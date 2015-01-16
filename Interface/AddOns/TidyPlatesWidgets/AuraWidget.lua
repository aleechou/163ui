
--[[
Things to do..

- Single Target Mode
UpdateWidgetContextTargetOnly
UpdateIconGrid
TargetOnlyEventHandler

- Raid-Target Only Mode

- More recycling of table entries

	The Prefilter should discard spells based on a general criteria

	Allowed spells
		- SpellID match
		- Debuffs (right now)
		- Target GUID

	Testing
	/wg emilye nagrand arena


	Arena UnitID support
		- Debuffs
		- Cast bars



	Idea: Store Recent non-target, non-focus, non-mouseover unitid via the Gameevent system
	Game events happen before combat log events





	When a debuff falls off, while marked as a raid-target (and cleared), the rest of the debuffs are cleared.
	When one debuff falls off, the whole shebang should get re-evaluated with the data table in-mind.





-- Widget Object Functions

--]]

TidyPlatesWidgets.DebuffWidgetBuild = 2

local PlayerGUID = UnitGUID("player")
local PolledHideIn = TidyPlatesWidgets.PolledHideIn
local FilterFunction = function() return 1 end
local AuraMonitor = CreateFrame("Frame")
local WatcherIsEnabled = false
local WidgetList, WidgetGUID = {}, {}
local UpdateWidget
local TargetOfGroupMembers = {}
local DebuffColumns = 3
local inArena = false

local GetCombatEventResults = TidyPlatesUtility.GetCombatEventResults

local function DefaultPreFilterFunction() return true end
local function DefaultFilterFunction(aura, unit) if aura and aura.duration and (aura.duration < 30) then return true end end

local AuraPrefilterFunction = DefaultPreFilterFunction
local AuraFilterFunction = DefaultFilterFunction
local AuraHookFunction

local AURA_TARGET_HOSTILE = 1
local AURA_TARGET_FRIENDLY = 2

local AURA_TYPE_BUFF = 1
local AURA_TYPE_DEBUFF = 6

local _

local AURA_TYPE = {
	["Buff"] = 1,
	["Curse"] = 2,
	["Disease"] = 3,
	["Magic"] = 4,
	["Poison"] = 5,
	["Debuff"] = 6,
}

local function SetFilter(func)
	if func and type(func) == "function" then
		FilterFunction = func
	end
end

local function GetAuraWidgetByGUID(guid)
	if guid then return WidgetGUID[guid] end
end

local function IsAuraShown(widget, aura)
		if widget and widget:IsShown() and widget.currentAuraCount ~= 0 then
		--if widget and widget.currentAuraCount ~= 0 then
			return true
			--[[
			for i = 1, 6 do
				if widget.AuraIconFrames[i] and widget.AuraIconFrames[i]:IsShown() then return true end
			end
			--]]
		end
end

local RaidIconBit = {
		["STAR"] = 0x00000001,
		["CIRCLE"] = 0x00000002,
		["DIAMOND"] = 0x00000004,
		["TRIANGLE"] = 0x00000008,
		["MOON"] = 0x00000010,
		["SQUARE"] = 0x00000020,
		["CROSS"] = 0x00000040,
		["SKULL"] = 0x00000080,
	}


local RaidIconIndex = {
	"STAR",
	"CIRCLE",
	"DIAMOND",
	"TRIANGLE",
	"MOON",
	"SQUARE",
	"CROSS",
	"SKULL",
}

local ByRaidIcon = {}			-- Raid Icon to GUID 		-- ex.  ByRaidIcon["SKULL"] = GUID
local ByName = {}				-- Name to GUID (PVP)

local PlayerDispelCapabilities = {
	["Curse"] = false,
	["Disease"] = false,
	["Magic"] = false,
	["Poison"] = false,
}

--[[
local DispelTypes = {
	["Curse"] = function()
		if IsSpellKnown(51886) then return true end									-- Cleanse Spirit, Shaman
		if IsSpellKnown(475) then return true end									-- Remove Curse, Mage
		if IsSpellKnown(2782) then return true end									-- Remove Corruption, Druid
	end,
	["Poison"] = function()
		if IsSpellKnown(2782) then return true end									-- Remove Corruption, Druid
		if IsSpellKnown(32375) then return true end									-- Mass Dispel, Priest
		if IsSpellKnown(527) and IsSpellKnown(33167) then return true end			-- Dispel Magic, Priest, Requires Absolution, 33167
		if IsSpellKnown(4987) then return true end									-- Cleanse, Paladin
	end,
	["Magic"] = function()
		if IsSpellKnown(4987) and IsSpellKnown(53551) then return true end			-- Cleanse, Paladin, Requires Sacred Cleansing, 53551
		if IsSpellKnown(2782) and IsSpellKnown(88423) then return true end			-- Remove Corruption, Druid, Requires Nature's Cure, 88423
		if IsSpellKnown(527) and IsSpellKnown(33167) then return true end			-- Dispel Magic, Priest, Requires Absolution, 33167
		if IsSpellKnown(32375) then return true end									-- Mass Dispel, Priest
		if IsSpellKnown(51886) and IsSpellKnown(77130) then return true end			-- Cleanse Spirit, Shaman, Requires Improved Cleanse Spirit, 77130
	end,
	["Disease"] = function()
		if IsSpellKnown(4987) then return true end									-- Cleanse, Paladin
		if IsSpellKnown(528) then return true end									-- Cure Disease, Shaman
	end,
}
--]]

local function UpdatePlayerDispelTypes()
	PlayerDispelCapabilities["Curse"] = IsSpellKnown(51886) or IsSpellKnown(475) or IsSpellKnown(2782)
	PlayerDispelCapabilities["Poison"] = IsSpellKnown(2782) or IsSpellKnown(32375) or IsSpellKnown(4987) or (IsSpellKnown(527) and IsSpellKnown(33167))
	PlayerDispelCapabilities["Magic"] = (IsSpellKnown(4987) and IsSpellKnown(53551)) or (IsSpellKnown(2782) and IsSpellKnown(88423)) or (IsSpellKnown(527) and IsSpellKnown(33167)) or (IsSpellKnown(51886) and IsSpellKnown(77130)) or IsSpellKnown(32375)
	PlayerDispelCapabilities["Disease"] = IsSpellKnown(4987) or IsSpellKnown(528)
end

local function CanPlayerDispel(debuffType)
	return PlayerDispelCapabilities[debuffType or ""]
end


-----------------------------------------------------
-- Default Filter
-----------------------------------------------------
local function DefaultFilterFunction(debuff)
	if (debuff.duration < 600) then
		return true
	end
end

-----------------------------------------------------
-- Update Via Search
-----------------------------------------------------

local function FindWidgetByGUID(guid)
	if guid == nil then return end
	return WidgetGUID[guid]
end

local function FindWidgetByName(SearchFor)
	if SearchFor == nil then return end
	local SearchForForeign = SearchFor..FOREIGN_SERVER_LABEL

	local widget
	--local SearchFor = strsplit("-", NameString)
	for widget in pairs(WidgetList) do
		--if widget.unit.name == SearchFor then
		if widget.unit.rawName == SearchFor  then
			return widget
		-- Try this alternative...
		elseif widget.unit.name == SearchForForeign then
			return widget
		end
	end
end

local function FindWidgetByIcon(raidicon)
	if raidicon == nil then return end
	local widget
	for widget in pairs(WidgetList) do
		if widget.unit.isMarked and widget.unit.raidIcon == raidicon then return widget end
	end
end

local function CallForWidgetUpdate(guid, raidicon, name)
	local widget

	widget = FindWidgetByGUID(guid) or FindWidgetByName(name) or FindWidgetByIcon(raidicon)

	if widget then UpdateWidget(FindWidgetByGUID(guid) or FindWidgetByName(name) or FindWidgetByIcon(raidicon)) end
end


-----------------------------------------------------
-- Aura Durations
-----------------------------------------------------
TidyPlatesWidgetData.CachedAuraDurations = {}

local function GetSpellDuration(spellid)
	if spellid then return TidyPlatesWidgetData.CachedAuraDurations[spellid] end
end

local function SetSpellDuration(spellid, duration)
	if spellid then TidyPlatesWidgetData.CachedAuraDurations[spellid] = duration end
end

-----------------------------------------------------
-- Aura Instances
-----------------------------------------------------

-- New Style
local Aura_List = {}	-- Two Dimensional
local Aura_Spellid = {}
local Aura_Spellname = {}
local Aura_Expiration = {}
local Aura_Stacks = {}
local Aura_Caster = {}
local Aura_Duration = {}
local Aura_Texture = {}
local Aura_Type = {}
local Aura_Target = {}

local function SetAuraInstance(guid, spellid, spellname, expiration, stacks, caster, duration, texture, auratype, auratarget)
	--if guid and spellid and caster and texture then
	if guid and spellid and texture then
		if AuraPrefilterFunction(spellid, spellname, auratype, auratarget) ~= true then return end

		--if auratarget == AURA_TARGET_FRIENDLY and auratype > 1 then print("Aura Approved", auratype) end

		local aura_id = spellid..(tostring(caster or "UNKNOWN_CASTER"))
		local aura_instance_id = guid..aura_id
		Aura_List[guid] = Aura_List[guid] or {}
		Aura_List[guid][aura_id] = aura_instance_id
		Aura_Spellid[aura_instance_id] = spellid
		Aura_Spellname[aura_instance_id] = spellname
		Aura_Expiration[aura_instance_id] = expiration
		Aura_Stacks[aura_instance_id] = stacks
		Aura_Caster[aura_instance_id] = caster
		Aura_Duration[aura_instance_id] = duration
		Aura_Texture[aura_instance_id] = texture
		Aura_Type[aura_instance_id] = auratype
		Aura_Target[aura_instance_id] = auratarget

	end
end

local function GetAuraInstance(guid, aura_id)
	if guid and aura_id then
		local aura_instance_id = guid..aura_id
		local spellid, spellname, expiration, stacks, caster, duration, texture, auratype, auratarget
		spellid = Aura_Spellid[aura_instance_id]
		spellname = Aura_Spellname[aura_instance_id]
		expiration = Aura_Expiration[aura_instance_id]
		stacks = Aura_Stacks[aura_instance_id]
		caster = Aura_Caster[aura_instance_id]
		duration = Aura_Duration[aura_instance_id]
		texture = Aura_Texture[aura_instance_id]
		auratype  = Aura_Type[aura_instance_id]
		auratarget  = Aura_Target[aura_instance_id]
		return spellid, spellname, expiration, stacks, caster, duration, texture, auratype, auratarget
	end
end

local function WipeUnitAuraList(guid)
	if guid and Aura_List[guid] then
		local unit_aura_list = Aura_List[guid]
		for aura_id, aura_instance_id in pairs(unit_aura_list) do
			Aura_Spellid[aura_instance_id] = nil
			Aura_Spellname[aura_instance_id] = nil
			Aura_Expiration[aura_instance_id] = nil
			Aura_Stacks[aura_instance_id] = nil
			Aura_Caster[aura_instance_id] = nil
			Aura_Duration[aura_instance_id] = nil
			Aura_Texture[aura_instance_id] = nil
			Aura_Type[aura_instance_id] = nil
			Aura_Target[aura_instance_id] = nil
			unit_aura_list[aura_id] = nil
		end
	end
end

local function GetAuraList(guid)
	if guid and Aura_List[guid] then return Aura_List[guid] end
end

local function RemoveAuraInstance(guid, spellid, caster)
	if guid and spellid and Aura_List[guid] then
		local aura_instance_id = tostring(guid)..tostring(spellid)..(tostring(caster or "UNKNOWN_CASTER"))
		local aura_id = spellid..(tostring(caster or "UNKNOWN_CASTER"))
		if Aura_List[guid][aura_id] then
			Aura_Spellid[aura_instance_id] = nil
			Aura_Spellname[aura_instance_id] = nil
			Aura_Expiration[aura_instance_id] = nil
			Aura_Stacks[aura_instance_id] = nil
			Aura_Caster[aura_instance_id] = nil
			Aura_Duration[aura_instance_id] = nil
			Aura_Texture[aura_instance_id] = nil
			Aura_Type[aura_instance_id] = nil
			Aura_Target[aura_instance_id] = nil
			Aura_List[guid][aura_id] = nil
		end
	end
end

local function CleanAuraLists()			-- Removes expired auras from the lists
	local currentTime = GetTime()
	for guid, instance_list in pairs(Aura_List) do
		local auracount = 0
		for aura_id, aura_instance_id in pairs(instance_list) do
			local expiration = Aura_Expiration[aura_instance_id]
			if expiration and expiration < currentTime then

				Aura_List[guid][aura_id] = nil
				Aura_Spellid[aura_instance_id] = nil
				Aura_Spellname[aura_instance_id] = nil
				Aura_Expiration[aura_instance_id] = nil
				Aura_Stacks[aura_instance_id] = nil
				Aura_Caster[aura_instance_id] = nil
				Aura_Duration[aura_instance_id] = nil
				Aura_Texture[aura_instance_id] = nil
				Aura_Type[aura_instance_id] = nil
				Aura_Target[aura_instance_id] = nil
			else
				auracount = auracount + 1
			end
		end
		if auracount == 0 then
			Aura_List[guid] = nil
		end
	end
end

-----------------------------------------------------
-- Aura Updating Via UnitID (Via UnitDebuff API function and UNIT_AURA events)
-----------------------------------------------------

local function UpdateAurasByUnitID(unitid)
		local unitType
		if UnitIsFriend("player", unitid) then unitType = AURA_TARGET_FRIENDLY else unitType = AURA_TARGET_HOSTILE end
		--if unitType == AURA_TARGET_FRIENDLY then return end		-- If the unit is hostile, quit.  Right now.

		-- Check the UnitIDs Debuffs
		local index
		local guid = UnitGUID(unitid)

		-- Reset Auras for a guid
		WipeUnitAuraList(guid)
		-- Debuffs
		for index = 1, 40 do
			local spellname , _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid, _, isBossDebuff = UnitDebuff(unitid, index)
			if not spellname then break end
			SetSpellDuration(spellid, duration)			-- Caches the aura data for times when the duration cannot be determined (ie. via combat log)

			--if dispelType and unitType == AURA_TARGET_FRIENDLY then print(spellname, unitCaster, dispelType, UnitName(unitid), guid, spellid, texture) end		-- DEBUG

			SetAuraInstance(guid, spellid, spellname, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE[dispelType or "Debuff"], unitType)
		end

		-- Buffs (Only for friendly units)

		--if unitType == AURA_TARGET_FRIENDLY then
			for index = 1, 40 do
				local spellname , _, texture, count, dispelType, duration, expirationTime, unitCaster, _, _, spellid, _, isBossDebuff = UnitBuff(unitid, index)
				if not spellname then break end
				SetSpellDuration(spellid, duration)			-- Caches the aura data for times when the duration cannot be determined (ie. via combat log)
				SetAuraInstance(guid, spellid, spellname, expirationTime, count, UnitGUID(unitCaster or ""), duration, texture, AURA_TYPE_BUFF, AURA_TARGET_FRIENDLY)
			end
		--end



		local raidicon, name
		if UnitPlayerControlled(unitid) then
			name = UnitName(unitid)
			ByName[name] = guid
		end
		raidicon = RaidIconIndex[GetRaidTargetIndex(unitid) or ""]
		if raidicon then ByRaidIcon[raidicon] = guid end

		CallForWidgetUpdate(guid, raidicon, name)
 end

 --[[
local LocalUnitLookup = {}
local LocalUnitIdList = {}

do 		-- Populate Unit ID List
	LocalUnitIdList["target"] = true
	LocalUnitIdList["focus"] = true
	LocalUnitIdList["mouseover"] = true

	for i = 1, 4 do
		LocalUnitIdList["boss"..i] = true
		LocalUnitIdList["party"..i] = true
	end

	for i = 1, 5 do
		LocalUnitIdList["arena"..i] = true
	end

	for i = 1, 40 do
		LocalUnitIdList["raid"..i] = true
	end
end
--]]



-----------------------------------------------------
-- Aura Updating Via Combat Log
-- local sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellName, spellSchool, auraType, stackCount = ...
-----------------------------------------------------

local function CombatLog_ApplyAura(...)
	local timestamp, sourceGUID, destGUID, destName, spellid, spellname, stackCount, auraType = ...
	local duration = GetSpellDuration(spellid)
	local texture = GetSpellTexture(spellid)

	local convertedAuraType = 6
	if auraType == "BUFF" then convertedAuraType = 1 end

	SetAuraInstance(destGUID, spellid, spellname, GetTime() + (duration or 0), 1, sourceGUID, duration, texture, convertedAuraType, AURA_TARGET_HOSTILE)

end

local function CombatLog_RemoveAura(...)
	local timestamp, sourceGUID, destGUID, destName, spellid = ...

	RemoveAuraInstance(destGUID, spellid, sourceGUID)
end

local function CombatLog_UpdateAuraStacks(...)
	local timestamp, sourceGUID, destGUID, destName, spellid, spellname, stackCount = ...
	local duration = GetSpellDuration(spellid)
	local texture = GetSpellTexture(spellid)
	SetAuraInstance(destGUID, spellid, spellname, GetTime() + (duration or 0), stackCount, sourceGUID, duration, texture, AURA_TYPE_DEBUFF, AURA_TARGET_HOSTILE)
end



-----------------------------------------------------
-- General Events
-----------------------------------------------------


--[[
local function EventUnitTarget()
	TargetOfGroupMembers = wipe(TargetOfGroupMembers)

	for name, unitid in pairs(TidyPlatesUtility.GroupMembers.UnitId) do
		local targetOf = unitid..("target" or "")
		if UnitExists(targetOf) then
			TargetOfGroupMembers[UnitGUID(targetOf)] = targetOf
		end
	end
end
--]]

--[[
local function EventPlayerTarget()
	-- if UnitExists("target") then UpdateAurasByUnitID("target") end
	local guid = UnitGUID("target")
	if guid then LocalUnitLookup[guid] = "target" end
end
--]]

local function EventUnitAura(unitid)
	if inArena or unitid == "target" or unitid == "target" or unitid == "focus" then
		UpdateAurasByUnitID(unitid)
	-- [[
	-- Personal Aura Tracker
	elseif unitid == "player" then
		UpdateAurasByUnitID("target")
	--]]
	end
end

local function EventPlayerEnterWorld()
	CleanAuraLists()
	local isInstance, instanceType = IsInInstance()
	--[[
		instanceType...
		arena - Player versus player arena
		none - Not inside an instance
		party - 5-man instance
		pvp - Player versus player battleground
		raid - Raid instance
	--]]
	if instanceType and instanceType == "arena" then
		inArena = true
	else
		inArena = false
	end
end

local function EventPlayerAbilityUpdated(...)
	UpdateAurasByUnitID("target")

	-- Personal Ability Reminder
	-- SPELL_UPDATE_USABLE
	--GetSpellCooldown()
	--usable, nomana = IsUsableSpell("spellName" or spellID or spellIndex[, "bookType"]);

	--[[
	"SPELL_COOLDOWN_READY",
	"SPELL_COOLDOWN_CHANGED",
	"SPELL_COOLDOWN_STARTED",
	"SPELL_UPDATE_USABLE",
	"PLAYER_TARGET_CHANGED",
	"UNIT_POWER",
	"RUNE_POWER_UPDATE",
	"RUNE_TYPE_UPDATE"
	--]]
end

--[[
local function EventLocalUnitUpdate()
	local unitid, guid
	LocalUnitLookup = wipe(LocalUnitLookup)

	-- Party
	for i = 1, 5 do
		unitid = "party"..i
		guid = UnitGUID(unitid)
		if guid then LocalUnitLookup[guid] = unitid end
	end

	-- Arena Opponent
	for i = 1, 5 do
		unitid = "arena"..i
		guid = UnitGUID(unitid)
		if guid then LocalUnitLookup[guid] = unitid end
	end

	-- Raid
	for i = 1, 40 do
		unitid = "raid"..i
		guid = UnitGUID(unitid)
		if guid then LocalUnitLookup[guid] = unitid end
	end


	--RAID_ROSTER_UPDATE
	--PARTY_MEMBERS_CHANGED
	--ARENA_OPPONENT_UPDATE
	--ARENA_TEAM_UPDATE

end
--]]

-----------------------------------------------------
-- Function Reference Lists
-----------------------------------------------------
local CombatLogEvents = {
	-- Refresh Expire Time
	["SPELL_AURA_APPLIED"] = CombatLog_ApplyAura,
	["SPELL_AURA_REFRESH"] = CombatLog_ApplyAura,
	-- Add a stack
	["SPELL_AURA_APPLIED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Remove a stack
	["SPELL_AURA_REMOVED_DOSE"] = CombatLog_UpdateAuraStacks,
	-- Expires Aura
	["SPELL_AURA_BROKEN"] = CombatLog_RemoveAura,
	["SPELL_AURA_BROKEN_SPELL"] = CombatLog_RemoveAura,
	["SPELL_AURA_REMOVED"] = CombatLog_RemoveAura,
}

local GeneralEvents = {
	--["UNIT_TARGET"] = EventUnitTarget,
	["UNIT_AURA"] = EventUnitAura,
	["PLAYER_ENTERING_WORLD"] = EventPlayerEnterWorld,
	["PLAYER_REGEN_ENABLED"] = CleanAuraLists,

	["SPELL_UPDATE_USABLE"] = EventPlayerAbilityUpdated,
	["SPELL_UPDATE_COOLDOWN"] = EventPlayerAbilityUpdated,
	["SPELL_COOLDOWN_READY"] = EventPlayerAbilityUpdated,
	["SPELL_COOLDOWN_STARTED"] = EventPlayerAbilityUpdated,

	--["ACTIONBAR_UPDATE_USABLE"] = EventPlayerAbilityUpdated,

	--["PLAYER_TALENT_UPDATE"] = UpdatePlayerDispelTypes,
	--["ACTIVE_TALENT_GROUP_CHANGED"] = UpdatePlayerDispelTypes,

	--["RAID_ROSTER_UPDATE"] = EventLocalUnitUpdate,
	--["PARTY_MEMBERS_CHANGED"] = EventLocalUnitUpdate,
	--["ARENA_OPPONENT_UPDATE"] = EventLocalUnitUpdate,
	--["ARENA_TEAM_UPDATE"] = EventLocalUnitUpdate,
	--["PLAYER_TARGET"] = EventPlayerTarget,
}

local function TargetOnlyEventHandler(frame, event, unitid)
	if unitid == "target" then
		UpdateAurasByUnitID("target")
	end
end

local function GuidIsLocalUnitId(guid)
	if guid == UnitGUID("player") or guid == UnitGUID("target") or guid == UnitGUID("mouseover") or guid == UnitGUID("focus") then
		return true
	-- elseif LocalUnitLookup[guid] then return true
	end
end



local function CombatEventHandler(frame, event, ...)
	-- General Events, Passthrough
	if event ~= "COMBAT_LOG_EVENT_UNFILTERED" then
		if GeneralEvents[event] then GeneralEvents[event](...) end
		return
	elseif inArena then
		return
	end

	-- Combat Log Unfiltered
	local timestamp, combatevent, sourceGUID, destGUID, destName, destFlags, destRaidFlag, auraType, spellid, spellname, stackCount = GetCombatEventResults(...)

		local CombatLogUpdateFunction = CombatLogEvents[combatevent]

		-- Evaluate only for certain combat log events
		if CombatLogUpdateFunction then
				-- Update Auras via API/UnitID Search
				if not GuidIsLocalUnitId(destGUID) then				-- Skip over the aura update if the unit is accessible by a local unitid.
						-- ADDITION: Also, we can skip player controlled friendly units when in a raid or battleground.

					-- Update Auras via Combat Log
					CombatLogUpdateFunction(timestamp, sourceGUID, destGUID, destName, spellid, spellname, stackCount, auraType)
				end
				-- To Do: Need to write something to detect when a change was made to the destID

				-- Cache Names and Rain Icon/Target Data....
				local name, raidicon
				if (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 0) then							-- Evaluate only Enemy Units
					-- Cache Unit Name for alternative lookup strategy
					if (bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and destName ~= nil then
						local rawName = strsplit("-", destName)			-- Strip server name from players
						ByName[rawName] = destGUID
						name = rawName
					end

					-- Cache Raid Icon Data for alternative lookup strategy
					for iconname, bitmask in pairs(RaidIconBit) do
						if bit.band(destRaidFlag, bitmask) > 0  then
							ByRaidIcon[iconname] = destGUID
							raidicon = iconname
							break
						end
					end
				end

				CallForWidgetUpdate(destGUID, raidicon, name)

		end

end

-------------------------------------------------------------
-- Widget Object Functions
-------------------------------------------------------------

local function UpdateWidgetTime(frame, expiration)
	if expiration == 0 then
		frame.TimeLeft:SetText("")
	else
		local timeleft = expiration-GetTime()
		if timeleft > 60 then
			frame.TimeLeft:SetText(floor(timeleft/60).."m")
		else
			frame.TimeLeft:SetText(floor(timeleft))
			--frame.TimeLeft:SetText(floor(timeleft*10)/10)
		end
	end
end


local function UpdateIcon(frame, texture, expiration, stacks, r, g, b)
	if frame and texture and expiration then
		-- Icon
		frame.Icon:SetTexture(texture)

		-- Stacks
		if stacks > 1 then frame.Stacks:SetText(stacks)
		else frame.Stacks:SetText("") end

		-- Highlight Coloring
		if r then
			frame.Highlight:SetVertexColor(r, g or 1, b or 1)
			frame.Highlight:Show()
			frame.Border:Hide()
		else frame.Highlight:Hide(); frame.Border:Show()	end

		-- Expiration
		UpdateWidgetTime(frame, expiration)
		frame:Show()
		if expiration ~= 0 then PolledHideIn(frame, expiration) end

	elseif frame then
		PolledHideIn(frame, 0)
	end
end

local AuraSlotspellid = {} 	-- auraSlot[slot] = spellid
local AuraSlotPriority = {} 	-- auraSlot[slot] = priority

local function debuffSort(a,b) return a.priority < b.priority end

local DebuffCache = {}
local CurrentAura = {}

local function UpdateIconGrid(frame, guid)

		local AuraIconFrames = frame.AuraIconFrames
		local AurasOnUnit = GetAuraList(guid)
		local AuraSlotIndex = 1
		local instanceid
		local DebuffLimit = DebuffColumns * 2

		DebuffCache = wipe(DebuffCache)
		local debuffCount = 0
		frame.currentAuraCount = 0

		--  if AuraHookFunction then debuffCount = AuraHookFunction(DebuffCache) end

		-- Cache displayable auras
		------------------------------------------------------------------------------------------------------
		-- This block will go through the auras on the unit and make a list of those that should
		-- be displayed, listed by priority.
		if AurasOnUnit then
			local currentAuraIndex = 0
			local aura

			for instanceid in pairs(AurasOnUnit) do
				currentAuraIndex = debuffCount + 1

				CurrentAura[currentAuraIndex] = wipe(CurrentAura[currentAuraIndex] or {})
				aura = CurrentAura[currentAuraIndex]

				aura.spellid, aura.name, aura.expiration, aura.stacks, aura.caster, aura.duration, aura.texture, aura.type, aura.reaction = GetAuraInstance(guid, instanceid)

				--if aura.type == 1 then print(aura.name, frame.unit.name) end
				if tonumber(aura.spellid) then
					local show, priority, r, g, b
					aura.unit = frame.unit

					-- Call Filter Function
					if frame.Filter then
						show, priority, r, g, b = frame.Filter(aura)		-- This method will be depricated
					else
						show, priority, r, g, b = AuraFilterFunction(aura)
					end				-- This method will replace it

					--print(aura.name, aura.spellid, aura.caster, aura.caster == UnitGUID("player"), aura.duration, aura.expiration)

					-- Get Order/Priority
					--if show and aura.expiration > GetTime() then		--- Testing this to enable certain 0 Expiration Debuffs  (MONK)
					if show then
						aura.priority = priority or 10
						aura.r, aura.g, aura.b = r, g, b
						debuffCount = debuffCount + 1
						DebuffCache[debuffCount] = aura
					end

				end
			end
		end


		-------------------------
		-- Debuff Cache Format
		--[[
		DebuffCache[i] = {'spellid', 'name', 'expiration', 'stacks', 'caster', 'duration', 'texture', 'type', 'reaction', 'priority', 'r', 'g', 'b'}
		How to use: You have control over the DebuffCache before it's sorted and displayed, particularly by adding and removing items.
		--]]


		--[[
		-------------------------
		-- Personal Aura Tracker: For displaying the presence of an aura on your character via target's aura widget...

		local PersonalAuraList = {"Rejuvenation"}

		if frame.unit.isTarget then --  and InCombatLockdown()
		--if frame.unit.isTarget and frame.unit.reaction ~= "FRIENDLY" then --  and InCombatLockdown()
			for i, n in pairs(PersonalAuraList) do
				if AuraSlotIndex > DebuffLimit then break end
				local pName, _, pIcon, pCount, _, _, pEnd = UnitAura("player", n)
				print(n, pName, _, pIcon, pCount, _, _, pEnd)
				if pName then
					UpdateIcon(AuraIconFrames[AuraSlotIndex], pIcon, pEnd, pCount, 1,.9,0)
					AuraSlotIndex = AuraSlotIndex + 1
				end
			end
		end
		--]]

		-- Display Auras
		------------------------------------------------------------------------------------------------------
		if debuffCount > 0 then
			frame:Show()
			sort(DebuffCache, debuffSort)

			for index = 1,  #DebuffCache do
				if AuraSlotIndex > DebuffLimit then break end
				local aura = DebuffCache[index]
				if aura.spellid and aura.expiration then
					--[[
					--if IsUsableSpell(aura.spellid) and select(2, GetSpellCooldown(aura.spellid)) == 0 then
					if select(2, GetSpellCooldown(aura.spellid)) == 0 then
						aura.r, aura.g, aura.b = 1,.9,0
					else aura.r, aura.g, aura.b = nil, nil, nil end
					--]]

					UpdateIcon(AuraIconFrames[AuraSlotIndex], aura.texture, aura.expiration, aura.stacks, aura.r, aura.g, aura.b)
					AuraSlotIndex = AuraSlotIndex + 1
					frame.currentAuraCount = index
				end
			end

		end

		-- Clear Extra Slots
		for AuraSlotIndex = AuraSlotIndex, DebuffLimit do UpdateIcon(AuraIconFrames[AuraSlotIndex]) end

		DebuffCache = wipe(DebuffCache)
end

function UpdateWidget(frame)
		-- Check for ID
		local unit = frame.unit
		if not unit then return end

		local guid = unit.guid

		if not guid then
			-- Attempt to ID widget via Name or Raid Icon
			if unit.type == "PLAYER" then guid = ByName[unit.rawName]
			elseif unit.isMarked then guid = ByRaidIcon[unit.raidIcon] end


			if guid then
				unit.guid = guid	-- Feed data back into unit table		-- Testing
			else
				frame:Hide()
				return
			end
		end


		UpdateIconGrid(frame, guid)

		if frame.currentAuraCount ~= frame.previousAuraCount then
			frame.previousAuraCount = frame.currentAuraCount
			--TidyPlates:RequestDelegateUpdate()		-- Delegate Update, For Debuff Widget-Controlled Scale and Opacity Functions

			TidyPlates:RequestDelegateUpdate(frame:GetParent().PlateParent)		-- Delegate Update, For Debuff Widget-Controlled Scale and Opacity Functions
		end
end

local function UpdateWidgetTarget(frame, unitid)
	UpdateIconGrid(frame, UnitGUID(unitid))
end


-- Context Update (mouseover, target change)
local function UpdateWidgetContextFull(frame, unit)
	local guid = unit.guid
	frame.unit = unit
	frame.guidcache = guid

	WidgetList[frame] = true
	if guid then WidgetGUID[guid] = frame end

	if unit.isTarget then UpdateAurasByUnitID("target")
	elseif unit.isMouseover then UpdateAurasByUnitID("mouseover") end

	local raidicon, name
	if unit.isMarked then
		raidicon = unit.raidIcon
		if guid and raidicon then ByRaidIcon[raidicon] = guid end
	end
	if unit.type == "PLAYER" then name = unit.rawName end

	CallForWidgetUpdate(guid, raidicon, name)
end

local function UpdateWidgetContextTargetOnly(frame, unit)
	if unit.isTarget then
		-- UpdateAurasByUnitID("target")

	end
end

local UpdateWidgetContext = UpdateWidgetContextFull

local function ClearWidgetContext(frame)
	if frame.guidcache then
		WidgetGUID[frame.guidcache] = nil
		frame.unit = nil
	end
	WidgetList[frame] = nil

end

local function ExpireFunction(icon)
	UpdateWidget(icon.Parent)
end

-------------------------------------------------------------
-- Widget Frames
-------------------------------------------------------------
local WideArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameWide"
local SquareArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameSquare"
local WideHighlightArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameHighlightWide"
local SquareHighlightArt = "Interface\\AddOns\\TidyPlatesWidgets\\Aura\\AuraFrameHighlightSquare"
local AuraFont = "FONTS\\ARIALN.TTF"

local function Enable()
	AuraMonitor:SetScript("OnEvent", CombatEventHandler)
	AuraMonitor:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	for event in pairs(GeneralEvents) do
		AuraMonitor:RegisterEvent(event)
	end

	TidyPlatesUtility:EnableGroupWatcher()
	WatcherIsEnabled = true

	if not TidyPlatesWidgetData.CachedAuraDurations then
		TidyPlatesWidgetData.CachedAuraDurations = {}
	end
end

local function EnableForTargetOnly()
	AuraMonitor:UnregisterAllEvents()
	AuraMonitor:SetScript("OnEvent", TargetEventHandler)

	--	AuraMonitor:RegisterEvent("UNIT_TARGET")
	AuraMonitor:RegisterEvent("UNIT_AURA")

	TidyPlatesUtility:EnableGroupWatcher()
	WatcherIsEnabled = true
end

local function Disable()
	AuraMonitor:SetScript("OnEvent", nil)
	AuraMonitor:UnregisterAllEvents()
	WatcherIsEnabled = false
end

-- Create a Wide Aura Icon
local function CreateWideAuraIconFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame.unit = nil
	frame.Parent = parent
	frame:SetWidth(26.5); frame:SetHeight(14.5)
	-- Icon
	frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
	frame.Icon:SetAllPoints(frame)
	--frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	frame.Icon:SetTexCoord(.07, 1-.07, .23, 1-.23)  -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
	frame.Border = frame:CreateTexture(nil, "ARTWORK")
	frame.Border:SetWidth(32); frame.Border:SetHeight(32)
	frame.Border:SetPoint("CENTER", 1, -2)
	frame.Border:SetTexture(WideArt)
	-- Highlight
	frame.Highlight = frame:CreateTexture(nil, "ARTWORK")
	frame.Highlight:SetAllPoints(frame.Border)
	frame.Highlight:SetTexture(WideHighlightArt)
	--  Time Text
	frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
	frame.TimeLeft:SetFont(AuraFont ,9, "OUTLINE")
	frame.TimeLeft:SetShadowOffset(1, -1)
	frame.TimeLeft:SetShadowColor(0,0,0,1)
	frame.TimeLeft:SetPoint("RIGHT", 0, 8)
	frame.TimeLeft:SetWidth(26)
	frame.TimeLeft:SetHeight(16)
	frame.TimeLeft:SetJustifyH("RIGHT")
	--  Stacks
	frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
	frame.Stacks:SetFont(AuraFont,10, "OUTLINE")
	frame.Stacks:SetShadowOffset(1, -1)
	frame.Stacks:SetShadowColor(0,0,0,1)
	frame.Stacks:SetPoint("RIGHT", 0, -6)
	frame.Stacks:SetWidth(26)
	frame.Stacks:SetHeight(16)
	frame.Stacks:SetJustifyH("RIGHT")
	-- Information about the currently displayed aura
	frame.AuraInfo = {
		Name = "",
		Icon = "",
		Stacks = 0,
		Expiration = 0,
		Type = "",
	}
	--frame.Poll = UpdateWidgetTime
	frame.Expire = ExpireFunction
	-- UpdateWidget(frame)
	frame.Poll = parent.PollFunction
	frame:Hide()
	return frame
end


-- Create a Square Aura Icon
local function CreateSquareAuraIconFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame.Parent = parent
	frame:SetWidth(16.5); frame:SetHeight(14.5)
	-- Icon
	frame.Icon = frame:CreateTexture(nil, "BACKGROUND")
	frame.Icon:SetAllPoints(frame)
	frame.Icon:SetTexCoord(.10, 1-.07, .12, 1-.12)  -- obj:SetTexCoord(left,right,top,bottom)
	-- Border
	frame.Border = frame:CreateTexture(nil, "ARTWORK")
	frame.Border:SetWidth(32); frame.Border:SetHeight(32)
	frame.Border:SetPoint("CENTER", 0, -2)
	frame.Border:SetTexture(SquareArt)
	-- Highlight
	frame.Highlight = frame:CreateTexture(nil, "ARTWORK")
	frame.Highlight:SetAllPoints(frame.Border)
	frame.Highlight:SetTexture(SquareHighlightArt)
	--  Time Text
	frame.TimeLeft = frame:CreateFontString(nil, "OVERLAY")
	frame.TimeLeft:SetFont(AuraFont ,9, "OUTLINE")
	frame.TimeLeft:SetShadowOffset(1, -1)
	frame.TimeLeft:SetShadowColor(0,0,0,1)
	frame.TimeLeft:SetPoint("RIGHT", 0, 8)
	frame.TimeLeft:SetWidth(26)
	frame.TimeLeft:SetHeight(16)
	frame.TimeLeft:SetJustifyH("RIGHT")
	--  Stacks
	frame.Stacks = frame:CreateFontString(nil, "OVERLAY")
	frame.Stacks:SetFont(AuraFont,10, "OUTLINE")
	frame.Stacks:SetShadowOffset(1, -1)
	frame.Stacks:SetShadowColor(0,0,0,1)
	frame.Stacks:SetPoint("RIGHT", 0, -6)
	frame.Stacks:SetWidth(26)
	frame.Stacks:SetHeight(16)
	frame.Stacks:SetJustifyH("RIGHT")
	-- Information about the currently displayed aura
	frame.AuraInfo = {
		Name = "",
		Icon = "",
		Stacks = 0,
		Expiration = 0,
		Type = "",
	}
	--frame.Poll = UpdateWidgetTime
	frame.Expire = ExpireFunction
	frame.Poll = parent.PollFunction
	frame:Hide()
	return frame
end

local CreateIconFrame = CreateWideAuraIconFrame

-- Create the Main Widget Body and Icon Array
local function CreateAuraWidget(parent, style)
	--if not WatcherIsEnabled then Enable() end
	-- Create Base frame
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(128); frame:SetHeight(32); frame:Show()
	-- Create Icon Array
	frame.PollFunction = UpdateWidgetTime
	frame.AuraIconFrames = {}
	local AuraIconFrames = frame.AuraIconFrames

	local DebuffLimit = DebuffColumns * 2

	for index = 1, DebuffLimit do AuraIconFrames[index] = CreateIconFrame(frame);  end
	-- Set Anchors
	AuraIconFrames[1]:SetPoint("LEFT", frame)
	for index = 2, DebuffColumns do AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index-1], "RIGHT", 5, 0) end
	AuraIconFrames[DebuffColumns+1]:SetPoint("BOTTOMLEFT", AuraIconFrames[1], "TOPLEFT", 0, 8)
	for index = (DebuffColumns+2), DebuffLimit do AuraIconFrames[index]:SetPoint("LEFT", AuraIconFrames[index-1], "RIGHT", 5, 0) end
	-- Functions
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end
	--frame:SetScript("OnHide", function() for index = 1, 4 do PolledHideIn(AuraIconFrames[index], 0) end end)
	frame.Filter = nil
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetContext
	frame.UpdateTarget = UpdateWidgetTarget
	return frame
end

local function UseSquareDebuffIcon()
	CreateIconFrame = CreateSquareAuraIconFrame
	DebuffColumns = 5
	TidyPlates:ForceUpdate()
end

local function UseWideDebuffIcon()
	CreateIconFrame = CreateWideAuraIconFrame
	DebuffColumns = 3
	TidyPlates:ForceUpdate()
end

local function SetPrefilter(func)
	if func and type(func) == 'function' then
		AuraPrefilterFunction = func or DefaultPrefilterFunction
	end
end

local function SetAuraFilter(func)
	if func and type(func) == 'function' then
		AuraFilterFunction = func
	end
end

local function SetAuraHook(func)
	if func and type(func) == 'function' then
		AuraHookFunction = func
	end
end

function TestAuraWatcher()
	--unitid = unitid or "focus"
	unitid = "focus"
	--name, rank, icon, powerCost, isFunnel, powerType, castingTime, minRange, maxRange = GetSpellInfo("Rip")
	--local spellname , _, texture, count, _, duration, _, _, _, _, spellid, _, isBossDebuff = UnitDebuff(unitid, index)

	SetAuraInstance(UnitGUID(unitid), 1822, "Rake", GetTime() + 15, 1, UnitGUID("player"), 15, "Interface\\Icons\\ability_druid_disembowel", AURA_TYPE["Debuff"], AURA_TARGET_HOSTILE)
	SetAuraInstance(UnitGUID(unitid), 774, "Rejuvenation", GetTime() + 12, 1, UnitGUID("player"), 12, "Interface\\Icons\\spell_nature_rejuvenation", AURA_TYPE_BUFF, AURA_TARGET_FRIENDLY)
	SetAuraInstance(UnitGUID(unitid), 2823, "Deadly Poison", GetTime() + 12, 1, UnitGUID("player"), 12, "Interface\\Icons\\ability_rogue_dualweild", AURA_TYPE["Poison"], AURA_TARGET_HOSTILE)
	--SetAuraInstance(UnitGUID(unitid), 6343, "Thunder Clap", GetTime() + 20, 1, UnitGUID("player"), 20, "Interface\\Icons\\Spell_nature_ThunderClap", AURA_TYPE["Debuff"], AURA_TARGET_HOSTILE)
	SetAuraInstance(UnitGUID(unitid), 6343, "Thunder Clap", GetTime() + 20, 1, UnitGUID("player"), 20, "Interface\\Icons\\Spell_nature_ThunderClap", AURA_TYPE["Debuff"], AURA_TARGET_HOSTILE)

	CallForWidgetUpdate(UnitGUID(unitid), nil, UnitName(unitid))
	-- /run TidyPlatesWidgets.TestAuraWatcher()
end

-----------------------------------------------------
-- External
-----------------------------------------------------
TidyPlatesWidgets.GetAuraWidgetByGUID = GetAuraWidgetByGUID
TidyPlatesWidgets.IsAuraShown = IsAuraShown
TidyPlatesWidgets.CanPlayerDispel = CanPlayerDispel

TidyPlatesWidgets.UseSquareDebuffIcon = UseSquareDebuffIcon
TidyPlatesWidgets.UseWideDebuffIcon = UseWideDebuffIcon
TidyPlatesWidgets.SetAuraPrefilter = SetPrefilter
TidyPlatesWidgets.SetDebuffPrefilter = SetPrefilter				-- Will be deprecated; "Debuff" is now "Aura"
TidyPlatesWidgets.SetAuraFilter = SetAuraFilter
TidyPlatesWidgets.SetAuraHook = SetAuraHook

TidyPlatesWidgets.CreateAuraWidget = CreateAuraWidget

TidyPlatesWidgets.EnableAuraWatcher = Enable
TidyPlatesWidgets.EnableAuraWatcherTargetOnly = EnableForTargetOnly
TidyPlatesWidgets.DisableAuraWatcher = Disable


