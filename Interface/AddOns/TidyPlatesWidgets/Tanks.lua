	
	
	
------------------------------
-- Target Tracker
------------------------------

local TrackedUnits = {}					-- Tracked Enemy Units
local TrackedUnitTargets = {}			-- Enemy Unit Targets
local TrackedUnitTargetHistory = {}		-- Previously determined Target (to determine if changes happened)
local TargetWatcher
local GetGroupInfo = TidyPlatesUtility.GetGroupInfo
local GetCombatEventResults = TidyPlatesUtility.GetCombatEventResults
local inRaid = false
local RecentDamageTime = {}
local RecentDamageTarget = {}

local function CombatLogWatcher(...)
	local timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destRaidFlag, auraType, spellid, spellname, stackCount = GetCombatEventResults(...)
	
	if combatevent == "SWING_DAMAGE" and (TrackedUnits[sourceGUID] == nil) then
		-- if the destination swing targets a group member, store the GUID and the Time in the Table
		local unitid = TidyPlatesUtility.GroupMembers.GUID[destGUID]
		if unitid then
			RecentDamageTime[sourceGUID] = GetTime()
			RecentDamageTarget[sourceGUID] = destGUID
			TidyPlates:Update()
		end		
	end
end

local function GetRecentDamageTarget(guid)
	local damageTime = RecentDamageTime[guid]
	if damageTime and GetTime() > ( damageTime + 5 ) then
		return RecentDamageTarget[guid]
	end
end

local function TargetWatcherEvents(frame, event, ...)
	if not UnitInRaid("player") then return end
	
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		CombatLogWatcher(...)
		return
	end
	
	local widget, plate
	local target, unitid, guid
	local changes = false
	local groupSize = tonumber(GetNumGroupMembers())
	TrackedUnits = wipe(TrackedUnits)
	
	-- Store target history
	for guid, target in pairs(TrackedUnitTargets) do
		TrackedUnitTargetHistory[guid] = target
		TrackedUnitTargets[guid] = nil
	end
	
	-- Reset the Tracking List
	for guid in pairs(TrackedUnits) do TrackedUnits[guid] = nil end
	
	-- Build a list of Trackable targets (via target, focus, and raid members)
	guid = UnitGUID("target")
	if guid then TrackedUnits[guid] = "target" end

	guid = UnitGUID("focus")
	if guid then TrackedUnits[guid] = "focus" end
	
	
	if groupSize then
		for index = 1, groupSize do
			unitid = "raid"..index.."target"
			guid = UnitGUID(unitid)
			if guid then TrackedUnits[guid] = unitid end
		end
		
		-- Build a list of the target's targets and check for changes
		for guid, unitid in pairs(TrackedUnits) do
			if unitid then 
				TrackedUnitTargets[guid] = UnitGUID(unitid.."target")
				if TrackedUnitTargets[guid] ~= TrackedUnitTargetHistory[guid] then changes = true end
			end
		end
	end
	
	if event == "PLAYER_REGEN_ENABLED" then
		wipe(RecentDamageTime)
	end
	
	-- Call for indicator Update, if needed
	if changes then 
		TidyPlates:Update()			-- To Do: Make a better update hook: either update specific GUIDs or update only indicators
	end
end


---------------
-- Tank Monitor
---------------
local TankNames = {}
local TankGUIDs = {}
local TankWatcher


--[[

	- Druid: Bear form					SpellID: 5487		-- UnitAura
	- Paladin: Righteous Fury			SpellID: 25780
	- Warrior: Defensive stance			SpellID: 71			-- GetShapeshiftFormID(), 18
	- Death Knight: Blood Presence		SpellID: 48263
	
	- Monk: 

--]]



local function IsTankedByAnotherTank(unit)
	local targetGUID
	if unit.guid then
		if unit.isTarget then targetGUID = UnitGUID("targettarget")				-- Nameplate is a target
		elseif unit.isMouseover then targetGUID = UnitGUID("mouseovertarget")		-- Nameplate is a mouseover
		else targetGUID = TrackedUnitTargets[unit.guid] or GetRecentDamageTarget(guid) end

		if targetGUID and TankGUIDs[targetGUID] then return true end
	end
	return false
end

local TankAuras = {
	["5487"] = true, 		-- Druid: Bear Form
	["25780"] = true, 		-- Paladin: Righteous Fury
	-- ["71"] = true, 
	["48263"] = true, 		-- DK: Blood
	["115069"] = true, 		-- Monk: Stance of the Sturdy Ox
}

local TankStances = {
	["18"] = true,			-- Warrior: Defensive Stance
	--["23"] = true,		-- Monk: Defensive Stance				
	--["5"] = true,			-- Druid: Bear Form
}

--TidyPlatesWidgets.IsTankingAuraActive = false

local function CheckPlayerAuras()
	local spellID, name, _
	local tankAura = false
	-- Check Auras
	for i = 1, 40 do
		name, _, _, _, _, _, _, _, _, _, spellID = UnitBuff("player", i)	-- 11th
		if TankAuras[tostring(spellID)] then 
			tankAura = true
		end
	end
	-- Check Stances
	if GetShapeshiftFormID() == 18 then -- Defensive Stance (Warrior)
		tankAura = true
	end
	
	if GetShapeshiftFormID() == 23 then -- Stance of the Sturdy Ox (Monk)
		tankAura = true
	end
	
	if TidyPlatesWidgets.IsTankingAuraActive ~= tankAura then
		TidyPlatesWidgets.IsTankingAuraActive = tankAura
		TidyPlates:RequestDelegateUpdate()
	end
end

local function TestPartAssignments()
			local party = "party1"
			
			local isAssigned = GetPartyAssignment("MAINTANK", party) or ("TANK" == UnitGroupRolesAssigned(party))
			
			if isAssigned then TankNames[UnitName(party)] = true 
			else TankNames[UnitName(party)] = nil end
end

local function CheckAssignments()
	
	if UnitInRaid("player") then
		local index
		inRaid = true
		local groupType, groupSize = GetGroupInfo()
		
		for index = 1, groupSize do
			local raidid = "raid"..tostring(index)
			
			if not UnitIsUnit("player", raidid) then		-- Skip over the Player
				local isAssigned = GetPartyAssignment("MAINTANK", raidid) or ("TANK" == UnitGroupRolesAssigned(raidid))
				
				if isAssigned then 
					TankNames[UnitName(raidid)] = true 
					TankGUIDs[UnitGUID(raidid)] = true
				else 
					TankNames[UnitName(raidid)] = nil 
					TankGUIDs[UnitGUID(raidid)] = nil
				end
			end
		end			
	else 
		inRaid = false
		TankNames = wipe(TankNames)
		TankGUIDs = wipe(TankGUIDs)
		if HasPetUI("player") and UnitName("pet") then 
			TankNames[UnitName("pet")] = true  			-- Adds your pet to the list (for you, only)
		end	
	end	
end

local function TankWatcherEvents(frame, event, ...)
	if event == "UNIT_AURA" or event == "UPDATE_SHAPESHIFT_FORM" then
		local unitid = ...
		if unitid == "player" then CheckPlayerAuras() end
		return
	end

	CheckAssignments()
	CheckPlayerAuras()
end
	

local function QueueUpdate()
	TankWatcher:SetScript("OnUpdate", TankWatcherEvents)
end

local function EnableTankWatch()
	-- Target-Of Watcher
	if not TargetWatcher then TargetWatcher = CreateFrame("Frame") end
	TargetWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
	TargetWatcher:RegisterEvent("PLAYER_REGEN_ENABLED")
	TargetWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")
	TargetWatcher:RegisterEvent("PLAYER_TARGET_CHANGED")
	TargetWatcher:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	TargetWatcher:RegisterEvent("UNIT_TARGET")
	TargetWatcher:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	TargetWatcher:SetScript("OnEvent", TargetWatcherEvents)
	TargetWatcherEvents()
	
	-- Party Tanks
	if not TankWatcher then TankWatcher = CreateFrame("Frame") end
	TankWatcher:RegisterEvent("GROUP_ROSTER_UPDATE")
	TankWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
	TankWatcher:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TankWatcher:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	TankWatcher:RegisterEvent("UNIT_AURA")
	TankWatcher:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	TankWatcher:SetScript("OnEvent", TankWatcherEvents)
	QueueUpdate()
end

local function DisableTankWatch() 
	-- Target-Of Watcher
	if TargetWatcher then
		TargetWatcher:SetScript("OnEvent", nil)
		TargetWatcher:UnregisterAllEvents()
		TargetWatcher = nil
	end
	
	-- Party Tanks
	if TankWatcher then
		TankWatcher:SetScript("OnEvent", nil)
		TankWatcher:UnregisterAllEvents()
		TankWatcher = nil
	end
end

TidyPlatesWidgets.EnableTankWatch = EnableTankWatch
TidyPlatesWidgets.DisableTankWatch = DisableTankWatch
TidyPlatesWidgets.IsTankedByAnotherTank = IsTankedByAnotherTank
--TidyPlatesWidgets.GetRecentDamageTarget = GetRecentDamageTarget

	
	