

if GetLocale() ~= 'ptBR' then return end

--These constants need to be built outside the table before they can be referenced
local LOCALE_STHOUSAND = "%p";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = "%p"; --Character(s) used for the decimal separator
local patNumber = "%d+[%p%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+[%p%d]*%p?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.ptBR = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "Placas",
	Mail = "Malha",
	Leather = "Couro",
	Cloth = "Tecido",
	
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
	-- ExcludeLen Mirando a las primeras letras de una linea podemos excluir un monton de lineas
	["ExcludeLen"] = 5, -- using string.utf8len
	["Exclude"] = {
		[""] = true,
		[" \n"] = true,

		["Disen"] = true, -- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)";
		["Durat"] = true, -- ITEM_DURATION_DAYS = "Duration: %d |4day:days;";
		["<Made"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		["Coold"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		--["Uniqu"] = true, --ITEM_UNIQUE_MULTIPLE = "Unique (%d)"; -- Item is unique
		["Class"] = true, -- Classes: xx -- ITEM_CLASSES_ALLOWED = "Classes: %s"; -- Lists the classes allowed to use this item
		
		--["Desen"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		--["Durac"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["Tiemp"] = true, -- temps de recharge…
		["<Hecho"] = true, -- artisan
		["Único"] = true, -- Unique (20)
		["Nivel"] = true, -- Niveau
		["\nNive"] = true, -- Niveau
		["Clase"] = true, -- Classes: xx
		["Razas"] = true, -- Races: xx (vendor mounts)
		["Usar: "] = true, -- Utiliser:
		["Posib"] = true, -- Chance de toucher:
		["Reque"] = true, -- Requiert
		["\nRequ"] = true,-- Requiert
		["Neces"] = true,--nécessite plus de gemmes...
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["Bonif"] = true,--ensemble
		["(2) B"] = true,
		["(3) B"] = true,
		["(4) B"] = true,
		["(5) B"] = true,
		["(6) B"] = true,
		["(7) B"] = true,
		["(8) B"] = true,
	},

	-----------------------
	-- Whole Text Lookup --
	-----------------------
	-- Usado principalmente para encantamientos que no tienen numeros en el texto
	["WholeTextLookup"] = {
		[EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
		[EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		[EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		[EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";
			["de "..SPELL_STAT1_NAME] = SPELL_STAT1_NAME, -- Strength
	["de "..SPELL_STAT2_NAME] =SPELL_STAT2_NAME, -- Agility
	["de "..SPELL_STAT3_NAME] = SPELL_STAT3_NAME, -- Stamina
	["de "..SPELL_STAT4_NAME] = SPELL_STAT4_NAME, -- Intellect
	["de "..SPELL_STAT5_NAME] = SPELL_STAT5_NAME, -- Spirit

		--ToDo
		["Aceite de zahorí menor"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
		["Aceite de zahorí inferior"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
		["Aceite de zahorí"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
		["Aceite de zahorí luminoso"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
		["Aceite de zahorí excelente"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --
		["Aceite de zahorí bendito"] = {["SPELL_DMG_UNDEAD"] = 60}, --
		["Windwalk"] = false, --ID: 74244  Windwalk: Permanently enchant a weapon to sometimes increase dodge rating by 600 and movement speed by 15% for 10 sec
		["Flintlocke's Woodchucker"] = false, --ItemID: 70139  Flintlocke's Woodchucker

		["Aceite de maná menor"] = {["COMBAT_MANA_REGEN"] = 4}, --
		["Aceite de maná inferior"] = {["COMBAT_MANA_REGEN"] = 8}, --
		["Aceite de maná luminoso"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, --
		["Aceite de maná excelente"] = {["COMBAT_MANA_REGEN"] = 14}, --

		["Sedal de eternio"] = {["FISHING"] = 5}, --
		["Fuego solar"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --
    ["Velocidad de la montura"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
    ["Pies de plomo"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

    ["Sutileza"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
    -- ["2% Reduced Threat"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
    ["Equipar: Permite respirar bajo el agua"] = false, -- [Band of Icy Depths] ID: 21526
    ["Permite respirar bajo el agua"] = false, --
    ["Equipar: Duración de Desarmar reducida"] = false, -- [Stronghold Gauntlets] ID: 12639
    ["Immune a desarmar"] = false, --
    ["Robo de vida"] = false, -- Enchant Crusader

    --translated
    ["Espuelas de mitril"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
    ["Equipar: Velocidad de carrera aumentada ligeramente"] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048"
    ["Aumenta ligeramente la velocidad de movimiento"] = {["RUN_SPEED"] = 8}, --
    ["Aumenta ligeramente la velocidad de movimiento"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
    ["Vitalidad"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, -- Enchant Boots - Vitality "Vitality" http://wow.allakhazam.com/db/spell.html?wspell=27948
    ["Escarcha de alma"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
    ["Salvajismo"] = {["AP"] = 70}, --
    ["Velocidad menor"] = {["RUN_SPEED"] = 8},
    -- ["Vitesse mineure et +9 en Endurance"] = {["RUN_SPEED"] = 8, ["STA"] = 9},--enchant

    ["Cruzado"] = false, -- Enchant Crusader
    ["Mangosta"] = false, -- Enchant Mangouste
    ["Arma impia"] = false,
    -- ["Équipé : Evite à son porteur d'être entièrement englobé dans la Flamme d'ombre."] = false, --cape Onyxia
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
	["SinglePlusStatCheck"] = "^([%+%-]%d+[%p%d]*[%sde]-)(.+)%.?$",

	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
  ["SingleEquipStatCheck"] = "^Equípado: (.-) h?a?s?t?a? ?(%d+)(.-)?%.$",

	-------------
	-- PreScan --
	-------------
	-- Its preferable to have as few "PreScanPatterns" as possible, only use this table if all other methods fail.
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		["^(%d+) armadura$"] = "ARMOR",
		["^Equípado: Restaura (%d+) p. de salud cada 5 s"]= "COMBAT_HEALTH_REGEN",
		["^Equípado: Restaura (%d+) p. de maná cada 5 s"]= "COMBAT_MANA_REGEN",
		["^Equípado: Aumenta (%d+) p. el poder de ataque"]= "AP",
		-- ["^Equipar: Mejora tu índice de golpe crítico (%d+) p"]= "MELEE_CRIT_RATING",
		["Refuerza %(%+(%d+) Armadura%)"]= "ARMOR_BONUS",
		-- ["Lunette %(%+(%d+) points? de dégâts?%)"]="RANGED_AP",
		["^%+?"..patNumber.." %- (%d+) .-Daño$"] = "MAX_DAMAGE",
		["^%(("..patDecimal..") daño por segundo%)$"] = "DPS",

		-- Exclude
		["^.- %(%d+/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		--["Confère une chance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128
		["A veces ganas"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["Ganas una Carga"] = false, -- El condensador de rayos ID:28785
		["Daño:"] = false, -- ligne de degats des armes
		["Tu técnica"] = false,
		["^%+?%d+ %- %d+ puntos de daño %(.-%)$"]= false, -- ligne de degats des baguettes/ +degats (Thunderfury)
		-- ["Permettent au porteur"] = false, -- Casques Ombrelunes
		-- ["^.- %(%d+%) requis"] = false, --metier requis pour porter ou utiliser
		-- ["^.- ?[Vv]?o?u?s? [Cc]onfèren?t? .-"] = false, --proc
		-- ["^.- ?l?e?s? ?[Cc]hances .-"] = false, --proc
		-- ["^.- par votre sort .-"] = false, --augmentation de capacité de sort
		-- ["^.- la portée de .-"] = false, --augmentation de capacité de sort
		-- ["^.- la durée de .-"] = false, --augmentation de capacité de sort
	},

	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Equípado: ", --\194\160= espacio requerido
	["Socket Bonus: "] = "Bõnus de engaste: ",
	-- Strip trailing "."
	["."] = ".",
	[","] = "",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" e " , -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", " , -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"[^p]%." , -- cuando es p y punto no separa
	},
	["DeepScanWordSeparators"] = {
		" e ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["la salud %+(%d+) y el daño %+ (%d+)$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["la salud %+(%d+) el dano %+ (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
		["salud un máximo de (%d+) y el dano un máximo de (%d+)"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		--"(.-)?(%d+%s[se]-)(.-)", -- "xxx by up to 22 xxx" (scan first)
		-- "^(.-)5 [Ss]ek%. (%d+) (.-)$",  -- "xxx 5 Sek. 8 xxx" (scan 2nd)
		"^(.-) ?([%+%-]?%d+[%p%d+]*) ?de ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 3rd)
		"^(.-) ?([%+%-]?%d+[%p%d+]*)(%s? ?.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 3rd)
		--"^(.-) ?(%d+[%p%d+]*)( ?.-)$", -- 22.22 xxx xxx (scan last)
		--"^(.-) ?(%d+[%p%d+]*) ?de ?(.-)$", -- 22.22 xxx xxx (scan last)

		"^(.-)([%+%-]"..patNumber..") (.-)%.?$",
	},
	
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	-- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
	-- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
	["StatIDLookup"] = {
	},
} -- }}}

-- TODO for localizer: This was drycoded. Please test and fix if needed, especially the part that removes "by" or "by up to"!
function PatternLocale.ptBR.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		newKey = gsub(newKey, " h?a?s?t?a? ?", "")
		
		--print("'"..k.."'")
		--print("'"..newKey.."'")
		targetStatIDLookup[newKey] = v
	end
end

DisplayLocale.ptBR = { -- {{{
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

	},
} -- }}}
