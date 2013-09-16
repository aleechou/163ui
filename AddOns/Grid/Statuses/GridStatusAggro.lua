--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
------------------------------------------------------------------------
	GridStatusAggro.lua
	GridStatus module for tracking aggro/threat.
----------------------------------------------------------------------]]

local _, Grid = ...
local L = Grid.L

local GridStatus = Grid:GetModule("GridStatus")
local GridRoster = Grid:GetModule("GridRoster")

local GridStatusAggro = Grid:NewStatusModule("GridStatusAggro")
GridStatusAggro.menuName = L["Aggro"]

local function getthreatcolor(status)
    local r, g, b = GetThreatStatusColor(status)
    return { r = r, g = g, b = b, a = 1 }
end

--{{{ AceDB defaults

GridStatusAggro.defaultDB = {
	alert_aggro = {
		text =  L["Aggro"],
		enable = true,
		color = { r = 1, g = 0, b = 0, a = 1 },
		priority = 99,
		range = false,
		threat = false,
		threatcolors = {
			[1] = getthreatcolor(1),
			[2] = getthreatcolor(2),
			[3] = getthreatcolor(3),
		},
		threattexts = {
			[1] = L["High"],
			[2] = L["Aggro"],
			[3] = L["Tank"]
		},
	},
}

--}}}

GridStatusAggro.options = false

local function getstatuscolor(status)
    local color = GridStatusAggro.db.profile.alert_aggro.threatcolors[status]
    return color.r, color.g, color.b, color.a
end

local function setstatuscolor(status, r, g, b, a)
    local color = GridStatusAggro.db.profile.alert_aggro.threatcolors[status]
    color.r = r
    color.g = g
    color.b = b
    color.a = a or 1
end

local aggroDynamicOptions = {
    [1] = {
        type = "color",
        name = L["High Threat color"],
        desc = L["Color for High Threat."],
        order = 87, width = "double",
        hasAlpha = true,
        get = function() return getstatuscolor(1) end,
        set = function(_, r, g, b, a) setstatuscolor(1, r, g, b, a) end,
    },
    [2] = {
        type = "color",
        name = L["Aggro color"],
        desc = L["Color for Aggro."],
        order = 88, width = "double",
        hasAlpha = true,
        get = function() return getstatuscolor(2) end,
        set = function(_, r, g, b, a) setstatuscolor(2, r, g, b, a) end,
    },
    [3] = {
        type = "color",
        name = L["Tanking color"],
        desc = L["Color for Tanking."],
        order = 89, width = "double",
        hasAlpha = true,
        get = function() return getstatuscolor(3) end,
        set = function(_, r, g, b, a) setstatuscolor(3, r, g, b, a) end,
    },
}

local function setupmenu()
	local args = GridStatus.options.args["alert_aggro"].args
	local threat = GridStatusAggro.db.profile.alert_aggro.threat

	if not aggroDynamicOptions.aggroColor then
		aggroDynamicOptions.aggroColor = args.color
	end

	if threat then
        args.color = nil
        args["1"] = aggroDynamicOptions[1]
        args["2"] = aggroDynamicOptions[2]
        args["3"] = aggroDynamicOptions[3]
    else
        args.color = aggroDynamicOptions.aggroColor
        args["1"] = nil
        args["2"] = nil
        args["3"] = nil
    end
end

--{{{ additional options
local aggroOptions = {
    ["threat"] = {
        type = "toggle",
        name = L["Threat"],
        desc = L["Show more detailed threat levels."],
        get = function() return GridStatusAggro.db.profile.alert_aggro.threat end,
        set = function()
            GridStatusAggro.db.profile.alert_aggro.threat = not GridStatusAggro.db.profile.alert_aggro.threat
            GridStatusAggro.UpdateAllUnits(GridStatusAggro)
            setupmenu()
        end,
    },
}
--}}}

function GridStatusAggro:PostInitialize()
	self:RegisterStatus("alert_aggro", L["Aggro alert"], aggroOptions, true)
	setupmenu()
end

function GridStatusAggro:OnStatusEnable(status)
	if status == "alert_aggro" then
		self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", "UpdateUnit")
		self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateAllUnits")
		self:UpdateAllUnits()
	end
end

function GridStatusAggro:OnStatusDisable(status)
	if status == "alert_aggro" then
		self:UnregisterEvent("UNIT_THREAT_SITUATION_UPDATE")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self.core:SendStatusLostAllUnits("alert_aggro")
	end
end

function GridStatusAggro:PostReset()
	self:UpdateAllUnits()
	setupmenu()
end

function GridStatusAggro:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit("UpdateAllUnits", unitid)
	end
end

do
	local UnitGUID = UnitGUID
	local UnitThreatSituation = UnitThreatSituation

	function GridStatusAggro:UpdateUnit(event, unitid)
		if not unitid then
			-- because sometimes the unitid can be nil... wtf?
			return
		end

		local guid = UnitGUID(unitid)
		local status = UnitThreatSituation(unitid)

		local settings = self.db.profile.alert_aggro
		local threat = settings.threat

		if status and ((threat and (status > 0)) or (status > 1)) then
			GridStatusAggro.core:SendStatusGained(guid, "alert_aggro",
				settings.priority,
				settings.range,
				(threat and settings.threatcolors[status] or settings.color),
				(threat and settings.threattexts[status] or settings.text),
				nil,
				nil,
				settings.icon)
		else
			GridStatusAggro.core:SendStatusLost(guid, "alert_aggro")
		end
	end
end
