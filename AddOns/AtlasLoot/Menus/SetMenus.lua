-- $Id: SetMenus.lua 4244 2013-09-08 13:20:12Z Dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")
local BabbleItemSet = AtlasLoot_GetLocaleLibBabble("LibBabble-ItemSet-3.0")
local BabbleRare = AtlasLoot_GetLocaleLibBabble("LibBabble-Rare-3.0")

	AtlasLoot_Data["SETMENU"] = {
		["Normal"] = {
			{
				{ 1, "VPMOPMENU", "pvecurrency-valor", "=ds="..AL["Valor Points"].." - "..AL["Rewards"], "=q5="..AL["Mists of Pandaria"]};
				{ 2, "JUSTICEPOINTSMENU", "pvecurrency-justice", "=ds="..AL["Justice Points"].." - "..AL["Rewards"], ""};
				{ 3, "SpiritOfHarmony", "inv_elemental_spiritofharmony_2", "=ds="..ALIL["Spirit of Harmony"].." - "..AL["Rewards"], "=q5="..AL["Mists of Pandaria"]};
				{ 4, "TimelessIsle", "spell_mage_altertime", "=ds="..ALIL["Timeless Isle"].." - "..AL["Rewards"], "=q5="..AL["Mists of Pandaria"]};
				{ 5, "MoltenFront", "inv_misc_markoftheworldtree", "=ds="..ALIL["Molten Front"].." - "..AL["Rewards"], "=q5="..AL["Cataclysm"]};
				{ 8, "RAREMENU", "expansionicon_mistsofpandaria", "=ds="..AL["Rare Mobs"], "=q5="..AL["Mists of Pandaria"]};
				{ 9, "WORLDEPICS", "INV_Sword_76", "=ds="..AL["BoE World Epics"], ""};
				{ 10, "Legendaries", "inv_hammer_unique_sulfuras", "=ds="..AL["Legendary Items"], ""};
				{ 11, "MOUNTMENU", "ability_hunter_pet_dragonhawk", "=ds="..BabbleInventory["Mounts"], ""};
				{ 12, "PETMENU", "INV_Box_PetCarrier_01", "=ds="..BabbleInventory["Companions"], ""};
				{ 13, "TABARDMENU", "inv_chest_cloth_30", "=ds="..BabbleInventory["Tabards"], ""};
				{ 14, "TRANSFORMATIONMENU", "inv_misc_orb_03", "=ds="..AL["Transformation Items"], ""};
				{ 15, "CardGame", "inv_misc_ogrepinata", "=ds="..AL["TCG Items"], ""};
				{ 16, "HEIRLOOMMENU", "INV_Sword_43", "=ds="..AL["Heirloom"].." & "..AL["Bind on Account"], ""};
				{ 17, "CHALLENGEMODESET", "inv_neck_hyjaldaily_04", "=ds="..AL["Challenge Mode Armor Sets"], "=q5="..AL["Mists of Pandaria"]};
				{ 19, "SETSMISCMENU", "inv_misc_monsterscales_15", "=ds="..AL["Misc Sets"], ""};
				{ 21, "T1T2T3SET", "INV_Pants_Mail_03", "=ds="..AL["Tier 1/2/3 Set"], "=q5="..AL["Classic WoW"]};
				{ 22, "T456SET", "INV_Gauntlets_63", "=ds="..AL["Tier 4/5/6 Set"], "=q5="..AL["Burning Crusade"]};
				{ 23, "T7T8SET", "INV_Chest_Chain_15", "=ds="..AL["Tier 7/8 Set"], "=q5="..AL["Wrath of the Lich King"]};
				{ 24, "T9SET", "inv_gauntlets_80", "=ds="..AL["Tier 9 Set"], "=q5="..AL["Wrath of the Lich King"]};
				{ 25, "T10SET", "inv_chest_plate_26", "=ds="..AL["Tier 10 Set"], "=q5="..AL["Wrath of the Lich King"]};
				{ 26, "T1112SET", "inv_helm_robe_raidmage_i_01", "=ds="..AL["Tier 11/12 Set"], "=q5="..AL["Cataclysm"]};
				{ 27, "T13SET", "inv_shoulder_plate_raiddeathknight_j_01", "=ds="..AL["Tier 13 Set"], "=q5="..AL["Cataclysm"]};
				{ 28, "T14SET", "inv_shoulder_cloth_raidwarlock_l_01", "=ds="..AL["Tier 14 Set"], "=q5="..AL["Mists of Pandaria"]};
				{ 29, "T15SET", "inv_chest_plate_raidwarrior_m_01", "=ds="..AL["Tier 15 Set"], "=q5="..AL["Mists of Pandaria"]};
				{ 30, "T16SET", "inv_shoulder_leather_raidmonk_n_01", "=ds="..AL["Tier 16 Set"], "=q5="..AL["Mists of Pandaria"]};
			};
		};
		info = {
			name = AL["Collections"],
		};
	}

	AtlasLoot_Data["VPMOPMENU"] = {
		["Normal"] = {
			{
				{ 2, "ValorPointsMoP", "inv_helmet_cloth_reputation_c_01", "=ds="..BabbleInventory["Cloth"], ""};
				{ 3, "ValorPointsMoP#2", "inv_helm_mail_reputation_c_01", "=ds="..BabbleInventory["Mail"], ""};
				{ 5, "ValorPointsMoP#4", "inv_cape_pandaria_c_01", "=ds="..AL["Accessories"], ""};
				{ 7, 104014, "", "=q4=Pouch of Timeless Coins", "=ds=#m17#", "#VALOR:500#"};
				{ 17, "ValorPointsMoP", "inv_helm_leather_reputation_c_01", "=ds="..BabbleInventory["Leather"], ""};
				{ 18, "ValorPointsMoP#3", "inv_helmet_plate_reputation_c_01", "=ds="..BabbleInventory["Plate"], ""};
				{ 22, 80433, "", "=q3=Blood Spirit", "=ds=#e8#", "#VALOR:400#"};
			};
		};
		info = {
			name = AL["Valor Points"].." - "..AL["Rewards"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["JUSTICEPOINTSMENU"] = {
		["Normal"] = {
			{
				{ 2, "JusticePointsMoP", "inv_chest_robe_dungeonrobe_c_04", "=ds="..BabbleInventory["Cloth"], ""};
				{ 3, "JusticePointsMoP#4", "inv_chest_mail_dungeonmail_c_04", "=ds="..BabbleInventory["Mail"], ""};
				{ 5, "JusticePointsMoP#8", "inv_misc_forestnecklace", "=ds="..AL["Accessories"], ""};
				{ 7, "JPCATAMENU", "inv_misc_necklacea10", "=ds="..AL["Justice Points"].." "..AL["Rewards"], "=q5="..AL["Cataclysm"]};
				{ 8, "JPBCMENU", "inv_valentineperfumebottle", "=ds="..AL["Justice Points"].." "..AL["Rewards"], "=q5="..AL["Burning Crusade"]};
				{ 17, "JusticePointsMoP#2", "inv_helmet_193", "=ds="..BabbleInventory["Leather"], ""};
				{ 18, "JusticePointsMoP#5", "inv_gauntlets_plate_dungeonplate_c_04", "=ds="..BabbleInventory["Plate"], ""};
				{ 20, 92742, "", "=q2=Polished Battle-Stone", "", "#JUSTICE:1000#" },
				{ 22, "JPWRATHMENU", "inv_misc_frostemblem_01", "=ds="..AL["Justice Points"].." "..AL["Rewards"], "=q5="..AL["Wrath of the Lich King"]};
			};
		};
		info = {
			name = AL["Justice Points"].." - "..AL["Rewards"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["JPCATAMENU"] = {
		["Normal"] = {
			{
				{ 2, "JusticePoints", "inv_chest_robe_dungeonrobe_c_04", "=ds="..BabbleInventory["Cloth"], ""};
				{ 3, "JusticePoints#3", "inv_chest_mail_dungeonmail_c_04", "=ds="..BabbleInventory["Mail"], ""};
				{ 5, "JusticePoints#6", "inv_misc_forestnecklace", "=ds="..AL["Accessories"], ""};
				{ 7, 52722, "", "=q4=Maelstrom Crystal", "", "#JUSTICE:3750#" },
				{ 8, 68813, "", "=q3=Satchel of Freshly-Picked Herbs", "", "#JUSTICE:1500#" },
				{ 9, 53010, "", "=q1=Embersilk Cloth", "", "#JUSTICE:1250#" },
				{ 10, 52185, "", "=q1=Elementium Ore", "", "#JUSTICE:1000#" },
				{ 17, "JusticePoints#2", "inv_helmet_193", "=ds="..BabbleInventory["Leather"], ""};
				{ 18, "JusticePoints#4", "inv_gauntlets_plate_dungeonplate_c_04", "=ds="..BabbleInventory["Plate"], ""};
				{ 20, "JusticePoints#8", "inv_wand_1h_firelandsraid_d_01", "=ds="..AL["Weapons"], ""};
				{ 22, 52721, "", "=q3=Heavenly Shard", "", "#JUSTICE:600#" },
				{ 23, 52719, "", "=q2=Greater Celestial Essence", "", "#JUSTICE:400#" },
				{ 24, 52976, "", "=q1=Savage Leather", "", "#JUSTICE:375#" },
				{ 25, 52555, "", "=q1=Hypnotic Dust", "", "#JUSTICE:100#" },
			};
		};
		info = {
			name = AL["Justice Points"].." - "..AL["Rewards"],
			menu = "JUSTICEPOINTSMENU",
		};
	}

	AtlasLoot_Data["JPWRATHMENU"] = {
		["Normal"] = {
			{
				{ 2, "EmblemofFrost", "inv_misc_frostemblem_01", "=ds="..string.format(AL["ilvl %d"], 264), "=q5="..BabbleInventory["Armor"]};
				{ 4, "EmblemofTriumph", "spell_holy_summonchampion", "=ds="..string.format(AL["ilvl %d"], 245), "=q5="..BabbleInventory["Armor"]};
				{ 5, "EmblemofTriumph#2", "spell_holy_summonchampion", "=ds="..string.format(AL["ilvl %d"], 245), "=q5="..AL["Accessories"].." & "..AL["Weapons"]};
				{ 7, "EmblemofConquest", "Spell_Holy_ChampionsGrace", "=ds="..string.format(AL["ilvl %d"], 226), "=q5="..BabbleInventory["Armor"]};
				{ 9, "EmblemofValor", "Spell_Holy_ProclaimChampion_02", "=ds="..string.format(AL["ilvl %d"], 213), "=q5="..BabbleInventory["Armor"]};
				{ 11, "EmblemofHeroism", "Spell_Holy_ProclaimChampion", "=ds="..string.format(AL["ilvl %d"], 200), "=q5="..BabbleInventory["Armor"].." & "..AL["Weapons"]};
				{ 13, "PVP80SET", "INV_Boots_01", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 80"]};
				{ 17, "T10SET", "inv_misc_frostemblem_01", "=ds="..AL["Tier 10 Set"], "=q5="..AL["10/25 Man"]};
				{ 19, "T9SET", "spell_holy_summonchampion", "=ds="..AL["Tier 9 Set"], "=q5="..AL["10/25 Man"]};
				{ 22, "EmblemofConquest#2", "Spell_Holy_ChampionsGrace", "=ds="..string.format(AL["ilvl %d"], 226), "=q5="..AL["Accessories"]};
				{ 24, "EmblemofValor#2", "Spell_Holy_ProclaimChampion_02", "=ds="..string.format(AL["ilvl %d"], 213), "=q5="..AL["Accessories"]};
				{ 26, "EmblemofHeroism#2", "Spell_Holy_ProclaimChampion", "=ds="..string.format(AL["ilvl %d"], 200), "=q5="..AL["Accessories"]};
			};
		};
		info = {
			name = AL["Justice Points"].." - "..AL["Rewards"],
			menu = "JUSTICEPOINTSMENU",
		};
	}

	AtlasLoot_Data["JPBCMENU"] = {
		["Normal"] = {
			{
				{ 2, "HardModeCloth", "inv_pants_cloth_15", "=ds="..BabbleInventory["Cloth"], ""};
				{ 3, "HardModeMail", "inv_pants_mail_26", "=ds="..BabbleInventory["Mail"], ""};
				{ 4, "HardModeResist", "inv_chest_cloth_18", "=ds="..AL["Fire Resistance Gear"], ""};
				{ 6, "HardModeWeapons", "inv_shield_33", "=ds="..AL["Weapons"], ""};
				{ 8, "HardModeAccessories", "inv_valentineperfumebottle", "=ds="..AL["Accessories"], ""};
				{ 17, "HardModeLeather", "inv_shoulder_83", "=ds="..BabbleInventory["Leather"], ""};
				{ 18, "HardModePlate", "inv_belt_27", "=ds="..BabbleInventory["Plate"], ""};
				{ 19, "HardModeCloaks", "inv_misc_cape_06", "=ds="..BabbleInventory["Back"], ""};
				{ 21, "HardModeArena", "inv_bracer_07", "=ds="..AL["PvP Rewards"], ""};
			};
		};
		info = {
			name = AL["Justice Points"].." - "..AL["Rewards"],
			menu = "JUSTICEPOINTSMENU",
		};
	}

	AtlasLoot_Data["SpiritOfHarmony"] = {
		["Normal"] = {
			{
				{ 2, "SmithingMoPVendor", "inv_scroll_04", "=ds="..AL["Mists of Pandaria Vendor Sold Plans"], "=q5="..ALIL["Vale of Eternal Blossoms"]};
				{ 3, "TailoringMoPVendor", "inv_scroll_04", "=ds="..AL["Mists of Pandaria Vendor Sold Patterns"], "=q5="..ALIL["Vale of Eternal Blossoms"]};
				{ 17, "LeatherworkingMoPVendor", "inv_scroll_04", "=ds="..AL["Mists of Pandaria Vendor Sold Patterns"], "=q5="..ALIL["Vale of Eternal Blossoms"]};
				{ 20, 72238, "", "=q2=Golden Lotus", "=ds=", "#SPIRITOFHARMONY:1#", amount = 2};
				{ 21, 89610, "", "=q1=Pandaria Herbs", "=ds=", "#SPIRITOFHARMONY:1#"};
				{ 23, 74247, "", "=q3=Ethereal Shard", "=ds=", "#SPIRITOFHARMONY:1#"};
				{ 24, 74250, "", "=q2=Mysterious Essence", "=ds=", "#SPIRITOFHARMONY:1#", amount = 5};
				{ 25, 74249, "", "=q1=Spirit Dust", "=ds=", "#SPIRITOFHARMONY:1#", amount = 20};
				{ 27, 72120, "", "=q1=Exotic Leather", "=ds=", "#SPIRITOFHARMONY:1#", amount = 20};
				{ 28, 79101, "", "=q1=Prismatic Scale", "=ds=", "#SPIRITOFHARMONY:1#", amount = 20};
				{ 5, 76734, "", "=q3=Serpent's Eye", "=ds=", "#SPIRITOFHARMONY:1#"};
				{ 6, 0, "inv_relics_idolofferocity", "=q1=Ironpaw Token", "=ds=#p3# #m17#", "#SPIRITOFHARMONY:1#"};
				{ 7, 87399, "", "=q1=Restored Artifact", "=ds=", "#SPIRITOFHARMONY:1#"};
				{ 8, 79255, "", "=q2=Starlight Ink", "=ds=", "#SPIRITOFHARMONY:1#"};
				{ 9, 72988, "", "=q1=Windwool Cloth", "=ds=", "#SPIRITOFHARMONY:1#", amount = 20};
				{ 11, 72094, "", "=q2=Black Trillium Ore", "=ds=", "#SPIRITOFHARMONY:1#", amount = 5};
				{ 12, 72103, "", "=q2=White Trillium Ore", "=ds=", "#SPIRITOFHARMONY:1#", amount = 5};
				{ 13, 72092, "", "=q1=Ghost Iron Ore", "=ds=", "#SPIRITOFHARMONY:1#", amount = 20};
				{ 14, 72093, "", "=q1=Kyparite", "=ds=", "#SPIRITOFHARMONY:1#", amount = 20};
			};
		};
		info = {
			name = ALIL["Spirit of Harmony"].." - "..AL["Rewards"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["WORLDEPICS"] = {
		["Normal"] = {
			{
				{ 2, "WorldEpics90", "inv_cape_pandaria_d_01", "=ds="..AL["Level 90"], ""};
				{ 3, "WorldEpics80", "INV_Sword_109", "=ds="..AL["Level 80"], ""};
				{ 4, "WorldEpics5060", "INV_Jewelry_Amulet_01", "=ds="..string.format(AL["Level %s"], "50-60"), ""};
				{ 5, "WorldEpics3039", "INV_Jewelry_Ring_15", "=ds="..string.format(AL["Level %s"], "30-39"), ""};
				{ 17, "WorldEpics85", "inv_misc_cape_cataclysm_caster_c_01", "=ds="..AL["Level 85"], ""};
				{ 18, "WorldEpics70", "INV_Sword_76", "=ds="..AL["Level 70"], ""};
				{ 19, "WorldEpics4049", "INV_Staff_29", "=ds="..string.format(AL["Level %s"], "40-49"), ""};
			};
		};
		info = {
			name = AL["BoE World Epics"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["MOUNTMENU"] = {
		["Normal"] = {
			{
				{ 2, "MountsAlliance", "achievement_pvp_a_16", "=ds="..ALIL["Darnassus"].." / "..ALIL["Gnomeregan"], "=ec1="..FACTION_ALLIANCE};
				{ 3, "MountsAlliance#2", "achievement_pvp_a_16", "=ds="..ALIL["Ironforge"].." / "..ALIL["Exodar"].." / "..ALIL["Stormwind"], "=ec1="..FACTION_ALLIANCE};
				{ 4, "MountsAlliance#3", "achievement_pvp_a_16", "=ds="..ALIL["Tushui Pandaren"].." / "..ALIL["Gilneas"], "=ec1="..FACTION_ALLIANCE};
				{ 5, "MountsAlliance#4", "achievement_pvp_a_16", "=ds="..AL["Flying Mounts"].." / "..ALIL["Kurenai"], "=ec1="..FACTION_ALLIANCE};
				{ 6, "MountsAlliance#5", "achievement_pvp_a_16", "=ds="..ALIL["Dalaran"].." / "..AL["Misc"], "=ec1="..FACTION_ALLIANCE};
				{ 8, "MountsFaction", "ability_mount_warhippogryph", "=ds="..AL["Neutral Faction Mounts"], ""};
				{ 9, "MountsRareDungeon", "ability_mount_drake_bronze", "=ds="..AL["Rare Mounts"], "=ec1="..AL["Dungeon"].." / "..AL["Outdoor"]};
				{ 10, "MountsCraftQuest", "ability_mount_gyrocoptorelite", "=ds="..BabbleInventory["Quest"].." / "..AL["Crafted Mounts"], ""};
				{ 11, "MountsEvent", "achievement_halloween_witch_01", "=ds="..AL["World Events"], ""};
				{ 12, "MountsPromotional", "inv_misc_reforgedarchstone_01", "=ds="..AL["Promotional Mounts"], ""};
				{ 13, "MountsNEW", "ability_mount_shreddermount", "=ds="..AL["New Mounts"], "=q5=Patch 5.4"};
				{ 17, "MountsHorde", "achievement_pvp_h_16", "=ds="..ALIL["Orgrimmar"].." / "..ALIL["Silvermoon City"], "=ec1="..FACTION_HORDE};
				{ 18, "MountsHorde#2", "achievement_pvp_h_16", "=ds="..ALIL["Darkspear Trolls"].." / "..ALIL["Thunder Bluff"].." / "..ALIL["Undercity"], "=ec1="..FACTION_HORDE};
				{ 19, "MountsHorde#3", "achievement_pvp_h_16", "=ds="..ALIL["Huojin Pandaren"].." / "..ALIL["Bilgewater Cartel"], "=ec1="..FACTION_HORDE};
				{ 20, "MountsHorde#4", "achievement_pvp_h_16", "=ds="..AL["Flying Mounts"].." / "..ALIL["The Mag'har"], "=ec1="..FACTION_HORDE};
				{ 21, "MountsHorde#5", "achievement_pvp_h_16", "=ds="..ALIL["Dalaran"].." / "..AL["Misc"], "=ec1="..FACTION_HORDE};
				{ 23, "MountsPvP", "ability_mount_netherdrakeelite", "=ds="..AL["PvP Mounts"], ""};
				{ 24, "MountsRareRaid", "inv_misc_summerfest_brazierorange", "=ds="..AL["Rare Mounts"], "=ec1="..AL["Raid"]};
				{ 25, "MountsAchievement", "inv_mount_allianceliong", "=ds="..AL["Achievement Reward"], ""};
				{ 26, "MountsCardGame", "ability_mount_bigblizzardbear", "=ds="..AL["Card Game Mounts"], ""};
				{ 27, "MountsRemoved", "INV_Misc_QirajiCrystal_05", "=ds="..AL["Unobtainable Mounts"], ""};
			};
		};
		info = {
			name = BabbleInventory["Mounts"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["PETMENU"] = {
		["Normal"] = {
			{
				{ 2, "PetsMerchant", "spell_nature_polymorph", "=ds="..AL["Merchant Sold Companions"], ""};
				{ 3, "PetsCrafted", "inv_drink_19", "=ds="..AL["Crafted Companions"], ""};
				{ 4, "PetsRare", "spell_shaman_hex", "=ds="..AL["Rare Companions"], ""};
				{ 5, "PetsFaction", "ability_hunter_pet_sporebat", "=ds="..AL["Faction Companions"], ""};
				{ 6, "PetsEvent", "inv_pet_egbert", "=ds="..AL["World Events"], ""};
				{ 7, "PetsRemoved", "inv_pet_babyblizzardbear", "=ds="..AL["Unobtainable Companions"], ""};
				{ 8, "PetsNEW", "inv_worserobot", "=ds="..AL["New Companions"], "=q5=Patch 5.4"};
				{ 17, "PetsQuest", "inv_drink_19", "=ds="..AL["Quest Reward Companions"], ""};
				{ 18, "PetsAchievement", "inv_misc_darkphoenixpet_01", "=ds="..AL["Achievement Reward"], ""};
				{ 19, "PetsPromotional", "inv_netherwhelp", "=ds="..AL["Promotional Companions"], ""};
				{ 20, "PetsCardGame", "inv_misc_fish_34", "=ds="..AL["Card Game Companions"], ""};
				{ 21, "PetsPetStore", "INV_Misc_Coin_01", "=ds="..AL["Blizzard Store"], ""};
				{ 22, "PetsAccessories", "inv_misc_petbiscuit_01", "=ds="..AL["Companion Accessories"], ""};
			};
		};
		info = {
			name = BabbleInventory["Companions"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["TABARDMENU"] = {
		["Normal"] = {
			{
				{ 1, "TabardsAlliance", "achievement_pvp_a_16", "=ds="..AL["Alliance Tabards"], ""};
				{ 2, "TabardsNeutralFaction", "inv_misc_tabard_tolvir", "=ds="..AL["Neutral Faction Tabards"], ""};
				{ 3, "TabardsRemoved", "INV_Jewelry_Ring_15", "=ds="..AL["Unobtainable Tabards"], ""};
				{ 5, 0, "INV_Box_01", "=q6="..AL["Mists of Pandaria"], ""};
				{ 6, 89401, "", "=q3=Anglers Tabard", "=ds=#s7#"};
				{ 7, 89799, "", "=q3=August Celestials Tabard", "=ds=#s7#"};
				{ 8, 89797, "", "=q3=Golden Lotus Tabard", "=ds=#s7#"};
				{ 9, 89798, "", "=q3=Klaxxi Tabard", "=ds=#s7#"};
				{ 10, 89795, "", "=q3=Lorewalkers Tabard", "=ds=#s7#"};
				{ 11, 89796, "", "=q3=Order of the Cloud Serpent Tabard", "=ds=#s7#"};
				{ 12, 89800, "", "=q3=Shado-Pan Tabard", "=ds=#s7#"};
				{ 13, 89784, "", "=q3=Tillers Tabard", "=ds=#s7#"};
				{ 14, 86468, "", "=q7=Apron", "=ds=#s7#"};
				{ 16, "TabardsHorde", "achievement_pvp_h_16", "=ds="..AL["Horde Tabards"], ""};
				{ 17, "TabardsAchievementQuestRare", "inv_shirt_guildtabard_01", "=ds="..AL["Achievement & Quest Reward Tabards"], ""};
				{ 20, 0, "INV_Box_01", "=q6="..AL["Misc"], ""};
				{ 21, 69210, "", "=q4=Renowned Guild Tabard", "=ds=#s7#"};
				{ 22, 69209, "", "=q3=Illustrious Guild Tabard", "=ds=#s7#"};
				{ 23, 5976, "", "=q1=Guild Tabard", "=ds=#s7#"};
			};
		};
		info = {
			name = BabbleInventory["Tabards"],
			menu = "SETMENU",
		};
	}
	
	AtlasLoot_Data["TRANSFORMATIONMENU"] = {
		["Normal"] = {
			{
				{ 2, "TransformationNonconsumedItems", "inv_misc_orb_02", "=ds="..AL["Non-consumed Transformation Items"], ""};
				{ 4, "TransformationAdditionalEffects", "stave_2h_tarecgosa_e_01stagefinal", "=ds="..AL["Additional Effects Transformation Items"]};
				{ 17, "TransformationConsumableItems", "inv_misc_monsterhead_04", "=ds="..AL["Consumable Transformation Items"], ""};
			};
		};
		info = {
			name = AL["Transformation Items"],
			menu = "SETMENU",
		};
	}	

	AtlasLoot_Data["HEIRLOOMMENU"] = {
		["Normal"] = {
			{
				{ 2, "Heirloom", "inv_helmet_24", "=ds="..BabbleInventory["Back"].." / "..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"], ""};
				{ 3, "Heirloom#4", "inv_sword_19", "=ds="..AL["PvP Heirlooms"], ""};
				{ 5, 86559, "", "=q7=Frying Pan", "=ds=#h1#", "#IRONPAW:50#"};
				{ 6, 86558, "", "=q7=Rolling Pin", "=ds=#s15#", "#IRONPAW:50#"};
				{ 7, 86468, "", "=q7=Apron", "=ds=#s7#", "#IRONPAW:50#"};
				{ 9, 88563, "", "=q7=Nat's Fishing Journal", "=ds=#m2#", "1,000 #gold#"};
				{ 11, "HeirloomBoAArmor", "trade_archaeology_ancientorcshamanheaddress", "=ds="..AL["Bind on Account Armor"], ""};
				{ 12, "HeirloomBoAMisc", "trade_archaeology_pendant of the aqir", "=ds="..AL["Misc"], ""};
				{ 17, "Heirloom#2", "inv_chest_plate03", "=ds="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"], ""};
				{ 18, "Heirloom#3", "inv_sword_17", "=ds="..AL["Accessories"].." / "..AL["Weapons"], ""};
				{ 20, 44133, "", "=q7=Greater Inscription of the Axe", "=ds=#s3# #e17#", "100 #gold#"};
				{ 21, 44134, "", "=q7=Greater Inscription of the Crag", "=ds=#s3# #e17#", "100 #gold#"};
				{ 22, 44136, "", "=q7=Greater Inscription of the Pinnacle", "=ds=#s3# #e17#", "100 #gold#"};
				{ 23, 44135, "", "=q7=Greater Inscription of the Storm ", "=ds=#s3# #e17#", "100 #gold#"};
				{ 26, "HeirloomBoAWeapons", "inv_mace_46", "=ds="..AL["Bind on Account Weapons"], ""};
			};
		};
		info = {
			name = AL["Heirloom"].." & "..AL["Bind on Account"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["CHALLENGEMODESET"] = {
		["Normal"] = {
			{
				{ 2, "ChallengeModeDeathKnight", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "ChallengeModeDruid", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "ChallengeModeHunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 5, "ChallengeModeMage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, "ChallengeModeMonk", "spell_monk_windwalker_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], ""};
				{ 7, "ChallengeModePaladin", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 17, "ChallengeModePriest", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "ChallengeModeRogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "ChallengeModeShaman", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "ChallengeModeWarlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "ChallengeModeWarrior", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
			};
		};
		info = {
			name = AL["Challenge Mode Armor Sets"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["RAREMENU"] = {
		["Normal"] = {
			{
				{ 2, "RaresMOPMobsJadeForest", "achievement_zone_jadeforest", "=ds="..ALIL["The Jade Forest"], "#ACHIEVEMENTID:7439#"};
				{ 3, "RaresMOPMobsKrasarangWilds", "achievement_zone_krasarangwilds", "=ds="..ALIL["Krasarang Wilds"], "#ACHIEVEMENTID:7439#"};
				{ 4, "RaresMOPMobsTownlongSteppes", "achievement_zone_townlongsteppes", "=ds="..ALIL["Townlong Steppes"], "#ACHIEVEMENTID:7439#"};
				{ 5, "RaresMOPMobsValeOfEternalBlossoms", "achievement_zone_valeofeternalblossoms", "=ds="..ALIL["Vale of Eternal Blossoms"], "#ACHIEVEMENTID:7439#"};
				{ 7, "RaresMOPMobsMisc", "inv_pandarenserpentmount_lightning", "=ds="..AL["Misc"], ""};
				{ 8, "RaresMOPMobsWarbringer", "achievement_boss_chiefukorzsandscalp", "=ds="..BabbleRare["Zandalari Warbringer"], ""};
				{ 10, "RaresMOPItemsJadeForestValleyoftheFourWinds", "achievement_zone_jadeforest", "=ds="..ALIL["The Jade Forest"].." / "..ALIL["Valley of the Four Winds"], "#ACHIEVEMENTID:7284#"};
				{ 11, "RaresMOPItemsTownlongSteppesDreadWastes", "achievement_zone_krasarangwilds", "=ds="..ALIL["Townlong Steppes"].." / "..ALIL["Dread Wastes"], "#ACHIEVEMENTID:7284#"};
				{ 17, "RaresMOPMobsValleyFourWinds", "achievement_zone_valleyoffourwinds", "=ds="..ALIL["Valley of the Four Winds"], "#ACHIEVEMENTID:7439#"};
				{ 18, "RaresMOPMobsKunLaiSummit", "achievement_zone_kunlaisummit", "=ds="..ALIL["Kun-Lai Summit"], "#ACHIEVEMENTID:7439#"};
				{ 19, "RaresMOPMobsDreadWastes", "achievement_zone_dreadwastes", "=ds="..ALIL["Dread Wastes"], "#ACHIEVEMENTID:7439#"};
				{ 20, "RaresMOPMobsIsleofThunder", "inv_shield_mogu_c_01", "=ds="..ALIL["Isle of Thunder"], "#ACHIEVEMENTID:8103#"};
				{ 22, "RaresMOPMobsClawlord", "inv_misc_birdbeck_02", "=ds="..BabbleRare["Clawlord Kril'mandar"], ""};
				{ 25, "RaresMOPItemsKrasarangWildsKunLaiSummit", "achievement_zone_valleyoffourwinds", "=ds="..ALIL["Krasarang Wilds"].." / "..ALIL["Kun-Lai Summit"], "#ACHIEVEMENTID:7284#"};
			};
		};
		info = {
			name = AL["Rare Mobs"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["SETSMISCMENU"] = {
		["Normal"] = {
			{
				{ 1, 0, "INV_Box_01", "=q6="..BabbleItemSet["Jaws of Retribution"], "=q1="..ALIL["Dragon Soul"]};
				{ 2, 77945, "", "=q4=Fear", "=ds=#h3#, #w4#", "" };
				{ 3, 77946, "", "=q4=Vengeance", "=ds=#h4#, #w4#", "" };
				{ 5, 0, "INV_Box_01", "=q6="..BabbleItemSet["Maw of Oblivion"], "=q1="..ALIL["Dragon Soul"]};
				{ 6, 77947, "", "=q4=The Sleeper", "=ds=#h3#, #w4#", "" };
				{ 7, 77948, "", "=q4=The Dreamer", "=ds=#h4#, #w4#", "" };
				{ 9, "AQ20Sets", "achievement_boss_ossiriantheunscarred", "=ds="..ALIL["Ruins of Ahn'Qiraj"].." "..AL["Set"], "=q5="..AL["Classic WoW"]};
				{ 11, "T0SET", "INV_Chest_Chain_03", "=ds="..AL["Dungeon Set 1/2"], "=q5="..AL["No Longer Available"]};
				{ 16, 0, "INV_Box_01", "=q6="..BabbleItemSet["Fangs of the Father"], "=q1="..ALIL["Dragon Soul"]};
				{ 17, 77949, "", "=q5=Golad, Twilight of Aspects", "=ds=#h3#, #w4#", "" };
				{ 18, 77950, "", "=q5=Tiriosh, Nightmare of Ages", "=ds=#h4#, #w4#", "" };
				{ 20, "SETSCLASSIC", "INV_Sword_43", "=ds="..AL["Classic WoW"].." "..AL["Sets"], ""};
				{ 21, "TBCSets", "INV_Weapon_Glave_01", "=ds="..AL["Burning Crusade"].." "..AL["Sets"], ""};
				{ 22, "WOTLKSets", "inv_misc_monsterscales_15", "=ds="..AL["Wrath of the Lich King"].." "..AL["Sets"], ""};
				{ 24, "AQ40Sets", "achievement_boss_cthun", "=ds="..ALIL["Temple of Ahn'Qiraj"].." "..AL["Set"], "=q5="..AL["Classic WoW"]};
				{ 26, "DS3SET", "INV_Helmet_15", "=ds="..AL["Dungeon Set 3"], "=q5="..AL["Burning Crusade"]};
			};
		};
		info = {
			name = AL["Misc Sets"],
			menu = "SETMENU",
		};
	}

	AtlasLoot_Data["SETSCLASSIC"] = {
		["Normal"] = {
			{
				{ 2, "VWOWSets#1", "INV_Pants_12", "=ds="..BabbleItemSet["Defias Leather"], "=q5="..ALIL["The Deadmines"]};
				{ 3, "VWOWSets#1", "INV_Shirt_16", "=ds="..BabbleItemSet["Embrace of the Viper"], "=q5="..ALIL["Wailing Caverns"]};
				{ 4, "VWOWSets#1", "INV_Gauntlets_19", "=ds="..BabbleItemSet["Chain of the Scarlet Crusade"], "=q5="..ALIL["Scarlet Monastery"]};
				{ 5, "VWOWSets#1", "INV_Helmet_01", "=ds="..BabbleItemSet["The Gladiator"], "=q5="..ALIL["Blackrock Depths"]};
				{ 6, "VWOWSets#2", "INV_Boots_Cloth_05", "=ds="..BabbleItemSet["Ironweave Battlesuit"], "=q5="..AL["Various Locations"]};
				{ 7, "VWOWSets#2", "INV_Boots_02", "=ds="..BabbleItemSet["The Postmaster"], "=q5="..ALIL["Stratholme"]};
				{ 8, "VWOWScholo", "INV_Shoulder_02", "=ds="..BabbleItemSet["Necropile Raiment"], "=q5="..ALIL["Scholomance"]};
				{ 17, "VWOWScholo", "INV_Belt_16", "=ds="..BabbleItemSet["Cadaverous Garb"], "=q5="..ALIL["Scholomance"]};
				{ 18, "VWOWScholo", "INV_Gauntlets_26", "=ds="..BabbleItemSet["Bloodmail Regalia"], "=q5="..ALIL["Scholomance"]};
				{ 19, "VWOWScholo", "INV_Belt_12", "=ds="..BabbleItemSet["Deathbone Guardian"], "=q5="..ALIL["Scholomance"]};
				{ 20, "VWOWSets#3", "INV_Weapon_ShortBlade_16", "=ds="..BabbleItemSet["Spider's Kiss"], "=q5="..ALIL["Lower Blackrock Spire"]};
				{ 21, "VWOWSets#3", "INV_Sword_43", "=ds="..BabbleItemSet["Dal'Rend's Arms"], "=q5="..ALIL["Upper Blackrock Spire"]};
				{ 22, "VWOWSets#3", "INV_Misc_MonsterScales_15", "=ds="..BabbleItemSet["Shard of the Gods"], "=q5="..AL["Various Locations"]};
				{ 23, "VWOWSets#3", "INV_Misc_MonsterClaw_04", "=ds="..BabbleItemSet["Spirit of Eskhandar"], "=q5="..AL["Various Locations"]};
			};
		};
		info = {
			name = AL["Classic WoW"].." "..AL["Sets"],
			menu = "SETSMISCMENU",
		};
	}

	AtlasLoot_Data["T0SET"] = {
		["Normal"] = {
			{
				{ 3, "T0Druid", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "T0Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "T0Priest", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 6, "T0Shaman", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 7, "T0Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 18, "T0Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 19, "T0Paladin", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 20, "T0Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 21, "T0Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
			};
		};
		info = {
			name = AL["Dungeon Set 1/2"],
			menu = "SETSMISCMENU",
		};
	}

	AtlasLoot_Data["DS3SET"] = {
		["Normal"] = {
			{
				{ 2, "DS3Cloth", "Spell_Holy_InnerFire", "=ds="..BabbleItemSet["Hallowed Raiment"], "=q5="..BabbleInventory["Cloth"]};
				{ 3, "DS3Cloth", "INV_Elemental_Mote_Nether", "=ds="..BabbleItemSet["Mana-Etched Regalia"], "=q5="..BabbleInventory["Cloth"]};
				{ 5, "DS3Leather", "Ability_Rogue_SinisterCalling", "=ds="..BabbleItemSet["Assassination Armor"], "=q5="..BabbleInventory["Leather"]};
				{ 6, "DS3Leather", "Ability_Hunter_RapidKilling", "=ds="..BabbleItemSet["Wastewalker Armor"], "=q5="..BabbleInventory["Leather"]};
				{ 8, "DS3Mail", "Ability_Hunter_Pet_Wolf", "=ds="..BabbleItemSet["Beast Lord Armor"], "=q5="..BabbleInventory["Mail"]};
				{ 9, "DS3Mail", "INV_Helmet_70", "=ds="..BabbleItemSet["Tidefury Raiment"], "=q5="..BabbleInventory["Mail"]};
				{ 11, "DS3Plate", "Spell_Fire_EnchantWeapon", "=ds="..BabbleItemSet["Bold Armor"], "=q5="..BabbleInventory["Plate"]};
				{ 12, "DS3Plate", "INV_Hammer_02", "=ds="..BabbleItemSet["Righteous Armor"], "=q5="..BabbleInventory["Plate"]};
				{ 17, "DS3Cloth", "Ability_Creature_Cursed_04", "=ds="..BabbleItemSet["Incanter's Regalia"], "=q5="..BabbleInventory["Cloth"]};
				{ 18, "DS3Cloth", "Ability_Creature_Cursed_03", "=ds="..BabbleItemSet["Oblivion Raiment"], "=q5="..BabbleInventory["Cloth"]};
				{ 20, "DS3Leather", "Spell_Holy_SealOfRighteousness", "=ds="..BabbleItemSet["Moonglade Raiment"], "=q5="..BabbleInventory["Leather"]};
				{ 23, "DS3Mail", "Ability_FiegnDead", "=ds="..BabbleItemSet["Desolation Battlegear"], "=q5="..BabbleInventory["Mail"]};
				{ 26, "DS3Plate", "INV_Helmet_08", "=ds="..BabbleItemSet["Doomplate Battlegear"], "=q5="..BabbleInventory["Plate"]};
			};
		};
		info = {
			name = AL["Dungeon Set 3"],
			menu = "SETSMISCMENU",
		};
	}

	AtlasLoot_Data["T1T2T3SET"] = {
		["Normal"] = {
			{
				{ 1, "T1T2Druid", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Tier 1/2 Set"]};
				{ 2, "T3Druid", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..AL["Tier 3 Set"]};
				{ 4, "T1T2Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "=q5="..AL["Tier 1/2 Set"]};
				{ 5, "T3Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], "=q5="..AL["Tier 3 Set"]};
				{ 7, "T1T2Priest", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Tier 1/2 Set"]};
				{ 8, "T3Priest", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..AL["Tier 3 Set"]};
				{ 10, "T1T2Shaman", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Tier 1/2 Set"]};
				{ 11, "T3Shaman", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..AL["Tier 3 Set"]};
				{ 13, "T1T2Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Tier 1/2 Set"]};
				{ 14, "T3Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["Tier 3 Set"]};
				{ 17, "T1T2Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "=q5="..AL["Tier 1/2 Set"]};
				{ 18, "T3Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], "=q5="..AL["Tier 3 Set"]};
				{ 20, "T1T2Paladin", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Tier 1/2 Set"]};
				{ 21, "T3Paladin", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..AL["Tier 3 Set"]};
				{ 23, "T1T2Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "=q5="..AL["Tier 1/2 Set"]};
				{ 24, "T3Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], "=q5="..AL["Tier 3 Set"]};
				{ 26, "T1T2Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=q5="..AL["Tier 1/2 Set"]};
				{ 27, "T3Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=q5="..AL["Tier 3 Set"]};
			};
		};
		info = {
			name = AL["Tier 1/2/3 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T456SET"] = {
		["Normal"] = {
			{
				{ 3, "T456DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 4, "T456DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 5, "T456DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 7, "T456Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 9, "T456Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 11, "T456PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 12, "T456PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 13, "T456PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "T456PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T456PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T456Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "T456ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "T456ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "T456ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "T456Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "T456WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 29, "T456WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 4/5/6 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T7T8SET"] = {
		["Normal"] = {
			{
				{ 2, "NaxxDeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 3, "NaxxDeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 5, "NaxxDruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 6, "NaxxDruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 7, "NaxxDruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 9, "NaxxHunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 11, "NaxxMage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 13, "NaxxPaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 14, "NaxxPaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 15, "NaxxPaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "NaxxPriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "NaxxPriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "NaxxRogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "NaxxShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "NaxxShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "NaxxShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "NaxxWarlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "NaxxWarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 29, "NaxxWarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 7/8 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T9SET"] = {
		["Normal"] = {
			{
				{ 2, "T9DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 3, "T9DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 5, "T9DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 6, "T9DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 7, "T9DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 9, "T9Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 11, "T9Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 13, "T9PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 14, "T9PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 15, "T9PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "T9PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T9PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T9Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "T9ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "T9ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "T9ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "T9Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "T9WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 29, "T9WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 9 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T10SET"] = {
		["Normal"] = {
			{
				{ 2, "T10DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 3, "T10DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 5, "T10DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 6, "T10DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 7, "T10DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 9, "T10Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 11, "T10Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 13, "T10PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 14, "T10PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 15, "T10PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "T10PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T10PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T10Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "T10ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "T10ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "T10ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "T10Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "T10WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 29, "T10WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 10 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T1112SET"] = {
		["Normal"] = {
			{
				{ 2, "T1112DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 3, "T1112DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 5, "T1112DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 6, "T1112DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 7, "T1112DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 9, "T1112Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 11, "T1112Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 13, "T1112PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 14, "T1112PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 15, "T1112PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "T1112PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T1112PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T1112Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "T1112ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "T1112ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "T1112ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "T1112Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "T1112WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 29, "T1112WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 11/12 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T13SET"] = {
		["Normal"] = {
			{
				{ 2, "T13DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 3, "T13DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 5, "T13DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 6, "T13DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 7, "T13DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 9, "T13Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 11, "T13Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 13, "T13PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 14, "T13PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 15, "T13PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "T13PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T13PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T13Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "T13ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "T13ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "T13ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "T13Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "T13WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 29, "T13WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 13 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T14SET"] = {
		["Normal"] = {
			{
				{ 1, "T14Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 2, "T14Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 3, "T14Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 4, "T14Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 6, "T14MonkTank", "spell_monk_brewmaster_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Brewmaster"]};
				{ 7, "T14MonkHealer", "spell_monk_mistweaver_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 8, "T14MonkDPS", "spell_monk_windwalker_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 10, "T14ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 11, "T14ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 12, "T14ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 14, "T14DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 15, "T14DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 17, "T14PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T14PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T14DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 21, "T14DruidDPS", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 22, "T14DruidTank", "ability_racial_bearform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Guardian"]};
				{ 23, "T14DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, "T14PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 26, "T14PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 27, "T14PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 29, "T14WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 30, "T14WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 14 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T15SET"] = {
		["Normal"] = {
			{
				{ 1, "T15Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 2, "T15Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 3, "T15Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 4, "T15Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 6, "T15MonkTank", "spell_monk_brewmaster_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Brewmaster"]};
				{ 7, "T15MonkHealer", "spell_monk_mistweaver_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 8, "T15MonkDPS", "spell_monk_windwalker_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 10, "T15ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 11, "T15ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 12, "T15ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 14, "T15DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 15, "T15DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 17, "T15PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T15PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T15DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 21, "T15DruidDPS", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 22, "T15DruidTank", "ability_racial_bearform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Guardian"]};
				{ 23, "T15DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, "T15PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 26, "T15PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 27, "T15PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 29, "T15WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 30, "T15WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 15 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["T16SET"] = {
		["Normal"] = {
			{
				{ 1, "T16Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 2, "T16Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 3, "T16Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 4, "T16Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 6, "T16MonkTank", "spell_monk_brewmaster_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Brewmaster"]};
				{ 7, "T16MonkHealer", "spell_monk_mistweaver_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 8, "T16MonkDPS", "spell_monk_windwalker_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 10, "T16ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 11, "T16ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 12, "T16ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 14, "T16DeathKnightDPS", "spell_deathknight_frostpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["DPS"]};
				{ 15, "T16DeathKnightTank", "spell_deathknight_bloodpresence", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], "=q5="..AL["Tanking"]};
				{ 17, "T16PriestHoly", "spell_holy_guardianspirit", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Holy"]};
				{ 18, "T16PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "T16DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 21, "T16DruidDPS", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 22, "T16DruidTank", "ability_racial_bearform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Guardian"]};
				{ 23, "T16DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 25, "T16PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 26, "T16PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 27, "T16PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 29, "T16WarriorFury", "ability_warrior_innerrage", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..AL["DPS"]};
				{ 30, "T16WarriorProtection", "ability_warrior_defensivestance", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], "=q5="..ALIL["Protection"]};
			};
		};
		info = {
			name = AL["Tier 16 Set"],
			menu = "SETMENU", instance = "TierSetsMenus",
		};
	}

	AtlasLoot_Data["ARCHAVON"] = {
		["Normal"] = {
			{
				{ 2, "VoAArchavon", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "VoAArchavon#2", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "VoAArchavon#3", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "VoAArchavon#3", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "VoAArchavon#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m7#", "", ""};
				{ 17, "VoAArchavon#5", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "VoAArchavon#3", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "VoAArchavon#6", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "VoAArchavon#7", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "VoAArchavon#7", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m6#", "", ""};
			};
		};
		info = {
			name = BabbleBoss["Archavon the Stone Watcher"],
		};
	}

	AtlasLoot_Data["EMALON"] = {
		["Normal"] = {
			{
				{ 2, "VoAEmalon#5", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "VoAEmalon#2", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "VoAEmalon", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "VoAEmalon#3", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "VoAEmalon#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, "VoAEmalon#6", "INV_Boots_Cloth_12", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
				{ 9, "VoAEmalon#7", "INV_Boots_Plate_06", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
				{ 10, "VoAEmalon#8", "inv_misc_cape_19", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Misc"]};
				{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m7#", "", ""};
				{ 17, "VoAEmalon", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "VoAEmalon#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "VoAEmalon#3", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "VoAEmalon", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "VoAEmalon#5", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, "VoAEmalon#6", "INV_Boots_08", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
				{ 24, "VoAEmalon#7", "INV_Boots_Plate_04", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
				{ 27, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m6#", "", ""};
			};
		};
		info = {
			name = BabbleBoss["Emalon the Storm Watcher"],
		};
	}

	AtlasLoot_Data["KORALON"] = {
		["Normal"] = {
			{
				{ 2, "VoAKoralon#5", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "VoAKoralon#2", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "VoAKoralon", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "VoAKoralon#3", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "VoAKoralon#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, "VoAKoralon#6", "INV_Boots_Cloth_12", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
				{ 9, "VoAKoralon#7", "INV_Boots_Plate_06", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
				{ 10, "VoAKoralon#8", "inv_misc_cape_19", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Misc"]};
				{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m7#", "", ""};
				{ 17, "VoAKoralon", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "VoAKoralon#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "VoAKoralon#3", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "VoAKoralon", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "VoAKoralon#5", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, "VoAKoralon#6", "INV_Boots_08", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
				{ 24, "VoAKoralon#7", "INV_Boots_Plate_04", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
				{ 27, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m6#", "", ""};
			};
		};
		info = {
			name = BabbleBoss["Koralon the Flame Watcher"],
		};
	}

	AtlasLoot_Data["TORAVON"] = {
		["Normal"] = {
			{
				{ 2, "VoAToravon#5", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "VoAToravon#2", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "VoAToravon", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "VoAToravon#3", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "VoAToravon#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, "VoAToravon#6", "INV_Boots_Cloth_12", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"]};
				{ 9, "VoAToravon#7", "INV_Boots_Plate_06", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"]};
				{ 10, "VoAToravon#8", "inv_misc_cape_19", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Misc"]};
				{ 12, 43959, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m7#", "", ""};
				{ 17, "VoAToravon", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "VoAToravon#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "VoAToravon#3", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "VoAToravon", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "VoAToravon#5", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, "VoAToravon#6", "INV_Boots_08", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Leather"]};
				{ 24, "VoAToravon#7", "INV_Boots_Plate_04", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Plate"]};
				{ 27, 44083, "", "=q4=Reins of the Grand Black War Mammoth", "=ds=#e26# =ec1=#m6#", "", ""};
			};
		};
		info = {
			name = BabbleBoss["Toravon the Ice Watcher"],
		};
	}

	AtlasLoot_Data["ARGALOTH"] = {
		["Normal"] = {
			{
				{ 2, "BHArgaloth#6", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "BHArgaloth", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "BHArgaloth#2", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "BHArgaloth#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "BHArgaloth#3", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, "BHArgaloth#7", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"]};
				{ 9, "BHArgaloth#9", "inv_jewelry_ring_80", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 85"]};
				{ 17, "BHArgaloth#4", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "BHArgaloth#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "BHArgaloth#5", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "BHArgaloth#2", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "BHArgaloth#6", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, "BHArgaloth#8", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]};
				{ 24, "BHArgaloth#10", "inv_misc_token_argentdawn3", "=ds="..AL["PvP Trinkets"], "=q5="..AL["Level 85"]};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Argaloth", 139),
		};
	}

	AtlasLoot_Data["OCCUTHAR"] = {
		["Normal"] = {
			{
				{ 2, "BHOccuthar#6", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "BHOccuthar", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "BHOccuthar#2", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "BHOccuthar#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "BHOccuthar#3", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, "BHOccuthar#7", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"]};
				{ 9, "BHOccuthar#9", "inv_jewelry_ring_80", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 85"]};
				{ 17, "BHOccuthar#4", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "BHOccuthar#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "BHOccuthar#5", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "BHOccuthar#2", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "BHOccuthar#6", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, "BHOccuthar#8", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]};
				{ 24, "BHOccuthar#10", "inv_misc_token_argentdawn3", "=ds="..AL["PvP Trinkets"], "=q5="..AL["Level 85"]};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Occu'thar", 140),
		};
	}

	AtlasLoot_Data["ALIZABAL"] = {
		["Normal"] = {
			{
				{ 2, "BHAlizabal#6", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "BHAlizabal", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "BHAlizabal#2", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "BHAlizabal#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 6, "BHAlizabal#3", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 8, "BHAlizabal#7", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"]};
				{ 9, "BHAlizabal#9", "inv_jewelry_ring_80", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 85"]};
				{ 17, "BHAlizabal#4", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "BHAlizabal#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "BHAlizabal#5", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "BHAlizabal#2", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "BHAlizabal#6", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 23, "BHAlizabal#8", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]};
				{ 24, "BHAlizabal#10", "inv_misc_token_argentdawn3", "=ds="..AL["PvP Trinkets"], "=q5="..AL["Level 85"]};
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Alizabal, Mistress of Hate", 339),
		};
	}

	AtlasLoot_Data["SHAOFANGER"] = {
		["Normal"] = {
			{
				{ 2, "ShaofAnger#7", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "ShaofAnger", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "ShaofAnger#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 5, "ShaofAnger#2", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, "ShaofAnger#3", "class_monk", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], ""};
				{ 7, "ShaofAnger#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 9, "ShaofAnger#8", "inv_bracer_robe_pvpmage_e_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"]};
				{ 10, "ShaofAnger#10", "inv_misc_pvp_ringc2", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 90"]};
				{ 12, 87771, "", "=q4=Reins of the Heavenly Onyx Cloud Serpent", "=ds=#e27#" },
				{ 17, "ShaofAnger#5", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "ShaofAnger#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "ShaofAnger#6", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "ShaofAnger#2", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "ShaofAnger#7", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 24, "ShaofAnger#9", "inv_bracer_plate_pvppaladin_e_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]};
				{ 25, "ShaofAnger#11", "inv_hand_1h_shaclaw", "=ds="..AL["Quest Reward"], ""};
				{ 27, 90839, "", "=q4=Cache of Sha-Touched Gold", "=ds=#m20#"  },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Sha of Anger", 691),
		};
	}

	AtlasLoot_Data["NALAK"] = {
		["Normal"] = {
			{
				{ 2, "Nalak#7", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "Nalak", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "Nalak#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 5, "Nalak#2", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, "Nalak#3", "class_monk", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], ""};
				{ 7, "Nalak#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 9, "Nalak#8", "inv_bracer_robe_pvpmage_e_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"]};
				{ 10, "Nalak#10", "inv_misc_pvp_ringc2", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 90"]};
				{ 12, 95057, "", "=q4=Reins of the Thundering Cobalt Cloud Serpent", "=ds=#e27#" },
				{ 17, "Nalak#5", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "Nalak#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "Nalak#6", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "Nalak#2", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "Nalak#7", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 24, "Nalak#9", "inv_bracer_plate_pvppaladin_e_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]};
				{ 27, 95602, "", "=q4=Stormtouched Cache", "=ds=#m20#"  },
			};
		};
		info = {
			name = AtlasLoot:EJ_GetBossName("Nalak, The Storm Lord", 814),
		};
	}

	AtlasLoot_Data["AUGUSTCELESTIALSWORLDBOSSES"] = {
		["Normal"] = {
			{
				{ 2, "AugustCelestialsWorldBosses#7", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "AugustCelestialsWorldBosses", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "AugustCelestialsWorldBosses#2", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 5, "AugustCelestialsWorldBosses#2", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 6, "AugustCelestialsWorldBosses#3", "class_monk", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], ""};
				{ 7, "AugustCelestialsWorldBosses#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 9, "AugustCelestialsWorldBosses#8", "inv_belt_leather_pvprogue_g_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Cloth"].." / "..BabbleInventory["Leather"]};
				{ 10, "AugustCelestialsWorldBosses#10", "inv_misc_pvp_ringc2", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 90"]};
				{ 17, "AugustCelestialsWorldBosses#5", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 18, "AugustCelestialsWorldBosses#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 19, "AugustCelestialsWorldBosses#6", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 20, "AugustCelestialsWorldBosses#2", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 21, "AugustCelestialsWorldBosses#7", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 24, "AugustCelestialsWorldBosses#9", "inv_boots_mail_pvphunter_g_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..BabbleInventory["Mail"].." / "..BabbleInventory["Plate"]};
				{ 27, 104272, "", "=q4=Celestial Treasure Box", "=ds=#m20#"  },
			};
		};
		info = {
			name = ALIL["The August Celestials"],
		};
	}