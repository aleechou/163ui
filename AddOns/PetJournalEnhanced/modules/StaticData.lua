local zoneIDs = PetJournalEnhanced:NewModule("ZoneIDs")

zoneIDs.continents = {
	 [1] = {--	Kalimdor
		772,--	Ahn'Qiraj: The Fallen Kingdom
		894,--	Ammen Vale MoP
		43,--	Ashenvale
		181,--	Azshara
		464,--	Azuremyst Isle
		476,--	Bloodmyst Isle
		890,--	Camp Narache MoP
		42,--	Darkshore
		381,--	Darnassus
		101,--	Desolace
		4,--	Durotar
		141,--	Dustwallow Marsh
		891,--	Echo Isles MoP
		182,--	Felwood
		121,--	Feralas
		795,--	Molten Front
		241,--	Moonglade
		606,--	Mount Hyjal
		9,--	Mulgore
		11,--	Northern Barrens
		321,--	Orgrimmar
		888,--	Shadowglen MoP
		261,--	Silithus
		607,--	Southern Barrens
		81,--	Stonetalon Mountains
		161,--	Tanaris
		41,--	Teldrassil
		471,--	The Exodar
		61,--	Thousand Needles
		362,--	Thunder Bluff
		720,--	Uldum
		201,--	Un'Goro Crater
		889,--	Valley of Trials MoP
		281,--	Winterspring
	},
	[2] = {--	Eastern Kingdoms
		614,--	Abyssal Depths
		16,--	Arathi Highlands
		17,--	Badlands
		19,--	Blasted Lands
		29,--	Burning Steppes
		866,--	Coldridge Valley MoP
		32,--	Deadwind Pass
		892,--	Deathknell MoP
		27,--	Dun Morogh
		34,--	Duskwood
		23,--	Eastern Plaguelands
		30,--	Elwynn Forest
		462,--	Eversong Woods
		463,--	Ghostlands
		545,--	Gilneas
		611,--	Gilneas City
		24,--	Hillsbrad Foothills
		341,--	Ironforge
		499,--	Isle of Quel'Danas
		610,--	Kelp'thar Forest
		35,--	Loch Modan
		895,--	New Tinkertown MoP
		37,--	Northern Stranglethorn
		864,--	Northshire MoP
		36,--	Redridge Mountains
		684,--	Ruins of Gilneas
		685,--	Ruins of Gilneas City
		28,--	Searing Gorge
		615,--	Shimmering Expanse
		480,--	Silvermoon City
		21,--	Silverpine Forest
		301,--	Stormwind City
		689,--	Stranglethorn Vale
		893,--	Sunstrider Isle MoP
		38,--	Swamp of Sorrows
		673,--	The Cape of Stranglethorn
		26,--	The Hinterlands
		502,--	The Scarlet Enclave
		20,--	Tirisfal Glades
		708,--	Tol Barad
		709,--	Tol Barad Peninsula
		700,--	Twilight Highlands
		382,--	Undercity
		613,--	Vashj'ir
		22,--	Western Plaguelands
		39,--	Westfall
		40,--	Wetlands
	},
	[3]={--	Outland
		475,--	Blade's Edge Mountains
		465,--	Hellfire Peninsula
		477,--	Nagrand
		479,--	Netherstorm
		473,--	Shadowmoon Valley
		481,--	Shattrath City
		478,--	Terokkar Forest
		467,--	Zangarmarsh
	},
	

	[4]={--	Northrend
		486,--	Borean Tundra
		510,--	Crystalsong Forest
		504,--	Dalaran
		488,--	Dragonblight
		490,--	Grizzly Hills
		491,--	Howling Fjord
		541,--	Hrothgar's Landing
		492,--	Icecrown
		493,--	Sholazar Basin
		495,--	The Storm Peaks
		501,--	Wintergrasp
		496,--	Zul'Drak
	},


	[5]={--	The Maelstrom
		640,--	Deepholm
		605,--	Kezan
		544,--	The Lost Isles
		737,--	The Maelstrom
		823,-- Darkmoon Island
	},

	[6]={-- Pandaria MoP
		858,--  Dread Wastes MoP
		929,--  Isle of Giants MoP
		928,--  Isle of Thunder MoP
		857,--  Krasarang Wilds MoP
		809,--  Kun-Lai Summit MoP
		905,--  Shrine of Seven Stars MoP
		903,--  Shrine of Two Moons MoP
		806,--  The Jade Forest MoP
		873,--  The Veiled Stair MoP
		808,--  The Wandering Isle MoP
		951,--  Timeless Isle
		810,--  Townlong Steppes MoP
		811,--  Vale of Eternal Blossoms MoP
		807,--  Valley of the Four Winds MoP
	},
	[7]={--Instances
		930,--  Throne of Thunder MoP
		401,--	Alterac Valley
		461,--	Arathi Basin
		482,--	Eye of the Storm
		540,--	Isle of Conquest
		512,--	Strand of the Ancients
		736,--	The Battle for Gilneas
		626,--	Twin Peaks
		443,--	Warsong Gulch
		688,--	Blackfathom Deeps
		704,--	Blackrock Depths
		721,--	Blackrock Spire
		699,--	Dire Maul
		691,--	Gnomeregan
		750,--	Maraudon
		680,--	Ragefire Chasm
		760,--	Razorfen Downs
		761,--	Razorfen Kraul
		762,--	Scarlet Monastery
		763,--	Scholomance
		764,--	Shadowfang Keep
		765,--	Stratholme
		756,--	The Deadmines
		690,--	The Stockade
		687,--	The Temple of Atal'Hakkar
		692,--	Uldaman
		749,--	Wailing Caverns
		686,--	Zul'Farrak
		755,--	Blackwing Lair
		696,--	Molten Core
		717,--	Ruins of Ahn'Qiraj
		766,--	Temple of Ahn'Qiraj
		722,--	Auchenai Crypts
		797,--	Hellfire Ramparts
		798,--	Magisters' Terrace
		732,--	Mana-Tombs
		734,--	Old Hillsbrad Foothills
		723,--	Sethekk Halls
		724,--	Shadow Labyrinth
		731,--	The Arcatraz
		733,--	The Black Morass
		725,--	The Blood Furnace
		729,--	The Botanica
		730,--	The Mechanar
		710,--	The Shattered Halls
		728,--	The Slave Pens
		727,--	The Steamvault
		726,--	The Underbog
		796,--	Black Temple
		776,--	Gruul's Lair
		775,--	Hyjal Summit
		799,--	Karazhan
		779,--	Magtheridon's Lair
		780,--	Serpentshrine Cavern
		789,--	Sunwell Plateau
		782,--	The Eye
		522,--	Ahn'kahet: The Old Kingdom
		533,--	Azjol-Nerub
		534,--	Drak'Tharon Keep
		530,--	Gundrak
		525,--	Halls of Lightning
		603,--	Halls of Reflection
		526,--	Halls of Stone
		602,--	Pit of Saron
		521,--	The Culling of Stratholme
		601,--	The Forge of Souls
		520,--	The Nexus
		528,--	The Oculus
		536,--	The Violet Hold
		542,--	Trial of the Champion
		523,--	Utgarde Keep
		524,--	Utgarde Pinnacle
		604,--	Icecrown Citadel
		535,--	Naxxramas
		718,--	Onyxia's Lair
		527,--	The Eye of Eternity
		531,--	The Obsidian Sanctum
		609,--	The Ruby Sanctum
		543,--	Trial of the Crusader
		529,--	Ulduar
		532,--	Vault of Archavon
		753,--	Blackrock Caverns
		820,--	End Time
		757,--	Grim Batol
		759,--	Halls of Origination
		819,--	Hour of Twilight
		747,--	Lost City of the Tol'vir
		768,--	The Stonecore
		769,--	The Vortex Pinnacle
		767,--	Throne of the Tides
		816,--	Well of Eternity
		781,--	Zul'Aman
		793,--	Zul'Gurub
		752,--	Baradin Hold
		754,--	Blackwing Descent
		824,--	Dragon Soul
		800,--	Firelands
		758,--	The Bastion of Twilight
		773,--	Throne of the Four Winds
		875,--	Gate of the Setting Sun MoP
		885,--	Mogu'Shan Palace MoP
		877,--	Shado-pan Monastery MoP
		887,--	Siege of Niuzao Temple MoP
		876,--	Stormstout Brewery MoP
		867,--	Temple of the Jade Serpent MoP
		897,--	Heart of Fear MoP
		896,--	Mogu'shan Vaults MoP
		886,--	Terrace of Endless Spring MoP
		953,--  Siege of Orgrimmar
	}
}



zoneIDs.SpeciesToZoneId = { 
[635]={[19]=19,[27]=27,[4]=4,[465]=465,[477]=477,[11]=11,[37]=37},--Adder
[74]={[510]=510},--Albino Snake
[331]={[301]=301},--Alliance Balloon
[487]={[606]=606,[81]=81,[281]=281},--Alpine Chipmunk
[441]={[27]=27,[281]=281},--Alpine Hare
[212]={[492]=492},--Ammen Vale Lashling
[52]={[61]=61},--Ancona Chicken
[1155]={[766]=766},--Anubisath Idol
[836]={[858]=858},--Aqua Strider
[1160]={[32]=32},--Arcane Eye
[214]={[492]=492},--Argent Squire
[425]={[29]=29,[473]=473},--Ash Viper
[1150]={[696]=696},--Ashstone Core
[57]={[281]=281},--Azure Whelpling
[406]={[17]=17,[42]=42,[23]=23,[182]=182,[37]=37,[261]=261,[673]=673,[201]=201},--Beetle
[75]={[321]=321},--Black Kingsnake
[398]={[17]=17,[27]=27,[34]=34,[141]=141,[23]=23,[605]=605,[61]=61,[700]=700,[22]=22,[40]=40},--Black Rat
[42]={[24]=24},--Black Tabby Cat
[456]={[22]=22},--Blighthawk
[145]={[479]=479},--Blue Dragonhawk Hatchling
[259]={[606]=606},--Blue Mini Jouster
[138]={[471]=471},--Blue Moth
[40]={[30]=30},--Bombay Cat
[639]={[486]=486},--Borean Marmot
[449]={[475]=475,[26]=26},--Brown Marmot
[70]={[9]=9},--Brown Prairie Dog
[137]={[479]=479},--Brown Rabbit
[77]={[321]=321},--Brown Snake
[224]={[510]=510},--Calico Cat
[646]={[461]=461,[464]=464,[476]=476,[34]=34,[141]=141,[30]=30,[545]=545,[24]=24,[491]=491,[11]=11,[36]=36,[481]=481,[20]=20,[39]=39,[40]=40},--Chicken
[1152]={[755]=755},--Chrominius
[174]={[481]=481},--Chuck
[518]={[477]=477},--Clefthoof Runt
[1142]={[321]=321},--Clock'em
[47]={[673]=673},--Cockatiel
[1164]={[475]=475},--Cogblade Raptor
[1149]={[696]=696},--Corefire Imp
[41]={[30]=30},--Cornish Rex Cat
[468]={[4]=4},--Creepy Crawly
[318]={[795]=795},--Crimson Lasher
[421]={[37]=37,[673]=673},--Crimson Moth
[78]={[479]=479},--Crimson Snake
[58]={[40]=40},--Crimson Whelpling
[634]={[281]=281},--Crystal Spider
[751]={[811]=811},--Dancing Water Skimmer
[56]={[40]=40,[141]=141,[17]=17,[29]=29},--Dark Whelpling
[336]={[823]=823},--Darkmoon Balloon
[343]={[823]=823},--Darkmoon Cub
[1061]={[823]=823},--Darkmoon Hatchling
[330]={[823]=823},--Darkmoon Monkey
[338]={[823]=823},--Darkmoon Tonk
[335]={[823]=823},--Darkmoon Turtle
[339]={[823]=823},--Darkmoon Zeppelin
[232]={[141]=141},--Darting Hatchling
[1153]={[755]=755},--Death Talon Whelpguard
[233]={[749]=749},--Deviate Hatchling
[537]={[488]=488},--Dragonbone Hatchling
[205]={[492]=492},--Dun Morogh Cub
[207]={[492]=492},--Durotar Scorpion
[396]={[34]=34},--Dusk Spiderling
[747]={[811]=811},--Effervescent Glowfly
[293]={[640]=640,[700]=700,[720]=720},--Elementium Geode
[209]={[492]=492},--Elwynn Lamb
[59]={[121]=121},--Emerald Whelpling
[213]={[492]=492},--Enchanted Broom
[383]={[811]=811},--Eternal Strider
[519]={[473]=473},--Fel Flame
[319]={[20]=20},--Feline Familiar
[342]={[241]=241},--Festival Lantern
[415]={[19]=19,[29]=29,[606]=606,[28]=28,[201]=201},--Fire Beetle
[146]={[467]=467},--Firefly
[847]={[806]=806},--Fishy
[1162]={[27]=27},--Fluxfire Feline
[407]={[37]=37,[673]=673},--Forest Spiderling
[278]={[709]=709},--Fox Kit
[1144]={[535]=535},--Fungal Abomination
[190]={[510]=510},--Ghostly Skull
[1143]={[535]=535},--Giant Bone Spider
[193]={[504]=504},--Giant Sewer Rat
[260]={[606]=606},--Gold Mini Jouster
[749]={[811]=811},--Golden Civet
[750]={[811]=811},--Golden Civet Kitten
[142]={[462]=462},--Golden Dragonhawk Hatchling
[68]={[41]=41},--Great Horned Owl
[50]={[756]=756},--Green Wing Macaw
[834]={[858]=858},--Grinder
[234]={[496]=496},--Gundrak Hatchling
[1147]={[696]=696},--Harbinger of Flame
[67]={[41]=41},--Hawk Owl
[648]={[24]=24,[38]=38,[700]=700,[496]=496},--Huge Toad
[49]={[37]=37,[673]=673},--Hyacinth Macaw
[317]={[795]=795},--Hyjal Bear Cub
[628]={[476]=476,[23]=23,[21]=21},--Infected Fawn
[627]={[476]=476,[23]=23,[21]=21},--Infected Squirrel
[453]={[24]=24},--Infested Bear Cub
[442]={[27]=27},--Irradiated Roach
[1202]={[930]=930},--Ji-Kun Hatchling
[1166]={[809]=809},--Kun-Lai Runt
[307]={[793]=793},--Lashtail Hatchling
[423]={[29]=29,[28]=28},--Lava Crab
[235]={[11]=11},--Leaping Hatchling
[408]={[37]=37,[673]=673},--Lizard Hatchling
[404]={[27]=27,[37]=37,[673]=673,[201]=201},--Long-tailed Mole
[458]={[20]=20},--Lost of Lordaeron
[450]={[43]=43,[27]=27,[463]=463,[24]=24,[491]=491,[26]=26,[20]=20},--Maggot
[132]={[478]=478},--Magical Crawdad
[136]={[479]=479},--Mana Wyrmling
[83]={[673]=673},--Mechanical Chicken
[215]={[492]=492},--Mechanopeep
[1156]={[766]=766},--Mini Mindslayer
[149]={[478]=478},--Miniwing
[165]={[781]=781},--Mojo
[633]={[490]=490,[81]=81,[495]=495,[40]=40,[281]=281},--Mountain Skunk
[385]={[34]=34,[141]=141,[490]=490,[9]=9,[479]=479,[39]=39,[40]=40},--Mouse
[164]={[481]=481},--Muckbreath
[210]={[492]=492},--Mulgore Hatchling
[557]={[121]=121},--Nether Faerie Dragon
[186]={[478]=478},--Nether Ray Fry
[638]={[479]=479},--Nether Roach
[1165]={[486]=486},--Nexus Whelpling
[236]={[510]=510},--Obsidian Hatchling
[530]={[486]=486},--Oily Slimeling
[43]={[30]=30},--Orange Tabby Cat
[1125]={[811]=811},--Pandaren Air Spirit
[1126]={[811]=811},--Pandaren Earth Spirit
[1124]={[811]=811},--Pandaren Fire Spirit
[868]={[811]=811},--Pandaren Water Spirit
[301]={[37]=37},--Panther Cub
[403]={[37]=37,[38]=38,[673]=673,[201]=201},--Parrot
[198]={[488]=488},--Pengu
[175]={[798]=798},--Phoenix Hatchling
[166]={[27]=27},--Pint-Sized Pink Pachyderm
[409]={[37]=37},--Polly
[386]={[16]=16,[9]=9,[477]=477,[11]=11,[301]=301,[39]=39},--Prairie Dog
[378]={[894]=894,[43]=43,[181]=181,[475]=475,[510]=510,[42]=42,[27]=27,[34]=34,[30]=30,[462]=462,[121]=121,[24]=24,[491]=491,[241]=241,[606]=606,[9]=9,[477]=477,[36]=36,[480]=480,[21]=21,[81]=81,[301]=301,[41]=41,[20]=20,[22]=22,[39]=39,[40]=40},--Rabbit
[472]={[181]=181,[605]=605,[81]=81,[281]=281},--Rabid Nut Varmint 5000
[417]={[894]=894,[461]=461,[16]=16,[43]=43,[181]=181,[476]=476,[510]=510,[42]=42,[101]=101,[27]=27,[463]=463,[545]=545,[611]=611,[24]=24,[491]=491,[35]=35,[477]=477,[684]=684,[481]=481,[21]=21,[81]=81,[301]=301,[38]=38,[478]=478,[673]=673,[26]=26,[544]=544,[20]=20},--Rat
[237]={[201]=201},--Ravasaur Hatchling
[238]={[40]=40},--Razormaw Hatchling
[239]={[37]=37,[673]=673},--Razzashi Hatchling
[143]={[462]=462},--Red Dragonhawk Hatchling
[139]={[479]=479},--Red Moth
[452]={[381]=381,[101]=101,[24]=24,[41]=41},--Red-Tailed Chipmunk
[392]={[36]=36},--Redridge Rat
[424]={[43]=43,[181]=181,[101]=101,[27]=27,[34]=34,[545]=545,[611]=611,[491]=491,[605]=605,[35]=35,[37]=37,[36]=36,[81]=81,[673]=673,[61]=61,[20]=20},--Roach
[471]={[181]=181,[605]=605,[321]=321,[281]=281},--Robo-Chick
[482]={[475]=475,[101]=101,[606]=606,[261]=261},--Rock Viper
[271]={[709]=709},--Rustberg Gull
[528]={[475]=475},--Scalded Basilisk Hatchling
[414]={[475]=475,[19]=19,[29]=29,[23]=23,[465]=465,[321]=321,[473]=473,[261]=261,[61]=61,[700]=700},--Scorpid
[340]={[823]=823},--Sea Pony
[172]={[795]=795},--Searing Scorchling
[218]={[492]=492},--Sen'jin Fetish
[51]={[673]=673},--Senegal
[229]={[492]=492},--Shimmering Wyrmling
[44]={[479]=479},--Siamese Cat
[144]={[462]=462},--Silver Dragonhawk Hatchling
[45]={[30]=30},--Silver Tabby Cat
[291]={[24]=24},--Singing Sunflower
[397]={[181]=181,[464]=464,[476]=476,[34]=34,[545]=545,[491]=491,[478]=478},--Skunk
[419]={[16]=16,[381]=381,[101]=101,[27]=27,[30]=30,[462]=462,[463]=463,[545]=545,[35]=35,[11]=11,[607]=607,[38]=38,[41]=41,[544]=544,[467]=467},--Small Frog
[90]={[721]=721},--Smolderweb Hatchling
[387]={[27]=27,[141]=141,[462]=462,[121]=121,[463]=463,[545]=545,[491]=491,[35]=35,[477]=477,[37]=37,[493]=493,[21]=21,[478]=478,[708]=708,[749]=749,[39]=39,[467]=467,[496]=496},--Snake
[173]={[481]=481},--Snarly
[440]={[27]=27},--Snow Cub
[72]={[27]=27},--Snowshoe Rabbit
[713]={[807]=807},--Softshell Snapling
[1183]={[930]=930},--Son of Animus
[1201]={[810]=810},--Spawn of G'nathus
[412]={[181]=181,[19]=19,[27]=27,[141]=141,[23]=23,[30]=30,[463]=463,[545]=545,[611]=611,[24]=24,[491]=491,[321]=321,[684]=684,[81]=81,[38]=38,[41]=41,[26]=26,[495]=495,[20]=20,[281]=281},--Spider
[515]={[467]=467},--Sporeling Sprout
[87]={[121]=121},--Sprite Darter Hatchling
[379]={[894]=894,[43]=43,[181]=181,[475]=475,[510]=510,[42]=42,[27]=27,[34]=34,[141]=141,[30]=30,[121]=121,[545]=545,[24]=24,[491]=491,[35]=35,[241]=241,[606]=606,[477]=477,[684]=684,[493]=493,[21]=21,[301]=301,[41]=41,[478]=478,[709]=709,[700]=700,[22]=22,[39]=39,[40]=40},--Squirrel
[1146]={[535]=535},--Stitched Pup
[675]={[30]=30},--Stormwind Rat
[401]={[43]=43,[488]=488,[27]=27,[545]=545,[605]=605,[37]=37,[38]=38,[673]=673,[544]=544},--Strand Crab
[211]={[301]=301,[321]=321},--Strand Crawler
[432]={[17]=17,[161]=161,[478]=478},--Stripe-Tailed Scorpid
[1158]={[121]=121},--Stunted Yeti
[679]={[809]=809},--Summit Kid
[1178]={[928]=928},--Sunreaver Micro-Sentry
[497]={[182]=182,[473]=473},--Tainted Cockroach
[499]={[182]=182},--Tainted Rat
[204]={[492]=492},--Teldrassil Sproutling
[650]={[807]=807},--Terrible Turnip
[287]={[29]=29},--Tiny Flamefly
[652]={[857]=857},--Tiny Goldfish
[389]={[39]=39},--Tiny Harvester
[279]={[640]=640},--Tiny Shale Spider
[167]={[467]=467},--Tiny Sporebat
[206]={[492]=492},--Tirisfal Batling
[420]={[43]=43,[27]=27,[4]=4,[141]=141,[462]=462,[182]=182,[463]=463,[545]=545,[24]=24,[491]=491,[477]=477,[321]=321,[684]=684,[21]=21,[38]=38,[41]=41,[700]=700,[40]=40},--Toad
[163]={[481]=481},--Toothy
[65]={[823]=823},--Tree Frog
[405]={[37]=37,[673]=673,[201]=201},--Tree Python
[536]={[486]=486,[488]=488},--Tundra Penguin
[55]={[479]=479},--Undercity Cockroach
[1151]={[755]=755},--Untamed Hatchling
[1154]={[766]=766},--Viscidus Globule
[418]={[4]=4,[37]=37,[321]=321,[38]=38,[700]=700,[40]=40},--Water Snake
[84]={[39]=39},--Westfall Chicken
[46]={[301]=301},--White Kitten
[141]={[471]=471},--White Moth
[306]={[281]=281},--Winterspring Cub
[220]={[42]=42},--Withers
[64]={[823]=823},--Wood Frog
[89]={[721]=721},--Worg Pup
[140]={[471]=471},--Yellow Moth
[1211]={[929]=929},--Zandalari Anklerender
[1212]={[929]=929},--Zandalari Footslasher
[1180]={[929]=929},--Zandalari Kneebiter
[1213]={[929]=929},--Zandalari Toenibbler
[724]={[809]=809},--Alpine Foxling
[725]={[809]=809},--Alpine Foxling Kit
[732]={[858]=858,[810]=810},--Amber Moth
[838]={[640]=640,[101]=101},--Amethyst Shale Hatchling
[716]={[857]=857},--Amethyst Spiderling
[1163]={[281]=281},--Anodized Robo Cub
[558]={[495]=495},--Arctic Fox Kit
[641]={[486]=486,[488]=488,[495]=495,[496]=496},--Arctic Hare
[216]={[492]=492},--Argent Gruntling
[632]={[606]=606,[201]=201},--Ash Lizard
[427]={[28]=28},--Ash Spiderling
[411]={[673]=673},--Baby Ape
[706]={[807]=807},--Bandicoon
[707]={[807]=807},--Bandicoon Kit
[626]={[23]=23,[606]=606,[20]=20},--Bat
[649]={[11]=11,[493]=493,[749]=749},--Biletoad
[374]={[30]=30},--Black Lamb
[455]={[21]=21},--Blighted Squirrel
[380]={[806]=806},--Bucktooth Flapper
[540]={[606]=606},--Carrion Rat
[459]={[16]=16,[30]=30,[462]=462,[611]=611,[479]=479,[480]=480},--Cat
[474]={[11]=11},--Cheetah Cub
[742]={[858]=858},--Clouded Hedgehog
[393]={[29]=29,[23]=23,[492]=492,[26]=26,[700]=700,[201]=201},--Cockroach
[562]={[806]=806},--Coral Adder
[488]={[81]=81},--Coral Snake
[507]={[41]=41},--Crested Owl
[559]={[640]=640},--Crimson Geode
[554]={[640]=640},--Crimson Shale Hatchling
[1068]={[823]=823},--Crow
[745]={[858]=858},--Crunchy Scorpion
[556]={[640]=640},--Crystal Beetle
[1062]={[823]=823},--Darkmoon Glowfly
[848]={[823]=823},--Darkmoon Rabbit
[508]={[42]=42},--Darkshore Cub
[755]={[606]=606},--Death's Head Cockroach
[555]={[640]=640},--Deepholm Cockroach
[484]={[101]=101,[261]=261,[161]=161,[720]=720},--Desert Spider
[523]={[491]=491},--Devouring Maggot
[504]={[201]=201},--Diemetradon Hatchling
[467]={[4]=4,[321]=321,[720]=720},--Dung Beetle
[1181]={[928]=928},--Elder Python
[1179]={[928]=928},--Electrified Razortooth
[479]={[381]=381,[101]=101,[606]=606,[41]=41},--Elfin Rabbit
[631]={[11]=11,[607]=607,[720]=720,[201]=201},--Emerald Boa
[1167]={[493]=493},--Emerald Proto-Whelp
[837]={[640]=640},--Emerald Shale Hatchling
[564]={[806]=806},--Emerald Turtle
[746]={[858]=858},--Emperor Crab
[447]={[30]=30,[490]=490,[41]=41},--Fawn
[457]={[23]=23},--Festering Maggot
[714]={[857]=857},--Feverbite Hatchling
[541]={[606]=606},--Fire-Proof Roach
[644]={[491]=491},--Fjord Rat
[529]={[491]=491},--Fjord Worg Pup
[514]={[465]=465},--Flayer Youngling
[395]={[36]=36},--Fledgling Buzzard
[521]={[479]=479},--Fledgling Nether Ray
[478]={[43]=43,[381]=381,[101]=101,[241]=241,[606]=606,[41]=41},--Forest Moth
[495]={[43]=43,[544]=544},--Frog
[756]={[640]=640},--Fungal Moth
[569]={[806]=806},--Garden Frog
[753]={[806]=806},--Garden Moth
[477]={[9]=9},--Gazelle Fawn
[748]={[811]=811},--Gilded Moth
[630]={[42]=42},--Gilnean Raven
[475]={[607]=607},--Giraffe Calf
[430]={[17]=17,[161]=161},--Gold Beetle
[733]={[810]=810},--Grassland Hopper
[443]={[16]=16},--Grasslands Cottontail
[464]={[464]=464},--Grey Moth
[647]={[490]=490,[700]=700},--Grizzly Squirrel
[539]={[606]=606},--Grotto Vole
[571]={[806]=806},--Grove Viper
[448]={[16]=16,[4]=4,[26]=26},--Hare
[1157]={[11]=11},--Harpy Youngling
[550]={[700]=700},--Highlands Mouse
[823]={[490]=490,[81]=81,[495]=495,[40]=40,[281]=281},--Highlands Skunk
[645]={[700]=700},--Highlands Turkey
[332]={[321]=321},--Horde Balloon
[851]={[17]=17,[261]=261},--Horned Lizard
[483]={[101]=101},--Horny Toad
[534]={[490]=490},--Imperial Eagle Chick
[1161]={[161]=161},--Infinite Whelpling
[792]={[301]=301,[321]=321},--Jade Crane Chick
[446]={[26]=26},--Jade Oozeling
[699]={[806]=806},--Jumping Spider
[565]={[806]=806},--Jungle Darter
[678]={[857]=857},--Jungle Grub
[438]={[17]=17},--King Snake
[680]={[810]=810},--Kuitan Mongoose
[461]={[463]=463,[535]=535},--Larva
[429]={[29]=29},--Lava Beetle
[545]={[720]=720},--Leopard Scorpid
[702]={[806]=806},--Leopard Tree Frog
[437]={[35]=35},--Little Black Ram
[543]={[720]=720},--Locust
[1159]={[24]=24},--Lofty Libram
[718]={[857]=857},--Luyu Moth
[542]={[720]=720},--Mac Frog
[708]={[807]=807},--Malayan Quillrat
[709]={[807]=807},--Malayan Quillrat Pup
[710]={[807]=807},--Marsh Fiddler
[570]={[806]=806},--Masked Tanuki
[703]={[806]=806},--Masked Tanuki Pup
[722]={[857]=857},--Mei Li Sparkler
[500]={[182]=182},--Minfernal
[566]={[806]=806},--Mirror Strider
[422]={[38]=38},--Moccasin
[428]={[28]=28},--Molten Hatchling
[737]={[810]=810},--Mongoose
[739]={[810]=810},--Mongoose Pup
[391]={[9]=9,[36]=36},--Mountain Cottontail
[547]={[606]=606},--Nordrassil Wisp
[544]={[720]=720},--Oasis Moth
[726]={[809]=809},--Plains Monitor
[727]={[809]=809},--Prairie Mouse
[513]={[261]=261},--Qiraji Guardling
[743]={[858]=858},--Rapana Whelk
[399]={[34]=34},--Rat Snake
[431]={[17]=17,[161]=161,[700]=700},--Rattlesnake
[465]={[476]=476},--Ravager Hatchling
[1042]={[807]=807},--Red Cricket
[744]={[858]=858},--Resilient Roach
[439]={[32]=32},--Restless Shadeling
[460]={[462]=462},--Ruby Sapling
[496]={[43]=43},--Rusty Snail
[491]={[161]=161},--Sand Kitten
[573]={[806]=806},--Sandy Petrel
[717]={[857]=857},--Savory Beetle
[512]={[261]=261},--Scarab Hatchling
[416]={[19]=19},--Scorpling
[538]={[492]=492},--Scourged Whelpling
[560]={[857]=857,[161]=161},--Sea Gull
[493]={[42]=42},--Shimmershell Snail
[388]={[181]=181,[486]=486,[491]=491,[857]=857,[700]=700,[39]=39},--Shore Crab
[629]={[321]=321},--Shore Crawler
[754]={[806]=806},--Shrine Fly
[677]={[807]=807},--Shy Bandicoon
[511]={[261]=261,[720]=720},--Sidewinder
[711]={[807]=807},--Sifang Otter
[712]={[807]=807},--Sifang Otter Pup
[741]={[858]=858},--Silent Hedgehog
[494]={[161]=161},--Silithid Hatchling
[568]={[806]=806},--Silkbead Snail
[503]={[241]=241,[606]=606,[201]=201},--Silky Moth
[637]={[475]=475},--Skittering Cavern Crawler
[640]={[24]=24},--Snowshoe Hare
[69]={[281]=281},--Snowy Owl
[489]={[141]=141},--Spawn of Onyxia
[1185]={[929]=929},--Spectral Porcupette
[433]={[17]=17,[261]=261},--Spiky Lizard
[466]={[4]=4,[321]=321},--Spiny Lizard
[723]={[857]=857},--Spiny Terrapin
[572]={[806]=806},--Spirebound Crab
[463]={[463]=463},--Spirit Crab
[502]={[201]=201},--Spotted Bell Frog
[492]={[161]=161},--Stinkbug
[485]={[101]=101},--Stone Armadillo
[553]={[640]=640},--Stowaway Rat
[532]={[493]=493},--Stunted Shardhorn
[1128]={[857]=857},--Sumprush Rodent
[1182]={[928]=928},--Swamp Croaker
[402]={[38]=38},--Swamp Moth
[728]={[809]=809},--Szechuan Chicken
[498]={[182]=182},--Tainted Moth
[567]={[806]=806},--Temple Snake
[802]={[301]=301,[321]=321},--Thundering Serpent Hatchling
[1175]={[928]=928},--Thundertail Flapper
[509]={[40]=40},--Tiny Bog Beast
[445]={[16]=16},--Tiny Twister
[546]={[720]=720},--Tol'vir Scarab
[729]={[809]=809},--Tolai Hare
[730]={[809]=809},--Tolai Hare Pup
[480]={[640]=640,[101]=101},--Topaz Shale Hatchling
[525]={[491]=491},--Turkey
[473]={[181]=181},--Turquoise Turtle
[469]={[181]=181,[640]=640,[606]=606},--Twilight Beetle
[552]={[700]=700},--Twilight Fiendling
[505]={[61]=61},--Twilight Iguana
[470]={[181]=181,[640]=640,[700]=700},--Twilight Spider
[454]={[20]=20},--Undercity Rat
[187]={[799]=799},--Vampiric Batling
[506]={[81]=81},--Venomspitter Hatchling
[1013]={[857]=857},--Wanderer's Festival Hatchling
[517]={[478]=478},--Warpstalker Hatchling
[535]={[496]=496},--Water Waveling
[410]={[673]=673,[709]=709},--Wharf Rat
[400]={[34]=34},--Widow Spiderling
[819]={[806]=806},--Wild Crimson Hatchling
[818]={[806]=806},--Wild Golden Hatchling
[817]={[806]=806},--Wild Jade Hatchling
[548]={[700]=700},--Wildhammer Gryphon Hatchling
[740]={[810]=810,[858]=858},--Yakrat
[752]={[811]=811},--Yellow-Bellied Bullfrog
[549]={[700]=700},--Yellow-Bellied Marmot
[731]={[809]=809},--Zooey Snake
[272]={[301]=301,[321]=321},--Armadillo Pup
[270]={[301]=301,[321]=321},--Dark Phoenix Hatchling
[320]={[301]=301,[321]=321},--Lil' Tarecgosa
[341]={[241]=241},--Lunar Lantern
[1232]={[780]=780},--Coilfang Stalker
[1205]={[929]=929},--Direhorn Runt
[1229]={[799]=799},--Fiendish Imp
[1237]={[4]=4},--Gahz'rooki
[282]={[301]=301,[321]=321},--Guild Herald
[283]={[301]=301,[321]=321},--Guild Herald
[280]={[301]=301,[321]=321},--Guild Page
[281]={[301]=301,[321]=321},--Guild Page
[1234]={[782]=782},--Lesser Voidcaller
[1226]={[799]=799},--Lil' Bad Wolf
[1243]={[930]=930},--Living Fluid
[1227]={[799]=799},--Menagerie Custodian
[1228]={[799]=799},--Netherspace Abyssal
[1235]={[782]=782},--Phoenix Hawk Hatchling
[1233]={[782]=782},--Pocket Reaver
[1200]={[930]=930},--Pygmy Direhorn
[1231]={[780]=780},--Tainted Waveling
[1230]={[780]=780},--Tideskipper
[1244]={[930]=930},--Viscous Horror
[1323]={[951]=951},--Ashleaf Spriteling
[1324]={[951]=951},--Ashwing Moth
[1321]={[951]=951},--Azure Crane Chick
[1322]={[953]=953},--Blackfuse Bombling
[1343]={[951]=951},--Bonkers
[1303]={[951]=951},--Chi-Chi, Hatchling of Chi-Ji
[1329]={[951]=951},--Dandelion Frolicker
[1330]={[951]=951},--Death Adder Hatchling
[1331]={[953]=953},--Droplet of Y'Shaarj
[1325]={[951]=951},--Flamering Moth
[1332]={[953]=953},--Gooey Sha-ling
[1345]={[951]=951},--Gu'chi Swarmling
[1338]={[951]=951},--Gulp Froglet
[1346]={[951]=951},--Harmonious Porcupette
[1348]={[951]=951},--Jadefire Spirit
[1333]={[951]=951},--Jademist Dancer
[1334]={[953]=953},--Kovok
[1276]={[823]=823},--Moon Moon
[1335]={[951]=951},--Ominous Flame
[1328]={[951]=951},--Ruby Droplet
[1336]={[951]=951},--Skunky Alemental
[1350]={[951]=951},--Sky Lantern
[1326]={[951]=951},--Skywisp Moth
[1337]={[951]=951},--Spineclaw Crab
[1238]={[510]=510,[493]=493,[490]=490,[492]=492,[488]=488,[486]=486,[491]=491,[495]=495},--Unborn Val'kyr
[1344]={[951]=951},--Vengeful Porcupette
[1304]={[951]=951},--Yu'la, Broodling of Yu'lon
}

