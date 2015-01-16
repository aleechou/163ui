local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 2)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local BB = AtlasLoot.LibBabble:Get("LibBabble-Boss-3.0")

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", nil, 1)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", nil, 2)
local P25_DIFF = data:AddDifficulty(AL["25 Player"], "p25", nil, 4)

local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)

-- Shared loot tables
local BC_DUNGEONMASTER_AC_TABLE = {	--[Outland Dungeonmaster]
	name = select(2, GetAchievementInfo(1284)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1284 },
		{ 2, 647 },			{ 17, 648 },
		{ 3, 649 },			{ 18, 650 },
		{ 4, 651 },			{ 19, 652 },
		{ 5, 653 },			{ 20, 654 },
		{ 6, 655 },			{ 21, 656 },
		{ 7, 657 },			{ 22, 658 },
		{ 8, 659 },			{ 23, 660 },
		{ 9, 661 },			{ 24, 666 },
	},
}

local BC_DUNGEON_HERO_AC_TABLE = {	--[Outland Dungeon Hero]
	name = select(2, GetAchievementInfo(1287)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[HEROIC_DIFF] = {
		{ 1, 1287 },
		{ 2, 667 },			{ 17, 668 },
		{ 3, 669 },			{ 18, 670 },
		{ 4, 671 },			{ 19, 673 },
		{ 5, 674 },			{ 20, 675 },
		{ 6, 676 },			{ 21, 677 },
		{ 7, 678 },			{ 22, 679 },
		{ 8, 680 },			{ 23, 681 },
		{ 9, 682 },			{ 24, 672 },
	},
}

local BC_RAID_AC_TABLE = {	--[Outland Raider]
	name = select(2, GetAchievementInfo(1286)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1286 },
		{ 2, 690 },			{ 17, 692 },
		{ 3, 693 },			{ 18, 694 },
		{ 4, 695 },			{ 19, 696 },
		{ 5, 697 },			{ 20, 698 },
	},
}

data["AuchAuchenaiCrypts"] = {
	EncounterJournalID = 247,
	MapID = 722,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--AuchCryptsShirrak
			EncounterJournalID = 523,
			[NORMAL_DIFF] = {
				{ 1, 27410 },	-- Collar of Command
				{ 2, 27409 },	-- Raven-Heart Headdress
				{ 3, 27408 },	-- Hope Bearer Helm
				{ 4, 26055 },	-- Oculus of the Hidden Eye
				{ 5, 25964 },	-- Shaarde the Lesser
			},
			[HEROIC_DIFF] = {
				{ 1, 27866 },	-- Scintillating Headdress of Second Sight
				{ 2, 27493 },	-- Gloves of the Deadwatcher
				{ 3, 27865 },	-- Bracers of Shirrak
				{ 4, 27845 },	-- Magma Plume Boots
				{ 5, 27847 },	-- Fanblade Pauldrons
				{ 6, 27846 },	-- Claw of the Watcher
				{ 16, 30587, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Champion's Fire Opal
				{ 17, 30588, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Potent Fire Opal
				{ 18, 30586, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
			},
		},
		{	--AuchCryptsExarch
			EncounterJournalID = 524,
			[NORMAL_DIFF] = {
				{ 1, 27411 },	-- Slippers of Serenity
				{ 2, 27415 },	-- Darkguard Face Mask
				{ 3, 27414 },	-- Mok'Nathal Beast-Mask
				{ 4, 27413 },	-- Ring of the Exarchs
				{ 5, 27416 },	-- Fetish of the Fallen
				{ 6, 27412 },	-- Ironstaff of Regeneration
				{ 16, "ac666" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29354 },	-- Light-Touched Stole of Altruism
				{ 2, 29257 },	-- Sash of Arcane Visions
				{ 3, 29244 },	-- Wave-Song Girdle
				{ 5, 27867 },	-- Boots of the Unjust
				{ 6, 27871 },	-- Maladaar's Blessed Chaplet
				{ 7, 27869 },	-- Soulpriest's Ring of Resolve
				{ 8, 27523 },	-- Exarch's Diamond Band
				{ 9, 27872 },	-- The Harvester of Souls
				{ 11, 33836, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Exarch's Soul Gem
				{ 13, 27870 },	-- Doomplate Legguards
				{ 16, 30587, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Champion's Fire Opal
				{ 17, 30588, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Potent Fire Opal
				{ 18, 30586, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 20, "ac672" },
			},
		},
		{	--AuchCryptsAvatar
			name = AL["Avatar of the Martyred"],
			[HEROIC_DIFF] = {
				{ 1, 27878 },	-- Auchenai Death Shroud
				{ 2, 28268 },	-- Natural Mender's Wraps
				{ 3, 27876 },	-- Will of the Fallen Exarch
				{ 4, 27937 },	-- Sky Breaker
				{ 5, 27877 },	-- Draenic Wildstaff
				{ 7, 27797 },	-- Wastewalker Shoulderpads
			},
		},
		{	--AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23605 },	-- Plans: Felsteel Gloves
				{ 2, 22544 },	-- Formula: Enchant Boots - Dexterity
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--LowerCity
			FactionID = 1011,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:7",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["HCHellfireRamparts"] = {
	EncounterJournalID = 248,
	MapID = 797,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--HCRampWatchkeeper
			EncounterJournalID = 527,
			[NORMAL_DIFF] = {
				{ 1, 24024 },	-- Pauldrons of Arcane Rage
				{ 2, 24023 },	-- Bracers of Finesse
				{ 3, 24022 },	-- Scale Leggings of the Skirmisher
				{ 4, 24021 },	-- Light-Touched Breastplate
				{ 5, 24020 },	-- Shadowrend Longblade
				{ 7, 23881, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Gargolmar's Hand
			},
			[HEROIC_DIFF] = {
				{ 1, 27448 },	-- Cloak of the Everliving
				{ 2, 27451 },	-- Boots of the Darkwalker
				{ 3, 27450 },	-- Wild Stalker Boots
				{ 4, 27447 },	-- Bracers of Just Rewards
				{ 5, 27449 },	-- Blood Knight Defender
				{ 7, 23881, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Gargolmar's Hand
				{ 16, 30593, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Potent Fire Opal
				{ 17, 30594, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
				{ 18, 30592, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Steady Chrysoprase
			},
		},
		{	--HCRampOmor
			EncounterJournalID = 528,
			[NORMAL_DIFF] = {
				{ 1, 24090 },	-- Bloodstained Ravager Gauntlets
				{ 2, 24091 },	-- Tenacious Defender
				{ 3, 24073 },	-- Garrote-String Necklace
				{ 4, 24096 },	-- Heartblood Prayer Beads
				{ 5, 24094 },	-- Heart Fire Warhammer
				{ 6, 24069 },	-- Crystalfire Staff
				{ 8, 23886, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Omor's Hoof
				{ 16, "ac647" },
			},
			[HEROIC_DIFF] = {
				{ 1, 27466 },	-- Headdress of Alacrity
				{ 2, 27462 },	-- Crimson Bracers of Gloom
				{ 3, 27467 },	-- Silent-Strider Kneeboots
				{ 4, 27478 },	-- Girdle of the Blasted Reaches
				{ 5, 27539 },	-- Justice Bearer's Pauldrons
				{ 6, 27906 },	-- Crimsonforge Breastplate
				{ 8, 27464 },	-- Omor's Unyielding Will
				{ 9, 27895 },	-- Band of Many Prisms
				{ 11, 27463 },	-- Terror Flame Dagger
				{ 12, 27476 },	-- Truncheon of Five Hells
				{ 13, 27477 },	-- Faol's Signet of Cleansing
				{ 15, 27465 },	-- Mana-Etched Gloves
				{ 16, 30593, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Potent Fire Opal
				{ 17, 30594, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
				{ 18, 30592, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Steady Chrysoprase
				{ 20, "ac667" },
			},
		},
		{	--HCRampVazruden
			EncounterJournalID = 529,
			[NORMAL_DIFF] = {
				{ 1, 24150 },	-- Mok'Nathal Wildercloak
				{ 2, 24083 },	-- Lifegiver Britches
				{ 3, 24063 },	-- Shifting Sash of Midnight
				{ 4, 24046 },	-- Kilt of Rolling Thunders
				{ 5, 24064 },	-- Ironsole Clompers
				{ 6, 24045 },	-- Band of Renewal
				{ 7, 24154 },	-- Witching Band
				{ 8, 24151 },	-- Mok'Nathal Clan Ring
				{ 9, 24044 },	-- Hellreaver
				{ 10, 24155 },	-- Ursol's Claw
				{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(529), nil },	--Vazruden the Herald
				{ 17, 23892, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ominous Letter
				{ 19, "INV_Box_01", nil, BB["Nazan"], nil },
				{ 20, 23901, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nazan's Head
			},
			[HEROIC_DIFF] = {
				{ 1, 29264 },	-- Tree-Mender's Belt
				{ 2, 32077 },	-- Wrath Infused Gauntlets
				{ 3, 29238 },	-- Lion's Heart Girdle
				{ 4, 29346 },	-- Feltooth Eviscerator
				{ 6, 27452 },	-- Light Scribe Bands
				{ 7, 27461 },	-- Chestguard of the Prowler
				{ 8, 27456 },	-- Raiments of Nature's Breath
				{ 9, 27454 },	-- Volcanic Pauldrons
				{ 10, 27458 },	-- Oceansong Kilt
				{ 11, 27455 },	-- Irondrake Faceguard
				{ 12, 27459 },	-- Vambraces of Daring
				{ 13, 27457 },	-- Life Bearer's Gauntlets
				{ 16, 30593, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Potent Fire Opal
				{ 17, 30594, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
				{ 18, 30592, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Steady Chrysoprase
				{ 20, 27453 },	-- Averinn's Ring of Slaying
				{ 21, 27460 },	-- Reavers' Ring
				{ 23, "INV_Box_01", nil, EJ_GetEncounterInfo(529), nil },	--Vazruden the Herald
				{ 24, 23892, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ominous Letter
				{ 26, "INV_Box_01", nil, BB["Nazan"], nil },
				{ 27, 23901, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nazan's Head
				{ 29, "ac667" },
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--HonorHold
			FactionID = 946,
			ExtraList = true,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:4",
		},
		{	--Thrallmar
			FactionID = 947,
			ExtraList = true,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:21",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["MagistersTerrace"] = {
	EncounterJournalID = 249,
	MapID = 798,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--SMTFireheart
			EncounterJournalID = 530,
			[NORMAL_DIFF] = {
				{ 1, 34702 },	-- Cloak of Swift Mending
				{ 2, 34697 },	-- Bindings of Raging Fire
				{ 3, 34701 },	-- Leggings of the Betrayed
				{ 4, 34698 },	-- Bracers of the Forest Stalker
				{ 5, 34700 },	-- Gauntlets of Divine Blessings
				{ 6, 34699 },	-- Sun-Forged Cleaver
			},
			[HEROIC_DIFF] = {
				{ 1, 34602 },	-- Eversong Cuffs
				{ 2, 34601 },	-- Shoulderplates of Everlasting Pain
				{ 3, 34604 },	-- Jaded Crystal Dagger
				{ 5, 35275, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Orb of the Sin'dorei
			},
		},
		{	--SMTVexallus
			EncounterJournalID = 531,
			[NORMAL_DIFF] = {
				{ 1, 34708 },	-- Cloak of the Coming Night
				{ 2, 34705 },	-- Bracers of Divine Infusion
				{ 3, 34707 },	-- Boots of Resuscitation
				{ 4, 34704 },	-- Band of Arcane Alacrity
				{ 5, 34706 },	-- Band of Determination
				{ 6, 34703 },	-- Latro's Dancing Blade
				{ 8, 73084, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Volatile Essence
			},
			[HEROIC_DIFF] = {
				{ 1, 34607 },	-- Fel-Tinged Mantle
				{ 2, 34605 },	-- Breastplate of Fierce Survival
				{ 3, 34606 },	-- Edge of Oppression
				{ 4, 34608 },	-- Rod of the Blazing Light
				{ 6, 35275, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Orb of the Sin'dorei
				{ 8, 73084, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Volatile Essence
			},
		},
		{	--SMTDelrissa
			EncounterJournalID = 532,
			[NORMAL_DIFF] = {
				{ 1, 34792 },	-- Cloak of the Betrayed
				{ 2, 34788 },	-- Duskhallow Mantle
				{ 3, 34791 },	-- Gauntlets of the Tranquil Waves
				{ 4, 34789 },	-- Bracers of Slaughter
				{ 5, 34790 },	-- Battle-Mace of the High Priestess
				{ 7, 35756, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Cloak - Greater Dodge
			},
			[HEROIC_DIFF] = {
				{ 1, 34473 },	-- Commendation of Kael'thas
				{ 2, 34472 },	-- Shard of Contempt
				{ 3, 34470 },	-- Timbal's Focusing Crystal
				{ 4, 34471 },	-- Vial of the Sunwell
				{ 6, 35275, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Orb of the Sin'dorei
				{ 8, 35756, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Cloak - Greater Dodge
			},
		},
		{	--SMTKaelthas
			EncounterJournalID = 533,
			[NORMAL_DIFF] = {
				{ 1, 34810 },	-- Cloak of Blade Turning
				{ 2, 34808 },	-- Gloves of Arcane Acuity
				{ 3, 34809 },	-- Sunrage Treads
				{ 4, 34799 },	-- Hauberk of the War Bringer
				{ 5, 34807 },	-- Sunstrider Warboots
				{ 6, 34625 },	-- Kharmaa's Ring of Fate
				{ 8, 34157, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Head of Kael'thas
				{ 16, 34793 },	-- Cord of Reconstruction
				{ 17, 34796 },	-- Robes of Summer Flame
				{ 18, 34795 },	-- Helm of Sanctification
				{ 19, 34798 },	-- Band of Celerity
				{ 20, 34794 },	-- Axe of Shattered Dreams
				{ 21, 34797 },	-- Sun-Infused Focus Staff
				{ 23, 35504, "pet175", [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Phoenix Hatchling
				{ 25, "ac661" },
			},
			[HEROIC_DIFF] = {
				{ 1, 34610 },	-- Scarlet Sin'dorei Robes
				{ 2, 34613 },	-- Shoulderpads of the Silvermoon Retainer
				{ 3, 34614 },	-- Tunic of the Ranger Lord
				{ 4, 34615 },	-- Netherforce Chestplate
				{ 5, 34612 },	-- Greaves of the Penitent Knight
				{ 7, 35275 },	-- Orb of the Sin'dorei
				{ 9, 34157, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Head of Kael'thas
				{ 10, 34160, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Signet Ring of Prince Kael'thas
				{ 16, 34609 },	-- Quickening Blade of the Prince
				{ 17, 34616 },	-- Breeching Comet
				{ 18, 34611 },	-- Cudgel of Consecration
				{ 20, 35513, "mount" },	-- Swift White Hawkstrider
				{ 22, 35504, "pet175" },	-- Phoenix Hatchling
				{ 24, "ac682" },
			},
		},
		{	--SMTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 35516 },	-- Sun Touched Satchel
			},
		},
		{	--SunOffensive
			FactionID = 1077,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:11",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["AuchManaTombs"] = {
	EncounterJournalID = 250,
	MapID = 732,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--AuchManaPandemonius
			EncounterJournalID = 534,
			[NORMAL_DIFF] = {
				{ 1, 25941 },	-- Boots of the Outlander
				{ 2, 25942 },	-- Faith Bearer's Gauntlets
				{ 3, 25943 },	-- Creepjacker
				{ 4, 28166 },	-- Shield of the Void
				{ 5, 25939 },	-- Voidfire Wand
				{ 7, 72126, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pandemonius' Essence
			},
			[HEROIC_DIFF] = {
				{ 1, 27816 },	-- Mindrage Pauldrons
				{ 2, 27818 },	-- Starry Robes of the Crescent
				{ 3, 27813 },	-- Boots of the Colossus
				{ 4, 27814 },	-- Twinblade of Mastery
				{ 5, 27817 },	-- Starbolt Longbow
				{ 7, 72126, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pandemonius' Essence
				{ 16, 30584, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Inscribed Fire Opal
				{ 17, 30585, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Polished Fire Opal
				{ 18, 30583, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
			},
		},
		{	--AuchManaTavarok
			EncounterJournalID = 535,
			[NORMAL_DIFF] = {
				{ 1, 25945 },	-- Cloak of Revival
				{ 2, 25946 },	-- Nethershade Boots
				{ 3, 25947 },	-- Lightning-Rod Pauldrons
				{ 4, 25952 },	-- Scimitar of the Nexus-Stalkers
				{ 5, 25944 },	-- Shaarde the Greater
				{ 6, 25950 },	-- Staff of Polarities
				{ 8, 72127, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tavarok's Heart
			},
			[HEROIC_DIFF] = {
				{ 1, 27824 },	-- Robe of the Great Dark Beyond
				{ 2, 27821 },	-- Extravagant Boots of Malice
				{ 3, 27825 },	-- Predatory Gloves
				{ 4, 27826 },	-- Mantle of the Sea Wolf
				{ 5, 27823 },	-- Shard Encrusted Breastplate
				{ 6, 27822 },	-- Crystal Band of Valor
				{ 8, 72127, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tavarok's Heart
				{ 16, 30584, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Inscribed Fire Opal
				{ 17, 30585, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Polished Fire Opal
				{ 18, 30583, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
			},
		},
		{	--AuchManaYor
			EncounterJournalID = 536,
			[HEROIC_DIFF] = {
				{ 1, 31919 },	-- Nexus-Prince's Ring of Balance
				{ 2, 31920 },	-- Shaffar's Band of Brutality
				{ 3, 31921 },	-- Yor's Collapsing Band
				{ 4, 31922 },	-- Ring of Conflict Survival
				{ 5, 31923 },	-- Band of the Crystalline Void
				{ 6, 31924 },	-- Yor's Revenge
				{ 8, 31554 },	-- Windchanneller's Tunic
				{ 9, 31562 },	-- Skystalker's Tunic
				{ 10, 31570 },	-- Mistshroud Tunic
				{ 11, 31578 },	-- Slatesteel Breastplate
				{ 16, 30584, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Inscribed Fire Opal
				{ 17, 30585, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Polished Fire Opal
				{ 18, 30583, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
			},
		},
		{	--AuchManaNexusPrince
			EncounterJournalID = 537,
			[NORMAL_DIFF] = {
				{ 1, 25957 },	-- Ethereal Boots of the Skystrider
				{ 2, 25955 },	-- Mask of the Howling Storm
				{ 3, 25956 },	-- Nexus-Bracers of Vigor
				{ 4, 25954 },	-- Sigil of Shaffar
				{ 5, 25962 },	-- Longstrider's Loop
				{ 6, 25953 },	-- Ethereal Warp-Bow
				{ 8, 22921, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Major Frost Protection Potion
				{ 10, 28490, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shaffar's Wrappings
				{ 16, "ac651" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29240 },	-- Bands of Negation
				{ 2, 30535 },	-- Forestwalker Kilt
				{ 3, 29352 },	-- Cobalt Band of Tyrigosa
				{ 4, 32082 },	-- The Fel Barrier
				{ 6, 27831 },	-- Mantle of the Unforgiven
				{ 7, 27843 },	-- Glyph-Lined Sash
				{ 8, 27827 },	-- Lucid Dream Bracers
				{ 9, 27835 },	-- Stillwater Girdle
				{ 10, 27844 },	-- Pauldrons of Swift Retribution
				{ 11, 27798 },	-- Gauntlets of Vindication
				{ 13, 33835, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shaffar's Wondrous Amulet
				{ 14, 28490, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shaffar's Wrappings
				{ 16, 30584, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Inscribed Fire Opal
				{ 17, 30585, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Polished Fire Opal
				{ 18, 30583, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
				{ 20, 27837 },	-- Wastewalker Leggings
				{ 22, 27828 },	-- Warp-Scarab Brooch
				{ 23, 28400 },	-- Warp-Storm Warblade
				{ 24, 27829 },	-- Axe of the Nexus-Kings
				{ 25, 27840 },	-- Scepter of Sha'tar
				{ 26, 27842 },	-- Grand Scepter of the Nexus-Kings
				{ 28, 22921, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Major Frost Protection Potion
				{ 30, "ac671" },
			},
		},
		{	--AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23615 },	-- Plans: Swiftsteel Gloves
				{ 2, 22543 },	-- Formula: Enchant Boots - Fortitude
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--Consortium
			FactionID = 933,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:15",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CoTOldHillsbrad"] = {
	EncounterJournalID = 251,
	MapID = 734,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--CoTHillsbradDrake
			EncounterJournalID = 538,
			[NORMAL_DIFF] = {
				{ 1, 27423 },	-- Cloak of Impulsiveness
				{ 2, 27418 },	-- Stormreaver Shadow-Kilt
				{ 3, 27417 },	-- Ravenwing Pauldrons
				{ 4, 27420 },	-- Uther's Ceremonial Warboots
				{ 5, 27436 },	-- Iron Band of the Unbreakable
			},
			[HEROIC_DIFF] = {
				{ 1, 28212 },	-- Aran's Sorcerous Slacks
				{ 2, 28214 },	-- Grips of the Lunar Eclipse
				{ 3, 28215 },	-- Mok'Nathal Mask of Battle
				{ 4, 28211 },	-- Lieutenant's Signet of Lordaeron
				{ 5, 28213 },	-- Lordaeron Medical Guide
				{ 6, 28210 },	-- Bloodskull Destroyer
				{ 16, 30589, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 17, 30591, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lucent Fire Opal
				{ 18, 30590, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
			},
		},
		{	--CoTHillsbradSkarloc
			EncounterJournalID = 539,
			[NORMAL_DIFF] = {
				{ 1, 27428 },	-- Stormfront Gauntlets
				{ 2, 27430 },	-- Scaled Greaves of Patience
				{ 3, 27427 },	-- Durotan's Battle Harness
				{ 4, 27424 },	-- Amani Venom-Axe
				{ 5, 27426 },	-- Northshire Battlemace
				{ 7, 22927, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Ironshield Potion
			},
			[HEROIC_DIFF] = {
				{ 1, 28218 },	-- Pontiff's Pantaloons of Prophecy
				{ 2, 28220 },	-- Moon-Crown Antlers
				{ 3, 28219 },	-- Emerald-Scale Greaves
				{ 4, 28221 },	-- Boots of the Watchful Heart
				{ 5, 28217 },	-- Tarren Mill Vitality Locket
				{ 6, 28216 },	-- Dathrohan's Ceremonial Hammer
				{ 8, 22927, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Ironshield Potion
				{ 16, 30589, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 17, 30591, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lucent Fire Opal
				{ 18, 30590, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
			},
		},
		{	--CoTHillsbradHunter
			EncounterJournalID = 540,
			[NORMAL_DIFF] = {
				{ 1, 27433 },	-- Pauldrons of Sufferance
				{ 2, 27434 },	-- Mantle of Perenolde
				{ 3, 27440 },	-- Diamond Prism of Recurrence
				{ 4, 27432 },	-- Broxigar's Ring of Valor
				{ 5, 27431 },	-- Time-Shifted Dagger
				{ 16, 24173, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Circlet of Arcane Might
				{ 18, "ac652" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29250 },	-- Cord of Sanctification
				{ 2, 29246 },	-- Nightfall Wristguards
				{ 3, 30534 },	-- Wyrmscale Greaves
				{ 4, 30536 },	-- Greaves of the Martyr
				{ 6, 27911 },	-- Epoch's Whispering Cinch
				{ 7, 28344 },	-- Wyrmfury Pauldrons
				{ 8, 28233 },	-- Necklace of Resplendent Hope
				{ 9, 27904 },	-- Resounding Ring of Glory
				{ 10, 28227 },	-- Sparking Arcanite Ring
				{ 11, 28223 },	-- Arcanist's Stone
				{ 12, 28226 },	-- Timeslicer
				{ 13, 28222 },	-- Reaver of the Infinites
				{ 16, 30589, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 17, 30591, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lucent Fire Opal
				{ 18, 30590, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
				{ 20, 24173, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Circlet of Arcane Might
				{ 22, 28191 },	-- Mana-Etched Vestments
				{ 23, 28224 },	-- Wastewalker Helm
				{ 24, 28401 },	-- Hauberk of Desolation
				{ 25, 28225 },	-- Doomplate Warhelm
				{ 27, 33847, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Epoch Hunter's Head
				{ 29, "ac673" },
			},
		},
		{	--CoTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 25729 },	-- Pattern: Stylin' Adventure Hat
				{ 3, "INV_Box_01", nil, AL["Don Carlos"], nil },
				{ 4, 38506 },	-- Don Carlos' Famous Hat
				{ 5, 38329 },	-- Don Carlos' Hat
				{ 6, 38276 },	-- Haliscan Brimmed Hat
				{ 16, "INV_Box_01", nil, AL["Thomas Yance"], nil },
				{ 17, 25725 },	-- Pattern: Riding Crop
				{ 19, "INV_Box_01", nil, AL["Aged Dalaran Wizard"], nil },
				{ 20, 22539 },	-- Formula: Enchant Shield - Intellect
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--KeepersofTime
			FactionID = 989,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:5",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["AuchSethekkHalls"] = {
	EncounterJournalID = 252,
	MapID = 723,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--AuchSethekkDarkweaver
			EncounterJournalID = 541,
			[NORMAL_DIFF] = {
				{ 1, 27919 },	-- Light-Woven Slippers
				{ 2, 27914 },	-- Moonstrider Boots
				{ 3, 27915 },	-- Sky-Hunter Swift Boots
				{ 4, 27918 },	-- Bands of Syth
				{ 6, 24160, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Khorium Inferno Band
				{ 8, 27633, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Terokk's Mask
			},
			[HEROIC_DIFF] = {
				{ 1, 27919 },	-- Light-Woven Slippers
				{ 2, 27914 },	-- Moonstrider Boots
				{ 3, 27915 },	-- Sky-Hunter Swift Boots
				{ 4, 27918 },	-- Bands of Syth
				{ 6, 24160, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Khorium Inferno Band
				{ 8, 27633, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Terokk's Mask
				{ 16, 30553, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Glinting Tanzanite
				{ 17, 30554, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stalwart Fire Opal
				{ 18, 30552, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
				{ 20, 25461, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Book of Forgotten Names
			},
		},
		{	--AuchSethekkRavenGod
			EncounterJournalID = 542,
			[HEROIC_DIFF] = {
				{ 1, 32769 },	-- Belt of the Raven Lord
				{ 2, 32778 },	-- Boots of Righteous Fortitude
				{ 3, 32779 },	-- Band of Frigid Elements
				{ 4, 32781 },	-- Talon of Anzu
				{ 5, 32780 },	-- The Boomstick
				{ 16, 30553, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pristine Fire Opal
				{ 17, 30554, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stalwart Fire Opal
				{ 18, 30552, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Blessed Tanzanite
				{ 20, 32768, "mount" },	-- Reins of the Raven Lord
			},
		},
		{	--AuchSethekkTalonKing
			EncounterJournalID = 543,
			[NORMAL_DIFF] = {
				{ 1, 27948 },	-- Trousers of Oblivion
				{ 2, 27838 },	-- Incanter's Trousers
				{ 3, 27875 },	-- Hallowed Trousers
				{ 4, 27776 },	-- Shoulderpads of Assassination
				{ 5, 27936 },	-- Greaves of Desolation
				{ 7, 27946 },	-- Avian Cloak of Feathers
				{ 8, 27981 },	-- Sethekk Oracle Cloak
				{ 9, 27985 },	-- Deathforge Girdle
				{ 10, 27925 },	-- Ravenclaw Band
				{ 11, 27980 },	-- Terokk's Nightmace
				{ 12, 27986 },	-- Crow Wing Reaper
				{ 14, 27632, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Terokk's Quill
				{ 16, "ac653" },
			},
			[HEROIC_DIFF] = {
				{ 1, 27948 },	-- Trousers of Oblivion
				{ 2, 27838 },	-- Incanter's Trousers
				{ 3, 27875 },	-- Hallowed Trousers
				{ 4, 27776 },	-- Shoulderpads of Assassination
				{ 5, 27936 },	-- Greaves of Desolation
				{ 7, 27946 },	-- Avian Cloak of Feathers
				{ 8, 27981 },	-- Sethekk Oracle Cloak
				{ 9, 27985 },	-- Deathforge Girdle
				{ 10, 27925 },	-- Ravenclaw Band
				{ 11, 27980 },	-- Terokk's Nightmace
				{ 12, 27986 },	-- Crow Wing Reaper
				{ 14, 27632, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Terokk's Quill
				{ 16, 30553, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Glinting Tanzanite
				{ 17, 30554, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stalwart Fire Opal
				{ 18, 30552, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
				{ 20, 29249 },	-- Bands of the Benevolent
				{ 21, 29259 },	-- Bracers of the Hunt
				{ 22, 32073 },	-- Spaulders of Dementia
				{ 23, 29355 },	-- Terokk's Shadowstaff
				{ 25, 33834, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Headfeathers of Ikiss
				{ 27, "ac674" },
			},
		},
		{	--AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 25731 },	-- Pattern: Stylin' Crimson Hat
				{ 3, 27634 },	-- The Saga of Terokk
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--LowerCity
			FactionID = 1011,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:7",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["AuchShadowLabyrinth"] = {
	EncounterJournalID = 253,
	MapID = 724,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--AuchShadowHellmaw
			EncounterJournalID = 544,
			[NORMAL_DIFF] = {
				{ 1, 27889 },	-- Jaedenfire Gloves of Annihilation
				{ 2, 27888 },	-- Dream-Wing Helm
				{ 3, 27884 },	-- Ornate Boots of the Sanctified
				{ 4, 27887 },	-- Platinum Shield of the Valorous
				{ 5, 27885 },	-- Soul-Wand of the Aldor
			},
			[HEROIC_DIFF] = {
				{ 1, 27889 },	-- Jaedenfire Gloves of Annihilation
				{ 2, 27888 },	-- Dream-Wing Helm
				{ 3, 27884 },	-- Ornate Boots of the Sanctified
				{ 4, 27887 },	-- Platinum Shield of the Valorous
				{ 5, 27885 },	-- Soul-Wand of the Aldor
				{ 16, 30563, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chrysoprase
				{ 17, 30559, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Etched Tanzanite
				{ 18, 30560, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
			},
		},
		{	--AuchShadowBlackheart
			EncounterJournalID = 545,
			[NORMAL_DIFF] = {
				{ 1, 27468 },	-- Moonglade Handwraps
				{ 3, 27892 },	-- Cloak of the Inciter
				{ 4, 27893 },	-- Ornate Leggings of the Venerated
				{ 5, 28134 },	-- Brooch of Heightened Potential
				{ 6, 27891 },	-- Adamantine Figurine
				{ 7, 27890 },	-- Wand of the Netherwing
				{ 9, 25728 },	-- Pattern: Stylin' Purple Hat
				{ 11, 30808, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Book of Fel Names
			},
			[HEROIC_DIFF] = {
				{ 1, 27468 },	-- Moonglade Handwraps
				{ 3, 27892 },	-- Cloak of the Inciter
				{ 4, 27893 },	-- Ornate Leggings of the Venerated
				{ 5, 28134 },	-- Brooch of Heightened Potential
				{ 6, 27891 },	-- Adamantine Figurine
				{ 7, 27890 },	-- Wand of the Netherwing
				{ 9, 25728 },	-- Pattern: Stylin' Purple Hat
				{ 11, 30808, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Book of Fel Names
				{ 16, 30563, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chyroprase
				{ 17, 30559, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Etched Tanzanite
				{ 18, 30560, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
			},
		},
		{	--AuchShadowGrandmaster
			EncounterJournalID = 546,
			[NORMAL_DIFF] = {
				{ 1, 27775 },	-- Hallowed Pauldrons
				{ 3, 27897 },	-- Breastplate of Many Graces
				{ 4, 27900 },	-- Jewel of Charismatic Mystique
				{ 5, 27901 },	-- Blackout Truncheon
				{ 6, 27898 },	-- Wrathfire Hand-Cannon
				{ 8, 30827, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lexicon Demonica
			},
			[HEROIC_DIFF] = {
				{ 1, 27775 },	-- Hallowed Pauldrons
				{ 3, 27897 },	-- Breastplate of Many Graces
				{ 4, 27900 },	-- Jewel of Charismatic Mystique
				{ 5, 27901 },	-- Blackout Truncheon
				{ 6, 27898 },	-- Wrathfire Hand-Cannon
				{ 8, 30827, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lexicon Demonica
				{ 16, 30563, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chyroprase
				{ 17, 30559, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Etched Tanzanite
				{ 18, 30560, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
			},
		},
		{	--AuchShadowMurmur
			EncounterJournalID = 547,
			[NORMAL_DIFF] = {
				{ 1, 24309, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Spellstrike Pants
				{ 3, 27902 },	-- Silent Slippers of Meditation
				{ 4, 27912 },	-- Harness of the Deep Currents
				{ 5, 27913 },	-- Whispering Blade of Slaying
				{ 6, 27905 },	-- Greatsword of Horrid Dreams
				{ 7, 27903 },	-- Sonic Spear
				{ 8, 27910 },	-- Silvermoon Crest Shield
				{ 10, 27778 },	-- Spaulders of Oblivion
				{ 11, 28232 },	-- Robe of Oblivion
				{ 12, 28230 },	-- Hallowed Garments
				{ 13, 27908 },	-- Leggings of Assassination
				{ 14, 27909 },	-- Tidefury Kilt
				{ 15, 27803 },	-- Shoulderguards of the Bold
				{ 16, 30532 },	-- Kirin Tor Master's Trousers
				{ 17, 29357 },	-- Master Thief's Gloves
				{ 18, 29261 },	-- Girdle of Ferocity
				{ 19, 29353 },	-- Shockwave Truncheon
				{ 21, "ac654" },
			},
			[HEROIC_DIFF] = {
				{ 1, 24309, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Spellstrike Pants
				{ 3, 27902 },	-- Silent Slippers of Meditation
				{ 4, 27912 },	-- Harness of the Deep Currents
				{ 5, 27913 },	-- Whispering Blade of Slaying
				{ 6, 27905 },	-- Greatsword of Horrid Dreams
				{ 7, 27903 },	-- Sonic Spear
				{ 8, 27910 },	-- Silvermoon Crest Shield
				{ 10, 27778 },	-- Spaulders of Oblivion
				{ 11, 28232 },	-- Robe of Oblivion
				{ 12, 28230 },	-- Hallowed Garments
				{ 13, 27908 },	-- Leggings of Assassination
				{ 14, 27909 },	-- Tidefury Kilt
				{ 15, 27803 },	-- Shoulderguards of the Bold
				{ 16, 30563, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Regal Chyroprase
				{ 17, 30559, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Etched Tanzanite
				{ 18, 30560, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
				{ 20, 30532 },	-- Kirin Tor Master's Trousers
				{ 21, 29357 },	-- Master Thief's Gloves
				{ 22, 29261 },	-- Girdle of Ferocity
				{ 23, 29353 },	-- Shockwave Truncheon
				{ 25, 31722, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Murmur's Essence
				{ 26, 33840, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Murmur's Whisper
				{ 28, "ac675" },
			},
		},
		{	--AuchTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23607 },	-- Plans: Felsteel Helm
				{ 3, "INV_Box_01", nil, AL["First Fragment Guardian"], nil },
				{ 4, 24514 },	-- First Key Fragment
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--LowerCity
			FactionID = 1011,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:7",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["TempestKeepArcatraz"] = {
	EncounterJournalID = 254,
	MapID = 731,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--TKArcUnbound
			EncounterJournalID = 548,
			[NORMAL_DIFF] = {
				{ 1, 28373 },	-- Cloak of Scintillating Auras
				{ 2, 28374 },	-- Mana-Sphere Shoulderguards
				{ 3, 28384 },	-- Outland Striders
				{ 4, 28375 },	-- Rubium War-Girdle
			},
			[HEROIC_DIFF] = {
				{ 1, 28373 },	-- Cloak of Scintillating Auras
				{ 2, 28374 },	-- Mana-Sphere Shoulderguards
				{ 3, 28384 },	-- Outland Striders
				{ 4, 28375 },	-- Rubium War-Girdle
				{ 16, 30582, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Deadly Fire Opal
				{ 17, 30575, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30581, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Willful Fire Opal
			},
		},
		{	--TKArcDalliah
			EncounterJournalID = 549,
			[NORMAL_DIFF] = {
				{ 1, 24308, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Whitemend Pants
				{ 3, 28391 },	-- Worldfire Chestguard
				{ 4, 28390 },	-- Thatia's Self-Correcting Gauntlets
				{ 5, 28387 },	-- Lamp of Peaceful Repose
				{ 6, 28392 },	-- Reflex Blades
				{ 7, 28386 },	-- Nether Core's Control Rod
			},
			[HEROIC_DIFF] = {
				{ 1, 24308, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Whitemend Pants
				{ 3, 28391 },	-- Worldfire Chestguard
				{ 4, 28390 },	-- Thatia's Self-Correcting Gauntlets
				{ 5, 28387 },	-- Lamp of Peaceful Repose
				{ 6, 28392 },	-- Reflex Blades
				{ 7, 28386 },	-- Nether Core's Control Rod
				{ 16, 30582, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Deadly Fire Opal
				{ 17, 30575, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30581, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Willful Fire Opal
			},
		},
		{	--TKArcScryer
			EncounterJournalID = 550,
			[NORMAL_DIFF] = {
				{ 1, 28396 },	-- Gloves of the Unbound
				{ 2, 28398 },	-- The Sleeper's Cord
				{ 3, 28394 },	-- Ryngo's Band of Ingenuity
				{ 4, 28393 },	-- Warmaul of Infused Light
				{ 5, 28397 },	-- Emberhawk Crossbow
			},
			[HEROIC_DIFF] = {
				{ 1, 28396 },	-- Gloves of the Unbound
				{ 2, 28398 },	-- The Sleeper's Cord
				{ 3, 28394 },	-- Ryngo's Band of Ingenuity
				{ 4, 28393 },	-- Warmaul of Infused Light
				{ 5, 28397 },	-- Emberhawk Crossbow
				{ 16, 30582, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Deadly Fire Opal
				{ 17, 30575, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30581, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Willful Fire Opal
			},
		},
		{	--TKArcHarbinger
			EncounterJournalID = 551,
			[NORMAL_DIFF] = {
				{ 1, 28415 },	-- Hood of Oblivion
				{ 2, 28413 },	-- Hallowed Crown
				{ 3, 28414 },	-- Helm of Assassination
				{ 4, 28231 },	-- Tidefury Chestpiece
				{ 5, 28403 },	-- Doomplate Chestguard
				{ 6, 28205 },	-- Breastplate of the Bold
				{ 8, 28406 },	-- Sigil-Laced Boots
				{ 9, 28419 },	-- Choker of Fluid Thought
				{ 10, 28407 },	-- Elementium Band of the Sentry
				{ 11, 28418 },	-- Shiffar's Nexus-Horn
				{ 12, 28412 },	-- Lamp of Peaceful Radiance
				{ 13, 28416 },	-- Hungering Spineripper
				{ 16, "ac660" },
			},
			[HEROIC_DIFF] = {
				{ 1, 28415 },	-- Hood of Oblivion
				{ 2, 28413 },	-- Hallowed Crown
				{ 3, 28414 },	-- Helm of Assassination
				{ 4, 28231 },	-- Tidefury Chestpiece
				{ 5, 28403 },	-- Doomplate Chestguard
				{ 6, 28205 },	-- Breastplate of the Bold
				{ 8, 28406 },	-- Sigil-Laced Boots
				{ 9, 28419 },	-- Choker of Fluid Thought
				{ 10, 28407 },	-- Elementium Band of the Sentry
				{ 11, 28418 },	-- Shiffar's Nexus-Horn
				{ 12, 28412 },	-- Lamp of Peaceful Radiance
				{ 13, 28416 },	-- Hungering Spineripper
				{ 16, 30582, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Deadly Fire Opal
				{ 17, 30575, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30581, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Willful Fire Opal
				{ 20, 29241 },	-- Belt of Depravity
				{ 21, 29248 },	-- Shadowstep Striders
				{ 22, 29252 },	-- Bracers of Dignity
				{ 23, 29360 },	-- Vileblade of the Betrayer
				{ 25, 33861, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Scroll of Skyriss
				{ 27, "ac681" },
			},
		},
		{	--TKTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 23606 },	-- Plans: Felsteel Leggings
				{ 2, 22556 },	-- Formula: Enchant 2H Weapon - Major Agility
				{ 3, 21905 },	-- Pattern: Arcanoweave Bracers
				{ 16, "INV_Box_01", nil, AL["Third Fragment Guardian"], nil },
				{ 17, 24488 },	-- Third Key Fragment
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CoTBlackMorass"] = {
	EncounterJournalID = 255,
	MapID = 733,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--CoTMorassDeja
			EncounterJournalID = 552,
			[NORMAL_DIFF] = {
				{ 1, 27988 },	-- Burnoose of Shifting Ages
				{ 2, 27994 },	-- Mantle of Three Terrors
				{ 3, 27995 },	-- Sun-Gilded Shouldercaps
				{ 4, 27993 },	-- Mask of Inner Fire
				{ 5, 27996 },	-- Ring of Spiritual Precision
				{ 6, 27987 },	-- Melmorta's Twilight Longbow
			},
			[HEROIC_DIFF] = {
				{ 1, 27988 },	-- Burnoose of Shifting Ages
				{ 2, 27994 },	-- Mantle of Three Terrors
				{ 3, 27995 },	-- Sun-Gilded Shouldercaps
				{ 4, 27993 },	-- Mask of Inner Fire
				{ 5, 27996 },	-- Ring of Spiritual Precision
				{ 6, 27987 },	-- Melmorta's Twilight Longbow
				{ 16, 30558, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stalwart Fire Opal
				{ 17, 30556, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Glinting Tanzanite
				{ 18, 30555, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
			},
		},
		{	--CoTMorassTemporus
			EncounterJournalID = 553,
			[NORMAL_DIFF] = {
				{ 1, 28185 },	-- Khadgar's Kilt of Abjuration
				{ 2, 28186 },	-- Laughing Skull Battle-Harness
				{ 3, 28034 },	-- Hourglass of the Unraveller
				{ 4, 28187 },	-- Star-Heart Lamp
				{ 5, 28184 },	-- Millennium Blade
				{ 6, 28033 },	-- Epoch-Mender
			},
			[HEROIC_DIFF] = {
				{ 1, 28185 },	-- Khadgar's Kilt of Abjuration
				{ 2, 28186 },	-- Laughing Skull Battle-Harness
				{ 3, 28034 },	-- Hourglass of the Unraveller
				{ 4, 28187 },	-- Star-Heart Lamp
				{ 5, 28184 },	-- Millennium Blade
				{ 6, 28033 },	-- Epoch-Mender
				{ 16, 30558, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stalwart Fire Opal
				{ 17, 30556, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Glinting Tanzanite
				{ 18, 30555, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
			},
		},
		{	--CoTMorassAeonus
			EncounterJournalID = 554,
			[NORMAL_DIFF] = {
				{ 1, 28193 },	-- Mana-Etched Crown
				{ 2, 27509 },	-- Handgrips of Assassination
				{ 3, 27873 },	-- Moonglade Pants
				{ 4, 28192 },	-- Helm of Desolation
				{ 5, 27977 },	-- Legplates of the Bold
				{ 6, 27839 },	-- Legplates of the Righteous
				{ 8, 28206 },	-- Cowl of the Guiltless
				{ 9, 28194 },	-- Primal Surge Bracers
				{ 10, 28207 },	-- Pauldrons of the Crimson Flight
				{ 11, 28190 },	-- Scarab of the Infinite Cycle
				{ 12, 28189 },	-- Latro's Shifting Sword
				{ 13, 28188 },	-- Bloodfire Greatstaff
				{ 16, "ac655" },
			},
			[HEROIC_DIFF] = {
				{ 1, 28193 },	-- Mana-Etched Crown
				{ 2, 27509 },	-- Handgrips of Assassination
				{ 3, 27873 },	-- Moonglade Pants
				{ 4, 28192 },	-- Helm of Desolation
				{ 5, 27977 },	-- Legplates of the Bold
				{ 6, 27839 },	-- Legplates of the Righteous
				{ 8, 28206 },	-- Cowl of the Guiltless
				{ 9, 28194 },	-- Primal Surge Bracers
				{ 10, 28207 },	-- Pauldrons of the Crimson Flight
				{ 11, 28190 },	-- Scarab of the Infinite Cycle
				{ 12, 28189 },	-- Latro's Shifting Sword
				{ 13, 28188 },	-- Bloodfire Greatstaff
				{ 16, 30558, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Stalwart Fire Opal
				{ 17, 30556, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Glinting Tanzanite
				{ 18, 30555, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Timeless Tanzanite
				{ 20, 30531 },	-- Breeches of the Occultist
				{ 21, 29247 },	-- Girdle of the Deathdealer
				{ 22, 29253 },	-- Girdle of Valorous Deeds
				{ 23, 29356 },	-- Quantum Blade
				{ 25, 33858, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Aeonus' Hourglass
				{ 27, "ac676" },
			},
		},
		{	--CoTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 25730 },	-- Pattern: Stylin' Jungle Hat
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--KeepersofTime
			FactionID = 989,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:5",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["HCBloodFurnace"] = {
	EncounterJournalID = 256,
	MapID = 725,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--HCFurnaceMaker
			EncounterJournalID = 555,
			[NORMAL_DIFF] = {
				{ 1, 24388 },	-- Girdle of the Gale Storm
				{ 2, 24387 },	-- Ironblade Gauntlets
				{ 3, 24385 },	-- Pendant of Battle-Lust
				{ 4, 24384 },	-- Diamond-Core Sledgemace
				{ 6, 73200, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Fel Infusion Rod
			},
			[HEROIC_DIFF] = {
				{ 1, 27485 },	-- Embroidered Cape of Mysteries
				{ 2, 27488 },	-- Mage-Collar of the Firestorm
				{ 3, 27483 },	-- Moon-Touched Bands
				{ 4, 27487 },	-- Bloodlord Legplates
				{ 6, 73200, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Fel Infusion Rod
				{ 16, 30601, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Steady Chrysoprase
				{ 17, 30600, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30602, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
			},
		},
		{	--HCFurnaceBroggok
			EncounterJournalID = 556,
			[NORMAL_DIFF] = {
				{ 1, 24392 },	-- Arcing Bracers
				{ 2, 24393 },	-- Bloody Surgeon's Mitts
				{ 3, 24391 },	-- Kilt of the Night Strider
				{ 4, 24390 },	-- Auslese's Light Channeler
				{ 5, 24389 },	-- Legion Blunderbuss
			},
			[HEROIC_DIFF] = {
				{ 1, 27848 },	-- Embroidered Spellpyre Boots
				{ 2, 27492 },	-- Moonchild Leggings
				{ 3, 27489 },	-- Virtue Bearer's Vambraces
				{ 4, 27491 },	-- Signet of Repose
				{ 5, 27490 },	-- Firebrand Battleaxe
				{ 16, 30601, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Steady Chrysoprase
				{ 17, 30600, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30602, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
			},
		},
		{	--HCFurnaceBreaker
			EncounterJournalID = 557,
			[NORMAL_DIFF] = {
				{ 1, 24397 },	-- Raiments of Divine Authority
				{ 2, 24395 },	-- Mindfire Waistband
				{ 3, 24398 },	-- Mantle of the Dusk-Dweller
				{ 4, 24396 },	-- Vest of Vengeance
				{ 5, 24394 },	-- Warsong Howling Axe
				{ 16, "ac648" },
			},
			[HEROIC_DIFF] = {
				{ 1, 32080 },	-- Mantle of Shadowy Embrace
				{ 2, 29245 },	-- Wave-Crest Striders
				{ 3, 29239 },	-- Eaglecrest Warboots
				{ 4, 29347 },	-- Talisman of the Breaker
				{ 6, 27506 },	-- Robe of Effervescent Light
				{ 7, 27514 },	-- Leggings of the Unrepentant
				{ 8, 27522 },	-- World's End Bracers
				{ 9, 27494 },	-- Emerald Eye Bracer
				{ 10, 27505 },	-- Ruby Helm of the Just
				{ 11, 27788 },	-- Bloodsworn Warboots
				{ 13, 28264 },	-- Wastewalker Tunic
				{ 14, 27497 },	-- Doomplate Gauntlets
				{ 16, 30601, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Steady Chrysoprase
				{ 17, 30600, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30602, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 20, 27495 },	-- Soldier's Dog Tags
				{ 21, 28121 },	-- Icon of Unyielding Courage
				{ 22, 27512 },	-- The Willbreaker
				{ 23, 27507 },	-- Adamantine Repeater
				{ 25, 33814, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Keli'dan's Feathered Stave
				{ 27, "ac668" },
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--HonorHold
			FactionID = 946,
			ExtraList = true,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:4",
		},
		{	--Thrallmar
			FactionID = 947,
			ExtraList = true,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:21",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["TempestKeepBotanica"] = {
	EncounterJournalID = 257,
	MapID = 729,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--TKBotSarannis
			EncounterJournalID = 558,
			[NORMAL_DIFF] = {
				{ 1, 28301 },	-- Syrannis' Mystic Sheen
				{ 2, 28304 },	-- Prismatic Mittens of Mending
				{ 3, 28306 },	-- Towering Mantle of the Hunt
				{ 4, 28311 },	-- Revenger
				{ 6, 28769, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Keystone
			},
			[HEROIC_DIFF] = {
				{ 1, 28301 },	-- Syrannis' Mystic Sheen
				{ 2, 28304 },	-- Prismatic Mittens of Mending
				{ 3, 28306 },	-- Towering Mantle of the Hunt
				{ 4, 28311 },	-- Revenger
				{ 6, 28769, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Keystone
				{ 16, 30574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
				{ 17, 30572, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30573, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Mysterious Tanzanite
			},
		},
		{	--TKBotFreywinn
			EncounterJournalID = 559,
			[NORMAL_DIFF] = {
				{ 1, 28317 },	-- Energis Armwraps
				{ 2, 28318 },	-- Obsidian Clodstompers
				{ 3, 28321 },	-- Enchanted Thorium Torque
				{ 4, 28315 },	-- Stormreaver Warblades
				{ 5, 28316 },	-- Aegis of the Sunbird
				{ 7, 23617, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Earthpeace Breastplate
				{ 9, 31744, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Botanist's Field Guide
			},
			[HEROIC_DIFF] = {
				{ 1, 28317 },	-- Energis Armwraps
				{ 2, 28318 },	-- Obsidian Clodstompers
				{ 3, 28321 },	-- Enchanted Thorium Torque
				{ 4, 28315 },	-- Stormreaver Warblades
				{ 5, 28316 },	-- Aegis of the Sunbird
				{ 7, 23617, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Earthpeace Breastplate
				{ 16, 30574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
				{ 17, 30572, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30573, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Mysterious Tanzanite
			},
		},
		{	--TKBotThorngrin
			EncounterJournalID = 560,
			[NORMAL_DIFF] = {

				{ 1, 28324 },	-- Gauntlets of Cruel Intention
				{ 2, 28327 },	-- Arcane Netherband
				{ 3, 28323 },	-- Ring of Umbral Doom
				{ 4, 28322 },	-- Runed Dagger of Solace
				{ 5, 28325 },	-- Dreamer's Dragonstaff
				{ 16, 24310, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Battlecast Pants
			},
			[HEROIC_DIFF] = {
				{ 1, 28324 },	-- Gauntlets of Cruel Intention
				{ 2, 28327 },	-- Arcane Netherband
				{ 3, 28323 },	-- Ring of Umbral Doom
				{ 4, 28322 },	-- Runed Dagger of Solace
				{ 5, 28325 },	-- Dreamer's Dragonstaff
				{ 16, 30574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
				{ 17, 30572, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30573, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Mysterious Tanzanite
				{ 20, 24310, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Battlecast Pants
			},
		},
		{	--TKBotLaj
			EncounterJournalID = 561,
			[NORMAL_DIFF] = {
				{ 1, 27739 },	-- Spaulders of the Righteous
				{ 3, 28328 },	-- Mithril-Bark Cloak
				{ 4, 28338 },	-- Devil-Stitched Leggings
				{ 5, 28340 },	-- Mantle of Autumn
				{ 6, 28339 },	-- Boots of the Shifting Sands
				{ 8, 72706, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Rapidly Evolving Frond
			},
			[HEROIC_DIFF] = {
				{ 1, 27739 },	-- Spaulders of the Righteous
				{ 3, 28328 },	-- Mithril-Bark Cloak
				{ 4, 28338 },	-- Devil-Stitched Leggings
				{ 5, 28340 },	-- Mantle of Autumn
				{ 6, 28339 },	-- Boots of the Shifting Sands
				{ 8, 72706, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Rapidly Evolving Frond
				{ 16, 30574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
				{ 17, 30572, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30573, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Mysterious Tanzanite
			},
		},
		{	--TKBotSplinter
			EncounterJournalID = 562,
			[NORMAL_DIFF] = {
				{ 1, 28371 },	-- Netherfury Cape
				{ 2, 28342 },	-- Warp Infused Drape
				{ 3, 28347 },	-- Warpscale Leggings
				{ 4, 28343 },	-- Jagged Bark Pendant
				{ 5, 28370 },	-- Bangle of Endless Blessings
				{ 6, 28345 },	-- Warp Splinter's Thorn
				{ 7, 28367 },	-- Greatsword of Forlorn Visions
				{ 8, 28341 },	-- Warpstaff of Arcanum
				{ 10, 31085, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Top Shard of the Arcatraz Key
				{ 16, 28229 },	-- Incanter's Robe
				{ 17, 28348 },	-- Moonglade Cowl
				{ 18, 28349 },	-- Tidefury Helm
				{ 19, 28228 },	-- Beast Lord Curiass
				{ 20, 28350 },	-- Warhelm of the Bold
				{ 22, 24311, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Whitemend Hood
				{ 24, "ac659" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29258 },	-- Boots of Ethereal Manipulation
				{ 2, 29262 },	-- Boots of the Endless Hunt
				{ 3, 32072 },	-- Gauntlets of Dissension
				{ 4, 29359 },	-- Feral Staff of Lashing
				{ 6, 28371 },	-- Netherfury Cape
				{ 7, 28342 },	-- Warp Infused Drape
				{ 8, 28347 },	-- Warpscale Leggings
				{ 9, 28343 },	-- Jagged Bark Pendant
				{ 10, 28370 },	-- Bangle of Endless Blessings
				{ 11, 28345 },	-- Warp Splinter's Thorn
				{ 12, 28367 },	-- Greatsword of Forlorn Visions
				{ 13, 28341 },	-- Warpstaff of Arcanum
				{ 15, "ac680" },
				{ 16, 30574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
				{ 17, 30572, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 18, 30573, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Mysterious Tanzanite
				{ 20, 28229 },	-- Incanter's Robe
				{ 21, 28348 },	-- Moonglade Cowl
				{ 22, 28349 },	-- Tidefury Helm
				{ 23, 28228 },	-- Beast Lord Curiass
				{ 24, 28350 },	-- Warhelm of the Bold
				{ 26, 24311, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Whitemend Hood
				{ 28, 31085, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Top Shard of the Arcatraz Key
				{ 29, 33859, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Warp Splinter Clipping
			},
		},
		{	--TKTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 24172 },	-- Design: Coronet of Verdant Flame
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["TempestKeepMechanar"] = {
	EncounterJournalID = 258,
	MapID = 730,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--TKMechCapacitus
			EncounterJournalID = 563,
			[NORMAL_DIFF] = {
				{ 1, 28256 },	-- Thoriumweave Cloak
				{ 2, 28255 },	-- Lunar-Claw Pauldrons
				{ 3, 28254 },	-- Warp Engineer's Prismatic Chain
				{ 4, 28257 },	-- Hammer of the Penitent
				{ 5, 28253 },	-- Plasma Rat's Hyper-Scythe
				{ 7, 35582, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Rocket Boots Xtreme Lite
			},
			[HEROIC_DIFF] = {
				{ 1, 28256 },	-- Thoriumweave Cloak
				{ 2, 28255 },	-- Lunar-Claw Pauldrons
				{ 3, 28254 },	-- Warp Engineer's Prismatic Chain
				{ 4, 28257 },	-- Hammer of the Penitent
				{ 5, 28253 },	-- Plasma Rat's Hyper-Scythe
				{ 7, 35582, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Rocket Boots Xtreme Lite
				{ 16, 30565, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 17, 30566, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Defender's Tanzanite
				{ 18, 30564, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Veiled Tanzanite
			},
		},
		{	--TKMechCacheoftheLegion
			name = BB["Cache of the Legion"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, BB["Cache of the Legion"], nil },
				{ 2, 28249 },	-- Capacitus' Cloak of Calibration
				{ 3, 28250 },	-- Vestia's Pauldrons of Inner Grace
				{ 4, 28252 },	-- Bloodfyre Robes of Annihilation
				{ 5, 28251 },	-- Boots of the Glade-Keeper
				{ 7, 72663 },	-- Blinding Fury
			},
		},
		{	--TKMechSepethrea
			EncounterJournalID = 564,
			[NORMAL_DIFF] = {
				{ 1, 28262 },	-- Jade-Skull Breastplate
				{ 2, 28259 },	-- Cosmic Lifeband
				{ 3, 28260 },	-- Manual of the Nethermancer
				{ 4, 28263 },	-- Stellaris
				{ 6, 22920, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Major Fire Protection Potion
			},
			[HEROIC_DIFF] = {
				{ 1, 28262 },	-- Jade-Skull Breastplate
				{ 2, 28259 },	-- Cosmic Lifeband
				{ 3, 28260 },	-- Manual of the Nethermancer
				{ 4, 28263 },	-- Stellaris
				{ 6, 22920, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Major Fire Protection Potion
				{ 16, 30565, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 17, 30566, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Defender's Tanzanite
				{ 18, 30564, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Veiled Tanzanite
			},
		},
		{	--TKMechCalc
			EncounterJournalID = 565,
			[NORMAL_DIFF] = {
				{ 1, 28269 },	-- Baba's Cloak of Arcanistry
				{ 2, 28266 },	-- Molten Earth Kilt
				{ 3, 28265 },	-- Dath'Remar's Ring of Defense
				{ 4, 28288 },	-- Abacus of Violent Odds
				{ 5, 27899 },	-- Mana Wrath
				{ 6, 28267 },	-- Edge of the Cosmos
				{ 7, 28286 },	-- Telescopic Sharprifle
				{ 9, 21907, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Arcanoweave Robe
				{ 11, 31086, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Bottom Shard of the Arcatraz Key
				{ 16, 28278 },	-- Incanter's Cowl
				{ 17, 28202 },	-- Moonglade Robe
				{ 18, 28204 },	-- Tunic of Assassination
				{ 19, 28275 },	-- Beast Lord Helm
				{ 20, 28285 },	-- Helm of the Righteous
				{ 22, "ac658" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29251 },	-- Boots of the Pious
				{ 2, 32076 },	-- Handguards of the Steady
				{ 3, 30533 },	-- Vanquisher's Legplates
				{ 4, 29362 },	-- The Sun Eater
				{ 6, 28269 },	-- Baba's Cloak of Arcanistry
				{ 7, 28266 },	-- Molten Earth Kilt
				{ 8, 28265 },	-- Dath'Remar's Ring of Defense
				{ 9, 28288 },	-- Abacus of Violent Odds
				{ 10, 27899 },	-- Mana Wrath
				{ 11, 28267 },	-- Edge of the Cosmos
				{ 12, 28286 },	-- Telescopic Sharprifle
				{ 14, 21907, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Arcanoweave Robe
				{ 16, 30565, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 17, 30566, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Defender's Tanzanite
				{ 18, 30564, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Veiled Tanzanite
				{ 20, 28278 },	-- Incanter's Cowl
				{ 21, 28202 },	-- Moonglade Robe
				{ 22, 28204 },	-- Tunic of Assassination
				{ 23, 28275 },	-- Beast Lord Helm
				{ 24, 28285 },	-- Helm of the Righteous
				{ 26, 31086, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Bottom Shard of the Arcatraz Key
				{ 27, 33860, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pathaleon's Projector
				{ 29, "ac679" },
			},
		},
		{	--TKTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 22920 },	-- Recipe: Major Fire Protection Potion
				{ 2, 21906 },	-- Pattern: Arcanoweave Boots
				{ 4, "INV_Box_01", nil, AL["Overcharged Manacell"], nil },
				{ 5, 30824 },	-- Overcharged Manacell
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["HCTheShatteredHalls"] = {
	EncounterJournalID = 259,
	MapID = 710,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--HCHallsNethekurse
			EncounterJournalID = 566,
			[NORMAL_DIFF] = {
				{ 1, 27519 },	-- Cloak of Malice
				{ 2, 27517 },	-- Bands of Nethekurse
				{ 3, 27521 },	-- Telaari Hunting Girdle
				{ 4, 27520 },	-- Greathelm of the Unbreakable
				{ 6, 23735, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Grand Warlock's Amulet
				{ 16, 24312, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Spellstrike Hood
			},
			[HEROIC_DIFF] = {
				{ 1, 27519 },	-- Cloak of Malice
				{ 2, 27517 },	-- Bands of Nethekurse
				{ 3, 27521 },	-- Telaari Hunting Girdle
				{ 4, 27520 },	-- Greathelm of the Unbreakable
				{ 6, 23735, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Grand Warlock's Amulet
				{ 8, 25462, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tome of Dusk
				{ 16, 30548, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 17, 30547, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reckless Fire Opal
				{ 18, 30546, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sovereign Tanzanite
				{ 20, 24312, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Spellstrike Hood
			},
		},
		{	--HCHallsPorung
			EncounterJournalID = 728,
			[HEROIC_DIFF] = {
				{ 1, 30709 },	-- Pantaloons of Flaming Wrath
				{ 2, 30707 },	-- Nimble-Foot Treads
				{ 3, 30708 },	-- Belt of Flowing Thought
				{ 4, 30705 },	-- Spaulders of Slaughter
				{ 5, 30710 },	-- Blood Guard's Necklace of Ferocity
				{ 16, 30548, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Polished Chrysoprase
				{ 17, 30547, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Luminous Fire Opal
				{ 18, 30546, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sovereign Tanzanite
			},
		},
		{	--HCHallsOmrogg
			EncounterJournalID = 568,
			[NORMAL_DIFF] = {
				{ 1, 27802 },	-- Tidefury Shoulderguards
				{ 3, 27525 },	-- Jeweled Boots of Sanctification
				{ 4, 27868 },	-- Runesong Dagger
				{ 5, 27524 },	-- Firemaul of Destruction
				{ 6, 27526 },	-- Skyfire Hawk-Bow
				{ 8, 72597, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- O'mrogg's Warcloth
				{ 9, 30829, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tear of the Earthmother
			},
			[HEROIC_DIFF] = {
				{ 1, 27802 },	-- Tidefury Shoulderguards
				{ 3, 27525 },	-- Jeweled Boots of Sanctification
				{ 4, 27868 },	-- Runesong Dagger
				{ 5, 27524 },	-- Firemaul of Destruction
				{ 6, 27526 },	-- Skyfire Hawk-Bow
				{ 8, 72597, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- O'mrogg's Warcloth
				{ 9, 30829, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tear of the Earthmother
				{ 16, 30548, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 17, 30547, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reckless Fire Opal
				{ 18, 30546, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sovereign Tanzanite
			},
		},
		{	--HCHallsKargath
			EncounterJournalID = 569,
			[NORMAL_DIFF] = {
				{ 1, 27536 },	-- Hallowed Handwraps
				{ 2, 27537 },	-- Gloves of Oblivion
				{ 3, 27531 },	-- Wastewalker Gloves
				{ 4, 27474 },	-- Beast Lord Handguards
				{ 5, 27528 },	-- Gauntlets of Desolation
				{ 6, 27535 },	-- Gauntlets of the Righteous
				{ 8, 27527 },	-- Greaves of the Shatterer
				{ 9, 27529 },	-- Figurine of the Colossus
				{ 10, 27533 },	-- Demonblood Eviscerator
				{ 11, 27538 },	-- Lightsworn Hammer
				{ 12, 27540 },	-- Nexus Torch
				{ 13, 27534 },	-- Hortus' Seal of Brilliance
				{ 15, 23723, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Warchief Kargath's Fist
				{ 16, "ac657" },
			},
			[HEROIC_DIFF] = {
				{ 1, 27536 },	-- Hallowed Handwraps
				{ 2, 27537 },	-- Gloves of Oblivion
				{ 3, 27531 },	-- Wastewalker Gloves
				{ 4, 27474 },	-- Beast Lord Handguards
				{ 5, 27528 },	-- Gauntlets of Desolation
				{ 6, 27535 },	-- Gauntlets of the Righteous
				{ 8, 27527 },	-- Greaves of the Shatterer
				{ 9, 27529 },	-- Figurine of the Colossus
				{ 10, 27534 },	-- Hortus' Seal of Brilliance
				{ 11, 27533 },	-- Demonblood Eviscerator
				{ 12, 27538 },	-- Lightsworn Hammer
				{ 13, 27540 },	-- Nexus Torch
				{ 15, 23723, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Warchief Kargath's Fist
				{ 16, 30548, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Jagged Chrysoprase
				{ 17, 30547, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reckless Fire Opal
				{ 18, 30546, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sovereign Tanzanite
				{ 20, 29255 },	-- Bands of Rarefied Magic
				{ 21, 29263 },	-- Forestheart Bracers
				{ 22, 29254 },	-- Boots of the Righteous Path
				{ 23, 29348 },	-- The Bladefist
				{ 25, 33815, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Bladefist's Seal
				{ 27, "ac678" },
			},
		},
		{	--HCHallsTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 22554 },	-- Formula: Enchant 2H Weapon - Savagery
				{ 3, "INV_Box_01", nil, AL["Shattered Hand Executioner"], nil },
				{ 4, 31716 },	-- Unused Axe of the Executioner
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--HonorHold
			FactionID = 946,
			ExtraList = true,
			CoinTexture = "Reputation",
			[ALLIANCE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:4",
		},
		{	--Thrallmar
			FactionID = 947,
			ExtraList = true,
			CoinTexture = "Reputation",
			[HORDE_DIFF] = "AtlasLoot_Factions:BCFACTIONS:21",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CFRTheSlavePens"] = {
	EncounterJournalID = 260,
	MapID = 728,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--CFRSlaveMennu
			EncounterJournalID = 570,
			[NORMAL_DIFF] = {
				{ 1, 24359 },	-- Princely Reign Leggings
				{ 2, 24357 },	-- Vest of Living Lightning
				{ 3, 24360 },	-- Tracker's Belt
				{ 4, 24356 },	-- Wastewalker Shiv
				{ 5, 24361 },	-- Spellfire Longsword
			},
			[HEROIC_DIFF] = {
				{ 1, 27542 },	-- Cord of Belief
				{ 2, 27545 },	-- Mennu's Scaled Leggings
				{ 3, 27541 },	-- Archery Belt of the Broken
				{ 4, 27546 },	-- Traitor's Noose
				{ 5, 27543 },	-- Starlight Dagger
				{ 16, 30604, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Resplendent Fire Opal
				{ 17, 30605, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30603, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
			},
		},
		{	--CFRSlaveRokmar
			EncounterJournalID = 571,
			[NORMAL_DIFF] = {
				{ 1, 24379 },	-- Bogstrok Scale Cloak
				{ 2, 24376 },	-- Runed Fungalcap
				{ 3, 24378 },	-- Coilfang Hammer of Renewal
				{ 4, 24380 },	-- Calming Spore Reed
				{ 5, 24381 },	-- Coilfang Needler
				{ 7, 72118, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Invader's Claw
			},
			[HEROIC_DIFF] = {
				{ 1, 27550 },	-- Ironscale War Cloak
				{ 2, 27547 },	-- Coldwhisper Cord
				{ 3, 28124 },	-- Liar's Cord
				{ 4, 27549 },	-- Wavefury Boots
				{ 5, 27548 },	-- Girdle of Many Blessings
				{ 6, 27551 },	-- Skeletal Necklace of Battlerage
				{ 8, 72118, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Invader's Claw
				{ 16, 30604, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Resplendent Fire Opal
				{ 17, 30605, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30603, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
			},
		},
		{	--CFRSlaveQuagmirran
			EncounterJournalID = 572,
			[NORMAL_DIFF] = {
				{ 1, 24362 },	-- Spore-Soaked Vaneer
				{ 2, 24365 },	-- Deft Handguards
				{ 3, 24366 },	-- Scorpid-Sting Mantle
				{ 4, 24363 },	-- Unscarred Breastplate
				{ 5, 24364 },	-- Azureplate Greaves
				{ 7, 72119, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Slave Master's Eye
				{ 16, "ac649" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29242 },	-- Boots of Blasphemy
				{ 2, 30538 },	-- Midnight Legguards
				{ 3, 32078 },	-- Pauldrons of Wild Magic
				{ 4, 29349 },	-- Adamantine Chain of the Unbroken
				{ 6, 27742 },	-- Mage-Fury Girdle
				{ 7, 27712 },	-- Shackles of Quagmirran
				{ 8, 27800 },	-- Earthsoul Britches
				{ 9, 28337 },	-- Breastplate of Righteous Fury
				{ 10, 27672 },	-- Girdle of the Immovable
				{ 12, 27796 },	-- Mana-Etched Spaulders
				{ 13, 27713 },	-- Pauldrons of Desolation
				{ 16, 30604, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Resplendent Fire Opal
				{ 17, 30605, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Nimble Chrysoprase
				{ 18, 30603, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Purified Tanzanite
				{ 20, 27740 },	-- Band of Ursol
				{ 21, 27683 },	-- Quagmirran's Eye
				{ 22, 27673 },	-- Phosphorescent Blade
				{ 23, 27741 },	-- Bleeding Hollow Warhammer
				{ 24, 27714 },	-- Swamplight Lantern
				{ 26, 33821, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Heart of Quagmirran
				{ 27, 72119, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Slave Master's Eye
				{ 29, "ac669" },
			},
		},
		{	--MidsummerFireFestivalAhune
			name = BB["Ahune"].." ("..AL["Midsummer Fire Festival"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:MidsummerFireFestival:1",
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CFRTheSteamvault"] = {
	EncounterJournalID = 261,
	MapID = 727,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--CFRSteamThespia
			EncounterJournalID = 573,
			[NORMAL_DIFF] = {
				{ 1, 27508 },	-- Incanter's Gloves
				{ 3, 27789 },	-- Cloak of Whispering Shells
				{ 4, 27787 },	-- Chestguard of No Remorse
				{ 5, 27783 },	-- Moonrage Girdle
				{ 6, 27784 },	-- Scintillating Coral Band
				{ 8, 30828, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Vial of Underworld Loam
			},
			[HEROIC_DIFF] = {
				{ 1, 27508 },	-- Incanter's Gloves
				{ 3, 27789 },	-- Cloak of Whispering Shells
				{ 4, 27787 },	-- Chestguard of No Remorse
				{ 5, 27783 },	-- Moonrage Girdle
				{ 6, 27784 },	-- Scintillating Coral Band
				{ 8, 30828, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Vial of Underworld Loam
				{ 16, 30550, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
				{ 17, 30551, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reckless Fire Opal
				{ 18, 30549, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
			},
		},
		{	--CFRSteamSteamrigger
			EncounterJournalID = 574,
			[NORMAL_DIFF] = {
				{ 1, 27793 },	-- Earth Mantle Handwraps
				{ 2, 27790 },	-- Mask of Penance
				{ 3, 27792 },	-- Steam-Hinge Chain of Valor
				{ 4, 27791 },	-- Serpentcrest Life-Staff
				{ 5, 27794 },	-- Recoilless Rocket Ripper X-54
				{ 7, 23887, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Rocket Boots Xtreme
				{ 9, 72574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Irradiated Gear
			},
			[HEROIC_DIFF] = {
				{ 1, 27793 },	-- Earth Mantle Handwraps
				{ 2, 27790 },	-- Mask of Penance
				{ 3, 27792 },	-- Steam-Hinge Chain of Valor
				{ 4, 27791 },	-- Serpentcrest Life-Staff
				{ 5, 27794 },	-- Recoilless Rocket Ripper X-54
				{ 7, 23887, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Rocket Boots Xtreme
				{ 9, 72574, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Irradiated Gear
				{ 16, 30550, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
				{ 17, 30551, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reckless Fire Opal
				{ 18, 30549, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
			},
		},
		{	--CFRSteamWarlord
			EncounterJournalID = 575,
			[NORMAL_DIFF] = {
				{ 1, 27738 },	-- Incanter's Pauldrons
				{ 2, 27737 },	-- Moonglade Shoulders
				{ 3, 27801 },	-- Beast Lord Mantle
				{ 4, 27510 },	-- Tidefury Gauntlets
				{ 5, 27874 },	-- Beast Lord Leggings
				{ 6, 28203 },	-- Breastplate of the Righteous
				{ 7, 27475 },	-- Gauntlets of the Bold
				{ 9, 27804 },	-- Devilshark Cape
				{ 10, 27799 },	-- Vermillion Robes of the Dominant
				{ 11, 27795 },	-- Sash of Serpentra
				{ 12, 27806 },	-- Fathomheart Gauntlets
				{ 13, 27805 },	-- Ring of the Silver Hand
				{ 16, 24313, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Battlecast Hood
				{ 18, "ac656" },
			},
			[HEROIC_DIFF] = {
				{ 1, 27738 },	-- Incanter's Pauldrons
				{ 2, 27737 },	-- Moonglade Shoulders
				{ 3, 27801 },	-- Beast Lord Mantle
				{ 4, 27510 },	-- Tidefury Gauntlets
				{ 5, 27874 },	-- Beast Lord Leggings
				{ 6, 28203 },	-- Breastplate of the Righteous
				{ 7, 27475 },	-- Gauntlets of the Bold
				{ 9, 27804 },	-- Devilshark Cape
				{ 10, 27799 },	-- Vermillion Robes of the Dominant
				{ 11, 27795 },	-- Sash of Serpentra
				{ 12, 27806 },	-- Fathomheart Gauntlets
				{ 13, 27805 },	-- Ring of the Silver Hand
				{ 16, 30550, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Misty Chrysoprase
				{ 17, 30551, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Reckless Fire Opal
				{ 18, 30549, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Shifting Tanzanite
				{ 20, 30543 },	-- Pontifex Kilt
				{ 21, 29243 },	-- Wave-Fury Vambraces
				{ 22, 29463 },	-- Amber Bands of the Aggressor
				{ 23, 29351 },	-- Wrathtide Longbow
				{ 25, 24313, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Battlecast Hood
				{ 27, 31721, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Kalithresh's Trident
				{ 28, 33827, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- The Warlord's Treatise
				{ 30, "ac677" },
			},
		},
		{	--CFRSteamTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 24159 },	-- Design: Khorium Band of Frost
				{ 3, 22533 },	-- Formula: Enchant Bracer - Fortitude
				{ 5, 24367 },	-- Orders from Lady Vashj
				{ 16, "INV_Box_01", nil, AL["Second Fragment Guardian"], nil },
				{ 17, 24487 },	-- Second Key Fragment
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["CFRTheUnderbog"] = {
	EncounterJournalID = 262,
	MapID = 726,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--CFRUnderHungarfen
			EncounterJournalID = 576,
			[NORMAL_DIFF] = {
				{ 1, 24450 },	-- Manaspark Gloves
				{ 2, 24452 },	-- Starlight Gauntlets
				{ 3, 24451 },	-- Lykul Bloodbands
			},
			[HEROIC_DIFF] = {

				{ 1, 27746 },	-- Arcanium Signet Bands
				{ 2, 27745 },	-- Hungarhide Gauntlets
				{ 3, 27743 },	-- Girdle of Living Flame
				{ 4, 27748 },	-- Cassock of the Loyal
				{ 5, 27747 },	-- Boggspine Knuckles
				{ 16, 30606, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lightning Chrysoprase
				{ 17, 30607, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Splendid Fire Opal
				{ 18, 30608, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Radiant Chrysoprase
			},
		},
		{	--CFRUnderGhazan
			EncounterJournalID = 577,
			[NORMAL_DIFF] = {
				{ 1, 24459 },	-- Cloak of Healing Rays
				{ 2, 24458 },	-- Studded Girdle of Virtue
				{ 3, 24460 },	-- Talisman of Tenacity
				{ 4, 24462 },	-- Luminous Pearls of Insight
				{ 5, 24461 },	-- Hatebringer
			},
			[HEROIC_DIFF] = {
				{ 1, 27760 },	-- Dunewind Sash
				{ 2, 27759 },	-- Headdress of the Tides
				{ 3, 27755 },	-- Girdle of Gallantry
				{ 4, 27758 },	-- Hydra-Fang Necklace
				{ 5, 27761 },	-- Ring of the Shadow Deeps
				{ 6, 27757 },	-- Greatstaff of the Leviathan
				{ 16, 30606, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lightning Chrysoprase
				{ 17, 30607, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Splendid Fire Opal
				{ 18, 30608, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Radiant Chrysoprase
			},
		},
		{	--CFRUnderSwamplord
			EncounterJournalID = 578,
			[NORMAL_DIFF] = {
				{ 1, 24454 },	-- Cloak of Enduring Swiftness
				{ 2, 24455 },	-- Tunic of the Nightwatcher
				{ 3, 24457 },	-- Truth Bearer Shoulderguards
				{ 4, 24456 },	-- Greaves of the Iron Guardian
				{ 5, 24453 },	-- Zangartooth Shortblade
			},
			[HEROIC_DIFF] = {
				{ 1, 27764 },	-- Hands of the Sun
				{ 2, 27763 },	-- Crown of the Forest Lord
				{ 3, 27765 },	-- Armwraps of Disdain
				{ 4, 27766 },	-- Swampstone Necklace
				{ 5, 27762 },	-- Weathered Band of the Swamplord
				{ 6, 27767 },	-- Bogreaver
				{ 16, 30606, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lightning Chrysoprase
				{ 17, 30607, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Splendid Fire Opal
				{ 18, 30608, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Radiant Chrysoprase
			},
		},
		{	--CFRUnderStalker
			EncounterJournalID = 579,
			[NORMAL_DIFF] = {
				{ 1, 24481 },	-- Robes of the Augurer
				{ 2, 24466 },	-- Skulldugger's Leggings
				{ 3, 24465 },	-- Shamblehide Chestguard
				{ 4, 24463 },	-- Pauldrons of Brute Force
				{ 5, 24464 },	-- The Stalker's Fangs
				{ 7, 24248, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Brain of the Black Stalker
				{ 16, "ac650" },
			},
			[HEROIC_DIFF] = {
				{ 1, 29265 },	-- Barkchip Boots
				{ 2, 30541 },	-- Stormsong Kilt
				{ 3, 32081 },	-- Eye of the Stalker
				{ 4, 29350 },	-- The Black Stalk
				{ 6, 27781 },	-- Demonfang Ritual Helm
				{ 7, 27768 },	-- Oracle Belt of Timeless Mystery
				{ 8, 27938 },	-- Savage Mask of the Lynx Lord
				{ 9, 27773 },	-- Barbaric Legstraps
				{ 10, 27779 },	-- Bone Chain Necklace
				{ 11, 27780 },	-- Ring of Fabled Hope
				{ 12, 27896 },	-- Alembic of Infernal Power
				{ 13, 27770 },	-- Argussian Compass
				{ 16, 30606, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lightning Chrysoprase
				{ 17, 30607, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Splendid Fire Opal
				{ 18, 30608, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Radiant Chrysoprase
				{ 20, 27907 },	-- Mana-Etched Pantaloons
				{ 21, 27771 },	-- Doomplate Shoulderguards
				{ 23, 27769 },	-- Endbringer
				{ 24, 27772 },	-- Stormshield of Renewal
				{ 26, 33826, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Black Stalker Egg
				{ 27, 24248, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Brain of the Black Stalker
				{ 29, "ac670" },
			},
		},
		{	--Dungeon Sets 3
			name = format(AL["Dungeon %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:DUNGEONSETS:1"
		},
		{	--CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2",
		},
		BC_DUNGEONMASTER_AC_TABLE,
		BC_DUNGEON_HERO_AC_TABLE,
	}
}

data["BlackTemple"] = {
	name = ALIL["Black Temple"],
	MapID = 796,
	ContentType = RAID_CONTENT,
	items = {
		{	--BTNajentus
			name = BB["High Warlord Naj'entus"],
			npcId = 22887,
			[P25_DIFF] = {
				{ 1, 32239 },	-- Slippers of the Seacaller
				{ 2, 32240 },	-- Guise of the Tidal Lurker
				{ 3, 32377 },	-- Mantle of Darkness
				{ 4, 32241 },	-- Helm of Soothing Currents
				{ 5, 32234 },	-- Fists of Mukoa
				{ 6, 32242 },	-- Boots of Oceanic Fury
				{ 7, 32232 },	-- Eternium Shell Bracers
				{ 8, 32243 },	-- Pearl Inlaid Boots
				{ 9, 32245 },	-- Tide-Stomper's Greaves
				{ 16, 32238 },	-- Ring of Calming Waves
				{ 17, 32247 },	-- Ring of Captured Storms
				{ 19, 32237 },	-- The Maelstrom's Fury
				{ 20, 32236 },	-- Rising Tide
				{ 21, 32248 },	-- Halberd of Desolation
			},
		},
		{	--BTSupremus
			name = BB["Supremus"],
			npcId = 22898,
			[P25_DIFF] = {
				{ 1, 32256 },	-- Waistwrap of Infinity
				{ 2, 32252 },	-- Nether Shadow Tunic
				{ 3, 32259 },	-- Bands of the Coming Storm
				{ 4, 32251 },	-- Wraps of Precise Flight
				{ 5, 32258 },	-- Naturalist's Preserving Cinch
				{ 6, 32250 },	-- Pauldrons of Abyssal Fury
				{ 8, 32260 },	-- Choker of Endless Nightmares
				{ 9, 32261 },	-- Band of the Abyssal Lord
				{ 16, 32254 },	-- The Brutalizer
				{ 17, 32262 },	-- Syphon of the Nathrezim
				{ 18, 32255 },	-- Felstone Bulwark
				{ 19, 32253 },	-- Legionkiller
			},
		},
		{	--BTAkama
			name = BB["Shade of Akama"],
			npcId = 22841,
			[P25_DIFF] = {
				{ 1, 32273 },	-- Amice of Brilliant Light
				{ 2, 32270 },	-- Focused Mana Bindings
				{ 3, 32513 },	-- Wristbands of Divine Influence
				{ 4, 32265 },	-- Shadow-Walker's Cord
				{ 5, 32271 },	-- Kilt of Immortal Nature
				{ 6, 32264 },	-- Shoulders of the Hidden Predator
				{ 7, 32275 },	-- Spiritwalker Gauntlets
				{ 8, 32276 },	-- Flashfire Girdle
				{ 9, 32279 },	-- The Seeker's Wristguards
				{ 10, 32278 },	-- Grips of Silent Justice
				{ 11, 32263 },	-- Praetorian's Legguards
				{ 12, 32268 },	-- Myrmidon's Treads
				{ 16, 32266 },	-- Ring of Deceitful Intent
				{ 18, 32361 },	-- Blind-Seers Icon
			},
		},
		{	--BTBloodboil
			name = BB["Gurtogg Bloodboil"],
			npcId = 22948,
			[P25_DIFF] = {
				{ 1, 32337 },	-- Shroud of Forgiveness
				{ 2, 32338 },	-- Blood-Cursed Shoulderpads
				{ 3, 32340 },	-- Garments of Temperance
				{ 4, 32339 },	-- Belt of Primal Majesty
				{ 5, 32334 },	-- Vest of Mounting Assault
				{ 6, 32342 },	-- Girdle of Mighty Resolve
				{ 7, 32333 },	-- Girdle of Stability
				{ 8, 32341 },	-- Leggings of Divine Retribution
				{ 16, 32335 },	-- Unstoppable Aggressor's Ring
				{ 17, 32501 },	-- Shadowmoon Insignia
				{ 19, 32269 },	-- Messenger of Fate
				{ 20, 32344 },	-- Staff of Immaculate Recovery
				{ 21, 32343 },	-- Wand of Prismatic Focus
			},
		},
		{	--BTReliquaryofSouls
			name = BB["Reliquary of Souls"],
			npcId = 22856,
			[P25_DIFF] = {
				{ 1, 32353 },	-- Gloves of Unfailing Faith
				{ 2, 32351 },	-- Elunite Empowered Bracers
				{ 3, 32347 },	-- Grips of Damnation
				{ 4, 32352 },	-- Naturewarden's Treads
				{ 5, 32517 },	-- The Wavemender's Mantle
				{ 6, 32346 },	-- Boneweave Girdle
				{ 7, 32354 },	-- Crown of Empowered Fate
				{ 8, 32345 },	-- Dreadboots of the Legion
				{ 16, 32349 },	-- Translucent Spellthread Necklace
				{ 17, 32362 },	-- Pendant of Titans
				{ 19, 32332 },	-- Torch of the Damned
				{ 20, 32363 },	-- Naaru-Blessed Life Rod
				{ 21, 32350 },	-- Touch of Inspiration
			},
		},
		{	--BTGorefiend
			name = BB["Teron Gorefiend"],
			npcId = 22871,
			[P25_DIFF] = {
				{ 1, 32323 },	-- Shadowmoon Destroyer's Drape
				{ 2, 32329 },	-- Cowl of Benevolence
				{ 3, 32327 },	-- Robe of the Shadow Council
				{ 4, 32324 },	-- Insidious Bands
				{ 5, 32328 },	-- Botanist's Gloves of Growth
				{ 6, 32510 },	-- Softstep Boots of Tracking
				{ 7, 32280 },	-- Gauntlets of Enforcement
				{ 8, 32512 },	-- Girdle of Lordaeron's Fallen
				{ 16, 32348 },	-- Soul Cleaver
				{ 17, 32325 },	-- Rifle of the Stoic Guardian
			},
		},
		{	--BTShahraz
			name = BB["Mother Shahraz"],
			npcId = 22947,
			[P25_DIFF] = {
				{ 1, 32367 },	-- Leggings of Devastation
				{ 2, 32366 },	-- Shadowmaster's Boots
				{ 3, 32365 },	-- Heartshatter Breastplate
				{ 4, 32370 },	-- Nadina's Pendant of Purity
				{ 5, 32369 },	-- Blade of Savagery
				{ 16, 31101 },	-- Pauldrons of the Forgotten Conqueror
				{ 17, 31103 },	-- Pauldrons of the Forgotten Protector
				{ 18, 31102 },	-- Pauldrons of the Forgotten Vanquisher
			},
		},
		{	--BTCouncil
			name = BB["The Illidari Council"],
			npcId = 23426,
			[P25_DIFF] = {
				{ 1, 32331 },	-- Cloak of the Illidari Council
				{ 2, 32519 },	-- Belt of Divine Guidance
				{ 3, 32518 },	-- Veil of Turning Leaves
				{ 4, 32376 },	-- Forest Prowler's Helm
				{ 5, 32373 },	-- Helm of the Illidari Shatterer
				{ 6, 32505 },	-- Madness of the Betrayer
				{ 16, 31098 },	-- Leggings of the Forgotten Conqueror
				{ 17, 31100 },	-- Leggings of the Forgotten Protector
				{ 18, 31099 },	-- Leggings of the Forgotten Vanquisher
			},
		},
		{	--BTIllidanStormrage
			name = BB["Illidan Stormrage"],
			npcId = 22917,
			[P25_DIFF] = {
				{ 1, 32524 },	-- Shroud of the Highborne
				{ 2, 32525 },	-- Cowl of the Illidari High Lord
				{ 3, 32235 },	-- Cursed Vision of Sargeras
				{ 4, 32521 },	-- Faceplate of the Impenetrable
				{ 6, 32497 },	-- Stormrage Signet Ring
				{ 7, 32483 },	-- The Skull of Gul'dan
				{ 8, 32496 },	-- Memento of Tyrande
				{ 10, 32837 },	-- Warglaive of Azzinoth
				{ 11, 32838 },	-- Warglaive of Azzinoth
				{ 16, 31089 },	-- Chestguard of the Forgotten Conqueror
				{ 17, 31091 },	-- Chestguard of the Forgotten Protector
				{ 18, 31090 },	-- Chestguard of the Forgotten Vanquisher
				{ 20, 32471 },	-- Shard of Azzinoth
				{ 21, 32500 },	-- Crystal Spire of Karabor
				{ 22, 32374 },	-- Zhar'doom, Greatstaff of the Devourer
				{ 23, 32375 },	-- Bulwark of Azzinoth
				{ 24, 32336 },	-- Black Bow of the Betrayer
				{ 26, "ac697" },
			},
		},
		{	--BTTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 32590 },	-- Nethervoid Cloak
				{ 2, 34012 },	-- Shroud of the Final Stand
				{ 3, 32609 },	-- Boots of the Divine Light
				{ 4, 32593 },	-- Treads of the Den Mother
				{ 5, 32592 },	-- Chestguard of Relentless Storms
				{ 6, 32608 },	-- Pillager's Gauntlets
				{ 7, 32606 },	-- Girdle of the Lightbearer
				{ 8, 32591 },	-- Choker of Serrated Blades
				{ 9, 32589 },	-- Hellfire-Encased Pendant
				{ 10, 32526 },	-- Band of Devastation
				{ 11, 32528 },	-- Blessed Band of Karabor
				{ 12, 32527 },	-- Ring of Ancient Knowledge
				{ 16, 34009 },	-- Hammer of Judgement
				{ 17, 32943 },	-- Swiftsteel Bludgeon
				{ 18, 34011 },	-- Illidari Runeshield
				{ 20, 32228 },	-- Empyrean Sapphire
				{ 21, 32231 },	-- Pyrestone
				{ 22, 32229 },	-- Lionseye
				{ 23, 32249 },	-- Seaspray Emerald
				{ 24, 32230 },	-- Shadowsong Amethyst
				{ 25, 32227 },	-- Crimson Spinel
				{ 27, 32428 },	-- Heart of Darkness
				{ 28, 32897 },	-- Mark of the Illidari
			},
		},
		{	--BTPatterns
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 141)..")",
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 32738 },	-- Plans: Dawnsteel Bracers
				{ 2, 32739 },	-- Plans: Dawnsteel Shoulders
				{ 3, 32736 },	-- Plans: Swiftsteel Bracers
				{ 4, 32737 },	-- Plans: Swiftsteel Shoulders
				{ 5, 32748 },	-- Pattern: Bindings of Lightning Reflexes
				{ 6, 32744 },	-- Pattern: Bracers of Renewed Life
				{ 7, 32750 },	-- Pattern: Living Earth Bindings
				{ 8, 32751 },	-- Pattern: Living Earth Shoulders
				{ 9, 32749 },	-- Pattern: Shoulders of Lightning Reflexes
				{ 10, 32745 },	-- Pattern: Shoulderpads of Renewed Life
				{ 11, 32746 },	-- Pattern: Swiftstrike Bracers
				{ 12, 32747 },	-- Pattern: Swiftstrike Shoulders
				{ 16, 32754 },	-- Pattern: Bracers of Nimble Thought
				{ 17, 32755 },	-- Pattern: Mantle of Nimble Thought
				{ 18, 32753 },	-- Pattern: Swiftheal Mantle
				{ 19, 32752 },	-- Pattern: Swiftheal Wraps
			},
		},
		{	--Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:12",
		},
		{	--Ashtongue
			FactionID = 1012,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:1:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["GruulsLair"] = {
	name = ALIL["Gruul's Lair"],
	MapID = 776,
	ContentType = RAID_CONTENT,
	items = {
		{	--GruulsLairHighKingMaulgar
			name = BB["High King Maulgar"],
			[P25_DIFF] = {
				{ 1, 28797 },	-- Brute Cloak of the Ogre-Magi
				{ 2, 28799 },	-- Belt of Divine Inspiration
				{ 3, 28796 },	-- Malefic Mask of the Shadows
				{ 4, 28801 },	-- Maulgar's Warhelm
				{ 5, 28795 },	-- Bladespire Warbands
				{ 6, 28800 },	-- Hammer of the Naaru
				{ 16, 29763 },	-- Pauldrons of the Fallen Champion
				{ 17, 29764 },	-- Pauldrons of the Fallen Defender
				{ 18, 29762 },	-- Pauldrons of the Fallen Hero
			},
		},
		{	--GruulGruul
			name = BB["Gruul the Dragonkiller"],
			[P25_DIFF] = {
				{ 1, 28804 },	-- Collar of Cho'gall
				{ 2, 28803 },	-- Cowl of Nature's Breath
				{ 3, 28828 },	-- Gronn-Stitched Girdle
				{ 4, 28827 },	-- Gauntlets of the Dragonslayer
				{ 5, 28810 },	-- Windshear Boots
				{ 6, 28824 },	-- Gauntlets of Martial Perfection
				{ 7, 28822 },	-- Teeth of Gruul
				{ 8, 28823 },	-- Eye of Gruul
				{ 9, 28830 },	-- Dragonspine Trophy
				{ 16, 29766 },	-- Leggings of the Fallen Champion
				{ 17, 29767 },	-- Leggings of the Fallen Defender
				{ 18, 29765 },	-- Leggings of the Fallen Hero
				{ 20, 28802 },	-- Bloodmaw Magus-Blade
				{ 21, 28794 },	-- Axe of the Gronn Lords
				{ 22, 28825 },	-- Aldori Legacy Defender
				{ 24, "ac692" },
			},
		},
		{	--Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:14:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["CoTHyjal"] = {
	name = ALIL["Hyjal Summit"],
	MapID = 775,
	ContentType = RAID_CONTENT,
	items = {
		{	--MountHyjalWinterchill
			name = BB["Rage Winterchill"],
			[P25_DIFF] = {
				{ 1, 30871 },	-- Bracers of Martyrdom
				{ 2, 30870 },	-- Cuffs of Devastation
				{ 3, 30863 },	-- Deadly Cuffs
				{ 4, 30868 },	-- Rejuvenating Bracers
				{ 5, 30864 },	-- Bracers of the Pathfinder
				{ 6, 30869 },	-- Howling Wind Bracers
				{ 7, 30873 },	-- Stillwater Boots
				{ 8, 30866 },	-- Blood-stained Pauldrons
				{ 9, 30862 },	-- Blessed Adamantite Bracers
				{ 10, 30861 },	-- Furious Shackles
				{ 16, 30865 },	-- Tracker's Blade
				{ 17, 30872 },	-- Chronicle of Dark Secrets
				{ 19, 32459 },	-- Time-Phased Phylactery
			},
		},
		{	--MountHyjalAnetheron
			name = BB["Anetheron"],
			[P25_DIFF] = {
				{ 1, 30884 },	-- Hatefury Mantle
				{ 2, 30888 },	-- Anetheron's Noose
				{ 3, 30885 },	-- Archbishop's Slippers
				{ 4, 30879 },	-- Don Alejandro's Money Belt
				{ 5, 30886 },	-- Enchanted Leather Sandals
				{ 6, 30887 },	-- Golden Links of Restoration
				{ 7, 30880 },	-- Quickstrider Moccasins
				{ 8, 30878 },	-- Glimmering Steel Mantle
				{ 16, 30874 },	-- The Unbreakable Will
				{ 17, 30881 },	-- Blade of Infamy
				{ 18, 30883 },	-- Pillar of Ferocity
				{ 19, 30882 },	-- Bastion of Light
			},
		},
		{	--MountHyjalKazrogal
			name = BB["Kaz'rogal"],
			[P25_DIFF] = {
				{ 1, 30895 },	-- Angelista's Sash
				{ 2, 30916 },	-- Leggings of Channeled Elements
				{ 3, 30894 },	-- Blue Suede Shoes
				{ 4, 30917 },	-- Razorfury Mantle
				{ 5, 30914 },	-- Belt of the Crescent Moon
				{ 6, 30891 },	-- Black Featherlight Boots
				{ 7, 30892 },	-- Beast-Tamer's Shoulders
				{ 8, 30919 },	-- Valestalker Girdle
				{ 9, 30893 },	-- Sun-Touched Chain Leggings
				{ 10, 30915 },	-- Belt of Seething Fury
				{ 16, 30918 },	-- Hammer of Atonement
				{ 17, 30889 },	-- Kaz'rogal's Hardened Heart
			},
		},
		{	--MountHyjalAzgalor
			name = BB["Azgalor"],
			[P25_DIFF] = {
				{ 1, 30899 },	-- Don Rodrigo's Poncho
				{ 2, 30898 },	-- Shady Dealer's Pantaloons
				{ 3, 30900 },	-- Bow-Stitched Leggings
				{ 4, 30896 },	-- Glory of the Defender
				{ 5, 30897 },	-- Girdle of Hope
				{ 6, 30901 },	-- Boundless Agony
				{ 16, 31092 },	-- Gloves of the Forgotten Conqueror
				{ 17, 31094 },	-- Gloves of the Forgotten Protector
				{ 18, 31093 },	-- Gloves of the Forgotten Vanquisher
			},
		},
		{	--MountHyjalArchimonde
			name = BB["Archimonde"],
			[P25_DIFF] = {
				{ 1, 30913 },	-- Robes of Rhonin
				{ 2, 30912 },	-- Leggings of Eternity
				{ 3, 30905 },	-- Midnight Chestguard
				{ 4, 30907 },	-- Mail of Fevered Pursuit
				{ 5, 30904 },	-- Savior's Grasp
				{ 6, 30903 },	-- Legguards of Endless Rage
				{ 7, 30911 },	-- Scepter of Purification
				{ 9, 30910 },	-- Tempest of Chaos
				{ 10, 30902 },	-- Cataclysm's Edge
				{ 11, 30908 },	-- Apostle of Argus
				{ 12, 30909 },	-- Antonidas' Aegis of Rapt Concentration
				{ 13, 30906 },	-- Bristleblitz Striker
				{ 16, 31097 },	-- Helm of the Forgotten Conqueror
				{ 17, 31095 },	-- Helm of the Forgotten Protector
				{ 18, 31096 },	-- Helm of the Forgotten Vanquisher
				{ 20, "ac695" },
			},
		},
		{	--MountHyjalTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 32590 },	-- Nethervoid Cloak
				{ 2, 34010 },	-- Pepe's Shroud of Pacification
				{ 3, 32609 },	-- Boots of the Divine Light
				{ 4, 32592 },	-- Chestguard of Relentless Storms
				{ 5, 32591 },	-- Choker of Serrated Blades
				{ 6, 32589 },	-- Hellfire-Encased Pendant
				{ 7, 34009 },	-- Hammer of Judgement
				{ 8, 32946 },	-- Claw of Molten Fury
				{ 9, 32945 },	-- Fist of Molten Fury
				{ 11, 32428 },	-- Heart of Darkness
				{ 12, 32897 },	-- Mark of the Illidari
				{ 16, 32285 },	-- Design: Flashing Crimson Spinel
				{ 17, 32289 },	-- Design: Stormy Empyrean Sapphire
				{ 18, 32295 },	-- Design: Mystic Lionseye
				{ 19, 32303 },	-- Design: Inscribed Pyrestone
				{ 20, 32298 },	-- Design: Shifting Shadowsong Amethyst
				{ 21, 32297 },	-- Design: Sovereign Shadowsong Amethyst
				{ 22, 32307 },	-- Design: Veiled Shadowsong Amethyst
			},
		},
		{	--Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:12",
		},
		{	--ScaleSands
			FactionID = 990,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:17:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["Karazhan"] = {
	name = ALIL["Karazhan"],
	MapID = 799,
	ContentType = RAID_CONTENT,
	items = {
		{	--KaraNamed
			name = AL["Servant's Quarter Animal Bosses"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, BB["Hyakiss the Lurker"], nil },
				{ 2, 30675 },	-- Lurker's Cord
				{ 3, 30676 },	-- Lurker's Grasp
				{ 4, 30677 },	-- Lurker's Belt
				{ 5, 30678 },	-- Lurker's Girdle
				{ 7, "INV_Box_01", nil, BB["Rokad the Ravager"], nil },
				{ 8, 30684 },	-- Ravager's Cuffs
				{ 9, 30685 },	-- Ravager's Wrist-Wraps
				{ 10, 30686 },	-- Ravager's Bands
				{ 11, 30687 },	-- Ravager's Bracers
				{ 16, "INV_Box_01", nil, BB["Shadikith the Glider"], nil },
				{ 17, 30680 },	-- Glider's Foot-Wraps
				{ 18, 30681 },	-- Glider's Boots
				{ 19, 30682 },	-- Glider's Sabatons
				{ 20, 30683 },	-- Glider's Greaves
			},
		},
		{	--KaraAttumen
			name = BB["Attumen the Huntsman"],
			[NORMAL_DIFF] = {
				{ 1, 28477 },	-- Harbinger Bands
				{ 2, 28507 },	-- Handwraps of Flowing Thought
				{ 3, 28508 },	-- Gloves of Saintly Blessings
				{ 4, 28453 },	-- Bracers of the White Stag
				{ 5, 28506 },	-- Gloves of Dexterous Manipulation
				{ 6, 28503 },	-- Whirlwind Bracers
				{ 7, 28454 },	-- Stalker's War Bands
				{ 8, 28502 },	-- Vambraces of Courage
				{ 9, 28505 },	-- Gauntlets of Renewed Hope
				{ 16, 28509 },	-- Worgen Claw Necklace
				{ 17, 28510 },	-- Spectral Band of Innervation
				{ 19, 28504 },	-- Steelhawk Crossbow
				{ 21, 30480, "mount" },	-- Fiery Warhorse's Reins
				{ 23, 23809 },	-- Schematic: Stabilized Eternium Scope
			},
		},
		{	--KaraMoroes
			name = BB["Moroes"],
			[NORMAL_DIFF] = {
				{ 1, 28529 },	-- Royal Cloak of Arathi Kings
				{ 2, 28570 },	-- Shadow-Cloak of Dalaran
				{ 3, 28565 },	-- Nethershard Girdle
				{ 4, 28545 },	-- Edgewalker Longboots
				{ 5, 28567 },	-- Belt of Gale Force
				{ 6, 28566 },	-- Crimson Girdle of the Indomitable
				{ 7, 28569 },	-- Boots of Valiance
				{ 16, 28530 },	-- Brooch of Unquenchable Fury
				{ 17, 28528 },	-- Moroes' Lucky Pocket Watch
				{ 19, 28524 },	-- Emerald Ripper
				{ 20, 28525 },	-- Signet of Unshakable Faith
				{ 22, 22559 },	-- Formula: Enchant Weapon - Mongoose
			},
		},
		{	--KaraMaiden
			name = BB["Maiden of Virtue"],
			[NORMAL_DIFF] = {
				{ 1, 28511 },	-- Bands of Indwelling
				{ 2, 28515 },	-- Bands of Nefarious Deeds
				{ 3, 28517 },	-- Boots of Foretelling
				{ 4, 28514 },	-- Bracers of Maliciousness
				{ 5, 28521 },	-- Mitts of the Treemender
				{ 6, 28520 },	-- Gloves of Centering
				{ 7, 28519 },	-- Gloves of Quickening
				{ 8, 28512 },	-- Bracers of Justice
				{ 9, 28518 },	-- Iron Gauntlets of the Maiden
				{ 16, 28516 },	-- Barbed Choker of Discipline
				{ 18, 28522 },	-- Shard of the Virtuous
			},
		},
		{	--KaraOperaEvent
			name = BB["Opera Event"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["Shared"], nil },
				{ 2, 28594 },	-- Trial-Fire Trousers
				{ 3, 28591 },	-- Earthsoul Leggings
				{ 4, 28589 },	-- Beastmaw Pauldrons
				{ 5, 28593 },	-- Eternium Greathelm
				{ 6, 28590 },	-- Ribbon of Sacrifice
				{ 8, "INV_Box_01", nil, BB["The Crone"], nil },
				{ 9, 28586 },	-- Wicked Witch's Hat
				{ 10, 28585 },	-- Ruby Slippers
				{ 11, 28587 },	-- Legacy
				{ 12, 28588 },	-- Blue Diamond Witchwand
				{ 16, "INV_Box_01", nil, BB["Romulo & Julianne"], nil },
				{ 17, 28578 },	-- Masquerade Gown
				{ 18, 28579 },	-- Romulo's Poison Vial
				{ 19, 28572 },	-- Blade of the Unrequited
				{ 20, 28573 },	-- Despair
				{ 23, "INV_Box_01", nil, BB["The Big Bad Wolf"], nil },
				{ 24, 28582 },	-- Red Riding Hood's Cloak
				{ 25, 28583 },	-- Big Bad Wolf's Head
				{ 26, 28584 },	-- Big Bad Wolf's Paw
				{ 27, 28581 },	-- Wolfslayer Sniper Rifle
				{ 28, 97548, "pet1226" },	-- Spiky Collar
			},
		},
		{	--KaraNightbane
			name = BB["Nightbane"],
			[NORMAL_DIFF] = {
				{ 1, 28602 },	-- Robe of the Elder Scribes
				{ 2, 28600 },	-- Stonebough Jerkin
				{ 3, 28601 },	-- Chestguard of the Conniver
				{ 4, 28599 },	-- Scaled Breastplate of Carnage
				{ 5, 28610 },	-- Ferocious Swift-Kickers
				{ 6, 28597 },	-- Panzar'Thar Breastplate
				{ 7, 28608 },	-- Ironstriders of Urgency
				{ 9, 24139 },	-- Faint Arcane Essence
				{ 16, 28609 },	-- Emberspur Talisman
				{ 18, 28604 },	-- Nightstaff of the Everliving
				{ 19, 28611 },	-- Dragonheart Flameshield
				{ 20, 28606 },	-- Shield of Impenetrable Darkness
				{ 21, 28603 },	-- Talisman of Nightbane
			},
		},
		{	--KaraCurator
			name = BB["The Curator"],
			[NORMAL_DIFF] = {
				{ 1, 28612 },	-- Pauldrons of the Solace-Giver
				{ 2, 28647 },	-- Forest Wind Shoulderpads
				{ 3, 28631 },	-- Dragon-Quake Shoulderguards
				{ 4, 28621 },	-- Wrynn Dynasty Greaves
				{ 5, 28649 },	-- Garona's Signet Ring
				{ 6, 28633 },	-- Staff of Infinite Mysteries
				{ 16, 29757 },	-- Gloves of the Fallen Champion
				{ 17, 29758 },	-- Gloves of the Fallen Defender
				{ 18, 29756 },	-- Gloves of the Fallen Hero
				{ 20, 97549, "pet1227" },	-- Instant Arcane Sanctum Security Kit
			},
		},
		{	--KaraIllhoof
			name = BB["Terestian Illhoof"],
			[NORMAL_DIFF] = {
				{ 1, 28660 },	-- Gilded Thorium Cloak
				{ 2, 28653 },	-- Shadowvine Cloak of Infusion
				{ 3, 28652 },	-- Cincture of Will
				{ 4, 28654 },	-- Malefic Girdle
				{ 5, 28655 },	-- Cord of Nature's Sustenance
				{ 6, 28656 },	-- Girdle of the Prowler
				{ 7, 28662 },	-- Breastplate of the Lightbinder
				{ 16, 28661 },	-- Mender's Heart-Ring
				{ 17, 28785 },	-- The Lightning Capacitor
				{ 19, 28657 },	-- Fool's Bane
				{ 20, 28658 },	-- Terestian's Stranglestaff
				{ 22, 97551, "pet1229" },	-- Satyr Charm
				{ 24, 22561 },	-- Formula: Enchant Weapon - Soulfrost
			},
		},
		{	--KaraAran
			name = BB["Shade of Aran"],
			[NORMAL_DIFF] = {
				{ 1, 28672 },	-- Drape of the Dark Reavers
				{ 2, 28726 },	-- Mantle of the Mind Flayer
				{ 3, 28670 },	-- Boots of the Infernal Coven
				{ 4, 28663 },	-- Boots of the Incorrupt
				{ 5, 28669 },	-- Rapscallion Boots
				{ 6, 28671 },	-- Steelspine Faceguard
				{ 7, 28666 },	-- Pauldrons of the Justice-Seeker
				{ 9, 23933 },	-- Medivh's Journal
				{ 16, 28674 },	-- Saberclaw Talisman
				{ 17, 28675 },	-- Shermanar Great-Ring
				{ 18, 28727 },	-- Pendant of the Violet Eye
				{ 20, 28673 },	-- Tirisfal Wand of Ascendancy
				{ 21, 28728 },	-- Aran's Soothing Sapphire
				{ 23, 22560 },	-- Formula: Enchant Weapon - Sunfire
			},
		},
		{	--KaraNetherspite
			name = BB["Netherspite"],
			[NORMAL_DIFF] = {
				{ 1, 28744 },	-- Uni-Mind Headdress
				{ 2, 28742 },	-- Pantaloons of Repentence
				{ 3, 28732 },	-- Cowl of Defiance
				{ 4, 28741 },	-- Skulker's Greaves
				{ 5, 28735 },	-- Earthblood Chestguard
				{ 6, 28740 },	-- Rip-Flayer Leggings
				{ 7, 28743 },	-- Mantle of Abrahmis
				{ 8, 28733 },	-- Girdle of Truth
				{ 16, 28731 },	-- Shining Chain of the Afterworld
				{ 17, 28730 },	-- Mithril Band of the Unscarred
				{ 19, 28729 },	-- Spiteblade
				{ 20, 28734 },	-- Jewel of Infinite Possibilities
			},
		},
		{	--KaraChess
			name = BB["Chess Event"],
			[NORMAL_DIFF] = {
				{ 1, 28756 },	-- Headdress of the High Potentate
				{ 2, 28755 },	-- Bladed Shoulderpads of the Merciless
				{ 3, 28750 },	-- Girdle of Treachery
				{ 4, 28752 },	-- Forestlord Striders
				{ 5, 28751 },	-- Heart-Flame Leggings
				{ 6, 28746 },	-- Fiend Slayer Boots
				{ 7, 28748 },	-- Legplates of the Innocent
				{ 8, 28747 },	-- Battlescar Boots
				{ 16, 28745 },	-- Mithril Chain of Heroism
				{ 17, 28753 },	-- Ring of Recurrence
				{ 19, 28749 },	-- King's Defender
				{ 20, 28754 },	-- Triptych Shield of the Ancients
			},
		},
		{	--KaraPrince
			name = BB["Prince Malchezaar"],
			[NORMAL_DIFF] = {
				{ 1, 28765 },	-- Stainless Cloak of the Pure Hearted
				{ 2, 28766 },	-- Ruby Drape of the Mysticant
				{ 3, 28764 },	-- Farstrider Wildercloak
				{ 4, 28762 },	-- Adornment of Stolen Souls
				{ 5, 28763 },	-- Jade Ring of the Everliving
				{ 6, 28757 },	-- Ring of a Thousand Marks
				{ 8, 28770 },	-- Nathrezim Mindblade
				{ 9, 28768 },	-- Malchazeen
				{ 10, 28767 },	-- The Decapitator
				{ 11, 28773 },	-- Gorehowl
				{ 12, 28771 },	-- Light's Justice
				{ 13, 28772 },	-- Sunfury Bow of the Phoenix
				{ 16, 29760 },	-- Helm of the Fallen Champion
				{ 17, 29761 },	-- Helm of the Fallen Defender
				{ 18, 29759 },	-- Helm of the Fallen Hero
				{ 20, 97550, "pet1228" },	-- Netherspace Portal-Stone
				{ 22, "ac690" },
			},
		},
		{	--KaraTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 30642 },	-- Drape of the Righteous
				{ 2, 30668 },	-- Grasp of the Dead
				{ 3, 30673 },	-- Inferno Waist Cord
				{ 4, 30644 },	-- Grips of Deftness
				{ 5, 30674 },	-- Zierhut's Lost Treads
				{ 6, 30643 },	-- Belt of the Tracker
				{ 7, 30641 },	-- Boots of Elusion
				{ 9, 23857 },	-- Legacy of the Mountain King
				{ 10, 23864 },	-- Torment of the Worgen
				{ 11, 23862 },	-- Redemption of the Fallen
				{ 12, 23865 },	-- Wrath of the Titans
				{ 14, 21882 },	-- Soul Essence
				{ 16, 30666 },	-- Ritssyn's Lost Pendant
				{ 17, 30667 },	-- Ring of Unrelenting Storms
				{ 19, 21903 },	-- Pattern: Soulcloth Shoulders
				{ 20, 21904 },	-- Pattern: Soulcloth Vest
				{ 21, 22545 },	-- Formula: Enchant Boots - Surefooted
				{ 23, 24492 },	-- Keanna's Log
			},
		},
		{	--Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:14",
		},
		{	--TheVioletEye
			FactionID = 967,
			CoinTexture = "Reputation",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Factions:BCFACTIONS:20",
		},
		BC_RAID_AC_TABLE,
	}
}

data["HCMagtheridonsLair"] = {
	name = ALIL["Magtheridon's Lair"],
	MapID = 779,
	ContentType = RAID_CONTENT,
	items = {
		{	--HCMagtheridon
			name = BB["Magtheridon"],
			[P25_DIFF] = {
				{ 1, 28777 },	-- Cloak of the Pit Stalker
				{ 2, 28780 },	-- Soul-Eater's Handwraps
				{ 3, 28776 },	-- Liar's Tongue Gloves
				{ 4, 28778 },	-- Terror Pit Girdle
				{ 5, 28775 },	-- Thundering Greathelm
				{ 6, 28779 },	-- Girdle of the Endless Pit
				{ 7, 28789 },	-- Eye of Magtheridon
				{ 9, 28774 },	-- Glaive of the Pit
				{ 10, 28782 },	-- Crystalheart Pulse-Staff
				{ 11, 29458 },	-- Aegis of the Vindicator
				{ 12, 28783 },	-- Eredar Wand of Obliteration
				{ 13, 28781 },	-- Karaborian Talisman
				{ 15, 34846 },	-- Black Sack of Gems
				{ 16, 29754 },	-- Chestguard of the Fallen Champion
				{ 17, 29753 },	-- Chestguard of the Fallen Defender
				{ 18, 29755 },	-- Chestguard of the Fallen Hero
				{ 20, 32385 },	-- Magtheridon's Head
				{ 21, 28791 },	-- Ring of the Recalcitrant
				{ 22, 28790 },	-- Naaru Lightwarden's Band
				{ 23, 28793 },	-- Band of Crimson Fury
				{ 24, 28792 },	-- A'dal's Signet of Defense
				{ 26, 34845 },	-- Pit Lord's Satchel
				{ 28, "ac693" },
			},
		},
		{	--Tier 4 Sets
			name = format(AL["Tier %d Sets"], 4),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:14:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["CFRSerpentshrineCavern"] = {
	name = ALIL["Serpentshrine Cavern"],
	MapID = 780,
	ContentType = RAID_CONTENT,
	items = {
		{	--CFRSerpentHydross
			name = BB["Hydross the Unstable"],
			[P25_DIFF] = {
				{ 1, 30056 },	-- Robe of Hateful Echoes
				{ 2, 32516 },	-- Wraps of Purification
				{ 3, 30050 },	-- Boots of the Shifting Nightmare
				{ 4, 30055 },	-- Shoulderpads of the Stranger
				{ 5, 30047 },	-- Blackfathom Warbands
				{ 6, 30054 },	-- Ranger-General's Chestguard
				{ 7, 30048 },	-- Brighthelm of Justice
				{ 8, 30053 },	-- Pauldrons of the Wardancer
				{ 16, 30052 },	-- Ring of Lethality
				{ 17, 33055 },	-- Band of Vile Aggression
				{ 18, 30664 },	-- Living Root of the Wildheart
				{ 19, 30629 },	-- Scarab of Displacement
				{ 21, 30049 },	-- Fathomstone
				{ 23, 97553, "pet1231" },	-- Tainted Core
			},
		},
		{	--CFRSerpentLurker
			name = BB["The Lurker Below"],
			[P25_DIFF] = {
				{ 1, 30064 },	-- Cord of Screaming Terrors
				{ 2, 30067 },	-- Velvet Boots of the Guardian
				{ 3, 30062 },	-- Grove-Bands of Remulos
				{ 4, 30060 },	-- Boots of Effortless Striking
				{ 5, 30066 },	-- Tempest-Strider Boots
				{ 6, 30065 },	-- Glowing Breastplate of Truth
				{ 7, 30057 },	-- Bracers of Eradication
				{ 16, 30059 },	-- Choker of Animalistic Fury
				{ 17, 30061 },	-- Ancestral Ring of Conquest
				{ 18, 33054 },	-- The Seal of Danzalar
				{ 19, 30665 },	-- Earring of Soulful Meditation
				{ 21, 30058 },	-- Mallet of the Tides
			},
		},
		{	--CFRSerpentLeotheras
			name = BB["Leotheras the Blind"],
			[P25_DIFF] = {
				{ 1, 30092 },	-- Orca-Hide Boots
				{ 2, 30097 },	-- Coral-Barbed Shoulderpads
				{ 3, 30091 },	-- True-Aim Stalker Bands
				{ 4, 30096 },	-- Girdle of the Invulnerable
				{ 5, 30627 },	-- Tsunami Talisman
				{ 6, 30095 },	-- Fang of the Leviathan
				{ 16, 30239 },	-- Gloves of the Vanquished Champion
				{ 17, 30240 },	-- Gloves of the Vanquished Defender
				{ 18, 30241 },	-- Gloves of the Vanquished Hero
			},
		},
		{	--CFRSerpentKarathress
			name = BB["Fathom-Lord Karathress"],
			[P25_DIFF] = {
				{ 1, 30100 },	-- Soul-Strider Boots
				{ 2, 30101 },	-- Bloodsea Brigand's Vest
				{ 3, 30099 },	-- Frayed Tether of the Drowned
				{ 4, 30663 },	-- Fathom-Brooch of the Tidewalker
				{ 5, 30626 },	-- Sextant of Unstable Currents
				{ 6, 30090 },	-- World Breaker
				{ 16, 30245 },	-- Leggings of the Vanquished Champion
				{ 17, 30246 },	-- Leggings of the Vanquished Defender
				{ 18, 30247 },	-- Leggings of the Vanquished Hero
			},
		},
		{	--CFRSerpentMorogrim
			name = BB["Morogrim Tidewalker"],
			[P25_DIFF] = {
				{ 1, 30098 },	-- Razor-Scale Battlecloak
				{ 2, 30079 },	-- Illidari Shoulderpads
				{ 3, 30075 },	-- Gnarled Chestpiece of the Ancients
				{ 4, 30085 },	-- Mantle of the Tireless Tracker
				{ 5, 30068 },	-- Girdle of the Tidal Call
				{ 6, 30084 },	-- Pauldrons of the Argent Sentinel
				{ 7, 30081 },	-- Warboots of Obliteration
				{ 16, 30008 },	-- Pendant of the Lost Ages
				{ 17, 30083 },	-- Ring of Sundered Souls
				{ 18, 33058 },	-- Band of the Vigilant
				{ 19, 30720 },	-- Serpent-Coil Braid
				{ 21, 30082 },	-- Talon of Azshara
				{ 22, 30080 },	-- Luminescent Rod of the Naaru
				{ 24, 97552, "pet1230" },	-- Shell of Tide-Calling
			},
		},
		{	--CFRSerpentVashj
			name = BB["Lady Vashj"],
			[P25_DIFF] = {
				{ 1, 30107 },	-- Vestments of the Sea-Witch
				{ 2, 30111 },	-- Runetotem's Mantle
				{ 3, 30106 },	-- Belt of One-Hundred Deaths
				{ 4, 30104 },	-- Cobra-Lash Boots
				{ 5, 30102 },	-- Krakken-Heart Breastplate
				{ 6, 30112 },	-- Glorious Gauntlets of Crestfall
				{ 7, 30109 },	-- Ring of Endless Coils
				{ 8, 30110 },	-- Coral Band of the Revived
				{ 9, 30621 },	-- Prism of Inner Calm
				{ 10, 30103 },	-- Fang of Vashj
				{ 11, 30108 },	-- Lightfathom Scepter
				{ 12, 30105 },	-- Serpent Spine Longbow
				{ 16, 30242 },	-- Helm of the Vanquished Champion
				{ 17, 30243 },	-- Helm of the Vanquished Defender
				{ 18, 30244 },	-- Helm of the Vanquished Hero
				{ 20, 97554, "pet1232" },	-- Dripping Strider Egg
				{ 22, 29906 },	-- Vashj's Vial Remnant
				{ 24, "ac694" },
			},
		},
		{	--CFRSerpentTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 30027 },	-- Boots of Courage Unending
				{ 2, 30022 },	-- Pendant of the Perilous
				{ 3, 30620 },	-- Spyglass of the Hidden Fleet
				{ 5, 30021 },	-- Wildfury Greatstaff
				{ 7, 30324 },	-- Plans: Red Havoc Boots
				{ 8, 30322 },	-- Plans: Red Belt of Battle
				{ 9, 30323 },	-- Plans: Boots of the Protector
				{ 10, 30321 },	-- Plans: Belt of the Guardian
				{ 11, 30280 },	-- Pattern: Belt of Blasting
				{ 12, 30282 },	-- Pattern: Boots of Blasting
				{ 13, 30283 },	-- Pattern: Boots of the Long Road
				{ 14, 30281 },	-- Pattern: Belt of the Long Road
				{ 16, 30308 },	-- Pattern: Hurricane Boots
				{ 17, 30304 },	-- Pattern: Monsoon Belt
				{ 18, 30305 },	-- Pattern: Boots of Natural Grace
				{ 19, 30307 },	-- Pattern: Boots of the Crimson Hawk
				{ 20, 30306 },	-- Pattern: Boots of Utter Darkness
				{ 21, 30301 },	-- Pattern: Belt of Natural Power
				{ 22, 30303 },	-- Pattern: Belt of the Black Eagle
				{ 23, 30302 },	-- Pattern: Belt of Deep Shadow
				{ 25, 30183 },	-- Nether Vortex
				{ 27, 32897 },	-- Mark of the Illidari
			},
		},
		{	--Tier 5 Sets
			name = format(AL["Tier %d Sets"], 5),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:13",
		},
		{	--CExpedition
			FactionID = 942,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:2:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["SunwellPlateau"] = {
	name = ALIL["Sunwell Plateau"],
	MapID = 789,
	ContentType = RAID_CONTENT,
	items = {
		{	--SPKalecgos
			name = BB["Kalecgos"],
			[P25_DIFF] = {
				{ 1, 34170 },	-- Pantaloons of Calming Strife
				{ 2, 34386 },	-- Pantaloons of Growing Strife
				{ 3, 34169 },	-- Breeches of Natural Aggression
				{ 4, 34384 },	-- Breeches of Natural Splendor
				{ 5, 34168 },	-- Starstalker Legguards
				{ 6, 34167 },	-- Legplates of the Holy Juggernaut
				{ 7, 34382 },	-- Judicator's Legguards
				{ 8, 34166 },	-- Band of Lucent Beams
				{ 9, 34165 },	-- Fang of Kalecgos
				{ 10, 34164 },	-- Dragonscale-Encrusted Longblade
				{ 16, 34848 },	-- Bracers of the Forgotten Conqueror
				{ 17, 34851 },	-- Bracers of the Forgotten Protector
				{ 18, 34852 },	-- Bracers of the Forgotten Vanquisher
			},
		},
		{	--SPBrutallus
			name = BB["Brutallus"],
			[P25_DIFF] = {
				{ 1, 34181 },	-- Leggings of Calamity
				{ 2, 34180 },	-- Felfury Legplates
				{ 3, 34381 },	-- Felstrength Legplates
				{ 4, 34178 },	-- Collar of the Pit Lord
				{ 5, 34177 },	-- Clutch of Demise
				{ 6, 34176 },	-- Reign of Misery
				{ 7, 34179 },	-- Heart of the Pit
				{ 16, 34853 },	-- Belt of the Forgotten Conqueror
				{ 17, 34854 },	-- Belt of the Forgotten Protector
				{ 18, 34855 },	-- Belt of the Forgotten Vanquisher
			},
		},
		{	--SPFelmyst
			name = BB["Felmyst"],
			[P25_DIFF] = {
				{ 1, 34352 },	-- Borderland Fortress Grips
				{ 2, 34188 },	-- Leggings of the Immortal Night
				{ 3, 34385 },	-- Leggings of the Immortal Beast
				{ 4, 34186 },	-- Chain Links of the Tumultuous Storm
				{ 5, 34383 },	-- Kilt of Spiritual Reconstruction
				{ 6, 34184 },	-- Brooch of the Highborne
				{ 7, 34185 },	-- Sword Breaker's Bulwark
				{ 8, 34182 },	-- Grand Magister's Staff of Torrents
				{ 16, 34856 },	-- Boots of the Forgotten Conqueror
				{ 17, 34857 },	-- Boots of the Forgotten Protector
				{ 18, 34858 },	-- Boots of the Forgotten Vanquisher
			},
		},
		{	--SPEredarTwins
			name = BB["The Eredar Twins"],
			[P25_DIFF] = {
				{ 1, 34205 },	-- Shroud of Redeemed Souls
				{ 2, 34190 },	-- Crimson Paragon's Cover
				{ 3, 34210 },	-- Amice of the Convoker
				{ 4, 34202 },	-- Shawl of Wonderment
				{ 5, 34393 },	-- Shoulderpads of Knowledge's Pursuit
				{ 6, 34209 },	-- Spaulders of Reclamation
				{ 7, 34391 },	-- Spaulders of Devastation
				{ 8, 34195 },	-- Shoulderpads of Vehemence
				{ 9, 34392 },	-- Demontooth Shoulderpads
				{ 10, 34194 },	-- Mantle of the Golden Forest
				{ 11, 34208 },	-- Equilibrium Epaulets
				{ 12, 34390 },	-- Erupting Epaulets
				{ 13, 34192 },	-- Pauldrons of Perseverance
				{ 14, 34388 },	-- Pauldrons of Berserking
				{ 16, 34193 },	-- Spaulders of the Thalassian Savior
				{ 17, 34389 },	-- Spaulders of the Thalassian Defender
				{ 18, 35290 },	-- Sin'dorei Pendant of Conquest
				{ 19, 35291 },	-- Sin'dorei Pendant of Salvation
				{ 20, 35292 },	-- Sin'dorei Pendant of Triumph
				{ 21, 34204 },	-- Amulet of Unfettered Magics
				{ 22, 34189 },	-- Band of Ruinous Delight
				{ 23, 34197 },	-- Shiv of Exsanguination
				{ 24, 34199 },	-- Archon's Gavel
				{ 25, 34203 },	-- Grip of Mannoroth
				{ 26, 34198 },	-- Stanchion of Primal Instinct
				{ 27, 34196 },	-- Golden Bow of Quel'Thalas
				{ 28, 34206 },	-- Book of Highborne Hymns
			},
		},
		{	--SPMuru
			name = BB["M'uru"],
			[P25_DIFF] = {
				{ 1, 34232 },	-- Fel Conquerer Raiments
				{ 2, 34233 },	-- Robes of Faltered Light
				{ 3, 34399 },	-- Robes of Ghostly Hatred
				{ 4, 34212 },	-- Sunglow Vest
				{ 5, 34398 },	-- Utopian Tunic of Elune
				{ 6, 34211 },	-- Harness of Carnal Instinct
				{ 7, 34397 },	-- Bladed Chaos Tunic
				{ 8, 34234 },	-- Shadowed Gauntlets of Paroxysm
				{ 9, 34408 },	-- Gloves of the Forest Drifter
				{ 10, 34229 },	-- Garments of Serene Shores
				{ 11, 34396 },	-- Garments of Crashing Shores
				{ 12, 34228 },	-- Vicious Hawkstrider Hauberk
				{ 13, 34215 },	-- Warharness of Reckless Fury
				{ 14, 34394 },	-- Breastplate of Agony's Aversion
				{ 15, 34240 },	-- Gauntlets of the Soothed Soul
				{ 16, 34216 },	-- Heroic Judicator's Chestguard
				{ 17, 34395 },	-- Noble Judicator's Chestguard
				{ 18, 34213 },	-- Ring of Hardened Resolve
				{ 19, 34230 },	-- Ring of Omnipotence
				{ 20, 35282 },	-- Sin'dorei Band of Dominance
				{ 21, 35283 },	-- Sin'dorei Band of Salvation
				{ 22, 35284 },	-- Sin'dorei Band of Triumph
				{ 23, 34427 },	-- Blackened Naaru Sliver
				{ 24, 34430 },	-- Glimmering Naaru Sliver
				{ 25, 34429 },	-- Shifting Naaru Sliver
				{ 26, 34428 },	-- Steely Naaru Sliver
				{ 27, 34214 },	-- Muramasa
				{ 28, 34231 },	-- Aegis of Angelic Fortune
			},
		},
		{	--SPKiljaeden
			name = BB["Kil'jaeden"],
			[P25_DIFF] = {
				{ 1, 34241 },	-- Cloak of Unforgivable Sin
				{ 2, 34242 },	-- Tattered Cape of Antonidas
				{ 3, 34339 },	-- Cowl of Light's Purity
				{ 4, 34405 },	-- Helm of Arcane Purity
				{ 5, 34340 },	-- Dark Conjuror's Collar
				{ 6, 34342 },	-- Handguards of the Dawn
				{ 7, 34406 },	-- Gloves of Tyri's Power
				{ 8, 34344 },	-- Handguards of Defiled Worlds
				{ 9, 34244 },	-- Duplicitous Guise
				{ 10, 34404 },	-- Mask of the Fury Hunter
				{ 11, 34245 },	-- Cover of Ursol the Wise
				{ 12, 34403 },	-- Cover of Ursoc the Mighty
				{ 13, 34333 },	-- Coif of Alleria
				{ 14, 34332 },	-- Cowl of Gul'dan
				{ 15, 34402 },	-- Shroud of Chieftain Ner'zhul
				{ 16, 34343 },	-- Thalassian Ranger Gauntlets
				{ 17, 34243 },	-- Helm of Burning Righteousness
				{ 18, 34401 },	-- Helm of Uther's Resolve
				{ 19, 34345 },	-- Crown of Anasterian
				{ 20, 34400 },	-- Crown of Dath'Remar
				{ 21, 34341 },	-- Borderland Paingrips
				{ 23, 34334 },	-- Thori'dal, the Stars' Fury
				{ 24, 34329 },	-- Crux of the Apocalypse
				{ 25, 34247 },	-- Apolyon, the Soul-Render
				{ 26, 34335 },	-- Hammer of Sanctification
				{ 27, 34331 },	-- Hand of the Deceiver
				{ 28, 34336 },	-- Sunflare
				{ 29, 34337 },	-- Golden Staff of the Sin'dorei
				{ 30, "ac698" },
			},
		},
		{	--SPTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 34351 },	-- Tranquil Majesty Wraps
				{ 2, 34407 },	-- Tranquil Moonlight Wraps
				{ 3, 34350 },	-- Gauntlets of the Ancient Shadowmoon
				{ 4, 34409 },	-- Gauntlets of the Ancient Frostwolf
				{ 5, 35733 },	-- Ring of Harmonic Beauty
				{ 6, 34183 },	-- Shivering Felspine
				{ 7, 34346 },	-- Mounting Vengeance
				{ 8, 34348 },	-- Wand of Cleansing Light
				{ 9, 34347 },	-- Wand of the Demonsoul
				{ 11, 35273 },	-- Study of Advanced Smelting
				{ 13, 34664 },	-- Sunmote
				{ 16, 32228 },	-- Empyrean Sapphire
				{ 17, 32231 },	-- Pyrestone
				{ 18, 32229 },	-- Lionseye
				{ 19, 32249 },	-- Seaspray Emerald
				{ 20, 32230 },	-- Shadowsong Amethyst
				{ 21, 32227 },	-- Crimson Spinel
				{ 23, 35208 },	-- Plans: Sunblessed Gauntlets
				{ 24, 35210 },	-- Plans: Sunblessed Breastplate
				{ 25, 35209 },	-- Plans: Hard Khorium Battlefists
				{ 26, 35211 },	-- Plans: Hard Khorium Battleplate
			},
		},
		{	--SPPatterns
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 159)..")",
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 35212 },	-- Pattern: Leather Gauntlets of the Sun
				{ 2, 35216 },	-- Pattern: Leather Chestguard of the Sun
				{ 3, 35213 },	-- Pattern: Fletcher's Gloves of the Phoenix
				{ 4, 35217 },	-- Pattern: Embrace of the Phoenix
				{ 5, 35214 },	-- Pattern: Gloves of Immortal Dusk
				{ 6, 35218 },	-- Pattern: Carapace of Sun and Shadow
				{ 7, 35215 },	-- Pattern: Sun-Drenched Scale Gloves
				{ 8, 35219 },	-- Pattern: Sun-Drenched Scale Chestguard
				{ 9, 35204 },	-- Pattern: Sunfire Handwraps
				{ 10, 35206 },	-- Pattern: Sunfire Robe
				{ 11, 35205 },	-- Pattern: Hands of Eternal Light
				{ 12, 35207 },	-- Pattern: Robe of Eternal Light
				{ 13, 35198 },	-- Design: Loop of Forged Power
				{ 14, 35201 },	-- Design: Pendant of Sunfire
				{ 15, 35199 },	-- Design: Ring of Flowing Life
				{ 16, 35202 },	-- Design: Amulet of Flowing Life
				{ 17, 35200 },	-- Design: Hard Khorium Band
				{ 18, 35203 },	-- Design: Hard Khorium Choker
				{ 19, 35186 },	-- Schematic: Annihilator Holo-Gogs
				{ 20, 35187 },	-- Schematic: Justicebringer 3000 Specs
				{ 21, 35189 },	-- Schematic: Powerheal 9000 Lens
				{ 22, 35190 },	-- Schematic: Hyper-Magnified Moon Specs
				{ 23, 35191 },	-- Schematic: Wonderheal XT68 Shades
				{ 24, 35192 },	-- Schematic: Primal-Attuned Goggles
				{ 25, 35193 },	-- Schematic: Lightning Etched Specs
				{ 26, 35194 },	-- Schematic: Surestrike Goggles v3.0
				{ 27, 35195 },	-- Schematic: Mayhem Projection Goggles
				{ 28, 35196 },	-- Schematic: Hard Khorium Goggles
				{ 29, 35197 },	-- Schematic: Quad Deathblow X44 Goggles
			},
		},
		{	--Tier 6 Sets
			name = format(AL["Tier %d Sets"], 6),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:12",
		},
		BC_RAID_AC_TABLE,
	}
}

data["TempestKeepTheEye"] = {
	name = ALIL["Tempest Keep"],
	MapID = 782,
	ContentType = RAID_CONTENT,
	items = {
		{	--TKEyeAlar
			name = BB["Al'ar"],
			[P25_DIFF] = {
				{ 1, 29925 },	-- Phoenix-Wing Cloak
				{ 2, 29918 },	-- Mindstorm Wristbands
				{ 3, 29947 },	-- Gloves of the Searing Grip
				{ 4, 29921 },	-- Fire Crest Breastplate
				{ 5, 29922 },	-- Band of Al'ar
				{ 6, 29920 },	-- Phoenix-Ring of Rebirth
				{ 7, 30448 },	-- Talon of Al'ar
				{ 8, 30447 },	-- Tome of Fiery Redemption
				{ 16, 32944 },	-- Talon of the Phoenix
				{ 17, 29948 },	-- Claw of the Phoenix
				{ 18, 29924 },	-- Netherbane
				{ 19, 29949 },	-- Arcanite Steam-Pistol
				{ 20, 29923 },	-- Talisman of the Sun King
				{ 22, 97557, "pet1235" },	-- Brilliant Phoenix Hawk Feather
			},
		},
		{	--TKEyeVoidReaver
			name = BB["Void Reaver"],
			[P25_DIFF] = {
				{ 1, 29986 },	-- Cowl of the Grand Engineer
				{ 2, 29984 },	-- Girdle of Zaetar
				{ 3, 29985 },	-- Void Reaver Greaves
				{ 4, 29983 },	-- Fel-Steel Warhelm
				{ 5, 32515 },	-- Wristguards of Determination
				{ 6, 30619 },	-- Fel Reaver's Piston
				{ 7, 30450 },	-- Warp-Spring Coil
				{ 16, 30248 },	-- Pauldrons of the Vanquished Champion
				{ 17, 30249 },	-- Pauldrons of the Vanquished Defender
				{ 18, 30250 },	-- Pauldrons of the Vanquished Hero
				{ 20, 97555, "pet1233" },	-- Tiny Fel Engine Key
			},
		},
		{	--TKEyeSolarian
			name = BB["High Astromancer Solarian"],
			[P25_DIFF] = {
				{ 1, 29977 },	-- Star-Soul Breeches
				{ 2, 29972 },	-- Trousers of the Astromancer
				{ 3, 29966 },	-- Vambraces of Ending
				{ 4, 29976 },	-- Worldstorm Gauntlets
				{ 5, 29951 },	-- Star-Strider Boots
				{ 6, 29965 },	-- Girdle of the Righteous Path
				{ 7, 29950 },	-- Greaves of the Bloodwarder
				{ 8, 32267 },	-- Boots of the Resilient
				{ 16, 30446 },	-- Solarian's Sapphire
				{ 17, 30449 },	-- Void Star Talisman
				{ 19, 29962 },	-- Heartrazor
				{ 20, 29981 },	-- Ethereum Life-Staff
				{ 21, 29982 },	-- Wand of the Forgotten Star
				{ 23, 97556, "pet1234" },	-- Crystal of the Void
			},
		},
		{	--TKEyeKaelthas
			name = BB["Kael'thas Sunstrider"],
			[P25_DIFF] = {
				{ 1, 29992 },	-- Royal Cloak of the Sunstriders
				{ 2, 29989 },	-- Sunshower Light Cloak
				{ 3, 29994 },	-- Thalassian Wildercloak
				{ 4, 29990 },	-- Crown of the Sun
				{ 5, 29987 },	-- Gauntlets of the Sun King
				{ 6, 29995 },	-- Leggings of Murderous Intent
				{ 7, 29991 },	-- Sunhawk Leggings
				{ 8, 29998 },	-- Royal Gauntlets of Silvermoon
				{ 9, 29997 },	-- Band of the Ranger-General
				{ 10, 29993 },	-- Twinblade of the Phoenix
				{ 11, 29996 },	-- Rod of the Sun King
				{ 12, 29988 },	-- The Nexus Key
				{ 16, 30236 },	-- Chestguard of the Vanquished Champion
				{ 17, 30237 },	-- Chestguard of the Vanquished Defender
				{ 18, 30238 },	-- Chestguard of the Vanquished Hero
				{ 20, 32458, "mount" },	-- Ashes of Al'ar
				{ 22, 32405 },	-- Verdant Sphere
				{ 23, 30018 },	-- Lord Sanguinar's Claim
				{ 24, 30017 },	-- Telonicus' Pendant of Mayhem
				{ 25, 30007 },	-- The Darkener's Grasp
				{ 26, 30015 },	-- The Sun King's Talisman
				{ 28, 29905 },	-- Kael's Vial Remnant
				{ 30, "ac696" },
			},
		},
		{	--TKEyeTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[P25_DIFF] = {
				{ 1, 30024 },	-- Mantle of the Elven Kings
				{ 2, 30020 },	-- Fire-Cord of the Magus
				{ 3, 30029 },	-- Bark-Gloves of Ancient Wisdom
				{ 4, 30026 },	-- Bands of the Celestial Archer
				{ 5, 30030 },	-- Girdle of Fallen Stars
				{ 6, 30028 },	-- Seventh Ring of the Tirisfalen
				{ 8, 30324 },	-- Plans: Red Havoc Boots
				{ 9, 30322 },	-- Plans: Red Belt of Battle
				{ 10, 30323 },	-- Plans: Boots of the Protector
				{ 11, 30321 },	-- Plans: Belt of the Guardian
				{ 12, 30280 },	-- Pattern: Belt of Blasting
				{ 13, 30282 },	-- Pattern: Boots of Blasting
				{ 14, 30283 },	-- Pattern: Boots of the Long Road
				{ 15, 30281 },	-- Pattern: Belt of the Long Road
				{ 16, 30308 },	-- Pattern: Hurricane Boots
				{ 17, 30304 },	-- Pattern: Monsoon Belt
				{ 18, 30305 },	-- Pattern: Boots of Natural Grace
				{ 19, 30307 },	-- Pattern: Boots of the Crimson Hawk
				{ 20, 30306 },	-- Pattern: Boots of Utter Darkness
				{ 21, 30301 },	-- Pattern: Belt of Natural Power
				{ 22, 30303 },	-- Pattern: Belt of the Black Eagle
				{ 23, 30302 },	-- Pattern: Belt of Deep Shadow
				{ 25, 30183 },	-- Nether Vortex
				{ 27, 32897 },	-- Mark of the Illidari
			},
		},
		{	--Tier 5 Sets
			name = format(AL["Tier %d Sets"], 5),
			ExtraList = true,
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:13",
		},
		{	--Shatar
			FactionID = 935,
			ExtraList = true,
			CoinTexture = "Reputation",
			[P25_DIFF] = "AtlasLoot_Factions:BCFACTIONS:19:n",
		},
		BC_RAID_AC_TABLE,
	}
}

data["WorldBossesBC"] = {
	name = AL["World Bosses"],
	ContentType = RAID_CONTENT,
	items = {
		{	--DoomLordKazzak
			name = BB["Doom Lord Kazzak"],
			[NORMAL_DIFF] = {
				{ 1, 30735 },	-- Ancient Spellcloak of the Highborne
				{ 2, 30734 },	-- Leggings of the Seventh Circle
				{ 3, 30737 },	-- Gold-Leaf Wildboots
				{ 4, 30739 },	-- Scaled Greaves of the Marksman
				{ 5, 30740 },	-- Ripfiend Shoulderplates
				{ 6, 30741 },	-- Topaz-Studded Battlegrips
				{ 16, 30736 },	-- Ring of Flowing Light
				{ 17, 30738 },	-- Ring of Reciprocity
				{ 19, 30733 },	-- Hope Ender
				{ 20, 30732 },	-- Exodar Life-Staff
			},
		},
		{	--Doomwalker
			name = BB["Doomwalker"],
			[NORMAL_DIFF] = {
				{ 1, 30729 },	-- Black-Iron Battlecloak
				{ 2, 30725 },	-- Anger-Spark Gloves
				{ 3, 30727 },	-- Gilded Trousers of Benediction
				{ 4, 30730 },	-- Terrorweave Tunic
				{ 5, 30728 },	-- Fathom-Helm of the Deeps
				{ 6, 30731 },	-- Faceguard of the Endless Watch
				{ 16, 30726 },	-- Archaic Charm of Presence
				{ 18, 30723 },	-- Talon of the Tempest
				{ 19, 30722 },	-- Ethereum Nexus-Reaver
				{ 20, 30724 },	-- Barrel-Blade Longrifle
			},
		},
	}
}