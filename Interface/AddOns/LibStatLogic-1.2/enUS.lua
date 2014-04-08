--Include LibStatLogic's enUS.lua file before any other locales, and before LibStatLogic.lua itself.
PatternLocale = {};
DisplayLocale = {};

-- The neutral table contains all entries that are build by using a constant from GlobalStrings.lua
-- DO NOT include any hardcoded english strings here!
PatternLocale.neutral = {
	-- The entries of that table will be copied to PatternLocale.<ClientLocale>.Exclude at startup.
	-- DO NOT include any hardcoded english strings here!
	-- DO NOT include any constants here that have placeholders like %d in their value! This won't work since the
	-- Exclude entries have to match exactly!
	["NeutralExclude"] = {
		-- Binds
		[ITEM_BIND_ON_EQUIP] = true, -- "Binds when equipped"
		[ITEM_BIND_ON_PICKUP] = true, -- "Binds when picked up"
		[ITEM_BIND_ON_USE] = true, -- "Binds when used"
		[ITEM_BIND_TO_ACCOUNT] = true, -- "Binds to account"
		[ITEM_ACCOUNTBOUND] = true, -- "Account Bound"
		[ITEM_BIND_TO_BNETACCOUNT] = true, -- "Binds to Battle.net account"
		[ITEM_BNETACCOUNTBOUND] = true, -- "Battle.net Account Bound"
		[ITEM_SOULBOUND] = true, -- "Soulbound"
		
		-- Uniques
		[ITEM_UNIQUE] = true, -- "Unique"
		[ITEM_UNIQUE_EQUIPPABLE] = true, -- "Unique-Equipped"

		-- Quests
		[ITEM_BIND_QUEST] = true, -- "Quest Item"
		[ITEM_STARTS_QUEST] = true, -- "This Item Begins a Quest"
		
		-- Equip types
		[INVTYPE_2HWEAPON] = true, -- "Two-Hand"
		[INVTYPE_AMMO] = true, -- "Ammo"
		[INVTYPE_BAG] = true, -- "Bag"
		[INVTYPE_BODY] = true, -- "Shirt"
		[INVTYPE_CHEST] = true, -- "Chest"
		[INVTYPE_CLOAK] = true, -- "Back"
		[INVTYPE_FEET] = true, -- "Feet"
		[INVTYPE_FINGER] = true, -- "Finger"
		[INVTYPE_HAND] = true, -- "Hands"
		[INVTYPE_HEAD] = true, -- "Head"
		[INVTYPE_HOLDABLE] = true, -- "Held In Off-hand"
		[INVTYPE_LEGS] = true, -- "Legs"
		[INVTYPE_NECK] = true, -- "Neck"
		[INVTYPE_QUIVER] = true, -- "Quiver"
		[INVTYPE_RANGED] = true, -- "Ranged"
		[INVTYPE_RANGEDRIGHT] = true, -- "Ranged"
		[INVTYPE_RELIC] = true, -- "Relic"
		[INVTYPE_ROBE] = true, -- "Chest"
		[INVTYPE_SHIELD] = true, -- "Off Hand"
		[INVTYPE_SHOULDER] = true, -- "Shoulder"
		[INVTYPE_TABARD] = true, -- "Tabard"
		[INVTYPE_THROWN] = true, -- "Thrown"
		[INVTYPE_TRINKET] = true, -- "Trinket"
		[INVTYPE_WAIST] = true, -- "Waist"
		[INVTYPE_WEAPON] = true, -- "One-Hand"
		[INVTYPE_WEAPONMAINHAND] = true, -- "Main Hand"
		[INVTYPE_WEAPONMAINHAND_PET] = true, -- "Main Attack"
		[INVTYPE_WEAPONOFFHAND] = true, -- "Off Hand"
		[INVTYPE_WRIST] = true, -- "Wrist"
		
		-- Item quality
		[ITEM_QUALITY0_DESC] = true, -- "Poor"
		[ITEM_QUALITY1_DESC] = true, -- "Common"
		[ITEM_QUALITY2_DESC] = true, -- "Uncommon"
		[ITEM_QUALITY3_DESC] = true, -- "Rare"
		[ITEM_QUALITY4_DESC] = true, -- "Epic"
		[ITEM_QUALITY5_DESC] = true, -- "Legendary"
		[ITEM_QUALITY6_DESC] = true, -- "Artifact"
		[ITEM_QUALITY7_DESC] = true, -- "Heirloom"
		[ITEM_HEROIC] = true, -- "Heroic"
		[ITEM_HEROIC_EPIC] = true, -- "Heroic Epic"
		[ITEM_HEROIC_QUALITY0_DESC] = true, -- "Heroic Poor"
		[ITEM_HEROIC_QUALITY1_DESC] = true, -- "Heroic Common"
		[ITEM_HEROIC_QUALITY2_DESC] = true, -- "Heroic Uncommon"
		[ITEM_HEROIC_QUALITY3_DESC] = true, -- "Heroic Rare"
		[ITEM_HEROIC_QUALITY4_DESC] = true, -- "Heroic Epic"
		[ITEM_HEROIC_QUALITY5_DESC] = true, -- "Heroic Legendary"
		[ITEM_HEROIC_QUALITY6_DESC] = true, -- "Heroic Artifact"
		[ITEM_HEROIC_QUALITY7_DESC] = true, -- "Heroic Heirloom"
		[RAID_FINDER] = true, -- "Raid Finder"
		
		-- Misc
		[REFORGED] = true, -- "Reforged"
		[ITEM_CANT_BE_DESTROYED] = true, -- "That item cannot be destroyed."
		[ITEM_CONJURED] = true, -- "Conjured Item"
		[ITEM_DISENCHANT_NOT_DISENCHANTABLE] = true, -- "Cannot be disenchanted"
		[ITEM_DISENCHANT_ANY_SKILL] = true, -- "Disenchantable"
	},
	
	-- The entries of that table will be copied to PatternLocale.<ClientLocale>.StatIDLookup at startup.
	-- DO NOT include any hardcoded english strings here!
	-- DO NOT include any constants here that have placeholders like %d in their value! This won't work since the
	-- StatIDLookup entries must contain the lookup string with the values completely removed. If they have placeholders,
	-- include them in NeutralStatIDLookupWithPlaceholders!
	["NeutralStatIDLookup"] = {
		[SPELL_STATALL] = {"STR", "AGI", "STA", "INT", "SPI"}, -- "all stats"
		[SPELL_STAT1_NAME] = {"STR"}, -- "Strength"
		[SPELL_STAT2_NAME] = {"AGI"}, -- "Agility"
		[SPELL_STAT3_NAME] = {"STA"}, -- "Stamina"
		[SPELL_STAT4_NAME] = {"INT"}, -- "Intellect"
		[SPELL_STAT5_NAME] = {"SPI"}, -- "Spirit"

		[HEALTH] = {"HEALTH"}, -- "Health"
		[HP] = {"HEALTH"}, -- "HP"
		[MANA] = {"MANA"}, -- "Mana"
		[MP] = {"MANA"}, -- "MP"
		
		[DAMAGE_TOOLTIP] = {"MELEE_DMG"}, -- "Weapon Damage"
		[DAMAGE_PER_SECOND] = {"DPS"}, -- "Damage per Second"
		
		[ATTACK_POWER_TOOLTIP] = {"AP"}, -- "Attack Power"
		[ITEM_MOD_RANGED_ATTACK_POWER_SHORT] = {"RANGED_AP"}, -- "Ranged Attack Power"
		[ITEM_MOD_FERAL_ATTACK_POWER_SHORT] = {"FERAL_AP"}, -- "Attack Power In Forms"
		
		[ITEM_MOD_SPELL_POWER_SHORT] = {"SPELL_DMG", "HEAL"}, -- "Spell Power"
		[STAT_SPELLDAMAGE] = {"SPELL_DMG"}, -- "Spell Damage"
		[STAT_SPELLHEALING] = {"HEAL"}, -- "Spell Healing"
		
		[ITEM_MOD_HIT_RATING_SHORT] = {"MELEE_HIT_RATING", "RANGED_HIT_RATING", "SPELL_HIT_RATING"}, -- "Hit"
		[ITEM_MOD_HIT_MELEE_RATING_SHORT] = {"MELEE_HIT_RATING"}, -- "Hit (Melee)"
		[ITEM_MOD_HIT_RANGED_RATING_SHORT] = {"RANGED_HIT_RATING"}, -- "Hit (Ranged)"
		[ITEM_MOD_HIT_SPELL_RATING_SHORT] = {"SPELL_HIT_RATING"}, -- "Hit (Spell)"
		[ITEM_MOD_EXPERTISE_RATING_SHORT] = {"EXPERTISE_RATING"}, -- "Expertise"
		
		[ITEM_MOD_CRIT_RATING_SHORT] = {"MELEE_CRIT_RATING", "RANGED_CRIT_RATING", "SPELL_CRIT_RATING"}, -- "Critical Strike"
		[ITEM_MOD_CRIT_MELEE_RATING_SHORT] = {"MELEE_CRIT_RATING"}, -- "Critical Strike (Melee)"
		[ITEM_MOD_CRIT_RANGED_RATING_SHORT] = {"RANGED_CRIT_RATING"}, -- "Critical Strike (Ranged)"
		[ITEM_MOD_CRIT_SPELL_RATING_SHORT] = {"SPELL_CRIT_RATING"}, -- "Critical Strike (Spell)"
		
		[ITEM_MOD_HASTE_RATING_SHORT] = {"MELEE_HASTE_RATING", "RANGED_HASTE_RATING", "SPELL_HASTE_RATING"}, -- "Haste"
		[ITEM_MOD_HASTE_MELEE_RATING_SHORT] = {"MELEE_HASTE_RATING"}, -- "Haste (Melee)"
		[ITEM_MOD_HASTE_RANGED_RATING_SHORT] = {"RANGED_HASTE_RATING"}, -- "Haste (Ranged)"
		[ITEM_MOD_HASTE_SPELL_RATING_SHORT] = {"SPELL_HASTE_RATING"}, -- "Haste (Spell)"
		
		[ITEM_MOD_MASTERY_RATING_SHORT] = {"MASTERY_RATING"}, -- "Mastery"
		[ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT] = {"ARMOR_PENETRATION_RATING"}, -- "Armor Penetration"

		[ITEM_MOD_DEFENSE_SKILL_RATING_SHORT] = {"DEFENSE_RATING"}, -- "Defense"
		[ITEM_MOD_DODGE_RATING_SHORT] = {"DODGE_RATING"}, -- "Dodge"
		[ITEM_MOD_PARRY_RATING_SHORT] = {"PARRY_RATING"}, -- "Parry"
		[ITEM_MOD_BLOCK_RATING_SHORT] = {"BLOCK_RATING"}, -- "Block"
		
		[ITEM_MOD_HIT_TAKEN_RATING_SHORT] = {"MELEE_HIT_AVOID_RATING", "RANGED_HIT_AVOID_RATING", "SPELL_HIT_AVOID_RATING"}, -- "Hit Avoidance"
		[ITEM_MOD_HIT_TAKEN_MELEE_RATING_SHORT] = {"MELEE_HIT_AVOID_RATING"}, -- "Hit Avoidance (Melee)";
		[ITEM_MOD_HIT_TAKEN_RANGED_RATING_SHORT] = {"RANGED_HIT_AVOID_RATING"}, --"Hit Avoidance (Ranged)";
		[ITEM_MOD_HIT_TAKEN_SPELL_RATING_SHORT] = {"SPELL_HIT_AVOID_RATING"}, -- "Hit Avoidance (Spell)"
		
		[ITEM_MOD_CRIT_TAKEN_RATING_SHORT] = {"MELEE_CRIT_AVOID_RATING", "RANGED_CRIT_AVOID_RATING", "SPELL_CRIT_AVOID_RATING"}, -- "Critical Strike Avoidance"
		[ITEM_MOD_CRIT_TAKEN_MELEE_RATING_SHORT] = {"MELEE_CRIT_AVOID_RATING"}, -- "Critical Strike Avoidance (Melee)"
		[ITEM_MOD_CRIT_TAKEN_RANGED_RATING_SHORT] = {"RANGED_CRIT_AVOID_RATING"}, -- "Critical Strike Avoidance (Ranged)"
		[ITEM_MOD_CRIT_TAKEN_SPELL_RATING_SHORT] = {"SPELL_CRIT_AVOID_RATING"}, -- "Critical Strike Avoidance (Spell)"
		
		[ITEM_MOD_RESILIENCE_RATING_SHORT] = {"RESILIENCE_RATING"}, -- "PvP Resilience"
		[ITEM_MOD_PVP_POWER_SHORT] = {"PVP_POWER"}, -- "PvP Power"
		[ITEM_MOD_SPELL_PENETRATION_SHORT] = {"SPELLPEN"}, -- "Spell Penetration" -- Enchant Cloak - Spell Penetration
		
		[ITEM_MOD_HEALTH_REGENERATION_SHORT] = {"COMBAT_HEALTH_REGEN"}, -- "Health Regeneration"
		[ITEM_MOD_MANA_REGENERATION_SHORT] = {"COMBAT_MANA_REGEN"}, -- "Mana Regeneration"
		
		[RESISTANCE0_NAME] = {"ARMOR_BONUS"}, -- "Armor"
		[RESISTANCE1_NAME] = {"HOLY_RES"}, -- "Holy Resistance"
		[RESISTANCE2_NAME] = {"FIRE_RES"}, -- "Fire Resistance"
		[RESISTANCE3_NAME] = {"NATURE_RES"}, -- "Nature Resistance"
		[RESISTANCE4_NAME] = {"FROST_RES"}, --  "Frost Resistance"
		[RESISTANCE5_NAME] = {"SHADOW_RES"}, -- "Shadow Resistance"
		[RESISTANCE6_NAME] = {"ARCANE_RES"}, -- "Arcane Resistance"
		
		[PROFESSIONS_FISHING] = {"FISHING"}, -- "Fishing" -- Fishing enchant ID:846
	},
	
	-- The entries of that table will be copied to PatternLocale.<ClientLocale>.StatIDLookup at startup, but only after
	-- beeing cleaned so that they don't contain the placeholders any more. This cleaning happens in the function
	-- PatternLocale.<ClientLocale>.ProcessNeutralStatIDLookupPlaceholders (will fallback to the enUS function if the
	-- function is nil in the client locale).
	-- DO NOT include any hardcoded english strings here!
	-- ONLY include constants here that have placeholders like %d in their value! If they don't have placeholders,
	-- include them in NeutralStatIDLookup!
	["NeutralStatIDLookupWithPlaceholders"] = {
		[ITEM_MOD_ATTACK_POWER] = {"AP"}, -- "Increases attack power by %s."
		[ITEM_MOD_RANGED_ATTACK_POWER] = {"RANGED_AP"}, -- "Increases ranged attack power by %s." -- [High Warlord's Crossbow] ID: 18837
		[ITEM_MOD_FERAL_ATTACK_POWER] = {"FERAL_AP"}, -- "Increases attack power by %s in Cat, Bear, Dire Bear, and Moonkin forms only."
		
		[ITEM_MOD_SPELL_POWER] = {"SPELL_DMG", "HEAL"}, -- "Increases spell power by %s."
		[ITEM_MOD_SPELL_HEALING_DONE] = {"HEAL"}, -- "Increases healing done by magical spells and effects by up to %s."
		[BONUS_HEALING_TOOLTIP] = {"HEAL"}, -- "Increases your healing by up to %d"

		[ITEM_MOD_HIT_RATING] = {"MELEE_HIT_RATING", "RANGED_HIT_RATING", "SPELL_HIT_RATING"}, -- "Increases your hit by %s."
		[ITEM_MOD_HIT_MELEE_RATING] = {"MELEE_HIT_RATING"}, -- "Improves melee hit by %s."
		[ITEM_MOD_HIT_RANGED_RATING] = {"RANGED_HIT_RATING"}, -- "Improves ranged hit by %s."
		[ITEM_MOD_HIT_SPELL_RATING] = {"SPELL_HIT_RATING"}, -- "Improves spell hit by %s.
		[ITEM_MOD_EXPERTISE_RATING] = {"EXPERTISE_RATING"}, --  "Increases your expertise by %s."
		
		[ITEM_MOD_CRIT_RATING] = {"MELEE_CRIT_RATING", "RANGED_CRIT_RATING", "SPELL_CRIT_RATING"}, -- "Increases your critical strike by %s."
		[ITEM_MOD_CRIT_MELEE_RATING] = {"MELEE_CRIT_RATING"}, -- "Improves melee critical strike by %s."
		[ITEM_MOD_CRIT_RANGED_RATING] = {"RANGED_CRIT_RATING"}, -- "Improves ranged critical strike by %s."
		[ITEM_MOD_CRIT_SPELL_RATING] = {"SPELL_CRIT_RATING"}, -- "Improves spell critical strike by %s."

		[ITEM_MOD_HASTE_RATING] = {"MELEE_HASTE_RATING", "RANGED_HASTE_RATING", "SPELL_HASTE_RATING"}, -- "Increases your haste by %s."
		[ITEM_MOD_HASTE_MELEE_RATING] = {"MELEE_HASTE_RATING"}, -- "Improves melee haste by %s."
		[ITEM_MOD_HASTE_RANGED_RATING] = {"RANGED_HASTE_RATING"}, -- "Improves ranged haste by %s."
		[ITEM_MOD_HASTE_SPELL_RATING] = {"SPELL_HASTE_RATING"}, -- "Improves spell haste by %s."
		
		[ITEM_MOD_MASTERY_RATING] = {"MASTERY_RATING"}, -- "Increases your mastery by %s."
		[ITEM_MOD_ARMOR_PENETRATION_RATING] = {"ARMOR_PENETRATION_RATING"}, --"Increases your armor penetration by %s."
		
		[ITEM_MOD_DEFENSE_SKILL_RATING] = {"DEFENSE_RATING"}, -- "Increases defense by %s."
		[ITEM_MOD_DODGE_RATING] = {"DODGE_RATING"}, -- "Increases your dodge by %s."
		[ITEM_MOD_PARRY_RATING] = {"PARRY_RATING"}, -- "Increases your parry by %s."
		[ITEM_MOD_BLOCK_RATING] = {"BLOCK_RATING"}, -- "Increases your shield block by %s."

		[ITEM_MOD_HIT_TAKEN_RATING] = {"MELEE_HIT_AVOID_RATING", "RANGED_HIT_AVOID_RATING", "SPELL_HIT_AVOID_RATING"}, -- "Improves hit avoidance by %s."
		[ITEM_MOD_HIT_TAKEN_MELEE_RATING] = {"MELEE_HIT_AVOID_RATING"}, -- "Improves melee hit avoidance by %s."
		[ITEM_MOD_HIT_TAKEN_RANGED_RATING] = {"RANGED_HIT_AVOID_RATING"}, -- "Improves ranged hit avoidance by %s."
		[ITEM_MOD_HIT_TAKEN_SPELL_RATING] = {"SPELL_HIT_AVOID_RATING"}, -- "Improves spell hit avoidance by %s."
		
		[ITEM_MOD_CRIT_TAKEN_RATING] = {"MELEE_CRIT_AVOID_RATING", "RANGED_CRIT_AVOID_RATING", "SPELL_CRIT_AVOID_RATING"}, -- "Improves critical avoidance by %s."
		[ITEM_MOD_CRIT_TAKEN_MELEE_RATING] = {"MELEE_CRIT_AVOID_RATING"}, -- "Improves melee critical avoidance by %s."
		[ITEM_MOD_CRIT_TAKEN_RANGED_RATING] = {"RANGED_CRIT_AVOID_RATING"}, -- "Improves ranged critical avoidance by %s."
		[ITEM_MOD_CRIT_TAKEN_SPELL_RATING] = {"SPELL_CRIT_AVOID_RATING"}, -- "Improves spell critical avoidance by %s."

		[ITEM_MOD_RESILIENCE_RATING] = {"RESILIENCE_RATING"}, -- "Increases your pvp resilience by %s."
		[ITEM_MOD_PVP_POWER] = {"PVP_POWER"}, -- "Increases your pvp power by %s."
		[ITEM_MOD_SPELL_PENETRATION] = {"SPELLPEN"}, -- "Increases spell penetration by %s."
		
		[ITEM_MOD_HEALTH_REGEN] = {"COMBAT_HEALTH_REGEN"}, -- "Restores %s health per 5 sec." [Onyxia Blood Talisman] ID: 18406
		[ITEM_MOD_MANA_REGENERATION] = {"COMBAT_MANA_REGEN"}, -- "Restores %s mana per 5 sec."
		
		[THREAT_TOOLTIP] = {"MOD_THREAT"}, -- "%d%% Threat" -- StatLogic:GetSum("item:23344:2613")
		[ITEM_RESIST_ALL] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES"}, -- "%c%d to All Resistances"
	}
}


--These constants need to be built outside the table before they can be referenced
--9/20/2012 You can't use %p. It fails for numbers like 1,234.5 (Unit Tests caught the regression)
local LOCALE_STHOUSAND = ",";  --Character used to separate groups of digits
local LOCALE_SDECIMAL = "."; --Character(s) used for the decimal separator
local patNumber = "%d+["..LOCALE_STHOUSAND.."%d]*"; --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
local patDecimal = "%d+["..LOCALE_STHOUSAND.."%d]*"..LOCALE_SDECIMAL.."?%d*"; --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*


PatternLocale.enUS = { -- {{{
	LOCALE_STHOUSAND = LOCALE_STHOUSAND, --Character used to separate groups of digits
	LOCALE_SDECIMAL = LOCALE_SDECIMAL, --Character(s) used for the decimal separator
	
	patNumber = patNumber, --regular expression to find a localized number e.g. "1,234"  = %d+[,%d]*
	patDecimal = patDecimal, --regex to find a localized decimal number e.g. "1,234.56" = %d+[,%d]*.?%d*

	-----------------
	-- Armor Types --
	-----------------
	Plate = "Plate",
	Mail = "Mail",
	Leather = "Leather",
	Cloth = "Cloth",
	
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
		["Binds"] = true,
		
		 -- The following can't directly use the constants from GlobalStrings.lua because of placeholder patterns.
		["Disen"] = true, -- ITEM_DISENCHANT_MIN_SKILL = "Disenchanting requires %s (%d)";
		["Durat"] = true, -- ITEM_DURATION_DAYS = "Duration: %d |4day:days;";
		["<Made"] = true, -- ITEM_CREATED_BY = "|cff00ff00<Made by %s>|r";
		["Coold"] = true, -- ITEM_COOLDOWN_TIME_DAYS = "Cooldown remaining: %d |4day:days;";
		["Uniqu"] = true, -- ITEM_UNIQUE_MULTIPLE = "Unique (%d)";
		--["Uniqu"] = true, -- ITEM_LIMIT_CATEGORY = "Unique: %s (%d)"; -- Note: Please do not remove that line, it might require a own entry in a localized version.
		--["Uniqu"] = true, -- ITEM_LIMIT_CATEGORY_MULTIPLE = "Unique-Equipped: %s (%d)"; -- Note: Please do not remove that line, it might require a own entry in a localized version.
		["Requi"] = true,  -- ITEM_MIN_LEVEL = "Requires Level %d";
		["Class"] = true, -- ITEM_CLASSES_ALLOWED = "Classes: %s";
		["Races"] = true, -- ITEM_RACES_ALLOWED = "Races: %s";
		["Item "] = true, -- ITEM_LEVEL = "Item Level %d";
		["Upgra"] = true, -- 5.1.0: ITEM_UPGRADE_TOOLTIP_FORMAT = "Upgrade Level: %d/%d"; e.g.: "Upgrade Level: 0/2"
		["Set: "] = true, -- ITEM_SET_BONUS = "Set: %s";
		["(2) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(3) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(4) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(5) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(6) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(7) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		["(8) S"] = true, -- ITEM_SET_BONUS_GRAY = "(%d) Set: %s";
		
		-- The following can't directly use the constants from GlobalStrings.lua because they are just the beginning of the line.
		["Use: "] = true, -- ITEM_SPELL_TRIGGER_ONUSE = "Use:";
		["Chanc"] = true, -- ITEM_SPELL_TRIGGER_ONPROC = "Chance on hit:";
		
		-- Misc
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

		["Ferocity"] = {["AP"] = 34, ["MELEE_HIT_RATING"] = 16, ["SPELL_HIT_RATING"] = 16 }, --ID: 35452  Ferocity
		["Savagery"] = {["AP"] = 70}, --ID: 27971  Savagry +70 Attack Power

		["Minor Wizard Oil"] = {["SPELL_DMG"] = 8, ["HEAL"] = 8}, -- ID: 20744  Minor Wizard Oil
		["Lesser Wizard Oil"] = {["SPELL_DMG"] = 16, ["HEAL"] = 16}, -- ID: 20746  Lesser Wizard Oil
		["Wizard Oil"] = {["SPELL_DMG"] = 24, ["HEAL"] = 24}, -- ID: 20750  Wizard Oil
		["Brilliant Wizard Oil"] = {["SPELL_DMG"] = 36, ["HEAL"] = 36, ["SPELL_CRIT_RATING"] = 14}, -- ID: 20749  Brilliant Wizard Oil
		["Superior Wizard Oil"] = {["SPELL_DMG"] = 42, ["HEAL"] = 42}, -- ID: 22522
		["Blessed Wizard Oil"] = {["SPELL_DMG_UNDEAD"] = 60}, -- ID: 23123
		
		["Enchanted: Heartsong"] = false, -- Enchant 4084
		["Enchanted: Power Torrent"] = false, --20120915 Enchant 4907  /dump StatLogic:GetSum("item:77196:4097:0:0:0:0:0:0")
		["Enchanted: Windwalk"] = false, --Enchant 4098    Windwalk: Permanently enchant a weapon to sometimes increase dodge rating by 600 and movement speed by 15% for 10 sec
		["Enchanted: Landslide"] = false, --20120915 EnchantID 4099   /dump StatLogic:GetSum("item:77196:4099:0:0:0:0:0:0")
		["Enchanted: Berserking"] = false,
		["Enchanted: Windsong"] = false,
		["Enchanted: Jade Spirit"] = false,
		["Enchanted: Dancing Steel"] = false,
		["Enchanted: Elemental Force"] = false,
		["Flintlocke's Woodchucker"] = false, --ItemID: 70139  Flintlocke's Woodchucker

		["Minor Mana Oil"] = {["COMBAT_MANA_REGEN"] = 4}, -- ID: 20745
		["Lesser Mana Oil"] = {["COMBAT_MANA_REGEN"] = 8}, -- ID: 20747
		["Brilliant Mana Oil"] = {["COMBAT_MANA_REGEN"] = 12, ["HEAL"] = 25}, -- ID: 20748
		["Superior Mana Oil"] = {["COMBAT_MANA_REGEN"] = 14}, -- ID: 22521

		--["Eternium Line"] = {["FISHING"] = 5}, -- +5 Fishing
		--["Vitality"] = {["COMBAT_MANA_REGEN"] = 4, ["COMBAT_HEALTH_REGEN"] = 4}, -- +4 Mana and Health every 5 sec
		--["Soulfrost"] = {["SHADOW_SPELL_DMG"] = 54, ["FROST_SPELL_DMG"] = 54}, -- Changed to +54 Shadow and Frost Spell Power
		--["Sunfire"] = {["ARCANE_SPELL_DMG"] = 50, ["FIRE_SPELL_DMG"] = 50}, -- Changed to +50 Arcane and Fire Spell Power

		--["Mithril Spurs"] = {["MOUNT_SPEED"] = 4}, -- Mithril Spurs  +4% Mount Speed
		--["Minor Mount Speed Increase"] = {["MOUNT_SPEED"] = 2}, -- Enchant Gloves - Riding Skill  +2% Mount Speed
		["Equip: Run speed increased slightly."] = {["RUN_SPEED"] = 8}, -- [Highlander's Plate Greaves] ID: 20048
		["Minor Speed Increase"] = {["RUN_SPEED"] = 8}, -- SpellID: 13890  EnchantID: 911 Enchant Boots - Minor Speed "Minor Speed Increase"
		["Minor Speed"] = {["RUN_SPEED"] = 8}, -- SpellID: 34007  EnchantID: 2939 Enchant Boots - Cat's Swiftness "Minor Speed and +6 Agility"
		["Minor Run Speed Increase"] = {["RUN_SPEED"] = 8}, -- 
		["Minor Movement Speed"] = {["RUN_SPEED"] = 8}, --SpellID: 74189  EnchantID: 4062  "+30 Stamina and Minor Movement Speed"

		--["Surefooted"] = {["MELEE_HIT_RATING"] = 10, ["SPELL_HIT_RATING"] = 10, ["MELEE_CRIT_RATING"] = 10, ["SPELL_CRIT_RATING"] = 10}, -- EnchantID: 2658 Enchant Boots - Surefooted

		--["Subtlety"] = {["MOD_THREAT"] = -2}, -- EnchantID: 2621 Enchant Cloak - Subtlety
		["2% Reduced Threat"] = {["MOD_THREAT"] = -2}, -- EnchantID: 2621, 2832, 3296
		["Equip: Allows underwater breathing."] = false, -- [Band of Icy Depths] ID: 21526
		["Allows underwater breathing"] = false, --
		["Equip: Immune to Disarm."] = false, -- [Stronghold Gauntlets] ID: 12639
		["Immune to Disarm"] = false, --
		["Crusader"] = false, -- Enchant Crusader
		["Lifestealing"] = false, -- Lifestealing 
		["Hurricane"] = false, -- EnchantID: 4083 
		["Mending"] = false, -- SpellID: 74195  EnchantID: 4066
		["Lightweave Embroidery"] = false, -- spell=75171
		["Gnomish X-Ray Scope"] = false, -- item=59594
		["Rune of the Fallen Crusader"] = false,

		--["Tuskar's Vitality"] = {["RUN_SPEED"] = 8, ["STA"] = 15}, -- EnchantID: 3232 +15 Stamina and Minor Speed Increase
		--["Wisdom"] = {["MOD_THREAT"] = -2, ["SPI"] = 10}, -- EnchantID: 3296 +10 Spirit and 2% Reduced Threat
		--["Accuracy"] = {["MELEE_HIT_RATING"] = 25, ["SPELL_HIT_RATING"] = 25, ["MELEE_CRIT_RATING"] = 25, ["SPELL_CRIT_RATING"] = 25}, -- EnchantID: 3788 +25 Hit Rating and +25 Critical Strike Rating
		--["Scourgebane"] = {["AP_UNDEAD"] = 140}, -- EnchantID: 3247 +140 Attack Power versus Undead
		--["Icewalker"] = {["MELEE_HIT_RATING"] = 12, ["SPELL_HIT_RATING"] = 12, ["MELEE_CRIT_RATING"] = 12, ["SPELL_CRIT_RATING"] = 12}, -- EnchantID: 3826 +12 Hit Rating and +12 Critical Strike Rating
		["Gatherer"] = {["HERBALISM"] = 5, ["MINING"] = 5, ["SKINNING"] = 5}, -- EnchantID: 3296
		--["Greater Vitality"] = {["COMBAT_MANA_REGEN"] = 6, ["COMBAT_HEALTH_REGEN"] = 6}, -- EnchantID: 3244 +7 Health and Mana every 5 sec

		--["+37 Stamina and +20 Defense"] = {["STA"] = 37, ["DEFENSE_RATING"] = 20}, -- EnchantID: 3818 Defense does not equal Defense Rating...
		["Rune of Swordbreaking"] = {["PARRY"] = 2}, -- EnchantID: 3594
		["Rune of Swordshattering"] = {["PARRY"] = 4}, -- EnchantID: 3365
		["Rune of the Stoneskin Gargoyle"] = {["MOD_ARMOR"] = 4, ["MOD_STA"] = 2}, -- EnchantID: 3847
		["Rune of the Nerubian Carapace"] = {["MOD_ARMOR"] = 2, ["MOD_STA"] = 1}, -- EnchantID: 3883

		--These are so rare to come across, who actually cares:
		["Equip: Guaranteed by Belbi Quikswitch to make EVERYONE look attractive!"] = false, --ID: 33047  Belbi's Eyesight Enhancing Romance Goggles
		["Equip: When worn with the Twilight Trappings Set, allows access to a Wind Stone in Silithus."] = false,
		["Equip: Succumb to the curse of Burgy Blackheart."] = false, --20120915 ID: 65665 Burgy Blackheart's Handsome Hat
		["Equip: Allows you to cook faster."] = false, --20120915 ID; 46349  /dump StatLogic:SetTip("item:46349")
		["Equip: Your attacks may occasionally attract small celestial objects."] = false, --20120915 ID: 70144   Ricket's Magnetic Fireball  /dump StatLogic:GetSum("item:70144")
		["Equip: Improves the range of your Shock and Wind Shear spells by 5 yards."] = false, --20120915 ID=51510 (among others) /dump StatLogic:GetSum("item:51510")
		["Equip: Your melee attacks grant 78 Strength for the next 10 sec, stacking up to 10 times."] = false, --ID: 77977  Eye of Unmaking
		["Equip: Allows you to see additional mining nodes and herbs while in Pandaria."] = false, --ID: 87213 Mist-Piercing Goggles
		["Equip: Protects the wearer from being fully engulfed by Shadow Flame."] = false, --ID:15138 Onyxia Scale Cloak
		--["Equip: Fishing skill increased by 30."] = {["FISHING"] = 30}, -- +30 Fishing  ID: 44050  Mastercraft Kalu'ak Fishing Pole   This should already be handled by skill lookups

		["Heals you for 2% of your maximum health whenever you kill a target that yields experience or honor"] = false, --Heirlooms ("Equip: Heals you for 2% of your maximum health whenever you kill a target that yields experience or honor.")
		["Restores 2% of your maximum mana whenever you kill a target that yields experience or honor"] = false, --Heirlooms ("Equip: Restores 2% of your maximum mana whenever you kill a target that yields experience or honor.")

		["Equip: Grants 39 mastery for 10 sec each time you deal periodic spell damage, stacking up to 10 times."] = false, --ItemID: 68982  Necromantic Focus

		--***************
		--*** Removed ***
		--***************
		--removed these "have a chance to" items because the new PreScan item should catch them all.
		--["Equip: Your melee attacks have a chance to cause you to summon a Tentacle of the Old Ones to fight by your side for 12 sec."] = false, --ID: 77191  Gurthalak, Voice of the Deeps
		--["Equip: Your melee attacks have a chance to trigger a whirlwind attack dealing 8029 to 12044 physical damage to all targets within 10 yards."] = false, --ID: 77982  Bone-Link Fetish
		--["Equip: When you heal you have a chance to gain 2904 haste rating for 20 sec."] = false, --ID: 77204  Seal of the Seven Signs
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

	-- 5.1 Landfall added "(Reforged from Xxx)" next to the +Stat items, e.g.:
	--		+384 Strength (Reforged from Parry)
	--		+1,234 Stamina (Reforged from Critical Strike)
	-- 5.1 also changed enchantments to "Enchanted: %s" (e.g. "Enchanted: +170 Strength"),
	-- therefore this pattern should not be limited to the start of the line (start with "^") to also match enchants.
	--["SinglePlusStatCheck"] = "(([%+%-][%d]+)%s([%s%a]+[%a]+)%s*(%(?[%a%s]*%)?))%s?",  --from http://stackoverflow.com/questions/13619193/greed-non-greedy-pattern-matching-and-optional-suffixes-in-lua#13619193
	--["SinglePlusStatCheck"] = "(([%+%-]"..patNumber..")%s([%s%a]+[%a]+)%s*(%(?[%a%s]*%)?))%s?",
	["SinglePlusStatCheck"] =   "(([%+%-]"..patNumber..")%s([%s%a%d]+[%a]+)%.?%s*(%(?[%a%s]*%)?))%s?",

	-----------------------------
	-- Single Equip Stat Check --
	-----------------------------
	-- stat1, value, stat2 = strfind
	-- stat = stat1..stat2
	-- "^Equip: (.-) by u?p? ?t?o? ?(%d+) ?(.-)%.?$"
	["SingleEquipStatCheck"] = "^"..ITEM_SPELL_TRIGGER_ONEQUIP.." (.-) by u?p? ?t?o? ?("..patNumber..") ?(.-)%.?$",

	-------------
	-- PreScan --
	-------------
	-- Its preferable to have as few "PreScanPatterns" as possible, only use this table if all other methods fail.
	-- Special cases that need to be dealt with before deep scan
	["PreScanPatterns"] = {
		--["^Equip: Increases attack power by (%d+) in Cat"] = "FERAL_AP",
		--["^Equip: Increases attack power by (%d+) when fighting Undead"] = "AP_UNDEAD", -- Seal of the Dawn ID:13029
		["^("..patNumber..") Armor$"] = "ARMOR",
		["Increases your mastery rating by ("..patNumber..").-%)$"] = "MASTERY_RATING",
		["%d+ secs?[,%.]"] = false, -- Procs
		["Reinforced %(%+(%d+) Armor%)"] = "ARMOR_BONUS",
		["Mana Regen (%d+) per 5 sec%.$"] = "COMBAT_MANA_REGEN",
		["^%+?"..patDecimal.." %- ("..patDecimal..") .-Damage$"] = "MAX_DAMAGE",  --e.g. "763.04 - 1,144 Damage", "221.34 - 411.06 Damage"
		["^%(("..patDecimal..") damage per second%)$"] = "DPS", --e.g. "(1,103 damage per second)"

		["^%+("..patDecimal..")%% Mount Speed$"] = "MOD_MOUNT_SPEED", --e.g. "+4% Mount Speed"

		-- Exclude
		["^(%d+) Slot"] = false, -- Bags
		["^[%a '%-]+%((%d+)/%d+%)$"] = false, -- Set Name (0/9)
		["|cff808080"] = false, -- Gray text "  |cff808080Requires at least 2 Yellow gems|r\n  |cff808080Requires at least 1 Red gem|r"
		-- Procs
		--["[Cc]hance"] = false, -- [Mark of Defiance] ID:27924 -- [Staff of the Qiraji Prophets] ID:21128 -- Commented out because it was blocking [Insightful Earthstorm Diamond]
		["[Ss]ometimes"] = false, -- [Darkmoon Card: Heroism] ID:19287
		["[Ww]hen struck in combat"] = false, -- [Essence of the Pure Flame] ID: 18815
		["^Increases attack power by (%d+) in Cat, Bear, Dire Bear, and Moonkin forms only%.$"] = "FERAL_AP", -- 3.0.8 FAP change
		
		--Reputation tabbard
		["^Equip: You champion the cause.-"] = false,
				--"Equip: You champion the cause of Gnomeregan. All reputation gains while in dungeons will be applied to your standing with them."
				--"Equip: You champion the causes of your guild. All guild reputation gains are increased by 100%.

		--We don't handle anything that has a chance to proc
		--[[
			Equip: Your melee attacks have a chance to cause you to summon a Tentacle of the Old Ones to fight by your side for 12 sec.
			Equip: Your melee attacks have a chance to trigger a whirlwind attack dealing 8029 to 12044 physical damage to all targets within 10 yards.
			Equip: When you heal you have a chance to gain 2904 haste rating for 20 sec.
			Equip: Your spells have a chance to grant you 1,962 haste for 10 sec and 392 haste to up to 3 allies within 20 yards.
		--]]
		["^Equip: .- (have a chance to) .-"] = false, 
	},

	--------------
	-- DeepScan --
	--------------
	-- Strip leading "Equip: ", "Socket Bonus: "
	[ITEM_SPELL_TRIGGER_ONEQUIP] = ITEM_SPELL_TRIGGER_ONEQUIP, -- ITEM_SPELL_TRIGGER_ONEQUIP = "Equip:";
	["Socket Bonus: "] = "Socket Bonus: ", -- ITEM_SOCKET_BONUS = "Socket Bonus: %s"; -- Tooltip tag for socketed item matched socket bonuses
	-- Strip trailing "."
	["."] = ".",
	["DeepScanSeparators"] = {
		"/", -- "+10 Defense Rating/+10 Stamina/+15 Block Value": ZG Enchant
		" & ", -- "+26 Healing Spells & 2% Reduced Threat": Bracing Earthstorm Diamond ID:25897
		", ", -- "+6 Spell Damage, +5 Spell Crit Rating": Potent Ornate Topaz ID: 28123
		"%. ", -- "Equip: Increases attack power by 81 when fighting Undead. It also allows the acquisition of Scourgestones on behalf of the Argent Dawn.": Seal of the Dawn
		"\n", -- Meta Gems
	},
	["DeepScanWordSeparators"] = {
		" and ", -- "Critical Rating +6 and Dodge Rating +5": Assassin's Fire Opal ID:30565
	},
	--9/20/2012: TODO: convert these %d+ to use patDecimal
	["DualStatPatterns"] = { -- all lower case
		["^%+(%d+) healing and %+(%d+) spell damage$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^%+(%d+) healing %+(%d+) spell damage$"] = {{"HEAL",}, {"SPELL_DMG",},},
		["^increases healing done by up to (%d+) and damage done by up to (%d+) for all magical spells and effects$"] = {{"HEAL",}, {"SPELL_DMG",},},
	},
	["DeepScanPatterns"] = {
		"^(.-) by u?p? ?t?o? ?(%d+) ?(.-)$", -- "xxx by up to 22 xxx" (scan first)
		"^(.-) ?([%+%-]%d+) ?(.-)$", -- "xxx xxx +22" or "+22 xxx xxx" or "xxx +22 xxx" (scan 2ed)
		"^(.-) ?([%d%.]+) ?(.-)$", -- 22.22 xxx xxx (scan last)
	},
	
	-----------------------
	-- Stat Lookup Table --
	-----------------------
	-- Please DO NOT include any strings here that are available as constant in GlobalStrings.lua.
	-- Instead include them in the NeutralStatIDLookup or NeutralStatIDLookupWithPlaceholders table in the enUS.lua file so other locales can use them too.
	["StatIDLookup"] = {
		["% Shield Block Value"] = {"MOD_BLOCK_VALUE"}, --  "% Shield Block Value"[Eternal Earthsiege Diamond] ID: 41396
		["Scope (Damage)"] = {"RANGED_DMG"}, -- Khorium Scope EnchantID: 2723
		["Scope (Critical Strike Rating)"] = {"RANGED_CRIT_RATING"}, -- Stabilized Eternium Scope EnchantID: 2724
		["Your attacks ignoreof your opponent's armor"] = {"IGNORE_ARMOR"}, -- StatLogic:GetSum("item:33733")
		["Increases your effective stealth level"] = {"STEALTH_LEVEL"}, -- [Nightscape Boots] ID: 8197

		["Arcane Resist"] = {"ARCANE_RES",}, -- Arcane Armor Kit +8 Arcane Resist
		["Fire Resist"] = {"FIRE_RES",}, -- Flame Armor Kit +8 Fire Resist
		["Nature Resist"] = {"NATURE_RES",}, -- Frost Armor Kit +8 Frost Resist
		["Frost Resist"] = {"FROST_RES",}, -- Nature Armor Kit +8 Nature Resist
		["Shadow Resist"] = {"SHADOW_RES",}, -- Shadow Armor Kit +8 Shadow Resist
		["Shadow resistance"] = {"SHADOW_RES",}, -- Demons Blood ID: 10779
		["All Resistances"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		--["Resist All"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},
		--["to All Resistances"] = {"ARCANE_RES", "FIRE_RES", "FROST_RES", "NATURE_RES", "SHADOW_RES",},

		["Fishing skill increased"] = {"FISHING"}, --Weather-Beaten Fishing Hat "Equip: Fishing skill increased by 5."
		["Mining"] = {"MINING",}, -- Mining enchant ID:844
		["Mining; does not need to be equipped"] = {"MINING"}, --ID: 2901 Mining Pick  "+10 Mining; does not need to be equipped." added in 5.0.4
		["Herbalism"] = {"HERBALISM",}, -- Herbalism enchant ID:845
		["Herbalism; does not need to be equipped"] = {"HERBALISM",}, -- ID:85663 Herbalist's Spade
		["Skinning"] = {"SKINNING",}, -- Skinning enchant ID:865
		["Skinning; does not need to be equipped"] = {"SKINNING",}, -- ID:7005 Skinning Knife
		["Skinning skill increased"] = {"SKINNING",}, --20120915 ID: 12709  Finkle's Skinner
		
		["Attack Power when fighting Undead"] = {"AP_UNDEAD",},
		["Attack Power versus Undead"] = {"AP_UNDEAD",}, -- Scourgebane EnchantID: 3247
		-- [Wristwraps of Undead Slaying] ID:23093
		["Increases attack powerwhen fighting Undead"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Increases attack powerwhen fighting Undead.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"AP_UNDEAD",}, -- [Seal of the Dawn] ID:13209
		["Increases attack powerwhen fighting Demons"] = {"AP_DEMON",},
		["Increases attack powerwhen fighting Undead and Demons"] = {"AP_UNDEAD", "AP_DEMON",}, -- [Mark of the Champion] ID:23206

		["Healing and Spell Damage"] = {"SPELL_DMG", "HEAL",}, -- Arcanum of Focus +8 Healing and Spell Damage http://wow.allakhazam.com/db/spell.html?wspell=22844
		["Damage and Healing Spells"] = {"SPELL_DMG", "HEAL",},
		["Spell Damage and Healing"] = {"SPELL_DMG", "HEAL",},
		["Increases damage and healing done by magical spells and effects"] = {"SPELL_DMG", "HEAL"},
		["Increases damage and healing done by magical spells and effects of all party members within 30 yards"] = {"SPELL_DMG", "HEAL"}, -- Atiesh
		["Spell Damage and Healing"] = {"SPELL_DMG", "HEAL",}, --StatLogic:GetSum("item:22630")
		["Damage"] = {"SPELL_DMG",},
		["Holy Damage"] = {"HOLY_SPELL_DMG",},
		["Arcane Damage"] = {"ARCANE_SPELL_DMG",},
		["Fire Damage"] = {"FIRE_SPELL_DMG",},
		["Nature Damage"] = {"NATURE_SPELL_DMG",},
		["Frost Damage"] = {"FROST_SPELL_DMG",},
		["Shadow Damage"] = {"SHADOW_SPELL_DMG",},
		["Holy Spell Damage"] = {"HOLY_SPELL_DMG",},
		["Arcane Spell Damage"] = {"ARCANE_SPELL_DMG",},
		["Fire Spell Damage"] = {"FIRE_SPELL_DMG",},
		["Nature Spell Damage"] = {"NATURE_SPELL_DMG",},
		["Frost Spell Damage"] = {"FROST_SPELL_DMG",}, -- Acrobatic Staff of Frozen Wrath ID:3185:0:0:0:0:0:1957
		["Shadow Spell Damage"] = {"SHADOW_SPELL_DMG",},
		["Shadow and Frost Spell Power"] = {"SHADOW_SPELL_DMG", "FROST_SPELL_DMG",}, -- Soulfrost
		["Arcane and Fire Spell Power"] = {"ARCANE_SPELL_DMG", "FIRE_SPELL_DMG",}, -- Sunfire
		["Increases damage done by Shadow spells and effects"] = {"SHADOW_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["Increases damage done by Frost spells and effects"] = {"FROST_SPELL_DMG",}, -- Frozen Shadoweave Vest ID:21871
		["Increases damage done by Holy spells and effects"] = {"HOLY_SPELL_DMG",},
		["Increases damage done by Arcane spells and effects"] = {"ARCANE_SPELL_DMG",},
		["Increases damage done by Fire spells and effects"] = {"FIRE_SPELL_DMG",},
		["Increases damage done by Nature spells and effects"] = {"NATURE_SPELL_DMG",},
		["Increases the damage done by Holy spells and effects"] = {"HOLY_SPELL_DMG",}, -- Drape of the Righteous ID:30642
		["Increases the damage done by Arcane spells and effects"] = {"ARCANE_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Fire spells and effects"] = {"FIRE_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Frost spells and effects"] = {"FROST_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Nature spells and effects"] = {"NATURE_SPELL_DMG",}, -- Added just in case
		["Increases the damage done by Shadow spells and effects"] = {"SHADOW_SPELL_DMG",}, -- Added just in case

		--PvP, per-class, item bonuses
		["Increases the damage dealt by your Crusader Strike ability%"] = false, ----Equip: Increases the damage dealt by your Crusader Strike ability by 5%.
		["Increases the critical effect chance of your Flash of Light%"] = false, --Equip: Increases the critical effect chance of your Flash of Light by 2%."
		["Increases the Holy damage of your Judgments"] = false, --Level 60 legacy armor: Blood Guard's Lamellar Guantlets  "Equip: Increases the Holy damage of your Judgements by 20."
		
		["Increases damage done to Undead by magical spells and effects"] = {"SPELL_DMG_UNDEAD"}, -- [Robe of Undead Cleansing] ID:23085
		["Increases damage done to Undead by magical spells and effects.  It also allows the acquisition of Scourgestones on behalf of the Argent Dawn"] = {"SPELL_DMG_UNDEAD"}, -- [Rune of the Dawn] ID:19812
		["Increases damage done to Undead and Demons by magical spells and effects"] = {"SPELL_DMG_UNDEAD", "SPELL_DMG_DEMON"}, -- [Mark of the Champion] ID:23207

		["Healing Spells"] = {"HEAL",}, -- Enchant Gloves - Major Healing "+35 Healing Spells" http://wow.allakhazam.com/db/spell.html?wspell=33999
		["Increases Healing"] = {"HEAL",},
		["Healing"] = {"HEAL",}, -- StatLogic:GetSum("item:23344:206")
		["healing Spells"] = {"HEAL",},
		["Damage Spells"] = {"SPELL_DMG",}, -- 2.3.0 StatLogic:GetSum("item:23344:2343")
		["Healing Spells"] = {"HEAL",}, -- [Royal Nightseye] ID: 24057
		["Increases healing done"] = {"HEAL",}, -- 2.3.0
		["damage donefor all magical spells"] = {"SPELL_DMG",}, -- 2.3.0
		["Increases healing done by magical spells and effects of all party members within 30 yards"] = {"HEAL",}, -- Atiesh

		["Cooking skill increased"] = {"COOKING",}, --"Cooking skill increased by 10". For use with SingleEquipStatCheck
		
		-- Exclude
		["sec"] = false,
		["to"] = false,
		["Increases ranged attack speed"] = false, -- AV quiver
		["Experience gained is increased%"] = false, -- Heirlooms  e.g. /sl analyze 42984  Preened Ironfeather Shoulders
		["Experience gained from killing monsters and completing quests increased%"] = false, -- Heirlooms  e.g. /sl analyze 62040  Ancient Bloodmoon Cloak
	},
} -- }}}

function PatternLocale.enUS.ProcessNeutralStatIDLookupPlaceholders(statIDLookupWithPlaceholders, targetStatIDLookup)
	for k, v in pairs(statIDLookupWithPlaceholders) do
		-- "%%" -> "%"
		local newKey = gsub(k, "%%%%", "%%")
		-- Remove tailing .
		newKey = gsub(newKey, "%.$", "")
		-- Remove <space><+-><"%d", "%s", "%c", "%g", "%2$d", "%.2f">
		newKey = gsub(newKey, " ?[%+%-]?%%%d?%.?%d?%$?[cdsgf]", "")
		-- Remove " by" or " by up to". This is important for a match with SingleEquipStatCheck.
		-- If you don't remove it, it might still work, but then it will use a DeepScanPattern.
		newKey = gsub(newKey, " by ?u?p? ?t?o?", "")
		
		--print("'"..k.."'")
		--print("'"..newKey.."'")
		targetStatIDLookup[newKey] = v
	end
end

DisplayLocale.enUS = { -- {{{
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
		["MOD_THREAT"] = {"Threat", "Threat", isPercent = true},
		["STEALTH_LEVEL"] = {"Stealth Level", "Stealth", isPercent = true},
		["MELEE_DMG"] = {"Melee Weapon "..DAMAGE, "Wpn Dmg", isPercent = true}, -- DAMAGE = "Damage"
		["RANGED_DMG"] = {"Ranged Weapon "..DAMAGE, "Ranged Dmg", isPercent = true}, -- DAMAGE = "Damage"
		["MOUNT_SPEED"] = {"Mount Speed", "Mount Spd", isPercent = true},
		["RUN_SPEED"] = {"Run Speed", "Run Spd", isPercent = true},

		["STR"] = {SPELL_STAT1_NAME, "Str"},
		["AGI"] = {SPELL_STAT2_NAME, "Agi"},
		["STA"] = {SPELL_STAT3_NAME, "Sta"},
		["INT"] = {SPELL_STAT4_NAME, "Int"},
		["SPI"] = {SPELL_STAT5_NAME, "Spi"},
		["ARMOR"] = {ARMOR, ARMOR},
		["ARMOR_BONUS"] = {"Bonus "..ARMOR, "Bonus "..ARMOR},

		["FIRE_RES"] = {RESISTANCE2_NAME, "FR"},
		["NATURE_RES"] = {RESISTANCE3_NAME, "NR"},
		["FROST_RES"] = {RESISTANCE4_NAME, "FrR"},
		["SHADOW_RES"] = {RESISTANCE5_NAME, "SR"},
		["ARCANE_RES"] = {RESISTANCE6_NAME, "AR"},

		["FISHING"] = {"Fishing", "Fishing"},
		["MINING"] = {"Mining", "Mining"},
		["HERBALISM"] = {"Herbalism", "Herbalism"},
		["SKINNING"] = {"Skinning", "Skinning"},

		["BLOCK_VALUE"] = {"Block Value", "Block Value"},

		["AP"] = {ATTACK_POWER_TOOLTIP, "AP"},
		["RANGED_AP"] = {RANGED_ATTACK_POWER, "RAP"},
		["FERAL_AP"] = {"Feral "..ATTACK_POWER_TOOLTIP, "Feral AP"},
		["AP_UNDEAD"] = {ATTACK_POWER_TOOLTIP.." (Undead)", "AP(Undead)"},
		["AP_DEMON"] = {ATTACK_POWER_TOOLTIP.." (Demon)", "AP(Demon)"},

		["HEAL"] = {"Healing", "Heal"},

		["SPELL_POWER"] = {STAT_SPELLPOWER, STAT_SPELLPOWER},
		["SPELL_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, PLAYERSTAT_SPELL_COMBAT.." Dmg"},
		["SPELL_DMG_UNDEAD"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Undead)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(Undead)"},
		["SPELL_DMG_DEMON"] = {PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE.." (Demon)", PLAYERSTAT_SPELL_COMBAT.." Dmg".."(Demon)"},
		["HOLY_SPELL_DMG"] = {SPELL_SCHOOL1_CAP.." "..DAMAGE, SPELL_SCHOOL1_CAP.." Dmg"},
		["FIRE_SPELL_DMG"] = {SPELL_SCHOOL2_CAP.." "..DAMAGE, SPELL_SCHOOL2_CAP.." Dmg"},
		["NATURE_SPELL_DMG"] = {SPELL_SCHOOL3_CAP.." "..DAMAGE, SPELL_SCHOOL3_CAP.." Dmg"},
		["FROST_SPELL_DMG"] = {SPELL_SCHOOL4_CAP.." "..DAMAGE, SPELL_SCHOOL4_CAP.." Dmg"},
		["SHADOW_SPELL_DMG"] = {SPELL_SCHOOL5_CAP.." "..DAMAGE, SPELL_SCHOOL5_CAP.." Dmg"},
		["ARCANE_SPELL_DMG"] = {SPELL_SCHOOL6_CAP.." "..DAMAGE, SPELL_SCHOOL6_CAP.." Dmg"},

		["SPELLPEN"] = {PLAYERSTAT_SPELL_COMBAT.." "..SPELL_PENETRATION, SPELL_PENETRATION},

		["HEALTH"] = {HEALTH, HP},
		["MANA"] = {MANA, MP},
		["HEALTH_REGEN"] = {HEALTH.." Regen (Normal)", "HP5(OC)"},
		["MANA_REGEN"] = {MANA.." Regen (Normal)", "MP5(OC)"},
		["COMBAT_HEALTH_REGEN"] = {HEALTH.." Regen (Combat)", "HP5"},
		["COMBAT_MANA_REGEN"] = {MANA.." Regen (Combat)", "MP5"},

		["MAX_DAMAGE"] = {"Max Damage", "Max Dmg"},
		["DPS"] = {"Damage Per Second", "DPS"},

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
		["RANGED_CRIT_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_RANGED_COMBAT.." "..COMBAT_RATING_NAME9},
		["SPELL_CRIT_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9, PLAYERSTAT_SPELL_COMBAT.." "..COMBAT_RATING_NAME9},
		["MELEE_CRIT_AVOID_RATING"] = {"Crit Avoidance "..RATING, "Crit Avoidance "..RATING},
		["RANGED_CRIT_AVOID_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance "..RATING},
		["SPELL_CRIT_AVOID_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING, PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance "..RATING},
		["RESILIENCE_RATING"] = {COMBAT_RATING_NAME15, COMBAT_RATING_NAME15}, -- COMBAT_RATING_NAME15 = "Resilience"
		["MELEE_HASTE_RATING"] = {"Haste "..RATING, "Haste "..RATING}, --
		["RANGED_HASTE_RATING"] = {PLAYERSTAT_RANGED_COMBAT.." Haste "..RATING, PLAYERSTAT_RANGED_COMBAT.." Haste "..RATING},
		["SPELL_HASTE_RATING"] = {PLAYERSTAT_SPELL_COMBAT.." Haste "..RATING, PLAYERSTAT_SPELL_COMBAT.." Haste "..RATING},
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
		["EXPERTISE_RATING"] = {"Expertise "..RATING, "Expertise "..RATING},
		--["EXPERTISE_RATING"] = {STAT_EXPERTISE.." "..RATING, STAT_EXPERTISE.." "..RATING},
		["ARMOR_PENETRATION_RATING"] = {"Armor Penetration "..RATING, "ArP "..RATING},
		["MASTERY_RATING"] = {"Mastery "..RATING, "Mastery "..RATING},

		---------------------------------------------------------------------------
		-- Tier2 Stats - Stats that only show up when broken down from a Tier1 stat
		-- Str -> AP, Block Value
		-- Agi -> AP, Crit, Dodge
		-- Sta -> Health
		-- Int -> Mana, Spell Crit
		-- Spi -> mp5nc, hp5oc
		-- Ratings -> Effect
		["MELEE_CRIT_DMG_REDUCTION"] = {"Crit Damage Reduction", "Crit Dmg Reduc", isPercent = true},
		["RANGED_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage Reduction", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg Reduc", isPercent = true},
		["SPELL_CRIT_DMG_REDUCTION"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage Reduction", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg Reduc", isPercent = true},
		["DEFENSE"] = {DEFENSE, "Def"},
		["DODGE"] = {DODGE, DODGE, isPercent = true},
		["PARRY"] = {PARRY, PARRY, isPercent = true},
		["BLOCK"] = {BLOCK, BLOCK, isPercent = true},
		["AVOIDANCE"] = {"Avoidance", "Avoidance", isPercent = true},
		["MELEE_HIT"] = {"Hit Chance", "Hit", isPercent = true},
		["RANGED_HIT"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Chance", PLAYERSTAT_RANGED_COMBAT.." Hit", isPercent = true},
		["SPELL_HIT"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Chance", PLAYERSTAT_SPELL_COMBAT.." Hit", isPercent = true},
		["MELEE_HIT_AVOID"] = {"Hit Avoidance", "Hit Avd", isPercent = true},
		["RANGED_HIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Hit Avoidance", PLAYERSTAT_RANGED_COMBAT.." Hit Avd", isPercent = true},
		["SPELL_HIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Hit Avoidance", PLAYERSTAT_SPELL_COMBAT.." Hit Avd", isPercent = true},
		["MELEE_CRIT"] = {MELEE_CRIT_CHANCE, "Crit"}, -- MELEE_CRIT_CHANCE = "Crit Chance"
		["RANGED_CRIT"] = {PLAYERSTAT_RANGED_COMBAT.." "..MELEE_CRIT_CHANCE, PLAYERSTAT_RANGED_COMBAT.." Crit", isPercent = true},
		["SPELL_CRIT"] = {PLAYERSTAT_SPELL_COMBAT.." "..MELEE_CRIT_CHANCE, PLAYERSTAT_SPELL_COMBAT.." Crit", isPercent = true},
		["MELEE_CRIT_AVOID"] = {"Crit Avoidance", "Crit Avd", isPercent = true},
		["RANGED_CRIT_AVOID"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Avoidance", PLAYERSTAT_RANGED_COMBAT.." Crit Avd", isPercent = true},
		["SPELL_CRIT_AVOID"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Avoidance", PLAYERSTAT_SPELL_COMBAT.." Crit Avd", isPercent = true},
		["MELEE_HASTE"] = {"Haste", "Haste"}, --
		["RANGED_HASTE"] = {PLAYERSTAT_RANGED_COMBAT.." Haste", PLAYERSTAT_RANGED_COMBAT.." Haste", isPercent = true},
		["SPELL_HASTE"] = {PLAYERSTAT_SPELL_COMBAT.." Haste", PLAYERSTAT_SPELL_COMBAT.." Haste", isPercent = true},
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
		["EXPERTISE"] = {"Expertise", "Expertise"},
		["ARMOR_PENETRATION"] = {"Armor Penetration", "ArP", isPercent = true},
		["MASTERY"] = {"Mastery", "Mastery"},

		---------------------------------------------------------------------------
		-- Tier3 Stats - Stats that only show up when broken down from a Tier2 stat
		-- Defense -> Crit Avoidance, Hit Avoidance, Dodge, Parry, Block
		-- Weapon Skill -> Crit, Hit, Dodge Neglect, Parry Neglect, Block Neglect
		-- Expertise -> Dodge Neglect, Parry Neglect
		["DODGE_NEGLECT"] = {DODGE.." Neglect", DODGE.." Neglect", isPercent = true},
		["PARRY_NEGLECT"] = {PARRY.." Neglect", PARRY.." Neglect", isPercent = true},
		["BLOCK_NEGLECT"] = {BLOCK.." Neglect", BLOCK.." Neglect", isPercent = true},

		---------------------------------------------------------------------------
		-- Talents
		["MELEE_CRIT_DMG"] = {"Crit Damage", "Crit Dmg", isPercent = true},
		["RANGED_CRIT_DMG"] = {PLAYERSTAT_RANGED_COMBAT.." Crit Damage", PLAYERSTAT_RANGED_COMBAT.." Crit Dmg", isPercent = true},
		["SPELL_CRIT_DMG"] = {PLAYERSTAT_SPELL_COMBAT.." Crit Damage", PLAYERSTAT_SPELL_COMBAT.." Crit Dmg", isPercent = true},

		---------------------------------------------------------------------------
		-- Spell Stats
		-- These values can be prefixed with a @ and spell name, using reverse translation to english from Babble-Spell-2.2
		-- ex: "Heroic Strike@RAGE_COST" for Heroic Strike rage cost
		-- ex: "Heroic Strike@THREAT" for Heroic Strike threat value
		-- Use strsplit("@", text) to seperate the spell name and statid
		["THREAT"] = {"Threat", "Threat"},
		["CAST_TIME"] = {"Casting Time", "Cast Time"},
		["MANA_COST"] = {"Mana Cost", "Mana Cost"},
		["RAGE_COST"] = {"Rage Cost", "Rage Cost"},
		["ENERGY_COST"] = {"Energy Cost", "Energy Cost"},
		["COOLDOWN"] = {"Cooldown", "CD"},

		---------------------------------------------------------------------------
		-- Stats Mods
		["MOD_STR"] = {"Mod "..SPELL_STAT1_NAME, "Mod Str", isPercent = true},
		["MOD_AGI"] = {"Mod "..SPELL_STAT2_NAME, "Mod Agi", isPercent = true},
		["MOD_STA"] = {"Mod "..SPELL_STAT3_NAME, "Mod Sta", isPercent = true},
		["MOD_INT"] = {"Mod "..SPELL_STAT4_NAME, "Mod Int", isPercent = true},
		["MOD_SPI"] = {"Mod "..SPELL_STAT5_NAME, "Mod Spi", isPercent = true},
		["MOD_HEALTH"] = {"Mod "..HEALTH, "Mod "..HP, isPercent = true},
		["MOD_MANA"] = {"Mod "..MANA, "Mod "..MP, isPercent = true},
		["MOD_ARMOR"] = {"Mod "..ARMOR.."from Items", "Mod "..ARMOR.."(Items)", isPercent = true},
		["MOD_BLOCK_VALUE"] = {"Mod Block Value", "Mod Block Value", isPercent = true},
		["MOD_DMG"] = {"Mod Damage", "Mod Dmg", isPercent = true},
		["MOD_DMG_TAKEN"] = {"Mod Damage Taken", "Mod Dmg Taken", isPercent = true},
		["MOD_CRIT_DAMAGE"] = {"Mod Crit Damage", "Mod Crit Dmg", isPercent = true},
		["MOD_CRIT_DAMAGE_TAKEN"] = {"Mod Crit Damage Taken", "Mod Crit Dmg Taken", isPercent = true},
		["MOD_THREAT"] = {"Mod Threat", "Mod Threat", isPercent = true},
		["MOD_AP"] = {"Mod "..ATTACK_POWER_TOOLTIP, "Mod AP", isPercent = true},
		["MOD_RANGED_AP"] = {"Mod "..PLAYERSTAT_RANGED_COMBAT.." "..ATTACK_POWER_TOOLTIP, "Mod RAP", isPercent = true},
		["MOD_SPELL_PWR"] = {"Mod "..PLAYERSTAT_SPELL_COMBAT.." "..DAMAGE, "Mod "..PLAYERSTAT_SPELL_COMBAT.." Dmg", isPercent = true},
		["MOD_HEAL"] = {"Mod Healing", "Mod Heal", isPercent = true},
		["MOD_CAST_TIME"] = {"Mod Casting Time", "Mod Cast Time", isPercent = true},
		["MOD_MANA_COST"] = {"Mod Mana Cost", "Mod Mana Cost", isPercent = true},
		["MOD_RAGE_COST"] = {"Mod Rage Cost", "Mod Rage Cost", isPercent = true},
		["MOD_ENERGY_COST"] = {"Mod Energy Cost", "Mod Energy Cost", isPercent = true},
		["MOD_COOLDOWN"] = {"Mod Cooldown", "Mod CD", isPercent = true},
		["CRIT_TAKEN"] = {"Chance to be critically hit", "Crit Taken", isPercent = true},
		["HIT_TAKEN"] = {"Chance to be hit", "Hit Taken", isPercent = true},
		["CRIT_DAMAGE_TAKEN"] = {"Critical damage taken", "Crit Dmg Taken", isPercent = true},
		["DMG_TAKEN"] = {"Damage taken", "Dmg Taken", isPercent = true},
		["CRIT_DAMAGE"] = {"Critical damage", "Crit Dmg", isPercent = true},
		["DMG"] = {DAMAGE, DAMAGE},
		["BLOCK_REDUCTION"] = {"Increases the amount your block stops by %1d", "Block Value", isPercent = true},

		---------------------------------------------------------------------------
		-- Misc Stats
		["WEAPON_RATING"] = {"Weapon "..SKILL.." "..RATING, "Weapon"..SKILL.." "..RATING},
		["WEAPON_SKILL"] = {"Weapon "..SKILL, "Weapon"..SKILL},
		["MAINHAND_WEAPON_RATING"] = {"Main Hand Weapon "..SKILL.." "..RATING, "MH Weapon"..SKILL.." "..RATING},
		["OFFHAND_WEAPON_RATING"] = {"Off Hand Weapon "..SKILL.." "..RATING, "OH Weapon"..SKILL.." "..RATING},
		["RANGED_WEAPON_RATING"] = {"Ranged Weapon "..SKILL.." "..RATING, "Ranged Weapon"..SKILL.." "..RATING},
	},
} -- }}}
