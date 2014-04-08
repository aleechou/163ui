-- $Id: PvPMenus.lua 4232 2013-08-12 08:52:37Z dynaletik $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")

	AtlasLoot_Data["PVPMENU"] = {
		["Normal"] = {
			{
				{ 2, "PVP90Accessories", "inv_misc_pvp_ringc2", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 90"]};
				{ 3, "PVP90SET", "inv_helm_plate_pvppaladin_g_01", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 90"]};
				{ 6, "PVP90NonSetCloth", "inv_cloth_pvpwarlock_g_01boot", "=ds="..AL["PvP Non-Set Epics"]..": "..BabbleInventory["Cloth"], "=q5="..AL["Level 90"]};
				{ 7, "PVP90NonSetLeather", "inv_belt_leather_pvprogue_g_01", "=ds="..AL["PvP Non-Set Epics"]..": "..BabbleInventory["Leather"], "=q5="..AL["Level 90"]};	
				{ 9, "PVPMENU2", "INV_Jewelry_Necklace_21", "=ds="..AL["BG/Open PvP Rewards"], ""};
				{ 17, "PVP90WeaponsGrievousElite", "inv_staff_2h_pvppandarias3_c_01", "=ds="..AL["PvP Weapons"].." - "..string.format(AL["ilvl %d"], 522), "=q5="..AL["Level 90"].." - "..AL["Elite"]};
				{ 18, "PVP90WeaponsGrievous", "inv_hand_1h_pvppandarias3_c_01", "=ds="..AL["PvP Weapons"].." - "..string.format(AL["ilvl %d"], 522), "=q5="..AL["Level 90"]};
				{ 19, "PVP90Weapons", "inv_hand_1h_pvppandarias2_c_01", "=ds="..AL["PvP Weapons"].." - "..string.format(AL["ilvl %d"], 498), "=q5="..AL["Level 90"]};
				{ 21, "PVP90NonSetMail", "inv_boots_mail_pvphunter_g_01", "=ds="..AL["PvP Non-Set Epics"]..": "..BabbleInventory["Mail"], "=q5="..AL["Level 90"]};
				{ 22, "PVP90NonSetPlate", "inv_boot_plate_pvppaladin_g_01", "=ds="..AL["PvP Non-Set Epics"]..": "..BabbleInventory["Plate"], "=q5="..AL["Level 90"]};
				{ 24, "PVPMENU3", "inv_belt_13", "=ds="..AL["Old PvP Rewards"], "=q5="};
			};
		};
		info = {
			name = AL["PvP Rewards"],
		};
	}

	AtlasLoot_Data["PVPMENU2"] = {
		["Normal"] = {
			{
				{ 2, "ABMisc", "INV_Jewelry_Amulet_07", "=ds="..AL["Misc. Rewards"], "=q5="..ALIL["Arathi Basin"]};
				{ 3, "ABSets", "INV_Jewelry_Amulet_07", "=ds="..AL["Arathi Basin Sets"], ""};
				{ 5, "WSGMisc", "INV_Misc_Rune_07", "=ds="..AL["Misc. Rewards"], "=q5="..ALIL["Warsong Gulch"]};
				{ 6, "WSGAccessories", "INV_Misc_Rune_07", "=ds="..AL["Accessories"], "=q5="..ALIL["Warsong Gulch"]};
				{ 8, "AVMisc", "INV_Jewelry_Necklace_21", "=ds="..ALIL["Alterac Valley"], ""};
				{ 10, "Hellfire", "INV_Misc_Token_HonorHold", "=ds="..ALIL["Hellfire Peninsula"], "=q5="..AL["Hellfire Fortifications"]};
				{ 11, "Zangarmarsh", "Spell_Nature_ElementalPrecision_1", "=ds="..ALIL["Zangarmarsh"], "=q5="..AL["Twin Spire Ruins"]};
				{ 13, "WINTERGRASPMENU", "INV_Misc_Platnumdisks", "=ds="..ALIL["Wintergrasp"], ""};
				{ 17, "AB4049", "INV_Jewelry_Amulet_07", "=ds="..string.format(AL["Level %s Rewards"], "40-49"), "=q5="..ALIL["Arathi Basin"]};
				{ 18, "AB2039", "INV_Jewelry_Amulet_07", "=ds="..string.format(AL["Level %s Rewards"], "20-39"), "=q5="..ALIL["Arathi Basin"]};
				{ 20, "WSGWeapons", "INV_Misc_Rune_07", "=ds="..AL["Weapons"], "=q5="..ALIL["Warsong Gulch"]};
				{ 21, "WSGArmor", "INV_Misc_Rune_07", "=ds="..BabbleInventory["Armor"], "=q5="..ALIL["Warsong Gulch"]};
				{ 25, "Terokkar", "INV_Jewelry_FrostwolfTrinket_04", "=ds="..ALIL["Terokkar Forest"], "=q5="..AL["Spirit Towers"]};
				{ 26, "Nagrand", "INV_Misc_Rune_09", "=ds="..ALIL["Nagrand"], "=q5="..AL["Halaa"]};
				{ 28, "VentureBay", "INV_Misc_Coin_16", "=ds="..ALIL["Grizzly Hills"], "=q5="..AL["Venture Bay"]};
			};
		};
		info = {
			name = AL["PvP Rewards"],
			menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVPMENU3"] = {
		["Normal"] = {
			{
				{ 2, "PVP85Accessories", "inv_jewelry_ring_80", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 85"]};
				{ 3, "PVP85SET", "inv_helm_plate_pvppaladin_c_01", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 85"]};
				{ 4, "PVP85Misc", "ability_warrior_rampage", "=ds="..AL["Misc"], "=q5="..AL["Level 85"]};
				{ 6, "PVP80Accessories", "INV_Jewelry_Necklace_36", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 80"]};
				{ 7, "PVP80SET", "INV_Boots_01", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 80"]};
				{ 9, "PVP70Accessories", "inv_jewelry_ring_60", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 70"]};
				{ 10, "PVP70RepSET", "INV_Axe_02", "=ds="..AL["PvP Reputation Sets"], "=q5="..AL["Level 70"]};
				{ 11, "PVP70GladiatorWeapons", "inv_weapon_hand_13", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 70"].." - "..AL["Gladiator"]};
				{ 12, "PVP70VengefulWeapons", "inv_weapon_shortblade_62", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 70"].." - "..AL["Vengeful"]};
				{ 14, "PVP60Accessories", "inv_jewelry_trinketpvp_01", "=ds="..AL["PvP Accessories"], "=q5="..AL["Level 60"]};
				{ 15, "PVP60SET", "INV_Axe_02", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 60"]};
				{ 17, "PVP85NonSet", "inv_bracer_mail_pvphunter_c_01", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Level 85"]};
				{ 18, "PVP85Weapons4", "inv_hand_1h_pvp400_c_01", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 85"].." - "..AL["Cataclysmic"]};
				{ 21, "PVP80NONSETEPICS", "inv_bracer_51", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Level 80"]};
				{ 22, "PVP80Weapons", "INV_Sword_86", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 80"].." - "..AL["Wrathful"]};
				{ 24, "PVP70NonSet", "inv_belt_13", "=ds="..AL["PvP Non-Set Epics"], "=q5="..AL["Level 70"]};
				{ 25, "PVP70SET", "inv_gauntlets_29", "=ds="..AL["PvP Armor Sets"], "=q5="..AL["Level 70"]};
				{ 26, "PVP70MercilessWeapons", "inv_staff_53", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 70"].." - "..AL["Merciless"]};
				{ 27, "PVP70BrutalWeapons", "INV_Weapon_Crossbow_10", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 70"].." - "..AL["Brutal"]};
				{ 29, "PVP60Weapons", "INV_Weapon_Bow_08", "=ds="..AL["PvP Weapons"], "=q5="..AL["Level 60"].." - "..AL["Grand Marshal"]};
			};
		};
		info = {
			name = AL["PvP Rewards"],
			menu = "PVPMENU",
		};
	}

	AtlasLoot_Data["PVP60SET"] = {
		["Normal"] = {
			{
				{ 3, "PVP60Druid", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "PVP60Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "PVP60Priest", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 6, "PVP60Shaman", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 7, "PVP60Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 18, "PVP60Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 19, "PVP60Paladin", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 20, "PVP60Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 21, "PVP60Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
			};
		};
		info = {
			name = AL["PvP Armor Sets"]..": "..AL["Level 60"],
			menu = "PVPMENU3",
		};
	}

	AtlasLoot_Data["PVP70SET"] = {
		["Normal"] = {
			{
				{ 2, "PVP70DeathKnight", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 4, "PVP70DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 5, "PVP70DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 6, "PVP70DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};		
				{ 8, "PVP70Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};		
				{ 10, "PVP70Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};		
				{ 12, "PVP70PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 13, "PVP70PaladinProtection", "spell_holy_devotionaura", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Protection"]};
				{ 14, "PVP70PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};		
				{ 17, "PVP70PriestHoly", "spell_holy_powerwordshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Discipline"]};
				{ 18, "PVP70PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};		
				{ 20, "PVP70Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};		
				{ 22, "PVP70ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "PVP70ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "PVP70ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};	
				{ 26, "PVP70WarlockDemonology", "spell_shadow_deathcoil", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=q5="..ALIL["Demonology"]};
				{ 27, "PVP70WarlockDestruction", "spell_shadow_rainoffire", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], "=q5="..ALIL["Destruction"]};
				{ 29, "PVP70Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
			};
		};
		info = {
			name = AL["PvP Armor Sets"]..": "..AL["Level 70"],
			menu = "PVPMENU3",
		};
	}
	
	AtlasLoot_Data["PVP70RepSET"] = {
		["Normal"] = {
			{
				{ 3, "PVP70Rep#2", "ability_druid_maul", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], ""};
				{ 4, "PVP70Rep", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 5, "PVP70Rep", "inv_staff_30", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], ""};
				{ 6, "PVP70Rep#3", "spell_nature_bloodlust", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], ""};
				{ 7, "PVP70Rep#4", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
				{ 18, "PVP70Rep#3", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 19, "PVP70Rep#4", "ability_thunderbolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], ""};
				{ 20, "PVP70Rep#2", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 21, "PVP70Rep", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
			};
		};
		info = {
			name = AL["PvP Reputation Sets"]..": "..AL["Level 70"],
			menu = "PVPMENU3",
		};
	}

	AtlasLoot_Data["PVP80NONSETEPICS"] = {
		["Normal"] = {
			{
				{ 2, "PVP80NonSet#1", "INV_Boots_Cloth_12", "=ds="..BabbleInventory["Cloth"], ""};
				{ 3, "PVP80NonSet#3", "INV_Boots_Plate_06", "=ds="..BabbleInventory["Mail"], ""};
				{ 17, "PVP80NonSet#2", "INV_Boots_08", "=ds="..BabbleInventory["Leather"], ""};
				{ 18, "PVP80NonSet#4", "INV_Boots_Plate_04", "=ds="..BabbleInventory["Plate"], ""};
			};
		};
		info = {
			name = AL["PvP Non-Set Epics"],
			menu = "PVPMENU3",
		};
	}

	AtlasLoot_Data["PVP80SET"] = {
		["Normal"] = {
			{
				{ 2, "PVP80DeathKnight", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 4, "PVP80DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 5, "PVP80DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 6, "PVP80DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 8, "PVP80Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 10, "PVP80Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 12, "PVP80PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 13, "PVP80PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "PVP80PriestHoly", "spell_holy_powerwordshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Discipline"]};
				{ 18, "PVP80PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "PVP80Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "PVP80ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "PVP80ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "PVP80ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "PVP80Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "PVP80Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
			};
		};
		info = {
			name = AL["PvP Armor Sets"]..": "..AL["Level 80"],
			menu = "PVPMENU3",
		};
	}

	AtlasLoot_Data["PVP85SET"] = {
		["Normal"] = {
			{
				{ 2, "PVP85DeathKnight", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 4, "PVP85DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 5, "PVP85DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 6, "PVP85DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 8, "PVP85Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 10, "PVP85Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 12, "PVP85PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 13, "PVP85PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "PVP85PriestHoly", "spell_holy_powerwordshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 18, "PVP85PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"]};
				{ 20, "PVP85Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "PVP85ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "PVP85ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "PVP85ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "PVP85Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "PVP85Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
			};
		};
		info = {
			name = AL["PvP Armor Sets"]..": "..AL["Level 85"],
			menu = "PVPMENU3",
		};
	}

	AtlasLoot_Data["WINTERGRASPMENU"] = {
		["Normal"] = {
			{
				{ 2, "LakeWintergrasp#2", "inv_helmet_136", "=ds="..BabbleInventory["Cloth"], ""};
				{ 3, "LakeWintergrasp#3", "INV_Helmet_141", "=ds="..BabbleInventory["Leather"], ""};
				{ 4, "LakeWintergrasp#4", "INV_Helmet_138", "=ds="..BabbleInventory["Mail"], ""};
				{ 5, "LakeWintergrasp#5", "inv_helmet_134", "=ds="..BabbleInventory["Plate"], ""};
				{ 17, "LakeWintergrasp", "inv_misc_rune_11", "=ds="..AL["Accessories"], ""};
				{ 18, "LakeWintergrasp#6", "inv_jewelcrafting_icediamond_02", "=ds="..AL["PVP Gems/Enchants/Jewelcrafting Designs"], ""};
			};
		};
		info = {
			name = ALIL["Wintergrasp"],
			menu = "PVPMENU2",
		};
	}
	
	AtlasLoot_Data["PVP90SET"] = {
		["Normal"] = {
			{
				{ 1, "PVP90DeathKnight", "spell_deathknight_classicon", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"], ""};
				{ 3, "PVP90DruidBalance", "spell_nature_starfall", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Balance"]};
				{ 4, "PVP90DruidFeral", "ability_druid_catform", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Feral"]};
				{ 5, "PVP90DruidRestoration", "spell_nature_healingtouch", "=ds="..LOCALIZED_CLASS_NAMES_MALE["DRUID"], "=q5="..ALIL["Restoration"]};
				{ 7, "PVP90Hunter", "inv_weapon_bow_07", "=ds="..LOCALIZED_CLASS_NAMES_MALE["HUNTER"], ""};
				{ 9, "PVP90Mage", "inv_staff_13", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MAGE"], ""};
				{ 11, "PVP90MonkHealer", "spell_monk_mistweaver_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Mistweaver"]};
				{ 12, "PVP90MonkDPS", "spell_monk_windwalker_spec", "=ds="..LOCALIZED_CLASS_NAMES_MALE["MONK"], "=q5="..ALIL["Windwalker"]};
				{ 14, "PVP90PaladinHoly", "Spell_Holy_HolyBolt", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Holy"]};
				{ 15, "PVP90PaladinRetribution", "Spell_Holy_AuraOfLight", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PALADIN"], "=q5="..ALIL["Retribution"]};
				{ 17, "PVP90PriestHoly", "spell_holy_powerwordshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Discipline"]};
				{ 18, "PVP90PriestShadow", "spell_shadow_shadowwordpain", "=ds="..LOCALIZED_CLASS_NAMES_MALE["PRIEST"], "=q5="..ALIL["Shadow"]};
				{ 20, "PVP90Rogue", "inv_throwingknife_04", "=ds="..LOCALIZED_CLASS_NAMES_MALE["ROGUE"], ""};
				{ 22, "PVP90ShamanElemental", "Spell_Nature_Lightning", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Elemental"]};
				{ 23, "PVP90ShamanEnhancement", "spell_nature_lightningshield", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Enhancement"]};
				{ 24, "PVP90ShamanRestoration", "spell_nature_magicimmunity", "=ds="..LOCALIZED_CLASS_NAMES_MALE["SHAMAN"], "=q5="..ALIL["Restoration"]};
				{ 26, "PVP90Warlock", "spell_nature_drowsy", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARLOCK"], ""};
				{ 28, "PVP90Warrior", "inv_sword_27", "=ds="..LOCALIZED_CLASS_NAMES_MALE["WARRIOR"], ""};
			};
		};
		info = {
			name = AL["PvP Armor Sets"]..": "..AL["Level 90"],
			menu = "PVPMENU",
		};
	}