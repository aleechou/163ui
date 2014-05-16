-- koKR localization by fenlis, 7destiny, slowhand

if GetLocale() ~= 'koKR' then return end

--These constants need to be built outside the table before they can be referenced
local LOCALE_STHOUSAND = ",";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = "."; --Character(s) used for the decimal separator
local patNumber = "%d+["..LOCALE_STHOUSAND.."%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+["..LOCALE_STHOUSAND.."%d]*"..LOCALE_SDECIMAL.."?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.koKR = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "판금",
	Mail = "사슬",
	Leather = "가죽",
	Cloth = "천",

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
	["ExcludeLen"] = 3,
  ["Exclude"] = {
    [""] = true,
    [" \n"] = true,
	
    ["마력 "] = true, -- ITEM_DISENCHANT_ANY_SKILL = "마력 추출 가능"; -- Items that can be disenchanted at any skill level
    -- ITEM_DISENCHANT_MIN_SKILL = "마력 추출 요구 사항: %s (%d)"; -- Minimum enchanting skill needed to disenchant
    ["지속시"] = true, -- ITEM_DURATION_DAYS = "지속시간: %d일";
    ["<제작"] = true, -- ITEM_CREATED_BY = "|cff00ff00<제작자: %s>|r"; -- %s is the creator of the item
    ["재사용"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "재사용 대기시간: %d일";
    ["고유 "] = true, -- Unique (20)
    ["최소 "] = true, -- Requires Level xx
    ["\n최소"] = true, -- Requires Level xx
    ["직업:"] = true, -- Classes: xx
    ["종족:"] = true, -- Races: xx (vendor mounts)
    ["사용 "] = true, -- Use:
    ["발동 "] = true, -- Chance On Hit:
    -- Set Bonuses
    -- ITEM_SET_BONUS = "세트 효과: %s";
    -- ITEM_SET_BONUS_GRAY = "(%d) 세트 효과: %s";
    -- ITEM_SET_NAME = "%s (%d/%d)"; -- Set name (2/5)
    ["세트 "] = true,
    ["(2)"] = true,
    ["(3)"] = true,
    ["(4)"] = true,
    ["(5)"] = true,
    ["(6)"] = true,
    ["(7)"] = true,
    ["(8)"] = true,
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

    ["최하급 마술사 오일"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, -- ID: 20744
    ["하급 마술사 오일"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, -- ID: 20746
    ["마술사 오일"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750
    ["반짝이는 마술사 오일"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749
    ["상급 마술사 오일"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
    ["신성한 마술사 오일"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123

    ["최하급 마나 오일"] = {["COMBAT_MANA_REGEN"] = 4}, -- ID: 20745
    ["하급 마나 오일"] = {["COMBAT_MANA_REGEN"] = 8}, -- ID: 20747
    ["반짝이는 마나 오일"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, -- ID: 20748
    ["상급 마나 오일"] = {["COMBAT_MANA_REGEN"] = 14}, -- ID: 22521

    ["에터니움 낚시줄"] = {["FISHING"] = 5}, --
    ["전투력"] = {["AP"] = 70}, --
    ["활력"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, -- Enchant Boots - Vitality "Vitality" http://wow.allakhazam.com/db/spell.html?wspell=27948
    ["냉기의 영혼"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, --
    ["태양의 불꽃"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, --

    ["미스릴 박차"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs
    ["최하급 탈것 속도 증가"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill
    ["착용 효과: 달리기 속도가 약간 증가합니다."] = {["RUN_SPEED"] = 8}, -- [산악연대 판금 경갑] ID: 20048
    ["달리기 속도가 약간 증가합니다."] = {["RUN_SPEED"] = 8}, --
    ["최하급 달리기 속도 증가"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Minor Speed "Minor Speed Increase" http://wow.allakhazam.com/db/spell.html?wspell=13890
    ["최하급 달리기 속도"] = {["RUN_SPEED"] = 8}, -- Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility" http://wow.allakhazam.com/db/spell.html?wspell=34007
    ["침착함"] = {["MELEE_HIT_RATING"] = 10, ["SPELL_HIT_RATING"] = 10, ["MELEE_CRIT_RATING"] = 10, ["SPELL_CRIT_RATING"] = 10}, -- Enchant Boots - Surefooted "Surefooted" http://wow.allakhazam.com/db/spell.html?wspell=27954

    ["위협 수준 감소"] = {["MOD_THREAT"] = -2}, -- Enchant Cloak - Subtlety
    ["위협 수준 2%만큼 감소"] = {["MOD_THREAT"] = -2}, -- StatLogic:GetSum("item:23344:2832")
    ["착용 효과: 물속에서 숨쉴 수 있도록 해줍니다."] = false, -- [얼음 심연의 고리] ID: 21526
    ["물속에서 숨쉴 수 있도록 해줍니다"] = false, --
    ["착용 효과: 무장 해제의 지속시간이 50%만큼 감소합니다."] = false, -- [야성의 건들릿] ID: 12639
    ["무장해제에 면역이 됩니다"] = false, --
    ["성전사"] = false, -- Enchant Crusader
    ["흡혈"] = false, -- Enchant Crusader

    ["투스카르의 활력"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232
    ["지혜"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296
    ["적중"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788
    ["스컬지 파멸"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247
    ["극지방랑자"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826
    ["채집가"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
    ["상급 활력"] = {["COMBAT_MANA_REGEN"] = 6, ["COMBAT_HEALTH_REGEN"] = 6}, -- EnchantID: 3244
  },
  ----------------------------
  -- Single Plus Stat Check --
  ----------------------------
  -- depending on locale, it may be
  -- +19 Stamina = "^%+(%d+) (.-)%.?$"
  -- Stamina +19 = "^(.-) %+(%d+)%.?$"
  -- +19 耐力 = "^%+(%d+) (.-)%.?$"
  -- Some have a "." at the end of string like:
  -- Enchant Chest - Restore Mana Prime "+6 mana every 5 sec. "
  ["SinglePlusStatCheck"] = "^(.-) ([%+%-]"..patNumber..")%.?$",
  -----------------------------
  -- Single Equip Stat Check --
  -----------------------------
  -- stat1, value, stat2 = strfind
  -- stat = stat1..stat2
  -- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
  ["SingleEquipStatCheck"] = "^착용 효과: (.-) (%d+)만큼(.-)$",
  -------------
  -- PreScan --
  -------------
  -- Special cases that need to be dealt with before deep scan
  ["PreScanPatterns"] = {
    --["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
    --["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
    ["^표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.$"] = "FERAL_AP", -- 3.0.8 FAP change
    ["^방어도 (%d+)$"] = "ARMOR",
    ["방어도 보강 %(%+(%d+)%)"] = "ARMOR_BONUS",
    ["매 5초마다 (%d+)의 생명력이 회복됩니다.$"] = "COMBAT_HEALTH_REGEN",
    ["매 5초마다 (%d+)의 마나가 회복됩니다.$"] = "COMBAT_MANA_REGEN",
    ["^.-공격력 %+?%d+ %- ("..patNumber..")$"] = "MAX_DAMAGE",
    ["^%(초당 공격력 ("..patDecimal..")%)$"] = "DPS",
	
		-- Exclude
    ["^(%d+)칸"] = false, -- Bags
    ["^[%D ]+ %((%d+)/%d+%)$"] = false, -- Set Name (0/9)
    ["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
    ["일정 확률로"] = false, -- [도전의 징표] ID:27924 -- [퀴라지 예언자의 지팡이] ID:21128
    ["확률로"] = false, -- [다크문 카드: 영웅심] ID:19287
    ["가격 당했을 때"] = false, -- [순수한 불꽃의 정수] ID: 18815
    ["성공하면"] = false,
	},
	
  --------------
  -- DeepScan --
  --------------
  -- Strip leading "Equip: ", "Socket Bonus: "
  ["Equip: "] = "착용 효과: ",
  ["Socket Bonus: "] = "보석 장착 보너스: ",
  -- Strip trailing "."
  ["."] = ".",
  ["DeepScanSeparators"] = {
    "/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
    --", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
    "%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
    " / ",
  },
  ["DeepScanWordSeparators"] = {
    -- only put word separators here like "and" in english
  },
  ["DualStatPatterns"] = { -- all lower case
    ["^%+(%d+) 치유량 %+(%d+) 주문 공격력$"] = {{"HEAL",}, {"SPELL_DMG",},},
    ["^모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼, 공격력이 최대 (%d+)만큼 증가합니다$"] = {{"HEAL",}, {"SPELL_DMG",},},
  },
  ["DeepScanPatterns"] = {
    "^(.-) (%d+)만큼(.-)$", -- "xxx by up to 22 xxx" (scan first)
    "^(.-) 최대 (%d+)만큼(.-)$", -- "xxx by up to 22 xxx" (scan first)
    "^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
    "^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
  },
	
  -----------------------
  -- Stat Lookup Table --
  -----------------------
  -- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
  -- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
  ["StatIDLookup"] = {
    ["위협 수준%"] = {"MOD_THREAT"}, -- StatLogic:GetSum("item:23344:2613")
    ["지능%"] = {"MOD_INT"}, -- [Ember Skyflare Diamond] ID: 41333
    ["방패 피해 방어량%"] = {"MOD_BLOCK_VALUE"}, -- [Eternal Earthsiege Diamond] ID: 41396
    ["조준경 (공격력)"] = {"RANGED_DMG"}, -- Khorium Scope EnchantID: 2723
    ["조준경 (치명타 적중도)"] = {"RANGED_CRIT_RATING"}, -- Stabilized Eternium Scope EnchantID: 2724
    ["공격 시 적의 방어도를 무시합니다"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
    ["은신의 효과 레벨이 증가합니다"] = {"STEALTH_LEVEL"}, -- [밤하늘 장화] ID: 8197
    ["무기 공격력"] = {"MELEE_DMG"}, -- Enchant
    ["탈것의 속도가 %만큼 증가합니다"] = {"MOUNT_SPEED"}, -- [산악연대 판금 경갑] ID: 20048

    ["모든 능력치"] = {"STR", "AGI", "STA", "INT", "SPI",},
    ["힘"] = {"STR",},
    ["민첩성"] = {"AGI",},
    ["체력"] = {"STA",},
    ["지능"] = {"INT",},
    ["정신력"] = {"SPI",},

    ["비전 저항력"] = {"ARCANE_RES",},
    ["화염 저항력"] = {"FIRE_RES",},
    ["자연 저항력"] = {"NATURE_RES",},
    ["냉기 저항력"] = {"FROST_RES",},
    ["암흑 저항력"] = {"SHADOW_RES",},
    ["비전 저항"] = {"ARCANE_RES",}, -- Arcane Armor Kit +8 Arcane Resist
    ["화염 저항"] = {"FIRE_RES",}, -- Flame Armor Kit +8 Fire Resist
    ["자연 저항"] = {"NATURE_RES",}, -- Frost Armor Kit +8 Frost Resist
    ["냉기 저항"] = {"FROST_RES",}, -- Nature Armor Kit +8 Nature Resist
    ["암흑 저항"] = {"SHADOW_RES",}, -- Shadow Armor Kit +8 Shadow Resist
    ["암흑 저항력"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
    ["모든 저항력"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
    ["모든 저항"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

    ["낚시"] = {"FISHING",}, -- Fishing enchant ID:846
    ["낚시 숙련도"] = {"FISHING",}, -- Fishing lure
    ["낚시 숙련도가 증가합니다"] = {"FISHING",}, -- Equip: Increased Fishing +20.
    ["채광"] = {"MINING",}, -- Mining enchant ID:844
    ["약초 채집"] = {"HERBALISM",}, -- Heabalism enchant ID:845
    ["무두질"] = {"SKINNING",}, -- Skinning enchant ID:865

    ["방어도"] = {"ARMOR_BONUS",},
    ["방어 숙련"] = {"DEFENSE",},
    ["방어 숙련 증가"] = {"DEFENSE",},

    ["생명력"] = {"HEALTH",},
    ["HP"] = {"HEALTH",},
    ["마나"] = {"MANA",},

    ["전투력"] = {"AP",},
    ["전투력이 증가합니다"] = {"AP",},
    ["언데드에 대한 전투력"] = {"AP_UNDEAD",},
    -- [언데드 퇴치의 손목보호대] ID:23093
    ["언데드에 대한 전투력이 증가합니다"] = {"AP_UNDEAD",}, -- [여명의 문장] ID:13209
    ["언데드에 대한 전투력이 증가합니다. 또한 은빛 여명회를 대표하여 스컬지석을 획득할 수 있습니다"] = {"AP_UNDEAD",}, -- [여명의 문장] ID:13209
    ["악마에 대한 전투력이 증가합니다"] = {"AP_DEMON",},
    ["언데드 및 악마에 대한 전투력이 증가합니다"] = {"AP_UNDEAD", "AP_DEMON",},
    ["언데드 및 악마에 대한 전투력이 증가합니다. 또한 은빛 여명회를 대표하여 스컬지석을 획득할 수 있습니다"] = {"AP_UNDEAD", "AP_DEMON",}, -- [용사의 징표] ID:23206
    ["표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력"] = {"FERAL_AP",},
    ["표범, 광포한 곰, 곰, 달빛야수 변신 상태일 때 전투력이 증가합니다"] = {"FERAL_AP",},
    ["원거리 전투력"] = {"RANGED_AP",},
    ["원거리 전투력이 증가합니다"] = {"RANGED_AP",}, -- [대장군의 석궁] ID: 18837

    ["생명력 회복량"] = {"COMBAT_HEALTH_REGEN",},
    ["매 5초마다 (.+)의 생명력"] = {"COMBAT_HEALTH_REGEN",},
    ["평상시 생명력 회복 속도"] = {"COMBAT_HEALTH_REGEN",}, -- [악마의 피] ID: 10779
    ["마나 회복량"] = {"COMBAT_MANA_REGEN",}, -- Prophetic Aura +4 Mana Regen/+10 Stamina/+24 Healing Spells http://wow.allakhazam.com/db/spell.html?wspell=24167
    ["매 5초마다 (.+)의 마나"] = {"COMBAT_MANA_REGEN",},
    ["5초당 마나 회복량"] = {"COMBAT_MANA_REGEN",}, -- [호화로운 야안석] ID: 24057

    ["주문 관통력"] = {"SPELLPEN",}, -- Enchant Cloak - Spell Penetration "+20 Spell Penetration" http://wow.allakhazam.com/db/spell.html?wspell=34003
    ["주문 관통력이 증가합니다"] = {"SPELLPEN",},

    ["치유량 및 주문 공격력"] = {"SPELL_DMG", "HEAL",}, -- Arcanum of Focus +8 Healing and Spell Damage http://wow.allakhazam.com/db/spell.html?wspell=22844
    ["치유 및 주문 공격력"] = {"SPELL_DMG", "HEAL",},
    ["주문 공격력 및 치유량"] = {"SPELL_DMG", "HEAL",},
    ["주문 공격력"] = {"SPELL_DMG", "HEAL",},
    ["모든 주문 및 효과의 공격력과 치유량이 증가합니다"] = {"SPELL_DMG", "HEAL"},
    ["주위 30미터 반경에 있는 모든 파티원의 주문력이 증가합니다"] = {"SPELL_DMG", "HEAL"}, -- 아티쉬
    ["주문 공격력 및 치유량"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
    ["피해"] = {"SPELL_DMG",},
    ["주문 공격력이 증가합니다"] = {"SPELL_DMG",}, -- Atiesh ID:22630, 22631, 22632, 22589
    ["주문력"] = {"SPELL_DMG", "HEAL",},
    ["주문력이 증가합니다"] = {"SPELL_DMG", "HEAL",}, -- WotLK
    ["신성 피해"] = {"HOLY_SPELL_DMG",},
    ["비전 피해"] = {"ARCANE_SPELL_DMG",},
    ["화염 피해"] = {"FIRE_SPELL_DMG",},
    ["자연 피해"] = {"NATURE_SPELL_DMG",},
    ["냉기 피해"] = {"FROST_SPELL_DMG",},
    ["암흑 피해"] = {"SHADOW_SPELL_DMG",},
    ["신성 주문력"] = {"HOLY_SPELL_DMG",},
    ["비전 주문력"] = {"ARCANE_SPELL_DMG",},
    ["화염 주문력"] = {"FIRE_SPELL_DMG",},
    ["자연 주문력"] = {"NATURE_SPELL_DMG",},
    ["냉기 주문력"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
    ["암흑 주문력"] = {"SHADOW_SPELL_DMG",},
    ["암흑 주문력이 증가합니다"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
    ["냉기 주문력이 증가합니다"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
    ["신성 주문력이 증가합니다"] = {"HOLY_SPELL_DMG",},
    ["비전 주문력이 증가합니다"] = {"ARCANE_SPELL_DMG",},
    ["화염 주문력이 증가합니다"] = {"FIRE_SPELL_DMG",},
    ["자연 주문력이 증가합니다"] = {"NATURE_SPELL_DMG",},

    ["언데드에 대한 주문력이 증가합니다"] = {"SPELL_DMG_UNDEAD"},
    ["언데드에 대한 주문력이 증가합니다. 또한 은빛여명회의 대리인으로서 스컬지석을 모을 수 있습니다"] = {"SPELL_DMG_UNDEAD"},
    ["언데드 및 악마에 대한 주문력이 증가합니다"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [용사의 징표] ID:23207

    ["주문 치유량"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
    ["치유량 증가"] = {"HEAL",},
    ["치유량"] = {"HEAL",},
    ["주문 공격력"] = {"SPELL_DMG",}, -- 2.3.0 StatLogic:GetSum("item:23344:2343")
    ["모든 주문 및 효과에 의한 치유량이"] = {"HEAL",}, -- 2.3.0
    ["주문 피해가 증가합니다"] = {"SPELL_DMG",}, -- 2.3.0
    ["모든 주문 및 효과에 의한 치유량이 증가합니다"] = {"HEAL",},

    ["초당 공격력"] = {"DPS",},
    ["초당의 피해 추가"] = {"DPS",}, -- [Thorium Shells] ID: 15977

    ["방어 숙련도"] = {"DEFENSE_RATING",},
    ["방어 숙련도가 증가합니다"] = {"DEFENSE_RATING",},
    ["회피 숙련도"] = {"DODGE_RATING",},
    ["회피 숙련도가 증가합니다."] = {"DODGE_RATING",},
    ["무기 막기 숙련도"] = {"PARRY_RATING",},
    ["무기 막기 숙련도가 증가합니다"] = {"PARRY_RATING",},
    ["방패 막기 숙련도"] = {"BLOCK_RATING",},
    ["방패 막기 숙련도가 증가합니다"] = {"BLOCK_RATING",},

    ["적중도"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"},
    ["적중도가 증가합니다"] = {"MELEE_HIT_RATING", "SPELL_HIT_RATING"}, -- ITEM_MOD_HIT_RATING
    ["근접 적중도가 증가합니다"] = {"MELEE_HIT_RATING",}, -- ITEM_MOD_HIT_MELEE_RATING
    ["주문 적중"] = {"SPELL_HIT_RATING",}, -- Presence of Sight +18 Healing and Spell Damage/+8 Spell Hit http://wow.allakhazam.com/db/spell.html?wspell=24164
    ["주문 적중도"] = {"SPELL_HIT_RATING",},
    ["주문 적중도가 증가합니다"] = {"SPELL_HIT_RATING",}, -- ITEM_MOD_HIT_SPELL_RATING
    ["원거리 적중도"] = {"RANGED_HIT_RATING",}, -- Biznicks 247x128 Accurascope EnchantID: 2523
    ["원거리 적중도가 증가합니다"] = {"RANGED_HIT_RATING",}, -- ITEM_MOD_HIT_RANGED_RATING

    ["치명타 적중도"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
    ["치명타 적중도가 증가합니다"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING",},
    ["주문 극대화 적중도"] = {"SPELL_CRIT_RATING",},
    ["주문 극대화 적중도가 증가합니다"] = {"SPELL_CRIT_RATING",},
    ["주위 30미터 반경에 있는 모든 파티원의 주문 극대화 적중도가 증가합니다"] = {"SPELL_CRIT_RATING",},
    ["원거리 치명타 적중도"] = {"RANGED_CRIT_RATING",}, -- Heartseeker Scope EnchantID: 3608
    ["원거리 치명타 적중도가 증가합니다"] = {"RANGED_CRIT_RATING",}, -- Fletcher's Gloves ID:7348
    ["치명타 및 주문 극대화 적중도"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},
    ["치명타 및 주문 극대화 적중도가 증가합니다"] = {"MELEE_CRIT_RATING", "SPELL_CRIT_RATING"},

    ["공격 회피 숙련도가 증가합니다"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RATING
    ["근접 공격 회피 숙련도가 증가합니다"] = {"MELEE_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_MELEE_RATING
    ["원거리 공격 회피 숙련도가 증가합니다"] = {"RANGED_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_RANGED_RATING
    ["주문 공격 회피 숙련도가 증가합니다"] = {"SPELL_HIT_AVOID_RATING"}, -- ITEM_MOD_HIT_TAKEN_SPELL_RATING
    ["탄력도"] = {"RESILIENCE_RATING",},
    ["탄력도가 증가합니다"] = {"RESILIENCE_RATING",},
    ["치명타 회피 숙련도가 증가합니다"] = {"MELEE_CRIT_AVOID_RATING",},
    ["근접 치명타 회피 숙련도가 증가합니다"] = {"MELEE_CRIT_AVOID_RATING",},
    ["원거리 치명타 회피 숙련도가 증가합니다"] = {"RANGED_CRIT_AVOID_RATING",},
    ["주문 치명타 회피 숙련도가 증가합니다"] = {"SPELL_CRIT_AVOID_RATING",},

    ["가속도"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
    ["가속도가 증가합니다"] = {"MELEE_HASTE_RATING", "SPELL_HASTE_RATING"},
    ["근접 공격 가속도가 증가합니다"] = {"MELEE_HASTE_RATING"},
    ["주문 시전 가속도"] = {"SPELL_HASTE_RATING"},
    ["주문 시전 가속도가 증가합니다"] = {"SPELL_HASTE_RATING"},
    ["원거리 공격 가속도"] = {"RANGED_HASTE_RATING"}, -- Micro Stabilizer EnchantID: 3607
    ["원거리 공격 가속도가 증가합니다"] = {"RANGED_HASTE_RATING"},

    ["단검류 숙련도가 증가합니다"] = {"DAGGER_WEAPON_RATING"},
    ["한손 도검류 숙련도가 증가합니다"] = {"SWORD_WEAPON_RATING"},
    ["양손 도검류 숙련도가 증가합니다"] = {"2H_SWORD_WEAPON_RATING"},
    ["한손 도끼류 숙련도가 증가합니다"] = {"AXE_WEAPON_RATING"},
    ["양손 도끼류 숙련도가 증가합니다"] = {"2H_AXE_WEAPON_RATING"},
    ["한손 둔기류 숙련도가 증가합니다"] = {"MACE_WEAPON_RATING"},
    ["양손 둔기류 숙련도가 증가합니다"] = {"2H_MACE_WEAPON_RATING"},
    ["총기류 숙련도가 증가합니다"] = {"GUN_WEAPON_RATING"},
    ["석궁류 숙련도가 증가합니다"] = {"CROSSBOW_WEAPON_RATING"},
    ["활류 숙련도가 증가합니다"] = {"BOW_WEAPON_RATING"},
    ["야성 전투 숙련도가 증가합니다"] = {"FERAL_WEAPON_RATING"},
    ["장착 무기류 숙련도가 증가합니다"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator
    ["맨손 전투 숙련도가 증가합니다"] = {"FIST_WEAPON_RATING"}, -- Demonblood Eviscerator ID:27533
    ["지팡이류 숙련도가 증가합니다"] = {"STAFF_WEAPON_RATING"}, -- Leggings of the Fang ID:10410

    ["숙련"] = {"EXPERTISE_RATING"}, -- gems
    ["숙련도가 증가합니다"] = {"EXPERTISE_RATING"},

    ["방어구 관통력"] = {"ARMOR_PENETRATION_RATING"}, -- gems
    ["방어구 관통력이 증가합니다"] = {"ARMOR_PENETRATION_RATING"},

    ["특화"] = {"MASTERY_RATING"}, -- gems
    ["특화도가 증가합니다"] = {"MASTERY_RATING"},

    -- Exclude
    ["초"] = false,
    ["칸 가방"] = false,
    ["칸 화살통"] = false,
    ["칸 탄환 주머니"] = false,
    ["원거리 공격 속도가%만큼 증가합니다"] = false, -- AV quiver
    ["원거리 무기 공격 속도가%만큼 증가합니다"] = false, -- AV quiver
  },
} -- }}}

-- TODO for localizer: This was drycoded. Please test and fix if needed, especially the part that removes "by" or "by up to"!
function PatternLocale.koKR.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		newKey = gsub(newKey, "만큼", "")
		
		--print("'"..k.."'")
		--print("'"..newKey.."'")
		targetStatIDLookup[newKey] = v
	end
end

DisplayLocale.koKR = { -- {{{
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
    ["EMPTY_SOCKET_RED"] = {EMPTY_SOCKET_RED, "붉은 보석"}, -- EMPTY_SOCKET_RED = "Red Socket";
    ["EMPTY_SOCKET_YELLOW"] = {EMPTY_SOCKET_YELLOW, "노란 보석"}, -- EMPTY_SOCKET_YELLOW = "Yellow Socket";
    ["EMPTY_SOCKET_BLUE"] = {EMPTY_SOCKET_BLUE, "푸른 보석"}, -- EMPTY_SOCKET_BLUE = "Blue Socket";
    ["EMPTY_SOCKET_META"] = {EMPTY_SOCKET_META, "얼개 보석"}, -- EMPTY_SOCKET_META = "Meta Socket";

    ["IGNORE_ARMOR"] = {"방어도 무시", "방무"},
    ["MOD_THREAT"] = {"위협(%)", "위협(%)"},
    ["STEALTH_LEVEL"] = {"은신 레벨 증가", "은신 레벨"},
    ["MELEE_DMG"] = {"근접 무기 공격력", "무기 공격력"}, -- DAMAGE = "Damage"
    ["RANGED_DMG"] = {"원거리 무기 공격력", "원거리 공격력"}, -- DAMAGE = "Damage"
    ["MOUNT_SPEED"] = {"탈것 속도(%)", "탈것 속도(%)"},
    ["RUN_SPEED"] = {"이동 속도(%)", "이속(%)"},

    ["STR"] = {SPELL_STAT1_NAME, SPELL_STAT1_NAME},
    ["AGI"] = {SPELL_STAT2_NAME, "민첩"},
    ["STA"] = {SPELL_STAT3_NAME, SPELL_STAT3_NAME},
    ["INT"] = {SPELL_STAT4_NAME, SPELL_STAT4_NAME},
    ["SPI"] = {SPELL_STAT5_NAME, SPELL_STAT5_NAME},
    ["ARMOR"] = {ARMOR, ARMOR},
    ["ARMOR_BONUS"] = {"효과에 의한"..ARMOR, ARMOR.."(보너스)"},

    ["FIRE_RES"] = {RESISTANCE2_NAME, "화저"},
    ["NATURE_RES"] = {RESISTANCE3_NAME, "자저"},
    ["FROST_RES"] = {RESISTANCE4_NAME, "냉저"},
    ["SHADOW_RES"] = {RESISTANCE5_NAME, "암저"},
    ["ARCANE_RES"] = {RESISTANCE6_NAME, "비저"},

    ["FISHING"] = {"낚시", "낚시"},
    ["MINING"] = {"채광", "채광"},
    ["HERBALISM"] = {"약초채집", "약초"},
    ["SKINNING"] = {"무두질", "무두"},

    ["BLOCK_VALUE"] = {"피해 방어량", "방어량"},

    ["AP"] = {"전투력", "전투력"},
    ["RANGED_AP"] = {RANGED_ATTACK_POWER, "원거리 전투력"},
    ["FERAL_AP"] = {"야성 전투력", "야성 전투력"},
    ["AP_UNDEAD"] = {"전투력 (언데드)", "전투력 (언데드)"},
    ["AP_DEMON"] = {"전투력 (악마)", "전투력 (악마)"},

    ["HEAL"] = {"치유량", "치유"},

    ["SPELL_POWER"] = {STAT_SPELLPOWER, STAT_SPELLPOWER},
    ["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." 공격력", "공격력"},
    ["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." 공격력 (언데드)", "공격력 (언데드)"},
    ["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." 공격력 (악마)", "공격력 (악마)"},
    ["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." 공격력", SPELL_SCHOOL1_CAP.." 공격력"},
    ["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." 공격력", SPELL_SCHOOL2_CAP.." 공격력"},
    ["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." 공격력", SPELL_SCHOOL3_CAP.." 공격력"},
    ["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." 공격력", SPELL_SCHOOL4_CAP.." 공격력"},
    ["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." 공격력", SPELL_SCHOOL5_CAP.." 공격력"},
    ["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." 공격력", SPELL_SCHOOL6_CAP.." 공격력"},

    ["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION},

    ["HEALTH"] = {HEALTH, "HP"},
    ["MANA"] = {MANA, "MP"},
    ["COMBAT_HEALTH_REGEN"] = {HEALTH.." 회복", "HP5"},
    ["COMBAT_MANA_REGEN"] = {MANA.." 회복", "MP5"},

    ["MAX_DAMAGE"] = {"최대 공격력", "맥뎀"},
    ["DPS"] = {"초당 공격력", "DPS"},

    ["DEFENSE_RATING"] = {COMBAT_RATING_NAME2, "방숙"}, -- COMBAT_RATING_NAME2 = "Defense Rating"
    ["DODGE_RATING"] = {COMBAT_RATING_NAME3, "회피"}, -- COMBAT_RATING_NAME3 = "Dodge Rating"
    ["PARRY_RATING"] = {COMBAT_RATING_NAME4, "무막"}, -- COMBAT_RATING_NAME4 = "Parry Rating"
    ["BLOCK_RATING"] = {COMBAT_RATING_NAME5, "방막"}, -- COMBAT_RATING_NAME5 = "Block Rating"
    ["MELEE_HIT_RATING"] = {COMBAT_RATING_NAME6, COMBAT_RATING_NAME6}, -- COMBAT_RATING_NAME6 = "Hit Rating"
    ["RANGED_HIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_RANGED_COMBAT = "Ranged"
    ["SPELL_HIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME6}, -- PLAYERSTAT_SPELL_COMBAT = "Spell"
    ["MELEE_HIT_AVOID_RATING"] = {"빗맞힘(숙련도)", "빗맞힘"},
    ["RANGED_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." 빗맞힘(숙련도)", PLAYERSTAT_RANGED_COMBAT.." 빗맞힘"},
    ["SPELL_HIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.. "빗맞힘(숙련도)", PLAYERSTAT_RANGED_COMBAT.." 빗맞힘"},
    ["MELEE_CRIT_RATING"] = {COMBAT_RATING_NAME9, "치명타"}, -- COMBAT_RATING_NAME9 = "Crit Rating"
    ["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." 치명타"},
    ["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." 치명타"},
    ["MELEE_CRIT_AVOID_RATING"] = {"치명타 감소(숙련도)", "치명타 감소"},
    ["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 감소(숙련도)", PLAYERSTAT_RANGED_COMBAT.." 치명타 감소"},
    ["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 감소(숙련도)", PLAYERSTAT_SPELL_COMBAT.." 치명타 감소"},
    ["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
    ["MELEE_HASTE_RATING"] = {"가속도", "가속도"},
    ["RANGED_HASTE_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." 가속도"..RATING, PLAYERSTAT_RANGED_COMBAT.." 가속도"},
    ["SPELL_HASTE_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." 가속도", PLAYERSTAT_SPELL_COMBAT.." 가속도"},
    ["DAGGER_WEAPON_RATING"] = {"단검류 숙련도", "단검 숙련"}, -- SKILL = "Skill"
    ["SWORD_WEAPON_RATING"] = {"도검류 숙련도", "도검 숙련"},
    ["2H_SWORD_WEAPON_RATING"] = {"양손 도검류 숙련도", "양손 도검 숙련"},
    ["AXE_WEAPON_RATING"] = {"도끼류 숙련도", "도끼 숙련"},
    ["2H_AXE_WEAPON_RATING"] = {"양손 도끼류 숙련도", "양손 도끼 숙련"},
    ["MACE_WEAPON_RATING"] = {"둔기류 숙련도", "둔기 숙련"},
    ["2H_MACE_WEAPON_RATING"] = {"양손 둔기류 숙련도", "양손 둔기 숙련"},
    ["GUN_WEAPON_RATING"] = {"총기류 숙련도", "총기 숙련"},
    ["CROSSBOW_WEAPON_RATING"] = {"석궁류 숙련도", "석궁 숙련"},
    ["BOW_WEAPON_RATING"] = {"활류 숙련도", "활 숙련"},
    ["FERAL_WEAPON_RATING"] = {"야성 "..SKILL.." "..RATING, "야성 "..RATING},
    ["FIST_WEAPON_RATING"] = {"맨손 전투 숙련도", "맨손 숙련"},
    ["STAFF_WEAPON_RATING"] = {"지팡이류 숙련도", "지팡이 숙련"}, -- Leggings of the Fang ID:10410
    --["EXPERTISE_RATING"] = {STAT_EXPERTISE.." "..RATING, STAT_EXPERTISE.." "..RATING},
    ["EXPERTISE_RATING"] = {"숙련".." "..RATING, "숙련".." "..RATING},
    ["ARMOR_PENETRATION_RATING"] = {"방어구 관통력", "방어구 관통력"},
    ["MASTERY_RATING"] = {"특화도"..RATING, "특화"..RATING},

    ---------------------------------------------------------------------------
    -- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
    -- Str -> AP, Block Value
    -- Agi -> AP, Crit, Dodge
    -- Sta -> Health
    -- Int -> Mana, Spell Crit
    -- Spi -> mp5nc, hp5oc
    -- Ratings -> Effect
    ["HEALTH_REGEN"] = {HEALTH.." 회복 (비전투)", "HP5(OC)"},
    ["MANA_REGEN"] = {MANA.." 회복 (비시전)", "MP5(OC)"},
    ["MELEE_CRIT_DMG_REDUCTION"] = {"치명타 피해 감소(%)", "치명 피해감소(%)"},
    ["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 피해 감소(%)", PLAYERSTAT_RANGED_COMBAT.." 치명 피해감소(%)"},
    ["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 피해 감소(%)", PLAYERSTAT_SPELL_COMBAT.." 치명 피해감소(%)"},
    ["DEFENSE"] = {DEFENSE, "방숙"},
    ["DODGE"] = {DODGE.."(%)", DODGE.."(%)"},
    ["PARRY"] = {PARRY.."(%)", PARRY.."(%)"},
    ["BLOCK"] = {BLOCK.."(%)", BLOCK.."(%)"},
    ["AVOIDANCE"] = {"방어행동(%)", "방어행동(%)"},
    ["MELEE_HIT"] = {"적중(%)", "적중(%)"},
    ["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." 적중(%)", PLAYERSTAT_RANGED_COMBAT.." 적중(%)"},
    ["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." 적중(%)", PLAYERSTAT_SPELL_COMBAT.." 적중(%)"},
    ["MELEE_HIT_AVOID"] = {"빗맞힘(%)", "빗맞힘(%)"},
    ["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." 빗맞힘(%)", PLAYERSTAT_RANGED_COMBAT.." 빗맞힘(%)"},
    ["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." 빗맞힘(%)", PLAYERSTAT_SPELL_COMBAT.." 빗맞힘(%)"},
    ["MELEE_CRIT"] = {MELEE_CRIT_CHANCE.."(%)", "치명타(%)"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
    ["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE.."(%)", PLAYERSTAT_RANGED_COMBAT.." 치명타(%)"},
    ["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_CRIT_CHANCE.."(%)", "극대화(%)"},
    ["MELEE_CRIT_AVOID"] = {"치명타 감소(%)", "치명타 감소(%)"},
    ["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 감소(%)", PLAYERSTAT_RANGED_COMBAT.." 치명타 감소(%)"},
    ["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 감소(%)", PLAYERSTAT_SPELL_COMBAT.." 치명타 감소(%)"},
    ["MELEE_HASTE"] = {"가속도(%)", "가속도(%)"},
    ["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." 가속도(%)", PLAYERSTAT_RANGED_COMBAT.." 가속도(%)"},
    ["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." 가속도(%)", PLAYERSTAT_SPELL_COMBAT.." 가속도(%)"},
    ["DAGGER_WEAPON"] = {"단검류 숙련", "단검 숙련"}, -- SKILL = "Skill"
    ["SWORD_WEAPON"] = {"도검류 숙련", "도검 숙련"},
    ["2H_SWORD_WEAPON"] = {"양손 도검류 숙련", "양손 도검 숙련"},
    ["AXE_WEAPON"] = {"도끼류 숙련", "도끼 숙련"},
    ["2H_AXE_WEAPON"] = {"양손 도끼류 숙련", "양손 도끼 숙련"},
    ["MACE_WEAPON"] = {"둔기류 숙련", "둔기 숙련"},
    ["2H_MACE_WEAPON"] = {"양손 둔기류 숙련", "양손 둔기 숙련"},
    ["GUN_WEAPON"] = {"총기류 숙련", "총기 숙련"},
    ["CROSSBOW_WEAPON"] = {"석궁류 숙련", "석궁 숙련"},
    ["BOW_WEAPON"] = {"활류 숙련", "활 숙련"},
    ["FERAL_WEAPON"] = {"야성 "..SKILL, "야성"},
    ["FIST_WEAPON"] = {"맨손 전투 숙련", "맨손 숙련"},
    ["STAFF_WEAPON"] = {"지팡이류 숙련", "지팡이 숙련"}, -- Leggings of the Fang ID:10410
    --["EXPERTISE"] = {STAT_EXPERTISE, STAT_EXPERTISE},
    ["EXPERTISE"] = {"숙련 ", "숙련"},
    ["ARMOR_PENETRATION"] = {"방어구 관통(%)", "방어구 관통(%)"},

    ---------------------------------------------------------------------------
    -- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
    -- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
    -- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
    -- Expertise -> Dodge Neglect, Parry Neglect
    ["DODGE_NEGLECT"] = {"회피 무시(%)", "회피 무시(%)"},
    ["PARRY_NEGLECT"] = {"무기 막기 무시(%)", "무막 무시(%)"},
    ["BLOCK_NEGLECT"] = {"방패 막기 무시(%)", "방막 무시(%)"},

    ---------------------------------------------------------------------------
    -- Talents
    ["MELEE_CRIT_DMG"] = {"치명타 피해(%)", "치명타 피해(%)"},
    ["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." 치명타 피해(%)", PLAYERSTAT_RANGED_COMBAT.." 치명타 피해(%)"},
    ["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." 치명타 피해(%)", PLAYERSTAT_SPELL_COMBAT.." 치명타 피해(%)"},

    ---------------------------------------------------------------------------
    -- Spell Stats
    -- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
    -- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
    -- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
    -- Use strsplit("@", text) to seperate the spell name and statid
    ["THREAT"] = {"위협 수준", "위협"},
    ["CAST_TIME"] = {"시전 시간", "시전"},
    ["MANA_COST"] = {"마나 소비량", "마나"},
    ["RAGE_COST"] = {"분노 소비량", "분노"},
    ["ENERGY_COST"] = {"기력 소비량", "기력"},
    ["COOLDOWN"] = {"재사용 대기시간", "쿨타임"},

    ---------------------------------------------------------------------------
    -- Stats Mods
    ["MOD_STR"] = {"효과: "..SPELL_STAT1_NAME.."(%)", "효과: "..SPELL_STAT1_NAME.."(%)"},
    ["MOD_AGI"] = {"효과: "..SPELL_STAT2_NAME.."(%)", "효과: ".."민첩(%)"},
    ["MOD_STA"] = {"효과: "..SPELL_STAT3_NAME.."(%)", "효과: "..SPELL_STAT3_NAME.."(%)"},
    ["MOD_INT"] = {"효과: "..SPELL_STAT4_NAME.."(%)", "효과: "..SPELL_STAT4_NAME.."(%)"},
    ["MOD_SPI"] = {"효과: "..SPELL_STAT5_NAME.."(%)", "효과: "..SPELL_STAT5_NAME.."(%)"},
    ["MOD_HEALTH"] = {"효과: "..HEALTH.."(%)", "효과: HP(%)"},
    ["MOD_MANA"] = {"효과: "..MANA.."(%)", "효과: MP(%)"},
    ["MOD_ARMOR"] = {"효과: 아이템에 의한 "..ARMOR.."(%)", "효과: "..ARMOR.."(아이템)(%)"},
    ["MOD_BLOCK_VALUE"] = {"효과: 피해 방어량(%)", "효과: 방어량(%)"},
    ["MOD_DMG"] = {"효과: 공격력(%)", "효과: 공격력(%)"},
    ["MOD_DMG_TAKEN"] = {"효과: 피해량(%)", "효과: 피해량(%)"},
    ["MOD_CRIT_DAMAGE"] = {"효과: 치명타 공격력(%)", "효과: 치명타 공격력(%)"},
    ["MOD_CRIT_DAMAGE_TAKEN"] = {"효과: 치명타 피해량(%)", "효과: 치명타 피해량(%)"},
    ["MOD_THREAT"] = {"효과: 위협 수준(%)", "효과: 위협(%)"},
    ["MOD_AP"] = {"효과: ".."전투력(%)", "효과: 전투력(%)"},
    ["MOD_RANGED_AP"] = {"효과: "..PLAYERSTAT_RANGED_COMBAT.." 전투력(%)", "효과: "..PLAYERSTAT_RANGED_COMBAT.." 전투력(%)"},
    ["MOD_SPELL_PWR"] = {"효과: "..PLAYERSTAT_SPELL_COMBAT.." 공격력(%)", "효과: "..PLAYERSTAT_SPELL_COMBAT.." 공격력(%)"},
    ["MOD_HEAL"] = {"효과: 치유량(%)", "효과: 치유량(%)"},
    ["MOD_CAST_TIME"] = {"효과: 시전 시간(%)", "효과: 시전(%)"},
    ["MOD_MANA_COST"] = {"효과: 마나 소비량(%)", "효과: 마나(%)"},
    ["MOD_RAGE_COST"] = {"효과: 분노 소비량(%)", "효과: 분노(%)"},
    ["MOD_ENERGY_COST"] = {"효과: 기력 소비량(%)", "효과: 기력(%)"},
    ["MOD_COOLDOWN"] = {"효과: 재사용 대기시간(%)", "효과: 쿨타임(%)"},
    ["CRIT_TAKEN"] = {"치명타 적중률(%)", "치타"},
    ["HIT_TAKEN"] = {"적중률(%)", "적중"},
    ["CRIT_DAMAGE_TAKEN"] = {"받는 치명타 피해(%)", "받는 크리"},
    ["DMG_TAKEN"] = {"피해(%)", "피해"},
    ["CRIT_DAMAGE"] = {"치명타 피해(%)", "치타 피해"},
    ["DMG"] = {DAMAGE, DAMAGE},
    ["BLOCK_REDUCTION"] = {"Increases the amount your block stops by %1d", "Block Value", isPercent = true},

    ---------------------------------------------------------------------------
    -- Misc Stats
    ["WEAPON_RATING"] = {"무기 숙련도", "무기 숙련도"},
    ["WEAPON_SKILL"] = {"무기 숙련", "무기 숙련"},
    ["MAINHAND_WEAPON_RATING"] = {"주 장비 무기 숙련도", "주 장비 무기 숙련도"},
    ["OFFHAND_WEAPON_RATING"] = {"보조 장비 무기 숙련도", "보조 장비 무기 숙련도"},
    ["RANGED_WEAPON_RATING"] = {"원거리 무기 숙련도", "원거리 무기 숙련도"},
  },
} -- }}}
