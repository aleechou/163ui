-- $Id: WorldEventMenus.lua 4183 2013-04-09 08:06:19Z dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleRare = AtlasLoot_GetLocaleLibBabble("LibBabble-Rare-3.0")

	AtlasLoot_Data["WORLDEVENTMENU"] = {
		["Normal"] = {
			{
				{ 1, "ARGENTMENU", "Ability_Paladin_ArtofWar", "=ds="..AL["Argent Tournament"], "=q5="..ALIL["Icecrown"]};
				{ 3, "BREWFESTMENU", "achievement_worldevent_brewmaster", "=ds="..AL["Brewfest"], "=q5="..ALIL["September"].." - "..ALIL["October"]};
				{ 4, "DayoftheDead", "inv_misc_bone_humanskull_02", "=ds="..AL["Day of the Dead"], "=q5="..ALIL["November"]};
				{ 5, "HALLOWSENDMENU", "achievement_halloween_witch_01", "=ds="..AL["Hallow's End"], "=q5="..ALIL["October"]};
				{ 6, "LOEVISINTHEAIRMENU", "achievement_worldevent_valentine", "=ds="..AL["Love is in the Air"], "=q5="..ALIL["February"]};
				{ 7, "MidsummerFestival", "inv_summerfest_symbol_high", "=ds="..AL["Midsummer Fire Festival"], "=q5="..ALIL["June"].." - "..ALIL["July"]};
				{ 8, "PilgrimsBounty", "inv_thanksgiving_turkey", "=ds="..AL["Pilgrim's Bounty"], "=q5="..ALIL["November"]};
				{ 10, "BashirLanding", "INV_Trinket_Naxxramas02", "=ds="..AL["Bash'ir Landing Skyguard Raid"], "=q5="..ALIL["Blade's Edge Mountains"]};
				{ 11, "GurubashiArena", "inv_misc_armorkit_04", "=ds="..AL["Gurubashi Arena Booty Run"], "=q5="..ALIL["Stranglethorn Vale"]};
				{ 13, "ABYSSALMENU", "INV_Staff_13", "=ds="..AL["Abyssal Council"], "=q5="..ALIL["Silithus"]};
				{ 14, "SKETTISMENU", "Spell_Nature_NaturesWrath", "=ds="..AL["Skettis"], "=q5="..ALIL["Terokkar Forest"]};
				{ 16, "DARKMOONMENU", "INV_Misc_Ticket_Tarot_Madness", "=ds="..ALIL["Darkmoon Faire"], "=q5="..AL["Darkmoon Island"]};
				{ 18, "ChildrensWeek", "inv_misc_toy_04", "=ds="..AL["Children's Week"], "=q5="..ALIL["April"].." - "..ALIL["May"]};
				{ 19, "WINTERVIELMENU", "achievement_worldevent_merrymaker", "=ds="..AL["Feast of Winter Veil"], "=q5="..ALIL["December"].." - "..ALIL["January"]};
				{ 20, "HarvestFestival", "INV_Misc_Food_33", "=ds="..AL["Harvest Festival"], "=q5="..ALIL["September"].." - "..ALIL["October"]};
				{ 21, "LUNARFESTIVALMENU", "achievement_worldevent_lunar", "=ds="..AL["Lunar Festival"], "=q5="..ALIL["January"].." - "..ALIL["February"]};
				{ 22, "Noblegarden", "inv_egg_09", "=ds="..AL["Noblegarden"], "=q5="..ALIL["March"].." - "..ALIL["April"]};
				{ 25, "FishingExtravaganza", "inv_misc_fish_06", "=ds="..AL["Fishing Contests"], "=q5="..ALIL["Stranglethorn Vale"].." / "..ALIL["Northrend"]};
				{ 28, "ETHEREUMMENU", "INV_Misc_PunchCards_Prismatic", "=ds="..AL["Ethereum Prison"], "=q5="..ALIL["Netherstorm"]};
			};
		};
		info = {
			name = AL["World Events"],
		};
	}

	AtlasLoot_Data["ARGENTMENU"] = {
		["Normal_A"] = {
			{
				{ 2, "ATArmor", "inv_boots_plate_09", "=ds="..BabbleInventory["Armor"].." / "..AL["Weapons"], ""};
				{ 3, "ATHeirlooms", "inv_jewelry_talisman_01", "=ds="..AL["Heirloom"], ""};
				{ 17, "ATPets", "achievement_reputation_argentchampion", "=ds="..BabbleInventory["Companions"]};
				{ 18, "ATMounts", "ability_mount_warhippogryph", "=ds="..BabbleInventory["Mounts"]};
				{ 5, 45714, "", "=q2=Darnassus Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 6, 45715, "", "=q2=Exodar Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 7, 45716, "", "=q2=Gnomeregan Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 9, 46874, "", "=q3=Argent Crusader's Tabard", "=ds=#s7#", "#CHAMPSEAL:50#"};
				{ 10, 45579, "", "=q1=Darnassus Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 11, 45580, "", "=q1=Exodar Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 12, 45578, "", "=q1=Gnomeregan Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 13, 45577, "", "=q1=Ironforge Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 14, 45574, "", "=q1=Stormwind Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 15, 46817, "", "=q1=Silver Covenant Tabard", "=ds=#s7#", "#CHAMPSEAL:50#"};
				{ 20, 45717, "", "=q2=Ironforge Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 21, 45718, "", "=q2=Stormwind Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 24, 46843, "", "=q1=Argent Crusader's Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 25, 45021, "", "=q1=Darnassus Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 26, 45020, "", "=q1=Exodar Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 27, 45019, "", "=q1=Gnomeregan Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 28, 45018, "", "=q1=Ironforge Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 29, 45011, "", "=q1=Stormwind Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
			};
		};
		["Normal_H"] = {
			{
				{ 2, "ATArmor", "inv_boots_plate_09", "=ds="..BabbleInventory["Armor"].." / "..AL["Weapons"], ""};
				{ 3, "ATHeirlooms", "inv_jewelry_talisman_01", "=ds="..AL["Heirloom"], ""};
				{ 17, "ATPets", "achievement_reputation_argentchampion", "=ds="..BabbleInventory["Companions"]};
				{ 18, "ATMounts", "ability_mount_warhippogryph", "=ds="..BabbleInventory["Mounts"]};
				{ 5, 45719, "", "=q2=Orgrimmar Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 6, 45723, "", "=q2=Undercity Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 7, 45722, "", "=q2=Thunder Bluff Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 9, 46874, "", "=q3=Argent Crusader's Tabard", "=ds=#s7#", "#CHAMPSEAL:50#"};
				{ 10, 45581, "", "=q1=Orgrimmar Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 11, 45583, "", "=q1=Undercity Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 12, 45584, "", "=q1=Thunder Bluff Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 13, 45582, "", "=q1=Darkspear Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 14, 45585, "", "=q1=Silvermoon City Tabard", "=ds=#s7#", "=ds=10 #silver#"};
				{ 15, 46818, "", "=q1=Sunreaver Tabard", "=ds=#s7#", "#CHAMPSEAL:50#"};
				{ 20, 45720, "", "=q2=Sen'jin Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 21, 45721, "", "=q2=Silvermoon Commendation Badge", "", "=ds=#CHAMPWRIT:1#"};
				{ 24, 46843, "", "=q1=Argent Crusader's Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 25, 45014, "", "=q1=Orgrimmar Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 26, 45016, "", "=q1=Undercity Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 27, 45013, "", "=q1=Thunder Bluff Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 28, 45015, "", "=q1=Sen'jin Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
				{ 29, 45017, "", "=q1=Silvermoon City Banner", "=ds=#e14#", "#CHAMPSEAL:15#"};
			};
		};
		info = {
			name = AL["Argent Tournament"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["BREWFESTMENU"] = {
		["Normal"] = {
			{
				{ 2, "Brewfest", "inv_holiday_brewfestbuff_01", "=ds="..AL["Vendor"], ""};
				{ 3, "Brewfest#2", "inv_holiday_beerfestpretzel01", "=ds="..AL["Food and Drinks"], ""};
				{ 5, 0, "inv_holiday_brewfestbuff_01", "=q6="..AL["Special Rewards"], ""};
				{ 6, 56836, "", "=q3=Overflowing Purple Brewfest Stein", "=ec1=2011 =q1=#m4#: =ds=#h1#"};
				{ 7, 37892, "", "=q3=Green Brewfest Stein", "#ACHIEVEMENTID:4782#"};
				{ 8, 33016, "", "=q3=Blue Brewfest Stein", "#ACHIEVEMENTID:1293#"};
				{ 9, 32912, "", "=q3=Yellow Brewfest Stein", "#ACHIEVEMENTID:1292#"};
				{ 10, 34140, "", "=q3=Dark Iron Tankard", "=ec1=2007 =q1=#m4#: =ds=#s15#"};
				{ 11, 33976, "", "=q3=Brewfest Ram", "=ec1=2007 =q1=#m4#: =ds=#e26#"};
				{ 17, "CorenDirebrew", "inv_misc_head_dwarf_01", "=ds="..BabbleBoss["Coren Direbrew"], "=q5="..AL["Daily Reward"]};
				{ 18, "Brewfest#3", "inv_holiday_brewfestbuff_01", "=ds="..AL["Brew of the Month Club"], ""};
			};
		};
		info = {
			name = AL["Brewfest"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["HALLOWSENDMENU"] = {
		["Normal"] = {
			{
				{ 2, "Halloween", "achievement_halloween_candy_01", "=ds="..AL["Vendor"], ""};
				{ 3, "Halloween#2", "achievement_halloween_ghost_01", "=ds="..AL["Non-Playable Race Masks"].." / "..BabbleInventory["Wands"], ""};
				{ 5, 0, "inv_misc_food_25", "=q6="..AL["Special Rewards"], ""};
				{ 6, 33117, "", "=q3=Jack-o'-Lantern", "=ds=#e1#", "=q2="..AL["World Drop"]};
				{ 7, 20400, "", "=q2=Pumpkin Bag", "=ds=#e1#", "=q2="..AL["World Drop"]};
				{
					{ 8, 71076, "", "=q1=Creepy Crate", "=ds=#e13#", "=q1=#m4#: #QUESTID:29429#"};
					{ 8, 71076, "", "=q1=Creepy Crate", "=ds=#e13#", "=q1=#m4#: #QUESTID:29413#"};
				};
				{ 17, "HeadlessHorseman", "inv_misc_food_59", "=ds="..BabbleBoss["Headless Horseman"], "=q5="..AL["Daily Reward"]};
				{ 18, "Halloween#3", "inv_mask_04", "=ds="..AL["Playable Race Masks"], ""};
				{ 21, 20516, "", "=q1=Bobbing Apple", "=ds=#e3#"};
				{ 22, 34068, "", "=q1=Weighted Jack-o'-Lantern", "=ds=#m20#"};
			};
		};
		info = {
			name = AL["Hallow's End"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["LOEVISINTHEAIRMENU"] = {
		["Normal"] = {
			{
				{ 2, "Valentineday", "ability_hunter_pet_tallstrider", "=ds="..AL["Vendor"], ""};
				{ 3, "Valentineday#2", "INV_ValentinesBoxOfChocolates02", "=ds="..AL["Misc"], ""};
				{ 17, "ApothecaryHummel", "inv_misc_head_undead_01", "=ds="..BabbleBoss["Apothecary Hummel"], "=q5="..AL["Daily Reward"]};
			};
		};
		info = {
			name = AL["Love is in the Air"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["WINTERVIELMENU"] = {
		["Normal"] = {
			{
				{ 2, "Winterveil", "inv_misc_food_61", "=ds="..AL["Vendor"], ""};
				{ 3, "Winterveil#2", "inv_holiday_christmas_present_02", "=ds="..AL["Gifts & Presents"], ""};
				{ 5, 0, "INV_Holiday_Christmas_Present_01", "=q6="..AL["Special Rewards"], ""};
				{ 6, 90888, "", "=q2=Foot Ball", "#ACHIEVEMENTID:7852#"};
				{ 7, 90883, "", "=q2=The Pigskin", "#ACHIEVEMENTID:7852#"};
				{ 8, 70923, "", "=q2=Gaudy Winter Veil Sweater", "#ACHIEVEMENTID:6061#"};
				{ 9, 46709, "", "=q3=MiniZep Controller", "#ACHIEVEMENTID:6060#"};
				{ 10, 46725, "", "=q2=Red Rider Air Rifle", "#ACHIEVEMENTID:6059#"};
				{ 11, 37710, "", "=q3=Crashin' Thrashin' Racer Controller", "#ACHIEVEMENTID:1706#"};
				{ 12, 34425, "", "=q3=Clockwork Rocket Bot", "#ACHIEVEMENTID:1705#"};
				{ 17, "Winterveil#3", "INV_Holiday_Christmas_Present_01", "=ds="..ALIL["Stolen Present"], "=q5="..AL["Daily Reward"]};
				{ 21, 21525, "", "=q2=Green Winter Hat", "=ds=#s1# =q2="..AL["Various Locations"]};
				{ 22, 21524, "", "=q2=Red Winter Hat", "=ds=#s1# =q2="..AL["Various Locations"]};
				{ 23, 17712, "", "=q1=Winter Veil Disguise Kit", "=q1=#m4#: =ds=#m20#"};
				{ 24, 17202, "", "=q1=Snowball", "=ds=#m20#"};
				{ 25, 34191, "", "=q1=Handful of Snowflakes", "=ds=#m20#"};
				{ 26, 21212, "", "=q1=Fresh Holly", "=ds=#m20#"};
				{ 27, 21519, "", "=q1=Mistletoe", "=ds=#m20#"};
			};
		};
		info = {
			name = AL["Feast of Winter Veil"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["LUNARFESTIVALMENU"] = {
		["Normal"] = {
			{
				{ 2, "LunarFestival", "inv_misc_elvencoins", "=ds="..AL["Vendor"], ""};
				{ 4, 21540, "", "=q2=Elune's Lantern", "=q1=#m4#: =ds=#m20#"};
				{ 17, "LunarFestival#2", "inv_scroll_06", "=ds="..AL["Schematics & Patterns"], ""};
				{ 19, 0, "INV_Misc_LuckyMoneyEnvelope", "=q6="..ALIL["Lucky Red Envelope"], ""};
				{ 20, 21744, "", "=q1=Lucky Rocket Cluster", "=ds=#e23#"};
				{ 21, 21745, "", "=q1=Elder's Moonstone", "=ds=#m20#"};
			};
		};
		info = {
			name = AL["Lunar Festival"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["DARKMOONMENU"] = {
		["Normal"] = {
			{
				{ 2, "DarkmoonD1D2", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=ec1=#j8# - #j9#"};
				{ 3, "DarkmoonD1D2#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "=ec1=#j8# - #j9#"};
				{ 4, "DarkmoonD1D2#3", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "=ec1=#j8# - #j9#"};
				{ 5, "DarkmoonD1D2#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=ec1=#j8# - #j9#"};
				{ 6, "DarkmoonD1D2#5", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=ec1=#j8# - #j9#"};
				{ 7, "DarkmoonD1D2#6", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "=ec1=#j8# - #j9#"};
				{ 8, "DarkmoonD1D2#7", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=ec1=#j8# - #j9#"};
				{ 9, "DarkmoonD1D2#8", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=ec1=#j8# - #j9#"};
				{ 10, "DarkmoonD1D2#9", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=ec1=#j8# - #j9#"};
				{ 12, 74035, "", "=q4=Master Pit Fighter", "=ds=#s14#", "#ACHIEVEMENTID:6024#"};
				{ 13, 74034, "", "=q3=Pit Fighter", "=ds=#s14# / #m2#", "#ACHIEVEMENTID:6023#"};
				{ 17, "Darkmoon", "ability_hunter_pet_bear", "=ds="..BabbleInventory["Mounts"].." & "..BabbleInventory["Companions"], ""};
				{ 18, "Darkmoon#2", "inv_misc_cape_darkmoonfaire_c_01", "=ds="..AL["Toys"], ""};
				{ 19, "Darkmoon#3", "inv_misc_food_164_fish_seadog", "=ds="..AL["Food and Drinks"], ""};
				{ 20, "Darkmoon#5", "inv_misc_bone_taurenskull_01", "=ds="..AL["Heirloom"], "=ec1="..BabbleInventory["Armor"]};
				{ 21, "Darkmoon#6", "inv_sword_17", "=ds="..AL["Heirloom"], "=ec1="..AL["Accessories"].." / "..AL["Weapons"]};
				{ 23, "DarkmoonDeck", "inv_inscription_trinket_tiger", "=ds="..AL["Level 90"].." "..AL["Trinkets"], ""};
				{ 24, "DarkmoonDeck#2", "inv_inscription_tarot_hurricanecard", "=ds="..AL["Level 85"].." "..AL["Trinkets"], ""};
				{ 25, "DarkmoonDeck#3", "INV_Inscription_TarotGreatness", "=ds="..AL["Level 80"].." "..AL["Trinkets"], ""};
				{ 26, "DarkmoonDeck#4", "INV_Misc_Ticket_Tarot_Madness", "=ds="..AL["Level 60 & 70 Trinkets"], ""};
				{ 27, "DarkmoonDeck#5", "INV_Misc_Ticket_Tarot_Furies", "=ds="..AL["Low Level Decks"], ""};
			};
		};
		info = {
			name = ALIL["Darkmoon Faire"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["ABYSSALMENU"] = {
		["Normal"] = {
			{
				{ 1, "Templars", "INV_Jewelry_Talisman_05", "=ds="..AL["Abyssal Council"].." - "..AL["Templars"], ""};
				{ 3, 0, "INV_Box_01", "=q6="..BabbleBoss["Prince Skaldrenox"], "=q1=#j19#"};
				{ 4, 20682, "", "=q4=Elemental Focus Band", "=ds=#s13#", "", "22.83%"};
				{ 5, 20515, "", "=q4=Abyssal Scepter", "=ds=#m3#", "", "100%"};
				{ 6, 20681, "", "=q3=Abyssal Leather Bracers", "=ds=#s8#, #a2#", "", "24.70%"};
				{ 7, 20680, "", "=q3=Abyssal Mail Pauldrons", "=ds=#s3#, #a3#", "", "24.21%"};
				{ 9, 0, "INV_Box_01", "=q6="..BabbleBoss["Lord Skwol"], "=q1=#j20#"};
				{ 10, 20685, "", "=q4=Wavefront Necklace", "=ds=#s2#", "", "24.48%"};
				{ 11, 20515, "", "=q4=Abyssal Scepter", "=ds=#m3#", "", "100%"};
				{ 12, 20684, "", "=q3=Abyssal Mail Armguards", "=ds=#s8#, #a3#", "", "27.68%"};
				{ 13, 20683, "", "=q3=Abyssal Plate Epaulets", "=ds=#s3#, #a4#", "", "21.52%"};
				{ 14, 20687, "", "=q3=Abyssal Plate Vambraces", "=ds=#s8#, #a4#", "", "23.66%"};
				{ 16, "Dukes", "INV_Jewelry_Ring_36", "=ds="..AL["Abyssal Council"].." - "..AL["Dukes"], ""};
				{ 18, 0, "INV_Box_01", "=q6="..BabbleBoss["High Marshal Whirlaxis"], "=q1=#j21#"};
				{ 19, 20691, "", "=q4=Windshear Cape", "=ds=#s4#", "", "22.08%"};
				{ 20, 20515, "", "=q4=Abyssal Scepter", "=ds=#m3#", "", "100%"};
				{ 21, 20690, "", "=q3=Abyssal Cloth Wristbands", "=ds=#s8#, #a1#", "", "23.60%"};
				{ 22, 20689, "", "=q3=Abyssal Leather Shoulders", "=ds=#s3#, #a3#", "", "23.40%"};
				{ 24, 0, "INV_Box_01", "=q6="..BabbleBoss["Baron Kazum"], "=q1=#j22#"};
				{ 25, 20688, "", "=q4=Earthen Guard", "=ds=#w8#", "", "20.64%"};
				{ 26, 20515, "", "=q4=Abyssal Scepter", "=ds=#m3#", "", "100%"};
				{ 27, 20686, "", "=q3=Abyssal Cloth Amice", "=ds=#s3#, #a1#", "", "23.96%"};
			};
		};
		info = {
			name = AL["Abyssal Council"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["ETHEREUMMENU"] = {
		["Normal"] = {
			{
				{ 2, "ArmbreakerHuffaz", "INV_Jewelry_Ring_59", "=ds="..BabbleRare["Armbreaker Huffaz"], ""};
				{ 3, "Forgosh", "INV_Boots_05", "=ds="..BabbleRare["Forgosh"], ""};
				{ 4, "MalevustheMad", "INV_Boots_Chain_04", "=ds="..BabbleRare["Malevus the Mad"], ""};
				{ 5, "WrathbringerLaztarash", "INV_Misc_Orb_01", "=ds="..BabbleRare["Wrathbringer Laz-tarash"], ""};
				{ 17, "FelTinkererZortan", "INV_Boots_Chain_08", "=ds="..BabbleRare["Fel Tinkerer Zortan"], ""};
				{ 18, "Gulbor", "INV_Jewelry_Necklace_29Naxxramas", "=ds="..BabbleRare["Gul'bor"], ""};
				{ 19, "PorfustheGemGorger", "INV_Boots_Cloth_01", "=ds="..BabbleRare["Porfus the Gem Gorger"], ""};
				{ 20, "BashirStasisChambers", "INV_Trinket_Naxxramas02", "=ds="..AL["Bash'ir Landing Stasis Chambers"], ""};
			};
		};
		info = {
			name = AL["Ethereum Prison"],
			menu = "WORLDEVENTMENU",
		};
	}

	AtlasLoot_Data["SKETTISMENU"] = {
		["Normal"] = {
			{
				{ 2, "Terokk", "inv_qirajidol_war", "=ds="..BabbleRare["Terokk"], ""};
				{ 4, "DarkscreecherAkkarai", "spell_nature_natureswrath", "=ds="..BabbleRare["Darkscreecher Akkarai"], ""};
				{ 5, "GezzaraktheHuntress", "inv_misc_monsterclaw_01", "=ds="..BabbleRare["Gezzarak the Huntress"], ""};
				{ 19, "Karrog", "inv_datacrystal08", "=ds="..BabbleRare["Karrog"], ""};
				{ 20, "VakkiztheWindrager", "inv_misc_monsterscales_13", "=ds="..BabbleRare["Vakkiz the Windrager"], ""};
			};
		};
		info = {
			name = AL["Skettis"],
			menu = "WORLDEVENTMENU",
		};
	}