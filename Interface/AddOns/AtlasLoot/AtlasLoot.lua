local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales

-- lua
local assert, type = assert, type
local next = next

-- WoW
-- DisableAddOn

local EventFrame = CreateFrame("FRAME")
EventFrame:RegisterEvent("ADDON_LOADED")

local function EventFrame_OnEvent(frame, event, arg1, ...)
	if event == "ADDON_LOADED" and arg1 and AtlasLoot.Init[arg1] then
		AtlasLoot:OnInitialize()
		-- init all other things
		if AtlasLoot.Init then
			for i = 1, #AtlasLoot.Init[arg1] do
				local func = AtlasLoot.Init[arg1][i]
				if func and type(func) == "function" then
					func()
				end
			end
			AtlasLoot.Init[arg1] = nil
		end
		if not next(AtlasLoot.Init) then
			EventFrame:UnregisterEvent("ADDON_LOADED")
		end
	end
end
EventFrame:SetScript("OnEvent", EventFrame_OnEvent)

function AtlasLoot:Print(msg)
	print("|cff33ff99AtlasLoot|r: "..(msg or ""))
end

function AtlasLoot:OnInitialize()
	if not AtlasLootDB.__addonrevision or AtlasLootDB.__addonrevision < AtlasLoot.__addonrevision then
		wipe(AtlasLootDB)
		AtlasLootDB.__addonrevision = AtlasLoot.__addonrevision
	end
	self.db = LibStub("AceDB-3.0"):New("AtlasLootDB")
	self.db:RegisterDefaults(AtlasLoot.AtlasLootDBDefaults)
	self.chardb = LibStub("AceDB-3.0"):New("AtlasLootCharDB")
	self.chardb:RegisterDefaults(AtlasLoot.AtlasLootDBDefaults)
	
	
	
	-- bindings
	BINDING_HEADER_ATLASLOOT = AL["AtlasLoot"]
	BINDING_NAME_ATLASLOOT_TOGGLE = AL["Toggle AtlasLoot"]
	
	
	local _, _, _, _, reason = GetAddOnInfo("AtlasLoot_Loader")
	--[[if reason ~=  "MISSING" or then 
		DisableAddOn("AtlasLoot_Loader") 
		StaticPopupDialogs["ATLASLOOT_LOADER_ADDON_ERROR"] = {
			text = AL["AtlasLoot_Loader is no longer in use.\nDelete it from your AddOns folder"],
			button1 = OKAY,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
		StaticPopup_Show("ATLASLOOT_LOADER_ADDON_ERROR")
	end]]

	
	--[[ scan for pet IDs
	self.db.profile.PETINFO = {}
	local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName
	local numPets = C_PetJournal.GetNumPets()
	
	for i=1,numPets do
		petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName = C_PetJournal.GetPetInfoByIndex(i)
		if speciesName and speciesID then
			self.db.profile.PETINFO[speciesName] = speciesID
		end
	end
	]]--
	

	--self.db.profile.MOUNTINFO = {}
	--local numMounts = C_MountJournal.GetNumMounts()
	
	--for i=1,numMounts do
		--print(C_MountJournal.GetMountInfo(i))
		
		
	
		--petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName = C_PetJournal.GetPetInfoByIndex(i)
		--if speciesName and speciesID then
		--	self.db.profile.PETINFO[speciesName] = speciesID
		--end
	--end

	
	
	
end

function AtlasLoot:AddInitFunc(func, module)
	assert(type(func) == "function", "'func' must be a function.")
	if not EventFrame:IsEventRegistered("ADDON_LOADED") then
		EventFrame:RegisterEvent("ADDON_LOADED")
	end
	module = module or "AtlasLoot"
	if not AtlasLoot.Init[module] then AtlasLoot.Init[module] = {} end
	AtlasLoot.Init[module][#AtlasLoot.Init[module]+1] = func
end



--[[
local db 
local ORIGetItemInfo = GetItemInfo
function GetItemInfo(xxx)
	if not db then 
		if not AtlasLoot.db.profile.itemInfo then
			AtlasLoot.db.profile.itemInfo = {}
		end
		db = AtlasLoot.db.profile.itemInfo
	end
	local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, vendorPrice = ORIGetItemInfo(xxx)
	if itemSubType and itemType then
		if not db[itemType] then
			db[itemType] = {}
		end
		db[itemType][itemSubType] = true
	end
	if itemEquipLoc then
		if not db.slot then db.slot = {} end
		db[itemEquipLoc] = nil
		db.slot[itemEquipLoc] = true
	end
	return itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemCount, itemEquipLoc, itemTexture, vendorPrice
end
]]--

-- ################
-- DEV !!! remove later only for tests
-- ################
local GUIDS = {
	["Player-1097-040A43FC"] = "author",	-- shijera@ysera-eu
	["Player-1097-0444710C"] = "author",	-- lag@ysera-eu
	["Player-1097-00490D06"] = true,		-- meena@ysera-eu
	["Player-1097-0212CAC6"] = true,		-- xyriana@ysera-eu
	["Player-612-0566C578"] = "author",		-- Dynaletik@nerathor-eu
	["Player-612-05667280"] = "author",		-- Dynarix@nerathor-eu
	["Player-612-0566725A"] = "author",		-- Dynalowtik@nerathor-eu
}
local AUTHOR_STRING = "AtlasLoot Author |T"..AtlasLoot.IMAGE_PATH.."gold:0|t"
local FRIEND_STRING = "AtlasLoot Friend |T"..AtlasLoot.IMAGE_PATH.."silver:0|t"
function hookUnitTarget(self)
	local name, unit = self:GetUnit()
	if name and unit then
		local guid = UnitGUID(unit)
		if guid and GUIDS[guid] then
			self:AddLine(GUIDS[guid] == "author" and AUTHOR_STRING or FRIEND_STRING, 0, 1, 0 )
		end
	end
end
GameTooltip:HookScript("OnTooltipSetUnit", hookUnitTarget)
