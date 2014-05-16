-- $Id: EJIntegration.lua 4201 2013-05-05 16:05:37Z lag123 $
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")

local EY_SUPPORT = { 
	["AtlasLootCataclysm"] = true 
}
-- ["Bosses"]
local BOSS_IDS = {}
local INSTANCE_IDS = {}

local BUTTON_LIST = {}

local function CopyTable(t)
	local new = {}
	local i, v = next(t, nil)
	while i do
		if type(v)=="table" then 
			v=CopyTable(v)
		end 
		new[i] = v
		i, v = next(t, i)
	end
	return new
end


local function createEncounterJournalIDList()
	for instance,iniTab in pairs(AtlasLoot_LootTableRegister["Instances"]) do
		if iniTab["Info"] and iniTab["Info"].EncounterJournalID then
			if not iniTab["Bosses"] then
				AtlasLoot:GetTableRegister(instance)
			end
			INSTANCE_IDS[ instance ] = iniTab["Info"].EncounterJournalID
			INSTANCE_IDS[ iniTab["Info"].EncounterJournalID ] = instance
			if iniTab["Bosses"] then
				for bossNum, bossTab in ipairs(iniTab["Bosses"]) do
					if bossTab.EncounterJournalID and type(bossTab.EncounterJournalID) == "table" then
						BOSS_IDS[ bossTab[1] ] = bossTab.EncounterJournalID[1]
						for k,v in ipairs(bossTab.EncounterJournalID) do
							BOSS_IDS[ v ] = { bossTab[1], iniTab["Info"].EncounterJournalID } -- dataID, iniID
						end
					elseif bossTab.EncounterJournalID then
						BOSS_IDS[ bossTab[1] ] = bossTab.EncounterJournalID 
						BOSS_IDS[ bossTab.EncounterJournalID ] = { bossTab[1], iniTab["Info"].EncounterJournalID } -- dataID, iniID
					end
				end
			end
		end
	end
end

local function encounterJournal_OnEnter(self)
	if self.info then
		local name, description 
		if self.info[2] then
			name, description = EJ_GetEncounterInfo(self.info[2])
		elseif self.info[1] then
			name, description = EJ_GetInstanceInfo(self.info[1])
		end	
		if name and description then
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(name)
			GameTooltip:AddLine("|cffFFFFFF"..description, nil, nil, nil, true)
			GameTooltip:Show()
		end
	end
end

local function encounterJournal_OnClick(self)
	if self.info then
		if not IsAddOnLoaded("Blizzard_EncounterJournal") then
			LoadAddOn("Blizzard_EncounterJournal")
		end
		EncounterJournal_ListInstances()
		if IsShiftKeyDown() then
			local link
			if self.info[2] then
				link = select(5, EJ_GetEncounterInfo(self.info[2]))
			elseif self.info[1] then
				link = select(7, EJ_GetInstanceInfo(self.info[1]))
			end			
			if link then
				ChatEdit_InsertLink(link)
			end
		else
			if self.info[1] then
				EncounterJournal_DisplayInstance(self.info[1])
			end
			if self.info[2] then
				EncounterJournal_DisplayEncounter(self.info[2])
			end
			if not EncounterJournal:IsShown() then
				EncounterJournal:Show()
			else
				EncounterJournal:Hide()
				EncounterJournal:Show()
			end
		end
	end
end

function AtlasLoot:EncounterJournal_CreateButton(name, parent, addInList)
	local scripts = {
		["OnClick"] = encounterJournal_OnClick,
		["OnEnter"] = encounterJournal_OnEnter,
		["OnLeave"] = function() GameTooltip:Hide() end,
	}
	local button = self:ItemFrame_IconList_CreateIcon(name, parent, "Interface\\EncounterJournal\\UI-EJ-PortraitIcon", scripts, addInList)
	
	BUTTON_LIST[ #BUTTON_LIST + 1 ] = button
	
	return button
end

function AtlasLoot:EncounterJournal_Initialize()
	createEncounterJournalIDList()
	if AtlasLoot.ItemFrame then
		AtlasLoot.ItemFrame.EncounterJournal = self:EncounterJournal_CreateButton("EncounterJournal", AtlasLoot.ItemFrame, true)
		AtlasLoot:ItemFrame_IconList_Refresh()
	end
	
	if AtlasLoot.CompareFrame then
		AtlasLoot.CompareFrame.EncounterJournal = self:EncounterJournal_CreateButton("AtlasLootCompareFrame_EncounterJournal", AtlasLoot.CompareFrame)
		AtlasLoot.CompareFrame.EncounterJournal:SetWidth(23)
		AtlasLoot.CompareFrame.EncounterJournal:SetHeight(23)
		AtlasLoot.CompareFrame.EncounterJournal:SetPoint("RIGHT", AtlasLoot.CompareFrame.Close2, "LEFT", -165, -1)
	end	
	

end

--- Get the boss name from the EncounterJournal or LibBabbleBoss
-- @param 	babbleBossName	<string>	LibBabbelBoss name
-- @param	encounterID		<number>	EncounterJournal Boss ID
function AtlasLoot:EJ_GetBossName(babbleBossName, encounterID)
	if encounterID and EJ_GetEncounterInfo(encounterID) then
		babbleBossName = EJ_GetEncounterInfo(encounterID)
	elseif babbleBossName and BabbleBoss[babbleBossName] then
		babbleBossName = BabbleBoss[babbleBossName]
	elseif not name then
		-- do nothing
	else
		babbleBossName = ""
	end
	return babbleBossName
end

local function refreshButtonInfo(info)
	if not info then return end
	if type(info) ~= "table" then
		if BOSS_IDS[ info ] then
			info = { BOSS_IDS[ BOSS_IDS[ info ] ][2], BOSS_IDS[ info ] }
		elseif INSTANCE_IDS[ info ] then
			info = { INSTANCE_IDS[ info ], nil }
		else
			info = nil
		end
	end
	return info
end

function AtlasLoot:EncounterJournal_ButtonsRefresh()
	for k,v in ipairs(BUTTON_LIST) do
		v.info = refreshButtonInfo( v.info )
		if v.info then
			v:Show()
		else
			v:Hide()
		end
	end
end