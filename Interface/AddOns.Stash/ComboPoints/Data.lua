------------------------------------------------------------
-- Data.lua
--
-- Abin
-- 2011-3-01
------------------------------------------------------------

local MAELSTORM_WEAPON = GetSpellInfo(53817)
local CLASS_DEF = {
	ROGUE = {
		maximum = 5,
		events = { "PLAYER_TARGET_CHANGED", "UNIT_COMBO_POINTS" },
		CalcPoints = function()
			return GetComboPoints("player")
		end,

		CheckEvent = function(event, unit)
			return event == "PLAYER_TARGET_CHANGED" or unit == "player"
		end,
	},

	DRUID = {
		maximum = 5,
		events = { "PLAYER_TARGET_CHANGED", "UNIT_DISPLAYPOWER", "UNIT_COMBO_POINTS" },
		CalcPoints = function()
			return UnitPowerType("player") == 3 and GetComboPoints("player")
		end,

		CheckEvent = function(event, unit)
			return event == "PLAYER_TARGET_CHANGED" or unit == "player"
		end,
	},

	SHAMAN = {
		maximum = 5,
		events = { "UNIT_AURA" },
		CalcPoints = function()
			return select(4, UnitBuff("player", MAELSTORM_WEAPON))
		end,

		CheckEvent = function(event, unit)
			return unit == "player"
		end,
	},

	PALADIN = {
		maximum = 5,
		events = { "UNIT_POWER" },
		CalcPoints = function()
			return UnitPower("player", SPELL_POWER_HOLY_POWER)
		end,

		CheckEvent = function(event, unit, power)
			return unit == "player" and power == "HOLY_POWER"
		end,
	},

	WARLOCK = {
		maximum = 3,
		events = { "UNIT_POWER" },
		CalcPoints = function()
			return UnitPower("player", SPELL_POWER_SOUL_SHARDS)
		end,

		CheckEvent = function(event, unit, power)
			return unit == "player" and power == "SOUL_SHARDS"
		end
	},
}

local classData = CLASS_DEF[select(2, UnitClass("player"))]
if not classData then 
	local _, addon = ...
	function addon:RegisterEvents() end
	function addon:CalcPoints() return 0 end
	return
end

local COLORS = { { r = 0, g = 1, b = 0 }, { r = 0.5, g = 1, b = 0 }, { r = 1, g = 1, b = 0 }, { r = 1, g = 0.5, b = 0 }, { r = 1, g = 0, b = 0 } }
local maximum, events, CalcPoints, CheckEvent = classData.maximum, classData.events, classData.CalcPoints, classData.CheckEvent

local _, addon = ...

function addon:RegisterEvents(frame)
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	local event
	for _, event in ipairs(events) do
		frame:RegisterEvent(event)
	end
end

function addon:CalcPoints()
	local points = CalcPoints() or 0
	local index
	if maximum == 3 then
		index = points * 2 - 1
	else
		index = points
	end
	local color = COLORS[index]
	if color then
		return points, color.r, color.g, color.b
	else
		return 0
	end
end

function addon:CheckEvent(event, ...)
	return event == "PLAYER_ENTERING_WORLD" or CheckEvent(event, ...)
end