local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname, 1)

local EJ_GetEncounterInfo = EJ_GetEncounterInfo

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales
local BB = AtlasLoot.LibBabble:Get("LibBabble-Boss-3.0")

local RF_DIFF = data:AddDifficulty(AL["Raid Finder"], "rf", nil, 17)
local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", nil, 1)
local HEROIC_DIFF = data:AddDifficulty(AL["Heroic"], "h", nil, 2)
local P25_DIFF = data:AddDifficulty(AL["25 Player"], "p25", nil, 4)
local REMOVED_DIFF = data:AddDifficulty(AL["Removed"], "removed")

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local AC_ITTYPE = data:AddItemTableType("Achievement")
local REMOVED_ITTYPE = data:AddItemTableType("Item", "Droprate")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local DUNGEON_CONTENT = data:AddContentType(AL["Dungeons"], ATLASLOOT_DUNGEON_COLOR)
local RAID_CONTENT = data:AddContentType(AL["Raids"], ATLASLOOT_RAID_COLOR)
local REMOVED_CONTENT = data:AddContentType(AL["Removed"], ATLASLOOT_REMOVED_COLOR)

-- Shared loot tables
local CLASSIC_INSTANCE_AC_TABLE = {	--[Classic Dungeonmaster]
	name = select(2, GetAchievementInfo(1283)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1283 },
		{ 2, 628 },			{ 17, 629 },
		{ 3, 630 },			{ 18, 631 },
		{ 4, 632 },			{ 19, 633 },
		{ 5, 634 },			{ 20, 635 },
		{ 6, 636 },			{ 21, 637 },
		{ 7, 638 },			{ 22, 639 },
		{ 8, 640 },			{ 23, 641 },
		{ 9, 642 },			{ 24, 643 },
		{ 10, 644 },			{ 25, 645 },
		{ 11, 646 }
	},
}

local CLASSIC_RAID_AC_TABLE = {	--[Classic Raider]
	name = select(2, GetAchievementInfo(1285)),
	TableType = AC_ITTYPE,
	ExtraList = true,
	CoinTexture = "Achievement",
	[NORMAL_DIFF] = {
		{ 1, 1285 },
		{ 2, 685 },			{ 17, 686 },
		{ 3, 687 },			{ 18, 689 },
	},
}

local BLACKFATHON_DEEPS_LOOT1 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(368), nil },	--Ghamoo-ra
	{ 2, 6908 },	-- Ghamoo-Ra's Bind
	{ 3, 6907 },	-- Tortoise Armor
	{ 5, "INV_Box_01", nil, EJ_GetEncounterInfo(436), nil },	--Domina
	{ 6, 888 },	-- Naga Battle Gloves
	{ 7, 11121 },	-- Darkwater Talwar
	{ 8, 3078 },	-- Naga Heartpiercer
	{ 10, "INV_Box_01", nil, EJ_GetEncounterInfo(426), nil },	--Subjugator Kor'ul
	{ 11, 6906 },	-- Algae Fists
	{ 12, 6905 },	-- Reef Axe
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(1145), nil },	--Thruk
	{ 17, 120165 },	-- Thruk's Fillet Knife
	{ 18, 120164 },	-- Thruk's Heavy Duty Fishing Pole
	{ 19, 120163 },	-- Thruk's Fishing Rod
	{ 21, "INV_Box_01", nil, EJ_GetEncounterInfo(447), nil },	--Guardian of the Deep
	{ 22, 6901 },	-- Glowing Thresher Cape
	{ 23, 6902 },	-- Bands of Serra'kis
	{ 24, 6904 },	-- Bite of Serra'kis
	{ 26, "INV_Box_01", nil, EJ_GetEncounterInfo(1144), nil },	--Executioner Gore
	{ 27, 120167 },	-- Bloody Twilight Cloak
	{ 28, 120166 },	-- Gorestained Garb
}
local BLACKFATHON_DEEPS_LOOT2 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(437), nil },	--Twilight Lord Bathiel
	{ 2, 6903 },	-- Gaze Dreamer Pants
	{ 3, 1155 },	-- Rod of the Sleepwalker
	{ 5, "INV_Box_01", nil, EJ_GetEncounterInfo(444), nil },	--Aku'mai
	{ 6, 6910 },	-- Leech Pants
	{ 7, 6911 },	-- Moss Cinch
	{ 8, 6909 },	-- Strike of the Hydra
	{ 10, "ac632" },
	{ 16, "INV_Box_01", nil, AL["Trash Mobs"], nil },
	{ 17, 1486 },	-- Tree Bark Jacket
	{ 18, 3416 },	-- Martyr's Chain
	{ 19, 1491 },	-- Ring of Precision
	{ 20, 3413 },	-- Doomspike
	{ 21, 2567 },	-- Evocator's Blade
	{ 22, 3417 },	-- Onyx Claymore
	{ 23, 1454 },	-- Axe of the Enforcer
	{ 24, 1481 },	-- Grimclaw
	{ 25, 3414 },	-- Crested Scepter
	{ 26, 3415 },	-- Staff of the Friar
	{ 27, 2271 },	-- Staff of the Blessed Seer
}
data["BlackfathomDeeps"] = {
	EncounterJournalID = 227,
	MapID = 688,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Ghamoo-ra
			EncounterJournalID = 368,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT1,
		},
		{	--Domina
			EncounterJournalID = 436,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT1,
		},
		{	--Subjugator Kor'ul
			EncounterJournalID = 426,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT1,
		},
		{	--Throk
			EncounterJournalID = 1145,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT1,
		},
		{	--Guardian of the Deep
			EncounterJournalID = 447,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT1,
		},
		{	--Executioner Gore
			EncounterJournalID = 1144,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT1,
		},
		{	--Twilight Lord Bathiel
			EncounterJournalID = 437,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT2,
		},
		{	--Aku'mai
			EncounterJournalID = 444,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT2,
		},
		{	--Trash Mobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = BLACKFATHON_DEEPS_LOOT2,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["BlackrockDepths"] = {
	EncounterJournalID = 228,
	MapID = 704,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--BRDHighInterrogatorGerstahn
			EncounterJournalID = 369,
			[NORMAL_DIFF] = {
				{ 1, 11626 },	-- Blackveil Cape
				{ 2, 11624 },	-- Kentic Amice
				{ 3, 22240 },	-- Greaves of Withering Despair
				{ 4, 11625 },	-- Enthralled Sphere
			},
		},
		{	--BRDLordRoccor
			EncounterJournalID = 370,
			[NORMAL_DIFF] = {
				{ 1, 22234 },	-- Mantle of Lost Hope
				{ 2, 11632 },	-- Earthslag Shoulders
				{ 3, 11631 },	-- Stoneshell Guard
				{ 16, 45050, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Smoking Heart of the Mountain
				{ 17, 11811, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Smoking Heart of the Mountain
			},
		},
		{	--BRDHoundmaster
			EncounterJournalID = 371,
			[NORMAL_DIFF] = {
				{ 1, 11623 },	-- Spritecaster Cape
				{ 2, 11627 },	-- Fleetfoot Greaves
				{ 3, 11628 },	-- Houndmaster's Bow
				{ 4, 11629 },	-- Houndmaster's Rifle
			},
		},
		{	--BRDBaelGar
			EncounterJournalID = 377,
			[NORMAL_DIFF] = {
				{ 1, 11807 },	-- Sash of the Burning Heart
				{ 2, 11802 },	-- Lavacrest Leggings
				{ 3, 11805 },	-- Rubidium Hammer
				{ 4, 11803 },	-- Force of Magma
			},
		},
		{	--BRDLordIncendius
			EncounterJournalID = 374,
			[NORMAL_DIFF] = {
				{ 1, 11766 },	-- Flameweave Cuffs
				{ 2, 11764 },	-- Cinderhide Armsplints
				{ 3, 11765 },	-- Pyremail Wristguards
				{ 4, 11767 },	-- Emberplate Armguards
				{ 16, 19268, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ace of Elementals
			},
		},
		{	--BRDFineousDarkvire
			EncounterJournalID = 376,
			[NORMAL_DIFF] = {
				{ 1, 11839 },	-- Chief Architect's Monocle
				{ 2, 11841 },	-- Senior Designer's Pantaloons
				{ 3, 11842 },	-- Lead Surveyor's Mantle
				{ 4, 22223 },	-- Foreman's Head Protector
				{ 6, 11840, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Master Builder's Shirt
			},
		},
		{	--BRDTheVault
			name = AL["The Vault"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, AL["The Vault"], nil },
				{ 2, 11309 },	-- The Heart of the Mountain
				{ 4, "INV_Box_01", nil, AL["The Secret Safe"], nil },
				{ 5, 22256 },	-- Mana Shaping Handwraps
				{ 8, 22205 },	-- Black Steel Bindings
				{ 9, 22255 },	-- Magma Forged Band
				{ 12, 22254 },	-- Wand of Eternal Light
				{ 16, "INV_Box_01", nil, BB["Dark Coffer"], nil },
				{ 17, 11752 },	-- Black Blood of the Tormented
				{ 18, 11751 },	-- Burning Essence
				{ 19, 11753 },	-- Eye of Kajal
			},
		},
		{	--BRDWarderStilgiss
			EncounterJournalID = 375,
			[NORMAL_DIFF] = {
				{ 1, 11782 },	-- Boreal Mantle
				{ 2, 22241 },	-- Dark Warder's Pauldrons
				{ 3, 11783 },	-- Chillsteel Girdle
				{ 4, 11784 },	-- Arbiter's Blade
			},
		},
		{	--BRDVerek
			name = BB["Verek"],
			[NORMAL_DIFF] = {
				{ 1, 22242 },	-- Verek's Leash
				{ 2, 11755 },	-- Verek's Collar
			},
		},
		{	--BRDPyromantLoregrain
			EncounterJournalID = 373,
			[NORMAL_DIFF] = {
				{ 1, 11747 },	-- Flamestrider Robes
				{ 2, 11749 },	-- Searingscale Leggings
				{ 3, 11750 },	-- Kindling Stave
				{ 4, 11748 },	-- Pyric Caduceus
				{ 16, 11207, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Formula: Enchant Weapon - Fiery Weapon
				{ 18, 63469, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Breath of Cenarius
				{ 19, 64305, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Loregrain's Grimoire
			},
		},
		{	--BRDArena
			EncounterJournalID = 372,
			[NORMAL_DIFF] = {
				{ 1, 11677 },	-- Graverot Cape
				{ 2, 11675 },	-- Shadefiend Boots
				{ 3, 11731 },	-- Savage Gladiator Greaves
				{ 4, 11678 },	-- Carapace of Anub'shiah
				{ 6, 11685 },	-- Splinthide Shoulders
				{ 7, 11686 },	-- Girdle of Beastial Fury
				{ 8, 11679 },	-- Rubicund Armguards
				{ 9, 11730 },	-- Savage Gladiator Grips
				{ 11, 11726 },	-- Savage Gladiator Chain
				{ 12, 22271 },	-- Leggings of Frenzied Magic
				{ 13, 22257 },	-- Bloodclot Band
				{ 14, 22266 },	-- Flarethorn
				{ 16, 11722 },	-- Dregmetal Spaulders
				{ 17, 11703 },	-- Stonewall Girdle
				{ 18, 22270 },	-- Entrenching Boots
				{ 19, 11702 },	-- Grizzle's Skinner
				{ 20, 11610 },	-- Plans: Dark Iron Pulverizer
				{ 22, 11634 },	-- Silkweb Gloves
				{ 23, 11729 },	-- Savage Gladiator Helm
				{ 24, 11633 },	-- Spiderfang Carapace
				{ 25, 11635 },	-- Hookfang Shanker
				{ 27, 11662 },	-- Ban'thok Sash
				{ 28, 11665 },	-- Ogreseer Fists
				{ 29, 11728 },	-- Savage Gladiator Leggings
				{ 30, 11824 },	-- Cyclopean Band
			},
		},
		{	--BRDGeneralAngerforge
			EncounterJournalID = 378,
			[NORMAL_DIFF] = {
				{ 1, 11821 },	-- Warstrife Leggings
				{ 2, 11820 },	-- Royal Decorated Armor
				{ 3, 11810 },	-- Force of Will
				{ 4, 11817 },	-- Lord General's Sword
				{ 5, 11816 },	-- Angerforge's Battle Axe
				{ 16, 64302, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- General's Attack Plans
			},
		},
		{	--BRDGolemLordArgelmach
			EncounterJournalID = 379,
			[NORMAL_DIFF] = {
				{ 1, 11822 },	-- Omnicast Boots
				{ 2, 11823 },	-- Luminary Kilt
				{ 3, 11669 },	-- Naglering
				{ 4, 11819 },	-- Second Wind
				{ 16, 21956, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Dark Iron Scorpid
				{ 18, 64303, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Elemental Golem Blueprints
			},
		},
		{	--BRDGuzzler
			name = AL["The Grim Guzzler"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(380), nil },	--Hurley Blackbreath
				{ 2, 11735 },	-- Ragefury Eyepatch
				{ 3, 18043 },	-- Coal Miner Boots
				{ 4, 22275 },	-- Firemoss Boots
				{ 5, 18044 },	-- Hurley's Tankard
				{ 6, 11312 },	-- Lost Thunderbrew Recipe
				{ 8, "INV_Box_01", nil, EJ_GetEncounterInfo(381), nil },	--Phalanx
				{ 9, 22212 },	-- Golem Fitted Pauldrons
				{ 10, 11745 },	-- Fists of Phalanx
				{ 11, 11744 },	-- Bloodfist
				{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(382), nil },	--Ribbly Screwspigot
				{ 17, 11612 },	-- Plans: Dark Iron Plate
				{ 18, 11742 },	-- Wayfarer's Knapsack
				{ 20, "INV_Box_01", nil, EJ_GetEncounterInfo(383), nil },	--Plugger Spazzring
				{ 21, 12793 },	-- Mixologist's Tunic
				{ 22, 12791 },	-- Barman Shanker
				{ 23, 13483 },	-- Recipe: Transmute Fire to Earth
				{ 24, 18653 },	-- Schematic: Goblin Jumper Cables XL
				{ 25, 15759 },	-- Pattern: Black Dragonscale Breastplate
				{ 26, 11602 },	-- Grim Guzzler Key
				{ 27, 11325 },	-- Dark Iron Ale Mug
			},
		},
		{	--BRDFlamelash
			EncounterJournalID = 384,
			[NORMAL_DIFF] = {
				{ 1, 11808 },	-- Circle of Flame
				{ 3, 11812 },	-- Cape of the Fire Salamander
				{ 4, 11814 },	-- Molten Fists
				{ 5, 11832 },	-- Burst of Knowledge
				{ 6, 11809 },	-- Flame Wrath
			},
		},
		{	--BRDPanzor
			name = BB["Panzor the Invincible"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 22245 },	-- Soot Encrusted Footwear
				{ 2, 11787 },	-- Shalehusk Boots
				{ 3, 11786 },	-- Stone of the Earth
				{ 4, 11785 },	-- Rock Golem Bulwark
			},
		},
		{	--BRDTomb
			EncounterJournalID = 385,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, BB["Chest of The Seven"], nil },
				{ 2, 11929 },	-- Haunting Specter Leggings
				{ 3, 11925 },	-- Ghostshroud
				{ 4, 11926 },	-- Deathdealer Breastplate
				{ 5, 11927 },	-- Legplates of the Eternal Guardian
				{ 6, 11922 },	-- Blood-Etched Blade
				{ 7, 11920 },	-- Wraith Scythe
				{ 8, 11923 },	-- The Hammer of Grace
				{ 9, 11921 },	-- Impervious Giant
			},
		},
		{	--BRDMagmus
			EncounterJournalID = 386,
			[NORMAL_DIFF] = {
				{ 1, 11746 },	-- Golem Skull Helm
				{ 2, 11935 },	-- Magmus Stone
				{ 3, 22208 },	-- Lavastone Hammer
			},
		},
		{	--BRDImperatorDagranThaurissan
			EncounterJournalID = 387,
			[NORMAL_DIFF] = {
				{ 1, 11684 },	-- Ironfoe
				{ 3, 11930 },	-- The Emperor's New Cape
				{ 4, 11924 },	-- Robes of the Royal Crown
				{ 5, 22204 },	-- Wristguards of Renown
				{ 6, 22207 },	-- Sash of the Grand Hunt
				{ 7, 11933 },	-- Imperial Jewel
				{ 8, 11934 },	-- Emperor's Seal
				{ 9, 11815 },	-- Hand of Justice
				{ 16, 11931 },	-- Dreadforge Retaliator
				{ 17, 11932 },	-- Guiding Stave of Wisdom
				{ 18, 11928 },	-- Thaurissan's Royal Scepter
				{ 20, 12033, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Thaurissan Family Jewels
				{ 22, "ac642" },
			},
		},
		{	--BRDPrincess
			name = BB["Princess Moira Bronzebeard"],
			[NORMAL_DIFF] = {
				{ 1, 12554 },	-- Hands of the Exalted Herald
				{ 2, 12556 },	-- High Priestess Boots
				{ 3, 12557 },	-- Ebonsteel Spaulders
				{ 4, 12553 },	-- Swiftwalker Boots
			},
		},
		{	--BRDTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 12552 },	-- Blisterbane Wrap
				{ 2, 12551 },	-- Stoneshield Cloak
				{ 3, 12542 },	-- Funeral Pyre Vestment
				{ 4, 12546 },	-- Aristocratic Cuffs
				{ 5, 12550 },	-- Runed Golem Shackles
				{ 6, 12547 },	-- Mar Alom's Grip
				{ 7, 12549 },	-- Braincage
				{ 8, 12555 },	-- Battlechaser's Greaves
				{ 9, 12531 },	-- Searing Needle
				{ 10, 12535 },	-- Doomforged Straightedge
				{ 11, 12527 },	-- Ribsplitter
				{ 12, 12528 },	-- The Judge's Gavel
				{ 13, 12532 },	-- Spire of the Stoneshaper
				{ 16, 15781 },	-- Pattern: Black Dragonscale Leggings
				{ 17, 15770 },	-- Pattern: Black Dragonscale Shoulders
				{ 18, 16053 },	-- Schematic: Master Engineer's Goggles
				{ 19, 16049 },	-- Schematic: Dark Iron Bomb
				{ 20, 16048 },	-- Schematic: Dark Iron Rifle
				{ 21, 18654 },	-- Schematic: Gnomish Alarm-o-Bot
				{ 22, 18661 },	-- Schematic: World Enlarger
				{ 24, 11754 },	-- Black Diamond
				{ 25, 11078 },	-- Relic Coffer Key
				{ 26, 18945 },	-- Dark Iron Residue
				{ 27, 64304 },	-- Elemental Module
				{ 28, 64313 },	-- Elemental-Imbued Weapon
			},
		},
		{	--Miscellaneous Sets
			name = AL["Miscellaneous"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:4",
		},
		{	--BrewfestCorenDirebrew
			name = BB["Coren Direbrew"].." ("..AL["Brewfest"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:Brewfest:1",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["Deadmines"] = {
	EncounterJournalID = 63,
	MapID = 756,
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--DeadminesGlubtok
			EncounterJournalID = 89,
			[NORMAL_DIFF] = {
				{ 1, 5444 },	-- Miner's Cape
				{ 2, 5195 },	-- Gold-Flecked Gloves
				{ 3, 2169 },	-- Buzzer Blade
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesGearbreaker
			EncounterJournalID = 90,
			[NORMAL_DIFF] = {
				{ 1, 5199 },	-- Smelting Pants
				{ 2, 5191 },	-- Cruel Barb
				{ 3, 5200 },	-- Impaling Harpoon
				{ 4, 5443 },	-- Gold-Plated Buckler
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesFoeReaper
			EncounterJournalID = 91,
			[NORMAL_DIFF] = {
				{ 1, 1937 },	-- Buzz Saw
				{ 2, 5187 },	-- Foe Reaper
				{ 3, 5201 },	-- Emberstone Staff
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesRipsnarl
			EncounterJournalID = 92,
			[NORMAL_DIFF] = {
				{ 1, 1156 },	-- Lavishly Jeweled Ring
				{ 2, 5196 },	-- Smite's Reaver
				{ 3, 872 },	-- Rockslicer
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesCookie
			EncounterJournalID = 93,
			[NORMAL_DIFF] = {
				{ 1, 5193 },	-- Cape of the Brotherhood
				{ 2, 5202 },	-- Corsair's Overshirt
				{ 3, 5192 },	-- Thief's Blade
				{ 4, 5197 },	-- Cookie's Tenderizer
				{ 5, 5198 },	-- Cookie's Stirring Rod
				{ 16, "ac628" },
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--DeadminesTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 1930 },	-- Stonemason Cloak
				{ 2, 1951 },	-- Blackwater Cutlass
				{ 3, 1926 },	-- Weighted Sap
				{ 16, "INV_Box_01", nil, BB["Marisa du'Paige"].." ("..AL["Rare"]..", "..AL["Entrance"]..")", nil },
				{ 17, 4660 },	-- Walking Boots
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local DMN_GUARD_LOOT = {
	{ 1, 18496 },	-- Heliotrope Cloak
	{ 2, 18450 },	-- Robe of Combustion
	{ 3, 18497 },	-- Sublime Wristguards
	{ 4, 18451 },	-- Hyena Hide Belt
	{ 5, 18494 },	-- Denwatcher's Shoulders
	{ 6, 18458 },	-- Modest Armguards
	{ 7, 18493 },	-- Bulky Iron Spaulders
	{ 8, 18459 },	-- Gallant's Wristguards
	{ 16, 18464 },	-- Gordok Nose Ring
	{ 18, 18498 },	-- Hedgecutter
	{ 19, 18462 },	-- Jagged Bone Fist
	{ 20, 18463 },	-- Ogre Pocket Knife
	{ 21, 18460 },	-- Unsophisticated Hand Cannon
}
data["DireMaul"] = {
	EncounterJournalID = 230,
	MapID = 699,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--DMEZevrimThornhoof
			EncounterJournalID = 402,
			[NORMAL_DIFF] = {
				{ 1, 18306 },	-- Gloves of Shadowy Mist
				{ 2, 18308 },	-- Clever Hat
				{ 3, 18319 },	-- Fervent Helm
				{ 4, 18313 },	-- Helm of Awareness
				{ 5, 18323 },	-- Satyr's Bow
			},
		},
		{	--DMEHydro
			EncounterJournalID = 403,
			[NORMAL_DIFF] = {
				{ 1, 18307 },	-- Riptide Shoes
				{ 2, 18322 },	-- Waterspout Boots
				{ 3, 18305 },	-- Breakwater Legguards
				{ 4, 18317 },	-- Tempest Talisman
				{ 5, 18324 },	-- Waveslicer
				{ 7, 18299, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Hydrospawn Essence
			},
		},
		{	--DMELethtendrisPimgib
			EncounterJournalID = 404,
			[NORMAL_DIFF] = {
				{ 1, 18325 },	-- Felhide Cap
				{ 2, 18302 },	-- Band of Vigor
				{ 3, 18311 },	-- Quel'dorei Channeling Rod
				{ 4, 18301 },	-- Lethtendris' Wand
				{ 6, 18426, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lethtendris' Web
				{ 16, "INV_Box_01", nil, BB["Pimgib"], nil },
				{ 17, 18354, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pimgib's Collar
			},
		},
		{	--DMEPusillin
			name = BB["Pusillin"],
			[NORMAL_DIFF] = {
				{ 1, 18267 },	-- Recipe: Runn Tum Tuber Surprise
				{ 3, 18261 },	-- Book of Incantations
			},
		},
		{	--DMEAlzzin
			EncounterJournalID = 405,
			[NORMAL_DIFF] = {
				{ 1, 18328 },	-- Shadewood Cloak
				{ 2, 18327 },	-- Whipvine Cord
				{ 3, 18309 },	-- Gloves of Restoration
				{ 4, 18318 },	-- Merciful Greaves
				{ 5, 18312 },	-- Energized Chestplate
				{ 6, 18326 },	-- Razor Gauntlets
				{ 16, 18314 },	-- Ring of Demonic Guile
				{ 17, 18315 },	-- Ring of Demonic Potency
				{ 19, 18321 },	-- Energetic Rod
				{ 20, 18310 },	-- Fiendish Machete
				{ 22, "INV_Box_01", nil, AL["Felvine Shard"], nil },
				{ 23, 18501, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Felvine Shard
				{ 25, "ac644" },
			},
		},
		{	--DMWTendrisWarpwood
			EncounterJournalID = 406,
			[NORMAL_DIFF] = {
				{ 1, 18390 },	-- Tanglemoss Leggings
				{ 2, 18393 },	-- Warpwood Binding
				{ 3, 18353 },	-- Stoneflower Staff
				{ 4, 18352 },	-- Petrified Bark Shield
			},
		},
		{	--DMWIllyannaRavenoak
			EncounterJournalID = 407,
			[NORMAL_DIFF] = {
				{ 1, 18386 },	-- Padre's Trousers
				{ 2, 18349 },	-- Gauntlets of Accuracy
				{ 3, 18383 },	-- Force Imbued Gauntlets
				{ 4, 18347 },	-- Well Balanced Axe
			},
		},
		{	--DMWMagisterKalendris
			EncounterJournalID = 408,
			[NORMAL_DIFF] = {
				{ 1, 18350 },	-- Amplifying Cloak
				{ 2, 18374 },	-- Flamescarred Shoulders
				{ 3, 18351 },	-- Magically Sealed Bracers
				{ 4, 18397 },	-- Elder Magus Pendant
				{ 5, 18371 },	-- Mindtap Talisman
				{ 7, 22309, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Pattern: Big Bag of Enchantment
			},
		},
		{	--DMWTsuzee
			name = BB["Tsu'zee"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 18387 },	-- Brightspark Gloves
				{ 2, 18346 },	-- Threadbare Trousers
				{ 3, 18345 },	-- Murmuring Ring
			},
		},
		{	--DMWImmolthar
			EncounterJournalID = 409,
			[NORMAL_DIFF] = {
				{ 1, 18389 },	-- Cloak of the Cosmos
				{ 2, 18385 },	-- Robe of Everlasting Night
				{ 3, 18377 },	-- Quickdraw Gloves
				{ 4, 18391 },	-- Eyestalk Cord
				{ 5, 18394 },	-- Demon Howl Wristguards
				{ 6, 18379 },	-- Odious Greaves
				{ 7, 18384 },	-- Bile-Etched Spaulders
				{ 16, 18381 },	-- Evil Eye Pendant
				{ 17, 18370 },	-- Vigilance Charm
				{ 19, 18372 },	-- Blade of the New Moon
				{ 21, "ac644" },
			},
		},
		{	--DMWHelnurath
			name = BB["Lord Hel'nurath"].." ("..AL["Summon"]..")",
			[NORMAL_DIFF] = {
				{ 1, 18757 },	-- Diabolic Mantle
				{ 2, 18755 },	-- Xorothian Firestick
				{ 3, 18756 },	-- Dreadguard's Protector
			},
		},
		{	--DMWPrinceTortheldrin
			EncounterJournalID = 410,
			[NORMAL_DIFF] = {
				{ 1, 18382 },	-- Fluctuating Cloak
				{ 2, 18373 },	-- Chestplate of Tranquility
				{ 3, 18375 },	-- Bracers of the Eclipse
				{ 4, 18378 },	-- Silvermoon Leggings
				{ 5, 18380 },	-- Eldritch Reinforced Legplates
				{ 7, 18395 },	-- Emerald Flame Ring
				{ 16, 18392 },	-- Distracting Dagger
				{ 17, 18396 },	-- Mind Carver
				{ 18, 18388 },	-- Stoneshatter
				{ 19, 18376 },	-- Timeworn Mace
			},
		},
		{	--DMNGuardMoldar
			EncounterJournalID = 411,
			[NORMAL_DIFF] = DMN_GUARD_LOOT
		},
		{	--DMNStomperKreeg
			EncounterJournalID = 412,
			[NORMAL_DIFF] = {
				{ 1, 18425 },	-- Kreeg's Mug
				{ 3, 18269, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Gordok Green Grog
				{ 4, 18284, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Kreeg's Stout Beatdown
				{ 5, 18287, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Evermurky
				{ 6, 18288, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Molasses Firewater
			},
		},
		{	--DMNGuardFengus
			EncounterJournalID = 413,
			[NORMAL_DIFF] = DMN_GUARD_LOOT
		},
		{	--DMNGuardSlipkik
			EncounterJournalID = 414,
			[NORMAL_DIFF] = DMN_GUARD_LOOT
		},
		{	--DMNCaptainKromcrush
			EncounterJournalID = 415,
			[NORMAL_DIFF] = {
				{ 1, 18507 },	-- Boots of the Full Moon
				{ 2, 18505 },	-- Mugger's Belt
				{ 3, 18503 },	-- Kromcrush's Chestplate
				{ 4, 18502 },	-- Monstrous Glaive
			},
		},
		{	--DMNChoRush
			EncounterJournalID = 416,
			[NORMAL_DIFF] = {
				{ 1, 18490 },	-- Insightful Hood
				{ 2, 18484 },	-- Cho'Rush's Blade
				{ 3, 18483 },	-- Mana Channeling Wand
				{ 4, 18485 },	-- Observer's Shield
			},
		},
		{	--DMNKingGordok
			EncounterJournalID = 417,
			[NORMAL_DIFF] = {
				{ 1, 18526 },	-- Crown of the Ogre King
				{ 2, 18525 },	-- Bracers of Prosperity
				{ 3, 18527 },	-- Harmonious Gauntlets
				{ 4, 18524 },	-- Leggings of Destruction
				{ 5, 18521 },	-- Grimy Metal Boots
				{ 7, 18522 },	-- Band of the Ogre King
				{ 16, 18520 },	-- Barbarous Blade
				{ 17, 18523 },	-- Brightly Glowing Stone
				{ 19, 19258, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Ace of Warlords
				{ 21, "ac644" },
			},
		},
		{	--DMETrash / DMWTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18295 },	-- Phasing Boots
				{ 2, 18344 },	-- Stonebark Gauntlets
				{ 3, 18298 },	-- Unbridled Leggings
				{ 4, 18296 },	-- Marksman Bands
				{ 5, 18289 },	-- Barbed Thorn Necklace
				{ 6, 18340 },	-- Eidolon Talisman
				{ 7, 18338 },	-- Wand of Arcane Potency
				{ 16, "INV_Box_01", nil, AL["Shen'dralar Provisioner"], nil },
				{ 17, 18487 },	-- Pattern: Mooncloth Robe
			},
		},
		{	--DMBooks
			name = AL["Dire Maul Books"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18364 },	-- The Emerald Dream
				{ 2, 18361 },	-- The Greatest Race of Hunters
				{ 3, 18358 },	-- The Arcanist's Cookbook
				{ 4, 18359 },	-- The Light and How to Swing It
				{ 5, 18362 },	-- Holy Bologna: What the Light Won't Tell You
				{ 6, 18356 },	-- Garona: A Study on Stealth and Treachery
				{ 7, 18363 },	-- Frost Shock and You
				{ 8, 18360 },	-- Harnessing Shadows
				{ 9, 18357 },	-- Codex of Defense
				{ 11, 18333 },	-- Libram of Focus
				{ 12, 18334 },	-- Libram of Protection
				{ 13, 18332 },	-- Libram of Rapidity
				{ 16, 18470 },	-- Royal Seal of Eldre'Thalas
				{ 17, 18473 },	-- Royal Seal of Eldre'Thalas
				{ 18, 18468 },	-- Royal Seal of Eldre'Thalas
				{ 19, 18472 },	-- Royal Seal of Eldre'Thalas
				{ 20, 18469 },	-- Royal Seal of Eldre'Thalas
				{ 21, 18465 },	-- Royal Seal of Eldre'Thalas
				{ 22, 18471 },	-- Royal Seal of Eldre'Thalas
				{ 23, 18467 },	-- Royal Seal of Eldre'Thalas
				{ 24, 18466 },	-- Royal Seal of Eldre'Thalas
			},
		},
		{	--DMNTRIBUTERUN
			name = AL["Dire Maul North Tribute Chest"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18538 },	-- Treant's Bane
				{ 3, 18495 },	-- Redoubt Cloak
				{ 4, 18532 },	-- Mindsurge Robe
				{ 5, 18475 },	-- Oddly Magical Belt
				{ 6, 18528 },	-- Cyclone Spaulders
				{ 7, 18478 },	-- Hyena Hide Jerkin
				{ 8, 18477 },	-- Shaggy Leggings
				{ 9, 18476 },	-- Mud Stained Boots
				{ 10, 18479 },	-- Carrion Scorpid Helm
				{ 11, 18530 },	-- Ogre Forged Hauberk
				{ 12, 18480 },	-- Scarab Plate Helm
				{ 13, 18533 },	-- Gordok Bracers of Power
				{ 14, 18529 },	-- Elemental Plate Girdle
				{ 16, 18500 },	-- Tarnished Elven Ring
				{ 17, 18537 },	-- Counterattack Lodestone
				{ 19, 18481 },	-- Skullcracking Mace
				{ 20, 18531 },	-- Unyielding Maul
				{ 21, 18534 },	-- Rod of the Ogre Magi
				{ 22, 18499 },	-- Barrier Shield
				{ 23, 18482 },	-- Ogre Toothpick Shooter
				{ 25, 18655 },	-- Schematic: Major Recombobulator
			},
		},
		{	--DMNThimblejack
			name = AL["Knot Thimblejack"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18517 },	-- Pattern: Chromatic Cloak
				{ 2, 18518 },	-- Pattern: Hide of the Wild
				{ 3, 18519 },	-- Pattern: Shifting Cloak
				{ 4, 18414 },	-- Pattern: Belt of the Archmage
				{ 6, 18418 },	-- Pattern: Cloak of Warding
				{ 7, 18415 },	-- Pattern: Felcloth Gloves
				{ 8, 18416 },	-- Pattern: Inferno Gloves
				{ 9, 18417 },	-- Pattern: Mooncloth Gloves
				{ 10, 18514 },	-- Pattern: Girdle of Insight
				{ 11, 18515 },	-- Pattern: Mongoose Boots
				{ 12, 18516 },	-- Pattern: Swift Flight Bracers
				{ 14, "INV_Box_01", nil, AL["Ogre Tannin Basket"], nil },
				{ 15, 18240 },	-- Ogre Tannin
				{ 16, 18509 },	-- Chromatic Cloak
				{ 17, 18510 },	-- Hide of the Wild
				{ 18, 18511 },	-- Shifting Cloak
				{ 19, 18405 },	-- Belt of the Archmage
				{ 21, 18413 },	-- Cloak of Warding
				{ 22, 18407 },	-- Felcloth Gloves
				{ 23, 18408 },	-- Inferno Gloves
				{ 24, 18409 },	-- Mooncloth Gloves
				{ 25, 18504 },	-- Girdle of Insight
				{ 26, 18506 },	-- Mongoose Boots
				{ 27, 18508 },	-- Swift Flight Bracers
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,

	}
}

local GNOMEREGAN_LOOT1 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(419), nil },	--Grubbis
	{ 2, 9445 },	-- Grubbis Paws
	{ 4, "INV_Box_01", nil, EJ_GetEncounterInfo(420), nil },	--Viscous Fallout
	{ 5, 9454 },	-- Acidic Walkers
	{ 6, 9453 },	-- Toxic Revenger
	{ 7, 9452 },	-- Hydrocane
	{ 9, "INV_Box_01", nil, EJ_GetEncounterInfo(421), nil },	--Electrocutioner 6000
	{ 10, 9448 },	-- Spidertank Oilrag
	{ 11, 9447 },	-- Electrocutioner Lagnut
	{ 12, 9446 },	-- Electrocutioner Leg
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(418), nil },	--Crowd Pummeler 9-60
	{ 17, 9450 },	-- Gnomebot Operating Boots
	{ 18, 9449 },	-- Manual Crowd Pummeler
	{ 20, "INV_Box_01", nil, BB["Dark Iron Ambassador"].." ("..AL["Rare"]..")", nil },
	{ 21, 9455 },	-- Emissary Cuffs
	{ 22, 9457 },	-- Royal Diplomatic Scepter
	{ 23, 9456 },	-- Glass Shooter
}
local GNOMEREGAN_LOOT2 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(422), nil },	--Mekgineer Thermaplugg
	{ 2, 9492 },	-- Electromagnetic Gigaflux Reactivator
	{ 3, 9461 },	-- Charged Gear
	{ 4, 9459 },	-- Thermaplugg's Left Arm
	{ 5, 9458 },	-- Thermaplugg's Central Core
	{ 6, 4415, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Craftsman's Monocle
	{ 7, 11828, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Pet Bombling
	{ 8, 4413, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Discombobulator Ray
	{ 9, 4411, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Flame Deflector
	{ 10, 7742, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Schematic: Gnomish Cloaking Device
	{ 12, "ac634" },
	{ 16, "INV_Box_01", nil, AL["Trash Mobs"], nil },
	{ 17, 9508 },	-- Mechbuilder's Overalls
	{ 18, 9491 },	-- Hotshot Pilot's Gloves
	{ 19, 9509 },	-- Petrolspill Leggings
	{ 20, 9510 },	-- Caverndeep Trudgers
	{ 21, 9490 },	-- Gizmotron Megachopper
	{ 22, 9485 },	-- Vibroblade
	{ 23, 9486 },	-- Supercharger Battle Axe
	{ 24, 9488 },	-- Oscillating Power Hammer
	{ 25, 9487 },	-- Hi-Tech Supergun
	{ 26, 11827 },	-- Schematic: Lil' Smoky
	{ 27, 9327 },	-- Security DELTA Data Access Card
	{ 28, 9326 },	-- Grime-Encrusted Ring
	{ 29, 9538 },	-- Talvash's Gold Ring
	{ 30, 9362 },	-- Brilliant Gold Ring
}
data["Gnomeregan"] = {
	EncounterJournalID = 231,
	MapID = 54,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Grubbis
			EncounterJournalID = 419,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT1,
		},
		{	--Viscous Fallout
			EncounterJournalID = 420,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT1,
		},
		{	--Electrocutioner 6000
			EncounterJournalID = 421,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT1,
		},
		{	--Crowd Pummeler 9-60
			EncounterJournalID = 418,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT1,
		},
		{	--Dark Iron Ambassador
			name = BB["Dark Iron Ambassador"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = GNOMEREGAN_LOOT1,
		},
		{	--Mekgineer Thermaplugg
			EncounterJournalID = 422,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT2,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = GNOMEREGAN_LOOT2,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["LowerBlackrockSpire"] = {
	EncounterJournalID = 229,
	MapID = 721,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--LBRSFelguard
			name = BB["Burning Felguard"].." ("..AL["Rare"]..", "..AL["Summon"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13181 },	-- Demonskin Gloves
				{ 2, 13182 },	-- Phase Blade
			},
		},
		{	--LBRSSpirestoneButcher
			name = BB["Spirestone Butcher"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12608 },	-- Butcher's Apron
				{ 2, 13286 },	-- Rivenspike
			},
		},
		{	--LBRSOmokk
			EncounterJournalID = 388,
			[NORMAL_DIFF] = {
				{ 1, 13170 },	-- Skyshroud Leggings
				{ 2, 13169 },	-- Tressermane Leggings
				{ 3, 13168 },	-- Plate of the Shaman King
				{ 4, 13166 },	-- Slamshot Shoulders
				{ 5, 13167 },	-- Fist of Omokk
				{ 7, 12534, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Omokk's Head
			},
		},
		{	--LBRSSpirestoneLord
			name = BB["Spirestone Battle Lord"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13284 },	-- Swiftdart Battleboots
				{ 2, 13285 },	-- The Blackrock Slicer
			},
		},
		{	--LBRSLordMagus
			name = BB["Spirestone Lord Magus"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13282 },	-- Ogreseer Tower Boots
				{ 2, 13283 },	-- Magus Ring
				{ 3, 13261 },	-- Globe of D'sak
			},
		},
		{	--LBRSVosh
			EncounterJournalID = 389,
			[NORMAL_DIFF] = {
				{ 1, 12626 },	-- Funeral Cuffs
				{ 2, 13257 },	-- Demonic Runed Spaulders
				{ 3, 13255 },	-- Trueaim Gauntlets
				{ 4, 12651 },	-- Blackcrow
				{ 5, 12653 },	-- Riphook
			},
		},
		{	--LBRSVoone
			EncounterJournalID = 390,
			[NORMAL_DIFF] = {
				{ 1, 22231 },	-- Kayser's Boots of Precision
				{ 2, 13179 },	-- Brazecore Armguards
				{ 3, 13177 },	-- Talisman of Evasion
				{ 4, 12582 },	-- Keris of Zul'Serak
			},
		},
		{	--LBRSGrimaxe
			name = BB["Bannok Grimaxe"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12634 },	-- Chiselbrand Girdle
				{ 2, 12637 },	-- Backusarian Gauntlets
				{ 3, 12621 },	-- Demonfork
				{ 5, 12838 },	-- Plans: Arcanite Reaper
				{ 6, 12784 },	-- Arcanite Reaper
			},
		},
		{	--LBRSSmolderweb
			EncounterJournalID = 391,
			[NORMAL_DIFF] = {
				{ 1, 13244 },	-- Gilded Gauntlets
				{ 2, 13213 },	-- Smolderweb's Eye
				{ 3, 13183 },	-- Venomspitter
				{ 5, 68673, "pet90" },	-- Smolderweb Egg
			},
		},
		{	--LBRSCrystalFang
			name = BB["Crystal Fang"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13185 },	-- Sunderseer Mantle
				{ 2, 13184 },	-- Fallbrush Handgrips
				{ 3, 13218 },	-- Fang of the Crystal Spider
			},
		},
		{	--LBRSDoomhowl
			EncounterJournalID = 392,
			[NORMAL_DIFF] = {
				{ 1, 13258 },	-- Slaghide Gauntlets
				{ 2, 22232 },	-- Marksman's Girdle
				{ 3, 13259 },	-- Ribsteel Footguards
				{ 4, 13178 },	-- Rosewine Circle
			},
		},
		{	--LBRSZigris
			EncounterJournalID = 393,
			[NORMAL_DIFF] = {
				{ 1, 13253 },	-- Hands of Power
				{ 2, 13252 },	-- Cloudrunner Girdle
				{ 4, 12835, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Annihilator
				{ 5, 12798, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Annihilator
				{ 7, 21955, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Design: Black Diamond Crab
				{ 16, 12264, "pet89" },	-- Worg Carrier
			},
		},
		{	--LBRSHalycon
			EncounterJournalID = 394,
			[NORMAL_DIFF] = {
				{ 1, 22313 },	-- Ironweave Bracers
				{ 2, 13210 },	-- Pads of the Dread Wolf
				{ 3, 13211 },	-- Slashclaw Bracers
				{ 4, 13212 },	-- Halycon's Spiked Collar
			},
		},
		{	--LBRSSlavener
			EncounterJournalID = 395,
			[NORMAL_DIFF] = {
				{ 1, 13206 },	-- Wolfshear Leggings
				{ 2, 13208 },	-- Bleak Howler Armguards
				{ 3, 13205 },	-- Rhombeard Protector
			},
		},
		{	--LBRSBashguud
			name = BB["Ghok Bashguud"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13203 },	-- Armswake Cloak
				{ 2, 13198 },	-- Hurd Smasher
				{ 3, 13204 },	-- Bashguuder
			},
		},
		{	--LBRSWyrmthalak
			EncounterJournalID = 396,
			[NORMAL_DIFF] = {
				{ 1, 13143 },	-- Mark of the Dragon Lord
				{ 3, 13162 },	-- Reiver Claws
				{ 4, 22321 },	-- Heart of Wyrmthalak
				{ 5, 13163 },	-- Relentless Scythe
				{ 6, 13161 },	-- Trindlehaven Staff
				{ 16, "ac643" },
			},
		},
		{	--LBRSTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 14513 },	-- Pattern: Robe of the Archmage
				{ 2, 14152 },	-- Robe of the Archmage
				{ 4, 13494 },	-- Recipe: Greater Fire Protection Potion
				{ 5, 16250 },	-- Formula: Enchant Weapon - Superior Striking
				{ 6, 15749 },	-- Pattern: Volcanic Breastplate
				{ 7, 15775 },	-- Pattern: Volcanic Shoulders
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local MARAUDON_LOOT1 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(423), nil },	--Noxxion
	{ 2, 17746 },	-- Noxxion's Shackles
	{ 3, 17744 },	-- Heart of Noxxion
	{ 4, 17745 },	--" Noxious Shooter
	{ 6, "INV_Box_01", nil, EJ_GetEncounterInfo(424), nil },	--Razorlash
	{ 7, 17750 },	-- Chloromesh Girdle
	{ 8, 17748 },	-- Vinerot Sandals
	{ 9, 17749 },	-- Phytoskin Spaulders
	{ 10, 17751 },	-- Brusslehide Leggings
	{ 12, "INV_Box_01", nil, BB["Meshlok the Harvester"].." ("..AL["Rare"]..")", nil },
	{ 13, 17741 },	-- Nature's Embrace
	{ 14, 17742 },	-- Fungus Shroud Armor
	{ 15, 17767 },	-- Bloomsprout Headpiece
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(427), nil },	--Lord Vyletongue
	{ 17, 17755 },	-- Satyrmane Sash
	{ 18, 17754 },	-- Infernal Trickster Leggings
	{ 19, 17752 },	-- Satyr's Lash
	{ 21, "INV_Box_01", nil, EJ_GetEncounterInfo(425), nil },	--Tinkerer Gizlock
	{ 22, 17719 },	-- Inventor's Focal Sword
	{ 23, 17718 },	-- Gizlock's Hypertech Buckler
	{ 24, 17717 },	-- Megashot Rifle
}
local MARAUDON_LOOT2 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(428), nil },	--Celebras the Cursed
	{ 2, 17739 },	-- Grovekeeper's Drape
	{ 3, 17740 },	-- Soothsayer's Headdress
	{ 4, 17738 },	-- Claw of Celebras
	{ 6, "INV_Box_01", nil, EJ_GetEncounterInfo(429), nil },	--Landslide
	{ 7, 17736 },	-- Rockgrip Gauntlets
	{ 8, 17734 },	-- Helm of the Mountain
	{ 9, 17737 },	-- Cloud Stone
	{ 10, 17943 },	-- Fist of Stone
	{ 12, "INV_Box_01", nil, EJ_GetEncounterInfo(430), nil },	--Rotgrip
	{ 13, 17732 },	-- Rotgrip Mantle
	{ 14, 17728 },	-- Albino Crocscale Boots
	{ 15, 17730 },	-- Gatorbite Axe
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(431), nil },	--Princess Theradras
	{ 17, 17780 },	-- Blade of Eternal Darkness
	{ 18, 17715 },	-- Eye of Theradras
	{ 19, 17714 },	-- Bracers of the Stone Princess
	{ 20, 17711 },	-- Elemental Rockridge Leggings
	{ 21, 17707 },	-- Gemshard Heart
	{ 22, 17713 },	-- Blackstone Ring
	{ 23, 17710 },	-- Charstone Dirk
	{ 24, 17766 },	-- Princess Theradras' Scepter
	{ 26, "ac640" },
}
data["Maraudon"] = {
	EncounterJournalID = 232,
	MapID = 750,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Noxxion
			EncounterJournalID = 423,
			[NORMAL_DIFF] = MARAUDON_LOOT1,
		},
		{	--Razorlash
			EncounterJournalID = 424,
			[NORMAL_DIFF] = MARAUDON_LOOT1,
		},
		{	--Meshlok the Harvester
			name = BB["Meshlok the Harvester"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = MARAUDON_LOOT1,
		},
		{	--Lord Vyletongue
			EncounterJournalID = 427,
			[NORMAL_DIFF] = MARAUDON_LOOT1,
		},
		{	--Tinkerer Gizlock
			EncounterJournalID = 425,
			[NORMAL_DIFF] = MARAUDON_LOOT1,
		},
		{	--Celebras the Cursed
			EncounterJournalID = 428,
			[NORMAL_DIFF] = MARAUDON_LOOT2,
		},
		{	--Landslide
			EncounterJournalID = 429,
			[NORMAL_DIFF] = MARAUDON_LOOT2,
		},
		{	--Rotgrip
			EncounterJournalID = 430,
			[NORMAL_DIFF] = MARAUDON_LOOT2,
		},
		{	--Princess Theradras
			EncounterJournalID =431,
			[NORMAL_DIFF] = MARAUDON_LOOT2,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local RAGEFIRE_CHASM_LOOT = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(694), nil },	--Adarogg
	{ 2, 82772 },	-- Snarlmouth Leggings
	{ 3, 82879 },	-- Collarspike Bracers
	{ 4, 82880 },	-- Fang of Adarogg
	{ 6, "INV_Box_01", nil, EJ_GetEncounterInfo(695), nil },	--Dark Shaman Koranthal
	{ 7, 82882 },	-- Dark Ritual Cape
	{ 8, 82881 },	-- Cuffs of Black Elements
	{ 9, 82877 },	-- Grasp of the Broken Totem
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(696), nil },	--Slagmaw
	{ 17, 82878 },	-- Fireworm Robes
	{ 18, 82884 },	-- Chitonous Bracers
	{ 19, 82885 },	-- Flameseared Carapace
	{ 21, "INV_Box_01", nil, EJ_GetEncounterInfo(697), nil },	--Lava Guard Gordoth
	{ 22, 82886 },	-- Gorewalker Treads
	{ 23, 82883 },	-- Bloodcursed Felblade
	{ 24, 82888 },	-- Heartboiler Staff
	{ 26, "ac629" },
}
data["RagefireChasm"] = {
	EncounterJournalID = 226,
	MapID = 680,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Adarogg
			EncounterJournalID = 694,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		{	--Dark Shaman Koranthal
			EncounterJournalID = 695,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		{	--Slagmaw
			EncounterJournalID = 696,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		{	--Lava Guard Gordoth
			EncounterJournalID = 697,
			[NORMAL_DIFF] = RAGEFIRE_CHASM_LOOT,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local RAZORFEN_DOWNS_LOOT1 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(1142), nil },	--Aarux
	{ 2, 10776 },	-- Silky Spider Cape
	{ 3, 10777 },	-- Arachnid Gloves
	{ 4, 10775 },	-- Carapace of Tuten'kash
	{ 6, "INV_Box_01", nil, EJ_GetEncounterInfo(433), nil },	--Mordresh Fire Eye
	{ 7, 10771 },	-- Deathmage Sash
	{ 8, 10769 },	-- Glowing Eye of Mordresh
	{ 9, 10770 },	-- Mordresh's Lifeless Skull
	{ 11, "INV_Box_01", nil, EJ_GetEncounterInfo(1143), nil },	--Mushlump
	{ 12, 10774 },	-- Fleshhide Shoulders
	{ 13, 10772 },	-- Glutton's Cleaver
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(1146), nil },	--Death Speaker Blackthorn
	{ 17, 10760 },	-- Swine Fists
	{ 18, 10768 },	-- Boar Champion's Belt
	{ 19, 10758 },	-- X'caliboar
	{ 20, 10766 },	-- Plaguerot Sprig
	{ 21, 10767 },	-- Savage Boar's Guard
	{ 23, "INV_Box_01", nil, EJ_GetEncounterInfo(1141), nil },	--Amnennar the Coldbringer
	{ 24, 10762 },	-- Robes of the Lich
	{ 25, 10765 },	-- Bonefingers
	{ 26, 10764 },	-- Deathchill Armor
	{ 27, 10763 },	-- Icemetal Barbute
	{ 28, 10761 },	-- Coldrage Dagger
	{ 30, "ac636" },
}
local RAZORFEN_DOWNS_LOOT2 = {
	{ 1, "INV_Box_01", nil, AL["Trash Mobs"], nil },
	{ 2, 10574 },	-- Corpseshroud
	{ 3, 10581 },	-- Death's Head Vestment
	{ 4, 10578 },	-- Thoughtcast Boots
	{ 5, 10583 },	-- Quillward Harness
	{ 6, 10582 },	-- Briar Tredders
	{ 7, 10584 },	-- Stormgale Fists
	{ 8, 10573 },	-- Boneslasher
	{ 9, 10570 },	-- Manslayer
	{ 10, 10571 },	-- Ebony Boneclub
	{ 11, 10567 },	-- Quillshooter
	{ 12, 10572 },	-- Freezing Shard
}
data["RazorfenDowns"] = {
	EncounterJournalID = 233,
	MapID = 760,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Aarux
			EncounterJournalID = 1142,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT1,
		},
		{	--Mordresh Fire Eye
			EncounterJournalID = 433,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT1,
		},
		{	--Mushlump
			EncounterJournalID = 1143,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT1,
		},
		{	--Death Speaker Blackthorn
			EncounterJournalID = 1146,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT1,
		},
		{	--Amnennar the Coldbringer
			EncounterJournalID = 1141,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT1,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = RAZORFEN_DOWNS_LOOT2,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local RAZORFEN_KRAUL_LOOT1 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(896), nil },	--Hunter Bonetusk
	{ 2, 6681 },	-- Thornspike
	{ 4, "INV_Box_01", nil, EJ_GetEncounterInfo(895), nil },	--Roogug
	{ 5, 6690 },	-- Ferine Leggings
	{ 6, 6691 },	-- Swinetusk Shank
	{ 8, "INV_Box_01", nil, EJ_GetEncounterInfo(899), nil },	--Warlord Ramtusk
	{ 9, 6686 },	-- Tusken Helm
	{ 10, 6687 },	-- Corpsemaker
	{ 16, "INV_Box_01", nil, BB["Earthcaller Halmgar"].." ("..AL["Rare"]..")", nil },
	{ 17, 6688 },	-- Whisperwind Headdress
	{ 18, 6689 },	-- Wind Spirit Staff
	{ 20, "INV_Box_01", nil, EJ_GetEncounterInfo(900), nil },	--Groyat, the Blind Hunter
	{ 21, 6697 },	-- Batwing Mantle
	{ 22, 6695 },	-- Stygian Bone Amulet
	{ 23, 6696 },	-- Nightstalker Bow
}
local RAZORFEN_KRAUL_LOOT2 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(901), nil },	--Charlga Razorflank
	{ 2, 6693 },	-- Agamaggan's Clutch
	{ 3, 6692 },	-- Pronged Reaver
	{ 4, 6694 },	-- Heart of Agamaggan
	{ 5, 5793, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Razorflank's Heart
	{ 7, "ac635" },
	{ 16, "INV_Box_01", nil, AL["Trash Mobs"], nil },
	{ 17, 2264 },	-- Mantle of Thieves
	{ 18, 1978 },	-- Wolfclaw Gloves
	{ 19, 1488 },	-- Avenger's Armor
	{ 20, 4438 },	-- Pugilist Bracers
	{ 21, 2039 },	-- Plains Ring
	{ 22, 776 },	-- Vendetta
	{ 23, 1727 },	-- Sword of Decay
	{ 24, 1975 },	-- Pysan's Old Greatsword
	{ 25, 1976 },	-- Slaghammer
	{ 26, 2549 },	-- Staff of the Shade
}
data["RazorfenKraul"] = {
	EncounterJournalID = 234,
	MapID = 761,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Hunter Bonetusk
			EncounterJournalID = 896,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT1,
		},
		{	--Roogug
			EncounterJournalID = 895,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT1,
		},
		{	--Warlord Ramtusk
			EncounterJournalID = 899,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT1,
		},
		{	--Earthcaller Halmgar
			name = BB["Earthcaller Halmgar"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT1,
		},
		{	--Groyat, the Blind Hunter
			EncounterJournalID = 900,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT1,
		},
		{	--Charlga Razorflank
			EncounterJournalID = 901,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT2,
		},
		{	--Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = RAZORFEN_KRAUL_LOOT2,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["ScarletHalls"] = {
	EncounterJournalID = 311,
	MapID = 871,
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--SHBraun
			EncounterJournalID = 660,
			[NORMAL_DIFF] = {
				{ 1, 88266 },	-- Hound Trainer's Gloves
				{ 2, 88268 },	-- Canine Commander's Breastplate
				{ 3, 88267 },	-- Commanding Bracers
				{ 4, 88265 },	-- Beastbinder Ring
				{ 5, 88264 },	-- Houndmaster's Compound Crossbow
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SHHarlan
			EncounterJournalID = 654,
			[NORMAL_DIFF] = {
				{ 1, 88269 },	-- Scarlet Sandals
				{ 2, 88270 },	-- Lightblade Bracer
				{ 3, 88271 },	-- Harlan's Shoulders
				{ 4, 88273 },	-- Armsmaster's Sealed Locket
				{ 5, 88272 },	-- The Gleaming Ravager
				{ 7, 23192, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tabard of the Scarlet Crusade
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SHKoegler
			EncounterJournalID = 656,
			[NORMAL_DIFF] = {
				{ 1, 88279 },	-- Robes of Koegler
				{ 2, 88282 },	-- Vellum-Ripper Gloves
				{ 3, 88276 },	-- Bindburner Belt
				{ 4, 88283 },	-- Bradbury's Entropic Legguards
				{ 5, 88277 },	-- Pyretic Legguards
				{ 6, 88275 },	-- Scorched Scarlet Key
				{ 7, 88281 },	-- Temperature-Sensing Necklace
				{ 8, 88280 },	-- Melted Hypnotic Blade
				{ 9, 88274 },	-- Koegler's Ritual Knife
				{ 10, 88278 },	-- Mograine's Immaculate Might
				{ 12, 87267, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Codex of the Crusade
				{ 16, "ac7413" },	
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
	}
}

data["ScarletMonastery"] = {
	EncounterJournalID = 316,
	MapID = 874,
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--SMThalnos
			EncounterJournalID = 688,
			[NORMAL_DIFF] = {
				{ 1, 88288 },	-- Soulrender Greatcloak
				{ 2, 88284 },	-- Forgotten Bloodmage Mantle
				{ 3, 88286 },	-- Legguards of the Crimson Magus
				{ 4, 88287 },	-- Bracers of the Fallen Crusader
				{ 5, 88285 },	-- Signet of the Hidden Door
				{ 16, "ac6946" },
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SMKorloff
			EncounterJournalID = 671,
			[NORMAL_DIFF] = {
				{ 1, 88290 },	-- Scorched Earth Cloak
				{ 2, 88291 },	-- Korloff's Raiment
				{ 3, 88292 },	-- Helm of Rising Flame
				{ 4, 88293 },	-- Firefinger Ring
				{ 5, 88289 },	-- Firestorm Greatstaff
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--SMWhitemane
			EncounterJournalID = 674,
			[NORMAL_DIFF] = {
				{ 1, 88299 },	-- Whitemane's Embroidered Chapeau
				{ 2, 88298 },	-- Leggings of Hallowed Fire
				{ 3, 88302 },	-- Incarnadine Scarlet Spaulders
				{ 4, 88295 },	-- Dashing Strike Treads
				{ 5, 88303 },	-- Crown of Holy Flame
				{ 6, 88296 },	-- Waistplate of Imminent Resurrection
				{ 7, 88300 },	-- Triune Signet
				{ 8, 88294 },	-- Flashing Steel Talisman
				{ 9, 88297 },	-- Lightbreaker Greatsword
				{ 10, 88301 },	-- Greatstaff of Righteousness
				{ 16, "ac637" },
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--HallowsEndHeadlessHorseman
			name = BB["Headless Horseman"].." ("..AL["Hallow's End"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:HallowsEnd:1",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["Scholomance"] = {
	EncounterJournalID = 246,
	MapID = 898,
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--ScholoChillheart
			EncounterJournalID = 659,
			[NORMAL_DIFF] = {
				{ 1, 88336 },	-- Icewrath Belt
				{ 2, 88337 },	-- Shadow Puppet Bracers
				{ 3, 88338 },	-- Breastplate of Wracking Souls
				{ 4, 88335 },	-- Anarchist's Pendant
				{ 5, 88339 },	-- Gravetouch Greatsword
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoJandice
			EncounterJournalID = 663,
			[NORMAL_DIFF] = {
				{ 1, 88349 },	-- Phantasmal Drape
				{ 2, 88345 },	-- Barovian Ritual Hood
				{ 3, 88347 },	-- Ghostwoven Legguards
				{ 4, 88348 },	-- Wraithplate Treads
				{ 5, 88346 },	-- Metanoia Shield
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoRattlegore
			EncounterJournalID = 665,
			[NORMAL_DIFF] = {
				{ 1, 88340 },	-- Deadwalker Bracers
				{ 2, 88342 },	-- Rattling Gloves
				{ 3, 88343 },	-- Bone Golem Boots
				{ 4, 88344 },	-- Goresoaked Headreaper
				{ 5, 88341 },	-- Necromantic Wand
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoVoss
			EncounterJournalID = 666,
			[NORMAL_DIFF] = {
				{ 1, 88350 },	-- Leggings of Unleashed Anguish
				{ 2, 88351 },	-- Soulburner Crown
				{ 3, 88352 },	-- Shivbreaker Vest
				{ 4, 88353 },	-- Dark Blaze Gauntlets
				{ 5, 88354 },	-- Necklace of the Dark Blaze
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		{	--ScholoGandling
			EncounterJournalID = 684,
			[NORMAL_DIFF] = {
				{ 1, 88359 },	-- Incineration Belt
				{ 2, 88356 },	-- Tombstone Gauntlets
				{ 3, 88361 },	-- Gloves of Explosive Pain
				{ 4, 88362 },	-- Shoulderguards of Painful Lessons
				{ 5, 88357 },	-- Vigorsteel Spaulders
				{ 6, 88358 },	-- Lessons of the Darkmaster
				{ 7, 88360 },	-- Price of Progress
				{ 8, 88355 },	-- Searing Words
				{ 16, "ac645" },
			},
			[HEROIC_DIFF] = "AtlasLoot_MistsofPandaria",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["ShadowfangKeep"] = {
	EncounterJournalID = 64,
	MapID = 764,
	ContentType = DUNGEON_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	items = {
		{	--ShadowfangAshbury
			EncounterJournalID = 96,
			[NORMAL_DIFF] = {
				{ 1, 6314 },	-- Wolfmaster Cape
				{ 2, 6324 },	-- Robes of Arugal
				{ 3, 6323 },	-- Baron's Scepter
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangSilverlaine
			EncounterJournalID = 97,
			[NORMAL_DIFF] = {
				{ 1, 6321 },	-- Silverlaine's Family Seal
				{ 2, 6323 },	-- Baron's Scepter
				{ 4, 60885, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Silverlaine Family Sword
				{ 5, 60878, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Silverlaine's Enchanted Crystal
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangSpringvale
			EncounterJournalID = 98,
			[NORMAL_DIFF] = {
				{ 1, 3191 },	-- Arced War Axe
				{ 2, 6320 },	-- Commander's Crest", "=ds=#w8#" };
				{ 4, 60879, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Commander's Holy Symbol
				{ 5, 60880, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Springvale's Sharpening Stone
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangWalden
			EncounterJournalID = 99,
			[NORMAL_DIFF] = {
				{ 1, 3230 },	-- Black Wolf Bracers
				{ 2, 6642 },	-- Phantom Armor
				{ 3, 6341 },	-- Eerie Stable Lantern
				{ 4, 1292 },	-- Butcher's Cleaver
				{ 6, 60876, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Walden's Elixirs
				{ 7, 60881, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Walden's Talisman
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangGodfrey
			EncounterJournalID = 100,
			[NORMAL_DIFF] = {
				{ 1, 3748 },	-- Feline Mantle
				{ 2, 6220 },	-- Meteor Shard
				{ 3, 6641 },	-- Haunting Blade
				{ 4, 6318 },	-- Odo's Ley Staff
				{ 6, 60877, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Godfrey's Crystal Scope
				{ 7, 60882, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tenebrous Orb
				{ 16, "ac631" },
			},
			[HEROIC_DIFF] = "AtlasLoot_Cataclysm",
		},
		{	--ShadowfangTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 1974 },	-- Mindthrust Bracers
				{ 2, 3194 },	-- Black Malice
				{ 3, 1483 },	-- Face Smasher
				{ 4, 2807 },	-- Guillotine Axe
				{ 5, 1318 },	-- Night Reaver
				{ 6, 1484 },	-- Witching Stave
				{ 16, 60977 },	-- Orders from High Command
				{ 17, 60874 },	-- Deathless Sinew
				{ 18, 60875 },	-- Ghostly Essence
			},
		},
		{	--LoveisintheAirTrio
			name = BB["Apothecary Hummel"].." ("..AL["Love is in the Air"]..")",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WorldEvents:LoveisintheAir:1",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["Stratholme"] = {
	EncounterJournalID = 236,
	MapID = 765,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--STRATSkull
			name = BB["Skul"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13395 },	-- Skul's Fingerbone Claws
				{ 2, 13394 },	-- Skul's Cold Embrace
				{ 3, 13396 },	-- Skul's Ghastly Touch
			},
		},
		{	--STRATTheUnforgiven
			EncounterJournalID = 450,
			[NORMAL_DIFF] = {
				{ 1, 13409 },	-- Tearfall Bracers
				{ 2, 13404 },	-- Mask of the Unforgiven
				{ 3, 13405 },	-- Wailing Nightbane Pauldrons
				{ 4, 13408 },	-- Soul Breaker
			},
		},
		{	--STRATHearthsingerForresten
			EncounterJournalID = 443,
			[NORMAL_DIFF] = {
				{ 1, 13378 },	-- Songbird Blouse
				{ 2, 13383 },	-- Woollies of the Prancing Minstrel
				{ 3, 13384 },	-- Rainbow Girdle
				{ 4, 13379 },	-- Piccolo of the Flaming Fire
			},
		},
		{	--STRATPostmasterMalown
			name = BB["Postmaster Malown"],
			[NORMAL_DIFF] = {
				{ 1, 13390 },	-- The Postmaster's Band
				{ 2, 13388 },	-- The Postmaster's Tunic
				{ 3, 13389 },	-- The Postmaster's Trousers
				{ 4, 13391 },	-- The Postmaster's Treads
				{ 16, 13392 },	-- The Postmaster's Seal
				{ 18, 13393 },	-- Malown's Slam
			},
		},			
		{	--STRATTimmytheCruel
			EncounterJournalID = 445,
			[NORMAL_DIFF] = {
				{ 1, 13403 },	-- Grimgore Noose
				{ 2, 13402 },	-- Timmy's Galoshes
				{ 3, 13400 },	-- Vambraces of the Sadist
				{ 4, 13401 },	-- The Cruel Hand of Timmy
			},
		},
		{	--STRATWilleyHopebreaker
			EncounterJournalID = 446,
			[NORMAL_DIFF] = {
				{ 1, 22405 },	-- Mantle of the Scarlet Crusade
				{ 2, 22407 },	-- Helm of the New Moon
				{ 3, 18721 },	-- Barrage Girdle
				{ 4, 13381 },	-- Master Cannoneer Boots
				{ 5, 22403 },	-- Diana's Pearl Necklace
				{ 6, 13382 },	-- Cannonball Runner
				{ 7, 22404 },	-- Willey's Back Scratcher
				{ 8, 22406 },	-- Redemption
				{ 9, 13380 },	-- Willey's Portable Howitzer
				{ 16, 12839, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Heartseeker
				{ 17, 12783, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Heartseeker
			},
		},
		{	--STRATInstructorGalford
			EncounterJournalID = 448,
			[NORMAL_DIFF] = {
				{ 1, 13386 },	-- Archivist Cape
				{ 2, 18716 },	-- Ash Covered Boots
				{ 3, 13387 },	-- Foresight Girdle
				{ 4, 13385 },	-- Tome of Knowledge
				{ 6, 12811, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Righteous Orb
				{ 16, "INV_Box_01", nil, AL["Unfinished Painting"], nil },
				{ 17, 14679, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Of Love and Family
			},
		},
		{	--STRATBalnazzar
			EncounterJournalID = 449,
			[NORMAL_DIFF] = {
				{ 1, 13353 },	-- Book of the Dead
				{ 2, 14512 },	-- Pattern: Truefaith Vestments
				{ 3, 14154 },	-- Truefaith Vestments
				{ 5, 18720 },	-- Shroud of the Nathrezim
				{ 6, 13369 },	-- Fire Striders
				{ 7, 13358 },	-- Wyrmtongue Shoulders
				{ 8, 13359 },	-- Crown of Tyranny
				{ 9, 18718 },	-- Grand Crusader's Helm
				{ 10, 12103 },	-- Star of Mystaria
				{ 11, 13360 },	-- Gift of the Elven Magi
				{ 12, 13348 },	-- Demonshear
				{ 13, 18717 },	-- Hammer of the Grand Crusader
				{ 16, 13520, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Recipe: Flask of Distilled Wisdom
				{ 18, "ac646" },
			},
		},
		{	--STRATStonespine
			name = BB["Stonespine"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 13397 },	-- Stoneskin Gargoyle Cape
				{ 2, 13954 },	-- Verdant Footpads
				{ 3, 13399 },	-- Gargoyle Shredder Talons
			},
		},
		{	--STRATBaronessAnastari
			EncounterJournalID = 451,
			[NORMAL_DIFF] = {
				{ 1, 13535 },	-- Coldtouch Phantom Wraps
				{ 2, 18730 },	-- Shadowy Laced Handwraps
				{ 3, 13537 },	-- Chillhide Bracers
				{ 4, 13538 },	-- Windshrieker Pauldrons
				{ 5, 13539 },	-- Banshee's Touch
				{ 6, 18728 },	-- Anastari Heirloom
				{ 7, 13534 },	-- Banshee Finger
				{ 8, 18729 },	-- Screeching Bow
				{ 10, 13514, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Wail of the Banshee
			},
		},
		{	--STRATNerubenkan
			EncounterJournalID = 452,
			[NORMAL_DIFF] = {
				{ 1, 18740 },	-- Thuzadin Sash
				{ 2, 18739 },	-- Chitinous Plate Legguards
				{ 3, 13529 },	-- Husk of Nerub'enkan
				{ 4, 18738 },	-- Carapace Spine Crossbow
				{ 6, 13530 },	-- Fangdrip Runners
				{ 7, 13531 },	-- Crypt Stalker Leggings
				{ 8, 13532 },	-- Darkspinner Claws
				{ 9, 13533 },	-- Acid-Etched Pauldrons
				{ 10, 13508, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Eye of Arachnida
			},
		},
		{	--STRATMalekithePallid
			EncounterJournalID = 453,
			[NORMAL_DIFF] = {
				{ 1, 18734 },	-- Pale Moon Cloak
				{ 2, 13525 },	-- Darkbind Fingers
				{ 3, 18735 },	-- Maleki's Footwraps
				{ 4, 13526 },	-- Flamescarred Girdle
				{ 5, 13528 },	-- Twilight Void Bracers
				{ 6, 13527 },	-- Lavawalker Greaves
				{ 7, 13524 },	-- Skull of Burning Shadows
				{ 8, 18737 },	-- Bone Slicing Hatchet
				{ 10, 13509, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Clutch of Foresight
				{ 16, 12833, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Plans: Hammer of the Titans
				{ 17, 12796, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Hammer of the Titans
			},
		},
		{	--STRATMagistrateBarthilas
			EncounterJournalID = 454,
			[NORMAL_DIFF] = {
				{ 1, 13376 },	-- Royal Tribunal Cloak
				{ 2, 18727 },	-- Crimson Felt Hat
				{ 3, 18726 },	-- Magistrate's Cuffs
				{ 4, 18722 },	-- Death Grips
				{ 5, 18725 },	-- Peacemaker
			},
		},
		{	--STRATRamsteintheGorger
			EncounterJournalID = 455,
			[NORMAL_DIFF] = {
				{ 1, 13374 },	-- Soulstealer Mantle
				{ 2, 18723 },	-- Animated Chain Necklace
				{ 3, 13373 },	-- Band of Flesh
				{ 4, 13515 },	-- Ramstein's Lightning Bolts
				{ 5, 13372 },	-- Slavedriver's Cane
				{ 6, 13375 },	-- Crest of Retribution
			},
		},
		{	--STRATLordAuriusRivendare
			EncounterJournalID = 456,
			[NORMAL_DIFF] = {
				{ 1, 13505 },	-- Runeblade of Baron Rivendare
				{ 2, 13335, "mount" },	-- Deathcharger's Reins
				{ 4, 13340 },	-- Cape of the Black Baron
				{ 5, 22412 },	-- Thuzadin Mantle
				{ 6, 13346 },	-- Robes of the Exalted
				{ 7, 22409 },	-- Tunic of the Crescent Moon
				{ 8, 13344 },	-- Dracorian Gauntlets
				{ 9, 22410 },	-- Gauntlets of Deftness
				{ 10, 22411 },	-- Helm of the Executioner
				{ 11, 13345 },	-- Seal of Rivendare
				{ 16, 13368 },	-- Bonescraper
				{ 17, 13361 },	-- Skullforge Reaver
				{ 18, 13349 },	-- Scepter of the Unholy
				{ 19, 22408 },	-- Ritssyn's Wand of Bad Mojo
				{ 21, "ac646" },
			},
		},
		{	--STRATTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18743 },	-- Gracious Cape
				{ 2, 17061 },	-- Juno's Shadow
				{ 3, 18745 },	-- Sacred Cloth Leggings
				{ 4, 18744 },	-- Plaguebat Fur Gloves
				{ 5, 18736 },	-- Plaguehound Leggings
				{ 6, 18742 },	-- Stratholme Militia Shoulderguard
				{ 7, 18741 },	-- Morlune's Bracer
				{ 9, 12811 },	-- Righteous Orb
				{ 16, 16249 },	-- Formula: Enchant 2H Weapon - Major Intellect
				{ 17, 16248 },	-- Formula: Enchant Weapon - Unholy
				{ 18, 18658 },	-- Schematic: Ultra-Flash Shadow Reflector
				{ 19, 16052 },	-- Schematic: Voice Amplification Modulator
				{ 20, 15777 },	-- Pattern: Runic Leather Shoulders
				{ 21, 15768 },	-- Pattern: Wicked Leather Belt
				{ 22, 14495 },	-- Pattern: Ghostweave Pants
				{ 24, "INV_Box_01", nil, BB["Fras Siabi"], nil },
				{ 25, 13172 },	-- Siabi's Premium Tobacco
			},
		},
		{	--Miscellaneous Sets
			name = AL["Miscellaneous"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:4",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local STOCKADE_LOOT = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(464), nil },	--Hogger
	{ 2, 2168 },	-- Corpse Rompers
	{ 3, 1934 },	-- Hogger's Trousers
	{ 4, 1959 },	-- Cold Iron Pick
	{ 6, "ac633" },
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(465), nil },	--Lord Overheat
	{ 17, 1929 },	-- Silk-Threaded Trousers
	{ 18, 5967 },	-- Girdle of Nobility
	{ 19, 4676 },	-- Skeletal Gauntlets
	{ 20, 62305, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Lord Overheat's Fiery Core
	{ 22, "INV_Box_01", nil, EJ_GetEncounterInfo(466), nil },	--Randolph Moloch
	{ 23, 63345 },	-- Noble's Robe
	{ 24, 63344 },	-- Standard Issue Prisoner Shoes
	{ 25, 63346 },	-- Wicked Dagger
}
data["TheStockade"] = {
	EncounterJournalID = 238,
	MapID = 690,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Hogger
			EncounterJournalID = 464,
			[NORMAL_DIFF] = STOCKADE_LOOT,
		},
		{	--Lord Overheat
			EncounterJournalID = 465,
			[NORMAL_DIFF] = STOCKADE_LOOT,
		},
		{	--Randolph Moloch
			EncounterJournalID = 466,
			[NORMAL_DIFF] = STOCKADE_LOOT,
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["TheSunkenTemple"] = {
	EncounterJournalID = 237,
	MapID = 687,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--STAvatarofHakkar
			EncounterJournalID = 457,
			[NORMAL_DIFF] = {
				{ 1, 12462 },	-- Embrace of the Wind Serpent
				{ 3, 10843 },	-- Featherskin Cape
				{ 4, 10842 },	-- Windscale Sarong
				{ 5, 10846 },	-- Bloodshot Greaves
				{ 6, 10845 },	-- Warrior's Embrace
				{ 7, 10838 },	-- Might of Hakkar
				{ 8, 10844 },	-- Spire of Hakkar
			},
		},
		{	--STJammalanandOgom
			EncounterJournalID = 458,
			[NORMAL_DIFF] = {
				{ 1, 10806 },	-- Vestments of the Atal'ai Prophet
				{ 2, 10808 },	-- Gloves of the Atal'ai Prophet
				{ 3, 10807 },	-- Kilt of the Atal'ai Prophet
				{ 5, 6212, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Head of Jammal'an
				{ 16, "INV_Box_01", nil, BB["Ogom the Wretched"], nil },
				{ 17, 10805 },	-- Eater of the Dead
				{ 18, 10804 },	-- Fist of the Damned
				{ 19, 10803 },	-- Blade of the Wretched
			},
		},
		{	--STDragons
			EncounterJournalID = 459,
			[NORMAL_DIFF] = {
				{ 1, 12465 },	-- Nightfall Drape
				{ 2, 12466 },	-- Dawnspire Cord
				{ 3, 12464 },	-- Bloodfire Talons
				{ 4, 10795 },	-- Drakeclaw Band
				{ 5, 10796 },	-- Drakestone
				{ 6, 10797 },	-- Firebreather
				{ 7, 12463 },	-- Drakefang Butcher
				{ 8, 12243 },	-- Smoldering Claw
			},
		},
		{	--STEranikus
			EncounterJournalID = 463,
			[NORMAL_DIFF] = {
				{ 1, 10847 },	-- Dragon's Call
				{ 3, 10833 },	-- Horns of Eranikus
				{ 4, 10829 },	-- The Dragon's Eye
				{ 5, 10828 },	-- Dire Nail
				{ 6, 10837 },	-- Tooth of Eranikus
				{ 7, 10835 },	-- Crest of Supremacy
				{ 8, 10836 },	-- Rod of Corrosion
				{ 16, "ac641" },
			},
		},
		{	--STTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 10630 },	-- Soulcatcher Halo
				{ 2, 10629 },	-- Mistwalker Boots
				{ 3, 10632 },	-- Slimescale Bracers
				{ 4, 10631 },	-- Murkwater Gauntlets
				{ 5, 10633 },	-- Silvershell Leggings
				{ 6, 10634 },	-- Mindseye Circle
				{ 8, 15733 },	-- Pattern: Green Dragonscale Leggings
				{ 16, 10623 },	-- Winter's Bite
				{ 17, 10625 },	-- Stealthblade
				{ 18, 10628 },	-- Deathblow
				{ 19, 10626 },	-- Ragehammer
				{ 20, 10627 },	-- Bludgeon of the Grinning Dog
				{ 21, 10624 },	-- Stinging Bow
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local ULDAMAN_LOOT = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(467), nil },	--Revelosh
	{ 2, 9390 },	-- Revelosh's Gloves
	{ 3, 9389 },	-- Revelosh's Spaulders
	{ 4, 9388 },	-- Revelosh's Armguards
	{ 5, 9387 },	-- Revelosh's Boots
	{ 7, "INV_Box_01", nil, EJ_GetEncounterInfo(469), nil },	--Ironaya
	{ 8, 9407 },	-- Stoneweaver Leggings
	{ 9, 9409 },	-- Ironaya's Bracers
	{ 10, 9408 },	-- Ironshod Bludgeon
	{ 12, "INV_Box_01", nil, EJ_GetEncounterInfo(470), nil },	--Ancient Stone Keeper
	{ 13, 9411 },	-- Rockshard Pauldrons
	{ 14, 9410 },	-- Cragfists
	{ 15, 62055, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Titan Power Core
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(471), nil },	--Galgann Firehammer
	{ 17, 11311 },	-- Emberscale Cape
	{ 18, 11310 },	-- Flameseer Mantle
	{ 19, 9419 },	-- Galgann's Firehammer
	{ 20, 9412 },	-- Galgann's Fireblaster
	{ 21, "INV_Box_01", nil, EJ_GetEncounterInfo(472), nil },	--Grimlok
	{ 22, 9415 },	-- Grimlok's Tribal Vestments
	{ 23, 9414 },	-- Oilskin Leggings
	{ 24, 9416 },	-- Grimlok's Charge
	{ 25, "INV_Box_01", nil, EJ_GetEncounterInfo(473), nil },	--Archaedas
	{ 26, 11118 },	-- Archaedic Stone
	{ 27, 9418 },	-- Stoneslayer
	{ 28, 9413 },	-- The Rockpounder
	{ 30, "ac638" },
}
data["Uldaman"] = {
	EncounterJournalID = 239,
	MapID = 692,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--UldDwarves
			EncounterJournalID = 468,
			[NORMAL_DIFF] = {
				{ 1, "INV_Box_01", nil, BB["Baelog"], nil },
				{ 2, 9401 },	-- Nordic Longshank
				{ 3, 9400 },	-- Baelog's Shortbow
				{ 5, "INV_Box_01", nil, BB["Eric \"The Swift\""], nil },
				{ 6, 9394 },	-- Horned Viking Helmet
				{ 7, 9398 },	-- Worn Running Boots
				{ 8, 2459 },	-- Swiftness Potion
				{ 16, "INV_Box_01", nil, BB["Olaf"], nil },
				{ 17, 9404 },	-- Olaf's All Purpose Shield
				{ 18, 9403 },	-- Battered Viking Shield
				{ 19, 1177 },	-- Oil of Olaf
			},
		},
		{	--Revelosh
			EncounterJournalID = 467,
			[NORMAL_DIFF] = ULDAMAN_LOOT,
		},
		{	--Ironaya
			EncounterJournalID = 469,
			[NORMAL_DIFF] = ULDAMAN_LOOT,
		},
		{	--Ancient Stone Keeper
			EncounterJournalID = 470,
			[NORMAL_DIFF] = ULDAMAN_LOOT,
		},
		{	--Galgann Firehammer
			EncounterJournalID = 471,
			[NORMAL_DIFF] = ULDAMAN_LOOT,
		},
		{	--Grimlok
			EncounterJournalID = 472,
			[NORMAL_DIFF] = ULDAMAN_LOOT,
		},
		{	--Archaedas
			EncounterJournalID = 473,
			[NORMAL_DIFF] = ULDAMAN_LOOT,
		},
		{	--UldTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 9397 },	-- Energy Cloak
				{ 2, 9431 },	-- Papal Fez
				{ 3, 9429 },	-- Miner's Hat of the Deep
				{ 4, 9420 },	-- Adventurer's Pith Helmet
				{ 5, 9430 },	-- Spaulders of a Lost Age
				{ 6, 9406 },	-- Spirewind Fetter
				{ 7, 9428 },	-- Unearthed Bands
				{ 8, 9396 },	-- Legguards of the Vault
				{ 9, 9432 },	-- Skullplate Bracers
				{ 10, 9393 },	-- Beacon of Hope
				{ 12, "INV_Box_01", nil, EJ_GetEncounterInfo(748), nil },	--Obsidian Sentinel
				{ 13, 62053 },	-- Obsidian Power Core
				{ 16, 9384 },	-- Stonevault Shiv
				{ 17, 9392 },	-- Annealed Blade
				{ 18, 9424 },	-- Ginn-Su Sword
				{ 19, 9465 },	-- Digmaster 5000
				{ 20, 9383 },	-- Obsidian Cleaver
				{ 21, 9425 },	-- Pendulum of Doom
				{ 22, 9386 },	-- Excavator's Brand
				{ 23, 9427 },	-- Stonevault Bonebreaker
				{ 24, 9423 },	-- The Jackhammer
				{ 25, 9391 },	-- The Shoveler
				{ 26, 9381 },	-- Earthen Rod
				{ 27, 9426 },	-- Monolithic Bow
				{ 28, 9422 },	-- Shadowforge Bushmaster
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local WAILING_CAVERNS_LOOT1 = {
	{ 1, "INV_Box_01", nil, BB["Boahn"].." ("..AL["Rare"]..", "..AL["Entrance"]..")", nil },
	{ 2, 5423 },	-- Boahn's Fang
	{ 3, 5422 },	-- Brambleweed Leggings
	{ 5, "INV_Box_01", nil, BB["Trigore the Lasher"].." ("..AL["Rare"]..", "..AL["Entrance"]..")", nil },
	{ 6, 5425 },	-- Runescale Girdle
	{ 7, 5426 },	-- Serpent's Kiss
	{ 9, "INV_Box_01", nil, EJ_GetEncounterInfo(474), nil },	--Lady Anacondra
	{ 10, 5404 },	-- Serpent's Shoulders
	{ 11, 10412 },	-- Belt of the Fang
	{ 12, 6446 },	-- Snakeskin Bag
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(476), nil },	--Lord Pythas
	{ 17, 6473 },	-- Armor of the Fang
	{ 18, 6472 },	-- Stinging Viper
	{ 20, "INV_Box_01", nil, EJ_GetEncounterInfo(475), nil },	--Lord Cobrahn
	{ 21, 6465 },	-- Robe of the Moccasin
	{ 22, 10410 },	-- Leggings of the Fang
	{ 23, 6460 },	-- Cobrahn's Grasp
	{ 25, "INV_Box_01", nil, EJ_GetEncounterInfo(477), nil },	--Kres-h
	{ 26, 13245 },	-- Kresh's Back
	{ 27, 6447 },	-- Worn Turtle Shell Shield
}
local WAILING_CAVERNS_LOOT2 = {
	{ 1, "INV_Box_01", nil, EJ_GetEncounterInfo(478), nil },	--Skum
	{ 2, 6449 },	-- Glowing Lizardscale Cloak
	{ 3, 6448 },	-- Tail Spike
	{ 5, "INV_Box_01", nil, BB["Deviate Faerie Dragon"].." ("..AL["Rare"]..")", nil },
	{ 6, 6632 },	-- Feyscale Cloak
	{ 7, 5243 },	-- Firebelcher
	{ 9, "INV_Box_01", nil, EJ_GetEncounterInfo(479), nil },	--Lord Serpentis
	{ 10, 5970 },	-- Serpent Gloves
	{ 11, 10411 },	-- Footpads of the Fang
	{ 12, 6459 },	-- Savage Trodders
	{ 13, 6469 },	-- Venomstrike
	{ 16, "INV_Box_01", nil, EJ_GetEncounterInfo(480), nil },	--Verdan the Everliving
	{ 17, 6629 },	-- Sporid Cape
	{ 18, 6631 },	-- Living Root
	{ 19, 6630 },	-- Seedcloud Buckler
	{ 21, "INV_Box_01", nil, EJ_GetEncounterInfo(481), nil },	--Mutanus the Devourer
	{ 22, 6461 },	-- Slime-Encrusted Pads
	{ 23, 6627 },	-- Mutant Scale Breastplate
	{ 24, 6463 },	-- Deep Fathom Ring
	{ 26, "ac630" },
	{ 28, "INV_Box_01", nil, AL["Trash Mobs"], nil },
	{ 29, 10413 },	-- Gloves of the Fang

}
data["WailingCaverns"] = {
	EncounterJournalID = 240,
	MapID = 749,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--Boahn
			name = BB["Boahn"].." ("..AL["Rare"]..", "..AL["Entrance"]..")",
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Trigore the Lasher
			name = BB["Trigore the Lasher"].." ("..AL["Rare"]..", "..AL["Entrance"]..")",
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Lady Anacondra
			EncounterJournalID = 474,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Lord Pythas
			EncounterJournalID = 476,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Lord Cobrahn
			EncounterJournalID = 475,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Kres-h
			EncounterJournalID = 477,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT1,
		},
		{	--Skum
			EncounterJournalID = 478,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Deviate Faerie Dragon
			name = BB["Deviate Faerie Dragon"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Lord Serpentis
			EncounterJournalID = 479,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Verdan the Everliving
			EncounterJournalID = 480,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Mutanus the Devourer
			EncounterJournalID = 481,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Trash Mobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = WAILING_CAVERNS_LOOT2,
		},
		{	--Miscellaneous Sets
			name = AL["Miscellaneous"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:4",
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

data["ZulFarrak"] = {
	EncounterJournalID = 241,
	MapID = 686,
	ContentType = DUNGEON_CONTENT,
	items = {
		{	--ZFZerillis
			name = BB["Zerillis"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12470 },	-- Sandstalker Ankleguards
			},
		},
		{	--ZFHydromancerVelratha
			EncounterJournalID = 482,
			[NORMAL_DIFF] = {
				{ 1, 9234, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Tiara of the Deep
			},
		},
		{	--ZFGahzrilla
			EncounterJournalID = 483,
			[NORMAL_DIFF] = {
				{ 1, 9469 },	-- Gahz'rilla Scale Armor
				{ 2, 9467 },	-- Gahz'rilla Fang
				{ 4, 8707, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Gahz'rilla's Electrified Scale
			},
		},
		{	--ZFSezzziz
			EncounterJournalID = 487,
			[NORMAL_DIFF] = {
				{ 1, 9470 },	-- Bad Mojo Mask
				{ 2, 9473 },	-- Jinxed Hoodoo Skin
				{ 3, 9474 },	-- Jinxed Hoodoo Kilt
				{ 4, 9475 },	-- Diabolic Skiver
			},
		},
		{	--ZFDustwraith
			name = BB["Dustwraith"].." ("..AL["Rare"]..")",
			[NORMAL_DIFF] = {
				{ 1, 12471 },	-- Desertwalker Cane
			},
		},
		{	--ZFWitchDoctorZumrah
			EncounterJournalID = 486,
			[NORMAL_DIFF] = {
				{ 1, 18083 },	-- Jumanza Grips
				{ 2, 18082 },	-- Zum'rah's Vexing Cane
			},
		},
		{	--ZFAntusul
			EncounterJournalID = 484,
			[NORMAL_DIFF] = {
				{ 1, 9640 },	-- Vice Grips
				{ 2, 9641 },	-- Lifeblood Amulet
				{ 3, 9639 },	-- The Hand of Antu'sul
				{ 5, 9379 },	-- Sang'thraze the Deflector
				{ 6, 9372, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sul'thraze the Lasher
			},
		},
		{	--ZFChiefUkorzSandscalp
			EncounterJournalID = 489,
			[NORMAL_DIFF] = {
				{ 1, 9479 },	-- Embrace of the Lycan
				{ 2, 9476 },	-- Big Bad Pauldrons
				{ 3, 9478 },	-- Ripsaw
				{ 4, 9477 },	-- The Chief's Enforcer
				{ 6, 11086 },	-- Jang'thraze the Protector
				{ 7, 9372, [ATLASLOOT_IT_FILTERIGNORE] = true },	-- Sul'thraze the Lasher
				{ 16, "ac639" },
			},
		},
		{	--ZFTrash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 9512 },	-- Blackmetal Cape
				{ 2, 9484 },	-- Spellshock Leggings
				{ 3, 9243 },	-- Shriveled Troll Heart
				{ 4, 862 },	-- Runed Ring
				{ 5, 6440 },	-- Brainlash
				{ 16, 5616 },	-- Gutwrencher
				{ 17, 9511 },	-- Bloodletter Scalpel
				{ 18, 9481 },	-- The Minotaur
				{ 19, 9480 },	-- Eyegouger
				{ 20, 9482 },	-- Witch Doctor's Cane
				{ 21, 9483 },	-- Flaming Incinerator
				{ 22, 2040 },	-- Troll Protector
			},
		},
		CLASSIC_INSTANCE_AC_TABLE,
	}
}

local AQ_ENCHANTS = {
	{ 1, 20728 },	-- Formula: Enchant Gloves - Frost Power
	{ 2, 20731 },	-- Formula: Enchant Gloves - Superior Agility
	{ 3, 20734 },	-- Formula: Enchant Cloak - Stealth
	{ 4, 20729 },	-- Formula: Enchant Gloves - Fire Power
	{ 5, 20736 },	-- Formula: Enchant Cloak - Dodge
	{ 6, 20730 },	-- Formula: Enchant Gloves - Healing Power
	{ 7, 20727 },	-- Formula: Enchant Gloves - Shadow Power
}
data["AhnQiraj"] = {
	name = ALIL["Ahn'Qiraj"],
	MapID = 766,
	ContentType = RAID_CONTENT,
	items = {
		{	--AQ40Skeram
			name = BB["The Prophet Skeram"],
			[NORMAL_DIFF] = {
				{ 1, 21701 },	-- Cloak of Concentrated Hatred
				{ 2, 21708 },	-- Beetle Scaled Wristguards
				{ 3, 21698 },	-- Leggings of Immersion
				{ 4, 21699 },	-- Barrage Shoulders
				{ 5, 21705 },	-- Boots of the Fallen Prophet
				{ 6, 21814 },	-- Breastplate of Annihilation
				{ 7, 21704 },	-- Boots of the Redeemed Prophecy
				{ 8, 21706 },	-- Boots of the Unwavering Will
				{ 10, 21702 },	-- Amulet of Foul Warding
				{ 11, 21700 },	-- Pendant of the Qiraji Guardian
				{ 12, 21707 },	-- Ring of Swarming Thought
				{ 13, 21703 },	-- Hammer of Ji'zhi
				{ 14, 21128 },	-- Staff of the Qiraji Prophets
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
				{ 27, 22222 },	-- Plans: Thick Obsidian Breastplate
				{ 29, 93041, "pet1156" },	-- Jewel of Maddening Whispers
			},
		},
		{	--AQ40BugFam
			name = BB["The Bug Family"],
			[NORMAL_DIFF] = {
				{ 1, 21697 },	-- Cape of the Trinity
				{ 2, 21694 },	-- Ternary Mantle
				{ 3, 21696 },	-- Robes of the Triumvirate
				{ 4, 21693 },	-- Guise of the Devourer
				{ 5, 21692 },	-- Triad Girdle
				{ 6, 21695 },	-- Angelista's Touch
				{ 8, 21237 },	-- Imperial Qiraji Regalia
				{ 9, 21232 },	-- Imperial Qiraji Armaments
				{ 11, "INV_Box_01", nil, BB["Lord Kri"], nil },
				{ 12, 21680 },	-- Vest of Swift Execution
				{ 13, 21603 },	-- Wand of Qiraji Nobility
				{ 14, 21681 },	-- Ring of the Devoured
				{ 15, 21685 },	-- Petrified Scarab
				{ 16, "INV_Box_01", nil, BB["Princess Yauj"], nil },
				{ 17, 21686 },	-- Mantle of Phrenic Power
				{ 18, 21682 },	-- Bile-Covered Gauntlets
				{ 19, 21684 },	-- Mantle of the Desert's Fury
				{ 20, 21683 },	-- Mantle of the Desert Crusade
				{ 21, 21687 },	-- Ukko's Ring of Darkness
				{ 23, "INV_Box_01", nil, BB["Vem"], nil },
				{ 24, 21689 },	-- Gloves of Ebru
				{ 25, 21691 },	-- Ooze-Ridden Gauntlets
				{ 26, 21688 },	-- Boots of the Fallen Hero
				{ 27, 21690 },	-- Angelista's Charm
			},
		},
		{	--AQ40Sartura
			name = BB["Battleguard Sartura"],
			[NORMAL_DIFF] = {
				{ 1, 21671 },	-- Robes of the Battleguard
				{ 2, 21676 },	-- Leggings of the Festering Swarm
				{ 3, 21648 },	-- Recomposed Boots
				{ 4, 21669 },	-- Creeping Vine Helm
				{ 5, 21672 },	-- Gloves of Enforcement
				{ 6, 21675 },	-- Thick Qirajihide Belt
				{ 7, 21668 },	-- Scaled Leggings of Qiraji Fury
				{ 8, 21674 },	-- Gauntlets of Steadfast Determination
				{ 9, 21667 },	-- Legplates of Blazing Light
				{ 11, 21678 },	-- Necklace of Purity
				{ 12, 21670 },	-- Badge of the Swarmguard
				{ 13, 21666 },	-- Sartura's Might
				{ 14, 21673 },	-- Silithid Claw
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40Fankriss
			name = BB["Fankriss the Unyielding"],
			[NORMAL_DIFF] = {
				{ 1, 21627 },	-- Cloak of Untold Secrets
				{ 2, 21663 },	-- Robes of the Guardian Saint
				{ 3, 21665 },	-- Mantle of Wicked Revenge
				{ 4, 21645 },	-- Hive Tunneler's Boots
				{ 5, 21651 },	-- Scaled Sand Reaver Leggings
				{ 6, 21639 },	-- Pauldrons of the Unrelenting
				{ 7, 21652 },	-- Silithid Carapace Chestguard
				{ 9, 21647 },	-- Fetish of the Sand Reaver
				{ 10, 21664 },	-- Barbed Choker
				{ 11, 21650 },	-- Ancient Qiraji Ripper
				{ 12, 21635 },	-- Barb of the Sand Reaver
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40Viscidus
			name = BB["Viscidus"],
			[NORMAL_DIFF] = {
				{ 1, 21624 },	-- Gauntlets of Kalimdor
				{ 2, 21626 },	-- Slime-Coated Leggings
				{ 3, 21623 },	-- Gauntlets of the Righteous Champion
				{ 5, 21677 },	-- Ring of the Qiraji Fury
				{ 6, 21625 },	-- Scarab Brooch
				{ 7, 21622 },	-- Sharpened Silithid Femur
				{ 9, 20932 },	-- Qiraji Bindings of Dominance
				{ 10, 20928 },	-- Qiraji Bindings of Command
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
				{ 27, 93039, "pet1154" },	-- Viscidus Globule
			},
		},
		{	--AQ40Huhuran
			name = BB["Princess Huhuran"],
			[NORMAL_DIFF] = {
				{ 1, 21619 },	-- Gloves of the Messiah
				{ 2, 21621 },	-- Cloak of the Golden Hive
				{ 3, 21617 },	-- Wasphide Gauntlets
				{ 4, 21618 },	-- Hive Defiler Wristguards
				{ 6, 21620 },	-- Ring of the Martyr
				{ 7, 21616 },	-- Huhuran's Stinger
				{ 9, 20932 },	-- Qiraji Bindings of Dominance
				{ 10, 20928 },	-- Qiraji Bindings of Command
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40Emperors
			name = BB["The Twin Emperors"],
			[NORMAL_DIFF] = {
				{ 1, 20930 },	-- Vek'lor's Diadem
				{ 2, 21600 },	-- Boots of Epiphany
				{ 3, 21602 },	-- Qiraji Execution Bracers
				{ 4, 21599 },	-- Vek'lor's Gloves of Devastation
				{ 5, 21598 },	-- Royal Qiraji Belt
				{ 6, 21597 },	-- Royal Scepter of Vek'lor
				{ 7, 21601 },	-- Ring of Emperor Vek'lor
				{ 8, 20735 },	-- Formula: Enchant Cloak - Subtlety
				{ 9, 93040, "pet1155" },	-- Anubisath Idol
				{ 11, 21232 },	-- Imperial Qiraji Armaments
				{ 12, 21242 },	-- Blessed Qiraji War Axe
				{ 13, 21272 },	-- Blessed Qiraji Musket
				{ 14, 21244 },	-- Blessed Qiraji Pugio
				{ 15, 21269 },	-- Blessed Qiraji Bulwark
				{ 16, 20926 },	-- Vek'nilash's Circlet
				{ 17, 21604 },	-- Bracelets of Royal Redemption
				{ 18, 21605 },	-- Gloves of the Hidden Temple
				{ 19, 21609 },	-- Regenerating Belt of Vek'nilash
				{ 20, 21607 },	-- Grasp of the Fallen Emperor
				{ 21, 21606 },	-- Belt of the Fallen Emperor
				{ 22, 21679 },	-- Kalimdor's Revenge
				{ 23, 21608 },	-- Amulet of Vek'nilash
				{ 24, 20726 },	-- Formula: Enchant Gloves - Threat
				{ 26, 21237 },	-- Imperial Qiraji Regalia
				{ 27, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 28, 21275 },	-- Blessed Qiraji Augur Staff
				{ 29, 21268 },	-- Blessed Qiraji War Hammer
			},
		},
		{	--AQ40Ouro
			name = BB["Ouro"],
			[NORMAL_DIFF] = {
				{ 1, 21615 },	-- Don Rigoberto's Lost Hat
				{ 2, 21611 },	-- Burrower Bracers
				{ 3, 23558 },	-- The Burrower's Shell
				{ 4, 23570 },	-- Jom Gabbar
				{ 5, 23557 },	-- Larvae of the Great Worm
				{ 6, 21610 },	-- Wormscale Blocker
				{ 8, 20927 },	-- Ouro's Intact Hide
				{ 9, 20931 },	-- Skin of the Great Sandworm
				{ 16, 21237 },	-- Imperial Qiraji Regalia
				{ 17, 21273 },	-- Blessed Qiraji Acolyte Staff
				{ 18, 21275 },	-- Blessed Qiraji Augur Staff
				{ 19, 21268 },	-- Blessed Qiraji War Hammer
				{ 21, 21232 },	-- Imperial Qiraji Armaments
				{ 22, 21242 },	-- Blessed Qiraji War Axe
				{ 23, 21272 },	-- Blessed Qiraji Musket
				{ 24, 21244 },	-- Blessed Qiraji Pugio
				{ 25, 21269 },	-- Blessed Qiraji Bulwark
			},
		},
		{	--AQ40CThun
			name = BB["C'Thun"],
			[NORMAL_DIFF] = {
				{ 1, 21583 },	-- Cloak of Clarity
				{ 2, 22731 },	-- Cloak of the Devoured
				{ 3, 21585 },	-- Dark Storm Gauntlets
				{ 4, 22730 },	-- Eyestalk Waist Cord
				{ 5, 21582 },	-- Grasp of the Old God
				{ 6, 21586 },	-- Belt of Never-Ending Agony
				{ 7, 21581 },	-- Gauntlets of Annihilation
				{ 9, 22732 },	-- Mark of C'Thun
				{ 10, 21596 },	-- Ring of the Godslayer
				{ 11, 21579 },	-- Vanquished Tentacle of C'Thun
				{ 12, 21126 },	-- Death's Sting
				{ 13, 21134 },	-- Dark Edge of Insanity
				{ 14, 21839 },	-- Scepter of the False Prophet
				{ 16, 20933 },	-- Husk of the Old God
				{ 17, 20929 },	-- Carapace of the Old God
				{ 19, 21221 },	-- Eye of C'Thun
				{ 20, 21710 },	-- Cloak of the Fallen God
				{ 21, 21712 },	-- Amulet of the Fallen God
				{ 22, 21709 },	-- Ring of the Fallen God
				{ 24, "ac687" },
			},
		},
		{	--AQ40Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 21838 },	-- Garb of Royal Ascension
				{ 2, 21888 },	-- Gloves of the Immortal
				{ 3, 21889 },	-- Gloves of the Redeemed Prophecy
				{ 4, 21836 },	-- Ritssyn's Ring of Chaos
				{ 5, 21891 },	-- Shard of the Fallen Star
				{ 6, 21856 },	-- Neretzek, The Blood Drinker
				{ 7, 21837 },	-- Anubisath Warhammer
				{ 9, 22202 },	-- Small Obsidian Shard
				{ 10, 22203 },	-- Large Obsidian Shard
				{ 16, 21218, "mount" },	-- Blue Qiraji Resonating Crystal
				{ 17, 21323, "mount" },	-- Green Qiraji Resonating Crystal
				{ 18, 21321, "mount" },	-- Red Qiraji Resonating Crystal
				{ 19, 21324, "mount" },	-- Yellow Qiraji Resonating Crystal
				{ 101, 20876 },	-- Idol of Death
				{ 102, 20879 },	-- Idol of Life
				{ 103, 20875 },	-- Idol of Night
				{ 104, 20878 },	-- Idol of Rebirth
				{ 105, 20881 },	-- Idol of Strife
				{ 106, 20877 },	-- Idol of the Sage
				{ 107, 20874 },	-- Idol of the Sun
				{ 108, 20882 },	-- Idol of War
				{ 110, 21230 },	-- Ancient Qiraji Artifact
				{ 112, 21762 },	-- Greater Scarab Coffer Key
				{ 116, 20864 },	-- Bone Scarab
				{ 117, 20861 },	-- Bronze Scarab
				{ 118, 20863 },	-- Clay Scarab
				{ 119, 20862 },	-- Crystal Scarab
				{ 120, 20859 },	-- Gold Scarab
				{ 121, 20865 },	-- Ivory Scarab
				{ 122, 20860 },	-- Silver Scarab
				{ 123, 20858 },	-- Stone Scarab
			},
		},
		{	--AQ40Sets
			name = ALIL["Ahn'Qiraj"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:1",
		},
		{	--AQEnchants
			name = AL["AQ Enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = AQ_ENCHANTS,
		},
		{	--BroodofNozdormu
			FactionID = 910,
			CoinTexture = "Reputation",
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Factions:CLASSICFACTIONS:3",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["BlackwingLair"] = {
	name = ALIL["Blackwing Lair"],
	MapID = 755,
	ContentType = RAID_CONTENT,
	items = {
		{	--BWLRazorgore
			name = BB["Razorgore the Untamed"],
			[NORMAL_DIFF] = {
				{ 1, 16918 },	-- Netherwind Bindings
				{ 2, 16926 },	-- Bindings of Transcendence
				{ 3, 16934 },	-- Nemesis Bracers
				{ 4, 16911 },	-- Bloodfang Bracers
				{ 5, 16904 },	-- Stormrage Bracers
				{ 6, 16935 },	-- Dragonstalker's Bracers
				{ 7, 16943 },	-- Bracers of Ten Storms
				{ 8, 16959 },	-- Bracelets of Wrath
				{ 9, 16951 },	-- Judgement Bindings
				{ 16, 19337 },	-- The Black Book
				{ 17, 19336 },	-- Arcane Infused Gem
				{ 19, 19370 },	-- Mantle of the Blackwing Cabal
				{ 20, 19369 },	-- Gloves of Rapid Evolution
				{ 21, 19334 },	-- The Untamed Blade
				{ 22, 19335 },	-- Spineshatter
				{ 24, 93036, "pet1151" },	-- Unscathed Egg
			},
		},
		{	--BWLVaelastrasz
			name = BB["Vaelastrasz the Corrupt"],
			[NORMAL_DIFF] = {
				{ 1, 16818 },	-- Netherwind Belt
				{ 2, 16925 },	-- Belt of Transcendence
				{ 3, 16933 },	-- Nemesis Belt
				{ 4, 16936 },	-- Dragonstalker's Belt
				{ 5, 16903 },	-- Stormrage Belt
				{ 6, 16910 },	-- Bloodfang Belt
				{ 7, 16944 },	-- Belt of Ten Storms
				{ 8, 16960 },	-- Waistband of Wrath
				{ 9, 16952 },	-- Judgement Belt
				{ 16, 19339 },	-- Mind Quickening Gem
				{ 17, 19340 },	-- Rune of Metamorphosis
				{ 19, 19372 },	-- Helm of Endless Rage
				{ 20, 19371 },	-- Pendant of the Fallen Dragon
				{ 21, 19346 },	-- Dragonfang Blade
				{ 22, 19348 },	-- Red Dragonscale Protector
			},
		},
		{	--BWLLashlayer
			name = BB["Broodlord Lashlayer"],
			[NORMAL_DIFF] = {
				{ 1, 16912 },	-- Netherwind Boots
				{ 2, 16919 },	-- Boots of Transcendence
				{ 3, 16927 },	-- Nemesis Boots
				{ 4, 16898 },	-- Stormrage Boots
				{ 5, 16906 },	-- Bloodfang Boots
				{ 6, 16941 },	-- Dragonstalker's Greaves
				{ 7, 16949 },	-- Greaves of Ten Storms
				{ 8, 16965 },	-- Sabatons of Wrath
				{ 9, 16957 },	-- Judgement Sabatons
				{ 16, 19342 },	-- Venomous Totem
				{ 17, 19341 },	-- Lifegiving Gem
				{ 19, 19374 },	-- Bracers of Arcane Accuracy
				{ 20, 19373 },	-- Black Brood Pauldrons
				{ 21, 19351 },	-- Maladath, Runed Blade of the Black Flight
				{ 22, 19350 },	-- Heartstriker
				{ 24, 93037, "pet1153" },	-- Blackwing Banner
			},
		},
		{	--BWLFiremaw
			name = BB["Firemaw"],
			[NORMAL_DIFF] = {
				{ 1, 16913 },	-- Netherwind Gloves
				{ 2, 16920 },	-- Handguards of Transcendence
				{ 3, 16928 },	-- Nemesis Gloves
				{ 4, 16907 },	-- Bloodfang Gloves
				{ 5, 16940 },	-- Dragonstalker's Gauntlets
				{ 6, 16899 },	-- Stormrage Handguards
				{ 7, 16948 },	-- Gauntlets of Ten Storms
				{ 8, 16964 },	-- Gauntlets of Wrath
				{ 9, 16956 },	-- Judgement Gauntlets
				{ 11, 19365 },	-- Claw of the Black Drake
				{ 12, 19355 },	-- Shadow Wing Focus Staff
				{ 13, 19353 },	-- Drake Talon Cleaver
				{ 16, 19343 },	-- Scrolls of Blinding Light
				{ 17, 19344 },	-- Natural Alignment Crystal
				{ 19, 19398 },	-- Cloak of Firemaw
				{ 20, 19400 },	-- Firemaw's Clutch
				{ 21, 19399 },	-- Black Ash Robe
				{ 22, 19396 },	-- Taut Dragonhide Belt
				{ 23, 19401 },	-- Primalist's Linked Legguards
				{ 24, 19394 },	-- Drake Talon Pauldrons
				{ 25, 19402 },	-- Legguards of the Fallen Crusader
				{ 27, 19397 },	-- Ring of Blackrock
				{ 28, 19395 },	-- Rejuvenating Gem
			},
		},
		{	--BWLEbonroc
			name = BB["Ebonroc"],
			[NORMAL_DIFF] = {
				{ 1, 16913 },	-- Netherwind Gloves
				{ 2, 16920 },	-- Handguards of Transcendence
				{ 3, 16928 },	-- Nemesis Gloves
				{ 4, 16907 },	-- Bloodfang Gloves
				{ 5, 16940 },	-- Dragonstalker's Gauntlets
				{ 6, 16899 },	-- Stormrage Handguards
				{ 7, 16948 },	-- Gauntlets of Ten Storms
				{ 8, 16964 },	-- Gauntlets of Wrath
				{ 9, 16956 },	-- Judgement Gauntlets
				{ 16, 19345 },	-- Aegis of Preservation
				{ 18, 19407 },	-- Ebony Flame Gloves
				{ 19, 19405 },	-- Malfurion's Blessed Bulwark
				{ 20, 19396 },	-- Taut Dragonhide Belt
				{ 21, 19394 },	-- Drake Talon Pauldrons
				{ 23, 19403 },	-- Band of Forced Concentration
				{ 24, 19397 },	-- Ring of Blackrock
				{ 25, 19406 },	-- Drake Fang Talisman
				{ 26, 19395 },	-- Rejuvenating Gem
				{ 28, 19353 },	-- Drake Talon Cleaver
				{ 29, 19355 },	-- Shadow Wing Focus Staff
				{ 30, 19368 },	-- Dragonbreath Hand Cannon
			},
		},
		{	--BWLFlamegor
			name = BB["Flamegor"],
			[NORMAL_DIFF] = {
				{ 1, 16913 },	-- Netherwind Gloves
				{ 2, 16920 },	-- Handguards of Transcendence
				{ 3, 16928 },	-- Nemesis Gloves
				{ 4, 16907 },	-- Bloodfang Gloves
				{ 5, 16940 },	-- Dragonstalker's Gauntlets
				{ 6, 16899 },	-- Stormrage Handguards
				{ 7, 16948 },	-- Gauntlets of Ten Storms
				{ 8, 16964 },	-- Gauntlets of Wrath
				{ 9, 16956 },	-- Judgement Gauntlets
				{ 16, 19430 },	-- Shroud of Pure Thought
				{ 17, 19396 },	-- Taut Dragonhide Belt
				{ 18, 19433 },	-- Emberweave Leggings
				{ 19, 19394 },	-- Drake Talon Pauldrons
				{ 21, 19397 },	-- Ring of Blackrock
				{ 22, 19432 },	-- Circle of Applied Force
				{ 23, 19395 },	-- Rejuvenating Gem
				{ 24, 19431 },	-- Styleen's Impeding Scarab
				{ 26, 19353 },	-- Drake Talon Cleaver
				{ 27, 19357 },	-- Herald of Woe
				{ 28, 19355 },	-- Shadow Wing Focus Staff
				{ 29, 19367 },	-- Dragon's Touch
			},
		},
		{	--BWLChromaggus
			name = BB["Chromaggus"],
			[NORMAL_DIFF] = {
				{ 1, 16917 },	-- Netherwind Mantle
				{ 2, 16924 },	-- Pauldrons of Transcendence
				{ 3, 16932 },	-- Nemesis Spaulders
				{ 4, 16937 },	-- Dragonstalker's Spaulders
				{ 5, 16902 },	-- Stormrage Pauldrons
				{ 6, 16832 },	-- Bloodfang Spaulders
				{ 7, 16945 },	-- Epaulets of Ten Storms
				{ 8, 16953 },	-- Judgement Spaulders
				{ 9, 16961 },	-- Pauldrons of Wrath
				{ 11, 93038, "pet1152" },	-- Whistle of Chromatic Bone
				{ 16, 19386 },	-- Elementium Threaded Cloak
				{ 17, 19388 },	-- Angelista's Grasp
				{ 18, 19385 },	-- Empowered Leggings
				{ 19, 19391 },	-- Shimmering Geta
				{ 20, 19389 },	-- Taut Dragonhide Shoulderpads
				{ 21, 19390 },	-- Taut Dragonhide Gloves
				{ 22, 19393 },	-- Primalist's Linked Waistguard
				{ 23, 19392 },	-- Girdle of the Fallen Crusader
				{ 24, 19387 },	-- Chromatic Boots
				{ 26, 19347 },	-- Claw of Chromaggus
				{ 27, 19352 },	-- Chromatically Tempered Sword
				{ 28, 19349 },	-- Elementium Reinforced Bulwark
				{ 29, 19361 },	-- Ashjre'thul, Crossbow of Smiting
			},
		},
		{	--BWLNefarian
			name = BB["Nefarian"],
			[NORMAL_DIFF] = {
				{ 1, 16914 },	-- Netherwind Crown
				{ 2, 16916 },	-- Netherwind Robes
				{ 3, 16929 },	-- Nemesis Skullcap
				{ 4, 16931 },	-- Nemesis Robes
				{ 5, 16921 },	-- Halo of Transcendence
				{ 6, 16923 },	-- Robes of Transcendence
				{ 7, 16908 },	-- Bloodfang Hood
				{ 8, 16905 },	-- Bloodfang Chestpiece
				{ 9, 16900 },	-- Stormrage Cover
				{ 10, 16897 },	-- Stormrage Chestguard
				{ 11, 16939 },	-- Dragonstalker's Helm
				{ 12, 16942 },	-- Dragonstalker's Breastplate
				{ 13, 16947 },	-- Helmet of Ten Storms
				{ 14, 16950 },	-- Breastplate of Ten Storms
				{ 15, 16963 },	-- Helm of Wrath
				{ 16, 16966 },	-- Breastplate of Wrath
				{ 17, 16955 },	-- Judgement Crown
				{ 18, 16958 },	-- Judgement Breastplate
				{ 20, 19378 },	-- Cloak of the Brood Lord
				{ 21, 19375 },	-- Mish'undare, Circlet of the Mind Flayer
				{ 22, 19381 },	-- Boots of the Shadow Flame
				{ 23, 19380 },	-- Therazane's Link
				{ 25, 19377 },	-- Prestor's Talisman of Connivery
				{ 26, 19376 },	-- Archimtiros' Ring of Reckoning
				{ 27, 19382 },	-- Pure Elementium Band
				{ 28, 19379 },	-- Neltharion's Tear
				{ 101, 19003 },	-- Head of Nefarian
				{ 102, 19383 },	-- Master Dragonslayer's Medallion
				{ 103, 19384 },	-- Master Dragonslayer's Ring
				{ 104, 19366 },	-- Master Dragonslayer's Orb
				{ 106, "ac685" },
				{ 116, 19364 },	-- Ashkandi, Greatsword of the Brotherhood
				{ 117, 19363 },	-- Crul'shorukh, Edge of Chaos
				{ 118, 19360 },	-- Lok'amir il Romathis
				{ 119, 19356 },	-- Staff of the Shadow Flame
			},
		},
		{	--BWLTrashMobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 19436 },	-- Cloak of Draconic Might
				{ 2, 19437 },	-- Boots of Pure Thought
				{ 3, 19438 },	-- Ringo's Blizzard Boots
				{ 4, 19439 },	-- Interlaced Shadow Jerkin
				{ 5, 19434 },	-- Band of Dark Dominion
				{ 6, 19362 },	-- Doom's Edge
				{ 7, 19354 },	-- Draconic Avenger
				{ 8, 19358 },	-- Draconic Maul
				{ 9, 19435 },	-- Essence Gatherer
				{ 11, 18562 },	-- Elementium Ingot
				{ 16, "INV_Box_01", nil, AL["Master Elemental Shaper Krixix"], nil },
				{ 17, 44956 },	-- Goblin's Guide to Elementium
			},
		},
		{	--Tier 2 Sets
			name = format(AL["Tier %d Sets"], 2),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:16",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["MoltenCore"] = {
	name = ALIL["Molten Core"],
	MapID = 696,
	ContentType = RAID_CONTENT,
	items = {
		{	--MCLucifron
			name = BB["Lucifron"],
			DisplayIDs = {
				{ 13031 }
			},
			[NORMAL_DIFF] = {
				{ 1, 18872 },	-- Manastorm Leggings
				{ 2, 19145 },	-- Robe of Volatile Power
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 17109 },	-- Choker of Enlightenment
				{ 8, 18879 },	-- Heavy Dark Iron Ring
				{ 9, 19147 },	-- Ring of Spell Power
				{ 10, 18878 },	-- Sorcerous Dagger
				{ 11, 17077 },	-- Crimson Shocker
				{ 16, 16800 },	-- Arcanist Boots
				{ 17, 16805 },	-- Felheart Gloves
				{ 18, 16829 },	-- Cenarion Boots
				{ 19, 16837 },	-- Earthfury Boots
				{ 20, 16863 },	-- Gauntlets of Might
				{ 21, 16859 },	-- Lawbringer Boots
			},
		},
		{	--MCMagmadar
			name = BB["Magmadar"],
			DisplayIDs = {
				{ 10193 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 17065 },	-- Medallion of Steadfast Might
				{ 9, 18821 },	-- Quick Strike Ring
				{ 10, 18820 },	-- Talisman of Ephemeral Power
				{ 12, 19142 },	-- Fire Runed Grimoire
				{ 13, 18202 },	-- Eskhandar's Left Claw
				{ 14, 18203 },	-- Eskhandar's Right Claw
				{ 15, 18822 },	-- Obsidian Edged Blade
				{ 16, 17073 },	-- Earthshaker
				{ 17, 17069 },	-- Striker's Mark
				{ 19, 16796 },	-- Arcanist Leggings
				{ 20, 16814 },	-- Pants of Prophecy
				{ 21, 16810 },	-- Felheart Pants
				{ 22, 16822 },	-- Nightslayer Pants
				{ 23, 16847 },	-- Giantstalker's Leggings
				{ 24, 16835 },	-- Cenarion Leggings
				{ 25, 16843 },	-- Earthfury Legguards
				{ 26, 16855 },	-- Lawbringer Legplates
				{ 27, 16867 },	-- Legplates of Might
				{ 29, 93034, "pet1149" },	-- Blazing Rune
			},
		},
		{	--MCGehennas
			name = BB["Gehennas"],
			DisplayIDs = {
				{ 13030 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19145 },	-- Robe of Volatile Power
				{ 2, 18872 },	-- Manastorm Leggings
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18879 },	-- Heavy Dark Iron Ring
				{ 8, 19147 },	-- Ring of Spell Power
				{ 9, 18878 },	-- Sorcerous Dagger
				{ 10, 17077 },	-- Crimson Shocker
				{ 16, 16812 },	-- Gloves of Prophecy
				{ 17, 16826 },	-- Nightslayer Gloves
				{ 18, 16849 },	-- Giantstalker's Boots
				{ 19, 16839 },	-- Earthfury Gauntlets
				{ 20, 16862 },	-- Sabatons of Might
				{ 21, 16860 },	-- Lawbringer Gauntlets
			},
		},
		{	--MCGarr
			name = BB["Garr"],
			DisplayIDs = {
				{ 12110 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 18821 },	-- Quick Strike Ring
				{ 9, 18820 },	-- Talisman of Ephemeral Power
				{ 10, 19142 },	-- Fire Runed Grimoire
				{ 11, 17071 },	-- Gutgore Ripper
				{ 12, 18832 },	-- Brutality Blade
				{ 13, 18822 },	-- Obsidian Edged Blade
				{ 14, 17105 },	-- Aurastone Hammer
				{ 15, 17066 },	-- Drillborer Disk
				{ 16, 16795 },	-- Arcanist Crown
				{ 17, 16813 },	-- Circlet of Prophecy
				{ 18, 16808 },	-- Felheart Horns
				{ 19, 16846 },	-- Giantstalker's Helmet
				{ 20, 16834 },	-- Cenarion Helm
				{ 21, 16821 },	-- Nightslayer Cover
				{ 22, 16842 },	-- Earthfury Helmet
				{ 23, 16866 },	-- Helm of Might
				{ 24, 16854 },	-- Lawbringer Helm
				{ 26, 18564 },	-- Bindings of the Windseeker
				{ 27, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
			},
		},
		{	--MCShazzrah
			name = BB["Shazzrah"],
			DisplayIDs = {
				{ 13032 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19145 },	-- Robe of Volatile Power
				{ 2, 18872 },	-- Manastorm Leggings
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18879 },	-- Heavy Dark Iron Ring
				{ 8, 19147 },	-- Ring of Spell Power
				{ 9, 18878 },	-- Sorcerous Dagger
				{ 10, 17077 },	-- Crimson Shocker
				{ 16, 16801 },	-- Arcanist Gloves
				{ 17, 16803 },	-- Felheart Slippers
				{ 18, 16811 },	-- Boots of Prophecy
				{ 19, 16831 },	-- Cenarion Gloves
				{ 20, 16852 },	-- Giantstalker's Gloves
				{ 21, 16824 },	-- Nightslayer Boots
			},
		},
		{	--MCGeddon
			name = BB["Baron Geddon"],
			DisplayIDs = {
				{ 12129 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 17110 },	-- Seal of the Archmagus
				{ 9, 18821 },	-- Quick Strike Ring
				{ 10, 18820 },	-- Talisman of Ephemeral Power
				{ 11, 19142 },	-- Fire Runed Grimoire
				{ 12, 18822 },	-- Obsidian Edged Blade
				{ 16, 16797 },	-- Arcanist Mantle
				{ 17, 16807 },	-- Felheart Shoulder Pads
				{ 18, 16836 },	-- Cenarion Spaulders
				{ 19, 16856 },	-- Lawbringer Spaulders
				{ 20, 16844 },	-- Earthfury Epaulets
				{ 22, 18563 },	-- Bindings of the Windseeker
				{ 23, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
			},
		},
		{	--MCGolemagg
			name = BB["Golemagg the Incinerator"],
			DisplayIDs = {
				{ 11986 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19136 },	-- Mana Igniting Cord
				{ 2, 18823 },	-- Aged Core Leather Gloves
				{ 3, 18829 },	-- Deep Earth Spaulders
				{ 4, 19144 },	-- Sabatons of the Flamewalker
				{ 5, 19143 },	-- Flameguard Gauntlets
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18824 },	-- Magma Tempered Boots
				{ 8, 18821 },	-- Quick Strike Ring
				{ 9, 18820 },	-- Talisman of Ephemeral Power
				{ 10, 19142 },	-- Fire Runed Grimoire
				{ 11, 17103 },	-- Azuresong Mageblade
				{ 12, 18822 },	-- Obsidian Edged Blade
				{ 13, 18842 },	-- Staff of Dominance
				{ 14, 17072 },	-- Blastershot Launcher
				{ 16, 16798 },	-- Arcanist Robes
				{ 17, 16815 },	-- Robes of Prophecy
				{ 18, 16809 },	-- Felheart Robes
				{ 19, 16820 },	-- Nightslayer Chestpiece
				{ 20, 16833 },	-- Cenarion Vestments
				{ 21, 16845 },	-- Giantstalker's Breastplate
				{ 22, 16841 },	-- Earthfury Vestments
				{ 23, 16865 },	-- Breastplate of Might
				{ 24, 16853 },	-- Lawbringer Chestguard
				{ 26, 17203 },	-- Sulfuron Ingot
				{ 27, 17182 },	-- Sulfuras, Hand of Ragnaros
				{ 29, 93035, "pet1150" },	-- Core of Hardened Ash
			},
		},
		{	--MCSulfuron
			name = BB["Sulfuron Harbinger"],
			DisplayIDs = {
				{ 13030 }
			},
			[NORMAL_DIFF] = {
				{ 1, 19145 },	-- Robe of Volatile Power
				{ 2, 18872 },	-- Manastorm Leggings
				{ 3, 19146 },	-- Wristguards of Stability
				{ 4, 18875 },	-- Salamander Scale Pants
				{ 5, 18870 },	-- Helm of the Lifegiver
				{ 6, 18861 },	-- Flamewaker Legplates
				{ 7, 18879 },	-- Heavy Dark Iron Ring
				{ 8, 19147 },	-- Ring of Spell Power
				{ 9, 18878 },	-- Sorcerous Dagger
				{ 10, 17074 },	-- Shadowstrike
				{ 11, 17077 },	-- Crimson Shocker
				{ 16, 16816 },	-- Mantle of Prophecy
				{ 17, 16823 },	-- Nightslayer Shoulder Pads
				{ 18, 16848 },	-- Giantstalker's Epaulets
				{ 19, 16868 },	-- Pauldrons of Might
				{ 21, 93033, "pet1147" },	-- Mark of Flame
			},
		},
		{	--MCMajordomo
			name = BB["Majordomo Executus"],
			DisplayIDs = {
				{ 12029 }
			},
			[NORMAL_DIFF] = {
				{ 1, 18811 },	-- Fireproof Cloak
				{ 2, 18808 },	-- Gloves of the Hypnotic Flame
				{ 3, 18809 },	-- Sash of Whispered Secrets
				{ 4, 19139 },	-- Fireguard Shoulders
				{ 5, 18810 },	-- Wild Growth Spaulders
				{ 6, 18812 },	-- Wristguards of True Flight
				{ 7, 18806 },	-- Core Forged Greaves
				{ 8, 19140 },	-- Cauterizing Band
				{ 9, 18805 },	-- Core Hound Tooth
				{ 10, 18803 },	-- Finkle's Lava Dredger
			},
		},
		{	--MCRagnaros
			name = BB["Ragnaros"],
			DisplayIDs = {
				{ 11121 }
			},
			[RF_DIFF] = {
				{ 1, 118942 },	-- Crown of Power
				{ 2, 118941 },	-- Crown of Woe
				{ 3, 118939 },	-- Crown of Destruction
				{ 4, 118940 },	-- Crown of Desolation
				{ 16, 118572 },	-- Flames of Ragnaros
				{ 17, 118574, "pet1544" },	-- Hatespark the Tiny
				{ 19, "ac9550", "mount170347" },
			},
			[NORMAL_DIFF] = {
				{ 1, 16915 },	-- Netherwind Pants
				{ 2, 16922 },	-- Leggings of Transcendence
				{ 3, 16930 },	-- Nemesis Leggings
				{ 4, 16909 },	-- Bloodfang Pants
				{ 5, 16901 },	-- Stormrage Legguards
				{ 6, 16938 },	-- Dragonstalker's Legguards
				{ 7, 16946 },	-- Legplates of Ten Storms
				{ 8, 16962 },	-- Legplates of Wrath
				{ 9, 16954 },	-- Judgement Legplates
				{ 11, 17204 },	-- Eye of Sulfuras
				{ 12, 17182 },	-- Sulfuras, Hand of Ragnaros
				{ 14, 19017 },	-- Essence of the Firelord
				{ 15, 19019 },	-- Thunderfury, Blessed Blade of the Windseeker
				{ 16, 17102 },	-- Cloak of the Shrouded Mists
				{ 17, 17107 },	-- Dragon's Blood Cape
				{ 18, 18817 },	-- Crown of Destruction
				{ 19, 19137 },	-- Onslaught Girdle
				{ 20, 18814 },	-- Choker of the Fire Lord
				{ 21, 19138 },	-- Band of Sulfuras
				{ 22, 17063 },	-- Band of Accuria
				{ 23, 17082 },	-- Shard of the Flame
				{ 24, 18815 },	-- Essence of the Pure Flame
				{ 25, 18816 },	-- Perdition's Blade
				{ 26, 17076 },	-- Bonereaver's Edge
				{ 27, 17104 },	-- Spinal Reaper
				{ 28, 17106 },	-- Malistar's Defender
				{ 30, "ac686" },
			},
		},
		{	--MCRANDOMBOSSDROPPS
			name = AL["Shared Boss Loot"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 18264 },	-- Plans: Elemental Sharpening Stone
				{ 2, 18262 },	-- Elemental Sharpening Stone
				{ 4, 18292 },	-- Schematic: Core Marksman Rifle
				{ 5, 18282 },	-- Core Marksman Rifle
				{ 7, 18291 },	-- Schematic: Force Reactive Disk
				{ 8, 18168 },	-- Force Reactive Disk
				{ 10, 18290 },	-- Schematic: Biznicks 247x128 Accurascope
				{ 11, 18283 },	-- Biznicks 247x128 Accurascope
				{ 13, 18259 },	-- Formula: Enchant Weapon - Spell Power
				{ 16, 18252 },	-- Pattern: Core Armor Kit
				{ 17, 18251 },	-- Core Armor Kit
				{ 19, 18265 },	-- Pattern: Flarecore Wraps
				{ 20, 18263 },	-- Flarecore Wraps
				{ 22, 21371 },	-- Pattern: Core Felcloth Bag
				{ 23, 21342 },	-- Core Felcloth Bag
				{ 25, 18257 },	-- Recipe: Major Rejuvenation Potion
				{ 26, 18253 },	-- Major Rejuvenation Potion
				{ 28, 18260 },	-- Formula: Enchant Weapon - Healing Power
			},
		},
		{	--MCTrashMobs
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 16802 },	-- Arcanist Belt
				{ 2, 16817 },	-- Girdle of Prophecy
				{ 3, 16806 },	-- Felheart Belt
				{ 4, 16827 },	-- Nightslayer Belt
				{ 5, 16828 },	-- Cenarion Belt
				{ 6, 16851 },	-- Giantstalker's Belt
				{ 7, 16838 },	-- Earthfury Belt
				{ 8, 16864 },	-- Belt of Might
				{ 9, 16858 },	-- Lawbringer Belt
				{ 11, 17010 },	-- Fiery Core
				{ 12, 17011 },	-- Lava Core
				{ 13, 11382 },	-- Blood of the Mountain
				{ 14, 17012 },	-- Core Leather
				{ 16, 16799 },	-- Arcanist Bindings
				{ 17, 16819 },	-- Vambraces of Prophecy
				{ 18, 16804 },	-- Felheart Bracers
				{ 19, 16825 },	-- Nightslayer Bracelets
				{ 20, 16830 },	-- Cenarion Bracers
				{ 21, 16850 },	-- Giantstalker's Bracers
				{ 22, 16840 },	-- Earthfury Bracers
				{ 23, 16861 },	-- Bracers of Might
				{ 24, 16857 },	-- Lawbringer Bracers
			},
		},
		{	--Tier 1 Sets
			name = format(AL["Tier %d Sets"], 1),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:17",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["TheRuinsofAhnQiraj"] = {
	name = ALIL["Ruins of Ahn'Qiraj"],
	MapID = 717,
	ContentType = RAID_CONTENT,
	items = {
		{	--AQ20Kurinnaxx
			name = BB["Kurinnaxx"],
			[NORMAL_DIFF] = {
				{ 1, 21499 },	-- Vestments of the Shifting Sands
				{ 2, 21498 },	-- Qiraji Sacrificial Dagger
				{ 4, 21500 },	-- Belt of the Inquisition
				{ 5, 21501 },	-- Toughened Silithid Hide Gloves
				{ 6, 21502 },	-- Sand Reaver Wristguards
				{ 7, 21503 },	-- Belt of the Sand Reaver
				{ 16, 20889 },	-- Qiraji Regal Drape
				{ 17, 20885 },	-- Qiraji Martial Drape
				{ 18, 20884 },	-- Qiraji Magisterial Ring
				{ 19, 20888 },	-- Qiraji Ceremonial Ring
				{ 21, 22217 },	-- Kurinnaxx's Venom Sac
			},
		},
		{	--AQ20Rajaxx
			name = BB["General Rajaxx"],
			[NORMAL_DIFF] = {
				{ 1, 21493 },	-- Boots of the Vanguard
				{ 2, 21492 },	-- Manslayer of the Qiraji
				{ 4, 21496 },	-- Bracers of Qiraji Command
				{ 5, 21494 },	-- Southwind's Grasp
				{ 6, 21497 },	-- Boots of the Qiraji General
				{ 7, 21495 },	-- Legplates of the Qiraji Command
				{ 9, "INV_Box_01", nil, AL["Rajaxx's Captains"], nil },
				{ 10, 21810 },	-- Treads of the Wandering Nomad
				{ 11, 21809 },	-- Fury of the Forgotten Swarm
				{ 12, 21806 },	-- Gavel of Qiraji Authority
				{ 16, 20889 },	-- Qiraji Regal Drape
				{ 17, 20885 },	-- Qiraji Martial Drape
				{ 18, 20884 },	-- Qiraji Magisterial Ring
				{ 19, 20888 },	-- Qiraji Ceremonial Ring
				{ 21, "INV_Box_01", nil, BB["Lieutenant General Andorov"], nil },
				{ 22, 22221 },	-- Plans: Obsidian Mail Tunic
				{ 23, 22219 },	-- Plans: Jagged Obsidian Shield
			},
		},
		{	--AQ20Moam
			name = BB["Moam"],
			[NORMAL_DIFF] = {
				{ 1, 21472 },	-- Dustwind Turban
				{ 2, 21467 },	-- Thick Silithid Chestguard
				{ 3, 21479 },	-- Gauntlets of the Immovable
				{ 4, 21471 },	-- Talon of Furious Concentration
				{ 6, 21470 },	-- Cloak of the Savior
				{ 7, 21468 },	-- Mantle of Maz'Nadir
				{ 8, 21455 },	-- Southwind Helm
				{ 9, 21474 },	-- Chitinous Shoulderguards
				{ 10, 21469 },	-- Gauntlets of Southwind
				{ 11, 21476 },	-- Obsidian Scaled Leggings
				{ 12, 21475 },	-- Legplates of the Destroyer
				{ 13, 21477 },	-- Ring of Fury
				{ 14, 21473 },	-- Eye of Moam
				{ 16, 20886 },	-- Qiraji Spiked Hilt
				{ 17, 20890 },	-- Qiraji Ornate Hilt
				{ 18, 20884 },	-- Qiraji Magisterial Ring
				{ 19, 20888 },	-- Qiraji Ceremonial Ring
				{ 21, 22220 },	-- Plans: Black Grasp of the Destroyer
				{ 22, 22194 },	-- Black Grasp of the Destroyer
			},
		},
		{	--AQ20Buru
			name = BB["Buru the Gorger"],
			[NORMAL_DIFF] = {
				{ 1, 21487 },	-- Slimy Scaled Gauntlets
				{ 2, 21486 },	-- Gloves of the Swarm
				{ 3, 21485 },	-- Buru's Skull Fragment
				{ 5, 21489 },	-- Quicksand Waders
				{ 6, 21491 },	-- Scaled Bracers of the Gorger
				{ 7, 21490 },	-- Slime Kickers
				{ 8, 21488 },	-- Fetish of Chitinous Spikes
				{ 16, 20886 },	-- Qiraji Spiked Hilt
				{ 17, 20890 },	-- Qiraji Ornate Hilt
				{ 18, 20889 },	-- Qiraji Regal Drape
				{ 19, 20885 },	-- Qiraji Martial Drape
				{ 20, 20884 },	-- Qiraji Magisterial Ring
				{ 21, 20888 },	-- Qiraji Ceremonial Ring
			},
		},
		{	--AQ20Ayamiss
			name = BB["Ayamiss the Hunter"],
			[NORMAL_DIFF] = {
				{ 1, 21479 },	-- Gauntlets of the Immovable
				{ 2, 21466 },	-- Stinger of Ayamiss
				{ 3, 21478 },	-- Bow of Taut Sinew
				{ 5, 21484 },	-- Helm of Regrowth
				{ 6, 21480 },	-- Scaled Silithid Gauntlets
				{ 7, 21482 },	-- Boots of the Fiery Sands
				{ 8, 21481 },	-- Boots of the Desert Protector
				{ 9, 21483 },	-- Ring of the Desert Winds
				{ 16, 20886 },	-- Qiraji Spiked Hilt
				{ 17, 20890 },	-- Qiraji Ornate Hilt
				{ 18, 20889 },	-- Qiraji Regal Drape
				{ 19, 20885 },	-- Qiraji Martial Drape
				{ 20, 20884 },	-- Qiraji Magisterial Ring
				{ 21, 20888 },	-- Qiraji Ceremonial Ring
			},
		},
		{	--AQ20Ossirian
			name = BB["Ossirian the Unscarred"],
			[NORMAL_DIFF] = {
				{ 1, 21456 },	-- Sandstorm Cloak
				{ 2, 21464 },	-- Shackles of the Unscarred
				{ 3, 21462 },	-- Gloves of Dark Wisdom
				{ 4, 21461 },	-- Leggings of the Black Blizzard
				{ 5, 21458 },	-- Gauntlets of New Life
				{ 6, 21454 },	-- Runic Stone Shoulders
				{ 7, 21463 },	-- Ossirian's Binding
				{ 8, 21460 },	-- Helm of Domination
				{ 9, 21453 },	-- Mantle of the Horusath
				{ 10, 21457 },	-- Bracers of Brutality
				{ 11, 21715 },	-- Sand Polished Hammer
				{ 12, 21459 },	-- Crossbow of Imminent Doom
				{ 13, 21452 },	-- Staff of the Ruins
				{ 16, 21220 },	-- Head of Ossirian the Unscarred
				{ 17, 21504 },	-- Charm of the Shifting Sands
				{ 18, 21507 },	-- Amulet of the Shifting Sands
				{ 19, 21505 },	-- Choker of the Shifting Sands
				{ 20, 21506 },	-- Pendant of the Shifting Sands
				{ 22, 20886 },	-- Qiraji Spiked Hilt
				{ 23, 20890 },	-- Qiraji Ornate Hilt
				{ 24, 20884 },	-- Qiraji Magisterial Ring
				{ 25, 20888 },	-- Qiraji Ceremonial Ring
				{ 27, "ac689" },
			},
		},
		{	--AQ20Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1, 20873 },	-- Alabaster Idol
				{ 2, 20869 },	-- Amber Idol
				{ 3, 20866 },	-- Azure Idol
				{ 4, 20870 },	-- Jasper Idol
				{ 5, 20868 },	-- Lambent Idol
				{ 6, 20871 },	-- Obsidian Idol
				{ 7, 20867 },	-- Onyx Idol
				{ 8, 20872 },	-- Vermillion Idol
				{ 10, 22202 },	-- Small Obsidian Shard
				{ 11, 22203 },	-- Large Obsidian Shard
				{ 16, 20864 },	-- Bone Scarab
				{ 17, 20861 },	-- Bronze Scarab
				{ 18, 20863 },	-- Clay Scarab
				{ 19, 20862 },	-- Crystal Scarab
				{ 20, 20859 },	-- Gold Scarab
				{ 21, 20865 },	-- Ivory Scarab
				{ 22, 20860 },	-- Silver Scarab
				{ 23, 20858 },	-- Stone Scarab
			},
		},
		{	--AQ20Sets
			name = ALIL["Ruins of Ahn'Qiraj"].." "..AL["Sets"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:CLASSICSETS:2",
		},
		{	--AQEnchants
			name = AL["AQ Enchants"],
			ExtraList = true,
			[NORMAL_DIFF] = AQ_ENCHANTS,
		},
		{	--CenarionCircle
			FactionID = 609,
			ExtraList = true,
			CoinTexture = "Reputation",
			[NORMAL_DIFF] = "AtlasLoot_Factions:CLASSICFACTIONS:4",
		},
		CLASSIC_RAID_AC_TABLE,
	}
}

data["Naxxramas"] = {
	name = ALIL["Naxxramas"],
	MapID = 535,
	ContentType = REMOVED_CONTENT,
	LoadDifficulty = REMOVED_DIFF,
	TableType = REMOVED_ITTYPE,
	items = {
		{	--Naxx80AnubRekhan
			name = BB["Anub'Rekhan"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 27.61 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22369, 28.57 }, -- Desecrated Bindings
				{ 5, 22362, 31.3 }, -- Desecrated Wristguards
				{ 6, 22355, 29.53 }, -- Desecrated Bracers
				{ 8, 22938, 20.39 }, -- Cryptfiend Silk Cloak
				{ 9, 22936, 16.85 }, -- Wristguards of Vengeance
				{ 10, 22937, 15.09 }, -- Gem of Nerubis
				{ 11, 22939, 16.85 }, -- Band of Unanswered Prayers
				{ 12, 22935, 13.32 }, -- Touch of Frost
			},
		},
		{	--Naxx80Faerlina
			name = BB["Grand Widow Faerlina"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 19.01 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22369, 25.22 }, -- Desecrated Bindings
				{ 5, 22362, 24.59 }, -- Desecrated Wristguards
				{ 6, 22355, 35.74 }, -- Desecrated Bracers
				{ 8, 22941, 14.96 }, -- Polar Shoulder Pads
				{ 9, 22940, 21.55 }, -- Icebane Pauldrons
				{ 10, 22806, 14.45 }, -- Widow's Remorse
				{ 11, 22942, 21.67 }, -- The Widow's Embrace
				{ 12, 22943, 17.49 }, -- Malice Stone Pendant
			},
		},
		{	--Naxx80Maexxna
			name = BB["Maexxna"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 11.13 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22371, 44.26 }, -- Desecrated Gloves
				{ 5, 22364, 49.03 }, -- Desecrated Handguards
				{ 6, 22357, 90.8 }, -- Desecrated Gauntlets
				{ 8, 23220, 11.34 }, -- Crystal Webbed Robe
				{ 9, 22804, 18.05 }, -- Maexxna's Fang
				{ 10, 22807, 14.25 }, -- Wraith Blade
				{ 11, 22947, 31.88 }, -- Pendant of Forgotten Names
				{ 12, 22954, 11.62 }, -- Kiss of the Spider
			},
		},
		{	--Naxx80Noth
			name = BB["Noth the Plaguebringer"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 13.07 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22370, 26.23 }, -- Desecrated Belt
				{ 5, 22363, 32.67 }, -- Desecrated Girdle
				{ 6, 22356, 29.66 }, -- Desecrated Waistguard
				{ 8, 23030, 13.33 }, -- Cloak of the Scourge
				{ 9, 22816, 15.99 }, -- Hatchet of Sundered Bone
				{ 10, 23005, 3.01 }, -- Totem of Flowing Water
				{ 11, 23006, 14.36 }, -- Libram of Light
				{ 12, 23029, 11.09 }, -- Noth's Frigid Heart
				{ 13, 23031, 12.9 }, -- Band of the Inevitable
				{ 14, 23028, 13.59 }, -- Hailstone Band
			},
		},
		{	--Naxx80Heigan
			name = BB["Heigan the Unclean"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22370 }, -- Desecrated Belt
				{ 5, 22363 }, -- Desecrated Girdle
				{ 6, 22356 }, -- Desecrated Waistguard
				{ 8, 23035 }, -- Preceptor's Hat
				{ 9, 23033 }, -- Icy Scale Coif
				{ 10, 23019 }, -- Icebane Helmet
				{ 11, 23068 }, -- Legplates of Carnage
				{ 12, 23036 }, -- Necklace of Necropsy
			},
		},
		{	--Naxx80Loatheb
			name = BB["Loatheb"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22366 }, -- Desecrated Leggings
				{ 5, 22359 }, -- Desecrated Legguards
				{ 6, 22352 }, -- Desecrated Legplates
				{ 8, 23039 }, -- The Eye of Nerub
				{ 9, 22800 }, -- Brimstone Staff
				{ 10, 23037 }, -- Ring of Spiritual Fervor
				{ 11, 23038 }, -- Band of Unnatural Forces
				{ 12, 23042 }, -- Loatheb's Reflection
			},
		},
		{	--Naxx80Razuvious
			name = BB["Instructor Razuvious"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 24.39 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22372, 27.64 }, -- Desecrated Sandals
				{ 5, 22365, 31.1 }, -- Desecrated Boots
				{ 6, 22358, 26.02 }, -- Desecrated Sabatons
				{ 8, 23017, 19.31 }, -- Veil of Eclipse
				{ 9, 23219, 8.74 }, -- Girdle of the Mentor
				{ 10, 23014, 9.35 }, -- Iblis, Blade of the Fallen Seraph
				{ 11, 23009, 12.8 }, -- Wand of the Whispering Dead
				{ 12, 23004, 17.68 }, -- Idol of Longevity
				{ 13, 23018, 19.31 }, -- Signet of the Fallen Defender
			},
		},
		{	--Naxx80Gothik
			name = BB["Gothik the Harvester"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22372 }, -- Desecrated Sandals
				{ 5, 22365 }, -- Desecrated Boots
				{ 6, 22358 }, -- Desecrated Sabatons
				{ 8, 23032 }, -- Glacial Headdress
				{ 9, 23021 }, -- The Soul Harvester's Bindings
				{ 10, 23020 }, -- Polar Helmet
				{ 11, 23073 }, -- Boots of Displacement
				{ 12, 23023 }, -- Sadist's Collar
			},
		},
		{	--Naxx80FourHorsemen
			name = BB["The Four Horsemen"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22351 }, -- Desecrated Robe
				{ 5, 22350 }, -- Desecrated Tunic
				{ 6, 22349 }, -- Desecrated Breastplate
				{ 8, 23071 }, -- Leggings of Apocalypse
				{ 9, 22809 }, -- Maul of the Redeemed Crusader
				{ 10, 22691 }, -- Corrupted Ashbringer
				{ 11, 22811 }, -- Soulstring
				{ 12, 23025 }, -- Seal of the Damned
				{ 13, 23027 }, -- Warmth of Forgiveness
			},
		},
		{	--Naxx80Patchwerk
			name = BB["Patchwerk"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726, 11.39 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22368, 21.33 }, -- Desecrated Shoulderpads
				{ 5, 22361, 36.65 }, -- Desecrated Spaulders
				{ 6, 22354, 28.78 }, -- Desecrated Pauldrons
				{ 8, 22960, 12.84 }, -- Cloak of Suturing
				{ 9, 22815, 16.15 }, -- Severance
				{ 10, 22820, 23.19 }, -- Wand of Fates
				{ 11, 22818, 15.53 }, -- The Plague Bearer
				{ 12, 22961, 22.15 }, -- Band of Reanimation
			},
		},
		{	--Naxx80Grobbulus
			name = BB["Grobbulus"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22368 }, -- Desecrated Shoulderpads
				{ 5, 22361 }, -- Desecrated Spaulders
				{ 6, 22354 }, -- Desecrated Pauldrons
				{ 8, 22968 }, -- Glacial Mantle
				{ 9, 22967 }, -- Icy Scale Spaulders
				{ 10, 22803 }, -- Midnight Haze
				{ 11, 22988 }, -- The End of Dreams
				{ 12, 22810 }, -- Toxin Injector
			},
		},
		{	--Naxx80Gluth
			name = BB["Gluth"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22983 }, -- Rime Covered Mantle
				{ 5, 22813 }, -- Claymore of Unholy Might
				{ 6, 23075 }, -- Death's Bargain
				{ 7, 22994 }, -- Digested Hand of Power
				{ 8, 22981 }, -- Gluth's Missing Collar
				{ 16, 22368 }, -- Desecrated Shoulderpads
				{ 17, 22361 }, -- Desecrated Spaulders
				{ 18, 22354 }, -- Desecrated Pauldrons
				{ 19, 22369 }, -- Desecrated Bindings
				{ 20, 22362 }, -- Desecrated Wristguards
				{ 21, 22355 }, -- Desecrated Bracers
				{ 22, 22370 }, -- Desecrated Belt
				{ 23, 22363 }, -- Desecrated Girdle
				{ 24, 22356 }, -- Desecrated Waistguard
				{ 25, 22372 }, -- Desecrated Sandals
				{ 26, 22365 }, -- Desecrated Boots
				{ 27, 22358 }, -- Desecrated Sabatons
			},
		},
		{	--Naxx80Thaddius
			name = BB["Thaddius"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22726 }, -- Splinter of Atiesh
				{ 2, 22727 }, -- Frame of Atiesh
				{ 4, 22367 }, -- Desecrated Circlet
				{ 5, 22360 }, -- Desecrated Headpiece
				{ 6, 22353 }, -- Desecrated Helmet
				{ 8, 23070 }, -- Leggings of Polarity
				{ 9, 23000 }, -- Plated Abomination Ribcage
				{ 10, 22808 }, -- The Castigator
				{ 11, 22801 }, -- Spire of Twilight
				{ 12, 23001 }, -- Eye of Diminution
			},
		},
		{	--Naxx80Sapphiron
			name = BB["Sapphiron"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 23050 }, -- Cloak of the Necropolis
				{ 2, 23045 }, -- Shroud of Dominion
				{ 3, 23072 }, -- Fists of the Unrelenting
				{ 4, 23043 }, -- The Face of Death
				{ 5, 23242 }, -- Claw of the Frost Wyrm
				{ 6, 23049 }, -- Sapphiron's Left Eye
				{ 7, 23048 }, -- Sapphiron's Right Eye
				{ 8, 23040 }, -- Glyph of Deflection
				{ 9, 23047 }, -- Eye of the Dead
				{ 10, 23046 }, -- The Restrained Essence of Sapphiron
				{ 11, 23041 }, -- Slayer's Crest
				{ 16, 23545 }, -- Power of the Scourge
				{ 17, 23547 }, -- Resilience of the Scourge
				{ 18, 23549 }, -- Fortitude of the Scourge
				{ 19, 23548 }, -- Might of the Scourge
			},
		},
		{	--Naxx80KelThuzad
			name = BB["Kel'Thuzad"],
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 22802 }, -- Kingsfall
				{ 2, 23054 }, -- Gressil, Dawn of Ruin
				{ 3, 23577 }, -- The Hungering Cold
				{ 4, 23056 }, -- Hammer of the Twisting Nether
				{ 5, 22798 }, -- Might of Menethil
				{ 6, 22799 }, -- Soulseeker
				{ 7, 22821 }, -- Doomfinger
				{ 8, 22812 }, -- Nerubian Slavemaker
				{ 9, 22819 }, -- Shield of Condemnation
				{ 10, 23057 }, -- Gem of Trapped Innocents
				{ 11, 23053 }, -- Stormrage's Talisman of Seething
				{ 13, 22520, 100 }, -- The Phylactery of Kel'Thuzad
				{ 14, 23207 }, -- Mark of the Champion
				{ 15, 23206 }, -- Mark of the Champion
				{ 16, 23064 }, -- Ring of the Dreamwalker
				{ 17, 23067 }, -- Ring of the Cryptstalker
				{ 18, 23062 }, -- Frostfire Ring
				{ 19, 23066 }, -- Ring of Redemption
				{ 20, 23061 }, -- Ring of Faith
				{ 21, 23060 }, -- Bonescythe Ring
				{ 22, 23065 }, -- Ring of the Earthshatterer
				{ 23, 23063 }, -- Plagueheart Ring
				{ 24, 23059 }, -- Ring of the Dreadnaught
				{ 26, 22733 }, -- Staff Head of Atiesh
				{ 27, 22632 }, -- Atiesh, Greatstaff of the Guardian
				{ 28, 22589 }, -- Atiesh, Greatstaff of the Guardian
				{ 29, 22631 }, -- Atiesh, Greatstaff of the Guardian
				{ 30, 22630 }, -- Atiesh, Greatstaff of the Guardian
			},
		},
		{	--Naxx80Trash
			name = AL["Trash Mobs"],
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
			[REMOVED_DIFF] = {
				{ 1, 23069 }, -- Necro-Knight's Garb
				{ 2, 23226 }, -- Ghoul Skin Tunic
				{ 3, 23663 }, -- Girdle of Elemental Fury
				{ 4, 23664 }, -- Pauldrons of Elemental Fury
				{ 5, 23665 }, -- Leggings of Elemental Fury
				{ 6, 23666 }, -- Belt of the Grand Crusader
				{ 7, 23667 }, -- Spaulders of the Grand Crusader
				{ 8, 23668 }, -- Leggings of the Grand Crusader
				{ 9, 23044 }, -- Harbinger of Doom
				{ 10, 23221 }, -- Misplaced Servo Arm
				{ 11, 23238 }, -- Stygian Buckler
				{ 12, 23237 }, -- Ring of the Eternal Flame
				{ 16, 22376 }, -- Wartorn Cloth Scrap
				{ 17, 22373 }, -- Wartorn Leather Scrap
				{ 18, 22374 }, -- Wartorn Chain Scrap
				{ 19, 22375 }, -- Wartorn Plate Scrap
				{ 21, 22708 }, -- Fate of Ramaladni
				{ 22, 23055 }, -- Word of Thawing
			},
		},
		{	--Tier 3 Sets
			name = format(AL["Tier %d Sets"], 3),
			ExtraList = true,
			[NORMAL_DIFF] = "AtlasLoot_Collections:TIERSETS:11",
			[P25_DIFF] = "AtlasLoot_Collections:TIERSETS:11",
			[REMOVED_DIFF] = "AtlasLoot_Collections:TIERSETS:15:n",
		},
		{	-- WOTLK_RAID1_10_AC_TABLE
			name = select(2, GetAchievementInfo(2137)),
			ExtraList = true,
			TableType = AC_ITTYPE,
			CoinTexture = "Achievement",
			[NORMAL_DIFF] = "AtlasLoot_WrathoftheLichKing",
		},
		{	-- WOTLK_RAID1_25_AC_TABLE
			name = select(2, GetAchievementInfo(2138)),
			ExtraList = true,
			TableType = AC_ITTYPE,
			CoinTexture = "Achievement",
			[P25_DIFF] = "AtlasLoot_WrathoftheLichKing",
		},
	}
}
