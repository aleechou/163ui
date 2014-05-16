-- $Id: mistsofpandaria.lua 4283 2014-02-16 00:13:49Z Dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleRare = AtlasLoot_GetLocaleLibBabble("LibBabble-Rare-3.0")
local moduleName = "AtlasLootMoP"

-- Index
--- Dungeons & Raids
---- Temple of the Jade Serpent
---- Stormstout Brewery
---- Mogu'Shan Palace
---- Shado-pan Monastery
---- Gate of the Setting Sun
---- Siege of Niuzao Temple
---- Scholomance
---- Scarlet Halls
---- Scarlet Monastery
---- Heart of Fear
---- Mogu'Shan Vaults
---- Pandaria World Bosses
---- Siege of Orgrimmar
---- Terrace of Endless Spring
---- Throne of Thunder
--- Rare Mobs
---- The Jade Forest
---- Valley of the Four Winds
---- Krasarang Wilds
---- Kun-Lai Summit
---- Townlong Steppes
---- Dread Wastes
---- Vale of Eternal Blossoms
---- Misc
---- Clawlord Kril'mandar
--- Rare Items
---- The Jade Forest
---- Valley of the Four Winds
---- Krasarang Wilds
---- Kun-Lai Summit
---- Townlong Steppes
---- Dread Wastes
--- Factions
---- The Anglers
---- The August Celestials
---- Bizmo's Brawlpub / Brawl'gar Arena
---- Dominance Offensive
---- Emperor Shaohao
---- Golden Lotus
---- Kirin Tor Offensive
---- The Klaxxi
---- The Lorewalkers
---- Operation: Shieldwall
---- Order of the Cloud Serpent
---- Shado-Pan
---- Shado-Pan Assault
---- Sunreaver Onslaught
---- The Tillers
---- Domination Point
---- Lion's Landing
--- PvP
---- PvP Armor Sets
---- Level 90 - Accessories
---- Level 90 - Non Set Epics
---- Level 90 - Weapons
--- Sets & Collections
---- Challenge Mode Armor Sets
---- Tier 14 Sets (T14)
---- Tier 15 Sets (T15)
---- Tier 16 Sets (T16)
---- Trading Card Game Items
---- Companions
---- Mounts
---- Tabards
---- Transformation Items
---- Legendaries
---- Heirloom Items
---- BoE World Epics
---- Justice Points Items
---- Valor Points Items
---- Timeless Isle

	------------------------
	--- Dungeons & Raids ---
	------------------------

		------------------------------
		--- Temple of Jade Serpent ---
		------------------------------

	AtlasLoot_Data["TJSMari"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80862, "", "=q3=Treads of Corrupted Water", "=ds=#s12#, #a2#", "", "33%"},
				{ 3, 80860, "", "=q3=Waterburst Helm", "=ds=#s1#, #a3#", "", "33%" },
				{ 4, 80861, "", "=q3=Riverbed Chestguard", "=ds=#s5#, #a4#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6460#"};
				{ 17, 81123, "", "=q3=Wind-Soaked Drape", "=ds=#s4#", "", "20%" },
				{ 18, 81072, "", "=q3=Treads of Corrupted Water", "=ds=#s12#, #a2#", "", "20%" },
				{ 19, 81075, "", "=q3=Waterburst Helm", "=ds=#s1#, #a3#", "", "20%" },
				{ 20, 81083, "", "=q3=Riverbed Chestguard", "=ds=#s5#, #a4#", "", "20%" },
				{ 21, 81124, "", "=q3=Crystallized Droplet", "=ds=#s13#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Wise Mari", 672),
			module = moduleName, instance = "TempleOfTheJadeSerpent",
		};
	};

	AtlasLoot_Data["TJSStonestep"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80864, "", "=q3=Girdle of Endemic Anger", "=ds=#s10#, #a1#", "", "33%" },
				{ 3, 80865, "", "=q3=Sunheart Waistband", "=ds=#s10#, #a3#", "", "33%" },
				{ 4, 80863, "", "=q3=Stonestep Boots", "=ds=#s12#, #a4#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81058, "", "=q3=Girdle of Endemic Anger", "=ds=#s10#, #a1#", "", "20%" },
				{ 18, 81126, "", "=q3=Leggings of Whispered Dreams", "=ds=#s11#, #a2#", "", "20%" },
				{ 19, 81060, "", "=q3=Sunheart Waistband", "=ds=#s10#, #a3#", "", "20%" },
				{ 20, 81073, "", "=q3=Stonestep Boots", "=ds=#s12#, #a4#", "", "20%" },
				{ 21, 81125, "", "=q3=Windswept Pages", "=ds=#s14#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lorewalker Stonestep", 664),
			module = moduleName, instance = "TempleOfTheJadeSerpent",
		};
	};

	AtlasLoot_Data["TJSFlameheart"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80866, "", "=q3=Cape of Entanglement", "=ds=#s4#", "", "33%" },
				{ 3, 80867, "", "=q3=Serpentstrike Shoulderpads", "=ds=#s3#, #a4#", "", "33%" },
				{ 4, 80872, "", "=q3=Firebelcher Hand Cannon", "=ds=#w5#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81084, "", "=q3=Cape of Entanglement", "=ds=#s4#", "", "20%" },
				{ 18, 81127, "", "=q3=Flameheart Sandals", "=ds=#s12#, #a1#", "", "20%" },
				{ 19, 81070, "", "=q3=Serpentstrike Shoulderpads", "=ds=#s3#, #a4#", "", "20%" },
				{ 20, 81128, "", "=q3=Signet of Dancing Jade", "=ds=#s13#", "", "20%" },
				{ 21, 81067, "", "=q3=Firebelcher Hand Cannon", "=ds=#w5#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Liu Flameheart", 658),
			module = moduleName, instance = "TempleOfTheJadeSerpent",
		};
	};

	AtlasLoot_Data["TJSShaDoubt"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80868, "", "=q3=Doubtridden Shoulderguards", "=ds=#s3#, #a2#", "", "33%" },
				{ 3, 80870, "", "=q3=Chestguard of Despair", "=ds=#s5#, #a2#", "", "33%" },
				{ 4, 80871, "", "=q3=Neverdare Shoulders", "=ds=#s3#, #a3#", "", "33%" },
				{ 5, 80869, "", "=q3=Hopecrusher Gauntlets", "=ds=#s9#, #a3#", "", "33%" },
				{ 6, 80873, "", "=q3=Dubious Handaxe", "=ds=#h1#, #w1#", "", "33%" },
				{ 7, 80874, "", "=q3=Staff of Trembling Will", "=ds=#w9#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6475# / #ACHIEVEMENTID:6671#"}; --- 2nd achievemnt isn't showing up..
				{ 17, 87544, "", "=q4=Je'lyu, Spirit of the Serpent", "=ds=#h1#, #w6#", "", "1%" },
				{ 18, 81129, "", "=q3=Cloak of Failing Will", "=ds=#s4#", "", "20%" },
				{ 19, 81132, "", "=q3=Paralyzing Gloves", "=ds=#s9#, #a1#", "", "20%" },
				{ 20, 81071, "", "=q3=Doubtridden Shoulderguards", "=ds=#s3#, #a2#", "", "20%" },
				{ 21, 81082, "", "=q3=Chestguard of Despair", "=ds=#s5#, #a2#", "", "20%" },
				{ 22, 81069, "", "=q3=Neverdare Shoulders", "=ds=#s3#, #a3#", "", "20%" },
				{ 23, 81074, "", "=q3=Hopecrusher Gauntlets", "=ds=#s9#, #a3#", "", "20%" },
				{ 24, 81130, "", "=q3=Binding of Broken Dreams", "=ds=#s10#, #a4#", "", "20%" },
				{ 25, 81131, "", "=q3=Mindbreaker Pendant", "=ds=#s2#", "", "20%" },
				{ 26, 81063, "", "=q3=Dubious Handaxe", "=ds=#h1#, #w1#", "", "20%" },
				{ 27, 81079, "", "=q3=Staff of Trembling Will", "=ds=#w9#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sha of Doubt", 335),
			module = moduleName, instance = "TempleOfTheJadeSerpent",
		};
	};

		--------------------------
		--- Stormstout Brewery ---
		--------------------------

	AtlasLoot_Data["BreweryOokOok"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80897, "", "=q3=Bracers of Displaced Air", "=ds=#s8#, #a1#", "", "33%"};
				{ 3, 80896, "", "=q3=Nimbletoe Chestguard", "=ds=#s5#, #a2#", "", "33%"};
				{ 4, 80892, "", "=q3=Ook's Hozen Slicer", "=ds=#h1#, #w10#", "", "33%"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6089#"};
				{ 17, 81064, "", "=q3=Bracers of Displaced Air", "=ds=#s8#, #a1#", "", "20%"};
				{ 18, 81080, "", "=q3=Nimbletoe Chestguard", "=ds=#s5#, #a2#", "", "20%"};
				{ 19, 81134, "", "=q3=Barreldodger Boots", "=ds=#s12#, #a4#", "", "20%"};
				{ 20, 81133, "", "=q3=Empty Fruit Barrel", "=ds=#s14#", "", "20%"};
				{ 21, 81061, "", "=q3=Ook's Hozen Slicer", "=ds=#h1#, #w10#", "", "20%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ook-Ook", 668),
			module = moduleName, instance = "StormstoutBrewery",
		};
	};

	AtlasLoot_Data["BreweryHoptallus"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80898, "", "=q3=Hopping Mad Leggings", "=ds=#s11#, #a3#", "", "33%"};
				{ 3, 80899, "", "=q3=Bubble-Breaker Bracers", "=ds=#s8#, #a4#", "", "33%"};
				{ 4, 80893, "", "=q3=Bottle of Potent Potables", "=ds=#s15#", "", "33%"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81136, "", "=q3=Cloak of Hidden Flasks", "=ds=#s4#", "", "20%"};
				{ 18, 81135, "", "=q3=Belt of Brazen Inebriation", "=ds=#s10#, #a2#", "", "20%"};
				{ 19, 81077, "", "=q3=Hopping Mad Leggings", "=ds=#s11#, #a3#", "", "20%"};
				{ 20, 81065, "", "=q3=Bubble-Breaker Bracers", "=ds=#s8#, #a4#", "", "20%"};
				{ 21, 81076, "", "=q3=Bottle of Potent Potables", "=ds=#s15#", "", "20%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Hoptallus", 669),
			module = moduleName, instance = "StormstoutBrewery",
		};
	};

	AtlasLoot_Data["BreweryYanZhu"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80903, "", "=q3=Fermenting Belt", "=ds=#s10#, #a1#", "", "33%"};
				{ 3, 80900, "", "=q3=Fizzy Spaulders", "=ds=#s3#, #a2#", "", "33%"};
				{ 4, 80902, "", "=q3=Uncasked Chestguard", "=ds=#s5#, #a3#", "", "33%"};
				{ 5, 80901, "", "=q3=Sudsy Legplates", "=ds=#s11#, #a4#", "", "33%"};
				{ 6, 80894, "", "=q3=Gao's Keg Tapper", "=ds=#h1#, #w6#", "", "33%"};
				{ 7, 80895, "", "=q3=Yan-Zhu's Pressure Valve", "=ds=#w5#", "", "33%"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 87545, "", "=q4=Inelava, Spirit of Inebriation", "=ds=#h1#, #w1#", "", "1%"};
				{ 18, 81059, "", "=q3=Fermenting Belt", "=ds=#s10#, #a1#", "", "20%"};
				{ 19, 81068, "", "=q3=Fizzy Spaulders", "=ds=#s3#, #a2#", "", "20%"};
				{ 20, 81081, "", "=q3=Uncasked Chestguard", "=ds=#s5#, #a3#", "", "20%"};
				{ 21, 81078, "", "=q3=Sudsy Legplates", "=ds=#s11#, #a4#", "", "20%"};
				{ 22, 81141, "", "=q3=Alemental Seal", "=ds=#s13#", "", "20%"};
				{ 23, 81139, "", "=q3=Lime-Rimmed Signet", "=ds=#s13#", "", "20%"};
				{ 24, 81138, "", "=q3=Carbonic Carbuncle", "=ds=#s14#", "", "20%"};
				{ 25, 81062, "", "=q3=Gao's Keg Tapper", "=ds=#h1#, #w6#", "", "20%"};
				{ 26, 81140, "", "=q3=Wort Sitrring Rod", "=ds=#w9#", "", "20%"};
				{ 27, 81066, "", "=q3=Yan-Zhu's Pressure Valve", "=ds=#w5#", "", "20%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Yan-Zhu the Uncasked", 670),
			module = moduleName, instance = "StormstoutBrewery",
		};
	};

		------------------------
		--- Mogu'Shan Palace ---
		------------------------

	AtlasLoot_Data["MoguShanTrialKing"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 85178, "", "=q3=Conflagrating Gloves", "=ds=#s9#, #a1#", "", "20%" },
				{ 3, 85176, "", "=q3=Hurricane Belt", "=ds=#s10#, #a2#", "", "20%" },
				{ 4, 85175, "", "=q3=Crest of the Clan Lords", "=ds=#s1#, #a3#", "", "20%" },
				{ 5, 85179, "", "=q3=Meteoric Greathelm", "=ds=#s1#, #a4#", "", "20%" },
				{ 6, 85177, "", "=q3=Whirling Dervish Choker", "=ds=#s2#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81240, "", "=q3=Conflagrating Gloves", "=ds=#s9#, #a1#", "", "20%" },
				{ 18, 81238, "", "=q3=Hurricane Belt", "=ds=#s10#, #a2#", "", "20%" },
				{ 19, 81237, "", "=q3=Crest of the Clan Lords", "=ds=#s1#, #a3#", "", "20%" },
				{ 20, 81241, "", "=q3=Meteoric Greathelm", "=ds=#s1#, #a4#", "", "20%" },
				{ 21, 81239, "", "=q3=Whirling Dervish Choker", "=ds=#s2#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Trial of the King", 708),
			module = moduleName, instance = "MoguShanPalace",
		};
	};

	AtlasLoot_Data["MoguShanGekkan"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 85182, "", "=q3=Cloak of Cleansing Flame", "=ds=#s4#", "", "20%" },
				{ 3, 85184, "", "=q3=Hexxer's Lethargic Gloves", "=ds=#s9#, #a3#", "", "20%" },
				{ 4, 85180, "", "=q3=Glintrok Sollerets", "=ds=#s12#, #a4#", "", "20%" },
				{ 5, 85181, "", "=q3=Iron Protector Talisman", "=ds=#s14#", "", "20%" },
				{ 6, 85183, "", "=q3=Claws of Gekkan", "=ds=#h1#, #w13#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6478#"};
				{ 17, 81244, "", "=q3=Cloak of Cleansing Flame", "=ds=#s4#", "", "20%" },
				{ 18, 81246, "", "=q3=Hexxer's Lethargic Gloves", "=ds=#s9#, #a3#", "", "20%" },
				{ 19, 81242, "", "=q3=Glintrok Sollerets", "=ds=#s12#, #a4#", "", "20%" },
				{ 20, 81243, "", "=q3=Iron Protector Talisman", "=ds=#s14#", "", "20%" },
				{ 21, 81245, "", "=q3=Claws of Gekkan", "=ds=#h1#, #w13#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Gekkan", 690),
			module = moduleName, instance = "MoguShanPalace",
		};
	};

	AtlasLoot_Data["MoguShanXin"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 85194, "", "=q3=Regal Silk Shoulderpads", "=ds=#s3#, #a1#", "", "20%" },
				{ 3, 85192, "", "=q3=Soulbinder Treads", "=ds=#s12#, #a1#", "", "20%" },
				{ 4, 85187, "", "=q3=Boots of Plummeting Death", "=ds=#s12#, #a2#", "", "20%" },
				{ 5, 85189, "", "=q3=Groundshaker Bracers", "=ds=#s8#, #a3#", "", "20%" },
				{ 6, 85193, "", "=q3=Mind's Eye Breastplate", "=ds=#s5#, #a4#", "", "20%" },
				{ 7, 85186, "", "=q3=Axebreaker Gauntlets", "=ds=#s9#, #a4#", "", "20%" },
				{ 8, 85191, "", "=q3=Mindcapture Pendant", "=ds=#s2#", "", "20%" },
				{ 9, 85188, "", "=q3=Blade Trap Signet", "=ds=#s13#", "", "20%" },
				{ 10, 85190, "", "=q3=Firescribe Dagger", "=ds=#h1#, #w4#", "", "20%" },
				{ 11, 85185, "", "=q3=Ghostheart", "=ds=#w7#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6736#"};
				{ 17, 87542, "", "=q4=Mogu'Dar, Blade of the Thousand Slaves", "=ds=#h2#, #w10#", "", "1%" },
				{ 18, 81257, "", "=q3=Regal Silk Shoulderpads", "=ds=#s3#, #a1#", "", "20%" },
				{ 19, 81255, "", "=q3=Soulbinder Treads", "=ds=#s12#, #a1#", "", "20%" },
				{ 20, 81249, "", "=q3=Boots of Plummeting Death", "=ds=#s12#, #a2#", "", "20%" },
				{ 21, 81252, "", "=q3=Groundshaker Bracers", "=ds=#s8#, #a3#", "", "20%" },
				{ 22, 81256, "", "=q3=Mind's Eye Breastplate", "=ds=#s5#, #a4#", "", "20%" },
				{ 23, 81248, "", "=q3=Axebreaker Gauntlets", "=ds=#s9#, #a4#", "", "20%" },
				{ 24, 81254, "", "=q3=Mindcapture Pendant", "=ds=#s2#", "", "20%" },
				{ 25, 81251, "", "=q3=Blade Trap Signet", "=ds=#s13#", "", "20%" },
				{ 26, 81253, "", "=q3=Firescribe Dagger", "=ds=#h1#, #w4#", "", "20%" },
				{ 27, 81247, "", "=q3=Ghostheart", "=ds=#w7#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Xin the Weaponmaster", 698),
			module = moduleName, instance = "MoguShanPalace",
		};
	};

		---------------------------
		--- Shado-pan Monastery ---
		---------------------------

	AtlasLoot_Data["ShadoPanCloudstrike"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80909, "", "=q3=Azure Serpent Chestguard", "=ds=#s5#, #a3#", "", "33%" },
				{ 3, 80910, "", "=q3=Leggings of the Charging Soul", "=ds=#s11#, #a3#", "", "33%" },
				{ 4, 80908, "", "=q3=Sparkbreath Girdle", "=ds=#s10#, #a4#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81179, "", "=q3=Star Summoner Bracers", "=ds=#s8#, #a2#", "", "20%" },
				{ 18, 81110, "", "=q3=Azure Serpent Chestguard", "=ds=#s5#, #a3#", "", "20%" },
				{ 19, 81092, "", "=q3=Leggings of the Charging Soul", "=ds=#s11#, #a3#", "", "20%" },
				{ 20, 81086, "", "=q3=Sparkbreath Girdle", "=ds=#s10#, #a4#", "", "20%" },
				{ 21, 81180, "", "=q3=Cloudstrike Pendant", "=ds=#s2#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Gu Cloudstrike", 673),
			module = moduleName, instance = "ShadoPanMonastery",
		};
	};

	AtlasLoot_Data["ShadoPanSnowdrift"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80912, "", "=q3=Gauntlets of Resolute Fury", "=ds=#s9#, #a4#", "", "33%" },
				{ 3, 80911, "", "=q3=Quivering Heart Girdle", "=ds=#s10#, #a4#", "", "33%" },
				{ 4, 80937, "", "=q3=Snowdrift's Bladed Staff", "=ds=#w9#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6477#"};
				{ 17, 81101, "", "=q3=Gauntlets of Resolute Fury", "=ds=#s9#, #a4#", "", "20%" },
				{ 18, 81087, "", "=q3=Quivering Heart Girdle", "=ds=#s10#, #a4#", "", "20%" },
				{ 19, 81182, "", "=q3=Eye of the Tornado", "=ds=#s13#", "", "20%" },
				{ 20, 81181, "", "=q3=Heart of Fire", "=ds=#s14#", "", "20%" },
				{ 21, 81108, "", "=q3=Snowdrift's Bladed Staff", "=ds=#w9#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Master Snowdrift", 657),
			module = moduleName, instance = "ShadoPanMonastery",
		};
	};

	AtlasLoot_Data["ShadoPanShaViolence"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80913, "", "=q3=Gloves of Enraged Slaughter", "=ds=#s9#, #a1#", "", "33%" },
				{ 3, 80915, "", "=q3=Spike-Soled Stompers", "=ds=#s12#, #a4#", "", "33%" },
				{ 4, 80883, "", "=q3=Crescent of Ichor", "=ds=#h1#, #w1#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6472#"};
				{ 17, 81102, "", "=q3=Gloves of Enraged Slaughter", "=ds=#s9#, #a1#", "", "20%" },
				{ 18, 81185, "", "=q3=Bladed Smoke Bracers", "=ds=#s8#, #a3#", "", "20%" },
				{ 19, 81113, "", "=q3=Spike-Soled Stompers", "=ds=#s12#, #a4#", "", "20%" },
				{ 20, 81184, "", "=q3=Necklace of Disorientation", "=ds=#s2#", "", "20%" },
				{ 21, 81089, "", "=q3=Crescent of Ichor", "=ds=#h1#, #w1#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sha of Violence", 685),
			module = moduleName, instance = "ShadoPanMonastery",
		};
	};

	AtlasLoot_Data["ShadoPanTaranZhu"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80919, "", "=q3=Darkbinder Leggings", "=ds=#s11#, #a2#", "", "33%" },
				{ 3, 80916, "", "=q3=Shadowspine Shoulderguards", "=ds=#s3#, #a3#", "", "33%" },
				{ 4, 80917, "", "=q3=Blastwalker Footguards", "=ds=#s12#, #a3#", "", "33%" },
				{ 5, 80918, "", "=q3=Mindbinder Plate Gloves", "=ds=#s9#, #a4#", "", "33%" },
				{ 6, 80936, "", "=q3=Warmace of Taran Zhu", "=ds=#h2#, #w6#", "", "33%" },
				{ 7, 80935, "", "=q3=Shield of Blind Hate", "=ds=#w8#", "", "33%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6471#"};
				{ 17, 87543, "", "=q4=Ka'eng, Breath of the Shadow", "=ds=#h1#, #w13#", "", "1%" },
				{ 18, 81188, "", "=q3=Robes of Fevered Dreams", "=ds=#s5#, #a1#", "", "20%" },
				{ 19, 81093, "", "=q3=Darkbinder Leggings", "=ds=#s11#, #a2#", "", "20%" },
				{ 20, 81099, "", "=q3=Shadowspine Shoulderguards", "=ds=#s3#, #a3#", "", "20%" },
				{ 21, 81114, "", "=q3=Blastwalker Footguards", "=ds=#s12#, #a3#", "", "20%" },
				{ 22, 81187, "", "=q3=Hateshatter Chestplate", "=ds=#s5#, #a4#", "", "20%" },
				{ 23, 81103, "", "=q3=Mindbinder Plate Gloves", "=ds=#s9#, #a4#", "", "20%" },
				{ 24, 81189, "", "=q3=Ring of Malice", "=ds=#s13#", "", "20%" },
				{ 25, 81186, "", "=q3=Seal of Hateful Meditation", "=ds=#s13#", "", "20%" },
				{ 26, 81107, "", "=q3=Warmace of Taran Zhu", "=ds=#h2#, #w6#", "", "20%" },
				{ 27, 81096, "", "=q3=Shield of Blind Hate", "=ds=#w8#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Taran Zhu", 686),
			module = moduleName, instance = "ShadoPanMonastery",
		};
	};

		-------------------------------
		--- Gate of the Setting Sun ---
		-------------------------------

	AtlasLoot_Data["GotSSKiptilak"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80920, "", "=q3=Fallout Filter", "=ds=#s1#, #a1#", "", "20%"},
				{ 3, 80921, "", "=q3=Saboteur's Stabilizing Bracers", "=ds=#s8#, #a2#", "", "20%" },
				{ 4, 80934, "", "=q3=Pendant of Precise Timing", "=ds=#s2#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6479#"};
				{ 17, 81104, "", "=q3=Fallout-Filtering Hood", "=ds=#s1#, #a1#", "", "20%"},
				{ 18, 81090, "", "=q3=Saboteur's Stabilizing Bracers", "=ds=#s8#, #a2#", "", "20%" },
				{ 19, 81190, "", "=q3=Grenadier's Belt", "=ds=#s10#, #a4#", "", "20%" },
				{ 20, 81095, "", "=q3=Pendant of Precise Timing", "=ds=#s2#", "", "20%" },
				{ 21, 81191, "", "=q3=Pulled Grenade Pin", "=ds=#s13#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Saboteur Kip'tilak", 655),
			module = moduleName, instance = "GateoftheSettingSun",
		};
	};

	AtlasLoot_Data["GotSSGadok"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80922, "", "=q3=Airstream Treads", "=ds=#s12#, #a2#", "", "20%" },
				{ 3, 80923, "", "=q3=Impaler's Girdle", "=ds=#s10#, #a3#", "", "20%" },
				{ 4, 80924, "", "=q3=Acid-Scarred Spaulders", "=ds=#s3#, #a4#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81229, "", "=q3=Bomber's Precision Gloves", "=ds=#s9#, #a1#", "", "20%" },
				{ 18, 81111, "", "=q3=Airstream Treads", "=ds=#s12#, #a2#", "", "20%" },
				{ 19, 81085, "", "=q3=Impaler's Girdle", "=ds=#s10#, #a3#", "", "20%" },
				{ 20, 81098, "", "=q3=Acid-Scarred Spaulders", "=ds=#s3#, #a4#", "", "20%" },
				{ 21, 81192, "", "=q3=Vision of the Predator", "=ds=#s14#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Striker Ga'dok", 675),
			module = moduleName, instance = "GateoftheSettingSun",
		};
	};

	AtlasLoot_Data["GotSSRimok"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80926, "", "=q3=Leggings of the Frenzy", "=ds=#s11#, #a1#", "", "20%" },
				{ 3, 80925, "", "=q3=Swarmcall Helm", "=ds=#s1#, #a3#", "", "20%" },
				{ 4, 80933, "", "=q3=Mantid Trochanter", "=ds=#h1#, #w4#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81106, "", "=q3=Leggings of the Frenzy", "=ds=#s11#, #a1#", "", "20%" },
				{ 18, 81105, "", "=q3=Swarmcall Helm", "=ds=#s1#, #a3#", "", "20%" },
				{ 19, 81230, "", "=q3=Ri'mok's Shattered Scale", "=ds=#s8#, #a4#", "", "20%" },
				{ 20, 81232, "", "=q3=Viscous Ring", "=ds=#s13#", "", "20%" },
				{ 21, 81088, "", "=q3=Mantid Trochanter", "=ds=#h1#, #w4#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Commander Ri'mok", 676),
			module = moduleName, instance = "GateoftheSettingSun",
		};
	};

	AtlasLoot_Data["GotSSRaigonn"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 80929, "", "=q3=Wall-Breaker Legguards", "=ds=#s11#, #a2#", "", "20%" },
				{ 3, 80928, "", "=q3=Treads of Fixation", "=ds=#s12#, #a3#", "", "20%" },
				{ 4, 80930, "", "=q3=Swarmbringer Chestguard", "=ds=#s5#, #a4#", "", "20%" },
				{ 5, 80927, "", "=q3=Hive Protector's Gauntlets", "=ds=#s9#, #a4#", "", "20%" },
				{ 6, 80932, "", "=q3=Carapace Breaker", "=ds=#h1#, #w6#", "", "20%" },
				{ 7, 80931, "", "=q3=Shield of the Protectorate", "=ds=#w8#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6945#"};
				{ 17, 87546, "", "=q4=Klatith, Fangs of the Swarm", "=ds=#w2#", "", "1%" },
				{ 18, 81234, "", "=q3=Drape of the Screeching Swarm", "=ds=#s4#", "", "20%" },
				{ 19, 81235, "", "=q3=Shoulders of Engulfing Winds", "=ds=#s3#, #a1#", "", "20%" },
				{ 20, 81236, "", "=q3=Frenzyswarm Bracers", "=ds=#s8#, #a1#", "", "20%" },
				{ 21, 81091, "", "=q3=Wall-Breaker Legguards", "=ds=#s11#, #a2#", "", "20%" },
				{ 22, 81112, "", "=q3=Treads of Fixation", "=ds=#s12#, #a3#", "", "20%" },
				{ 23, 81109, "", "=q3=Swarmbringer Chestguard", "=ds=#s5#, #a4#", "", "20%" },
				{ 24, 81100, "", "=q3=Hive Protector's Gauntlets", "=ds=#s9#, #a4#", "", "20%" },
				{ 25, 81094, "", "=q3=Carapace Breaker", "=ds=#h1#, #w6#", "", "20%" },
				{ 26, 81233, "", "=q3=Impervious Carapace", "=ds=#w8#", "", "20%" },
				{ 27, 81097, "", "=q3=Shield of the Protectorate", "=ds=#w8#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Raigonn", 649),
			module = moduleName, instance = "GateoftheSettingSun",
		};
	};

		------------------------------
		--- Siege of Niuzao Temple ---
		------------------------------

	AtlasLoot_Data["NTJinbak"] = {
		["Normal"] = {
			{
				{ 1, 81262, "", "=q3=Hood of Viridian Residue", "=ds=#s1#, #a2#", "", "20%"},
				{ 2, 81272, "", "=q3=Girdle of Soothing Detonation", "=ds=#s10#, #a4#", "", "20%" },
				{ 3, 81270, "", "=q3=Sap-Encrusted Legplates", "=ds=#s11#, #a4#", "", "20%" },
				{ 4, 81271, "", "=q3=Engraved Amber Pendant", "=ds=#s2#", "", "20%" },
				{ 5, 81263, "", "=q3=Flashfrozen Resin Globule", "=ds=#s14#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Vizier Jin'bak", 693),
			module = moduleName, instance = "SiegeofNiuzaoTemple",
		};
	};

	AtlasLoot_Data["NTVojak"] = {
		["Normal"] = {
			{
				{ 1, 81276, "", "=q3=Bombardment Bracers", "=ds=#s8#, #a1#", "", "20%" },
				{ 2, 81275, "", "=q3=Chestwrap of Arcing Flame", "=ds=#s5#, #a2#", "", "20%" },
				{ 3, 81277, "", "=q3=Archer's Precision Grips", "=ds=#s9#, #a3#", "", "20%" },
				{ 4, 81274, "", "=q3=Sightfinder Helm", "=ds=#s1#, #a4#", "", "20%" },
				{ 5, 81273, "", "=q3=Siege-Captain's Scimitar", "=ds=#h1#, #w10#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Commander Vo'jak", 738),
			module = moduleName, instance = "SiegeofNiuzaoTemple",
		};
	};

	AtlasLoot_Data["NTPavalak"] = {
		["Normal"] = {
			{
				{ 1, 81282, "", "=q3=Aerial Bombardment Cloak", "=ds=#s4#", "", "20%" },
				{ 2, 81281, "", "=q3=Breezebinder Handwraps", "=ds=#s9#, #a1#", "", "20%" },
				{ 3, 81280, "", "=q3=Siegeworn Bracers", "=ds=#s8#, #a4#", "", "20%" },
				{ 4, 81264, "", "=q3=Vial of Ichorous Blood", "=ds=#s14#", "", "20%" },
				{ 5, 81279, "", "=q3=Tempestuous Longbow", "=ds=#w2#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("General Pa'valak", 692),
			module = moduleName, instance = "SiegeofNiuzaoTemple",
		};
	};

	AtlasLoot_Data["NTNeronok"] = {
		["Normal"] = {
			{
				{ 1, 87547, "", "=q4=Tolakesh, Horn of the Black Ox", "=ds=#h1#, #w4#", "", "1%" },
				{ 3, 81289, "", "=q3=Breezeswept Hood", "=ds=#s1#, #a1#", "", "20%" },
				{ 4, 81291, "", "=q3=Whisperwind Spaulders", "=ds=#s3#, #a1#", "", "20%" },
				{ 5, 81283, "", "=q3=Windblast Helm", "=ds=#s1#, #a2#", "", "20%" },
				{ 6, 81285, "", "=q3=Galedodger Chestguard", "=ds=#s5#, #a3#", "", "20%" },
				{ 7, 81290, "", "=q3=Belt of Totemic Binding", "=ds=#s10#, #a3#", "", "20%" },
				{ 8, 81292, "", "=q3=Airbender Sandals", "=ds=#s12#, #a3#", "", "20%" },
				{ 9, 81287, "", "=q3=Spaulders of Immovable Stone", "=ds=#s3#, #a4#", "", "20%" },
				{ 10, 81284, "", "=q3=Anchoring Sabatons", "=ds=#s12#, #a4#", "", "20%" },
				{ 18, 81286, "", "=q3=Ner'onok's Razor Katar", "=ds=#h1#, #w13#", "", "20%" },
				{ 19, 81288, "", "=q3=Gustwalker Staff", "=ds=#w9#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Wing Leader Ner'onok", 727),
			module = moduleName, instance = "SiegeofNiuzaoTemple",
		};
	};

		-------------------
		--- Scholomance ---
		-------------------

	AtlasLoot_Data["ScholoChillheart"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88336, "", "=q3=Icewrath Belt", "=ds=#s10#, #a2#", "", "20%" },
				{ 3, 88337, "", "=q3=Shadow Puppet Bracers", "=ds=#s8#, #a3#", "", "20%" },
				{ 4, 88338, "", "=q3=Breastplate of Wracking Souls", "=ds=#s5#, #a4#", "", "20%" },
				{ 5, 88335, "", "=q3=Anarchist's Pendant", "=ds=#s2#", "", "20%" },
				{ 6, 88339, "", "=q3=Gravetouch Greatsword", "=ds=#h2#, #w10#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82823, "", "=q3=Icewrath Belt", "=ds=#s10#, #a2#", "", "20%" },
				{ 18, 82820, "", "=q3=Shadow Puppet Bracers", "=ds=#s8#, #a3#", "", "20%" },
				{ 19, 82821, "", "=q3=Breastplate of Wracking Souls", "=ds=#s5#, #a4#", "", "20%" },
				{ 20, 81566, "", "=q3=Anarchist's Pendant", "=ds=#s2#", "", "20%" },
				{ 21, 82822, "", "=q3=Gravetouch Greatsword", "=ds=#h2#, #w10#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Instructor Chillheart", 659),
			module = moduleName, instance = "Scholomance",
		};
	};

	AtlasLoot_Data["ScholoJandice"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88349, "", "=q3=Phantasmal Drape", "=ds=#s4#", "", "20%" },
				{ 3, 88345, "", "=q3=Barovian Ritual Hood", "=ds=#s1#, #a1#", "", "20%" },
				{ 4, 88347, "", "=q3=Ghostwoven Legguards", "=ds=#s11#, #a2#", "", "20%" },
				{ 5, 88348, "", "=q3=Wraithplate Treads", "=ds=#s12#, #a4#", "", "20%" },
				{ 6, 88346, "", "=q3=Metanoia Shield", "=ds=#w8#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6531#"};
				{ 17, 82850, "", "=q3=Phantasmal Drape", "=ds=#s4#", "", "20%" },
				{ 18, 82848, "", "=q3=Barovian Ritual Hood", "=ds=#s1#, #a1#", "", "20%" },
				{ 19, 82851, "", "=q3=Ghostwoven Legguards", "=ds=#s11#, #a2#", "", "20%" },
				{ 20, 82852, "", "=q3=Wraithplate Treads", "=ds=#s12#, #a4#", "", "20%" },
				{ 21, 82847, "", "=q3=Metanoia Shield", "=ds=#w8#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Jandice Barov", 663),
			module = moduleName, instance = "Scholomance",
		};
	};

	AtlasLoot_Data["ScholoRattlegore"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88340, "", "=q3=Deadwalker Bracers", "=ds=#s8#, #a1#", "", "20%" },
				{ 3, 88342, "", "=q3=Rattling Gloves", "=ds=#s9#, #a2#", "", "20%" },
				{ 4, 88343, "", "=q3=Bone Golem Boots", "=ds=#s12#, #a3#", "", "20%" },
				{ 5, 88344, "", "=q3=Goresoaked Headreaper", "=ds=#h2#, #w1#", "", "20%" },
				{ 6, 88341, "", "=q3=Necromantic Wand", "=ds=#w12#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6394#"};
				{ 17, 82825, "", "=q3=Deadwalker Bracers", "=ds=#s8#, #a1#", "", "20%" },
				{ 18, 82827, "", "=q3=Rattling Gloves", "=ds=#s9#, #a2#", "", "20%" },
				{ 19, 82828, "", "=q3=Bone Golem Boots", "=ds=#s12#, #a3#", "", "20%" },
				{ 20, 82824, "", "=q3=Goresoaked Headreaper", "=ds=#h2#, #w1#", "", "20%" },
				{ 21, 82826, "", "=q3=Necromantic Wand", "=ds=#w12#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Rattlegore", 665),
			module = moduleName, instance = "Scholomance",
		};
	};

	AtlasLoot_Data["ScholoVoss"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88350, "", "=q3=Leggings of Unleashed Anguish", "=ds=#s11#, #a1#", "", "20%" },
				{ 3, 88351, "", "=q3=Soulburner Crown", "=ds=#s1#, #a2#", "", "20%" },
				{ 4, 88352, "", "=q3=Shivbreaker Vest", "=ds=#s5#, #a3#", "", "20%" },
				{ 5, 88353, "", "=q3=Dark Blaze Gauntlets", "=ds=#s9#, #a4#", "", "20%" },
				{ 6, 88354, "", "=q3=Necklace of the Dark Blaze", "=ds=#s2#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82854, "", "=q3=Leggings of Unleashed Anguish", "=ds=#s11#, #a1#", "", "20%" },
				{ 18, 82853, "", "=q3=Soulburner Crown", "=ds=#s1#, #a2#", "", "20%" },
				{ 19, 82855, "", "=q3=Shivbreaker Vest", "=ds=#s5#, #a3#", "", "20%" },
				{ 20, 82856, "", "=q3=Dark Blaze Gauntlets", "=ds=#s9#, #a4#", "", "20%" },
				{ 21, 81567, "", "=q3=Necklace of the Dark Blaze", "=ds=#s2#", "", "20%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lilian Voss", 666),
			module = moduleName, instance = "Scholomance",
		};
	};

	AtlasLoot_Data["ScholoGandling"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88359, "", "=q3=Incineration Belt", "=ds=#s10#, #a1#", "", "25%" },
				{ 3, 88356, "", "=q3=Tombstone Gauntlets", "=ds=#s9#, #a2#", "", "25%" },
				{ 4, 88361, "", "=q3=Gloves of Explosive Pain", "=ds=#s9#, #a3#", "", "25%" },
				{ 5, 88362, "", "=q3=Shoulderguards of Painful Lessons", "=ds=#s3#, #a4#", "", "25%" },
				{ 6, 88357, "", "=q3=Vigorsteel Spaulders", "=ds=#s3#, #a4#", "", "25%" },
				{ 7, 88358, "", "=q3=Lessons of the Darkmaster", "=ds=#s14#", "", "25%" },
				{ 8, 88360, "", "=q3=Price of Progress", "=ds=#s14#", "", "25%" },
				{ 9, 88355, "", "=q3=Searing Words", "=ds=#s14#", "", "25%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6821#"};
				{ 17, 82859, "", "=q4=Headmaster's Will", "=ds=#w9#", "", "1%" },
				{ 18, 82861, "", "=q3=Incineration Belt", "=ds=#s10#, #a1#", "", "25%" },
				{ 19, 82858, "", "=q3=Tombstone Gauntlets", "=ds=#s9#, #a2#", "", "25%" },
				{ 20, 82860, "", "=q3=Gloves of Explosive Pain", "=ds=#s9#, #a3#", "", "25%" },
				{ 21, 82862, "", "=q3=Shoulderguards of Painful Lessons", "=ds=#s3#, #a4#", "", "25%" },
				{ 22, 82857, "", "=q3=Vigorsteel Spaulders", "=ds=#s3#, #a4#", "", "25%" },
				{ 23, 81268, "", "=q3=Lessons of the Darkmaster", "=ds=#s14#", "", "25%" },
				{ 24, 81266, "", "=q3=Price of Progress", "=ds=#s14#", "", "25%" },
				{ 25, 81267, "", "=q3=Searing Words", "=ds=#s14#", "", "25%" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Darkmaster Gandling", 684),
			module = moduleName, instance = "Scholomance",
		};
	};

		---------------------
		--- Scarlet Halls ---
		---------------------

	AtlasLoot_Data["SHBraun"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88266, "", "=q3=Hound Trainer's Gloves", "=ds=#s9#, #a2#", "", "20%" },
				{ 3, 88268, "", "=q3=Canine Commander's Breastplate", "=ds=#s5#, #a4#", "", "20%" },
				{ 4, 88267, "", "=q3=Commanding Bracers", "=ds=#s8#, #a4#", "", "20%" },
				{ 5, 88265, "", "=q3=Beastbinder Ring", "=ds=#s13#", "", "20%" },
				{ 6, 88264, "", "=q3=Houndmaster's Compound Crossbow", "=ds=#w3#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6684#"};
				{ 17, 81695, "", "=q3=Hound Trainer's Gloves", "=ds=#s9#, #a2#", "", "20%" },
				{ 18, 81696, "", "=q3=Canine Commander's Breastplate", "=ds=#s5#, #a4#", "", "20%" },
				{ 19, 81694, "", "=q3=Commanding Bracers", "=ds=#s8#, #a4#", "", "20%" },
				{ 20, 81563, "", "=q3=Beastbinder Ring", "=ds=#s13#", "", "20%" },
				{ 21, 81693, "", "=q3=Houndmaster's Compound Crossbow", "=ds=#w3#", "", "20%" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Houndmaster Braun", 660),
			module = moduleName, instance = "ScarletHalls",
		};
	};

	AtlasLoot_Data["SHHarlan"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88269, "", "=q3=Scarlet Sandals", "=ds=#s12#, #a1#", "", "20%" },
				{ 3, 88270, "", "=q3=Lightblade Bracer", "=ds=#s8#, #a2#", "", "20%" },
				{ 4, 88271, "", "=q3=Harlan's Shoulders", "=ds=#s3#, #a3#", "", "20%" },
				{ 5, 88273, "", "=q3=Armsmaster's Sealed Locket", "=ds=#s2#", "", "20%" },
				{ 6, 88272, "", "=q3=The Gleaming Ravager", "=ds=#h2#, #w1#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6427#"};
				{ 17, 81699, "", "=q3=Scarlet Sandals", "=ds=#s12#, #a1#", "", "20%" },
				{ 18, 81700, "", "=q3=Lightblade Bracer", "=ds=#s8#, #a2#", "", "20%" },
				{ 19, 81698, "", "=q3=Harlan's Shoulders", "=ds=#s3#, #a3#", "", "20%" },
				{ 20, 81568, "", "=q3=Armsmaster's Sealed Locket", "=ds=#s2#", "", "20%" },
				{ 21, 81697, "", "=q3=The Gleaming Ravager", "=ds=#h2#, #w1#", "", "20%" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Armsmaster Harlan", 654),
			module = moduleName, instance = "ScarletHalls",
		};
	};

	AtlasLoot_Data["SHKoegler"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88279, "", "=q3=Robes of Koegler", "=ds=#s5#, #a1#", "", "20%" },
				{ 3, 88282, "", "=q3=Vellum-Ripper Gloves", "=ds=#s9#, #a2#", "", "20%" },
				{ 4, 88276, "", "=q3=Bindburner Belt", "=ds=#s10#, #a3#", "", "20%" },
				{ 5, 88283, "", "=q3=Bradbury's Entropic Legguards", "=ds=#s11#, #a3#", "", "20%" },
				{ 6, 88277, "", "=q3=Pyretic Legguards", "=ds=#s11#, #a4#", "", "20%" },
				{ 7, 88275, "", "=q3=Scorched Scarlet Key", "=ds=#s2#", "", "20%" },
				{ 8, 88281, "", "=q3=Temperature-Sensing Necklace", "=ds=#s2#", "", "20%" },
				{ 9, 88280, "", "=q3=Melted Hypnotic Blade", "=ds=#h1#, #w4#", "", "20%" },
				{ 10, 88274, "", "=q3=Koegler's Ritual Knife", "=ds=#h1#, #w4#", "", "20%" },
				{ 11, 88278, "", "=q3=Mograine's Immaculate Might", "=ds=#h2#, #w6#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 87550, "", "=q4=Vithrak, Gaze of the Deadman", "=ds=#s13#", "", "1%" },
				{ 18, 82817, "", "=q3=Robes of Koegler", "=ds=#s5#, #a1#", "", "20%" },
				{ 19, 82818, "", "=q3=Vellum-Ripper Gloves", "=ds=#s9#, #a2#", "", "20%" },
				{ 20, 82815, "", "=q3=Bindburner Belt", "=ds=#s10#, #a3#", "", "20%" },
				{ 21, 82819, "", "=q3=Bradbury's Entropic Legguards", "=ds=#s11#, #a3#", "", "20%" },
				{ 22, 82812, "", "=q3=Pyretic Legguards", "=ds=#s11#, #a4#", "", "20%" },
				{ 23, 81564, "", "=q3=Scorched Scarlet Key", "=ds=#s2#", "", "20%" },
				{ 24, 81565, "", "=q3=Temperature-Sensing Necklace", "=ds=#s2#", "", "20%" },
				{ 25, 82816, "", "=q3=Melted Hypnotic Blade", "=ds=#h1#, #w4#", "", "20%" },
				{ 26, 82813, "", "=q3=Koegler's Ritual Knife", "=ds=#h1#, #w4#", "", "20%" },
				{ 27, 82814, "", "=q3=Mograine's Immaculate Might", "=ds=#h2#, #w6#", "", "20%" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Flameweaver Kogler", 656),
			module = moduleName, instance = "ScarletHalls",
		};
	};

		-------------------------
		--- Scarlet Monastery ---
		-------------------------

	AtlasLoot_Data["SMThalnos"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88288, "", "=q3=Soulrender Greatcloak", "=ds=#s4#", "", "20%" },
				{ 3, 88284, "", "=q3=Forgotten Bloodmage Mantle", "=ds=#s3#, #a1#", "", "20%" },
				{ 4, 88286, "", "=q3=Legguards of the Crimson Magus", "=ds=#s11#, #a3#", "", "20%" },
				{ 5, 88287, "", "=q3=Bracers of the Fallen Crusader", "=ds=#s8#, #a4#", "", "20%" },
				{ 6, 88285, "", "=q3=Signet of the Hidden Door", "=ds=#s13#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6946#"};
				{ 17, 81571, "", "=q3=Soulrender Greatcloak", "=ds=#s4#", "", "20%" },
				{ 18, 81569, "", "=q3=Forgotten Bloodmage Mantle", "=ds=#s3#, #a1#", "", "20%" },
				{ 19, 81570, "", "=q3=Legguards of the Crimson Magus", "=ds=#s11#, #a3#", "", "20%" },
				{ 20, 81572, "", "=q3=Bracers of the Fallen Crusader", "=ds=#s8#, #a4#", "", "20%" },
				{ 21, 81560, "", "=q3=Signet of the Hidden Door", "=ds=#s13#", "", "20%" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Thalnos the Soulrender", 688),
			module = moduleName, instance = "ScarletMonastery",
		};
	};

	AtlasLoot_Data["SMKorloff"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88290, "", "=q3=Scorched Earth Cloak", "=ds=#s4#", "", "20%" },
				{ 3, 88291, "", "=q3=Korloff's Raiment", "=ds=#s5#, #a2#", "", "20%" },
				{ 4, 88292, "", "=q3=Helm of Rising Flame", "=ds=#s1#, #a4#", "", "20%" },
				{ 5, 88293, "", "=q3=Firefinger Ring", "=ds=#s13#", "", "20%" },
				{ 6, 88289, "", "=q3=Firestorm Greatstaff", "=ds=#w9#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6928#"};
				{ 17, 81575, "", "=q3=Scorched Earth Cloak", "=ds=#s4#", "", "20%" },
				{ 18, 81573, "", "=q3=Korloff's Raiment", "=ds=#s5#, #a2#", "", "20%" },
				{ 19, 81574, "", "=q3=Helm of Rising Flame", "=ds=#s1#, #a4#", "", "20%" },
				{ 20, 81561, "", "=q3=Firefinger Ring", "=ds=#s13#", "", "20%" },
				{ 21, 81576, "", "=q3=Firestorm Greatstaff", "=ds=#w9#", "", "20%" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Brother Korloff", 671),
			module = moduleName, instance = "ScarletMonastery",
		};
	};

	AtlasLoot_Data["SMWhitemane"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88299, "", "=q3=Whitemane's Embroidered Chapeau", "=ds=#s1#, #a1#", "", "20%" },
				{ 3, 88298, "", "=q3=Leggings of Hallowed Fire", "=ds=#s11#, #a1#", "", "20%" },
				{ 4, 88302, "", "=q3=Incarnadine Scarlet Spaulders", "=ds=#s3#, #a2#", "", "20%" },
				{ 5, 88295, "", "=q3=Dashing Strike Treads", "=ds=#s12#, #a2#", "", "20%" },
				{ 6, 88303, "", "=q3=Crown of Holy Flame", "=ds=#s1#, #a4#", "", "20%" },
				{ 7, 88296, "", "=q3=Waistplate of Imminent Resurrection", "=ds=#s10#, #a4#", "", "20%" },
				{ 8, 88300, "", "=q3=Triune Signet", "=ds=#s13#", "", "20%" },
				{ 9, 88294, "", "=q3=Flashing Steel Talisman", "=ds=#s14#", "", "20%" },
				{ 10, 88297, "", "=q3=Lightbreaker Greatsword", "=ds=#h2#, #w10#", "", "20%" },
				{ 11, 88301, "", "=q3=Greatstaff of Righteousness", "=ds=#w9#", "", "20%" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:6929#"};
				{ 17, 87551, "", "=q4=Helios, Durand's Soul of Purity", "=ds=#s2#", "", "1%" },
				{ 18, 81692, "", "=q3=Whitemane's Embroidered Chapeau", "=ds=#s1#, #a1#", "", "20%" },
				{ 19, 81689, "", "=q3=Leggings of Hallowed Fire", "=ds=#s11#, #a1#", "", "20%" },
				{ 20, 81690, "", "=q3=Incarnadine Scarlet Spaulders", "=ds=#s3#, #a2#", "", "20%" },
				{ 21, 81688, "", "=q3=Dashing Strike Treads", "=ds=#s12#, #a2#", "", "20%" },
				{ 22, 81578, "", "=q3=Crown of Holy Flame", "=ds=#s1#, #a4#", "", "20%" },
				{ 23, 81687, "", "=q3=Waistplate of Imminent Resurrection", "=ds=#s10#, #a4#", "", "20%" },
				{ 24, 81562, "", "=q3=Triune Signet", "=ds=#s13#", "", "20%" },
				{ 25, 81265, "", "=q3=Flashing Steel Talisman", "=ds=#s14#", "", "20%" },
				{ 26, 81577, "", "=q3=Lightbreaker Greatsword", "=ds=#h2#, #w10#", "", "20%" },
				{ 27, 81691, "", "=q3=Greatstaff of Righteousness", "=ds=#w9#", "", "20%" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Inquisitor Whitemane", 674),
			module = moduleName, instance = "ScarletMonastery",
		};
	};

		---------------------
		--- Heart of Fear ---
		---------------------

	AtlasLoot_Data["HoFZorlok"] = {
		["RaidFinder"] = {
			{
				{ 1, 86812, "", "=q4=Hisek's Chrysanthemum Cape", "=ds=#s4#" },
				{ 2, 86815, "", "=q4=Attenuating Bracers", "=ds=#s8#, #a1#" },
				{ 3, 86819, "", "=q4=Gloves of Grasping Claws", "=ds=#s9#, #a1#" },
				{ 4, 89953, "", "=q4=Scent-Soaked Sandals", "=ds=#s12#, #a1#" },
				{ 5, 86817, "", "=q4=Gauntlets of Undesired Gifts", "=ds=#s9#, #a2#" },
				{ 6, 86811, "", "=q4=Boots of the Still Breath", "=ds=#s12#, #a2#" },
				{ 7, 86818, "", "=q4=Mail of Screaming Secrets", "=ds=#s5#, #a3#" },
				{ 8, 87823, "", "=q4=Zor'lok's Fizzing Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 86816, "", "=q4=Chestplate of the Forbidden Tower", "=ds=#s5#, #a4#" },
				{ 10, 89954, "", "=q4=Warbelt of Sealed Pods", "=ds=#s10#, #a4#" },
				{ 11, 86854, "", "=q4=Articulated Legplates", "=ds=#s11#, #a4#" },
				{ 16, 89952, "", "=q4=Pheromone-Coated Choker", "=ds=#s2#" },
				{ 17, 86814, "", "=q4=Fragment of Fear Made Flesh", "=ds=#s13#" },
				{ 18, 86813, "", "=q4=Vizier's Ruby Signet", "=ds=#s13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86154, "", "=q4=Hisek's Chrysanthemum Cape", "=ds=#s4#" },
				{ 2, 86157, "", "=q4=Attenuating Bracers", "=ds=#s8#, #a1#" },
				{ 3, 86161, "", "=q4=Gloves of Grasping Claws", "=ds=#s9#, #a1#" },
				{ 4, 89829, "", "=q4=Scent-Soaked Sandals", "=ds=#s12#, #a1#" },
				{ 5, 86159, "", "=q4=Gauntlets of Undesired Gifts", "=ds=#s9#, #a2#" },
				{ 6, 86153, "", "=q4=Boots of the Still Breath", "=ds=#s12#, #a2#" },
				{ 7, 86160, "", "=q4=Mail of Screaming Secrets", "=ds=#s5#, #a3#" },
				{ 8, 87824, "", "=q4=Zor'lok's Fizzing Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 86158, "", "=q4=Chestplate of the Forbidden Tower", "=ds=#s5#, #a4#" },
				{ 10, 89826, "", "=q4=Warbelt of Sealed Pods", "=ds=#s10#, #a4#" },
				{ 11, 86203, "", "=q4=Articulated Legplates", "=ds=#s11#, #a4#" },
				{ 16, 89827, "", "=q4=Pheromone-Coated Choker", "=ds=#s2#" },
				{ 17, 86156, "", "=q4=Fragment of Fear Made Flesh", "=ds=#s13#" },
				{ 18, 86155, "", "=q4=Vizier's Ruby Signet", "=ds=#s13#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 86945, "", "=q4=Hisek's Chrysanthemum Cape", "=ds=#s4#" },
				{ 2, 86948, "", "=q4=Attenuating Bracers", "=ds=#s8#, #a1#" },
				{ 3, 86947, "", "=q4=Gloves of Grasping Claws", "=ds=#s9#, #a1#" },
				{ 4, 89918, "", "=q4=Scent-Soaked Sandals", "=ds=#s12#, #a1#" },
				{ 5, 86950, "", "=q4=Gauntlets of Undesired Gifts", "=ds=#s9#, #a2#" },
				{ 6, 86943, "", "=q4=Boots of the Still Breath", "=ds=#s12#, #a2#" },
				{ 7, 86951, "", "=q4=Mail of Screaming Secrets", "=ds=#s5#, #a3#" },
				{ 8, 87822, "", "=q4=Zor'lok's Fizzing Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 86952, "", "=q4=Chestplate of the Forbidden Tower", "=ds=#s5#, #a4#" },
				{ 10, 89919, "", "=q4=Warbelt of Sealed Pods", "=ds=#s10#, #a4#" },
				{ 11, 86944, "", "=q4=Articulated Legplates", "=ds=#s11#, #a4#" },
				{ 16, 89917, "", "=q4=Pheromone-Coated Choker", "=ds=#s2#" },
				{ 17, 86949, "", "=q4=Fragment of Fear Made Flesh", "=ds=#s13#" },
				{ 18, 86946, "", "=q4=Vizier's Ruby Signet", "=ds=#s13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Imperial Vizier Zor'lok", 745),
			module = moduleName, instance = "HeartofFear",
		};
	};

	AtlasLoot_Data["HoFTayak"] = {
		["RaidFinder"] = {
			{
				{ 1, 86827, "", "=q4=Drape of Gathering Clouds", "=ds=#s4#" },
				{ 2, 86828, "", "=q4=Twisting Wind Bracers", "=ds=#s8#, #a1#" },
				{ 3, 86825, "", "=q4=Boots of the Blowing Wind", "=ds=#s12#, #a1#" },
				{ 4, 89957, "", "=q4=Hood of Stilled Winds", "=ds=#s1#, #a2#" },
				{ 5, 86821, "", "=q4=Bracers of Unseen Strikes", "=ds=#s8#, #a2#" },
				{ 6, 86826, "", "=q4=Bracers of Tempestuous Fury", "=ds=#s8#, #a3#" },
				{ 7, 90739, "", "=q4=Kaz'tik's Stormseizer Gauntlets", "=ds=#s9#, #a3#" },
				{ 8, 89955, "", "=q4=Sword Dancer's Leggings", "=ds=#s11#, #a3#" },
				{ 9, 89956, "", "=q4=Pauldrons of the Broken Blade", "=ds=#s3#, #a4#" },
				{ 10, 86823, "", "=q4=Windblade Talons", "=ds=#s9#, #a4#" },
				{ 11, 86822, "", "=q4=Waistplate of Overwhelming Assault", "=ds=#s10#, #a4#" },
				{ 16, 86824, "", "=q4=Choker of the Unleashed Storm", "=ds=#s2#" },
				{ 17, 86820, "", "=q4=Ring of the Bladed Tempest", "=ds=#s13#" },
				{ 19, 86829, "", "=q4=Tornado-Summoning Censer", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86169, "", "=q4=Drape of Gathering Clouds", "=ds=#s4#" },
				{ 2, 86170, "", "=q4=Twisting Wind Bracers", "=ds=#s8#, #a1#" },
				{ 3, 86167, "", "=q4=Boots of the Blowing Wind", "=ds=#s12#, #a1#" },
				{ 4, 89831, "", "=q4=Hood of Stilled Winds", "=ds=#s1#, #a2#" },
				{ 5, 86163, "", "=q4=Bracers of Unseen Strikes", "=ds=#s8#, #a2#" },
				{ 6, 86168, "", "=q4=Bracers of Tempestuous Fury", "=ds=#s8#, #a3#" },
				{ 7, 90738, "", "=q4=Kaz'tik's Stormseizer Gauntlets", "=ds=#s9#, #a3#" },
				{ 8, 89830, "", "=q4=Sword Dancer's Leggings", "=ds=#s11#, #a3#" },
				{ 9, 89828, "", "=q4=Pauldrons of the Broken Blade", "=ds=#s3#, #a4#" },
				{ 10, 86165, "", "=q4=Windblade Talons", "=ds=#s9#, #a4#" },
				{ 11, 86164, "", "=q4=Waistplate of Overwhelming Assault", "=ds=#s10#, #a4#" },
				{ 16, 86166, "", "=q4=Choker of the Unleashed Storm", "=ds=#s2#" },
				{ 17, 86162, "", "=q4=Ring of the Bladed Tempest", "=ds=#s13#" },
				{ 19, 86171, "", "=q4=Tornado-Summoning Censer", "=ds=#s15#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 86961, "", "=q4=Drape of Gathering Clouds", "=ds=#s4#" },
				{ 2, 86958, "", "=q4=Twisting Wind Bracers", "=ds=#s8#, #a1#" },
				{ 3, 86959, "", "=q4=Boots of the Blowing Wind", "=ds=#s12#, #a1#" },
				{ 4, 89922, "", "=q4=Hood of Stilled Winds", "=ds=#s1#, #a2#" },
				{ 5, 86954, "", "=q4=Bracers of Unseen Strikes", "=ds=#s8#, #a2#" },
				{ 6, 86962, "", "=q4=Bracers of Tempestuous Fury", "=ds=#s8#, #a3#" },
				{ 7, 90740, "", "=q4=Kaz'tik's Stormseizer Gauntlets", "=ds=#s9#, #a3#" },
				{ 8, 89920, "", "=q4=Sword Dancer's Leggings", "=ds=#s11#, #a3#" },
				{ 9, 89921, "", "=q4=Pauldrons of the Broken Blade", "=ds=#s3#, #a4#" },
				{ 10, 86956, "", "=q4=Windblade Talons", "=ds=#s9#, #a4#" },
				{ 11, 86955, "", "=q4=Waistplate of Overwhelming Assault", "=ds=#s10#, #a4#" },
				{ 16, 86953, "", "=q4=Choker of the Unleashed Storm", "=ds=#s2#" },
				{ 17, 86957, "", "=q4=Ring of the Bladed Tempest", "=ds=#s13#" },
				{ 19, 86960, "", "=q4=Tornado-Summoning Censer", "=ds=#s15#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Blade Lord Ta'yak", 744),
			module = moduleName, instance = "HeartofFear",
		};
	};

	AtlasLoot_Data["HoFGaralon"] = {
		["RaidFinder"] = {
			{
				{ 1, 86831, "", "=q4=Legbreaker Greatcloak", "=ds=#s4#" },
				{ 2, 86840, "", "=q4=Stormwake Mistcloak", "=ds=#s4#" },
				{ 3, 86839, "", "=q4=Xaril's Hood of Intoxicating Vapors", "=ds=#s1#, #a1#" },
				{ 4, 89959, "", "=q4=Shoulders of Foaming Fluids", "=ds=#s3#, #a1#" },
				{ 5, 86836, "", "=q4=Sandals of the Unbidden", "=ds=#s12#, #a1#" },
				{ 6, 86838, "", "=q4=Robes of Eighty Lights", "=ds=#s5#, #a2#" },
				{ 7, 86834, "", "=q4=Bonebreaker Gauntlets", "=ds=#s9#, #a2#" },
				{ 8, 89960, "", "=q4=Vestments of Steaming Ichor", "=ds=#s5#, #a3#" },
				{ 9, 86833, "", "=q4=Grips of the Leviathan", "=ds=#s9#, #a3#" },
				{ 10, 86832, "", "=q4=Garalon's Hollow Skull", "=ds=#s1#, #a4#" },
				{ 11, 89958, "", "=q4=Garalon's Graven Carapace", "=ds=#s5#, #a4#" },
				{ 12, 86837, "", "=q4=Grasps of Panic", "=ds=#s9#, #a4#" },
				{ 16, 86835, "", "=q4=Necklace of Congealed Weaknesses", "=ds=#s2#" },
				{ 17, 86830, "", "=q4=Ring of the Shattered Shell", "=ds=#s13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86173, "", "=q4=Legbreaker Greatcloak", "=ds=#s4#" },
				{ 2, 86182, "", "=q4=Stormwake Mistcloak", "=ds=#s4#" },
				{ 3, 86181, "", "=q4=Xaril's Hood of Intoxicating Vapors", "=ds=#s1#, #a1#" },
				{ 4, 89833, "", "=q4=Shoulders of Foaming Fluids", "=ds=#s3#, #a1#" },
				{ 5, 86178, "", "=q4=Sandals of the Unbidden", "=ds=#s12#, #a1#" },
				{ 6, 86180, "", "=q4=Robes of Eighty Lights", "=ds=#s5#, #a2#" },
				{ 7, 86176, "", "=q4=Bonebreaker Gauntlets", "=ds=#s9#, #a2#" },
				{ 8, 89834, "", "=q4=Vestments of Steaming Ichor", "=ds=#s5#, #a3#" },
				{ 9, 86175, "", "=q4=Grips of the Leviathan", "=ds=#s9#, #a3#" },
				{ 10, 86174, "", "=q4=Garalon's Hollow Skull", "=ds=#s1#, #a4#" },
				{ 11, 89832, "", "=q4=Garalon's Graven Carapace", "=ds=#s5#, #a4#" },
				{ 12, 86179, "", "=q4=Grasps of Panic", "=ds=#s9#, #a4#" },
				{ 16, 86177, "", "=q4=Necklace of Congealed Weaknesses", "=ds=#s2#" },
				{ 17, 86172, "", "=q4=Ring of the Shattered Shell", "=ds=#s13#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 86963, "", "=q4=Legbreaker Greatcloak", "=ds=#s4#" },
				{ 2, 86971, "", "=q4=Stormwake Mistcloak", "=ds=#s4#" },
				{ 3, 86970, "", "=q4=Xaril's Hood of Intoxicating Vapors", "=ds=#s1#, #a1#" },
				{ 4, 89924, "", "=q4=Shoulders of Foaming Fluids", "=ds=#s3#, #a1#" },
				{ 5, 86969, "", "=q4=Sandals of the Unbidden", "=ds=#s12#, #a1#" },
				{ 6, 86972, "", "=q4=Robes of Eighty Lights", "=ds=#s5#, #a2#" },
				{ 7, 86964, "", "=q4=Bonebreaker Gauntlets", "=ds=#s9#, #a2#" },
				{ 8, 89925, "", "=q4=Vestments of Steaming Ichor", "=ds=#s5#, #a3#" },
				{ 9, 86965, "", "=q4=Grips of the Leviathan", "=ds=#s9#, #a3#" },
				{ 10, 86966, "", "=q4=Garalon's Hollow Skull", "=ds=#s1#, #a4#" },
				{ 11, 89923, "", "=q4=Garalon's Graven Carapace", "=ds=#s5#, #a4#" },
				{ 12, 86973, "", "=q4=Grasps of Panic", "=ds=#s9#, #a4#" },
				{ 16, 86967, "", "=q4=Necklace of Congealed Weaknesses", "=ds=#s2#" },
				{ 17, 86968, "", "=q4=Ring of the Shattered Shell", "=ds=#s13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Garalon", 713),
			module = moduleName, instance = "HeartofFear",
		};
	};

	AtlasLoot_Data["HoFMeljarak"] = {
		["RaidFinder"] = {
			{
				{ 1, 86853, "", "=q4=Cloak of Raining Blades", "=ds=#s4#" },
				{ 2, 86911, "", "=q4=Robes of Torn Nightmares", "=ds=#s5#, #a1#" },
				{ 3, 86912, "", "=q4=Clutches of Dying Hope", "=ds=#s9#, #a2#" },
				{ 4, 86855, "", "=q4=Wingslasher Pauldrons", "=ds=#s3#, #a3#" },
				{ 5, 86852, "", "=q4=Impaling Treads", "=ds=#s12#, #a4#" },
				{ 16, 89271, "", "=q4=Gauntlets of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89272, "", "=q4=Gauntlets of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89270, "", "=q4=Gauntlets of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86856, "", "=q4=Korven's Amber-Sealed Beetle", "=ds=#s2#" },
				{ 21, 86851, "", "=q4=Painful Thorned Ring", "=ds=#s13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86202, "", "=q4=Cloak of Raining Blades", "=ds=#s4#" },
				{ 2, 86513, "", "=q4=Robes of Torn Nightmares", "=ds=#s5#, #a1#" },
				{ 3, 86514, "", "=q4=Clutches of Dying Hope", "=ds=#s9#, #a2#" },
				{ 4, 86204, "", "=q4=Wingslasher Pauldrons", "=ds=#s3#, #a3#" },
				{ 5, 86201, "", "=q4=Impaling Treads", "=ds=#s12#, #a4#" },
				{ 16, 89240, "", "=q4=Gauntlets of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89241, "", "=q4=Gauntlets of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89242, "", "=q4=Gauntlets of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86205, "", "=q4=Korven's Amber-Sealed Beetle", "=ds=#s2#" },
				{ 21, 86200, "", "=q4=Painful Thorned Ring", "=ds=#s13#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 86980, "", "=q4=Cloak of Raining Blades", "=ds=#s4#" },
				{ 2, 86975, "", "=q4=Robes of Torn Nightmares", "=ds=#s5#, #a1#" },
				{ 3, 86977, "", "=q4=Clutches of Dying Hope", "=ds=#s9#, #a2#" },
				{ 4, 86978, "", "=q4=Wingslasher Pauldrons", "=ds=#s3#, #a3#" },
				{ 5, 86979, "", "=q4=Impaling Treads", "=ds=#s12#, #a4#" },
				{ 16, 89256, "", "=q4=Gauntlets of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89257, "", "=q4=Gauntlets of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89255, "", "=q4=Gauntlets of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86976, "", "=q4=Korven's Amber-Sealed Beetle", "=ds=#s2#" },
				{ 21, 86974, "", "=q4=Painful Thorned Ring", "=ds=#s13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741),
			module = moduleName, instance = "HeartofFear",
		};
	};

	AtlasLoot_Data["HoFUnsok"] = {
		["RaidFinder"] = {
			{
				{ 1, 86857, "", "=q4=Belt of Malleable Amber", "=ds=#s10#, #a1#" },
				{ 2, 86859, "", "=q4=Treads of Deadly Secretions", "=ds=#s12#, #a2#" },
				{ 3, 86861, "", "=q4=Monstrous Stompers", "=ds=#s12#, #a3#" },
				{ 4, 86860, "", "=q4=Shoulderpads of Misshapen Life", "=ds=#s3#, #a4#" },
				{ 6, 86858, "", "=q4=Seal of the Profane", "=ds=#s13#" },
				{ 16, 89268, "", "=q4=Leggings of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89269, "", "=q4=Leggings of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89267, "", "=q4=Leggings of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86862, "", "=q4=Un'sok's Amber Scalpel", "=ds=#h1#, #w4#" },
				{ 21, 86863, "", "=q4=Scimitar of Seven Stars", "=ds=#h1#, #w10#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86210, "", "=q4=Belt of Malleable Amber", "=ds=#s10#, #a1#" },
				{ 2, 86212, "", "=q4=Treads of Deadly Secretions", "=ds=#s12#, #a2#" },
				{ 3, 86214, "", "=q4=Monstrous Stompers", "=ds=#s12#, #a3#" },
				{ 4, 86213, "", "=q4=Shoulderpads of Misshapen Life", "=ds=#s3#, #a4#" },
				{ 6, 86211, "", "=q4=Seal of the Profane", "=ds=#s13#" },
				{ 16, 89243, "", "=q4=Leggings of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89244, "", "=q4=Leggings of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89245, "", "=q4=Leggings of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86217, "", "=q4=Un'sok's Amber Scalpel", "=ds=#h1#, #w4#" },
				{ 21, 86219, "", "=q4=Scimitar of Seven Stars", "=ds=#h1#, #w10#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 86981, "", "=q4=Belt of Malleable Amber", "=ds=#s10#, #a1#" },
				{ 2, 86984, "", "=q4=Treads of Deadly Secretions", "=ds=#s12#, #a2#" },
				{ 3, 86985, "", "=q4=Monstrous Stompers", "=ds=#s12#, #a3#" },
				{ 4, 86986, "", "=q4=Shoulderpads of Misshapen Life", "=ds=#s3#, #a4#" },
				{ 6, 86982, "", "=q4=Seal of the Profane", "=ds=#s13#" },
				{ 16, 89253, "", "=q4=Leggings of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89254, "", "=q4=Leggings of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89252, "", "=q4=Leggings of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86983, "", "=q4=Un'sok's Amber Scalpel", "=ds=#h1#, #w4#" },
				{ 21, 86987, "", "=q4=Scimitar of Seven Stars", "=ds=#h1#, #w10#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737),
			module = moduleName, instance = "HeartofFear",
		};
	};

	AtlasLoot_Data["HoFShekzeer"] = {
		["RaidFinder"] = {
			{
				{ 1, 86867, "", "=q4=Leggings of Shadow Infestation", "=ds=#s11#, #a1#" },
				{ 2, 89961, "", "=q4=Shadow Heart Spaulders", "=ds=#s3#, #a2#" },
				{ 3, 86866, "", "=q4=Crown of the Doomed Empress", "=ds=#s1#, #a3#" },
				{ 4, 89962, "", "=q4=Hood of Dark Dreams", "=ds=#s1#, #a3#" },
				{ 5, 89963, "", "=q4=Legplates of Regal Reinforcement", "=ds=#s11#, #a4#" },
				{ 7, 86864, "", "=q4=Claws of Shek'zeer", "=ds=#h1#, #w13#" },
				{ 8, 86865, "", "=q4=Kri'tak, Imperial Scepter of the Swarm", "=ds=#h1#, #w6#" },
				{ 16, 89265, "", "=q4=Chest of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89266, "", "=q4=Chest of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89264, "", "=q4=Chest of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
			};
		};
		["Normal"] = {
			{
				{ 1, 86229, "", "=q4=Leggings of Shadow Infestation", "=ds=#s11#, #a1#" },
				{ 2, 89836, "", "=q4=Shadow Heart Spaulders", "=ds=#s3#, #a2#" },
				{ 3, 86228, "", "=q4=Crown of the Doomed Empress", "=ds=#s1#, #a3#" },
				{ 4, 89835, "", "=q4=Hood of Dark Dreams", "=ds=#s1#, #a3#" },
				{ 5, 89837, "", "=q4=Legplates of Regal Reinforcement", "=ds=#s11#, #a4#" },
				{ 7, 86226, "", "=q4=Claws of Shek'zeer", "=ds=#h1#, #w13#" },
				{ 8, 86227, "", "=q4=Kri'tak, Imperial Scepter of the Swarm", "=ds=#h1#, #w6#" },
				{ 16, 89237, "", "=q4=Chest of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89238, "", "=q4=Chest of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89239, "", "=q4=Chest of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 86989, "", "=q4=Leggings of Shadow Infestation", "=ds=#s11#, #a1#" },
				{ 2, 89926, "", "=q4=Shadow Heart Spaulders", "=ds=#s3#, #a2#" },
				{ 3, 86991, "", "=q4=Crown of the Doomed Empress", "=ds=#s1#, #a3#" },
				{ 4, 89927, "", "=q4=Hood of Dark Dreams", "=ds=#s1#, #a3#" },
				{ 5, 89928, "", "=q4=Legplates of Regal Reinforcement", "=ds=#s11#, #a4#" },
				{ 7, 86988, "", "=q4=Claws of Shek'zeer", "=ds=#h1#, #w13#" },
				{ 8, 86990, "", "=q4=Kri'tak, Imperial Scepter of the Swarm", "=ds=#h1#, #w6#" },
				{ 16, 89250, "", "=q4=Chest of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89251, "", "=q4=Chest of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89249, "", "=q4=Chest of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743),
			module = moduleName, instance = "HeartofFear",
		};
	};

	AtlasLoot_Data["HoFTrash"] = {
		["RaidFinder"] = {
			{
				{ 1, 95619, "", "=q3=Amber Encased Treasure Pouch", "=ds=#m20#" },
				{ 2, 86850, "", "=q4=Darting Damselfly Cuffs", "=ds=#s8#, #a1#" },
				{ 3, 86844, "", "=q4=Gleaming Moth Cuffs", "=ds=#s8#, #a1#" },
				{ 4, 86841, "", "=q4=Shining Cicada Bracers", "=ds=#s8#, #a1#" },
				{ 5, 86845, "", "=q4=Pearlescent Butterfly Wristbands", "=ds=#s8#, #a2#" },
				{ 6, 86843, "", "=q4=Smooth Beetle Wristbands", "=ds=#s8#, #a2#" },
				{ 7, 86847, "", "=q4=Jagged Hornet Bracers", "=ds=#s8#, #a3#" },
				{ 8, 86842, "", "=q4=Luminescent Firefly Wristguards", "=ds=#s8#, #a3#" },
				{ 9, 86846, "", "=q4=Inlaid Cricket Bracers", "=ds=#s8#, #a4#" },
				{ 10, 86849, "", "=q4=Plated Locust Bracers", "=ds=#s8#, #a4#" },
				{ 11, 86848, "", "=q4=Serrated Wasp Bracers", "=ds=#s8#, #a4#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86192, "", "=q4=Darting Damselfly Cuffs", "=ds=#s8#, #a1#" },
				{ 2, 86186, "", "=q4=Gleaming Moth Cuffs", "=ds=#s8#, #a1#" },
				{ 3, 86183, "", "=q4=Shining Cicada Bracers", "=ds=#s8#, #a1#" },
				{ 4, 86187, "", "=q4=Pearlescent Butterfly Wristbands", "=ds=#s8#, #a2#" },
				{ 5, 86185, "", "=q4=Smooth Beetle Wristbands", "=ds=#s8#, #a2#" },
				{ 6, 86189, "", "=q4=Jagged Hornet Bracers", "=ds=#s8#, #a3#" },
				{ 7, 86184, "", "=q4=Luminescent Firefly Wristguards", "=ds=#s8#, #a3#" },
				{ 8, 86188, "", "=q4=Inlaid Cricket Bracers", "=ds=#s8#, #a4#" },
				{ 9, 86191, "", "=q4=Plated Locust Bracers", "=ds=#s8#, #a4#" },
				{ 10, 86190, "", "=q4=Serrated Wasp Bracers", "=ds=#s8#, #a4#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "HeartofFear",
		};
	};

		------------------------
		--- Mogu'Shan Vaults ---
		------------------------

	AtlasLoot_Data["MSVTheStoneGuard"] = {
		["RaidFinder"] = {
			{
				{ 1, 86748, "", "=q4=Cape of Three Lanterns", "=ds=#s4#" },
				{ 2, 89966, "", "=q4=Claws of Amethyst", "=ds=#s9#, #a1#" },
				{ 3, 89965, "", "=q4=Ruby-Linked Girdle", "=ds=#s10#, #a1#" },
				{ 4, 86747, "", "=q4=Jade Dust Leggings", "=ds=#s11#, #a1#" },
				{ 5, 86746, "", "=q4=Stonebound Cinch", "=ds=#s10#, #a2#" },
				{ 6, 86743, "", "=q4=Stoneflesh Leggings", "=ds=#s11#, #a2#" },
				{ 7, 86745, "", "=q4=Sixteen-Fanged Crown", "=ds=#s1#, #a3#" },
				{ 8, 89964, "", "=q4=Stonefang Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 86740, "", "=q4=Stonemaw Armguards", "=ds=#s8#, #a3#" },
				{ 10, 86793, "", "=q4=Star-Stealer Waistguard", "=ds=#s10#, #a4#" },
				{ 11, 86744, "", "=q4=Heavenly Jade Greatboots", "=ds=#s12#, #a4#" },
				{ 12, 86742, "", "=q4=Jasper Clawfeet", "=ds=#s12#, #a4#" },
				{ 16, 86739, "", "=q4=Beads of the Mogu'shi", "=ds=#s2#" },
				{ 18, 86741, "", "=q4=Dagger of the Seven Stars", "=ds=#h1#, #w4#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 85979, "", "=q4=Cape of Three Lanterns", "=ds=#s4#" },
				{ 2, 89768, "", "=q4=Claws of Amethyst", "=ds=#s9#, #a1#" },
				{ 3, 89767, "", "=q4=Ruby-Linked Girdle", "=ds=#s10#, #a1#" },
				{ 4, 85978, "", "=q4=Jade Dust Leggings", "=ds=#s11#, #a1#" },
				{ 5, 85977, "", "=q4=Stonebound Cinch", "=ds=#s10#, #a2#" },
				{ 6, 85926, "", "=q4=Stoneflesh Leggings", "=ds=#s11#, #a2#" },
				{ 7, 85976, "", "=q4=Sixteen-Fanged Crown", "=ds=#s1#, #a3#" },
				{ 8, 89766, "", "=q4=Stonefang Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 85923, "", "=q4=Stonemaw Armguards", "=ds=#s8#, #a3#" },
				{ 10, 86134, "", "=q4=Star-Stealer Waistguard", "=ds=#s10#, #a4#" },
				{ 11, 85975, "", "=q4=Heavenly Jade Greatboots", "=ds=#s12#, #a4#" },
				{ 12, 85925, "", "=q4=Jasper Clawfeet", "=ds=#s12#, #a4#" },
				{ 16, 85922, "", "=q4=Beads of the Mogu'shi", "=ds=#s2#" },
				{ 18, 85924, "", "=q4=Dagger of the Seven Stars", "=ds=#h1#, #w4#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87018, "", "=q4=Cape of Three Lanterns", "=ds=#s4#" },
				{ 2, 89931, "", "=q4=Claws of Amethyst", "=ds=#s9#, #a1#" },
				{ 3, 89930, "", "=q4=Ruby-Linked Girdle", "=ds=#s10#, #a1#" },
				{ 4, 87017, "", "=q4=Jade Dust Leggings", "=ds=#s11#, #a1#" },
				{ 5, 87019, "", "=q4=Stonebound Cinch", "=ds=#s10#, #a2#" },
				{ 6, 87013, "", "=q4=Stoneflesh Leggings", "=ds=#s11#, #a2#" },
				{ 7, 87020, "", "=q4=Sixteen-Fanged Crown", "=ds=#s1#, #a3#" },
				{ 8, 89926, "", "=q4=Stonefang Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 87014, "", "=q4=Stonemaw Armguards", "=ds=#s8#, #a3#" },
				{ 10, 87060, "", "=q4=Star-Stealer Waistguard", "=ds=#s10#, #a4#" },
				{ 11, 87021, "", "=q4=Heavenly Jade Greatboots", "=ds=#s12#, #a4#" },
				{ 12, 87015, "", "=q4=Jasper Clawfeet", "=ds=#s12#, #a4#" },
				{ 16, 87016, "", "=q4=Beads of the Mogu'shi", "=ds=#s2#" },
				{ 18, 87012, "", "=q4=Dagger of the Seven Stars", "=ds=#h1#, #w4#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Stone Guard", 679),
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["MSVFeng"] = {
		["RaidFinder"] = {
			{
				{ 1, 86782, "", "=q4=Arrow Breaking Windcloak", "=ds=#s4#" },
				{ 2, 86753, "", "=q4=Cloak of Peacock Feathers", "=ds=#s4#" },
				{ 3, 86758, "", "=q4=Imperial Ghostbinder's Robes", "=ds=#s5#, #a1#" },
				{ 4, 86757, "", "=q4=Hood of Cursed Dreams", "=ds=#s1#, #a2#" },
				{ 5, 86750, "", "=q4=Tomb Raider's Girdle", "=ds=#s10#, #a2#" },
				{ 6, 86755, "", "=q4=Chain of Shadow", "=ds=#s10#, #a3#" },
				{ 7, 86749, "", "=q4=Wildfire Worldwalkers", "=ds=#s12#, #a3#" },
				{ 8, 86752, "", "=q4=Nullification Greathelm", "=ds=#s1#, #a4#" },
				{ 9, 86751, "", "=q4=Bracers of Six Oxen", "=ds=#s8#, #a4#" },
				{ 10, 86756, "", "=q4=Legplates of Sagacious Shadows", "=ds=#s11#, #a4#" },
				{ 16, 86754, "", "=q4=Amulet of Seven Curses", "=ds=#s2#" },
				{ 17, 89968, "", "=q4=Feng's Ring of Dreams", "=ds=#s13#" },
				{ 18, 89967, "", "=q4=Feng's Seal of Binding", "=ds=#s13#" },
				{ 20, 89426, "", "=q4=Fan of Fiery Winds", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86082, "", "=q4=Arrow Breaking Windcloak", "=ds=#s4#" },
				{ 2, 85985, "", "=q4=Cloak of Peacock Feathers", "=ds=#s4#" },
				{ 3, 85990, "", "=q4=Imperial Ghostbinder's Robes", "=ds=#s5#, #a1#" },
				{ 4, 85989, "", "=q4=Hood of Cursed Dreams", "=ds=#s1#, #a2#" },
				{ 5, 85982, "", "=q4=Tomb Raider's Girdle", "=ds=#s10#, #a2#" },
				{ 6, 85987, "", "=q4=Chain of Shadow", "=ds=#s10#, #a3#" },
				{ 7, 85980, "", "=q4=Wildfire Worldwalkers", "=ds=#s12#, #a3#" },
				{ 8, 85984, "", "=q4=Nullification Greathelm", "=ds=#s1#, #a4#" },
				{ 9, 85983, "", "=q4=Bracers of Six Oxen", "=ds=#s8#, #a4#" },
				{ 10, 85988, "", "=q4=Legplates of Sagacious Shadows", "=ds=#s11#, #a4#" },
				{ 16, 85986, "", "=q4=Amulet of Seven Curses", "=ds=#s2#" },
				{ 17, 89803, "", "=q4=Feng's Ring of Dreams", "=ds=#s13#" },
				{ 18, 89802, "", "=q4=Feng's Seal of Binding", "=ds=#s13#" },
				{ 20, 89424, "", "=q4=Fan of Fiery Winds", "=ds=#s15#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87044, "", "=q4=Arrow Breaking Windcloak", "=ds=#s4#" },
				{ 2, 87026, "", "=q4=Cloak of Peacock Feathers", "=ds=#s4#" },
				{ 3, 87027, "", "=q4=Imperial Ghostbinder's Robes", "=ds=#s5#, #a1#" },
				{ 4, 87029, "", "=q4=Hood of Cursed Dreams", "=ds=#s1#, #a2#" },
				{ 5, 87022, "", "=q4=Tomb Raider's Girdle", "=ds=#s10#, #a2#" },
				{ 6, 87030, "", "=q4=Chain of Shadow", "=ds=#s10#, #a3#" },
				{ 7, 87023, "", "=q4=Wildfire Worldwalkers", "=ds=#s12#, #a3#" },
				{ 8, 87024, "", "=q4=Nullification Greathelm", "=ds=#s1#, #a4#" },
				{ 9, 87025, "", "=q4=Bracers of Six Oxen", "=ds=#s8#, #a4#" },
				{ 10, 87031, "", "=q4=Legplates of Sagacious Shadows", "=ds=#s11#, #a4#" },
				{ 16, 87028, "", "=q4=Amulet of Seven Curses", "=ds=#s2#" },
				{ 17, 89933, "", "=q4=Feng's Ring of Dreams", "=ds=#s13#" },
				{ 18, 89932, "", "=q4=Feng's Seal of Binding", "=ds=#s13#" },
				{ 20, 89425, "", "=q4=Fan of Fiery Winds", "=ds=#s15#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Feng the Accursed", 689),
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["MSVGarajal"] = {
		["RaidFinder"] = {
			{
				{ 1, 86770, "", "=q4=Shadowsummoner Spaulders", "=ds=#s3#, #a1#" },
				{ 2, 86765, "", "=q4=Sandals of the Severed Soul", "=ds=#s12#, #a1#" },
				{ 3, 86763, "", "=q4=Netherrealm Shoulderpads", "=ds=#s3#, #a2#" },
				{ 4, 86768, "", "=q4=Spaulders of the Divided Mind", "=ds=#s3#, #a2#" },
				{ 5, 86761, "", "=q4=Fetters of Death", "=ds=#s10#, #a3#" },
				{ 6, 86769, "", "=q4=Leggings of Imprisoned Will", "=ds=#s11#, #a3#" },
				{ 7, 86766, "", "=q4=Bindings of Ancient Spirits", "=ds=#s8#, #a4#" },
				{ 8, 89969, "", "=q4=Bonded Soul Bracers", "=ds=#s8#, #a4#" },
				{ 9, 86760, "", "=q4=Sollerets of Spirit Splitting", "=ds=#s12#, #a4#" },
				{ 16, 86759, "", "=q4=Soulgrasp Choker", "=ds=#s2#" },
				{ 17, 86767, "", "=q4=Circuit of the Frail Soul", "=ds=#s13#" },
				{ 19, 86762, "", "=q4=Gara'kal, Fist of the Spiritbinder", "=ds=#h1#, #w13#" },
				{ 20, 86764, "", "=q4=Eye of the Ancient Spirit", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86041, "", "=q4=Shadowsummoner Spaulders", "=ds=#s3#, #a1#" },
				{ 2, 85997, "", "=q4=Sandals of the Severed Soul", "=ds=#s12#, #a1#" },
				{ 3, 85995, "", "=q4=Netherrealm Shoulderpads", "=ds=#s3#, #a2#" },
				{ 4, 86039, "", "=q4=Spaulders of the Divided Mind", "=ds=#s3#, #a2#" },
				{ 5, 85993, "", "=q4=Fetters of Death", "=ds=#s10#, #a3#" },
				{ 6, 86040, "", "=q4=Leggings of Imprisoned Will", "=ds=#s11#, #a3#" },
				{ 7, 86027, "", "=q4=Bindings of Ancient Spirits", "=ds=#s8#, #a4#" },
				{ 8, 89817, "", "=q4=Bonded Soul Bracers", "=ds=#s8#, #a4#" },
				{ 9, 85992, "", "=q4=Sollerets of Spirit Splitting", "=ds=#s12#, #a4#" },
				{ 16, 85991, "", "=q4=Soulgrasp Choker", "=ds=#s2#" },
				{ 17, 86038, "", "=q4=Circuit of the Frail Soul", "=ds=#s13#" },
				{ 19, 85994, "", "=q4=Gara'kal, Fist of the Spiritbinder", "=ds=#h1#, #w13#" },
				{ 20, 85996, "", "=q4=Eye of the Ancient Spirit", "=ds=#w8#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87038, "", "=q4=Shadowsummoner Spaulders", "=ds=#s3#, #a1#" },
				{ 2, 87037, "", "=q4=Sandals of the Severed Soul", "=ds=#s12#, #a1#" },
				{ 3, 87033, "", "=q4=Netherrealm Shoulderpads", "=ds=#s3#, #a2#" },
				{ 4, 87041, "", "=q4=Spaulders of the Divided Mind", "=ds=#s3#, #a2#" },
				{ 5, 87034, "", "=q4=Fetters of Death", "=ds=#s10#, #a3#" },
				{ 6, 87042, "", "=q4=Leggings of Imprisoned Will", "=ds=#s11#, #a3#" },
				{ 7, 87043, "", "=q4=Bindings of Ancient Spirits", "=ds=#s8#, #a4#" },
				{ 8, 89934, "", "=q4=Bonded Soul Bracers", "=ds=#s8#, #a4#" },
				{ 9, 87035, "", "=q4=Sollerets of Spirit Splitting", "=ds=#s12#, #a4#" },
				{ 16, 87036, "", "=q4=Soulgrasp Choker", "=ds=#s2#" },
				{ 17, 87040, "", "=q4=Circuit of the Frail Soul", "=ds=#s13#" },
				{ 19, 87032, "", "=q4=Gara'kal, Fist of the Spiritbinder", "=ds=#h1#, #w13#" },
				{ 20, 87039, "", "=q4=Eye of the Ancient Spirit", "=ds=#w8#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Gara'jal the Spiritbinder", 682),
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["MSVSpiritKings"] = {
		["RaidFinder"] = {
			{
				{ 1, 86782, "", "=q4=Arrow Breaking Windcloak", "=ds=#s4#" },
				{ 2, 89971, "", "=q4=Mindshard Drape", "=ds=#s4#" },
				{ 3, 86788, "", "=q4=Hood of Blind Eyes", "=ds=#s1#, #a1#" },
				{ 4, 86787, "", "=q4=Undying Shadow Grips", "=ds=#s9#, #a1#" },
				{ 5, 86786, "", "=q4=Bracers of Dark Thoughts", "=ds=#s8#, #a2#" },
				{ 6, 89970, "", "=q4=Bracers of Violent Meditation", "=ds=#s8#, #a2#" },
				{ 7, 86781, "", "=q4=Subetai's Pillaging Leggings", "=ds=#s11#, #a3#" },
				{ 8, 86784, "", "=q4=Meng's Treads of Insanity", "=ds=#s12#, #a3#" },
				{ 9, 86780, "", "=q4=Shoulderguards of the Unflanked", "=ds=#s3#, #a4#" },
				{ 10, 86779, "", "=q4=Breastplate of the Kings' Guard", "=ds=#s5#, #a4#" },
				{ 11, 86785, "", "=q4=Girdle of Delirious Visions", "=ds=#s10#, #a4#" },
				{ 16, 86776, "", "=q4=Amulet of the Hidden Kings", "=ds=#s2#" },
				{ 17, 86783, "", "=q4=Zian's Choker of Coalesced Shadow", "=ds=#s2#" },
				{ 19, 86777, "", "=q4=Screaming Tiger, Qiang's Unbreakable Polearm", "=ds=#w7#" },
				{ 20, 86778, "", "=q4=Steelskin, Qiang's Impervious Shield", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86082, "", "=q4=Arrow Breaking Windcloak", "=ds=#s4#" },
				{ 2, 89819, "", "=q4=Mindshard Drape", "=ds=#s4#" },
				{ 3, 86129, "", "=q4=Hood of Blind Eyes", "=ds=#s1#, #a1#" },
				{ 4, 86128, "", "=q4=Undying Shadow Grips", "=ds=#s9#, #a1#" },
				{ 5, 86127, "", "=q4=Bracers of Dark Thoughts", "=ds=#s8#, #a2#" },
				{ 6, 89818, "", "=q4=Bracers of Violent Meditation", "=ds=#s8#, #a2#" },
				{ 7, 86081, "", "=q4=Subetai's Pillaging Leggings", "=ds=#s11#, #a3#" },
				{ 8, 86084, "", "=q4=Meng's Treads of Insanity", "=ds=#s12#, #a3#" },
				{ 9, 86080, "", "=q4=Shoulderguards of the Unflanked", "=ds=#s3#, #a4#" },
				{ 10, 86076, "", "=q4=Breastplate of the Kings' Guard", "=ds=#s5#, #a4#" },
				{ 11, 86086, "", "=q4=Girdle of Delirious Visions", "=ds=#s10#, #a4#" },
				{ 16, 86047, "", "=q4=Amulet of the Hidden Kings", "=ds=#s2#" },
				{ 17, 86083, "", "=q4=Zian's Choker of Coalesced Shadow", "=ds=#s2#" },
				{ 19, 86071, "", "=q4=Screaming Tiger, Qiang's Unbreakable Polearm", "=ds=#w7#" },
				{ 20, 86075, "", "=q4=Steelskin, Qiang's Impervious Shield", "=ds=#w8#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87044, "", "=q4=Arrow Breaking Windcloak", "=ds=#s4#" },
				{ 2, 89936, "", "=q4=Mindshard Drape", "=ds=#s4#" },
				{ 3, 87051, "", "=q4=Hood of Blind Eyes", "=ds=#s1#, #a1#" },
				{ 4, 87052, "", "=q4=Undying Shadow Grips", "=ds=#s9#, #a1#" },
				{ 5, 87054, "", "=q4=Bracers of Dark Thoughts", "=ds=#s8#, #a2#" },
				{ 6, 89935, "", "=q4=Bracers of Violent Meditation", "=ds=#s8#, #a2#" },
				{ 7, 87047, "", "=q4=Subetai's Pillaging Leggings", "=ds=#s11#, #a3#" },
				{ 8, 87055, "", "=q4=Meng's Treads of Insanity", "=ds=#s12#, #a3#" },
				{ 9, 87049, "", "=q4=Shoulderguards of the Unflanked", "=ds=#s3#, #a4#" },
				{ 10, 87048, "", "=q4=Breastplate of the Kings' Guard", "=ds=#s5#, #a4#" },
				{ 11, 87056, "", "=q4=Girdle of Delirious Visions", "=ds=#s10#, #a4#" },
				{ 16, 87045, "", "=q4=Amulet of the Hidden Kings", "=ds=#s2#" },
				{ 17, 87053, "", "=q4=Zian's Choker of Coalesced Shadow", "=ds=#s2#" },
				{ 19, 87046, "", "=q4=Screaming Tiger, Qiang's Unbreakable Polearm", "=ds=#w7#" },
				{ 20, 87050, "", "=q4=Steelskin, Qiang's Impervious Shield", "=ds=#w8#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Spirit Kings", 687),
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["MSVElegon"] = {
		["RaidFinder"] = {
			{
				{ 1, 89973, "", "=q4=Galaxyfire Girdle", "=ds=#s10#, #a1#" },
				{ 2, 86798, "", "=q4=Orbital Belt", "=ds=#s10#, #a1#" },
				{ 3, 86795, "", "=q4=Chestguard of Total Annihilation", "=ds=#s5#, #a2#" },
				{ 4, 86797, "", "=q4=Phasewalker Striders", "=ds=#s12#, #a2#" },
				{ 5, 86800, "", "=q4=Shoulders of Empyreal Focus", "=ds=#s3#, #a3#" },
				{ 6, 89974, "", "=q4=Crown of Keening Stars", "=ds=#s1#, #a4#" },
				{ 7, 86794, "", "=q4=Starcrusher Gauntlets", "=ds=#s9#, #a4#" },
				{ 16, 89972, "", "=q4=Band of Bursting Novas", "=ds=#s13#" },
				{ 17, 86791, "", "=q4=Bottle of Infinite Stars", "=ds=#s14#" },
				{ 18, 86792, "", "=q4=Light of the Cosmos", "=ds=#s14#" },
				{ 19, 86790, "", "=q4=Vial of Dragon's Blood", "=ds=#s14#" },
				{ 21, 86789, "", "=q4=Elegion, the Fanged Crescent", "=ds=#h1#, #w1#" },
				{ 22, 86799, "", "=q4=Starshatter", "=ds=#h2#, #w10#" },
				{ 23, 86796, "", "=q4=Torch of the Celestial Spark", "=ds=#w12#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 89822, "", "=q4=Galaxyfire Girdle", "=ds=#s10#, #a1#" },
				{ 2, 86139, "", "=q4=Orbital Belt", "=ds=#s10#, #a1#" },
				{ 3, 86136, "", "=q4=Chestguard of Total Annihilation", "=ds=#s5#, #a2#" },
				{ 4, 86138, "", "=q4=Phasewalker Striders", "=ds=#s12#, #a2#" },
				{ 5, 86141, "", "=q4=Shoulders of Empyreal Focus", "=ds=#s3#, #a3#" },
				{ 6, 89821, "", "=q4=Crown of Keening Stars", "=ds=#s1#, #a4#" },
				{ 7, 86135, "", "=q4=Starcrusher Gauntlets", "=ds=#s9#, #a4#" },
				{ 9, 87777, "", "=q4=Reins of the Astral Cloud Serpent", "=ds=#e27#", ""};
				{ 16, 89824, "", "=q4=Band of Bursting Novas", "=ds=#s13#" },
				{ 17, 86132, "", "=q4=Bottle of Infinite Stars", "=ds=#s14#" },
				{ 18, 86133, "", "=q4=Light of the Cosmos", "=ds=#s14#" },
				{ 19, 86131, "", "=q4=Vial of Dragon's Blood", "=ds=#s14#" },
				{ 21, 86130, "", "=q4=Elegion, the Fanged Crescent", "=ds=#h1#, #w1#" },
				{ 22, 86140, "", "=q4=Starshatter", "=ds=#h2#, #w10#" },
				{ 23, 86137, "", "=q4=Torch of the Celestial Spark", "=ds=#w12#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 89938, "", "=q4=Galaxyfire Girdle", "=ds=#s10#, #a1#" },
				{ 2, 87064, "", "=q4=Orbital Belt", "=ds=#s10#, #a1#" },
				{ 3, 87058, "", "=q4=Chestguard of Total Annihilation", "=ds=#s5#, #a2#" },
				{ 4, 87067, "", "=q4=Phasewalker Striders", "=ds=#s12#, #a2#" },
				{ 5, 87068, "", "=q4=Shoulders of Empyreal Focus", "=ds=#s3#, #a3#" },
				{ 6, 89939, "", "=q4=Crown of Keening Stars", "=ds=#s1#, #a4#" },
				{ 7, 87059, "", "=q4=Starcrusher Gauntlets", "=ds=#s9#, #a4#" },
				{ 9, 87777, "", "=q4=Reins of the Astral Cloud Serpent", "=ds=#e27#", ""};
				{ 16, 89937, "", "=q4=Band of Bursting Novas", "=ds=#s13#" },
				{ 17, 87057, "", "=q4=Bottle of Infinite Stars", "=ds=#s14#" },
				{ 18, 87065, "", "=q4=Light of the Cosmos", "=ds=#s14#" },
				{ 19, 87063, "", "=q4=Vial of Dragon's Blood", "=ds=#s14#" },
				{ 21, 87062, "", "=q4=Elegion, the Fanged Crescent", "=ds=#h1#, #w1#" },
				{ 22, 87061, "", "=q4=Starshatter", "=ds=#h2#, #w10#" },
				{ 23, 87066, "", "=q4=Torch of the Celestial Spark", "=ds=#w12#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Elegon", 726),
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["MSVWilloftheEmperor"] = {
		["RaidFinder"] = {
			{
				{ 1, 86809, "", "=q4=Hood of Focused Energy", "=ds=#s1#, #a1#" },
				{ 2, 86804, "", "=q4=Crown of Opportunistic Strikes", "=ds=#s1#, #a2#" },
				{ 3, 86808, "", "=q4=Magnetized Leggings", "=ds=#s11#, #a2#" },
				{ 4, 89975, "", "=q4=Dreadeye Gaze", "=ds=#s1#, #a3#" },
				{ 5, 89977, "", "=q4=Enameled Grips of Solemnity", "=ds=#s9#, #a3#" },
				{ 6, 87826, "", "=q4=Grips of Terra Cotta", "=ds=#s9#, #a3#" },
				{ 7, 86807, "", "=q4=Spaulders of the Emperor's Rage", "=ds=#s3#, #a4#" },
				{ 8, 89976, "", "=q4=Chestguard of Eternal Vigilance", "=ds=#s5#, #a4#" },
				{ 9, 86803, "", "=q4=Jang-xi's Devastating Legplates", "=ds=#s11#, #a4#" },
				{ 16, 86810, "", "=q4=Worldwaker Cachabon", "=ds=#s2#" },
				{ 17, 86802, "", "=q4=Lei Shin's Final Orders", "=ds=#s14#" },
				{ 18, 86805, "", "=q4=Qin-xi's Polarizing Seal", "=ds=#s14#" },
				{ 20, 86806, "", "=q4=Tihan, Scepter of the Sleeping Emperor", "=ds=#h1#, #w6#" },
				{ 21, 86801, "", "=q4=Fang Kung, Spark of Titans", "=ds=#w2#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86151, "", "=q4=Hood of Focused Energy", "=ds=#s1#, #a1#" },
				{ 2, 86146, "", "=q4=Crown of Opportunistic Strikes", "=ds=#s1#, #a2#" },
				{ 3, 86150, "", "=q4=Magnetized Leggings", "=ds=#s11#, #a2#" },
				{ 4, 89820, "", "=q4=Dreadeye Gaze", "=ds=#s1#, #a3#" },
				{ 5, 89825, "", "=q4=Enameled Grips of Solemnity", "=ds=#s9#, #a3#" },
				{ 6, 87827, "", "=q4=Grips of Terra Cotta", "=ds=#s9#, #a3#" },
				{ 7, 86149, "", "=q4=Spaulders of the Emperor's Rage", "=ds=#s3#, #a4#" },
				{ 8, 89823, "", "=q4=Chestguard of Eternal Vigilance", "=ds=#s5#, #a4#" },
				{ 9, 86145, "", "=q4=Jang-xi's Devastating Legplates", "=ds=#s11#, #a4#" },
				{ 16, 86152, "", "=q4=Worldwaker Cachabon", "=ds=#s2#" },
				{ 17, 86144, "", "=q4=Lei Shin's Final Orders", "=ds=#s14#" },
				{ 18, 86147, "", "=q4=Qin-xi's Polarizing Seal", "=ds=#s14#" },
				{ 20, 86148, "", "=q4=Tihan, Scepter of the Sleeping Emperor", "=ds=#h1#, #w6#" },
				{ 21, 86142, "", "=q4=Fang Kung, Spark of Titans", "=ds=#w2#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87073, "", "=q4=Hood of Focused Energy", "=ds=#s1#, #a1#" },
				{ 2, 87070, "", "=q4=Crown of Opportunistic Strikes", "=ds=#s1#, #a2#" },
				{ 3, 87077, "", "=q4=Magnetized Leggings", "=ds=#s11#, #a2#" },
				{ 4, 89940, "", "=q4=Dreadeye Gaze", "=ds=#s1#, #a3#" },
				{ 5, 89942, "", "=q4=Enameled Grips of Solemnity", "=ds=#s9#, #a3#" },
				{ 6, 87825, "", "=q4=Grips of Terra Cotta", "=ds=#s9#, #a3#" },
				{ 7, 87078, "", "=q4=Spaulders of the Emperor's Rage", "=ds=#s3#, #a4#" },
				{ 8, 89941, "", "=q4=Chestguard of Eternal Vigilance", "=ds=#s5#, #a4#" },
				{ 9, 87071, "", "=q4=Jang-xi's Devastating Legplates", "=ds=#s11#, #a4#" },
				{ 16, 87076, "", "=q4=Worldwaker Cachabon", "=ds=#s2#" },
				{ 17, 87072, "", "=q4=Lei Shin's Final Orders", "=ds=#s14#" },
				{ 18, 87075, "", "=q4=Qin-xi's Polarizing Seal", "=ds=#s14#" },
				{ 20, 87074, "", "=q4=Tihan, Scepter of the Sleeping Emperor", "=ds=#h1#, #w6#" },
				{ 21, 87069, "", "=q4=Fang Kung, Spark of Titans", "=ds=#w2#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Will of the Emperor", 677),
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["MoguShanVaultsTrash"] = {
		["RaidFinder"] = {
			{
				{ 1, 95618, "", "=q3=Cache of Mogu Riches", "=ds=#m20#" },
				{ 2, 86772, "", "=q4=Jade Bandit Figurine", "=ds=#s14#" },
				{ 3, 86771, "", "=q4=Jade Charioteer Figurine", "=ds=#s14#" },
				{ 4, 86774, "", "=q4=Jade Courtesan Figurine", "=ds=#s14#" },
				{ 5, 86773, "", "=q4=Jade Magistrate Figurine", "=ds=#s14#" },
				{ 6, 86775, "", "=q4=Jade Warlord Figurine", "=ds=#s14#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86043, "", "=q4=Jade Bandit Figurine", "=ds=#s14#" },
				{ 2, 86042, "", "=q4=Jade Charioteer Figurine", "=ds=#s14#" },
				{ 3, 86045, "", "=q4=Jade Courtesan Figurine", "=ds=#s14#" },
				{ 4, 86044, "", "=q4=Jade Magistrate Figurine", "=ds=#s14#" },
				{ 5, 86046, "", "=q4=Jade Warlord Figurine", "=ds=#s14#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "MoguShanVaults",
		};
	};

	AtlasLoot_Data["Patternsilvl496"] = {
		["Normal"] = {
			{
				{ 1, 86381, "", "=q4=Pattern: Legacy of the Emperor", "=ds=#p8# (600)"};
				{ 2, 86379, "", "=q4=Pattern: Robe of Eternal Rule", "=ds=#p8# (600)"};
				{ 3, 86380, "", "=q4=Pattern: Imperial Silk Gloves", "=ds=#p8# (600)"};
				{ 4, 86382, "", "=q4=Pattern: Touch of the Light", "=ds=#p8# (600)"};
				{ 6, 86238, "", "=q4=Pattern: Chestguard of Nemeses", "=ds=#p7# (600)"};
				{ 7, 86281, "", "=q4=Pattern: Nightfire Robe", "=ds=#p7# (600)"};
				{ 8, 86279, "", "=q4=Pattern: Liferuned Leather Gloves", "=ds=#p7# (600)"};
				{ 9, 86280, "", "=q4=Pattern: Murderer's Gloves", "=ds=#p7# (600)"};
				{ 10, 86283, "", "=q4=Pattern: Raiment of Blood and Bone", "=ds=#p7# (600)"};
				{ 11, 86297, "", "=q4=Pattern: Stormbreaker Chestguard", "=ds=#p7# (600)"};
				{ 12, 86272, "", "=q4=Pattern: Fists of Lightning", "=ds=#p7# (600)"};
				{ 13, 86284, "", "=q4=Pattern: Raven Lord's Gloves", "=ds=#p7# (600)"};
				{ 16, 87412, "", "=q4=Plans: Chestplate of Limitless Faith", "=ds=#p2# (600)"};
				{ 17, 87410, "", "=q4=Plans: Ornate Battleplate of the Master", "=ds=#p2# (600)"};
				{ 18, 87408, "", "=q4=Plans: Unyielding Bloodplate", "=ds=#p2# (600)"};
				{ 19, 87411, "", "=q4=Plans: Bloodforged Warfists", "=ds=#p2# (600)"};
				{ 20, 87409, "", "=q4=Plans: Gauntlets of Battle Command", "=ds=#p2# (600)"};
				{ 21, 87413, "", "=q4=Plans: Gauntlets of Unbound Devotion", "=ds=#p2# (600)"};
			};
		};
		info = {
			name = AL["Patterns/Plans"].." ("..string.format(AL["ilvl %d"], 496)..")",
			module = moduleName,
		};
	};

		-----------------------------
		--- Pandaria World Bosses ---
		-----------------------------

	AtlasLoot_Data["AugustCelestialsWorldBosses"] = {
		["Normal_A"] = {
			{
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 102696, "", "=q4=Prideful Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
				{ 18, 102767, "", "=q4=Prideful Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 102739, "", "=q4=Prideful Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
				{ 22, 102654, "", "=q4=Prideful Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 102657, "", "=q4=Prideful Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
				{ 26, 102761, "", "=q4=Prideful Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 17, 102737, "", "=q4=Prideful Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 102670, "", "=q4=Prideful Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 21, 102735, "", "=q4=Prideful Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
				{ 22, 102648, "", "=q4=Prideful Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 102663, "", "=q4=Prideful Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
				{ 26, 102730, "", "=q4=Prideful Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 102725, "", "=q4=Prideful Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
				{ 30, 102755, "", "=q4=Prideful Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 20, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 21, 102627, "", "=q4=Prideful Gladiator's Copperskin Gloves", "=ds=#s9#, #a2#"};
				{ 22, 102762, "", "=q4=Prideful Gladiator's Copperskin Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 25, 102675, "", "=q4=Prideful Gladiator's Ironskin Gloves", "=ds=#s9#, #a2#"};
				{ 26, 102656, "", "=q4=Prideful Gladiator's Ironskin Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 102722, "", "=q4=Prideful Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
				{ 18, 102768, "", "=q4=Prideful Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 102630, "", "=q4=Prideful Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
				{ 22, 102780, "", "=q4=Prideful Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 17, 102615, "", "=q4=Prideful Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
				{ 18, 102704, "", "=q4=Prideful Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 21, 102707, "", "=q4=Prideful Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
				{ 22, 102621, "", "=q4=Prideful Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 102692, "", "=q4=Prideful Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 102781, "", "=q4=Prideful Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 102742, "", "=q4=Prideful Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
				{ 22, 102778, "", "=q4=Prideful Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 102774, "", "=q4=Prideful Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
				{ 26, 102719, "", "=q4=Prideful Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 103005, "", "=q4=Prideful Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 18, 102651, "", "=q4=Prideful Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 102618, "", "=q4=Prideful Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
				{ 26, 102732, "", "=q4=Prideful Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 1, 102687, "", "=q4=Prideful Gladiator's Cuffs of Accuracy", "=ds="};
				{ 2, 102662, "", "=q4=Prideful Gladiator's Cord of Accuracy", "=ds="};
				{ 3, 102620, "", "=q4=Prideful Gladiator's Treads of Alacrity", "=ds="};
				{ 5, 102666, "", "=q4=Prideful Gladiator's Cuffs of Meditation", "=ds="};
				{ 6, 102709, "", "=q4=Prideful Gladiator's Cord of Meditation", "=ds="};
				{ 7, 102752, "", "=q4=Prideful Gladiator's Treads of Meditation", "=ds="};
				{ 9, 102733, "", "=q4=Prideful Gladiator's Cuffs of Prowess", "=ds="};
				{ 10, 102684, "", "=q4=Prideful Gladiator's Cord of Cruelty", "=ds="};
				{ 11, 102686, "", "=q4=Prideful Gladiator's Treads of Cruelty", "=ds="};
				{ 16, 102711, "", "=q4=Prideful Gladiator's Armwraps of Accuracy", "=ds="};
				{ 17, 102708, "", "=q4=Prideful Gladiator's Waistband of Accuracy", "=ds="};
				{ 18, 102660, "", "=q4=Prideful Gladiator's Boots of Cruelty", "=ds="};
				{ 20, 102754, "", "=q4=Prideful Gladiator's Armwraps of Alacrity", "=ds="};
				{ 21, 102647, "", "=q4=Prideful Gladiator's Waistband of Cruelty", "=ds="};
				{ 22, 102716, "", "=q4=Prideful Gladiator's Boots of Alacrity", "=ds="};
				{ 24, 102723, "", "=q4=Prideful Gladiator's Bindings of Prowess", "=ds="};
				{ 25, 102694, "", "=q4=Prideful Gladiator's Belt of Cruelty", "=ds="};
				{ 26, 102631, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds="};
				{ 28, 102691, "", "=q4=Prideful Gladiator's Bindings of Meditation", "=ds="};
				{ 29, 102775, "", "=q4=Prideful Gladiator's Belt of Meditation", "=ds="};
				{ 30, 102760, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds="};
				merge = true;
			};
			{
				{ 1, 102624, "", "=q4=Prideful Gladiator's Armbands of Meditation", "=ds="};
				{ 2, 102668, "", "=q4=Prideful Gladiator's Waistguard of Meditation", "=ds="};
				{ 3, 102623, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds="};
				{ 5, 102665, "", "=q4=Prideful Gladiator's Armbands of Prowess", "=ds="};
				{ 6, 102677, "", "=q4=Prideful Gladiator's Waistguard of Cruelty", "=ds="};
				{ 7, 102664, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds="};
				{ 9, 102688, "", "=q4=Prideful Gladiator's Wristguards of Alacrity", "=ds="};
				{ 10, 102617, "", "=q4=Prideful Gladiator's Links of Cruelty", "=ds="};
				{ 11, 102646, "", "=q4=Prideful Gladiator's Sabatons of Alacrity", "=ds="};
				{ 13, 102753, "", "=q4=Prideful Gladiator's Wristguards of Accuracy", "=ds="};
				{ 14, 102645, "", "=q4=Prideful Gladiator's Links of Accuracy", "=ds="};
				{ 15, 102729, "", "=q4=Prideful Gladiator's Sabatons of Cruelty", "=ds="};
				{ 16, 102765, "", "=q4=Prideful Gladiator's Bracers of Meditation", "=ds="};
				{ 17, 102748, "", "=q4=Prideful Gladiator's Clasp of Meditation", "=ds="};
				{ 18, 102639, "", "=q4=Prideful Gladiator's Greaves of Meditation", "=ds="};
				{ 20, 102702, "", "=q4=Prideful Gladiator's Armplates of Proficiency", "=ds="};
				{ 21, 102640, "", "=q4=Prideful Gladiator's Girdle of Accuracy", "=ds="};
				{ 22, 102698, "", "=q4=Prideful Gladiator's Warboots of Cruelty", "=ds="};
				{ 24, 102695, "", "=q4=Prideful Gladiator's Bracers of Prowess", "=ds="};
				{ 25, 102764, "", "=q4=Prideful Gladiator's Clasp of Cruelty", "=ds="};
				{ 26, 102638, "", "=q4=Prideful Gladiator's Greaves of Alacrity", "=ds="};
				{ 28, 102771, "", "=q4=Prideful Gladiator's Armplates of Alacrity", "=ds="};
				{ 29, 102724, "", "=q4=Prideful Gladiator's Girdle of Prowess", "=ds="};
				{ 30, 102745, "", "=q4=Prideful Gladiator's Warboots of Alacrity", "=ds="};
				merge = true;
			};
			{
				{ 1, 102705, "", "=q4=Prideful Gladiator's Cape of Cruelty", "=ds=#s4#" },
				{ 2, 102642, "", "=q4=Prideful Gladiator's Cape of Prowess", "=ds=#s4#" },
				{ 3, 102769, "", "=q4=Prideful Gladiator's Cloak of Alacrity", "=ds=#s4#" },
				{ 4, 102770, "", "=q4=Prideful Gladiator's Cloak of Prowess", "=ds=#s4#" },
				{ 5, 102669, "", "=q4=Prideful Gladiator's Drape of Cruelty", "=ds=#s4#"},
				{ 6, 102756, "", "=q4=Prideful Gladiator's Drape of Meditation", "=ds=#s4#" },
				{ 7, 102772, "", "=q4=Prideful Gladiator's Drape of Prowess", "=ds=#s4#" },
				{ 9, 102649, "", "=q4=Prideful Gladiator's Band of Accuracy", "=ds=#s13#" };
				{ 10, 102674, "", "=q4=Prideful Gladiator's Band of Cruelty", "=ds=#s13#" };
				{ 11, 102758, "", "=q4=Prideful Gladiator's Band of Meditation", "=ds=#s13#" };
				{ 12, 102683, "", "=q4=Prideful Gladiator's Ring of Accuracy", "=ds=#s13#" };
				{ 13, 102644, "", "=q4=Prideful Gladiator's Ring of Cruelty", "=ds=#s13#" };
				{ 14, 102746, "", "=q4=Prideful Gladiator's Signet of Accuracy", "=ds=#s13#" };
				{ 15, 102701, "", "=q4=Prideful Gladiator's Signet of Cruelty", "=ds=#s13#" };
				{ 16, 102641, "", "=q4=Prideful Gladiator's Choker of Accuracy", "=ds=#s2#" },
				{ 17, 102749, "", "=q4=Prideful Gladiator's Choker of Proficiency", "=ds=#s2#" },
				{ 18, 102678, "", "=q4=Prideful Gladiator's Necklace of Proficiency", "=ds=#s2#" },
				{ 19, 102679, "", "=q4=Prideful Gladiator's Necklace of Prowess", "=ds=#s2#" },
				{ 20, 102757, "", "=q4=Prideful Gladiator's Pendant of Alacrity", "=ds=#s2#" },
				{ 21, 102773, "", "=q4=Prideful Gladiator's Pendant of Cruelty", "=ds=#s2#" },
				{ 22, 102736, "", "=q4=Prideful Gladiator's Pendant of Meditation", "=ds=#s2#" },
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 103398, "", "=q4=Prideful Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
				{ 18, 103400, "", "=q4=Prideful Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 103381, "", "=q4=Prideful Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
				{ 22, 103383, "", "=q4=Prideful Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 103389, "", "=q4=Prideful Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
				{ 26, 103391, "", "=q4=Prideful Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 17, 103417, "", "=q4=Prideful Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 103419, "", "=q4=Prideful Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 21, 103421, "", "=q4=Prideful Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
				{ 22, 103423, "", "=q4=Prideful Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 103476, "", "=q4=Prideful Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
				{ 26, 103478, "", "=q4=Prideful Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 103520, "", "=q4=Prideful Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
				{ 30, 103522, "", "=q4=Prideful Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 20, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 21, 103434, "", "=q4=Prideful Gladiator's Copperskin Gloves", "=ds=#s9#, #a2#"};
				{ 22, 103436, "", "=q4=Prideful Gladiator's Copperskin Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 25, 103429, "", "=q4=Prideful Gladiator's Ironskin Gloves", "=ds=#s9#, #a2#"};
				{ 26, 103431, "", "=q4=Prideful Gladiator's Ironskin Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 103451, "", "=q4=Prideful Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
				{ 18, 103453, "", "=q4=Prideful Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 103440, "", "=q4=Prideful Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
				{ 22, 103442, "", "=q4=Prideful Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 17, 103462, "", "=q4=Prideful Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
				{ 18, 103464, "", "=q4=Prideful Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 21, 103467, "", "=q4=Prideful Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
				{ 22, 103469, "", "=q4=Prideful Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 103497, "", "=q4=Prideful Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 103499, "", "=q4=Prideful Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 103491, "", "=q4=Prideful Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
				{ 22, 103493, "", "=q4=Prideful Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 103486, "", "=q4=Prideful Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
				{ 26, 103488, "", "=q4=Prideful Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 103377, "", "=q4=Prideful Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 18, 103379, "", "=q4=Prideful Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 103526, "", "=q4=Prideful Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
				{ 26, 103528, "", "=q4=Prideful Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 1, 103357, "", "=q4=Prideful Gladiator's Cuffs of Accuracy", "=ds="};
				{ 2, 103352, "", "=q4=Prideful Gladiator's Cord of Accuracy", "=ds="};
				{ 3, 103355, "", "=q4=Prideful Gladiator's Treads of Alacrity", "=ds="};
				{ 5, 103359, "", "=q4=Prideful Gladiator's Cuffs of Meditation", "=ds="};
				{ 6, 103353, "", "=q4=Prideful Gladiator's Cord of Meditation", "=ds="};
				{ 7, 103356, "", "=q4=Prideful Gladiator's Treads of Meditation", "=ds="};
				{ 9, 103358, "", "=q4=Prideful Gladiator's Cuffs of Prowess", "=ds="};
				{ 10, 103351, "", "=q4=Prideful Gladiator's Cord of Cruelty", "=ds="};
				{ 11, 103354, "", "=q4=Prideful Gladiator's Treads of Cruelty", "=ds="};
				{ 16, 103428, "", "=q4=Prideful Gladiator's Armwraps of Accuracy", "=ds="};
				{ 17, 103472, "", "=q4=Prideful Gladiator's Waistband of Accuracy", "=ds="};
				{ 18, 103473, "", "=q4=Prideful Gladiator's Boots of Cruelty", "=ds="};
				{ 20, 103474, "", "=q4=Prideful Gladiator's Armwraps of Alacrity", "=ds="};
				{ 21, 103426, "", "=q4=Prideful Gladiator's Waistband of Cruelty", "=ds="};
				{ 22, 103427, "", "=q4=Prideful Gladiator's Boots of Alacrity", "=ds="};
				{ 24, 103397, "", "=q4=Prideful Gladiator's Bindings of Prowess", "=ds="};
				{ 25, 103395, "", "=q4=Prideful Gladiator's Belt of Cruelty", "=ds="};
				{ 26, 103396, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds="};
				{ 28, 103388, "", "=q4=Prideful Gladiator's Bindings of Meditation", "=ds="};
				{ 29, 103386, "", "=q4=Prideful Gladiator's Belt of Meditation", "=ds="};
				{ 30, 102623, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds="};
				merge = true;
			};
			{
				{ 1, 103484, "", "=q4=Prideful Gladiator's Armbands of Meditation", "=ds="};
				{ 2, 103480, "", "=q4=Prideful Gladiator's Waistguard of Meditation", "=ds="};
				{ 3, 103482, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds="};
				{ 5, 103483, "", "=q4=Prideful Gladiator's Armbands of Prowess", "=ds="};
				{ 6, 103495, "", "=q4=Prideful  Gladiator's Waistguard of Cruelty", "=ds="};
				{ 7, 103481, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds="};
				{ 9, 103414, "", "=q4=Prideful Gladiator's Wristguards of Alacrity", "=ds="};
				{ 10, 103410, "", "=q4=Prideful Gladiator's Links of Cruelty", "=ds="};
				{ 11, 103413, "", "=q4=Prideful Gladiator's Sabatons of Alacrity", "=ds="};
				{ 13, 103415, "", "=q4=Prideful Gladiator's Wristguards of Accuracy", "=ds="};
				{ 14, 103411, "", "=q4=Prideful Gladiator's Links of Accuracy", "=ds="};
				{ 15, 103412, "", "=q4=Prideful Gladiator's Sabatons of Cruelty", "=ds="};
				{ 16, 103449, "", "=q4=Prideful Gladiator's Bracers of Meditation", "=ds="};
				{ 17, 103445, "", "=q4=Prideful Gladiator's Clasp of Meditation", "=ds="};
				{ 18, 103447, "", "=q4=Prideful Gladiator's Greaves of Meditation", "=ds="};
				{ 20, 103459, "", "=q4=Prideful Gladiator's Armplates of Proficiency", "=ds="};
				{ 21, 103455, "", "=q4=Prideful Gladiator's Girdle of Accuracy", "=ds="};
				{ 22, 103457, "", "=q4=Prideful Gladiator's Warboots of Cruelty", "=ds="};
				{ 24, 103448, "", "=q4=Prideful Gladiator's Bracers of Prowess", "=ds="};
				{ 25, 103444, "", "=q4=Prideful Gladiator's Clasp of Cruelty", "=ds="};
				{ 26, 103446, "", "=q4=Prideful Gladiator's Greaves of Alacrity", "=ds="};
				{ 28, 103460, "", "=q4=Prideful Gladiator's Armplates of Alacrity", "=ds="};
				{ 29, 103456, "", "=q4=Prideful Gladiator's Girdle of Prowess", "=ds="};
				{ 30, 103458, "", "=q4=Prideful Gladiator's Warboots of Alacrity", "=ds="};
				merge = true;
			};
			{
				{ 1, 103343, "", "=q4=Prideful Gladiator's Cape of Cruelty", "=ds=#s4#" },
				{ 2, 103344, "", "=q4=Prideful Gladiator's Cape of Prowess", "=ds=#s4#" },
				{ 3, 103512, "", "=q4=Prideful Gladiator's Cloak of Alacrity", "=ds=#s4#" },
				{ 4, 103513, "", "=q4=Prideful Gladiator's Cloak of Prowess", "=ds=#s4#" },
				{ 5, 103360, "", "=q4=Prideful Gladiator's Drape of Cruelty", "=ds=#s4#"},
				{ 6, 103362, "", "=q4=Prideful Gladiator's Drape of Meditation", "=ds=#s4#" },
				{ 7, 103361, "", "=q4=Prideful Gladiator's Drape of Prowess", "=ds=#s4#" },
				{ 9, 103371, "", "=q4=Prideful Gladiator's Band of Accuracy", "=ds=#s13#" };
				{ 10, 103370, "", "=q4=Prideful Gladiator's Band of Cruelty", "=ds=#s13#" };
				{ 11, 103372, "", "=q4=Prideful Gladiator's Band of Meditation", "=ds=#s13#" };
				{ 12, 103349, "", "=q4=Prideful Gladiator's Ring of Accuracy", "=ds=#s13#" };
				{ 13, 103348, "", "=q4=Prideful Gladiator's Ring of Cruelty", "=ds=#s13#" };
				{ 14, 103518, "", "=q4=Prideful Gladiator's Signet of Accuracy", "=ds=#s13#" };
				{ 15, 103517, "", "=q4=Prideful Gladiator's Signet of Cruelty", "=ds=#s13#" };
				{ 16, 103515, "", "=q4=Prideful Gladiator's Choker of Accuracy", "=ds=#s2#" },
				{ 17, 103514, "", "=q4=Prideful Gladiator's Choker of Proficiency", "=ds=#s2#" },
				{ 18, 103345, "", "=q4=Prideful Gladiator's Necklace of Proficiency", "=ds=#s2#" },
				{ 19, 103346, "", "=q4=Prideful Gladiator's Necklace of Prowess", "=ds=#s2#" },
				{ 20, 103368, "", "=q4=Prideful Gladiator's Pendant of Alacrity", "=ds=#s2#" },
				{ 21, 103367, "", "=q4=Prideful Gladiator's Pendant of Cruelty", "=ds=#s2#" },
				{ 22, 103369, "", "=q4=Prideful Gladiator's Pendant of Meditation", "=ds=#s2#" },
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 2, 99174, "", "=q4=Gloves of the Shattered Vale", "=ds=#s9#, #a2#"};
				{ 3, 99176, "", "=q4=Leggings of the Shattered Vale", "=ds=#s11#, #a2#"};
				{ 5, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["DPS"]};
				{ 6, 99181, "", "=q4=Grips of the Shattered Vale", "=ds=#s9#, #a2#"};
				{ 7, 99183, "", "=q4=Legguards of the Shattered Vale", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 10, 99185, "", "=q4=Handwraps of the Shattered Vale", "=ds=#s9#, #a2#"};
				{ 11, 99171, "", "=q4=Legwraps of the Shattered Vale", "=ds=#s11#, #a2#"};
				{ 13, 0, "ability_racial_bearform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Guardian"]};
				{ 14, 99163, "", "=q4=Handguards of the Shattered Vale", "=ds=#s9#, #a2#"};
				{ 15, 99165, "", "=q4=Breeches of the Shattered Vale", "=ds=#s11#, #a2#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["DRUID"];
			};
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 2, 99168, "", "=q4=Gloves of the Unblinking Vigil", "=ds=#s9#, #a3#"};
				{ 3, 99158, "", "=q4=Legguards of the Unblinking Vigil", "=ds=#s11#, #a3#"};
				{ 5, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, 99160, "", "=q4=Chronomancer Gloves", "=ds=#s9#, #a1#"};
				{ 7, 99162, "", "=q4=Chronomancer Leggings", "=ds=#s11#, #a1#"};
				{ 9, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 10, 99113, "", "=q4=Gloves of the Barbed Assassin", "=ds=#s9#, #a2#"};
				{ 11, 99115, "", "=q4=Legguards of the Barbed Assassin", "=ds=#s11#, #a2#"};
				{ 13, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 14, 99096, "", "=q4=Gloves of the Horned Nightmare", "=ds=#s9#, #a1#"};
				{ 15, 99098, "", "=q4=Leggings of the Horned Nightmare", "=ds=#s11#, #a1#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"].." / "..LOCALIZED_CLASS_NAMES_MALE["MAGE"].." / "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"].." / "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"];
			};
			{
				{ 1, 0, "spell_monk_brewmaster_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Brewmaster"]};
				{ 2, 99141, "", "=q4=Gauntlets of Seven Sacred Seals", "=ds=#s9#, #a2#"};
				{ 3, 99143, "", "=q4=Legguards of Seven Sacred Seals", "=ds=#s11#, #a2#"};
				{ 5, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 6, 99147, "", "=q4=Handwraps of Seven Sacred Seals", "=ds=#s9#, #a2#"};
				{ 7, 99149, "", "=q4=Legwraps of Seven Sacred Seals", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 10, 99155, "", "=q4=Grips of Seven Sacred Seals", "=ds=#s9#, #a2#"};
				{ 11, 99145, "", "=q4=Leggings of Seven Sacred Seals", "=ds=#s11#, #a2#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["MONK"];
			};
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 2, 99134, "", "=q4=Gloves of Winged Triumph", "=ds=#s9#, #a4#"};
				{ 3, 99124, "", "=q4=Greaves of Winged Triumph", "=ds=#s11#, #a4#"};
				{ 5, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 6, 99137, "", "=q4=Gauntlets of Winged Triumph", "=ds=#s9#, #a4#"};
				{ 7, 99139, "", "=q4=Legplates of Winged Triumph", "=ds=#s11#, #a4#"};
				{ 9, 0, "spell_holy_devotionaura", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 10, 99127, "", "=q4=Handguards of Winged Triumph", "=ds=#s9#, #a4#"};
				{ 11, 99129, "", "=q4=Legguards of Winged Triumph", "=ds=#s11#, #a4#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"];
			};
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 2, 99131, "", "=q4=Handwraps of the Ternion Glory", "=ds=#s9#, #a1#"};
				{ 3, 99118, "", "=q4=Legwraps of the Ternion Glory", "=ds=#s11#, #a1#"};
				{ 5, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 6, 99121, "", "=q4=Gloves of the Ternion Glory", "=ds=#s9#, #a1#"};
				{ 7, 99123, "", "=q4=Leggings of the Ternion Glory", "=ds=#s11#, #a1#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"];
			};
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 2, 99092, "", "=q4=Gloves of Celestial Harmony", "=ds=#s9#, #a3#"};
				{ 3, 99094, "", "=q4=Kilt of Celestial Harmony", "=ds=#s11#, #a3#"};
				{ 5, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 6, 99102, "", "=q4=Grips of Celestial Harmony", "=ds=#s9#, #a3#"};
				{ 7, 99104, "", "=q4=Legguards of Celestial Harmony", "=ds=#s11#, #a3#"};
				{ 9, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 10, 99108, "", "=q4=Handwraps of Celestial Harmony", "=ds=#s9#, #a3#"};
				{ 11, 99099, "", "=q4=Legwraps of Celestial Harmony", "=ds=#s11#, #a3#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"];
			};
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 2, 99193, "", "=q4=Gauntlets of Cyclopean Dread", "=ds=#s9#, #a4#"};
				{ 3, 99186, "", "=q4=Greaves of Cyclopean Dread", "=ds=#s11#, #a4#"};
				{ 5, 0, "spell_deathknight_bloodpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 6, 99189, "", "=q4=Handguards of Cyclopean Dread", "=ds=#s9#, #a4#"};
				{ 7, 99191, "", "=q4=Legguards of Cyclopean Dread", "=ds=#s11#, #a4#"};
				{ 9, 0, "ability_warrior_innerrage", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 10, 99198, "", "=q4=Gauntlets of the Prehistoric Marauder", "=ds=#s9#, #a4#"};
				{ 11, 99199, "", "=q4=Legplates of the Prehistoric Marauder", "=ds=#s11#, #a4#"};
				{ 13, 0, "ability_warrior_defensivestance", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
				{ 14, 99202, "", "=q4=Handguards of the Prehistoric Marauder", "=ds=#s9#, #a4#"};
				{ 15, 99195, "", "=q4=Legguards of the Prehistoric Marauder", "=ds=#s11#, #a4#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." / "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"];
			};
			{
				extraText = ": "..AL["PvP Non-Set Epics"].." - "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				extraText = ": "..AL["PvP Non-Set Epics"].." - "..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"];
			};
			{
				extraText = ": "..AL["PvP Accessories"];
			};
		};
		info = {
			name = ALIL["The August Celestials"],
			module = moduleName, menu = "AUGUSTCELESTIALSWORLDBOSSES", instance = "Pandaria",
		};
	};

	AtlasLoot_Data["Nalak"] = {
		["Normal_A"] = {
			{
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 91189, "", "=q4=Tyrannical Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
				{ 18, 91193, "", "=q4=Tyrannical Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 91157, "", "=q4=Tyrannical Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
				{ 22, 91161, "", "=q4=Tyrannical Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 91172, "", "=q4=Tyrannical Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
				{ 26, 91176, "", "=q4=Tyrannical Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 17, 91224, "", "=q4=Tyrannical Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 91228, "", "=q4=Tyrannical Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 21, 91232, "", "=q4=Tyrannical Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
				{ 22, 91236, "", "=q4=Tyrannical Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 91342, "", "=q4=Tyrannical Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
				{ 26, 91346, "", "=q4=Tyrannical Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 91420, "", "=q4=Tyrannical Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
				{ 30, 91424, "", "=q4=Tyrannical Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 20, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 21, 91257, "", "=q4=Tyrannical Gladiator's Copperskin Gloves", "=ds=#s9#, #a2#"};
				{ 22, 91261, "", "=q4=Tyrannical Gladiator's Copperskin Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 25, 91247, "", "=q4=Tyrannical Gladiator's Ironskin Gloves", "=ds=#s9#, #a2#"};
				{ 26, 91251, "", "=q4=Tyrannical Gladiator's Ironskin Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 91289, "", "=q4=Tyrannical Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
				{ 18, 91293, "", "=q4=Tyrannical Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 91269, "", "=q4=Tyrannical Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
				{ 22, 91273, "", "=q4=Tyrannical Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 17, 91309, "", "=q4=Tyrannical Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
				{ 18, 91313, "", "=q4=Tyrannical Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 21, 91319, "", "=q4=Tyrannical Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
				{ 22, 91323, "", "=q4=Tyrannical Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 91382, "", "=q4=Tyrannical Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 91386, "", "=q4=Tyrannical Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 91370, "", "=q4=Tyrannical Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
				{ 22, 91374, "", "=q4=Tyrannical Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 91360, "", "=q4=Tyrannical Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
				{ 26, 91364, "", "=q4=Tyrannical Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 91149, "", "=q4=Tyrannical Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 18, 91153, "", "=q4=Tyrannical Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 91432, "", "=q4=Tyrannical Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
				{ 26, 91436, "", "=q4=Tyrannical Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 1, 91121, "", "=q4=Tyrannical Gladiator's Cuffs of Accuracy", "=ds="};
				{ 2, 91111, "", "=q4=Tyrannical Gladiator's Cord of Accuracy", "=ds="};
				{ 3, 91117, "", "=q4=Tyrannical Gladiator's Treads of Alacrity", "=ds="};
				{ 5, 91123, "", "=q4=Tyrannical Gladiator's Cuffs of Meditation", "=ds="};
				{ 6, 91113, "", "=q4=Tyrannical Gladiator's Cord of Meditation", "=ds="};
				{ 7, 91119, "", "=q4=Tyrannical Gladiator's Treads of Meditation", "=ds="};
				{ 9, 91122, "", "=q4=Tyrannical Gladiator's Cuffs of Prowess", "=ds="};
				{ 10, 91109, "", "=q4=Tyrannical Gladiator's Cord of Cruelty", "=ds="};
				{ 11, 91115, "", "=q4=Tyrannical Gladiator's Treads of Cruelty", "=ds="};
				{ 16, 91246, "", "=q4=Tyrannical Gladiator's Armwraps of Accuracy", "=ds="};
				{ 17, 91335, "", "=q4=Tyrannical Gladiator's Waistband of Accuracy", "=ds="};
				{ 18, 91337, "", "=q4=Tyrannical Gladiator's Boots of Cruelty", "=ds="};
				{ 20, 91339, "", "=q4=Tyrannical Gladiator's Armwraps of Alacrity", "=ds="};
				{ 21, 91242, "", "=q4=Tyrannical Gladiator's Waistband of Cruelty", "=ds="};
				{ 22, 91244, "", "=q4=Tyrannical Gladiator's Boots of Alacrity", "=ds="};
				{ 24, 91188, "", "=q4=Tyrannical Gladiator's Bindings of Prowess", "=ds="};
				{ 25, 91184, "", "=q4=Tyrannical Gladiator's Belt of Cruelty", "=ds="};
				{ 26, 91186, "", "=q4=Tyrannical Gladiator's Footguards of Alacrity", "=ds="};
				{ 28, 91171, "", "=q4=Tyrannical Gladiator's Bindings of Meditation", "=ds="};
				{ 29, 91167, "", "=q4=Tyrannical Gladiator's Belt of Meditation", "=ds="};
				{ 30, 91169, "", "=q4=Tyrannical Gladiator's Footguards of Meditation", "=ds="};
				merge = true;
			};
			{
				{ 1, 91357, "", "=q4=Tyrannical Gladiator's Armbands of Meditation", "=ds="};
				{ 2, 91350, "", "=q4=Tyrannical Gladiator's Waistguard of Meditation", "=ds="};
				{ 3, 91354, "", "=q4=Tyrannical Gladiator's Footguards of Meditation", "=ds="};
				{ 5, 91356, "", "=q4=Tyrannical Gladiator's Armbands of Prowess", "=ds="};
				{ 6, 91378, "", "=q4=Tyrannical Gladiator's Waistguard of Cruelty", "=ds="};
				{ 7, 91352, "", "=q4=Tyrannical Gladiator's Footguards of Alacrity", "=ds="};
				{ 9, 91220, "", "=q4=Tyrannical Gladiator's Wristguards of Alacrity", "=ds="};
				{ 10, 91212, "", "=q4=Tyrannical Gladiator's Links of Cruelty", "=ds="};
				{ 11, 91218, "", "=q4=Tyrannical Gladiator's Sabatons of Alacrity", "=ds="};
				{ 13, 91221, "", "=q4=Tyrannical Gladiator's Wristguards of Accuracy", "=ds="};
				{ 14, 91214, "", "=q4=Tyrannical Gladiator's Links of Accuracy", "=ds="};
				{ 15, 91216, "", "=q4=Tyrannical Gladiator's Sabatons of Cruelty", "=ds="};
				{ 16, 91286, "", "=q4=Tyrannical Gladiator's Bracers of Meditation", "=ds="};
				{ 17, 91279, "", "=q4=Tyrannical Gladiator's Clasp of Meditation", "=ds="};
				{ 18, 91283, "", "=q4=Tyrannical Gladiator's Greaves of Meditation", "=ds="};
				{ 20, 91305, "", "=q4=Tyrannical Gladiator's Armplates of Proficiency", "=ds="};
				{ 21, 91297, "", "=q4=Tyrannical Gladiator's Girdle of Accuracy", "=ds="};
				{ 22, 91301, "", "=q4=Tyrannical Gladiator's Warboots of Cruelty", "=ds="};
				{ 24, 91285, "", "=q4=Tyrannical Gladiator's Bracers of Prowess", "=ds="};
				{ 25, 91277, "", "=q4=Tyrannical Gladiator's Clasp of Cruelty", "=ds="};
				{ 26, 91281, "", "=q4=Tyrannical Gladiator's Greaves of Alacrity", "=ds="};
				{ 28, 91306, "", "=q4=Tyrannical Gladiator's Armplates of Alacrity", "=ds="};
				{ 29, 91299, "", "=q4=Tyrannical Gladiator's Girdle of Prowess", "=ds="};
				{ 30, 91303, "", "=q4=Tyrannical Gladiator's Warboots of Alacrity", "=ds="};
				merge = true;
			};
			{
				{ 1, 91100, "", "=q4=Tyrannical Gladiator's Cape of Cruelty", "=ds=#s4#" },
				{ 2, 91101, "", "=q4=Tyrannical Gladiator's Cape of Prowess", "=ds=#s4#" },
				{ 3, 91411, "", "=q4=Tyrannical Gladiator's Cloak of Alacrity", "=ds=#s4#" },
				{ 4, 91412, "", "=q4=Tyrannical Gladiator's Cloak of Prowess", "=ds=#s4#" },
				{ 5, 91124, "", "=q4=Tyrannical Gladiator's Drape of Cruelty", "=ds=#s4#"},
				{ 6, 91126, "", "=q4=Tyrannical Gladiator's Drape of Meditation", "=ds=#s4#" },
				{ 7, 91125, "", "=q4=Tyrannical Gladiator's Drape of Prowess", "=ds=#s4#" },
				{ 9, 91139, "", "=q4=Tyrannical Gladiator's Band of Accuracy", "=ds=#s13#" };
				{ 10, 91138, "", "=q4=Tyrannical Gladiator's Band of Cruelty", "=ds=#s13#" };
				{ 11, 91140, "", "=q4=Tyrannical Gladiator's Band of Meditation", "=ds=#s13#" };
				{ 12, 91417, "", "=q4=Tyrannical Gladiator's Signet of Accuracy", "=ds=#s13#" };
				{ 13, 91416, "", "=q4=Tyrannical Gladiator's Signet of Cruelty", "=ds=#s13#" };
				{ 14, 91106, "", "=q4=Tyrannical Gladiator's Ring of Accuracy", "=ds=#s13#" };
				{ 15, 91105, "", "=q4=Tyrannical Gladiator's Ring of Cruelty", "=ds=#s13#" };
				{ 16, 91414, "", "=q4=Tyrannical Gladiator's Choker of Accuracy", "=ds=#s2#" },
				{ 17, 91413, "", "=q4=Tyrannical Gladiator's Choker of Proficiency", "=ds=#s2#" },
				{ 18, 91102, "", "=q4=Tyrannical Gladiator's Necklace of Proficiency", "=ds=#s2#" },
				{ 19, 91103, "", "=q4=Tyrannical Gladiator's Necklace of Prowess", "=ds=#s2#" },
				{ 20, 91136, "", "=q4=Tyrannical Gladiator's Pendant of Alacrity", "=ds=#s2#" },
				{ 21, 91135, "", "=q4=Tyrannical Gladiator's Pendant of Cruelty", "=ds=#s2#" },
				{ 22, 91137, "", "=q4=Tyrannical Gladiator's Pendant of Meditation", "=ds=#s2#" },
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 94412, "", "=q4=Tyrannical Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
				{ 18, 94483, "", "=q4=Tyrannical Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 94455, "", "=q4=Tyrannical Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
				{ 22, 94368, "", "=q4=Tyrannical Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 94371, "", "=q4=Tyrannical Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
				{ 26, 94477, "", "=q4=Tyrannical Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 17, 94453, "", "=q4=Tyrannical Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 94384, "", "=q4=Tyrannical Gladiator's Chain Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 21, 94451, "", "=q4=Tyrannical Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
				{ 22, 94362, "", "=q4=Tyrannical Gladiator's Silk Trousers", "=ds=#s11#, #a1#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 94377, "", "=q4=Tyrannical Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
				{ 26, 94446, "", "=q4=Tyrannical Gladiator's Leather Legguards", "=ds=#s11#, #a2#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 94441, "", "=q4=Tyrannical Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
				{ 30, 94471, "", "=q4=Tyrannical Gladiator's Felweave Trousers", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 20, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 21, 94340, "", "=q4=Tyrannical Gladiator's Copperskin Gloves", "=ds=#s9#, #a2#"};
				{ 22, 94478, "", "=q4=Tyrannical Gladiator's Copperskin Legguards", "=ds=#s11#, #a2#"};
				{ 24, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 25, 94391, "", "=q4=Tyrannical Gladiator's Ironskin Gloves", "=ds=#s9#, #a2#"};
				{ 26, 94370, "", "=q4=Tyrannical Gladiator's Ironskin Legguards", "=ds=#s11#, #a2#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 94438, "", "=q4=Tyrannical Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
				{ 18, 94484, "", "=q4=Tyrannical Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 94343, "", "=q4=Tyrannical Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
				{ 22, 94496, "", "=q4=Tyrannical Gladiator's Scaled Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 17, 94328, "", "=q4=Tyrannical Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
				{ 18, 94420, "", "=q4=Tyrannical Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 21, 94423, "", "=q4=Tyrannical Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
				{ 22, 94334, "", "=q4=Tyrannical Gladiator's Satin Leggings", "=ds=#s11#, #a1#"};
				merge = true;
			};
			{
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 94408, "", "=q4=Tyrannical Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
				{ 18, 94497, "", "=q4=Tyrannical Gladiator's Mail Leggings", "=ds=#s11#, #a3#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 94458, "", "=q4=Tyrannical Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
				{ 22, 94494, "", "=q4=Tyrannical Gladiator's Linked Leggings", "=ds=#s11#, #a3#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 94490, "", "=q4=Tyrannical Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
				{ 26, 94435, "", "=q4=Tyrannical Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#"};
				merge = true;
			};
			{
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 94364, "", "=q4=Tyrannical Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 18, 94365, "", "=q4=Tyrannical Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 94331, "", "=q4=Tyrannical Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
				{ 26, 94448, "", "=q4=Tyrannical Gladiator's Plate Legguards", "=ds=#s11#, #a4#"};
				merge = true;
			};
			{
				{ 1, 94403, "", "=q4=Tyrannical Gladiator's Cuffs of Accuracy", "=ds="};
				{ 2, 94376, "", "=q4=Tyrannical Gladiator's Cord of Accuracy", "=ds="};
				{ 3, 94333, "", "=q4=Tyrannical Gladiator's Treads of Alacrity", "=ds="};
				{ 5, 94380, "", "=q4=Tyrannical Gladiator's Cuffs of Meditation", "=ds="};
				{ 6, 94425, "", "=q4=Tyrannical Gladiator's Cord of Meditation", "=ds="};
				{ 7, 94468, "", "=q4=Tyrannical Gladiator's Treads of Meditation", "=ds="};
				{ 9, 94449, "", "=q4=Tyrannical Gladiator's Cuffs of Prowess", "=ds="};
				{ 10, 94400, "", "=q4=Tyrannical Gladiator's Cord of Cruelty", "=ds="};
				{ 11, 94402, "", "=q4=Tyrannical Gladiator's Treads of Cruelty", "=ds="};
				{ 16, 94427, "", "=q4=Tyrannical Gladiator's Armwraps of Accuracy", "=ds="};
				{ 17, 94424, "", "=q4=Tyrannical Gladiator's Waistband of Accuracy", "=ds="};
				{ 18, 94374, "", "=q4=Tyrannical Gladiator's Boots of Cruelty", "=ds="};
				{ 20, 94470, "", "=q4=Tyrannical Gladiator's Armwraps of Alacrity", "=ds="};
				{ 21, 94360, "", "=q4=Tyrannical Gladiator's Waistband of Cruelty", "=ds="};
				{ 22, 94432, "", "=q4=Tyrannical Gladiator's Boots of Alacrity", "=ds="};
				{ 24, 94439, "", "=q4=Tyrannical Gladiator's Bindings of Prowess", "=ds="};
				{ 25, 94410, "", "=q4=Tyrannical Gladiator's Belt of Cruelty", "=ds="};
				{ 26, 94344, "", "=q4=Tyrannical Gladiator's Footguards of Alacrity", "=ds="};
				{ 28, 94407, "", "=q4=Tyrannical Gladiator's Bindings of Meditation", "=ds="};
				{ 29, 94491, "", "=q4=Tyrannical Gladiator's Belt of Meditation", "=ds="};
				{ 30, 94476, "", "=q4=Tyrannical Gladiator's Footguards of Meditation", "=ds="};
				merge = true;
			};
			{
				{ 1, 94337, "", "=q4=Tyrannical Gladiator's Armbands of Meditation", "=ds="};
				{ 2, 94382, "", "=q4=Tyrannical Gladiator's Waistguard of Meditation", "=ds="};
				{ 3, 94336, "", "=q4=Tyrannical Gladiator's Footguards of Meditation", "=ds="};
				{ 5, 94379, "", "=q4=Tyrannical Gladiator's Armbands of Prowess", "=ds="};
				{ 6, 94393, "", "=q4=Tyrannical Gladiator's Waistguard of Cruelty", "=ds="};
				{ 7, 94378, "", "=q4=Tyrannical Gladiator's Footguards of Alacrity", "=ds="};
				{ 9, 94404, "", "=q4=Tyrannical Gladiator's Wristguards of Alacrity", "=ds="};
				{ 10, 94330, "", "=q4=Tyrannical Gladiator's Links of Cruelty", "=ds="};
				{ 11, 94359, "", "=q4=Tyrannical Gladiator's Sabatons of Alacrity", "=ds="};
				{ 13, 94469, "", "=q4=Tyrannical Gladiator's Wristguards of Accuracy", "=ds="};
				{ 14, 94358, "", "=q4=Tyrannical Gladiator's Links of Accuracy", "=ds="};
				{ 15, 94445, "", "=q4=Tyrannical Gladiator's Sabatons of Cruelty", "=ds="};
				{ 16, 94481, "", "=q4=Tyrannical Gladiator's Bracers of Meditation", "=ds="};
				{ 17, 94464, "", "=q4=Tyrannical Gladiator's Clasp of Meditation", "=ds="};
				{ 18, 94352, "", "=q4=Tyrannical Gladiator's Greaves of Meditation", "=ds="};
				{ 20, 94418, "", "=q4=Tyrannical Gladiator's Armplates of Proficiency", "=ds="};
				{ 21, 94353, "", "=q4=Tyrannical Gladiator's Girdle of Accuracy", "=ds="};
				{ 22, 94414, "", "=q4=Tyrannical Gladiator's Warboots of Cruelty", "=ds="};
				{ 24, 94411, "", "=q4=Tyrannical Gladiator's Bracers of Prowess", "=ds="};
				{ 25, 94480, "", "=q4=Tyrannical Gladiator's Clasp of Cruelty", "=ds="};
				{ 26, 94351, "", "=q4=Tyrannical Gladiator's Greaves of Alacrity", "=ds="};
				{ 28, 94487, "", "=q4=Tyrannical Gladiator's Armplates of Alacrity", "=ds="};
				{ 29, 94440, "", "=q4=Tyrannical Gladiator's Girdle of Prowess", "=ds="};
				{ 30, 94461, "", "=q4=Tyrannical Gladiator's Warboots of Alacrity", "=ds="};
				merge = true;
			};
			{
				{ 1, 94421, "", "=q4=Tyrannical Gladiator's Cape of Cruelty", "=ds=#s4#" },
				{ 2, 94355, "", "=q4=Tyrannical Gladiator's Cape of Prowess", "=ds=#s4#" },
				{ 3, 94485, "", "=q4=Tyrannical Gladiator's Cloak of Alacrity", "=ds=#s4#" },
				{ 4, 94486, "", "=q4=Tyrannical Gladiator's Cloak of Prowess", "=ds=#s4#" },
				{ 5, 94383, "", "=q4=Tyrannical Gladiator's Drape of Cruelty", "=ds=#s4#"},
				{ 6, 94472, "", "=q4=Tyrannical Gladiator's Drape of Meditation", "=ds=#s4#" },
				{ 7, 94488, "", "=q4=Tyrannical Gladiator's Drape of Prowess", "=ds=#s4#" },
				{ 9, 94363, "", "=q4=Tyrannical Gladiator's Band of Accuracy", "=ds=#s13#" };
				{ 10, 94390, "", "=q4=Tyrannical Gladiator's Band of Cruelty", "=ds=#s13#" };
				{ 11, 94474, "", "=q4=Tyrannical Gladiator's Band of Meditation", "=ds=#s13#" };
				{ 12, 94462, "", "=q4=Tyrannical Gladiator's Signet of Accuracy", "=ds=#s13#" };
				{ 13, 94417, "", "=q4=Tyrannical Gladiator's Signet of Cruelty", "=ds=#s13#" };
				{ 14, 94399, "", "=q4=Tyrannical Gladiator's Ring of Accuracy", "=ds=#s13#" };
				{ 15, 94357, "", "=q4=Tyrannical Gladiator's Ring of Cruelty", "=ds=#s13#" };
				{ 16, 94354, "", "=q4=Tyrannical Gladiator's Choker of Accuracy", "=ds=#s2#" },
				{ 17, 94465, "", "=q4=Tyrannical Gladiator's Choker of Proficiency", "=ds=#s2#" },
				{ 18, 94394, "", "=q4=Tyrannical Gladiator's Necklace of Proficiency", "=ds=#s2#" },
				{ 19, 94395, "", "=q4=Tyrannical Gladiator's Necklace of Prowess", "=ds=#s2#" },
				{ 20, 94473, "", "=q4=Tyrannical Gladiator's Pendant of Alacrity", "=ds=#s2#" },
				{ 21, 94489, "", "=q4=Tyrannical Gladiator's Pendant of Cruelty", "=ds=#s2#" },
				{ 22, 94452, "", "=q4=Tyrannical Gladiator's Pendant of Meditation", "=ds=#s2#" },
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 2, 95245, "", "=q4=Gloves of the Haunted Forest", "=ds=#s9#, #a2#"};
				{ 3, 95247, "", "=q4=Leggings of the Haunted Forest", "=ds=#s11#, #a2#"};
				{ 5, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["DPS"]};
				{ 6, 95236, "", "=q4=Grips of the Haunted Forest", "=ds=#s9#, #a2#"};
				{ 7, 95238, "", "=q4=Legguards of the Haunted Forest", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 10, 95240, "", "=q4=Handwraps of the Haunted Forest", "=ds=#s9#, #a2#"};
				{ 11, 95242, "", "=q4=Legwraps of the Haunted Forest", "=ds=#s11#, #a2#"};
				{ 13, 0, "ability_racial_bearform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Guardian"]};
				{ 14, 95251, "", "=q4=Handguards of the Haunted Forest", "=ds=#s9#, #a2#"};
				{ 15, 95253, "", "=q4=Breeches of the Haunted Forest", "=ds=#s11#, #a2#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["DRUID"];
			};
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 2, 95256, "", "=q4=Saurok Stalker's Gloves", "=ds=#s9#, #a3#"};
				{ 3, 95258, "", "=q4=Saurok Stalker's Legguards", "=ds=#s11#, #a3#"};
				{ 5, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, 95260, "", "=q4=Gloves of the Chromatic Hydra", "=ds=#s9#, #a1#"};
				{ 7, 95262, "", "=q4=Leggings of the Chromatic Hydra", "=ds=#s11#, #a1#"};
				{ 9, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 10, 95306, "", "=q4=Nine-Tailed Gloves", "=ds=#s9#, #a2#"};
				{ 11, 95308, "", "=q4=Nine-Tailed Legguards", "=ds=#s11#, #a2#"};
				{ 13, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 14, 95325, "", "=q4=Gloves of the Thousandfold Hells", "=ds=#s9#, #a1#"};
				{ 15, 95327, "", "=q4=Leggings of the Thousandfold Hells", "=ds=#s11#, #a1#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"].." / "..LOCALIZED_CLASS_NAMES_MALE["MAGE"].." / "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"].." / "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"];
			};
			{
				{ 1, 0, "spell_monk_brewmaster_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Brewmaster"]};
				{ 2, 95276, "", "=q4=Fire-Charm Gauntlets", "=ds=#s9#, #a2#"};
				{ 3, 95278, "", "=q4=Fire-Charm Legguards", "=ds=#s11#, #a2#"};
				{ 5, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 6, 95270, "", "=q4=Fire-Charm Handwraps", "=ds=#s9#, #a2#"};
				{ 7, 95272, "", "=q4=Fire-Charm Legwraps", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 10, 95266, "", "=q4=Fire-Charm Grips", "=ds=#s9#, #a2#"};
				{ 11, 95268, "", "=q4=Fire-Charm Leggings", "=ds=#s11#, #a2#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["MONK"];
			};
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 2, 95286, "", "=q4=Lightning Emperor's Gloves", "=ds=#s9#, #a4#"};
				{ 3, 95288, "", "=q4=Lightning Emperor's Greaves", "=ds=#s11#, #a4#"};
				{ 5, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 6, 95281, "", "=q4=Lightning Emperor's Gauntlets", "=ds=#s9#, #a4#"};
				{ 7, 95283, "", "=q4=Lightning Emperor's Legplates", "=ds=#s11#, #a4#"};
				{ 9, 0, "spell_holy_devotionaura", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 10, 95291, "", "=q4=Lightning Emperor's Handguards", "=ds=#s9#, #a4#"};
				{ 11, 95293, "", "=q4=Lightning Emperor's Legguards", "=ds=#s11#, #a4#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"];
			};
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 2, 95295, "", "=q4=Handwraps of the Exorcist", "=ds=#s9#, #a1#"};
				{ 3, 95297, "", "=q4=Legwraps of the Exorcist", "=ds=#s11#, #a1#"};
				{ 5, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 6, 95300, "", "=q4=Gloves of the Exorcist", "=ds=#s9#, #a1#"};
				{ 7, 95302, "", "=q4=Leggings of the Exorcist", "=ds=#s11#, #a1#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"];
			};
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 2, 95321, "", "=q4=Gloves of the Witch Doctor", "=ds=#s9#, #a3#"};
				{ 3, 95323, "", "=q4=Kilt of the Witch Doctor", "=ds=#s11#, #a3#"};
				{ 5, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 6, 95316, "", "=q4=Grips of the Witch Doctor", "=ds=#s9#, #a3#"};
				{ 7, 95318, "", "=q4=Legguards of the Witch Doctor", "=ds=#s11#, #a3#"};
				{ 9, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 10, 95311, "", "=q4=Handwraps of the Witch Doctor", "=ds=#s9#, #a3#"};
				{ 11, 95313, "", "=q4=Legwraps of the Witch Doctor", "=ds=#s11#, #a3#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"];
			};
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 2, 95226, "", "=q4=Gauntlets of the All-Consuming Maw", "=ds=#s9#, #a4#"};
				{ 3, 95228, "", "=q4=Greaves of the All-Consuming Maw", "=ds=#s11#, #a4#"};
				{ 5, 0, "spell_deathknight_bloodpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 6, 95231, "", "=q4=Handguards of the All-Consuming Maw", "=ds=#s9#, #a4#"};
				{ 7, 95233, "", "=q4=Legguards of the All-Consuming Maw", "=ds=#s11#, #a4#"};
				{ 9, 0, "ability_warrior_innerrage", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 10, 95332, "", "=q4=Gauntlets of the Last Mogu", "=ds=#s9#, #a4#"};
				{ 11, 95333, "", "=q4=Legplates of the Last Mogu", "=ds=#s11#, #a4#"};
				{ 13, 0, "ability_warrior_defensivestance", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
				{ 14, 95336, "", "=q4=Handguards of the Last Mogu", "=ds=#s9#, #a4#"};
				{ 15, 95338, "", "=q4=Legguards of the Last Mogu", "=ds=#s11#, #a4#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." / "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"];
			};
			{
				extraText = ": "..AL["PvP Non-Set Epics"].." - "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				extraText = ": "..AL["PvP Non-Set Epics"].." - "..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"];
			};
			{
				extraText = ": "..AL["PvP Accessories"];
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Nalak, The Storm Lord", 814),
			module = moduleName, menu = "NALAK", instance = "Pandaria",
		};
	};

	AtlasLoot_Data["Oondasta"] = {
		["Normal"] = {
			{
				{ 1, 95182, "", "=q4=Robes of Zalmoxes", "=ds=#s5#, #a1#" },
				{ 2, 95183, "", "=q4=Waistband of Elder Falcarius", "=ds=#s5#, #a1#" },
				{ 3, 95194, "", "=q4=Gloves of Tyranomancy", "=ds=#s9#, #a1#" },
				{ 4, 95193, "", "=q4=Gloves of Varsoon the Greater", "=ds=#s9#, #a1#" },
				{ 5, 95184, "", "=q4=Girdle of Dimorphodontics", "=ds=#s10#, #a1#" },
				{ 6, 95185, "", "=q4=Terrorful Weave", "=ds=#s10#, #a1#" },
				{ 8, 95147, "", "=q4=Fancifully Frilled Tunic", "=ds=#s5#, #a2#" },
				{ 9, 95148, "", "=q4=Vest of the Bordomorono", "=ds=#s5#, #a2#" },
				{ 10, 95196, "", "=q4=Gloves of Gastric Rumbling", "=ds=#s9#, #a2#" },
				{ 11, 95195, "", "=q4=Gloves of Unliving Fossil", "=ds=#s9#, #a2#" },
				{ 12, 95186, "", "=q4=Belt of Crushed Dreams", "=ds=#s10#, #a2#" },
				{ 13, 95187, "", "=q4=Girdle of the Derrodoccus", "=ds=#s10#, #a2#" },
				{ 16, 95149, "", "=q4=Gorgoraptor Scale Chest", "=ds=#s5#, #a3#" },
				{ 17, 95150, "", "=q4=Mail of the Mosschopper", "=ds=#s5#, #a3#" },
				{ 18, 95200, "", "=q4=Orndo Mando's Gloves", "=ds=#s9#, #a3#" },
				{ 19, 95197, "", "=q4=Therapsid Scale Gloves", "=ds=#s9#, #a3#" },
				{ 20, 95188, "", "=q4=Belt of the Arch Avimimus", "=ds=#s10#, #a3#" },
				{ 21, 95189, "", "=q4=Belt of the Dying Diemetradon", "=ds=#s10#, #a3#" },
			};
			{
				{ 1, 95152, "", "=q4=Breastplate of the Iguanocolossus", "=ds=#s5#, #a4#" },
				{ 2, 95151, "", "=q4=Scorched Spiritfire Drape", "=ds=#s5#, #a4#" },
				{ 3, 95153, "", "=q4=Tyrant King Battleplate", "=ds=#s5#, #a4#" },
				{ 4, 95199, "", "=q4=Carnotaur Battlegloves", "=ds=#s9#, #a4#" },
				{ 5, 95201, "", "=q4=Skullsmashing Gauntlets", "=ds=#s9#, #a4#" },
				{ 6, 95198, "", "=q4=Vulcanodon Gauntlets", "=ds=#s9#, #a4#" },
				{ 7, 95192, "", "=q4=Belt of the Tyrannotitan", "=ds=#s10#, #a4#" },
				{ 8, 95191, "", "=q4=Voolar's Bloodied Belt", "=ds=#s10#, #a4#" },
				{ 9, 95190, "", "=q4=Waistband of Furious Stomping", "=ds=#s10#, #a4#" },
				{ 11, 94228, "", "=q4=Reins of the Cobalt Primordial Direhorn", "=ds=#e26#" },
				{ 12, 95601, "", "=q4=Shiny Pile of Refuse", "=ds=#m20#" },
				{ 13, 94295, "", "=q3=Primal Egg", "=ds=#m20#" },
				{ 14, 94288, "", "=q1=Giant Dinosaur Bone", "=ds=#m20#" },
				{ 16, 95181, "", "=q4=Amulet of the Titanorex", "=ds=#s2#" },
				{ 17, 95177, "", "=q4=Choker of Stygimolochy", "=ds=#s2#" },
				{ 18, 95178, "", "=q4=Lootraptor's Amulet", "=ds=#s2#" },
				{ 19, 95179, "", "=q4=Necklace of the Hazillosaurus", "=ds=#s2#" },
				{ 20, 95180, "", "=q4=Overcompensating Chain of the Alpha Male", "=ds=#s2#" },
				{ 22, 95165, "", "=q4=Achillobator Ring", "=ds=#s13#" },
				{ 23, 95164, "", "=q4=Eye of Oondasta", "=ds=#s13#" },
				{ 24, 95166, "", "=q4=Forzarra's Last Meal", "=ds=#s13#" },
				{ 25, 95167, "", "=q4=Ring of King Kangrom", "=ds=#s13#" },
				{ 26, 95163, "", "=q4=Ring of Shamuru", "=ds=#s13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Oondasta", 826),
			module = moduleName, instance = "Pandaria",
		};
	};

	AtlasLoot_Data["Ordos"] = {
		["Normal"] = {
			{
				{ 1, 105810, "", "=q4=Buc-Zakai Burning Hood", "=ds=#s1#, #a1#" },
				{ 2, 105808, "", "=q4=Damien's Ice-Vein Mask", "=ds=#s1#, #a1#" },
				{ 3, 105795, "", "=q4=Bo He Me's Deathwind Mantle", "=ds=#s3#, #a1#" },
				{ 4, 105797, "", "=q4=Shay-Nii's Popping Shoulderpads", "=ds=#s3#, #a1#" },
				{ 5, 105774, "", "=q4=Catia's Flowing Robes", "=ds=#s5#, #a1#" },
				{ 6, 105773, "", "=q4=Ulmaas' Robes of Crushing Magma", "=ds=#s5#, #a1#" },
				{ 7, 105789, "", "=q4=Bjam's Blasting Bracers", "=ds=#s8#, #a1#" },
				{ 8, 105788, "", "=q4=Paululum's Doodled Wraps", "=ds=#s8#, #a1#" },
				{ 9, 105778, "", "=q4=Derevka's Gleaming Girdle", "=ds=#s10#, #a1#" },
				{ 10, 105781, "", "=q4=Venruki's Venerable Sash", "=ds=#s10#, #a1#" },
				{ 11, 105757, "", "=q4=Shipley's Shady Silks", "=ds=#s11#, #a1#" },
				{ 16, 105806, "", "=q4=Circlet of the Panser", "=ds=#s1#, #a2#" },
				{ 17, 105803, "", "=q4=Stickney's Grey-Shade Hood", "=ds=#s1#, #a2#" },
				{ 18, 105798, "", "=q4=Flame Healer's Shoulderguards", "=ds=#s3#, #a2#" },
				{ 19, 105801, "", "=q4=Spaulders of Dominating Dreams", "=ds=#s3#, #a2#" },
				{ 20, 105768, "", "=q4=Pamela's Muuscat Wrap", "=ds=#s5#, #a2#" },
				{ 21, 105770, "", "=q4=Zoo-Per's Superior Chestguard", "=ds=#s5#, #a2#" },
				{ 22, 105793, "", "=q4=Bracers of Simmering Fury", "=ds=#s8#, #a2#" },
				{ 23, 105787, "", "=q4=Burnseal Bracers", "=ds=#s8#, #a2#" },
				{ 24, 105782, "", "=q4=Belt of Glowing Embers", "=ds=#s10#, #a2#" },
				{ 25, 105780, "", "=q4=Windflame Girdle", "=ds=#s10#, #a2#" },
				{ 26, 105758, "", "=q4=Arielle's Ancient Legwraps", "=ds=#s11#, #a2#" },
				{ 27, 105760, "", "=q4=Hamlet's Wind-Whipped Leggings", "=ds=#s11#, #a2#" },
			};
			{
				{ 1, 105809, "", "=q4=Crest of Burning Deeds", "=ds=#s1#, #a3#" },
				{ 2, 105811, "", "=q4=Olivia's Graceful Gaze", "=ds=#s1#, #a3#" },
				{ 3, 105800, "", "=q4=Firearrow Shoulderpads", "=ds=#s3#, #a3#" },
				{ 4, 105799, "", "=q4=Fleshsmoke Chain Shoulders", "=ds=#s3#, #a3#" },
				{ 5, 105771, "", "=q4=Chestguard of Pyrrhic Immolation", "=ds=#s5#, #a3#" },
				{ 6, 105772, "", "=q4=Moonhee's Mean Vest", "=ds=#s5#, #a3#" },
				{ 7, 105792, "", "=q4=Bowflight Wristguard", "=ds=#s8#, #a3#" },
				{ 8, 105790, "", "=q4=Firetotem Bracers", "=ds=#s8#, #a3#" },
				{ 9, 105784, "", "=q4=Binkenstein's Burnished Belt", "=ds=#s10#, #a3#" },
				{ 10, 105779, "", "=q4=Light Kindler Waistguard", "=ds=#s10#, #a3#" },
				{ 11, 105754, "", "=q4=Desirae's Dashing Leggings", "=ds=#s11#, #a3#" },
				{ 12, 105755, "", "=q4=Moshne's Keen Kilt", "=ds=#s11#, #a3#" },
				{ 16, 105804, "", "=q4=Aladya's Spiritfire Greathelm", "=ds=#s1#, #a4#" },
				{ 17, 105805, "", "=q4=Dominik's Casque of Raging Flame", "=ds=#s1#, #a4#" },
				{ 18, 105807, "", "=q4=Magdalena's Murderous Crown", "=ds=#s1#, #a4#" },
				{ 19, 105796, "", "=q4=Rossi's Rosin-Soaked Shoulderplates", "=ds=#s3#, #a4#" },
				{ 20, 105794, "", "=q4=Starry Spaulders of Durability", "=ds=#s3#, #a4#" },
				{ 21, 105802, "", "=q4=Yaungol Deathcult Shoulderguards", "=ds=#s3#, #a4#" },
				{ 22, 105775, "", "=q4=Gleaming Eye Spellplate", "=ds=#s5#, #a4#" },
				{ 23, 105767, "", "=q4=Hoodrych's Bloodied Chestplate", "=ds=#s5#, #a4#" },
				{ 24, 105769, "", "=q4=Omegal's Crushing Carapace", "=ds=#s5#, #a4#" },
				{ 25, 105791, "", "=q4=Bracers of Unquestioning Belief", "=ds=#s8#, #a4#" },
				{ 26, 105786, "", "=q4=Ordosian Cultist's Bracers", "=ds=#s8#, #a4#" },
				{ 27, 105785, "", "=q4=Vanguard's Burly Bracers", "=ds=#s8#, #a4#" },
			};
			{
				{ 1, 105776, "", "=q4=Belt of the Burning Soul", "=ds=#s10#, #a4#" },
				{ 2, 105783, "", "=q4=Greatbelt of the Crendor", "=ds=#s10#, #a4#" },
				{ 3, 105777, "", "=q4=Remnar's Ruinous Girdle", "=ds=#s10#, #a4#" },
				{ 4, 105759, "", "=q4=Magmaplates of Jian Wu Xi Feng", "=ds=#s11#, #a4#" },
				{ 5, 105761, "", "=q4=Partik's Purified Legplates", "=ds=#s11#, #a4#" },
				{ 6, 105756, "", "=q4=Poxleitner's Leggings of Lights", "=ds=#s11#, #a4#" },
				{ 8, 104273, "", "=q4=Flame-Scarred Cache of Offerings", "=ds=#m20#" },
				{ 16, 105766, "", "=q4=Anafielle's Spiked Choker", "=ds=#s2#" },
				{ 17, 105765, "", "=q4=Bladeforger Necklace", "=ds=#s2#" },
				{ 18, 105763, "", "=q4=Penate's Perilous Pendant", "=ds=#s2#" },
				{ 19, 105764, "", "=q4=Rising New Moon Talisman", "=ds=#s2#" },
				{ 20, 105762, "", "=q4=Smoldering Eye", "=ds=#s2#" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ordos, Fire-God of the Yaungol", 861),
			module = moduleName, instance = "Pandaria",
		};
	};

	AtlasLoot_Data["SalyisWarband"] = {
		["Normal"] = {
			{
				{ 1, 90408, "", "=q4=Free Spirit Hood", "=ds=#s1#, #a1#" },
				{ 2, 90409, "", "=q4=Sky-Sear Cowl", "=ds=#s1#, #a1#" },
				{ 3, 90417, "", "=q4=Robes of Blue Skies", "=ds=#s5#, #a1#" },
				{ 4, 90418, "", "=q4=Robes of the Lightning Rider", "=ds=#s5#, #a1#" },
				{ 5, 90449, "", "=q4=Belt of Detonation", "=ds=#s10#, #a1#" },
				{ 6, 90448, "", "=q4=Cannonfire Cord", "=ds=#s10#, #a1#" },
				{ 7, 90439, "", "=q4=Open Steppe Sandals", "=ds=#s12#, #a1#" },
				{ 8, 90440, "", "=q4=Slippers of Fiery Retribution", "=ds=#s12#, #a1#" },
				{ 10, 90413, "", "=q4=Crest of the Grand Warband", "=ds=#s1#, #a3#" },
				{ 11, 90412, "", "=q4=Helm of Restoring Wind", "=ds=#s1#, #a3#" },
				{ 12, 90422, "", "=q4=Armor of the Single Cloud", "=ds=#s5#, #a3#" },
				{ 13, 90421, "", "=q4=Chain of Unsiezed Skies", "=ds=#s5#, #a3#" },
				{ 16, 90410, "", "=q4=Cap of Wandering Pride", "=ds=#s1#, #a2#" },
				{ 17, 90411, "", "=q4=Facemask of Unrepentant Banditry", "=ds=#s1#, #a2#" },
				{ 18, 90419, "", "=q4=Fireproofed Chestguard", "=ds=#s5#, #a2#" },
				{ 19, 90420, "", "=q4=Flameshot Wrap", "=ds=#s5#, #a2#" },
				{ 20, 90451, "", "=q4=Cannoneer's Gunpowder Carrier", "=ds=#s10#, #a2#" },
				{ 21, 90450, "", "=q4=Carrot-Holder Belt", "=ds=#s10#, #a2#" },
				{ 22, 90442, "", "=q4=Flamefoot Tabi", "=ds=#s12#, #a2#" },
				{ 23, 90441, "", "=q4=Stompdodger Boots", "=ds=#s12#, #a2#" },
				{ 25, 90453, "", "=q4=Girdle of the Raging Rider", "=ds=#s10#, #a3#" },
				{ 26, 90452, "", "=q4=Sparkmaker Girdle", "=ds=#s10#, #a3#" },
				{ 27, 90443, "", "=q4=Burnmender Boots", "=ds=#s12#, #a3#" },
				{ 28, 90444, "", "=q4=Treads of Gentle Nudges", "=ds=#s12#, #a3#" },
			};
			{
				{ 1, 90416, "", "=q4=Crown of Ranging Invasion", "=ds=#s1#, #a4#" },
				{ 2, 90415, "", "=q4=Giantfoot Headguard", "=ds=#s1#, #a4#" },
				{ 3, 90414, "", "=q4=Greathelm of the Monstrous Mushan", "=ds=#s1#, #a4#" },
				{ 4, 90425, "", "=q4=Carapace of Crushed Conviction", "=ds=#s5#, #a4#" },
				{ 5, 90423, "", "=q4=Chestguard of the Unbowed Back", "=ds=#s5#, #a4#" },
				{ 6, 90424, "", "=q4=Ravaging Warrior's Chestplate", "=ds=#s5#, #a4#" },
				{ 7, 90456, "", "=q4=Cord of Crazed Strength", "=ds=#s10#, #a4#" },
				{ 8, 90454, "", "=q4=Girdle of the Galloping Giant", "=ds=#s10#, #a4#" },
				{ 9, 90455, "", "=q4=Greatbelt of Livid Fury", "=ds=#s10#, #a4#" },
				{ 10, 90445, "", "=q4=Firerider Treads", "=ds=#s12#, #a4#" },
				{ 11, 90446, "", "=q4=Silverspur Warboots", "=ds=#s12#, #a4#" },
				{ 12, 90447, "", "=q4=Stompers of Vigorous Stomping", "=ds=#s12#, #a4#" },
				{ 16, 90432, "", "=q4=Hellrider's Choker", "=ds=#s2#" },
				{ 17, 90433, "", "=q4=Mushan Rider's Collar", "=ds=#s2#" },
				{ 18, 90429, "", "=q4=Necklace of Imbued Fury", "=ds=#s2#" },
				{ 19, 90431, "", "=q4=Saddlebinder Links", "=ds=#s2#" },
				{ 20, 90430, "", "=q4=Stomphowl Pendant", "=ds=#s2#" },
				{ 22, 90436, "", "=q4=Circle of Scaled Fury", "=ds=#s13#" },
				{ 23, 90437, "", "=q4=Hereditary Saurok Loop", "=ds=#s13#" },
				{ 24, 90435, "", "=q4=Ring of Wretched Flames", "=ds=#s13#" },
				{ 25, 90438, "", "=q4=Signet of the Bandit Lord", "=ds=#s13#" },
				{ 26, 90434, "", "=q4=Steaming Seal of Flame", "=ds=#s13#" },
				{ 28, 89783, "", "=q4=Son of Galleon's Saddle", "=ds=#e26#" },
				{ 29, 90840, "", "=q3=Marauder's Gleaming Sack of Gold", "=ds=#m20#" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Salyis's Warband", 725),
			module = moduleName, instance = "Pandaria",
		};
	};

	AtlasLoot_Data["ShaofAnger"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 2, 85308, "", "=q4=Eternal Blossom Gloves", "=ds=#s9#, #a2#"};
				{ 3, 85306, "", "=q4=Eternal Blossom Leggings", "=ds=#s11#, #a2#"};
				{ 5, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["DPS"]};
				{ 6, 85312, "", "=q4=Eternal Blossom Grips", "=ds=#s9#, #a2#"};
				{ 7, 85310, "", "=q4=Eternal Blossom Legguards", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 10, 85358, "", "=q4=Eternal Blossom Handwraps", "=ds=#s9#, #a2#"};
				{ 11, 85356, "", "=q4=Eternal Blossom Legwraps", "=ds=#s11#, #a2#"};
				{ 13, 0, "ability_racial_bearform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Guardian"]};
				{ 14, 85380, "", "=q4=Eternal Blossom Handguards", "=ds=#s9#, #a2#"};
				{ 15, 85382, "", "=q4=Eternal Blossom Breeches", "=ds=#s11#, #a2#"};
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 84843, "", "=q4=Malevolent Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 84832, "", "=q4=Malevolent Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 84833, "", "=q4=Malevolent Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["DRUID"];
			};
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 2, 85297, "", "=q4=Yaungol Slayer's Gloves", "=ds=#s9#, #a3#"};
				{ 3, 85295, "", "=q4=Yaungol Slayer's Legguards", "=ds=#s11#, #a3#"};
				{ 5, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, 85378, "", "=q4=Gloves of the Burning Scroll", "=ds=#s9#, #a1#"};
				{ 7, 85376, "", "=q4=Leggings of the Burning Scroll", "=ds=#s11#, #a1#"};
				{ 9, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 10, 85302, "", "=q4=Gloves of the Thousandfold Blades", "=ds=#s9#, #a2#"};
				{ 11, 85300, "", "=q4=Legguards of the Thousandfold Blades", "=ds=#s11#, #a2#"};
				{ 13, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 14, 85369, "", "=q4=Sha-Skin Gloves", "=ds=#s9#, #a1#"};
				{ 15, 85371, "", "=q4=Sha-Skin Leggings", "=ds=#s11#, #a1#"};
				{ 16, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 17, 84841, "", "=q4=Malevolent Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#"};
				{ 20, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 21, 84837, "", "=q4=Malevolent Gladiator's Silk Handguards", "=ds=#s9#, #a1#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 84830, "", "=q4=Malevolent Gladiator's Leather Gloves", "=ds=#s9#, #a2#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 84842, "", "=q4=Malevolent Gladiator's Felweave Handguards", "=ds=#s9#, #a1#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["HUNTER"].." / "..LOCALIZED_CLASS_NAMES_MALE["MAGE"].." / "..LOCALIZED_CLASS_NAMES_MALE["ROGUE"].." / "..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"];
			};
			{
				{ 1, 0, "spell_monk_brewmaster_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Brewmaster"]};
				{ 2, 85387, "", "=q4=Red Crane Gauntlets", "=ds=#s9#, #a2#"};
				{ 3, 85385, "", "=q4=Red Crane Legguards", "=ds=#s11#, #a2#"};
				{ 5, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 6, 85389, "", "=q4=Red Crane Handwraps", "=ds=#s9#, #a2#"};
				{ 7, 85391, "", "=q4=Red Crane Legwraps", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 10, 85395, "", "=q4=Red Crane Grips", "=ds=#s9#, #a2#"};
				{ 11, 85397, "", "=q4=Red Crane Leggings", "=ds=#s11#, #a2#"};
				{ 20, 0, "spell_monk_mistweaver_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 21, 84836, "", "=q4=Malevolent Gladiator's Copperskin Gloves", "=ds=#s9#, #a2#"};
				{ 24, 0, "spell_monk_windwalker_spec", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 25, 84839, "", "=q4=Malevolent Gladiator's Ironskin Gloves", "=ds=#s9#, #a2#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["MONK"];
			};
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 2, 85347, "", "=q4=White Tiger Gloves", "=ds=#s9#, #a4#"};
				{ 3, 85345, "", "=q4=White Tiger Greaves", "=ds=#s11#, #a4#"};
				{ 5, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 6, 85342, "", "=q4=White Tiger Gauntlets", "=ds=#s9#, #a4#"};
				{ 7, 85340, "", "=q4=White Tiger Legplates", "=ds=#s11#, #a4#"};
				{ 9, 0, "spell_holy_devotionaura", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 10, 85322, "", "=q4=White Tiger Handguards", "=ds=#s9#, #a4#"};
				{ 11, 85320, "", "=q4=White Tiger Legguards", "=ds=#s11#, #a4#"};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 84831, "", "=q4=Malevolent Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 84834, "", "=q4=Malevolent Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["PALADIN"];
			};
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 2, 85363, "", "=q4=Guardian Serpent Handwraps", "=ds=#s9#, #a1#"};
				{ 3, 85361, "", "=q4=Guardian Serpent Legwraps", "=ds=#s11#, #a1#"};
				{ 5, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 6, 85364, "", "=q4=Guardian Serpent Gloves", "=ds=#s9#, #a1#"};
				{ 7, 85366, "", "=q4=Guardian Serpent Leggings", "=ds=#s11#, #a1#"};
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 17, 84846, "", "=q4=Malevolent Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 21, 84838, "", "=q4=Malevolent Gladiator's Satin Gloves", "=ds=#s9#, #a1#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["PRIEST"];
			};
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 2, 85290, "", "=q4=Firebird's Gloves", "=ds=#s9#, #a3#"};
				{ 3, 85292, "", "=q4=Firebird's Kilt", "=ds=#s11#, #a3#"};
				{ 5, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 6, 85287, "", "=q4=Firebird's Grips", "=ds=#s9#, #a3#"};
				{ 7, 85285, "", "=q4=Firebird's Legguards", "=ds=#s11#, #a3#"};
				{ 9, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 10, 85352, "", "=q4=Firebird's Handwraps", "=ds=#s9#, #a3#"};
				{ 11, 85350, "", "=q4=Firebird's Legwraps", "=ds=#s11#, #a3#"};
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 84845, "", "=q4=Malevolent Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 84844, "", "=q4=Malevolent Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 84847, "", "=q4=Malevolent Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"];
			};
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 2, 85337, "", "=q4=Gauntlets of the Lost Catacomb", "=ds=#s9#, #a4#"};
				{ 3, 85335, "", "=q4=Greaves of the Lost Catacomb", "=ds=#s11#, #a4#"};
				{ 5, 0, "spell_deathknight_bloodpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 6, 85317, "", "=q4=Handguards of the Lost Catacomb", "=ds=#s9#, #a4#"};
				{ 7, 85315, "", "=q4=Legguards of the Lost Catacomb", "=ds=#s11#, #a4#"};
				{ 9, 0, "ability_warrior_innerrage", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 10, 85331, "", "=q4=Gauntlets of Resounding Rings", "=ds=#s9#, #a4#"};
				{ 11, 85330, "", "=q4=Legplates of Resounding Rings", "=ds=#s11#, #a4#"};
				{ 13, 0, "ability_warrior_defensivestance", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
				{ 14, 85327, "", "=q4=Handguards of Resounding Rings", "=ds=#s9#, #a4#"};
				{ 15, 85325, "", "=q4=Legguards of Resounding Rings", "=ds=#s11#, #a4#"};
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 84835, "", "=q4=Malevolent Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 84840, "", "=q4=Malevolent Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#"};
				extraText = ": "..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." / "..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"];
			};
			{
				{ 1, 84977, "", "=q4=Malevolent Gladiator's Cuffs of Accuracy", "=ds="};
				{ 2, 84955, "", "=q4=Malevolent Gladiator's Cord of Accuracy", "=ds="};
				{ 3, 84815, "", "=q4=Malevolent Gladiator's Treads of Alacrity", "=ds="};
				{ 5, 84979, "", "=q4=Malevolent Gladiator's Cuffs of Meditation", "=ds="};
				{ 6, 84956, "", "=q4=Malevolent Gladiator's Cord of Meditation", "=ds="};
				{ 7, 84816, "", "=q4=Malevolent Gladiator's Treads of Meditation", "=ds="};
				{ 9, 84978, "", "=q4=Malevolent Gladiator's Cuffs of Prowess", "=ds="};
				{ 10, 84954, "", "=q4=Malevolent Gladiator's Cord of Cruelty", "=ds="};
				{ 11, 84814, "", "=q4=Malevolent Gladiator's Treads of Cruelty", "=ds="};
				{ 16, 84973, "", "=q4=Malevolent Gladiator's Armwraps of Accuracy", "=ds="};
				{ 17, 84948, "", "=q4=Malevolent Gladiator's Waistband of Accuracy", "=ds="};
				{ 18, 84808, "", "=q4=Malevolent Gladiator's Boots of Cruelty", "=ds="};
				{ 20, 84972, "", "=q4=Malevolent Gladiator's Armwraps of Alacrity", "=ds="};
				{ 21, 84947, "", "=q4=Malevolent Gladiator's Waistband of Cruelty", "=ds="};
				{ 22, 84809, "", "=q4=Malevolent Gladiator's Boots of Alacrity", "=ds="};
				{ 24, 84982, "", "=q4=Malevolent Gladiator's Bindings of Prowess", "=ds="};
				{ 25, 84960, "", "=q4=Malevolent Gladiator's Belt of Cruelty", "=ds="};
				{ 26, 84819, "", "=q4=Malevolent Gladiator's Footguards of Alacrity", "=ds="};
				{ 28, 84976, "", "=q4=Malevolent Gladiator's Bindings of Meditation", "=ds="};
				{ 29, 84953, "", "=q4=Malevolent Gladiator's Belt of Meditation", "=ds="};
				{ 30, 84813, "", "=q4=Malevolent Gladiator's Footguards of Meditation", "=ds="};
				extraText = ": "..AL["PvP Non-Set Epics"].." - "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				{ 1, 84984, "", "=q4=Malevolent Gladiator's Armbands of Meditation", "=ds="};
				{ 2, 84946, "", "=q4=Malevolent Gladiator's Waistguard of Meditation", "=ds="};
				{ 3, 84821, "", "=q4=Malevolent Gladiator's Footguards of Meditation", "=ds="};
				{ 5, 84983, "", "=q4=Malevolent Gladiator's Armbands of Prowess", "=ds="};
				{ 6, 84959, "", "=q4=Malevolent Gladiator's Waistguard of Cruelty", "=ds="};
				{ 7, 84820, "", "=q4=Malevolent Gladiator's Footguards of Alacrity", "=ds="};
				{ 9, 84980, "", "=q4=Malevolent Gladiator's Wristguards of Alacrity", "=ds="};
				{ 10, 84958, "", "=q4=Malevolent Gladiator's Links of Cruelty", "=ds="};
				{ 11, 84818, "", "=q4=Malevolent Gladiator's Sabatons of Alacrity", "=ds="};
				{ 13, 84981, "", "=q4=Malevolent Gladiator's Wristguards of Accuracy", "=ds="};
				{ 14, 84957, "", "=q4=Malevolent Gladiator's Links of Accuracy", "=ds="};
				{ 15, 84817, "", "=q4=Malevolent Gladiator's Sabatons of Cruelty", "=ds="};
				{ 16, 84975, "", "=q4=Malevolent Gladiator's Bracers of Meditation", "=ds="};
				{ 17, 84952, "", "=q4=Malevolent Gladiator's Clasp of Meditation", "=ds="};
				{ 18, 84812, "", "=q4=Malevolent Gladiator's Greaves of Meditation", "=ds="};
				{ 20, 84985, "", "=q4=Malevolent Gladiator's Armplates of Proficiency", "=ds="};
				{ 21, 84949, "", "=q4=Malevolent Gladiator's Girdle of Accuracy", "=ds="};
				{ 22, 84810, "", "=q4=Malevolent Gladiator's Warboots of Cruelty", "=ds="};
				{ 24, 84974, "", "=q4=Malevolent Gladiator's Bracers of Prowess", "=ds="};
				{ 25, 84951, "", "=q4=Malevolent Gladiator's Clasp of Cruelty", "=ds="};
				{ 26, 84811, "", "=q4=Malevolent Gladiator's Greaves of Alacrity", "=ds="};
				{ 28, 84986, "", "=q4=Malevolent Gladiator's Armplates of Alacrity", "=ds="};
				{ 29, 84950, "", "=q4=Malevolent Gladiator's Girdle of Prowess", "=ds="};
				{ 30, 84822, "", "=q4=Malevolent Gladiator's Warboots of Alacrity", "=ds="};
				extraText = ": "..AL["PvP Non-Set Epics"].." - "..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"];
			};
			{
				{ 1, 84804, "", "=q4=Malevolent Gladiator's Cape of Cruelty", "=ds=#s4#" },
				{ 2, 84805, "", "=q4=Malevolent Gladiator's Cape of Prowess", "=ds=#s4#" },
				{ 3, 84807, "", "=q4=Malevolent Gladiator's Cloak of Alacrity", "=ds=#s4#" },
				{ 4, 84806, "", "=q4=Malevolent Gladiator's Cloak of Prowess", "=ds=#s4#" },
				{ 5, 84801, "", "=q4=Malevolent Gladiator's Drape of Cruelty", "=ds=#s4#"},
				{ 6, 84802, "", "=q4=Malevolent Gladiator's Drape of Meditation", "=ds=#s4#" },
				{ 7, 84803, "", "=q4=Malevolent Gladiator's Drape of Prowess", "=ds=#s4#" },
				{ 9, 84824, "", "=q4=Malevolent Gladiator's Band of Accuracy", "=ds=#s13#" };
				{ 10, 84823, "", "=q4=Malevolent Gladiator's Band of Cruelty", "=ds=#s13#" };
				{ 11, 84825, "", "=q4=Malevolent Gladiator's Band of Meditation", "=ds=#s13#" };
				{ 12, 84829, "", "=q4=Malevolent Gladiator's Signet of Accuracy", "=ds=#s13#" };
				{ 13, 84828, "", "=q4=Malevolent Gladiator's Signet of Cruelty", "=ds=#s13#" };
				{ 14, 84827, "", "=q4=Malevolent Gladiator's Ring of Accuracy", "=ds=#s13#" };
				{ 15, 84826, "", "=q4=Malevolent Gladiator's Ring of Cruelty", "=ds=#s13#" };
				{ 16, 84892, "", "=q4=Malevolent Gladiator's Choker of Accuracy", "=ds=#s2#" },
				{ 17, 84891, "", "=q4=Malevolent Gladiator's Choker of Proficiency", "=ds=#s2#" },
				{ 18, 84889, "", "=q4=Malevolent Gladiator's Necklace of Proficiency", "=ds=#s2#" },
				{ 19, 84890, "", "=q4=Malevolent Gladiator's Necklace of Prowess", "=ds=#s2#" },
				{ 20, 84886, "", "=q4=Malevolent Gladiator's Pendant of Alacrity", "=ds=#s2#" },
				{ 21, 84887, "", "=q4=Malevolent Gladiator's Pendant of Cruelty", "=ds=#s2#" },
				{ 22, 84888, "", "=q4=Malevolent Gladiator's Pendant of Meditation", "=ds=#s2#" },
				extraText = ": "..AL["PvP Accessories"];
			};
			{
				{ 1, 89317, "", "=q4=Claw of Anger", "=ds=#m2#: #QUESTID:31809#", "", "100%" },
				{ 3, 90911, "", "=q4=Furyheart Treads", "=ds=#s12#, #a1#" },
				{ 4, 90914, "", "=q4=Boots of Raging Haze", "=ds=#s12#, #a2#" },
				{ 5, 90907, "", "=q4=Boots of Unbreakable Umbrage", "=ds=#s12#, #a3#" },
				{ 6, 90912, "", "=q4=Angerforged Stompers", "=ds=#s12#, #a4#"},
				{ 7, 90910, "", "=q4=Mindfire Sollerets", "=ds=#s12#, #a4#"},
				{ 18, 90913, "", "=q4=Sandals of the Shadow", "=ds=#s12#, #a1#" },
				{ 19, 90908, "", "=q4=Crushing Treads of Anger", "=ds=#s12#, #a2#" },
				{ 20, 90906, "", "=q4=Treads of Ardent Antagonism", "=ds=#s12#, #a3#" };
				{ 21, 90909, "", "=q4=Intemperate Greatboots", "=ds=#s12#, #a4#" };
				extraText = ": "..AL["Quest Reward"];
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sha of Anger", 691),
			module = moduleName, menu = "SHAOFANGER", instance = "Pandaria",
		};
	};

		--------------------------
		--- Siege of Orgrimmar ---
		--------------------------

	AtlasLoot_Data["SoOImmerseus"] = {
		["RaidFinder"] = {
			{
				{ 1, 104923, "", "=q4=Cloak of Misguided Power", "=ds=#s4#" },
				{ 2, 104922, "", "=q4=Hood of Swirling Senses", "=ds=#s1#, #a1#" },
				{ 3, 104921, "", "=q4=Ichor-Dripping Shoulderpads", "=ds=#s3#, #a1#" },
				{ 4, 104920, "", "=q4=Bolt-Burster Grips", "=ds=#s9#, #a1#" },
				{ 5, 104911, "", "=q4=Hood of Blackened Tears", "=ds=#s1#, #a2#" },
				{ 6, 104927, "", "=q4=Bracers of Purified Spirit", "=ds=#s8#, #a2#" },
				{ 7, 104926, "", "=q4=Salt Water Sandals", "=ds=#s12#, #a2#" },
				{ 8, 104928, "", "=q4=Soul-Soaked Gloves", "=ds=#s9#, #a3#" },
				{ 9, 104912, "", "=q4=Puddle Punishers", "=ds=#s12#, #a3#" },
				{ 10, 104918, "", "=q4=Pauldrons of Violent Eruption", "=ds=#s3#, #a4#" },
				{ 11, 104914, "", "=q4=Chestplate of Congealed Corrosion", "=ds=#s5#, #a4#" },
				{ 12, 104917, "", "=q4=Bracers of Sordid Sleep", "=ds=#s8#, #a4#" },
				{ 13, 104913, "", "=q4=Bubble-Burst Bracers", "=ds=#s8#, #a4#" },
				{ 14, 104915, "", "=q4=Corruption-Rotted Gauntlets", "=ds=#s9#, #a4#" },
				{ 15, 104929, "", "=q4=Greatbelt of Living Waters", "=ds=#s10#, #a4#" },
				{ 16, 104916, "", "=q4=Treads of Unchained Hate", "=ds=#s12#, #a4#" },
				{ 17, 104930, "", "=q4=Waterwalker Greatboots", "=ds=#s12#, #a4#" },
				{ 19, 104909, "", "=q4=Immerseus' Crystalline Eye", "=ds=#s2#" },
				{ 20, 104925, "", "=q4=Seal of Eternal Sorrow", "=ds=#s13#" },
				{ 21, 104924, "", "=q4=Purified Bindings of Immerseus", "=ds=#s14#" },
				{ 23, 104919, "", "=q4=Encapsulated Essence of Immerseus", "=ds=#h1#, #w6#" },
				{ 24, 104910, "", "=q4=Trident of Corrupted Waters", "=ds=#w9#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104674, "", "=q4=Cloak of Misguided Power", "=ds=#s4#" },
				{ 2, 104673, "", "=q4=Hood of Swirling Senses", "=ds=#s1#, #a1#" },
				{ 3, 104672, "", "=q4=Ichor-Dripping Shoulderpads", "=ds=#s3#, #a1#" },
				{ 4, 104671, "", "=q4=Bolt-Burster Grips", "=ds=#s9#, #a1#" },
				{ 5, 104662, "", "=q4=Hood of Blackened Tears", "=ds=#s1#, #a2#" },
				{ 6, 104678, "", "=q4=Bracers of Purified Spirit", "=ds=#s8#, #a2#" },
				{ 7, 104677, "", "=q4=Salt Water Sandals", "=ds=#s12#, #a2#" },
				{ 8, 104679, "", "=q4=Soul-Soaked Gloves", "=ds=#s9#, #a3#" },
				{ 9, 104663, "", "=q4=Puddle Punishers", "=ds=#s12#, #a3#" },
				{ 10, 104669, "", "=q4=Pauldrons of Violent Eruption", "=ds=#s3#, #a4#" },
				{ 11, 104665, "", "=q4=Chestplate of Congealed Corrosion", "=ds=#s5#, #a4#" },
				{ 12, 104668, "", "=q4=Bracers of Sordid Sleep", "=ds=#s8#, #a4#" },
				{ 13, 104664, "", "=q4=Bubble-Burst Bracers", "=ds=#s8#, #a4#" },
				{ 14, 104666, "", "=q4=Corruption-Rotted Gauntlets", "=ds=#s9#, #a4#" },
				{ 15, 104680, "", "=q4=Greatbelt of Living Waters", "=ds=#s10#, #a4#" },
				{ 16, 104667, "", "=q4=Treads of Unchained Hate", "=ds=#s12#, #a4#" },
				{ 17, 104681, "", "=q4=Waterwalker Greatboots", "=ds=#s12#, #a4#" },
				{ 19, 104660, "", "=q4=Immerseus' Crystalline Eye", "=ds=#s2#" },
				{ 20, 104676, "", "=q4=Seal of Eternal Sorrow", "=ds=#s13#" },
				{ 21, 104675, "", "=q4=Purified Bindings of Immerseus", "=ds=#s14#" },
				{ 23, 104670, "", "=q4=Encapsulated Essence of Immerseus", "=ds=#h1#, #w6#" },
				{ 24, 104661, "", "=q4=Trident of Corrupted Waters", "=ds=#w9#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103769, "", "=q4=Cloak of Misguided Power", "=ds=#s4#", tf=105172 },
				{ 2, 103751, "", "=q4=Hood of Swirling Senses", "=ds=#s1#, #a1#", tf=105171 },
				{ 3, 103755, "", "=q4=Ichor-Dripping Shoulderpads", "=ds=#s3#, #a1#", tf=105170 },
				{ 4, 103752, "", "=q4=Bolt-Burster Grips", "=ds=#s9#, #a1#", tf=105169 },
				{ 5, 103728, "", "=q4=Hood of Blackened Tears", "=ds=#s1#, #a2#", tf=105160 },
				{ 6, 103757, "", "=q4=Bracers of Purified Spirit", "=ds=#s8#, #a2#", tf=105176 },
				{ 7, 103760, "", "=q4=Salt Water Sandals", "=ds=#s12#, #a2#", tf=105175 },
				{ 8, 103763, "", "=q4=Soul-Soaked Gloves", "=ds=#s9#, #a3#", tf=105177 },
				{ 9, 103730, "", "=q4=Puddle Punishers", "=ds=#s12#, #a3#", tf=105161 },
				{ 10, 103747, "", "=q4=Pauldrons of Violent Eruption", "=ds=#s3#, #a4#", tf=105167 },
				{ 11, 103736, "", "=q4=Chestplate of Congealed Corrosion", "=ds=#s5#, #a4#", tf=105163 },
				{ 12, 103741, "", "=q4=Bracers of Sordid Sleep", "=ds=#s8#, #a4#", tf=105166 },
				{ 13, 103738, "", "=q4=Bubble-Burst Bracers", "=ds=#s8#, #a4#", tf=105162 },
				{ 14, 103733, "", "=q4=Corruption-Rotted Gauntlets", "=ds=#s9#, #a4#", tf=105164 },
				{ 15, 103966, "", "=q4=Greatbelt of Living Waters", "=ds=#s10#, #a4#", tf=105178 },
				{ 16, 103744, "", "=q4=Treads of Unchained Hate", "=ds=#s12#, #a4#", tf=105165 },
				{ 17, 103766, "", "=q4=Waterwalker Greatboots", "=ds=#s12#, #a4#", tf=105179 },
				{ 19, 103749, "", "=q4=Immerseus' Crystalline Eye", "=ds=#s2#", tf=105158 },
				{ 20, 103771, "", "=q4=Seal of Eternal Sorrow", "=ds=#s13#", tf=105174 },
				{ 21, 102293, "", "=q4=Purified Bindings of Immerseus", "=ds=#s14#", tf=105173 },
				{ 23, 103727, "", "=q4=Encapsulated Essence of Immerseus", "=ds=#h1#, #w6#", tf=105168 },
				{ 24, 103726, "", "=q4=Trident of Corrupted Waters", "=ds=#w9#", tf=105159 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104425, "", "=q4=Cloak of Misguided Power", "=ds=#s4#", tf=105421 },
				{ 2, 104424, "", "=q4=Hood of Swirling Senses", "=ds=#s1#, #a1#", tf=105420 },
				{ 3, 104423, "", "=q4=Ichor-Dripping Shoulderpads", "=ds=#s3#, #a1#", tf=105419 },
				{ 4, 104422, "", "=q4=Bolt-Burster Grips", "=ds=#s9#, #a1#", tf=105418 },
				{ 5, 104413, "", "=q4=Hood of Blackened Tears", "=ds=#s1#, #a2#", tf=105409 },
				{ 6, 104429, "", "=q4=Bracers of Purified Spirit", "=ds=#s8#, #a2#", tf=105425 },
				{ 7, 104428, "", "=q4=Salt Water Sandals", "=ds=#s12#, #a2#", tf=105424 },
				{ 8, 104430, "", "=q4=Soul-Soaked Gloves", "=ds=#s9#, #a3#", tf=105426 },
				{ 9, 104414, "", "=q4=Puddle Punishers", "=ds=#s12#, #a3#", tf=105410 },
				{ 10, 104420, "", "=q4=Pauldrons of Violent Eruption", "=ds=#s3#, #a4#", tf=105416 },
				{ 11, 104416, "", "=q4=Chestplate of Congealed Corrosion", "=ds=#s5#, #a4#", tf=105412 },
				{ 12, 104419, "", "=q4=Bracers of Sordid Sleep", "=ds=#s8#, #a4#", tf=105415 },
				{ 13, 104415, "", "=q4=Bubble-Burst Bracers", "=ds=#s8#, #a4#", tf=105411 },
				{ 14, 104417, "", "=q4=Corruption-Rotted Gauntlets", "=ds=#s9#, #a4#", tf=105413 },
				{ 15, 104431, "", "=q4=Greatbelt of Living Waters", "=ds=#s10#, #a4#", tf=105427 },
				{ 16, 104418, "", "=q4=Treads of Unchained Hate", "=ds=#s12#, #a4#", tf=105414 },
				{ 17, 104432, "", "=q4=Waterwalker Greatboots", "=ds=#s12#, #a4#", tf=105428 },
				{ 19, 104411, "", "=q4=Immerseus' Crystalline Eye", "=ds=#s2#", tf=105407 },
				{ 20, 104427, "", "=q4=Seal of Eternal Sorrow", "=ds=#s13#", tf=105423 },
				{ 21, 104426, "", "=q4=Purified Bindings of Immerseus", "=ds=#s14#", tf=105422 },
				{ 23, 104421, "", "=q4=Encapsulated Essence of Immerseus", "=ds=#h1#, #w6#", tf=105417 },
				{ 24, 104412, "", "=q4=Trident of Corrupted Waters", "=ds=#w9#", tf=105408 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Immerseus", 852),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOFallenProtectors"] = {
		["RaidFinder"] = {
			{
				{ 1, 104939, "", "=q4=Gloomwrap Greatcloak", "=ds=#s4#" },
				{ 2, 104943, "", "=q4=Shoulderpads of Dou Dou Chong", "=ds=#s3#, #a1#" },
				{ 3, 104942, "", "=q4=Robes of the Tendered Heart", "=ds=#s5#, #a1#" },
				{ 4, 104944, "", "=q4=Lifebane Bracers", "=ds=#s8#, #a1#" },
				{ 5, 104941, "", "=q4=Sha-Seared Sandals", "=ds=#s12#, #a1#" },
				{ 6, 104947, "", "=q4=Shoulders of the Roiling Inferno", "=ds=#s3#, #a2#" },
				{ 7, 104933, "", "=q4=Stonetoe's Tormented Treads", "=ds=#s12#, #a2#" },
				{ 8, 104949, "", "=q4=Shoulderguards of Dark Meditations", "=ds=#s3#, #a3#" },
				{ 9, 104934, "", "=q4=Grips of Unending Anguish", "=ds=#s9#, #a3#" },
				{ 10, 104948, "", "=q4=Sabatons of Defilement", "=ds=#s12#, #a3#" },
				{ 11, 104951, "", "=q4=Gaze of Echoing Despair", "=ds=#s1#, #a4#" },
				{ 12, 104936, "", "=q4=Darkfallen Shoulderplates", "=ds=#s3#, #a4#" },
				{ 13, 104950, "", "=q4=Grips of the Fallen Council", "=ds=#s9#, #a4#" },
				{ 14, 104937, "", "=q4=Shockstriker Gauntlets", "=ds=#s9#, #a4#" },
				{ 15, 104935, "", "=q4=Poisonbinder Girth", "=ds=#s10#, #a4#" },
				{ 16, 104945, "", "=q4=Petrified Pennyroyal Ring", "=ds=#s13#" },
				{ 17, 104938, "", "=q4=Sorrowpath Signet", "=ds=#s13#" },
				{ 18, 104940, "", "=q4=Rook's Unlucky Talisman", "=ds=#s14#" },
				{ 20, 104931, "", "=q4=Death Lotus Crossbow", "=ds=#w3#" },
				{ 21, 104932, "", "=q4=Softfoot's Last Resort", "=ds=#h1#, #w13#" },
				{ 22, 104946, "", "=q4=Purehearted Cricket Cage", "=ds=#s15#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104690, "", "=q4=Gloomwrap Greatcloak", "=ds=#s4#" },
				{ 2, 104694, "", "=q4=Shoulderpads of Dou Dou Chong", "=ds=#s3#, #a1#" },
				{ 3, 104693, "", "=q4=Robes of the Tendered Heart", "=ds=#s5#, #a1#" },
				{ 4, 104695, "", "=q4=Lifebane Bracers", "=ds=#s8#, #a1#" },
				{ 5, 104692, "", "=q4=Sha-Seared Sandals", "=ds=#s12#, #a1#" },
				{ 6, 104698, "", "=q4=Shoulders of the Roiling Inferno", "=ds=#s3#, #a2#" },
				{ 7, 104684, "", "=q4=Stonetoe's Tormented Treads", "=ds=#s12#, #a2#" },
				{ 8, 104700, "", "=q4=Shoulderguards of Dark Meditations", "=ds=#s3#, #a3#" },
				{ 9, 104685, "", "=q4=Grips of Unending Anguish", "=ds=#s9#, #a3#" },
				{ 10, 104699, "", "=q4=Sabatons of Defilement", "=ds=#s12#, #a3#" },
				{ 11, 104702, "", "=q4=Gaze of Echoing Despair", "=ds=#s1#, #a4#" },
				{ 12, 104687, "", "=q4=Darkfallen Shoulderplates", "=ds=#s3#, #a4#" },
				{ 13, 104701, "", "=q4=Grips of the Fallen Council", "=ds=#s9#, #a4#" },
				{ 14, 104688, "", "=q4=Shockstriker Gauntlets", "=ds=#s9#, #a4#" },
				{ 15, 104686, "", "=q4=Poisonbinder Girth", "=ds=#s10#, #a4#" },
				{ 16, 104696, "", "=q4=Petrified Pennyroyal Ring", "=ds=#s13#" },
				{ 17, 104689, "", "=q4=Sorrowpath Signet", "=ds=#s13#" },
				{ 18, 104691, "", "=q4=Rook's Unlucky Talisman", "=ds=#s14#" },
				{ 20, 104682, "", "=q4=Death Lotus Crossbow", "=ds=#w3#" },
				{ 21, 104683, "", "=q4=Softfoot's Last Resort", "=ds=#h1#, #w13#" },
				{ 22, 104697, "", "=q4=Purehearted Cricket Cage", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103799, "", "=q4=Gloomwrap Greatcloak", "=ds=#s4#", tf=105188 },
				{ 2, 103807, "", "=q4=Shoulderpads of Dou Dou Chong", "=ds=#s3#, #a1#", tf=105192 },
				{ 3, 103802, "", "=q4=Robes of the Tendered Heart", "=ds=#s5#, #a1#", tf=105191 },
				{ 4, 103809, "", "=q4=Lifebane Bracers", "=ds=#s8#, #a1#", tf=105193 },
				{ 5, 103804, "", "=q4=Sha-Seared Sandals", "=ds=#s12#, #a1#", tf=105190 },
				{ 6, 103924, "", "=q4=Shoulders of the Roiling Inferno", "=ds=#s3#, #a2#", tf=105196 },
				{ 7, 103777, "", "=q4=Stonetoe's Tormented Treads", "=ds=#s12#, #a2#", tf=105182 },
				{ 8, 103815, "", "=q4=Shoulderguards of Dark Meditations", "=ds=#s3#, #a3#", tf=105198 },
				{ 9, 103780, "", "=q4=Grips of Unending Anguish", "=ds=#s9#, #a3#", tf=105183 },
				{ 10, 103812, "", "=q4=Sabatons of Defilement", "=ds=#s12#, #a3#", tf=105197 },
				{ 11, 103820, "", "=q4=Gaze of Echoing Despair", "=ds=#s1#, #a4#", tf=105200 },
				{ 12, 103783, "", "=q4=Darkfallen Shoulderplates", "=ds=#s3#, #a4#", tf=105185 },
				{ 13, 103817, "", "=q4=Grips of the Fallen Council", "=ds=#s9#, #a4#", tf=105199 },
				{ 14, 103790, "", "=q4=Shockstriker Gauntlets", "=ds=#s9#, #a4#", tf=105186 },
				{ 15, 103787, "", "=q4=Poisonbinder Girth", "=ds=#s10#, #a4#", tf=105184 },
				{ 16, 103822, "", "=q4=Petrified Pennyroyal Ring", "=ds=#s13#", tf=105194 },
				{ 17, 103793, "", "=q4=Sorrowpath Signet", "=ds=#s13#", tf=105187 },
				{ 18, 102296, "", "=q4=Rook's Unlucky Talisman", "=ds=#s14#", tf=105189 },
				{ 20, 103776, "", "=q4=Death Lotus Crossbow", "=ds=#w3#", tf=105180 },
				{ 21, 103775, "", "=q4=Softfoot's Last Resort", "=ds=#h1#, #w13#", tf=105181 },
				{ 22, 103801, "", "=q4=Purehearted Cricket Cage", "=ds=#s15#", tf=105195 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104441, "", "=q4=Gloomwrap Greatcloak", "=ds=#s4#", tf=105437 },
				{ 2, 104445, "", "=q4=Shoulderpads of Dou Dou Chong", "=ds=#s3#, #a1#", tf=105441 },
				{ 3, 104444, "", "=q4=Robes of the Tendered Heart", "=ds=#s5#, #a1#", tf=105440 },
				{ 4, 104446, "", "=q4=Lifebane Bracers", "=ds=#s8#, #a1#", tf=105442 },
				{ 5, 104443, "", "=q4=Sha-Seared Sandals", "=ds=#s12#, #a1#", tf=105439 },
				{ 6, 104449, "", "=q4=Shoulders of the Roiling Inferno", "=ds=#s3#, #a2#", tf=105445 },
				{ 7, 104435, "", "=q4=Stonetoe's Tormented Treads", "=ds=#s12#, #a2#", tf=105431 },
				{ 8, 104451, "", "=q4=Shoulderguards of Dark Meditations", "=ds=#s3#, #a3#", tf=105447 },
				{ 9, 104436, "", "=q4=Grips of Unending Anguish", "=ds=#s9#, #a3#", tf=105432 },
				{ 10, 104450, "", "=q4=Sabatons of Defilement", "=ds=#s12#, #a3#", tf=105446 },
				{ 11, 104453, "", "=q4=Gaze of Echoing Despair", "=ds=#s1#, #a4#", tf=105449 },
				{ 12, 104438, "", "=q4=Darkfallen Shoulderplates", "=ds=#s3#, #a4#", tf=105434 },
				{ 13, 104452, "", "=q4=Grips of the Fallen Council", "=ds=#s9#, #a4#", tf=105448 },
				{ 14, 104439, "", "=q4=Shockstriker Gauntlets", "=ds=#s9#, #a4#", tf=105435 },
				{ 15, 104437, "", "=q4=Poisonbinder Girth", "=ds=#s10#, #a4#", tf=105433 },
				{ 16, 104447, "", "=q4=Petrified Pennyroyal Ring", "=ds=#s13#", tf=105443 },
				{ 17, 104440, "", "=q4=Sorrowpath Signet", "=ds=#s13#", tf=105436 },
				{ 18, 104442, "", "=q4=Rook's Unlucky Talisman", "=ds=#s14#", tf=105438 },
				{ 20, 104433, "", "=q4=Death Lotus Crossbow", "=ds=#w3#", tf=105429 },
				{ 21, 104434, "", "=q4=Softfoot's Last Resort", "=ds=#h1#, #w13#", tf=105430 },
				{ 22, 104448, "", "=q4=Purehearted Cricket Cage", "=ds=#s15#", tf=105444 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Fallen Protectors", 849),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoONorushen"] = {
		["RaidFinder"] = {
			{
				{ 1, 104960, "", "=q4=Drape of the Despairing Pit", "=ds=#s4#" },
				{ 2, 104966, "", "=q4=Rime-Rift Shoulders", "=ds=#s3#, #a1#" },
				{ 3, 104963, "", "=q4=Bracers of Broken Causation", "=ds=#s8#, #a1#" },
				{ 4, 104964, "", "=q4=Blight Hurlers", "=ds=#s9#, #a1#" },
				{ 5, 104965, "", "=q4=Sash of the Last Guardian", "=ds=#s10#, #a1#" },
				{ 6, 104954, "", "=q4=Robes of the Blackened Watcher", "=ds=#s5#, #a2#" },
				{ 7, 104970, "", "=q4=Confident Grips", "=ds=#s9#, #a2#" },
				{ 8, 104955, "", "=q4=Gloves of the Golden Protector", "=ds=#s9#, #a2#" },
				{ 9, 104969, "", "=q4=Boots of Broken Reliance", "=ds=#s12#, #a2#" },
				{ 10, 104957, "", "=q4=Quarantine Shoulderguards", "=ds=#s3#, #a3#" },
				{ 11, 104971, "", "=q4=Bracers of Final Serenity", "=ds=#s8#, #a3#" },
				{ 12, 104956, "", "=q4=Leggings of Unabashed Anger", "=ds=#s11#, #a3#" },
				{ 13, 104972, "", "=q4=Shadow-Binder's Kilt", "=ds=#s11#, #a3#" },
				{ 14, 104959, "", "=q4=Rage-Blind Greathelm", "=ds=#s1#, #a4#" },
				{ 15, 104958, "", "=q4=Bracers of Blind Hatred", "=ds=#s8#, #a4#" },
				{ 16, 104973, "", "=q4=Wristplates of Broken Doubt", "=ds=#s8#, #a4#" },
				{ 18, 104967, "", "=q4=Untainted Guardian's Chain", "=ds=#s2#" },
				{ 19, 104953, "", "=q4=Reality Ripper Ring", "=ds=#s13#" },
				{ 20, 104961, "", "=q4=Fusion-Fire Core", "=ds=#s14#" },
				{ 22, 104952, "", "=q4=Norushen's Shortblade", "=ds=#h1#, #w4#" },
				{ 23, 104962, "", "=q4=Xifeng, Longblade of the Titanic Guardian", "=ds=#h1#, #w10#" },
				{ 24, 104968, "", "=q4=Norushen's Enigmatic Barrier", "=ds=#w8#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104711, "", "=q4=Drape of the Despairing Pit", "=ds=#s4#" },
				{ 2, 104717, "", "=q4=Rime-Rift Shoulders", "=ds=#s3#, #a1#" },
				{ 3, 104714, "", "=q4=Bracers of Broken Causation", "=ds=#s8#, #a1#" },
				{ 4, 104715, "", "=q4=Blight Hurlers", "=ds=#s9#, #a1#" },
				{ 5, 104716, "", "=q4=Sash of the Last Guardian", "=ds=#s10#, #a1#" },
				{ 6, 104705, "", "=q4=Robes of the Blackened Watcher", "=ds=#s5#, #a2#" },
				{ 7, 104721, "", "=q4=Confident Grips", "=ds=#s9#, #a2#" },
				{ 8, 104706, "", "=q4=Gloves of the Golden Protector", "=ds=#s9#, #a2#" },
				{ 9, 104720, "", "=q4=Boots of Broken Reliance", "=ds=#s12#, #a2#" },
				{ 10, 104708, "", "=q4=Quarantine Shoulderguards", "=ds=#s3#, #a3#" },
				{ 11, 104722, "", "=q4=Bracers of Final Serenity", "=ds=#s8#, #a3#" },
				{ 12, 104707, "", "=q4=Leggings of Unabashed Anger", "=ds=#s11#, #a3#" },
				{ 13, 104723, "", "=q4=Shadow-Binder's Kilt", "=ds=#s11#, #a3#" },
				{ 14, 104710, "", "=q4=Rage-Blind Greathelm", "=ds=#s1#, #a4#" },
				{ 15, 104709, "", "=q4=Bracers of Blind Hatred", "=ds=#s8#, #a4#" },
				{ 16, 104724, "", "=q4=Wristplates of Broken Doubt", "=ds=#s8#, #a4#" },
				{ 18, 104718, "", "=q4=Untainted Guardian's Chain", "=ds=#s2#" },
				{ 19, 104704, "", "=q4=Reality Ripper Ring", "=ds=#s13#" },
				{ 20, 104712, "", "=q4=Fusion-Fire Core", "=ds=#s14#" },
				{ 22, 104703, "", "=q4=Norushen's Shortblade", "=ds=#h1#, #w4#" },
				{ 23, 104713, "", "=q4=Xifeng, Longblade of the Titanic Guardian", "=ds=#h1#, #w10#" },
				{ 24, 104719, "", "=q4=Norushen's Enigmatic Barrier", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103845, "", "=q4=Drape of the Despairing Pit", "=ds=#s4#", tf=105209 },
				{ 2, 103857, "", "=q4=Rime-Rift Shoulders", "=ds=#s3#, #a1#", tf=105215 },
				{ 3, 103849, "", "=q4=Bracers of Broken Causation", "=ds=#s8#, #a1#", tf=105212 },
				{ 4, 103852, "", "=q4=Blight Hurlers", "=ds=#s9#, #a1#", tf=105213 },
				{ 5, 103855, "", "=q4=Sash of the Last Guardian", "=ds=#s10#, #a1#", tf=105214 },
				{ 6, 103834, "", "=q4=Robes of the Blackened Watcher", "=ds=#s5#, #a2#", tf=105203 },
				{ 7, 103858, "", "=q4=Confident Grips", "=ds=#s9#, #a2#", tf=105219 },
				{ 8, 103830, "", "=q4=Gloves of the Golden Protector", "=ds=#s9#, #a2#", tf=105204 },
				{ 9, 103762, "", "=q4=Boots of Broken Reliance", "=ds=#s12#, #a2#", tf=105218 },
				{ 10, 103836, "", "=q4=Quarantine Shoulderguards", "=ds=#s3#, #a3#", tf=105206 },
				{ 11, 103861, "", "=q4=Bracers of Final Serenity", "=ds=#s8#, #a3#", tf=105220 },
				{ 12, 103838, "", "=q4=Leggings of Unabashed Anger", "=ds=#s11#, #a3#", tf=105205 },
				{ 13, 103942, "", "=q4=Shadow-Binder's Kilt", "=ds=#s11#, #a3#", tf=105221 },
				{ 14, 103839, "", "=q4=Rage-Blind Greathelm", "=ds=#s1#, #a4#", tf=105208 },
				{ 15, 103740, "", "=q4=Bracers of Blind Hatred", "=ds=#s8#, #a4#", tf=105207 },
				{ 16, 103864, "", "=q4=Wristplates of Broken Doubt", "=ds=#s8#, #a4#", tf=105222 },
				{ 18, 103867, "", "=q4=Untainted Guardian's Chain", "=ds=#s2#", tf=105216 },
				{ 19, 103841, "", "=q4=Reality Ripper Ring", "=ds=#s13#", tf=105202 },
				{ 20, 102295, "", "=q4=Fusion-Fire Core", "=ds=#s14#", tf=105210 },
				{ 22, 103827, "", "=q4=Norushen's Shortblade", "=ds=#h1#, #w4#", tf=105201 },
				{ 23, 103826, "", "=q4=Xifeng, Longblade of the Titanic Guardian", "=ds=#h1#, #w10#", tf=105211 },
				{ 24, 103847, "", "=q4=Norushen's Enigmatic Barrier", "=ds=#w8#", tf=105217 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104462, "", "=q4=Drape of the Despairing Pit", "=ds=#s4#", tf=105458 },
				{ 2, 104468, "", "=q4=Rime-Rift Shoulders", "=ds=#s3#, #a1#", tf=105464 },
				{ 3, 104465, "", "=q4=Bracers of Broken Causation", "=ds=#s8#, #a1#", tf=105461 },
				{ 4, 104466, "", "=q4=Blight Hurlers", "=ds=#s9#, #a1#", tf=105462 },
				{ 5, 104467, "", "=q4=Sash of the Last Guardian", "=ds=#s10#, #a1#", tf=105463 },
				{ 6, 104456, "", "=q4=Robes of the Blackened Watcher", "=ds=#s5#, #a2#", tf=105452 },
				{ 7, 104472, "", "=q4=Confident Grips", "=ds=#s9#, #a2#", tf=105468 },
				{ 8, 104457, "", "=q4=Gloves of the Golden Protector", "=ds=#s9#, #a2#", tf=105453 },
				{ 9, 104471, "", "=q4=Boots of Broken Reliance", "=ds=#s12#, #a2#", tf=105467 },
				{ 10, 104459, "", "=q4=Quarantine Shoulderguards", "=ds=#s3#, #a3#", tf=105455 },
				{ 11, 104473, "", "=q4=Bracers of Final Serenity", "=ds=#s8#, #a3#", tf=105469 },
				{ 12, 104458, "", "=q4=Leggings of Unabashed Anger", "=ds=#s11#, #a3#", tf=105454 },
				{ 13, 104474, "", "=q4=Shadow-Binder's Kilt", "=ds=#s11#, #a3#", tf=105470 },
				{ 14, 104461, "", "=q4=Rage-Blind Greathelm", "=ds=#s1#, #a4#", tf=105457 },
				{ 15, 104460, "", "=q4=Bracers of Blind Hatred", "=ds=#s8#, #a4#", tf=105456 },
				{ 16, 104475, "", "=q4=Wristplates of Broken Doubt", "=ds=#s8#, #a4#", tf=105471 },
				{ 18, 104469, "", "=q4=Untainted Guardian's Chain", "=ds=#s2#", tf=105465 },
				{ 19, 104455, "", "=q4=Reality Ripper Ring", "=ds=#s13#", tf=105451 },
				{ 20, 104463, "", "=q4=Fusion-Fire Core", "=ds=#s14#", tf=105459 },
				{ 22, 104454, "", "=q4=Norushen's Shortblade", "=ds=#h1#, #w4#", tf=105450 },
				{ 23, 104464, "", "=q4=Xifeng, Longblade of the Titanic Guardian", "=ds=#h1#, #w10#", tf=105460 },
				{ 24, 104470, "", "=q4=Norushen's Enigmatic Barrier", "=ds=#w8#", tf=105466 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Norushen", 866),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOShaofPride"] = {
		["RaidFinder"] = {
			{
				{ 1, 104978, "", "=q4=Self-Reflecting Mask", "=ds=#s1#, #a2#" },
				{ 2, 104979, "", "=q4=Crown of Boastful Words", "=ds=#s1#, #a4#" },
				{ 3, 104980, "", "=q4=Greaves of Sublime Superiority", "=ds=#s12#, #a4#" },
				{ 5, 104982, "", "=q4=Choker of the Final Word", "=ds=#s2#" },
				{ 6, 104975, "", "=q4=Necklace of Fading Light", "=ds=#s2#" },
				{ 7, 104974, "", "=q4=Assurance of Consequence", "=ds=#s14#" },
				{ 8, 104976, "", "=q4=Prismatic Prison of Pride", "=ds=#s14#" },
				{ 16, 99678, "", "=q4=Chest of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99679, "", "=q4=Chest of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99677, "", "=q4=Chest of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104977, "", "=q4=Gaze of Arrogance", "=ds=#w9#" },
				{ 21, 104981, "", "=q4=Greatsword of Pride's Fall", "=ds=#h2#, #w10#" },
				{ 22, 104983, "", "=q4=Shield of Mockery", "=ds=#w8#" },
				{ 24, 104163, "", "=q3=Gooey Sha-ling", "=ds=#e13#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104729, "", "=q4=Self-Reflecting Mask", "=ds=#s1#, #a2#" },
				{ 2, 104730, "", "=q4=Crown of Boastful Words", "=ds=#s1#, #a4#" },
				{ 3, 104731, "", "=q4=Greaves of Sublime Superiority", "=ds=#s12#, #a4#" },
				{ 5, 104733, "", "=q4=Choker of the Final Word", "=ds=#s2#" },
				{ 6, 104726, "", "=q4=Necklace of Fading Light", "=ds=#s2#" },
				{ 7, 104725, "", "=q4=Assurance of Consequence", "=ds=#s14#" },
				{ 8, 104727, "", "=q4=Prismatic Prison of Pride", "=ds=#s14#" },
				{ 16, 99743, "", "=q4=Chest of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99744, "", "=q4=Chest of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99742, "", "=q4=Chest of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104728, "", "=q4=Gaze of Arrogance", "=ds=#w9#" },
				{ 21, 104732, "", "=q4=Greatsword of Pride's Fall", "=ds=#h2#, #w10#" },
				{ 22, 104734, "", "=q4=Shield of Mockery", "=ds=#w8#" },
				{ 24, 104162, "", "=q3=Droplet of Y'Shaarj", "=ds=#e13#" },
				{ 25, 104163, "", "=q3=Gooey Sha-ling", "=ds=#e13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103876, "", "=q4=Self-Reflecting Mask", "=ds=#s1#, #a2#", tf=105227 },
				{ 2, 103821, "", "=q4=Crown of Boastful Words", "=ds=#s1#, #a4#", tf=105228 },
				{ 3, 103878, "", "=q4=Greaves of Sublime Superiority", "=ds=#s12#, #a4#", tf=105229 },
				{ 5, 103883, "", "=q4=Choker of the Final Word", "=ds=#s2#", tf=105231 },
				{ 6, 103881, "", "=q4=Necklace of Fading Light", "=ds=#s2#", tf=105224 },
				{ 7, 102292, "", "=q4=Assurance of Consequence", "=ds=#s14#", tf=105223 },
				{ 8, 102299, "", "=q4=Prismatic Prison of Pride", "=ds=#s14#", tf=105225 },
				{ 16, 99686, "", "=q4=Chest of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99691, "", "=q4=Chest of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99696, "", "=q4=Chest of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 103873, "", "=q4=Gaze of Arrogance", "=ds=#w9#", tf=105226 },
				{ 21, 103869, "", "=q4=Greatsword of Pride's Fall", "=ds=#h2#, #w10#", tf=105230 },
				{ 22, 103870, "", "=q4=Shield of Mockery", "=ds=#w8#", tf=105232 },
				{ 24, 104162, "", "=q3=Droplet of Y'Shaarj", "=ds=#e13#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104480, "", "=q4=Self-Reflecting Mask", "=ds=#s1#, #a2#", tf=105476 },
				{ 2, 104481, "", "=q4=Crown of Boastful Words", "=ds=#s1#, #a4#", tf=105477 },
				{ 3, 104482, "", "=q4=Greaves of Sublime Superiority", "=ds=#s12#, #a4#", tf=105478 },
				{ 5, 104484, "", "=q4=Choker of the Final Word", "=ds=#s2#", tf=105480 },
				{ 6, 104477, "", "=q4=Necklace of Fading Light", "=ds=#s2#", tf=105473 },
				{ 7, 104476, "", "=q4=Assurance of Consequence", "=ds=#s14#", tf=105472 },
				{ 8, 104478, "", "=q4=Prismatic Prison of Pride", "=ds=#s14#", tf=105474 },
				{ 16, 99715, "", "=q4=Chest of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99716, "", "=q4=Chest of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99714, "", "=q4=Chest of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104479, "", "=q4=Gaze of Arrogance", "=ds=#w9#", tf=105475 },
				{ 21, 104483, "", "=q4=Greatsword of Pride's Fall", "=ds=#h2#, #w10#", tf=105479 },
				{ 22, 104485, "", "=q4=Shield of Mockery", "=ds=#w8#", tf=105481 },
				{ 24, 104162, "", "=q3=Droplet of Y'Shaarj", "=ds=#e13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sha of Pride", 867),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOGalakras"] = {
		["RaidFinder"] = {
			{
				{ 1, 104997, "", "=q4=Flameslinger's Fiery Cowl", "=ds=#s1#, #a1#" },
				{ 2, 104999, "", "=q4=Shoulderpads of Pulsing Protection", "=ds=#s3#, #a1#" },
				{ 3, 104996, "", "=q4=Scalebane Bracers", "=ds=#s8#, #a1#" },
				{ 4, 104995, "", "=q4=Bone-Inlaid Sandals", "=ds=#s12#, #a1#" },
				{ 5, 104998, "", "=q4=Skydancer Boots", "=ds=#s12#, #a1#" },
				{ 6, 104987, "", "=q4=Korgra's Venom-Soaked Gauntlets", "=ds=#s9#, #a2#" },
				{ 7, 105002, "", "=q4=Dragonmaw Emergency Strap", "=ds=#s10#, #a2#" },
				{ 8, 104986, "", "=q4=Unrepentant Heels", "=ds=#s12#, #a2#" },
				{ 9, 104989, "", "=q4=Dagryn's Fuselight Bracers", "=ds=#s8#, #a3#" },
				{ 10, 105003, "", "=q4=Grips of Tidal Force", "=ds=#s9#, #a3#" },
				{ 11, 104988, "", "=q4=Cannoneer's Multipocket Gunbelt", "=ds=#s10#, #a3#" },
				{ 12, 104990, "", "=q4=Thranok's Shattering Helm", "=ds=#s1#, #a4#" },
				{ 13, 104992, "", "=q4=Krugruk's Rigid Shoulderplates", "=ds=#s3#, #a4#" },
				{ 14, 104991, "", "=q4=Arcsmasher Bracers", "=ds=#s8#, #a4#" },
				{ 15, 105004, "", "=q4=Smoldering Drakescale Bracers", "=ds=#s8#, #a4#" },
				{ 16, 105005, "", "=q4=Windfire Legplates", "=ds=#s11#, #a4#" },
				{ 18, 105000, "", "=q4=Extinguished Ember of Galakras", "=ds=#s13#" },
				{ 19, 104994, "", "=q4=Galakrond Control Band", "=ds=#s13#" },
				{ 20, 104985, "", "=q4=Swift Serpent Signet", "=ds=#s13#" },
				{ 21, 104993, "", "=q4=Evil Eye of Galakras", "=ds=#s14#" },
				{ 23, 104984, "", "=q4=Dagryn's Discarded Longbow", "=ds=#w2#" },
				{ 24, 105001, "", "=q4=Drakebinder Greatstaff", "=ds=#w9#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104748, "", "=q4=Flameslinger's Fiery Cowl", "=ds=#s1#, #a1#" },
				{ 2, 104750, "", "=q4=Shoulderpads of Pulsing Protection", "=ds=#s3#, #a1#" },
				{ 3, 104747, "", "=q4=Scalebane Bracers", "=ds=#s8#, #a1#" },
				{ 4, 104746, "", "=q4=Bone-Inlaid Sandals", "=ds=#s12#, #a1#" },
				{ 5, 104749, "", "=q4=Skydancer Boots", "=ds=#s12#, #a1#" },
				{ 6, 104738, "", "=q4=Korgra's Venom-Soaked Gauntlets", "=ds=#s9#, #a2#" },
				{ 7, 104753, "", "=q4=Dragonmaw Emergency Strap", "=ds=#s10#, #a2#" },
				{ 8, 104737, "", "=q4=Unrepentant Heels", "=ds=#s12#, #a2#" },
				{ 9, 104740, "", "=q4=Dagryn's Fuselight Bracers", "=ds=#s8#, #a3#" },
				{ 10, 104754, "", "=q4=Grips of Tidal Force", "=ds=#s9#, #a3#" },
				{ 11, 104739, "", "=q4=Cannoneer's Multipocket Gunbelt", "=ds=#s10#, #a3#" },
				{ 12, 104741, "", "=q4=Thranok's Shattering Helm", "=ds=#s1#, #a4#" },
				{ 13, 104743, "", "=q4=Krugruk's Rigid Shoulderplates", "=ds=#s3#, #a4#" },
				{ 14, 104742, "", "=q4=Arcsmasher Bracers", "=ds=#s8#, #a4#" },
				{ 15, 104755, "", "=q4=Smoldering Drakescale Bracers", "=ds=#s8#, #a4#" },
				{ 16, 104756, "", "=q4=Windfire Legplates", "=ds=#s11#, #a4#" },
				{ 18, 104751, "", "=q4=Extinguished Ember of Galakras", "=ds=#s13#" },
				{ 19, 104745, "", "=q4=Galakrond Control Band", "=ds=#s13#" },
				{ 20, 104736, "", "=q4=Swift Serpent Signet", "=ds=#s13#" },
				{ 21, 104744, "", "=q4=Evil Eye of Galakras", "=ds=#s14#" },
				{ 23, 104735, "", "=q4=Dagryn's Discarded Longbow", "=ds=#w2#" },
				{ 24, 104752, "", "=q4=Drakebinder Greatstaff", "=ds=#w9#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103900, "", "=q4=Flameslinger's Fiery Cowl", "=ds=#s1#, #a1#", tf=105246 },
				{ 2, 103756, "", "=q4=Shoulderpads of Pulsing Protection", "=ds=#s3#, #a1#", tf=105248 },
				{ 3, 103850, "", "=q4=Scalebane Bracers", "=ds=#s8#, #a1#", tf=105245 },
				{ 4, 103805, "", "=q4=Bone-Inlaid Sandals", "=ds=#s12#, #a1#", tf=105244 },
				{ 5, 103902, "", "=q4=Skydancer Boots", "=ds=#s12#, #a1#", tf=105247 },
				{ 6, 103831, "", "=q4=Korgra's Venom-Soaked Gauntlets", "=ds=#s9#, #a2#", tf=105236 },
				{ 7, 103905, "", "=q4=Dragonmaw Emergency Strap", "=ds=#s10#, #a2#", tf=105251 },
				{ 8, 103778, "", "=q4=Unrepentant Heels", "=ds=#s12#, #a2#", tf=105235 },
				{ 9, 103889, "", "=q4=Dagryn's Fuselight Bracers", "=ds=#s8#, #a3#", tf=105238 },
				{ 10, 103765, "", "=q4=Grips of Tidal Force", "=ds=#s9#, #a3#", tf=105252 },
				{ 11, 103887, "", "=q4=Cannoneer's Multipocket Gunbelt", "=ds=#s10#, #a3#", tf=105237 },
				{ 12, 103892, "", "=q4=Thranok's Shattering Helm", "=ds=#s1#, #a4#", tf=105239 },
				{ 13, 103748, "", "=q4=Krugruk's Rigid Shoulderplates", "=ds=#s3#, #a4#", tf=105241 },
				{ 14, 103743, "", "=q4=Arcsmasher Bracers", "=ds=#s8#, #a4#", tf=105240 },
				{ 15, 103865, "", "=q4=Smoldering Drakescale Bracers", "=ds=#s8#, #a4#", tf=105253 },
				{ 16, 103907, "", "=q4=Windfire Legplates", "=ds=#s11#, #a4#", tf=105254 },
				{ 18, 103823, "", "=q4=Extinguished Ember of Galakras", "=ds=#s13#", tf=105249 },
				{ 19, 103894, "", "=q4=Galakrond Control Band", "=ds=#s13#", tf=105243 },
				{ 20, 103842, "", "=q4=Swift Serpent Signet", "=ds=#s13#", tf=105234 },
				{ 21, 102298, "", "=q4=Evil Eye of Galakras", "=ds=#s14#", tf=105242 },
				{ 23, 103885, "", "=q4=Dagryn's Discarded Longbow", "=ds=#w2#", tf=105233 },
				{ 24, 103875, "", "=q4=Drakebinder Greatstaff", "=ds=#w9#", tf=105250 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104499, "", "=q4=Flameslinger's Fiery Cowl", "=ds=#s1#, #a1#", tf=105495 },
				{ 2, 104501, "", "=q4=Shoulderpads of Pulsing Protection", "=ds=#s3#, #a1#", tf=105497 },
				{ 3, 104498, "", "=q4=Scalebane Bracers", "=ds=#s8#, #a1#", tf=105494 },
				{ 4, 104497, "", "=q4=Bone-Inlaid Sandals", "=ds=#s12#, #a1#", tf=105493 },
				{ 5, 104500, "", "=q4=Skydancer Boots", "=ds=#s12#, #a1#", tf=105496 },
				{ 6, 104489, "", "=q4=Korgra's Venom-Soaked Gauntlets", "=ds=#s9#, #a2#", tf=105485 },
				{ 7, 104504, "", "=q4=Dragonmaw Emergency Strap", "=ds=#s10#, #a2#", tf=105500 },
				{ 8, 104488, "", "=q4=Unrepentant Heels", "=ds=#s12#, #a2#", tf=105484 },
				{ 9, 104491, "", "=q4=Dagryn's Fuselight Bracers", "=ds=#s8#, #a3#", tf=105487 },
				{ 10, 104505, "", "=q4=Grips of Tidal Force", "=ds=#s9#, #a3#", tf=105501 },
				{ 11, 104490, "", "=q4=Cannoneer's Multipocket Gunbelt", "=ds=#s10#, #a3#", tf=105486 },
				{ 12, 104492, "", "=q4=Thranok's Shattering Helm", "=ds=#s1#, #a4#", tf=105488 },
				{ 13, 104494, "", "=q4=Krugruk's Rigid Shoulderplates", "=ds=#s3#, #a4#", tf=105490 },
				{ 14, 104493, "", "=q4=Arcsmasher Bracers", "=ds=#s8#, #a4#", tf=105489 },
				{ 15, 104506, "", "=q4=Smoldering Drakescale Bracers", "=ds=#s8#, #a4#", tf=105502 },
				{ 16, 104507, "", "=q4=Windfire Legplates", "=ds=#s11#, #a4#", tf=105503 },
				{ 18, 104502, "", "=q4=Extinguished Ember of Galakras", "=ds=#s13#", tf=105498 },
				{ 19, 104496, "", "=q4=Galakrond Control Band", "=ds=#s13#", tf=105492 },
				{ 20, 104487, "", "=q4=Swift Serpent Signet", "=ds=#s13#", tf=105483 },
				{ 21, 104495, "", "=q4=Evil Eye of Galakras", "=ds=#s14#", tf=105491 },
				{ 23, 104486, "", "=q4=Dagryn's Discarded Longbow", "=ds=#w2#", tf=105482 },
				{ 24, 104503, "", "=q4=Drakebinder Greatstaff", "=ds=#w9#", tf=105499 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Galakras", 868),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOIronJuggernaut"] = {
		["RaidFinder"] = {
			{
				{ 1, 105021, "", "=q4=Shock Pulse Robes", "=ds=#s5#, #a1#" },
				{ 2, 105019, "", "=q4=Bracers of the Broken Fault", "=ds=#s8#, #a1#" },
				{ 3, 105020, "", "=q4=Earthripper Gloves", "=ds=#s9#, #a1#" },
				{ 4, 105017, "", "=q4=Belt of Ominous Trembles", "=ds=#s10#, #a1#" },
				{ 5, 105018, "", "=q4=Leggings of Furious Flame", "=ds=#s11#, #a1#" },
				{ 6, 105008, "", "=q4=Ricocheting Shoulderguards", "=ds=#s3#, #a2#" },
				{ 7, 105024, "", "=q4=Castlebreaker Bracers", "=ds=#s8#, #a2#" },
				{ 8, 105007, "", "=q4=Laser Burn Bracers", "=ds=#s8#, #a2#" },
				{ 9, 105026, "", "=q4=Cavemaker Wristguards", "=ds=#s8#, #a3#" },
				{ 10, 105010, "", "=q4=Precision Cutters", "=ds=#s9#, #a3#" },
				{ 11, 105009, "", "=q4=Minelayer's Padded Boots", "=ds=#s12#, #a3#" },
				{ 12, 105025, "", "=q4=Treads of Autonomic Motion", "=ds=#s12#, #a3#" },
				{ 13, 105014, "", "=q4=Earthbreaker's Steaming Chestplate", "=ds=#s5#, #a4#" },
				{ 14, 105012, "", "=q4=Wall-Borer Bracers", "=ds=#s8#, #a4#" },
				{ 15, 105013, "", "=q4=Tar-Coated Gauntlets", "=ds=#s9#, #a4#" },
				{ 16, 105011, "", "=q4=Demolisher's Reinforced Belt", "=ds=#s10#, #a4#" },
				{ 17, 105027, "", "=q4=Borer Drill Boots", "=ds=#s12#, #a4#" },
				{ 19, 105015, "", "=q4=Juggernaut's Ignition Keys", "=ds=#s2#" },
				{ 20, 105022, "", "=q4=Laser-Slice Signet", "=ds=#s13#" },
				{ 21, 105016, "", "=q4=Juggernaut's Focusing Crystal", "=ds=#s14#" },
				{ 23, 105006, "", "=q4=Seismic Bore", "=ds=#h1#, #w6#" },
				{ 24, 105023, "", "=q4=Juggernaut's Power Core", "=ds=#s15#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104772, "", "=q4=Shock Pulse Robes", "=ds=#s5#, #a1#" },
				{ 2, 104770, "", "=q4=Bracers of the Broken Fault", "=ds=#s8#, #a1#" },
				{ 3, 104771, "", "=q4=Earthripper Gloves", "=ds=#s9#, #a1#" },
				{ 4, 104768, "", "=q4=Belt of Ominous Trembles", "=ds=#s10#, #a1#" },
				{ 5, 104769, "", "=q4=Leggings of Furious Flame", "=ds=#s11#, #a1#" },
				{ 6, 104759, "", "=q4=Ricocheting Shoulderguards", "=ds=#s3#, #a2#" },
				{ 7, 104775, "", "=q4=Castlebreaker Bracers", "=ds=#s8#, #a2#" },
				{ 8, 104758, "", "=q4=Laser Burn Bracers", "=ds=#s8#, #a2#" },
				{ 9, 104777, "", "=q4=Cavemaker Wristguards", "=ds=#s8#, #a3#" },
				{ 10, 104761, "", "=q4=Precision Cutters", "=ds=#s9#, #a3#" },
				{ 11, 104760, "", "=q4=Minelayer's Padded Boots", "=ds=#s12#, #a3#" },
				{ 12, 104776, "", "=q4=Treads of Autonomic Motion", "=ds=#s12#, #a3#" },
				{ 13, 104765, "", "=q4=Earthbreaker's Steaming Chestplate", "=ds=#s5#, #a4#" },
				{ 14, 104763, "", "=q4=Wall-Borer Bracers", "=ds=#s8#, #a4#" },
				{ 15, 104764, "", "=q4=Tar-Coated Gauntlets", "=ds=#s9#, #a4#" },
				{ 16, 104762, "", "=q4=Demolisher's Reinforced Belt", "=ds=#s10#, #a4#" },
				{ 17, 104778, "", "=q4=Borer Drill Boots", "=ds=#s12#, #a4#" },
				{ 19, 104766, "", "=q4=Juggernaut's Ignition Keys", "=ds=#s2#" },
				{ 20, 104773, "", "=q4=Laser-Slice Signet", "=ds=#s13#" },
				{ 21, 104767, "", "=q4=Juggernaut's Focusing Crystal", "=ds=#s14#" },
				{ 23, 104757, "", "=q4=Seismic Bore", "=ds=#h1#, #w6#" },
				{ 24, 104774, "", "=q4=Juggernaut's Power Core", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103922, "", "=q4=Shock Pulse Robes", "=ds=#s5#, #a1#", tf=105270 },
				{ 2, 103811, "", "=q4=Bracers of the Broken Fault", "=ds=#s8#, #a1#", tf=105268 },
				{ 3, 103754, "", "=q4=Earthripper Gloves", "=ds=#s9#, #a1#", tf=105269 },
				{ 4, 103898, "", "=q4=Belt of Ominous Trembles", "=ds=#s10#, #a1#", tf=105266 },
				{ 5, 103921, "", "=q4=Leggings of Furious Flame", "=ds=#s11#, #a1#", tf=105267 },
				{ 6, 103912, "", "=q4=Ricocheting Shoulderguards", "=ds=#s3#, #a2#", tf=105257 },
				{ 7, 103759, "", "=q4=Castlebreaker Bracers", "=ds=#s8#, #a2#", tf=105273 },
				{ 8, 103909, "", "=q4=Laser Burn Bracers", "=ds=#s8#, #a2#", tf=105256 },
				{ 9, 103863, "", "=q4=Cavemaker Wristguards", "=ds=#s8#, #a3#", tf=105275 },
				{ 10, 103782, "", "=q4=Precision Cutters", "=ds=#s9#, #a3#", tf=105259 },
				{ 11, 103731, "", "=q4=Minelayer's Padded Boots", "=ds=#s12#, #a3#", tf=105258 },
				{ 12, 103813, "", "=q4=Treads of Autonomic Motion", "=ds=#s12#, #a3#", tf=105274 },
				{ 13, 103914, "", "=q4=Earthbreaker's Steaming Chestplate", "=ds=#s5#, #a4#", tf=105263 },
				{ 14, 103739, "", "=q4=Wall-Borer Bracers", "=ds=#s8#, #a4#", tf=105261 },
				{ 15, 103735, "", "=q4=Tar-Coated Gauntlets", "=ds=#s9#, #a4#", tf=105262 },
				{ 16, 103788, "", "=q4=Demolisher's Reinforced Belt", "=ds=#s10#, #a4#", tf=105260 },
				{ 17, 103767, "", "=q4=Borer Drill Boots", "=ds=#s12#, #a4#", tf=105276 },
				{ 19, 103916, "", "=q4=Juggernaut's Ignition Keys", "=ds=#s2#", tf=105264 },
				{ 20, 103773, "", "=q4=Laser-Slice Signet", "=ds=#s13#", tf=105271 },
				{ 21, 102297, "", "=q4=Juggernaut's Focusing Crystal", "=ds=#s14#", tf=105265 },
				{ 23, 103908, "", "=q4=Seismic Bore", "=ds=#h1#, #w6#", tf=105255 },
				{ 24, 103918, "", "=q4=Juggernaut's Power Core", "=ds=#s15#", tf=105272 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104523, "", "=q4=Shock Pulse Robes", "=ds=#s5#, #a1#", tf=105519 },
				{ 2, 104521, "", "=q4=Bracers of the Broken Fault", "=ds=#s8#, #a1#", tf=105517 },
				{ 3, 104522, "", "=q4=Earthripper Gloves", "=ds=#s9#, #a1#", tf=105518 },
				{ 4, 104519, "", "=q4=Belt of Ominous Trembles", "=ds=#s10#, #a1#", tf=105515 },
				{ 5, 104520, "", "=q4=Leggings of Furious Flame", "=ds=#s11#, #a1#", tf=105516 },
				{ 6, 104510, "", "=q4=Ricocheting Shoulderguards", "=ds=#s3#, #a2#", tf=105506 },
				{ 7, 104526, "", "=q4=Castlebreaker Bracers", "=ds=#s8#, #a2#", tf=105522 },
				{ 8, 104509, "", "=q4=Laser Burn Bracers", "=ds=#s8#, #a2#", tf=105505 },
				{ 9, 104528, "", "=q4=Cavemaker Wristguards", "=ds=#s8#, #a3#", tf=105524 },
				{ 10, 104512, "", "=q4=Precision Cutters", "=ds=#s9#, #a3#", tf=105508 },
				{ 11, 104511, "", "=q4=Minelayer's Padded Boots", "=ds=#s12#, #a3#", tf=105507 },
				{ 12, 104527, "", "=q4=Treads of Autonomic Motion", "=ds=#s12#, #a3#", tf=105523 },
				{ 13, 104516, "", "=q4=Earthbreaker's Steaming Chestplate", "=ds=#s5#, #a4#", tf=105512 },
				{ 14, 104514, "", "=q4=Wall-Borer Bracers", "=ds=#s8#, #a4#", tf=105510 },
				{ 15, 104515, "", "=q4=Tar-Coated Gauntlets", "=ds=#s9#, #a4#", tf=105511 },
				{ 16, 104513, "", "=q4=Demolisher's Reinforced Belt", "=ds=#s10#, #a4#", tf=105509 },
				{ 17, 104529, "", "=q4=Borer Drill Boots", "=ds=#s12#, #a4#", tf=105525 },
				{ 19, 104517, "", "=q4=Juggernaut's Ignition Keys", "=ds=#s2#", tf=105513 },
				{ 20, 104524, "", "=q4=Laser-Slice Signet", "=ds=#s13#", tf=105520 },
				{ 21, 104518, "", "=q4=Juggernaut's Focusing Crystal", "=ds=#s14#", tf=105514 },
				{ 23, 104508, "", "=q4=Seismic Bore", "=ds=#h1#, #w6#", tf=105504 },
				{ 24, 104525, "", "=q4=Juggernaut's Power Core", "=ds=#s15#", tf=105521 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Iron Juggernaut", 864),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoODarkShaman"] = {
		["RaidFinder"] = {
			{
				{ 1, 105028, "", "=q4=Poisonmist Nightcloak", "=ds=#s4#" },
				{ 2, 105040, "", "=q4=Iron Wolf Hood", "=ds=#s1#, #a1#" },
				{ 3, 105039, "", "=q4=Toxic Tornado Treads", "=ds=#s12#, #a1#" },
				{ 4, 105044, "", "=q4=Darkfang Mask", "=ds=#s1#, #a2#" },
				{ 5, 105030, "", "=q4=Damron's Belt of Darkness", "=ds=#s10#, #a2#" },
				{ 6, 105031, "", "=q4=Riou's Vigilant Leggings", "=ds=#s11#, #a2#" },
				{ 7, 105032, "", "=q4=Haromm's Horrifying Helm", "=ds=#s1#, #a3#" },
				{ 8, 105046, "", "=q4=Shoulderguards of Foul Streams", "=ds=#s3#, #a3#" },
				{ 9, 105045, "", "=q4=Belt of the Iron Prison", "=ds=#s10#, #a3#" },
				{ 10, 105048, "", "=q4=Shoulderplates of Gushing Geysers", "=ds=#s3#, #a4#" },
				{ 11, 105034, "", "=q4=Breastplate of Shamanic Mirrors", "=ds=#s5#, #a4#" },
				{ 12, 105047, "", "=q4=Shackles of Stinking Slime", "=ds=#s8#, #a4#" },
				{ 13, 105035, "", "=q4=Ashen Wall Girdle", "=ds=#s10#, #a4#" },
				{ 14, 105033, "", "=q4=Wolf-Rider Spurs", "=ds=#s12#, #a4#" },
				{ 16, 105041, "", "=q4=Ashflare Pendant", "=ds=#s2#" },
				{ 17, 105036, "", "=q4=Bloodclaw Band", "=ds=#s13#" },
				{ 18, 105038, "", "=q4=Ring of the Iron Tomb", "=ds=#s13#" },
				{ 19, 105029, "", "=q4=Haromm's Talisman", "=ds=#s14#" },
				{ 20, 105042, "", "=q4=Kardris' Toxic Totem", "=ds=#s14#" },
				{ 22, 105037, "", "=q4=Haromm's Frozen Crescent", "=ds=#h1#, #w1#" },
				{ 23, 105043, "", "=q4=Kardris' Scepter", "=ds=#h1#, #w6#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104779, "", "=q4=Poisonmist Nightcloak", "=ds=#s4#" },
				{ 2, 104791, "", "=q4=Iron Wolf Hood", "=ds=#s1#, #a1#" },
				{ 3, 104790, "", "=q4=Toxic Tornado Treads", "=ds=#s12#, #a1#" },
				{ 4, 104795, "", "=q4=Darkfang Mask", "=ds=#s1#, #a2#" },
				{ 5, 104781, "", "=q4=Damron's Belt of Darkness", "=ds=#s10#, #a2#" },
				{ 6, 104782, "", "=q4=Riou's Vigilant Leggings", "=ds=#s11#, #a2#" },
				{ 7, 104783, "", "=q4=Haromm's Horrifying Helm", "=ds=#s1#, #a3#" },
				{ 8, 104797, "", "=q4=Shoulderguards of Foul Streams", "=ds=#s3#, #a3#" },
				{ 9, 104796, "", "=q4=Belt of the Iron Prison", "=ds=#s10#, #a3#" },
				{ 10, 104799, "", "=q4=Shoulderplates of Gushing Geysers", "=ds=#s3#, #a4#" },
				{ 11, 104785, "", "=q4=Breastplate of Shamanic Mirrors", "=ds=#s5#, #a4#" },
				{ 12, 104798, "", "=q4=Shackles of Stinking Slime", "=ds=#s8#, #a4#" },
				{ 13, 104786, "", "=q4=Ashen Wall Girdle", "=ds=#s10#, #a4#" },
				{ 14, 104784, "", "=q4=Wolf-Rider Spurs", "=ds=#s12#, #a4#" },
				{ 16, 104792, "", "=q4=Ashflare Pendant", "=ds=#s2#" },
				{ 17, 104787, "", "=q4=Bloodclaw Band", "=ds=#s13#" },
				{ 18, 104789, "", "=q4=Ring of the Iron Tomb", "=ds=#s13#" },
				{ 19, 104780, "", "=q4=Haromm's Talisman", "=ds=#s14#" },
				{ 20, 104793, "", "=q4=Kardris' Toxic Totem", "=ds=#s14#" },
				{ 22, 104788, "", "=q4=Haromm's Frozen Crescent", "=ds=#h1#, #w1#" },
				{ 23, 104794, "", "=q4=Kardris' Scepter", "=ds=#h1#, #w6#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103934, "", "=q4=Poisonmist Nightcloak", "=ds=#s4#", tf=105277 },
				{ 2, 103938, "", "=q4=Iron Wolf Hood", "=ds=#s1#, #a1#", tf=105289 },
				{ 3, 103806, "", "=q4=Toxic Tornado Treads", "=ds=#s12#, #a1#", tf=105288 },
				{ 4, 103877, "", "=q4=Darkfang Mask", "=ds=#s1#, #a2#", tf=105293 },
				{ 5, 103927, "", "=q4=Damron's Belt of Darkness", "=ds=#s10#, #a2#", tf=105279 },
				{ 6, 103929, "", "=q4=Riou's Vigilant Leggings", "=ds=#s11#, #a2#", tf=105280 },
				{ 7, 103930, "", "=q4=Haromm's Horrifying Helm", "=ds=#s1#, #a3#", tf=105281 },
				{ 8, 103816, "", "=q4=Shoulderguards of Foul Streams", "=ds=#s3#, #a3#", tf=105295 },
				{ 9, 103940, "", "=q4=Belt of the Iron Prison", "=ds=#s10#, #a3#", tf=105294 },
				{ 10, 103943, "", "=q4=Shoulderplates of Gushing Geysers", "=ds=#s3#, #a4#", tf=105297 },
				{ 11, 103737, "", "=q4=Breastplate of Shamanic Mirrors", "=ds=#s5#, #a4#", tf=105283 },
				{ 12, 103866, "", "=q4=Shackles of Stinking Slime", "=ds=#s8#, #a4#", tf=105296 },
				{ 13, 103932, "", "=q4=Ashen Wall Girdle", "=ds=#s10#, #a4#", tf=105284 },
				{ 14, 103880, "", "=q4=Wolf-Rider Spurs", "=ds=#s12#, #a4#", tf=105282 },
				{ 16, 103868, "", "=q4=Ashflare Pendant", "=ds=#s2#", tf=105290 },
				{ 17, 103798, "", "=q4=Bloodclaw Band", "=ds=#s13#", tf=105285 },
				{ 18, 103895, "", "=q4=Ring of the Iron Tomb", "=ds=#s13#", tf=105287 },
				{ 19, 102301, "", "=q4=Haromm's Talisman", "=ds=#s14#", tf=105278 },
				{ 20, 102300, "", "=q4=Kardris' Toxic Totem", "=ds=#s14#", tf=105291 },
				{ 22, 103926, "", "=q4=Haromm's Frozen Crescent", "=ds=#h1#, #w1#", tf=105286 },
				{ 23, 103936, "", "=q4=Kardris' Scepter", "=ds=#h1#, #w6#", tf=105292 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104530, "", "=q4=Poisonmist Nightcloak", "=ds=#s4#", tf=105526 },
				{ 2, 104542, "", "=q4=Iron Wolf Hood", "=ds=#s1#, #a1#", tf=105538 },
				{ 3, 104541, "", "=q4=Toxic Tornado Treads", "=ds=#s12#, #a1#", tf=105537 },
				{ 4, 104546, "", "=q4=Darkfang Mask", "=ds=#s1#, #a2#", tf=105542 },
				{ 5, 104532, "", "=q4=Damron's Belt of Darkness", "=ds=#s10#, #a2#", tf=105528 },
				{ 6, 104533, "", "=q4=Riou's Vigilant Leggings", "=ds=#s11#, #a2#", tf=105529 },
				{ 7, 104534, "", "=q4=Haromm's Horrifying Helm", "=ds=#s1#, #a3#", tf=105530 },
				{ 8, 104548, "", "=q4=Shoulderguards of Foul Streams", "=ds=#s3#, #a3#", tf=105544 },
				{ 9, 104547, "", "=q4=Belt of the Iron Prison", "=ds=#s10#, #a3#", tf=105543 },
				{ 10, 104550, "", "=q4=Shoulderplates of Gushing Geysers", "=ds=#s3#, #a4#", tf=105546 },
				{ 11, 104536, "", "=q4=Breastplate of Shamanic Mirrors", "=ds=#s5#, #a4#", tf=105532 },
				{ 12, 104549, "", "=q4=Shackles of Stinking Slime", "=ds=#s8#, #a4#", tf=105545 },
				{ 13, 104537, "", "=q4=Ashen Wall Girdle", "=ds=#s10#, #a4#", tf=105533 },
				{ 14, 104535, "", "=q4=Wolf-Rider Spurs", "=ds=#s12#, #a4#", tf=105531 },
				{ 16, 104543, "", "=q4=Ashflare Pendant", "=ds=#s2#", tf=105539 },
				{ 17, 104538, "", "=q4=Bloodclaw Band", "=ds=#s13#", tf=105534 },
				{ 18, 104540, "", "=q4=Ring of the Iron Tomb", "=ds=#s13#", tf=105536 },
				{ 19, 104531, "", "=q4=Haromm's Talisman", "=ds=#s14#", tf=105527 },
				{ 20, 104544, "", "=q4=Kardris' Toxic Totem", "=ds=#s14#", tf=105540 },
				{ 22, 104539, "", "=q4=Haromm's Frozen Crescent", "=ds=#h1#, #w1#", tf=105535 },
				{ 23, 104545, "", "=q4=Kardris' Scepter", "=ds=#h1#, #w6#", tf=105541 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Kor'kron Dark Shaman", 856),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoONazgrim"] = {
		["RaidFinder"] = {
			{
				{ 1, 105059, "", "=q4=Spaulders of Kor'kron Fealty", "=ds=#s3#, #a1#" },
				{ 2, 105050, "", "=q4=Sandals of Two Little Bees", "=ds=#s12#, #a1#" },
				{ 3, 105053, "", "=q4=Shoulderguards of the Righteous Stand", "=ds=#s3#, #a2#" },
				{ 4, 105054, "", "=q4=Robes of the Warrior's Fall", "=ds=#s5#, #a2#" },
				{ 5, 105056, "", "=q4=Crown of Tragic Truth", "=ds=#s1#, #a3#" },
				{ 6, 105055, "", "=q4=Ravager's Pathwalkers", "=ds=#s12#, #a3#" },
				{ 8, 105051, "", "=q4=Nazgrim's Burnished Insignia", "=ds=#s14#" },
				{ 16, 99681, "", "=q4=Gauntlets of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99667, "", "=q4=Gauntlets of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99680, "", "=q4=Gauntlets of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 105052, "", "=q4=Arcweaver Spell Sword", "=ds=#h1#, #w10#" },
				{ 21, 105057, "", "=q4=Gar'tok, Strength of the Faithful", "=ds=#h2#, #w6#" },
				{ 22, 105049, "", "=q4=Nazgrim's Gutripper", "=ds=#h1#, #w4#" },
				{ 23, 105058, "", "=q4=Bulwark of the Fallen General", "=ds=#w8#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104810, "", "=q4=Spaulders of Kor'kron Fealty", "=ds=#s3#, #a1#" },
				{ 2, 104801, "", "=q4=Sandals of Two Little Bees", "=ds=#s12#, #a1#" },
				{ 3, 104804, "", "=q4=Shoulderguards of the Righteous Stand", "=ds=#s3#, #a2#" },
				{ 4, 104805, "", "=q4=Robes of the Warrior's Fall", "=ds=#s5#, #a2#" },
				{ 5, 104807, "", "=q4=Crown of Tragic Truth", "=ds=#s1#, #a3#" },
				{ 6, 104806, "", "=q4=Ravager's Pathwalkers", "=ds=#s12#, #a3#" },
				{ 8, 104802, "", "=q4=Nazgrim's Burnished Insignia", "=ds=#s14#" },
				{ 16, 99746, "", "=q4=Gauntlets of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99747, "", "=q4=Gauntlets of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99745, "", "=q4=Gauntlets of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104803, "", "=q4=Arcweaver Spell Sword", "=ds=#h1#, #w10#" },
				{ 21, 104808, "", "=q4=Gar'tok, Strength of the Faithful", "=ds=#h2#, #w6#" },
				{ 22, 104800, "", "=q4=Nazgrim's Gutripper", "=ds=#h1#, #w4#" },
				{ 23, 104809, "", "=q4=Bulwark of the Fallen General", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103808, "", "=q4=Spaulders of Kor'kron Fealty", "=ds=#s3#, #a1#", tf=105308 },
				{ 2, 103904, "", "=q4=Sandals of Two Little Bees", "=ds=#s12#, #a1#", tf=105299 },
				{ 3, 103913, "", "=q4=Shoulderguards of the Righteous Stand", "=ds=#s3#, #a2#", tf=105302 },
				{ 4, 103947, "", "=q4=Robes of the Warrior's Fall", "=ds=#s5#, #a2#", tf=105303 },
				{ 5, 103949, "", "=q4=Crown of Tragic Truth", "=ds=#s1#, #a3#", tf=105305 },
				{ 6, 103732, "", "=q4=Ravager's Pathwalkers", "=ds=#s12#, #a3#", tf=105304 },
				{ 8, 102294, "", "=q4=Nazgrim's Burnished Insignia", "=ds=#s14#", tf=105300 },
				{ 16, 99687, "", "=q4=Gauntlets of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99692, "", "=q4=Gauntlets of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99682, "", "=q4=Gauntlets of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 103946, "", "=q4=Arcweaver Spell Sword", "=ds=#h1#, #w10#", tf=105301 },
				{ 21, 103945, "", "=q4=Gar'tok, Strength of the Faithful", "=ds=#h2#, #w6#", tf=105306 },
				{ 22, 103829, "", "=q4=Nazgrim's Gutripper", "=ds=#h1#, #w4#", tf=105298 },
				{ 23, 103872, "", "=q4=Bulwark of the Fallen General", "=ds=#w8#", tf=105307 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104561, "", "=q4=Spaulders of Kor'kron Fealty", "=ds=#s3#, #a1#", tf=105557 },
				{ 2, 104552, "", "=q4=Sandals of Two Little Bees", "=ds=#s12#, #a1#", tf=105548 },
				{ 3, 104555, "", "=q4=Shoulderguards of the Righteous Stand", "=ds=#s3#, #a2#", tf=105551 },
				{ 4, 104556, "", "=q4=Robes of the Warrior's Fall", "=ds=#s5#, #a2#", tf=105552 },
				{ 5, 104558, "", "=q4=Crown of Tragic Truth", "=ds=#s1#, #a3#", tf=105554 },
				{ 6, 104557, "", "=q4=Ravager's Pathwalkers", "=ds=#s12#, #a3#", tf=105553 },
				{ 8, 104553, "", "=q4=Nazgrim's Burnished Insignia", "=ds=#s14#", tf=105549 },
				{ 16, 99721, "", "=q4=Gauntlets of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99722, "", "=q4=Gauntlets of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99720, "", "=q4=Gauntlets of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104554, "", "=q4=Arcweaver Spell Sword", "=ds=#h1#, #w10#", tf=105550 },
				{ 21, 104559, "", "=q4=Gar'tok, Strength of the Faithful", "=ds=#h2#, #w6#", tf=105555 },
				{ 22, 104551, "", "=q4=Nazgrim's Gutripper", "=ds=#h1#, #w4#", tf=105547 },
				{ 23, 104560, "", "=q4=Bulwark of the Fallen General", "=ds=#w8#", tf=105556 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("General Nazgrim", 850),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOMalkorok"] = {
		["RaidFinder"] = {
			{
				{ 1, 105075, "", "=q4=Black-Blooded Drape", "=ds=#s4#" },
				{ 2, 105072, "", "=q4=Hood of Perpetual Implosion", "=ds=#s1#, #a1#" },
				{ 3, 105073, "", "=q4=Robes of Riven Dreams", "=ds=#s5#, #a1#" },
				{ 4, 105071, "", "=q4=Miasmic Skullbelt", "=ds=#s10#, #a1#" },
				{ 5, 105063, "", "=q4=Lazahk's Lost Shadowrap", "=ds=#s5#, #a2#" },
				{ 6, 105079, "", "=q4=Bracers of Averted Fatality", "=ds=#s8#, #a2#" },
				{ 7, 105078, "", "=q4=Boots of Perilous Infusion", "=ds=#s12#, #a2#" },
				{ 8, 105080, "", "=q4=Ebon Blood Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 105064, "", "=q4=Wristguards of Ruination", "=ds=#s8#, #a3#" },
				{ 10, 105081, "", "=q4=Terrorguard Chestplate", "=ds=#s5#, #a4#" },
				{ 11, 105066, "", "=q4=Blood Rage Bracers", "=ds=#s8#, #a4#" },
				{ 12, 105067, "", "=q4=Legplates of Willful Doom", "=ds=#s11#, #a4#" },
				{ 13, 105065, "", "=q4=Malkorok's Giant Stompers", "=ds=#s12#, #a4#" },
				{ 16, 105068, "", "=q4=Malkorok's Tainted Dog Tags", "=ds=#s2#" },
				{ 17, 105060, "", "=q4=Ring of Restless Energy", "=ds=#s13#" },
				{ 18, 105076, "", "=q4=Seal of Sullen Fury", "=ds=#s13#" },
				{ 19, 105074, "", "=q4=Frenzied Crystal of Rage", "=ds=#s14#" },
				{ 20, 105070, "", "=q4=Vial of Living Corruption", "=ds=#s14#" },
				{ 22, 105062, "", "=q4=Halberd of Inner Shadows", "=ds=#w7#" },
				{ 23, 105061, "", "=q4=Kor'kron Hand Cannon", "=ds=#w5#" },
				{ 24, 105069, "", "=q4=Malkorok's Skullcleaver", "=ds=#h1#, #w1#" },
				{ 25, 105077, "", "=q4=Visage of the Monstrous", "=ds=#w8#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104826, "", "=q4=Black-Blooded Drape", "=ds=#s4#" },
				{ 2, 104823, "", "=q4=Hood of Perpetual Implosion", "=ds=#s1#, #a1#" },
				{ 3, 104824, "", "=q4=Robes of Riven Dreams", "=ds=#s5#, #a1#" },
				{ 4, 104822, "", "=q4=Miasmic Skullbelt", "=ds=#s10#, #a1#" },
				{ 5, 104814, "", "=q4=Lazahk's Lost Shadowrap", "=ds=#s5#, #a2#" },
				{ 6, 104830, "", "=q4=Bracers of Averted Fatality", "=ds=#s8#, #a2#" },
				{ 7, 104829, "", "=q4=Boots of Perilous Infusion", "=ds=#s12#, #a2#" },
				{ 8, 104831, "", "=q4=Ebon Blood Chestguard", "=ds=#s5#, #a3#" },
				{ 9, 104815, "", "=q4=Wristguards of Ruination", "=ds=#s8#, #a3#" },
				{ 10, 104832, "", "=q4=Terrorguard Chestplate", "=ds=#s5#, #a4#" },
				{ 11, 104817, "", "=q4=Blood Rage Bracers", "=ds=#s8#, #a4#" },
				{ 12, 104818, "", "=q4=Legplates of Willful Doom", "=ds=#s11#, #a4#" },
				{ 13, 104816, "", "=q4=Malkorok's Giant Stompers", "=ds=#s12#, #a4#" },
				{ 16, 104819, "", "=q4=Malkorok's Tainted Dog Tags", "=ds=#s2#" },
				{ 17, 104811, "", "=q4=Ring of Restless Energy", "=ds=#s13#" },
				{ 18, 104827, "", "=q4=Seal of Sullen Fury", "=ds=#s13#" },
				{ 19, 104825, "", "=q4=Frenzied Crystal of Rage", "=ds=#s14#" },
				{ 20, 104821, "", "=q4=Vial of Living Corruption", "=ds=#s14#" },
				{ 22, 104813, "", "=q4=Halberd of Inner Shadows", "=ds=#w7#" },
				{ 23, 104812, "", "=q4=Kor'kron Hand Cannon", "=ds=#w5#" },
				{ 24, 104820, "", "=q4=Malkorok's Skullcleaver", "=ds=#h1#, #w1#" },
				{ 25, 104828, "", "=q4=Visage of the Monstrous", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103959, "", "=q4=Black-Blooded Drape", "=ds=#s4#", tf=105324 },
				{ 2, 103939, "", "=q4=Hood of Perpetual Implosion", "=ds=#s1#, #a1#", tf=105321 },
				{ 3, 103923, "", "=q4=Robes of Riven Dreams", "=ds=#s5#, #a1#", tf=105322 },
				{ 4, 103899, "", "=q4=Miasmic Skullbelt", "=ds=#s10#, #a1#", tf=105320 },
				{ 5, 103835, "", "=q4=Lazahk's Lost Shadowrap", "=ds=#s5#, #a2#", tf=105312 },
				{ 6, 103758, "", "=q4=Bracers of Averted Fatality", "=ds=#s8#, #a2#", tf=105328 },
				{ 7, 103761, "", "=q4=Boots of Perilous Infusion", "=ds=#s12#, #a2#", tf=105327 },
				{ 8, 103955, "", "=q4=Ebon Blood Chestguard", "=ds=#s5#, #a3#", tf=105329 },
				{ 9, 103890, "", "=q4=Wristguards of Ruination", "=ds=#s8#, #a3#", tf=105313 },
				{ 10, 103957, "", "=q4=Terrorguard Chestplate", "=ds=#s5#, #a4#", tf=105330 },
				{ 11, 103742, "", "=q4=Blood Rage Bracers", "=ds=#s8#, #a4#", tf=105315 },
				{ 12, 103954, "", "=q4=Legplates of Willful Doom", "=ds=#s11#, #a4#", tf=105316 },
				{ 13, 103879, "", "=q4=Malkorok's Giant Stompers", "=ds=#s12#, #a4#", tf=105314 },
				{ 16, 103917, "", "=q4=Malkorok's Tainted Dog Tags", "=ds=#s2#", tf=105317 },
				{ 17, 103843, "", "=q4=Ring of Restless Energy", "=ds=#s13#", tf=105309 },
				{ 18, 103772, "", "=q4=Seal of Sullen Fury", "=ds=#s13#", tf=105325 },
				{ 19, 102303, "", "=q4=Frenzied Crystal of Rage", "=ds=#s14#", tf=105323 },
				{ 20, 102306, "", "=q4=Vial of Living Corruption", "=ds=#s14#", tf=105319 },
				{ 22, 103952, "", "=q4=Halberd of Inner Shadows", "=ds=#w7#", tf=105311 },
				{ 23, 103953, "", "=q4=Kor'kron Hand Cannon", "=ds=#w5#", tf=105310 },
				{ 24, 103951, "", "=q4=Malkorok's Skullcleaver", "=ds=#h1#, #w1#", tf=105318 },
				{ 25, 103848, "", "=q4=Visage of the Monstrous", "=ds=#w8#", tf=105326 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104577, "", "=q4=Black-Blooded Drape", "=ds=#s4#", tf=105573 },
				{ 2, 104574, "", "=q4=Hood of Perpetual Implosion", "=ds=#s1#, #a1#", tf=105570 },
				{ 3, 104575, "", "=q4=Robes of Riven Dreams", "=ds=#s5#, #a1#", tf=105571 },
				{ 4, 104573, "", "=q4=Miasmic Skullbelt", "=ds=#s10#, #a1#", tf=105569 },
				{ 5, 104565, "", "=q4=Lazahk's Lost Shadowrap", "=ds=#s5#, #a2#", tf=105561 },
				{ 6, 104581, "", "=q4=Bracers of Averted Fatality", "=ds=#s8#, #a2#", tf=105577 },
				{ 7, 104580, "", "=q4=Boots of Perilous Infusion", "=ds=#s12#, #a2#", tf=105576 },
				{ 8, 104582, "", "=q4=Ebon Blood Chestguard", "=ds=#s5#, #a3#", tf=105578 },
				{ 9, 104566, "", "=q4=Wristguards of Ruination", "=ds=#s8#, #a3#", tf=105562 },
				{ 10, 104583, "", "=q4=Terrorguard Chestplate", "=ds=#s5#, #a4#", tf=105579 },
				{ 11, 104568, "", "=q4=Blood Rage Bracers", "=ds=#s8#, #a4#", tf=105564 },
				{ 12, 104569, "", "=q4=Legplates of Willful Doom", "=ds=#s11#, #a4#", tf=105565 },
				{ 13, 104567, "", "=q4=Malkorok's Giant Stompers", "=ds=#s12#, #a4#", tf=105563 },
				{ 16, 104570, "", "=q4=Malkorok's Tainted Dog Tags", "=ds=#s2#", tf=105566 },
				{ 17, 104562, "", "=q4=Ring of Restless Energy", "=ds=#s13#", tf=105558 },
				{ 18, 104578, "", "=q4=Seal of Sullen Fury", "=ds=#s13#", tf=105574 },
				{ 19, 104576, "", "=q4=Frenzied Crystal of Rage", "=ds=#s14#", tf=105572 },
				{ 20, 104572, "", "=q4=Vial of Living Corruption", "=ds=#s14#", tf=105568 },
				{ 22, 104564, "", "=q4=Halberd of Inner Shadows", "=ds=#w7#", tf=105560 },
				{ 23, 104563, "", "=q4=Kor'kron Hand Cannon", "=ds=#w5#", tf=105559 },
				{ 24, 104571, "", "=q4=Malkorok's Skullcleaver", "=ds=#h1#, #w1#", tf=105567 },
				{ 25, 104579, "", "=q4=Visage of the Monstrous", "=ds=#w8#", tf=105575 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Malkorok", 846),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOSpoils"] = {
		["RaidFinder"] = {
			{
				{ 1, 105094, "", "=q4=Mantid Vizier's Robes", "=ds=#s5#, #a1#" },
				{ 2, 105093, "", "=q4=Avool's Ancestral Bracers", "=ds=#s8#, #a1#" },
				{ 3, 105085, "", "=q4=Mantid Carapace Augments", "=ds=#s8#, #a2#" },
				{ 4, 105097, "", "=q4=Klaxxi Grips of Rejuvenation", "=ds=#s9#, #a2#" },
				{ 5, 105098, "", "=q4=Shado-Pan Reliquary Kilt", "=ds=#s11#, #a2#" },
				{ 6, 105084, "", "=q4=Pandaren Roofsprinters", "=ds=#s12#, #a2#" },
				{ 7, 105087, "", "=q4=Ancient Archer's Chestguard", "=ds=#s5#, #a3#" },
				{ 8, 105100, "", "=q4=Bracers of the Pristine Purifier", "=ds=#s8#, #a3#" },
				{ 9, 105086, "", "=q4=Arrowflight Girdle", "=ds=#s10#, #a3#" },
				{ 10, 105099, "", "=q4=Chitin-Link Chain Belt", "=ds=#s10#, #a3#" },
				{ 11, 105088, "", "=q4=Helm of the Night Watchman", "=ds=#s1#, #a4#" },
				{ 12, 105101, "", "=q4=Plate Belt of the War-Healer", "=ds=#s10#, #a4#" },
				{ 13, 105089, "", "=q4=Untarnishable Greatbelt", "=ds=#s10#, #a4#" },
				{ 14, 105102, "", "=q4=Mogu Mindbender's Greaves", "=ds=#s12#, #a4#" },
				{ 15, 105090, "", "=q4=Ominous Mogu Greatboots", "=ds=#s12#, #a4#" },
				{ 16, 105095, "", "=q4=Lost Necklace of the Mogu Empress", "=ds=#s2#" },
				{ 17, 105091, "", "=q4=Seal of the Forgotten Kings", "=ds=#s13#" },
				{ 18, 105082, "", "=q4=Sigil of Rampage", "=ds=#s14#" },
				{ 20, 105083, "", "=q4=Enchanted Shao-Tien Saber", "=ds=#h1#, #w10#" },
				{ 21, 105096, "", "=q4=Immaculately Preserved Wand", "=ds=#w12#" },
				{ 22, 105092, "", "=q4=Ancient Mogu Tower Shield", "=ds=#w8#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104845, "", "=q4=Mantid Vizier's Robes", "=ds=#s5#, #a1#" },
				{ 2, 104844, "", "=q4=Avool's Ancestral Bracers", "=ds=#s8#, #a1#" },
				{ 3, 104836, "", "=q4=Mantid Carapace Augments", "=ds=#s8#, #a2#" },
				{ 4, 104848, "", "=q4=Klaxxi Grips of Rejuvenation", "=ds=#s9#, #a2#" },
				{ 5, 104849, "", "=q4=Shado-Pan Reliquary Kilt", "=ds=#s11#, #a2#" },
				{ 6, 104835, "", "=q4=Pandaren Roofsprinters", "=ds=#s12#, #a2#" },
				{ 7, 104838, "", "=q4=Ancient Archer's Chestguard", "=ds=#s5#, #a3#" },
				{ 8, 104851, "", "=q4=Bracers of the Pristine Purifier", "=ds=#s8#, #a3#" },
				{ 9, 104837, "", "=q4=Arrowflight Girdle", "=ds=#s10#, #a3#" },
				{ 10, 104850, "", "=q4=Chitin-Link Chain Belt", "=ds=#s10#, #a3#" },
				{ 11, 104839, "", "=q4=Helm of the Night Watchman", "=ds=#s1#, #a4#" },
				{ 12, 104852, "", "=q4=Plate Belt of the War-Healer", "=ds=#s10#, #a4#" },
				{ 13, 104840, "", "=q4=Untarnishable Greatbelt", "=ds=#s10#, #a4#" },
				{ 14, 104853, "", "=q4=Mogu Mindbender's Greaves", "=ds=#s12#, #a4#" },
				{ 15, 104841, "", "=q4=Ominous Mogu Greatboots", "=ds=#s12#, #a4#" },
				{ 16, 104846, "", "=q4=Lost Necklace of the Mogu Empress", "=ds=#s2#" },
				{ 17, 104842, "", "=q4=Seal of the Forgotten Kings", "=ds=#s13#" },
				{ 18, 104833, "", "=q4=Sigil of Rampage", "=ds=#s14#" },
				{ 20, 104834, "", "=q4=Enchanted Shao-Tien Saber", "=ds=#h1#, #w10#" },
				{ 21, 104847, "", "=q4=Immaculately Preserved Wand", "=ds=#w12#" },
				{ 22, 104843, "", "=q4=Ancient Mogu Tower Shield", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103803, "", "=q4=Mantid Vizier's Robes", "=ds=#s5#, #a1#", tf=105343 },
				{ 2, 103851, "", "=q4=Avool's Ancestral Bracers", "=ds=#s8#, #a1#", tf=105342 },
				{ 3, 103911, "", "=q4=Mantid Carapace Augments", "=ds=#s8#, #a2#", tf=105334 },
				{ 4, 103860, "", "=q4=Klaxxi Grips of Rejuvenation", "=ds=#s9#, #a2#", tf=105346 },
				{ 5, 103967, "", "=q4=Shado-Pan Reliquary Kilt", "=ds=#s11#, #a2#", tf=105347 },
				{ 6, 103779, "", "=q4=Pandaren Roofsprinters", "=ds=#s12#, #a2#", tf=105333 },
				{ 7, 103962, "", "=q4=Ancient Archer's Chestguard", "=ds=#s5#, #a3#", tf=105336 },
				{ 8, 103862, "", "=q4=Bracers of the Pristine Purifier", "=ds=#s8#, #a3#", tf=105349 },
				{ 9, 103888, "", "=q4=Arrowflight Girdle", "=ds=#s10#, #a3#", tf=105335 },
				{ 10, 103941, "", "=q4=Chitin-Link Chain Belt", "=ds=#s10#, #a3#", tf=105348 },
				{ 11, 103893, "", "=q4=Helm of the Night Watchman", "=ds=#s1#, #a4#", tf=105337 },
				{ 12, 103965, "", "=q4=Plate Belt of the War-Healer", "=ds=#s10#, #a4#", tf=105350 },
				{ 13, 103933, "", "=q4=Untarnishable Greatbelt", "=ds=#s10#, #a4#", tf=105338 },
				{ 14, 103768, "", "=q4=Mogu Mindbender's Greaves", "=ds=#s12#, #a4#", tf=105351 },
				{ 15, 103745, "", "=q4=Ominous Mogu Greatboots", "=ds=#s12#, #a4#", tf=105339 },
				{ 16, 103882, "", "=q4=Lost Necklace of the Mogu Empress", "=ds=#s2#", tf=105344 },
				{ 17, 103796, "", "=q4=Seal of the Forgotten Kings", "=ds=#s13#", tf=105340 },
				{ 18, 102302, "", "=q4=Sigil of Rampage", "=ds=#s14#", tf=105331 },
				{ 20, 103961, "", "=q4=Enchanted Shao-Tien Saber", "=ds=#h1#, #w10#", tf=105332 },
				{ 21, 103964, "", "=q4=Immaculately Preserved Wand", "=ds=#w12#", tf=105345 },
				{ 22, 103871, "", "=q4=Ancient Mogu Tower Shield", "=ds=#w8#", tf=105341 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104596, "", "=q4=Mantid Vizier's Robes", "=ds=#s5#, #a1#", tf=105592 },
				{ 2, 104595, "", "=q4=Avool's Ancestral Bracers", "=ds=#s8#, #a1#", tf=105591 },
				{ 3, 104587, "", "=q4=Mantid Carapace Augments", "=ds=#s8#, #a2#", tf=105583 },
				{ 4, 104599, "", "=q4=Klaxxi Grips of Rejuvenation", "=ds=#s9#, #a2#", tf=105595 },
				{ 5, 104600, "", "=q4=Shado-Pan Reliquary Kilt", "=ds=#s11#, #a2#", tf=105596 },
				{ 6, 104586, "", "=q4=Pandaren Roofsprinters", "=ds=#s12#, #a2#", tf=105582 },
				{ 7, 104589, "", "=q4=Ancient Archer's Chestguard", "=ds=#s5#, #a3#", tf=105585 },
				{ 8, 104602, "", "=q4=Bracers of the Pristine Purifier", "=ds=#s8#, #a3#", tf=105598 },
				{ 9, 104588, "", "=q4=Arrowflight Girdle", "=ds=#s10#, #a3#", tf=105584 },
				{ 10, 104601, "", "=q4=Chitin-Link Chain Belt", "=ds=#s10#, #a3#", tf=105597 },
				{ 11, 104590, "", "=q4=Helm of the Night Watchman", "=ds=#s1#, #a4#", tf=105586 },
				{ 12, 104603, "", "=q4=Plate Belt of the War-Healer", "=ds=#s10#, #a4#", tf=105599 },
				{ 13, 104591, "", "=q4=Untarnishable Greatbelt", "=ds=#s10#, #a4#", tf=105587 },
				{ 14, 104604, "", "=q4=Mogu Mindbender's Greaves", "=ds=#s12#, #a4#", tf=105600 },
				{ 15, 104592, "", "=q4=Ominous Mogu Greatboots", "=ds=#s12#, #a4#", tf=105588 },
				{ 16, 104597, "", "=q4=Lost Necklace of the Mogu Empress", "=ds=#s2#", tf=105593 },
				{ 17, 104593, "", "=q4=Seal of the Forgotten Kings", "=ds=#s13#", tf=105589 },
				{ 18, 104584, "", "=q4=Sigil of Rampage", "=ds=#s14#", tf=105580 },
				{ 20, 104585, "", "=q4=Enchanted Shao-Tien Saber", "=ds=#h1#, #w10#", tf=105581 },
				{ 21, 104598, "", "=q4=Immaculately Preserved Wand", "=ds=#w12#", tf=105594 },
				{ 22, 104594, "", "=q4=Ancient Mogu Tower Shield", "=ds=#w8#", tf=105590 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Spoils of Pandaria", 870),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOThok"] = {
		["RaidFinder"] = {
			{
				{ 1, 105106, "", "=q4=Akolik's Acid-Soaked Robes", "=ds=#s5#, #a1#" },
				{ 2, 105105, "", "=q4=Montak's Grips of Scorching Breath", "=ds=#s9#, #a1#" },
				{ 3, 105110, "", "=q4=Icy Blood Chestplate", "=ds=#s5#, #a4#" },
				{ 5, 105104, "", "=q4=Gleaming Eye of the Devilsaur", "=ds=#s2#" },
				{ 6, 105113, "", "=q4=Devilfang Band", "=ds=#s13#" },
				{ 7, 105108, "", "=q4=Signet of the Dinomancers", "=ds=#s13#" },
				{ 8, 105109, "", "=q4=Thok's Acid-Grooved Tooth", "=ds=#s14#" },
				{ 9, 105111, "", "=q4=Thok's Tail Tip", "=ds=#s14#" },
				{ 16, 99672, "", "=q4=Helm of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99673, "", "=q4=Helm of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99671, "", "=q4=Helm of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 105112, "", "=q4=Britomart's Jagged Pike", "=ds=#w7#" },
				{ 21, 105103, "", "=q4=Hvitserk's Formidable Shanker", "=ds=#h1#, #w4#" },
				{ 22, 105107, "", "=q4=Festering Primordial Globule", "=ds=#s15#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104857, "", "=q4=Akolik's Acid-Soaked Robes", "=ds=#s5#, #a1#" },
				{ 2, 104856, "", "=q4=Montak's Grips of Scorching Breath", "=ds=#s9#, #a1#" },
				{ 3, 104861, "", "=q4=Icy Blood Chestplate", "=ds=#s5#, #a4#" },
				{ 5, 104855, "", "=q4=Gleaming Eye of the Devilsaur", "=ds=#s2#" },
				{ 6, 104864, "", "=q4=Devilfang Band", "=ds=#s13#" },
				{ 7, 104859, "", "=q4=Signet of the Dinomancers", "=ds=#s13#" },
				{ 8, 104860, "", "=q4=Thok's Acid-Grooved Tooth", "=ds=#s14#" },
				{ 9, 104862, "", "=q4=Thok's Tail Tip", "=ds=#s14#" },
				{ 16, 99749, "", "=q4=Helm of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99750, "", "=q4=Helm of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99748, "", "=q4=Helm of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104863, "", "=q4=Britomart's Jagged Pike", "=ds=#w7#" },
				{ 21, 104854, "", "=q4=Hvitserk's Formidable Shanker", "=ds=#h1#, #w4#" },
				{ 22, 104858, "", "=q4=Festering Primordial Globule", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 104308, "", "=q4=Akolik's Acid-Soaked Robes", "=ds=#s5#, #a1#", tf=105355 },
				{ 2, 103853, "", "=q4=Montak's Grips of Scorching Breath", "=ds=#s9#, #a1#", tf=105354 },
				{ 3, 103915, "", "=q4=Icy Blood Chestplate", "=ds=#s5#, #a4#", tf=105359 },
				{ 5, 103750, "", "=q4=Gleaming Eye of the Devilsaur", "=ds=#s2#", tf=105353 },
				{ 6, 103896, "", "=q4=Devilfang Band", "=ds=#s13#", tf=105362 },
				{ 7, 103774, "", "=q4=Signet of the Dinomancers", "=ds=#s13#", tf=105357 },
				{ 8, 102304, "", "=q4=Thok's Acid-Grooved Tooth", "=ds=#s14#", tf=105358 },
				{ 9, 102305, "", "=q4=Thok's Tail Tip", "=ds=#s14#", tf=105360 },
				{ 16, 99689, "", "=q4=Helm of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99694, "", "=q4=Helm of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99683, "", "=q4=Helm of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 103968, "", "=q4=Britomart's Jagged Pike", "=ds=#w7#", tf=105361 },
				{ 21, 103828, "", "=q4=Hvitserk's Formidable Shanker", "=ds=#h1#, #w4#", tf=105352 },
				{ 22, 103919, "", "=q4=Festering Primordial Globule", "=ds=#s15#", tf=105356 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104608, "", "=q4=Akolik's Acid-Soaked Robes", "=ds=#s5#, #a1#", tf=105604 },
				{ 2, 104607, "", "=q4=Montak's Grips of Scorching Breath", "=ds=#s9#, #a1#", tf=105603 },
				{ 3, 104612, "", "=q4=Icy Blood Chestplate", "=ds=#s5#, #a4#", tf=105608 },
				{ 5, 104606, "", "=q4=Gleaming Eye of the Devilsaur", "=ds=#s2#", tf=105602 },
				{ 6, 104615, "", "=q4=Devilfang Band", "=ds=#s13#", tf=105611 },
				{ 7, 104610, "", "=q4=Signet of the Dinomancers", "=ds=#s13#", tf=105606 },
				{ 8, 104611, "", "=q4=Thok's Acid-Grooved Tooth", "=ds=#s14#", tf=105607 },
				{ 9, 104613, "", "=q4=Thok's Tail Tip", "=ds=#s14#", tf=105609 },
				{ 16, 99724, "", "=q4=Helm of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99725, "", "=q4=Helm of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99723, "", "=q4=Helm of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104614, "", "=q4=Britomart's Jagged Pike", "=ds=#w7#", tf=105610 },
				{ 21, 104605, "", "=q4=Hvitserk's Formidable Shanker", "=ds=#h1#, #w4#", tf=105601 },
				{ 22, 104609, "", "=q4=Festering Primordial Globule", "=ds=#s15#", tf=105605 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOBlackfuse"] = {
		["RaidFinder"] = {
			{
				{ 1, 105115, "", "=q4=Fusespark Gloves", "=ds=#s9#, #a1#" },
				{ 2, 105118, "", "=q4=Bomber's Blackened Wristwatch", "=ds=#s8#, #a2#" },
				{ 3, 105119, "", "=q4=Bracers of Infinite Pipes", "=ds=#s8#, #a3#" },
				{ 4, 105120, "", "=q4=Powder-Stained Totemic Treads", "=ds=#s12#, #a3#" },
				{ 5, 105121, "", "=q4=Calixian Bladebreakers", "=ds=#s9#, #a4#" },
				{ 7, 105124, "", "=q4=Blackfuse's Blasting Cord", "=ds=#s2#" },
				{ 8, 105122, "", "=q4=Asgorathian Blood Seal", "=ds=#s13#" },
				{ 9, 105117, "", "=q4=Dysmorphic Samophlange of Discontinuity", "=ds=#s14#" },
				{ 10, 105114, "", "=q4=Ticking Ebon Detonator", "=ds=#s14#" },
				{ 16, 99669, "", "=q4=Shoulders of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99670, "", "=q4=Shoulders of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99668, "", "=q4=Shoulders of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 105116, "", "=q4=Lever of the Megantholithic Apparatus", "=ds=#w9#" },
				{ 21, 105123, "", "=q4=Siegecrafter's Forge Hammer", "=ds=#h1#, #w6#" },
				{ 23, 104158, "", "=q3=Blackfuse Bombling", "=ds=#e13#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104866, "", "=q4=Fusespark Gloves", "=ds=#s9#, #a1#" },
				{ 2, 104869, "", "=q4=Bomber's Blackened Wristwatch", "=ds=#s8#, #a2#" },
				{ 3, 104870, "", "=q4=Bracers of Infinite Pipes", "=ds=#s8#, #a3#" },
				{ 4, 104871, "", "=q4=Powder-Stained Totemic Treads", "=ds=#s12#, #a3#" },
				{ 5, 104872, "", "=q4=Calixian Bladebreakers", "=ds=#s9#, #a4#" },
				{ 7, 104875, "", "=q4=Blackfuse's Blasting Cord", "=ds=#s2#" },
				{ 8, 104873, "", "=q4=Asgorathian Blood Seal", "=ds=#s13#" },
				{ 9, 104868, "", "=q4=Dysmorphic Samophlange of Discontinuity", "=ds=#s14#" },
				{ 10, 104865, "", "=q4=Ticking Ebon Detonator", "=ds=#s14#" },
				{ 16, 99755, "", "=q4=Shoulders of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99756, "", "=q4=Shoulders of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99754, "", "=q4=Shoulders of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104867, "", "=q4=Lever of the Megantholithic Apparatus", "=ds=#w9#" },
				{ 21, 104874, "", "=q4=Siegecrafter's Forge Hammer", "=ds=#h1#, #w6#" },
				{ 23, 104158, "", "=q3=Blackfuse Bombling", "=ds=#e13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103970, "", "=q4=Fusespark Gloves", "=ds=#s9#, #a1#", tf=105364 },
				{ 2, 103910, "", "=q4=Bomber's Blackened Wristwatch", "=ds=#s8#, #a2#", tf=105367 },
				{ 3, 103891, "", "=q4=Bracers of Infinite Pipes", "=ds=#s8#, #a3#", tf=105368 },
				{ 4, 103814, "", "=q4=Powder-Stained Totemic Treads", "=ds=#s12#, #a3#", tf=105369 },
				{ 5, 103792, "", "=q4=Calixian Bladebreakers", "=ds=#s9#, #a4#", tf=105370 },
				{ 7, 103884, "", "=q4=Blackfuse's Blasting Cord", "=ds=#s2#", tf=105373 },
				{ 8, 103794, "", "=q4=Asgorathian Blood Seal", "=ds=#s13#", tf=105371 },
				{ 9, 102309, "", "=q4=Dysmorphic Samophlange of Discontinuity", "=ds=#s14#", tf=105366 },
				{ 10, 102311, "", "=q4=Ticking Ebon Detonator", "=ds=#s14#", tf=105363 },
				{ 16, 99690, "", "=q4=Shoulders of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99695, "", "=q4=Shoulders of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99685, "", "=q4=Shoulders of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 103874, "", "=q4=Lever of the Megantholithic Apparatus", "=ds=#w9#", tf=105365 },
				{ 21, 103969, "", "=q4=Siegecrafter's Forge Hammer", "=ds=#h1#, #w6#", tf=105372 },
				{ 23, 104158, "", "=q3=Blackfuse Bombling", "=ds=#e13#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104617, "", "=q4=Fusespark Gloves", "=ds=#s9#, #a1#", tf=105613 },
				{ 2, 104620, "", "=q4=Bomber's Blackened Wristwatch", "=ds=#s8#, #a2#", tf=105616 },
				{ 3, 104621, "", "=q4=Bracers of Infinite Pipes", "=ds=#s8#, #a3#", tf=105617 },
				{ 4, 104622, "", "=q4=Powder-Stained Totemic Treads", "=ds=#s12#, #a3#", tf=105618 },
				{ 5, 104623, "", "=q4=Calixian Bladebreakers", "=ds=#s9#, #a4#", tf=105619 },
				{ 7, 104626, "", "=q4=Blackfuse's Blasting Cord", "=ds=#s2#", tf=105622 },
				{ 8, 104624, "", "=q4=Asgorathian Blood Seal", "=ds=#s13#", tf=105620 },
				{ 9, 104619, "", "=q4=Dysmorphic Samophlange of Discontinuity", "=ds=#s14#", tf=105615 },
				{ 10, 104616, "", "=q4=Ticking Ebon Detonator", "=ds=#s14#", tf=105612 },
				{ 16, 99718, "", "=q4=Shoulders of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99719, "", "=q4=Shoulders of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99717, "", "=q4=Shoulders of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104618, "", "=q4=Lever of the Megantholithic Apparatus", "=ds=#w9#", tf=105614 },
				{ 21, 104625, "", "=q4=Siegecrafter's Forge Hammer", "=ds=#h1#, #w6#", tf=105621 },
				{ 23, 104158, "", "=q3=Blackfuse Bombling", "=ds=#e13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOParagons"] = {
		["RaidFinder"] = {
			{
				{ 1, 105128, "", "=q4=Bracers of Sonic Projection", "=ds=#s8#, #a1#" },
				{ 2, 105131, "", "=q4=Amber Parasite Wraps", "=ds=#s5#, #a2#" },
				{ 3, 105132, "", "=q4=Chestguard of Toxic Injections", "=ds=#s5#, #a3#" },
				{ 4, 105133, "", "=q4=Gauntlets of Insane Calculations", "=ds=#s9#, #a4#" },
				{ 6, 105130, "", "=q4=Iyyokuk's Hereditary Seal", "=ds=#s13#" },
				{ 7, 105126, "", "=q4=Kil'ruk's Band of Ascendancy", "=ds=#s13#" },
				{ 8, 105134, "", "=q4=Skeer's Bloodsoaked Talisman", "=ds=#s14#" },
				{ 16, 99675, "", "=q4=Leggings of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99676, "", "=q4=Leggings of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99674, "", "=q4=Leggings of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 105125, "", "=q4=Hisek's Reserve Longbow", "=ds=#w2#" },
				{ 21, 105135, "", "=q4=Kil'ruk's Furious Blade", "=ds=#h1#, #w10#" },
				{ 22, 105127, "", "=q4=Korven's Crimson Crescent", "=ds=#h1#, #w1#" },
				{ 23, 105129, "", "=q4=Rik'kal's Bloody Scalpel", "=ds=#h1#, #w4#" },
				{ 25, 104165, "", "=q3=Kovok", "=ds=#e13#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104879, "", "=q4=Bracers of Sonic Projection", "=ds=#s8#, #a1#" },
				{ 2, 104882, "", "=q4=Amber Parasite Wraps", "=ds=#s5#, #a2#" },
				{ 3, 104883, "", "=q4=Chestguard of Toxic Injections", "=ds=#s5#, #a3#" },
				{ 4, 104884, "", "=q4=Gauntlets of Insane Calculations", "=ds=#s9#, #a4#" },
				{ 6, 104881, "", "=q4=Iyyokuk's Hereditary Seal", "=ds=#s13#" },
				{ 7, 104877, "", "=q4=Kil'ruk's Band of Ascendancy", "=ds=#s13#" },
				{ 8, 104885, "", "=q4=Skeer's Bloodsoaked Talisman", "=ds=#s14#" },
				{ 16, 99752, "", "=q4=Leggings of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99753, "", "=q4=Leggings of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99751, "", "=q4=Leggings of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104876, "", "=q4=Hisek's Reserve Longbow", "=ds=#w2#" },
				{ 21, 104886, "", "=q4=Kil'ruk's Furious Blade", "=ds=#h1#, #w10#" },
				{ 22, 104878, "", "=q4=Korven's Crimson Crescent", "=ds=#h1#, #w1#" },
				{ 23, 104880, "", "=q4=Rik'kal's Bloody Scalpel", "=ds=#h1#, #w4#" },
				{ 25, 104165, "", "=q3=Kovok", "=ds=#e13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103810, "", "=q4=Bracers of Sonic Projection", "=ds=#s8#, #a1#", tf=105377 },
				{ 2, 103948, "", "=q4=Amber Parasite Wraps", "=ds=#s5#, #a2#", tf=105380 },
				{ 3, 103956, "", "=q4=Chestguard of Toxic Injections", "=ds=#s5#, #a3#", tf=105381 },
				{ 4, 103819, "", "=q4=Gauntlets of Insane Calculations", "=ds=#s9#, #a4#", tf=105382 },
				{ 6, 103824, "", "=q4=Iyyokuk's Hereditary Seal", "=ds=#s13#", tf=105379 },
				{ 7, 103844, "", "=q4=Kil'ruk's Band of Ascendancy", "=ds=#s13#", tf=105375 },
				{ 8, 102308, "", "=q4=Skeer's Bloodsoaked Talisman", "=ds=#s14#", tf=105383 },
				{ 16, 99688, "", "=q4=Leggings of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99693, "", "=q4=Leggings of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99684, "", "=q4=Leggings of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 103886, "", "=q4=Hisek's Reserve Longbow", "=ds=#w2#", tf=105374 },
				{ 21, 103972, "", "=q4=Kil'ruk's Furious Blade", "=ds=#h1#, #w10#", tf=105384 },
				{ 22, 103971, "", "=q4=Korven's Crimson Crescent", "=ds=#h1#, #w1#", tf=105376 },
				{ 23, 103973, "", "=q4=Rik'kal's Bloody Scalpel", "=ds=#h1#, #w4#", tf=105378 },
				{ 25, 104165, "", "=q3=Kovok", "=ds=#e13#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104630, "", "=q4=Bracers of Sonic Projection", "=ds=#s8#, #a1#", tf=105626 },
				{ 2, 104633, "", "=q4=Amber Parasite Wraps", "=ds=#s5#, #a2#", tf=105629 },
				{ 3, 104634, "", "=q4=Chestguard of Toxic Injections", "=ds=#s5#, #a3#", tf=105630 },
				{ 4, 104635, "", "=q4=Gauntlets of Insane Calculations", "=ds=#s9#, #a4#", tf=105631 },
				{ 6, 104632, "", "=q4=Iyyokuk's Hereditary Seal", "=ds=#s13#", tf=105628 },
				{ 7, 104628, "", "=q4=Kil'ruk's Band of Ascendancy", "=ds=#s13#", tf=105624 },
				{ 8, 104636, "", "=q4=Skeer's Bloodsoaked Talisman", "=ds=#s14#", tf=105632 },
				{ 16, 99712, "", "=q4=Leggings of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 99713, "", "=q4=Leggings of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 99726, "", "=q4=Leggings of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104627, "", "=q4=Hisek's Reserve Longbow", "=ds=#w2#", tf=105623 },
				{ 21, 104637, "", "=q4=Kil'ruk's Furious Blade", "=ds=#h1#, #w10#", tf=105633 },
				{ 22, 104629, "", "=q4=Korven's Crimson Crescent", "=ds=#h1#, #w1#", tf=105625 },
				{ 23, 104631, "", "=q4=Rik'kal's Bloody Scalpel", "=ds=#h1#, #w4#", tf=105627 },
				{ 25, 104165, "", "=q3=Kovok", "=ds=#e13#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOGarrosh"] = {
		["RaidFinder"] = {
			{
				{ 1, 105149, "", "=q4=Ebon Ritual Hood", "=ds=#s1#, #a1#" },
				{ 2, 105148, "", "=q4=Belt of the Broken Pact", "=ds=#s10#, #a1#" },
				{ 3, 105138, "", "=q4=Kor'kron Elite Skullmask", "=ds=#s1#, #a2#" },
				{ 4, 105154, "", "=q4=Hopeglow Spaulders", "=ds=#s3#, #a2#" },
				{ 5, 105137, "", "=q4=Cord of Black Dreams", "=ds=#s10#, #a2#" },
				{ 6, 105153, "", "=q4=Seal of Karmic Return", "=ds=#s10#, #a2#" },
				{ 7, 105155, "", "=q4=Cowl of Smoking Dreams", "=ds=#s1#, #a3#" },
				{ 8, 105140, "", "=q4=Penetrating Gaze of Y'Shaarj", "=ds=#s1#, #a3#" },
				{ 9, 105141, "", "=q4=Shoulderguards of Intended Power", "=ds=#s3#, #a3#" },
				{ 10, 105139, "", "=q4=Chestguard of Relentless Tyranny", "=ds=#s5#, #a3#" },
				{ 11, 105145, "", "=q4=Greathelm of the Warchief", "=ds=#s1#, #a4#" },
				{ 12, 105157, "", "=q4=Mantle of Looming Darkness", "=ds=#s3#, #a4#" },
				{ 13, 105143, "", "=q4=Spaulders of the Fallen Warchief", "=ds=#s3#, #a4#" },
				{ 14, 105156, "", "=q4=Chestplate of Fallen Passion", "=ds=#s5#, #a4#" },
				{ 15, 105142, "", "=q4=Legplates of Unthinking Strife", "=ds=#s11#, #a4#" },
				{ 16, 105861, "", "=q4=Essence of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 105860, "", "=q4=Essence of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 105862, "", "=q4=Essence of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 105150, "", "=q4=Black Blood of Y'Shaarj", "=ds=#s14#" },
				{ 21, 105147, "", "=q4=Curse of Hubris", "=ds=#s14#" },
				{ 23, 105151, "", "=q4=Horned Mace of the Old Ones", "=ds=#h1#, #w6#" },
				{ 24, 105136, "", "=q4=Kor'kron Spire of Supremacy", "=ds=#w9#" },
				{ 25, 105146, "", "=q4=Xal'atoh, Desecrated Image of Gorehowl", "=ds=#h2#, #w1#" },
				{ 26, 105152, "", "=q4=Revelations of Y'Shaarj", "=ds=#s15#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 104900, "", "=q4=Ebon Ritual Hood", "=ds=#s1#, #a1#" },
				{ 2, 104899, "", "=q4=Belt of the Broken Pact", "=ds=#s10#, #a1#" },
				{ 3, 104889, "", "=q4=Kor'kron Elite Skullmask", "=ds=#s1#, #a2#" },
				{ 4, 104905, "", "=q4=Hopeglow Spaulders", "=ds=#s3#, #a2#" },
				{ 5, 104888, "", "=q4=Cord of Black Dreams", "=ds=#s10#, #a2#" },
				{ 6, 104904, "", "=q4=Seal of Karmic Return", "=ds=#s10#, #a2#" },
				{ 7, 104906, "", "=q4=Cowl of Smoking Dreams", "=ds=#s1#, #a3#" },
				{ 8, 104891, "", "=q4=Penetrating Gaze of Y'Shaarj", "=ds=#s1#, #a3#" },
				{ 9, 104892, "", "=q4=Shoulderguards of Intended Power", "=ds=#s3#, #a3#" },
				{ 10, 104890, "", "=q4=Chestguard of Relentless Tyranny", "=ds=#s5#, #a3#" },
				{ 11, 104896, "", "=q4=Greathelm of the Warchief", "=ds=#s1#, #a4#" },
				{ 12, 104908, "", "=q4=Mantle of Looming Darkness", "=ds=#s3#, #a4#" },
				{ 13, 104894, "", "=q4=Spaulders of the Fallen Warchief", "=ds=#s3#, #a4#" },
				{ 14, 104907, "", "=q4=Chestplate of Fallen Passion", "=ds=#s5#, #a4#" },
				{ 15, 104893, "", "=q4=Legplates of Unthinking Strife", "=ds=#s11#, #a4#" },
				{ 16, 105864, "", "=q4=Essence of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 17, 105863, "", "=q4=Essence of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 18, 105865, "", "=q4=Essence of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 20, 104901, "", "=q4=Black Blood of Y'Shaarj", "=ds=#s14#" },
				{ 21, 104898, "", "=q4=Curse of Hubris", "=ds=#s14#" },
				{ 23, 104902, "", "=q4=Horned Mace of the Old Ones", "=ds=#h1#, #w6#" },
				{ 24, 104887, "", "=q4=Kor'kron Spire of Supremacy", "=ds=#w9#" },
				{ 25, 104897, "", "=q4=Xal'atoh, Desecrated Image of Gorehowl", "=ds=#h2#, #w1#" },
				{ 26, 104903, "", "=q4=Revelations of Y'Shaarj", "=ds=#s15#" },
			};
			{
				{ 1, 105672, "", "=q7=Hellscream's Cleaver", "=ds=#h1#, #w1#" },
				{ 2, 105679, "", "=q7=Hellscream's Decapitator", "=ds=#h2#, #w1#" },
				{ 3, 105678, "", "=q7=Hellscream's Doomblade", "=ds=#h1#, #w10#" },
				{ 4, 105673, "", "=q7=Hellscream's Pig Sticker", "=ds=#w7#" },
				{ 5, 105671, "", "=q7=Hellscream's Razor", "=ds=#h1#, #w4#" },
				{ 6, 105677, "", "=q7=Hellscream's War Staff", "=ds=#w9#" },
				{ 7, 105670, "", "=q7=Hellscream's Warbow", "=ds=#w2#" },
				{ 8, 105675, "", "=q7=Hellscream's Warmace", "=ds=#h1#, #w6#" },
				{ 9, 105674, "", "=q7=Hellscream's Barrier", "=ds=#w8#" },
				{ 10, 105680, "", "=q7=Hellscream's Shield Wall", "=ds=#w8#" },
				{ 11, 105676, "", "=q7=Hellscream's Tome of Destruction", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103901, "", "=q4=Ebon Ritual Hood", "=ds=#s1#, #a1#", tf=105398 },
				{ 2, 103856, "", "=q4=Belt of the Broken Pact", "=ds=#s10#, #a1#", tf=105397 },
				{ 3, 103729, "", "=q4=Kor'kron Elite Skullmask", "=ds=#s1#, #a2#", tf=105387 },
				{ 4, 103925, "", "=q4=Hopeglow Spaulders", "=ds=#s3#, #a2#", tf=105403 },
				{ 5, 103928, "", "=q4=Cord of Black Dreams", "=ds=#s10#, #a2#", tf=105386 },
				{ 6, 103906, "", "=q4=Seal of Karmic Return", "=ds=#s10#, #a2#", tf=105402 },
				{ 7, 103950, "", "=q4=Cowl of Smoking Dreams", "=ds=#s1#, #a3#", tf=105404 },
				{ 8, 103931, "", "=q4=Penetrating Gaze of Y'Shaarj", "=ds=#s1#, #a3#", tf=105389 },
				{ 9, 103837, "", "=q4=Shoulderguards of Intended Power", "=ds=#s3#, #a3#", tf=105390 },
				{ 10, 103963, "", "=q4=Chestguard of Relentless Tyranny", "=ds=#s5#, #a3#", tf=105388 },
				{ 11, 103840, "", "=q4=Greathelm of the Warchief", "=ds=#s1#, #a4#", tf=105394 },
				{ 12, 103944, "", "=q4=Mantle of Looming Darkness", "=ds=#s3#, #a4#", tf=105406 },
				{ 13, 103784, "", "=q4=Spaulders of the Fallen Warchief", "=ds=#s3#, #a4#", tf=105392 },
				{ 14, 103785, "", "=q4=Tusks of Mannoroth", "=ds=#s3#, #a4#", tf=105393 },
				{ 15, 103958, "", "=q4=Chestplate of Fallen Passion", "=ds=#s5#, #a4#", tf=105405 },
				{ 16, 104311, "", "=q4=Legplates of Unthinking Strife", "=ds=#s11#, #a4#", tf=105391 },
				{ 18, 105858, "", "=q4=Essence of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 19, 105857, "", "=q4=Essence of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 20, 105859, "", "=q4=Essence of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 22, 102310, "", "=q4=Black Blood of Y'Shaarj", "=ds=#s14#", tf=105399 },
				{ 23, 102307, "", "=q4=Curse of Hubris", "=ds=#s14#", tf=105396 },
				{ 25, 103937, "", "=q4=Horned Mace of the Old Ones", "=ds=#h1#, #w6#", tf=105400 },
				{ 26, 103974, "", "=q4=Kor'kron Spire of Supremacy", "=ds=#w9#", tf=105385 },
				{ 27, 103649, "", "=q4=Xal'atoh, Desecrated Image of Gorehowl", "=ds=#h2#, #w1#", tf=105395 },
				{ 28, 103920, "", "=q4=Revelations of Y'Shaarj", "=ds=#s15#", tf=105401 },
			};
			{
				{ 1, 104404, "", "=q7=Hellscream's Cleaver", "=ds=#h1#, #w1#" },
				{ 2, 104405, "", "=q7=Hellscream's Decapitator", "=ds=#h2#, #w1#" },
				{ 3, 104401, "", "=q7=Hellscream's Doomblade", "=ds=#h1#, #w10#" },
				{ 4, 104403, "", "=q7=Hellscream's Pig Sticker", "=ds=#w7#" },
				{ 5, 104400, "", "=q7=Hellscream's Razor", "=ds=#h1#, #w4#" },
				{ 6, 104406, "", "=q7=Hellscream's War Staff", "=ds=#w9#" },
				{ 7, 104399, "", "=q7=Hellscream's Warbow", "=ds=#w2#" },
				{ 8, 104402, "", "=q7=Hellscream's Warmace", "=ds=#h1#, #w6#" },
				{ 9, 104409, "", "=q7=Hellscream's Barrier", "=ds=#w8#" },
				{ 10, 104407, "", "=q7=Hellscream's Shield Wall", "=ds=#w8#" },
				{ 11, 104408, "", "=q7=Hellscream's Tome of Destruction", "=ds=#s15#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 104651, "", "=q4=Ebon Ritual Hood", "=ds=#s1#, #a1#", tf=105647 },
				{ 2, 104650, "", "=q4=Belt of the Broken Pact", "=ds=#s10#, #a1#", tf=105646 },
				{ 3, 104640, "", "=q4=Kor'kron Elite Skullmask", "=ds=#s1#, #a2#", tf=105636 },
				{ 4, 104656, "", "=q4=Hopeglow Spaulders", "=ds=#s3#, #a2#", tf=105652 },
				{ 5, 104639, "", "=q4=Cord of Black Dreams", "=ds=#s10#, #a2#", tf=105635 },
				{ 6, 104655, "", "=q4=Seal of Karmic Return", "=ds=#s10#, #a2#", tf=105651 },
				{ 7, 104657, "", "=q4=Cowl of Smoking Dreams", "=ds=#s1#, #a3#", tf=105653 },
				{ 8, 104642, "", "=q4=Penetrating Gaze of Y'Shaarj", "=ds=#s1#, #a3#", tf=105638 },
				{ 9, 104643, "", "=q4=Shoulderguards of Intended Power", "=ds=#s3#, #a3#", tf=105639 },
				{ 10, 104641, "", "=q4=Chestguard of Relentless Tyranny", "=ds=#s5#, #a3#", tf=105637 },
				{ 11, 104647, "", "=q4=Greathelm of the Warchief", "=ds=#s1#, #a4#", tf=105643 },
				{ 12, 104659, "", "=q4=Mantle of Looming Darkness", "=ds=#s3#, #a4#", tf=105655 },
				{ 13, 104645, "", "=q4=Spaulders of the Fallen Warchief", "=ds=#s3#, #a4#", tf=105641 },
				{ 14, 104646, "", "=q4=Tusks of Mannoroth", "=ds=#s3#, #a4#", tf=105642 },
				{ 15, 104658, "", "=q4=Chestplate of Fallen Passion", "=ds=#s5#, #a4#", tf=105654 },
				{ 16, 104644, "", "=q4=Legplates of Unthinking Strife", "=ds=#s11#, #a4#", tf=105640 },
				{ 18, 105867, "", "=q4=Essence of the Cursed Conqueror", "=ds=#e15#, #m42#" },
				{ 19, 105866, "", "=q4=Essence of the Cursed Protector", "=ds=#e15#, #m42#" },
				{ 20, 105868, "", "=q4=Essence of the Cursed Vanquisher", "=ds=#e15#, #m42#" },
				{ 22, 104652, "", "=q4=Black Blood of Y'Shaarj", "=ds=#s14#", tf=105648 },
				{ 23, 104649, "", "=q4=Curse of Hubris", "=ds=#s14#", tf=105645 },
				{ 25, 104653, "", "=q4=Horned Mace of the Old Ones", "=ds=#h1#, #w6#", tf=105649 },
				{ 26, 104638, "", "=q4=Kor'kron Spire of Supremacy", "=ds=#w9#", tf=105634 },
				{ 27, 104648, "", "=q4=Xal'atoh, Desecrated Image of Gorehowl", "=ds=#h2#, #w1#", tf=105644 },
				{ 28, 104654, "", "=q4=Revelations of Y'Shaarj", "=ds=#s15#", tf=105650 },
				{ 30, 104253, "", "=q4=Kor'kron Juggernaut", "=ds=#e26#" },
			};
			{
				{ 1, 105685, "", "=q7=Hellscream's Cleaver", "=ds=#h1#, #w1#" },
				{ 2, 105692, "", "=q7=Hellscream's Decapitator", "=ds=#h2#, #w1#" },
				{ 3, 105691, "", "=q7=Hellscream's Doomblade", "=ds=#h1#, #w10#" },
				{ 4, 105686, "", "=q7=Hellscream's Pig Sticker", "=ds=#w7#" },
				{ 5, 105684, "", "=q7=Hellscream's Razor", "=ds=#h1#, #w4#" },
				{ 6, 105690, "", "=q7=Hellscream's War Staff", "=ds=#w9#" },
				{ 7, 105683, "", "=q7=Hellscream's Warbow", "=ds=#w2#" },
				{ 8, 105688, "", "=q7=Hellscream's Warmace", "=ds=#h1#, #w6#" },
				{ 9, 105687, "", "=q7=Hellscream's Barrier", "=ds=#w8#" },
				{ 10, 105693, "", "=q7=Hellscream's Shield Wall", "=ds=#w8#" },
				{ 11, 105689, "", "=q7=Hellscream's Tome of Destruction", "=ds=#s15#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Garrosh Hellscream", 869),
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOShared"] = {
		["RaidFinder"] = {
			{
				{ 1, 104271, "", "=q4=Coalesced Turmoil", "=ds=#m20#" },
				{ 2, 104275, "", "=q4=Twisted Treasures of the Vale", "=ds=#m20#" },
				{ 3, 105824, "", "=q4=Aeth's Swiftcinder Cloak", "=ds=#s4#" },
				{ 4, 105816, "", "=q4=Brave Niunai's Cloak", "=ds=#s4#" },
				{ 5, 105812, "", "=q4=Cape of the Alpha", "=ds=#s4#" },
				{ 6, 105815, "", "=q4=Drape of the Omega", "=ds=#s4#" },
				{ 7, 105825, "", "=q4=Turtleshell Greatcloak", "=ds=#s4#" },
				{ 16, 105813, "", "=q4=Kalaena's Arcane Handwraps", "=ds=#s9#, #a1#" },
				{ 17, 105814, "", "=q4=Seebo's Sainted Touch", "=ds=#s9#, #a1#" },
				{ 18, 105818, "", "=q4=Crimson Gauntlets of Death", "=ds=#s9#, #a2#" },
				{ 19, 105817, "", "=q4=Siid's Silent Stranglers", "=ds=#s9#, #a2#" },
				{ 20, 105819, "", "=q4=Keengrip Arrowpullers", "=ds=#s9#, #a3#" },
				{ 21, 105820, "", "=q4=Marco's Crackling Gloves", "=ds=#s9#, #a3#" },
				{ 22, 105823, "", "=q4=Gauntlets of Discarded Time", "=ds=#s9#, #a4#" },
				{ 23, 105821, "", "=q4=Romy's Reliable Grips", "=ds=#s9#, #a4#" },
				{ 24, 105822, "", "=q4=Zoid's Molten Gauntlets", "=ds=#s9#, #a4#" },
			};
		};
		["Flexible"] = {
			{
				{ 1, 105714, "", "=q4=Coalesced Turmoil", "=ds=#m20#" },
				{ 2, 105713, "", "=q4=Twisted Treasures of the Vale", "=ds=#m20#" },
				{ 3, 105838, "", "=q4=Aeth's Swiftcinder Cloak", "=ds=#s4#" },
				{ 4, 105830, "", "=q4=Brave Niunai's Cloak", "=ds=#s4#" },
				{ 5, 105826, "", "=q4=Cape of the Alpha", "=ds=#s4#" },
				{ 6, 105829, "", "=q4=Drape of the Omega", "=ds=#s4#" },
				{ 7, 105839, "", "=q4=Turtleshell Greatcloak", "=ds=#s4#" },
				{ 16, 105827, "", "=q4=Kalaena's Arcane Handwraps", "=ds=#s9#, #a1#" },
				{ 17, 105828, "", "=q4=Seebo's Sainted Touch", "=ds=#s9#, #a1#" },
				{ 18, 105832, "", "=q4=Crimson Gauntlets of Death", "=ds=#s9#, #a2#" },
				{ 19, 105831, "", "=q4=Siid's Silent Stranglers", "=ds=#s9#, #a2#" },
				{ 20, 105833, "", "=q4=Keengrip Arrowpullers", "=ds=#s9#, #a3#" },
				{ 21, 105834, "", "=q4=Marco's Crackling Gloves", "=ds=#s9#, #a3#" },
				{ 22, 105837, "", "=q4=Gauntlets of Discarded Time", "=ds=#s9#, #a4#" },
				{ 23, 105835, "", "=q4=Romy's Reliable Grips", "=ds=#s9#, #a4#" },
				{ 24, 105836, "", "=q4=Zoid's Molten Gauntlets", "=ds=#s9#, #a4#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 105856, "", "=q4=Echoes of War", "=ds=#m17#" },
				{ 3, 105852, "", "=q4=Aeth's Swiftcinder Cloak", "=ds=#s4#, #ITEMID:103846#" },
				{ 4, 105844, "", "=q4=Brave Niunai's Cloak", "=ds=#s4#, #ITEMID:103960#" },
				{ 5, 105840, "", "=q4=Cape of the Alpha", "=ds=#s4#, #ITEMID:103935#" },
				{ 6, 105843, "", "=q4=Drape of the Omega", "=ds=#s4#, #ITEMID:103770#" },
				{ 7, 105853, "", "=q4=Turtleshell Greatcloak", "=ds=#s4#, #ITEMID:103800#" },
				{ 18, 105841, "", "=q4=Kalaena's Arcane Handwraps", "=ds=#s9#, #a1#, #ITEMID:103854#" },
				{ 19, 105842, "", "=q4=Seebo's Sainted Touch", "=ds=#s9#, #a1#, #ITEMID:103753#" },
				{ 20, 105846, "", "=q4=Crimson Gauntlets of Death", "=ds=#s9#, #a2#, #ITEMID:103859#" },
				{ 21, 105845, "", "=q4=Siid's Silent Stranglers", "=ds=#s9#, #a2#, #ITEMID:103832#" },
				{ 22, 105847, "", "=q4=Keengrip Arrowpullers", "=ds=#s9#, #a3#, #ITEMID:103781#" },
				{ 23, 105848, "", "=q4=Marco's Crackling Gloves", "=ds=#s9#, #a3#, #ITEMID:103764#" },
				{ 24, 105851, "", "=q4=Gauntlets of Discarded Time", "=ds=#s9#, #a4#, #ITEMID:103791#" },
				{ 25, 105849, "", "=q4=Romy's Reliable Grips", "=ds=#s9#, #a4#, #ITEMID:103818#" },
				{ 26, 105850, "", "=q4=Zoid's Molten Gauntlets", "=ds=#s9#, #a4#, #ITEMID:103734#" },
			};
		};
		info = {
			name = AL["Shared Boss Loot"],
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

	AtlasLoot_Data["SoOTrash"] = {
		["Flexible"] = {
			{
				{ 1, 105838, "", "=q4=Aeth's Swiftcinder Cloak", "=ds=#s4#" },
				{ 2, 105830, "", "=q4=Brave Niunai's Cloak", "=ds=#s4#" },
				{ 3, 105826, "", "=q4=Cape of the Alpha", "=ds=#s4#" },
				{ 4, 105829, "", "=q4=Drape of the Omega", "=ds=#s4#" },
				{ 5, 105839, "", "=q4=Turtleshell Greatcloak", "=ds=#s4#" },
				{ 7, 105827, "", "=q4=Kalaena's Arcane Handwraps", "=ds=#s9#, #a1#" },
				{ 8, 105828, "", "=q4=Seebo's Sainted Touch", "=ds=#s9#, #a1#" },
				{ 9, 105832, "", "=q4=Crimson Gauntlets of Death", "=ds=#s9#, #a2#" },
				{ 10, 105831, "", "=q4=Siid's Silent Stranglers", "=ds=#s9#, #a2#" },
				{ 11, 105833, "", "=q4=Keengrip Arrowpullers", "=ds=#s9#, #a3#" },
				{ 12, 105834, "", "=q4=Marco's Crackling Gloves", "=ds=#s9#, #a3#" },
				{ 13, 105837, "", "=q4=Gauntlets of Discarded Time", "=ds=#s9#, #a4#" },
				{ 14, 105835, "", "=q4=Romy's Reliable Grips", "=ds=#s9#, #a4#" },
				{ 15, 105836, "", "=q4=Zoid's Molten Gauntlets", "=ds=#s9#, #a4#" },
				{ 16, 105745, "", "=q4=Kor'kron Dark Shaman Cowl", "=ds=#s1#" },
				{ 17, 105747, "", "=q4=Kor'kron Dark Shaman Shoulder", "=ds=#s3#" },
				{ 18, 105743, "", "=q4=Kor'kron Dark Shaman Vestment", "=ds=#s5#" },
				{ 19, 105748, "", "=q4=Kor'kron Dark Shaman Bracers", "=ds=#s8#" },
				{ 20, 105744, "", "=q4=Kor'kron Dark Shaman Gloves", "=ds=#s9#" },
				{ 21, 105741, "", "=q4=Kor'kron Dark Shaman Belt", "=ds=#s10#" },
				{ 22, 105746, "", "=q4=Kor'kron Dark Shaman Kilt", "=ds=#s11#" },
				{ 23, 105742, "", "=q4=Kor'kron Dark Shaman Treads", "=ds=#s12#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 103846, "", "=q4=Aeth's Swiftcinder Cloak", "=ds=#s4#" },
				{ 2, 103960, "", "=q4=Brave Niunai's Cloak", "=ds=#s4#" },
				{ 3, 103935, "", "=q4=Cape of the Alpha", "=ds=#s4#" },
				{ 4, 103770, "", "=q4=Drape of the Omega", "=ds=#s4#" },
				{ 5, 103800, "", "=q4=Turtleshell Greatcloak", "=ds=#s4#" },
				{ 7, 103854, "", "=q4=Kalaena's Arcane Handwraps", "=ds=#s9#, #a1#" },
				{ 8, 103753, "", "=q4=Seebo's Sainted Touch", "=ds=#s9#, #a1#" },
				{ 9, 103859, "", "=q4=Crimson Gauntlets of Death", "=ds=#s9#, #a2#" },
				{ 10, 103832, "", "=q4=Siid's Silent Stranglers", "=ds=#s9#, #a2#" },
				{ 11, 103781, "", "=q4=Keengrip Arrowpullers", "=ds=#s9#, #a3#" },
				{ 12, 103764, "", "=q4=Marco's Crackling Gloves", "=ds=#s9#, #a3#" },
				{ 13, 103791, "", "=q4=Gauntlets of Discarded Time", "=ds=#s9#, #a4#" },
				{ 14, 103818, "", "=q4=Romy's Reliable Grips", "=ds=#s9#, #a4#" },
				{ 15, 103734, "", "=q4=Zoid's Molten Gauntlets", "=ds=#s9#, #a4#" },
				{ 16, 105745, "", "=q4=Kor'kron Dark Shaman Cowl", "=ds=#s1#" },
				{ 17, 105747, "", "=q4=Kor'kron Dark Shaman Shoulder", "=ds=#s3#" },
				{ 18, 105743, "", "=q4=Kor'kron Dark Shaman Vestment", "=ds=#s5#" },
				{ 19, 105748, "", "=q4=Kor'kron Dark Shaman Bracers", "=ds=#s8#" },
				{ 20, 105744, "", "=q4=Kor'kron Dark Shaman Gloves", "=ds=#s9#" },
				{ 21, 105741, "", "=q4=Kor'kron Dark Shaman Belt", "=ds=#s10#" },
				{ 22, 105746, "", "=q4=Kor'kron Dark Shaman Kilt", "=ds=#s11#" },
				{ 23, 105742, "", "=q4=Kor'kron Dark Shaman Treads", "=ds=#s12#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "SiegeofOrgrimmar",
		};
	};

		---------------------------------
		--- Terrace of Endless Spring ---
		---------------------------------

	AtlasLoot_Data["ToESProtectors"] = {
		["RaidFinder"] = {
			{
				{ 1, 86874, "", "=q4=Cloak of Overwhelming Corruption", "=ds=#s4#" },
				{ 2, 86875, "", "=q4=Cuffs of the Corrupted Waters", "=ds=#s8#, #a1#" },
				{ 3, 86878, "", "=q4=Asani's Uncleansed Sandals", "=ds=#s12#, #a2#" },
				{ 4, 86877, "", "=q4=Lightning Prisoner's Boots", "=ds=#s12#, #a3#" },
				{ 5, 86876, "", "=q4=Casque of Expelled Corruption", "=ds=#s1#, #a4#" },
				{ 6, 86868, "", "=q4=Bracers of Defiled Earth", "=ds=#s8#, #a4#" },
				{ 7, 86870, "", "=q4=Deepwater Greatboots", "=ds=#s12#, #a4#" },
				{ 16, 86872, "", "=q4=Kaolan's Withering Necklace", "=ds=#s2#" },
				{ 17, 86871, "", "=q4=Shackle of Eversparks", "=ds=#s2#" },
				{ 18, 86869, "", "=q4=Regail's Band of the Endless", "=ds=#s13#" },
				{ 19, 86873, "", "=q4=Watersoul Signet", "=ds=#s13#" },
				{ 21, 86909, "", "=q4=Regail's Crackling Dagger", "=ds=#h1#, #w4#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86316, "", "=q4=Cloak of Overwhelming Corruption", "=ds=#s4#" },
				{ 2, 86317, "", "=q4=Cuffs of the Corrupted Waters", "=ds=#s8#, #a1#" },
				{ 3, 86320, "", "=q4=Asani's Uncleansed Sandals", "=ds=#s12#, #a2#" },
				{ 4, 86319, "", "=q4=Lightning Prisoner's Boots", "=ds=#s12#, #a3#" },
				{ 5, 86318, "", "=q4=Casque of Expelled Corruption", "=ds=#s1#, #a4#" },
				{ 6, 86230, "", "=q4=Bracers of Defiled Earth", "=ds=#s8#, #a4#" },
				{ 7, 86232, "", "=q4=Deepwater Greatboots", "=ds=#s12#, #a4#" },
				{ 8, 86234, "", "=q4=Kaolan's Withering Necklace", "=ds=#s2#" },
				{ 9, 86233, "", "=q4=Shackle of Eversparks", "=ds=#s2#" },
				{ 10, 86231, "", "=q4=Regail's Band of the Endless", "=ds=#s13#" },
				{ 11, 86315, "", "=q4=Watersoul Signet", "=ds=#s13#" },
				{ 12, 86390, "", "=q4=Regail's Crackling Dagger", "=ds=#h1#, #w4#" },
				{ 16, 0, "inv_box_04", "=q6="..AL["Elite"], ""};
				{ 17, 90526, "", "=q4=Cloak of Overwhelming Corruption", "=ds=#s4#" },
				{ 18, 90524, "", "=q4=Cuffs of the Corrupted Waters", "=ds=#s8#, #a1#" },
				{ 19, 90528, "", "=q4=Asani's Uncleansed Sandals", "=ds=#s12#, #a2#" },
				{ 20, 90518, "", "=q4=Legguards of Failing Purification", "=ds=#s11#, #a2#" },
				{ 21, 90519, "", "=q4=Waterborne Shoulderguards", "=ds=#s3#, #a3#" },
				{ 22, 90529, "", "=q4=Lightning Prisoner's Boots", "=ds=#s12#, #a3#" },
				{ 23, 90530, "", "=q4=Casque of Expelled Corruption", "=ds=#s1#, #a4#" },
				{ 24, 90520, "", "=q4=Bracers of Defiled Earth", "=ds=#s8#, #a4#" },
				{ 25, 90521, "", "=q4=Deepwater Greatboots", "=ds=#s12#, #a4#" },
				{ 26, 90523, "", "=q4=Kaolan's Withering Necklace", "=ds=#s2#" },
				{ 27, 90522, "", "=q4=Shackle of Eversparks", "=ds=#s2#" },
				{ 28, 90517, "", "=q4=Regail's Band of the Endless", "=ds=#s13#" },
				{ 29, 90525, "", "=q4=Watersoul Signet", "=ds=#s13#" },
				{ 30, 90527, "", "=q4=Regail's Crackling Dagger", "=ds=#h1#, #w4#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87150, "", "=q4=Cloak of Overwhelming Corruption", "=ds=#s4#" },
				{ 2, 87149, "", "=q4=Cuffs of the Corrupted Waters", "=ds=#s8#, #a1#" },
				{ 3, 87153, "", "=q4=Asani's Uncleansed Sandals", "=ds=#s12#, #a2#" },
				{ 4, 87154, "", "=q4=Lightning Prisoner's Boots", "=ds=#s12#, #a3#" },
				{ 5, 87155, "", "=q4=Casque of Expelled Corruption", "=ds=#s1#, #a4#" },
				{ 6, 87145, "", "=q4=Bracers of Defiled Earth", "=ds=#s8#, #a4#" },
				{ 7, 87146, "", "=q4=Deepwater Greatboots", "=ds=#s12#, #a4#" },
				{ 8, 87148, "", "=q4=Kaolan's Withering Necklace", "=ds=#s2#" },
				{ 9, 87147, "", "=q4=Shackle of Eversparks", "=ds=#s2#" },
				{ 10, 87144, "", "=q4=Regail's Band of the Endless", "=ds=#s13#" },
				{ 11, 87151, "", "=q4=Watersoul Signet", "=ds=#s13#" },
				{ 12, 87152, "", "=q4=Regail's Crackling Dagger", "=ds=#h1#, #w4#" },
				{ 16, 0, "inv_box_04", "=q6="..AL["Elite"], ""};
				{ 17, 90512, "", "=q4=Cloak of Overwhelming Corruption", "=ds=#s4#" },
				{ 18, 90510, "", "=q4=Cuffs of the Corrupted Waters", "=ds=#s8#, #a1#" },
				{ 19, 90514, "", "=q4=Asani's Uncleansed Sandals", "=ds=#s12#, #a2#" },
				{ 20, 90504, "", "=q4=Legguards of Failing Purification", "=ds=#s11#, #a2#" },
				{ 21, 90505, "", "=q4=Waterborne Shoulderguards", "=ds=#s3#, #a3#" },
				{ 22, 90515, "", "=q4=Lightning Prisoner's Boots", "=ds=#s12#, #a3#" },
				{ 23, 90516, "", "=q4=Casque of Expelled Corruption", "=ds=#s1#, #a4#" },
				{ 24, 90506, "", "=q4=Bracers of Defiled Earth", "=ds=#s8#, #a4#" },
				{ 25, 90507, "", "=q4=Deepwater Greatboots", "=ds=#s12#, #a4#" },
				{ 26, 90509, "", "=q4=Kaolan's Withering Necklace", "=ds=#s2#" },
				{ 27, 90508, "", "=q4=Shackle of Eversparks", "=ds=#s2#" },
				{ 28, 90503, "", "=q4=Regail's Band of the Endless", "=ds=#s13#" },
				{ 29, 90511, "", "=q4=Watersoul Signet", "=ds=#s13#" },
				{ 30, 90513, "", "=q4=Regail's Crackling Dagger", "=ds=#h1#, #w4#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Protectors of the Endless", 683),
			module = moduleName, instance = "TerraceofEndlessSpring",
		};
	};

	AtlasLoot_Data["ToESTsulong"] = {
		["RaidFinder"] = {
			{
				{ 1, 86883, "", "=q4=Daybreak Drape", "=ds=#s4#" },
				{ 2, 89982, "", "=q4=Shoulderpads of Twisted Fate", "=ds=#s3#, #a1#" },
				{ 3, 86884, "", "=q4=Belt of Embodied Terror", "=ds=#s10#, #a1#" },
				{ 4, 86895, "", "=q4=Healer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 5, 86896, "", "=q4=Invoker's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 6, 86897, "", "=q4=Sorcerer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 7, 86888, "", "=q4=Sandals of the Blackest Night", "=ds=#s12#, #a1#" },
				{ 8, 89980, "", "=q4=Gauntlets of the Shadow's Caress", "=ds=#s9#, #a2#" },
				{ 9, 86899, "", "=q4=Stalker's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 10, 86898, "", "=q4=Weaver's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 11, 89983, "", "=q4=Fear-Blackened Leggings", "=ds=#s11#, #a2#" },
				{ 12, 86882, "", "=q4=Sunwrought Mail Hauberk", "=ds=#s5#, #a3#" },
				{ 13, 86900, "", "=q4=Binder's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 14, 86901, "", "=q4=Ranger's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 15, 89981, "", "=q4=Grasps of Serpentine Might", "=ds=#s9#, #a4#" },
				{ 16, 86902, "", "=q4=Mender's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 17, 86904, "", "=q4=Patroller's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 18, 86903, "", "=q4=Protector's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 19, 86887, "", "=q4=Sollerets of Instability", "=ds=#s12#, #a4#" },
				{ 21, 86880, "", "=q4=Dread Shadow Ring", "=ds=#s13#" },
				{ 22, 86885, "", "=q4=Spirits of the Sun", "=ds=#s14#" },
				{ 23, 86881, "", "=q4=Stuff of Nightmares", "=ds=#s14#" },
				{ 25, 86886, "", "=q4=Loshan, Terror Incarnate", "=ds=#h1#, #w10#" },
				{ 26, 86879, "", "=q4=Gao-Rei, Staff of the Legendary Protector", "=ds=#w9#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86325, "", "=q4=Daybreak Drape", "=ds=#s4#" },
				{ 2, 89883, "", "=q4=Shoulderpads of Twisted Fate", "=ds=#s3#, #a1#" },
				{ 3, 86326, "", "=q4=Belt of Embodied Terror", "=ds=#s10#, #a1#" },
				{ 4, 86337, "", "=q4=Healer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 5, 86338, "", "=q4=Invoker's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 6, 86339, "", "=q4=Sorcerer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 7, 86330, "", "=q4=Sandals of the Blackest Night", "=ds=#s12#, #a1#" },
				{ 8, 89842, "", "=q4=Gauntlets of the Shadow's Caress", "=ds=#s9#, #a2#" },
				{ 9, 86341, "", "=q4=Stalker's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 10, 86340, "", "=q4=Weaver's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 11, 89884, "", "=q4=Fear-Blackened Leggings", "=ds=#s11#, #a2#" },
				{ 12, 86324, "", "=q4=Sunwrought Mail Hauberk", "=ds=#s5#, #a3#" },
				{ 13, 86342, "", "=q4=Binder's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 14, 86343, "", "=q4=Ranger's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 15, 89843, "", "=q4=Grasps of Serpentine Might", "=ds=#s9#, #a4#" },
				{ 16, 86383, "", "=q4=Mender's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 17, 86385, "", "=q4=Patroller's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 18, 86384, "", "=q4=Protector's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 19, 86329, "", "=q4=Sollerets of Instability", "=ds=#s12#, #a4#" },
				{ 21, 86322, "", "=q4=Dread Shadow Ring", "=ds=#s13#" },
				{ 22, 86327, "", "=q4=Spirits of the Sun", "=ds=#s14#" },
				{ 23, 86323, "", "=q4=Stuff of Nightmares", "=ds=#s14#" },
				{ 25, 86328, "", "=q4=Loshan, Terror Incarnate", "=ds=#h1#, #w10#" },
				{ 26, 86321, "", "=q4=Gao-Rei, Staff of the Legendary Protector", "=ds=#w9#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87159, "", "=q4=Daybreak Drape", "=ds=#s4#" },
				{ 2, 89947, "", "=q4=Shoulderpads of Twisted Fate", "=ds=#s3#, #a1#" },
				{ 3, 87161, "", "=q4=Belt of Embodied Terror", "=ds=#s10#, #a1#" },
				{ 4, 87178, "", "=q4=Healer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 5, 87177, "", "=q4=Invoker's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 6, 87179, "", "=q4=Sorcerer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 7, 87162, "", "=q4=Sandals of the Blackest Night", "=ds=#s12#, #a1#" },
				{ 8, 89945, "", "=q4=Gauntlets of the Shadow's Caress", "=ds=#s9#, #a2#" },
				{ 9, 87180, "", "=q4=Stalker's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 10, 87181, "", "=q4=Weaver's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 11, 89948, "", "=q4=Fear-Blackened Leggings", "=ds=#s11#, #a2#" },
				{ 12, 87157, "", "=q4=Sunwrought Mail Hauberk", "=ds=#s5#, #a3#" },
				{ 13, 87183, "", "=q4=Binder's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 14, 87182, "", "=q4=Ranger's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 15, 89946, "", "=q4=Grasps of Serpentine Might", "=ds=#s9#, #a4#" },
				{ 16, 87184, "", "=q4=Mender's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 17, 87186, "", "=q4=Patroller's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 18, 87185, "", "=q4=Protector's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 19, 87165, "", "=q4=Sollerets of Instability", "=ds=#s12#, #a4#" },
				{ 21, 87158, "", "=q4=Dread Shadow Ring", "=ds=#s13#" },
				{ 22, 87163, "", "=q4=Spirits of the Sun", "=ds=#s14#" },
				{ 23, 87160, "", "=q4=Stuff of Nightmares", "=ds=#s14#" },
				{ 25, 87164, "", "=q4=Loshan, Terror Incarnate", "=ds=#h1#, #w10#" },
				{ 26, 87156, "", "=q4=Gao-Rei, Staff of the Legendary Protector", "=ds=#w9#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Tsulong", 742),
			module = moduleName, instance = "TerraceofEndlessSpring",
		};
	};

	AtlasLoot_Data["ToESLeiShi"] = {
		["RaidFinder"] = {
			{
				{ 1, 86892, "", "=q4=Robes of the Unknown Fear", "=ds=#s5#, #a1#" },
				{ 2, 86895, "", "=q4=Healer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 3, 86896, "", "=q4=Invoker's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 4, 86897, "", "=q4=Sorcerer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 5, 86899, "", "=q4=Stalker's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 6, 86898, "", "=q4=Weaver's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 7, 86900, "", "=q4=Binder's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 8, 86901, "", "=q4=Ranger's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 9, 86891, "", "=q4=Cuirass of the Animated Protector", "=ds=#s5#, #a4#" },
				{ 10, 86902, "", "=q4=Mender's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 11, 86904, "", "=q4=Patroller's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 12, 86903, "", "=q4=Protector's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 16, 89277, "", "=q4=Shoulders of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89278, "", "=q4=Shoulders of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89276, "", "=q4=Shoulders of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86894, "", "=q4=Darkmist Vortex", "=ds=#s14#" },
				{ 21, 86890, "", "=q4=Terror in the Mists", "=ds=#s14#" },
				{ 23, 86910, "", "=q4=Spiritsever", "=ds=#h1#, #w4#" },
				{ 24, 86893, "", "=q4=Jin'ya, Orb of the Waterspeaker", "=ds=#w9#" },
				{ 25, 86889, "", "=q4=Taoren, the Soul Burner", "=ds=#w5#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 86334, "", "=q4=Robes of the Unknown Fear", "=ds=#s5#, #a1#" },
				{ 2, 86337, "", "=q4=Healer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 3, 86338, "", "=q4=Invoker's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 4, 86339, "", "=q4=Sorcerer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 5, 86341, "", "=q4=Stalker's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 6, 86340, "", "=q4=Weaver's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 7, 86342, "", "=q4=Binder's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 8, 86343, "", "=q4=Ranger's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 9, 86333, "", "=q4=Cuirass of the Animated Protector", "=ds=#s5#, #a4#" },
				{ 10, 86383, "", "=q4=Mender's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 11, 86385, "", "=q4=Patroller's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 12, 86384, "", "=q4=Protector's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 16, 89246, "", "=q4=Shoulders of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89247, "", "=q4=Shoulders of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89248, "", "=q4=Shoulders of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 86336, "", "=q4=Darkmist Vortex", "=ds=#s14#" },
				{ 21, 86332, "", "=q4=Terror in the Mists", "=ds=#s14#" },
				{ 23, 86391, "", "=q4=Spiritsever", "=ds=#h1#, #w4#" },
				{ 24, 86335, "", "=q4=Jin'ya, Orb of the Waterspeaker", "=ds=#w9#" },
				{ 25, 86331, "", "=q4=Taoren, the Soul Burner", "=ds=#w5#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 87169, "", "=q4=Robes of the Unknown Fear", "=ds=#s5#, #a1#" },
				{ 2, 87178, "", "=q4=Healer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 3, 87177, "", "=q4=Invoker's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 4, 87179, "", "=q4=Sorcerer's Belt of Final Winter", "=ds=#s10#, #a1#" },
				{ 5, 87180, "", "=q4=Stalker's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 6, 87181, "", "=q4=Weaver's Cord of Eternal Autumn", "=ds=#s10#, #a2#" },
				{ 7, 87183, "", "=q4=Binder's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 8, 87182, "", "=q4=Ranger's Chain of Unending Summer", "=ds=#s10#, #a3#" },
				{ 9, 87171, "", "=q4=Cuirass of the Animated Protector", "=ds=#s5#, #a4#" },
				{ 10, 87184, "", "=q4=Mender's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 11, 87186, "", "=q4=Patroller's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 12, 87185, "", "=q4=Protector's Girdle of Endless Spring", "=ds=#s10#, #a4#" },
				{ 16, 89262, "", "=q4=Shoulders of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89263, "", "=q4=Shoulders of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89261, "", "=q4=Shoulders of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
				{ 20, 87172, "", "=q4=Darkmist Vortex", "=ds=#s14#" },
				{ 21, 87167, "", "=q4=Terror in the Mists", "=ds=#s14#" },
				{ 23, 87166, "", "=q4=Spiritsever", "=ds=#h1#, #w4#" },
				{ 24, 87170, "", "=q4=Jin'ya, Orb of the Waterspeaker", "=ds=#w9#" },
				{ 25, 87168, "", "=q4=Taoren, the Soul Burner", "=ds=#w5#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lei Shi", 729),
			module = moduleName, instance = "TerraceofEndlessSpring",
		};
	};

	AtlasLoot_Data["ToESShaofFear"] = {
		["RaidFinder"] = {
			{
				{ 1, 89984, "", "=q4=Robes of Pinioned Eyes", "=ds=#s5#, #a1#" },
				{ 2, 86908, "", "=q4=Dreadwoven Leggings of Failure", "=ds=#s11#, #a1#" },
				{ 3, 89985, "", "=q4=Wrap of Instant Petrification", "=ds=#s5#, #a2#" },
				{ 4, 89986, "", "=q4=Shadowgrip Girdle", "=ds=#s10#, #a3#" },
				{ 6, 86907, "", "=q4=Essence of Terror", "=ds=#s14#" },
				{ 8, 86906, "", "=q4=Kilrak, Jaws of Terror", "=ds=#h1#, #w10#" },
				{ 9, 86905, "", "=q4=Shin'ka, Execution of Dominion", "=ds=#h2#, #w1#" },
				{ 11, 87210, "", "=q5=Chimera of Fear", "=ds=#m3#" },
				{ 16, 89274, "", "=q4=Helm of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89275, "", "=q4=Helm of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89273, "", "=q4=Helm of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
			};
		};
		["Normal"] = {
			{
				{ 1, 89887, "", "=q4=Robes of Pinioned Eyes", "=ds=#s5#, #a1#" },
				{ 2, 86389, "", "=q4=Dreadwoven Leggings of Failure", "=ds=#s11#, #a1#" },
				{ 3, 89886, "", "=q4=Wrap of Instant Petrification", "=ds=#s5#, #a2#" },
				{ 4, 89839, "", "=q4=Shadowgrip Girdle", "=ds=#s10#, #a3#" },
				{ 6, 86388, "", "=q4=Essence of Terror", "=ds=#s14#" },
				{ 8, 86387, "", "=q4=Kilrak, Jaws of Terror", "=ds=#h1#, #w10#" },
				{ 9, 86386, "", "=q4=Shin'ka, Execution of Dominion", "=ds=#h2#, #w1#" },
				{ 11, 87210, "", "=q5=Chimera of Fear", "=ds=#m3#" },
				{ 16, 89235, "", "=q4=Helm of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89236, "", "=q4=Helm of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89234, "", "=q4=Helm of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 89949, "", "=q4=Robes of Pinioned Eyes", "=ds=#s5#, #a1#" },
				{ 2, 87174, "", "=q4=Dreadwoven Leggings of Failure", "=ds=#s11#, #a1#" },
				{ 3, 89950, "", "=q4=Wrap of Instant Petrification", "=ds=#s5#, #a2#" },
				{ 4, 89951, "", "=q4=Shadowgrip Girdle", "=ds=#s10#, #a3#" },
				{ 6, 87175, "", "=q4=Essence of Terror", "=ds=#s14#" },
				{ 8, 87173, "", "=q4=Kilrak, Jaws of Terror", "=ds=#h1#, #w10#" },
				{ 9, 87176, "", "=q4=Shin'ka, Execution of Dominion", "=ds=#h2#, #w1#" },
				{ 11, 87210, "", "=q5=Chimera of Fear", "=ds=#m3#" },
				{ 16, 89259, "", "=q4=Helm of the Shadowy Conqueror", "=ds=#e15#, #m40#"};
				{ 17, 89260, "", "=q4=Helm of the Shadowy Protector", "=ds=#e15#, #m40#"};
				{ 18, 89258, "", "=q4=Helm of the Shadowy Vanquisher", "=ds=#e15#, #m40#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sha of Fear", 709),
			module = moduleName, instance = "TerraceofEndlessSpring",
		};
	};

		-------------------------
		--- Throne of Thunder ---
		-------------------------

	AtlasLoot_Data["ToTJinrokh"] = {
		["RaidFinder"] = {
			{
				{ 1, 95639, "", "=q4=Drape of Booming Nights", "=ds=#s4#" },
				{ 2, 95636, "", "=q4=Fissure-Split Shoulderwraps", "=ds=#s3#, #a1#" },
				{ 3, 95637, "", "=q4=Robes of Static Bursts", "=ds=#s5#, #a1#" },
				{ 4, 95634, "", "=q4=Lightningweaver Gauntlets", "=ds=#s9#, #a1#" },
				{ 5, 95635, "", "=q4=Al'set's Tormented Leggings", "=ds=#s11#, #a1#" },
				{ 6, 95626, "", "=q4=Lightning-Eye Hood", "=ds=#s1#, #a2#" },
				{ 7, 95642, "", "=q4=Infinitely Conducting Bracers", "=ds=#s8#, #a2#" },
				{ 8, 95628, "", "=q4=Static-Shot Shoulderguards", "=ds=#s3#, #a3#" },
				{ 9, 95627, "", "=q4=Spearman's Jingling Leggings", "=ds=#s11#, #a3#" },
				{ 10, 95643, "", "=q4=Ghostbinder Greatboots", "=ds=#s12#, #a3#" },
				{ 11, 95630, "", "=q4=Chestplate of Violent Detonation", "=ds=#s5#, #a4#" },
				{ 12, 95644, "", "=q4=Ionized Yojamban Carapace", "=ds=#s5#, #a4#" },
				{ 13, 95631, "", "=q4=Bracers of Constant Implosion", "=ds=#s8#, #a4#" },
				{ 14, 95629, "", "=q4=Cloudbreaker Greatbelt", "=ds=#s10#, #a4#" },
				{ 16, 95638, "", "=q4=Jin'rokh's Dreamshard", "=ds=#s13#" },
				{ 17, 95633, "", "=q4=Jin'rokh's Soulcrystal", "=ds=#s13#" },
				{ 18, 95624, "", "=q4=Sign of the Bloodied God", "=ds=#s13#" },
				{ 19, 95625, "", "=q4=Renataki's Soul Charm", "=ds=#s14#" },
				{ 21, 95640, "", "=q4=Soulblade of the Breaking Storm", "=ds=#h1#, #w10#" },
				{ 22, 95632, "", "=q4=Worldbreaker's Stormscythe", "=ds=#h1#, #w1#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94735, "", "=q4=Drape of Booming Nights", "=ds=#s4#", tf=96011 },
				{ 2, 94733, "", "=q4=Fissure-Split Shoulderwraps", "=ds=#s3#, #a1#", tf=96008 },
				{ 3, 94731, "", "=q4=Robes of Static Bursts", "=ds=#s5#, #a1#", tf=96009 },
				{ 4, 94737, "", "=q4=Lightningweaver Gauntlets", "=ds=#s9#, #a1#", tf=96006 },
				{ 5, 94739, "", "=q4=Al'set's Tormented Leggings", "=ds=#s11#, #a1#", tf=96007 },
				{ 6, 94724, "", "=q4=Lightning-Eye Hood", "=ds=#s1#, #a2#", tf=95998 },
				{ 7, 94732, "", "=q4=Infinitely Conducting Bracers", "=ds=#s8#, #a2#", tf=96014 },
				{ 8, 94725, "", "=q4=Static-Shot Shoulderguards", "=ds=#s3#, #a3#", tf=96000 },
				{ 9, 94728, "", "=q4=Spearman's Jingling Leggings", "=ds=#s11#, #a3#", tf=95999 },
				{ 10, 94736, "", "=q4=Ghostbinder Greatboots", "=ds=#s12#, #a3#", tf=96015 },
				{ 11, 94723, "", "=q4=Chestplate of Violent Detonation", "=ds=#s5#, #a4#", tf=96002 },
				{ 12, 94734, "", "=q4=Ionized Yojamban Carapace", "=ds=#s5#, #a4#", tf=96016 },
				{ 13, 94727, "", "=q4=Bracers of Constant Implosion", "=ds=#s8#, #a4#", tf=96003 },
				{ 14, 94726, "", "=q4=Cloudbreaker Greatbelt", "=ds=#s10#, #a4#", tf=96001 },
				{ 16, 94738, "", "=q4=Jin'rokh's Dreamshard", "=ds=#s13#", tf=96010 },
				{ 17, 94729, "", "=q4=Jin'rokh's Soulcrystal", "=ds=#s13#", tf=96005 },
				{ 18, 95510, "", "=q4=Sign of the Bloodied God", "=ds=#s13#", tf=95996 },
				{ 19, 94512, "", "=q4=Renataki's Soul Charm", "=ds=#s14#", tf=95997 },
				{ 21, 94730, "", "=q4=Soulblade of the Breaking Storm", "=ds=#h1#, #w10#", tf=96012 },
				{ 22, 94722, "", "=q4=Worldbreaker's Stormscythe", "=ds=#h1#, #w1#", tf=96004 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96383, "", "=q4=Drape of Booming Nights", "=ds=#s4#", tf=96755 },
				{ 2, 96380, "", "=q4=Fissure-Split Shoulderwraps", "=ds=#s3#, #a1#", tf=96752 },
				{ 3, 96381, "", "=q4=Robes of Static Bursts", "=ds=#s5#, #a1#", tf=96753 },
				{ 4, 96378, "", "=q4=Lightningweaver Gauntlets", "=ds=#s9#, #a1#", tf=96750 },
				{ 5, 96379, "", "=q4=Al'set's Tormented Leggings", "=ds=#s11#, #a1#", tf=96751 },
				{ 6, 96370, "", "=q4=Lightning-Eye Hood", "=ds=#s1#, #a2#", tf=96742 },
				{ 7, 96386, "", "=q4=Infinitely Conducting Bracers", "=ds=#s8#, #a2#", tf=96758 },
				{ 8, 96372, "", "=q4=Static-Shot Shoulderguards", "=ds=#s3#, #a3#", tf=96744 },
				{ 9, 96371, "", "=q4=Spearman's Jingling Leggings", "=ds=#s11#, #a3#", tf=96743 },
				{ 10, 96387, "", "=q4=Ghostbinder Greatboots", "=ds=#s12#, #a3#", tf=96759 },
				{ 11, 96374, "", "=q4=Chestplate of Violent Detonation", "=ds=#s5#, #a4#", tf=96746 },
				{ 12, 96388, "", "=q4=Ionized Yojamban Carapace", "=ds=#s5#, #a4#", tf=96760 },
				{ 13, 96375, "", "=q4=Bracers of Constant Implosion", "=ds=#s8#, #a4#", tf=96747 },
				{ 14, 96373, "", "=q4=Cloudbreaker Greatbelt", "=ds=#s10#, #a4#", tf=96745 },
				{ 16, 96382, "", "=q4=Jin'rokh's Dreamshard", "=ds=#s13#", tf=96754 },
				{ 17, 96377, "", "=q4=Jin'rokh's Soulcrystal", "=ds=#s13#", tf=96749 },
				{ 18, 96368, "", "=q4=Sign of the Bloodied God", "=ds=#s13#", tf=96740 },
				{ 19, 96369, "", "=q4=Renataki's Soul Charm", "=ds=#s14#", tf=96741 },
				{ 21, 96384, "", "=q4=Soulblade of the Breaking Storm", "=ds=#h1#, #w10#", tf=96756 },
				{ 22, 96376, "", "=q4=Worldbreaker's Stormscythe", "=ds=#h1#, #w1#", tf=96748 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Jin'rokh the Breaker", 827),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTHorridon"] = {
		["RaidFinder"] = {
			{
				{ 1, 95653, "", "=q4=Horn-Rimmed Doomcloak", "=ds=#s4#" },
				{ 2, 95645, "", "=q4=Wastewalker's Sandblasted Drape", "=ds=#s4#" },
				{ 3, 95655, "", "=q4=Flamecaster's Burning Crown", "=ds=#s1#, #a1#" },
				{ 4, 95656, "", "=q4=Vaccinator's Armwraps", "=ds=#s8#, #a1#" },
				{ 5, 95662, "", "=q4=Spaulders of Dinomancy", "=ds=#s3#, #a2#" },
				{ 6, 95648, "", "=q4=Bindings of Multiplicative Strikes", "=ds=#s8#, #a2#" },
				{ 7, 95661, "", "=q4=Roots of Rampaging Earth", "=ds=#s11#, #a2#" },
				{ 8, 95649, "", "=q4=Sul'lithuz Sandmail", "=ds=#s5#, #a3#" },
				{ 9, 95663, "", "=q4=Legguards of Scintillating Scales", "=ds=#s11#, #a3#" },
				{ 10, 95652, "", "=q4=Puncture-Proof Greathelm", "=ds=#s1#, #a4#" },
				{ 11, 95664, "", "=q4=Armplates of the Vanquished Abomination", "=ds=#s8#, #a4#" },
				{ 12, 95650, "", "=q4=Frozen Warlord's Bracers", "=ds=#s8#, #a4#" },
				{ 13, 95651, "", "=q4=Bloodlord's Bloodsoaked Legplates", "=ds=#s11#, #a4#" },
				{ 16, 95658, "", "=q4=Horridon's Tusk Fragment", "=ds=#s2#" },
				{ 17, 95646, "", "=q4=Talisman of Living Poison", "=ds=#s2#" },
				{ 18, 95659, "", "=q4=Petrified Eye of the Basilisk", "=ds=#s13#" },
				{ 19, 95641, "", "=q4=Horridon's Last Gasp", "=ds=#s14#" },
				{ 20, 95654, "", "=q4=Spark of Zandalar", "=ds=#s14#" },
				{ 22, 95657, "", "=q4=Dinomancer's Spiritbinding Spire", "=ds=#w9#" },
				{ 23, 95647, "", "=q4=Jalak's Maelstrom Staff", "=ds=#w9#" },
				{ 24, 95660, "", "=q4=Venomlord's Totemic Wand", "=ds=#w12#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94745, "", "=q4=Horn-Rimmed Doomcloak", "=ds=#s4#", tf=96025 },
				{ 2, 94748, "", "=q4=Wastewalker's Sandblasted Drape", "=ds=#s4#", tf=96017 },
				{ 3, 94752, "", "=q4=Flamecaster's Burning Crown", "=ds=#s1#, #a1#", tf=96027 },
				{ 4, 94750, "", "=q4=Vaccinator's Armwraps", "=ds=#s8#, #a1#", tf=96028 },
				{ 5, 94753, "", "=q4=Spaulders of Dinomancy", "=ds=#s3#, #a2#", tf=96034 },
				{ 6, 94743, "", "=q4=Bindings of Multiplicative Strikes", "=ds=#s8#, #a2#", tf=96020 },
				{ 7, 94756, "", "=q4=Roots of Rampaging Earth", "=ds=#s11#, #a2#", tf=96033 },
				{ 8, 94741, "", "=q4=Sul'lithuz Sandmail", "=ds=#s5#, #a3#", tf=96021 },
				{ 9, 94975, "", "=q4=Legguards of Scintillating Scales", "=ds=#s11#, #a3#", tf=96035 },
				{ 10, 94744, "", "=q4=Puncture-Proof Greathelm", "=ds=#s1#, #a4#", tf=96024 },
				{ 11, 94751, "", "=q4=Armplates of the Vanquished Abomination", "=ds=#s8#, #a4#", tf=96036 },
				{ 12, 94742, "", "=q4=Frozen Warlord's Bracers", "=ds=#s8#, #a4#", tf=96022 },
				{ 13, 94747, "", "=q4=Bloodlord's Bloodsoaked Legplates", "=ds=#s11#, #a4#", tf=96023 },
				{ 16, 94754, "", "=q4=Horridon's Tusk Fragment", "=ds=#s2#", tf=96030 },
				{ 17, 94746, "", "=q4=Talisman of Living Poison", "=ds=#s2#", tf=96018 },
				{ 18, 95514, "", "=q4=Petrified Eye of the Basilisk", "=ds=#s13#", tf=96031 },
				{ 19, 94514, "", "=q4=Horridon's Last Gasp", "=ds=#s14#", tf=96013 },
				{ 20, 94526, "", "=q4=Spark of Zandalar", "=ds=#s14#", tf=96026 },
				{ 22, 94749, "", "=q4=Dinomancer's Spiritbinding Spire", "=ds=#w9#", tf=96029 },
				{ 23, 94740, "", "=q4=Jalak's Maelstrom Staff", "=ds=#w9#", tf=96019 },
				{ 24, 94755, "", "=q4=Venomlord's Totemic Wand", "=ds=#w12#", tf=96032 },
				{ 26, 93666, "", "=q4=Spawn of Horridon", "=ds=#e26#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 96397, "", "=q4=Horn-Rimmed Doomcloak", "=ds=#s4#", tf=96769 },
				{ 2, 96389, "", "=q4=Wastewalker's Sandblasted Drape", "=ds=#s4#", tf=96761 },
				{ 3, 96399, "", "=q4=Flamecaster's Burning Crown", "=ds=#s1#, #a1#", tf=96771 },
				{ 4, 96400, "", "=q4=Vaccinator's Armwraps", "=ds=#s8#, #a1#", tf=96772 },
				{ 5, 96406, "", "=q4=Spaulders of Dinomancy", "=ds=#s3#, #a2#", tf=96778 },
				{ 6, 96392, "", "=q4=Bindings of Multiplicative Strikes", "=ds=#s8#, #a2#", tf=96764 },
				{ 7, 96405, "", "=q4=Roots of Rampaging Earth", "=ds=#s11#, #a2#", tf=96777 },
				{ 8, 96393, "", "=q4=Sul'lithuz Sandmail", "=ds=#s5#, #a3#", tf=96765 },
				{ 9, 96407, "", "=q4=Legguards of Scintillating Scales", "=ds=#s11#, #a3#", tf=96779 },
				{ 10, 96396, "", "=q4=Puncture-Proof Greathelm", "=ds=#s1#, #a4#", tf=96768 },
				{ 11, 96408, "", "=q4=Armplates of the Vanquished Abomination", "=ds=#s8#, #a4#", tf=96780 },
				{ 12, 96394, "", "=q4=Frozen Warlord's Bracers", "=ds=#s8#, #a4#", tf=96766 },
				{ 13, 96395, "", "=q4=Bloodlord's Bloodsoaked Legplates", "=ds=#s11#, #a4#", tf=96767 },
				{ 16, 96402, "", "=q4=Horridon's Tusk Fragment", "=ds=#s2#", tf=96774 },
				{ 17, 96390, "", "=q4=Talisman of Living Poison", "=ds=#s2#", tf=96762 },
				{ 18, 96403, "", "=q4=Petrified Eye of the Basilisk", "=ds=#s13#", tf=96775 },
				{ 19, 96385, "", "=q4=Horridon's Last Gasp", "=ds=#s14#", tf=96757 },
				{ 20, 96398, "", "=q4=Spark of Zandalar", "=ds=#s14#", tf=96770 },
				{ 22, 96401, "", "=q4=Dinomancer's Spiritbinding Spire", "=ds=#w9#", tf=96773 },
				{ 23, 96391, "", "=q4=Jalak's Maelstrom Staff", "=ds=#w9#", tf=96763 },
				{ 24, 96404, "", "=q4=Venomlord's Totemic Wand", "=ds=#w12#", tf=96776 },
				{ 26, 93666, "", "=q4=Spawn of Horridon", "=ds=#e26#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Horridon", 819),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTCouncil"] = {
		["RaidFinder"] = {
			{
				{ 1, 95668, "", "=q4=Zandalari Robes of the Final Rite", "=ds=#s5#, #a1#" },
				{ 2, 95667, "", "=q4=Mar'li's Bloodstained Sandals", "=ds=#s12#, #a1#" },
				{ 3, 95671, "", "=q4=Robes of Treacherous Ground", "=ds=#s5#, #a2#" },
				{ 4, 95672, "", "=q4=Gaze of Gara'jal", "=ds=#s1#, #a3#" },
				{ 5, 95673, "", "=q4=Loa-Ridden Bracers", "=ds=#s8#, #a3#" },
				{ 6, 95674, "", "=q4=Overloaded Bladebreaker Cuirass", "=ds=#s5#, #a4#" },
				{ 8, 95676, "", "=q4=Talisman of Angry Spirits", "=ds=#s2#" },
				{ 9, 95665, "", "=q4=Bad Juju", "=ds=#s14#" },
				{ 10, 95677, "", "=q4=Fortitude of the Zandalari", "=ds=#s14#" },
				{ 11, 95669, "", "=q4=Wushoolay's Final Choice", "=ds=#s14#" },
				{ 16, 95856, "", "=q4=Gauntlets of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95857, "", "=q4=Gauntlets of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95855, "", "=q4=Gauntlets of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 95670, "", "=q4=Amun-Thoth, Sul's Spiritrending Talons", "=ds=#h1#, #w13#" },
				{ 21, 95666, "", "=q4=Kura-Kura, Kazra'jin's Skullcleaver", "=ds=#h1#, #w1#" },
				{ 22, 95675, "", "=q4=Zerat, Malakk's Soulburning Greatsword", "=ds=#h2#, #w10#" },
				{ 24, 94125, "", "=q3=Living Sandling", "=ds=#e13#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94761, "", "=q4=Zandalari Robes of the Final Rite", "=ds=#s5#, #a1#", tf=96040 },
				{ 2, 94762, "", "=q4=Mar'li's Bloodstained Sandals", "=ds=#s12#, #a1#", tf=96039 },
				{ 3, 94765, "", "=q4=Robes of Treacherous Ground", "=ds=#s5#, #a2#", tf=96043 },
				{ 4, 94763, "", "=q4=Gaze of Gara'jal", "=ds=#s1#, #a3#", tf=96044 },
				{ 5, 94767, "", "=q4=Loa-Ridden Bracers", "=ds=#s8#, #a3#", tf=96045 },
				{ 6, 94764, "", "=q4=Overloaded Bladebreaker Cuirass", "=ds=#s5#, #a4#", tf=96046 },
				{ 8, 94766, "", "=q4=Talisman of Angry Spirits", "=ds=#s2#", tf=96048 },
				{ 9, 94523, "", "=q4=Bad Juju", "=ds=#s14#", tf=96037 },
				{ 10, 94516, "", "=q4=Fortitude of the Zandalari", "=ds=#s14#", tf=96049 },
				{ 11, 94513, "", "=q4=Wushoolay's Final Choice", "=ds=#s14#", tf=96041 },
				{ 16, 95575, "", "=q4=Gauntlets of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95580, "", "=q4=Gauntlets of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95570, "", "=q4=Gauntlets of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 94760, "", "=q4=Amun-Thoth, Sul's Spiritrending Talons", "=ds=#h1#, #w13#", tf=96042 },
				{ 21, 94759, "", "=q4=Kura-Kura, Kazra'jin's Skullcleaver", "=ds=#h1#, #w1#", tf=96038 },
				{ 22, 94758, "", "=q4=Zerat, Malakk's Soulburning Greatsword", "=ds=#h2#, #w10#", tf=96047 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96412, "", "=q4=Zandalari Robes of the Final Rite", "=ds=#s5#, #a1#", tf=96784 },
				{ 2, 96411, "", "=q4=Mar'li's Bloodstained Sandals", "=ds=#s12#, #a1#", tf=96783 },
				{ 3, 96415, "", "=q4=Robes of Treacherous Ground", "=ds=#s5#, #a2#", tf=96787 },
				{ 4, 96416, "", "=q4=Gaze of Gara'jal", "=ds=#s1#, #a3#", tf=96788 },
				{ 5, 96417, "", "=q4=Loa-Ridden Bracers", "=ds=#s8#, #a3#", tf=96789 },
				{ 6, 96418, "", "=q4=Overloaded Bladebreaker Cuirass", "=ds=#s5#, #a4#", tf=96790 },
				{ 8, 96420, "", "=q4=Talisman of Angry Spirits", "=ds=#s2#", tf=96792 },
				{ 9, 96409, "", "=q4=Bad Juju", "=ds=#s14#", tf=96781 },
				{ 10, 96421, "", "=q4=Fortitude of the Zandalari", "=ds=#s14#", tf=96793 },
				{ 11, 96413, "", "=q4=Wushoolay's Final Choice", "=ds=#s14#", tf=96785 },
				{ 16, 96600, "", "=q4=Gauntlets of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 96601, "", "=q4=Gauntlets of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 96599, "", "=q4=Gauntlets of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 96414, "", "=q4=Amun-Thoth, Sul's Spiritrending Talons", "=ds=#h1#, #w13#", tf=96786 },
				{ 21, 96410, "", "=q4=Kura-Kura, Kazra'jin's Skullcleaver", "=ds=#h1#, #w1#", tf=96782 },
				{ 22, 96419, "", "=q4=Zerat, Malakk's Soulburning Greatsword", "=ds=#h2#, #w10#", tf=96791 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Council of Elders", 816),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTTortos"] = {
		["RaidFinder"] = {
			{
				{ 1, 95687, "", "=q4=Beakbreaker Greatcloak", "=ds=#s4#" },
				{ 2, 95691, "", "=q4=Shimmershell Cape", "=ds=#s4#" },
				{ 3, 95689, "", "=q4=Stonegaze Hood", "=ds=#s1#, #a1#" },
				{ 4, 95688, "", "=q4=Azure Shell Bracers", "=ds=#s8#, #a1#" },
				{ 5, 95690, "", "=q4=Crystal-Claw Gloves", "=ds=#s9#, #a1#" },
				{ 6, 95694, "", "=q4=Robes of Concussive Shocks", "=ds=#s5#, #a2#" },
				{ 7, 95679, "", "=q4=Rockfall Ribwraps", "=ds=#s5#, #a2#" },
				{ 8, 95693, "", "=q4=Vampire Bat-Hide Bracers", "=ds=#s8#, #a2#" },
				{ 9, 95680, "", "=q4=Grips of Vampiric Cruelty", "=ds=#s9#, #a2#" },
				{ 10, 95695, "", "=q4=Spaulders of Quaking Fear", "=ds=#s3#, #a3#" },
				{ 11, 95681, "", "=q4=Beady-Eye Bracers", "=ds=#s8#, #a3#" },
				{ 12, 95682, "", "=q4=Quakestompers", "=ds=#s12#, #a3#" },
				{ 13, 95683, "", "=q4=Shoulderguards of Centripetal Destruction", "=ds=#s3#, #a4#" },
				{ 14, 95684, "", "=q4=Shell-Coated Wristplates", "=ds=#s8#, #a4#" },
				{ 15, 95697, "", "=q4=Tortos' Shellseizers", "=ds=#s9#, #a4#" },
				{ 16, 95696, "", "=q4=Refreshing Abalone Girdle", "=ds=#s10#, #a4#" },
				{ 18, 95685, "", "=q4=Amulet of the Primal Turtle", "=ds=#s2#" },
				{ 20, 95686, "", "=q4=Shellsplitter Greataxe", "=ds=#h1#, #w1#" },
				{ 21, 95678, "", "=q4=Shattered Tortoiseshell Longbow", "=ds=#w2#" },
				{ 22, 95692, "", "=q4=Tortos' Discarded Shell", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94774, "", "=q4=Beakbreaker Greatcloak", "=ds=#s4#", tf=96059 },
				{ 2, 94785, "", "=q4=Shimmershell Cape", "=ds=#s4#", tf=96063 },
				{ 3, 94782, "", "=q4=Stonegaze Hood", "=ds=#s1#, #a1#", tf=96061 },
				{ 4, 94781, "", "=q4=Azure Shell Bracers", "=ds=#s8#, #a1#", tf=96060 },
				{ 5, 94780, "", "=q4=Crystal-Claw Gloves", "=ds=#s9#, #a1#", tf=96062 },
				{ 6, 94779, "", "=q4=Robes of Concussive Shocks", "=ds=#s5#, #a2#", tf=96066 },
				{ 7, 94770, "", "=q4=Rockfall Ribwraps", "=ds=#s5#, #a2#", tf=96051 },
				{ 8, 94786, "", "=q4=Vampire Bat-Hide Bracers", "=ds=#s8#, #a2#", tf=96065 },
				{ 9, 94777, "", "=q4=Grips of Vampiric Cruelty", "=ds=#s9#, #a2#", tf=96052 },
				{ 10, 94783, "", "=q4=Spaulders of Quaking Fear", "=ds=#s3#, #a3#", tf=96067 },
				{ 11, 94775, "", "=q4=Beady-Eye Bracers", "=ds=#s8#, #a3#", tf=96053 },
				{ 12, 94772, "", "=q4=Quakestompers", "=ds=#s12#, #a3#", tf=96054 },
				{ 13, 94773, "", "=q4=Shoulderguards of Centripetal Destruction", "=ds=#s3#, #a4#", tf=96055 },
				{ 14, 94771, "", "=q4=Shell-Coated Wristplates", "=ds=#s8#, #a4#", tf=96056 },
				{ 15, 94787, "", "=q4=Tortos' Shellseizers", "=ds=#s9#, #a4#", tf=96069 },
				{ 16, 94784, "", "=q4=Refreshing Abalone Girdle", "=ds=#s10#, #a4#", tf=96068 },
				{ 18, 94776, "", "=q4=Amulet of the Primal Turtle", "=ds=#s2#", tf=96057 },
				{ 20, 94768, "", "=q4=Shellsplitter Greataxe", "=ds=#h1#, #w1#", tf=96058 },
				{ 21, 94769, "", "=q4=Shattered Tortoiseshell Longbow", "=ds=#w2#", tf=96050 },
				{ 22, 94778, "", "=q4=Tortos' Discarded Shell", "=ds=#w8#", tf=96064 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96431, "", "=q4=Beakbreaker Greatcloak", "=ds=#s4#", tf=96803 },
				{ 2, 96435, "", "=q4=Shimmershell Cape", "=ds=#s4#", tf=96807 },
				{ 3, 96433, "", "=q4=Stonegaze Hood", "=ds=#s1#, #a1#", tf=96805 },
				{ 4, 96432, "", "=q4=Azure Shell Bracers", "=ds=#s8#, #a1#", tf=96804 },
				{ 5, 96434, "", "=q4=Crystal-Claw Gloves", "=ds=#s9#, #a1#", tf=96806 },
				{ 6, 96438, "", "=q4=Robes of Concussive Shocks", "=ds=#s5#, #a2#", tf=96810 },
				{ 7, 96423, "", "=q4=Rockfall Ribwraps", "=ds=#s5#, #a2#", tf=96795 },
				{ 8, 96437, "", "=q4=Vampire Bat-Hide Bracers", "=ds=#s8#, #a2#", tf=96809 },
				{ 9, 96424, "", "=q4=Grips of Vampiric Cruelty", "=ds=#s9#, #a2#", tf=96796 },
				{ 10, 96439, "", "=q4=Spaulders of Quaking Fear", "=ds=#s3#, #a3#", tf=96811 },
				{ 11, 96425, "", "=q4=Beady-Eye Bracers", "=ds=#s8#, #a3#", tf=96797 },
				{ 12, 96426, "", "=q4=Quakestompers", "=ds=#s12#, #a3#", tf=96798 },
				{ 13, 96427, "", "=q4=Shoulderguards of Centripetal Destruction", "=ds=#s3#, #a4#", tf=96799 },
				{ 14, 96428, "", "=q4=Shell-Coated Wristplates", "=ds=#s8#, #a4#", tf=96800 },
				{ 15, 96441, "", "=q4=Tortos' Shellseizers", "=ds=#s9#, #a4#", tf=96813 },
				{ 16, 96440, "", "=q4=Refreshing Abalone Girdle", "=ds=#s10#, #a4#", tf=96812 },
				{ 18, 96429, "", "=q4=Amulet of the Primal Turtle", "=ds=#s2#", tf=96801 },
				{ 20, 96430, "", "=q4=Shellsplitter Greataxe", "=ds=#h1#, #w1#", tf=96802 },
				{ 21, 96422, "", "=q4=Shattered Tortoiseshell Longbow", "=ds=#w2#", tf=96794 },
				{ 22, 96436, "", "=q4=Tortos' Discarded Shell", "=ds=#w8#", tf=96808 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Tortos", 825),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTMegaera"] = {
		["RaidFinder"] = {
			{
				{ 1, 95707, "", "=q4=Gleaming-Eye Shoulderpads", "=ds=#s3#, #a1#" },
				{ 2, 95708, "", "=q4=Frostborn Wristwraps", "=ds=#s8#, #a1#" },
				{ 3, 95706, "", "=q4=Sandals of Arcane Fury", "=ds=#s12#, #a1#" },
				{ 4, 95713, "", "=q4=Hood of Smoldering Flesh", "=ds=#s1#, #a2#" },
				{ 5, 95700, "", "=q4=Poisonblood Bladeshoulders", "=ds=#s3#, #a2#" },
				{ 6, 95715, "", "=q4=Chain of Consuming Magic", "=ds=#s5#, #a3#" },
				{ 7, 95701, "", "=q4=Grips of Cinderflesh", "=ds=#s9#, #a3#" },
				{ 8, 95714, "", "=q4=Links of the Bifurcated Tongue", "=ds=#s10#, #a3#" },
				{ 9, 95703, "", "=q4=Rot-Proof Greatplate", "=ds=#s5#, #a4#" },
				{ 10, 95702, "", "=q4=Plated Toothbreaker Girdle", "=ds=#s10#, #a4#" },
				{ 11, 95716, "", "=q4=Ice-Scored Treads", "=ds=#s12#, #a4#" },
				{ 16, 95705, "", "=q4=Hydraskull Choker", "=ds=#s2#" },
				{ 17, 95709, "", "=q4=Megaera's Shining Eye", "=ds=#s2#" },
				{ 18, 95699, "", "=q4=Quadra-Head Brooch", "=ds=#s2#" },
				{ 19, 95704, "", "=q4=Spinescale Seal", "=ds=#s13#" },
				{ 20, 95711, "", "=q4=Breath of the Hydra", "=ds=#s14#" },
				{ 21, 95712, "", "=q4=Inscribed Bag of Hydra-Spawn", "=ds=#s14#" },
				{ 23, 95698, "", "=q4=Megaera's Poisoned Fang", "=ds=#h1#, #w4#" },
				{ 24, 95710, "", "=q4=Fetish of the Hydra", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94801, "", "=q4=Gleaming-Eye Shoulderpads", "=ds=#s3#, #a1#", tf=96079 },
				{ 2, 94804, "", "=q4=Frostborn Wristwraps", "=ds=#s8#, #a1#", tf=96080 },
				{ 3, 94799, "", "=q4=Sandals of Arcane Fury", "=ds=#s12#, #a1#", tf=96078 },
				{ 4, 94800, "", "=q4=Hood of Smoldering Flesh", "=ds=#s1#, #a2#", tf=96085 },
				{ 5, 94791, "", "=q4=Poisonblood Bladeshoulders", "=ds=#s3#, #a2#", tf=96072 },
				{ 6, 94797, "", "=q4=Chain of Consuming Magic", "=ds=#s5#, #a3#", tf=96087 },
				{ 7, 94790, "", "=q4=Grips of Cinderflesh", "=ds=#s9#, #a3#", tf=96073 },
				{ 8, 94802, "", "=q4=Links of the Bifurcated Tongue", "=ds=#s10#, #a3#", tf=96086 },
				{ 9, 94789, "", "=q4=Rot-Proof Greatplate", "=ds=#s5#, #a4#", tf=96075 },
				{ 10, 94792, "", "=q4=Plated Toothbreaker Girdle", "=ds=#s10#, #a4#", tf=96074 },
				{ 11, 94798, "", "=q4=Ice-Scored Treads", "=ds=#s12#, #a4#", tf=96088 },
				{ 16, 94793, "", "=q4=Hydraskull Choker", "=ds=#s2#", tf=96077 },
				{ 17, 94803, "", "=q4=Megaera's Shining Eye", "=ds=#s2#", tf=96081 },
				{ 18, 94794, "", "=q4=Quadra-Head Brooch", "=ds=#s2#", tf=96071 },
				{ 19, 94795, "", "=q4=Spinescale Seal", "=ds=#s13#", tf=96076 },
				{ 20, 94521, "", "=q4=Breath of the Hydra", "=ds=#s14#", tf=96083 },
				{ 21, 94520, "", "=q4=Inscribed Bag of Hydra-Spawn", "=ds=#s14#", tf=96084 },
				{ 23, 94788, "", "=q4=Megaera's Poisoned Fang", "=ds=#h1#, #w4#", tf=96070 },
				{ 24, 94796, "", "=q4=Fetish of the Hydra", "=ds=#s15#", tf=96082 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96451, "", "=q4=Gleaming-Eye Shoulderpads", "=ds=#s3#, #a1#", tf=96823 },
				{ 2, 96452, "", "=q4=Frostborn Wristwraps", "=ds=#s8#, #a1#", tf=96824 },
				{ 3, 96450, "", "=q4=Sandals of Arcane Fury", "=ds=#s12#, #a1#", tf=96822 },
				{ 4, 96457, "", "=q4=Hood of Smoldering Flesh", "=ds=#s1#, #a2#", tf=96829 },
				{ 5, 96444, "", "=q4=Poisonblood Bladeshoulders", "=ds=#s3#, #a2#", tf=96816 },
				{ 6, 96459, "", "=q4=Chain of Consuming Magic", "=ds=#s5#, #a3#", tf=96831 },
				{ 7, 96445, "", "=q4=Grips of Cinderflesh", "=ds=#s9#, #a3#", tf=96817 },
				{ 8, 96458, "", "=q4=Links of the Bifurcated Tongue", "=ds=#s10#, #a3#", tf=96830 },
				{ 9, 96447, "", "=q4=Rot-Proof Greatplate", "=ds=#s5#, #a4#", tf=96819 },
				{ 10, 96446, "", "=q4=Plated Toothbreaker Girdle", "=ds=#s10#, #a4#", tf=96818 },
				{ 11, 96460, "", "=q4=Ice-Scored Treads", "=ds=#s12#, #a4#", tf=96832 },
				{ 16, 96449, "", "=q4=Hydraskull Choker", "=ds=#s2#", tf=96821 },
				{ 17, 96453, "", "=q4=Megaera's Shining Eye", "=ds=#s2#", tf=96825 },
				{ 18, 96443, "", "=q4=Quadra-Head Brooch", "=ds=#s2#", tf=96815 },
				{ 19, 96448, "", "=q4=Spinescale Seal", "=ds=#s13#", tf=96820 },
				{ 20, 96455, "", "=q4=Breath of the Hydra", "=ds=#s14#", tf=96827 },
				{ 21, 96456, "", "=q4=Inscribed Bag of Hydra-Spawn", "=ds=#s14#", tf=96828 },
				{ 23, 96442, "", "=q4=Megaera's Poisoned Fang", "=ds=#h1#, #w4#", tf=96814 },
				{ 24, 96454, "", "=q4=Fetish of the Hydra", "=ds=#s15#", tf=96826 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Megaera", 821),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTJiKun"] = {
		["RaidFinder"] = {
			{
				{ 1, 95717, "", "=q4=Pinionfeather Greatcloak", "=ds=#s4#" },
				{ 2, 95719, "", "=q4=Robe of Midnight Down", "=ds=#s5#, #a1#" },
				{ 3, 95718, "", "=q4=Cord of Cacophonous Cawing", "=ds=#s10#, #a1#" },
				{ 4, 95721, "", "=q4=Featherflight Belt", "=ds=#s10#, #a2#" },
				{ 5, 95722, "", "=q4=Grasp of the Ruthless Mother", "=ds=#s9#, #a3#" },
				{ 6, 95723, "", "=q4=Crown of Potentiated Birth", "=ds=#s1#, #a4#" },
				{ 7, 95724, "", "=q4=Talonrender Chestplate", "=ds=#s5#, #a4#" },
				{ 8, 95725, "", "=q4=Egg-Shard Grips", "=ds=#s9#, #a4#" },
				{ 10, 94835, "", "=q3=Ji-Kun Hatchling", "=ds=#e13#", ""};
				{ 16, 95888, "", "=q4=Leggings of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95889, "", "=q4=Leggings of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95887, "", "=q4=Leggings of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 95726, "", "=q4=Fabled Feather of Ji-Kun", "=ds=#s14#" },
				{ 21, 95727, "", "=q4=Ji-Kun's Rising Winds", "=ds=#s14#" },
				{ 23, 95720, "", "=q4=Giorgio's Caduceus of Pure Moods", "=ds=#w9#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94812, "", "=q4=Pinionfeather Greatcloak", "=ds=#s4#", tf=96089 },
				{ 2, 94806, "", "=q4=Robe of Midnight Down", "=ds=#s5#, #a1#", tf=96091 },
				{ 3, 94813, "", "=q4=Cord of Cacophonous Cawing", "=ds=#s10#, #a1#", tf=96090 },
				{ 4, 94811, "", "=q4=Featherflight Belt", "=ds=#s10#, #a2#", tf=96093 },
				{ 5, 94808, "", "=q4=Grasp of the Ruthless Mother", "=ds=#s9#, #a3#", tf=96094 },
				{ 6, 94809, "", "=q4=Crown of Potentiated Birth", "=ds=#s1#, #a4#", tf=96095 },
				{ 7, 94810, "", "=q4=Talonrender Chestplate", "=ds=#s5#, #a4#", tf=96096 },
				{ 8, 94807, "", "=q4=Egg-Shard Grips", "=ds=#s9#, #a4#", tf=96097 },
				{ 10, 95059, "", "=q4=Clutch of Ji-Kun", "=ds=#e27#", ""};
				{ 11, 94835, "", "=q3=Ji-Kun Hatchling", "=ds=#e13#", ""};
				{ 16, 95576, "", "=q4=Leggings of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95581, "", "=q4=Leggings of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95572, "", "=q4=Leggings of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 94515, "", "=q4=Fabled Feather of Ji-Kun", "=ds=#s14#", tf=96098 },
				{ 21, 94527, "", "=q4=Ji-Kun's Rising Winds", "=ds=#s14#", tf=96099 },
				{ 23, 94805, "", "=q4=Giorgio's Caduceus of Pure Moods", "=ds=#w9#", tf=96092 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96461, "", "=q4=Pinionfeather Greatcloak", "=ds=#s4#", tf=96833 },
				{ 2, 96463, "", "=q4=Robe of Midnight Down", "=ds=#s5#, #a1#", tf=96835 },
				{ 3, 96462, "", "=q4=Cord of Cacophonous Cawing", "=ds=#s10#, #a1#", tf=96834 },
				{ 4, 96465, "", "=q4=Featherflight Belt", "=ds=#s10#, #a2#", tf=96837 },
				{ 5, 96466, "", "=q4=Grasp of the Ruthless Mother", "=ds=#s9#, #a3#", tf=96838 },
				{ 6, 96467, "", "=q4=Crown of Potentiated Birth", "=ds=#s1#, #a4#", tf=96839 },
				{ 7, 96468, "", "=q4=Talonrender Chestplate", "=ds=#s5#, #a4#", tf=96840 },
				{ 8, 96469, "", "=q4=Egg-Shard Grips", "=ds=#s9#, #a4#", tf=96841 },
				{ 10, 95059, "", "=q4=Clutch of Ji-Kun", "=ds=#e27#", ""};
				{ 11, 94835, "", "=q3=Ji-Kun Hatchling", "=ds=#e13#", ""};
				{ 16, 96632, "", "=q4=Leggings of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 96633, "", "=q4=Leggings of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 96631, "", "=q4=Leggings of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 96470, "", "=q4=Fabled Feather of Ji-Kun", "=ds=#s14#", tf=96842 },
				{ 21, 96471, "", "=q4=Ji-Kun's Rising Winds", "=ds=#s14#", tf=96843 },
				{ 23, 96464, "", "=q4=Giorgio's Caduceus of Pure Moods", "=ds=#w9#", tf=96836 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ji-Kun", 828),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTDurumu"] = {
		["RaidFinder"] = {
			{
				{ 1, 95741, "", "=q4=Deadly Glare Cape", "=ds=#s4#" },
				{ 2, 95736, "", "=q4=Reinforced Mirror-Sheen Cloak", "=ds=#s4#" },
				{ 3, 95740, "", "=q4=Chilblain Spaulders", "=ds=#s3#, #a1#" },
				{ 4, 95738, "", "=q4=Lifedrainer's Sordid Grip", "=ds=#s9#, #a1#" },
				{ 5, 95739, "", "=q4=Leggings of Pulsing Blood", "=ds=#s11#, #a1#" },
				{ 6, 95729, "", "=q4=Crimson Bloom Legguards", "=ds=#s11#, #a2#" },
				{ 7, 95744, "", "=q4=Sandals of the Starving Eye", "=ds=#s12#, #a2#" },
				{ 8, 95731, "", "=q4=Aberrant Chestguard of Torment", "=ds=#s5#, #a3#" },
				{ 9, 95745, "", "=q4=Vein-Cover Bracers", "=ds=#s8#, #a3#" },
				{ 10, 95730, "", "=q4=Links of the Disintegrator", "=ds=#s10#, #a3#" },
				{ 11, 95732, "", "=q4=Caustic Spike Bracers", "=ds=#s8#, #a4#" },
				{ 12, 95735, "", "=q4=Artery Rippers", "=ds=#s9#, #a4#" },
				{ 13, 95746, "", "=q4=Iceshatter Gauntlets", "=ds=#s9#, #a4#" },
				{ 14, 95747, "", "=q4=Legplates of Re-Emergence", "=ds=#s11#, #a4#" },
				{ 15, 95733, "", "=q4=Legplates of the Dark Parasite", "=ds=#s11#, #a4#" },
				{ 16, 95734, "", "=q4=Treads of the Blind Eye", "=ds=#s12#, #a4#" },
				{ 18, 95742, "", "=q4=Durumu's Captive Eyeball", "=ds=#s13#" },
				{ 19, 95737, "", "=q4=Durumu's Severed Tentacle", "=ds=#s13#" },
				{ 21, 95743, "", "=q4=Ritual Dagger of the Mind's Eye", "=ds=#h1#, #w4#" },
				{ 22, 95728, "", "=q4=Durumu's Baleful Gaze", "=ds=#w3#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94929, "", "=q4=Deadly Glare Cape", "=ds=#s4#", tf=96113 },
				{ 2, 94822, "", "=q4=Reinforced Mirror-Sheen Cloak", "=ds=#s4#", tf=96108 },
				{ 3, 94928, "", "=q4=Chilblain Spaulders", "=ds=#s3#, #a1#", tf=96112 },
				{ 4, 94925, "", "=q4=Lifedrainer's Sordid Grip", "=ds=#s9#, #a1#", tf=96110 },
				{ 5, 94923, "", "=q4=Leggings of Pulsing Blood", "=ds=#s11#, #a1#", tf=96111 },
				{ 6, 94816, "", "=q4=Crimson Bloom Legguards", "=ds=#s11#, #a2#", tf=96101 },
				{ 7, 94927, "", "=q4=Sandals of the Starving Eye", "=ds=#s12#, #a2#", tf=96116 },
				{ 8, 94818, "", "=q4=Aberrant Chestguard of Torment", "=ds=#s5#, #a3#", tf=96103 },
				{ 9, 94926, "", "=q4=Vein-Cover Bracers", "=ds=#s8#, #a3#", tf=96117 },
				{ 10, 94819, "", "=q4=Links of the Disintegrator", "=ds=#s10#, #a3#", tf=96102 },
				{ 11, 94820, "", "=q4=Caustic Spike Bracers", "=ds=#s8#, #a4#", tf=96104 },
				{ 12, 94821, "", "=q4=Artery Rippers", "=ds=#s9#, #a4#", tf=96107 },
				{ 13, 94924, "", "=q4=Iceshatter Gauntlets", "=ds=#s9#, #a4#", tf=96118 },
				{ 14, 94930, "", "=q4=Legplates of Re-Emergence", "=ds=#s11#, #a4#", tf=96119 },
				{ 15, 94815, "", "=q4=Legplates of the Dark Parasite", "=ds=#s11#, #a4#", tf=96105 },
				{ 16, 94817, "", "=q4=Treads of the Blind Eye", "=ds=#s12#, #a4#", tf=96106 },
				{ 18, 94931, "", "=q4=Durumu's Captive Eyeball", "=ds=#s13#", tf=96114 },
				{ 19, 95511, "", "=q4=Durumu's Severed Tentacle", "=ds=#s13#", tf=96109 },
				{ 21, 94922, "", "=q4=Ritual Dagger of the Mind's Eye", "=ds=#h1#, #w4#", tf=96115 },
				{ 22, 94814, "", "=q4=Durumu's Baleful Gaze", "=ds=#w3#", tf=96100 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96485, "", "=q4=Deadly Glare Cape", "=ds=#s4#", tf=96857 },
				{ 2, 96480, "", "=q4=Reinforced Mirror-Sheen Cloak", "=ds=#s4#", tf=96852 },
				{ 3, 96484, "", "=q4=Chilblain Spaulders", "=ds=#s3#, #a1#", tf=96856 },
				{ 4, 96482, "", "=q4=Lifedrainer's Sordid Grip", "=ds=#s9#, #a1#", tf=96854 },
				{ 5, 96483, "", "=q4=Leggings of Pulsing Blood", "=ds=#s11#, #a1#", tf=96855 },
				{ 6, 96473, "", "=q4=Crimson Bloom Legguards", "=ds=#s11#, #a2#", tf=96845 },
				{ 7, 96488, "", "=q4=Sandals of the Starving Eye", "=ds=#s12#, #a2#", tf=96860 },
				{ 8, 96475, "", "=q4=Aberrant Chestguard of Torment", "=ds=#s5#, #a3#", tf=96847 },
				{ 9, 96489, "", "=q4=Vein-Cover Bracers", "=ds=#s8#, #a3#", tf=96861 },
				{ 10, 96474, "", "=q4=Links of the Disintegrator", "=ds=#s10#, #a3#", tf=96846 },
				{ 11, 96476, "", "=q4=Caustic Spike Bracers", "=ds=#s8#, #a4#", tf=96848 },
				{ 12, 96479, "", "=q4=Artery Rippers", "=ds=#s9#, #a4#", tf=96851 },
				{ 13, 96490, "", "=q4=Iceshatter Gauntlets", "=ds=#s9#, #a4#", tf=96862 },
				{ 14, 96491, "", "=q4=Legplates of Re-Emergence", "=ds=#s11#, #a4#", tf=96863 },
				{ 15, 96477, "", "=q4=Legplates of the Dark Parasite", "=ds=#s11#, #a4#", tf=96849 },
				{ 16, 96478, "", "=q4=Treads of the Blind Eye", "=ds=#s12#, #a4#", tf=96850 },
				{ 18, 96486, "", "=q4=Durumu's Captive Eyeball", "=ds=#s13#", tf=96858 },
				{ 19, 96481, "", "=q4=Durumu's Severed Tentacle", "=ds=#s13#", tf=96853 },
				{ 21, 96487, "", "=q4=Ritual Dagger of the Mind's Eye", "=ds=#h1#, #w4#", tf=96859 },
				{ 22, 96472, "", "=q4=Durumu's Baleful Gaze", "=ds=#w3#", tf=96844 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Durumu the Forgotten", 818),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTPrimordius"] = {
		["RaidFinder"] = {
			{
				{ 1, 95755, "", "=q4=Hydra-Scale Bloodcloak", "=ds=#s4#" },
				{ 2, 95759, "", "=q4=Robes of Mutagenic Blood", "=ds=#s5#, #a1#" },
				{ 3, 95762, "", "=q4=Bracers of Fragile Bone", "=ds=#s8#, #a1#" },
				{ 4, 95760, "", "=q4=Helix-Breaker Gloves", "=ds=#s9#, #a1#" },
				{ 5, 95761, "", "=q4=Leggings of Ebon Veins", "=ds=#s11#, #a1#" },
				{ 6, 95749, "", "=q4=Gloves of Cushioned Air", "=ds=#s9#, #a2#" },
				{ 7, 95764, "", "=q4=Leggings of the Malformed Sapling", "=ds=#s11#, #a2#" },
				{ 8, 95765, "", "=q4=Clear-Mind Helm", "=ds=#s1#, #a3#" },
				{ 9, 95750, "", "=q4=Bracers of Mutagenic Fervor", "=ds=#s8#, #a3#" },
				{ 10, 95751, "", "=q4=Synapse-String Handguards", "=ds=#s9#, #a3#" },
				{ 11, 95754, "", "=q4=Metabolically Boosted Shoulderplates", "=ds=#s3#, #a4#" },
				{ 12, 95767, "", "=q4=Spaulders of Primordial Growth", "=ds=#s3#, #a4#" },
				{ 13, 95766, "", "=q4=Bonemender Bracers", "=ds=#s8#, #a4#" },
				{ 14, 95752, "", "=q4=Pathogenic Gauntlets", "=ds=#s9#, #a4#" },
				{ 15, 95753, "", "=q4=Black Blood Legplates", "=ds=#s11#, #a4#" },
				{ 16, 95756, "", "=q4=Band of the Scaled Tyrant", "=ds=#s13#" },
				{ 17, 95757, "", "=q4=Primordius' Talisman of Rage", "=ds=#s14#" },
				{ 18, 95763, "", "=q4=Stolen Relic of Zuldazar", "=ds=#s14#" },
				{ 19, 95748, "", "=q4=Talisman of Bloodlust", "=ds=#s14#" },
				{ 21, 95758, "", "=q4=Acid-Spine Bonemace", "=ds=#h1#, #w6#" },
				{ 22, 95768, "", "=q4=Greatshield of the Gloaming", "=ds=#w8#" },
				{ 24, 97959, "", "=q3=Quivering Blob", "=ds=#e13#", ""};
			};
		};
		["Normal"] = {
			{
				{ 1, 94942, "", "=q4=Hydra-Scale Bloodcloak", "=ds=#s4#", tf=96127 },
				{ 2, 94951, "", "=q4=Robes of Mutagenic Blood", "=ds=#s5#, #a1#", tf=96131 },
				{ 3, 94948, "", "=q4=Bracers of Fragile Bone", "=ds=#s8#, #a1#", tf=96134 },
				{ 4, 94947, "", "=q4=Helix-Breaker Gloves", "=ds=#s9#, #a1#", tf=96132 },
				{ 5, 94953, "", "=q4=Leggings of Ebon Veins", "=ds=#s11#, #a1#", tf=96133 },
				{ 6, 94939, "", "=q4=Gloves of Cushioned Air", "=ds=#s9#, #a2#", tf=96121 },
				{ 7, 94946, "", "=q4=Leggings of the Malformed Sapling", "=ds=#s11#, #a2#", tf=96136 },
				{ 8, 94949, "", "=q4=Clear-Mind Helm", "=ds=#s1#, #a3#", tf=96137 },
				{ 9, 94940, "", "=q4=Bracers of Mutagenic Fervor", "=ds=#s8#, #a3#", tf=96122 },
				{ 10, 94943, "", "=q4=Synapse-String Handguards", "=ds=#s9#, #a3#", tf=96123 },
				{ 11, 94941, "", "=q4=Metabolically Boosted Shoulderplates", "=ds=#s3#, #a4#", tf=96126 },
				{ 12, 94950, "", "=q4=Spaulders of Primordial Growth", "=ds=#s3#, #a4#", tf=96139 },
				{ 13, 94952, "", "=q4=Bonemender Bracers", "=ds=#s8#, #a4#", tf=96138 },
				{ 14, 94938, "", "=q4=Pathogenic Gauntlets", "=ds=#s9#, #a4#", tf=96124 },
				{ 15, 94944, "", "=q4=Black Blood Legplates", "=ds=#s11#, #a4#", tf=96125 },
				{ 16, 95513, "", "=q4=Band of the Scaled Tyrant", "=ds=#s13#", tf=96128 },
				{ 17, 94519, "", "=q4=Primordius' Talisman of Rage", "=ds=#s14#", tf=96129 },
				{ 18, 94525, "", "=q4=Stolen Relic of Zuldazar", "=ds=#s14#", tf=96135 },
				{ 19, 94522, "", "=q4=Talisman of Bloodlust", "=ds=#s14#", tf=96120 },
				{ 21, 94937, "", "=q4=Acid-Spine Bonemace", "=ds=#h1#, #w6#", tf=96130 },
				{ 22, 94945, "", "=q4=Greatshield of the Gloaming", "=ds=#w8#", tf=96140 },
				{ 24, 97959, "", "=q3=Quivering Blob", "=ds=#e13#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 96499, "", "=q4=Hydra-Scale Bloodcloak", "=ds=#s4#", tf=96871 },
				{ 2, 96503, "", "=q4=Robes of Mutagenic Blood", "=ds=#s5#, #a1#", tf=96875 },
				{ 3, 96506, "", "=q4=Bracers of Fragile Bone", "=ds=#s8#, #a1#", tf=96878 },
				{ 4, 96504, "", "=q4=Helix-Breaker Gloves", "=ds=#s9#, #a1#", tf=96876 },
				{ 5, 96505, "", "=q4=Leggings of Ebon Veins", "=ds=#s11#, #a1#", tf=96877 },
				{ 6, 96493, "", "=q4=Gloves of Cushioned Air", "=ds=#s9#, #a2#", tf=96865 },
				{ 7, 96508, "", "=q4=Leggings of the Malformed Sapling", "=ds=#s11#, #a2#", tf=96880 },
				{ 8, 96509, "", "=q4=Clear-Mind Helm", "=ds=#s1#, #a3#", tf=96881 },
				{ 9, 96494, "", "=q4=Bracers of Mutagenic Fervor", "=ds=#s8#, #a3#", tf=96866 },
				{ 10, 96495, "", "=q4=Synapse-String Handguards", "=ds=#s9#, #a3#", tf=96867 },
				{ 11, 96498, "", "=q4=Metabolically Boosted Shoulderplates", "=ds=#s3#, #a4#", tf=96870 },
				{ 12, 96511, "", "=q4=Spaulders of Primordial Growth", "=ds=#s3#, #a4#", tf=96883 },
				{ 13, 96510, "", "=q4=Bonemender Bracers", "=ds=#s8#, #a4#", tf=96882 },
				{ 14, 96496, "", "=q4=Pathogenic Gauntlets", "=ds=#s9#, #a4#", tf=96868 },
				{ 15, 96497, "", "=q4=Black Blood Legplates", "=ds=#s11#, #a4#", tf=96869 },
				{ 16, 96500, "", "=q4=Band of the Scaled Tyrant", "=ds=#s13#", tf=96872 },
				{ 17, 96501, "", "=q4=Primordius' Talisman of Rage", "=ds=#s14#", tf=96873 },
				{ 18, 96507, "", "=q4=Stolen Relic of Zuldazar", "=ds=#s14#", tf=96879 },
				{ 19, 96492, "", "=q4=Talisman of Bloodlust", "=ds=#s14#", tf=96864 },
				{ 21, 96502, "", "=q4=Acid-Spine Bonemace", "=ds=#h1#, #w6#", tf=96874 },
				{ 22, 96512, "", "=q4=Greatshield of the Gloaming", "=ds=#w8#", tf=96884 },
				{ 24, 97960, "", "=q3=Dark Quivering Blob", "=ds=#e13#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Primordius", 820),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTDarkAnimus"] = {
		["RaidFinder"] = {
			{
				{ 1, 95773, "", "=q4=Constantly Accelerating Cloak", "=ds=#s4#" },
				{ 2, 95771, "", "=q4=Hood of the Crimson Wake", "=ds=#s1#, #a1#" },
				{ 3, 95776, "", "=q4=Anima-Ringed Fingers", "=ds=#s9#, #a2#" },
				{ 4, 95775, "", "=q4=Worldbinder Leggings", "=ds=#s11#, #a2#" },
				{ 5, 95778, "", "=q4=Crown of the Golden Golem", "=ds=#s1#, #a4#" },
				{ 6, 95777, "", "=q4=Matter-Swapped Legplates", "=ds=#s11#, #a4#" },
				{ 8, 95769, "", "=q4=Gore-Soaked Gear", "=ds=#s13#" },
				{ 9, 95772, "", "=q4=Cha-Ye's Essence of Brilliance", "=ds=#s14#" },
				{ 10, 95779, "", "=q4=Delicate Vial of the Sanguinaire", "=ds=#s14#" },
				{ 16, 95823, "", "=q4=Chest of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95824, "", "=q4=Chest of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95822, "", "=q4=Chest of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 95774, "", "=q4=Athame of the Sanguine Ritual", "=ds=#h1#, #w4#" },
				{ 21, 95770, "", "=q4=Hand of the Dark Animus", "=ds=#h1#, #w6#" },
				{ 23, 94152, "", "=q3=Son of Animus", "=ds=#e13#", ""};
			};
		};
		["Normal"] = {
			{
				{ 1, 94960, "", "=q4=Constantly Accelerating Cloak", "=ds=#s4#", tf=96145 },
				{ 2, 94959, "", "=q4=Hood of the Crimson Wake", "=ds=#s1#, #a1#", tf=96143 },
				{ 3, 94957, "", "=q4=Anima-Ringed Fingers", "=ds=#s9#, #a2#", tf=96148 },
				{ 4, 94962, "", "=q4=Worldbinder Leggings", "=ds=#s11#, #a2#", tf=96147 },
				{ 5, 94958, "", "=q4=Crown of the Golden Golem", "=ds=#s1#, #a4#", tf=96150 },
				{ 6, 94956, "", "=q4=Matter-Swapped Legplates", "=ds=#s11#, #a4#", tf=96149 },
				{ 8, 94961, "", "=q4=Gore-Soaked Gear", "=ds=#s13#", tf=96141 },
				{ 9, 94531, "", "=q4=Cha-Ye's Essence of Brilliance", "=ds=#s14#", tf=96144 },
				{ 10, 94518, "", "=q4=Delicate Vial of the Sanguinaire", "=ds=#s14#", tf=96151 },
				{ 16, 95574, "", "=q4=Chest of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95579, "", "=q4=Chest of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95569, "", "=q4=Chest of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 94955, "", "=q4=Athame of the Sanguine Ritual", "=ds=#h1#, #w4#", tf=96146 },
				{ 21, 94954, "", "=q4=Hand of the Dark Animus", "=ds=#h1#, #w6#", tf=96142 },
				{ 23, 94152, "", "=q3=Son of Animus", "=ds=#e13#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 96517, "", "=q4=Constantly Accelerating Cloak", "=ds=#s4#", tf=96889 },
				{ 2, 96515, "", "=q4=Hood of the Crimson Wake", "=ds=#s1#, #a1#", tf=96887 },
				{ 3, 96520, "", "=q4=Anima-Ringed Fingers", "=ds=#s9#, #a2#", tf=96892 },
				{ 4, 96519, "", "=q4=Worldbinder Leggings", "=ds=#s11#, #a2#", tf=96891 },
				{ 5, 96522, "", "=q4=Crown of the Golden Golem", "=ds=#s1#, #a4#", tf=96894 },
				{ 6, 96521, "", "=q4=Matter-Swapped Legplates", "=ds=#s11#, #a4#", tf=96893 },
				{ 8, 96513, "", "=q4=Gore-Soaked Gear", "=ds=#s13#", tf=96885 },
				{ 9, 96516, "", "=q4=Cha-Ye's Essence of Brilliance", "=ds=#s14#", tf=96888 },
				{ 10, 96523, "", "=q4=Delicate Vial of the Sanguinaire", "=ds=#s14#", tf=96895 },
				{ 16, 96567, "", "=q4=Chest of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 96568, "", "=q4=Chest of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 96566, "", "=q4=Chest of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 96518, "", "=q4=Athame of the Sanguine Ritual", "=ds=#h1#, #w4#", tf=96890 },
				{ 21, 96514, "", "=q4=Hand of the Dark Animus", "=ds=#h1#, #w6#", tf=96886 },
				{ 23, 94152, "", "=q3=Son of Animus", "=ds=#e13#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Dark Animus", 824),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTIronQon"] = {
		["RaidFinder"] = {
			{
				{ 1, 95782, "", "=q4=Quet'zal's Crackling Cord", "=ds=#s10#, #a1#" },
				{ 2, 95783, "", "=q4=Saddle-Scarred Leggings", "=ds=#s11#, #a1#" },
				{ 3, 95784, "", "=q4=Dam'ren's Frozen Footguards", "=ds=#s12#, #a1#" },
				{ 4, 95787, "", "=q4=Spurs of the Storm Cavalry", "=ds=#s12#, #a2#" },
				{ 5, 95788, "", "=q4=Ro'shak's Molten Chain", "=ds=#s5#, #a3#" },
				{ 6, 95789, "", "=q4=Rein-Binder's Fists", "=ds=#s9#, #a4#" },
				{ 8, 95785, "", "=q4=Ro'shak's Remembrance", "=ds=#s13#" },
				{ 16, 95956, "", "=q4=Shoulders of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95957, "", "=q4=Shoulders of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95955, "", "=q4=Shoulders of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 95780, "", "=q4=Iron Qon's Boot Knife", "=ds=#h1#, #w4#" },
				{ 21, 95790, "", "=q4=Qon's Flaming Scimitar", "=ds=#h1#, #w10#" },
				{ 22, 95781, "", "=q4=Voice of the Quilen", "=ds=#w5#" },
				{ 23, 95786, "", "=q4=Orb of Arcing Lightning", "=ds=#s15#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94970, "", "=q4=Quet'zal's Crackling Cord", "=ds=#s10#, #a1#", tf=96154 },
				{ 2, 94966, "", "=q4=Saddle-Scarred Leggings", "=ds=#s11#, #a1#", tf=96155 },
				{ 3, 94968, "", "=q4=Dam'ren's Frozen Footguards", "=ds=#s12#, #a1#", tf=96156 },
				{ 4, 94967, "", "=q4=Spurs of the Storm Cavalry", "=ds=#s12#, #a2#", tf=96159 },
				{ 5, 94969, "", "=q4=Ro'shak's Molten Chain", "=ds=#s5#, #a3#", tf=96160},
				{ 6, 94972, "", "=q4=Rein-Binder's Fists", "=ds=#s9#, #a4#", tf=96161 },
				{ 8, 95512, "", "=q4=Ro'shak's Remembrance", "=ds=#s13#", tf=96157 },
				{ 16, 95578, "", "=q4=Shoulders of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95583, "", "=q4=Shoulders of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95573, "", "=q4=Shoulders of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 94971, "", "=q4=Iron Qon's Boot Knife", "=ds=#h1#, #w4#", tf=96152 },
				{ 21, 94964, "", "=q4=Qon's Flaming Scimitar", "=ds=#h1#, #w10#", tf=96162 },
				{ 22, 94963, "", "=q4=Voice of the Quilen", "=ds=#w5#", tf=96153 },
				{ 23, 94965, "", "=q4=Orb of Arcing Lightning", "=ds=#s15#", tf=96158 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96526, "", "=q4=Quet'zal's Crackling Cord", "=ds=#s10#, #a1#", tf=96898 },
				{ 2, 96527, "", "=q4=Saddle-Scarred Leggings", "=ds=#s11#, #a1#", tf=96899 },
				{ 3, 96528, "", "=q4=Dam'ren's Frozen Footguards", "=ds=#s12#, #a1#", tf=96900 },
				{ 4, 96531, "", "=q4=Spurs of the Storm Cavalry", "=ds=#s12#, #a2#", tf=96903 },
				{ 5, 96532, "", "=q4=Ro'shak's Molten Chain", "=ds=#s5#, #a3#", tf=96904 },
				{ 6, 96533, "", "=q4=Rein-Binder's Fists", "=ds=#s9#, #a4#", tf=96905 },
				{ 8, 96529, "", "=q4=Ro'shak's Remembrance", "=ds=#s13#", tf=96901 },
				{ 16, 96700, "", "=q4=Shoulders of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 96701, "", "=q4=Shoulders of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 96699, "", "=q4=Shoulders of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 96524, "", "=q4=Iron Qon's Boot Knife", "=ds=#h1#, #w4#", tf=96896 },
				{ 21, 96534, "", "=q4=Qon's Flaming Scimitar", "=ds=#h1#, #w10#", tf=96906 },
				{ 22, 96525, "", "=q4=Voice of the Quilen", "=ds=#w5#", tf=96897 },
				{ 23, 96530, "", "=q4=Orb of Arcing Lightning", "=ds=#s15#", tf=96902 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Iron Qon", 817),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTTwinConsorts"] = {
		["RaidFinder"] = {
			{
				{ 1, 95792, "", "=q4=Robes of the Moon Lotus", "=ds=#s5#, #a1#" },
				{ 2, 95796, "", "=q4=Bracers of the Midnight Comet", "=ds=#s8#, #a2#" },
				{ 3, 95797, "", "=q4=Girdle of Night and Day", "=ds=#s10#, #a2#" },
				{ 4, 95801, "", "=q4=Fingers of the Night", "=ds=#s9#, #a3#" },
				{ 5, 95798, "", "=q4=Tidal Force Treads", "=ds=#s12#, #a4#" },
				{ 7, 95800, "", "=q4=Moonjade Necklace", "=ds=#s2#" },
				{ 8, 95793, "", "=q4=Passionfire Choker", "=ds=#s2#" },
				{ 9, 95799, "", "=q4=Gaze of the Twins", "=ds=#s14#" },
				{ 16, 95880, "", "=q4=Helm of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95881, "", "=q4=Helm of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95879, "", "=q4=Helm of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 95795, "", "=q4=Suen-Wo, Spire of the Falling Sun", "=ds=#w9#" },
				{ 21, 95791, "", "=q4=Wu-Lai, Bladed Fan of the Consorts", "=ds=#h1#, #w13#" },
				{ 22, 95794, "", "=q4=Shield of Twinned Despair", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 94977, "", "=q4=Robes of the Moon Lotus", "=ds=#s5#, #a1#", tf=96164 },
				{ 2, 94979, "", "=q4=Bracers of the Midnight Comet", "=ds=#s8#, #a2#", tf=96168 },
				{ 3, 94978, "", "=q4=Girdle of Night and Day", "=ds=#s10#, #a2#", tf=96169 },
				{ 4, 94757, "", "=q4=Fingers of the Night", "=ds=#s9#, #a3#", tf=96173 },
				{ 5, 94976, "", "=q4=Tidal Force Treads", "=ds=#s12#, #a4#", tf=96170 },
				{ 7, 94981, "", "=q4=Moonjade Necklace", "=ds=#s2#", tf=96172 },
				{ 8, 94980, "", "=q4=Passionfire Choker", "=ds=#s2#", tf=96165 },
				{ 9, 94529, "", "=q4=Gaze of the Twins", "=ds=#s14#", tf=96171 },
				{ 16, 95577, "", "=q4=Helm of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 95582, "", "=q4=Helm of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 95571, "", "=q4=Helm of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 94974, "", "=q4=Suen-Wo, Spire of the Falling Sun", "=ds=#w9#", tf=96167 },
				{ 21, 94973, "", "=q4=Wu-Lai, Bladed Fan of the Consorts", "=ds=#h1#, #w13#", tf=96163 },
				{ 22, 95515, "", "=q4=Shield of Twinned Despair", "=ds=#w8#", tf=96166 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96536, "", "=q4=Robes of the Moon Lotus", "=ds=#s5#, #a1#", tf=96908 },
				{ 2, 96540, "", "=q4=Bracers of the Midnight Comet", "=ds=#s8#, #a2#", tf=96912 },
				{ 3, 96541, "", "=q4=Girdle of Night and Day", "=ds=#s10#, #a2#", tf=96913 },
				{ 4, 96545, "", "=q4=Fingers of the Night", "=ds=#s9#, #a3#", tf=96917 },
				{ 5, 96542, "", "=q4=Tidal Force Treads", "=ds=#s12#, #a4#", tf=96914 },
				{ 7, 96544, "", "=q4=Moonjade Necklace", "=ds=#s2#", tf=96916 },
				{ 8, 96537, "", "=q4=Passionfire Choker", "=ds=#s2#", tf=96909 },
				{ 9, 96543, "", "=q4=Gaze of the Twins", "=ds=#s14#", tf=96915 },
				{ 16, 96624, "", "=q4=Helm of the Crackling Conqueror", "=ds=#e15#, #m41#" },
				{ 17, 96625, "", "=q4=Helm of the Crackling Protector", "=ds=#e15#, #m41#" },
				{ 18, 96623, "", "=q4=Helm of the Crackling Vanquisher", "=ds=#e15#, #m41#" },
				{ 20, 96539, "", "=q4=Suen-Wo, Spire of the Falling Sun", "=ds=#w9#", tf=96911 },
				{ 21, 96535, "", "=q4=Wu-Lai, Bladed Fan of the Consorts", "=ds=#h1#, #w13#", tf=96907 },
				{ 22, 96538, "", "=q4=Shield of Twinned Despair", "=ds=#w8#", tf=96910 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Twin Consorts", 829),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTLeiShen"] = {
		["RaidFinder"] = {
			{
				{ 1, 95813, "", "=q4=Gloves of the Maimed Vizier", "=ds=#s9#, #a1#" },
				{ 2, 95812, "", "=q4=Legwraps of Cardinality", "=ds=#s11#, #a1#" },
				{ 3, 95804, "", "=q4=Fusion Slasher Chestguard", "=ds=#s5#, #a2#" },
				{ 4, 95819, "", "=q4=Grips of Slicing Electricity", "=ds=#s9#, #a2#" },
				{ 5, 95805, "", "=q4=Conduit-Breaker Chain Leggings", "=ds=#s11#, #a3#" },
				{ 6, 95820, "", "=q4=Leggings of the Violent Gale", "=ds=#s11#, #a3#" },
				{ 7, 95806, "", "=q4=Doomed Crown of Lei Shen", "=ds=#s1#, #a4#" },
				{ 8, 95821, "", "=q4=Lei Shen's Grounded Carapace", "=ds=#s5#, #a4#" },
				{ 9, 95807, "", "=q4=Legplates of the Lightning Throne", "=ds=#s11#, #a4#" },
				{ 10, 95808, "", "=q4=Legplates of Whipping Ionization", "=ds=#s11#, #a4#" },
				{ 12, 94867, "", "=q5=Heart of the Thunder King", "=ds=#m3#" },
				{ 16, 95816, "", "=q4=Soul Prism of Lei Shen", "=ds=#s2#" },
				{ 17, 95817, "", "=q4=Lightning-Imbued Chalice", "=ds=#s14#" },
				{ 18, 95802, "", "=q4=Rune of Re-Origination", "=ds=#s14#" },
				{ 19, 95811, "", "=q4=Soul Barrier", "=ds=#s14#" },
				{ 20, 95814, "", "=q4=Unerring Vision of Lei Shen", "=ds=#s14#" },
				{ 22, 95803, "", "=q4=Shan-Dun, Breaker of Hope", "=ds=#w7#" },
				{ 23, 95815, "", "=q4=Torall, Rod of the Shattered Throne", "=ds=#h1#, #w6#" },
				{ 24, 95809, "", "=q4=Uroe, Harbinger of Terror", "=ds=#h2#, #w1#" },
				{ 25, 95810, "", "=q4=Ultimate Protection of the Emperor", "=ds=#w8#" },
				{ 26, 95818, "", "=q4=Lei Shen's Orb of Command", "=ds=#s15#" },

			};
		};
		["Normal"] = {
			{
				{ 1, 94993, "", "=q4=Gloves of the Maimed Vizier", "=ds=#s9#, #a1#", tf=96185 },
				{ 2, 94990, "", "=q4=Legwraps of Cardinality", "=ds=#s11#, #a1#", tf=96184 },
				{ 3, 94987, "", "=q4=Fusion Slasher Chestguard", "=ds=#s5#, #a2#", tf=96176 },
				{ 4, 94991, "", "=q4=Grips of Slicing Electricity", "=ds=#s9#, #a2#", tf=96191 },
				{ 5, 94986, "", "=q4=Conduit-Breaker Chain Leggings", "=ds=#s11#, #a3#", tf=96177 },
				{ 6, 94992, "", "=q4=Leggings of the Violent Gale", "=ds=#s11#, #a3#", tf=96192 },
				{ 7, 94984, "", "=q4=Doomed Crown of Lei Shen", "=ds=#s1#, #a4#", tf=96178 },
				{ 8, 94989, "", "=q4=Lei Shen's Grounded Carapace", "=ds=#s5#, #a4#", tf=96193 },
				{ 9, 95535, "", "=q4=Legplates of the Lightning Throne", "=ds=#s11#, #a4#", tf=96179 },
				{ 10, 94985, "", "=q4=Legplates of Whipping Ionization", "=ds=#s11#, #a4#", tf=96180 },
				{ 12, 94867, "", "=q5=Heart of the Thunder King", "=ds=#m3#" },
				{ 16, 94994, "", "=q4=Soul Prism of Lei Shen", "=ds=#s2#", tf=96188 },
				{ 17, 94530, "", "=q4=Lightning-Imbued Chalice", "=ds=#s14#", tf=96189 },
				{ 18, 94532, "", "=q4=Rune of Re-Origination", "=ds=#s14#", tf=96174 },
				{ 19, 94528, "", "=q4=Soul Barrier", "=ds=#s14#", tf=96183 },
				{ 20, 94524, "", "=q4=Unerring Vision of Lei Shen", "=ds=#s14#", tf=96186 },
				{ 22, 94983, "", "=q4=Shan-Dun, Breaker of Hope", "=ds=#w7#", tf=96175 },
				{ 23, 94988, "", "=q4=Torall, Rod of the Shattered Throne", "=ds=#h1#, #w6#", tf=96187 },
				{ 24, 94982, "", "=q4=Uroe, Harbinger of Terror", "=ds=#h2#, #w1#", tf=96181 },
				{ 25, 95472, "", "=q4=Ultimate Protection of the Emperor", "=ds=#w8#", tf=96182 },
				{ 26, 95473, "", "=q4=Lei Shen's Orb of Command", "=ds=#s15#", tf=96190 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96557, "", "=q4=Gloves of the Maimed Vizier", "=ds=#s9#, #a1#", tf=96929 },
				{ 2, 96556, "", "=q4=Legwraps of Cardinality", "=ds=#s11#, #a1#", tf=96928 },
				{ 3, 96548, "", "=q4=Fusion Slasher Chestguard", "=ds=#s5#, #a2#", tf=96920 },
				{ 4, 96563, "", "=q4=Grips of Slicing Electricity", "=ds=#s9#, #a2#", tf=96935 },
				{ 5, 96549, "", "=q4=Conduit-Breaker Chain Leggings", "=ds=#s11#, #a3#", tf=96921 },
				{ 6, 96564, "", "=q4=Leggings of the Violent Gale", "=ds=#s11#, #a3#", tf=96936 },
				{ 7, 96550, "", "=q4=Doomed Crown of Lei Shen", "=ds=#s1#, #a4#", tf=96922 },
				{ 8, 96565, "", "=q4=Lei Shen's Grounded Carapace", "=ds=#s5#, #a4#", tf=96937 },
				{ 9, 96551, "", "=q4=Legplates of the Lightning Throne", "=ds=#s11#, #a4#", tf=96923 },
				{ 10, 96552, "", "=q4=Legplates of Whipping Ionization", "=ds=#s11#, #a4#", tf=96924 },
				{ 12, 94867, "", "=q5=Heart of the Thunder King", "=ds=#m3#" },
				{ 16, 96560, "", "=q4=Soul Prism of Lei Shen", "=ds=#s2#", tf=96932 },
				{ 17, 96561, "", "=q4=Lightning-Imbued Chalice", "=ds=#s14#", tf=96933 },
				{ 18, 96546, "", "=q4=Rune of Re-Origination", "=ds=#s14#", tf=96918 },
				{ 19, 96555, "", "=q4=Soul Barrier", "=ds=#s14#", tf=96927 },
				{ 20, 96558, "", "=q4=Unerring Vision of Lei Shen", "=ds=#s14#", tf=96930 },
				{ 22, 96547, "", "=q4=Shan-Dun, Breaker of Hope", "=ds=#w7#", tf=96919 },
				{ 23, 96559, "", "=q4=Torall, Rod of the Shattered Throne", "=ds=#h1#, #w6#", tf=96931 },
				{ 24, 96553, "", "=q4=Uroe, Harbinger of Terror", "=ds=#h2#, #w1#", tf=96925 },
				{ 25, 96554, "", "=q4=Ultimate Protection of the Emperor", "=ds=#w8#", tf=96926 },
				{ 26, 96562, "", "=q4=Lei Shen's Orb of Command", "=ds=#s15#", tf=96934 },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lei Shen", 832),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTRaden"] = {
		["Heroic"] = {
			{
				{ 1, 95013, "", "=q4=Black Night Thundercloak", "=ds=#s4#" },
				{ 2, 95015, "", "=q4=Grey Wind Mistcloak", "=ds=#s4#" },
				{ 3, 95014, "", "=q4=Red Sky Cloudcloak", "=ds=#s4#" },
				{ 4, 95016, "", "=q4=White Snow Skycloak", "=ds=#s4#" },
				{ 5, 95017, "", "=q4=Yellow Dawn Lightningcloak", "=ds=#s4#" },
				{ 6, 95040, "", "=q4=Robes of Nova", "=ds=#s5#, #a1#" },
				{ 7, 95039, "", "=q4=Starburner Robes", "=ds=#s5#, #a1#" },
				{ 8, 94995, "", "=q4=Detonation Cord", "=ds=#s10#, #a1#" },
				{ 9, 94996, "", "=q4=Vita-Binder Wrap", "=ds=#s10#, #a1#" },
				{ 10, 95030, "", "=q4=Leggings of the Discarded Warning", "=ds=#s11#, #a1#" },
				{ 11, 95031, "", "=q4=Legguards of Surreal Visions", "=ds=#s11#, #a1#" },
				{ 12, 95004, "", "=q4=Starwalker Sandals", "=ds=#s12#, #a1#" },
				{ 13, 95005, "", "=q4=Treads of Delicate Fascia", "=ds=#s12#, #a1#" },
				{ 14, 95033, "", "=q4=Chestguard of Coruscating Blades", "=ds=#s5#, #a2#" },
				{ 15, 95032, "", "=q4=Robes of Contagious Time", "=ds=#s5#, #a2#" },
				{ 16, 94998, "", "=q4=Strap of Murderous Strikes", "=ds=#s10#, #a2#" },
				{ 17, 94997, "", "=q4=Worldbender Waistband", "=ds=#s10#, #a2#" },
				{ 18, 95028, "", "=q4=Cosmicfire Legwraps", "=ds=#s11#, #a2#" },
				{ 19, 95029, "", "=q4=Kilt of Perpetual Genuflection", "=ds=#s11#, #a2#" },
				{ 20, 95006, "", "=q4=Roots of Pain", "=ds=#s12#, #a2#" },
				{ 21, 95007, "", "=q4=Twist-Toe Tabi", "=ds=#s12#, #a2#" },
				{ 22, 95035, "", "=q4=Chains of Counted Souls", "=ds=#s5#, #a3#" },
				{ 23, 95034, "", "=q4=Scales of Shaped Flesh", "=ds=#s5#, #a3#" },
				{ 24, 95000, "", "=q4=Jingling Fetishgirdle", "=ds=#s10#, #a3#" },
				{ 25, 94999, "", "=q4=Longdraw Chain Belt", "=ds=#s10#, #a3#" },
				{ 26, 95027, "", "=q4=Legguards of Awaked Repair", "=ds=#s11#, #a3#" },
				{ 27, 95026, "", "=q4=Sparkstring Chain Leggings", "=ds=#s11#, #a3#" },
				{ 28, 95009, "", "=q4=Treads of the Sanguine Volley", "=ds=#s12#, #a3#" },
				{ 29, 95008, "", "=q4=World-Mote Sabatons", "=ds=#s12#, #a3#" },
				extraText = " ("..AL["Thunderforged"]..")";
			};
			{
				{ 1, 95038, "", "=q4=Carapace of the Core", "=ds=#s5#, #a4#" },
				{ 2, 95036, "", "=q4=Nova-Binder Breastplate", "=ds=#s5#, #a4#" },
				{ 3, 95037, "", "=q4=Planet-Birthed Cuirass", "=ds=#s5#, #a4#" },
				{ 4, 95001, "", "=q4=Bubbling Anima Belt", "=ds=#s10#, #a4#" },
				{ 5, 95002, "", "=q4=Cracklesnap Clasp", "=ds=#s10#, #a4#" },
				{ 6, 95003, "", "=q4=Flare-Forged Greatbelt", "=ds=#s10#, #a4#" },
				{ 7, 95025, "", "=q4=Archaic Protector's Legguards", "=ds=#s11#, #a4#" },
				{ 8, 95023, "", "=q4=Legplates of Lightning Blood", "=ds=#s11#, #a4#" },
				{ 9, 95024, "", "=q4=Time-Lost Greaves", "=ds=#s11#, #a4#" },
				{ 10, 95010, "", "=q4=Hypersensitive Sollerets", "=ds=#s12#, #a4#" },
				{ 11, 95011, "", "=q4=Lightning-Walker Clawfeet", "=ds=#s12#, #a4#" },
				{ 12, 95012, "", "=q4=Sabatons of the Superior Being", "=ds=#s12#, #a4#" },
				{ 16, 95020, "", "=q4=Ra-den's Contemplative Loop", "=ds=#s13#" },
				{ 17, 95018, "", "=q4=Ra-den's Evolving Signet", "=ds=#s13#" },
				{ 18, 95022, "", "=q4=Ra-den's Ruinous Ring", "=ds=#s13#" },
				{ 19, 95019, "", "=q4=Ra-den's Summoning Band", "=ds=#s13#" },
				{ 20, 95021, "", "=q4=Ra-den's Swift Seal", "=ds=#s13#" },
				extraText = " ("..AL["Thunderforged"]..")";
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ra-den", 831),
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTShared"] = {
		["RaidFinder"] = {
			{
				{ 1, 95863, "", "=q4=Lost Shoulders of Fire", "=ds=#s3#, #a1#" },
				{ 2, 95865, "", "=q4=Lost Shoulders of Fluidity", "=ds=#s3#, #a1#" },
				{ 3, 95864, "", "=q4=Lost Shoulders of Healing", "=ds=#s3#, #a1#" },
				{ 4, 95868, "", "=q4=Forgotten Mantle of the Moon", "=ds=#s3#, #a2#" },
				{ 5, 95869, "", "=q4=Forgotten Mantle of the Sun", "=ds=#s3#, #a2#" },
				{ 6, 95870, "", "=q4=Abandoned Spaulders of Arrowflight", "=ds=#s3#, #a3#" },
				{ 7, 95871, "", "=q4=Abandoned Spaulders of Renewal", "=ds=#s3#, #a3#" },
				{ 8, 95874, "", "=q4=Reconstructed Bloody Shoulderplates", "=ds=#s3#, #a4#" },
				{ 9, 95873, "", "=q4=Reconstructed Furious Shoulderplates", "=ds=#s3#, #a4#" },
				{ 10, 95872, "", "=q4=Reconstructed Holy Shoulderplates", "=ds=#s3#, #a4#" },
				{ 16, 95877, "", "=q4=Bo-Ris, Horror in the Night", "=ds=#w7#" },
				{ 17, 95862, "", "=q4=Darkwood Spiritstaff", "=ds=#w9#" },
				{ 18, 95876, "", "=q4=Do-tharak, the Swordbreaker", "=ds=#h1#, #w10#" },
				{ 19, 95860, "", "=q4=Fyn's Flickering Dagger", "=ds=#h1#, #w4#" },
				{ 20, 95875, "", "=q4=Greatsword of Frozen Hells", "=ds=#h2#, #w10#" },
				{ 21, 95858, "", "=q4=Invocation of the Dawn", "=ds=#h2#, #w6#" },
				{ 22, 95867, "", "=q4=Jerthud, Graceful Hand of the Savior", "=ds=#h1#, #w6#" },
				{ 23, 95859, "", "=q4=Miracoran, the Vehement Chord", "=ds=#w2#" },
				{ 24, 95866, "", "=q4=Nadagast's Exsanguinator", "=ds=#h1#, #w4#" },
				{ 25, 97129, "", "=q4=Tia-Tia, the Scything Star", "=ds=#h1#, #w13#" },
				{ 26, 95861, "", "=q4=Zeeg's Ancient Kegsmasher", "=ds=#h1#, #w6#" },
				{ 27, 95878, "", "=q4=Visage of the Doomed", "=ds=#w8#" },
			};
			{
				{ 1, 95343, "", "=q3=Treasures of the Thunder King", "=ds=#m20#" },
				{ 2, 95961, "", "=q4=Abandoned Zandalari Firecord", "=ds=#s10#, #a1#" },
				{ 3, 95962, "", "=q4=Abandoned Zandalari Shadowgirdle", "=ds=#s10#, #a1#" },
				{ 4, 95965, "", "=q4=Home-Warding Slippers", "=ds=#s12#, #a1#" },
				{ 5, 95963, "", "=q4=Silentflame Sandals", "=ds=#s12#, #a1#" },
				{ 6, 95971, "", "=q4=Abandoned Zandalari Moonstrap", "=ds=#s10#, #a2#" },
				{ 7, 95970, "", "=q4=Abandoned Zandalari Silentbelt", "=ds=#s10#, #a2#" },
				{ 8, 95966, "", "=q4=Deeproot Treads", "=ds=#s12#, #a2#" },
				{ 9, 95959, "", "=q4=Spiderweb Tabi", "=ds=#s12#, #a2#" },
				{ 10, 95972, "", "=q4=Abandoned Zandalari Arrowlinks", "=ds=#s10#, #a3#" },
				{ 11, 95973, "", "=q4=Abandoned Zandalari Waterchain", "=ds=#s10#, #a3#" },
				{ 12, 95960, "", "=q4=Scalehide Spurs", "=ds=#s12#, #a3#" },
				{ 13, 95967, "", "=q4=Spiritbound Boots", "=ds=#s12#, #a3#" },
				{ 14, 95976, "", "=q4=Abandoned Zandalari Bucklebreaker", "=ds=#s10#, #a4#" },
				{ 15, 95975, "", "=q4=Abandoned Zandalari Goreplate", "=ds=#s10#, #a4#" },
				{ 16, 95974, "", "=q4=Abandoned Zandalari Greatbelt", "=ds=#s10#, #a4#" },
				{ 17, 95979, "", "=q4=Columnbreaker Stompers", "=ds=#s12#, #a4#" },
				{ 18, 95978, "", "=q4=Locksmasher Greaves", "=ds=#s12#, #a4#" },
				{ 19, 95968, "", "=q4=Vaultwalker Sabatons", "=ds=#s12#, #a4#" },
				{ 21, 95958, "", "=q4=Necklace of the Terra-Cotta Archer", "=ds=#s2#" },
				{ 22, 95964, "", "=q4=Necklace of the Terra-Cotta Invoker", "=ds=#s2#" },
				{ 23, 95969, "", "=q4=Necklace of the Terra-Cotta Mender", "=ds=#s2#" },
				{ 24, 95980, "", "=q4=Necklace of the Terra-Cotta Protector", "=ds=#s2#" },
				{ 25, 95977, "", "=q4=Necklace of the Terra-Cotta Vanquisher", "=ds=#s2#" },
				{ 27, 94295, "", "=q3=Primal Egg", "=ds=#m20#" },
				{ 28, 94292, "", "=q4=Reins of the Black Primal Raptor", "=ds=#e26#" },
				{ 29, 94293, "", "=q4=Reins of the Green Primal Raptor", "=ds=#e26#" },
				{ 30, 94291, "", "=q4=Reins of the Red Primal Raptor", "=ds=#e26#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 95061, "", "=q4=Lost Shoulders of Fire", "=ds=#s3#, #a1#", tf=96235 },
				{ 2, 95067, "", "=q4=Lost Shoulders of Fluidity", "=ds=#s3#, #a1#", tf=96237 },
				{ 3, 95066, "", "=q4=Lost Shoulders of Healing", "=ds=#s3#, #a1#", tf=96236 },
				{ 4, 95065, "", "=q4=Forgotten Mantle of the Moon", "=ds=#s3#, #a2#", tf=96240 },
				{ 5, 95062, "", "=q4=Forgotten Mantle of the Sun", "=ds=#s3#, #a2#", tf=96241 },
				{ 6, 95060, "", "=q4=Abandoned Spaulders of Arrowflight", "=ds=#s3#, #a3#", tf=96242 },
				{ 7, 95064, "", "=q4=Abandoned Spaulders of Renewal", "=ds=#s3#, #a3#", tf=96243 },
				{ 8, 95068, "", "=q4=Reconstructed Bloody Shoulderplates", "=ds=#s3#, #a4#", tf=96246 },
				{ 9, 95063, "", "=q4=Reconstructed Furious Shoulderplates", "=ds=#s3#, #a4#", tf=96245 },
				{ 10, 95069, "", "=q4=Reconstructed Holy Shoulderplates", "=ds=#s3#, #a4#", tf=96244 },
				{ 16, 95498, "", "=q4=Bo-Ris, Horror in the Night", "=ds=#w7#", tf=96249 },
				{ 17, 95507, "", "=q4=Darkwood Spiritstaff", "=ds=#w9#", tf=96234 },
				{ 18, 95502, "", "=q4=Do-tharak, the Swordbreaker", "=ds=#h1#, #w10#", tf=96248 },
				{ 19, 95501, "", "=q4=Fyn's Flickering Dagger", "=ds=#h1#, #w4#", tf=96232 },
				{ 20, 95505, "", "=q4=Greatsword of Frozen Hells", "=ds=#h2#, #w10#", tf=96247 },
				{ 21, 95499, "", "=q4=Invocation of the Dawn", "=ds=#h2#, #w6#", tf=96230 },
				{ 22, 95500, "", "=q4=Jerthud, Graceful Hand of the Savior", "=ds=#h1#, #w6#", tf=96239 },
				{ 23, 95503, "", "=q4=Miracoran, the Vehement Chord", "=ds=#w2#", tf=96231 },
				{ 24, 95506, "", "=q4=Nadagast's Exsanguinator", "=ds=#h1#, #w4#", tf=96238 },
				{ 25, 97126, "", "=q4=Tia-Tia, the Scything Star", "=ds=#h1#, #w13#", tf=97128 },
				{ 26, 95504, "", "=q4=Zeeg's Ancient Kegsmasher", "=ds=#h1#, #w6#", tf=96233 },
				{ 27, 95516, "", "=q4=Visage of the Doomed", "=ds=#w8#", tf=96250 },
			};
		};
		["Heroic"] = {
			{
				{ 1, 96607, "", "=q4=Lost Shoulders of Fire", "=ds=#s3#, #a1#", tf=96979 },
				{ 2, 96609, "", "=q4=Lost Shoulders of Fluidity", "=ds=#s3#, #a1#", tf=96981 },
				{ 3, 96608, "", "=q4=Lost Shoulders of Healing", "=ds=#s3#, #a1#", tf=96980 },
				{ 4, 96612, "", "=q4=Forgotten Mantle of the Moon", "=ds=#s3#, #a2#", tf=96984 },
				{ 5, 96613, "", "=q4=Forgotten Mantle of the Sun", "=ds=#s3#, #a2#", tf=96985 },
				{ 6, 96614, "", "=q4=Abandoned Spaulders of Arrowflight", "=ds=#s3#, #a3#", tf=96986 },
				{ 7, 96615, "", "=q4=Abandoned Spaulders of Renewal", "=ds=#s3#, #a3#", tf=96987 },
				{ 8, 96618, "", "=q4=Reconstructed Bloody Shoulderplates", "=ds=#s3#, #a4#", tf=96990 },
				{ 9, 96617, "", "=q4=Reconstructed Furious Shoulderplates", "=ds=#s3#, #a4#", tf=96989 },
				{ 10, 96616, "", "=q4=Reconstructed Holy Shoulderplates", "=ds=#s3#, #a4#", tf=96988 },
				{ 16, 96621, "", "=q4=Bo-Ris, Horror in the Night", "=ds=#w7#", tf=96993 },
				{ 17, 96606, "", "=q4=Darkwood Spiritstaff", "=ds=#w9#", tf=96978 },
				{ 18, 96620, "", "=q4=Do-tharak, the Swordbreaker", "=ds=#h1#, #w10#", tf=96992 },
				{ 19, 96604, "", "=q4=Fyn's Flickering Dagger", "=ds=#h1#, #w4#", tf=96976 },
				{ 20, 96619, "", "=q4=Greatsword of Frozen Hells", "=ds=#h2#, #w10#", tf=96991 },
				{ 21, 96602, "", "=q4=Invocation of the Dawn", "=ds=#h2#, #w6#", tf=96974 },
				{ 22, 96611, "", "=q4=Jerthud, Graceful Hand of the Savior", "=ds=#h1#, #w6#", tf=96983 },
				{ 23, 96603, "", "=q4=Miracoran, the Vehement Chord", "=ds=#w2#", tf=96975 },
				{ 24, 96610, "", "=q4=Nadagast's Exsanguinator", "=ds=#h1#, #w4#", tf=96982 },
				{ 25, 97127, "", "=q4=Tia-Tia, the Scything Star", "=ds=#h1#, #w13#", tf=97130 },
				{ 26, 96605, "", "=q4=Zeeg's Ancient Kegsmasher", "=ds=#h1#, #w6#", tf=96977 },
				{ 27, 96622, "", "=q4=Visage of the Doomed", "=ds=#w8#", tf=96994 },
			};
		};
		info = {
			name = AL["Shared Boss Loot"],
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	AtlasLoot_Data["ToTTrash"] = {
		["Normal"] = {
			{
				{ 1, 95207, "", "=q4=Abandoned Zandalari Firecord", "=ds=#s10#, #a1#", tf=96333 },
				{ 2, 95208, "", "=q4=Abandoned Zandalari Shadowgirdle", "=ds=#s10#, #a1#", tf=96334 },
				{ 3, 95224, "", "=q4=Home-Warding Slippers", "=ds=#s12#, #a1#", tf=96337 },
				{ 4, 95223, "", "=q4=Silentflame Sandals", "=ds=#s12#, #a1#", tf=96335 },
				{ 5, 95210, "", "=q4=Abandoned Zandalari Moonstrap", "=ds=#s10#, #a2#", tf=96343 },
				{ 6, 95209, "", "=q4=Abandoned Zandalari Silentbelt", "=ds=#s10#, #a2#", tf=96342 },
				{ 7, 95221, "", "=q4=Deeproot Treads", "=ds=#s12#, #a2#", tf=96338 },
				{ 8, 95219, "", "=q4=Spiderweb Tabi", "=ds=#s12#, #a2#", tf=96331 },
				{ 9, 95211, "", "=q4=Abandoned Zandalari Arrowlinks", "=ds=#s10#, #a3#", tf=96344 },
				{ 10, 95212, "", "=q4=Abandoned Zandalari Waterchain", "=ds=#s10#, #a3#", tf=96345 },
				{ 11, 95220, "", "=q4=Scalehide Spurs", "=ds=#s12#, #a3#", tf=96332 },
				{ 12, 95222, "", "=q4=Spiritbound Boots", "=ds=#s12#, #a3#", tf=96339 },
				{ 13, 95215, "", "=q4=Abandoned Zandalari Bucklebreaker", "=ds=#s10#, #a4#", tf=96348 },
				{ 14, 95214, "", "=q4=Abandoned Zandalari Goreplate", "=ds=#s10#, #a4#", tf=96347 },
				{ 15, 95213, "", "=q4=Abandoned Zandalari Greatbelt", "=ds=#s10#, #a4#", tf=96346 },
				{ 16, 95218, "", "=q4=Columnbreaker Stompers", "=ds=#s12#, #a4#", tf=96351 },
				{ 17, 95217, "", "=q4=Locksmasher Greaves", "=ds=#s12#, #a4#", tf=96350 },
				{ 18, 95216, "", "=q4=Vaultwalker Sabatons", "=ds=#s12#, #a4#", tf=96340 },
				{ 20, 95202, "", "=q4=Necklace of the Terra-Cotta Archer", "=ds=#s2#", tf=96330 },
				{ 21, 95203, "", "=q4=Necklace of the Terra-Cotta Invoker", "=ds=#s2#", tf=96336 },
				{ 22, 95204, "", "=q4=Necklace of the Terra-Cotta Mender", "=ds=#s2#", tf=96341 },
				{ 23, 95206, "", "=q4=Necklace of the Terra-Cotta Protector", "=ds=#s2#", tf=96352 },
				{ 24, 95205, "", "=q4=Necklace of the Terra-Cotta Vanquisher", "=ds=#s2#", tf=96349 },
				{ 26, 94125, "", "=q3=Living Sandling", "=ds=#e13#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "ThroneofThunder",
		};
	};

	-----------------
	--- Rare Mobs ---
	-----------------

		-----------------------
		--- The Jade Forest ---
		-----------------------

	AtlasLoot_Data["RaresMOPMobsJadeForest"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Aethis"], ""};
				{ 3, 87649, "", "=q4=Pool-Stirrer", "=ds=#h1#, #w6#"};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Ferdinand"], ""};
				{ 6, 87652, "", "=q4=Ook-Breaker Mace", "=ds=#h1#, #w6#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Kor'nas Nightsavage"], ""};
				{ 9, 87642, "", "=q4=Darkstaff of Annihilation", "=ds=#w9#"};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Krax'ik"], ""};
				{ 12, 87646, "", "=q4=Needlefang Throatripper", "=ds=#h1#, #w1#"};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Mister Ferocious"], ""};
				{ 18, 87652, "", "=q4=Ook-Breaker Mace", "=ds=#h1#, #w6#"};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Morgrinn Crackfang"], ""};
				{ 21, 87643, "", "=q4=Fangcracker Battlemace", "=ds=#h2#, #w6#"};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Sarnak"], ""};
				{ 24, 87650, "", "=q4=Fishsticker Crossbow", "=ds=#w3#"};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Urobi the Walker"], ""};
				{ 27, 87651, "", "=q4=Pathwalker Greatstaff", "=ds=#w9#"};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87586, "", "=q3=Forest Trickster's Leggings", "=ds=#s11#, #a1#"};
				{ 4, 87590, "", "=q3=Jade Heart Leggings", "=ds=#s11#, #a1#"};
				{ 5, 87587, "", "=q3=Orchard Tender's Leggings", "=ds=#s11#, #a2#"};
				{ 6, 87591, "", "=q3=Tian Trainee Leggings", "=ds=#s11#, #a2#"};
				{ 7, 87592, "", "=q3=Grookin' Grookin' Trousers", "=ds=#s11#, #a3#"};
				{ 8, 87588, "", "=q3=Leggings of Spiritsong Melody", "=ds=#s11#, #a3#"};
				{ 9, 87593, "", "=q3=Gan Shi Warlord Legguards", "=ds=#s11#, #a4#"};
				{ 10, 87594, "", "=q3=Leggings of Forgotten War", "=ds=#s11#, #a4#"};
				{ 11, 87589, "", "=q3=Leggings of Fractured Reflection", "=ds=#s11#, #a4#"};
				{ 12, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["The Jade Forest"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		--------------------------------
		--- Valley of the Four Winds ---
		--------------------------------

	AtlasLoot_Data["RaresMOPMobsValleyFourWinds"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Blackhoof"], ""};
				{ 3, 86565, "", "=q3=Battle Horn", "=ds="};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Bonobos"], ""};
				{ 6, 86591, "", "=q3=Magic Banana", "=ds="};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Jonn-Dar"], ""};
				{ 9, 86572, "", "=q3=Terracotta Fragment", "=ds=#s14#"};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Nal'lak the Ripper"], ""};
				{ 12, 86576, "", "=q3=Dynasty of Steel", "=ds=#s14#"};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Nasra Spothide"], ""};
				{ 18, 86587, "", "=q3=Seed of Tranquil Growth", "=ds=#s14#"};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Salyin Warscout"], ""};
				{ 21, 86583, "", "=q3=Salyin Battle Banner", "=ds="};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Sele'na"], ""};
				{ 24, 86580, "", "=q3=Overgrown Lilypad", "=ds="};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Sulik'shor"], ""};
				{ 27, 86569, "", "=q3=Crystal of Insanity", "=ds="};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87597, "", "=q3=Gloves of Congealed Mist", "=ds=#s9#, #a1#"};
				{ 4, 87598, "", "=q3=Monstrous Silk Gloves", "=ds=#s9#, #a1#"};
				{ 5, 87595, "", "=q3=Gloves of Burrow Spelunking", "=ds=#s9#, #a2#"};
				{ 6, 87599, "", "=q3=Grower's Gloves", "=ds=#s9#, #a2#"};
				{ 7, 87600, "", "=q3=Marshsong Gloves", "=ds=#s9#, #a3#"};
				{ 8, 87596, "", "=q3=Mudmug's Mitts", "=ds=#s9#, #a3#"};
				{ 9, 87602, "", "=q3=Grain Warden's Gauntlets", "=ds=#s9#, #a4#"};
				{ 10, 87603, "", "=q3=Thunderfall Gauntlets", "=ds=#s9#, #a4#"};
				{ 11, 87601, "", "=q3=Plough Driving Grips", "=ds=#s9#, #a4#"};
				{ 12, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["Valley of the Four Winds"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		-----------------------
		--- Krasarang Wilds ---
		-----------------------

	AtlasLoot_Data["RaresMOPMobsKrasarangWilds"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Arness the Scale"], ""};
				{ 3, 90723, "", "=q4=Arness's Scaled Leggings", "=ds=#s11#, #a3#"};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Cournith Waterstrider"], ""};
				{ 6, 90721, "", "=q4=Courinth Waterstrider's Silken Finery", "=ds=#s11#, #a1#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Gaarn the Toxic"], ""};
				{ 9, 90725, "", "=q4=Gaarn's Leggings of Infestation", "=ds=#s11#, #a1#"};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Go-Kan"], ""};
				{ 12, 90719, "", "=q4=Go-Kan's Golden Trousers", "=ds=#s11#, #a3#"};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Qu'nas"], ""};
				{ 18, 90717, "", "=q4=Qu'nas' Apocryphal Legplates", "=ds=#s11#, #a4#"};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Ruun Ghostpaw"], ""};
				{ 21, 90720, "", "=q4=Silent Leggings of the Ghostpaw", "=ds=#s11#, #a2#"};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Spriggin"], ""};
				{ 24, 90724, "", "=q4=Spriggin's Sproggin' Leggin'", "=ds=#s11#, #a2#"};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Torik-Ethis"], ""};
				{ 27, 90718, "", "=q4=Torik-Ethis' Bloodied Legguards", "=ds=#s11#, #a4#"};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87604, "", "=q3=Beachcomber's Hat", "=ds=#s1#, #a1#"};
				{ 4, 87608, "", "=q3=Korjan Mystic's Hood", "=ds=#s1#, #a1#"};
				{ 5, 87609, "", "=q3=Brushstalker Helm", "=ds=#s1#, #a2#"};
				{ 6, 87605, "", "=q3=Crest of the Red Crane", "=ds=#s1#, #a2#"};
				{ 7, 87610, "", "=q3=Deepwild Hunting Helm", "=ds=#s1#, #a3#"};
				{ 8, 87606, "", "=q3=Tidehunter Helm", "=ds=#s1#, #a3#"};
				{ 9, 87612, "", "=q3=Ancient Krasari Helm", "=ds=#s1#, #a4#"};
				{ 10, 87611, "", "=q3=Shen-zin Shell Headguard", "=ds=#s1#, #a4#"};
				{ 11, 87607, "", "=q3=Unearthed Dojani Headcover", "=ds=#s1#, #a4#"};
				{ 12, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["Krasarang Wilds"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		----------------------
		--- Kun-Lai Summit ---
		----------------------

	AtlasLoot_Data["RaresMOPMobsKunLaiSummit"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Ahone the Wanderer"], ""};
				{ 3, 86588, "", "=q3=Pandaren Firework Launcher", "=ds="};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Borginn Darkfist"], ""};
				{ 6, 86570, "", "=q3=Crate of Kidnapped Puppies", "=ds=#s14#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Havak"], ""};
				{ 9, 86573, "", "=q3=Shard of Archstone", "=ds=#e25#"};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Korda Torros"], ""};
				{ 12, 86566, "", "=q3=Forager's Gloves", "=ds=#s9#, #a1#"};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Nessos the Oracle"], ""};
				{ 18, 86584, "", "=q3=Hardened Shell", "=ds="};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Scritch"], ""};
				{ 21, 86592, "", "=q3=Hozen Peace Pipe", "=ds="};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Ski'thik"], ""};
				{ 24, 86577, "", "=q3=Rod of Ambershaping", "=ds="};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Zai the Outcast"], ""};
				{ 27, 86581, "", "=q3=Farwater Conch", "=ds="};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87616, "", "=q3=Mountain Trailblazer's Cuffs", "=ds=#s8#, #a1#"};
				{ 4, 87615, "", "=q3=Yakwasher's Bracers", "=ds=#s8#, #a1#"};
				{ 5, 87617, "", "=q3=Bracers of the Serene Mountaintop", "=ds=#s8#, #a2#"};
				{ 6, 87613, "", "=q3=Frozen Zandalari Bracer", "=ds=#s8#, #a2#"};
				{ 7, 87618, "", "=q3=Ice Encrusted Bracer", "=ds=#s8#, #a3#"};
				{ 8, 87614, "", "=q3=Kafa Picker's Bracers", "=ds=#s8#, #a3#"};
				{ 9, 87620, "", "=q3=Bracers of the Frozen Summit", "=ds=#s8#, #a4#"};
				{ 10, 87619, "", "=q3=Terracotta Guardian's Bracer", "=ds=#s8#, #a4#"};
				{ 11, 87621, "", "=q3=Wristguards of Great Fortune", "=ds=#s8#, #a4#"};
				{ 12, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["Kun-Lai Summit"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		------------------------
		--- Townlong Steppes ---
		------------------------

	AtlasLoot_Data["RaresMOPMobsTownlongSteppes"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Eshelon"], ""};
				{ 3, 87222, "", "=q3=Big Bag of Linens", "=ds="};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Kah'tir"], ""};
				{ 6, 87218, "", "=q4=Big Bag of Arms", "=ds="};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Lith'ik the Stalker"], ""};
				{ 9, 87221, "", "=q3=Big Bag of Jewels", "=ds="};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Lon the Bull"], ""};
				{ 12, 87219, "", "=q3=Big Bag of Herbs", "=ds="};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Norlaxx"], ""};
				{ 18, 87220, "", "=q3=Big Bag of Mysteries", "=ds="};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Siltriss the Sharpener"], ""};
				{ 21, 87223, "", "=q3=Big Bag of Skins", "=ds="};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["The Yowler"], ""};
				{ 24, 87225, "", "=q3=Big Bag of Food", "=ds="};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Yul Wildpaw"], ""};
				{ 27, 87224, "", "=q3=Big Bag of Wonders", "=ds="};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87625, "", "=q3=Congealed Mist Amulet", "=ds=#s2#"};
				{ 4, 87623, "", "=q3=Razor-Sharp Chitin Choker", "=ds=#s2#"};
				{ 5, 87626, "", "=q3=Suna's Shattered Locket", "=ds=#s2#"};
				{ 6, 87624, "", "=q3=Yaungol Mist-Shaman's Amulet", "=ds=#s2#"};
				{ 7, 87622, "", "=q3=Yoke of Niuzao", "=ds=#s2#"};
				{ 8, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["Townlong Steppes"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		--------------------
		--- Dread Wastes ---
		--------------------

	AtlasLoot_Data["RaresMOPMobsDreadWastes"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Ai-Li Skymirror"], ""};
				{ 3, 86589, "", "=q3=Ai-Li's Skymirror", "=ds=#e25#"};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Dak the Breaker"], ""};
				{ 6, 86567, "", "=q3=Yaungol Wind Chime", "=ds=#s14#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Gar'lok"], ""};
				{ 9, 86578, "", "=q3=Eternal Warrior's Sigil", "=ds="};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Ik-Ik the Nimble"], ""};
				{ 12, 86593, "", "=q3=Hozen Beach Ball", "=ds=#e25#"};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Karr the Darkener"], ""};
				{ 18, 86564, "", "=q3=Imbued Jade Fragment", "=ds=#e13#"};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Krol the Blade"], ""};
				{ 21, 86574, "", "=q3=Elixir of Ancient Knowledge", "=ds="};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Nalash Verdantis"], ""};
				{ 24, 86563, "", "=q3=Hollow Reed", "=ds=#e13#"};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Omnis Grinlok"], ""};
				{ 27, 86585, "", "=q3=Golden Fleece", "=ds=#s14#"};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87635, "", "=q3=Amber-Starched Robes", "=ds=#s5#, #a1#"};
				{ 4, 87634, "", "=q3=Mazu's Robe", "=ds=#s5#, #a1#"};
				{ 5, 87631, "", "=q3=Jiao-Skin Tunic", "=ds=#s5#, #a2#"};
				{ 6, 87630, "", "=q3=Chestpiece of Twinkling Stars", "=ds=#s5#, #a3#"};
				{ 7, 87632, "", "=q3=Fearsworn Chestpiece", "=ds=#s5#, #a3#"};
				{ 8, 87629, "", "=q3=Chestplate of Manifest Dread", "=ds=#s5#, #a4#"};
				{ 9, 87627, "", "=q3=Kunchong Carapace Chestguard", "=ds=#s5#, #a4#"};
				{ 10, 87628, "", "=q3=Spinebreaker Chestpiece", "=ds=#s5#, #a4#"};
				{ 11, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["Dread Wastes"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		--------------------------------
		--- Vale of Eternal Blossoms ---
		--------------------------------

	AtlasLoot_Data["RaresMOPMobsValeOfEternalBlossoms"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Ai-Ran the Shifting Cloud"], ""};
				{ 3, 86590, "", "=q3=Essence of the Breeze", "=ds="};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Kal'tik the Blight"], ""};
				{ 6, 86579, "", "=q3=Bottled Tornado", "=ds=#s14#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Kang the Soul Thief"], ""};
				{ 9, 86571, "", "=q3=Kang's Bindstone", "=ds="};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Major Nanners"], ""};
				{ 12, 86594, "", "=q3=Helpful Wikky's Whistle", "=ds="};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Moldo One-Eye"], ""};
				{ 18, 86586, "", "=q3=Panflute of Pandaria", "=ds="};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Sahn Tidehunter"], ""};
				{ 21, 86582, "", "=q3=Aqua Jewel", "=ds="};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Urgolax"], ""};
				{ 24, 86575, "", "=q3=Chalice of Secrets", "=ds="};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Yorik Sharpeye"], ""};
				{ 27, 86568, "", "=q3=Mr. Smite's Brass Compass", "=ds=#e25#"};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 3, 87638, "", "=q3=Cloak of Tranquil Clouds", "=ds=#s4#"};
				{ 4, 87636, "", "=q3=Cloak of the Forgotten Emperor", "=ds=#s4#"};
				{ 5, 87637, "", "=q3=Jade Harbinger's Cloak", "=ds=#s4#"};
				{ 6, 87640, "", "=q3=Softfoot's Drape", "=ds=#s4#"};
				{ 7, 87639, "", "=q3=Tattered Guo-Lai Dynasty Cloak", "=ds=#s4#"};
				{ 8, 87217, "", "=q2=Small Bag of Goods", "=ds="};
			};
		};
		info = {
			name = ALIL["Vale of Eternal Blossoms"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		-----------------------
		--- Isle of Thunder ---
		-----------------------

	AtlasLoot_Data["RaresMOPMobsIsleofThunder"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..ALIL["Ancient Mogu Guardian"], "=q1="..AL["Summon"]};
				{ 3, 94826, "", "=q4=Mogu Sportsman's Bow", "=ds=#w2#"};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Cera"], "=q1="..AL["Summon"]};
				{ 6, 94706, "", "=q4=Cera's Impalers", "=ds=#h1#, #w4#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Echo of Kros"], "=q1="..AL["Summon"]};
				{ 9, 94708, "", "=q4=Saurok Ritualist's Sacrificial Dagger", "=ds=#h1#, #w4#"};
				{ 11, 0, "inv_box_04", "=q6="..ALIL["Electromancer Ju'le"], "=q1="..AL["Summon"]};
				{ 12, 94825, "", "=q4=Lightning Snare", "=ds=#h1#, #w6#"};
				{ 17, 0, "inv_box_04", "=q6="..ALIL["Haywire Sunreaver Construct"], ""};
				{ 18, 94124, "", "=q3=Sunreaver Micro-Sentry", "=ds=#e13#"};
				{ 20, 0, "inv_box_04", "=q6="..ALIL["Incomplete Drakkari Colossus"], "=q1="..AL["Summon"]};
				{ 21, 94823, "", "=q4=Drakkari Decapitator", "=ds=#h2#, #w1#"};
				{ 23, 0, "inv_box_04", "=q6="..ALIL["Kor'dok and Tinzo the Emberkeeper"], "=q1="..AL["Summon"]};
				{ 24, 94720, "", "=q4=Vengeance of Kor'dok", "=ds=#h1#, #w10#"};
				{ 26, 0, "inv_box_04", "=q6="..ALIL["Qi'nor"], "=q1="..AL["Summon"]};
				{ 27, 94824, "", "=q4=Gaze of Qi'nor", "=ds=#w9#"};
			};
			{
				{ 2, 0, "inv_box_04", "=q6="..BabbleRare["Ra'sha"], ""};
				{ 3, 95566, "", "=q3=Ra'sha's Sacrificial Dagger", "=ds="};
				{ 5, 0, "inv_box_04", "=q6="..ALIL["Spirit of Warlord Teng"], "=q1="..AL["Summon"]};
				{ 6, 94707, "", "=q4=Teng's Reach", "=ds=#w7#"};
				{ 8, 0, "inv_box_04", "=q6="..ALIL["Windweaver Akil'amon"], "=q1="..AL["Summon"]};
				{ 9, 94709, "", "=q4=Talonblade of Akil'amon", "=ds=#h1#, #w10#"};
				{ 17, 0, "inv_box_04", "=q6="..AL["Shared Zone Loot"], ""};
				{ 18, 94222, "", "=q4=Key to the Palace of Lei Shen", "=ds=#e9#"};
				{ 19, 92426, "", "=q4=Sealed Tome of the Lost Legion", "=ds=#m2#"};
				{ 20, 94221, "", "=q3=Shan'ze Ritual Stone", "=ds="};
			};
		};
		info = {
			name = ALIL["Isle of Thunder"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		---------------------
		--- Miscellaneous ---
		---------------------

	AtlasLoot_Data["RaresMOPMobsMisc"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..BabbleRare["Fixxul Lonelyheart"], "=q2="..ALIL["The Jade Forest"]};
				{ 3, 90078, "", "=q2=Cracked Talisman", "=ds="};
				{ 5, 0, "inv_box_04", "=q6="..BabbleRare["Lorbu Sadsummon"], "=q2="..ALIL["The Jade Forest"]};
				{ 6, 90078, "", "=q2=Cracked Talisman", "=ds="};
				{ 8, 0, "inv_box_04", "=q6="..BabbleRare["Martar the Not-So-Smart"], "=q2="..ALIL["The Jade Forest"]};
				{ 9, 87780, "", "=q3=Martar's Magnifying Glass", "=ds=#s14#"};
				{ 11, 0, "inv_box_04", "=q6="..BabbleRare["Huggalon the Heart Watcher"], "=q2="..ALIL["Townlong Steppes"]};
				{ 12, 90067, "", "=q3=B. F. F. Necklace", "=ds="};
				{ 14, 0, "inv_box_04", "=q6="..BabbleRare["Scotty"], "=q2="..ALIL["Townlong Steppes"]};
				{ 15, 89373, "", "=q2=Scotty's Lucky Coin", "=ds=#e25#"};
				{ 17, 0, "inv_box_04", "=q6="..BabbleRare["Alani"], "=q2="..ALIL["Vale of Eternal Blossoms"]};
				{ 18, 90655, "", "=q4=Reins of the Thundering Ruby Cloud Serpent", "=ds=#e12#"};
				{ 20, 0, "inv_box_04", "=q6="..BabbleRare["Sungraze Behemoth"], "=q2="..ALIL["Valley of the Four Winds"]};
				{ 21, 89682, "", "=q2=Oddly-Shaped Horn", "=ds=#e12#"};
				{ 23, 0, "inv_box_04", "=q6="..BabbleRare["Zhing"], "=q2="..ALIL["Kun-Lai Summit"]};
				{ 24, 89697, "", "=q2=Bag of Kafa Beans", "=ds=#e12#"};
				{ 26, 0, "inv_box_04", "=q6="..BabbleRare["Pengsong"], "=q2="..ALIL["Dread Wastes"]};
				{ 27, 89770, "", "=q2=Tuft of Yak Fur", "=ds=#e12#"};
				{ 29, 0, "inv_box_04", "=q6="..BabbleRare["Wild Onyx Serpent"], "=q2="..ALIL["Kun-Lai Summit"]};
				{ 30, 93360, "", "=q2=Serpent's Cache", "=ds="};
			};
		};
		info = {
			name = AL["Misc"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		----------------------------
		--- Zandalari Warbringer ---
		----------------------------

	AtlasLoot_Data["RaresMOPMobsWarbringer"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..BabbleRare["Zandalari Warbringer"], ""};
				{ 3, 94230, "", "=q4=Reins of the Amber Primordial Direhorn", "=ds=#e26#"};
				{ 4, 94231, "", "=q4=Reins of the Jade Primordial Direhorn", "=ds=#e26#"};
				{ 5, 94229, "", "=q4=Reins of the Slate Primordial Direhorn", "=ds=#e26#"};
				{ 6, 94225, "", "=q3=Stolen Celestial Insignia", "=ds="};
				{ 7, 94227, "", "=q3=Stolen Golden Lotus Insignia", "=ds="};
				{ 8, 94226, "", "=q3=Stolen Klaxxi Insignia", "=ds="};
				{ 9, 94223, "", "=q3=Stolen Shado-Pan Insignia", "=ds="};
				{ 10, 94158, "", "=q3=Big Bag of Zandalari Supplies", "=ds="};
				{ 11, 94159, "", "=q2=Small Bag of Zandalari Supplies", "=ds="};
			};
		};
		info = {
			name = BabbleRare["Zandalari Warbringer"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		----------------------------
		--- Clawlord Kril'mandar ---
		----------------------------

	AtlasLoot_Data["RaresMOPMobsClawlord"] = {
		["Normal"] = {
			{
				{ 2, 0, "inv_box_04", "=q6="..BabbleRare["Clawlord Kril'mandar"], "=q2="..ALIL["Krasarang Wilds"]};
				{ 3, 90087, "", "=q3=Lobstmourne", "=ds=#h1#, #w13#"};
				{ 5, 0, "inv_box_04", "=q6="..BabbleRare["Akkalou"], "=q2="..ALIL["The Jade Forest"]};
				{ 6, 90166, "", "=q2=Akkalou's Clamshell", "=ds="};
				{ 8, 0, "inv_box_04", "=q6="..BabbleRare["Akkalar"], "=q2="..ALIL["The Jade Forest"]};
				{ 9, 90167, "", "=q2=Akkalar's Clamshell", "=ds="};
				{ 11, 0, "inv_box_04", "=q6="..BabbleRare["Damlak"], "=q2="..ALIL["Krasarang Wilds"]};
				{ 12, 90169, "", "=q2=Damlak's Clamshell", "=ds="};
				{ 18, 90172, "", "=q2=Clamshell Band", "=ds=#m27#"};
				{ 20, 0, "inv_box_04", "=q6="..BabbleRare["Clamstok"], "=q2="..ALIL["Dread Wastes"]};
				{ 21, 90170, "", "=q2=Clamstok's Clamshell", "=ds="};
				{ 23, 0, "inv_box_04", "=q6="..BabbleRare["Kishak"], "=q2="..ALIL["Kun-Lai Summit"]};
				{ 24, 90168, "", "=q2=Kishak's Clamshell", "=ds="};
				{ 26, 0, "inv_box_04", "=q6="..BabbleRare["Odd'nirok"], "=q2="..ALIL["Townlong Steppes"]};
				{ 27, 90171, "", "=q2=Odd'nirok's Clamshell", "=ds="};
			};
		};
		info = {
			name = BabbleRare["Clawlord Kril'mandar"],
			module = moduleName, menu = "RAREMENU",
		};
	}

	------------------
	--- Rare Items ---
	------------------

		--------------------------------------------------
		--- The Jade Forest / Valley of the Four Winds ---
		--------------------------------------------------

	AtlasLoot_Data["RaresMOPItemsJadeForestValleyoftheFourWinds"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_box_04", "=q6="..ALIL["The Jade Forest"], "=ds="};
				{ 2, 86196, "", "=q3=Ancient Jinyu Staff", "=ds=#w9#"};
				{ 3, 85777, "", "=q3=Ancient Pandaren Mining Pick", "=ds=#h1#, #w1#"};
				{ 4, 86198, "", "=q3=Hammer of Ten Thunders", "=ds=#h2#, #w6#"};
				{ 5, 85776, "", "=q3=Wodin's Mantid Shanker", "=ds=#h1#, #w4#"};
				{ 7, 0, "inv_box_04", "=q6="..BabbleRare["Jade Warrior Statue"], "=ds="};
				{ 8, 86199, "", "=q3=Jade Infused Blade", "=ds=#h1#, #w10#"};
				{ 16, 0, "inv_box_04", "=q6="..ALIL["Valley of the Four Winds"], "=ds="};
				{ 17, 86218, "", "=q3=Staff of the Hidden Master", "=ds=#w9#"};
				{ 19, 0, "inv_box_04", "=q6="..BabbleRare["Ghostly Pandaren Craftsman"], "=ds="};
				{ 20, 85973, "", "=q3=Ancient Pandaren Fishing Charm", "=ds="};
				{ 22, 0, "inv_box_04", "=q6="..BabbleRare["Ghostly Pandaren Fisherman"], "=ds="};
				{ 23, 86079, "", "=q0=Ancient Pandaren Woodcutter", "=ds=#h3#, #w1#"};
				{ 25, 0, "inv_box_04", "=q6="..BabbleRare["Cache of Pilfered Goods"], "=ds="};
				{ 26, 86113, "", "=q3=Stolen Amulet of Might", "=ds=#s2#"};
				{ 27, 86112, "", "=q3=Stolen Amulet of Wisdom", "=ds=#s2#"};
				{ 28, 86111, "", "=q3=Stolen Necklace of Accuracy", "=ds=#s2#"};
				{ 29, 86114, "", "=q3=Stolen Necklace of Fortitude", "=ds=#s2#"};
				{ 30, 86110, "", "=q3=Stolen Necklace of Precision", "=ds=#s2#"};
			};
		};
		info = {
			name = ALIL["The Jade Forest"].." / "..ALIL["Valley of the Four Winds"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		----------------------------------------
		--- Krasarang Wilds / Kun-Lai Summit ---
		----------------------------------------

	AtlasLoot_Data["RaresMOPItemsKrasarangWildsKunLaiSummit"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_box_04", "=q6="..ALIL["Krasarang Wilds"], "=ds="};
				{ 2, 86124, "", "=q3=Pandaren Fishing Spear", "=ds=#w7#"};
				{ 4, 0, "inv_box_04", "=q6="..BabbleRare["Barrel of Banana Infused Rum"], "=ds="};
				{ 5, 87266, "", "=q1=Recipe: Banana Infused Rum", "=ds=#p3#"};
				{ 7, 0, "inv_box_04", "=q6="..BabbleRare["Equipment Locker"], "=ds="};
				{ 8, 86117, "", "=q3=Seafarer's Treads of Precision", "=ds=#s12#, #a1#"};
				{ 9, 86118, "", "=q3=Seafaring Advisor's Slippers", "=ds=#s12#, #a1#"};
				{ 10, 86119, "", "=q3=Seafarer's Boots of Meditation", "=ds=#s12#, #a2#"};
				{ 11, 86115, "", "=q3=Swashbuckling Boots", "=ds=#s12#, #a2#"};
				{ 12, 86116, "", "=q3=Agile Seafarer's Jackboots", "=ds=#s12#, #a3#"};
				{ 13, 86120, "", "=q3=Seafaring Sabatons of Meditation", "=ds=#s12#, #a3#"};
				{ 14, 86122, "", "=q3=Plankwalking Greaves", "=ds=#s12#, #a4#"};
				{ 15, 86123, "", "=q3=Seafarer's Sturdy Boots", "=ds=#s12#, #a4#"};
				{ 16, 0, "inv_box_04", "=q6="..ALIL["Kun-Lai Summit"], "=ds="};
				{ 17, 86394, "", "=q3=Hozen Warrior Spear", "=ds=#w7#"};
				{ 18, 88723, "", "=q3=Sturdy Yaungol Spear", "=ds=#w7#"};
				{ 19, 86393, "", "=q1=Tablet of Ren Yun", "=ds=#p3#"};
				{ 21, 0, "inv_box_04", "=q6="..BabbleRare["Frozen Trail Packer"], "=ds="};
				{ 22, 86125, "", "=q3=Kafa Press", "=ds="};
				{ 24, 0, "inv_box_04", "=q6="..BabbleRare["Sprite's Cloth Chest"], "=ds="};
				{ 25, 86223, "", "=q3=Agile Sprite Cloak", "=ds=#s4#"};
				{ 26, 86222, "", "=q3=Precise Sprite Cloak", "=ds=#s4#"};
				{ 27, 86224, "", "=q3=Steadfast Sprite Cape", "=ds=#s4#"};
				{ 28, 86225, "", "=q3=Strong Sprite Cloak", "=ds=#s4#"};
				{ 29, 86221, "", "=q3=Wise Sprite Cloak", "=ds=#s4#"};
			};
		};
		info = {
			name = ALIL["Krasarang Wilds"].." / "..ALIL["Kun-Lai Summit"],
			module = moduleName, menu = "RAREMENU",
		};
	}

		---------------------------------------
		--- Townlong Steppes / Dread Wastes ---
		---------------------------------------

	AtlasLoot_Data["RaresMOPItemsTownlongSteppesDreadWastes"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_box_04", "=q6="..ALIL["Townlong Steppes"], "=ds="};
				{ 2, 86518, "", "=q3=Yaungol Fire Carrier", "=ds=#h1#, #w6#"};
				{ 16, 0, "inv_box_04", "=q6="..ALIL["Dread Wastes"], "=ds="};
				{ 17, 86527, "", "=q3=Blade of the Poisoned Mind", "=ds=#h1#, #w10#"};
				{ 18, 86522, "", "=q3=Blade of the Prime", "=ds=#h1#, #w10#"};
				{ 19, 86525, "", "=q3=Bloodsoaked Chitin Fragment", "=ds=#s14#"};
				{ 20, 86524, "", "=q3=Dissector's Staff of Mutation", "=ds=#w9#"};
				{ 21, 86521, "", "=q3=Lucid Amulet of the Agile Mind", "=ds=#s2#"};
				{ 22, 86520, "", "=q3=Malik's Stalwart Spear", "=ds=#w7#"};
				{ 23, 86523, "", "=q3=Swarming Cleaver of Ka'roz", "=ds=#h2#, #w10#"};
				{ 24, 86526, "", "=q3=Swarmkeeper's Medallion", "=ds=#s2#"};
				{ 25, 86519, "", "=q3=Wind-Reaver's Dagger of Quick Strikes", "=ds=#h1#, #w4#"};
				{ 27, 0, "inv_box_04", "=q6="..BabbleRare["Glinting Rapana Whelk"], "=ds="};
				{ 28, 86529, "", "=q3=Manipulator's Talisman", "=ds=#s14#"};
			};
		};
		info = {
			name = ALIL["Townlong Steppes"].." / "..ALIL["Dread Wastes"],
			module = moduleName, menu = "RAREMENU",
		};
	}

	----------------
	--- Factions ---
	----------------

		-------------------
		--- The Anglers ---
		-------------------

	AtlasLoot_Data["Anglers"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_anglers", "=q6=#r2#", ""};
				{ 2, 85505, "", "=q2=Recipe: Krasarang Fritters", "=ds=#p3# (525)", "=ds=5 #gold#"};
				{ 3, 85502, "", "=q2=Recipe: Viseclaw Soup", "=ds=#p3# (525)", "=ds=5 #gold#"};
				{ 5, 0, "achievement_faction_anglers", "=q6=#r3#", ""};
				{ 6, 85447, "", "=q3=Tiny Goldfish", "=ds=#e13#", "=ds=250 #gold#"};
				{ 7, 84660, "", "=q2=Pandaren Fishing Pole", "=ds=#e20#", "=ds=25 #gold#"};
				{ 9, 0, "achievement_faction_anglers", "=q6=#r4#", ""};
				{ 10, 85500, "", "=q3=Anglers Fishing Raft", "=ds=#p24# (525)", "=ds=1,000 #gold#"};
				{ 11, 107950, "", "=q3=Bipsi's Bobbing Berg", "=ds=#p24# (525), =q1=#m1# =ds=#c3#", "=ds=1,000 #gold#"};
				{ 12, 84661, "", "=q3=Dragon Fishing Pole", "=ds=#e20#", "=ds=500 #gold#"};
				{ 13, 88535, "", "=q3=Sharpened Tuskarr Spear", "=ds=#h3#", "=ds=1,500 #gold#"};
				{ 14, 93225, "", "=q7=Grand Commendation of the Anglers", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "achievement_faction_anglers", "=q6=#r5#", ""};
				{ 17, 81354, "", "=q4=Reins of the Azure Water Strider", "=ds=#e12#", "=ds=5,000 #gold#"};
				{ 18, 89401, "", "=q3=Anglers Tabard", "=ds=#s7#", "=ds=10 #gold#"};
				{ 20, 0, "inv_fishingpole_01", "=q6="..ALIL["Nat Pagle"], "=q5=#r4#"};
				{ 21, 88563, "", "=q7=Nat's Fishing Journal", "=ds=#m2#", "=ds=1,000 #gold#"};
				{ 23, 0, "inv_fishingpole_01", "=q6="..ALIL["Nat Pagle"], "=q5=#r5#"};
				{ 24, 88710, "", "=q4=Nat's Hat", "=ds=#s1#", "=ds=250 #gold#"};
				{ 26, 0, "inv_fishingpole_01", "=q6="..ALIL["Nat Pagle"], "=q5="..AL["Best Friend"]};
				{ 27, 86596, "", "=q3=Nat's Fishing Chair", "=ds="};
			};
		};
		info = {
			name = ALIL["The Anglers"],
			module = moduleName, menu = "REPMENU",
		};
	}

		-----------------------------
		--- The August Celestials ---
		-----------------------------

	AtlasLoot_Data["AugustCelestials"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_celestials", "=q6=#r3#", ""};
				{ 2, 89124, "", "=q2=Celestial Offering", "=ds=#m20#", "=ds=100 #gold#"};
				{ 4, 0, "achievement_faction_celestials", "=q6=#r4#", ""};
				{ 5, 84561, "", "=q3=Formula: Enchant Bracer - Exceptional Strength", "=ds=#p4# (600)", "=ds=40 #gold#"};
				{ 6, 84557, "", "=q3=Formula: Enchant Bracer - Greater Agility", "=ds=#p4# (600)", "=ds=40 #gold#"};
				{ 7, 84559, "", "=q3=Formula: Enchant Bracer - Super Intellect", "=ds=#p4# (600)", "=ds=40 #gold#"};
				{ 8, 93224, "", "=q7=Grand Commendation of the August Celestials", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "achievement_faction_celestials", "=q6=#r5#", ""};
				{ 17, 89304, "", "=q4=Reins of the Thundering August Cloud Serpent", "=ds=#e27#", "=ds=10,000 #gold#"};
				{ 18, 89799, "", "=q3=August Celestials Tabard", "=ds=#s7#", "=ds=10 #gold#"};
				{ 19, 86377, "", "=q1=Pattern: Royal Satchel", "=ds=#p8# (600)", "=ds=50 #gold#"};
			};
		};
		info = {
			name = ALIL["The August Celestials"],
			module = moduleName, menu = "REPMENU",
		};
	}

		------------------------------------------
		--- Bizmo's Brawlpub / Brawl'gar Arena ---
		------------------------------------------

	AtlasLoot_Data["BizmosBrawlpubBrawlgarArena"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_celestials", "=q6=#r1#", ""};
				{ 2, 92954, "", "=q1=Brawler's Healing Potion", "=ds=#e2#", "1 #gold# 68 #silver#" },
				{ 3, 92941, "", "=q1=Potion of Brawler's Might", "=ds=#e2#", "70 #silver#" },
				{ 4, 92942, "", "=q1=Potion of Brawler's Cunning", "=ds=#e2#", "70 #silver#" },
				{ 5, 92943, "", "=q1=Potion of Brawler's Deftness", "=ds=#e2#", "70 #silver#" },
				{ 6, 93043, "", "=q1=Rotten Apple", "=ds=", "70 #silver#", amount = 5 },
				{ 7, 93044, "", "=q1=Rotten Banana", "=ds=", "70 #silver#", amount = 5 },
				{ 8, 93045, "", "=q1=Rotten Watermelon", "=ds=", "70 #silver#", amount = 5 },
				{ 9, 93158, "", "=q1=Expired Blackout Brew", "=ds=", "70 #silver#", amount = 5 },
				{ 16, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 4), ""};
				{
					{ 17, 95050, "", "=q4=The Brassiest Knuckle", "=ds=#s13#", "5000 #gold#" };
					{ 17, 95051, "", "=q4=The Brassiest Knuckle", "=ds=#s13#", "5000 #gold#" };
				};
				{ 18, 98079, "", "=q3=Floot-Tooter's Tunic", "=ds=#s6#", "#QUESTID:32837#" },
				{ 19, 98081, "", "=q3=The Boomshirt", "=ds=#s6#", "#QUESTID:32841#" },
				{ 20, 98082, "", "=q3=Undisputed Champion's Shirt", "=ds=#s6#", "#QUESTID:32859#" },
				{ 21, 93025, "", "=q1=Clock'em", "=ds=#e13#", "21 #silver#" },
				{ 23, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 5), ""};
				{ 24, 98084, "", "=q3=Ooze-Soaked Shirt", "=ds=#s6#", "#QUESTID:32845#" },
				{ 25, 98083, "", "=q3=Sharkskin Tunic", "=ds=#s6#", "#QUESTID:32843#" },
				{ 26, 98086, "", "=q3=Tuxedo-Like Shirt", "=ds=#s6#", "#QUESTID:32849#" },
				{ 28, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 6), ""};
				{ 29, 98085, "", "=q3=Brucehide Jersey", "=ds=#s6#", "#QUESTID:32847#" },
				{ 30, 98091, "", "=q3=Last Season's Shirt", "=ds=#s6#", "#QUESTID:32851#" },
			};
			{
				{ 1, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 7), ""};
				{ 2, 98080, "", "=q3=Gorgeous Blouse", "=ds=#s6#", "#QUESTID:32839#" },
				{ 3, 98087, "", "=q3=Paper Shirt", "=ds=#s6#", "#QUESTID:32857#" },
				{
					{ 4, 93228, "", "=q1=Brawler's Pass", "#ACHIEVEMENTID:7939#","" },
					{ 4, 93195, "", "=q1=Brawler's Pass", "#ACHIEVEMENTID:7940#", "" },
				};
				{ 6, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 8), ""};
				{ 7, 93858, "", "=q7=Brawler's Bladed Claws", "=ds=#h1#, #w13#", "#JUSTICE:870# #ITEM:92948:1#" },
				{ 8, 92948, "", "=q7=Brawler's Razor Claws", "=ds=#h1#, #w13#", "#JUSTICE:2175#" },
				{ 16, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 9), ""};
				{
					{ 17, 98543, "", "=q4=Wraps of the Blood-Soaked Brawler", "=ds=#s6#", "#ACHIEVEMENTID:8343#" },
					{ 17, 98543, "", "=q4=Wraps of the Blood-Soaked Brawler", "=ds=#s6#", "#ACHIEVEMENTID:8340#" },
				};
				{ 18, 98092, "", "=q3=Digmaster's Bodysleeve", "=ds=#s6#", "#QUESTID:32853#" },
				{ 19, 98093, "", "=q3=Sightless Mantle", "=ds=#s6#", "#QUESTID:32855#" },
				{
					{ 20, 93228, "", "=q1=Brawler's Pass", "#ACHIEVEMENTID:8337#","" },
					{ 20, 93195, "", "=q1=Brawler's Pass", "#ACHIEVEMENTID:8335#", "" },
				};
				{ 22, 0, "achievement_faction_celestials", "=q6="..string.format(AL["Rank %d"], 10), ""};
				{ 23, 98405, "", "=q4=Brawler's Burly Mushan Beast", "=ds=#e26#", "1500 #gold#" },
			};
		};
		info = {
			name = ALIL["Bizmo's Brawlpub"].." / "..ALIL["Brawl'gar Arena"],
			module = moduleName, menu = "REPMENU",
		};
	}

		---------------------------
		--- Dominance Offensive ---
		---------------------------

	AtlasLoot_Data["DominanceOffensive"] = {
		["Normal"] = {
			{
				{ 1, 0, "pvpcurrency-honor-horde", "=q6=#r4#", ""};
				{ 2, 93232, "", "=q7=Grand Commendation of the Dominance Offensive", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "pvpcurrency-honor-horde", "=q6=#r5#", ""};
				{ 17, 93169, "", "=q4=Grand Armored Wyvern", "=ds=#e27#", "=ds=2,000 #gold#"};
			};
		};
		info = {
			name = ALIL["Dominance Offensive"],
			module = moduleName, menu = "REPMENU",
		};
	}

		-----------------------
		--- Emperor Shaohao ---
		-----------------------

	AtlasLoot_Data["EmperorShaohao"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_monk_quipunch", "=q6=#r2#", ""};
				{ 2, 103683, "", "=q3=Mask of Anger", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 3, 103681, "", "=q3=Mask of Doubt", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 4, 103679, "", "=q3=Mask of Fear", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 5, 103680, "", "=q3=Mask of Hatred", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 6, 103682, "", "=q3=Mask of Violence", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 8, 0, "ability_monk_quipunch", "=q6=#r3#", ""};
				{ 9, 104014, "", "=q4=Pouch of Timeless Coins", "=ds=#m17#", "#VALOR:500#"};
				{ 10, 103678, "", "=q4=Time-Lost Artifact", "=ds=#s14#", "#TIMELESSCOIN:7500#"};
				{ 11, 103684, "", "=q3=Scroll of Challenge", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 16, 0, "ability_monk_quipunch", "=q6=#r4#", ""};
				{ 17, 103685, "", "=q3=Celestial Defender's Medallion", "=ds=#m20#", "#TIMELESSCOIN:2500#"};
				{ 18, 104295, "", "=q3=Harmonious Porcupette", "=ds=#e13#", "#TIMELESSCOIN:7500#"};
				{ 20, 0, "ability_monk_quipunch", "=q6=#r5#", ""};
				{ 21, 87774, "", "=q4=Reins of the Heavenly Golden Cloud Serpent", "=ds=#e27#", "#TIMELESSCOIN:100000#"};
			};
		};
		info = {
			name = ALIL["Emperor Shaohao"],
			module = moduleName, menu = "REPMENU",
		};
	}

		--------------------
		--- Golden Lotus ---
		--------------------

	AtlasLoot_Data["GoldenLotus"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_goldenlotus", "=q6=#r3#", ""};
				{ 2, 90615, "", "=q3=Burning Mark of the Golden Lotus", "=ds=#s13#", "=q1=#m4#: #QUESTID:30639#"};
				{ 3, 90614, "", "=q3=Delicate Mark of the Golden Lotus", "=ds=#s13#", "=q1=#m4#: #QUESTID:30639#"};
				{ 4, 90618, "", "=q3=Durable Mark of the Golden Lotus", "=ds=#s13#", "=q1=#m4#: #QUESTID:30639#"};
				{ 5, 90617, "", "=q3=Ferocious Mark of the Golden Lotus", "=ds=#s13#", "=q1=#m4#: #QUESTID:30639#"};
				{ 6, 90616, "", "=q3=Mending Mark of the Golden Lotus", "=ds=#s13#", "=q1=#m4#: #QUESTID:30639#"};
				{ 7, 86235, "", "=q1=Pattern: Angerhide Leg Armor", "=ds=#p7# (575)", "=ds=25 #gold#"};
				{ 8, 86276, "", "=q1=Pattern: Ironscale Leg Armor", "=ds=#p7# (575)", "=ds=25 #gold#"};
				{ 9, 86295, "", "=q1=Pattern: Shadowleather Leg Armor", "=ds=#p7# (575)", "=ds=25 #gold#"};
				{ 10, 86237, "", "=q1=Pattern: Chestguard of Earthen Harmony", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 11, 86273, "", "=q1=Pattern: Gloves of Earthen Harmony", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 12, 86274, "", "=q1=Pattern: Greyshadow Chestguard", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 13, 86275, "", "=q1=Pattern: Greyshadow Gloves", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 14, 86278, "", "=q1=Pattern: Lifekeeper's Robe", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 15, 86277, "", "=q1=Pattern: Lifekeeper's Gloves", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 16, 86309, "", "=q1=Pattern: Wildblood Vest", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 17, 86308, "", "=q1=Pattern: Wildblood Gloves", "=ds=#p7# (600)", "=ds=50 #gold#"};
				{ 18, 86376, "", "=q1=Pattern: Greater Cerulean Spellthread", "=ds=#p8# (575)", "=ds=25 #gold#"};
				{ 19, 86375, "", "=q1=Pattern: Greater Pearlescent Spellthread", "=ds=#p8# (575)", "=ds=25 #gold#"};
				{ 20, 86370, "", "=q1=Pattern: Robes of Creation", "=ds=#p8# (600)", "=ds=50 #gold#"};
				{ 21, 86371, "", "=q1=Pattern: Gloves of Creation", "=ds=#p8# (600)", "=ds=50 #gold#"};
				{ 22, 86368, "", "=q1=Pattern: Spelltwister's Grand Robe", "=ds=#p8# (600)", "=ds=50 #gold#"};
				{ 23, 86369, "", "=q1=Pattern: Spelltwister's Gloves", "=ds=#p8# (600)", "=ds=50 #gold#"};
			};
			{
				{ 1, 0, "achievement_faction_goldenlotus", "=q6=#r4#", ""};
				{ 2, 90607, "", "=q3=Burning Robes of the Golden Lotus", "=ds=#s5#, #a1#", "=q1=#m4#: #QUESTID:30642#"};
				{ 3, 90609, "", "=q3=Mending Robes of the Golden Lotus", "=ds=#s5#, #a1#", "=q1=#m4#: #QUESTID:30642#"};
				{ 4, 90597, "", "=q3=Delicate Chestguard of the Golden Lotus", "=ds=#s5#, #a2#", "=q1=#m4#: #QUESTID:30642#"};
				{ 5, 90599, "", "=q3=Warming Chestguard of the Golden Lotus", "=ds=#s5#, #a2#", "=q1=#m4#: #QUESTID:30642#"};
				{ 6, 90598, "", "=q3=Crackling Chain of the Golden Lotus", "=ds=#s5#, #a3#", "=q1=#m4#: #QUESTID:30642#"};
				{ 7, 90602, "", "=q3=Deadeye Chain of the Golden Lotus", "=ds=#s5#, #a3#", "=q1=#m4#: #QUESTID:30642#"};
				{ 8, 90601, "", "=q3=Bonded Plate of the Golden Lotus", "=ds=#s5#, #a4#", "=q1=#m4#: #QUESTID:30642#"};
				{ 9, 90603, "", "=q3=Durable Plate of the Golden Lotus", "=ds=#s5#, #a4#", "=q1=#m4#: #QUESTID:30642#"};
				{ 10, 90600, "", "=q3=Ferocious Plate of the Golden Lotus", "=ds=#s5#, #a4#", "=q1=#m4#: #QUESTID:30642#"};
				{ 11, 93215, "", "=q7=Grand Commendation of the Golden Lotus", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "achievement_faction_goldenlotus", "=q6=#r5#", ""};
				{ 17, 90596, "", "=q4=Burning Necklace of the Golden Lotus", "=ds=#s2#", "=q1=#m4#: #QUESTID:30646#"};
				{ 18, 90593, "", "=q4=Delicate Necklace of the Golden Lotus", "=ds=#s2#", "=q1=#m4#: #QUESTID:30646#"};
				{ 19, 90594, "", "=q4=Durable Necklace of the Golden Lotus", "=ds=#s2#", "=q1=#m4#: #QUESTID:30646#"};
				{ 20, 90592, "", "=q4=Ferocious Necklace of the Golden Lotus", "=ds=#s2#", "=q1=#m4#: #QUESTID:30646#"};
				{ 21, 90595, "", "=q4=Mending Necklace of the Golden Lotus", "=ds=#s2#", "=q1=#m4#: #QUESTID:30646#"};
				{ 22, 87781, "", "=q4=Reins of the Azure Riding Crane", "=ds=#e26#", "=ds=500 #gold#"};
				{ 23, 87782, "", "=q4=Reins of the Golden Riding Crane", "=ds=#e26#", "=ds=2,500 #gold#"};
				{ 24, 87783, "", "=q4=Reins of the Regal Riding Crane", "=ds=#e26#", "=ds=1,500 #gold#"};
				{ 25, 89797, "", "=q3=Golden Lotus Tabard", "=ds=#s7#", "=ds=10 #gold#"};
			};
		};
		info = {
			name = ALIL["Golden Lotus"],
			module = moduleName, menu = "REPMENU",
		};
	}

		---------------------------
		--- Kirin Tor Offensive ---
		---------------------------

	AtlasLoot_Data["KirinTorOffensive"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_reputation_kirintor_offensive", "=q6=#r2#", ""};
				{ 2, 80433, "", "=q3=Blood Spirit", "=ds=#e8#", "#VALOR:400#"};
				{ 3, 95489, "", "=q3=Kirin Tor Offensive Insignia", "=ds=", "#HISTORICALPARCHMENTS:1#"};
				{ 4, 95490, "", "=q3=Greater Kirin Tor Offensive Insignia", "=ds=", "#HISTORICALPARCHMENTS:10#"};
				{ 5, 95567, "", "=q1=Kirin Tor Beacon", "=ds=", "=ds=25 #gold#"};
				{ 6, 95054, "", "=q1=Potion of Light Steps", "=ds=", "#ELDERCHARM:1#"};
				{ 8, 0, "achievement_reputation_kirintor_offensive", "=q6=#r3#", ""};
				{ 9, 95532, "", "=q4=Belt of Loa Charms", "=ds=#s10#, #a1#", "=ds=300 #gold#"};
				{ 10, 95527, "", "=q4=Pain-Binder Girdle", "=ds=#s10#, #a1#", "=ds=300 #gold#"};
				{ 11, 95526, "", "=q4=Shan'ze Scholar's Girdle", "=ds=#s10#, #a1#", "=ds=300 #gold#"};
				{ 12, 95530, "", "=q4=Cinch of the Dead Forest's Vigil", "=ds=#s10#, #a2#", "=ds=300 #gold#"};
				{ 13, 95528, "", "=q4=Skumblade-Tooth Girdle", "=ds=#s10#, #a2#", "=ds=300 #gold#"};
				{ 14, 95531, "", "=q4=Rotting Bog Cinch", "=ds=#s10#, #a3#", "=ds=300 #gold#"};
				{ 15, 95534, "", "=q4=Skumblade Ritualist Links", "=ds=#s10#, #a3#", "=ds=300 #gold#"};
				{ 16, 95529, "", "=q4=Girdle of Shan'ze Glory", "=ds=#s10#, #a4#", "=ds=300 #gold#"};
				{ 17, 95533, "", "=q4=Thunder Caressed Waistguard", "=ds=#s10#, #a4#", "=ds=300 #gold#"};
				{ 18, 95053, "", "=q1=A Common Rock", "=ds=", "#ELDERCHARM:1#", amount = 2};
				{ 19, 95093, "", "=q1=Sleep Dust", "=ds=", "#ELDERCHARM:1#"};
				{ 21, 0, "achievement_reputation_kirintor_offensive", "=q6=#r4#", ""};
				{ 22, 95545, "", "=q7=Grand Commendation of the Kirin Tor Offensive", "=ds=", "=ds=50 #gold#"};
				{ 23, 95052, "", "=q1=Arcane Propellant", "=ds=", "#ELDERCHARM:1#", amount = 2};
				{ 24, 95055, "", "=q1=Frost Rune Trap", "=ds=", "#ELDERCHARM:1#"};
			};
			{
				{ 1, 0, "achievement_reputation_kirintor_offensive", "=q6=#r5#", ""};
				{ 2, 95564, "", "=q4=Reins of the Golden Primal Direhorn", "=ds=#e26#", "=ds=3000 #gold#"};
				{ 3, 95589, "", "=q3=Glorious Standard of the Kirin Tor Offensive", "=ds=", "=q1=#m4#: #QUESTID:32599#"};
				{ 4, 95591, "", "=q3=Kirin Tor Offensive Tabard", "=ds=#s7#", "=ds=10 #gold#"};
				{ 5, 95056, "", "=q1=Polymorphic Key", "=ds=", "#ELDERCHARM:3#"};
				{ 6, 98558, "", "=q1=Empty Supply Crate", "=ds=", "#ELDERCHARM:3#"};
				{ 7, 98560, "", "=q1=Arcane Trove", "=ds=", "#ELDERCHARM:15#"};
			};
		};
		info = {
			name = ALIL["Kirin Tor Offensive"],
			module = moduleName, menu = "REPMENU",
		};
	}

		------------------
		--- The Klaxxi ---
		------------------

	AtlasLoot_Data["Klaxxi"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_klaxxi", "=q6=#r3#", ""};
				{ 2, 89230, "", "=q1=Restorative Amber", "=ds=#e18#", "=ds=10 #gold#"};
				{ 3, 90531, "", "=q1=Plans: Ghost Iron Shield Spike", "=ds=#p2# (540)", "=ds=20 #kyparite#"};
				{ 4, 90532, "", "=q1=Plans: Living Steel Weapon Chain", "=ds=#p2# (540)", "=ds=20 #kyparite#"};
				{ 5, 84197, "", "=q1=Plans: Masterwork Forgewire Axe", "=ds=#p2# (575)", "=ds=20 #kyparite#"};
				{ 6, 84198, "", "=q1=Plans: Masterwork Ghost Shard", "=ds=#p2# (575)", "=ds=20 #kyparite#"};
				{ 7, 84200, "", "=q1=Plans: Masterwork Ghost-Forged Blade", "=ds=#p2# (575)", "=ds=20 #kyparite#"};
				{ 8, 84217, "", "=q1=Plans: Masterwork Phantasmal Hammer", "=ds=#p2# (575)", "=ds=20 #kyparite#"};
				{ 9, 84218, "", "=q1=Plans: Masterwork Spiritblade Decimator", "=ds=#p2# (575)", "=ds=20 #kyparite#"};
				{ 10, 83791, "", "=q1=Plans: Breastplate of Ancient Steel", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 11, 83792, "", "=q1=Plans: Gauntlets of Ancient Steel", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 12, 83787, "", "=q1=Plans: Ghost Reaver's Breastplate", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 13, 83788, "", "=q1=Plans: Ghost Reaver's Gauntlets", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 14, 84196, "", "=q1=Plans: Living Steel Belt Buckle", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 15, 83789, "", "=q1=Plans: Living Steel Breastplate", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 16, 83790, "", "=q1=Plans: Living Steel Gauntlets", "=ds=#p2# (600)", "=ds=20 #kyparite#"};
				{ 18, 0, "achievement_faction_klaxxi", "=q6=#r4#", ""};
				{ 19, 92522, "", "=q7=Grand Commendation of the Klaxxi", "=ds=", "=ds=45 #gold#"};
			};
			{
				{ 1, 0, "achievement_faction_klaxxi", "=q6=#r5#", ""};
				{ 2, 90862, "", "=q4=Seal of the Bloodseeker", "=ds=#s13#", "=q1=#m4#: #QUESTID:31612#"};
				{ 3, 90859, "", "=q4=Seal of the Lucid", "=ds=#s13#", "=q1=#m4#: #QUESTID:31612#"};
				{ 4, 90858, "", "=q4=Seal of the Prime", "=ds=#s13#", "=q1=#m4#: #QUESTID:31612#"};
				{ 5, 90860, "", "=q4=Seal of the Unscathed", "=ds=#s13#", "=q1=#m4#: #QUESTID:31612#"};
				{ 6, 90861, "", "=q4=Seal of the Windreaver", "=ds=#s13#", "=q1=#m4#: #QUESTID:31612#"};
				{ 7, 85262, "", "=q4=Reins of the Amber Scorpion", "=ds=#e26#", "=ds=10,000 #gold#"};
				{ 8, 89393, "", "=q3=Amber Slicer of Klaxxi-vess", "=ds=#h1#, #w4#", "=ds=169 #gold# 8 #silver# 72 #copper#"};
				{ 9, 89392, "", "=q3=Amber Spine of Klaxxi-vess", "=ds=#h1#, #w4#", "=ds=168 #gold# 47 #silver# 70 #copper#"};
				{ 10, 89396, "", "=q3=Amber Espada of Klaxxi-vess", "=ds=#h1#, #w10#", "=ds=170 #gold# 90 #silver# 16 #copper#"};
				{ 11, 89397, "", "=q3=Amber Saber of Klaxxi-vess", "=ds=#h1#, #w10#", "=ds=159 #gold# 37 #silver# 18 #copper#"};
				{ 12, 89398, "", "=q3=Amber Flammard of Klaxxi-vess", "=ds=#h2#, #w10#", "=ds=199 #gold# 97 #silver# 76 #copper#"};
				{ 13, 89400, "", "=q3=Amber Sledge of Klaxxi-vess", "=ds=#h1#, #w6#", "=ds=161 #gold# 18 #silver# 62 #copper#"};
				{ 14, 89394, "", "=q3=Amber Spear of Klaxxi-vess", "=ds=#w7#", "=ds=212 #gold# 12 #silver# 20 #copper#"};
				{ 15, 89395, "", "=q3=Amber Scythe of Klaxxi-vess", "=ds=#w9#", "=ds=212 #gold# 88 #silver# 48 #copper#"};
				{ 16, 89399, "", "=q3=Amber Sprayer of Klaxxi-vess", "=ds=#w5#", "=ds=120 #gold# 44 #silver# 43 #copper#"};
				{ 17, 89798, "", "=q3=Klaxxi Tabard", "=ds=#s7#", "=ds=10 #gold#"};
			};
		};
		info = {
			name = ALIL["The Klaxxi"],
			module = moduleName, menu = "REPMENU",
		};
	}

		-----------------------
		--- The Lorewalkers ---
		-----------------------

	AtlasLoot_Data["Lorewalkers"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_lorewalkers", "=q6=#r4#", ""};
				{ 2, 93230, "", "=q7=Grand Commendation of the Lorewalkers", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "achievement_faction_lorewalkers", "=q6=#r5#", ""};
				{ 17, 89363, "", "=q3=Disc of the Red Flying Cloud", "=ds=#e27#", "=ds=600 #gold#"};
				{ 18, 89795, "", "=q3=Lorewalkers Tabard", "=ds=#s7#", "=ds=10 #gold#"};
				{ 19, 87548, "", "=q2=Lorewalker's Lodestone", "=ds=#m20#"};
				{ 20, 87549, "", "=q2=Lorewalker's Map", "=ds=#m20#"};
			};
		};
		info = {
			name = ALIL["The Lorewalkers"],
			module = moduleName, menu = "REPMENU",
		};
	}

		-----------------------------
		--- Operation: Shieldwall ---
		-----------------------------

	AtlasLoot_Data["OperationShieldwall"] = {
		["Normal"] = {
			{
				{ 1, 0, "pvpcurrency-honor-alliance", "=q6=#r4#", ""};
				{ 2, 93231, "", "=q7=Grand Commendation of Operation: Shieldwall", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "pvpcurrency-honor-alliance", "=q6=#r5#", ""};
				{ 17, 93168, "", "=q4=Grand Armored Gryphon", "=ds=#e27#", "=ds=2,000 #gold#"};
			};
		};
		info = {
			name = ALIL["Operation: Shieldwall"],
			module = moduleName, menu = "REPMENU",
		};
	}
		----------------------------------
		--- Order of the Cloud Serpent ---
		----------------------------------

	AtlasLoot_Data["OrderCloudSerpent"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_serpentriders", "=q6=#r3#", ""};
				{ 2, 83845, "", "=q1=Design: Jade Panther", "=ds=#p12# (600)", "=ds=200 #gold#"};
				{ 3, 83830, "", "=q1=Design: Sunstone Panther", "=ds=#p12# (600)", "=ds=200 #gold#"};
				{ 5, 0, "achievement_faction_serpentriders", "=q6=#r4#", ""};
				{ 6, 83931, "", "=q1=Design: Ruby Panther", "=ds=#p12# (600)", "=ds=200 #gold#"};
				{ 7, 83932, "", "=q1=Design: Sapphire Panther", "=ds=#p12# (600)", "=ds=200 #gold#"};
				{ 8, 89222, "", "=q1=Cloud Ring", "=ds=#m20#", "=ds=1,000 #gold#"};
				{ 9, 89225, "", "=q1=Finish Line", "=ds=#m20#", "=ds=100 #gold#"};
				{ 10, 89227, "", "=q1=Floating Finish Line", "=ds=#m20#", "=ds=100 #gold#"};
				{ 11, 89224, "", "=q1=Floating Racing Flag", "=ds=#m20#", "=ds=25 #gold#"};
				{ 12, 89223, "", "=q1=Racing Flag", "=ds=#m20#", "=ds=25 #gold#"};
				{ 13, 93229, "", "=q7=Grand Commendation of the Order of the Cloud Serpent", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "achievement_faction_serpentriders", "=q6=#r5#", ""};
				{ 17, 85430, "", "=q4=Reins of the Azure Cloud Serpent", "=ds=#e27#", "=ds=3,000 #gold#"};
				{ 18, 85429, "", "=q4=Reins of the Golden Cloud Serpent", "=ds=#e27#", "=ds=3,000 #gold#"};
				{ 19, 79802, "", "=q4=Reins of the Jade Cloud Serpent", "=ds=#e27#", "=ds=3,000 #gold#"};
				{ 20, 89796, "", "=q3=Order of the Cloud Serpent Tabard", "=ds=#s7#", "=ds=10 #gold#"};
				{ 21, 83877, "", "=q1=Design: Jeweled Onyx Panther", "=ds=#p12# (600)", "=ds=200 #gold#"};
			};
		};
		info = {
			name = ALIL["Order of the Cloud Serpent"],
			module = moduleName, menu = "REPMENU",
		};
	}

		-----------------
		--- Shado-Pan ---
		-----------------

	AtlasLoot_Data["ShadoPan"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_shadopan", "=q6=#r3#", ""};
				{ 2, 89302, "", "=q1=Stack of Bamboo", "=ds=#e18#", "=ds=25 #gold#"};
				{ 3, 89303, "", "=q1=Stack of Stone Blocks", "=ds=#e18#", "=ds=40 #gold#"};
				{ 4, 89301, "", "=q1=Stack of Wooden Boards", "=ds=#e18#", "=ds=10 #gold#"};
				{ 6, 0, "achievement_faction_shadopan", "=q6=#r4#", ""};
				{ 7, 84584, "", "=q3=Formula: Enchant Weapon - Dancing Steel", "=ds=#p4# (600)", "=ds=40 #gold#"};
				{ 8, 84583, "", "=q3=Formula: Enchant Weapon - Jade Spirit", "=ds=#p4# (600)", "=ds=40 #gold#"};
				{ 9, 84580, "", "=q3=Formula: Enchant Weapon - River's Song", "=ds=#p4# (600)", "=ds=40 #gold#"};
				{ 10, 93220, "", "=q7=Grand Commendation of the Shado-Pan", "=ds=", "=ds=45 #gold#"};
				{ 16, 0, "achievement_faction_shadopan", "=q6=#r5#", ""};
				{ 17, 89307, "", "=q4=Reins of the Blue Shado-Pan Riding Tiger", "=ds=#e26#", "=ds=500 #gold#"};
				{ 18, 89305, "", "=q4=Reins of the Green Shado-Pan Riding Tiger", "=ds=#e26#", "=ds=1,500 #gold#"};
				{ 19, 89306, "", "=q4=Reins of the Red Shado-Pan Riding Tiger", "=ds=#e26#", "=ds=2,500 #gold#"};
				{ 20, 87768, "", "=q4=Reins of the Onyx Cloud Serpent", "=ds=#e27#", "=q1=#m4#: #QUESTID:31277#"};
				{ 21, 89801, "", "=q3=Replica Shado-Pan Helmet", "=ds=#s1#, #a1#", "=ds=18 #gold# 69 #silver# 42 #copper#"};
				{ 22, 90844, "", "=q3=Replica Shado-Pan Helmet", "=ds=#s1#, #a2#", "=ds=17 #gold# 73 #silver# 80 #copper#"};
				{ 23, 90845, "", "=q3=Replica Shado-Pan Helmet", "=ds=#s1#, #a3#", "=ds=17 #gold# 80 #silver# 64 #copper#"};
				{ 24, 90846, "", "=q3=Replica Shado-Pan Helmet", "=ds=#s1#, #a4#", "=ds=17 #gold# 87 #silver# 30 #copper#"};
				{ 25, 89800, "", "=q3=Shado-Pan Tabard", "=ds=#s7#", "=ds=10 #gold#"};
			};
		};
		info = {
			name = ALIL["Shado-Pan"],
			module = moduleName, menu = "REPMENU",
		};
	}

		---------------------------
		--- Shado-Pan Assault ---
		---------------------------

	AtlasLoot_Data["ShadoPanAssault"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_shadopan", "=q6=#r1#", ""};
				{ 2, 95146, "", "=q4=Destroyer's Battletags", "=ds=#s2#", "#VALOR:825#" },
				{ 3, 95143, "", "=q4=Flanker's Battletags", "=ds=#s2#", "#VALOR:825#" },
				{ 4, 95145, "", "=q4=Mender's Battletags", "=ds=#s2#", "#VALOR:825#" },
				{ 5, 95142, "", "=q4=Striker's Battletags", "=ds=#s2#", "#VALOR:825#" },
				{ 6, 95144, "", "=q4=Vanguard's Battletags", "=ds=#s2#", "#VALOR:825#" },
				{ 8, 0, "achievement_faction_shadopan", "=q6=#r2#", ""};
				{ 9, 95118, "", "=q4=Dreamweaver Drape", "=ds=#s4#", "#VALOR:825#" },
				{ 10, 95116, "", "=q4=Longshot Forestcloak", "=ds=#s4#", "#VALOR:825#" },
				{ 11, 95115, "", "=q4=Many-Layered Scalecloak", "=ds=#s4#", "#VALOR:825#" },
				{ 12, 95117, "", "=q4=Shadowspike Cloak", "=ds=#s4#", "#VALOR:825#" },
				{ 13, 95114, "", "=q4=Spikeshard Greatcloak", "=ds=#s4#", "#VALOR:825#" },
				{ 16, 0, "achievement_faction_shadopan", "=q6=#r2#", ""};
				{ 17, 95081, "", "=q4=Fire Support Robes", "=ds=#s5#, #a1#", "#VALOR:1485#" },
				{ 18, 95082, "", "=q4=Robes of Misty Bindings", "=ds=#s5#, #a1#", "#VALOR:1485#" },
				{ 19, 95078, "", "=q4=Raiment of Silent Stars", "=ds=#s5#, #a2#", "#VALOR:1485#" },
				{ 20, 95077, "", "=q4=Roofstalker Shadowwrap", "=ds=#s5#, #a2#", "#VALOR:1485#" },
				{ 21, 95079, "", "=q4=Carapace of Segmented Scale", "=ds=#s5#, #a3#", "#VALOR:1485#" },
				{ 22, 95080, "", "=q4=Skinsealer Tunic", "=ds=#s5#, #a3#", "#VALOR:1485#" },
				{ 23, 95076, "", "=q4=Breastplate of Brutal Strikes", "=ds=#s5#, #a4#", "#VALOR:1485#" },
				{ 24, 95075, "", "=q4=Gianttooth Chestplate", "=ds=#s5#, #a4#", "#VALOR:1485#" },
				{ 25, 95074, "", "=q4=Hauberk of Gleaming Fire", "=ds=#s5#, #a4#", "#VALOR:1485#" },

			};
			{
				{ 1, 0, "achievement_faction_shadopan", "=q6=#r2#", ""};
				{ 2, 95135, "", "=q4=Bracers of Shielding Thought", "=ds=#s8#, #a1#", "#VALOR:825#" },
				{ 3, 95136, "", "=q4=Troll-Burner Bracers", "=ds=#s8#, #a1#", "#VALOR:825#" },
				{ 4, 95134, "", "=q4=Hearthfire Armwraps", "=ds=#s8#, #a2#", "#VALOR:825#" },
				{ 5, 95133, "", "=q4=Willow-Weave Armbands", "=ds=#s8#, #a2#", "#VALOR:825#" },
				{ 6, 95131, "", "=q4=Powderburn Bracers", "=ds=#s8#, #a3#", "#VALOR:825#" },
				{ 7, 95132, "", "=q4=Spiritcaller Cuffs", "=ds=#s8#, #a3#", "#VALOR:825#" },
				{ 8, 95129, "", "=q4=Axebinder Wristguards", "=ds=#s8#, #a4#", "#VALOR:825#" },
				{ 9, 95128, "", "=q4=Bonecrusher Bracers", "=ds=#s8#, #a4#", "#VALOR:825#" },
				{ 10, 95130, "", "=q4=Softscar Armplates", "=ds=#s8#, #a4#", "#VALOR:825#" },
				{ 17, 95106, "", "=q4=Flameweaver Handwraps", "=ds=#s9#, #a1#", "#VALOR:1155#" },
				{ 18, 95105, "", "=q4=Ghostbinder Grips", "=ds=#s9#, #a1#", "#VALOR:1155#" },
				{ 19, 95108, "", "=q4=Daggerfinger Clutches", "=ds=#s9#, #a2#", "#VALOR:1155#" },
				{ 20, 95107, "", "=q4=Gloves of Enduring Renewal", "=ds=#s9#, #a2#", "#VALOR:1155#" },
				{ 21, 95109, "", "=q4=Gauntlets of the Longbow", "=ds=#s9#, #a3#", "#VALOR:1155#" },
				{ 22, 95112, "", "=q4=Totemshaper Gloves", "=ds=#s9#, #a3#", "#VALOR:1155#" },
				{ 23, 95111, "", "=q4=Bloodstained Skullsqueezers", "=ds=#s9#, #a4#", "#VALOR:1155#" },
				{ 24, 95110, "", "=q4=Stoneward Handguards", "=ds=#s9#, #a4#", "#VALOR:1155#" },
				{ 25, 95113, "", "=q4=Touch of Soothing Mists", "=ds=#s9#, #a4#", "#VALOR:1155#" },
			};
			{
				{ 1, 0, "achievement_faction_shadopan", "=q6=#r2#", ""};
				{ 2, 95090, "", "=q4=Firestrike Cord", "=ds=#s10#, #a1#", "#VALOR:1155#" },
				{ 3, 95091, "", "=q4=Girdle of Glowing Light", "=ds=#s10#, #a1#", "#VALOR:1155#" },
				{ 4, 95088, "", "=q4=Darkfang Belt", "=ds=#s10#, #a2#", "#VALOR:1155#" },
				{ 5, 95089, "", "=q4=Martiean's Splitleaf Girdle", "=ds=#s10#, #a2#", "#VALOR:1155#" },
				{ 6, 95087, "", "=q4=Cracklebite Links", "=ds=#s10#, #a3#", "#VALOR:1155#" },
				{ 7, 95086, "", "=q4=Nightflight Chain", "=ds=#s10#, #a3#", "#VALOR:1155#" },
				{ 8, 95084, "", "=q4=Reinforced Spiritplate Girdle", "=ds=#s10#, #a4#", "#VALOR:1155#" },
				{ 9, 95083, "", "=q4=Swordhook Slingbelt", "=ds=#s10#, #a4#", "#VALOR:1155#" },
				{ 10, 95085, "", "=q4=Waistplate of Channeled Mending", "=ds=#s10#, #a4#", "#VALOR:1155#" },
				{ 17, 95123, "", "=q4=Charfire Leggings", "=ds=#s11#, #a1#", "#VALOR:1485#" },
				{ 18, 95122, "", "=q4=Wisp-Weave Pantaloons", "=ds=#s11#, #a1#", "#VALOR:1485#" },
				{ 19, 95125, "", "=q4=Legguards of Hidden Knives", "=ds=#s11#, #a2#", "#VALOR:1485#" },
				{ 20, 95124, "", "=q4=Trousers of Waning Shadow", "=ds=#s11#, #a2#", "#VALOR:1485#" },
				{ 21, 95127, "", "=q4=Homeguard Leggings", "=ds=#s11#, #a3#", "#VALOR:1485#" },
				{ 22, 95126, "", "=q4=Kilt of Rising Thunder", "=ds=#s11#, #a3#", "#VALOR:1485#" },
				{ 23, 95120, "", "=q4=Legguards of Renewal", "=ds=#s11#, #a4#", "#VALOR:1485#" },
				{ 24, 95119, "", "=q4=Thunderbreaker Legplates", "=ds=#s11#, #a4#", "#VALOR:1485#" },
				{ 25, 95121, "", "=q4=Vaultbreaker Greaves", "=ds=#s11#, #a4#", "#VALOR:1485#" },

			};
			{
				{ 1, 0, "achievement_faction_shadopan", "=q6=#r2#", ""};
				{ 2, 95140, "", "=q4=Band of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#" },
				{ 3, 95141, "", "=q4=Loop of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#" },
				{ 4, 95139, "", "=q4=Ring of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#" },
				{ 5, 95137, "", "=q4=Seal of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#" },
				{ 5, 95138, "", "=q4=Signet of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#" },
				{ 7, 94508, "", "=q4=Brutal Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#" },
				{ 8, 94509, "", "=q4=Soothing Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#" },
				{ 9, 94507, "", "=q4=Steadfast Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#" },
				{ 10, 94511, "", "=q4=Vicious Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#" },
				{ 11, 94510, "", "=q4=Volatile Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#" },
				{ 16, 0, "achievement_faction_shadopan", "=q6=#r5#", ""};
				{ 17, 95102, "", "=q4=Frost-Kissed Shoulderwraps", "=ds=#s3#, #a1#", "=ds=1000 #gold#" },
				{ 18, 95101, "", "=q4=Halo-Graced Mantle", "=ds=#s3#, #a1#", "=ds=1000 #gold#" },
				{ 19, 95096, "", "=q4=Shoulders of Demonic Dreams", "=ds=#s3#, #a1#", "=ds=1000 #gold#" },
				{ 20, 95097, "", "=q4=Heartroot Shoulderguards", "=ds=#s3#, #a2#", "=ds=1000 #gold#" },
				{ 21, 95100, "", "=q4=Wallwalker Spaulders", "=ds=#s3#, #a2#", "=ds=1000 #gold#" },
				{ 22, 95099, "", "=q4=Lightning Strike Mantle", "=ds=#s3#, #a3#", "=ds=1000 #gold#" },
				{ 23, 95095, "", "=q4=Targetblinder Spaulders", "=ds=#s3#, #a3#", "=ds=1000 #gold#" },
				{ 24, 95104, "", "=q4=Shoulderguards of Potentiation", "=ds=#s3#, #a4#", "=ds=1000 #gold#" },
				{ 25, 95098, "", "=q4=Sightblinder Shoulderguards", "=ds=#s3#, #a4#", "=ds=1000 #gold#" },
				{ 26, 95103, "", "=q4=Sparksmasher Pauldrons", "=ds=#s3#, #a4#", "=ds=1000 #gold#" },
				{ 27, 97131, "", "=q3=Shado-Pan Assault Tabard", "=ds=#s7#", "=ds=10 #gold#" };
			};
		};
		info = {
			name = ALIL["Shado-Pan Assault"],
			module = moduleName, menu = "REPMENU",
		};
	}

		---------------------------
		--- Sunreaver Onslaught ---
		---------------------------

	AtlasLoot_Data["SunreaverOnslaught"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_reputation_kirintor_offensive", "=q6=#r2#", ""};
				{ 2, 80433, "", "=q3=Blood Spirit", "=ds=#e8#", "#VALOR:400#"};
				{ 3, 95487, "", "=q3=Sunreaver Onslaught Insignia", "=ds=", "#HISTORICALPARCHMENTS:1#"};
				{ 4, 95488, "", "=q3=Greater Sunreaver Onslaught Insignia", "=ds=", "#HISTORICALPARCHMENTS:10#"};
				{ 5, 97157, "", "=q1=Potion of Light Steps", "=ds=", "#ELDERCHARM:1#"};
				{ 6, 95568, "", "=q1=Sunreaver Beacon", "=ds=", "=ds=25 #gold#"};
				{ 8, 0, "achievement_faction_sunreaveronslaught", "=q6=#r3#", ""};
				{ 9, 95523, "", "=q4=Belt of Loa Charms", "=ds=#s10#, #a1#", "=ds=300 #gold#"};
				{ 10, 95518, "", "=q4=Pain-Binder Girdle", "=ds=#s10#, #a1#", "=ds=300 #gold#"};
				{ 11, 95517, "", "=q4=Shan'ze Scholar's Girdle", "=ds=#s10#, #a1#", "=ds=300 #gold#"};
				{ 12, 95521, "", "=q4=Cinch of the Dead Forest's Vigil", "=ds=#s10#, #a2#", "=ds=300 #gold#"};
				{ 13, 95519, "", "=q4=Skumblade-Tooth Girdle", "=ds=#s10#, #a2#", "=ds=300 #gold#"};
				{ 14, 95522, "", "=q4=Rotting Bog Cinch", "=ds=#s10#, #a3#", "=ds=300 #gold#"};
				{ 15, 95525, "", "=q4=Skumblade Ritualist Links", "=ds=#s10#, #a3#", "=ds=300 #gold#"};
				{ 16, 95520, "", "=q4=Girdle of Shan'ze Glory", "=ds=#s10#, #a4#", "=ds=300 #gold#"};
				{ 17, 95524, "", "=q4=Thunder Caressed Waistguard", "=ds=#s10#, #a4#", "=ds=300 #gold#"};
				{ 18, 97158, "", "=q1=A Common Rock", "=ds=", "#ELDERCHARM:1#", amount = 2};
				{ 19, 97154, "", "=q1=Sleep Dust", "=ds=", "#ELDERCHARM:1#"};
				{ 21, 0, "achievement_faction_sunreaveronslaught", "=q6=#r4#", ""};
				{ 22, 95548, "", "=q7=Grand Commendation of the Sunreaver Onslaught", "=ds=", "=ds=50 #gold#"};
				{ 23, 97159, "", "=q1=Arcane Propellant", "=ds=", "#ELDERCHARM:1#", amount = 2};
				{ 24, 97156, "", "=q1=Frost Rune Trap", "=ds=", "#ELDERCHARM:1#"};
			};
			{
				{ 1, 0, "achievement_faction_sunreaveronslaught", "=q6=#r5#", ""};
				{ 2, 95565, "", "=q4=Reins of the Crimson Primal Direhorn", "=ds=#e26#", "=ds=3000 #gold#"};
				{ 3, 95590, "", "=q3=Glorious Standard of the Sunreaver Onslaught", "=ds=", "=q1=#m4#: #QUESTID:32589#"};
				{ 4, 95592, "", "=q3=Sunreaver Onslaught Tabard", "=ds=#s7#", "=ds=10 #gold#"};
				{ 5, 97155, "", "=q1=Polymorphic Key", "=ds=", "#ELDERCHARM:3#"};
				{ 6, 98559, "", "=q1=Empty Supply Crate", "=ds=", "#ELDERCHARM:3#"};
				{ 7, 98562, "", "=q1=Sunreaver Bounty", "=ds=", "#ELDERCHARM:15#"};
			};
		};
		info = {
			name = ALIL["Sunreaver Onslaught"],
			module = moduleName, menu = "REPMENU",
		};
	}

		-------------------
		--- The Tillers ---
		-------------------

	AtlasLoot_Data["Tillers"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_faction_tillers", "=q6=#r2#", ""};
				{ 2, 79102, "", "=q1=Green Cabbage Seeds", "=ds=", "=ds=15 #silver#"};
				{ 3, 89328, "", "=q1=Jade Squash Seeds", "=ds=", "=ds=15 #silver#"};
				{ 4, 80590, "", "=q1=Juicycrunch Carrot Seeds", "=ds=", "=ds=15 #silver#"};
				{ 5, 80592, "", "=q1=Mogu Pumpkin Seeds", "=ds=", "=ds=15 #silver#"};
				{ 6, 80594, "", "=q1=Pink Turnip Seeds", "=ds=", "=ds=15 #silver#"};
				{ 7, 80593, "", "=q1=Red Blossom Leek Seeds", "=ds=", "=ds=15 #silver#"};
				{ 8, 80591, "", "=q1=Scallion Seeds", "=ds=", "=ds=15 #silver#"};
				{ 9, 89329, "", "=q1=Striped Melon Seeds", "=ds=", "=ds=15 #silver#"};
				{ 10, 80595, "", "=q1=White Turnip Seeds", "=ds=", "=ds=15 #silver#"};
				{ 11, 89326, "", "=q1=Witchberry Seeds", "=ds=", "=ds=15 #silver#"};
				{ 13, 0, "achievement_faction_tillers", "=q6=#r3#", ""};
				{ 14, 85267, "", "=q2=Autumn Blossom Sapling", "=ds=", "=ds=10 #silver#"};
				{ 15, 89812, "", "=q1=\"Jinyu Princess\" Irrigation System", "=ds=#m2#", "=ds=94 #gold# 44 #silver# 44 #copper#"};
				{ 16, 0, "achievement_faction_tillers", "=q6=#r4#", ""};
				{ 17, 89869, "", "=q3=Pandaren Scarecrow", "=ds=", "=ds=236 #gold# 11 #silver# 11 #copper#"};
				{ 18, 85268, "", "=q2=Spring Blossom Sapling", "=ds=", "=ds=10 #silver#"};
				{ 19, 85216, "", "=q1=Enigma Seed", "=ds=", "=ds=1 #gold#"};
				{ 20, 85217, "", "=q1=Magebulb Seed", "=ds=", "=ds=1 #gold#"};
				{ 21, 89202, "", "=q1=Raptorleaf Seed", "=ds=", "=ds=1 #gold#"};
				{ 22, 85215, "", "=q1=Snakeroot Seed", "=ds=", "=ds=1 #gold#"};
				{ 23, 89233, "", "=q1=Songbell Seed", "=ds=", "=ds=1 #gold#"};
				{ 24, 89197, "", "=q1=Windshear Cactus Seed", "=ds=", "=ds=1 #gold#"};
				{ 25, 89813, "", "=q1=\"Thunder King\" Pest Repellers", "=ds=#m2#", "=ds=94 #gold# 44 #silver# 44 #copper#"};
				{ 26, 93226, "", "=q7=Grand Commendation of the Tillers", "=ds=", "=ds=45 #gold#"};
			};
			{
				{ 1, 0, "achievement_faction_tillers", "=q6=#r5#", ""};
				{ 2, 89391, "", "=q4=Reins of the Black Riding Goat", "=ds=#e26#", "=ds=1166 #gold# 66 #silver# 66 #copper#"};
				{ 3, 89362, "", "=q4=Reins of the Brown Riding Goat", "=ds=#e26#", "=ds=388 #gold# 88 #silver# 88 #copper#"};
				{ 4, 89390, "", "=q4=Reins of the White Riding Goat", "=ds=#e26#", "=ds=2527 #gold# 77 #silver# 77 #copper#"};
				{ 5, 90175, "", "=q3=Gin-Ji Knife Set", "=ds=#m20#", "=ds=194 #gold# 44 #silver# 44 #copper#"};
				{ 6, 80914, "", "=q3=Mourning Glory", "=ds=#m20#", "=ds=97 #gold# 22 #silver# 22 #copper#"};
				{ 7, 89784, "", "=q3=Tillers Tabard", "=ds=#s7#", "=ds=7 #gold# 77 #silver# 77 #copper#"};
				{ 8, 74657, "", "=q2=Recipe: Spicy Salmon", "=ds=#p3# (500)", "=ds=77 #silver# 77 #copper#"};
				{ 9, 74658, "", "=q2=Recipe: Spicy Vegetable Chips", "=ds=#p3# (500)", "=ds=77 #silver# 77 #copper#"};
				{ 10, 85269, "", "=q2=Winter Blossom Sapling", "=ds=", "=ds=10 #silver#"};
				{ 11, 95449, "", "=q1=Bag of Enigma Seeds", "=ds=", "=ds=30 #gold#"};
				{ 12, 95451, "", "=q1=Bag of Magebulb Seeds", "=ds=", "=ds=30 #gold#"};
				{ 13, 95457, "", "=q1=Bag of Raptorleaf Seeds", "=ds=", "=ds=30 #gold#"};
				{ 14, 95447, "", "=q1=Bag of Snakeroot Seeds", "=ds=", "=ds=30 #gold#"};
				{ 15, 95445, "", "=q1=Bag of Songbell Seeds", "=ds=", "=ds=30 #gold#"};
				{ 16, 95454, "", "=q1=Bag of Windshear Cactus Seeds", "=ds=", "=ds=30 #gold#"};
				{ 17, 80809, "", "=q1=Bag of Green Cabbage Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 18, 89848, "", "=q1=Bag of Jade Squash Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 19, 84782, "", "=q1=Bag of Juicycrunch Carrot Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 20, 85153, "", "=q1=Bag of Mogu Pumpkin Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 21, 85162, "", "=q1=Bag of Pink Turnip Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 22, 85158, "", "=q1=Bag of Red Blossom Leek Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 23, 84783, "", "=q1=Bag of Scallion Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 24, 89849, "", "=q1=Bag of Striped Melon Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 25, 85163, "", "=q1=Bag of White Turnip Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 26, 89847, "", "=q1=Bag of Witchberry Seeds", "=ds=", "=ds=4 #gold# 50 #silver#"};
				{ 27, 91806, "", "=q1=Unstable Portal Shard", "=ds=", "=ds=3 #gold#"};
				{ 28, 89814, "", "=q1=\"Earth-Slasher\" Master Plow", "=ds=#m2#", "=ds=94 #gold# 44 #silver# 44 #copper#"};
			};
			{
				{ 1, 0, "achievement_faction_tillers", "=q6="..ALIL["Old Hillpaw"], "=q5="..AL["Best Friend"]};
				{ 2, 90893, "", "=q1=Straw Hat", "=ds=#s1#, #a1#", ""};
				{ 3, 90894, "", "=q1=Straw Hat", "=ds=#s1#, #a2#", ""};
				{ 4, 90895, "", "=q1=Straw Hat", "=ds=#s1#, #a3#", ""};
				{ 5, 90896, "", "=q1=Straw Hat", "=ds=#s1#, #a4#", ""};
				{ 7, 0, "achievement_faction_tillers", "=q6="..ALIL["Sho"], "=q5="..AL["Best Friend"]};
				{ 8, 85222, "", "=q3=Red Cricket", "=ds=#e13#", ""};
			};
		};
		info = {
			name = ALIL["The Tillers"],
			module = moduleName, menu = "REPMENU",
		};
	}

		------------------------
		--- Domination Point ---
		------------------------

	AtlasLoot_Data["DominationPoint"] = {
		["Normal"] = {
			{
				{ 1, 91819, "", "=q1=Sturdy Crane Snare", "=ds=", "#LIONSLANDINGCOMMISSION:30#"},
				{ 2, 91821, "", "=q1=Sturdy Tiger Trap", "=ds=", "#LIONSLANDINGCOMMISSION:30#"},
				{ 3, 91822, "", "=q1=Sturdy Crab Crate", "=ds=", "#LIONSLANDINGCOMMISSION:30#"},
				{ 4, 92058, "", "=q1=Portal Fuel: Shrine of Two Moons", "=ds=", "#LIONSLANDINGCOMMISSION:5#"},
				{ 5, 92057, "", "=q1=Portal Fuel: Orgrimmar", "=ds=", "#LIONSLANDINGCOMMISSION:5#"},
				{ 6, 92056, "", "=q1=Portal Fuel: Sparkrocket Outpost", "=ds=", "#LIONSLANDINGCOMMISSION:5#"},
				{ 7, 92049, "", "=q1=Mercenary Contract: Mage", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 8, 92053, "", "=q1=Mercenary Contract: Warrior", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 9, 92052, "", "=q1=Mercenary Contract: Druid", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 10, 92051, "", "=q1=Mercenary Contract: Priest", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 11, 92050, "", "=q1=Mercenary Contract: Paladin", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 12, 92055, "", "=q1=Mercenary Contract: Shaman", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 13, 92054, "", "=q1=Mercenary Contract: Rogue", "=ds=", "#LIONSLANDINGCOMMISSION:10#"},
				{ 14, 92059, "", "=q1=Domination Point Banquet", "=ds=", "#LIONSLANDINGCOMMISSION:30#"},
				{ 15, 92663, "", "=q1=Guard Contract: Outpost", "=ds=", "#LIONSLANDINGCOMMISSION:40#"},
				{ 16, 92421, "", "=q1=Guard Contract: Graveyard", "=ds=", "#LIONSLANDINGCOMMISSION:60#"},
				{ 17, 92422, "", "=q1=Guard Contract: Tower", "=ds=", "#LIONSLANDINGCOMMISSION:80#"},
				{ 18, 92526, "", "=q1=Crate of Horde Banners", "=ds=", "#LIONSLANDINGCOMMISSION:25#"},
				{ 19, 92530, "", "=q1=Box of Overridden Excavationbots", "=ds=", "#LIONSLANDINGCOMMISSION:125#"},
				{ 20, 92528, "", "=q1=Obelisk of Deception", "=ds=", "#LIONSLANDINGCOMMISSION:500#"},
				{ 21, 92527, "", "=q1=Rodent Crate", "=ds=", "#LIONSLANDINGCOMMISSION:2000#"},
			};
		};
		info = {
			name = ALIL["Domination Point"],
			module = moduleName, menu = "REPMENU",
		};
	}

		----------------------
		--- Lion's Landing ---
		----------------------

	AtlasLoot_Data["LionsLanding"] = {
		["Normal"] = {
			{
				{ 1, 91854, "", "=q1=Sturdy Crane Snare", "=ds=", "#DOMINATIONCOMMISSION:30#"},
				{ 2, 91855, "", "=q1=Sturdy Tiger Trap", "=ds=", "#DOMINATIONCOMMISSION:30#"},
				{ 3, 91856, "", "=q1=Sturdy Crab Crate", "=ds=", "#DOMINATIONCOMMISSION:30#"},
				{ 4, 92432, "", "=q1=Portal Reagents: Skyfire", "=ds=", "#DOMINATIONCOMMISSION:5#"},
				{ 5, 92430, "", "=q1=Portal Reagents: Shrine of Seven Stars", "=ds=", "#DOMINATIONCOMMISSION:5#"},
				{ 6, 92431, "", "=q1=Portal Reagents: Stormwind", "=ds=", "#DOMINATIONCOMMISSION:5#"},
				{ 7, 92439, "", "=q1=Mercenary Contract: Mage", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 8, 92435, "", "=q1=Mercenary Contract: Warrior", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 9, 92436, "", "=q1=Mercenary Contract: Druid", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 10, 92437, "", "=q1=Mercenary Contract: Priest", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 11, 92438, "", "=q1=Mercenary Contract: Paladin", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 12, 92433, "", "=q1=Mercenary Contract: Shaman", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 13, 92434, "", "=q1=Mercenary Contract: Rogue", "=ds=", "#DOMINATIONCOMMISSION:10#"},
				{ 14, 92429, "", "=q1=Lion's Landing Banquet", "=ds=", "#DOMINATIONCOMMISSION:30#"},
				{ 15, 92664, "", "=q1=Guard Contract: Outpost", "=ds=", "#DOMINATIONCOMMISSION:40#"},
				{ 16, 92428, "", "=q1=Guard Contract: Graveyard", "=ds=", "#DOMINATIONCOMMISSION:60#"},
				{ 17, 92427, "", "=q1=Guard Contract: Tower", "=ds=", "#DOMINATIONCOMMISSION:80#"},
				{ 18, 92531, "", "=q1=Crate of Alliance Banners", "=ds=", "#DOMINATIONCOMMISSION:25#"},
				{ 19, 92535, "", "=q1=Box of Overridden Excavationbots", "=ds=", "#DOMINATIONCOMMISSION:125#"},
				{ 20, 92533, "", "=q1=Obelisk of Deception", "=ds=", "#DOMINATIONCOMMISSION:500#" },
				{ 21, 92532, "", "=q1=Rodent Crate", "=ds=", "#DOMINATIONCOMMISSION:2000#"},
			};
		};
		info = {
			name = ALIL["Lion's Landing"],
			module = moduleName, menu = "REPMENU",
		};
	}

	-----------
	--- PvP ---
	-----------

		----------------------
		--- PvP Armor Sets ---
		----------------------

	AtlasLoot_Data["PVP90DeathKnight"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="};
				{ 11, 102713, "", "=q4=Prideful Gladiator's Dreadplate Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102652, "", "=q4=Prideful Gladiator's Dreadplate Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102676, "", "=q4=Prideful Gladiator's Dreadplate Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103005, "", "=q4=Prideful Gladiator's Dreadplate Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102651, "", "=q4=Prideful Gladiator's Dreadplate Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="};
				{ 17, 103181, "", "=q4=Grievous Gladiator's Dreadplate Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103183, "", "=q4=Grievous Gladiator's Dreadplate Shoulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103179, "", "=q4=Grievous Gladiator's Dreadplate Chestpiece", "=ds=", "#HONOR:2250#"};
				{ 20, 103180, "", "=q4=Grievous Gladiator's Dreadplate Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 103182, "", "=q4=Grievous Gladiator's Dreadplate Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
				{
				{ 10, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="};
				{ 11, 103378, "", "=q4=Prideful Gladiator's Dreadplate Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103380, "", "=q4=Prideful Gladiator's Dreadplate Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103376, "", "=q4=Prideful Gladiator's Dreadplate Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103377, "", "=q4=Prideful Gladiator's Dreadplate Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103379, "", "=q4=Prideful Gladiator's Dreadplate Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="};
				{ 17, 102910, "", "=q4=Grievous Gladiator's Dreadplate Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102849, "", "=q4=Grievous Gladiator's Dreadplate Shoulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102873, "", "=q4=Grievous Gladiator's Dreadplate Chestpiece", "=ds=", "#HONOR:2250#"};
				{ 20, 102847, "", "=q4=Grievous Gladiator's Dreadplate Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102848, "", "=q4=Grievous Gladiator's Dreadplate Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="};
				{ 2, 103006, "", "=q4=Prideful Gladiator's Dreadplate Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103008, "", "=q4=Prideful Gladiator's Dreadplate Shoulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103004, "", "=q4=Prideful Gladiator's Dreadplate Chestpiece", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103005, "", "=q4=Prideful Gladiator's Dreadplate Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103073, "", "=q4=Prideful Gladiator's Dreadplate Girdle", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103007, "", "=q4=Prideful Gladiator's Dreadplate Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103076, "", "=q4=Prideful Gladiator's Dreadplate Warboots", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="};
				{ 26, 98786, "", "=q3=Crafted Malevolent Gladiator's Dreadplate Helm", "=ds="};
				{ 27, 98788, "", "=q3=Crafted Malevolent Gladiator's Dreadplate Shoulders", "=ds="};
				{ 28, 98784, "", "=q3=Crafted Malevolent Gladiator's Dreadplate Chestpiece", "=ds="};
				{ 29, 98785, "", "=q3=Crafted Malevolent Gladiator's Dreadplate Gauntlets", "=ds="};
				{ 30, 98787, "", "=q3=Crafted Malevolent Gladiator's Dreadplate Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90DruidBalance"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="};
				{ 11, 102634, "", "=q4=Prideful Gladiator's Wyrmhide Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102700, "", "=q4=Prideful Gladiator's Wyrmhide Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102614, "", "=q4=Prideful Gladiator's Wyrmhide Robes", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102696, "", "=q4=Prideful Gladiator's Wyrmhide Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102767, "", "=q4=Prideful Gladiator's Wyrmhide Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="};
				{ 17, 103202, "", "=q4=Grievous Gladiator's Wyrmhide Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103205, "", "=q4=Grievous Gladiator's Wyrmhide Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103204, "", "=q4=Grievous Gladiator's Wyrmhide Robes", "=ds=", "#HONOR:2250#"};
				{ 20, 103201, "", "=q4=Grievous Gladiator's Wyrmhide Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103203, "", "=q4=Grievous Gladiator's Wyrmhide Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="};
				{ 11, 103399, "", "=q4=Prideful Gladiator's Wyrmhide Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103402, "", "=q4=Prideful Gladiator's Wyrmhide Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103401, "", "=q4=Prideful Gladiator's Wyrmhide Robes", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103398, "", "=q4=Prideful Gladiator's Wyrmhide Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103400, "", "=q4=Prideful Gladiator's Wyrmhide Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="};
				{ 17, 102831, "", "=q4=Grievous Gladiator's Wyrmhide Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102897, "", "=q4=Grievous Gladiator's Wyrmhide Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102811, "", "=q4=Grievous Gladiator's Wyrmhide Robes", "=ds=", "#HONOR:2250#"};
				{ 20, 102893, "", "=q4=Grievous Gladiator's Wyrmhide Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102964, "", "=q4=Grievous Gladiator's Wyrmhide Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="};
				{ 2, 103025, "", "=q4=Prideful Gladiator's Wyrmhide Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103028, "", "=q4=Prideful Gladiator's Wyrmhide Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103027, "", "=q4=Prideful Gladiator's Wyrmhide Robes", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103024, "", "=q4=Prideful Gladiator's Wyrmhide Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103022, "", "=q4=Prideful Gladiator's Wyrmhide Belt", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103026, "", "=q4=Prideful Gladiator's Wyrmhide Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103023, "", "=q4=Prideful Gladiator's Wyrmhide Footguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="};
				{ 26, 98806, "", "=q3=Crafted Malevolent Gladiator's Wyrmhide Helm", "=ds="};
				{ 27, 98809, "", "=q3=Crafted Malevolent Gladiator's Wyrmhide Spaulders", "=ds="};
				{ 28, 98808, "", "=q3=Crafted Malevolent Gladiator's Wyrmhide Robes", "=ds="};
				{ 29, 98805, "", "=q3=Crafted Malevolent Gladiator's Wyrmhide Gloves", "=ds="};
				{ 30, 98807, "", "=q3=Crafted Malevolent Gladiator's Wyrmhide Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90DruidFeral"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="};
				{ 11, 102653, "", "=q4=Prideful Gladiator's Dragonhide Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102741, "", "=q4=Prideful Gladiator's Dragonhide Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102740, "", "=q4=Prideful Gladiator's Dragonhide Robes", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102739, "", "=q4=Prideful Gladiator's Dragonhide Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102654, "", "=q4=Prideful Gladiator's Dragonhide Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="};
				{ 17, 103185, "", "=q4=Grievous Gladiator's Dragonhide Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103188, "", "=q4=Grievous Gladiator's Dragonhide Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103187, "", "=q4=Grievous Gladiator's Dragonhide Robes", "=ds=", "#HONOR:2250#"};
				{ 20, 103184, "", "=q4=Grievous Gladiator's Dragonhide Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103186, "", "=q4=Grievous Gladiator's Dragonhide Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="};
				{ 11, 103382, "", "=q4=Prideful Gladiator's Dragonhide Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103385, "", "=q4=Prideful Gladiator's Dragonhide Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103384, "", "=q4=Prideful Gladiator's Dragonhide Robes", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103381, "", "=q4=Prideful Gladiator's Dragonhide Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103383, "", "=q4=Prideful Gladiator's Dragonhide Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="};
				{ 17, 102850, "", "=q4=Grievous Gladiator's Dragonhide Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102938, "", "=q4=Grievous Gladiator's Dragonhide Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102937, "", "=q4=Grievous Gladiator's Dragonhide Robes", "=ds=", "#HONOR:2250#"};
				{ 20, 102936, "", "=q4=Grievous Gladiator's Dragonhide Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102851, "", "=q4=Grievous Gladiator's Dragonhide Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="};
				{ 2, 103010, "", "=q4=Prideful Gladiator's Dragonhide Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103013, "", "=q4=Prideful Gladiator's Dragonhide Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103012, "", "=q4=Prideful Gladiator's Dragonhide Robes", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103009, "", "=q4=Prideful Gladiator's Dragonhide Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103138, "", "=q4=Prideful Gladiator's Dragonhide Belt", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103011, "", "=q4=Prideful Gladiator's Dragonhide Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103137, "", "=q4=Prideful Gladiator's Dragonhide Footguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="};
				{ 26, 98790, "", "=q3=Crafted Malevolent Gladiator's Dragonhide Helm", "=ds="};
				{ 27, 98793, "", "=q3=Crafted Malevolent Gladiator's Dragonhide Spaulders", "=ds="};
				{ 28, 98792, "", "=q3=Crafted Malevolent Gladiator's Dragonhide Robes", "=ds="};
				{ 29, 98789, "", "=q3=Crafted Malevolent Gladiator's Dragonhide Gloves", "=ds="};
				{ 30, 98791, "", "=q3=Crafted Malevolent Gladiator's Dragonhide Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90DruidRestoration"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="};
				{ 11, 102776, "", "=q4=Prideful Gladiator's Kodohide Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102658, "", "=q4=Prideful Gladiator's Kodohide Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102721, "", "=q4=Prideful Gladiator's Kodohide Robes", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102657, "", "=q4=Prideful Gladiator's Kodohide Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102761, "", "=q4=Prideful Gladiator's Kodohide Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="};
				{ 17, 103193, "", "=q4=Grievous Gladiator's Kodohide Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103196, "", "=q4=Grievous Gladiator's Kodohide Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103195, "", "=q4=Grievous Gladiator's Kodohide Robes", "=ds=", "#HONOR:2250#"};
				{ 20, 103192, "", "=q4=Grievous Gladiator's Kodohide Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103194, "", "=q4=Grievous Gladiator's Kodohide Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="};
				{ 11, 103390, "", "=q4=Prideful Gladiator's Kodohide Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103393, "", "=q4=Prideful Gladiator's Kodohide Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103392, "", "=q4=Prideful Gladiator's Kodohide Robes", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103389, "", "=q4=Prideful Gladiator's Kodohide Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103391, "", "=q4=Prideful Gladiator's Kodohide Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="};
				{ 17, 102973, "", "=q4=Grievous Gladiator's Kodohide Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102855, "", "=q4=Grievous Gladiator's Kodohide Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102918, "", "=q4=Grievous Gladiator's Kodohide Robes", "=ds=", "#HONOR:2250#"};
				{ 20, 102854, "", "=q4=Grievous Gladiator's Kodohide Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102958, "", "=q4=Grievous Gladiator's Kodohide Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="};
				{ 2, 103017, "", "=q4=Prideful Gladiator's Kodohide Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103020, "", "=q4=Prideful Gladiator's Kodohide Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103019, "", "=q4=Prideful Gladiator's Kodohide Robes", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103016, "", "=q4=Prideful Gladiator's Kodohide Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103014, "", "=q4=Prideful Gladiator's Kodohide Belt", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103018, "", "=q4=Prideful Gladiator's Kodohide Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103015, "", "=q4=Prideful Gladiator's Kodohide Footguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="};
				{ 26, 98798, "", "=q3=Crafted Malevolent Gladiator's Kodohide Helm", "=ds="};
				{ 27, 98801, "", "=q3=Crafted Malevolent Gladiator's Kodohide Spaulders", "=ds="};
				{ 28, 98800, "", "=q3=Crafted Malevolent Gladiator's Kodohide Robes", "=ds="};
				{ 29, 98797, "", "=q3=Crafted Malevolent Gladiator's Kodohide Gloves", "=ds="};
				{ 30, 98799, "", "=q3=Crafted Malevolent Gladiator's Kodohide Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90Hunter"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="};
				{ 11, 102690, "", "=q4=Prideful Gladiator's Chain Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102734, "", "=q4=Prideful Gladiator's Chain Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102689, "", "=q4=Prideful Gladiator's Chain Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102737, "", "=q4=Prideful Gladiator's Chain Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102670, "", "=q4=Prideful Gladiator's Chain Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="};
				{ 17, 103221, "", "=q4=Grievous Gladiator's Chain Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103223, "", "=q4=Grievous Gladiator's Chain Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103219, "", "=q4=Grievous Gladiator's Chain Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 103220, "", "=q4=Grievous Gladiator's Chain Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 103222, "", "=q4=Grievous Gladiator's Chain Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="};
				{ 11, 103418, "", "=q4=Prideful Gladiator's Chain Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103420, "", "=q4=Prideful Gladiator's Chain Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103416, "", "=q4=Prideful Gladiator's Chain Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103417, "", "=q4=Prideful Gladiator's Chain Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103419, "", "=q4=Prideful Gladiator's Chain Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="};
				{ 17, 102887, "", "=q4=Grievous Gladiator's Chain Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102931, "", "=q4=Grievous Gladiator's Chain Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102886, "", "=q4=Grievous Gladiator's Chain Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 102934, "", "=q4=Grievous Gladiator's Chain Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102867, "", "=q4=Grievous Gladiator's Chain Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="};
				{ 2, 103039, "", "=q4=Prideful Gladiator's Chain Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103041, "", "=q4=Prideful Gladiator's Chain Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103037, "", "=q4=Prideful Gladiator's Chain Armor", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103038, "", "=q4=Prideful Gladiator's Chain Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103033, "", "=q4=Prideful Gladiator's Chain Links", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103040, "", "=q4=Prideful Gladiator's Chain Leggings", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103035, "", "=q4=Prideful Gladiator's Chain Sabatons", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="};
				{ 26, 98822, "", "=q3=Crafted Malevolent Gladiator's Chain Helm", "=ds="};
				{ 27, 98824, "", "=q3=Crafted Malevolent Gladiator's Chain Spaulders", "=ds="};
				{ 28, 98820, "", "=q3=Crafted Malevolent Gladiator's Chain Armor", "=ds="};
				{ 29, 98821, "", "=q3=Crafted Malevolent Gladiator's Chain Gauntlets", "=ds="};
				{ 30, 98823, "", "=q3=Crafted Malevolent Gladiator's Chain Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90Mage"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="};
				{ 11, 102667, "", "=q4=Prideful Gladiator's Silk Cowl", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103046, "", "=q4=Prideful Gladiator's Silk Amice", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102715, "", "=q4=Prideful Gladiator's Silk Robe", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102735, "", "=q4=Prideful Gladiator's Silk Handguards", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102648, "", "=q4=Prideful Gladiator's Silk Trousers", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="};
				{ 17, 103225, "", "=q4=Grievous Gladiator's Silk Cowl", "=ds=", "#HONOR:2250#"};
				{ 18, 103228, "", "=q4=Grievous Gladiator's Silk Amice", "=ds=", "#HONOR:1750#"};
				{ 19, 103227, "", "=q4=Grievous Gladiator's Silk Robe", "=ds=", "#HONOR:2250#"};
				{ 20, 103224, "", "=q4=Grievous Gladiator's Silk Handguards", "=ds=", "#HONOR:1750#"};
				{ 21, 103226, "", "=q4=Grievous Gladiator's Silk Trousers", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="};
				{ 11, 103422, "", "=q4=Prideful Gladiator's Silk Cowl", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103425, "", "=q4=Prideful Gladiator's Silk Amice", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103424, "", "=q4=Prideful Gladiator's Silk Robe", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103421, "", "=q4=Prideful Gladiator's Silk Handguards", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103423, "", "=q4=Prideful Gladiator's Silk Trousers", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="};
				{ 17, 102864, "", "=q4=Grievous Gladiator's Silk Cowl", "=ds=", "#HONOR:2250#"};
				{ 18, 102870, "", "=q4=Grievous Gladiator's Silk Amice", "=ds=", "#HONOR:1750#"};
				{ 19, 102912, "", "=q4=Grievous Gladiator's Silk Robe", "=ds=", "#HONOR:2250#"};
				{ 20, 102932, "", "=q4=Grievous Gladiator's Silk Handguards", "=ds=", "#HONOR:1750#"};
				{ 21, 102845, "", "=q4=Grievous Gladiator's Silk Trousers", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="};
				{ 2, 103043, "", "=q4=Prideful Gladiator's Silk Cowl", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103046, "", "=q4=Prideful Gladiator's Silk Amice", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103045, "", "=q4=Prideful Gladiator's Silk Robe", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103042, "", "=q4=Prideful Gladiator's Silk Handguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 102991, "", "=q4=Prideful Gladiator's Silk Cord", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103044, "", "=q4=Prideful Gladiator's Silk Trousers", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 102994, "", "=q4=Prideful Gladiator's Silk Treads", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="};
				{ 26, 98826, "", "=q3=Crafted Malevolent Gladiator's Silk Cowl", "=ds="};
				{ 27, 98829, "", "=q3=Crafted Malevolent Gladiator's Silk Amice", "=ds="};
				{ 28, 98828, "", "=q3=Crafted Malevolent Gladiator's Silk Robe", "=ds="};
				{ 29, 98825, "", "=q3=Crafted Malevolent Gladiator's Silk Handguards", "=ds="};
				{ 30, 98827, "", "=q3=Crafted Malevolent Gladiator's Silk Trousers", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90MonkHealer"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_monk_mistweaver_spec", "=q6=#arenas11_2#", "=q5="};
				{ 11, 102628, "", "=q4=Prideful Gladiator's Copperskin Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102777, "", "=q4=Prideful Gladiator's Copperskin Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102763, "", "=q4=Prideful Gladiator's Copperskin Tunic", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102627, "", "=q4=Prideful Gladiator's Copperskin Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102762, "", "=q4=Prideful Gladiator's Copperskin Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_monk_mistweaver_spec", "=q6=#arenas11_2#", "=q5="};
				{ 17, 103238, "", "=q4=Grievous Gladiator's Copperskin Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103240, "", "=q4=Grievous Gladiator's Copperskin Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103241, "", "=q4=Grievous Gladiator's Copperskin Tunic", "=ds=", "#HONOR:2250#"};
				{ 20, 103237, "", "=q4=Grievous Gladiator's Copperskin Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103239, "", "=q4=Grievous Gladiator's Copperskin Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_monk_mistweaver_spec", "=q6=#arenas11_2#", "=q5="};
				{ 11, 103435, "", "=q4=Prideful Gladiator's Copperskin Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103437, "", "=q4=Prideful Gladiator's Copperskin Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103438, "", "=q4=Prideful Gladiator's Copperskin Tunic", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103434, "", "=q4=Prideful Gladiator's Copperskin Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103436, "", "=q4=Prideful Gladiator's Copperskin Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_monk_mistweaver_spec", "=q6=#arenas11_2#", "=q5="};
				{ 17, 102825, "", "=q4=Grievous Gladiator's Copperskin Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102974, "", "=q4=Grievous Gladiator's Copperskin Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102960, "", "=q4=Grievous Gladiator's Copperskin Tunic", "=ds=", "#HONOR:2250#"};
				{ 20, 102824, "", "=q4=Grievous Gladiator's Copperskin Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102959, "", "=q4=Grievous Gladiator's Copperskin Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_mistweaver_spec", "=q6=#arenas11_2#", "=q5="};
				{ 2, 103055, "", "=q4=Prideful Gladiator's Copperskin Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103057, "", "=q4=Prideful Gladiator's Copperskin Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103058, "", "=q4=Prideful Gladiator's Copperskin Tunic", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103054, "", "=q4=Prideful Gladiator's Copperskin Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103134, "", "=q4=Prideful Gladiator's Copperskin Waistband", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103056, "", "=q4=Prideful Gladiator's Copperskin Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103133, "", "=q4=Prideful Gladiator's Copperskin Boots", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_monk_mistweaver_spec", "=q6=#arenas11_2#", "=q5="};
				{ 26, 98839, "", "=q3=Crafted Malevolent Gladiator's Copperskin Helm", "=ds="};
				{ 27, 98841, "", "=q3=Crafted Malevolent Gladiator's Copperskin Spaulders", "=ds="};
				{ 28, 98842, "", "=q3=Crafted Malevolent Gladiator's Copperskin Tunic", "=ds="};
				{ 29, 98838, "", "=q3=Crafted Malevolent Gladiator's Copperskin Gloves", "=ds="};
				{ 30, 98840, "", "=q3=Crafted Malevolent Gladiator's Copperskin Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Mistweaver"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90MonkDPS"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_monk_windwalker_spec", "=q6=#arenas11_1#", "=q5="};
				{ 11, 102712, "", "=q4=Prideful Gladiator's Ironskin Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102626, "", "=q4=Prideful Gladiator's Ironskin Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102720, "", "=q4=Prideful Gladiator's Ironskin Tunic", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102675, "", "=q4=Prideful Gladiator's Ironskin Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102656, "", "=q4=Prideful Gladiator's Ironskin Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_monk_windwalker_spec", "=q6=#arenas11_1#", "=q5="};
				{ 17, 103233, "", "=q4=Grievous Gladiator's Ironskin Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103235, "", "=q4=Grievous Gladiator's Ironskin Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103236, "", "=q4=Grievous Gladiator's Ironskin Tunic", "=ds=", "#HONOR:2250#"};
				{ 20, 103232, "", "=q4=Grievous Gladiator's Ironskin Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103234, "", "=q4=Grievous Gladiator's Ironskin Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_monk_windwalker_spec", "=q6=#arenas11_1#", "=q5="};
				{ 11, 103430, "", "=q4=Prideful Gladiator's Ironskin Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103432, "", "=q4=Prideful Gladiator's Ironskin Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103433, "", "=q4=Prideful Gladiator's Ironskin Tunic", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103429, "", "=q4=Prideful Gladiator's Ironskin Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103431, "", "=q4=Prideful Gladiator's Ironskin Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_monk_windwalker_spec", "=q6=#arenas11_1#", "=q5="};
				{ 17, 102909, "", "=q4=Grievous Gladiator's Ironskin Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102823, "", "=q4=Grievous Gladiator's Ironskin Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102917, "", "=q4=Grievous Gladiator's Ironskin Tunic", "=ds=", "#HONOR:2250#"};
				{ 20, 102872, "", "=q4=Grievous Gladiator's Ironskin Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102853, "", "=q4=Grievous Gladiator's Ironskin Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_windwalker_spec", "=q6=#arenas11_1#", "=q5="};
				{ 2, 103050, "", "=q4=Prideful Gladiator's Ironskin Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103052, "", "=q4=Prideful Gladiator's Ironskin Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103053, "", "=q4=Prideful Gladiator's Ironskin Tunic", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103049, "", "=q4=Prideful Gladiator's Ironskin Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103047, "", "=q4=Prideful Gladiator's Ironskin Waistband", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103051, "", "=q4=Prideful Gladiator's Ironskin Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103048, "", "=q4=Prideful Gladiator's Ironskin Boots", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_monk_windwalker_spec", "=q6=#arenas11_1#", "=q5="};
				{ 26, 98834, "", "=q3=Crafted Malevolent Gladiator's Ironskin Helm", "=ds="};
				{ 27, 98836, "", "=q3=Crafted Malevolent Gladiator's Ironskin Spaulders", "=ds="};
				{ 28, 98837, "", "=q3=Crafted Malevolent Gladiator's Ironskin Tunic", "=ds="};
				{ 29, 98833, "", "=q3=Crafted Malevolent Gladiator's Ironskin Gloves", "=ds="};
				{ 30, 98835, "", "=q3=Crafted Malevolent Gladiator's Ironskin Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Windwalker"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90PaladinRetribution"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="};
				{ 11, 102779, "", "=q4=Prideful Gladiator's Scaled Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102744, "", "=q4=Prideful Gladiator's Scaled Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102747, "", "=q4=Prideful Gladiator's Scaled Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102630, "", "=q4=Prideful Gladiator's Scaled Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102780, "", "=q4=Prideful Gladiator's Scaled Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="};
				{ 17, 103244, "", "=q4=Grievous Gladiator's Scaled Helm", "=ds=", "#CONQUEST:2250#"};
				{ 18, 103246, "", "=q4=Grievous Gladiator's Scaled Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 19, 103242, "", "=q4=Grievous Gladiator's Scaled Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 20, 103243, "", "=q4=Grievous Gladiator's Scaled Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 21, 103245, "", "=q4=Grievous Gladiator's Scaled Legguards", "=ds=", "#CONQUEST:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="};
				{ 11, 103441, "", "=q4=Prideful Gladiator's Scaled Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103443, "", "=q4=Prideful Gladiator's Scaled Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103439, "", "=q4=Prideful Gladiator's Scaled Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103440, "", "=q4=Prideful Gladiator's Scaled Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103442, "", "=q4=Prideful Gladiator's Scaled Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="};
				{ 17, 102976, "", "=q4=Grievous Gladiator's Scaled Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102941, "", "=q4=Grievous Gladiator's Scaled Shoulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102944, "", "=q4=Grievous Gladiator's Scaled Chestpiece", "=ds=", "#HONOR:2250#"};
				{ 20, 102827, "", "=q4=Grievous Gladiator's Scaled Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102977, "", "=q4=Grievous Gladiator's Scaled Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="};
				{ 2, 103061, "", "=q4=Prideful Gladiator's Scaled Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103063, "", "=q4=Prideful Gladiator's Scaled Shoulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103059, "", "=q4=Prideful Gladiator's Scaled Chestpiece", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103060, "", "=q4=Prideful Gladiator's Scaled Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103064, "", "=q4=Prideful Gladiator's Scaled Clasp", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103062, "", "=q4=Prideful Gladiator's Scaled Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103067, "", "=q4=Prideful Gladiator's Scaled Greaves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="};
				{ 26, 98845, "", "=q3=Crafted Malevolent Gladiator's Scaled Helm", "=ds="};
				{ 27, 98847, "", "=q3=Crafted Malevolent Gladiator's Scaled Shoulders", "=ds="};
				{ 28, 98843, "", "=q3=Crafted Malevolent Gladiator's Scaled Chestpiece", "=ds="};
				{ 29, 98844, "", "=q3=Crafted Malevolent Gladiator's Scaled Gauntlets", "=ds="};
				{ 30, 98846, "", "=q3=Crafted Malevolent Gladiator's Scaled Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90PaladinHoly"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="};
				{ 11, 102635, "", "=q4=Prideful Gladiator's Ornamented Headcover", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102697, "", "=q4=Prideful Gladiator's Ornamented Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102632, "", "=q4=Prideful Gladiator's Ornamented Chestguard", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102722, "", "=q4=Prideful Gladiator's Ornamented Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102768, "", "=q4=Prideful Gladiator's Ornamented Legplates", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="};
				{ 17, 103255, "", "=q4=Grievous Gladiator's Ornamented Headcover", "=ds=", "#HONOR:2250#"};
				{ 18, 103257, "", "=q4=Grievous Gladiator's Ornamented Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103253, "", "=q4=Grievous Gladiator's Ornamented Chestguard", "=ds=", "#HONOR:2250#"};
				{ 20, 103254, "", "=q4=Grievous Gladiator's Ornamented Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103256, "", "=q4=Grievous Gladiator's Ornamented Legplates", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="};
				{ 11, 103452, "", "=q4=Prideful Gladiator's Ornamented Headcover", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103454, "", "=q4=Prideful Gladiator's Ornamented Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103450, "", "=q4=Prideful Gladiator's Ornamented Chestguard", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103451, "", "=q4=Prideful Gladiator's Ornamented Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103453, "", "=q4=Prideful Gladiator's Ornamented Legplates", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="};
				{ 17, 102832, "", "=q4=Grievous Gladiator's Ornamented Headcover", "=ds=", "#HONOR:2250#"};
				{ 18, 102894, "", "=q4=Grievous Gladiator's Ornamented Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102829, "", "=q4=Grievous Gladiator's Ornamented Chestguard", "=ds=", "#HONOR:2250#"};
				{ 20, 102919, "", "=q4=Grievous Gladiator's Ornamented Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102965, "", "=q4=Grievous Gladiator's Ornamented Legplates", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="};
				{ 2, 103070, "", "=q4=Prideful Gladiator's Ornamented Headcover", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103072, "", "=q4=Prideful Gladiator's Ornamented Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103068, "", "=q4=Prideful Gladiator's Ornamented Chestguard", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103069, "", "=q4=Prideful Gladiator's Ornamented Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103065, "", "=q4=Prideful Gladiator's Ornamented Clasp", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103071, "", "=q4=Prideful Gladiator's Ornamented Legplates", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103066, "", "=q4=Prideful Gladiator's Ornamented Greaves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="};
				{ 26, 98856, "", "=q3=Crafted Malevolent Gladiator's Ornamented Headcover", "=ds="};
				{ 27, 98858, "", "=q3=Crafted Malevolent Gladiator's Ornamented Spaulders", "=ds="};
				{ 28, 98854, "", "=q3=Crafted Malevolent Gladiator's Ornamented Chestguard", "=ds="};
				{ 29, 98855, "", "=q3=Crafted Malevolent Gladiator's Ornamented Gloves", "=ds="};
				{ 30, 98857, "", "=q3=Crafted Malevolent Gladiator's Ornamented Legplates", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90PriestShadow"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="};
				{ 11, 102751, "", "=q4=Prideful Gladiator's Satin Hood", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102671, "", "=q4=Prideful Gladiator's Satin Mantle", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102622, "", "=q4=Prideful Gladiator's Satin Robe", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102707, "", "=q4=Prideful Gladiator's Satin Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102621, "", "=q4=Prideful Gladiator's Satin Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="};
				{ 17, 103271, "", "=q4=Grievous Gladiator's Satin Hood", "=ds=", "#HONOR:2250#"};
				{ 18, 103274, "", "=q4=Grievous Gladiator's Satin Mantle", "=ds=", "#HONOR:1750#"};
				{ 19, 103273, "", "=q4=Grievous Gladiator's Satin Robe", "=ds=", "#HONOR:2250#"};
				{ 20, 103270, "", "=q4=Grievous Gladiator's Satin Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103272, "", "=q4=Grievous Gladiator's Satin Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="};
				{ 11, 103468, "", "=q4=Prideful Gladiator's Satin Hood", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103471, "", "=q4=Prideful Gladiator's Satin Mantle", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103470, "", "=q4=Prideful Gladiator's Satin Robe", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103467, "", "=q4=Prideful Gladiator's Satin Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103469, "", "=q4=Prideful Gladiator's Satin Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="};
				{ 17, 102948, "", "=q4=Grievous Gladiator's Satin Hood", "=ds=", "#HONOR:2250#"};
				{ 18, 102868, "", "=q4=Grievous Gladiator's Satin Mantle", "=ds=", "#HONOR:1750#"};
				{ 19, 102819, "", "=q4=Grievous Gladiator's Satin Robe", "=ds=", "#HONOR:2250#"};
				{ 20, 102904, "", "=q4=Grievous Gladiator's Satin Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102818, "", "=q4=Grievous Gladiator's Satin Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="};
				{ 2, 103084, "", "=q4=Prideful Gladiator's Satin Hood", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103087, "", "=q4=Prideful Gladiator's Satin Mantle", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103086, "", "=q4=Prideful Gladiator's Satin Robe", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103083, "", "=q4=Prideful Gladiator's Satin Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103136, "", "=q4=Prideful Gladiator's Satin Cord", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103085, "", "=q4=Prideful Gladiator's Satin Leggings", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103135, "", "=q4=Prideful Gladiator's Satin Treads", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="};
				{ 26, 98871, "", "=q3=Crafted Malevolent Gladiator's Satin Hood", "=ds="};
				{ 27, 98874, "", "=q3=Crafted Malevolent Gladiator's Satin Mantle", "=ds="};
				{ 28, 98873, "", "=q3=Crafted Malevolent Gladiator's Satin Robe", "=ds="};
				{ 29, 98870, "", "=q3=Crafted Malevolent Gladiator's Satin Gloves", "=ds="};
				{ 30, 98872, "", "=q3=Crafted Malevolent Gladiator's Satin Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Shadow"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90PriestHoly"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="};
				{ 11, 102703, "", "=q4=Prideful Gladiator's Mooncloth Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102750, "", "=q4=Prideful Gladiator's Mooncloth Mantle", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102681, "", "=q4=Prideful Gladiator's Mooncloth Robe", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102615, "", "=q4=Prideful Gladiator's Mooncloth Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102704, "", "=q4=Prideful Gladiator's Mooncloth Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="};
				{ 17, 103266, "", "=q4=Grievous Gladiator's Mooncloth Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103269, "", "=q4=Grievous Gladiator's Mooncloth Mantle", "=ds=", "#HONOR:1750#"};
				{ 19, 103268, "", "=q4=Grievous Gladiator's Mooncloth Robe", "=ds=", "#HONOR:2250#"};
				{ 20, 103265, "", "=q4=Grievous Gladiator's Mooncloth Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103267, "", "=q4=Grievous Gladiator's Mooncloth Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="};
				{ 11, 103463, "", "=q4=Prideful Gladiator's Mooncloth Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103466, "", "=q4=Prideful Gladiator's Mooncloth Mantle", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103465, "", "=q4=Prideful Gladiator's Mooncloth Robe", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103462, "", "=q4=Prideful Gladiator's Mooncloth Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103464, "", "=q4=Prideful Gladiator's Mooncloth Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="};
				{ 17, 102900, "", "=q4=Grievous Gladiator's Mooncloth Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102947, "", "=q4=Grievous Gladiator's Mooncloth Mantle", "=ds=", "#HONOR:1750#"};
				{ 19, 102878, "", "=q4=Grievous Gladiator's Mooncloth Robe", "=ds=", "#HONOR:2250#"};
				{ 20, 102812, "", "=q4=Grievous Gladiator's Mooncloth Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102901, "", "=q4=Grievous Gladiator's Mooncloth Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="};
				{ 2, 103079, "", "=q4=Prideful Gladiator's Mooncloth Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103082, "", "=q4=Prideful Gladiator's Mooncloth Mantle", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103081, "", "=q4=Prideful Gladiator's Mooncloth Robe", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103078, "", "=q4=Prideful Gladiator's Mooncloth Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 102993, "", "=q4=Prideful Gladiator's Mooncloth Cord", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103080, "", "=q4=Prideful Gladiator's Mooncloth Leggings", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 102996, "", "=q4=Prideful Gladiator's Mooncloth Treads", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="};
				{ 26, 98866, "", "=q3=Crafted Malevolent Gladiator's Mooncloth Helm", "=ds="};
				{ 27, 98869, "", "=q3=Crafted Malevolent Gladiator's Mooncloth Mantle", "=ds="};
				{ 28, 98868, "", "=q3=Crafted Malevolent Gladiator's Mooncloth Robe", "=ds="};
				{ 29, 98865, "", "=q3=Crafted Malevolent Gladiator's Mooncloth Gloves", "=ds="};
				{ 30, 98867, "", "=q3=Crafted Malevolent Gladiator's Mooncloth Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Discipline"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90Rogue"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="};
				{ 11, 102710, "", "=q4=Prideful Gladiator's Leather Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102731, "", "=q4=Prideful Gladiator's Leather Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102727, "", "=q4=Prideful Gladiator's Leather Tunic", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102663, "", "=q4=Prideful Gladiator's Leather Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102730, "", "=q4=Prideful Gladiator's Leather Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="};
				{ 17, 103280, "", "=q4=Grievous Gladiator's Leather Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103282, "", "=q4=Grievous Gladiator's Leather Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103278, "", "=q4=Grievous Gladiator's Leather Tunic", "=ds=", "#HONOR:2250#"};
				{ 20, 103279, "", "=q4=Grievous Gladiator's Leather Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 103281, "", "=q4=Grievous Gladiator's Leather Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="};
				{ 11, 103477, "", "=q4=Prideful Gladiator's Leather Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103479, "", "=q4=Prideful Gladiator's Leather Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103475, "", "=q4=Prideful Gladiator's Leather Tunic", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103476, "", "=q4=Prideful Gladiator's Leather Gloves", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103478, "", "=q4=Prideful Gladiator's Leather Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="};
				{ 17, 102907, "", "=q4=Grievous Gladiator's Leather Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102928, "", "=q4=Grievous Gladiator's Leather Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102924, "", "=q4=Grievous Gladiator's Leather Tunic", "=ds=", "#HONOR:2250#"};
				{ 20, 102860, "", "=q4=Grievous Gladiator's Leather Gloves", "=ds=", "#HONOR:1750#"};
				{ 21, 102927, "", "=q4=Grievous Gladiator's Leather Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="};
				{ 2, 103092, "", "=q4=Prideful Gladiator's Leather Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103094, "", "=q4=Prideful Gladiator's Leather Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103090, "", "=q4=Prideful Gladiator's Leather Tunic", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103091, "", "=q4=Prideful Gladiator's Leather Gloves", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103088, "", "=q4=Prideful Gladiator's Leather Waistband", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103093, "", "=q4=Prideful Gladiator's Leather Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103089, "", "=q4=Prideful Gladiator's Leather Boots", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="};
				{ 26, 98886, "", "=q3=Crafted Malevolent Gladiator's Leather Helm", "=ds="};
				{ 27, 98888, "", "=q3=Crafted Malevolent Gladiator's Leather Spaulders", "=ds="};
				{ 28, 98884, "", "=q3=Crafted Malevolent Gladiator's Leather Tunic", "=ds="};
				{ 29, 98885, "", "=q3=Crafted Malevolent Gladiator's Leather Gloves", "=ds="};
				{ 30, 98887, "", "=q3=Crafted Malevolent Gladiator's Leather Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90ShamanElemental"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="};
				{ 11, 102693, "", "=q4=Prideful Gladiator's Mail Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102637, "", "=q4=Prideful Gladiator's Mail Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102743, "", "=q4=Prideful Gladiator's Mail Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102692, "", "=q4=Prideful Gladiator's Mail Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102781, "", "=q4=Prideful Gladiator's Mail Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="};
				{ 17, 103301, "", "=q4=Grievous Gladiator's Mail Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103303, "", "=q4=Grievous Gladiator's Mail Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103299, "", "=q4=Grievous Gladiator's Mail Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 103300, "", "=q4=Grievous Gladiator's Mail Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 103302, "", "=q4=Grievous Gladiator's Mail Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="};
				{ 11, 103498, "", "=q4=Prideful Gladiator's Mail Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103500, "", "=q4=Prideful Gladiator's Mail Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103496, "", "=q4=Prideful Gladiator's Mail Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103497, "", "=q4=Prideful Gladiator's Mail Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103499, "", "=q4=Prideful Gladiator's Mail Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="};
				{ 17, 102890, "", "=q4=Grievous Gladiator's Mail Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102834, "", "=q4=Grievous Gladiator's Mail Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102940, "", "=q4=Grievous Gladiator's Mail Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 102889, "", "=q4=Grievous Gladiator's Mail Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102978, "", "=q4=Grievous Gladiator's Mail Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="};
				{ 2, 103111, "", "=q4=Prideful Gladiator's Mail Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103113, "", "=q4=Prideful Gladiator's Mail Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103109, "", "=q4=Prideful Gladiator's Mail Armor", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103110, "", "=q4=Prideful Gladiator's Mail Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103108, "", "=q4=Prideful Gladiator's Mail Waistguard", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103112, "", "=q4=Prideful Gladiator's Mail Leggings", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103097, "", "=q4=Prideful Gladiator's Mail Footguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="};
				{ 26, 98907, "", "=q3=Crafted Malevolent Gladiator's Mail Helm", "=ds="};
				{ 27, 98909, "", "=q3=Crafted Malevolent Gladiator's Mail Spaulders", "=ds="};
				{ 28, 98905, "", "=q3=Crafted Malevolent Gladiator's Mail Armor", "=ds="};
				{ 29, 98906, "", "=q3=Crafted Malevolent Gladiator's Mail Gauntlets", "=ds="};
				{ 30, 98908, "", "=q3=Crafted Malevolent Gladiator's Mail Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90ShamanEnhancement"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="};
				{ 11, 102714, "", "=q4=Prideful Gladiator's Linked Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102629, "", "=q4=Prideful Gladiator's Linked Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102759, "", "=q4=Prideful Gladiator's Linked Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102742, "", "=q4=Prideful Gladiator's Linked Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102778, "", "=q4=Prideful Gladiator's Linked Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="};
				{ 17, 103295, "", "=q4=Grievous Gladiator's Linked Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103297, "", "=q4=Grievous Gladiator's Linked Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103293, "", "=q4=Grievous Gladiator's Linked Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 103294, "", "=q4=Grievous Gladiator's Linked Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 103296, "", "=q4=Grievous Gladiator's Linked Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="};
				{ 11, 103492, "", "=q4=Prideful Gladiator's Linked Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103494, "", "=q4=Prideful Gladiator's Linked Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103490, "", "=q4=Prideful Gladiator's Linked Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103491, "", "=q4=Prideful Gladiator's Linked Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103493, "", "=q4=Prideful Gladiator's Linked Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="};
				{ 17, 102911, "", "=q4=Grievous Gladiator's Linked Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102826, "", "=q4=Grievous Gladiator's Linked Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102956, "", "=q4=Grievous Gladiator's Linked Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 102939, "", "=q4=Grievous Gladiator's Linked Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102975, "", "=q4=Grievous Gladiator's Linked Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="};
				{ 2, 103105, "", "=q4=Prideful Gladiator's Linked Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103107, "", "=q4=Prideful Gladiator's Linked Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103103, "", "=q4=Prideful Gladiator's Linked Armor", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103104, "", "=q4=Prideful Gladiator's Linked Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103034, "", "=q4=Prideful Gladiator's Linked Waistband", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103106, "", "=q4=Prideful Gladiator's Linked Leggings", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103036, "", "=q4=Prideful Gladiator's Linked Sabatons", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="};
				{ 26, 98901, "", "=q3=Crafted Malevolent Gladiator's Linked Helm", "=ds="};
				{ 27, 98903, "", "=q3=Crafted Malevolent Gladiator's Linked Spaulders", "=ds="};
				{ 28, 98899, "", "=q3=Crafted Malevolent Gladiator's Linked Armor", "=ds="};
				{ 29, 98900, "", "=q3=Crafted Malevolent Gladiator's Linked Gauntlets", "=ds="};
				{ 30, 98902, "", "=q3=Crafted Malevolent Gladiator's Linked Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90ShamanRestoration"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="};
				{ 11, 102718, "", "=q4=Prideful Gladiator's Ringmail Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102655, "", "=q4=Prideful Gladiator's Ringmail Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102717, "", "=q4=Prideful Gladiator's Ringmail Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102774, "", "=q4=Prideful Gladiator's Ringmail Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102719, "", "=q4=Prideful Gladiator's Ringmail Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="};
				{ 17, 103290, "", "=q4=Grievous Gladiator's Ringmail Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103292, "", "=q4=Grievous Gladiator's Ringmail Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103288, "", "=q4=Grievous Gladiator's Ringmail Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 103289, "", "=q4=Grievous Gladiator's Ringmail Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 103291, "", "=q4=Grievous Gladiator's Ringmail Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="};
				{ 11, 103487, "", "=q4=Prideful Gladiator's Ringmail Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103489, "", "=q4=Prideful Gladiator's Ringmail Spaulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103485, "", "=q4=Prideful Gladiator's Ringmail Armor", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103486, "", "=q4=Prideful Gladiator's Ringmail Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103488, "", "=q4=Prideful Gladiator's Ringmail Leggings", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="};
				{ 17, 102915, "", "=q4=Grievous Gladiator's Ringmail Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102852, "", "=q4=Grievous Gladiator's Ringmail Spaulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102914, "", "=q4=Grievous Gladiator's Ringmail Armor", "=ds=", "#HONOR:2250#"};
				{ 20, 102971, "", "=q4=Grievous Gladiator's Ringmail Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102916, "", "=q4=Grievous Gladiator's Ringmail Leggings", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="};
				{ 2, 103100, "", "=q4=Prideful Gladiator's Ringmail Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103102, "", "=q4=Prideful Gladiator's Ringmail Spaulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103098, "", "=q4=Prideful Gladiator's Ringmail Armor", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103099, "", "=q4=Prideful Gladiator's Ringmail Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103095, "", "=q4=Prideful Gladiator's Ringmail Waistguard", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103101, "", "=q4=Prideful Gladiator's Ringmail Leggings", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103096, "", "=q4=Prideful Gladiator's Ringmail Footguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="};
				{ 26, 98896, "", "=q3=Crafted Malevolent Gladiator's Ringmail Helm", "=ds="};
				{ 27, 98898, "", "=q3=Crafted Malevolent Gladiator's Ringmail Spaulders", "=ds="};
				{ 28, 98894, "", "=q3=Crafted Malevolent Gladiator's Ringmail Armor", "=ds="};
				{ 29, 98895, "", "=q3=Crafted Malevolent Gladiator's Ringmail Gauntlets", "=ds="};
				{ 30, 98897, "", "=q3=Crafted Malevolent Gladiator's Ringmail Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90Warlock"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="};
				{ 11, 102726, "", "=q4=Prideful Gladiator's Felweave Cowl", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102682, "", "=q4=Prideful Gladiator's Felweave Amice", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102661, "", "=q4=Prideful Gladiator's Felweave Raiment", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102725, "", "=q4=Prideful Gladiator's Felweave Handguards", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102755, "", "=q4=Prideful Gladiator's Felweave Trousers", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="};
				{ 17, 103324, "", "=q4=Grievous Gladiator's Felweave Cowl", "=ds=", "#HONOR:2250#"};
				{ 18, 103327, "", "=q4=Grievous Gladiator's Felweave Amice", "=ds=", "#HONOR:1750#"};
				{ 19, 103326, "", "=q4=Grievous Gladiator's Felweave Raiment", "=ds=", "#HONOR:2250#"};
				{ 20, 103323, "", "=q4=Grievous Gladiator's Felweave Handguards", "=ds=", "#HONOR:1750#"};
				{ 21, 103325, "", "=q4=Grievous Gladiator's Felweave Trousers", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="};
				{ 11, 103521, "", "=q4=Prideful Gladiator's Felweave Cowl", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103524, "", "=q4=Prideful Gladiator's Felweave Amice", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103523, "", "=q4=Prideful Gladiator's Felweave Raiment", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103520, "", "=q4=Prideful Gladiator's Felweave Handguards", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103522, "", "=q4=Prideful Gladiator's Felweave Trousers", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="};
				{ 17, 102923, "", "=q4=Grievous Gladiator's Felweave Cowl", "=ds=", "#HONOR:2250#"};
				{ 18, 102879, "", "=q4=Grievous Gladiator's Felweave Amice", "=ds=", "#HONOR:1750#"};
				{ 19, 102858, "", "=q4=Grievous Gladiator's Felweave Raiment", "=ds=", "#HONOR:2250#"};
				{ 20, 102922, "", "=q4=Grievous Gladiator's Felweave Handguards", "=ds=", "#HONOR:1750#"};
				{ 21, 102952, "", "=q4=Grievous Gladiator's Felweave Trousers", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="};
				{ 2, 103124, "", "=q4=Prideful Gladiator's Felweave Cowl", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103127, "", "=q4=Prideful Gladiator's Felweave Amice", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103126, "", "=q4=Prideful Gladiator's Felweave Raiment", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103123, "", "=q4=Prideful Gladiator's Felweave Handguards", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 102992, "", "=q4=Prideful Gladiator's Felweave Cord", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103125, "", "=q4=Prideful Gladiator's Felweave Trousers", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 102995, "", "=q4=Prideful Gladiator's Felweave Treads", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="};
				{ 26, 98922, "", "=q3=Crafted Malevolent Gladiator's Felweave Cowl", "=ds="};
				{ 27, 98925, "", "=q3=Crafted Malevolent Gladiator's Felweave Amice", "=ds="};
				{ 28, 98924, "", "=q3=Crafted Malevolent Gladiator's Felweave Raiment", "=ds="};
				{ 29, 98921, "", "=q3=Crafted Malevolent Gladiator's Felweave Handguards", "=ds="};
				{ 30, 98923, "", "=q3=Crafted Malevolent Gladiator's Felweave Trousers", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "PVP90SET",
		};
	}

	AtlasLoot_Data["PVP90Warrior"] = {
		["Normal_A"] = {
			{
				{ 10, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="};
				{ 11, 102619, "", "=q4=Prideful Gladiator's Plate Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 102685, "", "=q4=Prideful Gladiator's Plate Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102728, "", "=q4=Prideful Gladiator's Plate Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 14, 102618, "", "=q4=Prideful Gladiator's Plate Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102732, "", "=q4=Prideful Gladiator's Plate Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="};
				{ 17, 103330, "", "=q4=Grievous Gladiator's Plate Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 103332, "", "=q4=Grievous Gladiator's Plate Shoulders", "=ds=", "#HONOR:1750#"};
				{ 19, 103328, "", "=q4=Grievous Gladiator's Plate Chestpiece", "=ds=", "#HONOR:2250#"};
				{ 20, 103329, "", "=q4=Grievous Gladiator's Plate Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 103331, "", "=q4=Grievous Gladiator's Plate Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 10, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="};
				{ 11, 103527, "", "=q4=Prideful Gladiator's Plate Helm", "=ds=", "#CONQUEST:2250#"};
				{ 12, 103529, "", "=q4=Prideful Gladiator's Plate Shoulders", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103525, "", "=q4=Prideful Gladiator's Plate Chestpiece", "=ds=", "#CONQUEST:2250#"};
				{ 14, 103526, "", "=q4=Prideful Gladiator's Plate Gauntlets", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103528, "", "=q4=Prideful Gladiator's Plate Legguards", "=ds=", "#CONQUEST:2250#"};
				{ 16, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="};
				{ 17, 102816, "", "=q4=Grievous Gladiator's Plate Helm", "=ds=", "#HONOR:2250#"};
				{ 18, 102882, "", "=q4=Grievous Gladiator's Plate Shoulders", "=ds=", "#HONOR:1750#"};
				{ 19, 102925, "", "=q4=Grievous Gladiator's Plate Chestpiece", "=ds=", "#HONOR:2250#"};
				{ 20, 102815, "", "=q4=Grievous Gladiator's Plate Gauntlets", "=ds=", "#HONOR:1750#"};
				{ 21, 102929, "", "=q4=Grievous Gladiator's Plate Legguards", "=ds=", "#HONOR:2250#"};
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="};
				{ 2, 103130, "", "=q4=Prideful Gladiator's Plate Helm", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 3, 103132, "", "=q4=Prideful Gladiator's Plate Shoulders", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 4, 103128, "", "=q4=Prideful Gladiator's Plate Chestpiece", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 5, 103129, "", "=q4=Prideful Gladiator's Plate Gauntlets", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 6, 103074, "", "=q4=Prideful Gladiator's Plate Girdle", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 7, 103131, "", "=q4=Prideful Gladiator's Plate Legguards", "=ds=", "#CONQUEST:2250#"..AL["Rating:"].." 2000"};
				{ 8, 103075, "", "=q4=Prideful Gladiator's Plate Warboots", "=ds=", "#CONQUEST:1750#"..AL["Rating:"].." 2000"};
				{ 25, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="};
				{ 26, 98928, "", "=q3=Crafted Malevolent Gladiator's Plate Helm", "=ds="};
				{ 27, 98930, "", "=q3=Crafted Malevolent Gladiator's Plate Shoulders", "=ds="};
				{ 28, 98926, "", "=q3=Crafted Malevolent Gladiator's Plate Chestpiece", "=ds="};
				{ 29, 98927, "", "=q3=Crafted Malevolent Gladiator's Plate Gauntlets", "=ds="};
				{ 30, 98929, "", "=q3=Crafted Malevolent Gladiator's Plate Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "PVP90SET",
		};
	}

		------------------------------
		--- Level 90 - Accessories ---
		------------------------------

	AtlasLoot_Data["PVP90Accessories"] = {
		["Normal_A"] = {
			{
				{ 1, 102705, "", "=q4=Prideful Gladiator's Cape of Cruelty", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 2, 102642, "", "=q4=Prideful Gladiator's Cape of Prowess", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 3, 102769, "", "=q4=Prideful Gladiator's Cloak of Alacrity", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 4, 102770, "", "=q4=Prideful Gladiator's Cloak of Prowess", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 5, 102669, "", "=q4=Prideful Gladiator's Drape of Cruelty", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 6, 102756, "", "=q4=Prideful Gladiator's Drape of Meditation", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 7, 102772, "", "=q4=Prideful Gladiator's Drape of Prowess", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 9, 102649, "", "=q4=Prideful Gladiator's Band of Accuracy", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 10, 102674, "", "=q4=Prideful Gladiator's Band of Cruelty", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 11, 102758, "", "=q4=Prideful Gladiator's Band of Meditation", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 12, 102683, "", "=q4=Prideful Gladiator's Ring of Accuracy", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 13, 102644, "", "=q4=Prideful Gladiator's Ring of Cruelty", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 14, 102746, "", "=q4=Prideful Gladiator's Signet of Accuracy", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 15, 102701, "", "=q4=Prideful Gladiator's Signet of Cruelty", "=ds=#s13#", "#CONQUEST:1250#"},
				{ 16, 102641, "", "=q4=Prideful Gladiator's Choker of Accuracy", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 17, 102749, "", "=q4=Prideful Gladiator's Choker of Proficiency", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 18, 102678, "", "=q4=Prideful Gladiator's Necklace of Proficiency", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 19, 102679, "", "=q4=Prideful Gladiator's Necklace of Prowess", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 20, 102757, "", "=q4=Prideful Gladiator's Pendant of Alacrity", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 21, 102773, "", "=q4=Prideful Gladiator's Pendant of Cruelty", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 22, 102736, "", "=q4=Prideful Gladiator's Pendant of Meditation", "=ds=#s2#", "#CONQUEST:1250#"},
				merge = true;
			};
			{
				{ 2, 102659, "", "=q4=Prideful Gladiator's Badge of Conquest", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 3, 102633, "", "=q4=Prideful Gladiator's Badge of Dominance", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 4, 102636, "", "=q4=Prideful Gladiator's Badge of Victory", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 6, 102680, "", "=q4=Prideful Gladiator's Emblem of Cruelty", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 7, 102616, "", "=q4=Prideful Gladiator's Emblem of Meditation", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 8, 102706, "", "=q4=Prideful Gladiator's Emblem of Tenacity", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 17, 102738, "", "=q4=Prideful Gladiator's Medallion of Cruelty", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 18, 102625, "", "=q4=Prideful Gladiator's Medallion of Meditation", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 19, 102672, "", "=q4=Prideful Gladiator's Medallion of Tenacity", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 21, 102643, "", "=q4=Prideful Gladiator's Insignia of Conquest", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 22, 102766, "", "=q4=Prideful Gladiator's Insignia of Dominance", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 23, 102699, "", "=q4=Prideful Gladiator's Insignia of Victory", "=ds=#s14#", "#CONQUEST:1750#" },
			};
			{
				{ 1, 103146, "", "=q4=Grievous Gladiator's Cape of Cruelty", "=ds=#s4#", "#HONOR:1250#"},
				{ 2, 103147, "", "=q4=Grievous Gladiator's Cape of Prowess", "=ds=#s4#", "#HONOR:1250#"},
				{ 3, 103315, "", "=q4=Grievous Gladiator's Cloak of Alacrity", "=ds=#s4#", "#HONOR:1250#"},
				{ 4, 103316, "", "=q4=Grievous Gladiator's Cloak of Prowess", "=ds=#s4#", "#HONOR:1250#"},
				{ 5, 103163, "", "=q4=Grievous Gladiator's Drape of Cruelty", "=ds=#s4#", "#HONOR:1250#"},
				{ 6, 103165, "", "=q4=Grievous Gladiator's Drape of Meditation", "=ds=#s4#", "#HONOR:1250#"},
				{ 7, 103164, "", "=q4=Grievous Gladiator's Drape of Prowess", "=ds=#s4#", "#HONOR:1250#"},
				{ 9, 103174, "", "=q4=Grievous Gladiator's Band of Accuracy", "=ds=#s13#", "#HONOR:1250#"},
				{ 10, 103173, "", "=q4=Grievous Gladiator's Band of Cruelty", "=ds=#s13#", "#HONOR:1250#"},
				{ 11, 103175, "", "=q4=Grievous Gladiator's Band of Meditation", "=ds=#s13#", "#HONOR:1250#"},
				{ 12, 103152, "", "=q4=Grievous Gladiator's Ring of Accuracy", "=ds=#s13#", "#HONOR:1250#"},
				{ 13, 103151, "", "=q4=Grievous Gladiator's Ring of Cruelty", "=ds=#s13#", "#HONOR:1250#"},
				{ 14, 103321, "", "=q4=Grievous Gladiator's Signet of Accuracy", "=ds=#s13#", "#HONOR:1250#"},
				{ 15, 103320, "", "=q4=Grievous Gladiator's Signet of Cruelty", "=ds=#s13#", "#HONOR:1250#"},
				{ 16, 103318, "", "=q4=Grievous Gladiator's Choker of Accuracy", "=ds=#s2#", "#HONOR:1250#"},
				{ 17, 103317, "", "=q4=Grievous Gladiator's Choker of Proficiency", "=ds=#s2#", "#HONOR:1250#"},
				{ 18, 103148, "", "=q4=Grievous Gladiator's Necklace of Proficiency", "=ds=#s2#", "#HONOR:1250#"},
				{ 19, 103149, "", "=q4=Grievous Gladiator's Necklace of Prowess", "=ds=#s2#", "#HONOR:1250#"},
				{ 20, 103171, "", "=q4=Grievous Gladiator's Pendant of Alacrity", "=ds=#s2#", "#HONOR:1250#"},
				{ 21, 103170, "", "=q4=Grievous Gladiator's Pendant of Cruelty", "=ds=#s2#", "#HONOR:1250#"},
				{ 22, 103172, "", "=q4=Grievous Gladiator's Pendant of Meditation", "=ds=#s2#", "#HONOR:1250#"},
			};
			{
				{ 1, 103145, "", "=q4=Grievous Gladiator's Badge of Conquest", "=ds=#s14#", "#HONOR:1750#" },
				{ 2, 103308, "", "=q4=Grievous Gladiator's Badge of Dominance", "=ds=#s14#", "#HONOR:1750#" },
				{ 3, 103314, "", "=q4=Grievous Gladiator's Badge of Victory", "=ds=#s14#", "#HONOR:1750#" },
				{ 5, 103210, "", "=q4=Grievous Gladiator's Emblem of Cruelty", "=ds=#s14#", "#HONOR:1750#" },
				{ 6, 103212, "", "=q4=Grievous Gladiator's Emblem of Meditation", "=ds=#s14#", "#HONOR:1750#" },
				{ 7, 103211, "", "=q4=Grievous Gladiator's Emblem of Tenacity", "=ds=#s14#", "#HONOR:1750#" },
				{ 9, 103334, "", "=q4=Grievous Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1750#" },
				{ 10, 103335, "", "=q4=Grievous Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1750#" },
				{ 11, 103333, "", "=q4=Grievous Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1750#" },
				{ 13, 103150, "", "=q4=Grievous Gladiator's Insignia of Conquest", "=ds=#s14#", "#HONOR:1750#" },
				{ 14, 103309, "", "=q4=Grievous Gladiator's Insignia of Dominance", "=ds=#s14#", "#HONOR:1750#" },
				{ 15, 103319, "", "=q4=Grievous Gladiator's Insignia of Victory", "=ds=#s14#", "#HONOR:1750#" },
				merge = true;
			};
		};
		["Normal_H"] = {
			{
				{ 1, 103343, "", "=q4=Prideful Gladiator's Cape of Cruelty", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 2, 103344, "", "=q4=Prideful Gladiator's Cape of Prowess", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 3, 103512, "", "=q4=Prideful Gladiator's Cloak of Alacrity", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 4, 103513, "", "=q4=Prideful Gladiator's Cloak of Prowess", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 5, 103360, "", "=q4=Prideful Gladiator's Drape of Cruelty", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 6, 103362, "", "=q4=Prideful Gladiator's Drape of Meditation", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 7, 103361, "", "=q4=Prideful Gladiator's Drape of Prowess", "=ds=#s4#", "#CONQUEST:1250#"},
				{ 9, 103371, "", "=q4=Prideful Gladiator's Band of Accuracy", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 10, 103370, "", "=q4=Prideful Gladiator's Band of Cruelty", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 11, 103372, "", "=q4=Prideful Gladiator's Band of Meditation", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 12, 103349, "", "=q4=Prideful Gladiator's Ring of Accuracy", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 13, 103348, "", "=q4=Prideful Gladiator's Ring of Cruelty", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 14, 103518, "", "=q4=Prideful Gladiator's Signet of Accuracy", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 15, 103517, "", "=q4=Prideful Gladiator's Signet of Cruelty", "=ds=#s13#", "#CONQUEST:1250#"};
				{ 16, 103515, "", "=q4=Prideful Gladiator's Choker of Accuracy", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 17, 103514, "", "=q4=Prideful Gladiator's Choker of Proficiency", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 18, 103345, "", "=q4=Prideful Gladiator's Necklace of Proficiency", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 19, 103346, "", "=q4=Prideful Gladiator's Necklace of Prowess", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 20, 103368, "", "=q4=Prideful Gladiator's Pendant of Alacrity", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 21, 103367, "", "=q4=Prideful Gladiator's Pendant of Cruelty", "=ds=#s2#", "#CONQUEST:1250#"},
				{ 22, 103369, "", "=q4=Prideful Gladiator's Pendant of Meditation", "=ds=#s2#", "#CONQUEST:1250#"},
				merge = true;
			};
			{
				{ 2, 103342, "", "=q4=Prideful Gladiator's Badge of Conquest", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 3, 103505, "", "=q4=Prideful Gladiator's Badge of Dominance", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 4, 103511, "", "=q4=Prideful Gladiator's Badge of Victory", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 6, 103407, "", "=q4=Prideful Gladiator's Emblem of Cruelty", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 7, 103409, "", "=q4=Prideful Gladiator's Emblem of Meditation", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 8, 103408, "", "=q4=Prideful Gladiator's Emblem of Tenacity", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 17, 103531, "", "=q4=Prideful Gladiator's Medallion of Cruelty", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 18, 103532, "", "=q4=Prideful Gladiator's Medallion of Meditation", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 19, 103530, "", "=q4=Prideful Gladiator's Medallion of Tenacity", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 21, 103347, "", "=q4=Prideful Gladiator's Insignia of Conquest", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 22, 103506, "", "=q4=Prideful Gladiator's Insignia of Dominance", "=ds=#s14#", "#CONQUEST:1750#" },
				{ 23, 103516, "", "=q4=Prideful Gladiator's Insignia of Victory", "=ds=#s14#", "#CONQUEST:1750#" },
			};
			{
				{ 1, 102902, "", "=q4=Grievous Gladiator's Cape of Cruelty", "=ds=#s4#", "#HONOR:1250#"},
				{ 2, 102839, "", "=q4=Grievous Gladiator's Cape of Prowess", "=ds=#s4#", "#HONOR:1250#"},
				{ 3, 102966, "", "=q4=Grievous Gladiator's Cloak of Alacrity", "=ds=#s4#", "#HONOR:1250#"},
				{ 4, 102967, "", "=q4=Grievous Gladiator's Cloak of Prowess", "=ds=#s4#", "#HONOR:1250#"},
				{ 5, 102866, "", "=q4=Grievous Gladiator's Drape of Cruelty", "=ds=#s4#", "#HONOR:1250#"},
				{ 6, 102953, "", "=q4=Grievous Gladiator's Drape of Meditation", "=ds=#s4#", "#HONOR:1250#"},
				{ 7, 102969, "", "=q4=Grievous Gladiator's Drape of Prowess", "=ds=#s4#", "#HONOR:1250#"},
				{ 9, 102846, "", "=q4=Grievous Gladiator's Band of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 10, 102871, "", "=q4=Grievous Gladiator's Band of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 11, 102955, "", "=q4=Grievous Gladiator's Band of Meditation", "=ds=#s13#", "#HONOR:1250#"};
				{ 12, 102880, "", "=q4=Grievous Gladiator's Ring of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 13, 102841, "", "=q4=Grievous Gladiator's Ring of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 14, 102943, "", "=q4=Grievous Gladiator's Signet of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 15, 102898, "", "=q4=Grievous Gladiator's Signet of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 16, 102838, "", "=q4=Grievous Gladiator's Choker of Accuracy", "=ds=#s2#", "#HONOR:1250#"},
				{ 17, 102946, "", "=q4=Grievous Gladiator's Choker of Proficiency", "=ds=#s2#", "#HONOR:1250#"},
				{ 18, 102875, "", "=q4=Grievous Gladiator's Necklace of Proficiency", "=ds=#s2#", "#HONOR:1250#"},
				{ 19, 102876, "", "=q4=Grievous Gladiator's Necklace of Prowess", "=ds=#s2#", "#HONOR:1250#"},
				{ 20, 102954, "", "=q4=Grievous Gladiator's Pendant of Alacrity", "=ds=#s2#", "#HONOR:1250#"},
				{ 21, 102970, "", "=q4=Grievous Gladiator's Pendant of Cruelty", "=ds=#s2#", "#HONOR:1250#"},
				{ 22, 102933, "", "=q4=Grievous Gladiator's Pendant of Meditation", "=ds=#s2#", "#HONOR:1250#"},
			};
			{
				{ 1, 102856, "", "=q4=Grievous Gladiator's Badge of Conquest", "=ds=#s14#", "#HONOR:1750#" },
				{ 2, 102830, "", "=q4=Grievous Gladiator's Badge of Dominance", "=ds=#s14#", "#HONOR:1750#" },
				{ 3, 102833, "", "=q4=Grievous Gladiator's Badge of Victory", "=ds=#s14#", "#HONOR:1750#" },
				{ 5, 102877, "", "=q4=Grievous Gladiator's Emblem of Cruelty", "=ds=#s14#", "#HONOR:1750#" },
				{ 6, 102813, "", "=q4=Grievous Gladiator's Emblem of Meditation", "=ds=#s14#", "#HONOR:1750#" },
				{ 7, 102903, "", "=q4=Grievous Gladiator's Emblem of Tenacity", "=ds=#s14#", "#HONOR:1750#" },
				{ 9, 102935, "", "=q4=Grievous Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1750#" },
				{ 10, 102822, "", "=q4=Grievous Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1750#" },
				{ 11, 102869, "", "=q4=Grievous Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1750#" },
				{ 13, 102840, "", "=q4=Grievous Gladiator's Insignia of Conquest", "=ds=#s14#", "#HONOR:1750#" },
				{ 14, 102963, "", "=q4=Grievous Gladiator's Insignia of Dominance", "=ds=#s14#", "#HONOR:1750#" },
				{ 15, 102896, "", "=q4=Grievous Gladiator's Insignia of Victory", "=ds=#s14#", "#HONOR:1750#" },
				merge = true;
			};
		};
		["Normal"] = {
			{
				{ 24, 103635, "", "=q4=Prideful Gladiator's Greatcloak", "=ds=#s4#", "#CONQUEST:1000#"..AL["Rating:"].." 2500"},
				{ 25, 103636, "", "=q4=Prideful Gladiator's Tabard", "=ds=#s7#", "#CONQUEST:1000#"..AL["Rating:"].." 2500"},
				{ 26, 95348, "", "=q4=Tyrannical Primal Diamond", "=ds=#e32# #e7#", "#CONQUEST:1000#"},
				{ 27, 98163, "", "=q3=Enchant Weapon - Bloody Dancing Steel", "=ds=#e17#", "#ITEMID:74726#"},
				{ 28, 95349, "", "=q3=Enchant Weapon - Glorious Tyranny", "=ds=#e17#", "#CONQUEST:1000#"},
				{ 29, 98164, "", "=q3=Enchant Weapon - Spirit of Conquest", "=ds=#e17#", "#ITEMID:74724#"},
				{ 30, 76061, "", "=q3=Spirit of Harmony", "=ds=#e8#", "#CONQUEST:600#"},
			};
			{};
			{};
			{
				{ 16, 98756, "", "=q3=Crafted Malevolent Gladiator's Cape of Cruelty", "=ds=#s4#"},
				{ 17, 98757, "", "=q3=Crafted Malevolent Gladiator's Cape of Prowess", "=ds=#s4#"},
				{ 18, 98913, "", "=q3=Crafted Malevolent Gladiator's Cloak of Alacrity", "=ds=#s4#"},
				{ 19, 98914, "", "=q3=Crafted Malevolent Gladiator's Cloak of Prowess", "=ds=#s4#"},
				{ 20, 98772, "", "=q3=Crafted Malevolent Gladiator's Drape of Cruelty", "=ds=#s4#"},
				{ 21, 98774, "", "=q3=Crafted Malevolent Gladiator's Drape of Meditation", "=ds=#s4#"},
				{ 22, 98773, "", "=q3=Crafted Malevolent Gladiator's Drape of Prowess", "=ds=#s4#"},
				{ 24, 102483, "", "=q3=Crafted Malevolent Gladiator's Medallion of Tenacity", "=ds=#s14#"},
			};
		};
		info = {
			name = AL["PvP Accessories"],
			module = moduleName, menu = "PVPMENU",
		};
	}

		--------------------------------
		--- Level 90 - Non Set Epics ---
		--------------------------------

	AtlasLoot_Data["PVP90NonSetCloth"] = {
		["Normal_A"] = {
			{
				{ 1, 102687, "", "=q4=Prideful Gladiator's Cuffs of Accuracy", "=ds=", "#CONQUEST:1250#"};
				{ 2, 102662, "", "=q4=Prideful Gladiator's Cord of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 3, 102620, "", "=q4=Prideful Gladiator's Treads of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 5, 102666, "", "=q4=Prideful Gladiator's Cuffs of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 6, 102709, "", "=q4=Prideful Gladiator's Cord of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 7, 102752, "", "=q4=Prideful Gladiator's Treads of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 9, 102733, "", "=q4=Prideful Gladiator's Cuffs of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 10, 102684, "", "=q4=Prideful Gladiator's Cord of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 102686, "", "=q4=Prideful Gladiator's Treads of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 16, 103160, "", "=q4=Grievous Gladiator's Cuffs of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 103155, "", "=q4=Grievous Gladiator's Cord of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 18, 103158, "", "=q4=Grievous Gladiator's Treads of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 20, 103162, "", "=q4=Grievous Gladiator's Cuffs of Meditation", "=ds=", "#HONOR:1250#"};
				{ 21, 103156, "", "=q4=Grievous Gladiator's Cord of Meditation", "=ds=", "#HONOR:1750#"};
				{ 22, 103159, "", "=q4=Grievous Gladiator's Treads of Meditation", "=ds=", "#HONOR:1750#"};
				{ 24, 103161, "", "=q4=Grievous Gladiator's Cuffs of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 103154, "", "=q4=Grievous Gladiator's Cord of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 103157, "", "=q4=Grievous Gladiator's Treads of Cruelty", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 103357, "", "=q4=Prideful Gladiator's Cuffs of Accuracy", "=ds=", "#CONQUEST:1250#"};
				{ 2, 103352, "", "=q4=Prideful Gladiator's Cord of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 3, 103355, "", "=q4=Prideful Gladiator's Treads of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 5, 103359, "", "=q4=Prideful Gladiator's Cuffs of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 6, 103353, "", "=q4=Prideful Gladiator's Cord of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 7, 103356, "", "=q4=Prideful Gladiator's Treads of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 9, 103358, "", "=q4=Prideful Gladiator's Cuffs of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 10, 103351, "", "=q4=Prideful Gladiator's Cord of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 103354, "", "=q4=Prideful Gladiator's Treads of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 16, 102884, "", "=q4=Grievous Gladiator's Cuffs of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 102859, "", "=q4=Grievous Gladiator's Cord of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 18, 102817, "", "=q4=Grievous Gladiator's Treads of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 20, 102863, "", "=q4=Grievous Gladiator's Cuffs of Meditation", "=ds=", "#HONOR:1250#"};
				{ 21, 102906, "", "=q4=Grievous Gladiator's Cord of Meditation", "=ds=", "#HONOR:1750#"};
				{ 22, 102949, "", "=q4=Grievous Gladiator's Treads of Meditation", "=ds=", "#HONOR:1750#"};
				{ 24, 102930, "", "=q4=Grievous Gladiator's Cuffs of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 102881, "", "=q4=Grievous Gladiator's Cord of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 102883, "", "=q4=Grievous Gladiator's Treads of Cruelty", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal"] = {
			{};
			{
				{ 1, 98769, "", "=q3=Crafted Malevolent Gladiator's Cuffs of Accuracy", "=ds="};
				{ 2, 98764, "", "=q3=Crafted Malevolent Gladiator's Cord of Accuracy", "=ds="};
				{ 3, 98767, "", "=q3=Crafted Malevolent Gladiator's Treads of Alacrity", "=ds="};
				{ 5, 98771, "", "=q3=Crafted Malevolent Gladiator's Cuffs of Meditation", "=ds="};
				{ 6, 98765, "", "=q3=Crafted Malevolent Gladiator's Cord of Meditation", "=ds="};
				{ 7, 98768, "", "=q3=Crafted Malevolent Gladiator's Treads of Meditation", "=ds="};
				{ 9, 98770, "", "=q3=Crafted Malevolent Gladiator's Cuffs of Prowess", "=ds="};
				{ 10, 98763, "", "=q3=Crafted Malevolent Gladiator's Cord of Cruelty", "=ds="};
				{ 11, 98766, "", "=q3=Crafted Malevolent Gladiator's Treads of Cruelty", "=ds="};
			};
		};
		info = {
			name = AL["PvP Non-Set Epics"]..": "..BabbleInventory["Cloth"],
			module = moduleName, menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVP90NonSetLeather"] = {
		["Normal_A"] = {
			{
				{ 1, 102711, "", "=q4=Prideful Gladiator's Armwraps of Accuracy", "=ds=", "#CONQUEST:1250#"};
				{ 2, 102708, "", "=q4=Prideful Gladiator's Waistband of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 3, 102660, "", "=q4=Prideful Gladiator's Boots of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 5, 102754, "", "=q4=Prideful Gladiator's Armwraps of Alacrity", "=ds=", "#CONQUEST:1250#"};
				{ 6, 102647, "", "=q4=Prideful Gladiator's Waistband of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 7, 102716, "", "=q4=Prideful Gladiator's Boots of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 9, 102723, "", "=q4=Prideful Gladiator's Bindings of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 10, 102694, "", "=q4=Prideful Gladiator's Belt of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 102631, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102691, "", "=q4=Prideful Gladiator's Bindings of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 14, 102775, "", "=q4=Prideful Gladiator's Belt of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102760, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 16, 103231, "", "=q4=Grievous Gladiator's Armwraps of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 103275, "", "=q4=Grievous Gladiator's Waistband of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 18, 103276, "", "=q4=Grievous Gladiator's Boots of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 20, 103277, "", "=q4=Grievous Gladiator's Armwraps of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 21, 103229, "", "=q4=Grievous Gladiator's Waistband of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 22, 103230, "", "=q4=Grievous Gladiator's Boots of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 24, 103200, "", "=q4=Grievous Gladiator's Bindings of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 103198, "", "=q4=Grievous Gladiator's Belt of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 103199, "", "=q4=Grievous Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 28, 103191, "", "=q4=Grievous Gladiator's Bindings of Meditation", "=ds=", "#HONOR:1250#"};
				{ 29, 103189, "", "=q4=Grievous Gladiator's Belt of Meditation", "=ds=", "#HONOR:1750#"};
				{ 30, 103190, "", "=q4=Grievous Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 103428, "", "=q4=Prideful Gladiator's Armwraps of Accuracy", "=ds=", "#CONQUEST:1250#"};
				{ 2, 103472, "", "=q4=Prideful Gladiator's Waistband of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 3, 103473, "", "=q4=Prideful Gladiator's Boots of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 5, 103474, "", "=q4=Prideful Gladiator's Armwraps of Alacrity", "=ds=", "#CONQUEST:1250#"};
				{ 6, 103426, "", "=q4=Prideful Gladiator's Waistband of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 7, 103427, "", "=q4=Prideful Gladiator's Boots of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 9, 103397, "", "=q4=Prideful Gladiator's Bindings of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 10, 103395, "", "=q4=Prideful Gladiator's Belt of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 103396, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103388, "", "=q4=Prideful Gladiator's Bindings of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 14, 103386, "", "=q4=Prideful Gladiator's Belt of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102623, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 16, 102908, "", "=q4=Grievous Gladiator's Armwraps of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 102905, "", "=q4=Grievous Gladiator's Waistband of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 18, 102857, "", "=q4=Grievous Gladiator's Boots of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 20, 102951, "", "=q4=Grievous Gladiator's Armwraps of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 21, 102844, "", "=q4=Grievous Gladiator's Waistband of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 22, 102913, "", "=q4=Grievous Gladiator's Boots of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 24, 102920, "", "=q4=Grievous Gladiator's Bindings of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 102891, "", "=q4=Grievous Gladiator's Belt of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 102828, "", "=q4=Grievous Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 28, 102888, "", "=q4=Grievous Gladiator's Bindings of Meditation", "=ds=", "#HONOR:1250#"};
				{ 29, 102972, "", "=q4=Grievous Gladiator's Belt of Meditation", "=ds=", "#HONOR:1750#"};
				{ 30, 102957, "", "=q4=Grievous Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal"] = {
			{};
			{
				{ 1, 98832, "", "=q3=Crafted Malevolent Gladiator's Armwraps of Accuracy", "=ds="};
				{ 2, 98881, "", "=q3=Crafted Malevolent Gladiator's Waistband of Accuracy", "=ds="};
				{ 3, 98882, "", "=q3=Crafted Malevolent Gladiator's Boots of Cruelty", "=ds="};
				{ 5, 98883, "", "=q3=Crafted Malevolent Gladiator's Armwraps of Alacrity", "=ds="};
				{ 6, 98830, "", "=q3=Crafted Malevolent Gladiator's Waistband of Cruelty", "=ds="};
				{ 7, 98831, "", "=q3=Crafted Malevolent Gladiator's Boots of Alacrity", "=ds="};
				{ 9, 98804, "", "=q3=Crafted Malevolent Gladiator's Bindings of Prowess", "=ds="};
				{ 10, 98802, "", "=q3=Crafted Malevolent Gladiator's Belt of Cruelty", "=ds="};
				{ 11, 98803, "", "=q3=Crafted Malevolent Gladiator's Footguards of Alacrity", "=ds="};
				{ 13, 98796, "", "=q3=Crafted Malevolent Gladiator's Bindings of Meditation", "=ds="};
				{ 14, 98794, "", "=q3=Crafted Malevolent Gladiator's Belt of Meditation", "=ds="};
				{ 15, 98795, "", "=q3=Crafted Malevolent Gladiator's Footguards of Meditation", "=ds="};
			};
		};
		info = {
			name = AL["PvP Non-Set Epics"]..": "..BabbleInventory["Leather"],
			module = moduleName, menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVP90NonSetMail"] = {
		["Normal_A"] = {
			{
				{ 1, 102624, "", "=q4=Prideful Gladiator's Armbands of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 2, 102668, "", "=q4=Prideful Gladiator's Waistguard of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 3, 102623, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 5, 102665, "", "=q4=Prideful Gladiator's Armbands of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 6, 102677, "", "=q4=Prideful Gladiator's Waistguard of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 7, 102664, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 9, 102688, "", "=q4=Prideful Gladiator's Wristguards of Alacrity", "=ds=", "#CONQUEST:1250#"};
				{ 10, 102617, "", "=q4=Prideful Gladiator's Links of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 102646, "", "=q4=Prideful Gladiator's Sabatons of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102753, "", "=q4=Prideful Gladiator's Wristguards of Accuracy", "=ds=", "#CONQUEST:1250#"};
				{ 14, 102645, "", "=q4=Prideful Gladiator's Links of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102729, "", "=q4=Prideful Gladiator's Sabatons of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 16, 103287, "", "=q4=Grievous Gladiator's Armbands of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 103283, "", "=q4=Grievous Gladiator's Waistguard of Meditation", "=ds=", "#HONOR:1750#"};
				{ 18, 103285, "", "=q4=Grievous Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1750#"};
				{ 20, 103286, "", "=q4=Grievous Gladiator's Armbands of Prowess", "=ds=", "#HONOR:1250#"};
				{ 21, 103298, "", "=q4=Grievous Gladiator's Waistguard of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 22, 103284, "", "=q4=Grievous Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 24, 103217, "", "=q4=Grievous Gladiator's Wristguards of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 25, 103213, "", "=q4=Grievous Gladiator's Links of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 103216, "", "=q4=Grievous Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 28, 103218, "", "=q4=Grievous Gladiator's Wristguards of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 29, 103214, "", "=q4=Grievous Gladiator's Links of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 30, 103215, "", "=q4=Grievous Gladiator's Sabatons of Cruelty", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 103484, "", "=q4=Prideful Gladiator's Armbands of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 2, 103480, "", "=q4=Prideful Gladiator's Waistguard of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 3, 103482, "", "=q4=Prideful Gladiator's Footguards of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 5, 103483, "", "=q4=Prideful Gladiator's Armbands of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 6, 103495, "", "=q4=Prideful Gladiator's Waistguard of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 7, 103481, "", "=q4=Prideful Gladiator's Footguards of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 9, 103414, "", "=q4=Prideful Gladiator's Wristguards of Alacrity", "=ds=", "#CONQUEST:1250#"};
				{ 10, 103410, "", "=q4=Prideful Gladiator's Links of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 103413, "", "=q4=Prideful Gladiator's Sabatons of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103415, "", "=q4=Prideful Gladiator's Wristguards of Accuracy", "=ds=", "#CONQUEST:1250#"};
				{ 14, 103411, "", "=q4=Prideful Gladiator's Links of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103412, "", "=q4=Prideful Gladiator's Sabatons of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 16, 102821, "", "=q4=Grievous Gladiator's Armbands of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 102865, "", "=q4=Grievous Gladiator's Waistguard of Meditation", "=ds=", "#HONOR:1750#"};
				{ 18, 102820, "", "=q4=Grievous Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1750#"};
				{ 20, 102862, "", "=q4=Grievous Gladiator's Armbands of Prowess", "=ds=", "#HONOR:1250#"};
				{ 21, 102874, "", "=q4=Grievous Gladiator's Waistguard of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 22, 102861, "", "=q4=Grievous Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 24, 102885, "", "=q4=Grievous Gladiator's Wristguards of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 25, 102814, "", "=q4=Grievous Gladiator's Links of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 102843, "", "=q4=Grievous Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 28, 102950, "", "=q4=Grievous Gladiator's Wristguards of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 29, 102842, "", "=q4=Grievous Gladiator's Links of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 30, 102926, "", "=q4=Grievous Gladiator's Sabatons of Cruelty", "=ds=", "#HONOR:1750#"};
				merge = true;
			};
		};
		["Normal"] = {
			{};
			{
				{ 1, 98893, "", "=q3=Crafted Malevolent Gladiator's Armbands of Meditation", "=ds="};
				{ 2, 98889, "", "=q3=Crafted Malevolent Gladiator's Waistguard of Meditation", "=ds="};
				{ 3, 98891, "", "=q3=Crafted Malevolent Gladiator's Footguards of Meditation", "=ds="};
				{ 5, 98892, "", "=q3=Crafted Malevolent Gladiator's Armbands of Prowess", "=ds="};
				{ 6, 98904, "", "=q3=Crafted Malevolent Gladiator's Waistguard of Cruelty", "=ds="};
				{ 7, 98890, "", "=q3=Crafted Malevolent Gladiator's Footguards of Alacrity", "=ds="};
				{ 9, 98818, "", "=q3=Crafted Malevolent Gladiator's Wristguards of Alacrity", "=ds="};
				{ 10, 98814, "", "=q3=Crafted Malevolent Gladiator's Links of Cruelty", "=ds="};
				{ 11, 98817, "", "=q3=Crafted Malevolent Gladiator's Sabatons of Alacrity", "=ds="};
				{ 13, 98819, "", "=q3=Crafted Malevolent Gladiator's Wristguards of Accuracy", "=ds="};
				{ 14, 98815, "", "=q3=Crafted Malevolent Gladiator's Links of Accuracy", "=ds="};
				{ 15, 98816, "", "=q3=Crafted Malevolent Gladiator's Sabatons of Cruelty", "=ds="};
			};
		};
		info = {
			name = AL["PvP Non-Set Epics"]..": "..BabbleInventory["Mail"],
			module = moduleName, menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVP90NonSetPlate"] = {
		["Normal_A"] = {
			{
				{ 1, 102765, "", "=q4=Prideful Gladiator's Bracers of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 2, 102748, "", "=q4=Prideful Gladiator's Clasp of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 3, 102639, "", "=q4=Prideful Gladiator's Greaves of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 5, 102702, "", "=q4=Prideful Gladiator's Armplates of Proficiency", "=ds=", "#CONQUEST:1250#"};
				{ 6, 102640, "", "=q4=Prideful Gladiator's Girdle of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 7, 102698, "", "=q4=Prideful Gladiator's Warboots of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 9, 102695, "", "=q4=Prideful Gladiator's Bracers of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 10, 102764, "", "=q4=Prideful Gladiator's Clasp of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 102638, "", "=q4=Prideful Gladiator's Greaves of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 13, 102771, "", "=q4=Prideful Gladiator's Armplates of Alacrity", "=ds=", "#CONQUEST:1250#"};
				{ 14, 102724, "", "=q4=Prideful Gladiator's Girdle of Prowess", "=ds=", "#CONQUEST:1750#"};
				{ 15, 102745, "", "=q4=Prideful Gladiator's Warboots of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 16, 103252, "", "=q4=Grievous Gladiator's Bracers of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 103248, "", "=q4=Grievous Gladiator's Clasp of Meditation", "=ds=", "#HONOR:1750#"};
				{ 18, 103250, "", "=q4=Grievous Gladiator's Greaves of Meditation", "=ds=", "#HONOR:1750#"};
				{ 20, 103262, "", "=q4=Grievous Gladiator's Armplates of Proficiency", "=ds=", "#HONOR:1250#"};
				{ 21, 103258, "", "=q4=Grievous Gladiator's Girdle of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 22, 103260, "", "=q4=Grievous Gladiator's Warboots of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 24, 103251, "", "=q4=Grievous Gladiator's Bracers of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 103247, "", "=q4=Grievous Gladiator's Clasp of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 103249, "", "=q4=Grievous Gladiator's Greaves of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 28, 103263, "", "=q4=Grievous Gladiator's Armplates of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 29, 103259, "", "=q4=Grievous Gladiator's Girdle of Prowess", "=ds=", "#HONOR:1750#"};
				{ 30, 103261, "", "=q4=Grievous Gladiator's Warboots of Alacrity", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 103449, "", "=q4=Prideful Gladiator's Bracers of Meditation", "=ds=", "#CONQUEST:1250#"};
				{ 2, 103445, "", "=q4=Prideful Gladiator's Clasp of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 3, 103447, "", "=q4=Prideful Gladiator's Greaves of Meditation", "=ds=", "#CONQUEST:1750#"};
				{ 5, 103459, "", "=q4=Prideful Gladiator's Armplates of Proficiency", "=ds=", "#CONQUEST:1250#"};
				{ 6, 103455, "", "=q4=Prideful Gladiator's Girdle of Accuracy", "=ds=", "#CONQUEST:1750#"};
				{ 7, 103457, "", "=q4=Prideful Gladiator's Warboots of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 9, 103448, "", "=q4=Prideful Gladiator's Bracers of Prowess", "=ds=", "#CONQUEST:1250#"};
				{ 10, 103444, "", "=q4=Prideful Gladiator's Clasp of Cruelty", "=ds=", "#CONQUEST:1750#"};
				{ 11, 103446, "", "=q4=Prideful Gladiator's Greaves of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 13, 103460, "", "=q4=Prideful Gladiator's Armplates of Alacrity", "=ds=", "#CONQUEST:1250#"};
				{ 14, 103456, "", "=q4=Prideful Gladiator's Girdle of Prowess", "=ds=", "#CONQUEST:1750#"};
				{ 15, 103458, "", "=q4=Prideful Gladiator's Warboots of Alacrity", "=ds=", "#CONQUEST:1750#"};
				{ 16, 102962, "", "=q4=Grievous Gladiator's Bracers of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 102945, "", "=q4=Grievous Gladiator's Clasp of Meditation", "=ds=", "#HONOR:1750#"};
				{ 18, 102836, "", "=q4=Grievous Gladiator's Greaves of Meditation", "=ds=", "#HONOR:1750#"};
				{ 20, 102899, "", "=q4=Grievous Gladiator's Armplates of Proficiency", "=ds=", "#HONOR:1250#"};
				{ 21, 102837, "", "=q4=Grievous Gladiator's Girdle of Accuracy", "=ds=", "#HONOR:1750#"};
				{ 22, 102895, "", "=q4=Grievous Gladiator's Warboots of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 24, 102892, "", "=q4=Grievous Gladiator's Bracers of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 102961, "", "=q4=Grievous Gladiator's Clasp of Cruelty", "=ds=", "#HONOR:1750#"};
				{ 26, 102835, "", "=q4=Grievous Gladiator's Greaves of Alacrity", "=ds=", "#HONOR:1750#"};
				{ 28, 102968, "", "=q4=Grievous Gladiator's Armplates of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 29, 102921, "", "=q4=Grievous Gladiator's Girdle of Prowess", "=ds=", "#HONOR:1750#"};
				{ 30, 102942, "", "=q4=Grievous Gladiator's Warboots of Alacrity", "=ds=", "#HONOR:1750#"};
			};
		};
		["Normal"] = {
			{};
			{
				{ 1, 98853, "", "=q3=Crafted Malevolent Gladiator's Bracers of Meditation", "=ds="};
				{ 2, 98849, "", "=q3=Crafted Malevolent Gladiator's Clasp of Meditation", "=ds="};
				{ 3, 98851, "", "=q3=Crafted Malevolent Gladiator's Greaves of Meditation", "=ds="};
				{ 5, 98863, "", "=q3=Crafted Malevolent Gladiator's Armplates of Proficiency", "=ds="};
				{ 6, 98859, "", "=q3=Crafted Malevolent Gladiator's Girdle of Accuracy", "=ds="};
				{ 7, 98861, "", "=q3=Crafted Malevolent Gladiator's Warboots of Cruelty", "=ds="};
				{ 9, 98852, "", "=q3=Crafted Malevolent Gladiator's Bracers of Prowess", "=ds="};
				{ 10, 98848, "", "=q3=Crafted Malevolent Gladiator's Clasp of Cruelty", "=ds="};
				{ 11, 98850, "", "=q3=Crafted Malevolent Gladiator's Greaves of Alacrity", "=ds="};
				{ 13, 98864, "", "=q3=Crafted Malevolent Gladiator's Armplates of Alacrity", "=ds="};
				{ 14, 98860, "", "=q3=Crafted Malevolent Gladiator's Girdle of Prowess", "=ds="};
				{ 15, 98862, "", "=q3=Crafted Malevolent Gladiator's Warboots of Alacrity", "=ds="};
			};
		};
		info = {
			name = AL["PvP Non-Set Epics"]..": "..BabbleInventory["Plate"],
			module = moduleName, menu = "PVPMENU",
		};
	}

		--------------------------
		--- Level 90 - Weapons ---
		--------------------------

	AtlasLoot_Data["PVP90WeaponsPridefulElite"] = {
		["Normal"] = {
			{
				{ 1, 103116, "", "=q4=Prideful Gladiator's Render", "=ds=#h1#, #w13#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 2, 103115, "", "=q4=Prideful Gladiator's Ripper", "=ds=#h1#, #w13#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 4, 102999, "", "=q4=Prideful Gladiator's Spellblade", "=ds=#h1#, #w4#", "#CONQUEST:2250#"..AL["Rating:"].." 2000" },
				{ 5, 103114, "", "=q4=Prideful Gladiator's Shanker", "=ds=#h1#, #w4#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 7, 103117, "", "=q4=Prideful Gladiator's Mageblade", "=ds=#h1#, #w10#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 8, 102989, "", "=q4=Prideful Gladiator's Quickblade", "=ds=#h1#, #w10#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 9, 103121, "", "=q4=Prideful Gladiator's Slicer", "=ds=#h1#, #w10#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 11, 102987, "", "=q4=Prideful Gladiator's Cleaver", "=ds=#h1#, #w1#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 12, 103119, "", "=q4=Prideful Gladiator's Hacker", "=ds=#h1#, #w1#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 16, 103120, "", "=q4=Prideful Gladiator's Bonecracker", "=ds=#h1#, #w6#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 17, 103030, "", "=q4=Prideful Gladiator's Gavel", "=ds=#h1#, #w6#", "#CONQUEST:2250#"..AL["Rating:"].." 2000" },
				{ 18, 102988, "", "=q4=Prideful Gladiator's Pummeler", "=ds=#h1#, #w6#", "#CONQUEST:1750#"..AL["Rating:"].." 2000" },
				{ 20, 102986, "", "=q4=Prideful Gladiator's Greatsword", "=ds=#h2#, #w10#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 21, 102984, "", "=q4=Prideful Gladiator's Decapitator", "=ds=#h2#, #w1#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 22, 102985, "", "=q4=Prideful Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 24, 103077, "", "=q4=Prideful Gladiator's Pike", "=ds=#w7#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 26, 103000, "", "=q4=Prideful Gladiator's Battle Staff", "=ds=#w9#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 27, 103032, "", "=q4=Prideful Gladiator's Energy Staff", "=ds=#w9#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 28, 103021, "", "=q4=Prideful Gladiator's Staff", "=ds=#w9#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
			};
			{
				{ 1, 102998, "", "=q4=Prideful Gladiator's Barrier", "=ds=#w8#", "#CONQUEST:1250#"..AL["Rating:"].." 2000" },
				{ 2, 103031, "", "=q4=Prideful Gladiator's Redoubt", "=ds=#w8#", "#CONQUEST:1250#"..AL["Rating:"].." 2000" },
				{ 3, 103122, "", "=q4=Prideful Gladiator's Shield Wall", "=ds=#w8#", "#CONQUEST:1250#"..AL["Rating:"].." 2000" },
				{ 5, 103003, "", "=q4=Prideful Gladiator's Heavy Crossbow", "=ds=#w3#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 6, 102990, "", "=q4=Prideful Gladiator's Longbow", "=ds=#w2#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 7, 103029, "", "=q4=Prideful Gladiator's Rifle", "=ds=#w5#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 16, 103118, "", "=q4=Prideful Gladiator's Baton of Light", "=ds=#w12#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 17, 103002, "", "=q4=Prideful Gladiator's Touch of Defeat", "=ds=#w12#", "#CONQUEST:3500#"..AL["Rating:"].." 2000" },
				{ 19, 103001, "", "=q4=Prideful Gladiator's Reprieve", "=ds=#s15#", "#CONQUEST:1250#"..AL["Rating:"].." 2000" },
				{ 20, 102997, "", "=q4=Prideful Gladiator's Endgame", "=ds=#s15#", "#CONQUEST:1250#"..AL["Rating:"].." 2000" },
			};
		};
		info = {
			name = AL["PvP Weapons"].." - "..string.format(AL["ilvl %d"], 550).." - "..AL["Elite"],
			module = moduleName, menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVP90WeaponsPrideful"] = {
		["Normal_A"] = {
			{
				{ 1, 102608, "", "=q4=Prideful Gladiator's Render", "=ds=#h1#, #w13#", "#CONQUEST:1750#" },
				{ 2, 102603, "", "=q4=Prideful Gladiator's Ripper", "=ds=#h1#, #w13#", "#CONQUEST:1750#" },
				{ 4, 102594, "", "=q4=Prideful Gladiator's Spellblade", "=ds=#h1#, #w4#", "#CONQUEST:2250#" },
				{ 5, 102602, "", "=q4=Prideful Gladiator's Shanker", "=ds=#h1#, #w4#", "#CONQUEST:1750#" },
				{ 7, 102598, "", "=q4=Prideful Gladiator's Mageblade", "=ds=#h1#, #w10#", "#CONQUEST:1750#" },
				{ 8, 102612, "", "=q4=Prideful Gladiator's Quickblade", "=ds=#h1#, #w10#", "#CONQUEST:1750#" },
				{ 9, 102605, "", "=q4=Prideful Gladiator's Slicer", "=ds=#h1#, #w10#", "#CONQUEST:1750#" },
				{ 11, 102600, "", "=q4=Prideful Gladiator's Cleaver", "=ds=#h1#, #w1#", "#CONQUEST:1750#" },
				{ 12, 102604, "", "=q4=Prideful Gladiator's Hacker", "=ds=#h1#, #w1#", "#CONQUEST:1750#" },
				{ 16, 102609, "", "=q4=Prideful Gladiator's Bonecracker", "=ds=#h1#, #w6#", "#CONQUEST:1750#" },
				{ 17, 102590, "", "=q4=Prideful Gladiator's Gavel", "=ds=#h1#, #w6#", "#CONQUEST:2250#" },
				{ 18, 102592, "", "=q4=Prideful Gladiator's Pummeler", "=ds=#h1#, #w6#", "#CONQUEST:1750#" },
				{ 20, 102599, "", "=q4=Prideful Gladiator's Greatsword", "=ds=#h2#, #w10#", "#CONQUEST:3500#" },
				{ 21, 102610, "", "=q4=Prideful Gladiator's Decapitator", "=ds=#h2#, #w1#", "#CONQUEST:3500#" },
				{ 22, 102611, "", "=q4=Prideful Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "#CONQUEST:3500#" },
				{ 24, 102606, "", "=q4=Prideful Gladiator's Pike", "=ds=#w7#", "#CONQUEST:3500#" },
				{ 26, 102601, "", "=q4=Prideful Gladiator's Battle Staff", "=ds=#w9#", "#CONQUEST:3500#" },
				{ 27, 102607, "", "=q4=Prideful Gladiator's Energy Staff", "=ds=#w9#", "#CONQUEST:3500#" },
				{ 28, 102595, "", "=q4=Prideful Gladiator's Staff", "=ds=#w9#", "#CONQUEST:3500#" },
			};
			{
				{ 1, 102785, "", "=q4=Prideful Gladiator's Barrier", "=ds=#w8#", "#CONQUEST:1250#" },
				{ 2, 102782, "", "=q4=Prideful Gladiator's Redoubt", "=ds=#w8#", "#CONQUEST:1250#" },
				{ 3, 102784, "", "=q4=Prideful Gladiator's Shield Wall", "=ds=#w8#", "#CONQUEST:1250#" },
				{ 5, 102613, "", "=q4=Prideful Gladiator's Heavy Crossbow", "=ds=#w3#", "#CONQUEST:3500#" },
				{ 6, 102591, "", "=q4=Prideful Gladiator's Longbow", "=ds=#w2#", "#CONQUEST:3500#" },
				{ 7, 102597, "", "=q4=Prideful Gladiator's Rifle", "=ds=#w5#", "#CONQUEST:3500#" },
				{ 16, 102596, "", "=q4=Prideful Gladiator's Baton of Light", "=ds=#w12#", "#CONQUEST:3500#" },
				{ 17, 102593, "", "=q4=Prideful Gladiator's Touch of Defeat", "=ds=#w12#", "#CONQUEST:3500#" },
				{ 19, 102783, "", "=q4=Prideful Gladiator's Reprieve", "=ds=#s15#", "#CONQUEST:1250#" },
				{ 20, 102786, "", "=q4=Prideful Gladiator's Endgame", "=ds=#s15#", "#CONQUEST:1250#" },
			};
		};
		["Normal_H"] = {
			{
				{ 1, 103503, "", "=q4=Prideful Gladiator's Render", "=ds=#h1#, #w13#", "#CONQUEST:1750#" },
				{ 2, 103502, "", "=q4=Prideful Gladiator's Ripper", "=ds=#h1#, #w13#", "#CONQUEST:1750#" },
				{ 4, 103365, "", "=q4=Prideful Gladiator's Spellblade", "=ds=#h1#, #w4#", "#CONQUEST:2250#" },
				{ 5, 103501, "", "=q4=Prideful Gladiator's Shanker", "=ds=#h1#, #w4#", "#CONQUEST:1750#" },
				{ 7, 103504, "", "=q4=Prideful Gladiator's Mageblade", "=ds=#h1#, #w10#", "#CONQUEST:1750#" },
				{ 8, 103341, "", "=q4=Prideful Gladiator's Quickblade", "=ds=#h1#, #w10#", "#CONQUEST:1750#" },
				{ 9, 103510, "", "=q4=Prideful Gladiator's Slicer", "=ds=#h1#, #w10#", "#CONQUEST:1750#" },
				{ 11, 103339, "", "=q4=Prideful Gladiator's Cleaver", "=ds=#h1#, #w1#", "#CONQUEST:1750#" },
				{ 12, 103508, "", "=q4=Prideful Gladiator's Hacker", "=ds=#h1#, #w1#", "#CONQUEST:1750#" },
				{ 16, 103509, "", "=q4=Prideful Gladiator's Bonecracker", "=ds=#h1#, #w6#", "#CONQUEST:1750#" },
				{ 17, 103404, "", "=q4=Prideful Gladiator's Gavel", "=ds=#h1#, #w6#", "#CONQUEST:2250#" },
				{ 18, 103340, "", "=q4=Prideful Gladiator's Pummeler", "=ds=#h1#, #w6#", "#CONQUEST:1750#" },
				{ 20, 103338, "", "=q4=Prideful Gladiator's Greatsword", "=ds=#h2#, #w10#", "#CONQUEST:3500#" },
				{ 21, 103336, "", "=q4=Prideful Gladiator's Decapitator", "=ds=#h2#, #w1#", "#CONQUEST:3500#" },
				{ 22, 103337, "", "=q4=Prideful Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "#CONQUEST:3500#" },
				{ 24, 103461, "", "=q4=Prideful Gladiator's Pike", "=ds=#w7#", "#CONQUEST:3500#" },
				{ 26, 103366, "", "=q4=Prideful Gladiator's Battle Staff", "=ds=#w9#", "#CONQUEST:3500#" },
				{ 27, 103406, "", "=q4=Prideful Gladiator's Energy Staff", "=ds=#w9#", "#CONQUEST:3500#" },
				{ 28, 103394, "", "=q4=Prideful Gladiator's Staff", "=ds=#w9#", "#CONQUEST:3500#" },
			};
			{
				{ 1, 103364, "", "=q4=Prideful Gladiator's Barrier", "=ds=#w8#", "#CONQUEST:1250#" },
				{ 2, 103405, "", "=q4=Prideful Gladiator's Redoubt", "=ds=#w8#", "#CONQUEST:1250#" },
				{ 3, 103519, "", "=q4=Prideful Gladiator's Shield Wall", "=ds=#w8#", "#CONQUEST:1250#" },
				{ 5, 103375, "", "=q4=Prideful Gladiator's Heavy Crossbow", "=ds=#w3#", "#CONQUEST:3500#" },
				{ 6, 103350, "", "=q4=Prideful Gladiator's Longbow", "=ds=#w2#", "#CONQUEST:3500#" },
				{ 7, 103403, "", "=q4=Prideful Gladiator's Rifle", "=ds=#w5#", "#CONQUEST:3500#" },
				{ 16, 103507, "", "=q4=Prideful Gladiator's Baton of Light", "=ds=#w12#", "#CONQUEST:3500#" },
				{ 17, 103374, "", "=q4=Prideful Gladiator's Touch of Defeat", "=ds=#w12#", "#CONQUEST:3500#" },
				{ 19, 103373, "", "=q4=Prideful Gladiator's Reprieve", "=ds=#s15#", "#CONQUEST:1250#" },
				{ 20, 103363, "", "=q4=Prideful Gladiator's Endgame", "=ds=#s15#", "#CONQUEST:1250#" },
			};
		};
		info = {
			name = AL["PvP Weapons"].." - "..string.format(AL["ilvl %d"], 550),
			module = moduleName, menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVP90Weapons"] = {
		["Normal_A"] = {
			{
				{ 1, 103306, "", "=q4=Grievous Gladiator's Render", "=ds=#h1#, #w13#", "#HONOR:1750#" },
				{ 2, 103305, "", "=q4=Grievous Gladiator's Ripper", "=ds=#h1#, #w13#", "#HONOR:1750#" },
				{ 4, 103168, "", "=q4=Grievous Gladiator's Spellblade", "=ds=#h1#, #w4#", "#HONOR:2250#" },
				{ 5, 103304, "", "=q4=Grievous Gladiator's Shanker", "=ds=#h1#, #w4#", "#HONOR:1750#" },
				{ 7, 103307, "", "=q4=Grievous Gladiator's Mageblade", "=ds=#h1#, #w10#", "#HONOR:1750#" },
				{ 8, 103144, "", "=q4=Grievous Gladiator's Quickblade", "=ds=#h1#, #w10#", "#HONOR:1750#" },
				{ 9, 103313, "", "=q4=Grievous Gladiator's Slicer", "=ds=#h1#, #w10#", "#HONOR:1750#" },
				{ 11, 103142, "", "=q4=Grievous Gladiator's Cleaver", "=ds=#h1#, #w1#", "#HONOR:1750#" },
				{ 12, 103311, "", "=q4=Grievous Gladiator's Hacker", "=ds=#h1#, #w1#", "#HONOR:1750#" },
				{ 16, 103312, "", "=q4=Grievous Gladiator's Bonecracker", "=ds=#h1#, #w6#", "#HONOR:1750#" },
				{ 17, 103207, "", "=q4=Grievous Gladiator's Gavel", "=ds=#h1#, #w6#", "#HONOR:2250#" },
				{ 18, 103143, "", "=q4=Grievous Gladiator's Pummeler", "=ds=#h1#, #w6#", "#HONOR:1750#" },
				{ 20, 103141, "", "=q4=Grievous Gladiator's Greatsword", "=ds=#h2#, #w10#", "#HONOR:3500#" },
				{ 21, 103139, "", "=q4=Grievous Gladiator's Decapitator", "=ds=#h2#, #w1#", "#HONOR:3500#" },
				{ 22, 103140, "", "=q4=Grievous Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "#HONOR:3500#" },
				{ 24, 103264, "", "=q4=Grievous Gladiator's Pike", "=ds=#w7#", "#HONOR:3500#" },
				{ 26, 103169, "", "=q4=Grievous Gladiator's Battle Staff", "=ds=#w9#", "#HONOR:3500#" },
				{ 27, 103209, "", "=q4=Grievous Gladiator's Energy Staff", "=ds=#w9#", "#HONOR:3500#" },
				{ 28, 103197, "", "=q4=Grievous Gladiator's Staff", "=ds=#w9#", "#HONOR:3500#" },
			};
			{
				{ 1, 103167, "", "=q4=Grievous Gladiator's Barrier", "=ds=#w8#", "#HONOR:1250#" },
				{ 2, 103208, "", "=q4=Grievous Gladiator's Redoubt", "=ds=#w8#", "#HONOR:1250#" },
				{ 3, 103322, "", "=q4=Grievous Gladiator's Shield Wall", "=ds=#w8#", "#HONOR:1250#" },
				{ 5, 103178, "", "=q4=Grievous Gladiator's Heavy Crossbow", "=ds=#w3#", "#HONOR:3500#" },
				{ 6, 103153, "", "=q4=Grievous Gladiator's Longbow", "=ds=#w2#", "#HONOR:3500#" },
				{ 7, 103206, "", "=q4=Grievous Gladiator's Rifle", "=ds=#w5#", "#HONOR:3500#" },
				{ 16, 103310, "", "=q4=Grievous Gladiator's Baton of Light", "=ds=#w12#", "#HONOR:3500#" },
				{ 17, 103177, "", "=q4=Grievous Gladiator's Touch of Defeat", "=ds=#w12#", "#HONOR:3500#" },
				{ 19, 103176, "", "=q4=Grievous Gladiator's Reprieve", "=ds=#s15#", "#HONOR:1250#" },
				{ 20, 103166, "", "=q4=Grievous Gladiator's Endgame", "=ds=#s15#", "#HONOR:1250#" },
			};
		};
		["Normal_H"] = {
			{
				{ 1, 102805, "", "=q4=Grievous Gladiator's Render", "=ds=#h1#, #w13#", "#HONOR:1750#" },
				{ 2, 102800, "", "=q4=Grievous Gladiator's Ripper", "=ds=#h1#, #w13#", "#HONOR:1750#" },
				{ 4, 102791, "", "=q4=Grievous Gladiator's Spellblade", "=ds=#h1#, #w4#", "#HONOR:2250#" },
				{ 5, 102799, "", "=q4=Grievous Gladiator's Shanker", "=ds=#h1#, #w4#", "#HONOR:1750#" },
				{ 7, 102795, "", "=q4=Grievous Gladiator's Mageblade", "=ds=#h1#, #w10#", "#HONOR:1750#" },
				{ 8, 102809, "", "=q4=Grievous Gladiator's Quickblade", "=ds=#h1#, #w10#", "#HONOR:1750#" },
				{ 9, 102802, "", "=q4=Grievous Gladiator's Slicer", "=ds=#h1#, #w10#", "#HONOR:1750#" },
				{ 11, 102797, "", "=q4=Grievous Gladiator's Cleaver", "=ds=#h1#, #w1#", "#HONOR:1750#" },
				{ 12, 102801, "", "=q4=Grievous Gladiator's Hacker", "=ds=#h1#, #w1#", "#HONOR:1750#" },
				{ 16, 102806, "", "=q4=Grievous Gladiator's Bonecracker", "=ds=#h1#, #w6#", "#HONOR:1750#" },
				{ 17, 102787, "", "=q4=Grievous Gladiator's Gavel", "=ds=#h1#, #w6#", "#HONOR:2250#" },
				{ 18, 102789, "", "=q4=Grievous Gladiator's Pummeler", "=ds=#h1#, #w6#", "#HONOR:1750#" },
				{ 20, 102796, "", "=q4=Grievous Gladiator's Greatsword", "=ds=#h2#, #w10#", "#HONOR:3500#" },
				{ 21, 102807, "", "=q4=Grievous Gladiator's Decapitator", "=ds=#h2#, #w1#", "#HONOR:3500#" },
				{ 22, 102808, "", "=q4=Grievous Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "#HONOR:3500#" },
				{ 24, 102803, "", "=q4=Grievous Gladiator's Pike", "=ds=#w7#", "#HONOR:3500#" },
				{ 26, 102798, "", "=q4=Grievous Gladiator's Battle Staff", "=ds=#w9#", "#HONOR:3500#" },
				{ 27, 102804, "", "=q4=Grievous Gladiator's Energy Staff", "=ds=#w9#", "#HONOR:3500#" },
				{ 28, 102792, "", "=q4=Grievous Gladiator's Staff", "=ds=#w9#", "#HONOR:3500#" },
			};
			{
				{ 1, 102982, "", "=q4=Grievous Gladiator's Barrier", "=ds=#w8#", "#HONOR:1250#" },
				{ 2, 102979, "", "=q4=Grievous Gladiator's Redoubt", "=ds=#w8#", "#HONOR:1250#" },
				{ 3, 102981, "", "=q4=Grievous Gladiator's Shield Wall", "=ds=#w8#", "#HONOR:1250#" },
				{ 5, 102810, "", "=q4=Grievous Gladiator's Heavy Crossbow", "=ds=#w3#", "#HONOR:3500#" },
				{ 6, 102788, "", "=q4=Grievous Gladiator's Longbow", "=ds=#w2#", "#HONOR:3500#" },
				{ 7, 102794, "", "=q4=Grievous Gladiator's Rifle", "=ds=#w5#", "#HONOR:3500#" },
				{ 16, 102793, "", "=q4=Grievous Gladiator's Baton of Light", "=ds=#w12#", "#HONOR:3500#" },
				{ 17, 102790, "", "=q4=Grievous Gladiator's Touch of Defeat", "=ds=#w12#", "#HONOR:3500#" },
				{ 19, 102980, "", "=q4=Grievous Gladiator's Reprieve", "=ds=#s15#", "#HONOR:1250#" },
				{ 20, 102983, "", "=q4=Grievous Gladiator's Endgame", "=ds=#s15#", "#HONOR:1250#" },
			};
		};
		info = {
			name = AL["PvP Weapons"].." - "..string.format(AL["ilvl %d"], 522),
			module = moduleName, menu = "PVPMENU",
		};
	}

	--------------------------
	--- Sets & Collections ---
	--------------------------

		---------------------------------
		--- Challenge Mode Armor Sets ---
		---------------------------------

	AtlasLoot_Data["ChallengeModeDeathKnight"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6=Lich Lord Plate", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90053, "", "=q4=Crown of the Lich Lord", "=ds=#s1#, #a4#", ""};
				{ 3, 90055, "", "=q4=Shoulderguards of the Lich Lord", "=ds=#s3#, #a4#", ""};
				{ 4, 90051, "", "=q4=Chestguard of the Lich Lord", "=ds=#s5#, #a4#", ""};
				{ 5, 90056, "", "=q4=Bracers of the Lich Lord", "=ds=#s8#, #a4#", ""};
				{ 6, 90052, "", "=q4=Grasps of the Lich Lord", "=ds=#s9#, #a4#", ""};
				{ 7, 90049, "", "=q4=Girdle of the Lich Lord", "=ds=#s10#, #a4#", ""};
				{ 8, 90054, "", "=q4=Legplates of the Lich Lord", "=ds=#s11#, #a4#", ""};
				{ 9, 90050, "", "=q4=Treads of the Lich Lord", "=ds=#s12#, #a4#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeDruid"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=Cycle Armor", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90062, "", "=q4=Hood of the Cycle", "=ds=#s1#, #a2#", ""};
				{ 3, 90065, "", "=q4=Branches of the Cycle", "=ds=#s3#, #a2#", ""};
				{ 4, 90064, "", "=q4=Robes of the Cycle", "=ds=#s5#, #a2#", ""};
				{ 5, 90066, "", "=q4=Bracers of the Cycle", "=ds=#s8#, #a2#", ""};
				{ 6, 90061, "", "=q4=Gloves of the Cycle", "=ds=#s9#, #a2#", ""};
				{ 7, 90059, "", "=q4=Waistguard of the Cycle", "=ds=#s10#, #a2#", ""};
				{ 8, 90063, "", "=q4=Leggings of the Cycle", "=ds=#s11#, #a2#", ""};
				{ 9, 90060, "", "=q4=Sandals of the Cycle", "=ds=#s12#, #a2#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeHunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=Howling Beast Set", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90072, "", "=q4=Helm of the Howling Beast", "=ds=#s1#, #a3#", ""};
				{ 3, 90074, "", "=q4=Shoulderguards of the Howling Beast", "=ds=#s3#, #a3#", ""};
				{ 4, 90070, "", "=q4=Chestguard of the Howling Beast", "=ds=#s5#, #a3#", ""};
				{ 5, 90075, "", "=q4=Wristwraps of the Howling Beast", "=ds=#s8#, #a3#", ""};
				{ 6, 90071, "", "=q4=Grips of the Howling Beast", "=ds=#s9#, #a3#", ""};
				{ 7, 90068, "", "=q4=Cinch of the Howling Beast", "=ds=#s10#, #a3#", ""};
				{ 8, 90073, "", "=q4=Legguards of the Howling Beast", "=ds=#s11#, #a3#", ""};
				{ 9, 90069, "", "=q4=Boots of the Howling Beast", "=ds=#s12#, #a3#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeMage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=Elemental Triad Regalia", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90082, "", "=q4=Hood of the Elemental Triad", "=ds=#s1#, #a1#", ""};
				{ 3, 90085, "", "=q4=Spaulders of the Elemental Triad", "=ds=#s3#, #a1#", ""};
				{ 4, 90084, "", "=q4=Robes of the Elemental Triad", "=ds=#s5#, #a1#", ""};
				{ 5, 90086, "", "=q4=Bracers of the Elemental Triad", "=ds=#s8#, #a1#", ""};
				{ 6, 90081, "", "=q4=Gloves of the Elemental Triad", "=ds=#s9#, #a1#", ""};
				{ 7, 90079, "", "=q4=Girdle of the Elemental Triad", "=ds=#s10#, #a1#", ""};
				{ 8, 90083, "", "=q4=Leggings of the Elemental Triad", "=ds=#s11#, #a1#", ""};
				{ 9, 90080, "", "=q4=Boots of the Elemental Triad", "=ds=#s12#, #a1#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeMonk"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_windwalker_spec", "=q6=Regal Lord Armor", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90092, "", "=q4=Crown of the Regal Lord", "=ds=#s1#, #a2#", ""};
				{ 3, 90094, "", "=q4=Shoulderguards of the Regal Lord", "=ds=#s3#, #a2#", ""};
				{ 4, 90090, "", "=q4=Chestwrap of the Regal Lord", "=ds=#s5#, #a2#", ""};
				{ 5, 90095, "", "=q4=Bracers of the Regal Lord", "=ds=#s8#, #a2#", ""};
				{ 6, 90091, "", "=q4=Handwraps of the Regal Lord", "=ds=#s9#, #a2#", ""};
				{ 7, 90088, "", "=q4=Greatbelt of the Regal Lord", "=ds=#s10#, #a2#", ""};
				{ 8, 90093, "", "=q4=Legwraps of the Regal Lord", "=ds=#s11#, #a2#", ""};
				{ 9, 90089, "", "=q4=Treads of the Regal Lord", "=ds=#s12#, #a2#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModePaladin"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=Holy Warrior Plate", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90100, "", "=q4=Greathelm of the Holy Warrior", "=ds=#s1#, #a4#", ""};
				{ 3, 90102, "", "=q4=Shoulderplate of the Holy Warrior", "=ds=#s3#, #a4#", ""};
				{ 4, 90098, "", "=q4=Chestplate of the Holy Warrior", "=ds=#s5#, #a4#", ""};
				{ 5, 90103, "", "=q4=Wristguards of the Holy Warrior", "=ds=#s8#, #a4#", ""};
				{ 6, 90099, "", "=q4=Gauntlets of the Holy Warrior", "=ds=#s9#, #a4#", ""};
				{ 7, 90096, "", "=q4=Girdle of the Holy Warrior", "=ds=#s10#, #a4#", ""};
				{ 8, 90101, "", "=q4=Legplates of the Holy Warrior", "=ds=#s11#, #a4#", ""};
				{ 9, 90097, "", "=q4=Greatboots of the Holy Warrior", "=ds=#s12#, #a4#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModePriest"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6=Light Regalia", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90116, "", "=q4=Cowl of the Light", "=ds=#s1#, #a1#", ""};
				{ 3, 90113, "", "=q4=Pauldrons of the Light", "=ds=#s3#, #a1#", ""};
				{ 4, 90114, "", "=q4=Robes of the Light", "=ds=#s5#, #a1#", ""};
				{ 5, 90112, "", "=q4=Bracers of the Light", "=ds=#s8#, #a1#", ""};
				{ 6, 90115, "", "=q4=Hands of the Light", "=ds=#s9#, #a1#", ""};
				{ 7, 90110, "", "=q4=Cord of the Light", "=ds=#s10#, #a1#", ""};
				{ 8, 90117, "", "=q4=Leggings of the Light", "=ds=#s11#, #a1#", ""};
				{ 9, 90111, "", "=q4=Steps of the Light", "=ds=#s12#, #a1#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeRogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=Silent Assassin Armor", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90120, "", "=q4=Hood of the Silent Assassin", "=ds=#s1#, #a2#", ""};
				{ 3, 90125, "", "=q4=Spaulders of the Silent Assassin", "=ds=#s3#, #a2#", ""};
				{ 4, 90122, "", "=q4=Shadowwrap of the Silent Assassin", "=ds=#s5#, #a2#", ""};
				{ 5, 90126, "", "=q4=Bracers of the Silent Assassin", "=ds=#s8#, #a2#", ""};
				{ 6, 90123, "", "=q4=Gloves of the Silent Assassin", "=ds=#s9#, #a2#", ""};
				{ 7, 90119, "", "=q4=Girdle of the Silent Assassin", "=ds=#s10#, #a2#", ""};
				{ 8, 90124, "", "=q4=Leggings of the Silent Assassin", "=ds=#s11#, #a2#", ""};
				{ 9, 90121, "", "=q4=Tabi of the Silent Assassin", "=ds=#s12#, #a2#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeShaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=Windfury Set", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90132, "", "=q4=Windfury Mask", "=ds=#s1#, #a3#", ""};
				{ 3, 90134, "", "=q4=Windfury Spirit Guides", "=ds=#s3#, #a3#", ""};
				{ 4, 90130, "", "=q4=Windfury Harness", "=ds=#s5#, #a3#", ""};
				{ 5, 90127, "", "=q4=Windfury Bracers", "=ds=#s8#, #a3#", ""};
				{ 6, 90131, "", "=q4=Windfury Crushers", "=ds=#s9#, #a3#", ""};
				{ 7, 90128, "", "=q4=Windfury Belt", "=ds=#s10#, #a3#", ""};
				{ 8, 90133, "", "=q4=Windfury Legguards", "=ds=#s11#, #a3#", ""};
				{ 9, 90129, "", "=q4=Windfury Sandals", "=ds=#s12#, #a3#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeWarlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=Betrayer Regalia", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90142, "", "=q4=Horns of the Betrayer", "=ds=#s1#, #a1#", ""};
				{ 3, 90138, "", "=q4=Amice of the Betrayer", "=ds=#s3#, #a1#", ""};
				{ 4, 90140, "", "=q4=Robes of the Betrayer", "=ds=#s5#, #a1#", ""};
				{ 5, 90139, "", "=q4=Bracers of the Betrayer", "=ds=#s8#, #a1#", ""};
				{ 6, 90141, "", "=q4=Handguards of the Betrayer", "=ds=#s9#, #a1#", ""};
				{ 7, 90136, "", "=q4=Belt of the Betrayer", "=ds=#s10#, #a1#", ""};
				{ 8, 90143, "", "=q4=Leggings of the Betrayer", "=ds=#s11#, #a1#", ""};
				{ 9, 90137, "", "=q4=Boots of the Betrayer", "=ds=#s12#, #a1#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

	AtlasLoot_Data["ChallengeModeWarrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_innerrage", "=q6=Golden King Plate", "=q5=#ACHIEVEMENTID:6378#"};
				{ 2, 90151, "", "=q4=Crown of the Golden King", "=ds=#s1#, #a4#", ""};
				{ 3, 90153, "", "=q4=Mantle of the Golden King", "=ds=#s3#, #a4#", ""};
				{ 4, 90149, "", "=q4=Chestplate of the Golden King", "=ds=#s5#, #a4#", ""};
				{ 5, 90154, "", "=q4=Bracers of the Golden King", "=ds=#s8#, #a4#", ""};
				{ 6, 90150, "", "=q4=Reach of the Golden King", "=ds=#s9#, #a4#", ""};
				{ 7, 90147, "", "=q4=Girdle of the Golden King", "=ds=#s10#, #a4#", ""};
				{ 8, 90152, "", "=q4=Greaves of the Golden King", "=ds=#s11#, #a4#", ""};
				{ 9, 90148, "", "=q4=Greatboots of the Golden King", "=ds=#s12#, #a4#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "CHALLENGEMODESET",
		};
	}

		--------------------------
		--- Tier 14 Sets (T14) ---
		--------------------------

	AtlasLoot_Data["T14DeathKnightDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6=#t14s10_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86676, "", "=q4=Helmet of the Lost Catacomb", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86674, "", "=q4=Pauldrons of the Lost Catacomb", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86678, "", "=q4=Breastplate of the Lost Catacomb", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86677, "", "=q4=Gauntlets of the Lost Catacomb", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86675, "", "=q4=Greaves of the Lost Catacomb", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_deathknight_frostpresence", "=q6=#t14s10_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85336, "", "=q4=Helmet of the Lost Catacomb", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85334, "", "=q4=Pauldrons of the Lost Catacomb", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85338, "", "=q4=Breastplate of the Lost Catacomb", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85337, "", "=q4=Gauntlets of the Lost Catacomb", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85335, "", "=q4=Greaves of the Lost Catacomb", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_deathknight_frostpresence", "=q6=#t14s10_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 86915, "", "=q4=Helmet of the Lost Catacomb", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 86917, "", "=q4=Pauldrons of the Lost Catacomb", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 86913, "", "=q4=Breastplate of the Lost Catacomb", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 86914, "", "=q4=Gauntlets of the Lost Catacomb", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 86916, "", "=q4=Greaves of the Lost Catacomb", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14DeathKnightTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_bloodpresence", "=q6=#t14s10_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86656, "", "=q4=Faceguard of the Lost Catacomb", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86654, "", "=q4=Shoulderguards of the Lost Catacomb", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86658, "", "=q4=Chestguard of the Lost Catacomb", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86657, "", "=q4=Handguards of the Lost Catacomb", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86655, "", "=q4=Legguards of the Lost Catacomb", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_deathknight_bloodpresence", "=q6=#t14s10_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85316, "", "=q4=Faceguard of the Lost Catacomb", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85314, "", "=q4=Shoulderguards of the Lost Catacomb", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85318, "", "=q4=Chestguard of the Lost Catacomb", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85317, "", "=q4=Handguards of the Lost Catacomb", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85315, "", "=q4=Legguards of the Lost Catacomb", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_deathknight_bloodpresence", "=q6=#t14s10_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 86920, "", "=q4=Faceguard of the Lost Catacomb", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 86922, "", "=q4=Shoulderguards of the Lost Catacomb", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 86918, "", "=q4=Chestguard of the Lost Catacomb", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 86919, "", "=q4=Handguards of the Lost Catacomb", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 86921, "", "=q4=Legguards of the Lost Catacomb", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14DruidRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#t14s1_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86697, "", "=q4=Eternal Blossom Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86694, "", "=q4=Eternal Blossom Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86695, "", "=q4=Eternal Blossom Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86698, "", "=q4=Eternal Blossom Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86696, "", "=q4=Eternal Blossom Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_nature_healingtouch", "=q6=#t14s1_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85357, "", "=q4=Eternal Blossom Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85354, "", "=q4=Eternal Blossom Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85355, "", "=q4=Eternal Blossom Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85358, "", "=q4=Eternal Blossom Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85356, "", "=q4=Eternal Blossom Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#t14s1_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 86929, "", "=q4=Eternal Blossom Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 86932, "", "=q4=Eternal Blossom Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 86931, "", "=q4=Eternal Blossom Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 86928, "", "=q4=Eternal Blossom Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 86930, "", "=q4=Eternal Blossom Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14DruidDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#t14s1_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86651, "", "=q4=Eternal Blossom Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86649, "", "=q4=Eternal Blossom Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86653, "", "=q4=Eternal Blossom Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86652, "", "=q4=Eternal Blossom Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86650, "", "=q4=Eternal Blossom Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "ability_druid_catform", "=q6=#t14s1_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85311, "", "=q4=Eternal Blossom Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85309, "", "=q4=Eternal Blossom Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85313, "", "=q4=Eternal Blossom Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85312, "", "=q4=Eternal Blossom Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85310, "", "=q4=Eternal Blossom Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "ability_druid_catform", "=q6=#t14s1_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 86925, "", "=q4=Eternal Blossom Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 86927, "", "=q4=Eternal Blossom Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 86923, "", "=q4=Eternal Blossom Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 86924, "", "=q4=Eternal Blossom Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 86926, "", "=q4=Eternal Blossom Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14DruidBalance"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#t14s1_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86647, "", "=q4=Eternal Blossom Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86644, "", "=q4=Eternal Blossom Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86645, "", "=q4=Eternal Blossom Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86648, "", "=q4=Eternal Blossom Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86646, "", "=q4=Eternal Blossom Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_nature_starfall", "=q6=#t14s1_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85307, "", "=q4=Eternal Blossom Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85304, "", "=q4=Eternal Blossom Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85305, "", "=q4=Eternal Blossom Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85308, "", "=q4=Eternal Blossom Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85306, "", "=q4=Eternal Blossom Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_nature_starfall", "=q6=#t14s1_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 86934, "", "=q4=Eternal Blossom Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 86937, "", "=q4=Eternal Blossom Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 86936, "", "=q4=Eternal Blossom Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 86933, "", "=q4=Eternal Blossom Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 86935, "", "=q4=Eternal Blossom Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14DruidTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_racial_bearform", "=q6=#t14s1_4#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86721, "", "=q4=Eternal Blossom Headguard", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86723, "", "=q4=Eternal Blossom Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86719, "", "=q4=Eternal Blossom Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86720, "", "=q4=Eternal Blossom Handguards", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86722, "", "=q4=Eternal Blossom Breeches", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "ability_racial_bearform", "=q6=#t14s1_4#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85381, "", "=q4=Eternal Blossom Headguard", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85383, "", "=q4=Eternal Blossom Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85379, "", "=q4=Eternal Blossom Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85380, "", "=q4=Eternal Blossom Handguards", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85382, "", "=q4=Eternal Blossom Breeches", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "ability_racial_bearform", "=q6=#t14s1_4#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 86940, "", "=q4=Eternal Blossom Headguard", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 86942, "", "=q4=Eternal Blossom Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 86938, "", "=q4=Eternal Blossom Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 86939, "", "=q4=Eternal Blossom Handguards", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 86941, "", "=q4=Eternal Blossom Breeches", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Guardian"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t14s2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86636, "", "=q4=Yaungol Slayer's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86634, "", "=q4=Yaungol Slayer's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86638, "", "=q4=Yaungol Slayer's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86637, "", "=q4=Yaungol Slayer's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86635, "", "=q4=Yaungol Slayer's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#t14s2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85296, "", "=q4=Yaungol Slayer's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85294, "", "=q4=Yaungol Slayer's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85298, "", "=q4=Yaungol Slayer's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85297, "", "=q4=Yaungol Slayer's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85295, "", "=q4=Yaungol Slayer's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t14s2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87004, "", "=q4=Yaungol Slayer's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87006, "", "=q4=Yaungol Slayer's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87002, "", "=q4=Yaungol Slayer's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87003, "", "=q4=Yaungol Slayer's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87005, "", "=q4=Yaungol Slayer's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t14s3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86717, "", "=q4=Hood of the Burning Scroll", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86714, "", "=q4=Mantle of the Burning Scroll", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86715, "", "=q4=Robes of the Burning Scroll", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86718, "", "=q4=Gloves of the Burning Scroll", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86716, "", "=q4=Leggings of the Burning Scroll", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "inv_staff_13", "=q6=#t14s3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85377, "", "=q4=Hood of the Burning Scroll", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85374, "", "=q4=Mantle of the Burning Scroll", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85375, "", "=q4=Robes of the Burning Scroll", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85378, "", "=q4=Gloves of the Burning Scroll", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85376, "", "=q4=Leggings of the Burning Scroll", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "inv_staff_13", "=q6=#t14s3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87008, "", "=q4=Hood of the Burning Scroll", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87011, "", "=q4=Mantle of the Burning Scroll", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87010, "", "=q4=Robes of the Burning Scroll", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87007, "", "=q4=Gloves of the Burning Scroll", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87009, "", "=q4=Leggings of the Burning Scroll", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14MonkTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_brewmaster_spec", "=q6=#t14s11_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86726, "", "=q4=Red Crane Crown", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86724, "", "=q4=Red Crane Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86728, "", "=q4=Red Crane Chestguard", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86727, "", "=q4=Red Crane Gauntlets", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86725, "", "=q4=Red Crane Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_monk_brewmaster_spec", "=q6=#t14s11_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85386, "", "=q4=Red Crane Crown", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85384, "", "=q4=Red Crane Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85388, "", "=q4=Red Crane Chestguard", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85387, "", "=q4=Red Crane Gauntlets", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85385, "", "=q4=Red Crane Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_monk_brewmaster_spec", "=q6=#t14s11_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87096, "", "=q4=Red Crane Crown", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87098, "", "=q4=Red Crane Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87094, "", "=q4=Red Crane Chestguard", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87095, "", "=q4=Red Crane Gauntlets", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87097, "", "=q4=Red Crane Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Brewmaster"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14MonkDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_windwalker_spec", "=q6=#t14s11_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86736, "", "=q4=Red Crane Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86738, "", "=q4=Red Crane Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86734, "", "=q4=Red Crane Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86735, "", "=q4=Red Crane Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86737, "", "=q4=Red Crane Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_monk_windwalker_spec", "=q6=#t14s11_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85396, "", "=q4=Red Crane Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85398, "", "=q4=Red Crane Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85394, "", "=q4=Red Crane Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85395, "", "=q4=Red Crane Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85397, "", "=q4=Red Crane Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_monk_windwalker_spec", "=q6=#t14s11_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87086, "", "=q4=Red Crane Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87088, "", "=q4=Red Crane Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87084, "", "=q4=Red Crane Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87085, "", "=q4=Red Crane Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87087, "", "=q4=Red Crane Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Windwalker"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14MonkHealer"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_mistweaver_spec", "=q6=#t14s11_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86730, "", "=q4=Red Crane Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86733, "", "=q4=Red Crane Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86732, "", "=q4=Red Crane Vest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86729, "", "=q4=Red Crane Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86731, "", "=q4=Red Crane Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_monk_mistweaver_spec", "=q6=#t14s11_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85390, "", "=q4=Red Crane Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85393, "", "=q4=Red Crane Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85392, "", "=q4=Red Crane Vest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85389, "", "=q4=Red Crane Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85391, "", "=q4=Red Crane Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_monk_mistweaver_spec", "=q6=#t14s11_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87090, "", "=q4=Red Crane Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87093, "", "=q4=Red Crane Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87092, "", "=q4=Red Crane Vest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87089, "", "=q4=Red Crane Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87091, "", "=q4=Red Crane Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Mistweaver"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14PaladinHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t14s4_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86686, "", "=q4=White Tiger Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86684, "", "=q4=White Tiger Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86688, "", "=q4=White Tiger Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86687, "", "=q4=White Tiger Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86685, "", "=q4=White Tiger Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t14s4_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85346, "", "=q4=White Tiger Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85344, "", "=q4=White Tiger Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85348, "", "=q4=White Tiger Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85347, "", "=q4=White Tiger Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85345, "", "=q4=White Tiger Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t14s4_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87106, "", "=q4=White Tiger Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87108, "", "=q4=White Tiger Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87104, "", "=q4=White Tiger Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87105, "", "=q4=White Tiger Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87107, "", "=q4=White Tiger Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14PaladinProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_devotionaura", "=q6=#t14s4_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86661, "", "=q4=White Tiger Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86659, "", "=q4=White Tiger Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86663, "", "=q4=White Tiger Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86662, "", "=q4=White Tiger Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86660, "", "=q4=White Tiger Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_holy_devotionaura", "=q6=#t14s4_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85321, "", "=q4=White Tiger Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85319, "", "=q4=White Tiger Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85323, "", "=q4=White Tiger Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85322, "", "=q4=White Tiger Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85320, "", "=q4=White Tiger Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_holy_devotionaura", "=q6=#t14s4_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87111, "", "=q4=White Tiger Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87113, "", "=q4=White Tiger Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87109, "", "=q4=White Tiger Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87110, "", "=q4=White Tiger Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87112, "", "=q4=White Tiger Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14PaladinRetribution"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t14s4_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86681, "", "=q4=White Tiger Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86679, "", "=q4=White Tiger Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86683, "", "=q4=White Tiger Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86682, "", "=q4=White Tiger Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86680, "", "=q4=White Tiger Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t14s4_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85341, "", "=q4=White Tiger Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85339, "", "=q4=White Tiger Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85343, "", "=q4=White Tiger Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85342, "", "=q4=White Tiger Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85340, "", "=q4=White Tiger Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t14s4_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87101, "", "=q4=White Tiger Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87103, "", "=q4=White Tiger Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87099, "", "=q4=White Tiger Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87100, "", "=q4=White Tiger Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87102, "", "=q4=White Tiger Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14PriestShadow"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#t14s5_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86705, "", "=q4=Guardian Serpent Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86708, "", "=q4=Guardian Serpent Shoulderguards", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86707, "", "=q4=Guardian Serpent Raiment", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86704, "", "=q4=Guardian Serpent Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86706, "", "=q4=Guardian Serpent Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_shadow_shadowwordpain", "=q6=#t14s5_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85365, "", "=q4=Guardian Serpent Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85368, "", "=q4=Guardian Serpent Shoulderguards", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85367, "", "=q4=Guardian Serpent Raiment", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85364, "", "=q4=Guardian Serpent Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85366, "", "=q4=Guardian Serpent Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#t14s5_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87120, "", "=q4=Guardian Serpent Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87123, "", "=q4=Guardian Serpent Shoulderguards", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87122, "", "=q4=Guardian Serpent Raiment", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87119, "", "=q4=Guardian Serpent Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87121, "", "=q4=Guardian Serpent Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Shadow"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14PriestHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6=#t14s5_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86702, "", "=q4=Guardian Serpent Cowl", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86699, "", "=q4=Guardian Serpent Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86700, "", "=q4=Guardian Serpent Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86703, "", "=q4=Guardian Serpent Handwraps", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86701, "", "=q4=Guardian Serpent Legwraps", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_holy_guardianspirit", "=q6=#t14s5_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85362, "", "=q4=Guardian Serpent Cowl", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85359, "", "=q4=Guardian Serpent Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85360, "", "=q4=Guardian Serpent Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85363, "", "=q4=Guardian Serpent Handwraps", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85361, "", "=q4=Guardian Serpent Legwraps", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_holy_guardianspirit", "=q6=#t14s5_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87115, "", "=q4=Guardian Serpent Cowl", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87118, "", "=q4=Guardian Serpent Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87117, "", "=q4=Guardian Serpent Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87114, "", "=q4=Guardian Serpent Handwraps", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87116, "", "=q4=Guardian Serpent Legwraps", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t14s6#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86641, "", "=q4=Helmet of the Thousandfold Blades", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86639, "", "=q4=Spaulders of the Thousandfold Blades", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86643, "", "=q4=Tunic of the Thousandfold Blades", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86642, "", "=q4=Gloves of the Thousandfold Blades", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86640, "", "=q4=Legguards of the Thousandfold Blades", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "inv_throwingknife_04", "=q6=#t14s6#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85301, "", "=q4=Helmet of the Thousandfold Blades", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85299, "", "=q4=Spaulders of the Thousandfold Blades", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85303, "", "=q4=Tunic of the Thousandfold Blades", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85302, "", "=q4=Gloves of the Thousandfold Blades", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85300, "", "=q4=Legguards of the Thousandfold Blades", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t14s6#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87126, "", "=q4=Helmet of the Thousandfold Blades", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87128, "", "=q4=Spaulders of the Thousandfold Blades", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87124, "", "=q4=Tunic of the Thousandfold Blades", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87125, "", "=q4=Gloves of the Thousandfold Blades", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87127, "", "=q4=Legguards of the Thousandfold Blades", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14ShamanElemental"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#t14s7_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86631, "", "=q4=Firebird's Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86633, "", "=q4=Firebird's Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86629, "", "=q4=Firebird's Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86630, "", "=q4=Firebird's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86632, "", "=q4=Firebird's Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "Spell_Nature_Lightning", "=q6=#t14s7_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85291, "", "=q4=Firebird's Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85293, "", "=q4=Firebird's Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85289, "", "=q4=Firebird's Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85290, "", "=q4=Firebird's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85292, "", "=q4=Firebird's Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#t14s7_3#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87141, "", "=q4=Firebird's Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87143, "", "=q4=Firebird's Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87139, "", "=q4=Firebird's Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87140, "", "=q4=Firebird's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87142, "", "=q4=Firebird's Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14ShamanEnhancement"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#t14s7_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86626, "", "=q4=Firebird's Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86624, "", "=q4=Firebird's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86628, "", "=q4=Firebird's Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86627, "", "=q4=Firebird's Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86625, "", "=q4=Firebird's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_nature_lightningshield", "=q6=#t14s7_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85286, "", "=q4=Firebird's Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85284, "", "=q4=Firebird's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85288, "", "=q4=Firebird's Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85287, "", "=q4=Firebird's Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85285, "", "=q4=Firebird's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#t14s7_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87136, "", "=q4=Firebird's Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87138, "", "=q4=Firebird's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87134, "", "=q4=Firebird's Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87135, "", "=q4=Firebird's Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87137, "", "=q4=Firebird's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14ShamanRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#t14s7_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86691, "", "=q4=Firebird's Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86689, "", "=q4=Firebird's Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86693, "", "=q4=Firebird's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86692, "", "=q4=Firebird's Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86690, "", "=q4=Firebird's Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_nature_magicimmunity", "=q6=#t14s7_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85351, "", "=q4=Firebird's Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85349, "", "=q4=Firebird's Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85353, "", "=q4=Firebird's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85352, "", "=q4=Firebird's Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85350, "", "=q4=Firebird's Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#t14s7_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87131, "", "=q4=Firebird's Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87133, "", "=q4=Firebird's Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87129, "", "=q4=Firebird's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87130, "", "=q4=Firebird's Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87132, "", "=q4=Firebird's Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t14s8#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86710, "", "=q4=Sha-Skin Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86713, "", "=q4=Sha-Skin Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86712, "", "=q4=Sha-Skin Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86709, "", "=q4=Sha-Skin Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86711, "", "=q4=Sha-Skin Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "spell_nature_drowsy", "=q6=#t14s8#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85370, "", "=q4=Sha-Skin Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85373, "", "=q4=Sha-Skin Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85372, "", "=q4=Sha-Skin Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85369, "", "=q4=Sha-Skin Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85371, "", "=q4=Sha-Skin Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t14s8#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87188, "", "=q4=Sha-Skin Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87191, "", "=q4=Sha-Skin Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87190, "", "=q4=Sha-Skin Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87187, "", "=q4=Sha-Skin Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87189, "", "=q4=Sha-Skin Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14WarriorFury"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_innerrage", "=q6=#t14s9_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86673, "", "=q4=Helmet of Resounding Rings", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86669, "", "=q4=Pauldrons of Resounding Rings", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86672, "", "=q4=Battleplate of Resounding Rings", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86671, "", "=q4=Gauntlets of Resounding Rings", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86670, "", "=q4=Legplates of Resounding Rings", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "ability_warrior_innerrage", "=q6=#t14s9_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85333, "", "=q4=Helmet of Resounding Rings", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85329, "", "=q4=Pauldrons of Resounding Rings", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85332, "", "=q4=Battleplate of Resounding Rings", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85331, "", "=q4=Gauntlets of Resounding Rings", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85330, "", "=q4=Legplates of Resounding Rings", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "ability_warrior_innerrage", "=q6=#t14s9_1#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87192, "", "=q4=Helmet of Resounding Rings", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87196, "", "=q4=Pauldrons of Resounding Rings", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87193, "", "=q4=Battleplate of Resounding Rings", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87194, "", "=q4=Gauntlets of Resounding Rings", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87195, "", "=q4=Legplates of Resounding Rings", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["DPS"],
			module = moduleName, menu = "T14SET",
		};
	}

	AtlasLoot_Data["T14WarriorProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_defensivestance", "=q6=#t14s9_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Raid Finder"]};
				{ 2, 86666, "", "=q4=Faceguard of Resounding Rings", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 3, 86664, "", "=q4=Shoulderguards of Resounding Rings", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 4, 86668, "", "=q4=Chestguard of Resounding Rings", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 5, 86667, "", "=q4=Handguards of Resounding Rings", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 6, 86665, "", "=q4=Legguards of Resounding Rings", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 8, 0, "ability_warrior_defensivestance", "=q6=#t14s9_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Normal"]};
				{ 9, 85326, "", "=q4=Faceguard of Resounding Rings", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 10, 85324, "", "=q4=Shoulderguards of Resounding Rings", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 11, 85328, "", "=q4=Chestguard of Resounding Rings", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 12, 85327, "", "=q4=Handguards of Resounding Rings", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 13, 85325, "", "=q4=Legguards of Resounding Rings", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
				{ 16, 0, "ability_warrior_defensivestance", "=q6=#t14s9_2#", "=q5="..string.format(AL["Tier %d"], 14).." - "..AL["Heroic"]};
				{ 17, 87199, "", "=q4=Faceguard of Resounding Rings", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Fear", 709)};
				{ 18, 87201, "", "=q4=Shoulderguards of Resounding Rings", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Lei Shi", 729)};
				{ 19, 87197, "", "=q4=Chestguard of Resounding Rings", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Grand Empress Shek'zeer", 743)};
				{ 20, 87198, "", "=q4=Handguards of Resounding Rings", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Wind Lord Mel'jarak", 741)};
				{ 21, 87200, "", "=q4=Legguards of Resounding Rings", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Amber-Shaper Un'sok", 737)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T14SET",
		};
	}

		--------------------------
		--- Tier 15 Sets (T15) ---
		--------------------------

	AtlasLoot_Data["T15DeathKnightDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6=#t15s10_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95827, "", "=q4=Helmet of the All-Consuming Maw", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95829, "", "=q4=Pauldrons of the All-Consuming Maw", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95825, "", "=q4=Breastplate of the All-Consuming Maw", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95826, "", "=q4=Gauntlets of the All-Consuming Maw", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95828, "", "=q4=Greaves of the All-Consuming Maw", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_deathknight_frostpresence", "=q6=#t15s10_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95227, "", "=q4=Helmet of the All-Consuming Maw", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95229, "", "=q4=Pauldrons of the All-Consuming Maw", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95225, "", "=q4=Breastplate of the All-Consuming Maw", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95226, "", "=q4=Gauntlets of the All-Consuming Maw", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95228, "", "=q4=Greaves of the All-Consuming Maw", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_deathknight_frostpresence", "=q6=#t15s10_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96571, "", "=q4=Helmet of the All-Consuming Maw", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96573, "", "=q4=Pauldrons of the All-Consuming Maw", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96569, "", "=q4=Breastplate of the All-Consuming Maw", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96570, "", "=q4=Gauntlets of the All-Consuming Maw", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96572, "", "=q4=Greaves of the All-Consuming Maw", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15DeathKnightTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_bloodpresence", "=q6=#t15s10_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95832, "", "=q4=Faceguard of the All-Consuming Maw", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95834, "", "=q4=Shoulderguards of the All-Consuming Maw", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95830, "", "=q4=Chestguard of the All-Consuming Maw", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95831, "", "=q4=Handguards of the All-Consuming Maw", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95833, "", "=q4=Legguards of the All-Consuming Maw", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_deathknight_bloodpresence", "=q6=#t15s10_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95232, "", "=q4=Faceguard of the All-Consuming Maw", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95234, "", "=q4=Shoulderguards of the All-Consuming Maw", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95230, "", "=q4=Chestguard of the All-Consuming Maw", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95231, "", "=q4=Handguards of the All-Consuming Maw", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95233, "", "=q4=Legguards of the All-Consuming Maw", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_deathknight_bloodpresence", "=q6=#t15s10_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96576, "", "=q4=Faceguard of the All-Consuming Maw", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96578, "", "=q4=Shoulderguards of the All-Consuming Maw", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96574, "", "=q4=Chestguard of the All-Consuming Maw", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96575, "", "=q4=Handguards of the All-Consuming Maw", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96577, "", "=q4=Legguards of the All-Consuming Maw", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15DruidRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#t15s1_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95841, "", "=q4=Helm of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95844, "", "=q4=Mantle of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95843, "", "=q4=Robes of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95840, "", "=q4=Handwraps of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95842, "", "=q4=Legwraps of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_nature_healingtouch", "=q6=#t15s1_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95241, "", "=q4=Helm of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95244, "", "=q4=Mantle of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95243, "", "=q4=Robes of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95240, "", "=q4=Handwraps of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95242, "", "=q4=Legwraps of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#t15s1_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96585, "", "=q4=Helm of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96588, "", "=q4=Mantle of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96587, "", "=q4=Robes of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96584, "", "=q4=Handwraps of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96586, "", "=q4=Legwraps of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15DruidDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#t15s1_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95837, "", "=q4=Headpiece of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95839, "", "=q4=Spaulders of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95835, "", "=q4=Raiment of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95836, "", "=q4=Grips of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95838, "", "=q4=Legguards of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "ability_druid_catform", "=q6=#t15s1_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95237, "", "=q4=Headpiece of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95239, "", "=q4=Spaulders of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95235, "", "=q4=Raiment of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95236, "", "=q4=Grips of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95238, "", "=q4=Legguards of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "ability_druid_catform", "=q6=#t15s1_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96581, "", "=q4=Headpiece of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96583, "", "=q4=Spaulders of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96579, "", "=q4=Raiment of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96580, "", "=q4=Grips of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96582, "", "=q4=Legguards of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15DruidBalance"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#t15s1_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95846, "", "=q4=Cover of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95849, "", "=q4=Shoulderwraps of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95848, "", "=q4=Vestment of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95845, "", "=q4=Gloves of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95847, "", "=q4=Leggings of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_nature_starfall", "=q6=#t15s1_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95246, "", "=q4=Cover of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95249, "", "=q4=Shoulderwraps of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95248, "", "=q4=Vestment of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95245, "", "=q4=Gloves of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95247, "", "=q4=Leggings of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_nature_starfall", "=q6=#t15s1_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96590, "", "=q4=Cover of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96593, "", "=q4=Shoulderwraps of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96592, "", "=q4=Vestment of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96589, "", "=q4=Gloves of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96591, "", "=q4=Leggings of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15DruidTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_racial_bearform", "=q6=#t15s1_4#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95852, "", "=q4=Headguard of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95854, "", "=q4=Shoulderguards of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95850, "", "=q4=Tunic of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95851, "", "=q4=Handguards of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95853, "", "=q4=Breeches of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "ability_racial_bearform", "=q6=#t15s1_4#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95252, "", "=q4=Headguard of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95254, "", "=q4=Shoulderguards of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95250, "", "=q4=Tunic of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95251, "", "=q4=Handguards of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95253, "", "=q4=Breeches of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "ability_racial_bearform", "=q6=#t15s1_4#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96596, "", "=q4=Headguard of the Haunted Forest", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96598, "", "=q4=Shoulderguards of the Haunted Forest", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96594, "", "=q4=Tunic of the Haunted Forest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96595, "", "=q4=Handguards of the Haunted Forest", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96597, "", "=q4=Breeches of the Haunted Forest", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Guardian"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t15s2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95884, "", "=q4=Saurok Stalker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95886, "", "=q4=Saurok Stalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95882, "", "=q4=Saurok Stalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95883, "", "=q4=Saurok Stalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95885, "", "=q4=Saurok Stalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#t15s2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95257, "", "=q4=Saurok Stalker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95259, "", "=q4=Saurok Stalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95255, "", "=q4=Saurok Stalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95256, "", "=q4=Saurok Stalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95258, "", "=q4=Saurok Stalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t15s2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96628, "", "=q4=Saurok Stalker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96630, "", "=q4=Saurok Stalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96626, "", "=q4=Saurok Stalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96627, "", "=q4=Saurok Stalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96629, "", "=q4=Saurok Stalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t15s3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95891, "", "=q4=Hood of the Chromatic Hydra", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95894, "", "=q4=Mantle of the Chromatic Hydra", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95893, "", "=q4=Robes of the Chromatic Hydra", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95890, "", "=q4=Gloves of the Chromatic Hydra", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95892, "", "=q4=Leggings of the Chromatic Hydra", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "inv_staff_13", "=q6=#t15s3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95261, "", "=q4=Hood of the Chromatic Hydra", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95264, "", "=q4=Mantle of the Chromatic Hydra", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95263, "", "=q4=Robes of the Chromatic Hydra", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95260, "", "=q4=Gloves of the Chromatic Hydra", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95262, "", "=q4=Leggings of the Chromatic Hydra", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "inv_staff_13", "=q6=#t15s3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96635, "", "=q4=Hood of the Chromatic Hydra", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96638, "", "=q4=Mantle of the Chromatic Hydra", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96637, "", "=q4=Robes of the Chromatic Hydra", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96634, "", "=q4=Gloves of the Chromatic Hydra", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96636, "", "=q4=Leggings of the Chromatic Hydra", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15MonkTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_brewmaster_spec", "=q6=#t15s11_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95907, "", "=q4=Fire-Charm Crown", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95909, "", "=q4=Fire-Charm Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95905, "", "=q4=Fire-Charm Chestguard", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95906, "", "=q4=Fire-Charm Gauntlets", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95908, "", "=q4=Fire-Charm Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_monk_brewmaster_spec", "=q6=#t15s11_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95277, "", "=q4=Fire-Charm Crown", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95279, "", "=q4=Fire-Charm Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95275, "", "=q4=Fire-Charm Chestguard", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95276, "", "=q4=Fire-Charm Gauntlets", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95278, "", "=q4=Fire-Charm Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_monk_brewmaster_spec", "=q6=#t15s11_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96651, "", "=q4=Fire-Charm Crown", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96653, "", "=q4=Fire-Charm Shoulderguards", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96649, "", "=q4=Fire-Charm Chestguard", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96650, "", "=q4=Fire-Charm Gauntlets", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96652, "", "=q4=Fire-Charm Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Brewmaster"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15MonkDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_windwalker_spec", "=q6=#t15s11_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95897, "", "=q4=Fire-Charm Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95899, "", "=q4=Fire-Charm Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95895, "", "=q4=Fire-Charm Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95896, "", "=q4=Fire-Charm Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95898, "", "=q4=Fire-Charm Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_monk_windwalker_spec", "=q6=#t15s11_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95267, "", "=q4=Fire-Charm Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95269, "", "=q4=Fire-Charm Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95265, "", "=q4=Fire-Charm Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95266, "", "=q4=Fire-Charm Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95268, "", "=q4=Fire-Charm Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_monk_windwalker_spec", "=q6=#t15s11_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96641, "", "=q4=Fire-Charm Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96643, "", "=q4=Fire-Charm Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96639, "", "=q4=Fire-Charm Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96640, "", "=q4=Fire-Charm Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96642, "", "=q4=Fire-Charm Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Windwalker"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15MonkHealer"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_mistweaver_spec", "=q6=#t15s11_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95901, "", "=q4=Fire-Charm Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95904, "", "=q4=Fire-Charm Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95903, "", "=q4=Fire-Charm Vest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95900, "", "=q4=Fire-Charm Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95902, "", "=q4=Fire-Charm Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_monk_mistweaver_spec", "=q6=#t15s11_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95271, "", "=q4=Fire-Charm Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95274, "", "=q4=Fire-Charm Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95273, "", "=q4=Fire-Charm Vest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95270, "", "=q4=Fire-Charm Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95272, "", "=q4=Fire-Charm Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_monk_mistweaver_spec", "=q6=#t15s11_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96645, "", "=q4=Fire-Charm Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96648, "", "=q4=Fire-Charm Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96647, "", "=q4=Fire-Charm Vest", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96644, "", "=q4=Fire-Charm Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96646, "", "=q4=Fire-Charm Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Mistweaver"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15PaladinHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t15s4_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95917, "", "=q4=Lightning Emperor's Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95919, "", "=q4=Lightning Emperor's Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95915, "", "=q4=Lightning Emperor's Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95916, "", "=q4=Lightning Emperor's Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95918, "", "=q4=Lightning Emperor's Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t15s4_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95287, "", "=q4=Lightning Emperor's Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95289, "", "=q4=Lightning Emperor's Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95285, "", "=q4=Lightning Emperor's Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95286, "", "=q4=Lightning Emperor's Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95288, "", "=q4=Lightning Emperor's Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t15s4_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96661, "", "=q4=Lightning Emperor's Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96663, "", "=q4=Lightning Emperor's Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96659, "", "=q4=Lightning Emperor's Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96660, "", "=q4=Lightning Emperor's Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96662, "", "=q4=Lightning Emperor's Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15PaladinProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_devotionaura", "=q6=#t15s4_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95922, "", "=q4=Lightning Emperor's Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95924, "", "=q4=Lightning Emperor's Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95920, "", "=q4=Lightning Emperor's Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95921, "", "=q4=Lightning Emperor's Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95923, "", "=q4=Lightning Emperor's Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_holy_devotionaura", "=q6=#t15s4_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95292, "", "=q4=Lightning Emperor's Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95294, "", "=q4=Lightning Emperor's Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95290, "", "=q4=Lightning Emperor's Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95291, "", "=q4=Lightning Emperor's Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95293, "", "=q4=Lightning Emperor's Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_holy_devotionaura", "=q6=#t15s4_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96666, "", "=q4=Lightning Emperor's Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96668, "", "=q4=Lightning Emperor's Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96664, "", "=q4=Lightning Emperor's Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96665, "", "=q4=Lightning Emperor's Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96667, "", "=q4=Lightning Emperor's Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15PaladinRetribution"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t15s4_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95912, "", "=q4=Lightning Emperor's Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95914, "", "=q4=Lightning Emperor's Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95910, "", "=q4=Lightning Emperor's Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95911, "", "=q4=Lightning Emperor's Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95913, "", "=q4=Lightning Emperor's Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t15s4_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95282, "", "=q4=Lightning Emperor's Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95284, "", "=q4=Lightning Emperor's Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95280, "", "=q4=Lightning Emperor's Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95281, "", "=q4=Lightning Emperor's Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95283, "", "=q4=Lightning Emperor's Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t15s4_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96656, "", "=q4=Lightning Emperor's Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96658, "", "=q4=Lightning Emperor's Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96654, "", "=q4=Lightning Emperor's Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96655, "", "=q4=Lightning Emperor's Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96657, "", "=q4=Lightning Emperor's Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15PriestShadow"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#t15s5_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95931, "", "=q4=Hood of the Exorcist", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95934, "", "=q4=Shoulderguards of the Exorcist", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95933, "", "=q4=Raiment of the Exorcist", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95930, "", "=q4=Gloves of the Exorcist", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95932, "", "=q4=Leggings of the Exorcist", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_shadow_shadowwordpain", "=q6=#t15s5_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95301, "", "=q4=Hood of the Exorcist", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95304, "", "=q4=Shoulderguards of the Exorcist", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95303, "", "=q4=Raiment of the Exorcist", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95300, "", "=q4=Gloves of the Exorcist", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95302, "", "=q4=Leggings of the Exorcist", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#t15s5_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96675, "", "=q4=Hood of the Exorcist", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96678, "", "=q4=Shoulderguards of the Exorcist", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96677, "", "=q4=Raiment of the Exorcist", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96674, "", "=q4=Gloves of the Exorcist", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96676, "", "=q4=Leggings of the Exorcist", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Shadow"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15PriestHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6=#t15s5_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95926, "", "=q4=Cowl of the Exorcist", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95929, "", "=q4=Mantle of the Exorcist", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95928, "", "=q4=Robes of the Exorcist", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95925, "", "=q4=Handwraps of the Exorcist", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95927, "", "=q4=Legwraps of the Exorcist", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_holy_guardianspirit", "=q6=#t15s5_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95296, "", "=q4=Cowl of the Exorcist", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95299, "", "=q4=Mantle of the Exorcist", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95298, "", "=q4=Robes of the Exorcist", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95295, "", "=q4=Handwraps of the Exorcist", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95297, "", "=q4=Legwraps of the Exorcist", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_holy_guardianspirit", "=q6=#t15s5_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96670, "", "=q4=Cowl of the Exorcist", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96673, "", "=q4=Mantle of the Exorcist", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96672, "", "=q4=Robes of the Exorcist", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96669, "", "=q4=Handwraps of the Exorcist", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96671, "", "=q4=Legwraps of the Exorcist", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t15s6#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95937, "", "=q4=Nine-Tailed Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95939, "", "=q4=Nine-Tailed Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95935, "", "=q4=Nine-Tailed Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95936, "", "=q4=Nine-Tailed Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95938, "", "=q4=Nine-Tailed Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "inv_throwingknife_04", "=q6=#t15s6#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95307, "", "=q4=Nine-Tailed Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95309, "", "=q4=Nine-Tailed Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95305, "", "=q4=Nine-Tailed Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95306, "", "=q4=Nine-Tailed Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95308, "", "=q4=Nine-Tailed Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t15s6#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96681, "", "=q4=Nine-Tailed Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96683, "", "=q4=Nine-Tailed Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96679, "", "=q4=Nine-Tailed Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96680, "", "=q4=Nine-Tailed Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96682, "", "=q4=Nine-Tailed Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15ShamanElemental"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#t15s7_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95952, "", "=q4=Headpiece of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95954, "", "=q4=Shoulderwraps of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95950, "", "=q4=Hauberk of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95951, "", "=q4=Gloves of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95953, "", "=q4=Kilt of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "Spell_Nature_Lightning", "=q6=#t15s7_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95322, "", "=q4=Headpiece of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95324, "", "=q4=Shoulderwraps of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95320, "", "=q4=Hauberk of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95321, "", "=q4=Gloves of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95323, "", "=q4=Kilt of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#t15s7_3#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96696, "", "=q4=Headpiece of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96698, "", "=q4=Shoulderwraps of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96694, "", "=q4=Hauberk of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96695, "", "=q4=Gloves of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96697, "", "=q4=Kilt of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15ShamanEnhancement"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#t15s7_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95947, "", "=q4=Helmet of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95949, "", "=q4=Spaulders of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95945, "", "=q4=Cuirass of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95946, "", "=q4=Grips of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95948, "", "=q4=Legguards of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_nature_lightningshield", "=q6=#t15s7_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95317, "", "=q4=Helmet of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95319, "", "=q4=Spaulders of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95315, "", "=q4=Cuirass of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95316, "", "=q4=Grips of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95318, "", "=q4=Legguards of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#t15s7_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96691, "", "=q4=Helmet of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96693, "", "=q4=Spaulders of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96689, "", "=q4=Cuirass of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96690, "", "=q4=Grips of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96692, "", "=q4=Legguards of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15ShamanRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#t15s7_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95942, "", "=q4=Faceguard of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95944, "", "=q4=Mantle of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95940, "", "=q4=Tunic of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95941, "", "=q4=Handwraps of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95943, "", "=q4=Legwraps of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_nature_magicimmunity", "=q6=#t15s7_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95312, "", "=q4=Faceguard of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95314, "", "=q4=Mantle of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95310, "", "=q4=Tunic of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95311, "", "=q4=Handwraps of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95313, "", "=q4=Legwraps of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#t15s7_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96686, "", "=q4=Faceguard of the Witch Doctor", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96688, "", "=q4=Mantle of the Witch Doctor", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96684, "", "=q4=Tunic of the Witch Doctor", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96685, "", "=q4=Handwraps of the Witch Doctor", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96687, "", "=q4=Legwraps of the Witch Doctor", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t15s8#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95982, "", "=q4=Hood of the Thousandfold Hells", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95985, "", "=q4=Mantle of the Thousandfold Hells", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95984, "", "=q4=Robes of the Thousandfold Hells", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95981, "", "=q4=Gloves of the Thousandfold Hells", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95983, "", "=q4=Leggings of the Thousandfold Hells", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "spell_nature_drowsy", "=q6=#t15s8#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95326, "", "=q4=Hood of the Thousandfold Hells", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95329, "", "=q4=Mantle of the Thousandfold Hells", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95328, "", "=q4=Robes of the Thousandfold Hells", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95325, "", "=q4=Gloves of the Thousandfold Hells", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95327, "", "=q4=Leggings of the Thousandfold Hells", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t15s8#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96726, "", "=q4=Hood of the Thousandfold Hells", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96729, "", "=q4=Mantle of the Thousandfold Hells", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96728, "", "=q4=Robes of the Thousandfold Hells", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96725, "", "=q4=Gloves of the Thousandfold Hells", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96727, "", "=q4=Leggings of the Thousandfold Hells", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15WarriorFury"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_innerrage", "=q6=#t15s9_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95986, "", "=q4=Helmet of the Last Mogu", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95990, "", "=q4=Pauldrons of the Last Mogu", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95987, "", "=q4=Battleplate of the Last Mogu", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95988, "", "=q4=Gauntlets of the Last Mogu", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95989, "", "=q4=Legplates of the Last Mogu", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "ability_warrior_innerrage", "=q6=#t15s9_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95330, "", "=q4=Helmet of the Last Mogu", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95334, "", "=q4=Pauldrons of the Last Mogu", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95331, "", "=q4=Battleplate of the Last Mogu", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95332, "", "=q4=Gauntlets of the Last Mogu", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95333, "", "=q4=Legplates of the Last Mogu", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "ability_warrior_innerrage", "=q6=#t15s9_1#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96730, "", "=q4=Helmet of the Last Mogu", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96734, "", "=q4=Pauldrons of the Last Mogu", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96731, "", "=q4=Battleplate of the Last Mogu", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96732, "", "=q4=Gauntlets of the Last Mogu", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96733, "", "=q4=Legplates of the Last Mogu", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["DPS"],
			module = moduleName, menu = "T15SET",
		};
	}

	AtlasLoot_Data["T15WarriorProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_defensivestance", "=q6=#t15s9_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Raid Finder"]};
				{ 2, 95993, "", "=q4=Faceguard of the Last Mogu", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 3, 95995, "", "=q4=Shoulderguards of the Last Mogu", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 4, 95991, "", "=q4=Chestguard of the Last Mogu", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 5, 95992, "", "=q4=Handguards of the Last Mogu", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 6, 95994, "", "=q4=Legguards of the Last Mogu", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 8, 0, "ability_warrior_defensivestance", "=q6=#t15s9_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Normal"]};
				{ 9, 95337, "", "=q4=Faceguard of the Last Mogu", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 10, 95339, "", "=q4=Shoulderguards of the Last Mogu", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 11, 95335, "", "=q4=Chestguard of the Last Mogu", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 12, 95336, "", "=q4=Handguards of the Last Mogu", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 13, 95338, "", "=q4=Legguards of the Last Mogu", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
				{ 16, 0, "ability_warrior_defensivestance", "=q6=#t15s9_2#", "=q5="..string.format(AL["Tier %d"], 15).." - "..AL["Heroic"]};
				{ 17, 96737, "", "=q4=Faceguard of the Last Mogu", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Twin Consorts", 829)};
				{ 18, 96739, "", "=q4=Shoulderguards of the Last Mogu", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Iron Qon", 817)};
				{ 19, 96735, "", "=q4=Chestguard of the Last Mogu", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Dark Animus", 824)};
				{ 20, 96736, "", "=q4=Handguards of the Last Mogu", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Council of Elders", 816)};
				{ 21, 96738, "", "=q4=Legguards of the Last Mogu", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Ji-Kun", 828)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T15SET",
		};
	}

		--------------------------
		--- Tier 16 Sets (T16) ---
		--------------------------

	AtlasLoot_Data["T16DeathKnightDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6=#t16s10_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99057, "", "=q4=Helmet of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99059, "", "=q4=Pauldrons of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99066, "", "=q4=Breastplate of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99067, "", "=q4=Gauntlets of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99058, "", "=q4=Greaves of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_deathknight_frostpresence", "=q6=#t16s10_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99571, "", "=q4=Helmet of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99639, "", "=q4=Pauldrons of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99608, "", "=q4=Breastplate of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99609, "", "=q4=Gauntlets of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99572, "", "=q4=Greaves of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_deathknight_frostpresence", "=q6=#t16s10_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99194, "", "=q4=Helmet of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99187, "", "=q4=Pauldrons of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99192, "", "=q4=Breastplate of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99193, "", "=q4=Gauntlets of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99186, "", "=q4=Greaves of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_deathknight_frostpresence", "=q6=#t16s10_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99337, "", "=q4=Helmet of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99339, "", "=q4=Pauldrons of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99335, "", "=q4=Breastplate of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99336, "", "=q4=Gauntlets of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99338, "", "=q4=Greaves of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16DeathKnightTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_bloodpresence", "=q6=#t16s10_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99049, "", "=q4=Faceguard of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99040, "", "=q4=Shoulderguards of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99060, "", "=q4=Chestguard of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99048, "", "=q4=Handguards of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99039, "", "=q4=Legguards of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_deathknight_bloodpresence", "=q6=#t16s10_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99605, "", "=q4=Faceguard of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99652, "", "=q4=Shoulderguards of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99640, "", "=q4=Chestguard of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99604, "", "=q4=Handguards of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99564, "", "=q4=Legguards of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_deathknight_bloodpresence", "=q6=#t16s10_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99190, "", "=q4=Faceguard of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99179, "", "=q4=Shoulderguards of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99188, "", "=q4=Chestguard of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99189, "", "=q4=Handguards of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99191, "", "=q4=Legguards of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_deathknight_bloodpresence", "=q6=#t16s10_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99323, "", "=q4=Faceguard of Cyclopean Dread", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99325, "", "=q4=Shoulderguards of Cyclopean Dread", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99330, "", "=q4=Chestguard of Cyclopean Dread", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99331, "", "=q4=Handguards of Cyclopean Dread", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99324, "", "=q4=Legguards of Cyclopean Dread", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16DruidRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#t16s1_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99013, "", "=q4=Helm of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99016, "", "=q4=Mantle of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99015, "", "=q4=Robes of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99012, "", "=q4=Handwraps of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99014, "", "=q4=Legwraps of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_nature_healingtouch", "=q6=#t16s1_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99638, "", "=q4=Helm of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99583, "", "=q4=Mantle of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99582, "", "=q4=Robes of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99637, "", "=q4=Handwraps of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99581, "", "=q4=Legwraps of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#t16s1_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99178, "", "=q4=Helm of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99173, "", "=q4=Mantle of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99172, "", "=q4=Robes of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99185, "", "=q4=Handwraps of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99171, "", "=q4=Legwraps of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_nature_healingtouch", "=q6=#t16s1_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99436, "", "=q4=Helm of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99431, "", "=q4=Mantle of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99430, "", "=q4=Robes of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99435, "", "=q4=Handwraps of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99429, "", "=q4=Legwraps of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16DruidDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#t16s1_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99043, "", "=q4=Headpiece of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99022, "", "=q4=Spaulders of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99041, "", "=q4=Raiment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99042, "", "=q4=Grips of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99044, "", "=q4=Legguards of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "ability_druid_catform", "=q6=#t16s1_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99599, "", "=q4=Headpiece of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99589, "", "=q4=Spaulders of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99632, "", "=q4=Raiment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99633, "", "=q4=Grips of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99600, "", "=q4=Legguards of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "ability_druid_catform", "=q6=#t16s1_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99182, "", "=q4=Headpiece of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99184, "", "=q4=Spaulders of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99180, "", "=q4=Raiment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99181, "", "=q4=Grips of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99183, "", "=q4=Legguards of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "ability_druid_catform", "=q6=#t16s1_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99328, "", "=q4=Headpiece of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99322, "", "=q4=Spaulders of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99326, "", "=q4=Raiment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99327, "", "=q4=Grips of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99329, "", "=q4=Legguards of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16DruidBalance"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#t16s1_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 98995, "", "=q4=Cover of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 98998, "", "=q4=Shoulderwraps of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 98997, "", "=q4=Vestment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 98994, "", "=q4=Gloves of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 98996, "", "=q4=Leggings of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_nature_starfall", "=q6=#t16s1_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99618, "", "=q4=Cover of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99621, "", "=q4=Shoulderwraps of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99620, "", "=q4=Vestment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99617, "", "=q4=Gloves of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99619, "", "=q4=Leggings of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_nature_starfall", "=q6=#t16s1_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99175, "", "=q4=Cover of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99169, "", "=q4=Shoulderwraps of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99177, "", "=q4=Vestment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99174, "", "=q4=Gloves of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99176, "", "=q4=Leggings of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_nature_starfall", "=q6=#t16s1_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99433, "", "=q4=Cover of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99428, "", "=q4=Shoulderwraps of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99427, "", "=q4=Vestment of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99432, "", "=q4=Gloves of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99434, "", "=q4=Leggings of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16DruidTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_racial_bearform", "=q6=#t16s1_4#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99001, "", "=q4=Headguard of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 98978, "", "=q4=Shoulderguards of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 98999, "", "=q4=Tunic of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99000, "", "=q4=Handguards of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 98981, "", "=q4=Breeches of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "ability_racial_bearform", "=q6=#t16s1_4#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99624, "", "=q4=Headguard of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99664, "", "=q4=Shoulderguards of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99622, "", "=q4=Tunic of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99623, "", "=q4=Handguards of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99610, "", "=q4=Breeches of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "ability_racial_bearform", "=q6=#t16s1_4#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99164, "", "=q4=Headguard of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99166, "", "=q4=Shoulderguards of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99170, "", "=q4=Tunic of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99163, "", "=q4=Handguards of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99165, "", "=q4=Breeches of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "ability_racial_bearform", "=q6=#t16s1_4#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99421, "", "=q4=Headguard of the Shattered Vale", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99423, "", "=q4=Shoulderguards of the Shattered Vale", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99419, "", "=q4=Tunic of the Shattered Vale", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99420, "", "=q4=Handguards of the Shattered Vale", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99422, "", "=q4=Breeches of the Shattered Vale", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Guardian"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t16s2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99080, "", "=q4=Headguard of the Unblinking Vigil", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99082, "", "=q4=Spaulders of the Unblinking Vigil", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99085, "", "=q4=Tunic of the Unblinking Vigil", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99086, "", "=q4=Gloves of the Unblinking Vigil", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99081, "", "=q4=Legguards of the Unblinking Vigil", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#t16s2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99660, "", "=q4=Headguard of the Unblinking Vigil", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99574, "", "=q4=Spaulders of the Unblinking Vigil", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99577, "", "=q4=Tunic of the Unblinking Vigil", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99578, "", "=q4=Gloves of the Unblinking Vigil", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99573, "", "=q4=Legguards of the Unblinking Vigil", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t16s2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99157, "", "=q4=Headguard of the Unblinking Vigil", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99159, "", "=q4=Spaulders of the Unblinking Vigil", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99167, "", "=q4=Tunic of the Unblinking Vigil", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99168, "", "=q4=Gloves of the Unblinking Vigil", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99158, "", "=q4=Legguards of the Unblinking Vigil", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "inv_weapon_bow_07", "=q6=#t16s2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99402, "", "=q4=Headguard of the Unblinking Vigil", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99404, "", "=q4=Spaulders of the Unblinking Vigil", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99405, "", "=q4=Tunic of the Unblinking Vigil", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99406, "", "=q4=Gloves of the Unblinking Vigil", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99403, "", "=q4=Legguards of the Unblinking Vigil", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t16s3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99084, "", "=q4=Chronomancer Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99079, "", "=q4=Chronomancer Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99078, "", "=q4=Chronomancer Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99083, "", "=q4=Chronomancer Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99077, "", "=q4=Chronomancer Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "inv_staff_13", "=q6=#t16s3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99576, "", "=q4=Chronomancer Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99659, "", "=q4=Chronomancer Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99658, "", "=q4=Chronomancer Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99575, "", "=q4=Chronomancer Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99657, "", "=q4=Chronomancer Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "inv_staff_13", "=q6=#t16s3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99161, "", "=q4=Chronomancer Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99153, "", "=q4=Chronomancer Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99152, "", "=q4=Chronomancer Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99160, "", "=q4=Chronomancer Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99162, "", "=q4=Chronomancer Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "inv_staff_13", "=q6=#t16s3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99398, "", "=q4=Chronomancer Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99401, "", "=q4=Chronomancer Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99400, "", "=q4=Chronomancer Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99397, "", "=q4=Chronomancer Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99399, "", "=q4=Chronomancer Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16MonkTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_brewmaster_spec", "=q6=#t16s11_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99065, "", "=q4=Crown of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99051, "", "=q4=Shoulderguards of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99063, "", "=q4=Chestguard of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99064, "", "=q4=Gauntlets of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99050, "", "=q4=Legguards of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_monk_brewmaster_spec", "=q6=#t16s11_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99607, "", "=q4=Crown of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99565, "", "=q4=Shoulderguards of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99643, "", "=q4=Chestguard of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99644, "", "=q4=Gauntlets of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99606, "", "=q4=Legguards of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_monk_brewmaster_spec", "=q6=#t16s11_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99142, "", "=q4=Crown of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99144, "", "=q4=Shoulderguards of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99140, "", "=q4=Chestguard of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99141, "", "=q4=Gauntlets of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99143, "", "=q4=Legguards of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_monk_brewmaster_spec", "=q6=#t16s11_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99384, "", "=q4=Crown of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99386, "", "=q4=Shoulderguards of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99382, "", "=q4=Chestguard of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99383, "", "=q4=Gauntlets of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99385, "", "=q4=Legguards of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Brewmaster"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16MonkDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_windwalker_spec", "=q6=#t16s11_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99073, "", "=q4=Headpiece of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99075, "", "=q4=Spaulders of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99071, "", "=q4=Tunic of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99072, "", "=q4=Grips of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99074, "", "=q4=Leggings of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_monk_windwalker_spec", "=q6=#t16s11_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99653, "", "=q4=Headpiece of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99655, "", "=q4=Spaulders of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99555, "", "=q4=Tunic of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99556, "", "=q4=Grips of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99654, "", "=q4=Leggings of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_monk_windwalker_spec", "=q6=#t16s11_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99156, "", "=q4=Headpiece of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99146, "", "=q4=Spaulders of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99154, "", "=q4=Tunic of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99155, "", "=q4=Grips of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99145, "", "=q4=Leggings of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_monk_windwalker_spec", "=q6=#t16s11_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99393, "", "=q4=Headpiece of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99395, "", "=q4=Spaulders of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99396, "", "=q4=Tunic of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99392, "", "=q4=Grips of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99394, "", "=q4=Leggings of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Windwalker"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16MonkHealer"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_monk_mistweaver_spec", "=q6=#t16s11_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99069, "", "=q4=Helm of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99062, "", "=q4=Mantle of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99061, "", "=q4=Vest of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99068, "", "=q4=Handwraps of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99070, "", "=q4=Legwraps of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_monk_mistweaver_spec", "=q6=#t16s11_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99553, "", "=q4=Helm of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99642, "", "=q4=Mantle of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99641, "", "=q4=Vest of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99552, "", "=q4=Handwraps of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99554, "", "=q4=Legwraps of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_monk_mistweaver_spec", "=q6=#t16s11_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99148, "", "=q4=Helm of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99151, "", "=q4=Mantle of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99150, "", "=q4=Vest of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99147, "", "=q4=Handwraps of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99149, "", "=q4=Legwraps of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_monk_mistweaver_spec", "=q6=#t16s11_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99389, "", "=q4=Helm of Seven Sacred Seals", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99381, "", "=q4=Mantle of Seven Sacred Seals", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99391, "", "=q4=Vest of Seven Sacred Seals", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99388, "", "=q4=Handwraps of Seven Sacred Seals", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99390, "", "=q4=Legwraps of Seven Sacred Seals", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MONK"].." - "..ALIL["Mistweaver"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16PaladinHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t16s4_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 98979, "", "=q4=Headguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99076, "", "=q4=Mantle of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99003, "", "=q4=Breastplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 98982, "", "=q4=Gloves of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 98980, "", "=q4=Greaves of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t16s4_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99665, "", "=q4=Headguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99656, "", "=q4=Mantle of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99626, "", "=q4=Breastplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99648, "", "=q4=Gloves of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99666, "", "=q4=Greaves of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t16s4_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99135, "", "=q4=Headguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99125, "", "=q4=Mantle of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99133, "", "=q4=Breastplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99134, "", "=q4=Gloves of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99124, "", "=q4=Greaves of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "Spell_Holy_HolyBolt", "=q6=#t16s4_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99376, "", "=q4=Headguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99378, "", "=q4=Mantle of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99374, "", "=q4=Breastplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99375, "", "=q4=Gloves of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99377, "", "=q4=Greaves of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16PaladinProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_devotionaura", "=q6=#t16s4_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99029, "", "=q4=Faceguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99027, "", "=q4=Shoulderguards of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99031, "", "=q4=Chestguard of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99028, "", "=q4=Handguards of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99026, "", "=q4=Legguards of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_holy_devotionaura", "=q6=#t16s4_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99596, "", "=q4=Faceguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99594, "", "=q4=Shoulderguards of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99598, "", "=q4=Chestguard of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99595, "", "=q4=Handguards of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99593, "", "=q4=Legguards of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_holy_devotionaura", "=q6=#t16s4_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99128, "", "=q4=Faceguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99130, "", "=q4=Shoulderguards of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99126, "", "=q4=Chestguard of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99127, "", "=q4=Handguards of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99129, "", "=q4=Legguards of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_holy_devotionaura", "=q6=#t16s4_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99370, "", "=q4=Faceguard of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99364, "", "=q4=Shoulderguards of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99368, "", "=q4=Chestguard of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99369, "", "=q4=Handguards of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99371, "", "=q4=Legguards of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16PaladinRetribution"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t16s4_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 98985, "", "=q4=Helmet of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 98987, "", "=q4=Pauldrons of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99052, "", "=q4=Battleplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99002, "", "=q4=Gauntlets of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 98986, "", "=q4=Legplates of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t16s4_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99651, "", "=q4=Helmet of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99662, "", "=q4=Pauldrons of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99566, "", "=q4=Battleplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99625, "", "=q4=Gauntlets of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99661, "", "=q4=Legplates of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t16s4_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99138, "", "=q4=Helmet of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99132, "", "=q4=Pauldrons of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99136, "", "=q4=Battleplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99137, "", "=q4=Gauntlets of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99139, "", "=q4=Legplates of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "Spell_Holy_AuraOfLight", "=q6=#t16s4_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99379, "", "=q4=Helmet of Winged Triumph", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99373, "", "=q4=Pauldrons of Winged Triumph", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99387, "", "=q4=Battleplate of Winged Triumph", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99380, "", "=q4=Gauntlets of Winged Triumph", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99372, "", "=q4=Legplates of Winged Triumph", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16PriestShadow"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#t16s5_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99020, "", "=q4=Hood of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99005, "", "=q4=Shoulderguards of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99004, "", "=q4=Raiment of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99019, "", "=q4=Gloves of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99021, "", "=q4=Leggings of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_shadow_shadowwordpain", "=q6=#t16s5_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99587, "", "=q4=Hood of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99628, "", "=q4=Shoulderguards of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99627, "", "=q4=Raiment of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99586, "", "=q4=Gloves of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99588, "", "=q4=Leggings of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#t16s5_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99122, "", "=q4=Hood of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99111, "", "=q4=Shoulderguards of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99110, "", "=q4=Raiment of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99121, "", "=q4=Gloves of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99123, "", "=q4=Leggings of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_shadow_shadowwordpain", "=q6=#t16s5_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99360, "", "=q4=Hood of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99363, "", "=q4=Shoulderguards of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99362, "", "=q4=Raiment of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99359, "", "=q4=Gloves of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99361, "", "=q4=Leggings of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Shadow"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16PriestHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6=#t16s5_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99024, "", "=q4=Cowl of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99018, "", "=q4=Mantle of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99017, "", "=q4=Robes of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99023, "", "=q4=Handwraps of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99025, "", "=q4=Legwraps of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_holy_guardianspirit", "=q6=#t16s5_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99591, "", "=q4=Cowl of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99585, "", "=q4=Mantle of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99584, "", "=q4=Robes of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99590, "", "=q4=Handwraps of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99592, "", "=q4=Legwraps of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_holy_guardianspirit", "=q6=#t16s5_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99117, "", "=q4=Cowl of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99120, "", "=q4=Mantle of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99119, "", "=q4=Robes of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99131, "", "=q4=Handwraps of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99118, "", "=q4=Legwraps of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_holy_guardianspirit", "=q6=#t16s5_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99366, "", "=q4=Cowl of the Ternion Glory", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99358, "", "=q4=Mantle of the Ternion Glory", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99357, "", "=q4=Robes of the Ternion Glory", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99365, "", "=q4=Handwraps of the Ternion Glory", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99367, "", "=q4=Legwraps of the Ternion Glory", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t16s6#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99008, "", "=q4=Helmet of the Barbed Assassin", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99010, "", "=q4=Spaulders of the Barbed Assassin", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99006, "", "=q4=Tunic of the Barbed Assassin", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99007, "", "=q4=Gloves of the Barbed Assassin", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99009, "", "=q4=Legguards of the Barbed Assassin", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "inv_throwingknife_04", "=q6=#t16s6#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99631, "", "=q4=Helmet of the Barbed Assassin", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99635, "", "=q4=Spaulders of the Barbed Assassin", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99629, "", "=q4=Tunic of the Barbed Assassin", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99630, "", "=q4=Gloves of the Barbed Assassin", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99634, "", "=q4=Legguards of the Barbed Assassin", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t16s6#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99114, "", "=q4=Helmet of the Barbed Assassin", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99116, "", "=q4=Spaulders of the Barbed Assassin", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99112, "", "=q4=Tunic of the Barbed Assassin", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99113, "", "=q4=Gloves of the Barbed Assassin", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99115, "", "=q4=Legguards of the Barbed Assassin", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "inv_throwingknife_04", "=q6=#t16s6#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99348, "", "=q4=Helmet of the Barbed Assassin", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99350, "", "=q4=Spaulders of the Barbed Assassin", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99356, "", "=q4=Tunic of the Barbed Assassin", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99355, "", "=q4=Gloves of the Barbed Assassin", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99349, "", "=q4=Legguards of the Barbed Assassin", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16ShamanElemental"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#t16s7_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99089, "", "=q4=Headpiece of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99091, "", "=q4=Shoulderwraps of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99087, "", "=q4=Hauberk of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99088, "", "=q4=Gloves of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99090, "", "=q4=Kilt of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "Spell_Nature_Lightning", "=q6=#t16s7_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99645, "", "=q4=Headpiece of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99647, "", "=q4=Shoulderwraps of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99579, "", "=q4=Hauberk of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99580, "", "=q4=Gloves of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99646, "", "=q4=Kilt of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#t16s7_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99093, "", "=q4=Headpiece of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99095, "", "=q4=Shoulderwraps of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99106, "", "=q4=Hauberk of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99092, "", "=q4=Gloves of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99094, "", "=q4=Kilt of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "Spell_Nature_Lightning", "=q6=#t16s7_3#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99332, "", "=q4=Headpiece of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99334, "", "=q4=Shoulderwraps of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99344, "", "=q4=Hauberk of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99345, "", "=q4=Gloves of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99333, "", "=q4=Kilt of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16ShamanEnhancement"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#t16s7_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 98983, "", "=q4=Helmet of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 98977, "", "=q4=Spaulders of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 98992, "", "=q4=Cuirass of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 98993, "", "=q4=Grips of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 98984, "", "=q4=Legguards of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_nature_lightningshield", "=q6=#t16s7_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99649, "", "=q4=Helmet of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99663, "", "=q4=Spaulders of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99615, "", "=q4=Cuirass of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99616, "", "=q4=Grips of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99650, "", "=q4=Legguards of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#t16s7_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99103, "", "=q4=Helmet of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99105, "", "=q4=Spaulders of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99101, "", "=q4=Cuirass of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99102, "", "=q4=Grips of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99104, "", "=q4=Legguards of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_nature_lightningshield", "=q6=#t16s7_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99341, "", "=q4=Helmet of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99343, "", "=q4=Spaulders of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99347, "", "=q4=Cuirass of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99340, "", "=q4=Grips of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99342, "", "=q4=Legguards of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16ShamanRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#t16s7_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 98989, "", "=q4=Faceguard of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 98991, "", "=q4=Mantle of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99011, "", "=q4=Tunic of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 98988, "", "=q4=Handwraps of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 98990, "", "=q4=Legwraps of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_nature_magicimmunity", "=q6=#t16s7_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99612, "", "=q4=Faceguard of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99614, "", "=q4=Mantle of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99636, "", "=q4=Tunic of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99611, "", "=q4=Handwraps of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99613, "", "=q4=Legwraps of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#t16s7_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99109, "", "=q4=Faceguard of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99100, "", "=q4=Mantle of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99107, "", "=q4=Tunic of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99108, "", "=q4=Handwraps of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99099, "", "=q4=Legwraps of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_nature_magicimmunity", "=q6=#t16s7_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99353, "", "=q4=Faceguard of Celestial Harmony", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99346, "", "=q4=Mantle of Celestial Harmony", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99351, "", "=q4=Tunic of Celestial Harmony", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99352, "", "=q4=Handwraps of Celestial Harmony", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99354, "", "=q4=Legwraps of Celestial Harmony", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t16s8#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99054, "", "=q4=Hood of the Horned Nightmare", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99045, "", "=q4=Mantle of the Horned Nightmare", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99056, "", "=q4=Robes of the Horned Nightmare", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99053, "", "=q4=Gloves of the Horned Nightmare", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99055, "", "=q4=Leggings of the Horned Nightmare", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "spell_nature_drowsy", "=q6=#t16s8#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99568, "", "=q4=Hood of the Horned Nightmare", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99601, "", "=q4=Mantle of the Horned Nightmare", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99570, "", "=q4=Robes of the Horned Nightmare", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99567, "", "=q4=Gloves of the Horned Nightmare", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99569, "", "=q4=Leggings of the Horned Nightmare", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t16s8#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99097, "", "=q4=Hood of the Horned Nightmare", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99205, "", "=q4=Mantle of the Horned Nightmare", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99204, "", "=q4=Robes of the Horned Nightmare", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99096, "", "=q4=Gloves of the Horned Nightmare", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99098, "", "=q4=Leggings of the Horned Nightmare", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "spell_nature_drowsy", "=q6=#t16s8#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99425, "", "=q4=Hood of the Horned Nightmare", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99417, "", "=q4=Mantle of the Horned Nightmare", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99416, "", "=q4=Robes of the Horned Nightmare", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99424, "", "=q4=Gloves of the Horned Nightmare", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99426, "", "=q4=Leggings of the Horned Nightmare", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16WarriorFury"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_innerrage", "=q6=#t16s9_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99046, "", "=q4=Helmet of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99036, "", "=q4=Pauldrons of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99047, "", "=q4=Battleplate of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99034, "", "=q4=Gauntlets of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99035, "", "=q4=Legplates of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "ability_warrior_innerrage", "=q6=#t16s9_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99602, "", "=q4=Helmet of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99561, "", "=q4=Pauldrons of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99603, "", "=q4=Battleplate of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99559, "", "=q4=Gauntlets of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99560, "", "=q4=Legplates of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "ability_warrior_innerrage", "=q6=#t16s9_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99206, "", "=q4=Helmet of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99200, "", "=q4=Pauldrons of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99197, "", "=q4=Battleplate of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99198, "", "=q4=Gauntlets of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99199, "", "=q4=Legplates of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "ability_warrior_innerrage", "=q6=#t16s9_1#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99418, "", "=q4=Helmet of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99414, "", "=q4=Pauldrons of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99411, "", "=q4=Battleplate of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99412, "", "=q4=Gauntlets of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99413, "", "=q4=Legplates of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["DPS"],
			module = moduleName, menu = "T16SET",
		};
	}

	AtlasLoot_Data["T16WarriorProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_defensivestance", "=q6=#t16s9_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Raid Finder"]};
				{ 2, 99032, "", "=q4=Faceguard of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 3, 99030, "", "=q4=Shoulderguards of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 4, 99037, "", "=q4=Chestguard of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 5, 99038, "", "=q4=Handguards of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 6, 99033, "", "=q4=Legguards of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 8, 0, "ability_warrior_defensivestance", "=q6=#t16s9_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Flexible"]};
				{ 9, 99557, "", "=q4=Faceguard of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 10, 99597, "", "=q4=Shoulderguards of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 11, 99562, "", "=q4=Chestguard of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 12, 99563, "", "=q4=Handguards of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 13, 99558, "", "=q4=Legguards of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 16, 0, "ability_warrior_defensivestance", "=q6=#t16s9_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Normal"]};
				{ 17, 99203, "", "=q4=Faceguard of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 18, 99196, "", "=q4=Shoulderguards of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 19, 99201, "", "=q4=Chestguard of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 20, 99202, "", "=q4=Handguards of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 21, 99195, "", "=q4=Legguards of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
				{ 23, 0, "ability_warrior_defensivestance", "=q6=#t16s9_2#", "=q5="..string.format(AL["Tier %d"], 16).." - "..AL["Heroic"]};
				{ 24, 99409, "", "=q4=Faceguard of the Prehistoric Marauder", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Thok the Bloodthirsty", 851)};
				{ 25, 99407, "", "=q4=Shoulderguards of the Prehistoric Marauder", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)};
				{ 26, 99415, "", "=q4=Chestguard of the Prehistoric Marauder", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Sha of Pride", 867)};
				{ 27, 99408, "", "=q4=Handguards of the Prehistoric Marauder", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("General Nazgrim", 850)};
				{ 28, 99410, "", "=q4=Legguards of the Prehistoric Marauder", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T16SET",
		};
	}

		-------------------------------
		--- Trading Card Game Items ---
		-------------------------------

	AtlasLoot_Data["CardGame"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Betrayal of the Guardian"]};
				{ 2, 93671, "", "=q4=Ghastly Charger's Skull", "=ds=#e12#" },
				{ 3, 93672, "", "=q3=Dark Portal", "=ds=" },
				{ 4, 93669, "", "=q3=Gusting Grimoire", "=ds=#e13#"};
				{ 6, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["War of the Ancients"]};
				{ 7, 79771, "", "=q4=Feldrake", "=ds=#e27#" },
				{ 8, 79769, "", "=q3=Demon Hunter's Aspect", "=ds=" },
				{ 9, 79744, "", "=q3=Eye of the Legion", "=ds=#e13#"};
				{ 11, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Tomb of the Forgotten"]};
				{ 12, 72575, "", "=q4=White Riding Camel", "=ds=#e26#" },
				{ 13, 72161, "", "=q3=Spurious Sarcophagus", "=ds=" },
				{ 14, 72153, "", "=q3=Sand Scarab", "=ds=#e13#"};
				{ 16, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Crown of Heaven"]};
				{ 17, 72582, "", "=q4=Corrupted Hippogryph", "=ds=#e12#" },
				{ 18, 72159, "", "=q3=Magical Ogre Idol", "=ds=" },
				{ 19, 72134, "", "=q3=Grell Moss", "=ds=#e13#"};
				{ 21, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..ALIL["Throne of the Tides"]};
				{ 22, 71718, "", "=q4=Swift Shorestrider", "=ds=#e26#" },
				{ 23, 71624, "", "=q3=Purple Puffer", "=ds=#e13#"},
				{ 24, 71628, "", "=q3=Sack of Starfish", "=ds=" },
				{ 26, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Twilight of the Dragons"]};
				{ 27, 68825, "", "=q4=Amani Dragonhawk", "=ds=#e27#" },
				{ 28, 69227, "", "=q3=Fool's Gold", "=ds=" },
				{ 29, 68841, "", "=q3=Nightsaber Cub", "=ds=#e13#" },
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["War of the Elements"]};
				{ 2, 69228, "", "=q4=Savage Raptor", "=ds=#e26#" },
				{ 3, 68840, "", "=q3=Landro's Lichling", "=ds=#e13#" },
				{ 4, 69215, "", "=q3=War Party Hitching Post", "=ds=" },
				{ 6, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Worldbreaker"]};
				{ 7, 68008, "", "=q4=Mottled Drake", "=ds="..AL["Mottled Drake"] };
				{ 8, 67097, "", "=q3=Grim Campfire", "=ds="..AL["Grim Campfire"] };
				{ 9, 67128, "", "=q3=Landro's Lil' XT", "=ds="..AL["Landro's Lil' XT"] };
				{ 11, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Icecrown"]};
				{ 12, 54068, "", "=q4=Wooly White Rhino", "=ds="..AL["Wooly White Rhino"]};
				{ 13, 54452, "", "=q3=Ethereal Portal", "=ds="..AL["Ethereal Portal"]};
				{ 14, 54455, "", "=q1=Paint Bomb", "=ds="..AL["Paint Bomb"]};
				{ 16, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Wrathgate"]};
				{ 17, 54069, "", "=q4=Blazing Hippogryph", "=ds="..AL["Blazing Hippogryph"]};
				{ 18, 54212, "", "=q3=Instant Statue Pedestal", "=ds="..AL["Statue Generator"]};
				{ 19, 54218, "", "=q1=Landro's Gift Box", "=ds="..AL["Landro's Gift"]};
				{ 21, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Scourgewar"]};
				{ 22, 49287, "", "=q4=Tuskarr Kite", "=ds="..AL["Tuskarr Kite"]};
				{ 23, 49343, "", "=q3=Spectral Tiger Cub", "=ds="..AL["Spectral Kitten"]};
				{ 24, 49289, "", "=q2=Little White Stallion Bridle", "=ds="..AL["Tiny"]};
				{ 25, 49288, "", "=q2=Little Ivory Raptor Whistle", "=ds="..AL["Tiny"]};
				{ 27, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Fields of Honor"]};
				{ 28, 49290, "", "=q4=Magic Rooster Egg", "=ds="..AL["El Pollo Grande"]};
				{ 29, 46780, "", "=q3=Ogre Pinata", "=ds="..AL["Pinata"]};
				{ 30, 46779, "", "=q1=Path of Cenarius", "=ds="..AL["Path of Cenarius"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Blood of Gladiators"]};
				{ 2, 45037, "", "=q4=Epic Purple Shirt", "=ds="..AL["Center of Attention"]};
				{ 3, 45063, "", "=q3=Foam Sword Rack", "=ds="..AL["Foam Sword Rack"]};
				{ 4, 45047, "", "=q3=Sandbox Tiger", "=ds="..AL["Sandbox Tiger"]};
				{ 6, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Drums of War"]};
				{ 7, 49282, "", "=q4=Big Battle Bear", "=ds="..AL["The Red Bearon"]};
				{ 8, 38578, "", "=q3=The Flag of Ownership", "=ds="..AL["Owned!"]};
				{ 9, 38577, "", "=q1=Party G.R.E.N.A.D.E.", "=ds="..AL["Slashdance"]};
				{ 11, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Hunt for Illidan"]};
				{ 12, 38050, "", "=q3=Soul-Trader Beacon", "=ds="..AL["Ethereal Plunderer"]};
				{ 13, 38301, "", "=q3=D.I.S.C.O", "=ds="..AL["Disco Inferno!"]};
				{ 14, 38233, "", "=q1=Path of Illidan", "=ds="..AL["The Footsteps of Illidan"]};
				{ 16, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Servants of the Betrayer"]};
				{ 17, 35227, "", "=q4=Goblin Weather Machine - Prototype 01-B", "=ds="..AL["Personal Weather Machine"]};
				{ 18, 49286, "", "=q4=X-51 Nether-Rocket X-TREME", "=ds="..AL["X-51 Nether-Rocket"]};
				{ 19, 49285, "", "=q3=X-51 Nether-Rocket", "=ds="..AL["X-51 Nether-Rocket"]};
				{ 20, 35223, "", "=q3=Papa Hummel's Old-Fashioned Pet Biscuit", "=ds="..AL["Papa Hummel's Old-fashioned Pet Biscuit"]};
				{ 22, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["March of the Legion"]};
				{ 23, 34493, "", "=q4=Dragon Kite", "=ds="..AL["Kiting"]};
				{ 24, 34492, "", "=q3=Rocket Chicken", "=ds="..AL["Robotic Homing Chicken"]};
				{ 25, 34499, "", "=q3=Paper Flying Machine Kit", "=ds="..AL["Paper Airplane"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Fires of Outland"]};
				{ 2, 49284, "", "=q4=Reins of the Swift Spectral Tiger", "=ds="..AL["Spectral Tiger"]};
				{ 3, 49283, "", "=q3=Reins of the Spectral Tiger", "=ds="..AL["Spectral Tiger"]};
				{ 4, 33223, "", "=q3=Fishing Chair", "=ds="..AL["Gone Fishin'"]};
				{ 5, 33219, "", "=q3=Goblin Gumbo Kettle", "=ds="..AL["Goblin Gumbo"]};
				{ 6, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Through The Dark Portal"]};
				{ 7, 32588, "", "=q3=Banana Charm", "=ds="..AL["King Mukla"]};
				{ 8, 32566, "", "=q3=Picnic Basket", "=ds="..AL["Rest and Relaxation"]};
				{ 9, 32542, "", "=q3=Imp in a Ball", "=ds="..AL["Fortune Telling"]};
				{ 11, 0, "INV_Box_01", "=q6=#ud1#", "=q1="..AL["Heroes of Azeroth"]};
				{ 12, 23705, "", "=q4=Tabard of Flame", "=ds="..AL["Landro Longshot"]};
				{ 13, 23713, "", "=q4=Hippogryph Hatchling", "=ds="..AL["Thunderhead Hippogryph"]};
				{ 14, 23720, "", "=q4=Riding Turtle", "=ds="..AL["Saltwater Snapjaw"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["UDE Items"], "=ds="..AL["No Longer Available"]};
				{ 17, 38312, "", "=q4=Tabard of Brilliance", "=ds=#s7#"};
				{ 18, 23709, "", "=q4=Tabard of Frost", "=ds=#s7#"};
				{ 19, 38313, "", "=q4=Tabard of Fury", "=ds=#s7#"};
				{ 20, 38309, "", "=q4=Tabard of Nature", "=ds=#s7#"};
				{ 21, 38310, "", "=q4=Tabard of the Arcane", "=ds=#s7#"};
				{ 22, 38314, "", "=q4=Tabard of the Defender", "=ds=#s7#"};
				{ 23, 38314, "", "=q4=Tabard of the Defender", "=ds=#s7#"};
				{ 24, 38311, "", "=q4=Tabard of the Void", "=ds=#s7#"};
				{ 25, 49704, "", "=q4=Carved Ogre Idol", "=ds="};
				{ 26, 49703, "", "=q4=Perpetual Purple Firework", "=ds="};
			};
		};
		info = {
			name = AL["TCG Items"],
			module = moduleName, menu = "SETMENU",
		};
	}

		------------------
		--- Companions ---
		------------------

	AtlasLoot_Data["PetsMerchant"] = {
		["Normal"] = {
			{
				{
					{ 1, 54436, "", "=q3=Blue Clockwork Rocket Bot", "=ds=#e13#", "=ds="..ALIL["Dalaran"].." / "..ALIL["Orgrimmar"]};
					{ 1, 54436, "", "=q3=Blue Clockwork Rocket Bot", "=ds=#e13#", "=ds="..ALIL["Dalaran"].." / "..ALIL["Stormwind City"]};
				};
				{ 2, 102145, "", "=q3=Chi-Chi, Hatchling of Chi-Ji", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 3, 70160, "", "=q3=Crimson Lasher", "=ds=#e13#", "=ds="..ALIL["Molten Front"]},
				{ 4, 39973, "", "=q3=Ghostly Skull", "=ds=#e13#", "=ds="..ALIL["Dalaran"]};
				{ 5, 70140, "", "=q3=Hyjal Bear Cub", "=ds=#e13#", "=ds="..ALIL["Molten Front"]},
				{ 6, 34955, "", "=q3=Scorched Stone", "=ds=#e13#", "=ds="..ALIL["Molten Front"]};
				{ 7, 104332, "", "=q3=Sky Lantern", "=ds=#e13#", "=ds=#TIMELESSCOIN:7500#=q1="..ALIL["Timeless Isle"]};
				{ 8, 103637, "", "=q3=Vengeful Porcupette", "=ds=#e13#", "=ds=#BLOODYCOIN:100#=q1="..ALIL["Timeless Isle"]};
				{ 9, 101771, "", "=q3=Xu-Fu, Cub of Xuen", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 10, 102147, "", "=q3=Yu'la, Broodling of Yu'lon", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 11, 102146, "", "=q3=Zao, Calfling of Niuzao", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 12, 44822, "", "=q1=Albino Snake", "=ds=#e13#", "=ds="..ALIL["Dalaran"]};
				{ 13, 11023, "", "=q1=Ancona Chicken", "=ds=#e13#", "=ds="..ALIL["Thousand Needles"]};
				{ 14, 10360, "", "=q1=Black Kingsnake", "=ds=#e13#", "=ds="..ALIL["Orgrimmar"]};
				{ 15, 29958, "", "=q1=Blue Dragonhawk Hatchling", "=ds=#e13#", "=ds="..ALIL["Netherstorm"]};
				{ 16, 29901, "", "=q1=Blue Moth Egg", "=ds=#e13#", "=ds="..ALIL["The Exodar"]};
				{ 17, 29364, "", "=q1=Brown Rabbit Crate", "=ds=#e13#", "=ds="..ALIL["Netherstorm"]};
				{ 18, 10361, "", "=q1=Brown Snake", "=ds=#e13#", "=ds="..ALIL["Orgrimmar"]};
				{ 19, 8485, "", "=q1=Cat Carrier (Bombay)", "=ds=#e13#", "=ds="..ALIL["Elwynn Forest"]};
				{ 20, 46398, "", "=q1=Cat Carrier (Calico Cat)", "=ds=#e13#", "=ds="..ALIL["Dalaran"]};
				{ 21, 8486, "", "=q1=Cat Carrier (Cornish Rex)", "=ds=#e13#", "=ds="..ALIL["Elwynn Forest"]};
				{ 22, 8487, "", "=q1=Cat Carrier (Orange Tabby)", "=ds=#e13#", "=ds="..ALIL["Elwynn Forest"]};
				{ 23, 8490, "", "=q1=Cat Carrier (Siamese)", "=ds=#e13#", "=ds="..ALIL["Netherstorm"]};
				{ 24, 8488, "", "=q1=Cat Carrier (Silver Tabby)", "=ds=#e13#", "=ds="..ALIL["Elwynn Forest"]};
				{ 25, 8489, "", "=q1=Cat Carrier (White Kitten)", "=ds=#e13#", "=ds="..ALIL["Stormwind City"]};
				{ 26, 10392, "", "=q1=Crimson Snake", "=ds=#e13#", "=ds="..ALIL["Netherstorm"].." / "..ALIL["Orgrimmar"]};
				{ 27, "s123214", "", "=q1=Gilnean Raven", "=ds=#e13#", "=ds="..AL["Battle Pet Trainer"].." =ec1=#m7#"};
				{ 28, 29953, "", "=q1=Golden Dragonhawk Hatchling", "=ds=#e13#", "=ds="..ALIL["Eversong Woods"]};
				{ 29, 8500, "", "=q1=Great Horned Owl", "=ds=#e13#", "=ds="..ALIL["Darnassus"]};
				{ 30, 8501, "", "=q1=Hawk Owl", "=ds=#e13#", "=ds="..ALIL["Darnassus"]};
			};
			{
				{ 1, 88148, "", "=q1=Jade Crane Chick", "=ds=#e13#", "=ds="..AL["Battle Pet Trainer"]};
				{ 2, 29363, "", "=q1=Mana Wyrmling", "=ds=#e13#", "=ds="..ALIL["Netherstorm"]};
				{ 3, 48120, "", "=q1=Obsidian Hatchling", "=ds=#e13#", "=ds="..ALIL["Dalaran"]};
				{ 4, 8496, "", "=q1=Parrot Cage (Cockatiel)", "=ds=#e13#", "=ds="..ALIL["Booty Bay"]};
				{ 5, 8492, "", "=q1=Parrot Cage (Green Wing Macaw)", "=ds=#e13#", "=ds="..ALIL["The Deadmines"]};
				{ 6, 8495, "", "=q1=Parrot Cage (Senegal)", "=ds=#e13#", "=ds="..ALIL["Netherstorm"].." / "..ALIL["Booty Bay"]};
				{ 7, 10394, "", "=q1=Prairie Dog Whistle", "=ds=#e13#", "=ds="..ALIL["Thunder Bluff"]};
				{ 8, 8497, "", "=q1=Rabbit Crate (Snowshoe)", "=ds=#e13#", "=ds="..ALIL["Dun Morogh"]};
				{ 9, 29956, "", "=q1=Red Dragonhawk Hatchling", "=ds=#e13#", "=ds="..ALIL["Silvermoon City"]};
				{ 10, 29902, "", "=q1=Red Moth Egg", "=ds=#e13#", "=ds="..ALIL["Netherstorm"]};
				{ 11, "s123212", "", "=q1=Shore Crawler", "=ds=#e13#", "=ds="..AL["Battle Pet Trainer"].." =ec1=#m6#"};
				{ 12, 29957, "", "=q1=Silver Dragonhawk Hatchling", "=ds=#e13#", "=ds="..ALIL["Silvermoon City"]};
				{ 13, 10393, "", "=q1=Undercity Cockroach", "=ds=#e13#", "=ds="..ALIL["Netherstorm"].." / "..ALIL["Undercity"]};
				{
					{ 14, 46767, "", "=q1=Warbot Ignition Key", "=ds=#e13#", "=ds="..ALIL["Dalaran"].." / "..ALIL["Orgrimmar"]};
					{ 14, 46767, "", "=q1=Warbot Ignition Key", "=ds=#e13#", "=ds="..ALIL["Dalaran"].." / "..ALIL["Stormwind City"]};
				};
				{ 15, 29904, "", "=q1=White Moth Egg", "=ds=#e13#", "=ds="..ALIL["The Exodar"]};
				{ 16, 69239, "", "=q1=Winterspring Cub", "=ds=#e13#", "=ds="..ALIL["Winterspring"]};
				{ 17, 29903, "", "=q1=Yellow Moth Egg", "=ds=#e13#", "=ds="..ALIL["The Exodar"]};
			};
		};
		info = {
			name = AL["Merchant Sold Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsQuest"] = {
		["Normal"] = {
			{
				{ 1, 35350, "", "=q3=Chuck's Bucket", "=ds=#e13#", "=q1="..AL["Fishing Daily Reward"]..": "..ALIL["Terokkar Forest"]};
				{ 2, 91040, "", "=q3=Darkmoon Eye", "=ds=#e13#", "=q1=#m4#: #QUESTID:32175#"};
				{ 3, 103670, "", "=q3=Lil' Bling", "=ds=#e13#", "=q1="..AL["Daily Reward"]..": #QUESTID:31752#"};
				{ 4, 94210, "", "=q3=Mountain Panda", "=ds=#e13#", "=q1=#m4#: #QUESTID:32604# / "..ALIL["Fabled Pandaren Pet Supplies"]};
				{ 5, 33818, "", "=q3=Muckbreath's Bucket", "=ds=#e13#", "=q1="..AL["Fishing Daily Reward"]..": "..ALIL["Terokkar Forest"]};
				{ 6, 92799, "", "=q3=Pandaren Air Spirit", "=ds=#e13#", "=q1=#m4#: #QUESTID:32428# / "..ALIL["Sack of Pet Supplies"]};
				{ 7, 92800, "", "=q3=Pandaren Earth Spirit", "=ds=#e13#", "=q1=#m4#: #QUESTID:32428# / "..ALIL["Sack of Pet Supplies"]};
				{ 8, 92798, "", "=q3=Pandaren Fire Spirit", "=ds=#e13#", "=q1=#m4#: #QUESTID:32428# / "..ALIL["Sack of Pet Supplies"]};
				{ 9, 90173, "", "=q3=Pandaren Water Spirit", "=ds=#e13#", "=q1=#m4#: #QUESTID:32428# / "..ALIL["Sack of Pet Supplies"]};
				{ 10, 89587, "", "=q3=Porcupette", "=ds=#e13#", "=ds="..ALIL["Sack of Pet Supplies"]};
				{ 11, 94025, "", "=q3=Red Panda", "=ds=#e13#", "=q1=#m4#: #QUESTID:32603#"};
				{ 12, 35349, "", "=q3=Snarly's Bucket", "=ds=#e13#", "=q1="..AL["Fishing Daily Reward"]..": "..ALIL["Terokkar Forest"]};
				{ 13, 94209, "", "=q3=Snowy Panda", "=ds=#e13#", "=q1=#m4#: #QUESTID:32604# / "..ALIL["Fabled Pandaren Pet Supplies"]};
				{ 14, 94190, "", "=q3=Spectral Porcupette", "=ds=#e13#", "=q1=#m4#: #QUESTID:32616#"};
				{ 15, 44983, "", "=q3=Strand Crawler", "=ds=#e13#", "=q1="..AL["Fishing Daily Reward"]..": "..ALIL["Dalaran"]};
				{ 16, 94208, "", "=q3=Sunfur Panda", "=ds=#e13#", "=q1=#m4#: #QUESTID:32604# / "..ALIL["Fabled Pandaren Pet Supplies"]};
				{ 17, 33816, "", "=q3=Toothy's Bucket", "=ds=#e13#", "=q1="..AL["Fishing Daily Reward"]..": "..ALIL["Terokkar Forest"]};
				{ 18, 72042, "", "=q1=Alliance Balloon", "=ds=#e13#", "=q1=#m4#: #QUESTID:29412# =ec1=#m7#"};
				{ 19, 65661, "", "=q1=Blue Mini Jouster", "=ds=#e13#", "=q1=#m4#: #QUESTID:25560#"};
				{ 20, 66067, "", "=q1=Brazie's Sunflower Seeds", "=ds=#e13#", "=q1=#m4#: #QUESTID:28748#"};
				{ 21, 11110, "", "=q1=Chicken Egg", "=ds=#e13#", "=q1=#m4#: #QUESTID:3861#"};
				{
					{ 22, 84105, "", "=q1=Fishy", "=ds=#e13#", "=q1=#m4#: #QUESTID:31239#"};
					{ 22, 84105, "", "=q1=Fishy", "=ds=#e13#", "=q1=#m4#: #QUESTID:29905#"};
				};
				{ 23, 65662, "", "=q1=Gold Mini Jouster", "=ds=#e13#", "=q1=#m4#: #QUESTID:25560#"};
				{ 24, 72045, "", "=q1=Horde Balloon", "=ds=#e13#", "=q1=#m4#: #QUESTID:29401# =ec1=#m6#"};
				{ 25, 69251, "", "=q1=Lashtail Hatchling", "=ds=#e13#", "=q1=#m4#: #QUESTID:29208#"};
				{ 26, 10398, "", "=q1=Mechanical Chicken", "=ds=#e13#", "=q1=#m4#: #QUESTID:3721#"};
				{ 27, 31760, "", "=q1=Miniwing", "=ds=#e13#", "=q1=#m4#: #QUESTID:10898#"};
				{ 28, 68833, "", "=q1=Panther Cub", "=ds=#e13#", "=q1=#m4#: #QUESTID:29267#"};
				{ 29, 66080, "", "=q1=Tiny Flamefly", "=ds=#e13#", "=q1=#m4#: #QUESTID:28415#"};
				{ 30, 46325, "", "=q1=Withers", "=ds=#e13#", "=q1=#m4#: #QUESTID:13570#"};
			};
		};
		info = {
			name = AL["Quest Reward Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsCrafted"] = {
		["Normal"] = {
			{
				{ 2, 0, "INV_Box_01", "=q6=#p25#", ""};
				{ 3, 60847, "", "=q4=Crawling Claw", "=ds=#e13#"};
				{ 4, 64372, "", "=q3=Clockwork Gnome", "=ds=#e13#"};
				{ 5, 60955, "", "=q3=Fossilized Hatchling", "=ds=#e13#"};
				{ 6, 69821, "", "=q3=Pterrordax Hatchling", "=ds=#e13#"};
				{ 7, 69824, "", "=q3=Voodoo Figurine", "=ds=#e13#"};
				{ 9, 0, "INV_Box_01", "=q6=#p23#", ""};
				{ 10, 67282, "", "=q3=Elementium Geode", "=ds=#e13#"};
				{ 12, 0, "INV_Box_01", "=q6=#p4#", ""};
				{ 13, 67274, "", "=q3=Enchanted Lantern", "=ds=#e13#"};
				{ 14, 67275, "", "=q3=Magic Lamp", "=ds=#e13#"};
				{ 17, 0, "INV_Box_01", "=q6=#p5#", ""};
				{ 18, 60216, "", "=q3=De-Weaponized Mechanical Companion", "=ds=#e13#"};
				{ 19, 87526, "", "=q3=Mechanical Pandaren Dragonling", "=ds=#e13#"};
				{ 20, 59597, "", "=q3=Personal World Destroyer", "=ds=#e13#"};
				{ 21, 94903, "", "=q3=Pierre", "=ds=#e13#"};
				{ 22, 100905, "", "=q3=Rascal-Bot", "=ds=#e13#"};
				{ 23, 15996, "", "=q1=Lifelike Mechanical Toad", "=ds=#e13#"};
				{ 24, 11826, "", "=q1=Lil' Smoky", "=ds=#e13#"};
				{ 25, 4401, "", "=q1=Mechanical Squirrel Box", "=ds=#e13#"};
				{ 26, 11825, "", "=q1=Pet Bombling", "=ds=#e13#"};
				{ 27, 21277, "", "=q1=Tranquil Mechanical Yeti", "=ds=#e13#"};
			};
			{
				{ 2, 0, "INV_Box_01", "=q6=#p24#", ""};
				{ 3, 43698, "", "=q3=Giant Sewer Rat", "=ds=#e13#", "#ACHIEVEMENTID:1958#, =q1="..ALIL["Dalaran"]};
				{ 4, 73953, "", "=q3=Sea Pony", "=ds=#e13#", "=q1="..AL["Darkmoon Island"]};
				{ 5, 27445, "", "=q1=Magical Crawdad Box", "=ds=#e13#", "=q1="..ALIL["Terokkar Forest"]};
				{ 6, 94933, "", "=q1=Tiny Blue Carp", "=ds=#e13#", "=q1="..ALIL["Vale of Eternal Blossoms"]};
				{ 7, 94934, "", "=q1=Tiny Green Carp", "=ds=#e13#", "=q1="..ALIL["The Jade Forest"].." / "..ALIL["Krasarang Wilds"].." / "..ALIL["Valley of the Four Winds"]};
				{ 8, 94932, "", "=q1=Tiny Red Carp", "=ds=#e13#", "=q1="..ALIL["Townlong Steppes"].." / "..ALIL["Dread Wastes"]};
				{ 9, 94935, "", "=q1=Tiny White Carp", "=ds=#e13#", "=q1="..ALIL["Kun-Lai Summit"].." / "..ALIL["Pandaria"]};
				{ 11, 0, "INV_Box_01", "=q6=#p26#", ""};
				{ 12, 89368, "", "=q1=Chi-ji Kite", "=ds=#e13#"};
				{ 13, 89367, "", "=q1=Yu'lon Kite", "=ds=#e13#"};
				{ 17, 0, "INV_Box_01", "=q6=#p12#", ""};
				{ 18, 82774, "", "=q3=Jade Owl", "=ds=#e13#"};
				{ 19, 82775, "", "=q3=Sapphire Cub", "=ds=#e13#"};
				{ 21, 0, "INV_Box_01", "=q6=#p8#", ""};

				{ 22, 90900, "", "=q3=Imperial Moth", "=ds=#e13#"};
				{ 23, 90902, "", "=q2=Imperial Silkworm", "=ds=#e13#"};
			};
		};
		info = {
			name = AL["Crafted Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsAchievement"] = {
		["Normal"] = {
			{
				{ 2, 63398, "", "=q3=Armadillo Pup", "=ds=#e13#", "#ACHIEVEMENTID:5144#"};
				{ 3, 71387, "", "=q3=Brilliant Kaliri", "=ds=#e13#", "#ACHIEVEMENTID:5877#" },
				{ 4, 54810, "", "=q3=Celestial Dragon", "=ds=#e13#", "#ACHIEVEMENTID:5875#" },
				{
					{ 5, 63138, "", "=q3=Dark Phoenix Hatchling", "=ds=#e13#", "#ACHIEVEMENTID:5892#, =ec1=#m6#"};
					{ 5, 63138, "", "=q3=Dark Phoenix Hatchling", "=ds=#e13#", "#ACHIEVEMENTID:5812#, =ec1=#m7#"};
				};
				{
					{ 6, 65364, "", "=q3=Guild Herald", "=ds=#e13#", "#ACHIEVEMENTID:5201#, =ec1=#m6#"};
					{ 6, 65363, "", "=q3=Guild Herald", "=ds=#e13#", "#ACHIEVEMENTID:5201#, =ec1=#m7#"};
				};
				{
					{ 7, 65362, "", "=q3=Guild Page", "=ds=#e13#", "#ACHIEVEMENTID:5179#, =ec1=#m6#"};
					{ 7, 65361, "", "=q3=Guild Page", "=ds=#e13#", "#ACHIEVEMENTID:5031#, =ec1=#m7#"};
				};
				{ 8, 85578, "", "=q3=Feral Vermling", "=ds=#e13#", "#ACHIEVEMENTID:7500#"};
				{ 9, 86562, "", "=q3=Hopling", "=ds=#e13#", "#ACHIEVEMENTID:6402#"};
				{ 10, 89686, "", "=q3=Jade Tentacle", "=ds=#e13#", "#ACHIEVEMENTID:7521#"};
				{ 11, 44738, "", "=q3=Kirin Tor Familiar", "=ds=#e13#", "#ACHIEVEMENTID:1956#"};
				{ 12, 44841, "", "=q3=Little Fawn's Salt Lick", "=ds=#e13#", "#ACHIEVEMENTID:2516#"};
				{ 13, 93031, "", "=q3=Mr. Bigglesworth", "=ds=#e13#", "#ACHIEVEMENTID:7934#"};
				{ 14, 71140, "", "=q3=Nuts' Acorn", "=ds=#e13#", "#ACHIEVEMENTID:5876#" },
				{ 17, 49912, "", "=q3=Perky Pug", "=ds=#e13#", "#ACHIEVEMENTID:4478#"};
				{ 18, 40653, "", "=q3=Reeking Pet Carrier", "=ds=#e13#", "#ACHIEVEMENTID:1250#"};
				{ 19, 88147, "", "=q3=Singing Cricket Cage", "=ds=#e13#", "#ACHIEVEMENTID:6582#"};
				{ 20, 94191, "", "=q3=Stunted Direhorn", "=ds=#e13#", "#ACHIEVEMENTID:8300#"};
				{ 21, 85513, "", "=q3=Thundering Serpent Hatchling", "=ds=#e13#", "#ACHIEVEMENTID:6634#"};
				{ 22, 97558, "", "=q3=Tito's Basket", "=ds=#e13#", "#ACHIEVEMENTID:8293#"};
				{ 23, 44810, "", "=q3=Turkey Cage", "=ds=#e13#", "#ACHIEVEMENTID:3478#"};
				{ 24, 89736, "", "=q3=Venus", "=ds=#e13#", "#ACHIEVEMENTID:7501#"};
				{ 25, 71033, "", "=q1=Lil' Tarecgosa", "=ds=#e13#", "#ACHIEVEMENTID:5840#" },
				{ 26, 60869, "", "=q1=Pebble", "=ds=#e13#", "#ACHIEVEMENTID:5449#"};
			};
		};
		info = {
			name = AL["Achievement Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsFaction"] = {
		["Normal"] = {
			{
				{ 2, 104295, "", "=q3=Harmonious Porcupette", "=ds=#e13#", "=ds=#TIMELESSCOIN:7500#=q2="..ALIL["Emperor Shaohao"]};
				{ 3, 38628, "", "=q3=Nether Ray Fry", "=ds=#e13#", "=ds="..ALIL["Sha'tari Skyguard"]};
				{ 4, 44723, "", "=q3=Nurtured Penguin Egg", "=ds=#e13#", "=ds="..ALIL["The Kalu'ak"]};
				{ 5, 85222, "", "=q3=Red Cricket", "=ds=#e13#", "=ds="..ALIL["Sho"].." - "..AL["Best Friend"]};
				{ 6, 85447, "", "=q3=Tiny Goldfish", "=ds=#e13#", "=ds="..ALIL["The Anglers"]};
				{ 7, 34478, "", "=q3=Tiny Sporebat", "=ds=#e13#", "=ds="..ALIL["Sporeggar"]};
				{ 8, 39898, "", "=q1=Cobra Hatchling", "=ds=#e13#", "=ds="..ALIL["The Oracles"].." - =q2="..ALIL["Mysterious Egg"]};
				{ 9, 44721, "", "=q1=Proto-Drake Whelp", "=ds=#e13#", "=ds="..ALIL["The Oracles"].." - =q2="..ALIL["Mysterious Egg"]};
				{ 10, 39896, "", "=q1=Tickbird Hatchling", "=ds=#e13#", "=ds="..ALIL["The Oracles"].." - =q2="..ALIL["Mysterious Egg"]};
				{ 11, 39899, "", "=q1=White Tickbird Hatchling", "=ds=#e13#", "=ds="..ALIL["The Oracles"].." - =q2="..ALIL["Mysterious Egg"]};
				{
					{ 17, "", "inv_misc_tournaments_symbol_orc", "=q6="..FACTION_HORDE, ""};
					{ 17, "", "inv_misc_tournaments_symbol_human", "=q6="..FACTION_ALLIANCE, ""};
				};
				{
					{ 18, 90898, "", "=q3=Fox Kit", "=ds=#e13#", "=ds="..ALIL["Hellscream's Reach"]};
					{ 18, 90897, "", "=q3=Fox Kit", "=ds=#e13#", "=ds="..ALIL["Baradin's Wardens"]};
				};
				{
					{ 19, 64996, "", "=q3=Rustberg Gull", "=ds=#e13#", "=ds="..ALIL["Hellscream's Reach"]};
					{ 19, 63355, "", "=q3=Rustberg Gull", "=ds=#e13#", "=ds="..ALIL["Baradin's Wardens"]};
				};
				{
					{ 20, 46821, "", "=q3=Shimmering Wyrmling", "=ds=#e13#", "=ds="..ALIL["The Sunreavers"]};
					{ 20, 46820, "", "=q3=Shimmering Wyrmling", "=ds=#e13#", "=ds="..ALIL["The Silver Covenant"]};
				};
				{
					{ 21, 93025, "", "=q1=Clock'em", "=ds=#e13#", "=ds="..ALIL["Brawl'gar Arena"].." - "..string.format(AL["Rank %d"], 4)};
					{ 21, 93025, "", "=q1=Clock'em", "=ds=#e13#", "=ds="..ALIL["Bizmo's Brawlpub"].." - "..string.format(AL["Rank %d"], 4)};
				};
			};
		};
		info = {
			name = AL["Faction Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsRare"] = {
		["Normal"] = {
			{
				{ 1, 80008, "", "=q4=Darkmoon Rabbit", "=ds=#e13#", "#ACHIEVEMENTID:6332#"};
				{ 2, 8494, "", "=q4=Parrot Cage (Hyacinth Macaw)", "=ds=#e13#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Stranglethorn Vale"]};

				{ 3, 104156, "", "=q3=Ashleaf Spriteling", "=ds=#e13#", "=q2="..ALIL["Leafmender"]..", =q1="..ALIL["Timeless Isle"]};
				{ 4, 104157, "", "=q3=Azure Crane Chick", "=ds=#e13#", "=q2="..ALIL["Crane Nest"]..", =q1="..ALIL["Timeless Isle"]};
				{ 5, 104202, "", "=q3=Bonkers", "=ds=#e13#", "=q2="..AL["Timeless Chest"]..", =q1="..ALIL["Timeless Isle"]};
				{ 6, 104160, "", "=q3=Dandelion Frolicker", "=ds=#e13#", "=q2="..AL["Scary Sprite"]..", =q1="..ALIL["Timeless Isle"]};
				{ 7, 104161, "", "=q3=Death Adder Hatchling", "=ds=#e13#", "=q2="..ALIL["Imperial Python"]..", =q1="..ALIL["Timeless Isle"]};
				{ 8, 64403, "", "=q3=Fox Kit", "=ds=#e13#", "=q2="..AL["Baradin Fox"]..", =q1="..ALIL["Tol Barad Peninsula"]};
				{ 9, 97821, "", "=q3=Gahz'rooki's Summoning Stone", "=ds=#e13#", "=q2="..ALIL["Darkspear Rebellion"]..", =q1="..ALIL["Northern Barrens"]};
				{ 10, 43698, "", "=q3=Giant Sewer Rat", "=ds=#e13#", "#ACHIEVEMENTID:1958#, =q1="..ALIL["Dalaran"]};
				{ 11, 104169, "", "=q3=Gulp Froglet", "=ds=#e13#", "=q2="..ALIL["Bufo"]..", =q1="..ALIL["Timeless Isle"]};
				{ 12, 97961, "", "=q3=Half-Empty Food Container", "=ds=#e13#", "=q1="..ALIL["Isle of Thunder"]};

				{ 13, 86563, "", "=q3=Hollow Reed", "=ds=#e13#", "=q2="..ALIL["Nalash Verdantis"]..", =q1="..ALIL["Dread Wastes"]};
				{ 14, 86564, "", "=q3=Imbued Jade Fragment", "=ds=#e13#", "=q2="..ALIL["Karr the Darkener"]..", =q1="..ALIL["Dread Wastes"]};
				{ 15, 104307, "", "=q3=Jadefire Spirit", "=ds=#e13#", "=q2="..ALIL["Spirit of Jadefire"]..", =q1="..ALIL["Timeless Isle"]};
				{ 16, 104164, "", "=q3=Jademist Dancer", "=ds=#e13#", "=q2="..ALIL["Jademist Dancer"]..", =q1="..ALIL["Timeless Isle"]};
				{ 17, 104166, "", "=q3=Ominous Flame", "=ds=#e13#", "=q2="..ALIL["Foreboding Flame"]..", =q1="..ALIL["Timeless Isle"]};
				{ 18, 104159, "", "=q3=Ruby Droplet", "=ds=#e13#", "=q2="..ALIL["Garnia"]..", =q1="..ALIL["Timeless Isle"]};
				{ 19, 73953, "", "=q3=Sea Pony", "=ds=#e13#", "=q2=#p24#, =q1="..AL["Darkmoon Island"]};
				{ 20, 104167, "", "=q3=Skunky Alemental", "=ds=#e13#", "=q2="..ALIL["Zhu-Gon the Sour"]..", =q1="..ALIL["Timeless Isle"]};
				{ 21, 94595, "", "=q3=Spawn of G'nathus", "=ds=#e13#", "=q2="..BabbleRare["G'nathus"]..", =q1="..ALIL["Townlong Steppes"]};
				{ 22, 104168, "", "=q3=Spineclaw Crab", "=ds=#e13#", "=q2="..ALIL["Monstrous Spineclaw"]..", =q1="..ALIL["Timeless Isle"]};
				{ 23, 94124, "", "=q3=Sunreaver Micro-Sentry", "=ds=#e13#", "=q2="..ALIL["Haywire Sunreaver Construct"]..", =q1="..ALIL["Isle of Thunder"]};
				{ 24, 104291, "", "=q3=Swarmling of Gu'chi", "=ds=#e13#", "=q2="..ALIL["Gu'chi the Swarmbringer"]..", =q1="..ALIL["Timeless Isle"]};
				{ 25, 85220, "", "=q3=Terrible Turnip", "=ds=#e13#", "=q2="..ALIL["Ominous Seed"]..", =q1="..AL["Halfhill Farm"]};
				{ 26, 95422, "", "=q3=Zandalari Anklerender", "=ds=#e13#", "=q1="..ALIL["Isle of Giants"]};

				{ 27, 95423, "", "=q3=Zandalari Footslasher", "=ds=#e13#", "=q1="..ALIL["Isle of Giants"]};

				{ 28, 94126, "", "=q3=Zandalari Kneebiter", "=ds=#e13#", "=q1="..ALIL["Isle of Giants"]};

				{ 29, 95424, "", "=q3=Zandalari Toenibbler", "=ds=#e13#", "=q1="..ALIL["Isle of Giants"]};

				{ 30, 34535, "", "=q1=Azure Whelpling", "=ds=#e13#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Winterspring"]};
				extraText = ": "..AL["World Drop"]
			};
			{
				{ 1, 29960, "", "=q1=Captured Firefly", "=ds=#e13#", "=q2="..AL["Bogflare Needler"]..", =q1="..ALIL["Zangarmarsh"]};
				{ 2, 8491, "", "=q1=Cat Carrier (Black Tabby)", "=ds=#e13#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Hillsbrad Foothills"]};
				{ 3, 10822, "", "=q1=Dark Whelpling", "=ds=#e13#", "=q2="..ALIL["Wetlands"].." / "..ALIL["Badlands"].." / "..ALIL["Burning Steppes"]};
				{ 4, 48112, "", "=q1=Darting Hatchling", "=ds=#e13#", "=q2="..BabbleRare["Dart's Nest"]..", =q1="..ALIL["Dustwallow Marsh"]};
				{ 5, 20769, "", "=q1=Disgusting Oozeling", "=ds=#e13#", "=q2="..ALIL["Oozing Bag"]..", =q1="..AL["Various Locations"]};
				{ 6, 48116, "", "=q1=Gundrak Hatchling", "=ds=#e13#", "=q2="..AL["Gundrak Raptor"]..", =q1="..ALIL["Zul'Drak"]};
				{ 7, 48118, "", "=q1=Leaping Hatchling", "=ds=#e13#", "=q2="..BabbleRare["Takk's Nest"]..", =q1="..ALIL["Northern Barrens"]};
				{ 8, 27445, "", "=q1=Magical Crawdad Box", "=ds=#e13#", "=ds="..ALIL["Terokkar Forest"]};
				{ 9, 66076, "", "=q1=Mr. Grubbs", "=ds=#e13#", "=q2="..ALIL["Hidden Stash"]..", =q1="..ALIL["Eastern Plaguelands"]};
				{ 10, 48122, "", "=q1=Ravasaur Hatchling", "=ds=#e13#", "=q2="..BabbleRare["Ravasaur Matriarch's Nest"]..", =q1="..ALIL["Un'Goro Crater"]};
				{ 11, 48124, "", "=q1=Razormaw Hatchling", "=ds=#e13#", "=q2="..BabbleRare["Razormaw Matriarch's Nest"]..", =q1="..ALIL["Wetlands"]};
				{ 12, 48126, "", "=q1=Razzashi Hatchling", "=ds=#e13#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Stranglethorn Vale"]};
				{ 13, 11474, "", "=q1=Sprite Darter Egg", "=ds=#e13#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Feralas"]};
				{ 14, 8499, "", "=q1=Tiny Crimson Whelpling", "=ds=#e13#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Wetlands"]};
				{ 15, 8498, "", "=q1=Tiny Emerald Whelpling", "=ds=#e13#", "=q2="..AL["Noxious Whelp"]..", =q1="..ALIL["Feralas"]};
				{ 16, 64494, "", "=q1=Tiny Shale Spider", "=ds=#e13#", "=q2="..BabbleRare["Jadefang"]..", =q1="..ALIL["Deepholm"]};
				extraText = ": "..AL["World Drop"]
			};
			{
				{ 1, 93040, "", "=q3=Anubisath Idol", "=ds=#e13#", "=q2="..BabbleBoss["Emperor Vek'lor"]..", =q1="..ALIL["Temple of Ahn'Qiraj"]};
				{ 2, 104158, "", "=q3=Blackfuse Bombling", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 3, 93037, "", "=q3=Blackwing Banner", "=ds=#e13#", "=q2="..BabbleBoss["Broodlord Lashlayer"]..", =q1="..ALIL["Blackwing Lair"]};
				{ 4, 93034, "", "=q3=Blazing Rune", "=ds=#e13#", "=q2="..BabbleBoss["Magmadar"]..", =q1="..ALIL["Molten Core"]};
				{ 5, 93032, "", "=q3=Blighted Spore", "=ds=#e13#", "=q2="..BabbleBoss["Loatheb"]..", =q1="..ALIL["Naxxramas"]};
				{ 6, 97557, "", "=q3=Brilliant Phoenix Hawk Feather", "=ds=#e13#", "=q2="..BabbleBoss["Al'ar"]..", =q1="..ALIL["Tempest Keep"]};
				{ 7, 93035, "", "=q3=Core of Hardened Ash", "=ds=#e13#", "=q2="..BabbleBoss["Golemagg the Incinerator"]..", =q1="..ALIL["Molten Core"]};
				{ 8, 97556, "", "=q3=Crystal of the Void", "=ds=#e13#", "=q2="..BabbleBoss["High Astromancer Solarian"]..", =q1="..ALIL["Tempest Keep"]};
				{ 9, 97960, "", "=q3=Dark Quivering Blob", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Primordius", 820).." - "..AL["Normal"].."/"..AL["Heroic"]..", =q1="..ALIL["Throne of Thunder"]};
				{ 10, 97554, "", "=q3=Dripping Strider Egg", "=ds=#e13#", "=q2="..BabbleBoss["Lady Vashj"]..", =q1="..ALIL["Serpentshrine Cavern"]};
				{ 11, 104162, "", "=q3=Droplet of Y'Shaarj", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Sha of Pride", 867).." - "..AL["Flexible"].."/"..AL["Normal"].."/"..AL["Heroic"]..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 12, 93030, "", "=q3=Dusty Clutch of Eggs", "=ds=#e13#", "=q2="..BabbleBoss["Maexxna"]..", =q1="..ALIL["Naxxramas"]};
				{ 13, 93029, "", "=q3=Gluth's Bone", "=ds=#e13#", "=q2="..BabbleBoss["Gluth"]..", =q1="..ALIL["Naxxramas"]};
				{ 14, 104163, "", "=q3=Gooey Sha-ling", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Sha of Pride", 867).." - "..AL["Raid Finder"].."/"..AL["Flexible"]..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 15, 97549, "", "=q3=Instant Arcane Sanctum Security Kit", "=ds=#e13#", "=q2="..BabbleBoss["The Curator"]..", =q1="..ALIL["Karazhan"]};
				{ 16, 93041, "", "=q3=Jewel of Maddening Whispers", "=ds=#e13#", "=q2="..BabbleBoss["The Prophet Skeram"]..", =q1="..ALIL["Temple of Ahn'Qiraj"]};
				{ 17, 94835, "", "=q3=Ji-Kun Hatchling", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Ji-Kun", 828)..", =q1="..ALIL["Throne of Thunder"]};
				{ 18, 104165, "", "=q3=Kovok", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 19, 94125, "", "=q3=Living Sandling", "=ds=#e13#", "=q2="..AL["Trash Mobs"]..", =q1="..ALIL["Throne of Thunder"]};
				{ 20, 93033, "", "=q3=Mark of Flame", "=ds=#e13#", "=q2="..BabbleBoss["Sulfuron Harbinger"]..", =q1="..ALIL["Molten Core"]};
				{ 21, 33993, "", "=q3=Mojo", "=ds=#e13#", "=q1="..ALIL["Zul'Aman"]};
				{ 22, 97550, "", "=q3=Netherspace Portal-Stone", "=ds=#e13#", "=q2="..BabbleBoss["Prince Malchezaar"]..", =q1="..ALIL["Karazhan"]};
				{ 23, 35504, "", "=q3=Phoenix Hatchling", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Kael'thas Sunstrider", 533)..", =q1="..ALIL["Magisters' Terrace"]};
				{ 24, 97959, "", "=q3=Quivering Blob", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Primordius", 820).." - "..AL["Raid Finder"]..", =q1="..ALIL["Throne of Thunder"]};
				{ 25, 97551, "", "=q3=Satyr Charm", "=ds=#e13#", "=q2="..BabbleBoss["Terestian Illhoof"]..", =q1="..ALIL["Karazhan"]};
				{ 26, 97552, "", "=q3=Shell of Tide-Calling", "=ds=#e13#", "=q2="..BabbleBoss["Morogrim Tidewalker"]..", =q1="..ALIL["Serpentshrine Cavern"]};
				{ 27, 68673, "", "=q3=Smolderweb Egg", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Mother Smolderweb", 391)..", =q1="..ALIL["Lower Blackrock Spire"]};
				{ 28, 94152, "", "=q3=Son of Animus", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Dark Animus", 824)..", =q1="..ALIL["Throne of Thunder"]};
				{ 29, 97548, "", "=q3=Spiky Collar", "=ds=#e13#", "=q2="..BabbleBoss["The Big Bad Wolf"]..", =q1="..ALIL["Karazhan"]};
				{ 30, 97553, "", "=q3=Tainted Core", "=ds=#e13#", "=q2="..BabbleBoss["Hydross the Unstable"]..", =q1="..ALIL["Serpentshrine Cavern"]};
				extraText = ": "..AL["Dungeon/Raid"]
			};
			{
				{ 1, 97555, "", "=q3=Tiny Fel Engine Key", "=ds=#e13#", "=q2="..BabbleBoss["Void Reaver"]..", =q1="..ALIL["Tempest Keep"]};
				{ 2, 93036, "", "=q3=Unscathed Egg", "=ds=#e13#", "=q2="..BabbleBoss["Razorgore the Untamed"]..", =q1="..ALIL["Blackwing Lair"]};
				{ 3, 93039, "", "=q3=Viscidus Globule", "=ds=#e13#", "=q2="..BabbleBoss["Viscidus"]..", =q1="..ALIL["Temple of Ahn'Qiraj"]};
				{ 4, 93038, "", "=q3=Whistle of Chromatic Bone", "=ds=#e13#", "=q2="..BabbleBoss["Chromaggus"]..", =q1="..ALIL["Blackwing Lair"]};
				{ 5, 12264, "", "=q3=Worg Carrier", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Quartermaster Zigris", 393)..", =q1="..ALIL["Lower Blackrock Spire"]};
				{ 6, 48114, "", "=q1=Deviate Hatchling", "=ds=#e13#", "=q2="..AL["Deviate Ravager/Deviate Guardian"]..", =q1="..ALIL["Wailing Caverns"]};
				extraText = ": "..AL["Dungeon/Raid"]
			};
		};
		info = {
			name = AL["Rare Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsEvent"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Argent Tournament"], ""};
				{ 2, 45022, "", "=q3=Argent Gruntling", "=ds=#e13#", "=ds=#m4#, =ec1=#m6#"};
				{ 3, 44998, "", "=q3=Argent Squire", "=ds=#e13#", "=ds=#m4#, =ec1=#m7#"};
				{ 4, 44984, "", "=q3=Ammen Vale Lashling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 5, 44970, "", "=q3=Dun Morogh Cub", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 6, 44973, "", "=q3=Durotar Scorpion", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 7, 44974, "", "=q3=Elwynn Lamb", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 8, 44982, "", "=q3=Enchanted Broom", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 9, 45002, "", "=q3=Mechanopeep", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 10, 44980, "", "=q3=Mulgore Hatchling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 11, 45606, "", "=q3=Sen'jin Fetish", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 12, 44965, "", "=q3=Teldrassil Sproutling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 13, 44971, "", "=q3=Tirisfal Batling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Brewfest"], ""};
				{ 17, 46707, "", "=q3=Pint-Sized Pink Pachyderm", "=ds=#e13#", "#BREWFEST:100#"};
				{ 18, 32233, "", "=q3=Wolpertinger's Tankard", "=ds=#e13#", "40 #silver#"};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Children's Week"], ""};
				{ 21, 46545, "", "=q3=Curious Oracle Hatchling", "=ds=#e13#", "=q1=#m4#: #QUESTID:13959#"};
				{ 22, 46544, "", "=q3=Curious Wolvar Pup", "=ds=#e13#", "=q1=#m4#: #QUESTID:13960#"};
				{
					{ 23, 32616, "", "=q3=Egbert's Egg", "=ds=#e13#", "=q1=#m4#: #QUESTID:10967#"};
					{ 23, 32616, "", "=q3=Egbert's Egg", "=ds=#e13#", "=q1=#m4#: #QUESTID:10966#"};
				};
				{
					{ 24, 32622, "", "=q3=Elekk Training Collar", "=ds=#e13#", "=q1=#m4#: #QUESTID:10967#"};
					{ 24, 32622, "", "=q3=Elekk Training Collar", "=ds=#e13#", "=q1=#m4#: #QUESTID:10966#"};
				};
				{
					{ 25, 69648, "", "=q3=Legs", "=ds=#e13#", "=q1=#m4#: #QUESTID:10967#"};
					{ 25, 69648, "", "=q3=Legs", "=ds=#e13#", "=q1=#m4#: #QUESTID:10966#"};
				};
				{
					{ 26, 32617, "", "=q3=Sleepy Willy", "=ds=#e13#", "=q1=#m4#: #QUESTID:10967#"};
					{ 26, 32617, "", "=q3=Sleepy Willy", "=ds=#e13#", "=q1=#m4#: #QUESTID:10966#"};
				};
				{
					{ 27, 23007, "", "=q1=Piglet's Collar", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
					{ 27, 23007, "", "=q1=Piglet's Collar", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
				};
				{
					{ 28, 23015, "", "=q1=Rat Cage", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
					{ 28, 23015, "", "=q1=Rat Cage", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
				};
				{
					{ 29, 66073, "", "=q1=Snail Shell", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
					{ 29, 66073, "", "=q1=Snail Shell", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
				};
				{
					{ 30, 23002, "", "=q1=Turtle Box", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
					{ 30, 23002, "", "=q1=Turtle Box", "=ds=#e13#", "=q1=#m4#: #QUESTID:171#"};
				};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..ALIL["Darkmoon Faire"], ""};
				{ 2, 80008, "", "=q4=Darkmoon Rabbit", "=ds=#e13#", "#ACHIEVEMENTID:6332#"};
				{ 3, 73762, "", "=q3=Darkmoon Balloon", "=ds=#e13#", "#DARKMOON:90#"};
				{ 4, 91040, "", "=q3=Darkmoon Eye", "=ds=#e13#", "=q1=#m4#: #QUESTID:32175#"};
				{ 5, 74981, "", "=q3=Darkmoon Cub", "=ds=#e13#", "#DARKMOON:90#"};
				{ 6, 91003, "", "=q3=Darkmoon Hatchling", "=ds=#e13#", "#DARKMOON:90#"};
				{ 7, 73764, "", "=q3=Darkmoon Monkey", "=ds=#e13#", "#DARKMOON:90#"};
				{ 8, 73903, "", "=q3=Darkmoon Tonk", "=ds=#e13#", "#DARKMOON:90#"};
				{ 9, 73765, "", "=q3=Darkmoon Turtle", "=ds=#e13#", "#DARKMOON:90#"};
				{ 10, 73905, "", "=q3=Darkmoon Zeppelin", "=ds=#e13#", "#DARKMOON:90#"};
				{ 11, 101570, "", "=q3=Moon Moon", "=ds=#e13#", "=q2="..AL["Drop"]..": "..AL["Moonfang"]..", =q1="..AL["Darkmoon Island"]};
				{ 12, 73953, "", "=q3=Sea Pony", "=ds=#e13#", "=q2=#p24#, =q1="..AL["Darkmoon Island"]};
				{ 13, 19450, "", "=q1=A Jubling's Tiny Home", "=ds=#e13#", "=q1=#m4#: #QUESTID:7946#"};
				{ 14, 11026, "", "=q1=Tree Frog Box", "=ds=#e13#", "1 #gold#"};
				{ 15, 11027, "", "=q1=Wood Frog Box", "=ds=#e13#", "1 #gold#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Feast of Winter Veil"], ""};
				{ 17, 73797, "", "=q3=Lump of Coal", "=ds=#e13#", "=ds=#e13#"};
				{ 18, 104317, "", "=q3=Rotten Helper Box", "=ds=#e13#"};
				{ 19, 21301, "", "=q1=Green Helper Box", "=ds=#e13#", "=ds=#e13#"};
				{ 20, 21308, "", "=q1=Jingling Bell", "=ds=#e13#", "=ds=#e13#"};
				{ 21, 21305, "", "=q1=Red Helper Box", "=ds=#e13#", "=ds=#e13#"};
				{ 22, 21309, "", "=q1=Snowman Kit", "=ds=#e13#", "=ds=#e13#"};
				{ 24, 0, "INV_Box_01", "=q6="..AL["Hallow's End"], ""};
				{ 25, 33154, "", "=q3=Sinister Squashling", "=ds=#e13#", "#HALLOWSEND:150# =ds="..AL["Daily Reward"]};
				{
					{ 26, 71076, "", "=q1=Creepy Crate", "=ds=#e13#", "=q1=#m4#: #QUESTID:29429#"};
					{ 26, 71076, "", "=q1=Creepy Crate", "=ds=#e13#", "=q1=#m4#: #QUESTID:29413#"};
				};
				{ 27, 70908, "", "=q1=Feline Familiar", "=ds=#e13#", "#HALLOWSEND:150#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Love is in the Air"], ""};
				{ 2, 50446, "", "=q3=Toxic Wasteling", "=ds=#e13#", "=ds="..AL["Daily Reward"]};
				{ 3, 22235, "", "=q1=Truesilver Shafted Arrow", "=ds=#e13#", "#VALENTINEDAY:40#"};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Lunar Festival"], ""};
				{ 6, 74611, "", "=q3=Festival Lantern", "=ds=#e13#", "#LUNARFESTIVAL:50#"};
				{ 7, 74610, "", "=q3=Lunar Lantern", "=ds=#e13#", "#LUNARFESTIVAL:50#"};
				{ 9, 0, "INV_Box_01", "=q6="..AL["Midsummer Fire Festival"], ""};
				{ 10, 23083, "", "=q3=Captured Flame", "=ds=#e13#", "#MIDSUMMER:350#"};
				{ 11, 53641, "", "=q3=Ice Chip", "=ds=#e13#", "=ds="..AL["Daily Reward"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Noblegarden"], ""};
				{ 17, 44794, "", "=q3=Spring Rabbit's Foot", "=ds=#e13#", "#NOBLEGARDEN:100#"};
				{ 19, 0, "INV_Box_01", "=q6="..AL["Pilgrim's Bounty"], ""};
				{
					{ 20, 44810, "", "=q3=Turkey Cage", "=ds=#e13#", "#ACHIEVEMENTID:3656#, =ec1=#m6#"};
					{ 20, 44810, "", "=q3=Turkey Cage", "=ds=#e13#", "#ACHIEVEMENTID:3478#, =ec1=#m7#"};
				};
			};
		};
		info = {
			name = BabbleInventory["Companions"].." - "..AL["World Events"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsPromotional"] = {
		["Normal"] = {
			{
				{ 2, 90177, "", "=q3=Baneling", "=ds=#e13#", "#ACHIEVEMENTID:7842#"};
				{ 3, 20371, "", "=q3=Blue Murloc Egg", "=ds=#e13#", "#ACHIEVEMENTID:411#"};
				{ 4, 49646, "", "=q3=Core Hound Pup", "=ds=#e13#", "=ds=#e13#"};
				{ 5, 13584, "", "=q3=Diablo Stone", "=ds=#e13#", "#ACHIEVEMENTID:662#"};
				{ 6, 109014, "", "=q3=Dread Hatchling", "=ds=#e13#"};
				{ 7, 76062, "", "=q3=Fetish Shaman's Spear", "=ds=#e13#", "#ACHIEVEMENTID:7412#"};
				{ 8, 39286, "", "=q3=Frosty's Collar", "=ds=#e13#", "#ACHIEVEMENTID:683#"};
				{ 9, 46802, "", "=q3=Heavy Murloc Egg", "=ds=#e13#", "#ACHIEVEMENTID:3536#"};
				{ 10, 62540, "", "=q3=Lil' Deathwing", "=ds=#e13#", "#ACHIEVEMENTID:5377#"};
				{ 11, 85871, "", "=q3=Lucky Quilen Cub", "=ds=#e13#", "#ACHIEVEMENTID:6848#"};
				{ 12, 30360, "", "=q3=Lurky's Egg", "=ds=#e13#", "=q2="..AL["Burning Crusade"].." "..AL["Collector's Edition"]};
				{ 17, 56806, "", "=q3=Mini Thor", "=ds=#e13#", "#ACHIEVEMENTID:4824#"};
				{ 18, 106244, "", "=q3=Murkalot's Flail", "=ds=#e13#", "#ACHIEVEMENTID:8793#"};
				{ 19, 45180, "", "=q3=Murkimus' Little Spear", "=ds=#e13#", "#ACHIEVEMENTID:3618#"};
				{ 20, 71726, "", "=q3=Murky's Little Soulstone", "=ds=#e13#", "#ACHIEVEMENTID:6185#"};
				{ 21, 25535, "", "=q3=Netherwhelp's Collar", "=ds=#e13#", "#ACHIEVEMENTID:665#"};
				{ 22, 13583, "", "=q3=Panda Collar", "=ds=#e13#", "#ACHIEVEMENTID:663#"};
				{ 23, 22114, "", "=q3=Pink Murloc Egg", "=ds=#e13#", "=ds=#e13#"};
				{ 24, 67418, "", "=q3=Smoldering Murloc Egg", "=ds=#e13#", "#ACHIEVEMENTID:5378#"};
				{ 25, 106256, "", "=q3=Treasure Goblin's Pack", "=ds=#e13#", "#ACHIEVEMENTID:8795#"};
				{ 26, 39656, "", "=q3=Tyrael's Hilt", "=ds=#e13#", "#ACHIEVEMENTID:414#"};
				{ 27, 13582, "", "=q3=Zergling Leash", "=ds=#e13#", "#ACHIEVEMENTID:664#"};
			};
		};
		info = {
			name = AL["Promotional Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsCardGame"] = {
		["Normal"] = {
			{
				{ 2, 34493, "", "=q4=Dragon Kite", "=ds=#e13#", "=q1="..AL["March of the Legion"]};
				{ 3, 23713, "", "=q4=Hippogryph Hatchling", "=ds=#e13#", "=q1="..AL["Heroes of Azeroth"]};
				{ 4, 49287, "", "=q4=Tuskarr Kite", "=ds=#e13#", "=q1="..AL["Scourgewar"]};
				{ 5, 32588, "", "=q3=Banana Charm", "=ds=#e13#", "=q1="..AL["Through The Dark Portal"]};
				{ 6, 79744, "", "=q3=Eye of the Legion", "=ds=#e13#", "=q1="..AL["War of the Ancients"]};
				{ 7, 72134, "", "=q3=Grell Moss", "=ds=#e13#", "=q1="..AL["Crown of Heaven"]};
				{ 8, 93669, "", "=q3=Gusting Grimoire", "=q1="..AL["Betrayal of the Guardian"]};
				{ 9, 68840, "", "=q3=Landro's Lichling", "=ds=#e13#", "=q1="..AL["War of the Elements"]};
				{ 17, 67128, "", "=q3=Landro's Lil' XT", "=ds=#e13#", "=q1="..AL["Worldbreaker"]};
				{ 18, 71624, "", "=q3=Purple Puffer", "=ds=#e13#", "=q1="..ALIL["Throne of the Tides"]};
				{ 19, 34492, "", "=q3=Rocket Chicken", "=ds=#e13#", "=q1="..AL["March of the Legion"]};
				{ 20, 72153, "", "=q3=Sand Scarab", "=ds=#e13#", "=q1="..AL["Tomb of the Forgotten"]};
				{ 21, 38050, "", "=q3=Soul-Trader Beacon", "=ds=#e13#", "=q1="..AL["Hunt for Illidan"]};
				{ 22, 49343, "", "=q3=Spectral Tiger Cub", "=ds=#e13#", "=q1="..AL["Scourgewar"]};
				{ 23, 68841, "", "=q3=Nightsaber Cub", "=ds=#e13#", "=q1="..AL["Twilight of the Dragons"]};
			};
		};
		info = {
			name = AL["Card Game Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsRemoved"] = {
		["Normal"] = {
			{
				{ 2, 37297, "", "=q3=Gold Medallion", "=ds=#e13#"};
				{ 3, 100870, "", "=q3=Murkimus' Tyrannical Spear", "=ds=#e13#", ""};
				{ 4, 41133, "", "=q3=Unhatched Mr. Chilly", "=ds=#e13#"};
				{ 5, 38658, "", "=q3=Vampiric Batling", "=ds=#e13#", "#ACHIEVEMENTID:2456#, =q1="..ALIL["Karazhan"]};
				{ 17, 44819, "", "=q1=Baby Blizzard Bear", "=ds=#e13#", "#ACHIEVEMENTID:2398#"};
				{ 18, 49362, "", "=q1=Onyxian Whelpling", "=ds=#e13#", "#ACHIEVEMENTID:4400#"};
			};
		};
		info = {
			name = AL["Unobtainable Companions"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsPetStore"] = {
		["Normal"] = {
			{
				{ 2, 106240, "", "=q3=Alterac Brandy", "=ds=#e13#"};
				{ 3, 98550, "", "=q3=Blossoming Ancient", "=ds=#e13#"};
				{ 4, 70099, "", "=q3=Cenarion Hatchling", "=ds=#e13#"};
				{ 5, 92707, "", "=q3=Cinder Kitten", "=ds=#e13#"};
				{ 6, 49662, "", "=q3=Gryphon Hatchling", "=ds=#e13#"};
				{ 7, 72068, "", "=q3=Guardian Cub", "=ds=#e13#"};
				{ 8, 49693, "", "=q3=Lil' Phylactery", "=ds=#e13#"};
				{ 17, 68385, "", "=q3=Lil' Ragnaros", "=ds=#e13#"};
				{ 18, 54847, "", "=q3=Lil' XT", "=ds=#e13#"};
				{ 19, 108438, "", "=q3=Moonkin Hatchling", "=ds=#e13#"};
				{ 20, 49665, "", "=q3=Pandaren Monk", "=ds=#e13#"};
				{ 21, 78916, "", "=q3=Soul of the Aspects", "=ds=#e13#"};
				{ 22, 49663, "", "=q3=Wind Rider Cub", "=ds=#e13#"};
			};
		};
		info = {
			name = AL["Blizzard Store"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsAccessories"] = {
		["Normal"] = {
			{
				{ 2, 92738, "", "=q3=Safari Hat", "=ds=#s1#", "#ACHIEVEMENTID:7499#"};
				{ 4, 47541, "", "=q3=Argent Pony Bridle", "=ds="};
				{ 5, 38291, "", "=q3=Ethereal Mutagen", "=ds="};
				{ 6, 35223, "", "=q3=Papa Hummel's Old-Fashioned Pet Biscuit", "=ds="};
				{ 7, 37431, "", "=q2=Fetch Ball", "=ds="};
				{ 8, 43626, "", "=q2=Happy Pet Snack", "=ds="};
				{ 9, 89906, "", "=q2=Magical Mini-Treat", "=ds="};
				{ 19, 71153, "", "=q2=Magical Pet Biscuit", "=ds="};
				{ 20, 43352, "", "=q2=Pet Grooming Kit", "=ds="};
				{ 21, 89139, "", "=q1=Chain Pet Leash", "=ds="};
				{ 22, 89222, "", "=q1=Cloud Ring", "=ds="};
				{ 23, 44820, "", "=q1=Red Ribbon Pet Leash", "=ds="};
				{ 24, 37460, "", "=q1=Rope Pet Leash", "=ds="};
			};
			{
				{ 1, 92742, "", "=q2=Polished Battle-Stone", "=ds=#e18#"};
				{ 2, 92689, "", "=q2=Polished Aquatic Battle-Stone", "=ds=#e18#"};
				{ 3, 92685, "", "=q2=Polished Beast Battle-Stone", "=ds=#e18#"};
				{ 4, 92686, "", "=q2=Polished Critter Battle-Stone", "=ds=#e18#"};
				{ 5, 92693, "", "=q2=Polished Dragonkin Battle-Stone", "=ds=#e18#"};
				{ 6, 92684, "", "=q2=Polished Elemental Battle-Stone", "=ds=#e18#"};
				{ 7, 92687, "", "=q2=Polished Flying Battle-Stone", "=ds=#e18#"};
				{ 8, 92692, "", "=q2=Polished Humanoid Battle-Stone", "=ds=#e18#"};
				{ 9, 92688, "", "=q2=Polished Magic Battle-Stone", "=ds=#e18#"};
				{ 10, 92690, "", "=q2=Polished Mechanical Battle-Stone", "=ds=#e18#"};
				{ 11, 92691, "", "=q2=Polished Undead Battle-Stone", "=ds=#e18#"};
				{ 16, 92741, "", "=q3=Flawless Battle-Stone", "=ds=#e18#"};
				{ 17, 92679, "", "=q3=Flawless Aquatic Battle-Stone", "=ds=#e18#"};
				{ 18, 92675, "", "=q3=Flawless Beast Battle-Stone", "=ds=#e18#"};
				{ 19, 92676, "", "=q3=Flawless Critter Battle-Stone", "=ds=#e18#"};
				{ 20, 92683, "", "=q3=Flawless Dragonkin Battle-Stone", "=ds=#e18#"};
				{ 21, 92665, "", "=q3=Flawless Elemental Battle-Stone", "=ds=#e18#"};
				{ 22, 92677, "", "=q3=Flawless Flying Battle-Stone", "=ds=#e18#"};
				{ 23, 92682, "", "=q3=Flawless Humanoid Battle-Stone", "=ds=#e18#"};
				{ 24, 92678, "", "=q3=Flawless Magic Battle-Stone", "=ds=#e18#"};
				{ 25, 92680, "", "=q3=Flawless Mechanical Battle-Stone", "=ds=#e18#"};
				{ 26, 92681, "", "=q3=Flawless Undead Battle-Stone", "=ds=#e18#"};
			};
		};
		info = {
			name = AL["Companion Accessories"],
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

	AtlasLoot_Data["PetsNEW"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Crafted Companions"], ""};
				{ 2, 94903, "", "=q3=Pierre", "=ds=#e13#", "=ds=#p5#" };
				{ 3, 100905, "", "=q3=Rascal-Bot", "=ds=#e13#", "=ds=#p5#" };
				{ 5, 0, "INV_Box_01", "=q6="..AL["Faction Companions"], ""};
				{ 6, 104295, "", "=q3=Harmonious Porcupette", "=ds=#e13#", "=ds=#TIMELESSCOIN:7500#"..ALIL["Emperor Shaohao"]};
				{ 8, 0, "INV_Box_01", "=q6="..AL["Merchant Sold Companions"], ""};
				{ 9, 102145, "", "=q3=Chi-Chi, Hatchling of Chi-Ji", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 10, 104332, "", "=q3=Sky Lantern", "=ds=#e13#", "=ds=#TIMELESSCOIN:7500#=q1="..ALIL["Timeless Isle"]};
				{ 11, 103637, "", "=q3=Vengeful Porcupette", "=ds=#e13#", "=ds=#BLOODYCOIN:100#=q1="..ALIL["Timeless Isle"]};
				{ 12, 101771, "", "=q3=Xu-Fu, Cub of Xuen", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 13, 102147, "", "=q3=Yu'la, Broodling of Yu'lon", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 14, 102146, "", "=q3=Zao, Calfling of Niuzao", "=ds=#e13#", "=ds=#ITEM:101529:3#=q1="..ALIL["Timeless Isle"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Quest Reward Companions"], ""};
				{ 17, 103670, "", "=q3=Lil' Bling", "=ds=#e13#", "=q1="..AL["Daily Reward"]..": #QUESTID:31752#"};
				{ 19, 0, "INV_Box_01", "=q6="..AL["Rare Companions"], ""};
				{ 20, 104156, "", "=q3=Ashleaf Spriteling", "=ds=#e13#", "=q2="..ALIL["Leafmender"]..", =q1="..ALIL["Timeless Isle"]};
				{ 21, 104157, "", "=q3=Azure Crane Chick", "=ds=#e13#", "=q2="..ALIL["Crane Nest"]..", =q1="..ALIL["Timeless Isle"]};
				{ 22, 104158, "", "=q3=Blackfuse Bombling", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Siegecrafter Blackfuse", 865)..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 23, 104202, "", "=q3=Bonkers", "=ds=#e13#", "=q2="..AL["Timeless Chest"]..", =q1="..ALIL["Timeless Isle"]};
				{ 24, 104160, "", "=q3=Dandelion Frolicker", "=ds=#e13#", "=q2="..AL["Scary Sprite"]..", =q1="..ALIL["Timeless Isle"]};
				{ 25, 104161, "", "=q3=Death Adder Hatchling", "=ds=#e13#", "=q2="..ALIL["Imperial Python"]..", =q1="..ALIL["Timeless Isle"]};
				{ 26, 104162, "", "=q3=Droplet of Y'Shaarj", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Sha of Pride", 867).." - "..AL["Flexible"].."/"..AL["Normal"].."/"..AL["Heroic"]..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 27, 104163, "", "=q3=Gooey Sha-ling", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Sha of Pride", 867).." - "..AL["Raid Finder"].."/"..AL["Flexible"]..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 28, 104169, "", "=q3=Gulp Froglet", "=ds=#e13#", "=q2="..ALIL["Bufo"]..", =q1="..ALIL["Timeless Isle"]};
				{ 29, 104307, "", "=q3=Jadefire Spirit", "=ds=#e13#", "=q2="..ALIL["Spirit of Jadefire"]..", =q1="..ALIL["Timeless Isle"]};
				{ 30, 104164, "", "=q3=Jademist Dancer", "=ds=#e13#", "=q2="..ALIL["Jademist Dancer"]..", =q1="..ALIL["Timeless Isle"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Blizzard Store"], ""};
				{ 2, 106240, "", "=q3=Alterac Brandy", "=ds=#e13#"};
				{ 4, 0, "INV_Box_01", "=q6="..AL["Promotional Companions"], ""};
				{ 5, 109014, "", "=q3=Dread Hatchling", "=ds=#e13#"};
				{ 6, 106244, "", "=q3=Murkalot's Flail", "=ds=#e13#", "#ACHIEVEMENTID:8793#"};
				{ 7, 106256, "", "=q3=Treasure Goblin's Pack", "=ds=#e13#", "#ACHIEVEMENTID:8795#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Rare Companions"], ""};
				{ 17, 104165, "", "=q3=Kovok", "=ds=#e13#", "=q2="..AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)..", =q1="..ALIL["Siege of Orgrimmar"]};
				{ 18, 104166, "", "=q3=Ominous Flame", "=ds=#e13#", "=q2="..ALIL["Foreboding Flame"]..", =q1="..ALIL["Timeless Isle"]};
				{ 19, 104159, "", "=q3=Ruby Droplet", "=ds=#e13#", "=q2="..ALIL["Garnia"]..", =q1="..ALIL["Timeless Isle"]};
				{ 20, 104167, "", "=q3=Skunky Alemental", "=ds=#e13#", "=q2="..ALIL["Zhu-Gon the Sour"]..", =q1="..ALIL["Timeless Isle"]};
				{ 21, 104168, "", "=q3=Spineclaw Crab", "=ds=#e13#", "=q2="..ALIL["Monstrous Spineclaw"]..", =q1="..ALIL["Timeless Isle"]};
				{ 22, 104291, "", "=q3=Swarmling of Gu'chi", "=ds=#e13#", "=q2="..ALIL["Gu'chi the Swarmbringer"]..", =q1="..ALIL["Timeless Isle"]};
				{ 24, 0, "INV_Box_01", "=q6="..AL["World Events"], ""};
				{ 25, 101570, "", "=q3=Moon Moon", "=ds=#e13#", "=q2="..AL["Drop"]..": "..AL["Moonfang"]..", =q1="..AL["Darkmoon Island"]};
				{ 26, 104317, "", "=q3=Rotten Helper Box", "=ds=#e13#", "=ds="..AL["Feast of Winter Veil"]};
			};
		};
		info = {
			name = AL["New Companions"].." - Patch 5.4",
			module = moduleName, menu = "PETMENU", instance = "Pets",
		};
	}

		--------------
		--- Mounts ---
		--------------

	AtlasLoot_Data["MountsAlliance"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_nightelf", "=q6="..ALIL["Darnassus"].." #j30#", "=ec1=#m7#"};
				{ 2, 18766, "", "=q4=Reins of the Swift Frostsaber", "=ds=#e26#"};
				{ 3, 18767, "", "=q4=Reins of the Swift Mistsaber", "=ds=#e26#"};
				{ 4, 18902, "", "=q4=Reins of the Swift Stormsaber", "=ds=#e26#"};
				{ 5, 8632, "", "=q3=Reins of the Spotted Frostsaber", "=ds=#e26#"};
				{ 6, 47100, "", "=q3=Reins of the Striped Dawnsaber", "=ds=#e26#"};
				{ 7, 8631, "", "=q3=Reins of the Striped Frostsaber", "=ds=#e26#"};
				{ 8, 8629, "", "=q3=Reins of the Striped Nightsaber", "=ds=#e26#"};
				{ 16, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..ALIL["Gnomeregan"].." #j30#", "=ec1=#m7#"};
				{ 17, 18772, "", "=q4=Swift Green Mechanostrider", "=ds=#e26#"};
				{ 18, 18773, "", "=q4=Swift White Mechanostrider", "=ds=#e26#"};
				{ 19, 18774, "", "=q4=Swift Yellow Mechanostrider", "=ds=#e26#"};
				{ 20, 8595, "", "=q3=Blue Mechanostrider", "=ds=#e26#"};
				{ 21, 13321, "", "=q3=Green Mechanostrider", "=ds=#e26#"};
				{ 22, 8563, "", "=q3=Red Mechanostrider", "=ds=#e26#"};
				{ 23, 13322, "", "=q3=Unpainted Mechanostrider", "=ds=#e26#"};
			};
			{
				{ 1, 0, "inv_misc_tournaments_symbol_dwarf", "=q6="..ALIL["Ironforge"].." #j30#", "=ec1=#m7#"};
				{ 2, 18786, "", "=q4=Swift Brown Ram", "=ds=#e26#"};
				{ 3, 18787, "", "=q4=Swift Gray Ram", "=ds=#e26#"};
				{ 4, 18785, "", "=q4=Swift White Ram", "=ds=#e26#"};
				{ 5, 5872, "", "=q3=Brown Ram", "=ds=#e26#"};
				{ 6, 5864, "", "=q3=Gray Ram", "=ds=#e26#"};
				{ 7, 5873, "", "=q3=White Ram", "=ds=#e26#"};
				{ 9, 0, "inv_misc_tournaments_symbol_draenei", "=q6="..ALIL["Exodar"].." #j30#", "=ec1=#m7#"};
				{ 10, 29745, "", "=q4=Great Blue Elekk", "=ds=#e26#"};
				{ 11, 29746, "", "=q4=Great Green Elekk", "=ds=#e26#"};
				{ 12, 29747, "", "=q4=Great Purple Elekk", "=ds=#e26#"};
				{ 13, 28481, "", "=q3=Brown Elekk", "=ds=#e26#"};
				{ 14, 29744, "", "=q3=Gray Elekk", "=ds=#e26#"};
				{ 15, 29743, "", "=q3=Purple Elekk", "=ds=#e26#"};
				{ 16, 0, "inv_misc_tournaments_symbol_human", "=q6="..ALIL["Stormwind"].." #j30#", "=ec1=#m7#"};
				{ 17, 18777, "", "=q4=Swift Brown Steed", "=ds=#e26#"};
				{ 18, 18776, "", "=q4=Swift Palomino", "=ds=#e26#"};
				{ 19, 18778, "", "=q4=Swift White Steed", "=ds=#e26#"};
				{ 20, 2411, "", "=q3=Black Stallion Bridle", "=ds=#e26#"};
				{ 21, 5656, "", "=q3=Brown Horse Bridle", "=ds=#e26#"};
				{ 22, 5655, "", "=q3=Chestnut Mare Bridle", "=ds=#e26#"};
				{ 23, 2414, "", "=q3=Pinto Bridle", "=ds=#e26#"};
			};
			{
				{ 1, 0, "inv_misc_tournaments_tabard_human", "=q6="..ALIL["Tushui Pandaren"].." #j30#"};
				{ 2, 87802, "", "=q4=Reins of the Great Black Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 3, 87803, "", "=q4=Reins of the Great Blue Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 4, 87804, "", "=q4=Reins of the Great Brown Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 5, 87801, "", "=q4=Reins of the Great Green Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 6, 87805, "", "=q4=Reins of the Great Purple Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 7, 82811, "", "=q4=Reins of the Great Red Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 8, 87795, "", "=q3=Reins of the Black Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 9, 87796, "", "=q3=Reins of the Blue Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 10, 87797, "", "=q3=Reins of the Brown Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 11, 82765, "", "=q3=Reins of the Green Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 12, 87799, "", "=q3=Reins of the Purple Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 13, 87800, "", "=q3=Reins of the Red Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 16, 0, "inv_misc_tabard_gilneas", "=q6="..ALIL["Gilneas"].." #j30#", "=ec1=#m7#"};
				{ 17, 73839, "", "=q4=Swift Mountain Horse", "=ds=#e26#"};
				{ 18, 73838, "", "=q3=Mountain Horse", "=ds=#e26#"};
			};
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6="..AL["Flying Mounts"], "=ec1=#m7#"};
				{ 2, 25473, "", "=q4=Swift Blue Gryphon", "=ds=#e27#"};
				{ 3, 25528, "", "=q4=Swift Green Gryphon", "=ds=#e27#"};
				{ 4, 25529, "", "=q4=Swift Purple Gryphon", "=ds=#e27#"};
				{ 5, 25527, "", "=q4=Swift Red Gryphon", "=ds=#e27#"};
				{ 6, 25471, "", "=q3=Ebon Gryphon", "=ds=#e27#"};
				{ 7, 25470, "", "=q3=Golden Gryphon", "=ds=#e27#"};
				{ 8, 25472, "", "=q3=Snowy Gryphon", "=ds=#e27#"};
				{ 16, 0, "INV_BannerPVP_02", "=q6="..ALIL["Kurenai"].." #j30#", "=ec1=#m7#"};
				{ 17, 29227, "", "=q4=Reins of the Cobalt War Talbuk", "=ds=#e26#"};
				{ 18, 29229, "", "=q4=Reins of the Silver War Talbuk", "=ds=#e26#"};
				{ 19, 29230, "", "=q4=Reins of the Tan War Talbuk", "=ds=#e26#"};
				{ 20, 29231, "", "=q4=Reins of the White War Talbuk", "=ds=#e26#"};
				{ 21, 31830, "", "=q4=Reins of the Cobalt Riding Talbuk", "=ds=#e26#"};
				{ 22, 31832, "", "=q4=Reins of the Silver Riding Talbuk", "=ds=#e26#"};
				{ 23, 31834, "", "=q4=Reins of the Tan Riding Talbuk", "=ds=#e26#"};
				{ 24, 31836, "", "=q4=Reins of the White Riding Talbuk", "=ds=#e26#"};
			};
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6="..ALIL["Baradin's Wardens"], "=ec1=#m7#"};
				{ 2, 64998, "", "=q4=Reins of the Spectral Steed", "=ds=#e12#"};
				{ 3, 63039, "", "=q4=Reins of the Drake of the West Wind", "=ds=#e27#"};
				{ 5, 0, "INV_BannerPVP_02", "=q6="..ALIL["Dalaran"], "=ec1=#m7#"};
				{ 6, 44225, "", "=q4=Reins of the Armored Brown Bear", "=ds=#e26#"};
				{ 7, 44230, "", "=q4=Reins of the Wooly Mammoth", "=ds=#e26#"};
				{ 8, 44235, "", "=q4=Reins of the Traveler's Tundra Mammoth", "=ds=#e26#"};
				{ 9, 44689, "", "=q4=Armored Snowy Gryphon", "=ds=#e27#"};
				{ 16, 0, "INV_BannerPVP_02", "=q6="..ALIL["Operation: Shieldwall"], "=ec1=#m7#"};
				{ 17, 93168, "", "=q4=Grand Armored Gryphon", "=ds=#e27#", "=ds=2,000 #gold#"};
				{ 19, 0, "INV_BannerPVP_02", "=q6="..ALIL["The Silver Covenant"].." #j30#", "=ec1=#m7#"};
				{ 20, 46815, "", "=q4=Quel'dorei Steed", "=ds=#e26#"};
				{ 21, 46813, "", "=q4=Silver Covenant Hippogryph", "=ds=#e27#"};
				{ 23, 0, "INV_BannerPVP_02", "=q6="..ALIL["Wintersaber Trainers"].." #j30#", "=ec1=#m7#"};
				{ 24, 13086, "", "=q4=Reins of the Winterspring Frostsaber", "=ds=#e26#"};
				{ 26, 0, "INV_BannerPVP_01", "=q6="..AL["Quest Reward"].." #j30#", "=ec1=#m7#"};
				{ 27, 93385, "", "=q4=Grand Gryphon", "=ds=#e27#, =ec1=#m7#", "=q1=#m4#: #QUESTID:32455#"};
			};
		};
		info = {
			name = AL["Alliance Mounts"],
			module = moduleName, menu = "MOUNTMENU",
		};
	}

	AtlasLoot_Data["MountsHorde"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Orgrimmar"].." #j30#", "=ec1=#m6#"};
				{ 2, 18796, "", "=q4=Horn of the Swift Brown Wolf", "=ds=#e26#"};
				{ 3, 18798, "", "=q4=Horn of the Swift Gray Wolf", "=ds=#e26#"};
				{ 4, 18797, "", "=q4=Horn of the Swift Timber Wolf", "=ds=#e26#"};
				{ 5, 46099, "", "=q3=Horn of the Black Wolf", "=ds=#e26#"};
				{ 6, 5668, "", "=q3=Horn of the Brown Wolf", "=ds=#e26#"};
				{ 7, 5665, "", "=q3=Horn of the Dire Wolf", "=ds=#e26#"};
				{ 8, 1132, "", "=q3=Horn of the Timber Wolf", "=ds=#e26#"};
				{ 16, 0, "inv_misc_tournaments_symbol_bloodelf", "=q6="..ALIL["Silvermoon City"].." #j30#", "=ec1=#m6#"};
				{ 17, 29223, "", "=q4=Swift Green Hawkstrider", "=ds=#e26#"};
				{ 18, 28936, "", "=q4=Swift Pink Hawkstrider", "=ds=#e26#"};
				{ 19, 29224, "", "=q4=Swift Purple Hawkstrider", "=ds=#e26#"};
				{ 20, 29221, "", "=q3=Black Hawkstrider", "=ds=#e26#"};
				{ 21, 29220, "", "=q3=Blue Hawkstrider", "=ds=#e26#"};
				{ 22, 29222, "", "=q3=Purple Hawkstrider", "=ds=#e26#"};
				{ 23, 28927, "", "=q3=Red Hawkstrider", "=ds=#e26#"};
			};
			{
				{ 1, 0, "inv_misc_tournaments_symbol_troll", "=q6="..ALIL["Darkspear Trolls"].." #j30#", "=ec1=#m6#"};
				{ 2, 18788, "", "=q4=Swift Blue Raptor", "=ds=#e26#"};
				{ 3, 18789, "", "=q4=Swift Olive Raptor", "=ds=#e26#"};
				{ 4, 18790, "", "=q4=Swift Orange Raptor", "=ds=#e26#"};
				{ 5, 8588, "", "=q3=Whistle of the Emerald Raptor", "=ds=#e26#"};
				{ 6, 8591, "", "=q3=Whistle of the Turquoise Raptor", "=ds=#e26#"};
				{ 7, 8592, "", "=q3=Whistle of the Violet Raptor", "=ds=#e26#"};
				{ 9, 0, "inv_misc_tournaments_symbol_tauren", "=q6="..ALIL["Thunder Bluff"].." #j30#", "=ec1=#m6#"};
				{ 10, 18794, "", "=q4=Great Brown Kodo", "=ds=#e26#"};
				{ 11, 18795, "", "=q4=Great Gray Kodo", "=ds=#e26#"};
				{ 12, 18793, "", "=q4=Great White Kodo", "=ds=#e26#"};
				{ 13, 15290, "", "=q3=Brown Kodo", "=ds=#e26#"};
				{ 14, 15277, "", "=q3=Gray Kodo", "=ds=#e26#"};
				{ 15, 46100, "", "=q3=White Kodo", "=ds=#e26#"};
				{ 16, 0, "inv_misc_tournaments_symbol_scourge", "=q6="..ALIL["Undercity"].." #j30#", "=ec1=#m6#"};
				{ 17, 13334, "", "=q4=Green Skeletal Warhorse", "=ds=#e26#"};
				{ 18, 47101, "", "=q4=Ochre Skeletal Warhorse", "=ds=#e26#"};
				{ 19, 18791, "", "=q4=Purple Skeletal Warhorse", "=ds=#e26#"};
				{ 20, 46308, "", "=q3=Black Skeletal Horse", "=ds=#e26#"};
				{ 21, 13332, "", "=q3=Blue Skeletal Horse", "=ds=#e26#"};
				{ 22, 13333, "", "=q3=Brown Skeletal Horse", "=ds=#e26#"};
				{ 23, 13331, "", "=q3=Red Skeletal Horse", "=ds=#e26#"};
			};
			{
				{ 1, 0, "inv_misc_tournaments_tabard_orc", "=q6="..ALIL["Huojin Pandaren"].." #j30#"};
				{ 2, 87802, "", "=q4=Reins of the Great Black Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 3, 87803, "", "=q4=Reins of the Great Blue Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 4, 87804, "", "=q4=Reins of the Great Brown Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 5, 87801, "", "=q4=Reins of the Great Green Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 6, 87805, "", "=q4=Reins of the Great Purple Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 7, 82811, "", "=q4=Reins of the Great Red Dragon Turtle", "=ds=#e26#", "=ds=10 #gold#"};
				{ 8, 87795, "", "=q3=Reins of the Black Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 9, 87796, "", "=q3=Reins of the Blue Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 10, 87797, "", "=q3=Reins of the Brown Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 11, 82765, "", "=q3=Reins of the Green Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 12, 87799, "", "=q3=Reins of the Purple Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 13, 87800, "", "=q3=Reins of the Red Dragon Turtle", "=ds=#e26#", "=ds=1 #gold#"};
				{ 16, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Bilgewater Cartel"].." #j30#", "=ec1=#m6#"};
				{ 17, 62462, "", "=q4=Goblin Turbo-Trike Key", "=ds=#e26#"};
				{ 18, 62461, "", "=q3=Goblin Trike Key", "=ds=#e26#"};
			};
			{
				{ 1, 0, "INV_BannerPVP_01", "=q6="..AL["Flying Mounts"], "=ec1=#m6#"};
				{ 2, 25531, "", "=q4=Swift Green Wind Rider", "=ds=#e27#"};
				{ 3, 25533, "", "=q4=Swift Purple Wind Rider", "=ds=#e27#"};
				{ 4, 25477, "", "=q4=Swift Red Wind Rider", "=ds=#e27#"};
				{ 5, 25532, "", "=q4=Swift Yellow Wind Rider", "=ds=#e27#"};
				{ 6, 25475, "", "=q3=Blue Wind Rider", "=ds=#e27#"};
				{ 7, 25476, "", "=q3=Green Wind Rider", "=ds=#e27#"};
				{ 8, 25474, "", "=q3=Tawny Wind Rider", "=ds=#e27#"};
				{ 16, 0, "INV_BannerPVP_01", "=q6="..ALIL["The Mag'har"].." #j30#", "=ec1=#m6#"};
				{ 17, 29102, "", "=q4=Reins of the Cobalt War Talbuk", "=ds=#e26#"};
				{ 18, 29104, "", "=q4=Reins of the Silver War Talbuk", "=ds=#e26#"};
				{ 19, 29105, "", "=q4=Reins of the Tan War Talbuk", "=ds=#e26#"};
				{ 20, 29103, "", "=q4=Reins of the White War Talbuk", "=ds=#e26#"};
				{ 21, 31829, "", "=q4=Reins of the Cobalt Riding Talbuk", "=ds=#e26#"};
				{ 22, 31831, "", "=q4=Reins of the Silver Riding Talbuk", "=ds=#e26#"};
				{ 23, 31833, "", "=q4=Reins of the Tan Riding Talbuk", "=ds=#e26#"};
				{ 24, 31835, "", "=q4=Reins of the White Riding Talbuk", "=ds=#e26#"};
			};
			{
				{ 1, 0, "INV_BannerPVP_01", "=q6="..ALIL["Hellscream's Reach"], "=ec1=#m6#"};
				{ 2, 64999, "", "=q4=Reins of the Spectral Wolf", "=ds=#e12#"};
				{ 3, 65356, "", "=q4=Reins of the Drake of the West Wind", "=ds=#e27#"};
				{ 5, 0, "INV_BannerPVP_01", "=q6="..ALIL["Dalaran"], "=ec1=#m6#"};
				{ 6, 44226, "", "=q4=Reins of the Armored Brown Bear", "=ds=#e26#"};
				{ 7, 44231, "", "=q4=Reins of the Wooly Mammoth", "=ds=#e26#"};
				{ 8, 44234, "", "=q4=Reins of the Traveler's Tundra Mammoth", "=ds=#e26#"};
				{ 9, 44690, "", "=q4=Armored Blue Wind Rider", "=ds=#e27#"};
				{ 16, 0, "INV_BannerPVP_02", "=q6="..ALIL["Dominance Offensive"], "=ec1=#m7#"};
				{ 17, 93169, "", "=q4=Grand Armored Wyvern", "=ds=#e27#", "=ds=2,000 #gold#"};
				{ 19, 0, "INV_BannerPVP_01", "=q6="..ALIL["The Sunreavers"].." #j30#", "=ec1=#m6#"};
				{ 20, 46816, "", "=q4=Sunreaver Hawkstrider", "=ds=#e26#"};
				{ 21, 46814, "", "=q4=Sunreaver Dragonhawk", "=ds=#e27#"};
				{ 23, 0, "INV_BannerPVP_01", "=q6="..AL["Quest Reward"].." #j30#", "=ec1=#m6#"};
				{ 24, 93386, "", "=q4=Grand Wyvern", "=ds=#e27#", "=q1=#m4#: #QUESTID:32399#"};
				{ 25, 46102, "", "=q4=Whistle of the Venomhide Ravasaur", "=ds=#e26#"};
			};
		};
		info = {
			name = AL["Horde Mounts"],
			module = moduleName, menu = "MOUNTMENU",
		};
	}

	AtlasLoot_Data["MountsFaction"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..ALIL["Order of the Cloud Serpent"].." #j30#"};
				{ 2, 85430, "", "=q4=Reins of the Azure Cloud Serpent", "=ds=#e27#", "=ds=3,000 #gold#"};
				{ 3, 85429, "", "=q4=Reins of the Golden Cloud Serpent", "=ds=#e27#", "=ds=3,000 #gold#"};
				{ 4, 79802, "", "=q4=Reins of the Jade Cloud Serpent", "=ds=#e27#", "=ds=3,000 #gold#"};
				{ 6, 0, "INV_Box_01", "=q6="..ALIL["The August Celestials"].." #j30#"};
				{ 7, 89304, "", "=q4=Reins of the Thundering August Cloud Serpent", "=ds=#e27#", "=ds=10,000 #gold#"};
				{ 9, 0, "INV_Box_01", "=q6="..ALIL["The Lorewalkers"].." #j30#"};
				{ 10, 89363, "", "=q3=Disc of the Red Flying Cloud", "=ds=#e27#", "=ds=600 #gold#"};
				{ 12, 0, "INV_Box_01", "=q6="..ALIL["Golden Lotus"].." #j30#"};
				{ 13, 87781, "", "=q4=Reins of the Azure Riding Crane", "=ds=#e26#", "=ds=500 #gold#"};
				{ 14, 87782, "", "=q4=Reins of the Golden Riding Crane", "=ds=#e26#", "=ds=2,500 #gold#"};
				{ 15, 87783, "", "=q4=Reins of the Regal Riding Crane", "=ds=#e26#", "=ds=1,500 #gold#"};
				{ 16, 0, "INV_Box_01", "=q6="..ALIL["The Klaxxi"].." #j30#"};
				{ 17, 85262, "", "=q4=Reins of the Amber Scorpion", "=ds=#e26#", "=ds=10,000 #gold#"};
				{ 19, 0, "INV_Box_01", "=q6="..ALIL["The Anglers"].." #j30#"};
				{ 20, 81354, "", "=q4=Reins of the Azure Water Strider", "=ds=#e26#", "=ds=5,000 #gold#"};
				{ 22, 0, "INV_Box_01", "=q6="..ALIL["Shado-Pan"].." #j30#"};
				{ 23, 89307, "", "=q4=Reins of the Blue Shado-Pan Riding Tiger", "=ds=#e26#", "=ds=500 #gold#"};
				{ 24, 89305, "", "=q4=Reins of the Green Shado-Pan Riding Tiger", "=ds=#e26#", "=ds=1,500 #gold#"};
				{ 25, 89306, "", "=q4=Reins of the Red Shado-Pan Riding Tiger", "=ds=#e26#", "=ds=2,500 #gold#"};
				{ 27, 0, "INV_Box_01", "=q6="..ALIL["Emperor Shaohao"].." #j30#"};
				{ 28, 87774, "", "=q4=Reins of the Heavenly Golden Cloud Serpent", "=ds=#e27#", "#TIMELESSCOIN:100000#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..ALIL["The Tillers"].." #j30#"};
				{ 2, 89391, "", "=q4=Reins of the Black Riding Goat", "=ds=#e26#", "=ds=1,416 #gold# 66 #silver# 66 #copper#"};
				{ 3, 89362, "", "=q4=Reins of the Brown Riding Goat", "=ds=#e26#", "=ds=472 #gold# 22 #silver# 22 #copper#"};
				{ 4, 89390, "", "=q4=Reins of the White Riding Goat", "=ds=#e26#", "=ds=3069 #gold# 44 #silver# 44 #copper#"};
				{ 6, 0, "INV_Box_01", "=q6="..AL["Vendor"]};
				{ 7, 84101, "", "=q4=Reins of the Grand Expedition Yak", "=q2="..AL["Uncle Bigpocket"]..", =q1="..ALIL["Kun-Lai Summit"], "=ds=120,000 #gold#"};
				{ 8, 87789, "", "=q4=Reins of the Blonde Riding Yak", "=q2="..AL["Uncle Bigpocket"]..", =q1="..ALIL["Kun-Lai Summit"], "=ds=3,000 #gold#"};
				{ 9, 87788, "", "=q4=Reins of the Grey Riding Yak", "=q2="..AL["Uncle Bigpocket"]..", =q1="..ALIL["Kun-Lai Summit"], "=ds=3,000 #gold#"};
				{ 11, 0, "INV_Box_01", "=q6="..ALIL["Ramkahen"].." #j30#", "=q1="..ALIL["Uldum"]};
				{ 12, 63044, "", "=q4=Reins of the Brown Riding Camel", "=ds=#e26#", "=ds=100 #gold#"};
				{ 13, 63045, "", "=q4=Reins of the Tan Riding Camel", "=ds=#e26#", "=ds=100 #gold#"};
				{ 16, 0, "INV_Box_01", "=q6="..ALIL["The Sons of Hodir"].." #j30#", "=q1="..ALIL["The Storm Peaks"]};
				{
					{ 17, 44080, "", "=q4=Reins of the Ice Mammoth", "=ds=#e26#", "=ds=1,000 #gold#"};
					{ 17, 43958, "", "=q4=Reins of the Ice Mammoth", "=ds=#e26#", "=ds=1,000 #gold#"};
				};
				{
					{ 18, 44086, "", "=q4=Reins of the Grand Ice Mammoth", "=ds=#e26#", "=ds=10,00 #gold#"};
					{ 18, 43961, "", "=q4=Reins of the Grand Ice Mammoth", "=ds=#e26#", "=ds=10,00 #gold#"};
				};
				{ 20, 0, "INV_Box_01", "=q6="..ALIL["The Wyrmrest Accord"].." #j30#", "=q1="..ALIL["Dragonblight"]};
				{ 21, 43955, "", "=q4=Reins of the Red Drake", "=ds=#e27#", "=ds=2,000 #gold#"};
				{ 23, 0, "INV_Box_01", "=q6="..ALIL["The Oracles"].." #j30#", "=q1="..ALIL["Sholazar Basin"]};
				{ 24, 44707, "", "=q4=Reins of the Green Proto-Drake", "=ds=#e27#", "=q2="..ALIL["Mysterious Egg"], ""};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..ALIL["Netherwing"].." #j30#", "=q1="..ALIL["Shadowmoon Valley"]};
				{ 2, 32858, "", "=q4=Reins of the Azure Netherwing Drake", "=ds=#e27#", "=ds=200 #gold#"};
				{ 3, 32859, "", "=q4=Reins of the Cobalt Netherwing Drake", "=ds=#e27#", "=ds=200 #gold#"};
				{ 4, 32857, "", "=q4=Reins of the Onyx Netherwing Drake", "=ds=#e27#", "=ds=200 #gold#"};
				{ 5, 32860, "", "=q4=Reins of the Purple Netherwing Drake", "=ds=#e27#", "=ds=200 #gold#"};
				{ 6, 32861, "", "=q4=Reins of the Veridian Netherwing Drake", "=ds=#e27#", "=ds=200 #gold#"};
				{ 7, 32862, "", "=q4=Reins of the Violet Netherwing Drake", "=ds=#e27#", "=ds=200 #gold#"};
				{ 9, 0, "INV_Box_01", "=q6="..ALIL["Cenarion Expedition"].." #j30#", "=q1="..ALIL["Zangarmarsh"]};
				{ 10, 33999, "", "=q4=Cenarion War Hippogryph", "=ds=#e27#", "=ds=2,000 #gold#"};
				{ 16, 0, "INV_Box_01", "=q6="..ALIL["Sha'tari Skyguard"].." #j30#", "=q1="..ALIL["Terokkar Forest"]};
				{ 17, 32319, "", "=q4=Blue Riding Nether Ray", "=ds=#e27#", "=ds=200 #gold#"};
				{ 18, 32314, "", "=q4=Green Riding Nether Ray", "=ds=#e27#", "=ds=200 #gold#"};
				{ 19, 32317, "", "=q4=Red Riding Nether Ray", "=ds=#e27#", "=ds=200 #gold#"};
				{ 20, 32316, "", "=q4=Purple Riding Nether Ray", "=ds=#e27#", "=ds=200 #gold#"};
				{ 21, 32318, "", "=q4=Silver Riding Nether Ray", "=ds=#e27#", "=ds=200 #gold#"};
			};
		};
		info = {
			name = AL["Neutral Faction Mounts"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsPvP"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Alliance PvP Mounts"], ""};
				{ 2, 29465, "", "=q4=Black Battlestrider", "=ds=#e26# =ec1=#m7#"};
				{ 3, 29467, "", "=q4=Black War Ram", "=ds=#e26# =ec1=#m7#"};
				{ 4, 29468, "", "=q4=Black War Steed Bridle", "=ds=#e26# =ec1=#m7#"};
				{ 5, 35906, "", "=q4=Reins of the Black War Elekk", "=ds=#e26# =ec1=#m7#"};
				{ 6, 29471, "", "=q4=Reins of the Black War Tiger", "=ds=#e26# =ec1=#m7#"};
				{ 7, 19030, "", "=q4=Stormpike Battle Charger", "=ds=#e26# =ec1=#m7#"};
				{ 8, 43956, "", "=q4=Reins of the Black War Mammoth", "=ds=#e26# =ec1=#m7#"};
				{ 12, 0, "INV_Box_01", "=q6="..AL["Halaa PvP Mounts"], "=q1="..ALIL["Nagrand"]};
				{ 13, 28915, "", "=q4=Reins of the Dark Riding Talbuk", "=ds=#e26#"};
				{ 14, 29228, "", "=q4=Reins of the Dark War Talbuk", "=ds=#e26#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Horde PvP Mounts"], ""};
				{ 17, 29466, "", "=q4=Black War Kodo", "=ds=#e26# =ec1=#m6#"};
				{ 18, 29469, "", "=q4=Horn of the Black War Wolf", "=ds=#e26# =ec1=#m6#"};
				{ 19, 29470, "", "=q4=Red Skeletal Warhorse", "=ds=#e26# =ec1=#m6#"};
				{ 20, 34129, "", "=q4=Swift Warstrider", "=ds=#e26# =ec1=#m6#"};
				{ 21, 29472, "", "=q4=Whistle of the Black War Raptor", "=ds=#e26# =ec1=#m6#"};
				{ 22, 19029, "", "=q4=Horn of the Frostwolf Howler", "=ds=#e26# =ec1=#m6#"};
				{ 23, 44077, "", "=q4=Reins of the Black War Mammoth", "=ds=#e26# =ec1=#m6#"};
				{ 27, 0, "INV_Box_01", "=q6="..ALIL["Timeless Isle"], ""};
				{ 28, 103638, "", "=q4=Reins of the Ashhide Mushan Beast", "=ds=#e26#", "#BLOODYCOIN:500#"};
			};
		};
		info = {
			name = AL["PvP Mounts"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsRareDungeon"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Dungeon"], ""};
				{ 2, 69747, "", "=q4=Amani Battle Bear", "=q2="..AL["Timed Reward Chest"]..", =q1="..ALIL["Zul'Aman"]};
				{ 3, 68823, "", "=q4=Armored Razzashi Raptor", "=q2="..AtlasLoot:EJ_GetBossName("Bloodlord Mandokir", 176)..", =q1="..ALIL["Zul'Gurub"]};
				{ 4, 13335, "", "=q4=Deathcharger's Reins", "#ACHIEVEMENTID:729#", "", "0.10%"};
				{ 5, 44151, "", "=q4=Reins of the Blue Proto-Drake", "=q2="..AtlasLoot:EJ_GetBossName("Skadi the Ruthless", 643)..", =q1="..AL["Heroic"].." "..ALIL["Utgarde Pinnacle"], ""};
				{ 6, 43951, "", "=q4=Reins of the Bronze Drake", "#ACHIEVEMENTID:1817#"};
				{ 7, 63040, "", "=q4=Reins of the Drake of the North Wind", "=q2="..AtlasLoot:EJ_GetBossName("Altairus", 115)..", =q1="..ALIL["The Vortex Pinnacle"]};
				{ 8, 32768, "", "=q4=Reins of the Raven Lord", "#ACHIEVEMENTID:883#"};
				{ 9, 63043, "", "=q4=Reins of the Vitreous Stone Drake", "=q2="..AtlasLoot:EJ_GetBossName("Slabhide", 111)..", =q1="..ALIL["The Stonecore"]};
				{ 10, 35513, "", "=q4=Swift White Hawkstrider", "#ACHIEVEMENTID:884#"};
				{ 11, 68824, "", "=q4=Swift Zulian Panther", "=q2="..AtlasLoot:EJ_GetBossName("High Priestess Kilnara", 181)..", =q1="..ALIL["Zul'Gurub"]};
				{ 13, 0, "INV_Box_01", "=q6="..AL["Outdoor"], ""};
				{ 14, 67151, "", "=q4=Reins of Poseidus", "=q2="..BabbleRare["Poseidus"]..", =q1="..ALIL["Vashj'ir"]};
				{ 15, 94230, "", "=q4=Reins of the Amber Primordial Direhorn", "=q2="..BabbleRare["Zandalari Warbringer"]..", =q1="..ALIL["Pandaria"]};
				{ 16, 94292, "", "=q4=Reins of the Black Primal Raptor", "=q1="..ALIL["Isle of Giants"]};
				{ 17, 94228, "", "=q4=Reins of the Cobalt Primordial Direhorn", "=q2="..AtlasLoot:EJ_GetBossName("Oondasta", 826)..", =q1="..ALIL["Isle of Giants"], ""},
				{ 18, 94293, "", "=q4=Reins of the Green Primal Raptor", "=q1="..ALIL["Isle of Giants"]};
				{ 19, 63046, "", "=q4=Reins of the Grey Riding Camel", "#ACHIEVEMENTID:5767#", ""};
				{ 20, 87771, "", "=q4=Reins of the Heavenly Onyx Cloud Serpent", "=q2="..AtlasLoot:EJ_GetBossName("Sha of Anger", 691)..", =q1="..ALIL["Kun-Lai Summit"], ""};
				{ 21, 94231, "", "=q4=Reins of the Jade Primordial Direhorn", "=q2="..BabbleRare["Zandalari Warbringer"]..", =q1="..ALIL["Pandaria"]};
				{ 22, 63042, "", "=q4=Reins of the Phosphorescent Stone Drake", "=q2="..BabbleRare["Aeonaxx"]..", =q1="..ALIL["Deepholm"]};
				{ 23, 94291, "", "=q4=Reins of the Red Primal Raptor", "=q1="..ALIL["Isle of Giants"]};
				{ 24, 94229, "", "=q4=Reins of the Slate Primordial Direhorn", "=q2="..BabbleRare["Zandalari Warbringer"]..", =q1="..ALIL["Pandaria"]};
				{ 25, 95057, "", "=q4=Reins of the Thundering Cobalt Cloud Serpent", "=q2="..AtlasLoot:EJ_GetBossName("Nalak, The Storm Lord", 814)..", =q1="..ALIL["Isle of Thunder"], ""},
				{ 26, 104269, "", "=q4=Reins of the Thundering Onyx Cloud Serpent", "=q2="..ALIL["Huolon"]..", =q1="..ALIL["Timeless Isle"] };
				{ 27, 90655, "", "=q4=Reins of the Thundering Ruby Cloud Serpent", "=ds=#e27#", "=q2="..BabbleRare["Alani"]..", =q1="..ALIL["Vale of Eternal Blossoms"]};
				{ 28, 44168, "", "=q4=Reins of the Time-Lost Proto-Drake", "=q2="..BabbleRare["Time-Lost Proto Drake"]..", =q1="..ALIL["The Storm Peaks"]};
				{ 29, 89783, "", "=q4=Son of Galleon's Saddle", "=q2="..AtlasLoot:EJ_GetBossName("Salyis's Warband", 725)..", =q1="..ALIL["Valley of the Four Winds"], ""};
				{ 30, 46109, "", "=q3=Sea Turtle", "#ACHIEVEMENTID:3218#", ""};
			};
		};
		info = {
			name = AL["Rare Mounts"]..": "..AL["Dungeon"].." / "..AL["Outdoor"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsRareRaid"] = {
		["Normal"] = {
			{
				{ 1, 32458, "", "=q4=Ashes of Al'ar", "#ACHIEVEMENTID:885#"};
				{ 2, 95059, "", "=q4=Clutch of Ji-Kun", "=q2="..AtlasLoot:EJ_GetBossName("Ji-Kun", 828)..", =q1="..ALIL["Throne of Thunder"]};
				{ 3, 78919, "", "=q4=Experiment 12-B", "=q2="..AtlasLoot:EJ_GetBossName("Ultraxion", 331)..", =q1="..ALIL["Dragon Soul"]},
				{ 4, 30480, "", "=q4=Fiery Warhorse's Reins", "#ACHIEVEMENTID:882#", "", "0.25%"};
				{ 5, 71665, "", "=q4=Flametalon of Alysrazor", "=q2="..AtlasLoot:EJ_GetBossName("Alysrazor", 194)..", =q1="..ALIL["Firelands"]},
				{ 6, 50818, "", "=q4=Invincible's Reins", "#ACHIEVEMENTID:4584#"};
				{ 7, 104253, "", "=q4=Kor'kron Juggernaut", "=ds=#e26#", "=q2="..AtlasLoot:EJ_GetBossName("Garrosh Hellscream", 869).." - "..AL["Heroic"]..", =q1="..ALIL["Siege of Orgrimmar"] },
				{ 8, 77069, "", "=q4=Life-Binder's Handmaiden", "=q2="..AtlasLoot:EJ_GetBossName("Madness of Deathwing", 333)..", =q1="..ALIL["Dragon Soul"]},
				{ 9, 45693, "", "=q4=Mimiron's Head", "#ACHIEVEMENTID:4626#, =q1="..ALIL["Ulduar"], "", ""};
				{ 10, 87777, "", "=q4=Reins of the Astral Cloud Serpent", "=ds=#e27#", "=q2="..AtlasLoot:EJ_GetBossName("Elegon", 726)..", =q1="..ALIL["Mogu'shan Vaults"], ""};
				{ 11, 43986, "", "=q4=Reins of the Black Drake", "#ACHIEVEMENTID:2051#, =q1="..ALIL["The Obsidian Sanctum"], "100%"};
				{ 12, 77067, "", "=q4=Reins of the Blazing Drake", "=q2="..AtlasLoot:EJ_GetBossName("Madness of Deathwing", 333)..", =q1="..ALIL["Dragon Soul"]},
				{ 13, 43954, "", "=q4=Reins of the Twilight Drake", "#ACHIEVEMENTID:2054#, =q1="..ALIL["The Obsidian Sanctum"], "100%"};
				{ 14, 43953, "", "=q4=Reins of the Blue Drake", "=q2="..BabbleBoss["Malygos"]..", =q1="..ALIL["The Eye of Eternity"], ""};
				{ 15, 43952, "", "=q4=Reins of the Azure Drake", "=q2="..BabbleBoss["Malygos"]..", =q1="..ALIL["The Eye of Eternity"], ""};
				{ 16, 63041, "", "=q4=Reins of the Drake of the South Wind", "=q2="..AtlasLoot:EJ_GetBossName("Al'Akir", 155)..", =q1="..ALIL["Throne of the Four Winds"]};
				{
					{ 17, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=q1="..ALIL["Vault of Archavon"]..", =ec1=#m6#", "", ""};
					{ 17, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=q1="..ALIL["Vault of Archavon"]..", =ec1=#m7#", "", ""};
				};
				{ 18, 49636, "", "=q4=Reins of the Onyxian Drake", "=q2="..BabbleBoss["Onyxia"]..", =q1="..ALIL["Onyxia's Lair"], ""};
				{ 19, 69224, "", "=q4=Smoldering Egg of Millagazor", "=q2="..BabbleBoss["Ragnaros"]..", =q1="..ALIL["Firelands"]},
				{ 20, 93666, "", "=q4=Spawn of Horridon", "=q2="..AtlasLoot:EJ_GetBossName("Horridon", 819)..", =q1="..ALIL["Throne of Thunder"]};
				{ 22, 21218, "", "=q3=Blue Qiraji Resonating Crystal", "=q2="..AL["Trash Mobs"]..", =q1="..ALIL["Temple of Ahn'Qiraj"], "", "10.91%"};
				{ 23, 21323, "", "=q3=Green Qiraji Resonating Crystal", "=q2="..AL["Trash Mobs"]..", =q1="..ALIL["Temple of Ahn'Qiraj"], "", "11.77%"};
				{ 24, 21321, "", "=q3=Red Qiraji Resonating Crystal", "=q2="..AL["Trash Mobs"]..", =q1="..ALIL["Temple of Ahn'Qiraj"], "", "1.32%"};
				{ 25, 21324, "", "=q3=Yellow Qiraji Resonating Crystal", "=q2="..AL["Trash Mobs"]..", =q1="..ALIL["Temple of Ahn'Qiraj"], "", "12.64%"};
			};
		};
		info = {
			name = AL["Rare Mounts"]..": "..AL["Raid"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsAchievement"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Dungeon"], ""};
				{ 2, 90710, "", "=q4=Reins of the Ashen Pandaren Phoenix", "#ACHIEVEMENTID:6375#"};
				{ 3, 87769, "", "=q4=Reins of the Crimson Cloud Serpent", "#ACHIEVEMENTID:6927#"};
				{ 4, 89154, "", "=q4=Reins of the Crimson Pandaren Phoenix", "#ACHIEVEMENTID:6375#"};
				{ 5, 90711, "", "=q4=Reins of the Emerald Pandaren Phoenix", "#ACHIEVEMENTID:6375#"};
				{ 6, 44160, "", "=q4=Reins of the Red Proto-Drake", "#ACHIEVEMENTID:2136#"};
				{ 7, 90712, "", "=q4=Reins of the Violet Pandaren Phoenix", "#ACHIEVEMENTID:6375#"};
				{ 8, 62900, "", "=q4=Reins of the Volcanic Stone Drake", "#ACHIEVEMENTID:4845#"};
				{ 10, 0, "INV_Box_01", "=q6="..AL["Misc"], ""};
				{ 11, 69213, "", "=q4=Flameward Hippogryph", "#ACHIEVEMENTID:5866#"};
				{ 12, 89785, "", "=q4=Pandaren Kite String", "#ACHIEVEMENTID:6828#"};
				{ 13, 62298, "", "=q4=Reins of the Golden King", "#ACHIEVEMENTID:4912#, =ec1=#m7#"};
				{ 14, 67107, "", "=q4=Reins of the Kor'kron Annihilator", "#ACHIEVEMENTID:5492#, =ec1=#m6#"};
				{ 15, 44177, "", "=q4=Reins of the Violet Proto-Drake", "#ACHIEVEMENTID:2144#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Raid"], ""};
				{ 17, 69230, "", "=q4=Corrupted Egg of Millagazor", "#ACHIEVEMENTID:5828#" };
				{ 18, 104208, "", "=q4=Reins of Galakras", "#ACHIEVEMENTID:8454#"};
				{ 19, 93662, "", "=q4=Reins of the Armored Skyscreamer", "#ACHIEVEMENTID:8124#"};
				{ 20, 51954, "", "=q4=Reins of the Bloodbathed Frostbrood Vanquisher", "#ACHIEVEMENTID:4602#"};
				{ 21, 63125, "", "=q4=Reins of the Dark Phoenix", "#ACHIEVEMENTID:4988#"};
				{ 22, 62901, "", "=q4=Reins of the Drake of the East Wind", "#ACHIEVEMENTID:4853#"};
				{ 23, 87773, "", "=q4=Reins of the Heavenly Crimson Cloud Serpent", "#ACHIEVEMENTID:6932#"};
				{ 24, 51955, "", "=q4=Reins of the Icebound Frostbrood Vanquisher", "#ACHIEVEMENTID:4603#"};
				{ 25, 45801, "", "=q4=Reins of the Ironbound Proto-Drake", "#ACHIEVEMENTID:2958#"};
				{ 26, 104246, "", "=q4=Reins of the Kor'kron War Wolf", "#ACHIEVEMENTID:8398#"};
				{ 27, 45802, "", "=q4=Reins of the Rusted Proto-Drake", "#ACHIEVEMENTID:2957#"};
				{ 28, 85666, "", "=q4=Reins of the Thundering Jade Cloud Serpent", "#ACHIEVEMENTID:6682#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Mount Collecting"], ""};
				{ 2, 44178, "", "=q4=Reins of the Albino Drake", "#ACHIEVEMENTID:2143#"};
				{ 3, 44843, "", "=q4=Blue Dragonhawk", "#ACHIEVEMENTID:2536#, =ec1=#m7#"};
				{ 4, 44842, "", "=q4=Red Dragonhawk", "#ACHIEVEMENTID:2537#, =ec1=#m6#"};
				{
					{ 5, 91802, "", "=q4=Jade Pandaren Kite String", "#ACHIEVEMENTID:7862#, =ec1=#m6#"};
					{ 5, 91802, "", "=q4=Jade Pandaren Kite String", "#ACHIEVEMENTID:7860#, =ec1=#m7#"};
				};
				{ 6, 98259, "", "=q4=Armored Blue Dragonhawk", "#ACHIEVEMENTID:8304#, =ec1=#m7#"};
				{ 7, 98104, "", "=q4=Armored Red Dragonhawk", "#ACHIEVEMENTID:8302#, =ec1=#m6#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["PvP"], ""};
				{ 17, 44223, "", "=q4=Reins of the Black War Bear", "#ACHIEVEMENTID:614#, =ec1=#m7#"};
				{ 18, 44224, "", "=q4=Reins of the Black War Bear", "#ACHIEVEMENTID:619#, =ec1=#m6#"};
				{ 19, 70909, "", "=q4=Reins of the Vicious War Steed", "#ACHIEVEMENTID:5823#, =ec1=#m7#"};
				{ 20, 70910, "", "=q4=Horn of the Vicious War Wolf", "#ACHIEVEMENTID:5824#, =ec1=#m6#"};
				{ 21, 102514, "", "=q4=Reins of the Vicious Warsaber", "#ACHIEVEMENTID:8485#, =ec1=#m7#"};
				{ 22, 102533, "", "=q4=Reins of the Vicious Skeletal Warhorse", "#ACHIEVEMENTID:8484#, =ec1=#m6#"};
			};
		};
		info = {
			name = AL["Achievement Reward"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsCraftQuest"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Crafted Mounts"], ""};
				{ 2, 65891, "", "=q4=Vial of the Sands", "=ds=#e27# =q2=#p1#"};
				{ 3, 60954, "", "=q4=Fossilized Raptor", "=ds=#e26# =q2=#p25#"};
				{ 4, 64883, "", "=q4=Scepter of Azj'Aqir", "=ds=#e26# =q2=#p25#"};
				{ 5, 44413, "", "=q4=Mekgineer's Chopper", "=ds=#e26# =q2=#p5# =ec1=#m7#"};
				{ 6, 41508, "", "=q4=Mechano-Hog", "=ds=#e26# =q2=#p5# =ec1=#m6#"};
				{ 7, 34061, "", "=q4=Turbo-Charged Flying Machine", "=ds=#e27# =q2=#p5#"};
				{ 8, 95416, "", "=q4=Sky Golem", "=ds=#e27# =q2=#p5#" };
				{ 9, 82453, "", "=q4=Jeweled Onyx Panther", "=ds=#e27# =q2=#p12#"};
				{ 10, 54797, "", "=q4=Frosty Flying Carpet", "=ds=#e27# =q2=#p8#"};
				{ 11, 44558, "", "=q4=Magnificent Flying Carpet", "=ds=#e27# =q2=#p8#"};
				{ 12, 87250, "", "=q3=Depleted-Kyparium Rocket", "=ds=#e27# =q2=#p5#"};
				{ 13, 87251, "", "=q3=Geosynchronous World Spinner", "=ds=#e27# =q2=#p5#"};
				{ 14, 34060, "", "=q3=Flying Machine", "=ds=#e27# =q2=#p5#"};
				{ 16, 83088, "", "=q3=Jade Panther", "=ds=#e27# =q2=#p12#"};
				{ 17, 83087, "", "=q3=Ruby Panther", "=ds=#e27# =q2=#p12#"};
				{ 18, 83090, "", "=q3=Sapphire Panther", "=ds=#e27# =q2=#p12#"};
				{ 19, 83089, "", "=q3=Sunstone Panther", "=ds=#e27# =q2=#p12#"};
				{ 20, 44554, "", "=q3=Flying Carpet", "=ds=#e27# =q2=#p8#"};
				{ 22, 0, "INV_Box_01", "=q6="..AL["Quest Reward"], ""};
				{ 23, 93385, "", "=q4=Grand Gryphon", "=ds=#e27#, =ec1=#m7#", "=q1=#m4#: #QUESTID:32455#"};
				{ 24, 93386, "", "=q4=Grand Wyvern", "=ds=#e27#, =ec1=#m6#", "=q1=#m4#: #QUESTID:32399#"};
				{ 25, 94290, "", "=q4=Reins of the Bone-White Primal Raptor", "=q1=#m4#: #QUESTID:32617#"};
				{ 26, 52200, "", "=q4=Reins of the Crimson Deathcharger", "=q1=#m4#: #QUESTID:24915#"};
				{ 27, 87768, "", "=q4=Reins of the Onyx Cloud Serpent", "=q1=#m4#: #QUESTID:31277#"};
				{ 28, 43962, "", "=q4=Reins of the White Polar Bear", "=q1=#m4#: "..ALIL["Hyldnir Spoils"], ""};
				{ 29, 54465, "", "=q3=Subdued Abyssal Seahorse", "=q1=#m4#: #QUESTID:25371#"};
			};
		};
		info = {
			name = AL["Quest Reward"].." / "..AL["Crafted Mounts"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsCardGame"] = {
		["Normal"] = {
			{
				{ 1, 68825, "", "=q4=Amani Dragonhawk", "=ds=#e27#", "=q1="..AL["Twilight of the Dragons"]},
				{ 2, 49282, "", "=q4=Big Battle Bear", "=ds=#e26#", "=q1="..AL["Drums of War"]};
				{ 3, 54069, "", "=q4=Blazing Hippogryph", "=ds=#e27#", "=q1="..AL["Wrathgate"]};
				{ 4, 72582, "", "=q4=Corrupted Hippogryph", "=ds=#e12#", "=q1="..AL["Crown of Heaven"]},
				{ 5, 79771, "", "=q4=Feldrake", "=ds=#e26#", "=q1="..AL["War of the Ancients"]},
				{ 6, 93671, "", "=q4=Ghastly Charger's Skull", "=ds=#12#", "=q1="..AL["Betrayal of the Guardian"]},
				{ 7, 49290, "", "=q4=Magic Rooster Egg", "=ds=#e26#", "=q1="..AL["Fields of Honor"]};
				{ 8, 68008, "", "=q4=Mottled Drake", "=ds=#e27#", "=q1="..AL["Worldbreaker"]};
				{ 9, 49284, "", "=q4=Reins of the Swift Spectral Tiger", "=ds=#e26#", "=q1="..AL["Fires of Outland"]};
				{ 16, 23720, "", "=q4=Riding Turtle", "=ds=#e26#", "=q1="..AL["Heroes of Azeroth"]};
				{ 17, 69228, "", "=q4=Savage Raptor", "=ds=#e26#", "=q1="..AL["War of the Elements"]},
				{ 18, 71718, "", "=q4=Swift Shorestrider", "=ds=#e26#", "=q1="..ALIL["Throne of the Tides"]},
				{ 19, 72575, "", "=q4=White Riding Camel", "=ds=#e26#", "=q1="..AL["Tomb of the Forgotten"]},
				{ 20, 54068, "", "=q4=Wooly White Rhino ", "=ds=#e26#", "=q1="..AL["Icecrown"]};
				{ 21, 49286, "", "=q4=X-51 Nether-Rocket X-TREME", "=ds=#e12#", "=q1="..AL["Servants of the Betrayer"]};
				{ 23, 49283, "", "=q3=Reins of the Spectral Tiger", "=ds=#e26#", "=q1="..AL["Fires of Outland"]};
				{ 24, 49285, "", "=q3=X-51 Nether-Rocket", "=ds=#e12#", "=q1="..AL["Servants of the Betrayer"]};
			};
		};
		info = {
			name = AL["Card Game Mounts"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsPromotional"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Promotional Mounts"], ""};
				{ 2, 106246, "", "=q4=Emerald Hippogryph", "#ACHIEVEMENTID:8794#"};
				{ 3, 83086, "", "=q4=Heart of the Nightwing", "#ACHIEVEMENTID:8213#"};
				{ 4, 98618, "", "=q4=Hearthsteed", "#ACHIEVEMENTID:8345#"};
				{ 5, 85870, "", "=q4=Imperial Quilen", "#ACHIEVEMENTID:6849#"};
				{ 6, 76889, "", "=q4=Spectral Gryphon", "=q2="..AL["Scroll of Resurrection"].."  =ec1=#m7#"};
				{ 7, 76902, "", "=q4=Spectral Wind Rider", "=q2="..AL["Scroll of Resurrection"].."  =ec1=#m6#"};
				{ 8, 76755, "", "=q4=Tyrael's Charger", "=q2="..AL["Annual Pass"]};
				{ 10, 43599, "", "=q3=Big Blizzard Bear", "#ACHIEVEMENTID:415#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Blizzard Store"], ""};
				{ 17, 95341, "", "=q4=Armored Bloodwing", "=ds=#e27#"};
				{ 18, 54811, "", "=q4=Celestial Steed", "=ds=#e27#"};
				{ 19, 97989, "", "=q4=Enchanted Fey Dragon", "=ds=#e27#"};
				{ 20, 78924, "", "=q4=Heart of the Aspects", "=ds=#e27#"};
				{ 21, 107951, "", "=q4=Iron Skyreaver", "=ds=#e27#"};
				{ 22, 92724, "", "=q4=Swift Windsteed", "=ds=#e27#"};
				{ 23, 69846, "", "=q4=Winged Guardian", "=ds=#e27#"};
			};
		};
		info = {
			name = AL["Promotional Mounts"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsEvent"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#m7#", ""};
				{ 2, 45591, "", "=q4=Darnassian Nightsaber", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 3, 45590, "", "=q4=Exodar Elekk", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 4, 45589, "", "=q4=Gnomeregan Mechanostrider", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 5, 45586, "", "=q4=Ironforge Ram", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 6, 45125, "", "=q4=Stormwind Steed", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 8, 46745, "", "=q4=Great Red Elekk", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 9, 46752, "", "=q4=Swift Gray Steed", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 10, 46744, "", "=q4=Swift Moonsaber", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 11, 46748, "", "=q4=Swift Violet Ram", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 12, 46747, "", "=q4=Turbostrider", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 14, 47179, "", "=q4=Argent Charger", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 15, 47180, "", "=q4=Argent Warhorse", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#m6#", ""};
				{ 17, 45593, "", "=q4=Darkspear Raptor", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 18, 45597, "", "=q4=Forsaken Warhorse", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 19, 45595, "", "=q4=Orgrimmar Wolf", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 20, 45596, "", "=q4=Silvermoon Hawkstrider", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 21, 45592, "", "=q4=Thunder Bluff Kodo", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 23, 46750, "", "=q4=Great Golden Kodo", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 24, 46749, "", "=q4=Swift Burgundy Wolf", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 25, 46743, "", "=q4=Swift Purple Raptor", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 26, 46751, "", "=q4=Swift Red Hawkstrider", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 27, 46746, "", "=q4=White Skeletal Warhorse", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 29, 45725, "", "=q4=Argent Hippogryph", "=ds=#e27#", "#CHAMPSEAL:150#"};
				extraText = " - "..AL["Argent Tournament"]
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..ALIL["Bizmo's Brawlpub"].." / "..ALIL["Brawl'gar Arena"], ""};
				{ 2, 98405, "", "=q4=Brawler's Burly Mushan Beast", "=ds=#e26#", string.format(AL["Rank %d"], 10)..", 1500 #gold#" },
				{ 4, 0, "INV_Box_01", "=q6="..AL["Brewfest"], ""};
				{ 5, 37828, "", "=q4=Great Brewfest Kodo", "=q2="..BabbleBoss["Coren Direbrew"]};
				{ 6, 33977, "", "=q4=Swift Brewfest Ram", "=q2="..BabbleBoss["Coren Direbrew"]};
				{ 8, 0, "INV_Box_01", "=q6="..AL["Hallow's End"], ""};
				{ 9, 37012, "", "=q4=The Horseman's Reins", "#ACHIEVEMENTID:980#"};
				{ 16, 0, "INV_Box_01", "=q6="..ALIL["Darkmoon Faire"], ""};
				{ 17, 73766, "", "=q4=Darkmoon Dancing Bear", "=ds=#e26#", "#DARKMOON:180#"},
				{ 18, 72140, "", "=q4=Swift Forest Strider", "=ds=#e26#", "#DARKMOON:180#"},
				{ 20, 0, "INV_Box_01", "=q6="..AL["Love is in the Air"], ""};
				{ 21, 50250, "", "=q4=Big Love Rocket", "#ACHIEVEMENTID:4627#"};
				{ 22, 72146, "", "=q4=Swift Lovebird", "=ds=#e26#", "#VALENTINEDAY:270#" },
				{ 24, 0, "INV_Box_01", "=q6="..AL["Noblegarden"], ""};
				{ 25, 72145, "", "=q4=Swift Springstrider", "=ds=#e26#", "#NOBLEGARDEN:500#"},
			};
		};
		info = {
			name = AL["World Events"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsRemoved"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Dungeon"], ""};
				{ 2, 33809, "", "=q4=Amani War Bear", "=q1="..ALIL["Zul'Aman"], ""};
				{ 3, 19872, "", "=q4=Swift Razzashi Raptor", "#ACHIEVEMENTID:881#"};
				{ 4, 19902, "", "=q4=Swift Zulian Tiger", "#ACHIEVEMENTID:880#"};
				{ 6, 0, "INV_Box_01", "=q6="..AL["Raid"], ""};
				{ 7, 49098, "", "=q4=Crusader's Black Warhorse", "#ACHIEVEMENTID:4079#, =ec1=#m6#"};
				{ 8, 49096, "", "=q4=Crusader's White Warhorse", "#ACHIEVEMENTID:4156#, =ec1=#m7#"};
				{ 9, 49044, "", "=q4=Swift Alliance Steed", "#ACHIEVEMENTID:3810#, =ec1=#m7#"};
				{ 10, 49046, "", "=q4=Swift Horde Wolf", "#ACHIEVEMENTID:3810#, =ec1=#m6#"};
				{ 11, 44164, "", "=q4=Reins of the Black Proto-Drake", "#ACHIEVEMENTID:2138#"};
				{ 12, 44175, "", "=q4=Reins of the Plagued Proto-Drake", "#ACHIEVEMENTID:2137#"};
				{ 14, 0, "INV_Box_01", "=q6="..AL["Arena Reward"], ""};
				{ 15, 30609, "", "=q4=Swift Nether Drake", "#ACHIEVEMENTID:886#"};
				{ 16, 34092, "", "=q4=Merciless Nether Drake", "#ACHIEVEMENTID:887#"};
				{ 17, 37676, "", "=q4=Vengeful Nether Drake", "#ACHIEVEMENTID:888#"};
				{ 18, 43516, "", "=q4=Brutal Nether Drake", "#ACHIEVEMENTID:2316#"};
				{ 19, 46708, "", "=q4=Deadly Gladiator's Frost Wyrm", "#ACHIEVEMENTID:3096#"};
				{ 20, 46171, "", "=q4=Furious Gladiator's Frost Wyrm", "#ACHIEVEMENTID:3756#"};
				{ 21, 47840, "", "=q4=Relentless Gladiator's Frost Wyrm", "#ACHIEVEMENTID:3757#"};
				{ 22, 50435, "", "=q4=Wrathful Gladiator's Frost Wyrm", "#ACHIEVEMENTID:4600#"};
				{ 23, 71339, "", "=q4=Vicious Gladiator's Twilight Drake", "#ACHIEVEMENTID:6003#"};
				{ 24, 71954, "", "=q4=Ruthless Gladiator's Twilight Drake", "#ACHIEVEMENTID:6322#"};
				{ 25, 85785, "", "=q4=Cataclysmic Gladiator's Twilight Drake", "#ACHIEVEMENTID:6741#"};
				{ 26, 95041, "", "=q4=Malevolent Gladiator's Cloud Serpent", "#ACHIEVEMENTID:8216#"};
				{ 27, 104325, "", "=q4=Tyrannical Gladiator's Cloud Serpent", "#ACHIEVEMENTID:8678#"};
				{ 28, 104326, "", "=q4=Grievous Gladiator's Cloud Serpent", "#ACHIEVEMENTID:8705#"};
				{ 29, 104327, "", "=q4=Prideful Gladiator's Cloud Serpent", "=ds=#e27#", "#ACHIEVEMENTID:8707#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["World Events"], ""};
				{ 2, 21176, "", "=q5=Black Qiraji Resonating Crystal", "=q1=#m4#: #QUESTID:8743#"};
				{ 3, 33976, "", "=q3=Brewfest Ram", "=ds=#e26#"};
				{ 5, 0, "INV_Box_01", "=q6="..FACTION_ALLIANCE, "#ACHIEVEMENTID:879#"};
				{ 6, 13328, "", "=q4=Black Ram", "#e26#"};
				{ 7, 13329, "", "=q4=Frost Ram", "#e26#"};
				{ 8, 13327, "", "=q4=Icy Blue Mechanostrider Mod A", "#e26#"};
				{ 9, 13326, "", "=q4=White Mechanostrider Mod B", "#e26#"};
				{ 10, 12354, "", "=q4=Palomino Bridle", "#e26#"};
				{ 11, 12353, "", "=q4=White Stallion Bridle", "#e26#"};
				{ 12, 12302, "", "=q4=Reins of the Ancient Frostsaber", "#e26#"};
				{ 13, 12303, "", "=q4=Reins of the Nightsaber", "#e26#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Promotional Mounts"], ""};
				{ 17, 103630, "", "=q4=Lucky Riding Turtle", "=ds=#e26#" };
				{ 18, 37719, "", "=q4=Swift Zhevra", "#ACHIEVEMENTID:1436#"};
				{ 19, 54860, "", "=q4=X-53 Touring Rocket", "#ACHIEVEMENTID:4832#"};
				{ 21, 0, "INV_Box_01", "=q6="..FACTION_HORDE, "#ACHIEVEMENTID:879#"};
				{ 22, 12351, "", "=q4=Horn of the Arctic Wolf", "#e26#"};
				{ 23, 12330, "", "=q4=Horn of the Red Wolf", "#e26#"};
				{ 24, 15292, "", "=q4=Green Kodo", "#e26#"};
				{ 25, 15293, "", "=q4=Teal Kodo", "#e26#"};
				{ 26, 13317, "", "=q4=Whistle of the Ivory Raptor", "#e26#"};
				{ 27, 8586, "", "=q4=Whistle of the Mottled Red Raptor", "#e26#"};
			};
		};
		info = {
			name = AL["Unobtainable Mounts"],
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

	AtlasLoot_Data["MountsNEW"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Achievement Reward"], ""};
				{ 2, 104208, "", "=q4=Reins of Galakras", "=ds=#e27#", "#ACHIEVEMENTID:8454#"};
				{ 3, 104246, "", "=q4=Reins of the Kor'kron War Wolf", "=ds=#e26#", "#ACHIEVEMENTID:8398#"};
				{ 4, 102533, "", "=q4=Reins of the Vicious Skeletal Warhorse", "#ACHIEVEMENTID:8484#, =ec1=#m6#"};
				{ 5, 102514, "", "=q4=Reins of the Vicious Warsaber", "#ACHIEVEMENTID:8485#, =ec1=#m7#"};
				{ 7, 0, "INV_Box_01", "=q6="..AL["Arena Reward"], ""};
				{ 8, 104326, "", "=q4=Grievous Gladiator's Cloud Serpent", "=ds=#e27#", "#ACHIEVEMENTID:8705#"};
				{ 9, 104327, "", "=q4=Prideful Gladiator's Cloud Serpent", "=ds=#e27#", "#ACHIEVEMENTID:8707#"};
				{ 10, 104325, "", "=q4=Tyrannical Gladiator's Cloud Serpent", "=ds=#e27#", "#ACHIEVEMENTID:8678#"};
				{ 12, 0, "INV_Box_01", "=q6="..AL["Crafted Mounts"], ""};
				{ 13, 95416, "", "=q4=Sky Golem", "=ds=#e27#", "=ds=#p5#" };
				{ 16, 0, "INV_Box_01", "=q6="..AL["Neutral Faction Mounts"], ""};
				{ 17, 87774, "", "=q4=Reins of the Heavenly Golden Cloud Serpent", "=ds=#e27#", "#TIMELESSCOIN:100000#"};
				{ 19, 0, "INV_Box_01", "=q6="..AL["Promotional Mounts"], ""};
				{ 20, 106246, "", "=q4=Emerald Hippogryph", "#ACHIEVEMENTID:8794#"};
				{ 21, 107951, "", "=q4=Iron Skyreaver", "=ds=#e27#"};
				{ 23, 0, "INV_Box_01", "=q6="..AL["PvP Mounts"], ""};
				{ 24, 103638, "", "=q4=Reins of the Ashhide Mushan Beast", "=ds=#e26#", "#BLOODYCOIN:500#"};
				{ 26, 0, "INV_Box_01", "=q6="..AL["Rare Mounts"], ""};
				{ 27, 104253, "", "=q4=Kor'kron Juggernaut", "=ds=#e26#", "=q2="..AtlasLoot:EJ_GetBossName("Garrosh Hellscream", 869).." - "..AL["Heroic"]..", =q1="..ALIL["Siege of Orgrimmar"] };
				{ 28, 104269, "", "=q4=Reins of the Thundering Onyx Cloud Serpent", "=ds=#e27#", "=q2="..ALIL["Huolon"]..", =q1="..ALIL["Timeless Isle"] };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Unknown"], ""};
				{ 2, 109013, "", "=q4=Reins of the Dread Raven", "=ds=#e27#"};
				{ 3, 104011, "", "=q4=Stormcrow", "=ds=" };
			};
		};
		info = {
			name = AL["New Mounts"].." - Patch 5.4",
			module = moduleName, menu = "MOUNTMENU", instance = "Mounts",
		};
	}

		---------------
		--- Tabards ---
		---------------

	AtlasLoot_Data["TabardsAlliance"] = {
		["Normal"] = {
			{
				{ 1, 63379, "", "=q3=Baradin's Wardens Tabard", "=ds=#s7#"};
				{ 2, 45579, "", "=q1=Darnassus Tabard", "=ds=#s7#"};
				{ 3, 45580, "", "=q1=Exodar Tabard", "=ds=#s7#"};
				{ 4, 64882, "", "=q1=Gilneas Tabard", "=ds=#s7#"};
				{ 5, 45578, "", "=q1=Gnomeregan Tabard", "=ds=#s7#"};
				{ 6, 23999, "", "=q1=Honor Hold Tabard", "=ds=#s7#"};
				{ 7, 45577, "", "=q1=Ironforge Tabard", "=ds=#s7#"};
				{ 8, 31774, "", "=q1=Kurenai Tabard", "=ds=#s7#"};
				{ 9, 46817, "", "=q1=Silver Covenant Tabard", "=ds=#s7#"};
				{ 10, 45574, "", "=q1=Stormwind Tabard", "=ds=#s7#"};
				{ 11, 83079, "", "=q1=Tushui Tabard", "=ds=#s7#"};
				{ 16, 0, "INV_BannerPVP_02", "=q6="..AL["PvP Tabards"], ""};
				{ 17, 15196, "", "=q1=Private's Tabard", "=ds=#s7#"};
				{ 18, 15198, "", "=q1=Knight's Colors", "=ds=#s7#"};
				{ 19, 20132, "", "=q1=Arathor Battle Tabard", "=ds=#s7#, =q1=#m4#"};
				{ 20, 19506, "", "=q1=Silverwing Battle Tabard", "=ds=#s7#"};
				{ 21, 19032, "", "=q1=Stormpike Battle Tabard", "=ds=#s7#"};
			};
		};
		info = {
			name = AL["Alliance Tabards"],
			module = moduleName, menu = "TABARDMENU",
		};
	}

	AtlasLoot_Data["TabardsHorde"] = {
		["Normal"] = {
			{
				{ 1, 63378, "", "=q3=Hellscream's Reach Tabard", "=ds=#s7#"};
				{ 2, 64884, "", "=q1=Bilgewater Cartel Tabard", "=ds=#s7#"};
				{ 3, 45582, "", "=q1=Darkspear Tabard", "=ds=#s7#"};
				{ 4, 83080, "", "=q1=Huojin Tabard", "=ds=#s7#"};
				{ 5, 31773, "", "=q1=Mag'har Tabard", "=ds=#s7#"};
				{ 6, 45581, "", "=q1=Orgrimmar Tabard", "=ds=#s7#"};
				{ 7, 45585, "", "=q1=Silvermoon City Tabard", "=ds=#s7#"};
				{ 8, 46818, "", "=q1=Sunreaver Tabard", "=ds=#s7#"};
				{ 9, 24004, "", "=q1=Thrallmar Tabard", "=ds=#s7#"};
				{ 10, 45584, "", "=q1=Thunder Bluff Tabard", "=ds=#s7#"};
				{ 11, 45583, "", "=q1=Undercity Tabard", "=ds=#s7#"};
				{ 16, 0, "INV_BannerPVP_01", "=q6="..AL["PvP Tabards"], ""};
				{ 17, 15197, "", "=q1=Scout's Tabard", "=ds=#s7#"};
				{ 18, 15199, "", "=q1=Stone Guard's Herald", "=ds=#s7#"};
				{ 19, 20131, "", "=q1=Battle Tabard of the Defilers", "=ds=#s7#, =q1=#m4#"};
				{ 20, 19031, "", "=q1=Frostwolf Battle Tabard", "=ds=#s7#"};
				{ 21, 19505, "", "=q1=Warsong Battle Tabard", "=ds=#s7#"};
			};
		};
		info = {
			name = AL["Horde Tabards"],
			module = moduleName, menu = "TABARDMENU",
		};
	}

	AtlasLoot_Data["TabardsNeutralFaction"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Cataclysm"], ""};
				{ 2, 65904, "", "=q1=Tabard of Ramkahen", "=ds=#s7#"};
				{ 3, 65909, "", "=q1=Tabard of the Dragonmaw Clan", "=ds=#s7#"};
				{ 4, 65905, "", "=q1=Tabard of the Earthen Ring", "=ds=#s7#"};
				{ 5, 65906, "", "=q1=Tabard of the Guardians of Hyjal", "=ds=#s7#"};
				{ 6, 65907, "", "=q1=Tabard of Therazane", "=ds=#s7#"};
				{ 7, 65908, "", "=q1=Tabard of the Wildhammer Clan", "=ds=#s7#"};
				{ 9, 0, "INV_Box_01", "=q6="..AL["Wrath of the Lich King"], ""};
				{ 10, 46874, "", "=q3=Argent Crusader's Tabard", "=ds=#s7#"};
				{ 11, 43154, "", "=q1=Tabard of the Argent Crusade", "=ds=#s7#"};
				{ 12, 43155, "", "=q1=Tabard of the Ebon Blade", "=ds=#s7#"};
				{ 13, 43157, "", "=q1=Tabard of the Kirin Tor", "=ds=#s7#"};
				{ 14, 43156, "", "=q1=Tabard of the Wyrmrest Accord", "=ds=#s7#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Burning Crusade"], ""};
				{ 17, 31779, "", "=q1=Aldor Tabard", "=ds=#s7#"};
				{ 18, 31804, "", "=q1=Cenarion Expedition Tabard", "=ds=#s7#"};
				{ 19, 31776, "", "=q1=Consortium Tabard", "=ds=#s7#"};
				{ 20, 31777, "", "=q1=Keepers of Time Tabard", "=ds=#s7#"};
				{ 21, 31778, "", "=q1=Lower City Tabard", "=ds=#s7#"};
				{ 22, 32828, "", "=q1=Ogri'la Tabard", "=ds=#s7#"};
				{ 23, 31781, "", "=q1=Sha'tar Tabard", "=ds=#s7#"};
				{ 24, 31775, "", "=q1=Sporeggar Tabard", "=ds=#s7#"};
				{ 25, 31780, "", "=q1=Scryers Tabard", "=ds=#s7#"};
				{ 26, 32445, "", "=q1=Skyguard Tabard", "=ds=#s7#"};
				{ 27, 35221, "", "=q1=Tabard of the Shattered Sun", "=ds=#s7#"};
			};
		};
		info = {
			name = AL["Neutral Faction Tabards"],
			module = moduleName, menu = "TABARDMENU",
		};
	}

	AtlasLoot_Data["TabardsAchievementQuestRare"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_guildperk_honorablemention_rank2", "=q6="..AL["Achievement Reward"], ""};
				{ 2, 43349, "", "=q4=Tabard of Brute Force", "#ACHIEVEMENTID:876#"};
				{ 3, 40643, "", "=q4=Tabard of the Achiever", "#ACHIEVEMENTID:1021#"};
				{ 4, 43348, "", "=q4=Tabard of the Explorer", "#ACHIEVEMENTID:45#"};
				{
					{ 5, 43300, "", "=q4=Loremaster's Colors", "#ACHIEVEMENTID:1682#, =ec1=#m6#"};
					{ 5, 43300, "", "=q4=Loremaster's Colors", "#ACHIEVEMENTID:1681#, =ec1=#m7#"};
				};
				{ 6, 49052, "", "=q3=Tabard of Conquest", "#ACHIEVEMENTID:3857#, =ec1=#m7#"};
				{ 7, 49054, "", "=q3=Tabard of Conquest", "#ACHIEVEMENTID:3957#, =ec1=#m6#"};
				{ 16, 0, "achievement_guildperk_honorablemention", "=q6="..AL["Quest Reward"], ""};
				{ 17, 52252, "", "=q4=Tabard of the Lightbringer", "=q1=#m4#: #QUESTID:24919#"};
				{ 18, 35280, "", "=q3=Tabard of Summer Flames", "=q1=#m4#: #QUESTID:11972#"};
				{ 19, 35279, "", "=q3=Tabard of Summer Skies", "=q1=#m4#: #QUESTID:11972#"};
				{ 20, 31404, "", "=q2=Green Trophy Tabard of the Illidari", "=q1=#m4#: #QUESTID:10781#"};
				{ 21, 31405, "", "=q2=Purple Trophy Tabard of the Illidari", "=q1=#m4#: #QUESTID:10781#"};
				{ 22, 25549, "", "=q1=Blood Knight Tabard", "=q1=#m4#: #QUESTID:9737#, =ec1=#m6#"};
				{ 23, 24344, "", "=q1=Tabard of the Hand", "=q1=#m4#: #QUESTID:9762#, =ec1=#m7#"};
			};
		};
		info = {
			name = AL["Achievement & Quest Reward Tabards"],
			module = moduleName, menu = "TABARDMENU",
		};
	}

	AtlasLoot_Data["TabardsRemoved"] = {
		["Normal"] = {
			{
				{ 1, 36941, "", "=q3=Competitor's Tabard", "#ACHIEVEMENTID:1636#"};
				{ 2, 89196, "", "=q3=Theramore Tabard", "#ACHIEVEMENTID:7467#"};
				{ 3, 23192, "", "=q2=Tabard of the Scarlet Crusade", "=ds=#s7#"};
				{ 4, 22999, "", "=q1=Tabard of the Argent Dawn", "#ACHIEVEMENTID:2116#"};
				{ 5, 28788, "", "=q1=Tabard of the Protector", "#ACHIEVEMENTID:2079#"};
				{ 6, 19160, "", "=q1=Contest Winner's Tabard", "=ds=#s7#"};
				{ 8, 0, "achievement_featsofstrength_gladiator_10", "=q6="..AL["Arena Reward"], ""};
				{ 9, 45983, "", "=q4=Furious Gladiator's Tabard", "=q5="..string.format(AL["Season %d"], 6)};
				{ 10, 49086, "", "=q4=Relentless Gladiator's Tabard", "=q5="..string.format(AL["Season %d"], 7)};
				{ 11, 51534, "", "=q4=Wrathful Gladiator's Tabard", "=q5="..string.format(AL["Season %d"], 8)};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Card Game Tabards"], ""};
				{ 17, 38312, "", "=q4=Tabard of Brilliance", "=ds=#s7#, =q1=#m24#"};
				{ 18, 23705, "", "=q4=Tabard of Flame", "=ds=#s7#, =q1=#m24#"};
				{ 19, 23709, "", "=q4=Tabard of Frost", "=ds=#s7#, =q1=#m24#"};
				{ 20, 38313, "", "=q4=Tabard of Fury", "=ds=#s7#, =q1=#m24#"};
				{ 21, 38309, "", "=q4=Tabard of Nature", "=ds=#s7#, =q1=#m24#"};
				{ 22, 38310, "", "=q4=Tabard of the Arcane", "=ds=#s7#, =q1=#m24#"};
				{ 23, 38314, "", "=q4=Tabard of the Defender", "=ds=#s7#, =q1=#m24#"};
				{ 24, 38311, "", "=q4=Tabard of the Void", "=ds=#s7#, =q1=#m24#"};
			};
		};
		info = {
			name = AL["Unobtainable Tabards"],
			module = moduleName, menu = "TABARDMENU",
		};
	}

		----------------------------
		--- Transformation Items ---
		----------------------------

	AtlasLoot_Data["TransformationNonconsumedItems"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Vendor"]};
				{ 2, 44719, "", "=q3=Frenzyheart Brew", "=q2="..ALIL["Frenzyheart Tribe"].." - "..AL["Revered"], "=ds=3 #gold#"};
				{ 3, 68806, "", "=q3=Kalytha's Haunted Locket", "=q2="..AL["Tex Vortacoil"]..", =q1="..ALIL["Azshara"], "=ds=5,000 #gold#"};
				{
					{ 4, 43499, "", "=q1=Iron Boot Flask", "=q2="..AL["Olut Alegut"]..", =q1="..ALIL["The Storm Peaks"], "#RELICULDUAR:10#"};
					{ 4, 43499, "", "=q1=Iron Boot Flask", "=q2="..AL["Rork Sharpchin"]..", =q1="..ALIL["The Storm Peaks"], "#RELICULDUAR:10#"};
				};
				{ 5, 66888, "", "=q1=Stave of Fur and Claw", "=q2="..ALIL["Timbermaw Hold"].." - "..AL["Exalted"], "=ds=5,000 #gold#"};
				{ 7, 0, "INV_Box_01", "=q6="..AL["Quest Reward"]};
				{ 8, 52201, "", "=q4=Muradin's Favor", "=ds=#m4#: #QUESTID:24917#"};
				{ 9, 54653, "", "=q3=Darkspear Pride", "=ds=#m4#: #QUESTID:25480# #m6#"};
				{ 10, 54651, "", "=q3=Gnomeregan Pride", "=ds=#m4#: #QUESTID:25286# #m7#"};
				{ 11, 19979, "", "=q3=Hook of the Master Angler", "=ds=#m4#: #QUESTID:8193#"};
				{ 12, 5462, "", "=q1=Dartol's Rod of Transformation", "=ds=#m34#: #QUESTID:1028# #m7#"};
				{ 13, 53057, "", "=q1=Faded Wizard Hat", "=ds=#m4#: #QUESTID:14392# #m6#"};
				{ 14, 88417, "", "=q1=Gokk'lok's Shell", "=ds=#m4#: #QUESTID:31083# #m6#"};
				{ 15, 71259, "", "=q1=Leyara's Locket", "=ds=#m4#: #QUESTID:29311#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Rare"]};
				{ 17, 37254, "", "=q4=Super Simian Sphere", "=ds="..AL["World Drop"]};
				{ 18, 86589, "", "=q3=Ai-Li's Skymirror", "=q2="..ALIL["Ai-Li Skymirror"]..", =q1="..ALIL["Dread Wastes"]};
				{ 19, 86582, "", "=q3=Aqua Jewel", "=q2="..ALIL["Sahn Tidehunter"]..", =q1="..ALIL["Vale of Eternal Blossoms"]};
				{ 20, 65665, "", "=q3=Burgy Blackheart's Handsome Hat", "=q2="..BabbleRare["Burgy Blackheart"]..", =q1="..ALIL["Shimmering Expanse"]};
				{ 21, 86593, "", "=q3=Hozen Beach Ball", "=q2="..ALIL["Ik-Ik the Nimble"]..", =q1="..ALIL["Dread Wastes"]};
				{ 22, 88566, "", "=q3=Krastinov's Bag of Horrors", "=q2="..BabbleBoss["Doctor Theolen Krastinov"]..", =q1="..ALIL["Scholomance"]};
				{ 23, 86568, "", "=q3=Mr. Smite's Brass Compass", "=q2="..ALIL["Yorik Sharpeye"]..", =q1="..ALIL["Vale of Eternal Blossoms"]};
				{ 24, 1973, "", "=q3=Orb of Deception", "=q2="..AL["World Drop"]};
				{ 25, 35275, "", "=q3=Orb of the Sin'dorei", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Magisters' Terrace"]};
				{ 26, 86573, "", "=q3=Shard of Archstone", "=q2="..ALIL["Havak"]..", =q1="..ALIL["Kun-Lai Summit"]};
				{ 27, 32782, "", "=q3=Time-Lost Figurine", "=q2="..BabbleRare["Terokk"]..", =q1="..ALIL["Terokkar Forest"]};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Crafted"]};
				{ 2, 64481, "", "=q4=Blessing of the Old God", "=ds=#p25#"};
				{ 3, 64646, "", "=q4=Bones of Transformation", "=ds=#p25#"};
				{ 4, 64651, "", "=q4=Wisp Amulet", "=ds=#p25#"};
				{ 5, 45850, "", "=q3=Rituals of the New Moon", "=ds=#p26#"};
				{ 6, 45851, "", "=q3=Rituals of the New Moon", "=ds=#p26#"};
				{ 7, 45852, "", "=q3=Rituals of the New Moon", "=ds=#p26#"};
				{ 8, 45853, "", "=q3=Rituals of the New Moon", "=ds=#p26#"};
				{ 9, 69775, "", "=q3=Vrykul Drinking Horn", "=ds=#p25#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Card Game Item"]};
				{ 17, 49704, "", "=q4=Carved Ogre Idol", "=ds="..AL["UDE Items"]..", =ds="..AL["No Longer Available"]};
				{ 19, 0, "INV_Box_01", "=q6="..AL["Promotional"]};
				{ 20, 33079, "", "=q3=Murloc Costume", "#ACHIEVEMENTID:412#"};
				{ 22, 0, "INV_Box_01", "=q6="..AL["World Events"]};
				{ 23, 17712, "", "=q1=Winter Veil Disguise Kit", "=ds="..AL["Feast of Winter Veil"]};
			};
		};
		info = {
			name = AL["Non-consumed Transformation Items"],
			module = moduleName, menu = "TRANSFORMATIONMENU",
		};
	}

	AtlasLoot_Data["TransformationConsumableItems"] = {
		["Normal"] = {
			{
				{ 2, 0, "INV_Box_01", "=q6="..AL["Crafted"]};
				{ 3, 4388, "", "=q1=Discombobulator Ray", "=ds=#p5#"};
				{ 4, 63122, "", "=q1=Lifegiving Seed", "=ds=#p27#"};
				{ 5, 43572, "", "=q1=Magic Eater", "=ds=#p24#: =q1="..ALIL["Dalaran"]};
				{ 6, 58489, "", "=q1=Potion of Illusion", "=ds=#p1#"};
				{ 7, 40195, "", "=q1=Pygmy Oil", "=ds=#p1#"};
				{ 8, 6657, "", "=q1=Savory Deviate Delight", "=ds=#p3#"};
				{ 10, 0, "INV_Box_01", "=q6="..AL["Drop"]};
				{ 11, 38320, "", "=q1=Dire Brew", "=q1="..ALIL["Blackrock Depths"]};
				{ 12, 23864, "", "=q1=Torment of the Worgen", "=q1="..ALIL["Karazhan"]};
				{ 13, 44012, "", "=q1=Underbelly Elixir", "=q1="..ALIL["Dalaran"]};
				{ 17, 0, "INV_Box_01", "=q6="..AL["Dungeon"].." / "..AL["Raid"]};
				{ 18, 94604, "", "=q2=Burning Seed", "=q1="..ALIL["Firelands"]};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Rare"]};
				{ 21, 89373, "", "=q2=Scotty's Lucky Coin", "=q2="..ALIL["Scotty"]..", =q1="..ALIL["Townlong Steppes"]};
			};
			{
				{ 2, 0, "INV_Box_01", "=q6="..AL["Vendor"]};
				{
					{ 3, 93314, "", "=q1=Magic Bamboo Shoot", "=q2="..AL["Luo Luo"]..", =q1="..ALIL["Orgrimmar"]};
					{ 3, 93314, "", "=q1=Magic Bamboo Shoot", "=q2="..AL["Meng Meng"]..", =q1="..ALIL["Stormwind City"]};
				};
				{ 4, 8529, "", "=q1=Noggenfogger Elixir", "=q2="..AL["Sprinkle Noggenfogger"]..", =q1="..ALIL["Tanaris"], "35 #silver#"};
				{
					{ 5, 92528, "", "=q1=Obelisk of Deception", "=q2="..AL["Ongrom Black Tooth"]..", =q1="..ALIL["Krasarang Wilds"], "=ds=", "#DOMINATIONCOMMISSION:500#" },
					{ 5, 92533, "", "=q1=Obelisk of Deception", "=q2="..AL["Proveditor Grantley"]..", =q1="..ALIL["Krasarang Wilds"], "=ds=", "#LIONSLANDINGCOMMISSION:500#" },
				};
				{ 6, 31337, "", "=q1=Orb of the Blackwhelp", "=q2="..AL["Wyrmcult Provisioner"]..", =q1="..ALIL["Blade's Edge Mountains"], "2 #gold# 50 #silver#"};
				{ 7, 88492, "", "=q1=Wicked Wikket", "=q2="..AL["Auntie Stormstout"]..", =q1="..ALIL["Stormstout Brewery"], "15 #gold#"};
				{ 17, 0, "INV_Box_01", "=q6="..AL["World Events"]};
				{ 18, 44792, "", "=q1=Blossoming Branch", "=ds="..AL["Noblegarden"], "#NOBLEGARDEN:10#"};
				{ 19, 20410, "", "=q1=Hallowed Wand - Bat", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 20, 20409, "", "=q1=Hallowed Wand - Ghost", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 21, 20399, "", "=q1=Hallowed Wand - Leper Gnome", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 22, 20398, "", "=q1=Hallowed Wand - Ninja", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 23, 20397, "", "=q1=Hallowed Wand - Pirate", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 24, 20413, "", "=q1=Hallowed Wand - Random", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 25, 20411, "", "=q1=Hallowed Wand - Skeleton", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
				{ 26, 20414, "", "=q1=Hallowed Wand - Wisp", "=ds="..AL["Hallow's End"], "#HALLOWSEND:2#"};
			};
		};
		info = {
			name = AL["Consumable Transformation Items"],
			module = moduleName, menu = "TRANSFORMATIONMENU",
		};
	}

	AtlasLoot_Data["TransformationAdditionalEffects"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Weapons"]};
				{ 2, 71086, "", "=q5=Dragonwrath, Tarecgosa's Rest", "=ds=#w9#", "=q1="..ALIL["Firelands"]};
				{ 3, 69897, "", "=q4=Fandral's Flamescythe", "=ds=#w9#", "=q2="..BabbleBoss["Majordomo Staghelm"]..", =q1="..ALIL["Firelands"]};
				{ 4, 71466, "", "=q4=Fandral's Flamescythe", "=ds=#w9#", "=q2="..BabbleBoss["Majordomo Staghelm"]..", =q1="..ALIL["Firelands"]};
				{ 5, 39769, "", "=q4=Arcanite Ripper", "=ds=#h2#, #w1#", "=q2="..AL["No Longer Available"]};
				{ 6, 19910, "", "=q4=Arlokk's Grasp", "=ds=#h1#, #w13#", "=q2="..AL["No Longer Available"]};
				{ 7, 19896, "", "=q4=Thekal's Grasp", "=ds=#h1#, #w13#", "=q2="..AL["No Longer Available"]};
				{ 9, 0, "INV_Box_01", "=q6="..BabbleInventory["Mounts"]};
				{ 10, 65891, "", "=q4=Vial of the Sands", "=ds=#e12#", "=ds=#p1#"};
				{ 11, 83086, "", "=q4=Heart of the Nightwing", "=ds=#e12#", "=q2="..AL["Recruit-A-Friend"]};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Trinkets"]};
				{ 17, 50362, "", "=q4=Deathbringer's Will", "=ds=#s14#", "=q2="..BabbleBoss["Deathbringer Saurfang"]..", =q1="..ALIL["Icecrown Citadel"]};
				{ 18, 50363, "", "=q4=Deathbringer's Will", "=ds=#s14#", "=q2="..BabbleBoss["Deathbringer Saurfang"]..", =q1="..ALIL["Icecrown Citadel"]};
				{ 19, 59461, "", "=q4=Fury of Angerforge", "=ds=#s14#", "=q2="..AL["Various Locations"]..", =q1="..ALIL["Blackwing Lair"]};
				{ 20, 23835, "", "=q3=Gnomish Poultryizer", "=ds=#s14#", "=ds=#p5#"};
				{ 21, 18984, "", "=q2=Dimensional Ripper - Everlook", "=ds=#s14#", "=ds=#p5#"};
				{ 22, 18986, "", "=q2=Ultrasafe Transporter: Gadgetzan", "=ds=#s14#", "=ds=#p5#"};
			};
		};
		info = {
			name = AL["Additional Effects Transformation Items"],
			module = moduleName, menu = "TRANSFORMATIONMENU",
		};
	}

		-------------------
		--- Legendaries ---
		-------------------

	AtlasLoot_Data["Legendaries"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Mists of Pandaria"]};
				{ 2, 102248, "", "=q5=Fen-Yu, Fury of Xuen", "=ds=#s4#"};
				{ 3, 102249, "", "=q5=Gong-Lu, Strength of Xuen", "=ds=#s4#"};
				{ 4, 102247, "", "=q5=Jina-Kang, Kindness of Chi-Ji", "=ds=#s4#"};
				{ 5, 102245, "", "=q5=Qian-Le, Courage of Niuzao", "=ds=#s4#"};
				{ 6, 102250, "", "=q5=Qian-Ying, Fortitude of Niuzao", "=ds=#s4#"};
				{ 7, 102246, "", "=q5=Xing-Ho, Breath of Yu'lon", "=ds=#s4#"};
				{ 9, 95346, "", "=q5=Capacitive Primal Diamond", "=ds=#e32# #e7#"};
				{ 10, 95345, "", "=q5=Courageous Primal Diamond", "=ds=#e32# #e7#"};
				{ 11, 95344, "", "=q5=Indomitable Primal Diamond", "=ds=#e32# #e7#"};
				{ 12, 95347, "", "=q5=Sinister Primal Diamond", "=ds=#e32# #e7#"};
				{ 17, 93403, "", "=q5=Eye of the Black Prince", "=ds=#m4#"};
				{ 19, 89873, "", "=q5=Crystallized Dread", "=ds=#e7#"};
				{ 20, 89882, "", "=q5=Crystallized Horror", "=ds=#e7#"};
				{ 21, 89881, "", "=q5=Crystallized Terror", "=ds=#e7#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Cataclysm"]};
				{ 2, 77949, "", "=q5=Golad, Twilight of Aspects", "=ds=#h3#, #w4#", "" };
				{ 3, 77950, "", "=q5=Tiriosh, Nightmare of Ages", "=ds=#h4#, #w4#", "" };
				{ 4, 77947, "", "=q4=The Sleeper", "=ds=#h3#, #w4#", "" };
				{ 5, 77948, "", "=q4=The Dreamer", "=ds=#h4#, #w4#", "" };
				{ 6, 77945, "", "=q4=Fear", "=ds=#h3#, #w4#", "" };
				{ 7, 77946, "", "=q4=Vengeance", "=ds=#h4#, #w4#", "" };
				{ 9, 71086, "", "=q5=Dragonwrath, Tarecgosa's Rest", "=ds=#w9#", "" };
				{ 10, 71085, "", "=q4=Runestaff of Nordrassil", "=ds=#w9#", "" };
				{ 11, 71084, "", "=q4=Branch of Nordrassil", "=ds=#w9#", "" };
				{ 16, 0, "INV_Box_01", "=q6="..AL["Wrath of the Lich King"]};
				{ 17, 49623, "", "=q5=Shadowmourne", "=ds=#h2#, #w1#", "" };
				{ 18, 49888, "", "=q4=Shadow's Edge", "=ds=#h2#, #w1#", "" };
				{ 20, 46017, "", "=q5=Val'anyr, Hammer of Ancient Kings", "=ds=#h1#, #w6#", "" };
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Burning Crusade"]};
				{ 2, 34334, "", "=q5=Thori'dal, the Stars' Fury", "=ds=#w2#"};
				{ 4, 32837, "", "=q5=Warglaive of Azzinoth", "=ds=#h3#, #w10#, =q1=#m1# =ds=#c9#, #c6#"};
				{ 5, 32838, "", "=q5=Warglaive of Azzinoth", "=ds=#h4#, #w10#, =q1=#m1# =ds=#c9#, #c6#"};
				{ 7, 30312, "", "=q5=Infinity Blade", "=ds=#h1#, #w4#"};
				{ 8, 30311, "", "=q5=Warp Slicer", "=ds=#h1#, #w10#"};
				{ 9, 30316, "", "=q5=Devastation", "=ds=#h2#, #w1#"};
				{ 10, 30317, "", "=q5=Cosmic Infuse", "=ds=#h1#, #w6#"};
				{ 11, 30313, "", "=q5=Staff of Disintegration", "=ds=#w9#"};
				{ 12, 30318, "", "=q5=Netherstrand Longbow", "=ds=#w2#"};
				{ 13, 30314, "", "=q5=Phaseshift Bulwark", "=ds=#w8#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Classic WoW"]};
				{ 17, 22632, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c1#"};
				{ 18, 22589, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c3#"};
				{ 19, 22631, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c5#"};
				{ 20, 22630, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#w9#, =q1=#m1# =ds=#c8#"};
				{ 22, 21176, "", "=q5=Black Qiraji Resonating Crystal", "=ds=#e26#"};
				{ 24, 19019, "", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=ds=#h1#, #w10#"};
				{ 26, 17182, "", "=q5=Sulfuras, Hand of Ragnaros", "=ds=#h2#, #w6#"};
				{ 27, 17193, "", "=q4=Sulfuron Hammer", "=ds=#h2#, #w6#"};
			};
		};
		info = {
			name = AL["Legendary Items"],
			module = moduleName, menu = "SETMENU",
		};
	}

		----------------------
		--- Heirloom Items ---
		----------------------

	AtlasLoot_Data["Heirloom"] = {
		["Normal"] = {
			{
				{ 1, 62040, "", "=q7=Ancient Bloodmoon Cloak", "=ds=#s4#", "1,200 #gold#"};
				{ 2, 62039, "", "=q7=Inherited Cape of the Black Baron", "=ds=#s4#", "1,200 #gold#"};
				{ 3, 69892, "", "=q7=Ripped Sandstorm Cloak", "=ds=#s4#", "1,200 #gold#"};
				{ 4, 62038, "", "=q7=Worn Stoneskin Gargoyle Cape", "=ds=#s4#", "1,200 #gold#"};
				{ 6, 61958, "", "=q7=Tattered Dreadmist Mask", "=ds=#s1#, #a1#", "1,500 #gold#"};
				{ 7, 93859, "", "=q7=Bloodstained Dreadmist Mantle", "=ds=#s3#, #a1#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42985:1#"};
				{ 8, 42985, "", "=q7=Tattered Dreadmist Mantle", "=ds=#s3#, #a1#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 9, 93860, "", "=q7=Bloodstained Dreadmist Robe", "=ds=#s5#, #a1#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48691:1#"};
				{ 10, 48691, "", "=q7=Tattered Dreadmist Robe", "=ds=#s5#, #a1#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 11, 62029, "", "=q7=Tattered Dreadmist Leggings", "=ds=#s11#, #a1#", "1,750 #gold#"};
				{ 16, 61942, "", "=q7=Preened Tribal War Feathers", "=ds=#s1#, #a2#", "1,500 #gold#"};
				{ 17, 93864, "", "=q7=Majestic Ironfeather Shoulders", "=ds=#s3#, #a2#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42984:1#"};
				{ 18, 42984, "", "=q7=Preened Ironfeather Shoulders", "=ds=#s3#, #a2#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 19, 93865, "", "=q7=Majestic Ironfeather Breastplate", "=ds=#s5#, #a2#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48687:1#"};
				{ 20, 48687, "", "=q7=Preened Ironfeather Breastplate", "=ds=#s5#, #a2#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 21, 62027, "", "=q7=Preened Wildfeather Leggings", "=ds=#s11#, #a2#", "1,750 #gold#"};
				{ 23, 61937, "", "=q7=Stained Shadowcraft Cap", "=ds=#s1#, #a2#", "1,500 #gold#"};
				{ 24, 93862, "", "=q7=Supple Shadowcraft Spaulders", "=ds=#s3#, #a2#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42952:1#"};
				{ 25, 42952, "", "=q7=Stained Shadowcraft Spaulders", "=ds=#s3#, #a2#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 26, 93863, "", "=q7=Supple Shadowcraft Tunic", "=ds=#s5#, #a2#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48689:1#"};
				{ 27, 48689, "", "=q7=Stained Shadowcraft Tunic", "=ds=#s5#, #a2#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 28, 62026, "", "=q7=Stained Shadowcraft Pants", "=ds=#s11#, #a2#", "1,750 #gold#"};
				extraText = ": "..BabbleInventory["Back"].." / "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				{ 1, 61935, "", "=q7=Tarnished Raging Berserker's Helm", "=ds=#s1#, #a3#", "1,500 #gold#"};
				{ 2, 93887, "", "=q7=Grand Champion Herod's Shoulder", "=ds=#s3#, #a3#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42950:1#"};
				{ 3, 42950, "", "=q7=Champion Herod's Shoulder", "=ds=#s3#, #a3#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 4, 93888, "", "=q7=Furious Deathdealer Breastplate", "=ds=#s5#, #a3#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48677:1#"};
				{ 5, 48677, "", "=q7=Champion's Deathdealer Breastplate", "=ds=#s5#, #a3#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 6, 62024, "", "=q7=Tarnished Leggings of Destruction", "=ds=#s11#, #a3#", "1,750 #gold#"};
				{ 8, 61936, "", "=q7=Mystical Coif of Elements", "=ds=#s1#, #a3#", "1,500 #gold#"};
				{ 9, 93876, "", "=q7=Awakened Pauldrons of Elements", "=ds=#s3#, #a3#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42951:1#"};
				{ 10, 42951, "", "=q7=Mystical Pauldrons of Elements", "=ds=#s3#, #a3#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 11, 93885, "", "=q7=Awakened Vest of Elements", "=ds=#s5#, #a3#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48683:1#"};
				{ 12, 48683, "", "=q7=Mystical Vest of Elements", "=ds=#s5#, #a3#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 13, 62025, "", "=q7=Mystical Kilt of Elements", "=ds=#s11#, #a3#", "1,750 #gold#"};
				{ 16, 69887, "", "=q7=Burnished Helm of Might", "=ds=#s1#, #a4#", "1,500 #gold#"};
				{ 17, 93893, "", "=q7=Brushed Pauldrons of Might", "=ds=#s3#, #a4#", "#JUSTICE:870# #DARKMOON:44# #ITEM:69890:1#"};
				{ 18, 69890, "", "=q7=Burnished Pauldrons of Might", "=ds=#s3#, #a4#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 19, 93892, "", "=q7=Brushed Breastplate of Might", "=ds=#s5#, #a4#", "#JUSTICE:870# #DARKMOON:44# #ITEM:69889:1#"};
				{ 20, 69889, "", "=q7=Burnished Breastplate of Might", "=ds=#s5#, #a4#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 21, 69888, "", "=q7=Burnished Legplates of Might", "=ds=#s11#, #a4#", "1,750 #gold#"};
				{ 23, 61931, "", "=q7=Polished Helm of Valor", "=ds=#s1#, #a4#", "1,500 #gold#"};
				{ 24, 93890, "", "=q7=Gleaming Spaulders of Valor", "=ds=#s3#, #a4#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42949:1#"};
				{ 25, 42949, "", "=q7=Polished Spaulders of Valor", "=ds=#s3#, #a4#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 26, 93891, "", "=q7=Gleaming Breastplate of Valor", "=ds=#s5#, #a4#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48685:1#"};
				{ 27, 48685, "", "=q7=Polished Breastplate of Valor", "=ds=#s5#, #a4#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 28, 62023, "", "=q7=Polished Legplates of Valor", "=ds=#s11#, #a4#", "1,750 #gold#"};
				extraText = ": "..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"];
			};
			{
				{ 1, 50255, "", "=q7=Dread Pirate Ring", "=ds=#s13#", "=ds="..AL["Kalu'ak Fishing Derby"]};
				{ 2, 93897, "", "=q7=Piercing Eye of the Beast", "=ds=#s14#", "#JUSTICE:1090# #DARKMOON:60# #ITEM:42992:1#"};
				{ 3, 42992, "", "=q7=Discerning Eye of the Beast", "=ds=#s14#", "#JUSTICE:2725# #CHAMPSEAL:75# #DARKMOON:130#"};
				{ 4, 93896, "", "=q7=Forceful Hand of Justice", "=ds=#s14#", "#JUSTICE:1090# #DARKMOON:60# #ITEM:42991:1#"};
				{ 5, 42991, "", "=q7=Swift Hand of Justice", "=ds=#s14#", "#JUSTICE:2725# #CHAMPSEAL:75# #DARKMOON:130#"};
				{ 6, 93857, "", "=q7=Vengeful Heartseeker", "=ds=#h1#, #w4#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42944:1#"};
				{ 7, 42944, "", "=q7=Balanced Heartseeker", "=ds=#h1#, #w4#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 8, 93845, "", "=q7=Gore-Steeped Skullforge Reaver", "=ds=#h1#, #w10#", "#JUSTICE:870# #DARKMOON:44# #ITEM:69893:1#"};
				{ 9, 69893, "", "=q7=Bloodsoaked Skullforge Reaver", "=ds=#h1#, #w10#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 10, 93856, "", "=q7=Noble Dal'Rend's Sacred Charge", "=ds=#h1#, #w10#", "#JUSTICE:870# #DARKMOON:44# #ITEM:42945:1#"};
				{ 11, 42945, "", "=q7=Venerable Dal'Rend's Sacred Charge", "=ds=#h1#, #w10#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 12, 93843, "", "=q7=Hardened Arcanite Reaper", "=ds=#h2#, #w1#", "#JUSTICE:1400# #DARKMOON:64# #ITEM:42943:1#"};
				{ 13, 42943, "", "=q7=Bloodied Arcanite Reaper", "=ds=#h2#, #w1#", "#JUSTICE:3500# #CHAMPSEAL:95# #DARKMOON:160#"};
				{ 14, 93853, "", "=q7=Pious Aurastone Hammer", "=ds=#h1#, #w6#", "#JUSTICE:1090# #DARKMOON:44# #ITEM:42948:1#"};
				{ 15, 42948, "", "=q7=Devout Aurastone Hammer", "=ds=#h1#, #w6#", "#JUSTICE:2725# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 16, 93847, "", "=q7=Crushing Mass of McGowan", "=ds=#h1#, #w6#", "#JUSTICE:870# #DARKMOON:44# #ITEM:48716:1#"};
				{ 17, 48716, "", "=q7=Venerable Mass of McGowan", "=ds=#h1#, #w6#", "#JUSTICE:2175# #CHAMPSEAL:60# #DARKMOON:110#"};
				{ 18, 93846, "", "=q7=Re-Engineered Lava Dredger", "=ds=#h2#, #w6#", "#JUSTICE:1400# #DARKMOON:64# #ITEM:48718:1#"};
				{ 19, 48718, "", "=q7=Repurposed Lava Dredger", "=ds=#h2#, #w6#", "#JUSTICE:3500# #CHAMPSEAL:95# #DARKMOON:160#"};
				{ 20, 93858, "", "=q7=Brawler's Bladed Claws", "=ds=#h1#, #w13#", "#JUSTICE:870# #ITEM:92948:1#" },
				{ 21, 92948, "", "=q7=Brawler's Razor Claws", "=ds=#h1#, #w13#", "#JUSTICE:2175#" },
				{ 22, 93844, "", "=q7=Refinished Warden Staff", "=ds=#w9#", "#JUSTICE:1400# #DARKMOON:64# #ITEM:79131:1#"};
				{ 23, 79131, "", "=q7=Burnished Warden Staff", "=ds=#w9#", "#JUSTICE:3500# #CHAMPSEAL:95# #DARKMOON:160#"};
				{ 24, 93854, "", "=q7=Scholarly Headmaster's Charge", "=ds=#w9#", "#JUSTICE:1400# #DARKMOON:64# #ITEM:42947:1#"};
				{ 25, 42947, "", "=q7=Dignified Headmaster's Charge", "=ds=#w9#", "#JUSTICE:3500# #CHAMPSEAL:95# #DARKMOON:160#"};
				{ 26, 93855, "", "=q7=War-Torn Ancient Bone Bow", "=ds=#w2#", "#JUSTICE:1400# #DARKMOON:64# #ITEM:42946:1#"};
				{ 27, 42946, "", "=q7=Charmed Ancient Bone Bow", "=ds=#w2#", "#JUSTICE:3500# #CHAMPSEAL:95# #DARKMOON:160#"};
				{ 28, 93902, "", "=q7=Flamescarred Draconian Deflector", "=ds=#w8#", "#JUSTICE:2175#"};
				{ 29, 93903, "", "=q7=Weathered Observer's Shield", "=ds=#w8#", "#JUSTICE:2175#"};
				{ 30, 93904, "", "=q7=Musty Tome of the Lost", "=ds=#s15#", "#JUSTICE:2175#"};
				extraText = ": "..AL["Accessories"].." / "..AL["Weapons"];
			};
			{
				{ 1, 93861, "", "=q7=Prestigious Sunderseer Mantle", "=ds=#s3#, #a1#", "#HONOR:870# #ITEM:44107:1#"};
				{ 2, 44107, "", "=q7=Exquisite Sunderseer Mantle", "=ds=#s3#, #a1#", "#HONOR:2175#"};
				{ 3, 93867, "", "=q7=Superior Stormshroud Shoulders", "=ds=#s3#, #a2#", "#HONOR:870# #ITEM:44103:1#"};
				{ 4, 44103, "", "=q7=Exceptional Stormshroud Shoulders", "=ds=#s3#, #a2#", "#HONOR:2175#"};
				{ 5, 93866, "", "=q7=Wild Feralheart Spaulders", "=ds=#s3#, #a2#", "#HONOR:870# #ITEM:44105:1#"};
				{ 6, 44105, "", "=q7=Lasting Feralheart Spaulders", "=ds=#s3#, #a2#", "#HONOR:2175#"};
				{ 7, 93889, "", "=q7=Venerated Pauldrons of The Five Thunders", "=ds=#s3#, #a3#", "#HONOR:870# #ITEM:44102:1#"};
				{ 8, 44102, "", "=q7=Aged Pauldrons of The Five Thunders", "=ds=#s3#, #a3#", "#HONOR:2175#"};
				{ 9, 93886, "", "=q7=Adorned Beastmaster's Mantle", "=ds=#s3#, #a3#", "#HONOR:870# #ITEM:44101:1#"};
				{ 10, 44101, "", "=q7=Prized Beastmaster's Mantle", "=ds=#s3#, #a3#", "#HONOR:2175#"};
				{ 11, 93894, "", "=q7=Immaculate Lightforge Spaulders", "=ds=#s3#, #a4#", "#HONOR:870# #ITEM:44100:1#"};
				{ 12, 44100, "", "=q7=Pristine Lightforge Spaulders", "=ds=#s3#, #a4#", "#HONOR:2175#"};
				{ 13, 93895, "", "=q7=Reinforced Stockade Pauldrons", "=ds=#s3#, #a4#", "#HONOR:870# #ITEM:44099:1#"};
				{ 14, 44099, "", "=q7=Strengthened Stockade Pauldrons", "=ds=#s3#, #a4#", "#HONOR:2175#"};
				{
					{ 15, 93898, "", "=q7=Bequeathed Insignia of the Horde", "=ds=#s14#", "#HONOR:1090# #ITEM:44097:1#"};
					{ 15, 93899, "", "=q7=Bequeathed Insignia of the Alliance", "=ds=#s14#", "#HONOR:1090# #ITEM:44098:1#"};
				};
				{
					{ 16, 44097, "", "=q7=Inherited Insignia of the Horde", "=ds=#s14#", "#HONOR:2725#"};
					{ 16, 44098, "", "=q7=Inherited Insignia of the Alliance", "=ds=#s14#", "#HONOR:2725#"};
				};
				{ 17, 93900, "", "=q7=Inherited Mark of Tyranny", "=ds=#s14#", "#HONOR:2725#"};
				{ 19, 93852, "", "=q7=Deadly Scarlet Kris", "=ds=#h1#, #w4#", "#HONOR:870# #ITEM:44091:1#"};
				{ 20, 44091, "", "=q7=Sharpened Scarlet Kris", "=ds=#h1#, #w4#", "#HONOR:2175#"};
				{ 21, 93848, "", "=q7=Battle-Hardened Thrash Blade", "=ds=#h1#, #w10#", "#HONOR:870# #ITEM:44096:1#"};
				{ 22, 44096, "", "=q7=Battleworn Thrash Blade", "=ds=#h1#, #w10#", "#HONOR:2175#"};
				{ 23, 93851, "", "=q7=Battle-Forged Truesilver Champion", "=ds=#h2#, #w10#", "#HONOR:1400# #ITEM:44092:1#"};
				{ 24, 44092, "", "=q7=Reforged Truesilver Champion", "=ds=#h2#, #w10#", "#HONOR:3500#"};
				{ 25, 93850, "", "=q7=The Sanctified Hammer of Grace", "=ds=#h1#, #w6#", "#HONOR:1090# #ITEM:44094:1#"};
				{ 26, 44094, "", "=q7=The Blessed Hammer of Grace", "=ds=#h1#, #w6#", "#HONOR:2725#"};
				{ 27, 93849, "", "=q7=Elder Staff of Jordan", "=ds=#w9#", "#HONOR:1400# #ITEM:44095:1#"};
				{ 28, 44095, "", "=q7=Grand Staff of Jordan", "=ds=#w9#", "#HONOR:3500#"};
				{ 29, 93841, "", "=q7=Smoothbore Dwarven Hand Cannon", "=ds=#w5#", "#HONOR:1400# #ITEM:44093:1#"};
				{ 30, 44093, "", "=q7=Upgraded Dwarven Hand Cannon", "=ds=#w5#", "#HONOR:3500#"};
				extraText = ": "..AL["PvP Heirlooms"];
			};
		};
		info = {
			name = AL["Heirloom"],
			module = moduleName, menu = "HEIRLOOMMENU",
		};
	}

	AtlasLoot_Data["HeirloomBoAArmor"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..string.format(AL["Level %s"], "85-89"), "=q1="..AL["Mists of Pandaria"]};
				{ 2, 86521, "", "=q3=Lucid Amulet of the Agile Mind", "=ds=#s2#"};
				{ 3, 89611, "", "=q3=Quilen Statuette", "=ds=#s14#"};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Level 85"], "=q1="..AL["Cataclysm"]};
				{ 6, 64904, "", "=q4=Ring of the Boy Emperor", "=ds=#s13#"};
				{ 7, 64645, "", "=q4=Tyrande's Favorite Doll", "=ds=#s14#"};
				{ 16, 0, "INV_Box_01", "=q6="..string.format(AL["Level %s"], "60-69"), ""};
				{ 17, 64644, "", "=q4=Headdress of the First Shaman", "=ds=#s1#, #a3#"};
				{ 19, 0, "INV_Box_01", "=q6="..string.format(AL["Level %s"], "50-60"), ""};
				{ 20, 64643, "", "=q4=Queen Azshara's Dressing Gown", "=ds=#s5#, #a1#"};
			};
		};
		info = {
			name = AL["Bind on Account Armor"],
			module = moduleName, menu = "HEIRLOOMMENU",
		};
	}

	AtlasLoot_Data["HeirloomBoAWeapons"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Level 90"], "=q1="..AL["Mists of Pandaria"]};
				{ 2, 79340, "", "=q4=Inscribed Crane Staff", "=ds=#w9#"};
				{ 3, 79341, "", "=q4=Inscribed Serpent Staff", "=ds=#w9#"};
				{ 4, 79343, "", "=q4=Inscribed Tiger Staff", "=ds=#w9#"};
				{ 6, 0, "INV_Box_01", "=q6="..string.format(AL["Level %s"], "85-89"), "=q1="..AL["Mists of Pandaria"]};
				{ 7, 85776, "", "=q3=Wodin's Mantid Shanker", "=ds=#h1#, #w4#"};
				{ 8, 86519, "", "=q3=Wind-Reaver's Dagger of Quick Strikes", "=ds=#h1#, #w4#"};
				{ 9, 86527, "", "=q3=Blade of the Poisoned Mind", "=ds=#h1#, #w10#"};
				{ 10, 86199, "", "=q3=Jade Infused Blade", "=ds=#h1#, #w10#"};
				{ 11, 86522, "", "=q3=Blade of the Prime", "=ds=#h1#, #w10#"};
				{ 12, 95391, "", "=q3=Mantid Sky Reaver", "=ds=#h1#, #w10#"};
				{ 13, 86523, "", "=q3=Swarming Cleaver of Ka'roz", "=ds=#h2#, #w10#"};
				{ 14, 85777, "", "=q3=Ancient Pandaren Mining Pick", "=ds=#h1#, #w1#"};
				{ 15, 86518, "", "=q3=Yaungol Fire Carrier", "=ds=#h1#, #w6#"};
				{ 16, 86198, "", "=q3=Hammer of Ten Thunders", "=ds=#h2#, #w6#"};
				{ 17, 86124, "", "=q3=Pandaren Fishing Spear", "=ds=#w7#"};
				{ 18, 86394, "", "=q3=Hozen Warrior Spear", "=ds=#w7#"};
				{ 19, 89685, "", "=q3=Spear of Xuen", "=ds=#w7#"};
				{ 20, 88723, "", "=q3=Sturdy Yaungol Spear", "=ds=#w7#"};
				{ 21, 86520, "", "=q3=Malik's Stalwart Spear", "=ds=#w7#"};
				{ 22, 86196, "", "=q3=Ancient Jinyu Staff", "=ds=#w9#"};
				{ 23, 86218, "", "=q3=Staff of the Hidden Master", "=ds=#w9#"};
				{ 24, 86524, "", "=q3=Dissector's Staff of Mutation", "=ds=#w9#"};
				{ 25, 95392, "", "=q3=Sonic Pulse Generator", "=ds=#w5#"};
				{ 26, 89684, "", "=q3=Umbrella of Chi-Ji", "=ds=#s15#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Level 85"], "=q1="..AL["Cataclysm"]};
				{ 2, 64885, "", "=q4=Scimitar of the Sirocco", "=ds=#h1#, #w10#"};
				{ 3, 64377, "", "=q4=Zin'rokh, Destroyer of Worlds", "=ds=#h2#, #w10#"};
				{ 4, 64880, "", "=q4=Staff of Ammunae", "=ds=#w9#"};
				{ 5, 64489, "", "=q4=Staff of Sorcerer-Thane Thaurissan", "=ds=#w9#"};
				{ 6, 69764, "", "=q4=Extinct Turtle Shell", "=ds=#w8#"};
				{ 16, 0, "INV_Box_01", "=q6="..string.format(AL["Level %s"], "70-79"), ""};
				{ 17, 64460, "", "=q4=Nifflevar Bearded Axe", "=ds=#h1#, #w1#"};
			};
		};
		info = {
			name = AL["Bind on Account Weapons"],
			module = moduleName, menu = "HEIRLOOMMENU",
		};
	}

	AtlasLoot_Data["HeirloomBoAMisc"] = {
		["Normal"] = {
			{
				{ 1, 64881, "", "=q4=Pendant of the Scarab Storm", "=ds="};
				{ 2, 33079, "", "=q3=Murloc Costume", "#ACHIEVEMENTID:412#"};
				{ 4, 92738, "", "=q3=Safari Hat", "=ds=#s1#", "#ACHIEVEMENTID:7499#"};
				{ 6, 86574, "", "=q3=Elixir of Ancient Knowledge", "=ds="};
				{ 8, 69210, "", "=q4=Renowned Guild Tabard", "=ds=#s7#"};
				{ 9, 69209, "", "=q3=Illustrious Guild Tabard", "=ds=#s7#"};
				{ 16, 95490, "", "=q3=Greater Kirin Tor Offensive Insignia", "=ds=", ""};
				{ 17, 95488, "", "=q3=Greater Sunreaver Onslaught Insignia", "=ds=", ""};
				{ 18, 95489, "", "=q3=Kirin Tor Offensive Insignia", "=ds=", ""};
				{ 19, 95496, "", "=q3=Shado-Pan Assault Insignia", "=ds=", ""};
				{ 20, 94225, "", "=q3=Stolen Celestial Insignia", "=ds=", ""};
				{ 21, 94227, "", "=q3=Stolen Golden Lotus Insignia", "=ds=", ""};
				{ 22, 94226, "", "=q3=Stolen Klaxxi Insignia", "=ds=", ""};
				{ 23, 94223, "", "=q3=Stolen Shado-Pan Insignia", "=ds=", ""};
				{ 24, 95487, "", "=q3=Sunreaver Onslaught Insignia", "=ds=", ""};
				{ 25, 63517, "", "=q2=Baradin's Wardens Commendation", "=ds=", "#TOLBARAD:10#"};
				{ 26, 63518, "", "=q2=Hellscream's Reach Commendation", "=ds=", "#TOLBARAD:10#"};
			};
			{
				{ 1, 92679, "", "=q3=Flawless Aquatic Battle-Stone", "=ds=", ""};
				{ 2, 92675, "", "=q3=Flawless Beast Battle-Stone", "=ds=", ""};
				{ 3, 92676, "", "=q3=Flawless Critter Battle-Stone", "=ds=", ""};
				{ 4, 92683, "", "=q3=Flawless Dragonkin Battle-Stone", "=ds=", ""};
				{ 5, 92665, "", "=q3=Flawless Elemental Battle-Stone", "=ds=", ""};
				{ 6, 92677, "", "=q3=Flawless Flying Battle-Stone", "=ds=", ""};
				{ 7, 92682, "", "=q3=Flawless Humanoid Battle-Stone", "=ds=", ""};
				{ 8, 92678, "", "=q3=Flawless Magic Battle-Stone", "=ds=", ""};
				{ 9, 92680, "", "=q3=Flawless Mechanical Battle-Stone", "=ds=", ""};
				{ 10, 92681, "", "=q3=Flawless Undead Battle-Stone", "=ds=", ""};
				{ 11, 98715, "", "=q3=Marked Flawless Battle-Stone", "#ACHIEVEMENTID:8348#", ""};
			};
		};
		info = {
			name = AL["Bind on Account"], --- Name not final
			module = moduleName, menu = "HEIRLOOMMENU",
		};
	}

		-----------------------
		--- BoE World Epics ---
		-----------------------

	AtlasLoot_Data["WorldEpics90"] = {
		["Normal"] = {
			{
				{ 1, 90580, "", "=q4=Cristof's Crushing Cloak", "=ds=#s4#"};
				{ 2, 90589, "", "=q4=Dirl's Drafty Drape", "=ds=#s4#"};
				{ 3, 90586, "", "=q4=Dory's Pageantry", "=ds=#s4#"};
				{ 4, 90578, "", "=q4=Zom's Rain-Stained Cloak", "=ds=#s4#"};
				{ 5, 90573, "", "=q4=Wang's Unshakable Smile", "=ds=#s1#, #a1#"};
				{ 6, 90587, "", "=q4=Natli's Fireheart Robe", "=ds=#s5#, #a1#"};
				{ 7, 90574, "", "=q4=Etoshia's Elegant Gloves", "=ds=#s9#, #a1#"};
				{ 8, 90588, "", "=q4=Rittsyn's Ruinblasters", "=ds=#s9#, #a1#"};
				{ 9, 90585, "", "=q4=Vulajin's Vicious Breastplate", "=ds=#s5#, #a2#"};
				{ 10, 90572, "", "=q4=Kilt of Pandaren Promises", "=ds=#s11#, #a3#"};
				{ 11, 90570, "", "=q4=Legguards of Sleeting Arrows", "=ds=#s11#, #a3#"};
				{ 12, 87695, "", "=q4=Treads of Edward the Odd", "=ds=#s12#, #a3#"};
				{ 13, 90576, "", "=q4=Spaulders of the Scorned", "=ds=#s3#, #a4#"};
				{ 14, 90577, "", "=q4=Boblet's Bouncing Hauberk", "=ds=#s5#, #a4#"};
				{ 15, 90579, "", "=q4=Legplates of Durable Dreams", "=ds=#s11#, #a4#"};
				{ 16, 90582, "", "=q4=Buc-Zakai Memento", "=ds=#s2#"};
				{ 17, 90583, "", "=q4=Don Guerrero's Glorious Choker", "=ds=#s2#"};
				{ 18, 90590, "", "=q4=Dorian's Necklace of Burgeoning Dreams", "=ds=#s2#"};
				{ 20, 90581, "", "=q4=Jan-Ho's Unwavering Seal", "=ds=#s13#"};
				{ 21, 90584, "", "=q4=Perculia's Peculiar Signet", "=ds=#s13#"};
				{ 22, 90591, "", "=q4=Ring of the Shipwrecked Prince", "=ds=#s13#"};
				{ 24, 90571, "", "=q4=Scroll of Whispered Secrets", "=ds=#s15#"};
				{ 25, 90575, "", "=q4=Sutiru's Brazen Bulwark", "=ds=#w8#"};
			};
			{
				{ 1, 0, "inv_misc_bag_12", "=q6="..ALIL["Big Bag of Arms"].." / "..ALIL["Big Bag of Mysteries"], "=q2="..ALIL["Kah'tir"].." / "..ALIL["Norlaxx"]..", =q1="..ALIL["Dread Wastes"]};
				{ 2, 90721, "", "=q4=Courinth Waterstrider's Silken Finery", "=ds=#s11#, #a1#", "=q2="..ALIL["Cournith Waterstrider"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 3, 90725, "", "=q4=Gaarn's Leggings of Infestation", "=ds=#s11#, #a1#", "=q2="..ALIL["Gaarn the Toxic"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 4, 90720, "", "=q4=Silent Leggings of the Ghostpaw", "=ds=#s11#, #a2#", "=q2="..ALIL["Ruun Ghostpaw"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 5, 90724, "", "=q4=Spriggin's Sproggin' Leggin'", "=ds=#s11#, #a2#", "=q2="..ALIL["Spriggin"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 6, 90723, "", "=q4=Arness's Scaled Leggings", "=ds=#s11#, #a3#", "=q2="..ALIL["Arness the Scale"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 7, 90719, "", "=q4=Go-Kan's Golden Trousers", "=ds=#s11#, #a3#", "=q2="..ALIL["Go-Kan"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 8, 90722, "", "=q4=Torik-Ethis' Gilded Legplates", "=ds=#s11#, #a3#"};
				{ 9, 90717, "", "=q4=Qu'nas' Apocryphal Legplates", "=ds=#s11#, #a4#", "=q2="..ALIL["Qu'nas"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 10, 90718, "", "=q4=Torik-Ethis' Bloodied Legguards", "=ds=#s11#, #a4#", "=q2="..ALIL["Torik-Ethis"]..", =q1="..ALIL["Krasarang Wilds"]};
				{ 11, 87650, "", "=q4=Fishsticker Crossbow", "=ds=#w3#", "=q2="..ALIL["Sarnak"]..", =q1="..ALIL["The Jade Forest"]};
				{ 12, 87641, "", "=q4=Yaungol Battle Barrier", "=ds=#w8#"};
				{ 16, 0, "inv_box_03", "=q6="..ALIL["Vine-Cracked Junkbox"], "=q1=#p28#"};
				{ 17, 88149, "", "=q4=The Gloaming Blade", "=ds=#h1#, #w4#"};
				{ 18, 88150, "", "=q4=Krol Scimitar", "=ds=#h1#, #w10#"};
			};
		};
		info = {
			name = AL["BoE World Epics"].." "..AL["Level 90"],
			module = moduleName, menu = "WORLDEPICS", instance = "WorldEpics",
		};
	}

		----------------------------
		--- Justice Points Items ---
		----------------------------

	AtlasLoot_Data["JusticePointsMoP"] = {
		["Normal"] = {
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 93330, "", "=q4=Chang's Changing Cord", "=ds=#s10#, #a1#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 2, 93339, "", "=q4=Bon-iy's Unbreakable Cord", "=ds=#s10#, #a1#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 3, 93271, "", "=q4=Beach-Born Sandals", "=ds=#s12#, #a1#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 3, 93280, "", "=q4=Sandals of Oiled Silk", "=ds=#s12#, #a1#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 5, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 6, 89337, "", "=q4=Firecracker Corona", "=ds=#s1#, #a1#", "#JUSTICE:2250#" },
				{ 7, 89340, "", "=q4=Mantle of the Golden Sun", "=ds=#s3#, #a1#", "#JUSTICE:1750#" },
				{ 8, 89433, "", "=q4=Vestments of Thundering Skies", "=ds=#s5#, #a1#", "#JUSTICE:2250#" },
				{ 9, 88893, "", "=q4=Minh's Beaten Bracers", "=ds=#s8#, #a1#", "#JUSTICE:1250#" },
				{ 10, 88742, "", "=q4=Sunspeaker's Flared Gloves", "=ds=#s9#, #a1#", "#JUSTICE:1750#" },
				{ 11, 89062, "", "=q4=Klaxxi Lash of the Orator", "=ds=#s10#, #a1#", "#JUSTICE:1750#" },
				{ 12, 89088, "", "=q4=Leggings of the Poisoned Soul", "=ds=#s11#, #a1#", "#JUSTICE:2250#" },
				{ 13, 88878, "", "=q4=Void Flame Slippers", "=ds=#s12#, #a1#", "#JUSTICE:1750#" },
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 17, 93331, "", "=q4=Sash of Surehandedness", "=ds=#s10#, #a1#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 17, 93340, "", "=q4=Sash of Bouncing Power", "=ds=#s10#, #a1#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 18, 93270, "", "=q4=Slippers of Soothing Balm", "=ds=#s12#, #a1#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 18, 93279, "", "=q4=Shieldwarden Slippers", "=ds=#s12#, #a1#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 20, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 21, 89338, "", "=q4=Yalia's Cowl", "=ds=#s1#, #a1#", "#JUSTICE:2250#" },
				{ 22, 89339, "", "=q4=Tenderheart Shoulders", "=ds=#s3#, #a1#", "#JUSTICE:1750#" },
				{ 23, 89434, "", "=q4=Robe of the Five Sisters", "=ds=#s5#, #a1#", "#JUSTICE:2250#" },
				{ 24, 88892, "", "=q4=Bracers of Inlaid Jade", "=ds=#s8#, #a1#", "#JUSTICE:1250#" },
				{ 25, 88741, "", "=q4=Gloves of Red Feathers", "=ds=#s9#, #a1#", "#JUSTICE:1750#" },
				{ 26, 89063, "", "=q4=Klaxxi Lash of the Seeker", "=ds=#s10#, #a1#", "#JUSTICE:1750#" },
				{ 27, 89087, "", "=q4=Poisoncrafter's Kilt", "=ds=#s11#, #a1#", "#JUSTICE:2250#" },
				{ 28, 88877, "", "=q4=Storm-Sing Sandals", "=ds=#s12#, #a1#", "#JUSTICE:1750#" },
				extraText = ": "..BabbleInventory["Cloth"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 93328, "", "=q4=Prevenge's Dagger-Carrier", "=ds=#s10#, #a2#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 2, 93337, "", "=q4=Prevenge's Swashbuckling Cinch", "=ds=#s10#, #a2#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 3, 93269, "", "=q4=Troll-Toe Tabi", "=ds=#s12#, #a2#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 3, 93278, "", "=q4=Crab-Leather Tabi", "=ds=#s12#, #a2#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 5, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 6, 89300, "", "=q4=Red Smoke Bandana", "=ds=#s1#, #a2#", "#JUSTICE:2250#" },
				{ 7, 89341, "", "=q4=Imperion Spaulders", "=ds=#s3#, #a2#", "#JUSTICE:1750#" },
				{ 8, 89431, "", "=q4=Softfoot Silentwrap", "=ds=#s5#, #a2#", "#JUSTICE:2250#" },
				{ 9, 88884, "", "=q4=Quillpaw Family Bracers", "=ds=#s8#, #a2#", "#JUSTICE:1250#" },
				{ 10, 88744, "", "=q4=Fingers of the Loneliest Monk", "=ds=#s9#, #a2#", "#JUSTICE:1750#" },
				{ 11, 89060, "", "=q4=Klaxxi Lash of the Borrower", "=ds=#s10#, #a2#", "#JUSTICE:1750#" },
				{ 12, 89090, "", "=q4=Dreadsworn Slayer Legs", "=ds=#s11#, #a2#", "#JUSTICE:2250#" },
				{ 13, 88868, "", "=q4=Tukka-Tuk's Hairy Boots", "=ds=#s12#, #a2#", "#JUSTICE:1750#" },
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 17, 93329, "", "=q4=Bambrick's Striking Strap", "=ds=#s10#, #a2#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 17, 93338, "", "=q4=Soothing Straps", "=ds=#s10#, #a2#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 18, 93268, "", "=q4=Treads of Rejuvenating Mists", "=ds=#s12#, #a2#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 18, 93277, "", "=q4=Statue Summoner's Treads", "=ds=#s12#, #a2#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 20, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 21, 89308, "", "=q4=Snowdrift Helm", "=ds=#s1#, #a2#", "#JUSTICE:2250#" },
				{ 22, 89342, "", "=q4=Whitepetal Shouldergarb", "=ds=#s3#, #a2#", "#JUSTICE:1750#" },
				{ 23, 89432, "", "=q4=Mistfall Robes", "=ds=#s5#, #a2#", "#JUSTICE:2250#" },
				{ 24, 88885, "", "=q4=Clever Ashyo's Armbands", "=ds=#s8#, #a2#", "#JUSTICE:1250#" },
				{ 25, 88743, "", "=q4=Ogo's Elder Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1750#" },
				{ 26, 89061, "", "=q4=Klaxxi Lash of the Harbinger", "=ds=#s10#, #a2#", "#JUSTICE:1750#" },
				{ 27, 89089, "", "=q4=Wind-Reaver Greaves", "=ds=#s11#, #a2#", "#JUSTICE:2250#" },
				{ 28, 88876, "", "=q4=Boots of the High Adept", "=ds=#s12#, #a2#", "#JUSTICE:1750#" },
				extraText = ": "..BabbleInventory["Leather"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 458), ""};
				{ 2, 89673, "", "=q3=Robe of Eternal Dynasty", "=ds=#s5#, #a1#", "#JUSTICE:565#"};
				{ 3, 89672, "", "=q3=Robe of Quiet Meditation", "=ds=#s5#, #a1#", "#JUSTICE:565#"};
				{ 4, 89642, "", "=q3=Bracers of Eternal Resolve", "=ds=#s8#, #a1#", "#JUSTICE:315#"};
				{ 5, 89643, "", "=q3=Tranquility Bindings", "=ds=#s8#, #a1#", "#JUSTICE:315#"};
				{ 6, 89650, "", "=q3=Emperor's Riding Gloves", "=ds=#s9#, #a1#", "#JUSTICE:440#"};
				{ 7, 89651, "", "=q3=Krompf's Fine-Tuning Gloves", "=ds=#s9#, #a1#", "#JUSTICE:440#"};
				{ 8, 89659, "", "=q3=Leggings of Unfinished Conquest", "=ds=#s11#, #a1#", "#JUSTICE:565#"};
				{ 9, 89658, "", "=q3=Subversive Leggings", "=ds=#s11#, #a1#", "#JUSTICE:565#"};
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 458), ""};
				{ 17, 89667, "", "=q3=Refurbished Zandalari Vestment", "=ds=#s5#, #a2#", "#JUSTICE:565#"};
				{ 18, 89666, "", "=q3=Vestment of the Ascendant Tribe", "=ds=#s5#, #a2#", "#JUSTICE:565#"};
				{ 19, 89645, "", "=q3=Cruel Mercy Bracers", "=ds=#s8#, #a2#", "#JUSTICE:315#"};
				{ 20, 89644, "", "=q3=Sudden Insight Bracers", "=ds=#s8#, #a2#", "#JUSTICE:315#"};
				{ 21, 89653, "", "=q3=Surehand Grips", "=ds=#s9#, #a2#", "#JUSTICE:440#"};
				{ 22, 89652, "", "=q3=Wandering Friar's Gloves", "=ds=#s9#, #a2#", "#JUSTICE:440#"};
				{ 23, 89660, "", "=q3=Brambleguard Leggings", "=ds=#s11#, #a2#", "#JUSTICE:565#"};
				{ 24, 89661, "", "=q3=Tough Mushanhide Leggings", "=ds=#s11#, #a2#", "#JUSTICE:565#"};
				extraText = ": "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 93326, "", "=q4=Shigi's Chain of Cheerful Summons", "=ds=#s10#, #a3#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 2, 93335, "", "=q4=Chain of Flaming Arrows", "=ds=#s10#, #a3#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 3, 93267, "", "=q4=Greaves of Manifest Destiny", "=ds=#s12#, #a3#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 3, 93276, "", "=q4=Odlaw's Everwalkers", "=ds=#s12#, #a3#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 5, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 6, 89291, "", "=q4=Hawkmaster's Headguard", "=ds=#s1#, #a3#", "#JUSTICE:2250#" },
				{ 7, 89344, "", "=q4=Windwalker Spaulders", "=ds=#s3#, #a3#", "#JUSTICE:1750#" },
				{ 8, 89430, "", "=q4=Breastplate of the Golden Pagoda", "=ds=#s5#, #a3#", "#JUSTICE:2250#" },
				{ 9, 88882, "", "=q4=Tiger-Striped Wristguards", "=ds=#s8#, #a3#", "#JUSTICE:1250#" },
				{ 10, 88745, "", "=q4=Sentinel Commander's Gauntlets", "=ds=#s9#, #a3#", "#JUSTICE:1750#" },
				{ 11, 89058, "", "=q4=Klaxxi Lash of the Winnower", "=ds=#s10#, #a3#", "#JUSTICE:1750#" },
				{ 12, 89092, "", "=q4=Locust Swarm Legguards", "=ds=#s11#, #a3#", "#JUSTICE:2250#" },
				{ 13, 88866, "", "=q4=Steps of the War Serpent", "=ds=#s12#, #a3#", "#JUSTICE:1750#" },
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 17, 93327, "", "=q4=Bloodbinder Links", "=ds=#s10#, #a3#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 17, 93336, "", "=q4=Links of Bonded Blood", "=ds=#s10#, #a3#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 18, 93266, "", "=q4=Boots of the Healing Stream", "=ds=#s12#, #a3#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 18, 93275, "", "=q4=Totem-Binder Boots", "=ds=#s12#, #a3#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 20, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 21, 89296, "", "=q4=Nightwatcher's Helm", "=ds=#s1#, #a3#", "#JUSTICE:2250#" },
				{ 22, 89343, "", "=q4=Mindbender Shoulders", "=ds=#s3#, #a3#", "#JUSTICE:1750#" },
				{ 23, 89429, "", "=q4=Robes of the Setting Sun", "=ds=#s5#, #a3#", "#JUSTICE:2250#" },
				{ 24, 88883, "", "=q4=Brewmaster Chani's Bracers", "=ds=#s8#, #a3#", "#JUSTICE:1250#" },
				{ 25, 88748, "", "=q4=Ravenmane's Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1750#" },
				{ 26, 89059, "", "=q4=Klaxxi Lash of the Precursor", "=ds=#s10#, #a3#", "#JUSTICE:1750#" },
				{ 27, 89091, "", "=q4=Swarmkeeper's Leggings", "=ds=#s11#, #a3#", "#JUSTICE:2250#" },
				{ 28, 88867, "", "=q4=Sandals of the Elder Sage", "=ds=#s12#, #a3#", "#JUSTICE:1750#" },
				extraText = ": "..BabbleInventory["Mail"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 93323, "", "=q4=Kwon's Crushing Girdle", "=ds=#s10#, #a4#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 2, 93332, "", "=q4=Girdle of Crushing Strength", "=ds=#s10#, #a4#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 3, 93264, "", "=q4=Cragchewer Sollerets", "=ds=#s12#, #a4#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 3, 93273, "", "=q4=Sea-Soaked Sollerets", "=ds=#s12#, #a4#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 5, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 6, 89280, "", "=q4=Voice Amplyifying Greathelm", "=ds=#s1#, #a4#", "#JUSTICE:2250#" },
				{ 7, 89345, "", "=q4=Stonetoe Spaulders", "=ds=#s3#, #a4#", "#JUSTICE:1750#" },
				{ 8, 89420, "", "=q4=Dawnblade's Chestguard", "=ds=#s5#, #a4#", "#JUSTICE:2250#" },
				{ 9, 88879, "", "=q4=Braided Black and White Bracer", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 10, 88747, "", "=q4=Streetfighter's Iron Knuckles", "=ds=#s9#, #a4#", "#JUSTICE:1750#" },
				{ 11, 89055, "", "=q4=Klaxxi Lash of the Rescinder", "=ds=#s10#, #a4#", "#JUSTICE:1750#" },
				{ 12, 89095, "", "=q4=Legguards of the Unscathed", "=ds=#s11#, #a4#", "#JUSTICE:2250#" },
				{ 13, 88862, "", "=q4=Tankiss Warstompers", "=ds=#s12#, #a4#", "#JUSTICE:1750#" },
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 17, 93324, "", "=q4=Immovable Waistplate", "=ds=#s10#, #a4#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 17, 93333, "", "=q4=Waistplate of Immobility", "=ds=#s10#, #a4#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 18, 93263, "", "=q4=Groundbreaker Sabatons", "=ds=#s12#, #a4#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 18, 93272, "", "=q4=Sabatons of the Sullied Shore", "=ds=#s12#, #a4#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 20, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 21, 89216, "", "=q4=Yi's Least Favorite Helmet", "=ds=#s1#, #a4#", "#JUSTICE:2250#" },
				{ 22, 89346, "", "=q4=Shoulders of Autumnlight", "=ds=#s3#, #a4#", "#JUSTICE:1750#" },
				{ 23, 89421, "", "=q4=Cuirass of the Twin Monoliths", "=ds=#s5#, #a4#", "#JUSTICE:2250#" },
				{ 24, 88880, "", "=q4=Battle Shadow Bracers", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 25, 88746, "", "=q4=Gloves of the Overwhelming Swarm", "=ds=#s9#, #a4#", "#JUSTICE:1750#" },
				{ 26, 89056, "", "=q4=Klaxxi Lash of the Consumer", "=ds=#s10#, #a4#", "#JUSTICE:1750#" },
				{ 27, 89093, "", "=q4=Kovok's Riven Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2250#" },
				{ 28, 88864, "", "=q4=Yu'lon Guardian Boots", "=ds=#s12#, #a4#", "#JUSTICE:1750#" },
				extraText = ": "..BabbleInventory["Plate"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 93325, "", "=q4=Divide's Greatheart Clasp", "=ds=#s10#, #a4#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 2, 93334, "", "=q4=Divide's Loyal Clasp", "=ds=#s10#, #a4#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 3, 93265, "", "=q4=Scar Swallower Greatboots", "=ds=#s12#, #a4#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 3, 93274, "", "=q4=Greatboots of Flashing Light", "=ds=#s12#, #a4#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{ 5, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 6, 89096, "", "=q4=Six Pool's Open Helm", "=ds=#s1#, #a4#", "#JUSTICE:2250#" },
				{ 7, 89347, "", "=q4=Paleblade Shoulderguards", "=ds=#s3#, #a4#", "#JUSTICE:1750#" },
				{ 8, 89423, "", "=q4=Battleguard of Guo-Lai", "=ds=#s5#, #a4#", "#JUSTICE:2250#" },
				{ 9, 88881, "", "=q4=Fallen Sentinel Bracers", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 10, 88749, "", "=q4=Gauntlets of Jade Sutras", "=ds=#s9#, #a4#", "#JUSTICE:1750#" },
				{ 11, 89057, "", "=q4=Klaxxi Lash of the Doubter", "=ds=#s10#, #a4#", "#JUSTICE:1750#" },
				{ 12, 89094, "", "=q4=Ambersmith Legplates", "=ds=#s11#, #a4#", "#JUSTICE:2250#" },
				{ 13, 88865, "", "=q4=Bramblestaff Boots", "=ds=#s12#, #a4#", "#JUSTICE:1750#" },
				extraText = ": "..BabbleInventory["Plate"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 458), ""};
				{ 2, 89668, "", "=q3=Mountain Stream Ringmail", "=ds=#s5#, #a3#", "#JUSTICE:565#"};
				{ 3, 89669, "", "=q3=Undergrowth Stalker Chestpiece", "=ds=#s5#, #a3#", "#JUSTICE:565#"};
				{ 4, 89647, "", "=q3=Entombed Traitor's Wristguards", "=ds=#s8#, #a3#", "#JUSTICE:315#"};
				{ 5, 89646, "", "=q3=Runoff Wristguards", "=ds=#s8#, #a3#", "#JUSTICE:315#"};
				{ 6, 89655, "", "=q3=Brushcutter's Gloves", "=ds=#s9#, #a3#", "#JUSTICE:440#"};
				{ 7, 89654, "", "=q3=Gloves of Forgotten Wisdom", "=ds=#s9#, #a3#", "#JUSTICE:440#"};
				{ 8, 89663, "", "=q3=Leggings of Twisted Vines", "=ds=#s11#, #a3#", "#JUSTICE:565#"};
				{ 9, 89662, "", "=q3=Snowpack Waders", "=ds=#s11#, #a3#", "#JUSTICE:565#"};
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 458), ""};
				{ 17, 89671, "", "=q3=Chestplate of the Stone Lion", "=ds=#s5#, #a4#", "#JUSTICE:565#"};
				{ 18, 89670, "", "=q3=Inner Serenity Chestplate", "=ds=#s5#, #a4#", "#JUSTICE:565#"};
				{ 19, 89648, "", "=q3=Bracers of Inner Light", "=ds=#s8#, #a4#", "#JUSTICE:315#"};
				{ 20, 89649, "", "=q3=Serrated Forearm Guards", "=ds=#s8#, #a4#", "#JUSTICE:315#"};
				{ 21, 89656, "", "=q3=Gauntlets of Restraint", "=ds=#s9#, #a4#", "#JUSTICE:440#"};
				{ 22, 89657, "", "=q3=Wall Breaker Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:440#"};
				{ 23, 89665, "", "=q3=Leggings of Ponderous Advance", "=ds=#s11#, #a4#", "#JUSTICE:565#"};
				{ 24, 89664, "", "=q3=Valiant's Shinguards", "=ds=#s11#, #a4#", "#JUSTICE:565#"};
				extraText = ": "..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 97212, "", "=q4=Cloak of the Immortal Guardian", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 2, 97207, "", "=q4=Cloak of the Immortal Guardian", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 3, 97210, "", "=q4=Shan'ze Gravetender Cloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 3, 97205, "", "=q4=Shan'ze Gravetender Cloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 4, 97211, "", "=q4=Shan'ze Partisan's Greatcloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 4, 97206, "", "=q4=Shan'ze Partisan's Greatcloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 5, 97209, "", "=q4=Static-Collecting Cloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 5, 97204, "", "=q4=Static-Collecting Cloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 6, 97208, "", "=q4=Thunder-Chaser Cloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 6, 97203, "", "=q4=Thunder-Chaser Cloak", "=ds=#s4#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{ 8, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 9, 89076, "", "=q4=Blackguard Cape", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 10, 89077, "", "=q4=Cloak of Snow Blossoms", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 11, 89074, "", "=q4=Cloak of the Dark Disciple", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 12, 89078, "", "=q4=Sagewhisper's Wrap", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 13, 89075, "", "=q4=Yi's Cloak of Courage", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 17, 89065, "", "=q4=Choker of the Klaxxi'va", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 18, 89064, "", "=q4=Bloodseeker's Solitaire", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 19, 89067, "", "=q4=Links of the Lucid", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 20, 89066, "", "=q4=Paragon's Pale Pendant", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 21, 89068, "", "=q4=Wire of the Wakener", "=ds=#s2#", "#JUSTICE:1250#" },
				extraText = ": "..AL["Accessories"]..": "..BabbleInventory["Back"].." / "..BabbleInventory["Neck"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 2, 97196, "", "=q4=Ancient Overlord's Onyx Band", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 2, 97191, "", "=q4=Ancient Overlord's Onyx Band", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 3, 97194, "", "=q4=Ancient Primalist's Seal", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 3, 97189, "", "=q4=Ancient Primalist's Seal", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 4, 97192, "", "=q4=Refurbished Band of Jin", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 4, 97187, "", "=q4=Refurbished Band of Jin", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 5, 97195, "", "=q4=Refurbished Seal of Jin", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 5, 97190, "", "=q4=Refurbished Seal of Jin", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{
					{ 6, 97193, "", "=q4=Restored Hexxer's Signet", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Sunreaver Onslaught"] },
					{ 6, 97188, "", "=q4=Restored Hexxer's Signet", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Kirin Tor Offensive"] },
				};
				{ 8, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 9, 93249, "", "=q4=Dominator's Band", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Dominance Offensive"] };
					{ 9, 93244, "", "=q4=Band of the Shieldwall", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 10, 93251, "", "=q4=Dominator's Circle", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Dominance Offensive"] };
					{ 10, 93246, "", "=q4=Circle of the Shieldwall", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 11, 93250, "", "=q4=Dominator's Loop", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Dominance Offensive"] };
					{ 11, 93245, "", "=q4=Loop of the Shieldwall", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 12, 93252, "", "=q4=Dominator's Seal", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Dominance Offensive"] };
					{ 12, 93247, "", "=q4=Seal of the Shieldwall", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 13, 93248, "", "=q4=Dominator's Signet", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Dominance Offensive"] };
					{ 13, 93243, "", "=q4=Signet of the Shieldwall", "=ds=#s13#", "#JUSTICE:1250#"..ALIL["Operation: Shieldwall"] };
				};
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 496), ""};
				{
					{ 17, 93255, "", "=q4=Cutstitcher Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 17, 93258, "", "=q4=Arrowflight Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 18, 93257, "", "=q4=Medallion of Mystifying Vapors", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 18, 93260, "", "=q4=Heartwarmer Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 19, 93256, "", "=q4=Skullrender Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 19, 93261, "", "=q4=Helmbreaker Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 20, 93254, "", "=q4=Static-Caster's Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 20, 93259, "", "=q4=Shock-Charger Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 21, 93253, "", "=q4=Woundripper Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Dominance Offensive"] };
					{ 21, 93262, "", "=q4=Vaporshield Medallion", "=ds=#s14#", "#JUSTICE:1750#"..ALIL["Operation: Shieldwall"] };
				};
				extraText = ": "..AL["Accessories"]..": "..BabbleInventory["Ring"].." / "..BabbleInventory["Trinket"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 2, 89070, "", "=q4=Anji's Keepsake", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 3, 89071, "", "=q4=Alani's Inflexible Ring", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 4, 89073, "", "=q4=Leven's Circle of Hope", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 5, 89069, "", "=q4=Ring of the Golden Stair", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 6, 89072, "", "=q4=Simple Harmonius Ring", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 489), ""};
				{ 17, 89081, "", "=q4=Blossom of Pure Snow", "=ds=#s14#", "#JUSTICE:1750#" },
				{ 18, 89082, "", "=q4=Hawkmaster's Talon", "=ds=#s14#", "#JUSTICE:1750#" },
				{ 19, 89083, "", "=q4=Iron Belly Wok", "=ds=#s14#", "#JUSTICE:1750#" },
				{ 20, 89079, "", "=q4=Lao-Chin's Liquid Courage", "=ds=#s14#", "#JUSTICE:1750#" },
				{ 21, 89080, "", "=q4=Scroll of Revered Ancestors", "=ds=#s14#", "#JUSTICE:1750#" },
				extraText = ": "..AL["Accessories"]..": "..BabbleInventory["Ring"].." / "..BabbleInventory["Trinket"];
			};
			{
				{ 1, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 458), ""};
				{ 2, 89532, "", "=q3=Bladesong Cloak", "=ds=#s4#", "#JUSTICE:315#"};
				{ 3, 89533, "", "=q3=Cloak of Ancient Curses", "=ds=#s4#", "#JUSTICE:315#"};
				{ 4, 89537, "", "=q3=Cloak of the Silent Mountain", "=ds=#s4#", "#JUSTICE:315#"};
				{ 5, 89534, "", "=q3=Pressed Flower Cloak", "=ds=#s4#", "#JUSTICE:315#"};
				{ 6, 89535, "", "=q3=Ribracker's Cloak", "=ds=#s4#", "#JUSTICE:315#"};
				{ 8, 89527, "", "=q3=Amulet of Swirling Mists", "=ds=#s2#", "#JUSTICE:315#"};
				{ 9, 89531, "", "=q3=Gorget of Usurped Kings", "=ds=#s2#", "#JUSTICE:315#"};
				{ 10, 89528, "", "=q3=Necklace of Jade Pearls", "=ds=#s2#", "#JUSTICE:315#"};
				{ 11, 89529, "", "=q3=Pendant of Endless Inquisition", "=ds=#s2#", "#JUSTICE:315#"};
				{ 12, 89530, "", "=q3=Triumphant Conqueror's Chain", "=ds=#s2#", "#JUSTICE:315#"};
				{ 16, 0, "pvecurrency-justice", "=ds="..string.format(AL["ilvl %d"], 458), ""};
				{ 17, 89523, "", "=q3=Etched Golden Loop", "=ds=#s13#", "#JUSTICE:315#"};
				{ 18, 89522, "", "=q3=Mark of the Dancing Crane", "=ds=#s13#", "#JUSTICE:315#"};
				{ 19, 89526, "", "=q3=Signet of the Slumbering Emperor", "=ds=#s13#", "#JUSTICE:315#"};
				{ 20, 89524, "", "=q3=Sorcerer-King's Seal", "=ds=#s13#", "#JUSTICE:315#"};
				{ 21, 89525, "", "=q3=Thunderstone Ring", "=ds=#s13#", "#JUSTICE:315#"};
				{
					{ 23, 93342, "", "=q3=Dominator's Arcane Badge", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Dominance Offensive"] };
					{ 23, 93347, "", "=q3=Arcane Badge of the Shieldwall", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 24, 93341, "", "=q3=Dominator's Deadeye Badge", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Dominance Offensive"] };
					{ 24, 93346, "", "=q3=Deadeye Badge of the Shieldwall", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 25, 93345, "", "=q3=Dominator's Durable Badge", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Dominance Offensive"] };
					{ 25, 93350, "", "=q3=Durable Badge of the Shieldwall", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 26, 93344, "", "=q3=Dominator's Knightly Badge", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Dominance Offensive"] };
					{ 26, 93349, "", "=q3=Knightly Badge of the Shieldwall", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Operation: Shieldwall"] };
				};
				{
					{ 27, 93343, "", "=q3=Dominator's Mending Badge", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Dominance Offensive"] };
					{ 27, 93348, "", "=q3=Mending Badge of the Shieldwall", "=ds=#s14#", "#JUSTICE:440#"..ALIL["Operation: Shieldwall"] };
				};
				{ 28, 89232, "", "=q3=Mogu Rune of Paralysis", "=ds=#s14#", "#JUSTICE:440#"};
				{ 29, 88995, "", "=q3=Shado-Pan Dragon Gun", "=ds=#s14#", "#JUSTICE:440#"};
				extraText = ": "..AL["Accessories"];
			};
		};
		info = {
			name = AL["Justice Points"],
			module = moduleName, menu = "JUSTICEPOINTSMENU",
		};
	}

		--------------------------
		--- Valor Points Items ---
		--------------------------

	AtlasLoot_Data["ValorPointsMoP"] = {
		["Normal"] = {
			{
				{ 1, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 2, 95081, "", "=q4=Fire Support Robes", "=ds=#s5#, #a1#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 3, 95136, "", "=q4=Troll-Burner Bracers", "=ds=#s8#, #a1#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 4, 95106, "", "=q4=Flameweaver Handwraps", "=ds=#s9#, #a1#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 5, 95090, "", "=q4=Firestrike Cord", "=ds=#s10#, #a1#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 6, 95123, "", "=q4=Charfire Leggings", "=ds=#s11#, #a1#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 8, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 9, 95077, "", "=q4=Roofstalker Shadowwrap", "=ds=#s5#, #a2#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 10, 95133, "", "=q4=Willow-Weave Armbands", "=ds=#s8#, #a2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 11, 95108, "", "=q4=Daggerfinger Clutches", "=ds=#s9#, #a2#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 12, 95088, "", "=q4=Darkfang Belt", "=ds=#s10#, #a2#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 13, 95125, "", "=q4=Legguards of Hidden Knives", "=ds=#s11#, #a2#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 16, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 17, 95082, "", "=q4=Robes of Misty Bindings", "=ds=#s5#, #a1#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 18, 95135, "", "=q4=Bracers of Shielding Thought", "=ds=#s8#, #a1#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 19, 95105, "", "=q4=Ghostbinder Grips", "=ds=#s9#, #a1#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 20, 95091, "", "=q4=Girdle of Glowing Light", "=ds=#s10#, #a1#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 21, 95122, "", "=q4=Wisp-Weave Pantaloons", "=ds=#s11#, #a1#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 23, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 24, 95078, "", "=q4=Raiment of Silent Stars", "=ds=#s5#, #a2#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 25, 95134, "", "=q4=Hearthfire Armwraps", "=ds=#s8#, #a2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 26, 95107, "", "=q4=Gloves of Enduring Renewal", "=ds=#s9#, #a2#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 27, 95089, "", "=q4=Martiean's Splitleaf Girdle", "=ds=#s10#, #a2#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 28, 95124, "", "=q4=Trousers of Waning Shadow", "=ds=#s11#, #a2#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				extraText = ": "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				{ 1, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 2, 95079, "", "=q4=Carapace of Segmented Scale", "=ds=#s5#, #a3#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 3, 95131, "", "=q4=Powderburn Bracers", "=ds=#s8#, #a3#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 4, 95109, "", "=q4=Gauntlets of the Longbow", "=ds=#s9#, #a3#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 5, 95086, "", "=q4=Nightflight Chain", "=ds=#s10#, #a3#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 6, 95127, "", "=q4=Homeguard Leggings", "=ds=#s11#, #a3#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 16, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 17, 95080, "", "=q4=Skinsealer Tunic", "=ds=#s5#, #a3#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 18, 95132, "", "=q4=Spiritcaller Cuffs", "=ds=#s8#, #a3#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 19, 95112, "", "=q4=Totemshaper Gloves", "=ds=#s9#, #a3#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 20, 95087, "", "=q4=Cracklebite Links", "=ds=#s10#, #a3#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 21, 95126, "", "=q4=Kilt of Rising Thunder", "=ds=#s11#, #a3#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				extraText = ": "..BabbleInventory["Mail"];
			};
			{
				{ 1, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 2, 95075, "", "=q4=Gianttooth Chestplate", "=ds=#s5#, #a4#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 3, 95128, "", "=q4=Bonecrusher Bracers", "=ds=#s8#, #a4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 4, 95111, "", "=q4=Bloodstained Skullsqueezers", "=ds=#s9#, #a4#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 5, 95083, "", "=q4=Swordhook Slingbelt", "=ds=#s10#, #a4#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 6, 95121, "", "=q4=Vaultbreaker Greaves", "=ds=#s11#, #a4#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 8, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 9, 95076, "", "=q4=Breastplate of Brutal Strikes", "=ds=#s5#, #a4#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 10, 95129, "", "=q4=Axebinder Wristguards", "=ds=#s8#, #a4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 11, 95110, "", "=q4=Stoneward Handguards", "=ds=#s9#, #a4#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 12, 95084, "", "=q4=Reinforced Spiritplate Girdle", "=ds=#s10#, #a4#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 13, 95119, "", "=q4=Thunderbreaker Legplates", "=ds=#s11#, #a4#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 16, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 17, 95074, "", "=q4=Hauberk of Gleaming Fire", "=ds=#s5#, #a4#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 18, 95130, "", "=q4=Softscar Armplates", "=ds=#s8#, #a4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 19, 95113, "", "=q4=Touch of Soothing Mists", "=ds=#s9#, #a4#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 20, 95085, "", "=q4=Waistplate of Channeled Mending", "=ds=#s10#, #a4#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 21, 95120, "", "=q4=Legguards of Renewal", "=ds=#s11#, #a4#", "#VALOR:1485#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				extraText = ": "..BabbleInventory["Plate"];
			};
			{
				{ 1, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 2, 95118, "", "=q4=Dreamweaver Drape", "=ds=#s4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 3, 95116, "", "=q4=Longshot Forestcloak", "=ds=#s4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 4, 95115, "", "=q4=Many-Layered Scalecloak", "=ds=#s4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 5, 95117, "", "=q4=Shadowspike Cloak", "=ds=#s4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 6, 95114, "", "=q4=Spikeshard Greatcloak", "=ds=#s4#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 8, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 9, 95146, "", "=q4=Destroyer's Battletags", "=ds=#s2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Neutral"] },
				{ 10, 95143, "", "=q4=Flanker's Battletags", "=ds=#s2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Neutral"] },
				{ 11, 95145, "", "=q4=Mender's Battletags", "=ds=#s2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Neutral"] },
				{ 12, 95142, "", "=q4=Striker's Battletags", "=ds=#s2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Neutral"] },
				{ 13, 95144, "", "=q4=Vanguard's Battletags", "=ds=#s2#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Neutral"] },
				{ 16, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 17, 95140, "", "=q4=Band of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 18, 95141, "", "=q4=Loop of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 19, 95139, "", "=q4=Ring of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 20, 95137, "", "=q4=Seal of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 21, 95138, "", "=q4=Signet of the Shado-Pan Assault", "=ds=#s13#", "#VALOR:825#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 23, 0, "pvecurrency-valor", "=ds="..string.format(AL["ilvl %d"], 522), ""};
				{ 24, 94508, "", "=q4=Brutal Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 25, 94509, "", "=q4=Soothing Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 26, 94507, "", "=q4=Steadfast Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 27, 94511, "", "=q4=Vicious Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				{ 28, 94510, "", "=q4=Volatile Talisman of the Shado-Pan Assault", "=ds=#s14#", "#VALOR:1155#"..ALIL["Shado-Pan Assault"].." - "..AL["Friendly"] },
				extraText = ": "..AL["Accessories"];
			};
		};
		info = {
			name = AL["Valor Points"],
			module = moduleName, menu = "VPMOPMENU",
		};
	}

		---------------------
		--- Timeless Isle ---
		---------------------

	AtlasLoot_Data["TimelessIsle"] = {
		["Normal"] = {
			{
				{ 1, 103989, "", "=q4=Alacrity of Xuen", "=ds=#s14#", "#TIMELESSCOIN:50000#"};
				{ 2, 103988, "", "=q4=Contemplation of Chi-Ji", "=ds=#s14#", "#TIMELESSCOIN:50000#"};
				{ 3, 103986, "", "=q4=Discipline of Xuen", "=ds=#s14#", "#TIMELESSCOIN:50000#"};
				{ 4, 103990, "", "=q4=Resolve of Niuzao", "=ds=#s14#", "#TIMELESSCOIN:50000#"};
				{ 5, 103987, "", "=q4=Yu'lon's Bite", "=ds=#s14#", "#TIMELESSCOIN:50000#"};
				{ 7, 103678, "", "=q4=Time-Lost Artifact", "=ds=#s14#", "#TIMELESSCOIN:7500#"};
				{ 9, 103982, "", "=q4=Burden of Eternity", "=ds=#m20#", "#TIMELESSCOIN:50000#"};
				{ 11, 87774, "", "=q4=Reins of the Heavenly Golden Cloud Serpent", "=ds=#e27#", "#TIMELESSCOIN:100000#"};
				{ 12, 104295, "", "=q3=Harmonious Porcupette", "=ds=#e13#", "#TIMELESSCOIN:7500#"};
				{ 13, 104332, "", "=q3=Sky Lantern", "=ds=#e13#", "#TIMELESSCOIN:7500#"};
				{ 15, 104014, "", "=q4=Pouch of Timeless Coins", "=ds=#m17#", "#VALOR:500#"};
				{ 16, 105921, "", "=q4=Cloudscorcher Greatstaff", "=ds=#w9#", "#TIMELESSCOIN:20000#"};
				{ 17, 105923, "", "=q4=Contemplation of Shaohao", "=ds=#w9#", "#TIMELESSCOIN:20000#"};
				{ 18, 105927, "", "=q4=Featherdraw Longbow", "=ds=#w2#", "#TIMELESSCOIN:20000#"};
				{ 19, 105924, "", "=q4=Hozen Can Opener", "=ds=#h1#, #w13#", "#TIMELESSCOIN:10000#"};
				{ 20, 105926, "", "=q4=Ordon Sacrificial Dagger", "=ds=#h1#, #w4#", "#TIMELESSCOIN:10000#"};
				{ 21, 105920, "", "=q4=Pandaren Peace Offering", "=ds=#h1#, #w6#", "#TIMELESSCOIN:10000#"};
				{ 22, 105929, "", "=q4=Scavenged Pandaren Dagger", "=ds=#h1#, #w4#", "#TIMELESSCOIN:10000#"};
				{ 23, 105925, "", "=q4=Yak-Herder's Longstaff", "=ds=#w7#", "#TIMELESSCOIN:20000#"};
				{ 24, 105919, "", "=q4=Daylight Protectorate", "=ds=#w8#", "#TIMELESSCOIN:10000#"};
				{ 25, 105922, "", "=q4=Shield of the Eternal Noon", "=ds=#w8#", "#TIMELESSCOIN:10000#"};
				{ 27, 104013, "", "=q4=Timeless Cloth Armor Cache", "=ds=#a1#", "#TIMELESSCOIN:7500#"};
				{ 28, 104012, "", "=q4=Timeless Leather Armor Cache", "=ds=#a2#", "#TIMELESSCOIN:7500#"};
				{ 29, 104010, "", "=q4=Timeless Mail Armor Cache", "=ds=#a3#", "#TIMELESSCOIN:7500#"};
				{ 30, 104009, "", "=q4=Timeless Plate Armor Cache", "=ds=#a4#", "#TIMELESSCOIN:7500#"};
			};
			{
				{ 1, 103685, "", "=q3=Celestial Defender's Medallion", "=ds=#m20#", "#TIMELESSCOIN:2500#"};
				{ 2, 101538, "", "=q3=Kukuru's Cache Key", "=ds=#e9#", "#TIMELESSCOIN:500#"};
				{ 3, 103683, "", "=q3=Mask of Anger", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 4, 103681, "", "=q3=Mask of Doubt", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 5, 103679, "", "=q3=Mask of Fear", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 6, 103680, "", "=q3=Mask of Hatred", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 7, 103682, "", "=q3=Mask of Violence", "=ds=#m20#", "#TIMELESSCOIN:100#"};
				{ 8, 103684, "", "=q3=Scroll of Challenge", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 9, 103786, "", "=q2=\"Dapper Gentleman\" Costume", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 10, 103795, "", "=q2=\"Dread Pirate\" Costume", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 11, 103789, "", "=q2=\"Little Princess\" Costume", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 12, 103797, "", "=q2=Big Pink Bow", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 13, 71153, "", "=q2=Magical Pet Biscuit", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 14, 103977, "", "=q1=Time-Worn Journal", "=ds=#m20#", "#TIMELESSCOIN:500#"};
				{ 16, 102467, "", "=q3=Censer of Eternal Agony", "=ds=#m20#", "#TIMELESSCOIN:2500#"};
				{ 18, 103638, "", "=q4=Reins of the Ashhide Mushan Beast", "=ds=#e26#", "#BLOODYCOIN:500#"};
				{ 19, 103639, "", "=q4=Pouch of White Ash", "=ds=#s14#", "#BLOODYCOIN:20#"};
				{ 20, 103637, "", "=q3=Vengeful Porcupette", "=ds=#e13#", "#BLOODYCOIN:100#"};
				{ 21, 102463, "", "=q3=Fire-Watcher's Oath", "=ds=#m20#", "#BLOODYCOIN:50#"};
				{ 22, 102464, "", "=q2=Black Ash", "=ds=#m20#", "#BLOODYCOIN:1#"};
				{ 24, 102145, "", "=q3=Chi-Chi, Hatchling of Chi-Ji", "=ds=#e13#", "#ITEM:101529:3#"};
				{ 25, 101771, "", "=q3=Xu-Fu, Cub of Xuen", "=ds=#e13#", "#ITEM:101529:3#"};
				{ 26, 102147, "", "=q3=Yu'la, Broodling of Yu'lon", "=ds=#e13#", "#ITEM:101529:3#"};
				{ 27, 102146, "", "=q3=Zao, Calfling of Niuzao", "=ds=#e13#", "#ITEM:101529:3#"};
				{ 28, 98715, "", "=q3=Marked Flawless Battle-Stone", "=ds=#m20#", "#ITEM:101529:3#"},
				{ 29, 86143, "", "=q2=Battle Pet Bandage", "=ds=#m20#", "#ITEM:101529:1#"},
				{ 30, 98114, "", "=q2=Pet Treat", "=ds=#m20#", "#ITEM:101529:1#"},
			};
		};
		info = {
			name = ALIL["Timeless Isle"].." - "..AL["Rewards"],
			module = moduleName, menu = "SETMENU",
		};
	}