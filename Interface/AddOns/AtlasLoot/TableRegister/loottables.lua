-- $Id: loottables.lua 4257 2013-09-13 10:44:24Z lag123 $
--[[
loottables.en.lua
This file assigns a title to every loot table.  The primary use of this table
is in the search function, as when iterating through the loot tables there is no
inherant title to the loot table, given the origins of the mod as an Atlas plugin.
]]

-- Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")

-- Using alchemy skill to get localized rank
local JOURNEYMAN = select(2, GetSpellInfo(3101));
local EXPERT = select(2, GetSpellInfo(3464));
local ARTISAN = select(2, GetSpellInfo(11611));
local MASTER = select(2, GetSpellInfo(28596));

local ALCHEMY, APPRENTICE = GetSpellInfo(2259);
local BLACKSMITHING = GetSpellInfo(2018);
local ARMORSMITH = GetSpellInfo(9788);
local WEAPONSMITH = GetSpellInfo(9787);
local AXESMITH = GetSpellInfo(17041);
local HAMMERSMITH = GetSpellInfo(17040);
local SWORDSMITH = GetSpellInfo(17039);
local COOKING = GetSpellInfo(2550);
local ENCHANTING = GetSpellInfo(7411);
local ENGINEERING = GetSpellInfo(4036);
local GNOMISH = GetSpellInfo(20220);
local GOBLIN = GetSpellInfo(20221);
local FIRSTAID = GetSpellInfo(3273);
local FISHING = GetSpellInfo(63275);
local INSCRIPTION = GetSpellInfo(45357);
local JEWELCRAFTING = GetSpellInfo(25229);
local LEATHERWORKING = GetSpellInfo(2108);
local DRAGONSCALE = GetSpellInfo(10656);
local ELEMENTAL = GetSpellInfo(10658);
local TRIBAL = GetSpellInfo(10660);
local MINING = GetSpellInfo(2575);
local TAILORING = GetSpellInfo(3908);
local MOONCLOTH = GetSpellInfo(26798);
local SHADOWEAVE = GetSpellInfo(26801);
local SPELLFIRE = GetSpellInfo(26797);

-- Index
--- Mists of Pandaria Instances
---- Dungeons
---- Raids
--- Cataclysm Instances
---- Dungeons
---- Raids
--- Wrath of the Lich King Instances
---- Dungeons
---- Raids
--- Burning Crusade Instances
---- Dungeons
---- Raids
--- Classic Instances
---- Dungeons
---- Raids
--- Battlegrounds
--- World Bosses
--- World Events
--- Crafting
--- Collections
---

AtlasLoot_LootTableRegister = {
	["Instances"] = {

	-----------------------------------
	--- Mists of Pandaria Instances ---
	-----------------------------------

		----------------
		--- Dungeons ---
		----------------

		["TempleOfTheJadeSerpent"] = {
			["Bosses"] = {
				{ "TJSMari", 2, EncounterJournalID = 672 },
				{ "TJSStonestep", 3, EncounterJournalID = 664 },
				{ "TJSFlameheart", 4, EncounterJournalID = 658 },
				{ "TJSShaDoubt", 5, EncounterJournalID = 335 },
			},
			["Info"] = { ALIL["Temple of the Jade Serpent"], "AtlasLootMoP", mapname = "EastTemple", EncounterJournalID = 313 },
		},

		["StormstoutBrewery"] = {
			["Bosses"] = {
				{ "BreweryOokOok", 3, EncounterJournalID = 668 },
				{ "BreweryHoptallus", 4, EncounterJournalID = 669 },
				{ "BreweryYanZhu", 5, EncounterJournalID = 670 },
			},
			["Info"] = { ALIL["Stormstout Brewery"], "AtlasLootMoP", mapname = "StormstoutBrewery", EncounterJournalID = 302 },
		},

		["MoguShanPalace"] = {
			["Bosses"] = {
				{ "MoguShanTrialKing", 3, EncounterJournalID = 708 },
				{ "MoguShanGekkan", 7, EncounterJournalID = 690 },
				{ "MoguShanXin", 8, EncounterJournalID = 698 },
			},
			["Info"] = { ALIL["Mogu'Shan Palace"], "AtlasLootMoP", mapname = "MogushanPalace", EncounterJournalID = 321 },
		},

		["ShadoPanMonasteryA"] = "ShadoPanMonastery",
		["ShadoPanMonasteryB"] = "ShadoPanMonastery",
		["ShadoPanMonastery"] = {
			["ShadoPanMonasteryA"] = {
				{ "ShadoPanCloudstrike", 2, EncounterJournalID = 673 },
				{ "ShadoPanTaranZhu", 4, EncounterJournalID = 686, hide = true },
			},
			["ShadoPanMonasteryB"] = {
				{ "ShadoPanSnowdrift", 3, EncounterJournalID = 657 },
				{ "ShadoPanShaViolence", 4, EncounterJournalID = 685 },
				{ "ShadoPanTaranZhu", EncounterJournalID = 686 },
			},
			["Info"] = { ALIL["Shado-pan Monastery"], "AtlasLootMoP", mapname = "ShadowpanHideout", sortOrder = { "ShadoPanMonasteryA", "ShadoPanMonasteryB" }, EncounterJournalID = 312 },
		},

		["GateoftheSettingSun"] = {
			["Bosses"] = {
				{ "GotSSKiptilak", 4, EncounterJournalID = 655 },
				{ "GotSSGadok", 5, EncounterJournalID = 675 },
				{ "GotSSRimok", 6, EncounterJournalID = 676 },
				{ "GotSSRaigonn", 7, EncounterJournalID = 649 },
			},
			["Info"] = { ALIL["Gate of the Setting Sun"], "AtlasLootMoP", mapname = "TheGreatWall", EncounterJournalID = 303 },
		},

		["SiegeofNiuzaoTempleA"] = "SiegeofNiuzaoTemple",
		["SiegeofNiuzaoTempleB"] = "SiegeofNiuzaoTemple",
		["SiegeofNiuzaoTemple"] = {
			["SiegeofNiuzaoTempleA"] = {
				{ "NTJinbak", 3, EncounterJournalID = 693 },
			},
			["SiegeofNiuzaoTempleB"] = {
				{ "NTVojak", 2, EncounterJournalID = 738 },
				{ "NTPavalak", 3, EncounterJournalID = 692 },
				{ "NTNeronok", 4, EncounterJournalID = 727 },
			},
			["Info"] = { ALIL["Siege of Niuzao Temple"], "AtlasLootMoP", mapname = "SiegeofNiuzaoTemple", sortOrder = { "SiegeofNiuzaoTempleA", "SiegeofNiuzaoTempleB" }, EncounterJournalID = 324 },
		},

		-------------
		--- Raids ---
		-------------

		["HeartofFear"] = {
			["Bosses"] = {
				{ "HoFZorlok", 3, EncounterJournalID = 745, BonusLootID = 132194 },
				{ "HoFTayak", 4, EncounterJournalID = 744, BonusLootID = 132195 },
				{ "HoFGaralon", 5, EncounterJournalID = 713, BonusLootID = 132196 },
				{ "HoFMeljarak", 6, EncounterJournalID = 741, BonusLootID = 132197 },
				{ "HoFUnsok", 7, EncounterJournalID = 737, BonusLootID = 132198 },
				{ "HoFShekzeer", 9, EncounterJournalID = 743, BonusLootID = 132199 },
				{ "HoFTrash", 11 },
				{ "Patternsilvl496", 12 },
			},
			["Info"] = { ALIL["Heart of Fear"], "AtlasLootMoP", mapname = "HeartofFear", raid = true, EncounterJournalID = 330 },
		},

		["MoguShanVaults"] = {
			["Bosses"] = {
				{ "MSVTheStoneGuard", 3, EncounterJournalID = 679, BonusLootID = 125144 },
				{ "MSVFeng", 8, EncounterJournalID = 689, BonusLootID = 132189 },
				{ "MSVGarajal", 9, EncounterJournalID = 682, BonusLootID = 132190 },
				{ "MSVSpiritKings", 10, EncounterJournalID = 687, BonusLootID = 132191 },
				{ "MSVElegon", 15, EncounterJournalID = 726, BonusLootID = 132192 },
				{ "MSVWilloftheEmperor", 16, EncounterJournalID = 677, BonusLootID = 132193 },
				{ "MoguShanVaultsTrash", 20 },
				{ "Patternsilvl496", 21 },
			},
			["Info"] = { ALIL["Mogu'shan Vaults"], "AtlasLootMoP", mapname = "MoguShanVaults", raid = true, EncounterJournalID = 317 },
		},

		["Pandaria"] = {
			["Bosses"] = {
				{ "AUGUSTCELESTIALSWORLDBOSSES", 8, EncounterJournalID = 857, BonusLootID = 1 },
				{ "Ordos", 7, EncounterJournalID = 861, BonusLootID = 1 },
				{ "NALAK", 1, EncounterJournalID = 814, BonusLootID = 136381 },
				{ "Oondasta", 2, EncounterJournalID = 826, BonusLootID = 137554 },
				{ "SHAOFANGER", 3, EncounterJournalID = 691, BonusLootID = 132205 },
				{ "SalyisWarband", 4, EncounterJournalID = 725, BonusLootID = 132206 },
			},
			["Info"] = { AL["Pandaria World Bosses"], "AtlasLootMoP", mapname = "Pandaria", raid = true, EncounterJournalID = 322 },
		},

		["SiegeofOrgrimmarA"] = "SiegeofOrgrimmar",
		["SiegeofOrgrimmarB"] = "SiegeofOrgrimmar",
		["SiegeofOrgrimmarC"] = "SiegeofOrgrimmar",
		["SiegeofOrgrimmarD"] = "SiegeofOrgrimmar",
		["SiegeofOrgrimmar"] = {
			["SiegeofOrgrimmarA"] = {
				{ "SoOImmerseus", 3, EncounterJournalID = 852, BonusLootID = 1 },
				{ "SoOFallenProtectors", EncounterJournalID = 849, BonusLootID = 1 },
				{ "SoONorushen", 4, EncounterJournalID = 866, BonusLootID = 1 },
				{ "SoOShaofPride", 6, EncounterJournalID = 867, BonusLootID = 1 },
				{ "SoOShared", 8, hide = true, BonusLootID = 1 },
				{ "SoOTrash", 9, hide = true, BonusLootID = 1 },
			},
			["SiegeofOrgrimmarB"] = {
				{ "SoOFallenProtectors", 2, EncounterJournalID = 849, hide = true, BonusLootID = 1 },
				{ "SoOShared", 7, hide = true, BonusLootID = 1 },
				{ "SoOTrash", 8, hide = true, BonusLootID = 1 },
			},
			["SiegeofOrgrimmarC"] = {
				{ "SoOGalakras", 2, EncounterJournalID = 868, BonusLootID = 1 },
				{ "SoOIronJuggernaut", 3, EncounterJournalID = 864, BonusLootID = 1 },
				{ "SoODarkShaman", 4, EncounterJournalID = 856, BonusLootID = 1 },
				{ "SoOShared", 8, hide = true, BonusLootID = 1 },
				{ "SoOTrash", 9, hide = true, BonusLootID = 1 },
			},
			["SiegeofOrgrimmarD"] = {
				{ "SoONazgrim", 2, EncounterJournalID = 850, BonusLootID = 1 },
				{ "SoOMalkorok", 3, EncounterJournalID = 846, BonusLootID = 1 },
				{ "SoOSpoils", 4, EncounterJournalID = 870, BonusLootID = 1 },
				{ "SoOThok", 6, EncounterJournalID = 851, BonusLootID = 1 },
				{ "SoOBlackfuse", 8, EncounterJournalID = 865, BonusLootID = 1 },
				{ "SoOParagons", 9, EncounterJournalID = 853, BonusLootID = 1 },
				{ "SoOGarrosh", 19, EncounterJournalID = 869, BonusLootID = 1 },
				{ "SoOShared", 21, BonusLootID = 1 },
				{ "SoOTrash", 22, BonusLootID = 1 },
			},
			["Info"] = { ALIL["Siege of Orgrimmar"], "AtlasLootMoP", mapname = "SiegeofOrgrimmar", sortOrder = { "SiegeofOrgrimmarA", "SiegeofOrgrimmarB", "SiegeofOrgrimmarC", "SiegeofOrgrimmarD" }, raid = true, EncounterJournalID = 369 },
		},

		["TerraceofEndlessSpring"] = {
			["Bosses"] = {
				{ "ToESProtectors", 2, EncounterJournalID = 683, BonusLootID = 132200 },
				{ "ToESTsulong", 6, EncounterJournalID = 742, BonusLootID = 132201 },
				{ "ToESLeiShi", 7, EncounterJournalID = 729, BonusLootID = 132202 },
				{ "ToESShaofFear", 8, EncounterJournalID = 709, BonusLootID = 132203 },
				{ "Patternsilvl496", 10 },
			},
			["Info"] = { ALIL["Terrace of Endless Spring"], "AtlasLootMoP", mapname = "TerraceofEndlessSpring", raid = true, EncounterJournalID = 320 },
		},

		["ThroneofThunderA"] = "ThroneofThunder",
		["ThroneofThunderB"] = "ThroneofThunder",
		["ThroneofThunderC"] = "ThroneofThunder",
		["ThroneofThunderD"] = "ThroneofThunder",
		["ThroneofThunder"] = {
			["ThroneofThunderA"] = {
				{ "ShadoPanAssault", 1, hide = true},
				{ "ToTJinrokh", 4, EncounterJournalID = 827, BonusLootID = 139674 },
				{ "ToTHorridon", 5, EncounterJournalID = 819, BonusLootID = 139677 },
				{ "ToTCouncil", 6, EncounterJournalID = 816, BonusLootID = 139679 },
				{ "ToTShared", 14, hide = true },
				{ "ToTTrash", 15, hide = true },
			},
			["ThroneofThunderB"] = {
				{ "ShadoPanAssault", 1, hide = true},
				{ "ToTTortos", 3, EncounterJournalID = 825, BonusLootID = 139680 },
				{ "ToTMegaera", 4, EncounterJournalID = 821, BonusLootID = 139682 },
				{ "ToTJiKun", 5, EncounterJournalID = 828, BonusLootID = 139684 },
				{ "ToTShared", 8, hide = true },
				{ "ToTTrash", 9, hide = true },
			},
			["ThroneofThunderC"] = {
				{ "ShadoPanAssault", 1, hide = true},
				{ "ToTDurumu", 3, EncounterJournalID = 818, BonusLootID = 139686 },
				{ "ToTPrimordius", 6, EncounterJournalID = 820, BonusLootID = 139687 },
				{ "ToTDarkAnimus", 7, EncounterJournalID = 824, BonusLootID = 139688 },
				{ "ToTShared", 11, hide = true },
				{ "ToTTrash", 12, hide = true },
			},
			["ThroneofThunderD"] = {
				{ "ShadoPanAssault", 1, hide = true},
				{ "ToTIronQon", 3, EncounterJournalID = 817, BonusLootID = 139689 },
				{ "ToTTwinConsorts", 7, EncounterJournalID = 829, BonusLootID = 139690 },
				{ "ToTLeiShen", 10, EncounterJournalID = 832, BonusLootID = 139691 },
				{ "ToTRaden", 11, EncounterJournalID = 831, BonusLootID = 139692 },
				{ "ToTShared", 14 },
				{ "ToTTrash", 15 },
			},
			["Info"] = { ALIL["Throne of Thunder"], "AtlasLootMoP", mapname = "ThroneofThunder", sortOrder = { "ThroneofThunderA", "ThroneofThunderB", "ThroneofThunderC", "ThroneofThunderD" }, raid = true, EncounterJournalID = 362 },
		},

	---------------------------
	--- Cataclysm Instances ---
	---------------------------

		----------------
		--- Dungeons ---
		----------------

		["BlackrockCaverns"] = {
			["Bosses"] = {
				{ "BlackrockCavernsRomogg", 2, EncounterJournalID = 105 },
				{ "BlackrockCavernsCorla", 3, EncounterJournalID = 106 },
				{ "BlackrockCavernsSteelbender", 4, EncounterJournalID = 107 },
				{ "BlackrockCavernsBeauty", 5, EncounterJournalID = 108 },
				{ "BlackrockCavernsLordObsidius", 6, EncounterJournalID = 109 },
				{ "BlackrockCavernsTrash", 11 },
			},
			["Info"] = { ALIL["Blackrock Caverns"], "AtlasLootCataclysm", mapname = "BlackrockCaverns", EncounterJournalID = 66 },
		},

		["CoTEndTime"] = {
			["Bosses"] = {
				{ "EndtimeEchoes", {5,6,7,8}, EncounterJournalID = 340 },
				{ "EndtimeMurozond", 9, EncounterJournalID = 289 },
				{ "EndtimeTrash", 12 },
			},
			["Info"] = { ALIL["End Time"], "AtlasLootCataclysm", mapname = "EndTime", EncounterJournalID = 184 },
		},

		["CoTHourOfTwilight"] = {
			["Bosses"] = {
				{ "HoTArcurion", 4, EncounterJournalID = 322 },
				{ "HoTDawnslayer", 5, EncounterJournalID = 342 },
				{ "HoTBenedictus", 6, EncounterJournalID = 341 },
				{ "HoTTrash", 9 },
			},
			["Info"] = { ALIL["Hour of Twilight"], "AtlasLootCataclysm", mapname = "HourofTwilight", EncounterJournalID = 186 },
		},

		["CoTWellOfEternity"] = {
			["Bosses"] = {
				{ "WoEPerotharn", 5, EncounterJournalID = 290 },
				{ "WoEAzshara", 6, EncounterJournalID = 291 },
				{ "WoEMannoroth", 7, EncounterJournalID = 292 },
				{ "WoETrash", 12 },
			},
			["Info"] = { ALIL["Well of Eternity"], "AtlasLootCataclysm", mapname = "WellOfEternity", EncounterJournalID = 185 },
		},

		["GrimBatol"] = {
			["Bosses"] = {
				{ "GBUmbriss", 2, EncounterJournalID = 131 },
				{ "GBThrongus", 3, EncounterJournalID = 132 },
				{ "GBDrahga", 4, EncounterJournalID = 133 },
				{ "GBErudax", 5, EncounterJournalID = 134 },
				{ "GBTrash", 10 },
			},
			["Info"] = { ALIL["Grim Batol"], "AtlasLootCataclysm", mapname = "GrimBatol", EncounterJournalID = 71 },
		},

		["HallsOfOrigination"] = {
			["Bosses"] = {
				{ "HoOAnhuur", 2, EncounterJournalID = 124 },
				{ "HoOPtah", 3, EncounterJournalID = 125 },
				{ "HoOAnraphet", 4, EncounterJournalID = 126 },
				{ "HoOIsiset", 5, EncounterJournalID = 127 },
				{ "HoOAmmunae", 6, EncounterJournalID = 128 },
				{ "HoOSetesh", 7, EncounterJournalID = 129 },
				{ "HoORajh", 8, EncounterJournalID = 130 },
				{ "HoOTrash", 13 },
			},
			["Info"] = { ALIL["Halls of Origination"], "AtlasLootCataclysm", mapname = "HallsOfOrigination", EncounterJournalID = 70 },
		},

		["LostCityOfTolvir"] = {
			["Bosses"] = {
				{ "LostCityHusam", 3, EncounterJournalID = 117 },
				{ "LostCityLockmaw", {4,5}, EncounterJournalID = 118 },
				{ "LostCityBarim", 6, EncounterJournalID = 119 },
				{ "LostCitySiamat", 7, EncounterJournalID = 122 },
				{ "LostCityTrash", 10 },
			},
			["Info"] = { ALIL["Lost City of the Tol'vir"], "AtlasLootCataclysm", mapname = "LostCityofTolvir", EncounterJournalID = 69 },
		},

		["TheStonecore"] = {
			["Bosses"] = {
				{ "StonecoreCorborus", 4, EncounterJournalID = 110 },
				{ "StonecoreSlabhide", 5, EncounterJournalID = 111 },
				{ "StonecoreOzruk", 6, EncounterJournalID = 112 },
				{ "StonecoreAzil", 7, EncounterJournalID = 113 },
				{ "StonecoreTrash", 10 },
			},
			["Info"] = { ALIL["The Stonecore"], "AtlasLootCataclysm", mapname = "TheStonecore", EncounterJournalID = 67 },
		},

		["TheVortexPinnacle"] = {
			["Bosses"] = {
				{ "VPErtan", 3, EncounterJournalID = 114 },
				{ "VPAltairus", 4 , EncounterJournalID = 115},
				{ "VPAsaad", 5, EncounterJournalID = 116 },
				{ "VPTrash", 9 },
			},
			["Info"] = { ALIL["The Vortex Pinnacle"], "AtlasLootCataclysm", mapname = "SkywallDungeon", EncounterJournalID = 68 },
		},

		["ThroneOfTheTides"] = {
			["Bosses"] = {
				{ "TotTNazjar", 5, EncounterJournalID = 101 },
				{ "TotTUlthok",  6, EncounterJournalID = 102 },
				{ "TotTMindbender", 7, EncounterJournalID = 103 },
				{ "TotTOzumat", 8, EncounterJournalID = 104 },
				{ "TotTTrash", 12 },
			},
			["Info"] = { ALIL["Throne of the Tides"], "AtlasLootCataclysm", mapname = "ThroneOfTheTides", EncounterJournalID = 65 },
		},

		["ZulAman"] = {
			["Bosses"] = {
				{ "ZAAkilZon", 6, EncounterJournalID = 186 },
				{ "ZANalorakk", 8, EncounterJournalID = 187 },
				{ "ZAJanAlai", 11, EncounterJournalID = 188 },
				{ "ZAHalazzi", 13, EncounterJournalID = 189 },
				{ "ZAMalacrass", 15, EncounterJournalID = 190 },
				{ "ZADaakara", 24, EncounterJournalID = 191 },
				{ "ZATimedChest", 40 },
				{ "ZATrash", 41 },
			},
			["Info"] = { ALIL["Zul'Aman"], "AtlasLootCataclysm", mapname = "ZulAman", EncounterJournalID = 77 },
		},

		["ZulGurub"] = {
			["Bosses"] = {
				{ "ZGVenoxis", 17, EncounterJournalID = 175 },
				{ "ZGMandokir", 22, EncounterJournalID = 176 },
				{ "ZGMadness", 26, EncounterJournalID = { 177, 178, 179, 180 } },
				{ "ZGKilnara", 34, EncounterJournalID = 181 },
				{ "ZGZanzil", 36, EncounterJournalID = 184 },
				{ "ZGJindo", 40, EncounterJournalID = 185 },
				{ "ZGTrash", 42 },
			},
			["Info"] = { ALIL["Zul'Gurub"], "AtlasLootCataclysm", mapname = "ZulGurub", EncounterJournalID = 76 },
		},

		-------------
		--- Raids ---
		-------------

		["BaradinHold"] = {
			["Bosses"] = {
				{ "BaradinsWardens", 1, hide = true },
				{ "HellscreamsReach", 2, hide = true },
				{ "ARGALOTH", 4, EncounterJournalID = 139 },
				{ "OCCUTHAR", 5, EncounterJournalID = 140 },
				{ "ALIZABAL", 6, EncounterJournalID = 339 },
			},
			["Info"] = { ALIL["Baradin Hold"], "AtlasLootCataclysm", mapname = "Baradinhold", raid = true, disableCompare = true, EncounterJournalID = 75 },
		},

		["BlackwingDescent"] = {
			["Bosses"] = {
				{ "BDMagmaw", 2, EncounterJournalID = 170 },
				{ "BDOmnotron", 3, EncounterJournalID = 169 },
				{ "BDChimaeron", 4, EncounterJournalID = 172 },
				{ "BDMaloriak", 5, EncounterJournalID = 173 },
				{ "BDAtramedes", 6, EncounterJournalID = 171 },
				{ "BDNefarian", 7, EncounterJournalID = 174 },
				{ "BDTrash", 9 },
			},
			["Info"] = { ALIL["Blackwing Descent"], "AtlasLootCataclysm", mapname = "BlackwingDescent", raid = true, EncounterJournalID = 73 },
		},

		["CoTDragonSoulA"] = "CoTDragonSoul",
		["CoTDragonSoulB"] = "CoTDragonSoul",
		["CoTDragonSoulC"] = "CoTDragonSoul",
		["CoTDragonSoul"] = {
			["CoTDragonSoulA"] = {
				{ "DragonSoulMorchok", 3, EncounterJournalID = 311 },
				{ "DragonSoulUltraxion", 4, EncounterJournalID = 331, hide = true },
				{ "DragonSoulShared", 8, hide = true },
				{ "DragonSoulTrash", 9, hide = true },
				{ "DragonSoulPatterns", 10, hide = true },
			},
			["CoTDragonSoulB"] = {
				{ "DragonSoulZonozz", 2, EncounterJournalID = 324 },
				{ "DragonSoulYorsahj", 3, EncounterJournalID = 325 },
				{ "DragonSoulHagara", 4, EncounterJournalID = 317 },
				{ "DragonSoulUltraxion", EncounterJournalID = 331 },
				{ "DragonSoulShared", 6, hide = true },
				{ "DragonSoulTrash", 7, hide = true },
				{ "DragonSoulPatterns", 8, hide = true },
			},
			["CoTDragonSoulC"] = {
				{ "DragonSoulBlackhorn", 1, EncounterJournalID = 332 },
				{ "DragonSoulDeathwingSpine", 2, EncounterJournalID = 318 },
				{ "DragonSoulDeathwingMadness", 3, EncounterJournalID = 333 },
				{ "DragonSoulShared", 5 },
				{ "DragonSoulTrash", 6 },
				{ "DragonSoulPatterns", 7 },
			},
			["Info"] = { ALIL["Dragon Soul"], "AtlasLootCataclysm", mapname = "DragonSoul", sortOrder = { "CoTDragonSoulA", "CoTDragonSoulB", "CoTDragonSoulC" }, raid = true, EncounterJournalID = 187 },
		},

		["Firelands"] = {
			["Bosses"] = {
				{ "AvengersHyjal", {1,4}, hide = true },
				{ "FirelandsBethtilac", 6, EncounterJournalID = 192 },
				{ "FirelandsRhyolith", 7, EncounterJournalID = 193 },
				{ "FirelandsAlysrazor", 8, EncounterJournalID = 194 },
				{ "FirelandsShannox", 9, EncounterJournalID = 195 },
				{ "FirelandsBaleroc", 10, EncounterJournalID = 196 },
				{ "FirelandsStaghelm", 11, EncounterJournalID = 197 },
				{ "FirelandsRagnaros", 12, EncounterJournalID = 198 },
				{ "FirelandsShared", 15 },
				{ "FirelandsTrash", 16 },
				{ "FirelandsPatterns", 17 },
				{ "FirelandsFirestone", 3 },
			},
			["Info"] = { ALIL["Firelands"], "AtlasLootCataclysm", mapname = "Firelands", raid = true, EncounterJournalID = 78 },
		},

		["TheBastionOfTwilight"] = {
			["Bosses"] = {
				{ "BoTWyrmbreaker", 3, EncounterJournalID = 156 },
				{ "BoTValionaTheralion", 4, EncounterJournalID = 157 },
				{ "BoTCouncil", 6, EncounterJournalID = 158 },
				{ "BoTChogall", 8, EncounterJournalID = 167 },
				{ "BoTSinestra", 9, EncounterJournalID = 168 },
				{ "BoTTrash", 12 },
			},
			["Info"] = { ALIL["The Bastion of Twilight"], "AtlasLootCataclysm", mapname = "TheBastionofTwilight", raid = true, EncounterJournalID = 72 },
		},

		["ThroneOfTheFourWinds"] = {
			["Bosses"] = {
				{ "TFWConclave", 2, EncounterJournalID = 154 },
				{ "TFWAlAkir", 6, EncounterJournalID = 155 },
			},
			["Info"] = { ALIL["Throne of the Four Winds"], "AtlasLootCataclysm", mapname = "Throneofthefourwinds", raid = true, EncounterJournalID = 74 },
		},

	----------------------------------------
	--- Wrath of the Lich King Instances ---
	----------------------------------------

		----------------
		--- Dungeons ---
		----------------

		["AhnKahet"] = {
			["Bosses"] = {
				{ "AhnkahetNadox", 4, EncounterJournalID = 580 },
				{ "AhnkahetTaldaram", 5, EncounterJournalID = 581 },
				{ "AhnkahetAmanitar", 6 },
				{ "AhnkahetJedoga", 7, EncounterJournalID = 582 },
				{ "AhnkahetVolazj", 8, EncounterJournalID = 584 },
				{ "AhnkahetTrash", 11 },
			},
			["Info"] = { ALIL["Ahn'kahet: The Old Kingdom"], "AtlasLootWotLK", mapname = "Ahnkahet", EncounterJournalID = 271 },
		},

		["AzjolNerub"] = {
			["Bosses"] = {
				{ "AzjolNerubKrikthir", 5, EncounterJournalID = 585 },
				{ "AzjolNerubHadronox", 9, EncounterJournalID = 586 },
				{ "AzjolNerubAnubarak", 10, EncounterJournalID = 587 },
				{ "LunarFestival", 11, hide = true },
				{ "AzjolNerubTrash", 13 },
			},
			["Info"] = { ALIL["Azjol-Nerub"], "AtlasLootWotLK", mapname = "AzjolNerub", EncounterJournalID = 272 },
		},

		["CoTOldStratholme"] = {
			["Bosses"] = {
				{ "CoTStratholmeMeathook", 5, EncounterJournalID = 611 },
				{ "CoTStratholmeSalramm", 6, EncounterJournalID = 612 },
				{ "CoTStratholmeEpoch", 7, EncounterJournalID = 613 },
				{ "CoTStratholmeTrash", 8, hide = true },
				{ "CoTStratholmeMalGanis", 10, EncounterJournalID = 614 },
				{ "CoTStratholmeTrash", 14 },
			},
			["Info"] = { ALIL["The Culling of Stratholme"], "AtlasLootWotLK", mapname = "CoTStratholme", EncounterJournalID = 279 },
		},

		["DrakTharonKeep"] = {
			["Bosses"] = {
				{ "DrakTharonKeepTrollgore", 5, EncounterJournalID = 588 },
				{ "DrakTharonKeepNovos", 6, EncounterJournalID = 589 },
				{ "DrakTharonKeepKingDred", 7, EncounterJournalID = 590 },
				{ "DrakTharonKeepTharonja", 8, EncounterJournalID = 591 },
				{ "LunarFestival", 9, hide = true },
				{ "DrakTharonKeepTrash", 12 },
			},
			["Info"] = { ALIL["Drak'Tharon Keep"], "AtlasLootWotLK", mapname = "DrakTharonKeep", EncounterJournalID = 273 },
		},

		["FHTheForgeOfSouls"] = {
			["Bosses"] = {
				{ "FoSBronjahm", 3, EncounterJournalID = 615 },
				{ "FoSDevourer", 4, EncounterJournalID = 616 },
				{ "FHTrashMobs", 12 },
			},
			["Info"] = { ALIL["The Forge of Souls"], "AtlasLootWotLK", mapname = "TheForgeofSouls", EncounterJournalID = 280 },
		},

		["FHHallsOfReflection"] = {
			["Bosses"] = {
				{ "HoRFalric", 4, EncounterJournalID = 601 },
				{ "HoRMarwyn", 5, EncounterJournalID = 602 },
				{ "HoRLichKing", {6,7}, EncounterJournalID = 603 },
				{ "FHTrashMobs", 13 },
			},
			["Info"] = { ALIL["Halls of Reflection"], "AtlasLootWotLK", mapname = "HallsofReflection", EncounterJournalID = 276 },
		},

		["FHPitOfSaron"] = {
			["Bosses"] = {
				{ "PoSGarfrost", 4, EncounterJournalID = 608 },
				{ "PoSKrickIck", 7, EncounterJournalID = 609 },
				{ "PoSTyrannus", 8, EncounterJournalID = 610 },
				{ "FHTrashMobs", 17 },
			},
			["Info"] = { ALIL["Pit of Saron"], "AtlasLootWotLK", mapname = "PitofSaron", EncounterJournalID = 278 },
		},

		["Gundrak"] = {
			["Bosses"] = {
				{ "GundrakSladran", 4, EncounterJournalID = 592 },
				{ "GundrakColossus", 5, EncounterJournalID = 593 },
				{ "GundrakMoorabi", 6, EncounterJournalID = 594 },
				{ "GundrakEck", 7 },
				{ "GundrakGaldarah", 8, EncounterJournalID = 596 },
				{ "LunarFestival", 9, hide = true },
				{ "GundrakTrash", 11 },
			},
			["Info"] = { ALIL["Gundrak"], "AtlasLootWotLK", mapname = "Gundrak", EncounterJournalID = 274 },
		},

		["TheNexus"] = {
			["Bosses"] = {
				{ "TheNexusKolurgStoutbeard", {3,4} },
				{ "TheNexusTelestra", 6, EncounterJournalID = 618 },
				{ "TheNexusAnomalus", 7, EncounterJournalID = 619 },
				{ "TheNexusOrmorok", 8, EncounterJournalID = 620 },
				{ "TheNexusKeristrasza", 9, EncounterJournalID = 621 },
				{ "LunarFestival", 10, hide = true },
			},
			["Info"] = { ALIL["The Nexus"], "AtlasLootWotLK", mapname = "TheNexus", EncounterJournalID = 281 },
		},

		["TheOculus"] = {
			["Bosses"] = {
				{ "OcuDrakos", 3, EncounterJournalID = 622 },
				{ "OcuCloudstrider", 7, EncounterJournalID = 623 },
				{ "OcuUrom", 8, EncounterJournalID = 624 },
				{ "OcuEregos", {9,11}, EncounterJournalID = 625 },
				{ "OcuTrash", 13 },
			},
			["Info"] = { ALIL["The Oculus"], "AtlasLootWotLK", mapname = "Nexus80", EncounterJournalID = 282 },
		},

		["TrialOfTheChampion"] = {
			["Bosses"] = {
				{ "TrialoftheChampionChampions", 2, EncounterJournalID = 634 },
				{ "TrialoftheChampionEadricthePure", 15, EncounterJournalID = 635 },
				{ "TrialoftheChampionConfessorPaletress", 16, EncounterJournalID = 636 },
				{ "TrialoftheChampionBlackKnight", 17, EncounterJournalID = 637 },
			},
			["Info"] = { ALIL["Trial of the Champion"], "AtlasLootWotLK", mapname = "TheArgentColiseum", EncounterJournalID = 284 },
		},

		["UlduarHallsofStone"] = {
			["Bosses"] = {
				{ "HallsofStoneKrystallus", 3, EncounterJournalID = 604 },
				{ "HallsofStoneMaiden", 4, EncounterJournalID = 605 },
				{ "HallsofStoneTribunal", {5,6}, EncounterJournalID = 606 },
				{ "HallsofStoneSjonnir", 7, EncounterJournalID = 607 },
				{ "LunarFestival", 8, hide = true },
				{ "HallsofStoneTrash", 11 },
			},
			["Info"] = { ALIL["Halls of Stone"], "AtlasLootWotLK", mapname = "Ulduar77", EncounterJournalID = 277 },
		},

		["UlduarHallsofLightning"] = {
			["Bosses"] = {
				{ "HallsofLightningBjarngrim", 3, EncounterJournalID = 597 },
				{ "HallsofLightningVolkhan", 4, EncounterJournalID = 598 },
				{ "HallsofLightningIonar", 5, EncounterJournalID = 599 },
				{ "HallsofLightningLoken", 6, EncounterJournalID = 600 },
				{ "HallsofLightningTrash", 8 },
			},
			["Info"] = { ALIL["Halls of Lightning"], "AtlasLootWotLK", mapname = "HallsofLightning", EncounterJournalID = 275 },
		},

		["UtgardeKeep"] = {
			["Bosses"] = {
				{ "UtgardeKeepKeleseth", 5, EncounterJournalID = 638 },
				{ "UtgardeKeepSkarvald", 6, EncounterJournalID = 639 },
				{ "UtgardeKeepIngvar", 7, EncounterJournalID = 640 },
				{ "LunarFestival", 8, hide = true },
				{ "UtgardeKeepTrash", 10 },
			},
			["Info"] = { ALIL["Utgarde Keep"], "AtlasLootWotLK", mapname = "UtgardeKeep", EncounterJournalID = 285 },
		},

		["UtgardePinnacle"] = {
			["Bosses"] = {
				{ "UPSorrowgrave", 4, EncounterJournalID = 641 },
				{ "UPPalehoof", 5, EncounterJournalID = 642 },
				{ "UPSkadi", 6, EncounterJournalID = 643 },
				{ "UPYmiron", 7, EncounterJournalID = 644 },
				{ "LunarFestival", 8, hide = true },
				{ "UPTrash", 10 },
			},
			["Info"] = { ALIL["Utgarde Pinnacle"], "AtlasLootWotLK", mapname = "UtgardePinnacle", EncounterJournalID = 286 },
		},

		["VioletHold"] = {
			["Bosses"] = {
				{ "VioletHoldErekem", 3, EncounterJournalID = 626 },
				{ "VioletHoldZuramat", 4, EncounterJournalID = 631 },
				{ "VioletHoldXevozz", 5, EncounterJournalID = 629 },
				{ "VioletHoldIchoron", 6, EncounterJournalID = 628 },
				{ "VioletHoldMoragg", 7, EncounterJournalID = 627 },
				{ "VioletHoldLavanthor", 8, EncounterJournalID = 630 },
				{ "VioletHoldCyanigosa", 9, EncounterJournalID = 632 },
				{ "VioletHoldTrash", 11 },
			},
			["Info"] = { ALIL["The Violet Hold"], "AtlasLootWotLK", mapname = "VioletHold", EncounterJournalID = 283 },
		},

		-------------
		--- Raids ---
		-------------

		["IcecrownCitadelA"] = "IcecrownCitadel",
		["IcecrownCitadelB"] = "IcecrownCitadel",
		["IcecrownCitadelC"] = "IcecrownCitadel",
		["IcecrownCitadel"] = {
			["IcecrownCitadelA"] = {
				{ "TheAshenVerdict", 1, hide = true},
				{ "ICCLordMarrowgar", 5},
				{ "ICCLadyDeathwhisper", 6},
				{ "ICCGunshipBattle", {7,8}},
				{ "ICCSaurfang", 9},
				{ "ICCTrash", 15, hide = true},
			},
			["IcecrownCitadelB"] = {
				{ "TheAshenVerdict", 1, hide = true},
				{ "ICCFestergut", 7},
				{ "ICCRotface", 8},
				{ "ICCPutricide", 9},
				{ "ICCCouncil", {10,11,12,13} },
				{ "ICCLanathel", 14},
				{ "ICCValithria", 16},
				{ "ICCSindragosa", 17},
				{ "ICCTrash", 23},
			},
			["IcecrownCitadelC"] = {
				{ "TheAshenVerdict", 1, hide = true},
				{ "ICCLichKing", 3},
			},
			["Info"] = { ALIL["Icecrown Citadel"], "AtlasLootWotLK", sortOrder = { "IcecrownCitadelA", "IcecrownCitadelB", "IcecrownCitadelC" }, mapname = "IcecrownCitadel", raid = true },
		},

		["Naxxramas"] = {
			["Bosses"] = {
				{ "Naxx80Patchwerk", 4 },
				{ "Naxx80Grobbulus", 5 },
				{ "Naxx80Gluth", 6 },
				{ "Naxx80Thaddius", 7 },
				{ "Naxx80AnubRekhan", 11 },
				{ "Naxx80Faerlina", 12 },
				{ "Naxx80Maexxna", 13 },
				{ "Naxx80Razuvious", 15 },
				{ "Naxx80Gothik", 16 },
				{ "Naxx80FourHorsemen", {17,22} },
				{ "Naxx80Noth", 24 },
				{ "Naxx80Heigan", 25 },
				{ "Naxx80Loatheb", 26 },
				{ "Naxx80Sapphiron", 28 },
				{ "Naxx80KelThuzad", 29 },
				{ "Naxx80Trash", 33 },
				{ "T7T8SET", 34, hide = true },
			},
			["Info"] = { ALIL["Naxxramas"], "AtlasLootWotLK", mapname = "IcecrownCitadel", mapname = "Naxxramas", raid = true },
		},

		["ObsidianSanctum"] = {
			["Bosses"] = {
				{ "Sartharion", 6 },
			},
			["Info"] = { ALIL["The Obsidian Sanctum"], "AtlasLootWotLK", mapname = "TheObsidianSanctum", raid = true },
		},

		["OnyxiasLair"] = {
			["Bosses"] = {
				{ "Onyxia", 2 },
			},
			["Info"] = { ALIL["Onyxia's Lair"], "AtlasLootWotLK", mapname = "OnyxiasLair", raid = true },
		},

		["RubySanctum"] = {
			["Bosses"] = {
				{ "Halion", 6 },
			},
			["Info"] = { ALIL["The Ruby Sanctum"], "AtlasLootWotLK", mapname = "TheRubySanctum", raid = true },
		},

		["TheEyeOfEternity"] = {
			["Bosses"] = {
				{ "Malygos", 2 },
			},
			["Info"] = { ALIL["The Eye of Eternity"], "AtlasLootWotLK", mapname = "TheEyeOfEternity", raid = true },
		},

		["TrialOfTheCrusader"] = {
			["Bosses"] = {
				{ "TrialoftheCrusaderNorthrendBeasts", 4 },
				{ "TrialoftheCrusaderLordJaraxxus", 9 },
				{ "TrialoftheCrusaderFactionChampions", 10 },
				{ "TrialoftheCrusaderTwinValkyrs", 11 },
				{ "TrialoftheCrusaderAnubarak", 14 },
				{ "TrialoftheCrusaderPatterns", 16 },
			},
			["Info"] = { ALIL["Trial of the Crusader"], "AtlasLootWotLK", mapname = "TheArgentColiseum", raid = true },
		},

		["UlduarA"] = "Ulduar",
		["UlduarB"] = "Ulduar",
		["UlduarC"] = "Ulduar",
		["UlduarD"] = "Ulduar",
		["UlduarE"] = "Ulduar",
		["Ulduar"] = {
			["UlduarA"] = {
				{ "UlduarLeviathan", 7 },
				{ "UlduarRazorscale", 8},
				{ "UlduarIgnis", 9 },
				{ "UlduarDeconstructor", 10 },
				{ "UlduarTrash", 16, hide = true},
				{ "UlduarPatterns", 17, hide = true},
				{ "T7T8SET", 18 , hide = true},
			},
			["UlduarB"] = {
				{ "UlduarIronCouncil", 3 },
				{ "UlduarKologarn", 7 },
				{ "UlduarAlgalon", 8 },
				{ "UlduarTrash", 13, hide = true },
				{ "UlduarPatterns", 14, hide = true },
				{ "T7T8SET", 15, hide = true },
			},
			["UlduarC"] = {
				{ "UlduarAuriaya", 4 },
				{ "UlduarHodir", 5 },
				{ "UlduarThorim", 6 },
				{ "UlduarFreya", 8 },
				{ "UlduarTrash", 15, hide = true },
				{ "UlduarPatterns", 16, hide = true },
				{ "T7T8SET", 17, hide = true },
			},
			["UlduarD"] = {
				{ "UlduarMimiron", 2 },
				{ "UlduarTrash", 5, hide = true },
				{ "UlduarPatterns", 6, hide = true },
				{ "T7T8SET", 7, hide = true },
			},
			["UlduarE"] = {
				{ "UlduarVezax", 2 },
				{ "UlduarYoggSaron", 3 },
				{ "UlduarTrash", 7 },
				{ "UlduarPatterns", 8 },
				{ "T7T8SET", 9, hide = true },
			},
			["Info"] = { ALIL["Ulduar"], "AtlasLootWotLK", sortOrder = { "UlduarA", "UlduarB", "UlduarC", "UlduarD", "UlduarE" }, mapname = "Ulduar", raid = true },
		},

		["VaultOfArchavon"] = {
			["Bosses"] = {
				{ "ARCHAVON", 2 },
				{ "EMALON", 3 },
				{ "KORALON", 4 },
				{ "TORAVON", 5 },
			},
			["Info"] = { ALIL["Vault of Archavon"], "AtlasLootWotLK", mapname = "VaultofArchavon", raid = true, disableCompare = true },
		},

	---------------------------------
	--- Burning Crusade Instances ---
	---------------------------------

		----------------
		--- Dungeons ---
		----------------

		["AuchAuchenaiCrypts"] = {
			["Bosses"] = {
				{ "LowerCity", 1, hide = true },
				{ "AuchCryptsShirrak", 4, EncounterJournalID = 523 },
				{ "AuchCryptsExarch", 5, EncounterJournalID = 524 },
				{ "AuchCryptsAvatar", 6 },
				{ "AuchTrash", 10 },
			},
			["Info"] = { ALIL["Auchenai Crypts"], "AtlasLootBurningCrusade", EncounterJournalID = 247 },
		},

		["AuchManaTombs"] = {
			["Bosses"] = {
				{ "Consortium", 1, hide = true },
				{ "AuchManaPandemonius", 6, EncounterJournalID = 534 },
				{ "AuchManaTavarok", 8, EncounterJournalID = 535 },
				{ "AuchManaNexusPrince", 9, EncounterJournalID = 537 },
				{ "AuchManaYor", 10 },
				{ "AuchTrash", 15 },
			},
			["Info"] = { ALIL["Mana-Tombs"], "AtlasLootBurningCrusade", mapname = "ManaTombs1", EncounterJournalID = 250 },
		},

		["AuchSethekkHalls"] = {
			["Bosses"] = {
				{ "LowerCity", 1, hide = true },
				{ "AuchSethekkDarkweaver", 4, EncounterJournalID = 541 },
				{ "AuchSethekkRavenGod", 7 },
				{ "AuchTrash", 8, hide = true },
				{ "AuchSethekkTalonKing", 9, EncounterJournalID = 543 },
				{ "AuchTrash", 11 },
			},
			["Info"] = { ALIL["Sethekk Halls"], "AtlasLootBurningCrusade", EncounterJournalID = 252 },
		},

		["AuchShadowLabyrinth"] = {
			["Bosses"] = {
				{ "LowerCity", 1, hide = true },
				{ "AuchShadowHellmaw", 5, EncounterJournalID = 544 },
				{ "AuchShadowBlackheart", 6, EncounterJournalID = 545 },
				{ "AuchShadowGrandmaster", 7, EncounterJournalID = 546 },
				{ "AuchShadowMurmur", 9, EncounterJournalID = 547 },
				{ "AuchTrash", 1, hide = true },
				{ "AuchTrash", 14 },
			},
			["Info"] = { ALIL["Shadow Labyrinth"], "AtlasLootBurningCrusade", mapname = "ShadowLabyrinth1", EncounterJournalID = 253 },
		},

		["CoTOldHillsbrad"] = {
			["Bosses"] = {
				{ "KeepersofTime", 3, hide = true },
				{ "CoTHillsbradDrake", 10, EncounterJournalID = 538 },
				{ "CoTHillsbradSkarloc", 12, EncounterJournalID = 539 },
				{ "CoTHillsbradHunter", 15, EncounterJournalID = 540 },
				{ "CoTTrash", {18,20,21}, hide = true },
				{ "CoTTrash", 25 },
			},
			["Info"] = { ALIL["Old Hillsbrad Foothills"], "AtlasLootBurningCrusade", EncounterJournalID = 251 },
		},

		["CoTBlackMorass"] = {
			["Bosses"] = {
				{ "KeepersofTime", 3, hide = true },
				{ "CoTMorassDeja", 7, EncounterJournalID = 552 },
				{ "CoTMorassTemporus", 8, EncounterJournalID = 553 },
				{ "CoTMorassAeonus", 9, EncounterJournalID = 554 },
				{ "CoTTrash", 13 },	
			},
			["Info"] = { ALIL["The Black Morass"], "AtlasLootBurningCrusade", EncounterJournalID = 255 },
		},

		["CFRTheSlavePens"] = {
			["Bosses"] = {
				{ "CExpedition", 1, hide = true },
				{ "CFRSlaveMennu", 5, EncounterJournalID = 570 },
				{ "CFRSlaveRokmar", 6, EncounterJournalID = 571 },
				{ "CFRSlaveQuagmirran", 7, EncounterJournalID = 572 },
				{ "LordAhune", 8, hide = true },
			},
			["Info"] = { ALIL["The Slave Pens"], "AtlasLootBurningCrusade", EncounterJournalID = 260 },
		},

		["CFRTheSteamvault"] = {
			["Bosses"] = {
				{ "CExpedition", 1, hide = true },
				{ "CFRSteamThespia", 6, EncounterJournalID = 573 },
				{ "CFRSteamSteamrigger", 8, EncounterJournalID = 574 },
				{ "CFRSteamWarlord", 10, EncounterJournalID = 575 },
				{ "CFRSteamTrash", 12, hide = true },
				{ "CFRSteamTrash", 14 },
			},
			["Info"] = { ALIL["The Steamvault"], "AtlasLootBurningCrusade", EncounterJournalID = 261 },
		},

		["CFRTheUnderbog"] = {
			["Bosses"] = {
				{ "CExpedition", 1, hide = true },
				{ "CFRUnderHungarfen", 6, EncounterJournalID = 576 },
				{ "CFRUnderGhazan", 8, EncounterJournalID = 577 },
				{ "CFRUnderSwamplord", 9, EncounterJournalID = 578 },
				{ "CFRUnderStalker", 11, EncounterJournalID = 579 },
			},
			["Info"] = { ALIL["The Underbog"], "AtlasLootBurningCrusade", EncounterJournalID = 262 },
		},

		["HCHellfireRamparts"] = {
			["Bosses"] = {
				{ "HonorHold", 1, hide = true },
				{ "Thrallmar", 2, hide = true },
				{ "HCRampWatchkeeper", 6, EncounterJournalID = 527 },
				{ "HCRampOmor", 7, EncounterJournalID = 528 },
				{ "HCRampVazruden", {8,9}, EncounterJournalID = 529 },
			},
			["Info"] = { ALIL["Hellfire Ramparts"], "AtlasLootBurningCrusade", EncounterJournalID = 248 },
		},

		["HCBloodFurnace"] = {
			["Bosses"] = {
				{ "HonorHold", 1, hide = true },
				{ "Thrallmar", 2, hide = true },
				{ "HCFurnaceMaker", 6, EncounterJournalID = 555 },
				{ "HCFurnaceBroggok", 7, EncounterJournalID = 556 },
				{ "HCFurnaceBreaker", 8, EncounterJournalID = 557 },
			},
			["Info"] = { ALIL["The Blood Furnace"], "AtlasLootBurningCrusade", EncounterJournalID = 256 },
		},

		["HCTheShatteredHalls"] = {
			["Bosses"] = {
				{ "HonorHold", 1, hide = true },
				{ "Thrallmar", 2, hide = true },
				{ "HCHallsNethekurse", 8, EncounterJournalID = 566 },
				{ "HCHallsPorung", 9 },
				{ "HCHallsOmrogg", 10, EncounterJournalID = 568 },
				{ "HCHallsKargath", 11, EncounterJournalID = 569 },
				{ "HCHallsTrash", 12, hide = true },
				{ "HCHallsTrash", 22 },
			},
			["Info"] = { ALIL["The Shattered Halls"], "AtlasLootBurningCrusade", EncounterJournalID = 259 },
		},

		["MagistersTerrace"] = {
			["Bosses"] = {
				{ "SunOffensive", 1, hide = true },
				{ "SMTFireheart", 5, EncounterJournalID = 530 },
				{ "SMTVexallus", 7, EncounterJournalID = 531 },
				{ "SMTDelrissa", 8, EncounterJournalID = 532 },
				{ "SMTKaelthas", 19, EncounterJournalID = 533 },
				{ "SMTTrash", 24 },
			},
			["Info"] = { ALIL["Magisters' Terrace"], "AtlasLootBurningCrusade", EncounterJournalID = 249 },
		},

		["TempestKeepArcatraz"] = {
			["Bosses"] = {
				{ "Shatar", 1, hide = true },
				{ "TKArcUnbound", 3, EncounterJournalID = 548 },
				{ "TKArcDalliah", 4, EncounterJournalID = 549 },
				{ "TKArcScryer", 5, EncounterJournalID = 550 },
				{ "TKArcHarbinger", 6, EncounterJournalID = 551 },
				{ "TKTrash", 10, hide = true },
				{ "TKTrash", 13 },
			},
			["Info"] = { ALIL["The Arcatraz"], "AtlasLootBurningCrusade", EncounterJournalID = 254 },
		},

		["TempestKeepBotanica"] = {
			["Bosses"] = {
				{ "Shatar", 1, hide = true },
				{ "TKBotSarannis", 4, EncounterJournalID = 558 },
				{ "TKBotFreywinn", 5, EncounterJournalID = 559 },
				{ "TKBotThorngrin", 6, EncounterJournalID = 560 },
				{ "TKBotLaj", 7, EncounterJournalID = 561 },
				{ "TKBotSplinter", 8, EncounterJournalID = 562 },
				{ "TKTrash", 10 },
			},
			["Info"] = { ALIL["The Botanica"], "AtlasLootBurningCrusade", EncounterJournalID = 257 },
		},

		["TempestKeepMechanar"] = {
			["Bosses"] = {
				{ "Shatar", 1, hide = true },
				{ "TKMechCapacitus", 6, EncounterJournalID = 563 },
				{ "TKTrash", 7, hide = true },
				{ "TKMechSepethrea", 8, EncounterJournalID = 564 },
				{ "TKMechCalc", 9, EncounterJournalID = 565 },
				{ "TKMechCacheoftheLegion", 10 },
				{ "TKTrash", 12 },
			},
			["Info"] = { ALIL["The Mechanar"], "AtlasLootBurningCrusade", EncounterJournalID = 258 },
		},

		-------------
		--- Raids ---
		-------------

		["BlackTempleStart"] = "BlackTemple",
		["BlackTempleBasement"] = "BlackTemple",
		["BlackTempleTop"] = "BlackTemple",
		["BlackTemple"] = {
			["BlackTempleStart"] = {
				{ "Ashtongue", 1, hide = true },
				{ "BTNajentus", 6 },
				{ "BTSupremus", 7 },
				{ "BTAkama", 8 },
				{ "BTTrash", 15, hide = true },
				{ "BTPatterns", 16, hide = true },
			},
			["BlackTempleBasement"] = {
				{ "Ashtongue", 1, hide = true },
				{ "BTBloodboil", 4 },
				{ "BTReliquaryofSouls", 5 },
				{ "BTGorefiend", 9 },
				{ "BTTrash", 11, hide = true },
				{ "BTPatterns", 12, hide = true },
			},
			["BlackTempleTop"] = {
				{ "Ashtongue", 1, hide = true },
				{ "BTShahraz", 4 },
				{ "BTCouncil", 5 },
				{ "BTIllidanStormrage", 10 },
				{ "BTTrash", 12 },
				{ "BTPatterns", 13 },
			},
			["Info"] = { ALIL["Black Temple"], "AtlasLootBurningCrusade", sortOrder = { "BlackTempleStart", "BlackTempleBasement", "BlackTempleTop" }, raid = true },
		},

		["CoTHyjalEnt"] = "CoTHyjalEaI",
		["CoTHyjal"] = "CoTHyjalEaI",
		["CoTHyjalEaI"] = {
			["CoTHyjalEnt"] = {
				{ "ScaleSands", 2, hide = true },
			},
			["CoTHyjal"] = {
				{ "ScaleSands", 2, hide = true },
				{ "MountHyjalWinterchill", 9 },
				{ "MountHyjalAnetheron", 10 },
				{ "MountHyjalKazrogal", 11 },
				{ "MountHyjalAzgalor", 12 },
				{ "MountHyjalArchimonde", 13 },
				{ "MountHyjalTrash", 15 },
			},
			["Info"] = { ALIL["Hyjal Summit"], "AtlasLootBurningCrusade", sortOrder = { "CoTHyjalEnt", "CoTHyjal" }, raid = true },
		},

		["CFRSerpentshrineCavern"] = {
			["Bosses"] = {
				{ "CExpedition", 1, hide = true },
				{ "CFRSerpentHydross", 3 },
				{ "CFRSerpentLurker", 4 },
				{ "CFRSerpentLeotheras", 5 },
				{ "CFRSerpentKarathress", 6 },
				{ "CFRSerpentMorogrim", 8 },
				{ "CFRSerpentVashj", 9 },
				{ "CFRSerpentTrash", 11 },
			},
			["Info"] = { ALIL["Serpentshrine Cavern"], "AtlasLootBurningCrusade", raid = true },
		},

		["GruulsLair"] = {
			["Bosses"] = {
				{ "GruulsLairHighKingMaulgar", 2 },
				{ "GruulGruul", 7 },
			},
			["Info"] = { ALIL["Gruul's Lair"], "AtlasLootBurningCrusade", raid = true },
		},

		["HCMagtheridonsLair"] = {
			["Bosses"] = {
				{ "HCMagtheridon", 2 },
			},
			["Info"] = { ALIL["Magtheridon's Lair"], "AtlasLootBurningCrusade", raid = true },
		},

		["KarazhanEnt"] = "KarazhanEaI",
		["KarazhanStart"] = "KarazhanEaI",
		["KarazhanEnd"] = "KarazhanEaI",
		["KarazhanEaI"] = {
			["KarazhanEnt"] = {
				{ "KaraCharredBoneFragment", 8, hide = true },
			},
			["KarazhanStart"] = {
				{ "VioletEye", 1, hide = true },
				{ "KaraAttumen", 4 },
				{ "KaraMoroes", 6 },
				{ "KaraMaiden", 13 },
				{ "KaraOperaEvent", 14 },
				{ "KaraNightbane", 27 },
				{ "KaraNamed", {29,30,31,32} },
				{ "KaraTrash", 38, hide = true },
				{ "KaraTrash", 43, hide = true },
			},
			["KarazhanEnd"] = {
				{ "VioletEye", 1, hide = true },
				{ "KaraCurator", 10 },
				{ "KaraIllhoof", 11 },
				{ "KaraAran", 13 },
				{ "KaraNetherspite", 14 },
				{ "KaraChess", {15,16} },
				{ "KaraPrince", 17 },
				{ "KaraTrash", 24 },
			},
			["Info"] = { ALIL["Karazhan"], "AtlasLootBurningCrusade", sortOrder = { "KarazhanEnt", "KarazhanStart", "KarazhanEnd" }, raid = true },
		},

		["SunwellPlateau"] = {
			["Bosses"] = {
				{ "SPKalecgos", 2 },
				{ "SPBrutallus", 4 },
				{ "SPFelmyst", 5 },
				{ "SPEredarTwins", 7 },
				{ "SPMuru", 10 },
				{ "SPKiljaeden", 12 },
				{ "SPTrash", 14 },
				{ "SPPatterns", 15 },
			},
			["Info"] = { ALIL["Sunwell Plateau"], "AtlasLootBurningCrusade", raid = true },
		},

		["TempestKeepTheEye"] = {
			["Bosses"] = {
				{ "Shatar", 1, hide = true },
				{ "TKEyeAlar", 3 },
				{ "TKEyeVoidReaver", 4 },
				{ "TKEyeSolarian", 5 },
				{ "TKEyeKaelthas", 6 },
				{ "TKEyeTrash", 12 },
			},
			["Info"] = { ALIL["Tempest Keep"], "AtlasLootBurningCrusade", raid = true },
		},

	-------------------------
	--- Classic Instances ---
	-------------------------

		----------------
		--- Dungeons ---
		----------------

		["BlackfathomDeeps"] = {
			["Bosses"] = {
				{ "Blackfathom#1", {3,4,5,7,8,11} },
				{ "Blackfathom#2", {9,12,19}, hide = true },
			},
			["Info"] = { ALIL["Blackfathom Deeps"], "AtlasLootClassicWoW", mapname = "BlackFathomDeeps", EncounterJournalID = 227 },
		},

		["BlackrockDepths"] = {
			["Bosses"] = {
				{ "BRDHighInterrogatorGerstahn", 6, EncounterJournalID = 369 },
				{ "BRDLordRoccor", 7, EncounterJournalID = 370 },
				{ "BRDHoundmaster", 8, EncounterJournalID = 371 },
				{ "BRDBaelGar", 9, EncounterJournalID = 377 },
				{ "BRDLordIncendius", 10, EncounterJournalID = 374 },
				{ "BRDFineousDarkvire", 12, EncounterJournalID = 376 },
				{ "BRDTheVault", 13 },
				{ "BRDWarderStilgiss", 14, EncounterJournalID = 375 },
				{ "BRDVerek", 15 },
				{ "BRDPyromantLoregrain", 17, EncounterJournalID = 373 },
				{ "BRDArena", {18,20,21,22,23,24,25}, EncounterJournalID = 372 },
				{ "LunarFestival", 26, hide = true },
				{ "BRDGeneralAngerforge", 27, EncounterJournalID = 378 },
				{ "BRDGolemLordArgelmach", 28, EncounterJournalID = 379 },
				{ "BRDBSPlans", {30,59}, hide = true },
				{ "BRDGuzzler", {31,33,34,35} },
				{ "CorenDirebrew", 32, hide = true },
				{ "BRDFlamelash", 38, EncounterJournalID = 384 },
				{ "BRDTomb", 39, EncounterJournalID = 385 },
				{ "BRDMagmus", 40, EncounterJournalID = 386 },
				{ "BRDImperatorDagranThaurissan", 41, EncounterJournalID = 387 },
				{ "BRDPrincess", 42 },
				{ "BRDPanzor", 44 },
				{ "BRDQuestItems", {69,70}, hide = true },
				{ "BRDTrash", 72 },
				{ "VWOWSets#1", 73, hide = true },
			},
			["Info"] = { ALIL["Blackrock Depths"], "AtlasLootClassicWoW", mapname = "BlackrockDepths", EncounterJournalID = 228 },
		},

		["BlackrockMountainEnt"] = {
			["Bosses"] = {
				{ "BlackrockMountainEntLoot", {12,13,14} },
			},
			["Info"] = { AL["Blackrock Mountain"], "AtlasLootClassicWoW" },
		},

		["BlackrockSpireLower"] = {
			["Bosses"] = {
				{ "LBRSOmokk", 4, EncounterJournalID = 398 },
				{ "LBRSVosh", 5, EncounterJournalID = 399 },
				{ "LBRSVoone", 6, EncounterJournalID = 390 },
				{ "LBRSSmolderweb", 7, EncounterJournalID = 391 },
				{ "LBRSDoomhowl", 8, EncounterJournalID = 392 },
				{ "LBRSZigris", 10, EncounterJournalID = 393 },
				{ "LBRSHalycon", 11, EncounterJournalID = 394 },
				{ "LBRSSlavener", 12, EncounterJournalID = 395 },
				{ "LBRSWyrmthalak", 13, EncounterJournalID = 396 },
				{ "LBRSFelguard", 14 },
				{ "LBRSSpirestoneButcher", 15 },
				{ "LBRSGrimaxe", 16 },
				{ "LBRSCrystalFang", 17 },
				{ "LBRSSpirestoneLord", 18 },
				{ "LBRSLordMagus", 19 },
				{ "LBRSBashguud", 20 },
				{ "LunarFestival", 22, hide = true },
				{ "LBRSQuestItems", 23, hide = true },
				{ "LBRSTrash", 25 },
				{ "VWOWSets#3", 26, hide = true },
			},
			["Info"] = { ALIL["Lower Blackrock Spire"], "AtlasLootClassicWoW", mapname = "BlackrockSpire", EncounterJournalID = 229 },
		},

		["BlackrockSpireUpper"] = {
			["Bosses"] = {
				{ "UBRSEmberseer", 5, EncounterJournalID = 397 },
				{ "UBRSSolakar", 6, EncounterJournalID = 398 },
				{ "UBRSAnvilcrack", 7 },
				{ "UBRSRend", 8, EncounterJournalID = 399 },
				{ "UBRSGyth", 9 },
				{ "UBRSBeast", 10, EncounterJournalID = 400 },
				{ "UBRSDrakkisath", 12, EncounterJournalID = 401 },
				{ "UBRSRunewatcher", 14 },
				{ "UBRSFLAME", 16 },
				{ "UBRSTrash", 18 },
				{ "VWOWSets#3", 19, hide = true },
			},
			["Info"] = { ALIL["Upper Blackrock Spire"], "AtlasLootClassicWoW", mapname = "BlackrockSpire", EncounterJournalID = 229 },
		},	

		["DireMaulEnt"] = {
			["Bosses"] = {
				{ "LunarFestival", 7, hide = true },
			},
			["Info"] = { ALIL["Dire Maul"], "AtlasLootWorldEvents" },
		},

		["DireMaulNorth"] = {
			["Bosses"] = {
				{ "DMNGuardMoldar", 4, EncounterJournalID = 411 },
				{ "DMNStomperKreeg", 5, EncounterJournalID = 412 },
				{ "DMNGuardFengus", 6, EncounterJournalID = 413 },
				{ "DMNGuardSlipkik", 7, EncounterJournalID = 414 },
				{ "DMNThimblejack", 8 },
				{ "DMNCaptainKromcrush", 9, EncounterJournalID = 415 },
				{ "DMNKingGordok", 10, EncounterJournalID = 417 },
				{ "DMNChoRush", 11, EncounterJournalID = 416 }, 
				{ "DMNTRIBUTERUN", 13 },
				{ "DMBooks", 14 },
			},
			["Info"] = { ALIL["Dire Maul"].." ("..AL["North"]..")", "AtlasLootClassicWoW", mapname = "DireMaul", EncounterJournalID = 230 },
		},

		["DireMaulEast"] = {
			["Bosses"] = {
				{ "DMELethtendrisPimgib", {8,9}, EncounterJournalID = 404 },
				{ "DMEHydro", 10, EncounterJournalID = 403 },
				{ "DMEZevrimThornhoof", 11, EncounterJournalID = 402 },
				{ "DMEAlzzin", 12, EncounterJournalID = 405 },
				{ "DMEPusillin", {13,14} },
				{ "DMETrash", 17 },
				{ "DMBooks", 18 },
			},
			["Info"] = { ALIL["Dire Maul"].." ("..AL["East"]..")", "AtlasLootClassicWoW", mapname = "DireMaul", EncounterJournalID = 230 },
		},

		["DireMaulWest"] = {
			["Bosses"] = {
				{ "OldKeys", 1, hide = true },
				{ "DMWTendrisWarpwood", 4, EncounterJournalID = 406 },
				{ "DMWMagisterKalendris", 5, EncounterJournalID = 408 },
				{ "DMWIllyannaRavenoak", 6, EncounterJournalID = 407 },
				{ "DMWImmolthar", 8, EncounterJournalID = 409 },
				{ "DMWHelnurath", 9 },
				{ "DMWPrinceTortheldrin", 10, EncounterJournalID = 410 },
				{ "DMWTsuzee", 11 },
				{ "DMWTrash", 23, hide = true },
				{ "DMWTrash", 25 },
				{ "DMBooks", 26 },
			},
			["Info"] = { ALIL["Dire Maul"].." ("..AL["West"]..")", "AtlasLootClassicWoW", mapname = "DireMaul", EncounterJournalID = 230 },
		},

		["Gnomeregan"] = {
			["Bosses"] = {
				{ "GnomereganLoot#1", {4,7,8,9} },
				{ "GnomereganLoot#2", {10}, hide = true },
			},
			["Info"] = { ALIL["Gnomeregan"], "AtlasLootClassicWoW", mapname = "Gnomeregan", EncounterJournalID = 231 },
		},

		["Maraudon"] = {
			["Bosses"] = {
				{ "MaraudonLoot#1", {4,5,6,7,12} },
				{ "MaraudonLoot#2", {8,10,11,12}, hide = true }, 
				{ "LunarFestival", 14, hide = true },
			},
			["Info"] = { ALIL["Maraudon"], "AtlasLootClassicWoW", mapname = "Maraudon", EncounterJournalID = 232 },
		},

		["RagefireChasm"] = {
			["Bosses"] = {
				{ "RagefireChasmLoot", {2,3,4,5} },
			},
			["Info"] = { ALIL["Ragefire Chasm"], "AtlasLootClassicWoW", mapname = "Ragefire", EncounterJournalID = 226 },
		},

		["RazorfenDowns"] = {
			["Bosses"] = {
				{ "RazorfenDownsLoot#1", {3,4,5,8,10} },
				{ "RazorfenDownsLoot#2", {6,7}, hide = true },
			},
			["Info"] = { ALIL["Razorfen Downs"], "AtlasLootClassicWoW", mapname = "RazorfenDowns", EncounterJournalID = 233 },
		},

		["RazorfenKraul"] = {
			["Bosses"] = {
				{ "RazorfenKraulLoot#1", {3,4,5,6,7,10} }, 
				{ "RazorfenKraulLoot#2", {8,11}, hide = true }, 
			},
			["Info"] = { ALIL["Razorfen Kraul"], "AtlasLootClassicWoW", mapname = "RazorfenKraul", EncounterJournalID = 234 },
		},

		["ScarletHalls"] = {
			["Bosses"] = {
				{ "SHBraun", 3, EncounterJournalID = 660 },
				{ "SHHarlan", 4, EncounterJournalID = 654 },
				{ "SHKoegler", 5, EncounterJournalID = 656 },
			},
			["Info"] = { ALIL["Scarlet Halls"], {"AtlasLootClassicWoW", "AtlasLootMoP"}, mapname = "ScarletHalls", EncounterJournalID = 311 },
		},

		["ScarletMonastery"] = {
			["Bosses"] = {
				{ "SMThalnos", 3, EncounterJournalID = 688 },
				{ "SMKorloff", 4, EncounterJournalID = 671 },
				{ "SMWhitemane", 5, EncounterJournalID = 674 },
			},
			["Info"] = { ALIL["Scarlet Monastery"], {"AtlasLootClassicWoW", "AtlasLootMoP"}, mapname = "ScarletMonastery", EncounterJournalID = 316 },
		},

		["Scholomance"] = {
			["Bosses"] = {
				{ "ScholoChillheart", 3, EncounterJournalID = 659 },
				{ "ScholoJandice", 5, EncounterJournalID = 663 },
				{ "ScholoRattlegore", 6, EncounterJournalID = 665 },
				{ "ScholoVoss", {7, 15}, EncounterJournalID = 666 },
				{ "ScholoGandling", 10, EncounterJournalID = 684 },
			},
			["Info"] = { ALIL["Scholomance"], {"AtlasLootClassicWoW", "AtlasLootMoP"}, mapname = "Scholomance", EncounterJournalID = 246 },
		},

		["ShadowfangKeep"] = {
			["Bosses"] = {
				{ "ShadowfangAshbury", 3, EncounterJournalID = 96 },
				{ "ShadowfangSilverlaine", 4, EncounterJournalID = 97 },
				{ "ShadowfangSpringvale", 9, EncounterJournalID = 98 },
				{ "ShadowfangWalden", 10, EncounterJournalID = 99 },
				{ "ShadowfangGodfrey", 11, EncounterJournalID = 100 },
				{ "ApothecaryHummel", 12, hide = true },
				{ "ShadowfangTrash", 21 },
			},
			["Info"] = { ALIL["Shadowfang Keep"], {"AtlasLootClassicWoW", "AtlasLootCataclysm"}, mapname = "ShadowfangKeep", EncounterJournalID = 64 },
		},

		["StratholmeCrusader"] = {
			["Bosses"] = {
				{ "STRATTheUnforgiven", 5, EncounterJournalID = 450 },
				{ "STRATTimmytheCruel", 6, EncounterJournalID = 445 },
				{ "STRATWilleyHopebreaker", 8, EncounterJournalID = 446 },
				{ "STRATInstructorGalford", 9, EncounterJournalID = 448 },
				{ "STRATBalnazzar", 10, EncounterJournalID = 449 },
				{ "STRATSkull", 12 },
				{ "STRATFrasSiabi", 13 },
				{ "STRATHearthsingerForresten", 14, EncounterJournalID = 443 },
				{ "STRATRisenHammersmith", {15,16} },
				{ "LunarFestival", 19, hide = true },
				{ "STRATTrash", 23 },
				{ "VWOWSets#2", {17,18,20,21}, hide = true },
			},
			["Info"] = { ALIL["Stratholme"].." - "..AL["Crusader's Square"], "AtlasLootClassicWoW", mapname = "Stratholme", EncounterJournalID = 236 },
		},

		["StratholmeGauntlet"] = {
			["Bosses"] = {
				{ "STRATBaronessAnastari", 3, EncounterJournalID = 451 },
				{ "STRATNerubenkan", 4, EncounterJournalID = 452 },
				{ "STRATMalekithePallid", 5, EncounterJournalID = 453 },
				{ "STRATMagistrateBarthilas", 6, EncounterJournalID = 454 },
				{ "STRATRamsteintheGorger", 7, EncounterJournalID = 455 },
				{ "STRATLordAuriusRivendare", 8, EncounterJournalID = 456 },
				{ "STRATBlackGuardSwordsmith", {9,10} },
				{ "STRATStonespine", },
				{ "STRATTrash", 16 },
			},
			["Info"] = { ALIL["Stratholme"].." - "..AL["The Gauntlet"], "AtlasLootClassicWoW", mapname = "Stratholme", EncounterJournalID = 236 },
		},

		["TheDeadminesEnt"] = "TheDeadminesEaI",
		["TheDeadmines"] = "TheDeadminesEaI",
		["TheDeadminesEaI"] = {
			["TheDeadminesEnt"] = {
				{ "DeadminesTrash", {4,5}, hide = true },
			},
			["TheDeadmines"] = {
				{ "DeadminesGlubtok", 3, EncounterJournalID = 89 },
				{ "DeadminesGearbreaker", 5, EncounterJournalID = 90 },
				{ "DeadminesFoeReaper", 6, EncounterJournalID = 91 },
				{ "DeadminesRipsnarl", 7, EncounterJournalID = 92 },
				{ "DeadminesCookie", 8, EncounterJournalID = 93 },
				{ "DeadminesVanessa", 9, EncounterJournalID = 95 },
				{ "DeadminesTrash", 18 },
			},
			["Info"] = { ALIL["The Deadmines"], {"AtlasLootClassicWoW", "AtlasLootCataclysm"}, sortOrder = { "TheDeadminesEnt", "TheDeadmines" }, mapname = "TheDeadmines", EncounterJournalID = 63 },
		},

		["TheStockade"] = {
			["Bosses"] = {
				{ "Stockade", {2,3,4} },
			},
			["Info"] = { ALIL["The Stockade"], "AtlasLootClassicWoW", mapname = "TheStockade", EncounterJournalID = 238 },
		},

		["TheSunkenTemple"] = {
			["Bosses"] = { 
				{ "STAvatarofHakkar", 3, EncounterJournalID = 457 },
				{ "STJammalanandOgom", {4,5}, EncounterJournalID = 458 },
				{ "STDragons", {6,7,8,9}, EncounterJournalID = 459 },
				{ "STEranikus", 10, EncounterJournalID = 463 },
				{ "LunarFestival", 12, hide = true },
				{ "STTrash", 14 },
			},
			["Info"] = { ALIL["The Temple of Atal'Hakkar"], "AtlasLootClassicWoW", mapname = "TempleOfAtalHakkar", EncounterJournalID = 237 },
		},

		["Uldaman"] = {
			["Bosses"] = {
				{ "UldDwarves", {5,6,7}, EncounterJournalID = 468 },
				{ "UldamanLoot", 9, EncounterJournalID = 467 },
				{ "UldamanLoot", 10, EncounterJournalID = 469, hide = true },
				{ "UldTrash", 11, EncounterJournalID = 748, hide = true },
				{ "UldamanLoot", 12, EncounterJournalID = 470, hide = true },
				{ "UldamanLoot", 13, EncounterJournalID = 471, hide = true },
				{ "UldamanLoot", 14, EncounterJournalID = 472, hide = true },
				{ "UldamanLoot", 15, EncounterJournalID = 473, hide = true },
				{ "UldTrash", 25 },
			},
			["Info"] = { ALIL["Uldaman"], "AtlasLootClassicWoW", mapname = "Uldaman", EncounterJournalID = 239 },
		},

		["WailingCavernsEnt"] = "WailingCavernsEaI",
		["WailingCaverns"] = "WailingCavernsEaI",
		["WailingCavernsEaI"] = {
			["WailingCavernsEnt"] = {
				{ "WailingCavernsLoot#1", 3, hide = true },
			},
			["WailingCaverns"] = {
				{ "WailingCavernsLoot#1", {2,3,4,5} },
				{ "WailingCavernsLoot#2", {6,7,8,10,11}, hide = true },
				{ "VWOWSets#1", 16, hide = true },
			},
			["Info"] = { ALIL["Wailing Caverns"], "AtlasLootClassicWoW", sortOrder = { "WailingCavernsEnt", "WailingCaverns" }, mapname = "WailingCaverns", EncounterJournalID = 240 },
		},

		["ZulFarrak"] = {
			["Bosses"] = {
				{ "ZFGahzrilla", 5 },
				{ "ZFSezzziz", 12 },
				{ "ZFChiefUkorzSandscalp", 13 },
				{ "ZFWitchDoctorZumrah", 15 },
				{ "ZFAntusul", 16 },
				{ "ZFHydromancerVelratha", 18 },
				{ "ZFDustwraith", 20 },
				{ "ZFZerillis", 21 },
				{ "LunarFestival", 22, hide = true },
				{ "ZFTrash", 24 },
			},
			["Info"] = { ALIL["Zul'Farrak"], "AtlasLootClassicWoW", mapname = "ZulFarrak", EncounterJournalID = 241 },
		},

		-------------
		--- Raids ---
		-------------

		["BlackwingLair"] = {
			["Bosses"] = {
				{ "BWLRazorgore", 6 },
				{ "BWLVaelastrasz", 7 },
				{ "BWLLashlayer", 8 },
				{ "BWLFiremaw", 9 },
				{ "BWLEbonroc", 10 },
				{ "BWLTrashMobs",  11, hide = true },
				{ "BWLFlamegor", 12 },
				{ "BWLChromaggus", 13 },
				{ "BWLNefarian", 14 },
				{ "BWLTrashMobs",  16 },
				{ "T1T2T3SET", 17, hide = true },
			},
			["Info"] = { ALIL["Blackwing Lair"], "AtlasLootClassicWoW", mapname = "BlackwingLair", raid = true },
		},

		["MoltenCore"] = {
			["Bosses"] = {
				{ "BloodsailHydraxian", 2, hide = true },
				{ "MCLucifron", 4 },
				{ "MCMagmadar", 5 },
				{ "MCGehennas", 6 },
				{ "MCGarr", 7 },
				{ "MCShazzrah", 8 },
				{ "MCGeddon", 9 },
				{ "MCGolemagg", 10 },
				{ "MCSulfuron", 11 },
				{ "MCMajordomo", 12 },
				{ "MCRagnaros", 13 },
				{ "T1T2T3SET", 15, hide = true },
				{ "MCRANDOMBOSSDROPPS", 16 },
				{ "MCTrashMobs", 17 },
			},
			["Info"] = { ALIL["Molten Core"], "AtlasLootClassicWoW", mapname = "MoltenCore", raid = true },
		},

		["TheTempleofAhnQiraj"] = {
			["Bosses"] = {
				{ "AQBroodRings", 1, hide = true },
				{ "AQ40Skeram", 4 },
				{ "AQ40BugFam", {5,6,7,8} },
				{ "AQ40Sartura", 9 },
				{ "AQ40Fankriss", 10 },
				{ "AQ40Viscidus", 11 },
				{ "AQ40Huhuran", 12 },
				{ "AQ40Emperors", {13,14,15} },
				{ "AQ40Ouro", 17 },
				{ "AQ40CThun", {18,19} },
				{ "AQ40Trash", 28 },
				{ "AQ40Sets", 29, hide = true },
				{ "AQEnchants", 30 },
			},
			["Info"] = { ALIL["Temple of Ahn'Qiraj"], "AtlasLootClassicWoW", mapname = "TempleofAhnQiraj", raid = true },
		},

		["TheRuinsofAhnQiraj"] = {
			["Bosses"] = {
				{ "CenarionCircle", 1, hide = true },
				{ "AQ20Kurinnaxx", 3 },
				{ "AQ20Rajaxx", {6,7,8,9,10,11,12,13} },
				{ "AQ20Moam", 14 },
				{ "AQ20Buru", 15 },
				{ "AQ20Ayamiss", 16 },
				{ "AQ20Ossirian", 17 },
				{ "AQ20Trash", 20 },
				{ "AQ20Sets", 21, hide = true },
				{ "AQEnchants", 22 },
			},
			["Info"] = { ALIL["Ruins of Ahn'Qiraj"], "AtlasLootClassicWoW", mapname = "RuinsofAhnQiraj", raid = true },
		},
	},

	---------------------
	--- Battlegrounds ---
	---------------------

	["Battlegrounds"] = {

		["AlteracValleyNorth"] = {
			["Bosses"] = {
				{ "MiscFactions", 1 },
				{ "AVMisc", 48 },
				{ "AVBlue", 49 },
			},
			["Info"] = { ALIL["Alterac Valley"], "AtlasLootClassicWoW" },
		},

		["AlteracValleySouth"] = {
			["Bosses"] = {
				{ "MiscFactions", 1 },
				{ "AVMisc", 31 },
				{ "AVBlue", 32 },
			},
			["Info"] = { ALIL["Alterac Valley"], "AtlasLootClassicWoW" },
		},

		["ArathiBasin"] = {
			["Bosses"] = {
				{ "MiscFactions", {1,2} },
				{ "AB2039", 11 },
				{ "AB4049", 12 },
				{ "ABSets", 13 },
				{ "ABMisc", 14 },
			},
			["Info"] = { ALIL["Arathi Basin"], "AtlasLootClassicWoW" },
		},

		["HalaaPvP"] = {
			["Bosses"] = {
				{ "Nagrand", 1 },
			},
			["Info"] = { ALIL["Nagrand"]..": "..AL["Halaa"], "AtlasLootBurningCrusade" },
		},

		["HellfirePeninsulaPvP"] = {
			["Bosses"] = {
				{ "Hellfire", 1 },
			},
			["Info"] = { ALIL["Hellfire Peninsula"]..": "..AL["Hellfire Fortifications"], "AtlasLootBurningCrusade" },
		},

		["TerokkarForestPvP"] = {
			["Bosses"] = {
				{ "Terokkar", 1 },
			},
			["Info"] = { ALIL["Terokkar Forest"]..": "..AL["Spirit Towers"], "AtlasLootBurningCrusade" },
		},

		["ZangarmarshPvP"] = {
			["Bosses"] = {
				{ "Zangarmarsh", 1 },
			},
			["Info"] = { ALIL["Zangarmarsh"]..": "..AL["Twin Spire Ruins"], "AtlasLootBurningCrusade" },
		},

		["WintergraspPvP"] = {
			["Bosses"] = {
				{ "LakeWintergrasp", 1 },
			},
			["Info"] = { ALIL["Wintergrasp"], "AtlasLootWotLK" },
		},

		["TolBarad"] = {
			["Bosses"] = {
				{ "BaradinsWardens", 1 },
				{ "HellscreamsReach", 2 },
			},
			["Info"] = { ALIL["Tol Barad"], "AtlasLootCataclysm" },
		},

		["TwinPeaks"] = {
			["Bosses"] = {
				{ "WildhammerClan", 1 },
				{ "DragonmawClan", 2 },
			},
			["Info"] = { ALIL["Twin Peaks"], "AtlasLootCataclysm" },
		},
	},

	["PVP"] = {
		["AlteracValley"] = {
			["Bosses"] = {
				{ "AVMisc" },
				{ "AVBlue" },
			},
			["Info"] = { ALIL["Alterac Valley"].." "..AL["Rewards"], "AtlasLootClassicWoW"},
		},

		["WarsongGulch"] = {
			["Bosses"] = {
				{ "WSGMisc", 6 },
				{ "WSGAccessories", 7 },
				{ "WSGWeapons", 8 },
				{ "WSGArmor", 9 },
			},
			["Info"] = { ALIL["Warsong Gulch"].." "..AL["Rewards"], "AtlasLootClassicWoW"},
		},
	},

	--------------------
	--- World Bosses ---
	--------------------

	["WorldBosses"] = {

		["DoomLordKazzak"] = {
			["Bosses"] = {
				{ "WorldBossesBC", 1 },
				{ "Thrallmar", 5, hide = true },
			},
			["Info"] = { BabbleBoss["Doom Lord Kazzak"], "AtlasLootBurningCrusade" },
		},

		["Doomwalker"] = {
			["Bosses"] = {
				{ "WorldBossesBC", 1 },
			},
			["Info"] = { BabbleBoss["Doomwalker"], "AtlasLootBurningCrusade" },
		},

		["Skettis"] = {
			["Bosses"] = {
				{ "Terokk", 9 },
				{ "DarkscreecherAkkarai", 18 },
				{ "GezzaraktheHuntress", 19 },
				{ "Karrog", 20 },
				{ "VakkiztheWindrager", 21 },
			},
			["Info"] = { AL["Skettis"], "AtlasLootWorldEvents" },
		},
	},

	--------------------
	--- World Events ---
	--------------------

	["WorldEvents"] = {

		["MidsummerFestival"] = {
			["Bosses"] = {
				{ "MidsummerFestival" },
				{ "LordAhune" },
			},
			["Info"] = { AL["Midsummer Fire Festival"], "AtlasLootWorldEvents"},
		},
	},

	----------------
	--- Crafting ---
	----------------

	["Crafting"] = {

		["Leatherworking"] = {
			["Bosses"] = {
				{ "Dragonscale" },
				{ "Elemental" },
				{ "Tribal" },
			},
			["Info"] = { LEATHERWORKING, "AtlasLootCrafting"},
		},

		["Tailoring"] = {
			["Bosses"] = {
				{ "Mooncloth" },
				{ "Shadoweave" },
				{ "Spellfire" },
			},
			["Info"] = { TAILORING, "AtlasLootCrafting"},
		},

		["BlacksmithingMail"] = {
			["Bosses"] = {
				{ "BlacksmithingMailBloodsoulEmbrace" },
				{ "BlacksmithingMailFelIronChain" },
			},
			["Info"] = { BLACKSMITHING..": "..BabbleInventory["Mail"], "AtlasLootCrafting"},
		},

		["BlacksmithingPlate"] = {
			["Bosses"] = {
				{ "BlacksmithingPlateImperialPlate" },
				{ "BlacksmithingPlateTheDarksoul" },
				{ "BlacksmithingPlateFelIronPlate" },
				{ "BlacksmithingPlateAdamantiteB" },
				{ "BlacksmithingPlateFlameG" },
				{ "BlacksmithingPlateEnchantedAdaman" },
				{ "BlacksmithingPlateKhoriumWard" },
				{ "BlacksmithingPlateFaithFelsteel" },
				{ "BlacksmithingPlateBurningRage" },
				{ "BlacksmithingPlateOrnateSaroniteBattlegear" },
				{ "BlacksmithingPlateSavageSaroniteBattlegear" },
			},
			["Info"] = { BLACKSMITHING..": "..BabbleInventory["Plate"], "AtlasLootCrafting"},
		},

		["LeatherworkingLeather"] = {
			["Bosses"] = {
				{ "LeatherworkingLeatherVolcanicArmor" },
				{ "LeatherworkingLeatherIronfeatherArmor" },
				{ "LeatherworkingLeatherStormshroudArmor" },
				{ "LeatherworkingLeatherDevilsaurArmor" },
				{ "LeatherworkingLeatherBloodTigerH" },
				{ "LeatherworkingLeatherPrimalBatskin" },
				{ "LeatherworkingLeatherWildDraenishA" },
				{ "LeatherworkingLeatherThickDraenicA" },
				{ "LeatherworkingLeatherFelSkin" },
				{ "LeatherworkingLeatherSClefthoof" },
				{ "LeatherworkingLeatherPrimalIntent" },
				{ "LeatherworkingLeatherWindhawkArmor" },
				{ "LeatherworkingLeatherBoreanEmbrace" },
				{ "LeatherworkingLeatherIceborneEmbrace" },
				{ "LeatherworkingLeatherEvisceratorBattlegear" },
				{ "LeatherworkingLeatherOvercasterBattlegear" },
			},
			["Info"] = { LEATHERWORKING..": "..BabbleInventory["Leather"], "AtlasLootCrafting"},
		},

		["LeatherworkingMail"] = {
			["Bosses"] = {
				{ "LeatherworkingMailGreenDragonM" },
				{ "LeatherworkingMailBlueDragonM" },
				{ "LeatherworkingMailBlackDragonM" },
				{ "LeatherworkingMailScaledDraenicA" },
				{ "LeatherworkingMailFelscaleArmor" },
				{ "LeatherworkingMailFelstalkerArmor" },
				{ "LeatherworkingMailNetherFury" },
				{ "LeatherworkingMailNetherscaleArmor" },
				{ "LeatherworkingMailNetherstrikeArmor" },
				{ "LeatherworkingMailFrostscaleBinding" },
				{ "LeatherworkingMailNerubianHive" },
				{ "LeatherworkingMailStormhideBattlegear" },
				{ "LeatherworkingMailSwiftarrowBattlefear" },
			},
			["Info"] = { LEATHERWORKING..": "..BabbleInventory["Mail"], "AtlasLootCrafting"},
		},

		["TailoringSets"] = {
			["Bosses"] = {
				{ "TailoringBloodvineG" },
				{ "TailoringNeatherVest" },
				{ "TailoringImbuedNeather" },
				{ "TailoringArcanoVest" },
				{ "TailoringTheUnyielding" },
				{ "TailoringWhitemendWis" },
				{ "TailoringSpellstrikeInfu" },
				{ "TailoringBattlecastG" },
				{ "TailoringSoulclothEm" },
				{ "TailoringPrimalMoon" },
				{ "TailoringShadowEmbrace" },
				{ "TailoringSpellfireWrath" },
				{ "TailoringFrostwovenPower" },
				{ "TailoringDuskweaver" },
				{ "TailoringFrostsavageBattlegear" },
			},
			["Info"] = { TAILORING..": "..BabbleInventory["Cloth"], "AtlasLootCrafting"},
		},
	},

	-------------------
	--- Collections ---
	-------------------

	["Misc"] = {
		["Pets"] = {
			["Bosses"] = {
				{ "PetsMerchant" },
				{ "PetsQuest" },
				{ "PetsCrafted" },
				{ "PetsAchievement" },
				{ "PetsFaction" },
				{ "PetsRare" },
				{ "PetsEvent" },
				{ "PetsPromotional" },
				{ "PetsCardGame" },
				{ "PetsPetStore" },
				{ "PetsRemoved" },
				{ "PetsNEW" },
				{ "PetsAccessories" },
			},
			["Info"] = { BabbleInventory["Companions"], "AtlasLootMoP"},
		},

		["Mounts"] = {
			["Bosses"] = {
				{ "MountsFaction" },
				{ "MountsPvP" },
				{ "MountsRareDungeon" },
				{ "MountsRareRaid" },
				{ "MountsAchievement" },
				{ "MountsCraftQuest" },
				{ "MountsCardGame" },
				{ "MountsPromotional" },
				{ "MountsEvent" },
				{ "MountsRemoved" },
				{ "MountsNEW" },
			},
			["Info"] = { BabbleInventory["Mounts"], "AtlasLootMoP"},
		},

		["Tabards"] = {
			["Bosses"] = {
				{ "TabardsAlliance" },
				{ "TabardsHorde" },
				{ "TabardsNeutralFaction" },
				{ "TabardsAchievementQuestRare" },
				{ "TabardsRemoved" },
			},
			["Info"] = { BabbleInventory["Tabards"], "AtlasLootMoP"},
		},
		
		["TransformationItems"] = {
			["Bosses"] = {
				{ "TransformationNonconsumedItems" },
				{ "TransformationConsumableItems" },
				{ "TransformationAdditionalEffects" },
			},
			["Info"] = { AL["Transformation Items"], "AtlasLootMoP"},
		},

		["WorldEpics"] = {
			["Bosses"] = {
				{ "WorldEpics90" },
				{ "WorldEpics85" },
				{ "WorldEpics80" },
				{ "WorldEpics70" },
				{ "WorldEpics5060" },
				{ "WorldEpics4049" },
				{ "WorldEpics3039" },
			},
			["Info"] = { AL["BoE World Epics"], "AtlasLootMoP"},
		},
	},

	["TierSets"] = {
		["TierSetsMenus"] = {
			["Bosses"] = {
				{ "T1T2T3SET" },
				{ "T456SET" },
				{ "T7T8SET" },
				{ "T9SET" },
				{ "T10SET" },
				{ "T1112SET" },
				{ "T13SET" },
				{ "T14SET" },
				{ "T15SET" },
				{ "T16SET" },
			},
			["Info"] = { AL["Tier Sets"], "AtlasLootMoP"},
		},
	},
}

AtlasLoot_LootTableRegister["Instances"]["EmptyPage"] = {
	["Bosses"] = {{"EmptyPage"}},
	["Info"] = { "EmptyPage" },
}

AtlasLoot_Data["EmptyPage"] = {
	["Normal"] = {{}};
	info = {
		name = "EmptyPage",
		instance = "EmptyPage",
	};
}