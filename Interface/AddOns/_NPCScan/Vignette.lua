--Code to handle triggering alerts off of Vignettes

--Known issues:  VIGNETTE_ADDED does not give useful info for mobs,
--Work around target macro may not be reliable if there are more than one rare mobs around
--No way to filter alerts if a player is not tracking certain mobs.

-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs

-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L

local Debug = private.Debug
local Toast = _G.LibStub("LibToast-1.0")

-------------------------------------------------------------------------------
-- Variables.
-------------------------------------------------------------------------------
local instance_id_registry = {}
local last_vignette_id = 0
local vignette_delay
local vignette_found_count = 0
local delay_time = 300

private.VFrame = _G.CreateFrame("Frame")
private.VFrame:RegisterEvent("VIGNETTE_ADDED")
private.VFrame:RegisterEvent("VIGNETTE_REMOVED")
private.VFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
private.VFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

private.VFrame:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

function private.VFrame:ZONE_CHANGED_NEW_AREA(event, ...)
	if vignette_delay then
		Debug("Releasing Delay")
		private.VFrame:VIGNETTE_ADDED("VIGNETTE_ADDED", vignette_delay)
		vignette_delay = nil
	end
end

--Clears the last found Vignette mob only after combat has ended.
function private.VFrame:PLAYER_REGEN_ENABLED(event, ...)
	if vignette_found_count == 0 then
		if not _G.InCombatLockdown() then
			last_vignette_id = 0
		end
	end
end

--Checks to see if enough time has elapsed from the first sighting of a vignette before it triggers an alert again.
function private.CheckDelay(instanceid)
	if  not instance_id_registry[instanceid] then
		instance_id_registry[instanceid] = GetTime()
		Debug("Vignette not seen before")
		return true
	else
		local current_time = GetTime()
		local recorded_time = instance_id_registry[instanceid]
		if (current_time - recorded_time) < delay_time then
			Debug("Not enough time elapsed")
			return false
		else
			instance_id_registry[instanceid] = GetTime()
			Debug("Enough time has elapsed, sound alert.")
			return true
		end
	end
end

	--Delays alerts on login untill the world so current zone can be properly detected
local function VignetteZoneCheck()
	local map_id = _G.GetCurrentMapAreaID()
	local zone_name = _G.GetMapNameByID(map_id)

	if not zone_name then
		vignette_delay = true
		private.Debug("Build List Delayed")
		return false
	else
		return true
	end
end


--Checks to see if achievement mobs are being tracked and filters by zone if an achievement is disabled.
local function VignetteFilterByAchievement()
	local currentzone = _G.GetCurrentMapAreaID()

	if not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY] and currentzone == private.ZONE_IDS.VALE_OF_ETERNAL_BLOSSOMS then
		Debug("ONE_MANY_ARMY not tracked")
		return false
	elseif not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN] and currentzone == private.ZONE_IDS.ISLE_OF_THUNDER then
		Debug("CHAMPIONS_OF_LEI_SHEN not tracked")
		return false
	elseif not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION] and currentzone == private.ZONE_IDS.TIMELESS_ISLE then
		Debug("TIMELESS_CHAMPION not tracked")
		return false
	elseif not private.OptionsCharacter.Achievements[private.ACHIEVEMENT_IDS.GLORIOUS] and (currentzone ~= private.ZONE_IDS.VALE_OF_ETERNAL_BLOSSOMS and currentzone ~= private.ZONE_IDS.TIMELESS_ISLE and currentzone ~= private.ZONE_IDS.ISLE_OF_THUNDER) then
		Debug("GLORIOUS not tracked")
		return false
	else
		Debug("Tracking Mob")
		return true
	end
end

--Updates button to display actual target info
function private.SetVignetteTarget()
	local npc_name = _G.GetUnitName("target")
	local npc_id = private.NPC_NAME_TO_ID[npc_name]

	if _G.UnitIsDead("target") and vignette_found_count > 1 then
		last_vignette_id = npc_id
		private.GenerateTargetMacro(npc_id)
		private.Button:Update(npc_id, "Vignette Mob", "Unknown Vignette")
		Debug("Mob Dead")
		return
	end

	if npc_id then
		if _G.InCombatLockdown() then
			Debug("Combat LockDown")
			private.Button.PendingID, private.Button.PendingName, private.Button.PendingSource = npc_id, npc_name, "Vignette Mob"
		else
			private.Button:Update(npc_id, npc_name, "Vignette Mob")
		end
		last_vignette_id = npc_id
	end

	Debug("Last ID: " .. last_vignette_id)
end

-- Vignette alert, Appears to be Fixed in WoD will need to monitor
-- Refrence: http://wowpedia.org/API_C_Vignettes.GetVignetteInfoFromInstanceID
function private.VFrame:VIGNETTE_ADDED(event, instanceid, ...)
	vignette_found_count = vignette_found_count + 1
	Debug("Found: %d  Last ID: %d", vignette_found_count, last_vignette_id)

	if not private.OptionsCharacter.TrackVignettes or
		not instanceid or
		not VignetteFilterByAchievement() or
		-- private.Button:IsShown() or
		_G.GetUnitName("target") == last_vignette_id or
		not VignetteZoneCheck or
		UnitIsDeadOrGhost("player")  or
		not private.CheckDelay(instanceid) then
		return
	end

	-- iconid seems to be 40:chests, 41:mobs
	local x, y, name, iconid = _G.C_Vignettes.GetVignetteInfoFromInstanceID(instanceid)
	local npc_id = private.NPC_NAME_TO_ID[name]
	local alert_text = nil

	if not iconid then --Use case for broken Mob Info
		Debug("Null Mob Data Returned")
		alert_text = L["FOUND_FORMAT"]:format("Vignette Mob")
		private.Button:SetNPC(67490, "Vignette Mob", "Unknown Vignette")
	elseif iconid == 41 then  --Use Case if API returns Mob Info
		Debug("Correct Mob Data Returned")
		--Check to see if mob is on the ignore list
		if _G._NPCScanOptions.IgnoreList.NPCs[npc_id] then
			Debug("Ignored Mob")
			return
		end
		--Check for Vignette mobs that dont exist in our DB
		if npc_id then 
			private.Button:SetNPC(npc_id, name, "Vignette Mob")
			alert_text = L["FOUND_FORMAT"]:format("Vignette Mob: "..name)
		else
			private.Button:SetNPC(29147, name, "Unknown Vignette")
			alert_text = L["FOUND_FORMAT"]:format("Vignette Mob")
		end
		--alert_text = L["FOUND_FORMAT"]:format("Vignette Mob")
		--private.Button:SetNPC(private.NPC_NAME_TO_ID[name], name, "Vignette Mob")
	else -- All other cases
		Debug("Untracked Vigenette")
	end

	if private.Options.ShowAlertAsToast and alert_text then
		Toast:Spawn("_NPCScanAlertToast", alert_text)
	elseif alert_text then
		private.Print(alert_text, _G.GREEN_FONT_COLOR)
	end
end

--Clears last seen mob when vignette is removed from map
function private.VFrame:VIGNETTE_REMOVED(event, instanceid, ...)
	vignette_found_count = vignette_found_count - 1
	if vignette_found_count == 0 then
		if not _G.InCombatLockdown() then
			last_vignette_id = 0
		end
	end
end

