local MAJOR_VERSION = "LibDogTag-Stats-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Revision: 17 $"):match("%d+")) or 0

if MINOR_VERSION > _G.DogTag_Stats_MINOR_VERSION then
	_G.DogTag_Stats_MINOR_VERSION = MINOR_VERSION
end

DogTag_Stats_funcs[#DogTag_Stats_funcs+1] = function(DogTag_Stats, DogTag)

local L = DogTag_Stats.L


DogTag:AddTag("Stats", "SpellDamage", {
	code = function(school)
		if not school then
			return min(
				GetSpellBonusDamage(2),
				GetSpellBonusDamage(3),
				GetSpellBonusDamage(4),
				GetSpellBonusDamage(5),
				GetSpellBonusDamage(6),
				GetSpellBonusDamage(7)
			)
		else
			return GetSpellBonusDamage(school)
		end
	end,
	arg = {
		'school', 'number;undef', "@undef",
	},
	ret = "number",
	events = "PLAYER_DAMAGE_DONE_MODS;SPELL_POWER_CHANGED",
	doc = L["Returns your bonus spell damage amount. School can be blank/nil for the lowest of all schools, 2 for Holy, 3 for Fire, 4 for Nature, 5 for Frost, 6 for Shadow, or 7 for Arcane."],
	example = '[SpellDamage] => "8476"',
	category = L["Spell"],
})
DogTag:AddTag("Stats", "SpellHealing", {
	code = GetSpellBonusHealing,
	ret = "number",
	events = "PLAYER_DAMAGE_DONE_MODS;SPELL_POWER_CHANGED",
	doc = L["Returns your bonus spell healing amount."],
	example = '[SpellHealing] => "8476"',
	category = L["Spell"],
})
DogTag:AddTag("Stats", "SpellCrit", {
	code = function(school)
		if not school then
			return min(
				GetSpellCritChance(2),
				GetSpellCritChance(3),
				GetSpellCritChance(4),
				GetSpellCritChance(5),
				GetSpellCritChance(6),
				GetSpellCritChance(7)
			)
		else
			return GetSpellCritChance(school)
		end
	end,
	arg = {
		'school', 'number;undef', "@undef",
	},
	ret = "number",
	events = "PLAYER_DAMAGE_DONE_MODS;COMBAT_RATING_UPDATE",
	doc = L["Returns your spell crit chance. School can be blank/nil for the lowest of all schools, 2 for Holy, 3 for Fire, 4 for Nature, 5 for Frost, 6 for Shadow, or 7 for Arcane."],
	example = '[SpellCrit:Round(1)] => "41.8"; [SpellCrit:Round(1):Percent] => "41.8%"',
	category = L["Spell"],
})

DogTag:AddTag("Stats", "SpellHaste", {
	code = function()
		return UnitSpellHaste("player")
	end,
	ret = "number",
	events = "COMBAT_RATING_UPDATE;UNIT_SPELL_HASTE#player",
	doc = L["Returns your spell haste percentage."],
	example = '[SpellHaste:Round(1)] => "28.1"; [SpellHaste:Round(1):Percent] => "28.1%"',
	category = L["Spell"],
})

DogTag:AddTag("Stats", "SpellHit", {
	code = function()
		return GetCombatRatingBonus(CR_HIT_SPELL) + GetSpellHitModifier()
	end,
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your spell hit percentage increase."],
	example = '[SpellHit:Round(1)] => "14.1"; [SpellHit:Round(1):Percent] => "14.1%"',
	category = L["Spell"],
})

DogTag:AddTag("Stats", "SpellMissChance", {
	code = function(leveloffset)
		if (leveloffset < 0 or leveloffset > 3) then
			DogTag.tagError("[SpellMissChance]", "Stats", "leveloffset must be between 0 and 3, inclusive (got " .. leveloffset .. ").")
		end

		return GetSpellMissChance(leveloffset)
	end,
	arg = {
		'leveloffset', 'number;undef', 0
	},
	ret = "number",
	events = "COMBAT_RATING_UPDATE",
	doc = L["Returns your spell miss chance against an enemy of the specified number of levels higher than you (max level difference is 3)"],
	example = '[SpellMissChance:Round(1)] => "5"; [SpellMissChance(3):Round(1):Percent] => "15%"',
	category = L["Spell"],
})


end