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
	GridStatusHeals.lua
	GridStatus module for tracking incoming healing spells.
----------------------------------------------------------------------]]

local _, Grid = ...
local L = Grid.L

local settings

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusHeals = Grid:NewStatusModule("GridStatusHeals")
GridStatusHeals.menuName = L["Heals"]
GridStatusHeals.options = false

GridStatusHeals.defaultDB = {
	alert_heals = {
		enable = true,
		priority = 50,
		range = false,
		color = { r = 0, g = 1, b = 0, a = 1 },
		text = "+%s",
		icon = nil,
		ignore_self = false,
		minimumValue = 0.1,
	},
}

local healsOptions = {
	ignoreSelf = {
		type = "toggle", width = "double",
		name = L["Ignore Self"],
		desc = L["Ignore heals cast by you."],
		get = function()
			return GridStatusHeals.db.profile.alert_heals.ignore_self
		end,
		set = function(_, v)
			GridStatusHeals.db.profile.alert_heals.ignore_self = v
			GridStatusHeals:UpdateAllUnits()
		end,
	},
	minimumValue = {
		width = "double",
		type = "range", min = 0, max = 0.5, step = 0.05, isPercent = true,
		name = L["Minimum Value"],
		desc = L["Only show incoming heals greater than this percent of the unit's maximum health."],
		get = function()
			return GridStatusHeals.db.profile.alert_heals.minimumValue
		end,
		set = function(_, v)
			GridStatusHeals.db.profile.alert_heals.minimumValue = v
		end,
	},
}

function GridStatusHeals:PostInitialize()
	settings = GridStatusHeals.db.profile.alert_heals
	if settings.minimumValue > 0.5 then
		settings.minimumValue = 0.1
	end

	self:RegisterStatus("alert_heals", L["Incoming heals"], healsOptions, true)
end

function GridStatusHeals:OnStatusEnable(status)
	if status == "alert_heals" then
		self:RegisterEvent("UNIT_HEALTH", "UpdateUnit")
		self:RegisterEvent("UNIT_MAXHEALTH", "UpdateUnit")
		self:RegisterEvent("UNIT_HEAL_PREDICTION", "UpdateUnit")
		self:UpdateAllUnits()
	end
end

function GridStatusHeals:OnStatusDisable(status)
	if status == "alert_heals" then
		self:UnregisterEvent("UNIT_HEALTH")
		self:UnregisterEvent("UNIT_MAXHEALTH")
		self:UnregisterEvent("UNIT_HEAL_PREDICTION")
		self.core:SendStatusLostAllUnits("alert_heals")
	end
end

function GridStatusHeals:PostReset()
	settings = GridStatusHeals.db.profile.alert_heals
	self:UpdateAllUnits()
end

function GridStatusHeals:UpdateAllUnits()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UpdateUnit("UpdateAllUnits", unitid)
	end
end

local UnitGetIncomingHeals, UnitGUID, UnitHealth, UnitHealthMax, UnitIsDeadOrGhost = UnitGetIncomingHeals, UnitGUID, UnitHealth, UnitHealthMax, UnitIsDeadOrGhost

function GridStatusHeals:UpdateUnit(event, unitid)
	if not unitid then return end

	local guid = UnitGUID(unitid)
	if not GridRoster:IsGUIDInRaid(guid) then return end

	if not UnitIsDeadOrGhost(unitid) then
		local incoming = UnitGetIncomingHeals(unitid) or 0
		if incoming > 0 and settings.ignore_self then
			incoming = incoming - (UnitGetIncomingHeals(unitid, "player") or 0)
		end
		if incoming > 0 then
			local maxHealth = UnitHealthMax(unitid)
			if (incoming / maxHealth) > (settings.minimumValue or 0) then
				return self:SendIncomingHealsStatus(guid, incoming, UnitHealth(unitid) + incoming, maxHealth)
			end
		end
	end
	self.core:SendStatusLost(guid, "alert_heals")
end

function GridStatusHeals:SendIncomingHealsStatus(guid, incoming, estimatedHealth, maxHealth)
	local incomingText = incoming
	if incoming > 9999 then
		incomingText = format("%.0fk", incoming / 1000)
	elseif incoming > 999 then
		incomingText = format("%.1fk", incoming / 1000)
	end
	self.core:SendStatusGained(guid, "alert_heals",
		settings.priority,
		settings.range,
		settings.color,
		format(settings.text, incomingText),
		estimatedHealth,
		maxHealth,
		settings.icon)
end
