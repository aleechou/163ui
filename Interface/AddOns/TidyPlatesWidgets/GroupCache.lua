

--Group Roster Monitor
local RosterMonitor, UpdateRoster
local GetGroupInfo = TidyPlatesUtility.GetGroupInfo
local LastUpdate = 0

local Group = {}
Group.Names = {}
Group.Tanks = {}
Group.Class = {}
Group.Role = {}
Group.UnitId = {}
Group.GUID = {}
Group.Type = "solo"
Group.Size = 1


local function IsUnitTank(unitId)
	if GetPartyAssignment("MAINTANK", unitId) or ("TANK" == UnitGroupRolesAssigned(unitId)) then return true end
end

function UpdateRoster(frame, event, ...)
	if GetTime() < LastUpdate + 1 then return end		-- Avoid spamming

	-- Queue Update
	TidyPlates:Update()

	-- Clear Cache
	wipe(Group.Names)
	wipe(Group.Tanks)
	wipe(Group.Class)
	wipe(Group.Role)
	wipe(Group.UnitId)
	wipe(Group.GUID)

	-- Check Group Type
	local groupType, groupSize = GetGroupInfo()
	local foundUnknown = false

	-- Cycle through Group
	if groupType then
		local unitId, unitName

		for index = 1, groupSize do
			unitId = groupType..index

			if UnitRealmRelationship(unitId) == LE_REALM_RELATION_SAME then
				-- Local units
				unitName = UnitName(unitId)
			else
				-- Foreign units
				unitName = UnitName(unitId).." (*)"
			end

			if (not unitName) or (unitName == "Unknown") then
				foundUnknown = true
			end

			if unitName then
				Group.Names[unitId] = unitName
				Group.Class[unitName] = select(2,UnitClass(unitId))
				Group.Tanks[unitName] = IsUnitTank(unitId)
				Group.Role[unitName] = UnitGroupRolesAssigned(unitId)
				Group.UnitId[unitName] = unitId
				Group.GUID[UnitGUID(unitId)] = unitId
			end

		end

	end

	LastUpdate = GetTime()

	if foundUnknown then RosterMonitor:SetScript("OnUpdate", UpdateRoster)
	else RosterMonitor:SetScript("OnUpdate", nil) end
end

local function Enable()
	if not RosterMonitor then RosterMonitor = CreateFrame("Frame") end
	RosterMonitor:RegisterEvent("GROUP_ROSTER_UPDATE")
	RosterMonitor:RegisterEvent("RAID_ROSTER_UPDATE")
	RosterMonitor:RegisterEvent("PARTY_CONVERTED_TO_RAID")
	RosterMonitor:RegisterEvent("PLAYER_ENTERING_WORLD")
	RosterMonitor:SetScript("OnEvent", UpdateRoster)

	RosterMonitor:SetScript("OnUpdate", UpdateRoster)		-- Queues the update
end

local function Disable()
	if RosterMonitor then
		RosterMonitor:SetScript("OnEvent", nil)
		RosterMonitor:UnregisterAllEvents()
		RosterMonitor = nil

		wipe(Group.Names)
		wipe(Group.Tanks)
		wipe(Group.Class)
		wipe(Group.Role)
		wipe(Group.UnitId)

		Group.Type = nil
		Group.Size = nil
	end

	--print("RosterMonitor disabled")
end

TidyPlatesUtility.GroupMembers = Group
TidyPlatesUtility.EnableGroupWatcher = Enable
TidyPlatesUtility.DisableGroupWatcher = Disable
