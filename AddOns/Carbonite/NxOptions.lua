local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
--local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxOptions - Options
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Tables

Nx.OptsVars = {
	["BGShowStats"] = "~B~T",
	["CameraForceMaxDist"] = "~B",
	["CaptureEnable"] = "~B~T",
	["CaptureShare"] = "~B~T",
	["ChatMsgFrm"] = "~CH~~Chat",
	["ComNoGlobal"] = "~B",
	["ComNoZone"] = "~B",
	["EmuCartWP"] = "~B",
	["EmuTomTom"] = "~B~T",
	["FontS"] = "~CH~Friz~FontFace",
	["FontSSize"] = "~I~10~6~14",
	["FontSH"] = "~I~0~-10~20",
	["FontM"] = "~CH~Friz~FontFace",
	["FontMSize"] = "~I~12~6~20",
	["FontMH"] = "~I~0~-10~20",
	["FontInfo"] = "~CH~Arial~FontFace",
	["FontInfoSize"] = "~I~11~6~20",
	["FontInfoH"] = "~I~0~-10~20",
	["FontMap"] = "~CH~Friz~FontFace",
	["FontMapSize"] = "~I~10~6~14",
	["FontMapLoc"] = "~CH~Friz~FontFace",
	["FontMapLocSize"] = "~I~10~6~14",
	["FontMenu"] = "~CH~Friz~FontFace",
	["FontMenuSize"] = "~I~10~6~14",
	["FontQuest"] = "~CH~Friz~FontFace",
	["FontQuestSize"] = "~I~12~6~20",
	["FontQuestH"] = "~I~1~-10~20",
	["FontWatch"] = "~CH~Arial~FontFace",
	["FontWatchSize"] = "~I~11~6~20",
	["FontWatchH"] = "~I~2~-10~20",
	["FontWarehouseI"] = "~CH~Friz~FontFace",
	["FontWarehouseISize"] = "~I~11~6~20",
	["FontWarehouseIH"] = "~I~6~-10~20",
	["GryphonsHide"] = "~B~T",
	["GuideVendorVMax"] = "~I~60~1~1000",
	["HUDHide"] = "~B",
	["HUDHideInBG"] = "~B",
	["HUDLock"] = "~W~NxHUD^L",
	["HUDShowDir"] = "~B",
	["HUDAGfx"] = "~CH~Gloss~HUDAGfx",
	["HUDASize"] = "~I~44~8~100",
	["HUDAXO"] = "~F",
	["HUDAYO"] = "~F",
	["HUDTBut"] = "~B~T",
	["HUDTButColor"] = "~C~5",
	["HUDTButCombatColor"] = "~C~ff00001a",
	["HUDTSoundOn"] = "~B~T",
	["HUDATBGPal"] = "~B~T",
	["HUDATCorpse"] = "~B~T",
	["HUDATTaxi"] = "~B~T",
	["InfoLvlUpShow"] = "~B~T",
	["InfoToF"] = "~B~T",
	["InfoToG"] = "~B~T",
	["InfoToZ"] = "~B~T",
	["ItemRequest"] = "~B",
	["IWinEnable"] = "~B~T",
	["IWinBGCol"] = "",					-- Delete
	["IWinListCol"] = "~C~0",
	["IWinLock"] = "~B~T",
	["LoginHideVer"] = "~B",
	["MapButLAlt"] = "~CH~None~MapFunc",
	["MapButLCtrl"] = "~CH~Goto~MapFunc",
	["MapButM"] = "~CH~Show Player Zone~MapFunc",
	["MapButMAlt"] = "~CH~None~MapFunc",
	["MapButMCtrl"] = "~CH~None~MapFunc",
	["MapButR"] = "~CH~Menu~MapFunc",
	["MapButRAlt"] = "~CH~None~MapFunc",
	["MapButRCtrl"] = "~CH~None~MapFunc",
	["MapBut4"] = "~CH~Show Selected Zone~MapFunc",
	["MapBut4Alt"] = "~CH~Add Note~MapFunc",
	["MapBut4Ctrl"] = "~CH~None~MapFunc",
	["MapDetailSize"] = "~I~6~2~40",
	["MapIconPOIAlpha"] = "~F~1",
	["MapIconGatherAlpha"] = "",		-- Delete
	["MapIconGatherA"] = "~F~.7",
	["MapIconGatherAtScale"] = "~F~.5",
	["MapLineThick"] = "~F~1~0~10",
	["MapLocTipAnchor"] = "~CH~TopRight~Anchor0",
	["MapLocTipAnchorRel"] = "~CH~None~Anchor0",
	["MapMaxCenter"] = "~B~T",
	["MapMaxMouseIgnore"] = "~B",
	["MapMaxOverride"] = "~B~T",
	["MapMaxRestoreHide"] = "~B",
	["MapMouseIgnore"] = "~B",
	["MapMMAboveIcons"] = "~B",
	["MapMMButColumns"] = "~I~1~1~999",
	["MapMMButCorner"] = "~CH~TopRight~Corner",
	["MapMMButHide"] = "~W~NxMapDock^H",
	["MapMMButLock"] = "~W~NxMapDock^L",
	["MapMMButOwn"] = "~B",
	["MapMMButShowCarb"] = "~B~T",
	["MapMMButShowCalendar"] = "~B~T",
	["MapMMButShowClock"] = "~B~T",
	["MapMMButShowWorldMap"] = "~B~T",
	["MapMMButShowTime"] = "",				-- Old
	["MapMMButSpacing"] = "~F~29~25~90",
	["MapMMDockHigh"] = "",
	["MapMMDockAlways"] = "~B",
	["MapMMDockBugged"]="~B~T",
	["MapMMDockIndoors"] = "~B~T",
	["MapMMDockOnMax"] = "~B",
	["MapMMDockSquare"] = "~B~T",
	["MapMMDockBottom"] = "~B",
	["MapMMDockRight"] = "~B",
	["MapMMDockIScale"] = "~F~1~.01~10",
	["MapMMDockZoom"] = "~I~0",
	["MapMMDXO"] = "~F",
	["MapMMDYO"] = "~F",
	["MapMMHideOnMax"] = "~B",
	["MapMMInstanceTogFullSize"] = "~B",
	["MapMMIndoorTogFullSize"] = "~B",
	["MapMMBuggedTogFullSize"]="~B",
	["MapMMIScale"] = "~F~1~.01~10",
	["MapMMMoveCapBars"] = "~B~T",
	["MapMMNodeGD"] = "~F~.4~0~999999",
	["MapMMNodeGD"] = "~F~0~0~999999",
	["MapMMOwn"] = "~B",
	["MapMMShowOldNameplate"] = "~B~T",
	["MapMMSquare"] = "~B",
	["MapPlayerColored"] = "~B~T",
	["MapPlyrArrowSize"] = "~F~32~10~100",
	["MapRestoreScaleAfterTrack"] = "~B~T",
	["MapRouteTest"] = "",					-- Cause delete
	["MapRouteUse"] = "~B~T",
	["MapTopTooltip"] = "~B",
	["MapIconScaleMin"] = "~I~-1~-1~50",
	["MapShowCCity"] = "~B",				-- Continental
	["MapShowCExtra"] = "~B~T",
	["MapShowCTown"] = "~B",
	["MapShowGather"] = "",					-- Old
	["MapShowGatherA"] = "-~B",
	["MapShowGatherH"] = "-~B",
	["MapShowGatherM"] = "-~B",
	["MapShowMailboxes"] = "~B~T",
	["MapShowNotes"] = "~B~T",
	["MapShowPunks"] = "~B~T",
	["MapShowOthersInCities"] = "~B",
	["MapShowOthersInZ"] = "~B~T",
	["MapShowPalsInCities"] = "~B~T",
	["MapShowPOI"] = "~B~T",
	["MapShowTitleName"] = "~B~T",
	["MapShowTitleXY"] = "~B~T",
	["MapShowTitleSpeed"] = "~B~T",
	["MapShowTitle2"] = "~B",
	["MapShowToolBar"] = "~B~T",
	["MapShowTrail"] = "~B~T",
	["MapTrailCnt"] = "~I~100~0~2000",
	["MapTrailDist"] = "~F~2~.1~20",
	["MapTrailTime"] = "~I~90~1~99999",
	["MapWOwn"] = "~B~T",					-- Own blizz map window
	["MapZoneDrawCnt"] = "~I~3~1~20",
--	["MapFollowChangeScale"] = "~B~T",	-- Old
	["MenuCenterH"] = "~B",
	["MenuCenterV"] = "~B",
	["MMButWinMinimize"] = "~B",
	["PunkAreaColor"] = "~C~200e0eff",
	["PunkAreaSize"] = "~F~80~0~5000",
	["PunkBGAreaColor"] = "~C~240909ff",
	["PunkBGAreaSize"] = "~F~60~0~5000",
	["PunkIconColor"] = "~C~ff8080ff",
	["PunkMAreaColor"] = "~C~187018ff",
	["PunkMAreaSize"] = "~F~200~0~5000",
	["PunkMAlertText"] = "~B~T",
	["PunkMAlertSnd"] = "~B~T",
	["PunkShowInNorthrend"] = "~B",
	["PunkShowInSafeArea"] = "~B",
	["PunkNewLocalWarnChat"] = "~B~T",
	["PunkNewLocalWarnSnd"] = "~B",
	["PunkShowInBG"] = "~B~T",
	["PunkShowTButtons"] = "",				-- Old
	["PunkTWinTitle"] = "~S~Punks:",
	["PunkTWinHide"] = "~W~NxPunkHUD^H",
	["PunkTWinLock"] = "~W~NxPunkHUD^L",
	["PunkTWinMaxButs"] = "~I~5~1~30",
	["QEnable"] = "~B~T",
	["QAddTooltip"] = "~B~T",
	["QAutoAccept"] = "~B",
	["QAutoTurnIn"] = "~B",
	["QAutoTurnInAC"] = "~B",
	["QBroadcastQChanges"] = "~B~T",
	["QBroadcastQChangesObj"] = "",		-- Old
	["QBroadcastQChangesNum"] = "~I~999~1~999",	
	["QDetailBC"] = "~C~c0c070ff",
	["QDetailTC"] = "~RGB~201008ff",
	["QDetailScale"] = "~F~.95~.5~2",
	["QHCheckCompleted"] = "~B~T",
	["QLevelsToLoad2"] = "",				-- Old
	["QLevelsToLoad3"] = "~I~90~0~90",
	["QMapShowQuestGivers"] = "",			-- Old
	["QMapShowQuestGivers3"] = "-~I~1",
	["QMapQuestGiversHighLevel"] = "~I~85",
	["QMapQuestGiversLowLevel"] = "~I~85",
	["QMapShowWatchAreas"] = "~B~T",
	["QMapWatchAreaAlpha"] = "~C~ffffff60",
	["QMapWatchAreaGfx"] = "~CH~Solid~QArea",
	["QMapWatchAreaTrackColor"] = "~C~b0b0b080",
	["QMapWatchAreaHoverColor"] = "~C~ffffff98",
	["QMapWatchColorPerQ"] = "~B~T",
	["QMapWatchColorCnt"] = "~I~12~1~12",
	["QMapWatchC1"] = "~RGB~ff0000ff",
	["QMapWatchC2"] = "~RGB~00ff00ff",
	["QMapWatchC3"] = "~RGB~3333ffff",
	["QMapWatchC4"] = "~RGB~ffff00ff",
	["QMapWatchC5"] = "~RGB~00ffffff",
	["QMapWatchC6"] = "~RGB~ff00ffff",
	["QMapWatchC7"] = "~RGB~ff7f00ff",
	["QMapWatchC8"] = "~RGB~00ff7fff",
	["QMapWatchC9"] = "~RGB~7f11ffff",
	["QMapWatchC10"] = "~RGB~7fff00ff",
	["QMapWatchC11"] = "~RGB~007fffff",
	["QMapWatchC12"] = "~RGB~ff007fff",
	["QPartyShare"] = "~B~T",
	["QShowDailyCount"]="~B~T",
	["QShowDailyReset"] = "~B~T",
	["QShowId"] = "~B",
	["QShowLinkExtra"] = "~B~T",
	["QSideBySide"] = "~B~T",
	["QSync"] = "~B~T",
	["QUseAltLKey"] = "~B",
	["QWAchTrack"] = "~B~T",			-- Track achievements
	["QWAchZoneShow"] = "~B~T",		-- Zone achievement
	["QWAddNew"] = "~B~T",
	["QWAddChanged"] = "~B~T",
	["QWBGColor"] = "~C~55",
	["QWBlizzModify"] = "~B~T",
	["QWChalTrack"] = "~B~T",
	["QWFadeAll"] = "~B",
	["QWFixedSize"] = "~B",
	["QWGrowUp"] = "~B",
	["QWHide"] = "~W~NxQuestWatch^H",
	["QWHideBlizz"] = "~B~T",
	["QWHideDoneObj"] = "~B",
	["QWHideRaid"] = "~B",
	["QWItemAlpha"] = "~C~ffffffa6",
	["QWItemScale"] = "~F~10~0~50",
	["QWKeyUseItem"] = "~S",
	["QWLargeFont"] = "~B",
	["QWLock"] = "~W~NxQuestWatch^L",
	["QWOCntFirst"] = "~B",
	["QWOMaxLen"] = "~I~60~20~999",
	["QWRemoveComplete"] = "~B",
	["QWScenTrack"] = "~B~T",
	["QWShowClose"] = "~B",
	["QWShowDist"] = "~B~T",
	["QWShowPerColor"] = "~B",
	["QWCompleteColor"] = "~RGB~ffd200ff",
	["QWIncompleteColor"] = "~RGB~bf9b00ff",
	["QWOCompleteColor"] = "~RGB~ffffffff",
	["QWOIncompleteColor"] = "~RGB~ccccccff",
	["QSndPlayCompleted"] = "~B~T",
	["QSnd1"] = "~B~T",
	["QSnd2"] = "~B",
	["QSnd3"] = "~B",
	["QSnd4"] = "~B",
	["QSnd5"] = "~B",
	["QSnd6"] = "~B",
	["QSnd7"] = "~B",
	["QSnd8"] = "~B",
	["QuestWatchATrack"] = "~B~F",
	["RouteGatherRadius"] = "~I~60",
	["RouteMergeRadius"] = "~I~20",
	["RouteRecycle"] = "~B",
	["SocialEnable"] = "~B~T",
	["SkinDef"] = "~B",
	["SkinWinBdColor"] = "~C~ccccffff",
	["SkinWinFixedBgColor"] = "~C~80808080",
	["SkinWinSizedBgColor"] = "~C~1f1f1fe0",
	["TeamTWinEnable"] = "~B~T",
	["TeamTWinHide"] = "~W~NxTeamHUD^H",
	["TeamTWinMaxButs"] = "~I~15~1~40",
	["TitleOff"] = "~B",
	["TitleSoundOn"] = "~B",
	["WarehouseEnable"] = "~B~T",
	["WarehouseAddTooltip"] = "~B~T",
}

Nx.OptsData = {
	{
		N = L["Welcome"],
		1,
		L["Select an options page using the list on the left"],
	},
	{
		N = L["Combat"],
		L["Combat options"],
		1,
		{
			N = L["Show Battleground Stats"],
			V = "BGShowStats",
		},
	},
	{
		N = L["Favorites"],
		L["Favorite settings"],
		1,
		{
			N = L["Import Cartographer Notes"],
			F = "NXCmdFavCartImport"
		},
	},
	{
		N = L["Font"],
		L["Font options"],
--PAIDS!
		1,
		L["Small Font"],
		{
			N = "",
			V = "FontS",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontSSize",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Spacing"],
			V = "FontSH",
			VF = "NXCmdFontChange"
		},
		1,
		L["Normal Font"],
		{
			N = "",
			V = "FontM",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontMSize",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Spacing"],
			V = "FontMH",
			VF = "NXCmdFontChange"
		},
		1,
		L["Info List Font"],
		{
			N = "",
			V = "FontInfo",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontInfoSize",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Spacing"],
			V = "FontInfoH",
			VF = "NXCmdFontChange"
		},
		1,
		L["Map Font"],
		{
			N = "",
			V = "FontMap",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontMapSize",
			VF = "NXCmdFontChange"
		},
		1,
		L["Map Location Tip Font"],
		{
			N = "",
			V = "FontMapLoc",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontMapLocSize",
			VF = "NXCmdFontChange"
		},
		1,
		L["Menu Font"],
		{
			N = "",
			V = "FontMenu",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontMenuSize",
			VF = "NXCmdFontChange"
		},
		1,
		L["Quest List Font"],
		{
			N = "",
			V = "FontQuest",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontQuestSize",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Spacing"],
			V = "FontQuestH",
			VF = "NXCmdFontChange"
		},
--PAIDE!
		1,
		L["Quest Watch List Font"],
		{
			N = "",
			V = "FontWatch",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontWatchSize",
			VF = "NXCmdFontChange"
		},
--PAIDS!
		{
			N = L["Spacing"],
			V = "FontWatchH",
			VF = "NXCmdFontChange"
		},
		1,
		L["Warehouse Item Font"],
		{
			N = "",
			V = "FontWarehouseI",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Size"],
			V = "FontWarehouseISize",
			VF = "NXCmdFontChange"
		},
		{
			N = L["Spacing"],
			V = "FontWarehouseIH",
			VF = "NXCmdFontChange"
		},
--PAIDE!
	},
	{
		N = L["General"],
		L["General options"],
		1,
		{
			N = L["Hide login messages"],
			V = "LoginHideVer",
		},
		{
			N = L["Hide login title"],
			V = "TitleOff",
		},
		{
			N = L["Play title sound"],
			V = "TitleSoundOn",
		},
		1,
		{
			N = L["Chat window for Carbonite messages"],
			V = "ChatMsgFrm",
			VF = "NXCmdUIChange"
		},
		1,
		{
			N = L["Force 'Max Camera Distance' setting higher than slider allows"],
			V = "CameraForceMaxDist",
			VF = "NXCmdCamForceMaxDist"
		},
		{
			N = L["Hide action bar gryphon graphics"],
			V = "GryphonsHide",
			VF = "NXCmdGryphonsUpdate"
		},
		{
			N = L["Emulate Cartographer Waypoints"],
			V = "EmuCartWP",
			VF = "NXCmdReload"
		},
		{
			N = L["Emulate TomTom"],
			V = "EmuTomTom",
			VF = "NXCmdReload"
		},
		{
			N = L["Enable request for missing items from server"],
			V = "ItemRequest",
		},
		{
			N = L["Show Warehouse info in item tooltips"],
			V = "WarehouseAddTooltip",
		},
	},
	{
		N = L["Guide"],
		L["Guide options"],
		1,
		{
			N = L["Maximum vendors to record"],
			V = "GuideVendorVMax",
		},
		1,
		{
			N = L["Delete Herbalism gather locations"],
			F = "NXCmdDeleteHerb"
		},
		{
			N = L["Delete Mining gather locations"],
			F = "NXCmdDeleteMine"
		},
		{
			N = L["Delete Misc (artifacts, gas) gather locations"],
			F = "NXCmdDeleteMisc"
		},
		1,
		{
			N = L["Import Carbonite Nodes Herbalism locations"],
			F = "NXCmdImportCarbHerb"
		},
		{
			N = L["Import Carbonite Nodes Mining locations"],
			F = "NXCmdImportCarbMine"
		},
		{
			N = L["Import Carbonite Nodes Misc (artifacts, gas) locations"],
			F = "NXCmdImportCarbMisc"
		},
--[[
		1,
		{
			N = "Import Cartographer Herbalism locations (OLD)",
			F = "NXCmdImportCartHerb"
		},
		{
			N = "Import Cartographer Mining locations (OLD)",
			F = "NXCmdImportCartMine"
		},
--]]
	},
	{
		N = L["Info Windows"],
		L["Info window options"],
		1,
		{
			N = L["Lock all windows"],
			V = "IWinLock",
			VF = "NXCmdInfoWinUpdate",
		},
		{
			N = L["List background color"],
			V = "IWinListCol",
			VF = "NXCmdInfoWinUpdate",
		},
	},
	{
		N = L["Map"],
		L["Map options"],
		1,
		{
			N = L["Maximize Carbonite map instead of opening normal map"],
			V = "MapMaxOverride",
		},
		{
			N = L["Center on selected zone when maximizing"],
			V = "MapMaxCenter",
		},
		{
			N = L["Ignore mouse on map except when Alt key pressed"],
			V = "MapMouseIgnore",
		},
		{
			N = L["Ignore mouse on maximized map except when Alt key pressed"],
			V = "MapMaxMouseIgnore",
		},
		{
			N = L["Move fullscreen map data into maximized Carbonite map"],
			V = "MapWOwn",
		},
		{
			N = L["Hide maximized map when ESC or map toggle (M) key pressed"],
			V = "MapMaxRestoreHide",
		},
		1,
		{
			N = L["Show friend and guild positions in city"],
			V = "MapShowPalsInCities",
		},
		{
			N = L["Show other player positions in city"],
			V = "MapShowOthersInCities",
		},
		{
			N = L["Show other player positions in zone"],
			V = "MapShowOthersInZ",
		},
		1,
		{
			N = L["Restore map scale after tracking cleared"],
			V = "MapRestoreScaleAfterTrack",
		},
		{
			N = L["Use travel routing"],
			V = "MapRouteUse",
		},
		{
			N = L["Show player movement trail"],
			V = "MapShowTrail",
		},
		{
			N = L["Player movement trail dot separation"],
			V = "MapTrailDist",
		},
		{
			N = L["Player movement trail max dot count"],
			V = "MapTrailCnt",
			VF = "NXCmdReload"
		},
		{
			N = L["Player movement trail fade time (seconds)"],
			V = "MapTrailTime",
		},
		{
			N = L["Player arrow size"],
			V = "MapPlyrArrowSize",
		},
		{
			N = L["Show map tool bar"],
			V = "MapShowToolBar",
			VF = "NXCmdMapToolBarUpdate"
		},
		{
			N = L["Location tip anchor"],
			V = "MapLocTipAnchor",
		},
		{
			N = L["Location tip anchor to map"],
			V = "MapLocTipAnchorRel",
		},
		{
			N = L["Show all tool tips above map"],
			V = "MapTopTooltip",
		},
		{
			N = L["Show 'Points of Interest' map icons"],
			V = "MapShowPOI",
		},
		{
			N = L["Icon scale minimum size. -1 disables scaling for Guide and Favorite Icons"],
			V = "MapIconScaleMin",
		},
		{
			N = L["Show party/raid members class color"],
			V = "MapPlayerColored",
		},
		{
			N = L["Icon health bar thickness (0 hides)"],
			V = "MapLineThick",
		},
		{
			N = L["Maximum number of zones to draw at a time"],
			V = "MapZoneDrawCnt",
		},
		{
			N = L["Detail graphics visible area"],
			V = "MapDetailSize",
			VF = "NXCmdReload"
		},
		1,
		L["Map window title bar"],
		{
			N = L["Show map name"],
			V = "MapShowTitleName",
		},
		{
			N = L["Show coordinates"],
			V = "MapShowTitleXY",
		},
		{
			N = L["Show speed"],
			V = "MapShowTitleSpeed",
		},
		{
			N = L["Show title line 2 (subzone, pvp, xy)"],
			V = "MapShowTitle2",
			VF = "NXCmdReload"
		},
		1,
		L["Mouse button click on map actions"],
		{
			N = L["Alt left click map"],
			V = "MapButLAlt",
		},
		{
			N = L["Ctrl left click map"],
			V = "MapButLCtrl",
		},
		{
			N = L["Middle click map"],
			V = "MapButM",
		},
		{
			N = L["Alt middle click map"],
			V = "MapButMAlt",
		},
		{
			N = L["Ctrl middle click map"],
			V = "MapButMCtrl",
		},
		{
			N = L["Right click map"],
			V = "MapButR",
		},
		{
			N = L["Alt right click map"],
			V = "MapButRAlt",
		},
		{
			N = L["Ctrl right click map"],
			V = "MapButRCtrl",
		},
		{
			N = L["Button 4 click map"],
			V = "MapBut4",
		},
		{
			N = L["Alt button 4 click map"],
			V = "MapBut4Alt",
		},
		{
			N = L["Ctrl button 4 click map"],
			V = "MapBut4Ctrl",
		},
	},
	{
		N = L["Map Minimap"],
		L["Map Minimap options"],
		1,
--PAIDS!
		{
			N = L["Move Minimap into Carbonite map (reload required)"],
			V = "MapMMOwn",
			VF = "NXCmdMMOwnChange"
		},
		{
			N = L["Move Minimap buttons into Carbonite button window (reload required)"],
			V = "MapMMButOwn",
			VF = "NXCmdReload",
		},
		1,
		{
			N = L["Minimap shape is square"],
			V = "MapMMSquare",
		},
		{
			N = L["Minimap is drawn above icons (ctrl key toggles)"],
			V = "MapMMAboveIcons",
		},
		{
			N = L["Minimap icon/dots scale"],
			V = "MapMMIScale",
		},
		{
			N = L["Minimap herb/ore dot glow delay (0 is off)"],
			V = "MapMMNodeGD",
			VF = "NXCmdMMChange"
		},
		{
			N = L["Minimap docks always"],
			V = "MapMMDockAlways",
		},
		{
			N = L["Minimap docks in indoor areas"],
			V = "MapMMDockIndoors",
		},
		{
		    N = L["Minimap docks in known bugged zones"],
			V="MapMMDockBugged",
		},
		{
			N = L["Minimap docks when map is maximized"],
			V = "MapMMDockOnMax",
		},
		{
			N = L["Minimap hides when map is maximized"],
			V = "MapMMHideOnMax",
		},
		{
			N = L["Minimap docked shape is square"],
			V = "MapMMDockSquare",
		},
		{
			N = L["Minimap docks to bottom"],
			V = "MapMMDockBottom",
		},
		{
			N = L["Minimap docks to right"],
			V = "MapMMDockRight",
		},
		{
			N = L["Minimap dock X offset"],
			V = "MapMMDXO",
		},
		{
			N = L["Minimap dock Y offset"],
			V = "MapMMDYO",
		},
		{
			N = L["Minimap dock icon/dots scale"],
			V = "MapMMDockIScale",
		},
		{
			N = L["Minimap toggles full size for indoor areas (not in cities)"],
			V = "MapMMIndoorTogFullSize",
		},
		{
		    N = L["Minimap toggles full size in known bugged areas"],
			V = "MapMMBuggedTogFullSize",
		},
		{
			N = L["Minimap toggles full size for instances"],
			V = "MapMMInstanceTogFullSize",
		},
		{
			N = L["Move capture bars under map"],
			V = "MapMMMoveCapBars",
		},
		{
			N = L["Show standard Minimap nameplate"],
			V = "MapMMShowOldNameplate",
			VF = "NXCmdMMButUpdate"
		},
		1,
		L["Minimap buttons"],
		{
			N = L["Hide button window"],
			V = "MapMMButHide",
			VF = "NXCmdMMButUpdate"
		},
		{
			N = L["Lock button window"],
			V = "MapMMButLock",
			VF = "NXCmdMMButUpdate"
		},
		{
			N = L["Button columns"],
			V = "MapMMButColumns",
		},
		{
			N = L["Button spacing"],
			V = "MapMMButSpacing",
		},
		{
			N = L["Corner for first button"],
			V = "MapMMButCorner",
		},
--PAIDE!
		{
			N = L["Show 'Carbonite' minimap button"],
			V = "MapMMButShowCarb",
			VF = "NXCmdMMButUpdate"
		},
		{
			N = L["Show 'Calendar' minimap button"],
			V = "MapMMButShowCalendar",
			VF = "NXCmdMMButUpdate"
		},
		{
			N = L["Show 'Clock' minimap button"],
			V = "MapMMButShowClock",
			VF = "NXCmdMMButUpdate"
		},
		{
			N = L["Show 'World Map' minimap button"],
			V = "MapMMButShowWorldMap",
			VF = "NXCmdMMButUpdate"
		},
	},
	{
		N = L["Menu"],
		L["Menu options"],
		1,
		{
			N = L["Center menus horizontally on cursor"],
			V = "MenuCenterH",
		},
		{
			N = L["Center menus vertically on cursor"],
			V = "MenuCenterV",
		},
	},
--PAIDS!
	{
		N = L["Modules"],
		L["Module settings (reload UI after changing these)"],
		L["Allows disabling of major features in the addon"],
		1,
		{
			N = L["Reload UI"],
			F = "NXCmdReload"
		},
		1,
--		{
--			N = "Enable Auction Assist",
--			V = "AuctionEnable",
--		},
		{
			N = L["Enable Info windows"],
			V = "IWinEnable",
		},
		{
			N = L["Enable Questing"],
			V = "QEnable",
		},
		{
			N = L["Enable Team window"],
			V = "TeamTWinEnable",
		},
		{
			N = L["Enable Warehouse"],
			V = "WarehouseEnable",
		},
	},
--PAIDE!
	{
		N = L["Privacy & Com"],
		L["Click buttons below to change privacy or communication settings"],
		1,
		{
			N = L["Send position and level ups"],
		},
		{
			N = L[" To friends"],
			V = "InfoToF",
		},
		{
			N = L[" To guild"],
			V = "InfoToG",
		},
		{
			N = L[" To zone"],
			V = "InfoToZ",
		},
		1,
		{
			N = L["Show received level ups"],
			V = "InfoLvlUpShow",
		},
		1,
		L["Reload UI required for these settings to take effect"],
		{
			N = L["Disable global channel (you won't know about version updates)"],
			V = "ComNoGlobal",
		},
		{
			N = L["Disable zone channel (you won't know about players or punks in your zone)"],
			V = "ComNoZone",
		},
		1,
		1,
--[[
		{
			N = "Capture quest and loot data for developers",
			V = "CaptureEnable",
		},
--]]
		{
			N = L["Share quest data"],
			V = "CaptureShare",
		},
	},
	{
		N = L["Quest"],
		L["Quest list options"],
		{
			N = L["Show quest list and details side by side"],
			V = "QSideBySide",
			VF = "NXCmdQuestSidebySide"
		},
		{
			N = L["Sync Carbonite Watched with Blizzard Watched (enables minimap blobs to work)"],
			V = "QSync",
		},
		{
			N = L["Show daily reset time"],
			V = "QShowDailyReset",
		},
		{
		    N = L["Show daily quest count"],
			V = "QShowDailyCount",
		},
		{
			N = L["Show quest id in list"],
			V = "QShowId",
		},
		{
			N = L["Open Carbonite quest window using Alt-L"],
			V = "QUseAltLKey",
		},
		{
			N = L["Details background color"],
			V = "QDetailBC",
		},
		{
			N = L["Details text color"],
			V = "QDetailTC",
		},
		{
			N = L["Details scale"],
			V = "QDetailScale",
		},
		1,
		L["Quest options"],
		{
			N = L["Show quest info in tooltips"],
			V = "QAddTooltip",
		},
		{
			N = L["Number of quest levels below player level to keep in memory (90 keeps all)"],
			V = "QLevelsToLoad3",
			VF = "NXCmdReload",
		},
		{
			N = L["Share quest status with party and show theirs"],
			V = "QPartyShare",
		},
		{
			N = L["Auto accept quests (shift+ctrl inverts)"],
			V = "QAutoAccept",
		},
		{
			N = L["Auto turn in quests when talking to NPC (shift+ctrl inverts)"],
			V = "QAutoTurnIn",
		},
		{
			N = L["Auto trigger self completion quests"],
			V = "QAutoTurnInAC",
		},
		{
			N = L["Broadcast quest change messages to party"],
			V = "QBroadcastQChanges",
		},
		{
			N = L["Broadcast after number of objectives are completed"],
			V = "QBroadcastQChangesNum",
		},
		{
			N = L["Show level and part number in quest links"],
			V = "QShowLinkExtra",
		},
		{
			N = L["Update completed quest history on login (gets from server)"],
			V = "QHCheckCompleted",
		},
		1,
		L["Quest map options"],
		{
			N = L["Always show watched quest areas on map"],
			V = "QMapShowWatchAreas",
		},
		{
			N = L["Color of watch areas when tracked"],
			V = "QMapWatchAreaTrackColor",
		},
		{
			N = L["Color of watch areas on mouse over"],
			V = "QMapWatchAreaHoverColor",
		},
		{
			N = L["Graphic of watch areas"],
			V = "QMapWatchAreaGfx",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Transparency of watch areas"],
			V = "QMapWatchAreaAlpha",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Use one color per quest"],
			V = "QMapWatchColorPerQ",
		},
		{
			N = L["Total colors to use"],
			V = "QMapWatchColorCnt",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 1"],
			V = "QMapWatchC1",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 2"],
			V = "QMapWatchC2",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 3"],
			V = "QMapWatchC3",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 4"],
			V = "QMapWatchC4",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 5"],
			V = "QMapWatchC5",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 6"],
			V = "QMapWatchC6",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 7"],
			V = "QMapWatchC7",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 8"],
			V = "QMapWatchC8",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 9"],
			V = "QMapWatchC9",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 10"],
			V = "QMapWatchC10",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 11"],
			V = "QMapWatchC11",
			VF = "NXCmdQMapWatchColor"
		},
		{
			N = L["Watch color 12"],
			V = "QMapWatchC12",
			VF = "NXCmdQMapWatchColor"
		},
	},
	{
		N = L["Quest Watch"],
		L["Watch window options"],
		1,
		{
			N = L["Hide"],
			V = "QWHide",
		},
		{
			N = L["Lock"],
			V = "QWLock",
		},
		{   N = L["Hide Blizzard Tracker"],
		    V = "QWHideBlizz",
		},
		1,
		{
			N = L["Auto watch new quests"],
			V = "QWAddNew",
		},
		{
			N = L["Auto watch changed quests"],
			V = "QWAddChanged",
		},
		{
			N = L["Auto remove watched quests when completed"],
			V = "QWRemoveComplete",
		},
		1,
		{
		    N = L["Add Scenario Objectives To Watch"],
			V = "QWScenTrack",
		},
		{
		    N = L["Add Achievement Tracks To Watch"],
			V = "QWAchTrack",
		},
		{
		    N = L["Add Challenge Timers To Watch"],
			V = "QWChalTrack",		
		},
		1,
		{
			N = L["Background color"],
			V = "QWBGColor",
		},
		{
			N = L["Show close button"],
			V = "QWShowClose",
			VF = "NXCmdReload"
		},
		{
			N = L["Show distance to quest"],
			V = "QWShowDist",
		},
		{
			N = L["Fade all parts of window"],
			V = "QWFadeAll",
			VF = "NXCmdQWFadeAll"
		},
		{
			N = L["Quest complete color"],
			V = "QWCompleteColor",
		},
		{
			N = L["Quest incomplete color"],
			V = "QWIncompleteColor",
		},
		{
			N = L["Objective complete color"],
			V = "QWOCompleteColor",
		},
		{
			N = L["Objective incomplete color"],
			V = "QWOIncompleteColor",
		},
		{
			N = L["Show objective percent done color"],
			V = "QWShowPerColor",
		},
		{
			N = L["Hide objectives that are 100% done"],
			V = "QWHideDoneObj",
		},
		{
			N = L["Put objective counts before objective names"],
			V = "QWOCntFirst",
		},
		{
			N = L["Objective text length to wrap lines"],
			V = "QWOMaxLen",
		},
		{
			N = L["Hide when in a raid group"],
			V = "QWHideRaid",
			VF = "NXCmdQWHideRaid"
		},
		{
			N = L["Item button scale (0 hides)"],
			V = "QWItemScale",
		},
		{
			N = L["Item button transparency"],
			V = "QWItemAlpha",
		},
		{
			N = L["Show tracked achievements. Hide Blizzard's watch list"],
			V = "QWAchTrack",
		},
		{
			N = L["Show questing achievement for zone"],
			V = "QWAchZoneShow",
		},
		{
			N = L["Grow list upwards"],
			V = "QWGrowUp",
		},
		{
			N = L["Use fixed size list"],
			V = "QWFixedSize",
			VF = "NXCmdReload"
		},
		{
			N = L["Modify game objective settings: Instant, no auto watch"],
			V = "QWBlizzModify",
		},
	},
--PAIDS!
	{
		N = L["Quest Sounds"],
		L["Quest sound options"],
		{
			N = L["Play sound when quest is completed"],
			V = "QSndPlayCompleted",
			VF = "NXCmdQSound"
		},
		L["Check one or more sounds. They will be randomly played"],
		{
			N = L["Carbonite QuestComplete"],
			V = "QSnd1",
			VF = "NXCmdQSound"
		},
		{
			N = L["PeonBuildingComplete1"],
			V = "QSnd2",
			VF = "NXCmdQSound"
		},
		{
			N = L["UndeadMaleCongratulations02"],
			V = "QSnd3",
			VF = "NXCmdQSound"
		},
		{
			N = L["HumanFemaleCongratulations01"],
			V = "QSnd4",
			VF = "NXCmdQSound"
		},
		{
			N = L["DwarfMaleCongratulations04"],
			V = "QSnd5",
			VF = "NXCmdQSound"
		},
		{
			N = L["GnomeMaleCongratulations03"],
			V = "QSnd6",
			VF = "NXCmdQSound"
		},
		{
			N = L["TaurenYes3"],
			V = "QSnd7",
			VF = "NXCmdQSound"
		},
		{
			N = L["UndeadMaleWarriorNPCGreeting01"],
			V = "QSnd8",
			VF = "NXCmdQSound"
		},
	},
--PAIDE!
	{
		N = L["Reset"],
		L["Click items below to reset or import"],
		1,
		{
			N = L["Import settings from a character"],
			F = "NXCmdImportCharSettings"
		},
		1,
		{
			N = L["Delete settings of a character"],
			F = "NXCmdDeleteCharSettings"
		},
		1,
		{
			N = L["Reset global and quest options"],
			F = "NXCmdResetOpts"
		},
		{
			N = L["Reset window layouts of current character"],
			F = "NXCmdResetWinLayouts"
		},
		{
			N = L["Reset Watch Window layout"],
			F = "NXCmdResetWatchWinLayout"
		},
		1,
		{
			N = L["Reload UI"],
			F = "NXCmdReload"
		},
	},
	{
		N = L["Skin"],
		L["UI skinning options"],
--PAIDS!
		1,
		{
			N = L["Border color of windows"],
			V = "SkinWinBdColor",
			VF = "NXCmdSkinColor",
		},
		{
			N = L["Background color of fixed size windows"],
			V = "SkinWinFixedBgColor",
			VF = "NXCmdSkinColor",
		},
		{
			N = L["Background color of sizable windows"],
			V = "SkinWinSizedBgColor",
			VF = "NXCmdSkinColor",
		},
--PAIDE!
		1,
		L["Click below to set a skin"],
		1,
		{
			N = L["Default"],
			F = "NXCmdSkin",
		},
		{
			N = L["Blackout"],
			F = "NXCmdSkin",
			Data = "Blackout"
		},
		{
			N = L["Blackout Blues"],
			F = "NXCmdSkin",
			Data = "BlackoutBlues"
		},
		{
			N = L["Dialog Blue"],
			F = "NXCmdSkin",
			Data = "DialogBlue"
		},
		{
			N = L["Dialog Gold"],
			F = "NXCmdSkin",
			Data = "DialogGold"
		},
		{
			N = L["Simple Blue"],
			F = "NXCmdSkin",
			Data = "SimpleBlue"
		},
		{
			N = L["Stone"],
			F = "NXCmdSkin",
			Data = "Stone"
		},
		{
			N = L["Tool Blue"],
			F = "NXCmdSkin",
			Data = "ToolBlue"
		},
	},
	{
		N = L["Social & Punks"],
		L["Social Window, Team and Punks options"],
		1,
		{
			N = L["Use enhanced social window"],
			V = "SocialEnable",
			VF = "NXCmdReload"
		},
		1,
		L["Team options"],
		1,
		{
			N = L["Hide team target button window"],
			V = "TeamTWinHide",
		},
		{
			N = L["Max team target buttons"],
			V = "TeamTWinMaxButs",
			VF = "NXCmdReload"
		},
		1,
		L["Punks options"],
		1,
		{
			N = L["Hide punk target button window"],
			V = "PunkTWinHide",
		},
		{
			N = L["Lock punk target button window"],
			V = "PunkTWinLock",
		},
		{
			N = L["Punk target button window title"],
			V = "PunkTWinTitle",
		},
		{
			N = L["Max punk target buttons"],
			V = "PunkTWinMaxButs",
			VF = "NXCmdReload"
		},
		{
			N = L["Show alert text on match"],
			V = "PunkMAlertText",
		},
		{
			N = L["Play alert sound on match"],
			V = "PunkMAlertSnd",
		},
		{
			N = L["Show punk detections in Northrend"],
			V = "PunkShowInNorthrend",
		},
		{
			N = L["Show punk detections in safe areas (sanctuary)"],
			V = "PunkShowInSafeArea",
		},
		{
			N = L["Show chat warning on new local punk detections"],
			V = "PunkNewLocalWarnChat",
		},
		{
			N = L["Play sound on new local punk detections"],
			V = "PunkNewLocalWarnSnd",
		},
		1,
		{
			N = L["Show on map"],
			V = "MapShowPunks",
		},
		{
			N = L["Icon color"],
			V = "PunkIconColor",
		},
		{
			N = L["Area color"],
			V = "PunkAreaColor",
		},
		{
			N = L["Area size"],
			V = "PunkAreaSize",
		},
		{
			N = L["Match area color"],
			V = "PunkMAreaColor",
		},
		{
			N = L["Match area size"],
			V = "PunkMAreaSize",
		},
		{
			N = L["Show in battlegrounds"],
			V = "PunkShowInBG",
		},
		{
			N = L["Battleground area color"],
			V = "PunkBGAreaColor",
		},
		{
			N = L["Battleground area size"],
			V = "PunkBGAreaSize",
		},
	},
	{
		N = L["Tracking HUD"],
		L["Tracking Arrow HUD options"],
		1,
		{
			N = L["Hide"],
			V = "HUDHide",
		},
		{
			N = L["Hide in battlegrounds"],
			V = "HUDHideInBG",
		},
		{
			N = L["Lock"],
			V = "HUDLock",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Arrow Graphic"],
			V = "HUDAGfx",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Arrow Size"],
			V = "HUDASize",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Arrow X offset"],
			V = "HUDAXO",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Arrow Y offset"],
			V = "HUDAYO",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Show direction text"],
			V = "HUDShowDir",
		},
		{
			N = L["Enable target button on arrow"],
			V = "HUDTBut",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Target button color"],
			V = "HUDTButColor",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Target button color in combat"],
			V = "HUDTButCombatColor",
			VF = "NXCmdHUDChange"
		},
		{
			N = L["Play target reached sound"],
			V = "HUDTSoundOn",
		},
		1,
		L["Auto tracking options"],
		{
			N = L["Pals in battlegrounds"],
			V = "HUDATBGPal",
		},
		{
			N = L["Taxi destination"],
			V = "HUDATTaxi",
		},
		{
			N = L["Your corpse"],
			V = "HUDATCorpse",
		},
	},
}

Nx.OptsDataSounds = {
	"Interface\\AddOns\\Carbonite\\Snd\\QuestComplete.ogg",
	"Sound\\Creature\\Peon\\PeonBuildingComplete1.wav",
	"Sound\\Character\\Scourge\\ScourgeVocalMale\\UndeadMaleCongratulations02.wav",
	"Sound\\Character\\Human\\HumanVocalFemale\\HumanFemaleCongratulations01.wav",
	"Sound\\Character\\Dwarf\\DwarfVocalMale\\DwarfMaleCongratulations04.wav",
	"Sound\\Character\\Gnome\\GnomeVocalMale\\GnomeMaleCongratulations03.wav",
	"Sound\\Creature\\Tauren\\TaurenYes3.wav",
	"Sound\\Creature\\UndeadMaleWarriorNPC\\UndeadMaleWarriorNPCGreeting01.wav",
}

-------------------------------------------------------------------------------

--------
-- Init options data. Called before UI init

function Nx.Opts:Init()

	self.ChoicesAnchor = {
		"TopLeft", "Top", "TopRight",
		"Left", "Center", "Right",
		"BottomLeft", "Bottom", "BottomRight",
	}
	self.ChoicesAnchor0 = {
		"None",
		"TopLeft", "Top", "TopRight",
		"Left", "Center", "Right",
		"BottomLeft", "Bottom", "BottomRight",
	}
	self.ChoicesCorner = { "TopLeft", "TopRight", "BottomLeft", "BottomRight", }

	self.ChoicesQArea = {
		"Solid", "SolidTexture", "HGrad",
	}
	self.ChoicesQAreaTex = {
		["SolidTexture"] = "Interface\\Buttons\\White8x8",
		["HGrad"] = "Interface\\AddOns\\Carbonite\\Gfx\\Map\\AreaGrad",
	}

	self:Reset (true)
	self:UpdateCom()

	Nx.Timer:Start ("OptsInit", .5, self, self.InitTimer)

--	Nx.prt ("cvar %s", GetCVar ("farclip") or "nil")

--	RegisterCVar ("dog", "hi")
--	Nx.prt ("dog %s", GetCVar ("dog") or "nil")
end

--------
-- Init timer

function Nx.Opts:InitTimer()

--	Nx.prt ("cvar %s", GetCVar ("farclip") or "nil")

--	Nx.prt ("dog2 %s", GetCVar ("dog") or "nil")

	self:NXCmdGryphonsUpdate()
	self:NXCmdCamForceMaxDist()

	Nx.Timer:Start ("OptsQO", 2, self, self.QuickOptsTimer)
end

--------
-- Show quick options timer

function Nx.Opts:QuickOptsTimer()

--	Nx.prt ("cvar %s", GetCVar ("farclip") or "nil")

	local opts = Nx:GetGlobalOpts()
	local i = opts["OptsQuickVer"] or 0

	local ver = 5

	opts["OptsQuickVer"] = ver

	if i < ver then

		local function func()
			local opts = Nx:GetGlobalOpts()
			opts["MapMMOwn"] = true
			opts["MapMMButOwn"] = true
			opts["MapMMShowOldNameplate"] = false
			ReloadUI()
		end

		local s = L["Put the game minimap into the Carbonite map?\n\nThis will make one unified map. The minimap buttons will go into the Carbonite button window. This can also be changed using the Map Minimap options page."]

		Nx:ShowMessage (s, L["Yes"], func, L["No"])
	end
end

--------
-- Reset options (can be called before Init)

function Nx.Opts:Reset (onlyNew)

	self.Opts = Nx:GetGlobalOpts()
	self.COpts = Nx.CurCharacter["Opts"]

	if not onlyNew then
		Nx.prt (L["Reset global options"])
	end

	for name, v in pairs (Nx.OptsVars) do

		local scope, typ, val = strsplit ("~", v)
		local opts = scope == "-" and self.COpts or self.Opts

		if scope == "-" and self.Opts[name] ~= nil then
--			Nx.prt ("deleted %s", name)
			self.Opts[name] = nil			-- Kill old global
		end

		if not onlyNew or opts[name] == nil then

			if typ == "B" then		-- Bool

				opts[name] = false
				if val == "T" then
					opts[name] = true
				end

			elseif typ == "C" or typ == "RGB" then	-- Color

				opts[name] = 0xffffffff	-- RGBA
				if val then
					opts[name] = tonumber (val, 16)
				end

			elseif typ == "CH" then	-- Choice

				opts[name] = ""
				if val then
					opts[name] = val
				end

			elseif typ == "F" then	-- Float

				opts[name] = 0
				if val then
					opts[name] = tonumber (val)
				end

			elseif typ == "I" then	-- Int

				opts[name] = 0
				if val then
					opts[name] = tonumber (val)
				end

			elseif typ == "S" then	-- String

				opts[name] = ""
				if val then
					opts[name] = val
				end

			elseif typ == "" then	-- Kill it?
				opts[name] = nil

			end
		end
	end
end

--------
-- Open options

function Nx.Opts:Open (pageName)

	local win = self.Win

	if not win then
		self:Create()
		win = self.Win
	end

	win:Show()

	if pageName then

		for n, t in ipairs (Nx.OptsData) do

			if t.N == pageName then
				self.PageList:Select (n)
				self.PageSel = n
				self.PageList:Update()
				break
			end
		end
	end

	self:Update()
end

--------
-- Open options

function Nx.Opts:Create()

	-- Create Window

	local win = Nx.Window:Create ("NxOpts", nil, nil, nil, 1)
	self.Win = win
	local frm = win.Frm

	win:CreateButtons (true, true)
	win:InitLayoutData (nil, -.25, -.1, -.5, -.7)

	tinsert (UISpecialFrames, frm:GetName())

	frm:SetToplevel (true)

	win:SetTitle (Nx.TXTBLUE.."CARBONITE " .. Nx.VERSION .. L["|cffffffff Options"])

	-- Page list

	local listW = 115

	local list = Nx.List:Create (false, 0, 0, 1, 1, frm)
	self.PageList = list

	list:SetUser (self, self.OnPageListEvent)
	win:Attach (list.Frm, 0, listW, 0, 1)

	list:SetLineHeight (8)

	list:ColumnAdd (L["Page"], 1, listW)

	for k, t in ipairs (Nx.OptsData) do

		list:ItemAdd (k)
		list:ItemSet (1, t.N)
	end

	self.PageSel = 1

	-- Item list

	Nx.List:SetCreateFont ("FontM", 24)

	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm)
	self.List = list

	list:SetUser (self, self.OnListEvent)

	list:SetLineHeight (12, 3)

	list:ColumnAdd ("", 1, 40)
	list:ColumnAdd ("", 2, 900)

	win:Attach (list.Frm, listW, 1, 0, 1)

	--

	self:Update()
end

--------

function Nx.Opts:NXCmdFavCartImport()
	Nx.Fav:CartImportNotes()
end

function Nx.Opts:NXCmdFontChange()
	Nx.Font:Update()
end

function Nx.Opts:NXCmdCamForceMaxDist()

--	Nx.prt ("Cam %s", GetCVar ("cameraDistanceMaxFactor"))

	if self.Opts["CameraForceMaxDist"] then
		SetCVar ("cameraDistanceMaxFactor", 3.4)
	end
end

function Nx.Opts:NXCmdGryphonsUpdate()
    if(U1GetCfgValue) then return end -- XXX 163UI
	if self.Opts["GryphonsHide"] then
		MainMenuBarLeftEndCap:Hide()
		MainMenuBarRightEndCap:Hide()
	else
		MainMenuBarLeftEndCap:Show()
		MainMenuBarRightEndCap:Show()
	end
end

function Nx.Opts:NXCmdDeleteHerb()

	local function func()
		Nx:GatherDeleteHerb()
	end
	Nx:ShowMessage (L["Delete Herb Locations?"], L["Delete"], func, L["Cancel"])
end

function Nx.Opts:NXCmdDeleteMine()

	local function func()
		Nx:GatherDeleteMine()
	end
	Nx:ShowMessage (L["Delete Mine Locations?"], L["Delete"], func, L["Cancel"])
end

function Nx.Opts:NXCmdDeleteMisc()

	local function func()
		Nx:GatherDeleteMisc()
	end
	Nx:ShowMessage (L["Delete Misc Locations?"], L["Delete"], func, L["Cancel"])
end

function Nx.Opts:NXCmdImportCarbHerb()

	local function func()
		Nx:GatherImportCarbHerb()
	end
	Nx:ShowMessage (L["Import Herbs?"], L["Import"], func, L["Cancel"])
end

function Nx.Opts:NXCmdImportCarbMine()

	local function func()
		Nx:GatherImportCarbMine()
	end
	Nx:ShowMessage (L["Import Mining?"], L["Import"], func, L["Cancel"])
end

function Nx.Opts:NXCmdImportCarbMisc()

	local function func()
		Nx:GatherImportCarbMisc()
	end
	Nx:ShowMessage (L["Import Misc?"], L["Import"], func, L["Cancel"])
end

--[[
function Nx.Opts:NXCmdImportCartHerb()

	local function func()
		Nx:GatherImportCartHerb()
	end
	Nx:ShowMessage ("Import Herbs?", "Import", func, "Cancel")
end

function Nx.Opts:NXCmdImportCartMine()

	local function func()
		Nx:GatherImportCartMine()
	end
	Nx:ShowMessage ("Import Mining?", "Import", func, "Cancel")
end
--]]

function Nx.Opts:NXCmdInfoWinUpdate()
	if Nx.Info then
		Nx.Info:OptionsUpdate()
	end
end

--warbaby minimap dock no reload
function Nx.Opts:NXCmdMMOwnChange (item, var)

	self:SetVar ("MapMMShowOldNameplate", not var)		-- Nameplate is opposite of integration
	self:SetVar ("MapMMButOwn", var)
	self:Update()

    Nx.Map.Maps[1].MMOwn = var
    if not var then
        if MinimapZoom then MinimapZoom:Show() end
        MinimapBackdrop:Show()
        Minimap:SetParent(MinimapCluster)
        Minimap:ClearAllPoints()
        Minimap:SetPoint("CENTER", MinimapCluster, "TOP", 9, -92)
        Minimap:SetSize(140,140)
        Minimap:SetScale(1)
        Minimap:SetAlpha(1)
        Minimap:SetMaskTexture("textures\\MinimapMask")
        Minimap:SetPlayerTexture("Interface\\Minimap\\MinimapArrow")
        MinimapCluster:Show()
        Nx.Map.Maps[1].MMMaskName = nil
        Nx.Map.Maps[1].MMArrowName = nil
    else
        Nx.Map.Dock:Create(0.5)
        Nx.Map.Maps[1]:MinimapOwnInit()
    end
	--self:NXCmdReload()
end

function Nx.Opts:NXCmdMMButUpdate()
	Nx.Map:MinimapButtonShowUpdate()
	Nx.Map.Dock:UpdateOptions()
end

-- Generic minimap change

function Nx.Opts:NXCmdMMChange()
	local map = Nx.Map:GetMap (1)
	map:MinimapNodeGlowInit (true)
end

function Nx.Opts:NXCmdMapToolBarUpdate()
	local map = Nx.Map:GetMap (1)
	map:UpdateToolBar()
end

function Nx.Opts:NXCmdQuestSidebySide()
	Nx.Quest.List:AttachFrames()
end

function Nx.Opts:NXCmdQMapWatchColor()
	Nx.Quest:CalcWatchColors()
end

--function Nx.Opts:NXCmdWatchFont()
--	Nx.Quest.Watch:SetFont()
--end

function Nx.Opts:NXCmdQWFadeAll (item, var)
	Nx.Quest.Watch:WinUpdateFade (var and Nx.Quest.Watch.Win:GetFade() or 1, true)
end

function Nx.Opts:NXCmdQWHideRaid()
	Nx.Quest.Watch.Win.Frm:Show()
end

function Nx.Opts:NXCmdQSound (item, var)
	if var then
		local sndI = tonumber (gsub (item.V, "%a", ""), 10)	-- gsub returns 2 params!
--		Nx.prtVar ("item", item)
--		Nx.prtVar ("sndI", sndI)
		Nx.Quest:PlaySound (sndI)
	end
end

function Nx.Opts:NXCmdImportCharSettings()

	local function func (self, name)

		local function func()

--			Nx.prt ("OK %s", name)

			if Nx:CopyCharacterData (name, UnitName ("player")) then
				ReloadUI()
			end
		end

		Nx:ShowMessage (format (L["Import %s character data and reload?"], name), L["Import"], func, L["Cancel"])
	end

	local t = {}

	for rc in pairs (NxData.Characters) do
		tinsert (t, rc)
	end

	sort (t)

	Nx.DropDown:Start (self, func)
	Nx.DropDown:AddT (t, 1)
	Nx.DropDown:Show (self.List.Frm)
end

function Nx.Opts:NXCmdDeleteCharSettings()

	local function func (self, name)

		local function func()

--			Nx.prt ("OK %s", name)

			Nx:DeleteCharacterData (name)
		end

		Nx:ShowMessage (format (L["Delete %s character data?"], name), L["Delete"], func, L["Cancel"])
	end

	local rcName = Nx:GetRealmCharName()

	local t = {}

	for rc in pairs (NxData.Characters) do
		if rc ~= rcName then
			tinsert (t, rc)
		end
	end

	sort (t)

	Nx.DropDown:Start (self, func)
	Nx.DropDown:AddT (t, 1)
	Nx.DropDown:Show (self.List.Frm)
end

function Nx.Opts:NXCmdResetOpts()

	local function func()
		local self = Nx.Opts
		self:Reset()
		self:Update()
		Nx.Skin:Set()
		Nx.Font:Update()
		Nx.Quest:OptsReset()
		Nx.Quest:CalcWatchColors()
		self:NXCmdHUDChange()
		self:NXCmdGryphonsUpdate()
		self:NXCmdInfoWinUpdate()
		self:NXCmdUIChange()
	end

	Nx:ShowMessage (L["Reset options?"], L["Reset"], func, L["Cancel"])
end

function Nx.Opts:NXCmdResetWinLayouts()

	local function func()
		Nx.Window:ResetLayouts()
	end

	Nx:ShowMessage (L["Reset window layouts?"], L["Reset"], func, L["Cancel"])
end

function Nx.Opts:NXCmdResetWatchWinLayout()
	Nx.Quest.Watch.Win:ResetLayout()
end

function Nx.Opts:NXCmdReload()

	local function func()
		ReloadUI()
	end

	Nx:ShowMessage (L["Reload UI?"], L["Reload"], func, L["Cancel"])
end

function Nx.Opts:NXCmdSkinColor()
	Nx.Skin:Update()
end

function Nx.Opts:NXCmdSkin (item)
	Nx.Skin:Set (item.Data)
end

function Nx.Opts:NXCmdHUDChange()
	Nx.HUD:UpdateOptions()
end

--------
-- Do simple call anytime UI changes

function Nx.Opts:NXCmdUIChange()
	Nx:prtSetChatFrame()
end

--------

function Nx.Opts:OnSetSize (w, h)

	Nx.Opts.FStr:SetWidth (w)
end

function Nx.Opts:OnPageListEvent (eventName, sel, val2)

	if eventName == "select" or eventName == "back" then
		self.PageSel = sel
		self:Update()
	end
end

function Nx.Opts:OnListEvent (eventName, sel, val2)

	local page = Nx.OptsData[self.PageSel]
	local item = page[sel]

	if eventName == "select" or eventName == "back" then

		if item then

			if type (item) == "table" then
				if item.F then
					local var = self:GetVar (item.V)
					Nx.Opts[item.F](self, item, var)
				end

				if item.V then
					self:EditItem (item)
				end
			end
		end

	elseif eventName == "button" then

--		Nx.prt ("but %s", val2 and "T" or "F")

		if item then
			if type (item) == "table" then
				if item.V then
					self:SetVar (item.V, val2)
				end
				if item.VF then
					local var = self:GetVar (item.V)
					Nx.Opts[item.VF](self, item, var)
				end
			end
		end

	elseif eventName == "color" then

		if item then
			if type (item) == "table" then
				if item.VF then
					Nx.Opts[item.VF](self, item)
				end
			end
		end
	end

	self:Update()
end

--------
-- Update options

function Nx.Opts:Update()

	local opts = self.Opts
	local list = self.List

	if not list then
		return
	end

	list:Empty()

	local page = Nx.OptsData[self.PageSel]

	for k, item in ipairs (page) do

		list:ItemAdd (k)

		if type (item) == "table" then

			if item.N then

				local col = "|cff9f9f9f"

				if item.F then				-- Function?
					col = "|cff8fdf8f"
				elseif item.V then
					col = "|cffdfdfdf"
				end

				local istr = format ("%s%s", col, item.N)

				if item.V then

					local typ, pressed, tx = self:ParseVar (item.V)
					if typ == "B" then

						if pressed ~= nil then
							local tip
							list:ItemSetButton ("Opts", pressed, tx, tip)
						end

					elseif typ == "C" then

						list:ItemSetColorButton (opts, item.V, true)

					elseif typ == "RGB" then

						list:ItemSetColorButton (opts, item.V, false)

					elseif typ == "CH" then	-- Choice

						local i = self:GetVar (item.V)
						istr = format ("%s  |cffffff80%s", istr, i)

					elseif typ == "F" then

						local i = self:GetVar (item.V)
						istr = format ("%s  |cffffff80%s", istr, i)

					elseif typ == "I" then

						local i = self:GetVar (item.V)
						istr = format ("%s  |cffffff80%s", istr, i)

					elseif typ == "S" then

						local s = self:GetVar (item.V)
						istr = format ("%s  |cffffff80%s", istr, s)

					elseif typ == "Frm" then

--						list:ItemSetFrame ("Color")

					end
				end

				list:ItemSet (2, istr)
			end

		elseif type (item) == "string" then

			local col = "|cff9f9f9f"
			list:ItemSet (2, format ("%s%s", col, item))
		end
	end

	list:FullUpdate()

	self:UpdateCom()
end

function Nx.Opts:UpdateCom()

	local opts = self.Opts

	local mask = 0

	if opts["InfoToF"] then
		mask = mask + 1
	end

	if opts["InfoToG"] then
		mask = mask + 2
	end

	if opts["InfoToZ"] then
		mask = mask + 4
	end

	Nx.Com:SetSendPalsMask (mask)
end

--------

function Nx.Opts:EditItem (item)

	local var = self:GetVar (item.V)
	local typ, r1 = self:ParseVar (item.V)

	if typ == "CH" then

		self.CurItem = item

		local data = self:CalcChoices (r1, "Get")
		if not data then
			Nx.prt (L["EditItem error (%s)"], r1)
		end
		Nx.DropDown:Start (self, self.EditCHAccept)
		for k, name in ipairs (data) do
			Nx.DropDown:Add (name, name == var)
		end
		Nx.DropDown:Show (self.List.Frm)
--[[
		local s = self:CalcChoices (r1, "Inc", var)
		self:SetVar (item.V, s)
		self:Update()

		if item.VF then
			local var = self:GetVar (item.V)
			self[item.VF](self, item, var)
		end
--]]
	elseif typ == "F" then
		Nx:ShowEditBox (item.N, var, item, self.EditFAccept)

	elseif typ == "I" then
		Nx:ShowEditBox (item.N, var, item, self.EditIAccept)

	elseif typ == "S" then
		Nx:ShowEditBox (item.N, var, item, self.EditSAccept)

	end
end

function Nx.Opts:EditCHAccept (name)

	local item = self.CurItem

	self:SetVar (item.V, name)
	self:Update()

	if item.VF then
		local var = self:GetVar (item.V)
		self[item.VF](self, item, var)
	end
end

function Nx.Opts.EditFAccept (str, item)

	local self = Nx.Opts

	local i = tonumber (str)
	if i then
		self:SetVar (item.V, i)
		self:Update()

		if item.VF then
			local var = self:GetVar (item.V)
			self[item.VF](self, item, var)
		end
	end
end

function Nx.Opts.EditIAccept (str, item)

	local self = Nx.Opts

	local i = tonumber (str)
	if i then
		self:SetVar (item.V, floor (i))
		self:Update()

		if item.VF then
			local var = self:GetVar (item.V)
			self[item.VF](self, item, var)
		end
	end
end

function Nx.Opts.EditSAccept (str, item)

	local self = Nx.Opts

	if str then
		self:SetVar (item.V, str)
		self:Update()

		if item.VF then
			local var = self:GetVar (item.V)
			self[item.VF](self, item, var)
		end
	end
end

--------
-- Calc

function Nx.Opts:CalcChoices (name, mode, val)

	if name == "FontFace" then

		if mode == "Inc" then
			local i = Nx.Font:GetIndex (val) + 1
			return Nx.Font:GetName (i) or Nx.Font:GetName (1)

		elseif mode == "Get" then

			data = {}

			for n = 1, 999 do
				local name = Nx.Font:GetName (n)
				if not name then
					break
				end

				tinsert (data, name)
			end

			sort (data)

			return data
		end

		return

	elseif name == "HUDAGfx" then

		return Nx.HUD.TexNames

	elseif name == "Anchor" then

		return self.ChoicesAnchor

	elseif name == "Anchor0" then

		return self.ChoicesAnchor0

	elseif name == "Chat" then

		return Nx:prtGetChatFrames()

	elseif name == "Corner" then

		return self.ChoicesCorner

	elseif name == "MapFunc" then

		return Nx.Map:GetFuncs()

	elseif name == "QArea" then

		return self.ChoicesQArea

	end
end

--------
-- Parse var

function Nx.Opts:ParseVar (varName)

	local data = Nx.OptsVars[varName]
	local scope, typ, val, a1 = strsplit ("~", data)
	local opts = scope == "-" and self.COpts or self.Opts

--	Nx.prtVar ("Parse " .. varName, opts[varName])

	local pressed
	local tx

	if typ == "B" then

		pressed = false
		tx = "But"

		if opts[varName] then
			pressed = true
			tx = "ButChk"
		end

		return typ, pressed, tx

	elseif typ == "CH" then

		return typ, a1

	elseif typ == "W" then

		local winName, atName = strsplit ("^", val)
		local typ, val = Nx.Window:GetAttribute (winName, atName)

		if typ == "B" then
			if val then
				return typ, true, "ButChk"
			end
			return typ, false, "But"
		end

		return typ, val
	end

	return typ
end

--------
-- Get

function Nx.Opts:GetVar (varName)

	local data = Nx.OptsVars[varName]
	if data then

		local scope, typ, val = strsplit ("~", data)
		local opts = scope == "-" and self.COpts or self.Opts

		if typ == "B" then
			return opts[varName]

		elseif typ == "CH" then
			return opts[varName]

		elseif typ == "F" or typ == "I" or typ == "S" then
			return opts[varName]

		end
	end
end

--------
-- Set

function Nx.Opts:SetVar (varName, val)

--	Nx.prtVar ("Set " .. varName, val)

	local data = Nx.OptsVars[varName]
	local scope, typ, vdef, vmin, vmax = strsplit ("~", data)
	local opts = scope == "-" and self.COpts or self.Opts

	if typ == "B" then
		opts[varName] = val

	elseif typ == "CH" then
		opts[varName] = val

	elseif typ == "F" or typ == "I" then

		vmin = tonumber (vmin)
		if vmin then
			val = max (val, vmin)
		end

		vmax = tonumber (vmax)
		if vmax then
			val = min (val, vmax)
		end

		opts[varName] = val

	elseif typ == "S" then
		opts[varName] = gsub (val, "~", "?")

	elseif typ == "W" then

		local winName, atName = strsplit ("^", vdef)
		Nx.Window:SetAttribute (winName, atName, val)

	else
		return
	end
end

-------------------------------------------------------------------------------
-- EOF

















