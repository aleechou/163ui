-- $Id$

--[[INFOS
Guerrier	 WARRIOR	 1
Paladin	 PALADIN	 2
Chasseur	 HUNTER	 3
Voleur	 ROGUE	 4
Prêtre	 PRIEST	 5
Todesritter	 DEATHKNIGHT	 6
Schmane	 SHAMAN	 7
Magier	 MAGE	 8
Démoniste	 WARLOCK	 9
Moine	 MONK	 10
Druide	 DRUID	 11


0,0 == reset
EJ_SetLootFilter(CLASS_ID, specID)

local numLoot = EJ_GetNumLoot();
local name, icon, slot, armorType, itemID, link, encounterID = EJ_GetLootInfoByIndex(index);

local id, name, description, icon, background = GetSpecializationInfo(shownSpec, nil, self.isPet);
SetPortraitToTexture(scrollChild.specIcon, icon);
]]

local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local CLASS_ID = select(3, UnitClass("player"))

-- Contains infos about items
--[[ FORMAT
[itemId] = {
	CLASS_ID = {specId1, specId2, specId3}
}
]]
AtlasLoot_BonusRoll_Items = {}
setmetatable(AtlasLoot_BonusRoll_Items, {
	__newindex = function(t, k, v)
		if CLASS_ID then
			if v[CLASS_ID] then
				rawset(t, k, v[CLASS_ID])
			else
				rawset(t, k, false)
			end
		else
			rawset(t, k, v)
		end
		
	end
})

local BUTTON_LIST = {}

local PLAYER_CLASS_ID = nil
local PLAYER_SPEC_INFO = nil
local BonusRollEventIds = {}
local BonusRollDataIds = {}

local classTable = {
	[1] = {[71] = 1,[72] = 2,[73] = 3,},
	[2] = {[65] = 1,[66] = 2,[70] = 3,},
	[3] = {[253] = 1,[254] = 2,[255] = 3,},
	[4] = {[259] = 1,[260] = 2,[261] = 3,},
	[5] = {[256] = 1,[257] = 2,[258] = 3,},
	[6] = {[250] = 1,[251] = 2,[252] = 3,},
	[7] = {[262] = 1,[263] = 2,[264] = 3,},
	[8] = {[62] = 1,[63] = 2,[64] = 3,},
	[9] = {[265] = 1,[266] = 2,[267] = 3,},
	[10] = {[268] = 1,[270] = 2,[269] = 3,},
	[11] = {[102] = 1,[103] = 2,[104] = 3,[105] = 4,},
}

local function CreateSpecInfo()
	PLAYER_SPEC_INFO = {}
	for i=1,GetNumSpecializations() do
		local id, name, description, icon, background, role = GetSpecializationInfo(i)
		if PLAYER_CLASS_ID and classTable[PLAYER_CLASS_ID] and classTable[PLAYER_CLASS_ID][id] then
			PLAYER_SPEC_INFO[classTable[PLAYER_CLASS_ID][id]] = {
				name = name,
				description = description,
				icon = icon
			}
		end
	end
end

function AtlasLoot:BonusRoll_Initialize()
	PLAYER_CLASS_ID = select(3, UnitClass("player"))

	for instance,iniTab in pairs(AtlasLoot_LootTableRegister["Instances"]) do
		if iniTab and iniTab["Bosses"] then
			for k,v in ipairs(iniTab["Bosses"]) do
				if v and v.BonusLootID then
					if type(v.BonusLootID) == "number" then
						BonusRollEventIds[v.BonusLootID] = v[1]
					end
					BonusRollDataIds[v[1]] = true
				end
			end
		end
	end
	
	if AtlasLoot.ItemFrame then
		AtlasLoot.ItemFrame.BonusRoll = self:BonusRoll_CreateButton("BonusRoll", AtlasLoot.ItemFrame, true)
		AtlasLoot:ItemFrame_IconList_Refresh()
	end
	
	--[[ BonusRoll not workes here :/
	if AtlasLoot.CompareFrame then
		AtlasLoot.CompareFrame.BonusRoll = self:BonusRoll_CreateButton("AtlasLootCompareFrame_BonusRoll", AtlasLoot.CompareFrame)
		AtlasLoot.CompareFrame.BonusRoll:SetWidth(23)
		AtlasLoot.CompareFrame.BonusRoll:SetHeight(23)
		if AtlasLoot.CompareFrame.EncounterJournal the
			AtlasLoot.CompareFrame.BonusRoll:SetPoint("RIGHT", AtlasLoot.CompareFrame.EncounterJournal, "LEFT", 0, 0)
		else
			AtlasLoot.CompareFrame.BonusRoll:SetPoint("RIGHT", AtlasLoot.CompareFrame.Close2, "LEFT", -165, -1)
		end
	end	
	]]--
end

local function bonusRoll_OnClick(self)
	AtlasLoot.db.profile.BonusRollEnabled = not AtlasLoot.db.profile.BonusRollEnabled
	AtlasLoot:RefreshLootPage()
end

function AtlasLoot:BonusRoll_CreateButton(name, parent, addInList)
	local scripts = {
		["OnClick"] = bonusRoll_OnClick,
	}
	local texture = select(3, GetCurrencyInfo(697))
	local button = self:ItemFrame_IconList_CreateIcon(name, parent, texture, scripts, addInList)
	
	BUTTON_LIST[ #BUTTON_LIST + 1 ] = button
	
	return button
end

function AtlasLoot:BonusLoot_GetSpecInfo(id)
	if PLAYER_SPEC_INFO[id] then
		return PLAYER_SPEC_INFO[id].name, PLAYER_SPEC_INFO[id].description
	end
end

--- Checks a item if it available for the player class and specs
function AtlasLoot:BonusLoot_CheckItemId(itemId)
	if not itemId or type(itemId) ~= "number" or AtlasLoot_BonusRoll_Items[itemId] == nil then return end
	if AtlasLoot_BonusRoll_Items[itemId] == false or (not CLASS_ID and not AtlasLoot_BonusRoll_Items[itemId][PLAYER_CLASS_ID]) then return false end
	if not PLAYER_SPEC_INFO then CreateSpecInfo() end
	local ret = {}
	for k,v in ipairs(CLASS_ID and AtlasLoot_BonusRoll_Items[itemId] or AtlasLoot_BonusRoll_Items[itemId][PLAYER_CLASS_ID]) do
		if v and PLAYER_SPEC_INFO[k] then
			if not PLAYER_SPEC_INFO[k].icon then
				CreateSpecInfo()
			end
			table.insert(ret, { k, PLAYER_SPEC_INFO[k].icon })
		end
	end
	return #ret > 0 and ret or false
end

function AtlasLoot:BonusLoot_GetItemIdInfo(itemId)
	if not itemId or type(itemId) ~= "number" or AtlasLoot_BonusRoll_Items[itemId] == nil then return end
	if AtlasLoot_BonusRoll_Items[itemId] == false or (not CLASS_ID and not AtlasLoot_BonusRoll_Items[itemId][PLAYER_CLASS_ID]) then return false end
	if not PLAYER_SPEC_INFO then CreateSpecInfo() end
	local ret = {}
	for k,v in ipairs(CLASS_ID and AtlasLoot_BonusRoll_Items[itemId] or AtlasLoot_BonusRoll_Items[itemId][PLAYER_CLASS_ID]) do
		if v then
			if not PLAYER_SPEC_INFO[k].icon then
				CreateSpecInfo()
			end
			table.insert(ret, "|T"..PLAYER_SPEC_INFO[k].icon..":16|t")
		end
	end
	return #ret > 0 and ret or false
end

function AtlasLoot:BonusLoot_GetDataIdInfo(dataId)
	if dataId and BonusRollDataIds[dataId] then
		return true
	end
end