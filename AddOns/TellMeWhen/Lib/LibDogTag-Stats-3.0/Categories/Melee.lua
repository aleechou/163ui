local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 12 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)

local L = DogTag_Stats.L


DogTag:AddTag("Stats", "MeleeAP", {
	code = function()
		local base, pos, neg = UnitAttackPower("player")
		return base + pos + neg
	end,
	ret = "number",
	events = "UNIT_ATTACK_POWER#player",
	doc = L["Returns your melee Attack Power"],
	example = '[MeleeAP] => "21345"',
	category = L["Melee"],
})

DogTag:AddTag("Stats", "MeleeCrit", {
	code = GetCritChance,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your melee crit chance"],
	example = '[MeleeCrit:Round(1)] => "23.4"; [MeleeCrit:Round(1):Percent] => "23.4%"',
	category = L["Melee"],
})

DogTag:AddTag("Stats", "MeleeHaste", {
	code = GetMeleeHaste,
	ret = "number",
	events = "UNIT_ATTACK_SPEED#player",
	doc = L["Returns your melee haste percentage"],
	example = '[MeleeHaste:Round(1)] => "32.7"; [MeleeHaste:Round(1):Percent] => "32.7%"',
	category = L["Melee"],
})

DogTag:AddTag("Stats", "MeleeExpertise", {
	code = GetExpertise,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your melee expertise"],
	example = '[MeleeExpertise] => "5.25"',
	category = L["Melee"],
})

DogTag:AddTag("Stats", "MeleeHit", {
	code = function()
		return GetCombatRatingBonus(CR_HIT_MELEE) + GetHitModifier()
	end,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your melee hit percentage increase."],
	example = '[MeleeHit:Round(1)] => "8.1"; [MeleeHit:Round(1):Percent] => "8.1%"',
	category = L["Melee"],
})

DogTag:AddTag("Stats", "MeleeNormalMissChance", {
	code = function(leveloffset)
		if (leveloffset < 0 or leveloffset > 3) then
			DogTag.tagError("[MeleeNormalMissChance]", "Stats", "leveloffset must be between 0 and 3, inclusive (got " .. leveloffset .. ").")
		end

		return GetMeleeMissChance(leveloffset, false)
	end,
	arg = {
		'leveloffset', 'number;undef', 0
	},
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your normal attack (white hit) miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"],
	example = '[MeleeNormalMissChance:Round(1)] => "22"; [MeleeNormalMissChance(3):Round(1):Percent] => "26.5%"',
	category = L["Melee"],
})

DogTag:AddTag("Stats", "MeleeSpecialMissChance", {
	code = function(leveloffset)
		if (leveloffset < 0 or leveloffset > 3) then
			DogTag.tagError("[MeleeSpecialMissChance]", "Stats", "leveloffset must be between 0 and 3, inclusive (got " .. leveloffset .. ").")
		end

		return GetMeleeMissChance(leveloffset, true)
	end,
	arg = {
		'leveloffset', 'number;undef', 0
	},
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your special attack (yellow hit) miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"],
	example = '[MeleeSpecialMissChance:Round(1)] => "3"; [MeleeSpecialMissChance(3):Round(1):Percent] => "7.5%"',
	category = L["Melee"],
})


end