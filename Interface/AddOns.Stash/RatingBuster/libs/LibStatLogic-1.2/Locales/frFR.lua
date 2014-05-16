-- frFR localization by Tixu

if GetLocale() ~= 'frFR' then return end

--These constants need to be built outside the table before they can be referenced
local LOCALE_STHOUSAND = ".";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = ","; --Character(s) used for the decimal separator
local patNumber = "%d+["..LOCALE_STHOUSAND.."%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+["..LOCALE_STHOUSAND.."%d]*"..LOCALE_SDECIMAL.."?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.frFR = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "Plaques",
	Mail = "Mailles",
	Leather = "Cuir",
	Cloth = "Tissu",
	
	------------------
	-- Fast Exclude --
	------------------
	-- Note to localizers: This is important for reducing lag on mouse over.
	-- Turn on /sldebug and see if there are any "No Match" strings, any 
	-- unused strings should be added in the "Exclude" table, because an unmatched 
	-- string costs a lot of CPU time, and should be prevented whenever possible.
	-- By looking at the first ExcludeLen letters of a line we can exclude a lot of lines.
	-- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
	-- Instead include them in the NeutralExclude table in the enUS.lua file so other locales can use them too.
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,
		
		--["Disen"] = true, -- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)";
		--["Durat"] = true, -- ITEM_DURATION_DAYS = "Duration: %d |4day:days;";
		["Temps"] = true, -- temps de recharge...
		["<Arti"] = true, -- artisan
		["Uniqu"] = true, -- Unique (20)
		["Nivea"] = true, -- Niveau
		["\nNive"] = true, -- Niveau
		["Class"] = true, -- Classes: xx
		["Races"] = true, -- Races: xx (vendor mounts)
		["Utili"] = true, -- Utiliser:
		["Chanc"] = true, -- Chance de toucher:
		["Requi"] = true, -- Requiert
		["\nRequ"] = true,-- Requiert
		["Néces"] = true,--nécessite plus de gemmes...
		-- Set Bonuses
		["Ensem"] = true,--ensemble
		["(2) E"] = true,
		["(2) E"] = true,
		["(3) E"] = true,
		["(4) E"] = true,
		["(5) E"] = true,
		["(6) E"] = true,
		["(7) E"] = true,
		["(8) E"] = true,
		
		["Seaso"] = true, --e.g. "Season 10"  PvP Season items e.g. Vicious Gladiator's Emblem of Tenacity
	},

	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Mainly used for enchants that doesn't have numbers in the text
	-- http://wow.allakhazam.com/db/enchant.html?slot=0&locale=enUS
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

		--ToDo
		["Huile de sorcier mineure"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["Huile de sorcier inférieure"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["Huile de sorcier"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["Huile de sorcier brillante"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["Huile de sorcier excellente"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --
		["Huile de sorcier bénite"] = {["SPELL_DMG_UNDEAD"] = 60}, --

		["Huile de mana mineure"] = {["COMBAT_MANA_REGEN"] = 4}, --
		["Huile de mana inférieure"] = {["COMBAT_MANA_REGEN"] = 8}, --
		["Huile de mana brillante"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, --
		["Huile de mana excellente"] = {["COMBAT_MANA_REGEN"] = 14}, --

		["Eternium Line"] = {["FISHING"] = 5}, --
		["Feu solaire"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --
		["Augmentation mineure de la vitesse de la monture"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["Pied sûr"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["Equip: Allows underwater breathing."] = false, -- [Band of Icy Depths] ID: 21526
		["Allows underwater breathing"] = false, --
		["Equip: Immune to Disarm."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immune to Disarm"] = false, --
		["Lifestealing"] = false, -- Enchant Crusader

		--translated
		["Eperons en mithril"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["Équipé\194\160: La vitesse de course augmente légèrement."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["La vitesse de course augmente légèrement"] = {["RUN_SPEED"] = 8}, --
		["Augmentation mineure de vitesse"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
		["Vitalité"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, -- Enchant Boots - Vitality "Vitality" http://wow.allakhazam.com/db/spell.html?wspell=27948
		["Âme de givre"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["Sauvagerie"] = {["AP"] = 70}, --
		["Vitesse mineure"] = {["RUN_SPEED"] = 8},
		["Vitesse mineure et +9 en Endurance"] = {["RUN_SPEED"] = 8, ["STA"] = 9},--enchant

		["Croisé"] = false, -- Enchant Crusader
		["Mangouste"] = false, -- Enchant Mangouste
		["Arme impie"] = false,
		["Équipé : Evite à son porteur d'être entièrement englobé dans la Flamme d'ombre."] = false, --cape Onyxia

		["Vitalité rohart"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["Sagesse"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["Précision"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["Plaie-du-Fléau"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["Marcheglace"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["Récolteur"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["Vitalité supérieure"] = {["COMBAT_MANA_REGEN"] = 6, ["COMBAT_HEALTH_REGEN"] = 6}, -- EnchantID: 3244
	},

	----------------------------
	-- Single Plus Stat Check --
	----------------------------
	-- depending on locale, it may be
	-- +19 Stamina = "^%+(patNumber) (.-)%.?$"
	-- Stamina +19 = "^(.-) %+(patNumber)%.?$"
	-- +19 耐力 = "^%+(patNumber) (.-)%.?$"
	-- Some have a "." at the end of string like:
	-- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
	--["SinglePlusStatCheck"] = "^([%+%-]"..patNumber..") (.-)%.?$",
	["SinglePlusStatCheck"] = "^([%+%-]"..patNumber..") a?u? ?(.-)%.?$",
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
	--["SingleEquipStatCheck"] = "^Équipé\194\160: Augmente (.-) ?de (%d+) ?a?u? ?m?a?x?i?m?u?m? ?(.-)%.?.-$",
	["SingleEquipStatCheck"] = "^"..ITEM_SPELL_TRIGGER_ONEQUIP.." (.-)Augmente ?de (%d+) (.-) ?%.?$",
	-------------
	-- PreScan --
	-------------
	-- Its preferable to have as few "PreScanPatterns" as possible, only use this table if all other methods fail.
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		["^Augmente la puissance d'attaque de (%d+) seulement en forme de félin, ours, ours redoutable ou sélénien%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		["Armure.- (%d+)"] = "ARMOR",
		["^Équipé\194\160: Rend (%d+) points de vie toutes les 5 seco?n?d?e?s?%.?$"]= "COMBAT_HEALTH_REGEN",
		["^Équipé\194\160: Rend (%d+) points de mana toutes les 5 seco?n?d?e?s?%.?$"]= "COMBAT_MANA_REGEN",
		["Renforcé %(%+(%d+) Armure%)"]= "ARMOR_BONUS",
		["Lunette %(%+(%d+) points? de dégâts?%)"]="RANGED_AP",
		["^%(("..patDecimal..") dégâts par seconde%)$"] = "DPS",
	
			-- Exclude
		["^.- %(%d+/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		--["Confère une chance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128
		["Rend parfois"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["Vous gagnez une"] = false, -- condensateur de foudre
		["Dégâts ?:"] = false, -- ligne de degats des armes
		["Dégâts\194\160:"] = false, -- ligne de degats des armes
		["Votre technique"] = false,
		["^%+?%d+ %- %d+ points de dégâts %(.-%)$"]= false, -- ligne de degats des baguettes/ +degats (Thunderfury)
		["Permettent au porteur"] = false, -- Casques Ombrelunes
		["^.- %(%d+%) requis"] = false, --metier requis pour porter ou utiliser
		["^.- ?[Vv]?o?u?s? [Cc]onfèren?t? .-"] = false, --proc
		["^.- ?l?e?s? ?[Cc]hances .-"] = false, --proc
		["^.- par votre sort .-"] = false, --augmentation de capacité de sort
		["^.- la portée de .-"] = false, --augmentation de capacité de sort
		["^.- la durée de .-"] = false, --augmentation de capacité de sort
	},

	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Équipé\194\160: ", --\194\160= espace insécable
	["Socket Bonus: "] = "Bonus de sertissage\194\160: ",
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
	},
	["DeepScanWordSeparators"] = {
		" et ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["les soins %+(%d+) et les dégâts %+ (%d+)$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["les soins %+(%d+) les dégâts %+ (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
		["soins prodigués d'un maximum de (%d+) et les dégâts d'un maximum de (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
    "^(.-) ?([%+%-]%d+) ?(.-)%.?$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
    "^(.-) ?([%d%,]+)( ?.-)%.?$", -- 22.22 xxx xxx (scan last)
    "^.-: (.-)([%+%-]%d+) ?(.-)%.?$", --Bonus de sertissage : +3 xxx
    "^(.-) augmentée?s? de (%d+) ?(.-)%%?%.?$",--sometimes this pattern is needed but not often
	},
	
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	-- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
	-- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
	["StatIDLookup"] = {
		["Score de critique"] = {"MELEE_CRIT_RATING", "RANGED_CRIT_RATING", "SPELL_CRIT_RATING"}, -- need for wierd reason. (need to investigate)
	},
} -- }}}

function PatternLocale.frFR.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		newKey = gsub(newKey, "Augmente de ?", "") 
			
		--print("'"..k.."'------>'"..newKey.."'")
		targetStatIDLookup[newKey] = v
		
		--autogenerate few known and useful string
		if string.find(newKey, "^l’") then
			newKey = "à ".. newKey;
			targetStatIDLookup[newKey] = v;
		end
		if string.find(newKey, "^la") then
			newKey = "à ".. newKey;
			targetStatIDLookup[newKey] = v;
		end		
	end
end

DisplayLocale.frFR = { -- {{{
  --ToDo
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
	["Stat Multiplier"] = "Stat Multiplier",
	["Attack Power Multiplier"] = "Attack Power Multiplier",
	["Reduced Physical Damage Taken"] = "Reduced Physical Damage Taken",
	["10% Melee/Ranged Attack Speed"] = "10% Melee/Ranged Attack Speed",
	["5% Spell Haste"] = "5% Spell Haste",
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["IGNORE_ARMOR"] = {"Ignore Armor", "Ignore Armor"},
		["STEALTH_LEVEL"] = {"Stealth Level", "Stealth"},
		["MELEE_DMG"] = {"Melee Weapon "..DAMAGE, "Wpn Dmg"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Mount Speed(%)", "Mount Spd(%)"},
		["RUN_SPEED"] = {"Run Speed(%)", "Run Spd(%)"},

		["STR"] = {SPELL_STAT1_NAME, "For"},
		["AGI"] = {SPELL_STAT2_NAME, "Agi"},
		["STA"] = {SPELL_STAT3_NAME, "End"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Esp"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {ARMOR.." from bonus", ARMOR.."(Bonus)"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "RF"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "RN"},
		["FROST_RES"] = {RESISTANCE4_NAME, "RG"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "RO"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "RA"},

		["FISHING"] = {"Pêche", "Pêche"},
		["MINING"] = {"Minage", "Minage"},
		["HERBALISM"] = {"Herboristerie", "Herboristerie"},
		["SKINNING"] = {"Dépeçage", "Dépeçage"},

		["BLOCK_VALUE"] = {"Valeur de blocage", "Valeur de blocage"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "PA"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "PAD"},
		["FERAL_AP"] = {ATTACK_POWER_TOOLTIP.." combat farouche", "PA C. Farouche"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (mort-vivant)", "PA(démon)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (démon)", "PA(démon)"},

		["HEAL"] = {"Soins", "Soin"},

		["SPELL_POWER"] = {STAT_SPELLPOWER, STAT_SPELLPOWER},
		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Dmg"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (mort-vivant)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(démon)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (démon)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(démon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Dmg"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Dmg"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Dmg"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Dmg"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Dmg"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.." Dmg"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REGEN"] = {"Regen vie (hors combat)", "HP5(HC)"},
		["MANA_REGEN"] = {"Regen mana (hors cast)", "MP5(HC)"},
		["COMBAT_HEALTH_REGEN"] = {"Regen "..HEALTH, "HP5"},
		["COMBAT_MANA_REGEN"] = {"Regen "..MANA, "MP5"},

		["MAX_DAMAGE"] = {"Dégât max", "Dmg max"},
		["DPS"] = {"Dégâts par seconde", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"Hit Avoidance "..RATING, "Hit Avoidance "..RATING},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance "..RATING},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance "..RATING},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {COMBAT_RATING_NAME9.." "..PLAYERSTAT_RANGED_COMBAT, COMBAT_RATING_NAME9.." "..PLAYERSTAT_RANGED_COMBAT},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Crit Avoidance "..RATING, "Crit Avoidance "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Hâte "..RATING, "Hâte "..RATING}, --
		["RANGED_HASTE_RATING"] = {"Hâte "..PLAYERSTAT_RANGED_COMBAT..RATING, "Hâte "..PLAYERSTAT_RANGED_COMBAT..RATING},
		["SPELL_HASTE_RATING"] = {"Hâte "..PLAYERSTAT_SPELL_COMBAT..RATING, "Hâte "..PLAYERSTAT_SPELL_COMBAT..RATING},
		["DAGGER_WEAPON_RATING"] = {"Dague "..SKILL.." "..RATING, "Dague "..RATING}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"Epée "..SKILL.." "..RATING, "Epée "..RATING},
		["2H_SWORD_WEAPON_RATING"] = {"Two-Handed Sword "..SKILL.." "..RATING, "2H Sword "..RATING},
		["AXE_WEAPON_RATING"] = {"Hache "..SKILL.." "..RATING, "Hache "..RATING},
		["2H_AXE_WEAPON_RATING"] = {"Two-Handed Axe "..SKILL.." "..RATING, "2H Axe "..RATING},
		["MACE_WEAPON_RATING"] = {"Masse "..SKILL.." "..RATING, "Masse "..RATING},
		["2H_MACE_WEAPON_RATING"] = {"Two-Handed Mace "..SKILL.." "..RATING, "2H Mace "..RATING},
		["GUN_WEAPON_RATING"] = {"Arme à feu "..SKILL.." "..RATING, "Arme à feu "..RATING},
		["CROSSBOW_WEAPON_RATING"] = {"Arbalète "..SKILL.." "..RATING, "Arbalète "..RATING},
		["BOW_WEAPON_RATING"] = {"Arc "..SKILL.." "..RATING, "Arc "..RATING},
		["FERAL_WEAPON_RATING"] = {"Farouche "..SKILL.." "..RATING, "Farouche "..RATING},
		["FIST_WEAPON_RATING"] = {"Main nue "..SKILL.." "..RATING, "Main nue "..RATING},
		["EXPERTISE_RATING"] = {"Expertise".." "..RATING, "Expertise".." "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"Pénétration d'armure".." "..RATING, "ArP".." "..RATING},
		["MASTERY_RATING"] = {RATING .. " de maîtrise", RATING .. " de maîtrise"},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["MELEE_CRIT_DMG_REDUCTION"] = {"Réduction des dégâts critiques(%)", "Réduc dmg crit(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {"Réduction des dégâts à distance critiques(%)", "Réduc dmg crit disc(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {"Réduction des dégâts des sorts critiques(%)", "Réduc dmg crit sorts(%)"},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["MELEE_HIT"] = {"Toucher(%)", "Toucher(%)"},
		["RANGED_HIT"] = {"Toucher à distance(%)", "Toucher à distance (%)"},
		["SPELL_HIT"] = {"Toucher des sorts(%)", "Toucher des sorts (%)"},
		["MELEE_HIT_AVOID"] = {"Evitement(%)", "Evt(%)"},
		["RANGED_HIT_AVOID"] = {"Evitement à distance(%)", "Evt dist(%)"},
		["SPELL_HIT_AVOID"] = {"Evitement des sorts(%)", "Evt sorts(%)"},
		["MELEE_CRIT"] = {"Critique(%)", "Crit(%)"},
		["RANGED_CRIT"] = {"Critique à distance(%)", "Crit dist(%)"},
		["SPELL_CRIT"] = {"Critique des sorts(%)", "Crit sorts(%)"},
		["MELEE_CRIT_AVOID"] = {"Evitement des critiques(%)", "Evt crit(%)"},
		["RANGED_CRIT_AVOID"] = {"Evitement des critiques à distance(%)", "Evt crit dist(%)"},
		["SPELL_CRIT_AVOID"] = {"Evitement des critiques des sorts(%)", "Evt crit sorts(%)"},
		["MELEE_HASTE"] = {"Hâte(%)", "Hâte(%)"},
		["RANGED_HASTE"] = {"Hâte à distance(%)", "Hâte dist(%)"},
		["SPELL_HASTE"] = {"Hâte des sorts(%)", "Hâte sorts(%)"},
		["DAGGER_WEAPON"] = {"Compétence de dague", "Dague"},
		["SWORD_WEAPON"] = {"Compétence de d'épée", "Epée"},
		["2H_SWORD_WEAPON"] = {"Compétence d'épée à deux mains", "Epée 2M"},
		["AXE_WEAPON"] = {"Compétence de hache", "Hache"},
		["2H_AXE_WEAPON"] = {"Compétence de hache à deux mains", "Hache 2M"},
		["MACE_WEAPON"] = {"Compétence de masse", "Masse"},
		["2H_MACE_WEAPON"] = {"Compétence de masse à deux mains", "Masse 2M"},
		["GUN_WEAPON"] = {"Compétence d'arme à feu", "Arme à feu"},
		["CROSSBOW_WEAPON"] = {"Compétence d'arbalète", "Arbalète"},
		["BOW_WEAPON"] = {"Compétence d'arc", "Arc"},
		["FERAL_WEAPON"] = {"Feral "..SKILL, "Feral"},
		["FIST_WEAPON"] = {"Main nue "..SKILL, "Main nue"},
		["EXPERTISE"] = {"Expertise", "Expertise"},
		["ARMOR_PENETRATION"] = {"Pénétration d'armure(%)", "PenAr(%)"},
		["MASTERY"] = {"Maîtrise", "Maîtrise"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {DODGE.." Neglect(%)", DODGE.." Neglect(%)"},
		["PARRY_NEGLECT"] = {PARRY.." Neglect(%)", PARRY.." Neglect(%)"},
		["BLOCK_NEGLECT"] = {BLOCK.." Neglect(%)", BLOCK.." Neglect(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Crit Damage(%)", "Crit Dmg(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage(%)", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage(%)", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Menace", "Menace"},
		["CAST_TIME"] = {"Temps d'incantation", "Tps incant"},
		["MANA_COST"] = {"Coût en mana", "Coût mana"},
		["RAGE_COST"] = {"Coût en rage", "Coût rage"},
		["ENERGY_COST"] = {"Coût en énergie", "Coût énergie"},
		["COOLDOWN"] = {"Cooldown", "CD"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"Mod "..SPELL_STAT1_NAME.."(%)", "Mod Str(%)"},
		["MOD_AGI"] = {"Mod "..SPELL_STAT2_NAME.."(%)", "Mod Agi(%)"},
		["MOD_STA"] = {"Mod "..SPELL_STAT3_NAME.."(%)", "Mod Sta(%)"},
		["MOD_INT"] = {"Mod "..SPELL_STAT4_NAME.."(%)", "Mod Int(%)"},
		["MOD_SPI"] = {"Mod "..SPELL_STAT5_NAME.."(%)", "Mod Spi(%)"},
		["MOD_HEALTH"] = {"Mod "..HEALTH.."(%)", "Mod "..HP.."(%)"},
		["MOD_MANA"] = {"Mod "..MANA.."(%)", "Mod "..MP.."(%)"},
		["MOD_ARMOR"] = {"Mod "..ARMOR.."from Items".."(%)", "Mod "..ARMOR.."(Items)".."(%)"},
		["MOD_BLOCK_VALUE"] = {"Mod Block Value".."(%)", "Mod Block Value".."(%)"},
		["MOD_DMG"] = {"Mod Damage".."(%)", "Mod Dmg".."(%)"},
		["MOD_DMG_TAKEN"] = {"Mod Damage Taken".."(%)", "Mod Dmg Taken".."(%)"},
		["MOD_CRIT_DAMAGE"] = {"Mod Crit Damage".."(%)", "Mod Crit Dmg".."(%)"},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"Mod Crit Damage Taken".."(%)", "Mod Crit Dmg Taken".."(%)"},
		["MOD_THREAT"] = {"Mod Threat".."(%)", "Mod Threat".."(%)"},
		["MOD_AP"] = {"Mod "..ATTACK_POWER_TOOLTIP.."(%)", "Mod AP".."(%)"},
		["MOD_RANGED_AP"] = {"Mod "..PLAYERSTAT_RANGED_COMBAT.." "..ATTACK_POWER_TOOLTIP.."(%)", "Mod RAP".."(%)"},
		["MOD_SPELL_PWR"] = {"Mod "..PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.."(%)", "Mod "..PLAYERSTAT_SPELL_COMBAT.." Dmg".."(%)"},
		["MOD_HEAL"] = {"Mod Healing".."(%)", "Mod Heal".."(%)"},
		["MOD_CAST_TIME"] = {"Mod Casting Time".."(%)", "Mod Cast Time".."(%)"},
		["MOD_MANA_COST"] = {"Mod Mana Cost".."(%)", "Mod Mana Cost".."(%)"},
		["MOD_RAGE_COST"] = {"Mod Rage Cost".."(%)", "Mod Rage Cost".."(%)"},
		["MOD_ENERGY_COST"] = {"Mod Energy Cost".."(%)", "Mod Energy Cost".."(%)"},
		["MOD_COOLDOWN"] = {"Mod Cooldown".."(%)", "Mod CD".."(%)"},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Weapon "..SKILL.." "..RATING, "Weapon"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Weapon "..SKILL, "Weapon"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Main Hand Weapon "..SKILL.." "..RATING, "MH Weapon"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Off Hand Weapon "..SKILL.." "..RATING, "OH Weapon"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Ranged Weapon "..SKILL.." "..RATING, "Ranged Weapon"..SKILL.." "..RATING},
	},
} -- }}}
