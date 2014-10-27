local AtlasLoot = _G.AtlasLoot
local EJ = {}
AtlasLoot.EncounterJournal = EJ
--local AL = AtlasLoot.Locales
local _
local tmp = nil

-- lua
local print = print
local wipe = table.wipe

-- WoW
local EJ_SelectInstance, EJ_SelectEncounter, EJ_SetDifficulty, EJ_SetLootFilter = EJ_SelectInstance, EJ_SelectEncounter, EJ_SetDifficulty, EJ_SetLootFilter
local EJ_GetEncounterInfo, EJ_GetLootInfoByIndex, EJ_GetNumLoot = EJ_GetEncounterInfo, EJ_GetLootInfoByIndex, EJ_GetNumLoot


function EJ:GetBossName(encounterID)
	if encounterID then
		tmp = EJ_GetEncounterInfo(encounterID)
	else
		return (ATLASLOOT_DEBUGMODE and "No encounter ID" or "")
	end
	if not encounterID and not ATLASLOOT_DEBUGMODE then
		tmp = nil
	elseif not encounterID and ATLASLOOT_DEBUGMODE then
		print("encounterID not found:"..encounterID)
		tmp = "encounterID not found:"..encounterID
	end
	return tmp
end

function EJ:GetBossInfo(encounterID)
	if encounterID then
		_, tmp = EJ_GetEncounterInfo(encounterID)
	else
		return (ATLASLOOT_DEBUGMODE and "No encounter ID" or "")
	end
	if not encounterID and not ATLASLOOT_DEBUGMODE then
		tmp = nil
	elseif not encounterID and ATLASLOOT_DEBUGMODE then
		print("encounterID not found:"..encounterID)
		tmp = "encounterID not found:"..encounterID
	end
	return tmp
end

-- ###############
-- Loot part
-- ###############
local eventFrame = CreateFrame("FRAME")
local itemList = {}
local currentQuery = {}

local function OnEvent(self, event, arg1)
	local classID, specID = EJ_GetLootFilter()
	if EJ_GetEncounterInfo(currentQuery[2][1]) ~= currentQuery[2][2] or EJ_GetDifficulty() ~= currentQuery[3] or EJ_GetCurrentTier() ~= currentQuery[4] or classID ~= currentQuery[5] or specID ~= currentQuery[6] then
		--print(EJ_GetCurrentInstance() ~= currentQuery[1], EJ_GetEncounterInfo(currentQuery[2][1]) ~= currentQuery[2][2], EJ_GetDifficulty() ~= currentQuery[3], EJ_GetCurrentTier() ~= currentQuery[4], classID ~= currentQuery[5], specID ~= currentQuery[6])
		EJ:ClearLootQuery()
		return
	end
	
	local _, itemID, link
	for i = 1, EJ_GetNumLoot() do
		_, _, _, _, itemID, link = EJ_GetLootInfoByIndex(i) --name, icon, slot, armorType, itemID, link, encounterID
		itemList[i] = { itemID, link }
		itemList[itemID] = i
	end
	self.OnUpdate(itemList)
end
eventFrame:SetScript("OnEvent", OnEvent)

function EJ:SetLootQuery(instanceID, encounterID, difficultyID, tier, classIDFilter, specIDFilter, OnUpdateFunc)
	if currentQuery[1] then EJ:ClearLootQuery() end
	if EncounterJournal then
		EncounterJournal:UnregisterEvent("EJ_DIFFICULTY_UPDATE")
	end
	eventFrame.OnUpdate = OnUpdateFunc
	eventFrame:RegisterEvent("EJ_LOOT_DATA_RECIEVED")
	EJ_SelectTier(tier)
	EJ_SetDifficulty(difficultyID)
	EJ_SelectInstance(instanceID)
	EJ_SelectEncounter(encounterID)
	currentQuery[1] = instanceID
	currentQuery[2] = { encounterID, EJ_GetEncounterInfo(encounterID) }
	currentQuery[3] = difficultyID
	currentQuery[4] = tier
	currentQuery[6] = specIDFilter or 0
	--currentQuery = { instanceID, EJ_GetEncounterInfo(encounterID), difficultyID, tier, classIDFilter, specIDFilter }
	--if not EJ_IsValidInstanceDifficulty(difficultyID) then
	--	print("ERROR UNKNOWN DIFFICULTY"..difficultyID)
	--end
	
	if not classIDFilter then
		_, _, classIDFilter = UnitClass("player")
	end
	currentQuery[5] = classIDFilter
	
	EJ_SetLootFilter(classIDFilter, specIDFilter or 0)

	local _, itemID, link
	for i = 1, EJ_GetNumLoot() do
		_, _, _, _, itemID, link = EJ_GetLootInfoByIndex(i) --name, icon, slot, armorType, itemID, link, encounterID
		itemList[i] = { itemID, link }
		itemList[itemID] = i
	end
	OnUpdateFunc(itemList)
	if EncounterJournal then
		EncounterJournal:RegisterEvent("EJ_DIFFICULTY_UPDATE")
	end
end

function EJ:ClearLootQuery()
	if not eventFrame.OnUpdate then return end
	eventFrame:UnregisterEvent("EJ_LOOT_DATA_RECIEVED")
	eventFrame.OnUpdate = nil
	wipe(itemList)
	wipe(currentQuery)
end