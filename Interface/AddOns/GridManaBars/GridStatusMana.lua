local L = GridManaBarsLocale

local GridRoster = Grid:GetModule("GridRoster")
local GridStatus = Grid:GetModule("GridStatus")

GridMBStatus = GridStatus:NewModule("GridMBStatus", "AceTimer-3.0")

GridMBStatus.menuName = "ManaBar"

GridMBStatus.defaultDB = {
	debug = false,
	hiderage = true,
	hidepetbars = true,
	color = { r = 0, g = 0.5, b = 1.0, a = 1.0 },
	ecolor = { r = 1, g = 1, b = 0, a = 1.0 },
	rcolor = { r = 1, g = 0, b = 0, a = 1.0 },
    dcolor = { r = 0, g = 0.8, b = 0.8, a = 1.0 },
    shmcolor = { r=1, g=1, b=1, a=1, },
    replaceshmcolor = false,
	unit_mana = {
		color = { r=1, g=1, b=1, a=1 },
		text = "ManaBar",
		enable = true,
		priority = 30,
		range = false
	}
}

GridMBStatus.options = false

local manabar_options = {

    ["header1"] = {
        order = 2110,
        type = "header",
        name = "",
    },
	["Ignore Non-Mana"] = {
        order = 2120,
		type = "toggle",
		name = L["Ignore Non-Mana"],
		desc = L["Don't track power for non-mana users"],
		get = function()
			return GridMBStatus.db.profile.hiderage
		end,
		set = function(_, v)
			GridMBStatus.db.profile.hiderage = v
            GridMBStatus:UpdateAllUnits()
		end,
	},
	["Ignore Pets"] = {
        order = 2130,
		type = "toggle",
		name = L["Ignore Pets"],
		desc = L["Don't track power for pets"],
		get = function()
			return GridMBStatus.db.profile.hidepetbars
		end,
		set = function(_, v)
			GridMBStatus.db.profile.hidepetbars=v
            GridMBStatus:UpdateAllUnits()
		end,
	},
    ["header2"] = {
        order = 2140,
        type = "header",
        name = "萨满法力条颜色设置",
    },
    ["Replace Shaman ManaBar"] = {
        order = 2150,
        type = "toggle",
        name = "是否改变颜色",
        desc = "改变萨满职业的法力条颜色，以免和血条颜色过于接近",
        get = function()
            return GridMBStatus.db.profile.replaceshmcolor
        end,
        set = function(_, v)
            GridMBStatus.db.profile.replaceshmcolor=v
            GridMBStatus:UpdateAllUnits()
        end,
    },
    ["Shaman Mana Color"] = {
        order = 2160,
        type = "color",
        name = "选择颜色",
        desc = "设置具体萨满法力条的具体颜色",
        get = function()
            local color = GridMBStatus.db.profile.shmcolor
            return color.r, color.g, color.b, color.a
        end,
        set = function(_, r, g, b, a)
            local color = GridMBStatus.db.profile.shmcolor
            color.r = r
            color.g = g
            color.b = b
            color.a = a or 1
        end,
    }
}

local playerName = UnitName("player")
local ignoreUnitsPower = {}

function GridMBStatus:OnInitialize()
	self.super.OnInitialize(self)

	self:RegisterStatus('unit_mana',L["Mana"], manabar_options, true)
	GridStatus.options.args['unit_mana'].args['color'] = nil
end

function GridMBStatus:OnStatusEnable(status)
    if status == "unit_mana" then
        self.timer = self:ScheduleRepeatingTimer("OnUpdate", 1)
        self:RegisterMessage("Grid_UnitLeft")
        self:RegisterMessage("Grid_LeftParty")

        self:RegisterMessage("Grid_UnitJoined")
        self:RegisterEvent("UNIT_DISPLAYPOWER")


        --self:RegisterEvent("UNIT_POWER","UpdateUnit")
        --self:RegisterEvent("UNIT_MAXPOWER","UpdateUnit")
        
        self:UpdateAllUnits()
    end
end

function GridMBStatus:OnUpdate()
    for guid, id in GridRoster:IterateRoster() do
		if ignoreUnitsPower[guid] == false then
			self:UpdateUnitPowerSimple(id, guid)
		end
    end
end

function GridMBStatus:OnStatusDisable(status)
    if status == "unit_mana" then
        self:CancelTimer(self.timer, true);
        ignoreUnitsPower = {}
        for guid, unitid in GridRoster:IterateRoster() do
            self.core:SendStatusLost(guid, "unit_mana")
        end
        
        self:UnregisterMessage("Grid_UnitLeft")
        self:UnregisterMessage("Grid_LeftParty")

        self:UnregisterMessage("Grid_UnitJoined")
        self:UnregisterEvent("UNIT_DISPLAYPOWER")


        --self:UnregisterEvent("UNIT_POWER","UpdateUnit")
        --self:UnregisterEvent("UNIT_MAXPOWER","UpdateUnit")
    end
end

function GridMBStatus:Reset()
	self.super.Reset(self)
	self:UpdateAllUnits()
end

function GridMBStatus:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnitPowerType(unitid, guid)
	end
end

--[[free the leaving units entry in ignoreUnitsPower-table]]
function GridMBStatus:Grid_UnitLeft(_, unitGUID)
	ignoreUnitsPower[unitGUID] = nil
end

--[[wipe own-heals-table clean]]
function GridMBStatus:Grid_LeftParty()
	ignoreUnitsPower = {}
	self:UpdateUnitPowerType("player")
end

function GridMBStatus:Grid_UnitJoined(_, unitGUID, unitid)
    self:UpdateUnitPowerType(unitid, unitGUID)
end

function GridMBStatus:UNIT_DISPLAYPOWER(_, unitid)
    self:UpdateUnitPowerType(unitid)
end

--no use
--[[
function GridMBStatus:UpdateUnit(_, unitid)
    local unitGUID = UnitGUID(unitid)
    --print("UU("..unitid..")")

    if ignoreUnitsPower[unitGUID] == false then
        self:UpdateUnitPower(unitid)
    end
end
--]]

function GridMBStatus:UpdateAllUnits()
    --print("MB:UpdateAllUnits()")
    for guid, id in GridRoster:IterateRoster() do
        self:UpdateUnitPowerType(id, guid)
    end
end


function GridMBStatus:UpdateUnitPowerType(unitid, guid)
    if not unitid then return end

    local unitGUID = guid or UnitGUID(unitid)
    if not unitGUID then return end
    --print("MB:UpdateUnitPowerType("..unitid..")")

	local powerType = UnitPowerType(unitid)

    local ignoreUnit = false

    if GridMBStatus.db.profile.hidepetbars and (not UnitIsPlayer(unitid)) then
        ignoreUnit = true
	elseif GridMBStatus.db.profile.hiderage then
		local powerType = UnitPowerType(unitid)
		ignoreUnit = powerType ~= 0
	end

    ignoreUnitsPower[unitGUID] = ignoreUnit

    if ignoreUnit then
        self.core:SendStatusLost(unitGUID, "unit_mana")
    else
        self:UpdateUnitPowerSimple(unitid, unitGUID)
    end
end

function GridMBStatus:UpdateUnitPowerSimple(unitid, guid)
	if UnitIsDeadOrGhost(unitid) or not UnitIsConnected(unitid) then
		self.core:SendStatusLost(guid, "unit_mana")
		return
	end
	
	local cur, max = UnitPower(unitid), UnitPowerMax(unitid)
	local priority = GridMBStatus.db.profile.unit_mana.priority

	if cur==max then
		priority=1
    end

    local powerType, powerToken = UnitPowerType(unitid)
    local col
    if powerToken=="MANA" and GridMBStatus.db.profile.replaceshmcolor and select(2, UnitClass(unitid))=="SHAMAN" then
        col = GridMBStatus.db.profile.shmcolor
    else
        col = PowerBarColor[powerToken] or PowerBarColor["MANA"]
    end

	self.core:SendStatusGained(
        guid, "unit_mana", 
        priority, 
        nil,
        col,
        nil,
        cur,max,
        nil
    )
end
