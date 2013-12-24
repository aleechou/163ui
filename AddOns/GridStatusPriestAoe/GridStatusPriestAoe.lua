------------------------------------------------------------------------------
--	GridStatusPriestAoe by Slaren
--    Thanks to Duugu for GridStatusCloseUp idea and original code
------------------------------------------------------------------------------

local QuickHealth = LibStub and LibStub("LibQuickHealth-2.0", true) -- don't error if not found
local MapFiles = LibStub("LibMapData-1.0")
local GridStatus = Grid:GetModule("GridStatus")

GridStatusPriestAoe = GridStatus:NewModule("GridStatusPriestAoe")
GridStatusPriestAoe.menuName = "Priest Aoe Healing"

-- constants
local TALENTTREE_DISCIPLINE = 1
local TALENTTREE_HOLY = 2

local TALENT_TWIN_DISCIPLINES 	= { TALENTTREE_DISCIPLINE, 2 }
local TALENT_COH 				= { TALENTTREE_HOLY, 20 }
local TALENT_TEST_OF_FAITH		= { TALENTTREE_HOLY, 18 }

local SPELLID_COH = 34861
local SPELLID_POH = 596
-- local SPELLID_GOPOH = 56161 		-- Glyph of Prayer of Healing
local SPELLID_CHAKRA_SANCT = 81206	-- Chakra: Sanctuary

local GLYPH_COH = 55675

local ICON_COH = "Interface\\Icons\\Spell_Holy_CircleOfRenewal"
local ICON_POH = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02"
local ICON_HN = "Interface\\Icons\\Spell_Holy_HolyNova"

local COH_BASE = (4599 + 5082) / 2
local POH_BASE = (6766 + 7148) / 2
local HN_BASE =  (2373 + 2756) / 2

local SPELLMOD_COH = 0.467
local SPELLMOD_POH = 0.671
local SPELLMOD_HN =  0.247

local PARTY_STATE_GROUP_COUNT = {
	["solo"] = 1,
	["party"] = 1,
	["raid_25"] = 5,
	["raid_10"] = 2,
	["bg"] = 8,
	["arena"] = 1
}

-- locals
local GridStatusPriestAoe = GridStatusPriestAoe
local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")
local UnitGUID = UnitGUID
local GetPlayerMapPosition = GetPlayerMapPosition
local SetMapToCurrentZone = SetMapToCurrentZone
local GetSpellCooldown = GetSpellCooldown
local UnitHealth = QuickHealth and QuickHealth.UnitHealth or UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitIsVisible = UnitIsVisible
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsConnected = UnitIsConnected
local UnitIsEnemy = UnitIsEnemy
local UnitIsCharmed = UnitIsCharmed
local UnitIsUnit = UnitIsUnit
local UnitInRange = UnitInRange
local UnitBuff = UnitBuff
local UnitGetIncomingHeals = UnitGetIncomingHeals
local GetSpellCritChance = GetSpellCritChance
local GetSpellBonusHealing = GetSpellBonusHealing
local math_min = math.min
local math_max = math.max
local math_floor = math.floor
local tinsert = table.insert
local tsort = table.sort
local select = select
local pairs = pairs
local wipe = wipe
local tostring = tostring

local WorldMapFrame = WorldMapFrame


-- local data
local settings
local settings_coh
local settings_poh
local settings_hn
local num_enabled = 0
local update_frame = CreateFrame("Frame")
local coh_prev_best = {
	uid = nil,
	guid = nil,
	amount = -1
}
local poh_prev_best
local spellname_gopoh
local spellname_chakra_sanct
local coh_targets
local coh_coef_madd
local coh_coef_m
local poh_coef_madd
local poh_coef_m
local hn_coef_madd
local hn_coef_m
local update_timer = 0
local coh_testrange_sq
local poh_testrange_sq
local hn_testrange_sq
local num_groups
local test_of_faith_mul
local roster
local player_group
local player_guid


-- Options
GridStatusPriestAoe.defaultDB = {
	debug = false,
	cycle_time = 0.2,
	first_groups_only = true,

	alert_priestaoe_coh = {
		-- coh
		enable = true,
		color = { r = 1, g = 1, b = 0, a = 1 },
		priority = 99,
		range = true,

		enable_if_have = true,
		threshold = 15000,
		hidecd = true,

		emphasize = true,
		emphasize_color = { r = 1, g = 1, b = 0 },
		emphasize_priority = 51,
	},
	alert_priestaoe_poh = {
		-- poh
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 97,
		range = true,

		always_best = false,
		-- hide_glyph = false,
		threshold = 20000,
		incoming_heals = false,
		
		emphasize = false,
		emphasize_color = { r = 1, g = 1, b = 1 },
		emphasize_priority = 50,
	},
	alert_priestaoe_hn = {
		-- holy nova
		enable = true,
		color = { r = 0, g = 1, b = 0, a = 1 },
		priority = 98,

		threshold = 7500,
		emphasize = false,
	}
}

local coh_options = {
	["coh_threshold"] = {
		order = 100,
		type = "range",
		name = "Heal threshold",
		desc = "Threshold for heal amount",
		softMax = 100000,
		min = 1,
		step = 1,
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_coh.threshold end,
		set = function (_, v) GridStatusPriestAoe.db.profile.alert_priestaoe_coh.threshold = v end,
	},
	["coh_enable_if_have"] = {
		order = 101,
		type = "toggle",
		name = "Show only while having the talent",
		desc = "Enable this if you want to hide this status while using a talent spec that does not include Circle of Healing",
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_coh.enable_if_have end,
		set = function (_, v) GridStatusPriestAoe.db.profile.alert_priestaoe_coh.enable_if_have = v; GridStatusPriestAoe:UpdateTalents(); end,
	},
	["coh_hidecd"] = {
		order = 102,
		type = "toggle",
		name = "Hide while on cooldown",
		desc = "Hide status while Circle of Healing is on cooldown",
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_coh.hidecd end,
		set = function (_, arg) GridStatusPriestAoe.db.profile.alert_priestaoe_coh.hidecd = arg end,
	}
}

local poh_options = {
	["poh_threshold"] = {
		order = 100,
		type = "range",
		name = "Heal threshold",
		desc = "Threshold for heal amount",
		softMax = 100000,
		min = 1,
		step = 1,
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_poh.threshold end,
		set = function (_, v) GridStatusPriestAoe.db.profile.alert_priestaoe_poh.threshold = v end,
	},
	["poh_enablebest"] = {
		order = 101,
		type = "toggle",
		name = "Always show best target in each group",
		desc = "Shows best target to cast Prayer of Healing on in each group, even if the heal amount is below the threshold (minimum 3 targets)",
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_poh.always_best end,
		set = function (_, v) GridStatusPriestAoe.db.profile.alert_priestaoe_poh.always_best = v end,
	},
	--[[
	["poh_hideglyph"] = {
		order = 102,
		type = "toggle",
		name = "Ignore players affected by your Glyph of Prayer of Healing",
		desc = "Ignores players that have your Glyph of Prayer of Healing buff (modified by your Prayer of Healing cast time)",
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_poh.hide_glyph end,
		set = function (_, arg) GridStatusPriestAoe.db.profile.alert_priestaoe_poh.hide_glyph = arg end,
	},
	]]
	["poh_incomingheals"] = {
		order = 103,
		type = "toggle",
		name = "Subtract incoming heals",
		desc = "Subtracts incoming heals from the health deficit before making the calculations (your own heals are excluded)",
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_poh.incoming_heals end,
		set = function (_, arg) GridStatusPriestAoe.db.profile.alert_priestaoe_poh.incoming_heals = arg end,
	},
}

local hn_options = {
	["range"] = false,
	["hn_threshold"] = {
		order = 100,
		type = "range",
		name = "Heal threshold",
		desc = "Threshold for heal amount",
		softmax = 100000,
		min = 1,
		step = 1,
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_hn.threshold end,
		set = function (_, v) GridStatusPriestAoe.db.profile.alert_priestaoe_hn.threshold = v end,
	}
}

GridStatusPriestAoe.extraOptions = {
	["frequency"] = {
		order = 100,
		type = "range",
		name = "Refresh time",
		desc = "Seconds between status refreshes",
		width = "full",
		get = function () return GridStatusPriestAoe.db.profile.cycle_time end,
		set = function (_, v) GridStatusPriestAoe.db.profile.cycle_time = v end,
		min = 0.01,
		max = 1,
		step = 0.01,
	},
	["first_groups_only"] = {
		order = 101,
		type = "toggle",
		name = "Check only first groups",
		desc = "Depending on the raid size, checks only the first groups to improve performance",
		get = function () return GridStatusPriestAoe.db.profile.first_groups_only end,
		set = function (_, v) GridStatusPriestAoe.db.profile.first_groups_only = v; GridStatusPriestAoe:UpdateNumGroups() end,
	},
}

-- Emphasize
local Emphasize = GridStatus:GetModule("GridStatusEmphasize", true)

local function print(...)
	DEFAULT_CHAT_FRAME:AddMessage("|cff33ff99GridStatusPriestAoe|r: " .. table.concat({...}, " "))
end

if Emphasize and not Emphasize.EmphasizeUnit then
	print("Your version of GridStatusEmphasize is not compatible with this version of GridStatusPriestAoe. Please update to the most recent version.")
	Emphasize = nil
end

if Emphasize then
	local PriestAoe_Emphasize = Emphasize:NewModule("PriestAoe_Emphasize")
	local emphasize_options = {
		["coh"] = {
			type = "group",
			inline = true,
			name = "Circle of Healing",
			args = {
				["emphasize"] = {
					order = 1,
					type = "toggle",
					width = "full",
					name = "Emphasize Circle of Healing",
					get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize end,
					set = function (_, v)
						GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize = v
						GridStatusPriestAoe:ClearCohStatus()
					end,
				},
				["color"] = {
					order = 2,
					type = "color",
					hasAlpha = false,
					name = "Color",
					disabled = function() return not GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize end,
					get = function ()
						local color = GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize_color
						return color.r, color.g, color.b
					end,
					set = function (_, r, g, b)
						local color = GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize_color
						color.r = r
						color.g = g
						color.b = b
					end,
				},
				["priority"] = {
					order = 3,
					type = "range",
					max = 99,
					min = 0,
					step = 1,
					name = "Priority",
					disabled = function() return not GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize end,
					get = function() return GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize_priority end,
					set = function(_, v)
						GridStatusPriestAoe.db.profile.alert_priestaoe_coh.emphasize_priority = v
						GridStatusPriestAoe:ClearCohStatus()
					end,
				},
			},
		},
		["poh"] = {
			type = "group",
			inline = true,
			name = "Prayer of Healing",
			args = {
				["emphasize"] = {
					order = 1,
					type = "toggle",
					width = "full",
					name = "Emphasize Prayer of Healing",
					get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize end,
					set = function (_, v)
						GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize = v
						GridStatusPriestAoe:ClearPohEmphasizeStatus()
					end,
				},
				["color"] = {
					order = 2,
					type = "color",
					hasAlpha = false,
					name = "Color",
					disabled = function() return not GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize end,
					get = function ()
						local color = GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize_color
						return color.r, color.g, color.b
					end,
					set = function (_, r, g, b)
						local color = GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize_color
						color.r = r
						color.g = g
						color.b = b
					end,
				},
				["priority"] = {
					order = 3,
					type = "range",
					max = 99,
					min = 0,
					step = 1,
					name = "Priority",
					disabled = function() return not GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize end,
					get = function() return GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize_priority end,
					set = function(_, v)
						GridStatusPriestAoe.db.profile.alert_priestaoe_poh.emphasize_priority = v
						GridStatusPriestAoe:ClearPohEmphasizeStatus()
					end,
				},				
			}
		}
		--[[ Holy Nova
		["hn_emphasize"] = {
			order = 3,
			type = "toggle",
			name = "Holy Nova",
			desc = "Emphasize Holy Nova",
			get = function () return GridStatusPriestAoe.db.profile.alert_priestaoe_hn.emphasize end,
			set = function (_, v)
				GridStatusPriestAoe.db.profile.alert_priestaoe_hn.emphasize = v
				if not v then Emphasize:DeemphasizeAllUnits("priestaoe_hn") end
			end,
		},
		]]
	}
	function PriestAoe_Emphasize:OnInitialize()
		self.super.OnInitialize(self)

		self:RegisterOptions("Priest Aoe Healing", emphasize_options)
	end
end

function GridStatusPriestAoe:OnInitialize()
	self.super.OnInitialize(self)
	-- self.core.core:AddModuleDebugMenu(self)

	self:RegisterStatus("alert_priestaoe_coh", string.format("|T%s:0:0:0:0:64:64:4:60:4:60|t", ICON_COH) .. " Circle of Healing", coh_options)
	self:RegisterStatus("alert_priestaoe_poh", string.format("|T%s:0:0:0:0:64:64:4:60:4:60|t", ICON_POH) .. " Prayer of Healing", poh_options)
	--[[ Holy Nova
	self:RegisterStatus("alert_priestaoe_hn", "Priest Aoe - Holy Nova", hn_options)
	]]
	
	GridStatus.registryDescriptions["alert_priestaoe_coh"] = string.format("|T%s:0:0:0:0:64:64:4:60:4:60|t", ICON_COH) .. " Priest Aoe - Circle of Healing"
	GridStatus.registryDescriptions["alert_priestaoe_poh"] = string.format("|T%s:0:0:0:0:64:64:4:60:4:60|t", ICON_POH) .. " Priest Aoe - Prayer of Healing"

	settings = self.db.profile
	settings_coh = self.db.profile.alert_priestaoe_coh
	settings_poh = self.db.profile.alert_priestaoe_poh
	settings_hn = self.db.profile.alert_priestaoe_hn
end

function GridStatusPriestAoe:OnStatusEnable(status)
	if status == "alert_priestaoe_coh" or status == "alert_priestaoe_poh" or status == "alert_priestaoe_hn" then
		num_enabled = num_enabled + 1
		if num_enabled == 1 then
			self:UpdateRoster()
			self:UpdateNumGroups()

			self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateTalents")
			self:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdateCoefs")
			self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateRoster")
			self:RegisterMessage("Grid_PartyTransition", "UpdateNumGroups")
			MapFiles:RegisterCallback("MapChanged", function(event, map, floor, w, h) GridStatusPriestAoe:UpdateMapData(map, floor, w, h) end)

			-- check talents the first frame, then change OnUpdate script to the real function
			update_frame:SetScript("OnUpdate",
				function()
					-- spellname_gopoh = GetSpellInfo(SPELLID_GOPOH)
					spellname_chakra_sanct = GetSpellInfo(SPELLID_CHAKRA_SANCT)
					
					player_guid = UnitGUID("player")
					
					self:UpdateTalents()
					
					update_frame:SetScript("OnUpdate", function(_, elapsed) return self:OnUpdate(elapsed) end)
				end)
		end
	end
end

function GridStatusPriestAoe:OnStatusDisable(status)
	if num_enabled > 0 then
		if status == "alert_priestaoe_coh" then
			self.core:SendStatusLostAllUnits("alert_priestaoe_coh")
			if Emphasize then Emphasize:DeemphasizeAllUnits("priestaoe_coh") end
			num_enabled = num_enabled - 1
		elseif status == "alert_priestaoe_poh" then
			self.core:SendStatusLostAllUnits("alert_priestaoe_poh")
			if Emphasize then Emphasize:DeemphasizeAllUnits("priestaoe_poh") end
			num_enabled = num_enabled - 1
		elseif status == "alert_priestaoe_hn" then
			self.core:SendStatusLostAllUnits("alert_priestaoe_hn")
			if Emphasize then Emphasize:DeemphasizeAllUnits("priestaoe_hn") end
			num_enabled = num_enabled - 1
		end

		if num_enabled == 0 then
			update_frame:SetScript("OnUpdate", nil)
			self:UnregisterEvent("PLAYER_TALENT_UPDATE")
			self:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
			self:UnregisterEvent("GROUP_ROSTER_UPDATE")
			self:UnregisterMessage("Grid_PartyTransition")
			MapFiles:UnregisterCallback("MapChanged")
		end
	end
end

function GridStatusPriestAoe:UpdateRoster()
	self:ClearCohStatus()
	self:ClearPohStatus()

	roster = { [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {} }

	if not IsInRaid() then
		tinsert(roster[1], "player")
		player_group = 1
		for i = 1, 4 do
			local unitid = "party" .. i
			if UnitExists(unitid) then
				tinsert(roster[1], unitid)
			end
		end
	else
		for i = 1, GetNumGroupMembers() do
			local name, _, group = GetRaidRosterInfo(i)
			local unitid = "raid" .. i
			if name and UnitExists(unitid) then
				tinsert(roster[group], unitid)
				if UnitIsUnit("player", unitid) then
					player_group = group
				end
			end
		end
	end

	self:Debug("roster updated:", #roster[1], #roster[2], #roster[3], #roster[4], #roster[5], #roster[6], #roster[7], #roster[8])
end

function GridStatusPriestAoe:UpdateTalents()
	-- check coh
	if (select(2, UnitClass("player")) == "PRIEST") and (GetSpecialization() == TALENTTREE_HOLY) then
		-- check if player has coh glyph
		if self:HasGlyph(GLYPH_COH) then
			coh_targets = 6
		else
			coh_targets = 5
		end
	else
		coh_targets = nil
	end

	-- lost coh? clear status
	if settings_coh.enable and settings_coh.enable_if_have and not coh_targets then
		self:ClearCohStatus()
	end

	-- update ranges
	coh_testrange_sq = 30 ^ 2
	poh_testrange_sq = 30 ^ 2
	hn_testrange_sq = 10 ^ 2

	-- update spell coefs
	self:UpdateCoefs()

	self:Debug("coh_targets:", coh_targets)
end

function GridStatusPriestAoe:UpdateNumGroups()
	self:ClearCohStatus()
	self:ClearPohStatus()
	num_groups = (settings.first_groups_only and PARTY_STATE_GROUP_COUNT[GridRoster:GetPartyState()]) or 8

	self:Debug("num_groups:", num_groups)
end

function GridStatusPriestAoe:ClearCohStatus()
	if coh_prev_best.guid then
		self.core:SendStatusLost(coh_prev_best.guid, "alert_priestaoe_coh")
		if Emphasize then Emphasize:DeemphasizeUnit(coh_prev_best.guid, "priestaoe_coh") end
		coh_prev_best.guid = nil
		coh_prev_best.uid = nil
		coh_prev_best.amount = -1
	end
end

function GridStatusPriestAoe:ClearPohGridStatus()
	self.core:SendStatusLostAllUnits("alert_priestaoe_poh")
end

function GridStatusPriestAoe:ClearPohEmphasizeStatus()
	if Emphasize then Emphasize:DeemphasizeUnit(poh_prev_best, "priestaoe_poh") end
	poh_prev_best = nil
end

function GridStatusPriestAoe:ClearPohStatus()
	self:ClearPohGridStatus()
	self:ClearPohEmphasizeStatus()
end

--[[
function GridStatusPriestAoe:ClearHnStatus()
	self.core:SendStatusLost(player_guid, "alert_priestaoe_hn")
	if Emphasize then Emphasize:DeemphasizeUnit(player_guid, "priestaoe_hn") end
end
]]

-- debug
local update_init_time = nil
local update_time = nil
local update_this_start_time = 0
local debug_frame = nil
local debug_fs = nil
local GetTime = GetTime

local function start_timing()
	if not debug_frame then
		debug_frame = CreateFrame("Frame", "gridstatuspriestaoe_performance_monitor", UIParent)
		debug_fs = debug_frame:CreateFontString(nil, "OVERLAY")
		debug_fs:SetFont(STANDARD_TEXT_FONT, 18,"THICKOUTLINE")
		debug_fs:SetPoint("LEFT", UIParent, "LEFT")
		debug_fs:SetText("GridStatusPriestAoe performance monitor")
	end
	local ctime = GetTime()
	update_this_start_time = ctime
	if update_init_time == nil then
		update_init_time = ctime
		update_time = 0
	end
end

local function end_timing()
	local ctime = GetTime()
	update_time = update_time + (ctime - update_this_start_time)

	local elapsed = ctime - update_init_time
	if elapsed >= 5 then
		debug_fs:SetText(string.format("%0.2f%%", update_time/elapsed*100))

		update_time = 0
		update_init_time = nil
	end
end
-- debug end

function GridStatusPriestAoe:OnUpdate(elapsed)
	update_timer = update_timer + elapsed

	-- check for coh cooldown here to update faster
	if coh_prev_best.guid and settings_coh.enable and settings_coh.hidecd and (not settings_coh.enable_if_have or coh_targets) and not self:IsCohReady() then
		self:ClearCohStatus()
	end

	if update_timer >= settings.cycle_time then
		update_timer = 0
		if settings.debug then start_timing() end
		GridStatusPriestAoe:RefreshAll()
		if settings.debug then end_timing() end
	end
end

local refresh_state = {
	player_x = 0,
	player_y = 0,
	player_data = {}
}

local map_width = 0
local map_height = 0


local function DistanceSq(x1, y1, x2, y2)
	local xx = x2 - x1
	local yy = y2 - y1

	return xx*xx + yy*yy
end

local function IsValidTarget(unitid)
	return not UnitIsDeadOrGhost(unitid) and
				UnitIsConnected(unitid) and
				UnitIsVisible(unitid) and
				not (UnitIsCharmed(unitid) and UnitIsEnemy("player", unitid))
end

local function IsUnitInRange(unitid)
	if UnitIsUnit(unitid, "player") then
		return true
	else
		return UnitInRange(unitid)
	end
end

function GridStatusPriestAoe:UpdateMapData(map, floor, w, h)
	self:Debug("map: ", map, floor, w, h)

	map_width = w
	map_height = h

	if w == 0 and h == 0 then
		--print("No map data available, status will be disabled. Installing the latest version of LibMapData-1.0 may fix this problem.")
	end
end

function GridStatusPriestAoe:RefreshMapData()
	if map_width == 0 and map_height == 0 then
		return false
	end

	-- check player position
	refresh_state.player_x, refresh_state.player_y = GetPlayerMapPosition("player")

	--[[
	if refresh_state.player_x <= 0 and refresh_state.player_y <= 0 then
		if WorldMapFrame:IsVisible() then
			return false
		end
		-- carbonite blinking map workaround
		local f = GetMouseFocus()
		while f do
			if f:GetName() == "NxMap1" then
				return false
			end
			f = f:GetParent()
		end

		SetMapToCurrentZone()
		refresh_state.player_x, refresh_state.player_y = GetPlayerMapPosition("player")
	end
	]]

	-- continue only if map supported
	if (refresh_state.player_x > 0 or refresh_state.player_y > 0) then
		return true
	end

	self:Debug("GetPlayerMapPosition failed")
	return false
end

function GridStatusPriestAoe:RefreshAll()
	if not self:RefreshMapData() then
		if settings_coh.enable then
			self:ClearCohStatus()
		end

		if settings_poh.enable then
			self:ClearPohStatus()
		end

		--[[
		if settings_hn.enable then
			self:ClearHnStatus()
		end
		]]
	else
		local ctime = GetTime()
		local poh_time = select(7, GetSpellInfo(SPELLID_POH)) / 1000 -- Prayer of Healing cast time, in seconds

		-- cache player data
		refresh_state.player_x = refresh_state.player_x * map_width
		refresh_state.player_y = refresh_state.player_y * map_height
		wipe(refresh_state.player_data)
		for group = 1, num_groups do
			for _, unitid in pairs(roster[group]) do
				local cx, cy = GetPlayerMapPosition(unitid)
				if (cx ~= 0 or cy ~= 0) and IsValidTarget(unitid) then
					local health = UnitHealth(unitid)
					local health_max = UnitHealthMax(unitid)
					local cguid = UnitGUID(unitid)
					local percent = health / health_max
					-- local gopoh = settings_poh.hide_glyph and self:UnitHasPlayerAura(unitid, spellname_gopoh) or 0

					refresh_state.player_data[unitid] = {
						guid = cguid,
						x = cx * map_width,
						y = cy * map_height,
						deficit = health_max - health,
						percent = percent,
						incoming = self:GetIncomingHeals(unitid),
						-- gopoh = (gopoh - ctime) > (poh_time + 0.5),
						healmod = self:GetHealModifier(cguid) * (percent <= 0.5 and test_of_faith_mul or 1)
					}
				end
			end
		end
		
		refresh_state.player_mod = self:GetPlayerHealingMod()
		
		if settings_coh.enable and
			(not settings_coh.hidecd or self:IsCohReady()) and
			(not settings_coh.enable_if_have or coh_targets) then
			self:RefreshCoH()
		end

		if settings_poh.enable then
			self:RefreshPoH()
		end

		--[[ Holy Nova
		if settings_hn.enable then
			self:RefreshHN()
		end
		]]
	end
end

-- Circle of Healing
local function CohSortTargets(x, y)
	return x.percent < y.percent
end

local targets = {}
function GridStatusPriestAoe:RefreshCoH()
	local refresh_state = refresh_state

	local coh_avg = self:GetCohAvg() * refresh_state.player_mod

	local coh_best_uid = nil
	local coh_best_amount = -1
	local coh_best_pdata = nil
	local coh_best_dists = nil

	for unitid, p1 in pairs(refresh_state.player_data) do
		if not settings_coh.range or IsUnitInRange(unitid) then
			wipe(targets)
			for tunitid, p2 in pairs(refresh_state.player_data) do
				local dist = p1 == p2 and 0 or DistanceSq(p1.x, p1.y, p2.x, p2.y)
				if dist <= coh_testrange_sq and p2.deficit > 0 then
					local amount = math_min(p2.deficit, coh_avg * p2.healmod)
					if amount > 0 then
						tinsert(targets, { amount = amount, percent = p2.percent, dist = dist })
					end
				end
			end

			-- order candidate targets, get best
			if #targets > (coh_targets or 5) then
				tsort(targets, CohSortTargets)
			end

			local dists = 0
			local hsum = 0
			for ti = 1, math_min(coh_targets or 5, #targets) do
				hsum = hsum + targets[ti].amount
				dists = math_max(dists, targets[ti].dist)
			end
			-- dists = dists / math_min(coh_targets or 5, #targets)

			-- select best, buy try to keep same target
			if hsum > coh_best_amount or
					(hsum == coh_best_amount and (
						unitid == coh_prev_best.uid or
						(coh_best_uid ~= coh_prev_best.uid and dists < coh_best_dists)
						)) then
				coh_best_uid = unitid
				coh_best_amount = hsum
				coh_best_pdata = p1
				coh_best_dists = dists
			end
		end
	end

	-- send status to best
	if coh_best_uid ~= coh_prev_best.uid or coh_best_amount < settings_coh.threshold then
		self:ClearCohStatus()
	end

	if coh_best_uid and coh_best_amount >= settings_coh.threshold then
		if coh_prev_best.uid ~= coh_best_uid or coh_prev_best.guid ~= coh_best_pdata.guid or coh_prev_best.amount ~= coh_best_amount then
			self.core:SendStatusGained(	coh_best_pdata.guid,
										"alert_priestaoe_coh",
										settings_coh.priority,
										nil,
										settings_coh.color,
										tostring(math_floor(coh_best_amount + 0.5)),
										1,
										nil,
										ICON_COH)
		end
		
		if Emphasize and settings_coh.emphasize and coh_prev_best.guid ~= coh_best_pdata.guid then
			Emphasize:EmphasizeUnit(coh_best_pdata.guid, "priestaoe_coh", settings_coh.emphasize_priority, settings_coh.emphasize_color)
		end
		
		coh_prev_best.uid = coh_best_uid
		coh_prev_best.guid = coh_best_pdata.guid
		coh_prev_best.amount = coh_best_amount
	end
end

-- Prayer of Healing
function GridStatusPriestAoe:RefreshPoH()
	local refresh_state = refresh_state

	self:ClearPohGridStatus()

	local poh_avg = self:GetPohAvg() * refresh_state.player_mod

	local best_group_guid = nil
	local best_group_amount = nil
	
	-- check all
	for group = 1, num_groups do
		local group_best_uid = nil
		local group_best_amount = -1
		local group_best_targets = -1
		local group_best_pdata = nil

		for _, unitid in pairs(roster[group]) do
			if not settings_poh.range or IsUnitInRange(unitid) then
				local amount = 0
				local targets = 0

				local p1 = refresh_state.player_data[unitid]
				if p1 then
					for _, tunitid in pairs(roster[group]) do
						local p2 = refresh_state.player_data[tunitid]
						if p2 --[[ and not p2.gopoh ]] then
							local dist = DistanceSq(p1.x, p1.y, p2.x, p2.y)
							if dist <= poh_testrange_sq then
								amount = amount + math_min(math_max(0, p2.deficit - p2.incoming), poh_avg * p2.healmod)
								targets = targets + 1
							end
						end
					end

					if amount > group_best_amount or (amount == group_best_amount and targets > group_best_targets) then
						group_best_amount = amount
						group_best_uid = unitid
						group_best_targets = targets
						group_best_pdata = p1
					end
				end
			end
		end
		
		if group_best_uid and (not best_group_guid or group_best_amount > best_group_amount) then
			best_group_guid = group_best_pdata.guid
			best_group_amount = group_best_amount
		end

		if group_best_uid and ((settings_poh.always_best and group_best_targets >= 3) or group_best_amount >= settings_poh.threshold) then
			local text = (group_best_amount >= settings_poh.threshold) and math_floor(group_best_amount + 0.5) or group_best_targets
			self.core:SendStatusGained(	group_best_pdata.guid,
										"alert_priestaoe_poh",
										settings_poh.priority,
										nil,
										settings_poh.color,
										tostring(text),
										1,
										nil,
										ICON_POH)
		end
	end
	
	if Emphasize and settings_poh.emphasize then
		if best_group_amount and best_group_amount > settings_poh.threshold then
			if poh_prev_best ~= best_group_guid then
				self:ClearPohEmphasizeStatus()
				poh_prev_best = best_group_guid
				Emphasize:EmphasizeUnit(best_group_guid, "priestaoe_poh", settings_poh.emphasize_priority, settings_poh.emphasize_color)
			end
		else
			self:ClearPohEmphasizeStatus()
		end
	end
end

--[[ Holy Nova
local function HnSortTargets(x, y)
	return x.dist < y.dist
end

local inrange = {}
function GridStatusPriestAoe:RefreshHN()
	local refresh_state = refresh_state

	self:ClearHnStatus()

	if settings.first_groups_only and player_group > num_groups then
		return
	end

	local hn_avg = self:GetHnAvg() * refresh_state.player_mod

	wipe(inrange)

	local amount = 0

	for unitid, p2 in pairs(refresh_state.player_data) do
		if p2.guid == player_guid then
			amount = math_min(p2.deficit, hn_avg * p2.healmod)
		else
			local dist = DistanceSq(refresh_state.player_x, refresh_state.player_y, p2.x, p2.y)
			if dist <= hn_testrange_sq then
				tinsert(inrange, { player = p2, dist = dist })
			end
		end
	end

	-- sort targets by distance and select the 4 closest to the player
	if #inrange > 4 then
		tsort(inrange, HnSortTargets)
	end

	for ti = 1, math_min(4, #inrange) do
		amount = amount + math_min(inrange[ti].player.deficit, hn_avg * inrange[ti].player.healmod)
	end

	if amount >= settings_hn.threshold then
		self.core:SendStatusGained(	player_guid,
									"alert_priestaoe_hn",
									settings_hn.priority,
									nil,
									settings_hn.color,
									tostring(math_floor(amount + 0.5)),
									1,
									nil,
									ICON_HN)
		if settings_hn.emphasize and Emphasize then
			Emphasize:EmphasizeUnit(player_guid, "priestaoe_hn", settings_hn.color)
		end
	end
end
]]

function GridStatusPriestAoe:HasGlyph(gid)
	for i = 1, 9 do
		local _, _, _, id = GetGlyphSocketInfo(i)
		if id and gid == id then
			return true
		end
	end
	return false
end

function GridStatusPriestAoe:GetSetAmount(set)
	local amount = 0
	for _, itemID in ipairs(set) do
		if IsEquippedItem(itemID) then
			amount = amount + 1
		end
	end
	return amount
end

function GridStatusPriestAoe:IsCohReady()
	local start, duration = GetSpellCooldown(SPELLID_COH)

	-- ignore global cooldown, show if ready or less than 0.5 secs of cooldown remaining
	if start == 0 or duration <= 1.5 or ((duration - (GetTime() - start)) <= 0.5) then
		return true
	end

	return false
end

function GridStatusPriestAoe:UnitHasPlayerAura(unitid, aura)
	local name, _, _, _, _, _, expires, caster = UnitBuff(unitid, aura)
	return name and caster == "player" and expires
end

-- TODO: probably would be best to create a library to calculate this
function GridStatusPriestAoe:GetPlayerHealingMod()
	local sanctuary = UnitBuff("player", spellname_chakra_sanct) and 1 or 0
	local mod = 0.15 * sanctuary
	return 1 + mod
end

function GridStatusPriestAoe:GetHealModifier(guid)
	return 1
end

function GridStatusPriestAoe:GetIncomingHeals(unitid)
	if settings_poh.enable and settings_poh.incoming_heals then
		return (UnitGetIncomingHeals(unitid) or 0) - (UnitGetIncomingHeals(unitid, "player") or 0)
	end
	return 0
end

function GridStatusPriestAoe:UpdateCoefs()
	--[[
	-- TODO: update this for level 90
	-- get talents
	local _, _, _, _, twin_disciplines = GetTalentInfo(TALENT_TWIN_DISCIPLINES[1], TALENT_TWIN_DISCIPLINES[2])
	local _, _, _, _, test_of_faith = GetTalentInfo(TALENT_TEST_OF_FAITH[1], TALENT_TEST_OF_FAITH[2])
	local spiritual_healing = GetSpecialization() == TALENTTREE_HOLY and 1 or 0

	-- Test of Faith
	test_of_faith_mul = 1 + test_of_faith * 0.04

	-- Circle of Healing
	coh_coef_madd =
			spiritual_healing * 0.15 +
			twin_disciplines * 0.02

	coh_coef_m = 1

	-- Prayer of Healing
	poh_coef_madd =
			spiritual_healing * 0.15 +
			twin_disciplines * 0.02

	poh_coef_m = 1

	-- Holy Nova
	hn_coef_madd =
			spiritual_healing * 0.15 +
			twin_disciplines * 0.02

	hn_coef_m = 1
	]]
	test_of_faith_mul = 1
	coh_coef_madd = 0
	coh_coef_m = 1
	poh_coef_madd = 0
	poh_coef_m = 1
	hn_coef_madd = 0
	hn_coef_m = 1
end

function GridStatusPriestAoe:GetSpellAvg(base, coef_madd, coef_m, spellmod)
	local coef = (1 + coef_madd) * coef_m
	local spellcrit = GetSpellCritChance(2)
	local spellbonus = GetSpellBonusHealing()

	local total = (base + spellbonus * spellmod) * coef
	-- total = total * (1 + spellcrit / 200.0) -- apply crit

	return math_floor(total + 0.5)
end

function GridStatusPriestAoe:GetCohAvg()
	return self:GetSpellAvg(COH_BASE, coh_coef_madd, coh_coef_m, SPELLMOD_COH)
end

function GridStatusPriestAoe:GetPohAvg()
	return self:GetSpellAvg(POH_BASE, poh_coef_madd, poh_coef_m, SPELLMOD_POH)
end

function GridStatusPriestAoe:GetHnAvg()
	return self:GetSpellAvg(HN_BASE, hn_coef_madd, hn_coef_m, SPELLMOD_HN)
end
