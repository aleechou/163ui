-- zhCN localization by iceburn

if GetLocale() ~= 'zhCN' then return end

--These constants need to be built outside the table before they can be referenced
local LOCALE_STHOUSAND = ",";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = "."; --Character(s) used for the decimal separator
local patNumber = "%d+["..LOCALE_STHOUSAND.."%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+["..LOCALE_STHOUSAND.."%d]*"..LOCALE_SDECIMAL.."?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.zhCN = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "板甲",
	Mail = "锁甲",
	Leather = "皮甲",
	Cloth = "布甲",
	
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
	["ExcludeLen"] = 3, -- using string.utf8len
  ["Exclude"] = {
    [""] = true,
    [" \n"] = true,
    ["分解"] = true, -- ITEM_DISENCHANT_ANY_SKILL = "Disenchantable"; -- Items that can be disenchanted at any skill level
    ["分解需"] = true, -- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)"; -- Minimum enchanting skill needed to disenchant
    ["持续时"] = true, -- ITEM_DURATION_DAYS = "Duration: %d days";
    ["<由%s"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r"; -- %s is the creator of the item
    ["冷却时"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d day";
    ["装备唯"] = true, -- Unique-Equipped
    ["唯一"] = true, -- ITEM_UNIQUE = "Unique";
    ["唯一("] = true, -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)";
    ["需要等"] = true, -- Requires Level xx
    ["需要 "] = true, -- Requires Level xx
    ["需要锻"] = true, -- Requires Level xx
    ["\n需要"] = true, -- Requires Level xx
    ["职业："] = true, -- Classes: xx
    ["种族："] = true, -- Races: xx (vendor mounts)
    ["使用："] = true, -- Use:
    ["击中时"] = true, -- Chance On Hit:
    -- Set Bonuses
    -- ITEM_SET_BONUS = "Set: %s";
    -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
    -- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
    ["套装："] = true,
    ["(2) 套装"] = true,
    ["(3) 套装"] = true,
    ["(4) 套装"] = true,
    ["(5) 套装"] = true,
    ["(6) 套装"] = true,
    ["(7) 套装"] = true,
    ["(8) 套装"] = true,
  },
  --[[
  textTable = {
    "法术伤害 +6 及法术命中等级 +5",
    "+3  耐力, +4 爆击等级",
    "++26 治疗法术 & 降低2% 威胁值",
    "+3 耐力/+4 爆击等级",
    "插槽加成:每5秒+2法力",
    "装备: 使所有法术和魔法效果所造成的伤害和治疗效果提高最多150点。",
    "装备: 使半径30码范围内所有小队成员的法术爆击等级提高28点。",
    "装备: 使30码范围内的所有队友提高所有法术和魔法效果所造成的伤害和治疗效果，最多33点。",
    "装备: 使周围半径30码范围内队友的所有法术和魔法效果所造成的治疗效果提高最多62点。",
    "装备: 使你的法术伤害提高最多120点，以及你的治疗效果最多300点。",
    "装备: 使周围半径30码范围内的队友每5秒恢复11点法力。",
    "装备: 使法术所造成的治疗效果提高最多300点。",
    "装备: 在猎豹、熊、巨熊和枭兽形态下的攻击强度提高420点。",
    -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
    -- "+26 Attack Power and +14 Critical Strike Rating": Swift Windfire Diamond ID:28556
    -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
    -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
    ----
    -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
    -- "Healing +11 and 2 mana per 5 sec.": Royal Tanzanite ID: 30603
  }
  --]]
  -----------------------
  -- Whole Text Lookup --
  -----------------------
  -- Mainly used for enchants that doesn't have numbers in the text
  ["WholeTextLookup"] = {
    [EMPTY_SOCKET_RED] = {["EMPTY_SOCKET_RED"] = 1}, -- EMPTY_SOCKET_RED = "Red Socket";
    [EMPTY_SOCKET_YELLOW] = {["EMPTY_SOCKET_YELLOW"] = 1}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
    [EMPTY_SOCKET_BLUE] = {["EMPTY_SOCKET_BLUE"] = 1}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
    [EMPTY_SOCKET_META] = {["EMPTY_SOCKET_META"] = 1}, -- EMPTY_SOCKET_META = "Meta Socket";

    ["野性"] = {["AP"] = 70}, --

    ["初级巫师之油"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, --
    ["次级巫师之油"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, --
    ["巫师之油"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, --
    ["卓越巫师之油"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, --
    ["神圣巫师之油"] = {["SPELL_DMG_UNDEAD"] = 60}, --

    ["超强法力之油"] = {["COMBAT_MANA_REGEN"] = 14}, --
    ["初级法力之油"] = {["COMBAT_MANA_REGEN"] = 4}, --
    ["次级法力之油"] = {["COMBAT_MANA_REGEN"] = 8}, --
    ["卓越法力之油"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, --
    ["超强巫师之油"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, --

    ["恒金渔线"] = {["FISHING"] = 5}, --
    ["活力"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, --
    ["魂霜"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
    ["阳炎"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --
    ["+40 法术伤害"] = {["SPELL_DMG"] = 40, ["HEAL"] = 40}, --
    ["+30 法术伤害"] = {["SPELL_DMG"] = 30, ["HEAL"] = 30}, --

    ["秘银马刺"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
    ["坐骑移动速度略微提升"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
    ["装备： 略微提高移动速度。"] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
    ["移动速度略微提升"] = {["RUN_SPEED"] = 8}, --
    ["略微提高奔跑速度"] = {["RUN_SPEED"] = 8}, --
    ["移动速度略微提升"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
    ["初级速度"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed
    ["稳固"] = {["MELEE_HIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted"

    ["狡诈"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
    ["威胁减少2%"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
    ["装备： 使你可以在水下呼吸。"] = false, -- [Band of Icy Depths] ID: 21526
    ["使你可以在水下呼吸"] = false, --
    ["装备： 免疫缴械。"] = false, -- [Stronghold Gauntlets] ID: 12639
    ["免疫缴械"] = false, --
    ["十字军"] = false, -- Enchant Crusader
    ["生命偷取"] = false, -- Enchant Crusader


    ["海象人的活力"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
    ["智慧"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
    ["精确"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
    ["天灾斩除"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
    ["履冰"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
    ["采集"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3238
    ["强效活力"] = {["COMBAT_MANA_REGEN"] = 6, ["COMBAT_HEALTH_REGEN"] = 6}, -- EnchantID: 3244
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
  	-- ["SinglePlusStatCheck"] = "^([%+%-]"..patNumber..") (.-)$",

	-- 5.1 Landfall added "(Reforged from Xxx)" next to the +Stat items, e.g.:
	--		+384 Strength (Reforged from Parry)
	--		+1,234 Stamina (Reforged from Critical Strike)
	-- 5.1 also changed enchantments to "Enchanted: %s" (e.g. "Enchanted: +170 Strength"),
	-- therefore this pattern should not be limited to the start of the line (start with "^") to also match enchants.
	--["SinglePlusStatCheck"] = "(([%+%-][%d]+)%s([%s%a]+[%a]+)%s*(%(?[%a%s]*%)?))%s?",  --from http://stackoverflow.com/questions/13619193/greed-non-greedy-pattern-matching-and-optional-suffixes-in-lua#13619193
	--["SinglePlusStatCheck"] = "(([%+%-]"..patNumber..")%s([%s%a]+[%a]+)%s*(%(?[%a%s]*%)?))%s?",
    -- +196命中（由招架重铸而来）
	-- ["SinglePlusStatCheck"] =   "(([%+%-]"..patNumber..")%s([%s%a%d]+[%a]+)%.?%s*(%(?[%a%s]*%)?))%s?",
    ['SinglePlusStatCheck'] = "([%+%-]"..patNumber..")%s?(.*)%s?\239?\188?\136?(.*)\239?\188?\137?",

  -----------------------------
  -- Single Equip Stat Check --
  -----------------------------
  -- stat1, value, stat2 = strfind
  -- stat = stat1..stat2
  -- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.$"
  --装备: 增加法术命中等级 11点。
  --装备: 提高所有法术和魔法效果所造成的伤害和治疗效果，最多46点。
  --"装备： (.-)提高(最多)?(%d+)(点)?(.-)。$",
  ["SingleEquipStatCheck"] = "装备： (.-)(%d+)点(.-)。$",
  -------------
  -- PreScan --
  -------------
  -- Special cases that need to be dealt with before base scan
  ["PreScanPatterns"] = {
    ["^装备: 猫形态下的攻击强度增加(%d+)"] = "FERAL_AP",
    ["^装备: 与亡灵作战时的攻击强度提高(%d+)点"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
    ["^(%d+)点护甲$"] = "ARMOR",
	["^("..patNumber..")点护甲$"] = "ARMOR",
    ["强化护甲 %+(%d+)"] = "ARMOR_BONUS",
    ["护甲值提高(%d+)点"] = "ARMOR_BONUS",
    ["每5秒恢复(%d+)点法力值。$"] = "COMBAT_MANA_REGEN",
    ["每5秒恢复(%d+)点生命值。$"] = "COMBAT_HEALTH_REGEN",
    ["每5秒回复(%d+)点法力值。$"] = "COMBAT_MANA_REGEN",
    ["每5秒回复(%d+)点法力值$"] = "COMBAT_MANA_REGEN",
    ["每5秒回复(%d+)点生命值。$"] = "COMBAT_HEALTH_REGEN",
    ["^%+?%"..patNumber.." %- ("..patNumber..").-伤害$"] = "MAX_DAMAGE",
    ["^（每秒伤害("..patDecimal..")）$"] = "DPS",

		-- Exclude
    ["^(%d+)格.-包"] = false, -- # of slots and bag type
    ["^(%d+)格.-袋"] = false, -- # of slots and bag type
    ["^(%d+)格容器"] = false, -- # of slots and bag type
    ["^.+（(%d+)/%d+）$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
    --["几率"] = false, --[挑战印记] ID:27924
    --["机率"] = false,
    --["有一定几率"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 --+12智力, 施法时有一定几率回复法力 gem ID:2835
    ["有可能"] = false, -- [Darkmoon Card: Heroism] ID:19287
    ["命中时"] = false, -- [黑色摧毁者手套] ID:22194
    ["被击中之后"] = false, -- [Essence of the Pure Flame] ID: 18815
    ["在杀死一个敌人"] = false, -- [注入精华的蘑菇] ID:28109
    ["每当你的"] = false, -- [电光相容器] ID: 28785
    ["被击中时"] = false, --
    ["你每施放一次法术，此增益的效果就降低17点伤害和34点治疗效果"] = false, --赞达拉英雄护符 ID:19950
	},
	
  --------------
  -- DeepScan --
  --------------
  -- Strip leading "Equip: ", "Socket Bonus: "
  ["Equip: "] = "装备: ", -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
  ["Socket Bonus: "] = "镶孔奖励: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
  -- Strip trailing "."
  ["."] = "。",
  ["DeepScanSeparators"] = {
    "/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
    " & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
    ", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
    "、", -- 防御者雕文
    "。",
  },
  ["DeepScanWordSeparators"] = {
    "及", "和", "并", "，","以及", "持续 "-- [发光的暗影卓奈石] ID:25894 "+24 攻击强度及略微提高奔跑速度", [刺客的火焰蛋白石] ID:30565 "爆击等级 +6 及躲闪等级 +5"
  },
  ["DualStatPatterns"] = { -- all lower case
    ["^%+(%d+)治疗和%+(%d+)法术伤害$"] = {{"HEAL",}, {"SPELL_DMG",},},
    ["^%+(%d+)治疗和%+(%d+)法术伤害及"] = {{"HEAL",}, {"SPELL_DMG",},},
    ["^使法术治疗提高最多(%d+)点，法术伤害提高最多(%d+)点$"] = {{"HEAL",}, {"SPELL_DMG",},},
  },
  ["DeepScanPatterns"] = {
    "^(.-)提高最多([%d%.]+)点(.-)$", --
    "^(.-)提高最多([%d%.]+)(.-)$", --
    "^(.-)，最多([%d%.]+)点(.-)$", --
    "^(.-)，最多([%d%.]+)(.-)$", --
    "^(.-)最多([%d%.]+)点(.-)$", --
    "^(.-)最多([%d%.]+)(.-)$", --
    "^(.-)提高([%d%.]+)点(.-)$", --
---
	"^(.-)提高("..patNumber..")点(.-)$",
    "^提高(.-)("..patNumber..")点(.-)$",
	"^(.-)("..patNumber..")点(.-)$", --
	"^(.-) ?("..patNumber..") ?点(.-)$", --
	"^(.-) ?([%+%-]"..patNumber..") ?(.-)$", --
	"^(.-) ?("..patNumber..") ?(.-)$", --
	"^(.-) ?("..patDecimal..") ?(.-)$", --
    "^(.-)提高([%d%.]+)(.-)$", --
    "^(.-)([%d%.]+)点(.-)$", --
    "^(.-) ?([%+%-][%d%.]+) ?点(.-)$", --
    "^(.-) ?([%+%-][%d%.]+) ?(.-)$", --
    "^(.-) ?([%d%.]+) ?点(.-)$", --
    "^(.-) ?([%d%.]+) ?(.-)$", --
  },
	
  -----------------------
  -- Stat Lookup Table --
  -----------------------
  -- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
  -- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
  ["StatIDLookup"] = {
    ["你的攻击无视目标的点护甲值"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
    ["% 威胁"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
    ["使你的潜行等级提高"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197
    ["潜行"] = {"STEALTH_LEVEL"}, -- Cloak Enchant
    ["武器伤害"] = {"MELEE_DMG"}, -- Enchant
    ["近战伤害"] = {"MELEE_DMG"}, -- Enchant
    ["使坐骑速度提高%"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048
    ["坐骑速度"] = {"MOUNT_SPEED"}, -- [Highlander's Plate Greaves] ID: 20048

    ["所有属性"] = {"STR", "AGI", "STA", "INT", "SPI",},
    ["力量"] = {"STR",},
    ["敏捷"] = {"AGI",},
    ["耐力"] = {"STA",},
    ["智力"] = {"INT",},
    ["精神"] = {"SPI",},

    ["奥术抗性"] = {"ARCANE_RES",},
    ["火焰抗性"] = {"FIRE_RES",},
    ["自然抗性"] = {"NATURE_RES",},
    ["冰霜抗性"] = {"FROST_RES",},
    ["暗影抗性"] = {"SHADOW_RES",},
    ["阴影抗性"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
    ["所有抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
    ["全部抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
    ["抵抗全部"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
    ["点所有魔法抗性"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",}, -- [锯齿黑曜石之盾] ID:22198

    ["钓鱼"] = {"FISHING",}, -- Fishing enchant ID:846
    ["钓鱼技能"] = {"FISHING",}, -- Fishing lure
    ["使钓鱼技能"] = {"FISHING",}, -- Equip: Increased Fishing +20.
    ["采矿"] = {"MINING",}, -- Mining enchant ID:844
    ["草药学"] = {"HERBALISM",}, -- Heabalism enchant ID:845
    ["剥皮"] = {"SKINNING",}, -- Skinning enchant ID:865

    ["护甲"] = {"ARMOR_BONUS",},
    ["护甲值"] = {"ARMOR_BONUS",},
    ["强化护甲"] = {"ARMOR_BONUS",},
    ["护甲值提高(%d+)点"] = {"ARMOR_BONUS",},
    ["防御"] = {"DEFENSE",},
    ["增加防御"] = {"DEFENSE",},

    ["生命值"] = {"HEALTH",},
    ["法力值"] = {"MANA",},

    ["攻击强度"] = {"AP",},
    ["攻击强度提高"] = {"AP",},
    ["提高攻击强度"] = {"AP",},
    ["与亡灵作战时的攻击强度"] = {"AP_UNDEAD",}, -- [黎明圣印] ID:13209 -- [弑妖裹腕] ID:23093
    ["与亡灵和恶魔作战时的攻击强度"] = {"AP_UNDEAD", "AP_DEMON",}, -- [勇士徽章] ID:23206
    ["与恶魔作战时的攻击强度"] = {"AP_DEMON",},
    ["在猎豹、熊、巨熊和枭兽形态下的攻击强度"] = {"FERAL_AP",}, -- Atiesh ID:22632
    ["使你的近战和远程攻击强度"] = {"AP"},
    ["远程攻击强度"] = {"RANGED_AP",}, -- [High Warlord's Crossbow] ID: 18837

    ["每5秒恢复(%d+)点生命值"] = {"COMBAT_HEALTH_REGEN",}, -- [Resurgence Rod] ID:17743
    ["每5秒回复(%d+)点生命值"] = {"COMBAT_HEALTH_REGEN",},
    ["生命值恢复速度"] = {"COMBAT_HEALTH_REGEN",}, -- [Demons Blood] ID: 10779

    ["每5秒法力"] = {"COMBAT_MANA_REGEN",}, --
    ["每5秒恢复法力"] = {"COMBAT_MANA_REGEN",}, -- [Royal Tanzanite] ID: 30603
    ["每5秒恢复(%d+)点法力值"] = {"COMBAT_MANA_REGEN",},
    ["每5秒回复(%d+)点法力值"] = {"COMBAT_MANA_REGEN",},
    ["每5秒法力回复"] = {"COMBAT_MANA_REGEN",},
    ["法力恢复"] = {"COMBAT_MANA_REGEN",},
    ["法力回复"] = {"COMBAT_MANA_REGEN",},
    ["使周围半径30码范围内的所有小队成员每5秒恢复(%d+)点法力值"] = {"COMBAT_MANA_REGEN",}, --

    ["法术穿透"] = {"SPELLPEN",},
    ["法术穿透力"] = {"SPELLPEN",},
    ["使你的法术穿透提高"] = {"SPELLPEN",},

    ["法术伤害和治疗"] = {"SPELL_DMG", "HEAL",},
    ["法术强度"] = {"SPELL_DMG", "HEAL",},
    ["法术治疗和伤害"] = {"SPELL_DMG", "HEAL",},
    ["治疗和法术伤害"] = {"SPELL_DMG", "HEAL",},
    ["法术伤害"] = {"SPELL_DMG",},
    ["提高法术和魔法效果所造成的伤害和治疗效果"] = {"SPELL_DMG", "HEAL"},
    ["使周围半径30码范围内的所有小队成员的法术和魔法效果所造成的伤害和治疗效果"] = {"SPELL_DMG", "HEAL"}, -- Atiesh, ID: 22630
    ["提高所有法术和魔法效果所造成的伤害和治疗效果"] = {"SPELL_DMG", "HEAL"},        --StatLogic:GetSum("22630")
    ["提高所有法术和魔法效果所造成的伤害和治疗效果，最多"] = {"SPELL_DMG", "HEAL"},
    --SetTip("22630")
    -- Atiesh ID:22630, 22631, 22632, 22589
            --装备: 使周围半径30码范围内队友的所有法术和魔法效果所造成的伤害和治疗效果提高最多33点。 -- 22630 -- 2.1.0
            --装备: 使周围半径30码范围内队友的所有法术和魔法效果所造成的治疗效果提高最多62点。 -- 22631
            --装备: 使半径30码范围内所有小队成员的法术爆击等级提高28点。 -- 22589
            --装备: 使周围半径30码范围内的队友每5秒恢复11点法力。
    ["使你的法术伤害"] = {"SPELL_DMG",}, -- Atiesh ID:22631
    ["伤害"] = {"SPELL_DMG",},
    ["法术能量"] = {"SPELL_DMG", "HEAL",},
    ["法术强度"] = {"SPELL_DMG", "HEAL",},
    ["神圣伤害"] = {"HOLY_SPELL_DMG",},
    ["奥术伤害"] = {"ARCANE_SPELL_DMG",},
    ["火焰伤害"] = {"FIRE_SPELL_DMG",},
    ["自然伤害"] = {"NATURE_SPELL_DMG",},
    ["冰霜伤害"] = {"FROST_SPELL_DMG",},
    ["暗影伤害"] = {"SHADOW_SPELL_DMG",},
    ["神圣法术伤害"] = {"HOLY_SPELL_DMG",},
    ["奥术法术伤害"] = {"ARCANE_SPELL_DMG",},
    ["火焰法术伤害"] = {"FIRE_SPELL_DMG",},
    ["自然法术伤害"] = {"NATURE_SPELL_DMG",},
    ["冰霜法术伤害"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
    ["暗影法术伤害"] = {"SHADOW_SPELL_DMG",},
    ["提高奥术法术和效果所造成的伤害"] = {"ARCANE_SPELL_DMG",},
    ["提高火焰法术和效果所造成的伤害"] = {"FIRE_SPELL_DMG",},
    ["提高冰霜法术和效果所造成的伤害"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
    ["提高神圣法术和效果所造成的伤害"] = {"HOLY_SPELL_DMG",},
    ["提高自然法术和效果所造成的伤害"] = {"NATURE_SPELL_DMG",},
    ["提高暗影法术和效果所造成的伤害"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871

    ["魔法和法术效果对亡灵造成的伤害"] = {"SPELL_DMG_UNDEAD",}, -- [黎明符文] ID:19812
    ["所有法术和效果对亡灵所造成的伤害"] = {"SPELL_DMG_UNDEAD",}, -- [净妖长袍] ID:23085
    ["魔法和法术效果对亡灵和恶魔所造成的伤害"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON",}, -- [勇士徽章] ID:23207

    ["使法术治疗"] = {"HEAL",},
    ["你的治疗效果"] = {"HEAL",}, -- Atiesh ID:22631
    ["治疗法术"] = {"HEAL",}, -- +35 Healing Glove Enchant
    ["治疗效果"] = {"HEAL",}, -- [圣使祝福手套] Socket Bonus
    ["治疗"] = {"HEAL",},
    ["法术治疗"] = {"HEAL",},
    ["神圣效果"] = {"HEAL",},-- Enchant Ring - Healing Power
    ["提高法术所造成的治疗效果"] = {"HEAL",},
    ["提高所有法术和魔法效果所造成的治疗效果"] = {"HEAL",},
    ["使周围半径30码范围内的所有小队成员的法术和魔法效果所造成的治疗效果"] = {"HEAL",}, -- Atiesh, ID: 22631

    ["每秒伤害"] = {"DPS",},
    ["每秒伤害提高"] = {"DPS",}, -- [Thorium Shells] ID: 15997

    ["防御等级"] = {"DEFENSE_RATING",},
    ["防御等级提高"] = {"DEFENSE_RATING",},
    ["提高你的防御等级"] = {"DEFENSE_RATING",},
    ["使防御等级"] = {"DEFENSE_RATING",},
    ["使你的防御等级"] = {"DEFENSE_RATING",},
---
    ["防御"] = {"DEFENSE_RATING",},
    ["防御提高"] = {"DEFENSE_RATING",},
    ["提高你的防御"] = {"DEFENSE_RATING",},
    ["使防御"] = {"DEFENSE_RATING",},
    ["使你的防御"] = {"DEFENSE_RATING",},
	
    ["躲闪等级"] = {"DODGE_RATING",},
    ["提高躲闪等级"] = {"DODGE_RATING",},
    ["躲闪等级提高"] = {"DODGE_RATING",},
    ["躲闪等级提高(%d+)"] = {"DODGE_RATING",},
    ["提高你的躲闪等级"] = {"DODGE_RATING",},
    ["使躲闪等级"] = {"DODGE_RATING",},
    ["使你的躲闪等级"] = {"DODGE_RATING",},
---
    ["躲闪"] = {"DODGE_RATING",},
    ["提高躲闪"] = {"DODGE_RATING",},
    ["躲闪提高"] = {"DODGE_RATING",},
    ["躲闪提高(%d+)"] = {"DODGE_RATING",},
    ["提高你的躲闪"] = {"DODGE_RATING",},
    ["使躲闪"] = {"DODGE_RATING",},
    ["使你的躲闪"] = {"DODGE_RATING",},
	
    ["招架等级"] = {"PARRY_RATING",},
    ["提高招架等级"] = {"PARRY_RATING",},
    ["提高你的招架等级"] = {"PARRY_RATING",},
    ["使招架等级"] = {"PARRY_RATING",},
    ["使你的招架等级"] = {"PARRY_RATING",},
---
    ["招架"] = {"PARRY_RATING",},
    ["提高招架"] = {"PARRY_RATING",},
    ["提高你的招架"] = {"PARRY_RATING",},
    ["使招架"] = {"PARRY_RATING",},
    ["使你的招架"] = {"PARRY_RATING",},
	
    ["盾挡等级"] = {"BLOCK_RATING",},
    ["提高盾挡等级"] = {"BLOCK_RATING",},
    ["提高你的盾挡等级"] = {"BLOCK_RATING",},
    ["使盾挡等级"] = {"BLOCK_RATING",},
    ["使你的盾挡等级"] = {"BLOCK_RATING",},
---
    ["盾挡"] = {"BLOCK_RATING",},
    ["提高盾挡"] = {"BLOCK_RATING",},
    ["提高你的盾挡"] = {"BLOCK_RATING",},
    ["使盾挡"] = {"BLOCK_RATING",},
    ["使你的盾挡"] = {"BLOCK_RATING",},
	
    ["格挡等级"] = {"BLOCK_RATING",},
    ["提高格挡等级"] = {"BLOCK_RATING",},
    ["提高你的格挡等级"] = {"BLOCK_RATING",},
    ["使格挡等级"] = {"BLOCK_RATING",},
    ["使你的格挡等级"] = {"BLOCK_RATING",},
---
    ["格挡"] = {"BLOCK_RATING",},
    ["提高格挡"] = {"BLOCK_RATING",},
    ["提高你的格挡"] = {"BLOCK_RATING",},
    ["使格挡"] = {"BLOCK_RATING",},
    ["使你的格挡"] = {"BLOCK_RATING",},
	
    ["盾牌格挡等级"] = {"BLOCK_RATING",},
    ["提高盾牌格挡等级"] = {"BLOCK_RATING",},
    ["提高你的盾牌格挡等级"] = {"BLOCK_RATING",},
    ["使盾牌格挡等级"] = {"BLOCK_RATING",},
    ["使你的盾牌格挡等级"] = {"BLOCK_RATING",},
---
    ["盾牌格挡"] = {"BLOCK_RATING",},
    ["提高盾牌格挡"] = {"BLOCK_RATING",},
    ["提高你的盾牌格挡"] = {"BLOCK_RATING",},
    ["使盾牌格挡"] = {"BLOCK_RATING",},
    ["使你的盾牌格挡"] = {"BLOCK_RATING",},

    ["命中等级"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
    ["提高命中等级"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_RATING
    ["使你的命中等级"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
    ["提高近战命中等级"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
---
    ["命中"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
    ["提高命中"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_RATING
    ["使你的命中"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING",},
    ["提高近战命中"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
	
    ["法术命中等级"] = {"SPELL_HIT_RATING",},
    ["提高法术命中等级"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
    ["使你的法术命中等级"] = {"SPELL_HIT_RATING",},
---
    ["法术命中"] = {"SPELL_HIT_RATING",},
    ["提高法术命中"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
    ["使你的法术命中"] = {"SPELL_HIT_RATING",},
	
    ["远程命中等级"] = {"RANGED_HIT_RATING",},
    ["提高远程命中等级"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
    ["使你的远程命中等级"] = {"RANGED_HIT_RATING",},
---
    ["远程命中"] = {"RANGED_HIT_RATING",},
    ["提高远程命中"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING
    ["使你的远程命中"] = {"RANGED_HIT_RATING",},

    ["爆击等级"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
    ["提高爆击等级"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
    ["使你的爆击等级"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
---
    ["爆击"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
    ["提高爆击"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
    ["使你的爆击"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
	
    ["近战爆击等级"] = {"MELEE_CRIT_RATING",},
    ["提高近战爆击等级"] = {"MELEE_CRIT_RATING",}, -- [屠杀者腰带] ID:21639
    ["使你的近战爆击等级"] = {"MELEE_CRIT_RATING",},
---
    ["近战爆击"] = {"MELEE_CRIT_RATING",},
    ["提高近战爆击"] = {"MELEE_CRIT_RATING",}, -- [屠杀者腰带] ID:21639
    ["使你的近战爆击"] = {"MELEE_CRIT_RATING",},
	
    ["法术爆击等级"] = {"SPELL_CRIT_RATING",},
    ["法术爆击"] = {"SPELL_CRIT_RATING",},
    ["提高法术爆击等级"] = {"SPELL_CRIT_RATING",}, -- [伊利达瑞的复仇] ID:28040
    ["使你的法术爆击等级"] = {"SPELL_CRIT_RATING",},
    ["使周围半径30码范围内的所有小队成员的法术爆击等级"] = {"SPELL_CRIT_RATING",}, -- Atiesh, ID: 22589
---
    ["法术爆击"] = {"SPELL_CRIT_RATING",},
    ["法术爆击"] = {"SPELL_CRIT_RATING",},
    ["提高法术爆击"] = {"SPELL_CRIT_RATING",}, -- [伊利达瑞的复仇] ID:28040
    ["使你的法术爆击"] = {"SPELL_CRIT_RATING",},
    ["使周围半径30码范围内的所有小队成员的法术爆击"] = {"SPELL_CRIT_RATING",}, -- Atiesh, ID: 22589

    ["远程爆击等级"] = {"RANGED_CRIT_RATING",},
    ["提高远程爆击等级"] = {"RANGED_CRIT_RATING",},
    ["使你的远程爆击等级"] = {"RANGED_CRIT_RATING",},
---
    ["远程爆击"] = {"RANGED_CRIT_RATING",},
    ["提高远程爆击"] = {"RANGED_CRIT_RATING",},
    ["使你的远程爆击"] = {"RANGED_CRIT_RATING",},
	
    ["提高命中躲闪等级"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING, Necklace of Trophies ID: 31275 (Patch 2.0.10 changed it to Hit Rating)
    ["提高近战命中躲闪等级"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
    ["提高远程命中躲闪等级"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
    ["提高法术命中躲闪等级"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
---
    ["提高命中躲闪"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING, Necklace of Trophies ID: 31275 (Patch 2.0.10 changed it to Hit Rating)
    ["提高近战命中躲闪"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
    ["提高远程命中躲闪"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
    ["提高法术命中躲闪"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING

    ["韧性"] = {"RESILIENCE_RATING",},
    ["韧性等级"] = {"RESILIENCE_RATING",},
    ["使你的韧性等级"] = {"RESILIENCE_RATING",},
    ["提高爆击躲闪等级"] = {"MELEE_CRIT_AVOID_RATING",},
    ["提高近战爆击躲闪等级"] = {"MELEE_CRIT_AVOID_RATING",},
    ["提高远程爆击躲闪等级"] = {"RANGED_CRIT_AVOID_RATING",},
    ["提高法术爆击躲闪等级"] = {"SPELL_CRIT_AVOID_RATING",},
---
    ["韧性"] = {"RESILIENCE_RATING",},
    ["韧性"] = {"RESILIENCE_RATING",},
    ["使你的韧性"] = {"RESILIENCE_RATING",},
    ["提高爆击躲闪"] = {"MELEE_CRIT_AVOID_RATING",},
    ["提高近战爆击躲闪"] = {"MELEE_CRIT_AVOID_RATING",},
    ["提高远程爆击躲闪"] = {"RANGED_CRIT_AVOID_RATING",},
    ["提高法术爆击躲闪"] = {"SPELL_CRIT_AVOID_RATING",},

    ["急速等级"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"}, -- Enchant Gloves
    ["攻击速度"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
    ["提高急速等级"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
    ["法术急速等级"] = {"SPELL_HASTE_RATING"},
    ["远程急速等级"] = {"RANGED_HASTE_RATING"},
    ["提高近战急速等级"] = {"MELEE_HASTE_RATING"},
    ["提高法术急速等级"] = {"SPELL_HASTE_RATING"},
    ["提高远程急速等级"] = {"RANGED_HASTE_RATING"},
---
    ["急速"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"}, -- Enchant Gloves
    ["攻击速度"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
    ["提高急速"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
    ["法术急速"] = {"SPELL_HASTE_RATING"},
    ["远程急速"] = {"RANGED_HASTE_RATING"},
    ["提高近战急速"] = {"MELEE_HASTE_RATING"},
    ["提高法术急速"] = {"SPELL_HASTE_RATING"},
    ["提高远程急速"] = {"RANGED_HASTE_RATING"},
	
    ["匕首技能"] = {"DAGGER_WEAPON_RATING"},
    ["匕首技能等级"] = {"DAGGER_WEAPON_RATING"},
    ["剑类技能"] = {"SWORD_WEAPON_RATING"},
    ["剑类武器技能等级"] = {"SWORD_WEAPON_RATING"},
    ["单手剑技能"] = {"SWORD_WEAPON_RATING"},
    ["单手剑技能等级"] = {"SWORD_WEAPON_RATING"},
    ["双手剑技能"] = {"2H_SWORD_WEAPON_RATING"},
    ["双手剑技能等级"] = {"2H_SWORD_WEAPON_RATING"},
    ["斧类技能"] = {"AXE_WEAPON_RATING"},
    ["斧类武器技能等级"] = {"AXE_WEAPON_RATING"},
    ["单手斧技能"] = {"AXE_WEAPON_RATING"},
    ["单手斧技能等级"] = {"AXE_WEAPON_RATING"},
    ["双手斧技能"] = {"2H_AXE_WEAPON_RATING"},
    ["双手斧技能等级"] = {"2H_AXE_WEAPON_RATING"},
    ["锤类技能"] = {"MACE_WEAPON_RATING"},
    ["锤类武器技能等级"] = {"MACE_WEAPON_RATING"},
    ["单手锤技能"] = {"MACE_WEAPON_RATING"},
    ["单手锤技能等级"] = {"MACE_WEAPON_RATING"},
    ["双手锤技能"] = {"2H_MACE_WEAPON_RATING"},
    ["双手锤技能等级"] = {"2H_MACE_WEAPON_RATING"},
    ["枪械技能"] = {"GUN_WEAPON_RATING"},
    ["枪械技能等级"] = {"GUN_WEAPON_RATING"},
    ["弩技能"] = {"CROSSBOW_WEAPON_RATING"},
    ["弩技能等级"] = {"CROSSBOW_WEAPON_RATING"},
    ["弓技能"] = {"BOW_WEAPON_RATING"},
    ["弓技能等级"] = {"BOW_WEAPON_RATING"},
    ["野性战斗技能"] = {"FERAL_WEAPON_RATING"},
    ["野性战斗技能等级"] = {"FERAL_WEAPON_RATING"},
    ["拳套技能"] = {"FIST_WEAPON_RATING"},
    ["拳套技能等级"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533

    ["使你的精准等级提高"] = {"EXPERTISE_RATING"},
    ["精准等级"] = {"EXPERTISE_RATING",},
    ["提高精准等级"] = {"EXPERTISE_RATING",},
    ["精准等级提高"] = {"EXPERTISE_RATING",},

    ['急速'] = {'MELEE_HASTE_RATING', 'SPELL_HASTE_RATING'},
    ['使你的急速提高'] = {'MELEE_HASTE_RATING', 'SPELL_HASTE_RATING'},

    ["精通"] = {"MASTERY_RATING",},
    ["使你的精通提高"] = {"MASTERY_RATING",},
---
    ["使你的精准提高"] = {"EXPERTISE_RATING"},
    ["精准"] = {"EXPERTISE_RATING",},
    ["提高精准"] = {"EXPERTISE_RATING",},
    ["精准提高"] = {"EXPERTISE_RATING",},
	
    ["护甲穿透等级"] = {"ARMOR_PENETRATION_RATING"},
    ["护甲穿透等级提高"] = {"ARMOR_PENETRATION_RATING"},
---
    ["护甲穿透"] = {"ARMOR_PENETRATION_RATING"},
    ["护甲穿透提高"] = {"ARMOR_PENETRATION_RATING"},

--[[	
		[RESILIENCE_ABBR] = {"RESILIENCE_RATING",},	
		[ITEM_MOD_RESILIENCE_RATING_SHORT] = {"RESILIENCE_RATING",}, --5.0.4  "+40 PvP Resilience", "Socket Bonus: +10 PvP Resilience"
		[ITEM_MOD_RESILIENCE_RATING] = {"RESILIENCE_RATING",},	--5.0.3  "Increases your pvp resilience by %s."
		[ITEM_MOD_PVP_POWER] = {"PVP_POWER", }, --5.0.4  e.g. "Equip: Increases your pvp power by %s."
		[ITEM_MOD_PVP_POWER_SHORT] = {"PVP_POWER",}, --5.0.4 "+50 PvP Power"
--]]

    -- Exclude
    ["秒"] = false,
    ["到"] = false,
    ["格容器"] = false,
    ["格箭袋"] = false,
    ["格弹药袋"] = false,
    ["远程攻击速度%"] = false, -- AV quiver
  },
} -- }}}

-- TODO for localizer: This was drycoded. Please test and fix if needed, especially the part that removes "by" or "by up to"!
function PatternLocale.zhCN.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		newKey = gsub(newKey, "点", "")
		
		--print("'"..k.."'")
		--print("'"..newKey.."'")
		targetStatIDLookup[newKey] = v
	end
end

DisplayLocale.zhCN = { -- {{{
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

    ["STEALTH_LEVEL"] = {"潜行等级", "潜行"},
    ["IGNORE_ARMOR"] = {"你的攻击无视目标的 %d+ 点护甲值。", "忽略护甲"},
    ["MELEE_DMG"] = {"近战伤害", "近战伤害"}, -- DAMAGE = "Damage"
    ["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg"}, -- DAMAGE = "Damage"
    ["MOUNT_SPEED"] = {"骑乘速度(%)", "骑速(%)"},
    ["RUN_SPEED"] = {"移动速度(%)", "跑速(%)"},

    ["STR"] = {SPELL_STAT1_NAME, "力"},
    ["AGI"] = {SPELL_STAT2_NAME, "敏"},
    ["STA"] = {SPELL_STAT3_NAME, "耐"},
    ["INT"] = {SPELL_STAT4_NAME, "智"},
    ["SPI"] = {SPELL_STAT5_NAME, "精"},
    ["ARMOR"] = {ARMOR, ARMOR},
    ["ARMOR_BONUS"] = {"护甲加成", "护甲"},

    ["FIRE_RES"] = {RESISTANCE2_NAME, "火抗"},
    ["NATURE_RES"] = {RESISTANCE3_NAME, "自然抗"},
    ["FROST_RES"] = {RESISTANCE4_NAME, "冰抗"},
    ["SHADOW_RES"] = {RESISTANCE5_NAME, "暗抗"},
    ["ARCANE_RES"] = {RESISTANCE6_NAME, "奥抗"},

    ["FISHING"] = {"钓鱼", "钓鱼"},
    ["MINING"] = {"采矿", "采矿"},
    ["HERBALISM"] = {"草药学", "草药"},
    ["SKINNING"] = {"剥皮", "剥皮"},

    ["BLOCK_VALUE"] = {"盾牌格挡值", "格挡值"},

    ["AP"] = {ATTACK_POWER_TOOLTIP, "攻强"},
    ["RANGED_AP"] = {RANGED_ATTACK_POWER, "远攻强度"},
    ["FERAL_AP"] = {"野性"..ATTACK_POWER_TOOLTIP, "野性强度"},
    ["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.."(亡灵)", "攻强(亡灵)"},
    ["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.."(恶魔)", "攻强(恶魔)"},

    ["HEAL"] = {"法术治疗", "治疗"},

    ["SPELL_POWER"] = {STAT_SPELLPOWER, STAT_SPELLPOWER},
    ["SPELL_DMG"] = {"法术伤害", "法伤"},
    ["SPELL_DMG_UNDEAD"] = {"法术伤害(亡灵)", PLAYERSTAT_SPELL_COMBAT.."法伤".."(亡灵)"},
    ["SPELL_DMG_DEMON"] = {"法术伤害(恶魔)", PLAYERSTAT_SPELL_COMBAT.."法伤".."(亡灵)"},
    ["HOLY_SPELL_DMG"] = {"神圣法术伤害", SPELL_SCHOOL1_CAP.."法伤"},
    ["FIRE_SPELL_DMG"] = {"火焰法术伤害", SPELL_SCHOOL2_CAP.."法伤"},
    ["NATURE_SPELL_DMG"] = {"自然法术伤害", SPELL_SCHOOL3_CAP.."法伤"},
    ["FROST_SPELL_DMG"] = {"冰霜法术伤害", SPELL_SCHOOL4_CAP.."法伤"},
    ["SHADOW_SPELL_DMG"] = {"暗影法术伤害", SPELL_SCHOOL5_CAP.."法伤"},
    ["ARCANE_SPELL_DMG"] = {"奥术法术伤害", SPELL_SCHOOL6_CAP.."法伤"},

    ["SPELLPEN"] = {"法术穿透", SPELL_PENETRATION},

    ["HEALTH"] = {HEALTH, HP},
    ["MANA"] = {MANA, MP},
    ["COMBAT_HEALTH_REGEN"] = {"生命恢复", "HP5"},
    ["COMBAT_MANA_REGEN"] = {"法力恢复", "MP5"},

    ["MAX_DAMAGE"] = {"最大伤害", "大伤"},
    ["DPS"] = {"每秒伤害", "DPS"},

    ["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, COMBAT_RATING_NAME2}, -- COMBAT_RATING_NAME2 = "Defense Rating"
    ["DODGE_RATING"] = {COMBAT_RATING_NAME3, COMBAT_RATING_NAME3}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
    ["PARRY_RATING"] = {COMBAT_RATING_NAME4, COMBAT_RATING_NAME4}, -- COMBAT_RATING_NAME4 = "Parry Rating"
    ["BLOCK_RATING"] = {COMBAT_RATING_NAME5, COMBAT_RATING_NAME5}, -- COMBAT_RATING_NAME5 = "Block Rating"
    ["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
    ["RANGED_HIT_RATING"] = {"远程命中等级", "远程命中"}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
    ["SPELL_HIT_RATING"] = {"法术命中等级", "法术命中"}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
    ["MELEE_HIT_AVOID_RATING"] = {"近战命中躲闪等级", "近战命中躲闪"},
    ["RANGED_HIT_AVOID_RATING"] = {"远程命中躲闪等级", "远程命中躲闪"},
    ["SPELL_HIT_AVOID_RATING"] = {"法术命中躲闪等级", "法术命中躲闪"},
    ["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, COMBAT_RATING_NAME9}, -- COMBAT_RATING_NAME9 = "Crit Rating"
    ["RANGED_CRIT_RATING"] = {"远程爆击等级", "远程爆击"},
    ["SPELL_CRIT_RATING"] = {"法术爆击等级", "法术爆击"},
    ["MELEE_CRIT_AVOID_RATING"] = {"爆击躲闪等级", "近战爆击躲闪"},
    ["RANGED_CRIT_AVOID_RATING"] = {"远程爆击躲闪等级", "远程爆击躲闪"},
    ["SPELL_CRIT_AVOID_RATING"] = {"法术爆击躲闪等级", "法术爆击躲闪"},
    ["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
    ["MELEE_HASTE_RATING"] = {"近战急速等级", "近战急速"}, --
    ["RANGED_HASTE_RATING"] = {"远程急速等级", "远程急速"},
    ["SPELL_HASTE_RATING"] = {"法术急速等级", "法术急速"},
    ["DAGGER_WEAPON_RATING"] = {"匕首技能等级", "匕首等级"}, -- SKILL = "Skill"
    ["SWORD_WEAPON_RATING"] = {"剑类武器技能等级", "剑等级"},
    ["2H_SWORD_WEAPON_RATING"] = {"双手剑技能等级", "双手剑等级"},
    ["AXE_WEAPON_RATING"] = {"斧类武器技能等级", "斧等级"},
    ["2H_AXE_WEAPON_RATING"] = {"双手斧技能等级", "双手斧等级"},
    ["MACE_WEAPON_RATING"] = {"锤类武器技能等级", "锤等级"},
    ["2H_MACE_WEAPON_RATING"] = {"双手锤技能等级", "双手锤等级"},
    ["GUN_WEAPON_RATING"] = {"枪械技能等级", "枪等级"},
    ["CROSSBOW_WEAPON_RATING"] = {"弩技能等级", "弩等级"},
    ["BOW_WEAPON_RATING"] = {"弓技能等级", "弓等级"},
    ["FERAL_WEAPON_RATING"] = {"野性技能等级", "野性等级"},
    ["FIST_WEAPON_RATING"] = {"徒手技能等级", "徒手等级"},
    ["STAFF_WEAPON_RATING"] = {"法杖技能等级", "法杖等级"}, -- Leggings of the Fang ID:10410
    ["EXPERTISE_RATING"] = {"精准等级", "精准等级"},
    ["ARMOR_PENETRATION_RATING"] = {"护甲穿透等级", "护甲穿透等级"},

    ---------------------------------------------------------------------------
    -- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
    -- Str -> AP, Block Value
    -- Agi -> AP, Crit, Dodge
    -- Sta -> Health
    -- Int -> Mana, Spell Crit
    -- Spi -> mp5nc, hp5oc
    -- Ratings -> Effect
    ["HEALTH_REGEN"] = {"正常回血", "正常回血"},
    ["MANA_REGEN"] = {"正常回魔", "正常回魔"},
    ["MELEE_CRIT_DMG_REDUCTION"] = {"爆击减伤(%)", "爆击减伤(%)"},
    ["RANGED_CRIT_DMG_REDUCTION"] = {"远程爆击减伤(%)", "远程爆击减伤(%)"},
    ["SPELL_CRIT_DMG_REDUCTION"] = {"法术爆击减伤(%)", "法术爆击减伤(%)"},
    ["DEFENSE"] = {DEFENSE, DEFENSE},
    ["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
    ["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
    ["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
    ["AVOIDANCE"] = {"完全豁免(%)", "豁免(%)"},
    ["MELEE_HIT"] = {"物理命中(%)", "命中(%)"},
    ["RANGED_HIT"] = {"远程命中(%)", "远程命中(%)"},
    ["SPELL_HIT"] = {"法术命中(%)", "法术命中(%)"},
    ["MELEE_HIT_AVOID"] = {"躲闪命中(%)", "躲闪命中(%)"},
    ["RANGED_HIT_AVOID"] = {"躲闪远程命中(%)", "躲闪远程命中(%)"},
    ["SPELL_HIT_AVOID"] = {"躲闪法术命中(%)", "躲闪法术命中(%)"},
    ["MELEE_CRIT"] = {"物理爆击(%)", "物理爆击(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
    ["RANGED_CRIT"] = {"远程爆击(%)", "远程爆击(%)"},
    ["SPELL_CRIT"] = {"法术爆击(%)", "法术爆击(%)"},
    ["MELEE_CRIT_AVOID"] = {"躲闪近战爆击(%)", "躲闪爆击(%)"},
    ["RANGED_CRIT_AVOID"] = {"躲闪远程爆击(%)", "躲闪远程爆击(%)"},
    ["SPELL_CRIT_AVOID"] = {"躲闪法术爆击(%)", "躲闪法术爆击(%)"},
    ["MELEE_HASTE"] = {"近战急速(%)", "近战急速(%)"}, --
    ["RANGED_HASTE"] = {"远程急速(%)", "远程急速(%)"},
    ["SPELL_HASTE"] = {"法术急速(%)", "法术急速(%)"},
    ["DAGGER_WEAPON"] = {"匕首技能", "匕首"}, -- SKILL = "Skill"
    ["SWORD_WEAPON"] = {"剑技能", "剑"},
    ["2H_SWORD_WEAPON"] = {"双手剑技能", "双手剑"},
    ["AXE_WEAPON"] = {"斧技能", "斧"},
    ["2H_AXE_WEAPON"] = {"双手斧技能", "双手斧"},
    ["MACE_WEAPON"] = {"锤技能", "锤"},
    ["2H_MACE_WEAPON"] = {"双手锤技能", "双手锤"},
    ["GUN_WEAPON"] = {"枪械技能", "枪械"},
    ["CROSSBOW_WEAPON"] = {"弩技能", "弩"},
    ["BOW_WEAPON"] = {"弓技能", "弓"},
    ["FERAL_WEAPON"] = {"野性技能", "野性"},
    ["FIST_WEAPON"] = {"徒手战斗技能", "徒手"},
    ["STAFF_WEAPON_RATING"] = {"法杖技能", "法杖"}, -- Leggings of the Fang ID:10410
    ["EXPERTISE"] = {"精准", "精准"},
    ["ARMOR_PENETRATION"] = {"护甲穿透(%)", "护甲穿透(%)"},
    ["MASTERY"] = {"精通", "精通"},

    ---------------------------------------------------------------------------
    -- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
    -- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
    -- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
    -- Expertise -> Dodge Neglect, Parry Neglect
    ["DODGE_NEGLECT"] = {"防止被躲闪(%)", "防止被躲闪(%)"},
    ["PARRY_NEGLECT"] = {"防止被招架(%)", "防止被招架(%)"},
    ["BLOCK_NEGLECT"] = {"防止被格挡(%)", "防止被格挡(%)"},

    ---------------------------------------------------------------------------
    -- Talents
    ["MELEE_CRIT_DMG"] = {"物理爆击(%)", "爆击(%)"},
    ["RANGED_CRIT_DMG"] = {"远程爆击(%)", "远程爆击(%)"},
    ["SPELL_CRIT_DMG"] = {"法术爆击(%)", "法爆(%)"},

    ---------------------------------------------------------------------------
    -- Spell Stats
    -- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
    -- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
    -- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
    -- Use strsplit("@", text) to seperate the spell name and statid
    ["THREAT"] = {"威胁值", "威胁"},
    ["CAST_TIME"] = {"施法时间", "施法时间"},
    ["MANA_COST"] = {"消耗法力", "消耗法力"},
    ["RAGE_COST"] = {"消耗怒气", "消耗怒气"},
    ["ENERGY_COST"] = {"消耗能量", "消耗能量"},
    ["COOLDOWN"] = {"冷却时间", "冷却"},

    ---------------------------------------------------------------------------
    -- Stats Mods
    ["MOD_STR"] = {"修正力量(%)", "修正力量(%)"},
    ["MOD_AGI"] = {"修正敏捷(%)", "修正敏捷(%)"},
    ["MOD_STA"] = {"修正耐力(%)", "修正耐力(%)"},
    ["MOD_INT"] = {"修正智力(%)", "修正智力(%)"},
    ["MOD_SPI"] = {"修正精神(%)", "修正精神(%)"},
    ["MOD_HEALTH"] = {"修正生命(%)", "修正生命(%)"},
    ["MOD_MANA"] = {"修正法力(%)", "修正法力(%)"},
    ["MOD_ARMOR"] = {"修正护甲(%)", "修正装甲(%)"},
    ["MOD_BLOCK_VALUE"] = {"修正格挡值(%)", "修正格挡值(%)"},
    ["MOD_DMG"] = {"修正伤害(%)", "修正伤害(%)"},
    ["MOD_DMG_TAKEN"] = {"修正承受伤害(%)", "修正受伤害(%)"},
    ["MOD_CRIT_DAMAGE"] = {"修正爆击(%)", "修正爆击(%)"},
    ["MOD_CRIT_DAMAGE_TAKEN"] = {"修正承受爆击(%)", "修正受爆击(%)"},
    ["MOD_THREAT"] = {"修正威胁(%)", "修正威胁(%)"},
    ["MOD_AP"] = {"修正近战攻击强度(%)", "修正攻强(%)"},
    ["MOD_RANGED_AP"] = {"修正远程攻击强度(%)", "修正远攻强度(%)"},
    ["MOD_SPELL_PWR"] = {"修正法术伤害(%)", "修正法伤(%)"},
    ["MOD_HEAL"] = {"修正法术治疗(%)", "修正治疗(%)"},
    ["MOD_CAST_TIME"] = {"修正施法时间(%)", "修正施法时间(%)"},
    ["MOD_MANA_COST"] = {"修正消耗法力(%)", "修正消耗法力(%)"},
    ["MOD_RAGE_COST"] = {"修正消耗怒气(%)", "修正消耗怒气(%)"},
    ["MOD_ENERGY_COST"] = {"修正消耗能量(%)", "修正消耗能量(%)"},
    ["MOD_COOLDOWN"] = {"修正技能冷却(%)", "修正技能冷却(%)"},

    ---------------------------------------------------------------------------
    -- Misc Stats
    ["WEAPON_RATING"] = {"武器技能等级", "武器技能等级"},
    ["WEAPON_SKILL"] = {"武器技能", "武器技能"},
    ["MAINHAND_WEAPON_RATING"] = {"主手武器技能等级", "主手武器技能等级"},
    ["OFFHAND_WEAPON_RATING"] = {"副手武器技能等级", "副手武器技能等级"},
    ["RANGED_WEAPON_RATING"] = {"远程武器技能等级", "远程武器技能等级"},
  },
} -- }}}
