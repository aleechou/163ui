-- -------------------------------------------------------------------------- --
-- GridStatusRaidIcons by kunda                                               --
-- -------------------------------------------------------------------------- --

local GridRoster = Grid:GetModule("GridRoster")
local L = GridStatusRaidIcons_Locales

local GridStatusRaidIcons = Grid:GetModule("GridStatus"):NewModule("GridStatusRaidIcons")
GridStatusRaidIcons.menuName = RAID_TARGET_ICON

local _G = _G
local UnitGUID = _G.UnitGUID
local UnitExists = _G.UnitExists
local GetRaidTargetIndex = _G.GetRaidTargetIndex

local LOC_PLAYER       = RAID_TARGET_ICON..": "..PLAYER
local LOC_PLAYERTARGET = RAID_TARGET_ICON..": "..PLAYER.." "..TARGET
local icontextcolor = {
	[1] = {r = 1.0,  g = 0.92, b = 0,     hex = "ffeb00", text = RAID_TARGET_1}, -- Yellow 4-point Star
	[2] = {r = 0.98, g = 0.57, b = 0,     hex = "fa9100", text = RAID_TARGET_2}, -- Orange Circle
	[3] = {r = 0.83, g = 0.22, b = 0.9,   hex = "d438e6", text = RAID_TARGET_3}, -- Purple Diamond
	[4] = {r = 0.04, g = 0.95, b = 0,     hex = "0af200", text = RAID_TARGET_4}, -- Green Triangle
	[5] = {r = 0.7,  g = 0.82, b = 0.875, hex = "b3d1df", text = RAID_TARGET_5}, -- White Crescent Moon
	[6] = {r = 0,    g = 0.71, b = 1,     hex = "00b5ff", text = RAID_TARGET_6}, -- Blue Square
	[7] = {r = 1.0,  g = 0.24, b = 0.168, hex = "ff3d2b", text = RAID_TARGET_7}, -- Red 'X' Cross
	[8] = {r = 0.98, g = 0.98, b = 0.98,  hex = "fafafa", text = RAID_TARGET_8}  -- White Skull
}

GridStatusRaidIcons.defaultDB = {
	debug = false,
	raidicon_player = {
		[1] = true,
		[2] = true,
		[3] = true,
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
		[8] = true,
	},
	raidicon_playertarget = {
		[1] = true,
		[2] = true,
		[3] = true,
		[4] = true,
		[5] = true,
		[6] = true,
		[7] = true,
		[8] = true,
	},
	alert_raidicons_player = {
		text =  LOC_PLAYER,
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		opacity = 1,
		priority = 50,
		range = false,
	},
	alert_raidicons_playertarget = {
		text =  LOC_PLAYERTARGET,
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		opacity = 1,
		priority = 50,
		range = false,
	}
}

GridStatusRaidIcons.options = false

function GridStatusRaidIcons:OnInitialize()
	self.super.OnInitialize(self)

	local menu_player = {
		["opacity"] = {
			type = "range",
			name = L["Opacity"],
			desc = L["Sets the opacity for the raid icons."],
			min = 0,
			max = 1,
			step = 0.01,
			bigStep = 0.05,
			get = function()
				return GridStatusRaidIcons.db.profile.alert_raidicons_player.opacity
			end,
			set = function(_, v)
				GridStatusRaidIcons.db.profile.alert_raidicons_player.opacity = v
				GridStatusRaidIcons:UpdateAllUnits()
			end,
		},
		["color"] = false,
	}
	local menu_playertarget = {
		["opacity"] = {
			type = "range",
			name = L["Opacity"],
			desc = L["Sets the opacity for the raid icons."],
			min = 0,
			max = 1,
			step = 0.01,
			bigStep = 0.05,
			get = function()
				return GridStatusRaidIcons.db.profile.alert_raidicons_playertarget.opacity
			end,
			set = function(_, v)
				GridStatusRaidIcons.db.profile.alert_raidicons_playertarget.opacity = v
				GridStatusRaidIcons:UpdateAllUnits()
			end,
		},
		["color"] = false,
	}
	for i = 1, #icontextcolor do
		menu_player["raidicon"..i.."_player_toggle"] = {
			type = "toggle",
			name = "|cff"..icontextcolor[i].hex..icontextcolor[i].text.."|r",
			desc = icontextcolor[i].text..".",
			order = 102+i/10,
			get = function()
				return GridStatusRaidIcons.db.profile.raidicon_player[i]
			end,
			set = function()
				GridStatusRaidIcons.db.profile.raidicon_player[i] = not GridStatusRaidIcons.db.profile.raidicon_player[i]
				GridStatusRaidIcons:UpdateAllUnits()
			end
		}
		menu_playertarget["raidicon"..i.."_playertarget_toggle"] = {
			type = "toggle",
			name = "|cff"..icontextcolor[i].hex..icontextcolor[i].text.."|r",
			desc = icontextcolor[i].text..".",
			order = 102+i/10,
			get = function()
				return GridStatusRaidIcons.db.profile.raidicon_playertarget[i]
			end,
			set = function()
				GridStatusRaidIcons.db.profile.raidicon_playertarget[i] = not GridStatusRaidIcons.db.profile.raidicon_playertarget[i]
				GridStatusRaidIcons:UpdateAllUnits()
			end
		}
	end

	self:RegisterStatus("alert_raidicons_player", LOC_PLAYER, menu_player, true)
	self:RegisterStatus("alert_raidicons_playertarget", LOC_PLAYERTARGET, menu_playertarget, true)
end

function GridStatusRaidIcons:OnStatusEnable(status)
	if status == "alert_raidicons_player" or status == "alert_raidicons_playertarget" then
		self:RegisterEvent("RAID_TARGET_UPDATE", "UpdateAllUnits")
		self:RegisterEvent("UNIT_TARGET", "UpdateUnit")
		self:RegisterMessage("Grid_UnitJoined")
		self:UpdateAllUnits()
	end
end

function GridStatusRaidIcons:OnStatusDisable(status)
	if not self.db.profile.alert_raidicons_playertarget.enable and not self.db.profile.alert_raidicons_player.enable then
		self:UnregisterEvent("RAID_TARGET_UPDATE")
		self:UnregisterEvent("UNIT_TARGET")
		self:UnregisterMessage("Grid_UnitJoined")
	end
	if status == "alert_raidicons_player" then
		self.core:SendStatusLostAllUnits("alert_raidicons_player")
	end
	if status == "alert_raidicons_playertarget" then
		self.core:SendStatusLostAllUnits("alert_raidicons_playertarget")
	end
end

function GridStatusRaidIcons:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridStatusRaidIcons:Grid_UnitJoined(event, guid, unitid)
	self:UpdateUnit(event, unitid)
end

function GridStatusRaidIcons:UpdateUnit(event, unitid)
	local guid = UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(guid) then return end

	local settings = self.db.profile.alert_raidicons_playertarget
	local targetid = unitid .. "target"
	if settings.enable and UnitExists(targetid) then
		local raidicon = GetRaidTargetIndex(targetid)
		if raidicon and GridStatusRaidIcons.db.profile.raidicon_playertarget[raidicon] then
			self.core:SendStatusGained(guid, "alert_raidicons_playertarget",
				settings.priority,
				(settings.range and 40),
				{ r = icontextcolor[raidicon].r, g = icontextcolor[raidicon].g, b = icontextcolor[raidicon].b, a = settings.opacity or 1, ignore = true },
				icontextcolor[raidicon].text,
				nil,
				nil,
				"Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..raidicon)
		else
			self.core:SendStatusLost(guid, "alert_raidicons_playertarget")
		end
	else
		self.core:SendStatusLost(guid, "alert_raidicons_playertarget")
	end
end

function GridStatusRaidIcons:UpdateAllUnits()
	local settings = self.db.profile.alert_raidicons_player
	for guid, unitid in GridRoster:IterateRoster() do
		local raidicon = GetRaidTargetIndex(unitid)
		-- unit
		if settings.enable and raidicon and GridStatusRaidIcons.db.profile.raidicon_player[raidicon] then
			self.core:SendStatusGained(guid, "alert_raidicons_player",
				settings.priority,
				(settings.range and 40),
				{ r = icontextcolor[raidicon].r, g = icontextcolor[raidicon].g, b = icontextcolor[raidicon].b, a = settings.opacity or 1, ignore = true },
				icontextcolor[raidicon].text,
				nil,
				nil,
				"Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..raidicon)
		else
			self.core:SendStatusLost(guid, "alert_raidicons_player")
		end

		-- unit target
		self:UpdateUnit("UpdateAllUnits", unitid)
	end
end