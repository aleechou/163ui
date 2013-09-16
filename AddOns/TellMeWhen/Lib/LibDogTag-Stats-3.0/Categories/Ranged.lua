local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 12 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)

local L = DogTag_Stats.L


DogTag:AddTag("Stats", "RangedAP", {
	code = function()
		local base, pos, neg = UnitRangedAttackPower("player")
		return base + pos + neg
	end,
	ret = "number",
	events = "UNIT_RANGED_ATTACK_POWER#player",
	doc = L["Returns your ranged attack power"],
	example = '[RangedAP] => "21345"',
	category = L["Ranged"],
})

DogTag:AddTag("Stats", "RangedCrit", {
	code = GetRangedCritChance,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your ranged crit chance"],
	example = '[RangedCrit:Round(1)] => "23.4"; [RangedCrit:Round(1):Percent] => "23.4%"',
	category = L["Ranged"],
})

DogTag:AddTag("Stats", "RangedHaste", {
	code = GetRangedHaste,
	ret = "number",
	events = "UNIT_RANGEDDAMAGE#player",
	doc = L["Returns your ranged haste percentage"],
	example = '[RangedHaste:Round(1)] => "32.7"; [RangedHaste:Round(1):Percent] => "32.7%"',
	category = L["Ranged"],
})

DogTag:AddTag("Stats", "RangedExpertise", {
	code = function()
		return select(3, GetExpertise())
	end,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your ranged expertise"],
	example = '[RangedExpertise] => "5.25"',
	category = L["Ranged"],
})

DogTag:AddTag("Stats", "RangedHit", {
	code = function()
		return GetCombatRatingBonus(CR_HIT_RANGED) + GetHitModifier()
	end,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your ranged hit percentage increase."],
	example = '[RangedHit:Round(1)] => "8.1"; [RangedHit:Round(1):Percent] => "8.1%"',
	category = L["Ranged"],
})

DogTag:AddTag("Stats", "RangedMissChance", {
	code = function(leveloffset)
		if (leveloffset < 0 or leveloffset > 3) then
			DogTag.tagError("[RangedMissChance]", "Stats", "leveloffset must be between 0 and 3, inclusive (got " .. leveloffset .. ").")
		end

		return GetRangedMissChance(leveloffset)
	end,
	arg = {
		'leveloffset', 'number;undef', 0
	},
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your ranged miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"],
	example = '[RangedMissChance:Round(1)] => "3"; [RangedMissChance(3):Round(1):Percent] => "7.5%"',
	category = L["Ranged"],
})


end