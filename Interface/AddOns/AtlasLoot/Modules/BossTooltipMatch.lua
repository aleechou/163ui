-- $Id: BossTooltipMatch.lua 4287 2014-02-19 18:28:14Z Bahnak $
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")

AtlasLoot_BossTooltipMatch = {}

-------------------------------------------------------------------
-- These matches uses unit IDs and need no further localizations
-------------------------------------------------------------------

-----------------------
-- Mists Raids
-----------------------
AtlasLoot_BossTooltipMatch[71952]					= AtlasLoot_IngameLocales["The August Celestials"]
AtlasLoot_BossTooltipMatch[71955]					= AtlasLoot_IngameLocales["The August Celestials"]
AtlasLoot_BossTooltipMatch[71954]					= AtlasLoot_IngameLocales["The August Celestials"]
AtlasLoot_BossTooltipMatch[71953]					= AtlasLoot_IngameLocales["The August Celestials"]
AtlasLoot_BossTooltipMatch[72057]					= AtlasLoot:EJ_GetBossName("Ordos, Fire-God of the Yaungol", 861)
AtlasLoot_BossTooltipMatch[71153]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71160]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71154]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71156]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71161]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71155]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71158]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71152]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71157]					= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch[71889]					= AtlasLoot:EJ_GetBossName("Spoils of Pandaria", 870)
AtlasLoot_BossTooltipMatch[71859]					= AtlasLoot:EJ_GetBossName("Kor'kron Dark Shaman", 856)
AtlasLoot_BossTooltipMatch[71858]					= AtlasLoot:EJ_GetBossName("Kor'kron Dark Shaman", 856)
AtlasLoot_BossTooltipMatch[72276]					= AtlasLoot:EJ_GetBossName("Norushen", 866)
AtlasLoot_BossTooltipMatch[71479]					= AtlasLoot:EJ_GetBossName("The Fallen Protectors", 849)
AtlasLoot_BossTooltipMatch[71475]					= AtlasLoot:EJ_GetBossName("The Fallen Protectors", 849)
AtlasLoot_BossTooltipMatch[71480]					= AtlasLoot:EJ_GetBossName("The Fallen Protectors", 849)
AtlasLoot_BossTooltipMatch[68905]					= AtlasLoot:EJ_GetBossName("Twin Consorts", 829)
AtlasLoot_BossTooltipMatch[68904]					= AtlasLoot:EJ_GetBossName("Twin Consorts", 829)
AtlasLoot_BossTooltipMatch[70247]					= AtlasLoot:EJ_GetBossName("Megaera", 821)
AtlasLoot_BossTooltipMatch[70235]					= AtlasLoot:EJ_GetBossName("Megaera", 821)
AtlasLoot_BossTooltipMatch[70212]					= AtlasLoot:EJ_GetBossName("Megaera", 821)
AtlasLoot_BossTooltipMatch[69134]					= AtlasLoot:EJ_GetBossName("Council of Elders", 816)
AtlasLoot_BossTooltipMatch[69132]					= AtlasLoot:EJ_GetBossName("Council of Elders", 816)
AtlasLoot_BossTooltipMatch[69131]					= AtlasLoot:EJ_GetBossName("Council of Elders", 816)
AtlasLoot_BossTooltipMatch[69078]					= AtlasLoot:EJ_GetBossName("Council of Elders", 816)
AtlasLoot_BossTooltipMatch[60583]					= AtlasLoot:EJ_GetBossName("Protectors of the Endless", 683)
AtlasLoot_BossTooltipMatch[60585]					= AtlasLoot:EJ_GetBossName("Protectors of the Endless", 683)
AtlasLoot_BossTooltipMatch[60586]					= AtlasLoot:EJ_GetBossName("Protectors of the Endless", 683)
AtlasLoot_BossTooltipMatch[59915]					= AtlasLoot:EJ_GetBossName("The Stone Guard", 679)
AtlasLoot_BossTooltipMatch[60043]					= AtlasLoot:EJ_GetBossName("The Stone Guard", 679)
AtlasLoot_BossTooltipMatch[60047]					= AtlasLoot:EJ_GetBossName("The Stone Guard", 679)
AtlasLoot_BossTooltipMatch[60051]					= AtlasLoot:EJ_GetBossName("The Stone Guard", 679)
AtlasLoot_BossTooltipMatch[60701]					= AtlasLoot:EJ_GetBossName("The Spirit Kings", 687)
AtlasLoot_BossTooltipMatch[60708]					= AtlasLoot:EJ_GetBossName("The Spirit Kings", 687)
AtlasLoot_BossTooltipMatch[60709]					= AtlasLoot:EJ_GetBossName("The Spirit Kings", 687)
AtlasLoot_BossTooltipMatch[60710]					= AtlasLoot:EJ_GetBossName("The Spirit Kings", 687)
AtlasLoot_BossTooltipMatch[60399]					= AtlasLoot:EJ_GetBossName("Will of the Emperor", 677)
AtlasLoot_BossTooltipMatch[60400]					= AtlasLoot:EJ_GetBossName("Will of the Emperor", 677)

-----------------------
-- Mists Dungeons
-----------------------
AtlasLoot_BossTooltipMatch[59051]					= AtlasLoot:EJ_GetBossName("Lorewalker Stonestep", 664)
AtlasLoot_BossTooltipMatch[59726]					= AtlasLoot:EJ_GetBossName("Lorewalker Stonestep", 664)
AtlasLoot_BossTooltipMatch[60040]					= AtlasLoot:EJ_GetBossName("High Inquisitor Whitemane", 674)

-----------------------
-- Cataclysm Raids
-----------------------
AtlasLoot_BossTooltipMatch[53494]					= AtlasLoot:EJ_GetBossName("Baleroc, the Gatekeeper", 196)
AtlasLoot_BossTooltipMatch[45992]					= AtlasLoot:EJ_GetBossName("Valiona and Theralion", 157)
AtlasLoot_BossTooltipMatch[45993]					= AtlasLoot:EJ_GetBossName("Valiona and Theralion", 157)
AtlasLoot_BossTooltipMatch[43735]					= AtlasLoot:EJ_GetBossName("Ascendant Council", 158)
AtlasLoot_BossTooltipMatch[43687]					= AtlasLoot:EJ_GetBossName("Ascendant Council", 158)
AtlasLoot_BossTooltipMatch[43686]					= AtlasLoot:EJ_GetBossName("Ascendant Council", 158)
AtlasLoot_BossTooltipMatch[41376]					= AtlasLoot:EJ_GetBossName("Nefarian", 174)
AtlasLoot_BossTooltipMatch[42166]					= AtlasLoot:EJ_GetBossName("Omnotron Defense System", 169)
AtlasLoot_BossTooltipMatch[42179]					= AtlasLoot:EJ_GetBossName("Omnotron Defense System", 169)
AtlasLoot_BossTooltipMatch[42178]					= AtlasLoot:EJ_GetBossName("Omnotron Defense System", 169)
AtlasLoot_BossTooltipMatch[42180]					= AtlasLoot:EJ_GetBossName("Omnotron Defense System", 169)
AtlasLoot_BossTooltipMatch[45870]					= AtlasLoot:EJ_GetBossName("Conclave of Wind", 154)
AtlasLoot_BossTooltipMatch[45871]					= AtlasLoot:EJ_GetBossName("Conclave of Wind", 154)
AtlasLoot_BossTooltipMatch[45872]					= AtlasLoot:EJ_GetBossName("Conclave of Wind", 154)

-----------------------
-- Cataclysm Dungeons
-----------------------
AtlasLoot_BossTooltipMatch[55419]					= AtlasLoot:EJ_GetBossName("Mannoroth and Varo'then", 292)
AtlasLoot_BossTooltipMatch[54969]					= AtlasLoot:EJ_GetBossName("Mannoroth and Varo'then", 292)
AtlasLoot_BossTooltipMatch[54544]					= "Echoes"
AtlasLoot_BossTooltipMatch[54445]					= "Echoes"
AtlasLoot_BossTooltipMatch[54431]					= "Echoes"
AtlasLoot_BossTooltipMatch[54123]					= "Echoes"
AtlasLoot_BossTooltipMatch[40319]					= AtlasLoot:EJ_GetBossName("Drahga Shadowburner", 133).." & "..BabbleBoss["Valiona"]
AtlasLoot_BossTooltipMatch[40788]					= BabbleBoss["Erunak Stonespeaker"].." & "..AtlasLoot:EJ_GetBossName("Mindbender Ghur'sha", 103)
AtlasLoot_BossTooltipMatch[40825]					= BabbleBoss["Erunak Stonespeaker"].." & "..AtlasLoot:EJ_GetBossName("Mindbender Ghur'sha", 103)

-----------------------
-- Wrath Raids
-----------------------
AtlasLoot_BossTooltipMatch[37970]					= BabbleBoss["Blood Prince Council"]
AtlasLoot_BossTooltipMatch[37972]					= BabbleBoss["Blood Prince Council"]
AtlasLoot_BossTooltipMatch[37973]					= BabbleBoss["Blood Prince Council"]
AtlasLoot_BossTooltipMatch[34496]					= BabbleBoss["The Twin Val'kyr"]
AtlasLoot_BossTooltipMatch[34497]					= BabbleBoss["The Twin Val'kyr"]
AtlasLoot_BossTooltipMatch[34796]					= BabbleBoss["The Beasts of Northrend"]
AtlasLoot_BossTooltipMatch[34797]					= BabbleBoss["The Beasts of Northrend"]
AtlasLoot_BossTooltipMatch[32857]					= BabbleBoss["The Iron Council"]
AtlasLoot_BossTooltipMatch[32927]					= BabbleBoss["The Iron Council"]
AtlasLoot_BossTooltipMatch[32867]					= BabbleBoss["The Iron Council"]
AtlasLoot_BossTooltipMatch[16063]					= BabbleBoss["The Four Horsemen"]
AtlasLoot_BossTooltipMatch[16064]					= BabbleBoss["The Four Horsemen"]
AtlasLoot_BossTooltipMatch[16065]					= BabbleBoss["The Four Horsemen"]
AtlasLoot_BossTooltipMatch[30549]					= BabbleBoss["The Four Horsemen"]

-----------------------
-- Wrath Dungeons
-----------------------
AtlasLoot_BossTooltipMatch[36477]					= AtlasLoot:EJ_GetBossName("Ick & Krick", 609)
AtlasLoot_BossTooltipMatch[36476]					= AtlasLoot:EJ_GetBossName("Ick & Krick", 609)
AtlasLoot_BossTooltipMatch[29573]					= AtlasLoot:EJ_GetBossName("Drakkari Colossus", 593)
AtlasLoot_BossTooltipMatch[26798]					= AtlasLoot:EJ_GetBossName("Frozen Commander", 617)
AtlasLoot_BossTooltipMatch[26796]					= AtlasLoot:EJ_GetBossName("Frozen Commander", 617)
AtlasLoot_BossTooltipMatch[24200]					= AtlasLoot:EJ_GetBossName("Skarvold & Dalronn", 639)
AtlasLoot_BossTooltipMatch[24201]					= AtlasLoot:EJ_GetBossName("Skarvold & Dalronn", 639)

-----------------------
-- BC Raids
-----------------------
AtlasLoot_BossTooltipMatch[25166]					= BabbleBoss["The Eredar Twins"]
AtlasLoot_BossTooltipMatch[25165]					= BabbleBoss["The Eredar Twins"]
AtlasLoot_BossTooltipMatch[22952]					= BabbleBoss["The Illidari Council"]
AtlasLoot_BossTooltipMatch[22951]					= BabbleBoss["The Illidari Council"]
AtlasLoot_BossTooltipMatch[22950]					= BabbleBoss["The Illidari Council"]
AtlasLoot_BossTooltipMatch[22949]					= BabbleBoss["The Illidari Council"]
AtlasLoot_BossTooltipMatch[23420]					= BabbleBoss["Reliquary of Souls"]
AtlasLoot_BossTooltipMatch[16151]					= BabbleBoss["Attumen the Huntsman"]

-----------------------
-- BC Dungeons
-----------------------

-----------------------
-- Classic Raids
-----------------------
AtlasLoot_BossTooltipMatch[15276]					= BabbleBoss["The Twin Emperors"]
AtlasLoot_BossTooltipMatch[15275]					= BabbleBoss["The Twin Emperors"]
AtlasLoot_BossTooltipMatch[15544]					= BabbleBoss["The Bug Family"]
AtlasLoot_BossTooltipMatch[15543]					= BabbleBoss["The Bug Family"]
AtlasLoot_BossTooltipMatch[15511]					= BabbleBoss["The Bug Family"]

-----------------------
-- Classic Dungeons
-----------------------



---------------------------------------------------------------
-- These matches uses Object Names and need to be translated
---------------------------------------------------------------

-----------------------
-- Mists Raids
-----------------------
AtlasLoot_BossTooltipMatch["Legacy of the Clan Leaders"]	= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch["Mantid Amber"]			= AtlasLoot:EJ_GetBossName("Paragons of the Klaxxi", 853)
AtlasLoot_BossTooltipMatch["Secured Stockpile of Pandaren Spoils"]	= AtlasLoot:EJ_GetBossName("Spoils of Pandaria", 870)
AtlasLoot_BossTooltipMatch["Vault of Forbidden Treasures"]	= AtlasLoot:EJ_GetBossName("Sha of Pride", 867)
AtlasLoot_BossTooltipMatch["Tears of the Vale"]			= AtlasLoot:EJ_GetBossName("Immerseus", 852)

-----------------------
-- Mists Dungeons
-----------------------
AtlasLoot_BossTooltipMatch["Legacy of the Clan Leaders"]	= AtlasLoot:EJ_GetBossName("Trial of the King", 708)
AtlasLoot_BossTooltipMatch["Snowdrift's Possessions"]		= AtlasLoot:EJ_GetBossName("Master Snowdrift", 657)
AtlasLoot_BossTooltipMatch["Taran Zhu's Personal Stash"]	= AtlasLoot:EJ_GetBossName("Taran Zhu", 686)
AtlasLoot_BossTooltipMatch["Instructor Chillheart's Phylactery"]= AtlasLoot:EJ_GetBossName("Instructor Chillheart", 659)
AtlasLoot_BossTooltipMatch["Coffer of Forgotten Souls"]		= AtlasLoot:EJ_GetBossName("Lilian Voss", 666)

-----------------------
-- Cataclysm Raids
-----------------------
AtlasLoot_BossTooltipMatch["Elementium Fragment"]		= AtlasLoot:EJ_GetBossName("Madness of Deathwing", 333)
AtlasLoot_BossTooltipMatch["Greater Cache of the Aspects"]	= AtlasLoot:EJ_GetBossName("Spine of Deathwing", 318)
AtlasLoot_BossTooltipMatch["Lesser Cache of the Aspects"]	= AtlasLoot:EJ_GetBossName("Ultraxion", 331)
AtlasLoot_BossTooltipMatch["Cache of the Fire Lord"]		= AtlasLoot:EJ_GetBossName("Ragnaros", 198)
AtlasLoot_BossTooltipMatch["Heart of Wind"]			= AtlasLoot:EJ_GetBossName("Al'Akir", 155)

-----------------------
-- Cataclysm Dungeons
-----------------------
AtlasLoot_BossTooltipMatch["Minor Cache of the Aspects"]	= AtlasLoot:EJ_GetBossName("Mannoroth and Varo'then", 292)
AtlasLoot_BossTooltipMatch["Royal Cache"]			= AtlasLoot:EJ_GetBossName("Queen Azshara", 291)
AtlasLoot_BossTooltipMatch["Murozond's Temporal Cache"]		= AtlasLoot:EJ_GetBossName("Murozond", 289)
AtlasLoot_BossTooltipMatch["Neptulon's Cache"]			= AtlasLoot:EJ_GetBossName("Ozumat", 104)

-----------------------
-- Wrath Raids
-----------------------
AtlasLoot_BossTooltipMatch["Cache of the Dreamwalker"]		= BabbleBoss["Valithria Dreamwalker"]
AtlasLoot_BossTooltipMatch["Deathbringer's Cache"]		= BabbleBoss["Deathbringer Saurfang"]
AtlasLoot_BossTooltipMatch["Gunship Armory"]			= BabbleBoss["Icecrown Gunship Battle"]
AtlasLoot_BossTooltipMatch["Champions' Cache"]			= BabbleBoss["Faction Champions"]
AtlasLoot_BossTooltipMatch["Gift of the Observer"]		= BabbleBoss["Algalon the Observer"]
AtlasLoot_BossTooltipMatch["Cache of Innovation"]		= BabbleBoss["Mimiron"]
AtlasLoot_BossTooltipMatch["Freya's Gift"]			= BabbleBoss["Freya"]
AtlasLoot_BossTooltipMatch["Cache of Storms"]			= BabbleBoss["Thorim"]
AtlasLoot_BossTooltipMatch["Cache of Winter"]			= BabbleBoss["Hodir"]
AtlasLoot_BossTooltipMatch["Cache of Living Stone"]		= BabbleBoss["Kologarn"]
AtlasLoot_BossTooltipMatch["Alexstrasza's Gift"]		= BabbleBoss["Malygos"]
AtlasLoot_BossTooltipMatch["Four Horsemen Chest"]		= BabbleBoss["The Four Horsemen"]

-----------------------
-- Wrath Dungeons
-----------------------
AtlasLoot_BossTooltipMatch["The Captain's Chest"]		= BabbleBoss["The Lich King"]
AtlasLoot_BossTooltipMatch["Eadric's Cache"]			= BabbleBoss["Eadric the Pure"]
AtlasLoot_BossTooltipMatch["Confessor's Cache"]			= BabbleBoss["Argent Confessor Paletress"]
AtlasLoot_BossTooltipMatch["Champion's Cache"]			= BabbleBoss["Faction Champions"]
AtlasLoot_BossTooltipMatch["Cache of Eregos"]			= AtlasLoot:EJ_GetBossName("Ley-Guardian Eregos", 625)
AtlasLoot_BossTooltipMatch["Tribunal Chest"]			= AtlasLoot:EJ_GetBossName("Tribunal of Ages", 606)
AtlasLoot_BossTooltipMatch["Dark Runed Chest"]			= AtlasLoot:EJ_GetBossName("Mal'Ganis", 614)

-----------------------
-- BC Raids
-----------------------
AtlasLoot_BossTooltipMatch["Dust Covered Chest"]		= BabbleBoss["Chess Event"]

-----------------------
-- BC Dungeons
-----------------------
AtlasLoot_BossTooltipMatch["Reinforced Fel Iron Chest"]		= AtlasLoot:EJ_GetBossName("Vazruden the Herald", 529)
AtlasLoot_BossTooltipMatch["Cache of the Legion"]		= BabbleBoss["Cache of the Legion"]

-----------------------
-- Classic Raids
-----------------------
AtlasLoot_BossTooltipMatch["Cache of the Firelord"]		= BabbleBoss["Majordomo Executus"]

-----------------------
-- Classic Dungeons
-----------------------
AtlasLoot_BossTooltipMatch["Gordok Tribute"]			= AL["DM North Tribute Chest"]
AtlasLoot_BossTooltipMatch["Chest of The Seven"]		= AtlasLoot:EJ_GetBossName("The Seven", 385)
AtlasLoot_BossTooltipMatch["Secret Safe"]			= AL["The Vault"]
