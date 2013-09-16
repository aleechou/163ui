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
	GridStatusReadyCheck.lua
	GridStatus module for reporting ready check responses.
----------------------------------------------------------------------]]

local _, Grid = ...
local L = Grid.L

local GridRoster = Grid:GetModule("GridRoster")

local GridStatusReadyCheck = Grid:NewStatusModule("GridStatusReadyCheck", "AceTimer-3.0")
GridStatusReadyCheck.menuName = L["Ready Check"]

GridStatusReadyCheck.defaultDB = {
	ready_check = {
		text = L["Ready Check"],
		enable = true,
		color = { r = 1, g = 1, b = 1, a = 1 },
		priority = 95,
		delay = 5,
		range = false,
		colors = {
			waiting = { r = 1, g = 1, b = 0, a = 1, ignore = true },
			ready = { r = 0, g = 1, b = 0, a = 1, ignore = true },
			notready = { r = 1, g = 0, b = 0, a = 1, ignore = true },
			afk = { r = 1, g = 0, b = 0, a = 1, ignore = true }
		},
	},
}

GridStatusReadyCheck.options = false

local readystatus = {
	waiting = {
		text = L["?"],
		icon = READY_CHECK_WAITING_TEXTURE
	},
	ready = {
		text = L["R"],
		icon = READY_CHECK_READY_TEXTURE
	},
	notready = {
		text = L["X"],
		icon = READY_CHECK_NOT_READY_TEXTURE
	},
	afk = {
		text = L["AFK"],
		icon = READY_CHECK_AFK_TEXTURE
	},
}

local function getstatuscolor(key)
	local color = GridStatusReadyCheck.db.profile.ready_check.colors[key]
	return color.r, color.g, color.b, color.a
end

local function setstatuscolor(key, r, g, b, a)
	local color = GridStatusReadyCheck.db.profile.ready_check.colors[key]
	color.r = r
	color.g = g
	color.b = b
	color.a = a or 1
	color.ignore = true
end

local readyCheckOptions = {
	["waiting"] = {
		name = L["Waiting color"],
		desc = L["Color for Waiting."],
		order = 86, width = "double",
		type = "color",
		hasAlpha = true,
		get = function() return getstatuscolor("waiting") end,
		set = function(_, r, g, b, a) setstatuscolor("waiting", r, g, b, a) end,
	},
	["ready"] = {
		name = L["Ready color"],
		desc = L["Color for Ready."],
		order = 87, width = "double",
		type = "color",
		hasAlpha = true,
		get = function() return getstatuscolor("ready") end,
		set = function(_, r, g, b, a) setstatuscolor("ready", r, g, b, a) end,
	},
	["notready"] = {
		name = L["Not Ready color"],
		desc = L["Color for Not Ready."],
		order = 88, width = "double",
		type = "color",
		hasAlpha = true,
		get = function() return getstatuscolor("notready") end,
		set = function(_, r, g, b, a) setstatuscolor("notready", r, g, b, a) end,
	},
	["afk"] = {
		name = L["AFK color"],
		desc = L["Color for AFK."],
		order = 89, width = "double",
		type = "color",
		hasAlpha = true,
		get = function() return getstatuscolor("afk") end,
		set = function(_, r, g, b, a) setstatuscolor("afk", r, g, b, a) end,
	},
	["delay"] = {
		name = L["Delay"],
		desc = L["Set the delay until ready check results are cleared."],
		width = "double",
		type = "range", min = 0, max = 10, step = 1,
		get = function()
			return GridStatusReadyCheck.db.profile.ready_check.delay
		end,
		set = function(_, v)
			GridStatusReadyCheck.db.profile.ready_check.delay = v
		end,
	},
	["color"] = false,
	["range"] = false,
}

function GridStatusReadyCheck:PostInitialize()
	self:RegisterStatus("ready_check", L["Ready Check"], readyCheckOptions, true)
end

function GridStatusReadyCheck:OnStatusEnable(status)
	if status ~= "ready_check" then return end

	self:RegisterEvent("READY_CHECK")
	self:RegisterEvent("READY_CHECK_CONFIRM")
	self:RegisterEvent("READY_CHECK_FINISHED")
	self:RegisterEvent("PARTY_LEADER_CHANGED", "GroupChanged")
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "GroupChanged")
	self:RegisterMessage("Grid_PartyTransition", "GroupChanged")
	self:RegisterMessage("Grid_UnitJoined")
end

function GridStatusReadyCheck:OnStatusDisable(status)
	if status ~= "ready_check" then return end

	self:UnregisterEvent("READY_CHECK")
	self:UnregisterEvent("READY_CHECK_CONFIRM")
	self:UnregisterEvent("READY_CHECK_FINISHED")
	self:UnregisterEvent("PARTY_LEADER_CHANGED")
	self:UnregisterEvent("GROUP_ROSTER_UPDATE")
	self:UnregisterMessage("Grid_PartyTransition")
	self:UnregisterMessage("Grid_UnitJoined")

	self:StopTimer("ClearStatus")
	self.core:SendStatusLostAllUnits("ready_check")
end

function GridStatusReadyCheck:PostReset()
	self:StopTimer("ClearStatus")
	self.core:SendStatusLostAllUnits("ready_check")
end

function GridStatusReadyCheck:GainStatus(guid, key, settings)
	local status = readystatus[key]
	self.core:SendStatusGained(guid, "ready_check",
		settings.priority,
		nil,
		settings.colors[key],
		status.text,
		nil,
		nil,
		status.icon)
end

function GridStatusReadyCheck:UpdateAllUnits()
	if GetReadyCheckStatus("player") then
		for guid, unitid in GridRoster:IterateRoster() do
			self:UpdateUnit(unitid)
		end
	else
		self:StopTimer("ClearStatus")
		self.core:SendStatusLostAllUnits("ready_check")
	end
end

function GridStatusReadyCheck:UpdateUnit(unitid)
	local guid = UnitGUID(unitid)
	local key = GetReadyCheckStatus(unitid)
	if key then
		local settings = self.db.profile.ready_check
		self:GainStatus(guid, key, settings)
	else
		self.core:SendStatusLost(guid, "ready_check")
	end
end

function GridStatusReadyCheck:READY_CHECK()
	if self.db.profile.ready_check.enable then
		self:StopTimer("ClearStatus")
		self:UpdateAllUnits()
	end
end

function GridStatusReadyCheck:READY_CHECK_CONFIRM(event, unitid)
	if unitid and self.db.profile.ready_check.enable then
		self:UpdateUnit(unitid)
	end
end

function GridStatusReadyCheck:READY_CHECK_FINISHED()
	local settings = self.db.profile.ready_check
	if settings.enable then
		local afk = {}
		for guid, status, statusTbl in self.core:CachedStatusIterator("ready_check") do
			if statusTbl.texture == READY_CHECK_WAITING_TEXTURE then
				afk[guid] = true
			end
		end
		for guid in pairs(afk) do
			self:GainStatus(guid, "afk", settings)
		end
		self:StartTimer("ClearStatus", settings.delay or 0)
	end
end

function GridStatusReadyCheck:GroupChanged()
	if self.db.profile.ready_check.enable then
		self:UpdateAllUnits()
	end
end

function GridStatusReadyCheck:Grid_UnitJoined(event, guid, unitid)
	if unitid and self.db.profile.ready_check.enable then
		self:UpdateUnit(unitid)
	end
end

function GridStatusReadyCheck:ClearStatus()
	self.core:SendStatusLostAllUnits("ready_check")
end