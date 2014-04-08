-- $Id: RepMenus.lua 4243 2013-09-08 12:10:13Z hegarol $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")

	AtlasLoot_Data["REPMENU"] = {
		["Normal"] = {
			{
				{ 1, "REPMENU_RACEFACTIONS", "inv_misc_tournaments_symbol_human", "=ds="..FACTION_ALLIANCE.." / "..FACTION_HORDE, ""};
				{ 2, "REPMENU_ORIGINALWOW", "INV_Helmet_66", "=ds="..AL["Classic WoW"], ""};
				{ 3, "REPMENU_WOTLK", "achievement_reputation_kirintor", "=ds="..AL["Wrath of the Lich King"], ""};
				{ 5, "KirinTorOffensive", "achievement_reputation_kirintor_offensive", "=ds="..ALIL["Kirin Tor Offensive"], "=q5="..ALIL["Isle of Thunder"]};
				{ 6, "OperationShieldwall", "pvpcurrency-honor-alliance", "=ds="..ALIL["Operation: Shieldwall"], "=q5="..ALIL["Krasarang Wilds"]};
				{ 7, "LionsLanding", "pvpcurrency-conquest-alliance", "=ds="..ALIL["Lion's Landing"], "=q5="..ALIL["Krasarang Wilds"]};
				{ 8, "BizmosBrawlpubBrawlgarArena", "inv_misc_head_clockworkgnome_01", "=ds="..ALIL["Bizmo's Brawlpub"], "=q5="..ALIL["Deeprun Tram"]};
				{ 10, "Anglers", "achievement_faction_anglers", "=ds="..ALIL["The Anglers"], "=q5="..ALIL["Krasarang Wilds"]};
				{ 11, "EmperorShaohao", "ability_monk_quipunch", "=ds="..ALIL["Emperor Shaohao"], "=q5="..ALIL["Timeless Isle"]};
				{ 12, "Klaxxi", "achievement_faction_klaxxi", "=ds="..ALIL["The Klaxxi"], "=q5="..ALIL["Dread Wastes"]};
				{ 13, "OrderCloudSerpent", "achievement_faction_serpentriders", "=ds="..ALIL["Order of the Cloud Serpent"], "=q5="..ALIL["The Jade Forest"]};
				{ 14, "ShadoPan", "achievement_faction_shadopan", "=ds="..ALIL["Shado-Pan"], "=q5="..ALIL["Townlong Steppes"]};
				{ 16, "REPMENU_BURNINGCRUSADE", "INV_Misc_Ribbon_01", "=ds="..AL["Burning Crusade"], ""};
				{ 17, "REPMENU_CATACLYSM", "inv_neck_hyjaldaily_04", "=ds="..AL["Cataclysm"], ""};
				{ 18, "VPMOPMENU", "pvecurrency-valor", "=ds="..AL["Valor Points"].." "..AL["Rewards"], "=q5="..AL["Mists of Pandaria"]};
				{ 20, "SunreaverOnslaught", "achievement_faction_sunreaveronslaught", "=ds="..ALIL["Sunreaver Onslaught"], "=q5="..ALIL["Isle of Thunder"]};
				{ 21, "DominanceOffensive", "pvpcurrency-honor-horde", "=ds="..ALIL["Dominance Offensive"], "=q5="..ALIL["Krasarang Wilds"]};
				{ 22, "DominationPoint", "pvpcurrency-conquest-horde", "=ds="..ALIL["Domination Point"], "=q5="..ALIL["Krasarang Wilds"]};
				{ 23, "BizmosBrawlpubBrawlgarArena", "inv_misc_head_clockworkgnome_01", "=ds="..ALIL["Brawl'gar Arena"], "=q5="..ALIL["Brawl'gar Arena"]};
				{ 25, "AugustCelestials", "achievement_faction_celestials", "=ds="..ALIL["The August Celestials"], "=q5="..ALIL["Vale of Eternal Blossoms"]};
				{ 26, "GoldenLotus", "achievement_faction_goldenlotus", "=ds="..ALIL["Golden Lotus"], "=q5="..ALIL["Vale of Eternal Blossoms"]};
				{ 27, "Lorewalkers", "achievement_faction_lorewalkers", "=ds="..ALIL["The Lorewalkers"], "=q5="..ALIL["Vale of Eternal Blossoms"]};
				{ 28, "ShadoPanAssault", "achievement_faction_shadopan", "=ds="..ALIL["Shado-Pan Assault"], "=q5="..ALIL["Throne of Thunder"]};
				{ 29, "Tillers", "achievement_faction_tillers", "=ds="..ALIL["The Tillers"], "=q5="..ALIL["Valley of the Four Winds"]};
			};
		};
		info = {
			name = AL["Factions"],
		};
	}

	AtlasLoot_Data["REPMENU_RACEFACTIONS"] = {
		["Normal"] = {
			{
				{ 2, "", "inv_misc_tournaments_symbol_human", "=q6="..FACTION_ALLIANCE, ""};
				{ 3, "Darnassus", "inv_misc_tournaments_symbol_nightelf", "=ds="..ALIL["Darnassus"], "=q5="..AL["Classic WoW"]};
				{ 4, "GnomereganRep", "inv_misc_tournaments_symbol_gnome", "=ds="..ALIL["Gnomeregan"], "=q5="..AL["Classic WoW"]};
				{ 5, "Ironforge", "inv_misc_tournaments_symbol_dwarf", "=ds="..ALIL["Ironforge"], "=q5="..AL["Classic WoW"]};
				{ 6, "Stormwind", "inv_misc_tournaments_symbol_human", "=ds="..ALIL["Stormwind"], "=q5="..AL["Classic WoW"]};
				{ 8, "Exodar", "inv_misc_tournaments_symbol_draenei", "=ds="..ALIL["Exodar"], "=q5="..AL["Burning Crusade"]};
				{ 10, "Gilneas", "achievement_win_gilneas", "=ds="..ALIL["Gilneas"], "=q5="..AL["Cataclysm"]};
				{ 12, "TushuiPandaren", "inv_misc_tournaments_symbol_human", "=ds="..ALIL["Tushui Pandaren"], "=q5="..AL["Mists of Pandaria"]};
				{ 17, "", "inv_misc_tournaments_symbol_orc", "=q6="..FACTION_HORDE, ""};
				{ 18, "DarkspearTrolls", "inv_misc_tournaments_symbol_troll", "=ds="..ALIL["Darkspear Trolls"], "=q5="..AL["Classic WoW"]};
				{ 19, "Orgrimmar", "inv_misc_tournaments_symbol_orc", "=ds="..ALIL["Orgrimmar"], "=q5="..AL["Classic WoW"]};
				{ 20, "ThunderBluff", "inv_misc_tournaments_symbol_tauren", "=ds="..ALIL["Thunder Bluff"], "=q5="..AL["Classic WoW"]};
				{ 21, "Undercity", "inv_misc_tournaments_symbol_scourge", "=ds="..ALIL["Undercity"], "=q5="..AL["Classic WoW"]};
				{ 23, "SilvermoonCity", "inv_misc_tournaments_symbol_bloodelf", "=ds="..ALIL["Silvermoon City"], "=q5="..AL["Burning Crusade"]};
				{ 25, "BilgewaterCartel", "inv_misc_tabard_kezan", "=ds="..ALIL["Bilgewater Cartel"], "=q5="..AL["Cataclysm"]};
				{ 27, "HuojinPandaren", "inv_misc_tournaments_symbol_orc", "=ds="..ALIL["Huojin Pandaren"], "=q5="..AL["Mists of Pandaria"]};
			};
		};
		info = {
			name = AL["Factions"].." - "..FACTION_ALLIANCE.." / "..FACTION_HORDE,
			menu = "REPMENU",
		};
	}

	AtlasLoot_Data["REPMENU_ORIGINALWOW"] = {
		["Normal"] = {
			{
				{ 2, "MiscFactions", "ability_warrior_rallyingcry", "=ds="..ALIL["The League of Arathor"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Arathi Basin"]};
				{ 3, "MiscFactions", "inv_jewelry_stormpiketrinket_05", "=ds="..ALIL["Stormpike Guard"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Alterac Valley"]};
				{ 4, "MiscFactions", "Ability_Mount_PinkTiger", "=ds="..ALIL["Wintersaber Trainers"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Winterspring"]};
				{ 6, "ArgentDawn", "inv_jewelry_talisman_07", "=ds="..ALIL["Argent Dawn"], "=q5="..ALIL["Eastern Plaguelands"]};
				{ 7, "Timbermaw", "achievement_reputation_timbermaw", "=ds="..ALIL["Timbermaw Hold"], "=q5="..ALIL["Felwood"].." / "..ALIL["Winterspring"]};
				{ 9, "AQBroodRings", "inv_misc_head_dragon_bronze", "=ds="..ALIL["Brood of Nozdormu"], "=q5="..ALIL["Temple of Ahn'Qiraj"].." / "..AL["Caverns of Time"]};
				{ 17, "MiscFactions", "spell_shadow_psychichorrors", "=ds="..ALIL["The Defilers"], "=q5="..FACTION_HORDE.." - "..ALIL["Arathi Basin"]}; 
				{ 18, "MiscFactions", "inv_jewelry_frostwolftrinket_05", "=ds="..ALIL["Frostwolf Clan"], "=q5="..FACTION_HORDE.." - "..ALIL["Alterac Valley"]};
				{ 21, "BloodsailBuccaneers", "INV_Helmet_66", "=ds="..ALIL["Bloodsail Buccaneers"], "=q5="..ALIL["Stranglethorn Vale"]};
				{ 22, "CenarionCircle", "ability_racial_ultravision", "=ds="..ALIL["Cenarion Circle"], "=q5="..ALIL["Silithus"]};
				{ 24, "ThoriumBrotherhood", "INV_Ingot_Mithril", "=ds="..ALIL["Thorium Brotherhood"], "=q5="..ALIL["Searing Gorge"]};
			};
		};
		info = {
			name = AL["Factions"].." - "..AL["Classic WoW"],
			menu = "REPMENU",
		};
	}

	AtlasLoot_Data["REPMENU_BURNINGCRUSADE"] = {
		["Normal"] = {
			{
				{ 2, "HonorHold", "INV_BannerPVP_02", "=ds="..ALIL["Honor Hold"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Hellfire Peninsula"]};
				{ 3, "Kurenai", "INV_Misc_Foot_Centaur", "=ds="..ALIL["Kurenai"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Nagrand"]};
				{ 6, "CExpedition", "INV_Misc_Ammo_Arrow_02", "=ds="..ALIL["Cenarion Expedition"], "=q5="..ALIL["Zangarmarsh"]};
				{ 7, "KeepersofTime", "Ability_Warrior_VictoryRush", "=ds="..ALIL["Keepers of Time"], "=q5="..AL["Caverns of Time"]};
				{ 8, "Netherwing", "Ability_Mount_Netherdrakepurple", "=ds="..ALIL["Netherwing"], "=q5="..ALIL["Shadowmoon Valley"]};
				{ 9, "Skyguard", "ability_hunter_pet_netherray", "=ds="..ALIL["Sha'tari Skyguard"], "=q5="..ALIL["Terokkar Forest"].." / "..ALIL["Blade's Edge Mountains"]};
				{ 10, "Sporeggar", "inv_mushroom_11", "=ds="..ALIL["Sporeggar"], "=q5="..ALIL["Zangarmarsh"]};
				{ 12, "Aldor", "INV_Jewelry_Talisman_08", "=ds="..ALIL["The Aldor"], ""};
				{ 14, "Ashtongue", "achievement_reputation_ashtonguedeathsworn", "=ds="..ALIL["Ashtongue Deathsworn"], "=q5="..ALIL["Shadowmoon Valley"].." / "..ALIL["Black Temple"]};
				{ 15, "VioletEye", "spell_holy_mindsooth", "=ds="..ALIL["The Violet Eye"], "=q5="..ALIL["Karazhan"]};
				{ 17, "Thrallmar", "INV_BannerPVP_01", "=ds="..ALIL["Thrallmar"], "=q5="..FACTION_HORDE.." - "..ALIL["Hellfire Peninsula"]};
				{ 18, "Maghar", "INV_Misc_Foot_Centaur", "=ds="..ALIL["The Mag'har"], "=q5="..FACTION_HORDE.." - "..ALIL["Nagrand"]};
				{ 19, "Tranquillien", "INV_Misc_Bandana_03", "=ds="..ALIL["Tranquillien"], "=q5="..FACTION_HORDE.." - "..ALIL["Ghostlands"]};
				{ 21, "Consortium", "inv_enchant_shardprismaticlarge", "=ds="..ALIL["The Consortium"], "=q5="..ALIL["Nagrand"].." / "..ALIL["Netherstorm"]};
				{ 22, "LowerCity", "Spell_Holy_ChampionsBond", "=ds="..ALIL["Lower City"], ""};
				{ 23, "Ogrila", "inv_misc_apexis_crystal", "=ds="..ALIL["Ogri'la"], "=q5="..ALIL["Blade's Edge Mountains"]};
				{ 24, "Shatar", "Ability_Warrior_ShieldMastery", "=ds="..ALIL["The Sha'tar"], ""};
				{ 25, "SunOffensive", "inv_shield_48", "=ds="..ALIL["Shattered Sun Offensive"], "=q5="..ALIL["Isle of Quel'Danas"]};
				{ 27, "Scryer", "INV_Misc_Foot_Centaur", "=ds="..ALIL["The Scryers"], ""};
				{ 29, "ScaleSands", "inv_enchant_dustillusion", "=ds="..ALIL["The Scale of the Sands"], "=q5="..ALIL["Hyjal Summit"]};
			};
		};
		info = {
			name = AL["Factions"].." - "..AL["Burning Crusade"],
			menu = "REPMENU",
		};
	}

	AtlasLoot_Data["REPMENU_WOTLK"] = {
		["Normal"] = {
			{
				{ 2, "AllianceVanguard", "spell_misc_hellifrepvphonorholdfavor", "=ds="..ALIL["Alliance Vanguard"], "=q5="..FACTION_ALLIANCE};
				{ 3, "ExplorersLeagueWarsongOffensive", "inv_drink_01", "=ds="..ALIL["Explorers' League"], "=q5="..ALIL["The Storm Peaks"]};
				{ 4, "ArgentTournamentFaction", "inv_misc_tabardpvp_01", "=ds="..ALIL["The Silver Covenant"], "=q5="..ALIL["Icecrown"].." / "..ALIL["Dalaran"]};
				{ 6, "ArgentCrusade", "INV_Jewelry_Talisman_08", "=ds="..ALIL["Argent Crusade"], "=q5="..ALIL["Zul'Drak"].." / "..ALIL["Icecrown"]};
				{ 7, "KirinTor", "achievement_reputation_kirintor", "=ds="..ALIL["Kirin Tor"], "=q5="..ALIL["Borean Tundra"].." / "..ALIL["Dalaran"]};
				{ 8, "TheSonsofHodir", "Spell_Holy_DivinePurpose", "=ds="..ALIL["The Sons of Hodir"], "=q5="..ALIL["The Storm Peaks"]};
				{ 9, "TheWyrmrestAccord", "achievement_reputation_wyrmresttemple", "=ds="..ALIL["The Wyrmrest Accord"], "=q5="..ALIL["Dragonblight"]};
				{ 11, "FrenzyheartTribe", "ability_mount_whitedirewolf", "=ds="..ALIL["Frenzyheart Tribe"], "=q5="..ALIL["Sholazar Basin"]};
				{ 13, "TheAshenVerdict", "INV_Jewelry_Ring_85", "=ds="..ALIL["The Ashen Verdict"], "=q5="..ALIL["Icecrown Citadel"]};
				{ 17, "HordeExpedition", "spell_misc_hellifrepvpthrallmarfavor", "=ds="..ALIL["Horde Expedition"], "=q5="..FACTION_HORDE};
				{ 18, "ExplorersLeagueWarsongOffensive", "inv_drink_01", "=ds="..ALIL["Warsong Offensive"], "=q5="..ALIL["The Storm Peaks"]};
				{ 19, "ArgentTournamentFaction", "inv_misc_tabardpvp_02", "=ds="..ALIL["The Sunreavers"], "=q5="..ALIL["Icecrown"].." / "..ALIL["Dalaran"]};
				{ 21, "TheKaluak", "achievement_reputation_tuskarr", "=ds="..ALIL["The Kalu'ak"], "=q5="..ALIL["Borean Tundra"].." / "..ALIL["Howling Fjord"].." / "..ALIL["Dragonblight"]};
				{ 22, "KnightsoftheEbonBlade", "achievement_reputation_knightsoftheebonblade", "=ds="..ALIL["Knights of the Ebon Blade"], "=q5="..ALIL["Zul'Drak"].." / "..ALIL["Icecrown"]};
				{ 23, "WinterfinRetreat", "INV_Misc_Shell_04", "=ds="..AL["Winterfin Retreat"], "=q5="..ALIL["Borean Tundra"]};
				{ 26, "TheOracles", "inv_misc_head_murloc_01", "=ds="..ALIL["The Oracles"], "=q5="..ALIL["Sholazar Basin"]};
			};
		};
		info = {
			name = AL["Factions"].." - "..AL["Wrath of the Lich King"],
			menu = "REPMENU",
		};
	}

	AtlasLoot_Data["REPMENU_CATACLYSM"] = {
		["Normal"] = {
			{
				{ 2, "WildhammerClan", "inv_misc_tabard_wildhammerclan", "=ds="..ALIL["Wildhammer Clan"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Twilight Highlands"]};
				{ 3, "BaradinsWardens", "inv_misc_tabard_baradinwardens", "=ds="..ALIL["Baradin's Wardens"], "=q5="..FACTION_ALLIANCE.." - "..ALIL["Tol Barad"]};
				{ 5, "EarthenRing", "inv_misc_tabard_earthenring", "=ds="..ALIL["The Earthen Ring"], "=q5="..ALIL["Vashj'ir"].." / "..ALIL["Deepholm"]};
				{ 6, "Ramkahen", "inv_misc_tabard_tolvir", "=ds="..ALIL["Ramkahen"], "=q5="..ALIL["Uldum"]};
				{ 8, "AvengersHyjal", "inv_neck_hyjaldaily_04", "=ds="..ALIL["Avengers of Hyjal"], "=q5="..ALIL["Firelands"]};
				{ 17, "DragonmawClan", "inv_misc_tabard_dragonmawclan", "=ds="..ALIL["Dragonmaw Clan"], "=q5="..FACTION_HORDE.." - "..ALIL["Twilight Highlands"]};
				{ 18, "HellscreamsReach", "inv_misc_tabard_hellscream", "=ds="..ALIL["Hellscream's Reach"], "=q5="..FACTION_HORDE.." - "..ALIL["Tol Barad"]};
				{ 20, "GuardiansHyjal", "inv_misc_tabard_guardiansofhyjal", "=ds="..ALIL["Guardians of Hyjal"], "=q5="..ALIL["Molten Front"].." / "..ALIL["Mount Hyjal"]};
				{ 21, "Therazane", "inv_misc_tabard_therazane", "=ds="..ALIL["Therazane"], "=q5="..ALIL["Deepholm"]};
			};
		};
		info = {
			name = AL["Factions"].." - "..AL["Cataclysm"],
			menu = "REPMENU",
		};
	}