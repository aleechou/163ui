-- $Id: worldevents.lua 4202 2013-05-05 21:56:29Z dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleRare = AtlasLoot_GetLocaleLibBabble("LibBabble-Rare-3.0")
local moduleName = "AtlasLoot_WorldEvents"

-- Index
--- Permanent Events
---- Argent Tournament
--- Seasonal Events
---- Brewfest
---- Children's Week
---- Day of the Dead
---- Feast of Winter Veil
---- Hallow's End
---- Harvest Festival
---- Love is in the Air
---- Lunar Festival
---- Midsummer Fire Festival
---- Noblegarden
---- Pilgrim's Bounty
--- Reaccouring Events
---- Bash'ir Landing Skyguard Raid
---- Darkmoon Faire
---- Gurubashi Arena Booty Run
---- Stranglethorn Fishing Extravaganza / Kalu'ak Fishing Derby
--- One-Time Events
--- Triggered Events
---- Abyssal Council
---- Ethereum Prison
---- Skettis

	------------------------
	--- Permanent Events ---
	------------------------

		-------------------------
		--- Argent Tournament ---
		-------------------------

	AtlasLoot_Data["ATArmor"] = {
		["Normal_A"] = {
			{
				{ 2, 45156, "", "=q3=Sash of Shattering Hearts", "=ds=#s10#, #a1#", "#CHAMPSEAL:10#" };
				{ 3, 45181, "", "=q3=Wrap of the Everliving Tree", "=ds=#s10#, #a2#", "#CHAMPSEAL:10#" };
				{ 4, 45159, "", "=q3=Treads of Nimble Evasion", "=ds=#s12#, #a2#", "#CHAMPSEAL:10#" };
				{ 5, 45184, "", "=q3=Cinch of Bonded Servitude", "=ds=#s10#, #a3#", "#CHAMPSEAL:10#" };
				{ 6, 45183, "", "=q3=Treads of the Glorious Spirit", "=ds=#s12#, #a3#", "#CHAMPSEAL:10#" };
				{ 7, 45182, "", "=q3=Gauntlets of Shattered Pride", "=ds=#s9#, #a4#", "#CHAMPSEAL:10#" };
				{ 8, 45160, "", "=q3=Girdle of Valorous Defeat", "=ds=#s10#, #a4#", "#CHAMPSEAL:10#" };
				{ 9, 45163, "", "=q3=Stanchions of Unseatable Furor", "=ds=#s12#, #a4#", "#CHAMPSEAL:10#" };
				{ 10, 45153, "", "=q3=Susurrating Shell Necklace", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 11, 45155, "", "=q3=Choker of Spiral Focus", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 12, 45154, "", "=q3=Necklace of Valiant Blood", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 13, 45152, "", "=q3=Pendant of Azure Dreams", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 14, 45131, "", "=q3=Jouster's Fury", "=ds=#s14#", "#CHAMPSEAL:10#" };
				{ 17, 45078, "", "=q4=Dagger of Lunar Purity", "=ds=#h1#, #w4#", "#CHAMPSEAL:25#" };
				{ 18, 45077, "", "=q4=Dagger of the Rising Moon", "=ds=#h1#, #w4#", "#CHAMPSEAL:25#" };
				{ 19, 45129, "", "=q4=Gnomeregan Bonechopper", "=ds=#h1#, #w10#", "#CHAMPSEAL:25#" };
				{ 20, 45074, "", "=q4=Claymore of the Prophet", "=ds=#h2#, #w10#", "#CHAMPSEAL:25#" };
				{ 21, 45076, "", "=q4=Teldrassil Protector", "=ds=#h1#, #w1#", "#CHAMPSEAL:25#" };
				{ 22, 45075, "", "=q4=Ironforge Smasher", "=ds=#h1#, #w6#", "#CHAMPSEAL:25#" };
				{ 23, 45128, "", "=q4=Silvery Sylvan Stave", "=ds=#w9#", "#CHAMPSEAL:25#" };
				{ 24, 45130, "", "=q4=Blunderbuss of Khaz Modan", "=ds=#w5#", "#CHAMPSEAL:25#" };
			};
		};
		["Normal_H"] = {
			{
				{ 2, 45209, "", "=q3=Sash of Trumpeted Pride", "=ds=#s10#, #a1#", "#CHAMPSEAL:10#" };
				{ 3, 45211, "", "=q3=Waistguard of Equine Fury", "=ds=#s10#, #a2#", "#CHAMPSEAL:10#" };
				{ 4, 45220, "", "=q3=Treads of the Earnest Squire", "=ds=#s12#, #a2#", "#CHAMPSEAL:10#" };
				{ 5, 45215, "", "=q3=Links of Unquenched Savagery", "=ds=#s10#, #a3#", "#CHAMPSEAL:10#" };
				{ 6, 45221, "", "=q3=Treads of Whispering Dreams", "=ds=#s12#, #a3#", "#CHAMPSEAL:10#" };
				{ 7, 45216, "", "=q3=Gauntlets of Mending Touch", "=ds=#s9#, #a4#", "#CHAMPSEAL:10#" };
				{ 8, 45217, "", "=q3=Clinch of Savage Fury", "=ds=#s10#, #a4#", "#CHAMPSEAL:10#" };
				{ 9, 45218, "", "=q3=Blood-Caked Stompers", "=ds=#s12#, #a4#", "#CHAMPSEAL:10#" };
				{ 10, 45206, "", "=q3=Choker of Feral Fury", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 11, 45207, "", "=q3=Necklace of Stolen Skulls", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 12, 45213, "", "=q3=Pendant of Emerald Crusader", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 13, 45223, "", "=q3=Razor's Edge Pendant", "=ds=#s2#", "#CHAMPSEAL:10#" };
				{ 14, 45219, "", "=q3=Jouster's Fury", "=ds=#s14#", "#CHAMPSEAL:10#" };
				{ 17, 45214, "", "=q4=Scalpel of the Royal Apothecary", "=ds=#h1#, #w4#", "#CHAMPSEAL:25#" };
				{ 18, 45222, "", "=q4=Spinal Destroyer", "=ds=#h1#, #w4#", "#CHAMPSEAL:25#" };
				{ 19, 45208, "", "=q4=Blade of the Keening Banshee", "=ds=#h1#, #w10#", "#CHAMPSEAL:25#" };
				{ 20, 45205, "", "=q4=Greatsword of the Sin'dorei", "=ds=#h2#, #w10#", "#CHAMPSEAL:25#" };
				{ 21, 45204, "", "=q4=Axe of the Sen'jin Protector", "=ds=#h1#, #w1#", "#CHAMPSEAL:25#" };
				{ 22, 45203, "", "=q4=Grimhorn Crusher", "=ds=#h1#, #w6#", "#CHAMPSEAL:25#" };
				{ 23, 45212, "", "=q4=Staff of Feral Furies", "=ds=#w9#", "#CHAMPSEAL:25#" };
				{ 24, 45210, "", "=q4=Sen'jin Beakblade Longrifle", "=ds=#w5#", "#CHAMPSEAL:25#" };
			};
		};
		info = {
			name = AL["Argent Tournament"],
			module = moduleName, menu = "ARGENTMENU",
		};
	};

	AtlasLoot_Data["ATMounts"] = {
		["Normal"] = {
			{
				{ 2, 45593, "", "=q4=Darkspear Raptor", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 3, 45597, "", "=q4=Forsaken Warhorse", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 4, 45595, "", "=q4=Orgrimmar Wolf", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 5, 45596, "", "=q4=Silvermoon Hawkstrider", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 6, 45592, "", "=q4=Thunder Bluff Kodo", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 8, 46750, "", "=q4=Great Golden Kodo", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 9, 46749, "", "=q4=Swift Burgundy Wolf", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 10, 46743, "", "=q4=Swift Purple Raptor", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 11, 46751, "", "=q4=Swift Red Hawkstrider", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 12, 46746, "", "=q4=White Skeletal Warhorse", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 17, 45591, "", "=q4=Darnassian Nightsaber", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 18, 45590, "", "=q4=Exodar Elekk", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 19, 45589, "", "=q4=Gnomeregan Mechanostrider", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 20, 45586, "", "=q4=Ironforge Ram", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 21, 45125, "", "=q4=Stormwind Steed", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 23, 46745, "", "=q4=Great Red Elekk", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 24, 46752, "", "=q4=Swift Gray Steed", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 25, 46744, "", "=q4=Swift Moonsaber", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 26, 46748, "", "=q4=Swift Violet Ram", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
				{ 27, 46747, "", "=q4=Turbostrider", "=ds=#e26#", "500 #gold# #CHAMPSEAL:5#"};
			};
			{
				{ 1, 0, "inv_misc_tabardpvp_01", "=q6="..ALIL["The Silver Covenant"], "=ec1=#m7#"};
				{ 2, 46815, "", "=q4=Quel'dorei Steed", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 3, 46813, "", "=q4=Silver Covenant Hippogryph", "=ds=#e27#", "#CHAMPSEAL:150#"};
				{ 5, 0, "INV_Jewelry_Talisman_08", "=q6="..ALIL["Argent Crusade"], "" };
				{ 6, 47179, "", "=q4=Argent Charger", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 7, 47180, "", "=q4=Argent Warhorse", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 8, 45725, "", "=q4=Argent Hippogryph", "=ds=#e27#", "#CHAMPSEAL:150#"};
				{ 16, 0, "inv_misc_tabardpvp_02", "=q6="..ALIL["The Sunreavers"], "=ec1=#m6#"};
				{ 17, 46816, "", "=q4=Sunreaver Hawkstrider", "=ds=#e26#", "#CHAMPSEAL:100#"};
				{ 18, 46814, "", "=q4=Sunreaver Dragonhawk", "=ds=#e27#", "#CHAMPSEAL:150#"};
			};
		};
		info = {
			name = AL["Argent Tournament"],
			module = moduleName, menu = "ARGENTMENU",
		};
	};

	AtlasLoot_Data["ATPets"] = {
		["Normal"] = {
			{
				{ 2, 45022, "", "=q3=Argent Gruntling", "=ds=#e13#", "=ds=#m4#, =ec1=#m6#"};
				{ 3, 44980, "", "=q3=Mulgore Hatchling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 4, 45606, "", "=q3=Sen'jin Fetish", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 5, 44971, "", "=q3=Tirisfal Batling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 6, 44973, "", "=q3=Durotar Scorpion", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 7, 44982, "", "=q3=Enchanted Broom", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 8, 46821, "", "=q3=Shimmering Wyrmling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 10, 0, "INV_Jewelry_Talisman_08", "=q6="..ALIL["Argent Crusade"], "" };
				{ 11, 47541, "", "=q3=Argent Pony Bridle", "=ds=", "#CHAMPSEAL:50#"};
				{ 17, 44998, "", "=q3=Argent Squire", "=ds=#e13#", "=ds=#m4#, =ec1=#m7#"};
				{ 18, 44984, "", "=q3=Ammen Vale Lashling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 19, 44965, "", "=q3=Teldrassil Sproutling", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 20, 44970, "", "=q3=Dun Morogh Cub", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 21, 44974, "", "=q3=Elwynn Lamb", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 22, 45002, "", "=q3=Mechanopeep", "=ds=#e13#", "#CHAMPSEAL:40#"};
				{ 23, 46820, "", "=q3=Shimmering Wyrmling", "=ds=#e13#", "#CHAMPSEAL:40#"};
			};
		};
		info = {
			name = AL["Argent Tournament"],
			module = moduleName, menu = "ARGENTMENU",
		};
	};

	AtlasLoot_Data["ATHeirlooms"] = {
		["Normal"] = {
			{
				{ 1, 42985, "", "=q7=Tattered Dreadmist Mantle", "=ds=#s3#, #a1#",  "#CHAMPSEAL:60#"};
				{ 2, 42984, "", "=q7=Preened Ironfeather Shoulders", "=ds=#s3#, #a2#", "#CHAMPSEAL:60#"};
				{ 3, 42952, "", "=q7=Stained Shadowcraft Spaulders", "=ds=#s3#, #a2#", "#CHAMPSEAL:60#"};
				{ 4, 42950, "", "=q7=Champion Herod's Shoulder", "=ds=#s3#, #a3#", "#CHAMPSEAL:60#"};
				{ 5, 42951, "", "=q7=Mystical Pauldrons of Elements", "=ds=#s3#, #a3#", "#CHAMPSEAL:60#"};
				{ 6, 69890, "", "=q7=Burnished Pauldrons of Might", "=ds=#s3#, #a4#", "#CHAMPSEAL:60#"};
				{ 7, 42949, "", "=q7=Polished Spaulders of Valor", "=ds=#s3#, #a4#", "#CHAMPSEAL:60#"};
				{ 9, 48691, "", "=q7=Tattered Dreadmist Robe", "=ds=#s5#, #a1#", "#CHAMPSEAL:60#"};
				{ 10, 48687, "", "=q7=Preened Ironfeather Breastplate", "=ds=#s5#, #a2#", "#CHAMPSEAL:60#"};
				{ 11, 48689, "", "=q7=Stained Shadowcraft Tunic", "=ds=#s5#, #a2#", "#CHAMPSEAL:60#"};
				{ 12, 48677, "", "=q7=Champion's Deathdealer Breastplate", "=ds=#s5#, #a3#", "#CHAMPSEAL:60#"};
				{ 13, 48683, "", "=q7=Mystical Vest of Elements", "=ds=#s5#, #a3#", "#CHAMPSEAL:60#"};
				{ 14, 69889, "", "=q7=Burnished Breastplate of Might", "=ds=#s5#, #a4#", "#CHAMPSEAL:60#"};
				{ 15, 48685, "", "=q7=Polished Breastplate of Valor", "=ds=#s5#, #a4#", "#CHAMPSEAL:60#"};
				{ 16, 42992, "", "=q7=Discerning Eye of the Beast", "=ds=#s14#", "#CHAMPSEAL:75#"};
				{ 17, 42991, "", "=q7=Swift Hand of Justice", "=ds=#s14#", "#CHAMPSEAL:75#"};
				{ 19, 42944, "", "=q7=Balanced Heartseeker", "=ds=#h1#, #w4#", "#CHAMPSEAL:60#"};
				{ 20, 69893, "", "=q7=Bloodsoaked Skullforge Reaver", "=ds=#h1#, #w10#", "#CHAMPSEAL:60#"};
				{ 21, 42945, "", "=q7=Venerable Dal'Rend's Sacred Charge", "=ds=#h1#, #w10#", "#CHAMPSEAL:60#"};
				{ 22, 42943, "", "=q7=Bloodied Arcanite Reaper", "=ds=#h2#, #w1#", "#CHAMPSEAL:95#"};
				{ 23, 42948, "", "=q7=Devout Aurastone Hammer", "=ds=#h1#, #w6#", "#CHAMPSEAL:60#"};
				{ 24, 48716, "", "=q7=Venerable Mass of McGowan", "=ds=#h1#, #w6#", "#CHAMPSEAL:60#"};
				{ 25, 48718, "", "=q7=Repurposed Lava Dredger", "=ds=#h2#, #w6#", "#CHAMPSEAL:95#"};
				{ 26, 79131, "", "=q7=Burnished Warden Staff", "=ds=#w9#", "#CHAMPSEAL:95#"};
				{ 27, 42947, "", "=q7=Dignified Headmaster's Charge", "=ds=#w9#", "#CHAMPSEAL:95#"};
				{ 28, 42946, "", "=q7=Charmed Ancient Bone Bow", "=ds=#w2#", "#CHAMPSEAL:95#"};
			};
		};
		info = {
			name = AL["Argent Tournament"],
			module = moduleName, menu = "ARGENTMENU",
		};
	};

	-----------------------
	--- Seasonal Events ---
	-----------------------

		----------------
		--- Brewfest ---
		----------------

	AtlasLoot_Data["Brewfest"] = {
		["Normal"] = {
			{
				{ 1, 46707, "", "=q3=Pint-Sized Pink Pachyderm", "=ds=#e13#", "#BREWFEST:100#"};
				{ 2, 32233, "", "=q3=Wolpertinger's Tankard", "=ds=#e13#", "#BREWFEST:200#"};
				{ 3, 33927, "", "=q3=Brewfest Pony Keg", "=ds=#m20#", "#BREWFEST:100#"};
				{ 4, 71137, "", "=q3=Brewfest Keg Pony", "=ds=#m20#", "#BREWFEST:200#"};
				{ 5, 90427, "", "=q3=Pandaren Brewpack", "=ds=#m20#", "#BREWFEST:100#"};
				{ 6, 37816, "", "=q2=Preserved Brewfest Hops", "=ds=#m20#", "#BREWFEST:20#"};
				{ 7, 90426, "", "=q1=Brewhelm", "=ds=#m20#", "#BREWFEST:2#"};
				{ 8, 37750, "", "=q1=Fresh Brewfest Hops", "=ds=#m20#", "#BREWFEST:2#"};
				{
					{ 9, 39477, "", "=q1=Fresh Dwarven Brewfest Hops", "=ds=#m20# =ec1=#m6#", "#BREWFEST:5#"};
					{ 9, 39476, "", "=q1=Fresh Goblin Brewfest Hops", "=ds=#m20# =ec1=#m7#", "#BREWFEST:5#"};
				};
				{ 10, 37599, "", "=q1=\"Brew of the Month\" Club Membership Form", "=ds=#m2#", "#BREWFEST:200#"};
				{
					{ 16, 34008, "", "=q1=Blix's Eyesight Enhancing Romance Goggles", "=ds=#s1#", "#BREWFEST:100#"};
					{ 16, 33047, "", "=q1=Belbi's Eyesight Enhancing Romance Goggles", "=ds=#s1#", "#BREWFEST:100#"};
				};
				{ 17, 33968, "", "=q1=Blue Brewfest Hat", "=ds=#s1#", "#BREWFEST:50#"};
				{ 18, 33864, "", "=q1=Brown Brewfest Hat", "=ds=#s1#", "#BREWFEST:50#"};
				{ 19, 33967, "", "=q1=Green Brewfest Hat", "=ds=#s1#", "#BREWFEST:50#"};
				{ 20, 33969, "", "=q1=Purple Brewfest Hat", "=ds=#s1#", "#BREWFEST:50#"};
				{ 21, 33863, "", "=q1=Brewfest Dress", "=ds=#s5#", "#BREWFEST:200#"};
				{ 22, 33862, "", "=q1=Brewfest Regalia", "=ds=#s5#", "#BREWFEST:200#"};
				{ 23, 33868, "", "=q1=Brewfest Boots", "=ds=#s12#", "#BREWFEST:100#"};
				{ 24, 33966, "", "=q1=Brewfest Slippers", "=ds=#s12#", "#BREWFEST:100#"};
				extraText = ": "..AL["Vendor"];
			};
			{
				{ 1, 33030, "", "=q1=Barleybrew Clear", "=ds=#e4#"};
				{ 2, 33028, "", "=q1=Barleybrew Light", "=ds=#e4#"};
				{ 3, 33029, "", "=q1=Barleybrew Dark", "=ds=#e4#"};
				{ 5, 33031, "", "=q1=Thunder 45", "=ds=#e4#"};
				{ 6, 33032, "", "=q1=Thunderbrew Ale", "=ds=#e4#"};
				{ 7, 33033, "", "=q1=Thunderbrew Stout", "=ds=#e4#"};
				{ 9, 33034, "", "=q1=Gordok Grog", "=ds=#e4#"};
				{ 10, 33036, "", "=q1=Mudder's Milk", "=ds=#e4#"};
				{ 11, 33035, "", "=q1=Ogre Mead", "=ds=#e4#"};
				{ 13, 34017, "", "=q1=Small Step Brew", "=ds=#e4#"};
				{ 14, 34018, "", "=q1=Long Stride Brew", "=ds=#e4#"};
				{ 15, 34019, "", "=q1=Path of Brew", "=ds=#e4#"};
				{ 16, 34020, "", "=q1=Jungle River Water", "=ds=#e4#"};
				{ 17, 34021, "", "=q1=Brewdoo Magic", "=ds=#e4#"};
				{ 18, 34022, "", "=q1=Stout Shrunken Head", "=ds=#e4#"};
				{ 20, 33929, "", "=q1=Brewfest Brew", "=ds=#e4#"};
				{ 22, 34063, "", "=q1=Dried Sausage", "=ds=#e3#"};
				{ 23, 33024, "", "=q1=Pickled Sausage", "=ds=#e3#"};
				{ 24, 38428, "", "=q1=Rock-Salted Pretzel", "=ds=#e3#"};
				{ 25, 33023, "", "=q1=Savory Sausage", "=ds=#e3#"};
				{ 26, 34065, "", "=q1=Spiced Onion Cheese", "=ds=#e3#"};
				{ 27, 33025, "", "=q1=Spicy Smoked Sausage", "=ds=#e3#"};
				{ 28, 34064, "", "=q1=Succulent Sausage", "=ds=#e3#"};
				{ 29, 33043, "", "=q1=The Essential Brewfest Pretzel", "=ds=#e3#"};
				{ 30, 33026, "", "=q1=The Golden Link", "=ds=#e3#"};
				extraText = ": "..AL["Food and Drinks"];
			};
			{
				{ 1, 37599, "", "=q1=\"Brew of the Month\" Club Membership Form", "=ds=#m2#", "#BREWFEST:200#"};
				{ 3, 37488, "", "=q1=Wild Winter Pilsner", "=ds=#month1#"};
				{ 4, 37489, "", "=q1=Izzard's Ever Flavor", "=ds=#month2#"};
				{ 5, 37490, "", "=q1=Aromatic Honey Brew", "=ds=#month3#"};
				{ 6, 37491, "", "=q1=Metok's Bubble Bock", "=ds=#month4#"};
				{ 7, 37492, "", "=q1=Springtime Stout", "=ds=#month5#"};
				{ 8, 37493, "", "=q1=Blackrock Lager", "=ds=#month6#"};
				{ 18, 37494, "", "=q1=Stranglethorn Brew", "=ds=#month7#"};
				{ 19, 37495, "", "=q1=Draenic Pale Ale", "=ds=#month8#"};
				{ 20, 37496, "", "=q1=Binary Brew", "=ds=#month9#"};
				{ 21, 37497, "", "=q1=Autumnal Acorn Ale", "=ds=#month10#"};
				{ 22, 37498, "", "=q1=Bartlett's Bitter Brew", "=ds=#month11#"};
				{ 23, 37499, "", "=q1=Lord of Frost's Private Label", "=ds=#month12#"};
				extraText = ": "..AL["Brew of the Month Club"];
			};
		};
		info = {
			name = AL["Brewfest"],
			module = moduleName, menu = "BREWFESTMENU",
		};
	};

	AtlasLoot_Data["CorenDirebrew"] = {
		["Normal"] = {
			{
				{ 1, 87573, "", "=q4=Thousand-Year Pickled Egg", "=ds=#s14#"};
				{ 2, 87575, "", "=q4=Bubbliest Brightbrew Charm", "=ds=#s14#"};
				{ 3, 87576, "", "=q4=Bitterest Balebrew Charm", "=ds=#s14#"};
				{ 4, 87571, "", "=q4=Brawler's Statue", "=ds=#s14#"};
				{ 5, 87574, "", "=q4=Coren's Cold Chromium Coaster", "=ds=#s14#"};
				{ 6, 87572, "", "=q4=Mithril Wristwatch", "=ds=#s14#"};
				{ 8, 38281, "", "=q1=Direbrew's Dire Brew", "=ds=#m2#"};
				{ 16, 54535, "", "=q3=Keg-Shaped Treasure Chest", "=q5="..AL["Daily Reward"]};
				{ 17, 71331, "", "=q4=Direbrew's Bloodied Shanker", "=ds=#h1#, #w4#"};
				{ 18, 71332, "", "=q4=Tremendous Tankard O' Terror", "=ds=#h1#, #w6#"};
				{ 19, 37828, "", "=q4=Great Brewfest Kodo", "=ds=#e26#"};
				{ 20, 33977, "", "=q4=Swift Brewfest Ram", "=ds=#e26#"};
				{ 22, 37863, "", "=q3=Direbrew's Remote", "=ds=#m20#"};
			};
		};
		info = {
			name = BabbleBoss["Coren Direbrew"],
			module = moduleName, menu = "BREWFESTMENU",
		};
	};

		-----------------------
		--- Children's Week ---
		-----------------------

	AtlasLoot_Data["ChildrensWeek"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Azeroth"], "=q5="..ALIL["Stormwind City"].." / "..ALIL["Orgrimmar"]};
				{ 2, 23007, "", "=q1=Piglet's Collar", "=ds=#e13#"};
				{ 3, 23015, "", "=q1=Rat Cage", "=ds=#e13#"};
				{ 4, 66073, "", "=q1=Snail Shell", "=ds=#e13#"};
				{ 5, 23002, "", "=q1=Turtle Box", "=ds=#e13#"};
				{ 6, 23022, "", "=q1=Curmudgeon's Payoff", "=ds="};
				{ 8, 0, "INV_Box_01", "=q6="..ALIL["Outland"], "=q5="..ALIL["Shattrath City"]};
				{ 9, 32616, "", "=q3=Egbert's Egg", "=ds=#e13#"};
				{ 10, 32622, "", "=q3=Elekk Training Collar", "=ds=#e13#"};
				{ 11, 69648, "", "=q3=Legs", "=ds=#e13#"};
				{ 12, 32617, "", "=q3=Sleepy Willy", "=ds=#e13#"};
				{ 16, 0, "INV_Box_01", "=q6="..ALIL["Northrend"], "=q5="..ALIL["Dalaran"]};
				{ 17, 46545, "", "=q3=Curious Oracle Hatchling", "=ds=#e13#"};
				{ 18, 46544, "", "=q3=Curious Wolvar Pup", "=ds=#e13#"};
			};
		};
		info = {
			name = AL["Children's Week"],
			module = moduleName, menu = "WORLDEVENTMENU",
		};
	};

		-----------------------
		--- Day of the Dead ---
		-----------------------

	AtlasLoot_Data["DayoftheDead"] = {
		["Normal"] = {
			{
				{ 1, 46831, "", "=q1=Macabre Marionette", "=q1=#m4#: =ds=#m20#"};
				{ 3, 46860, "", "=q1=Whimsical Skull Mask", "=ds=#s1#", "=ds=5 #copper#"};
				{ 4, 46861, "", "=q1=Bouquet of Orange Marigolds", "=ds=#s15#", "=ds=1 #gold#"};
				{ 5, 46690, "", "=q1=Candy Skull", "=ds=#m20#", "=ds=5 #copper#"};
				{ 6, 46711, "", "=q1=Spirit Candle", "=ds=#m20#", "=ds=30 #copper#"};
				{ 7, 46718, "", "=q1=Orange Marigold", "=ds=#m20#", "=ds=10 #copper#"};
				{ 16, 46710, "", "=q1=Recipe: Bread of the Dead", "=ds=#p3# (1)", "=ds=20 #silver#"};
				{ 17, 46691, "", "=q1=Bread of the Dead", "=ds=#e3#"};
			};
		};
		info = {
			name = AL["Day of the Dead"],
			module = moduleName, menu = "WORLDEVENTMENU",
		};
	};

		----------------------------
		--- Feast of Winter Veil ---
		----------------------------

	AtlasLoot_Data["Winterveil"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Holiday_Christmas_Present_01", "=q6="..AL["Smokywood Pastures Vendor"], ""};
				{ 2, 34262, "", "=q2=Pattern: Winter Boots", "=ds=#p7# (285)", "50 #silver#"};
				{ 3, 34319, "", "=q2=Pattern: Red Winter Clothes", "=ds=#p8# (250)", "50 #silver#"};
				{ 4, 34261, "", "=q2=Pattern: Green Winter Clothes", "=ds=#p8# (250)", "50 #silver#"};
				{ 5, 34413, "", "=q1=Recipe: Hot Apple Cider", "#p3# (325)", "1 #gold#"};
				{ 6, 17201, "", "=q1=Recipe: Egg Nog", "=ds=#p3# (35)", "2 #silver# 40 #copper#"};
				{ 7, 17200, "", "=q1=Recipe: Gingerbread Cookie", "=ds=#p3# (1)", "25 #copper#"};
				{ 8, 17344, "", "=q1=Candy Cane", "=ds=#e3#", "25 #copper#"};
				{ 9, 17406, "", "=q1=Holiday Cheesewheel", "=ds=#e3#", "1 #silver# 25 #copper#"};
				{ 10, 17407, "", "=q1=Graccu's Homemade Meat Pie", "=ds=#e3#", "10 #silver#"};
				{ 11, 17408, "", "=q1=Spicy Beefstick", "=ds=#e3#", "20 #silver#"};
				{ 12, 34410, "", "=q1=Honeyed Holiday Ham", "=ds=#e3#", "40 #silver#"};
				{ 13, 17404, "", "=q1=Blended Bean Brew", "=ds=#e4#", "1 #silver# 25 #copper#"};
				{ 14, 17405, "", "=q1=Green Garden Tea", "=ds=#e4#", "10 #silver#"};
				{ 15, 34412, "", "=q1=Sparkling Apple Cider", "=ds=#e4#", "10 #silver#"};
				{ 16, 17196, "", "=q1=Holiday Spirits", "=ds=#e4#", "50 #copper#"};
				{ 17, 17403, "", "=q1=Steamwheedle Fizzy Spirits", "=ds=#e4#", "1 #silver# 50 #copper#"};
				{ 18, 17402, "", "=q1=Greatfather's Winter Ale", "=ds=#e4#", "20 #silver#"};
				{ 19, 17194, "", "=q1=Holiday Spices", "=ds=#e8#", "10 #copper#"};
				{ 20, 17303, "", "=q1=Blue Ribboned Wrapping Paper", "=ds=#e6#", "10 #copper#"};
				{ 21, 17304, "", "=q1=Green Ribboned Wrapping Paper", "=ds=#e6#", "10 #copper#"};
				{ 22, 17307, "", "=q1=Purple Ribboned Wrapping Paper", "=ds=#e6#", "10 #copper#"};
				{ 23, 17202, "", "=q1=Snowball", "=ds=#m20#", "10 #copper#"};
				extraText = ": "..AL["Vendor"];
			};
			{
				{ 1, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Ticking Present"], ""};
				{ 2, 21325, "", "=q2=Mechanical Greench", "=ds=#e22#"};
				{ 3, 21213, "", "=q2=Preserved Holly", "=ds=#m20#"};
				{ 4, 17706, "", "=q2=Plans: Edge of Winter", "=ds=#p2# (190)"};
				{ 5, 17725, "", "=q2=Formula: Enchant Weapon - Winter's Might", "=ds=#p4# (190)"};
				{ 6, 17720, "", "=q2=Schematic: Snowmaster 9000", "=ds=#p5# (190)"};
				{ 7, 17722, "", "=q2=Pattern: Gloves of the Greatfather", "=ds=#p7# (190)"};
				{ 8, 17709, "", "=q1=Recipe: Elixir of Frost Power", "=ds=#p1# (190)"};
				{ 9, 17724, "", "=q1=Pattern: Green Holiday Shirt", "=ds=#p8# (190)"};
				{ 11, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Festive Gift"], ""};
				{ 12, 21328, "", "=q1=Wand of Holiday Cheer", "=ds=#m20#"};
				{ 16, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Gaily Wrapped Present"], ""};
				{ 17, 21301, "", "=q1=Green Helper Box", "=ds=#e13#"};
				{ 18, 21308, "", "=q1=Jingling Bell", "=ds=#e13#"};
				{ 19, 21305, "", "=q1=Red Helper Box", "=ds=#e13#"};
				{ 20, 21309, "", "=q1=Snowman Kit", "=ds=#e13#"};
				{ 22, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Gently Shaken Gift"], ""};
				{ 23, 21235, "", "=q1=Winter Veil Roast", "=ds=#e3#"};
				{ 24, 21241, "", "=q1=Winter Veil Eggnog", "=ds=#e4#"};
				{ 26, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Carefully Wrapped Present"], ""};
				{ 27, 21254, "", "=q1=Winter Veil Cookie", "=ds=#e3#"};
				{ 29, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Smokywood Pastures Extra-Special Gift"], ""};
				{ 30, 21215, "", "=q1=Graccu's Mince Meat Fruitcake", "=ds=#e3#"};
				extraText = ": "..AL["Gifts & Presents"];
			};
			{
				{ 1, 0, "INV_Holiday_Christmas_Present_01", "=q6="..ALIL["Stolen Present"], "#QUESTID:7043#"};
				{ 2, 93625, "", "=q4=Miniature Winter Veil Tree", "=ds=#h1#, #w4#"};
				{ 3, 54436, "", "=q3=Blue Clockwork Rocket Bot", "=ds=#e13#"};
				{ 4, 73797, "", "=q3=Lump of Coal", "=ds=#e13#"};
				{ 5, 44606, "", "=q3=Toy Train Set", "=ds=#m20#"};
				{ 6, 45057, "", "=q3=Wind-Up Train Wrecker", "=ds=#m20#"};
				{ 7, 46725, "", "=q2=Red Rider Air Rifle", "=ds=#m20#"};
				{ 8, 54438, "", "=q2=Tiny Blue Ragdoll", "=ds=#m20#"};
				{ 9, 54437, "", "=q2=Tiny Green Ragdoll", "=ds=#m20#"};
				{ 10, 44481, "", "=q1=Grindgear Toy Gorilla", "=ds=#m20#"};
				{ 11, 44601, "", "=q3=Heavy Copper Racer", "=ds=#m20#"};
				{ 12, 34498, "", "=q3=Paper Zeppelin Kit", "=ds=#m20#"};
				{ 13, 44482, "", "=q3=Trusty Copper Racer", "=ds=#m20#"};
				{ 14, 44599, "", "=q3=Zippy Copper Racer", "=ds=#m20#"};
				extraText = ": "..ALIL["Stolen Present"];
			};
		};
		info = {
			name = AL["Feast of Winter Veil"],
			module = moduleName, menu = "WINTERVIELMENU",
		};
	};

		--------------------
		--- Hallow's End ---
		--------------------

	AtlasLoot_Data["Halloween"] = {
		["Normal"] = {
			{
				{ 2, 33292, "", "=q3=Hallowed Helm", "=ds=#s1#, #a1#", "#HALLOWSEND:150#"};
				{ 3, 37011, "", "=q3=Magic Broom", "=ds=#e12#", "#HALLOWSEND:150#"};
				{ 4, 33154, "", "=q3=Sinister Squashling", "=ds=#e13#", "#HALLOWSEND:150#"};
				{ 5, 70722, "", "=q3=Little Wickerman", "=ds=#m20#", "#HALLOWSEND:150#"};
				{ 6, 70908, "", "=q1=Feline Familiar", "=ds=#e13#", "#HALLOWSEND:150#"};
				{ 7, 37604, "", "=q1=Tooth Pick", "=ds=#m20#", "#HALLOWSEND:2#", amount = 10};
				{ 8, 37585, "", "=q1=Chewy Fel Taffy", "=ds=#m20#", "#HALLOWSEND:2#", amount = 5};
				{ 9, 37583, "", "=q1=G.N.E.R.D.S.", "=ds=#m20#", "#HALLOWSEND:2#", amount = 5};
				{ 10, 37582, "", "=q1=Pyroblast Cinnamon Ball", "=ds=#m20#", "#HALLOWSEND:2#", amount = 5};
				{ 11, 37584, "", "=q1=Soothing Spearmint Candy", "=ds=#m20#", "#HALLOWSEND:2#", amount = 5};
				extraText = ": "..AL["Vendor"];
			};
			{
				{ 2, 69188, "", "=q1=Murloc Male Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 3, 69190, "", "=q1=Naga Male Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 4, 69193, "", "=q1=Ogre Male Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 5, 69195, "", "=q1=Vrykul Male Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 7, 20410, "", "=q1=Hallowed Wand - Bat", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 8, 20409, "", "=q1=Hallowed Wand - Ghost", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 9, 20399, "", "=q1=Hallowed Wand - Leper Gnome", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 10, 20398, "", "=q1=Hallowed Wand - Ninja", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 17, 69187, "", "=q1=Murloc Female Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 18, 69189, "", "=q1=Naga Female Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 19, 69192, "", "=q1=Ogre Female Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 20, 69194, "", "=q1=Vrykul Female Mask", "=ds=#m20#", "#HALLOWSEND:5#"};
				{ 22, 20397, "", "=q1=Hallowed Wand - Pirate", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 23, 20413, "", "=q1=Hallowed Wand - Random", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 24, 20411, "", "=q1=Hallowed Wand - Skeleton", "=ds=#e25#", "#HALLOWSEND:2#"};
				{ 25, 20414, "", "=q1=Hallowed Wand - Wisp", "=ds=#e25#", "#HALLOWSEND:2#"};
				extraText = ": "..AL["Non-Playable Race Masks"].." / "..BabbleInventory["Wands"];
			};
			{
				{ 2, 34003, "", "=q1=Draenei Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 3, 20561, "", "=q1=Dwarf Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 4, 20391, "", "=q1=Gnome Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 5, 49210, "", "=q1=Goblin Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 6, 20566, "", "=q1=Human Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 7, 20564, "", "=q1=Night Elf Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 8, 34002, "", "=q1=Blood Elf Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 9, 20570, "", "=q1=Orc Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 10, 20572, "", "=q1=Tauren Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 11, 20568, "", "=q1=Troll Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 12, 20573, "", "=q1=Undead Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 13, 49216, "", "=q1=Worgen Male Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 17, 34001, "", "=q1=Draenei Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 18, 20562, "", "=q1=Dwarf Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 19, 20392, "", "=q1=Gnome Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 20, 49212, "", "=q1=Goblin Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 21, 20565, "", "=q1=Human Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 22, 20563, "", "=q1=Night Elf Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 23, 34000, "", "=q1=Blood Elf Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 24, 20569, "", "=q1=Orc Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 25, 20571, "", "=q1=Tauren Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 26, 20567, "", "=q1=Troll Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 27, 20574, "", "=q1=Undead Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				{ 28, 49215, "", "=q1=Worgen Female Mask", "=ds=#s1#", "#HALLOWSEND:2#"};
				extraText = ": "..AL["Playable Race Masks"];
			};
		};
		info = {
			name = AL["Hallow's End"],
			module = moduleName, menu = "HALLOWSENDMENU",
		};
	};

	AtlasLoot_Data["HeadlessHorseman"] = {
		["Normal"] = {
			{
				{ 1, 88167, "", "=q4=Band of the Petrified Pumpkin", "=ds=#s13#"};
				{ 2, 88168, "", "=q4=Seal of Ghoulish Glee", "=ds=#s13#"};
				{ 3, 88169, "", "=q4=The Horseman's Ring", "=ds=#s13#"};
				{ 4, 88166, "", "=q4=Wicked Witch's Signet", "=ds=#s13#"};
				{ 6, 34068, "", "=q1=Weighted Jack-o'-Lantern", "=ds=#m20#", "", "100%"};
				{ 7, 33226, "", "=q1=Tricky Treat", "=ds=#m20#"};
				{ 16, 54516, "", "=q3=Loot-Filled Pumpkin", "=q5="..AL["Daily Reward"]};
				{ 17, 87569, "", "=q4=The Horseman's Horrific Hood", "=ds=#s1#, #a4#"};
				{ 18, 87570, "", "=q4=The Horseman's Sinister Slicer", "=ds=#h1#, #w10#"};
				{ 19, 37012, "", "=q4=The Horseman's Reins", "=ds=#e12#"};
				{ 20, 33292, "", "=q3=Hallowed Helm", "=ds=#s1#, #a1#"};
				{ 21, 37011, "", "=q3=Magic Broom", "=ds=#e12#"};
				{ 22, 33154, "", "=q3=Sinister Squashling", "=ds=#e13#"};
			};
		};
		info = {
			name = BabbleBoss["Headless Horseman"],
			module = moduleName, menu = "HALLOWSENDMENU",
		};
	};

		------------------------
		--- Harvest Festival ---
		------------------------

	AtlasLoot_Data["HarvestFestival"] = {
		["Normal"] = {
			{
				{ 2, 19995, "", "=q1=Harvest Boar", "=ds=#e3#"};
				{ 3, 19996, "", "=q1=Harvest Fish", "=ds=#e3#"};
				{ 4, 19994, "", "=q1=Harvest Fruit", "=ds=#e3#"};
				{ 5, 19997, "", "=q1=Harvest Nectar", "=ds=#e4#"};
				{ 17, 19697, "", "=q1=Bounty of the Harvest", "=q1=#m4#: =ds=#m20#"};
				{ 18, 20009, "", "=q1=For the Light!", "=ds=#e10# =ec1=#m7#", "=q1=#m4#: #QUESTID:8149#"};
				{ 19, 20010, "", "=q1=The Horde's Hellscream", "=ds=#e10# =ec1=#m6#", "=q1=#m4#: #QUESTID:8150#"};
			};
		};
		info = {
			name = AL["Harvest Festival"],
			module = moduleName, menu = "WORLDEVENTMENU", 
		};
	};

		--------------------------
		--- Love is in the Air ---
		--------------------------

	AtlasLoot_Data["Valentineday"] = {
		["Normal"] = {
			{
				{ 1, 72146, "", "=q4=Swift Lovebird", "=ds=#e26#", "#VALENTINEDAY:270#"};
				{ 2, 34480, "", "=q3=Romantic Picnic Basket", "=ds=#m20#", "#VALENTINEDAY:10#"};
				{ 3, 22235, "", "=q1=Truesilver Shafted Arrow", "=ds=#e13#", "#VALENTINEDAY:40#"};
				{ 4, 22200, "", "=q1=Silver Shafted Arrow", "=ds=#e13#", "#VALENTINEDAY:5#", amount = 5};
				{ 5, 50161, "", "=q1=Dinner Suit Box", "=ds=#m20#", "#VALENTINEDAY:20#"};
				{ 6, 50160, "", "=q1=Lovely Dress Box", "=ds=#m20#", "#VALENTINEDAY:20#"};
				{ 7, 22261, "", "=q1=Love Fool", "=ds=#e22#", "#VALENTINEDAY:10#"};
				{ 8, 34258, "", "=q1=Love Rocket", "=ds=#e23#", "#VALENTINEDAY:5#", amount = 5};
				{ 9, 50163, "", "=q1=Lovely Rose", "=ds=#m20#", "#VALENTINEDAY:5#", amount = 5};
				{ 10, 22218, "", "=q1=Handful of Rose Petals", "=ds=#m20#", "#VALENTINEDAY:2#", amount = 5};
				{ 11, 21813, "", "=q1=Bag of Heart Candies", "=ds=#m20#", "#VALENTINEDAY:2#"};
				{ 12, 21812, "", "=q1=Box of Chocolates", "=ds=#m20#", "#VALENTINEDAY:10#"};
				{ 13, 21815, "", "=q1=Love Token", "=ds=#m17#", "1 #valentineday2#"};
				{ 16, 49859, "", "=q1=\"Bravado\" Cologne", "=ds=#e2#", "#VALENTINEDAY:1#", amount = 5};
				{ 17, 49861, "", "=q1=\"STALWART\" Cologne", "=ds=#e2#", "#VALENTINEDAY:1#", amount = 5};
				{ 18, 49860, "", "=q1=\"Wizardry\" Cologne", "=ds=#e2#", "#VALENTINEDAY:1#", amount = 5};
				{ 19, 49858, "", "=q1=\"Forever\" Perfume", "=ds=#e2#", "#VALENTINEDAY:1#", amount = 5};
				{ 20, 49857, "", "=q1=\"Enchantress\" Perfume", "=ds=#e2#", "#VALENTINEDAY:1#", amount = 5};
				{ 21, 49856, "", "=q1=\"VICTORY\" Perfume", "=ds=#e2#", "#VALENTINEDAY:1#", amount = 5};
				extraText = ": "..AL["Vendor"];
			};
			{
				{ 1, 0, "INV_Box_02", "=q6="..ALIL["Lovely Dress Box"], "#ACHIEVEMENTID:1694#"};
				{ 2, 22279, "", "=q1=Lovely Black Dress", "=ds=#s5#"};
				{ 3, 22276, "", "=q1=Lovely Red Dress", "=ds=#s5#"};
				{ 4, 22278, "", "=q1=Lovely Blue Dress", "=ds=#s5#"};
				{ 5, 22280, "", "=q1=Lovely Purple Dress", "=ds=#s5#"};	
				{ 7, 0, "INV_Box_01", "=q6="..ALIL["Dinner Suit Box"], ""};
				{ 8, 22277, "", "=q1=Red Dinner Suit", "=ds=#s5#"};
				{ 9, 22281, "", "=q1=Blue Dinner Suit", "=ds=#s5#"};
				{ 10, 22282, "", "=q1=Purple Dinner Suit", "=ds=#s5#"};	
				{ 16, 0, "INV_ValentinesBoxOfChocolates02", "=q6="..ALIL["Box of Chocolates"], "#ACHIEVEMENTID:1702#"};
				{ 17, 22237, "", "=q1=Dark Desire", "=ds=#e3#"};
				{ 18, 22238, "", "=q1=Very Berry Cream", "=ds=#e3#"};
				{ 19, 22236, "", "=q1=Buttermilk Delight", "=ds=#e3#"};
				{ 20, 22239, "", "=q1=Sweet Surprise ", "=ds=#e3#"};
				{ 22, 0, "inv_valentinescandysack", "=q6="..ALIL["Bag of Heart Candies"], "#ACHIEVEMENTID:1701#"};
				{ 23, 21816, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 24, 21817, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 25, 21818, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 26, 21819, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 27, 21820, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 28, 21821, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 29, 21822, "", "=q1=Heart Candy", "=ds=#m20#"};
				{ 30, 21823, "", "=q1=Heart Candy", "=ds=#m20#"};
				extraText = ": "..AL["Misc"];
			};
		};
		info = {
			name = AL["Love is in the Air"],
			module = moduleName, menu = "LOEVISINTHEAIRMENU", 
		};
	};

	AtlasLoot_Data["ApothecaryHummel"] = {
		["Normal"] = {
			{
				{ 1, 93394, "", "=q4=Choker of the Pure Heart", "=ds=#s2#"};
				{ 2, 93391, "", "=q4=Heartbreak Charm", "=ds=#s2#"};
				{ 3, 93395, "", "=q4=Shard of Pirouetting Happiness", "=ds=#s2#"};
				{ 4, 93393, "", "=q4=Sweet Perfume Broach", "=ds=#s2#"};
				{ 5, 93392, "", "=q4=Winking Eye of Love", "=ds=#s2#"};
				{ 16, 54537, "", "=q3=Heart-Shaped Box", "=q5="..AL["Daily Reward"]};
				{ 17, 50250, "", "=q4=Big Love Rocket", "=ds=#e12#"};
				{ 18, 50446, "", "=q3=Toxic Wasteling", "=ds=#e13#"};
				{ 19, 50471, "", "=q3=The Heartbreaker", "=ds=#m20#"};
				{ 21, 49715, "", "=q3=Forever-Lovely Rose", "=ds=#s1#"};
				{ 22, 50741, "", "=q3=Vile Fumigator's Mask", "=ds=#s1#, #a1#"};
			};
		};
		info = {
			name = BabbleBoss["Apothecary Hummel"],
			module = moduleName, menu = "LOEVISINTHEAIRMENU",
		};
	};

		----------------------
		--- Lunar Festival ---
		----------------------

	AtlasLoot_Data["LunarFestival"] = {
		["Normal"] = {
			{
				{ 1, 74611, "", "=q3=Festival Lantern", "=ds=#e13#", "#LUNARFESTIVAL:50#"};
				{ 2, 74610, "", "=q3=Lunar Lantern", "=ds=#e13#", "#LUNARFESTIVAL:50#"};
				{ 3, 21157, "", "=q1=Festive Green Dress", "=ds=#s5#", "#LUNARFESTIVAL:5#"};
				{ 4, 21538, "", "=q1=Festive Pink Dress", "=ds=#s5#", "#LUNARFESTIVAL:5#"};
				{ 5, 21539, "", "=q1=Festive Purple Dress", "=ds=#s5#", "#LUNARFESTIVAL:5#"};
				{ 6, 21541, "", "=q1=Festive Black Pant Suit", "=ds=#s5#", "#LUNARFESTIVAL:5#"};
				{ 7, 21544, "", "=q1=Festive Blue Pant Suit", "=ds=#s5#", "#LUNARFESTIVAL:5#"};
				{ 8, 21543, "", "=q1=Festive Teal Pant Suit", "=ds=#s5#", "#LUNARFESTIVAL:5#"};
				{ 9, 21537, "", "=q1=Festival Dumplings", "=ds=#e3#", "#LUNARFESTIVAL:1#"};
				{ 10, 21721, "", "=q1=Moonglow", "=ds=#e4#", "15 #copper#"};
				{ 11, 21713, "", "=q1=Elune's Candle", "=ds=#m20#", "10 #silver#"};
				{ 12, 21558, "", "=q1=Small Blue Rocket", "=ds=#e23#", "25 #copper#"};
				{ 13, 21559, "", "=q1=Small Green Rocket", "=ds=#e23#", "25 #copper#"};
				{ 14, 21557, "", "=q1=Small Red Rocket", "=ds=#e23#", "25 #copper#"};
				{ 15, 21571, "", "=q1=Blue Rocket Cluster", "=ds=#e23#", "1 #silver#"};
				{ 16, 21574, "", "=q1=Green Rocket Cluster", "=ds=#e23#", "1 #silver#"};
				{ 17, 21576, "", "=q1=Red Rocket Cluster", "=ds=#e23#", "1 #silver#"};
				{ 18, 21747, "", "=q1=Festival Firecracker", "=ds=#e23#", "1 #silver#"};
				{ 20, 21640, "", "=q1=Lunar Festival Fireworks Pack", "=ds=#e23#", "#LUNARFESTIVAL:5#"};
				{ 21, 21558, "", "=q1=Small Blue Rocket", "=ds=#e23#"};
				{ 22, 21559, "", "=q1=Small Green Rocket", "=ds=#e23#"};
				{ 23, 21557, "", "=q1=Small Red Rocket", "=ds=#e23#"};
				{ 24, 21561, "", "=q1=Small White Rocket", "=ds=#e23#"};
				{ 25, 21562, "", "=q1=Small Yellow Rocket", "=ds=#e23#"};
				{ 26, 21589, "", "=q1=Large Blue Rocket", "=ds=#e23#"};
				{ 27, 21590, "", "=q1=Large Green Rocket", "=ds=#e23#"};
				{ 28, 21592, "", "=q1=Large Red Rocket", "=ds=#e23#"};
				{ 29, 21593, "", "=q1=Large White Rocket", "=ds=#e23#"};
				{ 30, 21595, "", "=q1=Large Yellow Rocket", "=ds=#e23#"};
				extraText = ": "..AL["Vendor"];
			};
			{
				{ 1, 21738, "", "=q2=Schematic: Firework Launcher ", "=ds=#p5# (225)", "#LUNARFESTIVAL:5#"};
				{ 3, 21740, "", "=q1=Small Rocket Recipes", "=ds=#p5# (125)", "#LUNARFESTIVAL:5#"};
				{ 4, 21724, "", "=q2=Schematic: Small Blue Rocket", "=ds=#p5# (125)"};
				{ 5, 21725, "", "=q2=Schematic: Small Green Rocket", "=ds=#p5# (125)"};
				{ 6, 21726, "", "=q2=Schematic: Small Red Rocket", "=ds=#p5# (125)"};
				{ 8, 21742, "", "=q1=Large Rocket Recipes", "=ds=#p5# (175)", "#LUNARFESTIVAL:5#"};
				{ 9, 21727, "", "=q2=Schematic: Large Blue Rocket", "=ds=#p5# (175)"};
				{ 10, 21728, "", "=q2=Schematic: Large Green Rocket", "=ds=#p5# (175)"};
				{ 11, 21729, "", "=q2=Schematic: Large Red Rocket", "=ds=#p5# (175)"};
				{ 13, 44916, "", "=q2=Pattern: Festival Dress", "=ds=#p8# (250)", "#LUNARFESTIVAL:5#"};
				{ 16, 21737, "", "=q2=Schematic: Cluster Launcher", "=ds=#p5# (275)"};
				{ 18, 21741, "", "=q1=Cluster Rocket Recipes", "=ds=#p5# (225)", "#LUNARFESTIVAL:5#"};
				{ 19, 21730, "", "=q2=Schematic: Blue Rocket Cluster", "=ds=#p5# (225)"};
				{ 20, 21731, "", "=q2=Schematic: Green Rocket Cluster", "=ds=#p5# (225)"};
				{ 21, 21732, "", "=q2=Schematic: Red Rocket Cluster", "=ds=#p5# (225)"};
				{ 23, 21743, "", "=q1=Large Cluster Rocket Recipes", "=ds=#p5# (275)", "#LUNARFESTIVAL:5#"};
				{ 24, 21733, "", "=q2=Schematic: Large Blue Rocket Cluster", "=ds=#p5# (275)"};
				{ 25, 21734, "", "=q2=Schematic: Large Green Rocket Cluster", "=ds=#p5# (275)"};
				{ 26, 21735, "", "=q2=Schematic: Large Red Rocket Cluster", "=ds=#p5# (275)"};
				{ 28, 44917, "", "=q2=Pattern: Festival Suit", "=ds=#p8# (250)", "#LUNARFESTIVAL:5#"};
				extraText = ": "..AL["Schematics & Patterns"];
			};
		};
		info = {
			name = AL["Lunar Festival"],
			module = moduleName, menu = "LUNARFESTIVALMENU", 
		};
	};

		-------------------------------
		--- Midsummer Fire Festival ---
		-------------------------------

	AtlasLoot_Data["MidsummerFestival"] = {
		["Normal"] = {
			{
				{ 1, 34686, "", "=q3=Brazier of Dancing Flames", "", "#MIDSUMMER:350#"};
				{ 2, 23083, "", "=q3=Captured Flame", "=ds=#e13#", "#MIDSUMMER:350#"};
				{ 4, 23379, "", "=q2=Cinder Bracers", "=ds=#e22#"};
				{ 6, 23246, "", "=q1=Fiery Festival Brew", "", "#MIDSUMMER:2#"};
				{ 7, 23435, "", "=q1=Elderberry Pie", "", "#MIDSUMMER:5#", amount = 5};
				{ 8, 23327, "", "=q1=Fire-Toasted Bun", "", "#MIDSUMMER:5#", amount = 5};
				{ 9, 23326, "", "=q1=Midsummer Sausage", "", "#MIDSUMMER:5#", amount = 5};
				{ 10, 23211, "", "=q1=Toasted Smorc", "", "#MIDSUMMER:5#", amount = 5};
				{ 11, 34684, "", "=q1=Handful of Summer Petals", "", "#MIDSUMMER:2#"};
				{ 12, 23215, "", "=q1=Bag of Smorc Ingredients", "", "#MIDSUMMER:5#", amount = 5};
				{ 13, 34599, "", "=q1=Juggling Torch", "", "#MIDSUMMER:5#", amount = 5};
				{ 15, 23247, "", "=q1=Burning Blossom", "=ds=#m17#"};
				{ 16, 23323, "", "=q1=Crown of the Fire Festival", "=ds=#s1#, #a1#, #m4#"};
				{ 17, 74278, "", "=q1=Helm of the Fire Festival", "=ds=#s1#"};
				{ 18, 23324, "", "=q1=Mantle of the Fire Festival", "=ds=#s3#", "#MIDSUMMER:100#"};
				{ 19, 34685, "", "=q1=Vestment of Summer", "=ds=#s5#", "#MIDSUMMER:100#"};
				{ 20, 34683, "", "=q1=Sandals of Summer", "=ds=#s11#", "#MIDSUMMER:200#"};
			};
		};
		info = {
			name = AL["Midsummer Fire Festival"],
			module = moduleName, menu = "WORLDEVENTMENU", instance = "MidsummerFestival",
		};
	};

	AtlasLoot_Data["LordAhune"] = {
		["Normal"] = {
			{
				{ 1, 95425, "", "=q4=Cloak of the Frigid Winds", "=ds=#s4#"};
				{ 2, 95427, "", "=q4=Icebound Cloak", "=ds=#s4#"};
				{ 3, 95428, "", "=q4=Shroud of Winter's Chill", "=ds=#s4#"};
				{ 4, 95429, "", "=q4=The Frost Lord's Battle Shroud", "=ds=#s4#"};
				{ 5, 95430, "", "=q4=The Frost Lord's War Cloak", "=ds=#s4#"};
				{ 7, 35498, "", "=q3=Formula: Enchant Weapon - Deathfrost", "=ds=#p4# (350)"};
				{ 9, 35723, "", "=q1=Shards of Ahune", "=ds=#m2#"};
				{ 10, 35279, "", "=q3=Tabard of Summer Skies", "=q1=#m4#: =ds=#s7#"};
				{ 11, 35280, "", "=q3=Tabard of Summer Flames", "=q1=#m4#: =ds=#s7#"};
				{ 16, 54536, "", "=q3=Satchel of Chilled Goods", "=q5="..AL["Daily Reward"]};
				{ 17, 95426, "", "=q4=Frostscythe of Lord Ahune", "=ds=#w9#"};
				{ 18, 53641, "", "=q3=Ice Chip", "=ds=#e13#"};
			};
		};
		info = {
			name = BabbleBoss["Ahune"],
			module = moduleName, menu = "WORLDEVENTMENU", instance = "MidsummerFestival",
		};
	};

		-------------------
		--- Noblegarden ---
		-------------------

	AtlasLoot_Data["Noblegarden"] = {
		["Normal"] = {
			{
				{ 2, 72145, "", "=q4=Swift Springstrider", "=ds=#e26#", "#NOBLEGARDEN:500#"},
				{ 3, 44793, "", "=q3=Tome of Polymorph: Rabbit", "=ds=#e10#", "#NOBLEGARDEN:100#"};
				{ 4, 44794, "", "=q3=Spring Rabbit's Foot", "=ds=#e13#", "#NOBLEGARDEN:100#"};
				{ 5, 45073, "", "=q1=Spring Flowers", "=ds=#h1#", "#NOBLEGARDEN:50#"};
				{ 6, 44792, "", "=q1=Blossoming Branch", "=ds=#e25#", "#NOBLEGARDEN:10#"};
				{ 7, 44818, "", "=q1=Noblegarden Egg", "=ds=", "#NOBLEGARDEN:5#"};
				{ 9, 45067, "", "=q1=Egg Basket", "=q1=#m4#: =ds=#s15#"};
				{ 10, 44791, "", "=q1=Noblegarden Chocolate", "=ds=#e3#"};
				{ 17, 44803, "", "=q1=Spring Circlet", "=ds=#s1#", "#NOBLEGARDEN:50#"};
				{ 18, 74282, "", "=q1=Black Spring Circlet", "=ds=#s1#", "#NOBLEGARDEN:50#"};
				{ 19, 74283, "", "=q1=Pink Spring Circlet", "=ds=#s1#", "#NOBLEGARDEN:50#"};
				{ 20, 19028, "", "=q1=Elegant Dress", "=ds=#s5#", "#NOBLEGARDEN:50#"};
				{ 21, 44800, "", "=q1=Spring Robes", "=ds=#s5#", "#NOBLEGARDEN:50#"};
				{ 22, 6833, "", "=q1=White Tuxedo Shirt", "=ds=#s6#", "#NOBLEGARDEN:25#"};
				{ 23, 6835, "", "=q1=Black Tuxedo Pants", "=ds=#s11#", "#NOBLEGARDEN:25#"};
			};
		};
		info = {
			name = AL["Noblegarden"],
			module = moduleName, menu = "WORLDEVENTMENU"
		};
	};

		------------------------
		--- Pilgrim's Bounty ---
		------------------------

	AtlasLoot_Data["PilgrimsBounty"] = {
		["Normal_A"] = {
			{
				{ 1, 44810, "", "=q3=Turkey Cage", "=ds=#e13#", "#ACHIEVEMENTID:1694#"};
				{ 3, 46809, "", "=q2=Bountiful Cookbook", "=ds=#p3# #e10# (1)", "=ds=10 #silver#"};
				{ 4, 44860, "", "=q1=Recipe: Spice Bread Stuffing", "=ds=#p3# (1)"};
				{ 5, 44862, "", "=q1=Recipe: Pumpkin Pie", "=ds=#p3# (100)"};
				{ 6, 44858, "", "=q1=Recipe: Cranberry Chutney", "=ds=#p3# (160)"};
				{ 7, 44859, "", "=q1=Recipe: Candied Sweet Potato", "=ds=#p3# (220)"};
				{ 8, 44861, "", "=q1=Recipe: Slow-Roasted Turkey", "=ds=#p3# (280)"};
				{ 10, 46888, "", "=q1=Bountiful Basket", "=ds=#e3#, #p3# (350)", "=ds=20 #silver#"};
				{ 11, 44855, "", "=q1=Teldrassil Sweet Potato", "=ds=#e3#", "=ds=25 #copper#", amount = 5};
				{ 12, 44854, "", "=q1=Tangy Wetland Cranberries", "=ds=#e3#", "=ds=25 #copper#", amount = 5};
				{ 13, 46784, "", "=q1=Ripe Elwynn Pumpkin", "=ds=#e3#", "=ds=25 #copper#", amount = 5};
				{ 14, 44835, "", "=q1=Autumnal Herbs", "=ds=#e6#", "=ds=10 #copper#", amount = 5};
				{ 15, 44853, "", "=q1=Honey", "=ds=#e6#", "=ds=25 #copper#", amount = 5};
				{ 16, 44844, "", "=q1=Turkey Caller", "=ds=", "=q1=#m4#: #QUESTID:14035#"};
				{ 18, 46723, "", "=q1=Pilgrim's Hat", "=ds=#s1#", "=ds="..AL["Daily Reward"]};
				{ 19, 46800, "", "=q1=Pilgrim's Attire", "=ds=#s5#", "=ds="..AL["Daily Reward"]};
				{ 20, 44785, "", "=q1=Pilgrim's Dress", "=ds=#s5#", "=ds="..AL["Daily Reward"]};
				{ 21, 46824, "", "=q1=Pilgrim's Robe", "=ds=#s5#", "=ds="..AL["Daily Reward"]};
				{ 22, 44788, "", "=q1=Pilgrim's Boots", "=ds=#s12#", "=ds="..AL["Daily Reward"]};
				{ 23, 44812, "", "=q1=Turkey Shooter", "=ds=", "=ds="..AL["Daily Reward"]};
			};
		};
		["Normal_H"] = {
			{
				{ 1, 44810, "", "=q3=Turkey Cage", "=q1=#m32#: =ds=#e13#", "#ACHIEVEMENTID:1694#"};
				{ 3, 46810, "", "=q2=Bountiful Cookbook", "=ds=#p3# #e10# (1)", "=ds=10 #silver#"};
				{ 4, 46803, "", "=q1=Recipe: Spice Bread Stuffing", "=ds=#p3# (1)"};
				{ 5, 46804, "", "=q1=Recipe: Pumpkin Pie", "=ds=#p3# (100)"};
				{ 6, 46805, "", "=q1=Recipe: Cranberry Chutney", "=ds=#p3# (160)"};
				{ 7, 46806, "", "=q1=Recipe: Candied Sweet Potato", "=ds=#p3# (220)"};
				{ 8, 46807, "", "=q1=Recipe: Slow-Roasted Turkey", "=ds=#p3# (280)"};
				{ 10, 46888, "", "=q1=Bountiful Basket", "=ds=#e3#, #p3# (350)", "=ds=20 #silver#"};
				{ 11, 46797, "", "=q1=Mulgore Sweet Potato", "=ds=#e3#", "=ds=25 #copper#", amount = 5};
				{ 12, 46793, "", "=q1=Tangy Southfury Cranberries ", "=ds=#e3#", "=ds=25 #copper#", amount = 5};
				{ 13, 46796, "", "=q1=Ripe Tirisfal Pumpkin ", "=ds=#e3#", "=ds=25 #copper#", amount = 5};
				{ 14, 44835, "", "=q1=Autumnal Herbs", "=ds=#e6#", "=ds=10 #copper#", amount = 5};
				{ 15, 44853, "", "=q1=Honey", "=ds=#e6#", "=ds=25 #copper#", amount = 5};		
				{ 16, 44844, "", "=q1=Turkey Caller", "=q1=#m4#: #QUESTID:14047#"};
				{ 18, 46723, "", "=q1=Pilgrim's Hat", "=ds=#s1#", "=ds="..AL["Daily Reward"]};
				{ 19, 46800, "", "=q1=Pilgrim's Attire", "=ds=#s5#", "=ds="..AL["Daily Reward"]};
				{ 20, 44785, "", "=q1=Pilgrim's Dress", "=ds=#s5#", "=ds="..AL["Daily Reward"]};
				{ 21, 46824, "", "=q1=Pilgrim's Robe", "=ds=#s5#", "=ds="..AL["Daily Reward"]};
				{ 22, 44788, "", "=q1=Pilgrim's Boots", "=ds=#s12#", "=ds="..AL["Daily Reward"]};
				{ 23, 44812, "", "=q1=Turkey Shooter", "=ds=", "=ds="..AL["Daily Reward"]};
			};
		};
		info = {
			name = AL["Pilgrim's Bounty"],
			module = moduleName, menu = "WORLDEVENTMENU"
		};
	};

	--------------------------
	--- Reaccouring Events ---
	--------------------------

		-------------------------------------
		--- Bash'ir Landing Skyguard Raid ---
		-------------------------------------

	AtlasLoot_Data["BashirLanding"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Phase 1"], "=q1="..AL["Aether-tech Assistant"]};
				{ 2, 32596, "", "=q1=Unstable Flask of the Elder", "=ds=#e2#", "", ""};
				{ 3, 32600, "", "=q1=Unstable Flask of the Physician", "=ds=#e2#", "", ""};
				{ 4, 32599, "", "=q1=Unstable Flask of the Bandit", "=ds=#e2#", "", ""};
				{ 5, 32597, "", "=q1=Unstable Flask of the Soldier", "=ds=#e2#", "", ""};
				{ 7, 0, "INV_Box_01", "=q6="..AL["Phase 2"], "=q1="..AL["Aether-tech Adept"]};
				{ 8, 32634, "", "=q3=Shifting Amethyst", "=ds=#e7#", "", ""};
				{ 9, 32637, "", "=q3=Deadly Citrine", "=ds=#e7#", "", ""};
				{ 10, 32638, "", "=q3=Reckless Citrine", "=ds=#e7#", "", ""};
				{ 11, 32635, "", "=q3=Timeless Peridot", "=ds=#e7#", "", ""};
				{ 12, 32636, "", "=q3=Purified Sapphire", "=ds=#e7#", "", ""};
				{ 13, 32639, "", "=q3=Jagged Mossjewel", "=ds=#e7#", "", ""};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Phase 3"], "=q1="..AL["Aether-tech Master"]};
				{ 17, 32641, "", "=q3=Imbued Unstable Diamond", "=ds=#e7#", "", ""};
				{ 18, 32640, "", "=q3=Tense Unstable Diamond", "=ds=#e7#", "", ""};
				{ 19, 32759, "", "=q1=Accelerator Module", "=ds=", "", ""};
				{ 20, 32630, "", "=q1=Small Gold Metamorphosis Geode", "=ds=", "", ""};
				{ 21, 32631, "", "=q1=Small Silver Metamorphosis Geode", "=ds=", "", ""};
				{ 22, 32627, "", "=q1=Small Copper Metamorphosis Geode", "=ds=", "", ""};
				{ 23, 32625, "", "=q1=Small Iron Metamorphosis Geode", "=ds=", "", ""};
				{ 24, 32629, "", "=q1=Large Gold Metamorphosis Geode", "=ds=", "", ""};
				{ 25, 32628, "", "=q1=Large Silver Metamorphosis Geode", "=ds=", "", ""};
				{ 26, 32626, "", "=q1=Large Copper Metamorphosis Geode", "=ds=", "", ""};
				{ 27, 32624, "", "=q1=Large Iron Metamorphosis Geode", "=ds=", "", ""};
			};
		};
		info = {
			name = AL["Bash'ir Landing Skyguard Raid"],
			module = moduleName, menu = "WORLDEVENTMENU"
		};
	};

		----------------------
		--- Darkmoon Faire ---
		----------------------

	AtlasLoot_Data["Darkmoon"] = {
		["Normal"] = {
			{
				{ 2, 73766, "", "=q4=Darkmoon Dancing Bear", "=ds=#e26#", "#DARKMOON:180#"},
				{ 3, 72140, "", "=q4=Swift Forest Strider", "=ds=#e26#", "#DARKMOON:180#"},
				{ 5, 73762, "", "=q3=Darkmoon Balloon", "=ds=#e13#", "#DARKMOON:90#"};
				{ 6, 74981, "", "=q3=Darkmoon Cub", "=ds=#e13#", "#DARKMOON:90#"};
				{ 7, 91003, "", "=q3=Darkmoon Hatchling", "=ds=#e13#", "#DARKMOON:90#"};
				{ 8, 73764, "", "=q3=Darkmoon Monkey", "=ds=#e13#", "#DARKMOON:90#"};
				{ 9, 73903, "", "=q3=Darkmoon Tonk", "=ds=#e13#", "#DARKMOON:90#"};
				{ 10, 73765, "", "=q3=Darkmoon Turtle", "=ds=#e13#", "#DARKMOON:90#"};
				{ 11, 73905, "", "=q3=Darkmoon Zeppelin", "=ds=#e13#", "#DARKMOON:90#"};
				{ 12, 11026, "", "=q1=Tree Frog Box", "=ds=#e13#", "1 #gold#"};
				{ 13, 11027, "", "=q1=Wood Frog Box", "=ds=#e13#", "1 #gold#"};
				{ 17, 80008, "", "=q4=Darkmoon Rabbit", "=ds=#e13#", "#ACHIEVEMENTID:6332#"};
				{ 18, 73953, "", "=q3=Sea Pony", "=ds=#e13#", "=q2=#p24#, =q1="..AL["Darkmoon Island"]};
				{ 20, 91040, "", "=q3=Darkmoon Eye", "=ds=#e13#", "=q1=#m4#: #QUESTID:32175#"};
				{ 21, 19450, "", "=q1=A Jubling's Tiny Home", "=ds=#e13#", "=q1=#m4#: #QUESTID:7946#"};
				{ 23, 75040, "", "=q1=Flimsy Darkmoon Balloon", "=ds=#e13#", "10 #silver#"},
				{ 24, 75041, "", "=q1=Flimsy Green Balloon", "=ds=#e13#", "10 #silver#"},
				{ 25, 75042, "", "=q1=Flimsy Yellow Balloon", "=ds=#e13#", "10 #silver#"},
				extraText = ": "..BabbleInventory["Mounts"].." & "..BabbleInventory["Companions"];
			};
			{
				{ 2, 78341, "", "=q3=Darkmoon Hammer", "=ds=#h2#, #w6#", "#DARKMOON:160#"},
				{ 3, 93732, "", "=q3=Darkmoon Fishing Cap", "=ds=#s1#", "#p24#: "..AL["Darkmoon Island"]},
				{ 4, 78340, "", "=q3=Cloak of the Darkmoon Faire", "=ds=#s4#", "#DARKMOON:90#"},
				{ 5, 90899, "", "=q3=Darkmoon Whistle", "=ds=#m20#", "#DARKMOON:90#"},
				{ 6, 77256, "", "=q1=Darkmoon \"Sword\"", "=ds=#h2#", "#DARKMOON:20#"},
				{ 7, 19295, "", "=q1=Darkmoon Flower", "=ds=#s15#", "#DARKMOON:1#"},
				{ 8, 19291, "", "=q1=Darkmoon Storage Box", "=ds=#e1#", "#DARKMOON:1#"},
				{ 9, 19292, "", "=q1=Last Month's Mutton", "=ds=#h1#, #w6#", "#DARKMOON:1#" },
				{ 10, 19293, "", "=q1=Last Year's Mutton", "=ds=#h1#, #w6#", "#DARKMOON:1#" },
				{ 11, 74142, "", "=q1=Darkmoon Firework", "=ds=#e23#", "1 #silver#"},
				{ 12, 93730, "", "=q1=Darkmoon Top Hat", "=ds=#m20#", "#DARKMOON:10#"},
				{ 13, 18662, "", "=q1=Heavy Leather Ball", "=ds=#m20#", "20 #copper#"},
				{ 17, 92959, "", "=q1=Darkmoon \"Cougar\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 18, 92966, "", "=q1=Darkmoon \"Dragon\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 19, 92967, "", "=q1=Darkmoon \"Gryphon\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 20, 92968, "", "=q1=Darkmoon \"Murloc\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 21, 92958, "", "=q1=Darkmoon \"Nightsaber\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 22, 92969, "", "=q1=Darkmoon \"Rocket\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 23, 92956, "", "=q1=Darkmoon \"Snow Leopard\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 24, 77158, "", "=q1=Darkmoon \"Tiger\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				{ 25, 92970, "", "=q1=Darkmoon \"Wyvern\"", "=ds=#m20#", "#DARKMOON:1#", amount = 10},
				extraText = ": "..AL["Toys"];
			};
			{
				{ 2, 19223, "", "=q1=Darkmoon Dog", "=ds=#e3#", "25 #copper#", amount = 5};
				{ 3, 19304, "", "=q1=Spiced Beef Jerky", "=ds=#e3#", "1 #silver# 25 #copper#", amount = 5};
				{ 4, 19305, "", "=q1=Pickled Kodo Foot", "=ds=#e3#", "5 #silver#", amount = 5};
				{ 5, 19224, "", "=q1=Red Hot Wings", "=ds=#e3#", "10 #silver#", amount = 5};
				{ 6, 19306, "", "=q1=Crunchy Frog", "=ds=#e3#", "20 #silver#", amount = 5};
				{ 7, 19225, "", "=q1=Deep Fried Candybar", "=ds=#e3#", "40 #silver#", amount = 5};
				{ 8, 33246, "", "=q1=Funnel Cake", "=ds=#e3#", "56 #silver#", amount = 5};
				{ 9, 33254, "", "=q1=Forest Strider Drumstick", "=ds=#e3#", "80 #silver#", amount = 5};
				{ 10, 44940, "", "=q1=Corn-Breaded Sausage", "=ds=#e3#", "1 #gold# 60 #silver#", amount = 5};
				{ 11, 73260, "", "=q1=Salty Sea Dog", "=ds=#e3#", "2 #gold#", amount = 5};
				{ 17, 75029, "", "=q1=Beer-Basted Short Ribs", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 18, 75031, "", "=q1=Draenic Dumplings", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 19, 75034, "", "=q1=Forsaken Foie Gras", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 20, 75030, "", "=q1=Gnomeregan Gnuggets", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 21, 75033, "", "=q1=Green Ham & Eggs", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 22, 75032, "", "=q1=Mulgore Meat Pie", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 23, 75036, "", "=q1=Silvermoon Steak", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 24, 75028, "", "=q1=Stormwind Surprise", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 25, 75027, "", "=q1=Teldrassil Tenderloin", "=ds=#e3#", "40 #silver#", amount = 5 },
				{ 26, 75035, "", "=q1=Troll Tartare", "=ds=#e3#", "40 #silver#", amount = 5 },
				extraText = ": "..AL["Food and Drinks"];
			};
			{
				{ 2, 19299, "", "=q1=Fizzy Faire Drink", "=ds=#e4#", "5 #silver#"};
				{ 3, 19300, "", "=q1=Bottled Winterspring Water", "=ds=#e4#", "20 #silver#", amount = 5};
				{ 4, 33234, "", "=q1=Iced Berry Slush", "=ds=#e4#", "40 #silver#", amount = 5};
				{ 5, 33236, "", "=q1=Fizzy Faire Drink 'Classic'", "=ds=#e4#", "56 #silver#", amount = 5};
				{ 6, 44941, "", "=q1=Fresh-Squeezed Limeade", "=ds=#e4#", "85 #silver#", amount = 5};
				{ 7, 74822, "", "=q1=Sasparilla Sinker", "=ds=#e4#", "1 #gold# 37 #silver# 50 #copper#", amount = 5};
				{ 17, 19222, "", "=q1=Cheap Beer", "=ds=#e4#", "10 #copper#"};
				{ 18, 19221, "", "=q1=Darkmoon Special Reserve", "=ds=#e4#", "50 #copper#"};
				{ 19, 93208, "", "=q1=Darkmoon P.I.E", "=ds=#e4#", "8 #gold#"};
				extraText = ": "..AL["Food and Drinks"];
			};
			{
				{ 1, 93859, "", "=q7=Bloodstained Dreadmist Mantle", "=ds=#s3#, #a1#", "#DARKMOON:44# #ITEM:42985:1#"};
				{ 2, 93864, "", "=q7=Majestic Ironfeather Shoulders", "=ds=#s3#, #a2#", "#DARKMOON:44# #ITEM:42984:1#"};
				{ 3, 93862, "", "=q7=Supple Shadowcraft Spaulders", "=ds=#s3#, #a2#", "#DARKMOON:44# #ITEM:42952:1#"};
				{ 4, 93887, "", "=q7=Grand Champion Herod's Shoulder", "=ds=#s3#, #a3#", "#DARKMOON:44# #ITEM:42950:1#"};
				{ 5, 93876, "", "=q7=Awakened Pauldrons of Elements", "=ds=#s3#, #a3#", "#DARKMOON:44# #ITEM:42951:1#"};
				{ 6, 93893, "", "=q7=Brushed Pauldrons of Might", "=ds=#s3#, #a4#", "#DARKMOON:44# #ITEM:69890:1#"};
				{ 7, 93890, "", "=q7=Gleaming Spaulders of Valor", "=ds=#s3#, #a4#", "#DARKMOON:44# #ITEM:42949:1#"};
				{ 9, 93860, "", "=q7=Bloodstained Dreadmist Robe", "=ds=#s5#, #a1#", "#DARKMOON:44# #ITEM:48691:1#"};
				{ 10, 93865, "", "=q7=Majestic Ironfeather Breastplate", "=ds=#s5#, #a2#", "#DARKMOON:44# #ITEM:48687:1#"};
				{ 11, 93863, "", "=q7=Supple Shadowcraft Tunic", "=ds=#s5#, #a2#", "#DARKMOON:44# #ITEM:48689:1#"};
				{ 12, 93888, "", "=q7=Furious Deathdealer Breastplate", "=ds=#s5#, #a3#", "#DARKMOON:44# #ITEM:48677:1#"};
				{ 13, 93885, "", "=q7=Awakened Vest of Elements", "=ds=#s5#, #a3#", "#DARKMOON:44# #ITEM:48683:1#"};
				{ 14, 93892, "", "=q7=Brushed Breastplate of Might", "=ds=#s5#, #a4#", "#DARKMOON:44# #ITEM:69889:1#"};
				{ 15, 93891, "", "=q7=Gleaming Breastplate of Valor", "=ds=#s5#, #a4#", "#DARKMOON:44# #ITEM:48685:1#"};
				{ 16, 42985, "", "=q7=Tattered Dreadmist Mantle", "=ds=#s3#, #a1#",  "#DARKMOON:110#"};
				{ 17, 42984, "", "=q7=Preened Ironfeather Shoulders", "=ds=#s3#, #a2#", "#DARKMOON:110#"};
				{ 18, 42952, "", "=q7=Stained Shadowcraft Spaulders", "=ds=#s3#, #a2#", "#DARKMOON:110#"};
				{ 19, 42950, "", "=q7=Champion Herod's Shoulder", "=ds=#s3#, #a3#", "#DARKMOON:110#"};
				{ 20, 42951, "", "=q7=Mystical Pauldrons of Elements", "=ds=#s3#, #a3#", "#DARKMOON:110#"};
				{ 21, 69890, "", "=q7=Burnished Pauldrons of Might", "=ds=#s3#, #a4#", "#DARKMOON:110#"};
				{ 22, 42949, "", "=q7=Polished Spaulders of Valor", "=ds=#s3#, #a4#", "#DARKMOON:110#"};
				{ 24, 48691, "", "=q7=Tattered Dreadmist Robe", "=ds=#s5#, #a1#", "#DARKMOON:110#"};
				{ 25, 48687, "", "=q7=Preened Ironfeather Breastplate", "=ds=#s5#, #a2#", "#DARKMOON:110#"};
				{ 26, 48689, "", "=q7=Stained Shadowcraft Tunic", "=ds=#s5#, #a2#", "#DARKMOON:110#"};
				{ 27, 48677, "", "=q7=Champion's Deathdealer Breastplate", "=ds=#s5#, #a3#", "#DARKMOON:110#"};
				{ 28, 48683, "", "=q7=Mystical Vest of Elements", "=ds=#s5#, #a3#", "#DARKMOON:110#"};
				{ 29, 69889, "", "=q7=Burnished Breastplate of Might", "=ds=#s5#, #a4#", "#DARKMOON:110#"};
				{ 30, 48685, "", "=q7=Polished Breastplate of Valor", "=ds=#s5#, #a4#", "#DARKMOON:110#"};
				extraText = ": "..AL["Heirloom"]..": "..BabbleInventory["Armor"];
			};
			{
				{ 1, 93897, "", "=q7=Piercing Eye of the Beast", "=ds=#s14#", "#DARKMOON:60# #ITEM:42992:1#"};
				{ 2, 93896, "", "=q7=Forceful Hand of Justice", "=ds=#s14#", "#DARKMOON:60# #ITEM:42991:1#"};
				{ 4, 93857, "", "=q7=Vengeful Heartseeker", "=ds=#h1#, #w4#", "#DARKMOON:44# #ITEM:42944:1#"};
				{ 5, 93845, "", "=q7=Gore-Steeped Skullforge Reaver", "=ds=#h1#, #w10#", "#DARKMOON:44# #ITEM:69893:1#"};
				{ 6, 93856, "", "=q7=Noble Dal'Rend's Sacred Charge", "=ds=#h1#, #w10#", "#DARKMOON:44# #ITEM:42945:1#"};
				{ 7, 93843, "", "=q7=Hardened Arcanite Reaper", "=ds=#h2#, #w1#", "#DARKMOON:64# #ITEM:42943:1#"};
				{ 8, 93853, "", "=q7=Pious Aurastone Hammer", "=ds=#h1#, #w6#", "#DARKMOON:44# #ITEM:42948:1#"};
				{ 9, 93847, "", "=q7=Crushing Mass of McGowan", "=ds=#h1#, #w6#", "#DARKMOON:44# #ITEM:48716:1#"};
				{ 10, 93846, "", "=q7=Re-Engineered Lava Dredger", "=ds=#h2#, #w6#", "#DARKMOON:64# #ITEM:48718:1#"};
				{ 11, 93844, "", "=q7=Refinished Warden Staff", "=ds=#w9#", "#DARKMOON:64# #ITEM:79131:1#"};
				{ 12, 93854, "", "=q7=Scholarly Headmaster's Charge", "=ds=#w9#", "#DARKMOON:64# #ITEM:42947:1#"};
				{ 13, 93855, "", "=q7=War-Torn Ancient Bone Bow", "=ds=#w2#", "#DARKMOON:64# #ITEM:42946:1#"};
				{ 16, 42992, "", "=q7=Discerning Eye of the Beast", "=ds=#s14#", "#DARKMOON:130#"};
				{ 17, 42991, "", "=q7=Swift Hand of Justice", "=ds=#s14#", "#DARKMOON:130#"};
				{ 19, 42944, "", "=q7=Balanced Heartseeker", "=ds=#h1#, #w4#", "#DARKMOON:110#"};
				{ 20, 69893, "", "=q7=Bloodsoaked Skullforge Reaver", "=ds=#h1#, #w10#", "#DARKMOON:110#"};
				{ 21, 42945, "", "=q7=Venerable Dal'Rend's Sacred Charge", "=ds=#h1#, #w10#", "#DARKMOON:110#"};
				{ 22, 42943, "", "=q7=Bloodied Arcanite Reaper", "=ds=#h2#, #w1#", "#DARKMOON:160#"};
				{ 23, 42948, "", "=q7=Devout Aurastone Hammer", "=ds=#h1#, #w6#", "#DARKMOON:110#"};
				{ 24, 48716, "", "=q7=Venerable Mass of McGowan", "=ds=#h1#, #w6#", "#DARKMOON:110#"};
				{ 25, 48718, "", "=q7=Repurposed Lava Dredger", "=ds=#h2#, #w6#", "#DARKMOON:160#"};
				{ 26, 79131, "", "=q7=Burnished Warden Staff", "=ds=#w9#", "#DARKMOON:160#"};
				{ 27, 42947, "", "=q7=Dignified Headmaster's Charge", "=ds=#w9#", "#DARKMOON:160#"};
				{ 28, 42946, "", "=q7=Charmed Ancient Bone Bow", "=ds=#w2#", "#DARKMOON:160#"};
				extraText = ": "..AL["Heirloom"]..": "..AL["Accessories"].." / "..AL["Weapons"];
			};
		};
		info = {
			name = ALIL["Darkmoon Faire"],
			module = moduleName, menu = "DARKMOONMENU"
		};
	};

	AtlasLoot_Data["DarkmoonD1D2"] = {
		["Normal"] = {
			{
				{ 1, 0, "ability_druid_maul", "=q6=#t0s1#", "=ec1=#j6# - #j9#"};
				{ 2, 78238, "", "=q3=Replica Wildheart Cowl", "=ds=#s1#, #a2#" },
				{ 3, 78239, "", "=q3=Replica Wildheart Spaulders", "=ds=#s3#, #a2#" },
				{ 4, 78242, "", "=q3=Replica Wildheart Vest", "=ds=#s5#, #a2#" },
				{ 5, 78240, "", "=q3=Replica Wildheart Bracers", "=ds=#s8#, #a2#" },
				{ 6, 78241, "", "=q3=Replica Wildheart Gloves", "=ds=#s9#, #a2#" },
				{ 7, 78244, "", "=q3=Replica Wildheart Belt", "=ds=#s10#, #a2#" },
				{ 8, 78245, "", "=q3=Replica Wildheart Kilt", "=ds=#s11#, #a2#" },
				{ 9, 78243, "", "=q3=Replica Wildheart Boots", "=ds=#s12#, #a2#" },
				{ 16, 0, "ability_druid_maul", "=q6=#t05s1#", "=ec1=#j7# - #j9#"};
				{ 17, 78249, "", "=q4=Replica Feralheart Cowl", "=ds=#s1#, #a2#" },
				{ 18, 78247, "", "=q3=Replica Feralheart Spaulders", "=ds=#s3#, #a2#" },
				{ 19, 78252, "", "=q4=Replica Feralheart Vest", "=ds=#s5#, #a2#" },
				{ 20, 78253, "", "=q3=Replica Feralheart Bracers", "=ds=#s8#, #a2#" },
				{ 21, 78248, "", "=q4=Replica Feralheart Gloves", "=ds=#s9#, #a2#" },
				{ 22, 78246, "", "=q3=Replica Feralheart Belt", "=ds=#s10#, #a2#" },
				{ 23, 78250, "", "=q3=Replica Feralheart Kilt", "=ds=#s11#, #a2#" },
				{ 24, 78251, "", "=q4=Replica Feralheart Boots", "=ds=#s12#, #a2#" },
			};
			{
				{ 1, 0, "inv_weapon_bow_07", "=q6=#t0s2#", "=ec1=#j6# - #j9#"};
				{ 2, 78275, "", "=q3=Replica Beaststalker's Cap", "=ds=#s1#, #a3#" },
				{ 3, 78273, "", "=q3=Replica Beaststalker's Mantle", "=ds=#s3#, #a3#" },
				{ 4, 78270, "", "=q3=Replica Beaststalker's Tunic", "=ds=#s5#, #a3#" },
				{ 5, 78277, "", "=q3=Replica Beaststalker's Bindings", "=ds=#s8#, #a3#" },
				{ 6, 78271, "", "=q3=Replica Beaststalker's Gloves", "=ds=#s9#, #a3#" },
				{ 7, 78274, "", "=q3=Replica Beaststalker's Belt", "=ds=#s10#, #a3#" },
				{ 8, 78276, "", "=q3=Replica Beaststalker's Pants", "=ds=#s11#, #a3#" },
				{ 9, 78272, "", "=q3=Replica Beaststalker's Boots", "=ds=#s12#, #a3#" },
				{ 16, 0, "inv_weapon_bow_07", "=q6=#t05s2#", "=ec1=#j7# - #j9#"};
				{ 17, 78284, "", "=q4=Replica Beastmaster's Cap", "=ds=#s1#, #a3#" },
				{ 18, 78281, "", "=q3=Replica Beastmaster's Mantle", "=ds=#s3#, #a3#" },
				{ 19, 78282, "", "=q4=Replica Beastmaster's Tunic", "=ds=#s5#, #a3#" },
				{ 20, 78283, "", "=q3=Replica Beastmaster's Bindings", "=ds=#s8#, #a3#" },
				{ 21, 78278, "", "=q4=Replica Beastmaster's Gloves", "=ds=#s9#, #a3#" },
				{ 22, 78285, "", "=q3=Replica Beastmaster's Belt", "=ds=#s10#, #a3#" },
				{ 23, 78280, "", "=q3=Replica Beastmaster's Pants", "=ds=#s11#, #a3#" },
				{ 24, 78279, "", "=q4=Replica Beastmaster's Boots", "=ds=#s12#, #a3#" },
			};
			{
				{ 1, 0, "inv_staff_13", "=q6=#t0s3#", "=ec1=#j6# - #j9#"};
				{ 2, 78188, "", "=q3=Replica Magister's Crown", "=ds=#s1#, #a1#" },
				{ 3, 78191, "", "=q3=Replica Magister's Mantle", "=ds=#s3#, #a1#" },
				{ 4, 78190, "", "=q3=Replica Magister's Robes", "=ds=#s5#, #a1#" },
				{ 5, 78193, "", "=q3=Replica Magister's Bindings", "=ds=#s8#, #a1#" },
				{ 6, 78187, "", "=q3=Replica Magister's Gloves", "=ds=#s9#, #a1#" },
				{ 7, 78192, "", "=q3=Replica Magister's Belt", "=ds=#s10#, #a1#" },
				{ 8, 78189, "", "=q3=Replica Magister's Leggings", "=ds=#s11#, #a1#" },
				{ 9, 78186, "", "=q3=Replica Magister's Boots", "=ds=#s12#, #a1#" },
				{ 16, 0, "inv_staff_13", "=q6=#t05s3#", "=ec1=#j7# - #j9#"};
				{ 17, 78198, "", "=q4=Replica Sorcerer's Crown", "=ds=#s1#, #a1#" },
				{ 18, 78201, "", "=q3=Replica Sorcerer's Mantle", "=ds=#s3#, #a1#" },
				{ 19, 78200, "", "=q4=Replica Sorcerer's Robes", "=ds=#s5#, #a1#" },
				{ 20, 78203, "", "=q3=Replica Sorcerer's Bindings", "=ds=#s8#, #a1#" },
				{ 21, 78197, "", "=q4=Replica Sorcerer's Gloves", "=ds=#s9#, #a1#" },
				{ 22, 78202, "", "=q3=Replica Sorcerer's Belt", "=ds=#s10#, #a1#" },
				{ 23, 78199, "", "=q3=Replica Sorcerer's Leggings", "=ds=#s11#, #a1#" },
				{ 24, 78196, "", "=q4=Replica Sorcerer's Boots", "=ds=#s12#, #a1#" },
			};
			{
				{ 1, 0, "ability_thunderbolt", "=q6=#t0s4#", "=ec1=#j6# - #j9#"};
				{ 2, 78307, "", "=q3=Replica Lightforge Helm", "=ds=#s1#, #a4#" },
				{ 3, 78308, "", "=q3=Replica Lightforge Spaulders", "=ds=#s3#, #a4#" },
				{ 4, 78306, "", "=q3=Replica Lightforge Breastplate", "=ds=#s5#, #a4#" },
				{ 5, 78304, "", "=q3=Replica Lightforge Bracers", "=ds=#s8#, #a4#" },
				{ 6, 78303, "", "=q3=Replica Lightforge Gauntlets", "=ds=#s9#, #a4#" },
				{ 7, 78302, "", "=q3=Replica Lightforge Belt", "=ds=#s10#, #a4#" },
				{ 8, 78305, "", "=q3=Replica Lightforge Legplates", "=ds=#s11#, #a4#" },
				{ 9, 78309, "", "=q3=Replica Lightforge Boots", "=ds=#s12#, #a4#" },
				{ 16, 0, "ability_thunderbolt", "=q6=#t05s4#", "=ec1=#j7# - #j9#"};
				{ 17, 78312, "", "=q4=Replica Soulforge Helm", "=ds=#s1#, #a4#" },
				{ 18, 78316, "", "=q3=Replica Soulforge Spaulders", "=ds=#s3#, #a4#" },
				{ 19, 78313, "", "=q4=Replica Soulforge Breastplate", "=ds=#s5#, #a4#" },
				{ 20, 78317, "", "=q3=Replica Soulforge Bracers", "=ds=#s8#, #a4#" },
				{ 21, 78314, "", "=q4=Replica Soulforge Gauntlets", "=ds=#s9#, #a4#" },
				{ 22, 78311, "", "=q3=Replica Soulforge Belt", "=ds=#s10#, #a4#" },
				{ 23, 78315, "", "=q3=Replica Soulforge Legplates", "=ds=#s11#, #a4#" },
				{ 24, 78310, "", "=q4=Replica Soulforge Boots", "=ds=#s12#, #a4#" },
			};
			{
				{ 1, 0, "inv_staff_30", "=q6=#t0s5#", "=ec1=#j6# - #j9#"};
				{ 2, 78205, "", "=q3=Replica Devout Crown", "=ds=#s1#, #a1#" },
				{ 3, 78204, "", "=q3=Replica Devout Mantle", "=ds=#s3#, #a1#" },
				{ 4, 78209, "", "=q3=Replica Devout Robe", "=ds=#s5#, #a1#" },
				{ 5, 78211, "", "=q3=Replica Devout Bracers", "=ds=#s8#, #a1#" },
				{ 6, 78208, "", "=q3=Replica Devout Gloves", "=ds=#s9#, #a1#" },
				{ 7, 78207, "", "=q3=Replica Devout Belt", "=ds=#s10#, #a1#" },
				{ 8, 78206, "", "=q3=Replica Devout Skirt", "=ds=#s11#, #a1#" },
				{ 9, 78210, "", "=q3=Replica Devout Sandals", "=ds=#s12#, #a1#" },
				{ 16, 0, "inv_staff_30", "=q6=#t05s5#", "=ec1=#j7# - #j9#"};
				{ 17, 78216, "", "=q4=Replica Virtuous Crown", "=ds=#s1#, #a1#" },
				{ 18, 78213, "", "=q3=Replica Virtuous Mantle", "=ds=#s3#, #a1#" },
				{ 19, 78212, "", "=q4=Replica Virtuous Robe", "=ds=#s5#, #a1#" },
				{ 20, 78215, "", "=q3=Replica Virtuous Bracers", "=ds=#s8#, #a1#" },
				{ 21, 78217, "", "=q4=Replica Virtuous Gloves", "=ds=#s9#, #a1#" },
				{ 22, 78218, "", "=q3=Replica Virtuous Belt", "=ds=#s10#, #a1#" },
				{ 23, 78214, "", "=q3=Replica Virtuous Skirt", "=ds=#s11#, #a1#" },
				{ 24, 78219, "", "=q4=Replica Virtuous Sandals", "=ds=#s12#, #a1#" },
			};
			{
				{ 1, 0, "inv_throwingknife_04", "=q6=#t0s6#", "=ec1=#j6# - #j9#"};
				{ 2, 78260, "", "=q3=Replica Shadowcraft Cap", "=ds=#s1#, #a2#" },
				{ 3, 78261, "", "=q3=Replica Shadowcraft Spaulders", "=ds=#s3#, #a2#" },
				{ 4, 78254, "", "=q3=Replica Shadowcraft Tunic", "=ds=#s5#, #a2#" },
				{ 5, 78255, "", "=q3=Replica Shadowcraft Bracers", "=ds=#s8#, #a2#" },
				{ 6, 78257, "", "=q3=Replica Shadowcraft Gloves", "=ds=#s9#, #a2#" },
				{ 7, 78259, "", "=q3=Replica Shadowcraft Belt", "=ds=#s10#, #a2#" },
				{ 8, 78258, "", "=q3=Replica Shadowcraft Pants", "=ds=#s11#, #a2#" },
				{ 9, 78256, "", "=q3=Replica Shadowcraft Boots", "=ds=#s12#, #a2#" },
				{ 16, 0, "inv_throwingknife_04", "=q6=#t05s6#", "=ec1=#j7# - #j9#"};
				{ 17, 78263, "", "=q4=Replica Darkmantle Cap", "=ds=#s1#, #a2#" },
				{ 18, 78267, "", "=q3=Replica Darkmantle Spaulders", "=ds=#s3#, #a2#" },
				{ 19, 78269, "", "=q4=Replica Darkmantle Tunic", "=ds=#s5#, #a2#" },
				{ 20, 78264, "", "=q3=Replica Darkmantle Bracers", "=ds=#s8#, #a2#" },
				{ 21, 78266, "", "=q4=Replica Darkmantle Gloves", "=ds=#s9#, #a2#" },
				{ 22, 78265, "", "=q3=Replica Darkmantle Belt", "=ds=#s10#, #a2#" },
				{ 23, 78268, "", "=q3=Replica Darkmantle Pants", "=ds=#s11#, #a2#" },
				{ 24, 78262, "", "=q4=Replica Darkmantle Boots", "=ds=#s12#, #a2#" },
			};
			{
				{ 1, 0, "spell_nature_bloodlust", "=q6=#t0s7#", "=ec1=#j6# - #j9#"};
				{ 2, 78286, "", "=q3=Replica Coif of Elements", "=ds=#s1#, #a3#" },
				{ 3, 78288, "", "=q3=Replica Pauldrons of Elements", "=ds=#s3#, #a3#" },
				{ 4, 78290, "", "=q3=Replica Vest of Elements", "=ds=#s5#, #a3#" },
				{ 5, 78289, "", "=q3=Replica Bindings of Elements", "=ds=#s8#, #a3#" },
				{ 6, 78291, "", "=q3=Replica Gauntlets of Elements", "=ds=#s9#, #a3#" },
				{ 7, 78293, "", "=q3=Replica Cord of Elements", "=ds=#s10#, #a3#" },
				{ 8, 78287, "", "=q3=Replica Kilt of Elements", "=ds=#s11#, #a3#" },
				{ 9, 78292, "", "=q3=Replica Boots of Elements", "=ds=#s12#, #a3#" },
				{ 16, 0, "spell_nature_bloodlust", "=q6=#t05s7#", "=ec1=#j7# - #j9#"};
				{ 17, 78294, "", "=q4=Replica Coif of The Five Thunders", "=ds=#s1#, #a3#" },
				{ 18, 78299, "", "=q3=Replica Pauldrons of The Five Thunders", "=ds=#s3#, #a3#" },
				{ 19, 78300, "", "=q4=Replica Vest of The Five Thunders", "=ds=#s5#, #a3#" },
				{ 20, 78296, "", "=q3=Replica Bindings of The Five Thunders", "=ds=#s8#, #a3#" },
				{ 21, 78295, "", "=q4=Replica Gauntlets of The Five Thunders", "=ds=#s9#, #a3#" },
				{ 22, 78297, "", "=q3=Replica Cord of The Five Thunders", "=ds=#s10#, #a3#" },
				{ 23, 78301, "", "=q3=Replica Kilt of The Five Thunders", "=ds=#s11#, #a3#" },
				{ 24, 78298, "", "=q4=Replica Boots of The Five Thunders", "=ds=#s12#, #a3#" },
			};
			{
				{ 1, 0, "spell_nature_drowsy", "=q6=#t0s8#", "=ec1=#j6# - #j9#"};
				{ 2, 78227, "", "=q3=Replica Dreadmist Mask", "=ds=#s1#, #a1#" },
				{ 3, 78226, "", "=q3=Replica Dreadmist Mantle", "=ds=#s3#, #a1#" },
				{ 4, 78225, "", "=q3=Replica Dreadmist Robe", "=ds=#s5#, #a1#" },
				{ 5, 78229, "", "=q3=Replica Dreadmist Bracers", "=ds=#s8#, #a1#" },
				{ 6, 78223, "", "=q3=Replica Dreadmist Wraps", "=ds=#s9#, #a1#" },
				{ 7, 78222, "", "=q3=Replica Dreadmist Belt", "=ds=#s10#, #a1#" },
				{ 8, 78228, "", "=q3=Replica Dreadmist Leggings", "=ds=#s11#, #a1#" },
				{ 9, 78224, "", "=q3=Replica Dreadmist Sandals", "=ds=#s12#, #a1#" },
				{ 16, 0, "spell_nature_drowsy", "=q6=#t05s8#", "=ec1=#j7# - #j9#"};
				{ 17, 78230, "", "=q4=Replica Deathmist Mask", "=ds=#s1#, #a1#" },
				{ 18, 78234, "", "=q3=Replica Deathmist Mantle", "=ds=#s3#, #a1#" },
				{ 19, 78237, "", "=q4=Replica Deathmist Robe", "=ds=#s5#, #a1#" },
				{ 20, 78232, "", "=q3=Replica Deathmist Bracers", "=ds=#s8#, #a1#" },
				{ 21, 78236, "", "=q4=Replica Deathmist Wraps", "=ds=#s9#, #a1#" },
				{ 22, 78233, "", "=q3=Replica Deathmist Belt", "=ds=#s10#, #a1#" },
				{ 23, 78231, "", "=q3=Replica Deathmist Leggings", "=ds=#s11#, #a1#" },
				{ 24, 78235, "", "=q4=Replica Deathmist Sandals", "=ds=#s12#, #a1#" },
			};
			{
				{ 1, 0, "inv_sword_27", "=q6=#t0s9#", "=ec1=#j6# - #j9#"};
				{ 2, 78322, "", "=q3=Replica Helm of Valor", "=ds=#s1#, #a4#" },
				{ 3, 78325, "", "=q3=Replica Spaulders of Valor", "=ds=#s3#, #a4#" },
				{ 4, 78323, "", "=q3=Replica Breastplate of Valor", "=ds=#s5#, #a4#" },
				{ 5, 78321, "", "=q3=Replica Bracers of Valor", "=ds=#s8#, #a4#" },
				{ 6, 78320, "", "=q3=Replica Gauntlets of Valor", "=ds=#s9#, #a4#" },
				{ 7, 78319, "", "=q3=Replica Belt of Valor", "=ds=#s10#, #a4#" },
				{ 8, 78324, "", "=q3=Replica Legplates of Valor", "=ds=#s11#, #a4#" },
				{ 9, 78318, "", "=q3=Replica Boots of Valor", "=ds=#s12#, #a4#" },
				{ 16, 0, "inv_sword_27", "=q6=#t05s9#", "=ec1=#j7# - #j9#"};
				{ 17, 78330, "", "=q4=Replica Helm of Heroism", "=ds=#s1#, #a4#" },
				{ 18, 78332, "", "=q3=Replica Spaulders of Heroism", "=ds=#s3#, #a4#" },
				{ 19, 78328, "", "=q4=Replica Breastplate of Heroism", "=ds=#s5#, #a4#" },
				{ 20, 78327, "", "=q3=Replica Bracers of Heroism", "=ds=#s8#, #a4#" },
				{ 21, 78329, "", "=q4=Replica Gauntlets of Heroism", "=ds=#s9#, #a4#" },
				{ 22, 78333, "", "=q3=Replica Belt of Heroism", "=ds=#s10#, #a4#" },
				{ 23, 78331, "", "=q3=Replica Legplates of Heroism", "=ds=#s11#, #a4#" },
				{ 24, 78326, "", "=q4=Replica Boots of Heroism", "=ds=#s12#, #a4#" },
			};
		};
		info = {
			name = ALIL["Darkmoon Faire"],
			module = moduleName, menu = "DARKMOONMENU"
		};
	};

	AtlasLoot_Data["DarkmoonDeck"] = {
		["Normal"] = {
			{
				{ 2, 79325, "", "=q4=Crane Deck", "=ds=#m2#"};
				{ 3, 79330, "", "=q4=Relic of Chi Ji", "=q1=#m4#: =ds=#s14#"};
				{ 5, 79324, "", "=q4=Ox Deck", "=ds=#m2#"};
				{ 6, 79329, "", "=q4=Relic of Niuzao", "=q1=#m4#: =ds=#s14#"};
				{ 17, 79326, "", "=q4=Serpent Deck", "=ds=#m2#"};
				{ 18, 79331, "", "=q4=Relic of Yu'lon", "=q1=#m4#: =ds=#s14#"};
				{ 20, 79323, "", "=q4=Tiger Deck", "=ds=#m2#"};
				{ 21, 79327, "", "=q4=Relic of Xuen", "=q1=#m4#: =ds=#s14#"};
				{ 22, 79328, "", "=q4=Relic of Xuen", "=q1=#m4#: =ds=#s14#"};
				extraText = ": "..AL["Level 90"].." "..AL["Trinkets"];
			};
			{
				{ 2, 62046, "", "=q4=Earthquake Deck", "=ds=#m2#"};
				{ 3, 62048, "", "=q4=Darkmoon Card: Earthquake", "=q1=#m4#: =ds=#s14#"};
				{ 5, 62045, "", "=q4=Hurricane Deck", "=ds=#m2#"};
				{ 6, 62049, "", "=q4=Darkmoon Card: Hurricane", "=q1=#m4#: =ds=#s14#"};
				{ 7, 62051, "", "=q4=Darkmoon Card: Hurricane", "=q1=#m4#: =ds=#s14#"};
				{ 17, 62044, "", "=q4=Tsunami Deck", "=ds=#m2#"};
				{ 18, 62050, "", "=q4=Darkmoon Card: Tsunami", "=q1=#m4#: =ds=#s14#"};
				{ 20, 62021, "", "=q4=Volcanic Deck", "=ds=#m2#"};
				{ 21, 62047, "", "=q4=Darkmoon Card: Volcano", "=q1=#m4#: =ds=#s14#"};
				extraText = ": "..AL["Level 85"].." "..AL["Trinkets"];
			};
			{
				{ 1, 44276, "", "=q4=Chaos Deck", "=ds=#m2#"};
				{ 2, 42989, "", "=q4=Darkmoon Card: Berserker!", "=q1=#m4#: =ds=#s14#"};
				{ 4, 44259, "", "=q4=Prisms Deck", "=ds=#m2#"};
				{ 5, 42988, "", "=q4=Darkmoon Card: Illusion", "=q1=#m4#: =ds=#s14#"};
				{ 7, 44294, "", "=q4=Undeath Deck", "=ds=#m2#"};
				{ 8, 42990, "", "=q4=Darkmoon Card: Death", "=q1=#m4#: =ds=#s14#"};
				{ 16, 44326, "", "=q4=Nobles Deck", "=ds=#m2#"};
				{ 17, 44253, "", "=q4=Darkmoon Card: Greatness", "=q1=#m4#: =ds=#s14#"};
				{ 18, 42987, "", "=q4=Darkmoon Card: Greatness", "=q1=#m4#: =ds=#s14#"};
				{ 19, 44254, "", "=q4=Darkmoon Card: Greatness", "=q1=#m4#: =ds=#s14#"};
				{ 20, 44255, "", "=q4=Darkmoon Card: Greatness", "=q1=#m4#: =ds=#s14#"};
				extraText = ": "..AL["Level 80"].." "..AL["Trinkets"];
			};
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Level 60"].." "..AL["Trinkets"], ""};
				{ 2, 19228, "", "=q4=Beasts Deck", "=ds=#m2#"};
				{ 3, 19288, "", "=q4=Darkmoon Card: Blue Dragon", "=q1=#m4#: =ds=#s14#"};
				{ 5, 19267, "", "=q4=Elementals Deck", "=ds=#m2#"};
				{ 6, 19289, "", "=q4=Darkmoon Card: Maelstrom", "=q1=#m4#: =ds=#s14#"};
				{ 8, 19277, "", "=q4=Portals Deck", "=ds=#m2#"};
				{ 9, 19290, "", "=q4=Darkmoon Card: Twisting Nether", "=q1=#m4#: =ds=#s14#"};
				{ 11, 19257, "", "=q4=Warlords Deck", "=ds=#m2#"};
				{ 12, 19287, "", "=q4=Darkmoon Card: Heroism", "=q1=#m4#: =ds=#s14#"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Level 70"].." "..AL["Trinkets"], ""};
				{ 17, 31890, "", "=q4=Blessings Deck", "=ds=#m2#"};
				{ 18, 31856, "", "=q4=Darkmoon Card: Crusade", "=q1=#m4#: =ds=#s14#"};
				{ 20, 31907, "", "=q4=Furies Deck", "=ds=#m2#"};
				{ 21, 31858, "", "=q4=Darkmoon Card: Vengeance", "=q1=#m4#: =ds=#s14#"};
				{ 23, 31914, "", "=q4=Lunacy Deck", "=ds=#m2#"};
				{ 24, 31859, "", "=q4=Darkmoon Card: Madness", "=q1=#m4#: =ds=#s14#"};
				{ 26, 31891, "", "=q4=Storms Deck", "=ds=#m2#"};
				{ 27, 31857, "", "=q4=Darkmoon Card: Wrath", "=q1=#m4#: =ds=#s14#"};
				extraText = ": "..AL["Level 60 & 70 Trinkets"];
			};
			{
				{ 1, 37163, "", "=q2=Rogues Deck", "=ds=#m2#"};
				{ 2, 38318, "", "=q2=Darkmoon Robe", "=q1=#m4#: =ds=#s5#, #a1#"};
				{ 3, 39509, "", "=q2=Darkmoon Vest", "=q1=#m4#: =ds=#s5#, #a2#"};
				{ 4, 39507, "", "=q2=Darkmoon Chain Shirt", "=q1=#m4#: =ds=#s5#, #a3#"};
				{ 6, 37164, "", "=q3=Swords Deck", "=ds=#m2#"};
				{ 7, 39894, "", "=q3=Darkcloth Shoulders", "=q1=#m4#: =ds=#s3#, #a1#"};
				{ 8, 39895, "", "=q3=Cloaked Shoulderpads", "=q1=#m4#: =ds=#s3#, #a2#"};
				{ 9, 39897, "", "=q3=Azure Shoulderguards", "=q1=#m4#: =ds=#s3#, #a3#"};
				{ 16, 44148, "", "=q3=Mages Deck", "=ds=#m2#"};
				{ 17, 44215, "", "=q3=Darkmoon Necklace", "=q1=#m4#: =ds=#s2#"};
				{ 18, 44213, "", "=q3=Darkmoon Pendant", "=q1=#m4#: =ds=#s2#"};
				{ 21, 44158, "", "=q3=Demons Deck", "=ds=#m2#"};
				{ 22, 44217, "", "=q3=Darkmoon Dirk", "=q1=#m4#: =ds=#h1#, #w4#"};
				{ 23, 44218, "", "=q3=Darkmoon Executioner", "=q1=#m4#: =ds=#h2#, #w1#"};
				{ 24, 44219, "", "=q3=Darkmoon Magestaff", "=q1=#m4#: =ds=#w9#"};
				extraText = ": "..AL["Low Level Decks"];
			};
		};
		info = {
			name = ALIL["Darkmoon Faire"],
			module = moduleName, menu = "DARKMOONMENU"
		};
	};

		---------------------------------
		--- Gurubashi Arena Booty Run ---
		---------------------------------

	AtlasLoot_Data["GurubashiArena"] = {
		["Normal"] = {
			{
				{ 2, 18709, "", "=q3=Arena Wristguards", "=ds=#s8#, #a1#", "", "5.0%"};
				{ 3, 18710, "", "=q3=Arena Bracers", "=ds=#s8#, #a2#", "", "6.4%"};
				{ 4, 18711, "", "=q3=Arena Bands", "=ds=#s8#, #a3#", "", "6.0%"};
				{ 5, 18712, "", "=q3=Arena Vambraces", "=ds=#s8#, #a4#", "", "6.8%"};
				{ 17, 18706, "", "=q2=Arena Master", "=ds=#s14#, =q1=#m2#", "", "100%"};
				{ 18, 19024, "", "=q3=Arena Grand Master", "=q1=#m4#: =ds=#s14#"};
			};
		};
		info = {
			name = AL["Gurubashi Arena Booty Run"],
			module = moduleName, menu = "WORLDEVENTMENU"
		};
	};

		------------------------------------------------------------------
		--- Stranglethorn Fishing Extravaganza / Kalu'ak Fishing Derby ---
		------------------------------------------------------------------

	AtlasLoot_Data["FishingExtravaganza"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["First Prize"], "=q1="..AL["Stranglethorn Fishing Extravaganza"]};
				{ 2, 19970, "", "=q3=Arcanite Fishing Pole", "=ds=#e20#"};
				{ 3, 19979, "", "=q3=Hook of the Master Angler", "=ds=#s14#"};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Rare Fish"], "=q1="..AL["Stranglethorn Fishing Extravaganza"]};
				{ 6, 19805, "", "=q2=Keefer's Angelfish", "=ds=#e21#", "", ""};
				{ 7, 19803, "", "=q2=Brownell's Blue Striped Racer", "=ds=#e21#", "", ""};
				{ 8, 19806, "", "=q2=Dezian Queenfish", "=ds=#e21#", "", ""};
				{ 9, 19808, "", "=q2=Rockhide Strongfish", "=ds=#h1#, #w6#", "", ""};
				{ 16, 0, "INV_Box_01", "=q6="..AL["First Prize"], "=q1="..AL["Kalu'ak Fishing Derby"]};
				{ 17, 50287, "", "=q3=Boots of the Bay", "=ds=#s12#"};
				{ 18, 50255, "", "=q7=Dread Pirate Ring", "=ds=#s13#"};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Rare Fish Rewards"], "=q1="..AL["Stranglethorn Fishing Extravaganza"]};
				{ 21, 19972, "", "=q2=Lucky Fishing Hat", "=ds=#s1#, #a1#"};
				{ 22, 19969, "", "=q2=Nat Pagle's Extreme Anglin' Boots", "=ds=#s12#, #a1#"};
				{ 23, 19971, "", "=q2=High Test Eternium Fishing Line", "=ds=#e20# #e17#"};
			};
		};
		info = {
			name = AL["Fishing Contests"],
			module = moduleName, menu = "WORLDEVENTMENU"
		};
	};

	-----------------------
	--- One-Time Events ---
	-----------------------

	------------------------
	--- Triggered Events ---
	------------------------

		-----------------------
		--- Abyssal Council ---
		-----------------------

	AtlasLoot_Data["Templars"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["Crimson Templar"], "=q1=#j19#"};
				{ 2, 20657, "", "=q3=Crystal Tipped Stiletto", "=ds=#h1#, #w4#", "", "2.31%"};
				{ 3, 20655, "", "=q2=Abyssal Cloth Handwraps", "=ds=#s9#, #a1#", "", "13.03%"};
				{ 4, 20656, "", "=q2=Abyssal Mail Sabatons", "=ds=#s12#, #a3#", "", "12.89%"};
				{ 5, 20513, "", "=q2=Abyssal Crest", "=ds=#m3#", "", "100%"};
				{ 7, 0, "INV_Box_01", "=q6="..AL["Azure Templar"], "=q1=#j20#"};
				{ 8, 20654, "", "=q3=Amethyst War Staff", "=ds=#w9#", "", "2.38%"};
				{ 9, 20652, "", "=q2=Abyssal Cloth Slippers", "=ds=#s12#, #a1#", "", "12.94%"};
				{ 10, 20653, "", "=q2=Abyssal Plate Gauntlets", "=ds=#s9#, #a4#", "", "13.61%"};
				{ 11, 20513, "", "=q2=Abyssal Crest", "=ds=#m3#", "", "100%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["Hoary Templar"], "=q1=#j21#"};
				{ 17, 20660, "", "=q3=Stonecutting Glaive", "=ds=#w7#", "", "2.22%"};
				{ 18, 20658, "", "=q2=Abyssal Leather Boots", "=ds=#s12#, #a2#", "", "13.16%"};
				{ 19, 20659, "", "=q2=Abyssal Mail Handguards", "=ds=#s9#, #a3#", "", "12.64%"};
				{ 20, 20513, "", "=q2=Abyssal Crest", "=ds=#m3#", "", "100%"};
				{ 22, 0, "INV_Box_01", "=q6="..AL["Earthen Templar"], "=q1=#j22#"};
				{ 23, 20663, "", "=q3=Deep Strike Bow", "=ds=#w2#", "", "2.55%"};
				{ 24, 20661, "", "=q2=Abyssal Leather Gloves", "=ds=#s9#, #a2#", "", "13.16%"};
				{ 25, 20662, "", "=q2=Abyssal Plate Greaves", "=ds=#s12#, #a4#", "", "12.93%"};
				{ 26, 20513, "", "=q2=Abyssal Crest", "=ds=#m3#", "", "100%"};
			};
		};
		info = {
			name = AL["Abyssal Council"].." - "..AL["Templars"],
			module = moduleName, menu = "ABYSSALMENU"
		};
	};

	AtlasLoot_Data["Dukes"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..AL["The Duke of Cynders"], "=q1=#j19#"};
				{ 2, 20665, "", "=q3=Abyssal Leather Leggings", "=ds=#s11#, #a2#", "", "22.50%"};
				{ 3, 20666, "", "=q3=Hardened Steel Warhammer", "=ds=#h1#, #w6#", "", "30.47%"};
				{ 4, 20514, "", "=q3=Abyssal Signet", "=ds=#m3#", "", "100%"};
				{ 5, 20664, "", "=q2=Abyssal Cloth Sash", "=ds=#s10#, #a1#", "", "27.08%"};
				{ 6, 21989, "", "=q1=Cinder of Cynders", "=ds=#m3#", "", "100%"};
				{ 8, 0, "INV_Box_01", "=q6="..AL["The Duke of Fathoms"], "=q1=#j20#"};
				{ 9, 20668, "", "=q3=Abyssal Mail Legguards", "=ds=#s11#, #a3#", "", "22.40%"};
				{ 10, 20669, "", "=q3=Darkstone Claymore", "=ds=#h2#, #w10#", "", "29.62%"};
				{ 11, 20514, "", "=q3=Abyssal Signet", "=ds=#m3#", "", "100%"};
				{ 12, 20667, "", "=q2=Abyssal Leather Belt", "=ds=#s10#, #a2#", "", "29.04%"};
				{ 16, 0, "INV_Box_01", "=q6="..AL["The Duke of Zephyrs"], "=q1=#j21#"};
				{ 17, 20674, "", "=q3=Abyssal Cloth Pants", "=ds=#s11#, #a1#", "", "21.83%"};
				{ 18, 20675, "", "=q3=Soulrender", "=ds=#h1#, #w1#", "", "29.73%"};
				{ 19, 20514, "", "=q3=Abyssal Signet", "=ds=#m3#", "", "100%"};
				{ 20, 20673, "", "=q2=Abyssal Plate Girdle", "=ds=#s10#, #a4#", "", "27.11%"};
				{ 23, 0, "INV_Box_01", "=q6="..AL["The Duke of Shards"], "=q1=#j22#"};
				{ 24, 20671, "", "=q3=Abyssal Plate Legplates", "=ds=#s11#, #a4#", "", "22.63%"};
				{ 25, 20672, "", "=q3=Sparkling Crystal Wand", "=ds=#w12#", "", "28.90%"};
				{ 26, 20514, "", "=q3=Abyssal Signet", "=ds=#m3#", "", "100%"};
				{ 27, 20670, "", "=q2=Abyssal Mail Clutch", "=ds=#s10#, #a3#", "", "28.16%"};
			};
		};
		info = {
			name = AL["Abyssal Council"].." - "..AL["Dukes"],
			module = moduleName, menu = "ABYSSALMENU"
		};
	};

		-----------------------
		--- Ethereum Prison ---
		-----------------------

	AtlasLoot_Data["ArmbreakerHuffaz"] = {
		["Normal"] = {
			{
				{ 1, 31943, "", "=q3=Ethereum Band", "=ds=#s13#", "", "10.7%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "1.36%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "0.4%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "0.36%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "1.1%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "0.6%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "0.7%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "0.8%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "0.5%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "1.0%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "1.3%"};
			};
		};
		info = {
			name = BabbleRare["Armbreaker Huffaz"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["FelTinkererZortan"] = {
		["Normal"] = {
			{
				{ 1, 31573, "", "=q3=Mistshroud Boots", "=ds=#s12#, #a3#", "", "9.7%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "0.94%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "1.0%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "0.94%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "0.4%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "0.7%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "1.0%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "1.3%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "1.2%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "1.0%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "1.2%"};
			};
		};
		info = {
			name = BabbleRare["Fel Tinkerer Zortan"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["Forgosh"] = {
		["Normal"] = {
			{
				{ 1, 31565, "", "=q3=Skystalker's Boots", "=ds=#s12#, #a2#", "", "8.5%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "2.63%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "0.29%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "0.9%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "0.7%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "1.0%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "0.9%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "1.9%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "0.5%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "1.0%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "0.7%"};
			};
		};
		info = {
			name = BabbleRare["Forgosh"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["Gulbor"] = {
		["Normal"] = {
			{
				{ 1, 31940, "", "=q3=Ethereum Torque", "=ds=#s2#", "", "9.5%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "0.66%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "0.66%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "1.1%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "1.1%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "0.8%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "0.7%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "0.9%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "0.8%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "0.8%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "2.0%"};
			};
		};
		info = {
			name = BabbleRare["Gul'bor"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["MalevustheMad"] = {
		["Normal"] = {
			{
				{ 1, 31581, "", "=q3=Slatesteel Boots", "=ds=#s12#, #a4#", "", "10.5%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "2.46%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "0.70%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "1.5%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "0.7%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "1.3%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "0.5%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "0.8%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "1.75%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "0.6%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "1.8%"};
			};
		};
		info = {
			name = BabbleRare["Malevus the Mad"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["PorfustheGemGorger"] = {
		["Normal"] = {
			{
				{ 1, 31557, "", "=q3=Windchanneller's Boots", "=ds=#s12#, #a1#", "", "7.9%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "1.89%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "0.81%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "1.0%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "0.7%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "1.1%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "0.7%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "0.6%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "1.8%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "1.0%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "1.1%"};
			};
		};
		info = {
			name = BabbleRare["Porfus the Gem Gorger"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["WrathbringerLaztarash"] = {
		["Normal"] = {
			{
				{ 1, 32520, "", "=q3=Manaforged Sphere", "=ds=#s15#", "", "10.4%"};
				{ 3, 31939, "", "=q3=Dark Cloak", "=ds=#s4#", "", "1.06%"};
				{ 4, 31938, "", "=q3=Enigmatic Cloak", "=ds=#s4#", "", "1.06%"};
				{ 5, 31936, "", "=q3=Fiery Cloak", "=ds=#s4#", "", "0.8%"};
				{ 6, 31935, "", "=q3=Frigid Cloak", "=ds=#s4#", "", "1.5%"};
				{ 7, 31937, "", "=q3=Living Cloak", "=ds=#s4#", "", "0.3%"};
				{ 9, 31957, "", "=q2=Ethereum Prisoner I.D. Tag", "=ds=#m3#", "", "100%"};
				{ 18, 31928, "", "=q3=Dark Band", "=ds=#s13#", "", "0.7%"};
				{ 19, 31929, "", "=q3=Enigmatic Band", "=ds=#s13#", "", "0.7%"};
				{ 20, 31925, "", "=q3=Fiery Band", "=ds=#s13#", "", "1.2%"};
				{ 21, 31926, "", "=q3=Frigid Band", "=ds=#s13#", "", "1.1%"};
				{ 22, 31927, "", "=q3=Living Band", "=ds=#s13#", "", "1.1%"};
			};
		};
		info = {
			name = BabbleRare["Wrathbringer Laz-tarash"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

	AtlasLoot_Data["BashirStasisChambers"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleRare["Trelopades"], ""};
				{ 2, 32522, "", "=q3=Demonic Bulwark", "=ds=#w8#", "", ""};
				{ 3, 31941, "", "=q2=Mark of the Nexus-King", "=ds=#m3#", "", ""};
				{ 5, 0, "INV_Box_01", "=q6="..BabbleRare["King Dorfbruiser"], ""};
				{ 6, 31577, "", "=q3=Slatesteel Shoulders", "=ds=#s3#, #a4#", "", ""};
				{ 7, 31941, "", "=q2=Mark of the Nexus-King", "=ds=#m3#", "", ""};
				{ 9, 0, "INV_Box_01", "=q6="..BabbleRare["Gorgolon the All-seeing"], ""};
				{ 10, 31569, "", "=q3=Mistshroud Shoulders", "=ds=#s3#, #a3#", "", ""};
				{ 11, 31941, "", "=q2=Mark of the Nexus-King", "=ds=#m3#", "", ""};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleRare["Matron Li-sahar"], ""};
				{ 17, 31553, "", "=q3=Windchanneller's Mantle", "=ds=#s3#, #a1#", "", ""};
				{ 18, 31941, "", "=q2=Mark of the Nexus-King", "=ds=#m3#", "", ""};
				{ 20, 0, "INV_Box_01", "=q6="..BabbleRare["Solus the Eternal"], ""};
				{ 21, 31561, "", "=q3=Skystalker's Shoulders", "=ds=#s3#, #a2#", "", ""};
				{ 22, 31941, "", "=q2=Mark of the Nexus-King", "=ds=#m3#", "", ""};
			};
		};
		info = {
			name = AL["Bash'ir Landing Stasis Chambers"],
			module = moduleName, menu = "ETHEREUMMENU"
		};
	};

		---------------
		--- Skettis ---
		---------------

	AtlasLoot_Data["DarkscreecherAkkarai"] = {
		["Normal"] = {
			{
				{ 2, 32529, "", "=q3=Heretic's Gauntlets", "=ds=#s9#, #a4#", "", "17.3%"};
				{ 3, 32715, "", "=q2=Akkarai's Talons", "=ds=#m3#", "", "100%"};
				{ 17, 31558, "", "=q3=Windchanneller's Bindings", "=ds=#s8#, #a1#", "", "5.3%"};
				{ 18, 31555, "", "=q3=Windchanneller's Ceinture", "=ds=#s10#, #a1#", "", "4.3%"};
				{ 19, 31566, "", "=q3=Skystalker's Bracers", "=ds=#s8#, #a2#", "", "6.8%"};
				{ 20, 31563, "", "=q3=Skystalker's Cord", "=ds=#s10#, #a2#", "", "6.2%"};
				{ 21, 31574, "", "=q3=Mistshroud Bracers", "=ds=#s8#, #a3#", "", "4.1%"};
				{ 22, 31571, "", "=q3=Mistshroud Belt", "=ds=#s10#, #a3#", "", "4.5%"};
				{ 23, 31582, "", "=q3=Slatesteel Bracers", "=ds=#s8#, #a4#", "", "6.7%"};
				{ 24, 31579, "", "=q3=Slatesteel Girdle", "=ds=#s10#, #a4#", "", "5.5%"};
				{ 25, 32514, "", "=q3=Skettis Band", "=ds=#s13#", "", "31.5%"};
			};
		};
		info = {
			name = BabbleRare["Darkscreecher Akkarai"],
			module = moduleName, menu = "SKETTISMENU"
		};
	};

	AtlasLoot_Data["Karrog"] = {
		["Normal"] = {
			{
				{ 2, 32533, "", "=q3=Karrog's Shard", "=ds=#s15#", "", "15.0%"};
				{ 3, 32717, "", "=q2=Karrog's Spine", "=ds=#m3#", "", "100%"};
				{ 17, 31558, "", "=q3=Windchanneller's Bindings", "=ds=#s8#, #a1#", "", "5.6%"};
				{ 18, 31555, "", "=q3=Windchanneller's Ceinture", "=ds=#s10#, #a1#", "", "6.8%"};
				{ 19, 31566, "", "=q3=Skystalker's Bracers", "=ds=#s8#, #a2#", "", "6.0%"};
				{ 20, 31563, "", "=q3=Skystalker's Cord", "=ds=#s10#, #a2#", "", "8.0%"};
				{ 21, 31574, "", "=q3=Mistshroud Bracers", "=ds=#s8#, #a3#", "", "5.6%"};
				{ 22, 31571, "", "=q3=Mistshroud Belt", "=ds=#s10#, #a3#", "", "3.6%"};
				{ 23, 31582, "", "=q3=Slatesteel Bracers", "=ds=#s8#, #a4#", "", "4.3%"};
				{ 24, 31579, "", "=q3=Slatesteel Girdle", "=ds=#s10#, #a4#", "", "5.3%"};
				{ 25, 32514, "", "=q3=Skettis Band", "=ds=#s13#", "", "24.9%"};
			};
		};
		info = {
			name = BabbleRare["Karrog"],
			module = moduleName, menu = "SKETTISMENU"
		};
	};

	AtlasLoot_Data["GezzaraktheHuntress"] = {
		["Normal"] = {
			{
				{ 2, 32531, "", "=q3=Gezzarak's Fang", "=ds=#s2#", "", "16.9%"};
				{ 3, 32716, "", "=q2=Gezzarak's Claws", "=ds=#m3#", "", "100%"};
				{ 17, 31558, "", "=q3=Windchanneller's Bindings", "=ds=#s8#, #a1#", "", "5.2%"};
				{ 18, 31555, "", "=q3=Windchanneller's Ceinture", "=ds=#s10#, #a1#", "", "6.9%"};
				{ 19, 31566, "", "=q3=Skystalker's Bracers", "=ds=#s8#, #a2#", "", "5.2%"};
				{ 20, 31563, "", "=q3=Skystalker's Cord", "=ds=#s10#, #a2#", "", "4.9%"};
				{ 21, 31574, "", "=q3=Mistshroud Bracers", "=ds=#s8#, #a3#", "", "5.8%"};
				{ 22, 31571, "", "=q3=Mistshroud Belt", "=ds=#s10#, #a3#", "", "5.4%"};
				{ 23, 31582, "", "=q3=Slatesteel Bracers", "=ds=#s8#, #a4#", "", "6.2%"};
				{ 24, 31579, "", "=q3=Slatesteel Girdle", "=ds=#s10#, #a4#", "", "4.6%"};
				{ 25, 32514, "", "=q3=Skettis Band", "=ds=#s13#", "", "25.7%"};
			};
		};
		info = {
			name = BabbleRare["Gezzarak the Huntress"],
			module = moduleName, menu = "SKETTISMENU"
		};
	};

	AtlasLoot_Data["VakkiztheWindrager"] = {
		["Normal"] = {
			{
				{ 2, 32532, "", "=q3=Windrager's Coils", "=ds=#s8#, #a3#", "", "18.1%"};
				{ 3, 32718, "", "=q2=Vakkiz's Scale", "=ds=#m3#", "", "100%"};
				{ 17, 31558, "", "=q3=Windchanneller's Bindings", "=ds=#s8#, #a1#", "", "5.0%"};
				{ 18, 31555, "", "=q3=Windchanneller's Ceinture", "=ds=#s10#, #a1#", "", "4.4%"};
				{ 19, 31566, "", "=q3=Skystalker's Bracers", "=ds=#s8#, #a2#", "", "4.1%"};
				{ 20, 31563, "", "=q3=Skystalker's Cord", "=ds=#s10#, #a2#", "", "3.9%"};
				{ 21, 31574, "", "=q3=Mistshroud Bracers", "=ds=#s8#, #a3#", "", "5.7%"};
				{ 22, 31571, "", "=q3=Mistshroud Belt", "=ds=#s10#, #a3#", "", "6.3%"};
				{ 23, 31582, "", "=q3=Slatesteel Bracers", "=ds=#s8#, #a4#", "", "5.8%"};
				{ 24, 31579, "", "=q3=Slatesteel Girdle", "=ds=#s10#, #a4#", "", "2.7%"};
				{ 25, 32514, "", "=q3=Skettis Band", "=ds=#s13#", "", "28.7%"};
			};
		};
		info = {
			name = BabbleRare["Vakkiz the Windrager"],
			module = moduleName, menu = "SKETTISMENU"
		};
	};

	AtlasLoot_Data["Terokk"] = {
		["Normal"] = {
			{
				{ 2, 32540, "", "=q4=Terokk's Might", "=ds=#s4#", "", "4.6%"};
				{ 3, 32541, "", "=q4=Terokk's Wisdom", "=ds=#s4#", "", "4.6%"};
				{ 4, 31556, "", "=q3=Windchanneller's Leggings", "=ds=#s11#, #a1#", "", "14.3%"};
				{ 5, 31564, "", "=q3=Skystalker's Leggings", "=ds=#s11#, #a2#", "", "13.9%"};
				{ 6, 31572, "", "=q3=Mistshroud Pants", "=ds=#s11#, #a3#", "", "10.7%"};
				{ 7, 31580, "", "=q3=Slatesteel Leggings", "=ds=#s11#, #a4#", "", "11.6%"};
				{ 8, 32535, "", "=q3=Gift of the Talonpriests", "=ds=#s13#", "", "7.9%"};
				{ 9, 32534, "", "=q3=Brooch of the Immortal King", "=ds=#s14#", "", "11.2%"};
				{ 10, 32782, "", "=q3=Time-Lost Figurine", "=ds=#s14#", "", ""};
				{ 11, 32537, "", "=q3=Terokk's Gavel", "=ds=#h1#, #w6#", "", "7.9%"};
				{ 12, 32536, "", "=q3=Terokk's Gavel", "=ds=#h1#, #w6#", "", "6.7%"};
			};
		};
		info = {
			name = BabbleRare["Terokk"],
			module = moduleName, menu = "SKETTISMENU"
		};
	};

	AtlasLoot_Data["SkettisTalonpriestIshaal"] = {
		["Normal"] = {
			{
				{ 1, 32523, "", "=q1=Ishaal's Almanac", "=ds=#m2#"};
			};
		};
		info = {
			name = "Talonpriest Ishaal",
			module = moduleName, menu = "SKETTISMENU"
		};
	};

	AtlasLoot_Data["SkettisHazziksPackage"] = {
		["Normal"] = {
			{
				{ 1, 32687, "", "=q1=Hazzik's Package", "=ds=#m3#"};
			};
		};
		info = {
			name = "Hazzik's Package",
			module = moduleName, menu = "SKETTISMENU"
		};
	};