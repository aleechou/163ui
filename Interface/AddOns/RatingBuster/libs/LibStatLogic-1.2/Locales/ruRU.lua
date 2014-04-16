-- ruRU localization by Gezz

if GetLocale() ~= 'ruRU' then return end

--These constants need to be built outside the table before they can be referenced
local LOCALE_STHOUSAND = ".";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = ","; --Character(s) used for the decimal separator
local patNumber = "%d+["..LOCALE_STHOUSAND.."%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+["..LOCALE_STHOUSAND.."%d]*"..LOCALE_SDECIMAL.."?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.ruRU = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "Латы",
	Mail = "Кольчуга",
	Leather = "Кожа",
	Cloth = "Ткань",
	
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
		
		["Перек"] = true, -- Перековано
		["Герои"] = true, -- Героический
		["Может"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
		-- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
		["Длите"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
		["<Изго"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
		["Време"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
		["Уника"] = true, -- Unique (20) -- ITEM_UNIQUE = "Unique"; -- Item is unique -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)"; -- Item is unique
		["Требу"] = true, -- Requires Level xx -- ITEM_MIN_LEVEL = "Requires Level %d"; -- Required level to use the item
		["\nТреб"] = true, -- Requires Level xx -- ITEM_MIN_SKILL = "Requires %s (%d)"; -- Required skill rank to use the item
		["Класс"] = true, -- Classes: xx -- ITEM_CLASSES_ALLOWED = "Classes: %s"; -- Lists the classes allowed to use this item
		["Расы:"] = true, -- Races: xx (vendor mounts) -- ITEM_RACES_ALLOWED = "Races: %s"; -- Lists the races allowed to use this item
		["Испол"] = true, -- Use: -- ITEM_SPELL_TRIGGER_ONUSE = "Use:";
		["Возмо"] = true, -- Chance On Hit: -- ITEM_SPELL_TRIGGER_ONPROC = "Chance on hit:";
		["Верхо"] = true, -- Верховые животные
		-- Set Bonuses
		-- ITEM_SET_BONUS = "Set: %s";
		-- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		-- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
		["Компл"] = true,
		["(2) S"] = true,
		["(3) S"] = true,
		["(4) S"] = true,
		["(5) S"] = true,
		["(6) S"] = true,
		["(7) S"] = true,
		["(8) S"] = true,
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

		["Слабое волшебное масло"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, -- ID: 20744
		["Простое волшебное масло"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, -- ID: 20746
		["Волшебное масло"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750
		["Сверкающее волшебное масло"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749
		["Превосходное волшебное масло"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
		["Благословенное волшебное масло"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

		["Слабое масло маны"] = {["COMBAT_MANA_REGEN"] = 4}, -- ID: 20745
		["Простое масло маны"] = {["COMBAT_MANA_REGEN"] = 8}, -- ID: 20747
		["Сверкающее масло маны"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, -- ID: 20748
		["Превосходное масло маны"] = {["COMBAT_MANA_REGEN"] = 14}, -- ID: 22521

		["Eternium Line"] = {["FISHING"] = 5}, --
		["свирепость"] = {["AP"] = 70}, --
		["жизненная сила"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, -- Enchant Boots - Vitality http://wow.allakhazam.com/db/spell.html?wspell=27948
		["Душелед"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
		["Солнечный огонь"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --

		["Мифриловые шпоры"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
		["Minor Mount Speed Increase"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
		["Если на персонаже: скорость бега слегка увеличилась."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["Небольшое увеличение скорости"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
		["Небольшое увеличение скорости бега"] = {["RUN_SPEED"] = 8}, --
		["Minor Speed"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility" http://wow.allakhazam.com/db/spell.html?wspell=34007
		["верный шаг"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

		["Скрытность"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
		["снижение угрозы на 2%"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
		["Если на персонаже: возможность дышать под водой."] = false, -- [Band of Icy Depths] ID: 21526
		["Возможность дышать под водой."] = false, --
		["Если на персонаже: Неуязвимость к способности Разоружение."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Неуязвимость к разоружению"] = false, --
		["Рыцарь"] = false, -- Enchant Crusader
		["Похищение жизни"] = false, -- Enchant Crusader

		["Живучесть клыкарра"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
		["Мудрость"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
		["Точность"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
		["Проклятие Плети"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
		["Ледопроходец"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
		["Собиратель"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		["Живучесть II"] = {["COMBAT_MANA_REGEN"] = 6, ["COMBAT_HEALTH_REGEN"] = 6}, -- EnchantID: 3244

		["+37 к выносливости и +20 к рейтингу защиты"] = {["STA"] = 37, ["DEFENSE_RATING"] = 20}, -- Defense does not equal Defense Rating...
		["Руна сломанных мечей"] = {["PARRY"] = 2}, -- EnchantID: 3594
		["Руна расколотых мечей"] = {["PARRY"] = 4}, -- EnchantID: 3365
		["Руна каменной горгульи"] = {["DEFENSE"] = 25, ["MOD_STA"] = 2}, -- EnchantID:

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
	-- ["SinglePlusStatCheck"] = "^([%+%-]%d+) (.-)%.?$",
	["SinglePlusStatCheck"] = "^(.-): %+("..patNumber..")%.?$",

	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
	--  ["SingleEquipStatCheck"] = "^Если на персонаже: (.-) ?н?е? ?б?о?л?е?е? ?ч?е?м?,? на (%d+) ?е?д?.? ?(.-)%.?$",
	["SingleEquipStatCheck"] = "^Если на персонаже: (.-)%s?+?(%d+)%.?%s?%(?.*%)?(.-)$",
	-------------
	-- PreScan --
	-------------
	-- Its preferable to have as few "PreScanPatterns" as possible, only use this table if all other methods fail.
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Если на персонаже: Увеличивает силу атаки на (%d+) ед. в облике кошки"] = "FERAL_AP",
		--["^Если на персонаже: Увеличение силы атаки на (%d+) ед. в битве с нежитью"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^Броня: (%d+)$"] = "ARMOR",
		["Доспех усилен %(%+(%d+) к броне%)"] = "ARMOR_BONUS",
		["Восполнение (%d+) ед%. маны раз в 5 сек%.$"] = "COMBAT_MANA_REGEN",
		["Восполнение (%d+) ед%. маны раз в 5 секунд"] = "COMBAT_MANA_REGEN",
		["Восполнение (%d+) ед%. маны в 5 секунд%."] = "COMBAT_MANA_REGEN",
		["^Урон: %+?%d+ %- ("..patNumber..")$"] = "MAX_DAMAGE",
		["^%(("..patDecimal..") единицы урона в секунду%)$"] = "DPS",
		["^%(("..patDecimal..") ед. урона в секунду%)$"] = "DPS",

		-- Exclude
		["^Комплект %((%d+) предмета%)"] = false, -- Set Name (0/9)
		["^Комплект"] = false, -- Set Name (0/9)
		["^.- %((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["[Cc]hance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 -- Commented out because it was blocking [Insightful Earthstorm Diamond]
		["[Ии]ногда"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["[Пп]ри получении удара в бою"] = false, -- [Essence of the Pure Flame] ID: 18815

		["Увеличение урона, наносимого заклинаниями и эффектами темной магии, на (%d+) ед%."] = "SHADOW_SPELL_DMG",
		["Увеличение урона, наносимого заклинаниями и эффектами льда, на (%d+) ед%."] = "FROST_SPELL_DMG",
		["Увеличение урона, наносимого заклинаниями и эффектами сил природы, на (%d+) ед%."] = "NATURE_SPELL_DMG",

		["Повышение не более чем на (%d+) ед.% урона, наносимого нежити заклинаниями и магическими эффектами%."] = "SPELL_DMG_UNDEAD", -- [Robe of Undead Cleansing] ID:23085
		["Увеличение урона, наносимого нежити и демонам от магических эффектов и заклинаний, не более чем на (%d+) ед%."] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [Mark of the Champion] ID:23207

		["Увеличивает силу атаки на (%d+) ед%. в облике кошки, медведя, лютого медведя или лунного совуха."] = "FERAL_AP",
	},
	
	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	["Equip: "] = "Если на персонаже: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "При соответствии цвета: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		-- " & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
	},
	["DeepScanWordSeparators"] = {
		-- "%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		" и ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) к лечению и %+(%d+) к урону от заклинаний$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+) к лечению %+(%d+) к урону от заклинаний$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^увеличение исцеляющих эффектов на (%d+) ед%. и урона от всех магических заклинаний и эффектов на (%d+) ед%.?$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["увеличивает силу заклинаний на (%d+) ед%."] = {{"SPELL_DMG",},{"HEAL",},},
	},
	["DeepScanPatterns"] = {
--		"^(.-) ?н?е? ?б?о?л?е?е? ?ч?е?м? на (%d+) ?е?д?.? ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-)%s?([%+%-]%d+)%s?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
		"^(.-)%s?([%d%,]+)%s(.-)$", -- 22.22 xxx xxx (scan last)
	},
	
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	-- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
	-- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
	["StatIDLookup"] = {
		["Увеличивает рейтинг пробивания брони на"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["Повышает рейтинг пробивания брони на"] = {"ARMOR_PENETRATION_RATING"},
		["% угрозы"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
		["увеличение уровня эффективного действия незаметности на"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
		["Скорость бега слегка увеличилась."] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

		["ко всем характеристикам"] = {"STR", "AGI", "STA", "INT", "SPI",},
		["Сила"] = {"STR",},
		["Ловкость"] = {"AGI",},
		["Выносливость"] = {"STA",},
		["Интеллект"] = {"INT",},
		["Дух"] = {"SPI",},

		["устойчивость:тайная магия"] = {"ARCANE_RES",},
		["устойчивость:огонь"] = {"FIRE_RES",},
		["устойчивость:природа"] = {"NATURE_RES",},
		["устойчивость:лед"] = {"FROST_RES",},
		["устойчивость:тьма"] = {"SHADOW_RES",},
		["к сопротивлению огню"] = {"FIRE_RES",},
		["к сопротивлению силам природы"] = {"NATURE_RES",},
		["к сопротивлению темной магии"] = {"SHADOW_RES",},
		["к сопротивлению тайной магии"] = {"ARCANE_RES",},
		["к сопротивлению всему"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		["Броня"] = {"ARMOR_BONUS",},
		["Защита"] = {"DEFENSE",},
		["Повышение защиты"] = {"DEFENSE",},

		["к силе"] = {"STR",},
		["к ловкости"] = {"AGI",},
		["к выносливости"] = {"STA",},
		["к интеллекту"] = {"INT",},
		["к духу"] = {"SPI",},
		["к здоровью"] = {"HEALTH",},
		["HP"] = {"HEALTH",},
		["Mana"] = {"MANA",},

		["сила атаки"] = {"AP",},
		["сила атаки увеличена на"] = {"AP",},
		["к силе атаки"] = {"AP",},
		["увеличение силы атаки на"] = {"AP",},
		["увеличивает силу атаки на"] = {"AP",},
		["увеличивает силу атаки наед"] = {"AP",},
		["Увеличение силы атаки в дальнем бою наед"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

		["здоровья каждые"] = {"COMBAT_HEALTH_REGEN",}, -- Frostwolf Insignia Rank 6 ID:17909
		["здоровья раз в"] = {"COMBAT_HEALTH_REGEN",}, -- [Resurgence Rod] ID:17743
		["ед. здоровья каждые 5 секунд"] = {"COMBAT_HEALTH_REGEN",}, -- [Royal Nightseye] ID: 24057
		["ед. здоровья каждые 5 сек"] = {"COMBAT_HEALTH_REGEN",}, -- [Royal Nightseye] ID: 24057
		["скорости восполнения здоровья - "] = {"COMBAT_HEALTH_REGEN",}, -- Demons Blood ID: 10779
		["восполняетед. здоровья каждые 5 сек"] = {"COMBAT_HEALTH_REGEN",}, -- [Onyxia Blood Talisman] ID: 18406
		["восполнениеед. здоровья каждые 5 сек"] = {"COMBAT_HEALTH_REGEN",}, -- [Resurgence Rod] ID:17743

		["маны раз в"] = {"COMBAT_MANA_REGEN",}, -- Resurgence Rod ID:17743 Most common
		["ед%. маны раз в 5 сек"] = {"COMBAT_MANA_REGEN",},
		["ед%. маны в 5 сек"] = {"COMBAT_MANA_REGEN",},
		["маны каждые 5 секунд"] = {"COMBAT_MANA_REGEN",}, -- [Royal Nightseye] ID: 24057
		["ед%. маны каждые 5 секунд"] = {"COMBAT_MANA_REGEN",}, -- [Royal Nightseye] ID: 24057
		["восполнениеманы раз в 5 сек."] = {"COMBAT_MANA_REGEN",}, -- [Resurgence Rod] ID:17743

		["проникающая способность заклинаний"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
		["к проникающей способности заклинаний"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
		["увеличение наед%. проникающей способности заклинаний на"] = {"SPELLPEN",},

		["сила заклинаний"] = {"SPELL_DMG", "HEAL",},
		["Увеличивает силу заклинаний на"] = {"SPELL_DMG", "HEAL",},
		["увеличивает силу заклинаний наед"] = {"SPELL_DMG", "HEAL",},
		["к урону от заклинаний и лечению"] = {"SPELL_DMG", "HEAL",},
		["к урону от заклинаний"] = {"SPELL_DMG", "HEAL",},
		["к силе заклинаний"] = {"SPELL_DMG", "HEAL",},
		["Увеличение урона и целительного действия магических заклинаний и эффектов"] = {"SPELL_DMG", "HEAL"},
		["к урону заклинаний от магии льда"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957

		["Увеличение урона от светлой магии, действие до"] = {"HOLY_SPELL_DMG",}, -- Drape of the Righteous ID:30642
		["к лечению"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057
		["Добавляетурона в секунду"] = {"DPS",}, -- [Thorium Shells] ID: 15977

		["рейтинг защиты"] = {"DEFENSE_RATING",},
		["увеличивает рейтинг защиты на"] = {"DEFENSE_RATING",}, -- [Golem Skull Helm] ID: 11746
		["к рейтингу защиты"] = {"DEFENSE_RATING",},
		["увеличение рейтинга защиты наед"] = {"DEFENSE_RATING",},
		["рейтинг уклонения"] = {"DODGE_RATING",},
		["к рейтингу уклонения"] = {"DODGE_RATING",},
		["увеличение рейтинга уклонения наед"] = {"DODGE_RATING",},
		["рейтинг парирования"] = {"PARRY_RATING",},
		["к рейтингу парирования"] = {"PARRY_RATING",},
		["рейтинг блокирования щитом"] = {"BLOCK_RATING",}, -- Enchant Shield - Lesser Block +10 Shield Block Rating http://wow.allakhazam.com/db/spell.html?wspell=13689
		["к рейтингу блока"] = {"BLOCK_RATING",}, --

		["рейтинг меткости"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["к рейтингу меткости"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["увеличение рейтинга меткости наед"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
		["к рейтингу меткости заклинаний"] = {"SPELL_HIT_RATING",}, -- Presence of Sight +18 Healing and Spell Damage/+8 Spell Hit http://wow.allakhazam.com/db/spell.html?wspell=24164
		["рейтинг меткости (заклинания)"] = {"SPELL_HIT_RATING",},


		--["Critical Rating"] = {"MELEE_CRIT_RATING",}, -- БАГ - непереведенный камень (+8 att power + 5 crit rate)
		["рейтинг критического удара"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["к рейтингу критического удара"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["рейтинг крит%. удара оруж%. ближнего боя"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
		["рейтинг критического удара (заклинания)"] = {"SPELL_CRIT_RATING",},
		["к рейтингу критического удара заклинаниями"] = {"SPELL_CRIT_RATING",},
		["к рейтингу критического удара заклинанием"] = {"SPELL_CRIT_RATING",},
		["Увеличение рейтинга критического эффекта заклинаний наед"] = {"SPELL_CRIT_RATING",},

		["Устойчивость"] = {"RESILIENCE_RATING",},
		["к устойчивости"] = {"RESILIENCE_RATING",},
		["рейтинг устойчивости"] = {"RESILIENCE_RATING",}, -- Enchant Chest - Major Resilience "+15 Resilience Rating" http://wow.allakhazam.com/db/spell.html?wspell=33992
		["к рейтингу устойчивости"] = {"RESILIENCE_RATING",}, -- Enchant Chest - Major Resilience "+15 Resilience Rating" http://wow.allakhazam.com/db/spell.html?wspell=33992

		["рейтинг скорости"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["к рейтингу скорости"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["рейтинг скорости боя"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["к рейтингу скорости боя"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
		["к рейтингу скорости заклинаний"] = {"SPELL_HASTE_RATING"},
		["рейтинг скорости боя (заклинания)"] = {"SPELL_HASTE_RATING"},

		["рейтинг мастерства"] = {"EXPERTISE_RATING"},
		["к рейтингу мастерства"] = {"EXPERTISE_RATING"},

		["к рейтингу искусности"] = {"MASTERY_RATING"},
		["рейтинг искусности"] = {"MASTERY_RATING"},
	},
} -- }}}

-- TODO for localizer: This was drycoded. Please test and fix if needed, especially the part that removes "by" or "by up to"!
function PatternLocale.ruRU.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		--newKey = gsub(newKey, " by ?u?p? ?t?o?", "")
		
		--print("'"..k.."'")
		--print("'"..newKey.."'")
		targetStatIDLookup[newKey] = v
	end
end

DisplayLocale.ruRU = { -- {{{
	----------------
	-- Stat Names --
	----------------
	-- Please localize these strings too, global strings were used in the enUS locale just to have minimum
	-- localization effect when a locale is not available for that language, you don't have to use global
	-- strings in your localization.
	["StatIDToName"] = {
		--[StatID] = {FullName, ShortName},
		["MASTERY_RATING"] = {"Рейтинг искусности", "РИ"},
		["MASTERY"] = {"Искусность", "Иск"},
	},
}
