local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 12 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)

local L = DogTag_Stats.L



DogTag:AddTag("Stats", "Strength", {
	code = function()
		return UnitStat("player", 1)
	end,
	ret = "number",
	events = "UNIT_STATS#player",
	doc = L["Returns your Strength"],
	example = '[Strength] => "1234"',
	category = L["Stats"],
})

DogTag:AddTag("Stats", "Agility", {
	code = function()
		return UnitStat("player", 2)
	end,
	ret = "number",
	events = "UNIT_STATS#player",
	doc = L["Returns your Agility"],
	example = '[Agility] => "1234"',
	category = L["Stats"],
})

DogTag:AddTag("Stats", "Stamina", {
	code = function()
		return UnitStat("player", 3)
	end,
	ret = "number",
	events = "UNIT_STATS#player",
	doc = L["Returns your Stamina"],
	example = '[Stamina] => "1234"',
	category = L["Stats"],
})

DogTag:AddTag("Stats", "Intellect", {
	code = function()
		return UnitStat("player", 4)
	end,
	ret = "number",
	events = "UNIT_STATS#player",
	doc = L["Returns your Intellect"],
	example = '[Intellect] => "1234"',
	category = L["Stats"],
})

DogTag:AddTag("Stats", "Spirit", {
	code = function()
		return UnitStat("player", 5)
	end,
	ret = "number",
	events = "UNIT_STATS#player",
	doc = L["Returns your Spirit"],
	example = '[Spirit] => "1234"',
	category = L["Stats"],
})

DogTag:AddTag("Stats", "Mastery", {
	code = GetMasteryEffect,
	ret = "number",
	events = "MASTERY_UPDATE",
	doc = L["Returns your Mastery effect percentage"],
	example = '[Mastery:Round(1)] => "17.2"; [Mastery:Round(1):Percent] => "17.2%"',
	category = L["Stats"],
})


end