


------------------------------
-- Target Tracker
------------------------------

local TrackedUnits = {}					-- Tracked Enemy Units (Returns UnitID)
local TrackedUnitTargetGUID = {}		-- Enemy Unit Targets (Returns GUID of the Unit's Targets)
local TrackedUnitTargetHistory = {}		-- Previously determined Target (to determine if changes happened)
local TargetWatcher
local GetGroupInfo = TidyPlatesUtility.GetGroupInfo
local GetCombatEventResults = TidyPlatesUtility.GetCombatEventResults
local inRaid = false
local RecentDamageTime = {}
local RecentDamageTarget = {}

local TANK_ROLE, DPS_ROLE = 2, 1

--[[
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
--]]


----------------------------------------
-- Tanks 2.0
----------------------------------------
local EnemyUnitsTargetGUID = {}
local EnemyUnitsHistoryGUID = {}
local EnemyUnitsTargetName = {}

local FriendlyUnitsUnitID = {}

local Debug = false

local function TargetWatcherEvents(frame, event, ...)

	--if not UnitInRaid("player") then return end

	--[[
		if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
			CombatLogWatcher(...)
			return
		end
	--]]

	--local widget, plate
	local target, unitid, guid
	FriendlyUnitsUnitID = wipe(FriendlyUnitsUnitID)

	-- Store target history
	for guid, target in pairs(EnemyUnitsTargetGUID) do
		EnemyUnitsHistoryGUID[guid] = target
		EnemyUnitsTargetGUID[guid] = nil
	end

	-- Reset the Tracking List
	for guid in pairs(FriendlyUnitsUnitID) do FriendlyUnitsUnitID[guid] = nil end

	-- Build a list of Trackable targets (via target, focus, and raid members)

	-- Add Target to Tracked Units List
	guid = UnitGUID("target")
	if guid then FriendlyUnitsUnitID[guid] = "target" end

	-- Add Focus to Tracked Units List
	guid = UnitGUID("focus")
	if guid then FriendlyUnitsUnitID[guid] = "focus" end

	-- Add Pets to Tracked Units List
	guid = UnitGUID("pet")
	if guid then FriendlyUnitsUnitID[guid] = "pet" end

	-- Add Raid Members
	local groupSize = tonumber(GetNumGroupMembers())
	for index = 1, groupSize do
		unitid = "raid"..index
		guid = UnitGUID(unitid)
		if guid then FriendlyUnitsUnitID[guid] = unitid end
	end


	-- Build a list of the target's targets and check for changes
	local changes = false

	for guid, unitid in pairs(FriendlyUnitsUnitID) do
		if unitid then

			local targetOfFriendly = unitid.."target"
			local targetOfEnemy = unitid.."targettarget"

			local enemyGUID = UnitGUID(targetOfFriendly)
			local targetGUID = UnitGUID(targetOfEnemy)

			if enemyGUID and targetGUID then
				EnemyUnitsTargetGUID[enemyGUID] = targetGUID

				if EnemyUnitsTargetGUID[enemyGUID] ~= EnemyUnitsHistoryGUID[enemyGUID] then changes = true end
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



	-- Suggested Change: If the unit is NOT attacking a non-tank, return false.  So, everything that is not a player character is OK to be attacked.
	-- Suggested Change: Create a new function, "AttackingSquishy(unit)"?
	-- Suggested Change:
	--[[
	FriendlyUnits
	FriendlyUnits = {}
		nil = Unknown
		1 = Healer/DPS
		2 = Tank
	--]]

--[[

	/run print(GetTotemInfo(1))
	= true Black Ox Statue 407749 900 Interface\Icons\monk_ability_summonoxstatue

--]]



---------------
-- Tank Monitor
---------------
local FriendlyUnitsRole = {}		-- Store the GUIDs of all active tanks
local TankWatcher

local function GetRecentDamageTarget(guid)
	local damageTime = RecentDamageTime[guid]
	if damageTime and GetTime() > ( damageTime + 5 ) then
		return RecentDamageTarget[guid]
	end
end

local function IsTankedByAnotherTank(unit)

	local targetGuid, targetName
	local guid = unit.guid

	if unit.isTarget then
		targetGuid = UnitGUID("targettarget")				-- Nameplate is a target
		--targetName = UnitName("targettarget")
	elseif unit.isMouseover then
		targetGuid = UnitGUID("mouseovertarget")		-- Nameplate is a mouseover
		--targetName = UnitName("mouseovertarget")
	elseif guid then

		targetGuid = EnemyUnitsTargetGUID[guid] -- or GetRecentDamageTarget(guid)	-- Nameplate is arbitrary (hopefully it's been moused during its life)
		--targetName = UnitName(
	end
	--print("IsTankedByAnotherTank", guid, targetGuid, FriendlyUnitsRole[targetGuid or 0], EnemyUnitsTargetGUID[guid])

	-- ie. If the evaluated unit's  target is equal to one of the tanks, then it's tanked
	if targetGuid and FriendlyUnitsRole[targetGuid] == TANK_ROLE then	-- If the mob is tanked by an actual tank...
		return true

	-- Experimental...
	elseif targetGuid and not FriendlyUnitsRole[targetGuid] then		-- If the mob is attacking something outside your group...
		return true
	end
end

--[[
	- Druid: Bear form					SpellID: 5487		-- UnitAura
	- Paladin: Righteous Fury			SpellID: 25780
	- Warrior: Defensive stance			SpellID: 71			-- GetShapeshiftFormID(), 18
	- Death Knight: Blood Presence		SpellID: 48263
	- Monk:
--]]

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

local function UpdatePlayerRole()
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


------------------------------------------------------------------------
-- UpdateGroupRoles: Builds a list of tanks and squishies
------------------------------------------------------------------------

local function UpdateGroupRoles()

	-- If a player is in a 5-man, no need for multi-tanking
	-- Only build this list if the player is in a Raid

	if UnitInRaid("player") then
		local index
		inRaid = true
		local groupType, groupSize = GetGroupInfo()

		for index = 1, groupSize do
			local raidid = "raid"..tostring(index)

			--if not UnitIsUnit("player", raidid) then		-- Skip over the Player
				local isTank = GetPartyAssignment("MAINTANK", raidid) or ("TANK" == UnitGroupRolesAssigned(raidid))

				if isTank then
					FriendlyUnitsRole[UnitGUID(raidid)] = TANK_ROLE		-- Tank = 2
				else
					FriendlyUnitsRole[UnitGUID(raidid)] = DPS_ROLE		-- DPS = 1
				end

			--end
		end

	-- If not in a raid, try to use guardian pet
	-- as a tank..
	else

		inRaid = false
		FriendlyUnitsRole = wipe(FriendlyUnitsRole)
		--print(UnitName("pet"), HasPetUI("player"))
		if HasPetUI("player") and UnitName("pet") then
			FriendlyUnitsRole[UnitGUID("pet")] = TANK_ROLE
			--print(UnitName("pet"), UnitGUID("pet"))
		end
	end

end



local function TankWatcherEvents(frame, event, ...)

	if event == "UNIT_AURA" or event == "UPDATE_SHAPESHIFT_FORM" then
		-- If the player auras change, check to see if they are still in tanking form
		local unitid = ...
		if unitid == "player" then UpdatePlayerRole() end
		return
	else
		-- Otherwise, check everyone...
		UpdateGroupRoles()
		UpdatePlayerRole()
	end
end


local function QueueUpdate()
	--TankWatcher:SetScript("OnUpdate", TankWatcherEvents)
end

local enabled = false

local function EnableTankWatch()

	if enabled then return end

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

--[[
    self:RegisterEvent("PLAYER_CONTROL_LOST");
    self:RegisterEvent("PLAYER_CONTROL_GAINED");
    self:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED");
    self:RegisterEvent("UNIT_PET");
    self:RegisterEvent("UNIT_FLAGS");
    self:RegisterEvent("PET_BAR_UPDATE");
    self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN");
    self:RegisterEvent("PET_BAR_SHOWGRID");
    self:RegisterEvent("PET_BAR_HIDEGRID");
    self:RegisterEvent("PET_BAR_HIDE");
    self:RegisterEvent("PET_BAR_UPDATE_USABLE");
    self:RegisterEvent("PET_UI_UPDATE");
    self:RegisterEvent("PLAYER_TARGET_CHANGED");
    self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR");
--]]
	-- Party Tanks
	if not TankWatcher then TankWatcher = CreateFrame("Frame") end
	TankWatcher:RegisterEvent("GROUP_ROSTER_UPDATE")
	TankWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
	TankWatcher:RegisterEvent("PARTY_MEMBERS_CHANGED")
	TankWatcher:RegisterEvent("UNIT_PET")
	TankWatcher:RegisterEvent("PET_BAR_UPDATE_USABLE")
	TankWatcher:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	TankWatcher:RegisterEvent("UNIT_AURA")
	TankWatcher:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	TankWatcher:SetScript("OnEvent", TankWatcherEvents)

	TankWatcherEvents()

	enabled = true
	--print("Tank Watch On")
end

local function DisableTankWatch()
	if enabled then
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

		enabled = false
	end

	--print("Tank Watch Off")
end

TidyPlatesWidgets.EnableTankWatch = EnableTankWatch
TidyPlatesWidgets.DisableTankWatch = DisableTankWatch
TidyPlatesWidgets.IsTankedByAnotherTank = IsTankedByAnotherTank
--TidyPlatesWidgets.GetRecentDamageTarget = GetRecentDamageTarget


