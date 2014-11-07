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

data["BrawlersGuild"] = {
	name = ALIL["Bizmo's Brawlpub"].." / "..ALIL["Brawl'gar Arena"],
	ContentType = WORLDEVENTS_CONTENT,
	items = {
		{	--Rank1-4
			name = string.format(AL["Rank %d"], 1).." - "..string.format(AL["Rank %d"], 4),
			[ALLIANCE_DIFF] = {
				{ 1, 118916, [PRICE_EXTRA_ITTYPE] = "money:15000" },	-- Brawler's Healing Tonic
				{ 2, 118910, [PRICE_EXTRA_ITTYPE] = "money:15000" },	-- Brawler's Draenic Agility Potion
				{ 3, 118911, [PRICE_EXTRA_ITTYPE] = "money:15000" },	-- Brawler's Draenic Intellect Potion
				{ 4, 118912, [PRICE_EXTRA_ITTYPE] = "money:15000" },	-- Brawler's Draenic Strength Potion
				{ 5, 93043, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Rotten Apple
				{ 6, 93044, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Rotten Banana
				{ 7, 93045, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Rotten Watermelon
				{ 8, 93158, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Expired Blackout Brew
				{ 16, "INV_Box_01", nil, string.format(AL["Rank %d"], 4), nil },
				{ 17, 118907, [PRICE_EXTRA_ITTYPE] = "money:200000000" },	-- Pit Fighter's Punching Ring
				{ 18, 98079, [QUEST_EXTRA_ITTYPE] = 32837 },	-- Floot-Tooter's Tunic
				{ 19, 98081, [QUEST_EXTRA_ITTYPE] = 32841 },	-- The Boomshirt
				{ 20, 98082, [QUEST_EXTRA_ITTYPE] = 32859 },	-- Undisputed Champion's Shirt
				{ 21, 118913, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Brawler's Bottomless Draenic Agility Potion
				{ 22, 118914, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Brawler's Bottomless Draenic Intellect Potion
				{ 23, 118915, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- Brawler's Bottomless Draenic Strength Potion
				{ 24, 93195, "ac9169" },	-- Brawler's Pass
				{ 25, 93025, "pet1142", [PRICE_EXTRA_ITTYPE] = "money:3000" },	-- Clock'em
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 17, 118908, [PRICE_EXTRA_ITTYPE] = "money:200000000" },	-- Pit Fighter's Punching Ring
				{ 24, 93228, "ac9173" },	-- Brawler's Pass
			},
		},
		{	--Rank5-8
			name = string.format(AL["Rank %d"], 5).." - "..string.format(AL["Rank %d"], 8),
			[ALLIANCE_DIFF] = {
				{ 1, "INV_Box_01", nil, string.format(AL["Rank %d"], 5), nil },
				{ 2, 98084, [QUEST_EXTRA_ITTYPE] = 32845 },	-- Ooze-Soaked Shirt
				{ 3, 98083, [QUEST_EXTRA_ITTYPE] = 32843 },	-- Sharkskin Tunic
				{ 4, 98086, [QUEST_EXTRA_ITTYPE] = 32849 },	-- Tuxedo-Like Shirt
				{ 6, "INV_Box_01", nil, string.format(AL["Rank %d"], 6), nil },
				{ 7, 98080, [QUEST_EXTRA_ITTYPE] = 32839 },	-- Gorgeous Blouse
				{ 8, 98091, [QUEST_EXTRA_ITTYPE] = 32851 },	-- Last Season's Shirt
				{ 16, "INV_Box_01", nil, string.format(AL["Rank %d"], 7), nil },
				{ 17, 98543, "ac9176" },	-- Wraps of the Blood-Soaked Brawler
				{ 18, 98085, [QUEST_EXTRA_ITTYPE] = 32847 },	-- Brucehide Jersey
				{ 19, 98092, [QUEST_EXTRA_ITTYPE] = 32853 },	-- Digmaster's Bodysleeve
				{ 20, 98087, [QUEST_EXTRA_ITTYPE] = 32857 },	-- Paper Shirt
				{ 21, 98093, [QUEST_EXTRA_ITTYPE] = 32855 },	-- Sightless Mantle
				{ 23, "INV_Box_01", nil, string.format(AL["Rank %d"], 8), nil },
				{ 24, 98405, "mount", [PRICE_EXTRA_ITTYPE] = "money:15000000" },	-- Brawler's Burly Mushan Beast
			},
			[HORDE_DIFF] = {
				GetItemsFromDiff = ALLIANCE_DIFF,
				{ 17, 98543, "ac9177" },	-- Wraps of the Blood-Soaked Brawler
			},
		},
	}
}

data["DarkmoonFaire"] = {
	name = AL["Darkmoon Faire"],
	ContentType = NORMAL_ITTYPE,
	items = {
		{	--DarkmoonMountsPets
			name = AL["Mounts"].." & "..AL["Pets"],
			[NORMAL_DIFF] = {
				{ 1, 73766, "mount", [PRICE_EXTRA_ITTYPE] = "darkmoon:180" },	-- Darkmoon Dancing Bear
				{ 2, 72140, "mount", [PRICE_EXTRA_ITTYPE] = "darkmoon:180" },	-- Swift Forest Strider
				{ 4, 73762, "pet336", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Balloon
				{ 5, 74981, "pet343", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Cub
				{ 6, 91003, "pet1061", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Hatchling
				{ 7, 73764, "pet330", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Monkey
				{ 8, 73903, "pet338", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Tonk
				{ 9, 73765, "pet335", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Turtle
				{ 10, 73905, "pet339", [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Zeppelin
				{ 11, 11026, "pet65", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Tree Frog Box
				{ 12, 11027, "pet64", [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Wood Frog Box
				{ 16, 80008, "pet848" },	-- Darkmoon Rabbit (ACM 6332)
				{ 17, 101570, "pet1276" },	-- Moon Moon (Drop: Moonfang)
				{ 18, 73953, "pet340" },	-- Sea Pony (Fishing: Darkmoon Island)
				{ 20, 91040, "pet1063", [QUEST_EXTRA_ITTYPE] = 32175 },	-- Darkmoon Eye
				{ 21, 116064, "pet1478", [QUEST_EXTRA_ITTYPE] = 36471 },	-- Syd the Squid
				{ 22, 19450, "pet106", [QUEST_EXTRA_ITTYPE] = 7946 },	-- A Jubling's Tiny Home
			},
		},
		{	--DarkmoonToys
			name = AL["Toys"].." & "..AL["Vanity Gear"],
			[NORMAL_DIFF] = {
				{ 1, 116138, [PRICE_EXTRA_ITTYPE] = "darkmoon:130" },	-- Last Deck of Nemelex Xobeh
				{ 2, 116115, "ac9252" },	-- Blazing Wings
				{ 3, 90899, [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Darkmoon Whistle
				{ 4, 75042, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Flimsy Yellow Balloon
				{ 5, 116139, [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Haunting Memento
				{ 6, 105898 },	-- Moonfang's Paw (Drop: Moonfang)
				{ 7, 101571 },	-- Moonfang Shroud (Drop: Moonfang)
				{ 8, 116067, [QUEST_EXTRA_ITTYPE] = 36477 },	-- Ring of Broken Promises
				{ 10, 19291, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon Storage Box
				{ 11, 74142, [PRICE_EXTRA_ITTYPE] = "money:100" },	-- Darkmoon Firework
				{ 12, 93730, [PRICE_EXTRA_ITTYPE] = "darkmoon:10" },	-- Darkmoon Top Hat
				{ 13, 75040, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Flimsy Darkmoon Balloon
				{ 14, 75041, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Flimsy Green Balloon
				{ 15, 18662, [PRICE_EXTRA_ITTYPE] = "money:20" },	-- Heavy Leather Ball
				{ 16, 92959, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Cougar"
				{ 17, 92966, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Dragon"
				{ 18, 92967, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Gryphon"
				{ 19, 92968, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Murloc"
				{ 20, 92958, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Nightsaber"
				{ 21, 92969, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Rocket"
				{ 22, 92956, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Snow Leopard"
				{ 23, 77158, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Tiger"
				{ 24, 92970, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon "Wyvern"
				{ 101, 78341, [PRICE_EXTRA_ITTYPE] = "darkmoon:160" },	-- Darkmoon Hammer
				{ 102, 93732 },	-- Darkmoon Fishing Cap (Fishing: Darkmoon Island)
				{ 103, 78340, [PRICE_EXTRA_ITTYPE] = "darkmoon:90" },	-- Cloak of the Darkmoon Faire
				{ 104, 77256, [PRICE_EXTRA_ITTYPE] = "darkmoon:20" },	-- Darkmoon "Sword"
				{ 105, 19295, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Darkmoon Flower
				{ 106, 19292, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Last Month's Mutton
				{ 107, 19293, [PRICE_EXTRA_ITTYPE] = "darkmoon:1" },	-- Last Year's Mutton
				{ 116, 116052, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Nobleman's Coat
				{ 117, 116137, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Noblewoman's Finery
				{ 118, 116133, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Nobleman's Pantaloons
				{ 119, 116136, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Noblewoman's Skirt
				{ 120, 116134, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Noble's Fancy Boots
			},
		},
		{	--DarkmoonTrinkets
			name = AL["Trinkets"],
			[NORMAL_DIFF] = {
				{ 1, 112303 },	-- Iron Deck
				{ 2, 112319, [QUEST_EXTRA_ITTYPE] = 34970 },	-- Knight's Badge
				{ 4, 112304 },	-- Moon Deck
				{ 5, 112320, [QUEST_EXTRA_ITTYPE] = 34973 },	-- Sandman's Pouch
				{ 7, 112305 },	-- Visions Deck
				{ 8, 112317, [QUEST_EXTRA_ITTYPE] = 34974 },	-- Winged Hourglass
				{ 10, 112306 },	-- War Deck
				{ 11, 112318, [QUEST_EXTRA_ITTYPE] = 34975 },	-- Skull of War
				{ 16, 79325 },	-- Crane Deck
				{ 17, 79330, [QUEST_EXTRA_ITTYPE] = 30449 },	-- Relic of Chi Ji
				{ 19, 79324 },	-- Ox Deck
				{ 20, 79329, [QUEST_EXTRA_ITTYPE] = 30450 },	-- Relic of Niuzao
				{ 22, 79326 },	-- Serpent Deck
				{ 23, 79331, [QUEST_EXTRA_ITTYPE] = 30451 },	-- Relic of Yu'lon
				{ 25, 79323 },	-- Tiger Deck
				{ 26, 79327, [QUEST_EXTRA_ITTYPE] = 30452 },	-- Relic of Xuen
				{ 27, 79328, [QUEST_EXTRA_ITTYPE] = 30452 },	-- Relic of Xuen
				{ 101, 62046 },	-- Earthquake Deck
				{ 102, 62048, [QUEST_EXTRA_ITTYPE] = 27667 },	-- Darkmoon Card: Earthquake
				{ 104, 62045 },	-- Hurricane Deck
				{ 105, 62049, [QUEST_EXTRA_ITTYPE] = 27665 },	-- Darkmoon Card: Hurricane
				{ 106, 62051, [QUEST_EXTRA_ITTYPE] = 27665 },	-- Darkmoon Card: Hurricane
				{ 108, 62044 },	-- Tsunami Deck
				{ 109, 62050, [QUEST_EXTRA_ITTYPE] = 27666 },	-- Darkmoon Card: Tsunami
				{ 111, 62021 },	-- Volcanic Deck
				{ 112, 62047, [QUEST_EXTRA_ITTYPE] = 27664 },	-- Darkmoon Card: Volcano
				{ 116, 44276 },	-- Chaos Deck
				{ 117, 42989, [QUEST_EXTRA_ITTYPE] = 13325 },	-- Darkmoon Card: Berserker!
				{ 119, 44259 },	-- Prisms Deck
				{ 120, 42988, [QUEST_EXTRA_ITTYPE] = 13324 },	-- Darkmoon Card: Illusion
				{ 122, 44294 },	-- Undeath Deck
				{ 123, 42990, [QUEST_EXTRA_ITTYPE] = 13327 },	-- Darkmoon Card: Death
				{ 125, 44326 },	-- Nobles Deck
				{ 126, 44253, [QUEST_EXTRA_ITTYPE] = 13326 },	-- Darkmoon Card: Greatness
				{ 127, 42987, [QUEST_EXTRA_ITTYPE] = 13326 },	-- Darkmoon Card: Greatness
				{ 128, 44254, [QUEST_EXTRA_ITTYPE] = 13326 },	-- Darkmoon Card: Greatness
				{ 129, 44255, [QUEST_EXTRA_ITTYPE] = 13326 },	-- Darkmoon Card: Greatness
				{ 201, 31890 },	-- Blessings Deck
				{ 202, 31856, [QUEST_EXTRA_ITTYPE] = 10938 },	-- Darkmoon Card: Crusade
				{ 204, 31907 },	-- Furies Deck
				{ 205, 31858, [QUEST_EXTRA_ITTYPE] = 10940 },	-- Darkmoon Card: Vengeance
				{ 207, 31914 },	-- Lunacy Deck
				{ 208, 31859, [QUEST_EXTRA_ITTYPE] = 10941 },	-- Darkmoon Card: Madness
				{ 210, 31891 },	-- Storms Deck
				{ 211, 31857, [QUEST_EXTRA_ITTYPE] = 10939 },	-- Darkmoon Card: Wrath
				{ 216, 19228 },	-- Beasts Deck
				{ 217, 19288, [QUEST_EXTRA_ITTYPE] = 7907 },	-- Darkmoon Card: Blue Dragon
				{ 219, 19267 },	-- Elementals Deck
				{ 220, 19289, [QUEST_EXTRA_ITTYPE] = 7929 },	-- Darkmoon Card: Maelstrom
				{ 222, 19277 },	-- Portals Deck
				{ 223, 19290, [QUEST_EXTRA_ITTYPE] = 7927 },	-- Darkmoon Card: Twisting Nether
				{ 225, 19257 },	-- Warlords Deck
				{ 226, 19287, [QUEST_EXTRA_ITTYPE] = 7928 },	-- Darkmoon Card: Heroism
				{ 301, 44158 },	-- Demons Deck
				{ 302, 44217, [QUEST_EXTRA_ITTYPE] = 13311 },	-- Darkmoon Dirk
				{ 303, 44218, [QUEST_EXTRA_ITTYPE] = 13311 },	-- Darkmoon Executioner
				{ 304, 44219, [QUEST_EXTRA_ITTYPE] = 13311 },	-- Darkmoon Magestaff
				{ 306, 44148 },	-- Mages Deck
				{ 307, 44215, [QUEST_EXTRA_ITTYPE] = 12518 },	-- Darkmoon Necklace
				{ 308, 44213, [QUEST_EXTRA_ITTYPE] = 12518 },	-- Darkmoon Pendant
				{ 316, 37164 },	-- Swords Deck
				{ 317, 39894, [QUEST_EXTRA_ITTYPE] = 12798 },	-- Darkcloth Shoulders
				{ 318, 39895, [QUEST_EXTRA_ITTYPE] = 12798 },	-- Cloaked Shoulderpads
				{ 319, 39897, [QUEST_EXTRA_ITTYPE] = 12798 },	-- Azure Shoulderguards
				{ 321, 37163 },	-- Rogues Deck
				{ 322, 38318, [QUEST_EXTRA_ITTYPE] = 12517 },	-- Darkmoon Robe
				{ 323, 39509, [QUEST_EXTRA_ITTYPE] = 12517 },	-- Darkmoon Vest
				{ 324, 39507, [QUEST_EXTRA_ITTYPE] = 12517 },	-- Darkmoon Chain Shirt
			},
		},
		{	--DarkmoonFoodDrinks
			name = AL["Food"].." & "..AL["Drinks"],
			[NORMAL_DIFF] = {
				{ 1, 19223, [PRICE_EXTRA_ITTYPE] = "money:25" },	-- Darkmoon Dog
				{ 2, 19304, [PRICE_EXTRA_ITTYPE] = "money:125" },	-- Spiced Beef Jerky
				{ 3, 19305, [PRICE_EXTRA_ITTYPE] = "money:500" },	-- Pickled Kodo Foot
				{ 4, 19224, [PRICE_EXTRA_ITTYPE] = "money:1000" },	-- Red Hot Wings
				{ 5, 19306, [PRICE_EXTRA_ITTYPE] = "money:2000" },	-- Crunchy Frog
				{ 6, 19225, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Deep Fried Candybar
				{ 7, 33246, [PRICE_EXTRA_ITTYPE] = "money:5600" },	-- Funnel Cake
				{ 8, 33254, [PRICE_EXTRA_ITTYPE] = "money:8000" },	-- Forest Strider Drumstick
				{ 9, 44940, [PRICE_EXTRA_ITTYPE] = "money:16000" },	-- Corn-Breaded Sausage
				{ 10, 73260, [PRICE_EXTRA_ITTYPE] = "money:20000" },	-- Salty Sea Dog
				{ 16, 75029, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Beer-Basted Short Ribs
				{ 17, 75031, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Draenic Dumplings
				{ 18, 75034, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Forsaken Foie Gras
				{ 19, 75030, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Gnomeregan Gnuggets
				{ 20, 75033, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Green Ham & Eggs
				{ 21, 75032, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Mulgore Meat Pie
				{ 22, 75036, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Silvermoon Steak
				{ 23, 75028, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Stormwind Surprise
				{ 24, 75027, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Teldrassil Tenderloin
				{ 25, 75035, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Troll Tartare
				{ 101, 19299, [PRICE_EXTRA_ITTYPE] = "money:500" },	-- Fizzy Faire Drink
				{ 102, 19300, [PRICE_EXTRA_ITTYPE] = "money:2000" },	-- Bottled Winterspring Water
				{ 103, 33234, [PRICE_EXTRA_ITTYPE] = "money:4000" },	-- Iced Berry Slush
				{ 104, 33236, [PRICE_EXTRA_ITTYPE] = "money:5600" },	-- Fizzy Faire Drink 'Classic'
				{ 105, 44941, [PRICE_EXTRA_ITTYPE] = "money:8500" },	-- Fresh-Squeezed Limeade
				{ 106, 74822, [PRICE_EXTRA_ITTYPE] = "money:13750" },	-- Sasparilla Sinker
				{ 116, 19222, [PRICE_EXTRA_ITTYPE] = "money:10" },	-- Cheap Beer
				{ 117, 19221, [PRICE_EXTRA_ITTYPE] = "money:50" },	-- Darkmoon Special Reserve
				{ 118, 93208, [PRICE_EXTRA_ITTYPE] = "money:80000" },	-- Darkmoon P.I.E
			},
		},
		{	--DarkmoonHeirloomArmor
			name = AL["Heirloom"].." - "..AL["Armor"],
			[NORMAL_DIFF] = {
				{ 1, 93859, [PRICE_EXTRA_ITTYPE] = "42985:1:darkmoon:44" },	-- Bloodstained Dreadmist Mantle
				{ 2, 93864, [PRICE_EXTRA_ITTYPE] = "42984:1:darkmoon:44" },	-- Majestic Ironfeather Shoulders
				{ 3, 93862, [PRICE_EXTRA_ITTYPE] = "42952:1:darkmoon:44" },	-- Supple Shadowcraft Spaulders
				{ 4, 93887, [PRICE_EXTRA_ITTYPE] = "42950:1:darkmoon:44" },	-- Grand Champion Herod's Shoulder
				{ 5, 93876, [PRICE_EXTRA_ITTYPE] = "42951:1:darkmoon:44" },	-- Awakened Pauldrons of Elements
				{ 6, 93893, [PRICE_EXTRA_ITTYPE] = "69890:1:darkmoon:44" },	-- Brushed Pauldrons of Might
				{ 7, 93890, [PRICE_EXTRA_ITTYPE] = "42949:1:darkmoon:44" },	-- Gleaming Spaulders of Valor
				{ 9, 93860, [PRICE_EXTRA_ITTYPE] = "48691:1:darkmoon:44" },	-- Bloodstained Dreadmist Robe
				{ 10, 93865, [PRICE_EXTRA_ITTYPE] = "48687:1:darkmoon:44" },	-- Majestic Ironfeather Breastplate
				{ 11, 93863, [PRICE_EXTRA_ITTYPE] = "48689:1:darkmoon:44" },	-- Supple Shadowcraft Tunic
				{ 12, 93888, [PRICE_EXTRA_ITTYPE] = "48677:1:darkmoon:44" },	-- Furious Deathdealer Breastplate
				{ 13, 93885, [PRICE_EXTRA_ITTYPE] = "48683:1:darkmoon:44" },	-- Awakened Vest of Elements
				{ 14, 93892, [PRICE_EXTRA_ITTYPE] = "69889:1:darkmoon:44" },	-- Brushed Breastplate of Might
				{ 15, 93891, [PRICE_EXTRA_ITTYPE] = "48685:1:darkmoon:44" },	-- Gleaming Breastplate of Valor
				{ 16, 42985, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Tattered Dreadmist Mantle
				{ 17, 42984, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Preened Ironfeather Shoulders
				{ 18, 42952, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Stained Shadowcraft Spaulders
				{ 19, 42950, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Champion Herod's Shoulder
				{ 20, 42951, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Mystical Pauldrons of Elements
				{ 21, 69890, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Burnished Pauldrons of Might
				{ 22, 42949, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Polished Spaulders of Valor
				{ 24, 48691, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Tattered Dreadmist Robe
				{ 25, 48687, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Preened Ironfeather Breastplate
				{ 26, 48689, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Stained Shadowcraft Tunic
				{ 27, 48677, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Champion's Deathdealer Breastplate
				{ 28, 48683, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Mystical Vest of Elements
				{ 29, 69889, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Burnished Breastplate of Might
				{ 30, 48685, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Polished Breastplate of Valor
			},
		},
		{	--DarkmoonHeirloomWeapons
			name = AL["Heirloom"].." - "..AL["Trinkets"].." & "..AL["Weapons"],
			[NORMAL_DIFF] = {
				{ 1, 93897, [PRICE_EXTRA_ITTYPE] = "42992:1:darkmoon:60" },	-- Piercing Eye of the Beast
				{ 2, 93896, [PRICE_EXTRA_ITTYPE] = "42991:1:darkmoon:60" },	-- Forceful Hand of Justice
				{ 4, 93857, [PRICE_EXTRA_ITTYPE] = "42944:1:darkmoon:44" },	-- Vengeful Heartseeker
				{ 5, 93845, [PRICE_EXTRA_ITTYPE] = "69893:1:darkmoon:44" },	-- Gore-Steeped Skullforge Reaver
				{ 6, 93856, [PRICE_EXTRA_ITTYPE] = "42945:1:darkmoon:44" },	-- Noble Dal'Rend's Sacred Charge
				{ 7, 93843, [PRICE_EXTRA_ITTYPE] = "42943:1:darkmoon:64" },	-- Hardened Arcanite Reaper
				{ 8, 93853, [PRICE_EXTRA_ITTYPE] = "42948:1:darkmoon:44" },	-- Pious Aurastone Hammer
				{ 9, 93847, [PRICE_EXTRA_ITTYPE] = "48716:1:darkmoon:44" },	-- Crushing Mass of McGowan
				{ 10, 93846, [PRICE_EXTRA_ITTYPE] = "48718:1:darkmoon:64" },	-- Re-Engineered Lava Dredger
				{ 11, 93844, [PRICE_EXTRA_ITTYPE] = "79131:1:darkmoon:64" },	-- Refinished Warden Staff
				{ 12, 93854, [PRICE_EXTRA_ITTYPE] = "42947:1:darkmoon:64" },	-- Scholarly Headmaster's Charge
				{ 13, 93855, [PRICE_EXTRA_ITTYPE] = "42946:1:darkmoon:64" },	-- War-Torn Ancient Bone Bow
				{ 14, 93902, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Flamescarred Draconian Deflector
				{ 15, 93903, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Weathered Observer's Shield
				{ 16, 42992, [PRICE_EXTRA_ITTYPE] = "darkmoon:130" },	-- Discerning Eye of the Beast
				{ 17, 42991, [PRICE_EXTRA_ITTYPE] = "darkmoon:130" },	-- Swift Hand of Justice
				{ 19, 42944, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Balanced Heartseeker
				{ 20, 69893, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Bloodsoaked Skullforge Reaver
				{ 21, 42945, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Venerable Dal'Rend's Sacred Charge
				{ 22, 42943, [PRICE_EXTRA_ITTYPE] = "darkmoon:160" },	-- Bloodied Arcanite Reaper
				{ 23, 42948, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Devout Aurastone Hammer
				{ 24, 48716, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Venerable Mass of McGowan
				{ 25, 48718, [PRICE_EXTRA_ITTYPE] = "darkmoon:160" },	-- Repurposed Lava Dredger
				{ 26, 79131, [PRICE_EXTRA_ITTYPE] = "darkmoon:160" },	-- Burnished Warden Staff
				{ 27, 42947, [PRICE_EXTRA_ITTYPE] = "darkmoon:160" },	-- Dignified Headmaster's Charge
				{ 28, 42946, [PRICE_EXTRA_ITTYPE] = "darkmoon:160" },	-- Charmed Ancient Bone Bow
				{ 29, 93904, [PRICE_EXTRA_ITTYPE] = "darkmoon:110" },	-- Musty Tome of the Lost
			},
		},
		{	--DarkmoonReplicasDruid
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			[NORMAL_DIFF] = {
				{ 1, 78238, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Wildheart Cowl
				{ 2, 78239, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Wildheart Spaulders
				{ 3, 78242, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Wildheart Vest
				{ 4, 78240, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Wildheart Bracers
				{ 5, 78241, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Wildheart Gloves
				{ 6, 78244, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Wildheart Belt
				{ 7, 78245, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Wildheart Kilt
				{ 8, 78243, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Wildheart Boots
				{ 16, 78249, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Feralheart Cowl
				{ 17, 78247, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Feralheart Spaulders
				{ 18, 78252, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Feralheart Vest
				{ 19, 78253, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Feralheart Bracers
				{ 20, 78248, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Feralheart Gloves
				{ 21, 78246, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Feralheart Belt
				{ 22, 78250, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Feralheart Kilt
				{ 23, 78251, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Feralheart Boots
			},
		},
		{	--DarkmoonReplicasHunter
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			[NORMAL_DIFF] = {
				{ 1, 78275, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beaststalker's Cap
				{ 2, 78273, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beaststalker's Mantle
				{ 3, 78270, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beaststalker's Tunic
				{ 4, 78277, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beaststalker's Bindings
				{ 5, 78271, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beaststalker's Gloves
				{ 6, 78274, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beaststalker's Belt
				{ 7, 78276, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beaststalker's Pants
				{ 8, 78272, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beaststalker's Boots
				{ 16, 78284, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beastmaster's Cap
				{ 17, 78281, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beastmaster's Mantle"
				{ 18, 78282, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beastmaster's Tunic
				{ 19, 78283, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beastmaster's Bindings
				{ 20, 78278, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beastmaster's Gloves
				{ 21, 78285, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beastmaster's Belt
				{ 22, 78280, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Beastmaster's Pants
				{ 23, 78279, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Beastmaster's Boots
			},
		},
		{	--DarkmoonReplicasMage
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			[NORMAL_DIFF] = {
				{ 1, 78188, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Magister's Crown
				{ 2, 78191, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Magister's Mantle
				{ 3, 78190, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Magister's Robes
				{ 4, 78193, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Magister's Bindings
				{ 5, 78187, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Magister's Gloves
				{ 6, 78192, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Magister's Belt
				{ 7, 78189, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Magister's Leggings
				{ 8, 78186, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Magister's Boots
				{ 16, 78198, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Sorcerer's Crown
				{ 17, 78201, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Sorcerer's Mantle
				{ 18, 78200, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Sorcerer's Robes
				{ 19, 78203, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Sorcerer's Bindings
				{ 20, 78197, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Sorcerer's Gloves
				{ 21, 78202, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Sorcerer's Belt
				{ 22, 78199, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Sorcerer's Leggings
				{ 23, 78196, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Sorcerer's Boots
			},
		},
		{	--DarkmoonReplicasPaladin
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			[NORMAL_DIFF] = {
				{ 1, 78307, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Lightforge Helm
				{ 2, 78308, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Lightforge Spaulders
				{ 3, 78306, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Lightforge Breastplate
				{ 4, 78304, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Lightforge Bracers
				{ 5, 78303, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Lightforge Gauntlets
				{ 6, 78302, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Lightforge Belt
				{ 7, 78305, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Lightforge Legplates
				{ 8, 78309, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Lightforge Boots
				{ 16, 78312, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Soulforge Helm
				{ 17, 78316, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Soulforge Spaulders
				{ 18, 78313, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Soulforge Breastplate
				{ 19, 78317, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Soulforge Bracers
				{ 20, 78314, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Soulforge Gauntlets
				{ 21, 78311, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Soulforge Belt
				{ 22, 78315, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Soulforge Legplates
				{ 23, 78310, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Soulforge Boots
			},
		},
		{	--DarkmoonReplicasPriest
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			[NORMAL_DIFF] = {
				{ 1, 78205, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Devout Crown
				{ 2, 78204, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Devout Mantle
				{ 3, 78209, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Devout Robe
				{ 4, 78211, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Devout Bracers
				{ 5, 78208, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Devout Gloves
				{ 6, 78207, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Devout Belt
				{ 7, 78206, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Devout Skirt
				{ 8, 78210, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Devout Sandals
				{ 16, 78216, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Virtuous Crown
				{ 17, 78213, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Virtuous Mantle
				{ 18, 78212, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Virtuous Robe
				{ 19, 78215, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Virtuous Bracers
				{ 20, 78217, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Virtuous Gloves
				{ 21, 78218, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Virtuous Belt
				{ 22, 78214, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Virtuous Skirt
				{ 23, 78219, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Virtuous Sandals
			},
		},
		{	--DarkmoonReplicasRogue
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			[NORMAL_DIFF] = {
				{ 1, 78260, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Shadowcraft Cap
				{ 2, 78261, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Shadowcraft Spaulders
				{ 3, 78254, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Shadowcraft Tunic
				{ 4, 78255, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Shadowcraft Bracers
				{ 5, 78257, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Shadowcraft Gloves
				{ 6, 78259, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Shadowcraft Belt
				{ 7, 78258, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Shadowcraft Pants
				{ 8, 78256, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Shadowcraft Boots
				{ 16, 78263, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Darkmantle Cap
				{ 17, 78267, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Darkmantle Spaulders
				{ 18, 78269, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Darkmantle Tunic
				{ 19, 78264, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Darkmantle Bracers
				{ 20, 78266, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Darkmantle Gloves
				{ 21, 78265, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Darkmantle Belt
				{ 22, 78268, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Darkmantle Pants
				{ 23, 78262, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Darkmantle Boots
			},
		},
		{	--DarkmoonReplicasShaman
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			[NORMAL_DIFF] = {
				{ 1, 78286, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Coif of Elements
				{ 2, 78288, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Pauldrons of Elements
				{ 3, 78290, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Vest of Elements
				{ 4, 78289, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Bindings of Elements
				{ 5, 78291, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Gauntlets of Elements
				{ 6, 78293, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Cord of Elements
				{ 7, 78287, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Kilt of Elements
				{ 8, 78292, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Boots of Elements
				{ 16, 78294, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Coif of The Five Thunders
				{ 17, 78299, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Pauldrons of The Five Thunders
				{ 18, 78300, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Vest of The Five Thunders
				{ 19, 78296, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Bindings of The Five Thunders
				{ 20, 78295, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Gauntlets of The Five Thunders
				{ 21, 78297, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Cord of The Five Thunders
				{ 22, 78301, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Kilt of The Five Thunders
				{ 23, 78298, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Boots of The Five Thunders
			},
		},
		{	--DarkmoonReplicasWarlock
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			[NORMAL_DIFF] = {
				{ 1, 78227, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Dreadmist Mask
				{ 2, 78226, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Dreadmist Mantle
				{ 3, 78225, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Dreadmist Robe
				{ 4, 78229, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Dreadmist Bracers
				{ 5, 78223, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Dreadmist Wraps
				{ 6, 78222, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Dreadmist Belt
				{ 7, 78228, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Dreadmist Leggings
				{ 8, 78224, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Dreadmist Sandals
				{ 16, 78230, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Deathmist Mask
				{ 17, 78234, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Deathmist Mantle
				{ 18, 78237, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Deathmist Robe
				{ 19, 78232, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Deathmist Bracers
				{ 20, 78236, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Deathmist Wraps
				{ 21, 78233, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Deathmist Belt
				{ 22, 78231, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Deathmist Leggings
				{ 23, 78235, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Deathmist Sandals
			},
		},
		{	--DarkmoonReplicasWarrior
			name = AL["Transmoggable Replicas"].." - "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			[NORMAL_DIFF] = {
				{ 1, 78322, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Helm of Valor
				{ 2, 78325, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Spaulders of Valor
				{ 3, 78323, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Breastplate of Valor
				{ 4, 78321, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Bracers of Valor
				{ 5, 78320, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Gauntlets of Valor
				{ 6, 78319, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Belt of Valor
				{ 7, 78324, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Legplates of Valor
				{ 8, 78318, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Boots of Valor
				{ 16, 78330, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Helm of Heroism
				{ 17, 78332, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Spaulders of Heroism
				{ 18, 78328, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Breastplate of Heroism
				{ 19, 78327, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Bracers of Heroism
				{ 20, 78329, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Gauntlets of Heroism
				{ 21, 78333, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Belt of Heroism
				{ 22, 78331, [PRICE_EXTRA_ITTYPE] = "darkmoon:75" },	-- Replica Legplates of Heroism
				{ 23, 78326, [PRICE_EXTRA_ITTYPE] = "darkmoon:55" },	-- Replica Boots of Heroism
			},
		},
	}
}

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
				{ 1, 116856, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Blooming Rose" Contender's Costume
				{ 2, 116888, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Night Demon" Contender's Costume
				{ 3, 116889, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Purple Phantom" Contender's Costume
				{ 4, 116890, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Santo's Sun" Contender's Costume
				{ 5, 116891, [PRICE_EXTRA_ITTYPE] = "money:1000000" },	-- "Snowy Owl" Contender's Costume
				{ 7, 46831, "pet1351", [QUEST_EXTRA_ITTYPE] = 14174 },	-- Macabre Marionette
				{ 16, 46718, [PRICE_EXTRA_ITTYPE] = "money:10" },	-- Orange Marigold
				{ 17, 46861, [PRICE_EXTRA_ITTYPE] = "money:10000" },	-- Bouquet of Orange Marigolds
				{ 19, 46710, [PRICE_EXTRA_ITTYPE] = "money:2000" },	-- Recipe: Bread of the Dead (p3 1)
				{ 20, 46691 },	-- Bread of the Dead
				{ 22, 46690, [PRICE_EXTRA_ITTYPE] = "money:25" },	-- Candy Skull
				{ 23, 46711, [PRICE_EXTRA_ITTYPE] = "money:30" },	-- Spirit Candle
				{ 24, 46860, [PRICE_EXTRA_ITTYPE] = "money:5" },	-- Whimsical Skull Mask
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