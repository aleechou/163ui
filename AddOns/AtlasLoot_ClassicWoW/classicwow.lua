-- $Id: classicwow.lua 4212 2013-05-20 12:27:56Z dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleRare = AtlasLoot_GetLocaleLibBabble("LibBabble-Rare-3.0")
local moduleName = "AtlasLootClassicWoW"

-- Index
--- Dungeons & Raids
---- Keys
---- AQ Enchants
---- Ahn'Qiraj: The Ruins of Ahn'Qiraj
---- Ahn'Qiraj: The Temple of Ahn'Qiraj
---- Blackfathom Deeps
---- Blackrock Mountain: Blackrock Depths
---- Blackrock Mountain: Entrance
---- Blackrock Mountain: Lower Blackrock Spire
---- Blackrock Mountain: Upper Blackrock Spire
---- Blackrock Mountain: Blackwing Lair
---- Blackrock Mountain: Molten Core
---- Dire Maul Books
---- Dire Maul East
---- Dire Maul North
---- Dire Maul West
---- Gnomeregan
---- Maraudon
---- Ragefire Chasm
---- Razorfen Downs
---- Razorfen Kraul
---- Scarlet Halls
---- Scarlet Monastery
---- Scholomance
---- Shadowfang Keep
---- Stratholme - Crusader's Square
---- Stratholme - The Gauntlet
---- The Deadmines
---- The Stockade
---- The Sunken Temple
---- Uldaman
---- Wailing Caverns
---- Zul'Farrak
--- Sets & Collections
---- Dungeon 1 and 2 Sets (D1/D2)
---- Tier 1/2 Sets (T1/T2)
---- Tier 3 Sets (T3)
---- Vanilla WoW Sets
---- ZG Sets
---- AQ20 Sets
---- AQ40 Sets
---- BoE World Epics
--- PvP
---- Alterac Valley
---- Arathi Basin
---- Warsong Gulch
---- PvP Level 60 Rare and Epic Sets
---- PvP Level 60 Weapons
---- PvP Level 60 Accessories
--- Factions
---- Misc
---- Argent Dawn
---- Bloodsail Buccaneers
---- Bilgewater Cartel
---- Brood of Nozdormu
---- Cenarion Circle
---- Darnassus
---- Darkspear Trolls
---- Exodar
---- Gilneas
---- Gnomeregan
---- Huojin Pandaren
---- Ironforge
---- Orgrimmar
---- Silvermoon City
---- Stormwind
---- Thorium Brotherhood
---- Thunder Bluff
---- Timbermaw Hold
---- Tushui Pandaren
---- Undercity

	------------------------
	--- Dungeons & Raids ---
	------------------------

		------------
		--- Keys ---
		------------

	AtlasLoot_Data["OldKeys"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#m20#", ""};
				{ 2, 13523, "", "=q1=Blood of Innocents", "=ds=#m27#"};
				{ 3, 18746, "", "=q1=Divination Scryer", "=ds=#m27#"};
				{ 4, 18663, "", "=q1=J'eevee's Jar", "=ds=#m27#"};
			};
		};
		info = {
			name = AL["Keys"],
			module = moduleName, NextPrevDisable = true,
		};
	};

		-------------------
		--- AQ Enchants ---
		-------------------

	AtlasLoot_Data["AQEnchants"] = {
		["Normal"] = {
			{
				{ 1, 20728, "", "=q3=Formula: Enchant Gloves - Frost Power", "=ds=#p4# (300)"};
				{ 2, 20731, "", "=q3=Formula: Enchant Gloves - Superior Agility", "=ds=#p4# (300)"};
				{ 3, 20734, "", "=q3=Formula: Enchant Cloak - Stealth", "=ds=#p4# (300)"};
				{ 4, 20729, "", "=q3=Formula: Enchant Gloves - Fire Power", "=ds=#p4# (300)"};
				{ 5, 20736, "", "=q3=Formula: Enchant Cloak - Dodge", "=ds=#p4# (300)"};
				{ 6, 20730, "", "=q3=Formula: Enchant Gloves - Healing Power", "=ds=#p4# (300)"};
				{ 7, 20727, "", "=q3=Formula: Enchant Gloves - Shadow Power", "=ds=#p4# (300)"};
			};
		};
		info = {
			name = AL["AQ Enchants"],
			module = moduleName, NextPrevDisable = true,
		};
	};

		-----------------------------------------
		--- Ahn'Qiraj: The Ruins of Ahn'Qiraj ---
		-----------------------------------------

	AtlasLoot_Data["AQ20Kurinnaxx"] = {
		["Normal"] = {
			{
				{ 1, 21499, "", "=q4=Vestments of the Shifting Sands", "=ds=#s5#, #a1#", "", "7.34%"};
				{ 2, 21498, "", "=q4=Qiraji Sacrificial Dagger", "=ds=#h1#, #w4#", "", "7.53%"};
				{ 4, 21500, "", "=q3=Belt of the Inquisition", "=ds=#s10#, #a1#", "", "14.84%"};
				{ 5, 21501, "", "=q3=Toughened Silithid Hide Gloves", "=ds=#s9#, #a2#", "", "12.91%"};
				{ 6, 21502, "", "=q3=Sand Reaver Wristguards", "=ds=#s8#, #a3#", "", "13.79%"};
				{ 7, 21503, "", "=q3=Belt of the Sand Reaver", "=ds=#s10#, #a4#", "", "14.38%"};
				{ 9, 22217, "", "=q1=Kurinnaxx's Venom Sac", "=ds=#m3#", "", "100%"};
				{ 16, 20889, "", "=q3=Qiraji Regal Drape", "#m3#", "", "30.83%"};
				{ 17, 20885, "", "=q3=Qiraji Martial Drape", "#m3#", "", "30.25%"};
				{ 18, 20884, "", "=q3=Qiraji Magisterial Ring", "#m3#", "", "7.98%"};
				{ 19, 20888, "", "=q3=Qiraji Ceremonial Ring", "#m3#", "", "7.80%"};
			};
		};
		info = {
			name = BabbleBoss["Kurinnaxx"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ20Rajaxx"] = {
		["Normal"] = {
			{
				{ 1, 21493, "", "=q4=Boots of the Vanguard", "=ds=#s12#, #a2#", "", "8.13%"};
				{ 2, 21492, "", "=q4=Manslayer of the Qiraji", "=ds=#h2#, #w10#", "", "10.04%"};
				{ 4, 21496, "", "=q3=Bracers of Qiraji Command", "=ds=#s8#, #a1#", "", "15.79%"};
				{ 5, 21494, "", "=q3=Southwind's Grasp", "=ds=#s10#, #a2#", "", "15.13%"};
				{ 6, 21497, "", "=q3=Boots of the Qiraji General", "=ds=#s12#, #a3#", "", "15.45%"};
				{ 7, 21495, "", "=q3=Legplates of the Qiraji Command", "=ds=#s11#, #a4#", "", "15.47%"};
				{ 9, 0, "INV_Box_01", "=q6="..AL["Rajaxx's Captains"], ""};
				{ 10, 21810, "", "=q3=Treads of the Wandering Nomad", "=ds=#s12#, #a1#", "", "3.11%"};
				{ 11, 21809, "", "=q3=Fury of the Forgotten Swarm", "=ds=#s2#", "", "3.20%"};
				{ 12, 21806, "", "=q3=Gavel of Qiraji Authority", "=ds=#h2#, #w6#", "", "3.04%"};
				{ 16, 20889, "", "=q3=Qiraji Regal Drape", "#m3#", "", "36.51%"};
				{ 17, 20885, "", "=q3=Qiraji Martial Drape", "#m3#", "", "33.97%"};
				{ 18, 20884, "", "=q3=Qiraji Magisterial Ring", "#m3#", "", "8.82%"};
				{ 19, 20888, "", "=q3=Qiraji Ceremonial Ring", "#m3#", "", "8.56%"};
				{ 21, 0, "INV_Box_01", "=q6="..BabbleBoss["Lieutenant General Andorov"], ""};
				{ 22, 22221, "", "=q1=Plans: Obsidian Mail Tunic", "=ds=#p2# (300)"};
				{ 23, 22219, "", "=q1=Plans: Jagged Obsidian Shield", "=ds=#p2# (300)"};
			};
		};
		info = {
			name = BabbleBoss["General Rajaxx"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ20Moam"] = {
		["Normal"] = {
			{
				{ 1, 21472, "", "=q4=Dustwind Turban", "=ds=#s1#, #a1#", "", "7.76%"};
				{ 2, 21467, "", "=q4=Thick Silithid Chestguard", "=ds=#s5#, #a2#", "", "6.76%"};
				{ 3, 21479, "", "=q4=Gauntlets of the Immovable", "=ds=#s9#, #a4#", "", "7.12%"};
				{ 4, 21471, "", "=q4=Talon of Furious Concentration", "=ds=#s15#", "", "7.39%"};
				{ 6, 21470, "", "=q3=Cloak of the Savior", "=ds=#s4#", "", "14.23%"};
				{ 7, 21468, "", "=q3=Mantle of Maz'Nadir", "=ds=#s3#, #a1#", "", "15.86%"};
				{ 8, 21455, "", "=q3=Southwind Helm", "=ds=#s1#, #a2#", "", "14.08%"};
				{ 9, 21474, "", "=q3=Chitinous Shoulderguards", "=ds=#s3#, #a2#", "", "15.25%"};
				{ 10, 21469, "", "=q3=Gauntlets of Southwind", "=ds=#s9#, #a2#", "", "15.28%"};
				{ 11, 21476, "", "=q3=Obsidian Scaled Leggings", "=ds=#s11#, #a3#", "", "6.81%"};
				{ 12, 21475, "", "=q3=Legplates of the Destroyer", "=ds=#s11#, #a4#", "", "10.39%"};
				{ 13, 21477, "", "=q3=Ring of Fury", "=ds=#s13#", "", "14.42%"};
				{ 14, 21473, "", "=q3=Eye of Moam", "=ds=#s14#", "", "14.74%"};
				{ 16, 20886, "", "=q4=Qiraji Spiked Hilt", "#m3#", "", "36.38%"};
				{ 17, 20890, "", "=q4=Qiraji Ornate Hilt", "#m3#", "", "33.16%"};
				{ 18, 20884, "", "=q3=Qiraji Magisterial Ring", "#m3#", "", "7.56%"};
				{ 19, 20888, "", "=q3=Qiraji Ceremonial Ring", "#m3#", "", "8.34%"};
				{ 21, 22220, "", "=q3=Plans: Black Grasp of the Destroyer", "=ds=#p2# (300)", "", "4.11%"};
				{ 22, 22194, "", "=q4=Black Grasp of the Destroyer", "=ds=#s9#, #a3#"};
			};
		};
		info = {
			name = BabbleBoss["Moam"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ20Buru"] = {
		["Normal"] = {
			{
				{ 1, 21487, "", "=q4=Slimy Scaled Gauntlets", "=ds=#s9#, #a3#", "", "2.64%"};
				{ 2, 21486, "", "=q4=Gloves of the Swarm", "=ds=#s9#, #a4#", "", "5.22%"};
				{ 3, 21485, "", "=q4=Buru's Skull Fragment", "=ds=#w8#", "", "7.88%"};
				{ 5, 21489, "", "=q3=Quicksand Waders", "=ds=#s12#, #a1#", "", "15.95%"};
				{ 6, 21491, "", "=q3=Scaled Bracers of the Gorger", "=ds=#s8#, #a2#", "", "16.51%"};
				{ 7, 21490, "", "=q3=Slime Kickers", "=ds=#s12#, #a4#", "", "15.99%"};
				{ 8, 21488, "", "=q3=Fetish of Chitinous Spikes", "=ds=#s14#", "", "17.22%"};
				{ 16, 20886, "", "=q4=Qiraji Spiked Hilt", "#m3#", "", "8.31%"};
				{ 17, 20890, "", "=q4=Qiraji Ornate Hilt", "#m3#", "", "8.98%"};
				{ 18, 20889, "", "=q3=Qiraji Regal Drape", "#m3#", "", "9.77%"};
				{ 19, 20885, "", "=q3=Qiraji Martial Drape", "#m3#", "", "9.84%"};
				{ 20, 20884, "", "=q3=Qiraji Magisterial Ring", "#m3#", "", "26.98%"};
				{ 21, 20888, "", "=q3=Qiraji Ceremonial Ring", "#m3#", "", "25.58%"};
			};
		};
		info = {
			name = BabbleBoss["Buru the Gorger"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ20Ayamiss"] = {
		["Normal"] = {
			{
				{ 1, 21479, "", "=q4=Gauntlets of the Immovable", "=ds=#s9#, #a4#", "", "6.18%"};
				{ 2, 21466, "", "=q4=Stinger of Ayamiss", "=ds=#h1#, #w6#", "", "2.06%"};
				{ 3, 21478, "", "=q4=Bow of Taut Sinew", "=ds=#w2#", "", "10.14%"};
				{ 5, 21484, "", "=q3=Helm of Regrowth", "=ds=#s1#, #a2#", "", "15.85%"};
				{ 6, 21480, "", "=q3=Scaled Silithid Gauntlets", "=ds=#s9#, #a3#", "", "17.10%"};
				{ 7, 21482, "", "=q3=Boots of the Fiery Sands", "=ds=#s12#, #a3#", "", "4.92%"};
				{ 8, 21481, "", "=q3=Boots of the Desert Protector", "=ds=#s12#, #a4#", "", "11.08%"};
				{ 9, 21483, "", "=q3=Ring of the Desert Winds", "=ds=#s13#", "", "16.32%"};
				{ 16, 20886, "", "=q4=Qiraji Spiked Hilt", "#m3#", "", "8.24%"};
				{ 17, 20890, "", "=q4=Qiraji Ornate Hilt", "#m3#", "", "8.21%"};
				{ 18, 20889, "", "=q3=Qiraji Regal Drape", "#m3#", "", "8.85%"};
				{ 19, 20885, "", "=q3=Qiraji Martial Drape", "#m3#", "", "10.97%"};
				{ 20, 20884, "", "=q3=Qiraji Magisterial Ring", "#m3#", "", "26.98%"};
				{ 21, 20888, "", "=q3=Qiraji Ceremonial Ring", "#m3#", "", "27.50%"};
			};
		};
		info = {
			name = BabbleBoss["Ayamiss the Hunter"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ20Ossirian"] = {
		["Normal"] = {
			{
				{ 1, 21456, "", "=q4=Sandstorm Cloak", "=ds=#s4#", "", "10.89%"};
				{ 2, 21464, "", "=q4=Shackles of the Unscarred", "=ds=#s8#, #a1#", "", "12.62%"};
				{ 3, 21462, "", "=q4=Gloves of Dark Wisdom", "=ds=#s9#, #a1#", "", "11.89%"};
				{ 4, 21461, "", "=q4=Leggings of the Black Blizzard", "=ds=#s11#, #a1#", "", "12.83%"};
				{ 5, 21458, "", "=q4=Gauntlets of New Life", "=ds=#s9#, #a2#", "", "13.25%"};
				{ 6, 21454, "", "=q4=Runic Stone Shoulders", "=ds=#s3#, #a3#", "", "4.10%"};
				{ 7, 21463, "", "=q4=Ossirian's Binding", "=ds=#s10#, #a3#", "", "12.27%"};
				{ 8, 21460, "", "=q4=Helm of Domination", "=ds=#s1#, #a4#", "", "12.18%"};
				{ 9, 21453, "", "=q4=Mantle of the Horusath", "=ds=#s3#, #a4#", "", "6.96%"};
				{ 10, 21457, "", "=q4=Bracers of Brutality", "=ds=#s8#, #a4#", "", "10.74%"};
				{ 11, 21715, "", "=q4=Sand Polished Hammer", "=ds=#h1#, #w6#", "", "5.95%"};
				{ 12, 21459, "", "=q4=Crossbow of Imminent Doom", "=ds=#w3#", "", "6.12%"};
				{ 13, 21452, "", "=q4=Staff of the Ruins", "=ds=#w9#", "", "10.32%"};
				{ 16, 21220, "", "=q4=Head of Ossirian the Unscarred", "=ds=#m2#", "", "100%"};
				{ 17, 21504, "", "=q4=Charm of the Shifting Sands", "=q1=#m4#: =ds=#s2#"};
				{ 18, 21507, "", "=q4=Amulet of the Shifting Sands", "=q1=#m4#: =ds=#s2#"};
				{ 19, 21505, "", "=q4=Choker of the Shifting Sands", "=q1=#m4#: =ds=#s2#"};
				{ 20, 21506, "", "=q4=Pendant of the Shifting Sands", "=q1=#m4#: =ds=#s2#"};
				{ 22, 20886, "", "=q4=Qiraji Spiked Hilt", "#m3#", "", "35.27%"};
				{ 23, 20890, "", "=q4=Qiraji Ornate Hilt", "#m3#", "", "30.69%"};
				{ 24, 20884, "", "=q3=Qiraji Magisterial Ring", "#m3#", "", "9.65%"};
				{ 25, 20888, "", "=q3=Qiraji Ceremonial Ring", "#m3#", "", "8.53%"};
			};
		};
		info = {
			name = BabbleBoss["Ossirian the Unscarred"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ20Trash"] = {
		["Normal"] = {
			{
				{ 1, 20873, "", "=q3=Alabaster Idol", "=ds=#e15#", "", "0.39%"};
				{ 2, 20869, "", "=q3=Amber Idol", "=ds=#e15#", "", "0.36%"};
				{ 3, 20866, "", "=q3=Azure Idol", "=ds=#e15#", "", "0.48%"};
				{ 4, 20870, "", "=q3=Jasper Idol", "=ds=#e15#", "", "0.52%"};
				{ 5, 20868, "", "=q3=Lambent Idol", "=ds=#e15#", "", "0.48%"};
				{ 6, 20871, "", "=q3=Obsidian Idol", "=ds=#e15#", "", "0.41%"};
				{ 7, 20867, "", "=q3=Onyx Idol", "=ds=#e15#", "", "0.36%"};
				{ 8, 20872, "", "=q3=Vermillion Idol", "=ds=#e15#", "", "0.31%"};
				{ 10, 22202, "", "=q1=Small Obsidian Shard", "=ds=#e8#"};
				{ 11, 22203, "", "=q1=Large Obsidian Shard", "=ds=#e8#"};
				{ 16, 20864, "", "=q2=Bone Scarab", "=ds=#e15#", "", "0.84%"};
				{ 17, 20861, "", "=q2=Bronze Scarab", "=ds=#e15#", "", "0.88%"};
				{ 18, 20863, "", "=q2=Clay Scarab", "=ds=#e15#", "", "0.95%"};
				{ 19, 20862, "", "=q2=Crystal Scarab", "=ds=#e15#", "", "0.99%"};
				{ 20, 20859, "", "=q2=Gold Scarab", "=ds=#e15#", "", "0.96%"};
				{ 21, 20865, "", "=q2=Ivory Scarab", "=ds=#e15#", "", "0.93%"};
				{ 22, 20860, "", "=q2=Silver Scarab", "=ds=#e15#", "", "1.82%"};
				{ 23, 20858, "", "=q2=Stone Scarab", "=ds=#e15#", "", "0.86%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "TheRuinsofAhnQiraj",
		};
	};

		------------------------------------------
		--- Ahn'Qiraj: The Temple of Ahn'Qiraj ---
		------------------------------------------

	AtlasLoot_Data["AQ40Skeram"] = {
		["Normal"] = {
			{
				{ 1, 21701, "", "=q4=Cloak of Concentrated Hatred", "=ds=#s4#", "", "11.81%"};
				{ 2, 21708, "", "=q4=Beetle Scaled Wristguards", "=ds=#s8#, #a2#", "", "12.85%"};
				{ 3, 21698, "", "=q4=Leggings of Immersion", "=ds=#s11#, #a2#", "", " 10.99%"};
				{ 4, 21699, "", "=q4=Barrage Shoulders", "=ds=#s3#, #a3#", "", "11.50%"};
				{ 5, 21705, "", "=q4=Boots of the Fallen Prophet", "=ds=#s12#, #a3#", "", "3.33%"};
				{ 6, 21814, "", "=q4=Breastplate of Annihilation", "=ds=#s5#, #a4#", "", "11.01%"};
				{ 7, 21704, "", "=q4=Boots of the Redeemed Prophecy", "=ds=#s12#, #a4#", "", "7.75%"};
				{ 8, 21706, "", "=q4=Boots of the Unwavering Will", "=ds=#s12#, #a4#", "", "12.23%"};
				{ 10, 21702, "", "=q4=Amulet of Foul Warding", "=ds=#s2#", "", "12.20%"};
				{ 11, 21700, "", "=q4=Pendant of the Qiraji Guardian", "=ds=#s2#", "", "11.57%"};
				{ 12, 21707, "", "=q4=Ring of Swarming Thought", "=ds=#s13#", "", "12.57%"};
				{ 13, 21703, "", "=q4=Hammer of Ji'zhi", "=ds=#h2#, #w6#", "", "7.14%"};
				{ 14, 21128, "", "=q4=Staff of the Qiraji Prophets", "=ds=#w9#", "", " 6.32%"};
				{ 16, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "1.74%"};
				{ 17, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#"};
				{ 18, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#"};
				{ 19, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#"};
				{ 21, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "1.32%"};
				{ 22, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#"};
				{ 23, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#"};
				{ 24, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#"};
				{ 25, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#"};
				{ 27, 22222, "", "=q3=Plans: Thick Obsidian Breastplate", "=ds=#p2# (300)", "", "5.00%"};
				{ 29, 93041, "", "=q3=Jewel of Maddening Whispers", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["The Prophet Skeram"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40BugFam"] = {
		["Normal"] = {
			{
				{ 1, 21697, "", "=q4=Cape of the Trinity", "=ds=#s4# =q2=#m5#", "", "14%"};
				{ 2, 21694, "", "=q4=Ternary Mantle", "=ds=#s3#, #a1# =q2=#m5#", "", "16%"};
				{ 3, 21696, "", "=q4=Robes of the Triumvirate", "=ds=#s5#, #a1# =q2=#m5#", "", "13%"};
				{ 4, 21693, "", "=q4=Guise of the Devourer", "=ds=#s1#, #a2# =q2=#m5#", "", "16%"};
				{ 5, 21692, "", "=q4=Triad Girdle", "=ds=#s10#, #a4# =q2=#m5#", "", "16%"};
				{ 6, 21695, "", "=q4=Angelista's Touch", "=ds=#s13# =q2=#m5#", "", "14%"};
				{ 8, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3# =q2=#m5#", "", "7%"};
				{ 9, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3# =q2=#m5#", "", "7%"};
				{ 11, 21680, "", "=q4=Vest of Swift Execution", "=ds=#s5#, #a2# =q2="..BabbleBoss["Lord Kri"], "", "21%"};
				{ 12, 21603, "", "=q4=Wand of Qiraji Nobility", "=ds=#w12# =q2="..BabbleBoss["Lord Kri"], "", "25%"};
				{ 13, 21681, "", "=q4=Ring of the Devoured", "=ds=#s13# =q2="..BabbleBoss["Lord Kri"], "", "17%"};
				{ 14, 21685, "", "=q4=Petrified Scarab", "=ds=#s14# =q2="..BabbleBoss["Lord Kri"], "", "21%"};
				{ 16, 21689, "", "=q4=Gloves of Ebru", "=ds=#s9#, #a2# =q2="..BabbleBoss["Vem"], "", "18%"};
				{ 17, 21691, "", "=q4=Ooze-Ridden Gauntlets", "=ds=#s9#, #a4# =q2="..BabbleBoss["Vem"], "", "20%"};
				{ 18, 21688, "", "=q4=Boots of the Fallen Hero", "=ds=#s12#, #a4# =q2="..BabbleBoss["Vem"], "", "18%"};
				{ 19, 21690, "", "=q4=Angelista's Charm", "=ds=#s2# =q2="..BabbleBoss["Vem"], "", "20%"};
				{ 21, 21686, "", "=q4=Mantle of Phrenic Power", "=ds=#s3#, #a1# =q2="..BabbleBoss["Princess Yauj"], "", "13%"};
				{ 22, 21682, "", "=q4=Bile-Covered Gauntlets", "=ds=#s9#, #a2# =q2="..BabbleBoss["Princess Yauj"], "", "19%"};
				{ 23, 21684, "", "=q4=Mantle of the Desert's Fury", "=ds=#s3#, #a3# =q2="..BabbleBoss["Princess Yauj"], "", "16%"};
				{ 24, 21683, "", "=q4=Mantle of the Desert Crusade", "=ds=#s3#, #a4# =q2="..BabbleBoss["Princess Yauj"], "", "14%"};
				{ 25, 21687, "", "=q4=Ukko's Ring of Darkness", "=ds=#s13# =q2="..BabbleBoss["Princess Yauj"], "", "20%"};
			};
		};
		info = {
			name = BabbleBoss["The Bug Family"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Sartura"] = {
		["Normal"] = {
			{
				{ 1, 21671, "", "=q4=Robes of the Battleguard", "=ds=#s5#, #a1#", "", "13.30%"};
				{ 2, 21676, "", "=q4=Leggings of the Festering Swarm", "=ds=#s11#, #a1#", "", "13.02%"};
				{ 3, 21648, "", "=q4=Recomposed Boots", "=ds=#s12#, #a1#", "", "7.64%"};
				{ 4, 21669, "", "=q4=Creeping Vine Helm", "=ds=#s1#, #a2#", "", "12.33%"};
				{ 5, 21672, "", "=q4=Gloves of Enforcement", "=ds=#s9#, #a2#", "", "11.87%"};
				{ 6, 21675, "", "=q4=Thick Qirajihide Belt", "=ds=#s10#, #a2#", "", "13.26%"};
				{ 7, 21668, "", "=q4=Scaled Leggings of Qiraji Fury", "=ds=#s11#, #a3#", "", "4.03%"};
				{ 8, 21674, "", "=q4=Gauntlets of Steadfast Determination", "=ds=#s9#, #a4#", "", "11.07%"};
				{ 9, 21667, "", "=q4=Legplates of Blazing Light", "=ds=#s11#, #a4#", "", "7.44%"};
				{ 11, 21678, "", "=q4=Necklace of Purity", "=ds=#s2#", "", "14.21%"};
				{ 12, 21670, "", "=q4=Badge of the Swarmguard", "=ds=#s14#", "", "13.22%"};
				{ 13, 21666, "", "=q4=Sartura's Might", "=ds=#s15#", "", "6.47%"};
				{ 14, 21673, "", "=q4=Silithid Claw", "=ds=#h1#, #w13#", "", "7.16%"};
				{ 16, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "4.01%"};
				{ 17, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#"};
				{ 18, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#"};
				{ 19, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#"};
				{ 21, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "4.02%"};
				{ 22, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#"};
				{ 23, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#"};
				{ 24, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#"};
				{ 25, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#"};
			};
		};
		info = {
			name = BabbleBoss["Battleguard Sartura"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Fankriss"] = {
		["Normal"] = {
			{
				{ 1, 21627, "", "=q4=Cloak of Untold Secrets", "=ds=#s4#", "", "12.51%"};
				{ 2, 21663, "", "=q4=Robes of the Guardian Saint", "=ds=#s5#, #a1#", "", "12.95%"};
				{ 3, 21665, "", "=q4=Mantle of Wicked Revenge", "=ds=#s3#, #a2#", "", "13.25%"};
				{ 4, 21645, "", "=q4=Hive Tunneler's Boots", "=ds=#s12#, #a2#", "", "14.04%"};
				{ 5, 21651, "", "=q4=Scaled Sand Reaver Leggings", "=ds=#s11#, #a3#", "", "12.91%"};
				{ 6, 21639, "", "=q4=Pauldrons of the Unrelenting", "=ds=#s3#, #a4#", "", "14.78%"};
				{ 7, 21652, "", "=q4=Silithid Carapace Chestguard", "=ds=#s5#, #a4#", "", "10.29%"};
				{ 9, 21647, "", "=q4=Fetish of the Sand Reaver", "=ds=#s14#", "", "13.82%"};
				{ 10, 21664, "", "=q4=Barbed Choker", "=ds=#s2#", "", "12.63%"};
				{ 11, 21650, "", "=q4=Ancient Qiraji Ripper", "=ds=#h1#, #w10#", "", " 7.19%"};
				{ 12, 21635, "", "=q4=Barb of the Sand Reaver", "=ds=#w7#", "", "6.61%"};
				{ 16, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "4.84%"};
				{ 17, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#"};
				{ 18, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#"};
				{ 19, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#"};
				{ 21, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "4.09%"};
				{ 22, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#"};
				{ 23, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#"};
				{ 24, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#"};
				{ 25, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#"};
			};
		};
		info = {
			name = BabbleBoss["Fankriss the Unyielding"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Viscidus"] = {
		["Normal"] = {
			{
				{ 1, 21624, "", "=q4=Gauntlets of Kalimdor", "=ds=#s9#, #a3#", "", "3.90%"};
				{ 2, 21626, "", "=q4=Slime-Coated Leggings", "=ds=#s11#, #a3#", "", "13.66%"};
				{ 3, 21623, "", "=q4=Gauntlets of the Righteous Champion", "=ds=#s9#, #a4#", "", "5.37%"};
				{ 5, 21677, "", "=q4=Ring of the Qiraji Fury", "=ds=#s13#", "", "2.93%"};
				{ 6, 21625, "", "=q4=Scarab Brooch", "=ds=#s14#", "", "21.46%"};
				{ 7, 21622, "", "=q4=Sharpened Silithid Femur", "=ds=#h1#, #w10#", "", "15.12%"};
				{ 9, 20932, "", "=q4=Qiraji Bindings of Dominance", "=q1=#m1# =ds=#c8#, #c3#, #c7#, #c1#, #c4#", "", "100%"};
				{ 10, 20928, "", "=q4=Qiraji Bindings of Command", "=q1=#m1# =ds=#c5#, #c6#, #c9#, #c2#", "", "100%"};
				{ 16, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "3.19%"};
				{ 17, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#"};
				{ 18, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#"};
				{ 19, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#"};
				{ 21, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "6.86%"};
				{ 22, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#"};
				{ 23, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#"};
				{ 24, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#"};
				{ 25, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#"};
				{ 27, 93039, "", "=q3=Viscidus Globule", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["Viscidus"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Huhuran"] = {
		["Normal"] = {
			{
				{ 1, 21619, "", "=q4=Gloves of the Messiah", "=ds=#s9#, #a1#", "", "12.01%"};
				{ 2, 21621, "", "=q4=Cloak of the Golden Hive", "=ds=#s4#", "", "12.56%"};
				{ 3, 21617, "", "=q4=Wasphide Gauntlets", "=ds=#s9#, #a2#", "", "11.97%"};
				{ 4, 21618, "", "=q4=Hive Defiler Wristguards", "=ds=#s8#, #a4#", "", "10.34%"};
				{ 6, 21620, "", "=q4=Ring of the Martyr", "=ds=#s13#", "", "12.97%"};
				{ 7, 21616, "", "=q4=Huhuran's Stinger", "=ds=#w2#", "", "5.71%"};
				{ 9, 20932, "", "=q4=Qiraji Bindings of Dominance", "=q1=#m1# =ds=#c8#, #c3#, #c7#, #c1#, #c4#", "", "100%"};
				{ 10, 20928, "", "=q4=Qiraji Bindings of Command", "=q1=#m1# =ds=#c5#, #c6#, #c9#, #c2#", "", "100%"};
				{ 16, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "4.31%"};
				{ 17, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#"};
				{ 18, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#"};
				{ 19, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#"};
				{ 21, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "4.11%"};
				{ 22, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#"};
				{ 23, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#"};
				{ 24, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#"};
				{ 25, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#"};
			};
		};
		info = {
			name = BabbleBoss["Princess Huhuran"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Emperors"] = {
		["Normal"] = {
			{
				{ 1, 20930, "", "=q4=Vek'lor's Diadem", "=q1=#m1# =ds=#c7#, #c1#, #c6#, #c2#, #c4#", "", "100%"};
				{ 2, 21600, "", "=q4=Boots of Epiphany", "=ds=#s12#, #a1#", "", "15.77%"};
				{ 3, 21602, "", "=q4=Qiraji Execution Bracers", "=ds=#s8#, #a2#", "", "15.95%"};
				{ 4, 21599, "", "=q4=Vek'lor's Gloves of Devastation", "=ds=#s9#, #a3#", "", "15.77%"};
				{ 5, 21598, "", "=q4=Royal Qiraji Belt", "=ds=#s10#, #a4#", "", "9.84%"};
				{ 6, 21597, "", "=q4=Royal Scepter of Vek'lor", "=ds=#s15#", "", "6.99%"};
				{ 7, 21601, "", "=q4=Ring of Emperor Vek'lor", "=ds=#s13#", "", "17.27%"};
				{ 8, 20735, "", "=q3=Formula: Enchant Cloak - Subtlety", "=ds=#p4# (300)", "", "6.62%"};
				{ 9, 93040, "", "=q3=Anubisath Idol", "=ds=#e13#", ""};
				{ 11, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "6.25%"};
				{ 12, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4#, =ds=#h1#, #w1#"};
				{ 13, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4#, =ds=#w5#"};
				{ 14, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4#, =ds=#h1#, #w4#"};
				{ 15, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4#, =ds=#w8#"};
				{ 16, 20926, "", "=q4=Vek'nilash's Circlet", "=q1=#m1# =ds=#c8#, #c3#, #c5#, #c9#", "", "100%"};
				{ 17, 21604, "", "=q4=Bracelets of Royal Redemption", "=ds=#s8#, #a1#", "", "12.51%"};
				{ 18, 21605, "", "=q4=Gloves of the Hidden Temple", "=ds=#s9#, #a2#", "", "15.45%"};
				{ 19, 21609, "", "=q4=Regenerating Belt of Vek'nilash", "=ds=#s10#, #a2#", "", "13.35%"};
				{ 20, 21607, "", "=q4=Grasp of the Fallen Emperor", "=ds=#s10#, #a3#", "", "2.72%"};
				{ 21, 21606, "", "=q4=Belt of the Fallen Emperor", "=ds=#s10#, #a4#", "", "12.22%"};
				{ 22, 21679, "", "=q4=Kalimdor's Revenge", "=ds=#h2#, #w10#", "", "9.25%"};
				{ 23, 21608, "", "=q4=Amulet of Vek'nilash", "=ds=#s2#", "", "14.25%"};
				{ 24, 20726, "", "=q3=Formula: Enchant Gloves - Threat", "=ds=#p4# (300)", "", "6.24%"};
				{ 26, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "5.00%"};
				{ 27, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4#, =ds=#w9#"};
				{ 28, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4#, =ds=#w9#"};
				{ 29, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4#, =ds=#h1#, #w6#"};
			};
		};
		info = {
			name = BabbleBoss["The Twin Emperors"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Ouro"] = {
		["Normal"] = {
			{
				{ 1, 21615, "", "=q4=Don Rigoberto's Lost Hat", "=ds=#s1#, #a1#", "", "28.63%"};
				{ 2, 21611, "", "=q4=Burrower Bracers", "=ds=#s8#, #a1#", "", "24.44%"};
				{ 3, 23558, "", "=q4=The Burrower's Shell", "=ds=#s14#", "", "2.90%"};
				{ 4, 23570, "", "=q4=Jom Gabbar", "=ds=#s14#", "", "2.80%"};
				{ 5, 23557, "", "=q4=Larvae of the Great Worm", "=ds=#w5#", "", "3.95%"};
				{ 6, 21610, "", "=q4=Wormscale Blocker", "=ds=#w8#", "", "16.54%"};
				{ 8, 20927, "", "=q4=Ouro's Intact Hide", "=q1=#m1# =ds=#c3#, #c5#, #c6#, #c9#", "", "100%"};
				{ 9, 20931, "", "=q4=Skin of the Great Sandworm", "=q1=#m1# =ds=#c8#, #c7#, #c1#, #c2#, #c4#", "", "100%"};
				{ 16, 21237, "", "=q4=Imperial Qiraji Regalia", "=ds=#m3#", "", "5.20%"};
				{ 17, 21273, "", "=q4=Blessed Qiraji Acolyte Staff", "=q1=#m4# =ds=#w9#"};
				{ 18, 21275, "", "=q4=Blessed Qiraji Augur Staff", "=q1=#m4# =ds=#w9#"};
				{ 19, 21268, "", "=q4=Blessed Qiraji War Hammer", "=q1=#m4# =ds=#h1#, #w6#"};
				{ 21, 21232, "", "=q4=Imperial Qiraji Armaments", "=ds=#m3#", "", "4.10%"};
				{ 22, 21242, "", "=q4=Blessed Qiraji War Axe", "=q1=#m4# =ds=#h1#, #w1#"};
				{ 23, 21272, "", "=q4=Blessed Qiraji Musket", "=q1=#m4# =ds=#w5#"};
				{ 24, 21244, "", "=q4=Blessed Qiraji Pugio", "=q1=#m4# =ds=#h1#, #w4#"};
				{ 25, 21269, "", "=q4=Blessed Qiraji Bulwark", "=q1=#m4# =ds=#w8#"};
			};
		};
		info = {
			name = BabbleBoss["Ouro"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40CThun"] = {
		["Normal"] = {
			{
				{ 1, 21583, "", "=q4=Cloak of Clarity", "=ds=#s4#", "", "14.45%"};
				{ 2, 22731, "", "=q4=Cloak of the Devoured", "=ds=#s4#", "", "16.34%"};
				{ 3, 21585, "", "=q4=Dark Storm Gauntlets", "=ds=#s9#, #a1#", "", "13.63%"};
				{ 4, 22730, "", "=q4=Eyestalk Waist Cord", "=ds=#s10#, #a1#", "", "10.41%"};
				{ 5, 21582, "", "=q4=Grasp of the Old God", "=ds=#s10#, #a1#", "", "15.04%"};
				{ 6, 21586, "", "=q4=Belt of Never-Ending Agony", "=ds=#s10#, #a2#", "", "11.24%"};
				{ 7, 21581, "", "=q4=Gauntlets of Annihilation", "=ds=#s9#, #a4#", "", "12.04%"};
				{ 9, 22732, "", "=q4=Mark of C'Thun", "=ds=#s2#", "", "10.62%"};
				{ 10, 21596, "", "=q4=Ring of the Godslayer", "=ds=#s13#", "", "11.83%"};
				{ 11, 21579, "", "=q4=Vanquished Tentacle of C'Thun", "=ds=#s14#", "", "12.18%"};
				{ 12, 21126, "", "=q4=Death's Sting", "=ds=#h1#, #w4#", "", "6.84%"};
				{ 13, 21134, "", "=q4=Dark Edge of Insanity", "=ds=#h2#, #w1#", "", "5.93%"};
				{ 14, 21839, "", "=q4=Scepter of the False Prophet", "=ds=#h1#, #w6#", "", "4.75%"};
				{ 16, 20933, "", "=q4=Husk of the Old God", "=q1=#m1# =ds=#c8#, #c3#, #c1#, #c5#", "", "100%"};
				{ 17, 20929, "", "=q4=Carapace of the Old God", "=q1=#m1# =ds=#c7#, #c6#, #c9#, #c2#, #c4#", "", "100%"};
				{ 19, 21221, "", "=q4=Eye of C'Thun", "=ds=#m2#", "", "100%"};
				{ 20, 21710, "", "=q4=Cloak of the Fallen God", "=q1=#m4#: =ds=#s4#"};
				{ 21, 21712, "", "=q4=Amulet of the Fallen God", "=q1=#m4#: =ds=#s2#"};
				{ 22, 21709, "", "=q4=Ring of the Fallen God", "=q1=#m4#: =ds=#s13#"};
				{ 24, 22734, "", "=q1=Base of Atiesh", "=ds=#m3#"};
				{ 25, 22632, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c1#"};
				{ 26, 22589, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c3#"};
				{ 27, 22631, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c5#"};
				{ 28, 22630, "", "=q5=Atiesh, Greatstaff of the Guardian", "=ds=#m4#, =q1=#m1# =ds=#c8#"};
			};
		};
		info = {
			name = BabbleBoss["C'Thun"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

	AtlasLoot_Data["AQ40Trash"] = {
		["Normal"] = {
			{
				{ 1, 21838, "", "=q4=Garb of Royal Ascension", "=ds=#s5#, #a1#", "", "0.20%"};
				{ 2, 21888, "", "=q4=Gloves of the Immortal", "=ds=#s9#, #a1#", "", "0.16%"};
				{ 3, 21889, "", "=q4=Gloves of the Redeemed Prophecy", "=ds=#s9#, #a4# =q1=#m1# =ds=#c4#", "", "0.39%"};
				{ 4, 21836, "", "=q4=Ritssyn's Ring of Chaos", "=ds=#s13#", "", "0.18%"};
				{ 5, 21891, "", "=q4=Shard of the Fallen Star", "=ds=#s14#", "", "0.59%"};
				{ 6, 21856, "", "=q4=Neretzek, The Blood Drinker", "=ds=#h2#, #w1#", "", "0.20%"};
				{ 7, 21837, "", "=q4=Anubisath Warhammer", "=ds=#h1#, #w6#", "", "0.21%"};
				{ 9, 22202, "", "=q1=Small Obsidian Shard", "=ds=#e8#"};
				{ 10, 22203, "", "=q1=Large Obsidian Shard", "=ds=#e8#"};
				{ 16, 21218, "", "=q3=Blue Qiraji Resonating Crystal", "=ds=#e26#", "", "10.64%"};
				{ 17, 21324, "", "=q3=Yellow Qiraji Resonating Crystal", "=ds=#e26#", "", "12.15%"};
				{ 18, 21323, "", "=q3=Green Qiraji Resonating Crystal", "=ds=#e26#", "", "11.62%"};
				{ 19, 21321, "", "=q3=Red Qiraji Resonating Crystal", "=ds=#e26#", "", "1.39%"};
			};
			{
				{ 1, 20876, "", "=q3=Idol of Death", "=ds=#e15#", "", "0.26%"};
				{ 2, 20879, "", "=q3=Idol of Life", "=ds=#e15#", "", "0.29%"};
				{ 3, 20875, "", "=q3=Idol of Night", "=ds=#e15#", "", "0.29%"};
				{ 4, 20878, "", "=q3=Idol of Rebirth", "=ds=#e15#", "", "0.28%"};
				{ 5, 20881, "", "=q3=Idol of Strife", "=ds=#e15#", "", "0.21%"};
				{ 6, 20877, "", "=q3=Idol of the Sage", "=ds=#e15#", "", "0.33%"};
				{ 7, 20874, "", "=q3=Idol of the Sun", "=ds=#e15#", "", "0.21%"};
				{ 8, 20882, "", "=q3=Idol of War", "=ds=#e15#", "", "0.30%"};
				{ 10, 21230, "", "=q1=Ancient Qiraji Artifact", "=ds=#m2#"};
				{ 12, 21762, "", "=q1=Greater Scarab Coffer Key", "=ds=#e9#", "", "7.03%"};
				{ 16, 20864, "", "=q2=Bone Scarab", "=ds=#e15#", "", "0.84%"};
				{ 17, 20861, "", "=q2=Bronze Scarab", "=ds=#e15#", "", "0.88%"};
				{ 18, 20863, "", "=q2=Clay Scarab", "=ds=#e15#", "", "0.95%"};
				{ 19, 20862, "", "=q2=Crystal Scarab", "=ds=#e15#", "", "0.99%"};
				{ 20, 20859, "", "=q2=Gold Scarab", "=ds=#e15#", "", "0.96%"};
				{ 21, 20865, "", "=q2=Ivory Scarab", "=ds=#e15#", "", "0.93%"};
				{ 22, 20860, "", "=q2=Silver Scarab", "=ds=#e15#", "", "1.82%"};
				{ 23, 20858, "", "=q2=Stone Scarab", "=ds=#e15#", "", "0.86%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "TheTempleofAhnQiraj",
		};
	};

		-------------------------
		--- Blackfathom Deeps ---
		-------------------------

	AtlasLoot_Data["Blackfathom"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Ghamoo-ra", 368), ""};
				{ 2, 6908, "", "=q3=Ghamoo-Ra's Bind", "=ds=#s10#, #a1#", "", "50%"};
				{ 3, 6907, "", "=q3=Tortoise Armor", "=ds=#s5#, #a3#", "", "50%"};
				{ 6, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lady Sarevess", 436), ""};
				{ 7, 888, "", "=q3=Naga Battle Gloves", "=ds=#s9#, #a2#", "", "33%"};
				{ 8, 11121, "", "=q3=Darkwater Talwar", "=ds=#h1#, #w10#", "", "33%"};
				{ 9, 3078, "", "=q3=Naga Heartpiercer", "=ds=#w2#", "", "33%"};
				{ 11, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Gelihast", 426), ""};
				{ 12, 6906, "", "=q3=Algae Fists", "=ds=#s9#, #a3#", "", "50%"};
				{ 13, 6905, "", "=q3=Reef Axe", "=ds=#h2#, #w1#", "", "50%"};
				{ 14, 1470, "", "=q1=Murloc Skin Bag", "=ds=#e1#", "", "12,5%"};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Baron Aquanis"], ""};
				{ 17, 16782, "", "=q2=Strange Water Globe", "=ds=#m2# (#m6#)", "", "100%"};
				{ 18, 16886, "", "=q3=Outlaw Sabre", "=q1=#m4#: =ds=#h1#, #w10#"};
				{ 19, 16887, "", "=q3=Witch's Finger", "=q1=#m4#: =ds=#s15#"};
				{ 21, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Twilight Lord Kelris", 437), ""};
				{ 22, 6903, "", "=q3=Gaze Dreamer Pants", "=ds=#s11#, #a1#", "", "50%"};
				{ 23, 1155, "", "=q3=Rod of the Sleepwalker", "=ds=#w9#", "", "50%"};
				{ 24, 5881, "", "=q1=Head of Kelris", "=ds=#m3#", "", "100%"};
				{ 26, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Old Serra'kis", 447), ""};
				{ 27, 6901, "", "=q3=Glowing Thresher Cape", "=ds=#s4#", "", "33%"};
				{ 28, 6902, "", "=q3=Bands of Serra'kis", "=ds=#s8#, #a2#", "", "33%"};
				{ 29, 6904, "", "=q3=Bite of Serra'kis", "=ds=#h1#, #w4#", "", "33%"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Aku'mai", 444), "#ACHIEVEMENTID:632#"};
				{ 2, 6910, "", "=q3=Leech Pants", "=ds=#s11#, #a1#", "", "33%"};
				{ 3, 6911, "", "=q3=Moss Cinch", "=ds=#s10#, #a2#", "", "33%"};
				{ 4, 6909, "", "=q3=Strike of the Hydra", "=ds=#h2#, #w10#", "", "33%"};
				{ 6, 0, "INV_Box_01", "=q6="..AL["Quest Item"], ""};
				{ 7, 5952, "", "=q1=Corrupted Brain Stem", "=ds=#m3#", "" };
				{ 8, 16762, "", "=q1=Fathom Core", "=ds=#m3#", "", "100%"};
				{ 9, 5359, "", "=q1=Lorgalis Manuscript", "=ds=#m3#", "", "100%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], ""};
				{ 17, 1486, "", "=q3=Tree Bark Jacket", "=ds=#s5#, #a1#"};
				{ 18, 3416, "", "=q3=Martyr's Chain", "=ds=#s5#, #a3#"};
				{ 19, 1491, "", "=q3=Ring of Precision", "=ds=#s13#"};
				{ 20, 3413, "", "=q3=Doomspike", "=ds=#h1#, #w4#"};
				{ 21, 2567, "", "=q3=Evocator's Blade", "=ds=#h1#, #w4#"};
				{ 22, 3417, "", "=q3=Onyx Claymore", "=ds=#h2#, #w10#"};
				{ 23, 1454, "", "=q3=Axe of the Enforcer", "=ds=#h1#, #w1#"};
				{ 24, 1481, "", "=q3=Grimclaw", "=ds=#h1#, #w1#"};
				{ 25, 3414, "", "=q3=Crested Scepter", "=ds=#h1#, #w6#"};
				{ 26, 3415, "", "=q3=Staff of the Friar", "=ds=#w9#"};
				{ 27, 2271, "", "=q3=Staff of the Blessed Seer", "=ds=#w9#"};
			};
		};
		info = {
			name = ALIL["Blackfathom Deeps"],
			module = moduleName, instance = "BlackfathomDeeps",
		};
	};

		--------------------------------------------
		--- Blackrock Mountain: Blackrock Depths ---
		--------------------------------------------

	AtlasLoot_Data["BRDHighInterrogatorGerstahn"] = {
		["Normal"] = {
			{
				{ 1, 11626, "", "=q3=Blackveil Cape", "=ds=#s4#", "", "25%"};
				{ 2, 11624, "", "=q3=Kentic Amice", "=ds=#s3#, #a1#", "", "25%"};
				{ 3, 22240, "", "=q3=Greaves of Withering Despair", "=ds=#s12#, #a3#", "", "25%"};
				{ 4, 11625, "", "=q3=Enthralled Sphere", "=ds=#s15#", "", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Interrogator Gerstahn", 369),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDLordRoccor"] = {
		["Normal"] = {
			{
				{ 1, 22234, "", "=q3=Mantle of Lost Hope", "=ds=#s3#, #a1#", "", "25%"};
				{ 2, 11632, "", "=q3=Earthslag Shoulders", "=ds=#s3#, #a4#", "", "25%"};
				{ 3, 11631, "", "=q3=Stoneshell Guard", "=ds=#w8#", "", "25%"};
				{ 16, 45050, "", "=q2=Formula: Smoking Heart of the Mountain", "=ds=#p4# (265)", "", "100%"};
				{ 17, 11811, "", "=q3=Smoking Heart of the Mountain", "=ds=#s14#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lord Roccor", 370),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDHoundmaster"] = {
		["Normal"] = {
			{
				{ 1, 11623, "", "=q3=Spritecaster Cape", "=ds=#s4#", "", "33%"};
				{ 2, 11627, "", "=q3=Fleetfoot Greaves", "=ds=#s12#, #a3#", "", "33%"};
				{ 3, 11628, "", "=q3=Houndmaster's Bow", "=ds=#w2#", "", "17%"};
				{ 4, 11629, "", "=q3=Houndmaster's Rifle", "=ds=#w5#", "", "17%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Houndmaster Grebmar", 371),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDBaelGar"] = {
		["Normal"] = {
			{
				{ 1, 11807, "", "=q3=Sash of the Burning Heart", "=ds=#s10#, #a1#", "", "25%"};
				{ 2, 11802, "", "=q3=Lavacrest Leggings", "=ds=#s11#, #a4#", "", "25%"};
				{ 3, 11805, "", "=q3=Rubidium Hammer", "=ds=#h1#, #w6#", "", "25%"};
				{ 4, 11803, "", "=q3=Force of Magma", "=ds=#h2#, #w6#", "", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Bael'Gar", 377),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDLordIncendius"] = {
		["Normal"] = {
			{
				{ 1, 11766, "", "=q3=Flameweave Cuffs", "=ds=#s8#, #a1#", "", "25%"};
				{ 2, 11764, "", "=q3=Cinderhide Armsplints", "=ds=#s8#, #a2#", "", "25%"};
				{ 3, 11765, "", "=q3=Pyremail Wristguards", "=ds=#s8#, #a3#", "", "25%"};
				{ 4, 11767, "", "=q3=Emberplate Armguards", "=ds=#s8#, #a4#", "", "25%"};
				{ 16, 19268, "", "=q3=Ace of Elementals", "=ds=#e16#", "", "3%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lord Incendius", 374),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDFineousDarkvire"] = {
		["Normal"] = {
			{
				{ 1, 11839, "", "=q3=Chief Architect's Monocle", "=ds=#s1#, #a1#", "", "25%"};
				{ 2, 11841, "", "=q3=Senior Designer's Pantaloons", "=ds=#s11#, #a1#", "", "25%"};
				{ 3, 11842, "", "=q3=Lead Surveyor's Mantle", "=ds=#s3#, #a3#", "", "25%"};
				{ 4, 22223, "", "=q3=Foreman's Head Protector", "=ds=#s1#, #a4#", "", "25%"};
				{ 6, 11840, "", "=q1=Master Builder's Shirt", "#s6#", "", "7%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Fineous Darkvire", 376),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDTheVault"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["The Vault"], ""};
				{ 2, 11309, "", "=q1=The Heart of the Mountain", "=ds=#m3#", "", "100%"};
				{ 4, 0, "INV_Box_01", "=q6="..AL["The Secret Safe"], ""};
				{ 5, 22256, "", "=q3=Mana Shaping Handwraps", "=ds=#s9#, #a1#", "", "25%"};
				{ 8, 22205, "", "=q3=Black Steel Bindings", "=ds=#s8#, #a4#", "", "25%"};
				{ 9, 22255, "", "=q3=Magma Forged Band", "=ds=#s13#", "", "25%"};
				{ 12, 22254, "", "=q3=Wand of Eternal Light", "=ds=#w12#", "", "25%"};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Dark Coffer"], ""};
				{ 17, 11752, "", "=q1=Black Blood of the Tormented", "=ds=#m3#"};
				{ 18, 11751, "", "=q1=Burning Essence", "=ds=#m3#"};
				{ 19, 11753, "", "=q1=Eye of Kajal", "=ds=#m3#"};
			};
		};
		info = {
			name = AL["The Vault"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDWarderStilgiss"] = {
		["Normal"] = {
			{
				{ 1, 11782, "", "=q3=Boreal Mantle", "=ds=#s3#, #a1#", "", "25%"};
				{ 2, 22241, "", "=q3=Dark Warder's Pauldrons", "=ds=#s3#, #a2#", "", "25%"};
				{ 3, 11783, "", "=q3=Chillsteel Girdle", "=ds=#s10#, #a3#", "", "25%"};
				{ 4, 11784, "", "=q3=Arbiter's Blade", "=ds=#h1#, #w10#", "", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Warder Stilgiss", 375),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDVerek"] = {
		["Normal"] = {
			{
				{ 1, 22242, "", "=q3=Verek's Leash", "=ds=#s10#, #a3#", "", "12.50%"};
				{ 2, 11755, "", "=q3=Verek's Collar", "=ds=#s2#", "", "12.50%"};
			};
		};
		info = {
			name = BabbleBoss["Verek"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDPyromantLoregrain"] = {
		["Normal"] = {
			{
				{ 1, 11747, "", "=q3=Flamestrider Robes", "=ds=#s5#, #a2#", "", "25%"};
				{ 2, 11749, "", "=q3=Searingscale Leggings", "=ds=#s11#, #a3#", "", "25%"};
				{ 3, 11750, "", "=q3=Kindling Stave", "=ds=#w9#", "", "25%"};
				{ 4, 11748, "", "=q3=Pyric Caduceus", "=ds=#w12#", "", "25%"};
				{ 16, 11207, "", "=q2=Formula: Enchant Weapon - Fiery Weapon", "=ds=#p4# (265)", "", "15%"};
				{ 18, 63469, "", "=q1=Breath of Cenarius", "=ds=#m3#, =q1=#m1# =ds=#c1#", "", " 100%"};
				{ 19, 64305, "", "=q1=Loregrain's Grimoire", "=ds=#m3#, =q1=#m1# =ds=#c3#", "", " 100%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Pyromancer Loregrain", 373),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDArena"] = {
		["Normal"] = {
			{
				{ 1, 11677, "", "=q3=Graverot Cape", "=ds=#s4# =q2=#brd1#", "", "25%"};
				{ 2, 11675, "", "=q3=Shadefiend Boots", "=ds=#s12#, #a2# =q2=#brd1#", "", "25%"};
				{ 3, 11731, "", "=q3=Savage Gladiator Greaves", "=ds=#s12#, #a3# =q2=#brd1#", "", "25%"};
				{ 4, 11678, "", "=q3=Carapace of Anub'shiah", "=ds=#s5#, #a4# =q2=#brd1#", "", "25%"};
				{ 6, 11685, "", "=q3=Splinthide Shoulders", "=ds=#s3#, #a2# =q2=#brd2#", "", "25%%"};
				{ 7, 11686, "", "=q3=Girdle of Beastial Fury", "=ds=#s10#, #a2# =q2=#brd2#", "", "25%%"};
				{ 8, 11679, "", "=q3=Rubicund Armguards", "=ds=#s8#, #a3# =q2=#brd2#", "", "25%%"};
				{ 9, 11730, "", "=q3=Savage Gladiator Grips", "=ds=#s9#, #a3# =q2=#brd2#", "", "25%%"};
				{ 11, 11726, "", "=q4=Savage Gladiator Chain", "=ds=#s5#, #a3# =q2=#brd3#", "", "25%%"};
				{ 12, 22271, "", "=q3=Leggings of Frenzied Magic", "=ds=#s11#, #a2# =q2=#brd3#", "", "25%%"};
				{ 13, 22257, "", "=q3=Bloodclot Band", "=ds=#s13# =q2=#brd3#", "", "25%%"};
				{ 14, 22266, "", "=q3=Flarethorn", "=ds=#h1#, #w4# =q2=#brd3#", "", "25%"};
				{ 16, 11722, "", "=q3=Dregmetal Spaulders", "=ds=#s3#, #a3# =q2=#brd4#", "", "25%%"};
				{ 17, 11703, "", "=q3=Stonewall Girdle", "=ds=#s10#, #a4# =q2=#brd4#", "", "25%%"};
				{ 18, 22270, "", "=q3=Entrenching Boots", "=ds=#s12#, #a4# =q2=#brd4#", "", "25%%"};
				{ 19, 11702, "", "=q3=Grizzle's Skinner", "=ds=#h1#, #w1# =q2=#brd4#", "", "25%%"};
				{ 20, 11610, "", "=q3=Plans: Dark Iron Pulverizer", "=ds=#p2# (265) =q2=#brd4#", "", "100%"};
				{ 22, 11634, "", "=q3=Silkweb Gloves", "=ds=#s9#, #a1# =q2=#brd5#", "", "25%%"};
				{ 23, 11729, "", "=q3=Savage Gladiator Helm", "=ds=#s1#, #a3# =q2=#brd3#, #brd5#", "", "25%%"};
				{ 24, 11633, "", "=q3=Spiderfang Carapace", "=ds=#s5#, #a4# =q2=#brd5#", "", "25%%"};
				{ 25, 11635, "", "=q3=Hookfang Shanker", "=ds=#h1#, #w4# =q2=#brd5#", "", "25%%"};
				{ 27, 11662, "", "=q3=Ban'thok Sash", "=ds=#s10#, #a1# =q2=#brd6#", "", "25%%"};
				{ 28, 11665, "", "=q3=Ogreseer Fists", "=ds=#s9#, #a2# =q2=#brd6#", "", "25%%"};
				{ 29, 11728, "", "=q3=Savage Gladiator Leggings", "=ds=#s11#, #a3# =q2=#brd6#", "", "25%%"};
				{ 30, 11824, "", "=q3=Cyclopean Band", "=ds=#s13# =q2=#brd6#", "", "25%%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ring of Law", 372),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDGeneralAngerforge"] = {
		["Normal"] = {
			{
				{ 1, 11821, "", "=q3=Warstrife Leggings", "=ds=#s11#, #a2#", "", "20%"};
				{ 2, 11820, "", "=q3=Royal Decorated Armor", "=ds=#s5#, #a3#", "", "20%"};
				{ 3, 11810, "", "=q3=Force of Will", "=ds=#s14#", "", "20%"};
				{ 4, 11817, "", "=q3=Lord General's Sword", "=ds=#h1#, #w10# ", "", "20%"};
				{ 5, 11816, "", "=q3=Angerforge's Battle Axe", "=ds=#h2#, #w1#", "", "20%"};
				{ 16, 64302, "", "=q1=General's Attack Plans", "=ds=#m3#, =q1=#m1# =ds=#c9#", "", " 100%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("General Angerforge", 378),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDGolemLordArgelmach"] = {
		["Normal"] = {
			{
				{ 1, 11822, "", "=q3=Omnicast Boots", "=ds=#s12#, #a1#", "", "25%"};
				{ 2, 11823, "", "=q3=Luminary Kilt", "=ds=#s11#, #a2#", "", "25%"};
				{ 3, 11669, "", "=q3=Naglering", "=ds=#s13#", "", "25%"};
				{ 4, 11819, "", "=q3=Second Wind", "=ds=#s14#", "", "25%"};
				{ 16, 21956, "", "=q2=Design: Dark Iron Scorpid", "=ds=#p12# (300)"};
				{ 18, 64303, "", "=q1=Elemental Golem Blueprints", "=ds=#m3#, =q1=#m1# =ds=#c2#", "", " 100%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Golem Lord Argelmach", 379),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDBSPlans"] = {
		["Normal"] = {
			{
				{ 1, 11614, "", "=q2=Plans: Dark Iron Mail", "=ds=#p2# (270)", "", "100%"};
				{ 2, 11615, "", "=q2=Plans: Dark Iron Shoulders", "=ds=#p2# (280)", "", "100%"};
			};
		};
		info = {
			name = AL["BRD Blacksmithing Plans"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDGuzzler"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Hurley Blackbreath", 380), ""};
				{ 2, 11735, "", "=q3=Ragefury Eyepatch", "=ds=#s1#, #a2#", "", "10%"};
				{ 3, 18043, "", "=q3=Coal Miner Boots", "=ds=#s12#, #a2#", "", "30%"};
				{ 4, 22275, "", "=q3=Firemoss Boots", "=ds=#s12#, #a2#", "", "30%"};
				{ 5, 18044, "", "=q3=Hurley's Tankard", "=ds=#h1#, #w6#", "", "30%"};
				{ 6, 11312, "", "=q1=Lost Thunderbrew Recipe", "=ds=#m3#"};
				{ 8, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Phalanx", 381), ""};
				{ 9, 22212, "", "=q3=Golem Fitted Pauldrons", "=ds=#s3#, #a3#", "", "26.04%"};
				{ 10, 11745, "", "=q3=Fists of Phalanx", "=ds=#s9#, #a4#", "", "29.79%"};
				{ 11, 11744, "", "=q3=Bloodfist", "=ds=#h1#, #w13#", "", "28.48%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Ribbly Screwspigot", 382), ""};
				{ 17, 11612, "", "=q3=Plans: Dark Iron Plate", "=ds=#p2# (285)", "", "50%"};
				{ 18, 11742, "", "=q3=Wayfarer's Knapsack", "=ds=#e1#", "", "50%"};
				{ 20, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Plugger Spazzring", 383), ""};
				{ 21, 12793, "", "=q3=Mixologist's Tunic", "=ds=#s5#, #a2#", "", "30%"};
				{ 22, 12791, "", "=q3=Barman Shanker", "=ds=#h1#, #w4#", "", "10%"};
				{ 23, 13483, "", "=q2=Recipe: Transmute Fire to Earth", "=ds=#p1# (275)"};
				{ 24, 18653, "", "=q2=Schematic: Goblin Jumper Cables XL", "=ds=#p5# (265)", "", "20%"};
				{ 25, 15759, "", "=q1=Pattern: Black Dragonscale Breastplate", "=ds=#p7# (290)"};
				{ 26, 11602, "", "=q1=Grim Guzzler Key", "=ds=#e9#"};
				{ 27, 11325, "", "=q1=Dark Iron Ale Mug", "=ds=#m3#"};
			};
		};
		info = {
			name = AL["The Grim Guzzler"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDFlamelash"] = {
		["Normal"] = {
			{
				{ 1, 11808, "", "=q4=Circle of Flame", "=ds=#s1#, #a1#", "", "5%"};
				{ 3, 11812, "", "=q3=Cape of the Fire Salamander", "=ds=#s4#", "", "25%"};
				{ 4, 11814, "", "=q3=Molten Fists", "=ds=#s9#, #a3#", "", "25%"};
				{ 5, 11832, "", "=q3=Burst of Knowledge", "=ds=#s14#", "", "25%"};
				{ 6, 11809, "", "=q3=Flame Wrath", "=ds=#w7#", "", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ambassador Flamelash", 384),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDTomb"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleBoss["Chest of The Seven"], ""};
				{ 2, 11929, "", "=q3=Haunting Specter Leggings", "=ds=#s11#, #a1#", "", "25%"};
				{ 3, 11925, "", "=q3=Ghostshroud", "=ds=#s1#, #a2#", "", "25%"};
				{ 4, 11926, "", "=q3=Deathdealer Breastplate", "=ds=#s5#, #a3#", "", "25%"};
				{ 5, 11927, "", "=q3=Legplates of the Eternal Guardian", "=ds=#s11#, #a4#", "", "25%"};
				{ 6, 11922, "", "=q3=Blood-Etched Blade", "=ds=#h1#, #w4#", "", "25%"};
				{ 7, 11920, "", "=q3=Wraith Scythe", "=ds=#h1# #w1#", "", "25%"};
				{ 8, 11923, "", "=q3=The Hammer of Grace", "=ds=#h1#, #w6#", "", "25%"};
				{ 9, 11921, "", "=q3=Impervious Giant", "=ds=#h2#, #w6#", "", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Seven", 385),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDMagmus"] = {
		["Normal"] = {
			{
				{ 1, 11746, "", "=q3=Golem Skull Helm", "=ds=#s1#, #a4#", "", "20%"};
				{ 2, 11935, "", "=q3=Magmus Stone", "=ds=#s15#", "", "20%"};
				{ 3, 22208, "", "=q3=Lavastone Hammer", "=ds=#h2#, #w6#", "", "20%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Magmus", 386),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDImperatorDagranThaurissan"] = {
		["Normal"] = {
			{
				{ 1, 11684, "", "=q4=Ironfoe", "=ds=#h1#, #w6#", "", "5%"};
				{ 3, 11930, "", "=q3=The Emperor's New Cape", "=ds=#s4#", "", "20%"};
				{ 4, 11924, "", "=q3=Robes of the Royal Crown", "=ds=#s5#, #a1#", "", "20%"};
				{ 5, 22204, "", "=q3=Wristguards of Renown", "=ds=#s8#, #a2#", "", "20%"};
				{ 6, 22207, "", "=q3=Sash of the Grand Hunt", "=ds=#s10#, #a3#", "", "20%"};
				{ 7, 11933, "", "=q3=Imperial Jewel", "=ds=#s2#", "", "20%"};
				{ 8, 11934, "", "=q3=Emperor's Seal", "=ds=#s13#", "", "20%"};
				{ 9, 11815, "", "=q3=Hand of Justice", "=ds=#s14#", "", "20%"};
				{ 16, 11931, "", "=q3=Dreadforge Retaliator", "=ds=#h2#, #w1#", "", "20%"};
				{ 17, 11932, "", "=q3=Guiding Stave of Wisdom", "=ds=#w9#", "", "20%"};
				{ 18, 11928, "", "=q3=Thaurissan's Royal Scepter", "=ds=#s15#", "", "20%"};
				{ 20, 12033, "", "=q1=Thaurissan Family Jewels", "=ds=#e7# #e1#", "", "3%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Emperor Dagran Thaurissan", 387),
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDPrincess"] = {
		["Normal"] = {
			{
				{ 1, 12554, "", "=q3=Hands of the Exalted Herald", "=ds=#s9#, #a1#", "", "25%"};
				{ 2, 12556, "", "=q3=High Priestess Boots", "=ds=#s12#, #a1#", "", "25%"};
				{ 3, 12557, "", "=q3=Ebonsteel Spaulders", "=ds=#s3#, #a4#", "", "25%"};
				{ 4, 12553, "", "=q3=Swiftwalker Boots", "=ds=#s12#, #a2#", "", "25%"};
			};
		};
		info = {
			name = BabbleBoss["Princess Moira Bronzebeard"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDPanzor"] = {
		["Normal"] = {
			{
				{ 1, 22245, "", "=q3=Soot Encrusted Footwear", "=ds=#s12#,#a1#", "", "25%"};
				{ 2, 11787, "", "=q3=Shalehusk Boots", "=ds=#s12#, #a4#", "", "25%"};
				{ 3, 11786, "", "=q3=Stone of the Earth", "=ds=#h2#, #w10#", "", "25%"};
				{ 4, 11785, "", "=q3=Rock Golem Bulwark", "=ds=#w8#", "", "25%"};
			};
		};
		info = {
			name = BabbleBoss["Panzor the Invincible"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDQuestItems"] = {
		["Normal"] = {
			{
				{ 1, 18412, "", "=q1=Core Fragment", "=ds=#m3#", "", "100%"};
				{ 3, 0, "INV_Box_01", "=q6="..AL["Shadowforge Flame Keeper"], ""};
				{ 4, 11885, "", "=q1=Shadowforge Torch", "=ds=#m20#"};
			};
		};
		info = {
			name = ALIL["Blackrock Depths"].." - "..AL["Quest Item"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

	AtlasLoot_Data["BRDTrash"] = {
		["Normal"] = {
			{
				{ 1, 12552, "", "=q3=Blisterbane Wrap", "=ds=#s4#"};
				{ 2, 12551, "", "=q3=Stoneshield Cloak", "=ds=#s4#"};
				{ 3, 12542, "", "=q3=Funeral Pyre Vestment", "=ds=#s5#, #a1#"};
				{ 4, 12546, "", "=q3=Aristocratic Cuffs", "=ds=#s8#, #a1#"};
				{ 5, 12550, "", "=q3=Runed Golem Shackles", "=ds=#s8#, #a2#"};
				{ 6, 12547, "", "=q3=Mar Alom's Grip", "=ds=#s9#, #a2#"};
				{ 7, 12549, "", "=q3=Braincage", "=ds=#s1#, #a3#"};
				{ 8, 12555, "", "=q3=Battlechaser's Greaves", "=ds=#s12#, #a4#"};
				{ 9, 12531, "", "=q3=Searing Needle", "=ds=#h1#, #w4#"};
				{ 10, 12535, "", "=q3=Doomforged Straightedge", "=ds=#h1#, #w10#"};
				{ 11, 12527, "", "=q3=Ribsplitter", "=ds=#h1#, #w1#"};
				{ 12, 12528, "", "=q3=The Judge's Gavel", "=ds=#h2#, #w6#"};
				{ 13, 12532, "", "=q3=Spire of the Stoneshaper", "=ds=#w9#"};
				{ 16, 15781, "", "=q3=Pattern: Black Dragonscale Leggings", "=ds=#p7# (300) =q1="..AL["Anvilrage Captain"]};
				{ 17, 15770, "", "=q3=Pattern: Black Dragonscale Shoulders", "=ds=#p7# (300) =q1="..AL["Anvilrage Marshal"]};
				{ 18, 16053, "", "=q2=Schematic: Master Engineer's Goggles", "=ds=#p5# (290) =q1="..AL["Doomforge Arcanasmith"]};
				{ 19, 16049, "", "=q2=Schematic: Dark Iron Bomb", "=ds=#p5# (285) =q1="..AL["Weapon Technician"]};
				{ 20, 16048, "", "=q2=Schematic: Dark Iron Rifle", "=ds=#p5# (275) =q1="..AL["Doomforge Craftsman"]};
				{ 21, 18654, "", "=q2=Schematic: Gnomish Alarm-o-Bot", "=ds=#p5# (265) =q1="..AL["Weapon Technician"]};
				{ 22, 18661, "", "=q2=Schematic: World Enlarger", "=ds=#p5# (260) =q1="..AL["Weapon Technician"]};
				{ 24, 11754, "", "=q2=Black Diamond", "#e8#"};
				{ 25, 11078, "", "=q1=Relic Coffer Key", "=ds=#e9#"};
				{ 26, 18945, "", "=q1=Dark Iron Residue", "=ds=#m3#"};
				{ 27, 64304, "", "=q1=Elemental Module", "=ds=#m3#, =q1=#m1# =ds=#c2#"};
				{ 28, 64313, "", "=q1=Elemental-Imbued Weapon", "=ds=#m3#, =q1=#m1# =ds=#c4#"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "BlackrockDepths",
		};
	};

		-----------------------------------
		--- Blackrock Mountain: Entrance ---
		-----------------------------------

	AtlasLoot_Data["BlackrockMountainEntLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Scarshield Quartermaster"], ""};
				{ 2, 18987, "", "=q1=Blackhand's Command", "=ds=#m2#", "", "100%"};
				{ 4, 0, "INV_Box_01", "=q6="..BabbleRare["The Behemoth"], ""};
				{ 5, 11603, "", "=q3=Vilerend Slicer", "=ds=#h1#, #w13#", "", "95%"};
				{ 7, 0, "INV_Box_01", "=q6="..BabbleBoss["Overmaster Pyron"], ""};
				{ 8, 14486, "", "=q3=Pattern: Cloak of Fire", "=ds=#p8# (275)", "", "17.95%"};
			};
		};
		info = {
			name = AL["Blackrock Mountain"],
			module = moduleName, instance = "BlackrockMountainEnt",
		};
	};

		-------------------------------------------------
		--- Blackrock Mountain: Lower Blackrock Spire ---
		-------------------------------------------------

	AtlasLoot_Data["LBRSQuestItems"] = {
		["Normal"] = {
			{
				{ 1, 12533, "", "=q1=Roughshod Pike", "=ds=#m3#"};
			};
		};
		info = {
			name = ALIL["Lower Blackrock Spire"].." - "..AL["Quest Item"],
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSSpirestoneButcher"] = {
		["Normal"] = {
			{
				{ 1, 12608, "", "=q3=Butcher's Apron", "=ds=#s4#", "", "54.31%"};
				{ 2, 13286, "", "=q3=Rivenspike", "=ds=#h1#, #w1#", "", "35.78%"};
			};
		};
		info = {
			name = BabbleBoss["Spirestone Butcher"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSOmokk"] = {
		["Normal"] = {
			{
				{ 1, 13170, "", "=q3=Skyshroud Leggings", "=ds=#s11#, #a1#", "", "8.52%"};
				{ 2, 13169, "", "=q3=Tressermane Leggings", "=ds=#s11#, #a2#", "", "9.52%"};
				{ 3, 13168, "", "=q3=Plate of the Shaman King", "=ds=#s5#, #a4#", "", "8.62%"};
				{ 4, 13166, "", "=q3=Slamshot Shoulders", "=ds=#s3#, #a4#", "", "7.25%"};
				{ 5, 13167, "", "=q3=Fist of Omokk", "=ds=#h2#, #w6#", "", "10.64%"};
				{ 7, 12534, "", "=q1=Omokk's Head", "=ds=#m3#", "", "100%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Highlord Omokk", 388),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSSpirestoneLord"] = {
		["Normal"] = {
			{
				{ 1, 13284, "", "=q3=Swiftdart Battleboots", "=ds=#s12#, #a3#", "", "48.68%"};
				{ 2, 13285, "", "=q3=The Blackrock Slicer", "=ds=#h2#, #w1#", "", "34.87%"};
			};
		};
		info = {
			name = BabbleBoss["Spirestone Battle Lord"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSLordMagus"] = {
		["Normal"] = {
			{
				{ 1, 13282, "", "=q3=Ogreseer Tower Boots", "=ds=#s12#, #a3#", "", "22.95%"};
				{ 2, 13283, "", "=q3=Magus Ring", "=ds=#s13#", "", "38.01%"};
				{ 3, 13261, "", "=q3=Globe of D'sak", "=ds=#s15#", "", "18.07%"};
			};
		};
		info = {
			name = BabbleBoss["Spirestone Lord Magus"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSVosh"] = {
		["Normal"] = {
			{
				{ 1, 12626, "", "=q3=Funeral Cuffs", "=ds=#s8#, #a1#", "", "18.74%"};
				{ 2, 13257, "", "=q3=Demonic Runed Spaulders", "=ds=#s3#, #a2#", "", "16.84%"};
				{ 3, 13255, "", "=q3=Trueaim Gauntlets", "=ds=#s9#, #a3#", "", "18.08%"};
				{ 4, 12651, "", "=q3=Blackcrow", "=ds=#w3#", "", "8.56%"};
				{ 5, 12653, "", "=q3=Riphook", "=ds=#w2#", "", "7.99%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Shadow Hunter Vosh'gajin", 389),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSVoone"] = {
		["Normal"] = {
			{
				{ 1, 22231, "", "=q3=Kayser's Boots of Precision", "=ds=#s12#, #a1#", "", "15.40%"};
				{ 2, 13179, "", "=q3=Brazecore Armguards", "=ds=#s8#, #a3#", "", "16.12%"};
				{ 3, 13177, "", "=q3=Talisman of Evasion", "=ds=#s2#", "", "15.40%"};
				{ 4, 12582, "", "=q3=Keris of Zul'Serak", "=ds=#h1#, #w4#", "", "8.08%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("War Master Voone", 390),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSGrimaxe"] = {
		["Normal"] = {
			{
				{ 1, 12634, "", "=q3=Chiselbrand Girdle", "=ds=#s10#, #a3#", "", "31.73%"};
				{ 2, 12637, "", "=q3=Backusarian Gauntlets", "=ds=#s9#, #a4#", "", "26.44%"};
				{ 3, 12621, "", "=q3=Demonfork", "=ds=#h1#, #w1#", "", "27.64%"};
				{ 5, 12838, "", "=q3=Plans: Arcanite Reaper", "=ds=#p2# (300)", "", "6.73%"};
				{ 6, 12784, "", "=q3=Arcanite Reaper", "=ds=#h2#, #w1#"};
			};
		};
		info = {
			name = BabbleBoss["Bannok Grimaxe"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSSmolderweb"] = {
		["Normal"] = {
			{
				{ 1, 13244, "", "=q3=Gilded Gauntlets", "=ds=#s9#, #a3#", "", "25.06%"};
				{ 2, 13213, "", "=q3=Smolderweb's Eye", "=ds=#s14#", "", "24.97%"};
				{ 3, 13183, "", "=q3=Venomspitter", "=ds=#h1#, #w6#", "", "12.49%"};
				{ 5, 68673, "", "=q3=Smolderweb Egg", "=ds=#e13#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Mother Smolderweb", 391),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSCrystalFang"] = {
		["Normal"] = {
			{
				{ 1, 13185, "", "=q3=Sunderseer Mantle", "=ds=#s3#, #a1#", "", "28.10%"};
				{ 2, 13184, "", "=q3=Fallbrush Handgrips", "=ds=#s9#, #a2#", "", "35.48%"};
				{ 3, 13218, "", "=q3=Fang of the Crystal Spider", "=ds=#h1#, #w4#", "", "17.62%"};
			};
		};
		info = {
			name = BabbleBoss["Crystal Fang"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSDoomhowl"] = {
		["Normal"] = {
			{
				{ 1, 13258, "", "=q3=Slaghide Gauntlets", "=ds=#s9#, #a2#", "", "17.09%"};
				{ 2, 22232, "", "=q3=Marksman's Girdle", "=ds=#s10#, #a3#", "", "20.60%"};
				{ 3, 13259, "", "=q3=Ribsteel Footguards", "=ds=#s12#, #a4#", "", "25.38%"};
				{ 4, 13178, "", "=q3=Rosewine Circle", "=ds=#s13#", "", "21.48%"};
				{ 6, 18784, "", "=q3=Top Half of Advanced Armorsmithing: Volume III", "=ds=#m3#", "", "10.30%"};
				{ 7, 12725, "", "=q3=Plans: Enchanted Thorium Helm", "=q1=#m4#: =ds=#p2# (300)"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Urok Doomhowl", 392).." ("..AL["Summon"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSZigris"] = {
		["Normal"] = {
			{
				{ 1, 13253, "", "=q3=Hands of Power", "=ds=#s9#, #a1#", "", "14.22%"};
				{ 2, 13252, "", "=q3=Cloudrunner Girdle", "=ds=#s10#, #a2#", "", "15.48%"};
				{ 4, 12835, "", "=q3=Plans: Annihilator", "=ds=#p2# (300)", "", "8.37%"};
				{ 5, 12798, "", "=q3=Annihilator", "=ds=#h1#, #w1#"};
				{ 7, 21955, "", "=q2=Design: Black Diamond Crab", "=ds=#p12# (300)"};
				{ 16, 12264, "", "=q3=Worg Carrier", "=ds=#e13#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Quartermaster Zigris", 393),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSSlavener"] = {
		["Normal"] = {
			{
				{ 1, 13206, "", "=q3=Wolfshear Leggings", "=ds=#s11#, #a1#", "", "17.46%"};
				{ 2, 13208, "", "=q3=Bleak Howler Armguards", "=ds=#s8#, #a2#", "", "18.02%"};
				{ 3, 13205, "", "=q3=Rhombeard Protector", "=ds=#w8#", "", "16.93%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Gizrul the Slavener", 395),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSHalycon"] = {
		["Normal"] = {
			{
				{ 1, 22313, "", "=q3=Ironweave Bracers", "=ds=#s8#, #a1#", "", "18.16%"};
				{ 2, 13210, "", "=q3=Pads of the Dread Wolf", "=ds=#s12#, #a2#", "", "9.88%"};
				{ 3, 13211, "", "=q3=Slashclaw Bracers", "=ds=#s8#, #a3#", "", "20.32%"};
				{ 4, 13212, "", "=q3=Halycon's Spiked Collar", "=ds=#s2#", "", "18.23%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Halycon", 394),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSBashguud"] = {
		["Normal"] = {
			{
				{ 1, 13203, "", "=q3=Armswake Cloak", "=ds=#s4#", "", "35.31%"};
				{ 2, 13198, "", "=q3=Hurd Smasher", "=ds=#h1#, #w13#", "", "21.15%"};
				{ 3, 13204, "", "=q3=Bashguuder", "=ds=#h1#, #w6#", "", "27.09%"};
			};
		};
		info = {
			name = BabbleBoss["Ghok Bashguud"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSWyrmthalak"] = {
		["Normal"] = {
			{
				{ 1, 13143, "", "=q4=Mark of the Dragon Lord", "=ds=#s13#", "", "1.11%"};
				{ 3, 13162, "", "=q3=Reiver Claws", "=ds=#s9#, #a4#", "", "12.14%"};
				{ 4, 13164, "", "=q3=Heart of the Scale", "=ds=#s14#", "", "0.73%"};
				{ 5, 22321, "", "=q3=Heart of Wyrmthalak", "=ds=#s14#", "", "13.87%"};
				{ 6, 13163, "", "=q3=Relentless Scythe", "=ds=#h2#, #w10#", "", "14.12%"};
				{ 7, 13148, "", "=q3=Chillpike", "=ds=#w7#", "", "0.76%"};
				{ 8, 13161, "", "=q3=Trindlehaven Staff", "=ds=#w9#", "", "10.40%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Overlord Wyrmthalak", 396),
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSFelguard"] = {
		["Normal"] = {
			{
				{ 1, 13181, "", "=q3=Demonskin Gloves", "=ds=#s9#, #a1#", "", "14.47%"};
				{ 2, 13182, "", "=q3=Phase Blade", "=ds=#h1#, #w10#", "", "11.63%"};
			};
		};
		info = {
			name = BabbleBoss["Burning Felguard"].." ("..AL["Rare"]..", "..AL["Random"]..")",
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

	AtlasLoot_Data["LBRSTrash"] = {
		["Normal"] = {
			{
				{ 1, 14513, "", "=q4=Pattern: Robe of the Archmage", "=ds=#p8# (300) =q1=#m1# =ds=#c3# =q1="..AL["Firebrand Pyromancer"], "", "10.12%"};
				{ 2, 14152, "", "=q4=Robe of the Archmage", "=ds=#s5#, #a1# =q1=#m1# =ds=#c3#"};
				{ 4, 13494, "", "=q2=Recipe: Greater Fire Protection Potion", "=ds=#p1# (290) =q1="..AL["Firebrand Pyromancer"].." / "..AL["Firebrand Invoker"], "", "1.94%"};
				{ 5, 16250, "", "=q2=Formula: Enchant Weapon - Superior Striking", "=ds=#p4# (300) =q1="..AL["Firebrand Grunt"], "", "1.04%"};
				{ 6, 16244, "", "=q2=Formula: Enchant Gloves - Greater Strength", "=ds=#p4# (295) =q1=".. AL["Firebrand Legionnaire"], "", "4.16%"};
				{ 7, 15749, "", "=q2=Pattern: Volcanic Breastplate", "=ds=#p7# (285) =q1="..AL["Spirestone Warlord"], "", "2.04%"};
				{ 8, 15775, "", "=q2=Pattern: Volcanic Shoulders", "=ds=#p7# (300) =q1="..AL["Spirestone Mystic"], "", "10.56%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "BlackrockSpireLower",
		};
	};

		-------------------------------------------------
		--- Blackrock Mountain: Upper Blackrock Spire ---
		-------------------------------------------------

	AtlasLoot_Data["UBRSEmberseer"] = {
		["Normal"] = {
			{
				{ 1, 12905, "", "=q3=Wildfire Cape", "=ds=#s4#", "", "15.20%"};
				{ 2, 12927, "", "=q3=Truestrike Shoulders", "=ds=#s3#, #a2#", "", "17.47%"};
				{ 3, 12929, "", "=q3=Emberfury Talisman", "=ds=#s2#", "", "15.89%"};
				{ 4, 12926, "", "=q3=Flaming Band", "=ds=#s13#", "", "18.52%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Pyroguard Emberseer", 397),
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSSolakar"] = {
		["Normal"] = {
			{
				{ 1, 12609, "", "=q3=Polychromatic Visionwrap", "=ds=#s5#, #a1#", "", "15.82%"};
				{ 2, 12589, "", "=q3=Dustfeather Sash", "=ds=#s10#, #a1#", "", "12.84%"};
				{ 3, 12603, "", "=q3=Nightbrace Tunic", "=ds=#s5#, #a2#", "", "15.06%"};
				{ 4, 12606, "", "=q3=Crystallized Girdle", "=ds=#s10#, #a2#", "", "14.04%"};
				{ 6, 18657, "", "=q2=Schematic: Hyper-Radiant Flame Reflector", "=ds=#p5# (290)", "", "7.38%"};
				{ 7, 18638, "", "=q3=Hyper-Radiant Flame Reflector", "=ds=#s14#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Solakar Flamewreath", 398),
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSAnvilcrack"] = {
		["Normal"] = {
			{
				{ 1, 18047, "", "=q3=Flame Walkers", "=ds=#s12#, #a3#", "", "18.05%"};
				{ 2, 13502, "", "=q3=Handcrafted Mastersmith Girdle", "=ds=#s10#, #a4#", "", "15.78%"};
				{ 3, 13498, "", "=q3=Handcrafted Mastersmith Leggings", "=ds=#s11#, #a4#", "", "20.63%"};
				{ 4, 18048, "", "=q3=Mastersmith's Hammer", "=ds=#h1#, #w6#", "", "17.26%"};
				{ 16, 12837, "", "=q3=Plans: Masterwork Stormhammer", "=ds=#p2# (300)", "", "4.80%"};
				{ 17, 12794, "", "=q3=Masterwork Stormhammer", "=ds=#h1#, #w6#"};
				{ 18, 12834, "", "=q3=Plans: Arcanite Champion", "=ds=#p2# (300)", "", "4.75%"};
				{ 19, 12790, "", "=q3=Arcanite Champion", "=ds=#h2#, #w10#"};
				{ 21, 18779, "", "=q3=Bottom Half of Advanced Armorsmithing: Volume I", "=ds=#m3#", "", "17.08%"};
				{ 22, 12727, "", "=q3=Plans: Enchanted Thorium Breastplate", "=q1=#m4#: =ds=#p2# (300)"};
			};
		};
		info = {
			name = BabbleBoss["Goraluk Anvilcrack"],
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSRend"] = {
		["Normal"] = {
			{
				{ 1, 12590, "", "=q4=Felstriker", "=ds=#h1#, #w4#", "", "1.06%"};
				{ 3, 22247, "", "=q3=Faith Healer's Boots", "=ds=#s12#, #a1#", "", "12.71%"};
				{ 4, 18102, "", "=q3=Dragonrider Boots", "=ds=#s12#, #a1#", "", "14.35%"};
				{ 5, 12587, "", "=q3=Eye of Rend", "=ds=#s1#, #a2#", "", "14.50%"};
				{ 6, 12588, "", "=q3=Bonespike Shoulder", "=ds=#s3#, #a3#", "", "0.85%"};
				{ 7, 18104, "", "=q3=Feralsurge Girdle", "=ds=#s10#, #a3#", "", "15.30%"};
				{ 8, 12936, "", "=q3=Battleborn Armbraces", "=ds=#s8#, #a4#", "", "16.96%"};
				{ 9, 12935, "", "=q3=Warmaster Legguards", "=ds=#s11#, #a4#", "", "15.05%"};
				{ 10, 18103, "", "=q3=Band of Rumination", "=ds=#s13#", "", "15.38%"};
				{ 16, 12940, "", "=q3=Dal'Rend's Sacred Charge", "=ds=#h3#, #w10#", "", "6.79%"};
				{ 17, 12939, "", "=q3=Dal'Rend's Tribal Guardian", "=ds=#h4#, #w10#", "", "7.61%"};
				{ 18, 12583, "", "=q3=Blackhand Doomsaw", "=ds=#w7#", "", "7.44%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Warchief Rend Blackhand", 399),
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSGyth"] = {
		["Normal"] = {
			{
				{ 1, 22225, "", "=q3=Dragonskin Cowl", "=ds=#s1#, #a1#", "", "11.85%"};
				{ 2, 12960, "", "=q3=Tribal War Feathers", "=ds=#s1#, #a2#", "", "15.24%"};
				{ 3, 12953, "", "=q3=Dragoneye Coif", "=ds=#s1#, #a3#", "", "15.99%"};
				{ 4, 12952, "", "=q3=Gyth's Skull", "=ds=#s1#, #a4#", "", "12.43%"};
			};
		};
		info = {
			name = BabbleBoss["Gyth"],
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSBeast"] = {
		["Normal"] = {
			{
				{ 1, 12967, "", "=q3=Bloodmoon Cloak", "=ds=#s4#", "", "18.30%"};
				{ 2, 12968, "", "=q3=Frostweaver Cape", "=ds=#s4#", "", "14.47%"};
				{ 3, 12965, "", "=q3=Spiritshroud Leggings", "=ds=#s11#, #a1#", "", "13.16%"};
				{ 4, 22311, "", "=q3=Ironweave Boots", "=ds=#s12#, #a1#", "", "12.31%"};
				{ 5, 12966, "", "=q3=Blackmist Armguards", "=ds=#s8#, #a2#", "", "16.06%"};
				{ 6, 12963, "", "=q3=Blademaster Leggings", "=ds=#s11#, #a2#", "", "12.74%"};
				{ 7, 12964, "", "=q3=Tristam Legguards", "=ds=#s11#, #a3#", "", "18.16%"};
				{ 8, 12709, "", "=q3=Finkle's Skinner", "=ds=#h1#, #w4#", "", "6.95%"};
				{ 9, 12969, "", "=q3=Seeping Willow", "=ds=#h2#, #w6#", "", "11.49%"};
				{ 16, 19227, "", "=q3=Ace of Beasts", "=ds=#e16#", "", "4.53%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Beast", 400),
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSDrakkisath"] = {
		["Normal"] = {
			{
				{ 1, 12592, "", "=q4=Blackblade of Shahram", "=ds=#h2#, #w10#", "", "1.08%"};
				{ 3, 22269, "", "=q3=Shadow Prowler's Cloak", "=ds=#s4#", "", "10.61%"};
				{ 4, 22267, "", "=q3=Spellweaver's Turban", "=ds=#s1#, #a1#", "", "15.50%"};
				{ 5, 13142, "", "=q3=Brigam Girdle", "=ds=#s10#, #a4#", "", "16.40%"};
				{ 6, 13141, "", "=q3=Tooth of Gnarr", "=ds=#s2#", "", "16.83%"};
				{ 7, 13098, "", "=q3=Painweaver Band", "=ds=#s13#", "", "13.51%"};
				{ 8, 22268, "", "=q3=Draconic Infused Emblem", "=ds=#s14#", "", "4.13%"};
				{ 9, 22253, "", "=q3=Tome of the Lost", "=ds=#s15#", "", "16.05%"};
				{ 10, 12602, "", "=q3=Draconian Deflector", "=ds=#w8#", "", "14.52%"};
				{ 16, 15730, "", "=q3=Pattern: Red Dragonscale Breastplate", "=ds=#p7# (300)", "", "3.58%"};
				{ 17, 15047, "", "=q3=Red Dragonscale Breastplate", "=ds=#s5#, #a3#"};
				{ 19, 13519, "", "=q2=Recipe: Flask of the Titans", "=ds=#p1# (300)", "", "1.72%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("General Drakkisath", 401),
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSFLAME"] = {
		["Normal"] = {
			{
				{ 1, 13371, "", "=q3=Father Flame", "=ds=#s15#", "", "100%"};
			};
		};
		info = {
			name = AL["Father Flame"],
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSRunewatcher"] = {
		["Normal"] = {
			{
				{ 1, 12604, "", "=q3=Starfire Tiara", "=ds=#s1#, #a1#", "", "28.64%"};
				{ 2, 12930, "", "=q3=Briarwood Reed", "=ds=#s14#", "", "26.36%"};
				{ 3, 12605, "", "=q3=Serpentine Skuller", "=ds=#w12#", "", "32.95%"};
			};
		};
		info = {
			name = BabbleBoss["Jed Runewatcher"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

	AtlasLoot_Data["UBRSTrash"] = {
		["Normal"] = {
			{
				{ 1, 13260, "", "=q3=Wind Dancer Boots", "=ds=#s12#, #a3#", "", "0.01%"};
				{ 3, 16247, "", "=q2=Formula: Enchant 2H Weapon - Superior Impact", "=ds=#p4# (295) =q1="..AL["Blackhand Elite"], "", "1.54%"};
				{ 5, 12607, "", "=q3=Brilliant Chromatic Scale", "#e8#"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "BlackrockSpireUpper",
		};
	};

		------------------------------------------
		--- Blackrock Mountain: Blackwing Lair ---
		------------------------------------------

	AtlasLoot_Data["BWLRazorgore"] = {
		["Normal"] = {
			{
				{ 1, 16918, "", "=q4=Netherwind Bindings", "=q1=#m1# =ds=#c3#", "", "20.41%"};
				{ 2, 16926, "", "=q4=Bindings of Transcendence", "=q1=#m1# =ds=#c5#", "", "20.37%"};
				{ 3, 16934, "", "=q4=Nemesis Bracers", "=q1=#m1# =ds=#c8#", "", "18.11%"};
				{ 4, 16911, "", "=q4=Bloodfang Bracers", "=q1=#m1# =ds=#c6#", "", "20.69%"};
				{ 5, 16904, "", "=q4=Stormrage Bracers", "=q1=#m1# =ds=#c1#", "", "17.38%"};
				{ 6, 16935, "", "=q4=Dragonstalker's Bracers", "=q1=#m1# =ds=#c2#", "", "19.13%"};
				{ 7, 16943, "", "=q4=Bracers of Ten Storms", "=q1=#m1# =ds=#c7#", "", "7.54%"};
				{ 8, 16959, "", "=q4=Bracelets of Wrath", "=q1=#m1# =ds=#c9#", "", "20.29%"};
				{ 9, 16951, "", "=q4=Judgement Bindings", "=q1=#m1# =ds=#c4#", "", "13.61%"};
				{ 16, 19337, "", "=q4=The Black Book", "=ds=#s14#, =q1=#m1# =ds=#c8#", "", "18.37%"};
				{ 17, 19336, "", "=q4=Arcane Infused Gem", "=ds=#s14#, =q1=#m1# =ds=#c2#", "", "17.33%"};
				{ 19, 19370, "", "=q4=Mantle of the Blackwing Cabal", "=ds=#s3#, #a1#", "", "18.57%"};
				{ 20, 19369, "", "=q4=Gloves of Rapid Evolution", "=ds=#s9#, #a1#", "", "17.52%"};
				{ 21, 19334, "", "=q4=The Untamed Blade", "=ds=#h2#, #w10#", "", "9.76%"};
				{ 22, 19335, "", "=q4=Spineshatter", "=ds=#h1#, #w6#", "", "10.44%"};
				{ 24, 93036, "", "=q3=Unscathed Egg", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["Razorgore the Untamed"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLVaelastrasz"] = {
		["Normal"] = {
			{
				{ 1, 16818, "", "=q4=Netherwind Belt", "=q1=#m1# =ds=#c3#", "", "19.94%"};
				{ 2, 16925, "", "=q4=Belt of Transcendence", "=q1=#m1# =ds=#c5#", "", "18.76%"};
				{ 3, 16933, "", "=q4=Nemesis Belt", "=q1=#m1# =ds=#c8#", "", "18.42%"};
				{ 4, 16936, "", "=q4=Dragonstalker's Belt", "=q1=#m1# =ds=#c2#", "", "20.17%"};
				{ 5, 16903, "", "=q4=Stormrage Belt", "=q1=#m1# =ds=#c1#", "", "16.90%"};
				{ 6, 16910, "", "=q4=Bloodfang Belt", "=q1=#m1# =ds=#c6#", "", "19.69%"};
				{ 7, 16944, "", "=q4=Belt of Ten Storms", "=q1=#m1# =ds=#c7#", "", "6.93%"};
				{ 8, 16960, "", "=q4=Waistband of Wrath", "=q1=#m1# =ds=#c9#", "", "20.03%"};
				{ 9, 16952, "", "=q4=Judgement Belt", "=q1=#m1# =ds=#c4#", "", "12.23%"};
				{ 16, 19339, "", "=q4=Mind Quickening Gem", "=ds=#s14#, =q1=#m1# =ds=#c3#", "", "18.96%"};
				{ 17, 19340, "", "=q4=Rune of Metamorphosis", "=ds=#s14#, =q1=#m1# =ds=#c1#", "", "17.66%"};
				{ 19, 19372, "", "=q4=Helm of Endless Rage", "=ds=#s1#, #a4#", "", "16.76%"};
				{ 20, 19371, "", "=q4=Pendant of the Fallen Dragon", "=ds=#s2#", "", "18.56%"};
				{ 21, 19346, "", "=q4=Dragonfang Blade", "=ds=#h1#, #w4#", "", "9.40%"};
				{ 22, 19348, "", "=q4=Red Dragonscale Protector", "=ds=#w8#", "", "8.57%"};
			};
		};
		info = {
			name = BabbleBoss["Vaelastrasz the Corrupt"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLLashlayer"] = {
		["Normal"] = {
			{
				{ 1, 16912, "", "=q4=Netherwind Boots", "=q1=#m1# =ds=#c3#", "", "17.17%"};
				{ 2, 16919, "", "=q4=Boots of Transcendence", "=q1=#m1# =ds=#c5#", "", "14.61%"};
				{ 3, 16927, "", "=q4=Nemesis Boots", "=q1=#m1# =ds=#c8#", "", "15.32%"};
				{ 4, 16898, "", "=q4=Stormrage Boots", "=q1=#m1# =ds=#c1#", "", "13.79%"};
				{ 5, 16906, "", "=q4=Bloodfang Boots", "=q1=#m1# =ds=#c6#", "", "15.66%"};
				{ 6, 16941, "", "=q4=Dragonstalker's Greaves", "=q1=#m1# =ds=#c2#", "", "17.78%"};
				{ 7, 16949, "", "=q4=Greaves of Ten Storms", "=q1=#m1# =ds=#c7#", "", "5.57%"};
				{ 8, 16965, "", "=q4=Sabatons of Wrath", "=q1=#m1# =ds=#c9#", "", "16.84%"};
				{ 9, 16957, "", "=q4=Judgement Sabatons", "=q1=#m1# =ds=#c4#", "", "11.28%"};
				{ 16, 19342, "", "=q4=Venomous Totem", "=ds=#s14#, =q1=#m1# =ds=#c6#", "", "15.06%"};
				{ 17, 19341, "", "=q4=Lifegiving Gem", "=ds=#s14#, =q1=#m1# =ds=#c9#", "", "14.27%"};
				{ 19, 19374, "", "=q4=Bracers of Arcane Accuracy", "=ds=#s8#, #a1#", "", "15.03%"};
				{ 20, 19373, "", "=q4=Black Brood Pauldrons", "=ds=#s3#, #a3#", "", "17.25%"};
				{ 21, 19351, "", "=q4=Maladath, Runed Blade of the Black Flight", "=ds=#h1#, #w10#", "", "9.62%"};
				{ 22, 19350, "", "=q4=Heartstriker", "=ds=#w2#", "", "8.45%"};
				{ 24, 93037, "", "=q3=Blackwing Banner", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["Broodlord Lashlayer"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLFiremaw"] = {
		["Normal"] = {
			{
				{ 1, 16913, "", "=q4=Netherwind Gloves", "=q1=#m1# =ds=#c3#", "", "7.37%"};
				{ 2, 16920, "", "=q4=Handguards of Transcendence", "=q1=#m1# =ds=#c5#", "", "6.01%"};
				{ 3, 16928, "", "=q4=Nemesis Gloves", "=q1=#m1# =ds=#c8#", "", "5.28%"};
				{ 4, 16907, "", "=q4=Bloodfang Gloves", "=q1=#m1# =ds=#c6#", "", "6.84%"};
				{ 5, 16940, "", "=q4=Dragonstalker's Gauntlets", "=q1=#m1# =ds=#c2#", "", "6.13%"};
				{ 6, 16899, "", "=q4=Stormrage Handguards", "=q1=#m1# =ds=#c1#", "", "5.34%"};
				{ 7, 16948, "", "=q4=Gauntlets of Ten Storms", "=q1=#m1# =ds=#c7#", "", "2.13%"};
				{ 8, 16964, "", "=q4=Gauntlets of Wrath", "=q1=#m1# =ds=#c9#", "", "5.93%"};
				{ 9, 16956, "", "=q4=Judgement Gauntlets", "=q1=#m1# =ds=#c4#", "", "3.58%"};
				{ 11, 19365, "", "=q4=Claw of the Black Drake", "=ds=#h1#, #w13#", "", "15.97%"};
				{ 12, 19355, "", "=q4=Shadow Wing Focus Staff", "=ds=#w9#", "", "3.70%"};
				{ 13, 19353, "", "=q4=Drake Talon Cleaver", "=ds=#h2#, #w1#", "", "3.18%"};
				{ 16, 19343, "", "=q4=Scrolls of Blinding Light", "=ds=#s14#, =q1=#m1# =ds=#c4#", "", "9.17%"};
				{ 17, 19344, "", "=q4=Natural Alignment Crystal", "=ds=#s14#, =q1=#m1# =ds=#c7#", "", "4.03%"};
				{ 19, 19398, "", "=q4=Cloak of Firemaw", "=ds=#s4#", "", "15.39%"};
				{ 20, 19400, "", "=q4=Firemaw's Clutch", "=ds=#s10#, #a1#", "", "14.75%"};
				{ 21, 19399, "", "=q4=Black Ash Robe", "=ds=#s5#, #a1#", "", "15.00%"};
				{ 22, 19396, "", "=q4=Taut Dragonhide Belt", "=ds=#s10#, #a2#", "", "5.44%"};
				{ 23, 19401, "", "=q4=Primalist's Linked Legguards", "=ds=#s11#, #a3#", "", "5.37%"};
				{ 24, 19394, "", "=q4=Drake Talon Pauldrons", "=ds=#s3#, #a4#", "", "6.76%"};
				{ 25, 19402, "", "=q4=Legguards of the Fallen Crusader", "=ds=#s11#, #a4#", "", "9.50%"};
				{ 27, 19397, "", "=q4=Ring of Blackrock", "=ds=#s13#", "", "5.98%"};
				{ 28, 19395, "", "=q4=Rejuvenating Gem", "=ds=#s14#", "", "5.30%"};
			};
		};
		info = {
			name = BabbleBoss["Firemaw"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLEbonroc"] = {
		["Normal"] = {
			{
				{ 1, 16913, "", "=q4=Netherwind Gloves", "=q1=#m1# =ds=#c3#", "", "6.44%"};
				{ 2, 16920, "", "=q4=Handguards of Transcendence", "=q1=#m1# =ds=#c5#", "", "6.59%"};
				{ 3, 16928, "", "=q4=Nemesis Gloves", "=q1=#m1# =ds=#c8#", "", "7.15%"};
				{ 4, 16907, "", "=q4=Bloodfang Gloves", "=q1=#m1# =ds=#c6#", "", "7.07%"};
				{ 5, 16940, "", "=q4=Dragonstalker's Gauntlets", "=q1=#m1# =ds=#c2#", "", "6.91%"};
				{ 6, 16899, "", "=q4=Stormrage Handguards", "=q1=#m1# =ds=#c1#", "", "6.32%"};
				{ 7, 16948, "", "=q4=Gauntlets of Ten Storms", "=q1=#m1# =ds=#c7#", "", "1.93%"};
				{ 8, 16964, "", "=q4=Gauntlets of Wrath", "=q1=#m1# =ds=#c9#", "", "6.19%"};
				{ 9, 16956, "", "=q4=Judgement Gauntlets", "=q1=#m1# =ds=#c4#", "", "4.45%"};
				{ 16, 19345, "", "=q4=Aegis of Preservation", "=ds=#s14#, =q1=#m1# =ds=#c5#", "", "16.47%"};
				{ 18, 19407, "", "=q4=Ebony Flame Gloves", "=ds=#s9#, #a1#", "", "16.59%"};
				{ 19, 19405, "", "=q4=Malfurion's Blessed Bulwark", "=ds=#s5#, #a2#", "", "17.03%"};
				{ 20, 19396, "", "=q4=Taut Dragonhide Belt", "=ds=#s10#, #a2#", "", "5.99%"};
				{ 21, 19394, "", "=q4=Drake Talon Pauldrons", "=ds=#s3#, #a4#", "", "5.68%"};
				{ 23, 19403, "", "=q4=Band of Forced Concentration", "=ds=#s13#", "", "14.63%"};
				{ 24, 19397, "", "=q4=Ring of Blackrock", "=ds=#s13#", "", "5.99%"};
				{ 25, 19406, "", "=q4=Drake Fang Talisman", "=ds=#s14#", "", "17.41%"};
				{ 26, 19395, "", "=q4=Rejuvenating Gem", "=ds=#s14#", "", "5.62%"};
				{ 28, 19353, "", "=q4=Drake Talon Cleaver", "=ds=#h2#, #w1#", "", "3.60%"};
				{ 29, 19355, "", "=q4=Shadow Wing Focus Staff", "=ds=#w9#", "", "2.77%"};
				{ 30, 19368, "", "=q4=Dragonbreath Hand Cannon", "=ds=#w5#", "", "8.58%"};
			};
		};
		info = {
			name = BabbleBoss["Ebonroc"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLFlamegor"] = {
		["Normal"] = {
			{
				{ 1, 16913, "", "=q4=Netherwind Gloves", "=q1=#m1# =ds=#c3#", "", "6.91%"};
				{ 2, 16920, "", "=q4=Handguards of Transcendence", "=q1=#m1# =ds=#c5#", "", "6.47%"};
				{ 3, 16928, "", "=q4=Nemesis Gloves", "=q1=#m1# =ds=#c8#", "", "6.65%"};
				{ 4, 16907, "", "=q4=Bloodfang Gloves", "=q1=#m1# =ds=#c6#", "", "6.41%"};
				{ 5, 16940, "", "=q4=Dragonstalker's Gauntlets", "=q1=#m1# =ds=#c2#", "", "6.73%"};
				{ 6, 16899, "", "=q4=Stormrage Handguards", "=q1=#m1# =ds=#c1#", "", "5.66%"};
				{ 7, 16948, "", "=q4=Gauntlets of Ten Storms", "=q1=#m1# =ds=#c7#", "", "2.72%"};
				{ 8, 16964, "", "=q4=Gauntlets of Wrath", "=q1=#m1# =ds=#c9#", "", "6.63%"};
				{ 9, 16956, "", "=q4=Judgement Gauntlets", "=q1=#m1# =ds=#c4#", "", "3.64%"};
				{ 16, 19430, "", "=q4=Shroud of Pure Thought", "=ds=#s4#", "", "17.50%"};
				{ 17, 19396, "", "=q4=Taut Dragonhide Belt", "=ds=#s10#, #a2#", "", "6.41%"};
				{ 18, 19433, "", "=q4=Emberweave Leggings", "=ds=#s11#, #a3#", "", "18.73%"};
				{ 19, 19394, "", "=q4=Drake Talon Pauldrons", "=ds=#s3#, #a4#", "", "5.95%"};
				{ 21, 19397, "", "=q4=Ring of Blackrock", "=ds=#s13#", "", "6.25%"};
				{ 22, 19432, "", "=q4=Circle of Applied Force", "=ds=#s13#", "", "18.69%"};
				{ 23, 19395, "", "=q4=Rejuvenating Gem", "=ds=#s14#", "", "5.46%"};
				{ 24, 19431, "", "=q4=Styleen's Impeding Scarab", "=ds=#s14#", "", "17.02%"};
				{ 26, 19353, "", "=q4=Drake Talon Cleaver", "=ds=#h2#, #w1#", "", "3.79%"};
				{ 27, 19357, "", "=q4=Herald of Woe", "=ds=#h2#, #w6#", "", "9.07%"};
				{ 28, 19355, "", "=q4=Shadow Wing Focus Staff", "=ds=#w9#", "", "2.66%"};
				{ 29, 19367, "", "=q4=Dragon's Touch", "=ds=#w12#", "", "9.06%"};
			};
		};
		info = {
			name = BabbleBoss["Flamegor"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLChromaggus"] = {
		["Normal"] = {
			{
				{ 1, 16917, "", "=q4=Netherwind Mantle", "=q1=#m1# =ds=#c3#", "", "18.09%"};
				{ 2, 16924, "", "=q4=Pauldrons of Transcendence", "=q1=#m1# =ds=#c5#", "", "17.83%"};
				{ 3, 16932, "", "=q4=Nemesis Spaulders", "=q1=#m1# =ds=#c8#", "", "16.26%"};
				{ 4, 16937, "", "=q4=Dragonstalker's Spaulders", "=q1=#m1# =ds=#c2#", "", "16.20%"};
				{ 5, 16902, "", "=q4=Stormrage Pauldrons", "=q1=#m1# =ds=#c1#", "", "14.63%"};
				{ 6, 16832, "", "=q4=Bloodfang Spaulders", "=q1=#m1# =ds=#c6#", "", "17.03%"};
				{ 7, 16945, "", "=q4=Epaulets of Ten Storms", "=q1=#m1# =ds=#c7#", "", "6.73%"};
				{ 8, 16953, "", "=q4=Judgement Spaulders", "=q1=#m1# =ds=#c4#", "", "10.97%"};
				{ 9, 16961, "", "=q4=Pauldrons of Wrath", "=q1=#m1# =ds=#c9#", "", "16.83%"};
				{ 11, 93038, "", "=q3=Whistle of Chromatic Bone", "=ds=#e13#", ""};
				{ 16, 19386, "", "=q4=Elementium Threaded Cloak", "=ds=#s4#", "", "18.93%"};
				{ 17, 19388, "", "=q4=Angelista's Grasp", "=ds=#s10#, #a1#", "", "16.86%"};
				{ 18, 19385, "", "=q4=Empowered Leggings", "=ds=#s11#, #a1#", "", "16.27%"};
				{ 19, 19391, "", "=q4=Shimmering Geta", "=ds=#s12#, #a1#", "", "17.46%"};
				{ 20, 19389, "", "=q4=Taut Dragonhide Shoulderpads", "=ds=#s3#, #a2#", "", "16.89%"};
				{ 21, 19390, "", "=q4=Taut Dragonhide Gloves", "=ds=#s9#, #a2#", "", "18.84%"};
				{ 22, 19393, "", "=q4=Primalist's Linked Waistguard", "=ds=#s10#, #a3#", "", "6.17%"};
				{ 23, 19392, "", "=q4=Girdle of the Fallen Crusader", "=ds=#s10#, #a4#", "", "10.97%"};
				{ 24, 19387, "", "=q4=Chromatic Boots", "=ds=#s12#, #a4#", "", "16.46%"};
				{ 26, 19347, "", "=q4=Claw of Chromaggus", "=ds=#h1#, #w4#", "", "8.39%"};
				{ 27, 19352, "", "=q4=Chromatically Tempered Sword", "=ds=#h1#, #w10#", "", "9.05%"};
				{ 28, 19349, "", "=q4=Elementium Reinforced Bulwark", "=ds=#w8#", "", "8.04%"};
				{ 29, 19361, "", "=q4=Ashjre'thul, Crossbow of Smiting", "=ds=#w3#", "", "7.51%"};
			};
		};
		info = {
			name = BabbleBoss["Chromaggus"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLNefarian"] = {
		["Normal"] = {
			{
				{ 1, 16914, "", "=q4=Netherwind Crown", "=q1=#m1# =ds=#c3#", "", "14.09%"};
				{ 2, 16916, "", "=q4=Netherwind Robes", "=q1=#m1# =ds=#c3#", "", "14.03%"};
				{ 3, 16929, "", "=q4=Nemesis Skullcap", "=q1=#m1# =ds=#c8#", "", "13.54%"};
				{ 4, 16931, "", "=q4=Nemesis Robes", "=q1=#m1# =ds=#c8#", "", "12.46%"};
				{ 5, 16921, "", "=q4=Halo of Transcendence", "=q1=#m1# =ds=#c5#", "", "13.39%"};
				{ 6, 16923, "", "=q4=Robes of Transcendence", "=q1=#m1# =ds=#c5#", "", "14.83%"};
				{ 7, 16908, "", "=q4=Bloodfang Hood", "=q1=#m1# =ds=#c6#", "", "13.21%"};
				{ 8, 16905, "", "=q4=Bloodfang Chestpiece", "=q1=#m1# =ds=#c6#", "", "14.21%"};
				{ 9, 16900, "", "=q4=Stormrage Cover", "=q1=#m1# =ds=#c1#", "", "13.08%"};
				{ 10, 16897, "", "=q4=Stormrage Chestguard", "=q1=#m1# =ds=#c1#", "", "11.89%"};
				{ 11, 16939, "", "=q4=Dragonstalker's Helm", "=q1=#m1# =ds=#c2#", "", "13.91%"};
				{ 12, 16942, "", "=q4=Dragonstalker's Breastplate", "=q1=#m1# =ds=#c2#", "", "13.30%"};
				{ 13, 16947, "", "=q4=Helmet of Ten Storms", "=q1=#m1# =ds=#c7#", "", "4.86%"};
				{ 14, 16950, "", "=q4=Breastplate of Ten Storms", "=q1=#m1# =ds=#c7#", "", "5.65%"};
				{ 15, 16963, "", "=q4=Helm of Wrath", "=q1=#m1# =ds=#c9#", "", "13.65%"};
				{ 16, 16966, "", "=q4=Breastplate of Wrath", "=q1=#m1# =ds=#c9#", "", "15.06%"};
				{ 17, 16955, "", "=q4=Judgement Crown", "=q1=#m1# =ds=#c4#", "", "8.64%"};
				{ 18, 16958, "", "=q4=Judgement Breastplate", "=q1=#m1# =ds=#c4#", "", "9.24%"};
				{ 20, 19378, "", "=q4=Cloak of the Brood Lord", "=ds=#s4#", "", "14.95%"};
				{ 21, 19375, "", "=q4=Mish'undare, Circlet of the Mind Flayer", "=ds=#s1#, #a1#", "", "14.80%"};
				{ 22, 19381, "", "=q4=Boots of the Shadow Flame", "=ds=#s12#, #a2#", "", "15.70%"};
				{ 23, 19380, "", "=q4=Therazane's Link", "=ds=#s10#, #a3#", "", "16.82%"};
				{ 25, 19377, "", "=q4=Prestor's Talisman of Connivery", "=ds=#s2#", "", "14.33%"};
				{ 26, 19376, "", "=q4=Archimtiros' Ring of Reckoning", "=ds=#s13#", "", "13.93%"};
				{ 27, 19382, "", "=q4=Pure Elementium Band", "=ds=#s13#", "", "15.15%"};
				{ 28, 19379, "", "=q4=Neltharion's Tear", "=ds=#s14#", "", "14.26%"};
			};
			{
				{ 1, 19003, "", "=q4=Head of Nefarian", "=ds=#m2#", "", "100%"};
				{ 2, 19383, "", "=q4=Master Dragonslayer's Medallion", "=q1=#m4#: =ds=#s2#"};
				{ 3, 19384, "", "=q4=Master Dragonslayer's Ring", "=q1=#m4#: =ds=#s13#"};
				{ 4, 19366, "", "=q4=Master Dragonslayer's Orb", "=q1=#m4#: =ds=#s15#"};
				{ 16, 19364, "", "=q4=Ashkandi, Greatsword of the Brotherhood", "=ds=#h2#, #w10#", "", "7.21%"};
				{ 17, 19363, "", "=q4=Crul'shorukh, Edge of Chaos", "=ds=#h1#, #w1#", "", "7.00%"};
				{ 18, 19360, "", "=q4=Lok'amir il Romathis", "=ds=#h1#, #w6#", "", "6.98%"};
				{ 19, 19356, "", "=q4=Staff of the Shadow Flame", "=ds=#w9#", "", "7.27%"};
			};
		};
		info = {
			name = BabbleBoss["Nefarian"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

	AtlasLoot_Data["BWLTrashMobs"] = {
		["Normal"] = {
			{
				{ 1, 19436, "", "=q4=Cloak of Draconic Might", "=ds=#s4#", "", "2.53%"};
				{ 2, 19437, "", "=q4=Boots of Pure Thought", "=ds=#s12#, #a1#", "", "2.33%"};
				{ 3, 19438, "", "=q4=Ringo's Blizzard Boots", "=ds=#s12#, #a1#", "", "4.42%"};
				{ 4, 19439, "", "=q4=Interlaced Shadow Jerkin", "=ds=#s5#, #a2#", "", "4.62%"};
				{ 5, 19434, "", "=q4=Band of Dark Dominion", "=ds=#s13#", "", "1.57%"};
				{ 6, 19362, "", "=q4=Doom's Edge", "=ds=#h1#, #w1#", "", "1.67%"};
				{ 7, 19354, "", "=q4=Draconic Avenger", "=ds=#h2#, #w1#", "", "5.96%"};
				{ 8, 19358, "", "=q4=Draconic Maul", "=ds=#h2#, #w6#", "", "2.30%"};
				{ 9, 19435, "", "=q4=Essence Gatherer", "=ds=#w12#", "", "1.61%"};
				{ 11, 18562, "", "=q4=Elementium Ingot", "=ds=#e8#", "", "4.75%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Master Elemental Shaper Krixix"], ""};
				{ 17, 44956, "", "=q3=Goblin's Guide to Elementium", "=ds=#p23# (300)", "", "100%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "BlackwingLair",
		};
	};

		---------------------------------------
		--- Blackrock Mountain: Molten Core ---
		---------------------------------------

	AtlasLoot_Data["MCLucifron"] = {
		["Normal"] = {
			{
				{ 1, 18872, "", "=q4=Manastorm Leggings", "=ds=#s11#, #a1#", "", "1.93%"};
				{ 2, 19145, "", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "", "1.84%"};
				{ 3, 19146, "", "=q4=Wristguards of Stability", "=ds=#s8#, #a2#", "", "1.95%"};
				{ 4, 18875, "", "=q4=Salamander Scale Pants", "=ds=#s11#, #a2#", "", "2.00%"};
				{ 5, 18870, "", "=q4=Helm of the Lifegiver", "=ds=#s1#, #a3#", "", "1.09%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "2.15%"};
				{ 7, 17109, "", "=q4=Choker of Enlightenment", "=ds=#s2#", "", "12.61%"};
				{ 8, 18879, "", "=q4=Heavy Dark Iron Ring", "=ds=#s13#", "", "2.04%"};
				{ 9, 19147, "", "=q4=Ring of Spell Power", "=ds=#s13#", "", "2.23%"};
				{ 10, 18878, "", "=q4=Sorcerous Dagger", "=ds=#h1#, #w4#", "", "2.23%"};
				{ 11, 17077, "", "=q4=Crimson Shocker", "=ds=#w12#", "", "1.60%"};
				{ 16, 16800, "", "=q4=Arcanist Boots", "=q1=#m1# =ds=#c3# (T1)", "", "12.06%"};
				{ 17, 16805, "", "=q4=Felheart Gloves", "=q1=#m1# =ds=#c8# (T1)", "", "14.89%"};
				{ 18, 16829, "", "=q4=Cenarion Boots", "=q1=#m1# =ds=#c1# (T1)", "", "10.72%"};
				{ 19, 16837, "", "=q4=Earthfury Boots", "=q1=#m1# =ds=#c7# (T1)", "", "4.16%"};
				{ 20, 16863, "", "=q4=Gauntlets of Might", "=q1=#m1# =ds=#c9# (T1)", "", "16.40%"};
				{ 21, 16859, "", "=q4=Lawbringer Boots", "=q1=#m1# =ds=#c4# (T1)", "", "7.20%"};
			};
		};
		info = {
			name = BabbleBoss["Lucifron"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCMagmadar"] = {
		["Normal"] = {
			{
				{ 1, 19136, "", "=q4=Mana Igniting Cord", "=ds=#s10#, #a1#", "", "4.79%"};
				{ 2, 18823, "", "=q4=Aged Core Leather Gloves", "=ds=#s9#, #a2#", "", "6.18%"};
				{ 3, 18829, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a3#", "", "2.10%"};
				{ 4, 19144, "", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "", "1.86%"};
				{ 5, 19143, "", "=q4=Flameguard Gauntlets", "=ds=#s9#, #a4#", "", "5.48%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "3.98%"};
				{ 7, 18824, "", "=q4=Magma Tempered Boots", "=ds=#s12#, #a4#", "", "3.22%"};
				{ 8, 17065, "", "=q4=Medallion of Steadfast Might", "=ds=#s2#", "", "14.05%"};
				{ 9, 18821, "", "=q4=Quick Strike Ring", "=ds=#s13#", "", "5.79%"};
				{ 10, 18820, "", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "", "5.55%"};
				{ 12, 19142, "", "=q4=Fire Runed Grimoire", "=ds=#s15#", "", "5.42%"};
				{ 13, 18202, "", "=q4=Eskhandar's Left Claw", "=ds=#h1#, #w13#", "", "14%"};
				{ 14, 18203, "", "=q4=Eskhandar's Right Claw", "=ds=#h1#, #w13#", "", "17.82%"};
				{ 15, 18822, "", "=q4=Obsidian Edged Blade", "=ds=#h2#, #w10#", "", "5.68%"};
				{ 16, 17073, "", "=q4=Earthshaker", "=ds=#h2#, #w6#", "", "16.75%"};
				{ 17, 17069, "", "=q4=Striker's Mark", "=ds=#w2#", "", "16.37%"};
				{ 19, 16796, "", "=q4=Arcanist Leggings", "=q1=#m1# =ds=#c3# (T1)", "", "14.57%"};
				{ 20, 16814, "", "=q4=Pants of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "14.33%"};
				{ 21, 16810, "", "=q4=Felheart Pants", "=q1=#m1# =ds=#c8# (T1)", "", "13.75%"};
				{ 22, 16822, "", "=q4=Nightslayer Pants", "=q1=#m1# =ds=#c6# (T1)", "", "13.83%"};
				{ 23, 16847, "", "=q4=Giantstalker's Leggings", "=q1=#m1# =ds=#c2# (T1)", "", "13.28%"};
				{ 24, 16835, "", "=q4=Cenarion Leggings", "=q1=#m1# =ds=#c1# (T1)", "", "12.90%"};
				{ 25, 16843, "", "=q4=Earthfury Legguards", "=q1=#m1# =ds=#c7# (T1)", "", " 4.73%"};
				{ 26, 16855, "", "=q4=Lawbringer Legplates", "=q1=#m1# =ds=#c4# (T1)", "", "8.54%"};
				{ 27, 16867, "", "=q4=Legplates of Might", "=q1=#m1# =ds=#c9# (T1)", "", "13.97%"};
				{ 29, 93034, "", "=q3=Blazing Rune", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["Magmadar"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCGehennas"] = {
		["Normal"] = {
			{
				{ 1, 19145, "", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "", "3.83%"};
				{ 2, 18872, "", "=q4=Manastorm Leggings", "=ds=#s11#, #a1#", "", "3.37%"};
				{ 3, 19146, "", "=q4=Wristguards of Stability", "=ds=#s8#, #a2#", "", "3.53%"};
				{ 4, 18875, "", "=q4=Salamander Scale Pants", "=ds=#s11#, #a2#", "", "3.57%"};
				{ 5, 18870, "", "=q4=Helm of the Lifegiver", "=ds=#s1#, #a3#", "", "1.77%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "3.48%"};
				{ 7, 18879, "", "=q4=Heavy Dark Iron Ring", "=ds=#s13#", "", "3.78%"};
				{ 8, 19147, "", "=q4=Ring of Spell Power", "=ds=#s13#", "", "3.78%"};
				{ 9, 18878, "", "=q4=Sorcerous Dagger", "=ds=#h1#, #w4#", "", "3.79%"};
				{ 10, 17077, "", "=q4=Crimson Shocker", "=ds=#w12#", "", "3.34%"};
				{ 16, 16812, "", "=q4=Gloves of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "18.65%"};
				{ 17, 16826, "", "=q4=Nightslayer Gloves", "=q1=#m1# =ds=#c6# (T1)", "", "19.47%"};
				{ 18, 16849, "", "=q4=Giantstalker's Boots", "=q1=#m1# =ds=#c2# (T1)", "", "14.54%"};
				{ 19, 16839, "", "=q4=Earthfury Gauntlets", "=q1=#m1# =ds=#c7# (T1)", "", "7.38%"};
				{ 20, 16862, "", "=q4=Sabatons of Might", "=q1=#m1# =ds=#c9# (T1)", "", "14.48%"};
				{ 21, 16860, "", "=q4=Lawbringer Gauntlets", "=q1=#m1# =ds=#c4# (T1)", "", "11.77%"};
			};
		};
		info = {
			name = BabbleBoss["Gehennas"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCGarr"] = {
		["Normal"] = {
			{
				{ 1, 19136, "", "=q4=Mana Igniting Cord", "=ds=#s10#, #a1#", "", "4.80%"};
				{ 2, 18823, "", "=q4=Aged Core Leather Gloves", "=ds=#s9#, #a2#", "", "5.23%"};
				{ 3, 18829, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a3#", "", "1.68%"};
				{ 4, 19144, "", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "", "1.48%"};
				{ 5, 19143, "", "=q4=Flameguard Gauntlets", "=ds=#s9#, #a4#", "", "3.84%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "2.82%"};
				{ 7, 18824, "", "=q4=Magma Tempered Boots", "=ds=#s12#, #a4#", "", "3.05%"};
				{ 8, 18821, "", "=q4=Quick Strike Ring", "=ds=#s13#", "", "4.48%"};
				{ 9, 18820, "", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "", "4.13%"};
				{ 10, 19142, "", "=q4=Fire Runed Grimoire", "=ds=#s15#", "", "3.69%"};
				{ 11, 17071, "", "=q4=Gutgore Ripper", "=ds=#h1#, #w4#", "", "11.21%"};
				{ 12, 18832, "", "=q4=Brutality Blade", "=ds=#h1#, #w10#", "", "13.27%"};
				{ 13, 18822, "", "=q4=Obsidian Edged Blade", "=ds=#h2#, #w10#", "", "4.09%"};
				{ 14, 17105, "", "=q4=Aurastone Hammer", "=ds=#h1#, #w6#", "", "12.67%"};
				{ 15, 17066, "", "=q4=Drillborer Disk", "=ds=#w8#", "", "11.85%"};
				{ 16, 16795, "", "=q4=Arcanist Crown", "=q1=#m1# =ds=#c3# (T1)", "", "11.31%"};
				{ 17, 16813, "", "=q4=Circlet of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "11.36%"};
				{ 18, 16808, "", "=q4=Felheart Horns", "=q1=#m1# =ds=#c8# (T1)", "", "10.62%"};
				{ 19, 16846, "", "=q4=Giantstalker's Helmet", "=q1=#m1# =ds=#c2# (T1)", "", "11.57%"};
				{ 20, 16834, "", "=q4=Cenarion Helm", "=q1=#m1# =ds=#c1# (T1)", "", "11.51%"};
				{ 21, 16821, "", "=q4=Nightslayer Cover", "=q1=#m1# =ds=#c6# (T1)", "", "10.38%"};
				{ 22, 16842, "", "=q4=Earthfury Helmet", "=q1=#m1# =ds=#c7# (T1)", "", "3.91%"};
				{ 23, 16866, "", "=q4=Helm of Might", "=q1=#m1# =ds=#c9# (T1)", "", "11.39%"};
				{ 24, 16854, "", "=q4=Lawbringer Helm", "=q1=#m1# =ds=#c4# (T1)", "", "7.23%"};
				{ 26, 18564, "", "=q5=Bindings of the Windseeker", "=ds=#m3#, =q1="..AL["Right Half"], "", "3.74%"};
				{ 27, 19019, "", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=q1=#m4#: =ds=#h1#, #w10#"};
			};
		};
		info = {
			name = BabbleBoss["Garr"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCShazzrah"] = {
		["Normal"] = {
			{
				{ 1, 19145, "", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "", "1.97%"};
				{ 2, 18872, "", "=q4=Manastorm Leggings", "=ds=#s11#, #a1#", "", "1.84%"};
				{ 3, 19146, "", "=q4=Wristguards of Stability", "=ds=#s8#, #a2#", "", "1.85%"};
				{ 4, 18875, "", "=q4=Salamander Scale Pants", "=ds=#s11#, #a2#", "", "1.81%"};
				{ 5, 18870, "", "=q4=Helm of the Lifegiver", "=ds=#s1#, #a3#", "", "0.78%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "2.22%"};
				{ 7, 18879, "", "=q4=Heavy Dark Iron Ring", "=ds=#s13#", "", "1.72%"};
				{ 8, 19147, "", "=q4=Ring of Spell Power", "=ds=#s13#", "", "1.99%"};
				{ 9, 18878, "", "=q4=Sorcerous Dagger", "=ds=#h1#, #w4#", "", "2.27%"};
				{ 10, 17077, "", "=q4=Crimson Shocker", "=ds=#w12#", "", "3.32%"};
				{ 16, 16801, "", "=q4=Arcanist Gloves", "=q1=#m1# =ds=#c3# (T1)", "", "19.59%"};
				{ 17, 16803, "", "=q4=Felheart Slippers", "=q1=#m1# =ds=#c8# (T1)", "", "15.28%"};
				{ 18, 16811, "", "=q4=Boots of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "14.90%"};
				{ 19, 16831, "", "=q4=Cenarion Gloves", "=q1=#m1# =ds=#c1# (T1)", "", "19.53%"};
				{ 20, 16852, "", "=q4=Giantstalker's Gloves", "=q1=#m1# =ds=#c2# (T1)", "", "18.58%"};
				{ 21, 16824, "", "=q4=Nightslayer Boots", "=q1=#m1# =ds=#c6# (T1)", "", "15.58%"};
			};
		};
		info = {
			name = BabbleBoss["Shazzrah"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCGeddon"] = {
		["Normal"] = {
			{
				{ 1, 19136, "", "=q4=Mana Igniting Cord", "=ds=#s10#, #a1#", "", "2.44%"};
				{ 2, 18823, "", "=q4=Aged Core Leather Gloves", "=ds=#s9#, #a2#", "", "3.04%"};
				{ 3, 18829, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a3#", "", "1.04%"};
				{ 4, 19144, "", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "", "1.00%"};
				{ 5, 19143, "", "=q4=Flameguard Gauntlets", "=ds=#s9#, #a4#", "", "2.61%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "1.77%"};
				{ 7, 18824, "", "=q4=Magma Tempered Boots", "=ds=#s12#, #a4#", "", "1.48%"};
				{ 8, 17110, "", "=q4=Seal of the Archmagus", "=ds=#s13#", "", "21.93%"};
				{ 9, 18821, "", "=q4=Quick Strike Ring", "=ds=#s13#", "", "2.61%"};
				{ 10, 18820, "", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "", "2.68%"};
				{ 11, 19142, "", "=q4=Fire Runed Grimoire", "=ds=#s15#", "", "2.59%"};
				{ 12, 18822, "", "=q4=Obsidian Edged Blade", "=ds=#h2#, #w10#", "", "2.70%"};
				{ 16, 16797, "", "=q4=Arcanist Mantle", "=q1=#m1# =ds=#c3# (T1)", "", "19.92%"};
				{ 17, 16807, "", "=q4=Felheart Shoulder Pads", "=q1=#m1# =ds=#c8# (T1)", "", "19.78%"};
				{ 18, 16836, "", "=q4=Cenarion Spaulders", "=q1=#m1# =ds=#c1# (T1)", "", "19.52%"};
				{ 19, 16856, "", "=q4=Lawbringer Spaulders", "=q1=#m1# =ds=#c4# (T1)", "", "12.62%"};
				{ 20, 16844, "", "=q4=Earthfury Epaulets", "=q1=#m1# =ds=#c7# (T1)", "", "7.29%"};
				{ 22, 18563, "", "=q5=Bindings of the Windseeker", " =ds=#m3#, =q1="..AL["Left Half"], "", "3.78%"};
				{ 23, 19019, "", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=q1=#m4#: =ds=#h1#, #w10#"};
			};
		};
		info = {
			name = BabbleBoss["Baron Geddon"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCGolemagg"] = {
		["Normal"] = {
			{
				{ 1, 19136, "", "=q4=Mana Igniting Cord", "=ds=#s10#, #a1#", "", "2.18%"};
				{ 2, 18823, "", "=q4=Aged Core Leather Gloves", "=ds=#s9#, #a2#", "", "2.65%"};
				{ 3, 18829, "", "=q4=Deep Earth Spaulders", "=ds=#s3#, #a3#", "", "1.20%"};
				{ 4, 19144, "", "=q4=Sabatons of the Flamewalker", "=ds=#s12#, #a3#", "", "1.00%"};
				{ 5, 19143, "", "=q4=Flameguard Gauntlets", "=ds=#s9#, #a4#", "", "2.17%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "1.44%"};
				{ 7, 18824, "", "=q4=Magma Tempered Boots", "=ds=#s12#, #a4#", "", "1.69%"};
				{ 8, 18821, "", "=q4=Quick Strike Ring", "=ds=#s13#", "", "2.26%"};
				{ 9, 18820, "", "=q4=Talisman of Ephemeral Power", "=ds=#s14#", "", "2.91%"};
				{ 10, 19142, "", "=q4=Fire Runed Grimoire", "=ds=#s15#", "", "2.46%"};
				{ 11, 17103, "", "=q4=Azuresong Mageblade", "=ds=#h1#, #w10#", "", "17.59%"};
				{ 12, 18822, "", "=q4=Obsidian Edged Blade", "=ds=#h2#, #w10#", "", "2.89%"};
				{ 13, 18842, "", "=q4=Staff of Dominance", "=ds=#w9#", "", "18.95%"};
				{ 14, 17072, "", "=q4=Blastershot Launcher", "=ds=#w5#", "", "17.83%"};
				{ 16, 16798, "", "=q4=Arcanist Robes", "=q1=#m1# =ds=#c3# (T1)", "", "16.51%"};
				{ 17, 16815, "", "=q4=Robes of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "15.65%"};
				{ 18, 16809, "", "=q4=Felheart Robes", "=q1=#m1# =ds=#c8# (T1)", "", "15.66%"};
				{ 19, 16820, "", "=q4=Nightslayer Chestpiece", "=q1=#m1# =ds=#c6# (T1)", "", "16.76%"};
				{ 20, 16833, "", "=q4=Cenarion Vestments", "=q1=#m1# =ds=#c1# (T1)", "", "15.21%"};
				{ 21, 16845, "", "=q4=Giantstalker's Breastplate", "=q1=#m1# =ds=#c2# (T1)", "", "15.83%"};
				{ 22, 16841, "", "=q4=Earthfury Vestments", "=q1=#m1# =ds=#c7# (T1)", "", " 6.08%"};
				{ 23, 16865, "", "=q4=Breastplate of Might", "=q1=#m1# =ds=#c9# (T1)", "", "15.28%"};
				{ 24, 16853, "", "=q4=Lawbringer Chestguard", "=q1=#m1# =ds=#c4# (T1)", "", "9.53%"};
				{ 26, 17203, "", "=q4=Sulfuron Ingot", "=ds=#m3#", "", "11.98%"};
				{ 27, 17182, "", "=q5=Sulfuras, Hand of Ragnaros", "=q1=#m4#: =ds=#h2#, #w6#"};
				{ 29, 93035, "", "=q3=Core of Hardened Ash", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["Golemagg the Incinerator"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCSulfuron"] = {
		["Normal"] = {
			{
				{ 1, 19145, "", "=q4=Robe of Volatile Power", "=ds=#s5#, #a1#", "", "2.80%"};
				{ 2, 18872, "", "=q4=Manastorm Leggings", "=ds=#s11#, #a1#", "", "2.54%"};
				{ 3, 19146, "", "=q4=Wristguards of Stability", "=ds=#s8#, #a2#", "", "2.70%"};
				{ 4, 18875, "", "=q4=Salamander Scale Pants", "=ds=#s11#, #a2#", "", "2.58%"};
				{ 5, 18870, "", "=q4=Helm of the Lifegiver", "=ds=#s1#, #a3#", "", "1.26%"};
				{ 6, 18861, "", "=q4=Flamewaker Legplates", "=ds=#s11#, #a4#", "", "2.54%"};
				{ 7, 18879, "", "=q4=Heavy Dark Iron Ring", "=ds=#s13#", "", "2.32%"};
				{ 8, 19147, "", "=q4=Ring of Spell Power", "=ds=#s13#", "", "2.39%"};
				{ 9, 18878, "", "=q4=Sorcerous Dagger", "=ds=#h1#, #w4#", "", "2.53%"};
				{ 10, 17074, "", "=q4=Shadowstrike", "=ds=#w7#", "", "23.50%"};
				{ 11, 17077, "", "=q4=Crimson Shocker", "=ds=#w12#", "", "2.26%"};
				{ 16, 16816, "", "=q4=Mantle of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "21.06%"};
				{ 17, 16823, "", "=q4=Nightslayer Shoulder Pads", "=q1=#m1# =ds=#c6# (T1)", "", "20.66%"};
				{ 18, 16848, "", "=q4=Giantstalker's Epaulets", "=q1=#m1# =ds=#c2# (T1)", "", "19.64%"};
				{ 19, 16868, "", "=q4=Pauldrons of Might", "=q1=#m1# =ds=#c9# (T1)", "", "21.14%"};
				{ 21, 93033, "", "=q3=Mark of Flame", "=ds=#e13#", ""};
			};
		};
		info = {
			name = BabbleBoss["Sulfuron Harbinger"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCMajordomo"] = {
		["Normal"] = {
			{
				{ 1, 18811, "", "=q4=Fireproof Cloak", "=ds=#s4#", "", "15.12%"};
				{ 2, 18808, "", "=q4=Gloves of the Hypnotic Flame", "=ds=#s9#, #a1#", "", "15.36%"};
				{ 3, 18809, "", "=q4=Sash of Whispered Secrets", "=ds=#s10#, #a1#", "", "15.93%"};
				{ 4, 19139, "", "=q4=Fireguard Shoulders", "=ds=#s3#, #a2#", "", "15.87%"};
				{ 5, 18810, "", "=q4=Wild Growth Spaulders", "=ds=#s3#, #a2#", "", "16.91%"};
				{ 6, 18812, "", "=q4=Wristguards of True Flight", "=ds=#s8#, #a3#", "", "18.04%"};
				{ 7, 18806, "", "=q4=Core Forged Greaves", "=ds=#s12#, #a4#", "", "16.53%"};
				{ 8, 19140, "", "=q4=Cauterizing Band", "=ds=#s13#", "", "15.10%"};
				{ 9, 18805, "", "=q4=Core Hound Tooth", "=ds=#h1#, #w4#", "", "16.06%"};
				{ 10, 18803, "", "=q4=Finkle's Lava Dredger", "=ds=#h2#, #w6#", "", "12.43%"};
			};
		};
		info = {
			name = BabbleBoss["Majordomo Executus"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCRagnaros"] = {
		["Normal"] = {
			{
				{ 1, 16915, "", "=q4=Netherwind Pants", "=q1=#m1# =ds=#c3# (T2)", "", "17.37%"};
				{ 2, 16922, "", "=q4=Leggings of Transcendence", "=q1=#m1# =ds=#c5# (T2)", "", "17.30%"};
				{ 3, 16930, "", "=q4=Nemesis Leggings", "=q1=#m1# =ds=#c8# (T2)", "", "16.87%"};
				{ 4, 16909, "", "=q4=Bloodfang Pants", "=q1=#m1# =ds=#c6# (T2)", "", "17.18%"};
				{ 5, 16901, "", "=q4=Stormrage Legguards", "=q1=#m1# =ds=#c1# (T2)", "", "15.49%"};
				{ 6, 16938, "", "=q4=Dragonstalker's Legguards", "=q1=#m1# =ds=#c2# (T2)", "", "16.02%"};
				{ 7, 16946, "", "=q4=Legplates of Ten Storms", "=q1=#m1# =ds=#c7# (T2)", "", "5.97%"};
				{ 8, 16962, "", "=q4=Legplates of Wrath", "=q1=#m1# =ds=#c9# (T2)", "", "17.23%"};
				{ 9, 16954, "", "=q4=Judgement Legplates", "=q1=#m1# =ds=#c4# (T2)", "", "10.81%"};
				{ 11, 17204, "", "=q5=Eye of Sulfuras", "=ds=#m3#", "", "3.42%"};
				{ 12, 17182, "", "=q5=Sulfuras, Hand of Ragnaros", "=q1=#m4#: =ds=#h2#, #w6#"};
				{ 14, 19017, "", "=q1=Essence of the Firelord", "=ds=#m3#", "", "0.46%"};
				{ 15, 19019, "", "=q5=Thunderfury, Blessed Blade of the Windseeker", "=q1=#m4#: =ds=#h1#, #w10#"};
				{ 16, 17102, "", "=q4=Cloak of the Shrouded Mists", "=ds=#s4#", "", "14.31%"};
				{ 17, 17107, "", "=q4=Dragon's Blood Cape", "=ds=#s4#", "", "15.32%"};
				{ 18, 18817, "", "=q4=Crown of Destruction", "=ds=#s1#, #a3#", "", "16.75%"};
				{ 19, 19137, "", "=q4=Onslaught Girdle", "=ds=#s10#, #a4#", "", "13.18%"};
				{ 20, 18814, "", "=q4=Choker of the Fire Lord", "=ds=#s2#", "", "16.08%"};
				{ 21, 19138, "", "=q4=Band of Sulfuras", "=ds=#s13#", "", "15.64%"};
				{ 22, 17063, "", "=q4=Band of Accuria", "=ds=#s13#", "", "14.81%"};
				{ 23, 17082, "", "=q4=Shard of the Flame", "=ds=#s14#", "", " 4.65%"};
				{ 24, 18815, "", "=q4=Essence of the Pure Flame", "=ds=#s14#", "", "17.80%"};
				{ 25, 18816, "", "=q4=Perdition's Blade", "=ds=#h1#, #w4#", "", "15.90%"};
				{ 26, 17076, "", "=q4=Bonereaver's Edge", "=ds=#h2#, #w10#", "", "5.12%"};
				{ 27, 17104, "", "=q4=Spinal Reaper", "=ds=#h2#, #w1#", "", " 4.63%"};
				{ 28, 17106, "", "=q4=Malistar's Defender", "=ds=#w8#", "", "13.88%"};
			};
		};
		info = {
			name = BabbleBoss["Ragnaros"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCTrashMobs"] = {
		["Normal"] = {
			{
				{ 1, 16802, "", "=q4=Arcanist Belt", "=q1=#m1# =ds=#c3# (T1)", "", "0.16%"};
				{ 2, 16817, "", "=q4=Girdle of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "0.18%"};
				{ 3, 16806, "", "=q4=Felheart Belt", "=q1=#m1# =ds=#c8# (T1)", "", "0.19%"};
				{ 4, 16827, "", "=q4=Nightslayer Belt", "=q1=#m1# =ds=#c6# (T1)", "", "0.15%"};
				{ 5, 16828, "", "=q4=Cenarion Belt", "=q1=#m1# =ds=#c1# (T1)", "", "0.16%"};
				{ 6, 16851, "", "=q4=Giantstalker's Belt", "=q1=#m1# =ds=#c2# (T1)", "", "0.17%"};
				{ 7, 16838, "", "=q4=Earthfury Belt", "=q1=#m1# =ds=#c7# (T1)", "", "0.07%"};
				{ 8, 16864, "", "=q4=Belt of Might", "=q1=#m1# =ds=#c9# (T1)", "", "0.16%"};
				{ 9, 16858, "", "=q4=Lawbringer Belt", "=q1=#m1# =ds=#c4# (T1)", "", "0.10%"};
				{ 11, 17010, "", "=q3=Fiery Core", "=ds=#e8#"};
				{ 12, 17011, "", "=q3=Lava Core", "=ds=#e8#"};
				{ 13, 11382, "", "=q2=Blood of the Mountain", "=ds=#e8#"};
				{ 14, 17012, "", "=q1=Core Leather", "=ds=#e8#"};
				{ 16, 16799, "", "=q4=Arcanist Bindings", "=q1=#m1# =ds=#c3# (T1)", "", "0.16%"};
				{ 17, 16819, "", "=q4=Vambraces of Prophecy", "=q1=#m1# =ds=#c5# (T1)", "", "0.16%"};
				{ 18, 16804, "", "=q4=Felheart Bracers", "=q1=#m1# =ds=#c8# (T1)", "", "0.16%"};
				{ 19, 16825, "", "=q4=Nightslayer Bracelets", "=q1=#m1# =ds=#c6# (T1)", "", "0.17%"};
				{ 20, 16830, "", "=q4=Cenarion Bracers", "=q1=#m1# =ds=#c1# (T1)", "", "0.17%"};
				{ 21, 16850, "", "=q4=Giantstalker's Bracers", "=q1=#m1# =ds=#c2# (T1)", "", "0.18%"};
				{ 22, 16840, "", "=q4=Earthfury Bracers", "=q1=#m1# =ds=#c7# (T1)", "", "0.06%"};
				{ 23, 16861, "", "=q4=Bracers of Might", "=q1=#m1# =ds=#c9# (T1)", "", "0.16%"};
				{ 24, 16857, "", "=q4=Lawbringer Bracers", "=q1=#m1# =ds=#c4# (T1)", "", "0.11%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "MoltenCore",
		};
	};

	AtlasLoot_Data["MCRANDOMBOSSDROPPS"] = {
		["Normal"] = {
			{
				{ 1, 18264, "", "=q3=Plans: Elemental Sharpening Stone", "=ds=#p2# (300)", "", "1.02%"};
				{ 2, 18262, "", "=q2=Elemental Sharpening Stone", "=ds=#e6#"};
				{ 4, 18292, "", "=q3=Schematic: Core Marksman Rifle", "=ds=#p5# (300)", "", "0.96%"};
				{ 5, 18282, "", "=q4=Core Marksman Rifle", "=ds=#w5#"};
				{ 7, 18291, "", "=q3=Schematic: Force Reactive Disk", "=ds=#p5# (300)", "", "0.92%"};
				{ 8, 18168, "", "=q4=Force Reactive Disk", "=ds=#w8#"};
				{ 10, 18290, "", "=q3=Schematic: Biznicks 247x128 Accurascope", "=ds=#p5# (300)", "", "0.11%"};
				{ 11, 18283, "", "=q3=Biznicks 247x128 Accurascope", "=ds=#e11#"};
				{ 13, 18259, "", "=q3=Formula: Enchant Weapon - Spell Power", "=ds=#p4# (300)", "", "0.85%"};
				{ 16, 18252, "", "=q3=Pattern: Core Armor Kit", "=ds=#p7# (300)", "", "0.85%"};
				{ 17, 18251, "", "=q3=Core Armor Kit", "=ds=#e6#"};
				{ 19, 18265, "", "=q3=Pattern: Flarecore Wraps", "=ds=#p8# (300)", "", "0.72%"};
				{ 20, 18263, "", "=q4=Flarecore Wraps", "=ds=#s8#, #a1#"};
				{ 22, 21371, "", "=q3=Pattern: Core Felcloth Bag", "=ds=#p8# (300)", "", "0.33%"};
				{ 23, 21342, "", "=q4=Core Felcloth Bag", "=ds=#e1# =q1=#m1# #c8#"};
				{ 25, 18257, "", "=q3=Recipe: Major Rejuvenation Potion", "=ds=#p1# (300)", "", "0.76%"};
				{ 26, 18253, "", "=q1=Major Rejuvenation Potion", "=ds=#e2#"};
				{ 28, 18260, "", "=q3=Formula: Enchant Weapon - Healing Power", "=ds=#p4# (300)", "", "0.75%"};
			};
		};
		info = {
			name = AL["Random Boss Loot"],
			module = moduleName, instance = "MoltenCore",
		};
	};

		-----------------------
		--- Dire Maul Books ---
		-----------------------

	AtlasLoot_Data["DMBooks"] = {
		["Normal"] = {
			{
				{ 1, 18364, "", "=q3=The Emerald Dream", "=ds=#e10#, =q1=#m1# =ds=#c1#"};
				{ 2, 18361, "", "=q3=The Greatest Race of Hunters", "=ds=#e10#, =q1=#m1# =ds=#c2#"};
				{ 3, 18358, "", "=q3=The Arcanist's Cookbook", "=ds=#e10#, =q1=#m1# =ds=#c3#"};
				{ 4, 18359, "", "=q3=The Light and How to Swing It", "=ds=#e10#, =q1=#m1# =ds=#c4#"};
				{ 5, 18362, "", "=q3=Holy Bologna: What the Light Won't Tell You", "=ds=#e10#, =q1=#m1# =ds=#c5#"};
				{ 6, 18356, "", "=q3=Garona: A Study on Stealth and Treachery", "=ds=#e10#, =q1=#m1# =ds=#c6#"};
				{ 7, 18363, "", "=q3=Frost Shock and You", "=ds=#e10#, =q1=#m1# =ds=#c7#"};
				{ 8, 18360, "", "=q3=Harnessing Shadows", "=ds=#e10#, =q1=#m1# =ds=#c8#"};
				{ 9, 18357, "", "=q3=Codex of Defense", "=ds=#e10#, =q1=#m1# =ds=#c9#"};
				{ 11, 18333, "", "=q2=Libram of Focus", "=ds=#e10#"};
				{ 12, 18334, "", "=q2=Libram of Protection", "=ds=#e10#"};
				{ 13, 18332, "", "=q2=Libram of Rapidity", "=ds=#e10#"};
				{ 16, 18470, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c1#"};
				{ 17, 18473, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c2#"};
				{ 18, 18468, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c3#"};
				{ 19, 18472, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c4#"};
				{ 20, 18469, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c5#"};
				{ 21, 18465, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c6#"};
				{ 22, 18471, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c7#"};
				{ 23, 18467, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c8#"};
				{ 24, 18466, "", "=q3=Royal Seal of Eldre'Thalas", "=ds=#s14#, =q1=#m1# =ds=#c9#"};
			};
		};
		info = {
			name = AL["Dire Maul Books"],
			module = moduleName, NextPrevDisable = true,
		};
	};

		----------------------
		--- Dire Maul East ---
		----------------------

	AtlasLoot_Data["DMELethtendrisPimgib"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lethtendris", 404), ""};
				{ 2, 18325, "", "=q3=Felhide Cap", "=ds=#s1#, #a2#", "25%"};
				{ 3, 18302, "", "=q3=Band of Vigor", "=ds=#s13#", "25%"};
				{ 4, 18311, "", "=q3=Quel'dorei Channeling Rod", "=ds=#w9#", "25%"};
				{ 5, 18301, "", "=q3=Lethtendris' Wand", "=ds=#w12#", "25%"};
				{ 7, 18426, "", "=q1=Lethtendris' Web", "=ds=#m3#", "100%"};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Pimgib"], ""};
				{ 17, 18354, "", "=q3=Pimgib's Collar", "=ds=#s14#, =q1=#m1# =ds=#c8#", "12,5%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lethtendris", 404).." & "..BabbleBoss["Pimgib"],
			module = moduleName, instance = "DireMaulEast",
		};
	};

	AtlasLoot_Data["DMEHydro"] = {
		["Normal"] = {
			{
				{ 1, 18307, "", "=q3=Riptide Shoes", "=ds=#s12#, #a1#", "20%"};
				{ 2, 18322, "", "=q3=Waterspout Boots", "=ds=#s12#, #a2#", "20%"};
				{ 3, 18305, "", "=q3=Breakwater Legguards", "=ds=#s11#, #a3#", "20%"};
				{ 4, 18317, "", "=q3=Tempest Talisman", "=ds=#s2#", "20%"};
				{ 5, 18324, "", "=q3=Waveslicer", "=ds=#h2#, #w1#", "20%"};
				{ 7, 18299, "", "=q1=Hydrospawn Essence", "=ds=#m3#", "100%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Hydrospawn", 403),
			module = moduleName, instance = "DireMaulEast",
		};
	};

	AtlasLoot_Data["DMEZevrimThornhoof"] = {
		["Normal"] = {
			{
				{ 1, 18306, "", "=q3=Gloves of Shadowy Mist", "=ds=#s9#, #a1#", "20%"};
				{ 2, 18308, "", "=q3=Clever Hat", "=ds=#s1#, #a2#", "20%"};
				{ 3, 18319, "", "=q3=Fervent Helm", "=ds=#s1#, #a2#", "20%"};
				{ 4, 18313, "", "=q3=Helm of Awareness", "=ds=#s1#, #a3#", "20%"};
				{ 5, 18323, "", "=q3=Satyr's Bow", "=ds=#w2#", "20%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Zevrim Thornhoof", 402),
			module = moduleName, instance = "DireMaulEast",
		};
	};

	AtlasLoot_Data["DMEAlzzin"] = {
		["Normal"] = {
			{
				{ 1, 18328, "", "=q3=Shadewood Cloak", "=ds=#s4#", "20%"};
				{ 2, 18327, "", "=q3=Whipvine Cord", "=ds=#s10#, #a1#", "20%"};
				{ 3, 18309, "", "=q3=Gloves of Restoration", "=ds=#s9#, #a2#", "20%"};
				{ 4, 18318, "", "=q3=Merciful Greaves", "=ds=#s12#, #a2#", "20%"};
				{ 5, 18312, "", "=q3=Energized Chestplate", "=ds=#s5#, #a3#", "20%"};
				{ 6, 18326, "", "=q3=Razor Gauntlets", "=ds=#s9#, #a3#", "20%"};
				{ 8, 0, "INV_Box_01", "=q6="..AL["Felvine Shard"], ""};
				{ 9, 18501, "", "=q1=Felvine Shard", "=ds=#m3#"};
				{ 16, 18315, "", "=q3=Ring of Demonic Potency", "=ds=#s13#", "20%"};
				{ 17, 18314, "", "=q3=Ring of Demonic Guile", "=ds=#s13#", "20%"};
				{ 18, 18310, "", "=q3=Fiendish Machete", "=ds=#h1#, #w10#", "20%"};
				{ 19, 18321, "", "=q3=Energetic Rod", "=ds=#h1#, #w6#", "20%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Alzzin the Wildshaper", 405),
			module = moduleName, instance = "DireMaulEast",
		};
	};

	AtlasLoot_Data["DMEPusillin"] = {
		["Normal"] = {
			{
				{ 1, 18267, "", "=q2=Recipe: Runn Tum Tuber Surprise", "=ds=#p3# (275)", "", "71.55%"};
				{ 3, 18261, "", "=q1=Book of Incantations", "=ds=#m3#", "", "100%"};
			};
		};
		info = {
			name = BabbleBoss["Pusillin"],
			module = moduleName, instance = "DireMaulEast",
		};
	};

	AtlasLoot_Data["DMETrash"] = {
		["Normal"] = {
			{
				{ 1, 18295, "", "=q3=Phasing Boots", "=ds=#s12#, #a1#", "", "1.26%"};
				{ 2, 18298, "", "=q3=Unbridled Leggings", "=ds=#s11#, #a2#", "", "0.62%"};
				{ 3, 18296, "", "=q3=Marksman Bands", "=ds=#s8#, #a3#", "", "0.59%"};
				{ 4, 18289, "", "=q3=Barbed Thorn Necklace", "=ds=#s2#", "", "0.87%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "DireMaulEast",
		};
	};

		-----------------------
		--- Dire Maul North ---
		-----------------------

	AtlasLoot_Data["DMNGuardMoldar"] = {
		["Normal"] = {
			{
				{ 1, 18496, "", "=q3=Heliotrope Cloak", "=ds=#s4#", "", "4.68%"};
				{ 2, 18497, "", "=q3=Sublime Wristguards", "=ds=#s8#, #a1#", "", "4.14%"};
				{ 3, 18494, "", "=q3=Denwatcher's Shoulders", "=ds=#s3#, #a3#", "", "4.62%"};
				{ 4, 18493, "", "=q3=Bulky Iron Spaulders", "=ds=#s3#, #a4#", "", "3.96%"};
				{ 5, 18498, "", "=q3=Hedgecutter", "=ds=#h1#, #w1#", "", "4.94%"};
				{ 16, 18450, "", "=q3=Robe of Combustion", "=ds=#s5#, #a1#", "", "6.57%"};
				{ 17, 18451, "", "=q3=Hyena Hide Belt", "=ds=#s10#, #a2#", "", "6.61%"};
				{ 18, 18458, "", "=q3=Modest Armguards", "=ds=#s8#, #a3#", "", "7.12%"};
				{ 19, 18459, "", "=q3=Gallant's Wristguards", "=ds=#s8#, #a4#", "", "6.09%"};
				{ 20, 18464, "", "=q3=Gordok Nose Ring", "=ds=#s13#", "", "6.52%"};
				{ 21, 18462, "", "=q3=Jagged Bone Fist", "=ds=#h1#, #w13#", "", "7.54%"};
				{ 22, 18463, "", "=q3=Ogre Pocket Knife", "=ds=#h1#, #w10#", "", "7.38%"};
				{ 23, 18460, "", "=q3=Unsophisticated Hand Cannon", "=ds=#w5#", "", "5.86%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Guard Mol'dar", 411),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNStomperKreeg"] = {
		["Normal"] = {
			{
				{ 1, 18425, "", "=q3=Kreeg's Mug", "=ds=#s15#", "100%"};
				{ 3, 18269, "", "=q2=Gordok Green Grog", "=ds=#e4#", };
				{ 4, 18284, "", "=q2=Kreeg's Stout Beatdown", "=ds=#e4#", };
				{ 5, 18287, "", "=q1=Evermurky", "=ds=#e4#", };
				{ 6, 18288, "", "=q1=Molasses Firewater", "=ds=#e4#", };
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Stomper Kreeg", 412),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNGuardFengus"] = {
		["Normal"] = {
			{
				{ 1, 18450, "", "=q3=Robe of Combustion", "=ds=#s5#, #a1#", "12,5"};
				{ 2, 18451, "", "=q3=Hyena Hide Belt", "=ds=#s10#, #a2#", "12,5"};
				{ 3, 18458, "", "=q3=Modest Armguards", "=ds=#s8#, #a3#", "12,5"};
				{ 4, 18459, "", "=q3=Gallant's Wristguards", "=ds=#s8#, #a4#", "12,5"};
				{ 5, 18464, "", "=q3=Gordok Nose Ring", "=ds=#s13#", "12,5"};
				{ 6, 18462, "", "=q3=Jagged Bone Fist", "=ds=#h1#, #w13#", "12,5"};
				{ 7, 18463, "", "=q3=Ogre Pocket Knife", "=ds=#h1#, #w10#", "12,5"};
				{ 8, 18460, "", "=q3=Unsophisticated Hand Cannon", "=ds=#w5#", "12,5"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Guard Fengus", 413),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNGuardSlipkik"] = {
		["Normal"] = {
			{
				{ 1, 18496, "", "=q3=Heliotrope Cloak", "=ds=#s4#", "", "5.82%"};
				{ 2, 18497, "", "=q3=Sublime Wristguards", "=ds=#s8#, #a1#", "", "4.75%"};
				{ 3, 18494, "", "=q3=Denwatcher's Shoulders", "=ds=#s3#, #a3#", "", "5.70%"};
				{ 4, 18493, "", "=q3=Bulky Iron Spaulders", "=ds=#s3#, #a4#", "", "4.89%"};
				{ 5, 18498, "", "=q3=Hedgecutter", "=ds=#h1#, #w1#", "", "6.01%"};
				{ 16, 18450, "", "=q3=Robe of Combustion", "=ds=#s5#, #a1#", "", "6.78%"};
				{ 17, 18451, "", "=q3=Hyena Hide Belt", "=ds=#s10#, #a2#", "", "7.83%"};
				{ 18, 18458, "", "=q3=Modest Armguards", "=ds=#s8#, #a3#", "", "7.63%"};
				{ 19, 18459, "", "=q3=Gallant's Wristguards", "=ds=#s8#, #a4#", "", "6.98%"};
				{ 20, 18464, "", "=q3=Gordok Nose Ring", "=ds=#s13#", "", "7.36%"};
				{ 21, 18462, "", "=q3=Jagged Bone Fist", "=ds=#h1#, #w13#", "", "8.52%"};
				{ 22, 18463, "", "=q3=Ogre Pocket Knife", "=ds=#h1#, #w10#", "", "7.74%"};
				{ 23, 18460, "", "=q3=Unsophisticated Hand Cannon", "=ds=#w5#", "", "6.66%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Guard Slip'kik", 414),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNThimblejack"] = {
		["Normal"] = {
			{
				{ 1, 18517, "", "=q4=Pattern: Chromatic Cloak", "=ds=#p7# (300)", "", "0.92%"};
				{ 2, 18518, "", "=q4=Pattern: Hide of the Wild", "=ds=#p7# (300)", "", "1.29%"};
				{ 3, 18519, "", "=q4=Pattern: Shifting Cloak", "=ds=#p7# (300)", "", "1.14%"};
				{ 4, 18414, "", "=q4=Pattern: Belt of the Archmage", "=ds=#p8# (300)", "", "1.00%"};
				{ 6, 18418, "", "=q3=Pattern: Cloak of Warding", "=ds=#p8# (300)", "", "9.75%"};
				{ 7, 18415, "", "=q3=Pattern: Felcloth Gloves", "=ds=#p8# (300)", "", "9.62%"};
				{ 8, 18416, "", "=q3=Pattern: Inferno Gloves", "=ds=#p8# (300)", "", "10.66%"};
				{ 9, 18417, "", "=q3=Pattern: Mooncloth Gloves", "=ds=#p8# (300)", "", "10.28%"};
				{ 10, 18514, "", "=q3=Pattern: Girdle of Insight", "=ds=#p7# (300)", "", "10.90%"};
				{ 11, 18515, "", "=q3=Pattern: Mongoose Boots", "=ds=#p7# (300)", "", "11.18%"};
				{ 12, 18516, "", "=q3=Pattern: Swift Flight Bracers", "=ds=#p7# (300)", "", "10.26%"};
				{ 14, 0, "INV_Box_01", "=q6="..AL["Ogre Tannin Basket"], ""};
				{ 15, 18240, "", "=q2=Ogre Tannin", "=ds=#m3#", "", "100%"};
				{ 16, 18509, "", "=q4=Chromatic Cloak", "=ds=#s4#"};
				{ 17, 18510, "", "=q4=Hide of the Wild", "=ds=#s4#"};
				{ 18, 18511, "", "=q4=Shifting Cloak", "=ds=#s4#"};
				{ 19, 18405, "", "=q4=Belt of the Archmage", "=ds=#s10#, #a1#"};
				{ 21, 18413, "", "=q3=Cloak of Warding", "=ds=#s4#"};
				{ 22, 18407, "", "=q3=Felcloth Gloves", "=ds=#s9#, #a1#"};
				{ 23, 18408, "", "=q3=Inferno Gloves", "=ds=#s9#, #a1#"};
				{ 24, 18409, "", "=q3=Mooncloth Gloves", "=ds=#s9#, #a1#"};
				{ 25, 18504, "", "=q3=Girdle of Insight", "=ds=#s10#, #a2#"};
				{ 26, 18506, "", "=q3=Mongoose Boots", "=ds=#s12#, #a2#"};
				{ 27, 18508, "", "=q3=Swift Flight Bracers", "=ds=#s8#, #a3#"};
			};
		};
		info = {
			name = AL["Knot Thimblejack"],
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNCaptainKromcrush"] = {
		["Normal"] = {
			{
				{ 1, 18507, "", "=q3=Boots of the Full Moon", "=ds=#s12#, #a1#", "25%"};
				{ 2, 18505, "", "=q3=Mugger's Belt", "=ds=#s10#, #a2#", "25%"};
				{ 3, 18503, "", "=q3=Kromcrush's Chestplate", "=ds=#s5#, #a4#", "25%"};
				{ 4, 18502, "", "=q3=Monstrous Glaive", "=ds=#w7#", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Captain Kromcrush", 415),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNKingGordok"] = {
		["Normal"] = {
			{
				{ 1, 18526, "", "=q3=Crown of the Ogre King", "=ds=#s1#, #a1#", "25%"};
				{ 2, 18525, "", "=q3=Bracers of Prosperity", "=ds=#s8#, #a2#", "25%"};
				{ 3, 18527, "", "=q3=Harmonious Gauntlets", "=ds=#s9#, #a3#", "25%"};
				{ 4, 18524, "", "=q3=Leggings of Destruction", "=ds=#s11#, #a3#", "25%"};
				{ 5, 18521, "", "=q3=Grimy Metal Boots", "=ds=#s12#, #a4#", "25%"};
				{ 6, 18522, "", "=q3=Band of the Ogre King", "=ds=#s13#", "25%"};
				{ 7, 18523, "", "=q3=Brightly Glowing Stone", "=ds=#s15#", "25%"};
				{ 8, 18520, "", "=q3=Barbarous Blade", "=ds=#h2#, #w10#", "25%"};
				{ 16, 19258, "", "=q3=Ace of Warlords", "=ds=#e16#", "5%"};
				{ 18, 18780, "", "=q3=Top Half of Advanced Armorsmithing: Volume I", "=ds=#m3#", "", "6.00%"};
				{ 19, 12727, "", "=q3=Plans: Enchanted Thorium Breastplate", "=q1=#m4#: =ds=#p2# (300)"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("King Gordok", 417),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNChoRush"] = {
		["Normal"] = {
			{
				{ 1, 18490, "", "=q3=Insightful Hood", "=ds=#s1#, #a2#", "25%"};
				{ 2, 18484, "", "=q3=Cho'Rush's Blade", "=ds=#h1#, #w10#", "25%"};
				{ 3, 18485, "", "=q3=Observer's Shield", "=ds=#w8#", "25%"};
				{ 4, 18483, "", "=q3=Mana Channeling Wand", "=ds=#w12#", "25%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Cho'Rush the Observer", 416),
			module = moduleName, instance = "DireMaulNorth",
		};
	};

	AtlasLoot_Data["DMNTRIBUTERUN"] = {
		["Normal"] = {
			{
				{ 1, 18538, "", "=q4=Treant's Bane", "=ds=#h2#, #w1#"};
				{ 3, 18495, "", "=q3=Redoubt Cloak", "=ds=#s4#"};
				{ 4, 18532, "", "=q3=Mindsurge Robe", "=ds=#s5#, #a1#"};
				{ 5, 18475, "", "=q3=Oddly Magical Belt", "=ds=#s10#, #a1#"};
				{ 6, 18528, "", "=q3=Cyclone Spaulders", "=ds=#s3#, #a2#"};
				{ 7, 18478, "", "=q3=Hyena Hide Jerkin", "=ds=#s5#, #a2#"};
				{ 8, 18477, "", "=q3=Shaggy Leggings", "=ds=#s11#, #a2#"};
				{ 9, 18476, "", "=q3=Mud Stained Boots", "=ds=#s12#, #a2#"};
				{ 10, 18479, "", "=q3=Carrion Scorpid Helm", "=ds=#s1#, #a3#"};
				{ 11, 18530, "", "=q3=Ogre Forged Hauberk", "=ds=#s5#, #a3#"};
				{ 12, 18480, "", "=q3=Scarab Plate Helm", "=ds=#s1#, #a4#"};
				{ 13, 18533, "", "=q3=Gordok Bracers of Power", "=ds=#s8#, #a4#"};
				{ 14, 18529, "", "=q3=Elemental Plate Girdle", "=ds=#s10#, #a4#"};
				{ 16, 18500, "", "=q3=Tarnished Elven Ring", "=ds=#s13#"};
				{ 17, 18537, "", "=q3=Counterattack Lodestone", "=ds=#s14#"};
				{ 19, 18481, "", "=q3=Skullcracking Mace", "=ds=#h2#, #w6#"};
				{ 20, 18531, "", "=q3=Unyielding Maul", "=ds=#h2#, #w6#"};
				{ 21, 18534, "", "=q3=Rod of the Ogre Magi", "=ds=#w9#"};
				{ 22, 18499, "", "=q3=Barrier Shield", "=ds=#w8#"};
				{ 23, 18482, "", "=q3=Ogre Toothpick Shooter", "=ds=#w2#"};
				{ 25, 18655, "", "=q2=Schematic: Major Recombobulator", "=ds=#p5# (275)"};
			};
		};
		info = {
			name = AL["DM North Tribute Chest"],
			module = moduleName, instance = "DireMaulNorth",
		};
	};

		----------------------
		--- Dire Maul West ---
		----------------------

	AtlasLoot_Data["DMWTendrisWarpwood"] = {
		["Normal"] = {
			{
				{ 1, 18390, "", "=q3=Tanglemoss Leggings", "=ds=#s11#, #a2#", "", "22.55%"};
				{ 2, 18393, "", "=q3=Warpwood Binding", "=ds=#s10#, #a3#", "", "19.81%"};
				{ 3, 18353, "", "=q3=Stoneflower Staff", "=ds=#w9#", "", "23.46%"};
				{ 4, 18352, "", "=q3=Petrified Bark Shield", "=ds=#w8#", "", "21.67%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Tendris Warpwood", 406),
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWMagisterKalendris"] = {
		["Normal"] = {
			{
				{ 1, 18350, "", "=q3=Amplifying Cloak", "=ds=#s4#", "", "21.44%"};
				{ 2, 18374, "", "=q3=Flamescarred Shoulders", "=ds=#s3#, #a2#", "", "18.11%"};
				{ 3, 18351, "", "=q3=Magically Sealed Bracers", "=ds=#s8#, #a4#", "", "24.36%"};
				{ 4, 18397, "", "=q3=Elder Magus Pendant", "=ds=#s2#", "", "17.46%"};
				{ 5, 18371, "", "=q3=Mindtap Talisman", "=ds=#s14#", "", "7.45%"};
				{ 7, 22309, "", "=q2=Pattern: Big Bag of Enchantment", "=ds=#p8# (300)"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Magister Kalendris", 408),
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWIllyannaRavenoak"] = {
		["Normal"] = {
			{
				{ 1, 18386, "", "=q3=Padre's Trousers", "=ds=#s11#, #a1#", "", "18.79%"};
				{ 2, 18349, "", "=q3=Gauntlets of Accuracy", "=ds=#s9#, #a3#", "", "23.94%"};
				{ 3, 18383, "", "=q3=Force Imbued Gauntlets", "=ds=#s9#, #a4#", "", "20.11%"};
				{ 4, 18347, "", "=q3=Well Balanced Axe", "=ds=#h1#, #w1#", "", "22.44%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Illyanna Ravenoak", 407),
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWImmolthar"] = {
		["Normal"] = {
			{
				{ 1, 18389, "", "=q3=Cloak of the Cosmos", "=ds=#s4#", "", "14.35%"};
				{ 2, 18385, "", "=q3=Robe of Everlasting Night", "=ds=#s5#, #a1#", "", "15.33%"};
				{ 3, 18377, "", "=q3=Quickdraw Gloves", "=ds=#s9#, #a2#", "", "21.01%"};
				{ 4, 18391, "", "=q3=Eyestalk Cord", "=ds=#s10#, #a2#", "", "20.08%"};
				{ 5, 18394, "", "=q3=Demon Howl Wristguards", "=ds=#s8#, #a3#", "", "17.51%"};
				{ 6, 18379, "", "=q3=Odious Greaves", "=ds=#s12#, #a3#", "", " 19.81%"};
				{ 7, 18384, "", "=q3=Bile-Etched Spaulders", "=ds=#s3#, #a4#", "", "14.71%"};
				{ 16, 18381, "", "=q3=Evil Eye Pendant", "=ds=#s2#", "", "17.78%"};
				{ 17, 18370, "", "=q3=Vigilance Charm", "=ds=#s14#", "", "6.30%"};
				{ 18, 18372, "", "=q3=Blade of the New Moon", "=ds=#h1#, #w4#", "", "6.99%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Immol'thar", 409),
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWHelnurath"] = {
		["Normal"] = {
			{
				{ 1, 18757, "", "=q3=Diabolic Mantle", "=ds=#s3#, #a1#", "", "23.12%"};
				{ 2, 18754, "", "=q3=Fel Hardened Bracers", "=ds=#s8#, #a4#", "", "19.24%"};
				{ 3, 18756, "", "=q3=Dreadguard's Protector", "=ds=#w8#", "", "19.77%"};
				{ 4, 18755, "", "=q3=Xorothian Firestick", "=ds=#w5#", "", "21.92%"};
			};
		};
		info = {
			name = BabbleBoss["Lord Hel'nurath"].." ("..AL["Summon"]..")",
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWPrinceTortheldrin"] = {
		["Normal"] = {
			{
				{ 1, 18382, "", "=q3=Fluctuating Cloak", "=ds=#s4#", "", "21.84%"};
				{ 2, 18373, "", "=q3=Chestplate of Tranquility", "=ds=#s5#, #a2#", "", "6.32%"};
				{ 3, 18375, "", "=q3=Bracers of the Eclipse", "=ds=#s8#, #a2#", "", "15.62%"};
				{ 4, 18378, "", "=q3=Silvermoon Leggings", "=ds=#s11#, #a3#", "", "21.20%"};
				{ 5, 18380, "", "=q3=Eldritch Reinforced Legplates", "=ds=#s11#, #a4#", "", "15.87%"};
				{ 6, 18395, "", "=q3=Emerald Flame Ring", "=ds=#s13#", "", "14.55%"};
				{ 16, 18392, "", "=q3=Distracting Dagger", "=ds=#h4#, #w4#", "", "14.70%"};
				{ 17, 18396, "", "=q3=Mind Carver", "=ds=#h1#, #w10#", "", "14.62%"};
				{ 18, 18376, "", "=q3=Timeworn Mace", "=ds=#h1#, #w6#", "", "14.40%"};
				{ 19, 18388, "", "=q3=Stoneshatter", "=ds=#w3#", "", "7.72%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Prince Tortheldrin", 410),
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWTsuzee"] = {
		["Normal"] = {
			{
				{ 1, 18387, "", "=q3=Brightspark Gloves", "=ds=#s9#, #a1#", "", "24.79%"};
				{ 2, 18346, "", "=q3=Threadbare Trousers", "=ds=#s11#, #a1#", "", "33.94%"};
				{ 3, 18345, "", "=q3=Murmuring Ring", "=ds=#s13#", "", "30.28%"};
			};
		};
		info = {
			name = BabbleBoss["Tsu'zee"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "DireMaulWest",
		};
	};

	AtlasLoot_Data["DMWTrash"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], ""};
				{ 2, 18344, "", "=q3=Stonebark Gauntlets", "=ds=#s9#, #a2#", "", "0.47%"};
				{ 3, 18340, "", "=q3=Eidolon Talisman", "=ds=#s2#", "", "0.58%"};
				{ 4, 18338, "", "=q3=Wand of Arcane Potency", "=ds=#w12#", "", "0.78%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Shen'dralar Provisioner"], ""};
				{ 17, 18487, "", "=q1=Pattern: Mooncloth Robe", "=ds=#p8# (300)"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "DireMaulWest",
		};
	};

		------------------
		--- Gnomeregan ---
		------------------

	AtlasLoot_Data["GnomereganLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Grubbis", 419), ""};
				{ 2, 9445, "", "=q3=Grubbis Paws", "=ds=#s9#, #a3#", "", "9.22%"};
				{ 4, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Viscous Fallout", 420), ""};
				{ 5, 9454, "", "=q3=Acidic Walkers", "=ds=#s12#, #a1#", "", "54.02%"};
				{ 6, 9453, "", "=q3=Toxic Revenger", "=ds=#h1#, #w4#", "", "19.05%"};
				{ 7, 9452, "", "=q3=Hydrocane", "=ds=#w9#", "", "18.25%"};
				{ 9, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Electrocutioner 6000", 421), ""};
				{ 10, 9448, "", "=q3=Spidertank Oilrag", "=ds=#s8#, #a1#", "", "28.37%"};
				{ 11, 9447, "", "=q3=Electrocutioner Lagnut", "=ds=#s13#", "", "28.44%"};
				{ 12, 9446, "", "=q3=Electrocutioner Leg", "=ds=#h1#, #w10#", "", "13.19%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Crowd Pummeler 9-60", 418), ""};
				{ 17, 9450, "", "=q3=Gnomebot Operating Boots", "=ds=#s12#, #a2#", "", "60.45%"};
				{ 18, 9449, "", "=q3=Manual Crowd Pummeler", "=ds=#h2#, #w6#", "", "33.14%"};
				{ 20, 0, "INV_Box_01", "=q6="..BabbleBoss["Dark Iron Ambassador"], ""};
				{ 21, 9455, "", "=q3=Emissary Cuffs", "=ds=#s8#, #a2#", "", "33.96%"};
				{ 22, 9457, "", "=q3=Royal Diplomatic Scepter", "=ds=#h1#, #w6#", "", "17.79%"};
				{ 23, 9456, "", "=q3=Glass Shooter", "=ds=#w5#", "", "38.01%"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Mekgineer Thermaplugg", 422), ""};
				{ 2, 9492, "", "=q3=Electromagnetic Gigaflux Reactivator", "=ds=#s1#, #a1#", "", "7.65%"};
				{ 3, 9461, "", "=q3=Charged Gear", "=ds=#s13#", "", "28.49%"};
				{ 4, 9459, "", "=q3=Thermaplugg's Left Arm", "=ds=#h2#, #w1#", "", "18.05%"};
				{ 5, 9458, "", "=q3=Thermaplugg's Central Core", "=ds=#w8#", "", "28.61%"};
				{ 6, 4415, "", "=q3=Schematic: Craftsman's Monocle", "=ds=#p5# (185)", "", ""};
				{ 7, 11828, "", "=q2=Schematic: Pet Bombling", "=ds=#p5# (205)", "", ""};
				{ 8, 4413, "", "=q2=Schematic: Discombobulator Ray", "=ds=#p5# (160)", "", ""};
				{ 9, 4411, "", "=q2=Schematic: Flame Deflector", "=ds=#p5# (125)", "", "0.7%"};
				{ 10, 7742, "", "=q1=Schematic: Gnomish Cloaking Device", "=ds=#p5# (200)", "", ""};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], ""};
				{ 17, 9508, "", "=q3=Mechbuilder's Overalls", "=ds=#s5#, #a1#", "", "0.02%"};
				{ 18, 9491, "", "=q3=Hotshot Pilot's Gloves", "=ds=#s9#, #a1#", "", "0.01%"};
				{ 19, 9509, "", "=q3=Petrolspill Leggings", "=ds=#s11#, #a2#", "", "0.01%"};
				{ 20, 9510, "", "=q3=Caverndeep Trudgers", "=ds=#s12#, #a3#", "", "0.01%"};
				{ 21, 9490, "", "=q3=Gizmotron Megachopper", "=ds=#h2#, #w10#", "", "0.01%"};
				{ 22, 9485, "", "=q3=Vibroblade", "=ds=#h1#, #w1#", "", "0.01%"};
				{ 23, 9486, "", "=q3=Supercharger Battle Axe", "=ds=#h2#, #w1#", "", "0.02%"};
				{ 24, 9488, "", "=q3=Oscillating Power Hammer", "=ds=#h1#, #w6#", "", "0.02%"};
				{ 25, 9487, "", "=q3=Hi-Tech Supergun", "=ds=#w5#", "", "0.01%"};
				{ 26, 11827, "", "=q2=Schematic: Lil' Smoky", "=ds=#p5# (205)", "", ""};
				{ 27, 9327, "", "=q2=Security DELTA Data Access Card", "=ds=#m20#", "", "1.41%"};
				{ 28, 9326, "", "=q1=Grime-Encrusted Ring", "=ds=#m2#", "", "9.38%"};
				{ 29, 9538, "", "=q3=Talvash's Gold Ring", "=q1=#m4#: =ds=#s13#"};
				{ 30, 9362, "", "=q2=Brilliant Gold Ring", "=q1=#m4#: =ds=#s13#"};
			};
		};
		info = {
			name = ALIL["Gnomeregan"],
			module = moduleName, instance = "Gnomeregan",
		};
	};

		----------------
		--- Maraudon ---
		----------------
		
	AtlasLoot_Data["MaraudonLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Noxxion", 423), ""};
				{ 2, 17746, "", "=q3=Noxxion's Shackles", "=ds=#s8#, #a3#", "", "32.50%"};
				{ 3, 17744, "", "=q3=Heart of Noxxion", "=ds=#s14#", "", "30.35%"};
				{ 4, 17745, "", "=q3=Noxious Shooter", "=ds=#w12#", "", "17.53%"};
				{ 6, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Razorlash", 424), ""};
				{ 7, 17750, "", "=q3=Chloromesh Girdle", "=ds=#s10#, #a1#", "", "22.93%"};
				{ 8, 17748, "", "=q3=Vinerot Sandals", "=ds=#s12#, #a1#", "", "20.60%"};
				{ 9, 17749, "", "=q3=Phytoskin Spaulders", "=ds=#s3#, #a2#", "", "22.09%"};
				{ 10, 17751, "", "=q3=Brusslehide Leggings", "=ds=#s11#, #a2#", "", "21.65%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lord Vyletongue", 427), ""};
				{ 17, 17755, "", "=q3=Satyrmane Sash", "=ds=#s10#, #a1#", "", "25.71%"};
				{ 18, 17754, "", "=q3=Infernal Trickster Leggings", "=ds=#s11#, #a3#", "", "28.09%"};
				{ 19, 17752, "", "=q3=Satyr's Lash", "=ds=#h1#, #w4#", "", "23.14%"};
				{ 21, 0, "INV_Box_01", "=q6="..BabbleBoss["Meshlok the Harvester"], ""};
				{ 22, 17741, "", "=q3=Nature's Embrace", "=ds=#s5#, #a1#", "", "30.34%"};
				{ 23, 17742, "", "=q3=Fungus Shroud Armor", "=ds=#s5#, #a2#", "", "31.37%"};
				{ 24, 17767, "", "=q3=Bloomsprout Headpiece", "=ds=#s1#, #a3#", "", "28.32%"};
				{ 26, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Tinkerer Gizlock", 425), ""};
				{ 27, 17719, "", "=q3=Inventor's Focal Sword", "=ds=#h1#, #w10#", "", "27.44%"};
				{ 28, 17718, "", "=q3=Gizlock's Hypertech Buckler", "=ds=#w8#", "", "30.61%"};
				{ 29, 17717, "", "=q3=Megashot Rifle", "=ds=#w5#", "", "27.23%"};

			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Celebras the Cursed", 428), ""};
				{ 2, 17739, "", "=q3=Grovekeeper's Drape", "=ds=#s4#", "", "30.32%"};
				{ 3, 17740, "", "=q3=Soothsayer's Headdress", "=ds=#s1#, #a2#", "", "28.59%"};
				{ 4, 17738, "", "=q3=Claw of Celebras", "=ds=#h1#, #w13#", "", "28.22%"};
				{ 6, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Landslide", 429), ""};
				{ 7, 17736, "", "=q3=Rockgrip Gauntlets", "=ds=#s9#, #a3#", "", "23.09%"};
				{ 8, 17734, "", "=q3=Helm of the Mountain", "=ds=#s1#, #a3#", "", "20.87%"};
				{ 9, 17737, "", "=q3=Cloud Stone", "=ds=#s15#", "", "19.99%"};
				{ 10, 17943, "", "=q3=Fist of Stone", "=ds=#h1#, #w6#", "", "16.58%"};
				{ 12, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Rotgrip", 430), ""};
				{ 13, 17732, "", "=q3=Rotgrip Mantle", "=ds=#s3#, #a1#", "", "25.73%"};
				{ 14, 17728, "", "=q3=Albino Crocscale Boots", "=ds=#s12#, #a2#", "", "26.20%"};
				{ 15, 17730, "", "=q3=Gatorbite Axe", "=ds=#h2#, #w1#", "", "19.21%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Princess Theradras", 431), ""};
				{ 17, 17780, "", "=q4=Blade of Eternal Darkness", "=ds=#h1#, #w4#", "", "0.20%"};
				{ 18, 17715, "", "=q3=Eye of Theradras", "=ds=#s1#, #a1#", "", "13.47%"};
				{ 19, 17714, "", "=q3=Bracers of the Stone Princess", "=ds=#s8#, #a3#", "", "20.06%"};
				{ 20, 17711, "", "=q3=Elemental Rockridge Leggings", "=ds=#s11#, #a3#", "", "14.96%"};
				{ 21, 17707, "", "=q3=Gemshard Heart", "=ds=#s2#", "", "15.30%"};
				{ 22, 17713, "", "=q3=Blackstone Ring", "=ds=#s13#", "", "18.92%"};
				{ 23, 17710, "", "=q3=Charstone Dirk", "=ds=#h1#, #w4#", "", "14.24%"};
				{ 24, 17766, "", "=q3=Princess Theradras' Scepter", "=ds=#h2#, #w6#", "", "16.44%"};
			};
		};
		info = {
			name = ALIL["Maraudon"],
			module = moduleName, instance = "Maraudon",
		};
	};

		----------------------
		--- Ragefire Chasm ---
		----------------------

	AtlasLoot_Data["RagefireChasmLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Adarogg", 694), ""};
				{ 2, 82772, "", "=q3=Snarlmouth Leggings", "=ds=#s11#, #a1#" },
				{ 3, 82879, "", "=q3=Collarspike Bracers", "=ds=#s8#, #a3#" },
				{ 4, 82880, "", "=q3=Fang of Adarogg", "=ds=#h1#, #w4#", ""};
				{ 6, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Dark Shaman Koranthal", 695), ""};
				{ 7, 82882, "", "=q3=Dark Ritual Cape", "=ds=#s4#", "" };
				{ 8, 82881, "", "=q3=Cuffs of Black Elements", "=ds=#s8#, #a1#", "" };
				{ 9, 82877, "", "=q3=Grasp of the Broken Totem", "=ds=#s5#, #a2#" },
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Slagmaw", 696), ""};
				{ 17, 82878, "", "=q3=Fireworm Robes", "=ds=#s5#, #a1#" },
				{ 18, 82884, "", "=q3=Chitonous Bracers", "=ds=#s8#, #a2#", "" };
				{ 19, 82885, "", "=q3=Flameseared Carapace", "=ds=#s5#, #a3#", "" };
				{ 21, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lava Guard Gordoth", 697), "#ACHIEVEMENTID:629#"};
				{ 22, 82886, "", "=q3=Gorewalker Treads", "=ds=#s12#, #a3#", "" };
				{ 23, 82883, "", "=q3=Bloodcursed Felblade", "=ds=#h1#, #w10#" };
				{ 24, 82888, "", "=q3=Heartboiler Staff", "=ds=#w9#", "" };
			};
		};
		info = {
			name = ALIL["Ragefire Chasm"],
			module = moduleName, instance = "RagefireChasm",
		};
	};
				

		----------------------
		--- Razorfen Downs ---
		----------------------
		
	AtlasLoot_Data["RazorfenDownsLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Tuten'kash", 432), ""};
				{ 2, 10776, "", "=q3=Silky Spider Cape", "=ds=#s4#", "", "28.64%"};
				{ 3, 10777, "", "=q3=Arachnid Gloves", "=ds=#s9#, #a2#", "", "28.95%"};
				{ 4, 10775, "", "=q3=Carapace of Tuten'kash", "=ds=#s5#, #a4#", "", "24.87%"};
				{ 6, 0, "INV_Box_01", "=q6="..BabbleBoss["Henry Stern"], ""};
				{ 7, 3831, "", "=q2=Recipe: Major Troll's Blood Elixir", "=ds=#p1# (180)"};
				{ 8, "s13028", "10841", "=q1=Goldthorn Tea", "=ds=#p3# (175)"};
				{ 10, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Mordresh Fire Eye", 433), ""};
				{ 11, 10771, "", "=q3=Deathmage Sash", "=ds=#s10#, #a1#", "", "27.92%"};
				{ 12, 10769, "", "=q3=Glowing Eye of Mordresh", "=ds=#s2#", "", "29.11%"};
				{ 13, 10770, "", "=q3=Mordresh's Lifeless Skull", "=ds=#s15#", "", "29.59%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Glutton", 434), ""};
				{ 17, 10774, "", "=q3=Fleshhide Shoulders", "=ds=#s3#, #a2#", "", "42.15%"};
				{ 18, 10772, "", "=q3=Glutton's Cleaver", "=ds=#h1#, #w1#", "", "44.22%"};
				{ 20, 0, "INV_Box_01", "=q6="..BabbleBoss["Ragglesnout"], ""};
				{ 21, 10768, "", "=q3=Boar Champion's Belt", "=ds=#s10#, #a3#", "", "31.40%"};
				{ 22, 10758, "", "=q3=X'caliboar", "=ds=#h2#, #w10#", "", "18.51%"};
				{ 23, 10767, "", "=q3=Savage Boar's Guard", "=ds=#w8#", "", "35.14%"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Amnennar the Coldbringer", 435), ""};
				{ 2, 10762, "", "=q3=Robes of the Lich", "=ds=#s5#, #a1#", "", "29.52%"};
				{ 3, 10765, "", "=q3=Bonefingers", "=ds=#s9#, #a2#"};
				{ 4, 10764, "", "=q3=Deathchill Armor", "=ds=#s5#, #a3#", "", "24.24%"};
				{ 5, 10763, "", "=q3=Icemetal Barbute", "=ds=#s1#, #a4#", "", "28.66%"};
				{ 6, 10761, "", "=q3=Coldrage Dagger", "=ds=#h1#, #w4#", "", "13.89%"};
				{ 8, 0, "INV_Box_01", "=q6="..BabbleBoss["Plaguemaw the Rotting"], ""};
				{ 9, 10760, "", "=q3=Swine Fists", "=ds=#s9#, #a2#", "", "58.15%"};
				{ 10, 10766, "", "=q3=Plaguerot Sprig", "=ds=#w12#, =q1=#m1# =ds=#c3#", "", "29.98%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], ""};
				{ 17, 10574, "", "=q3=Corpseshroud", "=ds=#s1#, #a1#", "", "0.01%"};
				{ 18, 10581, "", "=q3=Death's Head Vestment", "=ds=#s5#, #a1#", "", "0.02%"};
				{ 19, 10578, "", "=q3=Thoughtcast Boots", "=ds=#s12#, #a1#", "", "0.01%"};
				{ 20, 10583, "", "=q3=Quillward Harness", "=ds=#s5#, #a2#", "", "0.01%"};
				{ 21, 10582, "", "=q3=Briar Tredders", "=ds=#s12#, #a2#", "", "0.02%"};
				{ 22, 10584, "", "=q3=Stormgale Fists", "=ds=#s9#, #a4#", "", "0.02%"};
				{ 23, 10573, "", "=q3=Boneslasher", "=ds=#h2#, #w10#", "", "0.01%"};
				{ 24, 10570, "", "=q3=Manslayer", "=ds=#h2#, #w1#", "", "0.01%"};
				{ 25, 10571, "", "=q3=Ebony Boneclub", "=ds=#h1#, #w6#", "", "0.01%"};
				{ 26, 10567, "", "=q3=Quillshooter", "=ds=#w2#", "", "0.02%"};
				{ 27, 10572, "", "=q3=Freezing Shard", "=ds=#w12#, =q1=#m1# =q2=#c3#", "", "0.01%"};
			};
		};
		info = {
			name = ALIL["Razorfen Downs"],
			module = moduleName, instance = "RazorfenDowns",
		};
	};

		----------------------
		--- Razorfen Kraul ---
		----------------------

	AtlasLoot_Data["RazorfenKraulLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Aggem Thorncurse", 439), ""};
				{ 2, 6681, "", "=q3=Thornspike", "=ds=#h1#, #w4#", "", "57,12%"};
				{ 4, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Death Speaker Jargba", 438), ""};
				{ 5, 6685, "", "=q3=Death Speaker Mantle", "=ds=#s3#, #a1#", "", "40.42%"};
				{ 6, 6682, "", "=q3=Death Speaker Robes", "=ds=#s5#, #a1#", "", "40.52%"};
				{ 7, 2816, "", "=q3=Death Speaker Scepter", "=ds=#h1#, #w6#", "", "7.72%"};
				{ 9, 0, "INV_Box_01", "=q6="..AL["Razorfen Spearhide"], ""};
				{ 10, 6679, "", "=q3=Armor Piercer", "=ds=#w7#", "", "43%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Overlord Ramtusk", 440), ""};
				{ 17, 6686, "", "=q3=Tusken Helm", "=ds=#s1#, #a3#", "", "57.14%"};
				{ 18, 6687, "", "=q3=Corpsemaker", "=ds=#h2#, #w1#", "", "27.79%"};
				{ 20, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Agathelos the Raging", 441), ""};
				{ 21, 6690, "", "=q3=Ferine Leggings", "=ds=#s11#, #a2#", "", "49.21%"};
				{ 22, 6691, "", "=q3=Swinetusk Shank", "=ds=#h1#, #w4#", "", "24.85%"};
				{ 24, 0, "INV_Box_01", "=q6="..BabbleBoss["Blind Hunter"], ""};
				{ 25, 6697, "", "=q3=Batwing Mantle", "=ds=#s3#, #a1#", "", "27.65%"};
				{ 26, 6695, "", "=q3=Stygian Bone Amulet", "=ds=#s2#", "", "22.24%"};
				{ 27, 6696, "", "=q3=Nightstalker Bow", "=ds=#w2#", "", "25.12%"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Charlga Razorflank", 442), ""};
				{ 2, 6693, "", "=q3=Agamaggan's Clutch", "=ds=#s13#", "", "32.15%"};
				{ 3, 6692, "", "=q3=Pronged Reaver", "=ds=#h1#, #w1#", "", "15.43%"};
				{ 4, 6694, "", "=q3=Heart of Agamaggan", "=ds=#w8#", "", "30.24%"};
				{ 5, 5793, "", "=q1=Razorflank's Heart", "=ds=#m3#", "", "100%"};
				{ 7, 0, "INV_Box_01", "=q6="..BabbleBoss["Earthcaller Halmgar"], ""};
				{ 8, 6688, "", "=q3=Whisperwind Headdress", "=ds=#s1#, #a2#", "", "43.75%"};
				{ 9, 6689, "", "=q3=Wind Spirit Staff", "=ds=#w9#", "", "42.66%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"], ""};
				{ 17, 2264, "", "=q3=Mantle of Thieves", "=ds=#s3#, #a2#", "", "0.02%"};
				{ 18, 1978, "", "=q3=Wolfclaw Gloves", "=ds=#s9#, #a2#", "", "0.02%"};
				{ 19, 1488, "", "=q3=Avenger's Armor", "=ds=#s5#, #a3#", "", "0.01%"};
				{ 20, 4438, "", "=q3=Pugilist Bracers", "=ds=#s8#, #a3#", "", "0.01%"};
				{ 21, 2039, "", "=q3=Plains Ring", "=ds=#s13#", "", "0.02%"};
				{ 22, 776, "", "=q3=Vendetta", "=ds=#h1#, #w4#", "", "0.01%"};
				{ 23, 1727, "", "=q3=Sword of Decay", "=ds=#h1#, #w10#", "", "0.02%"};
				{ 24, 1975, "", "=q3=Pysan's Old Greatsword", "=ds=#h2#, #w10#", "", "0.02%"};
				{ 25, 1976, "", "=q3=Slaghammer", "=ds=#h2#, #w6#", "", "0.02%"};
				{ 26, 2549, "", "=q3=Staff of the Shade", "=ds=#w9#", "", "0.02%"};
			};
		};
		info = {
			name = ALIL["Razorfen Kraul"],
			module = moduleName, instance = "RazorfenKraul",
		};
	};

		---------------------
		--- Scarlet Halls ---
		---------------------

	AtlasLoot_Data["SHBraun"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88266, "", "=q3=Hound Trainer's Gloves", "=ds=#s9#, #a2#" },
				{ 3, 88268, "", "=q3=Canine Commander's Breastplate", "=ds=#s5#, #a4#" },
				{ 4, 88267, "", "=q3=Commanding Bracers", "=ds=#s8#, #a4#" },
				{ 5, 88265, "", "=q3=Beastbinder Ring", "=ds=#s13#" },
   				{ 6, 88264, "", "=q3=Houndmaster's Compound Crossbow", "=ds=#w3#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81695, "", "=q3=Hound Trainer's Gloves", "=ds=#s9#, #a2#" },
				{ 18, 81696, "", "=q3=Canine Commander's Breastplate", "=ds=#s5#, #a4#" },
				{ 19, 81694, "", "=q3=Commanding Bracers", "=ds=#s8#, #a4#" },
				{ 20, 81563, "", "=q3=Beastbinder Ring", "=ds=#s13#" },
				{ 21, 81693, "", "=q3=Houndmaster's Compound Crossbow", "=ds=#w3#" },
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
				{ 2, 88269, "", "=q3=Scarlet Sandals", "=ds=#s12#, #a1#" },
				{ 3, 88270, "", "=q3=Lightblade Bracer", "=ds=#s8#, #a2#" },
				{ 4, 88271, "", "=q3=Harlan's Shoulders", "=ds=#s3#, #a3#" },
				{ 5, 88273, "", "=q3=Armsmaster's Sealed Locket", "=ds=#s2#" },
   				{ 6, 88272, "", "=q3=The Gleaming Ravager", "=ds=#h2#, #w1#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81699, "", "=q3=Scarlet Sandals", "=ds=#s12#, #a1#" },
				{ 18, 81700, "", "=q3=Lightblade Bracer", "=ds=#s8#, #a2#" },
				{ 19, 81698, "", "=q3=Harlan's Shoulders", "=ds=#s3#, #a3#" },
				{ 20, 81568, "", "=q3=Armsmaster's Sealed Locket", "=ds=#s2#" },
				{ 21, 81697, "", "=q3=The Gleaming Ravager", "=ds=#h2#, #w1#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Armsmaster Harlan", 654),
			module = moduleName, instance = "ScarletHalls",
		};
	};

	AtlasLoot_Data["SHHarlan"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88269, "", "=q3=Scarlet Sandals", "=ds=#s12#, #a1#" },
				{ 3, 88270, "", "=q3=Lightblade Bracer", "=ds=#s8#, #a2#" },
				{ 4, 88271, "", "=q3=Harlan's Shoulders", "=ds=#s3#, #a3#" },
				{ 5, 88273, "", "=q3=Armsmaster's Sealed Locket", "=ds=#s2#" },
   				{ 6, 88272, "", "=q3=The Gleaming Ravager", "=ds=#h2#, #w1#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81699, "", "=q3=Scarlet Sandals", "=ds=#s12#, #a1#" },
				{ 18, 81700, "", "=q3=Lightblade Bracer", "=ds=#s8#, #a2#" },
				{ 19, 81698, "", "=q3=Harlan's Shoulders", "=ds=#s3#, #a3#" },
				{ 20, 81568, "", "=q3=Armsmaster's Sealed Locket", "=ds=#s2#" },
				{ 21, 81697, "", "=q3=The Gleaming Ravager", "=ds=#h2#, #w1#" },
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
				{ 2, 88279, "", "=q3=Robes of Koegler", "=ds=#s5#, #a1#" },
				{ 3, 88282, "", "=q3=Vellum-Ripper Gloves", "=ds=#s9#, #a2#" },
				{ 4, 88276, "", "=q3=Bindburner Belt", "=ds=#s10#, #a3#" },
				{ 5, 88283, "", "=q3=Bradbury's Entropic Legguards", "=ds=#s11#, #a3#" },
				{ 6, 88277, "", "=q3=Pyretic Legguards", "=ds=#s11#, #a4#" },
				{ 7, 88275, "", "=q3=Scorched Scarlet Key", "=ds=#s2#" },
				{ 8, 88281, "", "=q3=Temperature-Sensing Necklace", "=ds=#s2#" },
				{ 9, 88280, "", "=q3=Melted Hypnotic Blade", "=ds=#h1#, #w4#" },
				{ 10, 88274, "", "=q3=Koegler's Ritual Knife", "=ds=#h1#, #w4#" },
				{ 11, 88278, "", "=q3=Mograine's Immaculate Might", "=ds=#h2#, #w6#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 87550, "", "=q4=Vithrak, Gaze of the Deadman", "=ds=#s13#" },
				{ 18, 82817, "", "=q3=Robes of Koegler", "=ds=#s5#, #a1#" },
 				{ 19, 82818, "", "=q3=Vellum-Ripper Gloves", "=ds=#s9#, #a2#" },
				{ 20, 82815, "", "=q3=Bindburner Belt", "=ds=#s10#, #a3#" },
				{ 21, 82819, "", "=q3=Bradbury's Entropic Legguards", "=ds=#s11#, #a3#" },
				{ 22, 82812, "", "=q3=Pyretic Legguards", "=ds=#s11#, #a4#" },
				{ 23, 81564, "", "=q3=Scorched Scarlet Key", "=ds=#s2#" },
				{ 24, 81565, "", "=q3=Temperature-Sensing Necklace", "=ds=#s2#" },
				{ 25, 82816, "", "=q3=Melted Hypnotic Blade", "=ds=#h1#, #w4#" },
				{ 26, 82813, "", "=q3=Koegler's Ritual Knife", "=ds=#h1#, #w4#" },
				{ 27, 82814, "", "=q3=Mograine's Immaculate Might", "=ds=#h2#, #w6#" },
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
				{ 2, 88288, "", "=q3=Soulrender Greatcloak", "=ds=#s4#" },
   				{ 3, 88284, "", "=q3=Forgotten Bloodmage Mantle", "=ds=#s3#, #a1#" },
				{ 4, 88286, "", "=q3=Legguards of the Crimson Magus", "=ds=#s11#, #a3#" },
				{ 5, 88287, "", "=q3=Bracers of the Fallen Crusader", "=ds=#s8#, #a4#" },
				{ 6, 88285, "", "=q3=Signet of the Hidden Door", "=ds=#s13#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81571, "", "=q3=Soulrender Greatcloak", "=ds=#s4#" },
				{ 18, 81569, "", "=q3=Forgotten Bloodmage Mantle", "=ds=#s3#, #a1#" },
				{ 19, 81570, "", "=q3=Legguards of the Crimson Magus", "=ds=#s11#, #a3#" },
				{ 20, 81572, "", "=q3=Bracers of the Fallen Crusader", "=ds=#s8#, #a4#" },
				{ 21, 81560, "", "=q3=Signet of the Hidden Door", "=ds=#s13#" },
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
				{ 2, 88290, "", "=q3=Scorched Earth Cloak", "=ds=#s4#, #a1#" },
				{ 3, 88291, "", "=q3=Korloff's Raiment", "=ds=#s5#, #a2#" },
				{ 4, 88292, "", "=q3=Helm of Rising Flame", "=ds=#s1#, #a4#" },
				{ 5, 88293, "", "=q3=Firefinger Ring", "=ds=#s13#" },
				{ 6, 88289, "", "=q3=Firestorm Greatstaff", "=ds=#w9#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 81575, "", "=q3=Scorched Earth Cloak", "=ds=#s4#, #a1#" },
				{ 18, 81573, "", "=q3=Korloff's Raiment", "=ds=#s5#, #a2#" },
				{ 19, 81574, "", "=q3=Helm of Rising Flame", "=ds=#s1#, #a4#" },
				{ 20, 81561, "", "=q3=Firefinger Ring", "=ds=#s13#" },
				{ 21, 81576, "", "=q3=Firestorm Greatstaff", "=ds=#w9#" },
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
				{ 2, 88299, "", "=q3=Whitemane's Embroidered Chapeau", "=ds=#s1#, #a1#" },
				{ 3, 88298, "", "=q3=Leggings of Hallowed Fire", "=ds=#s11#, #a1#" },
				{ 4, 88302, "", "=q3=Incarnadine Scarlet Spaulders", "=ds=#s3#, #a2#" },
				{ 5, 88295, "", "=q3=Dashing Strike Treads", "=ds=#s12#, #a2#" },
				{ 6, 88303, "", "=q3=Crown of Holy Flame", "=ds=#s1#, #a4#" },
				{ 7, 88296, "", "=q3=Waistplate of Imminent Resurrection", "=ds=#s10#, #a4#" },
				{ 8, 88300, "", "=q3=Triune Signet", "=ds=#s13#" },
				{ 9, 88294, "", "=q3=Flashing Steel Talisman", "=ds=#s14#" },
				{ 10, 88297, "", "=q3=Lightbreaker Greatsword", "=ds=#h2#, #w10#" },
				{ 11, 88301, "", "=q3=Greatstaff of Righteousness", "=ds=#w9#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 87551, "", "=q4=Helios, Durand's Soul of Purity", "=ds=#s2#" },
				{ 18, 81692, "", "=q3=Whitemane's Embroidered Chapeau", "=ds=#s1#, #a1#" },
				{ 19, 81689, "", "=q3=Leggings of Hallowed Fire", "=ds=#s11#, #a1#" },
				{ 20, 81690, "", "=q3=Incarnadine Scarlet Spaulders", "=ds=#s3#, #a2#" },
				{ 21, 81688, "", "=q3=Dashing Strike Treads", "=ds=#s12#, #a2#" },
				{ 22, 81578, "", "=q3=Crown of Holy Flame", "=ds=#s1#, #a4#" },
				{ 23, 81687, "", "=q3=Waistplate of Imminent Resurrection", "=ds=#s10#, #a4#" },
				{ 24, 81562, "", "=q3=Triune Signet", "=ds=Finger, #m20#" },
				{ 25, 81265, "", "=q3=Flashing Steel Talisman", "=ds=#s14#, #m20#" },
				{ 26, 81577, "", "=q3=Lightbreaker Greatsword", "=ds=#h2#, #w10#" },
				{ 27, 81691, "", "=q3=Greatstaff of Righteousness", "=ds=#w9#" },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("High Inquisitor Whitemane", 674),
			module = moduleName, instance = "ScarletMonastery",
		};
	};

		-------------------
		--- Scholomance ---
		-------------------

	AtlasLoot_Data["ScholoChillheart"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#j1#", ""};
				{ 2, 88336, "", "=q3=Icewrath Belt", "=ds=#s10#, #a2#" },
				{ 3, 88337, "", "=q3=Shadow Puppet Bracers", "=ds=#s8#, #a3#" },
				{ 4, 88338, "", "=q3=Breastplate of Wracking Souls", "=ds=#s5#, #a4#" },
				{ 5, 88335, "", "=q3=Anarchist's Pendant", "=ds=#s2#" },
				{ 6, 88339, "", "=q3=Gravetouch Greatsword", "=ds=#h2#, #w10#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82823, "", "=q3=Icewrath Belt", "=ds=#s10#, #a2#" },
				{ 18, 82820, "", "=q3=Shadow Puppet Bracers", "=ds=#s8#, #a3#" },
				{ 19, 82821, "", "=q3=Breastplate of Wracking Souls", "=ds=#s5#, #a4#" },
				{ 20, 81566, "", "=q3=Anarchist's Pendant", "=ds=#s2#" },
				{ 21, 82822, "", "=q3=Gravetouch Greatsword", "=ds=#h2#, #w10#" },
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
				{ 2, 88349, "", "=q3=Phantasmal Drape", "=ds=#s4#" },
				{ 3, 88345, "", "=q3=Barovian Ritual Hood", "=ds=#s1#, #a1#" },
				{ 4, 88347, "", "=q3=Ghostwoven Legguards", "=ds=#s11#, #a2#" },
				{ 5, 88348, "", "=q3=Wraithplate Treads", "=ds=#s12#, #a4#" },
				{ 6, 88346, "", "=q3=Metanoia Shield", "=ds=#w8#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82850, "", "=q3=Phantasmal Drape", "=ds=#s4#, #a1#" },
				{ 18, 82848, "", "=q3=Barovian Ritual Hood", "=ds=#s1#, #a1#" },
				{ 19, 82851, "", "=q3=Ghostwoven Legguards", "=ds=#s11#, #a2#" },
				{ 20, 82852, "", "=q3=Wraithplate Treads", "=ds=#s12#, #a4#" },
				{ 21, 82847, "", "=q3=Metanoia Shield", "=ds=#w8#" },
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
				{ 2, 88340, "", "=q3=Deadwalker Bracers", "=ds=#s8#, #a1#" },
				{ 3, 88342, "", "=q3=Rattling Gloves", "=ds=#s9#, #a2#" },
				{ 4, 88343, "", "=q3=Bone Golem Boots", "=ds=#s12#, #a3#" },
				{ 5, 88344, "", "=q3=Goresoaked Headreaper", "=ds=#h2#, #w1#" },
				{ 6, 88341, "", "=q3=Necromantic Wand", "=ds=#w12#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82825, "", "=q3=Deadwalker Bracers", "=ds=#s8#, #a1#" },
				{ 18, 82827, "", "=q3=Rattling Gloves", "=ds=#s9#, #a2#" },
				{ 19, 82828, "", "=q3=Bone Golem Boots", "=ds=#s12#, #a3#" },
				{ 20, 82824, "", "=q3=Goresoaked Headreaper", "=ds=#h2#, #w1#" },
				{ 21, 82826, "", "=q3=Necromantic Wand", "=ds=#w12#" },
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
				{ 2, 88350, "", "=q3=Leggings of Unleashed Anguish", "=ds=#s11#, #a1#" },
				{ 3, 88351, "", "=q3=Soulburner Crown", "=ds=#s1#, #a2#" },
				{ 4, 88352, "", "=q3=Shivbreaker Vest", "=ds=#s5#, #a3#" },
				{ 5, 88353, "", "=q3=Dark Blaze Gauntlets", "=ds=#s9#, #a4#" },
				{ 6, 88354, "", "=q3=Necklace of the Dark Blaze", "=ds=#s2#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82854, "", "=q3=Leggings of Unleashed Anguish", "=ds=#s11#, #a1#" },
				{ 18, 82853, "", "=q3=Soulburner Crown", "=ds=#s1#, #a2#" },
				{ 19, 82855, "", "=q3=Shivbreaker Vest", "=ds=#s5#, #a3#" },
				{ 20, 82856, "", "=q3=Dark Blaze Gauntlets", "=ds=#s9#, #a4#" },
				{ 21, 81567, "", "=q3=Necklace of the Dark Blaze", "=ds=#s2#" },
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
				{ 2, 88359, "", "=q3=Incineration Belt", "=ds=#s10#, #a1#" },
				{ 3, 88356, "", "=q3=Tombstone Gauntlets", "=ds=#s9#, #a2#" },
				{ 4, 88361, "", "=q3=Gloves of Explosive Pain", "=ds=#s9#, #a3#" },
				{ 5, 88362, "", "=q3=Shoulderguards of Painful Lessons", "=ds=#s3#, #a4#" },
				{ 6, 88357, "", "=q3=Vigorsteel Spaulders", "=ds=#s3#, #a4#" },
				{ 7, 88358, "", "=q3=Lessons of the Darkmaster", "=ds=#s14#" },
				{ 8, 88360, "", "=q3=Price of Progress", "=ds=#s14#" },
				{ 9, 88355, "", "=q3=Searing Words", "=ds=#s14#" },
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 17, 82859, "", "=q4=Headmaster's Will", "=ds=Staves, Weapon" },
				{ 18, 82861, "", "=q3=Incineration Belt", "=ds=#s10#, #a1#" },
				{ 19, 82858, "", "=q3=Tombstone Gauntlets", "=ds=#s9#, #a2#" },
				{ 20, 82860, "", "=q3=Gloves of Explosive Pain", "=ds=#s9#, #a3#" },
				{ 21, 82862, "", "=q3=Shoulderguards of Painful Lessons", "=ds=#s3#, #a4#" },
				{ 22, 82857, "", "=q3=Vigorsteel Spaulders", "=ds=#s3#, #a4#" },
				{ 23, 81268, "", "=q3=Lessons of the Darkmaster", "=ds=#s14#" },
				{ 24, 81266, "", "=q3=Price of Progress", "=ds=#s14#" },
				{ 25, 81267, "", "=q3=Searing Words", "=ds=#s14#" },
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Darkmaster Gandling", 684),
			module = moduleName, instance = "Scholomance",
		};
	};

	AtlasLoot_Data["ScholoTrash"] = {
		["Normal"] = {
			{

			}
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "Scholomance",
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
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
				{ 18, 63439, "", "=q3=Gloves of the Uplifted Cup", "=ds=#s8#, #a2#" };
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
				{ 21, 63448, "", "=q3=Springvale's Cloak", "=ds=#s4#" };
				{ 21, 63449, "", "=q3=Thieving Spaulders", "=ds=#s3#, #a2#" };
				{ 21, 63447, "", "=q3=Breastplate of the Stilled Heart", "=ds=#s5#, #a3#" };
				{ 21, 63446, "", "=q3=Haunting Footfalls", "=ds=#s12#, #a3#" };
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
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

		--------------------------------------
		--- Stratholme - Crusader's Square ---
		--------------------------------------

	AtlasLoot_Data["STRATTheUnforgiven"] = {
		["Normal"] = {
			{
				{ 1, 13409, "", "=q3=Tearfall Bracers", "=ds=#s8#, #a1#", "", "14.62%"};
				{ 2, 13404, "", "=q3=Mask of the Unforgiven", "=ds=#s1#, #a2#", "", "14.96%"};
				{ 3, 13405, "", "=q3=Wailing Nightbane Pauldrons", "=ds=#s3#, #a4#", "", "12.10%"};
				{ 4, 13408, "", "=q3=Soul Breaker", "=ds=#h1#, #w1#", "", "19.33%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Unforgiven", 450),
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATTimmytheCruel"] = {
		["Normal"] = {
			{
				{ 1, 13403, "", "=q3=Grimgore Noose", "=ds=#s10#, #a1#", "", "16.48%"};
				{ 2, 13402, "", "=q3=Timmy's Galoshes", "=ds=#s12#, #a3#", "", "16.74%"};
				{ 3, 13400, "", "=q3=Vambraces of the Sadist", "=ds=#s8#, #a4#", "", "14.02%"};
				{ 4, 13401, "", "=q3=The Cruel Hand of Timmy", "=ds=#h1#, #w6#", "", "16.87%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Timmy the Cruel", 445),
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATWilleyHopebreaker"] = {
		["Normal"] = {
			{
				{ 1, 22405, "", "=q3=Mantle of the Scarlet Crusade", "=ds=#s3#, #a1#", "", "16.03%"};
				{ 2, 22407, "", "=q3=Helm of the New Moon", "=ds=#s1#, #a2#", "", "13.61%"};
				{ 3, 18721, "", "=q3=Barrage Girdle", "=ds=#s10#, #a3#", "", "12.39%"};
				{ 4, 13381, "", "=q3=Master Cannoneer Boots", "=ds=#s12#, #a4#", "", "12.86%"};
				{ 5, 22403, "", "=q3=Diana's Pearl Necklace", "=ds=#s2#", "", "14.27%"};
				{ 6, 13382, "", "=q3=Cannonball Runner", "=ds=#s14#", "", "12.28%"};
				{ 7, 22404, "", "=q3=Willey's Back Scratcher", "=ds=#h1#, #w13#", "", "6.26%"};
				{ 8, 22406, "", "=q3=Redemption", "=ds=#w9#", "", "7.04%"};
				{ 9, 13380, "", "=q3=Willey's Portable Howitzer", "=ds=#w5#", "", "10.71%"};
				{ 16, 12839, "", "=q3=Plans: Heartseeker", "=ds=#p2# (300)", "", "4.98%"};
				{ 17, 12783, "", "=q3=Heartseeker", "=ds=#h1#, #w4#"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Willey Hopebreaker", 446),
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATInstructorGalford"] = {
		["Normal"] = {
			{
				{ 1, 13386, "", "=q3=Archivist Cape", "=ds=#s4#", "", "18.45%"};
				{ 2, 18716, "", "=q3=Ash Covered Boots", "=ds=#s12#, #a2#", "", "16.30%"};
				{ 3, 13387, "", "=q3=Foresight Girdle", "=ds=#s10#, #a3#", "", "18.24%"};
				{ 4, 13385, "", "=q3=Tome of Knowledge", "=ds=#s15#", "", "9.87%"};
				{ 6, 12811, "", "=q2=Righteous Orb", "=ds=#e8#", "", "61.3%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Unfinished Painting"], ""};
				{ 17, 14679, "", "=q1=Of Love and Family", "=ds=#m3#"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Instructor Galford", 448),
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATBalnazzar"] = {
		["Normal"] = {
			{
				{ 1, 13353, "", "=q4=Book of the Dead", "=ds=#s15#", "", "1.37%"};
				{ 2, 14512, "", "=q4=Pattern: Truefaith Vestments", "=ds=#p8# (300)", "", "3.02%"};
				{ 3, 14154, "", "=q4=Truefaith Vestments", "=ds=#s5#, #a1# =q1=#m1# =ds=#c5#"};
				{ 5, 18720, "", "=q3=Shroud of the Nathrezim", "=ds=#s3#, #a1#", "", "10.54%"};
				{ 6, 13369, "", "=q3=Fire Striders", "=ds=#s12#, #a1#", "", "14.84%"};
				{ 7, 13358, "", "=q3=Wyrmtongue Shoulders", "=ds=#s3#, #a2#", "", "11.58%"};
				{ 8, 13359, "", "=q3=Crown of Tyranny", "=ds=#s1#, #a3#", "", "13.94%"};
				{ 9, 18718, "", "=q3=Grand Crusader's Helm", "=ds=#s1#, #a4#", "", "10.16%"};
				{ 10, 12103, "", "=q3=Star of Mystaria", "=ds=#s2#", "", "12.48%"};
				{ 11, 13360, "", "=q3=Gift of the Elven Magi", "=ds=#h1#, #w4#", "", "13.66%"};
				{ 12, 13348, "", "=q3=Demonshear", "=ds=#h2#, #w10#", "", "13.94%"};
				{ 13, 18717, "", "=q3=Hammer of the Grand Crusader", "=ds=#h2#, #w6#", "", "11.91%"};
				{ 16, 13520, "", "=q2=Recipe: Flask of Distilled Wisdom", "=ds=#p1# (300)", "", "1.94%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Balnazzar", 449),
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATSkull"] = {
		["Normal"] = {
			{
				{ 1, 13395, "", "=q3=Skul's Fingerbone Claws", "=ds=#s9#, #a2#", "", "36.52%"};
				{ 2, 13394, "", "=q3=Skul's Cold Embrace", "=ds=#s5#, #a4#", "", "24.16%"};
				{ 3, 13396, "", "=q3=Skul's Ghastly Touch", "=ds=#w12#", "", "16.85%"};
			}
		};
		info = {
			name = BabbleBoss["Skul"],
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATFrasSiabi"] = {
		["Normal"] = {
			{
				{ 1, 13172, "", "=q1=Siabi's Premium Tobacco", "=ds=#m3#", "", "100%"};
			}
		};
		info = {
			name = BabbleBoss["Fras Siabi"],
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATHearthsingerForresten"] = {
		["Normal"] = {
			{
				{ 1, 13378, "", "=q3=Songbird Blouse", "=ds=#s5#, #a2#", "", "15.31%"};
				{ 2, 13383, "", "=q3=Woollies of the Prancing Minstrel", "=ds=#s11#, #a3#", "", "18.42%"};
				{ 3, 13384, "", "=q3=Rainbow Girdle", "=ds=#s10#, #a4#", "", "19.21%"};
				{ 4, 13379, "", "=q3=Piccolo of the Flaming Fire", "=ds=#s14#", "", "15.13%"};
			}
		};
		info = {
			name = BabbleBoss["Hearthsinger Forresten"],
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATRisenHammersmith"] = {
		["Normal"] = {
			{
				{ 1, 18781, "", "=q3=Bottom Half of Advanced Armorsmithing: Volume II", "=ds=#m3#", "", "41.6%"};
				{ 2, 12726, "", "=q3=Plans: Enchanted Thorium Leggings", "=q1=#m4#: =ds=#p2# (300)"};
				{ 4, 12827, "", "=q2=Plans: Serenity", "=ds=#p2# (285)", "", "100%"};
			}
		};
		info = {
			name = BabbleBoss["Risen Hammersmith"].." ("..AL["Summon"]..")",
			module = moduleName, instance = "StratholmeCrusader",
		};
	};

	AtlasLoot_Data["STRATTrash"] = {
		["Normal"] = {
			{
				{ 1, 18743, "", "=q3=Gracious Cape", "=ds=#s4#", "", "0.01%"};
				{ 2, 17061, "", "=q3=Juno's Shadow", "=ds=#s4#", "", "0.01%"};
				{ 3, 18745, "", "=q3=Sacred Cloth Leggings", "=ds=#s11#, #a1#", "", "0.01%"};
				{ 4, 18744, "", "=q3=Plaguebat Fur Gloves", "=ds=#s9#, #a2#", "", "0.00%"};
				{ 5, 18736, "", "=q3=Plaguehound Leggings", "=ds=#s11#, #a2#", "", "0.00%"};
				{ 6, 18742, "", "=q3=Stratholme Militia Shoulderguard", "=ds=#s3#, #a3#", "", "0.00%"};
				{ 7, 18741, "", "=q3=Morlune's Bracer", "=ds=#s8#, #a4#", "", "0.01%"};
				{ 9, 12811, "", "=q2=Righteous Orb", "=ds=#e8#", "", "5.09%"};
				{ 16, 16249, "", "=q2=Formula: Enchant 2H Weapon - Major Intellect", "=ds=#p4# (300) =q1="..AL["Crimson Sorcerer"], "", "1.19%"};
				{ 17, 16248, "", "=q2=Formula: Enchant Weapon - Unholy", "=ds=#p4# (295) =q1="..AL["Thuzadin Shadowcaster"], "", "0.36%"};
				{ 18, 18658, "", "=q2=Schematic: Ultra-Flash Shadow Reflector", "=ds=#p5# (300) =q1="..AL["Crimson Inquisitor"], "", "1.82%"};
				{ 19, 16052, "", "=q2=Schematic: Voice Amplification Modulator", "=ds=#p5# (290) =q1="..AL["Crimson Inquisitor"], "", "1.99%"};
				{ 20, 15777, "", "=q2=Pattern: Runic Leather Shoulders", "=ds=#p7# (300) =q1="..AL["Crimson Battle Mage"], "", "1.00%"};
				{ 21, 15768, "", "=q2=Pattern: Wicked Leather Belt", "=ds=#p7# (300) =q1="..AL["Ghoul Ravener"], "", "0.85%"};
				{ 22, 14495, "", "=q2=Pattern: Ghostweave Pants", "=ds=#p8# (290) =q1="..AL["Spectral Citizen"], "", "2.13%"};
			}
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, NextPrevDisable = true,
		};
	};

		---------------------------------
		--- Stratholme - The Gauntlet ---
		---------------------------------

	AtlasLoot_Data["STRATBaronessAnastari"] = {
		["Normal"] = {
			{
				{ 1, 13535, "", "=q3=Coldtouch Phantom Wraps", "=ds=#s5#, #a1#", "", "9.84%"};
				{ 2, 18730, "", "=q3=Shadowy Laced Handwraps", "=ds=#s9#, #a1#", "", "13.54%"};
				{ 3, 13537, "", "=q3=Chillhide Bracers", "=ds=#s8#, #a2#", "", "9.71%"};
				{ 4, 13538, "", "=q3=Windshrieker Pauldrons", "=ds=#s3#, #a3#", "", "9.75%"};
				{ 5, 13539, "", "=q3=Banshee's Touch", "=ds=#s9#, #a4#", "", "8.27%"};
				{ 6, 18728, "", "=q3=Anastari Heirloom", "=ds=#s2#", "", "11.92%"};
				{ 7, 13534, "", "=q3=Banshee Finger", "=ds=#w12#", "", "13.42%"};
				{ 8, 18729, "", "=q3=Screeching Bow", "=ds=#w2#", "", "15.59%"};
				{ 10, 13514, "", "=q2=Wail of the Banshee", "=ds=#m20#", "", "7.73%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Baroness Anastari", 451),
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATNerubenkan"] = {
		["Normal"] = {
			{
				{ 1, 18740, "", "=q3=Thuzadin Sash", "=ds=#s10#, #a1#", "", "14.72%"};
				{ 2, 18739, "", "=q3=Chitinous Plate Legguards", "=ds=#s11#, #a4#", "", "12.19%"};
				{ 3, 13529, "", "=q3=Husk of Nerub'enkan", "=ds=#w8#", "", "12.62%"};
				{ 4, 18738, "", "=q3=Carapace Spine Crossbow", "=ds=#w3#", "", "14.17%"};
				{ 6, 13530, "", "=q2=Fangdrip Runners", "=ds=#s12#, #a1#", "", "8.49%"};
				{ 7, 13531, "", "=q2=Crypt Stalker Leggings", "=ds=#s11#, #a2#", "", "10.17%"};
				{ 8, 13532, "", "=q2=Darkspinner Claws", "=ds=#s9#, #a3#", "", "9.69%"};
				{ 9, 13533, "", "=q2=Acid-Etched Pauldrons", "=ds=#s3#, #a4#", "", "8.11%"};
				{ 10, 13508, "", "=q2=Eye of Arachnida", "=ds=#m20#", "", "7.39%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Nerub'enkan", 452),
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATMalekithePallid"] = {
		["Normal"] = {
			{
				{ 1, 18734, "", "=q3=Pale Moon Cloak", "=ds=#s4#", "", "13.42%"};
				{ 2, 13525, "", "=q3=Darkbind Fingers", "=ds=#s9#, #a1#", "", "9.15%"};
				{ 3, 18735, "", "=q3=Maleki's Footwraps", "=ds=#s12#, #a1#", "", "15.03%"};
				{ 4, 13526, "", "=q3=Flamescarred Girdle", "=ds=#s10#, #a2#", "", "9.57%"};
				{ 5, 13528, "", "=q3=Twilight Void Bracers", "=ds=#s8#, #a3#", "", "9.49%"};
				{ 6, 13527, "", "=q3=Lavawalker Greaves", "=ds=#s12#, #a4#", "", "9.39%"};
				{ 7, 13524, "", "=q3=Skull of Burning Shadows", "=ds=#s15#", "", "13.42%"};
				{ 8, 18737, "", "=q3=Bone Slicing Hatchet", "=ds=#h1#, #w1#", "", "14.23%"};
				{ 10, 13509, "", "=q2=Clutch of Foresight", "=ds=#m20#", "", "6.95%"};
				{ 16, 12833, "", "=q3=Plans: Hammer of the Titans", "=ds=#p2# (300)", "", "5.86%"};
				{ 17, 12796, "", "=q3=Hammer of the Titans", "=ds=#h2#, #w6#"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Maleki the Pallid", 453),
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATMagistrateBarthilas"] = {
		["Normal"] = {
			{
				{ 1, 13376, "", "=q3=Royal Tribunal Cloak", "=ds=#s4#", "", "12.44%"};
				{ 2, 18727, "", "=q3=Crimson Felt Hat", "=ds=#s1#, #a1#", "", "13.82%"};
				{ 3, 18726, "", "=q3=Magistrate's Cuffs", "=ds=#s8#, #a2#", "", "12.87%"};
				{ 4, 18722, "", "=q3=Death Grips", "=ds=#s9#, #a4#", "", "15.34%"};
				{ 5, 18725, "", "=q3=Peacemaker", "=ds=#w7#", "", "14.22%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Magistrate Barthilas", 454),
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATRamsteintheGorger"] = {
		["Normal"] = {
			{
				{ 1, 13374, "", "=q3=Soulstealer Mantle", "=ds=#s3#, #a1#", "", "9.87%"};
				{ 2, 18723, "", "=q3=Animated Chain Necklace", "=ds=#s2#", "", "7.54%"};
				{ 3, 13373, "", "=q3=Band of Flesh", "=ds=#s13#", "", "8.15%"};
				{ 4, 13515, "", "=q3=Ramstein's Lightning Bolts", "=ds=#s14#", "", "8.09%"};
				{ 5, 13372, "", "=q3=Slavedriver's Cane", "=ds=#w9#", "", "8.63%"};
				{ 6, 13375, "", "=q3=Crest of Retribution", "=ds=#w8#", "", "9.17%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Ramstein the Gorger", 455),
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATLordAuriusRivendare"] = {
		["Normal"] = {
			{
				{ 1, 13505, "", "=q4=Runeblade of Baron Rivendare", "=ds=#h2#, #w10#", "", "1%"};
				{ 2, 13335, "", "=q4=Deathcharger's Reins", "=ds=#e26#", "", "1%"};
				{ 4, 13340, "", "=q3=Cape of the Black Baron", "=ds=#s4#", "", "8.75%"};
				{ 5, 22412, "", "=q3=Thuzadin Mantle", "=ds=#s3#, #a1#", "", "4.16%"};
				{ 6, 13346, "", "=q3=Robes of the Exalted", "=ds=#s5#, #a1#", "", "11.51%"};
				{ 7, 22409, "", "=q3=Tunic of the Crescent Moon", "=ds=#s5#, #a2#", "", "4.59%"};
				{ 8, 13344, "", "=q3=Dracorian Gauntlets", "=ds=#s9#, #a3#", "", "10.85%"};
				{ 9, 22410, "", "=q3=Gauntlets of Deftness", "=ds=#s9#, #a3#", "", "4.98%"};
				{ 10, 22411, "", "=q3=Helm of the Executioner", "=ds=#s1#, #a4#", "", "3.80%"};
				{ 11, 13345, "", "=q3=Seal of Rivendare", "=ds=#s13#", "", "9.50%"};
				{ 16, 13368, "", "=q3=Bonescraper", "=ds=#h1#, #w4#", "", "4.32%"};
				{ 17, 13361, "", "=q3=Skullforge Reaver", "=ds=#h1#, #w10#", "", "4.25%"};
				{ 18, 13349, "", "=q3=Scepter of the Unholy", "=ds=#h1#, #w6#", "", "9.30%"};
				{ 19, 22408, "", "=q3=Ritssyn's Wand of Bad Mojo", "=ds=#w12#", "", "3.39%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Lord Aurius Rivendare", 456),
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATBlackGuardSwordsmith"] = {
		["Normal"] = {
			{
				{ 1, 18783, "", "=q3=Bottom Half of Advanced Armorsmithing: Volume III", "=ds=#m3#", "", "23.5%"};
				{ 2, 12725, "", "=q3=Plans: Enchanted Thorium Helm", "=q1=#m4#: =ds=#p2# (300)"};
				{ 4, 12830, "", "=q1=Plans: Corruption", "=ds=#p2# (290)", "", "100%"};
			}
		};
		info = {
			name = BabbleBoss["Black Guard Swordsmith"].." ("..AL["Summon"]..")",
			module = moduleName, instance = "StratholmeGauntlet",
		};
	};

	AtlasLoot_Data["STRATStonespine"] = {
		["Normal"] = {
			{
				{ 1, 13397, "", "=q3=Stoneskin Gargoyle Cape", "=ds=#s4#", "", "23.44%"};
				{ 2, 13954, "", "=q3=Verdant Footpads", "=ds=#s12#, #a2#", "", "25.36%"};
				{ 3, 13399, "", "=q3=Gargoyle Shredder Talons", "=ds=#h1#, #w13#", "", "26.16%"};
			}
		};
		info = {
			name = BabbleBoss["Stonespine"],
			module = moduleName, instance = "StratholmeGauntlet",
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
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
				{ 16, 0, "inv_box_04", "=q6=#j3#", ""};
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
		["Normal"] = {
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
				{ 17, 0, "INV_Box_01", "=q6="..BabbleBoss["Marisa du'Paige"], "=ec1=#j28#"};
				{ 18, 3019, "", "=q3=Noble's Robe", "=ds=#s5#, #a1#", "", "22.4%"};
				{ 19, 4660, "", "=q3=Walking Boots", "=ds=#s12#, #a1#", "", "71.4%"};
				{ 21, 0, "INV_Box_01", "=q6="..BabbleBoss["Brainwashed Noble"], "=ec1=#j28#"};
				{ 22, 5967, "", "=q3=Girdle of Nobility", "=ds=#s10#, #a1#", "", "70.4%"};
				{ 23, 3902, "", "=q3=Staff of Nobles", "=ds=#w9#", "", "23.0%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "TheDeadminesEaI",
		};
	};

		--------------------
		--- The Stockade ---
		--------------------

	AtlasLoot_Data["Stockade"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Randolph Moloch", 466), ""};
				{ 2, 63345, "", "=q3=Noble's Robe", "=ds=#s5#, #a1#", ""};
				{ 3, 63344, "", "=q3=Standard Issue Prisoner Shoes", "=ds=#s12#, #a2#", ""};
				{ 4, 63346, "", "=q3=Wicked Dagger", "=ds=#h1#, #w4#", ""};
				{ 6, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Hogger", 464), ""};
				{ 7, 2168, "", "=q3=Corpse Rompers", "=ds=#s12#, #a1#", ""};
				{ 8, 1934, "", "=q3=Hogger's Trousers", "=ds=#s11#, #a2#", ""};
				{ 9, 1959, "", "=q3=Cold Iron Pick", "=ds=#h2#, #w1#", ""};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lord Overheat", 465), ""};
				{ 17, 1929, "", "=q3=Silk-Threaded Trousers", "=ds=#s11#, #a1#", ""};
				{ 18, 5967, "", "=q3=Girdle of Nobility", "=ds=#s10#, #a1#", ""};
				{ 19, 4676, "", "=q3=Skeletal Gauntlets", "=ds=#s9#, #a3#", ""};
				{ 20, 62305, "", "=q1=Lord Overheat's Fiery Core", "=ds=#m3#", "", "100%"};
			};
		};
		info = {
			name = ALIL["The Stockade"],
			module = moduleName, instance = "TheStockade",
		};
	};

		-------------------------
		--- The Sunken Temple ---
		-------------------------

	AtlasLoot_Data["STAvatarofHakkar"] = {
		["Normal"] = {
			{
				{ 1, 12462, "", "=q4=Embrace of the Wind Serpent", "=ds=#s5#, #a1#", "", "0.15%"};
				{ 3, 10843, "", "=q3=Featherskin Cape", "=ds=#s4#", "", "31.12%"};
				{ 4, 10842, "", "=q3=Windscale Sarong", "=ds=#s11#, #a2#", "", "33.22%"};
				{ 5, 10846, "", "=q3=Bloodshot Greaves", "=ds=#s12#, #a3#", "", "32.44%"};
				{ 6, 10845, "", "=q3=Warrior's Embrace", "=ds=#s5#, #a4#", "", "30.44%"};
				{ 7, 10838, "", "=q3=Might of Hakkar", "=ds=#h1#, #w6#", "", "16.37%"};
				{ 8, 10844, "", "=q3=Spire of Hakkar", "=ds=#w9#", "", "16.02%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Avatar of Hakkar", 457),
			module = moduleName, instance = "TheSunkenTemple",
		};
	};

	AtlasLoot_Data["STJammalanandOgom"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Jammal'an the Prophet", 458), ""};
				{ 2, 10806, "", "=q3=Vestments of the Atal'ai Prophet", "=ds=#s5#, #a1#", "", "24.13%"};
				{ 3, 10808, "", "=q3=Gloves of the Atal'ai Prophet", "=ds=#s9#, #a1#", "", "26.74%"};
				{ 4, 10807, "", "=q3=Kilt of the Atal'ai Prophet", "=ds=#s11#, #a1#", "", "23.00%"};
				{ 6, 6212, "", "=q1=Head of Jammal'an", "=ds=#m3#"};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Ogom the Wretched"], ""};
				{ 17, 10805, "", "=q3=Eater of the Dead", "=ds=#h1#, #w1#", "", "28.27%"};
				{ 18, 10804, "", "=q3=Fist of the Damned", "=ds=#h1#, #w6#", "", "30.03%"};
				{ 19, 10803, "", "=q3=Blade of the Wretched", "=ds=#h1#, #w10#", "", "28.21%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Jammal'an the Prophet", 458).." & "..BabbleBoss["Ogom the Wretched"],
			module = moduleName, instance = "TheSunkenTemple",
		};
	};

	AtlasLoot_Data["STDragons"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Shared"], ""};
				{ 2, 12465, "", "=q3=Nightfall Drape", "=ds=#s4#", "", "4.48%"};
				{ 3, 12466, "", "=q3=Dawnspire Cord", "=ds=#s10#, #a1#", "", "4.46%"};
				{ 4, 12464, "", "=q3=Bloodfire Talons", "=ds=#s9#, #a2#", "", "5.00%"};
				{ 5, 10795, "", "=q3=Drakeclaw Band", "=ds=#s13#", "", "4.18%"};
				{ 6, 10796, "", "=q3=Drakestone", "=ds=#s15#", "", "4.92%"};
				{ 7, 10797, "", "=q3=Firebreather", "=ds=#h1#, #w10#", "", "4.50%"};
				{ 8, 12463, "", "=q3=Drakefang Butcher", "=ds=#h2#, #w10#", "", "4.58%"};
				{ 9, 12243, "", "=q3=Smoldering Claw", "=ds=#w7#", "", "4.56%"};
			};
		};
		info = {
			name = BabbleBoss["Dreamscythe"]..", "..BabbleBoss["Weaver"]..", "..BabbleBoss["Hazzas"].." & "..BabbleBoss["Morphaz"],
			module = moduleName, instance = "TheSunkenTemple",
		};
	};

	AtlasLoot_Data["STEranikus"] = {
		["Normal"] = {
			{
				{ 1, 10847, "", "=q4=Dragon's Call", "=ds=#h1#, #w10#", "", "0.18%"};
				{ 3, 10833, "", "=q3=Horns of Eranikus", "=ds=#s1#, #a3#", "", "25.66%"};
				{ 4, 10829, "", "=q3=The Dragon's Eye", "=ds=#s2#", "", "27.02%"};
				{ 5, 10828, "", "=q3=Dire Nail", "=ds=#h1#, #w4#", "", "10.91%"};
				{ 6, 10837, "", "=q3=Tooth of Eranikus", "=ds=#h1#, #w1#", "", "10.05%"};
				{ 7, 10835, "", "=q3=Crest of Supremacy", "=ds=#w8#", "", "19.17%"};
				{ 8, 10836, "", "=q3=Rod of Corrosion", "=ds=#w12#", "", "21.54%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Shade of Eranikus", 463),
			module = moduleName, instance = "TheSunkenTemple",
		};
	};

	AtlasLoot_Data["STTrash"] = {
		["Normal"] = {
			{
				{ 1, 10630, "", "=q3=Soulcatcher Halo", "=ds=#s1#, #a1#", "", "0.01%"};
				{ 2, 10629, "", "=q3=Mistwalker Boots", "=ds=#s12#, #a1#", "", "0.01%"};
				{ 3, 10632, "", "=q3=Slimescale Bracers", "=ds=#s8#, #a3#", "", "0.01%"};
				{ 4, 10631, "", "=q3=Murkwater Gauntlets", "=ds=#s9#, #a3#", "", "0.01%"};
				{ 5, 10633, "", "=q3=Silvershell Leggings", "=ds=#s11#, #a4#", "", "0.01%"};
				{ 6, 10634, "", "=q3=Mindseye Circle", "=ds=#s13#", "", "0.02%"};
				{ 8, 15733, "", "=q3=Pattern: Green Dragonscale Leggings", "=ds=#p7# (270) =q1="..AL["Murk Worm"], "", "1.80%"};
				{ 16, 10623, "", "=q3=Winter's Bite", "=ds=#h1#, #w1#", "", "0.01%"};
				{ 17, 10625, "", "=q3=Stealthblade", "=ds=#h1#, #w4#", "", "0.01%"};
				{ 18, 10628, "", "=q3=Deathblow", "=ds=#h2#, #w10#", "", "0.01%"};
				{ 19, 10626, "", "=q3=Ragehammer", "=ds=#h2#, #w6#", "", "0.01%"};
				{ 20, 10627, "", "=q3=Bludgeon of the Grinning Dog", "=ds=#w9#", "", "0.02%"};
				{ 21, 10624, "", "=q3=Stinging Bow", "=ds=#w2#", "", "0.02%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "TheSunkenTemple",
		};
	};

		---------------
		--- Uldaman ---
		---------------

	AtlasLoot_Data["UldDwarves"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleBoss["Baelog"], ""};
				{ 2, 9401, "", "=q3=Nordic Longshank", "=ds=#h1#, #w10#", "", "8.89%"};
				{ 3, 9400, "", "=q3=Baelog's Shortbow", "=ds=#w2#", "", "46.52%"};
				{ 5, 0, "INV_Box_01", "=q6="..BabbleBoss["Eric \"The Swift\""], ""};
				{ 6, 9394, "", "=q3=Horned Viking Helmet", "=ds=#s1#, #a3#", "", "4.05%"};
				{ 7, 9398, "", "=q3=Worn Running Boots", "=ds=#s12#, #a2#", "", "45.09%"};
				{ 8, 2459, "", "=q1=Swiftness Potion", "=ds=#e2#"};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleBoss["Olaf"], ""};
				{ 17, 9404, "", "=q3=Olaf's All Purpose Shield", "=ds=#w8#", "", "11.33%"};
				{ 18, 9403, "", "=q3=Battered Viking Shield", "=ds=#w8#", "", "69.85%"};
				{ 19, 1177, "", "=q1=Oil of Olaf", "=ds=#e2#", "", "76.54%"};
			}
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("The Lost Dwarves", 468),
			module = moduleName, instance = "Uldaman",
		};
	};

	AtlasLoot_Data["UldamanLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Revelosh", 467), ""};
				{ 2, 9390, "", "=q3=Revelosh's Gloves", "=ds=#s9#, #a1#", "", "20.08%"};
				{ 3, 9389, "", "=q3=Revelosh's Spaulders", "=ds=#s3#, #a2#", "", "18.77%"};
				{ 4, 9388, "", "=q3=Revelosh's Armguards", "=ds=#s8#, #a3#", "", "19.84%"};
				{ 5, 9387, "", "=q3=Revelosh's Boots", "=ds=#s12#, #a3#", "", "20.53%"};
				{ 7, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Ironaya", 469), ""};
				{ 8, 9407, "", "=q3=Stoneweaver Leggings", "=ds=#s11#, #a1#", "", "31.02%"};
				{ 9, 9409, "", "=q3=Ironaya's Bracers", "=ds=#s8#, #a3#", "", "32.71%"};
				{ 10, 9408, "", "=q3=Ironshod Bludgeon", "=ds=#w9#", "", "17.37%"};
				{ 12, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Ancient Stone Keeper", 470), ""};
				{ 13, 9411, "", "=q3=Rockshard Pauldrons", "=ds=#s3#, #a2#", "", "43.41%"};
				{ 14, 9410, "", "=q3=Cragfists", "=ds=#s9#, #a3#", "", "41.61%"};
				{ 15, 62055, "", "=q1=Titan Power Core", "=ds=#m3#", "", "100%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Galgann Firehammer", 471), ""};
				{ 17, 11311, "", "=q3=Emberscale Cape", "=ds=#s4#", "", "36.52%"};
				{ 18, 11310, "", "=q3=Flameseer Mantle", "=ds=#s3#, #a1#", "", "17.35%"};
				{ 19, 9419, "", "=q3=Galgann's Firehammer", "=ds=#h1#, #w6#", "", "18.10%"};
				{ 20, 9412, "", "=q3=Galgann's Fireblaster", "=ds=#w5#", "", "17.10%"};
				{ 22, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Grimlok", 472), ""};
				{ 23, 9415, "", "=q3=Grimlok's Tribal Vestments", "=ds=#s5#, #a1#", "", "36.51%"};
				{ 24, 9414, "", "=q3=Oilskin Leggings", "=ds=#s11#, #a2#", "", "29.78%"};
				{ 25, 9416, "", "=q3=Grimlok's Charge", "=ds=#w7#", "", "15.05%"};
				{ 27, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Archaedas", 473), ""};
				{ 28, 11118, "", "=q3=Archaedic Stone", "=ds=#s13#", "", "51.99%"};
				{ 29, 9418, "", "=q3=Stoneslayer", "=ds=#h2#, #w10#", "", "10.48%"};
				{ 30, 9413, "", "=q3=The Rockpounder", "=ds=#h2#, #w6#", "", "10.94%"};
			}
		};
		info = {
			name = ALIL["Uldaman"],
			module = moduleName, instance = "Uldaman",
		};
	};

	AtlasLoot_Data["UldTrash"] = {
		["Normal"] = {
			{
				{ 1, 9397, "", "=q3=Energy Cloak", "=ds=#s4#", "", "0.01%"};
				{ 2, 9431, "", "=q3=Papal Fez", "=ds=#s1#, #a1#", "", "0.01%"};
				{ 3, 9429, "", "=q3=Miner's Hat of the Deep", "=ds=#s1#, #a1#", "", "0.01%"};
				{ 4, 9420, "", "=q3=Adventurer's Pith Helmet", "=ds=#s1#, #a2#", "", "0.01%"};
				{ 5, 9430, "", "=q3=Spaulders of a Lost Age", "=ds=#s3#, #a2#", "", "0.00%"};
				{ 6, 9406, "", "=q3=Spirewind Fetter", "=ds=#s5#, #a2#", "", "0.01%"};
				{ 7, 9428, "", "=q3=Unearthed Bands", "=ds=#s8#, #a2#", "", "0.01%"};
				{ 8, 9396, "", "=q3=Legguards of the Vault", "=ds=#s11#, #a3#"};
				{ 9, 9432, "", "=q3=Skullplate Bracers", "=ds=#s8#, #a3#", "", "0.01%"};
				{ 10, 9393, "", "=q3=Beacon of Hope", "=ds=#s15#", "", "0.01%"};
				{ 12, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Obsidian Sentinel", 748), ""};
				{ 13, 62053, "", "=q1=Obsidian Power Core", "=ds=#m3#", "", "100%"};
				{ 16, 9384, "", "=q3=Stonevault Shiv", "=ds=#h1#, #w4#", "", "0.01%"};
				{ 17, 9392, "", "=q3=Annealed Blade", "=ds=#h1#, #w10#", "", "0.01%"};
				{ 18, 9424, "", "=q3=Ginn-Su Sword", "=ds=#h1#, #w10#", "", "0.01%"};
				{ 19, 9465, "", "=q3=Digmaster 5000", "=ds=#h1#, #w1#", "", "0.01%"};
				{ 20, 9383, "", "=q3=Obsidian Cleaver", "=ds=#h2#, #w1#", "", "0.01%"};
				{ 21, 9425, "", "=q3=Pendulum of Doom", "=ds=#h2#, #w1#", "", "0.01%"};
				{ 22, 9386, "", "=q3=Excavator's Brand", "=ds=#h1#, #w6#", "", "0.01%"};
				{ 23, 9427, "", "=q3=Stonevault Bonebreaker", "=ds=#h1#, #w6#", "", "0.01%"};
				{ 24, 9423, "", "=q3=The Jackhammer", "=ds=#h2#, #w6#", "", "0.01%"};
				{ 25, 9391, "", "=q3=The Shoveler", "=ds=#h2#, #w6#, =q2=#c9#", "", "0.01%"};
				{ 26, 9381, "", "=q3=Earthen Rod", "=ds=#w12#", "", "0.01%"};
				{ 27, 9426, "", "=q3=Monolithic Bow", "=ds=#w2#", "", "0.01%"};
				{ 28, 9422, "", "=q3=Shadowforge Bushmaster", "=ds=#w5#", "", "0.01%"};
			}
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "Uldaman",
		};
	};

		-----------------------
		--- Wailing Caverns ---
		-----------------------

	AtlasLoot_Data["WailingCavernsLoot"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleBoss["Trigore the Lasher"], "#j28#, "..AL["Rare"]};
				{ 2, 5425, "", "=q3=Runescale Girdle", "=ds=#s8#, #a3#", "", "50%"};
				{ 3, 5426, "", "=q3=Serpent's Kiss", "=ds=#h1#, #w1#", "", "35%"};
				{ 5, 0, "INV_Box_01", "=q6="..BabbleBoss["Boahn"], "#j28#, "..AL["Rare"]};
				{ 6, 5423, "", "=q3=Boahn's Fang", "=ds=#h2#, #w1#", "", "28%"};
				{ 7, 5422, "", "=q2=Brambleweed Leggings", "=ds=#s11#, #a2#", "", "64%"};
				{ 9, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lady Anacondra", 474), ""};
				{ 10, 5404, "", "=q3=Serpent's Shoulders", "=ds=#s3#, #a2#", "", "58.61%"};
				{ 11, 10412, "", "=q3=Belt of the Fang", "=ds=#s10#, #a2#", "", "8.63%"};
				{ 12, 6446, "", "=q3=Snakeskin Bag", "=ds=#e1#", "", "6.61%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lord Pythas", 476), ""};
				{ 17, 6473, "", "=q3=Armor of the Fang", "=ds=#s5#, #a2#", "", "52.06%"};
				{ 18, 6472, "", "=q3=Stinging Viper", "=ds=#h1#, #w6#", "", "28.24%"};
				{ 20, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lord Cobrahn", 475), ""};
				{ 21, 6465, "", "=q3=Robe of the Moccasin", "=ds=#s5#, #a1#", "", "51.73%"};
				{ 22, 10410, "", "=q3=Leggings of the Fang", "=ds=#s11#, #a2#", "", "16.03%"};
				{ 23, 6460, "", "=q3=Cobrahn's Grasp", "=ds=#s10#, #a3#", "", "16.20%"};
				{ 25, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Skum", 478), ""};
				{ 26, 6449, "", "=q3=Glowing Lizardscale Cloak", "=ds=#s4#", "", "38.24%"};
				{ 27, 6448, "", "=q3=Tail Spike", "=ds=#h1#, #w4#", "", "39.24%"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Lord Serpentis", 479), ""};
				{ 2, 5970, "", "=q3=Serpent Gloves", "=ds=#s9#, #a1#", "", "20.96%"};
				{ 3, 10411, "", "=q3=Footpads of the Fang", "=ds=#s12#, #a2#", "", "19.07%"};
				{ 4, 6459, "", "=q3=Savage Trodders", "=ds=#s12#, #a3#", "", "24.39%"};
				{ 5, 6469, "", "=q3=Venomstrike", "=ds=#w2#", "", "16.63%"};
				{ 7, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Verdan the Everliving", 480), ""};
				{ 8, 6629, "", "=q3=Sporid Cape", "=ds=#s4#", "", "16.65%"};
				{ 9, 6631, "", "=q3=Living Root", "=ds=#w9#", "", "34.47%"};
				{ 10, 6630, "", "=q3=Seedcloud Buckler", "=ds=#w8#", "", "35.38%"};
				{ 12, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Mutanus the Devourer", 481), ""};
				{ 13, 6461, "", "=q3=Slime-Encrusted Pads", "=ds=#s3#, #a1#", "", "22.96%"};
				{ 14, 6627, "", "=q3=Mutant Scale Breastplate", "=ds=#s5#, #a3#", "", "18.33%"};
				{ 15, 6463, "", "=q3=Deep Fathom Ring", "=ds=#s13#", "", "21.99%"};
				{ 16, 0, "INV_Box_01", "=q6="..AtlasLoot:EJ_GetBossName("Kresh", 477), ""};
				{ 17, 13245, "", "=q3=Kresh's Back", "=ds=#w8#", "", "9.17%"};
				{ 18, 6447, "", "=q3=Worn Turtle Shell Shield", "=ds=#w8#", "", "63.66%"};
				{ 20, 0, "INV_Box_01", "=q6="..BabbleBoss["Deviate Faerie Dragon"], AL["Rare"]};
				{ 21, 6632, "", "=q3=Feyscale Cloak", "=ds=#s4#", "", "37.84%"};
				{ 22, 5243, "", "=q3=Firebelcher", "=ds=#w12#", "", "39.65%"};
				{ 24, 0, "INV_Box_01", "=q6="..AL["Trash Mobs"]};
				{ 25, 10413, "", "=q3=Gloves of the Fang", "=ds=#s9#", "=q2="..AL["Druid of the Fang"], "1.20%"};
			};
		};
		info = {
			name = ALIL["Wailing Caverns"],
			module = moduleName, instance = "WailingCaverns",
		};
	};

		------------------
		--- Zul'Farrak ---
		------------------

	AtlasLoot_Data["ZFGahzrilla"] = {
		["Normal"] = {
			{
				{ 1, 9469, "", "=q3=Gahz'rilla Scale Armor", "=ds=#s5#, #a3#", "", "36.76%"};
				{ 2, 9467, "", "=q3=Gahz'rilla Fang", "=ds=#h1#, #w4#", "", "36.83%"};
				{ 4, 8707, "", "=q1=Gahz'rilla's Electrified Scale", "=ds=#m3#"};
			};
		};
		info = {
			name = BabbleBoss["Gahz'rilla"],
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFSezzziz"] = {
		["Normal"] = {
			{
				{ 1, 9470, "", "=q3=Bad Mojo Mask", "=ds=#s1#, #a1#", "", "18.69%"};
				{ 2, 9473, "", "=q3=Jinxed Hoodoo Skin", "=ds=#s5#, #a2#", "", "21.12%"};
				{ 3, 9474, "", "=q3=Jinxed Hoodoo Kilt", "=ds=#s11#, #a2#", "", "20.95%"};
				{ 4, 9475, "", "=q3=Diabolic Skiver", "=ds=#w7#", "", "20.06%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Nekrum Gutchewer and Shadow Priest Sezz'ziz", 487),
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFChiefUkorzSandscalp"] = {
		["Normal"] = {
			{
				{ 1, 9479, "", "=q3=Embrace of the Lycan", "=ds=#s1#, #a2#", "", "8.97%"};
				{ 2, 9476, "", "=q3=Big Bad Pauldrons", "=ds=#s3#, #a4#", "", "28.17%"};
				{ 3, 9478, "", "=q3=Ripsaw", "=ds=#h1#, #w1#", "", "19.78%"};
				{ 4, 9477, "", "=q3=The Chief's Enforcer", "=ds=#w9#", "", "22.33%"};
				{ 6, 11086, "", "=q3=Jang'thraze the Protector", "=ds=#h3#, #w10#", "", "1.72%"};
				{ 7, 9372, "", "=q4=Sul'thraze the Lasher", "=ds=#h2# #w10#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Chief Ukorz Sandscalp", 489),
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFWitchDoctorZumrah"] = {
		["Normal"] = {
			{
				{ 1, 18083, "", "=q3=Jumanza Grips", "=ds=#s9#, #a1#", "", "24.97%"};
				{ 2, 18082, "", "=q3=Zum'rah's Vexing Cane", "=ds=#w9#", "", "11.98%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Witch Doctor Zum'rah", 486),
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFAntusul"] = {
		["Normal"] = {
			{
				{ 1, 9640, "", "=q3=Vice Grips", "=ds=#s9#, #a4#", "", "31.30%"};
				{ 2, 9641, "", "=q3=Lifeblood Amulet", "=ds=#s2#", "", "30.80%"};
				{ 3, 9639, "", "=q3=The Hand of Antu'sul", "=ds=#h1#, #w6#", "", "15.47%"};
				{ 5, 9379, "", "=q3=Sang'thraze the Deflector", "=ds=#h1#, #w10#", "", "2.10%"};
				{ 6, 9372, "", "=q4=Sul'thraze the Lasher", "=ds=#h2#, #w10#"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Antu'sul", 484),
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFHydromancerVelratha"] = {
		["Normal"] = {
			{
				{ 1, 9234, "", "=q1=Tiara of the Deep", "=ds=#m3#", "", "100%"};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Hydromancer Velratha", 482),
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFDustwraith"] = {
		["Normal"] = {
			{
				{ 1, 12471, "", "=q3=Desertwalker Cane", "=ds=#s15#", "", "17.71%"};
			};
		};
		info = {
			name = BabbleBoss["Dustwraith"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFZerillis"] = {
		["Normal"] = {
			{
				{ 1, 12470, "", "=q3=Sandstalker Ankleguards", "=ds=#s12#, #a2#", "", "15.55%"};
			};
		};
		info = {
			name = BabbleBoss["Zerillis"].." ("..AL["Rare"]..")",
			module = moduleName, instance = "ZulFarrak",
		};
	};

	AtlasLoot_Data["ZFTrash"] = {
		["Normal"] = {
			{
				{ 1, 9512, "", "=q3=Blackmetal Cape", "=ds=#s4#", "", "0.02%"};
				{ 2, 9484, "", "=q3=Spellshock Leggings", "=ds=#s11#, #a1#", "", "0.01%"};
				{ 3, 9243, "", "=q3=Shriveled Troll Heart", "=ds=#s2#"};
				{ 4, 862, "", "=q3=Runed Ring", "=ds=#s13#", "", "0.02%"};
				{ 5, 6440, "", "=q3=Brainlash", "=ds=#s13#", "", "0.01%"};
				{ 16, 5616, "", "=q3=Gutwrencher", "=ds=#h1#, #w4#", "", "0.01%"};
				{ 17, 9511, "", "=q3=Bloodletter Scalpel", "=ds=#h1#, #w10#", "", "0.01%"};
				{ 18, 9481, "", "=q3=The Minotaur", "=ds=#h2#, #w1#", "", "0.01%"};
				{ 19, 9480, "", "=q3=Eyegouger", "=ds=#w7#", "", "0.01%"};
				{ 20, 9482, "", "=q3=Witch Doctor's Cane", "=ds=#w9#", "", "0.01%"};
				{ 21, 9483, "", "=q3=Flaming Incinerator", "=ds=#w12#", "", "0.01%"};
				{ 22, 2040, "", "=q3=Troll Protector", "=ds=#w8#", "", "0.02%"};
			};
		};
		info = {
			name = AL["Trash Mobs"],
			module = moduleName, instance = "ZulFarrak",
		};
	};

	--------------------------
	--- Sets & Collections ---
	--------------------------

		------------------------------------
		--- Dungeon 1 and 2 Sets (D1/D2) ---
		------------------------------------

	AtlasLoot_Data["T0Druid"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_maul", "=q6=#t0s1#", "=ec1=#j6#"};
				{ 2, 16720, "", "=q3=Wildheart Cowl", "=ds=#s1#, #a2#"};
				{ 3, 16718, "", "=q3=Wildheart Spaulders", "=ds=#s3#, #a2#"};
				{ 4, 16706, "", "=q3=Wildheart Vest", "=ds=#s5#, #a2#"};
				{ 5, 16714, "", "=q3=Wildheart Bracers", "=ds=#s8#, #a2#"};
				{ 6, 16717, "", "=q3=Wildheart Gloves", "=ds=#s9#, #a2#"};
				{ 7, 16716, "", "=q3=Wildheart Belt", "=ds=#s10#, #a2#"};
				{ 8, 16719, "", "=q3=Wildheart Kilt", "=ds=#s11#, #a2#"};
				{ 9, 16715, "", "=q3=Wildheart Boots", "=ds=#s12#, #a2#"};
				{ 16, 0, "ability_druid_maul", "=q6=#t05s1#", "=ec1=#j7#"};
				{ 17, 22109, "", "=q4=Feralheart Cowl", "=ds=#s1#, #a2#"};
				{ 18, 22112, "", "=q3=Feralheart Spaulders", "=ds=#s3#, #a2#"};
				{ 19, 22113, "", "=q4=Feralheart Vest", "=ds=#s5#, #a2#"};
				{ 20, 22108, "", "=q3=Feralheart Bracers", "=ds=#s8#, #a2#"};
				{ 21, 22110, "", "=q4=Feralheart Gloves", "=ds=#s9#, #a2#"};
				{ 22, 22106, "", "=q3=Feralheart Belt", "=ds=#s10#, #a2#"};
				{ 23, 22111, "", "=q3=Feralheart Kilt", "=ds=#s11#, #a2#"};
				{ 24, 22107, "", "=q4=Feralheart Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t0s2#", "=ec1=#j6#"};
				{ 2, 16677, "", "=q3=Beaststalker's Cap", "=ds=#s1#, #a3#"};
				{ 3, 16679, "", "=q3=Beaststalker's Mantle", "=ds=#s3#, #a3#"};
				{ 4, 16674, "", "=q3=Beaststalker's Tunic", "=ds=#s5#, #a3#"};
				{ 5, 16681, "", "=q3=Beaststalker's Bindings", "=ds=#s8#, #a3#"};
				{ 6, 16676, "", "=q3=Beaststalker's Gloves", "=ds=#s9#, #a3#"};
				{ 7, 16680, "", "=q3=Beaststalker's Belt", "=ds=#s10#, #a3#"};
				{ 8, 16678, "", "=q3=Beaststalker's Pants", "=ds=#s11#, #a3#"};
				{ 9, 16675, "", "=q3=Beaststalker's Boots", "=ds=#s12#, #a3#"};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t05s2#", "=ec1=#j7#"};
				{ 17, 22013, "", "=q4=Beastmaster's Cap", "=ds=#s1#, #a3#"};
				{ 18, 22016, "", "=q3=Beastmaster's Mantle", "=ds=#s3#, #a3#"};
				{ 19, 22060, "", "=q4=Beastmaster's Tunic", "=ds=#s5#, #a3#"};
				{ 20, 22011, "", "=q3=Beastmaster's Bindings", "=ds=#s8#, #a3#"};
				{ 21, 22015, "", "=q4=Beastmaster's Gloves", "=ds=#s9#, #a3#"};
				{ 22, 22010, "", "=q3=Beastmaster's Belt", "=ds=#s10#, #a3#"};
				{ 23, 22017, "", "=q3=Beastmaster's Pants", "=ds=#s11#, #a3#"};
				{ 24, 22061, "", "=q4=Beastmaster's Boots", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t0s3#", "=ec1=#j6#"};
				{ 2, 16686, "", "=q3=Magister's Crown", "=ds=#s1#, #a1#"};
				{ 3, 16689, "", "=q3=Magister's Mantle", "=ds=#s3#, #a1#"};
				{ 4, 16688, "", "=q3=Magister's Robes", "=ds=#s5#, #a1#"};
				{ 5, 16683, "", "=q3=Magister's Bindings", "=ds=#s8#, #a1#"};
				{ 6, 16684, "", "=q3=Magister's Gloves", "=ds=#s9#, #a1#"};
				{ 7, 16685, "", "=q3=Magister's Belt", "=ds=#s10#, #a1#"};
				{ 8, 16687, "", "=q3=Magister's Leggings", "=ds=#s11#, #a1#"};
				{ 9, 16682, "", "=q3=Magister's Boots", "=ds=#s12#, #a1#"};
				{ 16, 0, "inv_staff_13", "=q6=#t05s3#", "=ec1=#j7#"};
				{ 17, 22065, "", "=q4=Sorcerer's Crown", "=ds=#s1#, #a1#"};
				{ 18, 22068, "", "=q3=Sorcerer's Mantle", "=ds=#s3#, #a1#"};
				{ 19, 22069, "", "=q4=Sorcerer's Robes", "=ds=#s5#, #a1#"};
				{ 20, 22063, "", "=q3=Sorcerer's Bindings", "=ds=#s8#, #a1#"};
				{ 21, 22066, "", "=q4=Sorcerer's Gloves", "=ds=#s9#, #a1#"};
				{ 22, 22062, "", "=q3=Sorcerer's Belt", "=ds=#s10#, #a1#"};
				{ 23, 22067, "", "=q3=Sorcerer's Leggings", "=ds=#s11#, #a1#"};
				{ 24, 22064, "", "=q4=Sorcerer's Boots", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Paladin"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_thunderbolt", "=q6=#t0s4#", "=ec1=#j6#"};
				{ 2, 16727, "", "=q3=Lightforge Helm", "=ds=#s1#, #a4#"};
				{ 3, 16729, "", "=q3=Lightforge Spaulders", "=ds=#s3#, #a4#"};
				{ 4, 16726, "", "=q3=Lightforge Breastplate", "=ds=#s5#, #a4#"};
				{ 5, 16722, "", "=q3=Lightforge Bracers", "=ds=#s8#, #a4#"};
				{ 6, 16724, "", "=q3=Lightforge Gauntlets", "=ds=#s9#, #a4#"};
				{ 7, 16723, "", "=q3=Lightforge Belt", "=ds=#s10#, #a4#"};
				{ 8, 16728, "", "=q3=Lightforge Legplates", "=ds=#s11#, #a4#"};
				{ 9, 16725, "", "=q3=Lightforge Boots", "=ds=#s12#, #a4#"};
				{ 16, 0, "ability_thunderbolt", "=q6=#t05s4#", "=ec1=#j7#"};
				{ 17, 22091, "", "=q4=Soulforge Helm", "=ds=#s1#, #a4#"};
				{ 18, 22093, "", "=q3=Soulforge Spaulders", "=ds=#s3#, #a4#"};
				{ 19, 22089, "", "=q4=Soulforge Breastplate", "=ds=#s5#, #a4#"};
				{ 20, 22088, "", "=q3=Soulforge Bracers", "=ds=#s8#, #a4#"};
				{ 21, 22090, "", "=q4=Soulforge Gauntlets", "=ds=#s9#, #a4#"};
				{ 22, 22086, "", "=q3=Soulforge Belt", "=ds=#s10#, #a4#"};
				{ 23, 22092, "", "=q3=Soulforge Legplates", "=ds=#s11#, #a4#"};
				{ 24, 22087, "", "=q4=Soulforge Boots", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Priest"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_30", "=q6=#t0s5#", "=ec1=#j6#"};
				{ 2, 16693, "", "=q3=Devout Crown", "=ds=#s1#, #a1#"};
				{ 3, 16695, "", "=q3=Devout Mantle", "=ds=#s3#, #a1#"};
				{ 4, 16690, "", "=q3=Devout Robe", "=ds=#s5#, #a1#"};
				{ 5, 16697, "", "=q3=Devout Bracers", "=ds=#s8#, #a1#"};
				{ 6, 16692, "", "=q3=Devout Gloves", "=ds=#s9#, #a1#"};
				{ 7, 16696, "", "=q3=Devout Belt", "=ds=#s10#, #a1#"};
				{ 8, 16694, "", "=q3=Devout Skirt", "=ds=#s11#, #a1#"};
				{ 9, 16691, "", "=q3=Devout Sandals", "=ds=#s12#, #a1#"};
				{ 16, 0, "inv_staff_30", "=q6=#t05s5#", "=ec1=#j7#"};
				{ 17, 22080, "", "=q4=Virtuous Crown", "=ds=#s1#, #a1#"};
				{ 18, 22082, "", "=q3=Virtuous Mantle", "=ds=#s3#, #a1#"};
				{ 19, 22083, "", "=q4=Virtuous Robe", "=ds=#s5#, #a1#"};
				{ 20, 22079, "", "=q3=Virtuous Bracers", "=ds=#s8#, #a1#"};
				{ 21, 22081, "", "=q4=Virtuous Gloves", "=ds=#s9#, #a1#"};
				{ 22, 22078, "", "=q3=Virtuous Belt", "=ds=#s10#, #a1#"};
				{ 23, 22085, "", "=q3=Virtuous Skirt", "=ds=#s11#, #a1#"};
				{ 24, 22084, "", "=q4=Virtuous Sandals", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t0s6#", "=ec1=#j6#"};
				{ 2, 16707, "", "=q3=Shadowcraft Cap", "=ds=#s1#, #a2#"};
				{ 3, 16708, "", "=q3=Shadowcraft Spaulders", "=ds=#s3#, #a2#"};
				{ 4, 16721, "", "=q3=Shadowcraft Tunic", "=ds=#s5#, #a2#"};
				{ 5, 16710, "", "=q3=Shadowcraft Bracers", "=ds=#s8#, #a2#"};
				{ 6, 16712, "", "=q3=Shadowcraft Gloves", "=ds=#s9#, #a2#"};
				{ 7, 16713, "", "=q3=Shadowcraft Belt", "=ds=#s10#, #a2#"};
				{ 8, 16709, "", "=q3=Shadowcraft Pants", "=ds=#s11#, #a2#"};
				{ 9, 16711, "", "=q3=Shadowcraft Boots", "=ds=#s12#, #a2#"};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t05s6#", "=ec1=#j7#"};
				{ 17, 22005, "", "=q4=Darkmantle Cap", "=ds=#s1#, #a2#"};
				{ 18, 22008, "", "=q3=Darkmantle Spaulders", "=ds=#s3#, #a2#"};
				{ 19, 22009, "", "=q4=Darkmantle Tunic", "=ds=#s5#, #a2#"};
				{ 20, 22004, "", "=q3=Darkmantle Bracers", "=ds=#s8#, #a2#"};
				{ 21, 22006, "", "=q4=Darkmantle Gloves", "=ds=#s9#, #a2#"};
				{ 22, 22002, "", "=q3=Darkmantle Belt", "=ds=#s10#, #a2#"};
				{ 23, 22007, "", "=q3=Darkmantle Pants", "=ds=#s11#, #a2#"};
				{ 24, 22003, "", "=q4=Darkmantle Boots", "=ds=#s12#, #a2#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Shaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_bloodlust", "=q6=#t0s7#", "=ec1=#j6#"};
				{ 2, 16667, "", "=q3=Coif of Elements", "=ds=#s1#, #a3#"};
				{ 3, 16669, "", "=q3=Pauldrons of Elements", "=ds=#s3#, #a3#"};
				{ 4, 16666, "", "=q3=Vest of Elements", "=ds=#s5#, #a3#"};
				{ 5, 16671, "", "=q3=Bindings of Elements", "=ds=#s8#, #a3#"};
				{ 6, 16672, "", "=q3=Gauntlets of Elements", "=ds=#s9#, #a3#"};
				{ 7, 16673, "", "=q3=Cord of Elements", "=ds=#s10#, #a3#"};
				{ 8, 16668, "", "=q3=Kilt of Elements", "=ds=#s11#, #a3#"};
				{ 9, 16670, "", "=q3=Boots of Elements", "=ds=#s12#, #a3#"};
				{ 16, 0, "spell_nature_bloodlust", "=q6=#t05s7#", "=ec1=#j7#"};
				{ 17, 22097, "", "=q4=Coif of The Five Thunders", "=ds=#s1#, #a3#"};
				{ 18, 22101, "", "=q3=Pauldrons of The Five Thunders", "=ds=#s3#, #a3#"};
				{ 19, 22102, "", "=q4=Vest of The Five Thunders", "=ds=#s5#, #a3#"};
				{ 20, 22095, "", "=q3=Bindings of The Five Thunders", "=ds=#s8#, #a3#"};
				{ 21, 22099, "", "=q4=Gauntlets of The Five Thunders", "=ds=#s9#, #a3#"};
				{ 22, 22098, "", "=q3=Cord of The Five Thunders", "=ds=#s10#, #a3#"};
				{ 23, 22100, "", "=q3=Kilt of The Five Thunders", "=ds=#s11#, #a3#"};
				{ 24, 22096, "", "=q4=Boots of The Five Thunders", "=ds=#s12#, #a3#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t0s8#", "=ec1=#j6#"};
				{ 2, 16698, "", "=q3=Dreadmist Mask", "=ds=#s1#, #a1#"};
				{ 3, 16701, "", "=q3=Dreadmist Mantle", "=ds=#s3#, #a1#"};
				{ 4, 16700, "", "=q3=Dreadmist Robe", "=ds=#s5#, #a1#"};
				{ 5, 16703, "", "=q3=Dreadmist Bracers", "=ds=#s8#, #a1#"};
				{ 6, 16705, "", "=q3=Dreadmist Wraps", "=ds=#s9#, #a1#"};
				{ 7, 16702, "", "=q3=Dreadmist Belt", "=ds=#s10#, #a1#"};
				{ 8, 16699, "", "=q3=Dreadmist Leggings", "=ds=#s11#, #a1#"};
				{ 9, 16704, "", "=q3=Dreadmist Sandals", "=ds=#s12#, #a1#"};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t05s8#", "=ec1=#j7#"};
				{ 17, 22074, "", "=q4=Deathmist Mask", "=ds=#s1#, #a1#"};
				{ 18, 22073, "", "=q3=Deathmist Mantle", "=ds=#s3#, #a1#"};
				{ 19, 22075, "", "=q4=Deathmist Robe", "=ds=#s5#, #a1#"};
				{ 20, 22071, "", "=q3=Deathmist Bracers", "=ds=#s8#, #a1#"};
				{ 21, 22077, "", "=q4=Deathmist Wraps", "=ds=#s9#, #a1#"};
				{ 22, 22070, "", "=q3=Deathmist Belt", "=ds=#s10#, #a1#"};
				{ 23, 22072, "", "=q3=Deathmist Leggings", "=ds=#s11#, #a1#"};
				{ 24, 22076, "", "=q4=Deathmist Sandals", "=ds=#s12#, #a1#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T0SET",
		};
	}

	AtlasLoot_Data["T0Warrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_sword_27", "=q6=#t0s9#", "=ec1=#j6#"};
				{ 2, 16731, "", "=q3=Helm of Valor", "=ds=#s1#, #a4#"};
				{ 3, 16733, "", "=q3=Spaulders of Valor", "=ds=#s3#, #a4#"};
				{ 4, 16730, "", "=q3=Breastplate of Valor", "=ds=#s5#, #a4#"};
				{ 5, 16735, "", "=q3=Bracers of Valor", "=ds=#s8#, #a4#"};
				{ 6, 16737, "", "=q3=Gauntlets of Valor", "=ds=#s9#, #a4#"};
				{ 7, 16736, "", "=q3=Belt of Valor", "=ds=#s10#, #a4#"};
				{ 8, 16732, "", "=q3=Legplates of Valor", "=ds=#s11#, #a4#"};
				{ 9, 16734, "", "=q3=Boots of Valor", "=ds=#s12#, #a4#"};
				{ 16, 0, "inv_sword_27", "=q6=#t05s9#", "=ec1=#j7#"};
				{ 17, 21999, "", "=q4=Helm of Heroism", "=ds=#s1#, #a4#"};
				{ 18, 22001, "", "=q3=Spaulders of Heroism", "=ds=#s3#, #a4#"};
				{ 19, 21997, "", "=q4=Breastplate of Heroism", "=ds=#s5#, #a4#"};
				{ 20, 21996, "", "=q3=Bracers of Heroism", "=ds=#s8#, #a4#"};
				{ 21, 21998, "", "=q4=Gauntlets of Heroism", "=ds=#s9#, #a4#"};
				{ 22, 21994, "", "=q3=Belt of Heroism", "=ds=#s10#, #a4#"};
				{ 23, 22000, "", "=q3=Legplates of Heroism", "=ds=#s11#, #a4#"};
				{ 24, 21995, "", "=q4=Boots of Heroism", "=ds=#s12#, #a4#"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "T0SET",
		};
	}

		-----------------------------
		--- Tier 1/2 Sets (T1/T2) ---
		-----------------------------

	AtlasLoot_Data["T1T2Druid"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_maul", "=q6=#t1s1#", "=ec1=#m30#"};
				{ 2, 16834, "", "=q4=Cenarion Helm", "=ds=#s1#, #a2#", "=ds="..BabbleBoss["Garr"], "", "11.51%"};
				{ 3, 16836, "", "=q4=Cenarion Spaulders", "=ds=#s3#, #a2#", "=ds="..BabbleBoss["Baron Geddon"], "", "19.52%"};
				{ 4, 16833, "", "=q4=Cenarion Vestments", "=ds=#s5#, #a2#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "15.21%"};
				{ 5, 16830, "", "=q4=Cenarion Bracers", "=ds=#s8#, #a2#", "=ds="..AL["Trash Mobs"], "", "0.17%"};
				{ 6, 16831, "", "=q4=Cenarion Gloves", "=ds=#s9#, #a2#", "=ds="..BabbleBoss["Shazzrah"], "", "19.53%"};
				{ 7, 16828, "", "=q4=Cenarion Belt", "=ds=#s10#, #a2#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 8, 16835, "", "=q4=Cenarion Leggings", "=ds=#s11#, #a2#", "=ds="..BabbleBoss["Magmadar"], "", "12.90%"};
				{ 9, 16829, "", "=q4=Cenarion Boots", "=ds=#s12#, #a2#", "=ds="..BabbleBoss["Lucifron"], "", "10.72%"};
				{ 16, 0, "ability_druid_maul", "=q6=#t2s1#", "=ec1=#m31#"};
				{ 17, 16900, "", "=q4=Stormrage Cover", "=ds=#s1#, #a2#", "=ds="..BabbleBoss["Nefarian"], "", "13.08%"};
				{ 18, 16902, "", "=q4=Stormrage Pauldrons", "=ds=#s3#, #a2#", "=ds="..BabbleBoss["Chromaggus"], "", "14.63%"};
				{ 19, 16897, "", "=q4=Stormrage Chestguard", "=ds=#s5#, #a2#", "=ds="..BabbleBoss["Nefarian"], "", "11.89%"};
				{ 20, 16904, "", "=q4=Stormrage Bracers", "=ds=#s8#, #a2#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "17.38%"};
				{ 21, 16899, "", "=q4=Stormrage Handguards", "=ds=#s9#, #a2#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "5.34%"};
				{ 22, 16903, "", "=q4=Stormrage Belt", "=ds=#s10#, #a2#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "16.90%"};
				{ 23, 16901, "", "=q4=Stormrage Legguards", "=ds=#s11#, #a2#", "=ds="..BabbleBoss["Ragnaros"], "", "15.49%"};
				{ 24, 16898, "", "=q4=Stormrage Boots", "=ds=#s12#, #a2#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "13.79%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t1s2#", "=ec1=#m30#"};
				{ 2, 16846, "", "=q4=Giantstalker's Helmet", "=ds=#s1#, #a3#", "=ds="..BabbleBoss["Garr"], "", "11.57%"};
				{ 3, 16848, "", "=q4=Giantstalker's Epaulets", "=ds=#s3#, #a3#", "=ds="..BabbleBoss["Sulfuron Harbinger"], "", "19.64%"};
				{ 4, 16845, "", "=q4=Giantstalker's Breastplate", "=ds=#s5#, #a3#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "15.83%"};
				{ 5, 16850, "", "=q4=Giantstalker's Bracers", "=ds=#s8#, #a3#", "=ds="..AL["Trash Mobs"], "", "0.18%"};
				{ 6, 16852, "", "=q4=Giantstalker's Gloves", "=ds=#s9#, #a3#", "=ds="..BabbleBoss["Shazzrah"], "", "18.58%"};
				{ 7, 16851, "", "=q4=Giantstalker's Belt", "=ds=#s10#, #a3#", "=ds="..AL["Trash Mobs"], "", "0.17%"};
				{ 8, 16847, "", "=q4=Giantstalker's Leggings", "=ds=#s11#, #a3#", "=ds="..BabbleBoss["Magmadar"], "", "13.28%"};
				{ 9, 16849, "", "=q4=Giantstalker's Boots", "=ds=#s12#, #a3#", "=ds="..BabbleBoss["Gehennas"], "", "14.54%"};
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t2s2#", "=ec1=#m31#"};
				{ 17, 16939, "", "=q4=Dragonstalker's Helm", "=ds=#s1#, #a3#", "=ds="..BabbleBoss["Nefarian"], "", "13.91%"};
				{ 18, 16937, "", "=q4=Dragonstalker's Spaulders", "=ds=#s3#, #a3#", "=ds="..BabbleBoss["Chromaggus"], "", "16.20%"};
				{ 19, 16942, "", "=q4=Dragonstalker's Breastplate", "=ds=#s5#, #a3#", "=ds="..BabbleBoss["Nefarian"], "", "13.30%"};
				{ 20, 16935, "", "=q4=Dragonstalker's Bracers", "=ds=#s8#, #a3#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "19.13%"};
				{ 21, 16940, "", "=q4=Dragonstalker's Gauntlets", "=ds=#s9#, #a3#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "6.13%"};
				{ 22, 16936, "", "=q4=Dragonstalker's Belt", "=ds=#s10#, #a3#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "20.17%"};
				{ 23, 16938, "", "=q4=Dragonstalker's Legguards", "=ds=#s11#, #a3#", "=ds="..BabbleBoss["Ragnaros"], "", "16.02%"};
				{ 24, 16941, "", "=q4=Dragonstalker's Greaves", "=ds=#s12#, #a3#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "17.78%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t1s3#", "=ec1=#m30#"};
				{ 2, 16795, "", "=q4=Arcanist Crown", "=ds=#s1#, #a1#", "=ds="..BabbleBoss["Garr"], "", "11.31%"};
				{ 3, 16797, "", "=q4=Arcanist Mantle", "=ds=#s3#, #a1#", "=ds="..BabbleBoss["Baron Geddon"], "", "19.92%"};
				{ 4, 16798, "", "=q4=Arcanist Robes", "=ds=#s5#, #a1#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "16.51%"};
				{ 5, 16799, "", "=q4=Arcanist Bindings", "=ds=#s8#, #a1#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 6, 16801, "", "=q4=Arcanist Gloves", "=ds=#s9#, #a1#", "=ds="..BabbleBoss["Shazzrah"], "", "19.59%"};
				{ 7, 16802, "", "=q4=Arcanist Belt", "=ds=#s10#, #a1#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 8, 16796, "", "=q4=Arcanist Leggings", "=ds=#s11#, #a1#", "=ds="..BabbleBoss["Magmadar"], "", "14.57%"};
				{ 9, 16800, "", "=q4=Arcanist Boots", "=ds=#s12#, #a1#", "=ds="..BabbleBoss["Lucifron"], "", "12.06%"};
				{ 16, 0, "inv_staff_13", "=q6=#t2s3#", "=ec1=#m31#"};
				{ 17, 16914, "", "=q4=Netherwind Crown", "=ds=#s1#, #a1#", "=ds="..BabbleBoss["Nefarian"], "", "14.09%"};
				{ 18, 16917, "", "=q4=Netherwind Mantle", "=ds=#s3#, #a1#", "=ds="..BabbleBoss["Chromaggus"], "", "18.09%"};
				{ 19, 16916, "", "=q4=Netherwind Robes", "=ds=#s5#, #a1#", "=ds="..BabbleBoss["Nefarian"], "", "14.03%"};
				{ 20, 16918, "", "=q4=Netherwind Bindings", "=ds=#s8#, #a1#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "20.41%"};
				{ 21, 16913, "", "=q4=Netherwind Gloves", "=ds=#s9#, #a1#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "7.37%"};
				{ 22, 16818, "", "=q4=Netherwind Belt", "=ds=#s10#, #a1#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "19.94%"};
				{ 23, 16915, "", "=q4=Netherwind Pants", "=ds=#s11#, #a1#", "=ds="..BabbleBoss["Ragnaros"], "", "17.37%"};
				{ 24, 16912, "", "=q4=Netherwind Boots", "=ds=#s12#, #a1#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "17.17%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Paladin"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_thunderbolt", "=q6=#t1s4#", "=ec1=#m30#"};
				{ 2, 16854, "", "=q4=Lawbringer Helm", "=ds=#s1#, #a4#", "=ds="..BabbleBoss["Garr"], "", "7.23%"};
				{ 3, 16856, "", "=q4=Lawbringer Spaulders", "=ds=#s3#, #a4#", "=ds="..BabbleBoss["Baron Geddon"], "", "12.62%"};
				{ 4, 16853, "", "=q4=Lawbringer Chestguard", "=ds=#s5#, #a4#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "9.53%"};
				{ 5, 16857, "", "=q4=Lawbringer Bracers", "=ds=#s8#, #a4#", "=ds="..AL["Trash Mobs"], "", "0.11%"};
				{ 6, 16860, "", "=q4=Lawbringer Gauntlets", "=ds=#s9#, #a4#", "=ds="..BabbleBoss["Gehennas"], "", "11.77%"};
				{ 7, 16858, "", "=q4=Lawbringer Belt", "=ds=#s10#, #a4#", "=ds="..AL["Trash Mobs"], "", "0.10%"};
				{ 8, 16855, "", "=q4=Lawbringer Legplates", "=ds=#s11#, #a4#", "=ds="..BabbleBoss["Magmadar"], "", "8.54%"};
				{ 9, 16859, "", "=q4=Lawbringer Boots", "=ds=#s12#, #a4#", "=ds="..BabbleBoss["Lucifron"], "", "7.20%"};
				{ 16, 0, "ability_thunderbolt", "=q6=#t2s4#", "=ec1=#m31#"};
				{ 17, 16955, "", "=q4=Judgement Crown", "=ds=#s1#, #a4#", "=ds="..BabbleBoss["Nefarian"], "", "8.64%"};
				{ 18, 16953, "", "=q4=Judgement Spaulders", "=ds=#s3#, #a4#", "=ds="..BabbleBoss["Chromaggus"], "", "10.97%"};
				{ 19, 16958, "", "=q4=Judgement Breastplate", "=ds=#s5#, #a4#", "=ds="..BabbleBoss["Nefarian"], "", "9.24%"};
				{ 20, 16951, "", "=q4=Judgement Bindings", "=ds=#s8#, #a4#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "13.61%"};
				{ 21, 16956, "", "=q4=Judgement Gauntlets", "=ds=#s9#, #a4#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "3.58%"};
				{ 22, 16952, "", "=q4=Judgement Belt", "=ds=#s10#, #a4#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "12.23%"};
				{ 23, 16954, "", "=q4=Judgement Legplates", "=ds=#s11#, #a4#", "=ds="..BabbleBoss["Ragnaros"], "", "10.81%"};
				{ 24, 16957, "", "=q4=Judgement Sabatons", "=ds=#s12#, #a4#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "11.28%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Priest"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_30", "=q6=#t1s5#", "=ec1=#m30#"};
				{ 2, 16813, "", "=q4=Circlet of Prophecy", "=ds=#s1#, #a1#", "=ds="..BabbleBoss["Garr"], "", "11.36%"};
				{ 3, 16816, "", "=q4=Mantle of Prophecy", "=ds=#s3#, #a1#", "=ds="..BabbleBoss["Sulfuron Harbinger"], "", "21.06%"};
				{ 4, 16815, "", "=q4=Robes of Prophecy", "=ds=#s5#, #a1#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "15.65%"};
				{ 5, 16819, "", "=q4=Vambraces of Prophecy", "=ds=#s8#, #a1#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 6, 16812, "", "=q4=Gloves of Prophecy", "=ds=#s9#, #a1#", "=ds="..BabbleBoss["Gehennas"], "", "18.65%"};
				{ 7, 16817, "", "=q4=Girdle of Prophecy", "=ds=#s10#, #a1#", "=ds="..AL["Trash Mobs"], "", "0.18%"};
				{ 8, 16814, "", "=q4=Pants of Prophecy", "=ds=#s11#, #a1#", "=ds="..BabbleBoss["Magmadar"], "", "14.33%"};
				{ 9, 16811, "", "=q4=Boots of Prophecy", "=ds=#s12#, #a1#", "=ds="..BabbleBoss["Shazzrah"], "", "14.90%"};
				{ 16, 0, "inv_staff_30", "=q6=#t2s5#", "=ec1=#m31#"};
				{ 17, 16921, "", "=q4=Halo of Transcendence", "=ds=#s1#, #a1#", "=ds="..BabbleBoss["Nefarian"], "", "13.39%"};
				{ 18, 16924, "", "=q4=Pauldrons of Transcendence", "=ds=#s3#, #a1#", "=ds="..BabbleBoss["Chromaggus"], "", "17.83%"};
				{ 19, 16923, "", "=q4=Robes of Transcendence", "=ds=#s5#, #a1#", "=ds="..BabbleBoss["Nefarian"], "", "14.83%"};
				{ 20, 16926, "", "=q4=Bindings of Transcendence", "=ds=#s8#, #a1#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "20.37%"};
				{ 21, 16920, "", "=q4=Handguards of Transcendence", "=ds=#s9#, #a1#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "6.01%"};
				{ 22, 16925, "", "=q4=Belt of Transcendence", "=ds=#s10#, #a1#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "18.76%"};
				{ 23, 16922, "", "=q4=Leggings of Transcendence", "=ds=#s11#, #a1#", "=ds="..BabbleBoss["Ragnaros"], "", "17.30%"};
				{ 24, 16919, "", "=q4=Boots of Transcendence", "=ds= #s12#, #a1#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "14.61%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t1s6#", "=ec1=#m30#"};
				{ 2, 16821, "", "=q4=Nightslayer Cover", "=ds=#s1#, #a2#", "=ds="..BabbleBoss["Garr"], "", "10.38%"};
				{ 3, 16823, "", "=q4=Nightslayer Shoulder Pads", "=ds=#s3#, #a2#", "=ds="..BabbleBoss["Sulfuron Harbinger"], "", "20.66%"};
				{ 4, 16820, "", "=q4=Nightslayer Chestpiece", "=ds=#s5#, #a2#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "16.76%"};
				{ 5, 16825, "", "=q4=Nightslayer Bracelets", "=ds=#s8#, #a2#", "=ds="..AL["Trash Mobs"], "", "0.17%"};
				{ 6, 16826, "", "=q4=Nightslayer Gloves", "=ds=#s9#, #a2#", "=ds="..BabbleBoss["Gehennas"], "", "19.47%"};
				{ 7, 16827, "", "=q4=Nightslayer Belt", "=ds=#s10#, #a2#", "=ds="..AL["Trash Mobs"], "", "0.15%"};
				{ 8, 16822, "", "=q4=Nightslayer Pants", "=ds=#s11#, #a2#", "=ds="..BabbleBoss["Magmadar"], "", "13.83%"};
				{ 9, 16824, "", "=q4=Nightslayer Boots", "=ds=#s12#, #a2#", "=ds="..BabbleBoss["Shazzrah"], "", "15.58%"};
				{ 16, 0, "inv_throwingknife_04", "=q6=#t2s6#", "=ec1=#m31#"};
				{ 17, 16908, "", "=q4=Bloodfang Hood", "=ds=#s1#, #a2#", "=ds="..BabbleBoss["Nefarian"], "", "13.21%"};
				{ 18, 16832, "", "=q4=Bloodfang Spaulders", "=ds=#s3#, #a2#", "=ds="..BabbleBoss["Chromaggus"], "", "17.03%"};
				{ 19, 16905, "", "=q4=Bloodfang Chestpiece", "=ds=#s5#, #a2#", "=ds="..BabbleBoss["Nefarian"], "", "14.21%"};
				{ 20, 16911, "", "=q4=Bloodfang Bracers", "=ds=#s8#, #a2#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "20.69%"};
				{ 21, 16907, "", "=q4=Bloodfang Gloves", "=ds=#s9#, #a2#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "6.84%"};
				{ 22, 16910, "", "=q4=Bloodfang Belt", "=ds=#s10#, #a2#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "19.69%"};
				{ 23, 16909, "", "=q4=Bloodfang Pants", "=ds=#s11#, #a2#", "=ds="..BabbleBoss["Ragnaros"], "", "17.18%"};
				{ 24, 16906, "", "=q4=Bloodfang Boots", "=ds=#s12#, #a2#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "15.66%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Shaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_bloodlust", "=q6=#t1s7#", "=ec1=#m30#"};
				{ 2, 16842, "", "=q4=Earthfury Helmet", "=ds=#s1#, #a3#", "=ds="..BabbleBoss["Garr"], "", "3.91%"};
				{ 3, 16844, "", "=q4=Earthfury Epaulets", "=ds=#s3#, #a3#", "=ds="..BabbleBoss["Baron Geddon"], "", "7.29%"};
				{ 4, 16841, "", "=q4=Earthfury Vestments", "=ds=#s5#, #a3#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "6.08%"};
				{ 5, 16840, "", "=q4=Earthfury Bracers", "=ds=#s8#, #a3#", "=ds="..AL["Trash Mobs"], "", "0.06%"};
				{ 6, 16839, "", "=q4=Earthfury Gauntlets", "=ds=#s9#, #a3#", "=ds="..BabbleBoss["Gehennas"], "", "7.38%"};
				{ 7, 16838, "", "=q4=Earthfury Belt", "=ds=#s10#, #a3#", "=ds="..AL["Trash Mobs"], "", "0.07%"};
				{ 8, 16843, "", "=q4=Earthfury Legguards", "=ds=#s11#, #a3#", "=ds="..BabbleBoss["Magmadar"], "", "4.73%"};
				{ 9, 16837, "", "=q4=Earthfury Boots", "=ds=#s12#, #a3#", "=ds="..BabbleBoss["Lucifron"], "", "4.16%"};
				{ 16, 0, "spell_nature_bloodlust", "=q6=#t2s7#", "=ec1=#m31#"};
				{ 17, 16947, "", "=q4=Helmet of Ten Storms", "=ds=#s1#, #a3#", "=ds="..BabbleBoss["Nefarian"], "", "4.86%"};
				{ 18, 16945, "", "=q4=Epaulets of Ten Storms", "=ds=#s3#, #a3#", "=ds="..BabbleBoss["Chromaggus"], "", "6.73%"};
				{ 19, 16950, "", "=q4=Breastplate of Ten Storms", "=ds=#s5#, #a3#", "=ds="..BabbleBoss["Nefarian"], "", "5.65%"};
				{ 20, 16943, "", "=q4=Bracers of Ten Storms", "=ds=#s8#, #a3#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "7.54%"};
				{ 21, 16948, "", "=q4=Gauntlets of Ten Storms", "=ds=#s9#, #a3#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "2.13%"};
				{ 22, 16944, "", "=q4=Belt of Ten Storms", "=ds=#s10#, #a3#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "6.93%"};
				{ 23, 16946, "", "=q4=Legplates of Ten Storms", "=ds=#s11#, #a3#", "=ds="..BabbleBoss["Ragnaros"], "", "5.97%"};
				{ 24, 16949, "", "=q4=Greaves of Ten Storms", "=ds=#s12#, #a3#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "5.57%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t1s8#", "=ec1=#m30#"};
				{ 2, 16808, "", "=q4=Felheart Horns", "=ds=#s1#, #a1#", "=ds="..BabbleBoss["Garr"], "", "10.62%"};
				{ 3, 16807, "", "=q4=Felheart Shoulder Pads", "=ds=#s3#, #a1#", "=ds="..BabbleBoss["Baron Geddon"], "", "19.78%"};
				{ 4, 16809, "", "=q4=Felheart Robes", "=ds=#s5#, #a1#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "15.66%"};
				{ 5, 16804, "", "=q4=Felheart Bracers", "=ds=#s8#, #a1#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 6, 16805, "", "=q4=Felheart Gloves", "=ds=#s9#, #a1#", "=ds="..BabbleBoss["Lucifron"], "", "14.89%"};
				{ 7, 16806, "", "=q4=Felheart Belt", "=ds=#s10#, #a1#", "=ds="..AL["Trash Mobs"], "", "0.19%"};
				{ 8, 16810, "", "=q4=Felheart Pants", "=ds=#s11#, #a1#", "=ds="..BabbleBoss["Magmadar"], "", "13.75%"};
				{ 9, 16803, "", "=q4=Felheart Slippers", "=ds=#s12#, #a1#", "=ds="..BabbleBoss["Shazzrah"], "", "15.28%"};
				{ 16, 0, "spell_nature_drowsy", "=q6=#t2s8#", "=ec1=#m31#"};
				{ 17, 16929, "", "=q4=Nemesis Skullcap", "=ds=#s1#, #a1#", "=ds="..BabbleBoss["Nefarian"], "", "13.54%"};
				{ 18, 16932, "", "=q4=Nemesis Spaulders", "=ds=#s3#, #a1#", "=ds="..BabbleBoss["Chromaggus"], "", "16.26%"};
				{ 19, 16931, "", "=q4=Nemesis Robes", "=ds=#s5#, #a1#", "=ds="..BabbleBoss["Nefarian"], "", "12.46%"};
				{ 20, 16934, "", "=q4=Nemesis Bracers", "=ds=#s8#, #a1#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "18.11%"};
				{ 21, 16928, "", "=q4=Nemesis Gloves", "=ds=#s9#, #a1#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "5.28%"};
				{ 22, 16933, "", "=q4=Nemesis Belt", "=ds=#s10#, #a1#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "18.42%"};
				{ 23, 16930, "", "=q4=Nemesis Leggings", "=ds=#s11#, #a1#", "=ds="..BabbleBoss["Ragnaros"], "", "16.87%"};
				{ 24, 16927, "", "=q4=Nemesis Boots", "=ds=#s12#, #a1#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "15.32%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T1T2Warrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_sword_27", "=q6=#t1s9#", "=ec1=#m30#"};
				{ 2, 16866, "", "=q4=Helm of Might", "=ds=#s1#, #a4#", "=ds="..BabbleBoss["Garr"], "", "11.39%"};
				{ 3, 16868, "", "=q4=Pauldrons of Might", "=ds=#s3#, #a4#", "=ds="..BabbleBoss["Sulfuron Harbinger"], "", "21.14%"};
				{ 4, 16865, "", "=q4=Breastplate of Might", "=ds=#s5#, #a4#", "=ds="..BabbleBoss["Golemagg the Incinerator"], "", "15.28%"};
				{ 5, 16861, "", "=q4=Bracers of Might", "=ds=#s8#, #a4#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 6, 16863, "", "=q4=Gauntlets of Might", "=ds=#s9#, #a4#", "=ds="..BabbleBoss["Lucifron"], "", "16.40%"};
				{ 7, 16864, "", "=q4=Belt of Might", "=ds=#s10#, #a4#", "=ds="..AL["Trash Mobs"], "", "0.16%"};
				{ 8, 16867, "", "=q4=Legplates of Might", "=ds=#s11#, #a4#", "=ds="..BabbleBoss["Magmadar"], "", "13.97%"};
				{ 9, 16862, "", "=q4=Sabatons of Might", "=ds=#s12#, #a4#", "=ds="..BabbleBoss["Gehennas"], "", "14.48%"};
				{ 16, 0, "inv_sword_27", "=q6=#t2s9#", "=ec1=#m31#"};
				{ 17, 16963, "", "=q4=Helm of Wrath", "=ds=#s1#, #a4#", "=ds="..BabbleBoss["Nefarian"], "", "13.65%"};
				{ 18, 16961, "", "=q4=Pauldrons of Wrath", "=ds=#s3#, #a4#", "=ds="..BabbleBoss["Chromaggus"], "", "16.83%"};
				{ 19, 16966, "", "=q4=Breastplate of Wrath", "=ds=#s5#, #a4#", "=ds="..BabbleBoss["Nefarian"], "", "15.06%"};
				{ 20, 16959, "", "=q4=Bracelets of Wrath", "=ds=#s8#, #a4#", "=ds="..BabbleBoss["Razorgore the Untamed"], "", "20.29%"};
				{ 21, 16964, "", "=q4=Gauntlets of Wrath", "=ds=#s9#, #a4#", "=ds="..BabbleBoss["Firemaw"]..", "..BabbleBoss["Ebonroc"]..", "..BabbleBoss["Flamegor"], "", "5.93%"};
				{ 22, 16960, "", "=q4=Waistband of Wrath", "=ds=#s10#, #a4#", "=ds="..BabbleBoss["Vaelastrasz the Corrupt"], "", "20.03%"};
				{ 23, 16962, "", "=q4=Legplates of Wrath", "=ds=#s11#, #a4#", "=ds="..BabbleBoss["Ragnaros"], "", "17.23%"};
				{ 24, 16965, "", "=q4=Sabatons of Wrath", "=ds=#s12#, #a4#", "=ds="..BabbleBoss["Broodlord Lashlayer"], "", "16.84%"};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

		------------------------
		--- Tier 3 Sets (T3) ---
		------------------------

	AtlasLoot_Data["T3Druid"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_maul", "=q6=#t3s1#", "=ec1=#m35#"};
				{ 2, 22490, "", "=q4=Dreamwalker Headpiece", "=ds=#s1#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22491, "", "=q4=Dreamwalker Spaulders", "=ds=#s3#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22488, "", "=q4=Dreamwalker Tunic", "=ds=#s5#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22495, "", "=q4=Dreamwalker Wristguards", "=ds=#s8#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22493, "", "=q4=Dreamwalker Handguards", "=ds=#s9#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22494, "", "=q4=Dreamwalker Girdle", "=ds=#s10#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22489, "", "=q4=Dreamwalker Legguards", "=ds=#s11#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22492, "", "=q4=Dreamwalker Boots", "=ds=#s12#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23064, "", "=q4=Ring of the Dreamwalker", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t3s2#", "=ec1=#m35#"};
				{ 2, 22438, "", "=q4=Cryptstalker Headpiece", "=ds=#s1#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22439, "", "=q4=Cryptstalker Spaulders", "=ds=#s3#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22436, "", "=q4=Cryptstalker Tunic", "=ds=#s5#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22443, "", "=q4=Cryptstalker Wristguards", "=ds=#s8#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22441, "", "=q4=Cryptstalker Handguards", "=ds=#s9#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22442, "", "=q4=Cryptstalker Girdle", "=ds=#s10#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22437, "", "=q4=Cryptstalker Legguards", "=ds=#s11#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22440, "", "=q4=Cryptstalker Boots", "=ds=#s12#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23067, "", "=q4=Ring of the Cryptstalker", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_13", "=q6=#t3s3#", "=ec1=#m35#"};
				{ 2, 22498, "", "=q4=Frostfire Circlet", "=ds=#s1#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22499, "", "=q4=Frostfire Shoulderpads", "=ds=#s3#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22496, "", "=q4=Frostfire Robe", "=ds=#s5#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22503, "", "=q4=Frostfire Bindings", "=ds=#s8#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22501, "", "=q4=Frostfire Gloves", "=ds=#s9#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22502, "", "=q4=Frostfire Belt", "=ds=#s10#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22497, "", "=q4=Frostfire Leggings", "=ds=#s11#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22500, "", "=q4=Frostfire Sandals", "=ds=#s12#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23062, "", "=q4=Frostfire Ring", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Paladin"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_thunderbolt", "=q6=#t3s4#", "=ec1=#m35#"};
				{ 2, 22428, "", "=q4=Redemption Headpiece", "=ds=#s1#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22429, "", "=q4=Redemption Spaulders", "=ds=#s3#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22425, "", "=q4=Redemption Tunic", "=ds=#s5#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22424, "", "=q4=Redemption Wristguards", "=ds=#s8#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22426, "", "=q4=Redemption Handguards", "=ds=#s9#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22431, "", "=q4=Redemption Girdle", "=ds=#s10#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22427, "", "=q4=Redemption Legguards", "=ds=#s11#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22430, "", "=q4=Redemption Boots", "=ds=#s12#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23066, "", "=q4=Ring of Redemption", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Priest"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_staff_30", "=q6=#t3s5#", "=ec1=#m35#"};
				{ 2, 22514, "", "=q4=Circlet of Faith", "=ds=#s1#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22515, "", "=q4=Shoulderpads of Faith", "=ds=#s3#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22512, "", "=q4=Robe of Faith", "=ds=#s5#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22519, "", "=q4=Bindings of Faith", "=ds=#s8#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22517, "", "=q4=Gloves of Faith", "=ds=#s9#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22518, "", "=q4=Belt of Faith", "=ds=#s10#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22513, "", "=q4=Leggings of Faith", "=ds=#s11#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22516, "", "=q4=Sandals of Faith", "=ds=#s12#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23061, "", "=q4=Ring of Faith", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t3s6#", "=ec1=#m35#"};
				{ 2, 22478, "", "=q4=Bonescythe Helmet", "=ds=#s1#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22479, "", "=q4=Bonescythe Pauldrons", "=ds=#s3#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22476, "", "=q4=Bonescythe Breastplate", "=ds=#s5#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22483, "", "=q4=Bonescythe Bracers", "=ds=#s8#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22481, "", "=q4=Bonescythe Gauntlets", "=ds=#s9#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22482, "", "=q4=Bonescythe Waistguard", "=ds=#s10#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22477, "", "=q4=Bonescythe Legplates", "=ds=#s11#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22480, "", "=q4=Bonescythe Sabatons", "=ds=#s12#, #a2#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23060, "", "=q4=Bonescythe Ring", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Shaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_bloodlust", "=q6=#t3s7#", "=ec1=#m35#"};
				{ 2, 22466, "", "=q4=Earthshatter Headpiece", "=ds=#s1#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22467, "", "=q4=Earthshatter Spaulders", "=ds=#s3#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22464, "", "=q4=Earthshatter Tunic", "=ds=#s5#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22471, "", "=q4=Earthshatter Wristguards", "=ds=#s8#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22469, "", "=q4=Earthshatter Handguards", "=ds=#s9#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22470, "", "=q4=Earthshatter Girdle", "=ds=#s10#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22465, "", "=q4=Earthshatter Legguards", "=ds=#s11#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22468, "", "=q4=Earthshatter Boots", "=ds=#s12#, #a3#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23065, "", "=q4=Ring of the Earthshatterer", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t3s8#", "=ec1=#m35#"};
				{ 2, 22506, "", "=q4=Plagueheart Circlet", "=ds=#s1#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22507, "", "=q4=Plagueheart Shoulderpads", "=ds=#s3#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22504, "", "=q4=Plagueheart Robe", "=ds=#s5#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22511, "", "=q4=Plagueheart Bindings", "=ds=#s8#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22509, "", "=q4=Plagueheart Gloves", "=ds=#s9#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22510, "", "=q4=Plagueheart Belt", "=ds=#s10#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22505, "", "=q4=Plagueheart Leggings", "=ds=#s11#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22508, "", "=q4=Plagueheart Sandals", "=ds=#s12#, #a1#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23063, "", "=q4=Plagueheart Ring", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

	AtlasLoot_Data["T3Warrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_sword_27", "=q6=#t3s9#", "=ec1=#m35#"};
				{ 2, 22418, "", "=q4=Dreadnaught Helmet", "=ds=#s1#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 3, 22419, "", "=q4=Dreadnaught Pauldrons", "=ds=#s3#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 4, 22416, "", "=q4=Dreadnaught Breastplate", "=ds=#s5#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 5, 22423, "", "=q4=Dreadnaught Bracers", "=ds=#s8#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 6, 22421, "", "=q4=Dreadnaught Gauntlets", "=ds=#s9#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 7, 22422, "", "=q4=Dreadnaught Waistguard", "=ds=#s10#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 8, 22417, "", "=q4=Dreadnaught Legplates", "=ds=#s11#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 9, 22420, "", "=q4=Dreadnaught Sabatons", "=ds=#s12#, #a4#", "=ds="..AL["Black Market Auction House"]};
				{ 10, 23059, "", "=q4=Ring of the Dreadnaught", "=ds=#s13#", "=ds="..AL["No Longer Available"]};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "T1T2T3SET",
		};
	}

		------------------------
		--- Vanilla WoW Sets ---
		------------------------

	AtlasLoot_Data["VWOWSets"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#pre60s1#", "=ec1=#a2#. =q1="..ALIL["The Deadmines"]};
				{ 2, 10399, "", "=q3=Blackened Defias Armor", "=ds=#s5#", "=q2="..BabbleBoss["Edwin VanCleef"], "", "14.77%"};
				{ 3, 10401, "", "=q3=Blackened Defias Gloves", "=ds=#s9#", "=q2="..AL["Defias Overseer/Taskmaster"], "", "1.76%"};
				{ 4, 10403, "", "=q3=Blackened Defias Belt", "=ds=#s10#", "=q2="..BabbleBoss["Captain Greenskin"], "", "23.26%"};
				{ 5, 10400, "", "=q3=Blackened Defias Leggings", "=ds=#s11#", "=q2="..AL["Defias Overseer/Taskmaster"], "", "1.64%"};
				{ 6, 10402, "", "=q3=Blackened Defias Boots", "=ds=#s12#", "=q2="..AL["Defias Strip Miner"], "", "1.23%"};
				{ 8, 0, "INV_Box_01", "=q6=#pre60s2#", "=ec1=#a2#. =q1="..ALIL["Wailing Caverns"]};
				{ 9, 6473, "", "=q3=Armor of the Fang", "=ds=#s5#", "=q2="..BabbleBoss["Lord Pythas"], "", "52.05%"};
				{ 10, 10413, "", "=q3=Gloves of the Fang", "=ds=#s9#", "=q2="..AL["Druid of the Fang"], "", "1.20%"};
				{ 11, 10412, "", "=q3=Belt of the Fang", "=ds=#s10#", "=q2="..BabbleBoss["Lady Anacondra"], "", "8.64%"};
				{ 12, 10410, "", "=q3=Leggings of the Fang", "=ds=#s11#", "=q2="..BabbleBoss["Lord Cobrahn"], "", "16.03%"};
				{ 13, 10411, "", "=q3=Footpads of the Fang", "=ds=#s12#", "=q2="..BabbleBoss["Lord Serpentis"], "", "19.08%"};
				{ 16, 0, "INV_Box_01", "=q6=#pre60s3#", "=ec1=#a3#. =q1="..ALIL["Scarlet Monastery"]};
				{ 17, 10328, "", "=q3=Scarlet Chestpiece", "=ds=#s5#", ""};
				{ 18, 10333, "", "=q2=Scarlet Wristguards", "=ds=#s8#", ""};
				{ 19, 10331, "", "=q2=Scarlet Gauntlets", "=ds=#s9#", ""};
				{ 20, 10329, "", "=q2=Scarlet Belt", "=ds=#s10#", ""};
				{ 21, 10330, "", "=q3=Scarlet Leggings", "=ds=#s11#", ""};
				{ 22, 10332, "", "=q3=Scarlet Boots", "=ds=#s12#", ""};
				{ 24, 0, "INV_Box_01", "=q6=#pre60s4#", "=ec1=#a3#. =q1="..ALIL["Blackrock Depths"]};
				{ 25, 11729, "", "=q3=Savage Gladiator Helm", "=ds=#s1#", "=q2="..BabbleBoss["Gorosh the Dervish"].." / "..BabbleBoss["Hedrum the Creeper"], "", "10.08%"};
				{ 26, 11726, "", "=q4=Savage Gladiator Chain", "=ds=#s5#", "=q2="..BabbleBoss["Gorosh the Dervish"], "", "14.52%"};
				{ 27, 11730, "", "=q3=Savage Gladiator Grips", "=ds=#s9#", "=q2="..BabbleBoss["Eviscerator"], "", "14.12%"};
				{ 28, 11728, "", "=q3=Savage Gladiator Leggings", "=ds=#s11#", "=q2="..BabbleBoss["Ok'thor the Breaker"], "", "14.95%"};
				{ 29, 11731, "", "=q3=Savage Gladiator Greaves", "=ds=#s12#", "=q2="..BabbleBoss["Anub'shiah"], "", "15.14%"};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#pre60s5#", "=ec1=#a1#, =q1=#m1# #c5#, #c3#, #c8#"};
				{ 2, 22302, "", "=q3=Ironweave Cowl", "=ds=#s1#", "=q2="..BabbleBoss["Lord Valthalak"].." ("..ALIL["Upper Blackrock Spire"]..")", "", "27.72%"};
				{ 3, 22305, "", "=q3=Ironweave Mantle", "=ds=#s3#", "=q2=#n17# ("..ALIL["Blackrock Depths"]..")", "", "30.39%"};
				{ 4, 22301, "", "=q3=Ironweave Robe", "=ds=#s5#", "=q2=#n18# ("..ALIL["Stratholme"]..")", "", "19.00%"};
				{ 5, 22313, "", "=q3=Ironweave Bracers", "=ds=#s8#", "=q2="..BabbleBoss["Halycon"].." ("..ALIL["Lower Blackrock Spire"]..")", "", "18.16%"};
				{ 6, 22304, "", "=q3=Ironweave Gloves", "=ds=#s9#", "=q2="..BabbleBoss["Isalien"].." ("..ALIL["Dire Maul"].." ("..AL["East"]..")"..")", "", "16.24%"};
				{ 7, 22306, "", "=q3=Ironweave Belt", "=ds=#s10#", "=q2="..BabbleBoss["Mor Grayhoof"].." ("..ALIL["Lower Blackrock Spire"]..")", "", "20.28%"};
				{ 8, 22303, "", "=q3=Ironweave Pants", "=ds=#s11#", "=q2="..BabbleBoss["Kormok"].." ("..ALIL["Scholomance"]..")", "", "23.33%"};
				{ 9, 22311, "", "=q3=Ironweave Boots", "=ds=#s12#", "=q2="..BabbleBoss["The Beast"].." ("..ALIL["Upper Blackrock Spire"]..")", "", "12.31%"};
				{ 16, 0, "INV_Box_01", "=q6=#pre60s10#", "=ec1=#a1#, =q2="..BabbleBoss["Postmaster Malown"]..", =q1="..ALIL["Stratholme"]};
				{ 17, 13390, "", "=q3=The Postmaster's Band", "=ds=#s1#", "", ""};
				{ 18, 13388, "", "=q3=The Postmaster's Tunic", "=ds=#s5#", "", ""};
				{ 19, 13389, "", "=q3=The Postmaster's Trousers", "=ds=#s11#", "", ""};
				{ 20, 13391, "", "=q3=The Postmaster's Treads", "=ds=#s12#", "", ""};
				{ 21, 13392, "", "=q3=The Postmaster's Seal", "=ds=#s13#", "", ""};
			};
			{
				{ 1, 0, "INV_Box_01", "=q6=#pre60s15#", "=q1="..AL["Various Locations"]};
				{ 2, 17082, "", "=q4=Shard of the Flame", "=ds=#s14#", "=q2="..BabbleBoss["Ragnaros"].." ("..ALIL["Molten Core"]..")", "", "4.46%"};
				{ 3, 17064, "", "=q4=Shard of the Scale", "=ds=#s14#"};
				{ 5, 0, "INV_Box_01", "=q6=#pre60s20#", "=q1="..AL["Various Locations"]};
				{ 6, 18203, "", "=q4=Eskhandar's Right Claw", "=ds=#h1#, #w13#", "=q2="..BabbleBoss["Magmadar"].." ("..ALIL["Molten Core"]..")", "", "16.97%"};
				{ 7, 18202, "", "=q4=Eskhandar's Left Claw", "=ds=#h1#, #w13#", "=q2="..BabbleBoss["Magmadar"].." ("..ALIL["Molten Core"]..")", "", "14%"};
				{ 16, 0, "INV_Box_01", "=q6=#pre60s24#", "=q1="..ALIL["Lower Blackrock Spire"]};
				{ 17, 13218, "", "=q3=Fang of the Crystal Spider", "=ds=#h1#, #w4#", "=q2="..BabbleBoss["Crystal Fang"], "", "15.46%"};
				{ 18, 13183, "", "=q3=Venomspitter", "=ds=#h1#, #w6#", "=q2="..BabbleBoss["Mother Smolderweb"], "", "13.07%"};
				{ 20, 0, "INV_Box_01", "=q6=#pre60s23#", "=q1="..ALIL["Upper Blackrock Spire"]};
				{ 21, 12940, "", "=q3=Dal'Rend's Sacred Charge", "=ds=#h3#, #w10#", "=q2="..BabbleBoss["Warchief Rend Blackhand"], "", "6.62%"};
				{ 22, 12939, "", "=q3=Dal'Rend's Tribal Guardian", "=ds=#h4#, #w10#", "=q2="..BabbleBoss["Warchief Rend Blackhand"], "", "7.44%"};
			};
		};
		info = {
			name = AL["Classic WoW"].." "..AL["Sets"],
			module = moduleName, NextPrevDisable = true, menu = "SETSCLASSIC",
		};
	};
	AtlasLoot_Data["VWOWScholo"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6=#pre60s6#", "=ec1=#a1#. =q1="..ALIL["Scholomance"]};
				{ 2, 14633, "", "=q3=Necropile Mantle", "=ds=#s3#", "", "1.12%"};
				{ 3, 14626, "", "=q3=Necropile Robe", "=ds=#s5#", "", "1.27%"};
				{ 4, 14629, "", "=q3=Necropile Cuffs", "=ds=#s8#", "", "1.03%"};
				{ 5, 14632, "", "=q3=Necropile Leggings", "=ds=#s11#", "", "0.85%"};
				{ 6, 14631, "", "=q3=Necropile Boots", "=ds=#s12#", "", "0.88%"};
				{ 8, 0, "INV_Box_01", "=q6=#pre60s7#", "=ec1=#a2#. =q1="..ALIL["Scholomance"]};
				{ 9, 14637, "", "=q3=Cadaverous Armor", "=ds=#s5#", "", "1.51%"};
				{ 10, 14640, "", "=q3=Cadaverous Gloves", "=ds=#s9#", "", "0.82%"};
				{ 11, 14636, "", "=q3=Cadaverous Belt", "=ds=#s10#", "", "0.60%"};
				{ 12, 14638, "", "=q3=Cadaverous Leggings", "=ds=#s11#", "", "1.09%"};
				{ 13, 14641, "", "=q3=Cadaverous Walkers", "=ds=#s12#", "", "0.67%"};
				{ 16, 0, "INV_Box_01", "=q6=#pre60s8#", "=ec1=#a3#. =q1="..ALIL["Scholomance"]};
				{ 17, 14611, "", "=q3=Bloodmail Hauberk", "=ds=#s5#", "", "0.54%"};
				{ 18, 14615, "", "=q3=Bloodmail Gauntlets", "=ds=#s9#", "", "0.09%"};
				{ 19, 14614, "", "=q3=Bloodmail Belt", "=ds=#s10#", "", "0.60%"};
				{ 20, 14612, "", "=q3=Bloodmail Legguards", "=ds=#s11#", "", "0.42%"};
				{ 21, 14616, "", "=q3=Bloodmail Boots", "=ds=#s12#", "", "0.36%"};
				{ 23, 0, "INV_Box_01", "=q6=#pre60s9#", "=ec1=#a4#. =q1="..ALIL["Scholomance"]};
				{ 24, 14624, "", "=q3=Deathbone Chestplate", "=ds=#s5#", "", "0.45%"};
				{ 25, 14622, "", "=q3=Deathbone Gauntlets", "=ds=#s9#", "", "0.45%"};
				{ 26, 14620, "", "=q3=Deathbone Girdle", "=ds=#s10#", "", "0.67%"};
				{ 27, 14623, "", "=q3=Deathbone Legguards", "=ds=#s11#", "", "1.12%"};
				{ 28, 14621, "", "=q3=Deathbone Sabatons", "=ds=#s12#", "", "0.57%"};
			};
		};
		info = {
			name = ALIL["Scholomance"].." "..AL["Sets"],
			module = moduleName, NextPrevDisable = true, menu = "SETSCLASSIC",
		};
	};

		-----------------
		--- AQ20 Sets ---
		-----------------

	AtlasLoot_Data["AQ20Sets"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_maul", "=q6=#aq20s1#", "=ec1=#c1#"};
				{ 2, 21407, "", "=q4=Mace of Unending Life", "=ds=#h2#, #w6#", "=q4=#aq20t1#, =ds=#r5#"};
				{ 3, 21409, "", "=q4=Cloak of Unending Life", "=ds=#s4#", "=q3=#aq20t5#, =ds=#r4#"};
				{ 4, 21408, "", "=q4=Band of Unending Life", "=ds=#s13#", "=q3=#aq20t3#, =ds=#r3#"};
				{ 6, 0, "inv_weapon_bow_07", "=q6=#aq20s2#", "=ec1=#c2#"};
				{ 7, 21401, "", "=q4=Scythe of the Unseen Path", "=ds=#h1#, #w1#", "=q4=#aq20t6#, =ds=#r5#"};
				{ 8, 21403, "", "=q4=Cloak of the Unseen Path", "=ds=#s4#", "=q3=#aq20t5#, =ds=#r4#"};
				{ 9, 21402, "", "=q4=Signet of the Unseen Path", "=ds=#s13#", "=q3=#aq20t4#, =ds=#r3#"};
				{ 11, 0, "inv_staff_13", "=q6=#aq20s3#", "=ec1=#c3#"};
				{ 12, 21413, "", "=q4=Blade of Vaulted Secrets", "=ds=#h1#, #w10#", "=q4=#aq20t1#, =ds=#r5#"};
				{ 13, 21415, "", "=q4=Drape of Vaulted Secrets", "=ds=#s4#", "=q3=#aq20t2#, =ds=#r4#"};
				{ 14, 21414, "", "=q4=Band of Vaulted Secrets", "=ds=#s13#", "=ds=", "=q3=#aq20t3#, =ds=#r3#"};
				{ 16, 0, "ability_thunderbolt", "=q6=#aq20s4#", "=ec1=#c4#"};
				{ 17, 21395, "", "=q4=Blade of Eternal Justice", "=ds=#h1#, #w10#", "=q4=#aq20t6#, =ds=#r5#"};
				{ 18, 21397, "", "=q4=Cape of Eternal Justice", "=ds=#s4#", "=q3=#aq20t5#, =ds=#r4#"};
				{ 19, 21396, "", "=q4=Ring of Eternal Justice", "=ds=#s13#", "=q3=#aq20t3#, =ds=#r3#"};
				{ 21, 0, "inv_staff_30", "=q6=#aq20s5#", "=ec1=#c5#"};
				{ 22, 21410, "", "=q4=Gavel of Infinite Wisdom", "=ds=#h1#, #w6#", "=q4=#aq20t1#, =ds=#r5#"};
				{ 23, 21412, "", "=q4=Shroud of Infinite Wisdom", "=ds=#s4#", "=q3=#aq20t2#, =ds=#r4#"};
				{ 24, 21411, "", "=q4=Ring of Infinite Wisdom", "=ds=#s13#", "=q3=#aq20t4#, =ds=#r3#"};
				{ 26, 0, "inv_throwingknife_04", "=q6=#aq20s6#", "=ec1=#c6#"};
				{ 27, 21404, "", "=q4=Dagger of Veiled Shadows", "=ds=#h1#, #w4#", "=q4=#aq20t6#, =ds=#r5#"};
				{ 28, 21406, "", "=q4=Cloak of Veiled Shadows", "=ds=#s4#", "=q3=#aq20t2#, =ds=#r4#"};
				{ 29, 21405, "", "=q4=Band of Veiled Shadows", "=ds=#s13#", "=q3=#aq20t4#, =ds=#r3#"};
			};
			{
				{ 1, 0, "spell_nature_bloodlust", "=q6=#aq20s7#", "=ec1=#c7#"};
				{ 2, 21398, "", "=q4=Hammer of the Gathering Storm", "=ds=#h1#, #w6#", "=q4=#aq20t6#, =ds=#r5#"};
				{ 3, 21400, "", "=q4=Cloak of the Gathering Storm", "=ds=#s4#", "=q3=#aq20t5#, =ds=#r4#"};
				{ 4, 21399, "", "=q4=Ring of the Gathering Storm", "=ds=#s13#", "=q3=#aq20t3#, =ds=#r3#"};
				{ 6, 0, "spell_nature_drowsy", "=q6=#aq20s8#", "=ec1=#c8#"};
				{ 7, 21416, "", "=q4=Kris of Unspoken Names", "=ds=#h1#, #w4#", "=q4=#aq20t1#, =ds=#r5#"};
				{ 8, 21418, "", "=q4=Shroud of Unspoken Names", "=ds=#s4#", "=q3=#aq20t5#, =ds=#r4#"};
				{ 9, 21417, "", "=q4=Ring of Unspoken Names", "=ds=#s13#", "=q3=#aq20t4#, =ds=#r3#"};
				{ 16, 0, "inv_sword_27", "=q6=#aq20s9#", "=ec1=#c9#"};
				{ 17, 21392, "", "=q4=Sickle of Unyielding Strength", "=ds=#h1#, #w1#", "=q4=#aq20t6#, =ds=#r5#"};
				{ 18, 21394, "", "=q4=Drape of Unyielding Strength", "=ds=#s4#", "=q3=#aq20t2#, =ds=#r4#"};
				{ 19, 21393, "", "=q4=Signet of Unyielding Strength", "=ds=#s13#", "=q3=#aq20t3#=ds=, #r3#"};
			};
		};
		info = {
			name = ALIL["Ruins of Ahn'Qiraj"].." "..AL["Set"],
			module = moduleName, menu = "SETSMISCMENU",
		};
	}

		-----------------
		--- AQ40 Sets ---
		-----------------

	AtlasLoot_Data["AQ40Sets"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_maul", "=q6=#aq40s1#", "=ec1=#c1#"};
				{ 2, 21357, "", "=q4=Genesis Vest", "=q4=#aq40t4#, =ds=#r3#"};
				{ 3, 21353, "", "=q4=Genesis Helm", "=q4=#aq40t6#, =ds=#r2#"};
				{ 4, 21356, "", "=q4=Genesis Trousers", "=q4=#aq40t7#, =ds=#r2#"};
				{ 5, 21354, "", "=q4=Genesis Shoulderpads", "=q4=#aq40t1#, =ds=#r1#"};
				{ 6, 21355, "", "=q4=Genesis Boots", "=q4=#aq40t1#, =ds=#r1#"};
				{ 8, 0, "inv_weapon_bow_07", "=q6=#aq40s2#", "=ec1=#c2#"};
				{ 9, 21370, "", "=q4=Striker's Hauberk", "=q4=#aq40t8#, =ds=#r3#"};
				{ 10, 21366, "", "=q4=Striker's Diadem", "=q4=#aq40t6#, =ds=#r2#"};
				{ 11, 21368, "", "=q4=Striker's Leggings", "=q4=#aq40t7#, =ds=#r2#"};
				{ 12, 21367, "", "=q4=Striker's Pauldrons", "=q4=#aq40t5#, =ds=#r1#"};
				{ 13, 21365, "", "=q4=Striker's Footguards", "=q4=#aq40t5#, =ds=#r1#"};
				{ 16, 0, "inv_staff_13", "=q6=#aq40s3#", "=ec1=#c3#"};
				{ 17, 21343, "", "=q4=Enigma Robes", "=q4=#aq40t4#, =ds=#r3#"};
				{ 18, 21347, "", "=q4=Enigma Circlet", "=q4=#aq40t2#, =ds=#r2#"};
				{ 19, 21346, "", "=q4=Enigma Leggings", "=q4=#aq40t3#, =ds=#r2#"};
				{ 20, 21345, "", "=q4=Enigma Shoulderpads", "=q4=#aq40t1#, =ds=#r1#"};
				{ 21, 21344, "", "=q4=Enigma Boots", "=q4=#aq40t1#, =ds=#r1#"};
				{ 23, 0, "ability_thunderbolt", "=q6=#aq40s4#", "=ec1=#c4#"};
				{ 24, 21389, "", "=q4=Avenger's Breastplate", "=q4=#aq40t8#, =ds=#r3#"};
				{ 25, 21387, "", "=q4=Avenger's Crown", "=q4=#aq40t6#, =ds=#r2#"};
				{ 26, 21390, "", "=q4=Avenger's Legguards", "=q4=#aq40t7#, =ds=#r2#"};
				{ 27, 21391, "", "=q4=Avenger's Pauldrons", "=q4=#aq40t1#, =ds=#r1#"};
				{ 28, 21388, "", "=q4=Avenger's Greaves", "=q4=#aq40t1#, =ds=#r1#"};
			};
			{
				{ 1, 0, "inv_staff_30", "=q6=#aq40s5#", "=ec1=#c5#"};
				{ 2, 21351, "", "=q4=Vestments of the Oracle", "=q4=#aq40t4#, =ds=#r3#"};
				{ 3, 21348, "", "=q4=Tiara of the Oracle", "=q4=#aq40t2#, =ds=#r2#"};
				{ 4, 21352, "", "=q4=Trousers of the Oracle", "=q4=#aq40t3#, =ds=#r2#"};
				{ 5, 21350, "", "=q4=Mantle of the Oracle", "=q4=#aq40t5#, =ds=#r1#"};
				{ 6, 21349, "", "=q4=Footwraps of the Oracle", "=q4=#aq40t5#, =ds=#r1#"};
				{ 8, 0, "inv_throwingknife_04", "=q6=#aq40s6#", "=ec1=#c6#"};
				{ 9, 21364, "", "=q4=Deathdealer's Vest", "=q4=#aq40t8#, =ds=#r3#"};
				{ 10, 21360, "", "=q4=Deathdealer's Helm", "=q4=#aq40t6#, =ds=#r2#"};
				{ 11, 21362, "", "=q4=Deathdealer's Leggings", "=q4=#aq40t3#, =ds=#r2#"};
				{ 12, 21361, "", "=q4=Deathdealer's Spaulders", "=q4=#aq40t5#, =ds=#r1#"};
				{ 13, 21359, "", "=q4=Deathdealer's Boots", "=q4=#aq40t5#, =ds=#r1#"};
				{ 16, 0, "spell_nature_bloodlust", "=q6=#aq40s7#", "=ec1=#c7#"};
				{ 17, 21374, "", "=q4=Stormcaller's Hauberk", "=q4=#aq40t8#, =ds=#r3#"};
				{ 18, 21372, "", "=q4=Stormcaller's Diadem", "=q4=#aq40t6#, =ds=#r2#"};
				{ 19, 21375, "", "=q4=Stormcaller's Leggings", "=q4=#aq40t7#, =ds=#r2#"};
				{ 20, 21376, "", "=q4=Stormcaller's Pauldrons", "=q4=#aq40t1#, =ds=#r1#"};
				{ 21, 21373, "", "=q4=Stormcaller's Footguards", "=q4=#aq40t1#, =ds=#r1#"};
				{ 23, 0, "spell_nature_drowsy", "=q6=#aq40s8#", "=ec1=#c8#"};
				{ 24, 21334, "", "=q4=Doomcaller's Robes", "=q4=#aq40t4#, =ds=#r3#"};
				{ 25, 21337, "", "=q4=Doomcaller's Circlet", "=q4=#aq40t2#, =ds=#r2#"};
				{ 26, 21336, "", "=q4=Doomcaller's Trousers", "=q4=#aq40t7#, =ds=#r2#"};
				{ 27, 21335, "", "=q4=Doomcaller's Mantle", "=q4=#aq40t1#, =ds=#r1#"};
				{ 28, 21338, "", "=q4=Doomcaller's Footwraps", "=q4=#aq40t1#, =ds=#r1#"};
			};
			{
				{ 1, 0, "inv_sword_27", "=q6=#aq40s9#", "=ec1=#c9#"};
				{ 2, 21331, "", "=q4=Conqueror's Breastplate", "=q4=#aq40t8#, =ds=#r3#"};
				{ 3, 21329, "", "=q4=Conqueror's Crown", "=q4=#aq40t2#, =ds=#r2#"};
				{ 4, 21332, "", "=q4=Conqueror's Legguards", "=q4=#aq40t3#, =ds=#r2#"};
				{ 5, 21330, "", "=q4=Conqueror's Spaulders", "=q4=#aq40t5#, =ds=#r1#"};
				{ 6, 21333, "", "=q4=Conqueror's Greaves", "=q4=#aq40t5#, =ds=#r1#"};
			};
		};
		info = {
			name = ALIL["Temple of Ahn'Qiraj"].." "..AL["Set"],
			module = moduleName, menu = "SETSMISCMENU",
		};
	}

		-----------------------
		--- BoE World Epics ---
		-----------------------

	AtlasLoot_Data["WorldEpics3039"] = {
		["Normal"] = {
			{
				{ 1, 867, "", "=q4=Gloves of Holy Might", "=ds=#s9#, #a2#", "", ""};
				{ 2, 1981, "", "=q4=Icemail Jerkin", "=ds=#s5#, #a3#", "", ""};
				{ 3, 1980, "", "=q4=Underworld Band", "=ds=#s13#", "", ""};
				{ 16, 869, "", "=q4=Dazzling Longsword", "=ds=#h1#, #w10#", "", ""};
				{ 17, 1982, "", "=q4=Nightblade", "=ds=#h2#, #w10#", "", ""};
				{ 18, 870, "", "=q4=Fiery War Axe", "=ds=#h2#, #w1#", "", ""};
				{ 19, 868, "", "=q4=Ardent Custodian", "=ds=#h1#, #w6#", "", ""};
				{ 20, 873, "", "=q4=Staff of Jordan", "=ds=#w9#", "", ""};
				{ 21, 1204, "", "=q4=The Green Tower", "=ds=#w8#", "", ""};
				{ 22, 2825, "", "=q4=Bow of Searing Arrows", "=ds=#w2#", "", ""};
			};
		};
		info = {
			name = AL["BoE World Epics"].." "..string.format(AL["Level %s"], "30-39"),
			module = moduleName, menu = "WORLDEPICS", instance = "WorldEpics",
		};
	}

	AtlasLoot_Data["WorldEpics4049"] = {
		["Normal"] = {
			{
				{ 1, 3075, "", "=q4=Eye of Flame", "=ds=#s1#, #a1#", "", ""};
				{ 2, 940, "", "=q4=Robes of Insight", "=ds=#s5#, #a1#", "", ""};
				{ 3, 14551, "", "=q4=Edgemaster's Handguards", "=ds=#s9#, #a3#", "", ""};
				{ 4, 17007, "", "=q4=Stonerender Gauntlets", "=ds=#s9#, #a3#", "", ""};
				{ 5, 14549, "", "=q4=Boots of Avoidance", "=ds=#s12#, #a4#", "", ""};
				{ 6, 1315, "", "=q4=Lei of Lilies", "=ds=#s2#", "", ""};
				{ 7, 942, "", "=q4=Freezing Band", "=ds=#s13#", "", ""};
				{ 8, 1447, "", "=q4=Ring of Saviors", "=ds=#s13#", "", ""};
				{ 16, 2164, "", "=q4=Gut Ripper", "=ds=#h1#, #w4#", "", ""};
				{ 17, 2163, "", "=q4=Shadowblade", "=ds=#h1#, #w4#", "", ""};
				{ 18, 809, "", "=q4=Bloodrazor", "=ds=#h1#, #w10#", "", ""};
				{ 19, 871, "", "=q4=Flurry Axe", "=ds=#h1#, #w1#", "", ""};
				{ 20, 2291, "", "=q4=Kang the Decapitator", "=ds=#h2#, #w1#", "", ""};
				{ 21, 810, "", "=q4=Hammer of the Northern Wind", "=ds=#h1#, #w6#", "", ""};
				{ 22, 2915, "", "=q4=Taran Icebreaker", "=ds=#h2#, #w6#", "", ""};
				{ 23, 812, "", "=q4=Glowing Brightwood Staff", "=ds=#w9#", "", ""};
				{ 24, 943, "", "=q4=Warden Staff", "=ds=#w9#", "", ""};
				{ 25, 1169, "", "=q4=Blackskull Shield", "=ds=#w8#", "", ""};
				{ 26, 1979, "", "=q4=Wall of the Dead", "=ds=#w8#", "", ""};
				{ 27, 2824, "", "=q4=Hurricane", "=ds=#w2#", "", ""};
				{ 28, 2100, "", "=q4=Precisely Calibrated Boomstick", "=ds=#w5#", "", ""};
			};
		};
		info = {
			name = AL["BoE World Epics"].." "..string.format(AL["Level %s"], "40-49"),
			module = moduleName, menu = "WORLDEPICS", instance = "WorldEpics",
		};
	}

	AtlasLoot_Data["WorldEpics5060"] = {
		["Normal"] = {
			{
				{ 1, 3475, "", "=q4=Cloak of Flames", "=ds=#s4#", "", ""};
				{ 2, 14553, "", "=q4=Sash of Mercy", "=ds=#s10#, #a2#", "", ""};
				{ 3, 2245, "", "=q4=Helm of Narv", "=ds=#s1#, #a3#", "", ""};
				{ 4, 14552, "", "=q4=Stockade Pauldrons", "=ds=#s3#, #a4#", "", ""};
				{ 5, 14554, "", "=q4=Cloudkeeper Legplates", "=ds=#s11#, #a4#", "", ""};
				{ 6, 1443, "", "=q4=Jeweled Amulet of Cainwyn", "=ds=#s2#", "", ""};
				{ 7, 14558, "", "=q4=Lady Maye's Pendant", "=ds=#s2#", "", ""};
				{ 8, 2246, "", "=q4=Myrmidon's Signet", "=ds=#s13#", "", ""};
				{ 9, 833, "", "=q4=Lifestone", "=ds=#s14#", "", ""};
				{ 10, 14557, "", "=q4=The Lion Horn of Stormwind", "=ds=#s14#", "", ""};
				{ 16, 14555, "", "=q4=Alcor's Sunrazor", "=ds=#h1#, #w4#", "", ""};
				{ 17, 2244, "", "=q4=Krol Blade", "=ds=#h1#, #w10#", "", ""};
				{ 18, 1728, "", "=q4=Teebu's Blazing Longsword", "=ds=#h1#, #w10#", "", ""};
				{ 19, 2801, "", "=q4=Blade of Hanna", "=ds=#h2#, #w10#", "", ""};
				{ 20, 647, "", "=q4=Destiny", "=ds=#h2#, #w10#", "", ""};
				{ 21, 811, "", "=q4=Axe of the Deep Woods", "=ds=#h1#, #w1#", "", ""};
				{ 22, 1263, "", "=q4=Brain Hacker", "=ds=#h2#, #w1#", "", ""};
				{ 23, 2243, "", "=q4=Hand of Edward the Odd", "=ds=#h1#, #w6#", "", ""};
				{ 24, 944, "", "=q4=Elemental Mage Staff", "=ds=#w9#", "", ""};
				{ 25, 1168, "", "=q4=Skullflame Shield", "=ds=#w8#", "", ""};
				{ 26, 2099, "", "=q4=Dwarven Hand Cannon", "=ds=#w5#", "", ""};
			};
		};
		info = {
			name = AL["BoE World Epics"].." "..string.format(AL["Level %s"], "50-60"),
			module = moduleName, menu = "WORLDEPICS", instance = "WorldEpics",
		};
	}

	-----------
	--- PvP ---
	-----------

		----------------------
		--- Alterac Valley ---
		----------------------

	AtlasLoot_Data["AVMisc"] = {
		["Normal"] = {
			{
				{ 2, 0, "INV_BannerPVP_02", "=q6=#m7#", "=q5="..ALIL["Stormpike Guard"]};
				{ 3, 19030, "", "=q4=Stormpike Battle Charger", "=ds=#e26#", "#HONOR:2000#"};
				{ 4, 19045, "", "=q3=Stormpike Battle Standard", "=ds=#e14#", "#HONOR:500#"};
				{ 5, 19032, "", "=q1=Stormpike Battle Tabard", "=ds=#s7#", "#HONOR:2678#"};
				{ 7, 17348, "", "=q1=Major Healing Draught", "=ds=#e2#", "10 #silver# #HONOR:8#"};
				{ 8, 17349, "", "=q1=Superior Healing Draught", "=ds=#e2#", "5 #silver# #HONOR:1#"};
				{ 9, 19301, "", "=q1=Alterac Manna Biscuit", "=ds=#e3#", "70 #silver#"};
				{ 10, 19307, "", "=q1=Alterac Heavy Runecloth Bandage", "=ds=#e5#", "80 #silver#"};
				{ 17, 0, "INV_BannerPVP_01", "=q6=#m6#", "=q5="..ALIL["Frostwolf Clan"]};
				{ 18, 19029, "", "=q4=Horn of the Frostwolf Howler", "=ds=#e26#", "#HONOR:2000#"};
				{ 19, 19046, "", "=q3=Frostwolf Battle Standard", "=ds=#e14#", "#HONOR:500#"};
				{ 20, 19031, "", "=q1=Frostwolf Battle Tabard", "=ds=#s7#", "#HONOR:2678#"};
				{ 22, 17351, "", "=q1=Major Mana Draught", "=ds=#e2#", "10 #silver# 8 #faction#"};
				{ 23, 17352, "", "=q1=Superior Mana Draught", "=ds=#e2#", "5 #silver# 1 #faction#"};
				{ 24, 19318, "", "=q1=Bottled Alterac Spring Water", "=ds=#e4#", "50 #silver#"};
			};
		};
		info = {
			name = ALIL["Alterac Valley"].." "..AL["Misc. Rewards"],
			module = moduleName, menu = "PVPMENU2", instance = "AlteracValley",
		};
	}

	AtlasLoot_Data["AVBlue"] = {
		["Normal_A"] = {
			{
				{ 2, 19086, "", "=q3=Stormpike Sage's Cloak", "=ds=#s4#", "#HONOR:50#"};
				{ 3, 19084, "", "=q3=Stormpike Soldier's Cloak", "=ds=#s4#", "#HONOR:50#"};
				{ 4, 19094, "", "=q3=Stormpike Cloth Girdle", "=ds=#s10#, #a1#", "#HONOR:60#"};
				{ 5, 19093, "", "=q3=Stormpike Leather Girdle", "=ds=#s10#, #a2#", "#HONOR:60#"};
				{ 6, 19092, "", "=q3=Stormpike Mail Girdle", "=ds=#s10#, #a3#", "#HONOR:60#"};
				{ 7, 19091, "", "=q3=Stormpike Plate Girdle", "=ds=#s10#, #a4#", "#HONOR:60#"};
				{ 8, 19098, "", "=q3=Stormpike Sage's Pendant", "=ds=#s2#", "#HONOR:50#"};
				{ 9, 19097, "", "=q3=Stormpike Soldier's Pendant", "=ds=#s2#", "#HONOR:50#"};
				{ 10, 19100, "", "=q3=Electrified Dagger", "=ds=#h1#, #w4#", "#HONOR:175#"};
				{ 11, 19104, "", "=q3=Stormstrike Hammer", "=ds=#h1#, #w6#", "#HONOR:175#"};
				{ 12, 19102, "", "=q3=Crackling Staff", "=ds=#w9#", "#HONOR:60#"};
				{ 13, 19320, "", "=q3=Gnoll Skin Bandolier", "=ds=#e1#", "#HONOR:50#"};
				{ 14, 19319, "", "=q3=Harpy Hide Quiver", "=ds=#e1#", "#HONOR:50#"};
				{ 17, 19325, "", "=q4=Don Julio's Band", "=ds=#s13#", "#HONOR:50#"};
				{ 18, 21563, "", "=q4=Don Rodrigo's Band", "=ds=#s13#", "#HONOR:50#"};
				{ 19, 19312, "", "=q4=Lei of the Lifegiver", "=ds=#s15#", "#HONOR:50#"};
				{ 20, 19315, "", "=q4=Therazane's Touch", "=ds=#s15#", "#HONOR:50#"};
				{ 21, 19308, "", "=q4=Tome of Arcane Domination", "=ds=#s15#", "#HONOR:50#"};
				{ 22, 19309, "", "=q4=Tome of Shadow Force", "=ds=#s15#", "#HONOR:50#"};
				{ 23, 19311, "", "=q4=Tome of Fiery Arcana", "=ds=#s15#", "#HONOR:50#"};
				{ 24, 19310, "", "=q4=Tome of the Ice Lord", "=ds=#s15#", "#HONOR:50#"};
				{ 25, 19324, "", "=q4=The Lobotomizer", "=ds=#h1#, #w4#", "#HONOR:165#"};
				{ 26, 19321, "", "=q4=The Immovable Object", "=ds=#w8#", "#HONOR:50#"};
				{ 27, 19323, "", "=q4=The Unstoppable Force", "=ds=#h2#, #w6#", "#HONOR:250#"};
			};
		};
		["Normal_H"] = {
			{
				{ 2, 19085, "", "=q3=Frostwolf Advisor's Cloak", "=ds=#s4#", "#HONOR:50#"};
				{ 3, 19083, "", "=q3=Frostwolf Legionnaire's Cloak", "=ds=#s4#", "#HONOR:50#"};
				{ 4, 19090, "", "=q3=Frostwolf Cloth Belt", "=ds=#s10#, #a1#", "#HONOR:60#"};
				{ 5, 19089, "", "=q3=Frostwolf Leather Belt", "=ds=#s10#, #a2#", "#HONOR:60#"};
				{ 6, 19088, "", "=q3=Frostwolf Mail Belt", "=ds=#s10#, #a3#", "#HONOR:60#"};
				{ 7, 19087, "", "=q3=Frostwolf Plate Belt", "=ds=#s10#, #a4#", "#HONOR:60#"};
				{ 8, 19096, "", "=q3=Frostwolf Advisor's Pendant", "=ds=#s2#", "#HONOR:50#"};
				{ 9, 19095, "", "=q3=Frostwolf Legionnaire's Pendant", "=ds=#s2#", "#HONOR:50#"};
				{ 10, 19099, "", "=q3=Glacial Blade", "=ds=#h1#, #w4#", "#HONOR:175#"};
				{ 11, 19103, "", "=q3=Frostbite", "=ds=#h1#, #w6#", "#HONOR:175#"};
				{ 12, 19101, "", "=q3=Whiteout Staff", "=ds=#w9#", "#HONOR:60#"};
				{ 13, 19320, "", "=q3=Gnoll Skin Bandolier", "=ds=#e1#", "#HONOR:50#"};
				{ 14, 19319, "", "=q3=Harpy Hide Quiver", "=ds=#e1#", "#HONOR:50#"};
				{ 17, 19325, "", "=q4=Don Julio's Band", "=ds=#s13#", "#HONOR:50#"};
				{ 18, 21563, "", "=q4=Don Rodrigo's Band", "=ds=#s13#", "#HONOR:50#"};
				{ 19, 19312, "", "=q4=Lei of the Lifegiver", "=ds=#s15#", "#HONOR:50#"};
				{ 20, 19315, "", "=q4=Therazane's Touch", "=ds=#s15#", "#HONOR:50#"};
				{ 21, 19308, "", "=q4=Tome of Arcane Domination", "=ds=#s15#", "#HONOR:50#"};
				{ 22, 19309, "", "=q4=Tome of Shadow Force", "=ds=#s15#", "#HONOR:50#"};
				{ 23, 19311, "", "=q4=Tome of Fiery Arcana", "=ds=#s15#", "#HONOR:50#"};
				{ 24, 19310, "", "=q4=Tome of the Ice Lord", "=ds=#s15#", "#HONOR:50#"};
				{ 25, 19324, "", "=q4=The Lobotomizer", "=ds=#h1#, #w4#", "#HONOR:165#"};
				{ 26, 19321, "", "=q4=The Immovable Object", "=ds=#w8#", "#HONOR:50#"};
				{ 27, 19323, "", "=q4=The Unstoppable Force", "=ds=#h2#, #w6#", "#HONOR:250#"};
			};
		};
		info = {
			name = ALIL["Alterac Valley"],
			module = moduleName, menu = "PVPMENU2", instance = "AlteracValley",
		};
	}

		--------------------
		--- Arathi Basin ---
		--------------------

	AtlasLoot_Data["ABMisc"] = {
		["Normal_A"] = {
			{
				{ 2, 17349, "", "=q1=Superior Healing Draught", "=ds=", "5 #silver# #HONOR:1#", ""};
				{ 3, 17352, "", "=q1=Superior Mana Draught", "=ds=", "5 #silver# #HONOR:1#", ""};
				{ 4, 20225, "", "=q1=Highlander's Enriched Ration", "=ds=", "18 #silver#", ""};
				{ 5, 20227, "", "=q1=Highlander's Iron Ration", "=ds=", "13,5 #silver#", ""};
				{ 6, 20226, "", "=q1=Highlander's Field Ration", "=ds=", "9 #silver#", ""};
				{ 7, 20243, "", "=q1=Highlander's Runecloth Bandage", "=ds=", "18 #silver#", ""};
				{ 8, 20237, "", "=q1=Highlander's Mageweave Bandage", "=ds=", "13,5 #silver#", ""};
				{ 9, 20244, "", "=q1=Highlander's Silk Bandage", "=ds=", "9 #silver#", ""};
				{ 11, 21119, "", "=q3=Talisman of Arathor", "=ds=", "#HONOR:25#", ""};
				{ 12, 21118, "", "=q3=Talisman of Arathor", "=ds=", "#HONOR:35#", ""};
				{ 13, 21117, "", "=q3=Talisman of Arathor", "=ds=", "#HONOR:45#", ""};
				{ 14, 20071, "", "=q3=Talisman of Arathor", "=ds=", "#HONOR:55#", ""};
				{ 17, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "60"), "=q5="..ALIL["The League of Arathor"]};
				{ 18, 20073, "", "=q4=Cloak of the Honor Guard", "=ds=", "#HONOR:85#", ""};
				{ 19, 20070, "", "=q4=Sageclaw", "=ds=", "#HONOR:130#", ""};
				{ 20, 20069, "", "=q4=Ironbark Staff", "=ds=", "#HONOR:185#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 2, 17349, "", "=q1=Superior Healing Draught", "=ds=", "5 #silver# #HONOR:1#", ""};
				{ 3, 17352, "", "=q1=Superior Mana Draught", "=ds=", "5 #silver# #HONOR:1#", ""};
				{ 4, 20222, "", "=q1=Defiler's Enriched Ration", "=ds=", "18 #silver#", ""};
				{ 5, 20224, "", "=q1=Defiler's Iron Ration", "=ds=", "15 #silver#", ""};
				{ 6, 20223, "", "=q1=Defiler's Field Ration", "=ds=", "9 #silver#", ""};
				{ 7, 20234, "", "=q1=Defiler's Runecloth Bandage", "=ds=", "18 #silver#", ""};
				{ 8, 20232, "", "=q1=Defiler's Mageweave Bandage", "=ds=", "15 #silver#", ""};
				{ 9, 20235, "", "=q1=Defiler's Silk Bandage", "=ds=", "9 #silver#", ""};
				{ 11, 21116, "", "=q3=Defiler's Talisman", "=ds=", "#HONOR:25#", ""};
				{ 12, 21120, "", "=q3=Defiler's Talisman", "=ds=", "#HONOR:35#", ""};
				{ 13, 21115, "", "=q3=Defiler's Talisman", "=ds=", "#HONOR:45#", ""};
				{ 14, 20072, "", "=q3=Defiler's Talisman", "=ds=", "#HONOR:55#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6="..string.format(AL["Level %s Rewards"], "60"), "=q5="..ALIL["The Defilers"]};
				{ 17, 20068, "", "=q4=Deathguard's Cloak", "=ds=", "#HONOR:85#", ""};
				{ 25, 20214, "", "=q4=Mindfang", "=ds=", "#HONOR:130#", ""};
				{ 26, 20220, "", "=q4=Ironbark Staff", "=ds=", "#HONOR:185#", ""};
			};
		};
		info = {
			name = ALIL["Arathi Basin"].." "..AL["Misc. Rewards"],
			module = moduleName, menu = "PVPMENU2"
		};
	}

	AtlasLoot_Data["AB4049"] = {
		["Normal_A"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "40-49"), "=q5="..ALIL["The League of Arathor"]};
				{ 2, 20097, "", "=q3=Highlander's Cloth Girdle", "=ds=", "#HONOR:70#", ""};
				{ 3, 20094, "", "=q3=Highlander's Cloth Boots", "=ds=", "#HONOR:70#", ""};
				{ 4, 20115, "", "=q3=Highlander's Leather Girdle", "=ds=", "#HONOR:70#", ""};
				{ 5, 20103, "", "=q3=Highlander's Lizardhide Girdle", "=ds=", "#HONOR:70#", ""};
				{ 6, 20112, "", "=q3=Highlander's Leather Boots", "=ds=", "#HONOR:70#", ""};
				{ 7, 20100, "", "=q3=Highlander's Lizardhide Boots", "=ds=", "#HONOR:70#", ""};
				{ 8, 20089, "", "=q3=Highlander's Chain Girdle", "=ds=", "#HONOR:55#", ""};
				{ 9, 20088, "", "=q3=Highlander's Chain Girdle", "=ds=", "#HONOR:70#", ""};
				{ 10, 20119, "", "=q3=Highlander's Mail Girdle", "=ds=", "#HONOR:55#", ""};
				{ 11, 20118, "", "=q3=Highlander's Mail Girdle", "=ds=", "#HONOR:70#", ""};
				{ 12, 20092, "", "=q3=Highlander's Chain Greaves", "=ds=", "#HONOR:55#", ""};
				{ 13, 20091, "", "=q3=Highlander's Chain Greaves", "=ds=", "#HONOR:70#", ""};
				{ 14, 20122, "", "=q3=Highlander's Mail Greaves", "=ds=", "#HONOR:55#", ""};
				{ 15, 20121, "", "=q3=Highlander's Mail Greaves", "=ds=", "#HONOR:70#", ""};
				{ 17, 20107, "", "=q3=Highlander's Lamellar Girdle", "=ds=", "#HONOR:55#", ""};
				{ 18, 20106, "", "=q3=Highlander's Lamellar Girdle", "=ds=", "#HONOR:70#", ""};
				{ 19, 20125, "", "=q3=Highlander's Plate Girdle", "=ds=", "#HONOR:55#", ""};
				{ 20, 20124, "", "=q3=Highlander's Plate Girdle", "=ds=", "#HONOR:70#", ""};
				{ 21, 20110, "", "=q3=Highlander's Lamellar Greaves", "=ds=", "#HONOR:55#", ""};
				{ 22, 20109, "", "=q3=Highlander's Lamellar Greaves", "=ds=", "#HONOR:70#", ""};
				{ 23, 20128, "", "=q3=Highlander's Plate Greaves", "=ds=", "#HONOR:55#", ""};
				{ 24, 20127, "", "=q3=Highlander's Plate Greaves", "=ds=", "#HONOR:70#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "40-49"), "=q5="..ALIL["The Defilers"]};
				{ 2, 20165, "", "=q3=Defiler's Cloth Girdle", "=ds=", "#HONOR:70#", ""};
				{ 3, 20160, "", "=q3=Defiler's Cloth Boots", "=ds=", "#HONOR:70#", ""};
				{ 4, 20193, "", "=q3=Defiler's Leather Girdle", "=ds=", "#HONOR:70#", ""};
				{ 5, 20174, "", "=q3=Defiler's Lizardhide Girdle", "=ds=", "#HONOR:70#", ""};
				{ 6, 20189, "", "=q3=Defiler's Leather Boots", "=ds=", "#HONOR:70#", ""};
				{ 7, 20170, "", "=q3=Defiler's Lizardhide Boots", "=ds=", "#HONOR:70#", ""};
				{ 8, 20153, "", "=q3=Defiler's Chain Girdle", "=ds=", "#HONOR:55#", ""};
				{ 9, 20151, "", "=q3=Defiler's Chain Girdle", "=ds=", "#HONOR:70#", ""};
				{ 10, 20198, "", "=q3=Defiler's Mail Girdle", "=ds=", "#HONOR:55#", ""};
				{ 11, 20196, "", "=q3=Defiler's Mail Girdle", "=ds=", "#HONOR:70#", ""};
				{ 12, 20156, "", "=q3=Defiler's Chain Greaves", "=ds=", "#HONOR:55#", ""};
				{ 13, 20155, "", "=q3=Defiler's Chain Greaves", "=ds=", "#HONOR:70#", ""};
				{ 14, 20200, "", "=q3=Defiler's Mail Greaves", "=ds=", "#HONOR:55#", ""};
				{ 15, 20202, "", "=q3=Defiler's Mail Greaves", "=ds=", "#HONOR:70#", ""};
				{ 16, 20180, "", "=q3=Defiler's Lamellar Girdle", "=ds=", "#HONOR:55#", ""};
				{ 17, 20179, "", "=q3=Defiler's Lamellar Girdle", "=ds=", "#HONOR:70#", ""};
				{ 18, 20206, "", "=q3=Defiler's Plate Girdle", "=ds=", "#HONOR:55#", ""};
				{ 19, 20205, "", "=q3=Defiler's Plate Girdle", "=ds=", "#HONOR:70#", ""};
				{ 20, 20183, "", "=q3=Defiler's Lamellar Greaves", "=ds=", "#HONOR:55#", ""};
				{ 21, 20185, "", "=q3=Defiler's Lamellar Greaves", "=ds=", "#HONOR:70#", ""};
				{ 22, 20209, "", "=q3=Defiler's Plate Greaves", "=ds=", "#HONOR:55#", ""};
				{ 23, 20211, "", "=q3=Defiler's Plate Greaves", "=ds=", "#HONOR:70#", ""};
			};
		};
		info = {
			name = ALIL["Arathi Basin"].." "..string.format(AL["Level %s Rewards"], "40-49"),
			module = moduleName, menu = "PVPMENU2"
		};
	}

	AtlasLoot_Data["AB2039"] = {
		["Normal_A"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "30-39"), "=q5="..ALIL["The League of Arathor"]};
				{ 2, 20098, "", "=q3=Highlander's Cloth Girdle", "=ds=", "#HONOR:45#", ""};
				{ 3, 20095, "", "=q3=Highlander's Cloth Boots", "=ds=", "#HONOR:45#", ""};
				{ 4, 20116, "", "=q3=Highlander's Leather Girdle", "=ds=", "#HONOR:45#", ""};
				{ 5, 20104, "", "=q3=Highlander's Lizardhide Girdle", "=ds=", "#HONOR:45#", ""};
				{ 6, 20113, "", "=q3=Highlander's Leather Boots", "=ds=", "#HONOR:45#", ""};
				{ 7, 20101, "", "=q3=Highlander's Lizardhide Boots", "=ds=", "#HONOR:45#", ""};
				{ 16, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "20-29"), "=q5="..ALIL["The League of Arathor"]};
				{ 17, 20099, "", "=q3=Highlander's Cloth Girdle", "=ds=", "#HONOR:45#", ""};
				{ 18, 20096, "", "=q3=Highlander's Cloth Boots", "=ds=", "#HONOR:45#", ""};
				{ 19, 20117, "", "=q3=Highlander's Leather Girdle", "=ds=", "#HONOR:45#", ""};
				{ 20, 20105, "", "=q3=Highlander's Lizardhide Girdle", "=ds=", "#HONOR:45#", ""};
				{ 21, 20120, "", "=q3=Highlander's Mail Girdle", "=ds=", "#HONOR:45#", ""};
				{ 22, 20090, "", "=q3=Highlander's Padded Girdle", "=ds=", "#HONOR:45#", ""};
				{ 23, 20114, "", "=q3=Highlander's Leather Boots", "=ds=", "#HONOR:45#", ""};
				{ 24, 20102, "", "=q3=Highlander's Lizardhide Boots", "=ds=", "#HONOR:45#", ""};
				{ 25, 20123, "", "=q3=Highlander's Mail Greaves", "=ds=", "#HONOR:45#", ""};
				{ 26, 20093, "", "=q3=Highlander's Padded Greaves", "=ds=", "#HONOR:45#", ""};
				{ 27, 20108, "", "=q3=Highlander's Lamellar Girdle", "=ds=", "#HONOR:45#", ""};
				{ 28, 20126, "", "=q3=Highlander's Mail Girdle", "=ds=", "#HONOR:45#", ""};
				{ 29, 20111, "", "=q3=Highlander's Lamellar Greaves", "=ds=", "#HONOR:45#", ""};
				{ 30, 20129, "", "=q3=Highlander's Mail Greaves", "=ds=", "#HONOR:45#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "30-39"), "=q5="..ALIL["The Defilers"]};
				{ 2, 20166, "", "=q3=Defiler's Cloth Girdle", "=ds=", "#HONOR:45#", ""};
				{ 3, 20161, "", "=q3=Defiler's Cloth Boots", "=ds=", "#HONOR:45#", ""};
				{ 4, 20192, "", "=q3=Defiler's Leather Girdle", "=ds=", "#HONOR:45#", ""};
				{ 5, 20173, "", "=q3=Defiler's Lizardhide Girdle", "=ds=", "#HONOR:45#", ""};
				{ 6, 20187, "", "=q3=Defiler's Leather Boots", "=ds=", "#HONOR:45#", ""};
				{ 7, 20168, "", "=q3=Defiler's Lizardhide Boots", "=ds=", "#HONOR:45#", ""};
				{ 16, 0, "INV_BannerPVP_02", "=q6="..string.format(AL["Level %s Rewards"], "20-29"), "=q5="..ALIL["The Defilers"]};
				{ 17, 20164, "", "=q3=Defiler's Cloth Girdle", "=ds=", "#HONOR:45#", ""};
				{ 18, 20162, "", "=q3=Defiler's Cloth Boots", "=ds=", "#HONOR:45#", ""};
				{ 19, 20191, "", "=q3=Defiler's Leather Girdle", "=ds=", "#HONOR:45#", ""};
				{ 20, 20172, "", "=q3=Defiler's Lizardhide Girdle", "=ds=", "#HONOR:45#", ""};
				{ 21, 20152, "", "=q3=Defiler's Chain Girdle", "=ds=", "#HONOR:45#", ""};
				{ 22, 20197, "", "=q3=Defiler's Padded Girdle", "=ds=", "#HONOR:45#", ""};
				{ 23, 20188, "", "=q3=Defiler's Leather Boots", "=ds=", "#HONOR:45#", ""};
				{ 24, 20169, "", "=q3=Defiler's Lizardhide Boots", "=ds=", "#HONOR:45#", ""};
				{ 25, 20201, "", "=q3=Defiler's Mail Greaves", "=ds=", "#HONOR:45#", ""};
				{ 26, 20157, "", "=q3=Defiler's Chain Greaves", "=ds=", "#HONOR:45#", ""};
				{ 27, 20178, "", "=q3=Defiler's Lamellar Girdle", "=ds=", "#HONOR:45#", ""};
				{ 28, 20207, "", "=q3=Defiler's Mail Girdle", "=ds=", "#HONOR:45#", ""};
				{ 29, 20182, "", "=q3=Defiler's Lamellar Greaves", "=ds=", "#HONOR:45#", ""};
				{ 30, 20210, "", "=q3=Defiler's Mail Greaves", "=ds=", "#HONOR:45#", ""};
			};
		};
		info = {
			name = ALIL["Arathi Basin"].." "..string.format(AL["Level %s Rewards"], "20-39"),
			module = moduleName, menu = "PVPMENU2"
		};
	}

	AtlasLoot_Data["ABSets"] = {
		["Normal_A"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#absa1#", "=ec1=#c5#, #c3#, #c8#"};
				{ 2, 20061, "", "=q4=Highlander's Epaulets", "=ds=", "#HONOR:130#", ""};
				{ 3, 20047, "", "=q3=Highlander's Cloth Girdle", "=ds=", "#HONOR:85#", ""};
				{ 4, 20054, "", "=q3=Highlander's Cloth Boots", "=ds=", "#HONOR:85#", ""};
				{ 6, 0, "INV_BannerPVP_02", "=q6=#absa2#", "=ec1=#c6#, #c1#"};
				{ 7, 20059, "", "=q4=Highlander's Leather Shoulders", "=ds=", "#HONOR:130#", ""};
				{ 8, 20045, "", "=q3=Highlander's Leather Girdle", "=ds=", "#HONOR:85#", ""};
				{ 9, 20052, "", "=q3=Highlander's Leather Boots", "=ds=", "#HONOR:85#", ""};
				{ 11, 0, "INV_BannerPVP_02", "=q6=#absa3#", "=ec1=#c6#, #c1#"};
				{ 12, 20060, "", "=q4=Highlander's Lizardhide Shoulders", "=ds=", "#HONOR:130#", ""};
				{ 13, 20046, "", "=q3=Highlander's Lizardhide Girdle", "=ds=", "#HONOR:85#", ""};
				{ 14, 20053, "", "=q3=Highlander's Lizardhide Boots", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_02", "=q6=#absa4#", "=ec1=#c2#, #c7#"};
				{ 17, 20055, "", "=q4=Highlander's Chain Pauldrons", "=ds=", "#HONOR:130#", ""};
				{ 18, 20043, "", "=q3=Highlander's Chain Girdle", "=ds=", "#HONOR:85#", ""};
				{ 19, 20050, "", "=q3=Highlander's Chain Greaves", "=ds=", "#HONOR:85#", ""};
				{ 21, 0, "INV_BannerPVP_02", "=q6=#absa5#", "=ec1=#c2#, #c7#"};
				{ 22, 20056, "", "=q4=Highlander's Mail Pauldrons", "=ds=", "#HONOR:130#", ""};
				{ 23, 20044, "", "=q3=Highlander's Mail Girdle", "=ds=", "#HONOR:85#", ""};
				{ 24, 20051, "", "=q3=Highlander's Mail Greaves", "=ds=", "#HONOR:85#", ""};
				{ 26, 0, "INV_BannerPVP_02", "=q6=#absa6#", "=ec1=#c9#, #c4#"};
				{ 27, 20057, "", "=q4=Highlander's Plate Spaulders", "=ds=", "#HONOR:130#", ""};
				{ 28, 20041, "", "=q3=Highlander's Plate Girdle", "=ds=", "#HONOR:85#", ""};
				{ 29, 20048, "", "=q3=Highlander's Plate Greaves", "=ds=", "#HONOR:85#", ""};
			};
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#absa7#", "=ec1=#c4#"};
				{ 2, 20058, "", "=q4=Highlander's Lamellar Spaulders", "=ds=", "#HONOR:130#", ""};
				{ 3, 20042, "", "=q3=Highlander's Lamellar Girdle", "=ds=", "#HONOR:85#", ""};
				{ 4, 20049, "", "=q3=Highlander's Lamellar Greaves", "=ds=", "#HONOR:85#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 0, "INV_BannerPVP_01", "=q6=#absh1#", "=ec1=#c5#, #c3#, #c8#"};
				{ 2, 20176, "", "=q4=Defiler's Epaulets", "=ds=", "#HONOR:130#", ""};
				{ 3, 20163, "", "=q3=Defiler's Cloth Girdle", "=ds=", "#HONOR:85#", ""};
				{ 4, 20159, "", "=q3=Defiler's Cloth Boots", "=ds=", "#HONOR:85#", ""};
				{ 6, 0, "INV_BannerPVP_01", "=q6=#absh2#", "=ec1=#c6#, #c1#"};
				{ 7, 20194, "", "=q4=Defiler's Leather Shoulders", "=ds=", "#HONOR:130#", ""};
				{ 8, 20190, "", "=q3=Defiler's Leather Girdle", "=ds=", "#HONOR:85#", ""};
				{ 9, 20186, "", "=q3=Defiler's Leather Boots", "=ds=", "#HONOR:85#", ""};
				{ 11, 0, "INV_BannerPVP_01", "=q6=#absh3#", "=ec1=#c6#, #c1#"};
				{ 12, 20175, "", "=q4=Defiler's Lizardhide Shoulders", "=ds=", "#HONOR:130#", ""};
				{ 13, 20171, "", "=q3=Defiler's Lizardhide Girdle", "=ds=", "#HONOR:85#", ""};
				{ 14, 20167, "", "=q3=Defiler's Lizardhide Boots", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#absh4#", "=ec1=#c2#, #c7#"};
				{ 17, 20158, "", "=q3=Defiler's Chain Pauldrons", "=ds=", "#HONOR:130#", ""};
				{ 18, 20150, "", "=q3=Defiler's Chain Girdle", "=ds=", "#HONOR:85#", ""};
				{ 19, 20154, "", "=q3=Defiler's Chain Greaves", "=ds=", "#HONOR:85#", ""};
				{ 21, 0, "INV_BannerPVP_01", "=q6=#absh5#", "=ec1=#c2#, #c7#"};
				{ 22, 20203, "", "=q4=Defiler's Mail Pauldrons", "=ds=", "#HONOR:130#", ""};
				{ 23, 20195, "", "=q3=Defiler's Mail Girdle", "=ds=", "#HONOR:85#", ""};
				{ 24, 20199, "", "=q3=Defiler's Mail Greaves", "=ds=", "#HONOR:85#", ""};
				{ 26, 0, "INV_BannerPVP_01", "=q6=#absh6#", "=ec1=#c9#, #c4#"};
				{ 27, 20212, "", "=q4=Defiler's Plate Spaulders", "=ds=", "#HONOR:130#", ""};
				{ 28, 20204, "", "=q3=Defiler's Plate Girdle", "=ds=", "#HONOR:85#", ""};
				{ 29, 20208, "", "=q3=Defiler's Plate Greaves", "=ds=", "#HONOR:85#", ""};
			};
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#absa7#", "=ec1=#c4#"};
				{ 2, 20184, "", "=q4=Defiler's Lamellar Spaulders", "=ds=", "#HONOR:130#", ""};
				{ 3, 20177, "", "=q3=Defiler's Lamellar Girdle", "=ds=", "#HONOR:85#", ""};
				{ 4, 20181, "", "=q3=Defiler's Lamellar Greaves", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = AL["Arathi Basin Sets"],
			module = moduleName, menu = "PVPMENU2"
		};
	}

		---------------------
		--- Warsong Gulch ---
		---------------------

	AtlasLoot_Data["WSGMisc"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#m7#", "=q5="..ALIL["Silverwing Sentinels"]};
				{ 2, 19506, "", "=q1=Silverwing Battle Tabard", "=ds=", "#HONOR:2059#", ""};
				{ 5, 17348, "", "=q1=Major Healing Draught", "=ds=", "10 #silver# #HONOR:1#", ""};
				{ 6, 17349, "", "=q1=Superior Healing Draught", "=ds=", "5 #silver# #HONOR:1#", ""};
				{ 7, 19060, "", "=q1=Warsong Gulch Enriched Ration", "=ds=", "20 #silver#", ""};
				{ 8, 19062, "", "=q1=Warsong Gulch Field Ration", "=ds=", "10 #silver#", ""};
				{ 9, 19067, "", "=q1=Warsong Gulch Mageweave Bandage", "=ds=", "15 #silver#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#m6#", "=q5="..ALIL["Warsong Outriders"]};
				{ 17, 19505, "", "=q1=Warsong Battle Tabard", "=ds=", "#HONOR:2059#", ""};
				{ 20, 17351, "", "=q1=Major Mana Draught", "=ds=", "10 #silver# #HONOR:1#", ""};
				{ 21, 17352, "", "=q1=Superior Mana Draught", "=ds=", "5 #silver# #HONOR:1#", ""};
				{ 22, 19061, "", "=q1=Warsong Gulch Iron Ration", "=ds=", "15 #silver#", ""};
				{ 23, 19066, "", "=q1=Warsong Gulch Runecloth Bandage", "=ds=", "20 #silver#", ""};
				{ 24, 19068, "", "=q1=Warsong Gulch Silk Bandage", "=ds=", "10 #silver#", ""};
			};
		};
		info = {
			name = ALIL["Warsong Gulch"].." "..AL["Misc. Rewards"],
			module = moduleName, menu = "PVPMENU2", instance = "WarsongGulch",
		};
	}

	AtlasLoot_Data["WSGAccessories"] = {
		["Normal_A"] = {
			{
				{ 1, 20428, "", "=q3=Caretaker's Cape", "=ds=", "#HONOR:20#", ""};
				{ 2, 19533, "", "=q3=Caretaker's Cape", "=ds=", "#HONOR:25#", ""};
				{ 3, 19532, "", "=q3=Caretaker's Cape", "=ds=", "#HONOR:35#", ""};
				{ 4, 19531, "", "=q3=Caretaker's Cape", "=ds=", "#HONOR:45#", ""};
				{ 5, 19530, "", "=q3=Caretaker's Cape", "=ds=", "#HONOR:55#", ""};
				{ 7, 20444, "", "=q3=Sentinel's Medallion", "=ds=", "#HONOR:20#", ""};
				{ 8, 19541, "", "=q3=Sentinel's Medallion", "=ds=", "#HONOR:25#", ""};
				{ 9, 19540, "", "=q3=Sentinel's Medallion", "=ds=", "#HONOR:35#", ""};
				{ 10, 19539, "", "=q3=Sentinel's Medallion", "=ds=", "#HONOR:45#", ""};
				{ 11, 19538, "", "=q3=Sentinel's Medallion", "=ds=", "#HONOR:55#", ""};
				{ 13, 21568, "", "=q3=Rune of Duty", "=ds=", "#HONOR:20#", ""};
				{ 14, 21567, "", "=q3=Rune of Duty", "=ds=", "#HONOR:35#", ""};
				{ 16, 20431, "", "=q3=Lorekeeper's Ring", "=ds=", "#HONOR:20#", ""};
				{ 17, 19525, "", "=q3=Lorekeeper's Ring", "=ds=", "#HONOR:25#", ""};
				{ 18, 19524, "", "=q3=Lorekeeper's Ring", "=ds=", "#HONOR:35#", ""};
				{ 19, 19523, "", "=q3=Lorekeeper's Ring", "=ds=", "#HONOR:45#", ""};
				{ 20, 19522, "", "=q3=Lorekeeper's Ring", "=ds=", "#HONOR:55#", ""};
				{ 22, 20439, "", "=q3=Protector's Band", "=ds=", "#HONOR:20#", ""};
				{ 23, 19517, "", "=q3=Protector's Band", "=ds=", "#HONOR:25#", ""};
				{ 24, 19515, "", "=q3=Protector's Band", "=ds=", "#HONOR:35#", ""};
				{ 25, 19516, "", "=q3=Protector's Band", "=ds=", "#HONOR:45#", ""};
				{ 26, 19514, "", "=q3=Protector's Band", "=ds=", "#HONOR:55#", ""};
				{ 28, 21566, "", "=q3=Rune of Perfection", "=ds=", "#HONOR:20#", ""};
				{ 29, 21565, "", "=q3=Rune of Perfection", "=ds=", "#HONOR:35#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 20427, "", "=q3=Battle Healer's Cloak", "=ds=", "#HONOR:20#", ""};
				{ 2, 19529, "", "=q3=Battle Healer's Cloak", "=ds=", "#HONOR:25#", ""};
				{ 3, 19528, "", "=q3=Battle Healer's Cloak", "=ds=", "#HONOR:35#", ""};
				{ 4, 19527, "", "=q3=Battle Healer's Cloak", "=ds=", "#HONOR:45#", ""};
				{ 5, 19526, "", "=q3=Battle Healer's Cloak", "=ds=", "#HONOR:55#", ""};
				{ 7, 20442, "", "=q3=Scout's Medallion", "=ds=", "#HONOR:20#", ""};
				{ 8, 19537, "", "=q3=Scout's Medallion", "=ds=", "#HONOR:25#", ""};
				{ 9, 19536, "", "=q3=Scout's Medallion", "=ds=", "#HONOR:35#", ""};
				{ 10, 19535, "", "=q3=Scout's Medallion", "=ds=", "#HONOR:45#", ""};
				{ 11, 19534, "", "=q3=Scout's Medallion", "=ds=", "#HONOR:55#", ""};
				{ 13, 21568, "", "=q3=Rune of Duty", "=ds=", "#HONOR:20#", ""};
				{ 14, 21567, "", "=q3=Rune of Duty", "=ds=", "#HONOR:35#", ""};
				{ 16, 20426, "", "=q3=Advisor's Ring", "=ds=", "#HONOR:20#", ""};
				{ 17, 19521, "", "=q3=Advisor's Ring", "=ds=", "#HONOR:25#", ""};
				{ 18, 19520, "", "=q3=Advisor's Ring", "=ds=", "#HONOR:35#", ""};
				{ 19, 19519, "", "=q3=Advisor's Ring", "=ds=", "#HONOR:45#", ""};
				{ 20, 19518, "", "=q3=Advisor's Ring", "=ds=", "#HONOR:55#", ""};
				{ 22, 20429, "", "=q3=Legionnaire's Band", "=ds=", "#HONOR:20#", ""};
				{ 23, 19513, "", "=q3=Legionnaire's Band", "=ds=", "#HONOR:25#", ""};
				{ 24, 19512, "", "=q3=Legionnaire's Band", "=ds=", "#HONOR:35#", ""};
				{ 25, 19511, "", "=q3=Legionnaire's Band", "=ds=", "#HONOR:45#", ""};
				{ 26, 19510, "", "=q3=Legionnaire's Band", "=ds=", "#HONOR:55#", ""};
				{ 28, 21566, "", "=q3=Rune of Perfection", "=ds=", "#HONOR:20#", ""};
				{ 29, 21565, "", "=q3=Rune of Perfection", "=ds=", "#HONOR:35#", ""};
			};
		};
		info = {
			name = ALIL["Warsong Gulch"].." "..AL["Accessories"],
			module = moduleName, menu = "PVPMENU2", instance = "WarsongGulch",
		};
	}

	AtlasLoot_Data["WSGWeapons"] = {
		["Normal_A"] = {
			{
				{ 1, 20443, "", "=q3=Sentinel's Blade", "=ds=", "#HONOR:70#", ""};
				{ 2, 19549, "", "=q3=Sentinel's Blade", "=ds=", "#HONOR:85#", ""};
				{ 3, 19548, "", "=q3=Sentinel's Blade", "=ds=", "#HONOR:110#", ""};
				{ 4, 19547, "", "=q3=Sentinel's Blade", "=ds=", "#HONOR:135#", ""};
				{ 5, 19546, "", "=q3=Sentinel's Blade", "=ds=", "#HONOR:170#", ""};
				{ 7, 20440, "", "=q3=Protector's Sword", "=ds=", "#HONOR:70#", ""};
				{ 8, 19557, "", "=q3=Protector's Sword", "=ds=", "#HONOR:85#", ""};
				{ 9, 19556, "", "=q3=Protector's Sword", "=ds=", "#HONOR:110#", ""};
				{ 10, 19555, "", "=q3=Protector's Sword", "=ds=", "#HONOR:135#", ""};
				{ 11, 19554, "", "=q3=Protector's Sword", "=ds=", "#HONOR:170#", ""};
				{ 16, 20434, "", "=q3=Lorekeeper's Staff", "=ds=", "#HONOR:100#", ""};
				{ 17, 19573, "", "=q3=Lorekeeper's Staff", "=ds=", "#HONOR:125#", ""};
				{ 18, 19572, "", "=q3=Lorekeeper's Staff", "=ds=", "#HONOR:155#", ""};
				{ 19, 19571, "", "=q3=Lorekeeper's Staff", "=ds=", "#HONOR:195#", ""};
				{ 20, 19570, "", "=q3=Lorekeeper's Staff", "=ds=", "#HONOR:245#", ""};
				{ 22, 20438, "", "=q3=Outrunner's Bow", "=ds=", "#HONOR:70#", ""};
				{ 23, 19565, "", "=q3=Outrunner's Bow", "=ds=", "#HONOR:85#", ""};
				{ 24, 19564, "", "=q3=Outrunner's Bow", "=ds=", "#HONOR:110#", ""};
				{ 25, 19563, "", "=q3=Outrunner's Bow", "=ds=", "#HONOR:135#", ""};
				{ 26, 19562, "", "=q3=Outrunner's Bow", "=ds=", "#HONOR:170#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 20441, "", "=q3=Scout's Blade", "=ds=", "#HONOR:70#", ""};
				{ 2, 19545, "", "=q3=Scout's Blade", "=ds=", "#HONOR:85#", ""};
				{ 3, 19544, "", "=q3=Scout's Blade", "=ds=", "#HONOR:110#", ""};
				{ 4, 19543, "", "=q3=Scout's Blade", "=ds=", "#HONOR:135#", ""};
				{ 5, 19542, "", "=q3=Scout's Blade", "=ds=", "#HONOR:170#", ""};
				{ 7, 20430, "", "=q3=Legionnaire's Sword", "=ds=", "#HONOR:70#", ""};
				{ 8, 19553, "", "=q3=Legionnaire's Sword", "=ds=", "#HONOR:85#", ""};
				{ 9, 19552, "", "=q3=Legionnaire's Sword", "=ds=", "#HONOR:110#", ""};
				{ 10, 19551, "", "=q3=Legionnaire's Sword", "=ds=", "#HONOR:135#", ""};
				{ 11, 19550, "", "=q3=Legionnaire's Sword", "=ds=", "#HONOR:170#", ""};
				{ 16, 20425, "", "=q3=Advisor's Gnarled Staff", "=ds=", "#HONOR:100#", ""};
				{ 17, 19569, "", "=q3=Advisor's Gnarled Staff", "=ds=", "#HONOR:125#", ""};
				{ 18, 19568, "", "=q3=Advisor's Gnarled Staff", "=ds=", "#HONOR:155#", ""};
				{ 19, 19567, "", "=q3=Advisor's Gnarled Staff", "=ds=", "#HONOR:195#", ""};
				{ 20, 19566, "", "=q3=Advisor's Gnarled Staff", "=ds=", "#HONOR:245#", ""};
				{ 22, 20437, "", "=q3=Outrider's Bow", "=ds=", "#HONOR:70#", ""};
				{ 23, 19561, "", "=q3=Outrider's Bow", "=ds=", "#HONOR:85#", ""};
				{ 24, 19560, "", "=q3=Outrider's Bow", "=ds=", "#HONOR:110#", ""};
				{ 25, 19559, "", "=q3=Outrider's Bow", "=ds=", "#HONOR:135#", ""};
				{ 26, 19558, "", "=q3=Outrider's Bow", "=ds=", "#HONOR:170#", ""};
			};
		};
		info = {
			name = ALIL["Warsong Gulch"].." "..AL["Weapons"],
			module = moduleName, menu = "PVPMENU2", instance = "WarsongGulch",
		};
	}

	AtlasLoot_Data["WSGArmor"] = {
		["Normal_A"] = {
			{
				{ 1, 19597, "", "=q4=Dryad's Wrist Bindings", "=ds=", "#HONOR:55#", ""};
				{ 2, 19596, "", "=q4=Dryad's Wrist Bindings", "=ds=", "#HONOR:65#", ""};
				{ 3, 19595, "", "=q4=Dryad's Wrist Bindings", "=ds=", "#HONOR:85#", ""};
				{ 5, 19590, "", "=q4=Forest Stalker's Bracers", "=ds=", "#HONOR:55#", ""};
				{ 6, 19589, "", "=q4=Forest Stalker's Bracers", "=ds=", "#HONOR:65#", ""};
				{ 7, 19587, "", "=q4=Forest Stalker's Bracers", "=ds=", "#HONOR:85#", ""};
				{ 9, 19584, "", "=q4=Windtalker's Wristguards", "=ds=", "#HONOR:55#", ""};
				{ 10, 19583, "", "=q4=Windtalker's Wristguards", "=ds=", "#HONOR:65#", ""};
				{ 11, 19582, "", "=q4=Windtalker's Wristguards", "=ds=", "#HONOR:85#", ""};
				{ 13, 19581, "", "=q4=Berserker Bracers", "=ds=", "#HONOR:55#", ""};
				{ 14, 19580, "", "=q4=Berserker Bracers", "=ds=", "#HONOR:65#", ""};
				{ 15, 19578, "", "=q4=Berserker Bracers", "=ds=", "#HONOR:85#", ""};
				{ 16, 22752, "", "=q4=Sentinel's Silk Leggings", "=ds=", "#HONOR:105#", ""};
				{ 18, 22749, "", "=q4=Sentinel's Leather Pants", "=ds=", "#HONOR:105#", ""};
				{ 19, 22750, "", "=q4=Sentinel's Lizardhide Pants", "=ds=", "#HONOR:105#", ""};
				{ 21, 22748, "", "=q4=Sentinel's Chain Leggings", "=ds=", "#HONOR:105#", ""};
				{ 22, 30497, "", "=q4=Sentinel's Mail Leggings", "=ds=", "#HONOR:105#", ""};
				{ 24, 22753, "", "=q4=Sentinel's Lamellar Legguards", "=ds=", "#HONOR:105#", ""};
				{ 25, 22672, "", "=q4=Sentinel's Plate Legguards", "=ds=", "#HONOR:105#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 19597, "", "=q4=Dryad's Wrist Bindings", "=ds=", "#HONOR:55#", ""};
				{ 2, 19596, "", "=q4=Dryad's Wrist Bindings", "=ds=", "#HONOR:65#", ""};
				{ 3, 19595, "", "=q4=Dryad's Wrist Bindings", "=ds=", "#HONOR:85#", ""};
				{ 5, 19590, "", "=q4=Forest Stalker's Bracers", "=ds=", "#HONOR:55#", ""};
				{ 6, 19589, "", "=q4=Forest Stalker's Bracers", "=ds=", "#HONOR:65#", ""};
				{ 7, 19587, "", "=q4=Forest Stalker's Bracers", "=ds=", "#HONOR:85#", ""};
				{ 9, 19584, "", "=q4=Windtalker's Wristguards", "=ds=", "#HONOR:55#", ""};
				{ 10, 19583, "", "=q4=Windtalker's Wristguards", "=ds=", "#HONOR:65#", ""};
				{ 11, 19582, "", "=q4=Windtalker's Wristguards", "=ds=", "#HONOR:85#", ""};
				{ 13, 19581, "", "=q4=Berserker Bracers", "=ds=", "#HONOR:55#", ""};
				{ 14, 19580, "", "=q4=Berserker Bracers", "=ds=", "#HONOR:65#", ""};
				{ 15, 19578, "", "=q4=Berserker Bracers", "=ds=", "#HONOR:85#", ""};
				{ 16, 22747, "", "=q4=Outrider's Silk Leggings", "=ds=", "#HONOR:105#", ""};
				{ 18, 22740, "", "=q4=Outrider's Leather Pants", "=ds=", "#HONOR:105#", ""};
				{ 19, 22741, "", "=q4=Outrider's Lizardhide Pants", "=ds=", "#HONOR:105#", ""};
				{ 21, 22673, "", "=q4=Outrider's Chain Leggings", "=ds=", "#HONOR:105#", ""};
				{ 22, 22676, "", "=q4=Outrider's Mail Leggings", "=ds=", "#HONOR:105#", ""};
				{ 24, 30498, "", "=q4=Outrider's Lamellar Legguards", "=ds=", "#HONOR:105#", ""};
				{ 25, 22651, "", "=q4=Outrider's Plate Legguards", "=ds=", "#HONOR:105#", ""};
			};
		};
		info = {
			name = ALIL["Warsong Gulch"].." "..BabbleInventory["Armor"],
			module = moduleName, menu = "PVPMENU2", instance = "WarsongGulch",
		};
	}

		---------------------------------------
		--- PvP Level 60 Rare and Epic Sets ---
		---------------------------------------

	AtlasLoot_Data["PVP60Druid"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea1#", "=q5=#pvps1#"};
				{ 2, 16451, "", "=q4=Field Marshal's Dragonhide Helmet", "=ds=", "#HONOR:125#", ""};
				{ 3, 16449, "", "=q4=Field Marshal's Dragonhide Spaulders", "=ds=", "#HONOR:70#", ""};
				{ 4, 16452, "", "=q4=Field Marshal's Dragonhide Breastplate", "=ds=", "#HONOR:125#", ""};
				{ 5, 16448, "", "=q4=Marshal's Dragonhide Gauntlets", "=ds=", "#HONOR:70#", ""};
				{ 6, 16450, "", "=q4=Marshal's Dragonhide Legguards", "=ds=", "#HONOR:125#", ""};
				{ 7, 16459, "", "=q4=Marshal's Dragonhide Boots", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra1#", "=q5=#pvps2#"};
				{ 10, 23308, "", "=q3=Lieutenant Commander's Dragonhide Headguard", "=ds=", "#HONOR:105#", ""};
				{ 11, 23309, "", "=q3=Lieutenant Commander's Dragonhide Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 12, 23294, "", "=q3=Knight-Captain's Dragonhide Chestpiece", "=ds=", "#HONOR:105#", ""};
				{ 13, 23280, "", "=q3=Knight-Lieutenant's Dragonhide Grips", "=ds=", "#HONOR:60#", ""};
				{ 14, 23295, "", "=q3=Knight-Captain's Dragonhide Leggings", "=ds=", "#HONOR:105#", ""};
				{ 15, 23281, "", "=q3=Knight-Lieutenant's Dragonhide Treads", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh1#", "=q5=#pvps1#"};
				{ 17, 16550, "", "=q4=Warlord's Dragonhide Helmet", "=ds=", "#HONOR:125#", ""};
				{ 18, 16551, "", "=q4=Warlord's Dragonhide Epaulets", "=ds=", "#HONOR:70#", ""};
				{ 19, 16549, "", "=q4=Warlord's Dragonhide Hauberk", "=ds=", "#HONOR:125#", ""};
				{ 20, 16555, "", "=q4=General's Dragonhide Gloves", "=ds=", "#HONOR:70#", ""};
				{ 21, 16552, "", "=q4=General's Dragonhide Leggings", "=ds=", "#HONOR:125#", ""};
				{ 22, 16554, "", "=q4=General's Dragonhide Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh1#", "=q5=#pvps2#"};
				{ 25, 23253, "", "=q3=Champion's Dragonhide Headguard", "=ds=", "#HONOR:105#", ""};
				{ 26, 23254, "", "=q3=Champion's Dragonhide Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 27, 22877, "", "=q3=Legionnaire's Dragonhide Chestpiece", "=ds=", "#HONOR:105#", ""};
				{ 28, 22863, "", "=q3=Blood Guard's Dragonhide Grips", "=ds=", "#HONOR:60#", ""};
				{ 29, 22878, "", "=q3=Legionnaire's Dragonhide Leggings", "=ds=", "#HONOR:105#", ""};
				{ 30, 22852, "", "=q3=Blood Guard's Dragonhide Treads", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["DRUID"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Hunter"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea2#", "=q5=#pvps1#"};
				{ 2, 16465, "", "=q4=Field Marshal's Chain Helm", "=ds=", "#HONOR:125#", ""};
				{ 3, 16468, "", "=q4=Field Marshal's Chain Spaulders", "=ds=", "#HONOR:70#", ""};
				{ 4, 16466, "", "=q4=Field Marshal's Chain Breastplate", "=ds=", "#HONOR:125#", ""};
				{ 5, 16463, "", "=q4=Marshal's Chain Grips", "=ds=", "#HONOR:70#", ""};
				{ 6, 16467, "", "=q4=Marshal's Chain Legguards", "=ds=", "#HONOR:125#", ""};
				{ 7, 16462, "", "=q4=Marshal's Chain Boots", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra2#", "=q5=#pvps2#"};
				{ 10, 23306, "", "=q3=Lieutenant Commander's Chain Helm", "=ds=", "#HONOR:105#", ""};
				{ 11, 23307, "", "=q3=Lieutenant Commander's Chain Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 12, 23292, "", "=q3=Knight-Captain's Chain Hauberk", "=ds=", "#HONOR:105#", ""};
				{ 13, 23279, "", "=q3=Knight-Lieutenant's Chain Vices", "=ds=", "#HONOR:60#", ""};
				{ 14, 23293, "", "=q3=Knight-Captain's Chain Legguards", "=ds=", "#HONOR:105#", ""};
				{ 15, 23278, "", "=q3=Knight-Lieutenant's Chain Greaves", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh2#", "=q5=#pvps1#"};
				{ 17, 16566, "", "=q4=Warlord's Chain Helmet", "=ds=", "#HONOR:125#", ""};
				{ 18, 16568, "", "=q4=Warlord's Chain Shoulders", "=ds=", "#HONOR:70#", ""};
				{ 19, 16565, "", "=q4=Warlord's Chain Chestpiece", "=ds=", "#HONOR:125#", ""};
				{ 20, 16571, "", "=q4=General's Chain Gloves", "=ds=", "#HONOR:70#", ""};
				{ 21, 16567, "", "=q4=General's Chain Legguards", "=ds=", "#HONOR:125#", ""};
				{ 22, 16569, "", "=q4=General's Chain Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh2#", "=q5=#pvps2#"};
				{ 25, 23251, "", "=q3=Champion's Chain Helm", "=ds=", "#HONOR:105#", ""};
				{ 26, 23252, "", "=q3=Champion's Chain Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 27, 22874, "", "=q3=Legionnaire's Chain Hauberk", "=ds=", "#HONOR:105#", ""};
				{ 28, 22862, "", "=q3=Blood Guard's Chain Vices", "=ds=", "#HONOR:60#", ""};
				{ 29, 22875, "", "=q3=Legionnaire's Chain Legguards", "=ds=", "#HONOR:105#", ""};
				{ 30, 22843, "", "=q3=Blood Guard's Chain Greaves", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["HUNTER"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Mage"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea3#", "=q5=#pvps1#"};
				{ 2, 16441, "", "=q4=Field Marshal's Coronet", "=ds=", "#HONOR:125#", ""};
				{ 3, 16444, "", "=q4=Field Marshal's Silk Spaulders", "=ds=", "#HONOR:70#", ""};
				{ 4, 16443, "", "=q4=Field Marshal's Silk Vestments", "=ds=", "#HONOR:125#", ""};
				{ 5, 16440, "", "=q4=Marshal's Silk Gloves", "=ds=", "#HONOR:70#", ""};
				{ 6, 16442, "", "=q4=Marshal's Silk Leggings", "=ds=", "#HONOR:125#", ""};
				{ 7, 16437, "", "=q4=Marshal's Silk Footwraps", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra3#", "=q5=#pvps2#"};
				{ 10, 23318, "", "=q3=Lieutenant Commander's Silk Cowl", "=ds=", "#HONOR:105#", ""};
				{ 11, 23319, "", "=q3=Lieutenant Commander's Silk Mantle", "=ds=", "#HONOR:85#", ""};
				{ 12, 23305, "", "=q3=Knight-Captain's Silk Tunic", "=ds=", "#HONOR:105#", ""};
				{ 13, 23290, "", "=q3=Knight-Lieutenant's Silk Handwraps", "=ds=", "#HONOR:60#", ""};
				{ 14, 23304, "", "=q3=Knight-Captain's Silk Legguards", "=ds=", "#HONOR:105#", ""};
				{ 15, 23291, "", "=q3=Knight-Lieutenant's Silk Walkers", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh3#", "=q5=#pvps1#"};
				{ 17, 16533, "", "=q4=Warlord's Silk Cowl", "=ds=", "#HONOR:125#", ""};
				{ 18, 16536, "", "=q4=Warlord's Silk Amice", "=ds=", "#HONOR:70#", ""};
				{ 19, 16535, "", "=q4=Warlord's Silk Raiment", "=ds=", "#HONOR:125#", ""};
				{ 20, 16540, "", "=q4=General's Silk Handguards", "=ds=", "#HONOR:70#", ""};
				{ 21, 16534, "", "=q4=General's Silk Trousers", "=ds=", "#HONOR:125#", ""};
				{ 22, 16539, "", "=q4=General's Silk Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh3#", "=q5=#pvps2#"};
				{ 25, 23263, "", "=q3=Champion's Silk Cowl", "=ds=", "#HONOR:105#", ""};
				{ 26, 23264, "", "=q3=Champion's Silk Mantle", "=ds=", "#HONOR:85#", ""};
				{ 27, 22886, "", "=q3=Legionnaire's Silk Tunic", "=ds=", "#HONOR:105#", ""};
				{ 28, 22870, "", "=q3=Blood Guard's Silk Handwraps", "=ds=", "#HONOR:60#", ""};
				{ 29, 22883, "", "=q3=Legionnaire's Silk Legguards", "=ds=", "#HONOR:105#", ""};
				{ 30, 22860, "", "=q3=Blood Guard's Silk Walkers", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["MAGE"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Paladin"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea4#", "=q5=#pvps1#"};
				{ 2, 16474, "", "=q4=Field Marshal's Lamellar Faceguard", "=ds=", "#HONOR:125#", ""};
				{ 3, 16476, "", "=q4=Field Marshal's Lamellar Pauldrons", "=ds=", "#HONOR:70#", ""};
				{ 4, 16473, "", "=q4=Field Marshal's Lamellar Chestplate", "=ds=", "#HONOR:125#", ""};
				{ 5, 16471, "", "=q4=Marshal's Lamellar Gloves", "=ds=", "#HONOR:70#", ""};
				{ 6, 16475, "", "=q4=Marshal's Lamellar Legplates", "=ds=", "#HONOR:125#", ""};
				{ 7, 16472, "", "=q4=Marshal's Lamellar Boots", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra4#", "=q5=#pvps2#"};
				{ 10, 23276, "", "=q3=Lieutenant Commander's Lamellar Headguard", "=ds=", "#HONOR:105#", ""};
				{ 11, 23277, "", "=q3=Lieutenant Commander's Lamellar Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 12, 23272, "", "=q3=Knight-Captain's Lamellar Breastplate", "=ds=", "#HONOR:105#", ""};
				{ 13, 23274, "", "=q3=Knight-Lieutenant's Lamellar Gauntlets", "=ds=", "#HONOR:60#", ""};
				{ 14, 23273, "", "=q3=Knight-Captain's Lamellar Leggings", "=ds=", "#HONOR:105#", ""};
				{ 15, 23275, "", "=q3=Knight-Lieutenant's Lamellar Sabatons", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh9#", "=q5=#pvps1#"};
				{ 17, 29616, "", "=q4=Warlord's Lamellar Faceguard", "=ds=", "#HONOR:125#", ""};
				{ 18, 29617, "", "=q4=Warlord's Lamellar Pauldrons", "=ds=", "#HONOR:70#", ""};
				{ 19, 29615, "", "=q4=Warlord's Lamellar Chestplate", "=ds=", "#HONOR:125#", ""};
				{ 20, 29613, "", "=q4=General's Lamellar Gloves", "=ds=", "#HONOR:70#", ""};
				{ 21, 29614, "", "=q4=General's Lamellar Legplates", "=ds=", "#HONOR:125#", ""};
				{ 22, 29612, "", "=q4=General's Lamellar Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh9#", "=q5=#pvps2#"};
				{ 25, 29604, "", "=q3=Champion's Lamellar Headguard", "=ds=", "#HONOR:105#", ""};
				{ 26, 29605, "", "=q3=Champion's Lamellar Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 27, 29602, "", "=q3=Legionnaire's Lamellar Breastplate", "=ds=", "#HONOR:105#", ""};
				{ 28, 29600, "", "=q3=Blood Guard's Lamellar Gauntlets", "=ds=", "#HONOR:60#", ""};
				{ 29, 29603, "", "=q3=Legionnaire's Lamellar Leggings", "=ds=", "#HONOR:105#", ""};
				{ 30, 29601, "", "=q3=Blood Guard's Lamellar Sabatons", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PALADIN"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Priest"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea5#", "=q5=#pvps1#"};
				{ 2, 17602, "", "=q4=Field Marshal's Headdress", "=ds=", "#HONOR:125#", ""};
				{ 3, 17604, "", "=q4=Field Marshal's Satin Mantle", "=ds=", "#HONOR:70#", ""};
				{ 4, 17605, "", "=q4=Field Marshal's Satin Vestments", "=ds=", "#HONOR:125#", ""};
				{ 5, 17608, "", "=q4=Marshal's Satin Gloves", "=ds=", "#HONOR:70#", ""};
				{ 6, 17603, "", "=q4=Marshal's Satin Pants", "=ds=", "#HONOR:125#", ""};
				{ 7, 17607, "", "=q4=Marshal's Satin Sandals", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra5#", "=q5=#pvps2#"};
				{ 10, 23316, "", "=q3=Lieutenant Commander's Satin Hood", "=ds=", "#HONOR:105#", ""};
				{ 11, 23317, "", "=q3=Lieutenant Commander's Satin Mantle", "=ds=", "#HONOR:85#", ""};
				{ 12, 23303, "", "=q3=Knight-Captain's Satin Tunic", "=ds=", "#HONOR:105#", ""};
				{ 13, 23288, "", "=q3=Knight-Lieutenant's Satin Handwraps", "=ds=", "#HONOR:60#", ""};
				{ 14, 23302, "", "=q3=Knight-Captain's Satin Legguards", "=ds=", "#HONOR:105#", ""};
				{ 15, 23289, "", "=q3=Knight-Lieutenant's Satin Walkers", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh4#", "=q5=#pvps1#"};
				{ 17, 17623, "", "=q4=Warlord's Satin Cowl", "=ds=", "#HONOR:125#", ""};
				{ 18, 17622, "", "=q4=Warlord's Satin Mantle", "=ds=", "#HONOR:70#", ""};
				{ 19, 17624, "", "=q4=Warlord's Satin Robes", "=ds=", "#HONOR:125#", ""};
				{ 20, 17620, "", "=q4=General's Satin Gloves", "=ds=", "#HONOR:70#", ""};
				{ 21, 17625, "", "=q4=General's Satin Leggings", "=ds=", "#HONOR:125#", ""};
				{ 22, 17618, "", "=q4=General's Satin Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh4#", "=q5=#pvps2#"};
				{ 25, 23261, "", "=q3=Champion's Satin Hood", "=ds=", "#HONOR:105#", ""};
				{ 26, 23262, "", "=q3=Champion's Satin Mantle", "=ds=", "#HONOR:85#", ""};
				{ 27, 22885, "", "=q3=Legionnaire's Satin Tunic", "=ds=", "#HONOR:105#", ""};
				{ 28, 22869, "", "=q3=Blood Guard's Satin Handwraps", "=ds=", "#HONOR:60#", ""};
				{ 29, 22882, "", "=q3=Legionnaire's Satin Legguards", "=ds=", "#HONOR:105#", ""};
				{ 30, 22859, "", "=q3=Blood Guard's Satin Walkers", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["PRIEST"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Rogue"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea6#", "=q5=#pvps1#"};
				{ 2, 16455, "", "=q4=Field Marshal's Leather Mask", "=ds=", "#HONOR:125#", ""};
				{ 3, 16457, "", "=q4=Field Marshal's Leather Epaulets", "=ds=", "#HONOR:70#", ""};
				{ 4, 16453, "", "=q4=Field Marshal's Leather Chestpiece", "=ds=", "#HONOR:125#", ""};
				{ 5, 16454, "", "=q4=Marshal's Leather Handgrips", "=ds=", "#HONOR:70#", ""};
				{ 6, 16456, "", "=q4=Marshal's Leather Leggings", "=ds=", "#HONOR:125#", ""};
				{ 7, 16446, "", "=q4=Marshal's Leather Footguards", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra6#", "=q5=#pvps2#"};
				{ 10, 23312, "", "=q3=Lieutenant Commander's Leather Helm", "=ds=", "#HONOR:105#", ""};
				{ 11, 23313, "", "=q3=Lieutenant Commander's Leather Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 12, 23298, "", "=q3=Knight-Captain's Leather Chestpiece", "=ds=", "#HONOR:105#", ""};
				{ 13, 23284, "", "=q3=Knight-Lieutenant's Leather Grips", "=ds=", "#HONOR:60#", ""};
				{ 14, 23299, "", "=q3=Knight-Captain's Leather Legguards", "=ds=", "#HONOR:105#", ""};
				{ 15, 23285, "", "=q3=Knight-Lieutenant's Leather Walkers", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh5#", "=q5=#pvps1#"};
				{ 17, 16561, "", "=q4=Warlord's Leather Helm", "=ds=", "#HONOR:125#", ""};
				{ 18, 16562, "", "=q4=Warlord's Leather Spaulders", "=ds=", "#HONOR:70#", ""};
				{ 19, 16563, "", "=q4=Warlord's Leather Breastplate", "=ds=", "#HONOR:125#", ""};
				{ 20, 16560, "", "=q4=General's Leather Mitts", "=ds=", "#HONOR:70#", ""};
				{ 21, 16564, "", "=q4=General's Leather Legguards", "=ds=", "#HONOR:125#", ""};
				{ 22, 16558, "", "=q4=General's Leather Treads", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh5#", "=q5=#pvps2#"};
				{ 25, 23257, "", "=q3=Champion's Leather Helm", "=ds=", "#HONOR:105#", ""};
				{ 26, 23258, "", "=q3=Champion's Leather Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 27, 22879, "", "=q3=Legionnaire's Leather Chestpiece", "=ds=", "#HONOR:105#", ""};
				{ 28, 22864, "", "=q3=Blood Guard's Leather Grips", "=ds=", "#HONOR:60#", ""};
				{ 29, 22880, "", "=q3=Legionnaire's Leather Legguards", "=ds=", "#HONOR:105#", ""};
				{ 30, 22856, "", "=q3=Blood Guard's Leather Walkers", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["ROGUE"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Shaman"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea9#", "=q5=#pvps1#"};
				{ 2, 29610, "", "=q4=Field Marshal's Mail Helm", "=ds=", "#HONOR:125#", ""};
				{ 3, 29611, "", "=q4=Field Marshal's Mail Spaulders", "=ds=", "#HONOR:70#", ""};
				{ 4, 29609, "", "=q4=Field Marshal's Mail Armor", "=ds=", "#HONOR:125#", ""};
				{ 5, 29607, "", "=q4=Marshal's Mail Gauntlets", "=ds=", "#HONOR:70#", ""};
				{ 6, 29608, "", "=q4=Marshal's Mail Leggings", "=ds=", "#HONOR:125#", ""};
				{ 7, 29606, "", "=q4=Marshal's Mail Boots", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra9#", "=q5=#pvps2#"};
				{ 10, 29598, "", "=q3=Lieutenant Commander's Mail Headguard", "=ds=", "#HONOR:105#", ""};
				{ 11, 29599, "", "=q3=Lieutenant Commander's Mail Pauldrons", "=ds=", "#HONOR:85#", ""};
				{ 12, 29596, "", "=q3=Knight-Captain's Mail Hauberk", "=ds=", "#HONOR:105#", ""};
				{ 13, 29595, "", "=q3=Knight-Lieutenant's Mail Vices", "=ds=", "#HONOR:60#", ""};
				{ 14, 29597, "", "=q3=Knight-Captain's Mail Legguards", "=ds=", "#HONOR:105#", ""};
				{ 15, 29594, "", "=q3=Knight-Lieutenant's Mail Greaves", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh6#", "=q5=#pvps1#"};
				{ 17, 16578, "", "=q4=Warlord's Mail Helm", "=ds=", "#HONOR:125#", ""};
				{ 18, 16580, "", "=q4=Warlord's Mail Spaulders", "=ds=", "#HONOR:70#", ""};
				{ 19, 16577, "", "=q4=Warlord's Mail Armor", "=ds=", "#HONOR:125#", ""};
				{ 20, 16574, "", "=q4=General's Mail Gauntlets", "=ds=", "#HONOR:70#", ""};
				{ 21, 16579, "", "=q4=General's Mail Leggings", "=ds=", "#HONOR:125#", ""};
				{ 22, 16573, "", "=q4=General's Mail Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh6#", "=q5=#pvps2#"};
				{ 25, 23259, "", "=q3=Champion's Mail Headguard", "=ds=", "#HONOR:105#", ""};
				{ 26, 23260, "", "=q3=Champion's Mail Pauldrons", "=ds=", "#HONOR:85#", ""};
				{ 27, 22876, "", "=q3=Legionnaire's Mail Hauberk", "=ds=", "#HONOR:105#", ""};
				{ 28, 22867, "", "=q3=Blood Guard's Mail Vices", "=ds=", "#HONOR:60#", ""};
				{ 29, 22887, "", "=q3=Legionnaire's Mail Legguards", "=ds=", "#HONOR:105#", ""};
				{ 30, 22857, "", "=q3=Blood Guard's Mail Greaves", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Warlock"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea7#", "=q5=#pvps1#"};
				{ 2, 17578, "", "=q4=Field Marshal's Coronal", "=ds=", "#HONOR:125#", ""};
				{ 3, 17580, "", "=q4=Field Marshal's Dreadweave Shoulders", "=ds=", "#HONOR:70#", ""};
				{ 4, 17581, "", "=q4=Field Marshal's Dreadweave Robe", "=ds=", "#HONOR:125#", ""};
				{ 5, 17584, "", "=q4=Marshal's Dreadweave Gloves", "=ds=", "#HONOR:70#", ""};
				{ 6, 17579, "", "=q4=Marshal's Dreadweave Leggings", "=ds=", "#HONOR:125#", ""};
				{ 7, 17583, "", "=q4=Marshal's Dreadweave Boots", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra7#", "=q5=#pvps2#"};
				{ 10, 23310, "", "=q3=Lieutenant Commander's Dreadweave Cowl", "=ds=", "#HONOR:105#", ""};
				{ 11, 23311, "", "=q3=Lieutenant Commander's Dreadweave Spaulders", "=ds=", "#HONOR:85#", ""};
				{ 12, 23297, "", "=q3=Knight-Captain's Dreadweave Tunic", "=ds=", "#HONOR:105#", ""};
				{ 13, 23282, "", "=q3=Knight-Lieutenant's Dreadweave Handwraps", "=ds=", "#HONOR:60#", ""};
				{ 14, 23296, "", "=q3=Knight-Captain's Dreadweave Legguards", "=ds=", "#HONOR:105#", ""};
				{ 15, 23283, "", "=q3=Knight-Lieutenant's Dreadweave Walkers", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh7#", "=q5=#pvps1#"};
				{ 17, 17591, "", "=q4=Warlord's Dreadweave Hood", "=ds=", "#HONOR:125#", ""};
				{ 18, 17590, "", "=q4=Warlord's Dreadweave Mantle", "=ds=", "#HONOR:70#", ""};
				{ 19, 17592, "", "=q4=Warlord's Dreadweave Robe", "=ds=", "#HONOR:125#", ""};
				{ 20, 17588, "", "=q4=General's Dreadweave Gloves", "=ds=", "#HONOR:70#", ""};
				{ 21, 17593, "", "=q4=General's Dreadweave Pants", "=ds=", "#HONOR:125#", ""};
				{ 22, 17586, "", "=q4=General's Dreadweave Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh7#", "=q5=#pvps2#"};
				{ 25, 23255, "", "=q3=Champion's Dreadweave Cowl", "=ds=", "#HONOR:105#", ""};
				{ 26, 23256, "", "=q3=Champion's Dreadweave Spaulders", "=ds=", "#HONOR:85#", ""};
				{ 27, 22884, "", "=q3=Legionnaire's Dreadweave Tunic", "=ds=", "#HONOR:105#", ""};
				{ 28, 22865, "", "=q3=Blood Guard's Dreadweave Handwraps", "=ds=", "#HONOR:60#", ""};
				{ 29, 22881, "", "=q3=Legionnaire's Dreadweave Legguards", "=ds=", "#HONOR:105#", ""};
				{ 30, 22855, "", "=q3=Blood Guard's Dreadweave Walkers", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"],
			module = moduleName, menu = "PVP60SET",
		};
	}

	AtlasLoot_Data["PVP60Warrior"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_BannerPVP_02", "=q6=#pvpea8#", "=q5=#pvps1#"};
				{ 2, 16478, "", "=q4=Field Marshal's Plate Helm", "=ds=", "#HONOR:125#", ""};
				{ 3, 16480, "", "=q4=Field Marshal's Plate Shoulderguards", "=ds=", "#HONOR:70#", ""};
				{ 4, 16477, "", "=q4=Field Marshal's Plate Armor", "=ds=", "#HONOR:125#", ""};
				{ 5, 16484, "", "=q4=Marshal's Plate Gauntlets", "=ds=", "#HONOR:70#", ""};
				{ 6, 16479, "", "=q4=Marshal's Plate Legguards", "=ds=", "#HONOR:125#", ""};
				{ 7, 16483, "", "=q4=Marshal's Plate Boots", "=ds=", "#HONOR:70#", ""};
				{ 9, 0, "INV_BannerPVP_02", "=q6=#pvpra8#", "=q5=#pvps2#"};
				{ 10, 23314, "", "=q3=Lieutenant Commander's Plate Helm", "=ds=", "#HONOR:105#", ""};
				{ 11, 23315, "", "=q3=Lieutenant Commander's Plate Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 12, 23300, "", "=q3=Knight-Captain's Plate Hauberk", "=ds=", "#HONOR:105#", ""};
				{ 13, 23286, "", "=q3=Knight-Lieutenant's Plate Gauntlets", "=ds=", "#HONOR:60#", ""};
				{ 14, 23301, "", "=q3=Knight-Captain's Plate Leggings", "=ds=", "#HONOR:105#", ""};
				{ 15, 23287, "", "=q3=Knight-Lieutenant's Plate Greaves", "=ds=", "#HONOR:85#", ""};
				{ 16, 0, "INV_BannerPVP_01", "=q6=#pvpeh8#", "=q5=#pvps1#"};
				{ 17, 16542, "", "=q4=Warlord's Plate Headpiece", "=ds=", "#HONOR:125#", ""};
				{ 18, 16544, "", "=q4=Warlord's Plate Shoulders", "=ds=", "#HONOR:70#", ""};
				{ 19, 16541, "", "=q4=Warlord's Plate Armor", "=ds=", "#HONOR:125#", ""};
				{ 20, 16548, "", "=q4=General's Plate Gauntlets", "=ds=", "#HONOR:70#", ""};
				{ 21, 16543, "", "=q4=General's Plate Leggings", "=ds=", "#HONOR:125#", ""};
				{ 22, 16545, "", "=q4=General's Plate Boots", "=ds=", "#HONOR:70#", ""};
				{ 24, 0, "INV_BannerPVP_01", "=q6=#pvprh8#", "=q5=#pvps2#"};
				{ 25, 23244, "", "=q3=Champion's Plate Helm", "=ds=", "#HONOR:105#", ""};
				{ 26, 23243, "", "=q3=Champion's Plate Shoulders", "=ds=", "#HONOR:85#", ""};
				{ 27, 22872, "", "=q3=Legionnaire's Plate Hauberk", "=ds=", "#HONOR:105#", ""};
				{ 28, 22868, "", "=q3=Blood Guard's Plate Gauntlets", "=ds=", "#HONOR:60#", ""};
				{ 29, 22873, "", "=q3=Legionnaire's Plate Leggings", "=ds=", "#HONOR:105#", ""};
				{ 30, 22858, "", "=q3=Blood Guard's Plate Greaves", "=ds=", "#HONOR:85#", ""};
			};
		};
		info = {
			name = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"],
			module = moduleName, menu = "PVP60SET",
		};
	}

		----------------------------
		--- PvP Level 60 Weapons ---
		----------------------------

	AtlasLoot_Data["PVP60Weapons"] = {
		["Normal_A"] = {
			{
				{ 1, 18843, "", "=q4=Grand Marshal's Right Hand Blade", "=ds=#h1#, #w13#", "#HONOR:185#", ""};
				{ 2, 18847, "", "=q4=Grand Marshal's Left Hand Blade", "=ds=#h1#, #w13#", "#HONOR:185#", ""};
				{ 4, 23451, "", "=q4=Grand Marshal's Mageblade", "=ds=#h1#, #w4#", "#HONOR:185#", ""};
				{ 5, 18838, "", "=q4=Grand Marshal's Dirk", "=ds=#h1#, #w4#", "#HONOR:185#", ""};
				{ 7, 12584, "", "=q4=Grand Marshal's Longsword", "=ds=#h1#, #w10#", "#HONOR:185#", ""};
				{ 8, 23456, "", "=q4=Grand Marshal's Swiftblade", "=ds=#h1#, #w10#", "#HONOR:185#", ""};
				{ 10, 18827, "", "=q4=Grand Marshal's Handaxe", "=ds=#h1#, #w1#", "#HONOR:185#", ""};
				{ 12, 23454, "", "=q4=Grand Marshal's Warhammer", "=ds=#h1#, #w6#", "#HONOR:185#", ""};
				{ 13, 18865, "", "=q4=Grand Marshal's Punisher", "=ds=#h1#, #w6#", "#HONOR:185#", ""};
				{ 15, 18869, "", "=q4=Grand Marshal's Glaive", "=ds=#w7#", "#HONOR:290#", ""};				
				{ 16, 18876, "", "=q4=Grand Marshal's Claymore", "=ds=#h2#, #w10#", "#HONOR:290#", ""};
				{ 17, 18830, "", "=q4=Grand Marshal's Sunderer", "=ds=#h2#, #w1#", "#HONOR:290#", ""};
				{ 18, 18867, "", "=q4=Grand Marshal's Battle Hammer", "=ds=#h2#, #w6#", "#HONOR:290#", ""};
				{ 19, 23455, "", "=q4=Grand Marshal's Demolisher", "=ds=#h2#, #w6#", "#HONOR:290#", ""};
				{ 21, 18873, "", "=q4=Grand Marshal's Stave", "=ds=#w9#", "#HONOR:290#", ""};
				{ 23, 18825, "", "=q4=Grand Marshal's Aegis", "=ds=#w8#", "#HONOR:185#", ""};
				{ 25, 18833, "", "=q4=Grand Marshal's Bullseye", "=ds=#w2#", "#HONOR:185#", ""};
				{ 26, 18836, "", "=q4=Grand Marshal's Repeater", "=ds=#w3#", "#HONOR:185#", ""};
				{ 27, 18855, "", "=q4=Grand Marshal's Hand Cannon", "=ds=#w5#", "#HONOR:185#", ""};
				{ 29, 23452, "", "=q4=Grand Marshal's Tome of Power", "=ds=#s15#", "#HONOR:185#", ""};
				{ 30, 23453, "", "=q4=Grand Marshal's Tome of Restoration", "=ds=#s15#", "#HONOR:185#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 18844, "", "=q4=High Warlord's Right Claw", "=ds=#h1#, #w13#", "#HONOR:185#", ""};
				{ 2, 18848, "", "=q4=High Warlord's Razor Claw", "=ds=#h1#, #w13#", "#HONOR:185#", ""};
				{ 4, 23466, "", "=q4=High Warlord's Spellblade", "=ds=#h1#, #w4#", "#HONOR:185#", ""};
				{ 5, 18840, "", "=q4=High Warlord's Razor", "=ds=#h1#, #w4#", "#HONOR:185#", ""};
				{ 7, 16345, "", "=q4=High Warlord's Blade", "=ds=#h1#, #w10#", "#HONOR:185#", ""};
				{ 8, 23467, "", "=q4=High Warlord's Quickblade", "=ds=#h1#, #w10#", "#HONOR:185#", ""};
				{ 10, 18828, "", "=q4=High Warlord's Cleaver", "=ds=#h1#, #w1#", "#HONOR:185#", ""};
				{ 12, 23464, "", "=q4=High Warlord's Battle Mace", "=ds=#h1#, #w6#", "#HONOR:185#", ""};
				{ 13, 18866, "", "=q4=High Warlord's Bludgeon", "=ds=#h1#, #w6#", "#HONOR:185#", ""};
				{ 15, 18871, "", "=q4=High Warlord's Pig Sticker", "=ds=#w7#", "#HONOR:290#", ""};
				{ 16, 18877, "", "=q4=High Warlord's Greatsword", "=ds=#h2#, #w10#", "#HONOR:290#", ""};
				{ 17, 18831, "", "=q4=High Warlord's Battle Axe", "=ds=#h2#, #w1#", "#HONOR:290#", ""};
				{ 18, 18868, "", "=q4=High Warlord's Pulverizer", "=ds=#h2#, #w6#", "#HONOR:290#", ""};
				{ 19, 23465, "", "=q4=High Warlord's Destroyer", "=ds=#h2#, #w6#", "#HONOR:290#", ""};
				{ 21, 18874, "", "=q4=High Warlord's War Staff", "=ds=#w9#", "#HONOR:290#", ""};
				{ 23, 18826, "", "=q4=High Warlord's Shield Wall", "=ds=#w8#", "#HONOR:185#", ""};
				{ 25, 18835, "", "=q4=High Warlord's Recurve", "=ds=#w2#", "#HONOR:185#", ""};
				{ 26, 18837, "", "=q4=High Warlord's Crossbow", "=ds=#w3#", "#HONOR:185#", ""};
				{ 27, 18860, "", "=q4=High Warlord's Street Sweeper", "=ds=#w5#", "#HONOR:185#", ""};
				{ 29, 23468, "", "=q4=High Warlord's Tome of Destruction", "=ds=#s15#", "#HONOR:185#", ""};
				{ 30, 23469, "", "=q4=High Warlord's Tome of Mending", "=ds=#s15#", "#HONOR:185#", ""};
			};
		};
		info = {
			name = AL["PvP Weapons"].." "..AL["Level 60"].." - "..AL["Grand Marshal"],
			module = moduleName, menu = "PVPMENU3",
		};
	}

		--------------------------------
		--- PvP Level 60 Accessories ---
		--------------------------------

	AtlasLoot_Data["PVP60Accessories"] = {
		["Normal_A"] = {
			{
				{ 1, 29465, "", "=q4=Black Battlestrider", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 2, 29467, "", "=q4=Black War Ram", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 3, 29468, "", "=q4=Black War Steed Bridle", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 4, 29471, "", "=q4=Reins of the Black War Tiger", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 5, 35906, "", "=q4=Reins of the Black War Elekk", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 7, 18863, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 8, 18856, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 9, 18859, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 10, 18864, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 11, 18862, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 12, 18857, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 13, 29593, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 14, 18858, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 15, 18854, "", "=q3=Insignia of the Alliance", "=ds=#s14#", "#HONOR:55#", ""};
				{ 16, 15196, "", "=q1=Private's Tabard", "=ds=#s7#", "#HONOR:50#", ""};
				{ 17, 15198, "", "=q1=Knight's Colors", "=ds=#s7#", "#HONOR:100#", ""};
				{ 18, 18606, "", "=q1=Alliance Battle Standard", "=ds=#e14#", "#HONOR:500#", ""};
				{ 20, 18839, "", "=q1=Combat Healing Potion", "=ds=#e2#", "10 #silver# #HONOR:1#", ""};
				{ 21, 18841, "", "=q1=Combat Mana Potion", "=ds=#e2#", "10 #silver# #HONOR:1#", ""};
				{ 22, 32455, "", "=q1=Star's Lament", "=ds=#e4#", "12 #silver# #HONOR:1#", ""};
			};
			{
				{ 1, 18457, "", "=q3=Sergeant Major's Silk Cuffs", "=ds=#s8#, #a1#", "#HONOR:45#", ""};
				{ 2, 18456, "", "=q3=Sergeant Major's Silk Cuffs", "=ds=#s8#, #a1#", "#HONOR:55#", ""};
				{ 4, 18455, "", "=q3=Sergeant Major's Dragonhide Armsplints", "=ds=#s8#, #a2#", "#HONOR:45#", ""};
				{ 5, 18454, "", "=q3=Sergeant Major's Dragonhide Armsplints", "=ds=#s8#, #a2#", "#HONOR:55#", ""};
				{ 7, 18453, "", "=q3=Sergeant Major's Leather Armsplints", "=ds=#s8#, #a3#", "#HONOR:45#", ""};
				{ 8, 18452, "", "=q3=Sergeant Major's Leather Armsplints", "=ds=#s8#, #a3#", "#HONOR:55#", ""};
				{ 10, 18449, "", "=q3=Sergeant Major's Chain Armguards", "=ds=#s8#, #a3#", "#HONOR:45#", ""};
				{ 11, 18448, "", "=q3=Sergeant Major's Chain Armguards", "=ds=#s8#, #a3#", "#HONOR:55#", ""};
				{ 13, 18447, "", "=q3=Sergeant Major's Plate Wristguards", "=ds=#s8#, #a4#", "#HONOR:45#", ""};
				{ 14, 18445, "", "=q3=Sergeant Major's Plate Wristguards", "=ds=#s8#, #a4#", "#HONOR:55#", ""};
				{ 16, 18440, "", "=q3=Sergeant's Cape", "=ds=#s4#", "#HONOR:40#", ""};
				{ 17, 18441, "", "=q3=Sergeant's Cape", "=ds=#s4#", "#HONOR:45#", ""};
				{ 18, 16342, "", "=q3=Sergeant's Cape", "=ds=#s4#", "#HONOR:55#", ""};
				{ 20, 18442, "", "=q3=Master Sergeant's Insignia", "=ds=#s2#", "#HONOR:40#", ""};
				{ 21, 18444, "", "=q3=Master Sergeant's Insignia", "=ds=#s2#", "#HONOR:45#", ""};
				{ 22, 18443, "", "=q3=Master Sergeant's Insignia", "=ds=#s2#", "#HONOR:55#", ""};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 29466, "", "=q4=Black War Kodo", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 2, 29469, "", "=q4=Horn of the Black War Wolf", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 3, 29470, "", "=q4=Red Skeletal Warhorse", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 4, 29472, "", "=q4=Whistle of the Black War Raptor", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 5, 34129, "", "=q4=Swift Warstrider", "=ds=#e26#", "#HONOR:2000#", ""};
				{ 7, 18853, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 8, 18846, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 9, 18850, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 10, 29592, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 11, 18851, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 12, 18849, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 13, 18845, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 14, 18852, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 15, 18834, "", "=q3=Insignia of the Horde", "=ds=#s14#", "#HONOR:55#", ""};
				{ 16, 15197, "", "=q1=Scout's Tabard", "=ds=#s7#", "#HONOR:50#", ""};
				{ 17, 15199, "", "=q1=Stone Guard's Herald", "=ds=#s7#", "#HONOR:100#", ""};
				{ 18, 18607, "", "=q1=Horde Battle Standard", "=ds=#e14#", "#HONOR:500#", ""};
				{ 20, 18839, "", "=q1=Combat Healing Potion", "=ds=#e2#", "10 #silver# #HONOR:1#", ""};
				{ 21, 18841, "", "=q1=Combat Mana Potion", "=ds=#e2#", "10 #silver# #HONOR:1#", ""};
				{ 22, 32455, "", "=q1=Star's Lament", "=ds=#e4#", "12 #silver# #HONOR:1#", ""};
			};
			{
				{ 1, 18437, "", "=q3=First Sergeant's Silk Cuffs", "=ds=#s8#, #a1#", "#HONOR:45#", ""};
				{ 2, 16486, "", "=q3=First Sergeant's Silk Cuffs", "=ds=#s8#, #a1#", "#HONOR:55#", ""};
				{ 4, 18436, "", "=q3=First Sergeant's Dragonhide Armguards", "=ds=#s8#, #a1#", "#HONOR:45#", ""};
				{ 5, 18434, "", "=q3=First Sergeant's Dragonhide Armguards", "=ds=#s8#, #a1#", "#HONOR:55#", ""};
				{ 7, 18435, "", "=q3=First Sergeant's Leather Armguards", "=ds=#s8#, #a2#", "#HONOR:45#", ""};
				{ 8, 16497, "", "=q3=First Sergeant's Leather Armguards", "=ds=#s8#, #a2#", "#HONOR:55#", ""};
				{ 10, 18432, "", "=q3=First Sergeant's Mail Wristguards", "=ds=#s8#, #a3#", "#HONOR:45#", ""};
				{ 11, 16532, "", "=q3=First Sergeant's Mail Wristguards", "=ds=#s8#, #a3#", "#HONOR:55#", ""};
				{ 13, 18430, "", "=q3=First Sergeant's Plate Bracers", "=ds=#s8#, #a4#", "#HONOR:45#", ""};
				{ 14, 18429, "", "=q3=First Sergeant's Plate Bracers", "=ds=#s8#, #a4#", "#HONOR:55#", ""};
				{ 16, 18427, "", "=q3=Sergeant's Cloak", "=ds=#s4#", "#HONOR:40#", ""};
				{ 17, 16341, "", "=q3=Sergeant's Cloak", "=ds=#s4#", "#HONOR:45#", ""};
				{ 18, 18461, "", "=q3=Sergeant's Cloak", "=ds=#s4#", "#HONOR:55#", ""};
				{ 20, 15200, "", "=q3=Senior Sergeant's Insignia", "=ds=#s2#", "#HONOR:40#", ""};
				{ 21, 18428, "", "=q3=Senior Sergeant's Insignia", "=ds=#s2#", "#HONOR:45#", ""};
				{ 22, 16335, "", "=q3=Senior Sergeant's Insignia", "=ds=#s2#", "#HONOR:55#", ""};
			};
		};
		info = {
			name = AL["PvP Accessories"].." "..AL["Level 60"],
			module = moduleName, menu = "PVPMENU3",
		};
	}

	----------------
	--- Factions ---
	----------------

		------------
		--- Misc ---
		------------

	AtlasLoot_Data["MiscFactions"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_jewelry_stormpiketrinket_05", "=q6="..ALIL["Stormpike Guard"], "=q5="..FACTION_ALLIANCE};
				{ 2, 17904, "", "=q4=Stormpike Insignia Rank 6", "=ds=#s14#, =q1=#r5#"};
				{ 3, 17903, "", "=q3=Stormpike Insignia Rank 5", "=ds=#s14#, =q1=#r5#"};
				{ 4, 17902, "", "=q3=Stormpike Insignia Rank 4", "=ds=#s14#, =q1=#r4#"};
				{ 5, 17901, "", "=q2=Stormpike Insignia Rank 3", "=ds=#s14#, =q1=#r3#"};
				{ 6, 17900, "", "=q2=Stormpike Insignia Rank 2", "=ds=#s14#, =q1=#r2#"};
				{ 7, 17691, "", "=q2=Stormpike Insignia Rank 1", "=ds=#s14#, =q1=#r1#"};
				{ 9, 0, "ability_warrior_rallyingcry", "=q6="..ALIL["The League of Arathor"], "=ds=#r5#, =q5="..FACTION_ALLIANCE};
				{ 10, 20132, "", "=q1=Arathor Battle Tabard", "=ds=#s7#", "#HONOR:2679#"};
				{ 12, 0, "Ability_Mount_PinkTiger", "=q6="..ALIL["Wintersaber Trainers"], "=ds=#r5#, =q5="..FACTION_ALLIANCE};
				{ 13, 13086, "", "=q4=Reins of the Winterspring Frostsaber", "=ds=#e26#", "=q1=#m4#: #QUESTID:29034#"};
				{ 16, 0, "inv_jewelry_frostwolftrinket_05", "=q6="..ALIL["Frostwolf Clan"], "=q5="..FACTION_HORDE};
				{ 17, 17909, "", "=q4=Frostwolf Insignia Rank 6", "=ds=#s14#, =q1=#r5#"};
				{ 18, 17908, "", "=q3=Frostwolf Insignia Rank 5", "=ds=#s14#, =q1=#r5#"};
				{ 19, 17907, "", "=q3=Frostwolf Insignia Rank 4", "=ds=#s14#, =q1=#r4#"};
				{ 20, 17906, "", "=q2=Frostwolf Insignia Rank 3", "=ds=#s14#, =q1=#r3#"};
				{ 21, 17905, "", "=q2=Frostwolf Insignia Rank 2", "=ds=#s14#, =q1=#r2#"};
				{ 22, 17690, "", "=q2=Frostwolf Insignia Rank 1", "=ds=#s14#, =q1=#r1#"};
				{ 24, 0, "spell_shadow_psychichorrors", "=q6="..ALIL["The Defilers"], "=ds=#r5#, =q5="..FACTION_HORDE};
				{ 25, 20131, "", "=q1=Battle Tabard of the Defilers", "=ds=#s7#", "#HONOR:2679#"};
			};
		};
		info = {
			name = AL["Factions"].." - "..AL["Classic WoW"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		-------------------
		--- Argent Dawn ---
		-------------------

	AtlasLoot_Data["ArgentDawn"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_jewelry_talisman_07", "=q6=#r2#", ""};
				{ 2, 13724, "", "=q1=Enriched Manna Biscuit", "=ds=#e3#", "60 #silver#", amount = 5};
				{ 4, 0, "inv_jewelry_talisman_07", "=q6=#r3#", ""};
				{ 5, 13482, "", "=q2=Recipe: Transmute Air to Fire", "=ds=#p1# (275)", "1 #gold# 50 #silver#"};
				{ 6, 19203, "", "=q1=Plans: Girdle of the Dawn", "=ds=#p2# (290)", "2 #gold# 20 #silver#"};
				{ 7, 19446, "", "=q1=Formula: Enchant Bracer - Mana Regeneration", "=ds=#p4# (290)", "3 #gold#"};
				{ 8, 19442, "", "=q1=Formula: Powerful Anti-Venom", "=ds=#p6# (300)", "10 #gold#"};
				{ 9, 19328, "", "=q1=Pattern: Dawn Treaders", "=ds=#p7# (290)", "2 #gold# 20 #silver#"};
				{ 10, 19216, "", "=q1=Pattern: Argent Boots", "=ds=#p8# (290)", "2 #gold# 20 #silver#"};
				{ 16, 0, "inv_jewelry_talisman_07", "=q6=#r4#", ""};
				{ 17, 18171, "", "=q2=Arcane Mantle of the Dawn", "=ds=#s3# #e17#", "10 #gold#"};
				{ 18, 18169, "", "=q2=Flame Mantle of the Dawn", "=ds=#s3# #e17#", "10 #gold#"};
				{ 19, 18170, "", "=q2=Frost Mantle of the Dawn", "=ds=#s3# #e17#", "10 #gold#"};
				{ 20, 18172, "", "=q2=Nature Mantle of the Dawn", "=ds=#s3# #e17#", "10 #gold#"};
				{ 21, 18173, "", "=q2=Shadow Mantle of the Dawn", "=ds=#s3# #e17#", "10 #gold#"};
				{ 22, 19205, "", "=q1=Plans: Gloves of the Dawn", "=ds=#p2# (300)", "4 #gold#"};
				{ 23, 19447, "", "=q1=Formula: Enchant Bracer - Healing", "=ds=#p4# (300)", "6 #gold#"};
				{ 24, 19329, "", "=q1=Pattern: Golden Mantle of the Dawn", "=ds=#p7# (300)", "4 #gold#"};
				{ 25, 19217, "", "=q1=Pattern: Argent Shoulders", "=ds=#p8# (300)", "4 #gold#"};
				{ 26, 13810, "", "=q1=Blessed Sunfruit", "=ds=#e3#", "60 #silver#", amount = 5};
				{ 27, 13813, "", "=q1=Blessed Sunfruit Juice", "=ds=#e4#", "60 #silver#", amount = 5};
				{ 29, 0, "inv_jewelry_talisman_07", "=q6=#r5#", ""};
				{ 30, 18182, "", "=q2=Chromatic Mantle of the Dawn", "=ds=#s3# #e17#", "40 #gold#"};
			};
		};
		info = {
			name = ALIL["Argent Dawn"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		-------------------------
		--- Bilgewater Cartel ---
		-------------------------

	AtlasLoot_Data["BilgewaterCartel"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tabard_kezan", "=q6="..ALIL["Bilgewater Cartel"], "=q5=#r1#"};
				{ 2, 64884, "", "=q1=Bilgewater Cartel Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tabard_kezan", "=q6="..ALIL["Bilgewater Cartel"], "=q5=#r4#"};
				{ 5, 67525, "", "=q2=Bilgewater Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tabard_kezan", "=q6="..ALIL["Bilgewater Cartel"], "=q5=#r5#"};
				{ 8, 64906, "", "=q3=Bilgewater Cape", "=ds=#s4#", "3 #gold# 62 #silver# 2 #copper#"};
				{ 9, 64907, "", "=q3=Bilgewater Mantle", "=ds=#s4#", "3 #gold# 63 #silver# 31 #copper#"};
				{ 10, 64905, "", "=q3=Bilgewater Shroud", "=ds=#s4#", "3 #gold# 60 #silver# 78 #copper#"};
				{ 16, 62462, "", "=q4=Goblin Turbo-Trike Key", "=ds=#e26#", "10 #gold#"};
				{ 17, 62461, "", "=q3=Goblin Trike Key", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Bilgewater Cartel"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		----------------------------
		--- Bloodsail Buccaneers ---
		----------------------------

	AtlasLoot_Data["BloodsailBuccaneers"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Helmet_66", "=q6="..ALIL["Bloodsail Buccaneers"], "=q5=#r1# / #QUESTID:9272#"};
				{ 2, 22742, "", "=q1=Bloodsail Shirt", "=ds=#s5#, #a1#"};
				{ 3, 22743, "", "=q1=Bloodsail Sash", "=ds=#s10#, #a1#"};
				{ 4, 22745, "", "=q1=Bloodsail Pants", "=ds=#s11#, #a1#"};
				{ 5, 22744, "", "=q1=Bloodsail Boots", "=ds=#s12#, #a1#"};
				{ 16, 0, "INV_Helmet_66", "=q6="..ALIL["Bloodsail Buccaneers"], "=q5=#r2# / #QUESTID:4621#"};
				{ 17, 12185, "", "=q2=Bloodsail Admiral's Hat", "=ds=#s1#, #a1#"};
			};
		};
		info = {
			name = ALIL["Bloodsail Buccaneers"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		-------------------------
		--- Brood of Nozdormu ---
		-------------------------

	AtlasLoot_Data["AQBroodRings"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Jewelry_Ring_40", "=q6="..AL["Path of the Conqueror"], "#QUESTID:8747#"};
				{ 2, 21201, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r1#"};
				{ 3, 21202, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r2#"};
				{ 4, 21203, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r3#"};
				{ 5, 21204, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r4#"};
				{ 6, 21205, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r5#"};
				{ 8, 0, "INV_Jewelry_Ring_40", "=q6="..AL["Path of the Invoker"], "#QUESTID:8757#"};
				{ 9, 21206, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r1#"};
				{ 10, 21207, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r2#"};
				{ 11, 21208, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r3#"};
				{ 12, 21209, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r4#"};
				{ 13, 21210, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r5#"};
				{ 16, 0, "INV_Jewelry_Ring_40", "=q6="..AL["Path of the Protector"], "#QUESTID:8747#"};
				{ 17, 21196, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r1#"};
				{ 18, 21197, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r2#"};
				{ 19, 21198, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r3#"};
				{ 20, 21199, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r4#"};
				{ 21, 21200, "", "=q4=Signet Ring of the Bronze Dragonflight", "=ds=#s13#, =q1=#r5#"};
			};
		};
		info = {
			name = ALIL["Brood of Nozdormu"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		-----------------------
		--- Cenarion Circle ---
		-----------------------

	AtlasLoot_Data["CenarionCircle"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_racial_ultravision", "=q6=#r2#", ""};
				{ 2, 22209, "", "=q1=Plans: Heavy Obsidian Belt", "=ds=#p2# (300)", "5 #gold#"};
				{ 3, 22768, "", "=q1=Plans: Ironvine Belt", "=ds=#p2# (300)", "5 #gold#"};
				{ 4, 21952, "", "=q1=Design: Emerald Crown of Destruction", "=ds=#p12# (275)", "1 #gold#"};
				{ 5, 22769, "", "=q1=Pattern: Bramblewood Belt", "=ds=#p7# (300)", "5 #gold#"};
				{ 6, 20509, "", "=q1=Pattern: Sandstalker Bracers", "=ds=#p7# (300)", "4 #gold#"};
				{ 7, 20506, "", "=q1=Pattern: Spitfire Bracers", "=ds=#p7# (300)", "4 #gold#"};
				{ 8, 22772, "", "=q1=Pattern: Sylvan Shoulders", "=ds=#p8# (300)", "5 #gold#"};
				{ 9, 22310, "", "=q1=Pattern: Cenarion Herb Bag", "=ds=#p8# (275)", "2 #gold#"};
				{ 16, 0, "ability_racial_ultravision", "=q6=#r3#", ""};
				{ 17, 22767, "", "=q1=Plans: Ironvine Gloves", "=ds=#p2# (300)", "5 #gold#"};
				{ 18, 22214, "", "=q1=Plans: Light Obsidian Belt", "=ds=#p2# (300)", "5 #gold#"};
				{ 19, 22770, "", "=q1=Pattern: Bramblewood Boots", "=ds=#p7# (300)", "5 #gold#"};
				{ 20, 20510, "", "=q1=Pattern: Sandstalker Gauntlets", "=ds=#p7# (300)", "4 #gold#"};
				{ 21, 20507, "", "=q1=Pattern: Spitfire Gauntlets", "=ds=#p7# (300)", "4 #gold#"};
				{ 22, 22773, "", "=q1=Pattern: Sylvan Crown", "=ds=#p8# (300)", "5 #gold#"};
			};
			{
				{ 1, 0, "ability_racial_ultravision", "=q6=#r4#", ""};
				{ 2, 22766, "", "=q1=Plans: Ironvine Breastplate", "=ds=#p2# (300)", "5 #gold#"};
				{ 3, 22219, "", "=q1=Plans: Jagged Obsidian Shield", "=ds=#p2# (300)", "5 #gold# =q2="..ALIL["Ruins of Ahn'Qiraj"]};
				{ 4, 22771, "", "=q1=Pattern: Bramblewood Helm", "=ds=#p7# (300)", "5 #gold#"};
				{ 5, 20511, "", "=q1=Pattern: Sandstalker Breastplate", "=ds=#p7# (300)", "4 #gold#"};
				{ 6, 20508, "", "=q1=Pattern: Spitfire Breastplate", "=ds=#p7# (300)", "4 #gold#"};
				{ 7, 22683, "", "=q1=Pattern: Gaea's Embrace", "=ds=#p8# (300)", "9 #gold#"};
				{ 8, 22312, "", "=q1=Pattern: Satchel of Cenarius", "=ds=#p8# (300)", "5 #gold#"};
				{ 9, 22774, "", "=q1=Pattern: Sylvan Vest", "=ds=#p8# (300)", "5 #gold#"};
				{ 16, 0, "ability_racial_ultravision", "=q6=#r5#", ""};
				{ 17, 22221, "", "=q1=Plans: Obsidian Mail Tunic", "=ds=#p2# (300)", "8 #gold# =q2="..ALIL["Ruins of Ahn'Qiraj"]};
				{ 18, 20382, "", "=q1=Pattern: Dreamscale Breastplate", "=ds=#p7# (300)", "6 #gold#"};
			};
		};
		info = {
			name = ALIL["Cenarion Circle"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		-----------------
		--- Darnassus ---
		-----------------

	AtlasLoot_Data["Darnassus"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_banner_nightelf", "=q6="..ALIL["Darnassus"], "=q5=#r1#"};
				{ 2, 45579, "", "=q1=Darnassus Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_banner_nightelf", "=q6="..ALIL["Darnassus"], "=q5=#r4#"};
				{ 5, 67526, "", "=q2=Darnassian Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_banner_nightelf", "=q6="..ALIL["Darnassus"], "=q5=#r5#"};
				{ 8, 64887, "", "=q3=Cape of Darnassus", "=ds=#s4#", "3 #gold# 62 #silver# 34 #copper#"};
				{ 9, 64888, "", "=q3=Mantle of Darnassus", "=ds=#s4#", "3 #gold# 29 #silver# 92 #copper#"};
				{ 10, 64886, "", "=q3=Shroud of Darnassus", "=ds=#s4#", "3 #gold# 62 #silver# 9 #copper#"};
				{ 16, 18766, "", "=q4=Reins of the Swift Frostsaber", "=ds=#e26#", "10 #gold#"};
				{ 17, 18767, "", "=q4=Reins of the Swift Mistsaber", "=ds=#e26#", "10 #gold#"};
				{ 18, 18902, "", "=q4=Reins of the Swift Stormsaber", "=ds=#e26#", "10 #gold#"};
				{ 19, 8632, "", "=q3=Reins of the Spotted Frostsaber", "=ds=#e26#", "1 #gold#"};
				{ 20, 47100, "", "=q3=Reins of the Striped Dawnsaber", "=ds=#e26#", "1 #gold#"};
				{ 21, 8631, "", "=q3=Reins of the Striped Frostsaber", "=ds=#e26#", "1 #gold#"};
				{ 22, 8629, "", "=q3=Reins of the Striped Nightsaber", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Darnassus"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		------------------------
		--- Darkspear Trolls ---
		------------------------

	AtlasLoot_Data["DarkspearTrolls"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_troll", "=q6="..ALIL["Darkspear Trolls"], "=q5=#r1#"};
				{ 2, 45582, "", "=q1=Darkspear Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_troll", "=q6="..ALIL["Darkspear Trolls"], "=q5=#r4#"};
				{ 5, 67536, "", "=q2=Darkspear Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_troll", "=q6="..ALIL["Darkspear Trolls"], "=q5=#r5#"};
				{ 8, 64912, "", "=q3=Darkspear Cape", "=ds=#s4#", "3 #gold# 34 #silver# 98 #copper#"};
				{ 9, 64911, "", "=q3=Darkspear Mantle", "=ds=#s4#", "3 #gold# 33 #silver# 70 #copper#"};
				{ 10, 64913, "", "=q3=Darkspear Shroud", "=ds=#s4#", "3 #gold# 36 #silver# 26 #copper#"};
				{ 16, 18788, "", "=q4=Swift Blue Raptor", "=ds=#e26#", "10 #gold#"};
				{ 17, 18789, "", "=q4=Swift Olive Raptor", "=ds=#e26#", "10 #gold#"};
				{ 18, 18790, "", "=q4=Swift Orange Raptor", "=ds=#e26#", "10 #gold#"};
				{ 19, 8588, "", "=q3=Whistle of the Emerald Raptor", "=ds=#e26#", "1 #gold#"};
				{ 20, 8591, "", "=q3=Whistle of the Turquoise Raptor", "=ds=#e26#", "1 #gold#"};
				{ 21, 8592, "", "=q3=Whistle of the Violet Raptor", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Darkspear Trolls"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		--------------
		--- Exodar ---
		--------------

	AtlasLoot_Data["Exodar"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_draenei", "=q6="..ALIL["Exodar"], "=q5=#r1#"};
				{ 2, 45580, "", "=q1=Exodar Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_draenei", "=q6="..ALIL["Exodar"], "=q5=#r4#"};
				{ 5, 67527, "", "=q2=Exodar Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_draenei", "=q6="..ALIL["Exodar"], "=q5=#r5#"};
				{ 8, 64890, "", "=q3=Cape of Exodar", "=ds=#s4#", "3 #gold# 32 #silver# 48 #copper#"};
				{ 9, 64889, "", "=q3=Mantle of Exodar", "=ds=#s4#", "3 #gold# 31 #silver# 20 #copper#"};
				{ 10, 64891, "", "=q3=Shroud of Exodar", "=ds=#s4#", "3 #gold# 33 #silver# 73 #copper#"};
				{ 16, 29745, "", "=q4=Great Blue Elekk", "=ds=#e26#", "10 #gold#"};
				{ 17, 29746, "", "=q4=Great Green Elekk", "=ds=#e26#", "10 #gold#"};
				{ 18, 29747, "", "=q4=Great Purple Elekk", "=ds=#e26#", "10 #gold#"};
				{ 19, 28481, "", "=q3=Brown Elekk", "=ds=#e26#", "1 #gold#"};
				{ 20, 29744, "", "=q3=Gray Elekk", "=ds=#e26#", "1 #gold#"};
				{ 21, 29743, "", "=q3=Purple Elekk", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Exodar"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		---------------
		--- Gilneas ---
		---------------

	AtlasLoot_Data["Gilneas"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_win_gilneas", "=q6="..ALIL["Gilneas"], "=q5=#r1#"};
				{ 2, 64882, "", "=q1=Gilneas Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "achievement_win_gilneas", "=q6="..ALIL["Gilneas"], "=q5=#r4#"};
				{ 5, 67532, "", "=q2=Gilnean Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "achievement_win_gilneas", "=q6="..ALIL["Gilneas"], "=q5=#r5#"};
				{ 8, 64893, "", "=q3=Cape of Gilneas", "=ds=#s4#", "3 #gold# 36 #silver# 30 #copper#"};
				{ 9, 64892, "", "=q3=Mantle of Gilneas", "=ds=#s4#", "3 #gold# 35 #silver# 2 #copper#"};
				{ 10, 64894, "", "=q3=Shroud of Gilneas", "=ds=#s4#", "3 #gold# 37 #silver# 58 #copper#"};
				{ 16, 73839, "", "=q4=Swift Mountain Horse", "=ds=#e26#", "10 #gold#"};
				{ 17, 73838, "", "=q3=Mountain Horse", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Gilneas"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		------------------
		--- Gnomeregan ---
		------------------

	AtlasLoot_Data["GnomereganRep"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..ALIL["Gnomeregan"], "=q5=#r1#"};
				{ 2, 45578, "", "=q1=Gnomeregan Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..ALIL["Gnomeregan"], "=q5=#r4#"};
				{ 5, 67530, "", "=q2=Gnomeregan Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..ALIL["Gnomeregan"], "=q5=#r5#"};
				{ 8, 64896, "", "=q3=Cape of Gnomeregan", "=ds=#s4#", "3 #gold# 40 #silver# 11 #copper#"};
				{ 9, 64895, "", "=q3=Mantle of Gnomeregan", "=ds=#s4#", "3 #gold# 38 #silver# 83 #copper#"};
				{ 10, 64897, "", "=q3=Shroud of Gnomeregan", "=ds=#s4#", "3 #gold# 41 #silver# 40 #copper#"};
				{ 16, 18772, "", "=q4=Swift Green Mechanostrider", "=ds=#e26#", "10 #gold#"};
				{ 17, 18773, "", "=q4=Swift White Mechanostrider", "=ds=#e26#", "10 #gold#"};
				{ 18, 18774, "", "=q4=Swift Yellow Mechanostrider", "=ds=#e26#", "10 #gold#"};
				{ 19, 8595, "", "=q3=Blue Mechanostrider", "=ds=#e26#", "1 #gold#"};
				{ 20, 13321, "", "=q3=Green Mechanostrider", "=ds=#e26#", "1 #gold#"};
				{ 21, 8563, "", "=q3=Red Mechanostrider", "=ds=#e26#", "1 #gold#"};
				{ 22, 13322, "", "=q3=Unpainted Mechanostrider", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Gnomeregan"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		-----------------------
		--- Huojin Pandaren ---
		-----------------------

	AtlasLoot_Data["HuojinPandaren"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Huojin Pandaren"], "=q5=#r1#"};
				{ 2, 83080, "", "=q1=Huojin Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..ALIL["Huojin Pandaren"], "=q5=#r4#"};
				{ 5, 92070, "", "=q2=Huojin Satchel", "=ds=#e1#", "2 #gold#"};
				{ 16, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Huojin Pandaren"], "=q5=#r5#"};
				{ 17, 87802, "", "=q4=Reins of the Great Black Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 18, 87803, "", "=q4=Reins of the Great Blue Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 19, 87804, "", "=q4=Reins of the Great Brown Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 20, 87801, "", "=q4=Reins of the Great Green Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 21, 87805, "", "=q4=Reins of the Great Purple Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 22, 82811, "", "=q4=Reins of the Great Red Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 23, 87795, "", "=q3=Reins of the Black Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 24, 87796, "", "=q3=Reins of the Blue Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 25, 87797, "", "=q3=Reins of the Brown Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 26, 82765, "", "=q3=Reins of the Green Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 27, 87799, "", "=q3=Reins of the Purple Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 28, 87800, "", "=q3=Reins of the Red Dragon Turtle", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Huojin Pandaren"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		-----------------
		--- Ironforge ---
		-----------------

	AtlasLoot_Data["Ironforge"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_dwarf", "=q6="..ALIL["Ironforge"], "=q5=#r1#"};
				{ 2, 45577, "", "=q1=Ironforge Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_dwarf", "=q6="..ALIL["Ironforge"], "=q5=#r4#"};
				{ 5, 67528, "", "=q2=Ironforge Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_dwarf", "=q6="..ALIL["Ironforge"], "=q5=#r5#"};
				{ 8, 64899, "", "=q3=Cape of Ironforge", "=ds=#s4#", "3 #gold# 43 #silver# 93 #copper#"};
				{ 9, 64900, "", "=q3=Mantle of Ironforge", "=ds=#s4#", "3 #gold# 45 #silver# 21 #copper#"};
				{ 10, 64898, "", "=q3=Shroud of Ironforge", "=ds=#s4#", "3 #gold# 42 #silver# 68 #copper#"};
				{ 16, 18786, "", "=q4=Swift Brown Ram", "=ds=#e26#", "10 #gold#"};
				{ 17, 18787, "", "=q4=Swift Gray Ram", "=ds=#e26#", "10 #gold#"};
				{ 18, 18785, "", "=q4=Swift White Ram", "=ds=#e26#", "10 #gold#"};
				{ 19, 5872, "", "=q3=Brown Ram", "=ds=#e26#", "1 #gold#"};
				{ 20, 5864, "", "=q3=Gray Ram", "=ds=#e26#", "1 #gold#"};
				{ 21, 5873, "", "=q3=White Ram", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Ironforge"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		-----------------
		--- Orgrimmar ---
		-----------------

	AtlasLoot_Data["Orgrimmar"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Orgrimmar"], "=q5=#r1#"};
				{ 2, 45581, "", "=q1=Orgrimmar", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Orgrimmar"], "=q5=#r4#"};
				{ 5, 67533, "", "=q2=Orgrimmar Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_orc", "=q6="..ALIL["Orgrimmar"], "=q5=#r5#"};
				{ 8, 64909, "", "=q3=Cape of Orgrimmar", "=ds=#s4#", "3 #gold# 31 #silver# 17 #copper#"};
				{ 9, 64910, "", "=q3=Mantle of Orgrimmar", "=ds=#s4#", "3 #gold# 32 #silver# 42 #copper#"};
				{ 10, 64908, "", "=q3=Shroud of Orgrimmar", "=ds=#s4#", "3 #gold# 29 #silver# 88 #copper#"};
				{ 16, 18796, "", "=q4=Horn of the Swift Brown Wolf", "=ds=#e26#", "10 #gold#"};
				{ 17, 18798, "", "=q4=Horn of the Swift Gray Wolf", "=ds=#e26#", "10 #gold#"};
				{ 18, 18797, "", "=q4=Horn of the Swift Timber Wolf", "=ds=#e26#", "10 #gold#"};
				{ 19, 46099, "", "=q3=Horn of the Black Wolf", "=ds=#e26#", "1 #gold#"};
				{ 20, 5668, "", "=q3=Horn of the Brown Wolf", "=ds=#e26#", "1 #gold#"};
				{ 21, 5665, "", "=q3=Horn of the Dire Wolf", "=ds=#e26#", "1 #gold#"};
				{ 22, 1132, "", "=q3=Horn of the Timber Wolf", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Orgrimmar"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		-----------------------
		--- Silvermoon City ---
		-----------------------

	AtlasLoot_Data["SilvermoonCity"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_bloodelf", "=q6="..ALIL["Silvermoon City"], "=q5=#r1#"};
				{ 2, 45585, "", "=q1=Silvermoon City Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_bloodelf", "=q6="..ALIL["Silvermoon City"], "=q5=#r4#"};
				{ 5, 67535, "", "=q2=Silvermoon Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_bloodelf", "=q6="..ALIL["Silvermoon City"], "=q5=#r5#"};
				{ 8, 64915, "", "=q3=Cape of Silvermoon", "=ds=#s4#", "3 #gold# 38 #silver# 80 #copper#"};
				{ 9, 64916, "", "=q3=Mantle of Silvermoon", "=ds=#s4#", "3 #gold# 40 #silver# 8 #copper#"};
				{ 10, 64914, "", "=q3=Shroud of Silvermoon", "=ds=#s4#", "3 #gold# 37 #silver# 51 #copper#"};
				{ 16, 29223, "", "=q4=Swift Green Hawkstrider", "=ds=#e26#", "10 #gold#"};
				{ 17, 28936, "", "=q4=Swift Pink Hawkstrider", "=ds=#e26#", "10 #gold#"};
				{ 18, 29224, "", "=q4=Swift Purple Hawkstrider", "=ds=#e26#", "10 #gold#"};
				{ 19, 29221, "", "=q3=Black Hawkstrider", "=ds=#e26#", "1 #gold#"};
				{ 20, 29220, "", "=q3=Blue Hawkstrider", "=ds=#e26#", "1 #gold#"};
				{ 21, 29222, "", "=q3=Purple Hawkstrider", "=ds=#e26#", "1 #gold#"};
				{ 22, 28927, "", "=q3=Red Hawkstrider", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Silvermoon City"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		-----------------
		--- Stormwind ---
		-----------------

	AtlasLoot_Data["Stormwind"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_human", "=q6="..ALIL["Stormwind"], "=q5=#r1#"};
				{ 2, 45574, "", "=q1=Stormwind Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_human", "=q6="..ALIL["Stormwind"], "=q5=#r4#"};
				{ 5, 67531, "", "=q2=Stormwind Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_human", "=q6="..ALIL["Stormwind"], "=q5=#r5#"};
				{ 8, 64902, "", "=q3=Cape of Stormwind", "=ds=#s4#", "3 #gold# 56 #silver# 93 #copper#"};
				{ 9, 64901, "", "=q3=Mantle of Stormwind", "=ds=#s4#", "3 #gold# 46 #silver# 49 #copper#"};
				{ 10, 64898, "", "=q3=Shroud of Stormwind", "=ds=#s4#", "3 #gold# 58 #silver# 21 #copper#"};
				{ 16, 18777, "", "=q4=Swift Brown Steed", "=ds=#e26#", "10 #gold#"};
				{ 17, 18776, "", "=q4=Swift Palomino", "=ds=#e26#", "10 #gold#"};
				{ 18, 18778, "", "=q4=Swift White Steed", "=ds=#e26#", "10 #gold#"};
				{ 19, 2411, "", "=q3=Black Stallion Bridle", "=ds=#e26#", "1 #gold#"};
				{ 20, 5656, "", "=q3=Brown Horse Bridle", "=ds=#e26#", "1 #gold#"};
				{ 21, 5655, "", "=q3=Chestnut Mare Bridle", "=ds=#e26#", "1 #gold#"};
				{ 22, 2414, "", "=q3=Pinto Bridle", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Stormwind"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		---------------------------
		--- Thorium Brotherhood ---
		---------------------------

	AtlasLoot_Data["ThoriumBrotherhood"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Ingot_Mithril", "=q6=#r2#", "=q5="..ALIL["Blackrock Depths"]};
				{ 2, 17051, "", "=q3=Plans: Dark Iron Bracers", "=ds=#p2# (295)"};
				{ 3, 20761, "", "=q1=Recipe: Transmute Elemental Fire", "=ds=#p1# (300)"};
				{ 4, 19444, "", "=q1=Formula: Enchant Weapon - Strength", "=ds=#p4# (290)"};
				{ 5, 17023, "", "=q1=Pattern: Molten Helm", "=ds=#p7# (300)"};
				{ 6, 17022, "", "=q1=Pattern: Corehound Boots", "=ds=#p7# (295)"};
				{ 7, 17018, "", "=q1=Pattern: Flarecore Gloves", "=ds=#p8# (300)"};
				{ 16, 0, "INV_Ingot_Mithril", "=q6=#r3#", "=q5="..ALIL["Blackrock Depths"]};
				{ 17, 17060, "", "=q3=Plans: Dark Iron Destroyer", "=ds=#p2# (300)"};
				{ 18, 17059, "", "=q3=Plans: Dark Iron Reaver", "=ds=#p2# (300)"};
				{ 19, 17049, "", "=q3=Plans: Fiery Chain Girdle", "=ds=#p2# (295)"};
				{ 20, 19206, "", "=q1=Plans: Dark Iron Helm", "=ds=#p2# (300)"};
				{ 21, 19448, "", "=q1=Formula: Enchant Weapon - Mighty Spirit", "=ds=#p4# (300)"};
				{ 22, 17025, "", "=q1=Pattern: Black Dragonscale Boots", "=ds=#p7# (300)"};
				{ 23, 19330, "", "=q1=Pattern: Lava Belt", "=ds=#p7# (300)"};
				{ 24, 17017, "", "=q1=Pattern: Flarecore Mantle", "=ds=#p8# (300)"};
				{ 25, 19219, "", "=q1=Pattern: Flarecore Robe", "=ds=#p8# (300)"};
			};
			{
				{ 1, 0, "INV_Ingot_Mithril", "=q6=#r4#", "=q5="..ALIL["Blackrock Depths"]};
				{ 2, 18592, "", "=q4=Plans: Sulfuron Hammer", "=ds=#p2# (300), #m4#"};
				{ 3, 17052, "", "=q3=Plans: Dark Iron Leggings", "=ds=#p2# (300)"};
				{ 4, 17053, "", "=q3=Plans: Fiery Chain Shoulders", "=ds=#p2# (300)"};
				{ 5, 19209, "", "=q1=Plans: Blackfury", "=ds=#p2# (300)"};
				{ 6, 19208, "", "=q1=Plans: Black Amnesty", "=ds=#p2# (300)"};
				{ 7, 19207, "", "=q1=Plans: Dark Iron Gauntlets", "=ds=#p2# (300)"};
				{ 8, 19449, "", "=q1=Formula: Enchant Weapon - Mighty Intellect", "=ds=#p4# (300)"};
				{ 9, 19331, "", "=q1=Pattern: Chromatic Gauntlets", "=ds=#p7# (300)"};
				{ 10, 19332, "", "=q1=Pattern: Corehound Belt", "=ds=#p7# (300)"};
				{ 11, 19333, "", "=q1=Pattern: Molten Belt", "=ds=#p7# (300)"};
				{ 12, 19220, "", "=q1=Pattern: Flarecore Leggings", "=ds=#p8# (300)"};
				{ 16, 0, "INV_Ingot_Mithril", "=q6=#r5#", "=q5="..ALIL["Blackrock Depths"]};
				{ 17, 19211, "", "=q1=Plans: Blackguard", "=ds=#p2# (300)"};
				{ 18, 20040, "", "=q1=Plans: Dark Iron Boots", "=ds=#p2# (300)"};
				{ 19, 19210, "", "=q1=Plans: Ebon Hand", "=ds=#p2# (300)"};
				{ 20, 19212, "", "=q1=Plans: Nightfall", "=ds=#p2# (300)"};
			};
		};
		info = {
			name = ALIL["Thorium Brotherhood"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		---------------------
		--- Thunder Bluff ---
		---------------------

	AtlasLoot_Data["ThunderBluff"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_tauren", "=q6="..ALIL["Thunder Bluff"], "=q5=#r1#"};
				{ 2, 45584, "", "=q1=Thunder Bluff Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_tauren", "=q6="..ALIL["Thunder Bluff"], "=q5=#r4#"};
				{ 5, 67534, "", "=q2=Thunder Bluff Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_tauren", "=q6="..ALIL["Thunder Bluff"], "=q5=#r5#"};
				{ 8, 64918, "", "=q3=Cape of Thunder Bluff", "=ds=#s4#", "3 #gold# 51 #silver# 80 #copper#"};
				{ 9, 64917, "", "=q3=Mantle of Thunder Bluff", "=ds=#s4#", "3 #gold# 41 #silver# 36 #copper#"};
				{ 10, 64919, "", "=q3=Shroud of Thunder Bluff", "=ds=#s4#", "3 #gold# 53 #silver# 8 #copper#"};
				{ 16, 18794, "", "=q4=Great Brown Kodo", "=ds=#e26#", "10 #gold#"};
				{ 17, 18795, "", "=q4=Great Gray Kodo", "=ds=#e26#", "10 #gold#"};
				{ 18, 18793, "", "=q4=Great White Kodo", "=ds=#e26#", "10 #gold#"};
				{ 19, 15290, "", "=q3=Brown Kodo", "=ds=#e26#", "1 #gold#"};
				{ 20, 15277, "", "=q3=Gray Kodo", "=ds=#e26#", "1 #gold#"};
				{ 21, 46100, "", "=q3=White Kodo", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Thunder Bluff"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		----------------------
		--- Timbermaw Hold ---
		----------------------

	AtlasLoot_Data["Timbermaw"] = {
		["Normal"] = {
			{
				{ 1, 0, "achievement_reputation_timbermaw", "=q6=#r2#", ""};
				{ 2, 13484, "", "=q2=Recipe: Transmute Earth to Water", "=ds=#p1# (275)"};
				{ 3, 22392, "", "=q1=Formula: Enchant 2H Weapon - Agility", "=ds=#p4# (290)"};
				{ 4, 20254, "", "=q1=Pattern: Warbear Woolies", "=ds=#p7# (285)"};
				{ 5, 20253, "", "=q1=Pattern: Warbear Harness", "=ds=#p7# (275)"};
				{ 7, 0, "achievement_reputation_timbermaw", "=q6=#r3#", ""};
				{ 8, 16768, "", "=q2=Furbolg Medicine Pouch", "=ds=#s15#"};
				{ 9, 16769, "", "=q2=Furbolg Medicine Totem", "=ds=#h1#, #w6#"};
				{ 10, 19202, "", "=q1=Plans: Heavy Timbermaw Belt", "=ds=#p2# (290)"};
				{ 11, 19445, "", "=q1=Formula: Enchant Weapon - Agility", "=ds=#p4# (290)"};
				{ 12, 19326, "", "=q1=Pattern: Might of the Timbermaw", "=ds=#p7# (290)"};
				{ 13, 19215, "", "=q1=Pattern: Wisdom of the Timbermaw", "=ds=#p8# (290)"};
				{ 16, 0, "achievement_reputation_timbermaw", "=q6=#r4#", ""};
				{ 17, 19204, "", "=q1=Plans: Heavy Timbermaw Boots", "=ds=#p2# (300)"};
				{ 18, 19327, "", "=q1=Pattern: Timbermaw Brawlers", "=ds=#p7# (300)"};
				{ 19, 19218, "", "=q1=Pattern: Mantle of the Timbermaw", "=ds=#p8# (300)"};
				{ 22, 0, "achievement_reputation_timbermaw", "=q6=#r5#", ""};
				{ 23, 21326, "", "=q4=Defender of the Timbermaw", "=q1=#m4#: =ds=#s14#"};
				{ 24, 66888, "", "=q1=Stave of Fur and Claw", "=ds=#e25#"};
			};
		};
		info = {
			name = ALIL["Timbermaw Hold"],
			module = moduleName, menu = "REPMENU_ORIGINALWOW",
		};
	}

		-----------------------
		--- Tushui Pandaren ---
		-----------------------

	AtlasLoot_Data["TushuiPandaren"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_human", "=q6="..ALIL["Tushui Pandaren"], "=q5=#r1#"};
				{ 2, 83079, "", "=q1=Tushui Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_gnome", "=q6="..ALIL["Tushui Pandaren"], "=q5=#r4#"};
				{ 5, 92071, "", "=q2=Tushui Satchel", "=ds=#e1#", "2 #gold#"};
				{ 16, 0, "inv_misc_tournaments_symbol_human", "=q6="..ALIL["Tushui Pandaren"], "=q5=#r5#"};
				{ 17, 87802, "", "=q4=Reins of the Great Black Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 18, 87803, "", "=q4=Reins of the Great Blue Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 19, 87804, "", "=q4=Reins of the Great Brown Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 20, 87801, "", "=q4=Reins of the Great Green Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 21, 87805, "", "=q4=Reins of the Great Purple Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 22, 82811, "", "=q4=Reins of the Great Red Dragon Turtle", "=ds=#e26#", "10 #gold#"};
				{ 23, 87795, "", "=q3=Reins of the Black Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 24, 87796, "", "=q3=Reins of the Blue Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 25, 87797, "", "=q3=Reins of the Brown Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 26, 82765, "", "=q3=Reins of the Green Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 27, 87799, "", "=q3=Reins of the Purple Dragon Turtle", "=ds=#e26#", "1 #gold#"};
				{ 28, 87800, "", "=q3=Reins of the Red Dragon Turtle", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Tushui Pandaren"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}

		-----------------
		--- Undercity ---
		-----------------

	AtlasLoot_Data["Undercity"] = {
		["Normal"] = {
			{
				{ 1, 0, "inv_misc_tournaments_symbol_scourge", "=q6="..ALIL["Undercity"], "=q5=#r1#"};
				{ 2, 45583, "", "=q1=Undercity Tabard", "=ds=#s7#", "10 #silver#"};
				{ 4, 0, "inv_misc_tournaments_symbol_scourge", "=q6="..ALIL["Undercity"], "=q5=#r4#"};
				{ 5, 67529, "", "=q2=Undercity Satchel", "=ds=#e1#", "2 #gold#"};
				{ 7, 0, "inv_misc_tournaments_symbol_scourge", "=q6="..ALIL["Undercity"], "=q5=#r5#"};
				{ 8, 64921, "", "=q3=Cape of Undercity", "=ds=#s4#", "3 #gold# 55 #silver# 61 #copper#"};
				{ 9, 64922, "", "=q3=Mantle of Undercity", "=ds=#s4#", "3 #gold# 56 #silver# 90 #copper#"};
				{ 10, 64920, "", "=q3=Shroud of Undercity", "=ds=#s4#", "3 #gold# 54 #silver# 36 #copper#"};
				{ 16, 13334, "", "=q4=Green Skeletal Warhorse", "=ds=#e26#", "10 #gold#"};
				{ 17, 47101, "", "=q4=Ochre Skeletal Warhorse", "=ds=#e26#", "10 #gold#"};
				{ 18, 18791, "", "=q4=Purple Skeletal Warhorse", "=ds=#e26#", "10 #gold#"};
				{ 19, 46308, "", "=q3=Black Skeletal Horse", "=ds=#e26#", "1 #gold#"};
				{ 20, 13332, "", "=q3=Blue Skeletal Horse", "=ds=#e26#", "1 #gold#"};
				{ 21, 13333, "", "=q3=Brown Skeletal Horse", "=ds=#e26#", "1 #gold#"};
				{ 22, 13331, "", "=q3=Red Skeletal Horse", "=ds=#e26#", "1 #gold#"};
			};
		};
		info = {
			name = ALIL["Undercity"],
			module = moduleName, menu = "REPMENU_RACEFACTIONS",
		};
	}