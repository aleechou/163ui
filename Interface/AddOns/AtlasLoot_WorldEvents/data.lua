local addonname = ...
local AtlasLoot = _G.AtlasLoot
local data = AtlasLoot.ItemDB:Add(addonname)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local BB = AtlasLoot.LibBabble:Get("LibBabble-Boss-3.0")

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"])
local ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE)
local HORDE_DIFF = data:AddDifficulty(FACTION_HORDE)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")

local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")

local WORLDEVENTS_CONTENT = data:AddContentType(AL["World Events"], ATLASLOOT_WORLDEVENTS_COLOR)

data["HarvestFestival"] = {
	name = AL["Harvest Festival"].." ("..ALIL["September"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--HarvestFestival
			name = AL["Harvest Festival"],
			[NORMAL_DIFF] = {
				{ 1, 19995 },	-- Harvest Boar
				{ 2, 19996 },	-- Harvest Fish
				{ 3, 19994 },	-- Harvest Fruit
				{ 4, 19997 },	-- Harvest Nectar
				{ 16, 19697 },	-- Bounty of the Harvest
				{ 17, [ATLASLOOT_IT_ALLIANCE] = 20009, [ATLASLOOT_IT_HORDE] = 20010, [QUEST_EXTRA_ITTYPE] = 8149 },	-- For the Light! / The Horde's Hellscream
			},
		},
	}
}

data["Brewfest"] = {
	name = AL["Brewfest"].." ("..ALIL["September"].." - "..ALIL["October"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--BrewfestCorenDirebrew
			name = BB["Coren Direbrew"].." ("..ALIL["Blackrock Depths"]..")",
			[NORMAL_DIFF] = {
				{ 1, 117361 },	-- Bitterest Balebrew Charm
				{ 2, 117357 },	-- Brawler's Statue
				{ 3, 117391 },	-- Bubbliest Brightbrew Charm
				{ 4, 117360 },	-- Coren's Cold Chromium Coaster
				{ 5, 117358 },	-- Mithril Wristwatch
				{ 6, 117359 },	-- Thousand-Year Pickled Egg
				{ 8, [ATLASLOOT_IT_ALLIANCE] = 38281, [ATLASLOOT_IT_HORDE] = 38280 },	-- Direbrew's Dire Brew
				{ 16, 54535 },	-- Keg-Shaped Treasure Chest (Daily reward)
				{ 17, 117378 },	-- Direbrew's Bloodied Shanker
				{ 18, 117379 },	-- Tremendous Tankard O' Terror
				{ 19, 37828, "mount" },	-- Great Brewfest Kodo
				{ 20, 33977, "mount" },	-- Swift Brewfest Ram
				{ 21, 37863 },	-- Direbrew's Remote
				{ 22, 37829 },	-- Brewfest Prize Token
			},
		},
		{	--BrewfestVendor
			name = AL["Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 46707, "pet166", [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Pint-Sized Pink Pachyderm
				{ 2, 32233, "pet153", [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- Wolpertinger's Tankard
				{ 4, 116758, [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Brewfest Banner
				{ 5, 33927, [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Brewfest Pony Keg
				{ 6, 71137, [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- Brewfest Keg Pony
				{ 7, 90427, [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Pandaren Brewpack
				{ 8, 116757, [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- Steamworks Sausage Grill
				{ 10, 37816, [PRICE_EXTRA_ITTYPE] = "brewfest:20" },	-- Preserved Brewfest Hops
				{ 11, 90426, [PRICE_EXTRA_ITTYPE] = "brewfest:2" },	-- Brewhelm
				{ 12, 37750, [PRICE_EXTRA_ITTYPE] = "brewfest:2" },	-- Fresh Brewfest Hops
				{ 13, [ATLASLOOT_IT_ALLIANCE] = 39477, [ATLASLOOT_IT_HORDE] = 39476, [PRICE_EXTRA_ITTYPE] = "brewfest:5" },	-- Fresh Dwarven Brewfest Hops / Fresh Goblin Brewfest Hops
				{ 16, [ATLASLOOT_IT_ALLIANCE] = 33047, [ATLASLOOT_IT_HORDE] = 34008, [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Belbi's Eyesight Enhancing Romance Goggles / Blix's Eyesight Enhancing Romance Goggles
				{ 17, 33968, [PRICE_EXTRA_ITTYPE] = "brewfest:50" },	-- Blue Brewfest Hat
				{ 18, 33864, [PRICE_EXTRA_ITTYPE] = "brewfest:50" },	-- Brown Brewfest Hat
				{ 19, 33967, [PRICE_EXTRA_ITTYPE] = "brewfest:50" },	-- Green Brewfest Hat
				{ 20, 33969, [PRICE_EXTRA_ITTYPE] = "brewfest:50" },	-- Purple Brewfest Hat
				{ 21, 33863, [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- Brewfest Dress
				{ 22, 33862, [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- Brewfest Regalia
				{ 23, 33868, [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Brewfest Boots
				{ 24, 33966, [PRICE_EXTRA_ITTYPE] = "brewfest:100" },	-- Brewfest Slippers
				{ 26, 37599, [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- "Brew of the Month" Club Membership Form
			},
		},
		{	--BrewfestFoodDrinks
			name = AL["Food"].." & "..AL["Drinks"],
			[NORMAL_DIFF] = {
				{ 1, 33030 },	-- Barleybrew Clear
				{ 2, 33028 },	-- Barleybrew Light
				{ 3, 33029 },	-- Barleybrew Dark
				{ 5, 33031 },	-- Thunder 45
				{ 6, 33032 },	-- Thunderbrew Ale
				{ 7, 33033 },	-- Thunderbrew Stout
				{ 9, 33034 },	-- Gordok Grog
				{ 10, 33036 },	-- Mudder's Milk
				{ 11, 33035 },	-- Ogre Mead
				{ 13, 34017 },	-- Small Step Brew
				{ 14, 34018 },	-- Long Stride Brew
				{ 15, 34019 },	-- Path of Brew
				{ 16, 34020 },	-- Jungle River Water
				{ 17, 34021 },	-- Brewdoo Magic
				{ 18, 34022 },	-- Stout Shrunken Head
				{ 20, 33929 },	-- Brewfest Brew
				{ 22, 34063 },	-- Dried Sausage
				{ 23, 33024 },	-- Pickled Sausage
				{ 24, 38428 },	-- Rock-Salted Pretzel
				{ 25, 33023 },	-- Savory Sausage
				{ 26, 34065 },	-- Spiced Onion Cheese
				{ 27, 33025 },	-- Spicy Smoked Sausage
				{ 28, 34064 },	-- Succulent Sausage
				{ 29, 33043 },	-- The Essential Brewfest Pretzel
				{ 30, 33026 },	-- The Golden Link
			},
		},
		{	--BrewfestMonthClub
			name = AL["Brew of the Month Club"],
			[NORMAL_DIFF] = {
				{ 1, 37599, [PRICE_EXTRA_ITTYPE] = "brewfest:200" },	-- "Brew of the Month" Club Membership Form
				{ 3, 37488 },	-- Wild Winter Pilsner (January)
				{ 4, 37489 },	-- Izzard's Ever Flavor (February)
				{ 5, 37490 },	-- Aromatic Honey Brew (March)
				{ 6, 37491 },	-- Metok's Bubble Bock (April)
				{ 7, 37492 },	-- Springtime Stout (May)
				{ 8, 37493 },	-- Blackrock Lager (June)
				{ 18, 37494 },	-- Stranglethorn Brew (July)
				{ 19, 37495 },	-- Draenic Pale Ale (August)
				{ 20, 37496 },	-- Binary Brew (September)
				{ 21, 37497 },	-- Autumnal Acorn Ale (October)
				{ 22, 37498 },	-- Bartlett's Bitter Brew (November)
				{ 23, 37499 },	-- Lord of Frost's Private Label (December)
			},
		},
	}
}

data["HallowsEnd"] = {
	name = AL["Hallow's End"].." ("..ALIL["October"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--HallowsEndHeadlessHorseman
			name = BB["Headless Horseman"].." ("..ALIL["Scarlet Monastery"]..")",
			[NORMAL_DIFF] = {
				{ 1, "117363:573" },	-- Band of the Petrified Pumpkin
				{ 2, "117364:573" },	-- Seal of Ghoulish Glee
				{ 3, "117365:573" },	-- The Horseman's Ring
				{ 4, "117362:573" },	-- Wicked Witch's Signet
				{ 6, 34068 },	-- Weighted Jack-o'-Lantern
				{ 16, 54516 },	-- Loot-Filled Pumpkin
				{ 17, "117355:573" },	-- The Horseman's Horrific Hood
				{ 18, "117356:573" },	-- The Horseman's Sinister Slicer
				{ 19, 37012, "mount" },	-- The Horseman's Reins
				{ 20, 33292 },	-- Hallowed Helm
				{ 21, 37011 },	-- Magic Broom
				{ 22, 33154, "pet162" },	-- Sinister Squashling
				{ 23, 33226 },	-- Tricky Treat
			},
		},
		{	--HallowsEndCandyToys
			name = AL["Candy"].." & "..AL["Toys"],
			[NORMAL_DIFF] = {
				{ 1, 116801, "pet1521", [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Cursed Birman
				{ 2, 33154, "pet162", [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Sinister Squashling
				{ 3, 116804, "pet1523", [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Widget the Departed
				{ 4, 70908, "pet319", [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Feline Familiar
				{ 6, 70722, [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Little Wickerman
				{ 8, 116828, [PRICE_EXTRA_ITTYPE] = "trickytreat:500" },	-- Exquisite Costume Set: "The Lich King"
				{ 9, 116811, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- "Lil' Starlet" Costume
				{ 10, 116810, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- "Mad Alchemist" Costume
				{ 11, 116812, [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- "Yipp-Saron" Costume
				{ 16, 33292, [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Hallowed Helm
				{ 18, 37011, [PRICE_EXTRA_ITTYPE] = "trickytreat:150" },	-- Magic Broom
				{ 20, 37585, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Chewy Fel Taffy
				{ 21, 37583, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- G.N.E.R.D.S.
				{ 22, 37582, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Pyroblast Cinnamon Ball
				{ 23, 37584, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Soothing Spearmint Candy
				{ 24, 37604, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Tooth Pick
			},
		},
		{	--HallowsEndNonPlayableRaceMasks
			name = AL["Non-Playable Race Masks"],
			[NORMAL_DIFF] = {
				{ 1, 69187, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Murloc Female Mask
				{ 2, 69188, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Murloc Male Mask
				{ 3, 69189, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Naga Female Mask
				{ 4, 69190, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Naga Male Mask
				{ 5, 69192, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Ogre Female Mask
				{ 6, 69193, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Ogre Male Mask
				{ 7, 69194, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Vrykul Female Mask
				{ 8, 69195, [PRICE_EXTRA_ITTYPE] = "trickytreat:5" },	-- Vrykul Male Mask
			},
		},
		{	--HallowsEndPlayableRaceMasks
			name = AL["Playable Race Masks"],
			[NORMAL_DIFF] = {
				{ 1, 34000, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Blood Elf Female Mask
				{ 2, 34002, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Blood Elf Male Mask
				{ 3, 34001, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Draenei Female Mask
				{ 4, 34003, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Draenei Male Mask
				{ 5, 20562, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Dwarf Female Mask
				{ 6, 20561, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Dwarf Male Mask
				{ 7, 20392, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Gnome Female Mask
				{ 8, 20391, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Gnome Male Mask
				{ 9, 49212, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Goblin Female Mask
				{ 10, 49210, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Goblin Male Mask
				{ 11, 20565, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Human Female Mask
				{ 12, 20566, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Human Male Mask
				{ 16, 20563, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Night Elf Female Mask
				{ 17, 20564, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Night Elf Male Mask
				{ 18, 20569, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Orc Female Mask
				{ 19, 20570, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Orc Male Mask
				{ 20, 20571, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Tauren Female Mask
				{ 21, 20572, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Tauren Male Mask
				{ 22, 20567, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Troll Female Mask
				{ 23, 20568, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Troll Male Mask
				{ 24, 20574, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Undead Female Mask
				{ 25, 20573, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Undead Male Mask
				{ 26, 49215, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Worgen Female Mask
				{ 27, 49216, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Worgen Male Mask
			},
		},
		{	--HallowsEndWands
			name = AL["Wands"],
			[NORMAL_DIFF] = {
				{ 1, 116851, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Abomination
				{ 2, 20410, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Bat
				{ 3, 116853, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Geist
				{ 4, 20409, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Ghost
				{ 5, 116850, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Ghoul
				{ 6, 20399, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Leper Gnome
				{ 7, 20398, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Ninja
				{ 16, 20397, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Pirate
				{ 17, 20413, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Random
				{ 18, 20411, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Skeleton
				{ 19, 116848, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Slime
				{ 20, 116854, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Spider
				{ 21, 20414, [PRICE_EXTRA_ITTYPE] = "trickytreat:2" },	-- Hallowed Wand - Wisp
			},
		},
	}
}

data["DayoftheDead"] = {
	name = AL["Day of the Dead"].." ("..ALIL["November"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--DayoftheDead
			name = AL["Day of the Dead"],
			[NORMAL_DIFF] = {
				{ 1, 46831, "pet1351" },	-- Macabre Marionette
				{ 3, 46860 },	-- Whimsical Skull Mask
				{ 4, 46861 },	-- Bouquet of Orange Marigolds
				{ 5, 46690 },	-- Candy Skull
				{ 6, 46711 },	-- Spirit Candle
				{ 7, 46718 },	-- Orange Marigold
				{ 16, 46710 },	-- Recipe: Bread of the Dead
				{ 17, 46691 },	-- Bread of the Dead
			},
		},
	}
}

data["PilgrimsBounty"] = {
	name = AL["Pilgrim's Bounty"].." ("..ALIL["November"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--PilgrimsBounty
			name = AL["Pilgrim's Bounty"],
			[ALLIANCE_DIFF] = {
				{ 1, 44810, "pet201" },	-- Turkey Cage (ACM 1694)
				{ 3, 46809 },	-- Bountiful Cookbook
				{ 4, 44860 },	-- Recipe: Spice Bread Stuffing (p3 1)
				{ 5, 44862 },	-- Recipe: Pumpkin Pie (p3 100)
				{ 6, 44858 },	-- Recipe: Cranberry Chutney (p3 160)
				{ 7, 44859 },	-- Recipe: Candied Sweet Potato (p3 220)
				{ 8, 44861 },	-- Recipe: Slow-Roasted Turkey (p3 280)
				{ 10, 46888 },	-- Bountiful Basket (p3 350)
				{ 11, 44855 },	-- Teldrassil Sweet Potato
				{ 12, 44854 },	-- Tangy Wetland Cranberries
				{ 13, 46784 },	-- Ripe Elwynn Pumpkin
				{ 14, 44835 },	-- Autumnal Herbs
				{ 15, 44853 },	-- Honey
				{ 16, 44844, [QUEST_EXTRA_ITTYPE] = 14035 },	-- Turkey Caller
				{ 18, 46723 },	-- Pilgrim's Hat (Daily reward)
				{ 19, 46800 },	-- Pilgrim's Attire (Daily reward)
				{ 20, 44785 },	-- Pilgrim's Dress (Daily reward)
				{ 21, 46824 },	-- Pilgrim's Robe (Daily reward)
				{ 22, 44788 },	-- Pilgrim's Boots (Daily reward)
				{ 23, 44812 },	-- Turkey Shooter (Daily reward)
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 3, 46810 },	-- Bountiful Cookbook
				{ 4, 46803 },	-- Recipe: Spice Bread Stuffing (p3 1)
				{ 5, 46804 },	-- Recipe: Pumpkin Pie (p3 100)
				{ 6, 46805 },	-- Cranberry Chutney (p3 160)
				{ 7, 46806 },	-- Recipe: Candied Sweet Potato (p3 220)
				{ 8, 46807 },	-- Recipe: Slow-Roasted Turkey (p3 280)
				{ 11, 46797 },	-- Mulgore Sweet Potato
				{ 12, 46793 },	-- Tangy Southfury Cranberries
				{ 13, 46796 },	-- Ripe Tirisfal Pumpkin
				{ 16, 44844, [QUEST_EXTRA_ITTYPE] = 14047 },	-- Turkey Caller
			},
		},
	}
}

data["Winterveil"] = {
	name = AL["Feast of Winter Veil"].." ("..ALIL["December"].." - "..ALIL["January"]..")",
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--WinterveilStolenPresent
			name = ALIL["Stolen Present"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Holiday_Christmas_Present_01", nil, ALIL["Stolen Present"], nil, [QUEST_EXTRA_ITTYPE] = "1:7043" },
				{ 2, 117371 },	-- Miniature Winter Veil Tree
				{ 3, 70923 },	-- Gaudy Winter Veil Sweater
				{ 5, 54436, "pet254" },	-- Blue Clockwork Rocket Bot
				{ 6, 34425, "pet191" },	-- Clockwork Rocket Bot
				{ 7, 73797, "pet337" },	-- Lump of Coal
				{ 8, 104317, "pet1349" },	-- Rotten Little Helper
				{ 10, 21215 },	-- Graccu's Mince Meat Fruitcake
				{ 11, 44481 },	-- Grindgear Toy Gorilla
				{ 12, 44601 },	-- Heavy Copper Racer
				{ 13, 34498 },	-- Paper Zeppelin Kit
				{ 14, 44482 },	-- Trusty Copper Racer
				{ 15, 44599 },	-- Zippy Copper Racer
				{ 17, 104318 },	-- Crashin' Thrashin' Flyer Controller
				{ 18, 46709 },	-- MiniZep Controller
				{ 19, 44606 },	-- Toy Train Set
				{ 20, 45057 },	-- Wind-Up Train Wrecker
				{ 21, 17712 },	-- Winter Veil Disguise Kit (mailed 24h after quest)
				{ 22, 54343 },	-- Blue Crashin' Thrashin' Racer Controller
				{ 23, 37710 },	-- Crashin' Thrashin' Racer Controller
				{ 24, 90888 },	-- Foot Ball
				{ 25, 90883 },	-- The Pigskin
				{ 26, 54438 },	-- Tiny Blue Ragdoll
				{ 27, 54437 },	-- Tiny Green Ragdoll
				{ 28, 46725 },	-- Red Rider Air Rifle
			},
		},
		{	--WinterveilGiftsPresents
			name = AL["Gifts & Presents"],
			[NORMAL_DIFF] = {
				{ 1, "INV_Holiday_Christmas_Present_01", nil, ALIL["Gaily Wrapped Present"], nil },
				{ 2, 21301, "pet119" },	-- Green Helper Box
				{ 3, 21308, "pet118" },	-- Jingling Bell
				{ 4, 21305, "pet120" },	-- Red Helper Box
				{ 5, 21309, "pet117" },	-- Snowman Kit
				{ 7, "INV_Holiday_Christmas_Present_01", nil, ALIL["Gently Shaken Gift"], nil },
				{ 8, 116692 },	-- Fuzzy Green Lounge Cushion
				{ 9, 116689 },	-- Pineapple Lounge Cushion
				{ 10, 116690 },	-- Safari Lounge Cushion
				{ 11, 116691 },	-- Zhevra Lounge Cushion
				{ 12, 21235 },	-- Winter Veil Roast
				{ 13, 21241 },	-- Winter Veil Eggnog
				{ 16, "INV_Holiday_Christmas_Present_01", nil, ALIL["Ticking Present"], nil },
				{ 17, 17720 },	-- Schematic: Snowmaster 9000 (p5 190)
				{ 18, 17706 },	-- Plans: Edge of Winter (p2 190)
				{ 19, 17725 },	-- Formula: Enchant Weapon - Winter's Might (p4 190)
				{ 20, 17722 },	-- Pattern: Gloves of the Greatfather (p7 190)
				{ 21, 17709 },	-- Recipe: Elixir of Frost Power (p1 190)
				{ 22, 17724 },	-- Pattern: Green Holiday Shirt (p8 190)
				{ 23, 21325 },	-- Mechanical Greench
				{ 24, 21213 },	-- Preserved Holly
				{ 26, "INV_Holiday_Christmas_Present_01", nil, ALIL["Winter Veil Gift"], nil, [QUEST_EXTRA_ITTYPE] = 36617 },
				{ 27, 116763 },	-- Crashin' Thrashin' Shredder Controller (2014)
				{ 101, "INV_Holiday_Christmas_Present_01", nil, ALIL["Carefully Wrapped Present"], nil },
				{ 102, 21254 },	-- Winter Veil Cookie
				{ 104, "INV_Holiday_Christmas_Present_01", nil, ALIL["Festive Gift"], nil },
				{ 105, 21328 },	-- Wand of Holiday Cheer
				{ 116, "INV_Holiday_Christmas_Present_01", nil, ALIL["Smokywood Pastures Extra-Special Gift"], nil },
				{ 117, 21215 },	-- Graccu's Mince Meat Fruitcake
			},
		},
		{	--WinterveilVendor
			name = AL["Smokywood Pastures Vendor"],
			[NORMAL_DIFF] = {
				{ 1, 70923 },	-- Gaudy Winter Veil Sweater
				{ 3, 34262 },	-- Pattern: Winter Boots (p7 (85)
				{ 4, 34319 },	-- Pattern: Red Winter Clothes (p8 250)
				{ 5, 34261 },	-- Pattern: Green Winter Clothes (p8 250)
				{ 6, 34413 },	-- Recipe: Hot Apple Cider (p3 325)
				{ 7, 17201 },	-- Recipe: Egg Nog (p3 35)
				{ 8, 17200 },	-- Recipe: Gingerbread Cookie (p3 1)
				{ 9, 17194 },	-- Holiday Spices
				{ 11, 17303 },	-- Blue Ribboned Wrapping Paper
				{ 12, 17304 },	-- Green Ribboned Wrapping Paper
				{ 13, 17307 },	-- Purple Ribboned Wrapping Paper
				{ 15, 17202 },	-- Snowball
				{ 16, 17344 },	-- Candy Cane
				{ 17, 17406 },	-- Holiday Cheesewheel
				{ 18, 17407 },	-- Graccu's Homemade Meat Pie
				{ 19, 21215 },	-- Graccu's Mince Meat Fruitcake
				{ 20, 17408 },	-- Spicy Beefstick
				{ 21, 34410 },	-- Honeyed Holiday Ham
				{ 22, 17404 },	-- Blended Bean Brew
				{ 23, 17405 },	-- Green Garden Tea
				{ 24, 34412 },	-- Sparkling Apple Cider
				{ 25, 17196 },	-- Holiday Spirits
				{ 26, 17403 },	-- Steamwheedle Fizzy Spirits
				{ 27, 17402 },	-- Greatfather's Winter Ale
			},
		},
	}
}