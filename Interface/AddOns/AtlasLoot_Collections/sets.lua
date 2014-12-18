local addonname = ...
local AtlasLoot = _G.AtlasLoot
local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local Set = AtlasLoot.Data.Sets:RegisterNewSets(addonname)

local BIS = AtlasLoot.LibBabble:Get("LibBabble-ItemSet-3.0")

local RF_DIFF = Set:AddDifficulty(AL["Raid Finder"], "rf")
local NORMAL_DIFF = Set:AddDifficulty(AL["Normal"], "n")
local HEROIC_DIFF = Set:AddDifficulty(AL["Heroic"], "h")
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
				115536,	--{ 115536, [LOCATION_INFO] = "Ini for dis!!!!!" }, -- Ogreskull Boneplate Pauldrons
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
}

Set:SetContentTable(SetTable)