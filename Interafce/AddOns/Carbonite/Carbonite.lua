local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
--local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
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

---------------------------------------------------------------------------------------

function NXInit()
	Nx = {}
	local Nx = Nx

	Nx.WebSite = "wowinterface.com"

	NXTITLEFULL = NXTITLE

	Nx.VERMAJOR			= 5.1
	Nx.VERMINOR			= .6			-- Not 0 is a test version
	Nx.BUILD				= 292

	Nx.VERSION			= Nx.VERMAJOR + Nx.VERMINOR / 100

	Nx.VERSIONDATA			= .02				-- Main data
	Nx.VERSIONCHAR			= .02				-- Character data
	Nx.VERSIONCharData	= .4				-- Character specific saved data
	Nx.VERSIONFAV			= .13				-- Favorite data
	Nx.VERSIONGATHER		= .75				-- Gathered data
	Nx.VERSIONGOPTS		= .102			-- Global options
	Nx.VERSIONHUDOPTS		= .03				-- HUD options
	Nx.VERSIONINFO			= .24				-- Info win data
	Nx.VERSIONList			= .1				-- List header data
	Nx.VERSIONQOPTS		= .12				-- Quest options
	Nx.VERSIONSOCIAL		= .2				-- Social data
	Nx.VERSIONTaxiCap		= .5				-- Taxi capture data
	Nx.VERSIONTRAVEL		= .5				-- Travel data
	Nx.VERSIONWare			= .15				-- Warehouse data
	Nx.VERSIONWin			= .31				-- Window layouts
	Nx.VERSIONTOOLBAR		= .1				-- Tool Bar data
	Nx.VERSIONCAP			= .75				-- Captured data (quest recording)
	Nx.VERSIONVENDORV		= .55				-- Visited vendor data
	Nx.VERSIONTransferData = .1			-- Transfer data

	Nx.TXTBLUE			= "|cffc0c0ff"

	Nx.Tick = 0
--	Nx.Elapsed = 0

	NxData = {
		Version = 0,
	}

	-- NxUI

	Nx.Font = {}
	Nx.Skin = {}
	Nx.Window = {}
	Nx.Menu = {}
	Nx.MenuI = {}
	Nx.List = {}
	Nx.DropDown = {}
	Nx.Button = {}
	Nx.EditBox = {}
	Nx.Graph = {}
	Nx.Slider = {}
	Nx.TabBar = {}
	Nx.ToolBar = {}

	-- NxTimer

	Nx.Timer = {}
	Nx.Timer.Win = {}

	-- Help

	Nx.Help = {}
	Nx.Help.Demo = {}
	Nx.Help.License = {}
	Nx.Help.Ad = {}

	Nx.Proc = {}
	Nx.Script = {}

	Nx.Help.Logo = "Interface\\AddOns\\Carbonite\\Gfx\\Carbonite"

	-- Options

	Nx.Opts = {}

	-- Com

	Nx.Com = {}
	Nx.Com.List = {}

	-- Favorites

	Nx.Fav = {}

	-- HUD

	Nx.HUD = {}

	-- Info

	Nx.Info = {}

	-- Map

	Nx.Map = {}
	Nx.Map.Dock = {}
	Nx.Map.Guide = {}
	Nx.Map.Guide.PlayerTargets = {}
	Nx.Travel = {}

	-- Quest

	Nx.Quest = {}
	Nx.Quest.List = {}
	Nx.Quest.Watch = {}

	Nx.Quests = {}				-- Quest data

	-- Warehouse

	Nx.Warehouse = {}

	-- Security

	Nx.Sec = {}
	Nx.I68 = {}

	-- Local

	Nx.Title = {}

	Nx.AuctionAssist = {}

	Nx.Combat = {}

	Nx.Social = {}
	Nx.Social.List = {}
	Nx.Social.PunksHUD = {}
	Nx.Social.TeamHUD = {}

	Nx.UEvents = {}
	Nx.UEvents.List = {}

	Nx.DebugOn = false
	Nx.NetSendPos = false
	Nx.NetPlyrSendTime = GetTime()

	Nx.GroupMembers = {}

	Nx.Item = {}

	Nx.NXMiniMapBut = {}

	Nx.InfoStats = {}

	--

	local ver = GetBuildInfo()
	local v1, v2, v3 = strsplit (".", ver)
	v1 = tonumber (v1) or 0
	v2 = tonumber (v2) or 0
	v3 = tonumber (v3) or 0
	ver = v1 * 10000 + v2 * 100 + v3

	Nx.V30 = true

	if ver < 10000 or ver >= 40003 then		-- Patch 4
		Nx.V403 = true
--		DEFAULT_CHAT_FRAME:AddMessage ("40003")
	end

--	ver = 30300

	if ver > 10000 and ver < 50000 then		-- Old?
		local s = "|cffff2020Carbonite requires WoW 5"
		DEFAULT_CHAT_FRAME:AddMessage (s)
		UIErrorsFrame:AddMessage (s)
		Nx.NXVerOld = true
	end
	Nx.TooltipLastDiffNumLines = 0	
end

NXInit()

---------------------------------------------------------------------

--------
-- Slash command parsing

function Nx.slashCommand (txt)

	local UEvents = Nx.UEvents

	Nx.prt (txt)

	local cmd, a1, a2 = strsplit (" ", txt)
	cmd = strlower (cmd)

	a1 = a1 or ""
	a2 = a2 or ""

	if cmd == "" or cmd == "?" or cmd == "help" then

		Nx.prt ("Commands:")
		Nx.prt (" goto [zone] x y  (set map goto)")
		Nx.prt (" gotoadd [zone] x y  (add map goto)")
		Nx.prt (" menu  (open menu)")
		Nx.prt (" note [\"]name[\"] [zone] [x y]  (make map note)")
		Nx.prt (" options  (open options window)")
		Nx.prt (" resetwin  (reset window layouts)")
		Nx.prt (" rl  (reload UI)")
		Nx.prt (" track name  (track the player)")
		Nx.prt (" winpos name x y  (position a window)")
		Nx.prt (" winshow name [0/1]  (toggle or show a window)")
		Nx.prt (" winsize name w h  (size a window)")

	elseif cmd == "goto" then
		local map = Nx.Map:GetMap (1)
		local s = gsub (txt, "goto%s*", "")
		map:SetTargetAtStr (s)

	elseif cmd == "gotoadd" then
		local map = Nx.Map:GetMap (1)
		local s = gsub (txt, "gotoadd%s*", "")
		map:SetTargetAtStr (s, true)

	elseif cmd == "menu" then
		Nx.NXMiniMapBut:OpenMenu()

	elseif cmd == "note" then
		local s = gsub (txt, "note%s*", "")
		Nx.Fav:SetNoteAtStr (s)

	elseif cmd == "options" then
		Nx.Opts:Open()

	elseif cmd == "resetwin" then
		Nx.Window:ResetLayouts()

	elseif cmd == "rl" then
		ReloadUI()

	elseif cmd == "track" then
		if a1 then
			local map = Nx.Map:GetMap (1)
			map.TrackPlyrs[a1] = true
		end

	elseif cmd == "winpos" then
		Nx.Window:ConsolePos (gsub (txt, "winpos%s*", ""))

	elseif cmd == "winshow" then
		Nx.Window:ConsoleShow (gsub (txt, "winshow%s*", ""))

	elseif cmd == "winsize" then
		Nx.Window:ConsoleSize (gsub (txt, "winsize%s*", ""))

	-- Public debug commands

	elseif cmd == "gatherd" then
		NxData.NXDBGather = not NxData.NXDBGather

	elseif cmd == "herb" then
		UEvents:AddHerb (strtrim (a1 .. " " .. a2))

	elseif cmd == "dbmapmax" then
		NxData.NXDBMapMax = not NxData.NXDBMapMax

	elseif cmd == "mine" then
		UEvents:AddMine (strtrim (a1 .. " " .. a2))

	elseif cmd == "addopen" then
		UEvents:AddOpen (a1, a2)

	elseif cmd == "pro" then
		Nx.Timer:ProfilerDump()

	-- Private commands

	elseif cmd == "c" then
		Nx.Combat:Open()

	elseif cmd == "cap" then
		Nx.CaptureItems()

	elseif cmd == "crash" then
		assert()

	elseif cmd == "com" then
		Nx.Com.List:Open()

	elseif cmd == "comd" then
		NxData.DebugCom = not NxData.DebugCom
		ReloadUI()

	elseif cmd == "comt" then
		Nx.Com:Test (a1, a2)

	elseif cmd == "comver" then
		if NxData.NXVerDebug then			-- Stop casual use
			Nx.Com:GetUserVer()
		end

	elseif cmd == "d" then
		Nx.DebugOn = not Nx.DebugOn

	elseif cmd == "dock" then
		NxData.DebugDock = not NxData.DebugDock

	elseif cmd == "events" then
		UEvents.List:Open()

	elseif cmd == "g" then
		Nx.Graph:Create (20, 50, UIParent)

		local g2 = Nx.Graph:Create (200, 20, UIParent)
		g2.Frm:SetPoint ("CENTER", 0, 100)

	elseif cmd == "item" then
		local id = format (L["Hitem:%s"], a1)
		GameTooltip:SetOwner (UIParent, "ANCHOR_LEFT", 0, 0)
		GameTooltip:SetHyperlink (id)
		local name, iLink, iRarity, lvl, minLvl, type, subType, stackCount, equipLoc, tx = GetItemInfo (id)
		Nx.prt (L["Item: %s %s"], name or "nil", iLink or "")

	elseif cmd == "kill" then
		UEvents:AddKill (a1)

	elseif cmd == "loot" then
		Nx.LootOn = not Nx.LootOn
		Nx.prt (L["Loot %s"], Nx.LootOn and L["On"] or L["Off"])

	elseif cmd == "mapd" then
		NxData.DebugMap = not NxData.DebugMap
		ReloadUI()

	elseif cmd == "questclr" then
		Nx.Quest:ClearCaptured()

	elseif cmd == "unitc" then
		NxData.DebugUnit = true
		Nx:UnitDCapture()

	elseif cmd == "unitd" then
		NxData.DebugUnit = not NxData.DebugUnit

	elseif cmd == "vehpos" then
		Nx.Map:GetMap (1):VehicleDumpPos()

	else
		Nx.prt (L["Unknown command"])

	end

--	Nx.prtTable ("slash", self)
end

--------------------------------------------------------------------------------
-- Startup

function Nx:NXOnLoad (frm)

	SlashCmdList["Carbonite"] = Nx.slashCommand
	SLASH_Carbonite1 = "/Carb"	

	self.Frm = frm		--V4 this
	self.TimeLast = 0
	self.ClassColorStrs = Nx.Util_coltrgb2colstr (RAID_CLASS_COLORS)

	self:RegisterEvent ("ADDON_LOADED", Nx.ADDON_LOADED)

	Nx.Timer:Init()

	Nx.CalendarDate = 0		-- For safety if Map update happens early
end

--------
--

function Nx:ADDON_LOADED (event, arg1, ...)

--	Nx.prt ("ADDON_LOADED %s", arg1 or "nil")

	if arg1 == NXTITLELOW then

--		DEFAULT_CHAT_FRAME:AddMessage ("|cffc0c0ff"..NXTITLE.." |cffffffff"..Nx.VERSION.." B"..Nx.BUILD.." "..NXLOADING)

		--

		local fact = UnitFactionGroup ("player")
		Nx.PlFactionNum = strsub (fact, 1, 1) == "A" and 0 or 1

		Nx.AirshipType = Nx.PlFactionNum == 0 and "Airship Alliance" or "Airship Horde"

		Nx:InitGlobal()
		local opts = Nx:GetGlobalOpts()

		Nx:prtSetChatFrame()

		if not opts["LoginHideVer"] then			
			Nx.prt (NXTITLE.." |cffffffff"..Nx.VERMAJOR.."."..(Nx.VERMINOR*10).." B"..Nx.BUILD.." "..NXLOADING)
		end

		Nx:LocaleInit()

		Nx:InitEvents()

		Nx.Proc:Init()

		Nx.Opts:Init()

		Nx:UIInit()
		Nx.Item:Init()

		Nx.Help:Init()

		Nx.Title:Init()
		Nx.NXMiniMapBut:Init()

		Nx.Com:Init()
		Nx.HUD:Init()
		Nx.Map:Init()
		Nx:GatherInit()	-- Needs map init. May need to do before map open
		Nx.Map:Open()
		Nx.Fav:Init()		-- Needs map init
		Nx.Travel:Init()

		Nx.Info:Init()

		Nx.Quest:Init()

		Nx.Warehouse:Init()

		Nx.Social:Init()

		Nx.Combat:Init()

--		if NxCombatOpts.NXOpened then
			Nx.Combat:Open()
--		end

		Nx.UEvents:Init()
		Nx.UEvents.List:Open()

		hooksecurefunc ("ShowUIPanel", Nx.ShowUIPanel)
		hooksecurefunc ("HideUIPanel", Nx.HideUIPanel)
		hooksecurefunc ("CloseWindows", Nx.CloseWindows)
--[[
		Nx.prt ("garbage %d", collectgarbage ("count"))
		collectgarbage ("collect")
		Nx.prt ("garbage end %d", collectgarbage ("count"))
--]]

		if not opts["LoginHideVer"] then
			Nx.prt (NXLOAD_DONE)
		end

		Nx.Loaded = true

	end

	if Nx.Font.AddonLoaded then
		Nx.Font:AddonLoaded()
	end
end

function Nx:LocaleInit()

	local opts = Nx:GetGlobalOpts()

	local loc = GetLocale()

	if not opts["LoginHideVer"] then
		Nx.prt (" %s", loc)
	end

	if loc ~= "deDE" and loc ~= "frFR" and loc ~= "esES" and loc ~= "esMX" then
		loc = "enUS"
	end

--	if loc == "enGB" then
--		loc = "enUS"
--	end

	Nx.Locale = loc
end

--------
-- Register events

function Nx:InitEvents()

	local Com = Nx.Com
	local Guide = Nx.Map.Guide

--	self.Frm:RegisterAllEvents()

	local events = {

		"PLAYER_LOGIN", Nx.OnPlayer_login,
		"TIME_PLAYED_MSG", Nx.OnTime_played_msg,

		"UPDATE_MOUSEOVER_UNIT", Nx.OnUpdate_mouseover_unit,

		"PLAYER_REGEN_DISABLED", Nx.OnPlayer_regen_disabled,
		"PLAYER_REGEN_ENABLED", Nx.OnPlayer_regen_enabled,
		"UNIT_SPELLCAST_SENT", Nx.OnUnit_spellcast_sent,
		"UNIT_SPELLCAST_SUCCEEDED", Nx.OnUnit_spellcast_succeeded,
		"UNIT_SPELLCAST_FAILED", Nx.OnUnit_spellcast_interrupted,
		"UNIT_SPELLCAST_INTERRUPTED", Nx.OnUnit_spellcast_interrupted,

		"ZONE_CHANGED_NEW_AREA", Nx.OnZone_changed_new_area,
		"PLAYER_LEVEL_UP", Nx.OnPlayer_level_up,

		"GROUP_ROSTER_UPDATE", Nx.OnParty_members_changed,

		"UPDATE_BATTLEFIELD_SCORE", Nx.OnUpdate_battlefield_score,
		"UPDATE_WORLD_STATES", Nx.OnUpdate_battlefield_score,

		"PLAYER_LEAVING_WORLD", Com.OnEvent,
		"COMBAT_LOG_EVENT_UNFILTERED", Com.OnCombat_log_event_unfiltered,
		"FRIENDLIST_UPDATE", Com.OnFriendguild_update,
		"GUILD_ROSTER_UPDATE", Com.OnFriendguild_update,
--		"PLAYER_GUILD_UPDATE", Com.OnFRIENDLIST_UPDATE,
		"CHAT_MSG_CHANNEL_JOIN", Com.OnChatEvent,
		"CHAT_MSG_CHANNEL_NOTICE", Com.OnChatEvent,
		"CHAT_MSG_CHANNEL_LEAVE", Com.OnChatEvent,
		"CHAT_MSG_CHANNEL", Com.OnChat_msg_channel,
		"CHAT_MSG_ADDON", Com.OnChat_msg_addon,
		"CHANNEL_ROSTER_UPDATE", Com.OnChannel_roster_update,

		"CHAT_MSG_COMBAT_FACTION_CHANGE", Nx.Quest.OnChat_msg_combat_faction_change,
		"CHAT_MSG_RAID_BOSS_WHISPER", Nx.Quest.OnChat_msg_raid_boss_whisper,

--		"CHAT_MSG_SYSTEM", Nx.OnChat_msg_system,
		"CHAT_MSG_BG_SYSTEM_NEUTRAL", Nx.OnChat_msg_bg_system_neutral,
--		"CHAT_MSG_BG_SYSTEM_HORDE", Nx.OnChat_msg_bg_system_horde,

		"AUCTION_HOUSE_SHOW", Nx.AuctionAssist.OnAuction_house_show,
		"AUCTION_HOUSE_CLOSED", Nx.AuctionAssist.OnAuction_house_closed,
		"AUCTION_ITEM_LIST_UPDATE", Nx.AuctionAssist.OnAuction_item_list_update,

		"PLAYER_TARGET_CHANGED", Guide.OnPlayer_target_changed,
		"MERCHANT_SHOW", Guide.OnMerchant_show,
		"MERCHANT_UPDATE", Guide.OnMerchant_update,
		"GOSSIP_SHOW", Guide.OnGossip_show,
		"TRAINER_SHOW", Guide.OnTrainer_show,
--		"PET_STABLE_SHOW", Guide.OnPet_stable_show,

		"TAXIMAP_OPENED", Nx.Travel.OnTaximap_opened,

		"BAG_UPDATE", Nx.Warehouse.OnBag_update,
		"PLAYERBANKSLOTS_CHANGED", Nx.Warehouse.OnBag_update,
		"PLAYERBANKBAGSLOTS_CHANGED", Nx.Warehouse.OnBag_update,
		"BANKFRAME_OPENED", Nx.Warehouse.OnBankframe_opened,
		"BANKFRAME_CLOSED", Nx.Warehouse.OnBankframe_closed,
		"GUILDBANKFRAME_OPENED", Nx.Warehouse.OnGuildbankframe_opened,
		"GUILDBANKFRAME_CLOSED", Nx.Warehouse.OnGuildbankframe_closed,
		"ITEM_LOCK_CHANGED", Nx.Warehouse.OnItem_lock_changed,
		"MAIL_INBOX_UPDATE", Nx.Warehouse.OnMail_inbox_update,
		"UNIT_INVENTORY_CHANGED", Nx.Warehouse.OnUnit_inventory_changed,
		"MERCHANT_CLOSED", Nx.Warehouse.OnMerchant_closed,

		"LOOT_OPENED", Nx.Warehouse.OnLoot_opened,
		"LOOT_SLOT_CLEARED", Nx.Warehouse.OnLoot_slot_cleared,
		"LOOT_CLOSED", Nx.Warehouse.OnLoot_closed,

		"CHAT_MSG_SKILL", Nx.Warehouse.OnChat_msg_skill,
		"SKILL_LINES_CHANGED", Nx.Warehouse.OnChat_msg_skill,

		"TRADE_SKILL_UPDATE", Nx.Warehouse.OnTrade_skill_update,

	}

	local n = 1
	while events[n] do

--		Nx.prt ("OnLoad reg %s %s", events[n], tostring (events[n + 1]))

		Nx:RegisterEvent (events[n], events[n + 1])
		n = n + 2
	end

end

--------
-- Register for event and set event handler
-- (event name, handler to call)

function Nx:RegisterEvent (event, handler)

	self.Frm:RegisterEvent (event)

	if not self.Events then
		self.Events = {}
	end

	self.Events[event] = handler
end

-- Handle frame events

function Nx:NXOnEvent (event, ...)

--	Nx.prt ("Nx Event: %s %s %s", event, select (1, ...))

	local h = self.Events[event]
	if h then
		h (nil, event, ...)
	else
--[[
		--V4
		-- UNIT_MANA, UNIT_ENERGY, UNIT_RAGE, UNIT_RUNIC_POWER, UNIT_FOCUS and UNIT_HAPPINESS events,
		-- as well as their UNIT_MAX* counterparts, no longer fire.
		-- UNIT_POWER and UNIT_MAXPOWER may be used instead.

		if event ~= "UNIT_AURA"
				and event ~= "UNIT_ATTACKSPEED"
				and event ~= "UNIT_COMBAT"
				and event ~= "UNIT_ENERGY"
				and event ~= "UNIT_FACTION"
				and event ~= "UNIT_FOCUS"
				and event ~= "UNIT_FLAGS"
				and event ~= "UNIT_HAPPINESS"
				and event ~= "UNIT_HEALTH"
				and event ~= "UNIT_MANA"
				and event ~= "UNIT_MAXMANA"
				and event ~= "UNIT_MAXHEALTH"
				and event ~= "UNIT_MODELCHANGED"
				and event ~= "UNIT_PET"
				and event ~= "UNIT_TARGET"
				and event ~= "UNIT_RAGE" then
			Nx.prt ("Event: %s %s", event, select (1, ...) or "nil")
		end
--]]
		assert (0)
	end
end

--------
-- Login message

function Nx:OnPlayer_login (event, ...)

	Nx.OnParty_members_changed()

	Nx:RecordCharacterLogin()

	Nx.Com:OnEvent (event)


	Nx.BlizzChatFrame_DisplayTimePlayed = ChatFrame_DisplayTimePlayed		-- Save func
	ChatFrame_DisplayTimePlayed = function() end

	RequestTimePlayed()	-- Blizz does not do anymore on login???

end

--------

function Nx:OnTime_played_msg (event, arg1)
--	Nx.prt ("played %s", arg1)
	Nx.Warehouse.TimePlayed = arg1
end

function Nx:OnUpdate_mouseover_unit (event, ...)

--	local s = GameTooltipTextLeft1:GetText() or ""
--	Nx.prt ("MouseOver: %s %s", s, UnitReaction ("mouseover", "player") or "nil")

	if Nx.Quest.Enabled then
		Nx.Quest:TooltipProcess (true)
	end

	local data, guid, id, typ = Nx:UnitDGet ("mouseover")
	if guid then

		local tip = GameTooltip

		if typ == 0 then
			tip:AddLine (format (L["GUID player %s"], strsub (guid, 6)))

		elseif typ == 3 then
			tip:AddLine (format (L["GUID NPC %d"], id))

			Nx:UnitDTip()

		elseif typ == 4 then
			tip:AddLine (format (L["GUID pet %s"], strsub (guid, 13)))
		end

		tip:AddLine (format (" %s", guid))
		tip:Show()	-- Adjusts size
--[[
		local id = 17202
		local range = IsItemInRange (id, "mouseover")
		Nx.prt ("mo range %s", range or "nil")
		local range = IsItemInRange (id, "target")
		Nx.prt ("t range %s", range or "nil")
--]]
	end
end

function Nx:UnitDGet (target)

	if NxData.DebugUnit then

		local guid = UnitGUID (target)
		if guid then

			local id = tonumber (strsub (guid, 7, 10), 16)
			local typ = tonumber (strsub (guid, 5, 5), 16)

			local data = NxData.NXDBUnit or {}
			local ver = 2

			if (data["Ver"] or 0) < ver then
				data = {}
				data["Ver"] = ver
			end

			NxData.NXDBUnit = data

			return data, guid, id, typ
		end
	end
end

-- Capture pos of target

function Nx:UnitDCapture()

	local data, guid, id, typ = self:UnitDGet ("target")
	if data and typ == 3 then

		local mid = GetCurrentMapAreaID()
		local plZX, plZY = GetPlayerMapPosition ("player")
		if mid and (plZX > 0 or plZY > 0) then

			local s = data[id] or "0~0~~~~"
			local reactA, reactH, _, _, _, tipStr = strsplit ("~", s)

			data[id] = format ("%s~%s~%s~%s~0~%s", reactA, reactH, mid, self:PackXY (plZX * 100, plZY * 100), tipStr)

			Nx.prt (L["UnitDCap: %s, %s, %s"], id, plZX * 10000, plZY * 10000)

		else

			Nx.prt (L["Unit map error"])
		end
	end
end

function Nx:UnitDTip()

	local data, guid, id, typ = self:UnitDGet ("mouseover")
	if data and typ == 3 then

		local midCur = GetCurrentMapAreaID()
		local plZX, plZY = GetPlayerMapPosition ("player")
		if midCur and (plZX > 0 or plZY > 0) then

			local react = UnitReaction ("mouseover", "player")

			local s = data[id]

			local reactA, reactH, mid, xy, dist = strsplit ("~", s or "0~0~~000000~9")

			reactA = reactA or 0
			reactH = reactH or 0

			local x, y = self:UnpackXY (xy)

			if Nx.PlFactionNum == 0 then
				reactA = react
			else
				reactH = react
			end

			dist = tonumber (dist)

			local dcur = 9
			if CheckInteractDistance ("mouseover", 1) then	-- 28 yards
				dcur = 2
			end
			if CheckInteractDistance ("mouseover", 3) then	-- 9.9 yards
				dcur = 1
			end

			if dcur <= dist then
				dist = dcur
				mid = midCur
				x = plZX * 100
				y = plZY * 100
			end

			local tipStr = ""
			local tip = GameTooltip
			local textName = "GameTooltipTextLeft"

			for n = 1, tip:NumLines() do
				local s = _G[textName .. n]:GetText()
				if s then
					tipStr = tipStr .. s .. "^"
				end
			end

			data[id] = format ("%s~%s~%s~%s~%s~%s", reactA, reactH, mid, self:PackXY (x, y), dist, tipStr)

			if IsControlKeyDown() then
				Nx.prt (L["UnitDTip: %s %s, %d, %d (%d)"], id, react or "nil", x * 100 + .5, y * 100 + .5, dist)
			end

			if IsShiftKeyDown() and IsControlKeyDown() and (x > 0 or y > 0) then

				local Map = Nx.Map
				local mapId = Map:GetCurrentMapId()
				local m = Map:GetMap (1)

				local tar = m:SetTargetXY (mapId, x, y, "UnitD " .. id)
		  		tar.Radius = 1
			end

		else

			Nx.prt (L["Unit map error"])
		end
	end
end

function Nx:OnPlayer_regen_disabled()

--	Nx.prt ("OnPLAYER_REGEN_DISABLED %s %s", InCombatLockdown() or "nil", UnitAffectingCombat ("player") or "nil")

	Nx.Social:PreCombatHide()
	Nx.Window:UpdateCombat()
end

function Nx:OnPlayer_regen_enabled()

--	Nx.prt ("OnPLAYER_REGEN_ENABLED %s %s", InCombatLockdown() or "nil", UnitAffectingCombat ("player") or "nil")

	Nx.Window:UpdateCombat()
end

function Nx:OnUnit_spellcast_sent (event, arg1, arg2, arg3, arg4)

	if arg1 == "player" then

		local Nx = Nx

--		Nx.prt ("SpellCastSent: %s^%s^%s", arg2, arg3, arg4)

		if arg2 == NXlHERBGATHERING then
			Nx.GatherTarget = Nx.TooltipLastText

			if NxData.NXDBGather then
				Nx.prt (L["Gather: %s %s"], arg2, Nx.GatherTarget or "nil")
			end

			if Nx.GatherTarget then
				Nx.UEvents:AddHerb (Nx.GatherTarget)
				Nx.GatherTarget = nil
			end

		elseif arg2 == NXlMINING then
			Nx.GatherTarget = Nx.TooltipLastText

			if NxData.NXDBGather then
				Nx.prt (L["Gather: %s %s"], arg2, Nx.GatherTarget)
			end

			if Nx.GatherTarget then
				Nx.UEvents:AddMine (Nx.GatherTarget)
				Nx.GatherTarget = nil
			end

		elseif arg2 == NXlARTIFACTS then

			Nx.UEvents:AddOpen ("Art", arg4)

		elseif arg2 == NXlEXTRACTGAS then

			Nx.UEvents:AddOpen ("Gas", NXlEXTRACTGAS)
--			Nx.prt ("Gas %s %s", arg3 or "nil", arg4 or "nil")

		elseif arg2 == NXlOpening or arg2 == NXlOpeningNoText then
			Nx.GatherTarget = Nx.TooltipLastText

			if arg4 == NXlGLOWCAP then
				Nx.UEvents:AddHerb (arg4)

			elseif arg4 == NXlEverfrost then
				Nx.UEvents:AddOpen ("Everfrost", arg4)

			end

--			Nx.prt ("SpellCastSent: %s", GameTooltipTextLeft1:GetText())
		end
	end
end

function Nx:OnUnit_spellcast_succeeded (event, arg1, arg2, arg3)

	if arg1 == "player" then

--		Nx.prt ("SpellCast: " .. arg2)

		if arg2 == NXlOpening or arg2 == NXlOpeningNoText then

			if Nx.GatherTarget then
				Nx.Warehouse.LootTarget = format ("O^%s", Nx.GatherTarget)
				Nx.GatherTarget = nil
			end
		end
	end
end

function Nx:OnUnit_spellcast_interrupted (event, arg1)

	if arg1 == "player" then

--		Nx.prt ("SpellCast Fail/Interrupted")

		Nx.GatherTarget = nil
		Nx.Warehouse.LootTarget = nil
	end
end

function Nx:OnZone_changed_new_area (event)

	Nx.UEvents:AddInfo (L["Entered"])

	Nx.Com:OnEvent (event)
end

function Nx:OnPlayer_level_up (event, arg1)

	Nx.UEvents:AddInfo (format (L["Level %d"], arg1))

	Nx.Com:OnPlayer_level_up (event, arg1)
end

function Nx.OnParty_members_changed()

	local self = Nx

	local members = {}
	self.GroupMembers = members

	local memberCnt = MAX_PARTY_MEMBERS
	local unitName = "party"

	if IsInRaid() then
		memberCnt = MAX_RAID_MEMBERS
		unitName = "raid"
	end

	self.GroupType = unitName

	for n = 1, memberCnt do

		local unit = unitName .. n
		local name = UnitName (unit)
		if name then
			members[name] = n
--			Nx.prt ("name %s #%s", name, n)
		end
	end

--	members[UnitName ("player")] = nil

	if Nx.Quest.Enabled then
		Nx.Quest.OnParty_members_changed()
	end
end

function Nx:OnChat_msg_bg_system_neutral (event, arg1, arg2, arg3)

	-- AB: The Battle begins in 2 minutes!
	-- AB: The Battle begins in 1 minute!
	-- AB: The Battle begins in 30 seconds!
	-- AV: 1 minute until the battle for...
	-- AV: 30 seconds until the battle for...
	-- EOS: The battle begins in 30 seconds!
	-- WG: ...Warsong Gulch begins in 30 seconds.  Pre...
	-- Arena: Thirty seconds until the Arena battle begins!
	-- Arena: Fifteen seconds until the Arena battle begins!

	if Nx.Info then

		local s1, s2, secs

		if strfind (arg1, L["One minute until the Arena"]) then
			secs = 60
		end
		if strfind (arg1, L["Thirty seconds until the Arena"]) then
			secs = 30
		end
		if strfind (arg1, L["Fifteen seconds until the Arena"]) then
			secs = 15
		end

		if not secs then
			s1, s2, secs = strfind (arg1, L[" begins? in (%d+) "])
			if not secs then
				s1, s2, secs = strfind (arg1, L["(%d+) minutes? until the battle"])
			end
		end

		if secs then
			secs = tonumber (secs)
			if secs then
				if secs <= 3 then	-- Minutes?
					secs = secs * 60
				end

				Nx.Info:SetBGStartTime (secs)
--				Nx.prt ("Start: %s", dur)
			end
		end
	end
end

function Nx:OnUpdate_battlefield_score (event)

	local plName = UnitName ("player")
	local scores = GetNumBattlefieldScores()
	local cb = Nx.Combat

	local show

	for n = 1, scores do
		local name, kbs, hks, deaths, honor, faction, rank, race, class, classCap, damDone, healDone = GetBattlefieldScore (n)
		if name == plName then

			honor = floor (honor)	--V4 returns weird fractions

			local any = kbs + deaths + hks + honor

			if any > 0 and (cb.KBs ~= kbs or cb.Deaths ~= deaths or cb.HKs ~= hks or cb.Honor ~= honor) then
				cb.KBs = kbs
				cb.Deaths = deaths
				cb.HKs = hks
				cb.Honor = honor

				show = true
			end

			cb.DamDone = damDone
			cb.HealDone = healDone

			break
		end
	end

	local opts = Nx:GetGlobalOpts()

	if show and opts["BGShowStats"] then

		local kbrank = 1

		for n = 1, scores do
			local name, kbs = GetBattlefieldScore (n)
			if name ~= plName then

				if kbs > cb.KBs then
					kbrank = kbrank + 1
				end
			end
		end

		Nx.prt (L["%s KB (#%d), %s Deaths, %s HK, %d Bonus"], cb.KBs, kbrank, cb.Deaths, cb.HKs, cb.Honor)
	end

end

--------
-- Generic update

function Nx:NXOnUpdate (elapsed)

	local Nx = Nx

	if not Nx.Loaded then	-- Safety check if ADDON_LOADED not yet called
		return
	end

	Nx.Tick = Nx.Tick + 1
--	Nx.Elapsed = Nx.Elapsed + elapsed

	if Nx.LootOn then
		Nx:LootIt()
	end

--	Nx.prt ("elapsed %s", elapsed)

	Nx.Timer:OnUpdate (elapsed)
	Nx.Proc:OnUpdate (elapsed)

	-- Tooltip stuff

	if not GameTooltip:IsVisible() then
--		Nx.prt ("TT hidden")
		Nx.TooltipLastDiffText = nil
	end

	local s = GameTooltipTextLeft1:GetText()
	if s then

		if Nx.Tick % 4 == 1 and GameTooltipTextLeft1:IsVisible() and #s > 5 then
			if Nx.TooltipLastDiffText ~= s or Nx.TooltipLastDiffNumLines ~= GameTooltip:NumLines() then
--				Nx.prtStrHex ("TT text", s)
--				Nx.prt ("TT %s #%s old %s", s, GameTooltip:NumLines(), Nx.TooltipLastDiffNumLines)

				if Nx.Quest.Enabled then
					Nx.Quest:TooltipProcess()
				end
			end
		end

--		if Nx.TooltipLastText ~= s then Nx.prt ("New TT text %s", s) end
		Nx.TooltipLastText = s
	end

	if Nx.TooltipOwner then
--		Nx.prt ("TooltipOwner %s", tostring (Nx.TooltipOwner))

		if not Nx.TooltipOwner:IsVisible() then
			if GameTooltip:IsOwned (Nx.TooltipOwner) then
				GameTooltip:Hide()
--				Nx.prt ("Tip hide")
			end
			Nx.TooltipOwner = nil
		end
	end

	--

	if self.NetSendPos then

		local t = GetTime()

		if t > self.NetPlyrSendTime then

			local plX, plY = GetPlayerMapPosition ("player")

			if plX > 0 or plY > 0 then

				local s = format (L["Map~%d~%d~%d"], plX * 100000000, plY * 100000000, Nx.Map:GetCurrentMapId())
				Nx.prt (L["NetSend %s"], s)
				Nx.Com:Send ("Z", s)

				self.NetPlyrSendTime = t + 1.5
			end
		end
	end

	local combat = UnitAffectingCombat ("player")
	if Nx.InCombat ~= combat then

		Nx.InCombat = combat

		if not combat and Nx.Info and Nx.Info.NeedDurability then	-- Left combat?
			Nx.Warehouse:CaptureInvDurability()
		end
	end

	Nx.Com:OnUpdate (elapsed)
	Nx.Map:MainOnUpdate (elapsed)

	if Nx.Quest.Enabled then
		Nx.Quest:OnUpdate (elapsed)
	end

	if Nx.Tick % 11 == 0 then
		Nx:RecordCharacter()
	end

	Nx.Social.PunksHUD:Update()
	Nx.Social.TeamHUD:Update()
	Nx.Social:OnUpdate()
end

--------
-- Loot vendor Test

function Nx:LootIt()

	local b = getglobal ("GossipTitleButton1")

	if b:IsVisible() then
		b:Click()
	end
end

--------
-- ShowUIPanel hook

function Nx.ShowUIPanel (frame)

	if frame then

		local opts = Nx:GetGlobalOpts()

--		Nx.prt ("ShowUIPanel " .. frame:GetName())

		if frame == _G["FriendsFrame"] and opts["SocialEnable"] then

			Nx.Social:ShowUIPanel (frame)

		elseif frame == _G["QuestLogFrame"] and opts["QEnable"] then

			Nx.Quest:ShowUIPanel (frame)

		else
			if not InCombatLockdown() then
				frame:Raise()
			end
		end
	end
end

function Nx.HideUIPanel (frame)

	if frame then

		local opts = Nx:GetGlobalOpts()

--		Nx.prt ("HideUIPanel " .. frame:GetName())

		if frame == _G["FriendsFrame"] and opts["SocialEnable"] then

			Nx.Social:HideUIPanel (frame)

		elseif frame == _G["QuestLogFrame"] and opts["QEnable"] then

			Nx.Quest:HideUIPanel (frame)
		end
	end
end

function Nx.CloseWindows()

--	Nx.prt ("CloseWindows %s", InCombatLockdown() or "nil")

	if not InCombatLockdown() then
		Nx.Social:HideUIPanel (_G["FriendsFrame"])		-- Causing taint in BGs
	end

	if Nx:GetGlobalOpts()["QEnable"] then
		Nx.Quest:HideUIPanel (_G["QuestLogFrame"])
	end
end

--------
-- Show a generic message with optional function callback

function Nx:ShowMessage (msg, func1Txt, func1, func2Txt, func2)

	local pop = StaticPopupDialogs["NxMsg"]

	if not pop then

		pop = {
			["whileDead"] = 1,
			["hideOnEscape"] = 1,
			["timeout"] = 0,
		}
		StaticPopupDialogs["NxMsg"] = pop
	end

	pop["text"] = msg
	pop["button1"] = func1Txt
	pop["OnAccept"] = func1
	pop["button2"] = func2Txt
	pop["OnCancel"] = func2

	StaticPopup_Show ("NxMsg")
end

--------
-- Show a generic edit box with optional function callback

function Nx:ShowEditBox (msg, val, userData, funcAccept, funcCancel)

--	Nx.prt ("ShowEditBox")

	local pop = StaticPopupDialogs["NxEdit"]

	if not pop then

		pop = {
			["whileDead"] = 1,
			["hideOnEscape"] = 1,
			["timeout"] = 0,
			["exclusive"] = 1,
			["hasEditBox"] = 1,
		}
		StaticPopupDialogs["NxEdit"] = pop
	end

	pop["maxLetters"] = 110
	pop["text"] = msg

	Nx.ShowEditBoxVal = tostring (val)
	Nx.ShowEditBoxUData = userData
	Nx.ShowEditBoxFunc = funcAccept

	pop["OnAccept"] = function (this)
		if Nx.ShowEditBoxFunc then
--			Nx.prt ("%s", this:GetName())
			Nx.ShowEditBoxFunc (_G[this:GetName().."EditBox"]:GetText(), Nx.ShowEditBoxUData)
		end
	end

	pop["EditBoxOnEnterPressed"] = function (this)
		if Nx.ShowEditBoxFunc then
			Nx.ShowEditBoxFunc (_G[this:GetParent():GetName().."EditBox"]:GetText(), Nx.ShowEditBoxUData)
		end
		this:GetParent():Hide()
	end

	pop["EditBoxOnEscapePressed"] = function (this)
		this:GetParent():Hide()
	end

	pop["OnShow"] = function (this)
		ChatEdit_FocusActiveWindow()
		local eb = _G[this:GetName().."EditBox"]
		eb:SetFocus()
		eb:SetText (Nx.ShowEditBoxVal)
		eb:HighlightText()
	end

	pop["OnHide"] = function (this)
--		Nx.prt ("msg OnHide")
--		local box = Nx:FindActiveChatFrameEditBox()	-- Useless since Blizz clears edit when we get focus
--		if box then
--			box:SetFocus()
--		end
		_G[this:GetName().."EditBox"]:SetText ("")
	end

	pop["button1"] = ACCEPT
	pop["button2"] = CANCEL
	pop["OnCancel"] = funcCancel

	StaticPopup_Show ("NxEdit")
end

--------
-- Show a trial message

function Nx:ShowMessageTrial()
end

--------
-- Find active chat frame edit box. Added for patch 3.35 because there is one for each possible chat window now
-- Was called ChatFrameEditBox. Now ChatFrame1EditBox to ChatFrame10EditBox

function Nx:FindActiveChatFrameEditBox()

--	if ChatEdit_GetActiveWindow() then
--		Nx.prt ("act %s", ChatEdit_GetActiveWindow():GetName())
--	end

	return ChatEdit_GetActiveWindow()

--[[
	for n = 1, 10 do
		local box = _G["ChatFrame" .. n .. "EditBox"]
		if box and box:IsVisible() then
			if #box:GetText() > 0 then		-- Any text entered?
--				Nx.prt ("box %s", n)
				return box
			end

			return
		end
	end
--]]
end

--------
-- Get time in seconds * 100. Adds fake hundreths

function Nx:Time()

	local tm = time()

	if tm > self.TimeLast then
		self.TimeFrac = 0
	else
		self.TimeFrac = self.TimeFrac + 1
	end

	self.TimeLast = tm

	return tm * 100 + self.TimeFrac
end

function Nx:UnitIsPlusMob (target)
	local c = UnitClassification (target)
--	Nx.prt ("Class %s", c)
	return c == "elite" or c == "rareelite" or c == "worldboss"
end

--------------------------------------------------------------------------------
-- Global Data Management

-- Gather format {}
--  Herb [map id] = { [#] = { Id = #, Cnt = times gathered, X, Y } }
--  Mine ^

function Nx:InitGlobal()

	if NxData.Version < Nx.VERSIONDATA then

		if NxData.Version > 0 then
			Nx.prt (L["Reset old data %f"], NxData.Version)
		end

		NxData = {}
		NxData.Version = Nx.VERSIONDATA
		NxData.Characters = {}  -- Indexed by "Server.Name"
	end

	if not NxData.NXVer1 then
		NxData.NXVer1 = Nx.VERSION
	end

	Nx:InitCharacter()

	-- 

--	local unitName = Nx.DemungeStr ("TnjrManc")	-- UnitName
--	Nx.PlayerName = _G[unitName] (Nx.DemungeStr ("olbwdr"))		-- player

	-- Global options

	local opts = NxData.NXGOpts

	if not opts or opts.Version < Nx.VERSIONGOPTS then

		if opts and opts.Version < Nx.VERSIONGOPTS then
			Nx.prt (L["Reset old global options %f"], opts.Version)
			Nx:ShowMessage (L["Options have been reset for the new version.\nPrivacy or other settings may have changed."], L["OK"])
		end

		opts = {}
		NxData.NXGOpts = opts
		opts.Version = Nx.VERSIONGOPTS

		Nx.Opts:Reset()
	end

	-- Clean old junk

--	opts.NXCleaned = nil

	if not opts.NXCleaned then

		opts.NXCleaned = true

		local keep = {
			["Characters"] = 1,
			["NXCap"] = 1,
			["NXFav"] = 1,
			["NXGather"] = 1,
			["NXGOpts"] = 1,
			["NXHUDOpts"] = 1,
			["NXInfo"] = 1,
			["NXQOpts"] = 1,
			["NXSocial"] = 1,
			["NXTravel"] = 1,
			["NXVendorV"] = 1,
			["NXVendorVVersion"] = 1,
			["NXVer1"] = 1,
			["NXVerT"] = 1,
			["NXWare"] = 1,
			["Version"] = 1,
		}

		local cnt = 0
		for k, v in pairs (NxData) do
			if not keep[k] then
				NxData[k] = nil
--				Nx.prt ("Cleaned %s", k)
				cnt = cnt + 1
			end
		end

		if cnt > 0 then
			Nx.prt (L["Cleaned %d items"], cnt)
		end
	end

	-- Fav (favorite) data

	local fav = NxData.NXFav

	if not fav or fav.Version < Nx.VERSIONFAV then

		if fav then
			Nx.prt (L["Reset old favorite data %f"], fav.Version)
		end

		fav = {}
		NxData.NXFav = fav
		fav.Version = Nx.VERSIONFAV
	end

	-- HUD options

	local opts = NxData.NXHUDOpts

	if not opts or opts.Version < Nx.VERSIONHUDOPTS then

		if opts then
			Nx.prt (L["Reset old HUD options %f"], opts.Version)
		end

		opts = {}
		NxData.NXHUDOpts = opts
		opts.Version = Nx.VERSIONHUDOPTS

--		Nx.HUD:OptsReset()
	end

	-- Info win data

	local info = NxData.NXInfo

	if not info or info.Version < Nx.VERSIONINFO then

		if info then
			Nx.prt (L["Reset old info data %f"], info.Version)
		end

		info = {}
		NxData.NXInfo = info
		info.Version = Nx.VERSIONINFO
	end

 	-- Quest options

	local qopts = NxData.NXQOpts

	if not qopts or qopts.Version < Nx.VERSIONQOPTS then

		if qopts then
			Nx.prt (L["Reset old quest options %f"], qopts.Version)
		end

		qopts = {}
		NxData.NXQOpts = qopts
		qopts.Version = Nx.VERSIONQOPTS

		Nx.Quest:OptsReset()
	end

	-- Social data

	local soc = NxData.NXSocial

	if not soc or soc.Version < Nx.VERSIONSOCIAL then

		if soc then
			Nx.prt (L["Reset old social data %f"], soc.Version)
		end

		soc = {}
		NxData.NXSocial = soc
		soc.Version = Nx.VERSIONSOCIAL
	end

	local rn = GetRealmName()

	if not soc[rn] then
		local t = {}
		soc[rn] = t
		t["Pal"] = {}
		t["Pal"][""] = {}		-- Default non person
		t["Pk"] = {}
	end

	soc[rn]["PkAct"] = soc[rn]["PkAct"] or {}

	-- Travel data

	local tr = NxData.NXTravel

	if not tr or tr.Version < Nx.VERSIONTRAVEL then

		if tr then
			Nx.prt (L["Reset old travel data %f"], tr.Version)
		end

		tr = {}
		NxData.NXTravel = tr
		tr.Version = Nx.VERSIONTRAVEL
	end

	tr["TaxiTime"] = tr["TaxiTime"] or {}

	-- Warehouse data

	local ware = NxData.NXWare

	if not ware or ware.Version < Nx.VERSIONWare then

		if ware then
			Nx.prt (L["Reset old warehouse data %f"], ware.Version)
		end

		ware = {}
		NxData.NXWare = ware
		ware.Version = Nx.VERSIONWare
	end

	-- Gather data

	local gath = NxData.NXGather

	if not gath or gath.Version < Nx.VERSIONGATHER then

		if gath and gath.Version < 0 then
			Nx.DoGatherUpgrade = gath.Version

		else
			if gath then
				Nx.prt (L["Reset old gather data %f"], gath.Version)
			end

			gath = {}
			NxData.NXGather = gath
			gath.NXHerb = {}
			gath.NXMine = {}
		end

		gath.Version = Nx.VERSIONGATHER
	end

	gath["Misc"] = gath["Misc"] or {}
--	gath.NXGas = gath.NXGas or {}

	-- Capture data

	local cap = NxData.NXCap		-- Keep NX

--	cap = nil		-- Nuke test

	if not cap or cap.Version < Nx.VERSIONCAP then

--		if cap then
--			Nx.prt ("Reset old cap %f", cap.Version)
--		end

		cap = {}
		NxData.NXCap = cap
		cap.Version = Nx.VERSIONCAP
		cap["Q"] = {}

--		Nx.HUD:OptsReset()
	end

	cap["NPC"] = cap["NPC"] or {}
--	if not NxData.EOL then
--		message("This will be the last version of Carbonite. Watch for Carbonite2 Soon.\nTest Versions can be found on WoWI and Curse as Carbonite alpha releases now")
--		NxData.EOL = "seen"
--	end
end

--------
-- Get generic named data (global, character, database)

function Nx:GetData (name, ch)

	ch = ch or Nx.CurCharacter

	if name == "Events" then
		return ch.E

	elseif name == "List" then
		return ch["L"]

	elseif name == "Quests" then
		return ch.Q

	elseif name == "Win" then
		return ch.W

	elseif name == "Herb" then
		return NxData.NXGather.NXHerb

	elseif name == "Mine" then
		return NxData.NXGather.NXMine

	end
end

--------
-- Copy character data

function Nx:CopyCharacterData (srcName, dstName)

	if not srcName then

		-- Export me to everyone

		local sch = Nx.CurCharacter

		for rc, dch in pairs (NxData.Characters) do

			if dch ~= sch then

				Nx.Window:CopyLayoutsCheck (sch.W, dch.W)

				dch.W = sch.W
				dch["L"] = sch["L"]
				dch["TBar"] = sch["TBar"]
			end
		end
	else

		local sch = Nx:FindCharacter (srcName)
		local dch = Nx:FindCharacter (dstName)

		if not sch or not dch then
			Nx.prt (L["Missing character data!"])
			return
		end

		if not Nx.Window:CopyLayoutsCheck (sch.W, dch.W) then
			return
		end

		-- Change references. Save will make copy

		dch.W = sch.W
		dch["L"] = sch["L"]
		dch["TBar"] = sch["TBar"]
	end

	return true
end

--------
-- Delete character data

function Nx:DeleteCharacterData (srcName)

	self:DeleteCharacter (srcName)
	self:CalcRealmChars()
	self.Warehouse:Update()
end

--------
-- Import/Export

function Nx:ImportCharacterData()

	local tData = CarboniteTransferData
	if not tData then
		Nx.prtError (L["Carbonite Transfer addon is not loaded"])
		return
	end

	local accountName = GetCVar ("accountName")
	if accountName == "" then
		Nx.prtError (L["'Remember Account Name' must be checked"])
		return
	end

	local realmName = GetRealmName()

	for aName, aData in pairs (tData) do

		if aName ~= accountName then

			if aData.Version ~= Nx.VERSIONTransferData then
				Nx.prt (L["Account %s data has wrong version"], aName)

			else
				for rName, rData in pairs (aData) do
					if rName == realmName then

						Nx.prt (L["Importing account %s"], aName)

						for cName, cData in pairs (rData) do

							local rc = rName .. "." .. cName

							NxData.Characters[rc] = cData
							cData["Account"] = aName			-- Remember source account
						end

						aData[rName] = nil
					end
				end
			end
		end
	end
end

function Nx:ExportCharacterData()

	local tData = CarboniteTransferData
	if not tData then
		Nx.prtError (L["Carbonite Transfer addon is not loaded"])
		return
	end

	local accountName = GetCVar ("accountName")
	if accountName == "" then
		Nx.prtError (L["'Remember Account Name' must be checked on Login screen"])
		return
	end

	Nx.prt (L["Exporting account %s data"], accountName)

	local realmName = GetRealmName()

	local act = tData[accountName]
	if not act or act.Version < Nx.VERSIONTransferData then
		act = {}
		act.Version = Nx.VERSIONTransferData
	end
	tData[accountName] = act

	local data = {}
	act[realmName] = data

	for cnum, rc in ipairs (Nx.RealmChars) do

		local rname, cname = strsplit (".", rc)

		local ch = NxData.Characters[rc]
		if ch then

			if not ch["Account"] then		-- Only export our own characters

				Nx.prt (L[" Exporting %s"], cname)

				local t = Nx.Util_TCopyRecurse (ch)
				data[cname] = t

				t["E"] = nil
				t["L"] = nil
				t["Q"] = nil
				t["W"] = nil
				t["TBar"] = nil
			end
		end
	end
end

--------
-- Get data

function Nx:GetDataToolBar()
	return Nx.CurCharacter["TBar"]
end

--------
-- Get global options

function Nx:GetGlobalOpts()
	return NxData.NXGOpts
end

--------
-- Get Favorite data

function Nx:GetFav()
	return NxData.NXFav
end

--------
-- Get HUD options

function Nx:GetHUDOpts()
	return NxData.NXHUDOpts
end

--------
-- Get quest options

function Nx:GetQuestOpts()
	return NxData.NXQOpts
end

--------
-- Get Social data

function Nx:GetSocial (typ)
	local rn = GetRealmName()
	return NxData.NXSocial[rn][typ]
end

--------
-- Clear Social data

function Nx:ClearSocial (typ)
	local rn = GetRealmName()
	NxData.NXSocial[rn][typ] = {}
end

--------
-- Get Travel data

--function Nx:GetTravel (name)
--	return NxData.NXTravel[name]
--end

--------
-- Get Captured data

function Nx:GetCap()
	return NxData.NXCap
end

function Nx:CaptureFind (t, key)

	assert (type (t) == "table" and key)

	local d = t[key] or {}
	t[key] = d
	return d
end

--------
-- Make packed XY string
-- (xy 0-100)

function Nx:PackXY (x, y)

	x = max (0, min (100, x))
	y = max (0, min (100, y))
	return format ("%03x%03x", x * 40.9 + .5, y * 40.9 + .5)		-- Round off
end

--------

function Nx:UnpackXY (xy)

	local x = tonumber (strsub (xy, 1, 3), 16) / 40.9
	local y = tonumber (strsub (xy, 4, 6), 16) / 40.9
	return x, y
end

--------------------------------------------------------------------------------
-- Character Data Management

-- Event format OLD! Now a packed string!
--  Type table [Info, Kill, Death, Mine, Herb]
--   All have: Name, Time, Map, X, Y
--   T added by GetAllEvents for type ("I" "K" "D" "M" "H")
--   Kill: Level

-- Quest format
--  table index [quest id]
--  string "STime"
--   S (status char): C completed, c not completed, W watched
--   Time is number from time()

function Nx:InitCharacter()

--	NxData.Characters = {}

	local chars = NxData.Characters
	local fullName = self:GetRealmCharName()
	local ch = chars[fullName]

	if not ch or ch.Version < Nx.VERSIONCHAR then
		-- Add a new character
		ch = {}
		chars[fullName] = ch

		ch.Version = Nx.VERSIONCHAR

		ch.E = {}	-- Events
		ch.Q = {}	-- Quests
	end

	Nx.CurCharacter = ch

	ch["Opts"] = ch["Opts"] or {}		-- Character options
	Nx.CharOpts = ch["Opts"]			-- Shortcut

	ch["L"] = ch["L"] or {}	-- List
	ch.W = ch.W or {}			-- Window layouts

	if not ch["TBar"] then
		ch["TBar"] = {}	-- Tool Bar layouts
	end

	ch["Profs"] = ch["Profs"] or {}	-- Professions
	ch["Professions"] = nil				-- Old

--[[
	if not ch.E["Info"] then
		ch.E["Info"] = {}
	end

	if not ch.E["Death"] then
		ch.E["Death"] = {}
	end

	if not ch.E["Kill"] then
		ch.E["Kill"] = {}
	end

	if not ch.E["Herb"] then
		ch.E["Herb"] = {}
	end

	if not ch.E["Mine"] then
		ch.E["Mine"] = {}
	end
--]]

	self:DeleteOldEvents()

	ch.NXLoggedOnNum = ch.NXLoggedOnNum or 0 + 1

	--

	local cd = NxCData

	if not cd or cd.Version < Nx.VERSIONCharData then

		cd = {}
		NxCData = cd

		cd.Version = Nx.VERSIONCharData

		cd["Taxi"] = {}		-- Taxi nodes we have
	end

	--

	self:CalcRealmChars()
end


--------
-- 

function Nx:GetRealmCharName()
	return GetRealmName() .. "." .. UnitName ("player")
end

--------
-- 

function Nx:CalcRealmChars()

	local chars = NxData.Characters

	local realmName = GetRealmName()
	local fullName = realmName .. "." .. UnitName ("player")

	local t = {}

	for rc, v in pairs (chars) do
		if v ~= Nx.CurCharacter then

			local rname = strsplit (".", rc)
			if rname == realmName then
				tinsert (t, rc)
			end
		end
	end

	sort (t)		-- Alphabetical

	tinsert (t, 1, fullName)	-- Put me at top

	self.RealmChars = t

	-- Fix char data

	for cnum, rc in ipairs (self.RealmChars) do

		local ch = chars[rc]
		if ch then

			if ch["XP"] then
				ch["XPMax"] = ch["XPMax"] or 1
				ch["XPRest"] = ch["XPRest"] or 0
				ch["LXP"] = ch["LXP"] or 0
				ch["LXPMax"] = ch["LXPMax"] or 1
				ch["LXPRest"] = ch["LXPRest"] or 0
			end

			ch["TimePlayed"] = ch["TimePlayed"] or 0
		end
	end
end

--------
-- Find character data for a named character on current realm or all realms if "realm.name"

function Nx:FindCharacter (name)

	for cnum, rc in ipairs (Nx.RealmChars) do

		local ch = NxData.Characters[rc]
		if ch then

			local rname, cname = strsplit (".", rc)
			if cname == name then
				return ch
			end
		end
	end

	return NxData.Characters[name]
end

--------
-- Delete character data for a named character on current realm or all realms if "realm.name"

function Nx:DeleteCharacter (name)

	for cnum, rc in ipairs (Nx.RealmChars) do

		local ch = NxData.Characters[rc]
		if ch then

			local rname, cname = strsplit (".", rc)
			if cname == name then
				NxData.Characters[rc] = nil
				return
			end
		end
	end

	NxData.Characters[name] = nil
end

--------

function Nx:GetUnitClass()
	local _, cls = UnitClass ("player")
	cls = gsub (Nx.Util_CapStr (cls), "Deathknight", "Death Knight")
	return cls
end

--------
-- Record logged in state

function Nx:RecordCharacterLogin()

--	Nx.prt ("Log in %d", GetMoney())

	local ch = self.CurCharacter

	ch["LTime"] = time()
	ch["LvlTime"] = time()

	ch["LLevel"] = UnitLevel ("player")
	ch["Class"] = Nx:GetUnitClass()

	ch["LMoney"] = GetMoney()

	ch["LXP"] = UnitXP ("player")
	ch["LXPMax"] = UnitXPMax ("player")
	ch["LXPRest"] = GetXPExhaustion() or 0

	local _, arena = GetCurrencyInfo (390)
	local _, honor = GetCurrencyInfo (392)

	ch["LArenaPts"] = arena		--V4 gone GetArenaCurrency()
	ch["LHonor"] = honor			--V4 gone GetHonorCurrency()

	Nx.Warehouse:GuildRecord()

	Nx:RecordCharacter()
end

function Nx:RecordCharacter()

--	Nx.prt ("RecordCharacter")

	local ch = self.CurCharacter

	local map = self.Map:GetMap (1)
	if map.RMapId then
		ch["Pos"] = format ("%d^%f^%f", map.RMapId, map.PlyrRZX, map.PlyrRZY)
	end

	ch["Time"] = time()

	ch["Level"] = UnitLevel ("player")

	if ch["Level"] > ch["LLevel"] then	-- Made a level? Reset
		ch["LLevel"] = ch["Level"]
		ch["LvlTime"] = time()
		ch["LXP"] = UnitXP ("player")
		ch["LXPMax"] = UnitXPMax ("player")
		ch["LXPRest"] = GetXPExhaustion() or 0
	end

	ch["Money"] = GetMoney()

	ch["XP"] = UnitXP ("player")
	ch["XPMax"] = UnitXPMax ("player")
	ch["XPRest"] = GetXPExhaustion() or 0

	local _, arena = GetCurrencyInfo (390)
	local _, honor = GetCurrencyInfo (392)

	ch["ArenaPts"] = arena		--V4 gone GetArenaCurrency()
	ch["Honor"] = honor			--V4 gone GetHonorCurrency()

	if self.Warehouse.TimePlayed then
		ch["TimePlayed"] = self.Warehouse.TimePlayed
		self.Warehouse.TimePlayed = nil

		if Nx.BlizzChatFrame_DisplayTimePlayed then
			ChatFrame_DisplayTimePlayed = Nx.BlizzChatFrame_DisplayTimePlayed		-- Restore
			Nx.BlizzChatFrame_DisplayTimePlayed = nil
		end
	end

	Nx.InfoStats["ArenaPts"] = ch["ArenaPts"]
	Nx.InfoStats["Honor"] = ch["Honor"]
	Nx.InfoStats["XPRest%"] = ch["XPRest"] / ch["XPMax"] * 100
end

--------
-- Adds all events to a table

--[[
function Nx:AddAllEvents (t)

	local cc = Nx.CurCharacter

	for k, v in pairs (cc.E["Info"]) do
		tinsert (t, v)
	end

	for k, v in pairs (cc.E["Death"]) do
		tinsert (t, v)
	end

	for k, v in pairs (cc.E["Kill"]) do
		tinsert (t, v)
	end

	for k, v in pairs (cc.E["Herb"]) do
		tinsert (t, v)
	end

	for k, v in pairs (cc.E["Mine"]) do
		tinsert (t, v)
	end
end
--]]

function Nx:DeleteOldEvents()

	for rc, ch in pairs (NxData.Characters) do

--		Nx.prt ("char %s", rc)
--		assert (ch.E)

		if not ch.E or ch.E["Info"] then		-- Missing or has an old table? (User had missing table)
			ch.E = {}
		end

		self:DeleteOldEvent (ch.E, 60)
--[[
		local e = ch.E
		self:DeleteOldEvent (e["Info"], 60)
		self:DeleteOldEvent (e["Death"], 20)
		self:DeleteOldEvent (e["Kill"], 50)
		self:DeleteOldEvent (e["Herb"], 15)
		self:DeleteOldEvent (e["Mine"], 15)
--]]
	end
end

function Nx:DeleteOldEvent (ev, maxE)

--	Nx.prt ("Del event %d", #ev)

--[[
	local n = 1

	while n <= #ev do
		if type (ev[n]) == "table" then		-- Old table format?
--			Nx.prt ("Remove %d %d", n, #ev)
			tremove (ev, n)
		else
			n = n + 1
		end
	end
--]]

	if #ev > maxE then

		for n = 1, #ev - maxE do
--			Nx.prt ("Remove %d", n)
			tremove (ev, 1)
		end
	end
end

--------
-- Add event
-- (event) 1 letter name: I,K,D,H,M
-- (data) is optional string

function Nx:AddEvent (event, name, time, mapId, x, y, data)

	local ev = Nx.CurCharacter.E

--[[
	local i = #ev + 1

	local item = {}

	item.NXName = name
	item.NXTime = time
	item.NXMapId = mapId
	item.NXX = x
	item.NXY = y
--]]

	local s = Nx:PackXY (x, y)
	name = gsub (name, "^", "")

	s = format ("%s^%.0f^%d^%s^%s", event, time, Nx.MapIdToNxzone[mapId] or 0, s, name)

	if data then
		s = s .. "^" .. data
	end

	tinsert (ev, s)
end

--------

--function Nx:GetEventType (evStr)
--	return strsub (evStr, 1, 1)
--end

--------

function Nx:GetEventMapId (evStr)

	local _, _, map = strsplit ("^", evStr)

	return self.NxzoneToMapId[tonumber (map)] or 0
end

--------

function Nx:UnpackEvent (evStr)

	local typ, tm, map, xy, text, data = strsplit ("^", evStr)

	tm = tonumber (tm)
	map = self.NxzoneToMapId[tonumber (map)] or 0

	local x, y = Nx:UnpackXY (xy)

	return typ, tm, map, x, y, text, data
end

--------

function Nx:AddInfoEvent (name, time, mapId, x, y)
	self:AddEvent ("I", name, time, mapId, x, y)
end

function Nx:AddDeathEvent (name, time, mapId, x, y)
	self:AddEvent ("D", name, time, mapId, x, y)
end

function Nx:AddKillEvent (name, time, mapId, x, y)

	local ev = self.CurCharacter.E

	local kills = 1

	for k, item in ipairs (ev) do

		local typ, tm, mapId, x, y, text = self:UnpackEvent (item)

		if typ == "K" and text == name then
			kills = kills + 1
		end
	end

	self:AddEvent ("K", name, time, mapId, x, y, format ("%d", kills))
end

function Nx:AddHerbEvent (name, time, mapId, x, y)
	self:AddEvent ("H", name, time, mapId, x, y)
end

function Nx:AddMineEvent (name, time, mapId, x, y)
	self:AddEvent ("M", name, time, mapId, x, y)
end

--------
-- Get status for a quest

function Nx:GetQuest (qId)

	local quest = Nx.CurCharacter.Q[qId]
	if not quest then
		return
	end

	local s1, s2, status, time = strfind (quest, "(%a)(%d+)")

--	Nx.prt ("GetQuest %s %d", status, time)

	return status, time
end

function Nx:SetQuest (qId, qStatus, qTime)

	qTime = qTime or 0

	Nx.CurCharacter.Q[qId] = qStatus .. qTime

--	Nx.prt ("SetQuest %s", Nx.CurCharacter.Q[qId])
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Title

function Nx.Title:Init()

	local f = CreateFrame ("Frame", nil, UIParent)
	f.NxInst = self
	self.Frm = f

	f:SetFrameStrata ("HIGH")

	f:SetWidth (400)
	f:SetHeight (192)

	local bk = {
		["bgFile"] = "Interface\\Buttons\\White8x8",
		["edgeFile"] = "Interface\\DialogFrame\\UI-DialogBox-Border",
		["tile"] = true,
		["tileSize"] = 16,
		["edgeSize"] = 16,
		["insets"] = { ["left"] = 2, ["right"] = 2, ["top"] = 2, ["bottom"] = 2 }
	}

	f:SetBackdrop (bk)
	f:SetBackdropColor (0, 0, .1, 1)

	local lf = CreateFrame ("Frame", nil, f)

	lf:SetWidth (256)
	lf:SetHeight (128)

	lf:SetPoint ("CENTER", 0, 0)

	local t = lf:CreateTexture()
	t:SetTexture (Nx.Help.Logo)
--	t:SetVertexColor (1, 1, 1, 1)
	t:SetAllPoints (lf)
	lf.texture = t

	for n = 1, 2 do
		local fstr = f:CreateFontString()
		self["NXFStr"..n] = fstr
		fstr:SetFontObject ("GameFontNormal")
		fstr:SetJustifyH ("CENTER")
		fstr:SetPoint ("TOPLEFT", 0, -158 - (n - 1) * 14)
		fstr:SetWidth (400)
		fstr:Show()
	end

	local str

	if Nx.VERMINOR > 0 then
		str = NXTITLEFULL .. L[" |cffe0e0ffVersion %d.%d Build %d"]
	else
		str = NXTITLEFULL .. L[" |cffe0e0ffVersion %d.%d Build %d"]
	end

	str = format (str, Nx.VERMAJOR,Nx.VERMINOR*10, Nx.BUILD)

	self.NXFStr1:SetText (str)
	self.NXFStr2:SetText (L["|cffe0e0ffMaintained by Rythal of Moonguard"])

	Nx.Proc:New (self, self.TickWait, 40)

--	f:Show()
end

function Nx.Title:TickWait (proc)

	Nx.Map:StartupZoom()
	Nx.Proc:SetFunc (proc, self.TickWait2)
	return 30
end

function Nx.Title:TickWait2 (proc)

	Nx.Help.License:ShowOnce()

	self.X = 0
	self.Y = GetScreenHeight() * .4
	self.XV = 0
	self.YV = 0
	self.Scale = .8
	self.ScaleTarget = .8
	self.Alpha = 0
	self.AlphaTarget = 1

--	Nx.prt ("Y %s", self.Y)

	local opts = Nx:GetGlobalOpts()
	if opts["TitleSoundOn"] then
		PlaySound ("ReadyCheck")
	end

	Nx.Proc:SetFunc (proc, self.Tick)
end

function Nx.Title:Tick()

	local this = self.Frm

--PAIDS!
	local opts = Nx:GetGlobalOpts()
	if opts["TitleOff"] then
		this:Hide()
	end
--PAIDE!

	self.X = self.X + self.XV
	self.Y = self.Y + self.YV

	self.Scale = Nx.Util_StepValue (self.Scale, self.ScaleTarget, .8 / 60)

	this:SetPoint ("CENTER", self.X / self.Scale, self.Y / self.Scale)
	this:SetScale (self.Scale)

--	Nx.prt ("Title %f %f", elapsed, self.Alpha)

	self.Alpha = Nx.Util_StepValue (self.Alpha, self.AlphaTarget, .8 / 60)
	this:SetAlpha (self.Alpha)

	if self.Alpha == 1 then

		local sw = GetScreenWidth() / 2
		local sh = GetScreenHeight() / 2
		self.XV = (sw * .95 - self.X) / 80
		self.YV = (sh * .95 - self.Y) / 80

		self.ScaleTarget = .03
		self.AlphaTarget = 0

		return 1 * 60
	end

	if self.Alpha == 0 then

		this:Hide()
		collectgarbage ("collect")
		return -1	-- Die
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Auction

--PAIDS!

function Nx.AuctionAssist.OnAuction_house_show()

--	Nx.prt ("OnAUCTION_HOUSE_SHOW")

	if IsAddOnLoaded ("Blizzard_AuctionUI") then
		hooksecurefunc ("AuctionFrameBrowse_Update", Nx.AuctionAssist.AuctionFrameBrowse_Update)
		Nx.AuctionAssist:Create()
	end
end

function Nx.AuctionAssist.OnAuction_house_closed()

--	Nx.prt ("OnAUCTION_HOUSE_CLOSED")

	local self = Nx.AuctionAssist
	if self.Win then
		self.Win:Show (false)
		self.ItemList:Empty()
	end
end

function Nx.AuctionAssist.OnAuction_item_list_update()
--	Nx.prt ("OnAUCTION_ITEM_LIST_UPDATE")
	Nx.AuctionAssist:Update()
end

--------
-- Create favorites window

function Nx.AuctionAssist:Create()
end

--------
-- On list events

function Nx.AuctionAssist:OnListEvent (eventName, sel, val2, click)

--	Nx.prt ("Guide list event "..eventName)

	local name = self.List:ItemGetData (sel)

	Nx.prt ("%s", name)

	BrowseName:SetText (name)
	AuctionFrameBrowse_Search()
end

function Nx.AuctionAssist:Update()

end

--------

function Nx.AuctionAssist.AuctionFrameBrowse_Update()

	if not Nx.AuctionShowBOPer then
		return
	end

--	Nx.prt ("Auction")

	local low = 99999999
	local lowName
	local lowIName

	local numBatchAuctions, totalAuctions = GetNumAuctionItems ("list")
	local offset = FauxScrollFrame_GetOffset (BrowseScrollFrame)
	local last = offset + NUM_BROWSE_TO_DISPLAY

--	Nx.prt ("Auction off %d %d %d", offset, numBatchAuctions, totalAuctions)

	for n = 1, NUM_AUCTION_ITEMS_PER_PAGE do

		local name, texture, count, quality, canUse, level, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner = GetAuctionItemInfo ("list", n)

--		Nx.prt ("Auction #%d %d %d", n, buyoutPrice, count)

		local index = n + NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse["page"]

		if index > numBatchAuctions + NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse["page"] then
			break
		end

		if bidAmount == 0 then
			requiredBid = minBid
		else
			requiredBid = bidAmount + minIncrement
		end

		if requiredBid >= MAXIMUM_BID_PRICE then
			buyoutPrice = requiredBid
		end

		if buyoutPrice > 0 then

			local price1 = floor (buyoutPrice / count)

			if n > offset and n <= last then

				local buttonName = "BrowseButton" .. (n - offset)
				local itemName = _G[buttonName .. "Name"]

				if itemName then

					if price1 < low then
						low = price1
						lowName = name
						lowIName = itemName
					end

--					Nx.prtVar ("name", buttonName)

					if count > 1 then

						itemName:SetText (format ("%s *", name))

						local color = ITEM_QUALITY_COLORS[quality]
						itemName:SetVertexColor (color.r, color.g, color.b)

						local bf = _G[buttonName.."BuyoutFrameMoney"]
						if bf then
							MoneyFrame_Update (bf:GetName(), price1)
						end
					end
				end

			elseif price1 < low then
				low = price1
				lowName = nil
			end
		end
	end

	if lowName then
		lowIName:SetText (format (L["%s * low"], lowName))
	end
end

--PAIDE!

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Combat

NxCOMBATOPTS_VERSION	= .01

NxCombatOpts = {
	Version = NxCOMBATOPTS_VERSION,
--	NXOpened = nil,
}

--------
-- Init combat

function Nx.Combat:Init()

	self.KBs = 0
	self.Deaths = 0
	self.HKs = 0
	self.Honor = 0
	self.DamDone = 0
	self.HealDone = 0

	local o = NxCombatOpts

	o.FrmX = nil
	o.FrmY = nil
	o.Opened = nil
	o.NXOpened = nil

	self.Frm = nil
	self.HitPeak = 1
	self.HitTotal = 0
	self.HitBest = 0
	self.W = 400
	self.H = 80
	self.InCombat = false
	self.AttackerName = "?"
end

--------
-- Open and init or toggle combat frame

function Nx.Combat:Open()

--PAIDS!

	local win = self.Win

	if win then
		if win:IsShown() then
			win:Show (false)
--			NxCombatOpts.NXOpened = nil
		else
			win:Show()
--			NxCombatOpts.NXOpened = true
		end
		return
	end

--	NxCombatOpts.NXOpened = true

	self.EventTable = {
--[[
		CHAT_MSG_COMBAT_CREATURE_VS_SELF_HITS = self.OnEventRecvDamage,
		CHAT_MSG_SPELL_CREATURE_VS_SELF_DAMAGE = self.OnEventRecvDamage,
		CHAT_MSG_COMBAT_HOSTILEPLAYER_HITS = self.OnEventRecvDamage,
		CHAT_MSG_SPELL_HOSTILEPLAYER_DAMAGE = self.OnEventRecvDamage,
		CHAT_MSG_SPELL_PERIODIC_SELF_DAMAGE = self.OnEventRecvDamage,
--]]
	}

	-- Create window

	local win = Nx.Window:Create ("NxCombat", nil, nil, nil, nil, nil, true)
	self.Win = win

	win:InitLayoutData (nil, -.7, -.7, -.3, -.06)

	win:CreateButtons (true)

	-- Create frame

	local f = CreateFrame ("Frame", nil, UIParent)
	self.Frm = f
	f.NxCombat = self

	win:Attach (f, 0, 1, 0, 1)

	f:SetScript ("OnEvent", self.OnEvent)

--	f:RegisterEvent ("COMBAT_LOG_EVENT")
	f:RegisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
--[[
	f:RegisterEvent ("CHAT_MSG_COMBAT_SELF_HITS")
	f:RegisterEvent ("CHAT_MSG_COMBAT_PET_HITS")
	f:RegisterEvent ("CHAT_MSG_SPELL_SELF_DAMAGE")
	f:RegisterEvent ("CHAT_MSG_SPELL_PET_DAMAGE")
	f:RegisterEvent ("CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE")
	f:RegisterEvent ("CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE")
	f:RegisterEvent ("CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF")
	f:RegisterEvent ("CHAT_MSG_COMBAT_HOSTILE_DEATH")
--]]
	f:RegisterEvent ("CHAT_MSG_COMBAT_XP_GAIN")
	f:RegisterEvent ("CHAT_MSG_COMBAT_HONOR_GAIN")
	f:RegisterEvent ("CHAT_MSG_LOOT")
--	f:RegisterEvent ("CHAT_MSG_MONEY")
--	f:RegisterEvent ("CHAT_MSG_COMBAT_MISC_INFO")

	f:RegisterEvent ("PLAYER_REGEN_DISABLED")
	f:RegisterEvent ("PLAYER_REGEN_ENABLED")

	for k, v in pairs (self.EventTable) do
--		Nx.prt ("Reg %s", k)
		f:RegisterEvent (k)
	end

	f:RegisterEvent ("PLAYER_DEAD")

	f:SetScript ("OnUpdate", self.OnUpdate)

	f:SetScript ("OnEnter", self.OnEnter)
	f:SetScript ("OnLeave", self.OnEnter)
	f:EnableMouse (true)

	f:SetFrameStrata ("MEDIUM")

	local t = f:CreateTexture()
	t:SetTexture (.2, .2, .2, .5)
	t:SetAllPoints (f)
	f.texture = t

	f:Show()

	self:OpenGraph()

--PAIDE!
end

function Nx.Combat:OpenGraph()

	self.GraphHits = Nx.Graph:Create (self.W, 50, self.Frm)

	local f = self.GraphHits.MainFrm
	self.Win:Attach (f, 0, 1, 0, 1)

--	self.GraphDam = Nx.Graph:Create (self.W, 50, self.Frm)
--	self.GraphDam.MainFrm:SetPoint ("TOPLEFT", 1, -62)

end

--------

function Nx.Combat:OnEvent (event, ...)

	local arg1, arg2, arg3 = select (1, ...)

	local Combat = Nx.Combat
	local UEvents = Nx.UEvents
	local prtD = Nx.prtD

--	Nx.prt ("C> %s (%s, %s)", event, arg1 or "nil", arg2 or "nil")

	if event == "COMBAT_LOG_EVENT_UNFILTERED" then

		local OBJ_AFFILIATION_MINE = 1
		local OBJ_TYPE_PET			= 0x00001000
		local OBJ_TYPE_GUARDIAN		= 0x00002000

		local time, cEvent, _hideCaster, sId, sName, sFlags, sf2, dId, dName, dFlags, df2, a1, a2, a3, a4 = select (1, ...)

--		local plName = UnitName ("player")

		local pre, mid, post = strsplit ("_", cEvent)
		if not post then
			post = mid
		end

		if bit.band (sFlags, OBJ_AFFILIATION_MINE) > 0 then

--			Nx.prt ("Combat: %s (%s %x) (%s %x): %s %s %s %s", cEvent, sName or "", sFlags, dName or "", dFlags,
--					a1 or "nil", a2 or "nil", a3 or "nil", a4 or "nil")

			local spellId, spellName, spellSchool
			local i = 12

			if pre ~= "SWING" then
				spellId, spellName, spellSchool = select (12, ...)
				i = 15
			end

			local amount, school, resist, block, absorb, crit = select (i, ...)

			if post == "DAMAGE" then

				local v = amount

				local hitStr = crit and L["|cffff00ffcrit"] or L["hit"]

				if spellName then
					hitStr = spellName
					if mid == "PERIODIC" then
						hitStr = spellName .. L[" dot"]
					end
					if crit then
						hitStr = hitStr .. L[" |cffff00ffcrit"]
					end
				end
				local s = format ("|cff00ff00%s|r %s |cffff0000'%s'|r %d", sName or "?", hitStr, dName, amount)

				if bit.band (sFlags, OBJ_TYPE_PET + OBJ_TYPE_GUARDIAN) > 0 then
					if pre == "SPELL" then
						if crit then
							Combat:SetLine (v, "e0a000", s)
						else
							Combat:SetLine (v, "906000", s)
						end
					else
						if crit then
							Combat:SetLine (v, "e0a0a0", s)
						else
							Combat:SetLine (v, "806060", s)
						end
					end
				else
					if pre == "SPELL" then
						if crit then
							Combat:SetLine (v, "e0e000", s)
						else
							Combat:SetLine (v, "909000", s)
						end
					else
						if crit then
							Combat:SetLine (v, "e0e0e0", s)
						else
							Combat:SetLine (v, "808080", s)
						end
					end
				end

			elseif cEvent == "PARTY_KILL" then

				Combat:SetLine (-1, "e02020", L["Killed "] .. dName)
				UEvents:AddKill (dName)
			end

		elseif bit.band (dFlags, OBJ_AFFILIATION_MINE) > 0 then

			if post == "DAMAGE" and sName then
				Combat.AttackerName = sName
--				Nx.prt ("Atker %s", sName)
			end
		end
--[[
	elseif event == "CHAT_MSG_SPELL_PERIODIC_CREATURE_DAMAGE" or event == "CHAT_MSG_SPELL_PERIODIC_HOSTILEPLAYER_DAMAGE" then
		prtD ("Periodic Dam: " .. arg1)

		local s1, s2, d = string.find (arg1, " suffers (%d+) %a+ damage from your")
		if s1 then
			local v = tonumber (d)
			prtD ("=" .. v)
			Combat:SetLine (v, "900090", arg1)
		end

	elseif event == "CHAT_MSG_SPELL_DAMAGESHIELDS_ON_SELF" then
		prtD ("Damshield: " .. arg1)

		local s1, s2, d = string.find (arg1, "You reflect (%d+)")
		if s1 then
			local v = tonumber (d)
			prtD ("=" .. v)
			Combat:SetLine (v, "009090", arg1)
		end
--]]

	elseif event == "CHAT_MSG_COMBAT_XP_GAIN" then
--		prtD ("XPGain " .. arg1)

		local s1, s2, name = strfind (arg1, "gain (%d+) ex")
		if s1 then
--			prtD ("="..name)
			Combat:SetLine (-1, "20e020", arg1)

			UEvents:AddInfo ("+"..name..L[" xp"])
		end

	elseif event == "CHAT_MSG_COMBAT_HONOR_GAIN" then

--		Nx.prt ("HonorGain %s, %s, %s", arg1, arg2 or "nil", arg3 or "nil")
--[[
		local s1, s2, name = strfind (arg1, "Points: (%d+)")
		if s1 then
			UEvents:AddHonor ("+"..name.." honor")
			return
		end
--]]
		local s1, s2, val = strfind (arg1, "(%d*%.%d+) %aonor")	--V4
		if s1 then
			UEvents:AddHonor ("+".. val ..L[" honor"])
			return
		end

		local s1, s2, name = strfind (arg1, "(%d+) %aonor")
		if s1 and name ~= "0" then
			UEvents:AddHonor ("+"..name..L[" honor"])
		end

	elseif event == "CHAT_MSG_LOOT" then

		-- "You receive currency: Honor Points."
		-- "You receive currency: Honor Points x3."
		-- "You receive currency: Honor Points x45."

--		Nx.prt ("Loot %s, %s, %s", arg1 or "nil", arg2 or "nil", arg3 or "nil")

		local s1, s2 = strfind (arg1, "Honor Points%.")	--V4
		if s1 then
			UEvents:AddHonor (L["+1 honor"])
			return
		end

		local s1, s2, val = strfind (arg1, "Honor Points x(%d+)")	--V4
		if s1 then
			UEvents:AddHonor ("+" .. val .. L[" honor"])
			return
		end

--	elseif event == "CHAT_MSG_MONEY" then
--		Nx.prt ("Money %s, %s, %s", arg1 or "nil", arg2 or "nil", arg3 or "nil")

--	elseif event == "CHAT_MSG_COMBAT_MISC_INFO" then
--		Nx.prt ("CombatMisc %s, %s, %s", arg1 or "nil", arg2 or "nil", arg3 or "nil")

	elseif event == "PLAYER_REGEN_DISABLED" then
		Combat:EnterCombat()

	elseif event == "PLAYER_REGEN_ENABLED" then
		Combat.InCombat = false

	elseif event == "PLAYER_DEAD" then
		UEvents:AddDeath (Combat.AttackerName)

	else

--		Nx.prt ("C> %s (%s)", event, arg1 or "nil")

		if Combat.EventTable[event] then
			Combat.EventTable[event] (Combat, arg1)
		end

	end
end

--[[
function Nx.Combat:OnEventRecvDamage (event, arg1)

	local s1, s2, name = string.find (arg1, "(.+) hits")
	if s1 then
		self.AttackerName = name
	end

	local s1, s2, name = string.find (arg1, "(.+) crits")
	if s1 then
		self.AttackerName = name
	end

	local s1, s2, name = string.find (arg1, "(.+)'s")
	if s1 then
		self.AttackerName = name
	end
end
--]]

function Nx.Combat:OnUpdate (...)

--	local v = math.random (100)
--	Combat:SetLine (v, "808080", "Test")
end

function Nx.Combat:OnEnter (motion)
--	prtD ("Combat Enter "..tostring (motion))
end

--------
-- Start combat

function Nx.Combat:EnterCombat (value)

	if not self.InCombat then
		self.InCombat = true
		self.HitPeak = 10
		self.HitTotal = 0
		self.TimeStart = GetTime()

		self.GraphHits:Clear()
		self.GraphHits:SetPeak (self.HitPeak)
	end
end

--------
-- Set a new graph line to value

function Nx.Combat:SetLine (value, colorStr, infoStr)

	self:EnterCombat()

	if value > self.HitPeak then
		self.HitPeak = value
		self.GraphHits:SetPeak (self.HitPeak)
	end

	self.HitTotal = self.HitTotal + value

	if value > self.HitBest then
		self.HitBest = value
	end

	local time = GetTime() - self.TimeStart + .001		-- Dont allow zero

	self.GraphHits:SetLine (time, value, colorStr, infoStr)

	local txt = string.format (L["Hit %3.0f Peak "]..self.HitPeak..L[" Best "]..self.HitBest..L[" Total %.0f Time %.2f DPS %.1f"], value, self.HitTotal, time, self.HitTotal / time)
	self.Win:SetTitle (txt)
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- User events recording and list

function Nx.UEvents:Init()

--	self.Sorted = {}
end

------
-- Add info to list

function Nx.UEvents:AddInfo (name)

	local mapId, x, y = self:GetPlyrPos()

	Nx:AddInfoEvent (name, Nx:Time(), mapId, x, y)

	self:UpdateAll()

	return mapId
end

------
-- Add player death to list

function Nx.UEvents:AddDeath (name)

	local mapId, x, y = self:GetPlyrPos()

	Nx:AddDeathEvent (name, Nx:Time(), mapId, x, y)

	self:UpdateAll()

--	Nx:SendComm (2, "Death "..name)

	if Nx.Map:IsBattleGroundMap (mapId) then
--		Nx.prt ("Req D")
		RequestBattlefieldScoreData()
	end
end

------
-- Add kill to list

function Nx.UEvents:AddKill (name)

	local mapId, x, y = self:GetPlyrPos()

	Nx:AddKillEvent (name, Nx:Time(), mapId, x, y)

	self:UpdateAll()

--	Nx:SendComm (2, "Killed "..name)
end

------
-- Add honor info to list

function Nx.UEvents:AddHonor (name)

	local mapId = self:AddInfo (name)

	if Nx.Map:IsBattleGroundMap (mapId) then
--		Nx.prt ("Req H")
		RequestBattlefieldScoreData()
	end
end

------
-- Add herb to list

function Nx.UEvents:AddHerb (name)

	local mapId, x, y = self:GetPlyrPos()

	local id = Nx:HerbNameToId (name)
	if id then

		Nx:AddHerbEvent (name, Nx:Time(), mapId, x, y)
		Nx:GatherHerb (id, mapId, x, y)
	end

	self:UpdateAll (true)
end

------
-- Add mine to list

function Nx.UEvents:AddMine (name)

	local mapId, x, y = self:GetPlyrPos()

	local id = Nx:MineNameToId (name)
	if id then

		Nx:AddMineEvent (name, Nx:Time(), mapId, x, y)
		Nx:GatherMine (id, mapId, x, y)
	end

	self:UpdateAll (true)
end

------
-- Add open to list

function Nx.UEvents:AddOpen (typ, name)

	local mapId = self:AddInfo (name)

	local mapId, x, y = self:GetPlyrPos()

	Nx:Gather ("Misc", typ, mapId, x, y)

	self:UpdateAll()
end

--------
-- Get player map pos

function Nx.UEvents:GetPlyrPos()

	local mapId = Nx.Map:GetRealMapId()
	local map = Nx.Map:GetMap (1)
	return mapId, map.PlyrRZX, map.PlyrRZY
end

--------

function Nx.UEvents:UpdateAll (upGuide)

	self:Sort()
	self:UpdateMap (upGuide)
	self.List:Update()
end

--------
-- Sort compare

function Nx.UEvents.SortCmp (v1, v2)

--	prtD ("Sort "..v1.Time.." "..v2.Time)

	local _, tm1 = strsplit ("^", v1)
	local _, tm2 = strsplit ("^", v2)

	return tonumber (tm1) < tonumber (tm2)
end

--------

function Nx.UEvents:Sort()

--	wipe (self.Sorted)

--	Nx:AddAllEvents (self.Sorted)

--	sort (self.Sorted, self.SortCmp)

	sort (Nx.CurCharacter.E, self.SortCmp)		-- Should already be sorted, but whatever
end

--------
-- Open and init or toggle user events list

function Nx.UEvents.List:Open()

	local UEvents = Nx.UEvents

	local win = self.Win

	if win then
		if win:IsShown() then
			win:Show (false)
		else
			win:Show()
		end
		return
	end

	-- Create Window

	local win = Nx.Window:Create ("NxEventsList", nil, nil, nil, nil, nil, true)
	self.Win = win

	win:CreateButtons (true)

	win:InitLayoutData (nil, -.75, -.6, -.25, -.1)

	local list = Nx.List:Create (L["Events"], 2, -2, 100, 12 * 3, win.Frm)
	self.List = list
	list:ColumnAdd (L["Time"], 1, 70)
	list:ColumnAdd (L["Event"], 2, 140)
	list:ColumnAdd ("#", 3, 30, "CENTER")
	list:ColumnAdd (L["Position"], 4, 500)

	win:Attach (list.Frm, 0, 1, 0, 1)

	UEvents:UpdateAll()
end

------
function Nx.UEvents.List:Update()

	local Nx = Nx
	local UEvents = Nx.UEvents

	if not self.Win then
		return
	end

	local sorted = Nx.CurCharacter.E

	self.Win:SetTitle (format (L["Events: %d"], #sorted))

	local list = self.List
	local isLast = list:IsShowLast()
	list:Empty()

	for k, item in ipairs (sorted) do

		local typ, tm, mapId, x, y, text, data = Nx:UnpackEvent (item)

		list:ItemAdd()
		list:ItemSet (1, date ("%d %H:%M:%S", tm / 100))

		local eStr = text

		if typ == "D" then

			eStr = L["|cffff6060Died! "] .. text

		elseif typ == "K" then

			list:ItemSet (3, data)

			eStr = L["|cffff60ffKilled "] .. text

		elseif typ == "H" then

			eStr = L["|cff60ff60Picked "] .. text

		elseif typ == "M" then

			eStr = L["|cffc0c0c0Mined "] .. text

		end

		list:ItemSet (2, eStr)

		local mapName = Nx.Map:IdToName (mapId)

		local str = format ("%s %.0f %.0f", mapName, x, y)
		list:ItemSet (4, str)
	end

	list:Update (isLast)
end

------
-- Update user event data on map

function Nx.UEvents:UpdateMap (upGuide)

--	Nx.prt ("UEvents:UpdateMap")

	local Nx = Nx
	local Map = Nx.Map

	local mapId = Map:GetCurrentMapId()
	local m = Map:GetMap (1)

	if m then

		if upGuide then
			m.Guide:Update()
		end

		m:InitIconType ("Kill", nil, "Interface\\TargetingFrame\\UI-TargetingFrame-Skull", 16, 16)
		m:InitIconType ("Death", nil, "Interface\\TargetingFrame\\UI-TargetingFrame-Seal", 16, 16)

		local icon

		for k, item in ipairs (Nx.CurCharacter.E) do

			local iMapId = Nx:GetEventMapId (item)

			if iMapId == mapId then

				local typ, _, _, x, y, text = Nx:UnpackEvent (item)

				if typ == "K" then
					icon = m:AddIconPt ("Kill", x, y)
					m:SetIconTip (icon, text)

				elseif typ == "D" then
					icon = m:AddIconPt ("Death", x, y)
					m:SetIconTip (icon, text)
				end
			end
		end

	end
end

-------------------------------------------------------------------------------

Nx.GatherInfo = {
	[" "] = {	-- Misc
		["Art"] = { 0, "Trade_Archaeology",					"Artifact", "Artifact", "Artifact", "Artifact"	},
		["Everfrost"] = { 0, "spell_shadow_teleport",			NXlEverfrost, NXlEverfrost, NXlEverfrost, NXlEverfrost	},
		["Gas"] = { 0, "inv_gizmo_zapthrottlegascollector",	NXlGas, NXlGas, NXlGas, NXlGas	},
	},
	["H"] = {	-- Herbs
		{ 340, "INV_Misc_Herb_AncientLichen",		"Ancient Lichen",			"Urflechte",								"Lichen ancien",					"Liquen antiguo" },
		{ 220, "INV_Misc_Herb_13",						"Arthas' Tears",			"Arthas\226\128\153 Tr\195\164nen",	"Larmes d'Arthas ",				"L\195\161grimas de Arthas" },
		{ 300, "INV_Misc_Herb_17",						"Black Lotus",				"Schwarzer Lotus",						"Lotus noir",						"Loto negro" },
		{ 235, "INV_Misc_Herb_14",						"Blindweed",				"Blindkraut",								"Aveuglette",						"Carolina" },
		{ 1,   "INV_Misc_Herb_11a",					"Bloodthistle",			"Blutdistel",								"Chardon sanglant",				"Cardo de sangre" },
		{ 70,	 "INV_Misc_Root_01",						"Briarthorn",				"Wilddornrose",							"Eglantine",						"Brezospina" },
		{ 100, "INV_Misc_Herb_01",						"Bruiseweed",				"Beulengras",								"Doulourante",						"Hierba cardenal" },
		{ 270, "INV_Misc_Herb_DreamFoil",			"Dreamfoil",				"Traumblatt",								"Feuiller\195\170ve",			"Hojasue\195\177o" },
		{ 315, "INV_Misc_Herb_Dreamingglory",		"Dreaming Glory",			"Traumwinde",								"Glaurier",							"Gloria de ensue\195\177o" },
		{ 15,	 "INV_Misc_Herb_07",						"Earthroot",				"Erdwurzel",								"Terrestrine",						"Ra\195\173z de tierra" },
		{ 160, "INV_Misc_Herb_12",						"Fadeleaf",					"Blassblatt",								"P\195\162lerette",				"P\195\161lida" },
		{ 300, "INV_Misc_Herb_Felweed",				"Felweed",					"Teufelsgras",								"Gangrelette",						"Hierba vil" },
		{ 205, "INV_Misc_Herb_19",						"Firebloom",				"Feuerbl\195\188te",						"Fleur de feu",					"Flor de Fuego" },
		{ 335, "INV_Misc_Herb_Flamecap",				"Flame Cap",				"Flammenkappe",							"Chapeflamme",						"Copo de llamas" },
		{ 245, "INV_Mushroom_08",						"Ghost Mushroom",			"Geisterpilz",								"Champignon fant\195\180me",	"Champi\195\177\195\179n fantasma" },
		{ 260, "INV_Misc_Herb_SansamRoot",			"Golden Sansam",			"Goldener Sansam",						"Sansam dor\195\169",			"Sansam dorado" },
		{ 170, "INV_Misc_Herb_15",						"Goldthorn",				"Golddorn",									"Dor\195\169pine",				"Espina de oro" },
		{ 120, "INV_Misc_Dust_02",						"Grave Moss",				"Grabmoos",									"Tombeline",						"Musgo de tumba" },
		{ 250, "INV_Misc_Herb_16",						"Gromsblood",				"Gromsblut",								"Gromsang",							"Gromsanguina" },
		{ 290, "INV_Misc_Herb_IceCap",				"Icecap",					"Eiskappe",									"Chapeglace",						"Setelo" },
		{ 185, "INV_Misc_Herb_08",						"Khadgar's Whisker",		"Khadgars Schnurrbart",					"Moustache de Khadgar",			"Mostacho de Khadgar" },
		{ 125, "INV_Misc_Herb_03",						"Kingsblood",				"K\195\182nigsblut",						"Sang-royal",						"Sangrerregia" },
		{ 150, "INV_Misc_Root_02",						"Liferoot",					"Lebenswurz",								"Viet\195\169rule",				"Vidarra\195\173z" },
		{ 50,  "Spell_Shadow_DeathAndDecay",		"Mageroyal",				"Magusk\195\182nigskraut",				"Mage royal",						"Marregal" },
		{ 375, "INV_Misc_Herb_Manathistle",			"Mana Thistle",			"Manadistel",								"Chardon de mana",				"Cardo de man\195\161" },
		{ 280, "INV_Misc_Herb_MountainSilverSage","Mountain Silversage",	"Bergsilbersalbei",						"Sauge-argent des montagnes",	"Salviargenta de monta\195\177a" },
		{ 350, "INV_Misc_Herb_Netherbloom",			"Netherbloom",				"Netherbl\195\188te",					"N\195\169antine",				"Flor abisal" },
		{ 350, "INV_Enchant_DustSoul",				"Netherdust Bush",		"Netherstaubbusch",						"Buisson de pruin\195\169ante","Arbusto de polvo abisal" },
		{ 365, "INV_Misc_Herb_Nightmarevine",		"Nightmare Vine",			"Alptraumranke",							"Cauchemardelle",					"Vid Pesadilla" },
		{ 1,   "INV_Misc_Flower_02",					"Peacebloom",				"Friedensblume",							"Pacifique",						"Flor de paz" },
-- Sorrowmoss replaced Plaguebloom
		{ 285, "inv_misc_herb_plaguebloom",			"Sorrowmoss",				"Trauermoos",								"Chagrinelle",						"Musgopena" },
		{ 210, "INV_Misc_Herb_17",						"Purple Lotus",			"Lila Lotus",								"Lotus pourpre",					"Loto c\195\161rdeno" },
		{ 325, "INV_Misc_Herb_Ragveil",				"Ragveil",					"Zottelkappe",								"Voile-mis\195\168re",			"Velada" },
		{ 1,   "INV_Misc_Herb_10",						"Silverleaf",				"Silberblatt",								"Feuillargent",					"Hojaplata" },
		{ 85,  "INV_Misc_Herb_11",						"Stranglekelp",			"W\195\188rgetang",						"Etouffante",						"Alga estranguladora" },
		{ 230, "INV_Misc_Herb_18",						"Sungrass",					"Sonnengras",								"Soleillette",						"Solea" },
		{ 325, "INV_Misc_Herb_Terrocone",			"Terocone",					"Terozapfen",								"Teroc\195\180ne",				"Teropi\195\177a" },
		{ 115, "INV_Misc_Flower_01",					"Wild Steelbloom",		"Wildstahlblume",							"Aci\195\169rite sauvage",		"Ac\195\169rita salvaje" },
-- Dragon's Teeth replaced Wintersbite
		{ 195, "inv_misc_flower_03",					"Dragon's Teeth",			"Drachenzahn",								"Dents de dragon",				"Dientes de drag\195\179n" },
		{ 1,   "INV_Mushroom_02",						"Glowcap",					"Gl\195\188hkappe",						"Chapeluisant",					"Fluochampi\195\177\195\179n" },
		{ 350, "inv_misc_herb_goldclover",			"Goldclover",				"Goldklee",									"Tr\195\168fle dor\195\169",	"Tr\195\169bol de oro" },
		{ 385, "inv_misc_herb_talandrasrose",		"Talandra's Rose",		"Talandras Rose",							"Rose de Talandra",				"Rosa de Talandra" },
		{ 400, "inv_misc_herb_evergreenmoss",		"Adder's Tongue",			"Schlangenzunge",							"Verp\195\169renne",				"Lengua de v\195\173boris" },
		{ 400, "inv_misc_herb_goldclover",			"Frozen Herb",				"Gefrorenes Kraut",						"Herbe gel\195\169e",			"Hierba de escarcha" },
		{ 400, "inv_misc_herb_tigerlily",			"Tiger Lily",				"Tigerlilie",								"Lys tigr\195\169",				"Lirio atigrado" },
		{ 425, "inv_misc_herb_whispervine",			"Lichbloom",				"Lichbl\195\188te",						"Fleur-de-liche",					"Flor ex\195\161nime" },
		{ 435, "inv_misc_herb_icethorn",				"Icethorn",					"Eisdorn",									"Glac\195\169pine",				"Espina de hielo" },
		{ 450, "inv_misc_herb_frostlotus",			"Frost Lotus",				"Frostlotus",								"Lotus givr\195\169",			"Loto de escarcha" },
		{ 360, "inv_misc_herb_11a",					"Firethorn",				"Feuerdorn",								"Epine de feu",					"Espino de fuego" },
-- Cataclysm
		{ 425, "inv_misc_herb_azsharasveil",		"Azshara's Veil",			"Azsharas Schleier",						"Voile d'Azshara",				"Velo de Azshara" },
		{ 425, "inv_misc_herb_cinderbloom",			"Cinderbloom",				"Aschenbl\195\188te",					"Cendrelle",						"Flor de ceniza" },
		{ 425, "inv_misc_herb_stormvine",			"Stormvine",				"Sturmwinde",								"Vign\195\169tincelle",			"Vi\195\177\aviento" },
		{ 475, "inv_misc_herb_heartblossom",		"Heartblossom",			"Herzbl\195\188te",						"P\195\169tale de c\195\166ur", "Flor de coraz\195\179n" },
		{ 500, "inv_misc_herb_whiptail",				"Whiptail",					"Gertenrohr",								"Fouettine",						"Col\195\161tigo" },
		{ 525, "inv_misc_herb_twilightjasmine",	"Twilight Jasmine",		"Schattenjasmin",							"Jasmin cr\195\169pusculaire","Jazm\195\173n Crepuscular" },
-- Pandaria
	    { 600, "inv_misc_herb_foolscap", "Fool's Cap","Narrenkappe","Berluette","Flor del inocente"},
		{ 550, "inv_misc_herb_goldenlotus","Golden Lotus","Goldlotus","Lotus dor�","Loto dorado"},
		{ 500, "inv_misc_herb_jadetealeaf","Green Tea Leaf","Teepflanze","Feuille de th� vert","Hoja de t� verde"},
		{ 525, "inv_misc_herb_rainpoppy","Rain Poppy","Regenmohn","Pavot de pluie","Amapola de lluvia"},
		{ 575, "inv_misc_herb_shaherb","Sha-Touched Herb","Sha-ber�hrtes Kraut","Plante touch�e par les sha","Hierba influenciada por el sha"},
		{ 545, "inv_misc_herb_silkweed","Silkweed","Seidenkraut","Herbe � soie","Hierba sedosa"},
		{ 575, "inv_misc_herb_snowlily","Snow Lily","Schneelilie","Lys des neiges","Lirio de las nieves"},		
	},
	["M"] = {	-- Mine node
		{ 325,	"INV_Ore_Adamantium",		"Adamantite Deposit",		"Adamantitvorkommen",			"Gisement d'adamantite",			"Dep\195\179sito de adamantita" },
		{ 375,	"INV_Misc_Gem_01",			"Ancient Gem Vein",			"Uralte Edelsteinader",			"Ancien filon de gemmes",			"Fil\195\179n de gemas antiguo" },
		{ 1,		"INV_Ore_Copper_01",			"Copper Vein",					"Kupferader",						"Filon de cuivre",					"Fil\195\179n de cobre" },
		{ 230,	"INV_Ore_Mithril_01",		"Dark Iron Deposit",			"Dunkeleisenvorkommen",			"Gisement de sombrefer",			"Dep\195\179sito de hierro negro" },
		{ 275,	"INV_Ore_FelIron",			"Fel Iron Deposit",			"Teufelseisenvorkommen",		"Gisement de gangrefer",			"Dep\195\179sito de hierro vil" },
		{ 155,	"INV_Ore_Copper_01",			"Gold Vein",					"Goldader",							"Filon d'or",							"Fil\195\179n de oro" },
		{ 65,		"INV_Ore_Thorium_01",		"Incendicite Mineral Vein","Pyrophormineralvorkommen",	"Filon d'incendicite",				"Fil\195\179n de incendicita" },
		{ 150,	"INV_Ore_Mithril_01",		"Indurium Mineral Vein",	"Induriummineralvorkommen",	"Filon d'indurium",					"Fil\195\179n de indurio" },
		{ 125,	"INV_Ore_Iron_01",			"Iron Deposit",				"Eisenvorkommen",					"Gisement de fer",					"Dep\195\179sito de hierro" },
		{ 375,	"INV_Ore_Khorium",			"Khorium Vein",				"Khoriumader",						"Filon de khorium",					"Fil\195\179n de korio" },
		{ 305,	"INV_Stone_15",				"Large Obsidian Chunk",		"Gro\195\159er Obsidianbrocken", "Grand morceau d'obsidienne", "Trozo de obsidiana grande" },
		{ 75,		"INV_Ore_Thorium_01",		"Lesser Bloodstone Deposit", "Geringes Blutsteinvorkommen", "Gisement de pierre de sang inf\195\169rieure", "Dep\195\179sito de sangrita inferior" },
		{ 175,	"INV_Ore_Mithril_02",		"Mithril Deposit",			"Mithrilvorkommen",				"Gisement de mithril",				"Dep\195\179sito de mitril" },
		{ 275,	"INV_Ore_Ethernium_01",		"Nethercite Deposit",		"Netheritvorkommen",				"Gisement de n\195\169anticite", "Dep\195\179sito de abisalita" },
		{ 350,	"INV_Ore_Adamantium",		"Rich Adamantite Deposit",	"Reiches Adamantitvorkommen",	"Riche gisement d'adamantite",	"Dep\195\179sito rico en adamantita" },
		{ 255,	"INV_Ore_Thorium_02",		"Rich Thorium Vein",			"Reiche Thoriumader",			"Riche filon de thorium",			"Fil\195\179n de torio enriquecido" },
		{ 75,		"INV_Stone_16",				"Silver Vein",					"Silberader",						"Filon d'argent",						"Fil\195\179n de plata" },
		{ 305,	"INV_Misc_StoneTablet_01",	"Small Obsidian Chunk",		"Kleiner Obsidianbrocken",		"Petit morceau d'obsidienne",		"Trozo de obsidiana peque\195\177o" },
		{ 230,	"INV_Ore_Thorium_02",		"Small Thorium Vein",		"Kleine Thoriumader",			"Petit filon de thorium",			"Fil\195\179n peque\195\177o de torio" },
		{ 65,		"INV_Ore_Tin_01",				"Tin Vein",						"Zinnader",							"Filon d'\195\169tain",				"Fil\195\179n de esta\195\177o" },
		{ 230,	"INV_Ore_TrueSilver_01",	"Truesilver Deposit",		"Echtsilbervorkommen",			"Gisement de vrai-argent",			"Dep\195\179sito de veraplata" },
		{ 350,	"inv_ore_cobalt",				"Cobalt Deposit",				"Kobaltvorkommen",				"Gisement de cobalt",				"Dep\195\179sito de cobalto" },
		{ 375,	"inv_ore_cobalt",				"Rich Cobalt Deposit",		"Reiches Kobaltvorkommen",		"Riche gisement de cobalt",		"Dep\195\179sito de cobalto rico" },
		{ 400,	"inv_ore_saronite_01",		"Saronite Deposit",			"Saronitvorkommen",				"Gisement de saronite",				"Dep\195\179sito de saronita" },
		{ 425,	"inv_ore_saronite_01",		"Rich Saronite Deposit",	"Reiches Saronitvorkommen",	"Riche gisement de saronite",		"Dep\195\179sito de saronita rico" },
		{ 450,	"inv_ore_platinum_01",		"Titanium Vein",				"Titanader",						"Veine de titane",					"Fil\195\179n de titanio" },

-- Cataclysm
		{ 425,	"item_elementiumore",		"Obsidium Deposit",			"Obsidiumvorkommen",				"Morceau d'obsidium",						"Dep\195\179sito de obsidium" },
		{ 450,	"item_elementiumore",		"Rich Obsidium Deposit",	"Reiches Obsidiumvorkommen",	"Enorme bloc d'obsidienne",				"Dep\195\179sito de obsidium rico" },
		{ 475,	"item_pyriumore",				"Elementium Vein",			"Elementiumader",					"Filon d\195\169l\195\169mentium",		"Fil\195\179n de elementium" },
		{ 500,	"item_pyriumore",				"Rich Elementium Vein",		"Reiche Elementiumader",		"Riche filon d'\195\169l\195\169mentium", "Fil\195\179n de elementium rico" },
		{ 525,	"inv_ore_arcanite_01",		"Pyrite Deposit",				"Pyritvorkommen",					"Gisement de pyrite",						"Dep\195\179sito de pirita" },
		{ 525,	"inv_ore_arcanite_01",		"Rich Pyrite Deposit",		"Reiches Pyritvorkommen",		"Riche gisement de pyrite",				"Dep\195\179sito de pirita rico" },
-- Pandaria
        { 515, "inv_ore_ghostiron","Ghost Iron Deposit","Geistereisenvorkommen","Gisement d�ectofer","Dep�sito de hierro fantasma"},
		{ 550, "inv_ore_ghostiron","Rich Ghost Iron Deposit","Reiches Geistereisenvorkommen","Riche gisement d�ectofer","Dep�sito de hierro fantasma rico"},
		{ 550, "inv_ore_manticyte","Kyparite Deposit","Kyparitvorkommen","Gisement de kyparite","Dep�sito de kyparita"},
		{ 575, "inv_ore_manticyte","Rich Kyparite Deposit","Reiches Kyparitvorkommen","Riche gisement de kyparite","Dep�sito de kyparita rico"},
		{ 600, "inv_ore_trilliumwhite","Trillium Vein","Trilliumader","Filon de trillium","Fil�n de trillium"},
		{ 600, "INV_Ore_TrilliumWhite","Rich Trillium Vein","Reiche Trilliumader","Riche filon de trillium","Fil�n de trillium enriquecido"},
	}	
}

Nx.GatherRemap = {
	["NXHerb"] = {
		[47] = 46,		-- Icethorn
	},
	["NXMine"] = {
		[6] = 9,		-- Gold
		[17] = 20,	-- Silver
		[23] = 22,	-- Rich Cobalt Deposit
		[25] = 24,	-- Rich Saronite Deposit
		[26] = 24,	-- Titanium
	}
}

--------
-- Init. Call after map init

function Nx:GatherInit()

	self.GatherLocaleI = 3

	if Nx.Locale == "deDE" then
		self.GatherLocaleI = 4

	elseif Nx.Locale == "frFR" then
		self.GatherLocaleI = 5

	elseif Nx.Locale == "esES" or Nx.Locale == "esMX" then
		self.GatherLocaleI = 6
	end

	if self.DoGatherUpgrade then
		self.DoGatherUpgrade = nil
		Nx:GatherVerUpgrade()
	end

	Nx.GatherVerUpgrade = nil			-- Kill it
	Nx.GatherVerUpgradeType = nil		-- Kill it
end

function Nx:GetGather (typ, id)

	local v = Nx.GatherInfo[typ][id]

	if v then
		return v[self.GatherLocaleI], v[2], v[1]
	end
end

function Nx:HerbNameToId (name)

	local i = self.GatherLocaleI

	for k, v in ipairs (Nx.GatherInfo["H"]) do
		if v[i] == name then
			return k
		end
	end

	if NxData.NXDBGather then
		Nx.prt (L["Unknown herb %s"], name)
	end
end

function Nx:MineNameToId (name)

	if Nx.Locale == "deDE" then

		name = gsub (name, "Br\195\188hschlammbedecktes ", "")

		if name == "reiches Thoriumvorkommen" then	-- Created when Ooze Covered removed
			name = "Reiches Thoriumvorkommen"
		end

		if name == "Thoriumvorkommen" then				-- Created when Ooze Covered removed
			name = "Kleines Thoriumvorkommen"
		end

	elseif Nx.Locale == "frFR" then

		name = gsub (name, " couvert de limon", "")		-- Ooze Covered
		name = gsub (name, " couvert de vase", "")		-- Ooze Covered

		if name == "Filon de thorium" then					-- Created when Ooze Covered removed
			name = "Petit filon de thorium"
		end

	elseif Nx.Locale == "esES" or Nx.Locale == "esMX" then

		name = gsub (name, " cubierto de moco", "")		-- Ooze Covered
		name = gsub (name, " cubierta de moco", "")		-- Ooze Covered

		if name == "Fil\195\179n de torio" then			-- Created when Ooze Covered removed
			name = "Fil\195\179n peque\195\177o de torio"
		end

	else
--		name = gsub (name, "Hakkari", "Rich")		-- Hakkari Thorium Vein
		name = gsub (name, "Ooze Covered ", "")
		if name == "Thorium Vein" then				-- Created when Ooze Covered removed
			name = "Small Thorium Vein"
		end
	end

	local i = self.GatherLocaleI

	for k, v in ipairs (Nx.GatherInfo["M"]) do
		if v[i] == name then
			return k
		end
	end

	if NxData.NXDBGather then
		Nx.prt (L["Unknown ore %s"], name)
	end
end

--------
-- Upgrade gather data

function Nx:GatherVerUpgrade()

	Nx:GatherVerUpgradeType ("NXHerb")
	Nx:GatherVerUpgradeType ("NXMine")
end

function Nx:GatherVerUpgradeType (tName)

--[[
	local oldType = NxData.NXGather[tName]
	local newType = {}
	NxData.NXGather[tName] = newType

	for mapId, oldZone in pairs (oldType) do

		local zoneT = {}
		newType[mapId] = zoneT

		for _, node in ipairs (oldZone) do

			local x, y = Nx.Map:GetZonePos (mapId, node.NXX, node.NXY)		-- Needs map init
			if (x > 0 or y > 0) and x <= 100 and y <= 100 then

				local nodeT = zoneT[node.NXId] or {}
				zoneT[node.NXId] = nodeT

				local s = format ("%s^%d", Nx:PackXY (x, y), node.NXCnt)
				tinsert (nodeT, s)

--				Nx.prt ("%s %s %s", mapId, x, y)
--				Nx.prt (" %s", s)
--				Nx.prt (" %s %s", tonumber (strsub (s, 1, 3), 16) / 40.9, tonumber (strsub (s, 4, 6), 16) / 40.9)
			end
		end
	end
--]]
end

--------
-- Save location of gathered herb
-- xy is zone coords

function Nx:GatherHerb (id, mapId, x, y)
	self:Gather ("NXHerb", id, mapId, x, y)
end

--------
-- Save location of gathered mining
-- xy is zone coords

function Nx:GatherMine (id, mapId, x, y)
	self:Gather ("NXMine", id, mapId, x, y)
end

--------
-- Add gathered item. xy zone coords 0-100

function Nx:Gather (nodeType, id, mapId, x, y)

	local remap = self.GatherRemap[nodeType]
	if remap then
		id = remap[id] or id
	end

	local data = NxData.NXGather[nodeType]

	local zoneT = data[mapId]
	if not zoneT then

--		Nx.prt ("Gather new %d", mapId)

		zoneT = {}
		data[mapId] = zoneT
	end

	local maxDist = (5 / Nx.Map:GetWorldZoneScale (mapId)) ^ 2

	local index
	local nodeT = zoneT[id] or {}
	zoneT[id] = nodeT

	for n, node in ipairs (nodeT) do

		local nx = tonumber (strsub (node, 1, 3), 16) / 40.9
		local ny = tonumber (strsub (node, 4, 6), 16) / 40.9
		local dist = (nx - x) ^ 2 + (ny - y) ^ 2

--		Nx.prt ("Gather %f %f %f (%.2f %.2f) (%.2f %.2f)", dist, maxDist, id, nx, ny, x, y)

		if dist < maxDist then		-- Squared compare
			index = n
			break
		end
	end

	local cnt = 1

	if not index then
		index = #nodeT + 1

	else
		local xy, nCnt = strsplit ("^", nodeT[index])
		local nx = tonumber (strsub (xy, 1, 3), 16) / 40.9
		local ny = tonumber (strsub (xy, 4, 6), 16) / 40.9
		cnt = nCnt + 1
		x = (nx * nCnt + x) / cnt
		y = (ny * nCnt + y) / cnt
	end

	nodeT[index] = format ("%s^%d", Nx:PackXY (x, y), cnt)
end

--------

function Nx:GatherUnpack (item)

	local xy = strsplit ("^", item)
	local x = tonumber (strsub (xy, 1, 3), 16) / 40.9
	local y = tonumber (strsub (xy, 4, 6), 16) / 40.9
	return x, y
end

--------

function Nx:GatherDeleteHerb()
	NxData.NXGather.NXHerb = {}
end

function Nx:GatherDeleteMine()
	NxData.NXGather.NXMine = {}
end

function Nx:GatherDeleteMisc()
	NxData.NXGather["Misc"] = {}
end

--------

function Nx:GatherImportCarbHerb()
	Nx:GatherImportCarb ("NXHerb")
end

function Nx:GatherImportCarbMine()
	Nx:GatherImportCarb ("NXMine")
end

function Nx:GatherImportCarbMisc()
	Nx:GatherImportCarb ("Misc")
end

function Nx:GatherImportCarb (nodeType)

	if not LoadAddOn ("CarboniteNodes") then
		Nx.prt (L["CarboniteNodes addon could not be loaded!"])
		return
	end

	if not CarboniteNodes then
		Nx.prt (L["CarboniteNodes addon is not loaded!"])
		return
	end

	local srcT = CarboniteNodes[nodeType]
	if srcT then

		local cnt = 0

		for mapId, zoneT in pairs (srcT) do
			for nodeId, nodeStr in pairs (zoneT) do
				for n = 1, #nodeStr, 6 do

					cnt = cnt + 1

					local nx = tonumber (strsub (nodeStr, n, n + 2), 16) / 40.9
					local ny = tonumber (strsub (nodeStr, n + 3, n + 5), 16) / 40.9

					if nx < .1 or nx > 99.9 or ny < .1 or ny > 99.9 then
--						Nx.prt ("bad node %s %s %s", mapId, nx, ny)
					else
						Nx:Gather (nodeType, nodeId, mapId, nx, ny)
					end

				end
			end
		end

		Nx.prt (L["Imported %s %s"], nodeType, cnt)
	end
end

--------
-- OLD cart import

--[[

function Nx:GatherImportCartHerb()
	Nx:GatherImportCart ("Herbalism")
end

function Nx:GatherImportCartMine()
	Nx:GatherImportCart ("Mining")
end

function Nx:GatherImportCart (typ)

	local notes = Cartographer_Notes
	local data = _G["Cartographer_" .. typ .. "DB"]

	if not data then
		Nx.prt ("Cartographer_%sDB missing", typ)
		return
	end

	if not notes then
		Nx.prt ("Cartographer notes missing")
		return
	end

	local getXY = notes["getXY"]
	if not getXY then
		Nx.prt ("Cartographer getXY missing")
		return
	end

	local nameToId = Nx.HerbNameToId
	local gather = Nx.GatherHerb
	if typ == "Mining" then
		nameToId = Nx.MineNameToId
		gather = Nx.GatherMine
	end

	local importCnt = 0

	for zName, zData in pairs (data) do

		if type (zData) == "table" then

			local mapId = Nx.MapNameToId[zName]
			if not mapId then
				Nx.prt ("Unknown zone %s", zName)

			else

				for id, name in pairs (zData) do

					local nodeId = nameToId (Nx, name)
					if nodeId then
						importCnt = importCnt + 1
						local x, y = getXY (id)
						gather (Nx, nodeId, mapId, x * 100, y * 100)

					else
						Nx.prt ("Import unknown %s", name)
					end
				end
			end
		end
	end

	Nx.prt ("Imported %s nodes", importCnt)
end

--]]

-------------------------------------------------------------------------------
-- Item handling

function Nx.Item:Init()

	self.Needed = {}
	self.Asked = {}
end

function Nx.Item:Load (id)

	if self.Asked[id] then	-- Ask once

--		Nx.prt ("Asked %s", id)

		if time() - self.Asked[id] > 600 then

			local name = GetItemInfo (id)
			if not name then
--				Nx.prt ("Item still missing %s", id)
				return -1	-- Never got item. Probably bad id
			end
		end

		return
	end

	local name, link = GetItemInfo (id)
	if not name then

		if Nx:GetGlobalOpts()["ItemRequest"] then

			if not self.AskedToLoad then
				Nx:ShowMessage (Nx.TXTBLUE..L["Carbonite:\n|cffffff60Data for some items is not available.\nRetrieve data from the server?\n\n|cffff4040May cause a disconnect if an item is not seen on the server yet."], L["Get Data"], self.EnableLoadFromServer, L["Cancel"], self.DisableLoadFromServer)
				self.AskedToLoad = true
			end

			self.Needed[id] = true

--			Nx.prt ("Item:Load %s", id)
		end
	end
end

function Nx.Item.EnableLoadFromServer()

--	Nx.prt ("EnableLoadFromServer")

	local self = Nx.Item

	self.TooltipFrm = CreateFrame ("GameTooltip", "NxTooltipItem", UIParent, "GameTooltipTemplate")
	self.TooltipFrm:SetOwner (UIParent, "ANCHOR_NONE")		-- We won't see with this anchor

	self.ItemsRequested = 0

	Nx.Timer:Start ("Item", 1, self, self.Timer)
end

function Nx.Item.DisableLoadFromServer()

--	Nx.prt ("DisableLoadFromServer")

	local self = Nx.Item
	self.Needed = {}
	self.Load = function() end		-- Nuke function

	Nx.Timer:Start ("AskDeleteVV", 0, self, self.AskDeleteVV)
end

function Nx.Item.AskDeleteVV()

	local function func()
			NxData.NXVendorV = nil
			Nx.Map.Guide:UpdateVisitedVendors()
	end

	Nx:ShowMessage (Nx.TXTBLUE..L["Carbonite:\n|cffffff60Delete visited vendor data?\nThis will stop the attempted retrieval of items on login."], L["Delete"], func, L["Cancel"])
end

function Nx.Item:ShowTooltip (id, compare)

--	Nx.prtVar ("ShowTooltip", id)

	local id = tostring (id)

	id = strsplit ("^", id)

	if not strfind (id, "item:") then
		if strfind (id, "quest:") then
		else
			id = "item:" .. id .. ":0:0:0:0:0:0:0"		-- Without the 7 ":0" Pawn prints an error
		end
	end

	GameTooltip:SetHyperlink (id)

	if compare then
		GameTooltip_ShowCompareItem()
	end
end

function Nx.Item:Timer()

	local id = next (self.Needed)

	if id then

		local tip = self.TooltipFrm

		self.Needed[id] = nil

		local name = GetItemInfo (id)
		if name then
			return .01		-- Already have
		end

--		Nx.prt ("Getting item %s", id)

		self.Asked[id] = time()

		if not strfind (id, "item:") then
			id = "item:" .. id
		end

		tip:SetHyperlink (id)

		self.ItemsRequested = self.ItemsRequested + 1

		if next (self.Needed) then		-- More?

			if not Nx.Timer:IsActive ("ItemDraw") then
				Nx.Timer:Start ("ItemDraw", 10, self, self.DrawTimer)
			end
			return .1
		end

		Nx.Timer:Start ("ItemDraw", 3, self, self.DrawTimer)
	end

	return 2
end

function Nx.Item:DrawTimer()

	if next (self.Needed) then		-- More?
		Nx.prt (L[" %d items retrieved"], self.ItemsRequested)

	else
		Nx.prt (L["Item retrieval from server complete"])
	end

	Nx.Warehouse:Update()

	local g = Nx.Map:GetMap (1).Guide
	g:UpdateVisitedVendors()
	g:Update()
end

-------------------------------------------------------------------------------
-- Minimap button functions

function Nx.NXMiniMapBut:Init()

	local opts = Nx:GetGlobalOpts()

	local f = NXMiniMapBut

	if not opts["MapMMButOwn"] then
		f:RegisterForDrag ("LeftButton")
	end

	-- Create menu

	local menu = Nx.Menu:Create (f)
	self.Menu = menu

	menu:AddItem (0, L["Help"], self.Menu_OnShowHelp, self)
	menu:AddItem (0, L["Options"], self.Menu_OnOptions, self)

	menu:AddItem (0, L["Show Map"], self.Menu_OnShowMap, self)

--PAIDS!
	if not Nx.Free then

		menu:AddItem (0, L["Show Combat Graph"], self.Menu_OnShowCombat, self)
		menu:AddItem (0, L["Show Events"], self.Menu_OnShowEvents, self)

		local function func()
			Nx.Fav:ToggleShow()
		end
		menu:AddItem (0, L["Show Favorites"], func, self)

		if opts["IWinEnable"] then

			local function func()
				Nx.Info:ToggleShow()
			end

			menu:AddItem (0, L["Show Info 1 2"], func, self)
		end

		local function func()
			Nx.Warehouse:ToggleShow()
		end
		menu:AddItem (0, L["Show Warehouse"], func, self)

		menu:AddItem (0, L["Start Demo"], self.Menu_OnStartDemo, self)

		menu:AddItem (0, "", nil, self)
--[[
		local function func()
			Nx.Opts:Update()
		end

		local item = menu:AddItem (0, "Hide Tracking Arrow", func, self)
		item:SetChecked (opts, "HUDHide")
--]]
	end
--PAIDE!

	local item = menu:AddItem (0, L["Show Auction Buyout Per Item"], self.Menu_OnShowAuction, self)
	item:SetChecked (false)

	if NxData.DebugCom then
		menu:AddItem (0, "", nil, self)
		menu:AddItem (0, L["Show Com Window"], self.Menu_OnShowCom, self)
	end
	if NxData.DebugMap then
		menu:AddItem (0, "", nil, self)
		menu:AddItem (0, L["Toggle Profiling"], self.Menu_OnProfiling, self)
	end

	-- Fix position if bad (does not work)

	NXMiniMapBut:SetClampedToScreen (true)

--	self:Move()

	-- Ask to disable profiling

	local ok, var = pcall (GetCVar, "scriptProfile")
	if ok and var ~= "0" then
		Nx:ShowMessage (L["Profiling is on. This decreases game performance. Disable?"], L["Disable and Reload"], self.ToggleProfiling, L["Cancel"])
	end
end

function Nx.NXMiniMapBut:Menu_OnShowHelp()
	Nx.Help:Open()
end

function Nx.NXMiniMapBut:Menu_OnOptions()
	Nx.Opts:Open()
end

function Nx.NXMiniMapBut:Menu_OnStartDemo()
	Nx.Help.Demo:Start()
end

function Nx.NXMiniMapBut:Menu_OnShowMap()
	Nx.Map:ToggleSize()
end

function Nx.NXMiniMapBut:Menu_OnShowCombat()
	Nx.Combat:Open()
end

function Nx.NXMiniMapBut:Menu_OnShowEvents()
	Nx.UEvents.List:Open()
end

function Nx.NXMiniMapBut:Menu_OnHideWatch (item)
	local hide = item:GetChecked()
	Nx.Quest.Watch.Win:Show (not hide)
end

function Nx.NXMiniMapBut:Menu_OnShowAuction (item)
	Nx.AuctionShowBOPer = item:GetChecked()

	if AuctionFrame and AuctionFrame:IsShown() then
		AuctionFrameBrowse_Update()
	end
end

function Nx.NXMiniMapBut:Menu_OnShowCom()
	Nx.Com.List:Open()
end

function Nx.NXMiniMapBut:Menu_OnProfiling()
	Nx:ShowMessage (L["Toggle profiling? Reloads UI"], L["Reload"], self.ToggleProfiling, L["Cancel"])
end

function Nx.NXMiniMapBut:ToggleProfiling()

	RegisterCVar ("scriptProfile")

	local var = GetCVar ("scriptProfile")
--	Nx.prtVar ("v:", var)
	var = var == "0" and "1" or "0"
	SetCVar ("scriptProfile", var)

--	Nx.prt (format ("Profiling %s", var))
	ReloadUI()
end

function Nx.NXMiniMapBut:NXOnEnter (frm)

	local gopts = Nx.GetGlobalOpts()
	local mmown = gopts["MapMMButOwn"]
	local tip = GameTooltip

	--V4 this
	tip:SetOwner (frm, "ANCHOR_LEFT")
	tip:SetText (NXTITLEFULL .. " " .. Nx.VERMAJOR .. "." .. Nx.VERMINOR*10)	
	tip:AddLine (L["Left click toggle Map"], 1, 1, 1, 1)

	if mmown then
		tip:AddLine (L["Shift left click toggle minimize"], 1, 1, 1, 1)
	end

	tip:AddLine (L["Alt left click toggle Watch List"], 1, 1, 1, 1)
	tip:AddLine (L["Middle click toggle Guide"], 1, 1, 1, 1)
	tip:AddLine (L["Right click for Menu"], 1, 1, 1, 1)

	if not mmown then
		tip:AddLine (L["Shift drag to move"], 1, 1, 1, 1)
	end
	tip:AppendText ("")
end

function Nx.NXMiniMapBut:NXOnClick (button, down)

--	Nx.prt (button)

	if button == "LeftButton" then

		if IsShiftKeyDown() then
			local opts = Nx:GetGlobalOpts()
			opts["MMButWinMinimize"] = not opts["MMButWinMinimize"]
			Nx.Map.Dock:UpdateOptions()

		elseif IsAltKeyDown() then
			local w = Nx.Quest.Watch.Win
			w:Show (not w:IsShown())

		else
			Nx.Map:ToggleSize (0)
		end

	elseif button == "MiddleButton" then

		Nx.Map:GetMap (1).Guide:ToggleShow()

	else
		self:OpenMenu()
	end
end

function Nx.NXMiniMapBut:OpenMenu()
	if self.Menu then			-- Someone had error with this nil
		self.Menu:Open()
	end
end

--------
-- Move the minimap button around the minimap

function Nx.NXMiniMapBut:NXOnUpdate (frm)

--	Nx.prtVar ("NXOnUpdate", frm)

	--V4 this
	if frm.NXDrag then

--		Nx.prt ("Drag")

		local mm = _G["Minimap"]

		local x, y = GetCursorPosition()
		local s = mm:GetEffectiveScale()
		self:Move (x / s, y / s)
	end
end

function Nx.NXMiniMapBut:Move (x, y)

	local but = NXMiniMapBut		-- 32x32

	local mm = _G["Minimap"]

	local l = mm:GetLeft() + 70				-- Minimap is 140x140
	local b = mm:GetBottom() + 70
--[[
	if not x then
		x = but:GetLeft()
		y = but:GetTop()
		Nx.prt ("xy %s %s", x, y)
	end
--]]
	x = x - l
	y = y - b

	local ang = atan2 (y, x)
	local r = (x ^ 2 + y ^ 2) ^ .5
	r = max (r, 79)
	r = min (r, 110)

	x = r * cos (ang)
	y = r * sin (ang)	
	but:SetPoint ("TOPLEFT", mm, "TOPLEFT", x + 54, y - 54)
	but:SetUserPlaced (true)
end

-------------------------------------------------------------------------------
--EOF










