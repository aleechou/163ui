local mod = ExtraCD

function mod:GetDataVersion()
	return 55
end

function mod:GetSpellData() 
	return {
	
	-- talent
		-- type = "talent" 
		-- talent = the location of the talent(from 1 to 18)
		-- monk
		[121283] = {
			desc = "",
			type = "talent",
			class = "MONK",
			talent = 7,
			cd = 20,
		}, -- Power Strike
		[122281] = {
			desc = "",
			type = "talent",
			class = "MONK",
			talent = 13,
			cd = 15,
		}, -- Healing Elixirs
		-- shaman
		[31616] = {
			desc = "",
			type = "talent",
			class = "SHAMAN",
			talent = 1,
			cd = 30,
			duration = 10,
		}, -- Nature's Guardian
		
		-- mage
		[87023] = {
			desc = "",
			type = "talent",
			class = "MAGE",
			talent = 11,
			cd = 120,
			duration = 6,
		}, -- Cauterize
		
		-- rogue
		[45182] = {
			desc = "",
			type = "talent",
			class = "ROGUE",
			talent = 7,
			cd = 90,
			duration = 3,
		}, -- Cheated Death
		
		-- priest
		[114214] = {
			desc = "",
			type = "talent",
			class = "PRIEST",
			talent = 12,
			cd = 90,
		}, -- Angelic Bulwark
		
		-- dk
		[116888] = {
			desc = "",
			type = "talent",
			class = "DEATHKNIGHT",
			talent = 6,
			cd = 180,
			duration = 3,
		}, -- Purgatory	
		
	-- spec
		-- type = "spec" 
		-- spec = {the numbers of the spec(from 1 to 3(4 for druid))}
		-- druid
		[34299] = {
			desc = "",
			type = "spec",
			class = "DRUID",
			spec = {2, 3},
			cd = 6,
		}, -- Leader of the Pack
		
		-- hunter
		[56453] = {
			desc = "",
			type = "spec",
			class = "HUNTER",
			spec = {3},
			cd = 10,
		}, -- Lock and Load
		
		-- priest
		[47755] = {
			desc = "",
			type = "spec",
			class = "PRIEST",
			spec = {1},
			cd = 12,
		}, -- Rapture
		
		--dk
		[96171] = {
			desc = "",
			type = "spec",
			class = "DEATHKNIGHT",
			spec = {1},
			cd = 45,
			duration = 8,
		}, -- Will of the Necropolis	
		
		--warlock
		[104317] = {
			desc = "",
			type = "spec",
			class = "WARLOCK",
			spec = {2},
			cd = 20,
		}, --
		[34936] = {
			desc = "",
			type = "spec",
			class = "WARLOCK",
			spec = {3},
			cd = 8,
		}, --
		

		
	-- item
		-- type = "item" 
		-- item = {the item id}
		-- MOP 5.4
		-- Legendary cloak
		[148010] = {
			desc = "",
			type = "item",
			item = {102245, 102250},
			cd = 120,
		}, -- Qian-Le, Courage of Niuzao & Qian-Ying, Fortitude of Niuzao
		[146198] = {
			desc = "",
			type = "item",
			item = {102246},
			cd = 0,
			ppm = {
				MAGE = {3.26, 3.13, 3.13},
				WARLOCK = {2.87, 3.26, 3},
				SHAMAN = {2.74, 2.61, 2.61},
				DRUID = {2.87, 2.61, 2.61, 2.61},
				PRIEST = {2.61, 2.61, 2.61},
				OTHER = 2.61,
				BASE = 1
			}, 
			modifier = 'haste',
			duration = 4,
		}, -- Xing-Ho, Breath of Yu'lon
		[146194] = {
			desc = "",
			type = "item",
			item = {102248, 102249},
			cd = 0,
			ppm = {
				ROGUE = {2.70, 2, 1.74},
				SHAMAN = {1.74,2.70, 1.74},
				DRUID = {1.74, 2.26, 1.04, 1.74},
				DEATHKNIGHT = {1.04, 2.61, 1.83},
				HUNTER = {1.74, 2.09, 2},
				WARRIOR = {2.35, 1.83, 1.04},
				MONK = {1.04, 2.09, 1.74},
				PALADIN = {1.74, 1.04, 2.52},
				OTHER = 1.74,
				BASE = 1
			}, 
			modifier = 'haste',
			duration = 3,
		}, -- Fen-Yu, Fury of Xuen & Gong-Lu, Strength of Xuen
		[146200] = {
			desc = "",
			type = "item",
			item = {102247},
			cd = 0,
			ppm = {
				SHAMAN = {0.58, 0.58, 0.41},
				DRUID = {0.58, 0.58, 0.58, 0.46},
				PRIEST = {0.81, 0.58, 0.58},
				MONK = {0.58, 0.58, 0.46},
				PALADIN = {0.64, 0.58, 0.58},
				OTHER = 0.58,
				BASE = 1
			}, 
			duration = 10,
		}, -- Jina-Kang, Kindness of Chi-Ji
		
		-- SoO WH(Warforged Heroic)/ H/ WN/ N/ F(Flexible)/ LFR  
		[148911] = {
			desc = "",
			type = "item",
			item = {105607, 104611, 105358, 102304, 104860, 105109},
			cd = 115,
			duration = 20,
		}, -- Thok's Acid-Grooved Tooth
		[146250] = {
			desc = "",
			type = "item",
			item = {105609, 104613, 105360, 102305, 104862, 105111},
			cd = 115,
			duration = 20,
		}, -- Thok's Tail Tip
		[146046] = {
			desc = "",
			type = "item",
			item = {105422, 104426, 105173, 102293, 104675, 104924},
			cd = 115,
			duration = 20,
		}, -- Purified Bindings of Immerseus
		[146308] = {
			desc = "",
			type = "item",
			item = {105472, 104476, 105223, 102292, 104725, 104974},
			cd = 115,
			duration = 20,
		}, -- Assurance of Consequence
		[146314] = {
			desc = "",
			type = "item",
			item = {105474, 104478, 105225, 102299, 104727, 104976},
			cd = 115,
			duration = 20,
		}, -- Prismatic Prison of Pride
		[146245] = {
			desc = "",
			type = "item",
			item = {105491, 104495, 105242, 102298, 104744, 104993},
			cd = 55,
			duration = 10,
		}, -- Evil Eye of Galakras
		[148903] = {
			desc = "",
			type = "item",
			item = {105527, 104531, 105278, 102301, 104780, 105029},
			cd = 0,
			ppm = 0.92,
			duration = 10,
		}, -- Haromm's Talisman
		[148906] = {
			desc = "",
			type = "item",
			item = {105540, 104544, 105291, 102300, 104793, 105042},
			cd = 0,
			ppm = 0.92,
			duration = 10,
		}, -- Kardris' Toxic Totem
		[148908] = {
			desc = "",
			type = "item",
			item = {105549, 104553, 105300, 102294, 104802, 105051},
			cd = 0,
			ppm = 0.92,
			duration = 10,
		}, -- Nazgrim's Burnished Insignia
		[148897] = {
			desc = "",
			type = "item",
			item = {105572, 104576, 105323, 102303, 104825, 105074},
			cd = 85,
			duration = 15,
		}, -- Frenzied Crystal of Rage
		[148896] = {
			desc = "",
			type = "item",
			item = {105580, 104584, 105331, 102302, 104833, 105082},
			cd = 85,
			duration = 15,
		}, -- Sigil of Rampage
		[146310] = {
			desc = "",
			type = "item",
			item = {105612, 104616, 105363, 102311, 104865, 105114},
			cd = 0,
			ppm = 1,
			duration = 10,
		}, -- Ticking Ebon Detonator
		[146317] = {
			desc = "",
			type = "item",
			item = {105615, 104619, 105366, 102309, 104868, 105117},
			cd = 0,
			ppm = 0.92,
			modifier = 'haste',
			duration = 10,
		}, -- Dysmorphic Samophlange of Discontinuity
		[146285] = {
			desc = "",
			type = "item",
			item = {105632, 104636, 105383, 102308, 104885, 105134},
			cd = 0,
			ppm = 0.92,
			duration = 10,
		}, -- Skeer's Bloodsoaked Talisman
		[146184] = {
			desc = "",
			type = "item",
			item = {105648, 104652, 105399, 102310, 104901, 105150},
			cd = 0,
			ppm = 0.92,
			duration = 10,
		}, -- Black Blood of Y'Shaarj
		[148899] = {
			desc = "",
			type = "item",
			item = {105459, 104463, 105210, 102295, 104712, 104961},
			cd = 85,
			duration = 15,
		}, -- Fusion-Fire Core
		
		-- Timeless series 535 & 496 
		[146218] = {
			desc = "",
			type = "item",
			item = {103987, 103687},
			cd = 115,
			duration = 20,
		}, -- Yu'lon's Bite
		[146296] = {
			desc = "",
			type = "item",
			item = {103989, 103689},
			cd = 115,
			duration = 20,
		}, -- Alacrity of Xuen
		[146312] = {
			desc = "",
			type = "item",
			item = {103986, 103686},
			cd = 115,
			duration = 20,
		}, -- Discipline of Xuen
				
		
			
		-- MOP 5.2
		-- TH(Thunderforged Heroic)/ H/ TN/ N/ LFR Raid
		[138756] = {
			desc = "",
			type = "item",
			item = {96741,96369,95997,94512,95625},
			cd = 10,
			ppm = 1.21,
			duration = 10,
		}, -- Renataki's Soul Charm
		[138856] = {
			desc = "",
			type = "item",
			item = {96757,96385,96013,94514,95641},
			cd = 0,
			ppm = 0.96,
			modifier = 'haste',
			duration = 10,
		}, -- Horridon's Last Gasp
		[138938] = {
			desc = "",
			type = "item",
			item = {96781,96409,96037,94523,95665},
			cd = 0,
			ppm = 1.1,
			duration = 10,
		}, -- Bad Juju
		[138786] = {
			desc = "",
			type = "item",
			item = {96785,96413,96041,94513,95669},
			cd = 10,
			ppm = 1.21,
			duration = 10,
		}, -- Wushoolay's Final Choice
		[138898] = {
			desc = "",
			type = "item",
			item = {96827,96455,96083,94521,95711},
			cd = 0,
			ppm = 1.1,
			duration = 10,
		}, -- Breath of the Hydra
		[140380] = {
			desc = "",
			type = "item",
			item = {96828,96456,96084,94520,95712},
			cd = 17,
		}, -- Inscribed Bag of Hydra-Spawn
		
		[138759] = {
			desc = "",
			type = "item",
			item = {96842,96470,96098,94515,95726},
			cd = 10,
			ppm = 1.21,
			duration = 10,
		}, -- Fabled Feather of Ji-Kun
		
		[138895] = {
			desc = "",
			type = "item",
			item = {96864,96492,96120,94522,95748},
			cd = 0,
			ppm = 3.5,
			duration = 10,
		}, -- Talisman of Bloodlust
		
		[138973] = {
			desc = "",
			type = "item",
			item = {96843,96471,96099,94527,95727},
			cd = 30,
		}, -- Ji-Kun's Rising Winds
		
		[138870] = {
			desc = "",
			type = "item",
			item = {96873,96501,96129,94519,95757},
			cd = 0,
			ppm = 3.5,
			duration = 10,
		}, -- Primordius' Talisman of Rage
		
		-- this ones' rppm are differs by spec or based on critical chance, temporarily set their duration only 
		-----------------------------------------------
		[139133] = {
			desc = "",
			type = "item",
			item = {96888,96516,96144,94531,95772},
			cd = 0,
			ppm = 0.85,
			modifier = 'crit',
			duration = 10,
		}, -- Cha-Ye's Essence of Brilliance		
		[139170] = {
			desc = "",
			type = "item",
			item = {96915,96543,96171,94529,95799},
			cd = 0,
			ppm = 0.72,
			modifier = 'crit',
			duration = 20,
		}, -- Gaze of the Twins		
		[138963] = {
			desc = "",
			type = "item",
			item = {96930,96558,96186,94524,95814},
			cd = 0,
			duration = 4,
		}, -- Unerring Vision of Lei-Shen
		[139120] = {
			desc = "",
			type = "item",
			item = {96918,96546,96174,94532,95802},
			cd = 10,
			duration = 10,
		}, -- Rune of Re-Origination
		[139117] = {
			desc = "",
			type = "item",
			item = {96918,96546,96174,94532,95802},
			cd = 10,
			duration = 10,
		}, -- Rune of Re-Origination
		[139121] = {
			desc = "",
			type = "item",
			item = {96918,96546,96174,94532,95802},
			cd = 10,
			duration = 10,
		}, -- Rune of Re-Origination
		------------------------------------------------
		--  522 Valor Point
		[138703] = {
			desc = "",
			type = "item",
			item = {94510},
			cd = 45,
			duration = 10,
		}, -- Volatile Talisman of the Shado-Pan Assault
		[138702] = {
			desc = "",
			type = "item",
			item = {94508},
			cd = 75,
			duration = 15,
		}, -- Brutal Talisman of the Shado-Pan Assault
		[138699] = {
			desc = "",
			type = "item",
			item = {94511},
			cd = 105,
			duration = 20,
		}, -- Vicious Talisman of the Shado-Pan Assault			
		
		-- MOP 5.0
		-- 509 496 483 Raid
		[126646] = {
			desc = "",
			type = "item",
			item = {87160,86323,86881},
			cd = 105,
			duration = 20,
		}, -- Stuff of Nightmares
		[126640] = {
			desc = "",
			type = "item",
			item = {87163,86327,86885},
			cd = 105,
			duration = 20,
		},
		[126649] = {
			desc = "",
			type = "item",
			item = {87167,86332,86890},
			cd = 105,
			duration = 20,
		},
		[126657] = {
			desc = "",
			type = "item",
			item = {87172,86336,86894},
			cd = 105,
			duration = 20,
		}, -- H
		[126659] = {
			desc = "",
			type = "item",
			item = {87175,86388,86907},
			cd = 105,
			duration = 20,
		}, -- H
		
		-- 502 489 476 Raid
		[126554] = {
			desc = "",
			type = "item",
			item = {87057,86132,86791},
			cd = 45,
			duration = 20,
		}, -- H
		[126533] = {
			desc = "",
			type = "item",
			item = {87063,86131,86790},
			cd = 45,
			duration = 20,
		}, -- H
		[126577] = {
			desc = "",
			type = "item",
			item = {87065,86133,86792},
			cd = 45,
			duration = 20,
		}, -- H
		[126582] = {
			desc = "",
			type = "item",
			item = {87072,86144,86802},
			cd = 45,
			duration = 20,
		}, -- H
		[126588] = {
			desc = "",
			type = "item",
			item = {87075,86147,86805},
			cd = 45,
			duration = 20,
		}, -- H
		
		-- pvp 522(H/L set) 496(H/L set) 496(H/L) 483 476 458
		[126707] = {
			desc = "",
			type = "item",
			item = {100586,100200,100026,99777,94356,91104,84935,91457,84349},
			cd = 50,
			duration = 20,
		}, -- AGI
		[126705] = {
			desc = "",
			type = "item",
			item = {100712,100491,100152,99938,94482,91401,84941,91754,84489},
			cd = 50,
			duration = 20,
		}, -- SP
		[126700] = {
			desc = "",
			type = "item",
			item = {100505,100645,100085,99948,94415,91415,84937,91768,84495},
			cd = 50,
			duration = 20,
		}, -- STR
		
		-- Darkmoon Card 476
		[128985] = {
			desc = "",
			type = "item",
			item = {79331},
			cd = 50,
			duration = 15,
		}, -- Relic of Yu'lon
		[128986] = {
			desc = "",
			type = "item",
			item = {79327},
			cd = 45,
			duration = 15,
		}, -- Relic of Xuen STR
		[128984] = {
			desc = "",
			type = "item",
			item = {79328},
			cd = 55,
			duration = 15,
		}, -- Relic of Xuen AGI
		[128987] = {
			desc = "",
			type = "item",
			item = {79330},
			cd = 45,
			duration = 20,
		}, -- Relic of Chi Ji
		
		-- 470 
		[127923] = {
			desc = "",
			type = "item",
			item = {87572},
			cd = 45,
			duration = 10,
		}, -- Mithril Wristwatch
		[127928] = {
			desc = "",
			type = "item",
			item = {87574},
			cd = 45,
			duration = 10,
		}, -- Coren's Cold Chromium Coaster		
		[127915] = {
			desc = "",
			type = "item",
			item = {87573},
			cd = 45,
			duration = 10,
		}, -- Thousand-Year Pickled Egg
		
		-- 463 Heroic
		[126489] = {
			desc = "",
			type = "item",
			item = {81267},
			cd = 85,
			duration = 25,
		}, -- Searing Words
		[126483] = {
			desc = "",
			type = "item",
			item = {81125},
			cd = 65,
			duration = 20,
		}, -- Windswept Pages		
		[126236] = {
			desc = "",
			type = "item",
			item = {81243},
			cd = 50,
			duration = 15,
		}, -- Iron Protector Talisman
		[126266] = {
			desc = "",
			type = "item",
			item = {81133},
			cd = 30,
			duration = 10,
		}, -- Empty Fruit Barrel
		[126476] = {
			desc = "",
			type = "item",
			item = {81192},
			cd = 105,
			duration = 30,
		}, -- Vision of the Predator
		[126513] = {
			desc = "",
			type = "item",
			item = {81138},
			cd = 105,
			duration = 30,
		}, -- Carbonic Carbuncle		
		[126483] = {
			desc = "",
			type = "item",
			item = {81125},
			cd = 65,
			duration = 20,
		}, -- Windswept Pages
		[126489] = {
			desc = "",
			type = "item",
			item = {81267},
			cd = 85,
			duration = 25,
		}, -- Searing Words
		
		-- 450 and others
		[60234] = {
			desc = "",
			type = "item",
			item = {75274},
			cd = 55,
			duration = 15,
		}, -- Zen Alchemist Stone(Intellect)
		[60233] = {
			desc = "",
			type = "item",
			item = {75274},
			cd = 55,
			duration = 15,
		}, -- Zen Alchemist Stone(Agility)
		[60229] = {
			desc = "",
			type = "item",
			item = {75274},
			cd = 55,
			duration = 15,
		}, -- Zen Alchemist Stone(Strength)
	
	-- item set
		-- type = "itemset"
		-- items = {all items of this set(including all difficulties)}
		-- piece = the minimum pieces of the item set to get the bonus
		
		
		[102545] = {
			type = "itemset",
			class = "DRUID",
			items = {84377,84378,84379,84380,84381,84901,84832,84852,84871,84916,94367,94368,94455,94456,94457,91157,91159,91161,91163,91165},
			piece = 4,
			cd = 30,
		}, -- Feral PVP 4P
		

	-- enchant
		-- type = "enchant",
		-- slot = 16 main hand(two hand have the same enchant may cause mistakes), 15 cloak  
		-- enchant = {enchant Id}
		-- Cataclysm
		[74241] = {
			type = "enchant",
			enchant = {4097},
			slot = 16,
			cd = 45,
			duration = 12
		}, -- Power Torrent
		[99621] = {
			type = "enchant",
			enchant = {4267},
			slot = 16,
			cd = 40,
			duration = 10
		}, -- Flintlocke's Woodchucker
		[74221] = {
			type = "enchant",
			enchant = {4083},
			slot = 16,
			cd = 45,
			duration = 12
		}, -- Hurricane
		[74224] = {
			type = "enchant",
			enchant = {4084},
			slot = 16,
			cd = 20,
			duration = 15
		}, -- Heartsong
		[59626] = {
			type = "enchant",
			enchant = {3790},
			slot = 16,
			cd = 35,
			duration = 10
		}, -- Black Magic
		
		-- MOP
		[125488] = {
			desc = "",
			type = "enchant",
			enchant = {4893, 4116, 3728},
			slot = 15,
			cd = 60,
			duration = 15
		},	-- Darkglow Embroidery
		[125489] = {
			desc = "",
			type = "enchant",
			enchant = {4894, 3730, 4118},
			slot = 15,
			cd = 60,
			duration = 15
		}, -- Swordguard Embroidery
		[125487] = {
			desc = "",
			type = "enchant",
			enchant = {4892, 3722, 4115},
			slot = 15,
			cd = 55,
			duration = 15
		}, -- Lightweave Embroidery
		[104993] = {
			desc = "",
			type = "enchant",
			enchant = {4442},
			slot = 16,
			ppm = 2.2,
			duration = 12,
			cd = 0
		}, -- Jade Spirit
		[142535] = {
			desc = "",
			type = "enchant",
			enchant = {5124},
			slot = 16,
			ppm = 2.2,
			duration = 12,
			cd = 0
		}, -- Spirit of Conquest
		[120032] = {
			desc = "",
			type = "enchant",
			enchant = {4444},
			slot = 16,
			ppm = 2.53,
			duration = 12,
			cd = 0
		}, -- Steel Dancing
		[142530] = {
			desc = "",
			type = "enchant",
			enchant = {5125},
			slot = 16,
			ppm = 2.53,
			duration = 12,
			cd = 0
		}, -- Bloody Dancing Steel
		[116660] = {
			desc = "",
			type = "enchant",
			enchant = {4446},
			slot = 16,
			ppm = 3.67,
			modifier = 'haste',
			duration = 7,
			cd = 0
		}, -- River's Song
		
		
		
		-- meta gems
		-- type = "gem",
		-- slot = 1 (head)  
		-- gem = {gem Id}
		[137593] = {
			type = "gem",
			gem = {5030},
			slot = 1,
			cd = 0,
			duration = 15,
			ppm = 2.57
		}, -- Indomitable Primal Diamond
		[137590] = {
			type = "gem",
			gem = {5033},
			slot = 1,
			cd = 0,
			duration = 10,
			ppm = {
				MAGE = {0.761, 0.302, 1.387},
				WARLOCK = {0.625, 0.598, 0.509},
				SHAMAN = {1.891, 1, 1},
				DRUID = {1.872, 1, 1, 1},
				PRIEST = {1, 1, 0.933},
				OTHER = 1,
				BASE = 1.35
			}
		}, -- Sinister Primal Diamond
		[137331] = {
			type = "gem",
			gem = {5031},
			slot = 1,
			cd = 0,
			class = "MONK",
			duration = 4,
			ppm = 1.61
		}, -- Courageous Primal Diamond -- Monk
		[137247] = {
			type = "gem",
			gem = {5031},
			slot = 1,
			cd = 0,
			class = "DRUID",
			duration = 4,
			ppm = 1.61
		}, -- Courageous Primal Diamond -- Druid
		[137288] = {
			type = "gem",
			gem = {5031},
			slot = 1,
			cd = 0,
			class = "PALADIN",
			duration = 4,
			ppm = 1.61
		}, -- Courageous Primal Diamond -- Paladin
		[137323] = {
			type = "gem",
			gem = {5031},
			slot = 1,
			cd = 0,
			class = "PRIEST",
			duration = 4,
			ppm = 1.61
		}, -- Courageous Primal Diamond -- Priest
		[137326] = {
			type = "gem",
			gem = {5031},
			slot = 1,
			cd = 0,
			class = "SHAMAN",
			duration = 4,
			ppm = 1.61
		}, -- Courageous Primal Diamond -- Shaman
	}
end
