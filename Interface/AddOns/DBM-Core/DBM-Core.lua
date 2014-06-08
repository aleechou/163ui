﻿-- ********************************************************* 
-- **               Deadly Boss Mods - Core               **
-- **            http://www.deadlybossmods.com            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Paul Emmerich (Tandanu @ EU-Aegwynn) (DBM-Core)
--    * Martin Verges (Nitram @ EU-Azshara) (DBM-GUI)
--    * Adam Williams (Omegal @ US-Whisperwind) (Primary boss mod author & DBM maintainer) Contact: Twitter @MysticalOS)
--
-- The localizations are written by:
--    * enGB/enUS: Tandanu & Omegal		http://www.deadlybossmods.com
--    * deDE: Tandanu					http://www.deadlybossmods.com
--    * deDE: Ebmor						DBM forums (PM: "Ebmor")
--    * ruRU: Swix						stalker.kgv@gmail.com
--    * ruRU: TOM_RUS
--    * zhTW: Whyv						ultrashining@gmail.com
--    * koKR: nBlueWiz					everfinale@gmail.com
--    * esES/esMX: Sueñalobos			alcortesm@gmail.com
--
-- The former/inactive-translators:
--    * ruRU: BootWin					bootwin@gmail.com
--    * ruRU: Vampik					admin@vampik.ru
--    * zhTW: Hman						herman_c1@hotmail.com
--    * zhTW: Azael/kc10577				paul.poon.kw@gmail.com
--    * esES: Snamor/1nn7erpLaY      	romanscat@hotmail.com
--    * zhCN: Diablohu					http://www.dreamgen.cn | diablohudream@gmail.com
--
-- Special thanks to:
--    * Arta
--    * Tennberg (a lot of fixes in the enGB/enUS localization)
--    * nBlueWiz (a lot of fixes in the koKR localization as well as boss mod work) Contact: everfinale@gmail.com
--
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--


-------------------------------
--  Globals/Default Options  --
-------------------------------
DBM = {
	Revision = tonumber(("$Revision: 11061 $"):sub(12, -3)),
	DisplayVersion = "5.4.10 "..DBM_CORE_SOUNDVER, -- the string that is shown as version
	DisplayReleaseVersion = "5.4.10", -- Needed to work around old versions of BW sending improper version information
	ReleaseRevision = 11061 -- the revision of the latest stable version that is available
}

-- Legacy crap; that stupid "Version" field was never a good idea.
-- Some functions that should be using ReleaseRevision still use this one, so we will just keep it and set to ReleaseRevision
DBM.Version = tostring(DBM.ReleaseRevision)

-- support for git svn which doesn't support svn keyword expansion
if not DBM.Revision then
	-- just use the latest release revision
	DBM.Revision = DBM.ReleaseRevision
end

DBM_SavedOptions = {}

DBM.DefaultOptions = {
	WarningColors = {
		{r = 0.41, g = 0.80, b = 0.94}, -- Color 1 - #69CCF0 - Turqoise
		{r = 0.95, g = 0.95, b = 0.00}, -- Color 2 - #F2F200 - Yellow
		{r = 1.00, g = 0.50, b = 0.00}, -- Color 3 - #FF8000 - Orange
		{r = 1.00, g = 0.10, b = 0.10}, -- Color 4 - #FF1A1A - Red
	},
	RaidWarningSound = "Sound\\Doodad\\BellTollNightElf.ogg",
	SpecialWarningSound = "Sound\\Spells\\PVPFlagTaken.ogg",
	SpecialWarningSound2 = "Sound\\Spells\\PVPFlagTaken.ogg",
	SpecialWarningSound3 = "Sound\\Spells\\PVPFlagTaken.ogg",
	ModelSoundValue = "Short",
	ChallengeBest = "Realm",
	CountdownVoice = "DBM-Sound-Yike\\yike",
	CountdownVoice2 = "yun",
	ShowCountdownText = false,
	RaidWarningPosition = {
		Point = "TOP",
		X = 0,
		Y = -185,
	},
	Enabled = true,
	ShowWarningsInChat = true,
	ShowChatTime = true,
	ShowFakedRaidWarnings = false,
	WarningIconLeft = true,
	WarningIconRight = true,
	WarningIconChat = true,
	StripServerName = true,
	ShowLoadMessage = true,
	ShowPizzaMessage = true,
	ShowEngageMessage = true,
	ShowKillMessage = true,
	ShowWipeMessage = true,
	ShowRecoveryMessage = true,
	AutoRespond = true,
	StatusEnabled = true,
	WhisperStats = false,
	HideBossEmoteFrame = true,
	SpamBlockBossWhispers = false,
	ShowMinimapButton = false,
	BlockVersionUpdateNotice = false,
	ShowSpecialWarnings = true,
	ShowFlashFrame = true,
	ShowAdvSWSounds = false,
	ShowShakeFrame = true,
	AlwaysShowHealthFrame = false,
	ShowBigBrotherOnCombatStart = false,
	AutologBosses = false,
	AdvancedAutologBosses = false,
	LogOnlyRaidBosses = false,
	UseMasterVolume = true,
	LFDEnhance = true,
	SetPlayerRole = true,
	HideWatchFrame = false,
	EnableModels = true,
	RangeFrameFrames = "radar",
	RangeFrameUpdates = "Average",
	RangeFramePoint = "CENTER",
	RangeFrameX = 50,
	RangeFrameY = -50,
	RangeFrameSound1 = "none",
	RangeFrameSound2 = "none",
	RangeFrameLocked = false,
	RangeFrameRadarPoint = "CENTER",
	RangeFrameRadarX = 100,
	RangeFrameRadarY = -100,
	InfoFramePoint = "CENTER",
	InfoFrameX = 75,
	InfoFrameY = -75,
	InfoFrameShowSelf = false,
	HPFramePoint = "CENTER",
	HPFrameX = -50,
	HPFrameY = 50,
	HPFrameMaxEntries = 5,
	SpecialWarningPoint = "CENTER",
	SpecialWarningX = 0,
	SpecialWarningY = 75,
	SpecialWarningFont = STANDARD_TEXT_FONT,
	SpecialWarningFontSize = 50,
	SpecialWarningFontColor = {0.0, 0.0, 1.0},
	SpecialWarningFlashCol1 = {1.0, 1.0, 0.0},--Yellow
	SpecialWarningFlashCol2 = {1.0, 0.5, 0.0},--Orange
	SpecialWarningFlashCol3 = {1.0, 0.0, 0.0},--Red
	SpecialWarningFlashDura1 = 0.4,
	SpecialWarningFlashDura2 = 0.4,
	SpecialWarningFlashDura3 = 1,
	SpecialWarningFlashAlph1 = 0.3,
	SpecialWarningFlashAlph2 = 0.3,
	SpecialWarningFlashAlph3 = 0.4,
	HealthFrameGrowUp = false,
	HealthFrameLocked = false,
	HealthFrameWidth = 200,
	ArrowPosX = 0,
	ArrowPosY = -150,
	ArrowPoint = "TOP",
	-- global boss mod settings (overrides mod-specific settings for some options)
	DontShowBossAnnounces = false,
	DontSendBossWhispers = false,
	DontSetIcons = false,
	DontShowRangeFrame = false,
	DontShowInfoFrame = false,
	DontShowPT = true,
	DontShowPTCountdownText = false,
	DontPlayPTCountdown = false,
	DontShowPTText = false,
	DontShowPTNoID = false,
	DontShowCTCount = false,
	PTCountThreshold = 10,
	LatencyThreshold = 250,
	BigBrotherAnnounceToRaid = false,
	SettingsMessageShown = false,
	ForumsMessageShown = false,
	AlwaysShowSpeedKillTimer = true,
--	HelpMessageShown = false,
	MoviesSeen = {},
	MovieFilter = "Never",
	LastRevision = 0,
	FilterSayAndYell = false,
	DebugMode = false,
	ChatFrame = "DEFAULT_CHAT_FRAME",
	
	ShowLTSpecialWarnings = true,
	LTSpecialWarningFont = STANDARD_TEXT_FONT,
	LTSpecialWarningFontSize = 50,
	LTSpecialWarningPoint = "CENTER",
	LTSpecialWarningX = 0,
	LTSpecialWarningY = -130,
	LTSpecialWarningFontColor = {0.0, 1.0, 0.0},
}

DBM.Bars = DBT:New()
DBM.Mods = {}
DBM.Soundfile = {}

------------------------
-- Global Identifiers --
------------------------
DBM_DISABLE_ZONE_DETECTION = newproxy(false)
DBM_OPTION_SPACER = newproxy(false)

--------------
--  Locals  --
--------------
local enabled = true
local blockEnable = false
local lastCombatStarted = GetTime()
local loadcIds = {}
local forceloadmapIds = {}
local blockMovieSkipItems = {}
local inCombat = {}
local combatInfo = {}
local bossIds = {}
local updateFunctions = {}
local raid = {}
local modSyncSpam = {}
local autoRespondSpam = {}
local chatPrefix = "<Deadly Boss Mods> "
local chatPrefixShort = "<DBM> "
local ver = ("%s (r%d)"):format(DBM.DisplayVersion, DBM.Revision)
local mainFrame = CreateFrame("Frame")
local showedUpdateReminder = false
local combatInitialized = false
local healthCombatInitialized = false
local schedule
local unschedule
local loadOptions
local loadModOptions
local checkWipe
local fireEvent
local playerName = UnitName("player")
local _, class = UnitClass("player")
local LastInstanceMapID = -1
local queuedBattlefield = {}
local loadDelay = nil
local loadDelay2 = nil
local stopDelay = nil
local watchFrameRestore = false
local currentSizes = nil
local bossHealth = {}
local savedDifficulty
local difficultyText

local enableIcons = true -- set to false when a raid leader or a promoted player has a newer version of DBM
local guiRequested = false

local bannedMods = { -- a list of "banned" (meaning they are replaced by another mod like DBM-Battlegrounds (replaced by DBM-PvP)) boss mods, these mods will not be loaded by DBM (and they wont show up in the GUI)
	"DBM-Battlegrounds", --replaced by DBM-PvP
	-- ZG and ZA are now part of the party mods for Cataclysm
	"DBM-ZulAman",
	"DBM-ZG",
}

--------------------------------------------------------
--  Cache frequently used global variables in locals  --
--------------------------------------------------------
local DBM = DBM
-- these global functions are accessed all the time by the event handler
-- so caching them is worth the effort
local ipairs, pairs, next = ipairs, pairs, next
local tinsert, tremove, twipe = table.insert, table.remove, table.wipe
local type = type
local select = select
local GetTime = GetTime
local floor, mhuge, mmin, mmax = math.floor, math.huge, math.min, math.max
local GetNumGroupMembers = GetNumGroupMembers
local GetRaidRosterInfo = GetRaidRosterInfo
local IsInRaid = IsInRaid
local IsInGroup = IsInGroup
local IsInInstance = IsInInstance
local UnitAffectingCombat = UnitAffectingCombat
local UnitExists = UnitExists
local UnitIsDead = UnitIsDead
local UnitIsFriend = UnitIsFriend
local GetSpellInfo = GetSpellInfo
local EJ_GetSectionInfo = EJ_GetSectionInfo
local GetInstanceInfo = GetInstanceInfo
local GetCurrentMapDungeonLevel = GetCurrentMapDungeonLevel
local GetMapInfo = GetMapInfo
local GetCurrentMapZone = GetCurrentMapZone
local SetMapToCurrentZone = SetMapToCurrentZone
local GetSpecialization = GetSpecialization
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local GetPartyAssignment = GetPartyAssignment
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local LoadAddOn = LoadAddOn
local IsEncounterInProgress = IsEncounterInProgress
local InCombatLockdown = InCombatLockdown
local GetAddOnInfo = GetAddOnInfo
local PlaySoundFile = PlaySoundFile
local PlaySound = PlaySound
local Ambiguate = Ambiguate

-- for Phanx' Class Colors
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS

---------------------------------
--  General (local) functions  --
---------------------------------
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
	for i, v in ipairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

-- removes all occurrences of a value in an array
-- returns true if at least one occurrence was remove, false otherwise
local function removeEntry(t, val)
	local existed = false
	for i = #t, 1, -1 do
		if t[i] == val then
			tremove(t, i)
			existed = true
		end
	end
	return existed
end

-- automatically sends an addon message to the appropriate channel (INSTANCE_CHAT, RAID or PARTY)
local function sendSync(prefix, msg)
	msg = msg or ""
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then--For BGs, LFR and LFG (we also check IsInInstance() so if you're in queue but fighting something outside like a world boss, it'll sync in "RAID" instead)
		SendAddonMessage("D4", prefix .. "\t" .. msg, "INSTANCE_CHAT")
	else
		if IsInRaid() then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SendAddonMessage("D4", prefix .. "\t" .. msg, "PARTY")
		end
	end
end

local function strFromTime(time)
	if type(time) ~= "number" then time = 0 end
	time = floor(time)
	if time < 60 then
		return DBM_CORE_TIMER_FORMAT_SECS:format(time)
	elseif time % 60 == 0 then
		return DBM_CORE_TIMER_FORMAT_MINS:format(time/60)
	else
		return DBM_CORE_TIMER_FORMAT:format(time/60, time % 60)
	end
end

local pformat
do
	-- fail-safe format, replaces missing arguments with unknown
	-- note: doesn't handle cases like %%%s correctly at the moment (should become %unknown, but becomes %%s)
	-- also, the end of the format directive is not detected in all cases, but handles everything that occurs in our boss mods ;)
	--> not suitable for general-purpose use, just for our warnings and timers (where an argument like a spell-target might be nil due to missing target information from unreliable detection methods)

	local function replace(cap1, cap2)
		return cap1 == "%" and DBM_CORE_UNKNOWN
	end

	function pformat(fstr, ...)
		local ok, str = pcall(format, fstr, ...)
		return ok and str or fstr:gsub("(%%+)([^%%%s<]+)", replace):gsub("%%%%", "%%")
	end
end

-- sends a whisper to a player by his or her character name or BNet presence id
-- returns true if the message was sent, nil otherwise
local function sendWhisper(target, msg)
	if type(target) == "number" then
		if not BNIsSelf(target) then -- never send BNet whispers to ourselves
			BNSendWhisper(target, msg)
			return true
		end
	elseif type(target) == "string" then
		-- whispering to ourselves here is okay and somewhat useful for whisper-warnings
		SendChatMessage(msg, "WHISPER", nil, target)
		return true
	end
end
local BNSendWhisper = sendWhisper


--------------
--  Events  --
--------------
do
	local registeredEvents = {}
	local registeredUnitEventIds = {}
	local argsMT = {__index = {}}
	local args = setmetatable({}, argsMT)

	function argsMT.__index:IsSpellID(a1, a2, a3, a4, a5)
		local v = self.spellId
		return v == a1 or v == a2 or v == a3 or v == a4 or v == a5
	end

	function argsMT.__index:IsPlayer()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsPlayerSource()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 and bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsNPC()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_NPC) ~= 0
	end

	function argsMT.__index:IsPet()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsPetSource()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0
	end

	function argsMT.__index:IsSrcTypePlayer()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsDestTypePlayer()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
	end

	function argsMT.__index:IsSrcTypeHostile()
		return bit.band(args.sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:IsDestTypeHostile()
		return bit.band(args.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0
	end

	function argsMT.__index:GetSrcCreatureID()
		return tonumber(self.sourceGUID:sub(6, 10), 16) or 0
	end

	function argsMT.__index:GetDestCreatureID()
		return tonumber(self.destGUID:sub(6, 10), 16) or 0
	end

	local function handleEvent(self, event, ...)
		local isUnitEvent = event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED"
		if self == mainFrame and isUnitEvent then
			-- UNIT_* events that come from mainFrame are _UNFILTERED variants and need their suffix
			event = event .. "_UNFILTERED"
			isUnitEvent = false -- not actually a real unit id for this function...
		end
		if not registeredEvents[event] or not enabled then return end
		for i, v in ipairs(registeredEvents[event]) do
			local zones = v.zones
			local handler = v[event]
			local modEvents = v.registeredUnitEvents
			if handler and (not isUnitEvent or not modEvents or modEvents[event .. ...])  and (not zones or zones[LastInstanceMapID]) and not (v.isTrashMod and IsEncounterInProgress()) then
				handler(v, ...)
			end
		end
	end

	local registerUnitEvent, unregisterUnitEvent
	do
		local frames = {} -- frames that are being used for unit events, one frame per unit id (this could be optimized, as it currently creates a new frame even for a different event, but that's not worth the effort as 90% of all calls are just boss1 anyways)

		function registerUnitEvent(mod, event, ...)
			mod.registeredUnitEvents = mod.registeredUnitEvents or {}
			for i = 1, select("#", ...) do
				local uId = select(i, ...)
				if not uId then break end
				local frame = frames[uId]
				if not frame then
					frame = CreateFrame("Frame")
					if uId == "mouseover" then
						-- work-around for mouse-over events (broken!)
						frame:SetScript("OnEvent", function(self, event, uId, ...)
							-- we registered mouseover events, so we only want mouseover events, thanks.
							handleEvent(self, event, "mouseover", ...)
						end)
					else
						frame:SetScript("OnEvent", handleEvent)
					end
					frames[uId] = frame
				end
				registeredUnitEventIds[event .. uId] = (registeredUnitEventIds[event .. uId] or 0) + 1
				mod.registeredUnitEvents[event .. uId] = true
				frame:RegisterUnitEvent(event, uId)
			end
		end

		function unregisterUnitEvent(mod, event, ...)
			for i = 1, select("#", ...) do
				local uId = select(i, ...)
				if not uId then break end
				local frame = frames[uId]
				local refs = (registeredUnitEventIds[event .. uId] or 1) - 1
				registeredUnitEventIds[event .. uId] = refs
				if refs <= 0 then
					registeredUnitEventIds[event .. uId] = nil
					if frame then
						frame:UnregisterEvent(event)
					end
				end
				if mod.registeredUnitEvents and mod.registeredUnitEvents[event .. uId] then
					mod.registeredUnitEvents[event .. uId] = nil
				end
			end
			for i = #registeredEvents[event], 1, -1 do
				if registeredEvents[event][i] == mod then
					tremove(registeredEvents[event], i)
				end
			end
			if #registeredEvents[event] == 0 then
				registeredEvents[event] = nil
			end
		end

	end


	-- UNIT_* events are special: they can take 'parameters' like this: "UNIT_HEALTH boss1 boss" which only trigger the event for the given unit ids
	function DBM:RegisterEvents(...)
		for i = 1, select("#", ...) do
			local event = select(i, ...)
			local eventWithArgs = event
			-- unit events need special care
			if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
				-- unit events are limited to 8 "parameters", as there is no good reason to ever use more than 5 (it's just that the code old code supported 8 (boss1-5, target, focus))
				local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8
				event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
				if not arg1 and event:sub(event:len() - 10) ~= "_UNFILTERED" then -- no arguments given, support for legacy mods
					eventWithArgs = event .. " boss1 boss2 boss3 boss4 boss5 target focus"
					event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", eventWithArgs)
				end
				if event:sub(event:len() - 10) == "_UNFILTERED" then
					-- we really want *all* unit ids
					mainFrame:RegisterEvent(event:sub(0, -12))
				else
					registerUnitEvent(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
				end
			else
				-- normal events
				mainFrame:RegisterEvent(event)
			end
			registeredEvents[eventWithArgs] = registeredEvents[eventWithArgs] or {}
			tinsert(registeredEvents[eventWithArgs], self)
			if event ~= eventWithArgs then
				registeredEvents[event] = registeredEvents[event] or {}
				tinsert(registeredEvents[event], self)
			end
		end
	end

	local function unregisterEvent(mod, event)
		if event:sub(0, 5) == "UNIT_" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED" then
			local event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 = strsplit(" ", event)
			if event:sub(event:len() - 10) == "_UNFILTERED" then
				mainFrame:UnregisterEvent(event:sub(0, -12))
			else
				unregisterUnitEvent(mod, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
			end
		else
			mainFrame:UnregisterEvent(event)
		end
	end

	function DBM:UnregisterInCombatEvents(ignore)
		for event, mods in pairs(registeredEvents) do
			if event ~= ignore then
				local match = false
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.inCombatOnlyEvents, event)  then
						tremove(mods, i)
						match = true
					end
				end
				if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(0, -10) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then -- unit events have their own reference count
					unregisterEvent(self, event)
				end
				if #mods == 0 then
					registeredEvents[event] = nil
				end
			end
		end
	end

	function DBM:UnregisterShortTermEvents()
		if self.shortTermRegisterEvents then
			for event, mods in pairs(registeredEvents) do
				local match = false
				for i = #mods, 1, -1 do
					if mods[i] == self and checkEntry(self.shortTermRegisterEvents, event)  then
						tremove(mods, i)
						match = true
					end
				end
				if #mods == 0 or (match and event:sub(0, 5) == "UNIT_" and event:sub(0, -10) ~= "_UNFILTERED" and event ~= "UNIT_DIED" and event ~= "UNIT_DESTROYED") then
					unregisterEvent(self, event)
				end
				if #mods == 0 then
					registeredEvents[event] = nil
				end
			end
			self.shortTermEventsRegistered = nil
			self.shortTermRegisterEvents = nil
		end
	end



	DBM:RegisterEvents("ADDON_LOADED")

	function DBM:FilterRaidBossEmote(msg, ...)
		return handleEvent(nil, "CHAT_MSG_RAID_BOSS_EMOTE_FILTERED", msg:gsub("\124c%x+(.-)\124r", "%1"), ...)
	end


	local noArgTableEvents = {
		SWING_DAMAGE = true,
		SWING_MISSED = true,
		SPELL_DAMAGE = true,
		SPELL_BUILDING_DAMAGE = true,
		SPELL_MISSED = true,
		RANGE_DAMAGE = true,
		RANGE_MISSED = true,
		SPELL_HEAL = true,
		SPELL_ENERGIZE = true,
		SPELL_PERIODIC_MISSED = true,
		SPELL_PERIODIC_DAMAGE = true,
		SPELL_PERIODIC_DRAIN = true,
		SPELL_PERIODIC_LEECH = true,
		SPELL_PERIODIC_ENERGIZE = true,
		SPELL_DRAIN = true,
		SPELL_LEECH = true
	}
	function DBM:COMBAT_LOG_EVENT_UNFILTERED(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
		if not registeredEvents[event] then return end
		-- process some high volume events without building the whole table which is somewhat faster
		-- this prevents work-around with mods that used to have their own event handler to prevent this overhead
		if noArgTableEvents[event] then
			return handleEvent(nil, event, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
		else
			twipe(args)
			args.timestamp = timestamp
			args.event = event
			args.sourceGUID = sourceGUID
			args.sourceName = sourceName
			args.sourceFlags = sourceFlags
			args.sourceRaidFlags = sourceRaidFlags
			args.destGUID = destGUID
			args.destName = destName
			args.destFlags = destFlags
			args.destRaidFlags = destRaidFlags
			-- taken from Blizzard_CombatLog.lua
			if event:sub(0, 6) == "SPELL_" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				if event == "SPELL_INTERRUPT" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
				elseif event == "SPELL_EXTRA_ATTACKS" then
					args.amount = select(4, ...)
				elseif event == "SPELL_DISPEL" or event == "SPELL_DISPEL_FAILED" or event == "SPELL_AURA_STOLEN" or event == "SPELL_AURA_BROKEN" or event == "SPELL_AURA_BROKEN_SPELL" then
					args.extraSpellId, args.extraSpellName, args.extraSpellSchool = select(4, ...)
					args.auraType = select(7, ...)
				elseif event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REMOVED" or event == "SPELL_AURA_REFRESH" then
					args.auraType, args.remainingPoints = select(4, ...)
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_AURA_APPLIED_DOSE" or event == "SPELL_AURA_REMOVED_DOSE" then
					args.auraType, args.amount = select(4, ...)
					if not args.sourceName then
						args.sourceName = args.destName
						args.sourceGUID = args.destGUID
						args.sourceFlags = args.destFlags
					end
				elseif event == "SPELL_CAST_FAILED" then
					args.missType = select(4, ...)
				end
			elseif event == "DAMAGE_SHIELD" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			elseif event == "DAMAGE_SHIELD_MISSED" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				args.missType = select(4, ...)
			elseif event == "ENCHANT_APPLIED" or event == "ENCHANT_REMOVED" then
				args.spellName = select(1,...)
				args.itemId, args.itemName = select(2,...)
			elseif event == "UNIT_DIED" or event == "UNIT_DESTROYED" then
				args.sourceName = args.destName
				args.sourceGUID = args.destGUID
				args.sourceFlags = args.destFlags
			elseif event == "ENVIRONMENTAL_DAMAGE" then
				args.environmentalType = select(1,...)
				args.amount, args.overkill, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(2, ...)
				args.spellName = _G["ACTION_"..event.."_"..args.environmentalType]
				args.spellSchool = args.school
			elseif event == "DAMAGE_SPLIT" then
				args.spellId, args.spellName, args.spellSchool = select(1, ...)
				args.amount, args.school, args.resisted, args.blocked, args.absorbed, args.critical, args.glancing, args.crushing = select(4, ...)
			end
			return handleEvent(nil, event, args)
		end
	end
	mainFrame:SetScript("OnEvent", handleEvent)
end

--------------
--  OnLoad  --
--------------
do

	local isLoaded = false
	local onLoadCallbacks = {}

	-- register a callback that will be executed once the addon is fully loaded (ADDON_LOADED fired, saved vars are available)
	function DBM:RegisterOnLoadCallback(cb)
		if isLoaded then
			cb()
		else
			onLoadCallbacks[#onLoadCallbacks + 1] = cb
		end
	end

	local function showOldVerWarning()
		local popup = CreateFrame("Frame", nil, UIParent)
		popup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = {left = 1, right = 1, top = 1, bottom = 1}}
		)
		popup:SetSize(600, 160)
		popup:SetPoint("TOP", UIParent, "TOP", 0, -200)
		popup:SetFrameStrata("DIALOG")

		local text = popup:CreateFontString()
		text:SetFontObject(ChatFontNormal)
		text:SetWidth(570)
		text:SetWordWrap(true)
		text:SetPoint("TOP", popup, "TOP", 0, -15)
		text:SetText("You are still running the old DBM3 compatibility layer for deprecated DBM3 mods which have been replaced by DBM4 mods. This mod will cause error messages on login and must be disabled.\nYou should also remove the folder DBM-BurningCrusade from your Interface/AddOns folder.\nClick okay to disable the mod and reload the UI.")

		local accept = CreateFrame("Button", nil, popup)
		accept:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		accept:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		accept:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		accept:SetSize(128, 35)
		accept:SetPoint("BOTTOM", popup, "BOTTOM", 0, 0)
		accept:SetScript("OnClick", function(f) DisableAddOn("DBM-BurningCrusade") ReloadUI() f:GetParent():Hide() end)

		local atext = accept:CreateFontString()
		atext:SetFontObject(ChatFontNormal)
		atext:SetPoint("CENTER", accept, "CENTER", 0, 5)
		atext:SetText(OKAY)
		PlaySound("igMainMenuOpen")
	end

	function DBM:ADDON_LOADED(modname)
		if modname == "DBM-Core" and not isLoaded then
			isLoaded = true
			for i, v in ipairs(onLoadCallbacks) do
				xpcall(v, geterrorhandler())
			end
			onLoadCallbacks = nil
			local enabled, loadable = select(4, GetAddOnInfo("DBM-BurningCrusade"))
			if enabled and loadable then
				showOldVerWarning()
			end
			loadOptions()
			DBM.Bars:LoadOptions("DBM")
			DBM.Arrow:LoadPosition()
			if not DBM.Options.ShowMinimapButton then self:HideMinimapButton() end
			self.AddOns = {}
			for i = 1, GetNumAddOns() do
				local addonName, _, _, enabled = GetAddOnInfo(i)
				if GetAddOnMetadata(i, "X-DBM-Mod") and enabled then
					if checkEntry(bannedMods, addonName) then
						print("The mod " .. addonName .. " is deprecated and will not be available. Please remove the folder " .. addonName .. " from your Interface" .. (IsWindowsClient() and "\\" or "/") .. "AddOns folder to get rid of this message.")
					else
						local mapIdTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-MapID") or "")}
						tinsert(self.AddOns, {
							sort			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Sort") or mhuge) or mhuge,
							type			= GetAddOnMetadata(i, "X-DBM-Mod-Type") or "OTHER",
							category		= GetAddOnMetadata(i, "X-DBM-Mod-Category") or "Other",
							name			= GetAddOnMetadata(i, "X-DBM-Mod-Name") or GetRealZoneText(tonumber(mapIdTable[1])) or "Unknown",
							mapId			= mapIdTable,
							subTabs			= GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategoriesID"))} or GetAddOnMetadata(i, "X-DBM-Mod-SubCategories") and {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-SubCategories"))},
							oneFormat		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Single-Format") or 0) == 1,
							hasLFR			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-LFR") or 0) == 1,
							hasFlex			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Flex") or 0) == 1,
							hasChallenge	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-Has-Challenge") or 0) == 1,
							noHeroic		= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Heroic") or 0) == 1,
							noStatistics	= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-No-Statistics") or 0) == 1,
							modId			= addonName,
						})
						for i = #self.AddOns[#self.AddOns].mapId, 1, -1 do
							local id = tonumber(self.AddOns[#self.AddOns].mapId[i])
							if id then
								self.AddOns[#self.AddOns].mapId[i] = id
							else
								tremove(self.AddOns[#self.AddOns].mapId, i)
							end
						end
						if self.AddOns[#self.AddOns].subTabs then
							for k, v in ipairs(self.AddOns[#self.AddOns].subTabs) do
								local id = tonumber(self.AddOns[#self.AddOns].subTabs[k])
								if id then
									self.AddOns[#self.AddOns].subTabs[k] = GetRealZoneText(id):trim()
								else
									self.AddOns[#self.AddOns].subTabs[k] = (self.AddOns[#self.AddOns].subTabs[k]):trim()
								end
							end
						end
						if GetAddOnMetadata(i, "X-DBM-Mod-LoadCID") then
							local idTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-LoadCID"))}
							for i = 1, #idTable do
								loadcIds[tonumber(idTable[i]) or ""] = addonName
							end
						end
						if GetAddOnMetadata(i, "X-DBM-Mod-ForceLoad-MapID") then
							local idTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-ForceLoad-MapID"))}
							for i = 1, #idTable do
								forceloadmapIds[tonumber(idTable[i]) or ""] = true
							end
						end
						if GetAddOnMetadata(i, "X-DBM-Mod-Block-Movie-Skip-ItemID") then
							local idTable = {strsplit(",", GetAddOnMetadata(i, "X-DBM-Mod-Block-Movie-Skip-ItemID"))}
							for i = 1, #idTable do
								blockMovieSkipItems[tonumber(idTable[i]) or ""] = tonumber(mapIdTable[1])
							end
						end
					end
				elseif GetAddOnMetadata(i, "X-DBM-Mod-SoundFile") and enabled then
					tinsert(DBM.Soundfile, {
						Addon			= GetAddOnInfo(i),
						Tag				= GetAddOnMetadata(i, "X-DBM-Mod-SoundFile"),
						Path			= GetAddOnInfo(i).."\\"..GetAddOnMetadata(i, "X-DBM-Mod-SoundFile"),
						Name			= GetAddOnMetadata(i, "X-DBM-Mod-SoundFileName") or DBM_CORE_SOUND_UNNAME,						
						Usage			= GetAddOnMetadata(i, "X-DBM-Mod-SoundFileUsage") or DBM_CORE_SOUND_UNUSAGE,
						hasPic			= tonumber(GetAddOnMetadata(i, "X-DBM-Mod-SoundFilePIC") or 0) == 1,
					})
				end
			end
			table.sort(self.AddOns, function(v1, v2) return v1.sort < v2.sort end)
			self:RegisterEvents(
				"COMBAT_LOG_EVENT_UNFILTERED",
				"GROUP_ROSTER_UPDATE",
				"UNIT_NAME_UPDATE_UNFILTERED",
				--"INSTANCE_GROUP_SIZE_CHANGED",
				"CHAT_MSG_ADDON",
				"BN_CHAT_MSG_ADDON",
				"PLAYER_REGEN_DISABLED",
				"PLAYER_REGEN_ENABLED",
				"INSTANCE_ENCOUNTER_ENGAGE_UNIT",
				"ENCOUNTER_START",
				"ENCOUNTER_END",
				"UNIT_DIED",
				"UNIT_DESTROYED",
				"UNIT_HEALTH mouseover target focus boss1 boss2 boss3 boss4 boss5",
				"CHAT_MSG_WHISPER",
				"CHAT_MSG_BN_WHISPER",
				"CHAT_MSG_MONSTER_YELL",
				"CHAT_MSG_MONSTER_EMOTE",
				"CHAT_MSG_MONSTER_SAY",
				"CHAT_MSG_RAID_BOSS_EMOTE",
				"RAID_BOSS_EMOTE",
				"PLAYER_ENTERING_WORLD",
				"LFG_ROLE_CHECK_SHOW",
				"LFG_PROPOSAL_SHOW",
				"READY_CHECK",
				"LFG_PROPOSAL_FAILED",
				"LFG_PROPOSAL_SUCCEEDED",
				"UPDATE_BATTLEFIELD_STATUS",
				"UPDATE_MOUSEOVER_UNIT",
				"UNIT_TARGET_UNFILTERED",
				"CINEMATIC_START",
				"LFG_COMPLETION_REWARD",
				"WORLD_STATE_TIMER_START",
				"WORLD_STATE_TIMER_STOP",
				"ACTIVE_TALENT_GROUP_CHANGED",
				"LOADING_SCREEN_DISABLED"
			)
			self:GROUP_ROSTER_UPDATE()
			self:LOADING_SCREEN_DISABLED()
			self:Schedule(1.5, function()
        		combatInitialized = true
			end)
			self:Schedule(20, function()--Delay UNIT_HEALTH combat start for 20 sec. (to not break Timer Recovery stuff)
        		healthCombatInitialized = true
			end)
		end
	end
end


-----------------
--  Callbacks  --
-----------------
do
	local callbacks = {}

	function fireEvent(event, ...)
		if not callbacks[event] then return end
		for i, v in ipairs(callbacks[event]) do
			local ok, err = pcall(v, event, ...)
			if not ok then DBM:AddMsg(("Error while executing callback %s for event %s: %s"):format(tostring(v), tostring(event), err)) end
		end
	end

	function DBM:RegisterCallback(event, f)
		if not event or type(f) ~= "function" then
			error("Usage: DBM:RegisterCallback(event, callbackFunc)", 2)
		end
		callbacks[event] = callbacks[event] or {}
		tinsert(callbacks[event], f)
		return #callbacks[event]
	end
end


--------------------------
--  OnUpdate/Scheduler  --
--------------------------
do
	-- stack that stores a few tables (up to 8) which will be recycled
	local popCachedTable, pushCachedTable
	local numChachedTables = 0
	do
		local tableCache = nil

		-- gets a table from the stack, it will then be recycled.
		function popCachedTable()
			local t = tableCache
			if t then
				tableCache = t.next
				numChachedTables = numChachedTables - 1
			end
			return t
		end

		-- tries to push a table on the stack
		-- only tables with <= 4 array entries are accepted as cached tables are only used for tasks with few arguments as we don't want to have big arrays wasting our precious memory space doing nothing...
		-- also, the maximum number of cached tables is limited to 8 as DBM rarely has more than eight scheduled tasks with less than 4 arguments at the same time
		-- this is just to re-use all the tables of the small tasks that are scheduled all the time (like the wipe detection)
		-- note that the cache does not use weak references anywhere for performance reasons, so a cached table will never be deleted by the garbage collector
		function pushCachedTable(t)
			if numChachedTables < 8 and #t <= 4 then
				twipe(t)
				t.next = tableCache
				tableCache = t
				numChachedTables = numChachedTables + 1
			end
		end
	end

	-- priority queue (min-heap) that stores all scheduled tasks.
	-- insert: O(log n)
	-- deleteMin: O(log n)
	-- getMin: O(1)
	-- removeAllMatching: O(n)
	local insert, removeAllMatching, getMin, deleteMin
	do
		local heap = {}
		local firstFree = 1

		-- gets the next task
		function getMin()
			return heap[1]
		end

		-- restores the heap invariant by moving an item up
		local function siftUp(n)
			local parent = floor(n / 2)
			while n > 1 and heap[parent].time > heap[n].time do -- move the element up until the heap invariant is restored, meaning the element is at the top or the element's parent is <= the element
				heap[n], heap[parent] = heap[parent], heap[n] -- swap the element with its parent
				n = parent
				parent = floor(n / 2)
			end
		end

		-- restores the heap invariant by moving an item down
		local function siftDown(n)
			local m -- position of the smaller child
			while 2 * n < firstFree do -- #children >= 1
				-- swap the element with its smaller child
				if 2 * n + 1 == firstFree then -- n does not have a right child --> it only has a left child as #children >= 1
					m = 2 * n -- left child
				elseif heap[2 * n].time < heap[2 * n + 1].time then -- #children = 2 and left child < right child
					m = 2 * n -- left child
				else -- #children = 2 and right child is smaller than the left one
					m = 2 * n + 1 -- right
				end
				if heap[n].time <= heap[m].time then -- n is <= its smallest child --> heap invariant restored
					return
				end
				heap[n], heap[m] = heap[m], heap[n]
				n = m
			end
		end

		-- inserts a new element into the heap
		function insert(ele)
			heap[firstFree] = ele
			siftUp(firstFree)
			firstFree = firstFree + 1
		end

		-- deletes the min element
		function deleteMin()
			local min = heap[1]
			firstFree = firstFree - 1
			heap[1] = heap[firstFree]
			heap[firstFree] = nil
			siftDown(1)
			return min
		end

		-- removes multiple scheduled tasks from the heap
		-- note that this function is comparatively slow by design as it has to check all tasks and allows partial matches
		function removeAllMatching(f, mod, ...)
			-- remove all elements that match the signature, this destroyes the heap and leaves a normal array
			local v, match
			local foundMatch = false
			for i = #heap, 1, -1 do -- iterate backwards over the array to allow usage of table.remove
				v = heap[i]
				if (not f or v.func == f) and (not mod or v.mod == mod) then
					match = true
					for i = 1, select("#", ...) do
						if select(i, ...) ~= v[i] then
							match = false
							break
						end
					end
					if match then
						tremove(heap, i)
						firstFree = firstFree - 1
						foundMatch = true
					end
				end
			end
			-- rebuild the heap from the array in O(n)
			if foundMatch then
				for i = floor((firstFree - 1) / 2), 1, -1 do
					siftDown(i)
				end
			end
		end
	end

	mainFrame:SetScript("OnUpdate", function(self, elapsed)
		local time = GetTime()

		-- execute scheduled tasks
		local nextTask = getMin()
		while nextTask and nextTask.func and nextTask.time <= time do
			deleteMin()
			nextTask.func(unpack(nextTask))
			pushCachedTable(nextTask)
			nextTask = getMin()
		end

		-- execute OnUpdate handlers of all modules
		for i, v in pairs(updateFunctions) do
			if i.Options.Enabled and (not i.zones or i.zones[LastInstanceMapID]) then
				i.elapsed = (i.elapsed or 0) + elapsed
				if i.elapsed >= (i.updateInterval or 0) then
					v(i, i.elapsed)
					i.elapsed = 0
				end
			end
		end

		-- clean up sync spam timers and auto respond spam blockers
		-- TODO: optimize this; using next(t, k) all the time on nearly empty hash tables is not a good idea...doesn't really matter here as modSyncSpam only very rarely contains more than 4 entries...
		local k, v = next(modSyncSpam, nil)
		if v and (time - v > 8) then
			modSyncSpam[k] = nil
		end
	end)

	function schedule(t, f, mod, ...)
		if type(f) ~= "function" then
			error("usage: schedule(time, func, [mod, args...])", 2)
		end
		local v
		if numChachedTables > 0 and select("#", ...) <= 4 then -- a cached table is available and all arguments fit into an array with four slots
			v = popCachedTable()
			v.time = GetTime() + t
			v.func = f
			v.mod = mod
			for i = 1, select("#", ...) do
				v[i] = select(i, ...)
			end
		else -- create a new table
			v = {time = GetTime() + t, func = f, mod = mod, ...}
		end
		insert(v)
	end

	function unschedule(f, mod, ...)
		return removeAllMatching(f, mod, ...)
	end
end

function DBM:Schedule(t, f, ...)
	if type(f) ~= "function" then
		error("usage: DBM:Schedule(time, func, [args...])", 2)
	end
	return schedule(t, f, nil, ...)
end

function DBM:Unschedule(f, ...)
	return unschedule(f, nil, ...)
end

function DBM:ForceUpdate()
	mainFrame:GetScript("OnUpdate")(mainFrame, 0)
end

----------------------
--  Slash Commands  --
----------------------
SLASH_DEADLYBOSSMODS1 = "/dbm"
SlashCmdList["DEADLYBOSSMODS"] = function(msg)
	local cmd = msg:lower()
	if cmd == "ver" or cmd == "version" then
		DBM:ShowVersions(false)
	elseif cmd == "ver2" or cmd == "version2" then
		DBM:ShowVersions(true)
	elseif cmd == "unlock" or cmd == "move" then
		DBM.Bars:ShowMovableBar()
	elseif cmd == "help" then
		for i, v in ipairs(DBM_CORE_SLASHCMD_HELP) do DBM:AddMsg(v) end
	elseif cmd:sub(1, 5) == "timer" then
		local time, text = msg:match("^%w+ ([%d:]+) (.+)$")
		if not (time and text) then
			DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		time = min * 60 + sec
		DBM:CreatePizzaTimer(time, text)
	elseif cmd:sub(1, 15) == "broadcast timer" then
		local time, text = msg:match("^%w+ %w+ ([%d:]+) (.+)$")
		if DBM:GetRaidRank(playerName) == 0 then
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		if not (time and text) then
			DBM:AddMsg(DBM_PIZZA_ERROR_USAGE)
			return
		end
		local min, sec = string.split(":", time)
		min = tonumber(min or "") or 0
		sec = tonumber(sec or "")
		if min and not sec then
			sec = min
			min = 0
		end
		time = min * 60 + sec
		DBM:CreatePizzaTimer(time, text, true)
	elseif cmd:sub(0,5) == "break" then
		local _, _, difficultyID = GetInstanceInfo()
		if DBM:GetRaidRank(playerName) == 0 or difficultyID == 7 or difficultyID == 1 or difficultyID == 2 or IsEncounterInProgress() then--No break timers if not assistant or if it's LFR (because break timers in LFR are just not cute)
			DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
			return
		end
		DBM:Unschedule(SendChatMessage)
		local timer = tonumber(cmd:sub(6)) or 5
		if timer == 0 then return end--Allow /dbm break 0 to cancel it
		local timer = timer * 60
		local channel = (IsInRaid() and "RAID_WARNING") or "PARTY"
		DBM:CreatePizzaTimer(timer, DBM_CORE_TIMER_BREAK, true)
		if IsInGroup() then
			SendChatMessage(DBM_CORE_BREAK_START:format(timer/60), channel)
			if timer/60 > 5 then DBM:Schedule(timer - 5*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(5), channel) end
			if timer/60 > 2 then DBM:Schedule(timer - 2*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(2), channel) end
			if timer/60 > 1 then DBM:Schedule(timer - 1*60, SendChatMessage, DBM_CORE_BREAK_MIN:format(1), channel) end
			DBM:Schedule(timer, SendChatMessage, DBM_CORE_ANNOUNCE_BREAK_OVER, channel)
		end
	elseif cmd:sub(1, 4) == "pull" then
		if DBM:GetRaidRank(playerName) == 0 or IsEncounterInProgress() then
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		local timer = tonumber(cmd:sub(5)) or 10
		sendSync("PT", timer.."\t"..LastInstanceMapID)
	elseif cmd:sub(1, 5) == "cpull" then
		if DBM:GetRaidRank() == 0 or IsEncounterInProgress() then
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		sendSync("CPT")
	elseif cmd:sub(1, 3) == "lag" then
		sendSync("L")
		DBM:AddMsg(DBM_CORE_LAG_CHECKING)
		DBM:Schedule(5, function() DBM:ShowLag() end)
	elseif cmd:sub(1, 5) == "arrow" then
		if not IsInRaid() then
			DBM:AddMsg(DBM_ARROW_NO_RAIDGROUP)
			return false
		end
		local x, y = string.split(" ", cmd:sub(6):trim())
		local xNum, yNum = tonumber(x or ""), tonumber(y or "")
		local success
		if xNum and yNum then
			DBM.Arrow:ShowRunTo(xNum / 100, yNum / 100, 0)
			success = true
		elseif type(x) == "string" and x:trim() ~= "" then
			local subCmd = x:trim()
			if subCmd:upper() == "HIDE" then
				DBM.Arrow:Hide()
				success = true
			elseif subCmd:upper() == "MOVE" then
				DBM.Arrow:Move()
				success = true
			elseif subCmd:upper() == "TARGET" then
				DBM.Arrow:ShowRunTo("target")
				success = true
			elseif subCmd:upper() == "FOCUS" then
				DBM.Arrow:ShowRunTo("focus")
				success = true
			elseif DBM:GetRaidUnitId(DBM:Capitalize(subCmd)) then
				DBM.Arrow:ShowRunTo(DBM:Capitalize(subCmd))
				success = true
			end
		end
		if not success then
			for i, v in ipairs(DBM_ARROW_ERROR_USAGE) do
				DBM:AddMsg(v)
			end
		end
	elseif cmd:sub(1, 7) == "lockout" or cmd:sub(1, 3) == "ids" then
		if DBM:GetRaidRank(playerName) == 0 then
			return DBM:AddMsg(DBM_ERROR_NO_PERMISSION)
		end
		if not IsInRaid() then
			return DBM:AddMsg(DBM_ERROR_NO_RAID)
		end
		DBM:RequestInstanceInfo()
	elseif cmd:sub(1, 5) == "debug" then
		DBM.Options.DebugMode = DBM.Options.DebugMode == false and true or false
		DBM:AddMsg("DebugMode : " .. (DBM.Options.DebugMode and "on" or "off"))
	else
		DBM:LoadGUI()
	end
end

SLASH_DBMRANGE1 = "/range"
SLASH_DBMRANGE2 = "/distance"
SlashCmdList["DBMRANGE"] = function(msg)
	if DBM.RangeCheck:IsShown() then
		DBM.RangeCheck:Hide()
	else
		local r = tonumber(msg)
		if r and ((r == 10 or r == 11 or r == 15 or r == 28) or (DBM:GetMapSizes() and r < 31)) then
			DBM.RangeCheck:Show(r, nil, true)
		else
			DBM.RangeCheck:Show(10, nil, true)
		end
	end
end

do
	local sortMe = {}

	local function sort(v1, v2)
		if v1.revision and not v2.revision then
			return true
		elseif v2.revision and not v1.revision then
			return false
		elseif v1.revision and v2.revision then
			return v1.revision > v2.revision
		else
			return (v1.bwarevision or v1.bwrevision or 0) > (v2.bwarevision or v2.bwrevision or 0)
		end
	end

	function DBM:ShowVersions(notify)
		for i, v in pairs(raid) do
			tinsert(sortMe, v)
		end
		table.sort(sortMe, sort)
		self:AddMsg(DBM_CORE_VERSIONCHECK_HEADER)
		for i, v in ipairs(sortMe) do
			if v.displayVersion and not (v.bwrevision or v.bwarevision) then--DBM, no BigWigs
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(v.name, "DBM "..v.displayVersion, v.revision))
				if notify and v.revision < DBM.ReleaseRevision then
					SendChatMessage(chatPrefixShort..DBM_CORE_YOUR_VERSION_OUTDATED, "WHISPER", nil, v.name)
				end
			elseif v.displayVersion and (v.bwrevision or v.bwarevision) then--DBM & BigWigs
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_TWO:format(v.name, "DBM "..v.displayVersion, v.revision, v.bwarevision and DBM_BIG_WIGS_ALPHA or DBM_BIG_WIGS, v.bwarevision or v.bwrevision))
			elseif not v.displayVersion and (v.bwrevision or v.bwarevision) then--BigWigs, No DBM
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY:format(v.name, v.bwarevision and DBM_BIG_WIGS_ALPHA or DBM_BIG_WIGS, v.bwarevision or v.bwrevision))
			else
				self:AddMsg(DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM:format(v.name))
			end
		end
		local TotalUsers = #sortMe
		local NoDBM = 0
		local NoBigwigs = 0
		for i = #sortMe, 1, -1 do
			if not sortMe[i].revision then
				NoDBM = NoDBM + 1
			end
			if not (sortMe[i].bwarevision or sortMe[i].bwrevision) then
				NoBigwigs = NoBigwigs + 1
			end
		end
		local TotalDBM = TotalUsers - NoDBM
		local TotalBW = TotalUsers - NoBigwigs
		self:AddMsg(DBM_CORE_VERSIONCHECK_FOOTER:format(TotalDBM, TotalBW))
		for i = #sortMe, 1, -1 do
			sortMe[i] = nil
		end
	end
end

do
	local sortLag = {}
	local nolagResponse = {}
	local function sortit(v1, v2)
		return (v1.worldlag or 0) < (v2.worldlag or 0)
	end
	function DBM:ShowLag()
		for i, v in pairs(raid) do
			table.insert(sortLag, v)
		end
		table.sort(sortLag, sortit)
		self:AddMsg(DBM_CORE_LAG_HEADER)
		for i, v in ipairs(sortLag) do
			if v.worldlag then
				self:AddMsg(DBM_CORE_LAG_ENTRY:format(v.name, v.worldlag, v.homelag))
			else
				table.insert(nolagResponse, v.name)
			end
		end
		if #nolagResponse > 0 then
			DBM:AddMsg(DBM_CORE_LAG_FOOTER:format(table.concat(nolagResponse, ", ")))
			for i = #nolagResponse, 1, -1 do
				nolagResponse[i] = nil
			end
		end
		for i = #sortLag, 1, -1 do
			sortLag[i] = nil
		end
	end
end

-------------------
--  Pizza Timer  --
-------------------
do
	local ignore = {}
	function DBM:CreatePizzaTimer(time, text, broadcast, sender)
		if sender and ignore[sender] then return end
		text = text:sub(1, 16)
		text = text:gsub("%%t", UnitName("target") or "<no target>")
		self.Bars:CreateBar(time, text, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		if broadcast and self:GetRaidRank(playerName) >= 1 then
			sendSync("U", ("%s\t%s"):format(time, text))
		end
		if sender then self:ShowPizzaInfo(text, sender) end
	end

	function DBM:AddToPizzaIgnore(name)
		ignore[name] = true
	end
end

function DBM:ShowPizzaInfo(id, sender)
	if DBM.Options.ShowPizzaMessage then
		self:AddMsg(DBM_PIZZA_SYNC_INFO:format(sender, id))
	end
end

------------------
--  Hyperlinks  --
------------------
do
	local ignore, cancel
	local popuplevel = 0
	local function showPopupConfirmIgnore(ignore, cancel)
		local popup = CreateFrame("Frame", nil, UIParent)
		popup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = {left = 1, right = 1, top = 1, bottom = 1}}
		)
		popup:SetSize(500, 80)
		popup:SetPoint("TOP", UIParent, "TOP", 0, -200)
		popup:SetFrameStrata("DIALOG")
		popup:SetFrameLevel(popuplevel)
		popuplevel = popuplevel + 1

		local text = popup:CreateFontString()
		text:SetFontObject(ChatFontNormal)
		text:SetWidth(470)
		text:SetWordWrap(true)
		text:SetPoint("TOP", popup, "TOP", 0, -15)
		text:SetText(DBM_PIZZA_CONFIRM_IGNORE:format(ignore))

		local accept = CreateFrame("Button", nil, popup)
		accept:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		accept:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		accept:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		accept:SetSize(128, 35)
		accept:SetPoint("BOTTOM", popup, "BOTTOM", -75, 0)
		accept:SetScript("OnClick", function(f) DBM:AddToPizzaIgnore(ignore) DBM.Bars:CancelBar(cancel) f:GetParent():Hide() end)

		local atext = accept:CreateFontString()
		atext:SetFontObject(ChatFontNormal)
		atext:SetPoint("CENTER", accept, "CENTER", 0, 5)
		atext:SetText(YES)

		local decline = CreateFrame("Button", nil, popup)
		decline:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		decline:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		decline:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		decline:SetSize(128, 35)
		decline:SetPoint("BOTTOM", popup, "BOTTOM", 75, 0)
		decline:SetScript("OnClick", function(f) f:GetParent():Hide() end)

		local dtext = decline:CreateFontString()
		dtext:SetFontObject(ChatFontNormal)
		dtext:SetPoint("CENTER", decline, "CENTER", 0, 5)
		dtext:SetText(NO)
		PlaySound("igMainMenuOpen")
	end

	local function linkHook(self, link, string, button, ...)
		local linkType, arg1, arg2, arg3 = strsplit(":", link)
		if linkType ~= "DBM" then
			return
		end
		if arg1 == "cancel" then
			DBM.Bars:CancelBar(link:match("DBM:cancel:(.+):nil$"))
		elseif arg1 == "ignore" then
			cancel = link:match("DBM:ignore:(.+):[^%s:]+$")
			ignore = link:match(":([^:]+)$")
			showPopupConfirmIgnore(ignore, cancel)
		elseif arg1 == "update" then
			DBM:ShowUpdateReminder(arg2, arg3) -- displayVersion, revision
		elseif arg1 == "forums" then
			DBM:ShowUpdateReminder(nil, nil, DBM_FORUMS_COPY_URL_DIALOG)
		elseif arg1 == "showRaidIdResults" then
			DBM:ShowRaidIDRequestResults()
		end
	end

	DEFAULT_CHAT_FRAME:HookScript("OnHyperlinkClick", linkHook) -- handles the weird case that the default chat frame is not one of the normal chat frames (3rd party chat frames or whatever causes this)
	local i = 1
	while _G["ChatFrame" .. i] do
		if _G["ChatFrame" .. i] ~= DEFAULT_CHAT_FRAME then
			_G["ChatFrame" .. i]:HookScript("OnHyperlinkClick", linkHook)
		end
		i = i + 1
	end
end

do
	local old = ItemRefTooltip.SetHyperlink -- we have to hook this function since the default ChatFrame code assumes that all links except for player and channel links are valid arguments for this function
	function ItemRefTooltip:SetHyperlink(link, ...)
		if link:sub(0, 4) == "DBM:" then
			return
		end
		return old(self, link, ...)
	end
end


-----------------
--  GUI Stuff  --
-----------------
do
	local callOnLoad = {}
	function DBM:LoadGUI()
		if not IsAddOnLoaded("DBM-GUI") then
			local _, _, _, enabled = GetAddOnInfo("DBM-GUI")
			if not enabled then
				EnableAddOn("DBM-GUI")
			end
			local loaded, reason = LoadAddOn("DBM-GUI")
			if not loaded then
				if reason then
					self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(tostring(_G["ADDON_"..reason or ""])))
				else
					self:AddMsg(DBM_CORE_LOAD_GUI_ERROR:format(DBM_CORE_UNKNOWN))
				end
				return false
			end
			table.sort(callOnLoad, function(v1, v2) return v1[2] < v2[2] end)
			for i, v in ipairs(callOnLoad) do v[1]() end
			collectgarbage("collect")
		end
		return DBM_GUI:ShowHide()
	end

	function DBM:RegisterOnGuiLoadCallback(f, sort)
		tinsert(callOnLoad, {f, sort or mhuge})
	end
end


----------------------
--  Minimap Button  --
----------------------
do
	local dragMode = nil

	local function moveButton(self)
		if dragMode == "free" then
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", x, y)
		else
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			centerX, centerY = math.abs(x), math.abs(y)
			centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 80, (centerY / sqrt(centerX^2 + centerY^2)) * 80
			centerX = x < 0 and -centerX or centerX
			centerY = y < 0 and -centerY or centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", centerX, centerY)
		end
	end

	local button = CreateFrame("Button", "DBMMinimapButton", Minimap)
	button:SetHeight(32)
	button:SetWidth(32)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", -65.35, -38.8)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Up")
	button:SetPushedTexture("Interface\\AddOns\\DBM-Core\\textures\\Minimap-Button-Down")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	button:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and IsAltKeyDown() then
			dragMode = "free"
			self:SetScript("OnUpdate", moveButton)
		elseif IsShiftKeyDown() or button == "RightButton" then
			dragMode = nil
			self:SetScript("OnUpdate", moveButton)
		end
	end)
	button:SetScript("OnMouseUp", function(self)
		self:SetScript("OnUpdate", nil)
	end)
	button:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() or button == "RightButton" then return end
		DBM:LoadGUI()
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(DBM_CORE_MINIMAP_TOOLTIP_HEADER, 1, 1, 1)
		GameTooltip:AddLine(ver, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(DBM_CORE_MINIMAP_TOOLTIP_FOOTER, RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	function DBM:ToggleMinimapButton()
		self.Options.ShowMinimapButton = not self.Options.ShowMinimapButton
		if self.Options.ShowMinimapButton then
			button:Show()
		else
			button:Hide()
		end
	end

	function DBM:HideMinimapButton()
		return button:Hide()
	end
end

-------------------------------------------------
--  Raid/Party Handling and Unit ID Utilities  --
-------------------------------------------------
do
	local inRaid = false

	local raidUIds = {}
	local raidGuids = {}


	--	save playerinfo into raid table on load. (for solo raid)
	DBM:RegisterOnLoadCallback(function()
		DBM:Schedule(5, function()
			if not raid[playerName] then
				raid[playerName] = {}
				raid[playerName].name = playerName
				raid[playerName].shortname = playerName
				raid[playerName].guid = UnitGUID("player")
				raid[playerName].rank = 0
				raid[playerName].class = class
				raid[playerName].id = "player"
				raid[playerName].revision = DBM.Revision
				raid[playerName].version = tonumber(DBM.Version)
				raid[playerName].displayVersion = DBM.DisplayVersion
				raid[playerName].locale = GetLocale()
				raidUIds["player"] = playerName
				raidGuids[UnitGUID("player")] = playerName
			end
		end)
	end)

	local function updateAllRoster()
		if IsInRaid() then
			enableIcons = false
			local latestRevision = tonumber(DBM.Revision)
			if not inRaid then
				inRaid = true
				sendSync("H")
				SendAddonMessage("BigWigs", "VQ:0", IsPartyLFG() and "INSTANCE_CHAT" or "RAID")--Basically "H" to bigwigs. Tell Bigwigs users we joined raid. Send revision of 0 so bigwigs ignores revision but still replies with their version information
				DBM:Schedule(2, DBM.RequestTimers, DBM)
				DBM:Schedule(2, DBM.RoleCheck, DBM)
				fireEvent("raidJoin", playerName)
				if BigWigs and BigWigs.db.profile.raidicon and not DBM.Options.DontSetIcons then--Both DBM and bigwigs have raid icon marking turned on.
					DBM:AddMsg(DBM_CORE_BIGWIGS_ICON_CONFLICT)--Warn that one of them should be turned off to prevent conflict (which they turn off is obviously up to raid leaders preference, dbm accepts either ore turned off to stop this alert)
				end
			end
			for i = 1, GetNumGroupMembers() do
				local name, rank, subgroup, _, _, className = GetRaidRosterInfo(i)
				-- Maybe GetNumGroupMembers() bug? Seems that GetNumGroupMembers() rarely returns bad value, causing GetRaidRosterInfo() returns to nil.
				-- Filter name = nil to prevent nil table error.
				if name then
					local id = "raid" .. i
					local shortname = UnitName(id)
					if (not raid[name]) and inRaid then
						fireEvent("raidJoin", name)
					end
					raid[name] = raid[name] or {}
					raid[name].name = name
					raid[name].shortname = shortname
					raid[name].rank = rank
					raid[name].subgroup = subgroup
					raid[name].class = className
					raid[name].id = id
					raid[name].guid = UnitGUID(id) or ""
					raid[name].updated = true
					raidUIds[id] = name
					raidGuids[UnitGUID(id) or ""] = name
					--Something is wrong here, need to investigate. I watched MULTIPLE revisions OLDER than mine setting icons, revisions that HAVE this change. it is NOT disabling icons for revisions. I am seeing 5.2.3 release set icons when i have 5.2.4 alpha, even some 5.2.2 alphas setting icons when there is a 5.2.3 and 5.2.4 alpha in raid. this should not happen!
					--Maybe this improve wrong icon setting? (but, older verison also to be updated)
					if raid[name].revision and raid[name].revision > tonumber(DBM.Revision) then
						latestRevision = raid[name].revision
					end
				end
			end
			if latestRevision == tonumber(DBM.Revision) and DBM:GetRaidRank(playerName) > 0 then
				enableIcons = true
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raidUIds[v.id] = nil
					raidGuids[v.guid] = nil
					raid[i] = nil
					fireEvent("raidLeave", i)
				else
					v.updated = nil
				end
			end
		elseif IsInGroup() then
			if not inRaid then
				-- joined a new party
				inRaid = true
				sendSync("H")
				SendAddonMessage("BigWigs", "VQ:0", IsPartyLFG() and "INSTANCE_CHAT" or "PARTY")
				DBM:Schedule(2, DBM.RequestTimers, DBM)
				DBM:Schedule(2, DBM.RoleCheck, DBM)
				fireEvent("partyJoin", playerName)
			end
			for i = 0, GetNumSubgroupMembers() do
				local id
				if (i == 0) then
					id = "player"
				else
					id = "party"..i
				end
				local name, server = UnitName(id)
				local shortname = name
				local rank, _, className = UnitIsGroupLeader(id), UnitClass(id)
				if server and server ~= ""  then
					name = name.."-"..server
				end
				if (not raid[name]) and inRaid then
					fireEvent("partyJoin", name)
				end
				raid[name] = raid[name] or {}
				raid[name].name = name
				raid[name].shortname = shortname
				raid[name].guid = UnitGUID(id) or ""
				if rank then
					raid[name].rank = 2
				else
					raid[name].rank = 0
				end
				raid[name].class = className
				raid[name].id = id
				raid[name].updated = true
				raidUIds[id] = name
				raidGuids[UnitGUID(id) or ""] = name
			end
			for i, v in pairs(raid) do
				if not v.updated then
					raidUIds[v.id] = nil
					raidGuids[v.guid] = nil
					raid[i] = nil
					fireEvent("partyLeave", i)
				else
					v.updated = nil
				end
			end
		else
			-- left the current group/raid
			inRaid = false
			enableIcons = true
			fireEvent("raidLeave", playerName)
			twipe(raid)
			-- restore playerinfo into raid table on raidleave. (for solo raid)
			raid[playerName] = {}
			raid[playerName].name = playerName
			raid[playerName].shortname = playerName
			raid[playerName].guid = UnitGUID("player")
			raid[playerName].rank = 0
			raid[playerName].class = class
			raid[playerName].id = "player"
			raid[playerName].revision = DBM.Revision
			raid[playerName].version = tonumber(DBM.Version)
			raid[playerName].displayVersion = DBM.DisplayVersion
			raid[playerName].locale = GetLocale()
			raidUIds["player"] = playerName
			raidGuids[UnitGUID("player")] = playerName
		end
	end

	--This local function called if uId is not player's uId. (like target, raid1traget)
	local function getUnitFullName(uId)
		if not uId then return end
		local name, server = UnitName(uId)
		if not name then return end
		if server and server ~= ""  then
			name = name.."-"..server
		end
		return name
	end

	function DBM:GROUP_ROSTER_UPDATE()
		self:Schedule(1.5, updateAllRoster)
	end

	--Joined lfr during combat, many unit shows "Somewhat" and invisiable, and break class coloring temporarly. So update roster table again when unit name successfully updated.
	function DBM:UNIT_NAME_UPDATE_UNFILTERED()
		self:Unschedule(updateAllRoster)
		self:Schedule(1.5, updateAllRoster)
	end

	function DBM:GetRaidRank(name)
		local name = name or playerName
		if name == playerName then--If name is player, try to get actual rank. Because raid[name].rank sometimes seems returning 0 even player is promoted.
			return UnitIsGroupLeader("player") and 2 or UnitIsGroupAssistant("player") and 1 or 0
		else
			return (raid[name] and raid[name].rank) or 0
		end
	end

	function DBM:GetRaidSubgroup(name)
		return (raid[name] and raid[name].subgroup) or 0
	end

	function DBM:GetRaidClass(name)
		return (raid[name] and raid[name].class) or "UNKNOWN"
	end

	function DBM:GetRaidUnitId(name)
		return raid[name] and raid[name].id
	end

	function DBM:GetUnitFullName(uId)
		return raidUIds[uId] or getUnitFullName(uId)
	end

	function DBM:GetFullPlayerNameByGUID(guid)
		return raidGuids[guid]
	end

	function DBM:GetPlayerNameByGUID(guid)
		return raidGuids[guid] and raidGuids[guid]:gsub("%-.*$", "")
	end
end

do
	-- yes, we still do avoid memory allocations during fights; so we don't use a closure around a counter here
	-- this seems to be the easiest way to write an iterator that returns the unit id *string* as first argument without a memory allocation
	local function raidIterator(groupMembers, uId)
		local a, b = uId:byte(-2, -1)
		local i = (a >= 0x30 and a <= 0x39 and (a - 0x30) * 10 or 0) + b - 0x30
		if i < groupMembers then
			return "raid" .. i + 1, i + 1
		end
	end

	local function partyIterator(groupMembers, uId)
		if not uId then
			return "player", 0
		elseif uId == "player" then
			if groupMembers > 0 then
				return "party1", 1
			end
		else
			local i = uId:byte(-1) - 0x30
			if i < groupMembers then
				return "party" .. i + 1, i + 1
			end
		end
	end

	local function soloIterator(_, state)
		if not state then -- no state == first call
			return "player", 0
		end
	end

	-- returns the unit ids of all raid or party members, including the player's own id
	-- limitations: will break if there are ever raids with more than 99 players or partys with more than 10
	function DBM:GetGroupMembers()
		if IsInRaid() then
			return raidIterator, GetNumGroupMembers(), "raid0"
		elseif IsInGroup() then
			return partyIterator, GetNumSubgroupMembers(), nil
		else
			-- solo!
			return soloIterator, nil, nil
		end
	end
end

function DBM:GetNumGroupMembers()
	return IsInGroup() and GetNumGroupMembers() or 1
end

--For returning the number of players actually in zone with us for status functions
--This is very touchy though and will fail if everyone isn't in same SUB zone (ie same room/area)
--It should work for pretty much any case we'd use it though except maybe a fight like heroic LK? TODO: check this
function DBM:GetNumRealGroupMembers()
	if not IsInInstance() then--Not accurate outside of instances (such as world bosses)
		return IsInGroup() and GetNumGroupMembers() or 1--So just return regular group members.
	end
	SetMapToCurrentZone()
	local currentMapId = GetCurrentMapAreaID()
	local currentMapName = GetMapNameByID(currentMapId)
	local realGroupMembers = 0
	if IsInGroup() then
		for i = 1, GetNumGroupMembers() do
			if select(7, GetRaidRosterInfo(i)) == currentMapName then
				realGroupMembers = realGroupMembers + 1
			end
		end
	else
		return 1
	end
	return realGroupMembers
end

function DBM:GetBossUnitId(name)
	for i = 1, 5 do
		if UnitName("boss" .. i) == name then
			return "boss" .. i
		end
	end
	for uId in DBM:GetGroupMembers() do
		if UnitName(uId .. "target") == name and not UnitIsPlayer(uId .. "target") then
			return uId .. "target"
		end
	end
end

---------------
--  Options  --
---------------
do
	local function addDefaultOptions(t1, t2)
		for i, v in pairs(t2) do
			if t1[i] == nil then
				t1[i] = v
			elseif type(v) == "table" and type(t1[i]) == "table" then
				addDefaultOptions(t1[i], v)
			end
		end
	end

	local function setRaidWarningPositon()
		RaidWarningFrame:ClearAllPoints()
		RaidWarningFrame:SetPoint(DBM.Options.RaidWarningPosition.Point, UIParent, DBM.Options.RaidWarningPosition.Point, DBM.Options.RaidWarningPosition.X, DBM.Options.RaidWarningPosition.Y)
	end

	local function migrateSavedOptions()
		-- reset default special warning font for russian clients due to many reports of problems with cyrillic characters in special warnings
		if DBM.Options.LastRevision < 7998 then
			DBM.Options.LastRevision = DBM.Revision
			if GetLocale() == "ruRU" then
				DBM.Options.SpecialWarningFont = STANDARD_TEXT_FONT
			end
		end
	end

	local function fixsoundbug()
		local findsoundfile = false
		local finddefaultsoundfile = false
		if #DBM.Soundfile > 0 and DBM.Soundfile[#DBM.Soundfile].Path then
			for i = 1, #DBM.Soundfile do
				if DBM.Options.CountdownVoice == DBM.Soundfile[i].Path then
					findsoundfile = true							
				end
				if DBM.DefaultOptions.CountdownVoice == DBM.Soundfile[i].Path then
					finddefaultsoundfile = true							
				end
			end
			if not findsoundfile then
				if finddefaultsoundfile then
					DBM.Options.CountdownVoice = DBM.DefaultOptions.CountdownVoice
				else
					DBM.Options.CountdownVoice = DBM.Soundfile[#DBM.Soundfile].Path
				end
			end					
		end
	end
	
	function loadOptions()
		DBM.Options = DBM_SavedOptions
		enabled = DBM.Options.Enabled
		addDefaultOptions(DBM.Options, DBM.DefaultOptions)
		-- load special warning options
		migrateSavedOptions()
		DBM:Schedule(5, fixsoundbug)
		DBM:UpdateSpecialWarningOptions()
		-- set this with a short delay to prevent issues with other addons also trying to do the same thing with another position ;)
		DBM:Schedule(5, setRaidWarningPositon)
	end

	function loadModOptions(modId)
		local savedOptions = _G[modId:gsub("-", "").."_SavedVars"] or {}
		local savedStats = _G[modId:gsub("-", "").."_SavedStats"] or {}
		local existId = {}
		for i, v in ipairs(DBM.Mods) do
			if v.modId == modId then
				existId[v.id] = true
				-- import old options from mods that were using the encounter ID as number as id
				-- this was changed to use the string for compatibility reasons (see issues with sync),
				-- but a user might still have saved options or stats that still use the old id as number
				if tonumber(v.id) then
					local oldId = tonumber(v.id)
					if savedOptions[oldId] then
						savedOptions[v.id] = savedOptions[oldId]
						savedOptions[oldId] = nil
					end
					if savedStats[oldId] then
						savedStats[v.id] = savedStats[oldId]
						savedStats[oldId] = nil
					end
				end
				savedOptions[v.id] = savedOptions[v.id] or v.Options
				for option, optionValue in pairs(v.Options) do
					v.DefaultOptions[option] = optionValue
					if savedOptions[v.id][option] == nil then
						savedOptions[v.id][option] = optionValue
					end
				end
				--clean unused savedvariables
				for option, optionValue in pairs(savedOptions[v.id]) do
					if v.DefaultOptions[option] == nil then
						savedOptions[v.id][option] = nil
					end
				end
				v.Options = savedOptions[v.id] or {}
				savedStats[v.id] = savedStats[v.id] or {}
				local stats = savedStats[v.id]
				stats.normalKills = stats.normalKills or 0
				stats.normalPulls = stats.normalPulls or 0
				stats.heroicKills = stats.heroicKills or 0
				stats.heroicPulls = stats.heroicPulls or 0
				stats.challengeKills = stats.challengeKills or 0
				stats.challengePulls = stats.challengePulls or 0
				stats.flexKills = stats.flexKills or 0
				stats.flexPulls = stats.flexPulls or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Kills = stats.normal25Kills or 0
				stats.normal25Pulls = stats.normal25Pulls or 0
				stats.heroic25Kills = stats.heroic25Kills or 0
				stats.heroic25Pulls = stats.heroic25Pulls or 0
				stats.lfr25Kills = stats.lfr25Kills or 0
				stats.lfr25Pulls = stats.lfr25Pulls or 0
				v.stats = stats
				if v.OnInitialize then v:OnInitialize() end
				for i, cat in ipairs(v.categorySort) do -- temporary hack
					if cat == "misc" then
						tremove(v.categorySort, i)
						tinsert(v.categorySort, cat)
						break
					end
				end
			end
		end
		--clean unused savedvariables
		for id, table in pairs(savedOptions) do
			if existId[id] == nil then
				savedOptions[id] = nil
			end
		end
		for id, table in pairs(savedStats) do
			if existId[id] == nil then
				savedStats[id] = nil
			end
		end
		_G[modId:gsub("-", "").."_SavedVars"] = savedOptions
		_G[modId:gsub("-", "").."_SavedStats"] = savedStats
	end
end

local lastLFGAlert = 0
function DBM:LFG_ROLE_CHECK_SHOW()
	if not UnitIsGroupLeader("player") and DBM.Options.LFDEnhance and GetTime() - lastLFGAlert > 5 then
		PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
		lastLFGAlert = GetTime()
	end
end

function DBM:LFG_PROPOSAL_SHOW()
	DBM.Bars:CreateBar(40, DBM_LFG_INVITE, "Interface\\Icons\\Spell_Holy_BorrowedTime")
	if DBM.Options.LFDEnhance then
		PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
	end
end

function DBM:LFG_PROPOSAL_FAILED()
	DBM.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:LFG_PROPOSAL_SUCCEEDED()
	DBM.Bars:CancelBar(DBM_LFG_INVITE)
end

function DBM:ACTIVE_TALENT_GROUP_CHANGED()
	DBM:RoleCheck()
end

--BH ADD
function DBM:READY_CHECK()
	if DBM.Options.LFDEnhance then
		PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
	end
end
--ADD END

function DBM:PLAYER_REGEN_ENABLED()
	if loadDelay then
		DBM:LoadMod(loadDelay)
	end
	if loadDelay2 then
		DBM:LoadMod(loadDelay2)
	end
	if guiRequested and not IsAddOnLoaded("DBM-GUI") then
		guiRequested = false
		DBM:LoadGUI()
	end
end

function DBM:UPDATE_BATTLEFIELD_STATUS()
	for i = 1, 2 do
		if GetBattlefieldStatus(i) == "confirm" then
			queuedBattlefield[i] = select(2, GetBattlefieldStatus(i))
			DBM.Bars:CreateBar(85, queuedBattlefield[i], "Interface\\Icons\\Spell_Holy_BorrowedTime")	-- need to confirm the timer
			if DBM.Options.LFDEnhance then
				PlaySoundFile("Sound\\interface\\levelup2.ogg", "Master")--Because regular sound uses SFX channel which is too low of volume most of time
			end
		elseif queuedBattlefield[i] then
			DBM.Bars:CancelBar(queuedBattlefield[i])
			queuedBattlefield[i] = nil
		end
	end
end

--Loading routeens hacks for world bosses based on target or mouseover.
function DBM:UPDATE_MOUSEOVER_UNIT()
	if IsInInstance() or UnitIsDead("player") or UnitIsDead("mouseover") then return end--If you're in an instance no reason to waste cpu. If THE BOSS dead, no reason to load a mod for it. To prevent rare lua error, needed to filter on player dead.
	local guid = UnitGUID("mouseover")
	if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
		local cId = tonumber(guid:sub(6, 10), 16)
		for bosscId, addon in pairs(loadcIds) do
			local _, _, _, enabled = GetAddOnInfo(addon)
			if cId and bosscId and cId == bosscId and not IsAddOnLoaded(addon) and enabled then
				for i, v in ipairs(DBM.AddOns) do
					if v.modId == addon then
						self:LoadMod(v)
						break
					end
				end
			end
		end
	end
end

function DBM:UNIT_TARGET_UNFILTERED(uId)
	if IsInInstance() or not UnitIsFriend("player", uId) or UnitIsDead(uId.."target") then return end--If you're in an instance no reason to waste cpu. check only friend's target. If it's dead, no reason to load a mod for it.
	local guid = UnitGUID(uId.."target")
	if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
		local cId = tonumber(guid:sub(6, 10), 16)
		for bosscId, addon in pairs(loadcIds) do
			local _, _, _, enabled = GetAddOnInfo(addon)
			if cId and bosscId and cId == bosscId and not IsAddOnLoaded(addon) and enabled then
				for i, v in ipairs(DBM.AddOns) do
					if v.modId == addon then
						self:LoadMod(v)
						break
					end
				end
			end
		end
	end
end

function DBM:CINEMATIC_START()
	if DBM.Options.MovieFilter == "Never" then return end
	SetMapToCurrentZone()
	local _, _, _, _, _, _, _, currentMapID = GetInstanceInfo()
	for itemId, mapId in pairs(blockMovieSkipItems) do
		if mapId == currentMapID then
			if select(3, GetItemCooldown(itemId)) > 0 then return end
		end
	end
	local currentFloor = GetCurrentMapDungeonLevel() or 0
	if DBM.Options.MovieFilter == "Block" or DBM.Options.MovieFilter == "AfterFirst" and DBM.Options.MoviesSeen[currentMapID..currentFloor] then
		CinematicFrame_CancelCinematic()
	else
		DBM.Options.MoviesSeen[currentMapID..currentFloor] = true
	end
end

function DBM:LFG_COMPLETION_REWARD()
	if #inCombat > 0 and C_Scenario.IsInScenario() then
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if v.inScenario then
				self:EndCombat(v)
			end
		end
	end
end

function DBM:WORLD_STATE_TIMER_START()
	if DBM.Options.ChallengeBest == "None" or not C_Scenario.IsChallengeMode() then return end
	local maps = GetChallengeModeMapTable()
	local _, _, _, _, _, _, _, currentmapID = GetInstanceInfo()
	for i = 1, 9 do
		local _, mapID = GetChallengeModeMapInfo(maps[i])
		if currentmapID == mapID then
			local guildBest, realmBest = GetChallengeBestTime(mapID)
			local lastTime, bestTime, medal = GetChallengeModeMapPlayerStats(maps[i])
			if bestTime and DBM.Options.ChallengeBest == "Personal" then
				DBM.Bars:CreateBar(ceil(bestTime / 1000), DBM_SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			elseif guildBest and DBM.Options.ChallengeBest == "Guild" then
				DBM.Bars:CreateBar(ceil(guildBest / 1000), DBM_SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			elseif realmBest and DBM.Options.ChallengeBest == "Realm" then
				DBM.Bars:CreateBar(ceil(realmBest / 1000), DBM_SPEED_CLEAR_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
			end
		end
	end
end

function DBM:WORLD_STATE_TIMER_STOP()
	if (DBM.Options.ChallengeBest == "None") or not C_Scenario.IsChallengeMode() then return end
	if DBM.Bars:GetBar(DBM_SPEED_CLEAR_TIMER_TEXT) then
		DBM.Bars:CancelBar(DBM_SPEED_CLEAR_TIMER_TEXT)
	end
end

function DBM:GetCurrentArea()
	return LastInstanceMapID
end

--------------------------------
--  Load Boss Mods on Demand  --
--------------------------------
do
	local function FixForShittyComputers()
		local _, instanceType, _, _, _, _, _, mapID = GetInstanceInfo()
		LastInstanceMapID = mapID
		if instanceType == "none" and not forceloadmapIds[mapID] then return end
		-- You entered instance duing worldboss combat. Force end worldboss mod.
		if instanceType ~= "none" and savedDifficulty == "worldboss" then
			for i = #inCombat, 1, -1 do
				DBM:EndCombat(inCombat[i], true)
			end
		end
		-- LoadMod
		DBM:LoadModsOnDemand("mapId", mapID)
	end
	--Faster and more accurate loading for instances, but useless outside of them
	function DBM:LOADING_SCREEN_DISABLED()
		self:Schedule(1, FixForShittyComputers, DBM)
	end

	function DBM:LoadModsOnDemand(checkTable, checkValue)
		for i, v in ipairs(DBM.AddOns) do
			local modTable = v[checkTable]
			local _, _, _, enabled = GetAddOnInfo(v.modId)
			if enabled and not IsAddOnLoaded(v.modId) and modTable and checkEntry(modTable, checkValue) then
				self:LoadMod(v)
			end
		end
		DBM:ScenarioCheck()--Do not filter. Because ScenarioCheck function includes filter.
	end
end

--Scenario mods
function DBM:ScenarioCheck()
	if combatInfo[LastInstanceMapID] then
		for i, v in ipairs(combatInfo[LastInstanceMapID]) do
			if (v.type == "scenario") and checkEntry(v.msgs, LastInstanceMapID) then
				DBM:StartCombat(v.mod, 0, "LOADING_SCREEN_DISABLED")
			end
		end
	end
end

	--In combat and it's not a raid boss. We'll just delay mod load until we leave combat to avoid "script ran to long errors"
	--This should avoid most load problems (especially in LFR) When zoning in while in combat which causes the mod to fail to load/work correctly
	--IF we are fighting a boss, we don't have much of a choice but to try and load anyways since script ran too long isn't actually a guarentee.
	--The main place we should force a mod load in combat is for IsEncounterInProgress because i'm pretty sure blizzard waves "script ran too long" function for a small amount of time after a DC
	--Now that there are 9 world bosses, that mod is generating "script ran too long" more often on slow computers.
	--I had to remove world boss combat loading because of this. it's rare you engage boss before loading mod anyways.
function DBM:LoadMod(mod)
	if type(mod) ~= "table" then return false end
	if InCombatLockdown() and not IsEncounterInProgress() then
		if not loadDelay then--Prevent duplicate DBM_CORE_LOAD_MOD_COMBAT message.
			self:AddMsg(DBM_CORE_LOAD_MOD_COMBAT:format(tostring(mod.name)))
		end
		if loadDelay and loadDelay ~= mod then--Check if load delay exists, but make sure this isn't a loop of same mod before making a second load delay
			loadDelay2 = mod
		else
			loadDelay = mod
		end
		return
	end

	local loaded, reason = LoadAddOn(mod.modId)
	if not loaded then
		if reason then
			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), tostring(_G["ADDON_"..reason or ""])))
		else
--			self:AddMsg(DBM_CORE_LOAD_MOD_ERROR:format(tostring(mod.name), DBM_CORE_UNKNOWN)) -- wtf, this should never happen....(but it does happen sometimes if you reload your UI in an instance...)
		end
		return false
	else
		if DBM.Options.ShowLoadMessage then--Make load option optional for advanced users, option is NOT in the GUI.
			self:AddMsg(DBM_CORE_LOAD_MOD_SUCCESS:format(tostring(mod.name)))
		end
		loadModOptions(mod.modId)
		for i, v in ipairs(DBM.Mods) do -- load the hasHeroic/oneFormat attributes from the toc into all boss mods as required by the GetDifficulty() method
			if v.modId == mod.modId then
				v.type = mod.type
				v.oneFormat = mod.oneFormat
				v.hasLFR = mod.hasLFR
				v.hasFlex = mod.hasFlex
				v.hasChallenge = mod.hasChallenge
				v.noHeroic = mod.noHeroic
			end
		end
		if DBM_GUI then
			DBM_GUI:UpdateModList()
		end
		local _, instanceType, difficultyID, _, _, _, _, mapID = GetInstanceInfo()
		if difficultyID == 8 then
			RequestChallengeModeMapInfo()
			RequestChallengeModeLeaders(mapID)
		end
		if instanceType == "pvp" and IsAddOnLoaded("DBM-PvP") then--Is a battleground and pvp mods are installed
			if DBM:GetModByName("z30") and DBM:GetModByName("z30").revision >= 3 then--They are loaded and correct revision
				--Do nothing
			else--They either aren't loaded or are wrong revision. in either case, it means they have old pvp mods installed that don't load correctly or are out of date
				--Not the new stand alone pvp mods these are old ones and user needs to remove them or install updated package
--				self:AddMsg(DBM_CORE_OUTDATED_PVP_MODS)
			end
		elseif instanceType ~="pvp" and #inCombat == 0 and IsInGroup() then--do timer recovery only mod load
			local doRequest = false
			if IsEncounterInProgress() then
				doRequest = true
			else
				local uId = (IsInRaid() and "raid") or "party"
				for i = 0, GetNumGroupMembers() do
					local id = (i == 0 and "player") or uId..i
					if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
						doRequest = true
						break
					end
				end
			end
			if doRequest then
				-- Request timer to 3 person to prevent failure.
				DBM:Schedule(2, DBM.RequestTimers, DBM)
				DBM:Schedule(4, DBM.RequestTimers, DBM)
				DBM:Schedule(6, DBM.RequestTimers, DBM)
			end
		end
		if not InCombatLockdown() then--We loaded in combat because a raid boss was in process, but lets at least delay the garbage collect so at least load mod is half as bad, to do our best to avoid "script ran too long"
			collectgarbage("collect")
		end
		if loadDelay2 == mod then
			loadDelay2 = nil
		elseif loadDelay == mod then
			loadDelay = nil
		end
		return true
	end
end


local canSetIcons = {}
local iconSetRevision = {}
local iconSetPerson = {}
local addsGUIDs = {}

-----------------------------
--  Handle Incoming Syncs  --
-----------------------------
do
	local function checkForActualPull()
		if #inCombat == 0 then
			DBM:StopLogging()
		end
	end

	local function countDownTextDelay(timer)
		TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
	end

	local syncHandlers = {}
	local whisperSyncHandlers = {}

	-- DBM uses the following prefixes since 4.1 as pre-4.1 sync code is going to be incompatible anways, so this is the perfect opportunity to throw away the old and long names
	-- M = Mod
	-- C = Combat start
	-- IS = Icon set info
	-- K = Kill
	-- H = Hi!
	-- V = Incoming version information
	-- U = User Timer
	-- PT = Pull Timer (for sound effects, the timer itself is still sent as a normal timer)
	-- RT = Request Timers
	-- CI = Combat Info
	-- TI = Timer Info
	-- IR = Instance Info Request
	-- IRE = Instance Info Requested Ended/Canceled
	-- II = Instance Info

	syncHandlers["M"] = function(sender, mod, revision, event, ...)
		mod = DBM:GetModByName(mod or "")
		if mod and event and revision then
			revision = tonumber(revision) or 0
			mod:ReceiveSync(event, sender, revision, ...)
		end
	end

	syncHandlers["C"] = function(sender, delay, mod, modRevision, startHp, dbmRevision)
		if sender == playerName then return end
		local _, instanceType = GetInstanceInfo()
		if instanceType == "pvp" then return end
		if instanceType == "none" and (not UnitAffectingCombat("player") or #inCombat > 0) then return end--Ignore world boss pulls if you aren't fighting them. Also ignore world boss pull if already in combat.
		if not IsEncounterInProgress() and instanceType == "raid" and IsPartyLFG() then return end--Ignore syncs if we cannot validate IsEncounterInProgress as true
		local lag = select(4, GetNetStats()) / 1000
		delay = tonumber(delay or 0) or 0
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		dbmRevision = tonumber(dbmRevision or 0) or 0
		startHp = tonumber(startHp or -1) or -1
		if dbmRevision < 10481 then return end
		if mod and delay and (not mod.zones or mod.zones[LastInstanceMapID]) and (not mod.minSyncRevision or modRevision >= mod.minSyncRevision) then
			DBM:StartCombat(mod, delay + lag, "SYNC from - "..sender, true, startHp)
		end
	end

	syncHandlers["HF"] = function(sender, mod, modRevision)
		mod = DBM:GetModByName(mod or "")
		modRevision = tonumber(modRevision or 0) or 0
		if mod and (mod.revision < modRevision) then
			--TODO, maybe require at least 2 senders? this doesn't disable mod or make a popup though, just warn in chat that mod may have invalid timers/warnings do to a blizzard hotfix
			DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HOTFIX)
		end
	end

	syncHandlers["IS"] = function(sender, guid, ver, optionName)
		ver = tonumber(ver)
		if ver > (iconSetRevision[optionName] or 0) then--Save first synced version and person, ignore same version. refresh occurs only above version (fastest person)
			iconSetRevision[optionName] = ver
			iconSetPerson[optionName] = guid
		end
		if iconSetPerson[optionName] == UnitGUID("player") then--Check if that highest version was from ourself
			canSetIcons[optionName] = true
		else--Not from self, it means someone with a higher version than us probably sent it
			canSetIcons[optionName] = false
		end
	end

	syncHandlers["K"] = function(sender, cId)
		if select(2, IsInInstance()) == "pvp" then return end
		cId = tonumber(cId or "")
		if cId then DBM:OnMobKill(cId, true) end
	end

	local dummyMod -- dummy mod for the pull sound effect
	syncHandlers["PT"] = function(sender, timer, lastMapID)
		if select(2, IsInInstance()) == "pvp" or DBM:GetRaidRank(sender) == 0 or IsEncounterInProgress() then
			return
		end
		if (lastMapID and tonumber(lastMapID) ~= LastInstanceMapID) or (not lastMapID and DBM.Options.DontShowPTNoID) then return end
		timer = tonumber(timer or 0)
		if timer > 60 then
			return
		end
		if not dummyMod then
			dummyMod = DBM:NewMod("PullTimerCountdownDummy")
			DBM:GetModLocalization("PullTimerCountdownDummy"):SetGeneralLocalization{ name = DBM_CORE_MINIMAP_TOOLTIP_HEADER }
			dummyMod.countdown = dummyMod:NewCountdown(0, 0, nil, nil, nil, true)
			dummyMod.text = dummyMod:NewAnnounce("%s", 1, 2457)
		end
		--Cancel any existing pull timers before creating new ones, we don't want double countdowns or mismatching blizz countdown text (cause you can't call another one if one is in progress)
		if not DBM.Options.DontShowPT and DBM.Bars:GetBar(DBM_CORE_TIMER_PULL) then
			DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL)
		end
		if not DBM.Options.DontPlayPTCountdown then
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\com_go.mp3", "Master")
		end
		if not DBM.Options.DontShowPTCountdownText then
			DBM:Unschedule(countDownTextDelay)
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")--easiest way to nil out timers on TimerTracker frame. This frame just has no actual star/stop functions
		end
		dummyMod.text:Cancel()
		if timer == 0 then return DBM:AddMsg("<"..sender..">"..DBM_CORE_ANNOUNCE_PULL_CANCEL) end--"/dbm pull 0" will strictly be used to cancel the pull timer (which is w hy we let above part of code run but not below)
		if not DBM.Options.DontShowPT then
			DBM.Bars:CreateBar(timer, DBM_CORE_TIMER_PULL, "Interface\\Icons\\Spell_Holy_BorrowedTime")
		end
		if not DBM.Options.DontPlayPTCountdown then
			PlaySoundFile("Interface\\AddOns\\DBM-Core\\Sounds\\win.ogg", "Master")
			if timer > 5 then DBM:Schedule(timer-5, PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3", "Master") end
			if timer > 5 then DBM:Schedule(timer-4, PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3", "Master") end
			if timer > 3 then DBM:Schedule(timer-3, PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3", "Master") end
			if timer > 3 then DBM:Schedule(timer-2, PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3", "Master") end
			if timer > 3 then DBM:Schedule(timer-1, PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3", "Master") end
			if timer > 1 then DBM:Schedule(timer, PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\com_go.mp3", "Master") end
		end
		if not DBM.Options.DontShowPTCountdownText then
			local threshold = DBM.Options.PTCountThreshold
			if timer > threshold then
				DBM:Schedule(timer-threshold, countDownTextDelay, threshold)
			else
				TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
			end
		end
		if not DBM.Options.DontShowPTText then
			dummyMod.text:Show(DBM_CORE_ANNOUNCE_PULL:format(timer, sender))
			dummyMod.text:Schedule(timer, DBM_CORE_ANNOUNCE_PULL_NOW)
		end
		DBM:StartLogging(timer, checkForActualPull)
	end
	
	syncHandlers["CPT"] = function(sender)
		if select(2, IsInInstance()) == "pvp" or DBM:GetRaidRank(sender) == 0 or IsEncounterInProgress() then
			return
		end
		if not DBM.Options.DontShowPT and DBM.Bars:GetBar(DBM_CORE_TIMER_PULL) then
			DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL) 
		end
		dummyMod.text:Cancel()
		if not DBM.Options.DontPlayPTCountdown then
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3", "Master")
			DBM:Unschedule(PlaySoundFile, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\com_go.mp3", "Master")
		end
		if not DBM.Options.DontShowPTCountdownText then
			DBM:Unschedule(countDownTextDelay)
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")--easiest way to nil out timers on TimerTracker frame. This frame just has no actual star/stop functions
		end
		DBM:AddMsg("<"..sender..">"..DBM_CORE_ANNOUNCE_PULL_CANCEL)
	end
	
	local function SendVersion()
		sendSync("V", ("%d\t%s\t%s\t%s"):format(DBM.Revision, DBM.Version, DBM.DisplayVersion, GetLocale()))
	end

	-- TODO: is there a good reason that version information is broadcasted and not unicasted?
	syncHandlers["H"] = function(sender)
		DBM:Unschedule(SendVersion)--Throttle so we don't needlessly send tons of comms during initial raid invites
		DBM:Schedule(3, SendVersion)--Send version if 3 seconds have past since last "Hi" sync
	end

	syncHandlers["VR"] = function(sender, bwrevision)--Sent by bigwigs releases
		if bwrevision and raid[sender] then
			raid[sender].bwrevision = tonumber(bwrevision)
		end
	end

	syncHandlers["VRA"] = function(sender, bwarevision)--Sent by bigwigs Alphas
		if bwarevision and raid[sender] then
			raid[sender].bwarevision = tonumber(bwarevision)
		end
	end

	syncHandlers["V"] = function(sender, revision, version, displayVersion, locale)
		revision, version = tonumber(revision or ""), tonumber(version or "")
		if revision and version and displayVersion and raid[sender] then
			raid[sender].revision = revision
			raid[sender].version = version
			raid[sender].displayVersion = displayVersion
			raid[sender].locale = locale
			local revDifference = revision - tonumber(DBM.Revision)
			if version > tonumber(DBM.Version) then -- Update reminder
				--Old version of Bigwigs version faking breaks version update notification because they send alpha revision as release revision with their faking code
				--Bigwigs sniffs highest REVISION it finds in raid, (not highest ReleaseRevision) and then passes it as ReleaseRevision arg when sending sync back
				--As a result, we'll get a valid DisplayVersion but the highest alpha Revision bigwigs saw in raid roster as a sync.
				--For example, we might get 5.3.5 revision 10066 which is IMPOSSIBLE, anything above 10055 would be 5.3.6 alpha.
				--So below we fix these problems so our users don't get spammed with invalid update notifications do to BW sending bad version information
				if displayVersion == DBM.DisplayVersion or displayVersion == DBM.DisplayReleaseVersion then--Their version is higher than ours, but display version is same, ignore it.
					--Since we know their version information is crap, nil it out.
					raid[sender].revision = nil
					raid[sender].version = nil
					raid[sender].displayVersion = nil
					raid[sender].locale = nil
					DBM:GROUP_ROSTER_UPDATE()
					return
				end
				if not showedUpdateReminder then
					local found = false
					local secondfound = false
					local other = nil
					for i, v in pairs(raid) do
						if v.version == version and v ~= raid[sender] then
							if found then
								secondfound = true
								break
							end
							found = true
							other = i
						end
					end
					if found then--Only requires 2 for update notification (maybe also make 3?)
						showedUpdateReminder = true
						if not DBM.Options.BlockVersionUpdateNotice or revDifference > 333 then
							DBM:ShowUpdateReminder(displayVersion, version)
						else
							DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("([^\n]*)"))
							DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER:match("\n(.*)"):format(displayVersion, version))
							DBM:AddMsg(("|HDBM:update:%s:%s|h|cff3588ff[http://www.deadlybossmods.com]"):format(displayVersion, version))
						end
						--The following code requires at least THREE people to send that higher revision (I just upped it from 2). That should be more than adaquate, especially since there is also a display version validator now too (that had to be writen when bigwigs was sending bad revisions few versions back)
						if secondfound and revDifference > 400 then--WTF? Sorry but your DBM is being turned off until you update. Grossly out of date mods cause fps loss, freezes, lua error spam, or just very bad information, if mod is not up to date with latest changes. All around undesirable experience to put yourself or other raid mates through
							DBM:AddMsg(DBM_CORE_UPDATEREMINDER_DISABLE:format(revDifference))
							DBM:Disable(true)
						end
					end
				end
			end
			if revision > tonumber(DBM.Revision) then
				if raid[sender].rank >= 1 then
					enableIcons = false
				end
				if not showedUpdateReminder and DBM.DisplayVersion:find("alpha") and (revDifference > 20) then
					local found = false
					local other = nil
					for i, v in pairs(raid) do
						if v.revision == revision and v ~= raid[sender] then
							found = true
							other = i
							break
						end
					end
					if found then--Running alpha version that's out of date
						showedUpdateReminder = true
						DBM:AddMsg(DBM_CORE_UPDATEREMINDER_HEADER_ALPHA:format(revDifference))
					end
				end
			end
		end
		DBM:GROUP_ROSTER_UPDATE()
	end

	syncHandlers["L"] = function(sender)
		local _, _, home, world = GetNetStats()
		sendSync("LAG", ("%d\t%d"):format(home, world))
	end

	syncHandlers["LAG"] = function(sender, homelag, worldlag)
		homelag, worldlag = tonumber(homelag or ""), tonumber(worldlag or "")
		if homelag and worldlag and raid[sender] then
			raid[sender].homelag = homelag
			raid[sender].worldlag = worldlag
		end
	end

	syncHandlers["U"] = function(sender, time, text)
		if select(2, IsInInstance()) == "pvp" then return end -- no pizza timers in battlegrounds
		if DBM:GetRaidRank(sender) == 0 then return end
		if sender == playerName then return end
		time = tonumber(time or 0)
		text = tostring(text)
		if time and text then
			DBM:CreatePizzaTimer(time, text, nil, sender)
		end
	end

	-- beware, ugly and missplaced code ahead
	-- todo: move this somewhere else
	do
		local accessList = {}
		local savedSender

		local inspopup = CreateFrame("Frame", "DBMPopupLockout", UIParent)
		inspopup:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = {left = 1, right = 1, top = 1, bottom = 1}}
		)
		inspopup:SetSize(500, 120)
		inspopup:SetPoint("TOP", UIParent, "TOP", 0, -200)
		inspopup:SetFrameStrata("DIALOG")

		local inspopuptext = inspopup:CreateFontString()
		inspopuptext:SetFontObject(ChatFontNormal)
		inspopuptext:SetWidth(470)
		inspopuptext:SetWordWrap(true)
		inspopuptext:SetPoint("TOP", inspopup, "TOP", 0, -15)

		local buttonaccept = CreateFrame("Button", nil, inspopup)
		buttonaccept:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		buttonaccept:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		buttonaccept:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		buttonaccept:SetSize(128, 35)
		buttonaccept:SetPoint("BOTTOM", inspopup, "BOTTOM", -75, 0)

		local buttonatext = buttonaccept:CreateFontString()
		buttonatext:SetFontObject(ChatFontNormal)
		buttonatext:SetPoint("CENTER", buttonaccept, "CENTER", 0, 5)
		buttonatext:SetText(YES)

		local buttondecline = CreateFrame("Button", nil, inspopup)
		buttondecline:SetNormalTexture("Interface\\Buttons\\UI-DialogBox-Button-Up")
		buttondecline:SetPushedTexture("Interface\\Buttons\\UI-DialogBox-Button-Down")
		buttondecline:SetHighlightTexture("Interface\\Buttons\\UI-DialogBox-Button-Highlight", "ADD")
		buttondecline:SetSize(128, 35)
		buttondecline:SetPoint("BOTTOM", inspopup, "BOTTOM", 75, 0)

		local buttondtext = buttondecline:CreateFontString()
		buttondtext:SetFontObject(ChatFontNormal)
		buttondtext:SetPoint("CENTER", buttondecline, "CENTER", 0, 5)
		buttondtext:SetText(NO)

		inspopup:Hide()

		local function autoDecline(sender, force)
			inspopup:Hide()
			savedSender = nil
			if force then
				SendAddonMessage("D4", "II\t" .. "denied", "WHISPER", sender)
			else
				SendAddonMessage("D4", "II\t" .. "timeout", "WHISPER", sender)
			end
		end

		local function showPopupInstanceIdPermission(sender)
			DBM:Unschedule(autoDecline)
			DBM:Schedule(59, autoDecline, sender)
			inspopup:Hide()
			if savedSender ~= sender then
				if savedSender then
					autoDecline(savedSender, 1) -- Do not allow multiple popups, so auto decline to previous sender.
				end
				savedSender = sender
			end
			inspopuptext:SetText(DBM_REQ_INSTANCE_ID_PERMISSION:format(sender, sender))
			buttonaccept:SetScript("OnClick", function(f) savedSender = nil DBM:Unschedule(autoDecline) accessList[sender] = true syncHandlers["IR"](sender) f:GetParent():Hide() end)
			buttondecline:SetScript("OnClick", function(f) autoDecline(sender, 1) end)
			PlaySound("igMainMenuOpen")
			inspopup:Show()
		end

		syncHandlers["IR"] = function(sender)
			if DBM:GetRaidRank(sender) == 0 or sender == playerName then
				return
			end
			accessList = accessList or {}
			if not accessList[sender] then
				-- ask for permission
				showPopupInstanceIdPermission(sender)
				return
			end
			-- okay, send data
			local sentData = false
			for i = 1, GetNumSavedInstances() do
				local name, id, _, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, _, _, progress = GetSavedInstanceInfo(i)
				local longId = ("%x%x"):format(instanceIDMostSig, id) -- used as unique id by then default UI, so it's probably the "real" id
				if (locked or extended) and isRaid then -- only report locked raid instances
					SendAddonMessage("D4", "II\tData\t" .. name .. "\t" .. longId .. "\t" .. difficulty .. "\t" .. maxPlayers .. "\t" .. (progress or 0), "WHISPER", sender)
					sentData = true
				end
			end
			if not sentData then
				-- send something even if there is nothing to report so the receiver is able to tell you apart from someone who just didn't respond...
				SendAddonMessage("D4", "II\tNoData", "WHISPER", sender)
			end
		end

		syncHandlers["IRE"] = function(sender)
			local popup = inspopup:IsShown()
			if popup and savedSender == sender then -- found the popup with the correct data
				savedSender = nil
				DBM:Unschedule(autoDecline)
				inspopup:Hide()
			end
		end

		local lastRequest = 0
		local numResponses = 0
		local expectedResponses = 0
		local allResponded = false
		local results

		local updateInstanceInfo, showResults

		whisperSyncHandlers["II"] = function(sender, result, name, id, diff, maxPlayers, progress)
			if GetTime() - lastRequest > 62 or not results then
				return
			end
			if not result then
				return
			end
			name = name or "Unknown"
			id = id or ""
			diff = tonumber(diff or 0) or 0
			maxPlayers = tonumber(maxPlayers or 0) or 0
			progress = tonumber(progress or 0) or 0

			-- count responses
			if not results.responses[sender] then
				results.responses[sender] = result
				numResponses = numResponses + 1
			end

			if result == "Data" then
				-- got data in that response and not just a "no" or "i'm away"
				local instanceId = name.." "..maxPlayers.." "..diff -- locale-dependant dungeon ID
				results.data[instanceId] = results.data[instanceId] or {
					ids = {}, -- array of all ids of all raid members
					name = name,
					diff = diff,
					maxPlayers = maxPlayers,
				}
				results.data[instanceId].ids[id] = results.data[instanceId].ids[id] or { progress = progress }
				tinsert(results.data[instanceId].ids[id], sender)
			end

			if numResponses >= expectedResponses then -- unlikely, lol
				DBM:Unschedule(updateInstanceInfo)
				DBM:Unschedule(showResults)
				if not allResponded then --Only display message once in case we get for example 4 syncs the last sender
					DBM:Schedule(0.99, DBM.AddMsg, DBM, DBM_INSTANCE_INFO_ALL_RESPONSES)
					allResponded = true
				end
				DBM:Schedule(1, showResults) --Delay results so we allow time for same sender to send more than 1 lockout, otherwise, if we get expectedResponses before all data is sent from 1 user, we clip some of their data.
			end
		end

		function showResults()
			-- TODO: you could catch some localized instances by observing IDs if there are multiple players with the same instance ID but a different name ;) (not that useful if you are trying to get a fresh instance)
			DBM:AddMsg(DBM_INSTANCE_INFO_RESULTS)
			for i, v in pairs(results.data) do
				DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_HEADER:format(v.name, v.maxPlayers, v.diff))
				for id, v in pairs(v.ids) do
					DBM:AddMsg(DBM_INSTANCE_INFO_DETAIL_INSTANCE:format(id, v.progress, table.concat(v, ", ")))
				end
			end
			local denied = {}
			local away = {}
			local noResponse = {}
			for i = 1, GetNumGroupMembers() do
				if not UnitIsUnit("raid"..i, "player") then
					tinsert(noResponse, (GetRaidRosterInfo(i)))
				end
			end
			for i, v in pairs(results.responses) do
				if v == "Data" or v == "NoData" then
				elseif v == "timeout" then
					tinsert(away, i)
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					tinsert(denied, i)
				end
				removeEntry(noResponse, i)
			end
			if #denied > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_DENIED:format(table.concat(denied, ", ")))
			end
			if #away > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_AWAY:format(table.concat(away, ", ")))
			end
			if #noResponse > 0 then
				DBM:AddMsg(DBM_INSTANCE_INFO_STATS_NO_RESPONSE:format(table.concat(noResponse, ", ")))
			end
			results = nil
		end

		-- called when the chat link is clicked
		function DBM:ShowRaidIDRequestResults()
			if not results then -- check if we are currently querying raid IDs, results will be nil if we don't
				return
			end
			self:Unschedule(updateInstanceInfo)
			self:Unschedule(showResults)
			showResults() -- sets results to nil after the results are displayed, ending the current id request; future incoming data will be discarded
			sendSync("IRE")
		end

		local function getResponseStats()
			local numResponses = 0
			local sent = 0
			local denied = 0
			local away = 0
			for k, v in pairs(results.responses) do
				numResponses = numResponses + 1
				if v == "Data" or v == "NoData" then
					sent = sent + 1
				elseif v == "timeout" then
					away = away + 1
				else -- could be "clicked" or "override", in both cases we don't get the data because the dialog requesting it was dismissed
					denied = denied + 1
				end
			end
			return numResponses, sent, denied, away
		end

		local function getNumDBMUsers() -- without ourselves
			local r = 0
			for i, v in pairs(raid) do
				if v.revision and v.name ~= playerName and UnitIsConnected(DBM:GetRaidUnitId(v.name)) then
					r = r + 1
				end
			end
			return r
		end

		function updateInstanceInfo(timeRemaining, dontAddShowResultNowButton)
			local numResponses, sent, denied, away = getResponseStats()
			local dbmUsers = getNumDBMUsers()
			DBM:AddMsg(DBM_INSTANCE_INFO_STATUS_UPDATE:format(numResponses, dbmUsers, sent, denied, timeRemaining))
			if not dontAddShowResultNowButton then
				if dbmUsers - numResponses <= 7 then -- waiting for 7 or less players, show their names and the early result option
					-- copied from above, todo: implement a smarter way of keeping track of stuff like this
					local noResponse = {}
					for i = 1, GetNumGroupMembers() do
						if not UnitIsUnit("raid"..i, "player") and raid[GetRaidRosterInfo(i)] and raid[GetRaidRosterInfo(i)].revision then -- only show players who actually can respond (== DBM users)
							tinsert(noResponse, (GetRaidRosterInfo(i)))
						end
					end
					for i, v in pairs(results.responses) do
						removeEntry(noResponse, i)
					end

					--[[
					-- this looked like the easiest way (for some reason?) to create the player string when writing this code -.-
					local function dup(...) if select("#", ...) == 0 then return else return ..., ..., dup(select(2, ...)) end end
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(("|Hplayer:%s|h[%s]|h| "):rep(#noResponse):format(dup(unpack(noResponse)))))
					]]
					-- code that one can actually read
					for i, v in ipairs(noResponse) do
						noResponse[i] = ("|Hplayer:%s|h[%s]|h|"):format(v, v)
					end
					DBM:AddMsg(DBM_INSTANCE_INFO_SHOW_RESULTS:format(table.concat(noResponse, ", ")))
				end
			end
		end

		function DBM:RequestInstanceInfo()
			self:AddMsg(DBM_INSTANCE_INFO_REQUESTED)
			lastRequest = GetTime()
			allResponded = false
			results = {
				responses = { -- who responded to our request?
				},
				data = { -- the actual data
				}
			}
			numResponses = 0
			expectedResponses = getNumDBMUsers()
			sendSync("IR")
			self:Unschedule(updateInstanceInfo)
			self:Unschedule(showResults)
			self:Schedule(17, updateInstanceInfo, 45, true)
			self:Schedule(32, updateInstanceInfo, 30)
			self:Schedule(48, updateInstanceInfo, 15)
			self:Schedule(62, showResults)
		end
	end

	whisperSyncHandlers["RT"] = function(sender)
		DBM:SendTimers(sender)
	end

	whisperSyncHandlers["CI"] = function(sender, mod, time, isIEEU)
		mod = DBM:GetModByName(mod or "")
		time = tonumber(time or 0)
		if mod and time then
			DBM:ReceiveCombatInfo(sender, mod, time, isIEEU)
		end
	end

	whisperSyncHandlers["TI"] = function(sender, mod, timeLeft, totalTime, id, ...)
		mod = DBM:GetModByName(mod or "")
		timeLeft = tonumber(timeLeft or 0)
		totalTime = tonumber(totalTime or 0)
		if mod and timeLeft and timeLeft > 0 and totalTime and totalTime > 0 and id then
			DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		end
	end

	local function handleSync(channel, sender, prefix, ...)
		if not prefix then
			return
		end
		local handler
		if channel == "WHISPER" then -- separate between broadcast and unicast, broadcast must not be sent as unicast or vice-versa
			handler = whisperSyncHandlers[prefix]
		else
			handler = syncHandlers[prefix]
		end
		if handler then
			return handler(sender, ...)
		end
	end

	function DBM:CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if prefix == "D4" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT" or channel == "WHISPER" or channel == "GUILD") then
			sender = Ambiguate(sender, "none")
			handleSync(channel, sender, strsplit("\t", msg))
		elseif prefix == "BigWigs" and msg and (channel == "PARTY" or channel == "RAID" or channel == "INSTANCE_CHAT" or channel == "WHISPER" and self:GetRaidUnitId(sender)) then
			sender = Ambiguate(sender, "none")
			local bwPrefix, bwMsg = msg:match("^(%u-):(.+)")
			if bwPrefix and (bwPrefix == "VR" or bwPrefix == "VRA") then--We only care about version prefixes so only pass those prefixes on
				handleSync(channel, sender, bwPrefix, bwMsg)
			end
		end
	end
	
	function DBM:BN_CHAT_MSG_ADDON(prefix, msg, channel, sender)
		if prefix == "D4" and msg then
			handleSync(channel, sender, strsplit("\t", msg))
		end
	end
end

-----------------------
--  Update Reminder  --
-----------------------
do
	local frame, fontstring, fontstringFooter

	local function createFrame()
		frame = CreateFrame("Frame", nil, UIParent)
		frame:SetFrameStrata("FULLSCREEN_DIALOG") -- yes, this isn't a fullscreen dialog, but I want it to be in front of other DIALOG frames (like DBM GUI which might open this frame...)
		frame:SetWidth(430)
		frame:SetHeight(140)
		frame:SetPoint("TOP", 0, -230)
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
			insets = {left = 11, right = 12, top = 12, bottom = 11},
		})
		fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstring:SetWidth(410)
		fontstring:SetHeight(0)
		fontstring:SetPoint("TOP", 0, -16)
		local editBox = CreateFrame("EditBox", nil, frame)
		do
			local editBoxLeft = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxRight = editBox:CreateTexture(nil, "BACKGROUND")
			local editBoxMiddle = editBox:CreateTexture(nil, "BACKGROUND")
			editBoxLeft:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Left")
			editBoxLeft:SetHeight(32)
			editBoxLeft:SetWidth(32)
			editBoxLeft:SetPoint("LEFT", -14, 0)
			editBoxLeft:SetTexCoord(0, 0.125, 0, 1)
			editBoxRight:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
			editBoxRight:SetHeight(32)
			editBoxRight:SetWidth(32)
			editBoxRight:SetPoint("RIGHT", 6, 0)
			editBoxRight:SetTexCoord(0.875, 1, 0, 1)
			editBoxMiddle:SetTexture("Interface\\ChatFrame\\UI-ChatInputBorder-Right")
			editBoxMiddle:SetHeight(32)
			editBoxMiddle:SetWidth(1)
			editBoxMiddle:SetPoint("LEFT", editBoxLeft, "RIGHT")
			editBoxMiddle:SetPoint("RIGHT", editBoxRight, "LEFT")
			editBoxMiddle:SetTexCoord(0, 0.9375, 0, 1)
		end
		editBox:SetHeight(32)
		editBox:SetWidth(350)
		editBox:SetPoint("TOP", fontstring, "BOTTOM", 0, -4)
		editBox:SetFontObject("GameFontHighlight")
		editBox:SetTextInsets(0, 0, 0, 1)
		editBox:SetFocus()
		editBox:SetText("http://bbs.ngacn.cc/read.php?tid=5397726&page=1")
		editBox:HighlightText()
		editBox:SetScript("OnTextChanged", function(self)
			editBox:SetText("http://bbs.ngacn.cc/read.php?tid=5397726&page=1")
			editBox:HighlightText()
		end)
		fontstringFooter = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstringFooter:SetWidth(410)
		fontstringFooter:SetHeight(0)
		fontstringFooter:SetPoint("TOP", editBox, "BOTTOM", 0, 0)
		local button = CreateFrame("Button", nil, frame)
		button:SetHeight(24)
		button:SetWidth(75)
		button:SetPoint("BOTTOM", 0, 13)
		button:SetNormalFontObject("GameFontNormal")
		button:SetHighlightFontObject("GameFontHighlight")
		button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button:SetText(OKAY)
		button:SetScript("OnClick", function(self)
			frame:Hide()
		end)

	end

	function DBM:ShowUpdateReminder(newVersion, newRevision, text)
		if not frame then
			createFrame()
		end
		frame:Show()
		if newVersion then
			fontstring:SetText(DBM_CORE_UPDATEREMINDER_HEADER:format(newVersion, newRevision))
			fontstringFooter:SetText(DBM_CORE_UPDATEREMINDER_FOOTER)
		elseif text then
			fontstring:SetText(text)
			fontstringFooter:SetText(DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC)
		end
	end
end

do
	local frame, fontstringHeader, fontstring, fontstringFooter
	
	local function createFrame()
		frame = CreateFrame("Frame", nil, UIParent)
		frame:SetMovable(true)
		frame:SetFrameStrata("HIGH")
		frame:SetWidth(430)		
		frame:SetHeight(500)
		frame:SetPoint("TOP", 0, -230)
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
			insets = {left = 11, right = 12, top = 12, bottom = 11},
		})
		fontstringHeader = frame:CreateFontString(nil, "ARTWORK", "ZoneTextFont")
		fontstringHeader:SetWidth(410)
		fontstringHeader:SetHeight(0)
		fontstringHeader:SetPoint("TOP", 0, -16)
		
		fontstring = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")		
		fontstring:SetWidth(410)
		fontstring:SetHeight(0)
		fontstring:SetJustifyH("LEFT");
		fontstring:SetPoint("TOP", fontstringHeader, "BOTTOM", 0, -20)
		
		fontstringFooter = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		fontstringFooter:SetWidth(410)
		fontstringFooter:SetHeight(0)
		fontstringFooter:SetPoint("TOP", fontstring, "BOTTOM", 0, -30)
		local button = CreateFrame("Button", nil, frame)
		button:SetHeight(24)
		button:SetWidth(75)
		button:SetPoint("BOTTOM", 0, 35)
		button:SetNormalFontObject("GameFontNormal")
		button:SetHighlightFontObject("GameFontHighlight")
		button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button:SetText(OKAY)
		button:SetScript("OnClick", function(self)
			frame:Hide()
			DBM:LoadGUI()
		end)
	end

	function DBM:ShowGuildAD()
		if not frame then
			createFrame()
		end
		frame:Show()
		fontstringHeader:SetText(DBM_CORE_GUILDAD_HEADER_GENERIC)
		fontstring:SetText(DBM_CORE_GUILDAD_GENERIC)
		fontstringFooter:SetText(DBM_CORE_GUILDAD_FOOTER_GENERIC)
	end
end

do
	local frame, fontstringHeader, fontstring, Grilpic
	local fframe = false
	
	local function createFrame()
		frame = CreateFrame("Frame", nil, UIParent)
		frame:EnableMouse(true)
		frame:SetMovable(true)
		frame:SetFrameStrata("FULLSCREEN")
		frame:SetWidth(400)		
		frame:SetHeight(200)
		frame:SetPoint("BOTTOMRIGHT", -410, 300)
		frame:SetBackdrop({
			bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
			edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
			insets = {left = 10, right = 10, top = 10, bottom = 10},
		})
		
		frame:SetScript("OnMouseDown", function(self)
			frame:StartMoving()
		end)
		frame:SetScript("OnMouseUp", function(self)
			frame:StopMovingOrSizing()
		end)
					
		Grilpic = frame:CreateTexture( nil, "ARTWORK" )
		Grilpic:SetPoint( "TOPLEFT", 10, -10 )
		Grilpic:SetPoint( "BOTTOMRIGHT", -10, 10 )	
		Grilpic:SetTexCoord(0, 2, 0, 1)
		Grilpic:SetTexture( [[Interface\AddOns\DBM-Core\textures\soundgrils\pic.tga]] )
		
		fontstringHeader = frame:CreateFontString(nil, "ARTWORK", "ZoneTextFont")
		fontstringHeader:SetWidth(410)
		fontstringHeader:SetHeight(0)
		fontstringHeader:SetPoint("TOP", 80, -26)
		fontstringHeader:SetText(DBM_CORE_SOUND_NOFILE)
		
		fontstring = frame:CreateFontString(nil, "ARTWORK", "SystemFont_Tiny")	
		fontstring:SetWidth(200)
		fontstring:SetHeight(0)
		fontstring:SetJustifyH("LEFT")
		fontstring:SetFont(STANDARD_TEXT_FONT, 15, "")
		fontstring:SetTextColor(0.62, 0.32, 0.17, 1)
		fontstring:SetPoint("TOP", fontstringHeader, "BOTTOM", 0, -20)
		fontstring:SetText("       "..DBM_CORE_SOUND_NOFILEUSAGE)
		
		local button = CreateFrame("Button", nil, frame)
		button:SetHeight(15)
		button:SetWidth(20)
		button:SetPoint("TOPRIGHT", -8, -8)
		button:SetNormalFontObject("GameFontNormal")
		button:SetHighlightFontObject("GameFontHighlight")
		button:SetNormalTexture(button:CreateTexture(nil, nil, "UIPanelButtonUpTexture"))
		button:SetPushedTexture(button:CreateTexture(nil, nil, "UIPanelButtonDownTexture"))
		button:SetHighlightTexture(button:CreateTexture(nil, nil, "UIPanelButtonHighlightTexture"))
		button:SetText("x")
		button:SetScript("OnClick", function(self)
			frame:Hide()
		end)
	end

	function DBM:ShowSoundMM()
		if not frame then
			createFrame()
			frame:Show()
		end
		if frame:IsShown() and fframe then
			frame:Hide()
		else
			frame:Show()
			fframe = true
		end		
		if #DBM.Soundfile > 0 and DBM.Soundfile[#DBM.Soundfile].Path then
			for i = 1, #DBM.Soundfile do
				if DBM.Soundfile[i].Path == DBM.Options.CountdownVoice then
					if DBM.Soundfile[i].Name then
						fontstringHeader:SetText(DBM.Soundfile[i].Name)
					else
						fontstringHeader:SetText(DBM_CORE_SOUND_UNNAME)
					end
					if DBM.Soundfile[i].Usage then
						fontstring:SetText("       "..DBM.Soundfile[i].Usage)
					else
						fontstring:SetText("       "..DBM_CORE_SOUND_UNUSAGE)
					end
					if DBM.Soundfile[i].hasPic then
						Grilpic:SetTexture("Interface\\Addons\\"..DBM.Soundfile[i].Addon.."\\"..DBM.Soundfile[i].Tag..".tga")
					else
						Grilpic:SetTexture( [[Interface\AddOns\DBM-Core\textures\soundgrils\pic.tga]] )
					end					
				end
			end
		end
	end
end

----------------------
--  Pull Detection  --
----------------------
do
	local targetList = {}
	local function buildTargetList()
		local uId = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local id = (i == 0 and "target") or uId..i.."target"
			local guid = UnitGUID(id)
			if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
				local cId = tonumber(guid:sub(6, 10), 16)
				targetList[cId] = id
			end
		end
	end

	local function clearTargetList()
		twipe(targetList)
	end

	local function scanForCombat(mod, mob, delay)
		if not checkEntry(inCombat, mod) then
			buildTargetList()
			if targetList[mob] then
				if delay > 0 and UnitAffectingCombat(targetList[mob]) then
					DBM:StartCombat(mod, delay, "PLAYER_TARGET")
				elseif (delay == 0) and select(2, GetInstanceInfo()) == "none" then
					DBM:StartCombat(mod, 0, "PLAYER_TARGET_AND_YELL")
				end
			end
			clearTargetList()
		end
	end


	local function checkForPull(mob, combatInfo)
		DBM:Schedule(0.5, scanForCombat, combatInfo.mod, mob, 0.5)
		DBM:Schedule(2, scanForCombat, combatInfo.mod, mob, 2)
		DBM:Schedule(2.1, function()
			healthCombatInitialized = true
		end)
	end

	-- TODO: fix the duplicate code that was added for quick & dirty support of zone IDs

	-- detects a boss pull based on combat state, this is required for pre-ICC bosses that do not fire INSTANCE_ENCOUNTER_ENGAGE_UNIT events on engage
	function DBM:PLAYER_REGEN_DISABLED()
		lastCombatStarted = GetTime()
		healthCombatInitialized = false
		if not combatInitialized then return end
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type == "combat" or v.type == "combat_yell" or v.type == "combat_emote" or v.type == "combat_say" then--this will be faster than string.find
					if v.multiMobPullDetection then
						for _, mob in ipairs(v.multiMobPullDetection) do
							if checkForPull(mob, v) then
								break
							end
						end
					else
						checkForPull(v.mob, v)
					end
				end
			end
		end
	end

	local function isBossEngaged(cId)
		-- note that this is designed to work with any number of bosses, but it might be sufficient to check the first 5 unit ids
		-- TODO: check if the client supports more than 5 boss unit IDs...just because the default boss health frame is limited to 5 doesn't mean there can't be more
		local i = 1
		repeat
			local bossUnitId = "boss"..i
			local bossExists = UnitExists(bossUnitId)
			local bossGUID = bossExists and not UnitIsDead(bossUnitId) and UnitGUID(bossUnitId) -- check for UnitIsVisible maybe?
			local bossCId = bossGUID and tonumber(bossGUID:sub(6, 10), 16)
			if bossCId and (type(cId) == "number" and cId == bossCId or type(cId) == "table" and checkEntry(cId, bossCId)) then
				return true
			end
			i = i + 1
		until not bossExists
	end

	function DBM:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type == "combat" and isBossEngaged(v.multiMobPullDetection or v.mob) then
					self:StartCombat(v.mod, 0, "IEEU")
				end
			end
		end
	end
	
	function DBM:ENCOUNTER_START(encounterID, name, difficulty, size)
		if DBM.Options.DebugMode then
			print("ENCOUNTER_START EVENT Fired", encounterID, name, difficulty, size)
		end
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.multiEncounterPullDetection then
					for _, encounter in ipairs(v.multiEncounterPullDetection) do
						if encounterID == encounter then
							self:StartCombat(v.mod, 0, "ENCOUNTER_START")
							return
						end
					end
				elseif encounterID == v.encounter then
					self:StartCombat(v.mod, 0, "ENCOUNTER_START")
					return
				end
			end
		end
	end
	
	function DBM:ENCOUNTER_END(encounterID, name, difficulty, size, success)
		if DBM.Options.DebugMode then
			print("ENCOUNTER_END EVENT Fired", encounterID, name, difficulty, size, success)
		end
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if encounterID == v.encounter then
				local wipe = nil
				if success == 0 then wipe = true end
				self:EndCombat(v, wipe)
				return
			end
		end
	end

	local function checkExpressionList(exp, str)
		for i, v in ipairs(exp) do
			if str:match(v) then
				return true
			end
		end
		return false
	end

	-- called for all mob chat events
	local function onMonsterMessage(type, msg)
		-- pull detection
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if v.type == type and checkEntry(v.msgs, msg) or v.type == type .. "_regex" and checkExpressionList(v.msgs, msg) then
					DBM:StartCombat(v.mod, 0, "MONSTER_MESSAGE")
				elseif v.type == "combat_" .. type and checkEntry(v.msgs, msg) then
					scanForCombat(v.mod, v.mob, 0)
				end
			end
		end
		-- kill detection (wipe detection would also be nice to have)
		-- todo: add sync
		for i = #inCombat, 1, -1 do
			local v = inCombat[i]
			if not v.combatInfo then return end
			if v.combatInfo.killType == type and v.combatInfo.killMsgs[msg] then
				DBM:EndCombat(v)
			end
		end
	end

	function DBM:CHAT_MSG_MONSTER_YELL(msg)
		return onMonsterMessage("yell", msg)
	end

	function DBM:CHAT_MSG_MONSTER_EMOTE(msg)
		return onMonsterMessage("emote", msg)
	end

	function DBM:CHAT_MSG_RAID_BOSS_EMOTE(msg, ...)
		onMonsterMessage("emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:RAID_BOSS_EMOTE(msg, ...)--This is a mirror of above prototype only it has less args, both still exist for some reason.
		onMonsterMessage("emote", msg)
		return self:FilterRaidBossEmote(msg, ...)
	end

	function DBM:CHAT_MSG_MONSTER_SAY(msg)
		return onMonsterMessage("say", msg)
	end
end


---------------------------
--  Kill/Wipe Detection  --
---------------------------

function checkWipe(isIEEU, confirm)
	if #inCombat > 0 then
		local difficultyIndex
		if not savedDifficulty or not difficultyText then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText, difficultyIndex = DBM:GetCurrentInstanceDifficulty()
		end
		local wipe = 1 -- 0: no wipe, 1: normal wipe, 2: wipe by UnitExists check.
		if IsInScenarioGroup() or (difficultyIndex == 11) or (difficultyIndex == 12) then -- Scenario mod uses special combat start and must be enabled before sceniro end. So do not wipe.
			wipe = 0
		elseif IsEncounterInProgress() then -- Encounter Progress marked, you obiously combat whth boss. So do not Wipe
			wipe = 0
		elseif savedDifficulty == "worldboss" and UnitIsDeadOrGhost("player") then -- On dead or ghost, unit combat status detection would be fail. If you ghost in instance, that means wipe. But in worldboss, ghost means not wipe. So do not wipe.
			wipe = 0
		elseif isIEEU and IsInRaid() then -- Combat started by IEEU and no boss exist and no EncounterProgress marked, that means wipe
			wipe = 2
			for i = 1, 5 do
				if UnitExists("boss"..i) then
					wipe = 0 -- Boss found. No wipe
					break
				end
			end
		else -- Unit combat status detection. No combat unit in your party and no EncounterProgress marked, that means wipe
			wipe = 1
			local uId = (IsInRaid() and "raid") or "party"
			for i = 0, GetNumGroupMembers() do
				local id = (i == 0 and "player") or uId..i
				if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
					wipe = 0 -- Someone still in combat. No wipe
					break
				end
			end
		end
		if wipe == 0 then
			DBM:Schedule(3, checkWipe, isIEEU)
		elseif confirm then
			for i = #inCombat, 1, -1 do
				if DBM.Options.DebugMode then
					local reason = (wipe == 1 and "No combat unit found in your party." or "No boss found : "..(wipe or "nil"))
					print("You wiped. Reason : "..reason)
				end
				DBM:EndCombat(inCombat[i], true)
			end
		else
			local maxDelayTime = (savedDifficulty == "worldboss" and 30) or 5 --wait 25s more on worldboss do actual wipe.
			for i, v in ipairs(inCombat) do
				maxDelayTime = v.combatInfo and v.combatInfo.wipeTimer and v.combatInfo.wipeTimer > maxDelayTime and v.combatInfo.wipeTimer or maxDelayTime
			end
			DBM:Schedule(maxDelayTime, checkWipe, isIEEU, true)
		end
	end
end

local combatStartedByIEEU = false

function DBM:StartCombat(mod, delay, event, synced, syncedStartHp)
	if DBM.Options.DebugMode and not mod.inCombat then
		if event then
			print("DBM:StartCombat called by : "..event)
		else
			print("DBM:StartCombat called by individual mod or unknown reason.")
		end
	end
	if not checkEntry(inCombat, mod) then
		if not mod.Options.Enabled then return end
		-- HACK: makes sure that we don't detect a false pull if the event fires again when the boss dies...
		if mod.lastKillTime and GetTime() - mod.lastKillTime < (mod.reCombatTime or 120) and event ~= "LOADING_SCREEN_DISABLED" then return end
		if mod.lastWipeTime and GetTime() - mod.lastWipeTime < (mod.reCombatTime2 or 20) and event ~= "LOADING_SCREEN_DISABLED" then return end
		if not mod.combatInfo then return end
		if mod.combatInfo.noCombatInVehicle and UnitInVehicle("player") then -- HACK
			return
		end
		savedDifficulty, difficultyText = self:GetCurrentInstanceDifficulty()
		tinsert(inCombat, mod)
		bossHealth[mod.combatInfo.mob or -1] = 1
		if mod.multiMobPullDetection then
			for _, mob in ipairs(mod.multiMobPullDetection) do
				if not bossHealth[mob] then bossHealth[mob] = 1 end
			end
		end
		if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
			mod.inCombatOnlyEventsRegistered = 1
			mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
		end
		--Fix for "attempt to perform arithmetic on field 'stats' (a nil value)"
		if not mod.stats then
			self:AddMsg(DBM_CORE_BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
			mod.ignoreBestkill = true--Force this to true so we don't check any more occurances of "stats"
		else
			if mod:IsDifficulty("lfr25") then
				mod.stats.lfr25Pulls = mod.stats.lfr25Pulls + 1
			elseif mod:IsDifficulty("normal5", "normal10", "worldboss") then
				mod.stats.normalPulls = mod.stats.normalPulls + 1
			elseif mod:IsDifficulty("heroic5", "heroic10") then
				mod.stats.heroicPulls = mod.stats.heroicPulls + 1
			elseif mod:IsDifficulty("challenge5") then
				mod.stats.challengePulls = mod.stats.challengePulls + 1
			elseif mod:IsDifficulty("flex") then
				mod.stats.flexPulls = mod.stats.flexPulls + 1
			elseif mod:IsDifficulty("normal25") then
				mod.stats.normal25Pulls = mod.stats.normal25Pulls + 1
			elseif mod:IsDifficulty("heroic25") then
				mod.stats.heroic25Pulls = mod.stats.heroic25Pulls + 1
			end
		end
		if C_Scenario.IsInScenario() then
			mod.inScenario = true
		end
		mod.inCombat = true
		mod.blockSyncs = nil
		mod.combatInfo.pull = GetTime() - (delay or 0)
		combatStartedByIEEU = (event or "") == "IEEU"
		self:Schedule(mod.minCombatTime or 3, checkWipe, combatStartedByIEEU)
		if (DBM.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and not mod.inScenario then
			DBM.BossHealth:Show(mod.localization.general.name)
			if mod.bossHealthInfo then
				for i = 1, #mod.bossHealthInfo, 2 do
					DBM.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
				end
			else
				DBM.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
			end
		end
		local startHp = (syncedStartHp and (tonumber(syncedStartHp))) or mod:GetBossHP(mod.mainBossId or mod.combatInfo.mob) or -1
		if (mod:IsDifficulty("worldboss") and startHp < 0.98) or (event == "UNIT_HEALTH" and startHp < 0.90) then--Boss was not full health when engaged, disable combat start timer and kill record
			mod.ignoreBestkill = true
		else--Reset ignoreBestkill after wipe
			mod.ignoreBestkill = false
		end
		if (DBM.Options.AlwaysShowSpeedKillTimer or mod.Options.SpeedKillTimer) and not mod.ignoreBestkill then
			local bestTime
			if mod:IsDifficulty("lfr25") and mod.stats.lfr25BestTime then
				bestTime = mod.stats.lfr25BestTime
			elseif mod:IsDifficulty("normal5", "normal10", "worldboss") and mod.stats.normalBestTime then
				bestTime = mod.stats.normalBestTime
			elseif mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicBestTime then
				bestTime = mod.stats.heroicBestTime
			elseif mod:IsDifficulty("challenge5") and mod.stats.challengeBestTime then
				bestTime = mod.stats.challengeBestTime
			elseif mod:IsDifficulty("flex") and mod.stats.flexBestTime then
				bestTime = mod.stats.flexBestTime
			elseif mod:IsDifficulty("normal25") and mod.stats.normal25BestTime then
				bestTime = mod.stats.normal25BestTime
			elseif mod:IsDifficulty("heroic25") and mod.stats.heroic25BestTime then
				bestTime = mod.stats.heroic25BestTime
			end
			if bestTime and bestTime > 0 then
				local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
				speedTimer:Start()
			end
		end
		if mod.findFastestComputer and not DBM.Options.DontSetIcons then
			if DBM:GetRaidRank() > 0 then
				local optionName = mod.findFastestComputer[1]
				if #mod.findFastestComputer == 1 and mod.Options[optionName] then
					sendSync("IS", UnitGUID("player").."\t"..DBM.Revision.."\t"..optionName)
				else
					for i = 1, #mod.findFastestComputer do
						local option = mod.findFastestComputer[i]
						if mod.Options[option] then
							sendSync("IS", UnitGUID("player").."\t"..DBM.Revision.."\t"..option)
						end
					end
				end
			elseif not IsInGroup() then
				for i = 1, #mod.findFastestComputer do
					local option = mod.findFastestComputer[i]
					if mod.Options[option] then
						canSetIcons[option] = true
					end
				end
			end
		end
		if mod.OnCombatStart and not mod.ignoreBestkill then
			mod:OnCombatStart(delay or 0, event == "PLAYER_TARGET_AND_YELL")
		end
		if not synced then
			sendSync("C", (delay or 0).."\t"..mod.id.."\t"..(mod.revision or 0).."\t"..startHp.."\t"..DBM.Revision)
		end
		fireEvent("pull", mod, delay, synced, startHp)
		self:ToggleRaidBossEmoteFrame(1)
		if DBM.Options.ShowBigBrotherOnCombatStart and BigBrother and type(BigBrother.ConsumableCheck) == "function" then
			if DBM.Options.BigBrotherAnnounceToRaid then
				BigBrother:ConsumableCheck("RAID")
			else
				BigBrother:ConsumableCheck("SELF")
			end
		end
		self:StartLogging(0, nil)
		if DBM.Options.HideWatchFrame and WatchFrame:IsVisible() and not (mod.type == "SCENARIO") then
			WatchFrame:Hide()
			watchFrameRestore = true
		end
		if DBM.Options.ShowEngageMessage then
			if mod.ignoreBestkill and mod:IsDifficulty("worldboss") then--Should only be true on in progress field bosses, not in progress raid bosses we did timer recovery on.
				self:AddMsg(DBM_CORE_COMBAT_STARTED_IN_PROGRESS:format(difficultyText..mod.combatInfo.name))
			else
				if mod.type == "SCENARIO" then
					self:AddMsg(DBM_CORE_SCENARIO_STARTED:format(difficultyText..mod.combatInfo.name))
				else
					self:AddMsg(DBM_CORE_COMBAT_STARTED:format(difficultyText..mod.combatInfo.name))
				end
			end
		end
		local dummyMod = self:GetModByName("PullTimerCountdownDummy")
		if dummyMod then--stop pull timer, warning, countdowns
			dummyMod.countdown:Cancel()
			dummyMod.text:Cancel()
			DBM.Bars:CancelBar(DBM_CORE_TIMER_PULL)
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
		end
		if mod.hotfixNoticeRev then
			sendSync("HF", mod.id.."\t"..mod.hotfixNoticeRev)
		end
	end
end

function DBM:UNIT_HEALTH(uId)
	if not UnitExists(uId) then return end
	local cId = UnitGUID(uId) and tonumber(UnitGUID(uId):sub(6, 10), 16)
	if not cId then return end
	local health = (UnitHealth(uId) or 0) / (UnitHealthMax(uId) or 1)
	if #inCombat > 0 and bossHealth[cId] then
		bossHealth[cId] = health
	end
	if #inCombat == 0 and bossIds[cId] and InCombatLockdown() and UnitAffectingCombat(uId) and healthCombatInitialized then -- StartCombat by UNIT_HEALTH event, for older instances.
		if combatInfo[LastInstanceMapID] then
			for i, v in ipairs(combatInfo[LastInstanceMapID]) do
				if not v.mod.disableHealthCombat and (v.type == "combat" and v.multiMobPullDetection and checkEntry(v.multiMobPullDetection, cId) or v.mob == cId) then
					self:StartCombat(v.mod, health > 0.97 and 0.5 or mmin(20, (lastCombatStarted and GetTime() - lastCombatStarted) or 2.1), "UNIT_HEALTH", nil, health) -- Above 97%, boss pulled during combat, set min delay (0.5) / Below 97%, combat enter detection failure, use normal delay (max 20s)
				end
			end
		end
	end
end

function DBM:GetLowestBossHealth()
	local lowestBossHealth = 1
	for i, v in pairs(bossHealth) do
		if v < lowestBossHealth then
			lowestBossHealth = v
		end
	end
	return lowestBossHealth
end

function DBM:GetHighestBossHealth()
	if #bossHealth == 0 then return 1 end
	local highestBossHealth = 0
	for i, v in pairs(bossHealth) do
		if v > highestBossHealth then
			highestBossHealth = v
		end
	end
	return highestBossHealth
end

function DBM:GetBossHealthByCID(cid)
	if #bossHealth == 0 then return 1 end
	local health
	for i, v in pairs(bossHealth) do
		if i == cid then
			health = v
		end
	end
	return health
end

function DBM:EndCombat(mod, wipe)
	if removeEntry(inCombat, mod) then
		local scenario = mod.type == "SCENARIO"
		if mod.inCombatOnlyEvents and mod.inCombatOnlyEventsRegistered then
			-- unregister all events except for SPELL_AURA_REMOVED events (might still be needed to remove icons etc...)
			mod:UnregisterInCombatEvents("SPELL_AURA_REMOVED")
			self:Schedule(2, mod.UnregisterInCombatEvents, mod) -- 2 seconds should be enough for all auras to fade
			self:Schedule(2.1, mod.Stop, mod) -- Remove accident started timers.
			mod.inCombatOnlyEventsRegistered = nil
		end
		mod:Stop()
		mod.inCombat = false
		mod.blockSyncs = true
		if mod.combatInfo.killMobs then
			for i, v in pairs(mod.combatInfo.killMobs) do
				mod.combatInfo.killMobs[i] = true
			end
		end
		self:Schedule(10, DBM.StopLogging, DBM)--small delay to catch kill/died combatlog events
		if not savedDifficulty or not difficultyText then--prevent error if savedDifficulty or difficultyText is nil
			savedDifficulty, difficultyText = self:GetCurrentInstanceDifficulty()
		end
		if not mod.stats then--This will be nil if the mod for this intance failed to load fully because "script ran too long" (it tried to load in combat and failed)
			self:AddMsg(DBM_CORE_BAD_LOAD)--Warn user that they should reload ui soon as they leave combat to get their mod to load correctly as soon as possible
			return--Don't run any further, stats are nil on a bad load so rest of this code will also error out.
		end
		if wipe then
			mod.lastWipeTime = GetTime()
			--Fix for "attempt to perform arithmetic on field 'pull' (a nil value)" (which was actually caused by stats being nil, so we never did getTime on pull, fixing one SHOULD fix the other)
			local thisTime = GetTime() - mod.combatInfo.pull
			local wipeHP = ("%d%%"):format((mod.mainBossId and DBM:GetBossHealthByCID(mod.mainBossId) or mod.highesthealth and DBM:GetHighestBossHealth() or DBM:GetLowestBossHealth()) * 100)
			local totalPulls = (savedDifficulty == "lfr25" and mod.stats.lfr25Pulls) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicPulls) or (savedDifficulty == "challenge5" and mod.stats.challengePulls) or (savedDifficulty == "flex" and mod.stats.flexPulls) or (savedDifficulty == "normal25" and mod.stats.normal25Pulls) or (savedDifficulty == "heroic25" and mod.stats.heroic25Pulls) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalPulls) or 0
			local totalKills = (savedDifficulty == "lfr25" and mod.stats.lfr25Kills) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicKills) or (savedDifficulty == "challenge5" and mod.stats.challengeKills) or (savedDifficulty == "flex" and mod.stats.flexKills) or (savedDifficulty == "normal25" and mod.stats.normal25Kills) or (savedDifficulty == "heroic25" and mod.stats.heroic25Kills) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalKills) or 0
			if thisTime < 30 then -- Normally, one attempt will last at least 30 sec.
				if savedDifficulty == "lfr25" then
					mod.stats.lfr25Pulls = mod.stats.lfr25Pulls - 1
				elseif savedDifficulty == "heroic5" or savedDifficulty == "heroic10" then
					mod.stats.heroicPulls = mod.stats.heroicPulls - 1
				elseif savedDifficulty == "challenge5" then
					mod.stats.challengePulls = mod.stats.challengePulls - 1
				elseif savedDifficulty == "flex" then
					mod.stats.flexPulls = mod.stats.flexPulls - 1
				elseif savedDifficulty == "normal25" then
					mod.stats.normal25Pulls = mod.stats.normal25Pulls - 1
				elseif savedDifficulty == "heroic25" then
					mod.stats.heroic25Pulls = mod.stats.heroic25Pulls - 1
				else
					mod.stats.normalPulls = mod.stats.normalPulls - 1
				end
				if DBM.Options.ShowWipeMessage then
					if scenario then
						self:AddMsg(DBM_CORE_SCENARIO_ENDED_AT:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime)))
					else
						self:AddMsg(DBM_CORE_COMBAT_ENDED_AT:format(difficultyText..mod.combatInfo.name, wipeHP, strFromTime(thisTime)))
					end
				end
			else
				if DBM.Options.ShowWipeMessage then
					if scenario then
						self:AddMsg(DBM_CORE_SCENARIO_ENDED_AT_LONG:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), totalPulls - totalKills))
					else
						self:AddMsg(DBM_CORE_COMBAT_ENDED_AT_LONG:format(difficultyText..mod.combatInfo.name, wipeHP, strFromTime(thisTime), totalPulls - totalKills))
					end
				end
			end

			local msg
			for k, v in pairs(autoRespondSpam) do
				if DBM.Options.WhisperStats then
					if scenario then
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS:format(playerName, difficultyText..(mod.combatInfo.name or ""), totalPulls - totalKills)
					else
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT:format(playerName, difficultyText..(mod.combatInfo.name or ""), wipeHP, totalPulls - totalKills)
					end
				else
					if scenario then
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_WIPE:format(playerName, difficultyText..(mod.combatInfo.name or ""))
					else
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_WIPE_AT:format(playerName, difficultyText..(mod.combatInfo.name or ""), wipeHP)
					end
				end
				sendWhisper(k, msg)
			end
			fireEvent("wipe", mod)
		else
			mod.lastKillTime = GetTime()
			local thisTime = GetTime() - mod.combatInfo.pull
			local lastTime = (savedDifficulty == "lfr25" and mod.stats.lfr25LastTime) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicLastTime) or (savedDifficulty == "challenge5" and mod.stats.challengeLastTime) or (savedDifficulty == "flex" and mod.stats.flexLastTime) or (savedDifficulty == "normal25" and mod.stats.normal25LastTime) or (savedDifficulty == "heroic25" and mod.stats.heroic25LastTime) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalLastTime) or nil
			local bestTime = (savedDifficulty == "lfr25" and mod.stats.lfr25BestTime) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicBestTime) or (savedDifficulty == "challenge5" and mod.stats.challengeBestTime) or (savedDifficulty == "flex" and mod.stats.flexBestTime) or (savedDifficulty == "normal25" and mod.stats.normal25BestTime) or (savedDifficulty == "heroic25" and mod.stats.heroic25BestTime) or ((savedDifficulty == "normal5" or savedDifficulty == "normal10" or savedDifficulty == "worldboss") and mod.stats.normalBestTime) or nil
			if savedDifficulty == "lfr25" then
				if not mod.stats.lfr25Kills or mod.stats.lfr25Kills < 0 then mod.stats.lfr25Kills = 0 end
				if mod.stats.lfr25Kills > mod.stats.lfr25Pulls then mod.stats.lfr25Kills = mod.stats.lfr25Pulls end--Fix logical error i've seen where for some reason we have more kills then pulls for boss as seen by - stats for wipe messages.
				mod.stats.lfr25Kills = mod.stats.lfr25Kills + 1
				if not mod.ignoreBestkill then
					mod.stats.lfr25LastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 10 then--Just to prevent pre mature end combat calls from broken mods from saving bad time stats.
						mod.stats.lfr25BestTime = thisTime
					else
						mod.stats.lfr25BestTime = mmin(bestTime or mhuge, thisTime)
					end
				end
			elseif savedDifficulty == "normal5" or savedDifficulty == "worldboss" then
				if not mod.stats.normalKills or mod.stats.normalKills < 0 then mod.stats.normalKills = 0 end
				if mod.stats.normalKills > mod.stats.normalPulls then mod.stats.normalKills = mod.stats.normalPulls end
				mod.stats.normalKills = mod.stats.normalKills + 1
				if not mod.ignoreBestkill then
					mod.stats.normalLastTime = thisTime
					mod.stats.normalBestTime = mmin(bestTime or mhuge, thisTime)
				end
			elseif savedDifficulty == "heroic5" then
				if not mod.stats.heroicKills or mod.stats.heroicKills < 0 then mod.stats.heroicKills = 0 end
				if mod.stats.heroicKills > mod.stats.heroicPulls then mod.stats.heroicKills = mod.stats.heroicPulls end
				mod.stats.heroicKills = mod.stats.heroicKills + 1
				if not mod.ignoreBestkill then
					mod.stats.heroicLastTime = thisTime
					mod.stats.heroicBestTime = mmin(bestTime or mhuge, thisTime)
				end
			elseif savedDifficulty == "challenge5" then
				if not mod.stats.challengeKills or mod.stats.challengeKills < 0 then mod.stats.challengeKills = 0 end
				if mod.stats.challengeKills > mod.stats.challengePulls then mod.stats.challengeKills = mod.stats.challengePulls end
				mod.stats.challengeKills = mod.stats.challengeKills + 1
				if not mod.ignoreBestkill then
					mod.stats.challengeLastTime = thisTime
					mod.stats.challengeBestTime = mmin(bestTime or mhuge, thisTime)
				end
			elseif savedDifficulty == "flex" then
				if not mod.stats.flexKills or mod.stats.flexKills < 0 then mod.stats.flexKills = 0 end
				if mod.stats.flexKills > mod.stats.flexPulls then mod.stats.flexKills = mod.stats.flexPulls end
				mod.stats.flexKills = mod.stats.flexKills + 1
				if not mod.ignoreBestkill then
					mod.stats.flexLastTime = thisTime
					mod.stats.flexBestTime = mmin(bestTime or mhuge, thisTime)
				end
			elseif savedDifficulty == "normal10" then
				if not mod.stats.normalKills or mod.stats.normalKills < 0 then mod.stats.normalKills = 0 end
				if mod.stats.normalKills > mod.stats.normalPulls then mod.stats.normalKills = mod.stats.normalPulls end
				mod.stats.normalKills = mod.stats.normalKills + 1
				if not mod.ignoreBestkill then
					mod.stats.normalLastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 1.5 then--you did not kill a raid boss in one global CD. (all level 60 raids report as instance difficulty 1 which means this time has to be ridiculously low. It's more or less only gonna fix kill times of 0.)
						mod.stats.normalBestTime = thisTime
					else
						mod.stats.normalBestTime = mmin(bestTime or mhuge, thisTime)
					end
				end
			elseif savedDifficulty == "heroic10" then
				if not mod.stats.heroicKills or mod.stats.heroicKills < 0 then mod.stats.heroicKills = 0 end
				if mod.stats.heroicKills > mod.stats.heroicPulls then mod.stats.heroicKills = mod.stats.heroicPulls end
				mod.stats.heroicKills = mod.stats.heroicKills + 1
				if not mod.ignoreBestkill then
					mod.stats.heroicLastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 2 then
						mod.stats.heroicBestTime = thisTime
					else
						mod.stats.heroicBestTime = mmin(bestTime or mhuge, thisTime)
					end
				end
			elseif savedDifficulty == "normal25" then
				if not mod.stats.normal25Kills or mod.stats.normal25Kills < 0 then mod.stats.normal25Kills = 0 end
				if mod.stats.normal25Kills > mod.stats.normal25Pulls then mod.stats.normal25Kills = mod.stats.normal25Pulls end
				mod.stats.normal25Kills = mod.stats.normal25Kills + 1
				if not mod.ignoreBestkill then
					mod.stats.normal25LastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 3 then
						mod.stats.normal25BestTime = thisTime
					else
						mod.stats.normal25BestTime = mmin(bestTime or mhuge, thisTime)
					end
				end
			elseif savedDifficulty == "heroic25" then
				if not mod.stats.heroic25Kills or mod.stats.heroic25Kills < 0 then mod.stats.heroic25Kills = 0 end
				if mod.stats.heroic25Kills > mod.stats.heroic25Pulls then mod.stats.heroic25Kills = mod.stats.heroic25Pulls end
				mod.stats.heroic25Kills = mod.stats.heroic25Kills + 1
				if not mod.ignoreBestkill then
					mod.stats.heroic25LastTime = thisTime
					if bestTime and bestTime > 0 and bestTime < 4 then
						mod.stats.heroic25BestTime = thisTime
					else
						mod.stats.heroic25BestTime = mmin(bestTime or mhuge, thisTime)
					end
				end
			end
			local totalKills = (savedDifficulty == "lfr25" and mod.stats.lfr25Kills) or ((savedDifficulty == "heroic5" or savedDifficulty == "heroic10") and mod.stats.heroicKills) or (savedDifficulty == "challenge5" and mod.stats.challengeKills) or (savedDifficulty == "flex" and mod.stats.flexKills) or (savedDifficulty == "normal25" and mod.stats.normal25Kills) or (savedDifficulty == "heroic25" and mod.stats.heroic25Kills) or mod.stats.normalKills
			if DBM.Options.ShowKillMessage then
				if not thisTime then--was a bad pull so we ignored thisTime
					if scenario then
						self:AddMsg(DBM_CORE_SCENARIO_COMPLETE:format(difficultyText..mod.combatInfo.name, DBM_CORE_UNKNOWN))
					else
						self:AddMsg(DBM_CORE_BOSS_DOWN:format(difficultyText..mod.combatInfo.name, DBM_CORE_UNKNOWN))
					end
				elseif mod.ignoreBestkill then--Should never happen in a scenario so no need for scenario check.
					self:AddMsg(DBM_CORE_BOSS_DOWN_I:format(difficultyText..mod.combatInfo.name, totalKills))
				elseif not lastTime then
					if scenario then
						self:AddMsg(DBM_CORE_SCENARIO_COMPLETE:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime)))
					else
						self:AddMsg(DBM_CORE_BOSS_DOWN:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime)))
					end
				elseif thisTime < (bestTime or mhuge) then
					if scenario then
						self:AddMsg(DBM_CORE_SCENARIO_COMPLETE_NR:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), strFromTime(bestTime), totalKills))
					else
						self:AddMsg(DBM_CORE_BOSS_DOWN_NR:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), strFromTime(bestTime), totalKills))
					end
				else
					if scenario then
						self:AddMsg(DBM_CORE_SCENARIO_COMPLETE_L:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills))
					else
						self:AddMsg(DBM_CORE_BOSS_DOWN_L:format(difficultyText..mod.combatInfo.name, strFromTime(thisTime), strFromTime(lastTime), strFromTime(bestTime), totalKills))
					end
				end
			end
			local msg
			for k, v in pairs(autoRespondSpam) do
				if DBM.Options.WhisperStats then
					if scenario then
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS:format(playerName, difficultyText..(mod.combatInfo.name or ""), totalKills)
					else
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL_STATS:format(playerName, difficultyText..(mod.combatInfo.name or ""), totalKills)
					end
				else
					if scenario then
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_SCENARIO_END_KILL:format(playerName, difficultyText..(mod.combatInfo.name or ""))
					else
						msg = msg or chatPrefixShort..DBM_CORE_WHISPER_COMBAT_END_KILL:format(playerName, difficultyText..(mod.combatInfo.name or ""))
					end
				end
				sendWhisper(k, msg)
			end
			fireEvent("kill", mod)
		end
		twipe(autoRespondSpam)
		twipe(bossHealth)
		if mod.OnCombatEnd then mod:OnCombatEnd(wipe) end
		DBM.BossHealth:Hide()
		DBM.Arrow:Hide(true)
		self:ToggleRaidBossEmoteFrame(0)
		if DBM.Options.HideWatchFrame and watchFrameRestore and not scenario then
			WatchFrame:Show()
			watchFrameRestore = false
		end
		savedDifficulty = nil
		difficultyText = nil
	end
end

function DBM:OnMobKill(cId, synced)
	for i = #inCombat, 1, -1 do
		local v = inCombat[i]
		if not v.combatInfo then
			return
		end
		if v.combatInfo.killMobs and v.combatInfo.killMobs[cId] then
			if not synced then
				sendSync("K", cId)
			end
			v.combatInfo.killMobs[cId] = false
			local allMobsDown = true
			for i, v in pairs(v.combatInfo.killMobs) do
				if v then
					allMobsDown = false
					break
				end
			end
			if allMobsDown then
				self:EndCombat(v)
			end
		elseif cId == v.combatInfo.mob and not v.combatInfo.killMobs and not v.combatInfo.multiMobPullDetection then
			if not synced then
				sendSync("K", cId)
			end
			self:EndCombat(v)
		end
	end
end

function DBM:StartLogging(timer, checkFunc)
	self:Unschedule(DBM.StopLogging)
	if DBM.Options.LogOnlyRaidBosses and savedDifficulty ~= "normal10" and savedDifficulty ~= "normal25" and savedDifficulty ~= "heroic10" and savedDifficulty ~= "heroic25" and savedDifficulty ~= "flex" then return end
	if DBM.Options.AutologBosses and not LoggingCombat() then--Start logging here to catch pre pots.
		self:AddMsg("|cffffff00"..COMBATLOGENABLED.."|r")
		LoggingCombat(1)
		if checkFunc then
			self:Unschedule(checkFunc)
			self:Schedule(timer+10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
		end
	end
	if DBM.Options.AdvancedAutologBosses and Transcriptor then
		if not Transcriptor:IsLogging() then
			self:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_START.."|r")
			Transcriptor:StartLog(1)
		end
		if checkFunc then
			self:Unschedule(checkFunc)
			self:Schedule(timer+10, checkFunc)--But if pull was canceled and we don't have a boss engaged within 10 seconds of pull timer ending, abort log
		end
	end
end

function DBM:StopLogging()
	if DBM.Options.AutologBosses and LoggingCombat() then
		DBM:AddMsg("|cffffff00"..COMBATLOGDISABLED.."|r")
		LoggingCombat(0)
	end
	if DBM.Options.AdvancedAutologBosses and Transcriptor then
		if Transcriptor:IsLogging() then
			DBM:AddMsg("|cffffff00"..DBM_CORE_TRANSCRIPTOR_LOG_END.."|r")
			Transcriptor:StopLog(1)
		end
	end
end

function DBM:GetCurrentInstanceDifficulty()
	local _, _, difficulty, difficultyName, _, _, _, _, instanceGroupSize = GetInstanceInfo()
	if difficulty == 0 then
		return "worldboss", RAID_INFO_WORLD_BOSS.." - "
	elseif difficulty == 1 then
		return "normal5", difficultyName.." - ", difficulty
	elseif difficulty == 2 then
		return "heroic5", difficultyName.." - ", difficulty
	elseif difficulty == 3 then
		return "normal10", difficultyName.." - ", difficulty
	elseif difficulty == 4 then
		return "normal25", difficultyName.." - ", difficulty
	elseif difficulty == 5 then
		return "heroic10", difficultyName.." - ", difficulty
	elseif difficulty == 6 then
		return "heroic25", difficultyName.." - ", difficulty
	elseif difficulty == 7 then
		return "lfr25", difficultyName.." - ", difficulty
	elseif difficulty == 8 then
		return "challenge5", difficultyName.." - ", difficulty
	elseif difficulty == 9 then--40 man raids have their own difficulty now, no longer returned as normal 10man raids
		return "normal10", difficultyName.." - ",difficulty--Just use normal10 anyways, since that's where we been saving 40 man stuff for so long anyways, no reason to change it now, not like any 40 mans can be toggled between 10 and 40 where we NEED to tell the difference.
	elseif difficulty == 11 then--5.3 heroic scenario
		return "heroic5", difficultyName.." - ", difficulty
	elseif difficulty == 12 then--5.3 normal scenario
		return "normal5", difficultyName.." - ", difficulty
	elseif difficulty == 14 then
		return "flex", difficultyName.." - ", difficulty
	else--failsafe
		return "normal5", "", difficulty
	end
end

function DBM:UNIT_DIED(args)
	if bit.band(args.destGUID:sub(1, 5), 0x00F) == 3 or bit.band(args.destGUID:sub(1, 5), 0x00F) == 5  then
		self:OnMobKill(tonumber(args.destGUID:sub(6, 10), 16))
	end
end
DBM.UNIT_DESTROYED = DBM.UNIT_DIED


----------------------
--  Timer recovery  --
----------------------
do
	local requestedFrom = nil
	local requestTime = 0
	local clientUsed = {}

	function DBM:RequestTimers()
		local bestClient
		for i, v in pairs(raid) do
			-- If bestClient player's realm is not same with your's, timer recovery by bestClient not works at all.
			-- SendAddonMessage target channel is "WHISPER" and target player is other realm, no msg sends at all. At same realm, message sending works fine. (Maybe bliz bug or SendAddonMessage function restriction?)
			if v.name ~= playerName and UnitIsConnected(v.id) and (not UnitIsGhost(v.id)) and (v.revision or 0) > ((bestClient and bestClient.revision) or 0) and not select(2, UnitName(v.id)) and not clientUsed[v.name] then
				bestClient = v
				clientUsed[v.name] = true
			end
		end
		if not bestClient then return end
		requestedFrom = bestClient.name
		requestTime = GetTime()
		SendAddonMessage("D4", "RT", "WHISPER", bestClient.name)
	end

	function DBM:ReceiveCombatInfo(sender, mod, time, isIEEU)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 and #inCombat == 0 then
			if not mod.Options.Enabled then return end
			local lag = select(4, GetNetStats()) / 1000
			if not mod.combatInfo then return end
			self:AddMsg(DBM_CORE_COMBAT_STATE_RECOVERED:format(mod.combatInfo.name, strFromTime(time + lag)))
			tinsert(inCombat, mod)
			bossHealth[mod.combatInfo.mob or -1] = 1
			if mod.multiMobPullDetection then
				for _, mob in ipairs(mod.multiMobPullDetection) do
					if not bossHealth[mob] then bossHealth[mob] = 1 end
				end
			end
			savedDifficulty, difficultyText = self:GetCurrentInstanceDifficulty()
			if mod.inCombatOnlyEvents and not mod.inCombatOnlyEventsRegistered then
				mod.inCombatOnlyEventsRegistered = 1
				mod:RegisterEvents(unpack(mod.inCombatOnlyEvents))
			end
			if C_Scenario.IsInScenario() then
				mod.inScenario = true
			end
			mod.inCombat = true
			mod.blockSyncs = nil
			mod.combatInfo.pull = GetTime() - time + lag
			local isIEEU = isIEEU
			--hack for no iEEU information provided.
			if not isIEEU then
				for i = 1, 5 do
					if UnitExists("boss"..i) then
						isIEEU = "true"
						break
					end
				end
			end
			if mod.minCombatTime then
				self:Schedule(mmax((mod.minCombatTime - time - lag), 3), checkWipe, isIEEU == "true")
			else
				self:Schedule(3, checkWipe, isIEEU == "true")
			end
			if (DBM.Options.AlwaysShowHealthFrame or mod.Options.HealthFrame) and not mod.inSecnario then
				DBM.BossHealth:Show(mod.localization.general.name)
				if mod.bossHealthInfo then
					for i = 1, #mod.bossHealthInfo, 2 do
						DBM.BossHealth:AddBoss(mod.bossHealthInfo[i], mod.bossHealthInfo[i + 1])
					end
				else
					DBM.BossHealth:AddBoss(mod.combatInfo.mob, mod.localization.general.name)
				end
			end
			if (DBM.Options.AlwaysShowSpeedKillTimer or mod.Options.SpeedKillTimer) then
				local bestTime
				local elapsed = time + lag
				if mod:IsDifficulty("lfr25") and mod.stats.lfr25BestTime then
					bestTime = mod.stats.lfr25BestTime
				elseif mod:IsDifficulty("normal5", "normal10", "worldboss") and mod.stats.normalBestTime then
					bestTime = mod.stats.normalBestTime
				elseif mod:IsDifficulty("heroic5", "heroic10") and mod.stats.heroicBestTime then
					bestTime = mod.stats.heroicBestTime
				elseif mod:IsDifficulty("challenge5") and mod.stats.challengeBestTime then
					bestTime = mod.stats.challengeBestTime
				elseif mod:IsDifficulty("flex") and mod.stats.flexBestTime then
					bestTime = mod.stats.flexBestTime
				elseif mod:IsDifficulty("normal25") and mod.stats.normal25BestTime then
					bestTime = mod.stats.normal25BestTime
				elseif mod:IsDifficulty("heroic25") and mod.stats.heroic25BestTime then
					bestTime = mod.stats.heroic25BestTime
				end
				if bestTime and bestTime > 0 and elapsed < bestTime then	-- only start if you already have a bestTime :)
					local speedTimer = mod:NewTimer(bestTime, DBM_SPEED_KILL_TIMER_TEXT, "Interface\\Icons\\Spell_Holy_BorrowedTime")
					speedTimer:Update(time + lag, bestTime)
				end
			end
			self:ToggleRaidBossEmoteFrame(1)
		end
	end

	function DBM:ReceiveTimerInfo(sender, mod, timeLeft, totalTime, id, ...)
		if sender == requestedFrom and (GetTime() - requestTime) < 5 then
			local lag = select(4, GetNetStats()) / 1000
			for i, v in ipairs(mod.timers) do
				if v.id == id then
					v:Start(totalTime, ...)
					v:Update(totalTime - timeLeft + lag, totalTime, ...)
				end
			end
		end
	end
end

do
	local spamProtection = {}
	function DBM:SendTimers(target)
		local spamForTarget = spamProtection[target] or 0
		-- just try to clean up the table, that should keep the hash table at max. 4 entries or something :)
		for k, v in pairs(spamProtection) do
			if GetTime() - v >= 1 then
				spamProtection[k] = nil
			end
		end
		if GetTime() - spamForTarget < 1 then -- just to prevent players from flooding this on purpose
			return
		end
		spamProtection[target] = GetTime()
		if UnitInBattleground("player") then
			self:SendBGTimers(target)
			return
		end
		if #inCombat < 1 then return end
		local mod
		for i, v in ipairs(inCombat) do
			mod = not v.isCustomMod and v
		end
		mod = mod or inCombat[1]
		self:SendCombatInfo(mod, target)
		self:SendTimerInfo(mod, target)
	end
end

function DBM:SendBGTimers(target)
	local mod
	if IsActiveBattlefieldArena() then
		mod = self:GetModByName("Arenas")
	else
		-- FIXME: this doesn't work for non-english clients
		local zone = GetRealZoneText():gsub(" ", "")--Does this need updating to mapid arta?
		mod = self:GetModByName(zone)
	end
	if mod and mod.timers then
		self:SendTimerInfo(mod, target)
	end
end

function DBM:SendCombatInfo(mod, target)
	return SendAddonMessage("D4", ("CI\t%s\t%s\t%s"):format(mod.id, GetTime() - mod.combatInfo.pull, tostring(combatStartedByIEEU)), "WHISPER", target)
end

function DBM:SendTimerInfo(mod, target)
	for i, v in ipairs(mod.timers) do
		for _, uId in ipairs(v.startedTimers) do
			local elapsed, totalTime, timeLeft
			if select("#", string.split("\t", uId)) > 1 then
				elapsed, totalTime = v:GetTime(select(2, string.split("\t", uId)))
			else
				elapsed, totalTime = v:GetTime()
			end
			timeLeft = totalTime - elapsed
			if timeLeft > 0 and totalTime > 0 then
				SendAddonMessage("D4", ("TI\t%s\t%s\t%s\t%s"):format(mod.id, timeLeft, totalTime, uId), "WHISPER", target)
			end
		end
	end
end

do

	function DBM:PLAYER_ENTERING_WORLD()
--		self:Schedule(10, function() if not DBM.Options.HelpMessageShown then DBM.Options.HelpMessageShown = true DBM:AddMsg(DBM_CORE_NEED_SUPPORT) end end)
		self:Schedule(10, function() if not DBM.Options.SettingsMessageShown then DBM.Options.SettingsMessageShown = true self:AddMsg(DBM_HOW_TO_USE_MOD) end end)
--		self:Schedule(16, function() if not DBM.Options.ForumsMessageShown then DBM.Options.ForumsMessageShown = DBM.ReleaseRevision self:AddMsg(DBM_FORUMS_MESSAGE) end end)
		if type(RegisterAddonMessagePrefix) == "function" then
			if not RegisterAddonMessagePrefix("D4") then -- main prefix for DBM4
				self:AddMsg("Error: unable to register DBM addon message prefix (reached client side addon message filter limit), synchronization will be unavailable") -- TODO: confirm that this actually means that the syncs won't show up
			end
			if not RegisterAddonMessagePrefix("BigWigs") then
				self:AddMsg("Error: unable to register BigWigs addon message prefix (reached client side addon message filter limit), BigWigs version checks will be unavailable")
			end
		end
	end
end


------------------------------------
--  Auto-respond/Status whispers  --
------------------------------------
do
	local function getNumAlivePlayers()
		local alive = 0
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
			end
		end
		return alive
	end

	local function getNumRealAlivePlayers()
		local alive = 0
		local currentMapId = GetCurrentMapAreaID()
		local currentMapName = GetMapNameByID(currentMapId)
		if IsInRaid() then
			for i = 1, GetNumGroupMembers() do
				if select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("raid"..i) and 0) or 1)
				end
			end
		else
			alive = (UnitIsDeadOrGhost("player") and 0) or 1
			for i = 1, GetNumSubgroupMembers() do
				if select(7, GetRaidRosterInfo(i)) == currentMapName then
					alive = alive + ((UnitIsDeadOrGhost("party"..i) and 0) or 1)
				end
			end
		end
		return alive
	end

	local function isOnSameServer(presenceId)
		local toonID, client = select(5, BNGetFriendInfoByID(presenceId))
		if client ~= "WoW" then
			return false
		end
		return GetRealmName() == select(4, BNGetToonInfo(toonID))
	end

	-- sender is a presenceId for real id messages, a character name otherwise
	local function onWhisper(msg, sender, isRealIdMessage)
		-- ignore oQueue messages
		if msg and msg:sub(1, 3) == "OQ," then
			return
		end
		if msg == "status" and #inCombat > 0 and DBM.Options.StatusEnabled then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				difficultyText = select(2, DBM:GetCurrentInstanceDifficulty())
			end
			if IsInScenarioGroup() then return end--status not really useful on scenario mods since there is no way to report progress as a percent. We just ignore it.
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			local hp = ("%d%%"):format((mod.mainBossId and DBM:GetBossHealthByCID(mod.mainBossId) or mod.highesthealth and DBM:GetHighestBossHealth() or DBM:GetLowestBossHealth()) * 100)
			sendWhisper(sender, chatPrefix..DBM_CORE_STATUS_WHISPER:format(difficultyText..(mod.combatInfo.name or ""), hp or DBM_CORE_UNKNOWN, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
		elseif #inCombat > 0 and DBM.Options.AutoRespond and
		(isRealIdMessage and (not isOnSameServer(sender) or not DBM:GetRaidUnitId(select(4, BNGetFriendInfoByID(sender)))) or not isRealIdMessage and not DBM:GetRaidUnitId(sender)) then
			if not difficultyText then -- prevent error when timer recovery function worked and etc (StartCombat not called)
				difficultyText = select(2, DBM:GetCurrentInstanceDifficulty())
			end
			local mod
			for i, v in ipairs(inCombat) do
				mod = not v.isCustomMod and v
			end
			mod = mod or inCombat[1]
			local hp = ("%d%%"):format((mod.mainBossId and DBM:GetBossHealthByCID(mod.mainBossId) or mod.highesthealth and DBM:GetHighestBossHealth() or DBM:GetLowestBossHealth()) * 100)
			if not autoRespondSpam[sender] then
				if IsInScenarioGroup() then
					sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO:format(playerName, difficultyText..(mod.combatInfo.name or ""), getNumAlivePlayers(), DBM:GetNumGroupMembers()))
				else
					sendWhisper(sender, chatPrefix..DBM_CORE_AUTO_RESPOND_WHISPER:format(playerName, difficultyText..(mod.combatInfo.name or ""), hp or DBM_CORE_UNKNOWN, IsInInstance() and getNumRealAlivePlayers() or getNumAlivePlayers(), DBM:GetNumRealGroupMembers()))
				end
				DBM:AddMsg(DBM_CORE_AUTO_RESPONDED)
			end
			autoRespondSpam[sender] = true
		end
	end

	function DBM:CHAT_MSG_WHISPER(msg, name, _, _, _, status)
		if status ~= "GM" then
			return onWhisper(msg, name, false)
		end
	end

	function DBM:CHAT_MSG_BN_WHISPER(msg, ...)
		local presenceId = select(12, ...) -- srsly?
		return onWhisper(msg, presenceId, true)
	end
end


-------------------
--  Chat Filter  --
-------------------
do
	local function filterOutgoing(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			-- we also check if self exists to prevent a possible freeze if the function is called without arguments at all
			-- as this would be even worse than the issue with missing whisper messages ;)
			return filterOutgoing(nil, nil, self, event)
		end
		return msg:sub(1, chatPrefix:len()) == chatPrefix or msg:sub(1, chatPrefixShort:len()) == chatPrefixShort, ...
	end

	local function filterIncoming(self, event, ...)
		local msg = ...
		if not msg and self then -- compatibility mode!
			return filterIncoming(nil, nil, self, event)
		end
		if DBM.Options.SpamBlockBossWhispers then
			return #inCombat > 0 and (msg == "status" or msg:sub(1, chatPrefix:len()) == chatPrefix or msg:sub(1, chatPrefixShort:len()) == chatPrefixShort), ...
		else
			return msg == "status" and #inCombat > 0, ...
		end
	end

	local function filterSayYell(self, event, ...)
		return DBM.Options.FilterSayAndYell and #inCombat > 0, ...
	end

	--This is the source of the taints. As well as function DBM:AddMsg(text, prefix) function
	--It's also required and impossible to avoid since we need this stuff
	--This taint LOOKS like a StaticPopupDialog taint but it is not. That taint was actaully fixed in 5.3
	--Install http://www.wowace.com/addons/notaint/ which embeds libchatanims to fix problem.
	--Additional information at http://www.wowace.com/addons/libchatanims/
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", filterOutgoing)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filterIncoming)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filterSayYell)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filterSayYell)
end


--Raid Boss Emote frame handler for core and BG mods.
--This completely unregisteres or registers event so frame simply does or doesn't show events
--No dirty hooking. Least invasive way to do it. Uses lowest CPU
--Toggle is for if we are turning off or on.
--Custom is for exterior mods to call function without needing global option turned on (such as BG mods option)
--All also handled by core so both core AND pvp mods aren't trying to hook/hide it. Should all be done HERE
local unRegistered = false
function DBM:ToggleRaidBossEmoteFrame(toggle, custom)
	if not DBM.Options.HideBossEmoteFrame and not custom then return end
	if toggle == 1 and not unRegistered then
		unRegistered = true
		RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:UnregisterEvent("RAID_BOSS_WHISPER")
		RaidBossEmoteFrame:UnregisterEvent("CLEAR_BOSS_EMOTES")
	elseif toggle == 0 and unRegistered then
		unRegistered = false
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_EMOTE")
		RaidBossEmoteFrame:RegisterEvent("RAID_BOSS_WHISPER")
		RaidBossEmoteFrame:RegisterEvent("CLEAR_BOSS_EMOTES")
	end
end


--------------------------
--  Enable/Disable DBM  --
--------------------------
function DBM:Disable(forced)
	unschedule()
	enabled = false
	if not forced then
		self.Options.Enabled = false
	else
		blockEnable = true
	end
end

function DBM:Enable()
	if not blockEnable then
		enabled = true
		self.Options.Enabled = true
	end
end

function DBM:IsEnabled()
	return self.Options.Enabled
end


-----------------------
--  Misc. Functions  --
-----------------------
function DBM:AddMsg(text, prefix)
	prefix = prefix or (self.localization and self.localization.general.name) or "Deadly Boss Mods"
	local frame = _G[tostring(DBM.Options.ChatFrame)]
	frame = frame and frame:IsShown() and frame or DEFAULT_CHAT_FRAME
	if DBM.Options.ShowChatTime then
		frame:AddMessage(("|cffff7d0a%s|r|cffff7d0a[|r|cffffd200%s|r|cffff7d0a]|r %s"):format(date("%H:%M:%S"), tostring(prefix), tostring(text)), 0.41, 0.8, 0.94)
	else
		frame:AddMessage(("|cffff7d0a<|r|cffffd200%s|r|cffff7d0a>|r %s"):format(tostring(prefix), tostring(text)), 0.41, 0.8, 0.94)
	end	
end

do
	local testMod
	local testWarning1, testWarning2, testWarning3
	local testTimer
	local testSpecialWarning1
	local testSpecialWarning2
	local testSpecialWarning3
	function DBM:DemoMode()
		if not testMod then
			testMod = self:NewMod("TestMod")
			DBM:GetModLocalization("TestMod"):SetGeneralLocalization{ name = "Test Mod" }
			testWarning1 = testMod:NewAnnounce("%s", 1, "Interface\\Icons\\Spell_Nature_WispSplode")
			testWarning2 = testMod:NewAnnounce("%s", 2, "Interface\\Icons\\Spell_Shadow_ShadesOfDarkness")
			testWarning3 = testMod:NewAnnounce("%s", 3, "Interface\\Icons\\Spell_Fire_SelfDestruct")
			testTimer = testMod:NewTimer(20, "%s")
			testSpecialWarning1 = testMod:NewSpecialWarning("%s")
			testSpecialWarning2 = testMod:NewSpecialWarning(" %s ", nil, nil, nil, true)
			testSpecialWarning3 = testMod:NewSpecialWarning("  %s  ", nil, nil, nil, 3) -- hack: non auto-generated special warnings need distinct names (we could go ahead and give them proper names with proper localization entries, but this is much easier)
		end
		testTimer:Start(20, "Pew Pew Pew...")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_Starfall", "Pew Pew Pew...")
		testTimer:Start(10, "Test Bar")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Nature_WispSplode", "Test Bar")
		testTimer:Start(43, "Evil Spell")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Shadow_ShadesOfDarkness", "Evil Spell")
		testTimer:Start(60, "Boom!")
		testTimer:UpdateIcon("Interface\\Icons\\Spell_Fire_SelfDestruct", "Boom!")
		testWarning1:Cancel()
		testWarning2:Cancel()
		testWarning3:Cancel()
		testSpecialWarning1:Cancel()
		testSpecialWarning2:Cancel()
		testSpecialWarning3:Cancel()
		testWarning1:Show("Test-mode started...")
		testWarning1:Schedule(62, "Test-mode finished!")
		testWarning3:Schedule(50, "Boom in 10 sec!")
		testWarning3:Schedule(20, "Pew Pew Laser Owl!")
		testWarning2:Schedule(38, "Evil Spell in 5 sec!")
		testWarning2:Schedule(43, "Evil Spell!")
		testWarning1:Schedule(10, "Test bar expired!")
		testSpecialWarning1:Schedule(20, "Pew Pew Laser Owl")
		testSpecialWarning2:Schedule(43, "Evil Spell!")
		testSpecialWarning3:Schedule(60, "Boom!")
	end
end

DBM.Bars:SetAnnounceHook(function(bar)
	local prefix
	if bar.color and bar.color.r == 1 and bar.color.g == 0 and bar.color.b == 0 then
		prefix = DBM_CORE_HORDE or FACTION_HORDE
	elseif bar.color and bar.color.r == 0 and bar.color.g == 0 and bar.color.b == 1 then
		prefix = DBM_CORE_ALLIANCE or FACTION_ALLIANCE
	end
	if prefix then
		return ("%s: %s  %d:%02d"):format(prefix, _G[bar.frame:GetName().."BarName"]:GetText(), floor(bar.timer / 60), bar.timer % 60)
	end
end)

function DBM:Capitalize(str)
	local firstByte = str:byte(1, 1)
	local numBytes = 1
	if firstByte >= 0xF0 then -- firstByte & 0b11110000
		numBytes = 4
	elseif firstByte >= 0xE0 then -- firstByte & 0b11100000
		numBytes = 3
	elseif firstByte >= 0xC0 then  -- firstByte & 0b11000000
		numBytes = 2
	end
	return str:sub(1, numBytes):upper()..str:sub(numBytes + 1):lower()
end

--copied from big wigs with permission from funkydude. Modified by MysticalOS
local roleEventUnregistered = false
function DBM:RoleCheck()
	local spec = GetSpecialization()
	if not spec then return end
	local role = GetSpecializationRole(spec)
	local specID = GetLootSpecialization()
	local _, _, _, _, _, lootrole = GetSpecializationInfoByID(specID)
	local _, _, diff = GetInstanceInfo()
	if DBM.Options.SetPlayerRole and not InCombatLockdown() and IsInGroup() and ((IsPartyLFG() and diff == 14) or not IsPartyLFG()) then
		if UnitGroupRolesAssigned("player") ~= role then
			UnitSetRole("player", role)
		end
		if not roleEventUnregistered then
			roleEventUnregistered = true
			RolePollPopup:UnregisterEvent("ROLE_POLL_BEGIN")
		end
	else
		if roleEventUnregistered then
			roleEventUnregistered = false
			RolePollPopup:RegisterEvent("ROLE_POLL_BEGIN")
		end
	end
	--Loot reminder even if spec isn't known or we are in LFR where we have a valid for role without us being ones that set us.
	if lootrole and (role ~= lootrole) then
		self:AddMsg(DBM_CORE_LOOT_SPEC_REMINDER:format(_G[role] or DBM_CORE_UNKNOWN, _G[lootrole]))
	end
end

--To speed up creating new mods.
function DBM:FindDungeonIDs()
	for i=1, 1000 do
		local dungeon = GetDungeonInfo(i)
		if dungeon then
			self:AddMsg(i..": "..dungeon)
		end
	end
end

function DBM:FindInstanceIDs()
	for i=1, 1000 do
		local instance = EJ_GetInstanceInfo(i)
		if instance then
			self:AddMsg(i..": "..instance)
		end
	end
end

function DBM:FindEncounterIDs(instanceID, diff)
	if not instanceID then
		self:AddMsg("Error: Function requires instanceID be provided")
	end
	local _, instanceType, difficultyID = GetInstanceInfo()
	if difficultyID == 0 then difficultyID = 6 end--EJ in 5.4 considers world bosses as 25man normal
	EJ_SetDifficulty(diff or difficultyID)--Make sure it's set to right difficulty or it'll ignore mobs (ie ra-den if it's not set to heroic). Use user specified one as primary, with curernt zone difficulty as fallback
	for i=1, 25 do
		local name, _, encounterID = EJ_GetEncounterInfoByIndex(i, instanceID)
		if name then
			self:AddMsg(encounterID..": "..name)
		end
	end
end

-----------------
--  Map Sizes  --
-----------------
DBM.MapSizes = {}

function DBM:RegisterMapSize(zone, ...)
	if not DBM.MapSizes[zone] then
		DBM.MapSizes[zone] = {}
	end
	local zone = DBM.MapSizes[zone]
	for i = 1, select("#", ...), 3 do
		local level, width, height = select(i, ...)
		zone[level] = {width, height}
	end
end

function DBM:UpdateMapSizes()
	-- try custom map size first
	SetMapToCurrentZone()
	local mapName = GetMapInfo()
	local floor, a1, b1, c1, d1 = GetCurrentMapDungeonLevel()
	local dims = DBM.MapSizes[mapName] and DBM.MapSizes[mapName][floor]
	if dims then
		currentSizes = dims
		return
	end

	-- failed, try Blizzard's map size
	if not (a1 and b1 and c1 and d1) then
		local zoneIndex, a2, b2, c2, d2 = GetCurrentMapZone()
		a1, b1, c1, d1 = a2, b2, c2, d2
	end

	if not (a1 and b1 and c1 and d1) then return end
	currentSizes = {abs(c1-a1), abs(d1-b1)}
end

function DBM:GetMapSizes()
	if not currentSizes then
		DBM:UpdateMapSizes()
	end
	return currentSizes
end

-------------------
--  Movie Filter --
-------------------
MovieFrame:HookScript("OnEvent", function(self, event, id)
	if event == "PLAY_MOVIE" and id then
		if DBM.Options.MovieFilter == "Never" then return end
		if DBM.Options.MovieFilter == "Block" or DBM.Options.MovieFilter == "AfterFirst" and DBM.Options.MoviesSeen[id] then
			MovieFrame_OnMovieFinished(self)
		else
			DBM.Options.MoviesSeen[id] = true
		end
	end
end)


--------------------------
--  Boss Mod Prototype  --
--------------------------
local bossModPrototype = {}


----------------------------
--  Boss Mod Constructor  --
----------------------------
do
	local modsById = setmetatable({}, {__mode = "v"})
	local mt = {__index = bossModPrototype}

	function DBM:NewMod(name, modId, modSubTab, instanceId, nameModifier)
		name = tostring(name) -- the name should never be a number of something as it confuses sync handlers that just receive some string and try to get the mod from it
		if modsById[name] then error("DBM:NewMod(): Mod names are used as IDs and must therefore be unique.", 2) end
		local obj = setmetatable(
			{
				Options = {
					Enabled = true,
				},
				DefaultOptions = {
					Enabled = true,
				},
				subTab = modSubTab,
				optionCategories = {
				},
				categorySort = {},
				id = name,
				announces = {},
				specwarns = {},
				timers = {},
				countdowns = {},
				modId = modId,
				instanceId = instanceId,
				revision = 0,
				localization = self:GetModLocalization(name)
			},
			mt
		)
		for i, v in ipairs(self.AddOns) do
			if v.modId == modId then
				obj.addon = v
				break
			end
		end

		if tonumber(name) then
			local t = EJ_GetEncounterInfo(tonumber(name))
			if type(nameModifier) == "number" then--Get name form EJ_GetCreatureInfo
				t = select(2, EJ_GetCreatureInfo(nameModifier, tonumber(name)))
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or name)
			end
			obj.localization.general.name = t
			obj.modelId = select(4, EJ_GetCreatureInfo(1, tonumber(name)))
		elseif name:match("z%d+") then
			local t = GetRealZoneText(string.sub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or name)
			end
			obj.localization.general.name = t
		elseif name:match("d%d+") then
			local t = GetDungeonInfo(string.sub(name, 2))
			if type(nameModifier) == "number" then--do nothing
			elseif type(nameModifier) == "function" then--custom name modify function
				t = nameModifier(t or name)
			else--default name modify
				t = string.split(",", t or name)
			end
			obj.localization.general.name = t
		end
		tinsert(self.Mods, obj)
		modsById[name] = obj
		obj:AddBoolOption("SpeedKillTimer", false, "misc")
		obj:AddBoolOption("HealthFrame", false, "misc")
		obj:SetZone()
		return obj
	end

	function DBM:GetModByName(name)
		return modsById[tostring(name)]
	end
end


-----------------------
--  General Methods  --
-----------------------
bossModPrototype.RegisterEvents = DBM.RegisterEvents
bossModPrototype.UnregisterInCombatEvents = DBM.UnregisterInCombatEvents
bossModPrototype.AddMsg = DBM.AddMsg
bossModPrototype.UnregisterShortTermEvents = DBM.UnregisterShortTermEvents

function bossModPrototype:SetZone(...)
	if select("#", ...) == 0 then
		self.zones = {}
		if self.addon and self.addon.mapId then
			for i, v in ipairs(self.addon.mapId) do
				self.zones[v] = true
			end
		end
	elseif select(1, ...) ~= DBM_DISABLE_ZONE_DETECTION then
		self.zones = {}
		for i = 1, select("#", ...) do
			self.zones[select(i, ...)] = true
		end
	else -- disable zone detection
		self.zones = nil
	end
end

--------------
--  Events  --
--------------
function bossModPrototype:RegisterEventsInCombat(...)
	if self.inCombatOnlyEvents then
		geterrorhandler()("combat events already set")
	end
	self.inCombatOnlyEvents = {...}
	for k, v in pairs(self.inCombatOnlyEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
			-- legacy event, oh noes
			self.inCombatOnlyEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
		end
	end
end

function bossModPrototype:RegisterShortTermEvents(...)
	if self.shortTermEventsRegistered then
		return
	end
	self.shortTermRegisterEvents = {...}
	for k, v in pairs(self.shortTermRegisterEvents) do
		if v:sub(0, 5) == "UNIT_" and v:sub(v:len() - 10) ~= "_UNFILTERED" and not v:find(" ") and v ~= "UNIT_DIED" and v ~= "UNIT_DESTROYED" then
			-- legacy event, oh noes
			self.shortTermRegisterEvents[k] = v .. " boss1 boss2 boss3 boss4 boss5 target focus"
		end
	end
	self.shortTermEventsRegistered = 1
	self:RegisterEvents(unpack(self.shortTermRegisterEvents))
end

function bossModPrototype:SetCreatureID(...)
	self.creatureId = ...
	if select("#", ...) > 1 then
		self.multiMobPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiMobPullDetection = self.multiMobPullDetection
		end
		for i = 1, select("#", ...) do
			local cId = select(i, ...)
			bossIds[cId] = true
		end
	else
		local cId = ...
		bossIds[cId] = true
	end
end

--NOT same as encounter journal IDs.
function bossModPrototype:SetEncounterID(...)
	self.encounterId = ...
	if select("#", ...) > 1 then
		self.multiEncounterPullDetection = {...}
		if self.combatInfo then
			self.combatInfo.multiEncounterPullDetection = self.multiEncounterPullDetection
		end
	end
end

function bossModPrototype:SetQuestID(id)
	self.questId = id
end

function bossModPrototype:Toggle()
	if self.Options.Enabled then
		self:DisableMod()
	else
		self:EnableMod()
	end
end

function bossModPrototype:EnableMod()
	self.Options.Enabled = true
end

function bossModPrototype:DisableMod()
	self:Stop()
	self.Options.Enabled = false
end

function bossModPrototype:RegisterOnUpdateHandler(func, interval)
	if type(func) ~= "function" then return end
	self.elapsed = 0
	self.updateInterval = interval or 0
	updateFunctions[self] = func
end

function bossModPrototype:SetRevision(revision)
	revision = tonumber(revision or "")
	if not revision then
		-- bad revision: either forgot the svn keyword or using git svn
		revision = DBM.Revision
	end
	self.revision = revision
end

function bossModPrototype:SendWhisper(msg, target)
	return not DBM.Options.DontSendBossWhispers and sendWhisper(target, chatPrefixShort..msg)
end

function bossModPrototype:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	return (guid and (tonumber(guid:sub(6, 10), 16))) or 0
end

function bossModPrototype:GetCIDFromGUID(guid)
	return (guid and (tonumber(guid:sub(6, 10), 16))) or 0
end

local bossTargetuIds = {
	"target", "focus", "boss1", "boss2", "boss3", "boss4", "boss5"
}

function bossModPrototype:GetBossTarget(cid)
	cid = cid or self.creatureId
	local name, uid, bossuid
	for i, uId in ipairs(bossTargetuIds) do
		if self:GetUnitCreatureId(uId) == cid or UnitGUID(uId) == cid then--Accepts CID or GUID
			bossuid = uId
			name = DBM:GetUnitFullName(uId.."target")
			uid = uId.."target"
			break
		end
	end
	if name and bossuid then return name, uid, bossuid end
	-- failed to detect from default uIds, scan all group members's target.
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if self:GetUnitCreatureId("raid"..i.."target") == cid or UnitGUID("raid"..i.."target") == cid then
				bossuid = "raid"..i.."target"
				name = DBM:GetUnitFullName("raid"..i.."targettarget")
				uid = "raid"..i.."targettarget"
				break
			end
		end
	elseif IsInGroup() then
		for i = 1, GetNumSubgroupMembers() do
			if self:GetUnitCreatureId("party"..i.."target") == cid or UnitGUID("party"..i.."target") == cid then
				bossuid = "party"..i.."target"
				name = DBM:GetUnitFullName("party"..i.."targettarget")
				uid = "party"..i.."targettarget"
				break
			end
		end
	end
	return name, uid, bossuid
end

local targetScanCount = 0
function bossModPrototype:BossTargetScanner(cid, returnFunc, scanInterval, scanTimes, isEnemyScan, isFinalScan)
	--Increase scan count
	targetScanCount = targetScanCount + 1
	--Set default values
	local cid = cid or self.creatureId
	local scanInterval = scanInterval or 0.05
	local scanTimes = scanTimes or 16
	local targetname, targetuid, bossuid = self:GetBossTarget(cid)
	--Do scan
	if isEnemyScan and targetname or UnitExists(targetuid) then--We check target exists on player scan to prevent nil error. But on enemy scan, do not check target exists.
		if (isEnemyScan and UnitIsFriend("player", targetuid) or self:IsTanking(targetuid, bossuid)) and not isFinalScan then--On player scan, ignore tanks. On enemy scan, ignore friendly player.
			if targetScanCount < scanTimes then--Make sure no infinite loop.
				self:ScheduleMethod(scanInterval, "BossTargetScanner", cid, returnFunc, scanInterval, scanTimes, isEnemyScan)--Scan multiple times to be sure it's not on something other then tank (or friend on enemy scan).
			else--Go final scan.
				self:BossTargetScanner(cid, returnFunc, scanInterval, scanTimes, isEnemyScan, true)
			end
		else--Scan success. (or failed to detect right target.) But some spells can be used on tanks, anyway warns tank if player scan. (enemy scan block it)
			targetScanCount = 0--Reset count for later use.
			self:UnscheduleMethod("BossTargetScanner")--Unschedule all checks just to be sure none are running, we are done.
			if not (isEnemyScan and isFinalScan) then--If enemy scan, player target is always bad. So do not warn anything. Also, must filter nil value on returnFunc.
				self:ScheduleMethod(0, returnFunc, targetname, targetuid, bossuid)--Return results to warning function with all variables.
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if targetScanCount < scanTimes then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(scanInterval, "BossTargetScanner", cid, returnFunc, scanInterval, scanTimes, isEnemyScan)
		end
	end
end

local scanExpires = {}
local addsIcon = {}
local addsIconSet = {}

function bossModPrototype:ScanForMobs(creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName)
	if not optionName then optionName = self.findFastestComputer[1] end
	if canSetIcons[optionName] then
		--Declare variables.
		local timeNow = GetTime()
		local creatureID = creatureID--This function must not be used to boss, so remove self.creatureId. Accepts cid, guid and cid table
		local iconSetMethod = iconSetMethod or 0--Set IconSetMethod -- 0: Descending / 1:Ascending / 2: Force Set / 9:Force Stop
		--With different scanID, this function can support multi scanning same time. Required for Nazgrim.
		local scanID = 0
		if type(creatureID) == "number" then
			scanID = creatureID --guid and table no not supports multi scanning. only cid supports multi scanning
		end
		if iconSetMethod == 9 then--Force stop scanning
			--clear variables
			scanExpires[scanID] = nil
			addsIcon[scanID] = nil
			addsIconSet[scanID] = nil
			return
		end
		if not addsIcon[scanID] then addsIcon[scanID] = mobIcon or 8 end
		if not addsIconSet[scanID] then addsIconSet[scanID] = 0 end
		if not scanExpires[scanID] then scanExpires[scanID] = timeNow + scanningTime end
		local maxIcon = maxIcon or 8 --We only have 8 icons.
		local scanInterval = scanInterval or 0.2
		local scanningTime = scanningTime or 8
		--DO SCAN NOW
		for uId in DBM:GetGroupMembers() do
			local unitid = uId.."target"
			local guid = UnitGUID(unitid)
			local cid = self:GetCIDFromGUID(guid)
			if guid and type(creatureID) == "table" and creatureID[cid] and not addsGUIDs[guid] then
				if type(creatureID[cid]) == "number" then
					SetRaidTarget(unitid, creatureID[cid])
				else
					SetRaidTarget(unitid, addsIcon[scanID])
					if iconSetMethod == 1 then
						addsIcon[scanID] = addsIcon[scanID] + 1
					else
						addsIcon[scanID] = addsIcon[scanID] - 1
					end
				end
				addsGUIDs[guid] = true
				addsIconSet[scanID] = addsIconSet[scanID] + 1
				if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
					--clear variables
					scanExpires[scanID] = nil
					addsIcon[scanID] = nil
					addsIconSet[scanID] = nil
					return
				end
			elseif guid and ((guid == creatureID) or (cid == creatureID)) and not addsGUIDs[guid] then
				if iconSetMethod == 2 then
					SetRaidTarget(unitid, mobIcon)
				else
					SetRaidTarget(unitid, addsIcon[scanID])
					if iconSetMethod == 1 then
						addsIcon[scanID] = addsIcon[scanID] + 1
					else
						addsIcon[scanID] = addsIcon[scanID] - 1
					end
				end
				addsGUIDs[guid] = true
				addsIconSet[scanID] = addsIconSet[scanID] + 1
				if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
					--clear variables
					scanExpires[scanID] = nil
					addsIcon[scanID] = nil
					addsIconSet[scanID] = nil
					return
				end
			end
		end
		local guid2 = UnitGUID("mouseover")
		local cid2 = self:GetCIDFromGUID(guid2)
		if guid2 and type(creatureID) == "table" and creatureID[cid2] and not addsGUIDs[guid2] then
			if type(creatureID[cid2]) == "number" then
				SetRaidTarget("mouseover", creatureID[cid2])
			else
				SetRaidTarget("mouseover", addsIcon[scanID])
				if iconSetMethod == 1 then
					addsIcon[scanID] = addsIcon[scanID] + 1
				else
					addsIcon[scanID] = addsIcon[scanID] - 1
				end
			end
			addsGUIDs[guid2] = true
			addsIconSet[scanID] = addsIconSet[scanID] + 1
			if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				return
			end
		elseif guid2 and ((guid2 == creatureID) or (cid2 == creatureID)) and not addsGUIDs[guid2] then
			if iconSetMethod == 2 then
				SetRaidTarget("mouseover", mobIcon)
			else
				SetRaidTarget("mouseover", addsIcon[scanID])
				if iconSetMethod == 1 then
					addsIcon[scanID] = addsIcon[scanID] + 1
				else
					addsIcon[scanID] = addsIcon[scanID] - 1
				end
			end
			addsGUIDs[guid2] = true
			addsIconSet[scanID] = addsIconSet[scanID] + 1
			if addsIconSet[scanID] >= maxIcon then--stop scan immediately to save cpu
				--clear variables
				scanExpires[scanID] = nil
				addsIcon[scanID] = nil
				addsIconSet[scanID] = nil
				return
			end
		end
		if timeNow < scanExpires[scanID] then--scan for limited times.
			self:ScheduleMethod(scanInterval, "ScanForMobs", creatureID, iconSetMethod, mobIcon, maxIcon, scanInterval, scanningTime, optionName)
		else
			--clear variables
			scanExpires[scanID] = nil
			addsIcon[scanID] = nil
			addsIconSet[scanID] = nil
			--Do not wipe adds GUID table here, it's wiped by :Stop() which is called by EndCombat
		end
	end
end

--Now this function works perfectly. But have some limitation due to DBM.RangeCheck:GetDistance() function.
--Unfortunely, DBM.RangeCheck:GetDistance() function cannot reflects altitude difference. This makes range unreliable.
--So, we need to cafefully check range in difference altitude (Espcially, tower top and bottom)
function bossModPrototype:CheckTankDistance(cid, distance, defaultReturn)
	local cid = cid or self.creatureId--GetBossTarget supports GUID or CID and it will automatically return correct values with EITHER ONE
	local distance = distance or 40
	local uId
	local _, fallbackuId, mobuId = self:GetBossTarget(cid)
	if mobuId then--Have a valid mob unit ID
		--First, use trust threat more than fallbackuId and see what we pull from it first.
		--This is because for CheckTankDistance we want to know who is tanking it, not who it's targeting it.
		local unitId = (IsInRaid() and "raid") or "party"
		for i = 0, GetNumGroupMembers() do
			local id = (i == 0 and "target") or unitId..i
			local tanking, status = UnitDetailedThreatSituation(id, mobuId)--Tanking may return 0 if npc is temporarily looking at an NPC (IE fracture) but status will still be 3 on true tank
			if tanking or (status == 3) then uId = id end--Found highest threat target, make them uId
			if uId then break end
		end
		--Did not get anything useful from threat, so use who the boss was looking at, at time of cast (ie fallbackuId)
		if fallbackuId and not uId then
			uId = fallbackuId
		end
	end
	if uId then--Now we have a valid uId
		if UnitIsUnit("player", uId) then return true end--If "player" is target, avoid doing any complicated stuff
		local x, y = GetPlayerMapPosition(uId)
		if x == 0 and y == 0 then
			SetMapToCurrentZone()
			x, y = GetPlayerMapPosition(uId)
		end
		if x == 0 and y == 0 then--Failed to pull coords. This is likely a pet or a guardian or an NPC.
			local inRange2, checkedRange = UnitInRange(uId)--Use an API that works on pets and some NPCS (npcs that get a party/raid/pet ID)
			if inRange2 and checkedRange then
			end
			if checkedRange and not inRange2 then--checkedRange only returns true if api worked, so if we get false, true then we are not near npc
				return false
			else--Its probably a totem or just something we can't assess. Fall back to no filtering
				return true
			end
		end
		local inRange = DBM.RangeCheck:GetDistance("player", x, y)--We check how far we are from the tank who has that boss
		if inRange and (inRange > distance) then--You are not near the person tanking boss
			return false
		end
		--Tank in range, return true.
		return true
	end
	return (defaultReturn == nil) or defaultReturn--When we simply can't figure anything out, return true and allow warnings using this filter to fire. But some spells will prefer not to fire(i.e : Galakras tower spell), we can define it on this function calling.
end

function bossModPrototype:Stop(cid)
	for i, v in ipairs(self.timers) do
		v:Stop()
	end
	for i, v in ipairs(self.countdowns) do
		v:Stop()
	end
	self:Unschedule()
	twipe(canSetIcons)--Wiped here when mod stop is called by CombatEnd
	twipe(iconSetRevision)
	twipe(iconSetPerson)
	twipe(addsGUIDs)
end

function bossModPrototype:IsDifficulty(...)
	local diff = DBM:GetCurrentInstanceDifficulty()
	for i = 1, select("#", ...) do
		if diff == select(i, ...) then
			return true
		end
	end
	return false
end

function bossModPrototype:SetUsedIcons(...)
	self.usedIcons = {}
	for i = 1, select("#", ...) do
		self.usedIcons[select(i, ...)] = true
	end
end

function bossModPrototype:LatencyCheck()
	return select(4, GetNetStats()) < DBM.Options.LatencyThreshold
end

function bossModPrototype:IsTrivial(level)
	if UnitLevel("player") >= level then
		return true
	end
	return false
end

-- An anti spam function to throttle spammy events (e.g. SPELL_AURA_APPLIED on all group members)
-- @param time the time to wait between two events (optional, default 2.5 seconds)
-- @param id the id to distinguish different events (optional, only necessary if your mod keeps track of two different spam events at the same time)
function bossModPrototype:AntiSpam(time, id)
	if GetTime() - (id and (self["lastAntiSpam" .. tostring(id)] or 0) or self.lastAntiSpam or 0) > (time or 2.5) then
		if id then
			self["lastAntiSpam" .. tostring(id)] = GetTime()
		else
			self.lastAntiSpam = GetTime()
		end
		return true
	else
		return false
	end
end

function bossModPrototype:IsCriteriaCompleted(criteriaIDToCheck)
	if not criteriaIDToCheck then
		geterrorhandler()("usage: mod:IsCriteriaComplected(criteriaId)")
		return false
	end
	local _, _, numCriteria = C_Scenario.GetStepInfo()
	for i = 1, numCriteria do
		local _, _, criteriaCompleted, _, _, _, _, _, criteriaID = C_Scenario.GetCriteriaInfo(i)
		if criteriaID == criteriaIDToCheck and criteriaCompleted then
			return true
		end
	end
	return false
end

--Simple spec stuff
function bossModPrototype:IsMelee()
	return class == "ROGUE"
	or class == "WARRIOR"
	or class == "DEATHKNIGHT"
	or class == "MONK"--Iffy slope, monk healers will be ranged and melee. :\
	or (class == "PALADIN" and (GetSpecialization() ~= 1))
    or (class == "SHAMAN" and (GetSpecialization() == 2))
	or (class == "DRUID" and (GetSpecialization() == 2 or GetSpecialization() == 3))
end

function bossModPrototype:IsMeleeDps()
	return class == "ROGUE"
	or (class == "WARRIOR" and (GetSpecialization() ~= 3))
	or (class == "DEATHKNIGHT" and (GetSpecialization() ~= 1))
	or (class == "MONK" and (GetSpecialization() == 3))
	or (class == "PALADIN" and (GetSpecialization() == 3))
    or (class == "SHAMAN" and (GetSpecialization() == 2))
	or (class == "DRUID" and (GetSpecialization() == 2))
end

function bossModPrototype:IsRanged()--Including healer
	return class == "MAGE"
	or class == "HUNTER"
	or class == "WARLOCK"
	or class == "PRIEST"
	or (class == "PALADIN" and (GetSpecialization() == 1))
    or (class == "SHAMAN" and (GetSpecialization() ~= 2))
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 4))
	or (class == "MONK" and (GetSpecialization() == 2))--Iffy slope, monk healers will be ranged and melee. :\
end

function bossModPrototype:IsRangedDps()
	return class == "MAGE"
	or class == "HUNTER"
	or class == "WARLOCK"
	or (class == "PRIEST" and (GetSpecialization() == 3))
    or (class == "SHAMAN" and (GetSpecialization() == 1))
	or (class == "DRUID" and (GetSpecialization() == 1))
end

function bossModPrototype:IsManaUser()--Similar to ranged, but includes all paladins and all shaman
	return class == "MAGE"
	or class == "WARLOCK"
	or class == "PRIEST"
	or class == "PALADIN"
    or class == "SHAMAN"
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 4))
	or (class == "MONK" and (GetSpecialization() == 2))
end

function bossModPrototype:IsDps()--For features that simply should only be on for dps and not healers or tanks and without me having to use "not is heal or not is tank" rules :)
	return class == "WARLOCK"
	or class == "MAGE"
	or class == "HUNTER"
	or class == "ROGUE"
	or (class == "WARRIOR" and (GetSpecialization() ~= 3))
	or (class == "DEATHKNIGHT" and (GetSpecialization() ~= 1))
	or (class == "PALADIN" and (GetSpecialization() == 3))
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 2))
	or (class == "SHAMAN" and (GetSpecialization() ~= 3))
   	or (class == "PRIEST" and (GetSpecialization() == 3))
	or (class == "MONK" and (GetSpecialization() == 3))
end

function bossModPrototype:IsTank()
	return (class == "WARRIOR" and (GetSpecialization() == 3))
	or (class == "DEATHKNIGHT" and (GetSpecialization() == 1))
	or (class == "PALADIN" and (GetSpecialization() == 2))
	or (class == "DRUID" and (GetSpecialization() == 3))
	or (class == "MONK" and (GetSpecialization() == 1))
end

function bossModPrototype:IsSpellCaster(includePal)
	return class == "MAGE"
	or class == "WARLOCK"
	or class == "PRIEST"
	or (class == "MONK" and (GetSpecialization() == 2))
    or (class == "SHAMAN" and (GetSpecialization() ~= 2))
	or (class == "DRUID" and (GetSpecialization() == 1 or GetSpecialization() == 4))
	or (class == "PALADIN" and (GetSpecialization() == 1 or (includePal or false)))
end

function bossModPrototype:IsTanking(unit, boss)
	if not unit then return false end
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if boss and UnitExists(boss) then--Only checking one bossID as requested
		local tanking, status = UnitDetailedThreatSituation(unit, boss)
		if tanking or (status == 3) then
			return true
		end
	else--Check all of them if one isn't defined
		for i = 1, 5 do
			if UnitExists("boss"..i) then
				local tanking, status = UnitDetailedThreatSituation(unit, "boss"..i)
				if tanking or (status == 3) then
					return true
				end
			end
		end
	end
	return false
end

function bossModPrototype:IsHealer()
	return (class == "PALADIN" and (GetSpecialization() == 1))
	or (class == "SHAMAN" and (GetSpecialization() == 3))
	or (class == "DRUID" and (GetSpecialization() == 4))
	or (class == "PRIEST" and (GetSpecialization() ~= 3))
	or (class == "MONK" and (GetSpecialization() == 2))
end

function bossModPrototype:HasRaidCooldown()
	return class == "WARRIOR"--Rallying Cry/Demoralizing Banner
	or class == "PALADIN"--Aura Mastery
	or class == "ROGUE"--Smoke Bomb
	or (class == "PRIEST" and (GetSpecialization() == 1))--Power Word: Barrier
	or (class == "SHAMAN" and (GetSpecialization() == 3))--Spirit Link Totem
end

--These don't matter since they don't check talents
function bossModPrototype:IsPhysical()
	return self:IsMelee() or class == "HUNTER"
end

function bossModPrototype:CanRemoveEnrage()
	return class == "HUNTER" or class == "ROGUE" or class == "DRUID"
end

function bossModPrototype:IsMagicDispeller()
	return class == "MAGE" or class == "PRIEST" or class == "SHAMAN"
end

local Roleslist = {
	DEATHKNIGHT = function(uId)
		if UnitAura(uId, GetSpellInfo(48263)) then return "tank" end
		if UnitAura(uId, GetSpellInfo(48266)) then return "dps" end
		if UnitAura(uId, GetSpellInfo(48265)) then return "dps" end
	end,
	DRUID = function(uId)
		if UnitAura(uId, GetSpellInfo(5487))  then return "tank" end
		if UnitAura(uId, GetSpellInfo(768))   then return "dps" end
		if UnitAura(uId, GetSpellInfo(24858)) then return "dps" end
		if UnitAura(uId, GetSpellInfo(114282)) then return "healer" end
		return "healer"
	end,
	MAGE = "dps",
	HUNTER = "dps",	
	PALADIN = function(uId)
		if UnitLevel(uId) == 90 and UnitPowerMax(uId) > 200000 then return "healer" end
		if UnitAura(uId, GetSpellInfo(25780)) then return "tank" end
		return "dps"
	end,
	PRIEST = function(uId)
		if UnitAura(uId, GetSpellInfo(15473)) then return "dps" end
		return "healer"
	end,
	ROGUE = "dps",
	SHAMAN = function(uId)
		if UnitAura(uId, GetSpellInfo(52127)) then return "healer" end
		return "dps"
	end,
	WARLOCK = "dps",
	WARRIOR = function(uId)
		if UnitLevel(uId) == 90 and UnitHealthMax(uId) > 400000 then return "tank" end
		return "dps"
	end,
	MONK = function(uId)
		if UnitLevel(uId) == 90 and UnitPowerMax(uId) > 200000 then return "healer" end
		if UnitAura(uId, GetSpellInfo(115307)) then return "tank" end
		return "dps"
	end
}

function bossModPrototype:GetUnitRole(uId)
	uId = uId or "player"
	local _, uc = UnitClass(uId)
	local Checkunitrole = Roleslist[uc]
	if type(Checkunitrole) == "function" then Checkunitrole = Checkunitrole(uId) end
	return Checkunitrole
end

function bossModPrototype:UnitIsTank(uId)
	return self:GetUnitRole(uId) == "tank"
end

function bossModPrototype:UnitIsHealer(uId)
	return self:GetUnitRole(uId) == "healer"
end

function bossModPrototype:UnitIsDps(uId)
	return self:GetUnitRole(uId) == "dps"
end

----------------------------
--  Boss Health Function  --
----------------------------
function bossModPrototype:SetBossHealthInfo(...)
	self.bossHealthInfo = {...}
end

function bossModPrototype:SetMainBossID(cid)
	self.mainBossId = cid
end

function bossModPrototype:SetBossHPInfoToHighest()
	self.highesthealth = true
end

function bossModPrototype:GetBossHP(cId)
	for i = 1, 5 do
		local guid = UnitGUID("boss"..i)
		if guid and tonumber(guid:sub(6, 10), 16) == cId then
			return UnitHealth("boss"..i) / UnitHealthMax("boss"..i)
		end
	end
	local idType = (IsInRaid() and "raid") or "party"
	for i = 0, GetNumGroupMembers() do
		local unitId = ((i == 0) and "target") or idType..i.."target"
		local guid = UnitGUID(unitId)
		if guid and (tonumber(guid:sub(6, 10), 16)) == cId then
			return UnitHealth(unitId) / UnitHealthMax(unitId)
		end
	end
	return nil
end


-----------------------
--  Announce Object  --
-----------------------
do
	local textureCode = " |T%s:12:12|t "
	local textureExp = " |T(%S+......%S+):12:12|t "--Fix texture file including blank not strips(example: Interface\\Icons\\Spell_Frost_Ring of Frost). But this have limitations. Since I'm poor at regular expressions, this is not good fix. Do you have another good regular expression, tandanu?
	local announcePrototype = {}
	local mt = {__index = announcePrototype}

	-- TODO: is there a good reason that this is a weak table?
	local cachedColorFunctions = setmetatable({}, {__mode = "kv"})

	-- TODO: this function is an abomination, it needs to be rewritten. Also: check if these work-arounds are still necessary
	function announcePrototype:Show(...) -- todo: reduce amount of unneeded strings
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.DontShowBossAnnounces then return end	-- don't show the announces if the spam filter option is set
			local colorCode = ("|cff%.2x%.2x%.2x"):format(self.color.r * 255, self.color.g * 255, self.color.b * 255)
			local text
			if #self.combinedtext > 0 then--very ugly code. need tweaking. can cause script lan too long?
				local count = select("#", ...)
				-- create temporary arg table.
				local argTable = {}
				local pointToProcess = 0
				if count == 1 then
					pointToProcess = 1
					argTable[1] = select(1, ...)
				else
					for i = 1, select("#", ...) do
						local value = select(i, ...)
						if type(value) == "table" then
							pointToProcess = i
						end
						argTable[i] = value
					end
				end
				--Throttle spam.
				local displayText = table.concat(self.combinedtext, "<, >")
				if self.combinedcount == 1 then
					displayText = displayText.." "..DBM_CORE_GENERIC_WARNING_OTHERS
				elseif self.combinedcount > 1 then
					displayText = displayText.." "..DBM_CORE_GENERIC_WARNING_OTHERS2:format(self.combinedcount)
				end
				argTable[pointToProcess] = displayText
				text = ("%s%s%s|r%s"):format(
					(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
					colorCode,
					pformat(self.text, argTable[1], argTable[2], argTable[3], argTable[4], argTable[5]),
					(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
				)
			else
				text = ("%s%s%s|r%s"):format(
					(DBM.Options.WarningIconLeft and self.icon and textureCode:format(self.icon)) or "",
					colorCode,
					pformat(self.text, ...),
					(DBM.Options.WarningIconRight and self.icon and textureCode:format(self.icon)) or ""
				)
			end
			self.combinedcount = 0
			table.wipe(self.combinedtext)
			if not cachedColorFunctions[self.color] then
				local color = self.color -- upvalue for the function to colorize names, accessing self in the colorize closure is not safe as the color of the announce object might change (it would also prevent the announce from being garbage-collected but announce objects are never destroyed)
				cachedColorFunctions[color] = function(cap)
					cap = cap:sub(2, -2)
					local name = cap
					if DBM.Options.StripServerName then
						cap = cap:gsub("%-.*$", "")
					end
					if DBM:GetRaidClass(name) then
						local playerColor = RAID_CLASS_COLORS[DBM:GetRaidClass(name)] or color
						cap = ("|r|cff%.2x%.2x%.2x%s|r|cff%.2x%.2x%.2x"):format(playerColor.r * 255, playerColor.g * 255, playerColor.b * 255, cap, color.r * 255, color.g * 255, color.b * 255)
					end
					return cap
				end
			end
			text = text:gsub(">.-<", cachedColorFunctions[self.color])
			RaidNotice_AddMessage(RaidWarningFrame, text, ChatTypeInfo["RAID_WARNING"]) -- the color option doesn't work (at least it didn't work during the WotLK beta...todo: check this (this would save some of the WTFs))
			if DBM.Options.ShowWarningsInChat then
				if not DBM.Options.WarningIconChat then
					text = text:gsub(textureExp, "") -- textures @ chat frame can (and will) distort the font if using certain combinations of UI scale, resolution and font size TODO: is this still true as of cataclysm?
				end
				if DBM.Options.ShowFakedRaidWarnings then
					for i = 1, select("#", GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING")) do
						local frame = select(i, GetFramesRegisteredForEvent("CHAT_MSG_RAID_WARNING"))
						if frame ~= RaidWarningFrame and frame:GetScript("OnEvent") then
							frame:GetScript("OnEvent")(frame, "CHAT_MSG_RAID_WARNING", text, playerName, GetDefaultLanguage("player"), "", playerName, "", 0, 0, "", 0, 99, UnitGUID("player"))
						end
					end
				else
					self.mod:AddMsg(text, nil)
				end
			end
			if self.sound then
				if DBM.Options.UseMasterVolume then
					PlaySoundFile(DBM.Options.RaidWarningSound, "Master")
				else
					PlaySoundFile(DBM.Options.RaidWarningSound)
				end
			end
		end
	end

	function announcePrototype:CombinedShow(delay, ...)--very ugly code. need tweaking. can cause script lan too long?
		local count = select("#", ...)
		-- support only 5 args.
		if count > 5 then error("CombinedShow method only support up to 5 args", 2) end
		-- create temporary arg table.
		local argTable = {}
		local pointToCombine = 0
		if count == 1 then
			pointToCombine = 1
			argTable[1] = select(1, ...)
		else
			for i = 1, select("#", ...) do
				local value = select(i, ...)
				if type(value) == "string" then
					pointToCombine = i
				end
				argTable[i] = value
			end
		end
		-- process text combine.
		local text = select(pointToCombine, ...)
		if #self.combinedtext < 8 then--Throttle spam. We may not need more than 9 targets..
			self.combinedtext[#self.combinedtext + 1] = text or ""
		else
			self.combinedcount = self.combinedcount + 1
		end
		-- replace arg table
		argTable[pointToCombine] = self.combinedtext
		-- return to show method (up to 5 args)
		unschedule(self.Show, self.mod, self)
		schedule(delay or 0.5, self.Show, self.mod, self, argTable[1], argTable[2], argTable[3], argTable[4], argTable[5])
	end

	function announcePrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function announcePrototype:Cancel(...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	-- old constructor (no auto-localize)
	function bossModPrototype:NewAnnounce(text, color, icon, optionDefault, optionName, noSound)
		if not text then
			error("NewAnnounce: you must provide announce text", 2)
			return
		end
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				combinedtext = {},
				combinedcount = 0,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				sound = not noSound,
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = text
			self:AddBoolOption(obj.option, optionDefault, "announce")
		end
		tinsert(self.announces, obj)
		return obj
	end

	-- new constructor (auto-localized warnings and options, yay!)
	local function newAnnounce(self, announceType, spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, noSound, optionVersion)
		if not spellId then
			error("newAnnounce: you must provide spellId", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, color, icon, optionDefault, optionName, castTime, preWarnTime, noSound = color, icon, optionDefault, optionName, castTime, preWarnTime, noSound, temp
		end
		local unparsedId = spellId
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellId = string.sub(spellId, 3)
			spellName = EJ_GetSectionInfo(spellId) or DBM_CORE_UNKNOWN
		else
			spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		icon = icon or unparsedId
		local text
		if announceType == "cast" then
			local spellHaste = select(7, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			local timer = (select(7, GetSpellInfo(spellId)) or 1000) / spellHaste
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, castTime or (timer / 1000))
		elseif announceType == "prewarn" then
			if type(preWarnTime) == "string" then
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, preWarnTime)
			else
				text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(preWarnTime or 5))
			end
		elseif announceType == "phase" or announceType == "prephase" then
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(tostring(spellId))
		else
			text = DBM_CORE_AUTO_ANNOUNCE_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				combinedtext = {},
				combinedcount = 0,
				announceType = announceType,
				color = DBM.Options.WarningColors[color or 1] or DBM.Options.WarningColors[1],
				mod = self,
				icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode",
				sound = not noSound,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "announce")
		elseif not (optionName == false) then
			obj.option = "Announce"..unparsedId..announceType..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "announce")
			self.localization.options[obj.option] = DBM_CORE_AUTO_ANNOUNCE_OPTIONS[announceType]:format(unparsedId)
		end
		tinsert(self.announces, obj)
		return obj
	end

	function bossModPrototype:NewTargetAnnounce(spellId, color, ...)
		return newAnnounce(self, "target", spellId, color or 2, ...)
	end

	function bossModPrototype:NewTargetCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "targetcount", spellId, color or 2, ...)
	end

	function bossModPrototype:NewSpellAnnounce(spellId, color, ...)
		return newAnnounce(self, "spell", spellId, color or 3, ...)
	end

	function bossModPrototype:NewEndAnnounce(spellId, color, ...)
		return newAnnounce(self, "ends", spellId, color or 3, ...)
	end

	function bossModPrototype:NewFadesAnnounce(spellId, color, ...)
		return newAnnounce(self, "fades", spellId, color or 3, ...)
	end

	function bossModPrototype:NewAddsLeftAnnounce(spellId, color, ...)
		return newAnnounce(self, "adds", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCountAnnounce(spellId, color, ...)
		return newAnnounce(self, "count", spellId, color or 3, ...)
	end

	function bossModPrototype:NewStackAnnounce(spellId, color, ...)
		return newAnnounce(self, "stack", spellId, color or 2, ...)
	end

	function bossModPrototype:NewCastAnnounce(spellId, color, castTime, icon, optionDefault, optionName, noArg, noSound, optionVersion)
		local spellId, color, castTime, icon, optionDefault, optionName, noArg, noSound, optionVersion = spellId, color, castTime, icon, optionDefault, optionName, noArg, noSound, optionVersion
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, color, castTime, icon, optionDefault, optionName, noArg, noSound = color, castTime, icon, optionDefault, optionName, noArg, noSound, temp
		end
		return newAnnounce(self, "cast", spellId, color or 3, icon, optionDefault, optionName, castTime, nil, noSound, optionVersion)
	end

	function bossModPrototype:NewSoonAnnounce(spellId, color, ...)
		return newAnnounce(self, "soon", spellId, color or 1, ...)
	end

	function bossModPrototype:NewPreWarnAnnounce(spellId, time, color, icon, optionDefault, optionName, noArg, noSound, optionVersion)
		local spellId, time, color, icon, optionDefault, optionName, noArg, noSound, optionVersion = spellId, time, color, icon, optionDefault, optionName, noArg, noSound, optionVersion
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, time, color, icon, optionDefault, optionName, noArg, noSound = time, color, icon, optionDefault, optionName, noArg, noSound, temp
		end
		return newAnnounce(self, "prewarn", spellId, color or 1, icon, optionDefault, optionName, nil, time, noSound, optionVersion)
	end

	function bossModPrototype:NewPhaseAnnounce(phase, color, icon, ...)
		return newAnnounce(self, "phase", phase, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

	function bossModPrototype:NewPrePhaseAnnounce(phase, color, icon, ...)
		return newAnnounce(self, "prephase", phase, color or 1, icon or "Interface\\Icons\\Spell_Nature_WispSplode", ...)
	end

end

--------------------
--  Sound Object  --
--------------------
do
	local soundPrototype = {}
	local mt = { __index = soundPrototype }
	function bossModPrototype:NewSound(spellId, optionDefault, optionName, optionVersion)
		local spellId, optionDefault, optionName, optionVersion = spellId, optionDefault, optionName, optionVersion
		if type(optionName) == "boolean" and type(optionDefault) == "string" then
			local temp = optionDefault
			optionDefault = optionName
			optionName = temp
		end
		if not spellId and not optionName then
			error("NewSound: you must provide either spellId or optionName", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, optionDefault, optionName = optionDefault, optionName, temp
		end
		self.numSounds = self.numSounds and self.numSounds + 1 or 1
		local obj = setmetatable(
			{
				mod = self,
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound")
		elseif not (optionName == false) then
			obj.option = "Sound"..spellId..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "sound")
			self.localization.options[obj.option] = DBM_CORE_AUTO_SOUND_OPTION_TEXT:format(spellId)
		end
		return obj
	end
	bossModPrototype.NewRunAwaySound = bossModPrototype.NewSound

	function soundPrototype:Play(file)
		if not self.option or self.mod.Options[self.option] then
			if DBM.Options.UseMasterVolume then
				PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
			else
				PlaySoundFile(file or "Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg")
			end
		end
	end

	function soundPrototype:Schedule(t, ...)
		return schedule(t, self.Play, self.mod, self, ...)
	end

	function soundPrototype:Cancel(...)
		return unschedule(self.Play, self.mod, self, ...)
	end
end

------------------------
--  Countdown object  --
------------------------
do
	local countdownProtoType = {}
	local mt = {__index = countdownProtoType}

	local function showCountdown(timer)
		TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
	end

	local function stopCountdown()
		TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
	end

	function countdownProtoType:Start(timer, count)
		if not self.option or self.mod.Options[self.option] then
			timer = timer or self.timer or 10
			timer = timer < 2 and self.timer or timer
			count = count or self.count or 5
			if timer <= count then count = floor(timer) end
			if DBM.Options.ShowCountdownText and not (self.textDisabled or self.alternateVoice) then
				stopCountdown()
				if timer >= count then
					DBM:Schedule(timer-count, showCountdown, count)
				else
					DBM:Schedule(timer%1, showCountdown, floor(timer))
				end
			end
--[[		local voice = DBM.Options.CountdownVoice
			local voice2 = DBM.Options.CountdownVoice2
			if voice == "None" then return end
			if self.alternateVoice then--We already have an active countdown using primary voice, so fall back to secondary voice
				voice = voice2
			end
			if voice == "Mosh" then--Voice only goes to 5
				for i = count, 1, -1 do
					if i <= 5 then
						self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\"..i..".ogg")
					end
				end
			else--Voice that goes to 10
				for i = count, 1, -1 do
					self.sound5:Schedule(timer-i, "Interface\\AddOns\\DBM-Core\\Sounds\\"..voice.."\\"..i..".ogg")
				end
			end]]
			for i = count, 1, -1 do
				local countvaluei
				if i == 1 then countvaluei = "countone"
				elseif i == 2 then countvaluei = "counttwo"
				elseif i == 3 then countvaluei = "countthree"
				elseif i == 4 then countvaluei = "countfour"
				elseif i == 5 then countvaluei = "countfive"
				elseif i == 6 then countvaluei = "countsix"
				elseif i == 7 then countvaluei = "countseven"
				elseif i == 8 then countvaluei = "counteight"
				elseif i == 9 then countvaluei = "countnine"
				elseif i == 10 then countvaluei = "countten"
				elseif i == 11 then countvaluei = "counteleven" end
				if i <= 11 then
					self.sound5:Schedule(timer-i, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..countvaluei..".mp3")
				end
			end
		end
	end
	countdownProtoType.Show = countdownProtoType.Start

	function countdownProtoType:Schedule(t)
		return schedule(t, self.Start, self.mod, self)
	end

	function countdownProtoType:Cancel()
		if DBM.Options.ShowCountdownText and not self.textDisabled then
			DBM:Unschedule(showCountdown)
			stopCountdown()
		end
		self.mod:Unschedule(self.Start, self)
		self.sound1:Cancel()
		self.sound2:Cancel()
		self.sound3:Cancel()
		self.sound4:Cancel()
		self.sound5:Cancel()
	end
	countdownProtoType.Stop = countdownProtoType.Cancel

	function bossModPrototype:NewCountdown(timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
		local timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion = timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion
		if not spellId and not optionName then
			error("NewCountdown: you must provide either spellId or optionName", 2)
			return
		end
		if type(timer) == "string" and timer:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(timer, 14)
			timer, spellId, optionDefault, optionName, count, textDisabled, altVoice = spellId, optionDefault, optionName, count, textDisabled, altVoice, temp
		end
		if type(timer) == "string" and timer:match("Alt") then
			altVoice = true
			timer = tonumber(string.sub(timer, 4))
		end
		local sound5 = self:NewSound(5, true, false)
		local sound4 = self:NewSound(4, true, false)
		local sound3 = self:NewSound(3, true, false)
		local sound2 = self:NewSound(2, true, false)
		local sound1 = self:NewSound(1, true, false)
		timer = timer or 10
		count = count or 5
		spellId = spellId or 39505
		local obj = setmetatable(
			{
				id = optionName or "Countdown"..spellId..(optionVersion or ""),
				sound1 = sound1,
				sound2 = sound2,
				sound3 = sound3,
				sound4 = sound4,
				sound5 = sound5,
				timer = timer,
				count = count,
				textDisabled = textDisabled,
				alternateVoice = altVoice,
				mod = self
			},
			mt
		)
		if optionName then
			obj.option = obj.id
			self:AddBoolOption(obj.option, optionDefault, "sound")
		elseif not (optionName == false) then
			obj.option = obj.id
			self:AddBoolOption(obj.option, optionDefault, "sound")
			self.localization.options[obj.option] = DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT:format(spellId)
		end
		tinsert(self.countdowns, obj)
		return obj
	end

	function bossModPrototype:NewCountdownFades(timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion)
		local timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion = timer, spellId, optionDefault, optionName, count, textDisabled, altVoice, optionVersion
		if not spellId and not optionName then
			error("NewCountdownFades: you must provide either spellId or optionName", 2)
			return
		end
		if type(timer) == "string" and timer:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(timer, 14)
			timer, spellId, optionDefault, optionName, count, textDisabled, altVoice = spellId, optionDefault, optionName, count, textDisabled, altVoice, temp
		end
		if type(timer) == "string" and timer:match("Alt") then
			altVoice = true
			timer = tonumber(string.sub(timer, 4))
		end
		local sound5 = self:NewSound(5, true, false)
		local sound4 = self:NewSound(4, true, false)
		local sound3 = self:NewSound(3, true, false)
		local sound2 = self:NewSound(2, true, false)
		local sound1 = self:NewSound(1, true, false)
		timer = timer or 10
		count = count or 5
		spellId = spellId or 39505
		local obj = setmetatable(
			{
				id = optionName or "CountdownFades"..spellId..(optionVersion or ""),
				sound1 = sound1,
				sound2 = sound2,
				sound3 = sound3,
				sound4 = sound4,
				sound5 = sound5,
				timer = timer,
				count = count,
				textDisabled = textDisabled,
				alternateVoice = altVoice,
				mod = self
			},
			mt
		)
		if optionName then
			obj.option = obj.id
			self:AddBoolOption(obj.option, optionDefault, "sound")
		elseif not (optionName == false) then
			obj.option = obj.id
			self:AddBoolOption(obj.option, optionDefault, "sound")
			self.localization.options[obj.option] = DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2:format(spellId)
		end
		tinsert(self.countdowns, obj)
		return obj
	end
end

------------------------
--  Countout object  --
------------------------
do
	local countoutProtoType = {}
	local mt = {__index = countoutProtoType}

	function countoutProtoType:Start(timer)
		if not self.option or self.mod.Options[self.option] then
			timer = timer or self.timer or 10
			timer = timer <= 5 and self.timer or timer
--[[		local voice = DBM.Options.CountdownVoice
			if voice == "None" then return end
			if voice == "Mosh" and timer <= 5 then--Don't have 6-10 for him yet.
				for i = 1, timer do
					self.sound5:Schedule(i, "Interface\\AddOns\\DBM-Core\\Sounds\\Mosh\\"..i..".ogg")
				end
			else--Voices that go to 10
				for i = 1, timer do
					self.sound5:Schedule(i, "Interface\\AddOns\\DBM-Core\\Sounds\\"..voice.."\\"..i..".ogg")
				end
			end]]
			for i = 1, timer do
				local countvaluei
				if i == 1 then countvaluei = "countone"
				elseif i == 2 then countvaluei = "counttwo"
				elseif i == 3 then countvaluei = "countthree"
				elseif i == 4 then countvaluei = "countfour"
				elseif i == 5 then countvaluei = "countfive"
				elseif i == 6 then countvaluei = "countsix"
				elseif i == 7 then countvaluei = "countseven"
				elseif i == 8 then countvaluei = "counteight"
				elseif i == 9 then countvaluei = "countnine"
				elseif i == 10 then countvaluei = "countten"
				elseif i == 11 then countvaluei = "counteleven" end
				if i <= 11 then
					self.sound5:Schedule(timer-i, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..countvaluei..".mp3")
				end
			end
		end
	end

	function countoutProtoType:Schedule(t)
		return schedule(t, self.Start, self.mod, self)
	end

	function countoutProtoType:Cancel()
		self.mod:Unschedule(self.Start, self)
		self.sound1:Cancel()
		self.sound2:Cancel()
		self.sound3:Cancel()
		self.sound4:Cancel()
		self.sound5:Cancel()
	end
	countoutProtoType.Stop = countoutProtoType.Cancel

	function bossModPrototype:NewCountout(timer, spellId, optionDefault, optionName, optionVersion)
		local timer, spellId, optionDefault, optionName, optionVersion = timer, spellId, optionDefault, optionName, optionVersion
		if not spellId and not optionName then
			error("NewCountout: you must provide either spellId or optionName", 2)
			return
		end
		if type(timer) == "string" and timer:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(timer, 14)
			timer, spellId, optionDefault, optionName = spellId, optionDefault, optionName, temp
		end
		local sound5 = self:NewSound(5, true, false)
		local sound4 = self:NewSound(4, true, false)
		local sound3 = self:NewSound(3, true, false)
		local sound2 = self:NewSound(2, true, false)
		local sound1 = self:NewSound(1, true, false)
		timer = timer or 10
		spellId = spellId or 39505
		local obj = setmetatable(
			{
				sound1 = sound1,
				sound2 = sound2,
				sound3 = sound3,
				sound4 = sound4,
				sound5 = sound5,
				timer = timer,
				mod = self
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "sound")
		elseif not (optionName == false) then
			obj.option = "Countout"..spellId..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "sound")
			self.localization.options[obj.option] = DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT:format(spellId)
		end
		return obj
	end
end

--------------------
--  Yell Object  --
--------------------
do
	local yellPrototype = {}
	local mt = { __index = yellPrototype }
	function bossModPrototype:NewYell(spellId, yellText, optionDefault, optionName, chatType, optionVersion)
		local spellId, yellText, optionDefault, optionName, chatType, optionVersion = spellId, yellText, optionDefault, optionName, chatType, optionVersion
		if not spellId and not yellText then
			error("NewYell: you must provide either spellId or yellText", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, yellText, optionDefault, optionName, chatType = yellText, optionDefault, optionName, chatType, temp
		end
		local displayText
		if not yellText then
			if type(spellId) == "string" and spellId:match("ej%d+") then
				displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT:format(EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN)
			else
				displayText = DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT:format(GetSpellInfo(spellId) or DBM_CORE_UNKNOWN)
			end
		end
		local obj = setmetatable(
			{
				text = displayText or yellText,
				mod = self,
				chatType = chatType
			},
			mt
		)
		if optionName then
			obj.option = optionName
			self:AddBoolOption(obj.option, optionDefault, "misc")
		elseif not (optionName == false) then
			obj.option = "Yell"..(spellId or yellText)..(optionVersion or "")
			self:AddBoolOption(obj.option, optionDefault, "misc")
			self.localization.options[obj.option] = DBM_CORE_AUTO_YELL_OPTION_TEXT:format(spellId)
		end
		return obj
	end

	function yellPrototype:Yell(...)
		if not self.option or self.mod.Options[self.option] then
			SendChatMessage(self.text:format(...), self.chatType or "SAY")
		end
	end

	function yellPrototype:Schedule(t, ...)
		return schedule(t, self.Yell, self.mod, self, ...)
	end

	function yellPrototype:Cancel(...)
		return unschedule(self.Yell, self.mod, self, ...)
	end

	yellPrototype.Show = yellPrototype.Yell
end

------------------------------
--  Special Warning Object  --
------------------------------
do
	local frame = CreateFrame("Frame", nil, UIParent)
	local font = frame:CreateFontString(nil, "OVERLAY", "ZoneTextFont")
	frame:SetMovable(1)
	frame:SetWidth(1)
	frame:SetHeight(1)
	frame:SetFrameStrata("HIGH")
	frame:SetClampedToScreen()
	frame:Hide()
	font:SetWidth(1024)
	font:SetHeight(0)
	font:SetPoint("CENTER", 0, 0)

	local moving
	local specialWarningPrototype = {}
	local mt = {__index = specialWarningPrototype}

	function DBM:UpdateSpecialWarningOptions()
		frame:ClearAllPoints()
		frame:SetPoint(DBM.Options.SpecialWarningPoint, UIParent, DBM.Options.SpecialWarningPoint, DBM.Options.SpecialWarningX, DBM.Options.SpecialWarningY)
		font:SetFont(DBM.Options.SpecialWarningFont, DBM.Options.SpecialWarningFontSize, "THICKOUTLINE")
		font:SetTextColor(unpack(DBM.Options.SpecialWarningFontColor))
	end

	local shakeFrame = CreateFrame("Frame")
	shakeFrame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
	end)
	shakeFrame:Hide()

	frame:SetScript("OnUpdate", function(self, elapsed)
		self.timer = self.timer - elapsed
		if self.timer >= 3 and self.timer <= 4 then
			if not self.healthFrameHidden then
				LowHealthFrame:SetAlpha(self.timer - 3)
			end
		elseif self.timer <= 2 then
			frame:SetAlpha(self.timer/2)
		elseif self.timer <= 0 then
			if not self.healthFrameHidden then
				LowHealthFrame:Hide()
			end
			frame:Hide()
		end
	end)

	function specialWarningPrototype:Show(...)
		if DBM.Options.ShowSpecialWarnings and (not self.option or self.mod.Options[self.option]) and not moving and frame then
			local msg = pformat(self.text, ...)
			local stripName = function(cap)
				cap = cap:sub(2, -2)
				if DBM.Options.StripServerName then
					cap = cap:gsub("%-.*$", "")
				end
				return cap
			end
			msg = msg:gsub(">.-<", stripName)
			font:SetText(msg)
			if not UnitIsDeadOrGhost("player") and DBM.Options.ShowFlashFrame then
				if self.flash == 1 then
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol1[1],DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3], DBM.Options.SpecialWarningFlashDura1, DBM.Options.SpecialWarningFlashAlph1)
				elseif self.flash == 2 then
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol2[1],DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3], DBM.Options.SpecialWarningFlashDura2, DBM.Options.SpecialWarningFlashAlph2)
				elseif self.flash == 3 then
					DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol3[1],DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3], DBM.Options.SpecialWarningFlashDura3, DBM.Options.SpecialWarningFlashAlph3)
				end
			end
			frame:Show()
			frame:SetAlpha(1)
			frame.timer = 5
			if self.sound then
				local soundId = self.option and self.mod.Options[self.option .. "SpecialWarningSound"] or self.flash
				DBM:PlaySpecialWarningSound(soundId or 1)
			end
		end
	end

	function specialWarningPrototype:DelayedShow(delay, ...)
		unschedule(self.Show, self.mod, self, ...)
		schedule(delay or 0.5, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Schedule(t, ...)
		return schedule(t, self.Show, self.mod, self, ...)
	end

	function specialWarningPrototype:Cancel(t, ...)
		return unschedule(self.Show, self.mod, self, ...)
	end

	function bossModPrototype:NewSpecialWarning(text, optionDefault, optionName, noSound, runSound)
		if not text then
			error("NewSpecialWarning: you must provide special warning text", 2)
			return
		end
        if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		local flash
		local obj = setmetatable(
			{
				text = self.localization.warnings[text],
				mod = self,
				sound = not noSound,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
			},
			mt
		)
		local optionId = optionName or optionName ~= false and text
		if optionId then
			obj.option = optionId
			self:AddSpecialWarningOption(optionId, optionDefault, runSound, "specannounce")
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	local function newSpecialWarning(self, announceType, spellId, stacks, optionDefault, optionName, noSound, runSound, optionVersion)
		local spellId, stacks, optionDefault, optionName, noSound, runSound, optionVersion = spellId, stacks, optionDefault, optionName, noSound, runSound, optionVersion
		if not spellId then
			error("newSpecialWarning: you must provide spellId", 2)
			return
		end
		if type(spellId) == "string" and spellId:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(spellId, 14)
			spellId, optionDefault, optionName, noSound, runSound = optionDefault, optionName, noSound, runSound, temp
		end
		if runSound == true then
			runSound = 2
		elseif not runSound then
			runSound = 1
		end
		local spellName
		if type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = EJ_GetSectionInfo(string.sub(spellId, 3)) or DBM_CORE_UNKNOWN
		else
			spellName = GetSpellInfo(spellId) or DBM_CORE_UNKNOWN
		end
		local text
		local flash
		if announceType == "prewarn" then
			if type(stacks) == "string" then
				text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, stacks)
			else
				text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName, DBM_CORE_SEC_FMT:format(stacks or 5))
			end
		else
			text = DBM_CORE_AUTO_SPEC_WARN_TEXTS[announceType]:format(spellName)
		end
		local obj = setmetatable( -- todo: fix duplicate code
			{
				text = text,
				announceType = announceType,
				mod = self,
				sound = not noSound,
				flash = runSound,--Set flash color to hard coded runsound (even if user sets custom sounds)
			},
			mt
		)
		if optionName then
			obj.option = optionName
		elseif not (optionName == false) then
			obj.option = "SpecWarn"..spellId..announceType..(optionVersion or "")
			if announceType == "stack" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 3, spellId)
			elseif announceType == "prewarn" then
				self.localization.options[obj.option] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(stacks or 5, spellId)
			else
				self.localization.options[obj.option] = DBM_CORE_AUTO_SPEC_WARN_OPTIONS[announceType]:format(spellId)
			end
		end
		if obj.option then
			self:AddSpecialWarningOption(obj.option, optionDefault, runSound, "specannounce")
		end
		tinsert(self.specwarns, obj)
		return obj
	end

	function bossModPrototype:NewSpecialWarningSpell(text, optionDefault, ...)
		return newSpecialWarning(self, "spell", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningEnd(text, optionDefault, ...)
		return newSpecialWarning(self, "ends", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningFades(text, optionDefault, ...)
		return newSpecialWarning(self, "fades", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningSoon(text, optionDefault, ...)
		return newSpecialWarning(self, "soon", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningDispel(text, optionDefault, ...)
		return newSpecialWarning(self, "dispel", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningInterrupt(text, optionDefault, ...)
		return newSpecialWarning(self, "interrupt", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningYou(text, optionDefault, ...)
		return newSpecialWarning(self, "you", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningTarget(text, optionDefault, ...)
		return newSpecialWarning(self, "target", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningClose(text, optionDefault, ...)
		return newSpecialWarning(self, "close", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningMove(text, optionDefault, ...)
		return newSpecialWarning(self, "move", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningRun(text, optionDefault, ...)
		return newSpecialWarning(self, "run", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCast(text, optionDefault, ...)
		return newSpecialWarning(self, "cast", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningReflect(text, optionDefault, ...)
		return newSpecialWarning(self, "reflect", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningCount(text, optionDefault, ...)
		return newSpecialWarning(self, "count", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningStack(text, optionDefault, stacks, optionName, noSound, runSound, optionVersion)
		if type(text) == "string" and text:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(text, 14)
			text, optionDefault, stacks, optionName, noSound, runSound = optionDefault, stacks, optionName, noSound, runSound, temp
		end
		return newSpecialWarning(self, "stack", text, stacks, optionDefault, optionName, noSound, runSound, optionVersion)
	end

	function bossModPrototype:NewSpecialWarningSwitch(text, optionDefault, ...)
		return newSpecialWarning(self, "switch", text, nil, optionDefault, ...)
	end

	function bossModPrototype:NewSpecialWarningPreWarn(text, optionDefault, time, optionName, noSound, runSound, optionVersion)
		if type(text) == "string" and text:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(text, 14)
			text, optionDefault, time, optionName, noSound, runSound = optionDefault, time, optionName, noSound, runSound, temp
		end
		return newSpecialWarning(self, "prewarn", text, time, optionDefault, optionName, noSound, runSound, optionVersion)
	end

	function DBM:PlayCountSound(number, forceVoice)
		if number > 10 or number < 1 then return end
--[[		local voice, voice2
		if forceVoice then--Primarlly for options
			voice = forceVoice
		else
			voice = DBM.Options.CountdownVoice
			voice2 = DBM.Options.CountdownVoice2
		end
		if number > 5 and (voice == "Mosh") then--Can't count past 5
			if voice ~= voice2 then
				voice = voice2--Fall back to secondary voice option if primary is mosh
			else--Voice 1 and voice 2 were both set to "Mosh", they must really like mosh. At this point we must ignore their preference
				voice = "Corsica"
			end
		end--If number is higher than 5 and users primary voice setting ismosh, fallback to secondary voice setting]]
		local voice = DBM.Options.CountdownVoice
		local countvaluenumber
		if number == 1 then countvaluenumber = "countone"				
		elseif number == 2 then countvaluenumber = "counttwo"					
		elseif number == 3 then countvaluenumber = "countthree"
		elseif number == 4 then countvaluenumber = "countfour"
		elseif number == 5 then countvaluenumber = "countfive"
		elseif number == 6 then countvaluenumber = "countsix"
		elseif number == 7 then countvaluenumber = "countseven"
		elseif number == 8 then countvaluenumber = "counteight"
		elseif number == 9 then countvaluenumber = "countnine"
		elseif number == 10 then countvaluenumber = "countten" end
		if DBM.Options.UseMasterVolume then
			PlaySoundFile("Interface\\AddOns\\"..voice.."\\"..countvaluenumber..".mp3", "Master")
		else
			PlaySoundFile("Interface\\AddOns\\"..voice.."\\"..countvaluenumber..".mp3")
		end
	end

	function DBM:PlaySpecialWarningSound(soundId)
		local sound = type(soundId) == "number" and DBM.Options["SpecialWarningSound" .. (soundId == 1 and "" or soundId)] or soundId or DBM.Options.SpecialWarningSound
		if DBM.Options.UseMasterVolume then
			PlaySoundFile(sound, "Master")
		else
			PlaySoundFile(sound)
		end
	end

	do
		local anchorFrame
		local function moveEnd()
			moving = false
			anchorFrame:Hide()
			frame.timer = 1.5 -- fade out
			frame:SetFrameStrata("HIGH")
			DBM:Unschedule(moveEnd)
			DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
		end

		function DBM:MoveSpecialWarning()
			if not anchorFrame then
				anchorFrame = CreateFrame("Frame", nil, frame)
				anchorFrame:SetWidth(32)
				anchorFrame:SetHeight(32)
				anchorFrame:EnableMouse(true)
				anchorFrame:SetPoint("CENTER", 0, -32)
				anchorFrame:RegisterForDrag("LeftButton")
				anchorFrame:SetClampedToScreen()
				anchorFrame:Hide()
				local texture = anchorFrame:CreateTexture()
				texture:SetTexture("Interface\\Addons\\DBM-GUI\\textures\\dot.blp")
				texture:SetPoint("CENTER", anchorFrame, "CENTER", 0, 0)
				texture:SetWidth(32)
				texture:SetHeight(32)
				anchorFrame:SetScript("OnDragStart", function()
					frame:StartMoving()
					self:Unschedule(moveEnd)
					DBM.Bars:CancelBar(DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
				anchorFrame:SetScript("OnDragStop", function()
					frame:StopMovingOrSizing()
					local point, _, _, xOfs, yOfs = frame:GetPoint(1)
					DBM.Options.SpecialWarningPoint = point
					DBM.Options.SpecialWarningX = xOfs
					DBM.Options.SpecialWarningY = yOfs
					self:Schedule(15, moveEnd)
					DBM.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				end)
			end
			if anchorFrame:IsShown() then
				moveEnd()
			else
				moving = true
				anchorFrame:Show()
				self:Schedule(15, moveEnd)
				DBM.Bars:CreateBar(15, DBM_CORE_MOVE_SPECIAL_WARNING_BAR)
				font:SetText(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
				frame:Show()
				frame:SetFrameStrata("TOOLTIP")
				frame:SetAlpha(1)
				frame.timer = mhuge
			end
		end
	end

	local function testWarningEnd()
		frame:SetFrameStrata("HIGH")
	end

	function DBM:ShowTestSpecialWarning(text, number)
		if moving then
			return
		end
		font:SetText(DBM_CORE_MOVE_SPECIAL_WARNING_TEXT)
		frame:Show()
		frame:SetAlpha(1)
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(3, testWarningEnd)
		frame.timer = 3
		DBM:PlaySpecialWarningSound(number)
		if DBM.Options.ShowFlashFrame then
			if number == 1 then
				DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol1[1],DBM.Options.SpecialWarningFlashCol1[2], DBM.Options.SpecialWarningFlashCol1[3], DBM.Options.SpecialWarningFlashDura1, DBM.Options.SpecialWarningFlashAlph1)
			elseif number == 2 then
				DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol2[1],DBM.Options.SpecialWarningFlashCol2[2], DBM.Options.SpecialWarningFlashCol2[3], DBM.Options.SpecialWarningFlashDura2, DBM.Options.SpecialWarningFlashAlph2)
			elseif number == 3 then
				DBM.Flash:Show(DBM.Options.SpecialWarningFlashCol3[1],DBM.Options.SpecialWarningFlashCol3[2], DBM.Options.SpecialWarningFlashCol3[3], DBM.Options.SpecialWarningFlashDura3, DBM.Options.SpecialWarningFlashAlph3)
			end
		end
	end
end

------------------------------
--  LT Special Warning Object  --
------------------------------

do
	local frame, font, moving, showendnote, icon, cooldownframe
	local function createFrame()
		frame = CreateFrame("Frame", nil, UIParent)
		frame:SetWidth(400)
		frame:SetHeight(50)
		frame:SetMovable(true)
		frame:SetPoint(DBM.Options.LTSpecialWarningPoint, DBM.Options.LTSpecialWarningX, DBM.Options.LTSpecialWarningY)
		font = frame:CreateFontString()	
		font:SetDrawLayer("OVERLAY")
		font:SetFont(DBM.Options.LTSpecialWarningFont, DBM.Options.LTSpecialWarningFontSize, "THICKOUTLINE")
		font:SetTextColor(unpack(DBM.Options.LTSpecialWarningFontColor))
		font:SetPoint("CENTER", 0, 0)
		icon = frame:CreateTexture( nil, "ARTWORK" )
		icon:SetPoint("CENTER", 0, DBM.Options.LTSpecialWarningFontSize <= 33 and DBM.Options.LTSpecialWarningFontSize + 15 or 48)
		cooldownframe = CreateFrame("Cooldown", cooldownframe, frame)
		cooldownframe:SetAllPoints(icon)
		frame:Hide()
	end
	
	function DBM:UpdateLTSpecialWarningOptions()
		if not frame then
			createFrame()
		end
		frame:ClearAllPoints()
		frame:SetPoint(DBM.Options.LTSpecialWarningPoint, DBM.Options.LTSpecialWarningX, DBM.Options.LTSpecialWarningY)
		font:SetFont(DBM.Options.LTSpecialWarningFont, DBM.Options.LTSpecialWarningFontSize, "THICKOUTLINE")
		font:SetTextColor(unpack(DBM.Options.LTSpecialWarningFontColor))
	end
	
	function DBM:ShowLTSpecialWarning(text, r, g, b, shake, iconspellid, hidetime, cdtime)
		if (not DBM.Options.ShowLTSpecialWarnings) or (not text) then return end
		if not frame then
			createFrame()
		end
		frame:Show()
		moving = false
		frame:EnableMouse(false)
		if type(text) == "number" then text = GetSpellInfo(text) end
		font:SetText(text)
		if r and g and b then
			font:SetTextColor(r, g, b, 1)
		else
			font:SetTextColor(unpack(DBM.Options.LTSpecialWarningFontColor))
		end
		if iconspellid then
			local _, _, texture = GetSpellInfo(tostring(iconspellid))
			icon:SetTexture(texture)
		else
			icon:SetTexture(nil)
		end
		if shake then
			local shaketime = 0.3
			frame:SetScript("OnUpdate", function(self, e)
				shaketime = shaketime + e
				if shaketime <= shake then
					local Amt = 30 / (1 + 10*(300^(-(shake))))
					local moveX = random(-Amt, Amt)
					local moveY = random(-Amt, Amt)
					font:SetPoint("CENTER", moveX, moveY)
					if iconspellid then
						icon:SetPoint("CENTER", moveX, DBM.Options.LTSpecialWarningFontSize <= 33 and DBM.Options.LTSpecialWarningFontSize + 15 + moveY or 48 + moveY)
					end
				else
					font:SetPoint("CENTER", 0, 0)
					icon:SetPoint("CENTER", 0, DBM.Options.LTSpecialWarningFontSize <= 33 and DBM.Options.LTSpecialWarningFontSize + 15 or 48)
				end
			end)
		end
		if hidetime then
			self:Schedule(hidetime, function() DBM:HideLTSpecialWarning() end)
		end
		if cdtime then
			cooldownframe:SetCooldown(GetTime(), cdtime)
		end
	end
--	/run DBM:ShowLTSpecialWarning(145987, 1, 0, 0, 1, 145987, nil, 15)
	function DBM:HideLTSpecialWarning()
		if frame and frame:IsShown() then
			frame:Hide()
		end
	end
	
	function DBM:MoveLTSpecialWarning()
		if not frame then
			createFrame()
		end		
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function(self)
			frame:StartMoving()
		end)
		frame:SetScript("OnDragStop", function(self)
			frame:StopMovingOrSizing()
			local point, _, _, x, y = self:GetPoint(1)
			DBM.Options.LTSpecialWarningPoint = point
			DBM.Options.LTSpecialWarningX = x
			DBM.Options.LTSpecialWarningY = y
		end)
		if frame:IsShown() then
			if moving then
				frame:EnableMouse(false)
				frame:Hide()
			else
				font:SetText(DBM_GUI_Translations.BarWhileMove)
				moving = true
				frame:EnableMouse(true)
				frame:SetFrameStrata("TOOLTIP")
			end
		else
			font:SetText(DBM_GUI_Translations.BarWhileMove)
			frame:Show()
			moving = true
			frame:EnableMouse(true)
			frame:SetFrameStrata("TOOLTIP")
		end
	end
	
	local function testWarningEnd()
		DBM:HideLTSpecialWarning()
		if not showendnote then
			DBM:AddMsg(DBM_GUI_Translations.TestWarningEnd)
			showendnote = true
		end
	end
	
	function DBM:ShowTestLTSpecialWarning()
		if not frame then
			createFrame()
		end
		moving = false
		frame:EnableMouse(false)
		font:SetText(DBM_GUI_Translations.Panel_LTSpecWarnFrame)
		frame:Show()
		frame:SetFrameStrata("TOOLTIP")
		self:Unschedule(testWarningEnd)
		self:Schedule(5, testWarningEnd)
	end
end

--------------------
--  Timer Object  --
--------------------
do
	local timerPrototype = {}
	local mt = {__index = timerPrototype}

	function timerPrototype:Start(timer, ...)
		--Move entire coundown object here and eliminate seperate countdown options.
		--Timers should have a popup of their own with "none" "5" and "10" options for countdown voice.
		--Which voice that's used still controled by primary setting in gui still. Working on GUI will be changed to "primary"
		--Smart coding in this function to check if any audio countdowns are currently running if we are to start another one, if so, use a voice not currently running? else, always prefer users primary preference.
		--Maybe add a preferred voice order if more voices get added to mod?
		if timer and type(timer) ~= "number" then
			return self:Start(nil, timer, ...) -- first argument is optional!
		end
		if not self.option or self.mod.Options[self.option] then
			local timer = timer and ((timer > 0 and timer) or self.timer + timer) or self.timer
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			local bar = DBM.Bars:CreateBar(timer, id, self.icon)
			if not bar then
				return false, "error" -- creating the timer failed somehow, maybe hit the hard-coded timer limit of 15
			end
			local msg = ""
			if self.type and not self.text then
				msg = pformat(self.mod:GetLocalizedTimerText(self.type, self.spellId), ...)
			else
				msg = pformat(self.text, ...)
			end
			local stripName = function(cap)
				cap = cap:sub(2, -2)
				if DBM.Options.StripServerName then
					cap = cap:gsub("%-.*$", "")
				end
				return cap
			end
			msg = msg:gsub(">.-<", stripName)
			bar:SetText(msg)
			tinsert(self.startedTimers, id)
			self.mod:Unschedule(removeEntry, self.startedTimers, id)
			self.mod:Schedule(timer, removeEntry, self.startedTimers, id)
			return bar
		else
			return false, "disabled"
		end
	end
	timerPrototype.Show = timerPrototype.Start

	function timerPrototype:DelayedStart(delay, ...)
		unschedule(self.Start, self.mod, self, ...)
		schedule(delay or 0.5, self.Start, self.mod, self, ...)
	end
	timerPrototype.DelayedShow = timerPrototype.DelayedStart

	function timerPrototype:Schedule(t, ...)
		return schedule(t, self.Start, self.mod, self, ...)
	end

	function timerPrototype:Unschedule(t, ...)
		return unschedule(self.Start, self.mod, self, ...)
	end

	function timerPrototype:Stop(...)
		if select("#", ...) == 0 then
			for i = #self.startedTimers, 1, -1 do
				DBM.Bars:CancelBar(self.startedTimers[i])
				self.startedTimers[i] = nil
			end
		else
			local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
			for i = #self.startedTimers, 1, -1 do
				if self.startedTimers[i] == id then
					DBM.Bars:CancelBar(id)
					tremove(self.startedTimers, i)
				end
			end
		end
	end

	function timerPrototype:Cancel(...)
		self:Stop(...)
		self:Unschedule(...)
	end

	function timerPrototype:GetTime(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0, (bar and bar.timer) or 0
		else
			for i = 1, 100 do
				id = id.."\t"..i
				bar = DBM.Bars:GetBar(id)
				if bar then
					break
				else
					id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
				end
			end
			return bar and (bar.totalTime - bar.timer) or 0, (bar and bar.totalTime) or 0, (bar and bar.timer) or 0
		end				
	end

	function timerPrototype:IsStarted(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		return bar and true
	end

	function timerPrototype:SetTimer(timer)
		self.timer = timer
	end

	function timerPrototype:Update(elapsed, totalTime, ...)
		if self:GetTime(...) == 0 then
			self:Start(totalTime, ...)
		end
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		return DBM.Bars:UpdateBar(id, elapsed, totalTime)
	end

	function timerPrototype:UpdateIcon(icon, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetIcon((type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode")
		end
	end

	function timerPrototype:UpdateName(name, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetText(name)
		end
	end

	function timerPrototype:SetColor(c, ...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			return bar:SetColor(c)
		end
	end

	function timerPrototype:DisableEnlarge(...)
		local id = self.id..pformat((("\t%s"):rep(select("#", ...))), ...)
		local bar = DBM.Bars:GetBar(id)
		if bar then
			bar.small = true
		end
	end

	function timerPrototype:AddOption(optionDefault, optionName)
		--Do some stuff if countdownDefault isn't nil to make audio countdown checkbox for this timer on by default
		if optionName ~= false then
			self.option = optionName or self.id
			self.mod:AddBoolOption(self.option, optionDefault, "timer")
		end
	end

	function bossModPrototype:NewTimer(timer, name, icon, optionDefault, optionName, r, g, b, countdownDefault)--countdownDefault should be a number, such as 5 or 10 hard coded in boss mod to say "audio countdown is on by default for this timer and default count start point is 5 or 10
		local icon = (type(icon) == "string" and icon:match("ej%d+") and select(4, EJ_GetSectionInfo(string.sub(icon, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(icon, 3)))) or (type(icon) == "number" and select(3, GetSpellInfo(icon))) or icon or "Interface\\Icons\\Spell_Nature_WispSplode"
		local obj = setmetatable(
			{
				text = self.localization.timers[name],
				timer = timer,
				id = name,
				icon = icon,
				r = r,
				g = g,
				b = b,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)--countdownDefault
		tinsert(self.timers, obj)
		return obj
	end

	-- new constructor for the new auto-localized timer types
	-- note that the function might look unclear because it needs to handle different timer types, especially achievement timers need special treatment
	-- todo: disable the timer if the player already has the achievement and when the ACHIEVEMENT_EARNED event is fired
	-- problem: heroic/normal achievements :[
	-- local achievementTimers = {}
	local function newTimer(self, timerType, timer, spellId, timerText, optionDefault, optionName, texture, r, g, b, countdownDefault, optionVersion)--countdownDefault should be a number, such as 5 or 10 hard coded in boss mod to say "audio countdown is on by default for this timer and default count start point is 5 or 10
		if type(timer) == "string" and timer:match("OptionVersion") then
			local temp = optionVersion
			optionVersion = string.sub(timer, 14)
			timer, spellId, timerText, optionDefault, optionName, texture, r, g, b, countdownDefault = spellId, timerText, optionDefault, optionName, texture, r, g, b, countdownDefault, temp
		end
		-- new argument timerText is optional (usually only required for achievement timers as they have looooong names)
		if type(timerText) == "boolean" or type(optionDefault) == "string" then -- check if the argument was skipped
			return newTimer(self, timerType, timer, spellId, nil, timerText, optionDefault, optionName, texture, r, g, b, countdownDefault, optionVersion)
		end
		local spellName, icon
		local unparsedId = spellId
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
			icon = type(texture) == "number" and select(10, GetAchievementInfo(texture)) or texture or spellId and select(10, GetAchievementInfo(spellId))
--			if optionDefault == nil then
--				local completed = select(4, GetAchievementInfo(spellId))
--				optionDefault = not completed
--			end
		else
			if type(spellId) == "string" and spellId:match("ej%d+") then
				spellName = EJ_GetSectionInfo(string.sub(spellId, 3)) or ""
			else
				spellName = GetSpellInfo(spellId or 0)
			end
			if spellName then
				icon = type(texture) == "number" and select(3, GetSpellInfo(texture)) or texture or type(spellId) == "string" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) ~= "" and select(4, EJ_GetSectionInfo(string.sub(spellId, 3))) or (type(spellId) == "number" and select(3, GetSpellInfo(spellId)))
			else
				icon = nil
			end
		end
		spellName = spellName or tostring(spellId)
		local id = "Timer"..(spellId or 0)..timerType..(optionVersion or "")
		local obj = setmetatable(
			{
				text = self.localization.timers[timerText],
				type = timerType,
				spellId = spellId,
				timer = timer,
				id = id,
				icon = icon,
				r = r,
				g = g,
				b = b,
				startedTimers = {},
				mod = self,
			},
			mt
		)
		obj:AddOption(optionDefault, optionName)--countdownDefault
		tinsert(self.timers, obj)
		-- todo: move the string creation to the GUI with SetFormattedString...
		if timerType == "achievement" then
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(GetAchievementLink(spellId):gsub("%[(.+)%]", "%1"))
		else
			self.localization.options[id] = DBM_CORE_AUTO_TIMER_OPTIONS[timerType]:format(unparsedId)
		end
		return obj
	end

	function bossModPrototype:NewTargetTimer(...)
		return newTimer(self, "target", ...)
	end

	function bossModPrototype:NewBuffActiveTimer(...)
		return newTimer(self, "active", ...)
	end

	function bossModPrototype:NewBuffFadesTimer(...)
		return newTimer(self, "fades", ...)
	end

	function bossModPrototype:NewCastTimer(timer, ...)
		if tonumber(timer) and timer > 1000 then -- hehe :) best hack in DBM. This makes the first argument optional, so we can omit it to use the cast time from the spell id ;)
			local spellId = timer
			timer = select(7, GetSpellInfo(spellId)) or 1000 -- GetSpellInfo takes YOUR spell haste into account...WTF?
			local spellHaste = select(7, GetSpellInfo(53142)) / 10000 -- 53142 = Dalaran Portal, should have 10000 ms cast time
			timer = timer / spellHaste -- calculate the real cast time of the spell...
			return self:NewCastTimer(timer / 1000, spellId, ...)
		end
		return newTimer(self, "cast", timer, ...)
	end

	function bossModPrototype:NewCDTimer(...)
		return newTimer(self, "cd", ...)
	end

	function bossModPrototype:NewCDCountTimer(...)
		return newTimer(self, "cdcount", ...)
	end

	function bossModPrototype:NewCDSourceTimer(...)
		return newTimer(self, "cdsource", ...)
	end

	function bossModPrototype:NewNextTimer(...)
		return newTimer(self, "next", ...)
	end

	function bossModPrototype:NewNextCountTimer(...)
		return newTimer(self, "nextcount", ...)
	end

	function bossModPrototype:NewNextSourceTimer(...)
		return newTimer(self, "nextsource", ...)
	end

	function bossModPrototype:NewAchievementTimer(...)
		return newTimer(self, "achievement", ...)
	end

	function bossModPrototype:GetLocalizedTimerText(timerType, spellId)
		local spellName
		if timerType == "achievement" then
			spellName = select(2, GetAchievementInfo(spellId))
		elseif type(spellId) == "string" and spellId:match("ej%d+") then
			spellName = EJ_GetSectionInfo(string.sub(spellId, 3))
		else
			spellName = GetSpellInfo(spellId)
		end
		return pformat(DBM_CORE_AUTO_TIMER_TEXTS[timerType], spellName)
	end
end


------------------------------
--  Berserk/Combat Objects  --
------------------------------
do
	local enragePrototype = {}
	local mt = {__index = enragePrototype}

	local function countDownTextDelay(timer)
		TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
	end

	function enragePrototype:Start(timer)
		timer = timer or self.timer or 600
		timer = timer <= 0 and self.timer - timer or timer
		self.bar:SetTimer(timer)
		self.bar:Start()
		if self.warning1 then
			if timer > 660 then self.warning1:Schedule(timer - 600, 10, DBM_CORE_MIN) end
			if timer > 300 then self.warning1:Schedule(timer - 300, 5, DBM_CORE_MIN) end
			if timer > 180 then self.warning2:Schedule(timer - 180, 3, DBM_CORE_MIN) end
		end
		if self.warning2 then
			if timer > 60 then self.warning2:Schedule(timer - 60, 1, DBM_CORE_MIN) end
			if timer > 30 then self.warning2:Schedule(timer - 30, 30, DBM_CORE_SEC) end
			if timer > 10 then self.warning2:Schedule(timer - 10, 10, DBM_CORE_SEC) end
		end
		if self.countdown then
			if not DBM.Options.DontPlayPTCountdown then
				self.countdown:Start(timer)
			end
			if not DBM.Options.DontShowPTCountdownText then
				local threshold = DBM.Options.PTCountThreshold
				if timer > threshold then
					DBM:Schedule(timer-threshold, countDownTextDelay, threshold)
				else
					TimerTracker_OnEvent(TimerTracker, "START_TIMER", 2, timer, timer)
				end
			end
		end
	end

	function enragePrototype:Schedule(t)
		return self.owner:Schedule(t, self.Start, self)
	end

	function enragePrototype:Cancel()
		self.owner:Unschedule(self.Start, self)
		if self.warning1 then
			self.warning1:Cancel()
		end
		if self.warning2 then
			self.warning2:Cancel()
		end
		if self.countdown then
			DBM:Unschedule(countDownTextDelay)
			self.countdown:Cancel()
			TimerTracker_OnEvent(TimerTracker, "PLAYER_ENTERING_WORLD")
		end
		self.bar:Stop()
	end
	enragePrototype.Stop = enragePrototype.Cancel

	function bossModPrototype:NewBerserkTimer(timer, text, barText, barIcon)
		timer = timer or 600
		local warning1 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
		local warning2 = self:NewAnnounce(text or DBM_CORE_GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_BERSERK, barIcon or 28131, nil, "timer_berserk")
		local obj = setmetatable(
			{
				warning1 = warning1,
				warning2 = warning2,
				bar = bar,
				timer = timer,
				owner = self
			},
			mt
		)
		return obj
	end

	function bossModPrototype:NewCombatTimer(timer, text, barText, barIcon)
		timer = timer or 10
		local bar = self:NewTimer(timer, barText or DBM_CORE_GENERIC_TIMER_COMBAT, barIcon or 2457, nil, "timer_combat")
		local countdown = self:NewCountdown(0, 0, nil, DBM_CORE_GENERIC_TIMER_COMBAT, nil, true)
		local obj = setmetatable(
			{
				bar = bar,
				timer = timer,
				countdown = countdown,
				owner = self
			},
			mt
		)
		return obj
	end
end


--------------------------
--  Shield Health Bars  --
--------------------------

do
	local frame = CreateFrame("Frame") -- frame for CLEU events, we don't want to run all *_MISSED events through the whole DBM event system...
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	local activeShields = {}
	local shieldsByGuid = {}

	local function getShieldHPFunc(shieldInfo)
		return function()
			return mmax(1, floor(shieldInfo.absorbRemaining / shieldInfo.maxAbsorb * 100))
		end
	end

	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
			local shieldInfo = destGUID and shieldsByGuid[destGUID]
			if shieldInfo then
				local absorbed
				if subEvent == "SWING_MISSED" then
					absorbed = select(3, ...)
				elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then
					absorbed = select(6, ...)
				end
				if absorbed then
					shieldInfo.absorbRemaining = shieldInfo.absorbRemaining - absorbed
				end
			end
	end)

	function bossModPrototype:ShowShieldHealthBar(guid, spellId, absorb)
		self:RemoveShieldHealthBar(guid, spellId)
		local obj = {
			mod = self.id,
			spellId = spellId,
			guid = guid,
			absorbRemaining = absorb,
			maxAbsorb = absorb,
		}
		obj.func = getShieldHPFunc(obj)
		activeShields[#activeShields + 1] = obj
		shieldsByGuid[guid] = obj
		DBM.BossHealth:AddBoss(obj.func, GetSpellInfo(spellId) or spellId)
	end

	-- removes shield health bars for a specific guid and spellId (optional)
	function bossModPrototype:RemoveShieldHealthBar(guid, spellId)
		shieldsByGuid[guid] = nil
		for i = #activeShields, 1, -1 do
			if activeShields[i].guid == guid and activeShields[i].mod == self.id and (not spellId or activeShields[i].spellId == spellId) then
				DBM.BossHealth.RemoveBoss(activeShields[i].func)
				tremove(activeShields, i)
			end
		end
	end

	-- removes all shield bars of a boss mod
	function bossModPrototype:RemoveAllShieldHealthBars()
		for i = #activeShields, 1, -1 do
			if activeShields[i].mod == self.id then
				DBM.BossHealth.RemoveBoss(activeShields[i].func)
				shieldsByGuid[activeShields[i].guid] = nil
				tremove(activeShields, i)
			end
		end
	end
end


---------------
--  Options  --
---------------
function bossModPrototype:AddBoolOption(name, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, cat)
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddSpecialWarningOption(name, default, defaultSound, cat)
	cat = cat or "misc"
	self.Options[name] = (default == nil) or default
	self.Options[name .. "SpecialWarningSound"] = defaultSound or "Sound\\Spells\\PVPFlagTaken.ogg"
	self:SetOptionCategory(name, cat)
end

function bossModPrototype:AddSetIconOption(name, spellId, default, isHostile)
	self.Options[name] = (default == nil) or default
	self:SetOptionCategory(name, "misc")
	if isHostile then
		if not self.findFastestComputer then
			self.findFastestComputer = {}
		end
		self.findFastestComputer[#self.findFastestComputer + 1] = name
		self.localization.options[name] = DBM_CORE_AUTO_ICONS_OPTION_TEXT2:format(spellId)
	else
		self.localization.options[name] = DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(spellId)
	end
end

function bossModPrototype:AddRangeFrameOption(range, spellId, default)
	self.Options["RangeFrame"] = (default == nil) or default
	self:SetOptionCategory("RangeFrame", "misc")
	if spellId then
		self.localization.options["RangeFrame"] = DBM_CORE_AUTO_RANGE_OPTION_TEXT:format(range, spellId)
	else
		self.localization.options["RangeFrame"] = DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT:format(range)
	end
end

function bossModPrototype:AddInfoFrameOption(spellId, default)
	self.Options["InfoFrame"] = (default == nil) or default
	self:SetOptionCategory("InfoFrame", "misc")
	self.localization.options["InfoFrame"] = DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT:format(spellId)
end

function bossModPrototype:AddReadyCheckOption(questId, default)
	self.readyCheckQuestId = questId
	self.Options["ReadyCheck"] = (default == nil) or default
	self.localization.options["ReadyCheck"] = DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT
	self:SetOptionCategory("ReadyCheck", "misc")
end

function bossModPrototype:AddSliderOption(name, minValue, maxValue, valueStep, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = default or 0
	self:SetOptionCategory(name, cat)
	self.sliders = self.sliders or {}
	self.sliders[name] = {
		minValue = minValue,
		maxValue = maxValue,
		valueStep = valueStep,
	}
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddButton(name, onClick, cat, func)
	cat = cat or "misc"
	self:SetOptionCategory(name, cat)
	self.buttons = self.buttons or {}
	self.buttons[name] = onClick
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

-- FIXME: this function does not reset any settings to default if you remove an option in a later revision and a user has selected this option in an earlier revision were it still was available
-- this will be fixed as soon as it is necessary due to removed options ;-)
function bossModPrototype:AddDropdownOption(name, options, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = default
	self:SetOptionCategory(name, cat)
	self.dropdowns = self.dropdowns or {}
	self.dropdowns[name] = options
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddEditBoxOption(name, options, default, cat, func)
	cat = cat or "misc"
	self.Options[name] = default
	self:SetOptionCategory(name, cat)
	self.editboxes = self.editboxes or {}
	self.editboxes[name] = options
	if func then
		self.optionFuncs = self.optionFuncs or {}
		self.optionFuncs[name] = func
	end
end

function bossModPrototype:AddOptionSpacer(cat)
	cat = cat or "misc"
	if self.optionCategories[cat] then
		tinsert(self.optionCategories[cat], DBM_OPTION_SPACER)
	end
end

function bossModPrototype:AddAnnounceSpacer()
	return self:AddOptionSpacer("announce")
end

function bossModPrototype:AddTimerSpacer()
	return self:AddOptionSpacer("timer")
end

function bossModPrototype:RemoveOption(name)
	self.Options[name] = nil
	for i, options in pairs(self.optionCategories) do
		removeEntry(options, name)
		if #options == 0 then
			self.optionCategories[i] = nil
			removeEntry(self.categorySort, i)
		end
	end
	if self.optionFuncs then
		self.optionFuncs[name] = nil
	end
end

function bossModPrototype:SetOptionCategory(name, cat)
	for _, options in pairs(self.optionCategories) do
		removeEntry(options, name)
	end
	if not self.optionCategories[cat] then
		self.optionCategories[cat] = {}
		tinsert(self.categorySort, cat)
	end
	tinsert(self.optionCategories[cat], name)
end


--------------
--  Combat  --
--------------
function bossModPrototype:RegisterCombat(cType, ...)
	if cType then
		cType = cType:lower()
	end
	local info = {
		type = cType,
		mob = self.creatureId,
		encounter = self.encounterId,
		name = self.localization.general.name or self.id,
		msgs = (cType ~= "combat") and {...},
		mod = self
	}
	if self.multiMobPullDetection then
		info.multiMobPullDetection = self.multiMobPullDetection
	end
	if self.multiEncounterPullDetection then
		info.multiEncounterPullDetection = self.multiEncounterPullDetection
	end
	-- use pull-mobs as kill mobs by default, can be overriden by RegisterKill
	if self.multiMobPullDetection then
		for i, v in ipairs(self.multiMobPullDetection) do
			info.killMobs = info.killMobs or {}
			info.killMobs[v] = true
		end
	end
	self.combatInfo = info
	if not self.zones then return end
	for v in pairs(self.zones) do
		combatInfo[v] = combatInfo[v] or {}
		tinsert(combatInfo[v], info)
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:RegisterKill(msgType, ...)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	if msgType == "kill" then
		if select("#", ...) > 0 then -- calling this method with 0 IDs means "use the values from SetCreatureID", this is already done by RegisterCombat as calling RegisterKill should be optional --> mod:RegisterKill("kill") with no IDs is never necessary
			self.combatInfo.killMobs = {}
			for i = 1, select("#", ...) do
				local v = select(i, ...)
				if type(v) == "number" then
					self.combatInfo.killMobs[v] = true
				end
			end
		end
	else
		self.combatInfo.killType = msgType
		self.combatInfo.killMsgs = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			self.combatInfo.killMsgs[v] = true
		end
	end
end

-- needs to be called _AFTER_ RegisterCombat
function bossModPrototype:SetDetectCombatInVehicle(flag)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.noCombatInVehicle = not flag
end

function bossModPrototype:IsInCombat()
	return self.inCombat
end

function bossModPrototype:SetMinCombatTime(t)
	self.minCombatTime = t
end

-- needs to be called after RegisterCombat
function bossModPrototype:SetWipeTime(t)
	if not self.combatInfo then
		error("mod.combatInfo not yet initialized, use mod:RegisterCombat before using this method", 2)
	end
	self.combatInfo.wipeTimer = t
end

-- fix for LFR ToES Tsulong combat detection bug after killed.
function bossModPrototype:SetReCombatTime(t, t2)--T1, after kill. T2 after wipe
	self.reCombatTime = t
	self.reCombatTime2 = t2
end

function bossModPrototype:IsWipe()
	local wipe = true
	local uId = (IsInRaid() and "raid") or "party"
	for i = 0, GetNumGroupMembers() do
		local id = (i == 0 and "player") or uId..i
		if UnitAffectingCombat(id) and not UnitIsDeadOrGhost(id) then
			wipe = false
			break
		end
	end
	return wipe
end


-----------------------
--  Synchronization  --
-----------------------
function bossModPrototype:SendSync(event, ...)
	event = event or ""
	local arg = select("#", ...) > 0 and strjoin("\t", tostringall(...)) or ""
	local str = ("%s\t%s\t%s\t%s"):format(self.id, self.revision or 0, event, arg)
	local spamId = self.id .. event .. arg -- *not* the same as the sync string, as it doesn't use the revision information
	local time = GetTime()
	--Mod syncs are more strict and enforce latency threshold always.
	--Do not put latency check in main sendSync local function (line 313) though as we still want to get version information, etc from these users.
	if not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 8 then
		self:ReceiveSync(event, nil, self.revision or 0, tostringall(...))
		sendSync("M", str)
	end
end

function bossModPrototype:ReceiveSync(event, sender, revision, ...)
	local spamId = self.id .. event .. strjoin("\t", ...)
	local time = GetTime()
	if (not modSyncSpam[spamId] or (time - modSyncSpam[spamId]) > 8) and self.OnSync and (not (self.blockSyncs and sender)) and (not sender or (not self.minSyncRevision or revision >= self.minSyncRevision)) then
		modSyncSpam[spamId] = time
		-- we have to use the sender as last argument for compatibility reasons (stupid old API...)
		-- avoid table allocations for frequently used number of arguments
		if select("#", ...) <= 1 then
			-- syncs with no arguments have an empty argument (also for compatibility reasons)
			self:OnSync(event, ... or "", sender)
		elseif select("#", ...) == 2 then
			self:OnSync(event, ..., select(2, ...), sender)
		else
			local tmp = { ... }
			tmp[#tmp + 1] = sender
			self:OnSync(event, unpack(tmp))
		end
	end
end

function bossModPrototype:SetMinSyncRevision(revision)
	self.minSyncRevision = revision
end

function bossModPrototype:SetHotfixNoticeRev(revision)
	self.hotfixNoticeRev = revision
end


-----------------
--  Scheduler  --
-----------------
function bossModPrototype:Schedule(t, f, ...)
	return schedule(t, f, self, ...)
end

function bossModPrototype:Unschedule(f, ...)
	return unschedule(f, self, ...)
end

function bossModPrototype:ScheduleMethod(t, method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Schedule(t, self[method], self, ...)
end
bossModPrototype.ScheduleEvent = bossModPrototype.ScheduleMethod

function bossModPrototype:UnscheduleMethod(method, ...)
	if not self[method] then
		error(("Method %s does not exist"):format(tostring(method)), 2)
	end
	return self:Unschedule(self[method], self, ...)
end
bossModPrototype.UnscheduleEvent = bossModPrototype.UnscheduleMethod


-------------
--  Icons  --
-------------
function bossModPrototype:SetIcon(target, icon, timer)
	if not target then return end--Fix a rare bug where target becomes nil at last second (end combat fires and clears targets)
	if DBM.Options.DontSetIcons or not enableIcons or (DBM:GetRaidRank(playerName) == 0 and IsInGroup()) then -- Can set icon in solo raid.
		return
	end
	icon = icon and icon >= 0 and icon <= 8 and icon or 8
	local uId = DBM:GetRaidUnitId(target)
	if not uId then uId = target end
	local oldIcon = self:GetIcon(uId) or 0
	SetRaidTarget(uId, icon)
	self:UnscheduleMethod("SetIcon", target)
	if timer then
		self:ScheduleMethod(timer, "RemoveIcon", target)
		if oldIcon then
			self:ScheduleMethod(timer + 1, "SetIcon", target, oldIcon)
		end
	end
end

local iconSortTable = {}
local iconSet = 0

local function sort_by_group(v1, v2)
	return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
end

local function clearSortTable()
	table.wipe(iconSortTable)
	iconSet = 0
end

function bossModPrototype:SetIconBySortedTable(startIcon, reverseIcon, returnFunc)
	table.sort(iconSortTable, sort_by_group)
	local icon = startIcon or 1
	for i, v in ipairs(iconSortTable) do
		SetRaidTarget(v, icon)--do not use SetIcon function again. It already checked in SetSortedIcon function.
		if reverseIcon then
			icon = icon - 1
		else
			icon = icon + 1
		end
		if returnFunc then
			self:ScheduleMethod(0, returnFunc, v, icon)--Send icon and target to returnFunc. (Generally used by announce icon targets to raid chat feature)
		end
	end
	self:Schedule(1.5, clearSortTable)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
end

function bossModPrototype:SetSortedIcon(delay, target, startIcon, maxIcon, reverseIcon, returnFunc)
	if not target then return end
	if DBM.Options.DontSetIcons or not enableIcons or (DBM:GetRaidRank(playerName) == 0 and IsInGroup()) then
		return
	end
	if not startIcon then startIcon = 1 end
	startIcon = startIcon and startIcon >= 0 and startIcon <= 8 and startIcon or 8
	local uId = DBM:GetRaidUnitId(target)
	if not uId then uId = target end
	iconSet = iconSet + 1
	table.insert(iconSortTable, uId)
	self:UnscheduleMethod("SetIconBySortedTable")
	if maxIcon and iconSet == maxIcon then
		self:SetIconBySortedTable(startIcon, reverseIcon, returnFunc)
	elseif self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
		self:ScheduleMethod(delay or 0.5, "SetIconBySortedTable", startIcon, maxIcon, returnFunc)
	end
end

function bossModPrototype:GetIcon(uId)
	return GetRaidTargetIndex(uId)
end

function bossModPrototype:RemoveIcon(target, timer)
	return self:SetIcon(target, 0, timer)
end

function bossModPrototype:ClearIcons()
	if IsInRaid() then
		for i = 1, GetNumGroupMembers() do
			if UnitExists("raid"..i) and GetRaidTargetIndex("raid"..i) then
				SetRaidTarget("raid"..i, 0)
			end
		end
	else
		for i = 1, GetNumSubgroupMembers() do
			if UnitExists("party"..i) and GetRaidTargetIndex("party"..i) then
				SetRaidTarget("party"..i, 0)
			end
		end
	end
end

-----------------------
--  Model Functions  --
-----------------------
function bossModPrototype:SetModelScale(scale)
	self.modelScale = scale
end

function bossModPrototype:SetModelOffset(x, y, z)
	self.modelOffsetX = x
	self.modelOffsetY = y
	self.modelOffsetZ = z
end

function bossModPrototype:SetModelRotation(r)
	self.modelRotation = r
end

function bossModPrototype:SetModelMoveSpeed(v)
	self.modelMoveSpeed = v
end

function bossModPrototype:SetModelID(id)
	self.modelId = id
end

function bossModPrototype:SetModelSound(long, short)--PlaySoundFile prototype for model viewer, long is long sound, short is a short clip, configurable in UI, both sound paths defined in boss mods.
	self.modelSoundLong = long
	self.modelSoundShort = short
end

function bossModPrototype:EnableModel()
	self.modelEnabled = true
end

function bossModPrototype:DisableModel()
	self.modelEnabled = nil
end


--------------------
--  Localization  --
--------------------
function bossModPrototype:GetLocalizedStrings()
	self.localization.miscStrings.name = self.localization.general.name
	return self.localization.miscStrings
end

-- Not really good, needs a few updates
do
	local modLocalizations = {}
	local modLocalizationPrototype = {}
	local mt = {__index = modLocalizationPrototype}
	local returnKey = {__index = function(t, k) return k end}
	local defaultCatLocalization = {
		__index = setmetatable({
			timer		= DBM_CORE_OPTION_CATEGORY_TIMERS,
			announce	= DBM_CORE_OPTION_CATEGORY_WARNINGS,
			misc		= MISCELLANEOUS,
			specannounce	= DBM_CORE_OPTION_CATEGORY_SPECWARNINGS,
			sound		= DBM_CORE_OPTION_CATEGORY_SOUND
		}, returnKey)
	}
	local defaultTimerLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_GENERIC_TIMER_BERSERK,
			timer_combat = DBM_CORE_GENERIC_TIMER_COMBAT,
			TimerSpeedKill = DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL
		}, returnKey)
	}
	local defaultAnnounceLocalization = {
		__index = setmetatable({
			warning_berserk = DBM_CORE_GENERIC_WARNING_BERSERK
		}, returnKey)
	}
	local defaultOptionLocalization = {
		__index = setmetatable({
			timer_berserk = DBM_CORE_OPTION_TIMER_BERSERK,
			timer_combat = DBM_CORE_OPTION_TIMER_COMBAT,
			HealthFrame = DBM_CORE_OPTION_HEALTH_FRAME,
			SpeedKillTimer = DBM_SPEED_KILL_TIMER_OPTION
		}, returnKey)
	}
	local defaultMiscLocalization = {
		__index = {}
	}

	function modLocalizationPrototype:SetGeneralLocalization(t)
		for i, v in pairs(t) do
			self.general[i] = v
		end
	end

	function modLocalizationPrototype:SetWarningLocalization(t)
		for i, v in pairs(t) do
			self.warnings[i] = v
		end
	end

	function modLocalizationPrototype:SetTimerLocalization(t)
		for i, v in pairs(t) do
			self.timers[i] = v
		end
	end

	function modLocalizationPrototype:SetOptionLocalization(t)
		for i, v in pairs(t) do
			self.options[i] = v
		end
	end

	function modLocalizationPrototype:SetOptionCatLocalization(t)
		for i, v in pairs(t) do
			self.cats[i] = v
		end
	end

	function modLocalizationPrototype:SetMiscLocalization(t)
		for i, v in pairs(t) do
			self.miscStrings[i] = v
		end
	end

	function DBM:CreateModLocalization(name)
		name = tostring(name)
		local obj = {
			general = setmetatable({}, returnKey),
			warnings = setmetatable({}, defaultAnnounceLocalization),
			options = setmetatable({}, defaultOptionLocalization),
			timers = setmetatable({}, defaultTimerLocalization),
			miscStrings = setmetatable({}, defaultMiscLocalization),
			cats = setmetatable({}, defaultCatLocalization),
		}
		setmetatable(obj, mt)
		modLocalizations[name] = obj
		return obj
	end

	function DBM:GetModLocalization(name)
		name = tostring(name)
		return modLocalizations[name] or self:CreateModLocalization(name)
	end
end