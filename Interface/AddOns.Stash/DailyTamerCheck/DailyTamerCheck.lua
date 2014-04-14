-- Daily Tamer Check
-- by Fluffies
-- EU-Well of Eternity

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbicon = ldb and LibStub("LibDBIcon-1.0", true)

local DTCversion = 1
local tutorial_level = 0
local playerfaction = UnitFactionGroup("PLAYER")
-- dtc mainframe
--local DailyTamerCheck_mainframe
-- dtc world map frame
local DailyTamerCheck_mapframe
local DTCTTmenu = {}

-- string colors
local LIGHT_RED    = "|cffFF2020"
local LIGHT_GREEN  = "|cff20FF20"
local LIGHT_BLUE   = "|cff11DDFF"
local LIGHT_YELLOW = "|cffFFFFAA"
local ZONE_BLUE    = "|cff00aacc"
local GREY         = "|cffAAAAAA"
local COORD_GREY   = "|cffDDDDDD"
local GOLD         = "|cffffcc00"
local WHITE        = "|cffffffff"
local function AddColor(str,color)
	return color..str.."|r"
end

local levelcolor = WHITE
local npcnamecolor = LIGHT_BLUE
local zonecolor = GREY
local coordcolor = COORD_GREY

local SAT   = 0 -- satchels table
local EKK   = 1 -- eastern kingdoms, kalimdor
local ONC   = 2 -- outlands, northrend, cataclysm
local ABOUT = 3 -- about frame

-- elite pets daily quests (quest log)
local ep_header = "elite pets"
local ep_quest_missing = AddColor(string.format(ITEM_MISSING,BATTLE_PET_SOURCE_2),LIGHT_RED)
-- elite pets quest objective indexes
local epspecial = "#elitepets#"
--
local WEheader = EVENTS_LABEL
local WEtable  -- world events table
local tables = {} -- tamers tables
local questsdata = nil

local frames_backdrop = {
							bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
							tile = true, tileSize = 16, edgeSize = 16, 
							insets = { left = 4, right = 4, top = 4, bottom = 4 }
						}

-- pet families icons
local pfme  = "|TInterface\\icons\\Icon_PetFamily_Mechanical:12|t"
local pfbe  = "|TInterface\\icons\\Icon_PetFamily_Beast:12|t"
local pfhu  = "|TInterface\\icons\\Icon_PetFamily_Humanoid:12|t"
local pfdr  = "|TInterface\\icons\\Icon_PetFamily_Dragon:12|t"
local pffl  = "|TInterface\\icons\\Icon_PetFamily_Flying:12|t"
local pfcr  = "|TInterface\\icons\\Icon_PetFamily_Critter:12|t"
local pfma  = "|TInterface\\icons\\Icon_PetFamily_Magical:12|t"
local pfun  = "|TInterface\\icons\\Icon_PetFamily_Undead:12|t"
local pfwa  = "|TInterface\\icons\\Icon_PetFamily_Water:12|t"
local pfel  = "|TInterface\\icons\\Icon_PetFamily_Elemental:12|t"

-- icons
local dtcicon = "Interface\\ICONS\\INV_MISC_PETMOONKINTA"
local icon_firespirit = "Interface\\icons\\INV_Pet_PandarenElemental_Fire"
local icon_waterspirit = "Interface\\icons\\Inv_pet_PandarenElemental"
local icon_earthspirit = "Interface\\icons\\INV_Pet_PandarenElemental_Earth"
local icon_airspirit = "Interface\\icons\\INV_Pet_PandarenElemental_Air"
-- buttons' textures
local tx_btnnorth     = "Interface\\icons\\Achievement_Zone_Northrend_01"
local tx_btnkalim     = "Interface\\icons\\Achievement_Zone_Kalimdor_01"
local tx_btnabout     = "Interface\\icons\\Icon_PetFamily_Beast"
local tx_chkcoords    = "Interface\\icons\\INV_Misc_Map_01"
local tx_chkminimap   = "Interface\\icons\\INV_Misc_Map03"
local tx_chknames     = "Interface\\icons\\Achievement_Character_Pandaren_Female"
local tx_chkicons     = "Interface\\icons\\Icon_PetFamily_Dragon"
local tx_chkmapicons  = "Interface\\icons\\Ability_Hunter_Crossfire"
local tx_chklevel     = "Interface\\icons\\INV_Pet_Achievement_RaiseAPetLevel_25"
local tx_optionsframe = "Interface\\icons\\Icon_PetFamily_Mechanical"
local tx_bagicon      = "Interface\\icons\\INV_Misc_Bag_CenarionHerbBag"
local ep_icon         = "Interface\\icons\\Ability_Mount_WhiteDireWolf"
local tx_faction      = {
							["Alliance"] = "Interface\\icons\\Achievement_General_AllianceSlayer",
							["Horde"] = "Interface\\icons\\Achievement_General_HordeSlayer"
						}
local opt_framespeed = 20  -- frames animation speed
local centerbuttons_spacing = 80
--local worldeventschecked = false

-- localization show/hide
local s_togglecoords
local s_togglenpcnames
local s_toggleminimapbtn
local s_togglenpclevel
local s_togglenpcicons
local s_togglemapicons
local s_tomtomintegration
local s_tomtomset
local s_faction
local h_togglecoords
local h_togglenpcnames
local h_toggleminimapbtn
local h_togglenpclevel
local h_togglenpcicons
local h_togglemapicons
local h_faction
local s_optionsmain = COMPACT_UNIT_FRAME_PROFILE_SUBTYPE_ALL
local npc_firespirit = "Fire Spirit"
local npc_airspirit = "Air Spirit"
local npc_waterspirit = "Water Spirit"
local npc_earthspirit = "Earth Spirit"
local npc_tommy = "Little Tommy"
local npc_outlands = "Antari"
local npc_northrend = "Payne"
local npc_cataclysm = "Obalis"
local npc_kalimdor = "Trixxy"
local npc_easternkingdoms = "Lydia"
local npc_darkmoon = "Jeremy Feasel"

local LOCALE = GetLocale() 
local TITLE
local LBLTITLE
local L_CN = "zhCN"

if LOCALE == "itIT" then -- italian
	s_togglecoords = "Attiva coordinate"
	s_togglenpcnames = "Attiva nomi NPC"
	s_toggleminimapbtn = "Attiva pulsante minimappa"
	s_togglenpclevel = "Attiva livello delle mascotte"
	s_togglenpcicons = "Attiva le icone delle mascotte dei tamer"
	s_togglemapicons = "Attiva le icone sulla mappa"
	s_tomtomintegration = "Setta waypoint di TomTom"
	s_tomtomset = "|cff11DDFFDaily Tamer Check|r - Waypoint aggiunto a TomTom"
	s_showfaction = "Mostra tamer dell'altra fazione"
	h_togglecoords = "Non attivare coordinate"
	h_togglenpcnames = "Non attivare nomi NPC"
	h_toggleminimapbtn = "Non attivare pulsante minimappa"
	h_togglenpclevel = "Non attivare livello delle mascotte"
	h_togglenpcicons = "Non attivare le icone delle mascotte dei tamer"
	h_togglemapicons = "Non attivare le icone sulla mappa"
	h_showfaction = "Non mostrare tamer dell'altra fazione"
	TITLE = "Daily Tamer Check"
	LBLTITLE = "DailyTamerCheck"
elseif LOCALE == "deDE" then -- german
	s_togglecoords = "Koordinaten an"
	s_togglenpcnames = "NPC Namen an"
	s_toggleminimapbtn = "Minikarten Symbol an"
	s_togglenpclevel = "Sortiere Zähmer nach Haustier Level an"
	s_togglenpcicons = "Haustier Kategorie Symbol an"
	s_togglemapicons = "Show world map icons" --de
	s_tomtomintegration = "Set TomTom waypoint" --de
	s_tomtomset = "|cff11DDFFDaily Tamer Check|r - Waypoint added to TomTom" --de
	s_showfaction = "Show other faction tamers" --de
	h_togglecoords =  "Koordinaten aus"
	h_togglenpcnames = "NPC Namen aus"
	h_toggleminimapbtn = "Minikarten Symbol aus"
	h_togglenpclevel = "Sortiere Zähmer nach Haustier Level aus"
	h_togglenpcicons = "Haustier Kategorie Symbol aus"
	h_togglemapicons = "Hide world map icons"
	h_showfaction = "Hide other faction tamers"
	TITLE = "Daily Tamer Check"
	LBLTITLE = "DailyTamerCheck"
elseif LOCALE == L_CN then -- zhCN
	s_togglecoords = "显示任务坐标"
	s_togglenpcnames = "显示NPC名字"
	s_toggleminimapbtn = "显示小地图按钮"
	s_togglenpclevel = "显示宠物等级"
	s_togglenpcicons = "显示宠物类型图标"
	s_togglemapicons = "显示世界地图图标"
	s_tomtomintegration = "设置TomTom坐标"
	s_tomtomset = "|cff11DDFF宠物日常检测|r - 添加坐标到TomTom"
	s_showfaction = "显示对立阵营任务" 
	h_togglecoords = "隐藏任务坐标"
	h_togglenpcnames = "隐藏NPC名字"
	h_toggleminimapbtn = "隐藏小地图按钮"
	h_togglenpclevel = "隐藏宠物等级"
	h_togglenpcicons = "隐藏宠物类型图标"
	h_togglemapicons = "隐藏世界地图图标"
	h_showfaction = "隐藏对立阵营任务" 
	npc_firespirit = "熊猫人烈焰之灵"
	npc_airspirit = "熊猫人微风之灵"
	npc_waterspirit = "熊猫人流水之灵"
	npc_earthspirit = "熊猫人雷霆之灵"
	npc_tommy = "新手小汤米"
	npc_outlands = "血骑士安塔里"
	npc_northrend = "派恩少校"
	npc_cataclysm = "奥巴里斯"
	npc_kalimdor = "\"冷血\"崔克斯"
	npc_easternkingdoms = "莉迪亚·埃考斯特"
	npc_darkmoon = "杰米里.费舍尔"
	TITLE = "宠物日常检测"
	LBLTITLE = "宠物日常检测"
else -- eng
	s_togglecoords = "Show coordinates"
	s_togglenpcnames = "Show NPC names"
	s_toggleminimapbtn = "Show minimap button"
	s_togglenpclevel = "Show pet level"
	s_togglenpcicons = "Show pets' icons"
	s_togglemapicons = "Show world map icons"
	s_tomtomintegration = "Set TomTom waypoint"
	s_tomtomset = "|cff11DDFFDaily Tamer Check|r - Waypoint added to TomTom"
	s_showfaction = "Show other faction tamers"
	h_togglecoords = "Hide coordinates"
	h_togglenpcnames = "Hide NPC names"
	h_toggleminimapbtn = "Hide minimap button"
	h_togglenpclevel = "Hide pet level"
	h_togglenpcicons = "Hide pets' icons"
	h_togglemapicons = "Hide world map icons"
	h_showfaction = "Hide other faction tamers"
	TITLE = "Daily Tamer Check"
	LBLTITLE = "DailyTamerCheck"
end
--

local ZONE = 1
local NPCNAME = 2
local NPCLEVEL = 3
local NPCICONS = 4
local MAPDATA = 5
local MAPDEFAULT = 6
local MAPICON = 7
local FACTION = 8
------- zone -> quests table for the world map frame -------------------------
local mapstable = {}
local function generatezonetomaptable()
	table.foreach(questsdata, function(questID,info)
		if info[MAPDATA] then
			table.foreach(info[MAPDATA], function(mapID, _)
				if not mapstable[mapID] then
					mapstable[mapID] = {}
				end
				if not tContains(mapstable[mapID], questID) then
						table.insert(mapstable[mapID], questID)
				end
			end)
		end
	end)
end
------------------------------------------------------------------------
local function coord(questID)
	return questsdata[questID] and AddColor(questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][1]..","..questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][2],coordcolor) or ""
end
------------------------------------------------------------------------
local function levelformat(lev)
	if lev > 100 then -- elite pets
		return AddColor("["..(lev - 100).."+] ", levelcolor)
	else
		return AddColor("["..lev.."] ", levelcolor)
	end
end
------------------------------------------------------------------------
local function factioncheck(questID)
	if not questsdata[questID][FACTION] or DailyTamerCheck_Options["show_faction"] or
         (not DailyTamerCheck_Options["show_faction"] and questsdata[questID][FACTION]
          and questsdata[questID][FACTION] == playerfaction) then
		return true
	else
		return false
	end
end

--[[
  dtc tables [questID] = {zone name, npc name, petslevel, petsicons, {[mapid] = {x,y}, ... }, defaultmap, custom world map icon }
]]--

------- localized zone and npc names from GetAchievementCriteriaInfo --------
questsdata = {
    -- Pandaren Spirits --
    [32434] = {{6974,5},"|T"..icon_firespirit..":12|t "..npc_firespirit,25,pfdr..pfel..pffl,{[810] = {57,42},[862] = {32,36},[-1] = {46,79},[809] = {16,64}},810,icon_firespirit},
    [32439] = {{6974,6},"|T"..icon_waterspirit..":12|t "..npc_waterspirit,25,pfwa..pfcr..pfel,{[858] = {61,88},[862] = {38,81},[-1] = {48,92}},858,icon_waterspirit},
    [32441] = {{6974,4},"|T"..icon_earthspirit..":12|t "..npc_earthspirit,25,pfel..pfma..pfbe,{[809] = {65,94},[862] = {51,48},[-1] = {52,82},[811] = {67,14},[806] = {9,41}},809,icon_earthspirit},
    [32440] = {{6974,1},"|T"..icon_airspirit..":12|t "..npc_airspirit,25,pffl..pfdr..pfel,{[806] = {29,36},[862] = {60,45},[-1] = {55,81}, [809] = {86,87}},806,icon_airspirit},
    -- Pandaria --
    [31953] = {{6974,1},{6606,1},25,pffl..pfbe..pfwa,{[806] = {48,54},[862] = {69,54},[-1] = {58,84}},806,tx_bagicon},
    [31955] = {{6974,2},{6606,2},25,pfel..pfel..pfbe,{[807] = {46,44},[862] = {51,65},[-1] = {52,87}},807,tx_bagicon},
    [31954] = {{6974,3},{6606,3},25,pfbe..pffl..pfwa,{[857] = {62,45},[862] = {56,79},[-1] = {54,92}},857,tx_bagicon},
    [31956] = {{6974,4},{6606,4},25,pffl..pfcr..pfbe,{[809] = {36,74},[862] = {40,40},[-1] = {49,79}},809,tx_bagicon},
    [31991] = {{6974,5},{6606,5},25,pfel..pfcr..pfwa,{[810] = {36,52},[862] = {24,40},[-1] = {44,80}},810,tx_bagicon},
    [31957] = {{6974,6},{6606,6},25,pfwa..pfel..pfbe,{[858] = {55,38},[862] = {36,64},[-1] = {48,86}},858,tx_bagicon},
    [31958] = {{6974,7},{6606,7},25,pfcr..pfdr..pfwa,{[811] = {31,74},[862] = {45,58},[858] = {83,20},[807] = {25,15},[-1] = {50,85}},811,tx_bagicon},
    -- Outlands --
    [31922] = {{44,1},{6604,1},20,pfme..pfme..pfme,{[465] = {64,49},[466] = {62,52}},465},
    [31923] = {{44,2},{6604,2},21,pffl..pfhu..pfma,{[467] = {17,50},[466] = {25,48}},467},
    [31924] = {{44,4},{6604,3},22,pfwa..pfcr..pfbe,{[477] = {61,49},[466] = {35,65}},477},
    [31925] = {{867,8},{6604,4},23,pfwa..pfwa..pfwa,{[481] = {59,70},[478] = {32,30},[466] = {44,68}},481},
    [31926] = {{44,7},npc_outlands,24,pfma..pfel..pfdr,{[473] = {31,42},[466] = {60,79}},473,tx_bagicon},
    -- Northrend --
    [31931] = {{45,2},{6605,1},25,pffl..pfwa..pffl,{[491] = {29,34},[485] = {69,75},[-1] = {58,26}},491},
    [31933] = {{45,3},{6605,3},25,pfdr..pfun..pfun,{[488] = {59,77},[485] = {50,67},[-1] = {52,23}},488},
    [31934] = {{45,5},{6605,4},25,pfbe..pfbe..pfcr,{[496] = {13,67},[485] = {59,44},[-1] = {55,16}},496},
    [31932] = {{45,7},{6605,2},25,pfun..pfun..pfun,{[510] = {50,59},[485] = {51,44},[-1] = {53,16}},510},
    [31935] = {{45,9},npc_northrend,25,pfbe..pfme..pfel, {[492] = {77,20},[485] = {49,17},[-1] = {52,8}},492,tx_bagicon},
    -- Cataclysm --
    [31972] = {{4868,1},{7525,1},25,pfma..pfbe..pfcr,{[606] = {61,33},[182] = {87,48},[281] = {41,85},[13] = {56,31},[-1] = {23,37}},606},
    [31973] = {{4868,3},{7525,2},25,pfel..pfcr..pfel,{[640] = {50,57},[751] = {50,36},[-1] = {50,50}},640},
    [31971] = {{4868,4},npc_cataclysm,25,pfbe..pffl..pfcr,{[720] = {57,42},[13] = {49,92},[-1] = {19,75}},720,tx_bagicon},
    [31974] = {{4868,5},{7525,3},25,pfel..pfma..pfbe,{[700] = {57,57},[14] = {58,57},[-1] = {90,52}},700},
    -- Kalimdor --
    [31818] = {{43,1},{6602,1},2,pfbe..pfcr,{[4] = {44,28},[13] = {58,49},[-1] = {25,48},[11] = {78,27}},4,nil,"Horde"},
    [31819] = {{43,5},{6602,2},3,pfbe..pfbe..pfcr,{[11] = {58,53},[13] = {55,53},[-1] = {22,51},[4] = {23,58},[607] = {61,9}},11,nil,"Horde"},
    [31909] = {{43,6},npc_kalimdor,19,pfdr..pfbe..pffl,{[281] = {66,65},[13] = {60,27},[-1] = {26,35}},281,tx_bagicon},
    [31904] = {{43,7},{6602,8},11,pfme..pfme..pfme,{[607] = {39,79},[13] = {51,67},[-1] = {20,59},[9] = {69,98},[141] = {11,48}},607,nil,"Horde"},
    [31854] = {{43,10},{6602,3},5,pfwa..pfcr..pffl,{[43] = {20,29},[13] = {45,38},[-1] = {16,41},[182] = {21,91}},43,nil,"Horde"},
    [31906] = {{43,11},{6602,11},15,pfbe..pfcr..pfcr,{[61] = {32,33},[13] = {51,72},[-1] = {20,63},[141] = {16,83}},61,nil,"Horde"},
    [31862] = {{43,12},{6602,4},7,pfbe..pfbe..pfcr,{[81] = {59,71},[13] = {45,50},[-1] = {16,48}},81,nil,"Horde"},
    [31872] = {{43,13},{6602,5},9,pfwa..pfcr..pfel,{[101] = {57,45},[13] = {42,56},[-1] = {14,53},[9] = {10,21}},101,nil,"Horde"},
    [31905] = {{43,14},{6602,9},14,pfdr..pfdr..pfdr,{[141] = {53,74},[13] = {57,71},[-1] = {24,62},[61] = {77,24}},141,nil,"Horde"},
    [31871] = {{43,15},{6602,6},13,pfbe..pfcr..pfdr,{[121] = {60,50},[13] = {43,72},[-1] = {15,62}},121,nil,"Horde"},
    [31907] = {{43,18},{6602,10},16,pfma..pfma..pfme,{[182] = {40,56},[13] = {48,31},[42] = {56,75},[-1] = {18,37}},182,nil,"Horde"},
    [31908] = {{43,20},{6602,7},17,pfdr..pffl..pfma,{[241] = {46,60},[13] = {53,21},[42] = {84,15},[-1] = {21,30}},241,nil,"Horde"},
    -- Eastern Kingdoms --
    [31693] = {{42,1},{6603,1},2,pfbe..pfbe,{[30] = {42,84},[14] = {44,78},[-1] = {81,66}},30,nil,"Alliance"},
    [31914] = {{42,5},{6603,10},17,pffl..pfcr..pfel,{[29] = {25,47},[14] = {48,70},[-1] = {83,62}},29,nil,"Alliance"},
    [31850] = {{42,7},{6603,4},7,pfbe..pfbe..pfbe,{[34] = {20,44},[14] = {44,80},[-1] = {81,68}},34,nil,"Alliance"},
    [31781] = {{42,10},{6603,3},5,pfcr..pfcr..pfcr,{[36] = {33,52},[14] = {50,76},[-1] = {85,65}},36,nil,"Alliance"},
    [31912] = {{42,13},{6603,9},15,pfdr..pfdr..pfdr,{[28] = {35,27},[14] = {47,65},[-1] = {83,58}},28,nil,"Alliance"},
    [31852] = {{42,16},{6603,5},9,pfbe..pfbe..pfma,{[37] = {46,40},[689] = {47,26},[14] = {45,85},[-1] = {81,72}},37,nil,"Alliance"},
    [31851] = {{42,17},{6603,6},11,pfhu..pffl..pffl,{[673] = {51,73},[689] = {44,79},[14] = {44,94},[-1] = {81,78}},673,nil,"Alliance"},
    [31913] = {{42,18},{6603,11},16,pffl..pfwa..pfbe,{[38] = {76,41},[14] = {54,79},[-1] = {88,67}},38,nil,"Alliance"},
    [31910] = {{42,19},{6603,7},13,pfcr..pfbe..pfma,{[26] = {62,54},[14] = {54,41},[-1] = {88,41}},26,nil,"Alliance"},
    [31780] = {{42,20},{6603,2},3,pfme..pffl..pfcr,{[39] = {61,19},[14] = {42,77},[-1] = {80,66}},39,nil,"Alliance"},
    [31916] = {{42,22},npc_easternkingdoms,19,pfel..pfun..pfun,{[32] = {40,77},[14] = {49,82},[-1] = {84,70}},32,tx_bagicon},
    [31911] = {{42,24},{6603,8},14,pfbe..pfbe..pfun,{[23] = {67,54},[14] = {57,32},[-1] = {90,36}},23,nil,"Alliance"},
    -- Timeless Isle --
    [33222] = {GetMapNameByID(951),npc_tommy,125,pfbe,{[951] = {35,60},[862] = {88,71},[806] = {91,94},[-1] = {64,89}},951,nil},
    [33137] = {8410,"",25,"",{[951] = {35,60},[862] = {88,71},[806] = {91,94},[-1] = {64,89}},951,nil},
    --8410
    -- Elite Pets --
    [epspecial..1] = {{6974,1},ep_quest_missing,125,pfcr,{[806] = {48,71},[862] = {68,61},[-1] = {57,85}},806,ep_icon}, -- Kawi I
    [epspecial..2] = {{6974,4},ep_quest_missing,125,pfbe,{[809] = {35,56},[862] = {39,32},[-1] = {48,77},[810] = {77,33}},809,ep_icon}, -- kafi I
    [epspecial..3] = {{6974,4},ep_quest_missing,125,pfwa,{[809] = {68,85},[862] = {52,44},[-1] = {52,80},[806] = {12,33}},809,ep_icon}, -- dos ryga I
    [epspecial..4] = {{6974,1},ep_quest_missing,125,pfcr,{[806] = {57,29},[862] = {72,42},[-1] = {58,80}},806,ep_icon}, -- Nitun I
    [epspecial..5] = {{6974,2},ep_quest_missing,125,pfbe,{[807] = {25,78},[862] = {45,73},[-1] = {50,89},[857] = {26,27},[858] = {83,66}},807,ep_icon}, -- Greyhoof II
    [epspecial..6] = {{6974,2},ep_quest_missing,125,pfcr,{[807] = {40,43},[862] = {49,65},[-1] = {51,87},[858] = {94,41}},807,ep_icon}, -- Lucky Yi II
    [epspecial..7] = {{6974,3},ep_quest_missing,125,pfwa,{[857] = {36,37},[862] = {48,76},[858] = {91,75},[807] = {36,90},[-1] = {51,90}},857,ep_icon}, -- xia II
    [epspecial..8] = {{6974,6},ep_quest_missing,125,pfbe,{[858] = {26,50},[862] = {25,68},[-1] = {44,88}},858,ep_icon}, -- Gorespine III
    [epspecial..9] = {{6974,7},ep_quest_missing,125,pfwa,{[811] = {11,70},[862] = {42,57},[858] = {73,18}, [807] = {12,13},[-1] = {49,84}},811,ep_icon}, -- no-no III
	[epspecial..10] = {{6974,5},ep_quest_missing,125,pfwa,{[810] = {72,80},[862] = {37,50},[-1] = {48,82},[809] = {30,98}},810,ep_icon}, -- ti'un III
    -- Events
    
    -- Darkmoon Fairie
    [32175] = {"|TInterface\\icons\\INV_Misc_Eye_01:12|t "..CALENDAR_FILTER_DARKMOON,npc_darkmoon,25,pfma..pfme..pfbe,{[823] = {47,60}}, 823}}
    
--- Elite pets methods ---
local ep_books = { 
					{ index = -1, qname = "", completed = false, pets = {1,2,3,4}, questID = 32604},
					{ index = -1, qname = "", completed = false, pets = {5,6,7},   questID = 32868},
					{ index = -1, qname = "", completed = false, pets = {8,9,10},  questID = 32869}
                 }


local function EP_resetbooks()
	table.foreach(ep_books, function(k,v)
		v.index = -1
		v.completed = false
	end)
end

local function EP_GetBook_pet(pet)
	if type(pet) ~= "number" then
		pet = tonumber(pet)
	end
	if pet < 1 or pet > 10 then 		
		return nil 
	end 
	if pet <= 4 then
		return ep_books[1] 
	elseif pet <= 7 then
		return ep_books[2]
	else
		return ep_books[3]
	end
end
  
local function EP_GetBook_index(id)
	if id == "I" then
		return ep_books[1]
	elseif id == "II" then
		return ep_books[2]
	elseif id == "III" then
		return ep_books[3]
	else 
		return nil
	end
end

local function EP_iscriteriacompleted(pet)
	local result = false
	local book = EP_GetBook_pet(pet)
	if book and not book.completed and book.index > -1 then
		local _,_,done = GetQuestLogLeaderBoard(pet - (book.pets[1] - 1), book.index)
		result = done
	end
	return result
end

local function EP_match_questID(arg)
	table.foreach(ep_books, function(k,v)
		if v.questID == arg then
			return v
		end
	end)
end

local function getelitepetname(pet)
	local desc
	local book = EP_GetBook_pet(pet)
	if book and book.index > -1 then
		desc,_,_ = GetQuestLogLeaderBoard(pet - (book.pets[1] - 1),book.index)
		return desc
	end
end
----------------------------

-- check for active world events
local function AddWorldEventTamers()
	local result = false
	local i
	local _,_,today = CalendarGetDate()
	for i = 1,CalendarGetNumDayEvents(0,today) do
		local title = CalendarGetDayEvent(0, today, i)
		table.foreach(WEtable,function(k,v)
			if title == k then
				if not tables[SAT][WEheader] then 
					tables[SAT][WEheader] = {} 
				end
				table.foreach(v, function(_,questID)
					if not tContains(tables[SAT][WEheader], questID) then
						table.insert(tables[SAT][WEheader],questID)
						result = true
					end
				end)
			end
		end)
	end
	return result
end

-- I had to move the tables generation in the PLAYER_ENTERING_WORLD event
-- because, as patch 5.2 came out, the achievement criterias were no more available
-- on login
local function GenerateTables()
	local result = false
	if WEtable == nil then
		WEtable = {}
		WEtable[CALENDAR_FILTER_DARKMOON] = {32175}
		-- future world event tamers here
		result = true
	end

	-- Resolve Achievement Criterias
	table.foreach(questsdata, function(quest, v)
		if type(v[ZONE]) == "table" then
			v[ZONE] = GetAchievementCriteriaInfo(v[ZONE][1],v[ZONE][2])
		end
		if type(v[NPCNAME]) == "table" then
			v[NPCNAME] = GetAchievementCriteriaInfo(v[NPCNAME][1],v[NPCNAME][2])
		end
		-- celestial tournament hack
		if type(v[ZONE]) == "number" then
			v[ZONE] = "|cff55AACC"..select(8,GetAchievementInfo(v[ZONE])).."|r"
		end
		--if type(v[NPCNAME]) == "number" then
			--v[NPCNAME] = select(8,GetAchievementInfo(v[NPCNAME]))
		--end
	end)
 
	if tables[SAT] == nil then
		tables[SAT] = 
			{
				-- Pandaren Spirits --
				[select(2,GetAchievementInfo(7936))] = 
					{32434,32439,32441,32440},
				-- Pandaria Satchels --
				[select(2,GetAchievementInfo(6606))] = 
					{31957,31991,31956,31955,31954,31953,31958,33222},
				[select(2,GetAchievementInfo(8410))] =
					{33137},
				-- Other Satchels --
				[select(2,GetAchievementInfo(6607))] = 
					{31935,31926,31916,31909,31971} 
			}
		AddWorldEventTamers()
		generatezonetomaptable(tables[SAT])
		result = true
	end

	if tables[ONC] == nil then
		ep_header = select(2,GetAchievementInfo(8080)).." "
		tables[ONC] = 
			{
				-- Elite Pets --
				[ep_header.."I"] = 
					{epspecial..1,epspecial..2,epspecial..3,epspecial..4},
				[ep_header.."II"] = 
					{epspecial..5,epspecial..6,epspecial..7},
				[ep_header.."III"] = 
					{epspecial..8,epspecial..9,epspecial..10},
				-- Outlands --
				[select(2,GetAchievementInfo(6604))] = 
					{31923,31925,31924,31922},
				-- Northrend --
				[select(2,GetAchievementInfo(6605))] = 
					{31931,31934,31932,31933},
				-- Cataclysm --
				[select(2,GetAchievementInfo(7525))] = 
					{31973,31972,31974}
			}
		generatezonetomaptable(tables[ONC])
		result = true
	end
	if tables[EKK] == nil then
		tables[EKK] =  
			{
				-- Horde only (Kalimdor) --
                [select(2,GetAchievementInfo(6602)).." ("..FACTION_HORDE..")"] =
					{31854,31904,31819,31908,31905,31906,31872,31871,31907,31862,31818},
				-- Alliance only (Eastern Kingdoms) --
                [select(2,GetAchievementInfo(6603)).." ("..FACTION_ALLIANCE..")"] =
					{31851,31910,31911,31914,31850,31913,31693,31912,31781,31780,31852} 
			}
		generatezonetomaptable(tables[EKK])
		result = true
	end

	return result
end

local function GenerateLine(questID)
    local s1 = "";
    if not questsdata[questID] then 
		if LOCALE == L_CN then
			return "<任务数据丢失>"
		else	
			return "<quest data missing>"
		end
	end

    -- npc level
    if DailyTamerCheck_Options["show_npclevel"] and questsdata[questID][NPCLEVEL] then
		s1 = s1..levelformat(questsdata[questID][NPCLEVEL])
    end
    -- npc pets
    if DailyTamerCheck_Options["show_npcicons"] and questsdata[questID][NPCICONS] then
		s1 = s1..questsdata[questID][NPCICONS].." "
    end
    -- zone name
    if questsdata[questID][ZONE] then
		s1 = s1..AddColor(questsdata[questID][ZONE],zonecolor)
    else
		if LOCALE == L_CN then
			s1 = s1.. "<区域丢失>"
		else
			s1 = s1.. "<zone missing>"
		end
    end
    -- npc name
    if DailyTamerCheck_Options["show_npcnames"] and questsdata[questID][NPCNAME] then
		s1 = s1.." "..AddColor(questsdata[questID][NPCNAME],npcnamecolor)
    end
    -- coordinates
    if DailyTamerCheck_Options["show_coordinates"] then
		s1 = s1.." "..AddColor(coord(questID),coordcolor)
    end
    return s1
end

local function isquestcompleted(questID)
	local result = false
	if tostring(questID):find(epspecial) then
		result = EP_iscriteriacompleted(string.gsub(tostring(questID), epspecial, ""))
	else
		result = IsQuestFlaggedCompleted(questID)
	end
	return result
end

-- main "tooltip template" frame
local function DrawTCheckMainframe(obj, tab, istooltip)
	if AddWorldEventTamers() then
		generatezonetomaptable(tables[SAT])
	end
	obj:ClearLines()
	obj:AddDoubleLine(TITLE,"|T"..dtcicon..":32|t")
	local s1,s2
	table.foreach(tab,function(k,v)
		--min width
		obj:AddLine("                                                      ")
		obj:AddLine(k)
		table.foreach(v,function(i,questID)
            if factioncheck(questID) then
            s2 = isquestcompleted(questID) and AddColor(COMPLETE,LIGHT_GREEN) or AddColor(INCOMPLETE,LIGHT_RED)
            s1 = GenerateLine(questID)    
            obj:AddDoubleLine(s1,s2)
            end
        end)
	end)
	if not istooltip then
		-- create some space for the bottom buttons
		obj:AddLine(" ")
		obj:AddLine(" ")
		obj:AddLine(" ")
		if TomTom then
			obj:AddLine(" ")
		end
	end
end

-- lateral frames
local function DrawTCheckFrame(obj, tab)
	local s1,s2
	local tmpleft  = ""
	local tmpright = ""
	obj.maxwidth = 1

	local function adddoubleline(left,right)
		tmpleft  = tmpleft.."\n"..left
		tmpright = tmpright.."\n"..right
  
		local lefttmp
		lefttmp = string.gsub(left,"|c........","")
		lefttmp = string.gsub(lefttmp,"|r","")
		obj.leftfont:SetText(lefttmp..right)
		local tmplen = obj.leftfont:GetStringWidth(obj.leftfont)+40
		if (tmplen > obj.maxwidth) then
			obj.maxwidth = tmplen
		end
	end

	table.foreach(tab,function(k,v)
		adddoubleline("","")
		if k:find(ep_header) then -- elite pets special
			local book = EP_GetBook_index(string.gsub(k, ep_header, ""))
			if IsQuestFlaggedCompleted(book.questID) then
				s2 = AddColor(COMPLETE,LIGHT_GREEN)
				book.completed = true
			else
				s2 = AddColor(INCOMPLETE,LIGHT_RED)
			end
			adddoubleline(AddColor(book.qname ~= "" and book.qname or k,GOLD).." "..s2,"")
		else
			adddoubleline(AddColor(k,GOLD),"")
		end
		local wrotesomething = false
		local qmissing = true
		table.foreach(v,function(_,questID)
					
            if factioncheck(questID) then
				-- elite pets special
				if tostring(questID):find(epspecial) then
					local book = EP_GetBook_pet(string.gsub(questID,epspecial,""))
					if book ~= nil then
						if not book.completed and book.index > -1 then
							s2 = isquestcompleted(questID) and AddColor(COMPLETE,LIGHT_GREEN) or AddColor(INCOMPLETE,LIGHT_RED)
							s1 = GenerateLine(questID,info)
							adddoubleline(s1,s2)
						elseif book.index == -1 and not book.completed and qmissing then
							qmissing = false
							adddoubleline(ep_quest_missing,"")
						end
					end
				else
					s2 = isquestcompleted(questID) and AddColor(COMPLETE,LIGHT_GREEN) or AddColor(INCOMPLETE,LIGHT_RED)
					s1 = GenerateLine(questID,info)
					adddoubleline(s1,s2)
				end
            wrotesomething = true
            end
        end)
		if not wrotesomething then
			adddoubleline(AddColor(ADDON_DISABLED,LIGHT_RED),"")
		end
	end)

	obj.leftfont:SetText(tmpleft)
	obj.rightfont:SetText(tmpright)
end

local function CheckFramesAnimation(frame,id)
	if (frame) and (frame:IsVisible()) and (frame.maxwidth ~= nil) and (frame.width ~= nil) and (frame.opening ~= nil) then
		if frame.opening then
			if frame.width < frame.maxwidth then
				frame.width = frame.width + opt_framespeed
				if id == ABOUT then
					frame:SetHeight(frame.width)
				else
					frame:SetWidth(frame.width)
				end
			elseif (not frame.leftfont:IsVisible()) then
				frame.leftfont:Show()
				frame.rightfont:Show()
			end
		else -- closing
			if frame.width > opt_framespeed then
				frame.width = frame.width - opt_framespeed
				if id == ABOUT then
					frame:SetHeight(frame.width)
				else
					frame:SetWidth(frame.width)
				end
				if (frame.leftfont:IsVisible()) then
					frame.leftfont:Hide()
					frame.rightfont:Hide()
				end
			else
				frame:Hide()
			end
		end
	end
end

local function OnOptionChanged(opt)
	if opt == "show_npclevel" then
		table.foreach(tables, function(_,x)
			table.foreach(x, function(k,v)
				table.sort(v,function (a,b)
					if (DailyTamerCheck_Options["show_npclevel"]) then    
						if (questsdata[a][NPCLEVEL] and questsdata[b][NPCLEVEL]) then
							return questsdata[a][NPCLEVEL] < questsdata[b][NPCLEVEL]
						end
					else
						return a < b
					end
				end)
			end)
		end)
	end
end

local ID_MINIMAP_SPECIAL = 99
local function CreateCheckbox(parent,id,option,s_tooltip, h_tooltip,tx,offsetX,offsetY)
	local chkbox
	local function setcheckboxtexture(flag)
		local shaderSupported = chkbox.texture:SetDesaturated(not flag);
		if not shaderSupported then
			if not flag then
				chkbox.texture:SetVertexColor(0.5, 0.5, 0.5);
			else
				chkbox.texture:SetVertexColor(1.0, 1.0, 1.0);
			end
		end
	end

	if not parent.checkbox[id] then
		chkbox = CreateFrame("FRAME", nil, parent.optionsframe)
		chkbox.texture = chkbox:CreateTexture()
	else 
		chkbox = parent.checkbox[id]
	end

	chkbox:SetPoint("CENTER", parent.optionsframe, "CENTER",offsetX,offsetY)
	--chkbox:SetFrameStrata("HIGH")
	chkbox:SetWidth(20)
	chkbox:SetHeight(20)
	chkbox.texture:SetPoint("LEFT", chkbox, "LEFT")
	chkbox.texture:SetTexture(tx)
	chkbox.texture:SetWidth(20)
	chkbox.texture:SetHeight(20)
	if id == ID_MINIMAP_SPECIAL then
		setcheckboxtexture(not DailyTamerCheck_Options["minimap_icon"].hide)
	else
		setcheckboxtexture(DailyTamerCheck_Options[option])
	end

	chkbox:SetScript("OnMouseUp", function(self)
		if id == ID_MINIMAP_SPECIAL then -- it's pretty rough.. I know :p
			DailyTamerCheck_Options["minimap_icon"].hide = not DailyTamerCheck_Options["minimap_icon"].hide;
			ldbicon:Refresh("DailyTamerCheck", DailyTamerCheck, DailyTamerCheck_Options["minimap_icon"])
			setcheckboxtexture(not DailyTamerCheck_Options["minimap_icon"].hide)
		else
			DailyTamerCheck_Options[option] = not DailyTamerCheck_Options[option]
			GameTooltip:ClearLines()
			local showTip
			if (DailyTamerCheck_Options == nil) then	
				showTip = s_tooltip
			else 
				if (DailyTamerCheck_Options[option] == nil) then
					showTip = s_tooltip
				elseif (DailyTamerCheck_Options[option] == false) then
					showTip = s_tooltip
				else
					showTip = h_tooltip
				end
			end
			GameTooltip:AddLine(showTip)
			GameTooltip:Show()				
			OnOptionChanged(option)
			DrawTCheckMainframe(DailyTamerCheck_mainframe,tables[SAT],false)
			setcheckboxtexture(DailyTamerCheck_Options[option])
			DailyTamerCheck_mainframe:Show()
		end
	end)
  
	chkbox:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(chkbox,"ANCHOR_BOTTOM",0,-5)
		GameTooltip:ClearLines()
		local showTip
		if (DailyTamerCheck_Options == nil) then	
			showTip = s_tooltip
		else 
			if (DailyTamerCheck_Options[option] == nil) then
				showTip = s_tooltip
			elseif (DailyTamerCheck_Options[option] == false) then
				showTip = s_tooltip
			else
				showTip = h_tooltip
			end
		end
		GameTooltip:AddLine(showTip)
		GameTooltip:Show()
	end)  

	chkbox:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
  
	parent.checkbox[id] = chkbox
	chkbox:Hide()
end --CreateCheckBox

local function CreateNewFrameButton(id,pos,tx)
	local result, button
	if not DailyTamerCheck_mainframe.buttons[id] then
		button = CreateFrame("FRAME", nil, DailyTamerCheck_mainframe)
	else 
		button = DailyTamerCheck_mainframe.buttons[id]
	end
	if not button.texture then
		button.texture = button:CreateTexture()
	end
	if not DailyTamerCheck_mainframe.frames[id] then
		result = CreateFrame("Frame")
	else 
		result = DailyTamerCheck_mainframe.frames[id]
	end
	result:SetParent(DailyTamerCheck_mainframe)
	result:SetBackdrop(frames_backdrop);
	result:SetBackdropColor(0,0,0,0.8);
	if not result.leftfont then
		result.leftfont = result:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	end
	result.leftfont:SetParent(result)
	result.leftfont:SetPoint("TOPLEFT",10,-10)
	if not result.rightfont then
		result.rightfont = result:CreateFontString(nil, "OVERLAY", "GameTooltipText")
	end
	result.rightfont:SetParent(result)
	result.rightfont:SetPoint("TOPRIGHT",-10,-10)
	result.width = 1
	if id == ABOUT then
		result.leftfont:SetText(AddColor(" " ..TITLE.." ",GOLD).."\n"..
											 AddColor(" by\n",GREY)..
											 AddColor(" Fluffies",LIGHT_BLUE)..
											 AddColor(" EU-Well of Eternity",GREY))
		result.rightfont:SetText("|T"..dtcicon..":24|t\n")
		result.maxwidth = 60
	else
		result.maxwidth = 200
	end

	result.leftfont:Hide()
	result.rightfont:Hide()

	result:SetFrameStrata("DIALOG")
	result:SetScale(0.9)
	result:SetClampedToScreen(true)
	result:ClearAllPoints()
	if pos == "left" then
		result:SetPoint("TOPRIGHT", DailyTamerCheck_mainframe, "TOPLEFT")
		result:SetPoint("BOTTOMRIGHT", DailyTamerCheck_mainframe, "BOTTOMLEFT")
	elseif pos == "right" then
		result:SetPoint("TOPLEFT", DailyTamerCheck_mainframe, "TOPRIGHT")
		result:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMRIGHT")
	elseif pos == "bottomright" or pos == "bottomleft" then
		result:SetPoint("TOPLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT")
		result:SetPoint("TOPRIGHT", DailyTamerCheck_mainframe, "BOTTOMRIGHT")
	end
	
	-- frame's opening/closing animation
	result:SetScript("OnUpdate", function(self)
		CheckFramesAnimation(result,id)
	end)

	if pos == "left" then
		button:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT",10,10)
	elseif pos == "right" then
		button:SetPoint("BOTTOMRIGHT", DailyTamerCheck_mainframe, "BOTTOMRIGHT",-10,10)
	elseif pos == "bottomright" then
		button:SetPoint("BOTTOM", DailyTamerCheck_mainframe, "BOTTOM",centerbuttons_spacing,10)
	elseif pos == "bottomleft" then
		button:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT",45,10)
	end
	button:SetWidth(25)
	button:SetHeight(25)
	button.texture:SetAllPoints()
	button.texture:SetTexture(tx)

	button:SetScript("OnEnter", function(self)
		result.opening = true
		result:SetWidth(result.width)
		if id == EKK or id == ONC then
			DrawTCheckFrame(result,tables[id])
		end
		result:Show()
	end)

	button:SetScript("OnLeave", function(self)
		if result then 
			result.opening = false 
		end
	end)

	button:Show()
	if result.opening then 
		result:Show() 
	else 
		result:Hide() 
	end
	DailyTamerCheck_mainframe.frames[id] = result;
	DailyTamerCheck_mainframe.buttons[id] = button;
end --CreateNewFrameButton

local function tamerquestcheck()
	if DailyTamerCheck_mainframe and DailyTamerCheck_mainframe:IsVisible() then
		DailyTamerCheck_mainframe:Hide()
		if DTCMenuFrame then 
			DTCMenuFrame:Hide() 
		end
		collectgarbage()
	else
		if not DailyTamerCheck_mainframe then
			DailyTamerCheck_mainframe = CreateFrame("GameTooltip", "DailyTamerCheck_mainframe", nil, "GameTooltipTemplate")
		end
  
		DailyTamerCheck_mainframe:SetOwner(UIParent,"ANCHOR_NONE")
		DailyTamerCheck_mainframe:SetPoint("CENTER",UIParent,"CENTER")
		DailyTamerCheck_mainframe:SetFrameStrata("HIGH")
		DailyTamerCheck_mainframe:EnableMouse(true)
		DailyTamerCheck_mainframe:SetMovable()
		DailyTamerCheck_mainframe:SetScale(0.9)
		DailyTamerCheck_mainframe:RegisterForDrag("LeftButton")
		DailyTamerCheck_mainframe:SetScript("OnDragStart", function(self)  
			self:StartMoving()
		end)
		DailyTamerCheck_mainframe:SetScript("OnDragStop", function(self) 
			self:StopMovingOrSizing()
		end)

		if not DailyTamerCheck_mainframe.buttons then
			DailyTamerCheck_mainframe.buttons  = {}
		end
		if not DailyTamerCheck_mainframe.frames then
			DailyTamerCheck_mainframe.frames = {}
		end
		CreateNewFrameButton(EKK,"left",tx_btnkalim)
		CreateNewFrameButton(ONC,"right",tx_btnnorth)
		CreateNewFrameButton(ABOUT,"bottomright",tx_btnabout)
  
		-- options' checkboxes
		if not DailyTamerCheck_mainframe.optionsframe then
			DailyTamerCheck_mainframe.optionsframe = CreateFrame("FRAME", nil, DailyTamerCheck_mainframe)
			DailyTamerCheck_mainframe.optionsframe.texture = DailyTamerCheck_mainframe.optionsframe:CreateTexture()
			--DailyTamerCheck_mainframe.optionsframe:SetPoint("BOTTOMLEFT", DailyTamerCheck_mainframe, "BOTTOMLEFT",45,10)
			DailyTamerCheck_mainframe.optionsframe:SetPoint("BOTTOM",DailyTamerCheck_mainframe,"BOTTOM",-centerbuttons_spacing,10)
			DailyTamerCheck_mainframe.optionsframe:SetWidth(25)
			DailyTamerCheck_mainframe.optionsframe:SetHeight(25)
			DailyTamerCheck_mainframe.optionsframe.texture:SetAllPoints()
			DailyTamerCheck_mainframe.optionsframe.texture:SetTexture(tx_optionsframe)
			DailyTamerCheck_mainframe.optionsframe:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
			DailyTamerCheck_mainframe.optionsframe:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(DailyTamerCheck_mainframe.optionsframe,"ANCHOR_TOP",0,5)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(s_optionsmain)
				GameTooltip:Show()
			end)
    
			DailyTamerCheck_mainframe.optionsframe:SetScript("OnMouseUp", function(self)
				if not DailyTamerCheck_mainframe.optionsframe.open then
					table.foreach(DailyTamerCheck_mainframe.checkbox, function(k,v) 
						if not v:IsVisible() then 
							v:Show() 
						end 
					end)
					DailyTamerCheck_mainframe.optionsframe.open = true;
					DailyTamerCheck_mainframe.optionsframe.texture:SetVertexColor(0.5,1,0.5,1)
				else
					table.foreach(DailyTamerCheck_mainframe.checkbox, function(k,v) 
						if v:IsVisible() then 
							v:Hide() 
						end 
					end)
					DailyTamerCheck_mainframe.optionsframe.open = false;
					DailyTamerCheck_mainframe.optionsframe.texture:SetVertexColor(1,1,1,1)
				end
			end)
		end
		DailyTamerCheck_mainframe.optionsframe.texture:SetVertexColor(1,1,1,1)
		DailyTamerCheck_mainframe.optionsframe.open = false;
		if not DailyTamerCheck_mainframe.checkbox then 
			DailyTamerCheck_mainframe.checkbox = {} 
		end
		CreateCheckbox(DailyTamerCheck_mainframe,0,"show_coordinates",
                         s_togglecoords,h_togglecoords,tx_chkcoords,-20,-25)
		CreateCheckbox(DailyTamerCheck_mainframe,1,"show_npcnames",
                         s_togglenpcnames,h_togglenpcnames,tx_chknames,0,-25)
		CreateCheckbox(DailyTamerCheck_mainframe,2,"show_npclevel",
                         s_togglenpclevel,h_togglenpclevel,tx_chklevel,40,-25)
		CreateCheckbox(DailyTamerCheck_mainframe,3,"show_npcicons",
                         s_togglenpcicons,h_togglenpcicons,tx_chkicons,-40,-25)
		CreateCheckbox(DailyTamerCheck_mainframe,4,"show_mapicons",
                         s_togglemapicons,h_togglemapicons,tx_chkmapicons,0,-45)
		CreateCheckbox(DailyTamerCheck_mainframe,5,"show_faction",
                         s_showfaction,h_showfaction,tx_faction[playerfaction == "Alliance" and "Horde" or "Alliance"],-20,-45)
		CreateCheckbox(DailyTamerCheck_mainframe,ID_MINIMAP_SPECIAL,"",
                         s_toggleminimapbtn,h_toggleminimapbtn,tx_chkminimap,20,-25)

		DrawTCheckMainframe(DailyTamerCheck_mainframe,tables[SAT],false)

		if not btnclose then
			btnclose = CreateFrame("Button", "dtcclosebtn", DailyTamerCheck_mainframe, "UIPanelButtonTemplate")
			btnclose:SetPoint("BOTTOM", DailyTamerCheck_mainframe, "BOTTOM",0,10)
			btnclose:SetWidth(100)
			btnclose:SetText(CLOSE)
			btnclose:SetScript("OnClick", function(self)
				if DailyTamerCheck_mainframe.frames then
					table.foreach(DailyTamerCheck_mainframe.frames,function(k,v) 
						v:Hide() 
					end)
				end
				DailyTamerCheck_mainframe:Hide()
				if DTCMenuFrame then 
					DTCMenuFrame:Hide() 
				end
				collectgarbage()
			end)
		end

		-- TomTom Integration --
		if TomTom and DTCMenuFrame then
			local function CreateSubMenu(q)  
				local submenu = {}
				table.foreach(q, function(_,questID)
					if questsdata[questID] then
						table.insert(submenu, 
							{ 
								text = questsdata[questID][NPCNAME].." - "..questsdata[questID][ZONE].." "..coord(questID),
								disabled = isquestcompleted(questID),
								notCheckable = 1,
								keepShownOnClick = true,
								func = function(self)
									if questsdata[questID][MAPDATA] then
										TomTom:AddMFWaypoint(questsdata[questID][MAPDEFAULT], nil,
											questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][1] / 100,
											questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][2] / 100,
											{ 
												title = questsdata[questID][NPCNAME]
											})
										print(s_tomtomset.." ("..AddColor(questsdata[questID][NPCNAME],LIGHT_BLUE)..")")
									end
								end
                            })
					end
				end)
				return submenu
			end

			DTCTTmenu = {}
			local tx_TomTomTitle
			local tx_AddTomTomPoint
			local tx_SetTomTomPoint
			local tx_TomTomeClose
			if LOCALE == L_CN then
				tx_TomTomTitle = AddColor("- TomTom路径点 -",GOLD)
			else 
				tx_TomTomTitle = AddColor("- TomTom Waypoints -",GOLD)
			end	
			if LOCALE == L_CN then
				tx_AddTomTomPoint = AddColor("点击任意单独任务或者任务分组添加路径点",LIGHT_BLUE)
			else 
				tx_AddTomTomPoint = AddColor("Click either a single quest or a group" ,LIGHT_BLUE)
			end	
			if LOCALE == L_CN then
				tx_SetTomTomPoint = AddColor("设置TomTom路径点",LIGHT_BLUE)
			else 
				tx_SetTomTomPoint = AddColor("to set TomTom waypoints",LIGHT_BLUE)
			end	
			if LOCALE == L_CN then
				tx_TomTomeClose = "关闭"
			else 
				tx_TomTomeClose = "Close"
			end	
			table.insert(DTCTTmenu, {text = tx_TomTomTitle,endnotCheckable = 1,isTitle = true})
			table.insert(DTCTTmenu, {text = tx_AddTomTomPoint,notCheckable = 1, isTitle = true})
			table.insert(DTCTTmenu, {text = tx_SetTomTomPoint,notCheckable = 1, isTitle = true})
			table.insert(DTCTTmenu, {text = "",notCheckable = 1, isTitle = true})

			table.foreach(tables, function(k,tab)
				local pref = k == SAT and "|T"..tx_bagicon..":12|t" or ""
				table.foreach(tab, function(header,quests)
					table.insert(DTCTTmenu, 
						{ 
							text = pref..header,
							keepShownOnClick = true,
							notCheckable = 1,
							func = function(self)
								table.foreach(quests, function(_,questID)
									if questsdata[questID][MAPDATA] and not isquestcompleted(questID) then
										TomTom:AddMFWaypoint(questsdata[questID][MAPDEFAULT], nil,
											questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][1] / 100,
											questsdata[questID][MAPDATA][questsdata[questID][MAPDEFAULT]][2] / 100,
											{ 
												title = questsdata[questID][NPCNAME] 
											})
										print(s_tomtomset.." ("..AddColor(questsdata[questID][NPCNAME],LIGHT_BLUE)..")")
									end
								end)
							end,
							hasArrow = true, 
							menuList = CreateSubMenu(quests)
						})
				end)
			end)
			table.insert(DTCTTmenu, {text = "", isTitle = true, notCheckable = 1})
			table.insert(DTCTTmenu, {text = tx_TomTomeClose, notCheckable = 1})

			DailyTamerCheck_mainframe.Itomtomframe = CreateFrame("FRAME", nil, DailyTamerCheck_mainframe)
			DailyTamerCheck_mainframe.Itomtomframe:SetPoint("BOTTOMLEFT",DailyTamerCheck_mainframe,"BOTTOMLEFT",5,40)
			DailyTamerCheck_mainframe.Itomtomframe:SetWidth(60)
			DailyTamerCheck_mainframe.Itomtomframe:SetHeight(25)
			DailyTamerCheck_mainframe.Itomtomframe.text = DailyTamerCheck_mainframe.Itomtomframe:CreateFontString(nil, "OVERLAY")
			DailyTamerCheck_mainframe.Itomtomframe.text:SetAllPoints()
			DailyTamerCheck_mainframe.Itomtomframe.text:SetFont("Fonts\\FRIZQT__.TTF", 12)
			DailyTamerCheck_mainframe.Itomtomframe.text:SetText("TomTom")
			DailyTamerCheck_mainframe.Itomtomframe:SetBackdrop(frames_backdrop);
			DailyTamerCheck_mainframe.Itomtomframe:SetBackdropColor(1,0,0.3,1);
			DailyTamerCheck_mainframe.Itomtomframe:SetScript("OnLeave", function(self)
				GameTooltip:Hide()
			end)
			
			DailyTamerCheck_mainframe.Itomtomframe:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(DailyTamerCheck_mainframe.Itomtomframe,"ANCHOR_TOP",0,5)
				GameTooltip:ClearLines()
				GameTooltip:AddLine(s_tomtomintegration)
				GameTooltip:Show()
			end)
			
			DailyTamerCheck_mainframe.Itomtomframe:SetScript("OnMouseUp", function()
				if DTCMenuFrame then
					if DTCMenuFrame:IsVisible() then
						DTCMenuFrame:Hide()
					end
					DTCMenuFrame:SetPoint("TOP",DailyTamerCheck_mainframe.Itomtomframe,"BOTTOM",0,-5)
					EasyMenu(DTCTTmenu, DTCMenuFrame, DTCMenuFrame, 0 , 0, "MENU")
				end
			end)
		end
 
		DailyTamerCheck_mainframe:Show()

		-- show latest changes --
		if tutorial_level >= 1 then
			local tutorialframe = CreateFrame("FRAME")
			tutorialframe:SetParent(DailyTamerCheck_mainframe)
			tutorialframe:SetPoint("TOP",DailyTamerCheck_mainframe,"BOTTOM",0,-20)
			tutorialframe:SetBackdrop(frames_backdrop);
			tutorialframe:SetBackdropColor(0,0,0,0.8);
			local start = GetTime()
			tutorialframe:SetScript("OnUpdate", function()
				local t = GetTime()
				tutorialframe:SetBackdropColor(0,0,math.sin(t)+0.3,0.8)
				if t - start > 25 then -- I think 20 seconds is enough
					tutorialframe:SetScript("OnUpdate", nil)
					tutorialframe:Hide()
					tutorialframe.text = nil
					tutorialframe = nil
					return
				end
			end)
			tutorialframe.text = tutorialframe:CreateFontString(nil, "OVERLAY", "GameTooltipText")
			tutorialframe.text:SetJustifyH("LEFT")
			tutorialframe.text:SetJustifyV("TOP")
			tutorialframe.text:SetAllPoints()
			if LOCALE == L_CN then
				local s = "\n"..AddColor("  新增的内容: \n", GOLD)
				--if tutorial_level >= 2 then -- this user didn't see the previous version either
				if tutorial_level >= 1 then -- this version is new
					s = s..AddColor(" - 提示!\n",LIGHT_RED)
					s = s..AddColor(" - 新增选项: ",LIGHT_GREEN)..AddColor("显示世界地图图标选项 \n",WHITE)
					s = s..AddColor(" - 新增选项: ",LIGHT_GREEN)..AddColor("显示对立阵营任务选项 \n",WHITE)
					s = s..AddColor(" - 新增按钮: ",LIGHT_BLUE)..AddColor("TomTom整合按钮 \n",WHITE)
					s = s..AddColor("    (只有在TomTom插件可用的情况下才显示.) \n\n",GREY)
					s = s..AddColor(" 这个提示不久后将消失.",GREY)
					tutorialframe.text:SetText(s)
					tutorialframe:SetWidth(tutorialframe.text:GetStringWidth() + 10)
					tutorialframe:SetHeight(tutorialframe.text:GetStringHeight() + 10)
				end
			else			
				local s = "\n"..AddColor("  What's new: \n", GOLD)
				--if tutorial_level >= 2 then -- this user didn't see the previous version either
				if tutorial_level >= 1 then -- this version is new
					s = s..AddColor(" - This frame!\n",LIGHT_RED)
					s = s..AddColor(" - New option: ",LIGHT_GREEN)..AddColor("Toggle world map icons \n",WHITE)
					s = s..AddColor(" - New option: ",LIGHT_GREEN)..AddColor("Show other faction tamers \n",WHITE)
					s = s..AddColor(" - New button: ",LIGHT_BLUE)..AddColor("TomTom integration \n",WHITE)
					s = s..AddColor("    (only available with the TomTom addon active) \n\n",GREY)
					s = s..AddColor(" This frame will disappear shortly.",GREY)
					tutorialframe.text:SetText(s)
					tutorialframe:SetWidth(tutorialframe.text:GetStringWidth() + 10)
					tutorialframe:SetHeight(tutorialframe.text:GetStringHeight() + 10)
				end
			end

			tutorial_level = 0
		end
	end
end

--- world map section
DailyTamerCheck_mapframe = CreateFrame("Frame")
DailyTamerCheck_mapframe:SetParent(WorldMapButton)
DailyTamerCheck_mapframe:SetAllPoints()
DailyTamerCheck_mapframe.framespool = {}
CreateFrame("GameTooltip","DailyTamerCheck_maptooltip", nil, "GameTooltipTemplate")
DailyTamerCheck_maptooltip:SetFrameStrata("TOOLTIP")
DailyTamerCheck_maptooltip:SetScale(0.8)

local function createmapbutton()
	local f = CreateFrame("FRAME")
	f:SetParent(DailyTamerCheck_mapframe)
	f:SetPoint("CENTER",DailyTamerCheck_mapframe,"CENTER")
	f.data = {}
	f:SetScript("OnMouseUp", function(_, mousebutton)
		--if IsControlKeyDown() and mousebutton == "LeftButton" then
			-- actually TomTom can set waypoints by Ctrl-Rightclicking, so no need of it
			--return
		--end
		WorldMapButton_OnClick(WorldMapButton, mousebutton)
	end)
	
	f:SetScript("OnEnter", function()
		DailyTamerCheck_maptooltip:SetOwner(f,"ANCHOR_BOTTOM")
		DailyTamerCheck_maptooltip:ClearLines()
		DailyTamerCheck_maptooltip:AddLine((questsdata[f.data][NPCNAME] ~= nil and questsdata[f.data][NPCLEVEL] ~= nil) and levelformat(questsdata[f.data][NPCLEVEL]).." "..questsdata[f.data][NPCNAME] or "")
		DailyTamerCheck_maptooltip:AddLine(questsdata[f.data][NPCICONS] ~= nil and questsdata[f.data][NPCICONS] or "")
		DailyTamerCheck_maptooltip:Show()
	end)
	
	f:SetScript("OnLeave", function()
		DailyTamerCheck_maptooltip:Hide()
	end)
	f.tex = f:CreateTexture()
	f.tex:SetAllPoints()
	table.insert(DailyTamerCheck_mapframe.framespool,f)
	return f
end

local mapID
local active_buttons = 1
local function DTCworldmapupdate()
	DailyTamerCheck_mapframe:Hide()
	DailyTamerCheck_maptooltip:Hide()
	-- no tamers in the cosmic map or in dungeons, no needs of dtc updates if the map is not visible
	if not DailyTamerCheck_Options["show_mapicons"] or GetCurrentMapContinent() == WORLDMAP_COSMIC_ID 
		or GetNumDungeonMapLevels() ~= 0 or not WorldMapButton:IsVisible() then
		return
	end

	if mapID ~= GetCurrentMapAreaID() then
		table.foreach(DailyTamerCheck_mapframe.framespool,function(k,v) 
			v:Hide() 
		end)
		active_buttons = 1
		mapID = GetCurrentMapAreaID()
		if mapstable[mapID] then
			table.foreach(mapstable[mapID], function(_,v)
				if not isquestcompleted(v) and questsdata[v] then
					if questsdata[v][MAPDATA] and questsdata[v][MAPDATA][mapID] and factioncheck(v) then
						local tex = questsdata[v][MAPICON] and questsdata[v][MAPICON] or dtcicon
						-- pick up an unused frame or create a new one
						local f = DailyTamerCheck_mapframe.framespool[active_buttons] ~= nil and DailyTamerCheck_mapframe.framespool[active_buttons] or createmapbutton()
						local x = questsdata[v][MAPDATA][mapID][1]
						local y = questsdata[v][MAPDATA][mapID][2]
						f:SetWidth(questsdata[v][MAPDEFAULT] == mapID and 22 or 14)
					    f:SetHeight(questsdata[v][MAPDEFAULT] == mapID and 22 or 14)
						f:SetPoint("CENTER",DailyTamerCheck_mapframe,"TOPLEFT",
							-- I simply treat coordinates as a percentage of the width/height of the map frame
							DailyTamerCheck_mapframe:GetWidth()  * x / 100,
							-DailyTamerCheck_mapframe:GetHeight() * y / 100)
						f.data = v
						f.tex:SetTexture(tex,1)
						f:Show()
						active_buttons = active_buttons + 1
					end
				end
			end)
		end
	end

	if active_buttons > 1 then
		DailyTamerCheck_mapframe:Show()
	end
end

-- resizing the map through those buttons does not fire the world_map_update event,
-- even if that changes the mapID to the player's current map, so I hook them
WorldMapFrameSizeDownButton:HookScript("OnClick", DTCworldmapupdate)
WorldMapFrameSizeUpButton:HookScript("OnClick", DTCworldmapupdate)
--- world map section end

local ldbset = false
local epnameset = {}
local eventframe = CreateFrame("FRAME","DTCEventFrame")
eventframe:RegisterEvent("PLAYER_ENTERING_WORLD")
eventframe:RegisterEvent("VARIABLES_LOADED")
eventframe:RegisterEvent("QUEST_LOG_UPDATE")
eventframe:RegisterEvent("WORLD_MAP_UPDATE")
local function eventhandler(self, event, ...)
	if event=="WORLD_MAP_UPDATE" and WorldMapFrame:IsVisible() then
		DTCworldmapupdate()
	elseif event == "QUEST_LOG_UPDATE" then -- elite pets check
		local i, j, s, book
		EP_resetbooks()
		for i = 1, GetNumQuestLogEntries() do
			book = nil
			s = GetQuestLink(i)
			if s then
				table.foreach(ep_books, function(k,v)
					if tonumber(string.match(s, "Hquest:(%d+)")) == v.questID then
						book = v
					end
				end)
			end

			if book then
				book.index = i
				book.qname = select(1,GetQuestLogTitle(book.index))
				for _,j in pairs(book.pets) do
					if not epnameset[j] then
						local petname = getelitepetname(j)
						if petname ~= nil then
							questsdata[epspecial..j][NPCNAME] = petname
							epnameset[j] = true
						end
					end
				end
			end -- quest found
		end
	elseif event == "PLAYER_ENTERING_WORLD" then
		OpenCalendar()
		if GenerateTables() then
			-- initial sorting
			OnOptionChanged("show_npclevel")
		end
	--eventframe:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "VARIABLES_LOADED" then
		if DailyTamerCheck_Options == nil then
			DailyTamerCheck_Options = {}
		end
		if DailyTamerCheck_Options["show_coordinates"] == nil then -- show coords
			DailyTamerCheck_Options["show_coordinates"] = false
		end
		if DailyTamerCheck_Options["show_npcnames"] == nil then -- show npcnames
			DailyTamerCheck_Options["show_npcnames"] = false
		end
		if DailyTamerCheck_Options["show_npclevel"] == nil then -- sort by pet level
			DailyTamerCheck_Options["show_npclevel"] = false
		end
		if DailyTamerCheck_Options["show_npcicons"] == nil then -- show pet icons
			DailyTamerCheck_Options["show_npcicons"] = false
		end
		if DailyTamerCheck_Options["show_mapicons"] == nil then -- show world map icons
			DailyTamerCheck_Options["show_mapicons"] = false
		end
		if DailyTamerCheck_Options["show_faction"] == nil then -- show other faction tamers
			DailyTamerCheck_Options["show_faction"] = true
		end
		--- TomTom integration ---
		if TomTom then
			CreateFrame("Frame", "DTCMenuFrame", UIParent, "UIDropDownMenuTemplate")
		end
		if DailyTamerCheck_Options["minimap_icon"] == nil then -- show minimap icon
			DailyTamerCheck_Options["minimap_icon"] = 
				{
					hide = false,
					minimapPos = 220,
				}
		end
		if DailyTamerCheck_Options["DTC_Version"] == nil then -- addon version
			DailyTamerCheck_Options["DTC_Version"] = 0
		end
		if DailyTamerCheck_Options["DTC_Version"] < DTCversion then
			tutorial_level = DTCversion - DailyTamerCheck_Options["DTC_Version"]
		end
		DailyTamerCheck_Options["DTC_Version"] = DTCversion

		if ldb and not ldbset then
			local DailyTamerCheck = ldb:NewDataObject("DailyTamerCheck", 
				{
					type = "data source",
					icon = dtcicon,
					label = LBLTITLE,
					text = TITLE,
					OnClick = function(self,button)
						tamerquestcheck()
					end,
					OnTooltipShow = function(tooltip)
						DrawTCheckMainframe(tooltip,tables[SAT],true)
					end,
				})
			if ldbicon then
				ldbicon:Register("DailyTamerCheck", DailyTamerCheck, DailyTamerCheck_Options["minimap_icon"])
			end
			ldbset = true;
		end
	end
end

local function RefreshCheckBoxTexture(option, id, flag)
	if (option == nil or DailyTamerCheck_mainframe == nil or DailyTamerCheck_mainframe.checkbox == nil) then
		return
	end
	local parent = DailyTamerCheck_mainframe.checkbox
	if (parent[id] == nil) then
		return
	else
		local chkbox = parent[id]		
		local shaderSupported = chkbox.texture:SetDesaturated(not flag);
		if not shaderSupported then
			if not flag then
				chkbox.texture:SetVertexColor(0.5, 0.5, 0.5);
			else
				chkbox.texture:SetVertexColor(1.0, 1.0, 1.0);
			end
		end
	end	
end

function RefreshOption(option, id, selected)
	if DailyTamerCheck_Options == nil then
		DailyTamerCheck_Options = {}
	end
	DailyTamerCheck_Options[option] = selected
	OnOptionChanged(option)
	if (DailyTamerCheck_mainframe == nil or tables == nil) then
		return
	end
	DrawTCheckMainframe(DailyTamerCheck_mainframe,tables[SAT],false)
	RefreshCheckBoxTexture(option, id, DailyTamerCheck_Options[option])
	DailyTamerCheck_mainframe:Show()
end

function GetOptionValue(option)
	if DailyTamerCheck_Options == nil or DailyTamerCheck_Options[option] == nil then
		if option == "show_faction" then 
			return true
		else
			return false
		end
	else
		return DailyTamerCheck_Options[option] 	
	end
end

eventframe:SetScript("OnEvent", eventhandler);
-- slash command
SLASH_DAILYTAMERCHECK1 = "/dtcheck"
SLASH_DAILYTAMERCHECK2 = "/dtc"
SlashCmdList["DAILYTAMERCHECK"] = tamerquestcheck