-- deDE localization by Gailly, Dleh, cremor

if GetLocale() ~= 'deDE' then return end

--These constants need to be built outside the table before they can be referenced
local LOCALE_STHOUSAND = ".";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = ","; --Character(s) used for the decimal separator
local patNumber = "%d+["..LOCALE_STHOUSAND.."%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+["..LOCALE_STHOUSAND.."%d]*"..LOCALE_SDECIMAL.."?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.deDE = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "Platte",
	Mail = "Kette",
	Leather = "Leder",
	Cloth = "Stoff",
	
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
		
		 -- The following can't directly use the constants from GlobalStrings.lua because of placeholder patterns.
		["Entza"] = true, -- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)";
		["Dauer"] = true, -- ITEM_DURATION_DAYS = "Duration: %d |4day:days;";
		["<Herg"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r";
		["Verbl"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d |4day:days;";
		["Limit"] = true, -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)";
		["Einzi"] = true, -- ITEM_LIMIT_CATEGORY = "Unique: %s (%d)"; -- Note: Please do not remove that line, it might require a own entry in a localized version.
		--["Einzi"] = true, -- ITEM_LIMIT_CATEGORY_MULTIPLE = "Unique-Equipped: %s (%d)"; -- Note: Please do not remove that line, it might require a own entry in a localized version.
		["Benöt"] = true,  -- ITEM_MIN_LEVEL = "Requires Level %d";
		["Klass"] = true, -- ITEM_CLASSES_ALLOWED = "Classes: %s";
		["Völke"] = true, -- ITEM_RACES_ALLOWED = "Races: %s";
		["Gegen"] = true, -- ITEM_LEVEL = "Item Level %d";
		["Aufwe"] = true, -- 5.1.0: ITEM_UPGRADE_TOOLTIP_FORMAT = "Upgrade Level: %d/%d"; e.g.: "Upgrade Level: 0/2"
		["Set: "] = true, -- ITEM_SET_BONUS = "Set: %s";
		["(2) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(3) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(4) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(5) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(6) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(7) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(8) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		
		-- The following can't directly use the constants from GlobalStrings.lua because they are just the beginning of the line.
		["Benut"] = true, -- ITEM_SPELL_TRIGGER_ONUSE = "Use:";
		["Treff"] = true, -- ITEM_SPELL_TRIGGER_ONPROC = "Chance on hit:";
		
		-- Misc
		["Saiso"] = true, --e.g. "Season 10"  PvP Season items e.g. Vicious Gladiator's Emblem of Tenacity
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

		["Wildheit"] = {["AP"] = 34, ["MELEE_HIT_RATING"] = 16, ["SPELL_HIT_RATING"] = 16 }, --ID: 35452  Ferocity
		["Unbändigkeit"] = {["AP"] = 70}, --ID: 27971  Savagry +70 Attack Power

		["Schwaches Zauberöl"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --ID: 20744  Minor Wizard Oil
		["Geringes Zauberöl"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --ID: 20746  Lesser Wizard Oil
		["Zauberöl"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750  Wizard Oil
		["Hervorragendes Zauberöl"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749  Brilliant Wizard Oil
		["Überragendes Zauberöl"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
		["Gesegnetes Zauberöl"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123
		
		["Verzaubert: Gesang des Herzens"] = false, -- Enchant 4084
		["Verzaubert: Machtstrom"] = false, --20120915 Enchant 4907  /dump StatLogic:GetSum("item:77196:4097:0:0:0:0:0:0")
		["Verzaubert: Windwandler"] = false, --ID: 74244  Windwalk: Permanently enchant a weapon to sometimes increase dodge rating by 600 and movement speed by 15% for 10 sec
		["Verzaubert: Erdrutsch"] = false,
		["Verzaubert: Berserker"] = false,
		["Verzaubert: Windweise"] = false,
		["Verzaubert: Jadegeist"] = false,
		["Verzaubert: Tanzender Stahl"] = false,
		["Verzaubert: Elementarkraft"] = false,
		["Flintlockes Holzhacker"] = false, --ItemID: 70139  Flintlocke's Woodchucker

		["Schwaches Manaöl"] = {["COMBAT_MANA_REGEN"] = 4}, --
		["Geringes Manaöl"] = {["COMBAT_MANA_REGEN"] = 8}, --
		["Überragendes Manaöl"] = {["COMBAT_MANA_REGEN"] = 14}, --
		["Hervorragendes Manaöl"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, --

		["Eterniumangelschnur"] = {["FISHING"] = 5}, -- +5 Fishing
		["Vitalität"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, -- +4 Mana and Health every 5 sec
		["Seelenfrost"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, -- Changed to +54 Shadow and Frost Spell Power
		["Sonnenfeuer"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, -- Changed to +50 Arcane and Fire Spell Power

		["Mithrilsporen"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs  +4% Mount Speed
		["Schwache Reittierttempo-Strigerung"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill  +2% Mount Speed
		["Anlegen: Lauftempo ein wenig erhöht."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["Schwache Temposteigerung"] = {["RUN_SPEED"] = 8}, -- SpellID: 13890  EnchantID: 911 Enchant Boots - Minor Speed "Minor Speed Increase"
		["Schwaches Tempo"] = {["RUN_SPEED"] = 8}, -- SpellID: 34007  EnchantID: 2939 Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility"
		["Lauftempo ein wenig erhöht"] = {["RUN_SPEED"] = 8}, --
		["geringe Bewegungstempoerhöhung"] = {["RUN_SPEED"] = 8}, --SpellID: 74189  EnchantID: 4062  "+30 Stamina and Minor Movement Speed"

		["Sicherer Stand"] = {["MELEE_HIT_RATING"] = 10,  ["SPELL_HIT_RATING"] = 10, ["MELEE_CRIT_RATING"] = 10, ["SPELL_CRIT_RATING"] = 10}, -- EnchantID: 2658 Enchant Boots - Surefooted

		["Feingefühl"] = {["MOD_THREAT"] = -2}, -- EnchantID: 2621 Enchant Cloak - Subtlety
		["2% verringerte Bedrohung"] = {["MOD_THREAT"] = -2}, -- EnchantID: 2621, 2832, 3296
		["Anlegen: Ermöglicht Unterwasseratmung."] = false, -- [Band of Icy Depths] ID: 21526
		["Ermöglicht Unterwasseratmung"] = false, --
		["Anlegen: Immun gegen Entwaffnen."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immun gegen Entwaffnen"] = false, --
		["Kreuzfahrer"] = false, -- Enchant Crusader
		["Lebensdiebstahl"] = false, -- Lifestealing
		["Hurrikan"] = false, -- EnchantID: 4083 
		["Besserung"] = false, -- SpellID: 74195  EnchantID: 4066
		["Hell leuchtendes Garn"] = false, -- spell=75171
		["Gnomisches Röntgenzielfernrohr"] = false, -- item=59594
		["Rune des gefallenen Kreuzfahrers"] = false,

		["Vitalität der Tuskarr"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232 +15 Stamina and Minor Speed Increase
		["Weisheit"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296 +10 Spirit and 2% Reduced Threat
		["Präzision"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["Geißelbann"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247 +140 Attack Power versus Undead
		["Eiswandler"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["Sammler"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["Große Vitalität"] = {["COMBAT_MANA_REGEN"] = 6, ["COMBAT_HEALTH_REGEN"] = 6}, -- EnchantID: 3244 +7 Health and Mana every 5 sec

		--["+37 Ausdauer und +20 Verteidigung"] = {["STA"] = 37, ["DEFENSE_RATING"] = 20}, -- EnchantID: 3818 Defense does not equal Defense Rating...
		["Rune des Schwertbrechens"] = {["PARRY"] = 2}, -- EnchantID: 3594
		["Rune des Schwertberstens"] = {["PARRY"] = 4}, -- EnchantID: 3365
		["Rune des Steinhautgargoyles"] = {["MOD_ARMOR"] = 4, ["MOD_STA"] = 2}, -- EnchantID: 3847
		["Rune der nerubischen Panzerung"] = {["MOD_ARMOR"] = 2, ["MOD_STA"] = 1}, -- EnchantID: 3883

		--These are so rare to come across, who actually cares:
		["Anlegen: Mit Belbi Blitzknips' Garantie, dass damit JEDER attraktiv aussieht!"] = false, --ID: 33047  Belbi's Eyesight Enhancing Romance Goggles
		--["Equip: When worn with the Twilight Trappings Set, allows access to a Wind Stone in Silithus."] = false,
		["Anlegen: Erliegt dem Fluch von Bürgi Schwarzherz."] = false, --20120915 ID: 65665 Burgy Blackheart's Handsome Hat
		["Anlegen: Gestattet es Euch, schneller zu kochen."] = false, --20120915 ID; 46349  /dump StatLogic:SetTip("item:46349")
		["Anlegen: Eure Angriffe können unter Umständen kleine himmlische Objekte anziehen."] = false, --20120915 ID: 70144   Ricket's Magnetic Fireball  /dump StatLogic:GetSum("item:70144")
		["Anlegen: Erhöht die Reichweite Eurer Schockzauber sowie von 'Windstoß' um 5 Meter."] = false, --20120915 ID=51510 (among others) /dump StatLogic:GetSum("item:51510")
		["Anlegen: Eure Nahkampfangriffe gewähren Euch 10 Sek. lang 78 Stärke, bis zu 10-mal stapelbar."] = false, --ID: 77977  Eye of Unmaking
		["Anlegen: Ermöglicht Euch, zusätzliche Erzadern und Kräutervorkommen aufzuspüren, während Ihr Euch in Pandaria befindet."] = false, --ID: 87213 Mist-Piercing Goggles
		["Anlegen: Schützt den Träger davor, vollständig von der Schattenflamme verzehrt zu werden."] = false, --ID:15138 Onyxia Scale Cloak

		["Anlegen: Heilt Euch um 2% Eurer maximalen Gesundheit, wenn Ihr ein Ziel tötet, das Erfahrung oder Ehre gewährt."] = false, --Heirlooms ("Equip: Heals you for 2% of your maximum health whenever you kill a target that yields experience or honor.")
		["Anlegen: Stellt 2% Eures maximalen Manas wieder her, wenn Ihr ein Ziel tötet, das Erfahrung oder Ehre gewährt."] = false, --Heirlooms ("Equip: Restores 2% of your maximum mana whenever you kill a target that yields experience or honor.")

		["Anlegen: Jedes Mal, wenn Eure regelmäßigen Zauber Schaden verursachen, wird Eure Meisterschaft 10 Sek. lang um 39 erhöht. Bis zu 10-mal stapelbar."] = false, --ItemID: 68982  Necromantic Focus
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

	-- 5.1 Landfall added "(Reforged from Xxx)" next to the +Stat items
	-- 5.1 also changed enchantments to "Enchanted: %s" (e.g. "Enchanted: +170 Strength"),
	-- therefore this pattern should not be limited to the start of the line (start with "^") to also match enchants.
	-- Pattern is from http://stackoverflow.com/questions/13619193/greed-non-greedy-pattern-matching-and-optional-suffixes-in-lua/13620190#13620190
	-- The pattern used in enUS.lua doesn't match umlauts, e.g. it won't match "+100 Stärke".
	["SinglePlusStatCheck"] = "(([%+%-]"..patNumber..")%s*([%a]+[^%(^%)]+[%a]+)%s*(%(?[%a%s]*%)?))",
  
	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
    ["SingleEquipStatCheck"] = "^"..ITEM_SPELL_TRIGGER_ONEQUIP.." (.-) um b?i?s? ?z?u? ?("..patNumber..") ?(.-)%.?$",

	-------------
	-- PreScan --
	-------------
	-- Its preferable to have as few "PreScanPatterns" as possible, only use this table if all other methods fail.
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
		--["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^("..patNumber..") Rüstung$"] = "ARMOR",
		["Verstärkte %(%+(%d+) Rüstung%)"] = "ARMOR_BUFF",
		["Mana Regeneration (%d+) alle 5 Sek%.$"] = "COMBAT_MANA_REGEN",
		["^%+?"..patDecimal.." %- ("..patDecimal..") .-[Ss]chaden$"] = "MAX_DAMAGE",
		["^%(("..patDecimal..") Schaden pro Sekunde%)$"] = "DPS",  --e.g. "(1.103 Schaden pro Sekunde)"

		-- Exclude
		["^(%d+) Platz"] = false, -- Bags
		["^.+%((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["[Cc]hance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 -- Commented out because it was blocking [Insightful Earthstorm Diamond]
		["[Ee]s besteht eine Chance"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["[Ff]ügt dem Angreifer"] = false, -- [Essence of the Pure Flame] ID: 18815
		["^Erhöht die Angriffskraft um (%d+) nur in Katzen%-, Bären%-, Terrorbären%- und Mondkingestalt%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		
		--Reputation tabbard
		["^Anlegen: Ihr tragt die Insignien.-"] = false, --"Equip: You champion the cause of Gnomeregan. All reputation gains while in dungeons will be applied to your standing with them."
		["^Anlegen: Ihr streitet für die Sache.-"] = false, --"Equip: You champion the causes of your guild. All guild reputation gains are increased by 100%.

		--We don't handle anything that has a chance to proc
		--[[
			Equip: Your melee attacks have a chance to cause you to summon a Tentacle of the Old Ones to fight by your side for 12 sec.
			Equip: Your melee attacks have a chance to trigger a whirlwind attack dealing 8029 to 12044 physical damage to all targets within 10 yards.
			Equip: When you heal you have a chance to gain 2904 haste rating for 20 sec.
			Equip: Your spells have a chance to grant you 1,962 haste for 10 sec and 392 haste to up to 3 allies within 20 yards.
		--]]
		["^Anlegen: .- (eine Chance).-"] = false,
	},
	
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	[ITEM_SPELL_TRIGGER_ONEQUIP] = ITEM_SPELL_TRIGGER_ONEQUIP, -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "Sockelbonus: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"([^S][^e][^k])%. ",  -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
				-- Important for deDE to not separate "alle 5 Sek. 2 Mana"
	},
	["DeepScanWordSeparators"] = {
		" und ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) heilzauber %+(%d+) schadenszauber$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+) heilung %+(%d+) zauberschaden$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^erhöht durch sämtliche zauber und magische effekte verursachte heilung um bis zu (%d+) und den verursachten schaden um bis zu (%d+)$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) um b?i?s? ?z?u? ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		-- Special for deDE: "5 Sek." DeepScanPattern needed because otherwise it matches the "5" of "5 Sek." since "5 Sek." is before the actual value in German.
		"^(.-)5 [Ss]ek%. (%d+) (.-)$",  -- "xxx 5 Sek. 8 xxx" (scan 2nd)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 3rd)
		"^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	-- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
	-- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
	["StatIDLookup"] = {
		["% Schildblockwert"] = {"MOD_BLOCK_VALUE"}, --  "% Shield Block Value"[Eternal Earthsiege Diamond] ID: 41396
		["Zielfernrohr (Schaden)"] = {"RANGED_DMG"}, -- Khorium Scope EnchantID: 2723
		["Zielfernrohr (kritischer Trefferwert)"] = {"RANGED_CRIT_RATING"}, -- Stabilized Eternium Scope EnchantID: 2724
		["Erhöht Eure effektive Verstohlenheitsstufe"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		
		["alle Werte"] = {"STR", "AGI", "STA", "INT", "SPI",}, -- Different from SPELL_STATALL
		
		["Arcane Resist"] = {"ARCANE_RES",}, -- Arcane Armor Kit +8 Arcane Resist
		["Fire Resist"] = {"FIRE_RES",}, -- Flame Armor Kit +8 Fire Resist
		["Nature Resist"] = {"NATURE_RES",}, -- Frost Armor Kit +8 Frost Resist
		["Frost Resist"] = {"FROST_RES",}, -- Nature Armor Kit +8 Nature Resist
		["Shadow Resist"] = {"SHADOW_RES",}, -- Shadow Armor Kit +8 Shadow Resist
		["Schattenwiderstand"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["Alle Widerstände"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",}, -- Different from ITEM_RESIST_ALL

		["Angelfertigkeit"] = {"FISHING",}, -- Fishing lure
		["Fertigkeit im Angelnerhöht"] = {"FISHING"}, --Weather-Beaten Fishing Hat "Equip: Fishing skill increased by 5."
		["Bergbau"] = {"MINING",}, -- Mining enchant ID:844
		["Bergbau; muss nicht ausgerüstet sein"] = {"MINING"}, --ID: 2901 Mining Pick  "+10 Mining; does not need to be equipped." added in 5.0.4
		["Kräuterkunde"] = {"HERBALISM",}, -- Herbalism enchant ID:845
		["Kräuterkunde; muss nicht ausgerüstet sein"] = {"HERBALISM",}, -- ID:85663 Herbalist's Spade
		["Kürschnerei"] = {"SKINNING",}, -- Skinning enchant ID:865
		["Kürschnern; muss nicht ausgerüstet sein"] = {"SKINNING",}, -- ID:7005 Skinning Knife
		["Erhöht die Kürschnereifertigkeit. Ist mit anderen Fertigkeitsboni, die die Kürschnereifertigkeit erhöhen, nicht stapelbar"] = {"SKINNING",}, --20120915 ID: 12709  Finkle's Skinner

		["Erhöht die Angriffskraft im Kampf gegen Untote"] = {"AP_UNDEAD",}, -- [Wristwraps of Undead Slaying] ID:23093
		-- [Wristwraps of Undead Slaying] ID:23093
		["Erhöht die Angriffskraft gegen Untote"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Erhöht die Angriffskraft im Kampf gegen Untote. Ermöglicht das Einsammeln von Geißelsteinen im Namen der Argentumdämmerung"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Erhöht die Angriffskraft im Kampf gegen Dämonen"] = {"AP_DEMON",}, -- [Mark of the Champion] ID:23206

		["Schaden und Heilung"] = {"SPELL_DMG", "HEAL",},
		["Zauberschaden und Heilung"] = {"SPELL_DMG", "HEAL",},
		["Zauberkraft"] = {"SPELL_DMG", "HEAL",},
		["Erhöht durch Zauber und magische Effekte verursachten Schaden und Heilung"] = {"SPELL_DMG", "HEAL"},
		["Erhöht durch Zauber und magische Effekte zugefügten Schaden und Heilung aller Gruppenmitglieder, die sich im Umkreis von 30 befinden,"] = {"SPELL_DMG", "HEAL"}, -- Atiesh
		["Zauberschaden und Heilung"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
		["Schaden"] = {"SPELL_DMG",},
		["Zaubermacht"] = {"SPELL_DMG", "HEAL",},
		["Erhöht die Zaubermacht"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["Erhöht Zaubermacht"] = {"SPELL_DMG", "HEAL",}, -- WotLK
		["Erhöht Zaubermacht um"] = {"SPELL_DMG", "HEAL",},
		["Erhöht die Zaubermacht um"] = {"SPELL_DMG", "HEAL",},
		["Schadenszauber"] = {"SPELL_DMG"},
		
		["Heiligschaden"] = {"HOLY_SPELL_DMG",},
		["Arkanschaden"] = {"ARCANE_SPELL_DMG",},
		["Feuerschaden"] = {"FIRE_SPELL_DMG",},
		["Naturschaden"] = {"NATURE_SPELL_DMG",},
		["Frostschaden"] = {"FROST_SPELL_DMG",},
		["Schattenschaden"] = {"SHADOW_SPELL_DMG",},
		["Heiligzauberschaden"] = {"HOLY_SPELL_DMG",},
		["Arkanzauberschaden"] = {"ARCANE_SPELL_DMG",},
		["Feuerzauberschaden"] = {"FIRE_SPELL_DMG",},
		["Naturzauberschaden"] = {"NATURE_SPELL_DMG",},
		["Frostzauberschaden"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["Schattenzauberschaden"] = {"SHADOW_SPELL_DMG",},
		["Erhöht durch Arkanzauber und Arkaneffekte zugefügten Schaden"] = {"ARCANE_SPELL_DMG",},
		["Erhöht durch Feuerzauber und Feuereffekte zugefügten Schaden"] = {"FIRE_SPELL_DMG",},
		["Erhöht durch Frostzauber und Frosteffekte zugefügten Schaden"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["Erhöht durch Heiligzauber und Heiligeffekte zugefügten Schaden"] = {"HOLY_SPELL_DMG",},
		["Erhöht durch Naturzauber und Natureffekte zugefügten Schaden"] = {"NATURE_SPELL_DMG",},
		["Erhöht durch Schattenzauber und Schatteneffekte zugefügten Schaden"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871

		["Erhöht den durch Zauber und magische Effekte zugefügten Schaden gegen Untote"] = {"SPELL_DMG_UNDEAD"}, -- [Robe of Undead Cleansing] ID:23085
		["Erhöht den durch Zauber und magische Effekte zugefügten Schaden gegen Untote um bis zu 48. Ermöglicht das Einsammeln von Geißelsteinen im Namen der Argentumdämmerung."] = {"SPELL_DMG_UNDEAD"}, -- [Rune of the Dawn] ID:19812
		["Erhöht den durch Zauber und magische Effekte zugefügten Schaden gegen Untote und Dämonen"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [Mark of the Champion] ID:23207

		["Erhöht Heilung"] = {"HEAL",},
		["Heilung"] = {"HEAL",},
		["Heilzauber"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057

		["Erhöht durch Zauber und magische Effekte zugefügte Heilung aller Gruppenmitglieder, die sich im Umkreis von 30 befinden,"] = {"HEAL",}, -- Atiesh

		["Kochfertigkeit umerhöht"] = {"COOKING",}, --"Cooking skill increased by 10". For use with SingleEquipStatCheck

		-- Exclude
		["Sek"] = false,
		["bis"] = false,
		["Erhöht die erhaltene Erfahrung%"] = false, -- Heirlooms  e.g. /sl analyze 42984  Preened Ironfeather Shoulders
		["Durch das Töten von Monstern und das Abschließen von Quests erhaltene Erfahrung% erhöht"] = false, -- Heirlooms  e.g. /sl analyze 62040  Ancient Bloodmoon Cloak
	},
} -- }}}

function PatternLocale.deDE.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		newKey = gsub(newKey, " um ?b?i?s? ?z?u?", "")
		-- Special for deDE: "5 Sek" is still a special DeepScanPattern, so we need to remove it here.
		newKey = gsub(newKey, "5 [Ss]ek%. ", "")
		
		--print("'"..k.."'")
		--print("'"..newKey.."'")
		targetStatIDLookup[newKey] = v
	end
end

DisplayLocale.deDE = { -- {{{
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
	["Stat Multiplier"] = "Wertemultiplikatoren",
	["Attack Power Multiplier"] = "Angriffskraft-Multiplikatoren",
	["Reduced Physical Damage Taken"] = "Reduzierter erlittener physischer Schaden",
	["10% Melee/Ranged Attack Speed"] = "10% Melee/Ranged Attack Speed",
	["5% Spell Haste"] = "5% Spell Haste",
	-- NOTE I left many of the english terms because german players tend to use them and germans are much tooo long
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		---------------------------------------------------------------------------
		-- Tier1 Stats - Stats parsed directly off items
		["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, EMPTY_SOCKET_RED}, -- EMPTY_SOCKET_RED = "Red Socket";
		["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, EMPTY_SOCKET_YELLOW}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
		["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, EMPTY_SOCKET_BLUE}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
		["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, EMPTY_SOCKET_META}, -- EMPTY_SOCKET_META = "Meta Socket";

		["STEALTH_LEVEL"] = {"Verstohlenheitslevel", "Verstohlenheit"},
		["MELEE_DMG"] = {"Waffenschaden", "Waffenschaden"}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Reitgeschwindigkeit(%)", "Reitgeschw.(%)"},
		["RUN_SPEED"] = {"Laufgeschwindigkeit(%)", "Laufgeschw.(%)"},

		["STR"] = {SPELL_STAT1_NAME, "Stärke"},
		["AGI"] = {SPELL_STAT2_NAME, "Bewegl"},
		["STA"] = {SPELL_STAT3_NAME, "Ausdauer"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Wille"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {ARMOR.." von Bonus", ARMOR.."(Bonus)"},

		["FIRE_RES"] = {RESISTANCE2_NAME, "FW"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "NW"},
		["FROST_RES"] = {RESISTANCE4_NAME, "FrW"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "SW"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "AW"},

		["FISHING"] = {"Angeln", "Angeln"},
		["MINING"] = {"Bergbau", "Bergbau"},
		["HERBALISM"] = {"Kräuterkunde", "Kräutern"},
		["SKINNING"] = {"Kürschnerei", "Küschnern"},

		["BLOCK_VALUE"] = {"Blockwert", "Blockwert"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "AP"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "RAP"},
		["FERAL_AP"] = {"Feral "..ATTACK_POWER_TOOLTIP, "Feral AP"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (Untot)", "AP(Untot)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (Dämon)", "AP(Dämon)"},

		["HEAL"] = {"Heilung", "Heilung"},

		["SPELL_POWER"] = {STAT_SPELLPOWER, STAT_SPELLPOWER},
		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Schaden"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Untot)", PLAYERSTAT_SPELL_COMBAT.." Schaden".."(Untot)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Dämon)", PLAYERSTAT_SPELL_COMBAT.." Schaden".."(Dämon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Schaden"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Schaden"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Schaden"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Schaden"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Schaden"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.."Schaden"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REGEN"] = {HEALTH.." Regeneration (Nicht im Kampf)", "HP5(OC)"},
		["MANA_REGEN"] = {MANA.." Regeneration (Nicht im Kampf)", "MP5(OC)"},
		["COMBAT_HEALTH_REGEN"] = {HEALTH.." Regeneration", "HP5"},
		["COMBAT_MANA_REGEN"] = {MANA.." Regeneration", "MP5"},

		["MAX_DAMAGE"] = {"Maximalschaden", "Max Schaden"},
		["DPS"] = {"Schaden pro Sekunde", "DPS"},

		["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
		["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
		["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
		["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
		["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
		["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
		["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
		["MELEE_HIT_AVOID_RATING"] = {"Treffervermeidung "..RATING, "Treffervermeidung "..RATING},
		["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Treffervermeidung "..RATING, PLAYERSTAT_RANGED_COMBAT.." Treffervermeidung "..RATING},
		["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Treffervermeidung "..RATING, PLAYERSTAT_SPELL_COMBAT.." Treffervermeidung "..RATING},
		["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
		["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Kritvermeidung "..RATING, "Kritvermeidung "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung "..RATING, PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung "..RATING, PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Tempowertung", "Tempowertung"}, --
		["RANGED_HASTE_RATING"] = {"Distanztempowertung", "Distanztempowertung"},
		["SPELL_HASTE_RATING"] = {"Zaubertempowertung", "Zaubertempowertung"},
		["DAGGER_WEAPON_RATING"] = {"Dagger "..SKILL.." "..RATING, "Dagger "..RATING}, -- SKILL = "Skill"
		["SWORD_WEAPON_RATING"] = {"Sword "..SKILL.." "..RATING, "Sword "..RATING},
		["2H_SWORD_WEAPON_RATING"] = {"Two-Handed Sword "..SKILL.." "..RATING, "2H Sword "..RATING},
		["AXE_WEAPON_RATING"] = {"Axe "..SKILL.." "..RATING, "Axe "..RATING},
		["2H_AXE_WEAPON_RATING"] = {"Two-Handed Axe "..SKILL.." "..RATING, "2H Axe "..RATING},
		["MACE_WEAPON_RATING"] = {"Mace "..SKILL.." "..RATING, "Mace "..RATING},
		["2H_MACE_WEAPON_RATING"] = {"Two-Handed Mace "..SKILL.." "..RATING, "2H Mace "..RATING},
		["GUN_WEAPON_RATING"] = {"Gun "..SKILL.." "..RATING, "Gun "..RATING},
		["CROSSBOW_WEAPON_RATING"] = {"Crossbow "..SKILL.." "..RATING, "Crossbow "..RATING},
		["BOW_WEAPON_RATING"] = {"Bow "..SKILL.." "..RATING, "Bow "..RATING},
		["FERAL_WEAPON_RATING"] = {"Feral "..SKILL.." "..RATING, "Feral "..RATING},
		["FIST_WEAPON_RATING"] = {"Unarmed "..SKILL.." "..RATING, "Unarmed "..RATING},
		["STAFF_WEAPON_RATING"] = {"Staff "..SKILL.." "..RATING, "Staff "..RATING}, -- Leggings of the Fang ID:10410
		["EXPERTISE_RATING"] = {"Waffenkundewertung", "Waffenkundewertung"},
		["ARMOR_PENETRATION_RATING"] = {"Rüstungsdurchschlagwertung", "ArP".." "..RATING},
		["MASTERY_RATING"] = {"Meisterschaftswertung", "Meisterschaftswertung"},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["MELEE_CRIT_DMG_REDUCTION"] = {"Krit Schadenverminderung (%)", "Krit Schaden Verm(%)"},
		["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." Krit Schadenverminderung(%)", PLAYERSTAT_RANGED_COMBAT.." Krit Schaden Verm(%)"},
		["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." Krit Schadenverminderung(%)", PLAYERSTAT_SPELL_COMBAT.." Krit Schaden Verm(%)"},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
		["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
		["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
		["AVOIDANCE"] = {"Vermeidung(%)", "Vermeidung(%)"},
		["MELEE_HIT"] = {"Trefferchance(%)", "Treffer(%)"},
		["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." Trefferchance(%)", PLAYERSTAT_RANGED_COMBAT.." Treffer(%)"},
		["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." Trefferchance(%)", PLAYERSTAT_SPELL_COMBAT.." Treffer(%)"},
		["MELEE_HIT_AVOID"] = {"Treffer Vermeidung(%)", "Treffer Vermeid(%)"},
		["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Treffer Vermeidung(%)", PLAYERSTAT_RANGED_COMBAT.." Trefferermeidung(%)"},
		["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Treffer Vermeidung(%)", PLAYERSTAT_SPELL_COMBAT.." Treffervermeidung(%)"},
		["MELEE_CRIT"] = {MELEE_CRIT_CHANCE.."(%)", "Krit(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_RANGED_COMBAT.." Krit(%)"},
		["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_SPELL_COMBAT.." Krit(%)"},
		["MELEE_CRIT_AVOID"] = {"Kritvermeidung(%)", "Kritvermeidung(%)"},
		["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung(%)", PLAYERSTAT_RANGED_COMBAT.." Kritvermeidung(%)"},
		["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung(%)", PLAYERSTAT_SPELL_COMBAT.." Kritvermeidung(%)"},
		["MELEE_HASTE"] = {"Tempo(%)", "Tempo(%)"}, --
		["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." Tempo(%)", PLAYERSTAT_RANGED_COMBAT.." Tempo(%)"},
		["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." Tempo(%)", PLAYERSTAT_SPELL_COMBAT.." Tempo(%)"},
		["DAGGER_WEAPON"] = {"Dagger "..SKILL, "Dagger"}, -- SKILL = "Skill"
		["SWORD_WEAPON"] = {"Sword "..SKILL, "Sword"},
		["2H_SWORD_WEAPON"] = {"Two-Handed Sword "..SKILL, "2H Sword"},
		["AXE_WEAPON"] = {"Axe "..SKILL, "Axe"},
		["2H_AXE_WEAPON"] = {"Two-Handed Axe "..SKILL, "2H Axe"},
		["MACE_WEAPON"] = {"Mace "..SKILL, "Mace"},
		["2H_MACE_WEAPON"] = {"Two-Handed Mace "..SKILL, "2H Mace"},
		["GUN_WEAPON"] = {"Gun "..SKILL, "Gun"},
		["CROSSBOW_WEAPON"] = {"Crossbow "..SKILL, "Crossbow"},
		["BOW_WEAPON"] = {"Bow "..SKILL, "Bow"},
		["FERAL_WEAPON"] = {"Feral "..SKILL, "Feral"},
		["FIST_WEAPON"] = {"Unarmed "..SKILL, "Unarmed"},
		["STAFF_WEAPON"] = {"Staff "..SKILL, "Staff"}, -- Leggings of the Fang ID:10410
		--["EXPERTISE"] = {STAT_EXPERTISE, STAT_EXPERTISE},
		["EXPERTISE"] = {"Waffenkunde", "Waffenkunde"},
		["ARMOR_PENETRATION"] = {"Rüstungsdurchschlag(%)", "ArP(%)"},
		["MASTERY"] = {"Meisterschaft", "Meisterschaft"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {DODGE.." Verhinderung(%)", DODGE.." Verhinderung(%)"},
		["PARRY_NEGLECT"] = {PARRY.." Verhinderung(%)", PARRY.." Verhinderung(%)"},
		["BLOCK_NEGLECT"] = {BLOCK.." Verhinderung(%)", BLOCK.." Verhinderung(%)"},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Krit Schaden(%)", "Crit Schaden(%)"},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Krit Schaden(%)", PLAYERSTAT_RANGED_COMBAT.." Krit Schaden(%)"},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Krit Schaden(%)", PLAYERSTAT_SPELL_COMBAT.." Krit Schaden(%)"},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Bedrohung", "Bedrohung"},
		["CAST_TIME"] = {"Zauberzeit", "Zauberzeit"},
		["MANA_COST"] = {"Manakosten", "Mana"},
		["RAGE_COST"] = {"Wutkosten", "Wut"},
		["ENERGY_COST"] = {"Energiekosten", "Energie"},
		["COOLDOWN"] = {"Abklingzeit", "CD"},

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
		["CRIT_TAKEN"] = {"Chance kritisch getroffen zu werden", "Krit. Treffer bekommen", isPercent = true},
		["HIT_TAKEN"] = {"Chance getroffen zu werden", "Treffer bekommen", isPercent = true},
		["CRIT_DAMAGE_TAKEN"] = {"Kritischer Schaden genommen", "Krit. Schaden genommen", isPercent = true},
		["DMG_TAKEN"] = {"Schaden genommen", "Schaden genommen", isPercent = true},
		["CRIT_DAMAGE"] = {"Kritischer Schaden", "Krit. Schaden", isPercent = true},
		["DMG"] = {DAMAGE, DAMAGE},
		["BLOCK_REDUCTION"] = {"Erhöht die Menge, die Euer Blocken stoppt, um %1d", "Blockwertung", isPercent = true},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Waffe "..SKILL.." "..RATING, "Waffe"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Waffe "..SKILL, "Waffe"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Waffenhandwaffe "..SKILL.." "..RATING, "Waffenhand"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Schildhandwaffe "..SKILL.." "..RATING, "Schildhand"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Fernkampfwaffe "..SKILL.." "..RATING, "Fernkampf"..SKILL.." "..RATING},
	},
} -- }}}
