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
	GridStatusRange.lua
	GridStatus module for tracking unit range.
	Created by neXter, modified by Pastamancer, modified by Phanx.
----------------------------------------------------------------------]]

local _, Grid = ...
local L = Grid.L

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusRange = Grid:NewStatusModule("GridStatusRange", "AceTimer-3.0")
GridStatusRange.menuName = L["Out of Range"]

GridStatusRange.defaultDB = {
	alert_range = {
		enable = true,
		text = L["Range"],
		color = { r = 0.8, g = 0.2, b = 0.2, a = 0.5 },
		priority = 80,
		range = false,
		frequency = 0.2,
	}
}

local extraOptions = {
	frequency = {
		name = L["Range check frequency"],
		desc = L["Seconds between range checks"],
		order = -1,
		width = "double",
		type = "range", min = 0.1, max = 5, step = 0.1,
		get = function()
			return GridStatusRange.db.profile.alert_range.frequency
		end,
		set = function(_, v)
			GridStatusRange.db.profile.alert_range.frequency = v
			GridStatusRange:OnStatusDisable("alert_range")
			GridStatusRange:OnStatusEnable("alert_range")
		end,
	},
	text = {
		name = L["Text"],
		desc = L["Text to display on text indicators"],
		order = 113,
		type = "input",
		get = function()
			return GridStatusRange.db.profile.alert_range.text
		end,
		set = function(_, v)
			GridStatusRange.db.profile.alert_range.text = v
		end,
	},
	range = false,
}

function GridStatusRange:PostInitialize()
	self:RegisterStatus("alert_range", L["Out of Range"], extraOptions, true)
end

function GridStatusRange:OnStatusEnable(status)
	self:StartTimer("CheckRange", self.db.profile.alert_range.frequency, true)
end

function GridStatusRange:OnStatusDisable(status)
	self:StopTimer("CheckRange")
	self.core:SendStatusLostAllUnits("alert_range")
end

local resSpell
do
	local _, class = UnitClass("player")
	if class == "DEATHKNIGHT" then
		resSpell = GetSpellInfo(61999)  -- Raise Ally
	elseif class == "DRUID" then
		resSpell = GetSpellInfo(50769)  -- Revive
	elseif class == "MONK" then
		resSpell = GetSpellInfo(115178) -- Resuscitate
	elseif class == "PALADIN" then
		resSpell = GetSpellInfo(7328)   -- Redemption
	elseif class == "PRIEST" then
		resSpell = GetSpellInfo(2006)   -- Resurrection
	elseif class == "SHAMAN" then
		resSpell = GetSpellInfo(2008)   -- Ancestral Spirit
	elseif class == "WARLOCK" then
		resSpell = GetSpellInfo(20707)  -- Soulstone
	end
end

local IsSpellInRange, UnitInRange, UnitIsUnit = IsSpellInRange, UnitInRange, UnitIsUnit

function GridStatusRange:UnitInRange(unit)
	if UnitIsUnit(unit, "player") then
		return true
	elseif resSpell and UnitIsDead(unit) and not UnitIsDead("player") then
		return IsSpellInRange(resSpell, unit) == 1
	else
		return UnitInRange(unit)
	end
end

function GridStatusRange:CheckRange()
	local settings = self.db.profile.alert_range
	for guid, unit in GridRoster:IterateRoster() do
		if self:UnitInRange(unit) then
			self.core:SendStatusLost(guid, "alert_range")
		else
			self.core:SendStatusGained(guid, "alert_range",
				settings.priority,
				false,
				settings.color,
				settings.text)
		end
	end
end