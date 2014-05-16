-- $Id: cataclysm.lua 4241 2013-09-06 15:11:19Z Dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local moduleName = "AtlasLootCataclysm"

-- Index
--- Dungeons & Raids
---- Blackrock Caverns
---- Caverns of Time: End Time
---- Caverns of Time: Hour of Twilight
---- Caverns of Time: Well of Eternity
---- Grim Batol
---- Halls of Origination
---- Lost City of Tol'vir
---- Shadowfang Keep
---- The Deadmines
---- The Stonecore
---- The Vortex Pinnacle
---- Throne of the Tides
---- Zul'Aman
---- Zul'Gurub
---- Baradin Hold
---- Blackwing Descent
---- Caverns of Time: Dragon Soul
---- Firelands
---- The Bastion of Twilight
---- Throne of the Four Winds
--- Factions
---- Avengers of Hyjal
---- Baradin's Wardens
---- Dragonmaw Clan
---- Hellscream's Reach
---- Ramkahen
---- The Earthen Ring
---- The Guardians of Hyjal
---- Therazane
---- Wildhammer Clan
--- PvP
---- PvP Armor Sets
---- Level 85 - Accessories
---- Level 85 - Non Set Epics
---- Level 85 - Weapons
---- Level 85 - Misc
--- Sets & Collections
---- Tier 11/12 Sets (T11/12)
---- Tier 13 Sets (T13)
---- Bags
---- BoE World Epics
---- Heirloom Items
---- Justice Points Items
---- Molten Front Rewards

	------------------------
	--- Dungeons & Raids ---
	------------------------

		-------------------------
		--- Blackrock Caverns ---
		-------------------------

	AtlasLoot_Data["BlackrockCavernsRomogg"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55278, "", "=q3=Inquisition Robes", "=ds=#s5#, #a1#", ""};
				{ 3, 55279, "", "=q3=Manacles of Pain", "=ds=#s8#, #a3#", ""};
				{ 4, 55776, "", "=q3=Skullcracker Ring", "=ds=#s13#", ""};
				{ 5, 55777, "", "=q3=Torturer's Mercy", "=ds=#h1#, #w6#", ""};
				{ 6, 55778, "", "=q3=Shield of the Iron Maiden", "=ds=#w8#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5281#"};
				{ 17, 56311, "", "=q3=Inquisition Robes", "=ds=#s5#, #a1#", ""};
				{ 18, 56313, "", "=q3=Manacles of Pain", "=ds=#s8#, #a3#", ""};
				{ 19, 56310, "", "=q3=Skullcracker Ring", "=ds=#s13#", ""};
				{ 20, 56312, "", "=q3=Torturer's Mercy", "=ds=#h1#, #w6#", ""};
				{ 21, 56314, "", "=q3=Shield of the Iron Maiden", "=ds=#w8#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Rom'ogg Bonecrusher", 105),
			module = moduleName, instance = "BlackrockCaverns",
		};
	};

	AtlasLoot_Data["BlackrockCavernsCorla"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55264, "", "=q3=Armbands of Change", "=ds=#s8#, #a2#", ""};
				{ 3, 55263, "", "=q3=Renouncer's Cowl", "=ds=#s1#, #a3#", ""};
				{ 4, 55265, "", "=q3=Signet of Transformation", "=ds=#s13#", ""};
				{ 5, 55266, "", "=q3=Grace of the Herald", "=ds=#s14#", ""};
				{ 6, 55267, "", "=q3=Corla's Baton", "=ds=#w12#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5282#"};
				{ 17, 56297, "", "=q3=Armbands of Change", "=ds=#s8#, #a2#", ""};
				{ 18, 56298, "", "=q3=Renouncer's Cowl", "=ds=#s1#, #a3#", ""};
				{ 19, 56299, "", "=q3=Signet of Transformation", "=ds=#s13#", ""};
				{ 20, 56295, "", "=q3=Grace of the Herald", "=ds=#s14#", ""};
				{ 21, 56296, "", "=q3=Corla's Baton", "=ds=#w12#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Corla, Herald of Twilight", 106),
			module = moduleName, instance = "BlackrockCaverns",
		};
	};

	AtlasLoot_Data["BlackrockCavernsSteelbender"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55270, "", "=q3=Burned Gatherings", "=ds=#s4#", ""};
				{ 3, 55269, "", "=q3=Heat Wave Leggings", "=ds=#s11#, #a3#", ""};
				{ 4, 55268, "", "=q3=Bracers of Cooled Anger", "=ds=#s8#, #a4#", ""};
				{ 5, 55271, "", "=q3=Quicksilver Amulet", "=ds=#s2#", ""};
				{ 6, 55272, "", "=q3=Steelbender's Masterpiece", "=ds=#h1#, #w4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5283#"};
				{ 17, 56304, "", "=q3=Burned Gatherings", "=ds=#s4#", ""};
				{ 18, 56303, "", "=q3=Heat Wave Leggings", "=ds=#s11#, #a3#", ""};
				{ 19, 56301, "", "=q3=Bracers of Cooled Anger", "=ds=#s8#, #a4#", ""};
				{ 20, 56300, "", "=q3=Quicksilver Amulet", "=ds=#s2#", ""};
				{ 21, 56302, "", "=q3=Steelbender's Masterpiece", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Karsh Steelbender", 107),
			module = moduleName, instance = "BlackrockCaverns",
		};
	};

	AtlasLoot_Data["BlackrockCavernsBeauty"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55275, "", "=q3=Beauty's Silken Ribbon", "=ds=#s10#, #a1#", ""};
				{ 3, 55273, "", "=q3=Beauty's Chew Toy", "=ds=#s11#, #a2#", ""};
				{ 4, 55274, "", "=q3=Beauty's Plate", "=ds=#s5#, #a4#", ""};
				{ 5, 55276, "", "=q3=Kibble", "=ds=#s13#", ""};
				{ 6, 55277, "", "=q3=Beauty's Favorite Bone", "=ds=#s15#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56305, "", "=q3=Beauty's Silken Ribbon", "=ds=#s10#, #a1#", ""};
				{ 18, 56309, "", "=q3=Beauty's Chew Toy", "=ds=#s11#, #a2#", ""};
				{ 19, 56308, "", "=q3=Beauty's Plate", "=ds=#s5#, #a4#", ""};
				{ 20, 56307, "", "=q3=Kibble", "=ds=#s13#", ""};
				{ 21, 56306, "", "=q3=Beauty's Favorite Bone", "=ds=#s15#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Beauty", 108),
			module = moduleName, instance = "BlackrockCaverns",
		};
	};

	AtlasLoot_Data["BlackrockCavernsLordObsidius"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55780, "", "=q3=Twitching Shadows", "=ds=#s4#", ""};
				{ 3, 55786, "", "=q3=Kyrstel Mantle", "=ds=#s3#, #a1#", ""};
				{ 4, 55785, "", "=q3=Willowy Crown", "=ds=#s1#, #a2#", ""};
				{ 5, 55779, "", "=q3=Raz's Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 6, 55784, "", "=q3=Clutches of Dying Light", "=ds=#s9#, #a4#", ""};
				{ 7, 55781, "", "=q3=Carrier Wave Pendant", "=ds=#s2#", ""};
				{ 8, 55787, "", "=q3=Witching Hourglass", "=ds=#s14#", ""};
				{ 9, 55782, "", "=q3=Amber Messenger", "=ds=#w2#", ""};
				{ 10, 55788, "", "=q3=Crepuscular Shield", "=ds=#w8#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5284#"};
				{ 17, 56315, "", "=q3=Twitching Shadows", "=ds=#s4#", ""};
				{ 18, 56324, "", "=q3=Kyrstel Mantle", "=ds=#s3#, #a1#", ""};
				{ 19, 56321, "", "=q3=Willowy Crown", "=ds=#s1#, #a2#", ""};
				{ 20, 56318, "", "=q3=Raz's Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 21, 56323, "", "=q3=Clutches of Dying Light", "=ds=#s9#, #a4#", ""};
				{ 22, 56319, "", "=q3=Carrier Wave Pendant", "=ds=#s2#", ""};
				{ 23, 56320, "", "=q3=Witching Hourglass", "=ds=#s14#", ""};
				{ 24, 56317, "", "=q3=Amber Messenger", "=ds=#w2#", ""};
				{ 25, 56322, "", "=q3=Crepuscular Shield", "=ds=#w8#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ascendant Lord Obsidius", 109),
			module = moduleName, instance = "BlackrockCaverns",
		};
	};

	AtlasLoot_Data["BlackrockCavernsTrash"] = {
		["Normal"] = {
			{
				{ 2, 55791, "", "=q3=Acanthia's Lost Pendant", "=ds=#s2#", ""};
				{ 17, 55790, "", "=q3=Toxidunk Dagger", "=ds=#h1#, #w4#", ""};
				{ 18, 55789, "", "=q3=Berto's Staff", "=ds=#w9#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "BlackrockCaverns",
		};
	};

		---------------------------------
		--- Caverns of Time: End Time ---
		---------------------------------

	AtlasLoot_Data["EndtimeEchoes"] = {
		["Heroic"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Echo of Baine", 340), ""};
				{ 2, 72815, "", "=q4=Bloodhoof Legguards", "=ds=#s11#, #a4#" },
				{ 3, 72814, "", "=q4=Axe of the Tauren Chieftains", "=ds=#h2#, #w1#" },
				{ 5, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Echo of Jaina", 285), ""};
				{ 6, 72808, "", "=q4=Jaina's Staff", "=ds=#w9#" },
				{ 7, 72809, "", "=q4=Ward of Incantations", "=ds=#w8#" },
				{ 9, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Echo of Sylvanas", 323), "#ACHIEVEMENTID:6130#"};
				{ 10, 72811, "", "=q4=Cloak of the Banshee Queen", "=ds=#s4#" },
				{ 11, 72810, "", "=q4=Windrunner's Bow", "=ds=#w2#" },
				{ 13, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Echo of Tyrande", 283), "#ACHIEVEMENTID:5995#"};
				{ 14, 72813, "", "=q4=Whisperwind Robes", "=ds=#s5#, #a1#" },
				{ 15, 72812, "", "=q4=Crescent Moon", "=ds=#h1#, #w1#" },
				{ 16, 0, "INV_Box_01", "=q6="..AL["Shared"], ""};
				{ 17, 72802, "", "=q4=Time Traveler's Leggings", "=ds=#s11#, #a1#" },
				{ 18, 72805, "", "=q4=Gloves of the Hollow", "=ds=#s9#, #a2#" },
				{ 19, 72798, "", "=q4=Cord of Lost Hope", "=ds=#s10#, #a2#" },
				{ 20, 72806, "", "=q4=Echoing Headguard", "=ds=#s1#, #a3#" },
				{ 21, 72799, "", "=q4=Dead End Boots", "=ds=#s12#, #a3#" },
				{ 22, 72801, "", "=q4=Breastplate of Sorrow", "=ds=#s5#, #a4#" },
				{ 23, 72800, "", "=q4=Gauntlets of Temporal Interference", "=ds=#s9#, #a4#" },
				{ 24, 72803, "", "=q4=Girdle of Lost Heroes", "=ds=#s10#, #a4#" },
				{ 25, 72807, "", "=q4=Waistguard of Lost Time", "=ds=#s10#, #a4#" },
				{ 26, 72804, "", "=q4=Dragonshrine Scepter", "=ds=#h1#, #w6#" },

			};
		};
		info = {
			name = "Echoes",
			module = moduleName, instance = "CoTEndTime",
		};
	};

	AtlasLoot_Data["EndtimeMurozond"] = {
		["Heroic"] = {
			{
				{ 1, 72825, "", "=q4=Mantle of Time", "=ds=#s3#, #a1#" },
				{ 2, 72826, "", "=q4=Robes of Fate", "=ds=#s5#, #a1#" },
				{ 3, 72823, "", "=q4=Timeway Headgear", "=ds=#s1#, #a2#" },
				{ 4, 72824, "", "=q4=Time Twisted Tunic", "=ds=#s5#, #a2#" },
				{ 5, 72816, "", "=q4=Distortion Greaves", "=ds=#s11#, #a3#" },
				{ 6, 72820, "", "=q4=Crown of Epochs", "=ds=#s1#, #a4#" },
				{ 7, 72821, "", "=q4=Temporal Pauldrons", "=ds=#s3#, #a4#" },
				{ 8, 72818, "", "=q4=Breastplate of Tarnished Bronze", "=ds=#s5#, #a4#" },
				{ 9, 72817, "", "=q4=Time Altered Legguards", "=ds=#s11#, #a4#" },
				{ 10, 72819, "", "=q4=Chrono Boots", "=ds=#s12#, #a4#" },
				{ 16, 72897, "", "=q4=Arrow of Time", "=ds=#s14#" },
				{ 18, 72822, "", "=q4=Jagged Edge of Time", "=ds=#h1#, #w4#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Murozond", 289),
			module = moduleName, instance = "CoTEndTime",
		};
	};

	AtlasLoot_Data["EndtimeTrash"] = {
		["Heroic"] = {
			{
				{ 2, 76154, "", "=q4=Breastplate of Despair", "=ds=#s5#, #a4#" },
				{ 3, 76156, "", "=q4=Bindings of the End Times", "=ds=#s8#, #a4#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "CoTEndTime",
		};
	};

		-----------------------------------------
		--- Caverns of Time: Hour of Twilight ---
		-----------------------------------------

	AtlasLoot_Data["HoTArcurion"] = {
		["Heroic"] = {
			{
				{ 1, 72854, "", "=q4=Iceward Cloak", "=ds=#s4#" },
				{ 2, 72851, "", "=q4=Chillbane Belt", "=ds=#s10#, #a1#" },
				{ 3, 76150, "", "=q4=Evergreen Wristbands", "=ds=#s8#, #a2#" },
				{ 4, 72849, "", "=q4=Wayfinder Boots", "=ds=#s12#, #a2#" },
				{ 5, 72850, "", "=q4=Surestride Boots", "=ds=#s12#, #a3#" },
				{ 6, 72853, "", "=q4=Arcurion Legguards", "=ds=#s11#, #a4#" },
				{ 8, 77957, "", "=q1=Urgent Twilight Missive", "=ds=#m2#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Arcurion", 322),
			module = moduleName, instance = "CoTHourOfTwilight",
		};
	};

	AtlasLoot_Data["HoTDawnslayer"] = {
		["Heroic"] = {
			{
				{ 1, 76151, "", "=q4=Cloak of Subtle Light", "=ds=#s4#" },
				{ 2, 72857, "", "=q4=Leggings of Blinding Speed", "=ds=#s11#, #a2#" },
				{ 3, 72859, "", "=q4=Dawnslayer Helm", "=ds=#s1#, #a3#" },
				{ 4, 72856, "", "=q4=Pauldrons of Midnight Whispers", "=ds=#s3#, #a3#" },
				{ 16, 72855, "", "=q4=Corrupted Carapace", "=ds=#w8#" },
				{ 17, 72860, "", "=q4=Mandible of the Old Ones", "=ds=#h4#, #w4#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Asira Dawnslayer", 342),
			module = moduleName, instance = "CoTHourOfTwilight",
		};
	};

	AtlasLoot_Data["HoTBenedictus"] = {
		["Heroic"] = {
			{
				{ 1, 72865, "", "=q4=Mantle of False Virtue", "=ds=#s3#, #a1#" },
				{ 2, 72868, "", "=q4=Desecrated Shoulderguards", "=ds=#s3#, #a2#" },
				{ 3, 72870, "", "=q4=Betrayer's Pauldrons", "=ds=#s3#, #a3#" },
				{ 4, 72864, "", "=q4=Pauldrons of Conviction", "=ds=#s3#, #a4#" },
				{ 5, 72861, "", "=q4=Pauldrons of the Dragonblight", "=ds=#s3#, #a4#" },
				{ 7, 72901, "", "=q4=Rosary of Light", "=ds=#s14#" },
				{ 8, 72900, "", "=q4=Veil of Darkness", "=ds=#s14#" },
				{ 16, 72867, "", "=q4=Clattering Claw", "=ds=#h1#, #w13#" },
				{ 17, 72862, "", "=q4=Fanged Tentacle", "=ds=#h1#, #w4#" },
				{ 18, 72866, "", "=q4=Treachery's Bite", "=ds=#h1#, #w10#" },
				{ 19, 72863, "", "=q4=Stalk of Corruption", "=ds=#w9#" },
				{ 20, 72869, "", "=q4=Dragonsmaw Blaster", "=ds=#w5#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Archbishop Benedictus", 341),
			module = moduleName, instance = "CoTHourOfTwilight",
		};
	};

	AtlasLoot_Data["HoTTrash"] = {
		["Heroic"] = {
			{
				{ 2, 76160, "", "=q4=Drapes of the Dragonshrine", "=ds=#s4#" },
				{ 3, 76161, "", "=q4=Gauntlets of the Twilight Hour", "=ds=#s9#, #a3#" },
				{ 17, 76162, "", "=q4=Twilight Amulet", "=ds=#s2#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "CoTHourOfTwilight",
		};
	};

		-----------------------------------------
		--- Caverns of Time: Well of Eternity ---
		-----------------------------------------

	AtlasLoot_Data["WoEPerotharn"] = {
		["Heroic"] = {
			{
				{ 1, 72830, "", "=q4=Peroth'arn's Belt", "=ds=#s10#, #a2#" },
				{ 2, 72832, "", "=q4=Girdle of the Queen's Champion", "=ds=#s10#, #a4#" },
				{ 4, 72831, "", "=q4=Horned Band", "=ds=#s13#" },
				{ 5, 72829, "", "=q4=Orb of the First Satyrs", "=ds=#s15#" },
				{ 16, 72828, "", "=q4=Trickster's Edge", "=ds=#h1#, #w1#" },
				{ 17, 72827, "", "=q4=Gavel of Peroth'arn", "=ds=#h1#, #w6#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Peroth'arn", 290),
			module = moduleName, instance = "CoTWellOfEternity",
		};
	};

	AtlasLoot_Data["WoEAzshara"] = {
		["Heroic"] = {
			{
				{ 1, 72838, "", "=q4=Cloak of the Royal Protector", "=ds=#s4#"},
				{ 2, 72836, "", "=q4=Slippers of Wizardry", "=ds=#s12#, #a1#" },
				{ 3, 72835, "", "=q4=Puppeteer's Pantaloons", "=ds=#s11#, #a2#" },
				{ 4, 72834, "", "=q4=Breastplate of the Queen's Guard", "=ds=#s5#, #a3#" },
				{ 16, 72837, "", "=q4=Queen's Boon", "=ds=#s13#" },
				{ 18, 72833, "", "=q4=Scepter of Azshara", "=ds=#h1#, #w6#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Queen Azshara", 291),
			module = moduleName, instance = "CoTWellOfEternity",
		};
	};

	AtlasLoot_Data["WoEMannoroth"] = {
		["Heroic"] = {
			{
				{ 1, 72839, "", "=q4=Cowl of Highborne Sorcerors", "=ds=#s1#, #a1#" },
				{ 2, 72847, "", "=q4=Helm of Thorns", "=ds=#s1#, #a2#" },
				{ 3, 72840, "", "=q4=Spaulders of Eternity", "=ds=#s3#, #a2#" },
				{ 4, 72841, "", "=q4=Demonsbane Chestguard", "=ds=#s5#, #a3#" },
				{ 5, 72848, "", "=q4=Legguards of the Legion", "=ds=#s11#, #a3#" },
				{ 6, 72842, "", "=q4=Annihilan Helm", "=ds=#s1#, #a4#" },
				{ 7, 72843, "", "=q4=Helm of Power", "=ds=#s1#, #a4#" },
				{ 16, 72845, "", "=q4=Mannoroth's Signet", "=ds=#s13#" },
				{ 17, 72899, "", "=q4=Varo'then's Brooch", "=ds=#s14#" },
				{ 18, 72898, "", "=q4=Foul Gift of the Demon Lord", "=ds=#s14#" },
				{ 20, 72844, "", "=q4=Pit Lord's Destroyer", "=ds=#h2#, #w6#" },
				{ 21, 72846, "", "=q4=Thornwood Staff", "=ds=#w9#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Mannoroth and Varo'then", 292),
			module = moduleName, instance = "CoTWellOfEternity",
		};
	};

	AtlasLoot_Data["WoETrash"] = {
		["Heroic"] = {
			{
				{ 2, 76158, "", "=q4=Courtier's Slippers", "=ds=#s12#, #a1#" },
				{ 3, 76157, "", "=q4=Waterworn Handguards", "=ds=#s9#, #a2#" },
				{ 4, 76159, "", "=q4=Legion Bindings", "=ds=#s8#, #a3#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "CoTWellOfEternity",
		};
	};

		------------------
		--- Grim Batol ---
		------------------

	AtlasLoot_Data["GBUmbriss"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 56113, "", "=q3=Cursed Skardyn Vest", "=ds=#s5#, #a2#", ""};
				{ 3, 56112, "", "=q3=Wildhammer Riding Helm", "=ds=#s1#, #a3#", ""};
				{ 4, 56114, "", "=q3=Umbriss Band", "=ds=#s13#", ""};
				{ 5, 56115, "", "=q3=Skardyn's Grace", "=ds=#s14#", ""};
				{ 6, 56116, "", "=q3=Modgud's Blade", "=ds=#h1#, #w4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5297#"};
				{ 17, 56442, "", "=q3=Cursed Skardyn Vest", "=ds=#s5#, #a2#", ""};
				{ 18, 56443, "", "=q3=Wildhammer Riding Helm", "=ds=#s1#, #a3#", ""};
				{ 19, 56444, "", "=q3=Umbriss Band", "=ds=#s13#", ""};
				{ 20, 56440, "", "=q3=Skardyn's Grace", "=ds=#s14#", ""};
				{ 21, 56441, "", "=q3=Modgud's Blade", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("General Umbriss", 131),
			module = moduleName, instance = "GrimBatol",
		};
	};

	AtlasLoot_Data["GBThrongus"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 56119, "", "=q3=Dark Iron Chain Boots", "=ds=#s12#, #a3#", ""};
				{ 3, 56118, "", "=q3=Belt of the Forgemaster", "=ds=#s10#, #a4#", ""};
				{ 4, 56120, "", "=q3=Ring of Dun Algaz", "=ds=#s13#", ""};
				{ 5, 56121, "", "=q3=Throngus's Finger", "=ds=#s14#", ""};
				{ 6, 56122, "", "=q3=Wand of Untainted Power", "=ds=#w12#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56448, "", "=q3=Dark Iron Chain Boots", "=ds=#s12#, #a3#", ""};
				{ 18, 56447, "", "=q3=Belt of the Forgemaster", "=ds=#s10#, #a4#", ""};
				{ 19, 56445, "", "=q3=Ring of Dun Algaz", "=ds=#s13#", ""};
				{ 20, 56449, "", "=q3=Throngus's Finger", "=ds=#s14#", ""};
				{ 21, 56446, "", "=q3=Wand of Untainted Power", "=ds=#w12#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Forgemaster Throngus", 132),
			module = moduleName, instance = "GrimBatol",
		};
	};

	AtlasLoot_Data["GBDrahga"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 56126, "", "=q3=Azureborne Cloak", "=ds=#s4#", ""};
				{ 3, 56125, "", "=q3=Crimsonborne Bracers", "=ds=#s8#, #a1#", ""};
				{ 4, 56123, "", "=q3=Red Scale Boots", "=ds=#s12#, #a3#", ""};
				{ 5, 56124, "", "=q3=Earthshape Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 6, 56127, "", "=q3=Windwalker Blade", "=ds=#h1#, #w4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56450, "", "=q3=Azureborne Cloak", "=ds=#s4#", ""};
				{ 18, 56453, "", "=q3=Crimsonborne Bracers", "=ds=#s8#, #a1#", ""};
				{ 19, 56451, "", "=q3=Red Scale Boots", "=ds=#s12#, #a3#", ""};
				{ 20, 56452, "", "=q3=Earthshape Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 21, 56454, "", "=q3=Windwalker Blade", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Drahga Shadowburner", 133).." & "..BabbleBoss["Valiona"],
			module = moduleName, instance = "GrimBatol",
		};
	};

	AtlasLoot_Data["GBErudax"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 56133, "", "=q3=Crown of Enfeebled Bodies", "=ds=#s1#, #a1#", ""};
				{ 3, 56128, "", "=q3=Vest of Misshapen Hides", "=ds=#s5#, #a2#", ""};
				{ 4, 56135, "", "=q3=Bracers of Umbral Mending", "=ds=#s8#, #a4#", ""};
				{ 5, 56129, "", "=q3=Circle of Bone", "=ds=#s13#", ""};
				{ 6, 56136, "", "=q3=Corrupted Egg Shell", "=ds=#s14#", ""};
				{ 7, 56138, "", "=q3=Gale of Shadows", "=ds=#s14#", ""};
				{ 8, 56132, "", "=q3=Mark of Khardros", "=ds=#s14#", ""};
				{ 9, 56130, "", "=q3=Mace of Transformed Bone", "=ds=#h1#, #w6#", ""};
				{ 10, 56131, "", "=q3=Wild Hammer", "=ds=#h2#, #w6#", ""};
				{ 11, 56137, "", "=q3=Staff of Siphoned Essences", "=ds=#w9#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5298#"};
				{ 17, 56460, "", "=q3=Crown of Enfeebled Bodies", "=ds=#s1#, #a1#", ""};
				{ 18, 56455, "", "=q3=Vest of Misshapen Hides", "=ds=#s5#, #a2#", ""};
				{ 19, 56464, "", "=q3=Bracers of Umbral Mending", "=ds=#s8#, #a4#", ""};
				{ 20, 56457, "", "=q3=Circle of Bone", "=ds=#s13#", ""};
				{ 21, 56463, "", "=q3=Corrupted Egg Shell", "=ds=#s14#", ""};
				{ 22, 56462, "", "=q3=Gale of Shadows", "=ds=#s14#", ""};
				{ 23, 56458, "", "=q3=Mark of Khardros", "=ds=#s14#", ""};
				{ 24, 56459, "", "=q3=Mace of Transformed Bone", "=ds=#h1#, #w6#", ""};
				{ 25, 56456, "", "=q3=Wild Hammer", "=ds=#h2#, #w6#", ""};
				{ 26, 56461, "", "=q3=Staff of Siphoned Essences", "=ds=#w9#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Erudax", 134),
			module = moduleName, instance = "GrimBatol",
		};
	};

	AtlasLoot_Data["GBTrash"] = {
		["Normal"] = {
			{
				{ 2, 56219, "", "=q3=Shroud of Dark Memories", "=ds=#s4#", ""};
				{ 3, 56218, "", "=q3=Curse-Tainted Leggings", "=ds=#s11#, #a1#", ""};
				{ 17, 56220, "", "=q3=Abandoned Dark Iron Ring", "=ds=#s13#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "GrimBatol",
		};
	};

		------------------------------
		--- Halls of Origination -----
		------------------------------

	AtlasLoot_Data["HoOAnhuur"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55886, "", "=q3=Poison Fang Bracers", "=ds=#s8#, #a2#", ""};
				{ 3, 55890, "", "=q3=Awakening Footfalls", "=ds=#s12#, #a2#", ""};
				{ 4, 55887, "", "=q3=Belt of Petrified Tears", "=ds=#s10#, #a3#", ""};
				{ 5, 55888, "", "=q3=Darkhowl Amulet", "=ds=#s2#", ""};
				{ 6, 55889, "", "=q3=Anhuur's Hymnal", "=ds=#s14#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5293#"};
				{ 17, 56409, "", "=q3=Poison Fang Bracers", "=ds=#s8#, #a2#", ""};
				{ 18, 56408, "", "=q3=Awakening Footfalls", "=ds=#s12#, #a2#", ""};
				{ 19, 56410, "", "=q3=Belt of Petrified Tears", "=ds=#s10#, #a3#", ""};
				{ 20, 56411, "", "=q3=Darkhowl Amulet", "=ds=#s2#", ""};
				{ 21, 56407, "", "=q3=Anhuur's Hymnal", "=ds=#s14#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Temple Guardian Anhuur", 124),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

	AtlasLoot_Data["HoOPtah"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 56094, "", "=q3=Underworld Cord", "=ds=#s10#, #a2#", ""};
				{ 3, 56093, "", "=q3=Breastplate of the Risen Land", "=ds=#s5#, #a4#", ""};
				{ 4, 56095, "", "=q3=Mouth of the Earth", "=ds=#s2#", ""};
				{ 5, 56097, "", "=q3=Soul Releaser", "=ds=#w9#", ""};
				{ 6, 56096, "", "=q3=Bulwark of the Primordial Mound", "=ds=#w8#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5294#"};
				{ 17, 56423, "", "=q3=Underworld Cord", "=ds=#s10#, #a2#", ""};
				{ 18, 56425, "", "=q3=Breastplate of the Risen Land", "=ds=#s5#, #a4#", ""};
				{ 19, 56422, "", "=q3=Mouth of the Earth", "=ds=#s2#", ""};
				{ 20, 56424, "", "=q3=Soul Releaser", "=ds=#w9#", ""};
				{ 21, 56426, "", "=q3=Bulwark of the Primordial Mound", "=ds=#w8#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Earthrager Ptah", 125),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

	AtlasLoot_Data["HoOAnraphet"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 57860, "", "=q3=Anraphet's Regalia", "=ds=#s5#, #a1#", ""};
				{ 3, 57858, "", "=q3=Mantle of Soft Shadows", "=ds=#s3#, #a2#", ""};
				{ 4, 57857, "", "=q3=Boots of Crumbling Ruin", "=ds=#s12#, #a3#", ""};
				{ 5, 57856, "", "=q3=Omega Breastplate", "=ds=#s5#, #a4#", ""};
				{ 6, 57855, "", "=q3=Alpha Bracers", "=ds=#s8#, #a4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 57868, "", "=q3=Anraphet's Regalia", "=ds=#s5#, #a1#", ""};
				{ 18, 57866, "", "=q3=Mantle of Soft Shadows", "=ds=#s3#, #a2#", ""};
				{ 19, 57867, "", "=q3=Boots of Crumbling Ruin", "=ds=#s12#, #a3#", ""};
				{ 20, 57869, "", "=q3=Omega Breastplate", "=ds=#s5#, #a4#", ""};
				{ 21, 57870, "", "=q3=Alpha Bracers", "=ds=#s8#, #a4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Anraphet", 126),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

	AtlasLoot_Data["HoOIsiset"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55993, "", "=q3=Legwraps of Astral Rain", "=ds=#s11#, #a1#", ""};
				{ 3, 55992, "", "=q3=Armguards of Unearthly Light", "=ds=#s8#, #a4#", ""};
				{ 4, 55996, "", "=q3=Nova Band", "=ds=#s13#", ""};
				{ 5, 55994, "", "=q3=Ring of Blinding Stars", "=ds=#s13#", ""};
				{ 6, 55995, "", "=q3=Blood of Isiset", "=ds=#s14#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56413, "", "=q3=Legwraps of Astral Rain", "=ds=#s11#, #a1#", ""};
				{ 18, 56416, "", "=q3=Armguards of Unearthly Light", "=ds=#s8#, #a4#", ""};
				{ 19, 56415, "", "=q3=Nova Band", "=ds=#s13#", ""};
				{ 20, 56412, "", "=q3=Ring of Blinding Stars", "=ds=#s13#", ""};
				{ 21, 56414, "", "=q3=Blood of Isiset", "=ds=#s14#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Isiset", 127),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

	AtlasLoot_Data["HoOAmmunae"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55998, "", "=q3=Robes of Rampant Growth", "=ds=#s5#, #a1#", ""};
				{ 3, 55997, "", "=q3=Bloodpetal Mantle", "=ds=#s3#, #a3#", ""};
				{ 4, 55999, "", "=q3=Seedling Pod", "=ds=#s2#", ""};
				{ 5, 56000, "", "=q3=Band of Life Energy", "=ds=#s13#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56417, "", "=q3=Robes of Rampant Growth", "=ds=#s5#, #a1#", ""};
				{ 18, 56419, "", "=q3=Bloodpetal Mantle", "=ds=#s3#, #a3#", ""};
				{ 19, 56421, "", "=q3=Seedling Pod", "=ds=#s2#", ""};
				{ 20, 56418, "", "=q3=Band of Life Energy", "=ds=#s13#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ammunae", 128),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

	AtlasLoot_Data["HoOSetesh"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 57864, "", "=q3=Helm of the Typhonic Beast", "=ds=#s1#, #a1#", ""};
				{ 3, 57863, "", "=q3=Hieroglyphic Vest", "=ds=#s5#, #a2#", ""};
				{ 4, 57862, "", "=q3=Chaotic Wrappings", "=ds=#s11#, #a3#", ""};
				{ 5, 57861, "", "=q3=Helm of Setesh", "=ds=#s1#, #a4#", ""};
				{ 6, 57865, "", "=q3=Scepter of Power", "=ds=#h1#, #w6#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 57871, "", "=q3=Helm of the Typhonic Beast", "=ds=#s1#, #a1#", ""};
				{ 18, 57874, "", "=q3=Hieroglyphic Vest", "=ds=#s5#, #a2#", ""};
				{ 19, 57875, "", "=q3=Chaotic Wrappings", "=ds=#s11#, #a3#", ""};
				{ 20, 57873, "", "=q3=Helm of Setesh", "=ds=#s1#, #a4#", ""};
				{ 21, 57872, "", "=q3=Scepter of Power", "=ds=#h1#, #w6#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Setesh", 129),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

	AtlasLoot_Data["HoORajh"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 56107, "", "=q3=Solar Wind Cloak", "=ds=#s4#", ""};
				{ 3, 56105, "", "=q3=Hekatic Slippers", "=ds=#s12#, #a1#", ""};
				{ 4, 56098, "", "=q3=Red Beam Cord", "=ds=#s10#, #a2#", ""};
				{ 5, 56099, "", "=q3=Fingers of Light", "=ds=#s9#, #a4#", ""};
				{ 6, 56104, "", "=q3=Legguards of Noon", "=ds=#s11#, #a4#", ""};
				{ 7, 56106, "", "=q3=Band of Rays", "=ds=#s13#", ""};
				{ 8, 56102, "", "=q3=Left Eye of Rajh", "=ds=#s14#", ""};
				{ 9, 56100, "", "=q3=Right Eye of Rajh", "=ds=#s14#", ""};
				{ 10, 56108, "", "=q3=Blade of the Burning Sun", "=ds=#h1#, #w10#", ""};
				{ 11, 56101, "", "=q3=Sun Strike", "=ds=#h1#, #w10#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5295#"};
				{ 17, 56434, "", "=q3=Solar Wind Cloak", "=ds=#s4#", ""};
				{ 18, 56436, "", "=q3=Hekatic Slippers", "=ds=#s12#, #a1#", ""};
				{ 19, 56429, "", "=q3=Red Beam Cord", "=ds=#s10# #a2#", ""};
				{ 20, 56428, "", "=q3=Fingers of Light", "=ds=#s9#, #a4#", ""};
				{ 21, 56435, "", "=q3=Legguards of Noon", "=ds=#s11#, #a4#", ""};
				{ 22, 56432, "", "=q3=Band of Rays", "=ds=#s13#", ""};
				{ 23, 56427, "", "=q3=Left Eye of Rajh", "=ds=#s14#", ""};
				{ 24, 56431, "", "=q3=Right Eye of Rajh", "=ds=#s14#", ""};
				{ 25, 56433, "", "=q3=Blade of the Burning Sun", "=ds=#h1#, #w10#", ""};
				{ 26, 56430, "", "=q3=Sun Strike", "=ds=#h1#, #w10#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Rajh", 130),
			module = moduleName, instance = "HallsOfOrigination",
		};
	};	

	AtlasLoot_Data["HoOTrash"] = {
		["Normal"] = {
			{
				{ 2, 56110, "", "=q3=Charm of the Muse", "=ds=#s2#", ""};
				{ 3, 56111, "", "=q3=Temple Band", "=ds=#s13#", ""};
				{ 17, 56109, "", "=q3=Book of Origination", "=ds=#s15#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "HallsOfOrigination",
		};
	};

		----------------------------
		--- Lost City of Tol'vir ---
		----------------------------

	AtlasLoot_Data["LostCityHusam"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55858, "", "=q3=Kaleki Cloak", "=ds=#s4#"};
				{ 3, 55857, "", "=q3=Ionic Gloves", "=ds=#s9#, #a3#"};
				{ 4, 55856, "", "=q3=Greaves of Wu the Elder", "=ds=#s12#, #a4#"};
				{ 5, 55859, "", "=q3=Spirit Creeper Ring", "=ds=#s13#"};
				{ 6, 55860, "", "=q3=Seliza's Spear", "=ds=#w7#"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56379, "", "=q3=Kaleki Cloak", "=ds=#s4#"};
				{ 18, 56383, "", "=q3=Ionic Gloves", "=ds=#s9#, #a3#"};
				{ 19, 56381, "", "=q3=Greaves of Wu the Elder", "=ds=#s12#, #a4#"};
				{ 20, 56380, "", "=q3=Spirit Creeper Ring", "=ds=#s13#"};
				{ 21, 56382, "", "=q3=Seliza's Spear", "=ds=#w7#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("General Husam", 117),
			module = moduleName, instance = "LostCityOfTolvir",
		};
	};

	AtlasLoot_Data["LostCityLockmaw"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55866, "", "=q3=Sand Silk Wristband", "=ds=#s8#, #a1#"};
				{ 3, 55867, "", "=q3=Sand Dune Belt", "=ds=#s10#, #a4#"};
				{ 4, 55869, "", "=q3=Veneficial Band", "=ds=#s13#"};
				{ 5, 55868, "", "=q3=Heart of Solace", "=ds=#s14#"};
				{ 6, 55870, "", "=q3=Barim's Main Gauche", "=ds=#h1#, #w4#"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5291#"};
				{ 17, 56389, "", "=q3=Sand Silk Wristband", "=ds=#s8#, #a1#"};
				{ 18, 56392, "", "=q3=Sand Dune Belt", "=ds=#s10#, #a4#"};
				{ 19, 56391, "", "=q3=Veneficial Band", "=ds=#s13#"};
				{ 20, 56393, "", "=q3=Heart of Solace", "=ds=#s14#"};
				{ 21, 56390, "", "=q3=Barim's Main Gauche", "=ds=#h1#, #w4#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lockmaw", 118),
			module = moduleName, instance = "LostCityOfTolvir",
		};
	};

	AtlasLoot_Data["LostCityBarim"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55861, "", "=q3=Balkar's Waders", "=ds=#s11#, #a3#"};
				{ 3, 55862, "", "=q3=Greaves of Wu the Younger", "=ds=#s12#, #a4#"};
				{ 4, 55864, "", "=q3=Tauntka's Necklace", "=ds=#s2#"};
				{ 5, 55863, "", "=q3=Ring of the Darkest Day", "=ds=#s13#"};
				{ 6, 55865, "", "=q3=Resonant Kris", "=ds=#h1#, #w10#"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5290#"};
				{ 17, 56386, "", "=q3=Balkar's Waders", "=ds=#s11#, #a3#"};
				{ 18, 56387, "", "=q3=Greaves of Wu the Younger", "=ds=#s12#, #a4#"};
				{ 19, 56385, "", "=q3=Tauntka's Necklace", "=ds=#s2#"};
				{ 20, 56388, "", "=q3=Ring of the Darkest Day", "=ds=#s13#"};
				{ 21, 56384, "", "=q3=Resonant Kris", "=ds=#h1#, #w10#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Prophet Barim", 119),
			module = moduleName, instance = "LostCityOfTolvir",
		};
	};

	AtlasLoot_Data["LostCitySiamat"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55872, "", "=q3=Geordan's Cloak", "=ds=#s4#"};
				{ 3, 55876, "", "=q3=Mantle of Master Cho", "=ds=#s3#, #a1#"};
				{ 4, 55878, "", "=q3=Evelyn's Belt", "=ds=#s10#, #a1#"};
				{ 5, 55877, "", "=q3=Leggings of the Path", "=ds=#s11#, #a2#"};
				{ 6, 55871, "", "=q3=Crafty's Gaiters", "=ds=#s12#, #a2#"};
				{ 7, 55873, "", "=q3=Ring of Three Lights", "=ds=#s13#"};
				{ 8, 55874, "", "=q3=Tia's Grace", "=ds=#s14#"};
				{ 9, 55879, "", "=q3=Sorrowsong", "=ds=#s14#"};
				{ 10, 55875, "", "=q3=Hammer of Sparks", "=ds=#h1#, #w6#"};
				{ 11, 55880, "", "=q3=Zora's Ward", "=ds=#w8#"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5292#"};
				{ 17, 56397, "", "=q3=Geordan's Cloak", "=ds=#s4#"};
				{ 18, 56399, "", "=q3=Mantle of Master Cho", "=ds=#s3#, #a1#"};
				{ 19, 56403, "", "=q3=Evelyn's Belt", "=ds=#s10#, #a1#"};
				{ 20, 56401, "", "=q3=Leggings of the Path", "=ds=#s11#, #a2#"};
				{ 21, 56395, "", "=q3=Crafty's Gaiters", "=ds=#s12#, #a2#"};
				{ 22, 56398, "", "=q3=Ring of Three Lights", "=ds=#s13#"};
				{ 23, 56394, "", "=q3=Tia's Grace", "=ds=#s14#"};
				{ 24, 56400, "", "=q3=Sorrowsong", "=ds=#s14#"};
				{ 25, 56396, "", "=q3=Hammer of Sparks", "=ds=#h1#, #w6#"};
				{ 26, 56402, "", "=q3=Zora's Ward", "=ds=#w8#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Siamat, Lord of South Wind", 122),
			module = moduleName, instance = "LostCityOfTolvir",
		};
	};

	AtlasLoot_Data["LostCityTrash"] = {
		["Normal"] = {
			{
				{ 2, 55882, "", "=q3=Oasis Bracers", "=ds=#s8#, #a2#"};
				{ 17, 55884, "", "=q3=Mirage Ring", "=ds=#s13#"};
				{ 18, 55881, "", "=q3=Impetuous Query", "=ds=#s14#"};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "LostCityOfTolvir",
		};
	};

		-----------------------
		--- Shadowfang Keep ---
		-----------------------

	AtlasLoot_Data["ShadowfangAshbury"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 6314, "", "=q3=Wolfmaster Cape", "=ds=#s4#" };
				{ 3, 6324, "", "=q3=Robes of Arugal", "=ds=#s5#, #a1#" };
				{ 4, 6323, "", "=q3=Baron's Scepter", "=ds=#h1#, #w6#" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5503#"};
				{ 17, 63433, "", "=q3=Robes of Arugal", "=ds=#s5#, #a1#" };
				{ 18, 63437, "", "=q3=Baron Ashbury's Cuffs", "=ds=#s8#, #a1#" };
				{ 19, 63435, "", "=q3=Boots of the Predator", "=ds=#s12#, #a2#" };
				{ 20, 63436, "", "=q3=Traitor's Grips", "=ds=#s9#, #a3#" };
				{ 21, 63434, "", "=q3=Gloves of the Greymane Wall", "=ds=#s9#, #a4#" };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Baron Ashbury", 96),
			module = moduleName, instance = "ShadowfangKeep",
		};
	};

	AtlasLoot_Data["ShadowfangSilverlaine"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 6321, "", "=q3=Silverlaine's Family Seal", "=ds=#s13#" };
				{ 3, 6323, "", "=q3=Baron's Scepter", "=ds=#h1#, #w6#" };
				{ 5, 60885, "", "=q1=Silverlaine Family Sword", "=ds=#m3#, =q1=#m1# =ds=#c9#", "", "100%" };
				{ 6, 60878, "", "=q1=Silverlaine's Enchanted Crystal", "=ds=#m3#, =q1=#m1# =ds=#c3#", "", "100%" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 63440, "", "=q3=Boots of Lingering Sorrow", "=ds=#s12#, #a1#" };
				{ 18, 63439, "", "=q3=Gloves of the Uplifted Cup", "=ds=#s9#, #a2#" };
				{ 19, 63444, "", "=q3=Baron Silverlaine's Greaves", "=ds=#s12#, #a4#" };
				{ 20, 63438, "", "=q3=Baroness Silverlaine's Locket", "=ds=#s2#" };
				{ 21, 63441, "", "=q3=Pendant of the Keep", "=ds=#s2#" };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Baron Silverlaine", 97),
			module = moduleName, instance = "ShadowfangKeep",
		};
	};

	AtlasLoot_Data["ShadowfangSpringvale"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 3191, "", "=q3=Arced War Axe", "=ds=#h2#, #w1#" };
				{ 3, 6320, "", "=q3=Commander's Crest", "=ds=#w8#" };
				{ 5, 60879, "", "=q1=Commander's Holy Symbol", "=ds=#m3#, =q1=#m1# =ds=#c4#, =ds=#c5#", "", "100%" };
				{ 6, 60880, "", "=q1=Springvale's Sharpening Stone", "=ds=#m3#, =q1=#m1# =ds=#c6#", "", "100%" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5504#"};
				{ 17, 63448, "", "=q3=Springvale's Cloak", "=ds=#s4#" };
				{ 18, 63449, "", "=q3=Thieving Spaulders", "=ds=#s3#, #a2#" };
				{ 19, 63447, "", "=q3=Breastplate of the Stilled Heart", "=ds=#s5#, #a3#" };
				{ 20, 63446, "", "=q3=Haunting Footfalls", "=ds=#s12#, #a3#" };
				{ 21, 63445, "", "=q3=Arced War Axe", "=ds=#h2#, #w1#" };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Commander Springvale", 98),
			module = moduleName, instance = "ShadowfangKeep",
		};
	};

	AtlasLoot_Data["ShadowfangWalden"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 3230, "", "=q3=Black Wolf Bracers", "=ds=#s8#, #a2#" };
				{ 3, 6642, "", "=q3=Phantom Armor", "=ds=#s5#, #a3#" };
				{ 4, 6341, "", "=q3=Eerie Stable Lantern", "=ds=#s15#" };
				{ 5, 1292, "", "=q3=Butcher's Cleaver", "=ds=#h1#, #w1#" };
				{ 7, 60876, "", "=q1=Walden's Elixirs", "=ds=#m3#, =q1=#m1# =ds=#c1#", "", "100%" };
				{ 8, 60881, "", "=q1=Walden's Talisman", "=ds=#m3#, =q1=#m1# =ds=#c7#", "", "100%" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 63455, "", "=q3=Blinders of the Follower", "=ds=#s1#, #a1#" };
				{ 18, 63454, "", "=q3=Double Dealing Bracers", "=ds=#s8#, #a2#" };
				{ 19, 63452, "", "=q3=Burden of Lost Humanity", "=ds=#s3#, #a3#" };
				{ 20, 63450, "", "=q3=Phantom Armor", "=ds=#s5#, #a4#" };
				{ 21, 63453, "", "=q3=Iron Will Girdle", "=ds=#s10#, #a4#" };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lord Walden", 99),
			module = moduleName, instance = "ShadowfangKeep",
		};
	};

	AtlasLoot_Data["ShadowfangGodfrey"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 3748, "", "=q3=Feline Mantle", "=ds=#s3#, #a1#" };
				{ 3, 6220, "", "=q3=Meteor Shard", "=ds=#h1#, #w4#" };
				{ 4, 6641, "", "=q3=Haunting Blade", "=ds=#h2#, #w10#" };
				{ 5, 6318, "", "=q3=Odo's Ley Staff", "=ds=#w9#" };
				{ 7, 60877, "", "=q1=Godfrey's Crystal Scope", "=ds=#m3#, =q1=#m1# =ds=#c2#", "", "100%" };
				{ 8, 60882, "", "=q1=Tenebrous Orb", "=ds=#m3#, =q1=#m1# =ds=#c8#", "", "100%" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5505#"};
				{ 17, 63465, "", "=q3=Mantle of Loss", "=ds=#s3#, #a1#" };
				{ 18, 63463, "", "=q3=Mantle of the Eastern Lords", "=ds=#s3#, #a1#" };
				{ 19, 63459, "", "=q3=Worgen Hunter's Helm", "=ds=#s1#, #a3#" };
				{ 20, 63462, "", "=q3=Helm of Untold Stories", "=ds=#s1#, #a4#" };
				{ 21, 63458, "", "=q3=Lord Walden's Breastplate", "=ds=#s5#, #a4#" };
				{ 22, 63457, "", "=q3=Shackles of Undeath", "=ds=#s8#, #a4#" };
				{ 23, 63464, "", "=q3=Greaves of the Misguided", "=ds=#s11#, #a4#" };
				{ 24, 63456, "", "=q3=Meteor Shard", "=ds=#h1#, #w4#" };
				{ 25, 63461, "", "=q3=Staff of Isolation", "=ds=#w9#" };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lord Godfrey", 100),
			module = moduleName, instance = "ShadowfangKeep",
		};
	};

	AtlasLoot_Data["ShadowfangTrash"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 1974, "", "=q3=Mindthrust Bracers", "=ds=#s8#, #a1#", "", "0.01%"};
				{ 3, 3194, "", "=q3=Black Malice", "=ds=#h2#, #w6#", "", "0.01%"};
				{ 4, 1483, "", "=q3=Face Smasher", "=ds=#h1#, #w6#", "", "0.01%"};
				{ 5, 2807, "", "=q3=Guillotine Axe", "=ds=#h1#, #w1#", "", "0.01%"};
				{ 6, 1318, "", "=q3=Night Reaver", "=ds=#h2#, #w1#", "", "0.01%"};
				{ 7, 1484, "", "=q3=Witching Stave", "=ds=#h2#, #w9#", "", "0.01%"};
				{ 17, 60977, "", "=q1=Orders from High Command", "=ds=#m3#"};
				{ 18, 60874, "", "=q1=Deathless Sinew", "=ds=#m3#", "", "100%"};
				{ 19, 60875, "", "=q1=Ghostly Essence", "=ds=#m3#", "", "100%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "ShadowfangKeep",
		};
	};

		---------------------
		--- The Deadmines ---
		---------------------

	AtlasLoot_Data["DeadminesGlubtok"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 5444, "", "=q3=Miner's Cape", "=ds=#s4#", ""};
				{ 3, 5195, "", "=q3=Gold-Flecked Gloves", "=ds=#s9#, #a1#", "" };
				{ 4, 2169, "", "=q3=Buzzer Blade", "=ds=#h1#, #w4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 63467, "", "=q3=Shadow of the Past", "=ds=#s4#", ""};
				{ 18, 63468, "", "=q3=Defias Brotherhood Vest", "=ds=#s5#, #a2#", ""};
				{ 19, 63471, "", "=q3=Vest of the Curious Visitor", "=ds=#s5#, #a2#", ""};
				{ 20, 63470, "", "=q3=Missing Diplomat's Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 21, 65163, "", "=q3=Buzzer Blade", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Glubtok", 89),
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

	AtlasLoot_Data["DeadminesGearbreaker"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 5199, "", "=q3=Smelting Pants", "=ds=#s11#, #a2#", "" };
				{ 3, 5191, "", "=q3=Cruel Barb", "=ds=#h1#, #w10#", "" };
				{ 4, 5200, "", "=q3=Impaling Harpoon", "=ds=#w7#", "" };
				{ 5, 5443, "", "=q3=Gold-Plated Buckler", "=ds=#w8#", "" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5367#"};
				{ 17, 63473, "", "=q3=Cloak of Thredd", "=ds=#s4#", ""};
				{ 18, 63475, "", "=q3=Old Friend's Gloves", "=ds=#s9#, #a3#", ""};
				{ 19, 63476, "", "=q3=Gearbreaker's Bindings", "=ds=#s8#, #a4#", ""};
				{ 20, 63474, "", "=q3=Gear-Marked Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 21, 65164, "", "=q3=Cruel Barb", "=ds=#h1#, #w10#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Helix Gearbreaker", 90),
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

	AtlasLoot_Data["DeadminesFoeReaper"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 1937, "", "=q3=Buzz Saw", "=ds=#h1#, #w10#", "", };
				{ 3, 5187, "", "=q3=Foe Reaper", "=ds=#h2#, #w6#", ""};
				{ 4, 5201, "", "=q3=Emberstone Staff", "=ds=#w9#", "" };
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5368#"};
				{ 17, 65166, "", "=q3=Buzz Saw", "=ds=#h1#, #w10#", ""};
				{ 18, 65165, "", "=q3=Foe Reaper", "=ds=#h2#, #w6#", ""};
				{ 19, 65167, "", "=q3=Emberstone Staff", "=ds=#w9#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Foe Reaper 5000", 91),
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

	AtlasLoot_Data["DeadminesRipsnarl"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 1156, "", "=q3=Lavishly Jeweled Ring", "=ds=#s13#", "", };
				{ 3, 5196, "", "=q3=Smite's Reaver", "=ds=#h1#, #w1#", ""};
				{ 4, 872, "", "=q3=Rockslicer", "=ds=#h2#, #w1#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5369#"};
				{ 17, 65169, "", "=q3=Lavishly Jeweled Ring", "=ds=#s13#", ""};
				{ 18, 65170, "", "=q3=Smite's Reaver", "=ds=#h1#, #w1#", ""};
				{ 19, 65168, "", "=q3=Rockslicer", "=ds=#h2#, #w1#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Admiral Ripsnarl", 92),
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

	AtlasLoot_Data["DeadminesCookie"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 5193, "", "=q3=Cape of the Brotherhood", "=ds=#s4#", "" };
				{ 3, 5202, "", "=q3=Corsair's Overshirt", "=ds=#s5#, #a1#", "" };
				{ 4, 5192, "", "=q3=Thief's Blade", "=ds=#h1#, #w10#", ""};
				{ 5, 5197, "", "=q3=Cookie's Tenderizer", "=ds=#h1#, #w6#", "", };
				{ 6, 5198, "", "=q3=Cookie's Stirring Rod", "=ds=#w12#", "", };
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5370#"};
				{ 17, 65177, "", "=q3=Cape of the Brotherhood", "=ds=#s4#", ""};
				{ 18, 65174, "", "=q3=Corsair's Overshirt", "=ds=#s5#, #a1#", ""};
				{ 19, 65173, "", "=q3=Thief's Blade", "=ds=#h1#, #w10#", ""};
				{ 20, 65171, "", "=q3=Cookie's Tenderizer", "=ds=#h1#, #w6#", ""};
				{ 21, 65172, "", "=q3=Cookie's Stirring Rod", "=ds=#w12#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("\"Captain\" Cookie", 93),
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

	AtlasLoot_Data["DeadminesVanessa"] = {
		["Heroic"] = {
			{
				{ 1, 63484, "", "=q3=Armbands of Exiled Architects", "=ds=#s8#, #a1#", "" };
				{ 2, 63482, "", "=q3=Daughter's Hands", "=ds=#s9#, #a1#", "" };
				{ 3, 63485, "", "=q3=Cowl of Rebellion", "=ds=#s1#, #a2#", "" };
				{ 4, 65178, "", "=q3=VanCleef's Boots", "=ds=#s12#, #a2#", "" };
				{ 5, 63479, "", "=q3=Bracers of Some Consequence", "=ds=#s8#, #a3#", "" };
				{ 6, 63486, "", "=q3=Shackles of the Betrayed", "=ds=#s8#, #a3#", "" };
				{ 7, 63478, "", "=q3=Stonemason's Helm", "=ds=#s1#, #a4#", "" };
				{ 8, 63483, "", "=q3=Guildmaster's Greaves", "=ds=#s12#, #a4#", "" };
				{ 16, 63477, "", "=q3=Wicked Dagger", "=ds=#h1#, #w4#", "" };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Vanessa VanCleef", 95),
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

	AtlasLoot_Data["DeadminesTrash"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 1930, "", "=q3=Stonemason Cloak", "=ds=#s4#", "", "0.01%"};
				{ 3, 1951, "", "=q3=Blackwater Cutlass", "=ds=#h1#, #w10#", "", "0.01%"};
				{ 4, 1926, "", "=q3=Weighted Sap", "=ds=#h1#, #w6#", "", "0.01%"};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Marisa du'Paige"], "=ec1=#j28#"};
				{ 17, 3019, "", "=q3=Noble's Robe", "=ds=#s5#, #a1#", "", "22.4%"};
				{ 18, 4660, "", "=q3=Walking Boots", "=ds=#s12#, #a1#", "", "71.4%"};
				{ 20, 0, "INV_Box_01", "=q6="..BabbleBoss["Brainwashed Noble"], "=ec1=#j28#"};
				{ 21, 5967, "", "=q3=Girdle of Nobility", "=ds=#s10#, #a1#", "", "70.4%"};
				{ 22, 3902, "", "=q3=Staff of Nobles", "=ds=#w9#", "", "23.0%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

		---------------------
		--- The Stonecore ---
		---------------------

	AtlasLoot_Data["StonecoreCorborus"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55793, "", "=q3=Dolomite Adorned Gloves", "=ds=#s9#, #a1#", ""};
				{ 3, 55792, "", "=q3=Cinnabar Shoulders", "=ds=#s3#, #a4#", ""};
				{ 4, 55794, "", "=q3=Phosphorescent Ring", "=ds=#s13#", ""};
				{ 5, 55795, "", "=q3=Key to the Endless Chamber", "=ds=#s14#", ""};
				{ 6, 55796, "", "=q3=Fist of Pained Senses", "=ds=#h1#, #w13#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56331, "", "=q3=Dolomite Adorned Gloves", "=ds=#s9#, #a1#", ""};
				{ 18, 56330, "", "=q3=Cinnabar Shoulders", "=ds=#s3#, #a4#", ""};
				{ 19, 56332, "", "=q3=Phosphorescent Ring", "=ds=#s13#", ""};
				{ 20, 56328, "", "=q3=Key to the Endless Chamber", "=ds=#s14#", ""};
				{ 21, 56329, "", "=q3=Fist of Pained Senses", "=ds=#h1#, #w13#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Corborus", 110),
			module = moduleName, instance = "TheStonecore",
		};
	};

	AtlasLoot_Data["StonecoreSlabhide"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 63043, "", "=q4=Reins of the Vitreous Stone Drake", "=ds=#e27#", "", "1%"};
				{ 3, 55798, "", "=q3=Deep Delving Gloves", "=ds=#s9#, #a2#", ""};
				{ 4, 55797, "", "=q3=Hematite Plate Gloves", "=ds=#s9#, #a4#", ""};
				{ 5, 55799, "", "=q3=Rose Quartz Band", "=ds=#s13#", ""};
				{ 6, 55801, "", "=q3=Quicksilver Blade", "=ds=#h1#, #w4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 63043, "", "=q4=Reins of the Vitreous Stone Drake", "=ds=#e27#", "", "1%"};
				{ 18, 56334, "", "=q3=Deep Delving Gloves", "=ds=#s9#, #a2#", ""};
				{ 19, 56336, "", "=q3=Hematite Plate Gloves", "=ds=#s9#, #a4#", ""};
				{ 20, 56333, "", "=q3=Rose Quartz Band", "=ds=#s13#", ""};
				{ 21, 56335, "", "=q3=Quicksilver Blade", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Slabhide", 111),
			module = moduleName, instance = "TheStonecore",
		};
	};

	AtlasLoot_Data["StonecoreOzruk"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55802, "", "=q3=Elementium Scale Bracers", "=ds=#s8#, #a3#", ""};
				{ 3, 55803, "", "=q3=Belt of the Ringworm", "=ds=#s10#, #a4#", ""};
				{ 4, 55804, "", "=q3=Pendant of the Lightless Grotto", "=ds=#s2#", ""};
				{ 5, 55810, "", "=q3=Tendrils of Burrowing Dark", "=ds=#s14#", ""};
				{ 6, 55811, "", "=q3=Sword of the Bottomless Pit", "=ds=#h2#, #w10#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56340, "", "=q3=Elementium Scale Bracers", "=ds=#s8#, #a3#", ""};
				{ 18, 56341, "", "=q3=Belt of the Ringworm", "=ds=#s10#, #a4#", ""};
				{ 19, 56338, "", "=q3=Pendant of the Lightless Grotto", "=ds=#s2#", ""};
				{ 20, 56339, "", "=q3=Tendrils of Burrowing Dark", "=ds=#s14#", ""};
				{ 21, 56342, "", "=q3=Sword of the Bottomless Pit", "=ds=#h2#, #w10#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ozruk", 112),
			module = moduleName, instance = "TheStonecore",
		};
	};

	AtlasLoot_Data["StonecoreAzil"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55817, "", "=q3=Slippers of the Twilight Prophet", "=ds=#s12#, #a1#", ""};
				{ 3, 55812, "", "=q3=Helm of Numberless Shadows", "=ds=#s1#, #a2#", ""};
				{ 4, 55818, "", "=q3=Cowl of the Unseen World", "=ds=#s1#, #a3#", ""};
				{ 5, 55816, "", "=q3=Leaden Despair", "=ds=#s14#", ""};
				{ 6, 55814, "", "=q3=Magnetite Mirror", "=ds=#s14#", ""};
				{ 7, 55819, "", "=q3=Tear of Blood", "=ds=#s14#", ""};
				{ 8, 55820, "", "=q3=Prophet's Scepter", "=ds=#s15#", ""};
				{ 9, 55813, "", "=q3=Elementium Fang", "=ds=#h1#, #w10#", ""};
				{ 10, 55815, "", "=q3=Darkling Staff", "=ds=#w9#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5287#"};
				{ 17, 56348, "", "=q3=Slippers of the Twilight Prophet", "=ds=#s12#, #a1#", ""};
				{ 18, 56344, "", "=q3=Helm of Numberless Shadows", "=ds=#s1#, #a2#", ""};
				{ 19, 56352, "", "=q3=Cowl of the Unseen World", "=ds=#s1#, #a3#", ""};
				{ 20, 56347, "", "=q3=Leaden Despair", "=ds=#s14#", ""};
				{ 21, 56345, "", "=q3=Magnetite Mirror", "=ds=#s14#", ""};
				{ 22, 56351, "", "=q3=Tear of Blood", "=ds=#s14#", ""};
				{ 23, 56349, "", "=q3=Prophet's Scepter", "=ds=#s15#", ""};
				{ 24, 56346, "", "=q3=Elementium Fang", "=ds=#h1#, #w10#", ""};
				{ 25, 56343, "", "=q3=Darkling Staff", "=ds=#w9#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Priestess Azil", 113),
			module = moduleName, instance = "TheStonecore",
		};
	};

	AtlasLoot_Data["StonecoreTrash"] = {
		["Normal"] = {
			{
				{ 2, 55824, "", "=q3=Skin of Stone", "=ds=#s4#", ""};
				{ 17, 55822, "", "=q3=Heavy Geode Mace", "=ds=#h1#, #w6#", ""};
				{ 18, 55823, "", "=q3=Wand of Dark Worship", "=ds=#w12#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "TheStonecore",
		};
	};

		-------------------------
		--- The Vortex Pinnacle -----
		-------------------------

	AtlasLoot_Data["VPErtan"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55830, "", "=q3=Stratosphere Belt", "=ds=#s10#, #a1#", ""};
				{ 3, 55832, "", "=q3=Fallen Snow Shoulderguards", "=ds=#s3#, #a3#", ""};
				{ 4, 55831, "", "=q3=Headcover of Fog", "=ds=#s1#, #a4#", ""};
				{ 5, 55833, "", "=q3=Red Sky Pendant", "=ds=#s2#", ""};
				{ 6, 55834, "", "=q3=Biting Wind", "=ds=#h1#, #w4#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56356, "", "=q3=Stratosphere Belt", "=ds=#s10#, #a1#", ""};
				{ 18, 56359, "", "=q3=Fallen Snow Shoulderguards", "=ds=#s3#, #a3#", ""};
				{ 19, 56358, "", "=q3=Headcover of Fog", "=ds=#s1#, #a4#", ""};
				{ 20, 56360, "", "=q3=Red Sky Pendant", "=ds=#s2#", ""};
				{ 21, 56357, "", "=q3=Biting Wind", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Grand Vizier Ertan", 114),
			module = moduleName, instance = "TheVortexPinnacle",
		};
	};

	AtlasLoot_Data["VPAltairus"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 63040, "", "=q4=Reins of the Drake of the North Wind", "=ds=#e27#", "", "1%"};
				{ 3, 55838, "", "=q3=Mantle of Bestilled Winds", "=ds=#s3#, #a2#", ""};
				{ 4, 55835, "", "=q3=Hail-Strung Belt", "=ds=#s10#, #a3#", ""};
				{ 5, 55840, "", "=q3=Amulet of Tender Breath", "=ds=#s2#", ""};
				{ 6, 55839, "", "=q3=Skyshard Ring", "=ds=#s13#", ""};
				{ 7, 55841, "", "=q3=Axe of the Eclipse", "=ds=#h1#, #w1#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 63040, "", "=q4=Reins of the Drake of the North Wind", "=ds=#e27#", "", "1%"};
				{ 18, 56361, "", "=q3=Mantle of Bestilled Winds", "=ds=#s3#, #a2#", ""};
				{ 19, 56363, "", "=q3=Hail-Strung Belt", "=ds=#s10#, #a3#", ""};
				{ 20, 56362, "", "=q3=Amulet of Tender Breath", "=ds=#s2#", ""};
				{ 21, 56365, "", "=q3=Skyshard Ring", "=ds=#s13#", ""};
				{ 22, 56364, "", "=q3=Axe of the Eclipse", "=ds=#h1#, #w1#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Altairus", 115),
			module = moduleName, instance = "TheVortexPinnacle",
		};
	};

	AtlasLoot_Data["VPAsaad"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55847, "", "=q3=Billowing Cape", "=ds=#s4#", ""};
				{ 3, 55850, "", "=q3=Shadow of Perfect Bliss", "=ds=#s4#", ""};
				{ 4, 55849, "", "=q3=Leggings of Iridescent Clouds", "=ds=#s11#, #a1#", ""};
				{ 5, 55844, "", "=q3=Gloves of Haze", "=ds=#s9#, #a2#", ""};
				{ 6, 55848, "", "=q3=Lunar Halo", "=ds=#s1#, #a4#", ""};
				{ 7, 55842, "", "=q3=Legguards of Winnowing Wind", "=ds=#s11#, #a4#", ""};
				{ 8, 55851, "", "=q3=Ring of Frozen Rain", "=ds=#s13#", ""};
				{ 9, 55845, "", "=q3=Heart of Thunder", "=ds=#s14#", ""};
				{ 10, 55846, "", "=q3=Lightningflash", "=ds=#w5#", ""};
				{ 11, 55853, "", "=q3=Thundercall", "=ds=#w5#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5288#"};
				{ 17, 56369, "", "=q3=Billowing Cape", "=ds=#s4#", ""};
				{ 18, 56371, "", "=q3=Shadow of Perfect Bliss", "=ds=#s4#", ""};
				{ 19, 56375, "", "=q3=Leggings of Iridescent Clouds", "=ds=#s11#, #a1#", ""};
				{ 20, 56368, "", "=q3=Gloves of Haze", "=ds=#s9#, #a2#", ""};
				{ 21, 56374, "", "=q3=Lunar Halo", "=ds=#s1#, #a4#", ""};
				{ 22, 56367, "", "=q3=Legguards of Winnowing Wind", "=ds=#s11#, #a4#", ""};
				{ 23, 56373, "", "=q3=Ring of Frozen Rain", "=ds=#s13#", ""};
				{ 24, 56370, "", "=q3=Heart of Thunder", "=ds=#s14#", ""};
				{ 25, 56366, "", "=q3=Lightningflash", "=ds=#w5#", ""};
				{ 26, 56376, "", "=q3=Thundercall", "=ds=#w5#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Asaad", 116),
			module = moduleName, instance = "TheVortexPinnacle",
		};
	};

	AtlasLoot_Data["VPTrash"] = {
		["Normal"] = {
			{
				{ 2, 55855, "", "=q3=Darksky Treads", "=ds=#s12#, #a4#", ""};
				{ 17, 55854, "", "=q3=Rainsong", "=ds=#s14#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "TheVortexPinnacle",
		};
	};

		---------------------------
		--- Throne of the Tides ---
		---------------------------

	AtlasLoot_Data["TotTNazjar"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55202, "", "=q3=Periwinkle Cloak", "=ds=#s4#", ""};
				{ 3, 55198, "", "=q3=Aurelian Mitre", "=ds=#s1#, #a1#", ""};
				{ 4, 55195, "", "=q3=Wrasse Handwraps", "=ds=#s9#, #a3#", ""};
				{ 5, 55201, "", "=q3=Entwined Nereis", "=ds=#s13#", ""};
				{ 6, 55203, "", "=q3=Lightning Whelk Axe", "=ds=#h1#, #w1#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5285#"};
				{ 17, 56267, "", "=q3=Periwinkle Cloak", "=ds=#s4#", ""};
				{ 18, 56269, "", "=q3=Aurelian Mitre", "=ds=#s1#, #a1#", ""};
				{ 19, 56268, "", "=q3=Wrasse Handwraps", "=ds=#s9#, #a3#", ""};
				{ 20, 56270, "", "=q3=Entwined Nereis", "=ds=#s13#", ""};
				{ 21, 56266, "", "=q3=Lightning Whelk Axe", "=ds=#h1#, #w1#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lady Naz'jar", 101),
			module = moduleName, instance = "ThroneOfTheTides",
		};
	};

	AtlasLoot_Data["TotTUlthok"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55206, "", "=q3=Eagle Ray Cloak", "=ds=#s4#", ""};
				{ 3, 55204, "", "=q3=Caridean Epaulettes", "=ds=#s3#, #a2#", ""};
				{ 4, 55205, "", "=q3=Chromis Chestpiece", "=ds=#s5#, #a3#", ""};
				{ 5, 55207, "", "=q3=Harp Shell Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 6, 55228, "", "=q3=Cerith Spire Staff", "=ds=#w9#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56275, "", "=q3=Eagle Ray Cloak", "=ds=#s4#", ""};
				{ 18, 56273, "", "=q3=Caridean Epaulettes", "=ds=#s3#, #a2#", ""};
				{ 19, 56274, "", "=q3=Chromis Chestpiece", "=ds=#s5#, #a3#", ""};
				{ 20, 56272, "", "=q3=Harp Shell Pauldrons", "=ds=#s3#, #a4#", ""};
				{ 21, 56271, "", "=q3=Cerith Spire Staff", "=ds=#w9#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Commander Ulthok", 102),
			module = moduleName, instance = "ThroneOfTheTides",
		};
	};

	AtlasLoot_Data["TotTMindbender"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55236, "", "=q3=Anthia's Ring", "=ds=#s13#", ""};
				{ 3, 55235, "", "=q3=Decapod Slippers", "=ds=#s12#, #a2#", ""};
				{ 4, 55229, "", "=q3=Anomuran Helm", "=ds=#s1#, #a4#", ""};
				{ 5, 55237, "", "=q3=Porcelain Crab", "=ds=#s14#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 56276, "", "=q3=Anthia's Ring", "=ds=#s13#", ""};
				{ 18, 56277, "", "=q3=Decapod Slippers", "=ds=#s12#, #a2#", ""};
				{ 19, 56278, "", "=q3=Anomuran Helm", "=ds=#s1#, #a4#", ""};
				{ 20, 56280, "", "=q3=Porcelain Crab", "=ds=#s14#", ""};
			};
		};
		info = {
			name = BabbleBoss["Erunak Stonespeaker"].." & "..AtlasLoot:EJ_GetBossName("Mindbender Ghur'sha", 103),
			module = moduleName, instance = "ThroneOfTheTides",
		};
	};

	AtlasLoot_Data["TotTOzumat"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 55255, "", "=q3=Mnemiopsis Gloves", "=ds=#s9#, #a1#", ""};
				{ 3, 55253, "", "=q3=Wentletrap Vest", "=ds=#s5#, #a3#", ""};
				{ 4, 55254, "", "=q3=Abalone Plate Armor", "=ds=#s5#, #a4#", ""};
				{ 5, 55249, "", "=q3=Triton Legplates", "=ds=#s11#, #a4#", ""};
				{ 6, 55258, "", "=q3=Pipefish Cord", "=ds=#s2#", ""};
				{ 7, 55250, "", "=q3=Nautilus Ring", "=ds=#s13#", ""};
				{ 8, 55251, "", "=q3=Might of the Ocean", "=ds=#s14#", ""};
				{ 9, 55256, "", "=q3=Sea Star", "=ds=#s14#", ""};
				{ 10, 55259, "", "=q3=Bioluminescent Lamp", "=ds=#s15#", ""};
				{ 11, 55252, "", "=q3=Whitefin Axe", "=ds=#h2#, #w1#", ""};
				{ 16, 0, "inv_box_04", "=q6=#j3#", "#ACHIEVEMENTID:5286#"};
				{ 17, 56286, "", "=q3=Mnemiopsis Gloves", "=ds=#s9#, #a1#", ""};
				{ 18, 56281, "", "=q3=Wentletrap Vest", "=ds=#s5#, #a3#", ""};
				{ 19, 56291, "", "=q3=Abalone Plate Armor", "=ds=#s5#, #a4#", ""};
				{ 20, 56283, "", "=q3=Triton Legplates", "=ds=#s11#, #a4#", ""};
				{ 21, 56288, "", "=q3=Pipefish Cord", "=ds=#s2#", ""};
				{ 22, 56282, "", "=q3=Nautilus Ring", "=ds=#s13#", ""};
				{ 23, 56285, "", "=q3=Might of the Ocean", "=ds=#s14#", ""};
				{ 24, 56290, "", "=q3=Sea Star", "=ds=#s14#", ""};
				{ 25, 56289, "", "=q3=Bioluminescent Lamp", "=ds=#s15#", ""};
				{ 26, 56284, "", "=q3=Whitefin Axe", "=ds=#h2#, #w1#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ozumat", 104),
			module = moduleName, instance = "ThroneOfTheTides",
		};
	};

	AtlasLoot_Data["TotTTrash"] = {
		["Normal"] = {
			{
				{ 2, 55260, "", "=q3=Alpheus Legguards", "=ds=#s11#, #a4#", ""};
				{ 17, 55262, "", "=q3=Barnacle Pendant", "=ds=#s2#", ""};
				{ 18, 55261, "", "=q3=Ring of the Great Whale", "=ds=#s13#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "ThroneOfTheTides",
		};
	};

		----------------
		--- Zul'Aman ---
		----------------

	AtlasLoot_Data["ZAAkilZon"] = {
		["Heroic"] = {
			{
				{ 1, 69550, "", "=q4=Leggings of Ancient Magics", "=ds=#s11#, #a1#"};
				{ 2, 69551, "", "=q4=Feathers of Akil'zon", "=ds=#s3#, #a2#"};
				{ 3, 69549, "", "=q4=Wristguards of the Predator", "=ds=#s8#, #a3#"};
				{ 4, 69552, "", "=q4=Bracers of Hidden Purpose", "=ds=#s8#, #a4#"};
				{ 5, 69553, "", "=q4=Talonguard Band", "=ds=#s13#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Akil'zon", 186),
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZANalorakk"] = {
		["Heroic"] = {
			{
				{ 1, 69555, "", "=q4=Boots of the Ursine", "=ds=#s12#, #a1#"};
				{ 2, 69556, "", "=q4=Armbands of the Bear Spirit", "=ds=#s8#, #a2#"};
				{ 3, 69554, "", "=q4=Pauldrons of Nalorakk", "=ds=#s3#, #a3#"};
				{ 4, 69558, "", "=q4=Spiritshield Mask", "=ds=#s1#, #a4#"};
				{ 5, 69557, "", "=q4=Jungle Striders", "=ds=#s11#, #a4#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Nalorakk", 187),
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZAJanAlai"] = {
		["Heroic"] = {
			{
				{ 1, 69560, "", "=q4=Jan'alai's Spaulders", "=ds=#s3#, #a1#"};
				{ 2, 69559, "", "=q4=Amani'shi Bracers", "=ds=#s8#, #a2#"};
				{ 3, 69561, "", "=q4=Hawkscale Waistguard", "=ds=#s10#, #a3#"};
				{ 4, 69562, "", "=q4=Boots of Bad Mojo", "=ds=#s12#, #a4#"};
				{ 5, 69563, "", "=q4=Ring of the Numberless Brood", "=ds=#s13#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Jan'alai", 188),
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZAHalazzi"] = {
		["Heroic"] = {
			{
				{ 1, 69567, "", "=q4=Wristwraps of Departed Spirits", "=ds=#s8#, #a1#"};
				{ 2, 69564, "", "=q4=The Savager's Mask", "=ds=#s1#, #a2#"};
				{ 3, 69565, "", "=q4=Breastplate of Primal Fury", "=ds=#s5#, #a3#"};
				{ 4, 69568, "", "=q4=Shadowmender Wristguards", "=ds=#s8#, #a3#"};
				{ 5, 69566, "", "=q4=Shimmerclaw Band", "=ds=#s13#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Halazzi", 189),
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZAMalacrass"] = {
		["Heroic"] = {
			{
				{ 1, 69572, "", "=q4=Hex Lord's Bloody Cloak", "=ds=#s4#"};
				{ 2, 69569, "", "=q4=Shadowtooth Trollskin Breastplate", "=ds=#s5#, #a2#"};
				{ 3, 69570, "", "=q4=Waistband of Hexes", "=ds=#s10#, #a3#"};
				{ 4, 69573, "", "=q4=Pauldrons of Sacrifice", "=ds=#s3#, #a4#"};
				{ 5, 69571, "", "=q4=Soul Drain Signet", "=ds=#s13#"};
				{ 6, 69762, "", "=q4=Miniature Voodoo Mask", "=ds=#s14#"};
				{ 8, 69264, "", "=q1=The Hex Lord's Fetish", "=ds=#m3#"};
				{ 16, 70080, "", "=q4=Reforged Heartless", "=ds=#h1#, #w10#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Hex Lord Malacrass", 190),
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZADaakara"] = {
		["Heroic"] = {
			{
				{ 1, 69577, "", "=q4=Collar of Bones", "=ds=#s1#, #a1#"};
				{ 2, 69578, "", "=q4=Hexing Robes", "=ds=#s5#, #a1#"};
				{ 3, 69579, "", "=q4=Amani Headdress", "=ds=#s1#, #a2#"};
				{ 4, 69574, "", "=q4=Tusked Shoulderpads", "=ds=#s3#, #a2#"};
				{ 5, 69576, "", "=q4=Headdress of Sharpened Vision", "=ds=#s1#, #a3#"};
				{ 6, 69580, "", "=q4=Mask of Restless Spirits", "=ds=#s1#, #a3#"};
				{ 7, 69582, "", "=q4=Skullpiercer Pauldrons", "=ds=#s3#, #a4#"};
				{ 8, 69583, "", "=q4=Legguards of the Unforgiving", "=ds=#s11#, #a4#"};
				{ 16, 69581, "", "=q4=Amani Scepter of Rites", "=ds=#h1#, #w6#"};
				{ 17, 69575, "", "=q4=Mace of the Sacrificed", "=ds=#h1#, #w6#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Daakara", 191),
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZATimedChest"] = {
		["Heroic"] = {
			{
				{ 1, 69584, "", "=q4=Recovered Cloak of Frostheim", "=ds=#s4#"};
				{ 2, 69585, "", "=q4=Wristwraps of Madness", "=ds=#s8#, #a1#"};
				{ 3, 69589, "", "=q4=Leggings of Dancing Blades", "=ds=#s11#, #a2#"};
				{ 4, 69586, "", "=q4=Two-Toed Boots", "=ds=#s12#, #a2#"};
				{ 5, 69590, "", "=q4=Mojo-Mender's Gloves", "=ds=#s9#, #a3#"};
				{ 6, 69593, "", "=q4=Battleplate of the Amani Empire", "=ds=#s5#, #a4#"};
				{ 7, 69587, "", "=q4=Chestplate of Hubris", "=ds=#s5#, #a4#"};
				{ 8, 69588, "", "=q4=Skullcrusher Warboots", "=ds=#s12#, #a4#"};
				{ 16, 69591, "", "=q4=Voodoo Hexblade", "=ds=#h1#, #w4#"};
				{ 17, 69592, "", "=q4=Reforged Trollbane", "=ds=#h2#, #w1#"};
				{ 19, 69747, "", "=q4=Amani Battle Bear", "=ds=#e26#", ""};
			};
		};
		info = {
			name = AL["Timed Reward Chest"],
			module = moduleName, instance = "ZulAman",
		};
	};

	AtlasLoot_Data["ZATrash"] = {
		["Heroic"] = {
			{
				{ 1, 69797, "", "=q4=Charmbinder Grips", "=ds=#s9#, #a1#"};
				{ 2, 69801, "", "=q4=Amani Armguards", "=ds=#s8#, #a4#"};
				{ 4, 69802, "", "=q4=Band of the Gurubashi Berserker", "=ds=#s13#"};
				{ 5, 69799, "", "=q4=Quickfinger Ring", "=ds=#s13#"};
				{ 16, 33993, "", "=q3=Mojo", "=ds=#e13#"};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "ZulAman",
		};
	};

		------------------
		--- Zul'Gurub ----
		------------------

	AtlasLoot_Data["ZGVenoxis"] = {
		["Heroic"] = {
			{
				{ 1, 69601, "", "=q4=Serpentine Leggings", "=ds=#s11#, #a1#", ""};
				{ 2, 69600, "", "=q4=Belt of Slithering Serpents", "=ds=#s10#, #a2#", ""};
				{ 3, 69603, "", "=q4=Breastplate of Serenity", "=ds=#s5#, #a3#", ""};
				{ 4, 69604, "", "=q4=Coils of Hate", "=ds=#s10#, #a4#", ""};
				{ 5, 69602, "", "=q4=Signet of Venoxis", "=ds=#s13#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Priest Venoxis", 175),
			module = moduleName, instance = "ZulGurub",
		};
	};

	AtlasLoot_Data["ZGMandokir"] = {
		["Heroic"] = {
			{
				{ 1, 69606, "", "=q4=Hakkari Loa Drape", "=ds=#s4#", ""};
				{ 2, 69608, "", "=q4=Deathcharged Wristguards", "=ds=#s8#, #a4#", ""};
				{ 3, 69605, "", "=q4=Amulet of the Watcher", "=ds=#s2#", ""};
				{ 4, 69609, "", "=q4=Bloodlord's Protector", "=ds=#h1#, #w10#", ""};
				{ 5, 69607, "", "=q4=Touch of Discord", "=ds=#w12#", ""};
				{ 7, 68823, "", "=q4=Armored Razzashi Raptor", "=ds=#e26#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Bloodlord Mandokir", 176),
			module = moduleName, instance = "ZulGurub",
		};
	};

	AtlasLoot_Data["ZGMadness"] = {
		["Heroic"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleBoss["Gri'lek"], ""};
				{ 2, 69634, "", "=q4=Fasc's Preserved Boots", "=ds=#s12#, #a2#", ""};
				{ 3, 69635, "", "=q4=Amulet of Protection", "=ds=#s2#", ""};
				{ 5, 0, "INV_Box_01", "=q6="..BabbleBoss["Hazza'rah"], ""};
				{ 6, 69636, "", "=q4=Thekal's Claws", "=ds=#h1#, #w13#", ""};
				{ 7, 69637, "", "=q4=Gurubashi Destroyer", "=ds=#w5#", ""};
				{ 9, 0, "INV_Box_01", "=q6="..BabbleBoss["Renataki"], ""};
				{ 10, 69638, "", "=q4=Arlokk's Claws", "=ds=#h1#, #w13#", ""};
				{ 11, 69639, "", "=q4=Renataki's Soul Slicer", "=ds=#h1#, #w10#", ""};
				{ 13, 0, "INV_Box_01", "=q6="..BabbleBoss["Wushoolay"], ""};
				{ 14, 69640, "", "=q4=Kilt of Forgotten Rites", "=ds=#s11#, #a3#", ""};
				{ 15, 69641, "", "=q4=Troll Skull Chestplate", "=ds=#s5#, #a4#", ""};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Shared"], ""};
				{ 17, 69630, "", "=q4=Handguards of the Tormented", "=ds=#s9#, #a3#", ""};
				{ 18, 69633, "", "=q4=Plunderer's Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 19, 69632, "", "=q4=Lost Bag of Whammies", "=ds=#s15#", ""};
				{ 20, 69631, "", "=q4=Zulian Voodoo Stick", "=ds=#w12#", ""};
				{ 21, 69647, "", "=q1=Mysterious Gurubashi Bijou", "=ds=#m3#", ""};
			};
		};
		info = {
			name = AL["The Cache of Madness"],
			module = moduleName, instance = "ZulGurub",
		};
	};

	AtlasLoot_Data["ZGKilnara"] = {
		["Heroic"] = {
			{
				{ 1, 69612, "", "=q4=Claw-Fringe Mantle", "=ds=#s3#, #a1#", ""};
				{ 2, 69611, "", "=q4=Sash of Anguish", "=ds=#s10#, #a1#", ""};
				{ 3, 69613, "", "=q4=Leggings of the Pride", "=ds=#s11#, #a2#", ""};
				{ 4, 69614, "", "=q4=Roaring Mask of Bethekk", "=ds=#s1#, #a4#", ""};
				{ 5, 69610, "", "=q4=Arlokk's Signet", "=ds=#s13#", ""};
				{ 7, 68824, "", "=q4=Swift Zulian Panther", "=ds=#e26#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Priestess Kilnara", 181),
			module = moduleName, instance = "ZulGurub",
		};
	};

	AtlasLoot_Data["ZGZanzil"] = {
		["Heroic"] = {
			{
				{ 1, 69616, "", "=q4=Spiritbinder Spaulders", "=ds=#s3#, #a3#", ""};
				{ 2, 69615, "", "=q4=Zombie Walker Legguards", "=ds=#s11#, #a3#", ""};
				{ 3, 69617, "", "=q4=Plumed Medicine Helm", "=ds=#s1#, #a4#", ""};
				{ 4, 69619, "", "=q4=Bone Plate Handguards", "=ds=#s9#, #a4#", ""};
				{ 5, 69618, "", "=q4=Zulian Slasher", "=ds=#h1#, #w10#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Zanzil", 184),
			module = moduleName, instance = "ZulGurub",
		};
	};

	AtlasLoot_Data["ZGJindo"] = {
		["Heroic"] = {
			{
				{ 1, 69622, "", "=q4=The Hexxer's Mask", "=ds=#s1#, #a1#", ""};
				{ 2, 69623, "", "=q4=Vestments of the Soulflayer", "=ds=#s5#, #a2#", ""};
				{ 4, 69621, "", "=q4=Twinblade of the Hakkari", "=ds=#h1#, #w4#", ""};
				{ 5, 69620, "", "=q4=Twinblade of the Hakkari", "=ds=#h1#, #w4#", ""};
				{ 6, 69628, "", "=q4=Jeklik's Smasher", "=ds=#h2#, #w6#", ""};
				{ 7, 69626, "", "=q4=Jin'do's Verdict", "=ds=#w9#", ""};
				{ 8, 69624, "", "=q4=Legacy of Arlokk", "=ds=#w9#", ""};
				{ 16, 69629, "", "=q4=Shield of the Blood God", "=ds=#w8#", ""};
				{ 17, 69627, "", "=q4=Zulian Ward", "=ds=#w8#", ""};
				{ 18, 69625, "", "=q4=Mandokir's Tribute", "=ds=#w2#", ""};
				{ 20, 69774, "", "=q1=Zul'Gurub Stone", "=ds=#m3#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Jin'do the Godbreaker", 185),
			module = moduleName, instance = "ZulGurub",
		};
	};

	AtlasLoot_Data["ZGTrash"] = {
		["Heroic"] = {
			{
				{ 1, 69800, "", "=q4=Spiritguard Drape", "=ds=#s4#"};
				{ 2, 69796, "", "=q4=Spiritcaller Cloak", "=ds=#s4#"};
				{ 3, 69798, "", "=q4=Knotted Handwraps", "=ds=#s9#, #a2#"};
				{ 5, 69803, "", "=q4=Gurubashi Punisher", "=ds=#h1#, #w6#"};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "ZulGurub",
		};
	};

		---------------------
		--- Baradin Hold ----
		---------------------

	AtlasLoot_Data["BHArgaloth"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 2, 60285, "", "=q4=Stormrider's Gloves", "=ds=#s9#, #a2#", ""};
				{ 3, 60283, "", "=q4=Stormrider's Leggings", "=ds=#s11#, #a2#", ""};
				{ 5, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 6, 60290, "", "=q4=Stormrider's Grips", "=ds=#s9#, #a2#", ""};
				{ 7, 60288, "", "=q4=Stormrider's Legguards", "=ds=#s11#, #a2#", ""};
				{ 9, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 10, 60280, "", "=q4=Stormrider's Handwraps", "=ds=#s9#, #a2#", ""};
				{ 11, 60278, "", "=q4=Stormrider's Legwraps", "=ds=#s11#, #a2#", ""};
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 60453, "", "=q4=Vicious Gladiator's Wyrmhide Gloves", "=ds=#s9#, #a2#", ""};
				{ 18, 60455, "", "=q4=Vicious Gladiator's Wyrmhide Legguards", "=ds=#s11#, #a2#", ""};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 60443, "", "=q4=Vicious Gladiator's Dragonhide Gloves", "=ds=#s9#, #a2#", ""};
				{ 22, 60445, "", "=q4=Vicious Gladiator's Dragonhide Legguards", "=ds=#s11#, #a2#", ""};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 60448, "", "=q4=Vicious Gladiator's Kodohide Gloves", "=ds=#s9#, #a2#", ""};
				{ 26, 60450, "", "=q4=Vicious Gladiator's Kodohide Legguards", "=ds=#s11#, #a2#", ""};
			};
			{
				{ 1, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 2, 60247, "", "=q4=Firelord's Gloves", "=ds=#s9#, #a1#", ""};
				{ 3, 60245, "", "=q4=Firelord's Leggings", "=ds=#s11#, #a1#", ""};
				{ 5, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, 60307, "", "=q4=Lightning-Charged Gloves", "=ds=#s9#, #a3#", ""};
				{ 7, 60305, "", "=q4=Lightning-Charged Legguards", "=ds=#s11#, #a3#", ""};
				{ 9, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 10, 60298, "", "=q4=Wind Dancer's Gloves", "=ds=#s9#, #a2#", ""};
				{ 11, 60300, "", "=q4=Wind Dancer's Legguards", "=ds=#s11#, #a2#", ""};
				{ 13, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 14, 60248, "", "=q4=Shadowflame Handwraps", "=ds=#s9#, #a1#", ""};
				{ 15, 60250, "", "=q4=Shadowflame Leggings", "=ds=#s11#, #a1#", ""};
				{ 16, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 17, 60463, "", "=q4=Vicious Gladiator's Silk Handguards", "=ds=#s9#, #a1#", ""};
				{ 18, 60465, "", "=q4=Vicious Gladiator's Silk Trousers", "=ds=#s11#, #a1#", ""};
				{ 20, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 21, 60424, "", "=q4=Vicious Gladiator's Chain Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 22, 60426, "", "=q4=Vicious Gladiator's Chain Leggings", "=ds=#s11#, #a3#", ""};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 60459, "", "=q4=Vicious Gladiator's Leather Gloves", "=ds=#s9#, #a2#", ""};
				{ 26, 60461, "", "=q4=Vicious Gladiator's Leather Legguards", "=ds=#s11#, #a2#", ""};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 60478, "", "=q4=Vicious Gladiator's Felweave Handguards", "=ds=#s9#, #a1#", ""};
				{ 30, 60480, "", "=q4=Vicious Gladiator's Felweave Trousers", "=ds=#s11#, #a1#", ""};
			};
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 2, 60363, "", "=q4=Reinforced Sapphirium Gloves", "=ds=#s9#, #a4#", ""};
				{ 3, 60361, "", "=q4=Reinforced Sapphirium Greaves", "=ds=#s11#, #a4#", ""};
				{ 5, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 6, 60355, "", "=q4=Reinforced Sapphirium Handguards", "=ds=#s9#, #a4#", ""};
				{ 7, 60357, "", "=q4=Reinforced Sapphirium Legguards", "=ds=#s11#, #a4#", ""};
				{ 9, 0, "spell_holy_devotionaura", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 10, 60355, "", "=q4=Reinforced Sapphirium Handguards", "=ds=#s9#, #a4#", ""};
				{ 11, 60357, "", "=q4=Reinforced Sapphirium Legguards", "=ds=#s11#, #a4#", ""};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 60602, "", "=q4=Vicious Gladiator's Ornamented Gloves", "=ds=#s9#, #a4#", ""};
				{ 18, 60604, "", "=q4=Vicious Gladiator's Ornamented Legplates", "=ds=#s11#, #a4#", ""};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 60414, "", "=q4=Vicious Gladiator's Scaled Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 22, 60416, "", "=q4=Vicious Gladiator's Scaled Legguards", "=ds=#s11#, #a4#", ""};
			};
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 2, 60275, "", "=q4=Mercurial Handwraps", "=ds=#s9#, #a1#", ""};
				{ 3, 60261, "", "=q4=Mercurial Legwraps", "=ds=#s11#, #a1#", ""};
				{ 5, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 6, 60257, "", "=q4=Mercurial Gloves", "=ds=#s9#, #a1#", ""};
				{ 7, 60255, "", "=q4=Mercurial Leggings", "=ds=#s11#, #a1#", ""};
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 17, 60468, "", "=q4=Vicious Gladiator's Mooncloth Gloves", "=ds=#s9#, #a1#", ""};
				{ 18, 60470, "", "=q4=Vicious Gladiator's Mooncloth Leggings", "=ds=#s11#, #a1#", ""};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 21, 60476, "", "=q4=Vicious Gladiator's Satin Gloves", "=ds="};
				{ 22, 60475, "", "=q4=Vicious Gladiator's Satin Leggings", "=ds="};
			};
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 2, 60314, "", "=q4=Gloves of the Raging Elements", "=ds=#s9#, #a3#", ""};
				{ 3, 60316, "", "=q4=Kilt of the Raging Elements", "=ds=#s11#, #a3#", ""};
				{ 5, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 6, 60319, "", "=q4=Grips of the Raging Elements", "=ds=#s9#, #a3#", ""};
				{ 7, 60321, "", "=q4=Legguards of the Raging Elements", "=ds=#s11#, #a3#", ""};
				{ 9, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 10, 60312, "", "=q4=Handwraps of the Raging Elements", "=ds=#s9#, #a3#", ""};
				{ 11, 60310, "", "=q4=Legwraps of the Raging Elements", "=ds=#s11#, #a3#", ""};
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 60439, "", "=q4=Vicious Gladiator's Mail Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 18, 60441, "", "=q4=Vicious Gladiator's Mail Leggings", "=ds=#s11#, #a3#", ""};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 60434, "", "=q4=Vicious Gladiator's Linked Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 22, 60436, "", "=q4=Vicious Gladiator's Linked Leggings", "=ds=#s11#, #a3#", ""};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 60429, "", "=q4=Vicious Gladiator's Ringmail Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 26, 60431, "", "=q4=Vicious Gladiator's Ringmail Leggings", "=ds=#s11#, #a3#", ""};
			};
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 2, 60340, "", "=q4=Magma Plated Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 3, 60342, "", "=q4=Magma Plated Legplates", "=ds=#s11#, #a4#", ""};
				{ 5, 0, "spell_deathknight_bloodpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 6, 60350, "", "=q4=Magma Plated Handguards", "=ds=#s9#, #a4#", ""};
				{ 7, 60352, "", "=q4=Magma Plated Legguards", "=ds=#s11#, #a4#", ""};
				{ 9, 0, "ability_warrior_innerrage", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 10, 60326, "", "=q4=Earthen Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 11, 60324, "", "=q4=Earthen Legplates", "=ds=#s11#, #a4#", ""};
				{ 13, 0, "ability_warrior_defensivestance", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
				{ 14, 60332, "", "=q4=Earthen Handguards", "=ds=#s9#, #a4#", ""};
				{ 15, 60330, "", "=q4=Earthen Legguards", "=ds=#s11#, #a4#", ""};
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 60409, "", "=q4=Vicious Gladiator's Dreadplate Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 18, 60411, "", "=q4=Vicious Gladiator's Dreadplate Legguards", "=ds=#s11#, #a4#", ""};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 60419, "", "=q4=Vicious Gladiator's Plate Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 26, 60421, "", "=q4=Vicious Gladiator's Plate Legguards", "=ds=#s11#, #a4#", ""};
			};
			{
				{ 1, 60628, "", "=q4=Vicious Gladiator's Cuffs of Accuracy", "=ds=", };
				{ 2, 60626, "", "=q4=Vicious Gladiator's Cord of Accuracy", "=ds=", };
				{ 3, 60630, "", "=q4=Vicious Gladiator's Treads of Alacrity", "=ds=", };
				{ 5, 60635, "", "=q4=Vicious Gladiator's Cuffs of Meditation", "=ds=", };
				{ 6, 60637, "", "=q4=Vicious Gladiator's Cord of Meditation", "=ds=", };
				{ 7, 60636, "", "=q4=Vicious Gladiator's Treads of Meditation", "=ds=", };
				{ 9, 60634, "", "=q4=Vicious Gladiator's Cuffs of Prowess", "=ds=", };
				{ 10, 60612, "", "=q4=Vicious Gladiator's Cord of Cruelty", "=ds=", };
				{ 11, 60613, "", "=q4=Vicious Gladiator's Treads of Cruelty", "=ds=", };
				{ 16, 60591, "", "=q4=Vicious Gladiator's Armwraps of Accuracy", "=ds=", };
				{ 17, 60589, "", "=q4=Vicious Gladiator's Waistband of Accuracy", "=ds=", };
				{ 18, 60587, "", "=q4=Vicious Gladiator's Boots of Cruelty", "=ds=", };
				{ 20, 60594, "", "=q4=Vicious Gladiator's Armwraps of Alacrity", "=ds=", };
				{ 21, 60586, "", "=q4=Vicious Gladiator's Waistband of Cruelty", "=ds=", };
				{ 22, 60593, "", "=q4=Vicious Gladiator's Boots of Alacrity", "=ds=", };
				{ 24, 60611, "", "=q4=Vicious Gladiator's Bindings of Prowess", "=ds=", };
				{ 25, 60583, "", "=q4=Vicious Gladiator's Belt of Cruelty", "=ds=", };
				{ 26, 60607, "", "=q4=Vicious Gladiator's Footguards of Alacrity", "=ds=", };
				{ 28, 60582, "", "=q4=Vicious Gladiator's Bindings of Meditation", "=ds=", };
				{ 29, 60580, "", "=q4=Vicious Gladiator's Belt of Meditation", "=ds=", };
				{ 30, 60581, "", "=q4=Vicious Gladiator's Footguards of Meditation", "=ds=", };
			};
			{
				{ 1, 60535, "", "=q4=Vicious Gladiator's Armbands of Meditation", "=ds=", };
				{ 2, 60533, "", "=q4=Vicious Gladiator's Waistguard of Meditation", "=ds=", };
				{ 3, 60534, "", "=q4=Vicious Gladiator's Sabatons of Meditation", "=ds=", };
				{ 5, 60569, "", "=q4=Vicious Gladiator's Armbands of Prowess", "=ds=", };
				{ 6, 60536, "", "=q4=Vicious Gladiator's Waistguard of Cruelty", "=ds=", };
				{ 7, 60567, "", "=q4=Vicious Gladiator's Sabatons of Alacrity", "=ds=", };
				{ 9, 60559, "", "=q4=Vicious Gladiator's Wristguards of Alacrity", "=ds=", };
				{ 10, 60555, "", "=q4=Vicious Gladiator's Links of Cruelty", "=ds=", };
				{ 11, 60557, "", "=q4=Vicious Gladiator's Sabatons of Alacrity", "=ds=", };
				{ 13, 60565, "", "=q4=Vicious Gladiator's Wristguards of Accuracy", "=ds=", };
				{ 14, 60564, "", "=q4=Vicious Gladiator's Links of Accuracy", "=ds=", };
				{ 15, 60554, "", "=q4=Vicious Gladiator's Sabatons of Cruelty", "=ds=", };
				{ 16, 60541, "", "=q4=Vicious Gladiator's Bracers of Meditation", "=ds=", };
				{ 17, 60539, "", "=q4=Vicious Gladiator's Clasp of Meditation", "=ds=", };
				{ 18, 60540, "", "=q4=Vicious Gladiator's Greaves of Meditation", "=ds=", };
				{ 20, 60523, "", "=q4=Vicious Gladiator's Armplates of Proficiency", "=ds=", };
				{ 21, 60521, "", "=q4=Vicious Gladiator's Girdle of Prowess", "=ds=", };
				{ 22, 60513, "", "=q4=Vicious Gladiator's Warboots of Accuracy", "=ds=", };
				{ 24, 60520, "", "=q4=Vicious Gladiator's Bracers of Prowess", "=ds=", };
				{ 25, 60505, "", "=q4=Vicious Gladiator's Clasp of Cruelty", "=ds=", };
				{ 26, 60516, "", "=q4=Vicious Gladiator's Greaves of Alacrity", "=ds=", };
				{ 28, 60512, "", "=q4=Vicious Gladiator's Armplates of Alacrity", "=ds=", };
				{ 29, 60508, "", "=q4=Vicious Gladiator's Girdle of Cruelty", "=ds=", };
				{ 30, 60509, "", "=q4=Vicious Gladiator's Warboots of Cruelty", "=ds=", };
			};
			{
				{ 1, 60783, "", "=q4=Vicious Gladiator's Cape of Cruelty", "=ds=#s4#",  },
				{ 2, 60779, "", "=q4=Vicious Gladiator's Cape of Prowess", "=ds=#s4#",  },
				{ 3, 60776, "", "=q4=Vicious Gladiator's Cloak of Alacrity", "=ds=#s4#",  },
				{ 4, 60778, "", "=q4=Vicious Gladiator's Cloak of Prowess", "=ds=#s4#",  },
				{ 5, 60786, "", "=q4=Vicious Gladiator's Drape of Diffusion", "=ds=#s4#",  },
				{ 6, 60788, "", "=q4=Vicious Gladiator's Drape of Meditation", "=ds=#s4#",  },
				{ 7, 60787, "", "=q4=Vicious Gladiator's Drape of Prowess", "=ds=#s4#",  },
				{ 9, 60647, "", "=q4=Vicious Gladiator's Band of Accuracy", "=ds=#s13#", };
				{ 10, 60645, "", "=q4=Vicious Gladiator's Band of Cruelty", "=ds=#s13#", };
				{ 11, 60649, "", "=q4=Vicious Gladiator's Band of Dominance", "=ds=#s13#", };
				{ 12, 60651, "", "=q4=Vicious Gladiator's Signet of Accuracy", "=ds=#s13#", };
				{ 13, 60650, "", "=q4=Vicious Gladiator's Signet of Cruelty", "=ds=#s13#", };
				{ 14, 60658, "", "=q4=Vicious Gladiator's Ring of Accuracy", "=ds=#s13#", };
				{ 15, 60659, "", "=q4=Vicious Gladiator's Ring of Cruelty", "=ds=#s13#", };
				{ 16, 60673, "", "=q4=Vicious Gladiator's Choker of Accuracy", "=ds=#s2#",  },
				{ 17, 60670, "", "=q4=Vicious Gladiator's Choker of Proficiency", "=ds=#s2#",  },
				{ 18, 60669, "", "=q4=Vicious Gladiator's Necklace of Proficiency", "=ds=#s2#",  },
				{ 19, 60668, "", "=q4=Vicious Gladiator's Necklace of Prowess", "=ds=#s2#",  },
				{ 20, 60662, "", "=q4=Vicious Gladiator's Pendant of Alacrity", "=ds=#s2#",  },
				{ 21, 60661, "", "=q4=Vicious Gladiator's Pendant of Diffusion", "=ds=#s2#",  },
				{ 22, 60664, "", "=q4=Vicious Gladiator's Pendant of Meditation", "=ds=#s2#",  },
			};
			{
				{ 2, 61033, "", "=q4=Vicious Gladiator's Badge of Conquest", "=ds=#s14#",  },
				{ 3, 61035, "", "=q4=Vicious Gladiator's Badge of Dominance", "=ds=#s14#",  },
				{ 4, 61034, "", "=q4=Vicious Gladiator's Badge of Victory", "=ds=#s14#",  },
				{ 6, 61026, "", "=q4=Vicious Gladiator's Emblem of Cruelty", "=ds=#s14#",  },
				{ 7, 61031, "", "=q4=Vicious Gladiator's Emblem of Meditation", "=ds=#s14#",  },
				{ 8, 61032, "", "=q4=Vicious Gladiator's Emblem of Tenacity", "=ds=#s14#",  },
				{
					{ 17, 60801, "", "=q4=Vicious Gladiator's Medallion of Cruelty", "=ds=#s14#",  },
					{ 17, 60794, "", "=q4=Vicious Gladiator's Medallion of Cruelty", "=ds=#s14#",  },
				};
				{
					{ 18, 60806, "", "=q4=Vicious Gladiator's Medallion of Meditation", "=ds=#s14#",  },
					{ 18, 60799, "", "=q4=Vicious Gladiator's Medallion of Meditation", "=ds=#s14#",  },
				};
				{
					{ 19, 60807, "", "=q4=Vicious Gladiator's Medallion of Tenacity", "=ds=#s14#",  },
					{ 19, 60800, "", "=q4=Vicious Gladiator's Medallion of Tenacity", "=ds=#s14#",  },
				};
				{ 21, 61047, "", "=q4=Vicious Gladiator's Insignia of Conquest", "=ds=#s14#",  },
				{ 22, 61045, "", "=q4=Vicious Gladiator's Insignia of Dominance", "=ds=#s14#",  },
				{ 23, 61046, "", "=q4=Vicious Gladiator's Insignia of Victory", "=ds=#s14#",  },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Argaloth", 139),
			module = moduleName, menu = "ARGALOTH", instance = "BaradinHold",
		};
	};

	AtlasLoot_Data["BHOccuthar"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 2, 71107, "", "=q4=Obsidian Arborweave Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 3, 71109, "", "=q4=Obsidian Arborweave Leggings", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 5, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 6, 71097, "", "=q4=Obsidian Arborweave Grips", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 7, 71099, "", "=q4=Obsidian Arborweave Legguards", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 9, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 10, 71102, "", "=q4=Obsidian Arborweave Handwraps", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 11, 71104, "", "=q4=Obsidian Arborweave Legwraps", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 70289, "", "=q4=Ruthless Gladiator's Wyrmhide Gloves", "=ds=", "#HONOR:1650#"};
				{ 18, 70291, "", "=q4=Ruthless Gladiator's Wyrmhide Legguards", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 70279, "", "=q4=Ruthless Gladiator's Dragonhide Gloves", "=ds=", "#HONOR:1650#"};
				{ 22, 70281, "", "=q4=Ruthless Gladiator's Dragonhide Legguards", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 70284, "", "=q4=Ruthless Gladiator's Kodohide Gloves", "=ds=", "#HONOR:1650#"};
				{ 26, 70286, "", "=q4=Ruthless Gladiator's Kodohide Legguards", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 2, 71286, "", "=q4=Firehawk Gloves", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 3, 71288, "", "=q4=Firehawk Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 5, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, 71050, "", "=q4=Flamewaker's Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 7, 71052, "", "=q4=Flamewaker's Legguards", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 9, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 10, 71046, "", "=q4=Dark Phoenix Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 11, 71048, "", "=q4=Dark Phoenix Legguards", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 13, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 14, 71281, "", "=q4=Balespider's Handwraps", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 15, 71283, "", "=q4=Balespider's Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 16, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 17, 70299, "", "=q4=Ruthless Gladiator's Silk Handguards", "=ds=", "#HONOR:1650#"};
				{ 18, 70301, "", "=q4=Ruthless Gladiator's Silk Trousers", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 21, 70260, "", "=q4=Ruthless Gladiator's Chain Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 22, 70262, "", "=q4=Ruthless Gladiator's Chain Leggings", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 70295, "", "=q4=Ruthless Gladiator's Leather Gloves", "=ds=", "#HONOR:1650#"};
				{ 26, 70297, "", "=q4=Ruthless Gladiator's Leather Legguards", "=ds=", "#HONOR:2200#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 70314, "", "=q4=Ruthless Gladiator's Felweave Handguards", "=ds=", "#HONOR:1650#"};
				{ 30, 70316, "", "=q4=Ruthless Gladiator's Felweave Trousers", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 2, 71092, "", "=q4=Immolation Gloves", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 3, 71094, "", "=q4=Immolation Greaves", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 5, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 6, 71064, "", "=q4=Immolation Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 7, 71066, "", "=q4=Immolation Legplates", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 9, 0, "spell_holy_devotionaura", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 10, 70949, "", "=q4=Immolation Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 11, 70947, "", "=q4=Immolation Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 70354, "", "=q4=Ruthless Gladiator's Ornamented Gloves", "=ds=", "#HONOR:1650#"};
				{ 18, 70356, "", "=q4=Ruthless Gladiator's Ornamented Legplates", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 70250, "", "=q4=Ruthless Gladiator's Scaled Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 22, 70252, "", "=q4=Ruthless Gladiator's Scaled Legguards", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 2, 71271, "", "=q4=Handwraps of the Cleansing Flame", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 3, 71273, "", "=q4=Legwraps of the Cleansing Flame", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 5, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 6, 71276, "", "=q4=Gloves of the Cleansing Flame", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 7, 71278, "", "=q4=Leggings of the Cleansing Flame", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 17, 70304, "", "=q4=Ruthless Gladiator's Mooncloth Gloves", "=ds=", "#HONOR:1650#"};
				{ 18, 70306, "", "=q4=Ruthless Gladiator's Mooncloth Leggings", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 21, 70309, "", "=q4=Ruthless Gladiator's Satin Gloves", "=ds=", "#HONOR:1650#"};
				{ 22, 70311, "", "=q4=Ruthless Gladiator's Satin Leggings", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 2, 71292, "", "=q4=Erupting Volcanic Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 3, 71294, "", "=q4=Erupting Volcanic Kilt", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 5, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 6, 71302, "", "=q4=Erupting Volcanic Grips", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 7, 71304, "", "=q4=Erupting Volcanic Legguards", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 9, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 10, 71297, "", "=q4=Erupting Volcanic Handwraps", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 11, 71299, "", "=q4=Erupting Volcanic Legwraps", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 70275, "", "=q4=Ruthless Gladiator's Mail Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 18, 70277, "", "=q4=Ruthless Gladiator's Mail Leggings", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 70270, "", "=q4=Ruthless Gladiator's Linked Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 22, 70272, "", "=q4=Ruthless Gladiator's Linked Leggings", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 70265, "", "=q4=Ruthless Gladiator's Ringmail Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 26, 70267, "", "=q4=Ruthless Gladiator's Ringmail Leggings", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 2, 71059, "", "=q4=Elementium Deathplate Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 3, 71061, "", "=q4=Elementium Deathplate Greaves", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 5, 0, "spell_deathknight_bloodpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 6, 70953, "", "=q4=Elementium Deathplate Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 7, 70952, "", "=q4=Elementium Deathplate Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 9, 0, "ability_warrior_innerrage", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 10, 71069, "", "=q4=Gauntlets of the Molten Giant", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 11, 71071, "", "=q4=Legplates of the Molten Giant", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 13, 0, "ability_warrior_defensivestance", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
				{ 14, 70943, "", "=q4=Handguards of the Molten Giant", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 15, 70942, "", "=q4=Legguards of the Molten Giant", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 70245, "", "=q4=Ruthless Gladiator's Dreadplate Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 18, 70247, "", "=q4=Ruthless Gladiator's Dreadplate Legguards", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 70255, "", "=q4=Ruthless Gladiator's Plate Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 26, 70257, "", "=q4=Ruthless Gladiator's Plate Legguards", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 70363, "", "=q4=Ruthless Gladiator's Cuffs of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 2, 70362, "", "=q4=Ruthless Gladiator's Cord of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 3, 70364, "", "=q4=Ruthless Gladiator's Treads of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 5, 70366, "", "=q4=Ruthless Gladiator's Cuffs of Meditation", "=ds=", "#HONOR:1250#"};
				{ 6, 70368, "", "=q4=Ruthless Gladiator's Cord of Meditation", "=ds=", "#HONOR:1650#"};
				{ 7, 70367, "", "=q4=Ruthless Gladiator's Treads of Meditation", "=ds=", "#HONOR:1650#"};
				{ 9, 70365, "", "=q4=Ruthless Gladiator's Cuffs of Prowess", "=ds=", "#HONOR:1250#"};
				{ 10, 70360, "", "=q4=Ruthless Gladiator's Cord of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 11, 70361, "", "=q4=Ruthless Gladiator's Treads of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 16, 70350, "", "=q4=Ruthless Gladiator's Armwraps of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 70349, "", "=q4=Ruthless Gladiator's Waistband of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 18, 70348, "", "=q4=Ruthless Gladiator's Boots of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 20, 70352, "", "=q4=Ruthless Gladiator's Armwraps of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 21, 70347, "", "=q4=Ruthless Gladiator's Waistband of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 22, 70351, "", "=q4=Ruthless Gladiator's Boots of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 24, 70359, "", "=q4=Ruthless Gladiator's Bindings of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 70346, "", "=q4=Ruthless Gladiator's Belt of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 26, 70358, "", "=q4=Ruthless Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 28, 70345, "", "=q4=Ruthless Gladiator's Bindings of Meditation", "=ds=", "#HONOR:1250#"};
				{ 29, 70343, "", "=q4=Ruthless Gladiator's Belt of Meditation", "=ds=", "#HONOR:1650#"};
				{ 30, 70344, "", "=q4=Ruthless Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1650#"};
			};
			{
				{ 1, 70330, "", "=q4=Ruthless Gladiator's Armbands of Meditation", "=ds=", "#HONOR:1250#"};
				{ 2, 70328, "", "=q4=Ruthless Gladiator's Waistguard of Meditation", "=ds=", "#HONOR:1650#"};
				{ 3, 70329, "", "=q4=Ruthless Gladiator's Sabatons of Meditation", "=ds=", "#HONOR:1650#"};
				{ 5, 70342, "", "=q4=Ruthless Gladiator's Armbands of Prowess", "=ds=", "#HONOR:1250#"};
				{ 6, 70331, "", "=q4=Ruthless Gladiator's Waistguard of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 7, 70341, "", "=q4=Ruthless Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 9, 70338, "", "=q4=Ruthless Gladiator's Wristguards of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 10, 70336, "", "=q4=Ruthless Gladiator's Links of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 11, 70337, "", "=q4=Ruthless Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 13, 70340, "", "=q4=Ruthless Gladiator's Wristguards of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 14, 70339, "", "=q4=Ruthless Gladiator's Links of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 15, 70335, "", "=q4=Ruthless Gladiator's Sabatons of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 16, 70334, "", "=q4=Ruthless Gladiator's Bracers of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 70332, "", "=q4=Ruthless Gladiator's Clasp of Meditation", "=ds=", "#HONOR:1650#"};
				{ 18, 70333, "", "=q4=Ruthless Gladiator's Greaves of Meditation", "=ds=", "#HONOR:1650#"};
				{ 20, 70327, "", "=q4=Ruthless Gladiator's Armplates of Proficiency", "=ds=", "#HONOR:1250#"};
				{ 21, 70326, "", "=q4=Ruthless Gladiator's Girdle of Prowess", "=ds=", "#HONOR:1650#"};
				{ 22, 70323, "", "=q4=Ruthless Gladiator's Warboots of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 24, 70325, "", "=q4=Ruthless Gladiator's Bracers of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 70319, "", "=q4=Ruthless Gladiator's Clasp of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 26, 70324, "", "=q4=Ruthless Gladiator's Greaves of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 28, 70322, "", "=q4=Ruthless Gladiator's Armplates of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 29, 70320, "", "=q4=Ruthless Gladiator's Girdle of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 30, 70321, "", "=q4=Ruthless Gladiator's Warboots of Cruelty", "=ds=", "#HONOR:1650#"};
			};
			{
				{ 1, 70386, "", "=q4=Ruthless Gladiator's Cape of Cruelty", "=ds=#s4#", "#HONOR:1250#" },
				{ 2, 70385, "", "=q4=Ruthless Gladiator's Cape of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 3, 70383, "", "=q4=Ruthless Gladiator's Cloak of Alacrity", "=ds=#s4#", "#HONOR:1250#" },
				{ 4, 70384, "", "=q4=Ruthless Gladiator's Cloak of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 5, 70387, "", "=q4=Ruthless Gladiator's Drape of Diffusion", "=ds=#s4#", "#HONOR:1250#" },
				{ 6, 70389, "", "=q4=Ruthless Gladiator's Drape of Meditation", "=ds=#s4#", "#HONOR:1250#" },
				{ 7, 70388, "", "=q4=Ruthless Gladiator's Drape of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 9, 70370, "", "=q4=Ruthless Gladiator's Band of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 10, 70369, "", "=q4=Ruthless Gladiator's Band of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 11, 70371, "", "=q4=Ruthless Gladiator's Band of Dominance", "=ds=#s13#", "#HONOR:1250#"};
				{ 12, 70373, "", "=q4=Ruthless Gladiator's Signet of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 13, 70372, "", "=q4=Ruthless Gladiator's Signet of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 14, 70374, "", "=q4=Ruthless Gladiator's Ring of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 15, 70375, "", "=q4=Ruthless Gladiator's Ring of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 16, 70382, "", "=q4=Ruthless Gladiator's Choker of Accuracy", "=ds=#s2#", "#HONOR:1250#" },
				{ 17, 70381, "", "=q4=Ruthless Gladiator's Choker of Proficiency", "=ds=#s2#", "#HONOR:1250#" },
				{ 18, 70380, "", "=q4=Ruthless Gladiator's Necklace of Proficiency", "=ds=#s2#", "#HONOR:1250#" },
				{ 19, 70379, "", "=q4=Ruthless Gladiator's Necklace of Prowess", "=ds=#s2#", "#HONOR:1250#" },
				{ 20, 70377, "", "=q4=Ruthless Gladiator's Pendant of Alacrity", "=ds=#s2#", "#HONOR:1250#" },
				{ 21, 70376, "", "=q4=Ruthless Gladiator's Pendant of Diffusion", "=ds=#s2#", "#HONOR:1250#" },
				{ 22, 70378, "", "=q4=Ruthless Gladiator's Pendant of Meditation", "=ds=#s2#", "#HONOR:1250#" },
			};
			{
				{ 2, 70399, "", "=q4=Ruthless Gladiator's Badge of Conquest", "=ds=#s14#", "#HONOR:1650#" },
				{ 3, 70401, "", "=q4=Ruthless Gladiator's Badge of Dominance", "=ds=#s14#", "#HONOR:1650#" },
				{ 4, 70400, "", "=q4=Ruthless Gladiator's Badge of Victory", "=ds=#s14#", "#HONOR:1650#" },
				{ 6, 70396, "", "=q4=Ruthless Gladiator's Emblem of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
				{ 7, 70397, "", "=q4=Ruthless Gladiator's Emblem of Meditation", "=ds=#s14#", "#HONOR:1650#" },
				{ 8, 70398, "", "=q4=Ruthless Gladiator's Emblem of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
				{
					{ 17, 70393, "", "=q4=Ruthless Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
					{ 17, 70390, "", "=q4=Ruthless Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
				};
				{
					{ 18, 70394, "", "=q4=Ruthless Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1650#" },
					{ 18, 70391, "", "=q4=Ruthless Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1650#" },
				};
				{
					{ 19, 70395, "", "=q4=Ruthless Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
					{ 19, 70392, "", "=q4=Ruthless Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
				};
				{ 21, 70404, "", "=q4=Ruthless Gladiator's Insignia of Conquest", "=ds=#s14#", "#HONOR:1650#" },
				{ 22, 70402, "", "=q4=Ruthless Gladiator's Insignia of Dominance", "=ds=#s14#", "#HONOR:1650#" },
				{ 23, 70403, "", "=q4=Ruthless Gladiator's Insignia of Victory", "=ds=#s14#", "#HONOR:1650#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Occu'thar", 140),
			module = moduleName, menu = "OCCUTHAR", instance = "BaradinHold",
		};
	};

	AtlasLoot_Data["BHAlizabal"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 2, 77018, "", "=q4=Deep Earth Gloves", "=ds=#s9#, #a2#"};
				{ 3, 77020, "", "=q4=Deep Earth Leggings", "=ds=#s11#, #a2#"};
				{ 5, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 6, 77014, "", "=q4=Deep Earth Grips", "=ds=#s9#, #a2#"};
				{ 7, 77016, "", "=q4=Deep Earth Legguards", "=ds=#s11#, #a2#"};
				{ 9, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 10, 76749, "", "=q4=Deep Earth Handwraps", "=ds=#s9#, #a2#"};
				{ 11, 76751, "", "=q4=Deep Earth Legwraps", "=ds=#s11#, #a2#"};
				{ 16, 0, "spell_nature_starfall", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 17, 73599, "", "=q4=Cataclysmic Gladiator's Wyrmhide Gloves", "=ds=", "#HONOR:1650#"};
				{ 18, 73597, "", "=q4=Cataclysmic Gladiator's Wyrmhide Legguards", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "ability_druid_catform", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 21, 73615, "", "=q4=Cataclysmic Gladiator's Dragonhide Gloves", "=ds=", "#HONOR:1650#"};
				{ 22, 73613, "", "=q4=Cataclysmic Gladiator's Dragonhide Legguards", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "spell_nature_healingtouch", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, 73607, "", "=q4=Cataclysmic Gladiator's Kodohide Gloves", "=ds=", "#HONOR:1650#"};
				{ 26, 73605, "", "=q4=Cataclysmic Gladiator's Kodohide Legguards", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 2, 76212, "", "=q4=Time Lord's Gloves", "=ds=#s9#, #a1#"};
				{ 3, 76214, "", "=q4=Time Lord's Leggings", "=ds=#s11#, #a1#"};
				{ 5, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, 77029, "", "=q4=Wyrmstalker's Gloves", "=ds=#s9#, #a3#"};
				{ 7, 77031, "", "=q4=Wyrmstalker's Legguards", "=ds=#s11#, #a3#"};
				{ 9, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 10, 77024, "", "=q4=Blackfang Battleweave Gloves", "=ds=#s9#, #a2#"};
				{ 11, 77026, "", "=q4=Blackfang Battleweave Legguards", "=ds=#s11#, #a2#"};
				{ 13, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 14, 76343, "", "=q4=Gloves of the Faceless Shroud", "=ds=#s9#, #a1#"};
				{ 15, 76341, "", "=q4=Leggings of the Faceless Shroud", "=ds=#s11#, #a1#"};
				{ 16, 0, "inv_staff_13", "=q6="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 17, 73576, "", "=q4=Cataclysmic Gladiator's Silk Handguards", "=ds=", "#HONOR:1650#"};
				{ 18, 73574, "", "=q4=Cataclysmic Gladiator's Silk Trousers", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "inv_weapon_bow_07", "=q6="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 21, 73583, "", "=q4=Cataclysmic Gladiator's Chain Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 22, 73581, "", "=q4=Cataclysmic Gladiator's Chain Leggings", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "inv_throwingknife_04", "=q6="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 25, 73526, "", "=q4=Cataclysmic Gladiator's Leather Gloves", "=ds=", "#HONOR:1650#"};
				{ 26, 73524, "", "=q4=Cataclysmic Gladiator's Leather Legguards", "=ds=", "#HONOR:2200#"};
				{ 28, 0, "spell_nature_drowsy", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 29, 73487, "", "=q4=Cataclysmic Gladiator's Felweave Handguards", "=ds=", "#HONOR:1650#"};
				{ 30, 73485, "", "=q4=Cataclysmic Gladiator's Felweave Trousers", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 2, 76766, "", "=q4=Gloves of Radiant Glory", "=ds=#s9#, #a4#"};
				{ 3, 76768, "", "=q4=Greaves of Radiant Glory", "=ds=#s11#, #a4#"};
				{ 5, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 6, 76875, "", "=q4=Gauntlets of Radiant Glory", "=ds=#s9#, #a4#"};
				{ 7, 76877, "", "=q4=Legplates of Radiant Glory", "=ds=#s11#, #a4#"};
				{ 9, 0, "spell_holy_devotionaura", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 10, 77004, "", "=q4=Handguards of Radiant Glory", "=ds=#s9#, #a4#"};
				{ 11, 77006, "", "=q4=Legguards of Radiant Glory", "=ds=#s11#, #a4#"};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 17, 73559, "", "=q4=Cataclysmic Gladiator's Ornamented Gloves", "=ds=", "#HONOR:1650#"};
				{ 18, 73557, "", "=q4=Cataclysmic Gladiator's Ornamented Legplates", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "Spell_Holy_AuraOfLight", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 21, 73570, "", "=q4=Cataclysmic Gladiator's Scaled Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 22, 73568, "", "=q4=Cataclysmic Gladiator's Scaled Legguards", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 2, 76357, "", "=q4=Handwraps of Dying Light", "=ds=#s9#, #a1#"};
				{ 3, 76359, "", "=q4=Legwraps of Dying Light", "=ds=#s11#, #a1#"};
				{ 5, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 6, 76348, "", "=q4=Gloves of Dying Light", "=ds=#s9#, #a1#"};
				{ 7, 76346, "", "=q4=Leggings of Dying Light", "=ds=#s11#, #a1#"};
				{ 16, 0, "spell_holy_guardianspirit", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 17, 73549, "", "=q4=Cataclysmic Gladiator's Mooncloth Gloves", "=ds=", "#HONOR:1650#"};
				{ 18, 73547, "", "=q4=Cataclysmic Gladiator's Mooncloth Leggings", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "spell_shadow_shadowwordpain", "=q6="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 21, 73544, "", "=q4=Cataclysmic Gladiator's Satin Gloves", "=ds=", "#HONOR:1650#"};
				{ 22, 73542, "", "=q4=Cataclysmic Gladiator's Satin Leggings", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 2, 77038, "", "=q4=Spiritwalker's Gloves", "=ds=#s9#, #a3#"};
				{ 3, 77036, "", "=q4=Spiritwalker's Kilt", "=ds=#s11#, #a3#"};
				{ 5, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 6, 77041, "", "=q4=Spiritwalker's Grips", "=ds=#s9#, #a3#"};
				{ 7, 77043, "", "=q4=Spiritwalker's Legguards", "=ds=#s11#, #a3#"};
				{ 9, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 10, 76757, "", "=q4=Spiritwalker's Handwraps", "=ds=#s9#, #a3#"};
				{ 11, 76759, "", "=q4=Spiritwalker's Legwraps", "=ds=#s11#, #a3#"};
				{ 16, 0, "Spell_Nature_Lightning", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 17, 73505, "", "=q4=Cataclysmic Gladiator's Mail Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 18, 73503, "", "=q4=Cataclysmic Gladiator's Mail Leggings", "=ds=", "#HONOR:2200#"};
				{ 20, 0, "spell_nature_lightningshield", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 21, 73511, "", "=q4=Cataclysmic Gladiator's Linked Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 22, 73509, "", "=q4=Cataclysmic Gladiator's Linked Leggings", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "spell_nature_magicimmunity", "=q6="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 25, 73516, "", "=q4=Cataclysmic Gladiator's Ringmail Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 26, 73514, "", "=q4=Cataclysmic Gladiator's Ringmail Leggings", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 2, 76975, "", "=q4=Necrotic Boneplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 3, 76977, "", "=q4=Necrotic Boneplate Greaves", "=ds=#s11#, #a4#"};
				{ 5, 0, "spell_deathknight_bloodpresence", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 6, 77009, "", "=q4=Necrotic Boneplate Handguards", "=ds=#s9#, #a4#"};
				{ 7, 77011, "", "=q4=Necrotic Boneplate Legguards", "=ds=#s11#, #a4#"};
				{ 9, 0, "ability_warrior_innerrage", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 10, 76985, "", "=q4=Colossal Dragonplate Gauntlets", "=ds=#s9#, #a4#"};
				{ 11, 76986, "", "=q4=Colossal Dragonplate Legplates", "=ds=#s11#, #a4#"};
				{ 13, 0, "ability_warrior_defensivestance", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
				{ 14, 76989, "", "=q4=Colossal Dragonplate Handguards", "=ds=#s9#, #a4#"};
				{ 15, 76991, "", "=q4=Colossal Dragonplate Legguards", "=ds=#s11#, #a4#"};
				{ 16, 0, "spell_deathknight_classicon", "=q6="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"]};
				{ 17, 73619, "", "=q4=Cataclysmic Gladiator's Dreadplate Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 18, 73617, "", "=q4=Cataclysmic Gladiator's Dreadplate Legguards", "=ds=", "#HONOR:2200#"};
				{ 24, 0, "inv_sword_27", "=q6="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"]};
				{ 25, 73481, "", "=q4=Cataclysmic Gladiator's Plate Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 26, 73479, "", "=q4=Cataclysmic Gladiator's Plate Legguards", "=ds=", "#HONOR:2200#"};
			};
			{
				{ 1, 73633, "", "=q4=Cataclysmic Gladiator's Cuffs of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 2, 73638, "", "=q4=Cataclysmic Gladiator's Cord of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 3 , 73635, "", "=q4=Cataclysmic Gladiator's Treads of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 5, 73631, "", "=q4=Cataclysmic Gladiator's Cuffs of Meditation", "=ds=", "#HONOR:1250#"};
				{ 6, 73637, "", "=q4=Cataclysmic Gladiator's Cord of Meditation", "=ds=", "#HONOR:1650#"};
				{ 7, 73634, "", "=q4=Cataclysmic Gladiator's Treads of Meditation", "=ds=", "#HONOR:1650#"};
				{ 9, 73632, "", "=q4=Cataclysmic Gladiator's Cuffs of Prowess", "=ds=", "#HONOR:1250#"};
				{ 10, 73639, "", "=q4=Cataclysmic Gladiator's Cord of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 11, 73636, "", "=q4=Cataclysmic Gladiator's Treads of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 16, 73528, "", "=q4=Cataclysmic Gladiator's Armwraps of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 73532, "", "=q4=Cataclysmic Gladiator's Waistband of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 18, 73531, "", "=q4=Cataclysmic Gladiator's Boots of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 20, 73529, "", "=q4=Cataclysmic Gladiator's Armwraps of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 21, 73533, "", "=q4=Cataclysmic Gladiator's Waistband of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 22, 73530, "", "=q4=Cataclysmic Gladiator's Boots of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 24, 73600, "", "=q4=Cataclysmic Gladiator's Bindings of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 73602, "", "=q4=Cataclysmic Gladiator's Belt of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 26, 73601, "", "=q4=Cataclysmic Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 28, 73608, "", "=q4=Cataclysmic Gladiator's Bindings of Meditation", "=ds=", "#HONOR:1250#"};
				{ 29, 73610, "", "=q4=Cataclysmic Gladiator's Belt of Meditation", "=ds=", "#HONOR:1650#"};
				{ 30, 73609, "", "=q4=Cataclysmic Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1650#"};
			};
			{
				{ 1, 73518, "", "=q4=Cataclysmic Gladiator's Armbands of Meditation", "=ds=", "#HONOR:1250#"};
				{ 2, 73522, "", "=q4=Cataclysmic Gladiator's Waistguard of Meditation", "=ds=", "#HONOR:1650#"};
				{ 3, 73520, "", "=q4=Cataclysmic Gladiator's Sabatons of Meditation", "=ds=", "#HONOR:1650#"};
				{ 5, 73519, "", "=q4=Cataclysmic Gladiator's Armbands of Prowess", "=ds=", "#HONOR:1250#"};
				{ 6, 73507, "", "=q4=Cataclysmic Gladiator's Waistguard of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 7, 73677, "", "=q4=Cataclysmic Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 9, 73586, "", "=q4=Cataclysmic Gladiator's Wristguards of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 10, 73590, "", "=q4=Cataclysmic Gladiator's Links of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 11, 73587, "", "=q4=Cataclysmic Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 13, 73585, "", "=q4=Cataclysmic Gladiator's Wristguards of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 14, 73589, "", "=q4=Cataclysmic Gladiator's Links of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 15, 73588, "", "=q4=Cataclysmic Gladiator's Sabatons of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 16, 73561, "", "=q4=Cataclysmic Gladiator's Bracers of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 73565, "", "=q4=Cataclysmic Gladiator's Clasp of Meditation", "=ds=", "#HONOR:1650#"};
				{ 18, 73563, "", "=q4=Cataclysmic Gladiator's Greaves of Meditation", "=ds=", "#HONOR:1650#"};
				{ 20, 73551, "", "=q4=Cataclysmic Gladiator's Armplates of Proficiency", "=ds=", "#HONOR:1250#"};
				{ 21, 73554, "", "=q4=Cataclysmic Gladiator's Girdle of Prowess", "=ds=", "#HONOR:1650#"};
				{ 22, 73552, "", "=q4=Cataclysmic Gladiator's Warboots of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 24, 73562, "", "=q4=Cataclysmic Gladiator's Bracers of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 73566, "", "=q4=Cataclysmic Gladiator's Clasp of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 26, 73564, "", "=q4=Cataclysmic Gladiator's Greaves of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 28, 73550, "", "=q4=Cataclysmic Gladiator's Armplates of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 29, 73555, "", "=q4=Cataclysmic Gladiator's Girdle of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 30, 73553, "", "=q4=Cataclysmic Gladiator's Warboots of Cruelty", "=ds=", "#HONOR:1650#"};
			};
			{
				{ 1, 73647, "", "=q4=Cataclysmic Gladiator's Cape of Cruelty", "=ds=#s4#", "#HONOR:1250#" },
				{ 2, 73646, "", "=q4=Cataclysmic Gladiator's Cape of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 3, 73495, "", "=q4=Cataclysmic Gladiator's Cloak of Alacrity", "=ds=#s4#", "#HONOR:1250#" },
				{ 4, 73494, "", "=q4=Cataclysmic Gladiator's Cloak of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 5, 73629, "", "=q4=Cataclysmic Gladiator's Drape of Diffusion", "=ds=#s4#", "#HONOR:1250#" },
				{ 6, 73628, "", "=q4=Cataclysmic Gladiator's Drape of Meditation", "=ds=#s4#", "#HONOR:1250#" },
				{ 7, 73630, "", "=q4=Cataclysmic Gladiator's Drape of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 9, 73622, "", "=q4=Cataclysmic Gladiator's Band of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 10, 73623, "", "=q4=Cataclysmic Gladiator's Band of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 11, 73621, "", "=q4=Cataclysmic Gladiator's Band of Dominance", "=ds=#s13#", "#HONOR:1250#"};
				{ 12, 73488, "", "=q4=Cataclysmic Gladiator's Signet of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 13, 73489, "", "=q4=Cataclysmic Gladiator's Signet of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 14, 73640, "", "=q4=Cataclysmic Gladiator's Ring of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 15, 73641, "", "=q4=Cataclysmic Gladiator's Ring of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 16, 73492, "", "=q4=Cataclysmic Gladiator's Choker of Accuracy", "=ds=#s2#", "#HONOR:1250#" },
				{ 17, 73493, "", "=q4=Cataclysmic Gladiator's Choker of Proficiency", "=ds=#s2#", "#HONOR:1250#" },
				{ 18, 73645, "", "=q4=Cataclysmic Gladiator's Necklace of Proficiency", "=ds=#s2#", "#HONOR:1250#" },
				{ 19, 73644, "", "=q4=Cataclysmic Gladiator's Necklace of Prowess", "=ds=#s2#", "#HONOR:1250#" },
				{ 20, 73627, "", "=q4=Cataclysmic Gladiator's Pendant of Alacrity", "=ds=#s2#", "#HONOR:1250#" },
				{ 21, 73626, "", "=q4=Cataclysmic Gladiator's Pendant of Diffusion", "=ds=#s2#", "#HONOR:1250#" },
				{ 22, 73625, "", "=q4=Cataclysmic Gladiator's Pendant of Meditation", "=ds=#s2#", "#HONOR:1250#" },
			};
			{
				{ 2, 73648, "", "=q4=Cataclysmic Gladiator's Badge of Conquest", "=ds=#s14#", "#HONOR:1650#" },
				{ 3, 73498, "", "=q4=Cataclysmic Gladiator's Badge of Dominance", "=ds=#s14#", "#HONOR:1650#" },
				{ 4, 73496, "", "=q4=Cataclysmic Gladiator's Badge of Victory", "=ds=#s14#", "#HONOR:1650#" },
				{ 6, 73593, "", "=q4=Cataclysmic Gladiator's Emblem of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
				{ 7, 73591, "", "=q4=Cataclysmic Gladiator's Emblem of Meditation", "=ds=#s14#", "#HONOR:1650#" },
				{ 8, 73592, "", "=q4=Cataclysmic Gladiator's Emblem of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
				{
					{ 17, 73538, "", "=q4=Cataclysmic Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
					{ 17, 73539, "", "=q4=Cataclysmic Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
				};
				{
					{ 18, 73534, "", "=q4=Cataclysmic Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1650#" },
					{ 18, 73535, "", "=q4=Cataclysmic Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1650#" },
				};
				{
					{ 19, 73537, "", "=q4=Cataclysmic Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
					{ 19, 73536, "", "=q4=Cataclysmic Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
				};
				{ 21, 73643, "", "=q4=Cataclysmic Gladiator's Insignia of Conquest", "=ds=#s14#", "#HONOR:1650#" },
				{ 22, 73497, "", "=q4=Cataclysmic Gladiator's Insignia of Dominance", "=ds=#s14#", "#HONOR:1650#" },
				{ 23, 73491, "", "=q4=Cataclysmic Gladiator's Insignia of Victory", "=ds=#s14#", "#HONOR:1650#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339),
			module = moduleName, menu = "ALIZABAL", instance = "BaradinHold",
		};
	};

		--------------------------
		--- Blackwing Descent ----
		--------------------------

	AtlasLoot_Data["BDMagmaw"] = {
		["Normal"] = {
			{
				{ 1, 59452, "", "=q4=Crown of Burning Waters", "=ds=#s1#, #a1#", ""};
				{ 2, 59336, "", "=q4=Flame Pillar Leggings", "=ds=#s11#, #a1#", ""};
				{ 3, 59335, "", "=q4=Scorched Wormling Vest", "=ds=#s5#, #a2#", ""};
				{ 4, 59329, "", "=q4=Parasitic Bands", "=ds=#s8#, #a2#", ""};
				{ 5, 59334, "", "=q4=Lifecycle Waistguard", "=ds=#s10#, #a3#", ""};
				{ 6, 59331, "", "=q4=Leggings of Lethal Force", "=ds=#s11#, #a3#", ""};
				{ 7, 59340, "", "=q4=Breastplate of Avenging Flame", "=ds=#s5#, #a4#", ""};
				{ 8, 59328, "", "=q4=Molten Tantrum Boots", "=ds=#s12#, #a4#", ""};
				{ 10, 59332, "", "=q4=Symbiotic Worm", "=ds=#s14#", ""};
				{ 16, 59333, "", "=q4=Lava Spine", "=ds=#h1#, #w10#", ""};
				{ 17, 59492, "", "=q4=Akirus the Worm-Breaker", "=ds=#h2#, #w6#", ""};
				{ 18, 59341, "", "=q4=Incineratus", "=ds=#h1#, #w4#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65020, "", "=q4=Crown of Burning Waters", "=ds=#s1#, #a1#", ""};
				{ 2, 65044, "", "=q4=Flame Pillar Leggings", "=ds=#s11#, #a1#", ""};
				{ 3, 65045, "", "=q4=Scorched Wormling Vest", "=ds=#s5#, #a2#", ""};
				{ 4, 65050, "", "=q4=Parasitic Bands", "=ds=#s8#, #a2#", ""};
				{ 5, 65046, "", "=q4=Lifecycle Waistguard", "=ds=#s10#, #a3#", ""};
				{ 6, 65049, "", "=q4=Leggings of Lethal Force", "=ds=#s11#, #a3#", ""};
				{ 7, 65042, "", "=q4=Breastplate of Avenging Flame", "=ds=#s5#, #a4#", ""};
				{ 8, 65051, "", "=q4=Molten Tantrum Boots", "=ds=#s12#, #a4#", ""};
				{ 10, 65048, "", "=q4=Symbiotic Worm", "=ds=#s14#", ""};
				{ 16, 67429, "", "=q4=Gauntlets of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 17, 67430, "", "=q4=Gauntlets of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 18, 67431, "", "=q4=Gauntlets of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 20, 65047, "", "=q4=Lava Spine", "=ds=#h1#, #w10#", ""};
				{ 21, 65007, "", "=q4=Akirus the Worm-Breaker", "=ds=#h2#, #w6#", ""};
				{ 22, 65041, "", "=q4=Incineratus", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Magmaw", 170),
			module = moduleName, instance = "BlackwingDescent",
		};
	};

	AtlasLoot_Data["BDOmnotron"] = {
		["Normal"] = {
			{
				{ 1, 59219, "", "=q4=Power Generator Hood", "=ds=#s1#, #a1#", ""};
				{ 2, 59217, "", "=q4=X-Tron Duct Tape", "=ds=#s10#, #a1#", ""};
				{ 3, 59218, "", "=q4=Passive Resistor Spaulders", "=ds=#s3#, #a2#", ""};
				{ 4, 59120, "", "=q4=Poison Protocol Pauldrons", "=ds=#s3#, #a2#", ""};
				{ 5, 63540, "", "=q4=Circuit Design Breastplate", "=ds=#s5#, #a3#", ""};
				{ 6, 59119, "", "=q4=Voltage Source Chestguard", "=ds=#s5#, #a3#", ""};
				{ 7, 59118, "", "=q4=Electron Inductor Coils", "=ds=#s8#, #a4#", ""};
				{ 8, 59117, "", "=q4=Jumbotron Power Belt", "=ds=#s10#, #a4#", ""};
				{ 9, 59216, "", "=q4=Life Force Chargers", "=ds=#s12#, #a4#", ""};
				{ 16, 59220, "", "=q4=Security Measure Alpha", "=ds=#s13#", ""};
				{ 17, 59121, "", "=q4=Lightning Conductor Band", "=ds=#s13#", ""};
				{ 19, 59122, "", "=q4=Organic Lifeform Inverter", "=ds=#h1#, #w4#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65077, "", "=q4=Power Generator Hood", "=ds=#s1#, #a1#", ""};
				{ 2, 65079, "", "=q4=X-Tron Duct Tape", "=ds=#s10#, #a1#", ""};
				{ 3, 65078, "", "=q4=Passive Resistor Spaulders", "=ds=#s3#, #a2#", ""};
				{ 4, 65083, "", "=q4=Poison Protocol Pauldrons", "=ds=#s3#, #a2#", ""};
				{ 5, 65004, "", "=q4=Circuit Design Breastplate", "=ds=#s5#, #a3#", ""};
				{ 6, 65084, "", "=q4=Voltage Source Chestguard", "=ds=#s5#, #a3#", ""};
				{ 7, 65085, "", "=q4=Electron Inductor Coils", "=ds=#s8#, #a4#", ""};
				{ 8, 65086, "", "=q4=Jumbotron Power Belt", "=ds=#s10#, #a4#", ""};
				{ 9, 65080, "", "=q4=Life Force Chargers", "=ds=#s12#, #a4#", ""};
				{ 16, 65076, "", "=q4=Security Measure Alpha", "=ds=#s13#", ""};
				{ 17, 65082, "", "=q4=Lightning Conductor Band", "=ds=#s13#", ""};
				{ 19, 65081, "", "=q4=Organic Lifeform Inverter", "=ds=#h1#, #w4#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Omnotron Defense System", 169),
			module = moduleName, instance = "BlackwingDescent",
		};
	};

	AtlasLoot_Data["BDChimaeron"] = {
		["Normal"] = {
			{
				{ 1, 59313, "", "=q4=Brackish Gloves", "=ds=#s9#, #a1#", ""};
				{ 2, 59234, "", "=q4=Einhorn's Galoshes", "=ds=#s12#, #a1#", ""};
				{ 3, 59451, "", "=q4=Manacles of the Sleeping Beast", "=ds=#s8#, #a2#", ""};
				{ 4, 59223, "", "=q4=Double Attack Handguards", "=ds=#s9#, #a2#", ""};
				{ 5, 59310, "", "=q4=Chaos Beast Bracers", "=ds=#s8#, #a3#", ""};
				{ 6, 59355, "", "=q4=Chimaeron Armguards", "=ds=#s8#, #a3#", ""};
				{ 7, 59311, "", "=q4=Burden of Mortality", "=ds=#s3#, #a4#", ""};
				{ 8, 59225, "", "=q4=Plated Fists of Provocation", "=ds=#s9#, #a4#", ""};
				{ 9, 59221, "", "=q4=Massacre Treads", "=ds=#s12#, #a4#", ""};
				{ 16, 59233, "", "=q4=Bile-O-Tron Nut", "=ds=#s13#", ""};
				{ 17, 59224, "", "=q4=Heart of Rage", "=ds=#s14#", ""};
				{ 19, 59314, "", "=q4=Finkle's Mixer Upper", "=ds=#w12#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65065, "", "=q4=Brackish Gloves", "=ds=#s9#, #a1#", ""};
				{ 2, 65069, "", "=q4=Einhorn's Galoshes", "=ds=#s12#, #a1#", ""};
				{ 3, 65021, "", "=q4=Manacles of the Sleeping Beast", "=ds=#s8#, #a2#", ""};
				{ 4, 65073, "", "=q4=Double Attack Handguards", "=ds=#s9#, #a2#", ""};
				{ 5, 65068, "", "=q4=Chaos Beast Bracers", "=ds=#s8#, #a3#", ""};
				{ 6, 65028, "", "=q4=Chimaeron Armguards", "=ds=#s8#, #a3#", ""};
				{ 7, 65067, "", "=q4=Burden of Mortality", "=ds=#s3#, #a4#", ""};
				{ 8, 65071, "", "=q4=Plated Fists of Provocation", "=ds=#s9#, #a4#", ""};
				{ 9, 65075, "", "=q4=Massacre Treads", "=ds=#s12#, #a4#", ""};
				{ 16, 65070, "", "=q4=Bile-O-Tron Nut", "=ds=#s13#", ""};
				{ 17, 65072, "", "=q4=Heart of Rage", "=ds=#s14#", ""};
				{ 19, 65064, "", "=q4=Finkle's Mixer Upper", "=ds=#w12#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Chimaeron", 172),
			module = moduleName, instance = "BlackwingDescent",
		};
	};

	AtlasLoot_Data["BDMaloriak"] = {
		["Normal"] = {
			{
				{ 1, 59348, "", "=q4=Cloak of Biting Chill", "=ds=#s4#", ""};
				{ 2, 59349, "", "=q4=Belt of Arcane Storms", "=ds=#s10#, #a1#", ""};
				{ 3, 59351, "", "=q4=Legwraps of the Greatest Son", "=ds=#s11#, #a1#", ""};
				{ 4, 59343, "", "=q4=Aberration's Leggings", "=ds=#s11#, #a2#", ""};
				{ 5, 59353, "", "=q4=Leggings of Consuming Flames", "=ds=#s11#, #a2#", ""};
				{ 6, 59346, "", "=q4=Tunic of Failed Experiments", "=ds=#s5#, #a3#", ""};
				{ 7, 59350, "", "=q4=Treads of Flawless Creation", "=ds=#s12#, #a3#", ""};
				{ 8, 59344, "", "=q4=Dragon Bone Warhelm", "=ds=#s1#, #a4#", ""};
				{ 9, 59352, "", "=q4=Flash Freeze Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 10, 59342, "", "=q4=Belt of Absolute Zero", "=ds=#s10#, #a4#", ""};
				{ 16, 59354, "", "=q4=Jar of Ancient Remedies", "=ds=#s14#", ""};
				{ 18, 59347, "", "=q4=Mace of Acrid Death", "=ds=#h1#, #w6#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65035, "", "=q4=Cloak of Biting Chill", "=ds=#s4#", ""};
				{ 2, 65034, "", "=q4=Belt of Arcane Storms", "=ds=#s10#, #a1#", ""};
				{ 3, 65032, "", "=q4=Legwraps of the Greatest Son", "=ds=#s11#, #a1#", ""};
				{ 4, 65039, "", "=q4=Aberration's Leggings", "=ds=#s11#, #a2#", ""};
				{ 5, 65030, "", "=q4=Leggings of Consuming Flames", "=ds=#s11#, #a2#", ""};
				{ 6, 65037, "", "=q4=Tunic of Failed Experiments", "=ds=#s5#, #a3#", ""};
				{ 7, 65033, "", "=q4=Treads of Flawless Creation", "=ds=#s12#, #a3#", ""};
				{ 8, 65038, "", "=q4=Dragon Bone Warhelm", "=ds=#s1#, #a4#", ""};
				{ 9, 65031, "", "=q4=Flash Freeze Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 10, 65040, "", "=q4=Belt of Absolute Zero", "=ds=#s10#, #a4#", ""};
				{ 16, 67428, "", "=q4=Leggings of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 17, 67427, "", "=q4=Leggings of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 18, 67426, "", "=q4=Leggings of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 20, 65029, "", "=q4=Jar of Ancient Remedies", "=ds=#s14#", ""};
				{ 22, 65036, "", "=q4=Mace of Acrid Death", "=ds=#h1#, #w6#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Maloriak", 173),
			module = moduleName, instance = "BlackwingDescent",
		};
	};

	AtlasLoot_Data["BDAtramedes"] = {
		["Normal"] = {
			{
				{ 1, 59325, "", "=q4=Mantle of Roaring Flames", "=ds=#s3#, #a1#", ""};
				{ 2, 59322, "", "=q4=Bracers of the Burningeye", "=ds=#s8#, #a1#", ""};
				{ 3, 59312, "", "=q4=Helm of the Blind Seer", "=ds=#s1#, #a2#", ""};
				{ 4, 59318, "", "=q4=Sark of the Unwatched", "=ds=#s5#, #a2#", ""};
				{ 5, 59324, "", "=q4=Gloves of Cacophony", "=ds=#s9#, #a3#", ""};
				{ 6, 59315, "", "=q4=Boots of Vertigo", "=ds=#s12#, #a3#", ""};
				{ 7, 59316, "", "=q4=Battleplate of Ancient Kings", "=ds=#s5#, #a4#", ""};
				{ 8, 59317, "", "=q4=Legguards of the Unseeing", "=ds=#s11#, #a4#", ""};
				{ 16, 59319, "", "=q4=Ironstar Amulet", "=ds=#s2#", ""};
				{ 17, 59326, "", "=q4=Bell of Enraging Resonance", "=ds=#s14#", ""};
				{ 18, 59320, "", "=q4=Themios the Darkbringer", "=ds=#w2#", ""};
				{ 19, 59327, "", "=q4=Kingdom's Heart", "=ds=#w8#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65054, "", "=q4=Mantle of Roaring Flames", "=ds=#s3#, #a1#", ""};
				{ 2, 65056, "", "=q4=Bracers of the Burningeye", "=ds=#s8#, #a1#", ""};
				{ 3, 65066, "", "=q4=Helm of the Blind Seer", "=ds=#s1#, #a2#", ""};
				{ 4, 65060, "", "=q4=Sark of the Unwatched", "=ds=#s5#, #a2#", ""};
				{ 5, 65055, "", "=q4=Gloves of Cacophony", "=ds=#s9#, #a3#", ""};
				{ 6, 65063, "", "=q4=Boots of Vertigo", "=ds=#s12#, #a3#", ""};
				{ 7, 65062, "", "=q4=Battleplate of Ancient Kings", "=ds=#s5#, #a4#", ""};
				{ 8, 65061, "", "=q4=Legguards of the Unseeing", "=ds=#s11#, #a4#", ""};
				{ 16, 65059, "", "=q4=Ironstar Amulet", "=ds=#s2#", ""};
				{ 17, 65053, "", "=q4=Bell of Enraging Resonance", "=ds=#s14#", ""};
				{ 18, 65058, "", "=q4=Themios the Darkbringer", "=ds=#w2#", ""};
				{ 19, 65052, "", "=q4=Kingdom's Heart", "=ds=#w8#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Atramedes", 171),
			module = moduleName, instance = "BlackwingDescent",
		};
	};

	AtlasLoot_Data["BDNefarian"] = {
		["Normal"] = {
			{
				{ 1, 59457, "", "=q4=Shadow of Dread", "=ds=#s4#", ""};
				{ 2, 59337, "", "=q4=Mantle of Nefarius", "=ds=#s3#, #a1#", ""};
				{ 3, 59454, "", "=q4=Shadowblaze Robes", "=ds=#s5#, #a1#", ""};
				{ 4, 59321, "", "=q4=Belt of the Nightmare", "=ds=#s10#, #a2#", ""};
				{ 5, 59222, "", "=q4=Spaulders of the Scarred Lady", "=ds=#s3#, #a3#", ""};
				{ 6, 59356, "", "=q4=Pauldrons of the Apocalypse", "=ds=#s3#, #a4#", ""};
				{ 7, 59450, "", "=q4=Belt of the Blackhand", "=ds=#s10#, #a4#", ""};
				{ 9, 59442, "", "=q4=Rage of Ages", "=ds=#s2#", ""};
				{ 10, 59441, "", "=q4=Prestor's Talisman of Machination", "=ds=#s14#", ""};
				{ 16, 63683, "", "=q4=Helm of the Forlorn Conqueror", "=ds=#e15#, #m37#"};
				{ 17, 63684, "", "=q4=Helm of the Forlorn Protector", "=ds=#e15#, #m37#"};
				{ 18, 63682, "", "=q4=Helm of the Forlorn Vanquisher", "=ds=#e15#, #m37#"};
				{ 20, 59443, "", "=q4=Crul'korak, the Lightning's Arc", "=ds=#h1#, #w1#", ""};
				{ 21, 63679, "", "=q4=Reclaimed Ashkandi, Greatsword of the Brotherhood", "=ds=#h2#, #w10#", ""};
				{ 22, 59459, "", "=q4=Andoros, Fist of the Dragon King", "=ds=#h1#, #w6#", ""};
				{ 23, 59444, "", "=q4=Akmin-Kurai, Dominion's Shield", "=ds=#w8#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65018, "", "=q4=Shadow of Dread", "=ds=#s4#", ""};
				{ 2, 65043, "", "=q4=Mantle of Nefarius", "=ds=#s3#, #a1#", ""};
				{ 3, 65019, "", "=q4=Shadowblaze Robes", "=ds=#s5#, #a1#", ""};
				{ 4, 65057, "", "=q4=Belt of the Nightmare", "=ds=#s10#, #a2#", ""};
				{ 5, 65074, "", "=q4=Spaulders of the Scarred Lady", "=ds=#s3#, #a3#", ""};
				{ 6, 65027, "", "=q4=Pauldrons of the Apocalypse", "=ds=#s3#, #a4#", ""};
				{ 7, 65022, "", "=q4=Belt of the Blackhand", "=ds=#s10#, #a4#", ""};
				{ 9, 65025, "", "=q4=Rage of Ages", "=ds=#s2#", ""};
				{ 10, 65026, "", "=q4=Prestor's Talisman of Machination", "=ds=#s14#", ""};
				{ 16, 65001, "", "=q4=Crown of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 17, 65000, "", "=q4=Crown of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 18, 65002, "", "=q4=Crown of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 20, 65024, "", "=q4=Crul'korak, the Lightning's Arc", "=ds=#h1#, #w1#", ""};
				{ 21, 65003, "", "=q4=Reclaimed Ashkandi, Greatsword of the Brotherhood", "=ds=#h2#, #w10#", ""};
				{ 22, 65017, "", "=q4=Andoros, Fist of the Dragon King", "=ds=#h1#, #w6#", ""};
				{ 23, 65023, "", "=q4=Akmin-Kurai, Dominion's Shield", "=ds=#w8#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Nefarian's End", 174),
			module = moduleName, instance = "BlackwingDescent",
		};
	};

	AtlasLoot_Data["BDTrash"] = {
		["Normal"] = {
			{
				{ 1, 59466, "", "=q4=Ironstar's Impenetrable Cover", "=ds=#s4#", ""};
				{ 2, 59468, "", "=q4=Shadowforge's Lightbound Smock", "=ds=#s5#, #a1#", ""};
				{ 3, 59467, "", "=q4=Hide of Chromaggus", "=ds=#s3#, #a2#", ""};
				{ 4, 59465, "", "=q4=Corehammer's Riveted Girdle", "=ds=#s10#, #a4#", ""};
				{ 5, 59464, "", "=q4=Treads of Savage Beatings", "=ds=#s12#, #a4#", ""};
				{ 7, 59461, "", "=q4=Fury of Angerforge", "=ds=#s14#", ""};
				{ 16, 59462, "", "=q4=Maimgor's Bite", "=ds=#h4#, #w1#", ""};
				{ 17, 59463, "", "=q4=Maldo's Sword Cane", "=ds=#h1#, #w10#", ""};
				{ 18, 63537, "", "=q4=Claws of Torment", "=ds=#h1#, #w13#", ""};
				{ 19, 63538, "", "=q4=Claws of Agony", "=ds=#h1#, #w13#", ""};
				{ 20, 68601, "", "=q4=Scaleslicer", "=ds=#h1#, #w4#", ""};
				{ 21, 59460, "", "=q4=Theresa's Booklight", "=ds=#w12#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "BlackwingDescent",
		};
	};

		-------------------------------------
		--- Caverns of Time: Dragon Soul ----
		-------------------------------------

	AtlasLoot_Data["DragonSoulMorchok"] = {
		["RaidFinder"] = {
			{
				{ 1, 78381, "", "=q4=Mosswrought Shoulderguards", "=ds=#s3#, #a1#" },
				{ 2, 78380, "", "=q4=Robe of Glowing Stone", "=ds=#s5#, #a1#" },
				{ 3, 78375, "", "=q4=Underdweller's Spaulders", "=ds=#s3#, #a2#" },
				{ 4, 78384, "", "=q4=Mycosynth Wristguards", "=ds=#s8#, #a2#" },
				{ 5, 78376, "", "=q4=Sporebeard Gauntlets", "=ds=#s9#, #a3#" },
				{ 6, 78385, "", "=q4=Girdle of Shattered Stone", "=ds=#s10#, #a3#" },
				{ 7, 78378, "", "=q4=Brackenshell Shoulderplates", "=ds=#s3#, #a4#" },
				{ 8, 78377, "", "=q4=Rockhide Bracers", "=ds=#s8#, #a4#" },
				{ 9, 78386, "", "=q4=Pillarfoot Greaves", "=ds=#s12#, #a4#" },
				{ 16, 78382, "", "=q4=Petrified Fungal Heart", "=ds=#s2#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 77267, "", "=q4=Mosswrought Shoulderguards", "=ds=#s3#, #a1#" },
				{ 2, 77263, "", "=q4=Robe of Glowing Stone", "=ds=#s5#, #a1#" },
				{ 3, 77271, "", "=q4=Underdweller's Spaulders", "=ds=#s3#, #a2#" },
				{ 4, 77261, "", "=q4=Mycosynth Wristguards", "=ds=#s8#, #a2#" },
				{ 5, 77269, "", "=q4=Sporebeard Gauntlets", "=ds=#s9#, #a3#" },
				{ 6, 77266, "", "=q4=Girdle of Shattered Stone", "=ds=#s10#, #a3#" },
				{ 7, 77268, "", "=q4=Brackenshell Shoulderplates", "=ds=#s3#, #a4#" },
				{ 8, 77270, "", "=q4=Rockhide Bracers", "=ds=#s8#, #a4#" },
				{ 9, 77265, "", "=q4=Pillarfoot Greaves", "=ds=#s12#, #a4#" },
				{ 16, 77262, "", "=q4=Petrified Fungal Heart", "=ds=#s2#" },
				{ 18, 77214, "", "=q4=Vagaries of Time", "=ds=#h1#, #w6#" },
				{ 19, 77212, "", "=q4=Hand of Morchok", "=ds=#h1#, #w1#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78366, "", "=q4=Mosswrought Shoulderguards", "=ds=#s3#, #a1#" },
				{ 2, 78365, "", "=q4=Robe of Glowing Stone", "=ds=#s5#, #a1#" },
				{ 3, 78368, "", "=q4=Underdweller's Spaulders", "=ds=#s3#, #a2#" },
				{ 4, 78372, "", "=q4=Mycosynth Wristguards", "=ds=#s8#, #a2#" },
				{ 5, 78362, "", "=q4=Sporebeard Gauntlets", "=ds=#s9#, #a3#" },
				{ 6, 78370, "", "=q4=Girdle of Shattered Stone", "=ds=#s10#, #a3#" },
				{ 7, 78367, "", "=q4=Brackenshell Shoulderplates", "=ds=#s3#, #a4#" },
				{ 8, 78373, "", "=q4=Rockhide Bracers", "=ds=#s8#, #a4#" },
				{ 9, 78361, "", "=q4=Pillarfoot Greaves", "=ds=#s12#, #a4#" },
				{ 16, 78364, "", "=q4=Petrified Fungal Heart", "=ds=#s2#" },
				{ 18, 78363, "", "=q4=Vagaries of Time", "=ds=#h1#, #w6#" },
				{ 19, 78371, "", "=q4=Hand of Morchok", "=ds=#h1#, #w1#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Morchok", 311),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulZonozz"] = {
		["RaidFinder"] = {
			{
				{ 1, 78398, "", "=q4=Cord of the Slain Champion", "=ds=#s10#, #a1#" },
				{ 2, 78395, "", "=q4=Belt of Flayed Skin", "=ds=#s10#, #a2#" },
				{ 3, 78400, "", "=q4=Grotesquely Writhing Bracers", "=ds=#s8#, #a3#" },
				{ 4, 78397, "", "=q4=Graveheart Bracers", "=ds=#s8#, #a4#" },
				{ 5, 78396, "", "=q4=Treads of Crushed Flesh", "=ds=#s12#, #a4#" },
				{ 7, 77969, "", "=q4=Seal of the Seven Signs", "=ds=#s14#" },
				{ 16, 78866, "", "=q4=Gauntlets of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78867, "", "=q4=Gauntlets of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78865, "", "=q4=Gauntlets of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 78399, "", "=q4=Finger of Zon'ozz", "=ds=#w12#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 77255, "", "=q4=Cord of the Slain Champion", "=ds=#s10#, #a1#" },
				{ 2, 77260, "", "=q4=Belt of Flayed Skin", "=ds=#s10#, #a2#" },
				{ 3, 77257, "", "=q4=Grotesquely Writhing Bracers", "=ds=#s8#, #a3#" },
				{ 4, 77258, "", "=q4=Graveheart Bracers", "=ds=#s8#, #a4#" },
				{ 5, 77259, "", "=q4=Treads of Crushed Flesh", "=ds=#s12#, #a4#" },
				{ 7, 77204, "", "=q4=Seal of the Seven Signs", "=ds=#s14#" },
				{ 16, 78183, "", "=q4=Gauntlets of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78178, "", "=q4=Gauntlets of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78173, "", "=q4=Gauntlets of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77215, "", "=q4=Horrifying Horn Arbalest", "=ds=#w3#" },
				{ 21, 77216, "", "=q4=Finger of Zon'ozz", "=ds=#w12#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78391, "", "=q4=Cord of the Slain Champion", "=ds=#s10#, #a1#" },
				{ 2, 78388, "", "=q4=Belt of Flayed Skin", "=ds=#s10#, #a2#" },
				{ 3, 78393, "", "=q4=Grotesquely Writhing Bracers", "=ds=#s8#, #a3#" },
				{ 4, 78390, "", "=q4=Graveheart Bracers", "=ds=#s8#, #a4#" },
				{ 5, 78389, "", "=q4=Treads of Crushed Flesh", "=ds=#s12#, #a4#" },
				{ 7, 77989, "", "=q4=Seal of the Seven Signs", "=ds=#s14#" },
				{ 16, 78853, "", "=q4=Gauntlets of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78854, "", "=q4=Gauntlets of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78855, "", "=q4=Gauntlets of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 78387, "", "=q4=Horrifying Horn Arbalest", "=ds=#w3#" },
				{ 21, 78392, "", "=q4=Finger of Zon'ozz", "=ds=#w12#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulYorsahj"] = {
		["RaidFinder"] = {
			{
				{ 1, 78408, "", "=q4=Interrogator's Bloody Footpads", "=ds=#s12#, #a2#" },
				{ 2, 78411, "", "=q4=Mindstrainer Treads", "=ds=#s12#, #a3#" },
				{ 3, 78412, "", "=q4=Heartblood Wristplates", "=ds=#s8#, #a4#" },
				{ 5, 77971, "", "=q4=Insignia of the Corrupted Mind", "=ds=#s14#" },
				{ 6, 77970, "", "=q4=Soulshifter Vortex", "=ds=#s14#" },
				{ 16, 78872, "", "=q4=Leggings of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78873, "", "=q4=Leggings of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78871, "", "=q4=Leggings of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
			};
		};
		["Normal"] = {
			{
				{ 1, 77254, "", "=q4=Interrogator's Bloody Footpads", "=ds=#s12#, #a2#" },
				{ 2, 77252, "", "=q4=Mindstrainer Treads", "=ds=#s12#, #a3#" },
				{ 3, 77253, "", "=q4=Heartblood Wristplates", "=ds=#s8#, #a4#" },
				{ 5, 77217, "", "=q4=Experimental Specimen Slicer", "=ds=#h2#, #w1#" },
				{ 6, 77218, "", "=q4=Spire of Coagulated Globules", "=ds=#w9#" },
				{ 7, 77219, "", "=q4=Scalpel of Unrelenting Agony", "=ds=#h1#, #w4#" },
				{ 16, 78181, "", "=q4=Leggings of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78176, "", "=q4=Leggings of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78171, "", "=q4=Leggings of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77203, "", "=q4=Insignia of the Corrupted Mind", "=ds=#s14#" },
				{ 21, 77206, "", "=q4=Soulshifter Vortex", "=ds=#s14#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78402, "", "=q4=Interrogator's Bloody Footpads", "=ds=#s12#, #a2#" },
				{ 2, 78405, "", "=q4=Mindstrainer Treads", "=ds=#s12#, #a3#" },
				{ 3, 78406, "", "=q4=Heartblood Wristplates", "=ds=#s8#, #a4#" },
				{ 5, 78403, "", "=q4=Experimental Specimen Slicer", "=ds=#h2#, #w1#" },
				{ 6, 78401, "", "=q4=Spire of Coagulated Globules", "=ds=#w9#" },
				{ 7, 78404, "", "=q4=Scalpel of Unrelenting Agony", "=ds=#h1#, #w4#" },
				{ 16, 78856, "", "=q4=Leggings of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78857, "", "=q4=Leggings of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78858, "", "=q4=Leggings of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77991, "", "=q4=Insignia of the Corrupted Mind", "=ds=#s14#" },
				{ 21, 77990, "", "=q4=Soulshifter Vortex", "=ds=#s14#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulHagara"] = {
		["RaidFinder"] = {
			{
				{ 1, 78425, "", "=q4=Bracers of the Banished", "=ds=#s8#, #a1#" },
				{ 2, 78428, "", "=q4=Girdle of the Grotesque", "=ds=#s10#, #a2#" },
				{ 3, 78423, "", "=q4=Treads of Dormant Dreams", "=ds=#s12#, #a3#" },
				{ 4, 78424, "", "=q4=Runescriven Demon Collar", "=ds=#s10#, #a4#" },
				{ 6, 78427, "", "=q4=Ring of the Riven", "=ds=#s13#" },
				{ 7, 78421, "", "=q4=Signet of Grasping Mouths", "=ds=#s13#" },
				{ 16, 78875, "", "=q4=Shoulders of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78876, "", "=q4=Shoulders of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78874, "", "=q4=Shoulders of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 78422, "", "=q4=Electrowing Dagger", "=ds=#h1#, #w4#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 77249, "", "=q4=Bracers of the Banished", "=ds=#s8#, #a1#" },
				{ 2, 77248, "", "=q4=Girdle of the Grotesque", "=ds=#s10#, #a2#" },
				{ 3, 77251, "", "=q4=Treads of Dormant Dreams", "=ds=#s12#, #a3#" },
				{ 4, 77250, "", "=q4=Runescriven Demon Collar", "=ds=#s10#, #a4#" },
				{ 6, 78012, "", "=q4=Ring of the Riven", "=ds=#s13#" },
				{ 7, 78011, "", "=q4=Signet of Grasping Mouths", "=ds=#s13#" },
				{ 16, 78180, "", "=q4=Shoulders of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78175, "", "=q4=Shoulders of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78170, "", "=q4=Shoulders of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77221, "", "=q4=Lightning Rod", "=ds=#w9#" },
				{ 21, 77220, "", "=q4=Electrowing Dagger", "=ds=#h1#, #w4#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78417, "", "=q4=Bracers of the Banished", "=ds=#s8#, #a1#" },
				{ 2, 78420, "", "=q4=Girdle of the Grotesque", "=ds=#s10#, #a2#" },
				{ 3, 78415, "", "=q4=Treads of Dormant Dreams", "=ds=#s12#, #a3#" },
				{ 4, 78416, "", "=q4=Runescriven Demon Collar", "=ds=#s10#, #a4#" },
				{ 6, 78419, "", "=q4=Ring of the Riven", "=ds=#s13#" },
				{ 7, 78413, "", "=q4=Signet of Grasping Mouths", "=ds=#s13#" },
				{ 16, 78859, "", "=q4=Shoulders of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78860, "", "=q4=Shoulders of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78861, "", "=q4=Shoulders of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 78418, "", "=q4=Lightning Rod", "=ds=#w9#" },
				{ 21, 78414, "", "=q4=Electrowing Dagger", "=ds=#h1#, #w4#" },		
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulUltraxion"] = {
		["RaidFinder"] = {
			{
				{ 1, 78442, "", "=q4=Treads of Sordid Screams", "=ds=#s12#, #a2#" },
				{ 2, 78443, "", "=q4=Imperfect Specimens 27 and 28", "=ds=#s3#, #a3#" },
				{ 3, 78438, "", "=q4=Bracers of Looming Darkness", "=ds=#s8#, #a3#" },
				{ 4, 78444, "", "=q4=Dragonfracture Belt", "=ds=#s10#, #a4#" },
				{ 5, 78439, "", "=q4=Stillheart Warboots", "=ds=#s12#, #a4#" },
				{ 7, 78440, "", "=q4=Curled Twilight Claw", "=ds=#s13#" },
				{ 8, 77972, "", "=q4=Creche of the Final Dragon", "=ds=#s14#" },
				{ 9, 78441, "", "=q4=Ledger of Revolting Rituals", "=ds=#s15#" },
				{ 16, 78863, "", "=q4=Chest of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78864, "", "=q4=Chest of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78862, "", "=q4=Chest of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
			};
		};
		["Normal"] = {
			{
				{ 1, 77243, "", "=q4=Treads of Sordid Screams", "=ds=#s12#, #a2#" },
				{ 2, 77242, "", "=q4=Imperfect Specimens 27 and 28", "=ds=#s3#, #a3#" },
				{ 3, 77247, "", "=q4=Bracers of Looming Darkness", "=ds=#s8#, #a3#" },
				{ 4, 77244, "", "=q4=Dragonfracture Belt", "=ds=#s10#, #a4#" },
				{ 5, 77246, "", "=q4=Stillheart Warboots", "=ds=#s12#, #a4#" },
				{ 7, 78013, "", "=q4=Curled Twilight Claw", "=ds=#s13#" },
				{ 8, 77205, "", "=q4=Creche of the Final Dragon", "=ds=#s14#" },
				{ 9, 77245, "", "=q4=Ledger of Revolting Rituals", "=ds=#s15#" },
				{ 16, 78184, "", "=q4=Chest of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78179, "", "=q4=Chest of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78174, "", "=q4=Chest of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77223, "", "=q4=Morningstar of Heroic Will", "=ds=#h1#, #w6#" },
				{ 22, 78919, "", "=q4=Experiment 12-B", "=ds=#e27#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78434, "", "=q4=Treads of Sordid Screams", "=ds=#s12#, #a2#" },
				{ 2, 78435, "", "=q4=Imperfect Specimens 27 and 28", "=ds=#s3#, #a3#" },
				{ 3, 78430, "", "=q4=Bracers of Looming Darkness", "=ds=#s8#, #a3#" },
				{ 4, 78436, "", "=q4=Dragonfracture Belt", "=ds=#s10#, #a4#" },
				{ 5, 78431, "", "=q4=Stillheart Warboots", "=ds=#s12#, #a4#" },
				{ 7, 78432, "", "=q4=Curled Twilight Claw", "=ds=#s13#" },
				{ 8, 77992, "", "=q4=Creche of the Final Dragon", "=ds=#s14#" },
				{ 9, 78433, "", "=q4=Ledger of Revolting Rituals", "=ds=#s15#" },
				{ 16, 78847, "", "=q4=Chest of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78848, "", "=q4=Chest of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78849, "", "=q4=Chest of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 78429, "", "=q4=Morningstar of Heroic Will", "=ds=#h1#, #w6#" },
				{ 22, 78919, "", "=q4=Experiment 12-B", "=ds=#e27#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ultraxion", 331),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulBlackhorn"] = {
		["RaidFinder"] = {
			{
				{ 1, 78457, "", "=q4=Janglespur Jackboots", "=ds=#s12#, #a1#" },
				{ 2, 78454, "", "=q4=Shadow Wing Armbands", "=ds=#s8#, #a2#" },
				{ 3, 78455, "", "=q4=Belt of the Beloved Companion", "=ds=#s10#, #a3#" },
				{ 4, 78460, "", "=q4=Goriona's Collar", "=ds=#s10#, #a4#" },
				{ 6, 77973, "", "=q4=Starcatcher Compass", "=ds=#s14#" },
				{ 16, 78869, "", "=q4=Crown of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78870, "", "=q4=Crown of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78868, "", "=q4=Crown of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 78456, "", "=q4=Blackhorn's Mighty Bulwark", "=ds=#w8#" },
				{ 21, 78458, "", "=q4=Timepiece of the Bronze Flight", "=ds=#w8#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 77234, "", "=q4=Janglespur Jackboots", "=ds=#s12#, #a1#" },
				{ 2, 77240, "", "=q4=Shadow Wing Armbands", "=ds=#s8#, #a2#" },
				{ 3, 77241, "", "=q4=Belt of the Beloved Companion", "=ds=#s10#, #a3#" },
				{ 4, 77239, "", "=q4=Goriona's Collar", "=ds=#s10#, #a4#" },
				{ 6, 77224, "", "=q4=Ataraxis, Cudgel of the Warmaster", "=ds=#h2#, #w6#" },
				{ 7, 77225, "", "=q4=Visage of the Destroyer", "=ds=#w9#" },
				{ 8, 77226, "", "=q4=Blackhorn's Mighty Bulwark", "=ds=#w8#" },
				{ 9, 77227, "", "=q4=Timepiece of the Bronze Flight", "=ds=#w8#" },
				{ 16, 78182, "", "=q4=Crown of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78177, "", "=q4=Crown of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78172, "", "=q4=Crown of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77202, "", "=q4=Starcatcher Compass", "=ds=#s14#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78449, "", "=q4=Janglespur Jackboots", "=ds=#s12#, #a1#" },
				{ 2, 78446, "", "=q4=Shadow Wing Armbands", "=ds=#s8#, #a2#" },
				{ 3, 78447, "", "=q4=Belt of the Beloved Companion", "=ds=#s10#, #a3#" },
				{ 4, 78452, "", "=q4=Goriona's Collar", "=ds=#s10#, #a4#" },
				{ 6, 78445, "", "=q4=Ataraxis, Cudgel of the Warmaster", "=ds=#h2#, #w6#" },
				{ 7, 78451, "", "=q4=Visage of the Destroyer", "=ds=#w9#" },
				{ 8, 78448, "", "=q4=Blackhorn's Mighty Bulwark", "=ds=#w8#" },
				{ 9, 78450, "", "=q4=Timepiece of the Bronze Flight", "=ds=#w8#" },
				{ 16, 78850, "", "=q4=Crown of the Corrupted Conqueror", "=ds=#e15#, #m39#"};
				{ 17, 78851, "", "=q4=Crown of the Corrupted Protector", "=ds=#e15#, #m39#"};
				{ 18, 78852, "", "=q4=Crown of the Corrupted Vanquisher", "=ds=#e15#, #m39#"};
				{ 20, 77993, "", "=q4=Starcatcher Compass", "=ds=#s14#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulDeathwingSpine"] = {
		["RaidFinder"] = {
			{
				{ 1, 78466, "", "=q4=Gloves of Liquid Smoke", "=ds=#s9#, #a1#" },
				{ 2, 78467, "", "=q4=Molten Blood Footpads", "=ds=#s12#, #a2#" },
				{ 3, 78468, "", "=q4=Belt of Shattered Elementium", "=ds=#s10#, #a3#" },
				{ 4, 78470, "", "=q4=Backbreaker Spaulders", "=ds=#s3#, #a4#" },
				{ 5, 78469, "", "=q4=Gauntlets of the Golden Thorn", "=ds=#s9#, #a4#" },
				{ 16, 77977, "", "=q4=Eye of Unmaking", "=ds=#s14#" },
				{ 17, 77976, "", "=q4=Heart of Unliving", "=ds=#s14#" },
				{ 18, 77975, "", "=q4=Will of Unbinding", "=ds=#s14#" },
				{ 19, 77974, "", "=q4=Wrath of Unchaining", "=ds=#s14#" },
				{ 20, 77978, "", "=q4=Resolve of Undying", "=ds=#s14#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 78357, "", "=q4=Gloves of Liquid Smoke", "=ds=#s9#, #a1#" },
				{ 2, 77238, "", "=q4=Molten Blood Footpads", "=ds=#s12#, #a2#" },
				{ 3, 77237, "", "=q4=Belt of Shattered Elementium", "=ds=#s10#, #a3#" },
				{ 4, 77236, "", "=q4=Backbreaker Spaulders", "=ds=#s3#, #a4#" },
				{ 5, 77235, "", "=q4=Gauntlets of the Golden Thorn", "=ds=#s9#, #a4#" },
				{ 16, 77200, "", "=q4=Eye of Unmaking", "=ds=#s14#" },
				{ 17, 77199, "", "=q4=Heart of Unliving", "=ds=#s14#" },
				{ 18, 77198, "", "=q4=Will of Unbinding", "=ds=#s14#" },
				{ 19, 77197, "", "=q4=Wrath of Unchaining", "=ds=#s14#" },
				{ 20, 77201, "", "=q4=Resolve of Undying", "=ds=#s14#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78461, "", "=q4=Gloves of Liquid Smoke", "=ds=#s9#, #a1#" },
				{ 2, 78462, "", "=q4=Molten Blood Footpads", "=ds=#s12#, #a2#" },
				{ 3, 78463, "", "=q4=Belt of Shattered Elementium", "=ds=#s10#, #a3#" },
				{ 4, 78465, "", "=q4=Backbreaker Spaulders", "=ds=#s3#, #a4#" },
				{ 5, 78464, "", "=q4=Gauntlets of the Golden Thorn", "=ds=#s9#, #a4#" },
				{ 16, 77997, "", "=q4=Eye of Unmaking", "=ds=#s14#" },
				{ 17, 77996, "", "=q4=Heart of Unliving", "=ds=#s14#" },
				{ 18, 77995, "", "=q4=Will of Unbinding", "=ds=#s14#" },
				{ 19, 77994, "", "=q4=Wrath of Unchaining", "=ds=#s14#" },
				{ 20, 77998, "", "=q4=Resolve of Undying", "=ds=#s14#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Spine of Deathwing", 318),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulDeathwingMadness"] = {
		["RaidFinder"] = {
			{
				{ 1, 78484, "", "=q4=Rathrak, the Poisonous Mind", "=ds=#h1#, #w4#" },
				{ 2, 78483, "", "=q4=Blade of the Unmaker", "=ds=#h1#, #w4#" },
				{ 3, 78488, "", "=q4=Souldrinker", "=ds=#h1#, #w10#" },
				{ 4, 78487, "", "=q4=Gurthalak, Voice of the Deeps", "=ds=#h2#, #w10#" },
				{ 5, 78481, "", "=q4=No'Kaled, the Elements of Death", "=ds=#h1#, #w1#" },
				{ 6, 78485, "", "=q4=Maw of the Dragonlord", "=ds=#h1#, #w6#" },
				{ 16, 78482, "", "=q4=Kiril, Fury of Beasts", "=ds=#w7#" },
				{ 17, 78486, "", "=q4=Ti'tahk, the Steps of Time", "=ds=#w9#" },
				{ 18, 78480, "", "=q4=Vishanka, Jaws of the Earth", "=ds=#w2#" },
			};
		};
		["Normal"] = {
			{
				{ 1, 77195, "", "=q4=Rathrak, the Poisonous Mind", "=ds=#h1#, #w4#" },
				{ 2, 77189, "", "=q4=Blade of the Unmaker", "=ds=#h1#, #w4#" },
				{ 3, 77193, "", "=q4=Souldrinker", "=ds=#h1#, #w10#" },
				{ 4, 77191, "", "=q4=Gurthalak, Voice of the Deeps", "=ds=#h2#, #w10#" },
				{ 5, 77188, "", "=q4=No'Kaled, the Elements of Death", "=ds=#h1#, #w1#" },
				{ 6, 77196, "", "=q4=Maw of the Dragonlord", "=ds=#h1#, #w6#" },
				{ 16, 77194, "", "=q4=Kiril, Fury of Beasts", "=ds=#w7#" },
				{ 17, 77190, "", "=q4=Ti'tahk, the Steps of Time", "=ds=#w9#" },
				{ 18, 78359, "", "=q4=Vishanka, Jaws of the Earth", "=ds=#w2#" },
				{ 20, 77067, "", "=q4=Reins of the Blazing Drake", "=ds=#e27#" },
			};
		};
		["Heroic"] = {
			{
				{ 1, 78475, "", "=q4=Rathrak, the Poisonous Mind", "=ds=#h1#, #w4#" },
				{ 2, 78474, "", "=q4=Blade of the Unmaker", "=ds=#h1#, #w4#" },
				{ 3, 78479, "", "=q4=Souldrinker", "=ds=#h1#, #w10#" },
				{ 4, 78478, "", "=q4=Gurthalak, Voice of the Deeps", "=ds=#h2#, #w10#" },
				{ 5, 78472, "", "=q4=No'Kaled, the Elements of Death", "=ds=#h1#, #w1#" },
				{ 6, 78476, "", "=q4=Maw of the Dragonlord", "=ds=#h1#, #w6#" },
				{ 16, 78473, "", "=q4=Kiril, Fury of Beasts", "=ds=#w7#" },
				{ 17, 78477, "", "=q4=Ti'tahk, the Steps of Time", "=ds=#w9#" },
				{ 18, 78471, "", "=q4=Vishanka, Jaws of the Earth", "=ds=#w2#" },
				{ 20, 77069, "", "=q4=Life-Binder's Handmaiden", "=ds=#e27#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Madness of Deathwing", 333),
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulShared"] = {
		["RaidFinder"] = {
			{
				{ 2, 78497, "", "=q4=Breathstealer Band", "=ds=#s13#" },
				{ 3, 78498, "", "=q4=Hardheart Ring", "=ds=#s13#" },
				{ 4, 78495, "", "=q4=Infinite Loop", "=ds=#s13#" },
				{ 5, 78494, "", "=q4=Seal of Primordial Shadow", "=ds=#s13#" },
				{ 6, 78496, "", "=q4=Signet of Suturing", "=ds=#s13#" },
				{ 8, 52078, "", "=q3=Chaos Orb", "=ds=#e8#" },
				{ 17, 77982, "", "=q4=Bone-Link Fetish", "=ds=#s14#" },
				{ 18, 77980, "", "=q4=Cunning of the Cruel", "=ds=#s14#" },
				{ 19, 77983, "", "=q4=Indomitable Pride", "=ds=#s14#" },
				{ 20, 77979, "", "=q4=Vial of Shadows", "=ds=#s14#" },
				{ 21, 77981, "", "=q4=Windward Heart", "=ds=#s14#" },
			};
		};
		["Normal"] = {
			{
				{ 2, 77230, "", "=q4=Breathstealer Band", "=ds=#s13#" },
				{ 3, 77232, "", "=q4=Hardheart Ring", "=ds=#s13#" },
				{ 4, 77228, "", "=q4=Infinite Loop", "=ds=#s13#" },
				{ 5, 77231, "", "=q4=Seal of Primordial Shadow", "=ds=#s13#" },
				{ 6, 77229, "", "=q4=Signet of Suturing", "=ds=#s13#" },
				{ 8, 71998, "", "=q4=Essence of Destruction", "=ds=#e8#" },
				{ 17, 77210, "", "=q4=Bone-Link Fetish", "=ds=#s14#" },
				{ 18, 77208, "", "=q4=Cunning of the Cruel", "=ds=#s14#" },
				{ 19, 77211, "", "=q4=Indomitable Pride", "=ds=#s14#" },
				{ 20, 77207, "", "=q4=Vial of Shadows", "=ds=#s14#" },
				{ 21, 77209, "", "=q4=Windward Heart", "=ds=#s14#" },
			};
		};
		["Heroic"] = {
			{
				{ 2, 78492, "", "=q4=Breathstealer Band", "=ds=#s13#" },
				{ 3, 78493, "", "=q4=Hardheart Ring", "=ds=#s13#" },
				{ 4, 78490, "", "=q4=Infinite Loop", "=ds=#s13#" },
				{ 5, 78489, "", "=q4=Seal of Primordial Shadow", "=ds=#s13#" },
				{ 6, 78491, "", "=q4=Signet of Suturing", "=ds=#s13#" },
				{ 8, 71998, "", "=q4=Essence of Destruction", "=ds=#e8#" },
				{ 17, 78002, "", "=q4=Bone-Link Fetish", "=ds=#s14#" },
				{ 18, 78000, "", "=q4=Cunning of the Cruel", "=ds=#s14#" },
				{ 19, 78003, "", "=q4=Indomitable Pride", "=ds=#s14#" },
				{ 20, 77999, "", "=q4=Vial of Shadows", "=ds=#s14#" },
				{ 21, 78001, "", "=q4=Windward Heart", "=ds=#s14#" },
			};
		};
		info = {
			name = AL["Shared Boss Loot"],
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulTrash"] = {
		["Normal"] = {
			{
				{ 2, 78879, "", "=q4=Sash of Relentless Truth", "=ds=#s10#, #a1#" },
				{ 3, 78884, "", "=q4=Girdle of Fungal Dreams", "=ds=#s10#, #a2#" },
				{ 4, 78882, "", "=q4=Nightblind Cinch", "=ds=#s10#, #a2#" },
				{ 5, 78886, "", "=q4=Belt of Ghostly Graces", "=ds=#s10#, #a3#" },
				{ 6, 78885, "", "=q4=Dragoncarver Belt", "=ds=#s10#, #a3#" },
				{ 7, 78887, "", "=q4=Girdle of Soulful Mending", "=ds=#s10#, #a4#" },
				{ 8, 78888, "", "=q4=Waistguard of Bleeding Bone", "=ds=#s10#, #a4#" },
				{ 9, 78889, "", "=q4=Waistplate of the Desecrated Future", "=ds=#s10#, #a4#" },
				{ 17, 78878, "", "=q4=Spine of the Thousand Cuts", "=ds=#h1#, #w10#" },
				{ 18, 77192, "", "=q4=Ruinblaster Shotgun", "=ds=#w5#" },
				{ 20, 77938, "", "=q4=Dragonfire Orb", "=ds=#s15#" },
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "CoTDragonSoul",
		};
	};

	AtlasLoot_Data["DragonSoulPatterns"] = {
		["Normal"] = {
			{
				{ 1, 72004, "", "=q4=Pattern: Bracers of Unconquered Power", "=ds=#p8# (525)"};
				{ 2, 72003, "", "=q4=Pattern: Dreamwraps of the Light", "=ds=#p8# (525)"};
				{ 3, 72002, "", "=q4=Pattern: Lavaquake Legwraps", "=ds=#p8# (525)"};
				{ 4, 72000, "", "=q4=Pattern: World Mender's Pants", "=ds=#p8# (525)"};
				{ 6, 72006, "", "=q4=Pattern: Bladeshadow Leggings", "=ds=#p7# (525)"};
				{ 7, 72010, "", "=q4=Pattern: Bladeshadow Wristguards", "=ds=#p7# (525)"};
				{ 8, 72008, "", "=q4=Pattern: Bracers of Flowing Serenity", "=ds=#p7# (525)"};
				{ 9, 72011, "", "=q4=Pattern: Bracers of the Hunter-Killer", "=ds=#p7# (525)"};
				{ 10, 72005, "", "=q4=Pattern: Deathscale Leggings", "=ds=#p7# (525)"};
				{ 11, 71999, "", "=q4=Pattern: Leggings of Nature's Champion", "=ds=#p7# (525)"};
				{ 12, 72007, "", "=q4=Pattern: Rended Earth Leggings", "=ds=#p7# (525)"};
				{ 13, 72009, "", "=q4=Pattern: Thundering Deathscale Wristguards", "=ds=#p7# (525)"};
				{ 16, 72015, "", "=q4=Plans: Bracers of Destructive Strength", "=ds=#p2# (525)"};
				{ 17, 72013, "", "=q4=Plans: Foundations of Courage", "=ds=#p2# (525)"};
				{ 18, 72001, "", "=q4=Plans: Pyrium Legplates of Purified Evil", "=ds=#p2# (525)"};
				{ 19, 72014, "", "=q4=Plans: Soul Redeemer Bracers", "=ds=#p2# (525)"};
				{ 20, 72016, "", "=q4=Plans: Titanguard Wristplates", "=ds=#p2# (525)"};
				{ 21, 72012, "", "=q4=Plans: Unstoppable Destroyer's Legplates", "=ds=#p2# (525)"};
			};
		};
		info = {
			name = ALIL["Dragon Soul"].. " "..AL["Patterns/Plans"],
			module = moduleName, instance = "DragonSoul",
		};
	};

		----------------------
		--- Firelands ----
		----------------------

	AtlasLoot_Data["FirelandsBethtilac"] = {
		["Normal"] = {
			{
				{ 1, 71041, "", "=q4=Robes of Smoldering Devastation", "=ds=#s5#, #a1#"};
				{ 2, 71040, "", "=q4=Cowl of the Clicking Menace", "=ds=#s1#, #a2#"};
				{ 3, 71044, "", "=q4=Cindersilk Gloves", "=ds=#s9#, #a2#"};
				{ 4, 71031, "", "=q4=Cinderweb Leggings", "=ds=#s11#, #a2#"};
				{ 5, 71030, "", "=q4=Flickering Shoulders", "=ds=#s3#, #a3#"};
				{ 6, 71042, "", "=q4=Thoracic Flame Kilt", "=ds=#s11#, #a3#"};
				{ 7, 71043, "", "=q4=Spaulders of Manifold Eyes", "=ds=#s3#, #a4#"};
				{ 8, 70914, "", "=q4=Carapace of Imbibed Flame", "=ds=#s5#, #a4#"};
				{ 9, 71029, "", "=q4=Arachnaflame Treads", "=ds=#s12#, #a4#"};
				{ 11, 71032, "", "=q4=Widow's Kiss", "=ds=#s13#"};
				{ 12, 68981, "", "=q4=Spidersilk Spindle", "=ds=#s14#" },
				{ 16, 70922, "", "=q4=Mandible of Beth'tilac", "=ds=#h1#, #w10#"};
				{ 17, 71039, "", "=q4=Funeral Pyre", "=ds=#w9#"};
				{ 18, 71038, "", "=q4=Ward of the Red Widow", "=ds=#w8#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71407, "", "=q4=Robes of Smoldering Devastation", "=ds=#s5#, #a1#"};
				{ 2, 71411, "", "=q4=Cowl of the Clicking Menace", "=ds=#s1#, #a2#"};
				{ 3, 71410, "", "=q4=Cindersilk Gloves", "=ds=#s9#, #a2#"};
				{ 4, 71402, "", "=q4=Cinderweb Leggings", "=ds=#s11#, #a2#"};
				{ 5, 71403, "", "=q4=Flickering Shoulders", "=ds=#s3#, #a3#"};
				{ 6, 71412, "", "=q4=Thoracic Flame Kilt", "=ds=#s11#, #a3#"};
				{ 7, 71413, "", "=q4=Spaulders of Manifold Eyes", "=ds=#s3#, #a4#"};
				{ 8, 71405, "", "=q4=Carapace of Imbibed Flame", "=ds=#s5#, #a4#"};
				{ 9, 71404, "", "=q4=Arachnaflame Treads", "=ds=#s12#, #a4#"};
				{ 11, 71401, "", "=q4=Widow's Kiss", "=ds=#s13#"};
				{ 12, 69138, "", "=q4=Spidersilk Spindle", "=ds=#s14#" },
				{ 16, 71406, "", "=q4=Mandible of Beth'tilac", "=ds=#h1#, #w10#"};
				{ 17, 71409, "", "=q4=Funeral Pyre", "=ds=#w9#"};
				{ 18, 71408, "", "=q4=Ward of the Red Widow", "=ds=#w8#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Beth'tilac", 192),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsRhyolith"] = {
		["Normal"] = {
			{
				{ 1, 70992, "", "=q4=Dreadfire Drape", "=ds=#s4#"};
				{ 2, 71011, "", "=q4=Flickering Cowl", "=ds=#s1#, #a1#"};
				{ 3, 71003, "", "=q4=Hood of Rampant Disdain", "=ds=#s1#, #a2#"};
				{ 4, 71010, "", "=q4=Incendic Chestguard", "=ds=#s5#, #a2#"};
				{ 5, 71005, "", "=q4=Flaming Core Chestguard", "=ds=#s5#, #a3#"};
				{ 6, 71009, "", "=q4=Lava Line Wristbands", "=ds=#s8#, #a3#"};
				{ 7, 71004, "", "=q4=Earthcrack Bracers", "=ds=#s8#, #a4#"};
				{ 8, 70993, "", "=q4=Fireskin Gauntlets", "=ds=#s9#, #a4#"};
				{ 9, 71007, "", "=q4=Grips of the Raging Giant", "=ds=#s9#, #a4#"};
				{ 10, 70912, "", "=q4=Cracked Obsidian Stompers", "=ds=#s12#, #a4#"};
				{ 16, 71012, "", "=q4=Heartstone of Rhyolith", "=ds=#s2#"};
				{ 18, 71006, "", "=q4=Volcanospike", "=ds=#h1#, #w10#"};
				{ 19, 70991, "", "=q4=Arbalest of Erupting Fury", "=ds=#w3#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71415, "", "=q4=Dreadfire Drape", "=ds=#s4#"};
				{ 2, 71421, "", "=q4=Flickering Cowl", "=ds=#s1#, #a1#"};
				{ 3, 71416, "", "=q4=Hood of Rampant Disdain", "=ds=#s1#, #a2#"};
				{ 4, 71424, "", "=q4=Incendic Chestguard", "=ds=#s5#, #a2#"};
				{ 5, 71417, "", "=q4=Flaming Core Chestguard", "=ds=#s5#, #a3#"};
				{ 6, 71425, "", "=q4=Lava Line Wristbands", "=ds=#s8#, #a3#"};
				{ 7, 71418, "", "=q4=Earthcrack Bracers", "=ds=#s8#, #a4#"};
				{ 8, 71419, "", "=q4=Fireskin Gauntlets", "=ds=#s9#, #a4#"};
				{ 9, 71426, "", "=q4=Grips of the Raging Giant", "=ds=#s9#, #a4#"};
				{ 10, 71420, "", "=q4=Cracked Obsidian Stompers", "=ds=#s12#, #a4#"};
				{ 16, 71423, "", "=q4=Heartstone of Rhyolith", "=ds=#s2#"};
				{ 18, 71422, "", "=q4=Volcanospike", "=ds=#h1#, #w10#"};
				{ 19, 71414, "", "=q4=Arbalest of Erupting Fury", "=ds=#w3#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lord Rhyolith", 193),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsAlysrazor"] = {
		["Normal"] = {
			{
				{ 1, 70990, "", "=q4=Wings of Flame", "=ds=#s4#"};
				{ 2, 70989, "", "=q4=Leggings of Billowing Fire", "=ds=#s11#, #a1#"};
				{ 3, 70735, "", "=q4=Flickering Wristbands", "=ds=#s8#, #a2#"};
				{ 4, 70987, "", "=q4=Phoenix-Down Treads", "=ds=#s12#, #a2#"};
				{ 5, 70985, "", "=q4=Craterflame Spaulders", "=ds=#s3#, #a3#"};
				{ 6, 70986, "", "=q4=Clawshaper Gauntlets", "=ds=#s9#, #a3#"};
				{ 7, 70736, "", "=q4=Moltenfeather Leggings", "=ds=#s11#, #a3#"};
				{ 8, 70734, "", "=q4=Greathelm of the Voracious Maw", "=ds=#s1#, #a4#"};
				{ 9, 70737, "", "=q4=Spaulders of Recurring Flame", "=ds=#s3#, #a4#"};
				{ 10, 70988, "", "=q4=Clutch of the Firemother", "=ds=#s5#, #a4#"};
				{ 11, 70739, "", "=q4=Lavaworm Legplates", "=ds=#s11#, #a4#"};
				{ 13, 71665, "", "=q4=Flametalon of Alysrazor", "=ds=#e27#" },
				{ 16, 70738, "", "=q4=Alysrazor's Band", "=ds=#s13#"};
				{ 17, 68983, "", "=q4=Eye of Blazing Power", "=ds=#s14#" },
				{ 19, 70733, "", "=q4=Alysra's Razor", "=ds=#h1#, #w4#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71434, "", "=q4=Wings of Flame", "=ds=#s4#"};
				{ 2, 71435, "", "=q4=Leggings of Billowing Fire", "=ds=#s11#, #a1#"};
				{ 3, 71428, "", "=q4=Flickering Wristbands", "=ds=#s8#, #a2#"};
				{ 4, 71436, "", "=q4=Phoenix-Down Treads", "=ds=#s12#, #a2#"};
				{ 5, 71438, "", "=q4=Craterflame Spaulders", "=ds=#s3#, #a3#"};
				{ 6, 71437, "", "=q4=Clawshaper Gauntlets", "=ds=#s9#, #a3#"};
				{ 7, 71429, "", "=q4=Moltenfeather Leggings", "=ds=#s11#, #a3#"};
				{ 8, 71430, "", "=q4=Greathelm of the Voracious Maw", "=ds=#s1#, #a4#"};
				{ 9, 71432, "", "=q4=Spaulders of Recurring Flame", "=ds=#s3#, #a4#"};
				{ 10, 71439, "", "=q4=Clutch of the Firemother", "=ds=#s5#, #a4#"};
				{ 11, 71431, "", "=q4=Lavaworm Legplates", "=ds=#s11#, #a4#"};
				{ 13, 71665, "", "=q4=Flametalon of Alysrazor", "=ds=#e27#" },
				{ 16, 71679, "", "=q4=Chest of the Fiery Conqueror", "=ds=#e15#, #m38# - #j4#"};
				{ 17, 71686, "", "=q4=Chest of the Fiery Protector", "=ds=#e15#, #m38# - #j4#"};
				{ 18, 71672, "", "=q4=Chest of the Fiery Vanquisher", "=ds=#e15#, #m38# - #j4#"};
				{ 20, 71433, "", "=q4=Alysrazor's Band", "=ds=#s13#"};
				{ 21, 69149, "", "=q4=Eye of Blazing Power", "=ds=#s14#" },
				{ 23, 71427, "", "=q4=Alysra's Razor", "=ds=#h1#, #w4#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Alysrazor", 194),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsShannox"] = {
		["Normal"] = {
			{
				{ 1, 71023, "", "=q4=Coalwalker Sandals", "=ds=#s12#, #a1#"};
				{ 2, 71025, "", "=q4=Flickering Shoulderpads", "=ds=#s3#, #a2#"};
				{ 3, 71020, "", "=q4=Gloves of Dissolving Smoke", "=ds=#s9#, #a2#"};
				{ 4, 71018, "", "=q4=Scalp of the Bandit Prince", "=ds=#s1#, #a3#"};
				{ 5, 71027, "", "=q4=Treads of Implicit Obedience", "=ds=#s12#, #a3#"};
				{ 6, 71026, "", "=q4=Bracers of the Dread Hunter", "=ds=#s8#, #a4#"};
				{ 7, 71021, "", "=q4=Uncrushable Belt of Fury", "=ds=#s10#, #a4#"};
				{ 8, 71028, "", "=q4=Legplates of Absolute Control", "=ds=#s11#, #a4#"};
				{ 9, 70913, "", "=q4=Legplates of Frenzied Devotion", "=ds=#s11#, #a4#"};
				{ 11, 71019, "", "=q4=Necklace of Fetishes", "=ds=#s2#"};
				{ 12, 71024, "", "=q4=Crystal Prison Band", "=ds=#s13#"};
				{ 13, 71022, "", "=q4=Goblet of Anger", "=ds=#s15#"};
				{ 16, 71014, "", "=q4=Skullstealer Greataxe", "=ds=#h2#, #w1#"};
				{ 17, 71013, "", "=q4=Feeding Frenzy", "=ds=#h1#, #w4#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71447, "", "=q4=Coalwalker Sandals", "=ds=#s12#, #a1#"};
				{ 2, 71450, "", "=q4=Flickering Shoulderpads", "=ds=#s3#, #a2#"};
				{ 3, 71440, "", "=q4=Gloves of Dissolving Smoke", "=ds=#s9#, #a2#"};
				{ 4, 71442, "", "=q4=Scalp of the Bandit Prince", "=ds=#s1#, #a3#"};
				{ 5, 71451, "", "=q4=Treads of Implicit Obedience", "=ds=#s12#, #a3#"};
				{ 6, 71452, "", "=q4=Bracers of the Dread Hunter", "=ds=#s8#, #a4#"};
				{ 7, 71443, "", "=q4=Uncrushable Belt of Fury", "=ds=#s10#, #a4#"};
				{ 8, 71453, "", "=q4=Legplates of Absolute Control", "=ds=#s11#, #a4#"};
				{ 9, 71444, "", "=q4=Legplates of Frenzied Devotion", "=ds=#s11#, #a4#"};
				{ 11, 71446, "", "=q4=Necklace of Fetishes", "=ds=#s2#"};
				{ 12, 71449, "", "=q4=Crystal Prison Band", "=ds=#s13#"};
				{ 13, 71448, "", "=q4=Goblet of Anger", "=ds=#s15#"};
				{ 16, 71678, "", "=q4=Leggings of the Fiery Conqueror", "=ds=#e15#, #m38# - #j4#"};
				{ 17, 71685, "", "=q4=Leggings of the Fiery Protector", "=ds=#e15#, #m38# - #j4#"};
				{ 18, 71671, "", "=q4=Leggings of the Fiery Vanquisher", "=ds=#e15#, #m38# - #j4#"};
				{ 20, 71445, "", "=q4=Skullstealer Greataxe", "=ds=#h2#, #w1#"};
				{ 21, 71441, "", "=q4=Feeding Frenzy", "=ds=#h1#, #w4#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Shannox", 195),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsBaleroc"] = {
		["Normal"] = {
			{
				{ 1, 71343, "", "=q4=Mantle of Closed Doors", "=ds=#s3#, #a1#"};
				{ 2, 71345, "", "=q4=Shoulderpads of the Forgotten Gate", "=ds=#s3#, #a2#"};
				{ 3, 71314, "", "=q4=Breastplate of the Incendiary Soul", "=ds=#s5#, #a2#"};
				{ 4, 71341, "", "=q4=Glowing Wing Bracers", "=ds=#s8#, #a2#"};
				{ 5, 71340, "", "=q4=Gatekeeper's Embrace", "=ds=#s5#, #a3#"};
				{ 6, 71315, "", "=q4=Decimation Treads", "=ds=#s12#, #a3#"};
				{ 7, 71342, "", "=q4=Casque of Flame", "=ds=#s1#, #a4#"};
				{ 8, 70916, "", "=q4=Helm of Blazing Glory", "=ds=#s1#, #a4#"};
				{ 9, 70917, "", "=q4=Flickering Handguards", "=ds=#s9#, #a4#"};
				{ 11, 68982, "", "=q4=Necromantic Focus", "=ds=#s14#" },
				{ 12, 71323, "", "=q4=Molten Scream", "=ds=#s15#"};
				{ 16, 71312, "", "=q4=Gatecrasher", "=ds=#h1#, #w1#"};
				{ 17, 70915, "", "=q4=Shard of Torment", "=ds=#w8#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71461, "", "=q4=Mantle of Closed Doors", "=ds=#s3#, #a1#"};
				{ 2, 71456, "", "=q4=Shoulderpads of the Forgotten Gate", "=ds=#s3#, #a2#"};
				{ 3, 71455, "", "=q4=Breastplate of the Incendiary Soul", "=ds=#s5#, #a2#"};
				{ 4, 71463, "", "=q4=Glowing Wing Bracers", "=ds=#s8#, #a2#"};
				{ 5, 71464, "", "=q4=Gatekeeper's Embrace", "=ds=#s5#, #a3#"};
				{ 6, 71457, "", "=q4=Decimation Treads", "=ds=#s12#, #a3#"};
				{ 7, 71465, "", "=q4=Casque of Flame", "=ds=#s1#, #a4#"};
				{ 8, 71459, "", "=q4=Helm of Blazing Glory", "=ds=#s1#, #a4#"};
				{ 9, 71458, "", "=q4=Flickering Handguards", "=ds=#s9#, #a4#"};
				{ 11, 69139, "", "=q4=Necromantic Focus", "=ds=#s14#" },
				{ 12, 71462, "", "=q4=Molten Scream", "=ds=#s15#"};
				{ 16, 71676, "", "=q4=Gauntlets of the Fiery Conqueror", "=ds=#e15#, #m38# - #j4#"};
				{ 17, 71683, "", "=q4=Gauntlets of the Fiery Protector", "=ds=#e15#, #m38# - #j4#"};
				{ 18, 71669, "", "=q4=Gauntlets of the Fiery Vanquisher", "=ds=#e15#, #m38# - #j4#"};
				{ 20, 71454, "", "=q4=Gatecrasher", "=ds=#h1#, #w1#"};
				{ 21, 71460, "", "=q4=Shard of Torment", "=ds=#w8#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsStaghelm"] = {
		["Normal"] = {
			{
				{ 1, 71350, "", "=q4=Wristwraps of Arrogant Doom", "=ds=#s8#, #a1#"};
				{ 2, 71349, "", "=q4=Firecat Leggings", "=ds=#s11#, #a2#"};
				{ 3, 71313, "", "=q4=Sandals of Leaping Coals", "=ds=#s12#, #a2#"};
				{ 4, 71346, "", "=q4=Grips of Unerring Precision", "=ds=#s9#, #a3#"};
				{ 5, 71344, "", "=q4=Breastplate of Shifting Visions", "=ds=#s5#, #a4#"};
				{ 6, 70920, "", "=q4=Bracers of the Fiery Path", "=ds=#s8#, #a4#"};
				{ 7, 71351, "", "=q4=Treads of the Penitent Man", "=ds=#s12#, #a4#"};
				{ 9, 71348, "", "=q4=Flowform Choker", "=ds=#s2#"};
				{ 10, 68927, "", "=q4=The Hungerer", "=ds=#s14#" };
				{ 11, 68926, "", "=q4=Jaws of Defeat", "=ds=#s14#" },
				{ 16, 71681, "", "=q4=Mantle of the Fiery Conqueror", "=ds=#e15#, #m38#"};
				{ 17, 71688, "", "=q4=Mantle of the Fiery Protector", "=ds=#e15#, #m38#"};
				{ 18, 71674, "", "=q4=Mantle of the Fiery Vanquisher", "=ds=#e15#, #m38#"};
				{ 20, 69897, "", "=q4=Fandral's Flamescythe", "=ds=#w9#"};
				{ 21, 71347, "", "=q4=Stinger of the Flaming Scorpion", "=ds=#w12#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71471, "", "=q4=Wristwraps of Arrogant Doom", "=ds=#s8#, #a1#"};
				{ 2, 71474, "", "=q4=Firecat Leggings", "=ds=#s11#, #a2#"};
				{ 3, 71467, "", "=q4=Sandals of Leaping Coals", "=ds=#s12#, #a2#"};
				{ 4, 71468, "", "=q4=Grips of Unerring Precision", "=ds=#s9#, #a3#"};
				{ 5, 71469, "", "=q4=Breastplate of Shifting Visions", "=ds=#s5#, #a4#"};
				{ 6, 71470, "", "=q4=Bracers of the Fiery Path", "=ds=#s8#, #a4#"};
				{ 7, 71475, "", "=q4=Treads of the Penitent Man", "=ds=#s12#, #a4#"};
				{ 9, 71472, "", "=q4=Flowform Choker", "=ds=#s2#"};
				{ 10, 69112, "", "=q4=The Hungerer", "=ds=#s14#" };
				{ 11, 69111, "", "=q4=Jaws of Defeat", "=ds=#s14#" },
				{ 16, 71680, "", "=q4=Shoulders of the Fiery Conqueror", "=ds=#e15#, #m38# - #j4#"};
				{ 17, 71687, "", "=q4=Shoulders of the Fiery Protector", "=ds=#e15#, #m38# - #j4#"};
				{ 18, 71673, "", "=q4=Shoulders of the Fiery Vanquisher", "=ds=#e15#, #m38# - #j4#"};
				{ 20, 71466, "", "=q4=Fandral's Flamescythe", "=ds=#w9#"};
				{ 21, 71473, "", "=q4=Stinger of the Flaming Scorpion", "=ds=#w12#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsRagnaros"] = {
		["Normal"] = {
			{
				{ 1, 71358, "", "=q4=Fingers of Incineration", "=ds=#s9#, #a1#"};
				{ 2, 71357, "", "=q4=Majordomo's Chain of Office", "=ds=#s10#, #a1#"};
				{ 3, 71356, "", "=q4=Crown of Flame", "=ds=#s1#, #a3#"};
				{ 4, 70921, "", "=q4=Pauldrons of Roaring Flame", "=ds=#s3#, #a4#"};
				{ 6, 71354, "", "=q4=Choker of the Vanquished Lord", "=ds=#s2#"};
				{ 7, 68994, "", "=q4=Matrix Restabilizer", "=ds=#s14#" };
				{ 8, 68925, "", "=q4=Variable Pulse Lightning Capacitor", "=ds=#s14#" };
				{ 9, 68995, "", "=q4=Vessel of Acceleration", "=ds=#s14#" };
				{ 11, 69224, "", "=q4=Smoldering Egg of Millagazor", "=ds=#e27#" },
				{ 16, 71675, "", "=q4=Helm of the Fiery Conqueror", "=ds=#e15#, #m38#"};
				{ 17, 71682, "", "=q4=Helm of the Fiery Protector", "=ds=#e15#, #m38#"};
				{ 18, 71668, "", "=q4=Helm of the Fiery Vanquisher", "=ds=#e15#, #m38#"};
				{ 20, 71355, "", "=q4=Ko'gun, Hammer of the Firelord", "=ds=#h1#, #w6#"};
				{ 21, 71352, "", "=q4=Sulfuras, the Extinguished Hand", "=ds=#h2#, #w6#"};
				{ 22, 71798, "", "=q4=Sho'ravon, Greatstaff of Annihilation", "=ds=#w9#"};
				{ 23, 71353, "", "=q4=Arathar, the Eye of Flame", "=ds=#w2#"};
			};
		};
		["Heroic"] = {
			{
				{ 1, 71614, "", "=q4=Fingers of Incineration", "=ds=#s9#, #a1#"};
				{ 2, 71613, "", "=q4=Majordomo's Chain of Office", "=ds=#s10#, #a1#"};
				{ 3, 71616, "", "=q4=Crown of Flame", "=ds=#s1#, #a3#"};
				{ 4, 71612, "", "=q4=Pauldrons of Roaring Flame", "=ds=#s3#, #a4#"};
				{ 6, 71610, "", "=q4=Choker of the Vanquished Lord", "=ds=#s2#"};
				{ 7, 69150, "", "=q4=Matrix Restabilizer", "=ds=#s14#" };
				{ 8, 69110, "", "=q4=Variable Pulse Lightning Capacitor", "=ds=#s14#" };
				{ 9, 69167, "", "=q4=Vessel of Acceleration", "=ds=#s14#" };
				{ 11, 69224, "", "=q4=Smoldering Egg of Millagazor", "=ds=#e27#" },
				{ 16, 71677, "", "=q4=Crown of the Fiery Conqueror", "=ds=#e15#, #m38# - #j4#"};
				{ 17, 71684, "", "=q4=Crown of the Fiery Protector", "=ds=#e15#, #m38# - #j4#"};
				{ 18, 71670, "", "=q4=Crown of the Fiery Vanquisher", "=ds=#e15#, #m38# - #j4#"};
				{ 20, 71615, "", "=q4=Ko'gun, Hammer of the Firelord", "=ds=#h1#, #w6#"};
				{ 21, 70723, "", "=q4=Sulfuras, the Extinguished Hand", "=ds=#h2#, #w6#"};
				{ 22, 71797, "", "=q4=Sho'ravon, Greatstaff of Annihilation", "=ds=#w9#"};
				{ 23, 71611, "", "=q4=Arathar, the Eye of Flame", "=ds=#w2#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ragnaros", 198),
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsShared"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 71779, "", "=q4=Avool's Incendiary Shanker", "=ds=#h1#, #w4#"};
				{ 3, 71787, "", "=q4=Entrail Disgorger", "=ds=#h1#, #w4#"};
				{ 4, 71785, "", "=q4=Firethorn Mindslicer", "=ds=#h1#, #w10#"};
				{ 5, 71780, "", "=q4=Zoid's Firelit Greatsword", "=ds=#h2#, #w10#"};
				{ 6, 71776, "", "=q4=Eye of Purification", "=ds=#h1#, #w1#"};
				{ 7, 71782, "", "=q4=Shatterskull Bonecrusher", "=ds=#h1#, #w6#"};
				{ 8, 71775, "", "=q4=Smoldering Censer of Purity", "=ds=#w9#"};
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 71778, "", "=q4=Avool's Incendiary Shanker", "=ds=#h1#, #w4#"};
				{ 18, 71786, "", "=q4=Entrail Disgorger", "=ds=#h1#, #w4#"};
				{ 19, 71784, "", "=q4=Firethorn Mindslicer", "=ds=#h1#, #w10#"};
				{ 20, 71781, "", "=q4=Zoid's Firelit Greatsword", "=ds=#h2#, #w10#"};
				{ 21, 71777, "", "=q4=Eye of Purification", "=ds=#h1#, #w1#"};
				{ 22, 71783, "", "=q4=Shatterskull Bonecrusher", "=ds=#h1#, #w6#"};
				{ 23, 71774, "", "=q4=Smoldering Censer of Purity", "=ds=#w9#"};
			};
		};
		info = {
			name = AL["Shared Boss Loot"],
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsTrash"] = {
		["Normal"] = {
			{
				{ 1, 71640, "", "=q4=Riplimb's Lost Collar", "=ds=#s10#, #a2#"};
				{ 2, 71365, "", "=q4=Hide-Bound Chains", "=ds=#s8#, #a3#"};
				{ 4, 70929, "", "=q4=Firebound Gorget", "=ds=#s2#"};
				{ 5, 71367, "", "=q4=Theck's Emberseal", "=ds=#s13#"};
				{ 6, 68972, "", "=q4=Apparatus of Khaz'goroth", "=ds=#s14#" },
				{ 7, 68915, "", "=q4=Scales of Life", "=ds=#s14#" },
				{ 16, 71359, "", "=q4=Chelley's Sterilized Scalpel", "=ds=#h1#, #w4#"};
				{ 17, 71362, "", "=q4=Obsidium Cleaver", "=ds=#h1#, #w1#"};
				{ 18, 71361, "", "=q4=Ranseur of Hatred", "=ds=#w7#"};
				{ 19, 71360, "", "=q4=Spire of Scarlet Pain", "=ds=#w9#"};
				{ 20, 71366, "", "=q4=Lava Bolt Crossbow", "=ds=#w3#"};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsPatterns"] = {
		["Normal"] = {
			{
				{ 1, 69976, "", "=q4=Pattern: Boots of the Black Flame", "=ds=#p8# (525)"};
				{ 2, 69966, "", "=q4=Pattern: Don Tayo's Inferno Mittens", "=ds=#p8# (525)"};
				{ 3, 69975, "", "=q4=Pattern: Endless Dream Walkers", "=ds=#p8# (525)"};
				{ 4, 69965, "", "=q4=Pattern: Grips of Altered Reality", "=ds=#p8# (525)"};
				{ 6, 69962, "", "=q4=Pattern: Clutches of Evil", "=ds=#p7# (525)"};
				{ 7, 69960, "", "=q4=Pattern: Dragonfire Gloves", "=ds=#p7# (525)"};
				{ 8, 69971, "", "=q4=Pattern: Earthen Scale Sabatons", "=ds=#p7# (525)"};
				{ 9, 69974, "", "=q4=Pattern: Ethereal Footfalls", "=ds=#p7# (525)"};
				{ 10, 69972, "", "=q4=Pattern: Footwraps of Quenched Fire", "=ds=#p7# (525)"};
				{ 11, 69961, "", "=q4=Pattern: Gloves of Unforgiving Flame", "=ds=#p7# (525)"};
				{ 12, 69963, "", "=q4=Pattern: Heavenly Gloves of the Moon", "=ds=#p7# (525)"};
				{ 13, 69973, "", "=q4=Pattern: Treads of the Craft", "=ds=#p7# (525)"};
				{ 16, 69970, "", "=q4=Plans: Emberforged Elementium Boots", "=ds=#p2# (525)"};
				{ 17, 69969, "", "=q4=Plans: Mirrored Boots", "=ds=#p2# (525)"};
				{ 18, 69968, "", "=q4=Plans: Warboots of Mighty Lords", "=ds=#p2# (525)"};
				{ 19, 69958, "", "=q4=Plans: Eternal Elementium Handguards", "=ds=#p2# (525)"};
				{ 20, 69957, "", "=q4=Plans: Fists of Fury", "=ds=#p2# (525)"};
				{ 21, 69959, "", "=q4=Plans: Holy Flame Gauntlets", "=ds=#p2# (525)"};
			};
		};
		info = {
			name = ALIL["Firelands"].. " "..AL["Patterns/Plans"],
			module = moduleName, instance = "Firelands",
		};
	};

	AtlasLoot_Data["FirelandsFirestone"] = {
		["Normal"] = {
			{
				{ 1, 71641, "", "=q4=Riplimb's Lost Collar", "=ds=#s10#, #a2#"};
				{ 2, 71561, "", "=q4=Hide-Bound Chains", "=ds=#s8#, #a3#"};
				{ 4, 71563, "", "=q4=Firebound Gorget", "=ds=#s2#"};
				{ 5, 71564, "", "=q4=Theck's Emberseal", "=ds=#s13#"};
				{ 6, 69113, "", "=q4=Apparatus of Khaz'goroth", "=ds=#s14#" },
				{ 7, 69109, "", "=q4=Scales of Life", "=ds=#s14#" },
				{ 9, 71560, "", "=q4=Chelley's Sterilized Scalpel", "=ds=#h1#, #w4#"};
				{ 10, 71562, "", "=q4=Obsidium Cleaver", "=ds=#h1#, #w1#"};
				{ 11, 71557, "", "=q4=Ranseur of Hatred", "=ds=#w7#"};
				{ 12, 71559, "", "=q4=Spire of Scarlet Pain", "=ds=#w9#"};
				{ 13, 71558, "", "=q4=Lava Bolt Crossbow", "=ds=#w3#"};
				{ 16, 71579, "", "=q4=Scorchvine Wand", "=ds=#w12#"},
				{ 17, 71575, "", "=q4=Trail of Embers", "=ds=#w12#"},
				{ 19, 71617, "", "=q4=Crystallized Firestone", "=ds=#m17#"},
			};
		};
		info = {
			name = AL["Firestone Vendor"],
			module = moduleName, instance = "Firelands",
		};
	};

		-------------------------------
		--- The Bastion of Twilight ---
		-------------------------------

	AtlasLoot_Data["BoTWyrmbreaker"] = {
		["Normal"] = {
			{
				{ 1, 59482, "", "=q4=Robes of the Burning Acolyte", "=ds=#s5#, #a1#", ""};
				{ 2, 59475, "", "=q4=Bracers of the Bronze Flight", "=ds=#s8#, #a1#", ""};
				{ 3, 59469, "", "=q4=Storm Rider's Boots", "=ds=#s12#, #a2#", ""};
				{ 4, 59481, "", "=q4=Helm of the Nether Scion", "=ds=#s1#, #a3#", ""};
				{ 5, 59472, "", "=q4=Proto-Handler's Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 6, 59471, "", "=q4=Pauldrons of the Great Ettin", "=ds=#s3#, #a4#", ""};
				{ 7, 59470, "", "=q4=Bracers of Impossible Strength", "=ds=#s8#, #a4#", ""};
				{ 8, 59476, "", "=q4=Legguards of the Emerald Brood", "=ds=#s11#, #a4#", ""};
				{ 16, 59483, "", "=q4=Wyrmbreaker's Amulet", "=ds=#s2#", ""};
				{ 17, 59473, "", "=q4=Essence of the Cyclone", "=ds=#s14#", ""};
				{ 18, 59484, "", "=q4=Book of Binding Will", "=ds=#s15#", ""};
				{ 20, 59474, "", "=q4=Malevolence", "=ds=#w9#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65135, "", "=q4=Robes of the Burning Acolyte", "=ds=#s5#, #a1#", ""};
				{ 2, 65138, "", "=q4=Bracers of the Bronze Flight", "=ds=#s8#, #a1#", ""};
				{ 3, 65144, "", "=q4=Storm Rider's Boots", "=ds=#s12#, #a2#", ""};
				{ 4, 65136, "", "=q4=Helm of the Nether Scion", "=ds=#s1#, #a3#", ""};
				{ 5, 65141, "", "=q4=Proto-Handler's Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 6, 65142, "", "=q4=Pauldrons of the Great Ettin", "=ds=#s3#, #a4#", ""};
				{ 7, 65143, "", "=q4=Bracers of Impossible Strength", "=ds=#s8#, #a4#", ""};
				{ 8, 65137, "", "=q4=Legguards of the Emerald Brood", "=ds=#s11#, #a4#", ""};
				{ 10, 65134, "", "=q4=Wyrmbreaker's Amulet", "=ds=#s2#", ""};
				{ 11, 65140, "", "=q4=Essence of the Cyclone", "=ds=#s14#", ""};
				{ 12, 65133, "", "=q4=Book of Binding Will", "=ds=#s15#", ""};
				{ 16, 67423, "", "=q4=Chest of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 17, 67424, "", "=q4=Chest of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 18, 67425, "", "=q4=Chest of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 20, 65139, "", "=q4=Malevolence", "=ds=#w9#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156),
			module = moduleName, instance = "TheBastionOfTwilight",
		};
	};

	AtlasLoot_Data["BoTValionaTheralion"] = {
		["Normal"] = {
			{
				{ 1, 59516, "", "=q4=Drape of the Twins", "=ds=#s4#", ""};
				{ 2, 63534, "", "=q4=Helm of Eldritch Authority", "=ds=#s1#, #a1#", ""};
				{ 3, 63535, "", "=q4=Waistguard of Hatred", "=ds=#s10#, #a3#", ""};
				{ 4, 63531, "", "=q4=Daybreaker Helm", "=ds=#s1#, #a4#", ""};
				{ 6, 59517, "", "=q4=Necklace of Strife", "=ds=#s2#", ""};
				{ 7, 59512, "", "=q4=Valiona's Medallion", "=ds=#s2#", ""};
				{ 8, 59518, "", "=q4=Ring of Rivalry", "=ds=#s13#", ""};
				{ 9, 59519, "", "=q4=Theralion's Mirror", "=ds=#s14#", ""};
				{ 10, 59515, "", "=q4=Vial of Stolen Memories", "=ds=#s14#", ""};
				{ 16, 63533, "", "=q4=Fang of Twilight", "=ds=#h1#, #w10#", ""};
				{ 17, 63536, "", "=q4=Blade of the Witching Hour", "=ds=#h1#, #w4#", ""};
				{ 18, 63532, "", "=q4=Dragonheart Piercer", "=ds=#w3#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65108, "", "=q4=Drape of the Twins", "=ds=#s4#", ""};
				{ 2, 65093, "", "=q4=Helm of Eldritch Authority", "=ds=#s1#, #a1#", ""};
				{ 3, 65092, "", "=q4=Waistguard of Hatred", "=ds=#s10#, #a3#", ""};
				{ 4, 65096, "", "=q4=Daybreaker Helm", "=ds=#s1#, #a4#", ""};
				{ 6, 65107, "", "=q4=Necklace of Strife", "=ds=#s2#", ""};
				{ 7, 65112, "", "=q4=Valiona's Medallion", "=ds=#s2#", ""};
				{ 8, 65106, "", "=q4=Ring of Rivalry", "=ds=#s13#", ""};
				{ 9, 65105, "", "=q4=Theralion's Mirror", "=ds=#s14#", ""};
				{ 10, 65109, "", "=q4=Vial of Stolen Memories", "=ds=#s14#", ""};
				{ 16, 65094, "", "=q4=Fang of Twilight", "=ds=#h1#, #w10#", ""};
				{ 17, 65091, "", "=q4=Blade of the Witching Hour", "=ds=#h1#, #w4#", ""};
				{ 18, 65095, "", "=q4=Dragonheart Piercer", "=ds=#w3#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Valiona and Theralion", 157),
			module = moduleName, instance = "TheBastionOfTwilight",
		};
	};

	AtlasLoot_Data["BoTCouncil"] = {
		["Normal"] = {
			{
				{ 1, 59507, "", "=q4=Glittering Epidermis", "=ds=#s4#", ""};
				{ 2, 59508, "", "=q4=Treads of Liquid Ice", "=ds=#s12#, #a1#", ""};
				{ 3, 59511, "", "=q4=Hydrolance Gloves", "=ds=#s9#, #a2#", ""};
				{ 4, 59502, "", "=q4=Dispersing Belt", "=ds=#s10#, #a2#", ""};
				{ 5, 59504, "", "=q4=Arion's Crown", "=ds=#s1#, #a3#", ""};
				{ 6, 59510, "", "=q4=Feludius' Mantle", "=ds=#s3#, #a3#", ""};
				{ 7, 59509, "", "=q4=Glaciated Helm", "=ds=#s1#, #a4#", ""};
				{ 8, 59505, "", "=q4=Gravitational Pull", "=ds=#s9#, #a4#", ""};
				{ 9, 59503, "", "=q4=Terrastra's Legguards", "=ds=#s11#, #a4#", ""};
				{ 16, 59506, "", "=q4=Crushing Weight", "=ds=#s14#", ""};
				{ 17, 59514, "", "=q4=Heart of Ignacious", "=ds=#s14#", ""};
				{ 18, 59513, "", "=q4=Scepter of Ice", "=ds=#s15#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65117, "", "=q4=Glittering Epidermis", "=ds=#s4#", ""};
				{ 2, 65116, "", "=q4=Treads of Liquid Ice", "=ds=#s12#, #a1#", ""};
				{ 3, 65113, "", "=q4=Hydrolance Gloves", "=ds=#s9#, #a2#", ""};
				{ 4, 65122, "", "=q4=Dispersing Belt", "=ds=#s10#, #a2#", ""};
				{ 5, 65120, "", "=q4=Arion's Crown", "=ds=#s1#, #a3#", ""};
				{ 6, 65114, "", "=q4=Feludius' Mantle", "=ds=#s3#, #a3#", ""};
				{ 7, 65115, "", "=q4=Glaciated Helm", "=ds=#s1#, #a4#", ""};
				{ 8, 65119, "", "=q4=Gravitational Pull", "=ds=#s9#, #a4#", ""};
				{ 9, 65121, "", "=q4=Terrastra's Legguards", "=ds=#s11#, #a4#", ""};
				{ 16, 65118, "", "=q4=Crushing Weight", "=ds=#s14#", ""};
				{ 17, 65110, "", "=q4=Heart of Ignacious", "=ds=#s14#", ""};
				{ 18, 65111, "", "=q4=Scepter of Ice", "=ds=#s15#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ascendant Council", 158),
			module = moduleName, instance = "TheBastionOfTwilight",
		};
	};

	AtlasLoot_Data["BoTChogall"] = {
		["Normal"] = {
			{
				{ 1, 59498, "", "=q4=Hands of the Twilight Council", "=ds=#s9#, #a1#", ""};
				{ 2, 59490, "", "=q4=Membrane of C'Thun", "=ds=#s1#, #a2#", ""};
				{ 3, 59495, "", "=q4=Treads of Hideous Transformation", "=ds=#s12#, #a2#", ""};
				{ 4, 59485, "", "=q4=Coil of Ten-Thousand Screams", "=ds=#s10#, #a3#", ""};
				{ 5, 59499, "", "=q4=Kilt of the Forgotten Battle", "=ds=#s11#, #a3#", ""};
				{ 6, 59487, "", "=q4=Helm of Maddening Whispers", "=ds=#s1#, #a4#", ""};
				{ 7, 59486, "", "=q4=Battleplate of the Apocalypse", "=ds=#s5#, #a4#", ""};
				{ 8, 59497, "", "=q4=Shackles of the End of Days", "=ds=#s8#, #a4#", ""};
				{ 10, 59501, "", "=q4=Signet of the Fifth Circle", "=ds=#s13#", ""};
				{ 11, 59500, "", "=q4=Fall of Mortality", "=ds=#s14#", ""};
				{ 16, 64315, "", "=q4=Mantle of the Forlorn Conqueror", "=ds=#e15#, #m37#"};
				{ 17, 64316, "", "=q4=Mantle of the Forlorn Protector", "=ds=#e15#, #m37#"};
				{ 18, 64314, "", "=q4=Mantle of the Forlorn Vanquisher", "=ds=#e15#, #m37#"};
				{ 20, 59494, "", "=q4=Uhn'agh Fash, the Darkest Betrayal", "=ds=#h1#, #w4#", ""};
				{ 21, 59330, "", "=q4=Shalug'doom, the Axe of Unmaking", "=ds=#h2#, #w1#", ""};
				{ 22, 63680, "", "=q4=Twilight's Hammer", "=ds=#h1#, #w6#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65126, "", "=q4=Hands of the Twilight Council", "=ds=#s9#, #a1#", ""};
				{ 2, 65129, "", "=q4=Membrane of C'Thun", "=ds=#s1#, #a2#", ""};
				{ 3, 65128, "", "=q4=Treads of Hideous Transformation", "=ds=#s12#, #a2#", ""};
				{ 4, 65132, "", "=q4=Coil of Ten-Thousand Screams", "=ds=#s10#, #a3#", ""};
				{ 5, 65125, "", "=q4=Kilt of the Forgotten Battle", "=ds=#s11#, #a3#", ""};
				{ 6, 65130, "", "=q4=Helm of Maddening Whispers", "=ds=#s1#, #a4#", ""};
				{ 7, 65131, "", "=q4=Battleplate of the Apocalypse", "=ds=#s5#, #a4#", ""};
				{ 8, 65127, "", "=q4=Shackles of the End of Days", "=ds=#s8#, #a4#", ""};
				{ 10, 65123, "", "=q4=Signet of the Fifth Circle", "=ds=#s13#", ""};
				{ 11, 65124, "", "=q4=Fall of Mortality", "=ds=#s14#", ""};
				{ 16, 65088, "", "=q4=Shoulders of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 17, 65087, "", "=q4=Shoulders of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 18, 65089, "", "=q4=Shoulders of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 20, 68600, "", "=q4=Uhn'agh Fash, the Darkest Betrayal", "=ds=#h1#, #w4#", ""};
				{ 21, 65145, "", "=q4=Shalug'doom, the Axe of Unmaking", "=ds=#h2#, #w1#", ""};
				{ 22, 65090, "", "=q4=Twilight's Hammer", "=ds=#h1#, #w6#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Cho'gall", 167),
			module = moduleName, instance = "TheBastionOfTwilight",
		};
	};

	AtlasLoot_Data["BoTSinestra"] = {
		["Heroic"] = {
			{
				{ 1, 60232, "", "=q4=Shroud of Endless Grief", "=ds=#s4#", ""};
				{ 2, 60237, "", "=q4=Crown of the Twilight Queen", "=ds=#s1#, #a1#", ""};
				{ 3, 60238, "", "=q4=Bracers of the Dark Mother", "=ds=#s8#, #a1#", ""};
				{ 4, 60231, "", "=q4=Belt of the Fallen Brood", "=ds=#s10#, #a2#", ""};
				{ 5, 60236, "", "=q4=Nightmare Rider's Boots", "=ds=#s12#, #a2#", ""};
				{ 6, 60230, "", "=q4=Twilight Scale Leggings", "=ds=#s11#, #a3#", ""};
				{ 7, 60235, "", "=q4=Boots of Az'galada", "=ds=#s12#, #a3#", ""};
				{ 8, 60234, "", "=q4=Bindings of Bleak Betrayal", "=ds=#s8#, #a4#", ""};
				{ 9, 60228, "", "=q4=Bracers of the Mat'redor", "=ds=#s8#, #a4#", ""};
				{ 10, 60229, "", "=q4=War-Torn Crushers", "=ds=#s12#, #a4#", ""};
				{ 16, 60227, "", "=q4=Caelestrasz's Will", "=ds=#s2#", ""};
				{ 17, 60226, "", "=q4=Dargonax's Signet", "=ds=#s13#", ""};
				{ 18, 60233, "", "=q4=Shard of Woe", "=ds=#s14#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sinestra", 168),
			module = moduleName, instance = "TheBastionOfTwilight",
		};
	};

	AtlasLoot_Data["BoTTrash"] = {
		["Normal"] = {
			{
				{ 1, 60211, "", "=q4=Bracers of the Dark Pool", "=ds=#s8#, #a1#", ""};
				{ 2, 60202, "", "=q4=Tsanga's Helm", "=ds=#s1#, #a2#", ""};
				{ 3, 60201, "", "=q4=Phase-Twister Leggings", "=ds=#s11#, #a3#", ""};
				{ 4, 59901, "", "=q4=Heaving Plates of Protection", "=ds=#s3#, #a4#", ""};
				{ 6, 59520, "", "=q4=Unheeded Warning", "=ds=#s14#", ""};
				{ 16, 59521, "", "=q4=Soul Blade", "=ds=#h1#, #w10#", ""};
				{ 17, 59525, "", "=q4=Chelley's Staff of Dark Mending", "=ds=#w9#", ""};
				{ 18, 60210, "", "=q4=Crossfire Carbine", "=ds=#w5#", ""};
			};
		};
		info = {
			name = "trash",
			module = moduleName, instance = "TheBastionOfTwilight",
		};
	};

		---------------------------------
		--- Throne of the Four Winds ----
		---------------------------------

	AtlasLoot_Data["TFWConclave"] = {
		["Normal"] = {
			{
				{ 1, 63498, "", "=q4=Soul Breath Belt", "=ds=#s10#, #a1#", ""};
				{ 2, 63497, "", "=q4=Gale Rouser Belt", "=ds=#s10#, #a2#", ""};
				{ 3, 63493, "", "=q4=Wind Stalker Belt", "=ds=#s10#, #a2#", ""};
				{ 4, 63496, "", "=q4=Lightning Well Belt", "=ds=#s10#, #a3#", ""};
				{ 5, 63492, "", "=q4=Star Chaser Belt", "=ds=#s10#, #a3#", ""};
				{ 6, 63490, "", "=q4=Sky Strider Belt", "=ds=#s10#, #a4#", ""};
				{ 7, 63495, "", "=q4=Tempest Keeper Belt", "=ds=#s10#, #a4#", ""};
				{ 8, 63491, "", "=q4=Thunder Wall Belt", "=ds=#s10#, #a4#", ""};
				{ 16, 63488, "", "=q4=Mistral Circle", "=ds=#s13#", ""};
				{ 17, 63489, "", "=q4=Permafrost Signet", "=ds=#s13#", ""};
				{ 18, 63494, "", "=q4=Planetary Band", "=ds=#s13#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 65376, "", "=q4=Soul Breath Belt", "=ds=#s10#, #a1#", ""};
				{ 2, 65374, "", "=q4=Gale Rouser Belt", "=ds=#s10#, #a2#", ""};
				{ 3, 65371, "", "=q4=Wind Stalker Belt", "=ds=#s10#, #a2#", ""};
				{ 4, 65377, "", "=q4=Lightning Well Belt", "=ds=#s10#, #a3#", ""};
				{ 5, 65368, "", "=q4=Star Chaser Belt", "=ds=#s10#, #a3#", ""};
				{ 6, 65369, "", "=q4=Sky Strider Belt", "=ds=#s10#, #a4#", ""};
				{ 7, 65375, "", "=q4=Tempest Keeper Belt", "=ds=#s10#, #a4#", ""};
				{ 8, 65370, "", "=q4=Thunder Wall Belt", "=ds=#s10#, #a4#", ""};
				{ 16, 65367, "", "=q4=Mistral Circle", "=ds=#s13#", ""};
				{ 17, 65372, "", "=q4=Permafrost Signet", "=ds=#s13#", ""};
				{ 18, 65373, "", "=q4=Planetary Band", "=ds=#s13#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Conclave of Wind", 154),
			module = moduleName, instance = "ThroneOfTheFourWinds",
		};
	};

	AtlasLoot_Data["TFWAlAkir"] = {
		["Normal"] = {
			{
				{ 1, 69834, "", "=q4=Cloudburst Cloak", "=ds=#s4#", ""};
				{ 2, 69831, "", "=q4=Mistral Drape", "=ds=#s4#", ""};
				{ 3, 69833, "", "=q4=Permafrost Cape", "=ds=#s4#", ""};
				{ 4, 69835, "", "=q4=Planetary Drape", "=ds=#s4#", ""};
				{ 5, 63507, "", "=q4=Soul Breath Leggings", "=ds=#s11#, #a1#", ""};
				{ 6, 63506, "", "=q4=Gale Rouser Leggings", "=ds=#s11#, #a2#", ""};
				{ 7, 63503, "", "=q4=Wind Stalker Leggings", "=ds=#s11#, #a2#", ""};
				{ 8, 63505, "", "=q4=Lightning Well Legguards", "=ds=#s11#, #a3#", ""};
				{ 9, 63502, "", "=q4=Star Chaser Legguards", "=ds=#s11#, #a3#", ""};
				{ 10, 63500, "", "=q4=Sky Strider Greaves", "=ds=#s11#, #a4#", ""};
				{ 11, 63504, "", "=q4=Tempest Keeper Leggings", "=ds=#s11#, #a4#", ""};
				{ 12, 63501, "", "=q4=Thunder Wall Greaves", "=ds=#s11#, #a4#", ""};
				{ 14, 68127, "", "=q4=Stormwake, the Tempest's Reach", "=ds=#h1#, #w10#", ""};
				{ 15, 68128, "", "=q4=Stormwake, the Tempest's Reach", "=ds=#h1#, #w10#", ""};
				{ 16, 63683, "", "=q4=Helm of the Forlorn Conqueror", "=ds=#e15#, #m37#"};
				{ 17, 63684, "", "=q4=Helm of the Forlorn Protector", "=ds=#e15#, #m37#"};
				{ 18, 63682, "", "=q4=Helm of the Forlorn Vanquisher", "=ds=#e15#, #m37#"};
				{ 19, 64315, "", "=q4=Mantle of the Forlorn Conqueror", "=ds=#e15#, #m37#"};
				{ 20, 64316, "", "=q4=Mantle of the Forlorn Protector", "=ds=#e15#, #m37#"};
				{ 21, 64314, "", "=q4=Mantle of the Forlorn Vanquisher", "=ds=#e15#, #m37#"};
				{ 23, 69829, "", "=q4=Cloudburst Necklace", "=ds=#s2#", ""};
				{ 24, 69827, "", "=q4=Mistral Pendant", "=ds=#s2#", ""};
				{ 25, 69828, "", "=q4=Permafrost Choker", "=ds=#s2#", ""};
				{ 26, 69830, "", "=q4=Planetary Amulet", "=ds=#s2#", ""};
				{ 27, 63499, "", "=q4=Cloudburst Ring", "=ds=#s13#", ""};
				{ 29, 63041, "", "=q4=Reins of the Drake of the South Wind", "=ds=#e27#", ""};
			};
		};
		["Heroic"] = {
			{
				{ 1, 69879, "", "=q4=Cloudburst Cloak", "=ds=#s4#", ""};
				{ 2, 69884, "", "=q4=Mistral Drape", "=ds=#s4#", ""};
				{ 3, 69878, "", "=q4=Permafrost Cape", "=ds=#s4#", ""};
				{ 4, 69881, "", "=q4=Planetary Drape", "=ds=#s4#", ""};
				{ 5, 65383, "", "=q4=Soul Breath Leggings", "=ds=#s11#, #a1#", ""};
				{ 6, 65384, "", "=q4=Gale Rouser Leggings", "=ds=#s11#, #a2#", ""};
				{ 7, 65381, "", "=q4=Wind Stalker Leggings", "=ds=#s11#, #a2#", ""};
				{ 8, 65386, "", "=q4=Lightning Well Legguards", "=ds=#s11#, #a3#", ""};
				{ 9, 65378, "", "=q4=Star Chaser Legguards", "=ds=#s11#, #a3#", ""};
				{ 10, 65379, "", "=q4=Sky Strider Greaves", "=ds=#s11#, #a4#", ""};
				{ 11, 65385, "", "=q4=Tempest Keeper Leggings", "=ds=#s11#, #a4#", ""};
				{ 12, 65380, "", "=q4=Thunder Wall Greaves", "=ds=#s11#, #a4#", ""};
				{ 14, 68132, "", "=q4=Stormwake, the Tempest's Reach", "=ds=#h1#, #w10#", ""};
				{ 15, 68131, "", "=q4=Stormwake, the Tempest's Reach", "=ds=#h1#, #w10#", ""};
				{ 16, 66998, "", "=q4=Essence of the Forlorn", "=ds=#e15#, #m37#"};
				{ 17, 65001, "", "=q4=Crown of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 18, 65000, "", "=q4=Crown of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 19, 65002, "", "=q4=Crown of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 20, 65088, "", "=q4=Shoulders of the Forlorn Conqueror", "=ds=#e15#, #m37# - #j4#"};
				{ 21, 65087, "", "=q4=Shoulders of the Forlorn Protector", "=ds=#e15#, #m37# - #j4#"};
				{ 22, 65089, "", "=q4=Shoulders of the Forlorn Vanquisher", "=ds=#e15#, #m37# - #j4#"};
				{ 24, 69885, "", "=q4=Cloudburst Necklace", "=ds=#s2#", ""};
				{ 25, 69880, "", "=q4=Mistral Pendant", "=ds=#s2#", ""};
				{ 26, 69883, "", "=q4=Permafrost Choker", "=ds=#s2#", ""};
				{ 27, 69882, "", "=q4=Planetary Amulet", "=ds=#s2#", ""};
				{ 28, 65382, "", "=q4=Cloudburst Ring", "=ds=#s13#", ""};
				{ 30, 63041, "", "=q4=Reins of the Drake of the South Wind", "=ds=#e27#", ""};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Al'Akir", 155),
			module = moduleName, instance = "ThroneOfTheFourWinds",
		};
	};

	----------------
	--- Factions ---
	----------------

		-------------------------
		--- Avengers of Hyjal ---
		-------------------------

	AtlasLoot_Data["AvengersHyjal"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_neck_hyjaldaily_04", "=q6=#r2#", ""};
				{ 2, 70930, "", "=q4=Durable Flamewrath Greatcloak", "=ds=#s4#"};
				{ 3, 71229, "", "=q4=Flowing Flamewrath Cape", "=ds=#s4#"};
				{ 4, 71228, "", "=q4=Nimble Flamewrath Cloak", "=ds=#s4#"};
				{ 5, 71230, "", "=q4=Rippling Flamewrath Drape", "=ds=#s4#"};
				{ 6, 71227, "", "=q4=Spiked Flamewrath Cloak", "=ds=#s4#"};
				{ 16, 0, "inv_neck_hyjaldaily_04", "=q6=#r3#", ""};
				{ 17, 71258, "", "=q4=Embereye Belt", "=ds=#s10#, #a1#"};
				{ 18, 71249, "", "=q4=Firescar Sash", "=ds=#s10#, #a2#"};
				{ 19, 71131, "", "=q4=Flamebinding Girdle", "=ds=#s10#, #a2#"};
				{ 20, 71255, "", "=q4=Firearrow Belt", "=ds=#s10#, #a3#"};
				{ 21, 71254, "", "=q4=Firemend Cinch", "=ds=#s10#, #a3#"};
				{ 22, 71250, "", "=q4=Cinch of the Flaming Ember", "=ds=#s10#, #a4#"};
				{ 23, 70933, "", "=q4=Girdle of the Indomitable Flame", "=ds=#s10#, #a4#"};
				{ 24, 71253, "", "=q4=Belt of the Seven Seals", "=ds=#s10#, #a4#"};
			};
			{
				{ 1, 0, "inv_neck_hyjaldaily_04", "=q6=#r4#", ""};
				{ 2, 69001, "", "=q4=Ancient Petrified Seed", "=ds=#s14#"};
				{ 3, 69002, "", "=q4=Essence of the Eternal Flame", "=ds=#s14#" },
				{ 4, 69000, "", "=q4=Fiery Quintessence", "=ds=#s14#"};
				{ 5, 68998, "", "=q4=Rune of Zeth", "=ds=#s14#"};
				{ 6, 68996, "", "=q4=Stay of Execution", "=ds=#s14#"};
				{ 16, 0, "inv_neck_hyjaldaily_04", "=q6=#r5#", ""};
				{ 17, 70934, "", "=q4=Adamantine Signet of the Avengers", "=ds=#s13#"};
				{ 18, 71217, "", "=q4=Infernal Signet of the Avengers", "=ds=#s13#"};
				{ 19, 71215, "", "=q4=Obsidian Signet of the Avengers", "=ds=#s13#"};
				{ 20, 71237, "", "=q4=Quicksilver Signet of the Avengers", "=ds=#s13#"};
				{ 21, 71216, "", "=q4=Viridian Signet of the Avengers", "=ds=#s13#"};
			};
		};
		info = {
			name = ALIL["Avengers of Hyjal"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		-------------------------
		--- Baradin's Wardens ---
		-------------------------

	AtlasLoot_Data["BaradinsWardens"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_baradinwardens", "=q6=#r1#", ""};
				{ 2, 68774, "", "=q4=Greater Inscription of Vicious Agility", "=ds=#s3# #e17#", "#TOLBARAD:80#"};
				{ 3, 68772, "", "=q4=Greater Inscription of Vicious Intellect", "=ds=#s3# #e17#", "#TOLBARAD:80#"};
				{ 4, 68773, "", "=q4=Greater Inscription of Vicious Strength", "=ds=#s3# #e17#", "#TOLBARAD:80#"};
				{ 6, 0, "inv_misc_tabard_baradinwardens", "=q6=#r2#", ""};
				{ 7, 63517, "", "=q2=Baradin's Wardens Commendation", "=ds=", "#TOLBARAD:10#"};
				{ 8, 63391, "", "=q1=Baradin's Wardens Bandage", "=ds=#e5#", "#TOLBARAD:5#"};
				{ 9, 63144, "", "=q1=Baradin's Wardens Healing Potion", "=ds=#e2#", "#TOLBARAD:2#"};
				{ 10, 63145, "", "=q1=Baradin's Wardens Mana Potion", "=ds=#e2#", "#TOLBARAD:2#"};
				{ 16, 0, "inv_misc_tabard_baradinwardens", "=q6=#r3#", ""};
				{ 17, 63379, "", "=q3=Baradin's Wardens Tabard", "=ds=#s7#", "#TOLBARAD:40#"};
				{ 18, 65175, "", "=q3=Baradin Footman's Tags", "=ds=#s14#", "#TOLBARAD:40#"};
				{ 19, 63355, "", "=q3=Rustberg Gull", "=ds=#e13#", "#TOLBARAD:50#"};
				{ 20, 63141, "", "=q3=Tol Barad Searchlight", "=ds=", "#TOLBARAD:40#"};
			};
			{
				{ 1, 0, "inv_misc_tabard_baradinwardens", "=q6=#r4#", ""};
				{ 2, 62475, "", "=q3=Dagger of Restless Nights", "=ds=#h1#, #w4#", "#TOLBARAD:85#"};
				{ 3, 62473, "", "=q3=Blade of the Fearless", "=ds=#h2#, #w10#", "#TOLBARAD:85#"};
				{ 4, 62476, "", "=q3=Ravening Slicer", "=ds=#h1#, #w1#", "#TOLBARAD:85#"};
				{ 5, 68739, "", "=q3=Darkheart Hacker", "=ds=#h1#, #w1#", "#TOLBARAD:85#"};
				{ 6, 62478, "", "=q3=Shimmering Morningstar", "=ds=#h1#, #w6#", "#TOLBARAD:85#"};
				{ 7, 62474, "", "=q3=Spear of Trailing Shadows", "=ds=#w7#", "#TOLBARAD:85#"};
				{ 8, 62477, "", "=q3=Insidious Staff", "=ds=#w9#", "#TOLBARAD:85#"};
				{ 9, 62479, "", "=q3=Sky Piercer", "=ds=#w3#", "#TOLBARAD:85#"};
				{ 10, 63377, "", "=q3=Baradin's Wardens Battle Standard", "=ds=#e14#", "#TOLBARAD:50#"};
				{ 16, 0, "inv_misc_tabard_baradinwardens", "=q6=#r5#", ""};
				{ 17, 62469, "", "=q4=Impatience of Youth", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 18, 62472, "", "=q4=Mandala of Stirring Patterns", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 19, 62471, "", "=q4=Mirror of Broken Images", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 20, 62470, "", "=q4=Stump of Time", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 21, 62468, "", "=q4=Unsolvable Riddle", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 22, 64998, "", "=q4=Reins of the Spectral Steed", "=ds=#e12#", "#TOLBARAD:165#"};
				{ 23, 63039, "", "=q4=Reins of the Drake of the West Wind", "=ds=#e27#", "#TOLBARAD:200#"};
				{ 24, 90897, "", "=q3=Fox Kit", "=ds=#e13#", "#TOLBARAD:200#"};
			};
		};
		info = {
			name = ALIL["Baradin's Wardens"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		----------------------
		--- Dragonmaw Clan ---
		----------------------

	AtlasLoot_Data["DragonmawClan"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_dragonmawclan", "=q6=#r2#", ""};
				{ 2, 65909, "", "=q1=Tabard of the Dragonmaw Clan", "=ds=#s7#"};
				{ 4, 0, "inv_misc_tabard_dragonmawclan", "=q6=#r3#", ""};
				{ 5, 62406, "", "=q3=Bone Fever Gloves", "=ds=#s9#, #a1#"};
				{ 6, 62404, "", "=q3=Spaulders of the Endless Plains", "=ds=#s3#, #a2#"};
				{ 7, 62405, "", "=q3=Leggings of the Impenitent", "=ds=#s11#, #a2#"};
				{ 8, 62407, "", "=q3=Helm of the Brown Lands", "=ds=#s1#, #a3#"};
				{ 10, 0, "inv_misc_tabard_dragonmawclan", "=q6=#r4#", ""};
				{ 11, 62409, "", "=q3=Snarling Helm", "=ds=#s1#, #a3#"};	
				{ 12, 62410, "", "=q3=Grinning Fang Helm", "=ds=#s1#, #a4#"};
				{ 13, 62408, "", "=q3=Gauntlets of Rattling Bones", "=ds=#s9#, #a4#"};
				{ 14, 62415, "", "=q3=Band of Lamentation", "=ds=#s13#"};
				{ 16, 0, "inv_misc_tabard_dragonmawclan", "=q6=#r5#", ""};
				{ 17, 62417, "", "=q4=Liar's Handwraps", "=ds=#s9#, #a2#"};
				{ 18, 62420, "", "=q4=Withered Dream Belt", "=ds=#s10#, #a2#"};
				{ 19, 62418, "", "=q4=Boots of Sullen Rock", "=ds=#s12#, #a4#"};
				{ 20, 62416, "", "=q4=Yellow Smoke Pendant", "=ds=#s2#"};
			};
		};
		info = {
			name = ALIL["Dragonmaw Clan"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		--------------------------
		--- Hellscream's Reach ---
		--------------------------

	AtlasLoot_Data["HellscreamsReach"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_hellscream", "=q6=#r1#", ""};
				{ 2, 68774, "", "=q4=Greater Inscription of Vicious Agility", "=ds=#s3# #e17#", "#TOLBARAD:80#"};
				{ 3, 68772, "", "=q4=Greater Inscription of Vicious Intellect", "=ds=#s3# #e17#", "#TOLBARAD:80#"};
				{ 4, 68773, "", "=q4=Greater Inscription of Vicious Strength", "=ds=#s3# #e17#", "#TOLBARAD:80#"};
				{ 6, 0, "inv_misc_tabard_hellscream", "=q6=#r2#", ""};
				{ 7, 63518, "", "=q2=Hellscream's Reach Commendation", "=ds=", "#TOLBARAD:10#"};
				{ 8, 64995, "", "=q1=Hellscream's Reach Bandage", "=ds=#e5#", "#TOLBARAD:5#"};
				{ 9, 64994, "", "=q1=Hellscream's Reach Healing Potion", "=ds=#e2#", "#TOLBARAD:2#"};
				{ 10, 64993, "", "=q1=Hellscream's Reach Mana Potion", "=ds=#e2#", "#TOLBARAD:2#"};
				{ 16, 0, "inv_misc_tabard_hellscream", "=q6=#r3#", ""};
				{ 17, 63378, "", "=q3=Hellscream's Reach Tabard", "=ds=#s7#", "#TOLBARAD:40#"};
				{ 18, 65176, "", "=q3=Baradin Grunt's Talisman", "=ds=#s14#", "#TOLBARAD:40#"};
				{ 19, 64996, "", "=q3=Rustberg Gull", "=ds=#e13#", "#TOLBARAD:50#"};
				{ 20, 64997, "", "=q3=Tol Barad Searchlight", "=ds=", "#TOLBARAD:40#"};
			};
			{
				{ 1, 0, "inv_misc_tabard_hellscream", "=q6=#r4#", ""};
				{ 2, 62456, "", "=q3=Dagger of Restless Nights", "=ds=#h1#, #w4#", "#TOLBARAD:85#"};
				{ 3, 62454, "", "=q3=Blade of the Fearless", "=ds=#h2#, #w10#", "#TOLBARAD:85#"};
				{ 4, 62457, "", "=q3=Ravening Slicer", "=ds=#h1#, #w1#", "#TOLBARAD:85#"};
				{ 5, 68740, "", "=q3=Darkheart Hacker", "=ds=#h1#, #w1#", "#TOLBARAD:85#"};
				{ 6, 62459, "", "=q3=Shimmering Morningstar", "=ds=#h1#, #w6#", "#TOLBARAD:85#"};
				{ 7, 62455, "", "=q3=Spear of Trailing Shadows", "=ds=#w7#", "#TOLBARAD:85#"};
				{ 8, 62458, "", "=q3=Insidious Staff", "=ds=#w9#", "#TOLBARAD:85#"};
				{ 9, 62460, "", "=q3=Sky Piercer", "=ds=#w3#", "#TOLBARAD:85#"};
				{ 10, 63376, "", "=q3=Hellscream's Reach Battle Standard", "=ds=#e14#", "#TOLBARAD:50#"};
				{ 16, 0, "inv_misc_tabard_hellscream", "=q6=#r5#", ""};
				{ 17, 62464, "", "=q4=Impatience of Youth", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 18, 62467, "", "=q4=Mandala of Stirring Patterns", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 19, 62466, "", "=q4=Mirror of Broken Images", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 20, 62465, "", "=q4=Stump of Time", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 21, 62463, "", "=q4=Unsolvable Riddle", "=ds=#s14#", "#TOLBARAD:125#"};
				{ 22, 64999, "", "=q4=Reins of the Spectral Wolf", "=ds=#e12#", "#TOLBARAD:165#"};
				{ 23, 65356, "", "=q4=Reins of the Drake of the West Wind", "=ds=#e27#", "#TOLBARAD:200#"};
				{ 24, 90898, "", "=q3=Fox Kit", "=ds=#e13#", "#TOLBARAD:200#"};
			};
		};
		info = {
			name = ALIL["Hellscream's Reach"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		----------------
		--- Ramkahen ---
		----------------

	AtlasLoot_Data["Ramkahen"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_tolvir", "=q6=#r2#", ""};
				{ 2, 65904, "", "=q1=Tabard of Ramkahen", "=ds=#s7#"};
				{ 4, 0, "inv_misc_tabard_tolvir", "=q6=#r3#", ""};
				{ 5, 62437, "", "=q3=Shroud of the Dead", "=ds=#s4#", ""};
				{ 6, 62439, "", "=q3=Belt of the Stargazer", "=ds=#s10#, #a3#", ""};
				{ 7, 62438, "", "=q3=Drystone Greaves", "=ds=#s12#, #a4#", ""};
				{ 8, 62436, "", "=q3=Ammunae's Blessing", "=ds=#s13#", ""};
				{ 10, 0, "inv_misc_tabard_tolvir", "=q6=#r4#", ""};
				{ 11, 62441, "", "=q3=Robes of Orsis", "=ds=#s5#, #a1#", ""};
				{ 12, 62446, "", "=q3=Quicksand Belt", "=ds=#s10#, #a2#", ""};
				{ 13, 62445, "", "=q3=Sash of Prophecy", "=ds=#s10#, #a3#", ""};
				{ 14, 62440, "", "=q3=Red Rock Band", "=ds=#s13#", ""};
				{ 16, 0, "inv_misc_tabard_tolvir", "=q6=#r5#", ""};
				{ 17, 62450, "", "=q4=Desert Walker Sandals", "=ds=#s12#, #a1#", ""};
				{ 18, 62449, "", "=q4=Sandguard Bracers", "=ds=#s8#, #a4#", ""};
				{ 19, 62448, "", "=q4=Sun King's Girdle", "=ds=#s10#, #a4#", ""};
				{ 20, 62447, "", "=q4=Gift of Nadun", "=ds=#s2#", ""};
				{ 21, 63044, "", "=q4=Reins of the Brown Riding Camel", "=ds=#e26#", ""};
				{ 22, 63045, "", "=q4=Reins of the Tan Riding Camel", "=ds=#e26#", ""};
			};
		};
		info = {
			name = ALIL["Ramkahen"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		------------------------
		--- The Earthen Ring ---
		------------------------

	AtlasLoot_Data["EarthenRing"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_earthenring", "=q6=#r2#", ""};
				{ 2, 65905, "", "=q1=Tabard of the Earthen Ring", "=ds=#s7#"};
				{ 4, 0, "inv_misc_tabard_earthenring", "=q6=#r3#", ""};
				{ 5, 62356, "", "=q3=Helm of Temperance", "=ds=#s1#, #a1#", ""};
				{ 6, 62353, "", "=q3=Mantle of Moss", "=ds=#s3#, #a3#", ""};
				{ 7, 62355, "", "=q3=Stone-Wrapped Greaves", "=ds=#s11#, #a4#", ""};
				{ 8, 62354, "", "=q3=Pendant of Elemental Balance", "=ds=#s2#", ""};
				{ 10, 0, "inv_misc_tabard_earthenring", "=q6=#r4#", ""};
				{ 11, 62357, "", "=q3=Cloak of Ancient Wisdom", "=ds=#s4#", ""};
				{ 12, 62361, "", "=q3=Softwind Cape", "=ds=#s4#", ""};
				{ 13, 62358, "", "=q3=Leggings of Clutching Roots", "=ds=#s11#, #a2#", ""};
				{ 14, 62359, "", "=q3=Peacemaker's Breastplate", "=ds=#s5#, #a4#", ""};
				{ 16, 0, "inv_misc_tabard_earthenring", "=q6=#r5#", ""};
				{ 17, 62364, "", "=q4=Flamebloom Gloves", "=ds=#s9#, #a1#", ""};
				{ 18, 62363, "", "=q4=Earthmender's Boots", "=ds=#s12#, #a3#", ""};
				{ 19, 62365, "", "=q4=World Keeper's Gauntlets", "=ds=#s9#, #a4#", ""};
				{ 20, 62362, "", "=q4=Signet of the Elder Council", "=ds=#s13#", ""};
			};
		};
		info = {
			name = ALIL["The Earthen Ring"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		------------------------------
		--- The Guardians of Hyjal ---
		------------------------------

	AtlasLoot_Data["GuardiansHyjal"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_guardiansofhyjal", "=q6=#r2#", ""};
				{ 2, 65906, "", "=q1=Tabard of the Guardians of Hyjal", "=ds=#s7#"};
				{ 4, 0, "inv_misc_tabard_guardiansofhyjal", "=q6=#r3#", ""};
				{ 5, 62377, "", "=q3=Cloak of the Dryads", "=ds=#s4#"};
				{ 6, 62374, "", "=q3=Sly Fox Jerkin", "=ds=#s5#, #a2#"};
				{ 7, 62376, "", "=q3=Mountain's Mouth", "=ds=#s2#"};
				{ 8, 62375, "", "=q3=Galrond's Band", "=ds=#s13#"};
				{ 10, 0, "inv_misc_tabard_guardiansofhyjal", "=q6=#r4#", ""};
				{ 11, 62381, "", "=q3=Aessina-Blessed Gloves", "=ds=#s9#, #a2#"};
				{ 12, 62380, "", "=q3=Wilderness Legguards", "=ds=#s11#, #a3#"};
				{ 13, 62382, "", "=q3=Waywatcher's Boots", "=ds=#s12#, #a4#"};
				{ 14, 62378, "", "=q3=Acorn of the Daughter Tree", "=ds=#s2#"};
				{ 16, 0, "inv_misc_tabard_guardiansofhyjal", "=q6=#r5#", ""};
				{ 17, 62383, "", "=q4=Wrap of the Great Turtle", "=ds=#s4#"};
				{ 18, 62386, "", "=q4=Cord of the Raven Queen", "=ds=#s10#, #a1#"};
				{ 19, 62385, "", "=q4=Treads of Malorne", "=ds=#s12#, #a3#"};
				{ 20, 62384, "", "=q4=Belt of the Ferocious Wolf", "=ds=#s10#, #a4#"};
			};
		};
		info = {
			name = ALIL["Guardians of Hyjal"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		-----------------
		--- Therazane ---
		-----------------

	AtlasLoot_Data["Therazane"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_therazane", "=q6=#r2#", ""};
				{ 2, 65907, "", "=q1=Tabard of Therazane", "=ds=#s7#"};
				{ 4, 0, "inv_misc_tabard_therazane", "=q6=#r3#", ""};
				{ 5, 62342, "", "=q3=Lesser Inscription of Charged Lodestone", "=ds=#s3# #e17#"};
				{ 6, 62344, "", "=q3=Lesser Inscription of Jagged Stone", "=ds=#s3# #e17#"};
				{ 7, 62347, "", "=q3=Lesser Inscription of Shattered Crystal", "=ds=#s3# #e17#"};
				{ 8, 62321, "", "=q3=Lesser Inscription of Unbreakable Quartz", "=ds=#s3# #e17#"};
				{ 10, 0, "inv_misc_tabard_therazane", "=q6=#r4#", ""};
				{ 11, 62352, "", "=q3=Diamant's Ring of Temperance", "=ds=#s13#", ""};
				{ 12, 62351, "", "=q3=Felsen's Ring of Resolve", "=ds=#s13#", ""};
				{ 13, 62350, "", "=q3=Gorsik's Band of Shattering", "=ds=#s13#", ""};
				{ 14, 62348, "", "=q3=Terrath's Signet of Balance", "=ds=#s13#", ""};
				{ 16, 0, "inv_misc_tabard_therazane", "=q6=#r5#", ""};
				{ 17, 62343, "", "=q4=Greater Inscription of Charged Lodestone", "=ds=#s3# #e17#"};
				{ 18, 62345, "", "=q4=Greater Inscription of Jagged Stone", "=ds=#s3# #e17#"};
				{ 19, 62346, "", "=q4=Greater Inscription of Shattered Crystal", "=ds=#s3# #e17#"};
				{ 20, 62333, "", "=q4=Greater Inscription of Unbreakable Quartz", "=ds=#s3# #e17#"};
			};
		};
		info = {
			name = ALIL["Therazane"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

		-----------------------
		--- Wildhammer Clan ---
		-----------------------

	AtlasLoot_Data["WildhammerClan"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_wildhammerclan", "=q6=#r2#", ""};
				{ 2, 65908, "", "=q1=Tabard of the Wildhammer Clan", "=ds=#s7#"};
				{ 4, 0, "inv_misc_tabard_wildhammerclan", "=q6=#r3#", ""};
				{ 5, 62424, "", "=q3=Gloves of Aetherial Rumors", "=ds=#s9#, #a1#"};
				{ 6, 62426, "", "=q3=Mantle of Wild Feathers", "=ds=#s3#, #a2#"};
				{ 7, 62425, "", "=q3=Swiftflight Leggings", "=ds=#s11#, #a2#"};
				{ 8, 62423, "", "=q3=Helm of the Skyborne", "=ds=#s1#, #a3#"};
				{ 10, 0, "inv_misc_tabard_wildhammerclan", "=q6=#r4#", ""};
				{ 11, 62429, "", "=q3=Windhome Helm", "=ds=#s1#, #a3#"};	
				{ 12, 62428, "", "=q3=Crown of Wings", "=ds=#s1#, #a4#"};
				{ 13, 62430, "", "=q3=Gryphon Talon Gauntlets", "=ds=#s9#, #a4#"};
				{ 14, 62427, "", "=q3=Band of Singing Grass", "=ds=#s13#"};
				{ 16, 0, "inv_misc_tabard_wildhammerclan", "=q6=#r5#", ""};
				{ 17, 62433, "", "=q4=Stormbolt Gloves", "=ds=#s9#, #a2#"};
				{ 18, 62431, "", "=q4=Belt of the Untamed", "=ds=#s10#, #a2#"};
				{ 19, 62432, "", "=q4=Gryphon Rider's Boots", "=ds=#s12#, #a4#"};
				{ 20, 62434, "", "=q4=Lightning Flash Pendant", "=ds=#s2#"};
			};
		};
		info = {
			name = ALIL["Wildhammer Clan"],
			module = moduleName, menu = "REPMENU_CATACLYSM",
		};
	}

	-----------
	--- PvP ---
	-----------

		----------------------
		--- PvP Armor Sets ---
		----------------------

	AtlasLoot_Data["PVP85DeathKnight"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73618, "", "=q4=Cataclysmic Gladiator's Dreadplate Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73616, "", "=q4=Cataclysmic Gladiator's Dreadplate Shoulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73620, "", "=q4=Cataclysmic Gladiator's Dreadplate Chestpiece", "=ds=", "#HONOR:2200#"};
				{ 5, 73619, "", "=q4=Cataclysmic Gladiator's Dreadplate Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73617, "", "=q4=Cataclysmic Gladiator's Dreadplate Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70246, "", "=q4=Ruthless Gladiator's Dreadplate Helm", "=ds="};
				{ 10, 70248, "", "=q4=Ruthless Gladiator's Dreadplate Shoulders", "=ds="};
				{ 11, 70244, "", "=q4=Ruthless Gladiator's Dreadplate Chestpiece", "=ds="};
				{ 12, 70245, "", "=q4=Ruthless Gladiator's Dreadplate Gauntlets", "=ds="};
				{ 13, 70247, "", "=q4=Ruthless Gladiator's Dreadplate Legguards", "=ds="};
				{ 16, 0, "spell_deathknight_classicon", "=q6=#arenas10#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60410, "", "=q4=Vicious Gladiator's Dreadplate Helm", "=ds="};
				{ 18, 60412, "", "=q4=Vicious Gladiator's Dreadplate Shoulders", "=ds="};
				{ 19, 60408, "", "=q4=Vicious Gladiator's Dreadplate Chestpiece", "=ds="};
				{ 20, 60409, "", "=q4=Vicious Gladiator's Dreadplate Gauntlets", "=ds="};
				{ 21, 60411, "", "=q4=Vicious Gladiator's Dreadplate Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85DruidBalance"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73598, "", "=q4=Cataclysmic Gladiator's Wyrmhide Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73595, "", "=q4=Cataclysmic Gladiator's Wyrmhide Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73596, "", "=q4=Cataclysmic Gladiator's Wyrmhide Robes", "=ds=", "#HONOR:2200#"};
				{ 5, 73599, "", "=q4=Cataclysmic Gladiator's Wyrmhide Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73597, "", "=q4=Cataclysmic Gladiator's Wyrmhide Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70290, "", "=q4=Ruthless Gladiator's Wyrmhide Helm", "=ds="};
				{ 10, 70293, "", "=q4=Ruthless Gladiator's Wyrmhide Spaulders", "=ds="};
				{ 11, 70292, "", "=q4=Ruthless Gladiator's Wyrmhide Robes", "=ds="};
				{ 12, 70289, "", "=q4=Ruthless Gladiator's Wyrmhide Gloves", "=ds="};
				{ 13, 70291, "", "=q4=Ruthless Gladiator's Wyrmhide Legguards", "=ds="};
				{ 16, 0, "spell_nature_starfall", "=q6=#arenas1_2#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60454, "", "=q4=Vicious Gladiator's Wyrmhide Helm", "=ds="};
				{ 18, 60457, "", "=q4=Vicious Gladiator's Wyrmhide Spaulders", "=ds="};
				{ 19, 60456, "", "=q4=Vicious Gladiator's Wyrmhide Robes", "=ds="};
				{ 20, 60453, "", "=q4=Vicious Gladiator's Wyrmhide Gloves", "=ds="};
				{ 21, 60455, "", "=q4=Vicious Gladiator's Wyrmhide Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85DruidFeral"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73614, "", "=q4=Cataclysmic Gladiator's Dragonhide Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73611, "", "=q4=Cataclysmic Gladiator's Dragonhide Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73612, "", "=q4=Cataclysmic Gladiator's Dragonhide Robes", "=ds=", "#HONOR:2200#"};
				{ 5, 73615, "", "=q4=Cataclysmic Gladiator's Dragonhide Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73613, "", "=q4=Cataclysmic Gladiator's Dragonhide Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70280, "", "=q4=Ruthless Gladiator's Dragonhide Helm", "=ds="};
				{ 10, 70283, "", "=q4=Ruthless Gladiator's Dragonhide Spaulders", "=ds="};
				{ 11, 70282, "", "=q4=Ruthless Gladiator's Dragonhide Robes", "=ds="};
				{ 12, 70279, "", "=q4=Ruthless Gladiator's Dragonhide Gloves", "=ds="};
				{ 13, 70281, "", "=q4=Ruthless Gladiator's Dragonhide Legguards", "=ds="};
				{ 16, 0, "ability_druid_catform", "=q6=#arenas1_1#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60444, "", "=q4=Vicious Gladiator's Dragonhide Helm", "=ds="};
				{ 18, 60447, "", "=q4=Vicious Gladiator's Dragonhide Spaulders", "=ds="};
				{ 19, 60446, "", "=q4=Vicious Gladiator's Dragonhide Robes", "=ds="};
				{ 20, 60443, "", "=q4=Vicious Gladiator's Dragonhide Gloves", "=ds="};
				{ 21, 60445, "", "=q4=Vicious Gladiator's Dragonhide Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85DruidRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73606, "", "=q4=Cataclysmic Gladiator's Kodohide Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73603, "", "=q4=Cataclysmic Gladiator's Kodohide Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73604, "", "=q4=Cataclysmic Gladiator's Kodohide Robes", "=ds=", "#HONOR:2200#"};
				{ 5, 73607, "", "=q4=Cataclysmic Gladiator's Kodohide Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73605, "", "=q4=Cataclysmic Gladiator's Kodohide Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70285, "", "=q4=Ruthless Gladiator's Kodohide Helm", "=ds="};
				{ 10, 70288, "", "=q4=Ruthless Gladiator's Kodohide Spaulders", "=ds="};
				{ 11, 70287, "", "=q4=Ruthless Gladiator's Kodohide Robes", "=ds="};
				{ 12, 70284, "", "=q4=Ruthless Gladiator's Kodohide Gloves", "=ds="};
				{ 13, 70286, "", "=q4=Ruthless Gladiator's Kodohide Legguards", "=ds="};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#arenas1_3#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60449, "", "=q4=Vicious Gladiator's Kodohide Helm", "=ds="};
				{ 18, 60452, "", "=q4=Vicious Gladiator's Kodohide Spaulders", "=ds="};
				{ 19, 60451, "", "=q4=Vicious Gladiator's Kodohide Robes", "=ds="};
				{ 20, 60448, "", "=q4=Vicious Gladiator's Kodohide Gloves", "=ds="};
				{ 21, 60450, "", "=q4=Vicious Gladiator's Kodohide Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73582, "", "=q4=Cataclysmic Gladiator's Chain Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73580, "", "=q4=Cataclysmic Gladiator's Chain Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73584, "", "=q4=Cataclysmic Gladiator's Chain Armor", "=ds=", "#HONOR:2200#"};
				{ 5, 73583, "", "=q4=Cataclysmic Gladiator's Chain Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73581, "", "=q4=Cataclysmic Gladiator's Chain Leggings", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70261, "", "=q4=Ruthless Gladiator's Chain Helm", "=ds="};
				{ 10, 70263, "", "=q4=Ruthless Gladiator's Chain Spaulders", "=ds="};
				{ 11, 70259, "", "=q4=Ruthless Gladiator's Chain Armor", "=ds="};
				{ 12, 70260, "", "=q4=Ruthless Gladiator's Chain Gauntlets", "=ds="};
				{ 13, 70262, "", "=q4=Ruthless Gladiator's Chain Leggings", "=ds="};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#arenas2#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60425, "", "=q4=Vicious Gladiator's Chain Helm", "=ds="};
				{ 18, 60427, "", "=q4=Vicious Gladiator's Chain Spaulders", "=ds="};
				{ 19, 60423, "", "=q4=Vicious Gladiator's Chain Armor", "=ds="};
				{ 20, 60424, "", "=q4=Vicious Gladiator's Chain Gauntlets", "=ds="};
				{ 21, 60426, "", "=q4=Vicious Gladiator's Chain Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73575, "", "=q4=Cataclysmic Gladiator's Silk Cowl", "=ds=", "#HONOR:2200#"};
				{ 3, 73572, "", "=q4=Cataclysmic Gladiator's Silk Amice", "=ds=", "#HONOR:1650#"};
				{ 4, 73573, "", "=q4=Cataclysmic Gladiator's Silk Robe", "=ds=", "#HONOR:2200#"};
				{ 5, 73576, "", "=q4=Cataclysmic Gladiator's Silk Handguards", "=ds=", "#HONOR:1650#"};
				{ 6, 73574, "", "=q4=Cataclysmic Gladiator's Silk Trousers", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70300, "", "=q4=Ruthless Gladiator's Silk Cowl", "=ds="};
				{ 10, 70303, "", "=q4=Ruthless Gladiator's Silk Amice", "=ds="};
				{ 11, 70302, "", "=q4=Ruthless Gladiator's Silk Robe", "=ds="};
				{ 12, 70299, "", "=q4=Ruthless Gladiator's Silk Handguards", "=ds="};
				{ 13, 70301, "", "=q4=Ruthless Gladiator's Silk Trousers", "=ds="};
				{ 16, 0, "inv_staff_13", "=q6=#arenas3#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60464, "", "=q4=Vicious Gladiator's Silk Cowl", "=ds="};
				{ 18, 60467, "", "=q4=Vicious Gladiator's Silk Amice", "=ds="};
				{ 19, 60466, "", "=q4=Vicious Gladiator's Silk Robe", "=ds="};
				{ 20, 60463, "", "=q4=Vicious Gladiator's Silk Handguards", "=ds="};
				{ 21, 60465, "", "=q4=Vicious Gladiator's Silk Trousers", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85PaladinRetribution"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73569, "", "=q4=Cataclysmic Gladiator's Scaled Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73567, "", "=q4=Cataclysmic Gladiator's Scaled Shoulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73571, "", "=q4=Cataclysmic Gladiator's Scaled Chestpiece", "=ds=", "#HONOR:2200#"};
				{ 5, 73570, "", "=q4=Cataclysmic Gladiator's Scaled Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73568, "", "=q4=Cataclysmic Gladiator's Scaled Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70251, "", "=q4=Ruthless Gladiator's Scaled Helm", "=ds="};
				{ 10, 70253, "", "=q4=Ruthless Gladiator's Scaled Shoulders", "=ds="};
				{ 11, 70249, "", "=q4=Ruthless Gladiator's Scaled Chestpiece", "=ds="};
				{ 12, 70250, "", "=q4=Ruthless Gladiator's Scaled Gauntlets", "=ds="};
				{ 13, 70252, "", "=q4=Ruthless Gladiator's Scaled Legguards", "=ds="};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#arenas4_2#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60415, "", "=q4=Vicious Gladiator's Scaled Helm", "=ds="};
				{ 18, 60417, "", "=q4=Vicious Gladiator's Scaled Shoulders", "=ds="};
				{ 19, 60413, "", "=q4=Vicious Gladiator's Scaled Chestpiece", "=ds="};
				{ 20, 60414, "", "=q4=Vicious Gladiator's Scaled Gauntlets", "=ds="};
				{ 21, 60416, "", "=q4=Vicious Gladiator's Scaled Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85PaladinHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73558, "", "=q4=Cataclysmic Gladiator's Ornamented Headcover", "=ds=", "#HONOR:2200#"};
				{ 3, 73556, "", "=q4=Cataclysmic Gladiator's Ornamented Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73560, "", "=q4=Cataclysmic Gladiator's Ornamented Chestguard", "=ds=", "#HONOR:2200#"};
				{ 5, 73559, "", "=q4=Cataclysmic Gladiator's Ornamented Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73557, "", "=q4=Cataclysmic Gladiator's Ornamented Legplates", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70355, "", "=q4=Ruthless Gladiator's Ornamented Headcover", "=ds="};
				{ 10, 70357, "", "=q4=Ruthless Gladiator's Ornamented Spaulders", "=ds="};
				{ 11, 70353, "", "=q4=Ruthless Gladiator's Ornamented Chestguard", "=ds="};
				{ 12, 70354, "", "=q4=Ruthless Gladiator's Ornamented Gloves", "=ds="};
				{ 13, 70356, "", "=q4=Ruthless Gladiator's Ornamented Legplates", "=ds="};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#arenas4_3#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60603, "", "=q4=Vicious Gladiator's Ornamented Headcover", "=ds="};
				{ 18, 60605, "", "=q4=Vicious Gladiator's Ornamented Spaulders", "=ds="};
				{ 19, 60601, "", "=q4=Vicious Gladiator's Ornamented Chestguard", "=ds="};
				{ 20, 60602, "", "=q4=Vicious Gladiator's Ornamented Gloves", "=ds="};
				{ 21, 60604, "", "=q4=Vicious Gladiator's Ornamented Legplates", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85PriestShadow"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73543, "", "=q4=Cataclysmic Gladiator's Satin Hood", "=ds=", "#HONOR:2200#"};
				{ 3, 73540, "", "=q4=Cataclysmic Gladiator's Satin Mantle", "=ds=", "#HONOR:1650#"};
				{ 4, 73541, "", "=q4=Cataclysmic Gladiator's Satin Robe", "=ds=", "#HONOR:2200#"};
				{ 5, 73544, "", "=q4=Cataclysmic Gladiator's Satin Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73542, "", "=q4=Cataclysmic Gladiator's Satin Leggings", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70310, "", "=q4=Ruthless Gladiator's Satin Hood", "=ds="};
				{ 10, 70313, "", "=q4=Ruthless Gladiator's Satin Mantle", "=ds="};
				{ 11, 70312, "", "=q4=Ruthless Gladiator's Satin Robe", "=ds="};
				{ 12, 70309, "", "=q4=Ruthless Gladiator's Satin Gloves", "=ds="};
				{ 13, 70311, "", "=q4=Ruthless Gladiator's Satin Leggings", "=ds="};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#arenas5_1#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60474, "", "=q4=Vicious Gladiator's Satin Hood", "=ds="};
				{ 18, 60477, "", "=q4=Vicious Gladiator's Satin Mantle", "=ds="};
				{ 19, 60473, "", "=q4=Vicious Gladiator's Satin Robe", "=ds="};
				{ 20, 60476, "", "=q4=Vicious Gladiator's Satin Gloves", "=ds="};
				{ 21, 60475, "", "=q4=Vicious Gladiator's Satin Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85PriestHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73548, "", "=q4=Cataclysmic Gladiator's Mooncloth Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73545, "", "=q4=Cataclysmic Gladiator's Mooncloth Mantle", "=ds=", "#HONOR:1650#"};
				{ 4, 73546, "", "=q4=Cataclysmic Gladiator's Mooncloth Robe", "=ds=", "#HONOR:2200#"};
				{ 5, 73549, "", "=q4=Cataclysmic Gladiator's Mooncloth Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73547, "", "=q4=Cataclysmic Gladiator's Mooncloth Leggings", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70305, "", "=q4=Ruthless Gladiator's Mooncloth Helm", "=ds="};
				{ 10, 70308, "", "=q4=Ruthless Gladiator's Mooncloth Mantle", "=ds="};
				{ 11, 70307, "", "=q4=Ruthless Gladiator's Mooncloth Robe", "=ds="};
				{ 12, 70304, "", "=q4=Ruthless Gladiator's Mooncloth Gloves", "=ds="};
				{ 13, 70306, "", "=q4=Ruthless Gladiator's Mooncloth Leggings", "=ds="};
				{ 16, 0, "spell_holy_powerwordshield", "=q6=#arenas5_2#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60469, "", "=q4=Vicious Gladiator's Mooncloth Helm", "=ds="};
				{ 18, 60472, "", "=q4=Vicious Gladiator's Mooncloth Mantle", "=ds="};
				{ 19, 60471, "", "=q4=Vicious Gladiator's Mooncloth Robe", "=ds="};
				{ 20, 60468, "", "=q4=Vicious Gladiator's Mooncloth Gloves", "=ds="};
				{ 21, 60470, "", "=q4=Vicious Gladiator's Mooncloth Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73525, "", "=q4=Cataclysmic Gladiator's Leather Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73523, "", "=q4=Cataclysmic Gladiator's Leather Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73527, "", "=q4=Cataclysmic Gladiator's Leather Tunic", "=ds=", "#HONOR:2200#"};
				{ 5, 73526, "", "=q4=Cataclysmic Gladiator's Leather Gloves", "=ds=", "#HONOR:1650#"};
				{ 6, 73524, "", "=q4=Cataclysmic Gladiator's Leather Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70296, "", "=q4=Ruthless Gladiator's Leather Helm", "=ds="};
				{ 10, 70298, "", "=q4=Ruthless Gladiator's Leather Spaulders", "=ds="};
				{ 11, 70294, "", "=q4=Ruthless Gladiator's Leather Tunic", "=ds="};
				{ 12, 70295, "", "=q4=Ruthless Gladiator's Leather Gloves", "=ds="};
				{ 13, 70297, "", "=q4=Ruthless Gladiator's Leather Legguards", "=ds="};
				{ 16, 0, "inv_throwingknife_04", "=q6=#arenas6#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60460, "", "=q4=Vicious Gladiator's Leather Helm", "=ds="};
				{ 18, 60462, "", "=q4=Vicious Gladiator's Leather Spaulders", "=ds="};
				{ 19, 60458, "", "=q4=Vicious Gladiator's Leather Tunic", "=ds="};
				{ 20, 60459, "", "=q4=Vicious Gladiator's Leather Gloves", "=ds="};
				{ 21, 60461, "", "=q4=Vicious Gladiator's Leather Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85ShamanElemental"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73504, "", "=q4=Cataclysmic Gladiator's Mail Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73502, "", "=q4=Cataclysmic Gladiator's Mail Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73506, "", "=q4=Cataclysmic Gladiator's Mail Armor", "=ds=", "#HONOR:2200#"};
				{ 5, 73505, "", "=q4=Cataclysmic Gladiator's Mail Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73503, "", "=q4=Cataclysmic Gladiator's Mail Leggings", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70276, "", "=q4=Ruthless Gladiator's Mail Helm", "=ds="};
				{ 10, 70278, "", "=q4=Ruthless Gladiator's Mail Spaulders", "=ds="};
				{ 11, 70274, "", "=q4=Ruthless Gladiator's Mail Armor", "=ds="};
				{ 12, 70275, "", "=q4=Ruthless Gladiator's Mail Gauntlets", "=ds="};
				{ 13, 70277, "", "=q4=Ruthless Gladiator's Mail Leggings", "=ds="};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#arenas7_2#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60440, "", "=q4=Vicious Gladiator's Mail Helm", "=ds="};
				{ 18, 60442, "", "=q4=Vicious Gladiator's Mail Spaulders", "=ds="};
				{ 19, 60438, "", "=q4=Vicious Gladiator's Mail Armor", "=ds="};
				{ 20, 60439, "", "=q4=Vicious Gladiator's Mail Gauntlets", "=ds="};
				{ 21, 60441, "", "=q4=Vicious Gladiator's Mail Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85ShamanEnhancement"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73510, "", "=q4=Cataclysmic Gladiator's Linked Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73508, "", "=q4=Cataclysmic Gladiator's Linked Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73512, "", "=q4=Cataclysmic Gladiator's Linked Armor", "=ds=", "#HONOR:2200#"};
				{ 5, 73511, "", "=q4=Cataclysmic Gladiator's Linked Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73509, "", "=q4=Cataclysmic Gladiator's Linked Leggings", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70271, "", "=q4=Ruthless Gladiator's Linked Helm", "=ds="};
				{ 10, 70273, "", "=q4=Ruthless Gladiator's Linked Spaulders", "=ds="};
				{ 11, 70269, "", "=q4=Ruthless Gladiator's Linked Armor", "=ds="};
				{ 12, 70270, "", "=q4=Ruthless Gladiator's Linked Gauntlets", "=ds="};
				{ 13, 70272, "", "=q4=Ruthless Gladiator's Linked Leggings", "=ds="};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#arenas7_1#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60435, "", "=q4=Vicious Gladiator's Linked Helm", "=ds="};
				{ 18, 60437, "", "=q4=Vicious Gladiator's Linked Spaulders", "=ds="};
				{ 19, 60433, "", "=q4=Vicious Gladiator's Linked Armor", "=ds="};
				{ 20, 60434, "", "=q4=Vicious Gladiator's Linked Gauntlets", "=ds="};
				{ 21, 60436, "", "=q4=Vicious Gladiator's Linked Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85ShamanRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73515, "", "=q4=Cataclysmic Gladiator's Ringmail Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73513, "", "=q4=Cataclysmic Gladiator's Ringmail Spaulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73517, "", "=q4=Cataclysmic Gladiator's Ringmail Armor", "=ds=", "#HONOR:2200#"};
				{ 5, 73516, "", "=q4=Cataclysmic Gladiator's Ringmail Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73514, "", "=q4=Cataclysmic Gladiator's Ringmail Leggings", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70266, "", "=q4=Ruthless Gladiator's Ringmail Helm", "=ds="};
				{ 10, 70268, "", "=q4=Ruthless Gladiator's Ringmail Spaulders", "=ds="};
				{ 11, 70264, "", "=q4=Ruthless Gladiator's Ringmail Armor", "=ds="};
				{ 12, 70265, "", "=q4=Ruthless Gladiator's Ringmail Gauntlets", "=ds="};
				{ 13, 70267, "", "=q4=Ruthless Gladiator's Ringmail Leggings", "=ds="};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#arenas7_3#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60430, "", "=q4=Vicious Gladiator's Ringmail Helm", "=ds="};
				{ 18, 60432, "", "=q4=Vicious Gladiator's Ringmail Spaulders", "=ds="};
				{ 19, 60428, "", "=q4=Vicious Gladiator's Ringmail Armor", "=ds="};
				{ 20, 60429, "", "=q4=Vicious Gladiator's Ringmail Gauntlets", "=ds="};
				{ 21, 60431, "", "=q4=Vicious Gladiator's Ringmail Leggings", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73486, "", "=q4=Cataclysmic Gladiator's Felweave Cowl", "=ds=", "#HONOR:2200#"};
				{ 3, 73483, "", "=q4=Cataclysmic Gladiator's Felweave Amice", "=ds=", "#HONOR:1650#"};
				{ 4, 73484, "", "=q4=Cataclysmic Gladiator's Felweave Raiment", "=ds=", "#HONOR:2200#"};
				{ 5, 73487, "", "=q4=Cataclysmic Gladiator's Felweave Handguards", "=ds=", "#HONOR:1650#"};
				{ 6, 73485, "", "=q4=Cataclysmic Gladiator's Felweave Trousers", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70315, "", "=q4=Ruthless Gladiator's Felweave Cowl", "=ds="};
				{ 10, 70318, "", "=q4=Ruthless Gladiator's Felweave Amice", "=ds="};
				{ 11, 70317, "", "=q4=Ruthless Gladiator's Felweave Raiment", "=ds="};
				{ 12, 70314, "", "=q4=Ruthless Gladiator's Felweave Handguards", "=ds="};
				{ 13, 70316, "", "=q4=Ruthless Gladiator's Felweave Trousers", "=ds="};
				{ 16, 0, "spell_nature_drowsy", "=q6=#arenas8_2#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60479, "", "=q4=Vicious Gladiator's Felweave Cowl", "=ds="};
				{ 18, 60482, "", "=q4=Vicious Gladiator's Felweave Amice", "=ds="};
				{ 19, 60481, "", "=q4=Vicious Gladiator's Felweave Raiment", "=ds="};
				{ 20, 60478, "", "=q4=Vicious Gladiator's Felweave Handguards", "=ds="};
				{ 21, 60480, "", "=q4=Vicious Gladiator's Felweave Trousers", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "PVP85SET",
		};
	}

	AtlasLoot_Data["PVP85Warrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="..string.format(AL["Season %d"], 11)..", "..AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339)};
				{ 2, 73480, "", "=q4=Cataclysmic Gladiator's Plate Helm", "=ds=", "#HONOR:2200#"};
				{ 3, 73478, "", "=q4=Cataclysmic Gladiator's Plate Shoulders", "=ds=", "#HONOR:1650#"};
				{ 4, 73482, "", "=q4=Cataclysmic Gladiator's Plate Chestpiece", "=ds=", "#HONOR:2200#"};
				{ 5, 73481, "", "=q4=Cataclysmic Gladiator's Plate Gauntlets", "=ds=", "#HONOR:1650#"};
				{ 6, 73479, "", "=q4=Cataclysmic Gladiator's Plate Legguards", "=ds=", "#HONOR:2200#"};
				{ 8, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="..string.format(AL["Season %d"], 10)..", "..AtlasLoot:EJ_GetBossName("Occu'thar", 140)};
				{ 9, 70256, "", "=q4=Ruthless Gladiator's Plate Helm", "=ds="};
				{ 10, 70258, "", "=q4=Ruthless Gladiator's Plate Shoulders", "=ds="};
				{ 11, 70254, "", "=q4=Ruthless Gladiator's Plate Chestpiece", "=ds="};
				{ 12, 70255, "", "=q4=Ruthless Gladiator's Plate Gauntlets", "=ds="};
				{ 13, 70257, "", "=q4=Ruthless Gladiator's Plate Legguards", "=ds="};
				{ 16, 0, "ability_warrior_savageblow", "=q6=#arenas9#", "=q5="..string.format(AL["Season %d"], 9)..", "..AtlasLoot:EJ_GetBossName("Argaloth", 139)};
				{ 17, 60420, "", "=q4=Vicious Gladiator's Plate Helm", "=ds="};
				{ 18, 60422, "", "=q4=Vicious Gladiator's Plate Shoulders", "=ds="};
				{ 19, 60418, "", "=q4=Vicious Gladiator's Plate Chestpiece", "=ds="};
				{ 20, 60419, "", "=q4=Vicious Gladiator's Plate Gauntlets", "=ds="};
				{ 21, 60421, "", "=q4=Vicious Gladiator's Plate Legguards", "=ds="};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "PVP85SET",
		};
	}

		------------------------------
		--- Level 85 - Accessories ---
		------------------------------

	AtlasLoot_Data["PVP85Accessories"] = {
		["Normal"] = {
			{
				{ 1, 73647, "", "=q4=Cataclysmic Gladiator's Cape of Cruelty", "=ds=#s4#", "#HONOR:1250#" },
				{ 2, 73646, "", "=q4=Cataclysmic Gladiator's Cape of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 3, 73495, "", "=q4=Cataclysmic Gladiator's Cloak of Alacrity", "=ds=#s4#", "#HONOR:1250#" },
				{ 4, 73494, "", "=q4=Cataclysmic Gladiator's Cloak of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 5, 73629, "", "=q4=Cataclysmic Gladiator's Drape of Diffusion", "=ds=#s4#", "#HONOR:1250#" },
				{ 6, 73628, "", "=q4=Cataclysmic Gladiator's Drape of Meditation", "=ds=#s4#", "#HONOR:1250#" },
				{ 7, 73630, "", "=q4=Cataclysmic Gladiator's Drape of Prowess", "=ds=#s4#", "#HONOR:1250#" },
				{ 9, 73622, "", "=q4=Cataclysmic Gladiator's Band of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 10, 73623, "", "=q4=Cataclysmic Gladiator's Band of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 11, 73621, "", "=q4=Cataclysmic Gladiator's Band of Dominance", "=ds=#s13#", "#HONOR:1250#"};
				{ 12, 73488, "", "=q4=Cataclysmic Gladiator's Signet of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 13, 73489, "", "=q4=Cataclysmic Gladiator's Signet of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 14, 73640, "", "=q4=Cataclysmic Gladiator's Ring of Accuracy", "=ds=#s13#", "#HONOR:1250#"};
				{ 15, 73641, "", "=q4=Cataclysmic Gladiator's Ring of Cruelty", "=ds=#s13#", "#HONOR:1250#"};
				{ 16, 73492, "", "=q4=Cataclysmic Gladiator's Choker of Accuracy", "=ds=#s2#", "#HONOR:1250#" },
				{ 17, 73493, "", "=q4=Cataclysmic Gladiator's Choker of Proficiency", "=ds=#s2#", "#HONOR:1250#" },
				{ 18, 73645, "", "=q4=Cataclysmic Gladiator's Necklace of Proficiency", "=ds=#s2#", "#HONOR:1250#" },
				{ 19, 73644, "", "=q4=Cataclysmic Gladiator's Necklace of Prowess", "=ds=#s2#", "#HONOR:1250#" },
				{ 20, 73627, "", "=q4=Cataclysmic Gladiator's Pendant of Alacrity", "=ds=#s2#", "#HONOR:1250#" },
				{ 21, 73626, "", "=q4=Cataclysmic Gladiator's Pendant of Diffusion", "=ds=#s2#", "#HONOR:1250#" },
				{ 22, 73625, "", "=q4=Cataclysmic Gladiator's Pendant of Meditation", "=ds=#s2#", "#HONOR:1250#" },
			};
			{
				{ 2, 73648, "", "=q4=Cataclysmic Gladiator's Badge of Conquest", "=ds=#s14#", "#HONOR:1650#" },
				{ 3, 73498, "", "=q4=Cataclysmic Gladiator's Badge of Dominance", "=ds=#s14#", "#HONOR:1650#" },
				{ 4, 73496, "", "=q4=Cataclysmic Gladiator's Badge of Victory", "=ds=#s14#", "#HONOR:1650#" },
				{ 6, 73593, "", "=q4=Cataclysmic Gladiator's Emblem of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
				{ 7, 73591, "", "=q4=Cataclysmic Gladiator's Emblem of Meditation", "=ds=#s14#", "#HONOR:1650#" },
				{ 8, 73592, "", "=q4=Cataclysmic Gladiator's Emblem of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
				{
					{ 17, 73538, "", "=q4=Cataclysmic Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
					{ 17, 73539, "", "=q4=Cataclysmic Gladiator's Medallion of Cruelty", "=ds=#s14#", "#HONOR:1650#" },
				};
				{
					{ 18, 73534, "", "=q4=Cataclysmic Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1650#" },
					{ 18, 73535, "", "=q4=Cataclysmic Gladiator's Medallion of Meditation", "=ds=#s14#", "#HONOR:1650#" },
				};
				{
					{ 19, 73537, "", "=q4=Cataclysmic Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
					{ 19, 73536, "", "=q4=Cataclysmic Gladiator's Medallion of Tenacity", "=ds=#s14#", "#HONOR:1650#" },
				};
				{ 21, 73643, "", "=q4=Cataclysmic Gladiator's Insignia of Conquest", "=ds=#s14#", "#HONOR:1650#" },
				{ 22, 73497, "", "=q4=Cataclysmic Gladiator's Insignia of Dominance", "=ds=#s14#", "#HONOR:1650#" },
				{ 23, 73491, "", "=q4=Cataclysmic Gladiator's Insignia of Victory", "=ds=#s14#", "#HONOR:1650#" },
			};
		};
		info = {
			name = AL["PvP Accessories"],
			module = moduleName, menu = "PVPMENU3",
		};
	}

		--------------------------------
		--- Level 85 - Non Set Epics ---
		--------------------------------

	AtlasLoot_Data["PVP85NonSet"] = {
		["Normal"] = {
			{
				{ 1, 73633, "", "=q4=Cataclysmic Gladiator's Cuffs of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 2, 73638, "", "=q4=Cataclysmic Gladiator's Cord of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 3, 73635, "", "=q4=Cataclysmic Gladiator's Treads of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 5, 73631, "", "=q4=Cataclysmic Gladiator's Cuffs of Meditation", "=ds=", "#HONOR:1250#"};
				{ 6, 73637, "", "=q4=Cataclysmic Gladiator's Cord of Meditation", "=ds=", "#HONOR:1650#"};
				{ 7, 73634, "", "=q4=Cataclysmic Gladiator's Treads of Meditation", "=ds=", "#HONOR:1650#"};
				{ 9, 73632, "", "=q4=Cataclysmic Gladiator's Cuffs of Prowess", "=ds=", "#HONOR:1250#"};
				{ 10, 73639, "", "=q4=Cataclysmic Gladiator's Cord of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 11, 73636, "", "=q4=Cataclysmic Gladiator's Treads of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 16, 73528, "", "=q4=Cataclysmic Gladiator's Armwraps of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 17, 73532, "", "=q4=Cataclysmic Gladiator's Waistband of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 18, 73531, "", "=q4=Cataclysmic Gladiator's Boots of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 20, 73529, "", "=q4=Cataclysmic Gladiator's Armwraps of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 21, 73533, "", "=q4=Cataclysmic Gladiator's Waistband of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 22, 73530, "", "=q4=Cataclysmic Gladiator's Boots of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 24, 73600, "", "=q4=Cataclysmic Gladiator's Bindings of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 73602, "", "=q4=Cataclysmic Gladiator's Belt of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 26, 73601, "", "=q4=Cataclysmic Gladiator's Footguards of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 28, 73608, "", "=q4=Cataclysmic Gladiator's Bindings of Meditation", "=ds=", "#HONOR:1250#"};
				{ 29, 73610, "", "=q4=Cataclysmic Gladiator's Belt of Meditation", "=ds=", "#HONOR:1650#"};
				{ 30, 73609, "", "=q4=Cataclysmic Gladiator's Footguards of Meditation", "=ds=", "#HONOR:1650#"};
				extraText = ": "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"];
			};
			{
				{ 1, 73518, "", "=q4=Cataclysmic Gladiator's Armbands of Meditation", "=ds=", "#HONOR:1250#"};
				{ 2, 73522, "", "=q4=Cataclysmic Gladiator's Waistguard of Meditation", "=ds=", "#HONOR:1650#"};
				{ 3, 73520, "", "=q4=Cataclysmic Gladiator's Sabatons of Meditation", "=ds=", "#HONOR:1650#"};
				{ 5, 73519, "", "=q4=Cataclysmic Gladiator's Armbands of Prowess", "=ds=", "#HONOR:1250#"};
				{ 6, 73507, "", "=q4=Cataclysmic Gladiator's Waistguard of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 7, 73677, "", "=q4=Cataclysmic Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 9, 73586, "", "=q4=Cataclysmic Gladiator's Wristguards of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 10, 73590, "", "=q4=Cataclysmic Gladiator's Links of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 11, 73587, "", "=q4=Cataclysmic Gladiator's Sabatons of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 13, 73585, "", "=q4=Cataclysmic Gladiator's Wristguards of Accuracy", "=ds=", "#HONOR:1250#"};
				{ 14, 73589, "", "=q4=Cataclysmic Gladiator's Links of Accuracy", "=ds=", "#HONOR:1650#"};
				{ 15, 73588, "", "=q4=Cataclysmic Gladiator's Sabatons of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 16, 73561, "", "=q4=Cataclysmic Gladiator's Bracers of Meditation", "=ds=", "#HONOR:1250#"};
				{ 17, 73565, "", "=q4=Cataclysmic Gladiator's Clasp of Meditation", "=ds=", "#HONOR:1650#"};
				{ 18, 73563, "", "=q4=Cataclysmic Gladiator's Greaves of Meditation", "=ds=", "#HONOR:1650#"};
				{ 20, 73551, "", "=q4=Cataclysmic Gladiator's Armplates of Proficiency", "=ds=", "#HONOR:1250#"};
				{ 21, 73554, "", "=q4=Cataclysmic Gladiator's Girdle of Prowess", "=ds=", "#HONOR:1650#"};
				{ 22, 73552, "", "=q4=Cataclysmic Gladiator's Warboots of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 24, 73562, "", "=q4=Cataclysmic Gladiator's Bracers of Prowess", "=ds=", "#HONOR:1250#"};
				{ 25, 73566, "", "=q4=Cataclysmic Gladiator's Clasp of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 26, 73564, "", "=q4=Cataclysmic Gladiator's Greaves of Alacrity", "=ds=", "#HONOR:1650#"};
				{ 28, 73550, "", "=q4=Cataclysmic Gladiator's Armplates of Alacrity", "=ds=", "#HONOR:1250#"};
				{ 29, 73555, "", "=q4=Cataclysmic Gladiator's Girdle of Cruelty", "=ds=", "#HONOR:1650#"};
				{ 30, 73553, "", "=q4=Cataclysmic Gladiator's Warboots of Cruelty", "=ds=", "#HONOR:1650#"};
				extraText = ": "..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]
			};
		};
		info = {
			name = AL["PvP Non-Set Epics"],
			module = moduleName, menu = "PVPMENU3",
		};
	}

		--------------------------
		--- Level 85 - Weapons ---
		--------------------------

	AtlasLoot_Data["PVP85Weapons4"] = {
		["Normal"] = {
			{
				{ 1, 73452, "", "=q4=Cataclysmic Gladiator's Right Render", "=ds=#h1#, #w13#", "#HONOR:2450#" },
				{ 2, 73454, "", "=q4=Cataclysmic Gladiator's Ripper", "=ds=#h1#, #w13#", "#HONOR:2450#" },
				{ 3, 73451, "", "=q4=Cataclysmic Gladiator's Slasher", "=ds=#h1#, #w13#", "#HONOR:950#" },
				{ 4, 73453, "", "=q4=Cataclysmic Gladiator's Fleshslicer", "=ds=#h1#, #w13#", "#HONOR:950#" },
				{ 6, 73467, "", "=q4=Cataclysmic Gladiator's Spellblade", "=ds=#h1#, #w4#", "#HONOR:2450#" },
				{ 7, 73455, "", "=q4=Cataclysmic Gladiator's Shanker", "=ds=#h1#, #w4#", "#HONOR:2450#" },
				{ 8, 73461, "", "=q4=Cataclysmic Gladiator's Shiv", "=ds=#h4#, #w4#", "#HONOR:950#" },
				{ 10, 73472, "", "=q4=Cataclysmic Gladiator's Quickblade", "=ds=#h1#, #w10#", "#HONOR:2450#" },
				{ 11, 73447, "", "=q4=Cataclysmic Gladiator's Slicer", "=ds=#h1#, #w10#", "#HONOR:2450#" },
				{ 13, 73474, "", "=q4=Cataclysmic Gladiator's Cleaver", "=ds=#h1#, #w1#", "#HONOR:2450#" },
				{ 14, 73449, "", "=q4=Cataclysmic Gladiator's Hacker", "=ds=#h1#, #w1#", "#HONOR:2450#" },
				{ 16, 73459, "", "=q4=Cataclysmic Gladiator's Gavel", "=ds=#h1#, #w6#", "#HONOR:2450#" },
				{ 17, 73448, "", "=q4=Cataclysmic Gladiator's Bonecracker", "=ds=#h1#, #w6#", "#HONOR:2450#" },
				{ 18, 73473, "", "=q4=Cataclysmic Gladiator's Pummeler", "=ds=#h1#, #w6#", "#HONOR:2450#" },
				{ 20, 73475, "", "=q4=Cataclysmic Gladiator's Greatsword", "=ds=#h2#, #w10#", "#HONOR:3400#" },
				{ 21, 73477, "", "=q4=Cataclysmic Gladiator's Decapitator", "=ds=#h2#, #w1#", "#HONOR:3400#" },
				{ 22, 73476, "", "=q4=Cataclysmic Gladiator's Bonegrinder", "=ds=#h2#, #w6#", "#HONOR:3400#" },
				{ 24, 73456, "", "=q4=Cataclysmic Gladiator's Pike", "=ds=#w7#", "#HONOR:3400#" },
				{ 26, 73466, "", "=q4=Cataclysmic Gladiator's Battle Staff", "=ds=#w9#", "#HONOR:3400#" },
				{ 27, 73457, "", "=q4=Cataclysmic Gladiator's Energy Staff", "=ds=#w9#", "#HONOR:3400#" },
				{ 28, 73462, "", "=q4=Cataclysmic Gladiator's Staff", "=ds=#w9#", "#HONOR:3400#" },
			};
			{
				{ 1, 73468, "", "=q4=Cataclysmic Gladiator's Barrier", "=ds=#w8#", "#HONOR:950#" },
				{ 2, 73458, "", "=q4=Cataclysmic Gladiator's Redoubt", "=ds=#w8#", "#HONOR:950#" },
				{ 3, 73446, "", "=q4=Cataclysmic Gladiator's Shield Wall", "=ds=#w8#", "#HONOR:950#" },
				{ 5, 73470, "", "=q4=Cataclysmic Gladiator's Longbow", "=ds=#w2#", "#HONOR:3400#" },
				{ 6, 73463, "", "=q4=Cataclysmic Gladiator's Heavy Crossbow", "=ds=#w3#", "#HONOR:3400#" },
				{ 7, 73460, "", "=q4=Cataclysmic Gladiator's Rifle", "=ds=#w5#", "#HONOR:3400#" },
				{ 16, 73450, "", "=q4=Cataclysmic Gladiator's Baton of Light", "=ds=#w12#", "#HONOR:700#" },
				{ 17, 73464, "", "=q4=Cataclysmic Gladiator's Touch of Defeat", "=ds=#w12#", "#HONOR:700#" },
				{ 19, 73465, "", "=q4=Cataclysmic Gladiator's Reprieve", "=ds=#s15#", "#HONOR:950#" },
				{ 20, 73469, "", "=q4=Cataclysmic Gladiator's Endgame", "=ds=#s15#", "#HONOR:950#" }
			};
		};
		info = {
			name = AL["PvP Weapons"].." "..AL["Level 85"].." - "..AL["Cataclysmic"],
			module = moduleName, menu = "PVPMENU3",
		};
	}

		-----------------------
		--- Level 85 - Misc ---
		-----------------------

	AtlasLoot_Data["PVP85Misc"] = {
		["Normal"] = {
			{
				{ 1, 68774, "", "=q4=Greater Inscription of Vicious Agility", "=ds=#s3# #e17#", "#HONOR:2000#" },
				{ 2, 68772, "", "=q4=Greater Inscription of Vicious Intellect", "=ds=#s3# #e17#", "#HONOR:2000#" },
				{ 3, 68773, "", "=q4=Greater Inscription of Vicious Strength", "=ds=#s3# #e17#", "#HONOR:2000#" },
				{ 5, 52722, "", "=q4=Maelstrom Crystal", "", "#HONOR:3750#" },
				{ 6, 68813, "", "=q3=Satchel of Freshly-Picked Herbs", "", "#HONOR:1500#" },
				{ 7, 53010, "", "=q1=Embersilk Cloth", "", "#HONOR:1250#" },
				{ 8, 52185, "", "=q1=Elementium Ore", "", "#HONOR:1000#" },
				{ 9, 52721, "", "=q3=Heavenly Shard", "", "#HONOR:600#" },
				{ 10, 52719, "", "=q2=Greater Celestial Essence", "", "#HONOR:400#" },
				{ 11, 52976, "", "=q1=Savage Leather", "", "#HONOR:375#" },
				{ 12, 52555, "", "=q1=Hypnotic Dust", "", "#HONOR:100#" },
				{ 16, 77140, "", "=q4=Stormy Deepholm Iolite", "=ds=#e7#", "#HONOR:750#" },
				{ 17, 77130, "", "=q4=Balanced Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 18, 77131, "", "=q4=Infused Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 19, 77154, "", "=q4=Radiant Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 20, 77137, "", "=q4=Shattered Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 21, 77139, "", "=q4=Steady Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 22, 77142, "", "=q4=Turbid Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 23, 77143, "", "=q4=Vivid Elven Peridot", "=ds=#e7#", "#HONOR:750#" },
				{ 24, 77132, "", "=q4=Lucent Lava Coral", "=ds=#e7#", "#HONOR:750#" },
				{ 25, 77136, "", "=q4=Resplendent Lava Coral", "=ds=#e7#", "#HONOR:750#" },
				{ 26, 77138, "", "=q4=Splendid Lava Coral", "=ds=#e7#", "#HONOR:750#" },
				{ 27, 77141, "", "=q4=Tenuous Lava Coral", "=ds=#e7#", "#HONOR:750#" },
				{ 28, 77144, "", "=q4=Willful Lava Coral", "=ds=#e7#", "#HONOR:750#" },
				{ 29, 77133, "", "=q4=Mysterious Shadow Spinel", "=ds=#e7#", "#HONOR:750#" },
				{ 30, 77134, "", "=q4=Mystic Lightstone", "=ds=#e7#", "#HONOR:750#" },
			};
		};
		info = {
			name = AL["Misc"], "=q5="..AL["Level 85"],
			module = moduleName, menu = "PVPMENU3",
		};
	}

	--------------------------
	--- Sets & Collections ---
	--------------------------

		--------------------------------
		--- Tier 11/12 Sets (T11/12) ---
		--------------------------------

	AtlasLoot_Data["T1112DeathKnightDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6=#t11s10_1#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60341, "", "=q4=Magma Plated Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60343, "", "=q4=Magma Plated Pauldrons", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60339, "", "=q4=Magma Plated Battleplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60340, "", "=q4=Magma Plated Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60342, "", "=q4=Magma Plated Legplates", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_deathknight_frostpresence", "=q6=#t11s10_1#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65181, "", "=q4=Magma Plated Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65183, "", "=q4=Magma Plated Pauldrons", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65179, "", "=q4=Magma Plated Battleplate", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65180, "", "=q4=Magma Plated Gauntlets", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65182, "", "=q4=Magma Plated Legplates", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_deathknight_frostpresence", "=q6=#t12s10_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71060, "", "=q4=Elementium Deathplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71062, "", "=q4=Elementium Deathplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71058, "", "=q4=Elementium Deathplate Breastplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 71059, "", "=q4=Elementium Deathplate Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 71061, "", "=q4=Elementium Deathplate Greaves", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_deathknight_frostpresence", "=q6=#t12s10_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71478, "", "=q4=Elementium Deathplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71480, "", "=q4=Elementium Deathplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71476, "", "=q4=Elementium Deathplate Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71477, "", "=q4=Elementium Deathplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71479, "", "=q4=Elementium Deathplate Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112DeathKnightTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_bloodpresence", "=q6=#t11s10_2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60351, "", "=q4=Magma Plated Faceguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60353, "", "=q4=Magma Plated Shoulderguards", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60349, "", "=q4=Magma Plated Chestguard", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60350, "", "=q4=Magma Plated Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60352, "", "=q4=Magma Plated Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_deathknight_bloodpresence", "=q6=#t11s10_2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65186, "", "=q4=Magma Plated Faceguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65188, "", "=q4=Magma Plated Shoulderguards", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65184, "", "=q4=Magma Plated Chestguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65185, "", "=q4=Magma Plated Handguards", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65187, "", "=q4=Magma Plated Legguards", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_deathknight_frostpresence", "=q6=#t12s10_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 70954, "", "=q4=Elementium Deathplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 70951, "", "=q4=Elementium Deathplate Shouldergards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 70955, "", "=q4=Elementium Deathplate Chestguard", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 70953, "", "=q4=Elementium Deathplate Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 70952, "", "=q4=Elementium Deathplate Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_deathknight_frostpresence", "=q6=#t12s10_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71483, "", "=q4=Elementium Deathplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71485, "", "=q4=Elementium Deathplate Shouldergards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71481, "", "=q4=Elementium Deathplate Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71482, "", "=q4=Elementium Deathplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71484, "", "=q4=Elementium Deathplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112DruidRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#t11s1_1#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60277, "", "=q4=Stormrider's Helm", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60279, "", "=q4=Stormrider's Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60276, "", "=q4=Stormrider's Robes", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 5, 60280, "", "=q4=Stormrider's Handwraps", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 6, 60278, "", "=q4=Stormrider's Legwraps", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_nature_healingtouch", "=q6=#t11s1_1#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65195, "", "=q4=Stormrider's Helm", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65198, "", "=q4=Stormrider's Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65197, "", "=q4=Stormrider's Robes", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65194, "", "=q4=Stormrider's Handwraps", "=ds=#s9#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65196, "", "=q4=Stormrider's Legwraps", "=ds=#s11#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#t12s1_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71103, "", "=q4=Obsidian Arborweave Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71106, "", "=q4=Obsidian Arborweave Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71105, "", "=q4=Obsidian Arborweave Robes", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 20, 71102, "", "=q4=Obsidian Arborweave Handwraps", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 21, 71104, "", "=q4=Obsidian Arborweave Legwraps", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_nature_healingtouch", "=q6=#t12s1_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71492, "", "=q4=Obsidian Arborweave Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71495, "", "=q4=Obsidian Arborweave Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71494, "", "=q4=Obsidian Arborweave Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71491, "", "=q4=Obsidian Arborweave Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71493, "", "=q4=Obsidian Arborweave Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112DruidFeral"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#t11s1_2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60286, "", "=q4=Stormrider's Headpiece", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60289, "", "=q4=Stormrider's Spaulders", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60287, "", "=q4=Stormrider's Raiment", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 5, 60290, "", "=q4=Stormrider's Grips", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 6, 60288, "", "=q4=Stormrider's Legguards", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 8, 0, "ability_druid_catform", "=q6=#t11s1_2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65190, "", "=q4=Stormrider's Headpiece", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65193, "", "=q4=Stormrider's Spaulders", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65192, "", "=q4=Stormrider's Raiment", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65189, "", "=q4=Stormrider's Grips", "=ds=#s9#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65191, "", "=q4=Stormrider's Legguards", "=ds=#s11#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "ability_druid_catform", "=q6=#t12s1_2#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71098, "", "=q4=Obsidian Arborweave Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71101, "", "=q4=Obsidian Arborweave Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71100, "", "=q4=Obsidian Arborweave Raiment", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 20, 71097, "", "=q4=Obsidian Arborweave Grips", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 21, 71099, "", "=q4=Obsidian Arborweave Legguards", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 23, 0, "ability_druid_catform", "=q6=#t12s1_2#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71488, "", "=q4=Obsidian Arborweave Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71490, "", "=q4=Obsidian Arborweave Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71486, "", "=q4=Obsidian Arborweave Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71487, "", "=q4=Obsidian Arborweave Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71489, "", "=q4=Obsidian Arborweave Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112DruidBalance"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#t11s1_3#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60282, "", "=q4=Stormrider's Cover", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60284, "", "=q4=Stormrider's Shoulderwraps", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60281, "", "=q4=Stormrider's Vestment", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 5, 60285, "", "=q4=Stormrider's Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 6, 60283, "", "=q4=Stormrider's Leggings", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_nature_starfall", "=q6=#t11s1_3#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65200, "", "=q4=Stormrider's Cover", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65203, "", "=q4=Stormrider's Shoulderwraps", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65202, "", "=q4=Stormrider's Vestment", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65199, "", "=q4=Stormrider's Gloves", "=ds=#s9#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65201, "", "=q4=Stormrider's Leggings", "=ds=#s11#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_nature_starfall", "=q6=#t12s1_3#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71108, "", "=q4=Obsidian Arborweave Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71111, "", "=q4=Obsidian Arborweave Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71110, "", "=q4=Obsidian Arborweave Vestment", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 20, 71107, "", "=q4=Obsidian Arborweave Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 21, 71109, "", "=q4=Obsidian Arborweave Leggings", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_nature_starfall", "=q6=#t12s1_3#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71497, "", "=q4=Obsidian Arborweave Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71500, "", "=q4=Obsidian Arborweave Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71499, "", "=q4=Obsidian Arborweave Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71496, "", "=q4=Obsidian Arborweave Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71498, "", "=q4=Obsidian Arborweave Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t11s2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60303, "", "=q4=Lightning-Charged Headguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60306, "", "=q4=Lightning-Charged Spaulders", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60304, "", "=q4=Lightning-Charged Tunic", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 5, 60307, "", "=q4=Lightning-Charged Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 6, 60305, "", "=q4=Lightning-Charged Legguards", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#t11s2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65206, "", "=q4=Lightning-Charged Headguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65208, "", "=q4=Lightning-Charged Spaulders", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65204, "", "=q4=Lightning-Charged Tunic", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65205, "", "=q4=Lightning-Charged Gloves", "=ds=#s9#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65207, "", "=q4=Lightning-Charged Legguards", "=ds=#s11#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t12s2#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71051, "", "=q4=Flamewaker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71053, "", "=q4=Flamewaker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71054, "", "=q4=Flamewaker's Tunic", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 20, 71050, "", "=q4=Flamewaker's Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 21, 71052, "", "=q4=Flamewaker's Legguards", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 23, 0, "inv_weapon_bow_07", "=q6=#t12s2#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71503, "", "=q4=Flamewaker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71505, "", "=q4=Flamewaker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71501, "", "=q4=Flamewaker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71502, "", "=q4=Flamewaker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71504, "", "=q4=Flamewaker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t11s3#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60243, "", "=q4=Firelord's Hood", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60246, "", "=q4=Firelord's Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60244, "", "=q4=Firelord's Robes", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 5, 60247, "", "=q4=Firelord's Gloves", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 6, 60245, "", "=q4=Firelord's Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 8, 0, "inv_staff_13", "=q6=#t11s3#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65210, "", "=q4=Firelord's Hood", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65213, "", "=q4=Firelord's Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65212, "", "=q4=Firelord's Robes", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65209, "", "=q4=Firelord's Gloves", "=ds=#s9#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65211, "", "=q4=Firelord's Leggings", "=ds=#s11#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "inv_staff_13", "=q6=#t12s3#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71287, "", "=q4=Firehawk Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71290, "", "=q4=Firehawk Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71289, "", "=q4=Firehawk Robes", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 20, 71286, "", "=q4=Firehawk Gloves", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 21, 71288, "", "=q4=Firehawk Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 23, 0, "inv_staff_13", "=q6=#t12s3#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71508, "", "=q4=Firehawk Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71511, "", "=q4=Firehawk Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71510, "", "=q4=Firehawk Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71507, "", "=q4=Firehawk Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71509, "", "=q4=Firehawk Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112PaladinHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t11s4_1#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60359, "", "=q4=Reinforced Sapphirium Headguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60362, "", "=q4=Reinforced Sapphirium Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60360, "", "=q4=Reinforced Sapphirium Breastplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60363, "", "=q4=Reinforced Sapphirium Gloves", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60361, "", "=q4=Reinforced Sapphirium Greaves", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t11s4_1#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65221, "", "=q4=Reinforced Sapphirium Headguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65223, "", "=q4=Reinforced Sapphirium Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65219, "", "=q4=Reinforced Sapphirium Breastplate", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65220, "", "=q4=Reinforced Sapphirium Gloves", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65222, "", "=q4=Reinforced Sapphirium Greaves", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t12s4_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71093, "", "=q4=Immolation Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71095, "", "=q4=Immolation Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71091, "", "=q4=Immolation Breastplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 71092, "", "=q4=Immolation Gloves", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 71094, "", "=q4=Immolation Greaves", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "Spell_Holy_HolyBolt", "=q6=#t12s4_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71519, "", "=q4=Immolation Headguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71521, "", "=q4=Immolation Mantle", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71517, "", "=q4=Immolation Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71518, "", "=q4=Immolation Gloves", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71520, "", "=q4=Immolation Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112PaladinProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_devotionaura", "=q6=#t11s4_2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60356, "", "=q4=Reinforced Sapphirium Faceguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60358, "", "=q4=Reinforced Sapphirium Shoulderguards", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60354, "", "=q4=Reinforced Sapphirium Chestguard", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60355, "", "=q4=Reinforced Sapphirium Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60357, "", "=q4=Reinforced Sapphirium Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_holy_devotionaura", "=q6=#t11s4_2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65226, "", "=q4=Reinforced Sapphirium Faceguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65228, "", "=q4=Reinforced Sapphirium Shoulderguards", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65224, "", "=q4=Reinforced Sapphirium Chestguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65225, "", "=q4=Reinforced Sapphirium Handguards", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65227, "", "=q4=Reinforced Sapphirium Legguards", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_holy_devotionaura", "=q6=#t12s4_2#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 70948, "", "=q4=Immolation Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 70946, "", "=q4=Immolation Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 70950, "", "=q4=Immolation Chestguard", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 70949, "", "=q4=Immolation Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 70947, "", "=q4=Immolation Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_holy_devotionaura", "=q6=#t12s4_2#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71524, "", "=q4=Immolation Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71526, "", "=q4=Immolation Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71522, "", "=q4=Immolation Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71523, "", "=q4=Immolation Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71525, "", "=q4=Immolation Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112PaladinRetribution"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t11s4_3#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60346, "", "=q4=Reinforced Sapphirium Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60348, "", "=q4=Reinforced Sapphirium Pauldrons", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60344, "", "=q4=Reinforced Sapphirium Battleplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60345, "", "=q4=Reinforced Sapphirium Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60347, "", "=q4=Reinforced Sapphirium Legplates", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t11s4_3#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65216, "", "=q4=Reinforced Sapphirium Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65218, "", "=q4=Reinforced Sapphirium Pauldrons", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65214, "", "=q4=Reinforced Sapphirium Battleplate", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65215, "", "=q4=Reinforced Sapphirium Gauntlets", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65217, "", "=q4=Reinforced Sapphirium Legplates", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t12s4_3#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71065, "", "=q4=Immolation Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71067, "", "=q4=Immolation Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71063, "", "=q4=Immolation Battleplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 71064, "", "=q4=Immolation Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 71066, "", "=q4=Immolation Legplates", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "Spell_Holy_AuraOfLight", "=q6=#t12s4_3#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71514, "", "=q4=Immolation Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71516, "", "=q4=Immolation Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71512, "", "=q4=Immolation Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71513, "", "=q4=Immolation Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71515, "", "=q4=Immolation Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112PriestShadow"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#t11s5_1#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60256, "", "=q4=Mercurial Hood", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60253, "", "=q4=Mercurial Shoulderwraps", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60254, "", "=q4=Mercurial Vestment", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 5, 60257, "", "=q4=Mercurial Gloves", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 6, 60255, "", "=q4=Mercurial Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_shadow_shadowwordpain", "=q6=#t11s5_1#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65235, "", "=q4=Mercurial Hood", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65238, "", "=q4=Mercurial Shoulderwraps", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65237, "", "=q4=Mercurial Vestment", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65234, "", "=q4=Mercurial Gloves", "=ds=#s9#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65236, "", "=q4=Mercurial Leggings", "=ds=#s11#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#t12s5_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71277, "", "=q4=Hood of the Cleansing Flame", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71280, "", "=q4=Shoulderwraps of the Cleansing Flame", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71279, "", "=q4=Vestment of the Cleansing Flame", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 20, 71276, "", "=q4=Gloves of the Cleansing Flame", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 21, 71278, "", "=q4=Leggings of the Cleansing Flame", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_shadow_shadowwordpain", "=q6=#t12s5_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71533, "", "=q4=Hood of the Cleansing Flame", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71536, "", "=q4=Shoulderwraps of the Cleansing Flame", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71535, "", "=q4=Vestment of the Cleansing Flame", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71532, "", "=q4=Gloves of the Cleansing Flame", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71534, "", "=q4=Leggings of the Cleansing Flame", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Shadow"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112PriestHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6=#t11s5_2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60258, "", "=q4=Mercurial Cowl", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60262, "", "=q4=Mercurial Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60259, "", "=q4=Mercurial Robes", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 5, 60275, "", "=q4=Mercurial Handwraps", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 6, 60261, "", "=q4=Mercurial Legwraps", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_holy_guardianspirit", "=q6=#t11s5_2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65230, "", "=q4=Mercurial Cowl", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65233, "", "=q4=Mercurial Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65232, "", "=q4=Mercurial Robes", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65229, "", "=q4=Mercurial Handwraps", "=ds=#s9#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65231, "", "=q4=Mercurial Legwraps", "=ds=#s11#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_holy_guardianspirit", "=q6=#t12s5_2#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71272, "", "=q4=Cowl of the Cleansing Flame", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71275, "", "=q4=Mantle of the Cleansing Flame", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71274, "", "=q4=Robes of the Cleansing Flame", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 20, 71271, "", "=q4=Handwraps of the Cleansing Flame", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 21, 71273, "", "=q4=Legwraps of the Cleansing Flame", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_holy_guardianspirit", "=q6=#t12s5_2#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71528, "", "=q4=Cowl of the Cleansing Flame", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71531, "", "=q4=Mantle of the Cleansing Flame", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71530, "", "=q4=Robes of the Cleansing Flame", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71527, "", "=q4=Handwraps of the Cleansing Flame", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71529, "", "=q4=Legwraps of the Cleansing Flame", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t11s6#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60299, "", "=q4=Wind Dancer's Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60302, "", "=q4=Wind Dancer's Spaulders", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60301, "", "=q4=Wind Dancer's Tunic", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 5, 60298, "", "=q4=Wind Dancer's Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 6, 60300, "", "=q4=Wind Dancer's Legguards", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 8, 0, "inv_throwingknife_04", "=q6=#t11s6#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65241, "", "=q4=Wind Dancer's Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65243, "", "=q4=Wind Dancer's Spaulders", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65239, "", "=q4=Wind Dancer's Tunic", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65240, "", "=q4=Wind Dancer's Gloves", "=ds=#s9#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65242, "", "=q4=Wind Dancer's Legguards", "=ds=#s11#, #a2#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t12s6#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71047, "", "=q4=Dark Phoenix Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71049, "", "=q4=Dark Phoenix Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71045, "", "=q4=Dark Phoenix Tunic", "=ds=#s5#, #a2#", "#JUSTICE:2200#"};
				{ 20, 71046, "", "=q4=Dark Phoenix Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#"};
				{ 21, 71048, "", "=q4=Dark Phoenix Legguards", "=ds=#s11#, #a2#", "#JUSTICE:2200#"};
				{ 23, 0, "inv_throwingknife_04", "=q6=#t12s6#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71539, "", "=q4=Dark Phoenix Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71541, "", "=q4=Dark Phoenix Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71537, "", "=q4=Dark Phoenix Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71538, "", "=q4=Dark Phoenix Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71540, "", "=q4=Dark Phoenix Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112ShamanElemental"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#t11s7_3#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60315, "", "=q4=Headpiece of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60317, "", "=q4=Shoulderwraps of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60313, "", "=q4=Hauberk of the Raging Elements", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 5, 60314, "", "=q4=Gloves of the Raging Elements", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 6, 60316, "", "=q4=Kilt of the Raging Elements", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 8, 0, "Spell_Nature_Lightning", "=q6=#t11s7_3#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65256, "", "=q4=Headpiece of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65258, "", "=q4=Shoulderwraps of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65254, "", "=q4=Hauberk of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65255, "", "=q4=Gloves of the Raging Elements", "=ds=#s9#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65257, "", "=q4=Kilt of the Raging Elements", "=ds=#s11#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#t12s7_3#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71293, "", "=q4=Erupting Volcanic Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71295, "", "=q4=Erupting Volcanic Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71294, "", "=q4=Erupting Volcanic Hauberk", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 20, 71292, "", "=q4=Erupting Volcanic Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 21, 71291, "", "=q4=Erupting Volcanic Kilt", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 23, 0, "Spell_Nature_Lightning", "=q6=#t12s7_3#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71554, "", "=q4=Erupting Volcanic Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71556, "", "=q4=Erupting Volcanic Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71552, "", "=q4=Erupting Volcanic Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71553, "", "=q4=Erupting Volcanic Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71555, "", "=q4=Erupting Volcanic Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112ShamanEnhancement"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#t11s7_2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60320, "", "=q4=Helmet of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60322, "", "=q4=Spaulders of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60318, "", "=q4=Culrass of the Raging Elements", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 5, 60319, "", "=q4=Grips of the Raging Elements", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 6, 60321, "", "=q4=Legguards of the Raging Elements", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_nature_lightningshield", "=q6=#t11s7_2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65251, "", "=q4=Helmet of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65253, "", "=q4=Spaulders of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65249, "", "=q4=Culrass of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65250, "", "=q4=Grips of the Raging Elements", "=ds=#s9#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65252, "", "=q4=Legguards of the Raging Elements", "=ds=#s11#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#t12s7_2#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71303, "", "=q4=Erupting Volcanic Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71305, "", "=q4=Erupting Volcanic Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71301, "", "=q4=Erupting Volcanic Cuirass", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 20, 71302, "", "=q4=Erupting Volcanic Grips", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 21, 71304, "", "=q4=Erupting Volcanic Legguards", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_nature_lightningshield", "=q6=#t12s7_2#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71549, "", "=q4=Erupting Volcanic Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71551, "", "=q4=Erupting Volcanic Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71547, "", "=q4=Erupting Volcanic Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71548, "", "=q4=Erupting Volcanic Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71550, "", "=q4=Erupting Volcanic Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112ShamanRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#t11s7_1#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60308, "", "=q4=Faceguard of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60311, "", "=q4=Mantle of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60309, "", "=q4=Tunic of the Raging Elements", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 5, 60312, "", "=q4=Handwraps of the Raging Elements", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 6, 60310, "", "=q4=Legwraps of the Raging Elements", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_nature_magicimmunity", "=q6=#t11s7_1#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65246, "", "=q4=Faceguard of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65248, "", "=q4=Mantle of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65244, "", "=q4=Tunic of the Raging Elements", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65245, "", "=q4=Handwraps of the Raging Elements", "=ds=#s9#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65247, "", "=q4=Legwraps of the Raging Elements", "=ds=#s11#, #a3#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#t12s7_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71298, "", "=q4=Erupting Volcanic Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71300, "", "=q4=Erupting Volcanic Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71296, "", "=q4=Erupting Volcanic Tunic", "=ds=#s5#, #a3#", "#JUSTICE:2200#"};
				{ 20, 71297, "", "=q4=Erupting Volcanic Handwraps", "=ds=#s9#, #a3#", "#JUSTICE:1650#"};
				{ 21, 71299, "", "=q4=Erupting Volcanic Legwraps", "=ds=#s11#, #a3#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_nature_magicimmunity", "=q6=#t12s7_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71544, "", "=q4=Erupting Volcanic Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71546, "", "=q4=Erupting Volcanic Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71542, "", "=q4=Erupting Volcanic Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71543, "", "=q4=Erupting Volcanic Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71545, "", "=q4=Erupting Volcanic Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t11s8#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60249, "", "=q4=Shadowflame Hood", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60252, "", "=q4=Shadowflame Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60251, "", "=q4=Shadowflame Robes", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 5, 60248, "", "=q4=Shadowflame Handwraps", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 6, 60250, "", "=q4=Shadowflame Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 8, 0, "spell_nature_drowsy", "=q6=#t11s8#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65260, "", "=q4=Shadowflame Hood", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65263, "", "=q4=Shadowflame Mantle", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65262, "", "=q4=Shadowflame Robes", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65259, "", "=q4=Shadowflame Handwraps", "=ds=#s9#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65261, "", "=q4=Shadowflame Leggings", "=ds=#s11#, #a1#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t12s8#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71282, "", "=q4=Balespider's Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71285, "", "=q4=Balespider's Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71284, "", "=q4=Balespider's Robes", "=ds=#s5#, #a1#", "#JUSTICE:2200#"};
				{ 20, 71281, "", "=q4=Balespider's Handwraps", "=ds=#s9#, #a1#", "#JUSTICE:1650#"};
				{ 21, 71283, "", "=q4=Balespider's Leggings", "=ds=#s11#, #a1#", "#JUSTICE:2200#"};
				{ 23, 0, "spell_nature_drowsy", "=q6=#t12s8#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71595, "", "=q4=Balespider's Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71598, "", "=q4=Balespider's Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71597, "", "=q4=Balespider's Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71594, "", "=q4=Balespider's Handwraps", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71596, "", "=q4=Balespider's Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112WarriorFury"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_innerrage", "=q6=#t11s9_1#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60325, "", "=q4=Earthen Helmet", "=ds=#s1#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60327, "", "=q4=Earthen Pauldrons", "=ds=#s3#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60323, "", "=q4=Earthen Battleplate", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60326, "", "=q4=Earthen Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60324, "", "=q4=Earthen Legplates", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "ability_warrior_innerrage", "=q6=#t11s9_1#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65266, "", "=q4=Earthen Helmet", "", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 10, 65268, "", "=q4=Earthen Pauldrons", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65264, "", "=q4=Earthen Battleplate", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65265, "", "=q4=Earthen Gauntlets", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65267, "", "=q4=Earthen Legplates", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "ability_warrior_innerrage", "=q6=#t12s9_1#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 71070, "", "=q4=Helmet of the Molten Giant", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 71072, "", "=q4=Pauldrons of the Molten Giant", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 71068, "", "=q4=Battleplate of the Molten Giant", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 71069, "", "=q4=Gauntlets of the Molten Giant", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 71071, "", "=q4=Legplates of the Molten Giant", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "ability_warrior_innerrage", "=q6=#t12s9_1#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71599, "", "=q4=Helmet of the Molten Giant", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71603, "", "=q4=Pauldrons of the Molten Giant", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71600, "", "=q4=Battleplate of the Molten Giant", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71601, "", "=q4=Gauntlets of the Molten Giant", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71602, "", "=q4=Legplates of the Molten Giant", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["DPS"],
			module = moduleName, menu = "T1112SET",
		};
	}

	AtlasLoot_Data["T1112WarriorProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_defensivestance", "=q6=#t11s9_2#", "=q5="..string.format(AL["Tier %d"], 11)};
				{ 2, 60328, "", "=q4=Earthen Faceguard", "=ds=#s1#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174)};
				{ 3, 60331, "", "=q4=Earthen Shoulderguards", "=ds=#s3#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 4, 60329, "", "=q4=Earthen Chestguard", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 5, 60332, "", "=q4=Earthen Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 6, 60330, "", "=q4=Earthen Legguards", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 8, 0, "ability_warrior_defensivestance", "=q6=#t11s9_2#", "=q5="..string.format(AL["Tier %d"], 11).." - "..AL["Heroic"]};
				{ 9, 65271, "", "=q4=Earthen Faceguard", "=ds="..AtlasLoot:EJ_GetBossName("Nefarian's End", 174), ""};
				{ 10, 65273, "", "=q4=Earthen Shoulderguards", "", "=ds="..AtlasLoot:EJ_GetBossName("Cho'gall", 167)};
				{ 11, 65269, "", "=q4=Earthen Chestguard", "", "=ds="..AtlasLoot:EJ_GetBossName("Halfus Wyrmbreaker", 156)};
				{ 12, 65270, "", "=q4=Earthen Handguards", "=ds=#s9#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Magmaw", 170)};
				{ 13, 65272, "", "=q4=Earthen Legguards", "=ds=#s11#, #a4#", "=ds="..AtlasLoot:EJ_GetBossName("Maloriak", 173)};
				{ 16, 0, "ability_warrior_defensivestance", "=q6=#t12s9_2#", "=q5="..string.format(AL["Tier %d"], 12)};
				{ 17, 70944, "", "=q4=Faceguard of the Molten Giant", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 18, 70941, "", "=q4=Shoulderguards of the Molten Giant", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 19, 70945, "", "=q4=Chestguard of the Molten Giant", "=ds=#s5#, #a4#", "#JUSTICE:2200#"};
				{ 20, 70943, "", "=q4=Handguards of the Molten Giant", "=ds=#s9#, #a4#", "#JUSTICE:1650#"};
				{ 21, 70942, "", "=q4=Legguards of the Molten Giant", "=ds=#s11#, #a4#", "#JUSTICE:2200#"};
				{ 23, 0, "ability_warrior_defensivestance", "=q6=#t12s9_2#", "=q5="..string.format(AL["Tier %d"], 12).." - "..AL["Heroic"]};
				{ 24, 71606, "", "=q4=Faceguard of the Molten Giant", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Ragnaros", 198)};
				{ 25, 71608, "", "=q4=Shoulderguards of the Molten Giant", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Majordomo Staghelm", 197)};
				{ 26, 71604, "", "=q4=Chestguard of the Molten Giant", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Alysrazor", 194)};
				{ 27, 71605, "", "=q4=Handguards of the Molten Giant", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)};
				{ 28, 71607, "", "=q4=Legguards of the Molten Giant", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Shannox", 195)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T1112SET",
		};
	}

		--------------------------
		--- Tier 13 Sets (T13) ---
		--------------------------

	AtlasLoot_Data["T13DeathKnightDPS"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_frostpresence", "=q6=#t13s10_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78782, "", "=q4=Necrotic Boneplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78831, "", "=q4=Necrotic Boneplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78754, "", "=q4=Necrotic Boneplate Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78765, "", "=q4=Necrotic Boneplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78802, "", "=q4=Necrotic Boneplate Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_deathknight_frostpresence", "=q6=#t13s10_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76976, "", "=q4=Necrotic Boneplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76978, "", "=q4=Necrotic Boneplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76974, "", "=q4=Necrotic Boneplate Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76975, "", "=q4=Necrotic Boneplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76977, "", "=q4=Necrotic Boneplate Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_deathknight_frostpresence", "=q6=#t13s10_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78687, "", "=q4=Necrotic Boneplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78736, "", "=q4=Necrotic Boneplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78659, "", "=q4=Necrotic Boneplate Breastplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78670, "", "=q4=Necrotic Boneplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78707, "", "=q4=Necrotic Boneplate Greaves", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["DPS"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13DeathKnightTank"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_deathknight_bloodpresence", "=q6=#t13s10_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78792, "", "=q4=Necrotic Boneplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78846, "", "=q4=Necrotic Boneplate Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78758, "", "=q4=Necrotic Boneplate Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78773, "", "=q4=Necrotic Boneplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78811, "", "=q4=Necrotic Boneplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_deathknight_bloodpresence", "=q6=#t13s10_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77010, "", "=q4=Necrotic Boneplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77012, "", "=q4=Necrotic Boneplate Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77008, "", "=q4=Necrotic Boneplate Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77009, "", "=q4=Necrotic Boneplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77011, "", "=q4=Necrotic Boneplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_deathknight_bloodpresence", "=q6=#t13s10_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78697, "", "=q4=Necrotic Boneplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78751, "", "=q4=Necrotic Boneplate Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78663, "", "=q4=Necrotic Boneplate Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78678, "", "=q4=Necrotic Boneplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78716, "", "=q4=Necrotic Boneplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"].." - "..AL["Tanking"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13DruidRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_healingtouch", "=q6=#t13s1_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78785, "", "=q4=Deep Earth Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78835, "", "=q4=Deep Earth Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78755, "", "=q4=Deep Earth Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78775, "", "=q4=Deep Earth Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78805, "", "=q4=Deep Earth Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_nature_healingtouch", "=q6=#t13s1_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76750, "", "=q4=Deep Earth Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76753, "", "=q4=Deep Earth Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76752, "", "=q4=Deep Earth Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76749, "", "=q4=Deep Earth Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76751, "", "=q4=Deep Earth Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_nature_healingtouch", "=q6=#t13s1_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78690, "", "=q4=Deep Earth Helm", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78740, "", "=q4=Deep Earth Mantle", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78660, "", "=q4=Deep Earth Robes", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78680, "", "=q4=Deep Earth Handwraps", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78710, "", "=q4=Deep Earth Legwraps", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13DruidFeral"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_catform", "=q6=#t13s1_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78789, "", "=q4=Deep Earth Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78838, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78760, "", "=q4=Deep Earth Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78779, "", "=q4=Deep Earth Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78808, "", "=q4=Deep Earth Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "ability_druid_catform", "=q6=#t13s1_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77015, "", "=q4=Deep Earth Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77017, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77013, "", "=q4=Deep Earth Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77014, "", "=q4=Deep Earth Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77016, "", "=q4=Deep Earth Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "ability_druid_catform", "=q6=#t13s1_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78694, "", "=q4=Deep Earth Headpiece", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78743, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78665, "", "=q4=Deep Earth Raiment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78684, "", "=q4=Deep Earth Grips", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78713, "", "=q4=Deep Earth Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Feral"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13DruidBalance"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_starfall", "=q6=#t13s1_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78791, "", "=q4=Deep Earth Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78839, "", "=q4=Deep Earth Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78757, "", "=q4=Deep Earth Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78771, "", "=q4=Deep Earth Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78809, "", "=q4=Deep Earth Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_nature_starfall", "=q6=#t13s1_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77019, "", "=q4=Deep Earth Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77022, "", "=q4=Deep Earth Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77021, "", "=q4=Deep Earth Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77018, "", "=q4=Deep Earth Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77020, "", "=q4=Deep Earth Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_nature_starfall", "=q6=#t13s1_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78696, "", "=q4=Deep Earth Cover", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78744, "", "=q4=Deep Earth Shoulderwraps", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78662, "", "=q4=Deep Earth Vestment", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78676, "", "=q4=Deep Earth Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78714, "", "=q4=Deep Earth Leggings", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"].." - "..ALIL["Balance"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t13s2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78793, "", "=q4=Wyrmstalker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78832, "", "=q4=Wyrmstalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78756, "", "=q4=Wyrmstalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78769, "", "=q4=Wyrmstalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78804, "", "=q4=Wyrmstalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#t13s2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77030, "", "=q4=Wyrmstalker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77032, "", "=q4=Wyrmstalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77028, "", "=q4=Wyrmstalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77029, "", "=q4=Wyrmstalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77031, "", "=q4=Wyrmstalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t13s2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78698, "", "=q4=Wyrmstalker's Headguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78737, "", "=q4=Wyrmstalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78661, "", "=q4=Wyrmstalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78674, "", "=q4=Wyrmstalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78709, "", "=q4=Wyrmstalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t13s3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78796, "", "=q4=Time Lord's Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78843, "", "=q4=Time Lord's Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78824, "", "=q4=Time Lord's Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78766, "", "=q4=Time Lord's Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78815, "", "=q4=Time Lord's Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "inv_staff_13", "=q6=#t13s3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76213, "", "=q4=Time Lord's Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76216, "", "=q4=Time Lord's Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76215, "", "=q4=Time Lord's Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76212, "", "=q4=Time Lord's Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76214, "", "=q4=Time Lord's Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "inv_staff_13", "=q6=#t13s3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78701, "", "=q4=Time Lord's Hood", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78748, "", "=q4=Time Lord's Mantle", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78729, "", "=q4=Time Lord's Robes", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78671, "", "=q4=Time Lord's Gloves", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78720, "", "=q4=Time Lord's Leggings", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13PaladinHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_HolyBolt", "=q6=#t13s4_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78787, "", "=q4=Headguard of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78841, "", "=q4=Mantle of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78821, "", "=q4=Breastplate of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78768, "", "=q4=Gloves of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78812, "", "=q4=Greaves of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "Spell_Holy_HolyBolt", "=q6=#t13s4_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76767, "", "=q4=Headguard of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76769, "", "=q4=Mantle of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76765, "", "=q4=Breastplate of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76766, "", "=q4=Gloves of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76768, "", "=q4=Greaves of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "Spell_Holy_HolyBolt", "=q6=#t13s4_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78692, "", "=q4=Headguard of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78746, "", "=q4=Mantle of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78726, "", "=q4=Breastplate of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78673, "", "=q4=Gloves of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78717, "", "=q4=Greaves of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13PaladinProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_devotionaura", "=q6=#t13s4_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78790, "", "=q4=Faceguard of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78840, "", "=q4=Shoulderguards of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78827, "", "=q4=Chestguard of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78772, "", "=q4=Handguards of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78810, "", "=q4=Legguards of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_holy_devotionaura", "=q6=#t13s4_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77005, "", "=q4=Faceguard of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77007, "", "=q4=Shoulderguards of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77003, "", "=q4=Chestguard of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77004, "", "=q4=Handguards of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77006, "", "=q4=Legguards of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_holy_devotionaura", "=q6=#t13s4_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78695, "", "=q4=Faceguard of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78745, "", "=q4=Shoulderguards of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78732, "", "=q4=Chestguard of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78677, "", "=q4=Handguards of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78715, "", "=q4=Legguards of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13PaladinRetribution"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Holy_AuraOfLight", "=q6=#t13s4_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78788, "", "=q4=Helmet of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78837, "", "=q4=Pauldrons of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78822, "", "=q4=Battleplate of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78770, "", "=q4=Gauntlets of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78807, "", "=q4=Legplates of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "Spell_Holy_AuraOfLight", "=q6=#t13s4_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76876, "", "=q4=Helmet of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76878, "", "=q4=Pauldrons of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76874, "", "=q4=Battleplate of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76875, "", "=q4=Gauntlets of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76877, "", "=q4=Legplates of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "Spell_Holy_AuraOfLight", "=q6=#t13s4_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78693, "", "=q4=Helmet of Radiant Glory", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78742, "", "=q4=Pauldrons of Radiant Glory", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78727, "", "=q4=Battleplate of Radiant Glory", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78675, "", "=q4=Gauntlets of Radiant Glory", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78712, "", "=q4=Legplates of Radiant Glory", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"].." - "..ALIL["Retribution"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13PriestShadow"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_shadow_shadowwordpain", "=q6=#t13s5_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78798, "", "=q4=Hood of Dying Light", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78845, "", "=q4=Mantle of Dying Light", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78826, "", "=q4=Robes of Dying Light", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78777, "", "=q4=Gloves of Dying Light", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78817, "", "=q4=Leggings of Dying Light", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_shadow_shadowwordpain", "=q6=#t13s5_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76347, "", "=q4=Hood of Dying Light", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76344, "", "=q4=Mantle of Dying Light", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76345, "", "=q4=Robes of Dying Light", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76348, "", "=q4=Gloves of Dying Light", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76346, "", "=q4=Leggings of Dying Light", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_shadow_shadowwordpain", "=q6=#t13s5_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78703, "", "=q4=Hood of Dying Light", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78750, "", "=q4=Mantle of Dying Light", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78731, "", "=q4=Robes of Dying Light", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78682, "", "=q4=Gloves of Dying Light", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78722, "", "=q4=Leggings of Dying Light", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Shadow"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13PriestHoly"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_holy_guardianspirit", "=q6=#t13s5_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78795, "", "=q4=Cowl of Dying Light", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78842, "", "=q4=Mantle of Dying Light", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78823, "", "=q4=Robes of Dying Light", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78778, "", "=q4=Handwraps of Dying Light", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78814, "", "=q4=Legwraps of Dying Light", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_holy_guardianspirit", "=q6=#t13s5_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76358, "", "=q4=Cowl of Dying Light", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76361, "", "=q4=Mantle of Dying Light", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76360, "", "=q4=Robes of Dying Light", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76357, "", "=q4=Handwraps of Dying Light", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76359, "", "=q4=Legwraps of Dying Light", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_holy_guardianspirit", "=q6=#t13s5_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78700, "", "=q4=Cowl of Dying Light", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78747, "", "=q4=Mantle of Dying Light", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78728, "", "=q4=Robes of Dying Light", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78683, "", "=q4=Handwraps of Dying Light", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78719, "", "=q4=Legwraps of Dying Light", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"].." - "..ALIL["Holy"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t13s6#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78794, "", "=q4=Blackfang Battleweave Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78833, "", "=q4=Blackfang Battleweave Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78759, "", "=q4=Blackfang Battleweave Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78774, "", "=q4=Blackfang Battleweave Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78803, "", "=q4=Blackfang Battleweave Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "inv_throwingknife_04", "=q6=#t13s6#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77025, "", "=q4=Blackfang Battleweave Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77027, "", "=q4=Blackfang Battleweave Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77023, "", "=q4=Blackfang Battleweave Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77024, "", "=q4=Blackfang Battleweave Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77026, "", "=q4=Blackfang Battleweave Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t13s6#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78699, "", "=q4=Blackfang Battleweave Helmet", "=ds=#s1#, #a2#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78738, "", "=q4=Blackfang Battleweave Spaulders", "=ds=#s3#, #a2#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78664, "", "=q4=Blackfang Battleweave Tunic", "=ds=#s5#, #a2#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78679, "", "=q4=Blackfang Battleweave Gloves", "=ds=#s9#, #a2#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78708, "", "=q4=Blackfang Battleweave Legguards", "=ds=#s11#, #a2#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13ShamanElemental"] = {
		["Normal"] = {
			{
				{ 1, 0, "Spell_Nature_Lightning", "=q6=#t13s7_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78780, "", "=q4=Spiritwalker's Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78836, "", "=q4=Spiritwalker's Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78818, "", "=q4=Spiritwalker's Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78761, "", "=q4=Spiritwalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78806, "", "=q4=Spiritwalker's Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "Spell_Nature_Lightning", "=q6=#t13s7_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77037, "", "=q4=Spiritwalker's Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77035, "", "=q4=Spiritwalker's Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77039, "", "=q4=Spiritwalker's Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77038, "", "=q4=Spiritwalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77036, "", "=q4=Spiritwalker's Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "Spell_Nature_Lightning", "=q6=#t13s7_3#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78685, "", "=q4=Spiritwalker's Headpiece", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78741, "", "=q4=Spiritwalker's Shoulderwraps", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78723, "", "=q4=Spiritwalker's Hauberk", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78666, "", "=q4=Spiritwalker's Gloves", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78711, "", "=q4=Spiritwalker's Kilt", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Elemental"],
			module = moduleName, menu = "T13SET",
		};
	}
				
	AtlasLoot_Data["T13ShamanEnhancement"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_lightningshield", "=q6=#t13s7_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78781, "", "=q4=Spiritwalker's Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78828, "", "=q4=Spiritwalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78819, "", "=q4=Spiritwalker's Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78762, "", "=q4=Spiritwalker's Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78799, "", "=q4=Spiritwalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_nature_lightningshield", "=q6=#t13s7_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 77042, "", "=q4=Spiritwalker's Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 77044, "", "=q4=Spiritwalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 77040, "", "=q4=Spiritwalker's Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 77041, "", "=q4=Spiritwalker's Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 77043, "", "=q4=Spiritwalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_nature_lightningshield", "=q6=#t13s7_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78686, "", "=q4=Spiritwalker's Helmet", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78733, "", "=q4=Spiritwalker's Spaulders", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78724, "", "=q4=Spiritwalker's Cuirass", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78667, "", "=q4=Spiritwalker's Grips", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78704, "", "=q4=Spiritwalker's Legguards", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Enhancement"],
			module = moduleName, menu = "T13SET",
		};
	}
				
	AtlasLoot_Data["T13ShamanRestoration"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_magicimmunity", "=q6=#t13s7_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78786, "", "=q4=Spiritwalker's Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78834, "", "=q4=Spiritwalker's Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78820, "", "=q4=Spiritwalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78767, "", "=q4=Spiritwalker's Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78813, "", "=q4=Spiritwalker's Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_nature_magicimmunity", "=q6=#t13s7_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76758, "", "=q4=Spiritwalker's Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76760, "", "=q4=Spiritwalker's Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76756, "", "=q4=Spiritwalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76757, "", "=q4=Spiritwalker's Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76759, "", "=q4=Spiritwalker's Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_nature_magicimmunity", "=q6=#t13s7_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78691, "", "=q4=Spiritwalker's Faceguard", "=ds=#s1#, #a3#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78739, "", "=q4=Spiritwalker's Mantle", "=ds=#s3#, #a3#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78725, "", "=q4=Spiritwalker's Tunic", "=ds=#s5#, #a3#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78672, "", "=q4=Spiritwalker's Handwraps", "=ds=#s9#, #a3#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78718, "", "=q4=Spiritwalker's Legwraps", "=ds=#s11#, #a3#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"].." - "..ALIL["Restoration"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t13s8#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78797, "", "=q4=Hood of the Faceless Shroud", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78844, "", "=q4=Mantle of the Faceless Shroud", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78825, "", "=q4=Robes of the Faceless Shroud", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78776, "", "=q4=Gloves of the Faceless Shroud", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78816, "", "=q4=Leggings of the Faceless Shroud", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "spell_nature_drowsy", "=q6=#t13s8#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76342, "", "=q4=Hood of the Faceless Shroud", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76339, "", "=q4=Mantle of the Faceless Shroud", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76340, "", "=q4=Robes of the Faceless Shroud", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76343, "", "=q4=Gloves of the Faceless Shroud", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76341, "", "=q4=Leggings of the Faceless Shroud", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t13s8#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78702, "", "=q4=Hood of the Faceless Shroud", "=ds=#s1#, #a1#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78749, "", "=q4=Mantle of the Faceless Shroud", "=ds=#s3#, #a1#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78730, "", "=q4=Robes of the Faceless Shroud", "=ds=#s5#, #a1#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78681, "", "=q4=Gloves of the Faceless Shroud", "=ds=#s9#, #a1#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78721, "", "=q4=Leggings of the Faceless Shroud", "=ds=#s11#, #a1#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13WarriorFury"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_innerrage", "=q6=#t13s9_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78783, "", "=q4=Colossal Dragonplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78830, "", "=q4=Colossal Dragonplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78752, "", "=q4=Colossal Dragonplate Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78763, "", "=q4=Colossal Dragonplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78801, "", "=q4=Colossal Dragonplate Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "ability_warrior_innerrage", "=q6=#t13s9_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76983, "", "=q4=Colossal Dragonplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76987, "", "=q4=Colossal Dragonplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76984, "", "=q4=Colossal Dragonplate Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76985, "", "=q4=Colossal Dragonplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76986, "", "=q4=Colossal Dragonplate Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "ability_warrior_innerrage", "=q6=#t13s9_1#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78688, "", "=q4=Colossal Dragonplate Helmet", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78735, "", "=q4=Colossal Dragonplate Pauldrons", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78657, "", "=q4=Colossal Dragonplate Battleplate", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78668, "", "=q4=Colossal Dragonplate Gauntlets", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78706, "", "=q4=Colossal Dragonplate Legplates", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..AL["DPS"],
			module = moduleName, menu = "T13SET",
		};
	}

	AtlasLoot_Data["T13WarriorProtection"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_warrior_defensivestance", "=q6=#t13s9_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Raid Finder"]};
				{ 2, 78784, "", "=q4=Colossal Dragonplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 3, 78829, "", "=q4=Colossal Dragonplate Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 4, 78753, "", "=q4=Colossal Dragonplate Chestguards", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 5, 78764, "", "=q4=Colossal Dragonplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 6, 78800, "", "=q4=Colossal Dragonplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 8, 0, "ability_warrior_defensivestance", "=q6=#t13s9_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Normal"]};
				{ 9, 76990, "", "=q4=Colossal Dragonplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 10, 76992, "", "=q4=Colossal Dragonplate Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 11, 76988, "", "=q4=Colossal Dragonplate Chestguard", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 12, 76989, "", "=q4=Colossal Dragonplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 13, 76991, "", "=q4=Colossal Dragonplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
				{ 16, 0, "ability_warrior_defensivestance", "=q6=#t13s9_2#", "=q5="..string.format(AL["Tier %d"], 13).." - "..AL["Heroic"]};
				{ 17, 78689, "", "=q4=Colossal Dragonplate Faceguard", "=ds=#s1#, #a4#", AtlasLoot:EJ_GetBossName("Warmaster Blackhorn", 332)};
				{ 18, 78734, "", "=q4=Colossal Dragonplate Shoulderguards", "=ds=#s3#, #a4#", AtlasLoot:EJ_GetBossName("Hagara the Stormbinder", 317)};
				{ 19, 78658, "", "=q4=Colossal Dragonplate Chestguards", "=ds=#s5#, #a4#", AtlasLoot:EJ_GetBossName("Ultraxion", 331)};
				{ 20, 78669, "", "=q4=Colossal Dragonplate Handguards", "=ds=#s9#, #a4#", AtlasLoot:EJ_GetBossName("Warlord Zon'ozz", 324)};
				{ 21, 78705, "", "=q4=Colossal Dragonplate Legguards", "=ds=#s11#, #a4#", AtlasLoot:EJ_GetBossName("Yor'sahj the Unsleeping", 325)};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"].." - "..ALIL["Protection"],
			module = moduleName, menu = "T13SET",
		};
	}

		------------
		--- Bags ---
		------------

-- THIS SECTION IS UNDER HEAVY CONSTRUCTION. Quests and Items need to be flaged as Horde or Alliance. Some quests are only available to a specific race and should be flaged as such.

	AtlasLoot_Data["BagsGeneral"] = {
		["Normal"] = {
			{
				{ 1, 82446, "", "=q4=Royal Satchel", "=ds=#e1#", "=ds#p8#"};
				{ 2, 54444, "", "=q3=Illusionary Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 3, 51809, "", "=q4=Portable Hole", "=ds=#e1#", "=ds="..AL["Vendor"]..": 3,000 #gold#"};
				{ 4, 69748, "", "=q3=Tattered Hexcloth Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:29186#"};
				{ 5, 88397, "", "=q1=Grummlepack", "=ds=#e1#", "=q1=#m4#: #QUESTID:30600#"};
				{ 6, 38082, "", "=q4=\"Gigantique\" Bag", "=ds=#e1#", "=ds="..AL["Vendor"]..": 1,200 #gold#"};
				{ 7, 43345, "", "=q4=Dragon Hide Bag", "=ds=", "=ds=#e1#", "=ds="..BabbleBoss["Sartharion"]..": "..ALIL["The Obsidian Sanctum"]};
				{ 8, 49295, "", "=q4=Enlarged Onyxia Hide Backpack", "=ds=#e1#", "=ds="..BabbleBoss["Onyxia"]..": "..ALIL["Onyxia's Lair"]};
				{ 9, 50316, "", "=q4=Papa's Brand New Bag", "=ds=#e1#", "=ds="..BabbleBoss["Bronjahm"]..": "..ALIL["The Forge of Souls"]};
				{ 10, 41957, "", "=q3=Abyssal Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 11, 41600, "", "=q3=Glacial Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 12, 54443, "", "=q2=Embersilk Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 13, 50317, "", "=q4=Papa's New Bag", "=ds=#e1#", "=ds="..BabbleBoss["Bronjahm"]..": "..ALIL["The Forge of Souls"]};
				{ 14, 34845, "", "=q4=Pit Lord's Satchel", "=ds=#e1#", "=ds="..BabbleBoss["Magtheridon"]..": "..ALIL["Magtheridon's Lair"]};
				{ 15, 21872, "", "=q3=Ebon Shadowbag", "=ds=#e1#", "=ds=#p8#"};
				{ 16, 21876, "", "=q3=Primal Mooncloth Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 17, 34105, "", "=q3=Quiver of a Thousand Feathers", "=ds=#e1#", "#p7#"};
				--{ 18, 35516, "", "=q3=Sun Touched Satchel", "=ds=#e1#", "=ds="..BabbleBoss["Zone Drop"]..": "..ALIL["Magisters' Terrace"]};
				{ 19, 41599, "", "=q2=Frostweave Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 20, 21342, "", "=q4=Core Felcloth Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 21, 14156, "", "=q3=Bottomless Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 22, 27680, "", "=q3=Halaani Bag", "=ds=#e1#", "=ds="..AL["Halaa"].." "..AL["Vendor"]..": 8 #halaaresearch#"};
				{ 23, 33117, "", "=q3=Jack-o'-Lantern", "=ds=#e1#", "=ds="..AL["World Drop"].." - "..AL["Hallow's End"]};
				{ 24, 21843, "", "=q2=Imbued Netherweave Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 25, 21341, "", "=q3=Felcloth Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 26, 19320, "", "=q3=Gnoll Skin Bandolier", "=ds=#e1#", "#HONOR:50#"};
				{ 27, 19319, "", "=q3=Harpy Hide Quiver", "=ds=#e1#", "#HONOR:50#"};
				{ 28, 11742, "", "=q3=Wayfarer's Knapsack", "=ds=#e1#", "=ds="..BabbleBoss["Ribbly Screwspigot"]..": "..ALIL["Blackrock Depths"]};
				{ 29, 67525, "", "=q2=Bilgewater Satchel", "=ds=#e1#", "=ds="..ALIL["Bilgewater Cartel"].." - "..AL["Revered"]};
				{ 30, 67536, "", "=q2=Darkspear Satchel", "=ds=#e1#", "=ds="..ALIL["Darkspear Trolls"].." - "..AL["Revered"]};
			};
			{
				{ 1, 67526, "", "=q2=Darnassian Satchel", "=ds=#e1#", "=ds="..ALIL["Darnassus"].." - "..AL["Revered"]};
				{ 2, 67527, "", "=q2=Exodar Satchel", "=ds=#e1#", "=ds="..ALIL["Exodar"].." - "..AL["Revered"]};
				{ 3, 67532, "", "=q2=Gilnean Satchel", "=ds=#e1#", "=ds="..ALIL["Gilneas"].." - "..AL["Revered"]};
				{ 4, 67530, "", "=q2=Gnomeregan Satchel", "=ds=#e1#", "=ds="..ALIL["Gnomeregan"].." - "..AL["Revered"]};
				{ 5, 92070, "", "=q2=Huojin Satchel", "=ds=#e1#", "=ds="..ALIL["Huojin Pandaren"].." - "..AL["Revered"]};
				{ 6, 67528, "", "=q2=Ironforge Satchel", "=ds=#e1#", "=ds="..ALIL["Ironforge"].." - "..AL["Revered"]};
				{ 7, 14155, "", "=q2=Mooncloth Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 8, 21841, "", "=q2=Netherweave Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 9, 67533, "", "=q2=Orgrimmar Satchel", "=ds=#e1#", "=ds="..ALIL["Orgrimmar"].." - "..AL["Revered"]};
				{ 10, 20400, "", "=q2=Pumpkin Bag", "=ds=#e1# =q2="..AL["Various Locations"]};
				{ 11, 67535, "", "=q2=Silvermoon Satchel", "=ds=#e1#", "=ds="..ALIL["Silvermoon City"].." - "..AL["Revered"]};
				{ 12, 67531, "", "=q2=Stormwind Satchel", "=ds=#e1#", "=ds="..ALIL["Stormwind"].." - "..AL["Revered"]};
				{ 13, 67534, "", "=q2=Thunder Bluff Satchel", "=ds=#e1#", "=ds="..ALIL["Thunder Bluff"].." - "..AL["Revered"]};
				{ 14, 4500, "", "=q2=Traveler's Backpack", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 15, 92071, "", "=q2=Tushui Satchel", "=ds=#e1#", "=ds="..ALIL["Tushui Pandaren"].." - "..AL["Revered"]};
				{ 16, 67529, "", "=q2=Undercity Satchel", "=ds=#e1#", "=ds="..ALIL["Undercity"].." - "..AL["Revered"]};
				{ 17, 19291, "", "=q1=Darkmoon Storage Box", "=ds=#e1#", "#DARKMOON:1#"};
				{ 18, 30744, "", "=q2=Draenic Leather Pack", "=ds=#e1#", "=ds="..AL["Vendor"]..": 12 #gold#"};
				{ 19, 21340, "", "=q2=Soul Pouch", "=ds=#e1#", "=ds=#p8#"};
				{ 20, 67387, "", "=q1=\"Carriage\" Signature Bag", "=ds=#e1#", "=ds="..ALIL["Stormwind City"].." "..AL["Vendor"]..": 30 #gold#"};
				{ 21, 3914, "", "=q1=Journeyman's Backpack", "=ds=#e1#"};
				{ 22, 14046, "", "=q1=Runecloth Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 23, 60335, "", "=q1=Thick Hide Pack", "=ds=#e1#", "=ds="..AL["Vendor"]..": 12 #gold#"};
				{ 24, 1685, "", "=q1=Troll-Hide Bag", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 25, 4499, "", "=q1=Huge Brown Sack", "=ds=#e1#", "=ds="..AL["Vendor"]..": 10 #gold#"};
				{ 26, 1725, "", "=q1=Large Knapsack", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 27, 10050, "", "=q1=Mageweave Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 28, 10051, "", "=q1=Red Mageweave Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 29, 6446, "", "=q3=Snakeskin Bag", "=ds=#e1#", "=ds="..BabbleBoss["Lady Anacondra"]..": "..ALIL["Wailing Caverns"]};
				{ 30, 5765, "", "=q1=Black Silk Pack", "=ds=#e1#", "=ds=#p8#"};
			};
			{
				--{ 1, 932, "", "=q1=Fel Steed Saddlebags", "=ds=#e1#", "=ds="..AL["Fel Steed"]..": "..ALIL["Shadowfang Keep"]};
				{ 2, 5764, "", "=q1=Green Silk Pack", "=ds=#e1#", "=ds=#p8#"};
				{ 3, 4497, "", "=q1=Heavy Brown Bag", "=ds=#e1#", "=ds="..AL["Vendor"]..": 2 #gold#"};
				{ 4, 804, "", "=q1=Large Blue Sack", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 5, 5576, "", "=q1=Large Brown Sack", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 6, 5575, "", "=q1=Large Green Sack", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 7, 857, "", "=q1=Large Red Sack", "=ds=#e1#", "=ds="..AL["World Drop"]};
				--{ 8, 933, "", "=q1=Large Rucksack", "=ds=#e1#", "=ds="..AL["Foe Reaper 4000"]..": "..ALIL["Westfall"]}; ---rare
				{ 9, 1470, "", "=q1=Murloc Skin Bag", "=ds=#e1#", "=ds="..BabbleBoss["Gelihast"]..": "..ALIL["Blackfathom Deeps"]};
				{ 10, 4245, "", "=q1=Small Silk Pack", "=ds=#e1#", "=ds=#p8#"};
				{ 11, 23852, "", "=q2=Nolkai's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:9561#"};
				{ 12, 57251, "", "=q1=\"Collecting\" Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:147#"};
				{ 13, 856, "", "=q1=Blue Leather Bag", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 14, 4498, "", "=q1=Brown Leather Satchel", "=ds=#e1#", "=ds="..AL["Vendor"]..": 25 #silver#"};
				{ 15, 3343, "", "=q1=Captain Sanders' Booty Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:26356#"};
				{ 16, 60240, "", "=q1=Dream Carrier", "=ds=#e1#", "=q1=#m4#: #QUESTID:483#"};
				{ 17, 56149, "", "=q1=Empty Town-In-A-Box", "=ds=#e1#", "=q1=#m4#: #QUESTID:24671#"};
				--{ 18, 3233, "", "=q1=Gnoll Hide Sack", "=ds=#e1#", "=ds="..AL["Fedfennel"]..": "..ALIL["Elwynn Forest"]}; ---rare
				{ 19, 5573, "", "=q1=Green Leather Bag", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 20, 4241, "", "=q1=Green Woolen Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 21, 57791, "", "=q1=Headsman's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:25046#"};
				{ 22, 57793, "", "=q1=Kodo Saddlebag", "=ds=#e1#", "=q1=#m4#: #QUESTID:24540#"};
				{ 23, 60242, "", "=q1=Kron's New Hunting Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:25193#"};
				{ 24, 73242, "", "=q1=Master's Haversack", "=ds=#e1#", "=q1=#m4#: #QUESTID:29421#"};
				{ 25, 60731, "", "=q1=Message Carrier", "=ds=#e1#", "=q1=#m4#: #QUESTID:26503#"};
				{ 26, 57549, "", "=q1=Prospector's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:25937#"};
				{ 27, 5763, "", "=q1=Red Woolen Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 28, 52039, "", "=q1=Shipwright's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:14404#"};
				{ 29, 5574, "", "=q1=White Leather Bag", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 30, 4240, "", "=q1=Woolen Bag", "=ds=#e1#", "=ds=#p8#"};
			};
			{
				{ 1, 59053, "", "=q1=Airfield Courier Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:26265#"};
				{ 2, 57792, "", "=q1=Bag of Thorns", "=ds=#e1#", "=q1=#m4#: #QUESTID:14460#"};
				{ 3, 56148, "", "=q1=Bank Robber's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:14122#"};
				{ 4, 57542, "", "=q1=Coldridge Mountaineer's Pouch", "=ds=#e1#", "=q1=#m4#: #QUESTID:24492#"};
				{ 5, 22571, "", "=q1=Courier's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:9148#"};
				{ 6, 60241, "", "=q1=Dusty Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:25130#"};
				{ 7, 60239, "", "=q1=Foul Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:488#"};
				{ 8, 57247, "", "=q1=Grape-Picking Sack", "=ds=#e1#", "=q1=#m4#: #QUESTID:26391#"};
				{ 9, 5081, "", "=q1=Kodo Hide Bag", "=ds=#e1#", "=ds=#p7#"};
				{ 10, 4238, "", "=q1=Linen Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 11, 46753, "", "=q1=Melithar's Supply Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:28715#"};
				{ 12, 73241, "", "=q1=Merchant's Satchel", "=ds=#e1#", "=q1=#m4#: #QUESTID:29419#"};
				--{ 13, 4957, "", "=q1=Old Moneybag", "=ds=#e1#", "=ds=#p8#"}; ---no idea from where
				{ 14, 57790, "", "=q1=Pumpkin Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:24976#"};
				{ 15, 5762, "", "=q1=Red Linen Bag", "=ds=#e1#", "=ds=#p8#"};
				{ 16, 52040, "", "=q1=Salvager's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:14094#"};
				{ 17, 60260, "", "=q1=Sea Witch's Bag", "=ds=#e1#", "=q1=#m4#: #QUESTID:24814#"};
				{ 18, 5571, "", "=q1=Small Black Pouch", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 19, 828, "", "=q1=Small Blue Pouch", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 20, 4496, "", "=q1=Small Brown Pouch", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 21, 5572, "", "=q1=Small Green Pouch", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 22, 805, "", "=q1=Small Red Pouch", "=ds=#e1#", "=ds="..AL["World Drop"]};
				{ 23, 23389, "", "=q1=Empty Draenei Supply Pouch", "=ds=#e1#", "=q1=#m4#: #QUESTID:9283#"};
				--{ 24, 56147, "", "=q1=Fatcandle Bag", "=ds=#e1#", "=ds="..AL["Gug Fatcandle"]..": "..ALIL["Elwynn Forest"]}; ---rare
				{ 25, 22976, "", "=q1=Magister's Pouch", "=ds=#e1#", "=q1=#m4#: #QUESTID:9066#"};
				{ 26, 20474, "", "=q1=Sunstrider Book Satchel", "=ds=#e1#", "=q1=#m4#: #QUESTID:8330#"};
				--{ 27, 37606, "", "=q1=Penny Pouch", "=ds=#e1#", "=ds="..AL["Handful of Treats"].." - "..AL["Hallow's End"]}; 
			};
		};
		info = {
			name = "Bags",
			module = moduleName,
		};
	}

		-----------------------
		--- BoE World Epics ---
		-----------------------

	AtlasLoot_Data["WorldEpics85"] = {
		["Normal"] = {
			{
				{ 1, 67134, "", "=q4=Dory's Finery", "=ds=#s4#"};
				{ 2, 67140, "", "=q4=Drape of Inimitable Fate", "=ds=#s4#"};
				{ 3, 67131, "", "=q4=Ritssyn's Ruminous Drape", "=ds=#s4#"};
				{ 4, 67142, "", "=q4=Zom's Electrostatic Cloak", "=ds=#s4#"};
				{ 5, 67147, "", "=q4=Je'Tze's Sparkling Tiara", "=ds=#s1#, #a1#"};
				{ 6, 67133, "", "=q4=Dizze's Whirling Robe", "=ds=#s5#, #a1#"};
				{ 7, 67132, "", "=q4=Grips of the Failed Immortal", "=ds=#s9#, #a1#"};
				{ 8, 67146, "", "=q4=Woundsplicer Handwraps", "=ds=#s9#, #a1#"};
				{ 9, 67135, "", "=q4=Morrie's Waywalker Wrap", "=ds=#s5#, #a2#"};
				{ 10, 67150, "", "=q4=Arrowsinger Legguards", "=ds=#s11#, #a3#"};
				{ 11, 67148, "", "=q4=Kilt of Trollish Dreams", "=ds=#s11#, #a3#"};
				{ 12, 67144, "", "=q4=Pauldrons of Edward the Odd", "=ds=#s3#, #a4#"};
				{ 13, 67143, "", "=q4=Icebone Hauberk", "=ds=#s5#, #a4#"};
				{ 14, 67141, "", "=q4=Corefire Legplates", "=ds=#s11#, #a4#"};
				{ 16, 67138, "", "=q4=Buc-Zakai Choker", "=ds=#s2#"};
				{ 17, 67137, "", "=q4=Don Rodrigo's Fabulous Necklace", "=ds=#s2#"};
				{ 18, 67130, "", "=q4=Dorian's Lost Necklace", "=ds=#s2#"};
				{ 20, 67139, "", "=q4=Blauvelt's Family Crest", "=ds=#s13#"};
				{ 21, 67136, "", "=q4=Gilnean Ring of Ruination", "=ds=#s13#"};
				{ 22, 67129, "", "=q4=Signet of High Arcanist Savor", "=ds=#s13#"};
				{ 24, 67145, "", "=q4=Blockade's Lost Shield", "=ds=#w8#"};
				{ 25, 67149, "", "=q4=Heartbound Tome", "=ds=#s15#"};
				{ 27, 0, "inv_box_03", "=q6="..ALIL["Flame-Scarred Junkbox"], "=q1=#p28#"};
				{ 28, 68163, "", "=q4=The Twilight Blade", "=ds=#h1#, #w4#"};
				{ 29, 68161, "", "=q4=Krol Decapitator", "=ds=#h1#, #w10#"};
			};
		};
		info = {
			name = AL["BoE World Epics"].." "..AL["Level 85"],
			module = moduleName, menu = "WORLDEPICS", instance = "WorldEpics",
		};
	}

		----------------------------
		--- Justice Points Items ---
		----------------------------

	AtlasLoot_Data["JusticePoints"] = {
		["Normal"] = {
			{
				{ 1, 77147, "", "=q4=Hood of Hidden Flesh", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
				{ 2, 77122, "", "=q4=Robes of Searing Shadow", "=ds=#s5#, #a1#", "#JUSTICE:2200#" },
				{ 3, 77324, "", "=q4=Chronoboost Bracers", "=ds=#s8#, #a1#", "#JUSTICE:1250#" },
				{ 4, 77159, "", "=q4=Clockwinder's Immaculate Gloves", "=ds=#s9#, #a1#", "#JUSTICE:1650#" },
				{ 5, 77179, "", "=q4=Tentacular Belt", "=ds=#s10#, #a1#", "#JUSTICE:1650#" },
				{ 6, 77176, "", "=q4=Kavan's Forsaken Treads", "=ds=#s12#, #a1#", "#JUSTICE:1650#" },
				{ 8, 58155, "", "=q3=Cowl of Pleasant Gloom", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
				{ 9, 58157, "", "=q3=Meadow Mantle", "=ds=#s3#, #a1#", "#JUSTICE:1650#" },
				{ 10, 58153, "", "=q3=Robes of Embalmed Darkness", "=ds=#s5#, #a1#", "#JUSTICE:2200#" },
				{ 11, 71265, "", "=q4=Emberflame Bracers", "=ds=#s8#, #a1#", "#JUSTICE:1250#" },
				{ 12, 58158, "", "=q3=Gloves of the Painless Midnight", "=ds=#s9#, #a1#", "#JUSTICE:1650#" },
				{ 13, 57921, "", "=q3=Incense Infused Cummerbund", "=ds=#s10#, #a1#", "#JUSTICE:1650#" },
				{ 14, 58154, "", "=q3=Pensive Legwraps", "=ds=#s11#, #a1#", "#JUSTICE:2200#" },
				{ 15, 58485, "", "=q4=Melodious Slippers", "=ds=#s12#, #a1#", "#JUSTICE:1650#" },
				{ 16, 77146, "", "=q4=Soulgaze Cowl", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
				{ 17, 77121, "", "=q4=Lightwarper Vestments", "=ds=#s5#, #a1#", "#JUSTICE:2200#" },
				{ 18, 77323, "", "=q4=Bracers of the Black Dream", "=ds=#s8#, #a1#", "#JUSTICE:1250#" },
				{ 19, 77157, "", "=q4=The Hands of Gilly", "=ds=#s9#, #a1#", "#JUSTICE:1650#" },
				{ 20, 77187, "", "=q4=Vestal's Irrepressible Girdle", "=ds=#s10#, #a1#", "#JUSTICE:1650#" },
				{ 21, 77177, "", "=q4=Splinterfoot Sandals", "=ds=#s12#, #a1#", "#JUSTICE:1650#" },
				{ 23, 58161, "", "=q3=Mask of New Snow", "=ds=#s1#, #a1#", "#JUSTICE:2200#" },
				{ 24, 58162, "", "=q3=Summer Song Shoulderwraps", "=ds=#s3#, #a1#", "#JUSTICE:1650#" },
				{ 25, 58159, "", "=q3=Musk Rose Robes", "=ds=#s5#, #a1#", "#JUSTICE:2200#" },
				{ 26, 71266, "", "=q4=Firesoul Wristguards", "=ds=#s8#, #a1#", "#JUSTICE:1250#" },
				{ 27, 58163, "", "=q3=Gloves of Purification", "=ds=#s9#, #a1#", "#JUSTICE:1650#" },
				{ 28, 57922, "", "=q3=Belt of the Falling Rain", "=ds=#s10#, #a1#", "#JUSTICE:1650#" },
				{ 29, 58160, "", "=q3=Leggings of Charity", "=ds=#s11#, #a1#", "#JUSTICE:2200#" },
				{ 30, 58486, "", "=q4=Slippers of Moving Waters", "=ds=#s12#, #a1#", "#JUSTICE:1650#" },
				extraText = ": "..BabbleInventory["Cloth"];
			};
			{
				{ 1, 77149, "", "=q4=Helmet of Perpetual Rebirth", "=ds=#s1#, #a2#", "#JUSTICE:2200#" },
				{ 2, 77127, "", "=q4=Decaying Herbalist's Robes", "=ds=#s5#, #a2#", "#JUSTICE:2200#" },
				{ 3, 77320, "", "=q4=Luminescent Bracers", "=ds=#s8#, #a2#", "#JUSTICE:1250#" },
				{ 4, 77160, "", "=q4=Fungus-Born Gloves", "=ds=#s9#, #a2#", "#JUSTICE:1650#" },
				{ 5, 77181, "", "=q4=Belt of Universal Curing", "=ds=#s10#, #a2#", "#JUSTICE:1650#" },
				{ 6, 77172, "", "=q4=Boots of Fungoid Growth", "=ds=#s12#, #a2#", "#JUSTICE:1650#" },
				{ 8, 58150, "", "=q3=Cluster of Stars", "=ds=#s1#, #a2#", "#JUSTICE:2200#" },
				{ 9, 58151, "", "=q3=Somber Shawl", "=ds=#s3#, #a2#", "#JUSTICE:1650#" },
				{ 10, 58139, "", "=q3=Chestguard of Forgetfulness", "=ds=#s5#, #a2#", "#JUSTICE:2200#" },
				{ 11, 71262, "", "=q4=Smolderskull Bindings", "=ds=#s8#, #a2#", "#JUSTICE:1250#" },
				{ 12, 58152, "", "=q3=Blessed Hands of Elune", "=ds=#s9#, #a2#", "#JUSTICE:1650#" },
				{ 13, 57919, "", "=q3=Thatch Eave Vines", "=ds=#s10#, #a2#", "#JUSTICE:1650#" },
				{ 14, 58140, "", "=q3=Leggings of Late Blooms", "=ds=#s11#, #a2#", "#JUSTICE:2200#" },
				{ 15, 58484, "", "=q4=Fading Violet Sandals", "=ds=#s12#, #a2#", "#JUSTICE:1650#" },
				{ 16, 77148, "", "=q4=Nocturnal Gaze", "=ds=#s1#, #a2#", "#JUSTICE:2200#" },
				{ 17, 77126, "", "=q4=Shadowbinder Chestguard", "=ds=#s5#, #a2#", "#JUSTICE:2200#" },
				{ 18, 77322, "", "=q4=Bracers of Manifold Pockets", "=ds=#s8#, #a2#", "#JUSTICE:1250#" },
				{ 19, 77161, "", "=q4=Lightfinger Handwraps", "=ds=#s9#, #a2#", "#JUSTICE:1650#" },
				{ 20, 77180, "", "=q4=Belt of Hidden Keys", "=ds=#s10#, #a2#", "#JUSTICE:1650#" },
				{ 21, 77173, "", "=q4=Rooftop Griptoes", "=ds=#s12#, #a2#", "#JUSTICE:1650#" },
				{ 23, 58133, "", "=q3=Mask of Vines", "=ds=#s1#, #a2#", "#JUSTICE:2200#" },
				{ 24, 58134, "", "=q3=Embrace of the Night", "=ds=#s3#, #a2#", "#JUSTICE:1650#" },
				{ 25, 58131, "", "=q3=Tunic of Sinking Envy", "=ds=#s5#, #a2#", "#JUSTICE:2200#" },
				{ 26, 71130, "", "=q4=Flamebinder Bracers", "=ds=#s8#, #a2#", "#JUSTICE:1250#" },
				{ 27, 58138, "", "=q3=Sticky Fingers", "=ds=#s9#, #a2#", "#JUSTICE:1650#" },
				{ 28, 57918, "", "=q3=Sash of Musing", "=ds=#s10#, #a2#", "#JUSTICE:1650#" },
				{ 29, 58132, "", "=q3=Leggings of the Burrowing Mole", "=ds=#s11#, #a2#", "#JUSTICE:2200#" },
				{ 30, 58482, "", "=q4=Treads of Fleeting Joy", "=ds=#s12#, #a2#", "#JUSTICE:1650#" },
				extraText = ": "..BabbleInventory["Leather"];
			};
			{
				{ 1, 77151, "", "=q4=Wolfdream Circlet", "=ds=#s1#, #a3#", "#JUSTICE:2200#" },
				{ 2, 77125, "", "=q4=Ghostworld Chestguard", "=ds=#s5#, #a3#", "#JUSTICE:2200#" },
				{ 3, 77319, "", "=q4=Bracers of the Spectral Wolf", "=ds=#s8#, #a3#", "#JUSTICE:1250#" },
				{ 4, 77163, "", "=q4=Gloves of Ghostly Dreams", "=ds=#s9#, #a3#", "#JUSTICE:1650#" },
				{ 5, 77183, "", "=q4=Girdle of Shamanic Fury", "=ds=#s10#, #a3#", "#JUSTICE:1650#" },
				{ 6, 77174, "", "=q4=Sabatons of the Graceful Spirit", "=ds=#s12#, #a3#", "#JUSTICE:1650#" },
				{ 8, 58128, "", "=q3=Helm of the Inward Eye", "=ds=#s1#, #a3#", "#JUSTICE:2200#" },
				{ 9, 58129, "", "=q3=Seafoam Mantle", "=ds=#s3#, #a3#", "#JUSTICE:1650#" },
				{ 10, 58126, "", "=q3=Vest of the Waking Dream", "=ds=#s5#, #a3#", "#JUSTICE:2200#" },
				{ 11, 71263, "", "=q4=Bracers of Misting Ash", "=ds=#s8#, #a3#", "#JUSTICE:1250#" },
				{ 12, 58130, "", "=q3=Gleaning Gloves", "=ds=#s9#, #a3#", "#JUSTICE:1650#" },
				{ 13, 57917, "", "=q3=Belt of the Still Stream", "=ds=#s10#, #a3#", "#JUSTICE:1650#" },
				{ 14, 58127, "", "=q3=Leggings of Soothing Silence", "=ds=#s11#, #a3#", "#JUSTICE:2200#" },
				{ 15, 58481, "", "=q4=Boots of the Perilous Seas", "=ds=#s12#, #a3#", "#JUSTICE:1650#" },
				{ 16, 77150, "", "=q4=Zeherah's Dragonskull Crown", "=ds=#s1#, #a3#", "#JUSTICE:2200#" },
				{ 17, 77124, "", "=q4=Dragonflayer Vest", "=ds=#s5#, #a3#", "#JUSTICE:2200#" },
				{ 18, 77321, "", "=q4=Dragonbelly Bracers", "=ds=#s8#, #a3#", "#JUSTICE:1250#" },
				{ 19, 77162, "", "=q4=Arrowflick Gauntlets", "=ds=#s9#, #a3#", "#JUSTICE:1650#" },
				{ 20, 77182, "", "=q4=Cord of Dragon Sinew", "=ds=#s10#, #a3#", "#JUSTICE:1650#" },
				{ 21, 77175, "", "=q4=Boneshard Boots", "=ds=#s12#, #a3#", "#JUSTICE:1650#" },
				{ 23, 58123, "", "=q3=Willow Mask", "=ds=#s1#, #a3#", "#JUSTICE:2200#" },
				{ 24, 58124, "", "=q3=Wrap of the Valley Glades", "=ds=#s3#, #a3#", "#JUSTICE:1650#" },
				{ 25, 58121, "", "=q3=Vest of the True Companion", "=ds=#s5#, #a3#", "#JUSTICE:2200#" },
				{ 26, 71264, "", "=q4=Bracers of Forked Lightning", "=ds=#s8#, #a3#", "#JUSTICE:1250#" },
				{ 27, 58125, "", "=q3=Gloves of the Passing Night", "=ds=#s9#, #a3#", "#JUSTICE:1650#" },
				{ 28, 57916, "", "=q3=Belt of the Dim Forest", "=ds=#s10#, #a3#", "#JUSTICE:1650#" },
				{ 29, 58122, "", "=q3=Hillside Striders", "=ds=#s11#, #a3#", "#JUSTICE:2200#" },
				{ 30, 58199, "", "=q4=Moccasins of Verdurous Glooms", "=ds=#s12#, #a3#", "#JUSTICE:1650#" },
				extraText = ": "..BabbleInventory["Mail"];
			};
			{
				{ 1, 77153, "", "=q4=Glowing Wings of Hope", "=ds=#s1#, #a4#", "#JUSTICE:2200#" },
				{ 2, 77123, "", "=q4=Shining Carapace of Glory", "=ds=#s5#, #a4#", "#JUSTICE:2200#" },
				{ 3, 77316, "", "=q4=Flashing Bracers of Warmth", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 4, 77164, "", "=q4=Gleaming Grips of Mending", "=ds=#s9#, #a4#", "#JUSTICE:1650#" },
				{ 5, 77184, "", "=q4=Blinding Girdle of Truth", "=ds=#s10#, #a4#", "#JUSTICE:1650#" },
				{ 6, 77169, "", "=q4=Silver Sabatons of Fury", "=ds=#s12#, #a4#", "#JUSTICE:1650#" },
				{ 8, 58108, "", "=q3=Crown of the Blazing Sun", "=ds=#s1#, #a4#", "#JUSTICE:2200#" },
				{ 9, 58109, "", "=q3=Pauldrons of the Forlorn", "=ds=#s3#, #a4#", "#JUSTICE:1650#" },
				{ 10, 58106, "", "=q3=Chestguard of Dancing Waves", "=ds=#s5#, #a4#", "#JUSTICE:2200#" },
				{ 11, 71260, "", "=q4=Bracers of Imperious Truths", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 12, 58110, "", "=q3=Gloves of Curious Conscience", "=ds=#s9#, #a4#", "#JUSTICE:1650#" },
				{ 13, 57915, "", "=q3=Belt of Barred Clouds", "=ds=#s10#, #a4#", "#JUSTICE:1650#" },
				{ 14, 58107, "", "=q3=Legguards of the Gentle", "=ds=#s11#, #a4#", "#JUSTICE:2200#" },
				{ 15, 58198, "", "=q4=Eternal Pathfinders", "=ds=#s12#, #a4#", "#JUSTICE:1650#" },
				{ 16, 77155, "", "=q4=Visage of Petrification", "=ds=#s1#, #a4#", "#JUSTICE:2200#" },
				{ 17, 77119, "", "=q4=Bones of the Damned", "=ds=#s5#, #a4#", "#JUSTICE:2200#" },
				{ 18, 77317, "", "=q4=Heartcrusher Wristplates", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 19, 77165, "", "=q4=Grimfist Crushers", "=ds=#s9#, #a4#", "#JUSTICE:1650#" },
				{ 20, 77185, "", "=q4=Demonbone Waistguard", "=ds=#s10#, #a4#", "#JUSTICE:1650#" },
				{ 21, 77170, "", "=q4=Kneebreaker Boots", "=ds=#s12#, #a4#", "#JUSTICE:1650#" },
				{ 23, 58098, "", "=q3=Helm of Easeful Death", "=ds=#s1#, #a4#", "#JUSTICE:2200#" },
				{ 24, 58100, "", "=q3=Pauldrons of the High Requiem", "=ds=#s3#, #a4#", "#JUSTICE:1650#" },
				{ 25, 58096, "", "=q3=Breastplate of Raging Fury", "=ds=#s5#, #a4#", "#JUSTICE:2200#" },
				{ 26, 71261, "", "=q4=Gigantiform Bracers", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 27, 58099, "", "=q3=Reaping Gauntlets", "=ds=#s9#, #a4#", "#JUSTICE:1650#" },
				{ 28, 57913, "", "=q3=Beech Green Belt", "=ds=#s10#, #a4#", "#JUSTICE:1650#" },
				{ 29, 58097, "", "=q3=Greaves of Gallantry", "=ds=#s11#, #a4#", "#JUSTICE:2200#" },
				{ 30, 58195, "", "=q4=Woe Breeder's Boots", "=ds=#s12#, #a4#", "#JUSTICE:1650#" },
				extraText = ": "..BabbleInventory["Plate"];
			};
			{
				{ 2, 77156, "", "=q4=Jaw of Repudiation", "=ds=#s1#, #a4#", "#JUSTICE:2200#" },
				{ 3, 77120, "", "=q4=Chestplate of the Unshakable Titan", "=ds=#s5#, #a4#", "#JUSTICE:2200#" },
 				{ 4, 77318, "", "=q4=Bracers of Unrelenting Excellence", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 5, 77166, "", "=q4=Gauntlets of Feathery Blows", "=ds=#s9#, #a4#", "#JUSTICE:1650#" },
				{ 6, 77186, "", "=q4=Forgesmelter Waistplate", "=ds=#s10#, #a4#", "#JUSTICE:1650#" },
				{ 7, 77171, "", "=q4=Bladeshatter Treads", "=ds=#s12#, #a4#", "#JUSTICE:1650#" },
				{ 17, 58103, "", "=q3=Helm of the Proud", "=ds=#s1#, #a4#", "#JUSTICE:2200#" },
				{ 18, 58104, "", "=q3=Sunburnt Pauldrons", "=ds=#s3#, #a4#", "#JUSTICE:1650#" },
				{ 19, 58101, "", "=q3=Chestplate of the Steadfast", "=ds=#s5#, #a4#", "#JUSTICE:2200#" },
				{ 20, 70937, "", "=q4=Bracers of Regal Force", "=ds=#s8#, #a4#", "#JUSTICE:1250#" },
				{ 21, 58105, "", "=q3=Numbing Handguards", "=ds=#s9#, #a4#", "#JUSTICE:1650#" },
				{ 22, 57914, "", "=q3=Girdle of the Mountains", "=ds=#s10#, #a4#", "#JUSTICE:1650#" },
				{ 23, 58102, "", "=q3=Greaves of Splendor", "=ds=#s11#, #a4#", "#JUSTICE:2200#" },
				{ 24, 58197, "", "=q4=Rock Furrow Boots", "=ds=#s12#, #a4#", "#JUSTICE:1650#" },
				extraText = ": "..BabbleInventory["Plate"];
			};
			{
				{ 2, 77095, "", "=q4=Batwing Cloak", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 3, 77097, "", "=q4=Dreamcrusher Drape", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 4, 77099, "", "=q4=Indefatigable Greatcloak", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 5, 77098, "", "=q4=Nanoprecise Cape", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 6, 77096, "", "=q4=Woundlicker Cover", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 8, 58190, "", "=q4=Floating Web", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 9, 58192, "", "=q4=Gray Hair Cloak", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 10, 58193, "", "=q4=Haunt of Flies", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 11, 58194, "", "=q4=Heavenly Breeze", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 12, 58191, "", "=q4=Viewless Wings", "=ds=#s4#", "#JUSTICE:1250#" },
				{ 17, 77114, "", "=q4=Bottled Wishes", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 18, 77117, "", "=q4=Fire of the Deep", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 19, 77113, "", "=q4=Kiroptyric Sigil", "=ds=#s14#", "#JUSTICE:1650#" },
 				{ 20, 77115, "", "=q4=Reflection of the Light", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 21, 77116, "", "=q4=Rotting Skull", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 23, 58184, "", "=q4=Core of Ripeness", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 24, 58182, "", "=q4=Bedrock Talisman", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 25, 58181, "", "=q4=Fluid Death", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 26, 58180, "", "=q4=License to Slay", "=ds=#s14#", "#JUSTICE:1650#" },
				{ 27, 58183, "", "=q4=Soul Casket", "=ds=#s14#", "#JUSTICE:1650#" },
				extraText = ": "..AL["Accessories"];
			};
			{
				{ 1, 77091, "", "=q4=Cameo of Terrible Memories", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 2, 77092, "", "=q4=Guardspike Choker", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 3, 77090, "", "=q4=Necklace of Black Dragon's Teeth", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 4, 77088, "", "=q4=Opal of the Secret Order", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 5, 77089, "", "=q4=Threadlinked Chain", "=ds=#s2#", "#JUSTICE:1250#" },
	  			{ 6, 71213, "", "=q4=Amulet of Burning Brilliance", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 7, 71214, "", "=q4=Firemind Pendant", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 8, 71129, "", "=q4=Necklace of Smoke Signals", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 9, 71212, "", "=q4=Stoneheart Choker", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 10, 70935, "", "=q4=Stoneheart Necklace", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 11, 57931, "", "=q3=Amulet of Dull Dreaming", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 12, 57934, "", "=q3=Celadon Pendant", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 13, 57930, "", "=q3=Pendant of Quiet Breath", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 14, 57933, "", "=q3=String of Beaded Bubbles", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 15, 57932, "", "=q3=The Lustrous Eye", "=ds=#s2#", "#JUSTICE:1250#" },
				{ 16, 77109, "", "=q4=Band of Reconstruction", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 17, 77111, "", "=q4=Emergency Descent Loop", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 18, 77110, "", "=q4=Ring of Torn Flesh", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 19, 77108, "", "=q4=Seal of the Grand Architect", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 20, 77112, "", "=q4=Signet of the Resolute", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 21, 71210, "", "=q4=Crystalline Brimstone Ring", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 22, 70940, "", "=q4=Deflecting Brimstone Band", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 23, 71208, "", "=q4=Serrated Brimstone Signet", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 24, 71211, "", "=q4=Soothing Brimstone Circle", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 25, 71209, "", "=q4=Splintered Brimstone Seal", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 26, 58185, "", "=q4=Band of Bees", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 27, 58188, "", "=q4=Band of Secret Names", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 28, 68812, "", "=q4=Hornet-Sting Band", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 29, 58187, "", "=q4=Ring of the Battle Anthem", "=ds=#s13#", "#JUSTICE:1250#" },
				{ 30, 58189, "", "=q4=Twined Band of Flowers", "=ds=#s13#", "#JUSTICE:1250#" },
				extraText = ": "..AL["Accessories"];
			};
			{
				{ 2, 77079, "", "=q4=Hungermouth Wand", "=ds=#w12#", "#JUSTICE:700#" },
				{ 3, 77078, "", "=q4=Scintillating Rods", "=ds=#w12#", "#JUSTICE:700#" },
				{ 5, 71150, "", "=q4=Scorchvine Wand", "=ds=#w12#", "#JUSTICE:700#" },
				{ 6, 71151, "", "=q4=Trail of Embers", "=ds=#w12#", "#JUSTICE:700#" },
				{ 8, 57924, "", "=q3=Apple-Bent Bough", "=ds=#s15#", "#JUSTICE:950#" },
				{ 9, 57923, "", "=q3=Hermit's Lamp", "=ds=#s15#", "#JUSTICE:950#" },
				{ 17, 57929, "", "=q3=Dawnblaze Blade", "=ds=#h4#, #w10#", "#JUSTICE:950#" },
				{ 18, 57928, "", "=q3=Windslicer", "=ds=#h4#, #w1#", "#JUSTICE:950#" },
				{ 19, 57927, "", "=q3=Throat Slasher", "=ds=#h4#, #w4#", "#JUSTICE:950#" },
				{ 20, 57926, "", "=q3=Shield of the Four Grey Towers", "=ds=#w8#", "#JUSTICE:950#" },
				{ 21, 57925, "", "=q3=Shield of the Mists", "=ds=#w8#", "#JUSTICE:950#" },
				extraText = ": "..AL["Weapons"];
			};
		};
		info = {
			name = AL["Justice Points"],
			module = moduleName, menu = "JPCATAMENU",
		};
	}

		--------------------
		--- Molten Front ---
		--------------------

	AtlasLoot_Data["MoltenFront"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Zen'Vorka"], ""};
				{ 2, 70108, "", "=q4=Pyrelord Greaves", "=ds=#s12#, #a4#"};
				{ 3, 70105, "", "=q4=Matoclaw's Band", "=ds=#s13#"};
				{ 17, 70107, "", "=q4=Fireheart Necklace", "=ds=#s2#"};
				{ 18, 70106, "", "=q4=Nightweaver's Amulet", "=ds=#s2#"};
				{ 5, 71087, "", "=q2=Gilneas Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 6, 70145, "", "=q2=Darnassus Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 7, 70146, "", "=q2=Exodar Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 8, 70147, "", "=q2=Gnomeregan Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 9, 70148, "", "=q2=Ironforge Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 10, 70152, "", "=q2=Stormwind Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 12, 71631, "", "=q2=Zen'Vorka's Cache", "=ds=", "#WORLDTREE:30#"};
				{ 20, 71088, "", "=q2=Bilgewater Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 21, 70149, "", "=q2=Orgrimmar Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 22, 70154, "", "=q2=Undercity Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 23, 70153, "", "=q2=Thunder Bluff Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 24, 70150, "", "=q2=Sen'jin Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
				{ 25, 70151, "", "=q2=Silvermoon Writ of Commendation", "=ds=", "#WORLDTREE:30#"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Ayla Shadowstorm"], "=q1=#m4#: #QUESTID:29279#"};
				{ 2, 70110, "", "=q4=Band of Glittering Lights", "=ds=#s13#"};
				{ 3, 70113, "", "=q4=Moon Blessed Band", "=ds=#s13#"};
				{ 4, 70142, "", "=q4=Moonwell Chalice", "=ds=#s14#"};
				{ 5, 70143, "", "=q4=Moonwell Phial", "=ds=#s14#"};
				{ 6, 70112, "", "=q4=Globe of Moonlight", "=ds=#s15#"};
				{ 7, 70175, "", "=q3=Pattern: Triple-Reinforced Mining Bag", "=ds=#p7# (500)"},
				{ 8, 70174, "", "=q3=Pattern: Royal Scribe's Satchel", "=ds=#p7# (510)"},
				{ 9, 70176, "", "=q3=Pattern: Luxurious Silk Gem Bag", "=ds=#p8# (515)"},
				{ 10, 70160, "", "=q3=Crimson Lasher", "=ds=#e13#"},
				{ 11, 70161, "", "=q3=Mushroom Chair", "=ds=#m20#"},
				{ 16, 0, "INV_Box_01", "=q6="..AL["Varlan Highbough"], "=q1=#m4#: #QUESTID:29283#"};
				{ 17, 70122, "", "=q4=Aviana's Grips", "=ds=#s9#, #a2#"};		
				{ 18, 70123, "", "=q4=Lancer's Greaves", "=ds=#s12#, #a3#"};
				{ 19, 70127, "", "=q4=Lylagar Horn Ring", "=ds=#s13#"};
				{ 20, 70126, "", "=q4=Nemesis Shell Band", "=ds=#s13#"};
				{ 21, 70124, "", "=q4=Spirit Fragment Band", "=ds=#s13#"};
				{ 22, 70141, "", "=q4=Dwyer's Caber", "=ds=#s14#"};
				{ 23, 70140, "", "=q3=Hyjal Bear Cub", "=ds=#e13#"},
				{ 24, 70159, "", "=q3=Mylune's Call", "=ds=#m20#"},
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Damek Bloombeard"], "=q1=#m4#: #QUESTID:29281#"};
				{ 2, 70118, "", "=q4=Widow's Clutches", "=ds=#s9#, #a1#"};
				{ 3, 70114, "", "=q4=Fireplume Girdle", "=ds=#s10#, #a2#"};
				{ 4, 70115, "", "=q4=Fiery Treads", "=ds=#s12#, #a3#"};
				{ 5, 70121, "", "=q4=Ricket's Gun Show", "=ds=#s8#, #a4#"};
				{ 6, 70116, "", "=q4=Gauntlets of Living Obsidium", "=ds=#s9#, #a4#"};
				{ 7, 70117, "", "=q4=Belt of Living Obsidium", "=ds=#s10#, #a4#"};
				{ 8, 70120, "", "=q4=Rickety Belt", "=ds=#s10#, #a4#"};
				{ 9, 70119, "", "=q4=Meteorite Ring", "=ds=#s13#"};
				{ 10, 70144, "", "=q4=Ricket's Magnetic Fireball", "=ds=#s14#"};
				{ 17, 70166, "", "=q3=Plans: Brainsplinter", "=ds=#p2# (525)"};
				{ 18, 70169, "", "=q3=Plans: Elementium-Edged Scalper", "=ds=#p2# (525)"};
				{ 19, 70168, "", "=q3=Plans: Lightforged Elementium Hammer", "=ds=#p2# (525)"};
				{ 20, 70172, "", "=q3=Plans: Masterwork Elementium Deathblade", "=ds=#p2# (525)"};
				{ 21, 70167, "", "=q3=Plans: Masterwork Elementium Spellblade", "=ds=#p2# (525)"};
				{ 22, 70170, "", "=q3=Plans: Pyrium Spellward", "=ds=#p2# (525)"};
				{ 23, 70171, "", "=q3=Plans: Unbreakable Guardian", "=ds=#p2# (525)"};
				{ 24, 70173, "", "=q3=Plans: Witch-Hunter's Harvester", "=ds=#p2# (525)"};
				{ 25, 70177, "", "=q3=Schematic: Flintlocke's Woodchucker", "=ds=#p5# (515)"};
				{ 26, 71078, "", "=q3=Schematic: Extreme-Impact Hole Puncher", "=ds=#p5# (525)"};
			};
		};
		info = {
			name = ALIL["Molten Front"].." - "..AL["Rewards"],
			module = moduleName, menu = "SETMENU",
		};
	}