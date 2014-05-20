GlowFoSho = LibStub("AceAddon-3.0"):NewAddon("GlowFoSho", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("GlowFoSho")
local LD = LibStub("LibDropdown-1.0")

local currWeaponLink, currWeaponEnchant
GlowFoSho.eList = {}
local tbl = GlowFoSho.eList
-- local showGlowless = false
local showClassic = false
local showBurningCrusade = false
local showWotLK = false
local showCata = false
local showMop = true
local showRunes = false
local onlyCompatible = true
-- the button
local gfsbutton
-- the dropdown
local dropdownframe
local dropdownOptions

-- make enchant table local
local enchants = GlowFoSho_enchants

--[[

Local helper functions

--]]

-- returns information about the enchant when provided with enchantID
local function GetFormulaID(enchantID)
	if tonumber(enchantID) then
		for formulaID, enchant in pairs(enchants) do
			if enchant.enchantID == enchantID then
				return formulaID
			end
		end
		return
	end
end

-- creates a link for an enchanting recipe with formulaID and name
local function GetRecipeLink(formulaID)
	return "|cffffd000|Henchant:" .. formulaID .. "|h[" .. GetSpellInfo(formulaID) .. "]|h|r"
end

-- sets enchant for item link to enchantID
local function SetEnchant(link, enchantID)
	local link1, link2 = string.match(link,"(.*item:%d+:)%d+(.*)")
	if link1 and link2 then
		return link1 .. enchantID .. link2
	end
	
	return
end

-- returns the enchantID in the link
local function GetEnchant(link)
	return string.match(link,"item:%d+:(%d+)")
end

-- returns the list of enchants for dewdrop menu
local function UpdateEnchantList()
	-- if there is no weapon equipped, empty the list
	if not currWeaponLink then
		for k in pairs(tbl) do
			tbl[k] = nil
		end
		return
	end

	local weapMinlvl, _, _, _, is2H = select(5,GetItemInfo(currWeaponLink))
	local name
	is2H = (is2H == "INVTYPE_2HWEAPON")
	for formulaID, enchant in pairs(enchants) do
		-- all enchants have are glowing now
		-- if enchant.glowless and not showGlowless then
		-- 	tbl[formulaID] = nil
		-- else
		if enchant.classic and not showClassic then
			tbl[formulaID] = nil
		elseif enchant.burningcrusade and not showBurningCrusade then
			tbl[formulaID] = nil
		elseif enchant.wotlk and not showWotLK then
			tbl[formulaID] = nil
		elseif enchant.cata and not showCata then
			tbl[formulaID] = nil
		elseif enchant.mop and not showMop then
			tbl[formulaID] = nil
		elseif enchant.runes and not showRunes then
			tbl[formulaID] = nil
		-- remove incompatible enchants if those should not be shown
		elseif onlyCompatible and ((enchant.lvl and weapMinlvl < enchant.lvl) or (not is2H and enchant.is2H)) then
			tbl[formulaID] = nil
		else
			if enchant.is2H then
				name = enchant.name .. " (2H)"
			else
				name = enchant.name
			end
			tbl[formulaID] = L[name]
		end
	end
end

--[[

Main Addon Functions

--]]

function GlowFoSho:ChatCommand(msg)
	local cmd = self:GetArgs(msg)
	if cmd and string.lower(cmd)=="standby" then
		if gfsbutton:IsShown() then
			self:OnDisable()
			self:Print("|cffff0000" .. L["Suspended"] .. "|r")
		else
			self:OnEnable()
			self:Print("|cff00ff00" .. L["Active"] .. "|r")
		end
	else
		self:Print(L["standby"])
		self:Print(L["Enable/disable the addon"])
	end
end

function GlowFoSho:OnInitialize()
	--register chat commands
	self:RegisterChatCommand("glowfosho", "ChatCommand")
	self:RegisterChatCommand("gfs", "ChatCommand")
	
	-- set up GlowFoSho button on the dressup frame
	gfsbutton = CreateFrame("Button","GlowFoSho_Button",DressUpFrame)
	gfsbutton:SetPoint("TOPRIGHT","DressUpFrame","TOPRIGHT",-50,-80)
	-- to be compatible with CloseUp, otherwise does not receive clicks
	gfsbutton:SetFrameStrata("HIGH")
	gfsbutton:Hide()
	gfsbutton:SetWidth(25)
	gfsbutton:SetHeight(25)
	gfsbutton:SetNormalTexture("Interface\\Icons\\INV_Hammer_02")
	gfsbutton:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square","ADD")
	-- set up button click scripts
	gfsbutton:RegisterForClicks("LeftButtonUp","RightButtonUp")
	gfsbutton:SetScript("OnClick",function(self,button) if dropdownframe and dropdownframe:IsShown() then dropdownframe:Release() else GlowFoSho:OpenDropdown(self) end end)
	gfsbutton:SetScript("OnHide",function() dropdownframe = dropdownframe and dropdownframe:Release() end)
end

function GlowFoSho:OpenDropdown(buttonframe)
	dropdownOptions = {
		type = "group",
		args = {
			getWeaponLink = {
				name = L["Show Weapon Link"],
				desc = L["Displays the link of the enchanted weapon in the chat frame."],
				type = "execute",
				func = "GetWeaponLink",
				handler = self,
				order = 10
			},
			getFormulaLink = {
				name = L["Show Enchant Link"],
				desc = L["Displays the link of the enchant currently on the weapon in the chat frame."],
				type = "execute",
				func = "GetEnchantLink",
				handler = self,
				order = 20
			},
			classic = {
				name = L["Show Classic Enchants"],
				desc = L["Allows you to preview Classic enchants."],
				type = "toggle",
				get = function() return showClassic end,
				set = function(info, v) showClassic = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 31
			},
			burningcrusade = {
				name = L["Show BC Enchants"],
				desc = L["Allows you to preview BC enchants."],
				type = "toggle",
				get = function() return showBurningCrusade end,
				set = function(info, v) showBurningCrusade = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 32
			},
			wotlk = {
				name = L["Show WotLK Enchants"],
				desc = L["Allows you to preview WotLK enchants."],
				type = "toggle",
				get = function() return showWotLK end,
				set = function(info, v) showWotLK = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 33
			},
			cata = {
				name = L["Show Cata Enchants"],
				desc = L["Allows you to preview Cata enchants."],
				type = "toggle",
				get = function() return showCata end,
				set = function(info, v) showCata = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 34
			},
			mop = {
				name = L["Show Mop Enchants"],
				desc = L["Allows you to preview Mop enchants."],
				type = "toggle",
				get = function() return showMop end,
				set = function(info, v) showMop = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 35
			},
			runes = {
				name = L["Show DK Runes"],
				desc = L["Allows you to preview Runes which are created by DKs."],
				type = "toggle",
				get = function() return showRunes end,
				set = function(info, v) showRunes = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 36
			},
			compatible = {
				name = L["Show Only Compatible Enchants"],
				desc = L["Filters out enchants that cannot be applied to the currently previewed weapon."],
				type = "toggle",
				get = function() return onlyCompatible end,
				set = function(info, v) onlyCompatible = v; UpdateEnchantList(); self:OpenDropdown(buttonframe) end,
				order = 37
			},
			enchants = {
				name = L["Enchants"],
				desc = L["List of weapon enchants you can preview."],
				type = "select",
				get = function(info) return currWeaponEnchant end,
				set = function(info,v) self:EnchantWeaponByFormulaID(v) end,
				values = self.eList,
				disabled = function() return not next(self.eList) end,
				order = 40
			},
			clear = {
				name = L["Clear"],
				desc = L["Removes enchant from the weapon in the dressing room."],
				type = "execute",
				func = "ClearEnchant",
				handler = self,
				order = 50
			},
		}
	}
	dropdownframe = dropdownframe and dropdownframe:Release()
	dropdownframe = dropdownframe or LD:OpenAce3Menu(dropdownOptions)
	dropdownframe:SetClampedToScreen(true)
	dropdownframe:SetAlpha(1.0)
	dropdownframe:Show()
	local leftPos = buttonframe:GetLeft()
	local rightPos = buttonframe:GetRight()
	local side,oside
	rightPos = rightPos or 0
	leftPos = leftPos or 0
	local rightDist = GetScreenWidth() - rightPos
	if leftPos and rightDist < leftPos then
		side = "TOPLEFT"
		oside = "TOPRIGHT"
	else
		side = "TOPRIGHT"
		oside = "TOPLEFT"
	end
	dropdownframe:SetPoint(oside, buttonframe, side)
	
end

function GlowFoSho:OnEnable()
	-- show the button
	gfsbutton:Show()

	-- hook onto DressUp frame functions
	self:SecureHook("DressUpItemLink")
	self:HookScript(DressUpFrame,"OnShow","OnDressUpFrameShow")
	self:HookScript(DressUpFrameResetButton,"OnClick","OnDressUpFrameResetButtonClick")
	
	-- chat handler for enchanting over chat
	self:RegisterEvent("CHAT_MSG_WHISPER","ChatHandler")
	-- filter out addon messages
	self:SetMessageFilter(true)
end

function GlowFoSho:OnDisable()
	-- hide the button
	gfsbutton:Hide()
	-- unregister dewdrop
	dropdownframe = dropdownframe and dropdownframe:Release()
	-- unhook events
	self:UnhookAll()
	-- unregister events
	self:UnregisterAllEvents()
	self:SetMessageFilter(false)
end

-- hook to DressUpItemLink function
function GlowFoSho:DressUpItemLink(link)
	if link then
		local iType
		local _, link, _, _, _, iType = GetItemInfo(link)

		-- if previewing weapon, set the currWeaponLink link to passed link
		if iType == ENCHSLOT_WEAPON then
			currWeaponLink = link
		end
	end

	if not currWeaponLink then
		currWeaponLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
		currWeaponEnchant = nil
	end

	if currWeaponLink then
		currWeaponEnchant = GetFormulaID(GetEnchant(currWeaponLink))
	end
	UpdateEnchantList()
end

-- reset previous enchants when DressUp frame shows up
function GlowFoSho:OnDressUpFrameShow(...)
	currWeaponLink = nil
	currWeaponEnchant = nil
end

-- reset previous enchants when Reset button is pressed.
-- enchant is set to currently equiped weapon data
function GlowFoSho:OnDressUpFrameResetButtonClick(...)
	currWeaponLink = GetInventoryItemLink("player",GetInventorySlotInfo("MainHandSlot"))
	if currWeaponLink then
		currWeaponEnchant = GetFormulaID(GetEnchant(currWeaponLink))
	end
end

-- enchant and preview weapon
function GlowFoSho:EnchantWeaponByFormulaID(formulaID)
	if currWeaponLink and enchants[formulaID] then
		self:EnchantWeapon(enchants[formulaID].enchantID)
	end
end

-- enchant and preview weapon by enchantID
function GlowFoSho:EnchantWeapon(enchantID)
	if currWeaponLink then
		local newLink = SetEnchant(currWeaponLink,enchantID)
		if newLink then
			DressUpItemLink(newLink)
		end
	end
end

-- prints out link to the currently previewed weapon with a currently previewed enchant
function GlowFoSho:GetWeaponLink()
	if currWeaponLink then
		self:Print(currWeaponLink)
	end
end

-- prints out link to a formula for the current enchant on the weapon
function GlowFoSho:GetEnchantLink()
	local formulaID = self:GetCurrEnchant()
	if formulaID then
		self:Print(GetRecipeLink(formulaID))
	else
		self:Print(L["There is no enchant on the weapon or enchant unknown."])
	end
end

-- returns information about the enchant on currently preview weapon
function GlowFoSho:GetCurrEnchant()
	local enchant = enchants[currWeaponEnchant]
	if enchant then
		return currWeaponEnchant, enchant.name, enchant.enchantID, enchant.is2H, enchant.glowless, enchant.classic, enchant.burningcrusade, enchant.wotlk, enchant.runes
	end
end

-- removes enchant from item link and previews it in dressing room
function GlowFoSho:ClearEnchant()
	if currWeaponLink then
		currWeaponLink = SetEnchant(currWeaponLink,0)
		DressUpItemLink(currWeaponLink)
		DressUpItemLink(currWeaponLink)
	end
end

-- chat handler for enchanting over chat
function GlowFoSho:ChatHandler(event, msg, author)
	if not string.match(msg,"^" .. L["!glow"]) then
		return
	end
	
	if msg == L["!glow"] then
		SendChatMessage(L["glow>"] .. " " .. L["Syntax: !glow <weapon link> <enchant link>"],"WHISPER",nil,author)
		return
	end
	
	local weaponLink = string.match(msg,"|c%x+|Hitem:.-|h|r")
	if weaponLink and select(6,GetItemInfo(weaponLink)) == ENCHSLOT_WEAPON then
		local formulaID = string.match(msg,"Henchant:(%d+)")
		if formulaID then
			enchant = enchants[formulaID]
			if enchant then
				SendChatMessage(L["glow>"] .. " ".. SetEnchant(weaponLink,enchant.enchantID),"WHISPER",nil,author)
			else
				SendChatMessage(L["glow>"] .. " " .. L["Unknown enchant."],"WHISPER",nil,author)
			end
		else
			SendChatMessage(L["glow>"] .. " " .. L["No weapon enchant link specified."],"WHISPER",nil,author)
		end
	else
		SendChatMessage(L["glow>"] .. " " .. L["No weapon link specified."],"WHISPER",nil,author)
	end
end


local GlowFoShoIncomingFilter = function(chatframe, event, ...)
	local msg = ...
	if string.match(msg,"^" .. L["!glow"]) then
		return true
	else
		return false, ...
	end
end
local GlowFoShoOutgoingFilter = function(chatframe, event, ...)
	local msg = ...
	if string.match(msg,"^" .. L["glow>"]) then
		return true
	else
		return false, ...
	end
end
-- prevents addon messages from displaying in the chat window
function GlowFoSho:SetMessageFilter(enable)
	if enable then
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER",GlowFoShoIncomingFilter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM",GlowFoShoOutgoingFilter)
	else
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER",GlowFoShoIncomingFilter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM",GlowFoShoOutgoingFilter)
	end
end
