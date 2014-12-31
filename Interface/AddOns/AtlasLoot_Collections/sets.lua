local addonname = ...
local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local BB = AtlasLoot.LibBabble:Get("LibBabble-Boss-3.0")
local Set = AtlasLoot.Data.Sets:RegisterNewSets(addonname)

local BIS = AtlasLoot.LibBabble:Get("LibBabble-ItemSet-3.0")

local RF_DIFF = Set:AddDifficulty(AL["Raid Finder"], "rf")
local NORMAL_DIFF = Set:AddDifficulty(AL["Normal"], "n")
local HEROIC_DIFF = Set:AddDifficulty(AL["Heroic"], "h")
local P25_DIFF = Set:AddDifficulty(AL["25 Player"], "p25")
local P25H_DIFF = Set:AddDifficulty(AL["25 Player Heroic"], "p25h")
local MYTHIC_DIFF = Set:AddDifficulty(AL["Mythic"], "m")
local HEROIC_PRE_DIFF = Set:AddDifficulty(AL["Heroic"], "hB1", { "HeroicRaid", "HeroicRaidWarforged" })
local MYTHIC_PRE_DIFF = Set:AddDifficulty(AL["Mythic"], "mB1", { "MythicRaid", "MythicRaidWarforged" })

local SOURCE_INFO = Set:AddInfoList(AL["Source"])

local format = string.format

local EJ_GetInstanceInfo, EJ_GetEncounterInfo = EJ_GetInstanceInfo, EJ_GetEncounterInfo

-- #################### DEV
-- Test a set with
-- /run AtlasLoot:Teest("Tier17")
-- #################### DEV

local SetTable = {
	["AQ40"] = {	-- Ahn'Qiraj Sets (T2.5)
		name = ALIL["Ahn'Qiraj"].." "..AL["Sets"],
		sourceTemplate = {
			ALIL["Ahn'Qiraj"],	-- Head
			ALIL["Ahn'Qiraj"],	-- Shoulder
			ALIL["Ahn'Qiraj"],	-- Chest
			ALIL["Ahn'Qiraj"],	-- Legs
			ALIL["Ahn'Qiraj"],	-- Feet
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21353,	-- Genesis Helm
				21354,	-- Genesis Shoulderpads
				21357,	-- Genesis Vest
				21356,	-- Genesis Trousers
				21355,	-- Genesis Boots
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21366,	-- Striker's Diadem
				21367,	-- Striker's Pauldrons
				21370,	-- Striker's Hauberk
				21368,	-- Striker's Leggings
				21365,	-- Striker's Footguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21347,	-- Enigma Circlet
				21345,	-- Enigma Shoulderpads
				21343,	-- Enigma Robes
				21346,	-- Enigma Leggings
				21344,	-- Enigma Boots
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21387,	-- Avenger's Crown
				21391,	-- Avenger's Pauldrons
				21389,	-- Avenger's Breastplate
				21390,	-- Avenger's Legguards
				21388,	-- Avenger's Greaves
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21348,	-- Tiara of the Oracle
				21350,	-- Mantle of the Oracle
				21351,	-- Vestments of the Oracle
				21352,	-- Trousers of the Oracle
				21349,	-- Footwraps of the Oracle
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21360,	-- Deathdealer's Helm
				21361,	-- Deathdealer's Spaulders
				21364,	-- Deathdealer's Vest
				21362,	-- Deathdealer's Leggings
				21359,	-- Deathdealer's Boots
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21372,	-- Stormcaller's Diadem
				21376,	-- Stormcaller's Pauldrons
				21374,	-- Stormcaller's Hauberk
				21375,	-- Stormcaller's Leggings
				21373,	-- Stormcaller's Footguards
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21337,	-- Doomcaller's Circlet
				21335,	-- Doomcaller's Mantle
				21334,	-- Doomcaller's Robes
				21336,	-- Doomcaller's Trousers
				21338,	-- Doomcaller's Footwraps
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21329,	-- Conqueror's Crown
				21330,	-- Conqueror's Spaulders
				21331,	-- Conqueror's Breastplate
				21332,	-- Conqueror's Legguards
				21333,	-- Conqueror's Greaves
			},
		},
	},

	["AQ20"] = {	-- Ruins of Ahn'Qiraj Sets
		name = ALIL["Ruins of Ahn'Qiraj"].." "..AL["Sets"],
		sourceTemplate = {
			ALIL["Ruins of Ahn'Qiraj"],	-- Cloak
			ALIL["Ruins of Ahn'Qiraj"],	-- Finger
			ALIL["Ruins of Ahn'Qiraj"],	-- Main Hand
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21409,	-- Cloak of Unending Life
				21408,	-- Band of Unending Life
				21407,	-- Mace of Unending Life
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21403,	-- Cloak of the Unseen Path
				21402,	-- Signet of the Unseen Path
				21401,	-- Scythe of the Unseen Path
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21415,	-- Drape of Vaulted Secrets
				21414,	-- Band of Vaulted Secrets
				21413,	-- Blade of Vaulted Secrets
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21397,	-- Cape of Eternal Justice
				21396,	-- Ring of Eternal Justice
				21395,	-- Blade of Eternal Justice
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21412,	-- Shroud of Infinite Wisdom
				21411,	-- Ring of Infinite Wisdom
				21410,	-- Gavel of Infinite Wisdom
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21406,	-- Cloak of Veiled Shadows
				21405,	-- Band of Veiled Shadows
				21404,	-- Dagger of Veiled Shadows
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21400,	-- Cloak of the Gathering Storm
				21399,	-- Ring of the Gathering Storm
				21398,	-- Hammer of the Gathering Storm
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21418,	-- Shroud of Unspoken Names
				21417,	-- Ring of Unspoken Names
				21416,	-- Kris of Unspoken Names
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21394,	-- Drape of Unyielding Strength
				21393,	-- Signet of Unyielding Strength
				21392,	-- Sickle of Unyielding Strength
			},
		},
	},

	["ClassicMisc"] = {	-- Miscellaneous Classic Sets
		name = AL["Miscellaneous"].." "..AL["Sets"],
		{	-- Ironweave Battlesuit
			name = BIS["Ironweave Battlesuit"].." ("..ALIL["Cloth"]..")",
			subSetName = "ironweavebattlesuit",
			icon = "mage",
			[NORMAL_DIFF] = {
				{ 22302, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Cowl
				{ 22305, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Mantle
				{ 22301, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Robe
				{ 22313, [SOURCE_INFO] = EJ_GetInstanceInfo(229).." - "..EJ_GetEncounterInfo(394) },	-- Ironweave Bracers
				{ 22304, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Gloves
				{ 22306, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Belt
				{ 22303, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Pants
				{ 22311, [SOURCE_INFO] = AL["No longer available"] },	-- Ironweave Boots
			},
		},
		{	-- The Gladiator
			name = BIS["The Gladiator"].." ("..ALIL["Mail"]..")",
			subSetName = "thegladiator",
			icon = "hunter",
			[NORMAL_DIFF] = {
				{ 11729, [SOURCE_INFO] = EJ_GetInstanceInfo(228).." - "..EJ_GetEncounterInfo(372) },	-- Savage Gladiator Helm
				{ 11726, [SOURCE_INFO] = EJ_GetInstanceInfo(228).." - "..EJ_GetEncounterInfo(372) },	-- Savage Gladiator Chain
				{ 11730, [SOURCE_INFO] = EJ_GetInstanceInfo(228).." - "..EJ_GetEncounterInfo(372) },	-- Savage Gladiator Grips
				{ 11728, [SOURCE_INFO] = EJ_GetInstanceInfo(228).." - "..EJ_GetEncounterInfo(372) },	-- Savage Gladiator Leggings
				{ 11731, [SOURCE_INFO] = EJ_GetInstanceInfo(228).." - "..EJ_GetEncounterInfo(372) },	-- Savage Gladiator Greaves
			},
		},
		{	-- The Postmaster
			name = BIS["The Postmaster"].." ("..ALIL["Cloth"]..")",
			subSetName = "thepostmaster",
			icon = "mage",
			[NORMAL_DIFF] = {
				{ 13390, [SOURCE_INFO] = EJ_GetInstanceInfo(236).." - "..BB["Postmaster Malown"] },	-- The Postmaster's Band
				{ 13388, [SOURCE_INFO] = EJ_GetInstanceInfo(236).." - "..BB["Postmaster Malown"] },	-- The Postmaster's Tunic
				{ 13389, [SOURCE_INFO] = EJ_GetInstanceInfo(236).." - "..BB["Postmaster Malown"] },	-- The Postmaster's Trousers
				{ 13391, [SOURCE_INFO] = EJ_GetInstanceInfo(236).." - "..BB["Postmaster Malown"] },	-- The Postmaster's Treads
				{ 13392, [SOURCE_INFO] = EJ_GetInstanceInfo(236).." - "..BB["Postmaster Malown"] },	-- The Postmaster's Seal
			},
		},
		{	-- Chain of the Scarlet Crusade
			name = BIS["Chain of the Scarlet Crusade"].." ("..ALIL["Mail"]..")",
			subSetName = "chainofthescarletcrusade",
			icon = "warri",
			[NORMAL_DIFF] = {
				{ 10328, [SOURCE_INFO] = AL["Salvage Yard"] },	-- Scarlet Chestpiece
				{ 10333, [SOURCE_INFO] = AL["Salvage Yard"] },	-- Scarlet Wristguards
				{ 10331, [SOURCE_INFO] = AL["Salvage Yard"] },	-- Scarlet Gauntlets
				{ 10329, [SOURCE_INFO] = AL["Salvage Yard"] },	-- Scarlet Belt
				{ 10330, [SOURCE_INFO] = AL["Salvage Yard"] },	-- Scarlet Leggings
				{ 10332, [SOURCE_INFO] = AL["Salvage Yard"] },	-- Scarlet Boots
			},
		},
		{	-- Embrace of the Viper
			name = BIS["Embrace of the Viper"].." ("..ALIL["Leather"]..")",
			subSetName = "embraceoftheviper",
			icon = "rogue",
			[NORMAL_DIFF] = {
				{ 6473, [SOURCE_INFO] = EJ_GetInstanceInfo(240).." - "..EJ_GetEncounterInfo(476) },	-- Armor of the Fang
				{ 10413, [SOURCE_INFO] = EJ_GetInstanceInfo(240).." - "..AL["Druid of the Fang"] },	-- Gloves of the Fang
				{ 10412, [SOURCE_INFO] = EJ_GetInstanceInfo(240).." - "..EJ_GetEncounterInfo(474) },	-- Belt of the Fang
				{ 10410, [SOURCE_INFO] = EJ_GetInstanceInfo(240).." - "..EJ_GetEncounterInfo(475) },	-- Leggings of the Fang
				{ 10411, [SOURCE_INFO] = EJ_GetInstanceInfo(240).." - "..EJ_GetEncounterInfo(479) },	-- Footpads of the Fang
			},
		},
		{	-- Defias Leather
			name = BIS["Defias Leather"].." ("..ALIL["Leather"]..")",
			subSetName = "defiasleather",
			icon = "rogue",
			[NORMAL_DIFF] = {
				{ 10399, [SOURCE_INFO] = AL["No longer available"] },	-- Blackened Defias Armor
				{ 10401, [SOURCE_INFO] = EJ_GetInstanceInfo(63).." - "..AL["Defias Overseer"] },	-- Blackened Defias Gloves
				{ 10403, [SOURCE_INFO] = AL["No longer available"] },	-- Blackened Defias Belt
				{ 10400, [SOURCE_INFO] = EJ_GetInstanceInfo(63).." - "..AL["Defias Overseer"] },	-- Blackened Defias Leggings
				{ 10402, [SOURCE_INFO] = AL["No longer available"] },	-- Blackened Defias Boots
			},
		},
	},

	["CMMoP"] = {	-- MoP Challenge Mode Armor Sets
		name = AL["Challenge Mode Armor Sets"],
		sourceTemplate = {
			AL["No longer available"],	-- Head
			AL["No longer available"],	-- Shoulder
			AL["No longer available"],	-- Chest
			AL["No longer available"],	-- Wrist
			AL["No longer available"],	-- Hands
			AL["No longer available"],	-- Waist
			AL["No longer available"],	-- Legs
			AL["No longer available"],	-- Feet
		},
		{	-- Deathknight
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			subSetName = "dk",
			icon = "dk",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90053,	-- Crown of the Lich Lord
				90055,	-- Shoulderguards of the Lich Lord
				90051,	-- Chestguard of the Lich Lord
				90056,	-- Bracers of the Lich Lord
				90052,	-- Grasps of the Lich Lord
				90049,	-- Girdle of the Lich Lord
				90054,	-- Legplates of the Lich Lord
				90050,	-- Treads of the Lich Lord
			},
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90062,	-- Hood of the Cycle
				90065,	-- Branches of the Cycle
				90064,	-- Robes of the Cycle
				90066,	-- Bracers of the Cycle
				90061,	-- Gloves of the Cycle
				90059,	-- Waistguard of the Cycle
				90063,	-- Leggings of the Cycle
				90060,	-- Sandals of the Cycle
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90072,	-- Helm of the Howling Beast
				90074,	-- Shoulderguards of the Howling Beast
				90070,	-- Chestguard of the Howling Beast
				90075,	-- Wristwraps of the Howling Beast
				90071,	-- Grips of the Howling Beast
				90068,	-- Cinch of the Howling Beast
				90073,	-- Legguards of the Howling Beast
				90069,	-- Boots of the Howling Beast
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90082,	-- Hood of the Elemental Triad
				90085,	-- Spaulders of the Elemental Triad
				90084,	-- Robes of the Elemental Triad
				90086,	-- Bracers of the Elemental Triad
				90081,	-- Gloves of the Elemental Triad
				90079,	-- Girdle of the Elemental Triad
				90083,	-- Leggings of the Elemental Triad
				90080,	-- Boots of the Elemental Triad
			},
		},
		{	-- Monk
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"],
			subSetName = "monk",
			icon = "monk",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90092,	-- Crown of the Regal Lord
				90094,	-- Shoulderguards of the Regal Lord
				90090,	-- Chestwrap of the Regal Lord
				90095,	-- Bracers of the Regal Lord
				90091,	-- Handwraps of the Regal Lord
				90088,	-- Greatbelt of the Regal Lord
				90093,	-- Legwraps of the Regal Lord
				90089,	-- Treads of the Regal Lord
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90100,	-- Greathelm of the Holy Warrior
				90102,	-- Shoulderplate of the Holy Warrior
				90098,	-- Chestplate of the Holy Warrior
				90103,	-- Wristguards of the Holy Warrior
				90099,	-- Gauntlets of the Holy Warrior
				90096,	-- Girdle of the Holy Warrior
				90101,	-- Legplates of the Holy Warrior
				90097,	-- Greatboots of the Holy Warrior
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90116,	-- Cowl of the Light
				90113,	-- Pauldrons of the Light
				90114,	-- Robes of the Light
				90112,	-- Bracers of the Light
				90115,	-- Hands of the Light
				90110,	-- Cord of the Light
				90117,	-- Leggings of the Light
				90111,	-- Steps of the Light
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90120,	-- Hood of the Silent Assassin
				90125,	-- Spaulders of the Silent Assassin
				90122,	-- Shadowwrap of the Silent Assassin
				90126,	-- Bracers of the Silent Assassin
				90123,	-- Gloves of the Silent Assassin
				90119,	-- Girdle of the Silent Assassin
				90124,	-- Leggings of the Silent Assassin
				90121,	-- Tabi of the Silent Assassin
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90132,	-- Windfury Mask
				90134,	-- Windfury Spirit Guides
				90130,	-- Windfury Harness
				90127,	-- Windfury Bracers
				90131,	-- Windfury Crushers
				90128,	-- Windfury Belt
				90133,	-- Windfury Legguards
				90129,	-- Windfury Sandals
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90142,	-- Horns of the Betrayer
				90138,	-- Amice of the Betrayer
				90140,	-- Robes of the Betrayer
				90139,	-- Bracers of the Betrayer
				90141,	-- Handguards of the Betrayer
				90136,	-- Belt of the Betrayer
				90143,	-- Leggings of the Betrayer
				90137,	-- Boots of the Betrayer
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				90151,	-- Crown of the Golden King
				90153,	-- Mantle of the Golden King
				90149,	-- Chestplate of the Golden King
				90154,	-- Bracers of the Golden King
				90150,	-- Reach of the Golden King
				90147,	-- Girdle of the Golden King
				90152,	-- Greaves of the Golden King
				90148,	-- Greatboots of the Golden King
			},
		},
	},

	["Dungeon3"] = {	-- Dungeon 3 Sets
		name = format(AL["Dungeon %d Sets"], 3),
		{	-- Moonglade Raiment
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..BIS["Moonglade Raiment"]..")",
			subSetName = "moongladeraiment",
			icon = "druid",
			[NORMAL_DIFF] = {
				{ 28348, [SOURCE_INFO] = EJ_GetInstanceInfo(257).." - "..EJ_GetEncounterInfo(562) },	-- Moonglade Cowl
				{ 27737, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Moonglade Shoulders
				{ 28202, [SOURCE_INFO] = EJ_GetInstanceInfo(258).." - "..EJ_GetEncounterInfo(565) },	-- Moonglade Robe
				{ 27468, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(545) },	-- Moonglade Handwraps
				{ 27873, [SOURCE_INFO] = EJ_GetInstanceInfo(255).." - "..EJ_GetEncounterInfo(554) },	-- Moonglade Pants
			},
		},
		{	-- Beast Lord Armor
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"].." ("..BIS["Beast Lord Armor"]..")",
			subSetName = "beastlordarmor",
			icon = "hunter",
			[NORMAL_DIFF] = {
				{ 28275, [SOURCE_INFO] = EJ_GetInstanceInfo(258).." - "..EJ_GetEncounterInfo(565) },	-- Beast Lord Helm
				{ 27801, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Beast Lord Mantle
				{ 28228, [SOURCE_INFO] = EJ_GetInstanceInfo(257).." - "..EJ_GetEncounterInfo(562) },	-- Beast Lord Curiass
				{ 27474, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(569) },	-- Beast Lord Handguards
				{ 27874, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Beast Lord Leggings
			},
		},
		{	-- Incanter's Regalia
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"].." ("..BIS["Incanter's Regalia"]..")",
			subSetName = "incantersregalia",
			icon = "mage",
			[NORMAL_DIFF] = {
				{ 28278, [SOURCE_INFO] = EJ_GetInstanceInfo(258).." - "..EJ_GetEncounterInfo(565) },	-- Incanter's Cowl
				{ 27738, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Incanter's Pauldrons
				{ 28229, [SOURCE_INFO] = EJ_GetInstanceInfo(257).." - "..EJ_GetEncounterInfo(562) },	-- Incanter's Robe
				{ 27508, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(573) },	-- Incanter's Gloves
				{ 27838, [SOURCE_INFO] = EJ_GetInstanceInfo(252).." - "..EJ_GetEncounterInfo(543) },	-- Incanter's Trousers
			},
		},
		{	-- Righteous Armor
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..BIS["Righteous Armor"]..")",
			subSetName = "righteousarmor",
			icon = "pala",
			[NORMAL_DIFF] = {
				{ 28285, [SOURCE_INFO] = EJ_GetInstanceInfo(258).." - "..EJ_GetEncounterInfo(565) },	-- Helm of the Righteous
				{ 27739, [SOURCE_INFO] = EJ_GetInstanceInfo(257).." - "..EJ_GetEncounterInfo(561) },	-- Spaulders of the Righteous
				{ 28203, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Breastplate of the Righteous
				{ 27535, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(568) },	-- Gauntlets of the Righteous
				{ 27839, [SOURCE_INFO] = EJ_GetInstanceInfo(255).." - "..EJ_GetEncounterInfo(554) },	-- Legplates of the Righteous
			},
		},
		{	-- Hallowed Raiment
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..BIS["Hallowed Raiment"]..")",
			subSetName = "hallowedraiment",
			icon = "priest",
			[NORMAL_DIFF] = {
				{ 28413, [SOURCE_INFO] = EJ_GetInstanceInfo(254).." - "..EJ_GetEncounterInfo(551) },	-- Hallowed Crown
				{ 27775, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(546) },	-- Hallowed Pauldrons
				{ 28230, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(547) },	-- Hallowed Garments
				{ 27536, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(569) },	-- Hallowed Handwraps
				{ 27875, [SOURCE_INFO] = EJ_GetInstanceInfo(252).." - "..EJ_GetEncounterInfo(543) },	-- Hallowed Trousers
			},
		},
		{	-- Assassination Armor
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"].." ("..BIS["Assassination Armor"]..")",
			subSetName = "assassinationarmor",
			icon = "rogue",
			[NORMAL_DIFF] = {
				{ 28414, [SOURCE_INFO] = EJ_GetInstanceInfo(254).." - "..EJ_GetEncounterInfo(551) },	-- Helm of Assassination
				{ 27776, [SOURCE_INFO] = EJ_GetInstanceInfo(252).." - "..EJ_GetEncounterInfo(543) },	-- Shoulderpads of Assassination
				{ 28204, [SOURCE_INFO] = EJ_GetInstanceInfo(258).." - "..EJ_GetEncounterInfo(565) },	-- Tunic of Assassination
				{ 27509, [SOURCE_INFO] = EJ_GetInstanceInfo(255).." - "..EJ_GetEncounterInfo(554) },	-- Handgrips of Assassination
				{ 27908, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(547) },	-- Leggings of Assassination
			},
		},
		{	-- Tidefury Raiment
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..BIS["Tidefury Raiment"]..")",
			subSetName = "tidefuryraiment",
			icon = "shaman",
			[NORMAL_DIFF] = {
				{ 28349, [SOURCE_INFO] = EJ_GetInstanceInfo(257).." - "..EJ_GetEncounterInfo(562) },	-- Tidefury Helm
				{ 27802, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(568) },	-- Tidefury Shoulderguards
				{ 28231, [SOURCE_INFO] = EJ_GetInstanceInfo(254).." - "..EJ_GetEncounterInfo(551) },	-- Tidefury Chestpiece
				{ 27510, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Tidefury Gauntlets
				{ 27909, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(547) },	-- Tidefury Kilt
			},
		},
		{	-- Oblivion Raiment
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"].." ("..BIS["Oblivion Raiment"]..")",
			subSetName = "oblivionraiment",
			icon = "warlock",
			[NORMAL_DIFF] = {
				{ 28415, [SOURCE_INFO] = EJ_GetInstanceInfo(254).." - "..EJ_GetEncounterInfo(551) },	-- Hood of Oblivion
				{ 27778, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(547) },	-- Spaulders of Oblivion
				{ 28232, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(547) },	-- Robe of Oblivion
				{ 27537, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(569) },	-- Gloves of Oblivion
				{ 27948, [SOURCE_INFO] = EJ_GetInstanceInfo(252).." - "..EJ_GetEncounterInfo(543) },	-- Trousers of Oblivion
			},
		},
		{	-- Bold Armor
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..BIS["Bold Armor"]..")",
			subSetName = "boldarmor",
			icon = "warri",
			[NORMAL_DIFF] = {
				{ 28350, [SOURCE_INFO] = EJ_GetInstanceInfo(257).." - "..EJ_GetEncounterInfo(562) },	-- Warhelm of the Bold
				{ 27803, [SOURCE_INFO] = EJ_GetInstanceInfo(253).." - "..EJ_GetEncounterInfo(547) },	-- Shoulderguards of the Bold
				{ 28205, [SOURCE_INFO] = EJ_GetInstanceInfo(254).." - "..EJ_GetEncounterInfo(551) },	-- Breastplate of the Bold
				{ 27475, [SOURCE_INFO] = EJ_GetInstanceInfo(261).." - "..EJ_GetEncounterInfo(575) },	-- Gauntlets of the Bold
				{ 27977, [SOURCE_INFO] = EJ_GetInstanceInfo(255).." - "..EJ_GetEncounterInfo(554) },	-- Legplates of the Bold
			},
		},
		{	-- Mana-Etched Regalia
			name = ALIL["Cloth"].." ("..BIS["Mana-Etched Regalia"]..")",
			subSetName = "manaechedregalia",
			icon = "Interface\\Icons\\inv_chest_cloth_42",
			[NORMAL_DIFF] = {
				{ 28193, [SOURCE_INFO] = EJ_GetInstanceInfo(255).." - "..EJ_GetEncounterInfo(554) },	-- Mana-Etched Crown
				{ 27796, [SOURCE_INFO] = EJ_GetInstanceInfo(260).." - "..EJ_GetEncounterInfo(572) },	-- Mana-Etched Spaulders
				{ 28191, [SOURCE_INFO] = EJ_GetInstanceInfo(251).." - "..EJ_GetEncounterInfo(540) },	-- Mana-Etched Vestments
				{ 27465, [SOURCE_INFO] = EJ_GetInstanceInfo(248).." - "..EJ_GetEncounterInfo(528) },	-- Mana-Etched Gloves
				{ 27907, [SOURCE_INFO] = EJ_GetInstanceInfo(262).." - "..EJ_GetEncounterInfo(579) },	-- Mana-Etched Pantaloons
			},
		},
		{	-- Wastewalker Armor
			name = ALIL["Leather"].." ("..BIS["Wastewalker Armor"]..")",
			subSetName = "wastewalkerarmor",
			icon = "Interface\\Icons\\inv_chest_chain_17",
			[NORMAL_DIFF] = {
				{ 28224, [SOURCE_INFO] = EJ_GetInstanceInfo(251).." - "..EJ_GetEncounterInfo(540) },	-- Wastewalker Helm
				{ 27797, [SOURCE_INFO] = EJ_GetInstanceInfo(247).." - "..AL["Avatar of the Martyred"] },	-- Wastewalker Shoulderpads
				{ 28264, [SOURCE_INFO] = EJ_GetInstanceInfo(256).." - "..EJ_GetEncounterInfo(557) },	-- Wastewalker Tunic
				{ 27531, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(569) },	-- Wastewalker Gloves
				{ 27837, [SOURCE_INFO] = EJ_GetInstanceInfo(250).." - "..EJ_GetEncounterInfo(537) },	-- Wastewalker Leggings
			},
		},
		{	-- Desolation Battlegear
			name = ALIL["Mail"].." ("..BIS["Desolation Battlegear"]..")",
			subSetName = "desolationbattlegear",
			icon = "Interface\\Icons\\inv_chest_chain_03",
			[NORMAL_DIFF] = {
				{ 28192, [SOURCE_INFO] = EJ_GetInstanceInfo(255).." - "..EJ_GetEncounterInfo(554) },	-- Helm of Desolation
				{ 27713, [SOURCE_INFO] = EJ_GetInstanceInfo(260).." - "..EJ_GetEncounterInfo(572) },	-- Pauldrons of Desolation
				{ 28401, [SOURCE_INFO] = EJ_GetInstanceInfo(251).." - "..EJ_GetEncounterInfo(540) },	-- Hauberk of Desolation
				{ 27528, [SOURCE_INFO] = EJ_GetInstanceInfo(259).." - "..EJ_GetEncounterInfo(569) },	-- Gauntlets of Desolation
				{ 27936, [SOURCE_INFO] = EJ_GetInstanceInfo(252).." - "..EJ_GetEncounterInfo(543) },	-- Greaves of Desolation
			},
		},
		{	-- Doomplate Battlegear
			name = ALIL["Plate"].." ("..BIS["Doomplate Battlegear"]..")",
			subSetName = "doomplatebattlegear",
			icon = "Interface\\Icons\\inv_chest_chain_15",
			[NORMAL_DIFF] = {
				{ 28225, [SOURCE_INFO] = EJ_GetInstanceInfo(251).." - "..EJ_GetEncounterInfo(540) },	-- Doomplate Warhelm
				{ 27771, [SOURCE_INFO] = EJ_GetInstanceInfo(262).." - "..EJ_GetEncounterInfo(579) },	-- Doomplate Shoulderguards
				{ 28403, [SOURCE_INFO] = EJ_GetInstanceInfo(254).." - "..EJ_GetEncounterInfo(551) },	-- Doomplate Chestguard
				{ 27497, [SOURCE_INFO] = EJ_GetInstanceInfo(256).." - "..EJ_GetEncounterInfo(557) },	-- Doomplate Gauntlets
				{ 27870, [SOURCE_INFO] = EJ_GetInstanceInfo(247).." - "..EJ_GetEncounterInfo(524) },	-- Doomplate Legguards
			},
		},
	},

	["Dungeon2"] = {	-- Dungeon 2 Sets
		name = format(AL["Dungeon %d Sets"], 2),
		sourceTemplate = {
			AL["Replica available at Darkmoon Faire"],	-- Head 75
			AL["Replica available at Darkmoon Faire"],	-- Shoulder 75
			AL["Replica available at Darkmoon Faire"],	-- Chest 75
			AL["Replica available at Darkmoon Faire"],	-- Wrist 55
			AL["Replica available at Darkmoon Faire"],	-- Hands 55
			AL["Replica available at Darkmoon Faire"],	-- Waist 55
			AL["Replica available at Darkmoon Faire"],	-- Legs 75
			AL["Replica available at Darkmoon Faire"],	-- Feet 55
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22109,	-- Feralheart Cowl
				22112,	-- Feralheart Spaulders
				22113,	-- Feralheart Vest
				22108,	-- Feralheart Bracers
				22110,	-- Feralheart Gloves
				22106,	-- Feralheart Belt
				22111,	-- Feralheart Kilt
				22107,	-- Feralheart Boots
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22013,	-- Beastmaster's Cap
				22016,	-- Beastmaster's Mantle
				22060,	-- Beastmaster's Tunic
				22011,	-- Beastmaster's Bindings
				22015,	-- Beastmaster's Gloves
				22010,	-- Beastmaster's Belt
				22017,	-- Beastmaster's Pants
				22061,	-- Beastmaster's Boots
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22065,	-- Sorcerer's Crown
				22068,	-- Sorcerer's Mantle
				22069,	-- Sorcerer's Robes
				22063,	-- Sorcerer's Bindings
				22066,	-- Sorcerer's Gloves
				22062,	-- Sorcerer's Belt
				22067,	-- Sorcerer's Leggings
				22064,	-- Sorcerer's Boots
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22091,	-- Soulforge Helm
				22093,	-- Soulforge Spaulders
				22089,	-- Soulforge Breastplate
				22088,	-- Soulforge Bracers
				22090,	-- Soulforge Gauntlets
				22086,	-- Soulforge Belt
				22092,	-- Soulforge Legplates
				22087,	-- Soulforge Boots
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22080,	-- Virtuous Crown
				22082,	-- Virtuous Mantle
				22083,	-- Virtuous Robe
				22079,	-- Virtuous Bracers
				22081,	-- Virtuous Gloves
				22078,	-- Virtuous Belt
				22085,	-- Virtuous Skirt
				22084,	-- Virtuous Sandals
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22005,	-- Darkmantle Cap
				22008,	-- Darkmantle Spaulders
				22009,	-- Darkmantle Tunic
				22004,	-- Darkmantle Bracers
				22006,	-- Darkmantle Gloves
				22002,	-- Darkmantle Belt
				22007,	-- Darkmantle Pants
				22003,	-- Darkmantle Boots
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22097,	-- Coif of The Five Thunders
				22101,	-- Pauldrons of The Five Thunders
				22102,	-- Vest of The Five Thunders
				22095,	-- Bindings of The Five Thunders
				22099,	-- Gauntlets of The Five Thunders
				22098,	-- Cord of The Five Thunders
				22100,	-- Kilt of The Five Thunders
				22096,	-- Boots of The Five Thunders
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22074,	-- Deathmist Mask
				22073,	-- Deathmist Mantle
				22075,	-- Deathmist Robe
				22071,	-- Deathmist Bracers
				22077,	-- Deathmist Wraps
				22070,	-- Deathmist Belt
				22072,	-- Deathmist Leggings
				22076,	-- Deathmist Sandals
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				21999,	-- Helm of Heroism
				22001,	-- Spaulders of Heroism
				21997,	-- Breastplate of Heroism
				21996,	-- Bracers of Heroism
				21998,	-- Gauntlets of Heroism
				21994,	-- Belt of Heroism
				22000,	-- Legplates of Heroism
				21995,	-- Boots of Heroism
			},
		},
	},

	["Dungeon1"] = {	-- Dungeon 1 Sets
		name = format(AL["Dungeon %d Sets"], 1),
		sourceTemplate = {
			AL["Replica available at Darkmoon Faire"],	-- Head 75
			AL["Replica available at Darkmoon Faire"],	-- Shoulder 75
			AL["Replica available at Darkmoon Faire"],	-- Chest 75
			AL["Replica available at Darkmoon Faire"],	-- Wrist 55
			AL["Replica available at Darkmoon Faire"],	-- Hands 55
			AL["Replica available at Darkmoon Faire"],	-- Waist 55
			AL["Replica available at Darkmoon Faire"],	-- Legs 75
			AL["Replica available at Darkmoon Faire"],	-- Feet 55
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16720,	-- Wildheart Cowl
				16718,	-- Wildheart Spaulders
				16706,	-- Wildheart Vest
				16714,	-- Wildheart Bracers
				16717,	-- Wildheart Gloves
				16716,	-- Wildheart Belt
				16719,	-- Wildheart Kilt
				16715,	-- Wildheart Boots
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16677,	-- Beaststalker's Cap
				16679,	-- Beaststalker's Mantle
				16674,	-- Beaststalker's Tunic
				16681,	-- Beaststalker's Bindings
				16676,	-- Beaststalker's Gloves
				16680,	-- Beaststalker's Belt
				16678,	-- Beaststalker's Pants
				16675,	-- Beaststalker's Boots
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16686,	-- Magister's Crown
				16689,	-- Magister's Mantle
				16688,	-- Magister's Robes
				16683,	-- Magister's Bindings
				16684,	-- Magister's Gloves
				16685,	-- Magister's Belt
				16687,	-- Magister's Leggings
				16682,	-- Magister's Boots
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16727,	-- Lightforge Helm
				16729,	-- Lightforge Spaulders
				16726,	-- Lightforge Breastplate
				16722,	-- Lightforge Bracers
				16724,	-- Lightforge Gauntlets
				16723,	-- Lightforge Belt
				16728,	-- Lightforge Legplates
				16725,	-- Lightforge Boots
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16693,	-- Devout Crown
				16695,	-- Devout Mantle
				16690,	-- Devout Robe
				16697,	-- Devout Bracers
				16692,	-- Devout Gloves
				16696,	-- Devout Belt
				16694,	-- Devout Skirt
				16691,	-- Devout Sandals
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16707,	-- Shadowcraft Cap
				16708,	-- Shadowcraft Spaulders
				16721,	-- Shadowcraft Tunic
				16710,	-- Shadowcraft Bracers
				16712,	-- Shadowcraft Gloves
				16713,	-- Shadowcraft Belt
				16709,	-- Shadowcraft Pants
				16711,	-- Shadowcraft Boots
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16667,	-- Coif of Elements
				16669,	-- Pauldrons of Elements
				16666,	-- Vest of Elements
				16671,	-- Bindings of Elements
				16672,	-- Gauntlets of Elements
				16673,	-- Cord of Elements
				16668,	-- Kilt of Elements
				16670,	-- Boots of Elements
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16698,	-- Dreadmist Mask
				16701,	-- Dreadmist Mantle
				16700,	-- Dreadmist Robe
				16703,	-- Dreadmist Bracers
				16705,	-- Dreadmist Wraps
				16702,	-- Dreadmist Belt
				16699,	-- Dreadmist Leggings
				16704,	-- Dreadmist Sandals
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16731,	-- Helm of Valor
				16733,	-- Spaulders of Valor
				16730,	-- Breastplate of Valor
				16735,	-- Bracers of Valor
				16737,	-- Gauntlets of Valor
				16736,	-- Belt of Valor
				16732,	-- Legplates of Valor
				16734,	-- Boots of Valor
			},
		},
	},

	["Scholomance"] = {	-- Scholomance Sets
		name = GetMapNameByID(898).." "..AL["Sets"],
		sourceTemplate = {
			AL["No longer available"],
			AL["No longer available"],
			AL["No longer available"],
			AL["No longer available"],
			AL["No longer available"],
		},
		{	-- Scholomance Cloth
			name = BIS["Necropile Raiment"].." ("..ALIL["Cloth"]..")",
			subSetName = "scholocloth",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				14633,	-- Necropile Mantle
				14626,	-- Necropile Robe
				14629,	-- Necropile Cuffs
				14632,	-- Necropile Leggings
				14631,	-- Necropile Boots
			},
		},
		{	-- Scholomance Leather
			name = BIS["Cadaverous Garb"].." ("..ALIL["Leather"]..")",
			subSetName = "schololeather",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				14637,	-- Cadaverous Armor
				14640,	-- Cadaverous Gloves
				14636,	-- Cadaverous Belt
				14638,	-- Cadaverous Leggings
				14641,	-- Cadaverous Walkers
			},
		},
		{	-- Scholomance Mail
			name = BIS["Bloodmail Regalia"].." ("..ALIL["Mail"]..")",
			subSetName = "scholomail",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				14611,	-- Bloodmail Hauberk
				14615,	-- Bloodmail Gauntlets
				14614,	-- Bloodmail Belt
				14612,	-- Bloodmail Legguards
				14616,	-- Bloodmail Boots
			},
		},
		{	-- Scholomance Plate
			name = BIS["Deathbone Guardian"].." ("..ALIL["Plate"]..")",
			subSetName = "scholoplate",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				14624,	-- Deathbone Chestplate
				14622,	-- Deathbone Gauntlets
				14620,	-- Deathbone Girdle
				14623,	-- Deathbone Legguards
				14621,	-- Deathbone Sabatons
			},
		},
	},

	["Tier17"] = {	-- T17 Sets
		name = format(AL["Tier %d Sets"], 17),
		sourceTemplate = {
			EJ_GetInstanceInfo(457).." - "..EJ_GetEncounterInfo(1162),	-- Head
			EJ_GetInstanceInfo(457).." - "..EJ_GetEncounterInfo(1147),	-- Shoulder
			EJ_GetInstanceInfo(457).." - "..EJ_GetEncounterInfo(1123),	-- Chest
			EJ_GetInstanceInfo(457).." - "..EJ_GetEncounterInfo(1203),	-- Hands
			EJ_GetInstanceInfo(457).." - "..EJ_GetEncounterInfo(1154),	-- Legs
		},
		{	-- Deathknight
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			subSetName = "dk",
			icon = "dk",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115539,	-- Ogreskull Boneplate Greathelm
				115536,	-- Ogreskull Boneplate Pauldrons
				115537,	-- Ogreskull Boneplate Breastplate
				115538,	-- Ogreskull Boneplate Gauntlets
				115535,	-- Ogreskull Boneplate Greaves
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115542,	-- Living Wood Headpiece
				115544,	-- Living Wood Spaulders
				115540,	-- Living Wood Raiment
				115541,	-- Living Wood Grips
				115543,	-- Living Wood Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115545,	-- Rylakstalker's Headguard
				115547,	-- Rylakstalker's Spaulders
				115548,	-- Rylakstalker's Tunic
				115549,	-- Rylakstalker's Gloves
				115546,	-- Rylakstalker's Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115553,	-- Arcanoshatter Hood
				115551,	-- Arcanoshatter Mantle
				115550,	-- Arcanoshatter Robes
				115552,	-- Arcanoshatter Gloves
				115554,	-- Arcanoshatter Leggings
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Monk
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"],
			subSetName = "monk",
			icon = "monk",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115556,	-- Helm of the Somber Gaze
				115559,	-- Mantle of the Somber Gaze
				115558,	-- Vest of the Somber Gaze
				115555,	-- Handwraps of the Somber Gaze
				115557,	-- Legwraps of the Somber Gaze
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115568,	-- Helmet of Guiding Light
				115565,	-- Pauldrons of Guiding Light
				115566,	-- Battleplate of Guiding Light
				115567,	-- Gauntlets of Guiding Light
				115569,	-- Legplates of Guiding Light
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115563,	-- Soul Priest's Hood
				115561,	-- Soul Priest's Shoulderguards
				115560,	-- Soul Priest's Raiment
				115562,	-- Soul Priest's Gloves
				115564,	-- Soul Priest's Leggings
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115572,	-- Poisoner's Helmet
				115574,	-- Poisoner's Spaulders
				115570,	-- Poisoner's Tunic
				115571,	-- Poisoner's Gloves
				115573,	-- Poisoner's Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115579,	-- Windspeaker's Faceguard
				115576,	-- Windspeaker's Mantle
				115577,	-- Windspeaker's Tunic
				115578,	-- Windspeaker's Handwraps
				115575,	-- Windspeaker's Legwraps
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115586,	-- Shadow Council's Hood
				115589,	-- Shadow Council's Mantle
				115588,	-- Shadow Council's Robes
				115585,	-- Shadow Council's Gloves
				115587,	-- Shadow Council's Leggings
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				115584,	-- Blackhand's Faceguard
				115581,	-- Blackhand's Shoulderguards
				115582,	-- Blackhand's Chestguard
				115583,	-- Blackhand's Handguards
				115580,	-- Blackhand's Legguards
			},
			[HEROIC_PRE_DIFF] = NORMAL_DIFF,
			[MYTHIC_PRE_DIFF] = NORMAL_DIFF,
		},
		{	-- LFR Cloth
			name = ALIL["Cloth"].." "..AL["Armor"],
			subSetName = "rfcloth",
			icon = "mage",
			[RF_DIFF] = {
				120373,	-- Ebonflame Hood
				120376,	-- Ebonflame Spaulders
				120375,	-- Ebonflame Robes
				120374,	-- Ebonflame Grips
				120377,	-- Ebonflame Leggings
				120378,	-- Ebonflame Sandals
			},
		},
		{	-- LFR Leather
			name = ALIL["Leather"].." "..AL["Armor"],
			subSetName = "rfleather",
			icon = "rogue",
			[RF_DIFF] = {
				120382,	-- Sootfur Cap
				120381,	-- Sootfur Shoulderguards
				120380,	-- Sootfur Harness
				120384,	-- Sootfur Gauntlets
				120379,	-- Sootfur Legwraps
				120383,	-- Sootfur Stompers
			},
		},
		{	-- LFR Mail
			name = ALIL["Mail"].." "..AL["Armor"],
			subSetName = "rfmail",
			icon = "hunter",
			[RF_DIFF] = {
				120390,	-- Ashlink Coif
				120388,	-- Ashlink Pauldrons
				120389,	-- Ashlink Hauberk
				120386,	-- Ashlink Gloves
				120385,	-- Ashlink Legguards
				120387,	-- Ashlink Treads
			},
		},
		{	-- LFR Plate
			name = ALIL["Plate"].." "..AL["Armor"],
			subSetName = "rfplate",
			icon = "warri",
			[RF_DIFF] = {
				120396,	-- Blacksteel Casque
				120395,	-- Blacksteel Shoulderplates
				120393,	-- Blacksteel Chestplate
				120392,	-- Blacksteel Gauntlets
				120391,	-- Blacksteel Legplates
				120394,	-- Blacksteel Greatboots
			},
		},
	},

	["Tier16"] = {	-- T16 Sets
		name = format(AL["Tier %d Sets"], 16),
		sourceTemplate = {
			EJ_GetInstanceInfo(369).." - "..EJ_GetEncounterInfo(851),	-- Head
			EJ_GetInstanceInfo(369).." - "..EJ_GetEncounterInfo(865),	-- Shoulder
			EJ_GetInstanceInfo(369).." - "..EJ_GetEncounterInfo(867),	-- Chest
			EJ_GetInstanceInfo(369).." - "..EJ_GetEncounterInfo(850),	-- Hands
			EJ_GetInstanceInfo(369).." - "..EJ_GetEncounterInfo(853),	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99049,	-- Faceguard of Cyclopean Dread
				99040,	-- Shoulderguards of Cyclopean Dread
				99060,	-- Chestguard of Cyclopean Dread
				99048,	-- Handguards of Cyclopean Dread
				99039,	-- Legguards of Cyclopean Dread
			},
			[NORMAL_DIFF] = {
				99605,	-- Faceguard of Cyclopean Dread
				99652,	-- Shoulderguards of Cyclopean Dread
				99640,	-- Chestguard of Cyclopean Dread
				99604,	-- Handguards of Cyclopean Dread
				99564,	-- Legguards of Cyclopean Dread
			},
			[HEROIC_DIFF] = {
				99190,	-- Faceguard of Cyclopean Dread
				99179,	-- Shoulderguards of Cyclopean Dread
				99188,	-- Chestguard of Cyclopean Dread
				99189,	-- Handguards of Cyclopean Dread
				99191,	-- Legguards of Cyclopean Dread
			},
			[MYTHIC_DIFF] = {
				99323,	-- Faceguard of Cyclopean Dread
				99325,	-- Shoulderguards of Cyclopean Dread
				99330,	-- Chestguard of Cyclopean Dread
				99331,	-- Handguards of Cyclopean Dread
				99324,	-- Legguards of Cyclopean Dread
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99057,	-- Helmet of Cyclopean Dread
				99059,	-- Pauldrons of Cyclopean Dread
				99066,	-- Breastplate of Cyclopean Dread
				99067,	-- Gauntlets of Cyclopean Dread
				99058,	-- Greaves of Cyclopean Dread
			},
			[NORMAL_DIFF] = {
				99571,	-- Helmet of Cyclopean Dread
				99639,	-- Pauldrons of Cyclopean Dread
				99608,	-- Breastplate of Cyclopean Dread
				99609,	-- Gauntlets of Cyclopean Dread
				99572,	-- Greaves of Cyclopean Dread
			},
			[HEROIC_DIFF] = {
				99194,	-- Helmet of Cyclopean Dread
				99187,	-- Pauldrons of Cyclopean Dread
				99192,	-- Breastplate of Cyclopean Dread
				99193,	-- Gauntlets of Cyclopean Dread
				99186,	-- Greaves of Cyclopean Dread
			},
			[MYTHIC_DIFF] = {
				99337,	-- Helmet of Cyclopean Dread
				99339,	-- Pauldrons of Cyclopean Dread
				99335,	-- Breastplate of Cyclopean Dread
				99336,	-- Gauntlets of Cyclopean Dread
				99338,	-- Greaves of Cyclopean Dread
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				98995,	-- Cover of the Shattered Vale
				98998,	-- Shoulderwraps of the Shattered Vale
				98997,	-- Vestment of the Shattered Vale
				98994,	-- Gloves of the Shattered Vale
				98996,	-- Leggings of the Shattered Vale
			},
			[NORMAL_DIFF] = {
				99618,	-- Cover of the Shattered Vale
				99621,	-- Shoulderwraps of the Shattered Vale
				99620,	-- Vestment of the Shattered Vale
				99617,	-- Gloves of the Shattered Vale
				99619,	-- Leggings of the Shattered Vale
			},
			[HEROIC_DIFF] = {
				99175,	-- Cover of the Shattered Vale
				99169,	-- Shoulderwraps of the Shattered Vale
				99177,	-- Vestment of the Shattered Vale
				99174,	-- Gloves of the Shattered Vale
				99176,	-- Leggings of the Shattered Vale
			},
			[MYTHIC_DIFF] = {
				99433,	-- Cover of the Shattered Vale
				99428,	-- Shoulderwraps of the Shattered Vale
				99427,	-- Vestment of the Shattered Vale
				99432,	-- Gloves of the Shattered Vale
				99434,	-- Leggings of the Shattered Vale
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99043,	-- Headpiece of the Shattered Vale
				99022,	-- Spaulders of the Shattered Vale
				99041,	-- Raiment of the Shattered Vale
				99042,	-- Grips of the Shattered Vale
				99044,	-- Legguards of the Shattered Vale
			},
			[NORMAL_DIFF] = {
				99599,	-- Headpiece of the Shattered Vale
				99589,	-- Spaulders of the Shattered Vale
				99632,	-- Raiment of the Shattered Vale
				99633,	-- Grips of the Shattered Vale
				99600,	-- Legguards of the Shattered Vale
			},
			[HEROIC_DIFF] = {
				99182,	-- Headpiece of the Shattered Vale
				99184,	-- Spaulders of the Shattered Vale
				99180,	-- Raiment of the Shattered Vale
				99181,	-- Grips of the Shattered Vale
				99183,	-- Legguards of the Shattered Vale
			},
			[MYTHIC_DIFF] = {
				99328,	-- Headpiece of the Shattered Vale
				99322,	-- Spaulders of the Shattered Vale
				99326,	-- Raiment of the Shattered Vale
				99327,	-- Grips of the Shattered Vale
				99329,	-- Legguards of the Shattered Vale
			},
		},
		{	-- Druid - Guardian
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Guardian"]..")",
			subSetName = "druidguardian",
			icon = "druidTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99001,	-- Headguard of the Shattered Vale
				98978,	-- Shoulderguards of the Shattered Vale
				98999,	-- Tunic of the Shattered Vale
				99000,	-- Handguards of the Shattered Vale
				98981,	-- Breeches of the Shattered Vale
			},
			[NORMAL_DIFF] = {
				99624,	-- Headguard of the Shattered Vale
				99664,	-- Shoulderguards of the Shattered Vale
				99622,	-- Tunic of the Shattered Vale
				99623,	-- Handguards of the Shattered Vale
				99610,	-- Breeches of the Shattered Vale
			},
			[HEROIC_DIFF] = {
				99164,	-- Headguard of the Shattered Vale
				99166,	-- Shoulderguards of the Shattered Vale
				99170,	-- Tunic of the Shattered Vale
				99163,	-- Handguards of the Shattered Vale
				99165,	-- Breeches of the Shattered Vale
			},
			[MYTHIC_DIFF] = {
				99421,	-- Headguard of the Shattered Vale
				99423,	-- Shoulderguards of the Shattered Vale
				99419,	-- Tunic of the Shattered Vale
				99420,	-- Handguards of the Shattered Vale
				99422,	-- Breeches of the Shattered Vale
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99013,	-- Helm of the Shattered Vale
				99016,	-- Mantle of the Shattered Vale
				99015,	-- Robes of the Shattered Vale
				99012,	-- Handwraps of the Shattered Vale
				99014,	-- Legwraps of the Shattered Vale
			},
			[NORMAL_DIFF] = {
				99638,	-- Helm of the Shattered Vale
				99583,	-- Mantle of the Shattered Vale
				99582,	-- Robes of the Shattered Vale
				99637,	-- Handwraps of the Shattered Vale
				99581,	-- Legwraps of the Shattered Vale
			},
			[HEROIC_DIFF] = {
				99178,	-- Helm of the Shattered Vale
				99173,	-- Mantle of the Shattered Vale
				99172,	-- Robes of the Shattered Vale
				99185,	-- Handwraps of the Shattered Vale
				99171,	-- Legwraps of the Shattered Vale
			},
			[MYTHIC_DIFF] = {
				99436,	-- Helm of the Shattered Vale
				99431,	-- Mantle of the Shattered Vale
				99430,	-- Robes of the Shattered Vale
				99435,	-- Handwraps of the Shattered Vale
				99429,	-- Legwraps of the Shattered Vale
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99080,	-- Headguard of the Unblinking Vigil
				99082,	-- Spaulders of the Unblinking Vigil
				99085,	-- Tunic of the Unblinking Vigil
				99086,	-- Gloves of the Unblinking Vigil
				99081,	-- Legguards of the Unblinking Vigil
			},
			[NORMAL_DIFF] = {
				99660,	-- Headguard of the Unblinking Vigil
				99574,	-- Spaulders of the Unblinking Vigil
				99577,	-- Tunic of the Unblinking Vigil
				99578,	-- Gloves of the Unblinking Vigil
				99573,	-- Legguards of the Unblinking Vigil
			},
			[HEROIC_DIFF] = {
				99157,	-- Headguard of the Unblinking Vigil
				99159,	-- Spaulders of the Unblinking Vigil
				99167,	-- Tunic of the Unblinking Vigil
				99168,	-- Gloves of the Unblinking Vigil
				99158,	-- Legguards of the Unblinking Vigil
			},
			[MYTHIC_DIFF] = {
				99402,	-- Headguard of the Unblinking Vigil
				99404,	-- Spaulders of the Unblinking Vigil
				99405,	-- Tunic of the Unblinking Vigil
				99406,	-- Gloves of the Unblinking Vigil
				99403,	-- Legguards of the Unblinking Vigil
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99084,	-- Chronomancer Hood
				99079,	-- Chronomancer Mantle
				99078,	-- Chronomancer Robes
				99083,	-- Chronomancer Gloves
				99077,	-- Chronomancer Leggings
			},
			[NORMAL_DIFF] = {
				99576,	-- Chronomancer Hood
				99659,	-- Chronomancer Mantle
				99658,	-- Chronomancer Robes
				99575,	-- Chronomancer Gloves
				99657,	-- Chronomancer Leggings
			},
			[HEROIC_DIFF] = {
				99161,	-- Chronomancer Hood
				99153,	-- Chronomancer Mantle
				99152,	-- Chronomancer Robes
				99160,	-- Chronomancer Gloves
				99162,	-- Chronomancer Leggings
			},
			[MYTHIC_DIFF] = {
				99398,	-- Chronomancer Hood
				99401,	-- Chronomancer Mantle
				99400,	-- Chronomancer Robes
				99397,	-- Chronomancer Gloves
				99399,	-- Chronomancer Leggings
			},
		},
		{	-- Monk - Brewmaster
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Brewmaster"]..")",
			subSetName = "monkbrewmaster",
			icon = "monkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99065,	-- Crown of Seven Sacred Seals
				99051,	-- Shoulderguards of Seven Sacred Seals
				99063,	-- Chestguard of Seven Sacred Seals
				99064,	-- Gauntlets of Seven Sacred Seals
				99050,	-- Legguards of Seven Sacred Seals
			},
			[NORMAL_DIFF] = {
				99607,	-- Crown of Seven Sacred Seals
				99565,	-- Shoulderguards of Seven Sacred Seals
				99643,	-- Chestguard of Seven Sacred Seals
				99644,	-- Gauntlets of Seven Sacred Seals
				99606,	-- Legguards of Seven Sacred Seals
			},
			[HEROIC_DIFF] = {
				99142,	-- Crown of Seven Sacred Seals
				99144,	-- Shoulderguards of Seven Sacred Seals
				99140,	-- Chestguard of Seven Sacred Seals
				99141,	-- Gauntlets of Seven Sacred Seals
				99143,	-- Legguards of Seven Sacred Seals
			},
			[MYTHIC_DIFF] = {
				99384,	-- Crown of Seven Sacred Seals
				99386,	-- Shoulderguards of Seven Sacred Seals
				99382,	-- Chestguard of Seven Sacred Seals
				99383,	-- Gauntlets of Seven Sacred Seals
				99385,	-- Legguards of Seven Sacred Seals
			},
		},
		{	-- Monk - Mistweaver
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Mistweaver"]..")",
			subSetName = "monkmistweaver",
			icon = "monkHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99069,	-- Helm of Seven Sacred Seals
				99062,	-- Mantle of Seven Sacred Seals
				99061,	-- Vest of Seven Sacred Seals
				99068,	-- Handwraps of Seven Sacred Seals
				99070,	-- Legwraps of Seven Sacred Seals
			},
			[NORMAL_DIFF] = {
				99553,	-- Helm of Seven Sacred Seals
				99642,	-- Mantle of Seven Sacred Seals
				99641,	-- Vest of Seven Sacred Seals
				99552,	-- Handwraps of Seven Sacred Seals
				99554,	-- Legwraps of Seven Sacred Seals
			},
			[HEROIC_DIFF] = {
				99148,	-- Helm of Seven Sacred Seals
				99151,	-- Mantle of Seven Sacred Seals
				99150,	-- Vest of Seven Sacred Seals
				99147,	-- Handwraps of Seven Sacred Seals
				99149,	-- Legwraps of Seven Sacred Seals
			},
			[MYTHIC_DIFF] = {
				99389,	-- Helm of Seven Sacred Seals
				99381,	-- Mantle of Seven Sacred Seals
				99391,	-- Vest of Seven Sacred Seals
				99388,	-- Handwraps of Seven Sacred Seals
				99390,	-- Legwraps of Seven Sacred Seals
			},
		},
		{	-- Monk - Windwalker
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Windwalker"]..")",
			subSetName = "monkwindwalker",
			icon = "monkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99073,	-- Headpiece of Seven Sacred Seals
				99075,	-- Spaulders of Seven Sacred Seals
				99071,	-- Tunic of Seven Sacred Seals
				99072,	-- Grips of Seven Sacred Seals
				99074,	-- Leggings of Seven Sacred Seals
			},
			[NORMAL_DIFF] = {
				99653,	-- Headpiece of Seven Sacred Seals
				99655,	-- Spaulders of Seven Sacred Seals
				99555,	-- Tunic of Seven Sacred Seals
				99556,	-- Grips of Seven Sacred Seals
				99654,	-- Leggings of Seven Sacred Seals
			},
			[HEROIC_DIFF] = {
				99156,	-- Headpiece of Seven Sacred Seals
				99146,	-- Spaulders of Seven Sacred Seals
				99154,	-- Tunic of Seven Sacred Seals
				99155,	-- Grips of Seven Sacred Seals
				99145,	-- Leggings of Seven Sacred Seals
			},
			[MYTHIC_DIFF] = {
				99393,	-- Headpiece of Seven Sacred Seals
				99395,	-- Spaulders of Seven Sacred Seals
				99396,	-- Tunic of Seven Sacred Seals
				99392,	-- Grips of Seven Sacred Seals
				99394,	-- Leggings of Seven Sacred Seals
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				98979,	-- Headguard of Winged Triumph
				99076,	-- Mantle of Winged Triumph
				99003,	-- Breastplate of Winged Triumph
				98982,	-- Gloves of Winged Triumph
				98980,	-- Greaves of Winged Triumph
			},
			[NORMAL_DIFF] = {
				99665,	-- Headguard of Winged Triumph
				99656,	-- Mantle of Winged Triumph
				99626,	-- Breastplate of Winged Triumph
				99648,	-- Gloves of Winged Triumph
				99666,	-- Greaves of Winged Triumph
			},
			[HEROIC_DIFF] = {
				99135,	-- Headguard of Winged Triumph
				99125,	-- Mantle of Winged Triumph
				99133,	-- Breastplate of Winged Triumph
				99134,	-- Gloves of Winged Triumph
				99124,	-- Greaves of Winged Triumph
			},
			[MYTHIC_DIFF] = {
				99376,	-- Headguard of Winged Triumph
				99378,	-- Mantle of Winged Triumph
				99374,	-- Breastplate of Winged Triumph
				99375,	-- Gloves of Winged Triumph
				99377,	-- Greaves of Winged Triumph
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99029,	-- Faceguard of Winged Triumph
				99027,	-- Shoulderguards of Winged Triumph
				99031,	-- Chestguard of Winged Triumph
				99028,	-- Handguards of Winged Triumph
				99026,	-- Legguards of Winged Triumph
			},
			[NORMAL_DIFF] = {
				99596,	-- Faceguard of Winged Triumph
				99594,	-- Shoulderguards of Winged Triumph
				99598,	-- Chestguard of Winged Triumph
				99595,	-- Handguards of Winged Triumph
				99593,	-- Legguards of Winged Triumph
			},
			[HEROIC_DIFF] = {
				99128,	-- Faceguard of Winged Triumph
				99130,	-- Shoulderguards of Winged Triumph
				99126,	-- Chestguard of Winged Triumph
				99127,	-- Handguards of Winged Triumph
				99129,	-- Legguards of Winged Triumph
			},
			[MYTHIC_DIFF] = {
				99370,	-- Faceguard of Winged Triumph
				99364,	-- Shoulderguards of Winged Triumph
				99368,	-- Chestguard of Winged Triumph
				99369,	-- Handguards of Winged Triumph
				99371,	-- Legguards of Winged Triumph
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				98985,	-- Helmet of Winged Triumph
				98987,	-- Pauldrons of Winged Triumph
				99052,	-- Battleplate of Winged Triumph
				99002,	-- Gauntlets of Winged Triumph
				98986,	-- Legplates of Winged Triumph
			},
			[NORMAL_DIFF] = {
				99651,	-- Helmet of Winged Triumph
				99662,	-- Pauldrons of Winged Triumph
				99566,	-- Battleplate of Winged Triumph
				99625,	-- Gauntlets of Winged Triumph
				99661,	-- Legplates of Winged Triumph
			},
			[HEROIC_DIFF] = {
				99138,	-- Helmet of Winged Triumph
				99132,	-- Pauldrons of Winged Triumph
				99136,	-- Battleplate of Winged Triumph
				99137,	-- Gauntlets of Winged Triumph
				99139,	-- Legplates of Winged Triumph
			},
			[MYTHIC_DIFF] = {
				99379,	-- Helmet of Winged Triumph
				99373,	-- Pauldrons of Winged Triumph
				99387,	-- Battleplate of Winged Triumph
				99380,	-- Gauntlets of Winged Triumph
				99372,	-- Legplates of Winged Triumph
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99024,	-- Cowl of the Ternion Glory
				99018,	-- Mantle of the Ternion Glory
				99017,	-- Robes of the Ternion Glory
				99023,	-- Handwraps of the Ternion Glory
				99025,	-- Legwraps of the Ternion Glory
			},
			[NORMAL_DIFF] = {
				99591,	-- Cowl of the Ternion Glory
				99585,	-- Mantle of the Ternion Glory
				99584,	-- Robes of the Ternion Glory
				99590,	-- Handwraps of the Ternion Glory
				99592,	-- Legwraps of the Ternion Glory
			},
			[HEROIC_DIFF] = {
				99117,	-- Cowl of the Ternion Glory
				99120,	-- Mantle of the Ternion Glory
				99119,	-- Robes of the Ternion Glory
				99131,	-- Handwraps of the Ternion Glory
				99118,	-- Legwraps of the Ternion Glory
			},
			[MYTHIC_DIFF] = {
				99366,	-- Cowl of the Ternion Glory
				99358,	-- Mantle of the Ternion Glory
				99357,	-- Robes of the Ternion Glory
				99365,	-- Handwraps of the Ternion Glory
				99367,	-- Legwraps of the Ternion Glory
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99020,	-- Hood of the Ternion Glory
				99005,	-- Shoulderguards of the Ternion Glory
				99004,	-- Raiment of the Ternion Glory
				99019,	-- Gloves of the Ternion Glory
				99021,	-- Leggings of the Ternion Glory
			},
			[NORMAL_DIFF] = {
				99587,	-- Hood of the Ternion Glory
				99628,	-- Shoulderguards of the Ternion Glory
				99627,	-- Raiment of the Ternion Glory
				99586,	-- Gloves of the Ternion Glory
				99588,	-- Leggings of the Ternion Glory
			},
			[HEROIC_DIFF] = {
				99122,	-- Hood of the Ternion Glory
				99111,	-- Shoulderguards of the Ternion Glory
				99110,	-- Raiment of the Ternion Glory
				99121,	-- Gloves of the Ternion Glory
				99123,	-- Leggings of the Ternion Glory
			},
			[MYTHIC_DIFF] = {
				99360,	-- Hood of the Ternion Glory
				99363,	-- Shoulderguards of the Ternion Glory
				99362,	-- Raiment of the Ternion Glory
				99359,	-- Gloves of the Ternion Glory
				99361,	-- Leggings of the Ternion Glory
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99008,	-- Helmet of the Barbed Assassin
				99010,	-- Spaulders of the Barbed Assassin
				99006,	-- Tunic of the Barbed Assassin
				99007,	-- Gloves of the Barbed Assassin
				99009,	-- Legguards of the Barbed Assassin
			},
			[NORMAL_DIFF] = {
				99631,	-- Helmet of the Barbed Assassin
				99635,	-- Spaulders of the Barbed Assassin
				99629,	-- Tunic of the Barbed Assassin
				99630,	-- Gloves of the Barbed Assassin
				99634,	-- Legguards of the Barbed Assassin
			},
			[HEROIC_DIFF] = {
				99114,	-- Helmet of the Barbed Assassin
				99116,	-- Spaulders of the Barbed Assassin
				99112,	-- Tunic of the Barbed Assassin
				99113,	-- Gloves of the Barbed Assassin
				99115,	-- Legguards of the Barbed Assassin
			},
			[MYTHIC_DIFF] = {
				99348,	-- Helmet of the Barbed Assassin
				99350,	-- Spaulders of the Barbed Assassin
				99356,	-- Tunic of the Barbed Assassin
				99355,	-- Gloves of the Barbed Assassin
				99349,	-- Legguards of the Barbed Assassin
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99089,	-- Headpiece of Celestial Harmony
				99091,	-- Shoulderwraps of Celestial Harmony
				99087,	-- Hauberk of Celestial Harmony
				99088,	-- Gloves of Celestial Harmony
				99090,	-- Kilt of Celestial Harmony
			},
			[NORMAL_DIFF] = {
				99645,	-- Headpiece of Celestial Harmony
				99647,	-- Shoulderwraps of Celestial Harmony
				99579,	-- Hauberk of Celestial Harmony
				99580,	-- Gloves of Celestial Harmony
				99646,	-- Kilt of Celestial Harmony
			},
			[HEROIC_DIFF] = {
				99093,	-- Headpiece of Celestial Harmony
				99095,	-- Shoulderwraps of Celestial Harmony
				99106,	-- Hauberk of Celestial Harmony
				99092,	-- Gloves of Celestial Harmony
				99094,	-- Kilt of Celestial Harmony
			},
			[MYTHIC_DIFF] = {
				99332,	-- Headpiece of Celestial Harmony
				99334,	-- Shoulderwraps of Celestial Harmony
				99344,	-- Hauberk of Celestial Harmony
				99345,	-- Gloves of Celestial Harmony
				99333,	-- Kilt of Celestial Harmony
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				98983,	-- Helmet of Celestial Harmony
				98977,	-- Spaulders of Celestial Harmony
				98992,	-- Cuirass of Celestial Harmony
				98993,	-- Grips of Celestial Harmony
				98984,	-- Legguards of Celestial Harmony
			},
			[NORMAL_DIFF] = {
				99649,	-- Helmet of Celestial Harmony
				99663,	-- Spaulders of Celestial Harmony
				99615,	-- Cuirass of Celestial Harmony
				99616,	-- Grips of Celestial Harmony
				99650,	-- Legguards of Celestial Harmony
			},
			[HEROIC_DIFF] = {
				99103,	-- Helmet of Celestial Harmony
				99105,	-- Spaulders of Celestial Harmony
				99101,	-- Cuirass of Celestial Harmony
				99102,	-- Grips of Celestial Harmony
				99104,	-- Legguards of Celestial Harmony
			},
			[MYTHIC_DIFF] = {
				99341,	-- Helmet of Celestial Harmony
				99343,	-- Spaulders of Celestial Harmony
				99347,	-- Cuirass of Celestial Harmony
				99340,	-- Grips of Celestial Harmony
				99342,	-- Legguards of Celestial Harmony
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				98989,	-- Faceguard of Celestial Harmony
				98991,	-- Mantle of Celestial Harmony
				99011,	-- Tunic of Celestial Harmony
				98988,	-- Handwraps of Celestial Harmony
				98990,	-- Legwraps of Celestial Harmony
			},
			[NORMAL_DIFF] = {
				99612,	-- Faceguard of Celestial Harmony
				99614,	-- Mantle of Celestial Harmony
				99636,	-- Tunic of Celestial Harmony
				99611,	-- Handwraps of Celestial Harmony
				99613,	-- Legwraps of Celestial Harmony
			},
			[HEROIC_DIFF] = {
				99109,	-- Faceguard of Celestial Harmony
				99100,	-- Mantle of Celestial Harmony
				99107,	-- Tunic of Celestial Harmony
				99108,	-- Handwraps of Celestial Harmony
				99099,	-- Legwraps of Celestial Harmony
			},
			[MYTHIC_DIFF] = {
				99353,	-- Faceguard of Celestial Harmony
				99346,	-- Mantle of Celestial Harmony
				99351,	-- Tunic of Celestial Harmony
				99352,	-- Handwraps of Celestial Harmony
				99354,	-- Legwraps of Celestial Harmony
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99054,	-- Hood of the Horned Nightmare
				99045,	-- Mantle of the Horned Nightmare
				99056,	-- Robes of the Horned Nightmare
				99053,	-- Gloves of the Horned Nightmare
				99055,	-- Leggings of the Horned Nightmare
			},
			[NORMAL_DIFF] = {
				99568,	-- Hood of the Horned Nightmare
				99601,	-- Mantle of the Horned Nightmare
				99570,	-- Robes of the Horned Nightmare
				99567,	-- Gloves of the Horned Nightmare
				99569,	-- Leggings of the Horned Nightmare
			},
			[HEROIC_DIFF] = {
				99097,	-- Hood of the Horned Nightmare
				99205,	-- Mantle of the Horned Nightmare
				99204,	-- Robes of the Horned Nightmare
				99096,	-- Gloves of the Horned Nightmare
				99098,	-- Leggings of the Horned Nightmare
			},
			[MYTHIC_DIFF] = {
				99425,	-- Hood of the Horned Nightmare
				99417,	-- Mantle of the Horned Nightmare
				99416,	-- Robes of the Horned Nightmare
				99424,	-- Gloves of the Horned Nightmare
				99426,	-- Leggings of the Horned Nightmare
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99046,	-- Helmet of the Prehistoric Marauder
				99036,	-- Pauldrons of the Prehistoric Marauder
				99047,	-- Battleplate of the Prehistoric Marauder
				99034,	-- Gauntlets of the Prehistoric Marauder
				99035,	-- Legplates of the Prehistoric Marauder
			},
			[NORMAL_DIFF] = {
				99602,	-- Helmet of the Prehistoric Marauder
				99561,	-- Pauldrons of the Prehistoric Marauder
				99603,	-- Battleplate of the Prehistoric Marauder
				99559,	-- Gauntlets of the Prehistoric Marauder
				99560,	-- Legplates of the Prehistoric Marauder
			},
			[HEROIC_DIFF] = {
				99206,	-- Helmet of the Prehistoric Marauder
				99200,	-- Pauldrons of the Prehistoric Marauder
				99197,	-- Battleplate of the Prehistoric Marauder
				99198,	-- Gauntlets of the Prehistoric Marauder
				99199,	-- Legplates of the Prehistoric Marauder
			},
			[MYTHIC_DIFF] = {
				99418,	-- Helmet of the Prehistoric Marauder
				99414,	-- Pauldrons of the Prehistoric Marauder
				99411,	-- Battleplate of the Prehistoric Marauder
				99412,	-- Gauntlets of the Prehistoric Marauder
				99413,	-- Legplates of the Prehistoric Marauder
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				99032,	-- Faceguard of the Prehistoric Marauder
				99030,	-- Shoulderguards of the Prehistoric Marauder
				99037,	-- Chestguard of the Prehistoric Marauder
				99038,	-- Handguards of the Prehistoric Marauder
				99033,	-- Legguards of the Prehistoric Marauder
			},
			[NORMAL_DIFF] = {
				99557,	-- Faceguard of the Prehistoric Marauder
				99597,	-- Shoulderguards of the Prehistoric Marauder
				99562,	-- Chestguard of the Prehistoric Marauder
				99563,	-- Handguards of the Prehistoric Marauder
				99558,	-- Legguards of the Prehistoric Marauder
			},
			[HEROIC_DIFF] = {
				99203,	-- Faceguard of the Prehistoric Marauder
				99196,	-- Shoulderguards of the Prehistoric Marauder
				99201,	-- Chestguard of the Prehistoric Marauder
				99202,	-- Handguards of the Prehistoric Marauder
				99195,	-- Legguards of the Prehistoric Marauder
			},
			[MYTHIC_DIFF] = {
				99409,	-- Faceguard of the Prehistoric Marauder
				99407,	-- Shoulderguards of the Prehistoric Marauder
				99415,	-- Chestguard of the Prehistoric Marauder
				99408,	-- Handguards of the Prehistoric Marauder
				99410,	-- Legguards of the Prehistoric Marauder
			},
		},
	},

	["Tier15"] = {	-- T15 Sets
		name = format(AL["Tier %d Sets"], 15),
		sourceTemplate = {
			EJ_GetInstanceInfo(362).." - "..EJ_GetEncounterInfo(829),	-- Head
			EJ_GetInstanceInfo(362).." - "..EJ_GetEncounterInfo(817),	-- Shoulder
			EJ_GetInstanceInfo(362).." - "..EJ_GetEncounterInfo(824),	-- Chest
			EJ_GetInstanceInfo(362).." - "..EJ_GetEncounterInfo(816),	-- Hands
			EJ_GetInstanceInfo(362).." - "..EJ_GetEncounterInfo(828),	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95832,	-- Faceguard of the All-Consuming Maw
				95834,	-- Shoulderguards of the All-Consuming Maw
				95830,	-- Chestguard of the All-Consuming Maw
				95831,	-- Handguards of the All-Consuming Maw
				95833,	-- Legguards of the All-Consuming Maw
			},
			[NORMAL_DIFF] = {
				95232,	-- Faceguard of the All-Consuming Maw
				95234,	-- Shoulderguards of the All-Consuming Maw
				95230,	-- Chestguard of the All-Consuming Maw
				95231,	-- Handguards of the All-Consuming Maw
				95233,	-- Legguards of the All-Consuming Maw
			},
			[HEROIC_DIFF] = {
				96576,	-- Faceguard of the All-Consuming Maw
				96578,	-- Shoulderguards of the All-Consuming Maw
				96574,	-- Chestguard of the All-Consuming Maw
				96575,	-- Handguards of the All-Consuming Maw
				96577,	-- Legguards of the All-Consuming Maw
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95827,	-- Helmet of the All-Consuming Maw
				95829,	-- Pauldrons of the All-Consuming Maw
				95825,	-- Breastplate of the All-Consuming Maw
				95826,	-- Gauntlets of the All-Consuming Maw
				95828,	-- Greaves of the All-Consuming Maw
			},
			[NORMAL_DIFF] = {
				95227,	-- Helmet of the All-Consuming Maw
				95229,	-- Pauldrons of the All-Consuming Maw
				95225,	-- Breastplate of the All-Consuming Maw
				95226,	-- Gauntlets of the All-Consuming Maw
				95228,	-- Greaves of the All-Consuming Maw
			},
			[HEROIC_DIFF] = {
				96571,	-- Helmet of the All-Consuming Maw
				96573,	-- Pauldrons of the All-Consuming Maw
				96569,	-- Breastplate of the All-Consuming Maw
				96570,	-- Gauntlets of the All-Consuming Maw
				96572,	-- Greaves of the All-Consuming Maw
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95846,	-- Cover of the Haunted Forest
				95849,	-- Shoulderwraps of the Haunted Forest
				95848,	-- Vestment of the Haunted Forest
				95845,	-- Gloves of the Haunted Forest
				95847,	-- Leggings of the Haunted Forest
			},
			[NORMAL_DIFF] = {
				95246,	-- Cover of the Haunted Forest
				95249,	-- Shoulderwraps of the Haunted Forest
				95248,	-- Vestment of the Haunted Forest
				95245,	-- Gloves of the Haunted Forest
				95247,	-- Leggings of the Haunted Forest
			},
			[HEROIC_DIFF] = {
				96590,	-- Cover of the Haunted Forest
				96593,	-- Shoulderwraps of the Haunted Forest
				96592,	-- Vestment of the Haunted Forest
				96589,	-- Gloves of the Haunted Forest
				96591,	-- Leggings of the Haunted Forest
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95837,	-- Headpiece of the Haunted Forest
				95839,	-- Spaulders of the Haunted Forest
				95835,	-- Raiment of the Haunted Forest
				95836,	-- Grips of the Haunted Forest
				95838,	-- Legguards of the Haunted Forest
			},
			[NORMAL_DIFF] = {
				95237,	-- Headpiece of the Haunted Forest
				95239,	-- Spaulders of the Haunted Forest
				95235,	-- Raiment of the Haunted Forest
				95236,	-- Grips of the Haunted Forest
				95238,	-- Legguards of the Haunted Forest
			},
			[HEROIC_DIFF] = {
				96581,	-- Headpiece of the Haunted Forest
				96583,	-- Spaulders of the Haunted Forest
				96579,	-- Raiment of the Haunted Forest
				96580,	-- Grips of the Haunted Forest
				96582,	-- Legguards of the Haunted Forest
			},
		},
		{	-- Druid - Guardian
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Guardian"]..")",
			subSetName = "druidguardian",
			icon = "druidTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95852,	-- Headguard of the Haunted Forest
				95854,	-- Shoulderguards of the Haunted Forest
				95850,	-- Tunic of the Haunted Forest
				95851,	-- Handguards of the Haunted Forest
				95853,	-- Breeches of the Haunted Forest
			},
			[NORMAL_DIFF] = {
				95252,	-- Headguard of the Haunted Forest
				95254,	-- Shoulderguards of the Haunted Forest
				95250,	-- Tunic of the Haunted Forest
				95251,	-- Handguards of the Haunted Forest
				95253,	-- Breeches of the Haunted Forest
			},
			[HEROIC_DIFF] = {
				96596,	-- Headguard of the Haunted Forest
				96598,	-- Shoulderguards of the Haunted Forest
				96594,	-- Tunic of the Haunted Forest
				96595,	-- Handguards of the Haunted Forest
				96597,	-- Breeches of the Haunted Forest
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95841,	-- Helm of the Haunted Forest
				95844,	-- Mantle of the Haunted Forest
				95843,	-- Robes of the Haunted Forest
				95840,	-- Handwraps of the Haunted Forest
				95842,	-- Legwraps of the Haunted Forest
			},
			[NORMAL_DIFF] = {
				95241,	-- Helm of the Haunted Forest
				95244,	-- Mantle of the Haunted Forest
				95243,	-- Robes of the Haunted Forest
				95240,	-- Handwraps of the Haunted Forest
				95242,	-- Legwraps of the Haunted Forest
			},
			[HEROIC_DIFF] = {
				96585,	-- Helm of the Haunted Forest
				96588,	-- Mantle of the Haunted Forest
				96587,	-- Robes of the Haunted Forest
				96584,	-- Handwraps of the Haunted Forest
				96586,	-- Legwraps of the Haunted Forest
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95884,	-- Saurok Stalker's Headguard
				95886,	-- Saurok Stalker's Spaulders
				95882,	-- Saurok Stalker's Tunic
				95883,	-- Saurok Stalker's Gloves
				95885,	-- Saurok Stalker's Legguards
			},
			[NORMAL_DIFF] = {
				95257,	-- Saurok Stalker's Headguard
				95259,	-- Saurok Stalker's Spaulders
				95255,	-- Saurok Stalker's Tunic
				95256,	-- Saurok Stalker's Gloves
				95258,	-- Saurok Stalker's Legguards
			},
			[HEROIC_DIFF] = {
				96628,	-- Saurok Stalker's Headguard
				96630,	-- Saurok Stalker's Spaulders
				96626,	-- Saurok Stalker's Tunic
				96627,	-- Saurok Stalker's Gloves
				96629,	-- Saurok Stalker's Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95891,	-- Hood of the Chromatic Hydra
				95894,	-- Mantle of the Chromatic Hydra
				95893,	-- Robes of the Chromatic Hydra
				95890,	-- Gloves of the Chromatic Hydra
				95892,	-- Leggings of the Chromatic Hydra
			},
			[NORMAL_DIFF] = {
				95261,	-- Hood of the Chromatic Hydra
				95264,	-- Mantle of the Chromatic Hydra
				95263,	-- Robes of the Chromatic Hydra
				95260,	-- Gloves of the Chromatic Hydra
				95262,	-- Leggings of the Chromatic Hydra
			},
			[HEROIC_DIFF] = {
				96635,	-- Hood of the Chromatic Hydra
				96638,	-- Mantle of the Chromatic Hydra
				96637,	-- Robes of the Chromatic Hydra
				96634,	-- Gloves of the Chromatic Hydra
				96636,	-- Leggings of the Chromatic Hydra
			},
		},
		{	-- Monk - Brewmaster
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Brewmaster"]..")",
			subSetName = "monkbrewmaster",
			icon = "monkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95907,	-- Fire-Charm Crown
				95909,	-- Fire-Charm Shoulderguards
				95905,	-- Fire-Charm Chestguard
				95906,	-- Fire-Charm Gauntlets
				95908,	-- Fire-Charm Legguards
			},
			[NORMAL_DIFF] = {
				95277,	-- Fire-Charm Crown
				95279,	-- Fire-Charm Shoulderguards
				95275,	-- Fire-Charm Chestguard
				95276,	-- Fire-Charm Gauntlets
				95278,	-- Fire-Charm Legguards
			},
			[HEROIC_DIFF] = {
				96651,	-- Fire-Charm Crown
				96653,	-- Fire-Charm Shoulderguards
				96649,	-- Fire-Charm Chestguard
				96650,	-- Fire-Charm Gauntlets
				96652,	-- Fire-Charm Legguards
			},
		},
		{	-- Monk - Mistweaver
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Mistweaver"]..")",
			subSetName = "monkmistweaver",
			icon = "monkHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95901,	-- Fire-Charm Helm
				95904,	-- Fire-Charm Mantle
				95903,	-- Fire-Charm Vest
				95900,	-- Fire-Charm Handwraps
				95902,	-- Fire-Charm Legwraps
			},
			[NORMAL_DIFF] = {
				95271,	-- Fire-Charm Helm
				95274,	-- Fire-Charm Mantle
				95273,	-- Fire-Charm Vest
				95270,	-- Fire-Charm Handwraps
				95272,	-- Fire-Charm Legwraps
			},
			[HEROIC_DIFF] = {
				96645,	-- Fire-Charm Helm
				96648,	-- Fire-Charm Mantle
				96647,	-- Fire-Charm Vest
				96644,	-- Fire-Charm Handwraps
				96646,	-- Fire-Charm Legwraps
			},
		},
		{	-- Monk - Windwalker
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Windwalker"]..")",
			subSetName = "monkwindwalker",
			icon = "monkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95897,	-- Fire-Charm Headpiece
				95899,	-- Fire-Charm Spaulders
				95895,	-- Fire-Charm Tunic
				95896,	-- Fire-Charm Grips
				95898,	-- Fire-Charm Leggings
			},
			[NORMAL_DIFF] = {
				95267,	-- Fire-Charm Headpiece
				95269,	-- Fire-Charm Spaulders
				95265,	-- Fire-Charm Tunic
				95266,	-- Fire-Charm Grips
				95268,	-- Fire-Charm Leggings
			},
			[HEROIC_DIFF] = {
				96641,	-- Fire-Charm Headpiece
				96643,	-- Fire-Charm Spaulders
				96639,	-- Fire-Charm Tunic
				96640,	-- Fire-Charm Grips
				96642,	-- Fire-Charm Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95917,	-- Lightning Emperor's Headguard
				95919,	-- Lightning Emperor's Mantle
				95915,	-- Lightning Emperor's Breastplate
				95916,	-- Lightning Emperor's Gloves
				95918,	-- Lightning Emperor's Greaves
			},
			[NORMAL_DIFF] = {
				95287,	-- Lightning Emperor's Headguard
				95289,	-- Lightning Emperor's Mantle
				95285,	-- Lightning Emperor's Breastplate
				95286,	-- Lightning Emperor's Gloves
				95288,	-- Lightning Emperor's Greaves
			},
			[HEROIC_DIFF] = {
				96661,	-- Lightning Emperor's Headguard
				96663,	-- Lightning Emperor's Mantle
				96659,	-- Lightning Emperor's Breastplate
				96660,	-- Lightning Emperor's Gloves
				96662,	-- Lightning Emperor's Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95922,	-- Lightning Emperor's Faceguard
				95924,	-- Lightning Emperor's Shoulderguards
				95920,	-- Lightning Emperor's Chestguard
				95921,	-- Lightning Emperor's Handguards
				95923,	-- Lightning Emperor's Legguards
			},
			[NORMAL_DIFF] = {
				95292,	-- Lightning Emperor's Faceguard
				95294,	-- Lightning Emperor's Shoulderguards
				95290,	-- Lightning Emperor's Chestguard
				95291,	-- Lightning Emperor's Handguards
				95293,	-- Lightning Emperor's Legguards
			},
			[HEROIC_DIFF] = {
				96666,	-- Lightning Emperor's Faceguard
				96668,	-- Lightning Emperor's Shoulderguards
				96664,	-- Lightning Emperor's Chestguard
				96665,	-- Lightning Emperor's Handguards
				96667,	-- Lightning Emperor's Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95912,	-- Lightning Emperor's Helmet
				95914,	-- Lightning Emperor's Pauldrons
				95910,	-- Lightning Emperor's Battleplate
				95911,	-- Lightning Emperor's Gauntlets
				95913,	-- Lightning Emperor's Legplates
			},
			[NORMAL_DIFF] = {
				95282,	-- Lightning Emperor's Helmet
				95284,	-- Lightning Emperor's Pauldrons
				95280,	-- Lightning Emperor's Battleplate
				95281,	-- Lightning Emperor's Gauntlets
				95283,	-- Lightning Emperor's Legplates
			},
			[HEROIC_DIFF] = {
				96656,	-- Lightning Emperor's Helmet
				96658,	-- Lightning Emperor's Pauldrons
				96654,	-- Lightning Emperor's Battleplate
				96655,	-- Lightning Emperor's Gauntlets
				96657,	-- Lightning Emperor's Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95926,	-- Cowl of the Exorcist
				95929,	-- Mantle of the Exorcist
				95928,	-- Robes of the Exorcist
				95925,	-- Handwraps of the Exorcist
				95927,	-- Legwraps of the Exorcist
			},
			[NORMAL_DIFF] = {
				95296,	-- Cowl of the Exorcist
				95299,	-- Mantle of the Exorcist
				95298,	-- Robes of the Exorcist
				95295,	-- Handwraps of the Exorcist
				95297,	-- Legwraps of the Exorcist
			},
			[HEROIC_DIFF] = {
				96670,	-- Cowl of the Exorcist
				96673,	-- Mantle of the Exorcist
				96672,	-- Robes of the Exorcist
				96669,	-- Handwraps of the Exorcist
				96671,	-- Legwraps of the Exorcist
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95931,	-- Hood of the Exorcist
				95934,	-- Shoulderguards of the Exorcist
				95933,	-- Raiment of the Exorcist
				95930,	-- Gloves of the Exorcist
				95932,	-- Leggings of the Exorcist
			},
			[NORMAL_DIFF] = {
				95301,	-- Hood of the Exorcist
				95304,	-- Shoulderguards of the Exorcist
				95303,	-- Raiment of the Exorcist
				95300,	-- Gloves of the Exorcist
				95302,	-- Leggings of the Exorcist
			},
			[HEROIC_DIFF] = {
				96675,	-- Hood of the Exorcist
				96678,	-- Shoulderguards of the Exorcist
				96677,	-- Raiment of the Exorcist
				96674,	-- Gloves of the Exorcist
				96676,	-- Leggings of the Exorcist
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95937,	-- Nine-Tailed Helmet
				95939,	-- Nine-Tailed Spaulders
				95935,	-- Nine-Tailed Tunic
				95936,	-- Nine-Tailed Gloves
				95938,	-- Nine-Tailed Legguards
			},
			[NORMAL_DIFF] = {
				95307,	-- Nine-Tailed Helmet
				95309,	-- Nine-Tailed Spaulders
				95305,	-- Nine-Tailed Tunic
				95306,	-- Nine-Tailed Gloves
				95308,	-- Nine-Tailed Legguards
			},
			[HEROIC_DIFF] = {
				96681,	-- Nine-Tailed Helmet
				96683,	-- Nine-Tailed Spaulders
				96679,	-- Nine-Tailed Tunic
				96680,	-- Nine-Tailed Gloves
				96682,	-- Nine-Tailed Legguards
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95952,	-- Headpiece of the Witch Doctor
				95954,	-- Shoulderwraps of the Witch Doctor
				95950,	-- Hauberk of the Witch Doctor
				95951,	-- Gloves of the Witch Doctor
				95953,	-- Kilt of the Witch Doctor
			},
			[NORMAL_DIFF] = {
				95322,	-- Headpiece of the Witch Doctor
				95324,	-- Shoulderwraps of the Witch Doctor
				95320,	-- Hauberk of the Witch Doctor
				95321,	-- Gloves of the Witch Doctor
				95323,	-- Kilt of the Witch Doctor
			},
			[HEROIC_DIFF] = {
				96696,	-- Headpiece of the Witch Doctor
				96698,	-- Shoulderwraps of the Witch Doctor
				96694,	-- Hauberk of the Witch Doctor
				96695,	-- Gloves of the Witch Doctor
				96697,	-- Kilt of the Witch Doctor
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95947,	-- Helmet of the Witch Doctor
				95949,	-- Spaulders of the Witch Doctor
				95945,	-- Cuirass of the Witch Doctor
				95946,	-- Grips of the Witch Doctor
				95948,	-- Legguards of the Witch Doctor
			},
			[NORMAL_DIFF] = {
				95317,	-- Helmet of the Witch Doctor
				95319,	-- Spaulders of the Witch Doctor
				95315,	-- Cuirass of the Witch Doctor
				95316,	-- Grips of the Witch Doctor
				95318,	-- Legguards of the Witch Doctor
			},
			[HEROIC_DIFF] = {
				96691,	-- Helmet of the Witch Doctor
				96693,	-- Spaulders of the Witch Doctor
				96689,	-- Cuirass of the Witch Doctor
				96690,	-- Grips of the Witch Doctor
				96692,	-- Legguards of the Witch Doctor
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95942,	-- Faceguard of the Witch Doctor
				95944,	-- Mantle of the Witch Doctor
				95940,	-- Tunic of the Witch Doctor
				95941,	-- Handwraps of the Witch Doctor
				95943,	-- Legwraps of the Witch Doctor
			},
			[NORMAL_DIFF] = {
				95312,	-- Faceguard of the Witch Doctor
				95314,	-- Mantle of the Witch Doctor
				95310,	-- Tunic of the Witch Doctor
				95311,	-- Handwraps of the Witch Doctor
				95313,	-- Legwraps of the Witch Doctor
			},
			[HEROIC_DIFF] = {
				96686,	-- Faceguard of the Witch Doctor
				96688,	-- Mantle of the Witch Doctor
				96684,	-- Tunic of the Witch Doctor
				96685,	-- Handwraps of the Witch Doctor
				96687,	-- Legwraps of the Witch Doctor
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95982,	-- Hood of the Thousandfold Hells
				95985,	-- Mantle of the Thousandfold Hells
				95984,	-- Robes of the Thousandfold Hells
				95981,	-- Gloves of the Thousandfold Hells
				95983,	-- Leggings of the Thousandfold Hells
			},
			[NORMAL_DIFF] = {
				95326,	-- Hood of the Thousandfold Hells
				95329,	-- Mantle of the Thousandfold Hells
				95328,	-- Robes of the Thousandfold Hells
				95325,	-- Gloves of the Thousandfold Hells
				95327,	-- Leggings of the Thousandfold Hells
			},
			[HEROIC_DIFF] = {
				96726,	-- Hood of the Thousandfold Hells
				96729,	-- Mantle of the Thousandfold Hells
				96728,	-- Robes of the Thousandfold Hells
				96725,	-- Gloves of the Thousandfold Hells
				96727,	-- Leggings of the Thousandfold Hells
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95986,	-- Helmet of the Last Mogu
				95990,	-- Pauldrons of the Last Mogu
				95987,	-- Battleplate of the Last Mogu
				95988,	-- Gauntlets of the Last Mogu
				95989,	-- Legplates of the Last Mogu
			},
			[NORMAL_DIFF] = {
				95330,	-- Helmet of the Last Mogu
				95334,	-- Pauldrons of the Last Mogu
				95331,	-- Battleplate of the Last Mogu
				95332,	-- Gauntlets of the Last Mogu
				95333,	-- Legplates of the Last Mogu
			},
			[HEROIC_DIFF] = {
				96730,	-- Helmet of the Last Mogu
				96734,	-- Pauldrons of the Last Mogu
				96731,	-- Battleplate of the Last Mogu
				96732,	-- Gauntlets of the Last Mogu
				96733,	-- Legplates of the Last Mogu
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				95993,	-- Faceguard of the Last Mogu
				95995,	-- Shoulderguards of the Last Mogu
				95991,	-- Chestguard of the Last Mogu
				95992,	-- Handguards of the Last Mogu
				95994,	-- Legguards of the Last Mogu
			},
			[NORMAL_DIFF] = {
				95337,	-- Faceguard of the Last Mogu
				95339,	-- Shoulderguards of Last Mogu
				95335,	-- Chestguard of the Last Mogu
				95336,	-- Handguards of the Last Mogu
				95338,	-- Legguards of the Last Mogu
			},
			[HEROIC_DIFF] = {
				96737,	-- Faceguard of the Last Mogu
				96739,	-- Shoulderguards of the Last Mogu
				96735,	-- Chestguard of the Last Mogu
				96736,	-- Handguards of the Last Mogu
				96738,	-- Legguards of the Last Mogu
			},
		},
	},

	["Tier14"] = {	-- T14 Sets
		name = format(AL["Tier %d Sets"], 14),
		sourceTemplate = {
			EJ_GetInstanceInfo(320).." - "..EJ_GetEncounterInfo(709),	-- Head
			EJ_GetInstanceInfo(320).." - "..EJ_GetEncounterInfo(729),	-- Shoulder
			EJ_GetInstanceInfo(330).." - "..EJ_GetEncounterInfo(743),	-- Chest
			EJ_GetInstanceInfo(330).." - "..EJ_GetEncounterInfo(741),	-- Hands
			EJ_GetInstanceInfo(330).." - "..EJ_GetEncounterInfo(737),	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86656,	-- Faceguard of the Lost Catacomb
				86654,	-- Shoulderguards of the Lost Catacomb
				86658,	-- Chestguard of the Lost Catacomb
				86657,	-- Handguards of the Lost Catacomb
				86655,	-- Legguards of the Lost Catacomb
			},
			[NORMAL_DIFF] = {
				85316,	-- Faceguard of the Lost Catacomb
				85314,	-- Shoulderguards of the Lost Catacomb
				85318,	-- Chestguard of the Lost Catacomb
				85317,	-- Handguards of the Lost Catacomb
				85315,	-- Legguards of the Lost Catacomb
			},
			[HEROIC_DIFF] = {
				86920,	-- Faceguard of the Lost Catacomb
				86922,	-- Shoulderguards of the Lost Catacomb
				86918,	-- Chestguard of the Lost Catacomb
				86919,	-- Handguards of the Lost Catacomb
				86921,	-- Legguards of the Lost Catacomb
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86676,	-- Helmet of the Lost Catacomb
				86674,	-- Pauldrons of the Lost Catacomb
				86678,	-- Breastplate of the Lost Catacomb
				86677,	-- Gauntlets of the Lost Catacomb
				86675,	-- Greaves of the Lost Catacomb
			},
			[NORMAL_DIFF] = {
				85336,	-- Helmet of the Lost Catacomb
				85334,	-- Pauldrons of the Lost Catacomb
				85338,	-- Breastplate of the Lost Catacomb
				85337,	-- Gauntlets of the Lost Catacomb
				85335,	-- Greaves of the Lost Catacomb
			},
			[HEROIC_DIFF] = {
				86915,	-- Helmet of the Lost Catacomb
				86917,	-- Pauldrons of the Lost Catacomb
				86913,	-- Breastplate of the Lost Catacomb
				86914,	-- Gauntlets of the Lost Catacomb
				86916,	-- Greaves of the Lost Catacomb
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86647,	-- Eternal Blossom Cover
				86644,	-- Eternal Blossom Shoulderwraps
				86645,	-- Eternal Blossom Vestment
				86648,	-- Eternal Blossom Gloves
				86646,	-- Eternal Blossom Leggings
			},
			[NORMAL_DIFF] = {
				85307,	-- Eternal Blossom Cover
				85304,	-- Eternal Blossom Shoulderwraps
				85305,	-- Eternal Blossom Vestment
				85308,	-- Eternal Blossom Gloves
				85306,	-- Eternal Blossom Leggings
			},
			[HEROIC_DIFF] = {
				86934,	-- Eternal Blossom Cover
				86937,	-- Eternal Blossom Shoulderwraps
				86936,	-- Eternal Blossom Vestment
				86933,	-- Eternal Blossom Gloves
				86935,	-- Eternal Blossom Leggings
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86651,	-- Eternal Blossom Headpiece
				86649,	-- Eternal Blossom Spaulders
				86653,	-- Eternal Blossom Raiment
				86652,	-- Eternal Blossom Grips
				86650,	-- Eternal Blossom Legguards
			},
			[NORMAL_DIFF] = {
				85311,	-- Eternal Blossom Headpiece
				85309,	-- Eternal Blossom Spaulders
				85313,	-- Eternal Blossom Raiment
				85312,	-- Eternal Blossom Grips
				85310,	-- Eternal Blossom Legguards
			},
			[HEROIC_DIFF] = {
				86925,	-- Eternal Blossom Headpiece
				86927,	-- Eternal Blossom Spaulders
				86923,	-- Eternal Blossom Raiment
				86924,	-- Eternal Blossom Grips
				86926,	-- Eternal Blossom Legguards
			},
		},
		{	-- Druid - Guardian
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Guardian"]..")",
			subSetName = "druidguardian",
			icon = "druidTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86721,	-- Eternal Blossom Headguard
				86723,	-- Eternal Blossom Shoulderguards
				86719,	-- Eternal Blossom Tunic
				86720,	-- Eternal Blossom Handguards
				86722,	-- Eternal Blossom Breeches
			},
			[NORMAL_DIFF] = {
				85381,	-- Eternal Blossom Headguard
				85383,	-- Eternal Blossom Shoulderguards
				85379,	-- Eternal Blossom Tunic
				85380,	-- Eternal Blossom Handguards
				85382,	-- Eternal Blossom Breeches
			},
			[HEROIC_DIFF] = {
				86940,	-- Eternal Blossom Headguard
				86942,	-- Eternal Blossom Shoulderguards
				86938,	-- Eternal Blossom Tunic
				86939,	-- Eternal Blossom Handguards
				86941,	-- Eternal Blossom Breeches
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86697,	-- Eternal Blossom Helm
				86694,	-- Eternal Blossom Mantle
				86695,	-- Eternal Blossom Robes
				86698,	-- Eternal Blossom Handwraps
				86696,	-- Eternal Blossom Legwraps
			},
			[NORMAL_DIFF] = {
				85357,	-- Eternal Blossom Helm
				85354,	-- Eternal Blossom Mantle
				85355,	-- Eternal Blossom Robes
				85358,	-- Eternal Blossom Handwraps
				85356,	-- Eternal Blossom Legwraps
			},
			[HEROIC_DIFF] = {
				86929,	-- Eternal Blossom Helm
				86932,	-- Eternal Blossom Mantle
				86931,	-- Eternal Blossom Robes
				86928,	-- Eternal Blossom Handwraps
				86930,	-- Eternal Blossom Legwraps
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86636,	-- Yaungol Slayer's Headguard
				86634,	-- Yaungol Slayer's Spaulders
				86638,	-- Yaungol Slayer's Tunic
				86637,	-- Yaungol Slayer's Gloves
				86635,	-- Yaungol Slayer's Legguards
			},
			[NORMAL_DIFF] = {
				85296,	-- Yaungol Slayer's Headguard
				85294,	-- Yaungol Slayer's Spaulders
				85298,	-- Yaungol Slayer's Tunic
				85297,	-- Yaungol Slayer's Gloves
				85295,	-- Yaungol Slayer's Legguards
			},
			[HEROIC_DIFF] = {
				87004,	-- Yaungol Slayer's Headguard
				87006,	-- Yaungol Slayer's Spaulders
				87002,	-- Yaungol Slayer's Tunic
				87003,	-- Yaungol Slayer's Gloves
				87005,	-- Yaungol Slayer's Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86717,	-- Hood of the Burning Scroll
				86714,	-- Mantle of the Burning Scroll
				86715,	-- Robes of the Burning Scroll
				86718,	-- Gloves of the Burning Scroll
				86716,	-- Leggings of the Burning Scroll
			},
			[NORMAL_DIFF] = {
				85377,	-- Hood of the Burning Scroll
				85374,	-- Mantle of the Burning Scroll
				85375,	-- Robes of the Burning Scroll
				85378,	-- Gloves of the Burning Scroll
				85376,	-- Leggings of the Burning Scroll
			},
			[HEROIC_DIFF] = {
				87008,	-- Hood of the Burning Scroll
				87011,	-- Mantle of the Burning Scroll
				87010,	-- Robes of the Burning Scroll
				87007,	-- Gloves of the Burning Scroll
				87009,	-- Leggings of the Burning Scroll
			},
		},
		{	-- Monk - Brewmaster
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Brewmaster"]..")",
			subSetName = "monkbrewmaster",
			icon = "monkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86726,	-- Red Crane Crown
				86724,	-- Red Crane Shoulderguards
				86728,	-- Red Crane Chestguard
				86727,	-- Red Crane Gauntlets
				86725,	-- Red Crane Legguards
			},
			[NORMAL_DIFF] = {
				85386,	-- Red Crane Crown
				85384,	-- Red Crane Shoulderguards
				85388,	-- Red Crane Chestguard
				85387,	-- Red Crane Gauntlets
				85385,	-- Red Crane Legguards
			},
			[HEROIC_DIFF] = {
				87096,	-- Red Crane Crown
				87098,	-- Red Crane Shoulderguards
				87094,	-- Red Crane Chestguard
				87095,	-- Red Crane Gauntlets
				87097,	-- Red Crane Legguards
			},
		},
		{	-- Monk - Mistweaver
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Mistweaver"]..")",
			subSetName = "monkmistweaver",
			icon = "monkHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86730,	-- Red Crane Helm
				86733,	-- Red Crane Mantle
				86732,	-- Red Crane Vest
				86729,	-- Red Crane Handwraps
				86731,	-- Red Crane Legwraps
			},
			[NORMAL_DIFF] = {
				85390,	-- Red Crane Helm
				85393,	-- Red Crane Mantle
				85392,	-- Red Crane Vest
				85389,	-- Red Crane Handwraps
				85391,	-- Red Crane Legwraps
			},
			[HEROIC_DIFF] = {
				87090,	-- Red Crane Helm
				87093,	-- Red Crane Mantle
				87092,	-- Red Crane Vest
				87089,	-- Red Crane Handwraps
				87091,	-- Red Crane Legwraps
			},
		},
		{	-- Monk - Windwalker
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." ("..ALIL["Windwalker"]..")",
			subSetName = "monkwindwalker",
			icon = "monkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86736,	-- Red Crane Headpiece
				86738,	-- Red Crane Spaulders
				86734,	-- Red Crane Tunic
				86735,	-- Red Crane Grips
				86737,	-- Red Crane Leggings
			},
			[NORMAL_DIFF] = {
				85396,	-- Red Crane Headpiece
				85398,	-- Red Crane Spaulders
				85394,	-- Red Crane Tunic
				85395,	-- Red Crane Grips
				85397,	-- Red Crane Leggings
			},
			[HEROIC_DIFF] = {
				87086,	-- Red Crane Headpiece
				87088,	-- Red Crane Spaulders
				87084,	-- Red Crane Tunic
				87085,	-- Red Crane Grips
				87087,	-- Red Crane Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86686,	-- White Tiger Headguard
				86684,	-- White Tiger Mantle
				86688,	-- White Tiger Breastplate
				86687,	-- White Tiger Gloves
				86685,	-- White Tiger Greaves
			},
			[NORMAL_DIFF] = {
				85346,	-- White Tiger Headguard
				85344,	-- White Tiger Mantle
				85348,	-- White Tiger Breastplate
				85347,	-- White Tiger Gloves
				85345,	-- White Tiger Greaves
			},
			[HEROIC_DIFF] = {
				87106,	-- White Tiger Headguard
				87108,	-- White Tiger Mantle
				87104,	-- White Tiger Breastplate
				87105,	-- White Tiger Gloves
				87107,	-- White Tiger Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86661,	-- White Tiger Faceguard
				86659,	-- White Tiger Shoulderguards
				86663,	-- White Tiger Chestguard
				86662,	-- White Tiger Handguards
				86660,	-- White Tiger Legguards
			},
			[NORMAL_DIFF] = {
				85321,	-- White Tiger Faceguard
				85319,	-- White Tiger Shoulderguards
				85323,	-- White Tiger Chestguard
				85322,	-- White Tiger Handguards
				85320,	-- White Tiger Legguards
			},
			[HEROIC_DIFF] = {
				87111,	-- White Tiger Faceguard
				87113,	-- White Tiger Shoulderguards
				87109,	-- White Tiger Chestguard
				87110,	-- White Tiger Handguards
				87112,	-- White Tiger Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86681,	-- White Tiger Helmet
				86679,	-- White Tiger Pauldrons
				86683,	-- White Tiger Battleplate
				86682,	-- White Tiger Gauntlets
				86680,	-- White Tiger Legplates
			},
			[NORMAL_DIFF] = {
				85341,	-- White Tiger Helmet
				85339,	-- White Tiger Pauldrons
				85343,	-- White Tiger Battleplate
				85342,	-- White Tiger Gauntlets
				85340,	-- White Tiger Legplates
			},
			[HEROIC_DIFF] = {
				87101,	-- White Tiger Helmet
				87103,	-- White Tiger Pauldrons
				87099,	-- White Tiger Battleplate
				87100,	-- White Tiger Gauntlets
				87102,	-- White Tiger Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86702,	-- Guardian Serpent Cowl
				86699,	-- Guardian Serpent Mantle
				86700,	-- Guardian Serpent Robes
				86703,	-- Guardian Serpent Handwraps
				86701,	-- Guardian Serpent Legwraps
			},
			[NORMAL_DIFF] = {
				85362,	-- Guardian Serpent Cowl
				85359,	-- Guardian Serpent Mantle
				85360,	-- Guardian Serpent Robes
				85363,	-- Guardian Serpent Handwraps
				85361,	-- Guardian Serpent Legwraps
			},
			[HEROIC_DIFF] = {
				87115,	-- Guardian Serpent Cowl
				87118,	-- Guardian Serpent Mantle
				87117,	-- Guardian Serpent Robes
				87114,	-- Guardian Serpent Handwraps
				87116,	-- Guardian Serpent Legwraps
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86705,	-- Guardian Serpent Hood
				86708,	-- Guardian Serpent Shoulderguards
				86707,	-- Guardian Serpent Raiment
				86704,	-- Guardian Serpent Gloves
				86706,	-- Guardian Serpent Leggings
			},
			[NORMAL_DIFF] = {
				85365,	-- Guardian Serpent Hood
				85368,	-- Guardian Serpent Shoulderguards
				85367,	-- Guardian Serpent Raiment
				85364,	-- Guardian Serpent Gloves
				85366,	-- Guardian Serpent Leggings
			},
			[HEROIC_DIFF] = {
				87120,	-- Guardian Serpent Hood
				87123,	-- Guardian Serpent Shoulderguards
				87122,	-- Guardian Serpent Raiment
				87119,	-- Guardian Serpent Gloves
				87121,	-- Guardian Serpent Leggings
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86641,	-- Helmet of the Thousandfold Blades
				86639,	-- Spaulders of the Thousandfold Blades
				86643,	-- Tunic of the Thousandfold Blades
				86642,	-- Gloves of the Thousandfold Blades
				86640,	-- Legguards of the Thousandfold Blades
			},
			[NORMAL_DIFF] = {
				85301,	-- Helmet of the Thousandfold Blades
				85299,	-- Spaulders of the Thousandfold Blades
				85303,	-- Tunic of the Thousandfold Blades
				85302,	-- Gloves of the Thousandfold Blades
				85300,	-- Legguards of the Thousandfold Blades
			},
			[HEROIC_DIFF] = {
				87126,	-- Helmet of the Thousandfold Blades
				87128,	-- Spaulders of the Thousandfold Blades
				87124,	-- Tunic of the Thousandfold Blades
				87125,	-- Gloves of the Thousandfold Blades
				87127,	-- Legguards of the Thousandfold Blades
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86631,	-- Firebird's Headpiece
				86633,	-- Firebird's Shoulderwraps
				86629,	-- Firebird's Hauberk
				86630,	-- Firebird's Gloves
				86632,	-- Firebird's Kilt
			},
			[NORMAL_DIFF] = {
				85291,	-- Firebird's Headpiece
				85293,	-- Firebird's Shoulderwraps
				85289,	-- Firebird's Hauberk
				85290,	-- Firebird's Gloves
				85292,	-- Firebird's Kilt
			},
			[HEROIC_DIFF] = {
				87141,	-- Firebird's Headpiece
				87143,	-- Firebird's Shoulderwraps
				87139,	-- Firebird's Hauberk
				87140,	-- Firebird's Gloves
				87142,	-- Firebird's Kilt
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86626,	-- Firebird's Helmet
				86624,	-- Firebird's Spaulders
				86628,	-- Firebird's Cuirass
				86627,	-- Firebird's Grips
				86625,	-- Firebird's Legguards
			},
			[NORMAL_DIFF] = {
				85286,	-- Firebird's Helmet
				85284,	-- Firebird's Spaulders
				85288,	-- Firebird's Cuirass
				85287,	-- Firebird's Grips
				85285,	-- Firebird's Legguards
			},
			[HEROIC_DIFF] = {
				87136,	-- Firebird's Helmet
				87138,	-- Firebird's Spaulders
				87134,	-- Firebird's Cuirass
				87135,	-- Firebird's Grips
				87137,	-- Firebird's Legguards
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86691,	-- Firebird's Faceguard
				86689,	-- Firebird's Mantle
				86693,	-- Firebird's Tunic
				86692,	-- Firebird's Handwraps
				86690,	-- Firebird's Legwraps
			},
			[NORMAL_DIFF] = {
				85351,	-- Firebird's Faceguard
				85349,	-- Firebird's Mantle
				85353,	-- Firebird's Tunic
				85352,	-- Firebird's Handwraps
				85350,	-- Firebird's Legwraps
			},
			[HEROIC_DIFF] = {
				87131,	-- Firebird's Faceguard
				87133,	-- Firebird's Mantle
				87129,	-- Firebird's Tunic
				87130,	-- Firebird's Handwraps
				87132,	-- Firebird's Legwraps
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86710,	-- Sha-Skin Hood
				86713,	-- Sha-Skin Mantle
				86712,	-- Sha-Skin Robes
				86709,	-- Sha-Skin Gloves
				86711,	-- Sha-Skin Leggings
			},
			[NORMAL_DIFF] = {
				85370,	-- Sha-Skin Hood
				85373,	-- Sha-Skin Mantle
				85372,	-- Sha-Skin Robes
				85369,	-- Sha-Skin Gloves
				85371,	-- Sha-Skin Leggings
			},
			[HEROIC_DIFF] = {
				87188,	-- Sha-Skin Hood
				87191,	-- Sha-Skin Mantle
				87190,	-- Sha-Skin Robes
				87187,	-- Sha-Skin Gloves
				87189,	-- Sha-Skin Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86673,	-- Helmet of Resounding Rings
				86669,	-- Pauldrons of Resounding Rings
				86672,	-- Battleplate of Resounding Rings
				86671,	-- Gauntlets of Resounding Rings
				86670,	-- Legplates of Resounding Rings
			},
			[NORMAL_DIFF] = {
				85333,	-- Helmet of Resounding Rings
				85329,	-- Pauldrons of Resounding Rings
				85332,	-- Battleplate of Resounding Rings
				85331,	-- Gauntlets of Resounding Rings
				85330,	-- Legplates of Resounding Rings
			},
			[HEROIC_DIFF] = {
				87192,	-- Helmet of Resounding Rings
				87196,	-- Pauldrons of Resounding Rings
				87193,	-- Battleplate of Resounding Rings
				87194,	-- Gauntlets of Resounding Rings
				87195,	-- Legplates of Resounding Rings
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				86666,	-- Faceguard of Resounding Rings
				86664,	-- Shoulderguards of Resounding Rings
				86668,	-- Chestguard of Resounding Rings
				86667,	-- Handguards of Resounding Rings
				86665,	-- Legguards of Resounding Rings
			},
			[NORMAL_DIFF] = {
				85326,	-- Faceguard of Resounding Rings
				85324,	-- Shoulderguards of Resounding Rings
				85328,	-- Chestguard of Resounding Rings
				85327,	-- Handguards of Resounding Rings
				85325,	-- Legguards of Resounding Rings
			},
			[HEROIC_DIFF] = {
				87199,	-- Faceguard of Resounding Rings
				87201,	-- Shoulderguards of Resounding Rings
				87197,	-- Chestguard of Resounding Rings
				87198,	-- Handguards of Resounding Rings
				87200,	-- Legguards of Resounding Rings
			},
		},
	},

	["Tier13"] = {	-- T13 Sets
		name = format(AL["Tier %d Sets"], 13),
		sourceTemplate = {
			EJ_GetInstanceInfo(187).." - "..EJ_GetEncounterInfo(332),	-- Head
			EJ_GetInstanceInfo(187).." - "..EJ_GetEncounterInfo(317),	-- Shoulder
			EJ_GetInstanceInfo(187).." - "..EJ_GetEncounterInfo(331),	-- Chest
			EJ_GetInstanceInfo(187).." - "..EJ_GetEncounterInfo(324),	-- Hands
			EJ_GetInstanceInfo(187).." - "..EJ_GetEncounterInfo(325),	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78792,	-- Necrotic Boneplate Faceguard
				78846,	-- Necrotic Boneplate Shoulderguards
				78758,	-- Necrotic Boneplate Chestguard
				78773,	-- Necrotic Boneplate Handguards
				78811,	-- Necrotic Boneplate Legguards
			},
			[NORMAL_DIFF] = {
				77010,	-- Necrotic Boneplate Faceguard
				77012,	-- Necrotic Boneplate Shoulderguards
				77008,	-- Necrotic Boneplate Chestguard
				77009,	-- Necrotic Boneplate Handguards
				77011,	-- Necrotic Boneplate Legguards
			},
			[HEROIC_DIFF] = {
				78697,	-- Necrotic Boneplate Faceguard
				78751,	-- Necrotic Boneplate Shoulderguards
				78663,	-- Necrotic Boneplate Chestguard
				78678,	-- Necrotic Boneplate Handguards
				78716,	-- Necrotic Boneplate Legguards
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78782,	-- Necrotic Boneplate Helmet
				78831,	-- Necrotic Boneplate Pauldrons
				78754,	-- Necrotic Boneplate Breastplate
				78765,	-- Necrotic Boneplate Gauntlets
				78802,	-- Necrotic Boneplate Greaves
			},
			[NORMAL_DIFF] = {
				76976,	-- Necrotic Boneplate Helmet
				76978,	-- Necrotic Boneplate Pauldrons
				76974,	-- Necrotic Boneplate Breastplate
				76975,	-- Necrotic Boneplate Gauntlets
				76977,	-- Necrotic Boneplate Greaves
			},
			[HEROIC_DIFF] = {
				78687,	-- Necrotic Boneplate Helmet
				78736,	-- Necrotic Boneplate Pauldrons
				78659,	-- Necrotic Boneplate Breastplate
				78670,	-- Necrotic Boneplate Gauntlets
				78707,	-- Necrotic Boneplate Greaves
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78791,	-- Deep Earth Cover
				78839,	-- Deep Earth Shoulderwraps
				78757,	-- Deep Earth Vestment
				78771,	-- Deep Earth Gloves
				78809,	-- Deep Earth Leggings
			},
			[NORMAL_DIFF] = {
				77019,	-- Deep Earth Cover
				77022,	-- Deep Earth Shoulderwraps
				77021,	-- Deep Earth Vestment
				77018,	-- Deep Earth Gloves
				77020,	-- Deep Earth Leggings
			},
			[HEROIC_DIFF] = {
				78696,	-- Deep Earth Cover
				78744,	-- Deep Earth Shoulderwraps
				78662,	-- Deep Earth Vestment
				78676,	-- Deep Earth Gloves
				78714,	-- Deep Earth Leggings
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78789,	-- Deep Earth Headpiece
				78838,	-- Deep Earth Spaulders
				78760,	-- Deep Earth Raiment
				78779,	-- Deep Earth Grips
				78808,	-- Deep Earth Legguards
			},
			[NORMAL_DIFF] = {
				77015,	-- Deep Earth Headpiece
				77017,	-- Deep Earth Spaulders
				77013,	-- Deep Earth Raiment
				77014,	-- Deep Earth Grips
				77016,	-- Deep Earth Legguards
			},
			[HEROIC_DIFF] = {
				78694,	-- Deep Earth Headpiece
				78743,	-- Deep Earth Spaulders
				78665,	-- Deep Earth Raiment
				78684,	-- Deep Earth Grips
				78713,	-- Deep Earth Legguards
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78785,	-- Deep Earth Helm
				78835,	-- Deep Earth Mantle
				78755,	-- Deep Earth Robes
				78775,	-- Deep Earth Handwraps
				78805,	-- Deep Earth Legwraps
			},
			[NORMAL_DIFF] = {
				76750,	-- Deep Earth Helm
				76753,	-- Deep Earth Mantle
				76752,	-- Deep Earth Robes
				76749,	-- Deep Earth Handwraps
				76751,	-- Deep Earth Legwraps
			},
			[HEROIC_DIFF] = {
				78690,	-- Deep Earth Helm
				78740,	-- Deep Earth Mantle
				78660,	-- Deep Earth Robes
				78680,	-- Deep Earth Handwraps
				78710,	-- Deep Earth Legwraps
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78793,	-- Wyrmstalker's Headguard
				78832,	-- Wyrmstalker's Spaulders
				78756,	-- Wyrmstalker's Tunic
				78769,	-- Wyrmstalker's Gloves
				78804,	-- Wyrmstalker's Legguards
			},
			[NORMAL_DIFF] = {
				77030,	-- Wyrmstalker's Headguard
				77032,	-- Wyrmstalker's Spaulders
				77028,	-- Wyrmstalker's Tunic
				77029,	-- Wyrmstalker's Gloves
				77031,	-- Wyrmstalker's Legguards
			},
			[HEROIC_DIFF] = {
				78698,	-- Wyrmstalker's Headguard
				78737,	-- Wyrmstalker's Spaulders
				78661,	-- Wyrmstalker's Tunic
				78674,	-- Wyrmstalker's Gloves
				78709,	-- Wyrmstalker's Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78796,	-- Time Lord's Hood
				78843,	-- Time Lord's Mantle
				78824,	-- Time Lord's Robes
				78766,	-- Time Lord's Gloves
				78815,	-- Time Lord's Leggings
			},
			[NORMAL_DIFF] = {
				76213,	-- Time Lord's Hood
				76216,	-- Time Lord's Mantle
				76215,	-- Time Lord's Robes
				76212,	-- Time Lord's Gloves
				76214,	-- Time Lord's Leggings
			},
			[HEROIC_DIFF] = {
				78701,	-- Time Lord's Hood
				78748,	-- Time Lord's Mantle
				78729,	-- Time Lord's Robes
				78671,	-- Time Lord's Gloves
				78720,	-- Time Lord's Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78787,	-- Headguard of Radiant Glory
				78841,	-- Mantle of Radiant Glory
				78821,	-- Breastplate of Radiant Glory
				78768,	-- Gloves of Radiant Glory
				78812,	-- Greaves of Radiant Glory
			},
			[NORMAL_DIFF] = {
				76767,	-- Headguard of Radiant Glory
				76769,	-- Mantle of Radiant Glory
				76765,	-- Breastplate of Radiant Glory
				76766,	-- Gloves of Radiant Glory
				76768,	-- Greaves of Radiant Glory
			},
			[HEROIC_DIFF] = {
				78692,	-- Headguard of Radiant Glory
				78746,	-- Mantle of Radiant Glory
				78726,	-- Breastplate of Radiant Glory
				78673,	-- Gloves of Radiant Glory
				78717,	-- Greaves of Radiant Glory
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78790,	-- Faceguard of Radiant Glory
				78840,	-- Shoulderguards of Radiant Glory
				78827,	-- Chestguard of Radiant Glory
				78772,	-- Handguards of Radiant Glory
				78810,	-- Legguards of Radiant Glory
			},
			[NORMAL_DIFF] = {
				77005,	-- Faceguard of Radiant Glory
				77007,	-- Shoulderguards of Radiant Glory
				77003,	-- Chestguard of Radiant Glory
				77004,	-- Handguards of Radiant Glory
				77006,	-- Legguards of Radiant Glory
			},
			[HEROIC_DIFF] = {
				78695,	-- Faceguard of Radiant Glory
				78745,	-- Shoulderguards of Radiant Glory
				78732,	-- Chestguard of Radiant Glory
				78677,	-- Handguards of Radiant Glory
				78715,	-- Legguards of Radiant Glory
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78788,	-- Helmet of Radiant Glory
				78837,	-- Pauldrons of Radiant Glory
				78822,	-- Battleplate of Radiant Glory
				78770,	-- Gauntlets of Radiant Glory
				78807,	-- Legplates of Radiant Glory
			},
			[NORMAL_DIFF] = {
				76876,	-- Helmet of Radiant Glory
				76878,	-- Pauldrons of Radiant Glory
				76874,	-- Battleplate of Radiant Glory
				76875,	-- Gauntlets of Radiant Glory
				76877,	-- Legplates of Radiant Glory
			},
			[HEROIC_DIFF] = {
				78693,	-- Helmet of Radiant Glory
				78742,	-- Pauldrons of Radiant Glory
				78727,	-- Battleplate of Radiant Glory
				78675,	-- Gauntlets of Radiant Glory
				78712,	-- Legplates of Radiant Glory
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78795,	-- Cowl of Dying Light
				78842,	-- Mantle of Dying Light
				78823,	-- Robes of Dying Light
				78778,	-- Handwraps of Dying Light
				78814,	-- Legwraps of Dying Light
			},
			[NORMAL_DIFF] = {
				76358,	-- Cowl of Dying Light
				76361,	-- Mantle of Dying Light
				76360,	-- Robes of Dying Light
				76357,	-- Handwraps of Dying Light
				76359,	-- Legwraps of Dying Light
			},
			[HEROIC_DIFF] = {
				78700,	-- Cowl of Dying Light
				78747,	-- Mantle of Dying Light
				78728,	-- Robes of Dying Light
				78683,	-- Handwraps of Dying Light
				78719,	-- Legwraps of Dying Light
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78798,	-- Hood of Dying Light
				78845,	-- Mantle of Dying Light
				78826,	-- Robes of Dying Light
				78777,	-- Gloves of Dying Light
				78817,	-- Leggings of Dying Light
			},
			[NORMAL_DIFF] = {
				76347,	-- Hood of Dying Light
				76344,	-- Mantle of Dying Light
				76345,	-- Robes of Dying Light
				76348,	-- Gloves of Dying Light
				76346,	-- Leggings of Dying Light
			},
			[HEROIC_DIFF] = {
				78703,	-- Hood of Dying Light
				78750,	-- Mantle of Dying Light
				78731,	-- Robes of Dying Light
				78682,	-- Gloves of Dying Light
				78722,	-- Leggings of Dying Light
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78794,	-- Blackfang Battleweave Helmet
				78833,	-- Blackfang Battleweave Spaulders
				78759,	-- Blackfang Battleweave Tunic
				78774,	-- Blackfang Battleweave Gloves
				78803,	-- Blackfang Battleweave Legguards
			},
			[NORMAL_DIFF] = {
				77025,	-- Blackfang Battleweave Helmet
				77027,	-- Blackfang Battleweave Spaulders
				77023,	-- Blackfang Battleweave Tunic
				77024,	-- Blackfang Battleweave Gloves
				77026,	-- Blackfang Battleweave Legguards
			},
			[HEROIC_DIFF] = {
				78699,	-- Blackfang Battleweave Helmet
				78738,	-- Blackfang Battleweave Spaulders
				78664,	-- Blackfang Battleweave Tunic
				78679,	-- Blackfang Battleweave Gloves
				78708,	-- Blackfang Battleweave Legguards
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78780,	-- Spiritwalker's Headpiece
				78836,	-- Spiritwalker's Shoulderwraps
				78818,	-- Spiritwalker's Hauberk
				78761,	-- Spiritwalker's Gloves
				78806,	-- Spiritwalker's Kilt
			},
			[NORMAL_DIFF] = {
				77037,	-- Spiritwalker's Headpiece
				77035,	-- Spiritwalker's Shoulderwraps
				77039,	-- Spiritwalker's Hauberk
				77038,	-- Spiritwalker's Gloves
				77036,	-- Spiritwalker's Kilt
			},
			[HEROIC_DIFF] = {
				78685,	-- Spiritwalker's Headpiece
				78741,	-- Spiritwalker's Shoulderwraps
				78723,	-- Spiritwalker's Hauberk
				78666,	-- Spiritwalker's Gloves
				78711,	-- Spiritwalker's Kilt
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78781,	-- Spiritwalker's Helmet
				78828,	-- Spiritwalker's Spaulders
				78819,	-- Spiritwalker's Cuirass
				78762,	-- Spiritwalker's Grips
				78799,	-- Spiritwalker's Legguards
			},
			[NORMAL_DIFF] = {
				77042,	-- Spiritwalker's Helmet
				77044,	-- Spiritwalker's Spaulders
				77040,	-- Spiritwalker's Cuirass
				77041,	-- Spiritwalker's Grips
				77043,	-- Spiritwalker's Legguards
			},
			[HEROIC_DIFF] = {
				78686,	-- Spiritwalker's Helmet
				78733,	-- Spiritwalker's Spaulders
				78724,	-- Spiritwalker's Cuirass
				78667,	-- Spiritwalker's Grips
				78704,	-- Spiritwalker's Legguards
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78786,	-- Spiritwalker's Faceguard
				78834,	-- Spiritwalker's Mantle
				78820,	-- Spiritwalker's Tunic
				78767,	-- Spiritwalker's Handwraps
				78813,	-- Spiritwalker's Legwraps
			},
			[NORMAL_DIFF] = {
				76758,	-- Spiritwalker's Faceguard
				76760,	-- Spiritwalker's Mantle
				76756,	-- Spiritwalker's Tunic
				76757,	-- Spiritwalker's Handwraps
				76759,	-- Spiritwalker's Legwraps
			},
			[HEROIC_DIFF] = {
				78691,	-- Spiritwalker's Faceguard
				78739,	-- Spiritwalker's Mantle
				78725,	-- Spiritwalker's Tunic
				78672,	-- Spiritwalker's Handwraps
				78718,	-- Spiritwalker's Legwraps
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78797,	-- Hood of the Faceless Shroud
				78844,	-- Mantle of the Faceless Shroud
				78825,	-- Robes of the Faceless Shroud
				78776,	-- Gloves of the Faceless Shroud
				78816,	-- Leggings of the Faceless Shroud
			},
			[NORMAL_DIFF] = {
				76342,	-- Hood of the Faceless Shroud
				76339,	-- Mantle of the Faceless Shroud
				76340,	-- Robes of the Faceless Shroud
				76343,	-- Gloves of the Faceless Shroud
				76341,	-- Leggings of the Faceless Shroud
			},
			[HEROIC_DIFF] = {
				78702,	-- Hood of the Faceless Shroud
				78749,	-- Mantle of the Faceless Shroud
				78730,	-- Robes of the Faceless Shroud
				78681,	-- Gloves of the Faceless Shroud
				78721,	-- Leggings of the Faceless Shroud
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78783,	-- Colossal Dragonplate Helmet
				78830,	-- Colossal Dragonplate Pauldrons
				78752,	-- Colossal Dragonplate Battleplate
				78763,	-- Colossal Dragonplate Gauntlets
				78801,	-- Colossal Dragonplate Legplates
			},
			[NORMAL_DIFF] = {
				76983,	-- Colossal Dragonplate Helmet
				76987,	-- Colossal Dragonplate Pauldrons
				76984,	-- Colossal Dragonplate Battleplate
				76985,	-- Colossal Dragonplate Gauntlets
				76986,	-- Colossal Dragonplate Legplates
			},
			[HEROIC_DIFF] = {
				78688,	-- Colossal Dragonplate Helmet
				78735,	-- Colossal Dragonplate Pauldrons
				78657,	-- Colossal Dragonplate Battleplate
				78668,	-- Colossal Dragonplate Gauntlets
				78706,	-- Colossal Dragonplate Legplates
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[RF_DIFF] = {
				78784,	-- Colossal Dragonplate Faceguard
				78829,	-- Colossal Dragonplate Shoulderguards
				78753,	-- Colossal Dragonplate Chestguard
				78764,	-- Colossal Dragonplate Handguards
				78800,	-- Colossal Dragonplate Legguards
			},
			[NORMAL_DIFF] = {
				76990,	-- Colossal Dragonplate Faceguard
				76992,	-- Colossal Dragonplate Shoulderguards
				76988,	-- Colossal Dragonplate Chestguard
				76989,	-- Colossal Dragonplate Handguards
				76991,	-- Colossal Dragonplate Legguards
			},
			[HEROIC_DIFF] = {
				78689,	-- Colossal Dragonplate Faceguard
				78734,	-- Colossal Dragonplate Shoulderguards
				78658,	-- Colossal Dragonplate Chestguard
				78669,	-- Colossal Dragonplate Handguards
				78705,	-- Colossal Dragonplate Legguards
			},
		},
	},

	["Tier12"] = {	-- T12 Sets
		name = format(AL["Tier %d Sets"], 12),
		sourceTemplate = {
			EJ_GetInstanceInfo(78).." - "..EJ_GetEncounterInfo(198),	-- Head
			EJ_GetInstanceInfo(78).." - "..EJ_GetEncounterInfo(197),	-- Shoulder
			EJ_GetInstanceInfo(78).." - "..EJ_GetEncounterInfo(194),	-- Chest
			EJ_GetInstanceInfo(78).." - "..EJ_GetEncounterInfo(196),	-- Hands
			EJ_GetInstanceInfo(78).." - "..EJ_GetEncounterInfo(195),	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				70954,	-- Elementium Deathplate Faceguard
				70951,	-- Elementium Deathplate Shoulderguards
				{ 70955, [SOURCE_INFO] = GetCoinTextureString(3403600) },	-- Elementium Deathplate Chestguard
				{ 70953, [SOURCE_INFO] = GetCoinTextureString(1698800) },	-- Elementium Deathplate Handguards
				{ 70952, [SOURCE_INFO] = GetCoinTextureString(3366000) },	-- Elementium Deathplate Legguards
			},
			[HEROIC_DIFF] = {
				71483,	-- Elementium Deathplate Faceguard
				71485,	-- Elementium Deathplate Shoulderguards
				71481,	-- Elementium Deathplate Chestguard
				71482,	-- Elementium Deathplate Handguards
				71484,	-- Elementium Deathplate Legguards
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71060,	-- Elementium Deathplate Helmet
				71062,	-- Elementium Deathplate Pauldrons
				{ 71058, [SOURCE_INFO] = GetCoinTextureString(3278300) },	-- Elementium Deathplate Breastplate
				{ 71059, [SOURCE_INFO] = GetCoinTextureString(1654700) },	-- Elementium Deathplate Gauntlets
				{ 71061, [SOURCE_INFO] = GetCoinTextureString(3315800) },	-- Elementium Deathplate Greaves
			},
			[HEROIC_DIFF] = {
				71478,	-- Elementium Deathplate Helmet
				71480,	-- Elementium Deathplate Pauldrons
				71476,	-- Elementium Deathplate Breastplate
				71477,	-- Elementium Deathplate Gauntlets
				71479,	-- Elementium Deathplate Greaves
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71108,	-- Obsidian Arborweave Cover
				71111,	-- Obsidian Arborweave Shoulderwraps
				{ 71110, [SOURCE_INFO] = GetCoinTextureString(3518300) },	-- Obsidian Arborweave Vestment
				{ 71107, [SOURCE_INFO] = GetCoinTextureString(1750300) },	-- Obsidian Arborweave Gloves
				{ 71109, [SOURCE_INFO] = GetCoinTextureString(3505700) },	-- Obsidian Arborweave Leggings
			},
			[HEROIC_DIFF] = {
				71497,	-- Obsidian Arborweave Cover
				71500,	-- Obsidian Arborweave Shoulderwraps
				71499,	-- Obsidian Arborweave Vestment
				71496,	-- Obsidian Arborweave Gloves
				71498,	-- Obsidian Arborweave Leggings
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71098,	-- Obsidian Arborweave Headpiece
				71101,	-- Obsidian Arborweave Spaulders
				{ 71100, [SOURCE_INFO] = GetCoinTextureString(3302200) },	-- Obsidian Arborweave Raiment
				{ 71097, [SOURCE_INFO] = GetCoinTextureString(1641600) },	-- Obsidian Arborweave Grips
				{ 71099, [SOURCE_INFO] = GetCoinTextureString(3289900) },	-- Obsidian Arborweave Legguards
			},
			[HEROIC_DIFF] = {
				71488,	-- Obsidian Arborweave Headpiece
				71490,	-- Obsidian Arborweave Spaulders
				71486,	-- Obsidian Arborweave Raiment
				71487,	-- Obsidian Arborweave Grips
				71489,	-- Obsidian Arborweave Legguards
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71103,	-- Obsidian Arborweave Helm
				71106,	-- Obsidian Arborweave Mantle
				{ 71105, [SOURCE_INFO] = GetCoinTextureString(3365000) },	-- Obsidian Arborweave Tunic
				{ 71102, [SOURCE_INFO] = GetCoinTextureString(1673200) },	-- Obsidian Arborweave Handwraps
				{ 71104, [SOURCE_INFO] = GetCoinTextureString(3352400) },	-- Obsidian Arborweave Legwraps
			},
			[HEROIC_DIFF] = {
				71492,	-- Obsidian Arborweave Helm
				71495,	-- Obsidian Arborweave Mantle
				71494,	-- Obsidian Arborweave Tunic
				71491,	-- Obsidian Arborweave Handwraps
				71493,	-- Obsidian Arborweave Legwraps
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71051,	-- Flamewaker's Headguard
				71053,	-- Flamewaker's Spaulders
				{ 71054, [SOURCE_INFO] = GetCoinTextureString(3479400) },	-- Flamewaker's Tunic
				{ 71050, [SOURCE_INFO] = GetCoinTextureString(1724400) },	-- Flamewaker's Gloves
				{ 71052, [SOURCE_INFO] = GetCoinTextureString(3454100) },	-- Flamewaker's Legguards
			},
			[HEROIC_DIFF] = {
				71503,	-- Flamewaker's Headguard
				71505,	-- Flamewaker's Spaulders
				71501,	-- Flamewaker's Tunic
				71502,	-- Flamewaker's Gloves
				71504,	-- Flamewaker's Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71287,	-- Firehawk Hood
				71290,	-- Firehawk Mantle
				{ 71289, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Firehawk Robes
				{ 71286, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Firehawk Gloves
				{ 71288, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Firehawk Leggings
			},
			[HEROIC_DIFF] = {
				71508,	-- Firehawk Hood
				71511,	-- Firehawk Mantle
				71510,	-- Firehawk Robes
				71507,	-- Firehawk Gloves
				71509,	-- Firehawk Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71093,	-- Immolation Headguard
				71095,	-- Immolation Mantle
				{ 71091, [SOURCE_INFO] = GetCoinTextureString(3531300) },	-- Immolation Breastplate
				{ 71092, [SOURCE_INFO] = GetCoinTextureString(1782100) },	-- Immolation Gloves
				{ 71094, [SOURCE_INFO] = GetCoinTextureString(3568900) },	-- Immolation Greaves
			},
			[HEROIC_DIFF] = {
				71519,	-- Immolation Headguard
				71521,	-- Immolation Mantle
				71517,	-- Immolation Breastplate
				71518,	-- Immolation Gloves
				71520,	-- Immolation Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				70948,	-- Immolation Faceguard
				70946,	-- Immolation Shoulderguards
				{ 70950, [SOURCE_INFO] = GetCoinTextureString(3340800) },	-- Immolation Chestguard
				{ 70949, [SOURCE_INFO] = GetCoinTextureString(1673700) },	-- Immolation Handguards
				{ 70947, [SOURCE_INFO] = GetCoinTextureString(3303200) },	-- Immolation Legguards
			},
			[HEROIC_DIFF] = {
				71524,	-- Immolation Faceguard
				71526,	-- Immolation Shoulderguards
				71522,	-- Immolation Chestguard
				71523,	-- Immolation Handguards
				71525,	-- Immolation Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71065,	-- Immolation Helmet
				71067,	-- Immolation Pauldrons
				{ 71063, [SOURCE_INFO] = GetCoinTextureString(3340800) },	-- Immolation Battleplate
				{ 71064, [SOURCE_INFO] = GetCoinTextureString(1686300) },	-- Immolation Gauntlets
				{ 71066, [SOURCE_INFO] = GetCoinTextureString(3378300) },	-- Immolation Legplates
			},
			[HEROIC_DIFF] = {
				71514,	-- Immolation Helmet
				71516,	-- Immolation Pauldrons
				71512,	-- Immolation Battleplate
				71513,	-- Immolation Gauntlets
				71515,	-- Immolation Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71272,	-- Cowl of the Cleansing Flame
				71275,	-- Mantle of the Cleansing Flame
				{ 71274, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Robes of the Cleansing Flame
				{ 71271, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Handwraps of the Cleansing Flame
				{ 71273, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Legwraps of the Cleansing Flame
			},
			[HEROIC_DIFF] = {
				71528,	-- Cowl of the Cleansing Flame
				71531,	-- Mantle of the Cleansing Flame
				71530,	-- Robes of the Cleansing Flame
				71527,	-- Handwraps of the Cleansing Flame
				71529,	-- Legwraps of the Cleansing Flame
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71277,	-- Hood of the Cleansing Flame
				71280,	-- Shoulderwraps of the Cleansing Flame
				{ 71279, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Vestment of the Cleansing Flame
				{ 71276, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Gloves of the Cleansing Flame
				{ 71278, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Leggings of the Cleansing Flame
			},
			[HEROIC_DIFF] = {
				71533,	-- Hood of the Cleansing Flame
				71536,	-- Shoulderwraps of the Cleansing Flame
				71535,	-- Vestment of the Cleansing Flame
				71532,	-- Gloves of the Cleansing Flame
				71534,	-- Leggings of the Cleansing Flame
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71047,	-- Dark Phoenix Helmet
				71049,	-- Dark Phoenix Spaulders
				{ 71045, [SOURCE_INFO] = GetCoinTextureString(3366400) },	-- Dark Phoenix Tunic
				{ 71046, [SOURCE_INFO] = GetCoinTextureString(1699100) },	-- Dark Phoenix Gloves
				{ 71048, [SOURCE_INFO] = GetCoinTextureString(3403900) },	-- Dark Phoenix Legguards
			},
			[HEROIC_DIFF] = {
				71539,	-- Dark Phoenix Helmet
				71541,	-- Dark Phoenix Spaulders
				71537,	-- Dark Phoenix Tunic
				71538,	-- Dark Phoenix Gloves
				71540,	-- Dark Phoenix Legguards
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71293,	-- Erupting Volcanic Headpiece
				71295,	-- Erupting Volcanic Shoulderwraps
				{ 71291, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Erupting Volcanic Hauberk
				{ 71292, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Erupting Volcanic Gloves
				{ 71294, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Erupting Volcanic Kilt
			},
			[HEROIC_DIFF] = {
				71554,	-- Erupting Volcanic Headpiece
				71556,	-- Erupting Volcanic Shoulderwraps
				71552,	-- Erupting Volcanic Hauberk
				71553,	-- Erupting Volcanic Gloves
				71555,	-- Erupting Volcanic Kilt
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71303,	-- Erupting Volcanic Helmet
				71305,	-- Erupting Volcanic Spaulders
				{ 71301, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Erupting Volcanic Cuirass
				{ 71302, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Erupting Volcanic Grips
				{ 71304, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Erupting Volcanic Legguards
			},
			[HEROIC_DIFF] = {
				71549,	-- Erupting Volcanic Helmet
				71551,	-- Erupting Volcanic Spaulders
				71547,	-- Erupting Volcanic Cuirass
				71548,	-- Erupting Volcanic Grips
				71550,	-- Erupting Volcanic Legguards
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71298,	-- Erupting Volcanic Faceguard
				71300,	-- Erupting Volcanic Mantle
				{ 71296, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Erupting Volcanic Tunic
				{ 71297, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Erupting Volcanic Handwraps
				{ 71299, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Erupting Volcanic Legwraps
			},
			[HEROIC_DIFF] = {
				71544,	-- Erupting Volcanic Faceguard
				71546,	-- Erupting Volcanic Mantle
				71542,	-- Erupting Volcanic Tunic
				71543,	-- Erupting Volcanic Handwraps
				71545,	-- Erupting Volcanic Legwraps
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71282,	-- Balespider's Hood
				71285,	-- Balespider's Mantle
				{ 71284, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Balespider's Robes
				{ 71281, [SOURCE_INFO] = GetCoinTextureString(1717200) },	-- Balespider's Handwraps
				{ 71283, [SOURCE_INFO] = GetCoinTextureString(3414900) },	-- Balespider's Leggings
			},
			[HEROIC_DIFF] = {
				71595,	-- Balespider's Hood
				71598,	-- Balespider's Mantle
				71597,	-- Balespider's Robes
				71594,	-- Balespider's Handwraps
				71596,	-- Balespider's Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				71070,	-- Helmet of the Molten Giant
				71072,	-- Pauldrons of the Molten Giant
				{ 71068, [SOURCE_INFO] = GetCoinTextureString(3403600) }, -- Battleplate of the Molten Giant
				{ 71069, [SOURCE_INFO] = GetCoinTextureString(1717800) }, -- Gauntlets of the Molten Giant
				{ 71071, [SOURCE_INFO] = GetCoinTextureString(3441200) }, -- Legplates of the Molten Giant
			},
			[HEROIC_DIFF] = {
				71599,	-- Helmet of the Molten Giant
				71603,	-- Pauldrons of the Molten Giant
				71600,	-- Battleplate of the Molten Giant
				71601,	-- Gauntlets of the Molten Giant
				71602,	-- Legplates of the Molten Giant
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				70944,	-- Faceguard of the Molten Giant
				70941,	-- Shoulderguards of the Molten Giant
				{ 70945, [SOURCE_INFO] = GetCoinTextureString(3278300) }, -- Chestguard of the Molten Giant
				{ 70943, [SOURCE_INFO] = GetCoinTextureString(1762200) }, -- Handguards of the Molten Giant
				{ 70942, [SOURCE_INFO] = GetCoinTextureString(3491700) }, -- Legguards of the Molten Giant
			},
			[HEROIC_DIFF] = {
				71606,	-- Faceguard of the Molten Giant
				71608,	-- Shoulderguards of the Molten Giant
				71604,	-- Chestguard of the Molten Giant
				71605,	-- Handguards of the Molten Giant
				71607,	-- Legguards of the Molten Giant
			},
		},
	},

	["Tier11"] = {	-- T11 Sets
		name = format(AL["Tier %d Sets"], 11),
		sourceTemplate = {
			EJ_GetInstanceInfo(73).." - "..EJ_GetEncounterInfo(174),	-- Head
			EJ_GetInstanceInfo(72).." - "..EJ_GetEncounterInfo(167),	-- Shoulder
			EJ_GetInstanceInfo(72).." - "..EJ_GetEncounterInfo(156),	-- Chest
			EJ_GetInstanceInfo(73).." - "..EJ_GetEncounterInfo(171),	-- Hands
			EJ_GetInstanceInfo(73).." - "..EJ_GetEncounterInfo(173),	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60351,	-- Magma Plated Faceguard
				60353,	-- Magma Plated Shoulderguards
				{ 60349, [SOURCE_INFO] = GetCoinTextureString(3270400) },	-- Magma Plated Chestguard
				{ 60350, [SOURCE_INFO] = GetCoinTextureString(1650400) },	-- Magma Plated Handguards
				{ 60352, [SOURCE_INFO] = GetCoinTextureString(3306300) },	-- Magma Plated Legguards
			},
			[HEROIC_DIFF] = {
				65186,	-- Magma Plated Faceguard
				65188,	-- Magma Plated Shoulderguards
				65184,	-- Magma Plated Chestguard
				65185,	-- Magma Plated Handguards
				65187,	-- Magma Plated Legguards
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60341,	-- Magma Plated Helmet
				60343,	-- Magma Plated Pauldrons
				{ 60339, [SOURCE_INFO] = GetCoinTextureString(3150400) },	-- Magma Plated Battleplate
				{ 60340, [SOURCE_INFO] = GetCoinTextureString(1590200) },	-- Magma Plated Gauntlets
				{ 60342, [SOURCE_INFO] = GetCoinTextureString(3186600) },	-- Magma Plated Legplates
			},
			[HEROIC_DIFF] = {
				65181,	-- Magma Plated Helmet
				65183,	-- Magma Plated Pauldrons
				65179,	-- Magma Plated Battleplate
				65180,	-- Magma Plated Gauntlets
				65182,	-- Magma Plated Legplates
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60282,	-- Stormrider's Cover
				60284,	-- Stormrider's Shoulderwraps
				{ 60281, [SOURCE_INFO] = GetCoinTextureString(3415900) },	-- Stormrider's Vestment
				{ 60285, [SOURCE_INFO] = GetCoinTextureString(1577600) },	-- Stormrider's Gloves
				{ 60283, [SOURCE_INFO] = GetCoinTextureString(3113200) },	-- Stormrider's Leggings
			},
			[HEROIC_DIFF] = {
				65200,	-- Stormrider's Cover
				65203,	-- Stormrider's Shoulderwraps
				65202,	-- Stormrider's Vestment
				65199,	-- Stormrider's Gloves
				65201,	-- Stormrider's Leggings
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60286,	-- Stormrider's Headpiece
				60289,	-- Stormrider's Spaulders
				{ 60287, [SOURCE_INFO] = GetCoinTextureString(3161200) },	-- Stormrider's Raiment
				{ 60290, [SOURCE_INFO] = GetCoinTextureString(1651100) },	-- Stormrider's Grips
				{ 60288, [SOURCE_INFO] = GetCoinTextureString(3173200) },	-- Stormrider's Legguards
			},
			[HEROIC_DIFF] = {
				65190,	-- Stormrider's Headpiece
				65193,	-- Stormrider's Spaulders
				65192,	-- Stormrider's Raiment
				65189,	-- Stormrider's Grips
				65191,	-- Stormrider's Legguards
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60277,	-- Stormrider's Helm
				60279,	-- Stormrider's Mantle
				{ 60276, [SOURCE_INFO] = GetCoinTextureString(3355900) },	-- Stormrider's Robes
				{ 60280, [SOURCE_INFO] = GetCoinTextureString(1711600) },	-- Stormrider's Handwraps
				{ 60278, [SOURCE_INFO] = GetCoinTextureString(3380000) },	-- Stormrider's Legwraps
			},
			[HEROIC_DIFF] = {
				65195,	-- Stormrider's Helm
				65198,	-- Stormrider's Mantle
				65197,	-- Stormrider's Robes
				65194,	-- Stormrider's Handwraps
				65196,	-- Stormrider's Legwraps
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60303,	-- Lightning-Charged Headguard
				60306,	-- Lightning-Charged Spaulders
				{ 60304, [SOURCE_INFO] = GetCoinTextureString(3124900) },	-- Lightning-Charged Tunic
				{ 60307, [SOURCE_INFO] = GetCoinTextureString(1632900) },	-- Lightning-Charged Gloves
				{ 60305, [SOURCE_INFO] = GetCoinTextureString(3223100) },	-- Lightning-Charged Legguards
			},
			[HEROIC_DIFF] = {
				65206,	-- Lightning-Charged Headguard
				65208,	-- Lightning-Charged Spaulders
				65204,	-- Lightning-Charged Tunic
				65205,	-- Lightning-Charged Gloves
				65207,	-- Lightning-Charged Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60243,	-- Firelord's Hood
				60246,	-- Firelord's Mantle
				{ 60244, [SOURCE_INFO] = GetCoinTextureString(3126300) },	-- Firelord's Robes
				{ 60247, [SOURCE_INFO] = GetCoinTextureString(1590100) },	-- Firelord's Gloves
				{ 60245, [SOURCE_INFO] = GetCoinTextureString(3138000) },	-- Firelord's Leggings
			},
			[HEROIC_DIFF] = {
				65210,	-- Firelord's Hood
				65213,	-- Firelord's Mantle
				65212,	-- Firelord's Robes
				65209,	-- Firelord's Gloves
				65211,	-- Firelord's Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60359,	-- Reinforced Sapphirium Headguard
				60362,	-- Reinforced Sapphirium Mantle
				{ 60360, [SOURCE_INFO] = GetCoinTextureString(3162100) },	-- Reinforced Sapphirium Breastplate
				{ 60363, [SOURCE_INFO] = GetCoinTextureString(1608100) },	-- Reinforced Sapphirium Gloves
				{ 60361, [SOURCE_INFO] = GetCoinTextureString(3173900) },	-- Reinforced Sapphirium Greaves
			},
			[HEROIC_DIFF] = {
				65221,	-- Reinforced Sapphirium Headguard
				65223,	-- Reinforced Sapphirium Mantle
				65219,	-- Reinforced Sapphirium Breastplate
				65220,	-- Reinforced Sapphirium Gloves
				65222,	-- Reinforced Sapphirium Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60356,	-- Reinforced Sapphirium Faceguard
				60358,	-- Reinforced Sapphirium Shoulderguards
				{ 60354, [SOURCE_INFO] = GetCoinTextureString(3416600) },	-- Reinforced Sapphirium Chestguard
				{ 60355, [SOURCE_INFO] = GetCoinTextureString(1559900) },	-- Reinforced Sapphirium Handguards
				{ 60357, [SOURCE_INFO] = GetCoinTextureString(3126300) },	-- Reinforced Sapphirium Legguards
			},
			[HEROIC_DIFF] = {
				65226,	-- Reinforced Sapphirium Faceguard
				65228,	-- Reinforced Sapphirium Shoulderguards
				65224,	-- Reinforced Sapphirium Chestguard
				65225,	-- Reinforced Sapphirium Handguards
				65227,	-- Reinforced Sapphirium Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60346,	-- Reinforced Sapphirium Helmet
				60348,	-- Reinforced Sapphirium Pauldrons
				{ 60344, [SOURCE_INFO] = GetCoinTextureString(3210400) },	-- Reinforced Sapphirium Battleplate
				{ 60345, [SOURCE_INFO] = GetCoinTextureString(1620400) },	-- Reinforced Sapphirium Gauntlets
				{ 60347, [SOURCE_INFO] = GetCoinTextureString(3246300) },	-- Reinforced Sapphirium Legplates
			},
			[HEROIC_DIFF] = {
				65216,	-- Reinforced Sapphirium Helmet
				65218,	-- Reinforced Sapphirium Pauldrons
				65214,	-- Reinforced Sapphirium Battleplate
				65215,	-- Reinforced Sapphirium Gauntlets
				65217,	-- Reinforced Sapphirium Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60258,	-- Mercurial Cowl
				60262,	-- Mercurial Mantle
				{ 60259, [SOURCE_INFO] = GetCoinTextureString(3392400) },	-- Mercurial Robes
				{ 60275, [SOURCE_INFO] = GetCoinTextureString(1681400) },	-- Mercurial Handwraps
				{ 60261, [SOURCE_INFO] = GetCoinTextureString(3416200) },	-- Mercurial Legwraps
			},
			[HEROIC_DIFF] = {
				65230,	-- Mercurial Cowl
				65233,	-- Mercurial Mantle
				65232,	-- Mercurial Robes
				65229,	-- Mercurial Handwraps
				65231,	-- Mercurial Legwraps
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60256,	-- Mercurial Hood
				60253,	-- Mercurial Shoulderwraps
				{ 60254, [SOURCE_INFO] = GetCoinTextureString(3246000) },	-- Mercurial Vestment
				{ 60257, [SOURCE_INFO] = GetCoinTextureString(1693700) },	-- Mercurial Gloves
				{ 60255, [SOURCE_INFO] = GetCoinTextureString(3258000) },	-- Mercurial Leggings
			},
			[HEROIC_DIFF] = {
				65235,	-- Mercurial Hood
				65238,	-- Mercurial Shoulderwraps
				65237,	-- Mercurial Vestment
				65234,	-- Mercurial Gloves
				65236,	-- Mercurial Leggings
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60299,	-- Wind Dancer's Helmet
				60302,	-- Wind Dancer's Spaulders
				{ 60301, [SOURCE_INFO] = GetCoinTextureString(3415300) },	-- Wind Dancer's Tunic
				{ 60298, [SOURCE_INFO] = GetCoinTextureString(1699300) },	-- Wind Dancer's Gloves
				{ 60300, [SOURCE_INFO] = GetCoinTextureString(3403500) },	-- Wind Dancer's Legguards
			},
			[HEROIC_DIFF] = {
				65241,	-- Wind Dancer's Helmet
				65243,	-- Wind Dancer's Spaulders
				65239,	-- Wind Dancer's Tunic
				65240,	-- Wind Dancer's Gloves
				65242,	-- Wind Dancer's Legguards
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60315,	-- Headpiece of the Raging Elements
				60317,	-- Shoulderwraps of the Raging Elements
				{ 60313, [SOURCE_INFO] = GetCoinTextureString(3319000) },	-- Hauberk of the Raging Elements
				{ 60314, [SOURCE_INFO] = GetCoinTextureString(1675000) },	-- Gloves of the Raging Elements
				{ 60316, [SOURCE_INFO] = GetCoinTextureString(3354900) },	-- Kilt of the Raging Elements
			},
			[HEROIC_DIFF] = {
				65256,	-- Headpiece of the Raging Elements
				65258,	-- Shoulderwraps of the Raging Elements
				65254,	-- Hauberk of the Raging Elements
				65255,	-- Gloves of the Raging Elements
				65257,	-- Kilt of the Raging Elements
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60320,	-- Helmet of the Raging Elements
				60322,	-- Spaulders of the Raging Elements
				{ 60318, [SOURCE_INFO] = GetCoinTextureString(3379100) },	-- Cuirass of the Raging Elements
				{ 60319, [SOURCE_INFO] = GetCoinTextureString(1705200) },	-- Grips of the Raging Elements
				{ 60321, [SOURCE_INFO] = GetCoinTextureString(3174900) },	-- Legguards of the Raging Elements
			},
			[HEROIC_DIFF] = {
				65251,	-- Helmet of the Raging Elements
				65253,	-- Spaulders of the Raging Elements
				65249,	-- Cuirass of the Raging Elements
				65250,	-- Grips of the Raging Elements
				65252,	-- Legguards of the Raging Elements
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60308,	-- Faceguard of the Raging Elements
				60311,	-- Mantle of the Raging Elements
				{ 60309, [SOURCE_INFO] = GetCoinTextureString(3271100) },	-- Tunic of the Raging Elements
				{ 60312, [SOURCE_INFO] = GetCoinTextureString(1663100) },	-- Handwraps of the Raging Elements
				{ 60310, [SOURCE_INFO] = GetCoinTextureString(3283200) },	-- Legwraps of the Raging Elements
			},
			[HEROIC_DIFF] = {
				65246,	-- Faceguard of the Raging Elements
				65248,	-- Mantle of the Raging Elements
				65244,	-- Tunic of the Raging Elements
				65245,	-- Handwraps of the Raging Elements
				65247,	-- Legwraps of the Raging Elements
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60249,	-- Shadowflame Hood
				60252,	-- Shadowflame Mantle
				{ 60251, [SOURCE_INFO] = GetCoinTextureString(3210100) },	-- Shadowflame Robes
				{ 60248, [SOURCE_INFO] = GetCoinTextureString(1596100) },	-- Shadowflame Handwraps
				{ 60250, [SOURCE_INFO] = GetCoinTextureString(3198000) },	-- Shadowflame Leggings
			},
			[HEROIC_DIFF] = {
				65260,	-- Shadowflame Hood
				65263,	-- Shadowflame Mantle
				65262,	-- Shadowflame Robes
				65259,	-- Shadowflame Handwraps
				65261,	-- Shadowflame Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60325,	-- Earthen Helmet
				60327,	-- Earthen Pauldrons
				{ 60323, [SOURCE_INFO] = GetCoinTextureString(3199000) }, -- Earthen Battleplate
				{ 60326, [SOURCE_INFO] = GetCoinTextureString(1626700) }, -- Earthen Gauntlets
				{ 60324, [SOURCE_INFO] = GetCoinTextureString(3210700) }, -- Earthen Legplates
			},
			[HEROIC_DIFF] = {
				65266,	-- Earthen Helmet
				65268,	-- Earthen Pauldrons
				65264,	-- Earthen Battleplate
				65265,	-- Earthen Gauntlets
				65267,	-- Earthen Legplates
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				60328,	-- Earthen Faceguard
				60331,	-- Earthen Shoulderguards
				{ 60329, [SOURCE_INFO] = GetCoinTextureString(3270800) }, -- Earthen Chestguard
				{ 60332, [SOURCE_INFO] = GetCoinTextureString(1662700) }, -- Earthen Handguards
				{ 60330, [SOURCE_INFO] = GetCoinTextureString(3282800) }, -- Earthen Legguards
			},
			[HEROIC_DIFF] = {
				65271,	-- Earthen Faceguard
				65273,	-- Earthen Shoulderguards
				65269,	-- Earthen Chestguard
				65270,	-- Earthen Handguards
				65272,	-- Earthen Legguards
			},
		},
	},

	["Tier10"] = {	-- T10 Sets
		name = format(AL["Tier %d Sets"], 10),
		sourceTemplate = {
			ALIL["Icecrown Citadel"],	-- Head
			ALIL["Icecrown Citadel"],	-- Shoulder
			ALIL["Icecrown Citadel"],	-- Chest
			ALIL["Icecrown Citadel"],	-- Hands
			ALIL["Icecrown Citadel"],	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50855, [SOURCE_INFO] = GetCoinTextureString(1728400) },	-- Scourgelord Faceguard
				{ 50853, [SOURCE_INFO] = GetCoinTextureString(1672300) },	-- Scourgelord Pauldrons
				{ 50857, [SOURCE_INFO] = GetCoinTextureString(2325300) },	-- Scourgelord Chestguard
				{ 50856, [SOURCE_INFO] = GetCoinTextureString(1165200) },	-- Scourgelord Handguards
				{ 50854, [SOURCE_INFO] = GetCoinTextureString(2242000) },	-- Scourgelord Legguards
			},
			[P25_DIFF] = {
				51133,	-- Sanctified Scourgelord Faceguard
				51130,	-- Sanctified Scourgelord Pauldrons
				51134,	-- Sanctified Scourgelord Chestguard
				51132,	-- Sanctified Scourgelord Handguards
				51131,	-- Sanctified Scourgelord Legguards
			},
			[P25H_DIFF] = {
				51306,	-- Sanctified Scourgelord Faceguard
				51309,	-- Sanctified Scourgelord Pauldrons
				51305,	-- Sanctified Scourgelord Chestguard
				51307,	-- Sanctified Scourgelord Handguards
				51308,	-- Sanctified Scourgelord Legguards
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50096, [SOURCE_INFO] = GetCoinTextureString(1635400) },	-- Scourgelord Helmet
				{ 50098, [SOURCE_INFO] = GetCoinTextureString(1647500) },	-- Scourgelord Shoulderplates
				{ 50094, [SOURCE_INFO] = GetCoinTextureString(2168300) },	-- Scourgelord Battleplate
				{ 50095, [SOURCE_INFO] = GetCoinTextureString(1094400) },	-- Scourgelord Gauntlets
				{ 50097, [SOURCE_INFO] = GetCoinTextureString(2192600) },	-- Scourgelord Legplates
			},
			[P25_DIFF] = {
				51127,	-- Sanctified Scourgelord Helmet
				51125,	-- Sanctified Scourgelord Shoulderplates
				51129,	-- Sanctified Scourgelord Battleplate
				51128,	-- Sanctified Scourgelord Gauntlets
				51126,	-- Sanctified Scourgelord Legplates
			},
			[P25H_DIFF] = {
				51312,	-- Sanctified Scourgelord Helmet
				51314,	-- Sanctified Scourgelord Shoulderplates
				51310,	-- Sanctified Scourgelord Battleplate
				51311,	-- Sanctified Scourgelord Gauntlets
				51313,	-- Sanctified Scourgelord Legplates
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50821, [SOURCE_INFO] = GetCoinTextureString(1721400) },	-- Lasherweave's Cover
				{ 50819, [SOURCE_INFO] = GetCoinTextureString(1709300) },	-- Lasherweave's Mantle
				{ 50823, [SOURCE_INFO] = GetCoinTextureString(2153000) },	-- Lasherweave's Vestment
				{ 50822, [SOURCE_INFO] = GetCoinTextureString(1078500) },	-- Lasherweave's Gloves
				{ 50820, [SOURCE_INFO] = GetCoinTextureString(2291400) },	-- Lasherweave's Trousers
			},
			[P25_DIFF] = {
				51149,	-- Sanctified Lasherweave's Cover
				51147,	-- Sanctified Lasherweave's Mantle
				51145,	-- Sanctified Lasherweave's Vestment
				51148,	-- Sanctified Lasherweave's Gloves
				51146,	-- Sanctified Lasherweave's Trousers
			},
			[P25H_DIFF] = {
				51290,	-- Sanctified Lasherweave's Cover
				51292,	-- Sanctified Lasherweave's Mantle
				51294,	-- Sanctified Lasherweave's Vestment
				51291,	-- Sanctified Lasherweave's Gloves
				51293,	-- Sanctified Lasherweave's Trousers
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50826, [SOURCE_INFO] = GetCoinTextureString(1629900) },	-- Lasherweave's Headguard
				{ 50824, [SOURCE_INFO] = GetCoinTextureString(1617600) },	-- Lasherweave's Shoulderpads
				{ 50828, [SOURCE_INFO] = GetCoinTextureString(2193500) },	-- Lasherweave's Raiment
				{ 50827, [SOURCE_INFO] = GetCoinTextureString(1099000) },	-- Lasherweave's Handgrips
				{ 50825, [SOURCE_INFO] = GetCoinTextureString(2169200) },	-- Lasherweave's Legguards
			},
			[P25_DIFF] = {
				51143,	-- Sanctified Lasherweave's Headguard
				51140,	-- Sanctified Lasherweave's Shoulderpads
				51141,	-- Sanctified Lasherweave's Raiment
				51144,	-- Sanctified Lasherweave's Handgrips
				51142,	-- Sanctified Lasherweave's Legguards
			},
			[P25H_DIFF] = {
				51296,	-- Sanctified Lasherweave's Headguard
				51299,	-- Sanctified Lasherweave's Shoulderpads
				51298,	-- Sanctified Lasherweave's Raiment
				51295,	-- Sanctified Lasherweave's Handgrips
				51297,	-- Sanctified Lasherweave's Legguards
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50108, [SOURCE_INFO] = GetCoinTextureString(1586300) },	-- Lasherweave's Helmet
				{ 50113, [SOURCE_INFO] = GetCoinTextureString(1616800) },	-- Lasherweave's Pauldrons
				{ 50106, [SOURCE_INFO] = GetCoinTextureString(2324700) },	-- Lasherweave's Robes
				{ 50107, [SOURCE_INFO] = GetCoinTextureString(1061600) },	-- Lasherweave's Gauntlets
				{ 50109, [SOURCE_INFO] = GetCoinTextureString(2127300) },	-- Lasherweave's Legplates
			},
			[P25_DIFF] = {
				51137,	-- Sanctified Lasherweave's Helmet
				51135,	-- Sanctified Lasherweave's Pauldrons
				51139,	-- Sanctified Lasherweave's Robes
				51138,	-- Sanctified Lasherweave's Gauntlets
				51136,	-- Sanctified Lasherweave's Legplates
			},
			[P25H_DIFF] = {
				51302,	-- Sanctified Lasherweave's Helmet
				51304,	-- Sanctified Lasherweave's Pauldrons
				51300,	-- Sanctified Lasherweave's Robes
				51301,	-- Sanctified Lasherweave's Gauntlets
				51303,	-- Sanctified Lasherweave's Legplates
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50115, [SOURCE_INFO] = GetCoinTextureString(1673000) },	-- Ahn'Kahar Blood Hunter's Headpiece
				{ 50117, [SOURCE_INFO] = GetCoinTextureString(1685100) },	-- Ahn'Kahar Blood Hunter's Spaulders
				{ 50118, [SOURCE_INFO] = GetCoinTextureString(2259300) },	-- Ahn'Kahar Blood Hunter's Tunic
				{ 50114, [SOURCE_INFO] = GetCoinTextureString(1090200) },	-- Ahn'Kahar Blood Hunter's Handguards
				{ 50116, [SOURCE_INFO] = GetCoinTextureString(2242900) },	-- Ahn'Kahar Blood Hunter's Legguards
			},
			[P25_DIFF] = {
				51153,	-- Sanctified Ahn'Kahar Blood Hunter's Headpiece
				51151,	-- Sanctified Ahn'Kahar Blood Hunter's Spaulders
				51150,	-- Sanctified Ahn'Kahar Blood Hunter's Tunic
				51154,	-- Sanctified Ahn'Kahar Blood Hunter's Handguards
				51152,	-- Sanctified Ahn'Kahar Blood Hunter's Legguards
			},
			[P25H_DIFF] = {
				51286,	-- Sanctified Ahn'Kahar Blood Hunter's Headpiece
				51288,	-- Sanctified Ahn'Kahar Blood Hunter's Spaulders
				51289,	-- Sanctified Ahn'Kahar Blood Hunter's Tunic
				51285,	-- Sanctified Ahn'Kahar Blood Hunter's Handguards
				51287,	-- Sanctified Ahn'Kahar Blood Hunter's Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50276, [SOURCE_INFO] = GetCoinTextureString(1599200) },	-- Bloodmage Hood
				{ 50279, [SOURCE_INFO] = GetCoinTextureString(1617500) },	-- Bloodmage Shoulderpads
				{ 50278, [SOURCE_INFO] = GetCoinTextureString(2152500) },	-- Bloodmage Robe
				{ 50275, [SOURCE_INFO] = GetCoinTextureString(1152100) },	-- Bloodmage Gloves
				{ 50277, [SOURCE_INFO] = GetCoinTextureString(2144600) },	-- Bloodmage Leggings
			},
			[P25_DIFF] = {
				51158,	-- Sanctified Bloodmage Hood
				51155,	-- Sanctified Bloodmage Shoulderpads
				51156,	-- Sanctified Bloodmage Robe
				51159,	-- Sanctified Bloodmage Gloves
				51157,	-- Sanctified Bloodmage Leggings
			},
			[P25H_DIFF] = {
				51281,	-- Sanctified Bloodmage Hood
				51284,	-- Sanctified Bloodmage Shoulderpads
				51283,	-- Sanctified Bloodmage Robe
				51280,	-- Sanctified Bloodmage Gloves
				51282,	-- Sanctified Bloodmage Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50867, [SOURCE_INFO] = GetCoinTextureString(1635500) },	-- Lightsworn Headpiece
				{ 50865, [SOURCE_INFO] = GetCoinTextureString(1623300) },	-- Lightsworn Spaulders
				{ 50869, [SOURCE_INFO] = GetCoinTextureString(2201100) },	-- Lightsworn Tunic
				{ 50868, [SOURCE_INFO] = GetCoinTextureString(1102800) },	-- Lightsworn Gloves
				{ 50866, [SOURCE_INFO] = GetCoinTextureString(2176700) },	-- Lightsworn Greaves
			},
			[P25_DIFF] = {
				51167,	-- Sanctified Lightsworn Headpiece
				51166,	-- Sanctified Lightsworn Spaulders
				51165,	-- Sanctified Lightsworn Tunic
				51169,	-- Sanctified Lightsworn Gloves
				51168,	-- Sanctified Lightsworn Greaves
			},
			[P25H_DIFF] = {
				51272,	-- Sanctified Lightsworn Headpiece
				51273,	-- Sanctified Lightsworn Spaulders
				51274,	-- Sanctified Lightsworn Tunic
				51270,	-- Sanctified Lightsworn Gloves
				51271,	-- Sanctified Lightsworn Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50862, [SOURCE_INFO] = GetCoinTextureString(1605000) },	-- Lightsworn Faceguard
				{ 50860, [SOURCE_INFO] = GetCoinTextureString(1592900) },	-- Lightsworn Shoulderguards
				{ 50864, [SOURCE_INFO] = GetCoinTextureString(2160500) },	-- Lightsworn Chestguard
				{ 50863, [SOURCE_INFO] = GetCoinTextureString(1082300) },	-- Lightsworn Handguards
				{ 50861, [SOURCE_INFO] = GetCoinTextureString(2135900) },	-- Lightsworn Legguards
			},
			[P25_DIFF] = {
				51173,	-- Sanctified Lightsworn Faceguard
				51170,	-- Sanctified Lightsworn Shoulderguards
				51174,	-- Sanctified Lightsworn Chestguard
				51172,	-- Sanctified Lightsworn Handguards
				51171,	-- Sanctified Lightsworn Legguards
			},
			[P25H_DIFF] = {
				51266,	-- Sanctified Lightsworn Faceguard
				51269,	-- Sanctified Lightsworn Shoulderguards
				51265,	-- Sanctified Lightsworn Chestguard
				51267,	-- Sanctified Lightsworn Handguards
				51268,	-- Sanctified Lightsworn Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50326, [SOURCE_INFO] = GetCoinTextureString(1703700) },	-- Lightsworn Helmet
				{ 50324, [SOURCE_INFO] = GetCoinTextureString(1691400) },	-- Lightsworn Shoulderplates
				{ 50328, [SOURCE_INFO] = GetCoinTextureString(2292100) },	-- Lightsworn Battleplate
				{ 50327, [SOURCE_INFO] = GetCoinTextureString(1148500) },	-- Lightsworn Gauntlets
				{ 50325, [SOURCE_INFO] = GetCoinTextureString(2267700) },	-- Lightsworn Legplates
			},
			[P25_DIFF] = {
				51162,	-- Sanctified Lightsworn Helmet
				51160,	-- Sanctified Lightsworn Shoulderplates
				51164,	-- Sanctified Lightsworn Battleplate
				51163,	-- Sanctified Lightsworn Gauntlets
				51161,	-- Sanctified Lightsworn Legplates
			},
			[P25H_DIFF] = {
				51277,	-- Sanctified Lightsworn Helmet
				51279,	-- Sanctified Lightsworn Shoulderplates
				51275,	-- Sanctified Lightsworn Battleplate
				51276,	-- Sanctified Lightsworn Gauntlets
				51278,	-- Sanctified Lightsworn Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50765, [SOURCE_INFO] = GetCoinTextureString(1580500) },	-- Crimson Acolyte Hood
				{ 50767, [SOURCE_INFO] = GetCoinTextureString(1592600) },	-- Crimson Acolyte Shoulderpads
				{ 50768, [SOURCE_INFO] = GetCoinTextureString(2135700) },	-- Crimson Acolyte Robe
				{ 50766, [SOURCE_INFO] = GetCoinTextureString(1065800) },	-- Crimson Acolyte Gloves
				{ 50769, [SOURCE_INFO] = GetCoinTextureString(2143900) },	-- Crimson Acolyte Leggings
			},
			[P25_DIFF] = {
				51178,	-- Sanctified Crimson Acolyte Hood
				51175,	-- Sanctified Crimson Acolyte Shoulderpads
				51176,	-- Sanctified Crimson Acolyte Robe
				51179,	-- Sanctified Crimson Acolyte Gloves
				51177,	-- Sanctified Crimson Acolyte Leggings
			},
			[P25H_DIFF] = {
				51261,	-- Sanctified Crimson Acolyte Hood
				51264,	-- Sanctified Crimson Acolyte Shoulderpads
				51263,	-- Sanctified Crimson Acolyte Robe
				51260,	-- Sanctified Crimson Acolyte Gloves
				51262,	-- Sanctified Crimson Acolyte Leggings
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50392, [SOURCE_INFO] = GetCoinTextureString(1612500) },	-- Crimson Acolyte Cowl
				{ 50396, [SOURCE_INFO] = GetCoinTextureString(1641800) },	-- Crimson Acolyte Mantle
				{ 50394, [SOURCE_INFO] = GetCoinTextureString(2177100) },	-- Crimson Acolyte Raiments
				{ 50391, [SOURCE_INFO] = GetCoinTextureString(1082400) },	-- Crimson Acolyte Handwraps
				{ 50393, [SOURCE_INFO] = GetCoinTextureString(2168900) },	-- Crimson Acolyte Pants
			},
			[P25_DIFF] = {
				51184,	-- Sanctified Crimson Acolyte Cowl
				51182,	-- Sanctified Crimson Acolyte Mantle
				51180,	-- Sanctified Crimson Acolyte Raiments
				51183,	-- Sanctified Crimson Acolyte Handwraps
				51181,	-- Sanctified Crimson Acolyte Pants
			},
			[P25H_DIFF] = {
				51255,	-- Sanctified Crimson Acolyte Cowl
				51257,	-- Sanctified Crimson Acolyte Mantle
				51259,	-- Sanctified Crimson Acolyte Raiments
				51256,	-- Sanctified Crimson Acolyte Handwraps
				51258,	-- Sanctified Crimson Acolyte Pants
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50089, [SOURCE_INFO] = GetCoinTextureString(1592800) },	-- Shadowblade Helmet
				{ 50105, [SOURCE_INFO] = GetCoinTextureString(1734000) },	-- Shadowblade Pauldrons
				{ 50087, [SOURCE_INFO] = GetCoinTextureString(2111300) },	-- Shadowblade Breastplate
				{ 50088, [SOURCE_INFO] = GetCoinTextureString(1065800) },	-- Shadowblade Gauntlets
				{ 50090, [SOURCE_INFO] = GetCoinTextureString(2135700) },	-- Shadowblade Legplates
			},
			[P25_DIFF] = {
				51187,	-- Sanctified Shadowblade Helmet
				51185,	-- Sanctified Shadowblade Pauldrons
				51189,	-- Sanctified Shadowblade Breastplate
				51188,	-- Sanctified Shadowblade Gauntlets
				51186,	-- Sanctified Shadowblade Legplates
			},
			[P25H_DIFF] = {
				51252,	-- Sanctified Shadowblade Helmet
				51254,	-- Sanctified Shadowblade Pauldrons
				51250,	-- Sanctified Shadowblade Breastplate
				51251,	-- Sanctified Shadowblade Gauntlets
				51253,	-- Sanctified Shadowblade Legplates
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50843, [SOURCE_INFO] = GetCoinTextureString(1611300) },	-- Frost Witch's Helm
				{ 50845, [SOURCE_INFO] = GetCoinTextureString(1623600) },	-- Frost Witch's Shoulderpads
				{ 50841, [SOURCE_INFO] = GetCoinTextureString(2136400) },	-- Frost Witch's Hauberk
				{ 50842, [SOURCE_INFO] = GetCoinTextureString(1078400) },	-- Frost Witch's Gloves
				{ 50844, [SOURCE_INFO] = GetCoinTextureString(2160700) },	-- Frost Witch's Kilt
			},
			[P25_DIFF] = {
				51202,	-- Sanctified Frost Witch's Helm
				51204,	-- Sanctified Frost Witch's Shoulderpads
				51200,	-- Sanctified Frost Witch's Hauberk
				51201,	-- Sanctified Frost Witch's Gloves
				51203,	-- Sanctified Frost Witch's Kilt
			},
			[P25H_DIFF] = {
				51237,	-- Sanctified Frost Witch's Helm
				51235,	-- Sanctified Frost Witch's Shoulderpads
				51239,	-- Sanctified Frost Witch's Hauberk
				51238,	-- Sanctified Frost Witch's Gloves
				51236,	-- Sanctified Frost Witch's Kilt
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50832, [SOURCE_INFO] = GetCoinTextureString(1666400) },	-- Frost Witch's Faceguard
				{ 50834, [SOURCE_INFO] = GetCoinTextureString(1678600) },	-- Frost Witch's Shoulderguards
				{ 50830, [SOURCE_INFO] = GetCoinTextureString(2209900) },	-- Frost Witch's Chestguard
				{ 50831, [SOURCE_INFO] = GetCoinTextureString(1115300) },	-- Frost Witch's Grips
				{ 50833, [SOURCE_INFO] = GetCoinTextureString(2234300) },	-- Frost Witch's War-Kilt
			},
			[P25_DIFF] = {
				51197,	-- Sanctified Frost Witch's Faceguard
				51199,	-- Sanctified Frost Witch's Shoulderguards
				51195,	-- Sanctified Frost Witch's Chestguard
				51196,	-- Sanctified Frost Witch's Grips
				51198,	-- Sanctified Frost Witch's War-Kilt
			},
			[P25H_DIFF] = {
				51242,	-- Sanctified Frost Witch's Faceguard
				51240,	-- Sanctified Frost Witch's Shoulderguards
				51244,	-- Sanctified Frost Witch's Chestguard
				51243,	-- Sanctified Frost Witch's Grips
				51241,	-- Sanctified Frost Witch's War-Kilt
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50837, [SOURCE_INFO] = GetCoinTextureString(1696900) },	-- Frost Witch's Headpiece
				{ 50839, [SOURCE_INFO] = GetCoinTextureString(1586900) },	-- Frost Witch's Spaulders
				{ 50835, [SOURCE_INFO] = GetCoinTextureString(2250500) },	-- Frost Witch's Tunic
				{ 50836, [SOURCE_INFO] = GetCoinTextureString(1135800) },	-- Frost Witch's Handguards
				{ 50838, [SOURCE_INFO] = GetCoinTextureString(2112000) },	-- Frost Witch's Legguards
			},
			[P25_DIFF] = {
				51192,	-- Sanctified Frost Witch's Headpiece
				51194,	-- Sanctified Frost Witch's Spaulders
				51190,	-- Sanctified Frost Witch's Tunic
				51191,	-- Sanctified Frost Witch's Handguards
				51193,	-- Sanctified Frost Witch's Legguards
			},
			[P25H_DIFF] = {
				51247,	-- Sanctified Frost Witch's Headpiece
				51245,	-- Sanctified Frost Witch's Spaulders
				51249,	-- Sanctified Frost Witch's Tunic
				51248,	-- Sanctified Frost Witch's Handguards
				51246,	-- Sanctified Frost Witch's Legguards
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50241, [SOURCE_INFO] = GetCoinTextureString(1586100) },	-- Dark Coven Hood
				{ 50244, [SOURCE_INFO] = GetCoinTextureString(1648300) },	-- Dark Coven Shoulderpads
				{ 50243, [SOURCE_INFO] = GetCoinTextureString(2135300) },	-- Dark Coven Robe
				{ 50240, [SOURCE_INFO] = GetCoinTextureString(1061300) },	-- Dark Coven Gloves
				{ 50242, [SOURCE_INFO] = GetCoinTextureString(2127100) },	-- Dark Coven Leggings
			},
			[P25_DIFF] = {
				51208,	-- Sanctified Dark Coven Hood
				51205,	-- Sanctified Dark Coven Shoulderpads
				51206,	-- Sanctified Dark Coven Robe
				51209,	-- Sanctified Dark Coven Gloves
				51207,	-- Sanctified Dark Coven Leggings
			},
			[P25H_DIFF] = {
				51231,	-- Sanctified Dark Coven Hood
				51234,	-- Sanctified Dark Coven Shoulderpads
				51233,	-- Sanctified Dark Coven Robe
				51230,	-- Sanctified Dark Coven Gloves
				51232,	-- Sanctified Dark Coven Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50080, [SOURCE_INFO] = GetCoinTextureString(1659900) },	-- Ymirjar Lord's Helmet
				{ 50082, [SOURCE_INFO] = GetCoinTextureString(1672000) },	-- Ymirjar Lord's Shoulderplates
				{ 50078, [SOURCE_INFO] = GetCoinTextureString(2201100) },	-- Ymirjar Lord's Battleplate
				{ 50079, [SOURCE_INFO] = GetCoinTextureString(1110900) },	-- Ymirjar Lord's Gauntlets
				{ 50081, [SOURCE_INFO] = GetCoinTextureString(2225600) },	-- Ymirjar Lord's Legplates
			},
			[P25_DIFF] = {
				51212,	-- Sanctified Ymirjar Lord's Helmet
				51210,	-- Sanctified Ymirjar Lord's Shoulderplates
				51214,	-- Sanctified Ymirjar Lord's Battleplate
				51213,	-- Sanctified Ymirjar Lord's Gauntlets
				51211,	-- Sanctified Ymirjar Lord's Legplates
			},
			[P25H_DIFF] = {
				51227,	-- Sanctified Ymirjar Lord's Helmet
				51229,	-- Sanctified Ymirjar Lord's Shoulderplates
				51225,	-- Sanctified Ymirjar Lord's Battleplate
				51226,	-- Sanctified Ymirjar Lord's Gauntlets
				51228,	-- Sanctified Ymirjar Lord's Legplates
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				{ 50848, [SOURCE_INFO] = GetCoinTextureString(1641800) },	-- Ymirjar Lord's Greathelm
				{ 50846, [SOURCE_INFO] = GetCoinTextureString(1629600) },	-- Ymirjar Lord's Pauldrons
				{ 50850, [SOURCE_INFO] = GetCoinTextureString(2209500) },	-- Ymirjar Lord's Breastplate
				{ 50849, [SOURCE_INFO] = GetCoinTextureString(1107000) },	-- Ymirjar Lord's Handguards
				{ 50847, [SOURCE_INFO] = GetCoinTextureString(2185100) },	-- Ymirjar Lord's Legguards
			},
			[P25_DIFF] = {
				51218,	-- Sanctified Ymirjar Lord's Greathelm
				51215,	-- Sanctified Ymirjar Lord's Pauldrons
				51219,	-- Sanctified Ymirjar Lord's Breastplate
				51217,	-- Sanctified Ymirjar Lord's Handguards
				51216,	-- Sanctified Ymirjar Lord's Legguards
			},
			[P25H_DIFF] = {
				51221,	-- Sanctified Ymirjar Lord's Greathelm
				51224,	-- Sanctified Ymirjar Lord's Pauldrons
				51220,	-- Sanctified Ymirjar Lord's Breastplate
				51222,	-- Sanctified Ymirjar Lord's Handguards
				51223,	-- Sanctified Ymirjar Lord's Legguards
			},
		},
	},

	["Tier9A"] = {	-- T9 Alliance Sets
		name = format(AL["Tier %d Sets"], 9),
		sourceTemplatep25 = {
			ALIL["Trial of the Crusader"],	-- Head
			ALIL["Trial of the Crusader"],	-- Shoulder
			ALIL["Trial of the Crusader"],	-- Chest
			ALIL["Trial of the Crusader"],	-- Hands
			ALIL["Trial of the Crusader"],	-- Legs
		},
		sourceTemplatep25h = {
			AL["No longer available"],	-- Head
			AL["No longer available"],	-- Shoulder
			AL["No longer available"],	-- Chest
			AL["No longer available"],	-- Hands
			AL["No longer available"],	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[NORMAL_DIFF] = {
				{ 48529, [SOURCE_INFO] = GetCoinTextureString(1525800) },	-- Thassarian's Faceguard of Conquest
				{ 48535, [SOURCE_INFO] = GetCoinTextureString(1560500) },	-- Thassarian's Pauldrons of Conquest
				{ 48531, [SOURCE_INFO] = GetCoinTextureString(2053600) },	-- Thassarian's Chestguard of Conquest
				{ 48537, [SOURCE_INFO] = GetCoinTextureString(1056100) },	-- Thassarian's Handguards of Conquest
				{ 48533, [SOURCE_INFO] = GetCoinTextureString(2069200) },	-- Thassarian's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48540,	-- Thassarian's Faceguard of Triumph
				48542,	-- Thassarian's Pauldrons of Triumph
				48538,	-- Thassarian's Chestguard of Triumph
				48539,	-- Thassarian's Handguards of Triumph
				48541,	-- Thassarian's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48545,	-- Thassarian's Faceguard of Triumph
				48543,	-- Thassarian's Pauldrons of Triumph
				48547,	-- Thassarian's Chestguard of Triumph
				48546,	-- Thassarian's Handguards of Triumph
				48544,	-- Thassarian's Legguards of Triumph
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[NORMAL_DIFF] = {
				{ 48472, [SOURCE_INFO] = GetCoinTextureString(1502000) },	-- Thassarian's Helmet of Conquest
				{ 48478, [SOURCE_INFO] = GetCoinTextureString(1578400) },	-- Thassarian's Shoulderplates of Conquest
				{ 48474, [SOURCE_INFO] = GetCoinTextureString(2021800) },	-- Thassarian's Battleplate of Conquest
				{ 48480, [SOURCE_INFO] = GetCoinTextureString(1068100) },	-- Thassarian's Gauntlets of Conquest
				{ 48476, [SOURCE_INFO] = GetCoinTextureString(2093200) },	-- Thassarian's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48483,	-- Thassarian's Helmet of Triumph
				48485,	-- Thassarian's Shoulderplates of Triumph
				48481,	-- Thassarian's Battleplate of Triumph
				48482,	-- Thassarian's Gauntlets of Triumph
				48484,	-- Thassarian's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48488,	-- Thassarian's Helmet of Triumph
				48486,	-- Thassarian's Shoulderplates of Triumph
				48490,	-- Thassarian's Battleplate of Triumph
				48489,	-- Thassarian's Gauntlets of Triumph
				48487,	-- Thassarian's Legplates of Triumph
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[NORMAL_DIFF] = {
				{ 48158, [SOURCE_INFO] = GetCoinTextureString(1572400) },	-- Malfurion's Cover of Conquest
				{ 48161, [SOURCE_INFO] = GetCoinTextureString(1589900) },	-- Malfurion's Mantle of Conquest
				{ 48159, [SOURCE_INFO] = GetCoinTextureString(2108400) },	-- Malfurion's Vestments of Conquest
				{ 48162, [SOURCE_INFO] = GetCoinTextureString(1071800) },	-- Malfurion's Gloves of Conquest
				{ 48160, [SOURCE_INFO] = GetCoinTextureString(2116200) },	-- Malfurion's Trousers of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48164,	-- Malfurion's Cover of Triumph
				48167,	-- Malfurion's Mantle of Triumph
				48166,	-- Malfurion's Vestments of Triumph
				48163,	-- Malfurion's Gloves of Triumph
				48165,	-- Malfurion's Trousers of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48171,	-- Malfurion's Cover of Triumph
				48168,	-- Malfurion's Mantle of Triumph
				48169,	-- Malfurion's Vestments of Triumph
				48172,	-- Malfurion's Gloves of Triumph
				48170,	-- Malfurion's Trousers of Triumph
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[NORMAL_DIFF] = {
				{ 48214, [SOURCE_INFO] = GetCoinTextureString(1548600) },	-- Malfurion's Headguard of Conquest
				{ 48217, [SOURCE_INFO] = GetCoinTextureString(1566100) },	-- Malfurion's Shoulderpads of Conquest
				{ 48216, [SOURCE_INFO] = GetCoinTextureString(2084400) },	-- Malfurion's Raiments of Conquest
				{ 48213, [SOURCE_INFO] = GetCoinTextureString(1036500) },	-- Malfurion's Handgrips of Conquest
				{ 48215, [SOURCE_INFO] = GetCoinTextureString(2076600) },	-- Malfurion's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48211,	-- Malfurion's Headguard of Triumph
				48208,	-- Malfurion's Shoulderpads of Triumph
				48209,	-- Malfurion's Raiments of Triumph
				48212,	-- Malfurion's Handgrips of Triumph
				48210,	-- Malfurion's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48204,	-- Malfurion's Headguard of Triumph
				48207,	-- Malfurion's Shoulderpads of Triumph
				48206,	-- Malfurion's Raiments of Triumph
				48203,	-- Malfurion's Handgrips of Triumph
				48205,	-- Malfurion's Legguards of Triumph
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[NORMAL_DIFF] = {
				{ 48102, [SOURCE_INFO] = GetCoinTextureString(1554500) },	-- Malfurion's Headpiece of Conquest
				{ 48131, [SOURCE_INFO] = GetCoinTextureString(1648300) },	-- Malfurion's Spaulders of Conquest
				{ 48129, [SOURCE_INFO] = GetCoinTextureString(2186300) },	-- Malfurion's Robe of Conquest
				{ 48132, [SOURCE_INFO] = GetCoinTextureString(1111000) },	-- Malfurion's Handguards of Conquest
				{ 48130, [SOURCE_INFO] = GetCoinTextureString(2194100) },	-- Malfurion's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48134,	-- Malfurion's Headpiece of Triumph
				48137,	-- Malfurion's Spaulders of Triumph
				48136,	-- Malfurion's Robe of Triumph
				48133,	-- Malfurion's Handguards of Triumph
				48135,	-- Malfurion's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48141,	-- Malfurion's Headpiece of Triumph
				48138,	-- Malfurion's Spaulders of Triumph
				48139,	-- Malfurion's Robe of Triumph
				48142,	-- Malfurion's Handguards of Triumph
				48140,	-- Malfurion's Leggings of Triumph
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[NORMAL_DIFF] = {
				{ 48250, [SOURCE_INFO] = GetCoinTextureString(1525100) },	-- Windrunner's Headpiece of Conquest
				{ 48253, [SOURCE_INFO] = GetCoinTextureString(1584300) },	-- Windrunner's Spaulders of Conquest
				{ 48251, [SOURCE_INFO] = GetCoinTextureString(2101000) },	-- Windrunner's Tunic of Conquest
				{ 48254, [SOURCE_INFO] = GetCoinTextureString(1068100) },	-- Windrunner's Handguards of Conquest
				{ 48252, [SOURCE_INFO] = GetCoinTextureString(2108600) },	-- Windrunner's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48257,	-- Windrunner's Headpiece of Triumph
				48259,	-- Windrunner's Spaulders of Triumph
				48255,	-- Windrunner's Tunic of Triumph
				48256,	-- Windrunner's Handguards of Triumph
				48258,	-- Windrunner's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48262,	-- Windrunner's Headpiece of Triumph
				48260,	-- Windrunner's Spaulders of Triumph
				48264,	-- Windrunner's Tunic of Triumph
				48263,	-- Windrunner's Handguards of Triumph
				48261,	-- Windrunner's Legguards of Triumph
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[NORMAL_DIFF] = {
				{ 47748, [SOURCE_INFO] = GetCoinTextureString(1583600) },	-- Khadgar's Hood of Conquest
				{ 47751, [SOURCE_INFO] = GetCoinTextureString(1601000) },	-- Khadgar's Shoulderpads of Conquest
				{ 47749, [SOURCE_INFO] = GetCoinTextureString(2123300) },	-- Khadgar's Robe of Conquest
				{ 47752, [SOURCE_INFO] = GetCoinTextureString(1079400) },	-- Khadgar's Gauntlets of Conquest
				{ 47750, [SOURCE_INFO] = GetCoinTextureString(2131100) },	-- Khadgar's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				47754,	-- Khadgar's Hood of Triumph
				47757,	-- Khadgar's Shoulderpads of Triumph
				47756,	-- Khadgar's Robe of Triumph
				47753,	-- Khadgar's Gauntlets of Triumph
				47755,	-- Khadgar's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				47761,	-- Khadgar's Hood of Triumph
				47758,	-- Khadgar's Shoulderpads of Triumph
				47759,	-- Khadgar's Robe of Triumph
				47762,	-- Khadgar's Gauntlets of Triumph
				47760,	-- Khadgar's Leggings of Triumph
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[NORMAL_DIFF] = {
				{ 48564, [SOURCE_INFO] = GetCoinTextureString(1654300) },	-- Turalyon's Headpiece of Conquest
				{ 48572, [SOURCE_INFO] = GetCoinTextureString(1584400) },	-- Turalyon's Spaulders of Conquest
				{ 48566, [SOURCE_INFO] = GetCoinTextureString(2014500) },	-- Turalyon's Tunic of Conquest
				{ 48574, [SOURCE_INFO] = GetCoinTextureString(1072200) },	-- Turalyon's Gloves of Conquest
				{ 48568, [SOURCE_INFO] = GetCoinTextureString(2029800) },	-- Turalyon's Greaves of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48577,	-- Turalyon's Headpiece of Triumph
				48579,	-- Turalyon's Spaulders of Triumph
				48575,	-- Turalyon's Tunic of Triumph
				48576,	-- Turalyon's Gloves of Triumph
				48578,	-- Turalyon's Greaves of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48582,	-- Turalyon's Headpiece of Triumph
				48580,	-- Turalyon's Spaulders of Triumph
				48584,	-- Turalyon's Tunic of Triumph
				48583,	-- Turalyon's Gloves of Triumph
				48581,	-- Turalyon's Greaves of Triumph
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[NORMAL_DIFF] = {
				{ 48634, [SOURCE_INFO] = GetCoinTextureString(1595500) },	-- Turalyon's Faceguard of Conquest
				{ 48636, [SOURCE_INFO] = GetCoinTextureString(1607000) },	-- Turalyon's Shoulderguards of Conquest
				{ 48632, [SOURCE_INFO] = GetCoinTextureString(2115800) },	-- Turalyon's Breastplate of Conquest
				{ 48633, [SOURCE_INFO] = GetCoinTextureString(1067800) },	-- Turalyon's Handguards of Conquest
				{ 48635, [SOURCE_INFO] = GetCoinTextureString(2139100) },	-- Turalyon's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48639,	-- Turalyon's Faceguard of Triumph
				48637,	-- Turalyon's Shoulderguards of Triumph
				48641,	-- Turalyon's Breastplate of Triumph
				48640,	-- Turalyon's Handguards of Triumph
				48638,	-- Turalyon's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48644,	-- Turalyon's Faceguard of Triumph
				48646,	-- Turalyon's Shoulderguards of Triumph
				48642,	-- Turalyon's Breastplate of Triumph
				48643,	-- Turalyon's Handguards of Triumph
				48645,	-- Turalyon's Legguards of Triumph
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[NORMAL_DIFF] = {
				{ 48604, [SOURCE_INFO] = GetCoinTextureString(1537800) },	-- Turalyon's Helm of Conquest
				{ 48606, [SOURCE_INFO] = GetCoinTextureString(1549300) },	-- Turalyon's Shoulderplates of Conquest
				{ 48602, [SOURCE_INFO] = GetCoinTextureString(2193700) },	-- Turalyon's Battleplate of Conquest
				{ 48603, [SOURCE_INFO] = GetCoinTextureString(1107000) },	-- Turalyon's Gauntlets of Conquest
				{ 48605, [SOURCE_INFO] = GetCoinTextureString(2062100) },	-- Turalyon's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48609,	-- Turalyon's Helm of Triumph
				48611,	-- Turalyon's Shoulderplates of Triumph
				48607,	-- Turalyon's Battleplate of Triumph
				48608,	-- Turalyon's Gauntlets of Triumph
				48610,	-- Turalyon's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48614,	-- Turalyon's Helm of Triumph
				48612,	-- Turalyon's Shoulderplates of Triumph
				48616,	-- Turalyon's Battleplate of Triumph
				48615,	-- Turalyon's Gauntlets of Triumph
				48613,	-- Turalyon's Legplates of Triumph
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[NORMAL_DIFF] = {
				{ 47914, [SOURCE_INFO] = GetCoinTextureString(1584300) },	-- Velen's Cowl of Conquest
				{ 47981, [SOURCE_INFO] = GetCoinTextureString(1508100) },	-- Velen's Shoulderpads of Conquest
				{ 47936, [SOURCE_INFO] = GetCoinTextureString(2131600) },	-- Velen's Robe of Conquest
				{ 47982, [SOURCE_INFO] = GetCoinTextureString(1017000) },	-- Velen's Gloves of Conquest
				{ 47980, [SOURCE_INFO] = GetCoinTextureString(2007100) },	-- Velen's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				47984,	-- Velen's Cowl of Triumph
				47987,	-- Velen's Shoulderpads of Triumph
				47986,	-- Velen's Robe of Triumph
				47983,	-- Velen's Gloves of Triumph
				47985,	-- Velen's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48035,	-- Velen's Cowl of Triumph
				48029,	-- Velen's Shoulderpads of Triumph
				48031,	-- Velen's Robe of Triumph
				48037,	-- Velen's Gloves of Triumph
				48033,	-- Velen's Leggings of Triumph
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[NORMAL_DIFF] = {
				{ 48073, [SOURCE_INFO] = GetCoinTextureString(1618600) },	-- Velen's Circlet of Conquest
				{ 48076, [SOURCE_INFO] = GetCoinTextureString(1519900) },	-- Velen's Mantle of Conquest
				{ 48075, [SOURCE_INFO] = GetCoinTextureString(2022700) },	-- Velen's Raiments of Conquest
				{ 48072, [SOURCE_INFO] = GetCoinTextureString(1083400) },	-- Velen's Handwraps of Conquest
				{ 48074, [SOURCE_INFO] = GetCoinTextureString(2015100) },	-- Velen's Pants of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48078,	-- Velen's Circlet of Triumph
				48081,	-- Velen's Mantle of Triumph
				48080,	-- Velen's Raiments of Triumph
				48077,	-- Velen's Handwraps of Triumph
				48079,	-- Velen's Pants of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48085,	-- Velen's Circlet of Triumph
				48082,	-- Velen's Mantle of Triumph
				48083,	-- Velen's Raiments of Triumph
				48086,	-- Velen's Handwraps of Triumph
				48084,	-- Velen's Pants of Triumph
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[NORMAL_DIFF] = {
				{ 48218, [SOURCE_INFO] = GetCoinTextureString(1571800) },	-- VanCleef's Helmet of Conquest
				{ 48221, [SOURCE_INFO] = GetCoinTextureString(1631100) },	-- VanCleef's Pauldrons of Conquest
				{ 48219, [SOURCE_INFO] = GetCoinTextureString(2163400) },	-- VanCleef's Breastplate of Conquest
				{ 48222, [SOURCE_INFO] = GetCoinTextureString(1099500) },	-- VanCleef's Gauntlets of Conquest
				{ 48220, [SOURCE_INFO] = GetCoinTextureString(2171200) },	-- VanCleef's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48225,	-- VanCleef's Helmet of Triumph
				48227,	-- VanCleef's Pauldrons of Triumph
				48223,	-- VanCleef's Breastplate of Triumph
				48224,	-- VanCleef's Gauntlets of Triumph
				48226,	-- VanCleef's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48230,	-- VanCleef's Helmet of Triumph
				48228,	-- VanCleef's Pauldrons of Triumph
				48232,	-- VanCleef's Breastplate of Triumph
				48231,	-- VanCleef's Gauntlets of Triumph
				48229,	-- VanCleef's Legplates of Triumph
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[NORMAL_DIFF] = {
				{ 48313, [SOURCE_INFO] = GetCoinTextureString(1583600) },	-- Nobundo's Helm of Conquest
				{ 48315, [SOURCE_INFO] = GetCoinTextureString(1637100) },	-- Nobundo's Shoulderpads of Conquest
				{ 48310, [SOURCE_INFO] = GetCoinTextureString(2092400) },	-- Nobundo's Hauberk of Conquest
				{ 48312, [SOURCE_INFO] = GetCoinTextureString(1059900) },	-- Nobundo's Gloves of Conquest
				{ 48314, [SOURCE_INFO] = GetCoinTextureString(2123300) },	-- Nobundo's Kilt of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48318,	-- Nobundo's Helm of Triumph
				48320,	-- Nobundo's Shoulderpads of Triumph
				48316,	-- Nobundo's Hauberk of Triumph
				48317,	-- Nobundo's Gloves of Triumph
				48319,	-- Nobundo's Kilt of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48323,	-- Nobundo's Helm of Triumph
				48321,	-- Nobundo's Shoulderpads of Triumph
				48325,	-- Nobundo's Hauberk of Triumph
				48324,	-- Nobundo's Gloves of Triumph
				48322,	-- Nobundo's Kilt of Triumph
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[NORMAL_DIFF] = {
				{ 48343, [SOURCE_INFO] = GetCoinTextureString(1525300) },	-- Nobundo's Faceguard of Conquest
				{ 48345, [SOURCE_INFO] = GetCoinTextureString(1537000) },	-- Nobundo's Shoulderguards of Conquest
				{ 48341, [SOURCE_INFO] = GetCoinTextureString(2022300) },	-- Nobundo's Chestguard of Conquest
				{ 48342, [SOURCE_INFO] = GetCoinTextureString(1020700) },	-- Nobundo's Grips of Conquest
				{ 48344, [SOURCE_INFO] = GetCoinTextureString(2045400) },	-- Nobundo's War-Kilt of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48348,	-- Nobundo's Faceguard of Triumph
				48350,	-- Nobundo's Shoulderguards of Triumph
				48346,	-- Nobundo's Chestguard of Triumph
				48347,	-- Nobundo's Grips of Triumph
				48349,	-- Nobundo's War-Kilt of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48353,	-- Nobundo's Faceguard of Triumph
				48351,	-- Nobundo's Shoulderguards of Triumph
				48355,	-- Nobundo's Chestguard of Triumph
				48354,	-- Nobundo's Grips of Triumph
				48352,	-- Nobundo's War-Kilt of Triumph
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[NORMAL_DIFF] = {
				{ 48280, [SOURCE_INFO] = GetCoinTextureString(1624600) },	-- Nobundo's Headpiece of Conquest
				{ 48283, [SOURCE_INFO] = GetCoinTextureString(1525900) },	-- Nobundo's Spaulders of Conquest
				{ 48281, [SOURCE_INFO] = GetCoinTextureString(2178100) },	-- Nobundo's Tunic of Conquest
				{ 48284, [SOURCE_INFO] = GetCoinTextureString(1029000) },	-- Nobundo's Handguards of Conquest
				{ 48282, [SOURCE_INFO] = GetCoinTextureString(2185700) },	-- Nobundo's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48287,	-- Nobundo's Headpiece of Triumph
				48289,	-- Nobundo's Spaulders of Triumph
				48285,	-- Nobundo's Tunic of Triumph
				48286,	-- Nobundo's Handguards of Triumph
				48288,	-- Nobundo's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48292,	-- Nobundo's Headpiece of Triumph
				48290,	-- Nobundo's Spaulders of Triumph
				48294,	-- Nobundo's Tunic of Triumph
				48293,	-- Nobundo's Handguards of Triumph
				48291,	-- Nobundo's Legguards of Triumph
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[NORMAL_DIFF] = {
				{ 47784, [SOURCE_INFO] = GetCoinTextureString(1560100) },	-- Kel'Thuzad's Hood of Conquest
				{ 47787, [SOURCE_INFO] = GetCoinTextureString(1619300) },	-- Kel'Thuzad's Shoulderpads of Conquest
				{ 47786, [SOURCE_INFO] = GetCoinTextureString(2155400) },	-- Kel'Thuzad's Robe of Conquest
				{ 47783, [SOURCE_INFO] = GetCoinTextureString(1044100) },	-- Kel'Thuzad's Gloves of Conquest
				{ 47785, [SOURCE_INFO] = GetCoinTextureString(2147600) },	-- Kel'Thuzad's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				47778,	-- Kel'Thuzad's Hood of Triumph
				47781,	-- Kel'Thuzad's Shoulderpads of Triumph
				47779,	-- Kel'Thuzad's Robe of Triumph
				47782,	-- Kel'Thuzad's Gloves of Triumph
				47780,	-- Kel'Thuzad's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				47789,	-- Kel'Thuzad's Hood of Triumph
				47792,	-- Kel'Thuzad's Shoulderpads of Triumph
				47791,	-- Kel'Thuzad's Robe of Triumph
				47788,	-- Kel'Thuzad's Gloves of Triumph
				47790,	-- Kel'Thuzad's Leggings of Triumph
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[NORMAL_DIFF] = {
				{ 48371, [SOURCE_INFO] = GetCoinTextureString(1613300) },	-- Wrynn's Helmet of Conquest
				{ 48374, [SOURCE_INFO] = GetCoinTextureString(1630600) },	-- Wrynn's Shoulderplates of Conquest
				{ 48372, [SOURCE_INFO] = GetCoinTextureString(2162900) },	-- Wrynn's Battleplate of Conquest
				{ 48375, [SOURCE_INFO] = GetCoinTextureString(1099300) },	-- Wrynn's Gauntlets of Conquest
				{ 48373, [SOURCE_INFO] = GetCoinTextureString(2170500) },	-- Wrynn's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48378,	-- Wrynn's Helmet of Triumph
				48380,	-- Wrynn's Shoulderplates of Triumph
				48376,	-- Wrynn's Battleplate of Triumph
				48377,	-- Wrynn's Gauntlets of Triumph
				48379,	-- Wrynn's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48383,	-- Wrynn's Helmet of Triumph
				48381,	-- Wrynn's Shoulderplates of Triumph
				48385,	-- Wrynn's Battleplate of Triumph
				48384,	-- Wrynn's Gauntlets of Triumph
				48382,	-- Wrynn's Legplates of Triumph
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[NORMAL_DIFF] = {
				{ 48429, [SOURCE_INFO] = GetCoinTextureString(1642800) },	-- Wrynn's Greathelm of Conquest
				{ 48448, [SOURCE_INFO] = GetCoinTextureString(1636800) },	-- Wrynn's Pauldrons of Conquest
				{ 48436, [SOURCE_INFO] = GetCoinTextureString(2038000) },	-- Wrynn's Breastplate of Conquest
				{ 48449, [SOURCE_INFO] = GetCoinTextureString(1103400) },	-- Wrynn's Handguards of Conquest
				{ 48445, [SOURCE_INFO] = GetCoinTextureString(2163400) },	-- Wrynn's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48430,	-- Wrynn's Greathelm of Triumph
				48454,	-- Wrynn's Pauldrons of Triumph
				48450,	-- Wrynn's Breastplate of Triumph
				48452,	-- Wrynn's Handguards of Triumph
				48446,	-- Wrynn's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48433,	-- Wrynn's Greathelm of Triumph
				48455,	-- Wrynn's Pauldrons of Triumph
				48451,	-- Wrynn's Breastplate of Triumph
				48453,	-- Wrynn's Handguards of Triumph
				48447,	-- Wrynn's Legguards of Triumph
			},
		},
	},

	["Tier9H"] = {	-- T9 Horde Sets
		name = format(AL["Tier %d Sets"], 9),
		sourceTemplatep25 = {
			ALIL["Trial of the Crusader"],	-- Head
			ALIL["Trial of the Crusader"],	-- Shoulder
			ALIL["Trial of the Crusader"],	-- Chest
			ALIL["Trial of the Crusader"],	-- Hands
			ALIL["Trial of the Crusader"],	-- Legs
		},
		sourceTemplatep25h = {
			AL["No longer available"],	-- Head
			AL["No longer available"],	-- Shoulder
			AL["No longer available"],	-- Chest
			AL["No longer available"],	-- Hands
			AL["No longer available"],	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[NORMAL_DIFF] = {
				{ 48560, [SOURCE_INFO] = GetCoinTextureString(1631100) },	-- Koltira's Faceguard of Conquest
				{ 48562, [SOURCE_INFO] = GetCoinTextureString(1642600) },	-- Koltira's Pauldrons of Conquest
				{ 48558, [SOURCE_INFO] = GetCoinTextureString(2163400) },	-- Koltira's Chestguard of Conquest
				{ 48559, [SOURCE_INFO] = GetCoinTextureString(1091800) },	-- Koltira's Handguards of Conquest
				{ 48561, [SOURCE_INFO] = GetCoinTextureString(2186500) },	-- Koltira's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48555,	-- Koltira's Faceguard of Triumph
				48553,	-- Koltira's Pauldrons of Triumph
				48557,	-- Koltira's Chestguard of Triumph
				48556,	-- Koltira's Handguards of Triumph
				48554,	-- Koltira's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48550,	-- Koltira's Faceguard of Triumph
				48552,	-- Koltira's Pauldrons of Triumph
				48548,	-- Koltira's Chestguard of Triumph
				48549,	-- Koltira's Handguards of Triumph
				48551,	-- Koltira's Legguards of Triumph
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[NORMAL_DIFF] = {
				{ 48503, [SOURCE_INFO] = GetCoinTextureString(1607300) },	-- Koltira's Helmet of Conquest
				{ 48505, [SOURCE_INFO] = GetCoinTextureString(1618800) },	-- Koltira's Shoulderplates of Conquest
				{ 48501, [SOURCE_INFO] = GetCoinTextureString(2131600) },	-- Koltira's Battleplate of Conquest
				{ 48502, [SOURCE_INFO] = GetCoinTextureString(1075800) },	-- Koltira's Gauntlets of Conquest
				{ 48504, [SOURCE_INFO] = GetCoinTextureString(2154700) },	-- Koltira's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48498,	-- Koltira's Helmet of Triumph
				48496,	-- Koltira's Shoulderplates of Triumph
				48500,	-- Koltira's Battleplate of Triumph
				48499,	-- Koltira's Gauntlets of Triumph
				48497,	-- Koltira's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48493,	-- Koltira's Helmet of Triumph
				48495,	-- Koltira's Shoulderplates of Triumph
				48491,	-- Koltira's Battleplate of Triumph
				48492,	-- Koltira's Gauntlets of Triumph
				48494,	-- Koltira's Legplates of Triumph
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[NORMAL_DIFF] = {
				{ 48184, [SOURCE_INFO] = GetCoinTextureString(1607000) },	-- Runetotem's Cover of Conquest
				{ 48187, [SOURCE_INFO] = GetCoinTextureString(1508400) },	-- Runetotem's Mantle of Conquest
				{ 48186, [SOURCE_INFO] = GetCoinTextureString(2007300) },	-- Runetotem's Vestments of Conquest
				{ 48183, [SOURCE_INFO] = GetCoinTextureString(1075700) },	-- Runetotem's Gloves of Conquest
				{ 48185, [SOURCE_INFO] = GetCoinTextureString(2154500) },	-- Runetotem's Trousers of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48181,	-- Runetotem's Cover of Triumph
				48178,	-- Runetotem's Mantle of Triumph
				48179,	-- Runetotem's Vestments of Triumph
				48182,	-- Runetotem's Gloves of Triumph
				48180,	-- Runetotem's Trousers of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48174,	-- Runetotem's Cover of Triumph
				48177,	-- Runetotem's Mantle of Triumph
				48176,	-- Runetotem's Vestments of Triumph
				48173,	-- Runetotem's Gloves of Triumph
				48175,	-- Runetotem's Trousers of Triumph
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[NORMAL_DIFF] = {
				{ 48188, [SOURCE_INFO] = GetCoinTextureString(1514100) },	-- Runetotem's Headguard of Conquest
				{ 48191, [SOURCE_INFO] = GetCoinTextureString(1531600) },	-- Runetotem's Shoulderpads of Conquest
				{ 48189, [SOURCE_INFO] = GetCoinTextureString(2030500) },	-- Runetotem's Raiments of Conquest
				{ 48192, [SOURCE_INFO] = GetCoinTextureString(1032700) },	-- Runetotem's Handgrips of Conquest
				{ 48190, [SOURCE_INFO] = GetCoinTextureString(2038300) },	-- Runetotem's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48194,	-- Runetotem's Headguard of Triumph
				48197,	-- Runetotem's Shoulderpads of Triumph
				48196,	-- Runetotem's Raiments of Triumph
				48193,	-- Runetotem's Handgrips of Triumph
				48195,	-- Runetotem's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48201,	-- Runetotem's Headguard of Triumph
				48198,	-- Runetotem's Shoulderpads of Triumph
				48199,	-- Runetotem's Raiments of Triumph
				48202,	-- Runetotem's Handgrips of Triumph
				48200,	-- Runetotem's Legguards of Triumph
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[NORMAL_DIFF] = {
				{ 48154, [SOURCE_INFO] = GetCoinTextureString(1549300) },	-- Runetotem's Headpiece of Conquest
				{ 48157, [SOURCE_INFO] = GetCoinTextureString(1566800) },	-- Runetotem's Spaulders of Conquest
				{ 48156, [SOURCE_INFO] = GetCoinTextureString(2085200) },	-- Runetotem's Robe of Conquest
				{ 48153, [SOURCE_INFO] = GetCoinTextureString(1008800) },	-- Runetotem's Handguards of Conquest
				{ 48155, [SOURCE_INFO] = GetCoinTextureString(2077400) },	-- Runetotem's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48151,	-- Runetotem's Headpiece of Triumph
				48148,	-- Runetotem's Spaulders of Triumph
				48149,	-- Runetotem's Robe of Triumph
				48152,	-- Runetotem's Handguards of Triumph
				48150,	-- Runetotem's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48144,	-- Runetotem's Headpiece of Triumph
				48147,	-- Runetotem's Spaulders of Triumph
				48146,	-- Runetotem's Robe of Triumph
				48143,	-- Runetotem's Handguards of Triumph
				48145,	-- Runetotem's Leggings of Triumph
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[NORMAL_DIFF] = {
				{ 48277, [SOURCE_INFO] = GetCoinTextureString(1607300) },	-- Windrunner's Headpiece of Conquest
				{ 48279, [SOURCE_INFO] = GetCoinTextureString(1618800) },	-- Windrunner's Spaulders of Conquest
				{ 48275, [SOURCE_INFO] = GetCoinTextureString(2131600) },	-- Windrunner's Tunic of Conquest
				{ 48276, [SOURCE_INFO] = GetCoinTextureString(1075800) },	-- Windrunner's Handguards of Conquest
				{ 48278, [SOURCE_INFO] = GetCoinTextureString(2154700) },	-- Windrunner's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48272,	-- Windrunner's Headpiece of Triumph
				48270,	-- Windrunner's Spaulders of Triumph
				48274,	-- Windrunner's Tunic of Triumph
				48273,	-- Windrunner's Handguards of Triumph
				48271,	-- Windrunner's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48267,	-- Windrunner's Headpiece of Triumph
				48269,	-- Windrunner's Spaulders of Triumph
				48265,	-- Windrunner's Tunic of Triumph
				48266,	-- Windrunner's Handguards of Triumph
				48268,	-- Windrunner's Legguards of Triumph
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[NORMAL_DIFF] = {
				{ 47774, [SOURCE_INFO] = GetCoinTextureString(1502100) },	-- Sunstrider's Hood of Conquest
				{ 47777, [SOURCE_INFO] = GetCoinTextureString(1519600) },	-- Sunstrider's Shoulderpads of Conquest
				{ 47776, [SOURCE_INFO] = GetCoinTextureString(2022300) },	-- Sunstrider's Robe of Conquest
				{ 47773, [SOURCE_INFO] = GetCoinTextureString(1111200) },	-- Sunstrider's Gauntlets of Conquest
				{ 47775, [SOURCE_INFO] = GetCoinTextureString(2014500) },	-- Sunstrider's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				47771,	-- Sunstrider's Hood of Triumph
				47768,	-- Sunstrider's Shoulderpads of Triumph
				47769,	-- Sunstrider's Robe of Triumph
				47772,	-- Sunstrider's Gauntlets of Triumph
				47770,	-- Sunstrider's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				47764,	-- Sunstrider's Hood of Triumph
				47767,	-- Sunstrider's Shoulderpads of Triumph
				47766,	-- Sunstrider's Robe of Triumph
				47763,	-- Sunstrider's Gauntlets of Triumph
				47765,	-- Sunstrider's Leggings of Triumph
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[NORMAL_DIFF] = {
				{ 48597, [SOURCE_INFO] = GetCoinTextureString(1613300) },	-- Liadrin's Headpiece of Conquest
				{ 48595, [SOURCE_INFO] = GetCoinTextureString(1601600) },	-- Liadrin's Spaulders of Conquest
				{ 48599, [SOURCE_INFO] = GetCoinTextureString(2170500) },	-- Liadrin's Tunic of Conquest
				{ 48598, [SOURCE_INFO] = GetCoinTextureString(1087600) },	-- Liadrin's Gloves of Conquest
				{ 48596, [SOURCE_INFO] = GetCoinTextureString(2147400) },	-- Liadrin's Greaves of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48592,	-- Liadrin's Headpiece of Triumph
				48590,	-- Liadrin's Spaulders of Triumph
				48594,	-- Liadrin's Tunic of Triumph
				48593,	-- Liadrin's Gloves of Triumph
				48591,	-- Liadrin's Greaves of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48587,	-- Liadrin's Headpiece of Triumph
				48585,	-- Liadrin's Spaulders of Triumph
				48589,	-- Liadrin's Tunic of Triumph
				48588,	-- Liadrin's Gloves of Triumph
				48586,	-- Liadrin's Greaves of Triumph
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[NORMAL_DIFF] = {
				{ 48654, [SOURCE_INFO] = GetCoinTextureString(1637100) },	-- Liadrin's Faceguard of Conquest
				{ 48656, [SOURCE_INFO] = GetCoinTextureString(1648600) },	-- Liadrin's Shoulderguards of Conquest
				{ 48652, [SOURCE_INFO] = GetCoinTextureString(2115600) },	-- Liadrin's Breastplate of Conquest
				{ 48653, [SOURCE_INFO] = GetCoinTextureString(1095800) },	-- Liadrin's Handguards of Conquest
				{ 48655, [SOURCE_INFO] = GetCoinTextureString(2194500) },	-- Liadrin's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48659,	-- Liadrin's Faceguard of Triumph
				48661,	-- Liadrin's Shoulderguards of Triumph
				48657,	-- Liadrin's Breastplate of Triumph
				48658,	-- Liadrin's Handguards of Triumph
				48660,	-- Liadrin's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48649,	-- Liadrin's Faceguard of Triumph
				48647,	-- Liadrin's Shoulderguards of Triumph
				48651,	-- Liadrin's Breastplate of Triumph
				48650,	-- Liadrin's Handguards of Triumph
				48648,	-- Liadrin's Legguards of Triumph
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[NORMAL_DIFF] = {
				{ 48629, [SOURCE_INFO] = GetCoinTextureString(1566400) },	-- Liadrin's Helm of Conquest
				{ 48627, [SOURCE_INFO] = GetCoinTextureString(1554900) },	-- Liadrin's Shoulderplates of Conquest
				{ 48631, [SOURCE_INFO] = GetCoinTextureString(2108200) },	-- Liadrin's Battleplate of Conquest
				{ 48630, [SOURCE_INFO] = GetCoinTextureString(1056200) },	-- Liadrin's Gauntlets of Conquest
				{ 48628, [SOURCE_INFO] = GetCoinTextureString(2085000) },	-- Liadrin's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48624,	-- Liadrin's Helm of Triumph
				48622,	-- Liadrin's Shoulderplates of Triumph
				48626,	-- Liadrin's Battleplate of Triumph
				48625,	-- Liadrin's Gauntlets of Triumph
				48623,	-- Liadrin's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48619,	-- Liadrin's Helm of Triumph
				48621,	-- Liadrin's Shoulderplates of Triumph
				48617,	-- Liadrin's Battleplate of Triumph
				48618,	-- Liadrin's Gauntlets of Triumph
				48620,	-- Liadrin's Legplates of Triumph
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[NORMAL_DIFF] = {
				{ 48068, [SOURCE_INFO] = GetCoinTextureString(1589600) },	-- Zabra's Cowl of Conquest
				{ 48071, [SOURCE_INFO] = GetCoinTextureString(1607000) },	-- Zabra's Shoulderpads of Conquest
				{ 48070, [SOURCE_INFO] = GetCoinTextureString(2139100) },	-- Zabra's Robe of Conquest
				{ 48067, [SOURCE_INFO] = GetCoinTextureString(1064000) },	-- Zabra's Gloves of Conquest
				{ 48069, [SOURCE_INFO] = GetCoinTextureString(2131300) },	-- Zabra's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48065,	-- Zabra's Cowl of Triumph
				48062,	-- Zabra's Shoulderpads of Triumph
				48063,	-- Zabra's Robe of Triumph
				48066,	-- Zabra's Gloves of Triumph
				48064,	-- Zabra's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48058,	-- Zabra's Cowl of Triumph
				48061,	-- Zabra's Shoulderpads of Triumph
				48060,	-- Zabra's Robe of Triumph
				48057,	-- Zabra's Gloves of Triumph
				48059,	-- Zabra's Leggings of Triumph
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[NORMAL_DIFF] = {
				{ 48098, [SOURCE_INFO] = GetCoinTextureString(1531300) },	-- Zabra's Circlet of Conquest
				{ 48101, [SOURCE_INFO] = GetCoinTextureString(1548600) },	-- Zabra's Mantle of Conquest
				{ 48100, [SOURCE_INFO] = GetCoinTextureString(2061200) },	-- Zabra's Raiments of Conquest
				{ 48097, [SOURCE_INFO] = GetCoinTextureString(1024800) },	-- Zabra's Handwraps of Conquest
				{ 48099, [SOURCE_INFO] = GetCoinTextureString(2053400) },	-- Zabra's Pants of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48095,	-- Zabra's Circlet of Triumph
				48092,	-- Zabra's Mantle of Triumph
				48093,	-- Zabra's Raiments of Triumph
				48096,	-- Zabra's Handwraps of Triumph
				48094,	-- Zabra's Pants of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48088,	-- Zabra's Circlet of Triumph
				48091,	-- Zabra's Mantle of Triumph
				48090,	-- Zabra's Raiments of Triumph
				48087,	-- Zabra's Handwraps of Triumph
				48089,	-- Zabra's Pants of Triumph
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[NORMAL_DIFF] = {
				{ 48245, [SOURCE_INFO] = GetCoinTextureString(1653900) },	-- Garona's Helmet of Conquest
				{ 48247, [SOURCE_INFO] = GetCoinTextureString(1507800) },	-- Garona's Pauldrons of Conquest
				{ 48243, [SOURCE_INFO] = GetCoinTextureString(2194100) },	-- Garona's Breastplate of Conquest
				{ 48244, [SOURCE_INFO] = GetCoinTextureString(1107200) },	-- Garona's Gauntlets of Conquest
				{ 48246, [SOURCE_INFO] = GetCoinTextureString(2006500) },	-- Garona's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48240,	-- Garona's Helmet of Triumph
				48238,	-- Garona's Pauldrons of Triumph
				48242,	-- Garona's Breastplate of Triumph
				48241,	-- Garona's Gauntlets of Triumph
				48239,	-- Garona's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48235,	-- Garona's Helmet of Triumph
				48237,	-- Garona's Pauldrons of Triumph
				48233,	-- Garona's Breastplate of Triumph
				48234,	-- Garona's Gauntlets of Triumph
				48236,	-- Garona's Legplates of Triumph
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[NORMAL_DIFF] = {
				{ 48338, [SOURCE_INFO] = GetCoinTextureString(1654300) },	-- Thrall's Helm of Conquest
				{ 48340, [SOURCE_INFO] = GetCoinTextureString(1508000) },	-- Thrall's Shoulderpads of Conquest
				{ 48336, [SOURCE_INFO] = GetCoinTextureString(2194300) },	-- Thrall's Hauberk of Conquest
				{ 48337, [SOURCE_INFO] = GetCoinTextureString(1107300) },	-- Thrall's Gloves of Conquest
				{ 48339, [SOURCE_INFO] = GetCoinTextureString(2006700) },	-- Thrall's Kilt of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48333,	-- Thrall's Helm of Triumph
				48331,	-- Thrall's Shoulderpads of Triumph
				48335,	-- Thrall's Hauberk of Triumph
				48334,	-- Thrall's Gloves of Triumph
				48332,	-- Thrall's Kilt of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48328,	-- Thrall's Helm of Triumph
				48330,	-- Thrall's Shoulderpads of Triumph
				48326,	-- Thrall's Hauberk of Triumph
				48327,	-- Thrall's Gloves of Triumph
				48329,	-- Thrall's Kilt of Triumph
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[NORMAL_DIFF] = {
				{ 48368, [SOURCE_INFO] = GetCoinTextureString(1595900) },	-- Thrall's Faceguard of Conquest
				{ 48370, [SOURCE_INFO] = GetCoinTextureString(1607400) },	-- Thrall's Shoulderguards of Conquest
				{ 48366, [SOURCE_INFO] = GetCoinTextureString(2116400) },	-- Thrall's Chestguard of Conquest
				{ 48367, [SOURCE_INFO] = GetCoinTextureString(1068100) },	-- Thrall's Grips of Conquest
				{ 48369, [SOURCE_INFO] = GetCoinTextureString(2139600) },	-- Thrall's War-Kilt of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48363,	-- Thrall's Faceguard of Triumph
				48361,	-- Thrall's Shoulderguards of Triumph
				48365,	-- Thrall's Chestguard of Triumph
				48364,	-- Thrall's Grips of Triumph
				48362,	-- Thrall's War-Kilt of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48358,	-- Thrall's Faceguard of Triumph
				48360,	-- Thrall's Shoulderguards of Triumph
				48356,	-- Thrall's Chestguard of Triumph
				48357,	-- Thrall's Grips of Triumph
				48359,	-- Thrall's War-Kilt of Triumph
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[NORMAL_DIFF] = {
				{ 48297, [SOURCE_INFO] = GetCoinTextureString(1607000) },	-- Thrall's Headpiece of Conquest
				{ 48299, [SOURCE_INFO] = GetCoinTextureString(1502600) },	-- Thrall's Spaulders of Conquest
				{ 48295, [SOURCE_INFO] = GetCoinTextureString(2131300) },	-- Thrall's Tunic of Conquest
				{ 48296, [SOURCE_INFO] = GetCoinTextureString(1075700) },	-- Thrall's Handguards of Conquest
				{ 48298, [SOURCE_INFO] = GetCoinTextureString(2154500) },	-- Thrall's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48302,	-- Thrall's Headpiece of Triumph
				48304,	-- Thrall's Spaulders of Triumph
				48300,	-- Thrall's Tunic of Triumph
				48301,	-- Thrall's Handguards of Triumph
				48303,	-- Thrall's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48307,	-- Thrall's Headpiece of Triumph
				48309,	-- Thrall's Spaulders of Triumph
				48305,	-- Thrall's Tunic of Triumph
				48306,	-- Thrall's Handguards of Triumph
				48308,	-- Thrall's Legguards of Triumph
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[NORMAL_DIFF] = {
				{ 47801, [SOURCE_INFO] = GetCoinTextureString(1584300) },	-- Gul'dan's Hood of Conquest
				{ 47798, [SOURCE_INFO] = GetCoinTextureString(1525100) },	-- Gul'dan's Shoulderpads of Conquest
				{ 47799, [SOURCE_INFO] = GetCoinTextureString(2045200) },	-- Gul'dan's Robe of Conquest
				{ 47802, [SOURCE_INFO] = GetCoinTextureString(1068100) },	-- Gul'dan's Gloves of Conquest
				{ 47800, [SOURCE_INFO] = GetCoinTextureString(2052800) },	-- Gul'dan's Leggings of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				47804,	-- Gul'dan's Hood of Triumph
				47807,	-- Gul'dan's Shoulderpads of Triumph
				47806,	-- Gul'dan's Robe of Triumph
				47803,	-- Gul'dan's Gloves of Triumph
				47805,	-- Gul'dan's Leggings of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				47796,	-- Gul'dan's Hood of Triumph
				47793,	-- Gul'dan's Shoulderpads of Triumph
				47794,	-- Gul'dan's Robe of Triumph
				47797,	-- Gul'dan's Gloves of Triumph
				47795,	-- Gul'dan's Leggings of Triumph
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[NORMAL_DIFF] = {
				{ 48388, [SOURCE_INFO] = GetCoinTextureString(1595600) },	-- Hellscream's Helmet of Conquest
				{ 48390, [SOURCE_INFO] = GetCoinTextureString(1607300) },	-- Hellscream's Shoulderplates of Conquest
				{ 48386, [SOURCE_INFO] = GetCoinTextureString(2116200) },	-- Hellscream's Battleplate of Conquest
				{ 48387, [SOURCE_INFO] = GetCoinTextureString(1068000) },	-- Hellscream's Gauntlets of Conquest
				{ 48389, [SOURCE_INFO] = GetCoinTextureString(2139400) },	-- Hellscream's Legplates of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48393,	-- Hellscream's Helmet of Triumph
				48395,	-- Hellscream's Shoulderplates of Triumph
				48391,	-- Hellscream's Battleplate of Triumph
				48392,	-- Hellscream's Gauntlets of Triumph
				48394,	-- Hellscream's Legplates of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48398,	-- Hellscream's Helmet of Triumph
				48400,	-- Hellscream's Shoulderplates of Triumph
				48396,	-- Hellscream's Battleplate of Triumph
				48397,	-- Hellscream's Gauntlets of Triumph
				48399,	-- Hellscream's Legplates of Triumph
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[NORMAL_DIFF] = {
				{ 48458, [SOURCE_INFO] = GetCoinTextureString(1537000) },	-- Hellscream's Greathelm of Conquest
				{ 48460, [SOURCE_INFO] = GetCoinTextureString(1590300) },	-- Hellscream's Pauldrons of Conquest
				{ 48456, [SOURCE_INFO] = GetCoinTextureString(2037600) },	-- Hellscream's Breastplate of Conquest
				{ 48457, [SOURCE_INFO] = GetCoinTextureString(1028500) },	-- Hellscream's Handguards of Conquest
				{ 48459, [SOURCE_INFO] = GetCoinTextureString(2060800) },	-- Hellscream's Legguards of Conquest
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				48463,	-- Hellscream's Greathelm of Triumph
				48465,	-- Hellscream's Pauldrons of Triumph
				48461,	-- Hellscream's Breastplate of Triumph
				48462,	-- Hellscream's Handguards of Triumph
				48464,	-- Hellscream's Legguards of Triumph
			},
			[P25H_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25h",
				48468,	-- Hellscream's Greathelm of Triumph
				48470,	-- Hellscream's Pauldrons of Triumph
				48466,	-- Hellscream's Breastplate of Triumph
				48467,	-- Hellscream's Handguards of Triumph
				48469,	-- Hellscream's Legguards of Triumph
			},
		},
	},

	["Tier8"] = {	-- T8 Sets
		name = format(AL["Tier %d Sets"], 8),
		sourceTemplate = {
			ALIL["Ulduar"].." - "..BB["Mimiron"],	-- Head
			ALIL["Ulduar"].." - "..BB["Thorim"],	-- Shoulder
			ALIL["Ulduar"].." - "..BB["Yogg-Saron"],	-- Chest
			ALIL["Ulduar"].." - "..BB["Freya"],	-- Hands
			ALIL["Ulduar"].." - "..BB["Hodir"],	-- Legs
		},
		sourceTemplatep25 = {
			ALIL["Ulduar"].." - "..BB["Thorim"],	-- Head
			ALIL["Ulduar"].." - "..BB["Yogg-Saron"],	-- Shoulder
			ALIL["Ulduar"].." - "..BB["Hodir"],	-- Chest
			ALIL["Ulduar"].." - "..BB["Mimiron"],	-- Hands
			ALIL["Ulduar"].." - "..BB["Freya"],	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45336,	-- Valorous Darkruned Faceguard
				45339,	-- Valorous Darkruned Pauldrons
				45335,	-- Valorous Darkruned Chestguard
				45337,	-- Valorous Darkruned Handguards
				45338,	-- Valorous Darkruned Legguards
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46120,	-- Conqueror's Darkruned Faceguard
				46122,	-- Conqueror's Darkruned Pauldrons
				46118,	-- Conqueror's Darkruned Chestguard
				46119,	-- Conqueror's Darkruned Handguards
				46121,	-- Conqueror's Darkruned Legguards
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45342,	-- Valorous Darkruned Helmet
				45344,	-- Valorous Darkruned Shoulderplates
				45340,	-- Valorous Darkruned Battleplate
				45341,	-- Valorous Darkruned Gauntlets
				45343,	-- Valorous Darkruned Legplates
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46115,	-- Conqueror's Darkruned Helmet
				46117,	-- Conqueror's Darkruned Shoulderplates
				46111,	-- Conqueror's Darkruned Battleplate
				46113,	-- Conqueror's Darkruned Gauntlets
				46116,	-- Conqueror's Darkruned Legplates
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				46313,	-- Valorous Nightsong Cover
				45352,	-- Valorous Nightsong Mantle
				45354,	-- Valorous Nightsong Vestments
				45351,	-- Valorous Nightsong Gloves
				45353,	-- Valorous Nightsong Trousers
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46191,	-- Conqueror's Nightsong Cover
				46196,	-- Conqueror's Nightsong Mantle
				46194,	-- Conqueror's Nightsong Vestments
				46189,	-- Conqueror's Nightsong Gloves
				46192,	-- Conqueror's Nightsong Trousers
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45356,	-- Valorous Nightsong Headguard
				45359,	-- Valorous Nightsong Shoulderpads
				45358,	-- Valorous Nightsong Raiments
				45355,	-- Valorous Nightsong Handgrips
				45357,	-- Valorous Nightsong Legguards
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46161,	-- Conqueror's Nightsong Headguard
				46157,	-- Conqueror's Nightsong Shoulderpads
				46159,	-- Conqueror's Nightsong Raiments
				46158,	-- Conqueror's Nightsong Handgrips
				46160,	-- Conqueror's Nightsong Legguards
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45346,	-- Valorous Nightsong Headpiece
				45349,	-- Valorous Nightsong Spaulders
				45348,	-- Valorous Nightsong Robe
				45345,	-- Valorous Nightsong Handguards
				45347,	-- Valorous Nightsong Leggings
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46184,	-- Conqueror's Nightsong Headpiece
				46187,	-- Conqueror's Nightsong Spaulders
				46186,	-- Conqueror's Nightsong Robe
				46183,	-- Conqueror's Nightsong Handguards
				46185,	-- Conqueror's Nightsong Leggings
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45361,	-- Valorous Scourgestalker Headpiece
				45363,	-- Valorous Scourgestalker Spaulders
				45364,	-- Valorous Scourgestalker Tunic
				45360,	-- Valorous Scourgestalker Handguards
				45362,	-- Valorous Scourgestalker Legguards
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46143,	-- Conqueror's Scourgestalker Headpiece
				46145,	-- Conqueror's Scourgestalker Spaulders
				46141,	-- Conqueror's Scourgestalker Tunic
				46142,	-- Conqueror's Scourgestalker Handguards
				46144,	-- Conqueror's Scourgestalker Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45365,	-- Valorous Kirin Tor Hood
				45369,	-- Valorous Kirin Tor Shoulderpads
				45368,	-- Valorous Kirin Tor Tunic
				46131,	-- Valorous Kirin Tor Gauntlets
				45367,	-- Valorous Kirin Tor Leggings
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46129,	-- Conqueror's Kirin Tor Hood
				46134,	-- Conqueror's Kirin Tor Shoulderpads
				46130,	-- Conqueror's Kirin Tor Tunic
				46132,	-- Conqueror's Kirin Tor Gauntlets
				46133,	-- Conqueror's Kirin Tor Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45372,	-- Valorous Aegis Headpiece
				45373,	-- Valorous Aegis Spaulders
				45374,	-- Valorous Aegis Tunic
				45370,	-- Valorous Aegis Gloves
				45371,	-- Valorous Aegis Greaves
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46180,	-- Conqueror's Aegis Headpiece
				46182,	-- Conqueror's Aegis Spaulders
				46178,	-- Conqueror's Aegis Tunic
				46179,	-- Conqueror's Aegis Gloves
				46181,	-- Conqueror's Aegis Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45382,	-- Valorous Aegis Faceguard
				45385,	-- Valorous Aegis Shoulderguards
				45381,	-- Valorous Aegis Breastplate
				45383,	-- Valorous Aegis Handguards
				45384,	-- Valorous Aegis Legguards
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46175,	-- Conqueror's Aegis Faceguard
				46177,	-- Conqueror's Aegis Shoulderguards
				46173,	-- Conqueror's Aegis Breastplate
				46174,	-- Conqueror's Aegis Handguards
				46176,	-- Conqueror's Aegis Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45377,	-- Valorous Aegis Helm
				45380,	-- Valorous Aegis Shoulderplates
				45375,	-- Valorous Aegis Battleplate
				45376,	-- Valorous Aegis Gauntlets
				45379,	-- Valorous Aegis Legplates
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46156,	-- Conqueror's Aegis Helm
				46152,	-- Conqueror's Aegis Shoulderplates
				46154,	-- Conqueror's Aegis Battleplate
				46155,	-- Conqueror's Aegis Gauntlets
				46153,	-- Conqueror's Aegis Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45386,	-- Valorous Cowl of Sanctification
				45390,	-- Valorous Shoulderpads of Sanctification
				45389,	-- Valorous Robe of Sanctification
				45387,	-- Valorous Gloves of Sanctification
				45388,	-- Valorous Leggings of Sanctification
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46197,	-- Conqueror's Cowl of Sanctification
				46190,	-- Conqueror's Shoulderpads of Sanctification
				46193,	-- Conqueror's Robe of Sanctification
				46188,	-- Conqueror's Gloves of Sanctification
				46195,	-- Conqueror's Leggings of Sanctification
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45391,	-- Valorous Circlet of Sanctification
				45393,	-- Valorous Mantle of Sanctification
				45395,	-- Valorous Raiments of Sanctification
				45392,	-- Valorous Handwraps of Sanctification
				45394,	-- Valorous Pants of Sanctification
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46172,	-- Conqueror's Circlet of Sanctification
				46165,	-- Conqueror's Mantle of Sanctification
				46168,	-- Conqueror's Raiments of Sanctification
				46163,	-- Conqueror's Handwraps of Sanctification
				46170,	-- Conqueror's Pants of Sanctification
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45398,	-- Valorous Terrorblade Helmet
				45400,	-- Valorous Terrorblade Pauldrons
				45396,	-- Valorous Terrorblade Breastplate
				45397,	-- Valorous Terrorblade Gauntlets
				45399,	-- Valorous Terrorblade Legplates
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46125,	-- Conqueror's Terrorblade Helmet
				46127,	-- Conqueror's Terrorblade Pauldrons
				46123,	-- Conqueror's Terrorblade Breastplate
				46124,	-- Conqueror's Terrorblade Gauntlets
				46126,	-- Conqueror's Terrorblade Legplates
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45408,	-- Valorous Worldbreaker Helm
				45410,	-- Valorous Worldbreaker Shoulderpads
				45411,	-- Valorous Worldbreaker Hauberk
				45406,	-- Valorous Worldbreaker Gloves
				45409,	-- Valorous Worldbreaker Kilt
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46209,	-- Conqueror's Worldbreaker Helm
				46211,	-- Conqueror's Worldbreaker Shoulderpads
				46206,	-- Conqueror's Worldbreaker Hauberk
				46207,	-- Conqueror's Worldbreaker Gloves
				46210,	-- Conqueror's Worldbreaker Kilt
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45412,	-- Valorous Worldbreaker Faceguard
				45415,	-- Valorous Worldbreaker Shoulderguards
				45413,	-- Valorous Worldbreaker Chestguard
				45414,	-- Valorous Worldbreaker Grips
				45416,	-- Valorous Worldbreaker War-Kilt
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46212,	-- Conqueror's Worldbreaker Faceguard
				46203,	-- Conqueror's Worldbreaker Shoulderguards
				46205,	-- Conqueror's Worldbreaker Chestguard
				46200,	-- Conqueror's Worldbreaker Grips
				46208,	-- Conqueror's Worldbreaker War-Kilt
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45402,	-- Valorous Worldbreaker Headpiece
				45404,	-- Valorous Worldbreaker Spaulders
				45405,	-- Valorous Worldbreaker Tunic
				45401,	-- Valorous Worldbreaker Handguards
				45403,	-- Valorous Worldbreaker Legguards
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46201,	-- Conqueror's Worldbreaker Headpiece
				46204,	-- Conqueror's Worldbreaker Spaulders
				46198,	-- Conqueror's Worldbreaker Tunic
				46199,	-- Conqueror's Worldbreaker Handguards
				46202,	-- Conqueror's Worldbreaker Legguards
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45417,	-- Valorous Deathbringer Hood
				45422,	-- Valorous Deathbringer Shoulderpads
				45421,	-- Valorous Deathbringer Robe
				45419,	-- Valorous Deathbringer Gloves
				45420,	-- Valorous Deathbringer Leggings
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46140,	-- Conqueror's Deathbringer Hood
				46136,	-- Conqueror's Deathbringer Shoulderpads
				46137,	-- Conqueror's Deathbringer Robe
				46135,	-- Conqueror's Deathbringer Gloves
				46139,	-- Conqueror's Deathbringer Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45431,	-- Valorous Siegebreaker Helmet
				45433,	-- Valorous Siegebreaker Shoulderplates
				45429,	-- Valorous Siegebreaker Battleplate
				45430,	-- Valorous Siegebreaker Gauntlets
				45432,	-- Valorous Siegebreaker Legplates
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46151,	-- Conqueror's Siegebreaker Helmet
				46149,	-- Conqueror's Siegebreaker Shoulderplates
				46146,	-- Conqueror's Siegebreaker Battleplate
				46148,	-- Conqueror's Siegebreaker Gauntlets
				46150,	-- Conqueror's Siegebreaker Legplates
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[NORMAL_DIFF] = {
				[SOURCE_INFO] = "sourceTemplate",
				45425,	-- Valorous Siegebreaker Greathelm
				45428,	-- Valorous Siegebreaker Pauldrons
				45424,	-- Valorous Siegebreaker Breastplate
				45426,	-- Valorous Siegebreaker Handguards
				45427,	-- Valorous Siegebreaker Legguards
			},
			[P25_DIFF] = {
				[SOURCE_INFO] = "sourceTemplatep25",
				46166,	-- Conqueror's Siegebreaker Greathelm
				46167,	-- Conqueror's Siegebreaker Pauldrons
				46162,	-- Conqueror's Siegebreaker Breastplate
				46164,	-- Conqueror's Siegebreaker Handguards
				46169,	-- Conqueror's Siegebreaker Legguards
			},
		},
	},

	["Tier7"] = {	-- T7 Sets
		name = format(AL["Tier %d Sets"], 7),
		sourceTemplate = {
			ALIL["Naxxramas"].." - "..BB["Kel'Thuzad"],	-- Head
			ALIL["Naxxramas"].." - "..BB["Loatheb"],	-- Shoulder
			ALIL["Naxxramas"].." - "..BB["The Four Horsemen"],	-- Chest
			ALIL["The Obsidian Sanctum"].." - "..BB["Sartharion"],	-- Hands
			ALIL["Naxxramas"].." - "..BB["Thaddius"],	-- Legs
		},
		{	-- Deathknight - Blood
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Blood"]..")",
			subSetName = "deathknightblood",
			icon = "dkTank",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39625,	-- Heroes' Scourgeborne Faceguard
				39627,	-- Heroes' Scourgeborne Pauldrons
				39623,	-- Heroes' Scourgeborne Chestguard
				39624,	-- Heroes' Scourgeborne Handguards
				39626,	-- Heroes' Scourgeborne Legguards
			},
			[P25_DIFF] = {
				40565,	-- Valorous Scourgeborne Faceguard
				40568,	-- Valorous Scourgeborne Pauldrons
				40559,	-- Valorous Scourgeborne Chestguard
				40563,	-- Valorous Scourgeborne Handguards
				40567,	-- Valorous Scourgeborne Legguards
			},
		},
		{	-- Deathknight - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." ("..ALIL["Frost"].." / "..ALIL["Unholy"]..")",
			subSetName = "deathknightdps",
			icon = "dkDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39619,	-- Heroes' Scourgeborne Helmet
				39621,	-- Heroes' Scourgeborne Shoulderplates
				39617,	-- Heroes' Scourgeborne Battleplate
				39618,	-- Heroes' Scourgeborne Gauntlets
				39620,	-- Heroes' Scourgeborne Legplates
			},
			[P25_DIFF] = {
				40554,	-- Valorous Scourgeborne Helmet
				40557,	-- Valorous Scourgeborne Shoulderplates
				40550,	-- Valorous Scourgeborne Battleplate
				40552,	-- Valorous Scourgeborne Gauntlets
				40556,	-- Valorous Scourgeborne Legplates
			},
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39545,	-- Heroes' Dreamwalker Cover
				39548,	-- Heroes' Dreamwalker Mantle
				39547,	-- Heroes' Dreamwalker Vestments
				39544,	-- Heroes' Dreamwalker Gloves
				39546,	-- Heroes' Dreamwalker Trousers
			},
			[P25_DIFF] = {
				40467,	-- Valorous Dreamwalker Cover
				40470,	-- Valorous Dreamwalker Mantle
				40469,	-- Valorous Dreamwalker Vestments
				40466,	-- Valorous Dreamwalker Gloves
				40468,	-- Valorous Dreamwalker Trousers
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39553,	-- Heroes' Dreamwalker Headguard
				39556,	-- Heroes' Dreamwalker Shoulderpads
				39554,	-- Heroes' Dreamwalker Raiments
				39557,	-- Heroes' Dreamwalker Handgrips
				39555,	-- Heroes' Dreamwalker Legguards
			},
			[P25_DIFF] = {
				40473,	-- Valorous Dreamwalker Headguard
				40494,	-- Valorous Dreamwalker Shoulderpads
				40471,	-- Valorous Dreamwalker Raiments
				40472,	-- Valorous Dreamwalker Handgrips
				40493,	-- Valorous Dreamwalker Legguards
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39531,	-- Heroes' Dreamwalker Headpiece
				39542,	-- Heroes' Dreamwalker Spaulders
				39538,	-- Heroes' Dreamwalker Robe
				39543,	-- Heroes' Dreamwalker Handguards
				39539,	-- Heroes' Dreamwalker Leggings
			},
			[P25_DIFF] = {
				40461,	-- Valorous Dreamwalker Headpiece
				40465,	-- Valorous Dreamwalker Spaulders
				40463,	-- Valorous Dreamwalker Robe
				40460,	-- Valorous Dreamwalker Handguards
				40462,	-- Valorous Dreamwalker Leggings
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39578,	-- Heroes' Cryptstalker Headpiece
				39581,	-- Heroes' Cryptstalker Spaulders
				39579,	-- Heroes' Cryptstalker Tunic
				39582,	-- Heroes' Cryptstalker Handguards
				39580,	-- Heroes' Cryptstalker Legguards
			},
			[P25_DIFF] = {
				40505,	-- Valorous Cryptstalker Headpiece
				40507,	-- Valorous Cryptstalker Spaulders
				40503,	-- Valorous Cryptstalker Tunic
				40504,	-- Valorous Cryptstalker Handguards
				40506,	-- Valorous Cryptstalker Legguards
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39491,	-- Heroes' Frostfire Circlet
				39494,	-- Heroes' Frostfire Shoulderpads
				39492,	-- Heroes' Frostfire Robe
				39495,	-- Heroes' Frostfire Gloves
				39493,	-- Heroes' Frostfire Leggings
			},
			[P25_DIFF] = {
				40416,	-- Valorous Frostfire Circlet
				40419,	-- Valorous Frostfire Shoulderpads
				40418,	-- Valorous Frostfire Robe
				40415,	-- Valorous Frostfire Gloves
				40417,	-- Valorous Frostfire Leggings
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39628,	-- Heroes' Redemption Headpiece
				39631,	-- Heroes' Redemption Spaulders
				39629,	-- Heroes' Redemption Tunic
				39632,	-- Heroes' Redemption Gloves
				39630,	-- Heroes' Redemption Greaves
			},
			[P25_DIFF] = {
				40571,	-- Valorous Redemption Headpiece
				40573,	-- Valorous Redemption Spaulders
				40569,	-- Valorous Redemption Tunic
				40570,	-- Valorous Redemption Gloves
				40572,	-- Valorous Redemption Greaves
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39640,	-- Heroes' Redemption Faceguard
				39642,	-- Heroes' Redemption Shoulderguards
				39638,	-- Heroes' Redemption Breastplate
				39639,	-- Heroes' Redemption Handguards
				39641,	-- Heroes' Redemption Legguards
			},
			[P25_DIFF] = {
				40581,	-- Valorous Redemption Faceguard
				40584,	-- Valorous Redemption Shoulderguards
				40579,	-- Valorous Redemption Breastplate
				40580,	-- Valorous Redemption Handguards
				40583,	-- Valorous Redemption Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39635,	-- Heroes' Redemption Helm
				39637,	-- Heroes' Redemption Shoulderplates
				39633,	-- Heroes' Redemption Chestpiece
				39634,	-- Heroes' Redemption Gauntlets
				39636,	-- Heroes' Redemption Legplates
			},
			[P25_DIFF] = {
				40576,	-- Valorous Redemption Helm
				40578,	-- Valorous Redemption Shoulderplates
				40574,	-- Valorous Redemption Chestpiece
				40575,	-- Valorous Redemption Gauntlets
				40577,	-- Valorous Redemption Legplates
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39514,	-- Heroes' Cowl of Faith
				39518,	-- Heroes' Shoulderpads of Faith
				39515,	-- Heroes' Robe of Faith
				39519,	-- Heroes' Gloves of Faith
				39517,	-- Heroes' Leggings of Faith
			},
			[P25_DIFF] = {
				40447,	-- Valorous Cowl of Faith
				40450,	-- Valorous Shoulderpads of Faith
				40449,	-- Valorous Robe of Faith
				40445,	-- Valorous Gloves of Faith
				40448,	-- Valorous Leggings of Faith
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39521,	-- Heroes' Circlet of Faith
				39529,	-- Heroes' Mantle of Faith
				39523,	-- Heroes' Raiments of Faith
				39530,	-- Heroes' Handwraps of Faith
				39528,	-- Heroes' Pants of Faith
			},
			[P25_DIFF] = {
				40456,	-- Valorous Circlet of Faith
				40459,	-- Valorous Mantle of Faith
				40458,	-- Valorous Raiments of Faith
				40454,	-- Valorous Handwraps of Faith
				40457,	-- Valorous Pants of Faith
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39561,	-- Heroes' Bonescythe Helmet
				39565,	-- Heroes' Bonescythe Pauldrons
				39558,	-- Heroes' Bonescythe Breastplate
				39560,	-- Heroes' Bonescythe Gauntlets
				39564,	-- Heroes' Bonescythe Legplates
			},
			[P25_DIFF] = {
				40499,	-- Valorous Bonescythe Helmet
				40502,	-- Valorous Bonescythe Pauldrons
				40495,	-- Valorous Bonescythe Breastplate
				40496,	-- Valorous Bonescythe Gauntlets
				40500,	-- Valorous Bonescythe Legplates
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39594,	-- Heroes' Earthshatter Helm
				39596,	-- Heroes' Earthshatter Shoulderpads
				39592,	-- Heroes' Earthshatter Hauberk
				39593,	-- Heroes' Earthshatter Gloves
				39595,	-- Heroes' Earthshatter Kilt
			},
			[P25_DIFF] = {
				40516,	-- Valorous Earthshatter Helm
				40518,	-- Valorous Earthshatter Shoulderpads
				40514,	-- Valorous Earthshatter Hauberk
				40515,	-- Valorous Earthshatter Gloves
				40517,	-- Valorous Earthshatter Kilt
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39602,	-- Heroes' Earthshatter Faceguard
				39604,	-- Heroes' Earthshatter Shoulderguards
				39597,	-- Heroes' Earthshatter Chestguard
				39601,	-- Heroes' Earthshatter Grips
				39603,	-- Heroes' Earthshatter War-Kilt
			},
			[P25_DIFF] = {
				40521,	-- Valorous Earthshatter Faceguard
				40524,	-- Valorous Earthshatter Shoulderguards
				40523,	-- Valorous Earthshatter Chestguard
				40520,	-- Valorous Earthshatter Grips
				40522,	-- Valorous Earthshatter War-Kilt
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39583,	-- Heroes' Earthshatter Headpiece
				39590,	-- Heroes' Earthshatter Spaulders
				39588,	-- Heroes' Earthshatter Tunic
				39591,	-- Heroes' Earthshatter Handguards
				39589,	-- Heroes' Earthshatter Legguards
			},
			[P25_DIFF] = {
				40510,	-- Valorous Earthshatter Headpiece
				40513,	-- Valorous Earthshatter Spaulders
				40508,	-- Valorous Earthshatter Tunic
				40509,	-- Valorous Earthshatter Handguards
				40512,	-- Valorous Earthshatter Legguards
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39496,	-- Heroes' Plagueheart Circlet
				39499,	-- Heroes' Plagueheart Shoulderpads
				39497,	-- Heroes' Plagueheart Robe
				39500,	-- Heroes' Plagueheart Gloves
				39498,	-- Heroes' Plagueheart Leggings
			},
			[P25_DIFF] = {
				40421,	-- Valorous Plagueheart Circlet
				40424,	-- Valorous Plagueheart Shoulderpads
				40423,	-- Valorous Plagueheart Robe
				40420,	-- Valorous Plagueheart Gloves
				40422,	-- Valorous Plagueheart Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39605,	-- Heroes' Dreadnaught Helmet
				39608,	-- Heroes' Dreadnaught Shoulderplates
				39606,	-- Heroes' Dreadnaught Battleplate
				39609,	-- Heroes' Dreadnaught Gauntlets
				39607,	-- Heroes' Dreadnaught Legplates
			},
			[P25_DIFF] = {
				40528,	-- Valorous Dreadnaught Helmet
				40530,	-- Valorous Dreadnaught Shoulderplates
				40525,	-- Valorous Dreadnaught Battleplate
				40527,	-- Valorous Dreadnaught Gauntlets
				40529,	-- Valorous Dreadnaught Legplates
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				39610,	-- Heroes' Dreadnaught Greathelm
				39613,	-- Heroes' Dreadnaught Pauldrons
				39611,	-- Heroes' Dreadnaught Breastplate
				39622,	-- Heroes' Dreadnaught Handguards
				39612,	-- Heroes' Dreadnaught Legguards
			},
			[P25_DIFF] = {
				40546,	-- Valorous Dreadnaught Greathelm
				40548,	-- Valorous Dreadnaught Pauldrons
				40544,	-- Valorous Dreadnaught Breastplate
				40545,	-- Valorous Dreadnaught Handguards
				40547,	-- Valorous Dreadnaught Legguards
			},
		},
	},

	["Tier6"] = {	-- T6 Sets
		name = format(AL["Tier %d Sets"], 6),
		sourceTemplate = {
			ALIL["Hyjal Summit"].." - "..BB["Archimonde"],	-- Head
			ALIL["Black Temple"].." - "..BB["Mother Shahraz"],	-- Shoulder
			ALIL["Black Temple"].." - "..BB["Illidan Stormrage"],	-- Chest
			ALIL["Sunwell Plateau"].." - "..BB["Kalecgos"],	-- Wrist
			ALIL["Hyjal Summit"].." - "..BB["Azgalor"],	-- Hands
			ALIL["Sunwell Plateau"].." - "..BB["Brutallus"],	-- Waist
			ALIL["Black Temple"].." - "..BB["The Illidari Council"],	-- Legs
			ALIL["Sunwell Plateau"].." - "..BB["Felmyst"],	-- Feet
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31040,	-- Thunderheart Headguard
				31049,	-- Thunderheart Shoulderpads
				31043,	-- Thunderheart Vest
				34446,	-- Thunderheart Bands
				31035,	-- Thunderheart Handguards
				34555,	-- Thunderheart Cord
				31046,	-- Thunderheart Pants
				34572,	-- Thunderheart Footwraps
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31039,	-- Thunderheart Cover
				31048,	-- Thunderheart Pauldrons
				31042,	-- Thunderheart Chestguard
				34444,	-- Thunderheart Wristguards
				31034,	-- Thunderheart Gauntlets
				34556,	-- Thunderheart Waistguard
				31044,	-- Thunderheart Leggings
				34573,	-- Thunderheart Treads
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31037,	-- Thunderheart Helmet
				31047,	-- Thunderheart Spaulders
				31041,	-- Thunderheart Tunic
				34445,	-- Thunderheart Bracers
				31032,	-- Thunderheart Gloves
				34554,	-- Thunderheart Belt
				31045,	-- Thunderheart Legguards
				34571,	-- Thunderheart Boots
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31003,	-- Gronnstalker's Helmet
				31006,	-- Gronnstalker's Spaulders
				31004,	-- Gronnstalker's Chestguard
				34443,	-- Gronnstalker's Bracers
				31001,	-- Gronnstalker's Gloves
				34549,	-- Gronnstalker's Belt
				31005,	-- Gronnstalker's Leggings
				34570,	-- Gronnstalker's Boots
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31056,	-- Cowl of the Tempest
				31059,	-- Mantle of the Tempest
				31057,	-- Robes of the Tempest
				34447,	-- Bracers of the Tempest
				31055,	-- Gloves of the Tempest
				34557,	-- Belt of the Tempest
				31058,	-- Leggings of the Tempest
				34574,	-- Boots of the Tempest
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30988,	-- Lightbringer Greathelm
				30996,	-- Lightbringer Pauldrons
				30992,	-- Lightbringer Chestpiece
				34432,	-- Lightbringer Bracers
				30983,	-- Lightbringer Gloves
				34487,	-- Lightbringer Belt
				30994,	-- Lightbringer Leggings
				34559,	-- Lightbringer Treads
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30987,	-- Lightbringer Faceguard
				30998,	-- Lightbringer Shoulderguards
				30991,	-- Lightbringer Chestguard
				34433,	-- Lightbringer Wristguards
				30985,	-- Lightbringer Handguards
				34488,	-- Lightbringer Waistguard
				30995,	-- Lightbringer Legguards
				34560,	-- Lightbringer Stompers
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30989,	-- Lightbringer War-Helm
				30997,	-- Lightbringer Shoulderbraces
				30990,	-- Lightbringer Breastplate
				34431,	-- Lightbringer Bands
				30982,	-- Lightbringer Gauntlets
				34485,	-- Lightbringer Girdle
				30993,	-- Lightbringer Greaves
				34561,	-- Lightbringer Boots
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31063,	-- Cowl of Absolution
				31069,	-- Mantle of Absolution
				31066,	-- Vestments of Absolution
				34435,	-- Cuffs of Absolution
				31060,	-- Gloves of Absolution
				34527,	-- Belt of Absolution
				31068,	-- Breeches of Absolution
				34562,	-- Boots of Absolution
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31064,	-- Hood of Absolution
				31070,	-- Shoulderpads of Absolution
				31065,	-- Shroud of Absolution
				34434,	-- Bracers of Absolution
				31061,	-- Handguards of Absolution
				34528,	-- Cord of Absolution
				31067,	-- Leggings of Absolution
				34563,	-- Treads of Absolution
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31027,	-- Slayer's Helm
				31030,	-- Slayer's Shoulderpads
				31028,	-- Slayer's Chestguard
				34448,	-- Slayer's Bracers
				31026,	-- Slayer's Handguards
				34558,	-- Slayer's Belt
				31029,	-- Slayer's Legguards
				34575,	-- Slayer's Boots
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31014,	-- Skyshatter Headguard
				31023,	-- Skyshatter Mantle
				31017,	-- Skyshatter Breastplate
				34437,	-- Skyshatter Bands
				31008,	-- Skyshatter Gauntlets
				34542,	-- Skyshatter Cord
				31020,	-- Skyshatter Legguards
				34566,	-- Skyshatter Treads
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31015,	-- Skyshatter Cover
				31024,	-- Skyshatter Pauldrons
				31018,	-- Skyshatter Tunic
				34439,	-- Skyshatter Wristguards
				31011,	-- Skyshatter Grips
				34545,	-- Skyshatter Girdle
				31021,	-- Skyshatter Pants
				34567,	-- Skyshatter Greaves
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31012,	-- Skyshatter Helmet
				31022,	-- Skyshatter Shoulderpads
				31016,	-- Skyshatter Chestguard
				34438,	-- Skyshatter Bracers
				31007,	-- Skyshatter Gloves
				34543,	-- Skyshatter Belt
				31019,	-- Skyshatter Leggings
				34565,	-- Skyshatter Boots
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				31051,	-- Hood of the Malefic
				31054,	-- Mantle of the Malefic
				31052,	-- Robe of the Malefic
				34436,	-- Bracers of the Malefic
				31050,	-- Gloves of the Malefic
				34541,	-- Belt of the Malefic
				31053,	-- Leggings of the Malefic
				34564,	-- Boots of the Malefic
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30972,	-- Onslaught Battle-Helm
				30979,	-- Onslaught Shoulderblades
				30975,	-- Onslaught Breastplate
				34441,	-- Onslaught Bracers
				30969,	-- Onslaught Gauntlets
				34546,	-- Onslaught Belt
				30977,	-- Onslaught Greaves
				34569,	-- Onslaught Treads
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30974,	-- Onslaught Greathelm
				30980,	-- Onslaught Shoulderguards
				30976,	-- Onslaught Chestguard
				34442,	-- Onslaught Wristguards
				30970,	-- Onslaught Handguards
				34547,	-- Onslaught Waistguard
				30978,	-- Onslaught Legguards
				34568,	-- Onslaught Boots
			},
		},
	},

	["Tier5"] = {	-- T5 Sets
		name = format(AL["Tier %d Sets"], 5),
		sourceTemplate = {
			ALIL["Serpentshrine Cavern"].." - "..BB["Lady Vashj"],	-- Head
			ALIL["Tempest Keep"].." - "..BB["Void Reaver"],	-- Shoulder
			ALIL["Tempest Keep"].." - "..BB["Kael'thas Sunstrider"],	-- Chest
			ALIL["Serpentshrine Cavern"].." - "..BB["Leotheras the Blind"],	-- Hands
			ALIL["Serpentshrine Cavern"].." - "..BB["Fathom-Lord Karathress"],	-- Legs
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30233,	-- Nordrassil Headpiece
				30235,	-- Nordrassil Wrath-Mantle
				30231,	-- Nordrassil Chestpiece
				30232,	-- Nordrassil Gauntlets
				30234,	-- Nordrassil Wrath-Kilt
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30228,	-- Nordrassil Headdress
				30230,	-- Nordrassil Feral-Mantle
				30222,	-- Nordrassil Chestplate
				30223,	-- Nordrassil Handgrips
				30229,	-- Nordrassil Feral-Kilt
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30219,	-- Nordrassil Headguard
				30221,	-- Nordrassil Life-Mantle
				30216,	-- Nordrassil Chestguard
				30217,	-- Nordrassil Gloves
				30220,	-- Nordrassil Life-Kilt
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30141,	-- Rift Stalker Helm
				30143,	-- Rift Stalker Mantle
				30139,	-- Rift Stalker Hauberk
				30140,	-- Rift Stalker Gauntlets
				30142,	-- Rift Stalker Leggings
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30206,	-- Cowl of Tirisfal
				30210,	-- Mantle of Tirisfal
				30196,	-- Robes of Tirisfal
				30205,	-- Gloves of Tirisfal
				30207,	-- Leggings of Tirisfal
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30136,	-- Crystalforge Greathelm
				30138,	-- Crystalforge Pauldrons
				30134,	-- Crystalforge Chestpiece
				30135,	-- Crystalforge Gloves
				30137,	-- Crystalforge Leggings
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30125,	-- Crystalforge Faceguard
				30127,	-- Crystalforge Shoulderguards
				30123,	-- Crystalforge Chestguard
				30124,	-- Crystalforge Handguards
				30126,	-- Crystalforge Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30131,	-- Crystalforge War-Helm
				30133,	-- Crystalforge Shoulderbraces
				30129,	-- Crystalforge Breastplate
				30130,	-- Crystalforge Gauntlets
				30132,	-- Crystalforge Greaves
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30152,	-- Cowl of the Avatar
				30154,	-- Mantle of the Avatar
				30150,	-- Vestments of the Avatar
				30151,	-- Gloves of the Avatar
				30153,	-- Breeches of the Avatar
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30161,	-- Hood of the Avatar
				30163,	-- Wings of the Avatar
				30159,	-- Shroud of the Avatar
				30160,	-- Handguards of the Avatar
				30162,	-- Leggings of the Avatar
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30146,	-- Deathmantle Helm
				30149,	-- Deathmantle Shoulderpads
				30144,	-- Deathmantle Chestguard
				30145,	-- Deathmantle Handguards
				30148,	-- Deathmantle Legguards
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30171,	-- Cataclysm Headpiece
				30173,	-- Cataclysm Shoulderpads
				30169,	-- Cataclysm Chestpiece
				30170,	-- Cataclysm Handgrips
				30172,	-- Cataclysm Leggings
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30190,	-- Cataclysm Helm
				30194,	-- Cataclysm Shoulderplates
				30185,	-- Cataclysm Chestplate
				30189,	-- Cataclysm Gauntlets
				30192,	-- Cataclysm Legplates
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30166,	-- Cataclysm Headguard
				30168,	-- Cataclysm Shoulderguards
				30164,	-- Cataclysm Chestguard
				30165,	-- Cataclysm Gloves
				30167,	-- Cataclysm Legguards
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30212,	-- Hood of the Corruptor
				30215,	-- Mantle of the Corruptor
				30214,	-- Robe of the Corruptor
				30211,	-- Gloves of the Corruptor
				30213,	-- Leggings of the Corruptor
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30120,	-- Destroyer Battle-Helm
				30122,	-- Destroyer Shoulderblades
				30118,	-- Destroyer Breastplate
				30119,	-- Destroyer Gauntlets
				30121,	-- Destroyer Greaves
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[P25_DIFF] = {
				30115,	-- Destroyer Greathelm
				30117,	-- Destroyer Shoulderguards
				30113,	-- Destroyer Chestguard
				30114,	-- Destroyer Handguards
				30116,	-- Destroyer Legguards
			},
		},
	},

	["Tier4"] = {	-- T4 Sets
		name = format(AL["Tier %d Sets"], 4),
		sourceTemplate = {
			ALIL["Karazhan"].." - "..BB["Prince Malchezaar"],	-- Head
			ALIL["Gruul's Lair"].." - "..BB["High King Maulgar"],	-- Shoulder
			ALIL["Magtheridon's Lair"].." - "..BB["Magtheridon"],	-- Chest
			ALIL["Karazhan"].." - "..BB["The Curator"],	-- Hands
			ALIL["Gruul's Lair"].." - "..BB["Gruul the Dragonkiller"],	-- Legs
		},
		{	-- Druid - Balance
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Balance"]..")",
			subSetName = "druidbalance",
			icon = "druidBalance",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29093,	-- Antlers of Malorne
				29095,	-- Pauldrons of Malorne
				29091,	-- Chestpiece of Malorne
				29092,	-- Gloves of Malorne
				29094,	-- Britches of Malorne
			},
		},
		{	-- Druid - Feral
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Feral"]..")",
			subSetName = "druidferal",
			icon = "druidDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29098,	-- Stag-Helm of Malorne
				29100,	-- Mantle of Malorne
				29096,	-- Breastplate of Malorne
				29097,	-- Gauntlets of Malorne
				29099,	-- Greaves of Malorne
			},
		},
		{	-- Druid - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." ("..ALIL["Restoration"]..")",
			subSetName = "druidrestoration",
			icon = "druidResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29086,	-- Crown of Malorne
				29089,	-- Shoulderguards of Malorne
				29087,	-- Chestguard of Malorne
				29090,	-- Handguards of Malorne
				29088,	-- Legguards of Malorne
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29081,	-- Demon Stalker Greathelm
				29084,	-- Demon Stalker Shoulderguards
				29082,	-- Demon Stalker Harness
				29085,	-- Demon Stalker Gauntlets
				29083,	-- Demon Stalker Greaves
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29076,	-- Collar of the Aldor
				29079,	-- Pauldrons of the Aldor
				29077,	-- Vestments of the Aldor
				29080,	-- Gloves of the Aldor
				29078,	-- Legwraps of the Aldor
			},
		},
		{	-- Paladin - Holy
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Holy"]..")",
			subSetName = "paladinholy",
			icon = "palaHoly",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29061,	-- Justicar Diadem
				29064,	-- Justicar Pauldrons
				29062,	-- Justicar Chestpiece
				29065,	-- Justicar Gloves
				29063,	-- Justicar Leggings
			},
		},
		{	-- Paladin - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Protection"]..")",
			subSetName = "paladinprotection",
			icon = "palaProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29068,	-- Justicar Faceguard
				29070,	-- Justicar Shoulderguards
				29066,	-- Justicar Chestguard
				29067,	-- Justicar Handguards
				29069,	-- Justicar Legguards
			},
		},
		{	-- Paladin - Retribution
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." ("..ALIL["Retribution"]..")",
			subSetName = "paladinretribution",
			icon = "palaRetri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29073,	-- Justicar Crown
				29075,	-- Justicar Shoulderplates
				29071,	-- Justicar Breastplate
				29072,	-- Justicar Gauntlets
				29074,	-- Justicar Greaves
			},
		},
		{	-- Priest - Heal
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Discipline"].." / "..ALIL["Holy"]..")",
			subSetName = "priestheal",
			icon = "priestHeal",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29049,	-- Light-Collar of the Incarnate
				29054,	-- Light-Mantle of the Incarnate
				29050,	-- Robes of the Incarnate
				29055,	-- Handwraps of the Incarnate
				29053,	-- Trousers of the Incarnate
			},
		},
		{	-- Priest - Shadow
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." ("..ALIL["Shadow"]..")",
			subSetName = "priestshadow",
			icon = "priestShadow",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29058,	-- Soul-Collar of the Incarnate
				29060,	-- Soul-Mantle of the Incarnate
				29056,	-- Shroud of the Incarnate
				29057,	-- Gloves of the Incarnate
				29059,	-- Leggings of the Incarnate
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29044,	-- Netherblade Facemask
				29047,	-- Netherblade Shoulderpads
				29045,	-- Netherblade Chestpiece
				29048,	-- Netherblade Gloves
				29046,	-- Netherblade Breeches
			},
		},
		{	-- Shaman - Elemental
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Elemental"]..")",
			subSetName = "shamanelemental",
			icon = "shamanEle",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29035,	-- Cyclone Faceguard
				29037,	-- Cyclone Shoulderguards
				29033,	-- Cyclone Chestguard
				29034,	-- Cyclone Handguards
				29036,	-- Cyclone Legguards
			},
		},
		{	-- Shaman - Enhancement
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Enhancement"]..")",
			subSetName = "shamanenhancement",
			icon = "shamanEnhanc",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29040,	-- Cyclone Helm
				29043,	-- Cyclone Shoulderplates
				29038,	-- Cyclone Breastplate
				29039,	-- Cyclone Gauntlets
				29042,	-- Cyclone War-Kilt
			},
		},
		{	-- Shaman - Restoration
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." ("..ALIL["Restoration"]..")",
			subSetName = "shamanrestoration",
			icon = "shamanResto",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29028,	-- Cyclone Headdress
				29031,	-- Cyclone Shoulderpads
				29029,	-- Cyclone Hauberk
				29032,	-- Cyclone Gloves
				29030,	-- Cyclone Kilt
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				28963,	-- Voidheart Crown
				28967,	-- Voidheart Mantle
				28964,	-- Voidheart Robe
				28968,	-- Voidheart Gloves
				28966,	-- Voidheart Leggings
			},
		},
		{	-- Warrior - DPS
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Arms"].." / "..ALIL["Fury"]..")",
			subSetName = "warriordps",
			icon = "warriDPS",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29021,	-- Warbringer Battle-Helm
				29023,	-- Warbringer Shoulderplates
				29019,	-- Warbringer Breastplate
				29020,	-- Warbringer Gauntlets
				29022,	-- Warbringer Greaves
			},
		},
		{	-- Warrior - Protection
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." ("..ALIL["Protection"]..")",
			subSetName = "warriorprotection",
			icon = "warriProt",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				29011,	-- Warbringer Greathelm
				29016,	-- Warbringer Shoulderguards
				29012,	-- Warbringer Chestguard
				29017,	-- Warbringer Handguards
				29015,	-- Warbringer Legguards
			},
		},
	},

	["Tier3"] = {	-- T3 Sets
		name = format(AL["Tier %d Sets"], 3),
		sourceTemplate = {
			AL["Black Market Auction House"],	-- Head
			AL["Black Market Auction House"],	-- Shoulder
			AL["Black Market Auction House"],	-- Chest
			AL["Black Market Auction House"],	-- Wrist
			AL["Black Market Auction House"],	-- Hands
			AL["Black Market Auction House"],	-- Waist
			AL["Black Market Auction House"],	-- Legs
			AL["Black Market Auction House"],	-- Feet
			AL["No longer available"],	-- Finger
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22490,	-- Dreamwalker Headpiece
				22491,	-- Dreamwalker Spaulders
				22488,	-- Dreamwalker Tunic
				22495,	-- Dreamwalker Wristguards
				22493,	-- Dreamwalker Handguards
				22494,	-- Dreamwalker Girdle
				22489,	-- Dreamwalker Legguards
				22492,	-- Dreamwalker Boots
				23064,	-- Ring of the Dreamwalker
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22438,	-- Cryptstalker Headpiece
				22439,	-- Cryptstalker Spaulders
				22436,	-- Cryptstalker Tunic
				22443,	-- Cryptstalker Wristguards
				22441,	-- Cryptstalker Handguards
				22442,	-- Cryptstalker Girdle
				22437,	-- Cryptstalker Legguards
				22440,	-- Cryptstalker Boots
				23067,	-- Ring of the Cryptstalker
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22498,	-- Frostfire Circlet
				22499,	-- Frostfire Shoulderpads
				22496,	-- Frostfire Robe
				22503,	-- Frostfire Bindings
				22501,	-- Frostfire Gloves
				22502,	-- Frostfire Belt
				22497,	-- Frostfire Leggings
				22500,	-- Frostfire Sandals
				23062,	-- Frostfire Ring
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22428,	-- Redemption Headpiece
				22429,	-- Redemption Spaulders
				22425,	-- Redemption Tunic
				22424,	-- Redemption Wristguards
				22426,	-- Redemption Handguards
				22431,	-- Redemption Girdle
				22427,	-- Redemption Legguards
				22430,	-- Redemption Boots
				23066,	-- Ring of Redemption
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22514,	-- Circlet of Faith
				22515,	-- Shoulderpads of Faith
				22512,	-- Robe of Faith
				22519,	-- Bindings of Faith
				22517,	-- Gloves of Faith
				22518,	-- Belt of Faith
				22513,	-- Leggings of Faith
				22516,	-- Sandals of Faith
				23061,	-- Ring of Faith
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22478,	-- Bonescythe Helmet
				22479,	-- Bonescythe Pauldrons
				22476,	-- Bonescythe Breastplate
				22483,	-- Bonescythe Bracers
				22481,	-- Bonescythe Gauntlets
				22482,	-- Bonescythe Waistguard
				22477,	-- Bonescythe Legplates
				22480,	-- Bonescythe Sabatons
				23060,	-- Bonescythe Ring
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22466,	-- Earthshatter Headpiece
				22467,	-- Earthshatter Spaulders
				22464,	-- Earthshatter Tunic
				22471,	-- Earthshatter Wristguards
				22469,	-- Earthshatter Handguards
				22470,	-- Earthshatter Girdle
				22465,	-- Earthshatter Legguards
				22468,	-- Earthshatter Boots
				23065,	-- Ring of the Earthshatterer
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22506,	-- Plagueheart Circlet
				22507,	-- Plagueheart Shoulderpads
				22504,	-- Plagueheart Robe
				22511,	-- Plagueheart Bindings
				22509,	-- Plagueheart Gloves
				22510,	-- Plagueheart Belt
				22505,	-- Plagueheart Leggings
				22508,	-- Plagueheart Sandals
				23063,	-- Plagueheart Ring
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				22418,	-- Dreadnaught Helmet
				22419,	-- Dreadnaught Pauldrons
				22416,	-- Dreadnaught Breastplate
				22423,	-- Dreadnaught Bracers
				22421,	-- Dreadnaught Gauntlets
				22422,	-- Dreadnaught Waistguard
				22417,	-- Dreadnaught Legplates
				22420,	-- Dreadnaught Sabatons
				23059,	-- Ring of the Dreadnaught
			},
		},
	},

	["Tier2"] = {	-- T2 Sets
		name = format(AL["Tier %d Sets"], 2),
		sourceTemplate = {
			ALIL["Blackwing Lair"].." - "..BB["Nefarian"],	-- Head
			ALIL["Blackwing Lair"].." - "..BB["Chromaggus"],	-- Shoulder
			ALIL["Blackwing Lair"].." - "..BB["Nefarian"],	-- Chest
			ALIL["Blackwing Lair"].." - "..BB["Razorgore the Untamed"],	-- Wrist
			ALIL["Blackwing Lair"].." - "..BB["Firemaw"]..", "..BB["Ebonroc"]..", "..BB["Flamegor"],	-- Hands
			ALIL["Blackwing Lair"].." - "..BB["Vaelastrasz the Corrupt"],	-- Waist
			ALIL["Molten Core"].." - "..BB["Ragnaros"],	-- Legs
			ALIL["Blackwing Lair"].." - "..BB["Broodlord Lashlayer"],	-- Feet
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16900,	-- Stormrage Cover
				16902,	-- Stormrage Pauldrons
				16897,	-- Stormrage Chestguard
				16904,	-- Stormrage Bracers
				16899,	-- Stormrage Handguards
				16903,	-- Stormrage Belt
				16901,	-- Stormrage Legguards
				16898,	-- Stormrage Boots
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16939,	-- Dragonstalker's Helm
				16937,	-- Dragonstalker's Spaulders
				16942,	-- Dragonstalker's Breastplate
				16935,	-- Dragonstalker's Bracers
				16940,	-- Dragonstalker's Gauntlets
				16936,	-- Dragonstalker's Belt
				16938,	-- Dragonstalker's Legguards
				16941,	-- Dragonstalker's Greaves
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16914,	-- Netherwind Crown
				16917,	-- Netherwind Mantle
				16916,	-- Netherwind Robes
				16918,	-- Netherwind Bindings
				16913,	-- Netherwind Gloves
				16818,	-- Netherwind Belt
				16915,	-- Netherwind Pants
				16912,	-- Netherwind Boots
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16955,	-- Judgement Crown
				16953,	-- Judgement Spaulders
				16958,	-- Judgement Breastplate
				16951,	-- Judgement Bindings
				16956,	-- Judgement Gauntlets
				16952,	-- Judgement Belt
				16954,	-- Judgement Legplates
				16957,	-- Judgement Sabatons
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16921,	-- Halo of Transcendence
				16924,	-- Pauldrons of Transcendence
				16923,	-- Robes of Transcendence
				16926,	-- Bindings of Transcendence
				16920,	-- Handguards of Transcendence
				16925,	-- Belt of Transcendence
				16922,	-- Leggings of Transcendence
				16919,	-- Boots of Transcendence
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16908,	-- Bloodfang Hood
				16832,	-- Bloodfang Spaulders
				16905,	-- Bloodfang Chestpiece
				16911,	-- Bloodfang Bracers
				16907,	-- Bloodfang Gloves
				16910,	-- Bloodfang Belt
				16909,	-- Bloodfang Pants
				16906,	-- Bloodfang Boots
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16947,	-- Helmet of Ten Storms
				16945,	-- Epaulets of Ten Storms
				16950,	-- Breastplate of Ten Storms
				16943,	-- Bracers of Ten Storms
				16948,	-- Gauntlets of Ten Storms
				16944,	-- Belt of Ten Storms
				16946,	-- Legplates of Ten Storms
				16949,	-- Greaves of Ten Storms
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16929,	-- Nemesis Skullcap
				16932,	-- Nemesis Spaulders
				16931,	-- Nemesis Robes
				16934,	-- Nemesis Bracers
				16928,	-- Nemesis Gloves
				16933,	-- Nemesis Belt
				16930,	-- Nemesis Leggings
				16927,	-- Nemesis Boots
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16963,	-- Helm of Wrath
				16961,	-- Pauldrons of Wrath
				16966,	-- Breastplate of Wrath
				16959,	-- Bracelets of Wrath
				16964,	-- Gauntlets of Wrath
				16960,	-- Waistband of Wrath
				16962,	-- Legplates of Wrath
				16965,	-- Sabatons of Wrath
			},
		},
	},

	["Tier1"] = {	-- T1 Sets
		name = format(AL["Tier %d Sets"], 1),
		sourceTemplate = {
			ALIL["Molten Core"].." - "..BB["Garr"],	-- Head
			nil,	-- Shoulder
			ALIL["Molten Core"].." - "..BB["Golemagg the Incinerator"],	-- Chest
			ALIL["Molten Core"].." - "..AL["Trash Mobs"],	-- Wrist
			nil,	-- Hands
			ALIL["Molten Core"].." - "..AL["Trash Mobs"],	-- Waist
			ALIL["Molten Core"].." - "..BB["Magmadar"],	-- Legs
			nil,	-- Feet
		},
		{	-- Druid
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			subSetName = "druid",
			icon = "druid",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16834,	-- Cenarion Helm
				{ 16836, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Baron Geddon"] },	-- Cenarion Spaulders
				16833,	-- Cenarion Vestments
				16830,	-- Cenarion Bracers
				{ 16831, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Shazzrah"] },	-- Cenarion Gloves
				16828,	-- Cenarion Belt
				16835,	-- Cenarion Leggings
				{ 16829, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Lucifron"] },	-- Cenarion Boots
			},
		},
		{	-- Hunter
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			subSetName = "hunter",
			icon = "hunter",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16846,	-- Giantstalker's Helmet
				{ 16848, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Sulfuron Harbinger"] },	-- Giantstalker's Epaulets
				16845,	-- Giantstalker's Breastplate
				16850,	-- Giantstalker's Bracers
				{ 16852, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Shazzrah"] },	-- Giantstalker's Gloves
				16851,	-- Giantstalker's Belt
				16847,	-- Giantstalker's Leggings
				{ 16849, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Gehennas"] },	-- Giantstalker's Boots
			},
		},
		{	-- Mage
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			subSetName = "mage",
			icon = "mage",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16795,	-- Arcanist Crown
				{ 16797, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Baron Geddon"] },	-- Arcanist Mantle
				16798,	-- Arcanist Robes
				16799,	-- Arcanist Bindings
				{ 16801, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Shazzrah"] },	-- Arcanist Gloves
				16802,	-- Arcanist Belt
				16796,	-- Arcanist Leggings
				{ 16800, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Lucifron"] },	-- Arcanist Boots
			},
		},
		{	-- Paladin
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			subSetName = "paladin",
			icon = "pala",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16854,	-- Lawbringer Helm
				{ 16856, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Baron Geddon"] },	-- Lawbringer Spaulders
				16853,	-- Lawbringer Chestguard
				16857,	-- Lawbringer Bracers
				{ 16860, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Gehennas"] },	-- Lawbringer Gauntlets
				16858,	-- Lawbringer Belt
				16855,	-- Lawbringer Legplates
				{ 16859, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Lucifron"] },	-- Lawbringer Boots
			},
		},
		{	-- Priest
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			subSetName = "priest",
			icon = "priest",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16813,	-- Circlet of Prophecy
				{ 16816, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Sulfuron Harbinger"] },	-- Mantle of Prophecy
				16815,	-- Robes of Prophecy
				16819,	-- Vambraces of Prophecy
				{ 16812, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Gehennas"] },	-- Gloves of Prophecy
				16817,	-- Girdle of Prophecy
				16814,	-- Pants of Prophecy
				{ 16811, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Shazzrah"] },	-- Boots of Prophecy
			},
		},
		{	-- Rogue
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			subSetName = "rogue",
			icon = "rogue",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16821,	-- Nightslayer Cover
				{ 16823, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Sulfuron Harbinger"] },	-- Nightslayer Shoulder Pads
				16820,	-- Nightslayer Chestpiece
				16825,	-- Nightslayer Bracelets
				{ 16826, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Gehennas"] },	-- Nightslayer Gloves
				16827,	-- Nightslayer Belt
				16822,	-- Nightslayer Pants
				{ 16824, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Shazzrah"] },	-- Nightslayer Boots
			},
		},
		{	-- Shaman
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			subSetName = "shaman",
			icon = "shaman",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16842,	-- Earthfury Helmet
				{ 16844, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Baron Geddon"] },	-- Earthfury Epaulets
				16841,	-- Earthfury Vestments
				16840,	-- Earthfury Bracers
				{ 16839, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Gehennas"] },	-- Earthfury Gauntlets
				16838,	-- Earthfury Belt
				16843,	-- Earthfury Legguards
				{ 16837, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Lucifron"] },	-- Earthfury Boots
			},
		},
		{	-- Warlock
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			subSetName = "warlock",
			icon = "warlock",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16808,	-- Felheart Horns
				{ 16807, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Baron Geddon"] },	-- Felheart Shoulder Pads
				16809,	-- Felheart Robes
				16804,	-- Felheart Bracers
				{ 16805, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Lucifron"] },	-- Felheart Gloves
				16806,	-- Felheart Belt
				16810,	-- Felheart Pants
				{ 16803, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Shazzrah"] },	-- Felheart Slippers
			},
		},
		{	-- Warrior
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			subSetName = "warrior",
			icon = "warri",
			[SOURCE_INFO] = "sourceTemplate",
			[NORMAL_DIFF] = {
				16866,	-- Helm of Might
				{ 16868, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Sulfuron Harbinger"] },	-- Pauldrons of Might
				16865,	-- Breastplate of Might
				16861,	-- Bracers of Might
				{ 16863, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Lucifron"] },	-- Gauntlets of Might
				16864,	-- Belt of Might
				16867,	-- Legplates of Might
				{ 16862, [SOURCE_INFO] = ALIL["Molten Core"].." - "..BB["Gehennas"] },	-- Sabatons of Might
			},
		},
	},
}

Set:SetContentTable(SetTable)