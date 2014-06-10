-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local next = _G.next
local pairs = _G.pairs
local tonumber = _G.tonumber
local tostring = _G.tostring
local type = _G.type

-- Libraries
local string = _G.string
local table = _G.table


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...

local Dialog = _G.LibStub("LibDialog-1.0")
local L = private.L
_G._NPCScan = private

local debugger -- Only defined if needed.

private.Frame = _G.CreateFrame("Frame")
private.Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
private.Frame:RegisterEvent("PLAYER_LEAVING_WORLD")
private.Frame:RegisterEvent("PLAYER_UPDATE_RESTING")
private.Frame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

private.Updater = private.Frame:CreateAnimationGroup()
private.Updater.UpdateRate = 0.5
private.Updater:CreateAnimation("Animation"):SetDuration(private.Updater.UpdateRate)
private.Updater:SetLooping("REPEAT")

-------------------------------------------------------------------------------
-- Constants.
-------------------------------------------------------------------------------
local DB_VERSION = 3
local ISLE_OF_THUNDER_MAP_ID = 1064
local PLAYER_CLASS = _G.select(2, _G.UnitClass("player"))
local PLAYER_FACTION = _G.UnitFactionGroup("player")


-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
private.Options = {
	Version = DB_VERSION,
	AlertSound = nil, -- Default sound
	NPCs = {},
	NPCWorldIDs = {},
	IgnoreList = {
		NPCs = {},
		MapName = {},
		WorldID = {},
	},
}

private.OptionsCharacter = {
	Version = DB_VERSION,
	Achievements = {},
}


private.OptionsDefault = {
	Version = DB_VERSION,
	AlertSound = nil, -- Default sound
	NPCs = {
		[50409] = private.L.NPCs["50409"], --"Mysterious Camel Figurine",
		[50410] = private.L.NPCs["50410"], --"Mysterious Camel Figurine",
		[64004] = private.L.NPCs["64004"], --"Ghostly Pandaren Fisherman",
		[64191] = private.L.NPCs["64191"], --"Ghostly Pandaren Craftsman",
	},
	NPCWorldIDs = {
		[50409] = private.ZONE_NAMES.KALIMDOR,
		[50410] = private.ZONE_NAMES.KALIMDOR,
		[64004] = private.ZONE_NAMES.PANDARIA,
		[64191] = private.ZONE_NAMES.PANDARIA,
	},
	IgnoreList = {
		NPCs = {},
		MapName = {},
		WorldID = {},
	},
}


private.OptionsCharacterDefault = {
	Version = DB_VERSION,
	Achievements = {
		[private.ACHIEVEMENT_IDS.BLOODY_RARE] = true,
		[private.ACHIEVEMENT_IDS.FROSTBITTEN] = true,
		[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY] = true,
		[private.ACHIEVEMENT_IDS.GLORIOUS] = true,
		[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN] = true,
		[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION] = true,
	},
	AchievementsAddFound = true,
	AlertScreenEdgeFlash = true,
	AlertSoundUnmute = nil,
	CacheWarnings = true,
	FlightSupress = true,
	TargetIcon = 8, --Skull
	TrackBeasts = true,
	TrackRares = true,
	TrackVignettes = false,
}


-------------------------------------------------------------------------------
-- Dialogs.
-------------------------------------------------------------------------------
Dialog:Register("NPCSCAN_AUTOADD_WARNING", {
	text = "You appear to be running _NPCScan.AutoAdd v2.2 or earlier, which may prevent _NPCScan from working properly.\n\nIt is recommended that you disable _NPCScan.AutoAdd until it is updated.",
	text_justify_h = "left",
	text_justify_v = "bottom",
	buttons = {
		{
			text = _G.OKAY,
		},
	},
	icon = [[Interface\DialogFrame\UI-Dialog-Icon-AlertNew]],
	show_while_dead = true,
	hide_on_escape = true,
	width = 500,
})


-------------------------------------------------------------------------------
-- Debugger.
-------------------------------------------------------------------------------
local function CreateDebugFrame()
	return _G.LibStub("LibTextDump-1.0"):New(("%s Debug Output"):format(FOLDER_NAME), 640, 480)
end

function private.Debug(...)
	--[===[@debug@
	debugger = debugger or CreateDebugFrame()
	debugger:AddLine(string.format(...))
	--@end-debug@]===]
end


-------------------------------------------------------------------------------
-- Helpers.
-------------------------------------------------------------------------------
function private.Print(message, color)
	if not color then
		color = _G.NORMAL_FONT_COLOR
	end
	_G.DEFAULT_CHAT_FRAME:AddMessage(L.PRINT_FORMAT:format(private.Options.PrintTime and _G.date(_G.CHAT_TIMESTAMP_FORMAT or L.TIME_FORMAT) or "", message), color.r, color.g, color.b)
end


do
	local tooltip = _G.CreateFrame("GameTooltip", "_NPCScanTooltip")
	local tooltip_text = tooltip:CreateFontString()
	tooltip:AddFontStrings(tooltip_text, tooltip:CreateFontString())


	function private.NPCNameFromCache(npc_id)
		tooltip:SetOwner(_G.WorldFrame, "ANCHOR_NONE")
		tooltip:SetHyperlink(("unit:0xF53%05X00000000"):format(npc_id))

		if tooltip:IsShown() then
			return tooltip_text:GetText()
		end
	end
end


local CacheListBuild
do
	local build_list = {}
	local id_registry = {}


	--- Compiles a cache list into a printable list string.
	-- @param Relist True to relist NPC names that have already been printed.
	-- @return List string, or nil if the list was empty.
	function CacheListBuild(source_data, should_relist)
		if not next(source_data) then
			return
		end
		table.wipe(build_list)

		for npc_id, npc_name in pairs(source_data) do
			if should_relist or not id_registry[npc_id] then
				if not should_relist then
					id_registry[npc_id] = true
				end
				build_list[#build_list + 1] = L.CACHELIST_ENTRY_FORMAT:format(npc_name)
			end
		end
		table.wipe(source_data)

		if #build_list > 0 then
			table.sort(build_list)
			return table.concat(build_list, L.CACHELIST_SEPARATOR)
		end
	end
end


local CacheList = {}
do
	-- Fills a cache list with all added NPCs, active or not.
	local function CacheListPopulate(self)
		for npc_id in pairs(private.Options.NPCs) do
			self[npc_id] = private.NPCNameFromCache(npc_id)
		end

		if private.OptionsCharacter.TrackBeasts then
			for npc_id in pairs(private.TAMABLE_ID_TO_NAME) do
				self[npc_id] = private.NPCNameFromCache(npc_id)
			end
		end

		if private.OptionsCharacter.TrackRares then
			for npc_id in pairs(private.UNTAMABLE_ID_TO_NAME) do
				self[npc_id] = private.NPCNameFromCache(npc_id)
			end
		end

		for achievement_id in pairs(private.OptionsCharacter.Achievements) do
			for criteria_id, npc_id in pairs(private.ACHIEVEMENTS[achievement_id].Criteria) do
				if private.OptionsCharacter.AchievementsAddFound or not select(3, GetAchievementCriteriaInfoByID(achievement_id, criteria_id)) then -- Not completed
					self[npc_id] = private.NPCNameFromCache(npc_id)
				end
			end
		end
	end


	local FirstPrint = true


	--- Prints a standard message listing cached mobs.
	-- Will also print details about the cache the first time it's called.
	-- @param force_print Overrides the user's option to not print cache warnings.
	-- @param FullListing Adds all cached NPCs before printing, active or not.
	-- @return True if list printed.
	function private.CacheListPrint(force_print, full_listing)
		if force_print or private.Options.CacheWarnings then
			if full_listing then
				CacheListPopulate(CacheList)
			end
			local ListString = CacheListBuild(CacheList, force_print or full_listing) -- Allow printing an NPC a second time if forced or full listing

			if ListString then
				private.Print(L[FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT"]:format(ListString), force_print and _G.RED_FONT_COLOR)
				FirstPrint = false
				return true
			end
		else
			table.wipe(CacheList)
		end
	end
end


local ScanIDs = {} -- [ NpcID ] = Number of concurrent scans for this ID


-- Begins searching for an NPC.
local function ScanAdd(npc_id)
	local name = private.NPCNameFromCache(npc_id)

	if name then
		CacheList[npc_id] = name
	else
		if ScanIDs[npc_id] then
			ScanIDs[npc_id] = ScanIDs[npc_id] + 1
		else
			if not next(ScanIDs) then -- First
				private.Updater:Play()
			end
			ScanIDs[npc_id] = 1
			private.Overlays.Add(npc_id)
		end
		return true
	end
end


-- Stops searching for an NPC when nothing is searching for it.
local function ScanRemove(npc_id)
	local count = assert(ScanIDs[npc_id], "Attempt to remove inactive scan.")

	if count > 1 then
		ScanIDs[npc_id] = count - 1
	else
		ScanIDs[npc_id] = nil
		private.Overlays.Remove(npc_id)

		if not next(ScanIDs) then -- Last
			private.Updater:Stop()
		end
	end
end


local function IsWorldIDActive(world_id)
	return not world_id or world_id == private.WorldID
end


local NPCActivate, NPCDeactivate
do
	local NPCsActive = {}


	-- Starts actual scan for NPC if on the right world.
	function NPCActivate(npc_id, world_id)
		if NPCsActive[npc_id] or not IsWorldIDActive(world_id) or not ScanAdd(npc_id) then
			return
		end
		NPCsActive[npc_id] = true
		private.Config.Search.UpdateTab("NPC")
		return true
	end


	-- Ends actual scan for NPC.
	function NPCDeactivate(npc_id)
		if not NPCsActive[npc_id] then
			return
		end
		NPCsActive[npc_id] = nil
		ScanRemove(npc_id)
		private.Config.Search.UpdateTab("NPC")
		return true -- Successfully deactivated
	end


	function private.NPCIsActive(npc_id)
		return NPCsActive[npc_id]
	end
end


--- Adds an NPC name and ID to settings and begins searching.
-- @param npc_id Numeric ID of the NPC (See Wowhead.com).
-- @param Name Temporary name to identify this NPC by in the search table.
-- @param WorldID Number or localized string WorldID to limit this search to.
-- @return True if custom NPC added.
function private.NPCAdd(npc_id, npc_name, world_id)
	local options = private.Options
	npc_id = assert(tonumber(npc_id), "NpcID must be numeric.")

	if options.NPCs[npc_id] then
		return
	end
	assert(type(npc_name) == "string", "Name must be a string.")
	assert(world_id == nil or type(world_id) == "string" or type(world_id) == "number", "Invalid WorldID.")
	options.NPCs[npc_id] = npc_name
	options.NPCWorldIDs[npc_id] = world_id

	if not NPCActivate(npc_id, world_id) then
		-- Didn't activate; Just add row
		private.Config.Search.UpdateTab("NPC")
	end
	return true
end


--- Removes an NPC from settings and stops searching for it.
-- @param NpcID Numeric ID of the NPC.
-- @return True if custom NPC removed.
function private.NPCRemove(npc_id)
	local options = private.Options
	npc_id = tonumber(npc_id)

	if not options.NPCs[npc_id] then
		return
	end
	options.NPCs[npc_id] = nil
	options.NPCWorldIDs[npc_id] = nil

	if not NPCDeactivate(npc_id) then
		private.Config.Search.UpdateTab("NPC")
	end
	return true
end


-- Starts searching for an achievement's NPC if it meets all settings.
local function AchievementNPCActivate(achievement, npc_id, criteria_id)
	if (achievement.Active and not achievement.NPCsActive[npc_id]
		and (private.OptionsCharacter.AchievementsAddFound or not select(3, GetAchievementCriteriaInfoByID(achievement.ID, criteria_id))) -- Not completed
		and ScanAdd(npc_id)) then
		achievement.NPCsActive[npc_id] = criteria_id
		private.Config.Search.UpdateTab(achievement.ID)
		return true
	end
end


-- Stops searching for an achievement's NPC.
local function AchievementNPCDeactivate(achievement, npc_id)
	if not achievement.NPCsActive[npc_id] then
		return
	end
	achievement.NPCsActive[npc_id] = nil
	ScanRemove(npc_id)
	private.Config.Search.UpdateTab(achievement.ID)
	return true
end


-- Starts actual scans for achievement NPCs if on the right world.
local function AchievementActivate(achievement)
	if achievement.Active or not IsWorldIDActive(achievement.WorldID) then
		return
	end
	achievement.Active = true

	for criteria_id, npc_id in pairs(achievement.Criteria) do
		if not _G._NPCScanOptions.IgnoreList.NPCs[npc_id] then
			AchievementNPCActivate(achievement, npc_id, criteria_id)
		end
	end
	return true
end


-- Ends actual scans for achievement NPCs.
local function AchievementDeactivate(achievement)
	if not achievement.Active then
		return
	end
	achievement.Active = nil

	for npc_id in pairs(achievement.NPCsActive) do
		AchievementNPCDeactivate(achievement, npc_id)
	end
	return true
end


--- @param achievement Achievement data table from NS.Achievements.
-- @return True if the achievement NPC is being searched for.
function private.AchievementNPCIsActive(achievement, npc_id)
	return achievement.NPCsActive[npc_id] ~= nil
end


--- Adds a kill-related achievement to track.
-- @param achievement_id Numeric ID of achievement.
-- @return True if achievement added.
function private.AchievementAdd(achievement_id)
	achievement_id = assert(tonumber(achievement_id), "AchievementID must be numeric.")
	local achievement = private.ACHIEVEMENTS[achievement_id]

	if not achievement or private.OptionsCharacter.Achievements[achievement_id] then
		return
	end

	if not next(private.OptionsCharacter.Achievements) then -- First
		private.Frame:RegisterEvent("ACHIEVEMENT_EARNED")
		private.Frame:RegisterEvent("CRITERIA_UPDATE")
	end
	private.OptionsCharacter.Achievements[achievement_id] = true
	private.Config.Search.AchievementSetEnabled(achievement_id, true)
	AchievementActivate(achievement)
	return true
end


--- Removes an achievement from settings and stops tracking it.
-- @param achievement_id Numeric ID of achievement.
-- @return True if achievement removed.
function private.AchievementRemove(achievement_id)
	if not private.OptionsCharacter.Achievements[achievement_id] then
		return
	end
	AchievementDeactivate(private.ACHIEVEMENTS[achievement_id])
	private.OptionsCharacter.Achievements[achievement_id] = nil

	if not next(private.OptionsCharacter.Achievements) then -- Last
		private.Frame:UnregisterEvent("ACHIEVEMENT_EARNED")
		private.Frame:UnregisterEvent("CRITERIA_UPDATE")
	end
	private.Config.Search.AchievementSetEnabled(achievement_id, false)
	return true
end


--- Adds a kill-related achievement to track.
-- @param AchievementID Numeric ID of achievement.
-- @return True if achievement added.
function private.SetRareMob(identifier, enable)
	if identifier == "BEASTS" then
		private.OptionsCharacter.TrackBeasts = enable or nil
		private.Config.Search.AchievementSetEnabled(identifier, enable)
		return true
	elseif identifier == "RARENPC" then
		private.OptionsCharacter.TrackRares = enable or nil
		private.Config.Search.AchievementSetEnabled(identifier, enable)
		return true
	end
end

function private.ReavtivateIgnoreMob(npc_id, world_id)
	NPCActivate(npc_id, world_id)
end

function private.DeavtivateIgnoreMob(npc_id)
	NPCDeactivate(npc_id)
end


function private.RareMobToggle(identifier, enable)
	local npcs

	if identifier == "BEASTS" then
		npcs = private.TAMABLE_ID_TO_NAME
	elseif identifier == "RARENPC" then
		npcs = private.UNTAMABLE_ID_TO_NAME
	end

	if npcs and enable then
		for npc_id, _ in pairs(npcs) do
			if not _G._NPCScanOptions.IgnoreList.NPCs[npc_id] then
				NPCActivate(npc_id, private.NPC_ID_TO_WORLD_NAME[npc_id])
			end
		end
	else
		for npc_id, _ in pairs(npcs) do
			NPCDeactivate(npc_id)
		end
	end
end


--- Enables printing cache lists on login.
-- @return True if changed.
function private.SetCacheWarnings(enable)
	if not enable ~= not private.Options.CacheWarnings then
		private.Options.CacheWarnings = enable or nil

		private.Config.cache_warnings_checkbox:SetChecked(enable)
		return true
	end
end


--- Enables adding a timestamp to printed messages.
-- @return True if changed.
function private.SetPrintTime(enable)
	if not enable ~= not private.Options.PrintTime then
		private.Options.PrintTime = enable or nil

		private.Config.print_time_checkbox:SetChecked(enable)
		return true
	end
end


--- Enables tracking of unneeded achievement NPCs.
-- @return True if changed.
function private.SetAchievementsAddFound(enable)
	if not enable ~= not private.OptionsCharacter.AchievementsAddFound then
		private.OptionsCharacter.AchievementsAddFound = enable or nil
		private.Config.Search.add_found_checkbox:SetChecked(enable)

		for _, achievement in pairs(private.ACHIEVEMENTS) do
			if AchievementDeactivate(achievement) then -- Was active
				AchievementActivate(achievement)
			end
		end
		return true
	end
end


--- Enables unmuting sound to play found alerts.
-- @return True if changed.
function private.SetAlertSoundUnmute(enable)
	if not enable ~= not private.OptionsCharacter.AlertSoundUnmute then
		private.OptionsCharacter.AlertSoundUnmute = enable or nil

		private.Config.alert_unmute_checkbox:SetChecked(enable)
		return true
	end
end


--- Enables unmuting sound to play found alerts.
-- @return True if changed.
function private.SetAlertScreenEdgeFlash(enable)
	if not enable ~= not private.OptionsCharacter.AlertScreenEdgeFlash then
		private.OptionsCharacter.AlertScreenEdgeFlash = enable or nil

		private.Config.screen_edge_flash_checkbox:SetChecked(enable)
		return true
	end
end

--- Sets the sound to play when NPCs are found.
-- @return True if changed.
function private.SetAlertSound(alert_sound)
	assert(alert_sound == nil or type(alert_sound) == "string", "AlertSound must be a string or nil.")
	if alert_sound ~= private.Options.AlertSound then
		private.Options.AlertSound = alert_sound

		_G.UIDropDownMenu_SetText(private.Config.alert_sound_dropdown, alert_sound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or alert_sound)
		return true
	end
end

--- Sets the icon to display over found NPC.
function private.SetTargetIcon(icon_id)
	icon_id = icon_id or private.NUM_RAID_ICONS
	private.OptionsCharacter.TargetIcon = icon_id

	local icon_info = _G.UnitPopupButtons["RAID_TARGET_" .. icon_id]
	local colorCode = ("|cFF%02x%02x%02x"):format(icon_info.color.r * 255, icon_info.color.g * 255, icon_info.color.b * 255)
	_G.UIDropDownMenu_SetText(private.Config.alert_icon_dropdown, colorCode .. icon_info.text)
end

--- Enables Blocking alerts while on taxi.
function private.SetBlockFlightScan(enable)
	private.OptionsCharacter.FlightSupress = enable
	private.Config.Search.block_flight_scan_checkbox:SetChecked(enable)
	return enable
end

--- Enables Vignette tracking.
function private.SetVignetteScan(enable)
	private.OptionsCharacter.TrackVignettes = enable
	private.Config.Search.viginette_scan_checkbox:SetChecked(enable)
	return enable
end


local IsDefaultNPCValid
do
	local TAMABLE_EXCEPTIONS = {
		[49822] = true -- Jadefang drops a pet
	}

	local NPC_FACTION = {
		[51071] = "Horde", -- Captain Florence
		[51079] = "Alliance", -- Captain Foulwind
		[68317] = "Horde", -- Mavis Harms
		[68318] = "Horde", -- Dalan Nightbreaker
		[68319] = "Horde", -- Disha Fearwarden
		[68320] = "Alliance", -- Ubunti the Shade
		[68321] = "Alliance", -- Kar Warmaker
		[68322] = "Alliance", -- Muerta
	}

	--- @return True if NpcID should be a default for this character.
	function IsDefaultNPCValid(npc_id)
		return (PLAYER_CLASS == "HUNTER" or not private.TAMABLE_ID_TO_NAME[npc_id] or TAMABLE_EXCEPTIONS[npc_id]) and (not NPC_FACTION[npc_id] or NPC_FACTION[npc_id] == PLAYER_FACTION)
	end
end


--- Resets the scanning list and reloads it from saved settings.
function private.Synchronize(options, character_options)
	-- Load defaults if settings omitted
	local is_default_scan = false

	if not options then
		options = private.OptionsDefault
	end

	if not options.IgnoreList then
		options.IgnoreList = private.OptionsDefault.IgnoreList
	end

	if not character_options then
		character_options = private.OptionsCharacterDefault
		is_default_scan = true
	end

	-- Clear all scans
	for achievement_id in pairs(private.ACHIEVEMENTS) do
		private.AchievementRemove(achievement_id)
	end

	for npc_id in pairs(private.Options.NPCs) do
		private.NPCRemove(npc_id)
	end

	for npc_id, world_id in pairs(private.NPC_ID_TO_WORLD_NAME) do
		private.NPCRemove(npc_id)
	end
	assert(not next(ScanIDs), "Orphan NpcIDs in scan pool!")

	_G._NPCScanOptions.IgnoreList = options.IgnoreList
	private.SetCacheWarnings(options.CacheWarnings)
	private.SetPrintTime(options.PrintTime)
	private.SetAchievementsAddFound(character_options.AchievementsAddFound)
	private.SetAlertSoundUnmute(character_options.AlertSoundUnmute)
	private.SetAlertScreenEdgeFlash(character_options.AlertScreenEdgeFlash)
	private.SetTargetIcon(character_options.TargetIcon)
	private.SetAlertSound(options.AlertSound)
	private.SetVignetteScan(character_options.TrackVignettes)
	private.SetBlockFlightScan(character_options.FlightSupress)
	private.SetRareMob("BEASTS", character_options.TrackBeasts)
	private.SetRareMob("RARENPC", character_options.TrackRares)

	local add_all_defaults = _G.IsShiftKeyDown()

	for npc_id, npc_name in pairs(options.NPCs) do
		-- If defaults, only add tamable custom mobs if the player is a hunter
		if add_all_defaults or not is_default_scan or IsDefaultNPCValid(npc_id) then
			private.NPCAdd(npc_id, npc_name, options.NPCWorldIDs[npc_id])
		end
	end

	for achievement_id, achievement in pairs(private.ACHIEVEMENTS) do
		-- If defaults, don't enable completed achievements unless explicitly allowed
		if character_options.Achievements[achievement_id] and (not is_default_scan or character_options.AchievementsAddFound or not achievement.is_completed) then
			private.AchievementAdd(achievement_id)
		end
	end

	private.CacheListPrint(false, true) -- Populates cache list with inactive mobs too before printing
end


do
	local PetList = {}


	-- Prints the list of cached pets when leaving a city or inn.
	function private.Frame:PLAYER_UPDATE_RESTING()
		if _G.IsResting() or not next(PetList) then
			return
		end

		if private.Options.CacheWarnings then
			local ListString = CacheListBuild(PetList)
			if ListString then
				private.Print(L.CACHED_PET_RESTING_FORMAT:format(ListString), _G.RED_FONT_COLOR)
			end
		else
			table.wipe(PetList)
		end
	end


	--- @return True if the tamable mob is in its correct zone, else false with an optional reason string.
	local function OnFoundTamable(npc_id, npc_name)
		local tamable_zone_name = private.TAMABLE_ID_TO_MAP_NAME[npc_id]
		local expected_zone_id = tamable_zone_name and private.ZONE_IDS[private.ZONE_NAME_TO_LABEL[tamable_zone_name]]
		local current_zone_id = _G.GetCurrentMapAreaID()

		_G.SetMapToCurrentZone()
		local in_correct_zone = expected_zone_id == _G.GetCurrentMapAreaID()
		local invalid_reason

		if not in_correct_zone then
			if _G.IsResting() then
				PetList[npc_id] = npc_name -- Suppress error message until the player stops resting
			else
				local expected_zone_name = expected_zone_id and _G.GetMapNameByID(expected_zone_id) or nil
				if not expected_zone_name then -- GetMapNameByID returns nil for continent maps
					_G.SetMapByID(expected_zone_id)

					local map_continent = _G.GetCurrentMapContinent()
					if map_continent >= 1 then
						expected_zone_name = select(map_continent, _G.GetMapContinents())
					end
				end
				invalid_reason = L.FOUND_TAMABLE_WRONGZONE_FORMAT:format(npc_name, _G.GetRealZoneText(), expected_zone_name or L.FOUND_ZONE_UNKNOWN, expected_zone_id)
			end
		end
		_G.SetMapByID(current_zone_id)

		return in_correct_zone, invalid_reason
	end


	local function GetScanSource(npc_id)
		local custom_name = private.Options.NPCs[npc_id]

		if custom_name then
			return custom_name
		end

		for achievement_id in pairs(private.OptionsCharacter.Achievements) do
			if private.ACHIEVEMENTS[achievement_id].NPCsActive[npc_id] then
				return _G.GetAchievementLink(achievement_id)
			end
		end
	end

	-- Validates found mobs before showing alerts.
	local function OnFound(npc_id, npc_name)
		NPCDeactivate(npc_id)

		for achievement_id in pairs(private.OptionsCharacter.Achievements) do
			AchievementNPCDeactivate(private.ACHIEVEMENTS[achievement_id], npc_id)
		end

		local is_valid = true
		local is_tamable = private.TAMABLE_ID_TO_NAME[npc_id]
		local invalid_reason

		if is_tamable then
			is_valid, invalid_reason = OnFoundTamable(npc_id, npc_name)
		end

		--Checks to see if player is on flightpath, this will block possible cross realm alerts
		if private.OptionsCharacter.FlightSupress and _G.UnitOnTaxi("player") then
			is_valid = false
			_G.SetMapToCurrentZone()
			_G.PlaySound("TellMessage", "master")

			local x, y = _G.GetPlayerMapPosition("player")
			invalid_reason = L.FOUND_UNIT_TAXI:format(npc_name, x * 100, y * 100, _G.GetZoneText())
		end

		if is_valid then
			private.Print(L[is_tamable and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT"]:format(npc_name), _G.GREEN_FONT_COLOR)
			private.Button:SetNPC(npc_id, npc_name, GetScanSource(npc_id)) -- Sends added and found overlay messages
		elseif invalid_reason then
			private.Print(invalid_reason)
		end
	end


	local criteria_updated_bucket


	function private.Frame:CRITERIA_UPDATE()
		criteria_updated_bucket = true
	end


	-- Scans all NPCs on a timer and alerts if any are found.
	function private.Updater:OnLoop()
		if criteria_updated_bucket then
			if not private.OptionsCharacter.AchievementsAddFound then
				for achievement_id in pairs(private.OptionsCharacter.Achievements) do
					local achievement = private.ACHIEVEMENTS[achievement_id]

					for npc_id, criteria_id in pairs(achievement.NPCsActive) do
						local _, _, is_completed = _G.GetAchievementCriteriaInfoByID(achievement_id, criteria_id)

						if is_completed then
							AchievementNPCDeactivate(achievement, npc_id)
						end
					end
				end
			end
			criteria_updated_bucket = false
		end

		for npc_id in pairs(ScanIDs) do
			local npc_name = private.NPCNameFromCache(npc_id)
			if npc_name then
				OnFound(npc_id, npc_name)
			end
		end
	end
end


if PLAYER_CLASS == "HUNTER" then
	local StableUpdater = _G.CreateFrame("Frame")
	local stabled_list = {}


	-- Stops scans for stabled hunter pets before a bogus alert can fire.
	function private.Frame:PET_STABLE_UPDATE()
		for npc_id in pairs(ScanIDs) do
			local npc_name = private.NPCNameFromCache(npc_id)
			if npc_name then
				stabled_list[npc_id] = npc_name
				NPCDeactivate(npc_id)

				for achievement_id in pairs(private.OptionsCharacter.Achievements) do
					AchievementNPCDeactivate(private.ACHIEVEMENTS[achievement_id], npc_id)
				end
			end
		end
		StableUpdater:Show()
	end


	-- Bucket to print cached stabled pets on one line.
	function StableUpdater:OnUpdate()
		self:Hide()

		if private.Options.CacheWarnings then
			local list_string = CacheListBuild(stabled_list)
			if list_string then
				private.Print(L.CACHED_STABLED_FORMAT:format(list_string))
			end
		else
			table.wipe(stabled_list)
		end
	end


	StableUpdater:Hide()
	StableUpdater:SetScript("OnUpdate", StableUpdater.OnUpdate)
	private.Frame:RegisterEvent("PET_STABLE_UPDATE")


	-- Prevents the pet UI from querying (and caching) stabled pets until actually viewing the stables.
	-- @param is_override Forces a normal query even if the stables aren't open.
	local Original_GetStablePetInfo = _G.GetStablePetInfo
	function _G.GetStablePetInfo(stable_slot, is_override, ...)
		if is_override or stable_slot <= _G.NUM_PET_ACTIVE_SLOTS or _G.IsAtStableMaster() then
			return Original_GetStablePetInfo(stable_slot, is_override, ...)
		end
	end
end


-- Loads defaults, validates settings, and starts scan.
-- Used instead of ADDON_LOADED to give overlay mods a chance to load and register for messages.
function private.Frame:PLAYER_LOGIN(event_name)
	if _G.IsAddOnLoaded("_NPCScan.AutoAdd") then
		if _G.GetAddOnMetadata("_NPCScan.AutoAdd", "Version"):match("^([%d.]+)") <= "2.2" then
			Dialog:Spawn("NPCSCAN_AUTOADD_WARNING")
		end
	end
	local stored_options = _G._NPCScanOptions
	local stored_character_options = _G._NPCScanOptionsCharacter
	_G._NPCScanOptions = private.Options
	_G._NPCScanOptionsCharacter = private.OptionsCharacter

	--Updates custom NPCs to include include new NPCS added in version change
	if stored_options and stored_options.Version ~= DB_VERSION then
		if stored_options.NPCs then
			for npc_id, npc_name in pairs(private.OptionsDefault.NPCs) do
				if not stored_options.NPCs[npc_id] then
					stored_options.NPCs[npc_id] = npc_name
					local world = private.OptionsDefault.NPCWorldIDs and private.OptionsDefault.NPCWorldIDs[npc_id]
					if world then
						stored_options.NPCWorldIDs[npc_id] = world
					end
				end
			end
		end
		stored_options.Version = DB_VERSION
	end

	--Converts old style per character NPCs to global saved NPCs
	if stored_character_options and stored_character_options.Version ~= DB_VERSION then
		if not stored_character_options.Version or type(stored_character_options.Version) == "string" or stored_character_options.Version < DB_VERSION then
			if stored_character_options.NPCs then
				for npc_id, npc_name in pairs(stored_character_options.NPCs) do
					if not stored_options.NPCs[npc_id] then
						stored_options.NPCs[npc_id] = npc_name
						local world = stored_character_options.NPCWorldIDs and stored_character_options.NPCWorldIDs[npc_id]
						if world then
							stored_options.NPCWorldIDs[npc_id] = world
						end
					end
				end
				stored_character_options.NPCs = nil
			end
		end
		stored_character_options.Version = DB_VERSION
	end

	private.Overlays.Register()
	private.Synchronize(stored_options, stored_character_options)

	self[event_name] = nil
end


do
	local has_initialized = false

	function private.Frame:PLAYER_ENTERING_WORLD()
		self:PLAYER_UPDATE_RESTING()

		-- Since real MapIDs aren't available to addons, a "WorldID" is a universal ContinentID or the map's localized name.
		local map_name, _, _, _, _, _, _, map_id = _G.GetInstanceInfo()

		if map_id == ISLE_OF_THUNDER_MAP_ID then -- Fix for Isle of Thunder having a diffrent Instance name
			private.WorldID = private.ZONE_NAMES.PANDARIA
		else
			private.WorldID = map_name
		end

		if private.OptionsCharacter.TrackRares then
			for npc_id, world_name in pairs(private.UNTAMABLE_ID_TO_WORLD_NAME) do
				if not private.Options.IgnoreList.NPCs[npc_id] then
					NPCActivate(npc_id, world_name)
				end
			end
		end

		if private.OptionsCharacter.TrackBeasts then
			for npc_id, world_name in pairs(private.TAMABLE_ID_TO_WORLD_NAME) do
				if not private.Options.IgnoreList.NPCs[npc_id] then
					NPCActivate(npc_id, world_name)
				end
			end
		end

		for achievement_id in pairs(private.OptionsCharacter.Achievements) do
			local achievement = private.ACHIEVEMENTS[achievement_id]
			if achievement.WorldID then
				AchievementActivate(achievement)
			end
		end

		for npc_id, _ in pairs(private.Options.NPCs) do
			NPCActivate(npc_id, private.Options.NPCWorldIDs[npc_id])
		end

		if not has_initialized or not private.Options.CacheWarnings then
			-- Full listing of cached mobs gets printed on login
			has_initialized = true
			table.wipe(CacheList)
		else
			-- Print list of cached mobs specific to new world
			local list_string = CacheListBuild(CacheList)
			if list_string then
				private.Print(L.CACHED_WORLD_FORMAT:format(list_string, map_name))
			end
		end
		private.Config.Search:UpdateTabNames()
	end
end


function private.Frame:PLAYER_LEAVING_WORLD()
	for npc_id in pairs(private.Options.NPCWorldIDs) do
		NPCDeactivate(npc_id)
	end

	for achievement_id in pairs(private.OptionsCharacter.Achievements) do
		local achievement = private.ACHIEVEMENTS[achievement_id]
		if achievement.WorldID then
			AchievementDeactivate(achievement)
		end
	end
	private.WorldID = nil
end


function private.Frame:ACHIEVEMENT_EARNED(_, achievement_id)
	if not private.ACHIEVEMENTS[achievement_id] then
		return
	end
	private.ACHIEVEMENTS[achievement_id].is_completed = true

	if not private.OptionsCharacter.AchievementsAddFound then
		private.AchievementRemove(achievement_id)
	end
end


function private.Frame:ZONE_CHANGED_NEW_AREA(event_name)
	self:UnregisterEvent(event_name)
	self[event_name] = nil

	private.Updater:SetScript("OnLoop", private.Updater.OnLoop)
end

do
	local SUBCOMMAND_FUNCS = {
		[L.CMD_ADD] = function(arguments)
			local id, name = arguments:match("^(%d+)%s+(.+)$")
			id = tonumber(id)

			if not id then
				return
			end
			private.NPCRemove(id)

			if private.NPCAdd(id, name) then
				private.CacheListPrint(true)
			end
		end,
		[L.CMD_REMOVE] = function(arguments)
			local id = tonumber(arguments)

			if not id then
				for npc_id, npc_name in pairs(private.Options.NPCs) do
					if npc_name == arguments then
						id = npc_id
						break
					end
				end
			end

			if not private.NPCRemove(id) then
				private.Print(L.CMD_REMOVENOTFOUND_FORMAT:format(arguments), _G.RED_FONT_COLOR)
			end
		end,
		[L.CMD_CACHE] = function(arguments)
			if not private.CacheListPrint(true, true) then
				private.Print(L.CMD_CACHE_EMPTY, _G.GREEN_FONT_COLOR)
			end
		end,
		--[===[@debug@
		DEBUG = function()
			debugger = debugger or CreateDebugFrame()

			if debugger:Lines() == 0 then
				debugger:AddLine("Nothing to report.")
				debugger:Display()
				debugger:Clear()
				return
			end
			debugger:Display()
		end,
		DUMP = function()
			private.TextDump = private.TextDump or _G.LibStub("LibTextDump-1.0"):New(FOLDER_NAME)
			private.DumpNPCData()
		end,
		--@end-debug@]===]
	}

	_G.SlashCmdList["_NPCSCAN"] = function(input)
		local subcommand, arguments = input:match("^(%S+)%s*(.-)%s*$")
		if subcommand then
			local func = SUBCOMMAND_FUNCS[subcommand:upper()]
			if func then
				func(arguments)
			else
				private.Print(L.CMD_HELP)
			end
		else
			_G.InterfaceOptionsFrame_OpenToCategory(private.Config.Search)
		end
	end
end -- do-block


if _G.IsLoggedIn() then
	private.Frame:PLAYER_LOGIN("PLAYER_LOGIN")
else
	private.Frame:RegisterEvent("PLAYER_LOGIN")
end


if _G.GetZoneText() == "" then
	private.Frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
else
	private.Frame:ZONE_CHANGED_NEW_AREA("ZONE_CHANGED_NEW_AREA")
end
