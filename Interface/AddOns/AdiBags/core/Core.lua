--[[
AdiBags - Adirelle's bag addon.
Copyright 2010-2012 Adirelle (adirelle@gmail.com)
All rights reserved.
--]]

local addonName, addon = ...
local L = addon.L

--<GLOBALS
local _G = _G
local ADDON_LOAD_FAILED = _G.ADDON_LOAD_FAILED
local BANK_CONTAINER = _G.BANK_CONTAINER
local CloseWindows = _G.CloseWindows
local CreateFrame = _G.CreateFrame
local format = _G.format
local GetCVarBool = _G.GetCVarBool
local geterrorhandler = _G.geterrorhandler
local InterfaceOptions_AddCategory = _G.InterfaceOptions_AddCategory
local LoadAddOn = _G.LoadAddOn
local next = _G.next
local NUM_BANKGENERIC_SLOTS = _G.NUM_BANKGENERIC_SLOTS
local pairs = _G.pairs
local pcall = _G.pcall
local print = _G.print
local strmatch = _G.strmatch
local strsplit = _G.strsplit
local type = _G.type
local unpack = _G.unpack
--GLOBALS>

LibStub('AceAddon-3.0'):NewAddon(addon, addonName, 'AceEvent-3.0', 'AceBucket-3.0', 'AceHook-3.0', 'AceConsole-3.0')
--[===[@debug@
_G[addonName] = addon
--@end-debug@]===]

--------------------------------------------------------------------------------
-- Debug stuff
--------------------------------------------------------------------------------

--[===[@alpha@
if AdiDebug then
	AdiDebug:Embed(addon, addonName)
else
--@end-alpha@]===]
	function addon.Debug() end
--[===[@alpha@
end
--@end-alpha@]===]

--[===[@debug@
local function DebugTable(t, prevKey)
	local k, v = next(t, prevKey)
	if k ~= nil then
		return k, v, DebugTable(t, k)
	end
end
--@end-debug@]===]

--------------------------------------------------------------------------------
-- Addon initialization and enabling
--------------------------------------------------------------------------------

addon:SetDefaultModuleState(false)

function addon:OnInitialize()
	local bfd = self:GetFontDefaults(GameFontHighlightLarge)
	bfd.r, bfd.g, bfd.b = 1, 1, 1
	self.DEFAULT_SETTINGS.profile.bagFont = bfd
	self.DEFAULT_SETTINGS.profile.sectionFont = self:GetFontDefaults(GameFontNormalLeft)

	self.db = LibStub('AceDB-3.0'):New(addonName.."DB", self.DEFAULT_SETTINGS, true)
	self.db.RegisterCallback(self, "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
	self.db.RegisterCallback(self, "OnProfileReset", "Reconfigure")

	self.bagFont = self:CreateFont(addonName.."BagFont", GameFontHighlightLarge, function() return self.db.profile.bagFont end)
	self.sectionFont = self:CreateFont(addonName.."SectionFont", GameFontNormalLeft, function() return self.db.profile.sectionFont end)

	self.itemParentFrames = {}

	self:InitializeFilters()
	self:CreateBagAnchor()

	self:SetEnabledState(false)

	-- Persistant handlers
	self.RegisterBucketMessage(addonName, 'AdiBags_ConfigChanged', 0.2, function(...) addon:ConfigChanged(...) end)
	self.RegisterEvent(addonName, 'PLAYER_ENTERING_WORLD', function() if self.db.profile.enabled then self:Enable() end end)

	self:UpgradeProfile()

	self:RegisterChatCommand("adibags", function(cmd)
		addon:OpenOptions(strsplit(' ', cmd or ""))
	end, true)

	self:Debug('Initialized')
end

function addon:OnEnable()

	self.globalLock = false

	self:RegisterEvent('BAG_UPDATE')
	self:RegisterBucketEvent('PLAYERBANKSLOTS_CHANGED', 0, 'BankUpdated')

	self:RegisterEvent('PLAYER_LEAVING_WORLD', 'Disable')

	self:RegisterMessage('AdiBags_BagOpened', 'LayoutBags')
	self:RegisterMessage('AdiBags_BagClosed', 'LayoutBags')

	self:RegisterEvent('CURRENT_SPELL_CAST_CHANGED')

	self:RawHook("OpenAllBags", true)
	self:RawHook("CloseAllBags", true)
	self:RawHook("ToggleAllBags", true)
	self:RawHook("ToggleBackpack", true)
	self:RawHook("ToggleBag", true)
	self:RawHook("OpenBackpack", true)
	self:RawHook("CloseBackpack", true)
	self:RawHook('CloseSpecialWindows', true)

	-- Track most windows involving items
	self:RegisterEvent('BANKFRAME_OPENED', 'UpdateInteractingWindow')
	self:RegisterEvent('BANKFRAME_CLOSED', 'UpdateInteractingWindow')
	self:RegisterEvent('MAIL_SHOW', 'UpdateInteractingWindow')
	self:RegisterEvent('MAIL_CLOSED', 'UpdateInteractingWindow')
	self:RegisterEvent('MERCHANT_SHOW', 'UpdateInteractingWindow')
	self:RegisterEvent('MERCHANT_CLOSED', 'UpdateInteractingWindow')
	self:RegisterEvent('AUCTION_HOUSE_SHOW', 'UpdateInteractingWindow')
	self:RegisterEvent('AUCTION_HOUSE_CLOSED', 'UpdateInteractingWindow')
	self:RegisterEvent('TRADE_SHOW', 'UpdateInteractingWindow')
	self:RegisterEvent('TRADE_CLOSED', 'UpdateInteractingWindow')
	self:RegisterEvent('GUILDBANKFRAME_OPENED', 'UpdateInteractingWindow')
	self:RegisterEvent('GUILDBANKFRAME_CLOSED', 'UpdateInteractingWindow')
	self:RegisterEvent('VOID_STORAGE_OPEN', 'UpdateInteractingWindow')
	self:RegisterEvent('VOID_STORAGE_CLOSE', 'UpdateInteractingWindow')
	self:RegisterEvent('FORGE_MASTER_OPENED', 'UpdateInteractingWindow')
	self:RegisterEvent('FORGE_MASTER_CLOSED', 'UpdateInteractingWindow')

	self:SetSortingOrder(self.db.profile.sortingOrder)

	for name, module in self:IterateModules() do
		if module.isFilter then
			module:SetEnabledState(self.db.profile.filters[module.moduleName])
		elseif module.isBag then
			module:SetEnabledState(self.db.profile.bags[module.bagName])
		else
			module:SetEnabledState(self.db.profile.modules[module.moduleName])
		end
	end

	self.bagFont:ApplySettings()
	self.sectionFont:ApplySettings()
	self:UpdatePositionMode()

	self:CURRENT_SPELL_CAST_CHANGED('OnEnable')

	self:Debug('Enabled')
end

function addon:OnDisable()
	self.anchor:Hide()
	self:CloseAllBags()
	self:Debug('Disabled')
end

function addon:Reconfigure()
	self.holdYourBreath = true -- prevent tons*$% of useless updates
	self:Disable()
	self:Enable()
	self.holdYourBreath = nil
	self:UpdateFilters()
end

function addon:OnProfileChanged()
	self:UpgradeProfile()
	return self:Reconfigure()
end

function addon:UpgradeProfile()
	local profile = self.db.profile

	-- Convert old ordering setting
	if profile.laxOrdering == true then
		profile.laxOrdering = 1
	end

	-- Convert old anchor settings
	local oldData = profile.anchor
	if oldData then
		local scale = oldData.scale or 0.8
		profile.scale = scale

		local newData = profile.positions.anchor
		newData.point = oldData.pointFrom or "BOTTOMRIGHT"
		newData.xOffset = (oldData.xOffset or -32) / scale
		newData.yOffset = (oldData.yOffset or 200) / scale

		profile.anchor = nil
	end

	-- Convert old "notWhenTrading" setting
	if profile.virtualStacks.notWhenTrading == true then
		profile.virtualStacks.notWhenTrading = 3
	end

	-- Convert old "rowWidth"
	if type(profile.rowWidth) == "number" then
		local rowWidth = profile.rowWidth
		profile.rowWidth = { Bank = rowWidth, Backpack = rowWidth }
	end

	-- Convert old "backgroundColors"
	if type(profile.backgroundColors) == "table" then
		profile.skin.BackpackColor = profile.backgroundColors.Backpack
		profile.skin.BankColor = profile.backgroundColors.Bank
		profile.backgroundColors = nil
	end
	
	-- Convert old font settings
	if type(profile.skin) == "table" then
		local skin = profile.skin
		if type(skin.font) == "string" then
			profile.bagFont.name = skin.font
			profile.sectionFont.name = skin.font
			skin.font = nil
		end
		if skin.fontSize then
			profile.bagFont.size = skin.fontSize
			profile.sectionFont.size = skin.fontSize - 4
			skin.fontSize = nil
		end
		if skin.fontBagColor then
			local bagFont = profile.bagFont
			bagFont.r, bagFont.g, bagFont.r = unpack(skin.fontBagColor)
			skin.fontBagColor = nil
		end
		if skin.fontSectionColor then
			local sectionFont = profile.sectionFont
			sectionFont.r, sectionFont.g, sectionFont.b = unpack(skin.fontSectionColor)
			skin.fontSectionColor = nil
		end
	end

end

--------------------------------------------------------------------------------
-- Error reporting
--------------------------------------------------------------------------------

local BugGrabber = addon.BugGrabber
if BugGrabber then
	if BugGrabber.setupCallbacks then
		BugGrabber.setupCallbacks()
	end
	local pattern = "("..addonName.."[^\n]+%.lua):%d+:"
	BugGrabber.RegisterCallback(addon, 'BugGrabber_BugGrabbed', function(_, errorObject)
		local ref = strmatch(errorObject.stack, pattern)
		if ref and not strmatch(ref, '\\libs\\') then
			if not addon.db.global.muteBugGrabber then
				print(format('|cffffff00'..L['Error in %s: %s -- details: %s'], addonName, '|r'..errorObject.message, BugGrabber:GetChatLink(errorObject)))
			end
			addon:Debug('Error:', errorObject.message)
		end
	end)
end

--------------------------------------------------------------------------------
-- Track spell targeting
--------------------------------------------------------------------------------

function addon:CURRENT_SPELL_CAST_CHANGED(event)
	local spellIsTargeting = SpellIsTargeting()
	if self.spellIsTargeting ~= spellIsTargeting then
		self.spellIsTargeting = spellIsTargeting
		self:SendMessage('AdiBags_SpellIsTargetingChanged', spellIsTargeting)
	end
end

--------------------------------------------------------------------------------
-- Option addon handling
--------------------------------------------------------------------------------

do
	local configAddonName = "AdiBags_Config"
	local why = '???'
	local function CouldNotLoad()
		print("|cffff0000AdiBags:", format(ADDON_LOAD_FAILED, configAddonName, why), "|r")
	end
	function addon:OpenOptions(...)
		self.OpenOptions = CouldNotLoad
		local loaded, reason = LoadAddOn(configAddonName)
		if not loaded then
			why = _G['ADDON_'..reason]
		end
		addon:OpenOptions(...)
	end
end

do
	-- Create the Blizzard addon option frame
	local panel = CreateFrame("Frame", addonName.."BlizzOptions")
	panel.name = addonName
	InterfaceOptions_AddCategory(panel)

	local fs = panel:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	fs:SetPoint("TOPLEFT", 10, -15)
	fs:SetPoint("BOTTOMRIGHT", panel, "TOPRIGHT", 10, -45)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	fs:SetText(addonName)

	local button = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
	button:SetText(L['Configure'])
	button:SetWidth(128)
	button:SetPoint("TOPLEFT", 10, -48)
	button:SetScript('OnClick', function()
		while CloseWindows() do end
		return addon:OpenOptions()
	end)

end

--------------------------------------------------------------------------------
-- Module prototype
--------------------------------------------------------------------------------

local moduleProto = {
	Debug = addon.Debug,
	OpenOptions = function(self)
		return addon:OpenOptions("modules", self.moduleName)
	end,
}
addon.moduleProto = moduleProto
addon:SetDefaultModulePrototype(moduleProto)

--------------------------------------------------------------------------------
-- Event handlers
--------------------------------------------------------------------------------

function addon:BAG_UPDATE(event, bag)
	self:SendMessage('AdiBags_BagUpdated', bag)
end

function addon:BankUpdated(slots)
	-- Wrap several PLAYERBANKSLOTS_CHANGED into one AdiBags_BagUpdated message
	for slot in pairs(slots) do
		if slot > 0 and slot <= NUM_BANKGENERIC_SLOTS then
			self:SendMessage('AdiBags_BagUpdated', BANK_CONTAINER)
			return
		end
	end
end

function addon:ConfigChanged(vars)
	--[===[@debug@
	self:Debug('ConfigChanged', DebugTable(vars))
	--@end-debug@]===]
	if vars.enabled then
		if self.db.profile.enabled then
			self:Enable()
		else
			self:Disable()
		end
		return
	elseif not self:IsEnabled() then
		return
	elseif vars.filter then
		return self:SendMessage('AdiBags_FiltersChanged')
	else
		for name in pairs(vars) do
			if strmatch(name, 'virtualStacks') then
				return self:SendMessage('AdiBags_FiltersChanged')
			elseif strmatch(name, 'bags%.') then
				local _, bagName = strsplit('.', name)
				local bag = self:GetModule(bagName)
				local enabled = self.db.profile.bags[bagName]
				if enabled and not bag:IsEnabled() then
					bag:Enable()
				elseif not enabled and bag:IsEnabled() then
					bag:Disable()
				end
			elseif strmatch(name, 'rowWidth') then
				return self:SendMessage('AdiBags_LayoutChanged')
			elseif strmatch(name, '^skin%.font') then
				return self:UpdateFonts()
			end
		end
	end
	if vars.sortingOrder then
		return self:SetSortingOrder(self.db.profile.sortingOrder)
	elseif vars.maxHeight or vars.maxWidth or vars.laxOrdering then
		return self:SendMessage('AdiBags_LayoutChanged')
	elseif vars.scale then
		return self:LayoutBags()
	elseif vars.positionMode then
		return self:UpdatePositionMode()
	else
		self:SendMessage('AdiBags_UpdateAllButtons')
	end
end

function addon:SetGlobalLock(locked)
	locked = not not locked
	if locked ~= self.globalLock then
		self.globalLock = locked
		self:SendMessage('AdiBags_GlobalLockChanged', locked)
		if not locked then
			self:SendMessage('AdiBags_LayoutChanged')
		end
		return true
	end
end

--------------------------------------------------------------------------------
-- Track windows related to item interaction (merchant, mail, bank, ...)
--------------------------------------------------------------------------------

do
	local current
	function addon:UpdateInteractingWindow(event, ...)
		local new = strmatch(event, '^([_%w]+)_OPEN') or strmatch(event, '^([_%w]+)_SHOW$')
		self:Debug('UpdateInteractingWindow', event, current, '=>', new, '|', ...)
		if new ~= current then
			local old = current
			current = new
			self.atBank = (current == "BANKFRAME")
			if self.db.profile.virtualStacks.notWhenTrading ~= 0 then
				self:SendMessage('AdiBags_FiltersChanged', true)
			end
			self:SendMessage('AdiBags_InteractingWindowChanged', new, old)
		end
	end

	function addon:GetInteractingWindow()
		return current
	end
end

--------------------------------------------------------------------------------
-- Virtual stacks
--------------------------------------------------------------------------------

function addon:ShouldStack(slotData)
	local conf = self.db.profile.virtualStacks
	if not slotData.link then
		return conf.freeSpace, "*Free*"
	end
	local window, unstack = self:GetInteractingWindow(), 0
	if window then
		unstack = conf.notWhenTrading
		if unstack >= 4 and window ~= "BANKFRAME" then
			return
		end
	end
	local maxStack = slotData.maxStack or 1
	if maxStack > 1 then
		if conf.stackable then
			if (slotData.count or 1) == maxStack then
				return true, slotData.itemId
			elseif unstack < 3 then
				return conf.incomplete, slotData.itemId
			end
		end
	elseif conf.others and unstack < 2 then
		return true, self.GetDistinctItemID(slotData.link)
	end
end

--------------------------------------------------------------------------------
-- Skin-related methods
--------------------------------------------------------------------------------

local LSM = LibStub('LibSharedMedia-3.0')

function addon:GetContainerSkin(containerName)
	local skin = self.db.profile.skin
	local r, g, b, a = unpack(skin[containerName..'Color'], 1, 4)
	local backdrop = addon.BACKDROP
	backdrop.bgFile = LSM:Fetch(LSM.MediaType.BACKGROUND, skin.background)
	backdrop.edgeFile = LSM:Fetch(LSM.MediaType.BORDER, skin.border)
	backdrop.edgeSize = skin.borderWidth
	backdrop.insets.left = skin.insets
	backdrop.insets.right = skin.insets
	backdrop.insets.top = skin.insets
	backdrop.insets.bottom = skin.insets
	return backdrop, r, g, b, a
end
