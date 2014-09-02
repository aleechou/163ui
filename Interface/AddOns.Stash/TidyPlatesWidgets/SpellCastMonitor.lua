--[[
Tasks:
- Add Spell Catch by Raid Icon
- Filter out Spell events for the current target  *done*
--]]


local RaidTargetReference
local _

if (tonumber((select(2, GetBuildInfo()))) >= 14299) then
	-- 4.2
	RaidTargetReference = {
		["STAR"] = 0x00000001,
		["CIRCLE"] = 0x00000002,
		["DIAMOND"] = 0x00000004,
		["TRIANGLE"] = 0x00000008,
		["MOON"] = 0x00000010,
		["SQUARE"] = 0x00000020,
		["CROSS"] = 0x00000040,
		["SKULL"] = 0x00000080,
	}
else
	 -- 4.1
	 RaidTargetReference = {
		["STAR"] = 0x00100000,
		["CIRCLE"] = 0x00200000,
		["DIAMOND"] = 0x00400000,
		["TRIANGLE"] = 0x00800000,
		["MOON"] = 0x01000000,
		["SQUARE"] = 0x02000000,
		["CROSS"] = 0x04000000,
		["SKULL"] = 0x08000000,
	}
end

-------------------------------------------------------------------------
-- Spell Cast Event Watcher.
-------------------------------------------------------------------------
local CombatCastEventWatcher
local CombatEventHandlers = {}
local StartCastAnimationOnNameplate = TidyPlates.StartCastAnimationOnNameplate		-- If you don't define a local reference, the Tidy Plates table will get passed to the function.

local function SearchNameplateByGUID(SearchFor)
	local VisiblePlate, UnitGUID
	for VisiblePlate in pairs(TidyPlates.NameplatesByVisible) do
		UnitGUID = VisiblePlate.extended.unit.guid
		if UnitGUID and UnitGUID == SearchFor then									-- BY GUID
			return VisiblePlate
		end
	end
end

local function SearchNameplateByName(NameString)
	local VisiblePlate
	local SearchFor = strsplit("-", NameString)
	for VisiblePlate in pairs(TidyPlates.NameplatesByVisible) do
		if VisiblePlate.extended.unit.name == SearchFor then										-- BY NAME
			return VisiblePlate
		end
	end
end

local function SearchNameplateByIcon(UnitFlags)
	local UnitIcon
	for iconname, bitmask in pairs(RaidTargetReference) do
		if bit.band(UnitFlags, bitmask) > 0  then
			UnitIcon = iconname
			break
		end
	end	

	local VisiblePlate = nil
	for VisiblePlate in pairs(TidyPlates.NameplatesByVisible) do
		if VisiblePlate.extended.unit.isMarked and (VisiblePlate.extended.unit.raidIcon == UnitIcon) then	-- BY Icon
			return VisiblePlate
		end
	end
end

--------------------------------------
-- OnSpellCast
-- Sends cast event to an available nameplate
--------------------------------------
local function OnSpellCast(...)
	local sourceGUID, sourceName, sourceFlags, sourceRaidFlags, spellid, spellname = ...
	local FoundPlate = nil
	
	-- Gather Spell Info
	local spell, displayName, icon, castTime, _
	spell, displayName, icon, _, _, _, castTime, _, _ = GetSpellInfo(spellid)
	if not (castTime > 0) then return end
	
	if bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0 then 
		if bit.band(sourceFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0 then 
			--	destination plate, by name
			FoundPlate = SearchNameplateByName(sourceName)
		elseif bit.band(sourceFlags, COMBATLOG_OBJECT_CONTROL_NPC) > 0 then 
			--	destination plate, by GUID
			FoundPlate = SearchNameplateByGUID(sourceGUID)
			if not FoundPlate then FoundPlate = SearchNameplateByIcon(sourceRaidFlags) end
		else return	end
	else return end

	-- If the unit's nameplate is visible, show the cast bar
	if FoundPlate then 
		local currentTime = GetTime()
		FoundPlateUnit = FoundPlate.extended.unit
		if FoundPlateUnit.isTarget then return end
		
		castTime = (castTime / 1000)	-- Convert to seconds
		StartCastAnimationOnNameplate(FoundPlate, spell, spell, icon, currentTime, currentTime+castTime, false, false)
	end
end

-- SPELL_CAST_START -- Non-channeled spells
function CombatEventHandlers.SPELL_CAST_START(...)
	OnSpellCast(...)
end

--[[
-- SPELL_CAST_SUCCESS -- Channeled and Instant spells
function CombatEventHandlers.SPELL_CAST_SUCCESS(...)
	OnSpellCast(..., true)
end
--]]

--------------------------------------
-- Watch Combat Log Events
--------------------------------------

local GetCombatEventResults

if (tonumber((select(2, GetBuildInfo()))) >= 14299) then
	-- 4.2
	function GetCombatEventResults(...)
		local timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlag, spellid, spellname = ...	
		return combatevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, spellid, spellname	
	end

else
	 -- 4.1
	function GetCombatEventResults(...)
		local timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellid, spellname = ...		
		return combatevent, sourceGUID, sourceName, sourceFlags, sourceFlags, spellid, spellname
	end

end

-- 4.2
local function OnCombatEvent(self, event, ...)
	local combatevent, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, spellid, spellname = GetCombatEventResults(...)
	if CombatEventHandlers[combatevent] and sourceGUID ~= UnitGUID("target") then CombatEventHandlers[combatevent](sourceGUID, sourceName, sourceFlags, sourceRaidFlags, spellid, spellname) end		
end

-----------------------------------
-- External control functions
-----------------------------------

--/run TidyPlates:StartSpellCastWatcher()
local function StartSpellCastWatcher()
	if not CombatCastEventWatcher then CombatCastEventWatcher = CreateFrame("Frame") end
	CombatCastEventWatcher:SetScript("OnEvent", OnCombatEvent) 
	CombatCastEventWatcher:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	--print("Enabling Tidy Plates Spell Cast Monitor")
end

local function StopSpellCastWatcher()
	if CombatCastEventWatcher then 
		CombatCastEventWatcher:SetScript("OnEvent", nil)
		CombatCastEventWatcher:UnregisterAllEvents()
		CombatCastEventWatcher = nil
	end
end

TidyPlates.StartSpellCastWatcher = StartSpellCastWatcher
TidyPlates.StopSpellCastWatcher = StopSpellCastWatcher

-- To test spell cast: /run TestTidyPlatesCastBar("Boognish", 133, true)		-- The spell ID number of Fireball is 133
function TestTidyPlatesCastBar(SearchFor, SpellID, Shielded, ForceChanneled)
	local VisiblePlate, FoundPlate
	local currentTime = GetTime()
	local spell, displayName, icon,castTime, channel, _
	
	spell, displayName, icon, _, _, _, castTime, _, _ = GetSpellInfo(SpellID)
	
	
	print("Testing Spell Cast on", SearchFor)
	-- Search for the nameplate, by name (you could also search by GUID)
	for VisiblePlate in pairs(TidyPlates.NameplatesByVisible) do
	   if VisiblePlate.extended.unit.name == SearchFor then
		  FoundPlate = VisiblePlate
	   end
	end

	if ForceChanneled ~= nil then 
		channel = ForceChanneled
		if ForceChanneled then castTime = castTime + 2412 end
	else channel = false end
		
	-- If found, display the cast bar
	if FoundPlate then StartCastAnimationOnNameplate(FoundPlate, spell, spell, icon, currentTime, currentTime+(castTime/1000), Shielded, channel) end
end