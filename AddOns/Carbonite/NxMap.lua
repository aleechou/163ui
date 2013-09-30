local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxMap - Map code
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
-------------------------------------------------------------------------------
-- Map

NxMAPOPTS_VERSION	= .26

NxMapOpts = {
	Version = 0
}

NxMapOptsDefaults = {
	Version = NxMAPOPTS_VERSION,

	NXMaps = {
		[1] = {
			[0] = {	-- Default map id
				NXPlyrFollow = true,
				NXWorldShow = true,
			},
			[9001] = {	-- AB
				NXPlyrFollow = false,
				NXWorldShow = false,
--				NXScale = 1,
			},
			[9002] = {	-- WG
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9003] = {	-- AV
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9004] = {	-- EOS
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9008] = {	-- SoA
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9009] = {	-- IC
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9010] = {	-- TBG
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9011] = {	-- TP
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9012] = {	-- TK
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9013] = {	-- SM
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9014] = {	-- TPG
				NXPlyrFollow = false,
				NXWorldShow = false,
			},
			[9015] = {
				NXPlyrFollow = false,
				NXWorldShow = false,	
			},
			[9016] = {
				NXPlyrFollow = false,
				NXWorldShow = false,	
			},
			NXAutoScaleOn = true,

			NXKillShow = false,

			NXMMFull = false,
			NXMMAlpha = .1,
			NXMMDockScale = .4,
			NXMMDockScaleBG = .4,
			NXMMDockAlpha = 1,
			NXMMDockOnAtScale = .6,

			NXBackgndAlphaFade = .4,
			NXBackgndAlphaFull = 1,

			NXArchAlpha = .3,
			NXQuestAlpha = .3,
			
			NXAutoScaleMin = .01,
			NXAutoScaleMax = 4,
			NXDotZoneScale = 1,
			NXDotPalScale = 1,
			NXDotPartyScale = 1,
			NXDotRaidScale = 1,
			NXIconNavScale = 1,
			NXIconScale = 1,
			NXDetailScale = 2,
			NXDetailAlpha = 1,
			NXPOIAtScale = 1,

			NXShowUnexplored = false,
			NXUnexploredAlpha = .35,
			
			-- OLD
			NXOverlayAlpha = nil,
			NXMiniAlpha = nil,
			NXMiniShow = nil,			
		}
	}
}

--------
-- Init map stuff

function Nx.Map:Init()

	local gopts = Nx.GetGlobalOpts()
	self.GOpts = gopts

	local plFaction = UnitFactionGroup ("player")
--	Nx.prt ("fac %s", plFaction)
	plFaction = strsub (plFaction, 1, 1)
	self.PlFactionNum = plFaction == "A" and 0 or 1
	self.PlFactionShort = plFaction == "A" and "Ally" or "Horde"

	self.Maps = {}
	self.Created = false

	self:InitFuncs()
	self:InitTables()

--	if Nx.V32 then
--		hooksecurefunc ("UpdateQuestMapPOI", self.UpdateQuestMapPOIHook)
--	end

--	hooksecurefunc ("ToggleWorldMap", Nx.Map.ToggleWorldMapHook)

	self.PlyrNames = {}
	self.AFKers = {}
	self.PlyrNamesTipStr = ""

	self.ScanContinentsMod = 10

	self.ContPOIs = {}
	for cont = 1, self.ContCnt do
		self.ContPOIs[cont] = {}
	end

	self.BGTimers = {}

	local hist = {}
	self.PlyrHist = hist
	hist.LastX = -99999999
	hist.LastY = -99999999
	hist.Next = 1
	hist.Cnt = self.GOpts["MapTrailCnt"]

	for n = 1, hist.Cnt * 4, 4 do
		hist[n] = 0				-- Secs
		hist[n + 1] = 0		-- World X
		hist[n + 2] = 0		-- World Y
		hist[n + 3] = 0		-- Direction
	end

	Nx.MapPOITypes = {
		[0] =
		0, 0, 2, 1, 1, 0, 0, 0,  0, 1, 2, 1, 2, 2, 2, 1,
		0, 1, 1, 2, 2, 0, 1, 1,  2, 2, 0, 1, 1, 2, 2, 0,
		1, 1, 2, 2, 0, 1, 1, 2,  2, 0, 0, 1, 2, 0, 1, 1,
		2, 2,
		[136] = 1,
		[137] = 1,
		[138] = 2,
		[139] = 2,
		[141] = 1,
		[142] = 1,
		[143] = 2,
		[144] = 2,
		[146] = 1,
		[147] = 1,
		[148] = 2,
		[149] = 2,
		[151] = 1,
		[152] = 1,
		[153] = 2,
		[154] = 2,
	}

	self.WorldMapHideNames = {
		"WorldMapCorpse", "WorldMapDeathRelease", "WorldMapPing", "OutlandButton", "AzerothButton"
	}

	self.AddonMinimapNames = NXMapAddonMinimapNames
	NXMapAddonMinimapNames = nil

	-- Emulate TomTom

	if gopts["EmuTomTom"] and not TomTom then
		local tom = {}
		TomTom = tom
		tom["version"] = "v40200"
		tom["AddWaypoint"] = Nx.TTAddWaypoint
		tom["AddZWaypoint"] = Nx.TTAddZWaypoint
		tom["SetCustomWaypoint"] = Nx.TTSetCustomWaypoint
		tom["SetCustomMFWaypoint"] = Nx.TTSetCustomMFWaypoint
		tom["AddMFWaypoint"] = Nx.TTSetCustomMFWaypoint
		tom["RemoveWaypoint"] = Nx.TTRemoveWaypoint
		tom["SetCrazyArrow"] = Nx.TTSetCrazyArrow
		SLASH_WAY1 = '/way'
		SlashCmdList["WAY"] = function (msg, editbox)
			Nx:TTWayCmd(msg)
		end
	end

	if gopts["EmuCartWP"] and not Cartographer then
		local cart = {}
		Cartographer = cart

		cart["HasModule"] = function (self, module)
				return module == "Waypoints" or module == Cartographer_Waypoints
			end
		cart["IsModuleActive"] = cart["HasModule"]

		cart["GetDistanceToPoint"] = Nx.CartGetDistanceToPoint

		local cartwp = {}
		Cartographer_Waypoints = cartwp
		cartwp["SetPointAsWaypoint"] = Nx.CartSetPointAsWaypoint
		cartwp["AddLHWaypoint"] = Nx.CartAddLHWaypoint
		cartwp["AddRoutesWaypoint"] = Nx.CartAddRoutesWaypoint
		cartwp["AddWaypoint"] = Nx.CartAddWaypoint
		cartwp["UpdateWaypoint"] = function (self) end
		cartwp["CancelWaypoint"] = Nx.CartCancelWaypoint

		cartwp["GetWaypointHitDistance"] = function() return 7 end
		cartwp["SetWaypointHitDistance"] = Nx.CartSetWaypointHitDistance

--		Nx.prtVar ("Cartographer_Waypoints", Cartographer:IsModuleActive ("Waypoints"))
--		Nx.prtVar ("Cartographer_Waypoints", Cartographer:IsModuleActive (Cartographer_Waypoints))

		if not NotePoint then
			local np = {}
			NotePoint = np
			np["new"] = Nx.CartNotePointNew
		end
	end
end

--------
-- Open and init

function Nx.Map:Open()

	local Map = Nx.Map

	local m = self.Maps[1]

	if not NxMapOpts.NXMaps then		-- Missing?
		NxMapOpts.Version = 0
	end

	if NxMapOpts.Version < NxMAPOPTS_VERSION then

		if NxMapOpts.Version > 0 then
			Nx.prt (L["Reset map options %f"], NxMapOpts.Version)
		end

		NxMapOpts = NxMapOptsDefaults
	end

	local opts = NxMapOpts.NXMaps[1]

	for k, v in pairs (NxMapOptsDefaults.NXMaps[1]) do		
		if opts[k] == nil then		    
			opts[k] = v
		end
	end

	if self.Created then

		if m.Frm:IsShown() then
			m.Frm:Hide()
		else
			m.Frm:Show()
		end
		return
	end

	--

	
	self.Maps[1] = self:Create (1)
	self.Dock:Create()

	self.Created = true

	-- Create a table of all the Minimap's children

--[[
	local children = { Minimap:GetChildren() }

--	Map.MinimapChildren = children

	for i = #children, 1, -1 do

		-- Scan children starting from the end of the list to see if the object is a model
		-- If it is, and has no name (in case some addon attached a model to it), it's probably the right one

		-- FIX!!!! use model name!

		if children[i]:IsObjectType ("Model") and not children[i]:GetName() then

			Map.MinimapPlyrModel = children[i]

--			Nx.prtVar ("minimap model", Map.MinimapPlyrModel)

			break

		end
	end

	Map.MinimapCompass = getglobal ("MiniMapCompassRing")

--]]
end

--------

function Nx.Map:UpdateOptions (index)

	local src = Nx.Map.Maps[index]
	local dst = NxMapOpts.NXMaps[index]

	assert (src)
	assert (dst)

--	dst.NXMapScale = src.MapScale

	dst.NXShowUnexplored = src.ShowUnexplored
	dst.NXKillShow = src.KillShow

	dst.NXBackgndAlphaFade = src.BackgndAlphaFade	
	dst.NXBackgndAlphaFull = src.BackgndAlphaFull

	dst.NXArchAlpha = src.ArchAlpha
	dst.NXQuestAlpha = src.QuestAlpha
	
	dst.NXDotZoneScale = src.DotZoneScale
	dst.NXDotPalScale = src.DotPalScale
	dst.NXDotPartyScale = src.DotPartyScale
	dst.NXDotRaidScale = src.DotRaidScale
	dst.NXIconNavScale = src.IconNavScale
	dst.NXIconScale = src.IconScale

	local opts = src.CurOpts
	if opts then
--		Nx.prt ("Map UpdateOptions %s %s", src.MapPosX, src.MapPosY)
		opts.NXMapPosX = src.MapPosX
		opts.NXMapPosY = src.MapPosY
		opts.NXScale = src.Scale
	end
end

--------
-- Switch to a new set of options
-- self = map

function Nx.Map:SwitchOptions (id, startup)

--	Nx.prt ("Map SwitchOptions %s", id)

	local opts = NxMapOpts.NXMaps[self.MapIndex]
	local copts = opts[id] or opts[0]

	if copts ~= self.CurOpts then

--		Nx.prt ("Map SwitchOptions Diff %s", id)

		self.CurOpts = copts

		if copts.NXPlyrFollow then
			self:GotoPlayer()
		end

--		Nx.prtVar ("copts", copts)
--		Nx.prtVar ("inBG", Nx.InBG)

		if (not copts.NXPlyrFollow or startup) and copts.NXMapPosX then

--			Nx.prt ("Map SwitchOptions %s NXMapPosX %f %f %f", id, copts.NXMapPosX, copts.NXMapPosY, copts.NXScale)

			self.MapPosX = copts.NXMapPosX
			self.MapPosY = copts.NXMapPosY
			self.Scale = copts.NXScale
			self.RealScale = self.Scale
			self.StepTime = 1

		elseif copts.NXPlyrFollow or Nx.InBG then

--			Nx.prt ("Map SwitchOptions GotoCurrentZone")
			self:GotoCurrentZone()
		end

		local mode = opts[id] and tostring (id) or ""
		self.Win:SwitchLayoutMode (mode)
	end
end

--------

function Nx.Map:GetOptionsT (index)

	local map = Nx.Map.Maps[index]
	local opts = NxMapOpts.NXMaps[index]

	return opts[map.RMapId] or opts[0]
end

--------

function Nx.Map:GetOption (index, name)

	local map = Nx.Map.Maps[index]
	local opts = NxMapOpts.NXMaps[index]

	local id = map.RMapId
	id = opts[id] and id or 0

	return opts[id][name]
end

--------

function Nx.Map:SetOption (index, name, value)

	local map = Nx.Map.Maps[index]
	local opts = NxMapOpts.NXMaps[index]

	local id = map.RMapId
	id = opts[id] and id or 0

	opts[id][name] = value
end

--------

function Nx.Map:InitFuncs()

	self.Funcs = {
		["None"] = function() end,
		["Add Note"] = self.Menu_OnAddNote,
		["Goto"] = self.SetTargetAtClick,
		["Show Player Zone"] = self.GotoCurrentZone,
		["Show Selected Zone"] = self.CenterMap,
		["Menu"] = self.OpenMenu,
		["Zoom In"] = self.ClickZoomIn,
		["Zoom Out"] = self.ClickZoomOut,
	}
end

function Nx.Map:GetFuncs()

	local t = {}

	for name in pairs (self.Funcs) do
		tinsert (t, name)
	end

	sort (t)

	return t
end

--------
-- Call a map function from an option setting
-- self = map

function Nx.Map:CallFunc (optName)

	local name = self.GOpts[optName]
	if name == "None" then
		return	-- return nil
	end

	local func = self.Funcs[name]
	if func then
		func (self)
	else
		Nx.prt (L["Unknown map function %s"], name)
	end

	return true	-- We did something
end

--------
-- Create a map

function Nx.Map:Create (index)

	local Map = Nx.Map

	local m = {}

	local gopts = Nx.GetGlobalOpts()
	m.GOpts = gopts

	local opts = NxMapOpts.NXMaps[index]
	m.LOpts = opts		-- Local for map (stuff without a map mode)

	opts.NXPOIAtScale = opts.NXPOIAtScale or 1

	setmetatable (m, self)
	self.__index = self

	m.Tick = 0												-- Debug tick
	m.Debug = nil											-- Debug on
	m.DebugTime = nil
	m.DebugFullCoords = nil								-- Debug high precision map coords
	m.DebugAdjustScale = .1

	m.MapIndex = index
	m.MMOwn = gopts["MapMMOwn"] and index == 1

	m.ShowUnexplored = opts.NXShowUnexplored
	
	m.KillShow = opts.NXKillShow

	m.TitleH = 0
	m.PadX = 0
	m.Scale = .025
	m.RealScale = .025
	m.ScaleDraw = .025									-- Actual draw scale
	m.MapScale = opts.NXMapScale or 1
	m.MapW = 150
	m.MapH = 140
	m.W = m.MapW + m.PadX * 2
	m.H = m.MapH + m.TitleH + 1
	m.LClickTime = 0
	m.MouseEnabled = true
	m.Scrolling = false
	m.StepTime = 0
	m.MapId = 0
	m.BaseScale = 1										-- Scale values, because instances are smaller
	m.PlyrX = 0
	m.PlyrY = 0
	m.PlyrRZX = 0
	m.PlyrRZY = 0
	m.PlyrDir = 0
	m.PlyrLastDir = 999
	m.PlyrSpeed = 0
	m.PlyrSpeedX = 0
	m.PlyrSpeedY = 0
	m.PlyrSpeedCalcTime = GetTime()
	m.MoveDir = 0
	m.MoveLastX = 0
	m.MoveLastY = 0
	m.ViewSavedData = {}
	m.MapPosX = 2200											-- World position of map
	m.MapPosY = -100
	m.MapPosXDraw = m.MapPosX								-- Actual draw position
	m.MapPosYDraw = m.MapPosY
	m.MapsDrawnOrder = {}									-- [index (1st is newest)] = map id
	m.MapsDrawnFade = {}										-- [map id] = fade
	m.MiniBlks = gopts["MapDetailSize"]
	m.ArchAlpha = opts.NXArchAlpha
	m.QuestAlpha = opts.NXQuestAlpha
	m.BackgndAlphaFade = opts.NXBackgndAlphaFade
	m.BackgndAlphaFull = opts.NXBackgndAlphaFull
	m.BackgndAlpha = 0									-- Current value
	m.BackgndAlphaTarget = m.BackgndAlphaFade		-- Target value
	m.WorldAlpha = 0
	m.DotZoneScale = opts.NXDotZoneScale
	m.DotPalScale = opts.NXDotPalScale
	m.DotPartyScale = opts.NXDotPartyScale
	m.DotRaidScale = opts.NXDotRaidScale
	m.IconNavScale = opts.NXIconNavScale
	m.IconScale = opts.NXIconScale
	m.ArrowPulse = 1
	m.ArrowScroll = 0

	m.UpdateTargetDelay = 0
	m.UpdateTrackingDelay = 0

	m.Targets = {}
	m.TargetNextUniqueId = 1
	m.Tracking = {}
	m.TrackPlyrs = {}

	m.Data = {}
	m.IconFrms = {}
	m.IconFrms.Next = 1
	m.IconNIFrms = {}				-- Non interactive
	m.IconNIFrms.Next = 1
	m.IconStaticFrms = {}
	m.IconStaticFrms.Next = 1

	m.TextFStrs = {}
	m.TextFStrs.Next = 1

	m.MMGathererUpdateDelay = 1

	-- Create Window

	Nx.Window:SetCreateFade (1, 0)

	local wname = m:GetWinName()

	local i = gopts["MapShowTitle2"] and 2 or 1

	local win = Nx.Window:Create (wname, nil, nil, nil, i)
	m.Win = win

	win:SetBGAlpha (0, 1)

	win:CreateButtons (true)
	win:InitLayoutData (nil, -.0001, -.4, -.19, -.3, 1)

	for n = 9001, 9004 do
		win:InitLayoutData (tostring (n), -.0001, -.4, -.19, -.3, 1)
	end

	for n = 9008, 9013 do
		win:InitLayoutData (tostring (n), -.0001, -.4, -.19, -.3, 1)
	end

	win:SetUser (m, self.OnWin)
	win.UserUpdateFade = m.WinUpdateFade

	win.Frm:SetToplevel (true)
	win.Frm.NxMap = m

	m.StartupShown = win:IsShown()
	win.Frm:Show()

	-- Create main frame

	local f = CreateFrame ("Frame", nil, UIParent)
	m.Frm = f
	f.NxMap = m

	win:Attach (f, 0, 1, 0, 1)

--	win:RegisterEvent ("PLAYER_LOGIN", self.OnEvent)
--	win:RegisterEvent ("PLAYER_ENTERING_WORLD", self.OnEvent)
	win:RegisterEvent ("WORLD_MAP_UPDATE", self.OnEvent)
	win:RegisterEvent ("PLAYER_REGEN_DISABLED", self.OnEvent)
	win:RegisterEvent ("PLAYER_REGEN_ENABLED", self.OnEvent)
	f:SetScript ("OnMouseDown", self.OnMouseDown)
	f:SetScript ("OnMouseUp", self.OnMouseUp)
	f:SetScript ("OnMouseWheel", self.OnMouseWheel)
	f:EnableMouse (true)
	f:EnableMouseWheel (true)

	f:SetScript ("OnUpdate", self.OnUpdate)

	f:SetMovable (true)
	f:SetResizable (true)

--	f:SetFrameStrata ("LOW")
	f:SetWidth (m.W)
	f:SetHeight (m.H)
	f:SetMinResize (50, 50)

	local t = f:CreateTexture()
	t:SetTexture (0, 0, 0, .2)
	t:SetAllPoints (f)
	f.texture = t

	f:Show()

	-- Create text frame

	local tsf = CreateFrame ("ScrollFrame", nil, f)
	m.TextScFrm = tsf

	tsf:SetAllPoints (f)

	local tf = CreateFrame ("Frame", nil, tsf)
	m.TextFrm = tf
	tf:SetPoint ("TOPLEFT", 0, 0)
	tf:SetWidth (100)
	tf:SetHeight (100)

--	tf:SetAllPoints (f)
	tsf:SetScrollChild (tf)

	-- Tip

	m:CreateLocationTip()

	-- Create tool bar

	m:CreateToolBar()

	-- Create buttons

	local bw, bh = win:GetBorderSize()

	local function func (self, but)
		self.LOpts.NXAutoScaleOn = but:GetPressed()
	end

	m.ButAutoScaleOn = Nx.Button:Create (win.Frm, "MapAutoScale", nil, nil, -20, -bh, "TOPRIGHT", 12, 12, func, m)
	m.ButAutoScaleOn:SetPressed (opts.NXAutoScaleOn)

	-- Create menu

	local menu = Nx.Menu:Create (f)
	m.Menu = menu

	menu:AddItem (0, L["Goto"], self.Menu_OnGoto, m)
	menu:AddItem (0, L["Clear Goto"], self.Menu_OnClearGoto, m)

	menu:AddItem (0, L["Add Note"], self.Menu_OnAddNote, m)

	menu:AddItem (0, L["Save Map Scale"], self.Menu_OnScaleSave, m)
	menu:AddItem (0, L["Restore Map Scale"], self.Menu_OnScaleRestore, m)

	m.MenuIPlyrFollow = menu:AddItem (0, L["Follow You"], self.Menu_OnPlyrFollow, m)

	local item = menu:AddItem (0, L["Select Cities Last"], self.SetLevelWorldHotspots, m)
	item:SetChecked (m, "NXCitiesUnder")

	m.MenuIMonitorZone = menu:AddItem (0, L["Monitor Zone"], self.Menu_OnMonitorZone, m)

	menu:AddItem (0, "", nil, self)

	-- Create route sub menu

	local routeMenu = Nx.Menu:Create (f)
	menu:AddSubMenu (routeMenu, L["Route..."])

	local function func (self)
		self:RouteGathers()
	end
	local item = routeMenu:AddItem (0, L["Current Gather Locations"], func, m)

	local function func (self)
		self:RouteTargets()
	end
	local item = routeMenu:AddItem (0, L["Current Goto Targets"], func, m)

	local function func (self)
		self.ShowUnexplored = false
		self:UpdateOverlayUnexplored()
		self:TargetOverlayUnexplored()
		self:RouteTargets()
	end

	routeMenu:AddItem (0, L["Unexplored Locations"], func, m)

	local function func (self)
		self:ReverseTargets()
	end

	routeMenu:AddItem (0, L["Reverse Targets"], func, m)

	local item = routeMenu:AddItem (0, L["Recycle Reached Targets"])
	item:SetChecked (gopts, "RouteRecycle")

	local item = routeMenu:AddItem (0, L["Gather Target Radius"])
	item:SetSlider (gopts, 7, 300, nil, "RouteGatherRadius")

	local item = routeMenu:AddItem (0, L["Gather Merge Radius"])
	item:SetSlider (gopts, 0, 100, nil, "RouteMergeRadius")

	-- Create show sub menu

	local showMenu = Nx.Menu:Create (f)
	menu:AddSubMenu (showMenu, L["Show..."])

	showMenu:AddItem (0, L["Show Player Zone"], self.Menu_OnShowPlayerZone, m)

	local function func (self)
		self.Guide:UpdateGatherFolders()
	end

	local item = showMenu:AddItem (0, L["Show Herb Locations"], func, m)
	m.MenuIShowHerb = item
	item:SetChecked (Nx.CharOpts, "MapShowGatherH")

	local item = showMenu:AddItem (0, L["Show Mining Locations"], func, m)
	m.MenuIShowMine = item
	item:SetChecked (Nx.CharOpts, "MapShowGatherM")

	local item = showMenu:AddItem (0, L["Show Artifact Locations"], func, m)
	m.MenuIShowArt = item
	item:SetChecked (Nx.CharOpts, "MapShowGatherA")


	local function func (self)
		self.Guide.POIDraw = nil
	end

	local item = showMenu:AddItem (0, L["Show Mailboxes"], func, m)
	item:SetChecked (gopts, "MapShowMailboxes")


	local item = showMenu:AddItem (0, L["Show Notes"])
	item:SetChecked (gopts, "MapShowNotes")

	local item = showMenu:AddItem (0, L["Show Punks"])
	item:SetChecked (gopts, "MapShowPunks")

	local item = showMenu:AddItem(0, L["Show Archaeology Blobs"], func, m)
	item:SetChecked (Nx.CharOpts, "MapShowArchBlobs")

	local item = showMenu:AddItem(0, L["Show Quest Blobs"], func, m)
	item:SetChecked (Nx.CharOpts, "MapShowQuestBlobs")
	
	local function func (self, item)
		self.ShowUnexplored = item:GetChecked()
	end

	local item = showMenu:AddItem (0, L["Show Unexplored Areas"], func, m)
	item:SetChecked (m.ShowUnexplored)


	m.MenuIShowWorld = showMenu:AddItem (0, L["Show World"], self.Menu_OnShowWorld, m)


	local function forceShowCont (self)
		self.ScanContinentsMod = 10
	end

	local item = showMenu:AddItem (0, L["Show Cities"], forceShowCont, Map)
	item:SetChecked (gopts, "MapShowCCity")

	local item = showMenu:AddItem (0, L["Show Towns"], forceShowCont, Map)
	item:SetChecked (gopts, "MapShowCTown")

	local item = showMenu:AddItem (0, L["Show Extras"], forceShowCont, Map)
	item:SetChecked (gopts, "MapShowCExtra")

	local item = showMenu:AddItem (0, L["Show Kill Icons"], self.Menu_OnShowKills, m)
	item:SetChecked (m.KillShow)

	-- Create minimap sub menu

	if not Nx.Free then

		local mmmenu = Nx.Menu:Create (f)

		menu:AddSubMenu (mmmenu, L["Minimap..."])

		local function func (self, item)
			self.LOpts.NXMMFull = item:GetChecked()
			self.MMZoomChanged = true
		end

		local item = mmmenu:AddItem (0, L["Full Size"], func, m)
		self.MMMenuIFull = item
		item:SetChecked (opts.NXMMFull)

		local function func (self, item)
			self.LOpts.NXMMAlpha = item:GetSlider()
		end

		local item = mmmenu:AddItem (0, L["Transparency"], func, m)
		item:SetSlider (opts.NXMMAlpha, 0, 1)

		local function func (self, item)
			self.LOpts.NXMMDockScale = item:GetSlider()
			self.MMZoomChanged = true
		end

		local item = mmmenu:AddItem (0, L["Docked Scale"], func, m)
		item:SetSlider (opts.NXMMDockScale, .01, 3)

		local function func (self, item)
			self.LOpts.NXMMDockScaleBG = item:GetSlider()
			self.MMZoomChanged = true
		end

		local item = mmmenu:AddItem (0, L["Docked Scale In BG"], func, m)
		item:SetSlider (opts.NXMMDockScaleBG, .01, 3)

		local function func (self, item)
			self.LOpts.NXMMDockAlpha = item:GetSlider()
		end

		local item = mmmenu:AddItem (0, L["Docked Transparency"], func, m)
		item:SetSlider (opts.NXMMDockAlpha, 0, 1)

		local function func (self, item)
			self.LOpts.NXMMDockOnAtScale = item:GetSlider()
		end

		local item = mmmenu:AddItem (0, L["Docking Below Map Scale"], func, m)
		item:SetSlider (opts.NXMMDockOnAtScale, 0, 5)
	end

	-- Create scale sub menu

	local smenu = Nx.Menu:Create (f)

	menu:AddSubMenu (smenu, L["Scale..."])

	local item = smenu:AddItem (0, L["Auto Scale Min"])
	item:SetSlider (opts, .01, 10, nil, "NXAutoScaleMin")

	local item = smenu:AddItem (0, L["Auto Scale Max"])
	item:SetSlider (opts, .25, 10, nil, "NXAutoScaleMax")

	local item = smenu:AddItem (0, L["Zone Dot Scale"], self.Menu_OnDotZoneScale, m)
	item:SetSlider (m.DotZoneScale, 0.1, 2)

	local item = smenu:AddItem (0, L["Friend/Guild Dot Scale"], self.Menu_OnDotPalScale, m)
	item:SetSlider (m.DotPalScale, 0.1, 2)

	local item = smenu:AddItem (0, L["Party Dot Scale"], self.Menu_OnDotPartyScale, m)
	item:SetSlider (m.DotPartyScale, 0.1, 2)

	local item = smenu:AddItem (0, L["Raid Dot Scale"], self.Menu_OnDotRaidScale, m)
	item:SetSlider (m.DotRaidScale, 0.1, 2)

	local item = smenu:AddItem (0, L["Icon Scale"], self.Menu_OnIconScale, m)
	item:SetSlider (m.IconScale, 0.1, 3)

	local item = smenu:AddItem (0, L["Navigation Icon Scale"], self.Menu_OnIconNavScale, m)
	item:SetSlider (m.IconNavScale, 0.1, 3)

	local function func (self, item)
		self.LOpts.NXDetailScale = item:GetSlider()
	end

	local item = smenu:AddItem (0, L["Details At Scale"], func, m)
	item:SetSlider (opts.NXDetailScale, .05, 10)

	local item = smenu:AddItem (0, L["Gather Icons At Scale"])
	item:SetSlider (gopts, .01, 10, nil, "MapIconGatherAtScale")

	local item = smenu:AddItem (0, L["POI Icons At Scale"])
	item:SetSlider (opts, .1, 10, nil, "NXPOIAtScale")

	-- Create transparency sub menu

	local tmenu = Nx.Menu:Create (f)
	m.TransMenu = tmenu

	menu:AddSubMenu (tmenu, L["Transparency..."])

	local item = tmenu:AddItem (0, L["Detail Transparency"], self.Menu_OnDetailAlpha, m)
	item:SetSlider (opts.NXDetailAlpha, .25, 1)

	local item = tmenu:AddItem (0, L["Fade In Transparency"], self.Menu_OnBackgndAlphaFull, m)
	item:SetSlider (m.BackgndAlphaFull, .25, 1)

	local item = tmenu:AddItem (0, L["Fade Out Transparency"], self.Menu_OnBackgndAlphaFade, m)
	item:SetSlider (m.BackgndAlphaFade, 0, 1)

	local function func (self)
		self.Guide:UpdateGatherFolders()
	end

	local item = tmenu:AddItem (0, L["Gather Icon Transparency"], func, m)
	item:SetSlider (gopts, .2, 1, nil, "MapIconGatherA")

	local item = tmenu:AddItem (0, L["POI Icon Transparency"])
	item:SetSlider (gopts, .2, 1, nil, "MapIconPOIAlpha")

	local function func (self, item)
		self.LOpts.NXUnexploredAlpha = item:GetSlider()
	end

	local item = tmenu:AddItem (0, L["Unexplored Transparency"], func, m)
	item:SetSlider (opts.NXUnexploredAlpha, 0, .9)
	
	local item = tmenu:AddItem(0, L["Archaeology Blob Transparency"],self.Menu_OnArchAlpha, m)
	item:SetSlider (m.ArchAlpha,0,1)

	local item = tmenu:AddItem(0, L["Quest Blob Transparency"],self.Menu_OnQuestAlpha, m)
	item:SetSlider (m.QuestAlpha,0,1)	
	
	-- Options menu

	local item = menu:AddItem (0, L["Options..."], self.Menu_OnOptions, m)

	-- Debug menu

	if NxData.DebugMap then

		m.DebugMap = true

		local dbmenu = Nx.Menu:Create (f)

		menu:AddItem (0, "", nil, self)
		menu:AddSubMenu (dbmenu, L["Debug..."])

		local function func (self, item)
			self.Debug = item:GetChecked()
		end

		local item = dbmenu:AddItem (0, L["Map Debug"], func, m)
		item:SetChecked (false)

--[[
		Nx.prt ("*** DebugHotspots is ON")
		m["DebugHotspots"] = true
--]]
		local item = dbmenu:AddItem (0, L["Hotspots"], func, m)
		item:SetChecked (m, "DebugHotspots")

		dbmenu:AddItem (0, L["Hotspots pack"], self.PackHotspotsDebug, m)

		local function func (self, item)
			self.DebugTime = item:GetChecked()
		end

		local item = dbmenu:AddItem (0, L["Map Debug Time"], func, m)
		item:SetChecked (false)

		local item = dbmenu:AddItem (0, L["Map Full Coords"], self.Menu_OnMapDebugFullCoords, m)
		item:SetChecked (m.DebugFullCoords)

		local item = dbmenu:AddItem (0, L["Quest Debug"], self.Menu_OnQuestDebug, m)
		item:SetChecked (Nx.Quest.Debug)

		local function func (self, item)
			self.DebugScale = item:GetSlider()
		end

		local item = dbmenu:AddItem (0, L["Scale"], func, m)
		item:SetSlider (0, 4, 6)
	end

	-- Create player icon menu

	local menu = Nx.Menu:Create (f)
	m.PIconMenu = menu

	menu:AddItem (0, L["Whisper"], self.Menu_OnWhisper, m)
	menu:AddItem (0, L["Invite"], self.Menu_OnInvite, m)
	menu:AddItem (0, L["Get Quests"], self.Menu_OnGetQuests, m)

	local item = menu:AddItem (0, L["Track Player"], self.Menu_OnTrackPlyr, m)
	local item = menu:AddItem (0, L["Remove From Tracking"], self.Menu_OnRemoveTracking, m)

	menu:AddItem (0, L["Report Player AFK"], self.Menu_OnReportPlyrAFK, m)
--	menu:AddItem (0, "Report All AFK", self.Menu_OnReportAllAFK, m)

	menu:AddItem (0, "")

	local item = menu:AddItem (0, L["Grow Conflict Bars"], self.Menu_OnGrowConflictBars, m)
	item:SetChecked (true)
	m.BGGrowBars = true

	-- Create general icon menu

	m:CreateIconMenu (f)

	-- Create BG icon menu

	m.BGIncNum = 0

	local menu = Nx.Menu:Create (f)
	m.BGIconMenu = menu

	for n = 1, #NXlBGMessages, 2 do

		local function func (self)
			self:BGMenu_Send (NXlBGMessages[n + 1])	-- Inherit n from loop
		end

		menu:AddItem (0, NXlBGMessages[n], func, m)
	end

	menu:AddItem (0, NXlBGStatus, self.BGMenu_OnStatus, m)

	-- Create player icon

	local plf = CreateFrame ("Frame", nil, f)
	m.PlyrFrm = plf
	plf.NxMap = m

	plf:SetWidth (3)
	plf:SetHeight (3)

	t = plf:CreateTexture()
	plf.texture = t
	t:SetTexture ("Interface\\Minimap\\MinimapArrow")
	t:SetAllPoints (plf)

	plf:SetPoint ("CENTER", 0, (m.TitleH - 1) * -.5)
	plf:Show()

	-- Init map frames

	m:InitFrames()

	-- Test

--[[
	m:InitIconType ("Test", nil, "Interface\\TargetingFrame\\TargetDead", 64, 64)

	for i = 1, 100, .2 do
		m:AddIconData ("Test", i, 30, 0)
	end
--]]

--[[
	m:InitIconType ("Test2", nil, 64, 64)

	for i = 1, 100, .2 do
		m:AddIconData ("Test2", i, 10, "00ff00")
	end
--]]

--[[
	m:InitIconType ("TestZR", "ZR")

	for i = 1, 10, 2 do
		m:AddIconRect ("TestZR", i, 5, i+1, 6, "00ff0080")
	end
--]]

	--
	local questwin = CreateFrame("QuestPOIFrame")
	m.QuestWin = questwin
	m.QuestWin:SetParent(m.TextScFrm:GetScrollChild())
	m.QuestWin:Hide()
	m.QuestWin:SetSize(WorldMapButton:GetSize())
	m.QuestWin:SetFillAlpha(255 * m.QuestAlpha)
	m.QuestWin:SetBorderAlpha(255 * m.QuestAlpha)
	m.QuestWin:SetFillTexture([[Interface\WorldMap\UI-QuestBlob-Inside]])
	m.QuestWin:SetBorderTexture([[Interface\WorldMap\UI-QuestBlob-Outside]])
	m.QuestWin:SetBorderScalar(0.15)
	
	local arch = CreateFrame("ArchaeologyDigSiteFrame")
	m.Arch = arch
    m.Arch:SetParent(m.TextScFrm:GetScrollChild())		
    m.Arch:Hide()
	m.Arch:SetSize(WorldMapButton:GetSize())
	m.Arch:SetFillAlpha(255 * m.ArchAlpha)
	m.Arch:SetBorderAlpha(255 * m.ArchAlpha )
	m.Arch:SetFillTexture( [[Interface\WorldMap\UI-ArchaeologyBlob-Inside]] )
	m.Arch:SetBorderTexture( [[Interface\WorldMap\UI-ArchaeologyBlob-Outside]] )
	m.Arch:SetBorderScalar( 0.15 )
	
	self.RMapId = 9000		-- Safe default

	m:SwitchOptions (-1, true)

	m:UpdateAll()

	m.Guide = Map.Guide:Create (m)

	--

	self.MMFrm = _G["Minimap"]
	assert (self.MMFrm)

	m:MinimapOwnInit()

	-- Force player to be shown after init done and not in BG

	local function func (self)
		if not Nx.InBG then
			self:GotoPlayer()
		end
	end

	Nx.Timer:Start ("MapIShow" .. m.MapIndex, 1, m, func)

	--

	return m
end

--------

function Nx.Map:GetWinName()
	return "NxMap" .. self.MapIndex
end

--------
-- Create map tool bar

function Nx.Map:CreateToolBar()

	local bar = Nx.ToolBar:Create (self:GetWinName().."TB", self.Frm, 22, true, true)
	self.ToolBar = bar

	bar:SetUser (self)

--	bar.Frm:SetFrameLevel (self.Frm:GetFrameLevel() + 30)

	local data = {
		{ "MapZIn", "Zoom In", self.OnButZoomIn, false },
		{ "MapZOut", "Zoom Out", self.OnButZoomOut, false },
		{ "MapFav", "-Favorites-", self.OnButToggleFav, false },
		{ "MapGuide", "-Guide-", self.OnButToggleGuide, false },
--		{ "MapQGivers", "-Quest Givers-", self.OnButToggleQuestGivers, false },
		{ "MapWarehouse", "-Warehouse-", self.OnButToggleWarehouse, false },
		{ "MapCombat", "-Combat-", self.OnButToggleCombat, false },
		{ "MapEvents", "-Events-", self.OnButToggleEvent, false },
--		{ "Scroll", "Debug Scroll", self.OnButScrollDebug, false },
--		{ "Scroll", "Debug Scroll2", self.OnButScrollDebug2, false },
	}

	for i, b in ipairs (data) do

		if Nx.Free and i > 3 then
			break
		end

		bar:AddButton (b[1], _TRANS(b[2]), nil, b[3], b[4])
	end

	bar:Update()

	self:UpdateToolBar()
end

function Nx.Map:UpdateToolBar()

	local frm = self.ToolBar.Frm

	local opts = Nx:GetGlobalOpts()
	if opts["MapShowToolBar"] then
		frm:Show()
	else
		frm:Hide()
	end
end

function Nx.Map:CreateIconMenu (frm)

	-- Create general icon menu

	local menu = Nx.Menu:Create (frm)
	self.GIconMenu = menu

	self.GIconMenuITogInst = menu:AddItem (0, L["Toggle Instance Map"], self.GMenu_OnTogInst, self)
	self.GIconMenuIFindNote = menu:AddItem (0, L["Find Note"], self.GMenu_OnFindNote, self)

	Nx.Quest:CreateGiverIconMenu (menu, frm)

	menu:AddItem (0, L["Goto"], self.GMenu_OnGoto, self)
	menu:AddItem (0, L["Clear Goto"], self.Menu_OnClearGoto, self)
	menu:AddItem (0, L["Paste Link"], self.GMenu_OnPasteLink, self)

	menu:AddItem (0, L["Add Note"], self.Menu_OnAddNote, self)
end

--------

function Nx.Map:CreateLocationTip()

	local f = CreateFrame ("Frame", "NxMapTip", self.Frm)
--	f.NxInst = self
	self.LocTipFrm = f

	f:SetClampedToScreen()

--	f:ClearAllPoints()
--	f:SetPoint ("BOTTOMLEFT", 0, 0)

	local t = f:CreateTexture()
	f.texture = t
	t:SetAllPoints (f)
	t:SetTexture (0, 0, 0, .85)

	-- Font strings

	local fstrs = {}
	self.LocTipFStrs = fstrs

	local h = Nx.Font:GetH ("FontMapLoc")

	for n = 1, 4 do
		local fstr = f:CreateFontString()
		tinsert (fstrs, fstr)
		fstr:SetFontObject ("NxFontMapLoc")
		fstr:SetJustifyH ("LEFT")
	end
end

function Nx.Map:SetLocationTip (tipStr)

	local f = self.LocTipFrm
	local a = self.GOpts["MapLocTipAnchor"]

	if tipStr and a ~= "None" then

		local ar = self.GOpts["MapLocTipAnchorRel"]
		ar = ar == "None" and a or ar
		f:ClearAllPoints()
		f:SetPoint (a, self.Frm, ar)

		local h = Nx.Font:GetH ("FontMapLoc")
		local fstrs = self.LocTipFStrs
		local i = 1
		local textW = 0

		for s in gmatch (tipStr, "(%C+)") do		-- gmatch makes garbage!
--			Nx.prt (s)
			local fstr = fstrs[i]
			fstr:SetPoint ("TOPLEFT", 2, 0 - (i - 1) * h)
			fstr:SetText (s)
			textW = max (textW, fstr:GetStringWidth())
			i = i + 1
		end

		for n = i, #fstrs do
			fstrs[n]:SetText ("")
		end

--		Nx.prt (textW)

--		f:SetFrameStrata ("DIALOG")
		f:SetWidth (4 + textW)
		f:SetHeight (2 + (i - 1) * h)
		f:Show()

	else
		f:Hide()
	end
end

-------------------------------------------------------

--------
-- Startup so show map

function Nx.Map:StartupZoom()
--	local map = self:GetMap (1)
--	map:GotoCurrentZone()
end

--------
-- Main frame update event handler

function Nx.Map:MainOnUpdate (elapsed)

	if self.Created then

		local map = self:GetMap (1)
		local win = map.Win
		local show, showsv = win:IsShown()

--		if not show and GameTooltip:IsOwned (win.Frm) then
--			GameTooltip:Hide()
--		end

		if not show then

			if showsv and not win:IsCombatHidden() then	-- We've been hidden, but not by us (Escape key)?
				win:Show()
				map:RestoreSize()
				return
			end

			self.OnUpdate (map.Frm, elapsed)
		end
	end
end

--------

function Nx.Map:OnWin (typ)

--	Nx.prt ("MapOnWin %s", typ)

	if typ == "SizeNorm" then
		self:RestoreSize()

	elseif typ == "SizeMax" then

		if WorldMapFrame:IsShown() then
			HideUIPanel (WorldMapFrame)
		end
		tinsert (UISpecialFrames, self:GetWinName())

		self:AttachWorldMap()

	elseif typ == "Close" then

	end
end

--------
--

function Nx.Map:AttachWorldMap()

	if not self.GOpts["MapWOwn"] then
		return
	end

	local f = getglobal ("WorldMapButton")
	if f then

--		Nx.prt ("AttachWorldMap")

		self.WorldMapFrm = f
		self.WorldMapFrmParent = f:GetParent()
		self.WorldMapFrmScale = f:GetScale()

		f:SetParent (self.TextFrm)
		f:Show()

		f:EnableMouse (false)

		self:SetWorldMapIcons (.001)

		local tipf = getglobal ("WorldMapTooltip")
		if tipf then
			tipf:SetParent (self.Frm)
		end

		local af = getglobal ("WorldMapFrameAreaFrame")
		if af then
			af:Hide()
--			af:SetParent (self.Frm)
--			af:SetPoint ("TOP", self.Frm, "TOP", 0, 0)
		end

--		Gatherer.MapNotes.MapDraw = function() Nx.prt ("Gath mapdraw") end

		-- Remove leftovers
		for n = 1, NUM_WORLDMAP_POIS do
			local f = getglobal ("WorldMapFramePOI" .. n)
			f:Hide()
		end

		self.WorldMapFrmMapId = 0
	end
end

--------
--

function Nx.Map:DetachWorldMap()

	local f = self.WorldMapFrm

	if f then

--		Nx.prt ("DetachWorldMap")

		self.WorldMapFrm = nil

		f:SetParent (self.WorldMapFrmParent)
		f:SetScale (self.WorldMapFrmScale)
		f:SetPoint ("TOPLEFT", "WorldMapDetailFrame", "TOPLEFT", 0, 0)

		f:EnableMouse (true)

		self:SetWorldMapIcons (1)

		local tipf = getglobal ("WorldMapTooltip")
		if tipf then
			tipf:SetParent (self.WorldMapFrmParent)
			tipf:SetFrameStrata ("TOOLTIP")
		end

		local af = getglobal ("WorldMapFrameAreaFrame")
		if af then
			af:Show()
--			af:SetParent (f)
--			af:SetPoint ("TOP", f, "TOP", 0, -10)
		end

	end
end

--------
-- Update Blizzard world map frame if we grabbed it

function Nx.Map:UpdateWorldMap()

	local f = self.WorldMapFrm
	
	for factionIndex = 1, GetNumFactions() do
		local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)				
		if (name == "Operation: Shieldwall") or (name == "Dominance Offensive") then
			self.MapWorldInfo[6002].Overlay = "krasarang_terrain1"
		end
	end
	
	if f then

		if self.StepTime ~= 0 or self.Scrolling or IsShiftKeyDown() then
			f:Hide()
		else

			local tipf = getglobal ("WorldMapTooltip")
			if tipf then
				tipf:SetFrameStrata ("TOOLTIP")
			end

			local af = getglobal ("WorldMapFrameAreaFrame")
			if af then
				af:SetFrameStrata ("HIGH")
			end

			f:Show()

			self:ClipZoneFrm (self.Cont, self.Zone, f, 1)
			f:SetFrameLevel (self.Level)
			if self.WorldMapFrmMapId ~= self.MapId then

--				Nx.prt ("mapid %s", self.MapId)

				self.WorldMapFrmMapId = self.MapId

				self:SetChildLevels (f, self.Level + 1)

				self.Level = self.Level + 4
			end
		end

		for k, f in ipairs (_G["MAP_VEHICLES"]) do
			f:SetScale (.001)
		end
	end
	if not InCombatLockdown() then	
		self.Arch:DrawNone();
		if Nx.CharOpts["MapShowArchBlobs"] then
			for i = 1, ArchaeologyMapUpdateAll() do
				self.Arch:DrawBlob(ArcheologyGetVisibleBlobID(i), true)	  
			end
			self:ClipZoneFrm( self.Cont, self.Zone, self.Arch, 1 )
			self.Arch:SetFrameLevel(self.Level)		
			self.Arch:SetFillAlpha(255 * self.ArchAlpha)
			self.Arch:SetBorderAlpha( 255 * self.ArchAlpha )		
			self.Arch:Show()
		else
			self.Arch:Hide()
		end
	end
end

--------
-- Hook of UpdateQuestMapPOI, so we can move icons after Blizz updates

--[[

function Nx.Map.UpdateQuestMapPOIHook()

	local self = Nx.Map:GetMap (1)

--	Nx.prt ("UpdateQuestMapPOI hook")

	local f = self.WorldMapFrm
	if f then

		-- Just hide, since we draw ourselves

  		for n = 1, QuestMapUpdateAllQuests() do
			local f = QUEST_MAP_POI[n]
			if f then
				f:Hide()
			end
		end

		for n = 1, #QUEST_MAP_ADDITIONAL_POI do
			QUEST_MAP_ADDITIONAL_POI[n]:Hide()
		end

-- OLD
		if false then
--		if SHOW_QUEST_OBJECTIVES_ON_MAP == "1" then

			local sc = f:GetScale()

			Nx.prt ("WMFrm %s %s %s", f:GetScale(), f:GetLeft(), f:GetRight())

			local numPOI = QuestMapUpdateAllQuests()

			for i = 1, numPOI do
				local pf = QUEST_MAP_POI[i]
				if pf and pf:IsShown() then
					Nx.prt ("QPOI %s %s %s", i, pf["x"], pf["y"])
					pf:SetPoint ("CENTER", f, "TOPLEFT", pf["x"] * sc, pf["y"] * sc)
					pf:SetScale (1 / sc)
--					pf:SetParent (self.TextFrm)
					pf:SetFrameLevel (100)
				end
			end
		end

	end
end

--]]

--------
-- Recursively set child levels

function Nx.Map:SetChildLevels (frm, lvl)

	local ch = { frm:GetChildren() }

	for n, chf in pairs (ch) do

		chf:SetFrameLevel (lvl)

		if chf:GetNumChildren() > 0 then
			self:SetChildLevels (chf, lvl + 1)
		end
	end
end

--------
-- Set scale on world map icons

function Nx.Map:SetWorldMapIcons (scale)

	for n = 1, MAX_PARTY_MEMBERS do
		local f = getglobal ("WorldMapParty" .. n)
		if f then
			f:SetScale (scale)
		end
	end
	for n = 1, MAX_RAID_MEMBERS do
		local f = getglobal ("WorldMapRaid" .. n)
		if f then
			f:SetScale (scale)
		end
	end
	local flags = GetNumBattlefieldFlagPositions()
	for n = 1, flags do
		local f = getglobal ("WorldMapFlag" .. n)
		if f then
			f:SetScale (scale)
		end
	end

	for k, f in ipairs (_G["MAP_VEHICLES"]) do
		f:SetScale (scale)
	end

	for k, name in ipairs (Nx.Map.WorldMapHideNames) do

		local f = getglobal (name)
		if f then
			f:SetScale (scale)
		end
	end

--[[
	for n = 1, QuestMapUpdateAllQuests() do
		local f = QUEST_MAP_POI[n]
		if f then
			f:SetScale (scale)
		end
	end

	for i = 1, #QUEST_MAP_ADDITIONAL_POI do
		QUEST_MAP_ADDITIONAL_POI[i]:Hide();
	end
--]]
end

--------
--

function Nx.Map:OnButZoomIn()
	self:SetScaleOverTime (2)
end

function Nx.Map:OnButZoomOut()
	self:SetScaleOverTime (-2)
end

function Nx.Map:OnButToggleFav (but)
	Nx.Fav:ToggleShow()
end

function Nx.Map:OnButToggleGuide (but)
	self.Guide:ToggleShow()
end

function Nx.Map:OnButToggleWarehouse (but)
	Nx.Warehouse:ToggleShow()
end

--[[
function Nx.Map:OnButToggleQuestGivers (but)
	local guide = self.Guide
	local folder = guide:FindFolder ("Quest Givers")
	guide:AddShowFolders (folder, guide:IsShowFolders (folder))
	guide:Update()
end
--]]

function Nx.Map:OnButToggleCombat (but)
	Nx.Combat:Open()
end

function Nx.Map:OnButToggleEvent (but)
	Nx.UEvents.List:Open()
end

--[[
function Nx.Map:OnButScrollDebug (but, click, x, y)

	x = x * self.DebugAdjustScale
	y = y * self.DebugAdjustScale

	if self["DebugHotspots"] then
		return self:HotspotDebugScroll (x, y)
	end

	local id = self.DebugMapId		-- Double click map to set
	if not id then
		return
	end

	local mode = 2

	if mode == 1 then

		if IsControlKeyDown() then
			x = x * .1 + self.MapWorldInfo[id][1]
			self.MapWorldInfo[id][1] = x
			Nx.prt ("Sc %f", x)
		else

			local info = self.MapWorldInfo[id]

			info[2] = x + info[2]
			info[3] = y + info[3]
			info[4] = x + info[4]
			info[5] = y + info[5]

			info.XOff = x + (info.XOff or 0)
			info.YOff = y + (info.YOff or 0)

			Nx.prt ("XY %f %f, %f %f", info[2], info[3], info.XOff, info.YOff)
		end

	elseif mode == 2 then	-- Minimap data

		local miniT = self:GetMiniInfo (id)
		miniT[5] = x + miniT[5]
		miniT[6] = y + miniT[6]
		Nx.prt ("XY %f %f", miniT[5], miniT[6])
	end

	return true
end

function Nx.Map:OnButScrollDebug2 (but, click, x, y)

	self.DebugAdjustScale = self.DebugAdjustScale + x * .001

	Nx.prt ("Adj scale %s", self.DebugAdjustScale)
end
--]]

--------
-- Init static map frames

function Nx.Map:InitFrames()

	local f = self.Frm
	local m = self

	-- Create map zone tile frames

	self.TileFrms = {}

	local tf

	for i = 1, 12 do

		tf = CreateFrame ("Frame", nil, f)
		m.TileFrms[i] = tf

		local t = tf:CreateTexture()
		t:SetAllPoints (tf)
		tf.texture = t
	end

	-- Init continent frames

	Nx.ContBlks = {
		{ 0,1,1,0, 0,1,1,0, 0,1,1,0 },
		{ 0,1,1,0, 0,1,1,0, 0,1,1,0 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
		{ 1,1,1,0, 1,1,1,0, 1,1,1,0 },
		{ 1,1,1,1, 1,1,1,1, 1,1,1,1 },
	}

	self.ContFrms = {}

	for n = 1, Nx.Map.ContCnt do

		self.ContFrms[n] = {}

		local mapFileName = self.MapInfo[n].FileName

		local texi = 1

--		Nx.prtD ("Map Update ".. mapFileName)

		for i = 1, 12 do

			if Nx.ContBlks[n][i] ~= 0 then

				local cf = CreateFrame ("Frame", nil, f)
				m.ContFrms[n][i] = cf

				local t = cf:CreateTexture()
				t:SetAllPoints (cf)
				cf.texture = t

				if n == 0 then
					t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\Cont\\".."Kal"..texi)
					texi = texi + 1
				else
					t:SetTexture ("Interface\\WorldMap\\"..mapFileName.."\\"..mapFileName..i)
				end
			end
		end
	end

--[[
	local cf = CreateFrame ("Frame", nil, f)
	self.ContFillFrm = cf

	local t = cf:CreateTexture()
	t:SetAllPoints (cf)
	cf.texture = t
--	t:SetTexture (.5, .5, .45, .99)
	t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\HBlend")
	t:SetVertexColor (1, 1, 1, .7)
--]]

	-- Create mini frames

	self.MiniFrms = {}

	for n = 1, self.MiniBlks ^ 2 do

		local tf = CreateFrame ("Frame", nil, f)
		m.MiniFrms[n] = tf

		local t = tf:CreateTexture()
		tf.texture = t
		t:SetAllPoints (tf)
	end

	self:InitHotspots()

--	self:InitHotspotsDebug()
end

--------
-- Init hotspots

function Nx.Map:InitHotspots()

	local quad = {}
	self.WorldHotspots = quad
	local quadCity = {}
	self.WorldHotspotsCity = quadCity

	for contN = 1, Nx.Map.ContCnt do

		cname = self:GetWorldContinentInfo (contN)
		cname = _TRANS(cname)
		if not cname then
			break
		end

		local zoneN = 1

		while true do

			zname, zx, zy, zw, zh = self:GetWorldZoneInfo (contN, zoneN)
			if not zx then
				break
			end

			local mapId = self:CZ2MapId (contN, zoneN)
			local nxz = Nx.MapIdToNxzone[mapId] or 0

--			local zscale = self:GetWorldZoneScale (mapId)

--			Nx.prt ("Hotspot %s+%s %d %s", contN, zoneN, mapId, nxz or "nil")

			local color, infoStr = self:GetMapNameDesc (mapId)
			local tipStr = format ("%s, %s%s (%s)", cname, color, zname, infoStr)

			local loc = Nx.MapWorldHotspots[nxz]	-- Old way
			local locSize = 4

			if not loc then

				loc = Nx.MapWorldHotspots2[mapId]
				if loc then
					locSize = 12
				else
					loc = format ("%c%c%c%c", 85, 85, 135, 135)
				end
			end

			for n = 0, 100 do

				local locN = n * locSize + 1

				local loc1 = strsub (loc, locN, locN + locSize - 1)
				if loc1 == "" then
					break
				end

				local zx, zy, zw, zh

				if locSize == 4 then
					zx, zy, zw, zh = Nx.Quest:UnpackLocRect (loc1)
				else
					zx = tonumber (strsub (loc1, 1, 3), 16) * 100 / 4095
					zy = tonumber (strsub (loc1, 4, 6), 16) * 100 / 4095
					zw = tonumber (strsub (loc1, 7, 9), 16) * 1002 / 4095
					zh = tonumber (strsub (loc1, 10, 12), 16) * 668 / 4095
				end

				local spot = {}

				local wzone = self:GetWorldZone (mapId)

				if wzone.City or wzone.StartZone then
					tinsert (quadCity, spot)
				else
					tinsert (quad, spot)
				end

				spot.MapId = mapId

				local wx, wy = self:GetWorldPos (mapId, zx, zy)
				spot.WX1 = wx
				spot.WY1 = wy
				zw = zw / 1002 * 100
				zh = zh / 668 * 100
				local wx, wy = self:GetWorldPos (mapId, zx + zw, zy + zh)
				spot.WX2 = wx
				spot.WY2 = wy

				spot.NxTipBase = tipStr

--				if contN == 5 then
--					Nx.prtVar ("Spot", spot)
--				end

			end

			zoneN = zoneN + 1
		end
	end

end

--------
-- Init hotspots

--[[

function Nx.Map:InitHotspotsDebug()

	if 1 then return end

	NxData.NXDBHotspotsT = {}
--	NxData.NXDBHotspotsT = NxData.NXDBHotspotsT or {}

	self:InitHotspots2Debug (self.WorldHotspotsCity)
	self:InitHotspots2Debug (self.WorldHotspots)
end

function Nx.Map:InitHotspots2Debug (quad)

	local saved = NxData.NXDBHotspotsT

	for n, spot in ipairs (quad) do

		local mapId = spot.MapId

		if mapId then
--		if mapId ~= 2042 and mapId ~= 2043 then
--		if mapId == 1014 or mapId > 4000 and mapId <= 5999 then

			local x, y = self:GetZonePos (mapId, spot.WX1, spot.WY1)
			local w, h = self:GetZonePos (mapId, spot.WX2, spot.WY2)

			local mapT = saved[mapId] or {}
			saved[mapId] = mapT

			local saveSpot = { X = x, Y = y, W = w - x, H = h - y }
			tinsert (mapT, saveSpot)
		end
	end
end

function Nx.Map:HotspotDebugCmd (cmd)

	if cmd == "add" then

		local curT = self.HotspotDebugCurT
		if curT then
			Nx.prt ("Add")

			local x, y = self:GetZonePos (self.DebugMapId, self.DebugWX or 0, self.DebugWY or 0)
			local spot = { X = x, Y = y, W = 10, H = 10 }
			tinsert (curT, spot)
		end

	elseif cmd == "del" then

		local curT = self.HotspotDebugCurT
		if curT then
			tremove (curT, self.HotspotDebugCurI)
		end
	end
end


function Nx.Map:PackHotspotsDebug()

	local saved = NxData.NXDBHotspotsT

	if saved then

		local cnt = 0

		local packed = {}
		NxData.NXDBHotspotsPacked = packed

		for mapId, mapT in pairs (saved) do

			local s = ""

			for n, spot in ipairs (mapT) do

				local x = min (max (spot.X * 4095 / 100, 0), 4095)
				local y = min (max (spot.Y * 4095 / 100, 0), 4095)
				local w = min (max (spot.W * 4095 / 100, 0), 4095)
				local h = min (max (spot.H * 4095 / 100, 0), 4095)
				s = format ("%s%03x%03x%03x%03x", s, x, y, w, h)

				cnt = cnt + 1
			end

			packed[mapId] = s
		end

		Nx.prt ("Packed %d", cnt)
	end
end

function Nx.Map:UpdateHotspotsDebug()

	local saved = NxData.NXDBHotspotsT or {}
	NxData.NXDBHotspotsT = saved

	local curMapId = self.DebugMapId

	for mapId, mapT in pairs (saved) do

		local zscale = self:GetWorldZoneScale (mapId)

		for n, spot in ipairs (mapT) do

			local f = self:GetIcon (0)

			local x, y = self:GetWorldPos (mapId, spot.X, spot.Y)
			if self:ClipFrameTL (f, x, y, spot.W * zscale, spot.H * zscale / 1.5) then

				f.NXType = 8000
				f.NXData = mapId
				f.NXData2 = n

				if IsControlKeyDown() then
					f.NxTip = format ("%s %d #%d\n%s %s\n%s %s", self:IdToName (mapId), mapId, n, spot.X, spot.Y, spot.W, spot.H)
				end

				if mapId == curMapId then

					if mapT == self.HotspotDebugCurT and n == self.HotspotDebugCurI then
						f.texture:SetTexture (.2, .2, .5, .5)
					else
						f.texture:SetTexture (0, 0, .4, .35)
					end
				else
					f.texture:SetTexture (.1, 0, 0, .3)
				end
			end

--			Nx.prt ("spot #%d %s %s %s %s", n, spot.X, spot.Y, spot.W, spot.H)
		end
	end
end

function Nx.Map:HotspotDebugClick (button)

--	this = self.Frm
	self.OnMouseDown (self.Frm, button)

	local icon = self.ClickFrm
	local mapId = icon.NXData

	if mapId == self.DebugMapId then

		local index = icon.NXData2

		local saved = NxData.NXDBHotspotsT

		self.HotspotDebugCurT = saved[mapId]
		self.HotspotDebugCurI = index

--		local spot = saved[mapId][index]
--		Nx.prt ("spot #%d %s %s %s %s", n, spot.X, spot.Y, spot.W, spot.H)
	end
end

function Nx.Map:HotspotDebugScroll (x, y)

	local curT = self.HotspotDebugCurT

	local spot = curT and curT[self.HotspotDebugCurI]
	if spot then

		x = x * 2
		y = y * 2

		if IsShiftKeyDown() then
			x = x * .05
			y = y * .05
		end

		if not IsAltKeyDown() then

			spot.X = spot.X + x
			spot.Y = spot.Y + y
		else
			spot.W = spot.W + x
			spot.H = spot.H + y
		end

		Nx.prt ("%s spot #%d %s %s %s %s", self.DebugMapId, self.HotspotDebugCurI, spot.X, spot.Y, spot.W, spot.H)

		return true
	end
end

--]]

--------
-- Get description (color) that goes with a map nane

function Nx.Map:GetMapNameDesc (mapId)

--	Nx.prt ("MapId %s", mapId)

	local nxz = Nx.MapIdToNxzone[mapId] or 0
	local _, minLvl, maxLvl, faction = strsplit ("!", Nx.Zones[nxz])
	minLvl = tonumber (minLvl)
	faction = tonumber (faction)

	local infoStr = format ("%d-%d", minLvl, maxLvl)

	local color = "|cffffffff"
	if self.PlFactionNum == faction then
		color = "|cff20ff20"
	elseif faction == 2 then
		color = "|cffffff00"
	elseif faction < 2 then
		color = "|cffff6060"
	end

	if minLvl == 0 then
		infoStr = L["Any"]
	end

	if self:GetWorldZone (mapId).City then
		infoStr = L["City"]
		minLvl = -1
	end

	return color, infoStr, minLvl
end

--------
-- Init minimap ownership

function Nx.Map:MinimapOwnInit()

	self.MMScales = {}

	for n = 1, 6 do
		self.MMScales[n] = (8 - n) * 66.6666666666666 / 5.0
	end

	self.MMScalesC = { 300, 240, 180, 120, 80, 50 }

	for n = 1, 6 do
		self.MMScalesC[n] = self.MMScalesC[n] / 5.0
	end

	--

	local mm = self.MMFrm
	local mmc = getglobal ("MinimapCluster")

	-- Reset since this seems to be getting remembered
	mm:SetMaskTexture ("textures\\MinimapMask")

	self:MinimapNodeGlowInit()

	-- Commom data for map and dock

	self.MMChkDelay = 5		-- Prevent crash here
	self.MMOwnedFrms = {}

	--

	if not self.MMOwn then
		self.Win:Show (self.StartupShown)
		Nx.Map:MinimapButtonShowUpdate()
		return
	end

	Nx.Map:MinimapButtonShowUpdate (true)

--	self.Win:RegisterEvent ("MINIMAP_UPDATE_ZOOM", self.OnEvent)

	mm:SetClampedToScreen (true)
	mm:SetWidth (140)
	mm:SetHeight (140)
	self.MMAlphaDelay = 100

	mm:SetParent (self.Frm)
    self.MMFrm:SetQuestBlobRingAlpha(1)
	self.MMFrm:SetPOIArrowTexture("")
	mm:SetScript ("OnMouseDown", self.MinimapOnMouseDown)
	mm:SetScript ("OnMouseUp", self.MinimapOnMouseUp)
	mm:SetScript ("OnEnter", self.MinimapOnEnter)
	mm:SetScript ("OnLeave", self.MinimapOnLeave)

--	local prtFrameChildren = Nx.prtFrameChildren
--	prtFrameChildren ("Minimap", mm)
--	prtFrameChildren ("MinimapCluster", mmc)

--[[
	local mmsf = CreateFrame ("ScrollFrame", nil, self.Frm)
	self.MMScFrm = mmsf

	mm:SetParent (mmsf)

	mmsf:SetAllPoints (self.Frm)
--	mmsf:SetScrollChild (mm)
--]]

	-- Ping

--[[	--V4
	local ping = MinimapPing
	ping:SetParent (UIParent)

	self.MMOwnedFrms[ping] = 0
--]]

	-- Data setup

	self.MMModels = {}
	self.MMAddonFrms = {}

	local f = getglobal ("MinimapBackdrop")
	if f then
		f:Hide()
		f:SetParent (mmc)
	end

	hooksecurefunc ("Minimap_ZoomIn", Nx.Map.Minimap_ZoomInClick)
	hooksecurefunc ("Minimap_ZoomOut", Nx.Map.Minimap_ZoomOutClick)

-- Dont work anymore
--	hooksecurefunc ("Minimap_ZoomInClick", Nx.Map.Minimap_ZoomInClick)
--	hooksecurefunc ("Minimap_ZoomOutClick", Nx.Map.Minimap_ZoomOutClick)
--	hooksecurefunc ("MinimapPing_OnEvent", Nx.Map.Minimap_OnEvent)
end

function Nx.Map.Minimap_ZoomInClick()
	local map = Nx.Map:GetMap (1)
	map:MinimapZoom (2)
end

function Nx.Map.Minimap_ZoomOutClick()
	local map = Nx.Map:GetMap (1)
	map:MinimapZoom (-2)
end

function Nx.Map.Minimap_OnEvent()

--	Nx.prt ("Minimap_OnEvent %s", arg1 or "nil")

	local map = Nx.Map:GetMap (1)
	map:MinimapZoom()
end

function Nx.Map:MinimapZoom (value)

--	Nx.prt ("MinimapZoom %s", value)

	if value then
		self:SetScaleOverTime (value)
	end

	local f = getglobal ("MinimapZoomIn")
	if f then
		f:Enable()
	end

	local f = getglobal ("MinimapZoomOut")
	if f then
		f:Enable()
	end
end

function Nx.Map:MinimapOnMouseDown (button)
--	Nx.prt ("click %s", button)

	local this = self			--V4

	local map = Nx.Map.Maps[1]

	if (map.MMZoomType == 0 and button == "LeftButton") or
			(IsShiftKeyDown() and not IsControlKeyDown()) then
		this.NXPing = true
	else
		this.NXPing = nil

		this.NxMap = map
		map.OnMouseDown (this, button)
	end
end

function Nx.Map:MinimapOnMouseUp (button)
--	Nx.prt ("click %s", button)

	local this = self			--V4

	local map = Nx.Map.Maps[1]

	if this.NXPing then
		if map.MMZoomType == 0 then
			Minimap_OnClick (this)
		else
			map:Ping()
		end

	else
		this.NxMap = map
		map.OnMouseUp (this, button)
	end
end

function Nx.Map:Ping()

	local frm = self.Frm
	local mx, my = Nx.Util_GetMouseClampedXY (frm)
	local top = frm:GetTop()
	local bottom = frm:GetBottom()
	my = top - (my + bottom)

	local mm = self.MMFrm

	local scales = self.MMScales
	local info = self.MapWorldInfo[self.MapId]

	if info.City and not info.MMOutside then
		scales = self.MMScalesC
	end

	local zoom = mm:GetZoom() + 1

	local wx, wy = self:FramePosToWorldPos (mx, my)

	local sc = scales[zoom] / mm:GetWidth()
	local x = wx - self.PlyrX
	local y = self.PlyrY - wy

--	Nx.prt ("Ping %f %f %f %f", x, y, sc, mm:GetScale())
--	Nx.prt (" Sc %f, W %f", scales[zoom], mm:GetWidth())

	mm:PingLocation (x / sc, y / sc)
end

function Nx.Map:MinimapOnEnter (motion)

	local map = Nx.Map.Maps[1]
	if map.MMZoomType ~= 0 then
		local this = self			--V4
		this.NxMap = map
		map.IconOnEnter (self, motion)
	end
end

function Nx.Map:MinimapOnLeave (motion)

	local map = Nx.Map.Maps[1]
	if map.MMZoomType ~= 0 then
		local this = self			--V4
		this.NxMap = map
		map.IconOnLeave (self, motion)
	end
end

function Nx.Map:MinimapButtonShowUpdate (justNameplate)

	local opts = Nx:GetGlobalOpts()
	local t = {
		"MinimapCluster", "MapMMShowOldNameplate",
		"NXMiniMapBut", "MapMMButShowCarb",
		"GameTimeFrame", "MapMMButShowCalendar",
		"TimeManagerClockButton", "MapMMButShowClock",
		"MiniMapWorldMapButton", "MapMMButShowWorldMap",
	}

	for n = 1, #t, 2 do

		local skip

		if Nx.Free then
			if t[n] == "MinimapCluster" then
				skip = true
			end
		end

		if not skip then

			local f = getglobal (t[n])
			if f then
				if opts[t[n + 1]] then
					f:Show()
				else
					f:Hide()
				end
			end
		end

		if justNameplate then
			break
		end
	end
end

--------
-- Init minimap node glow. Also called by options

function Nx.Map:MinimapNodeGlowInit (reset)

	local mm = self.MMFrm

	Nx.Timer:Stop ("MapNodeGlow")

	if reset then
		mm:SetBlipTexture ("Interface\\Minimap\\objecticons")
	end

	local delay = self.GOpts["MapMMNodeGD"]

	if delay > 0 then

		if not self.MMGlowInited then

			self.MMGlowInited = true

			-- Force blip textures to stay in mem, so minimap does not show corruption when switching

			local t = mm:CreateTexture (nil, "BACKGROUND")
			t:SetAllPoints()
			t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\MMOIcons")
			t:Hide()
			local t = mm:CreateTexture (nil, "BACKGROUND")
			t:SetAllPoints()
			t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\MMOIconsG")
			t:Hide()
		end
		
		Nx.Timer:Start ("MapNodeGlow", .1, self, self.OnMinimapNodeGlowTimer)
	end
end

function Nx.Map:OnMinimapNodeGlowTimer (name)

	self:MinimapNodeGlowSet ("")

	Nx.Timer:SetFunc (name, self.OnMinimapNodeGlowTimerG)

	return self.GOpts["MapMMNodeGD"] * 2
end

function Nx.Map:OnMinimapNodeGlowTimerG (name)

	self:MinimapNodeGlowSet ("G")

	Nx.Timer:SetFunc (name, self.OnMinimapNodeGlowTimer)

	return self.GOpts["MapMMNodeGD"] * 2
end

function Nx.Map:MinimapNodeGlowSet (letter)

	local count = GetNumTrackingTypes()	
	for n = 1, count do 
		local name, texture, active, category = GetTrackingInfo (n)

		if active and category == "spell" then
				self.MMFrm:SetBlipTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\MMOIcons" .. letter)
			break
		end
	end
end

--------
--

function Nx.Map:MinimapUpdate()

	if not self.MMOwn then
		self:MinimapDetachFrms()
		return
	end

	--

	if self.GOpts["MapMMMoveCapBars"] then

		local y = 0

		for n = 1, NUM_EXTENDED_UI_FRAMES do

			local f = getglobal ("WorldStateCaptureBar" .. n)
			if f and f:IsShown() then

--				Nx.prtFrame ("WorldState", f)

				f:SetPoint ("TOPRIGHT", self.Win.Frm, "BOTTOMRIGHT", 0, y)
				y = y + f:GetHeight()
			end
		end
	end

	--

	if self.DebugScale then
		self.MMScale = 0
		local sc = self.DebugScale

		for n = 1, 6 do
			self.MMScales[n] = (8 - n) * 66.6666666666666 / sc
		end
	end

	--

	local mm = self.MMFrm
	local lOpts = self.LOpts

	local scales = self.MMScales
	local info = self.MapWorldInfo[self.RMapId]

	if info.City and not info.MMOutside then
		scales = self.MMScalesC
	end

	local zoomType = 0
	local zoom = mm:GetZoom (1)

	local dock = lOpts.NXMMFull or self.GOpts["MapMMDockAlways"]

	if self.Win:IsSizeMax() and self.GOpts["MapMMDockOnMax"] then
		dock = true
	end

	if not dock and not self.InstanceId
			and self.ScaleDraw > lOpts.NXMMDockOnAtScale then

		mm:ClearAllPoints()

		for n = 1, 6 do

			local sz = scales[n]

			if self:ClipMMW (mm, self.PlyrX, self.PlyrY, sz, sz) then
--				Nx.prt ("MM #%d sz %d", n, sz)
				zoomType = n
--				self.MMSize = sz * self.ScaleDraw
				break
			end
		end
	end

	local al = lOpts.NXMMAlpha

	local indoors = IsIndoors()
	local resting = IsResting()
	local indoorChange = self.Indoors ~= indoors
	self.Indoors = indoors
    local bugged = false
    local bugtest = GetSubZoneText()  	  
    for _,zonetest in ipairs(Nx.BuggedAreas) do        
		if GetCurrentMapAreaID() == zonetest and not indoors then	  
			bugged = true
		end
	end
	for _,zonetest in ipairs(Nx.BuggedSubZones) do    
		if bugtest == zonetest then	  
			bugged = true
		end
	end
	if self.InstanceId then
		al = 1
	else
		if indoors and self.GOpts["MapMMDockIndoors"] then
			zoomType = 0
		end
		if bugged and self.GOpts["MapMMDockBugged"] then
			zoomType = 0
		end
		if indoorChange and self.GOpts["MapMMIndoorTogFullSize"] then
			lOpts.NXMMFull = false
			if not info.City and indoors then
				lOpts.NXMMFull = true
			end
			self.MMMenuIFull:SetChecked (lOpts.NXMMFull)
			Nx.Menu:CheckUpdate (self.MMMenuIFull)
		end
		if self.GOpts["MapMMBuggedTogFullSize"] then
			if bugged then
				lOpts.NXMMFull=true
			else
				lOpts.NXMMFull=false
			end
			self.MMMenuIFull:SetChecked(lOpts.NXMMFull)
			Nx.Menu:CheckUpdate(self.MMMenuIFull)	    	  
		end
		if zoomType == 0 then
			al = 1
		end

		if IsControlKeyDown() then
			al = IsAltKeyDown() and 1 or .8
			self.MMZoomChanged = true
		end
	end

	if self.MMZoomType ~= zoomType or zoomType > 0 and self.MMScale ~= self.ScaleDraw
			or indoorChange then

		self.MMZoomType = zoomType
		self.MMScale = self.ScaleDraw

		self.MMZoomChanged = true

--		Nx.prt ("MMZoomChanged")

		if self.MMAlphaDelay == 0 then
--		if zoomType == 0 and self.MMAlphaDelay == 0 then
			self.MMAlphaDelay = 2
		end
	end

	if self.MMAlphaDelay > 0 then
		self.MMAlphaDelay = self.MMAlphaDelay - 1
--		al = 1
--		Nx.prt ("MMAFix %s", self.MMAlphaDelay)
		self.MMZoomChanged = true
	end

	mm:SetAlpha (al)

	self:MinimapDetachFrms()

	if zoomType > 0 then

		self:MinimapUpdateMask ("MapMMSquare")

		local above = IsControlKeyDown()

		if self.GOpts["MapMMAboveIcons"] then
			above = not above
		end

		local lvl = self.Level
		if above then
			lvl = lvl + 15
		end

		mm:SetFrameLevel (lvl)

		self:MinimapUpdateDetachedFrms (lvl + 1)
		self.Level = self.Level + 2

	else

		local sc = self.MMFScale

		self.MMFScale = Nx.InBG and lOpts.NXMMDockScaleBG or lOpts.NXMMDockScale

		if lOpts.NXMMFull then
			self.MMFScale = min (self.MapW, self.MapH) / 140
		end
	end

--[[
	local mmsf = self.MMScFrm

	mmsf:SetScrollChild (mm)
	mmsf:UpdateScrollChildRect()

	mmsf:SetFrameLevel (self.Level)
--]]

end

function Nx.Map:MinimapUpdateEnd()

	if not self.MMOwn then
		return
	end

	local mm = self.MMFrm
	local mmfull = self.LOpts.NXMMFull

	if self.Win:IsSizeMax() and self.GOpts["MapMMHideOnMax"] or self.MMFScale < .02 then

		mm:SetPoint ("TOPLEFT", 1, 0)
		mm:SetScale (.02)
		mm:SetFrameLevel (1)
--		mm:Hide()

		for n, f in ipairs (self.MMModels) do
			f:SetScale (.001)
		end
		return
	end

	if self.MMZoomType == 0 then

		self:MinimapUpdateMask ("MapMMDockSquare")

		local iconScale = self.GOpts["MapMMDockIScale"]

		self:MinimapSetScale (self.MMFScale, iconScale)
--		mm:SetScale (self.MMFScale)

		local x = 0
		local y = 0
		local sz = 140 * self.MMFScale

		if self.GOpts["MapMMDockRight"] then
			x = (self.MapW - sz + 1)
		end
		if self.GOpts["MapMMDockBottom"] then
			y = (self.MapH - sz + 1)
		end

		mm:ClearAllPoints()
		mm:SetPoint ("TOPLEFT", (x + self.GOpts["MapMMDXO"]) / iconScale,
										(-y - self.GOpts["MapMMDYO"]) / iconScale)
		mm:Show()

		mm:SetFrameLevel (self.Level)
		self:MinimapUpdateDetachedFrms (self.Level + 1)
		self.Level = self.Level + 2
	end

	if self.MMZoomChanged then

		self.MMZoomChanged = false

		local zoom = max (self.MMZoomType - 1, 0)

		if self.MMZoomType == 0 then
			zoom = self.GOpts["MapMMDockZoom"]
		end

		local z = zoom - 1
		if z < 0 then
			z = 1
		end

		-- Force icon update
		mm:SetZoom (z)
		mm:SetZoom (zoom)

--		Nx.prt ("zoom %d", zoom)

		if self.MMZoomType == 0 then
			mm:SetAlpha (1)
		end

--		if Gatherer then
--			Nx.Timer:Start ("Gatherer", .1, self, self.OnGathererTimer)
--		end
	end

	-- Transfer window and minimap scale

	--V4 gone TEST!!!!!!!!!
--	MinimapPing:SetScale (self.Win.Frm:GetScale() * mm:GetScale())
end

function Nx.Map:MinimapSetScale (scale, iconScale)

	local mm = self.MMFrm
	local sz = 140 * scale / iconScale
	mm:SetWidth (sz)
	mm:SetHeight (sz)
	mm:SetScale (iconScale)
end

function Nx.Map:MinimapUpdateMask (optName)

	local name = self.GOpts[optName] and "Interface\\Buttons\\White8x8" or "textures\\MinimapMask"

--	if IsControlKeyDown() then
--		self.MMMaskName = nil
--	end

	if self.MMMaskName ~= name then
		self.MMMaskName = name

		local mm = self.MMFrm
		mm:SetMaskTexture (name)

--		Nx.prt ("MMmask %s", name)
	end

	local name = self.MMZoomType == 0 and "Interface\\Minimap\\MinimapArrow" or ""	
	if self.MMArrowName ~= name then
		self.MMArrowName = name		
		if (name ~= "") then
    		self.MMFrm:SetPlayerTexture (name)
		end
	end
end

--[[
function Nx.Map.OnGathererTimer()

	Nx.prt ("Gatherer update")

	local mn = Gatherer["MiniNotes"]
	if mn then
		local update = mn["ForceUpdate"]
		if update then
			update()
		end
	else
		Nx.prt ("no mn")
	end
end
--]]

function Nx.Map:MinimapDetachFrms()

	local mm = self.MMFrm
	local mmc = getglobal ("MinimapCluster")
	local winf = self.Win.Frm
	local dock = Nx.Map.Dock

	if dock.InitPending then
		return
	end

	self.MMChkDelay = self.MMChkDelay - 1

	if self.MMChkDelay < 1 then

		self.MMChkDelay = 40		-- Reset

		-- Find and own any minimap child windows

		local mmNames = self.AddonMinimapNames
		local ch = { mm:GetChildren() }

		for n = 1, #ch do

			local c = ch[n]
			if c ~= mmc then

--				if not c:IsVisible() then
--					Nx.prt ("MM Frm v0 %s", c:GetName() or "nil")
--				end

				if c:IsShown() and not self.MMOwnedFrms[c] then

					if c:IsObjectType ("Model") then
--						Nx.prt ("MM Model %s", c:GetName() or "nil")

						if self.MMOwn then

							c:SetParent (winf)
							self.MMOwnedFrms[c] = 0
							tinsert (self.MMModels, c)
						end

					elseif c:IsObjectType ("Frame") then

						local name = gsub (c:GetName() or "", "%d", "")

						if mmNames[name] then

							if self.MMOwn then
								self.MMOwnedFrms[c] = 0
								self.MMAddonFrms[c] = 1
							end

						elseif dock.MMFrms then

							self.MMOwnedFrms[c] = 0
							tinsert (dock.MMFrms, c)

--							Nx.prt ("MM Frm %s #%s", c:GetName() or "nil", c:GetNumChildren())
--							Nx.prtFrameChildren (c:GetName() or "nil", c)

							if c:GetNumChildren() > 0 then

								local ch = { c:GetChildren() }
								for k, c in ipairs (ch) do

--									if not c:IsShown() then
--										Nx.prt ("MM Frm v0 %s", c:GetName() or "nil")
--									end

									if c:IsShown() then
										if c:IsObjectType ("Frame") then
											local pt, relTo = c:GetPoint()
											if relTo == mm then
												tinsert (dock.MMFrms, c)
--												Nx.prt ("MMCC %s", c:GetName())
											end
										end
									end
								end
							end

						end
					end
				end
			end
		end
	end

	--

	dock:MinimapDetachFrms()
end

function Nx.Map:MinimapUpdateDetachedFrms (lvl)

--	self:MinimapDetachFrms()

	local sc = self.MMFScale
	local arrowsc = sc
	local msc = min (1 / sc, 1) * .5

	if Nx.InBG then
		arrowsc = .001
	end

	local mmplyr = Nx.Map.MinimapPlyrModel		-- Old

	for n, f in ipairs (self.MMModels) do

		if f:IsShown() then

			f:SetFrameLevel (lvl)

			local name = f:GetModel()

			if name == "interface\\minimap\\ping\\minimapping.m2" then
				f:SetScale (sc)
				f:SetModelScale (msc)
				f:SetAlpha (1)

			elseif f == mmplyr then
				if self.MMZoomType == 0 then
					f:SetScale (max (.4, min (.9, sc)) * self.GOpts["MapPlyrArrowSize"] / 28)
--					f:SetModelScale (min (.2, sc))
					f:SetModelScale (1)
				else
					f:SetScale (.1)
					f:SetModelScale (1)
				end
			else
				f:SetScale (arrowsc)
				f:SetModelScale (msc)
			end
--[[
			if IsAltKeyDown() then
				Nx.prt ("Model %s (%s %s)", f:GetModel() or "", f:GetScale(), f:GetModelScale())
			end
--]]
		end
	end

	for f, v in pairs (self.MMAddonFrms) do
		f:SetFrameLevel (lvl)
--		f:SetScale (sc)
--		f:SetModelScale (msc)
	end
end

--------

function Nx.Map:Menu_OnGoto (item)
	self:SetTargetAtClick()
end

function Nx.Map:Menu_OnClearGoto (item)
	self:ClearTargets()
	self.Guide:ClearAll()
end

function Nx.Map:Menu_OnAddNote()
	local wx, wy = self:FramePosToWorldPos (self.ClickFrmX, self.ClickFrmY)
	local zx, zy = self:GetZonePos (self.MapId, wx, wy)
	self:AddNote ("?", self.MapId, zx, zy)
end

function Nx.Map:AddNote (name, id, x, y)
	Nx.Fav:Record ("Note", name, id, x, y)
end

function Nx.Map:Menu_OnMonitorZone (item)
	Nx.Com:MonitorZone (self.MenuMapId, item:GetChecked())
end

function Nx.Map:Menu_OnScaleSave()
	self.CurOpts.NXScaleSave = self.Scale
end

function Nx.Map:Menu_OnScaleRestore()
	local s = self.CurOpts.NXScaleSave
	if s then
		self.Scale = s
		self.RealScale = s
		self.StepTime = 10
	else
		Nx.prt (L["Scale not set"])
	end
end

function Nx:NXMapKeyScaleRestore()
	local map = self.Map:GetMap (1)
	map:Menu_OnScaleRestore()
end

function Nx.Map:Menu_OnPlyrFollow (item)
	self.CurOpts.NXPlyrFollow = item:GetChecked()
end

function Nx.Map:Menu_OnShowWorld (item)
	self.CurOpts.NXWorldShow = item:GetChecked()
end

function Nx.Map:Menu_OnShowPlayerZone()
	self:GotoCurrentZone()
end

function Nx.Map:Menu_OnShowKills (item)
	self.KillShow = item:GetChecked()
end

function Nx.Map:Menu_OnDetailAlpha (item)
	self.LOpts.NXDetailAlpha = item:GetSlider()
end

function Nx.Map:Menu_OnBackgndAlphaFade (item)
	self.BackgndAlphaFade = item:GetSlider()
end

function Nx.Map:Menu_OnArchAlpha (item)
	self.ArchAlpha = item:GetSlider()
end

function Nx.Map:Menu_OnQuestAlpha (item)
	self.QuestAlpha = item:GetSlider()
end

function Nx.Map:Menu_OnBackgndAlphaFull (item)
	self.BackgndAlphaFull = item:GetSlider()
end

function Nx.Map:Menu_OnDotZoneScale (item)
	self.DotZoneScale = item:GetSlider()
end

function Nx.Map:Menu_OnDotPalScale (item)
	self.DotPalScale = item:GetSlider()
end

function Nx.Map:Menu_OnDotPartyScale (item)
	self.DotPartyScale = item:GetSlider()
end

function Nx.Map:Menu_OnDotRaidScale (item)
	self.DotRaidScale = item:GetSlider()
end

function Nx.Map:Menu_OnIconScale (item)
	self.IconScale = item:GetSlider()
end

function Nx.Map:Menu_OnIconNavScale (item)
	self.IconNavScale = item:GetSlider()
end

function Nx.Map:Menu_OnOptions (item)
	Nx.Opts:Open ("Map")
end

-- Debug sub menu

function Nx.Map:Menu_OnMapDebugFullCoords (item)
	self.DebugFullCoords = item:GetChecked()
end

function Nx.Map:Menu_OnQuestDebug (item)
	Nx.Quest.Debug = item:GetChecked()
end

-- Plyr icon menu

function Nx.Map:Menu_OnWhisper()

	for _, name in pairs (Nx.Map.PlyrNames) do

		local box = ChatEdit_ChooseBoxForSend()
		ChatEdit_ActivateChat (box)
		box:SetText ("/w " .. name .. " " .. box:GetText())
--[[
		local frm = DEFAULT_CHAT_FRAME
		local eb = frm["editBox"]
		if not eb:IsVisible() then
			ChatFrame_OpenChat ("/w " .. name, frm)
		else
			eb:SetText ("/w " .. name .. " " .. eb:GetText())
		end
--]]
		break
	end
end

-- Plyr icon menu

function Nx.Map:Menu_OnInvite()

	for _, name in pairs (Nx.Map.PlyrNames) do
		InviteUnit (name)
		break
	end
end

function Nx.Map:Menu_OnGetQuests (item)

	for _, name in pairs (Nx.Map.PlyrNames) do
		Nx.Quest:GetFromPlyr (name)
		break
	end
end

function Nx.Map:Menu_OnTrackPlyr (item)

	for _, name in pairs (Nx.Map.PlyrNames) do
		self.TrackPlyrs[name] = true
	end
end

function Nx.Map:Menu_OnRemoveTracking (item)

	for _, name in pairs (Nx.Map.PlyrNames) do
		self.TrackPlyrs[name] = nil
	end
end

function Nx.Map:Menu_OnReportPlyrAFK (item)
	local n = 0
	for k, v in pairs (Nx.Map.AFKers) do
		ReportPlayerIsPVPAFK (v)
		n = n + 1
	end
	Nx.prt (L["%d reported"], n)
end

--[[
function Nx.Map:Menu_OnReportAllAFK (item)

	local members = MAX_PARTY_MEMBERS
	local unitName = "party"

	if IsInRaid() > 0 then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
	end

	local cnt = 0

	for i = 1, members do

		local unit = unitName..i

		if not UnitIsUnit (unit, "player") then
			ReportPlayerIsPVPAFK (unit)
			cnt = cnt + 1
		end
	end

	Nx.prt ("%d reported", cnt)
end
--]]

function Nx.Map:Menu_OnGrowConflictBars (item)
	self.BGGrowBars = item:GetChecked()
end

function Nx.Map:GMenuOpen (icon, typ)

	self.GIconMenuITogInst:Show (false)
	self.GIconMenuIFindNote:Show (false)

	if typ == 3000 then
		if icon.UData then
			self.GIconMenuITogInst:Show()
		end

		if icon.FavData1 then
			self.GIconMenuIFindNote:Show()
		end
	end

	Nx.Quest:OpenGiverIconMenu (icon, typ)

	self.GIconMenu:Open()
end

--------
-- Instance icon

function Nx.Map:GMenu_OnTogInst()

	local icon = self.ClickIcon

	local mapId = icon.UData

	if mapId then
		if self.InstMapId == mapId then
			self:SetInstanceMap()
		else
			local atlas = _G["AtlasMaps"]

--			Nx.prt ("%s", mapId)

			if not (Nx.Map.InstanceInfo[mapId] or atlas) then
				UIErrorsFrame:AddMessage (L["This instance map requires the Atlas addon be installed"], 1, .1, .1, 1)
				return
			end

			self:SetInstanceMap (mapId)
		end
	end
end

--------
-- Favorite icon

function Nx.Map:GMenu_OnFindNote()
	Nx.Fav:ShowIconNote (self.ClickIcon)
end

--------
-- Generic icon goto

function Nx.Map:GMenu_OnGoto()

	Nx.Quest.Watch:ClearAutoTarget()

	if self.ClickType == 3001 then
		Nx.Social:GotoPunk (self.ClickIcon)

	else
		local icon = self.ClickIcon
		local x = icon.X
		local y = icon.Y
		local name = icon.Tip and strsplit ("\n", icon.Tip) or ""

		self:SetTarget ("Goto", x, y, x, y, false, 0, name)
	end
end

--------
-- Generic icon goto

function Nx.Map:GMenu_OnPasteLink()

	local name

	if self.ClickType == 3001 then
		name = Nx.Social:GetPunkPasteInfo (self.ClickIcon)
	else
		local icon = self.ClickIcon
		name = gsub (icon.Tip, "\n", ", ")
	end

	name = gsub (name, "|cff......", "")
	name = gsub (name, "|r", "")

	local frm = DEFAULT_CHAT_FRAME
	local eb = frm["editBox"]
	if eb:IsVisible() then
		eb:SetText (eb:GetText() .. name)
	else
		Nx.prt (L["No edit box open!"])
	end
end

--------
-- Send BG messages

function Nx.Map:BGMenu_OnIncoming (item)
	self:BGMenu_Send (NXlBGMsgIncoming)
end

function Nx.Map:BGMenu_OnClear (item)
	self:BGMenu_Send ("Clear")
end

function Nx.Map:BGMenu_OnHelp (item)
	self:BGMenu_Send ("Help")
end

function Nx.Map:BGMenu_OnAttack (item)
	self:BGMenu_Send ("Attack")
end

function Nx.Map:BGMenu_OnGuard (item)
	self:BGMenu_Send ("Guard")
end

function Nx.Map:BGMenu_OnLosing (item)
	self:BGMenu_Send ("Losing")
end

--------
-- BG icon status

function Nx.Map:BGMenu_OnStatus (item)

	local id, x, y, str = strsplit ("~", self.BGMsg)
	if id == "1" then
		self:BGMenu_Send()
--		SendChatMessage (str, "BATTLEGROUND")
	else
		Nx.prt (L["No Status"])
	end
end

--------
-- BG icon status

function Nx.Map:BGMenu_Send (msg)

	local id, tx, ty, str = strsplit ("~", self.BGMsg)
	tx, ty = self:GetWorldPos (self.RMapId, tonumber (tx), tonumber (ty))

	local members = MAX_PARTY_MEMBERS
	local unitName = "party"

	if IsInRaid() then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
	end

	local cnt = 0
	local maxDist = (100 / 4.575) ^ 2	-- Yards to world space squared

	for i = 1, members do

		local unit = unitName..i
		local pX, pY = GetPlayerMapPosition (unit)

		if (pX > 0 or pY > 0) and not UnitIsDeadOrGhost (unit) then

			local x, y = self:GetWorldPos (self.RMapId, pX * 100, pY * 100)
			local dist = (tx - x) ^ 2 + (ty - y) ^ 2

--			Nx.prt ("%s %s %s = %s", unit, pX, pY, sqrt (dist) * 4.575)

			if dist <= maxDist then
				cnt = cnt + 1
--				Nx.prt (" %s", UnitName (unit))
			end
		end
	end

	local dstr = L[", No "]
	if cnt > 0 then
		dstr = format (", %d ", cnt)
	end

	dstr = dstr .. Nx.Map.PlFactionShort .. L[" in area"]

	if msg then
		SendChatMessage (msg .. " - " .. str .. dstr, "INSTANCE_CHAT")
	else
		SendChatMessage (str .. dstr, "INSTANCE_CHAT")
	end

--	Nx.prt ("count %d", cnt)
--	Nx.prt (msg .. " - " .. str .. dstr)
end

function Nx.Map:BGIncSendTimer()

	local str = format (L["Inc %s"], self.BGIncNum)
	self:BGMenu_Send (str)

	self.BGIncNum = 0

--	Nx.prt ("BGIncSendTimer %s", str)
end

--------
-- Override blizz BC map toggle

function ToggleWorldMap()

--	Nx.prt ("ToggleWorldMap")

	local opts = Nx:GetGlobalOpts()

	if Nx.Map.BlizzToggling or WorldMapFrame:IsShown() or IsAltKeyDown() or not opts["MapMaxOverride"] then
		Nx.Map:BlizzToggleWorldMap()
	else
		Nx.Map:ToggleSize()
	end
end

--------
-- Override blizz WotLK frame toggle

function ToggleFrame (frame)

	if frame ~= WorldMapFrame then
		if frame:IsShown() then
			HideUIPanel (frame)
		else
			ShowUIPanel (frame)
		end
		return
	end

--	Nx.prt ("ToggleWorldMap")

	local opts = Nx:GetGlobalOpts()

	if Nx.Map.BlizzToggling or WorldMapFrame:IsShown() or IsAltKeyDown() or not opts["MapMaxOverride"] then
		Nx.Map:BlizzToggleWorldMap()
	else
		Nx.Map:ToggleSize()
	end
end

--------
-- Hook
--[[
function Nx.Map.ToggleWorldMapHook()

	Nx.prt ("ToggleWorldMapHook")

	if 1 then return end

	local self = Nx.Map:GetMap (1)
	local ismax = self.Win:IsSizeMax()

	if ismax then

		Nx.prt ("ToggleWorldMapHook Max")

--		HideUIPanel (WorldMapFrame)
		self:RestoreSize()
--		return
	end

	if IsAltKeyDown() or Nx.Map.BlizzToggling then
		Nx.prt ("ToggleWorldMapHook Alt or Tog")
	else

		if WorldMapFrame:IsShown() then

			HideUIPanel (WorldMapFrame)

			if not ismax then
				self:ToggleSize()
			end
		end
	end
end
--]]

--------
-- Blizz map toggle

function Nx.Map:BlizzToggleWorldMap()

	if WorldMapFrame:IsShown() then
		HideUIPanel (WorldMapFrame)
	else
		local map = self:GetMap (1)
		map:DetachWorldMap()
		ShowUIPanel (WorldMapFrame)
	end
end

--------
-- Key binding toggle map size. Open blizz map
-- global func

function Nx:NXMapKeyTogOriginal()

	-- Does not get called when map fullscreen

	Nx.Map.BlizzToggling = true
	ToggleWorldMap()
	Nx.Map.BlizzToggling = nil
end

--------
-- Key binding toggle map size
-- global func

function Nx:NXMapKeyTogNormalMax()
	Nx.Map:ToggleSize()
end

--------
-- Key binding toggle map size
-- global func

function Nx:NXMapKeyTogNoneMax()
	Nx.Map:ToggleSize (1)
end

--------
-- Key binding toggle map size
-- global func

function Nx:NXMapKeyTogNoneNormal()
	Nx.Map:ToggleSize (0)
end

--------
-- Toggle map size
-- global func

function Nx.Map:ToggleSize (szmode)

	if not self.Maps then	-- Healbot called ToggleFrame on load that caused us to fail in GetMap
		return
	end

	local map = self:GetMap (1)
	local win = map.Win

	if not win:IsShown() then
		win:Show()

		if szmode == 0 then
			MapBarFrame:SetParent("WorldMapFrame")
			WorldMapPlayerLower:SetAlpha(1)
			WorldMapPlayerUpper:SetAlpha(1)		
			map:RestoreSize()

		elseif szmode == 1 then
			MapBarFrame:SetParent(win.Frm)				
			MapBarFrame:SetFrameLevel(win.Frm:GetFrameLevel() + 10)		
			WorldMapPlayerLower:SetAlpha(0)
			WorldMapPlayerUpper:SetAlpha(0)
			map:MaxSize()

		elseif self.GOpts["MapMaxCenter"] then
			MapBarFrame:SetParent(win.Frm)				
			MapBarFrame:SetFrameLevel(win.Frm:GetFrameLevel() + 10)		
			WorldMapPlayerLower:SetAlpha(0)
			WorldMapPlayerUpper:SetAlpha(0)
			map:MaxSize()
		end

	elseif szmode then
		win:Show (false)

	elseif not win:IsSizeMax() then
		MapBarFrame:SetParent(win.Frm)				
		MapBarFrame:SetFrameLevel(win.Frm:GetFrameLevel() + 10)	
		WorldMapPlayerLower:SetAlpha(0)
		WorldMapPlayerUpper:SetAlpha(0)	
		map:MaxSize()

	else
		MapBarFrame:SetParent("WorldMapFrame")
		WorldMapPlayerLower:SetAlpha(1)
		WorldMapPlayerUpper:SetAlpha(1)	
		map:RestoreSize()
	end

	if Nx.TooltipOwner == win.Frm then
		GameTooltip:Hide()
		Nx.TooltipOwner = nil
	end
end

--------
-- Restore map size

function Nx.Map:RestoreSize()

	self:MouseEnable (false)

	if self.Win:IsSizeMax() then

--		Nx.prt ("Map RestoreSize ToggleSize")
		self.Win:ToggleSize()

		self:RestoreView ("")
		self:DetachWorldMap()

		if self.GOpts["MapMaxRestoreHide"] then
			self.Win:Show (false)
		end
	end

	local wname = self:GetWinName()
	for n, name in pairs (UISpecialFrames) do
		if name == wname then
			tremove (UISpecialFrames, n)
			break
		end
	end
end

--------
-- Maximize map size

function Nx.Map:MaxSize()

	if not self.Win:IsSizeMax() then

		if NxData.NXDBMapMax then
			Nx.prt (L["MapMax %s"], debugstack (2, 4, 0))
		end

		self.Win:ToggleSize()

		self:SaveView ("")

		self:MouseEnable (true)

		if self.GOpts["MapMaxCenter"] then
			self:CenterMap()
		end
		self.StepTime = min (self.StepTime, 1)
	end
end

--------
-- Key binding toggle owned minimap to full size
-- global func

function Nx:NXMapKeyTogMiniFull()

	if Nx.Free then
		return
	end

	local map = Nx.Map:GetMap (1)
	map.LOpts.NXMMFull = not map.LOpts.NXMMFull
	map.MMZoomChanged = true
	map.MMMenuIFull:SetChecked (map.LOpts.NXMMFull)
	Nx.Menu:CheckUpdate (map.MMMenuIFull)
end

--------
-- Key binding toggle herbs
-- global func

function Nx:NXMapKeyTogHerb()

	local map = Nx.Map:GetMap (1)
	Nx.CharOpts["MapShowGatherH"] = not Nx.CharOpts["MapShowGatherH"]
	map.MenuIShowHerb:SetChecked (Nx.CharOpts, "MapShowGatherH")
	map.Guide:UpdateGatherFolders()

end

--------
-- Key binding toggle mining
-- global func

function Nx:NXMapKeyTogMine()

	local map = Nx.Map:GetMap (1)
	Nx.CharOpts["MapShowGatherM"] = not Nx.CharOpts["MapShowGatherM"]
	map.MenuIShowMine:SetChecked (Nx.CharOpts, "MapShowGatherM")
	map.Guide:UpdateGatherFolders()

end

--------
-- Enable or disable map mouse input

function Nx.Map:MouseEnable (max)

--	Nx.prt ("MouseEnable %s %s", max and "max" or "min", alt and 1 or 0)

	local on = true

	if max then
		if self.GOpts["MapMaxMouseIgnore"] then
			on = IsAltKeyDown() and true or false		-- IsAltKeyDown returns nil or 1
		end
	else
		if self.GOpts["MapMouseIgnore"] then
			on = IsAltKeyDown() and true or false		-- IsAltKeyDown returns nil or 1
		end
	end

	if self.MouseEnabled ~= on then

--		Nx.prt ("MouseEnable up")

		self.MouseEnabled = on

		self.Win:EnableMouse (on)

		if on then
			self.ButAutoScaleOn.Frm:Show()
			self:UpdateToolBar()		-- Will show or hide
		else
			self.ButAutoScaleOn.Frm:Hide()
			self.ToolBar.Frm:Hide()
		end

		self.Frm:EnableMouse (on)
		self.Frm:EnableMouseWheel (on)

		self.MMFrm:EnableMouse (on)
		self.MMFrm:EnableMouseWheel (on)

		for n, f in ipairs (self.IconFrms) do
			f:EnableMouse (on)
		end

		for n, f in ipairs (self.IconStaticFrms) do
			f:EnableMouse (on)
		end
	end
end

--------
-- Handle events
-- self = map table

function Nx.Map:OnEvent (event, ...)

	local this = self.Win.Frm

--	Nx.prtVar ("Map Event", self)
--	Nx.prt ("Map Event %s", event)

	if event == "WORLD_MAP_UPDATE" then

		if Nx.Quest then
			Nx.Quest:MapChanged()
		end

		if this:IsVisible() then
			this.NxMap:UpdateAll()
		end
	elseif event == "PLAYER_REGEN_DISABLED" then
	  self.Arch:Hide()
	  self.QuestWin:Hide()
	  self.Arch:SetParent(nil)
	  self.QuestWin:SetParent(nil)
	  self.Arch:ClearAllPoints()
	  self.QuestWin:ClearAllPoints()
	elseif event == "PLAYER_REGEN_ENABLED" then
	  self.Arch:SetParent(this.NxMap.TextScFrm:GetScrollChild())
	  self.QuestWin:SetParent(this.NxMap.TextScFrm:GetScrollChild())
	  self.Arch:Show()
	  self.QuestWin:Hide()
	end
end

function Nx.Map:OnMouseDown (button)

	local map = self.NxMap	--V4 this
	local this = map.Frm

	local x, y = GetCursorPosition()
	x = x / this:GetEffectiveScale()
	y = y / this:GetEffectiveScale()

	map:CalcClick()

	ResetCursor()

--	Nx.prt ("Map MouseDown %s %s %s %s %s", button, x, y, rgt, bot)

	if button == "LeftButton" then

--[[
		if map["DebugHotspots"] then

			map.HotspotDebugCurT = nil

			if map:IsDoubleClick() then
				map.DebugMapId = map.MapId
			else
				map.LClickTime = GetTime()
				map.Scrolling = true
				map.ScrollingX = x
				map.ScrollingY = y
				map.ScrollingFrm = map.ClickFrm
			end
			return
		end
--]]

		if IsControlKeyDown() and map:CallFunc ("MapButLCtrl") then	-- If func does nothing continue

		elseif IsAltKeyDown() and map:CallFunc ("MapButLAlt") then	-- If func does nothing continue

		elseif IsShiftKeyDown() then
			map:Ping()

		else

			if map:IsDoubleClick() then

				map:CenterMap()
				map.DebugMapId = map.MapId

			else
				map.LClickTime = GetTime()
				map.Scrolling = true
				map.ScrollingX = x
				map.ScrollingY = y
				map.ScrollingFrm = map.ClickFrm
			end
		end

	elseif button == "MiddleButton" then

		if IsControlKeyDown() then
			map:CallFunc ("MapButMCtrl")
		elseif IsAltKeyDown() then
			map:CallFunc ("MapButMAlt")
		else
			map:CallFunc ("MapButM")
		end

	elseif button == "RightButton" then

		if IsControlKeyDown() and map:CallFunc ("MapButRCtrl") then

		elseif IsAltKeyDown() and map:CallFunc ("MapButRAlt") then

		else
			map:CallFunc ("MapButR")
		end

	elseif button == "Button4" then

		if IsControlKeyDown() then
			map:CallFunc ("MapBut4Ctrl")
		elseif IsAltKeyDown() then
			map:CallFunc ("MapBut4Alt")
		else
			map:CallFunc ("MapBut4")
		end
	end
end

function Nx.Map:CalcClick()

	local f = self.Frm

	local x, y = GetCursorPosition()
	x = x / f:GetEffectiveScale()
	y = y / f:GetEffectiveScale()

	self.ClickFrmX = x - f:GetLeft()
	self.ClickFrmY = f:GetTop() - y
end

function Nx.Map:IsDoubleClick()

	if GetTime() - self.LClickTime < .5 then
--		Nx.prt ("Map DBL Click")
		self.LClickTime = 0
		return true
	end
end

function Nx.Map:OpenMenu()

	local opts = self:GetOptionsT (self.MapIndex)

	self.MenuIPlyrFollow:SetChecked (self.CurOpts.NXPlyrFollow)
	self.MenuIShowWorld:SetChecked (self.CurOpts.NXWorldShow)

--PAIDS!
	self.MenuIMonitorZone:SetChecked (Nx.Com:IsZoneMonitored (self.MapId))
--PAIDE!

	self.MenuMapId = self.MapId

	self.Menu:Open()
end

function Nx.Map:OnMouseUp (button)

--	Nx.prt ("Map MouseUp "..tostring (button))

	local this = self			--V4
	local map = this.NxMap
	map.Scrolling = false
end

--------

function Nx.Map:ClickZoomIn()
	self:MouseWheel (1)
end

function Nx.Map:ClickZoomOut()
	self:MouseWheel (-1)
end

function Nx.Map:OnMouseWheel (value)
	self.NxMap:MouseWheel (value)
end

function Nx.Map:MouseWheel (value)

--	Nx.prt ("Map MouseWheel "..tostring (value))

	local map = self
	local this = map.Frm

	if map.MMZoomType == 0 and Nx.Util_IsMouseOver (map.MMFrm) then

		map.MMZoomChanged = true

		local i = map.GOpts["MapMMDockZoom"]

		if value < 0 then
			i = max (i - 1, 0)
		else
			i = min (i + 1, 5)
		end

		map.GOpts["MapMMDockZoom"] = i

		return
	end

	local x, y = GetCursorPosition()
	x = x / this:GetEffectiveScale()
	y = y / this:GetEffectiveScale()

	local left = this:GetLeft()
	local rgt = this:GetRight()
	local top = this:GetTop()
	local bot = this:GetBottom()

	local ox = map.MapPosX + (x - left - map.PadX - map.MapW / 2) / map.Scale
	local oy = map.MapPosY + (top - y - map.TitleH - map.MapH / 2) / map.Scale

	map.Scale = map:ScrollScale (value)
	map.StepTime = 10
	if map:IsInstanceMap(map:GetRealMapId()) then
	else
	  map.RealScale = map.Scale
	end
	map.MapScale = map.Scale / 10.02

	local nx = map.MapPosX + (x - left - map.PadX - map.MapW / 2) / map.Scale
	local ny = map.MapPosY + (top - y - map.TitleH - map.MapH / 2) / map.Scale

	map.MapPosX = map.MapPosX + ox - nx
	map.MapPosY = map.MapPosY + oy - ny		
end

function Nx.Map:ScrollScale (value)

	local s = self.Scale
	if value < 0 then
		value = value * .76923
	end

	return math.max (s + value * s * .3, .015)
end

function Nx.Map:SetScaleOverTime (steps)

	local step = steps >= 0 and 1 or -1
	for n = 1, abs (steps) do
		self.Scale = self:ScrollScale (step)
	end

	self.StepTime = 10
end

--------
-- Update event handler

function Nx.Map.OnUpdate (this, elapsed)	--V4 this


--	if IsControlKeyDown() then		return	end


	local Nx = Nx

	Nx.Timer:ProfilerStart ("Map OnUpdate")

	local profileTime = GetTime()

	local map = this.NxMap
	local gopts = map.GOpts
	local Quest = Nx.Quest

	map.Tick = map.Tick + 1

	map.EffScale = this:GetEffectiveScale()
	map.Size1 = gopts["MapLineThick"] * .75 / map.EffScale

	Nx.Map:UpdateOptions (map.MapIndex)

	local winx, winy = Nx.Util_IsMouseOver (this)

	if not this:IsVisible() or not map.MouseEnabled then
		winx = nil
		map.Scrolling = false
	end

	if map.MMZoomType == 0 and Nx.Util_IsMouseOver (map.MMFrm) then
		winx = nil
	end

	map.MouseIsOver = winx

	-- Scroll map with mouse

	if map.Scrolling then

		local cx, cy = GetCursorPosition()
		cx = cx / map.EffScale
		cy = cy / map.EffScale

		local x = cx - map.ScrollingX
		local y = cy - map.ScrollingY

--[[
		if map["DebugHotspots"] or (map.Debug and IsAltKeyDown()) then
			if map:OnButScrollDebug (0, 0, x, -y) then
				x = 0
				y = 0
			end
		end
--]]

		if x ~= 0 or y ~= 0 then		-- Moved? Cancel double click
			map.LClickTime = 0
		end

		map.ScrollingX = cx
		map.ScrollingY = cy

		local left = this:GetLeft()
		local top = this:GetTop()

		local mx = x / map.ScaleDraw
		local my = y / map.ScaleDraw
		map.MapPosXDraw = map.MapPosXDraw - mx
		map.MapPosYDraw = map.MapPosYDraw + my

		map.MapPosX = map.MapPosXDraw
		map.MapPosY = map.MapPosYDraw
		map.Scale = map.ScaleDraw
	end

	map:Update (elapsed)

	-- Title text

	local title = ""

	if gopts["MapShowTitleName"] then

		title = map:IdToName (map.RMapId)

--		for n = 1, MAX_BATTLEFIELD_QUEUES do
		for n = 1, GetMaxBattlefieldID() do		-- Patch 4.3

			local status, _, instId = GetBattlefieldStatus (n)
			if status == "active" then
				title = title .. format (" #%s", instId)
				break
			end
		end
	end

	if gopts["MapShowTitleXY"] then
		if map.DebugFullCoords then
			title = title .. format (" %4.2f, %4.2f", map.PlyrRZX, map.PlyrRZY)
		else
			title = title .. format (" %4.1f, %4.1f", map.PlyrRZX, map.PlyrRZY)
		end
	end

	if map.PlyrSpeed > 0 and gopts["MapShowTitleSpeed"] then

		local speed = map.PlyrSpeed

		local sa = Nx.Map.MapWorldInfo[map.MapId].ScaleAdjust
		if sa then
			speed = speed * sa
		end

		speed = speed / 6.4 * 100 - 100
		if abs (speed) < .5 then	-- Removes small -0%
			speed = 0
		end
		title = title..format (L[" |cffa0a0a0Speed %+.0f%%"], speed)
--		Nx.prt ("Speed %f %f, Tm %.4f, %.3f %.3f", map.PlyrSpeed, speed, elapsed, map.PlyrX, map.PlyrY)		-- DEBUG!
	end

--	title = title..format (" Dir %.1f", map.PlyrDir)

	local cursorLocStr = ""
	local cursorLocXY = ""

	local menuOpened = Nx.Menu:IsAnyOpened()

	if winx then

		map.BackgndAlphaTarget = map.BackgndAlphaFull

		winy = this:GetHeight() - winy

		if winy >= map.TitleH then

			local wx, wy = map:FramePosToWorldPos (winx, winy)

			if not menuOpened then
--				local tm = GetTime()
				map:CheckWorldHotspots (wx, wy)
--				Nx.prt ("CheckWorldHotspots Time %s", GetTime() - tm)
			end

			local x, y = map:GetZonePos (map.MapId, wx, wy)

			x = floor (x * 10) / 10	-- Chop fraction to tenths
			y = floor (y * 10) / 10
			local dist = ((wx - map.PlyrX) ^ 2 + (wy - map.PlyrY) ^ 2) ^ .5 * 4.575

			cursorLocXY = format (L["|cff80b080%.1f %.1f %.0f yds"], x, y, dist)
			cursorLocStr = cursorLocXY

			local name = UpdateMapHighlight (x / 100, y / 100)
			if name then
				cursorLocStr = format ("%s\n|cffafafaf%s", cursorLocStr, name)
			end
		end

	else

--		if GameTooltip:IsOwned (map.Win.Frm) and map.TooltipType == 1 then
--			Nx.prt ("map TT hide")
--			map.TooltipType = 0
--			GameTooltip:Hide()
--		end

		if not map.Scrolling and not menuOpened then

			map.BackgndAlphaTarget = map.BackgndAlphaFade

			local rid = map:GetRealMapId()			
			if rid ~= 9000 and not WorldMapFrame:IsShown() then

				local mapId = map:GetCurrentMapId()
				if map:IsInstanceMap (rid) then					
					if not Nx.Map.InstanceInfo[rid] then		-- Don't convert WotLK/Cata instances
						rid = Nx.Map.MapWorldInfo[rid].EntryMId
					end					
					if map:IsInstanceMap(rid) then
					  map.Scale = 120					  
					else
					  map.Scale = map.RealScale					  
					end
					local lvl = GetCurrentMapDungeonLevel()
					if lvl ~= map.InstLevelSet then
						mapId = 0	-- Force set
--						Nx.prt ("map force set inst")
					end
				end

				if mapId ~= rid then
					if map:IsBattleGroundMap (rid) then						
						SetMapToCurrentZone()
					else
						map:SetCurrentMap (rid)
					end
				end
			end
		end
	end

	-- Check quest window

	if map.Guide.Win.Frm:IsVisible() or Quest.List.Win and Quest.List.Win.Frm:IsVisible() then
		map.BackgndAlphaTarget = map.BackgndAlphaFull
	end

	-- Profiling

	if map.DebugTime then

		profileTime = GetTime() - profileTime
		local t = map.DebugProfileTime or .01
		t = t * .95 + profileTime * .05
		map.DebugProfileTime = t

		UpdateAddOnMemoryUsage()
		local mem = GetAddOnMemoryUsage ("Carbonite")

		local memdif = mem - (map.DebugMemUse or 0)
		map.DebugMemUse = mem

		title = title..format (L[" Time %.4f Mem %d %.4f"], t, mem, memdif)
	end

	if GetCVar ("scriptProfile") == "1" then

		UpdateAddOnCPUUsage()

		title = title..format (L[" |cffffffffCPU %6.3f %6.3f"], GetAddOnCPUUsage ("CARBONITE"), GetScriptCPUUsage())

		ResetCPUUsage()
	end

	--

	if Nx.Tick % 3 == 0 then	-- Do less often, since tip makes garbage

		local tip = format (" %s", cursorLocStr)
		if map.Debug and winx then
			local x, y = map:FramePosToWorldPos (winx, winy)
			tip = tip .. format (L["\n|cffc080a0%.2f WXY %6.2f %6.2f PXY %6.2f %6.2f"], map.Scale, x, y, map.PlyrX, map.PlyrY)
			map.DebugWX = x
			map.DebugWY = y
		end

		local over = winx and not Nx.Util_IsMouseOver (map.ToolBar.Frm)
		map:SetLocationTip (over and not menuOpened and map.WorldHotspotTipStr and (map.WorldHotspotTipStr .. tip))
	end

	if map.Win:IsSizeMax() then
		local s = Nx.Quest:GetZoneAchievement (true)
		if s then
			title = title .. "  " .. s
		end
	end

	map.Win:SetTitle (title, 1)

	if map.GOpts["MapShowTitle2"] then

		local s = GetSubZoneText()
		local pvpType = GetZonePVPInfo()
		if pvpType then
			s = s .. " (" .. pvpType .. ")"
		end
		map.Win:SetTitle (format ("%s %s", s, cursorLocXY), 2)
	end
	
	Nx.Timer:ProfilerEnd ("Map OnUpdate")
end

--------
-- Handle mouse click on icon

--[[
function Nx.Map:WorldHotspotOnMouseDown (button)

--	Nx.prt ("MapWorldHotspotOnMouseDown "..button.." "..(this:GetName() or "?"))

	local map = this.NxMap
	map.ClickFrm = this
	this = map.Frm
	map:OnMouseDown (button)
end
--]]

--------
-- Handle mouse on icon

--[[
function Nx.Map:WorldHotspotOnEnter (motion)

	local map = this.NxMap

	if not map.Scrolling then

		local mapId = this.NxMapId
		map:SetCurrentMap (mapId)

		map:IconOnEnter (motion)
	end
end
--]]

--------
-- Flag for update all map data

function Nx.Map:UpdateAll()

	self.NeedWorldUpdate = true

--	Nx.prt ("%d Map UpdateAll %d (%d)", self.Tick, self:GetCurrentMapId(), self.MapId)
end

--------
-- Update all map data

function Nx.Map:NewGetMapInfo()
    local mapName, textureWidth, textureHeight, isMicroDungeon, microDungeonName = GetMapInfo()
    if isMicroDungeon and microDungeonName then
        return microDungeonName, textureWidth, textureHeight, isMicroDungeon, microDungeonName
    end
    return mapName, textureWidth, textureHeight, isMicroDungeon
end	

function Nx.Map:UpdateWorld()

	if self.Debug then
		Nx.prt (L["%d Map UpdateWorld1 %d L%d"],
				self.Tick, self:GetCurrentMapId(), GetCurrentMapDungeonLevel())
	end

	self.NeedWorldUpdate = false

	local mapId = self:GetCurrentMapId()	
	local winfo = self.MapWorldInfo[mapId]
	
	if winfo.MapLevel then
		if GetCurrentMapDungeonLevel() ~= winfo.MapLevel then	-- Wrong level?
			SetDungeonMapLevel (winfo.MapLevel)
		end
	end

	local i = self:GetExploredOverlayNum()

	if self.CurWorldUpdateMapId == mapId and i == self.CurWorldUpdateOverlayNum and GetCurrentMapDungeonLevel()==self.LastDungeonLevel then
		return
	end

	self.CurWorldUpdateMapId = mapId
	self.CurWorldUpdateOverlayNum = i
    self.LastDungeonLevel = GetCurrentMapDungeonLevel()
	
	local mapFileName,_,_,isMicro,microTex = GetMapInfo()	
	if not mapFileName then
		if GetCurrentMapContinent() == WORLDMAP_COSMIC_ID then
			mapFileName = "Cosmic"
		else
			mapFileName = "World"
		end
	end
    local texPath = "Interface\\WorldMap\\"..(isMicro and "MicroDungeon\\"..mapFileName.."\\"..microTex or mapFileName).."\\"
    local texName = microTex or mapFileName
	
	self:UpdateOverlayUnexplored()

	if self.Debug then
		Nx.prt (L["%d Map UpdateWorld %d"], self.Tick, self:GetCurrentMapId())
		Nx.prt (L[" File %s"], mapFileName)
	end

	Nx.UEvents:UpdateMap (true)
    local dungeonLevel = GetCurrentMapDungeonLevel();
    if (DungeonUsesTerrainMap()) then
        dungeonLevel = dungeonLevel - 1;
    end
    if dungeonLevel>0 then texName = texName..dungeonLevel.."_" end
	for i = 1, 12 do
		self.TileFrms[i].texture:SetTexture (texPath..texName..i)
	end
end

--------
-- Update window fade

function Nx.Map:WinUpdateFade (fade)

	self.ToolBar:SetFade (fade)
	self.ButAutoScaleOn.Frm:SetAlpha (fade)
end

--------
-- Update map. Called every tick, make it quick

function Nx.Map:Update (elapsed)

	local Nx = Nx
	local Map = Nx.Map

	self:MouseEnable (self.Win:IsSizeMax())

	if self.NeedWorldUpdate then
		self:UpdateWorld()
	end

	self.MapW = self.Frm:GetWidth() - self.PadX * 2
	self.MapH = self.Frm:GetHeight() - self.TitleH
	self.Level = self.Frm:GetFrameLevel() + 1

	local mapId = self:GetCurrentMapId()
	self.Cont, self.Zone = self:IdToContZone (mapId)

	Nx.InSanctuary = GetZonePVPInfo() == "sanctuary"

	local doSetCurZone
	local mapChange

	if self.MapId ~= mapId then

		if self.Debug then
			Nx.prt (L["%d Map change %d to %d"], self.Tick, self.MapId, mapId)
		end

		self.CurMapBG = self:IsBattleGroundMap (mapId)

		if not self:IsBattleGroundMap (self.MapId) then
--			self.MapIdOld = self.MapId
			self:AddOldMap (mapId)
		end

		self.MapId = mapId
		mapChange = true

		Nx.Com.PlyrChange = GetTime()
	end

	local rid = self:GetRealMapId()
	local inBG = self:IsBattleGroundMap (rid)

	if Nx.InBG and Nx.InBG ~= rid then	-- Left or changed BG?

--		Nx.prt ("Left BG %s", Nx.InBG)

		local cb = Nx.Combat

		if Nx.InArena then
			local s = Nx.Map:GetShortName (Nx.InArena)
			Nx.UEvents:AddInfo (format (L["Left %s %d %d %dD %dH"], s, cb.KBs, cb.Deaths, cb.DamDone, cb.HealDone))

		else
			local total = cb.KBs + cb.Deaths + cb.HKs + cb.Honor
			if total > 0 then
				local sname = Nx.Map:GetShortName (Nx.InBG)
				Nx.UEvents:AddInfo (format (L["Left %s %d %d %d %d"], sname, cb.KBs, cb.Deaths, cb.HKs, cb.Honor))

				local tm = GetTime() - cb.BGEnterTime
				local _, honor = GetCurrencyInfo (392)		--V4
				local hGain = honor - cb.BGEnterHonor
				Nx.UEvents:AddInfo (format (L[" %s +%d honor, +%d hour"], Nx.Util_GetTimeElapsedMinSecStr (tm), hGain, hGain / tm * 3600))

				local xpGain = UnitXP ("player") - cb.BGEnterXP
				if xpGain > 0 then
					Nx.UEvents:AddInfo (format (L[" +%d xp, +%d hour"], xpGain, xpGain / tm * 3600))
				end
			end
		end

		cb.KBs = 0
		cb.Deaths = 0
		cb.HKs = 0
		cb.Honor = 0
		Nx.InBG = nil

		if Nx.InArena then
			self.LOpts.NXMMFull = false
		end
		Nx.InArena = nil
	end

	if inBG and Nx.InBG ~= rid then
		Nx.InBG = rid

		local cb = Nx.Combat
		cb.BGEnterTime = GetTime()
		local _, honor = GetCurrencyInfo (392)		--V4
		cb.BGEnterHonor = honor
		cb.BGEnterXP = UnitXP ("player")

		if self.MapWorldInfo[rid].Arena then
			Nx.InArena = rid
			self.LOpts.NXMMFull = true
		end

--		Nx.prt ("Entering BG %s", rid)
		doSetCurZone = true
	end

	-- Taxi update

	local ontaxi = UnitOnTaxi ("player")

	if ontaxi then
		if not Map.TaxiOn then	-- New taxi ride?
			Map.TaxiStartTime = GetTime()
			Map.TaxiOn = true
			if NxData.DebugMap then
				Nx.prt ("Taxi start")
			end
		end

	elseif Map.TaxiOn then	-- Done with taxi
		Map.TaxiOn = false
		Map.TaxiX = nil		-- Clear so if we pop on a taxi by a unhooked method we don't track old

		local tm = GetTime() - Map.TaxiStartTime

		Nx.Travel:TaxiSaveTime (tm)

		if NxData.DebugMap then
			Nx.prt (L["Taxi time %.1f seconds"], tm)
		end
	end

	-- Real map switch

	if self.RMapId ~= rid then
		if rid ~= 9000 then

--			Nx.prt ("Map zone changed %d, %d", rid, mapId)

			if self.RMapId == 9000 then	-- Loading?
				self.CurOpts = nil
				self:SwitchOptions (rid, true)
			end

			self.RMapId = rid

			self:SwitchOptions (rid)
			self:SwitchRealMap (rid)
		end
		self.Scale = self.RealScale
	end

	local plZX, plZY = GetPlayerMapPosition ("player")

	self.InstanceId = false
	
	if self:IsInstanceMap (rid) then

		self.InstanceId = rid

		plZX = plZX * 100
		plZY = plZY * 100

--		self.PlyrInstX = plZX
--		self.PlyrInstY = plZY

--		Nx.prt ("XY %s %s", plZX, plZY)

		self.PlyrRZX = plZX
		self.PlyrRZY = plZY

		local x, y = self:GetWorldPos (rid, 0, 0)

		local lvl = max (GetCurrentMapDungeonLevel(), 1)		-- 0 if no level

		if not self.InstMapId then		-- Not showing instance?
			plZX = 0
			plZY = 0

		elseif plZX == 0 and plZY == 0 then

			self.InstLevelSet = -1
		end

		self.PlyrX = x + plZX * 1002 / 25600
		self.PlyrY = y + plZY * 668 / 25600 + (lvl - 1) * 668 / 256

--		self.InstanceLevel = GetCurrentMapDungeonLevel()

		self.PlyrSpeed = 0
	elseif plZX > 0 or plZY > 0 then	-- Update world position of player if we can get it

		plZX = plZX * 100
		plZY = plZY * 100

		local x, y = self:GetWorldPos (mapId, plZX, plZY)
		
		if elapsed > 0 then

			if x == self.PlyrX and y == self.PlyrY then	-- Not moving?
				self.PlyrSpeedCalcTime = GetTime()
				self.PlyrSpeed = 0
				self.PlyrSpeedX = x
				self.PlyrSpeedY = y

			else
				local tmDif = GetTime() - self.PlyrSpeedCalcTime
				if tmDif > .5 then
					self.PlyrSpeedCalcTime = GetTime()
					self.PlyrSpeed = ((x - self.PlyrSpeedX) ^ 2 + (y - self.PlyrSpeedY) ^ 2) ^ .5 * 4.575 / tmDif
					self.PlyrSpeedX = x
					self.PlyrSpeedY = y
				end
			end
		end

--		if elapsed > 0 then
--			self.PlyrSpeed = ((x - self.PlyrX) ^ 2 + (y - self.PlyrY) ^ 2) ^ .5 * 4.575 / elapsed
--		end

		self.PlyrX = x
		self.PlyrY = y

		if mapId ~= rid then			-- Not in real zone?
			if (self:IsMicroDungeon(mapId)) then			
			else
			  plZX, plZY = self:GetZonePos (rid, x, y)			
			end
		end

		self.PlyrRZX = plZX
		self.PlyrRZY = plZY

		if mapChange then
			self.MoveLastX = x
			self.MoveLastY = y
		end
	end

--	Nx.prt ("Dir %s", GetPlayerFacing())
	self.PlyrDir = 360 - GetPlayerFacing() / 2 / math.pi * 360

	local plX = self.PlyrX
	local plY = self.PlyrY

	local x = plX - self.MoveLastX
	local y = plY - self.MoveLastY
	local ang = self.PlyrDir - self.PlyrLastDir

	local moveDist = (x * x + y * y) ^ .5

--	if moveDist > 0 then Nx.prt ("MoveDist %f %f", moveDist, self.BaseScale) end

	if moveDist >= .01 * self.BaseScale or abs (ang) > .01 then

		Nx.Com.PlyrChange = GetTime()

		if self.MoveLastX ~= -1 then
			self.MoveDir = math.deg (math.atan2 (x, -y / 1.5))
		end

		self.MoveLastX = plX
		self.MoveLastY = plY

--		if not rotOk then
--			self.PlyrDir = self.MoveDir
--		end

		self.PlyrLastDir = self.PlyrDir

		if not self.Scrolling and not self.MouseIsOver and not WorldMapFrame:IsVisible() then

			if self.CurOpts.NXPlyrFollow then

				local scOn = self.LOpts.NXAutoScaleOn		--self.GOpts["MapFollowChangeScale"]

				if plZX ~= 0 or plZY ~= 0 then

					if #self.Tracking == 0 or not scOn then
						self:Move (plX, plY, nil, 60)
					end
				end

				if scOn then

					local midX
					local midY
					local dtx
					local dty

					local cX, cY = GetCorpseMapPosition()

					if cX ~= 0 or cY ~= 0 then

						midX, midY = self:GetWorldPos (mapId, cX * 100, cY * 100)
						dtx = 1
						dty = 1

					elseif #self.Tracking > 0 then

						local tr = self.Tracking[1]
						midX = tr.TargetMX
						midY = tr.TargetMY
						dtx = abs (tr.TargetX1 - tr.TargetX2)
						dty = abs (tr.TargetY1 - tr.TargetY2)

					elseif Map.TaxiX then

						midX, midY = self.TaxiX, self.TaxiY
						dtx = 1
						dty = 1
					end

					if midX then

						local mX = (midX + self.PlyrX) * .5
						local mY = (midY + self.PlyrY) * .5

						local dx = abs (midX - self.PlyrX)
						local dy = abs (midY - self.PlyrY)
--						Nx.prt ("Map scale target %f %f", dx, dy)
						dx = self.MapW / dx
						dy = self.MapH / dy
						local scale = min (dx, dy) * .5
--						Nx.prt ("Map scales %f %f", dx, dy)

--						Nx.prt ("Map scale target %f %f", dtx, dty)
						dx = self.MapW / dtx
						dy = self.MapH / dty
						scale = min (min (dx, dy), scale)	-- Smaller of target rect of player to target center

						local scmax = self.InstanceId and 800 or self.LOpts.NXAutoScaleMax

						scale = max (min (scale, scmax), self.LOpts.NXAutoScaleMin)
						self:Move (mX, mY, scale, 60)
					end
				end

				if rid ~= mapId then
					doSetCurZone = true
--					Nx.prt ("Map SetMapToCurrentZone")
				end
			end
		end
	end

	-- Adjust draw scale and position

	local scaleDiff = abs (self.ScaleDraw - self.Scale)
	local xDiff = self.MapPosXDraw - self.MapPosX
	local yDiff = self.MapPosYDraw - self.MapPosY

	if self.StepTime ~= 0 and (scaleDiff > 0 or xDiff ~= 0 or yDiff ~= 0) then
--	if (xDiff ~= 0 or yDiff ~= 0) and (self.Tick % 1 == 0) then

--		Nx.prt ("Tick %f", self.Tick)

		if self.StepTime > 0 then

--			Nx.prt ("Steptime Go #%d %f", self.Tick, self.StepTime)

			self.StepTime = -self.StepTime

			self.ScaleDrawW = 1 / self.ScaleDraw
			self.ScaleW = 1 / self.Scale
		end

		local st = -self.StepTime

		self.MapPosXDraw = Nx.Util_StepValue (self.MapPosXDraw, self.MapPosX, abs (xDiff) / st)
		self.MapPosYDraw = Nx.Util_StepValue (self.MapPosYDraw, self.MapPosY, abs (yDiff) / st)
		self.ScaleDrawW = Nx.Util_StepValue (self.ScaleDrawW, self.ScaleW, abs (self.ScaleDrawW - self.ScaleW) / st)
		self.ScaleDraw = 1 / self.ScaleDrawW

--		Nx.prt ("Map scrl #%d %f %f", self.StepTime, self.MapPosXDraw, self.MapPosX)
--		Nx.prt ("Map scrl %f %f", self.OCur, self.OEnd)
--		Nx.prt ("Map scrl %f %f", self.ScaleDraw, self.Scale)

		self.StepTime = self.StepTime + 1
	end

	local _, zx, zy, zw = self:GetWorldZoneInfo (self.Cont, self.Zone)
	if zx then
		self.MapScale = self.Scale / 10.02
	end

	--

	local plSize = self.GOpts["MapPlyrArrowSize"]
	if IsShiftKeyDown() then
		plSize = 5
	end

	self.PlyrFrm:Show()
	self:ClipFrameW (self.PlyrFrm, self.PlyrX, self.PlyrY, plSize, plSize, self.PlyrDir)

	self.InCombat = UnitAffectingCombat ("player")

	local g = 1
	local b = 1
	local al = 1
	if self.InCombat then
		g = 0
		b = 0
		al = abs (GetTime() % 1 - .5) / .5 * .5 + .4
	end

	self.PlyrFrm.texture:SetVertexColor (1, g, b, al)
--	local str = format ("%s %d %d", UnitName ("player"), UnitHealth ("player"), UnitMana ("player"))
--	self.PlyrFrm.NxTip = str

	--

	self.BackgndAlpha = Nx.Util_StepValue (self.BackgndAlpha, self.BackgndAlphaTarget, .05)
	self.Frm.texture:SetVertexColor (1, 1, 1, self.BackgndAlpha)

	self.WorldAlpha = (self.BackgndAlpha - self.BackgndAlphaFade) / (self.BackgndAlphaFull - self.BackgndAlphaFade) * self.BackgndAlphaFull

	self:ResetIcons()

	self:MoveContinents()
--	self:MoveWorldHotspots()

--	if not (IsAltKeyDown() and IsControlKeyDown()) then
--	end

	self:UpdateZones()
	self:UpdateInstanceMap()

	self:MinimapUpdate()
	self:UpdateWorldMap()

	self:DrawContinentsPOIs()

	if self.GOpts["MapShowTrail"] then
		self:UpdatePlyrHistory()
	end

	if self.GOpts["MapShowPunks"] then
		Nx.Social:UpdateIcons (self)
	end

--[[
	if self["DebugHotspots"] then
		self:UpdateHotspotsDebug()
	end
--]]

	-- Battlefield Vehicles

	local vtex = _G["VEHICLE_TEXTURES"]

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, orientation, player = GetBattlefieldVehicleInfo (n)
		if x and x > 0 and not player then

--			Nx.prtCtrl ("#%s %s %.2f %.2f %.3f %s %s %s", n, unitName or "nil", x or -1, y or -1, orientation or -1, typ or "no type", possessed and "poss" or "-poss", player and "plyr" or "-plyr")

			if vtex[typ] then
				local f2 = self:GetIconNI (1)
				local sc = self.ScaleDraw * 0.8
				if self.InstanceId then				
					sc = .5		-- Airships
				end
				if typ == "Drive" or typ == "Fly" then
					sc = 1
					if self.InstanceId then
					  sc = .7
					end
				end							
				if self:ClipFrameZ (f2, x * 100, y * 100, vtex[typ]["width"] * sc, vtex[typ]["height"] * sc, orientation / PI * -180) then
					f2.texture:SetTexture (WorldMap_GetVehicleTexture (typ, possessed))
				end

--				Nx.prtCtrl ("%s %s %s %s", unitName, x, y, orientation)
			end
		end
	end

	-- POI's (Points of interest)

	local oldLev = self.Level

	if IsShiftKeyDown() then

		oldLev = oldLev - 4
		self.Level = self.Level + 16
	end

	local name, description, txIndex, pX, pY
	local txX1, txX2, txY1, txY2
	local poiNum = GetNumMapLandmarks()

--	Nx.prt ("poiNum %d", poiNum)

	for i = 1, poiNum do
		name, desc, txIndex, pX, pY = GetMapLandmarkInfo (i)

		if txIndex ~= 0 then		-- WotLK has 0 index POIs for named locations

			local tip = name
			if desc then
				tip = format ("%s\n%s", name, desc)
			end

			pX = pX * 100
			pY = pY * 100

--			Nx.prtCtrl ("poi %d %s %s %d", i, name, desc, txIndex)

			local f = self:GetIcon (3)

			if self.CurMapBG then

				f.NXType = 2000

				local iconType = Nx.MapPOITypes[txIndex]

				local sideStr = ""
				if iconType == 1 then	-- Ally?
					sideStr = L[" (Ally)"]
				elseif iconType == 2 then	-- Horde?
					sideStr = L[" (Horde)"]
				end

				if desc == NXlINCONFLICT then

					local state = self.BGTimers[name]
					if state ~= txIndex then
						self.BGTimers[name] = txIndex
						self.BGTimers[name.."#"] = GetTime()
					end

					local dur = GetTime() - self.BGTimers[name.."#"]
					local doneDur = (rid == 9001 or rid == 9009 or rid == 9010) and 64 or 241
					local leftDur = max (doneDur - dur, 0)
					local tmStr

					if leftDur < 60 then
						tmStr = format (":%02d", leftDur)
					else
						tmStr = format ("%d:%02d", floor (leftDur / 60), floor (leftDur % 60))
					end

					f.NXData = format ("1~%f~%f~%s%s %s", pX, pY, name, sideStr, tmStr)

					tip = format ("%s\n%s", tip, tmStr)

					-- Horizontal bar

					local sz = 30 / self.ScaleDraw

					local f2 = self:GetIcon (0)
					self:ClipFrameZTLO (f2, pX, pY, sz, sz, -15, -15)
					f2.texture:SetTexture (0, 0, 0, .35)

					f2.NXType = 2000
					f2.NxTip = tip
					f2.NXData = f.NXData

					local f2 = self:GetIconNI (1)

					if leftDur < 10 then

						if self.BGGrowBars then

							local al = abs (GetTime() % .4 - .2) / .2 * .2 + .8

							local f3 = self:GetIconNI (2)
							self:ClipFrameZTLO (f3, pX, pY, sz * (10 - leftDur) * .1, 3 / self.ScaleDraw, -15, -15)
							f3.texture:SetTexture (.5, 1, .5, al)

							local f3 = self:GetIconNI (2)
							self:ClipFrameZTLO (f3, pX, pY, sz * (10 - leftDur) * .1, 3 / self.ScaleDraw, -15, 12)
							f3.texture:SetTexture (.5, 1, .5, al)
						end

--						f2.texture:SetTexture (.5, 1, .5, abs (GetTime() % .6 - .3) / .3 * .7 + .3)
					end

					local red = .3
					local blue = 1
					if iconType == 2 then	-- Horde?
						red = 1
						blue = .3
					end

					f2.texture:SetTexture (red, .3, blue, abs (GetTime() % 2 - 1) * .5 + .5)

					local per = leftDur / doneDur
					local vper = per > .1 and 1 or per * 10

					if self.BGGrowBars then
						per = 1 - per
						vper = 1
					else
						per = max (per, .1)
					end

					self:ClipFrameZTLO (f2, pX, pY, sz * per, sz * vper, -15, -15)

				else	-- No conflict

					f.NXData = format ("0~%f~%f~%s%s", pX, pY, name, sideStr)

					self.BGTimers[name] = nil

					-- Rect

					local sz = 30 / self.ScaleDraw

					local f2 = self:GetIcon (0)
					self:ClipFrameZTLO (f2, pX, pY, sz, sz, -15, -15)

--					Nx.prtCtrl ("I %s %s %s", name, txIndex, iconType or "nil")

					if iconType == 1 then	-- Ally?
						f2.texture:SetTexture (0, 0, 1, .3)
--						Nx.prtCtrl ("Blue")
					elseif iconType == 2 then	-- Horde?
						f2.texture:SetTexture (1, 0, 0, .3)
--						Nx.prtCtrl ("Red")
					else
						f2.texture:SetTexture (0, 0, 0, .3)
					end

					f2.NXType = 2000
					f2.NxTip = tip
					f2.NXData = f.NXData

				end
			end

			f.NxTip = tip

			self:ClipFrameZ (f, pX, pY, 16, 16, 0)

			f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
			txX1, txX2, txY1, txY2 = GetPOITextureCoords (txIndex)
			f.texture:SetTexCoord (txX1 + .003, txX2 - .003, txY1 + .003, txY2 - .003)
			f.texture:SetVertexColor (1, 1, 1, 1)
		end
	end

	self.Level = oldLev + 4

	-- Update misc icons (herbs, ore, ...)
	-- Levels:
	--  +0 quest areas
	--  +1 quest area target
	--  +2-3 com players (++3 if alt key)
	--  +4 quest icons
	--  +5 ?

	Nx.HUD:Update (self)

	local comTrackName, comTrackX, comTrackY = Nx.Com:UpdateIcons (self)

	self.Level = self.Level + 2
	self.Guide:UpdateZonePOIIcons()
	Nx.Fav:UpdateIcons()
	self:UpdateIcons (self.KillShow)
	self.Level = self.Level - 2

	if Nx.Quest.Enabled then
		Nx.Quest:UpdateIcons (self)
	end

	self.Level = self.Level + 7

	-- Test

--	for n = 0, 100 do
--		local f = self:GetIcon()
--		f.texture:SetTexture (1, 1, .5, 1)
--		self:ClipFrameZ (f, n, 50, 2, 2)
--	end

	-- Battlefield flags

	local fX, fY, fToken
	local flagNum = GetNumBattlefieldFlagPositions()

	for i = 1, flagNum do

		fX, fY, fToken = GetBattlefieldFlagPosition (i)

		if fX ~= 0 or fY ~= 0 then

			local f = self:GetIconNI()
			f.texture:SetTexture ("Interface\\WorldStateFrame\\"..fToken)
			self:ClipFrameZ (f, fX * 100, fY * 100, 36, 36, 0)
		end
	end

	self.Level = self.Level + 1

	-- Raid or party icons (AKA group)

	local palName, palX, palY = self:UpdateGroup (plX, plY)

	-- Tracking animation

	if self.PlyrSpeed == 0 then

--		self.ArrowPulse = self.ArrowPulse + .05
--		if self.ArrowPulse > cnt then
--			self.ArrowPulse = 1
--		end

		self.ArrowScroll = self.ArrowScroll + .01
		if self.ArrowScroll >= 1 then
			self.ArrowScroll = 0
		end
	end

	-- Corpse or target tracking

	self.TrackDir = false

	self.Guide:OnMapUpdate()	-- For closest target

	if #self.Targets > 0 then

		self:UpdateTargets()
		self:UpdateTracking()
		self.Level = self.Level + 2
	end

	self.TrackETA = false

	local cX, cY = GetCorpseMapPosition()

	if (cX > 0 or cY > 0) and not inBG then	-- We dead, but not in BG?

		if self.GOpts["HUDATCorpse"] then

			self.TrackName = L["Corpse"]

			local x, y = self:GetWorldPos (mapId, cX * 100, cY * 100)
			self:DrawTracking (plX, plY, x, y, false, "D")

			local f = self:GetIcon (1)

			f.NxTip = L["Your corpse"]
			f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
			self:ClipFrameZ (f, cX * 100, cY * 100, 16, 16, 0)
			-- Override clipping (FIX maybe?)
			f.texture:SetTexCoord (.502, .5605, 0, .0605)	-- 16x16 grid (.0625 uv size)

			self.Level = self.Level + 2
		end

	elseif ontaxi and Map.TaxiX then

		if self.GOpts["HUDATTaxi"] then

			self.TrackName = Map.TaxiName
			self.TrackETA = Map.TaxiETA

			local x, y = self.TaxiX, self.TaxiY
			self:DrawTracking (plX, plY, x, y, false, "F")

--			Nx.prt ("taxi %s %s", x, y)

			local f = self:GetIcon (1)

			f.NxTip = Map.TaxiName
			f.texture:SetTexture ("Interface\\Icons\\Ability_Mount_Wyvern_01")
			self:ClipFrameW (f, x, y, 16, 16, 0)

			self.Level = self.Level + 2
		end
	end

	-- Battle ground or manual pal tracking

	if (palX or comTrackX) and (inBG or next (self.TrackPlyrs)) then

		if palX then

			self.TrackName = palName
			self:DrawTracking (plX, plY, palX, palY, false, "B")
		else
			self.TrackName = comTrackName
			self:DrawTracking (plX, plY, comTrackX, comTrackY, false)
		end

		self.Level = self.Level + 2
	end

	-- Set final levels

	self.TextScFrm:SetFrameLevel (self.Level)
	self.PlyrFrm:SetFrameLevel (self.Level + 1)

	self.ToolBar:SetLevels (self.Level + 2)

	self.Level = self.Level + 3

	self:MinimapUpdateEnd()		-- Uses 2 levels

	self.LocTipFrm:SetFrameLevel (self.Level + 2)

	-- Hide leftovers

	self:HideExtraIcons()

	-- Scan. Switch maps if needed. Do at end so we dont glitch

	if Nx.Tick % self.ScanContinentsMod == 3 then
		self:ScanContinents()
	end

	if doSetCurZone then
		self:SetToCurrentZone()
	end

	-- Debug
--[[
	Nx.prt ("Map WPos %s ZPos %s WScale %s", self.GetWorldPosCnt or 0, self.GetZonePosCnt or 0, self.GetWorldZoneScaleCnt or 0)
	self.GetWorldPosCnt = 0
	self.GetZonePosCnt = 0
	self.GetWorldZoneScaleCnt = 0
--]]

end

function Nx.Map:SetInstanceMap (mapId)	
	self.InstMapId = nil
	if not mapId then
		return
	end
	local Map = Nx.Map
	local info = Map.InstanceInfo[mapId]
    
    if not(info) then
        Nx.Map:GetInstanceMapTextures(mapId)		
        info=Map.InstanceInfo[mapId]
    end
	
	local sizex, sizey = 1002, 668	
	if info then	
		self:SetCurrentMap (mapId)		
		self.InstMapId = mapId
		self.InstMapInfo = info
		local winfo = Map.MapWorldInfo[mapId]
		local wx = winfo[2]
		local wy = winfo[3]
		self.InstMapWX1 = wx
		self.InstMapWY1 = wy
		self.InstMapWX2 = wx + sizex / 256
		self.InstMapWY2 = wy + sizey / 256 * #info / 3
	end
end

function Nx.Map:GetInstanceMapTextures(mapId)
    local areaId = Nx.IdToAId[mapId]		
    if areaId then
        SetMapByID(areaId)
        local mapName = GetMapInfo();
        local levels, first = GetNumDungeonMapLevels() 
        local useTerrainMap = DungeonUsesTerrainMap()
		if (areaId == 824) then
		  levels = 7		  
		  first = 1
		end
        Nx.Map.InstanceInfo[mapId] = {}
        for i=first,max(first,first+levels-1) do
            SetDungeonMapLevel(i)
            local level = useTerrainMap and i-1 or i
            local fileName = mapName.."\\"..mapName;
            if ( level > 0 ) then
                fileName = fileName..level.."_";
            end
            Nx.Map.InstanceInfo[mapId][(i-first)*3+1] = 0
            Nx.Map.InstanceInfo[mapId][(i-first)*3+2] = -100*(i-first)
            Nx.Map.InstanceInfo[mapId][(i-first)*3+3] = fileName			
        end
    end    
end

--------
-- Switch to a new map
-- self = map

function Nx.Map:SwitchRealMap (id)	
	if self:IsInstanceMap (id) then
		self:SetInstanceMap (id)			-- Turn it on
	else
		self:SetInstanceMap()				-- Turn it off
	end

	if self.GOpts["MapMMInstanceTogFullSize"] then
		self.LOpts.NXMMFull = false
		if self:IsInstanceMap (id) then
			self.LOpts.NXMMFull = true
		end
	else
		if self:IsInstanceMap(id) then		
			s = self.Scale
			self.Scale = 120.0			
		else
			self.Scale = self.RealScale			
		end
	end
end
--------
-- Scan the continents for POI data

function Nx.Map:ScanContinents()

	Nx.Map.ScanContinentsMod = 500

	local oldCont = GetCurrentMapContinent()
	if oldCont < 0 then
		return
	end

	local oldZone = GetCurrentMapZone()
	local mapLvl = GetCurrentMapDungeonLevel()
	local isMicroDungeon = select(4, GetMapInfo())
	
--	Nx.prt ("ScanContinents cont zone, %s %s", oldCont, oldZone)

	--

	WatchFrame:UnregisterEvent ("WORLD_MAP_UPDATE")

	local hideT = {}
	hideT[0] = true	-- WotLK has 0 index POIs for named locations
	hideT[6] = not self.GOpts["MapShowCCity"]
	hideT[41] = not self.GOpts["MapShowCExtra"]
	hideT[5] = not self.GOpts["MapShowCTown"]

	for cont = 1, self.ContCnt do

		local poiT = {}
		self.ContPOIs[cont] = poiT

		SetMapZoom (cont)
		local mapId = cont * 1000

		local name, description, txIndex, pX, pY
		local txX1, txX2, txY1, txY2
		local poiNum = GetNumMapLandmarks()

--		Nx.prt ("poiNum %d", poiNum)

		for n = 1, poiNum do
			name, desc, txIndex, pX, pY = GetMapLandmarkInfo (n)

			if name and not hideT[txIndex] then

				local poi = {}
				tinsert (poiT, poi)
				poi.Name = name
				poi.Desc = desc
				poi.TxIndex = txIndex

				local x, y = self:GetWorldPos (mapId, pX * 100, pY * 100)
				poi.WX = x
				poi.WY = y
			end
		end
	end

	--
--[[
	local members = MAX_PARTY_MEMBERS
	local unitName = "party"
	local raid

	if IsInRaid() > 0 then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
		raid = true
	end

	local pals = Nx.Com.PalNames
	local palName
	local palDist = 99999999
	local palX, palY
	local combatName
	local combatUnit
	local combatHealth
	local combatDist = 99999999
	local combatX, combatY

	local palsInfo = Nx.Com.PalsInfo

	for i = 1, members do

		local unit = unitName .. i
		local name, unitRealm = UnitName (unit)

		local mapId = self.MapId

		local pX, pY = GetPlayerMapPosition (unit)
		if pX <= 0 and pY <= 0 then

			local info = palsInfo[name]
			if info and info.EntryMId == mapId then
				mapId = info.MId
				pX = info.X + .00001
				pY = info.Y
			end

		else
			pX = pX * 100
			pY = pY * 100
		end

		if (pX ~= 0 or pY ~= 0) and not UnitIsUnit (unit, "player") then

			local fullName = unitRealm and (name .. "-" .. unitRealm) or name

			local wx, wy = self:GetWorldPos (mapId, pX, pY)

		end
	end
--]]
	-- Restore

    if(isMicroDungeon)then
        SetMapToCurrentZone() 
	else
		SetMapZoom (oldCont, oldZone)
		SetDungeonMapLevel (mapLvl)
	end
	
	WatchFrame:RegisterEvent ("WORLD_MAP_UPDATE")
end

--------
-- Draw the continents POI data

function Nx.Map:DrawContinentsPOIs()

	if self.ScaleDraw > self.LOpts.NXPOIAtScale then

		if not Nx.CharOpts["MapShowGatherA"] then
			return
		end
	end

	local getCoords = GetPOITextureCoords

	for cont = 1, self.ContCnt do

		for k, poi in ipairs (self.ContPOIs[cont]) do

			local txi = poi.TxIndex
			local z = txi == 177 and 13 or 3

			local f = self:GetIcon (z)

			if self:ClipFrameW (f, poi.WX, poi.WY, 16, 16, 0) then

				f.NxTip = poi.Name			 --.. poi.TxIndex

				-- 1 2
				-- 4 3

				local t1x, t1y, t4x, t4y, t2x = f.texture:GetTexCoord()

				f.texture:SetTexture ("Interface\\Minimap\\POIIcons")
				local txX1, txX2, txY1, txY2 = getCoords (txi)
--				f.texture:SetTexCoord (txX1 + .003, txX2 - .003, txY1 + .003, txY2 - .003)

				local x = txX1 + .003
				local y = txY1 + .003
				local w = txX2 - .003 - x
				local h = txY2 - .003 - y
				f.texture:SetTexCoord (x + w * t1x, x + w * t2x,
							y + h * t1y, y + h * t4y)

--				Nx.prtCtrl ("%s %s %s %s %s %s", t1x, t1y, t4x, t4y, t2x, t2y)
			end
		end
	end

	self.Level = self.Level + 1
end

--------
-- Draw group (raid or party)
-- (player world pos)

function Nx.Map:UpdateGroup (plX, plY)

	local alt = IsAltKeyDown()
	local redGlow = abs (GetTime() * 400 % 200 - 100) / 200 + .5

	local members = MAX_PARTY_MEMBERS
	local unitName = "party"
	local raid

	if IsInRaid() then
		members = MAX_RAID_MEMBERS
		unitName = "raid"
		raid = true
	end

	local pals = Nx.Com.PalNames
	local palName
	local palDist = 99999999
	local palX, palY
	local combatName
	local combatUnit
	local combatHealth
	local combatDist = 99999999
	local combatX, combatY

	local palsInfo = Nx.Com.PalsInfo

	--SetMapToCurrentZone()
	for i = 1, members do

		local unit = unitName .. i
		local name, unitRealm = UnitName (unit)

		local mapId = self.MapId

		local pX, pY = GetPlayerMapPosition (unit)
		if pX <= 0 and pY <= 0 then

			local info = palsInfo[name]
			if info and info.EntryMId == mapId then
				mapId = info.MId
				pX = info.X + .00001
				pY = info.Y
			end

		else
			pX = pX * 100
			pY = pY * 100
			local lvl = max (GetCurrentMapDungeonLevel(), 1)
			if GetCurrentMapAreaID() == 937 then
				if GetCurrentMapDungeonLevel() == 0 then
					lvl = 1
				else
					lvl = 2
				end			
			end			
--			pY = pY + (((lvl - 1) * 668) / 256)	
			pY = pY + (lvl - 1) * 100
		end

		if (pX ~= 0 or pY ~= 0) and not UnitIsUnit (unit, "player") then

			local fullName = unitRealm and #unitRealm > 0 and (name .. "-" .. unitRealm) or name

			local wx, wy = self:GetWorldPos (mapId, pX, pY)
			--Nx.prt("Pal2 %s %s %s", mapId, pX, pY)

			local sz = 16 * self.DotRaidScale
			if UnitInParty (unit) then
				sz = 18 * self.DotPartyScale
			end

			local cls = UnitClass (unit) or ""
			cls = _TRANS(cls)
			local inCombat
--PAIDS!
			inCombat = UnitAffectingCombat (unit)
--PAIDE!
			local h = UnitHealth (unit)
			if UnitIsDeadOrGhost (unit) then
				h = 0
			end
			local m = UnitHealthMax (unit)
			local per = min (h / m, 1)			-- Can overflow?

			if per > 0 then

				if pals[name] ~= nil or self.TrackPlyrs[name] then

--					Nx.prtCtrl ("Pal %s", name)

					sz = 20 * self.DotPalScale

					if self.TrackPlyrs[name] then
						sz = 25 * self.DotPalScale
					end

					local dist = (plX - wx) ^ 2 + (plY - wy) ^ 2
					if dist < palDist then
						palName = name
						palDist = dist
						palX, palY = wx, wy

--						Nx.prtCtrl ("Pal %s %s", name, dist)
					end
				end

				if inCombat then

					local dist = (plX - wx) ^ 2 + (plY - wy) ^ 2
					if dist < combatDist then
						combatName = name
						combatUnit = unit
						combatHealth = per
						combatDist = dist
						combatX, combatY = wx, wy
					end
				end
			end

			local f1 = self:GetIcon (1)

			if self:ClipFrameW (f1, wx, wy, sz, sz, 0) then

				f1.NXType = 1000
				f1.NXData = unit
				f1.NXData2 = fullName

				local inactive
				for n = 1, MAX_TARGET_DEBUFFS do
					if UnitDebuff (unit, n) == "Inactive" then
						inactive = true
						per = 0
						break
					end
				end

				local txName = "IconPlyrP"

				if pals[name] == false then
					txName = "IconPlyrF"
				elseif pals[name] == true then
					txName = "IconPlyrG"
				end

				if inCombat then
					txName = txName.."C"
				end

				f1.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\"..txName)

--				Nx.prt ("#%d %.1f %.1f", i, pX, pY)

				-- Show health

				local tStr = ""
--PAIDS!
				f = self:GetIconNI (2)

				if per > .33 then

					-- Horizontal bar at top left

					local sc = self.ScaleDraw
					self:ClipFrameTL (f, wx - 9 / sc, wy - 10 / sc, 16 * per / sc, 1 / sc)
--					self:ClipFrameZTLO (f, pX, pY, 12 * per / self.ScaleDraw, .9 / self.ScaleDraw, -7, -7)
					f.texture:SetTexture (1, 1, 1, 1)

				else
					self:ClipFrameW (f, wx, wy, 7, 7, 0)
--					self:ClipFrameZ (f, pX, pY, 7, 7, 0)

					if per > 0 then
						f.texture:SetTexture (1, .1, .1, 1 - per * 2)
					else
						if inactive then
							f.texture:SetTexture (1, 0, 1, .7)	-- Punk
						else
							f.texture:SetTexture (0, 0, 0, .5)	-- Dead
						end
					end
				end

				-- Show target info

				local unitTarget = unit.."target"
				local tName = UnitName (unitTarget)
				local tEnPlayer

				if tName then

					local tLvl = UnitLevel (unitTarget)
					local tCls = UnitClass (unitTarget) or ""
					if tName == tCls then
						tCls = ""
					end

					local th = UnitHealth (unitTarget)
					if UnitIsDeadOrGhost (unitTarget) then
						th = 0
					end
					local tm = max (UnitHealthMax (unitTarget), 1)
					local per = min (th / tm, 1)

--					Nx.prt ("H %d", th)

					local f = self:GetIconNI (2)
					local sc = self.ScaleDraw

					if UnitIsFriend ("player", unitTarget) then

						-- Horizontal green bar
						self:ClipFrameTL (f, wx - 9 / sc, wy - 2 / sc, 16 * per / sc, 1 / sc)
						f.texture:SetTexture (0, 1, 0, 1)

						tStr = format ("\n|cff80ff80%s %d %s %d", tName, tLvl, tCls, th)

						if not UnitIsPlayer (unitTarget) then	-- NPC?
							tStr = tStr .. "%"
						end
					else
						self:ClipFrameTL (f, wx - 9 / sc, wy - 9 / sc, 1 / sc, 15 * per / sc)

						if UnitIsPlayer (unitTarget) then

							tEnPlayer = true
							tStr = format ("\n|cffff4040%s %d %s %d%%", tName, tLvl, tCls, th)
							f.texture:SetTexture (redGlow, .1, 0, 1)

						elseif UnitIsEnemy ("player", unitTarget) then

							tStr = format ("\n|cffffff40%s %d %s %d%%", tName, tLvl, tCls, th)

							if Nx:UnitIsPlusMob (unitTarget) then
								f.texture:SetTexture (1, .4, 1, 1)
							else
								f.texture:SetTexture (1, 1, 0, 1)
							end

						else
							tStr = format ("\n|cffc0c0ff%s %d %s %d%%", tName, tLvl, tCls, th)
							f.texture:SetTexture (.7, .7, 1, 1)
						end
					end
				end
--PAIDE!
				local lvl = UnitLevel (unit)
				local qStr = Nx.Com:GetPlyrQStr (name)

				if raid then
					local name, rank, grp = GetRaidRosterInfo (i)
					cls = cls .. grp .. L[" G"]
				end

				f1.NxTip = format ("%s %d %s %d%%\n(%d,%d) %s %s%s", fullName, lvl, cls, per * 100, pX, pY, inactive and L["Inactive"] or "", tStr, qStr or "")

				if alt then
					-- tStr has \n
					local s = tEnPlayer and (name .. tStr) or name
					local txt = self:GetText (s)
					self:MoveTextToIcon (txt, f1, 15, 1)
				end
			end
		end
	end

	self.Level = self.Level + 3

	if palName and self.GOpts["HUDATBGPal"] then
		if not combatName or combatDist > palDist then
			self.TrackPlayer = palName
			return palName, palX, palY
		end
	end

	if combatName then

		if not self.InCombat or combatDist > 35 then
			self.TrackPlayer = combatName
			return format (L["Combat, %s %d%%"], combatName, combatHealth * 100), combatX, combatY
		end
	end
end

--------
-- Draw player position history

function Nx.Map:UpdatePlyrHistory()

	local Map = Nx.Map			-- Use global map
	local hist = Map.PlyrHist

	local tm = GetTime()

	local scale = self.BaseScale

	local x = hist.LastX - self.MoveLastX
	local y = hist.LastY - self.MoveLastY
	local moveDist = (x * x + y * y) ^ .5

	if moveDist > self.GOpts["MapTrailDist"] * scale then

		hist.LastX = self.MoveLastX
		hist.LastY = self.MoveLastY

		hist.Time = tm

		local next = hist.Next
		local o = next * 4 - 3

		hist[o] = GetTime()
		hist[o + 1] = self.PlyrX
		hist[o + 2] = self.PlyrY
		hist[o + 3] = self.PlyrDir

		if next >= hist.Cnt then
			next = 0
		end

		hist.Next = next + 1
	end

	local size = min (max (4 * self.ScaleDraw * self.BaseScale, 3), 25)
	local fadeTime = self.GOpts["MapTrailTime"]

	for n = 1, hist.Cnt * 4, 4 do

		local secs = hist[n]
		local tmdif = tm - secs

		if tmdif < fadeTime then

			local x = hist[n + 1]
			local y = hist[n + 2]
			local dir = hist[n + 3]

			local f = self:GetIconNI()

			if self:ClipFrameW (f, x, y, size, size, dir) then

				f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCircleFade")
				local a = (fadeTime - tmdif) / fadeTime * .9
				f.texture:SetVertexColor (1, 0, 0, a)

--				f.texture:SetTexture ("Interface\\Minimap\\MinimapArrow")
--				self:ClipFrameW (f, x, y, 16, 16, dir)
--				f.texture:SetVertexColor (1, 1, 1, .3)
			end

		end
	end
end

--------
-- Targets

function Nx.Map:UpdateTargets()

	local delay = self.UpdateTargetDelay
	if delay > 0 then
		self.UpdateTargetDelay = delay - 1
		return
	end

	local tar = self.Targets[1]

	local x = tar.TargetMX - self.PlyrX
	local y = tar.TargetMY - self.PlyrY
	local distYd = (x * x + y * y) ^ .5 * 4.575

	if distYd < (tar.Radius or 7) * self.BaseScale then

		if tar.TargetType ~= "Q" then	-- Not for quest, so clear

			self.UpdateTargetDelay = 20
			self.UpdateTrackingDelay = 0

--			Nx.prtVar ("", self.Targets[1])

			tremove (self.Targets, 1)

			if #self.Targets > 0 and self.GOpts["RouteRecycle"] then
				tinsert (self.Targets, tar)
			end

			if self.GOpts["HUDTSoundOn"] then
				Nx:PlaySoundFile ("sound\\interface\\magicclick.wav")
			end

			UIErrorsFrame:AddMessage (L["Target "] .. _TRANS(tar.TargetName) .. L[" reached"], 1, 1, 1, 1)

			self.Guide:ClearAll()

			if tar.RadiusFunc then
--				Nx.prt ("Target radius func")
				tar.RadiusFunc ("distance", tar.UniqueId, tar.Radius, distYd, distYd)
				tar.RadiusFunc = nil
			end
		end
	end
end

function Nx.Map:UpdateTracking()

	local delay = self.UpdateTrackingDelay - 1

	if delay <= 0 then

		self:CalcTracking()
		delay = 45
	end

	self.UpdateTrackingDelay = delay

	--

	self.Level = self.Level + 2

	local dist1
	local dir1

	local srcX = self.PlyrX
	local srcY = self.PlyrY

	for n = 1, #self.Tracking do

		local tr = self.Tracking[n]

		self:DrawTracking (srcX, srcY, tr.TargetMX, tr.TargetMY, tr.TargetTex, tr.Mode, tr.TargetName)

		if n == 1 then
			self.TrackName = tr.TargetName
			dist1 = self.TrackDistYd
			dir1 = self.TrackDir
		end

		srcX = tr.TargetMX
		srcY = tr.TargetMY
	end

	self.TrackDistYd = dist1
	self.TrackDir = dir1
end

function Nx.Map:CalcTracking()

	Nx.Timer:ProfilerStart ("Map Tracking")

	local Travel = Nx.Travel

	local tr = {}
	self.Tracking = tr

	local srcX = self.PlyrX
	local srcY = self.PlyrY
	local srcMapId = self.RMapId

	for n, tar in ipairs (self.Targets) do

		Travel:MakePath (tr, srcMapId, srcX, srcY, tar.MapId, tar.TargetMX, tar.TargetMY, tar.TargetType)

		tinsert (tr, tar)

		srcX = tar.TargetMX
		srcY = tar.TargetMY
		srcMapId = tar.MapId
	end

	Nx.Timer:ProfilerEnd ("Map Tracking")
end

--------
-- Draw a tracking cursor and lines

function Nx.Map:DrawTracking (srcX, srcY, dstX, dstY, tex, mode, name)

	local x = dstX - srcX
	local y = dstY - srcY

	local dist = (x * x + y * y) ^ .5
	self.TrackDistYd = dist * 4.575

	if tex ~= false then

		local f = self:GetIcon (1)

		local size = 16 * self.IconNavScale
		self:ClipFrameW (f, dstX, dstY, size, size, 0)

		local s = name or self.TrackName

		f.NxTip = format (L["%s\n%d yds"], s, dist * 4.575)

		f.texture:SetTexture (tex or "Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconWayTarget")
	end

	self.TrackDir = false

	if 1 then

		local dir = math.deg (math.atan2 (y, x)) + 90

		self.TrackDir = dir

		local sx = self.ScaleDraw
		local sy = self.ScaleDraw / 1.5

		x = x * sx
		y = y * sy

		-- Offset toward target
--		local off = 1 / sqrt (x * x + y * y)
--		local xo = x * off
--		local yo = y * off

		local cnt = (x * x + y * y) ^ .5 / 15 / self.IconNavScale
		if cnt < 5 then
			cnt = cnt + .5
		end
		cnt = min (floor (cnt), 40)

		if cnt >= 1 then

			local dx = x / cnt
			local dy = y / cnt

			local offset = self.ArrowScroll
			x = dx * offset
			y = dy * offset

			local size = 16 * self.IconNavScale
--			local pulse = floor (self.ArrowPulse)
			local usedIcon = true
			local f

			for n = 1, cnt do

				local wx = srcX + x / sx
				local wy = srcY + y / sy

--[[			-- Needed if we use an offset
				if n >= cnt then
					if sqrt ((wx - srcX) ^ 2 + (wy - plY) ^ 2) > dist then
						Nx.prt ("Target arrow")
						break
					end
				end
--]]
				if usedIcon then
					usedIcon = false
					f = self:GetIconNI()
				end

				if self:ClipFrameW (f, wx, wy, size, size, dir) then

					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconArrowGrad")

--					local a = n == pulse and .8 or .2
--					f.texture:SetVertexColor (1, 1, 1, a)

					if mode == "B" then
						f.texture:SetVertexColor (.7, .7, 1, .5)
					elseif mode == "F" then
						f.texture:SetVertexColor (1, 1, 0, .9)
					elseif mode == "D" then
						f.texture:SetVertexColor (1, 0, 0, 1)
					end

					usedIcon = true
				end

				x = x + dx
				y = y + dy
			end
		end
	end
end

--------
-- Move continent frames

function Nx.Map:MoveContinents()

	if self.CurOpts.NXWorldShow then

		for contN = 1, Nx.Map.ContCnt do
			local lvl = contN <= 2 and self.Level or self.Level + 1
			self:MoveZoneTiles (contN, 0, self.ContFrms[contN], self.WorldAlpha, lvl)
		end

		local f = self.ContFillFrm
		if f then
			if Nx.V30 then
				self:ClipFrameTL (f, 1600, -1600, 1500, 4400, 0)
			else
				self:ClipFrameTL (f, 1600, -1900, 1500, 4650, 0)
			end
			f:SetFrameLevel (self.Level + 1)
			f:SetAlpha (self.WorldAlpha)
		end

--[[	-- Map cap
		local frms, frm

		frms = self.ContFrms[self.Cont or 1]

		for i = 1, 12 do
			frm = frms[i]
			if frm then
				frm.texture:SetVertexColor (0, 0, 0, 1)
			end
		end
--]]
		self.Level = self.Level + 2

	else

		local frms, frm

		for contN = 1, Nx.Map.ContCnt do
			frms = self.ContFrms[contN]

			for i = 1, 12 do
				frm = frms[i]
				if frm then
					frm:Hide()
				end
			end
		end

		if self.ContFillFrm then
			self.ContFillFrm:Hide()
		end
	end
end

--------
-- Check world zone hotspots

function Nx.Map:CheckWorldHotspots (wx, wy)

	if self.InstMapId then
		if wx >= self.InstMapWX1 and wx <= self.InstMapWX2 and wy >= self.InstMapWY1 and wy <= self.InstMapWY2 then

			local lvl = floor ((wy - self.InstMapWY1) / 668 * 256) + 1

			if self.InstMapId ~= self.MapId then

--				Nx.prt ("Hit Inst %s, lvl %s", self.InstMapId, lvl)

				self:SetCurrentMap (self.InstMapId)
			end

			SetDungeonMapLevel (lvl)

			self.InstLevelSet = -1

			self.WorldHotspotTipStr = Nx.MapIdToName[self.InstMapId] .. "\n"

			return
		end
	end

	local quad1 = self.WorldHotspotsCity
	local quad2 = self.WorldHotspots

	if self.NXCitiesUnder then
		quad1, quad2 = quad2, quad1
	end

	if self:CheckWorldHotspotsType (wx, wy, quad1) then
		return
	end

	if self:CheckWorldHotspotsType (wx, wy, quad2) then
		return
	end

	self.WorldHotspotTipStr = false

--	local tt = GameTooltip
--	if tt:IsOwned (self.Win.Frm) and self.TooltipType == 1 then
--		tt:Hide()
--	end
end

--------
-- Check world zone hotspots type
-- This is very fast. No need to make a quad tree

function Nx.Map:CheckWorldHotspotsType (wx, wy, quad)

	for n, spot in ipairs (quad) do
		if wx >= spot.WX1 and wx <= spot.WX2 and wy >= spot.WY1 and wy <= spot.WY2 then

			local curId = self:GetCurrentMapId()
			curId = self.MapWorldInfo[curId].Level1Id or curId

			if spot.MapId ~= curId then

--				Nx.prt ("hotspot %s %s %s %s %s", spot.MapId, spot.WX1, spot.WX2, spot.WY1, spot.WY2)

				self:SetCurrentMap (spot.MapId)
			end

			self.WorldHotspotTipStr = spot.NxTipBase .. "\n"
--[[
			if false then

				local tt = GameTooltip
				local owner = self.Win.Frm

				owner.NXTip = spot.NxTipBase

				if not tt:IsVisible() then

--					Nx.prt ("hotspot tip")

					local tippos = "ANCHOR_TOPLEFT"

					Nx.TooltipOwner = owner
					self.TooltipType = 1

					tt:SetOwner (owner, tippos, 0, 0)
					Nx:SetTooltipText (owner.NXTip .. Nx.Map.PlyrNamesTipStr)

					owner["UpdateTooltip"] = Nx.Map.OnUpdateTooltip
				end
			end
--]]
			return true
		end
	end
end

--------
-- Called by tooltip
-- self = frame

--[[
function Nx.Map:OnUpdateTooltip()

	local map = self.NxMap
	map:BuildPlyrLists()

	Nx:SetTooltipText (self.NXTip .. map.TipStr .. Nx.Map.PlyrNamesTipStr)

--	Nx.prt ("OnUpdateTooltip %s %s", self.NXTip, map.TipStr)
end
--]]

--------
-- Move world zone hotspot frames

--[[
function Nx.Map:MoveWorldHotspots()

	local clip = self.ClipFrameTL

	local level = self.Level
	local alpha = 0

	if self.Debug then
		level = level + 15
		alpha = self.BackgndAlpha * .5
	end

	self.Level = self.Level + 2

	local cont = self.Cont
	local zone = self.Zone

	local _, zx, zy, zw, zh = self:GetWorldZoneInfo (cont, zone)
	if not zx then
		return
	end

--	Nx.prt ("Map World XY "..basex.." "..basey)

	local frms = self.WorldHotFrms

	frms.UpStart = (frms.UpStart + 1) % 3

	for n = frms.UpStart + 1, #frms, 3 do

		local f = frms[n]

		if clip (self, f, f.NXWX, f.NXWY, f.NXW, f.NXH) then

			if self.DebugMap then
				f.texture:SetVertexColor (1, 1, 1, alpha)
			end

			f:SetFrameLevel (level + f.NXLev)

			f.NxTip = f.NxTipBase .. self.TipStr .. "~T"
		end
	end
end
--]]

--------
-- Update 

function Nx.Map:SetLevelWorldHotspots()
--[[
	local lvl =	self.NXCitiesUnder and -1 or 1

	for _, f in ipairs (self.WorldHotFrms) do
		if f.NXLev ~= 0 then		-- A city?
			f.NXLev = lvl
		end
	end
--]]
end

--------
-- Update map zone tiles

function Nx.Map:MoveCurZoneTiles (clear)

	local mapId = self.MapId
	local wzone = self:GetWorldZone (mapId)

	if not clear and
			(not wzone or wzone.City or (wzone.StartZone and self.RMapId == mapId) or
			self:IsBattleGroundMap (mapId)) or self:IsMicroDungeon(mapId) then

--		Nx.prt ("MoveCurZoneTiles %d", mapId)

		local alpha = self.BackgndAlpha * (wzone.Alpha or 1)

		self:MoveZoneTiles (self.Cont, self.Zone, self.TileFrms, alpha, self.Level)
		self.Level = self.Level + 1

	else
		local frms, frm

		frms = self.TileFrms

		for i = 1, 12 do
			frm = frms[i]
			if frm then
				frm:Hide()
			end
		end
	end
end

--------
-- Hide extra (Dalaran) map zone tiles

function Nx.Map:HideExtraZoneTiles()

	local frms = self.TileFrms
	frms[4]:Hide()
	frms[8]:Hide()
	frms[9]:Hide()
	frms[12]:Hide()
end

--------
-- Update map zone tiles (4x3 blocks)

function Nx.Map:MoveZoneTiles (cont, zone, frms, alpha, level)

	local zname, zx, zy, zw, zh = self:GetWorldZoneInfo (cont, zone)
	if not zx then
		return
	end

--	Nx.prt ("MapZ %f, %f", zx, zy)

	local scale = self.ScaleDraw

	local clipW = self.MapW
	local clipH = self.MapH
	local x = (zx - self.MapPosXDraw) * scale + clipW / 2
	local y = (zy - self.MapPosYDraw) * scale + clipH / 2
	local bx = 0
	local by = 0
	local bw = zw * 1024 / 1002 / 4 * scale
	local bh = zh * 768 / 668 / 3 * scale
	local w, h
	local texX1, texX2
	local texY1, texY2

	for i = 1, 12 do

		local frm = frms[i]
		if frm then

			texX1 = 0
			texX2 = 1
			texY1 = 0
			texY2 = 1

			local vx0 = bx * bw + x
			local vx1 = vx0
			local vx2 = vx0 + bw

			if vx1 < 0 then
				vx1 = 0
				texX1 = (vx1 - vx0) / bw
			end

			if vx2 > clipW then
				vx2 = clipW
				texX2 = (vx2 - vx0) / bw
			end

			local vy0 = by * bh + y
			local vy1 = vy0
			local vy2 = vy0 + bh

			if vy1 < 0 then
				vy1 = 0
				texY1 = (vy1 - vy0) / bh
			end

			if vy2 > clipH then
				vy2 = clipH
				texY2 = (vy2 - vy0) / bh
			end

			w = vx2 - vx1
			h = vy2 - vy1

			if w <= 0 or h <= 0 then
				frm:Hide()
			else
				frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)
				frm:SetWidth (w)
				frm:SetHeight (h)
				frm:SetFrameLevel (level)

				frm.texture:SetTexCoord (texX1, texX2, texY1, texY2)
				frm.texture:SetVertexColor (1, 1, 1, self.BackgndAlpha)

				frm:Show()
			end
		end

		bx = bx + 1

		if bx >= 4 then
			bx = 0
			by = by + 1
		end
	end
end

--------
-- Add old map zone to list

function Nx.Map:AddOldMap (newMapId)

	if self.MapId == 0 then		-- Happens on startup
		return
	end

	-- Remove any for new zone

	local off = 1
	local dup

	for n = 1, #self.MapsDrawnOrder do
		if self.MapsDrawnOrder[off] == newMapId then
			tremove (self.MapsDrawnOrder, off)
			dup = true
		else
			off = off + 1
		end
	end

	local drawCnt = self.GOpts["MapZoneDrawCnt"]

	if not dup then

--		Nx.prt ("no dup")

		local extra = #self.MapsDrawnOrder - drawCnt + 2
		for n = 1, extra do
			tremove (self.MapsDrawnOrder, 1)
		end
	end

	if drawCnt > 1 then

		self.MapsDrawnFade[self.MapId] = -1
		tinsert (self.MapsDrawnOrder, self.MapId)		-- Newest at end

--		Nx.prt ("Cur map %s", self:GetCurrentMapId())
--		Nx.prtVar ("order", self.MapsDrawnOrder)
	end
end

--------
-- Update the zones

function Nx.Map:UpdateZones()

	local mapId = self.MapId
	local winfo = self.MapWorldInfo[mapId]

--	Nx.prt ("UpdateZones %s, %s", mapId, winfo.Name or "nil")

	local s = self.LOpts.NXDetailScale

	local freeOrScale = self.ScaleDraw <= s

	if freeOrScale or
		winfo.City or
		(winfo.StartZone and self.RMapId == mapId) or
		self:IsBattleGroundMap (mapId) or
		self:IsMicroDungeon(mapId) then

--		if freeOrScale and self.MapIdOld and self.MapIdOld ~= mapId then
--			self:UpdateOverlay (id, .8, true)
--		end

		for n, id in ipairs (self.MapsDrawnOrder) do
			self:UpdateOverlay (id, .8, true)
		end
--[[
		if freeOrScale then

			local abs = abs

			for id, fade in pairs (self.MapsDrawnFade) do

				if id ~= mapId then
					self:UpdateOverlay (id, abs (fade) * .8, true)
				end

				if fade > 0 then
					fade = fade + .1
					self.MapsDrawnFade[id] = fade <= 1 and fade or 1

				elseif fade < 0 then
					fade = fade + .1
					self.MapsDrawnFade[id] = fade < 0 and fade or nil
				end
			end
		end
--]]
--[[
			if mapId >= 1000 and mapId <= 1999 then

				for id = 1001, 1024 do
					if id ~= mapId then
						self:UpdateOverlay (id, .8)
					end
				end

			elseif mapId >= 2000 and mapId <= 2999 then

				for id = 2001, 2028 do
					if id ~= mapId then
						self:UpdateOverlay (id, .8)
					end
				end

			elseif mapId >= 3000 and mapId <= 3999 then

				for id = 3001, 3008 do
					if id ~= mapId then
						self:UpdateOverlay (id, .8)
					end
				end
			end
--]]
		if winfo.City then
--			Nx.prt ("city %s", self.Level)
			self:UpdateMiniFrames()
			self:MoveCurZoneTiles()

		else
			self:MoveCurZoneTiles()
			self:UpdateOverlay (mapId, 1)
			self:UpdateMiniFrames()
		end

	else
		self:MoveCurZoneTiles (true)		-- Clear
		self:UpdateMiniFrames()

	end
end

function Nx.Map:GetExploredOverlayNum()

--	local overlayNum = GetNumMapOverlays()		-- Cartographer makes this return 0

	for i = 1, 999 do
		local txName = GetMapOverlayInfo (i)
		if not txName then
			return i
		end
	end
end

function Nx.Map:UpdateOverlayUnexplored()

	self.CurOverlays = false
	local txFolder

	local mapId = self:GetCurrentMapId()

	local wzone = self:GetWorldZone (mapId)
	if wzone then
		if wzone.City then
			return
		end
		txFolder = wzone.Overlay
	end

	local overlays

	if txFolder then
		overlays = Nx.Map.ZoneOverlays[txFolder]
	end

	if not overlays or not self.ShowUnexplored then

--		local overlayNum = GetNumMapOverlays()		-- Cartographer makes this return 0
--		Nx.prt ("Overlays %s", overlayNum)

		local s1, s2, file
		local ol = {}

		if overlays then
			for txName, whxyStr in pairs (overlays) do	-- Copy overlay table
				ol[txName] = whxyStr
			end
		end

		overlays = ol

		for i = 1, 99 do

			-- Terrokar has 4 overlays with "" for name

			local txName, txW, txH, oX, oY = GetMapOverlayInfo (i)
			if not txName then
				break
			end

			local s1, s2, folder, file = strfind (txName, ".+\\.+\\(.+)\\(.+)")
			if s1 then
				txFolder = folder
				file = strlower (file)
				overlays[file] = format ("%d,%d,%d,%d", oX - 10000, oY, txW, txH)

--				Nx.prt (" %s %s", txName, overlays[file])
			end
		end

		if not txFolder then		-- Can happen on log in
			overlays = false
		end
	end

	self.CurOverlays = overlays
	self.CurOverlaysTexFolder = txFolder
end

function Nx.Map:TargetOverlayUnexplored()

	local mapId = self:GetCurrentMapId()

	self:ClearTargets()		-- Will change current mapid

	local wzone = self:GetWorldZone (mapId)
	if wzone and wzone.City then
		return
	end

	local overlays = self.CurOverlays

	if not overlays then	-- Not found? New stuff probably
		return
	end

	for txName, whxyStr in pairs (overlays) do

		local oX, oY, txW, txH = strsplit (",", whxyStr)

		oX = tonumber (oX)
		oY = tonumber (oY)

		if oX >= 0 then

			txW = tonumber (txW)
			txH = tonumber (txH)

			if txW == 512 then
				txW = txW * .75
			end
			if txH == 512 then
				txH = txH * .75
			end

--			Nx.prt ("%s %s %s %s %s", txName, oX, oY, txW, txH)

			local x, y = (oX + txW / 2) / 1002 * 100, (oY + txH / 2) / 668 * 100
--			local wx, wy = self:GetWorldPos (mapId, (oX) / 1002 * 100, (oY) / 668 * 100)

			self:SetTargetXY (mapId, x, y, "Explore", true)
		end
	end
end

--------
-- Update the overlays

function Nx.Map:UpdateOverlay (mapId, bright, noUnexplored)

	local wzone = self:GetWorldZone (mapId)
	if wzone and (wzone.City or self:IsMicroDungeon(mapId)) then
		return
	end

	local txFolder = wzone and wzone.Overlay or ""
	local overlays = Nx.Map.ZoneOverlays[txFolder]
	local unex

	if not noUnexplored and (not overlays or not self.ShowUnexplored) then

		if not (wzone and wzone.Explored) then
			unex = true
		end

		overlays = self.CurOverlays
		txFolder = self.CurOverlaysTexFolder
	end

	if not overlays then	-- Not found? New stuff probably
		return
	end

	local bW, bH
	local txIndex
	local txPixelW, txFileW, txPixelH, txFileH

	local path = "Interface\\Worldmap\\" .. txFolder .. "\\"

	local alpha = self.BackgndAlpha
	local unExAl = self.LOpts.NXUnexploredAlpha

	local zscale = self:GetWorldZoneScale (mapId) / 10

	for txName, whxyStr in pairs (overlays) do

		local lev = 0
		local brt = bright

		txName = path .. txName

		local oX, oY, txW, txH, mode = strsplit (",", whxyStr)

		txW = tonumber (txW)
		txH = tonumber (txH)
		oX = tonumber (oX)
		oY = tonumber (oY)

		if unex then		-- Dimming unexplored?
			if oX < 0 then
				oX = oX + 10000	-- Fix explored x
			else
				brt = unExAl		-- Dim
				lev = 1
			end
		end

--		if self.Debug then
--			Nx.prt ("%d %f %f", i, oX, oY)
--		end

		bW = ceil (txW / 256)
		bH = ceil (txH / 256)
		txIndex = 1

		for bY = 0, bH - 1 do

			if bY < bH - 1 then
				txPixelH = 256
				txFileH = 256
			else
				txPixelH = mod (txH, 256)
				if txPixelH == 0 then
					txPixelH = 256
				end
				txFileH = 16
				while txFileH < txPixelH do
					txFileH = txFileH * 2
				end
			end

			for bX = 0, bW - 1 do

				if bX < bW - 1 then
					txPixelW = 256
					txFileW = 256
				else
					txPixelW = mod (txW, 256)
					if txPixelW == 0 then
						txPixelW = 256
					end
					txFileW = 16
					while txFileW < txPixelW do
						txFileW = txFileW * 2
					end
				end

				local f = self:GetIconNI (lev)

				local wx, wy = self:GetWorldPos (mapId, (oX + bX * 256) / 1002 * 100, (oY + bY * 256) / 668 * 100)

				if self:ClipFrameTL (f, wx, wy, txFileW * zscale, txFileH * zscale) then

--					if IsShiftKeyDown() then
--						f.texture:SetTexture (1, 0, 0)
--					end
--[[
					if IsAltKeyDown() then		-- DEBUG!
						alpha = .2
					end
--]]
					f.texture:SetTexture (mode and txName or txName .. txIndex)
					f.texture:SetVertexColor (brt, brt, brt, alpha)

--					if IsControlKeyDown() then
--						Nx.prt ("Overlay %s, %s, %s %s", txName, txIndex, oX, oY)
--					end

--[[ -- Map cap
					if bright < 1 then
						f.texture:SetVertexColor (1, 1, 1, 1)
--						SetDesaturation (f.texture, 1)
					end
--]]
				end

				txIndex = txIndex + 1
			end
		end
	end

	self.Level = self.Level + 2
end

--------
-- Update frames for mini map texture layer (detail layer)

function Nx.Map:UpdateMiniFrames()

--[[
	SaveView (5)
--	local x = GetCVar ("cameraYawD")
--	local y = GetCVar ("cameraPitchD")
--	local isLook = IsMouselooking()

--	Nx.prtCtrl ("Cam %s %s %s", x, y, isLook or "nil")

	local vartest = {
		"cameraYaw",
		"cameraYawA",
		"cameraYawB",
		"cameraYawC",
		"cameraYawD",
	}

	for k, name in pairs (vartest) do
		Nx.prtCtrl ("Cam %s %s", name, GetCVar (name) or "nil")
	end
--]]

	local Map = Nx.Map
	local mapId = self.MapId
	local winfo = self.MapWorldInfo[mapId]

	local opts = self.LOpts

	local alphaRange = opts.NXDetailScale * .35
	local s = opts.NXDetailScale - alphaRange

--	s = .1

--	or winfo.City

	if self.ScaleDraw <= s or opts.NXDetailAlpha <= 0 or self:IsBattleGroundMap (mapId) or self:IsMicroDungeon(mapId) then
		self:HideMiniFrames()
		return
	end

	local alphaPer = min ((self.ScaleDraw - s) / alphaRange, 1)
--	Nx.prt ("alpha %s", alphaPer)

--	local cont = self.Cont
--	local zname, zx, zy

	local miniT, basex, basey = self:GetMiniInfo (mapId)
	if not miniT then
		self:HideMiniFrames()
		return
	end

	local level = self.Level
	self.Level = self.Level + 1

	local f
	local frmNum = 1

	local scale = 256 * 0.416767770014
	local size = scale

--	size = size - 4

	local miniX = floor ((self.MapPosXDraw - basex) / scale - self.MiniBlks / 2 + .5)
	local miniY = floor ((self.MapPosYDraw - basey) / scale - self.MiniBlks / 2 + .5)

--	Nx.prt ("MiniXY %f %f", miniX, miniY)

	basex = basex + miniX * scale
	basey = basey + miniY * scale

	local wx
	local wy = basey
	local al = self.BackgndAlpha * opts.NXDetailAlpha * alphaPer

	for y = miniY, miniY + self.MiniBlks - 1 do

		wx = basex

		for x = miniX, miniX + self.MiniBlks - 1 do

			f = self.MiniFrms[frmNum]
			local txname = Map:GetMiniBlkName (miniT, x, y)

			if txname then

				if self:ClipFrameTL (f, wx, wy, size, size) then

					f:SetFrameLevel (level)
					f.texture:SetVertexColor (1, 1, 1, al)
--					txname = "Textures\\Minimap\\"..txname
					f.texture:SetTexture (txname)

--[[
--					Nx.prtCtrl ("%s %s, %s", x, y, txname)

					local r, r2, r3 = f.texture:SetTexture (txname)		--V4 always returns r=1?
					Nx.prtVar ("mmtex", r)
					Nx.prtVar ("mmtex2", r2)
					Nx.prtVar ("mmtex3", r3)
					if not r then
						Nx.prtCtrl ("%s %s, %s", x, y, txname)
					end
--]]
				end

			else

				f:Hide()
			end

			wx = wx + scale
			frmNum = frmNum + 1
		end

		wy = wy + scale
	end

end

function Nx.Map:HideMiniFrames()

	for n = 1, self.MiniBlks ^ 2 do
		self.MiniFrms[n]:Hide()
	end
end

--------
-- Update POI

--[[
Nx.POITypes = { "Mailbox", "Anvil", "Forge", "Moonwell", "Manaloom" }
Nx.POITex = { "Icons\\INV_Letter_15",
	"Icons\\Trade_BlackSmithing",
	"Icons\\INV_Sword_09",
	"Icons\\Spell_Fire_BlueFlameRing",
	"Icons\\Spell_Fire_BlueFlameRing"
}

function Nx.Map:UpdateNxPOI()

	local Map = Nx.Map

	for poiType, v in pairs (Nx.POI) do

		local str = Nx.POI[poiType]

		for n = 1, #str, 5 do

			local zone = strbyte (str, n)
			if not zone then
				break
			end

			zone = zone - 35

			local x = ((strbyte (str, n + 1) - 35) * 221 + (strbyte (str, n + 2) - 35)) / 100
			local y = ((strbyte (str, n + 3) - 35) * 221 + (strbyte (str, n + 4) - 35)) / 100

			if self.Debug then
--				Nx.prt ("POI #%d %d %d %d", (n+4) / 5, zone, x, y)
			end

			local mapId = Map.NxzoneToMapId[tonumber (zone)]

			if not mapId then
--				Nx.prt ("POI #%d %d %d %d", (n+4) / 5, zone, x, y)

			else
				x, y = self:GetWorldPos (mapId, x, y)

				local f = self:GetIcon()

				if self:ClipFrameW (f, x, y, 16, 16, 0) then
					f.NxTip = format ("%s", Nx.POITypes[poiType])
					f.texture:SetTexture ("Interface\\" .. Nx.POITex[poiType])
				end
			end
		end
	end
end
--]]

--------
--
--[[
function Nx.Map:DrawZoneRect (mapId, x, y, w, h, tip)

	mapId = mapId or self.MapId

	local wx, wy = self:GetWorldPos (mapId, x, y)
	local scale = self:GetWorldZoneScale (mapId) / 10.02

	local f = map:GetIcon()

	if self:ClipFrameTL (f, wx, wy, w * scale, h * scale) then
		f.NxTip = tip
		f.texture:SetTexture (r, g, b, .5)
	end
end
--]]

--------
-- Zone clip a frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function Nx.Map:ClipFrameZ (frm, x, y, w, h, dir)

	x, y = self:GetWorldPos (self.MapId, x, y)
	return self:ClipFrameW (frm, x, y, w, h, dir)
end

--------
-- Zone clip a frame to the map and set position (top left), size and texture coords
-- Width and height are scaled

function Nx.Map:ClipFrameZTL (frm, x, y, w, h)

	x, y = self:GetWorldPos (self.MapId, x, y)
	return self:ClipFrameTL (frm, x, y, w, h)
end

--------
-- Zone clip a frame (top left with offset)
-- Width and height are scaled

function Nx.Map:ClipFrameZTLO (frm, x, y, w, h, xo, yo)

	x, y = self:GetWorldPos (self.MapId, x, y)
	return self:ClipFrameTL (frm, x + xo / self.ScaleDraw, y + yo / self.ScaleDraw, w, h)
end

--------
-- Clip a frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function Nx.Map:ClipFrameW (frm, bx, by, w, h, dir)

--	Nx.Timer:ProfilerStart ("Map ClipFrameW", true)
--	Nx.Timer:ProfilerEnd ("Map ClipFrameW")

	local scale = self.ScaleDraw

	-- Calc x

	local bw = w
	local clipW = self.MapW
	local x = (bx - self.MapPosXDraw) * scale + clipW * .5

	local texX1 = 0
	local texX2 = 1

	local vx0 = x - bw * .5		-- Center frame at bx
	local vx1 = vx0
	local vx2 = vx0 + bw

	if vx1 < 0 then
		vx1 = 0
		texX1 = (vx1 - vx0) / bw
	end

	if vx2 > clipW then
		vx2 = clipW
		texX2 = (vx2 - vx0) / bw
	end

	w = vx2 - vx1

	if w < .3 then

--		Nx.Timer:ProfilerStart ("Map ClipFrameW x", true)
--		Nx.Timer:ProfilerEnd ("Map ClipFrameW x")

		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Calc y

	local bh = h
	local clipH = self.MapH
	local y = (by - self.MapPosYDraw) * scale + clipH * .5

	local texY1 = 0
	local texY2 = 1

	local vy0 = y - bh * .5		-- Center frame at by
	local vy1 = vy0
	local vy2 = vy0 + bh

	if vy1 < 0 then
		vy1 = 0
		texY1 = (vy1 - vy0) / bh
	end

	if vy2 > clipH then
		vy2 = clipH
		texY2 = (vy2 - vy0) / bh
	end

	h = vy2 - vy1

	if h < .3 then

--		Nx.Timer:ProfilerStart ("Map ClipFrameW y", true)
--		Nx.Timer:ProfilerEnd ("Map ClipFrameW y")

		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Set frame

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)
	frm:SetWidth (w)
	frm:SetHeight (h)

	if dir == 0 then

		frm.texture:SetTexCoord (texX1, texX2, texY1, texY2)

	else
		-- 13 UV order
		-- 24
		local t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y

		-- Make UV range -.5 to .5
		texX1 = texX1 - .5
		texX2 = texX2 - .5
		texY1 = texY1 - .5
		texY2 = texY2 - .5

		local co = cos (dir)
		local si = sin (dir)
		t1x = texX1 * co + texY1 * si + .5
		t1y = texX1 * -si + texY1 * co + .5
		t2x = texX1 * co + texY2 * si + .5
		t2y = texX1 * -si + texY2 * co + .5
		t3x = texX2 * co + texY1 * si + .5
		t3y = texX2 * -si + texY1 * co + .5
		t4x = texX2 * co + texY2 * si + .5
		t4y = texX2 * -si + texY2 * co + .5
		frm.texture:SetTexCoord (t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y)

--		Nx.prt (" T1 "..t1x.." "..t1y)
--		Nx.prt (" T2 "..t2x.." "..t2y)
	end

	frm:Show()

	return true
end

--------
-- Clip a frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function Nx.Map:ClipFrameWChop (frm, bx, by, w, h)

	local bw = w
	local bh = h
	local clipW = self.MapW
	local clipH = self.MapH

	local scale = self.ScaleDraw
	local x = (bx - self.MapPosXDraw) * scale + clipW / 2
	local y = (by - self.MapPosYDraw) * scale + clipH / 2

	local texX1 = 0
	local texX2 = 1

	-- Center frame at bx, by

	local vx0 = x - bw * .5
	local vx1 = vx0
	local vx2 = vx0 + bw

	if vx1 < 0 then
		vx1 = 0
		texX1 = (vx1 - vx0) / bw
	end

	if vx2 > clipW then
		vx2 = clipW
		texX2 = (vx2 - vx0) / bw
	end

	w = vx2 - vx1

	if w < .3 then
		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	local texY1 = 0
	local texY2 = 1

	local vy0 = y - bh * .5
	local vy1 = vy0
	local vy2 = vy0 + bh

	if vy1 < 0 then
		vy1 = 0
		texY1 = (vy1 - vy0) / bh
	end

	if vy2 > clipH then
		vy2 = clipH
		texY2 = (vy2 - vy0) / bh
	end

	h = vy2 - vy1

	if h < .3 then
		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)
	frm:SetWidth (w)
	frm:SetHeight (h)

	frm.texture:SetTexCoord (texX1 * .9 + .05, texX2 * .9 + .05, texY1 * .9 + .05, texY2 * .9 + .05)

	frm:Show()

	return true
end

--------
-- Clip minimap frame to the map and set position, size and texture coords
-- XY is center. Width and height are not scaled

function Nx.Map:ClipMMW (frm, bx, by, w, h)

	local scale = self.ScaleDraw

	-- Each world unit maps to a pixel, so w * scale == size in pixels

	local bw = w * scale
	local bh = h * scale
	local clipW = self.MapW
	local clipH = self.MapH
	local x = (bx - self.MapPosXDraw) * scale + clipW * .5
	local y = (by - self.MapPosYDraw) * scale + clipH * .5

	local vx0 = x - bw * .5
	local vx1 = vx0
	local vx2 = vx0 + bw

	if vx1 < 0 or vx2 > clipW then
		return false
	end

	w = vx2 - vx1

	if w <= 0 then
		return false
	end

	local vy0 = y - bh * .5
	local vy1 = vy0
	local vy2 = vy0 + bh

	if vy1 < 0 or vy2 > clipH then
		return false
	end

	h = vy2 - vy1

	if h <= 0 then
		return false
	end

--	frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)
--	frm:SetWidth (w)
--	frm:SetHeight (h)

	local sc = w / 140
	self.MMFScale = sc

	local isc = self.GOpts["MapMMIScale"]
	self:MinimapSetScale (sc, isc)

--	frm:SetScale (sc)
	frm:SetPoint ("TOPLEFT", self.Frm, "TOPLEFT", vx1 / isc, (-vy1 - self.TitleH) / isc)

	frm:Show()

	return true
end

--------
-- Clip a frame to the map and set position (top left), size and texture coords
-- Width and height are scaled by base (zone) scale

function Nx.Map:ClipFrameTL (frm, bx, by, w, h)

	-- Each world unit maps to a pixel, so w * scale == size in pixels

	local scale = self.ScaleDraw

	-- Calc x

	local bw = w * scale
	local clipW = self.MapW
	local x = (bx - self.MapPosXDraw) * scale + clipW * .5

	local texX1 = 0
	local texX2 = 1

	local vx1 = x
	local vx2 = x + bw

	if vx1 < 0 then
		vx1 = 0
		texX1 = (vx1 - x) / bw
	end

	if vx2 > clipW then
		vx2 = clipW
		texX2 = (vx2 - x) / bw
	end

	w = vx2 - vx1

	if w < .3 then
		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Calc y

	local bh = h * scale
	local clipH = self.MapH
	local y = (by - self.MapPosYDraw) * scale + clipH * .5

	local texY1 = 0
	local texY2 = 1

	local vy1 = y
	local vy2 = y + bh

	if vy1 < 0 then
		vy1 = 0
		texY1 = (vy1 - y) / bh
	end

	if vy2 > clipH then
		vy2 = clipH
		texY2 = (vy2 - y) / bh
	end

	h = vy2 - vy1

	if h < .3 then
		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)

	if w <= 1.2 then		-- Adjust so we get a clean line
		w = self.Size1
		if w <= 0 then
			frm:SetWidth (.001)
			return
		end
	end

	if h <= 1.2 then
		h = self.Size1
		if h <= 0 then
			frm:SetWidth (.001)
			return
		end
	end

	frm:SetWidth (w)
	frm:SetHeight (h)

	frm.texture:SetTexCoord (texX1, texX2, texY1, texY2)

	frm:Show()

	return true
end

--------
-- Clip a frame to the map and set position (top left), size and texture coords
-- Width and height are scaled by base (zone) scale
-- Solid color texture version

function Nx.Map:ClipFrameTLSolid (frm, bx, by, w, h)

--	Nx.Timer:ProfilerStart ("Map ClipFrameTLSolid", true)
--	Nx.Timer:ProfilerEnd ("Map ClipFrameTLSolid")

	-- Each world unit maps to a pixel, so w * scale == size in pixels

	local scale = self.ScaleDraw

	-- Calc x

	local clipW = self.MapW
	local vx1 = (bx - self.MapPosXDraw) * scale + clipW * .5
	local vx2 = vx1 + w * scale

	if vx1 < 0 then
		vx1 = 0
	end

	if vx2 > clipW then
		vx2 = clipW
	end

	w = vx2 - vx1

	if w < .3 then
		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	-- Calc y

	local clipH = self.MapH
	local vy1 = (by - self.MapPosYDraw) * scale + clipH * .5
	local vy2 = vy1 + h * scale

	if vy1 < 0 then
		vy1 = 0
	end

	if vy2 > clipH then
		vy2 = clipH
	end

	h = vy2 - vy1

	if h < .3 then
		if self.ScrollingFrm ~= frm then
			frm:Hide()
		else
			frm:SetWidth (.001)
		end
		return false
	end

	frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)

	frm:SetWidth (w)
	frm:SetHeight (h)

	frm:Show()

	return true
end

--------
-- Clip full zone frame to map

function Nx.Map:ClipZoneFrm (cont, zone, frm, alpha)

	local zname, zx, zy, zw, zh

	zname, zx, zy, zw, zh = self:GetWorldZoneInfo (cont, zone)
	if not zx then
		return
	end

	local scale = self.ScaleDraw

	local clipW = self.MapW
	local clipH = self.MapH
	local x = (zx - self.MapPosXDraw) * scale + clipW / 2
	local y = (zy - self.MapPosYDraw) * scale + clipH / 2
	local bx = 0
	local by = 0
	local bw = zw * scale
	local bh = zh * scale
	local w, h

	local level = self.Level

	if frm then

		local vx0 = bx * bw + x
		local vx1 = vx0
		local vx2 = vx0 + bw

		local vy0 = by * bh + y
		local vy1 = vy0
		local vy2 = vy0 + bh

		w = vx2 - vx1
		h = vy2 - vy1

		if w <= 0 or h <= 0 then
			frm:Hide()
		else
			local sc = w / 1002
			vx1 = vx1 / sc
			vy1 = vy1 / sc
			frm:SetPoint ("TOPLEFT", vx1, -vy1 - self.TitleH)
			frm:SetScale (sc)
--			frm:SetFrameLevel (level)

			frm:Show()

--			Nx.prt ("ClipZF %f, %f (%s)", vx1, vy1, sc)
		end
	end
end

--------
-- Init a map icon type and set drawing info

function Nx.Map:InitIconType (iconType, drawMode, texture, w, h)

	local d = self.Data

	local t = wipe (d[iconType] or {})
	d[iconType] = t
	t.Num = 0
	t.Enabled = true
	t.DrawMode = drawMode or "ZP"	-- Zone point is default
	t.Tex = texture
	t.W = w
	t.H = h
	t.Scale = 1	-- USED???
	t.ClipFunc = self.ClipFrameW		-- For WP mode
end

--------
-- Clear a map icon type

function Nx.Map:ClearIconType (iconType)

	local d = self.Data
	d[iconType] = nil
end

--------
-- Set alpha for an icon type

function Nx.Map:SetIconTypeAlpha (iconType, alpha, alphaNear)

	local d = self.Data
	assert (d[iconType])

	d[iconType].Alpha = alpha
	d[iconType].AlphaNear = alphaNear
end

--------
-- Set at scale for an icon type

function Nx.Map:SetIconTypeAtScale (iconType, scale)

	local d = self.Data
	assert (d[iconType])

	d[iconType].AtScale = scale
end

--------
-- Set level for an icon type

function Nx.Map:SetIconTypeLevel (iconType, level)

	local d = self.Data
	assert (d[iconType])

	d[iconType].Lvl = level
end

--------
-- Set level for an icon type

function Nx.Map:SetIconTypeChop (iconType, on)

	local d = self.Data
	assert (d[iconType])

	d[iconType].ClipFunc = on and self.ClipFrameWChop or self.ClipFrameW
end

--------
-- Add point icon to map data
-- ret: icon

function Nx.Map:AddIconPt (iconType, x, y, color, texture)

	local d = self.Data

	assert (d[iconType])

	local tdata = d[iconType]
	tdata.Num = tdata.Num + 1		-- Use # instead??

	local icon = {}
	tdata[tdata.Num] = icon

	icon.X = x
	icon.Y = y
	icon.Color = color
	icon.Tex = texture

	assert (tdata.Tex or texture or color)

	return icon
end

--------
-- Get icon count

function Nx.Map:GetIconCnt (iconType)

	return #self.Data[iconType]
end

--------
-- Get point icon XY at index (for routing code)

function Nx.Map:GetIconPt (iconType, index)

	local icon = self.Data[iconType][index]
	return icon.X, icon.Y
end

--------
-- Add rectangle icon to map data (zone coords)
-- ret: icon

function Nx.Map:AddIconRect (iconType, mapId, x, y, x2, y2, color)

	local d = self.Data

	assert (d[iconType])

	local tdata = d[iconType]
	tdata.Num = tdata.Num + 1

	local icon = {}
	tdata[tdata.Num] = icon

	icon.MapId = mapId
	icon.X = x
	icon.Y = y
	icon.X2 = x2
	icon.Y2 = y2
	icon.Color = color

	return icon
end

--------
-- Add icon tool tip

function Nx.Map:SetIconTip (icon, tip)
	icon.Tip = tip
end

--------
-- Set user data

function Nx.Map:SetIconUserData (icon, data)
	icon.UData = data
end

--------
-- Set favorite data

function Nx.Map:SetIconFavData (icon, data1, data2)
	icon.FavData1 = data1
	icon.FavData2 = data2
end

--------
-- Set favorite data

function Nx.Map:GetIconFavData (icon)
	return icon.FavData1, icon.FavData2
end

--------
-- Update all icons

function Nx.Map:UpdateIcons (drawNonGuide)

	local c2rgb = Nx.Util_c2rgb
	local c2rgba = Nx.Util_c2rgba
	local d = self.Data

	local wpScale = 1
	local wpMin = self.GOpts["MapIconScaleMin"]
	if wpMin >= 0 then
		wpScale = self.ScaleDraw * .08
	end

	for type, v in pairs (d) do
		v.Enabled = drawNonGuide or strbyte (type) == 33	-- "!" is guide types

		if v.AtScale then
			if self.ScaleDraw < v.AtScale then
				v.Enabled = false
			end
		end
	end

	for k, v in pairs (d) do

--		Nx.prt ("UpdateIcons %s %s", k, v.DrawMode)

		if v.Enabled then

			if v.DrawMode == "ZP" then		-- Zone point

				local scale = self.IconScale
				local w = v.W * scale
				local h = v.H * scale

				for n = 1, v.Num do

					local icon = v[n]
					local f = self:GetIconStatic (v.Lvl)

					if self:ClipFrameZ (f, icon.X, icon.Y, w, h, 0) then

						f.NxTip = icon.Tip

--						assert (icon.Tex or v.Tex or icon.Color)

						if icon.Tex then
							f.texture:SetTexture (icon.Tex)

						elseif v.Tex then
							f.texture:SetTexture (v.Tex)

						else
							f.texture:SetTexture (c2rgb (icon.Color))
						end
					end
				end

			elseif v.DrawMode == "WP" then		-- World point

				local scale = self.IconScale * v.Scale * wpScale
				local w = max (v.W * scale, wpMin)
				local h = max (v.H * scale, wpMin)

				if v.AlphaNear then

					local aNear = v.AlphaNear * (abs (GetTime() % .7 - .35) / .7 + .5)	-- 50% to 100% pulse

					for n = 1, v.Num do

						local icon = v[n]
						local f = self:GetIconStatic (v.Lvl)

						if v.ClipFunc (self, f, icon.X, icon.Y, w, h, 0) then

							f.NxTip = icon.Tip
							f.NXType = 3000
							f.NXData = icon

							if icon.Tex then
								f.texture:SetTexture (icon.Tex)

							elseif v.Tex then
								f.texture:SetTexture (v.Tex)

							else
								f.texture:SetTexture (c2rgb (icon.Color))
							end

							local a = v.Alpha

							local dist = (icon.X - self.PlyrX) ^ 2 + (icon.Y - self.PlyrY) ^ 2
							if dist < 306 then	-- 80 yards * 4.575 ^ 2
								a = aNear
--								Nx.prt ("fade %s %s", dist ^ .5, a)
							end

							f.texture:SetVertexColor (1, 1, 1, a)
						end
					end

				else
					for n = 1, v.Num do

						local icon = v[n]
						local f = self:GetIconStatic (v.Lvl)

						if v.ClipFunc (self, f, icon.X, icon.Y, w, h, 0) then

							f.NxTip = icon.Tip
							f.NXType = 3000
							f.NXData = icon

							if icon.Tex then
								f.texture:SetTexture (icon.Tex)

							elseif v.Tex then
								f.texture:SetTexture (v.Tex)

							else
								f.texture:SetTexture (c2rgb (icon.Color))
							end

							if v.Alpha then
								f.texture:SetVertexColor (1, 1, 1, v.Alpha)
							end
						end
					end
				end

			elseif v.DrawMode == "ZR" then	-- Zone rectangle

				local x, y, x2, y2
--				local x0, y0, x2, y2 = self:GetWorldRect (self.MapId, 0, 0, 100, 100)

				for n = 1, v.Num do

					local icon = v[n]
					local f = self:GetIconStatic (v.Lvl)

--					Nx.prt ("ZR #%d %f %f %f %f", n, icon.X, icon.Y, icon.X2, icon.Y2)

					f.NxTip = icon.Tip

					x, y = self:GetWorldPos (icon.MapId, icon.X, icon.Y)
					x2, y2 = self:GetWorldPos (icon.MapId, icon.X2, icon.Y2)

--					Nx.prt ("%f %f %f %f", x, y, x2, y2)

					if self:ClipFrameTL (f, x, y, x2-x, y2-y) then
						if v.Texture then
							f.texture:SetTexture (v.Tex)
						else
							f.texture:SetTexture (c2rgba (icon.Color))
						end
					end
				end
			end
		end
	end
end

------
-- Reset icons

function Nx.Map:ResetIcons()

	local frms = self.IconFrms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1

	local frms = self.IconNIFrms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1

	local frms = self.IconStaticFrms
	frms.Used = frms.Next - 1		-- Save last frame used
	frms.Next = 1

	local data = self.TextFStrs
	data.Used = data.Next - 1		-- Save last used
	data.Next = 1
end

------
-- Hide extra icons (a hide and then show will reset mouse state, breaking OnMouseUp)

function Nx.Map:HideExtraIcons()

	local frms = self.IconFrms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end

	local frms = self.IconNIFrms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end

	local frms = self.IconStaticFrms

	for n = frms.Next, frms.Used do		-- Hide up to last frames used amount
		frms[n]:Hide()
	end

	local data = self.TextFStrs

	for n = data.Next, data.Used do		-- Hide up to last used amount
		data[n]:Hide()
	end
end

------
-- Get next available map icon or create one
-- ret: icon frame

function Nx.Map:GetIcon (levelAdd)

	local frms = self.IconFrms
	local pos = frms.Next

	if pos > 1500 then
		pos = 1500	-- Too many used. Reuse
	end

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxIcon"..pos, self.Frm)
		frms[pos] = f
		f.NxMap = self

		f:SetScript ("OnMouseDown", self.IconOnMouseDown)
		f:SetScript ("OnMouseUp", self.IconOnMouseUp)
		f:SetScript ("OnEnter", self.IconOnEnter)
		f:SetScript ("OnLeave", self.IconOnLeave)
		f:SetScript ("OnHide", self.IconOnLeave)

		f:EnableMouse (true)

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

	f:SetFrameLevel (self.Level + (levelAdd or 0))

	f.texture:SetVertexColor (1, 1, 1, 1)
--	f.texture:SetBlendMode ("BLEND")

	f.NxTip = nil
	f.NXType = nil			-- 1000 plyr, 2000 BG, 3000 POI, 8000 debug, 9000+ quest
	f.NXData = nil
	f.NXData2 = nil

	frms.Next = pos + 1

	return f
end

------
-- Get next available map non interactive icon or create one
-- ret: icon frame

function Nx.Map:GetIconNI (levelAdd)

	local frms = self.IconNIFrms
	local pos = frms.Next

	if pos > 1500 then
		pos = 1500	-- Too many used. Reuse
	end

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxIconNI"..pos, self.Frm)
		frms[pos] = f
		f.NxMap = self

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

	local add = levelAdd or 0
	f:SetFrameLevel (self.Level + add)

	f.texture:SetVertexColor (1, 1, 1, 1)
	f.texture:SetBlendMode ("BLEND")

	frms.Next = pos + 1

	return f
end

------
-- Get next available map static (for non moving stuff) icon or create one
-- ret: icon frame

function Nx.Map:GetIconStatic (levelAdd)

	local frms = self.IconStaticFrms
	local pos = frms.Next

	if pos > 1500 then
		pos = 1500	-- Too many used. Reuse
	end

	local f = frms[pos]
	if not f then

		f = CreateFrame ("Frame", "NxIconS"..pos, self.Frm)
		frms[pos] = f
		f.NxMap = self

		f:SetScript ("OnMouseDown", self.IconOnMouseDown)
		f:SetScript ("OnMouseUp", self.IconOnMouseUp)
		f:SetScript ("OnEnter", self.IconOnEnter)
		f:SetScript ("OnLeave", self.IconOnLeave)
		f:SetScript ("OnHide", self.IconOnLeave)

		f:EnableMouse (true)

		local t = f:CreateTexture()
		f.texture = t
		t:SetAllPoints (f)
	end

	local add = levelAdd or 0
	f:SetFrameLevel (self.Level + add)

	f.texture:SetVertexColor (1, 1, 1, 1)
--	f.texture:SetBlendMode ("BLEND")

	f.NxTip = nil
	f.NXType = nil			-- 1000 plyr, 2000 BG, 3000 POI, 8000 debug, 9000+ quest
	f.NXData = nil
	f.NXData2 = nil

	frms.Next = pos + 1

	return f
end

--------
-- Handle mouse click on icon

function Nx.Map:IconOnMouseDown (button)

	local this = self			--V4

--	Nx.prt ("MapIconMouseDown "..button.." "..(this:GetName() or "?"))

	local map = this.NxMap
	map:CalcClick()
	map.ClickFrm = this
	map.ClickType = this.NXType
	map.ClickIcon = this.NXData

	local shift = IsShiftKeyDown()

	if button == "LeftButton" then

		local cat = floor ((this.NXType or 0) / 1000)

		if cat == 2 and shift then		-- BG location

			if map.BGIncNum > 0 then

				local _, _, _, str = strsplit ("~", map.BGMsg)
				local _, _, _, str2 = strsplit ("~", this.NXData)

				if str ~= str2 then				-- Different node?
					Nx.Timer:Fire ("BGInc")		-- Clear if pending
				end
			end

			map.BGMsg = this.NXData
			map.BGIncNum = map.BGIncNum + 1

			UIErrorsFrame:AddMessage ("Inc " .. map.BGIncNum, 1, 1, 1, 1)

			Nx.Timer:Start ("BGInc", 1.5, map, map.BGIncSendTimer)

--		elseif cat == 8 then
--			map:HotspotDebugClick (button)

		else
			if map:IsDoubleClick() then
				if cat == 3 then
--					Nx.prt ("Icon dbl click")
					map:GMenu_OnGoto()
				end

			else
				map.OnMouseDown (map.Frm, button)
			end
		end

	else		--if button == "MiddleButton" or button == "Button4" or IsShiftKeyDown() then

		if button == "RightButton" then

			local typ = this.NXType

--			Nx.prt ("Icon type %s", typ or 0)

			if typ then

				local i = floor (typ / 1000)

				if i == 1 then
					map:BuildPlyrLists()
					map.PIconMenu:Open()

				elseif i == 2 then				-- BG location

					Nx.Timer:Fire ("BGInc")		-- Clear if pending

					map.BGMsg = this.NXData
					map.BGIconMenu:Open()

				elseif i == 3 then

					map:GMenuOpen (this.NXData, typ)

				elseif i == 9 then				-- Quest

					Nx.Quest:IconOnMouseDown (this)
				end
			end

		else
			map.OnMouseDown (map.Frm, button)
		end
	end
end

function Nx.Map:BuildPlyrLists()

	local Map = Nx.Map

	Map.PlyrNames = {}
	Map.AFKers = {}
	local tipStr = ""

	local frms = self.IconFrms
	local f

	local cnt = 0

	for n = 1, frms.Next-1 do

		f = frms[n]
		local plyr = f.NXType == 1000 and f.NXData2
		if plyr then

			local x, y = Nx.Util_IsMouseOver (f)
			if x then

--				Nx.prt ("Plyr %s", plyr)

				tinsert (Map.PlyrNames, plyr)

				if f.NXData then
					tinsert (Map.AFKers, f.NXData)
--					Nx.prt ("AFKer %d %s %s", #Nx.Map.AFKers, plyr, f.NXData)
				end
			end
		end
	end

	if #Map.PlyrNames >= 2 then

		tipStr = format (L["\n\n|cff00cf00%s players:"], #Map.PlyrNames)

		sort (Map.PlyrNames)

		for _, name in ipairs (Map.PlyrNames) do
			tipStr = tipStr .. "\n" .. name
		end
	end

	Map.PlyrNamesTipStr = tipStr

end

function Nx.Map:IconOnMouseUp (button)

--	Nx.prt ("MapIconMouseUp "..button)

	local this = self			--V4
	this.NxMap.OnMouseUp (this.NxMap.Frm, button)
end

--------
-- Handle mouse on icon

function Nx.Map:IconOnEnter (motion)

	local this = self			--V4

--	Nx.prt ("MapIconEnter %s", this:GetName() or "nil")

	local map = this.NxMap

--	map.BackgndAlphaTarget = map.BackgndAlphaFull

	map:BuildPlyrLists()

	if this.NxTip then
--		Nx.prt ("MapIconEnter %s %s", this:GetName() or "nil", this.NxTip)

		local tt = GameTooltip

		local str = strsplit ("~", this.NxTip)

		local owner = this
		local tippos = "ANCHOR_CURSOR"

		local opts = Nx:GetGlobalOpts()
		if opts["MapTopTooltip"] then
			owner = map.Win.Frm
			tippos = "ANCHOR_TOPLEFT"
		end

		owner.NXIconFrm = this

--		Nx.TooltipOwner = owner
--		map.TooltipType = 2

		tt:SetOwner (owner, tippos, 0, 0)

		Nx:SetTooltipText (str .. Nx.Map.PlyrNamesTipStr)

		owner["UpdateTooltip"] = Nx.Map.IconOnUpdateTooltip
	end

	local t = this.NXType or -1

	if t >= 9000 then					-- Quest
		Nx.Quest:IconOnEnter (this)
	end
end

--------
-- Called by tooltip
-- self = frame

function Nx.Map:IconOnUpdateTooltip()

	local f = self.NXIconFrm

	if f and f.NxTip then

		local map = f.NxMap
		map:BuildPlyrLists()

		local str = strsplit ("~", f.NxTip)
		Nx:SetTooltipText (str .. Nx.Map.PlyrNamesTipStr)

		if Nx.Quest.Enabled then
			Nx.Quest:TooltipProcess()
		end

--		Nx.prt ("IconOnUpdateTooltip")
	end
end

--------
-- Handle mouse leaving icon (or icon hiding)

function Nx.Map:IconOnLeave (motion)

	local this = self			--V4
	local t = this.NXType or -1

	if t >= 9000 then					-- Quest
		Nx.Quest:IconOnLeave (this)
	end

--	self.TooltipType = 0

--	if not this:IsVisible() then
--		Nx.prt ("IconOnLeave not vis")
--		return
--	end

--	local map = this.NxMap
--	local owner = map.Win.Frm

	if GameTooltip:IsOwned (this) or GameTooltip:IsOwned (this.NxMap.Win.Frm) then
		GameTooltip:Hide()
--		Nx.prt ("MapIconLeave hide tip")
	end
end

--------
-- Get next available map text or create one
-- ret: text font string

function Nx.Map:GetText (text, levelAdd)

	local data = self.TextFStrs
	local pos = data.Next

	if pos > 100 then
		pos = 1	-- Reset. Too many used
	end

	local fstr = data[pos]
	if not fstr then

		fstr = self.TextFrm:CreateFontString()
		data[pos] = fstr

		fstr:SetFontObject ("NxFontMap")
		fstr:SetJustifyH ("LEFT")
		fstr:SetJustifyV ("TOP")
--		fstr:SetWidth (400)
		fstr:SetHeight (100)
		fstr:SetTextColor (1, 1, 1, 1)
	end

	fstr:SetText (text)

--	local add = levelAdd or 0
--	f:SetFrameLevel (self.Level + add)

	data.Next = pos + 1

	return fstr
end

--------
-- Move text

function Nx.Map:MoveTextToIcon (fstr, icon, ox, oy)

	local f = icon
	local atPt, relTo, relPt, x, y = f:GetPoint()

--	Nx.prt ("Text %s %s %s", relPt, x, y)

	fstr:SetPoint ("TOPLEFT", x + ox, y - oy)
	fstr:Show()
end

--------
-- Update instance map

function Nx.Map:UpdateInstanceMap()

	local mapId = self.InstMapId
	if not mapId then
		return
	end

	local Map = Nx.Map
	local winfo = Map.MapWorldInfo[mapId]
	local info = self.InstMapInfo				-- Valid if Id not nil

--	Nx.prt ("Inst id %s", mapId)

	if self.InstMapAtlas then

		local wx = winfo[2]
		local wy = winfo[3]

		for n = 1, #info, 3 do

			local sc = 668 / 256
			local f = self:GetIconNI()

			if self:ClipFrameTL (f, wx, wy + (n - 1) * 668 / 768, sc, sc) then
				local tex = info[n + 2]
				tex = "Interface\\Addons\\Atlas\\Images\\Maps\\" .. tex
				f.texture:SetTexture (tex)
			end
		end

		self.Level = self.Level + 1

	else

		local wx = winfo[2]
		local wy = winfo[3]

		for n = 1, #info, 3 do

			local imgI = 1

			local offx = 0		-- info[n] * .04 * 1002 / 1024
			local offy = info[n + 1] * .03 * 668 / 768

			for by = 0, 2 do

				for bx = 0, 3 do

					local sc = 1
					local f = self:GetIconNI()

--					Nx.prt ("Inst %s, %s %s %s %s", mapId, wx, wy, bx, by)

					if self:ClipFrameTL (f, wx + bx - offx, wy + by - offy, sc, sc) then
						local tex = info[n + 2]
						tex = "Interface\\WorldMap\\" .. tex .. imgI
						f.texture:SetTexture (tex)
					end

					imgI = imgI + 1
				end
			end
		end

		self.Level = self.Level + 1
	end
end

------------------------------------------
-- Helpers

--------
-- Get a map by index

function Nx.Map:GetMap (mapIndex)
	return self.Maps[mapIndex]
end

--------
-- Set map target name

function Nx.Map:SetTargetName (name)

	local tar = self.Maps[1].Targets[1]
	if tar then
		tar.TargetName = name
	end
end

--------
-- Get map target type, id

function Nx.Map:GetTargetInfo()

	local tar = self.Maps[1].Targets[1]
	if tar then
		return tar.TargetType, tar.TargetId
	end
end

--------
-- Get map target pos

function Nx.Map:GetTargetPos()

	local tar = self.Maps[1].Targets[1]
	if tar then
		return tar.TargetX1, tar.TargetY1, tar.TargetX2, tar.TargetY2
	end
end

--------
-- Center the map in view

function Nx.Map:CurrentCenterMap (mapId)

	local map = self.Maps[1]
	map:CenterMap (mapId)
end

------------------------------------------
-- Map table access

--------
-- Init map tables

function Nx.Map:InitTables()

	local Nx = Nx

--[[
	NxData.NXMapDebugZones1 = { GetMapZones (1) }
	NxData.NXMapDebugZones2 = { GetMapZones (2) }
	NxData.NXMapDebugZones3 = { GetMapZones (3) }
	NxData.NXMapDebugZones4 = { GetMapZones (4) }
	Nx.prt ("zone cap!!!!!")
--]]

	local worldInfo = self.MapWorldInfo

	Nx.MapNameToId = {}
	Nx.MapIdToName = {}
	Nx.MapIdToNxzone = {}
	self.NxzoneToMapId = {}
	Nx.NxzoneToMapId = self.NxzoneToMapId
	Nx.MapOverlayToMapId = {}

	-- Get Blizzard's alphabetical set of names

	--V403

	self.MapNames = {
		{ GetMapZones (1) },
		{ GetMapZones (2) },
		{ GetMapZones (3) },
		{ GetMapZones (4) },
		{ GetMapZones (5) },
		{ GetMapZones (6) },
	}

	tinsert (self.MapNames[2], NXlMapNames["Plaguelands: The Scarlet Enclave"] or "Plaguelands: The Scarlet Enclave")
	tinsert (self.MapNames[2], NXlMapNames["Gilneas"] or "Gilneas")
	tinsert (self.MapNames[2], NXlMapNames["Gilneas City"] or "Gilneas City")

	for mi, mapName in pairs (self.MapNames[2]) do
		for mi2, mapName2 in pairs (self.MapNames[2]) do
			if mapName == mapName2 and mi ~= mi2 then			-- Duplicate name? (Gilneas, Ruins of Gilneas (EU))
				self.MapNames[2][mi2] = mapName .. "2"			-- Hack it!
--				Nx.prt ("Dup zone name %s", mapName)
				break
			end
		end
	end

	local BGNames = {}
	self.MapNames[9] = BGNames

	for n = 1, 999 do
		local winfo = worldInfo[9000 + n]
		if not winfo then
			break
		end

		BGNames[n] = NXlMapNames[winfo.Name] or winfo.Name
	end

--	Nx.Zones[152]="Icecrown: The Forge of Souls!80!80!3!5!128!####!5"


	-- Set overlays

	self.ZoneOverlays["lakewintergrasp"]["lakewintergrasp"] = "0,0,1024,768"

	-- Support maps with multiple levels

	self.MapSubNames = NXlMapSubNames

--	tinsert (self.MapNames[4], "Molten Front")
--	tinsert (self.MapNames[4], "Dalaran Underbelly")
--	tinsert (self.MapNames[5], "Darkmoon Island")
--  tinsert (self.MapNames[6], "The Wandering Isle")    
	tinsert(self.MapNames[4],NXlMapNames["Molten Front"] or "Molten Front")             --warbaby add some zone not on map
	tinsert(self.MapNames[4],NXlMapNames["Dalaran Underbelly"] or "Dalaran Underbelly") --warbaby add some zone not on map
	tinsert(self.MapNames[5],NXlMapNames["Darkmoon Island"] or "Darkmoon Island") --warbaby add some zone not on map
	tinsert(self.MapNames[6],NXlMapNames["The Wandering Isle"] or "The Wandering Isle")    
	-- Setup mapping to and from Blizzard cont/zone to Map Id
	-- and overlay name to map id

	self.ContCnt = 6
	continentNums = { 1, 2, 3, 4, 5, 6, 9 }

	local CZ2Id = {}
	self.CZ2Id = CZ2Id

	for _, ci in ipairs (continentNums) do

		local z2id = {}
		CZ2Id[ci] = z2id

		for n = 1, 999 do

			local mapId = ci * 1000 + n
			local winfo = worldInfo[mapId]
			if not winfo then
				break
			end

			if Nx.PlFactionNum == 0 and winfo.QAchievementIdA then
				winfo.QAchievementId = winfo.QAchievementIdA				-- Copy Ally Id to generic Id
			end
			if Nx.PlFactionNum == 1 and winfo.QAchievementIdH then
				winfo.QAchievementId = winfo.QAchievementIdH				-- Copy Horde Id to generic Id
			end

			local locName = NXlMapNames[winfo.Name] or winfo.Name

			for i, name in ipairs (self.MapNames[ci]) do
				if name == locName then
--					Nx.prt ("%s #%s = %s", name, i, mapId)
					z2id[i] = mapId
					break
				end
			end
		end
       
		for k, v in ipairs (CZ2Id[ci]) do
            
			worldInfo[v].Cont = ci
			worldInfo[v].Zone = k

			local ov = worldInfo[v].Overlay
			if ov then
				Nx.MapOverlayToMapId[ov] = v
			end
		end
	end

	for n = 1, self.ContCnt do
		CZ2Id[n][0] = n * 1000
	end

	-- Init for getting map id to and from name

	for _, ci in ipairs (continentNums) do

		for mi, mapName in pairs (self.MapNames[ci]) do

--			if ci == 2 then
--				Nx.prt ("Map %s %s", mapName, self.CZ2Id[ci][mi] or "nil")
--			end
			local mid = self.CZ2Id[ci][mi]

			if Nx.MapNameToId[mapName] then
				Nx.prt (L["Dup map name: %s (%s %s)"], mapName, ci, mi)
				Nx.MapNameToId[mapName .. "2"] = mid
			else
				Nx.MapNameToId[mapName] = mid
			end

			if not mid then
				Nx.prt (L["Unknown map name: %s (%s %s)"], mapName, ci, mi)
			else
				Nx.MapIdToName[mid] = mapName
			end
		end
	end

	-- Localize the zone name

	for id, v in ipairs (Nx.Zones) do

		local i = strfind (v, "!")
		local name = strsub (v, 1, i - 1)
		local data = strsub (v, i + 1)

		local locName = NXlMapNames[name]
		if locName then
			Nx.Zones[id] = locName .. "!" .. data
		end
	end

	-- Move MapGenAreas to MapWorldInfo (scale, x, y, overlay)

	for id, area in pairs (Nx.Map.MapGenAreas) do

		local s = Nx.Zones[id]				
		local name = strsplit ("!", s)
		local mapId = Nx.MapNameToId[name]

		if not mapId then
			Nx.prt ("Err MapGenAreas %s", name)

		else

			local cont = floor (mapId / 1000)
			if cont <= 2 or cont == 5 then

				local wi = worldInfo[mapId]
				wi[1] = area[1]				-- Scale
				wi[2] = area[2]				-- X
				wi[3] = area[3]				-- Y

				if wi.XOff then	-- Had pos offset?
					wi[2] = wi[2] + wi.XOff	-- X
					wi[3] = wi[3] + wi.YOff	-- Y
					wi.XOff = nil
					wi.YOff = nil
				end

				wi.Overlay = area[4]
			end
		end
	end

	Nx.Map.MapGenAreas = nil

	-- Make world coords for each zone

	for _, ci in ipairs (continentNums) do

		local info = self.MapInfo[ci]
		local cx = info.X
		local cy = info.Y		
--		Nx.prt ("WC %s %s %s", ci, cx, cy)

		for n = 0, 999 do			
			local winfo = worldInfo[ci * 1000 + n]						
			if not winfo then
				break
			end			
-- LANG TEST			
--			Nx.prt(ci * 1000 + n) 
			winfo[4] = cx + winfo[2]
			winfo[5] = cy + winfo[3]
		end
	end			
	--

	for id, v in pairs (Nx.Zones) do

		local name, minLvl, maxLvl, faction, cont, entryId, entryPos = strsplit ("!", v)

		-- Faction:
		-- 0 Alliance
		-- 1 Horde
		-- 2 Contested
		-- 3 Instance
		-- 4 Unknown

		-- Continent:
		-- 1 Kalimdor
		-- 2 EasternKingdoms
		-- 3 Outland
		-- 4 Battleground
		-- 5 Dungeon
		-- 6 Raid					-- OLD
		-- 7 Northrend
		-- 8 The Maelstrom
		-- 9 Unknown

		if faction == "3" and cont == "5" then		-- Instance

			assert (entryId and entryPos)

			if entryId == "0" then
				entryId = "125"
			end

--[[
			local i = strfind (name, ": ")
			if i then
				name = strsub (name, i + 2)
			end
--]]

--			Nx.prt ("Inst %s %d", name, id)

			local entryZone = Nx.Zones[tonumber (entryId)]			
			local ename, _, _, _, cont = strsplit ("!", entryZone)
			if cont == "7" then
				cont = 4
			end
			if cont == "8" then
				cont = 5
			end
			local mid = cont * 1000 + 10000 + id

			Nx.MapNameToId[name] = mid
			Nx.MapIdToName[mid] = name

			local emid = Nx.MapNameToId[ename]


			local ex, ey = Nx.Quest:UnpackLocPt (entryPos)


			if self.MapWorldInfo[mid] then			-- Adjustment exists?
				ex = ex + self.MapWorldInfo[mid][2]
				ey = ey + self.MapWorldInfo[mid][3]
			end

--			Nx.prt ("Inst %s %s, %s %s %f %f", name, mid, ename, emid or "nil", ex, ey)

			local x, y = self:GetWorldPos (emid, ex, ey)

--			Nx.prt ("Inst %s %d, %d %f %f", name, mid, emid, x, y)

			local ewinfo = self.MapWorldInfo[emid]
			if not ewinfo then
--				Nx.prt ("? %s %s", ename, emid or "nil")
			end

			local winfo = {}

			winfo.EntryMId = emid
			winfo[1] = 1002 / 25600 --ewinfo[1]		-- Scale
			winfo[2] = x				-- X
			winfo[3] = y				-- Y
			winfo[4] = x				-- X
			winfo[5] = y				-- Y
			self.MapWorldInfo[mid] = winfo
		end
	end
--	Nx.prt("debug: ")
	-- Init NxzoneToMapId, MapIdToNxzone

	for id, v in ipairs (Nx.Zones) do

		local name, minLvl, maxLvl, faction = strsplit ("!", v)
--[[
		if id ~= 146 then		-- The Scarlet Enclave needs to keep the :
			local i = strfind (name, ": ")
			if i then
				name = strsub (name, i + 2)
			end
		end
--]]
		local mapId = Nx.MapNameToId[name]

		if mapId then

			if not Nx.MapIdToNxzone[mapId] then
				Nx.MapIdToNxzone[mapId] = id
			else
--				Nx.prt ("Map Init %s %s dup %s", name, id, Nx.MapIdToNxzone[mapId])
			end

			self.NxzoneToMapId[id] = mapId
		else
--			Nx.prt ("Inst %s %d", name, id)
		end
	end

	-- Init AId2Id (Blizzard area id to map id and back)

	Nx.AIdToId = {}
	Nx.IdToAId = {}

	for aid, zid in pairs (Nx.ID2Zone) do
		if zid ~= 0 then
			local id = self.NxzoneToMapId[zid]
			Nx.AIdToId[aid] = id
			if id then
				Nx.IdToAId[id] = aid
			end
--			if not id then
--				Nx.prt ("AId %s (%s) = %s", aid, zid, id or "nil")
--			end

		end
	end

	-- Test
--[[

	Nx.prt ("Test Map Id")

	for k, v in ipairs (Nx.Zones) do

		if k ~= 16 and k ~= 34 and k ~= 102 then
			local mapId = self.NxzoneToMapId[k]
			assert (Nx.MapIdToNxzone[mapId] == k)
		end
	end
--]]

	-- Init instance entries

	for k, v in ipairs (Nx.Zones) do

		local name, minLvl, maxLvl, faction, cont, entryId = strsplit ("!", v)

		if faction ~= "3" then		-- Not instance

			if entryId and entryId ~= "" then
				self.NxzoneToMapId[k] = self.NxzoneToMapId[tonumber (entryId)]
			end
		end
	end

	--	DEBUG for Jamie

	Nx.ZoneConnections = Nx["ZoneConnections"] or Nx.ZoneConnections	-- Copy unmunged data to munged data

	-- Init zone connections

	for ci = 1, self.ContCnt do
		for n = 0, 999 do

			local mapId = ci * 1000 + n
			local winfo = worldInfo[mapId]
			if not winfo then
				break
			end
			local cons = {}
			winfo.Connections = cons

			for _, str in ipairs (Nx.ZoneConnections) do

				local flags, ta, tb, z1, x1a, x1b, y1a, y1b, z2, x2a, x2b, y2a, y2b, name1len = strbyte (str, 1, 14)

				flags = flags - 35
				local conTime = (ta - 35) * 221 + tb - 35
				local mapId1 = self.NxzoneToMapId[z1 - 35]
				local mapId2 = self.NxzoneToMapId[z2 - 35]
--[[
				if mapId1 == 1017 or mapId2 == 1017 or mapId1 == 1028 or mapId2 == 1028 then
					Nx.prt ("%s %d %d to %s %d %d, %s f%x",
							Nx.MapIdToName[mapId1] or mapId1, ((x1a - 35) * 221 + x1b - 35) / 100, ((y1a - 35) * 221 + y1b - 35) / 100,
							Nx.MapIdToName[mapId2] or mapId2, ((x2a - 35) * 221 + x2b - 35) / 100, ((y2a - 35) * 221 + y2b - 35) / 100,
							conTime, flags)
				end
--]]
				if not (mapId1 and mapId2) then
--					Nx.prt ("zone conn err %s to %s", z1 - 35, z2 - 35)
					conTime = 0
				end

				if conTime == 1 and (mapId == mapId1 or (mapId == mapId2 and bit.band (flags, 1) == 1)) then

					local cont1 = self:IdToContZone (mapId1)
					local cont2 = self:IdToContZone (mapId2)

					if cont1 == cont2 then

						name1len = name1len - 35
						local name1 = name1len == 0 and "" or strsub (str, 15, 14 + name1len)
						local i = 15 + name1len
						local name2len = strbyte (str, i)						
						local name2 = name2len == 0 and "" or strsub (str, i + 1, i + name2len)

						local x1 = ((x1a - 35) * 221 + x1b - 35) / 100
						local y1 = ((y1a - 35) * 221 + y1b - 35) / 100
						local x2 = ((x2a - 35) * 221 + x2b - 35) / 100
						local y2 = ((y2a - 35) * 221 + y2b - 35) / 100
--[[
						if mapId1 == 1017 or mapId2 == 1017 or mapId1 == 1028 or mapId2 == 1028 then
							Nx.prt ("%s %d %d to %s %d %d, %s, %s %s",
									Nx.MapIdToName[mapId1] or mapId1, x1, y1,
									Nx.MapIdToName[mapId2] or mapId2, x2, y2,
									conTime, name1, name2)
						end
--]]
						if mapId == mapId2 then		-- Swap?
							mapId1, mapId2 = mapId2, mapId1
							x1, y1, x2, y2 = x2, y2, x1, y1
						end

						local zcons = cons[mapId2] or {}
						cons[mapId2] = zcons

						if x1 ~= 0 and y1 ~= 0 then	-- Specific connection? Else connects anywhere

							local con = {}
							tinsert (zcons, con)

							x1, y1 = self:GetWorldPos (mapId1, x1, y1)
							x2, y2 = self:GetWorldPos (mapId2, x2, y2)

							con.StartMapId = mapId1
							con.StartX = x1
							con.StartY = y1
							con.EndMapId = mapId2
							con.EndX = x2
							con.EndY = y2
							con.Dist = ((x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5
						end

--					else
--						Nx.prt ("%s to %s", mapId1, mapId2)
					end
				end
			end
		end
	end
end

--------
-- Convert raw cont and zone to mapid
-- self: not used

function Nx.Map:ConnectionUnpack (str)

--[[
	Format is (base 221 packed):

	1 byte flags Bit 0 = two-way, Bit 1 = Alliance, Bit 2 = Horde
	2 byte time,  0 = Instant (Portal)  1 = Normal connection  >1 = Some type of boat/zeppelin
	1 byte zone 1
	2 byte zone 1 location
	1 byte zone 2
	2 byte zone 2 location
	1 byte name 1 length
	name 1
	1 byte name 2 length
	name 2

	To choose icons to show you could search the string to work out what it is.
	Boat, Tram, Zeppelin, Portal
--]]

	local flags, ta, tb, z1, x1a, x1b, y1a, y1b, z2, x2a, x2b, y2a, y2b, name1len = strbyte (str, 1, 14)

	flags = flags - 35
	local conTime = (ta - 35) * 221 + tb - 35
	local mapId1 = self.NxzoneToMapId[z1 - 35]
	local mapId2 = self.NxzoneToMapId[z2 - 35]

--	local cont1 = self:IdToContZone (mapId1)
--	local cont2 = self:IdToContZone (mapId2)

	name1len = name1len - 35
	local name1 = name1len == 0 and "" or strsub (str, 15, 14 + name1len)
	local i = 15 + name1len
	local name2len = strbyte (str, i)
	local name2 = name2len == 0 and "" or strsub (str, i + 1, i + name2len)

	local x1 = ((x1a - 35) * 221 + x1b - 35) / 100
	local y1 = ((y1a - 35) * 221 + y1b - 35) / 100
	local x2 = ((x2a - 35) * 221 + x2b - 35) / 100
	local y2 = ((y2a - 35) * 221 + y2b - 35) / 100

	return flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2
end

--------
-- Convert raw cont and zone to mapid
-- self: not used

function Nx.Map:CZ2MapId (cont, zone)

	if cont <= 0 then
		return 9000
	end

	return self.CZ2Id[cont][zone]
end

--------
-- Get the real player location map id without map level calculation

function Nx.Map:GetRealBaseMapId()
	return Nx.MapNameToId[GetRealZoneText()] or 9000
end

--------
-- Get the real player location map id
-- asdf
function Nx.Map:GetInstanceID(id)
  local name, minLvl, maxLvl, faction, cont, entryId, entryPos = strsplit ("!", Nx.Zones[tonumber(id)])
  local entryZone = Nx.Zones[tonumber (entryId)]
  if entryZone then	
	local ename, _, _, _, cont = strsplit ("!", entryZone)
	local mid = cont * 1000 + 10000 + id
	return mid
  end
end

function Nx.Map:GetRealMapId()

	--Nx.prt ("RealMId %s %s #%s", GetRealZoneText(), GetSubZoneText(), GetCurrentMapDungeonLevel())

	local zName = GetRealZoneText()	
	local mapId = Nx.MapNameToId[zName] or 9000	
	local name, instanceType, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, mapID = GetInstanceInfo()
	if (difficultyIndex == 1) then  		
	    if IsInScenarioGroup() then
			SetMapToCurrentZone()
			local id = Nx.ID2Zone[GetCurrentMapAreaID()]
			mapId = self:GetInstanceID(id)					
			return mapId
		end
	end	
	local subT = self.MapSubNames[zName]	-- Find subzone name

	if subT then
		if subT[GetSubZoneText()] then
			return self.MapWorldInfo[mapId].Level2Id or mapId
		end
	end

--	if GetCurrentMapDungeonLevel() > 1 then
--		return self.MapWorldInfo[mapId].Level2Id or mapId
--	end

	return mapId
end

--------
-- Get the current selected map id
-- Do not call SetMapToCurrentZone() here or crash

function Nx.Map:GetCurrentMapId()

	--V403

	local cont = GetCurrentMapContinent()
	local zone = GetCurrentMapZone()
	
	if cont <= 0 or cont >= 6 then

		local aid = GetCurrentMapAreaID()

--		Nx.prtCtrl ("GetCurrentMapId %s, %s+%s", aid, cont, zone)

--		if cont == -1 and (self.MapId or 0) > 11000 then
--			return self.MapId
--		end

		local id = Nx.AIdToId[aid]
		if id then
--			Nx.prt ("GetCurrentMapId from aid %s", id)
			return id
		end		
		return self:GetRealMapId()
	end

--[[
	if not self.CZ2Id[cont] then
		Nx.prt ("cont %s", cont)
	end

	if not self.CZ2Id[cont][zone] then
		Nx.prt ("%s %s", cont, zone)
	end
--]]

	local mapId = self.CZ2Id[cont][zone] or 9000

	if mapId == Nx.MapNameToId[GetRealZoneText()] then		-- Same as real zone?
		return self:GetRealMapId()
	end	
	return mapId
end

--------
-- Set the current using a map id

function Nx.Map:SetCurrentMap (mapId)

	if mapId then

--		Nx.prt ("SetMapToCurrentZone %s", mapId)

		self.BaseScale = 1

		if mapId > 1000 and mapId < 7000 then

			local cont = self.MapWorldInfo[mapId].Cont
			local zone = self.MapWorldInfo[mapId].Zone

			if not cont or not zone or mapId == self:GetRealBaseMapId() or mapId == self:GetRealMapId() then

--				Nx.prt ("SetMapToCurrentZone %s", mapId)

				SetMapToCurrentZone()		-- This fixes the Scarlet Enclave map selection, so we get player position
				SetDungeonMapLevel (1)

			else

				if self.MapWorldInfo[mapId].UseAId then
--					SetMapByID (Nx.IdToAId[mapId])
				else
					SetMapZoom (cont, zone)
				end
			end

--			Nx.prt ("CurLvl %s", GetCurrentMapDungeonLevel())

--[[
			local lvl = self.MapWorldInfo[mapId].MapLevel
			if lvl then
				Nx.prt ("SetDLvl %s", lvl)
				SetDungeonMapLevel (lvl)
			end
--]]
		elseif mapId > 11000 then	-- Instance?

			self.BaseScale = .025

			local aid = Nx.IdToAId[mapId]

--			Nx.prtCtrl ("SetCurrentMap %s %s", mapId, aid or "nil")

			if aid then
				self.MapId = 0				-- Force change (needed?)

				if mapId == self:GetRealBaseMapId() then
					SetMapToCurrentZone()

				else
					local caid = GetCurrentMapAreaID()

					if caid ~= aid then
--						Nx.prt ("SetCurrentMap dif %s", caid)
						SetMapByID (aid)
						SetDungeonMapLevel (1)
					end
				end


			else
				if mapId == self:GetRealBaseMapId() then

					self.MapId = 0				-- Force change
					SetMapToCurrentZone()
				else
					self.MapId = mapId
					SetMapZoom (-1)			-- Cosmic map. Has no POIs
				end
			end
		end

		self.InstLevelSet = GetCurrentMapDungeonLevel()
	end
end

--------
-- Set the map to current zone

function Nx.Map:SetToCurrentZone()

	SetMapToCurrentZone()

	local aid = GetCurrentMapAreaID()
	local id = Nx.AIdToId[aid]

	if id == 1014 then					-- Orgrimmar
		SetDungeonMapLevel (1)			-- Don't allow cleft of shadows
	end

--	Nx.prt ("SetToCurrentZone %s %s", aid, id or "nil")
end

--------
-- Save map view

function Nx.Map:SaveView (name)

	local str = format ("%s%s", Nx.InBG or "", name)

--	Nx.prt ("Save view %s", str)

	local v = self.ViewSavedData[str]

	if not v then
		v = {}
		self.ViewSavedData[str] = v
	end

	v.Scale = self.Scale
	v.X = self.MapPosX
	v.Y = self.MapPosY
end

--------
-- Restore map view

function Nx.Map:RestoreView (name)

	local str = format ("%s%s", Nx.InBG or "", name)

--	Nx.prt ("Restore view %s", str)

	local v = self.ViewSavedData[str]

	if v then
		self.Scale = v.Scale
		self.MapPosX = v.X
		self.MapPosY = v.Y

		self.StepTime = 5
	end
end

--------
-- Move map

function Nx.Map:Move (x, y, scale, stepTime)

--	Nx.prt ("Move %s %s sc %s time %s", x, y, scale or "nil", stepTime)

	self.MapPosX = x
	self.MapPosY = y

	if scale then
		self.Scale = scale
	end

	local dist = ((self.MapPosXDraw - self.MapPosX) ^ 2 + (self.MapPosYDraw - self.MapPosY) ^ 2) ^ .5

	local sz = max (self.MapW, self.MapH)

--	Nx.prt ("Move dist %f %f val %f", sz, dist, dist * self.Scale / sz)

	if dist * self.Scale / sz > 10 then	-- Zoomed in and a large jump?
		stepTime = 1	-- Go fast
	end

--	Nx.prt ("Move #%d %f steptime %f ", self.Tick, dist, self.StepTime)

	local st = abs (self.StepTime)	-- Will be neg if triggered

	if st > 0 and st < stepTime then		-- Already stepping? Use short time
		stepTime = st
--		Nx.prt ("Move steptime %f", stepTime)
	end

	self.StepTime = stepTime

	if dist < .25 then

--		Nx.prt ("Move snap XY")

		self.MapPosXDraw = self.MapPosX
		self.MapPosYDraw = self.MapPosY
	end

	if abs (1 / self.ScaleDraw - 1 / self.Scale) < .01 then
		self.ScaleDraw = self.Scale

--		Nx.prt ("Move snap scale")

		if dist < .25 then
			self.StepTime = 0
		end
	end

--[[
	if self.Debug then
		local plZX, plZY = GetPlayerMapPosition ("player")
		Nx.prt ("Move %f %f (%f %f)", x, y, plZX, plZY)
	end
--]]
end

--------
-- Goto current zone and center map

function Nx.Map:GotoCurrentZone()

--	Nx.prt ("GotoCurrentZone")

	if self.InstanceId then
		self:Move (self.PlyrX, self.PlyrY, 20, 30)
	else

		self:SetToCurrentZone()
		local mapId = self:GetCurrentMapId()
		self:CenterMap (mapId)
	end
end

--------
-- Goto current zone and cause player moved update

function Nx.Map:GotoPlayer()

--	Nx.prt ("GotoPlayer")

	self:CalcTracking()

	self:SetToCurrentZone()

	self.MoveLastX = -1
	self.MoveLastY = -1
end

--------
-- Center the map in view

function Nx.Map:CenterMap (mapId, scale)

	mapId = mapId or self.MapId

--[[ -- Map capture
	if 1 then
		self:CenterMap1To1 (floor (mapId / 1000) * 1000)
		return
	end
--]]

	if self:GetWorldZone (mapId).City then
		scale = 1
	end

	self.MapW = self.Frm:GetWidth() - self.PadX * 2
	self.MapH = self.Frm:GetHeight() - self.TitleH

	local x, y = self:GetWorldPos (mapId, 50, 50)
	local size = min (self.MapW / 1002, self.MapH / 668)
	if self.MapW < GetScreenWidth() / 2 then
		size = size * (scale or 1.5)
	end

	local scale = size / self:GetWorldZoneScale (mapId) * 10.02

	self:Move (x, y, scale, 30)

--	Nx.prt ("Center #%d %f (%f %f) (%d %d)", mapId, self.Scale, self.MapPosX, self.MapPosY, self.MapW, self.MapH)
end

--------
-- Center the map in view and 1 to 1 scale

function Nx.Map:CenterMap1To1 (mapId)

	self.MapPosX, self.MapPosY = self:GetWorldPos (mapId, 50, 50)

	self.Scale = 1002 / 100 / self:GetWorldZoneScale (mapId) * GetScreenWidth() / 1680 * 2
	self.ScaleDraw = self.Scale
	self.StepTime = 10
end

--------
-- Get a cont zone from the map id

function Nx.Map:IdToContZone (mapId)

	if mapId >= 10000 then
		return floor (mapId / 1000) - 10, 0
	end

	local info = self.MapWorldInfo[mapId]

--	if not info then
--		Nx.prt ("IdToContZone info nil %s", mapId)
--	end

	return info.Cont or 9, info.Zone or 0
end

--------
-- Get map name from id

function Nx.Map:IdToName (mapId)

--	Nx.prt ("MapId "..mapId)

	return Nx.MapIdToName[mapId] or "?"
end

--------
-- Get map id from name

function Nx.Map:NameToId (mapName)
	return Nx.MapNameToId[mapName]
end

--------
--

function Nx.Map:IsNormalMap (mapId)
	return mapId > 1000 and mapId % 1000 > 0 and mapId < 7000
end

--------
--

function Nx.Map:IsOutlandMap (mapId)
	return mapId >= 3000 and mapId <= 3999
end

--------
--

function Nx.Map:IsInstanceMap (mapId)
    if (GetCurrentMapAreaID() == 20) then return false end	
	return mapId >= 10000
end

--------
--

function Nx.Map:IsBattleGroundMap (mapId)
	return mapId >= 9001 and mapId <= 9099
end

function Nx.Map:IsMicroDungeon(mapId)	       
    return select(4, GetMapInfo()) and Nx.Map:GetCurrentMapId() == mapId 
	--and Nx.Map:GetCurrentMapId()==mapId and Nx.IdToAId[mapId] and not Nx.Map.MapLevels[Nx.IdToAId[mapId]] then	  
end

function Nx.Map:IsScenario(mapId)
	local name, instanceType, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, mapID = GetInstanceInfo()
	if (Nx.Map:GetCurrentMapId() == mapId) then
		if (difficultyIndex == 1) then     
			Nx.prt(mapId)
			return true
		end
	end	
	return false
end

function Nx.Map:GCMI_OVERRIDE(mapId)
    return mapId and Nx.Map:GetWorldZone(mapId) and Nx.Map:GetWorldZone(mapId).overrideMapWorldId or mapId
end
--------
-- Get map short name (only BGs have)

function Nx.Map:GetShortName (mapId)
	return Nx.Map.MapWorldInfo[mapId].Short
end

--------
-- Get world info for a continent
-- (cont #)

function Nx.Map:GetWorldContinentInfo (cont)

	local info = self.MapInfo[cont]
	if not info then
		return
	end

	return info.Name, info.X, info.Y
end

--------
-- Get world info for a continent and zone
-- (cont #, zone #)

function Nx.Map:GetWorldZoneInfo (cont, zone)

	local nt = self.MapNames[cont] or self.MapNames[5]
	local name = nt[zone] or "?"

	local info = self.MapInfo[cont]
	if not info then
		return name, 0, 0, 1002, 668
	end

	local id = self.CZ2Id[cont][zone]

	local winfo = self.MapWorldInfo[id]
	if not winfo then
		return
	end

	local x = info.X + winfo[2]
	local y = info.Y + winfo[3]
	local scale = winfo[1] * 100

	return name, x, y, scale, scale / 1.5		-- x, y, w, h
end

--------
-- Get world zone from map id
-- (id)

function Nx.Map:GetWorldZone (mapId)
	return self.MapWorldInfo[mapId]
end

--------
-- Get world zone scale from map id
-- (id)

function Nx.Map:GetWorldZoneScale (mapId)

--	self.GetWorldZoneScaleCnt = (self.GetWorldZoneScaleCnt or 0) + 1

--	if not self.MapWorldInfo[mapId] then
--		Nx.prt ("GetWorldZoneScale %s %s %s", mapId)
--	end

--	return (not self.MapWorldInfo[mapId] and 10.02) or self.MapWorldInfo[mapId][1]
	return self.MapWorldInfo[mapId][1]
end

--------
-- Get world position of map (zone) location
-- (id, x (0-100), y (0-100)

function Nx.Map:GetWorldPos (mapId, mapX, mapY)

--	self.GetWorldPosCnt = (self.GetWorldPosCnt or 0) + 1

--[[
	local info = self.MapInfo[floor (mapId / 1000)]
	if not info then

		if IsControlKeyDown() then
			Nx.prt ("GetWorldPos inst %s %s %s", mapId, mapX, mapY)
--			Nx.prt (" %s", debugstack (2, 3, 0))
		end

--		info = self.MapInfo[0]
		mapX = 0
		mapY = 0
	end
--]]

	local winfo = self.MapWorldInfo[mapId]
	if winfo then

		local scale = winfo[1]

		return	winfo[4] + mapX * scale,
					winfo[5] + mapY * scale / 1.5

--		if mapId == 11050 then
--			Nx.prt ("%s %s %s %s", info.Y, winfo[3], mapY, scale)
--		end

--		return	info.X + winfo[2] + mapX * scale,
--					info.Y + winfo[3] + mapY / 1.5 * scale
	end

	return 0, 0
end

--------
-- Get world positions of map (zone) rectangle
-- (id, x, y)

function Nx.Map:GetWorldRect (mapId, mapX, mapY, mapX2, mapY2)

	local x, y = self:GetWorldPos (mapId, mapX, mapY)
	local x2, y2 = self:GetWorldPos (mapId, mapX2, mapY2)

	return x, y, x2, y2
end

--------
-- Get zone position of world location
-- (id, x, y)

function Nx.Map:GetZonePos (mapId, worldX, worldY)

--	self.GetZonePosCnt = (self.GetZonePosCnt or 0) + 1

--	Nx.prt ("WXY %f %f", worldX, worldY)

	local winfo = self.MapWorldInfo[mapId]
	if winfo then

		local scale = winfo[1]		
		return	(worldX - winfo[4]) / scale,
					(worldY - winfo[5]) / scale * 1.5

--		local x = (worldX - info.X - winfo[2]) / scale
--		local y = (worldY - info.Y - winfo[3]) / scale * 1.5

--		Nx.prt ("XY %f %f %f", x, y, scale)

--		return x, y
	end

	return 0, 0
end

--------
-- Get continent of world location
-- (wx, wy)

--[[
function Nx.Map:GetContFromPos (worldX, worldY)

	if worldY < -2050 then
		return 3
	end

	if worldX > 2200 then
		return 2
	end

	return 1
end
--]]

--------
-- Convert frame (top left) to zone positions
--[[
function Nx.Map:FramePosToZonePos (x, y)
	x = self.ZonePosX + (x - self.PadX - self.MapW / 2) / 10.02 / self.Scale
	y = self.ZonePosY + (y - self.TitleH - self.MapH / 2) / 6.68 / self.Scale
	return x, y
end
--]]

--------
-- Convert frame (top left) to world positions

function Nx.Map:FramePosToWorldPos (x, y)
	x = self.MapPosX + (x - self.PadX - self.MapW / 2) / 10.02 / self.MapScale
	y = self.MapPosY + (y - self.TitleH - self.MapH / 2) / 10.02 / self.MapScale
	return x, y
end

--------
-- Set map target
-- (type string, x, y, x2, y2, texture (nil for default, false for none), user id, name)

function Nx.Map:SetTarget (typ, x1, y1, x2, y2, tex, id, name, keep, mapId)

	self.UpdateTrackingDelay = 0

	local sbt = self.ScaleBeforeTarget

--	if self.ScaleBeforeTarget then
--		self.Scale = self.ScaleBeforeTarget
		self.ScaleBeforeTarget = false
--	end

	if not keep then
		self:ClearTargets()
	end

	self.ScaleBeforeTarget = sbt or not next (self.Targets) and self.GOpts["MapRestoreScaleAfterTrack"] and self.Scale

	local tar = {}
	tinsert (self.Targets, tar)

	assert (x1)

	tar.TargetType = typ
	tar.TargetX1 = x1
	tar.TargetY1 = y1
	tar.TargetX2 = x2
	tar.TargetY2 = y2
	tar.TargetMX = (x1 + x2) * .5		-- Mid point
	tar.TargetMY = (y1 + y2) * .5
	tar.TargetTex = tex
	tar.TargetId = id
	tar.TargetName = name
--	tar.ArrowPulse = 1

	mapId = mapId or self.MapId
	tar.MapId = mapId

	local i = self.TargetNextUniqueId
	tar.UniqueId = i
	self.TargetNextUniqueId = i + 1

	local typ = keep and "Target" or "TargetS"
	local zx, zy = self:GetZonePos (mapId, tar.TargetMX, tar.TargetMY)

	Nx.Fav:Record (typ, name, mapId, zx, zy)

	return tar
end

--------
-- Clear all targets
-- (matchType we will clear or nil for any)

function Nx.Map:ClearTargets (matchType)

	if matchType then
		local tar = self.Targets[1]
		if tar then
			if tar.TargetType ~= matchType then
				return
			end
		end
	end

	self.Targets = {}
	self.Tracking = {}

	if self.LOpts.NXAutoScaleOn and self.ScaleBeforeTarget then

--		Nx.prt ("ScaleBeforeTarget trigger %s", matchType or "nil")
--		self.Scale = self.ScaleBeforeTarget

		self:GotoPlayer()		-- Map won't move if cursor on it
		self:Move (self.PlyrX, self.PlyrY, self.ScaleBeforeTarget, 60)
	end

	self.ScaleBeforeTarget = false
end

--------

function Nx.Map:ClearTarget (uniqueId)

	self.Tracking = {}

	local tar, i = self:FindTarget (uniqueId)

	if tar then
--		Nx.prt ("ClearTarget %s %s", uniqueId, i)
		tremove (self.Targets, i)
	end

end

function Nx.Map:FindTarget (uniqueId)

	for n, tar in ipairs (self.Targets) do
		if tar.UniqueId == uniqueId then
			return tar, n
		end
	end
end

--------
-- Changes indexed or last target to a new index

function Nx.Map:ChangeTargetOrder (srcI, dstI)

	srcI = srcI >= 0 and srcI or #self.Targets	-- -1 for last target

	local t = tremove (self.Targets, srcI)
	tinsert (self.Targets, dstI, t)

	self.Tracking = {}
end

--------
-- Reverse order of all targets

function Nx.Map:ReverseTargets()

	local tar = self.Targets
	local n2 = #tar

	for n = 1, n2 / 2 do
		local a = tar[n]
		tar[n] = tar[n2]
		tar[n2] = a
		n2 = n2 - 1
	end

	self.Tracking = {}
end

--------
-- Set map target at zone xy (pos 0-100)
-- Ret target table

function Nx.Map:SetTargetXY (mid, zx, zy, name, keep)

	Nx.Quest.Watch:ClearAutoTarget()

	local wx, wy = self:GetWorldPos (mid, zx, zy)
	return self:SetTarget ("Goto", wx, wy, wx, wy, nil, nil, name or "", keep, mid)
end

--------
-- Set map target at mouse click

function Nx.Map:SetTargetAtClick()

	Nx.Quest.Watch:ClearAutoTarget()

	local wx, wy = self:FramePosToWorldPos (self.ClickFrmX, self.ClickFrmY)
	local zx, zy = self:GetZonePos (self.MapId, wx, wy)
	local str = format (L["Goto %.0f, %.0f"], zx, zy)

	self:SetTarget ("Goto", wx, wy, wx, wy, nil, nil, str, IsShiftKeyDown())
end

function Nx.Map:SetTargetAtStr (str, keep)

	local mId, zx, zy = self:ParseTargetStr (str)
	if mId then
		local wx, wy = self:GetWorldPos (mId, zx, zy)
		local str = format ("%.0f, %.0f", zx, zy)
		self:SetTarget ("Goto", wx, wy, wx, wy, nil, nil, str, keep, mId)
	end
end

--------
-- Parse map target string. "[zone] x y"
-- (string)

function Nx.Map:ParseTargetStr (str)

--	Nx.prt (str)

	local str = gsub (strlower (str), ",", " ")

	local zone
	local zx, zy

	for s in gmatch (str, "%S+") do
		local i = tonumber (s)
		if i then
			if zx then
				zy = zy or i
			else
				zx = i
			end
		else
			if zone then
				zone = zone .. " " .. s
			else
				zone = s
			end
		end
	end

	local mid = self.RMapId

	if zone then

		mid = nil

		for name, id in pairs (Nx.MapNameToId) do
			if strfind (strlower (name), zone, 1, true) then
				mid = id
--				Nx.prt (" %s", name)
				break
			end
		end

		if not mid then
			Nx.prt (L["zone %s not found"], zone)
			return
		end
	end

	if not zx or not zy then
		Nx.prt (L["zone coordinate error"])
		return
	end

	return mid, zx, zy
end

----------------
-- External functions (for TomTom and Cartographer emulation)

--------
-- Used for id = TomTom:AddWaypoint (x, y, desc, persistent, minimap, world, silent)
-- self is bad if called by TomTom

function Nx:TTAddWaypoint (zx, zy, name)

	local map = Nx.Map:GetMap (1)
	local mid = map:GetCurrentMapId()
	local tar = map:SetTargetXY (mid, zx, zy, name, true)

	map:ChangeTargetOrder (-1, 1)

	return tar.UniqueId
end

function Nx:TTWayCmd(msg,editbox)
	local map = Nx.Map:GetMap(1)
	map:SetTargetAtStr (msg, true)
end

--------
-- Used for id = TomTom:AddZWaypoint (c, z, x, y, desc, persistent, minimap, world, callbacks, silent, crazy)

function Nx:TTAddZWaypoint (cont, zone, zx, zy, name, _persist, _minimap, _world, callbackT)

	local map = Nx.Map:GetMap (1)
	local mid = map:GetCurrentMapId()

	if cont and zone then
		mid = map:CZ2MapId (cont, zone)
	end

	return Nx:TTSetTarget (mid, zx, zy, name, callbackT)
end

--------
--	Used for id = TomTom:SetCustomWaypoint (c, z, x, y, callback, minimap, world, silent)

function Nx:TTSetCustomWaypoint (cont, zone, zx, zy, callbackT)

	return Nx:TTAddZWaypoint (cont, zone, zx, zy, "", false, nil, nil, callbackT)
end

--------
--	Used for id = TomTom:SetCustomMFWaypoint (m, f, x, y, opts)

function Nx:TTSetCustomMFWaypoint (aid, _floor, zx, zy, opts)

	zx = zx * 100
	zy = zy * 100

	return Nx:TTSetTarget (Nx.AIdToId[aid], zx, zy, opts["title"], opts["callbacks"])
end


function Nx:TTSetTarget (mid, zx, zy, name, callbackT)

--	Nx.prt ("TTSetTarget %s %s %s %s", name or "nil", mid or "nil", zx, zy)

	local map = Nx.Map:GetMap (1)
	local tar = map:SetTargetXY (mid, zx, zy, name, true)

	map:ChangeTargetOrder (-1, 1)

	if callbackT and callbackT["distance"] then

		local d = 99999
		local f

		for dist, func in pairs (callbackT["distance"]) do
			if dist < d then
				d = dist
				f = func
			end
		end

		tar.Radius = d
		tar.RadiusFunc = f

--		Nx.prt (" R %s", d)
	end

	return tar.UniqueId
end

--------
-- Used for TomTom:RemoveWaypoint (uid)

function Nx:TTRemoveWaypoint (id)

	local map = Nx.Map:GetMap (1)
	map:ClearTarget (id)
end

--------
-- Used for TomTom:SetCrazyArrow (uid, dist, title)

function Nx:TTSetCrazyArrow (id, dist, str)

	local map = Nx.Map:GetMap (1)
	local tar = map:FindTarget (id)
	if tar then
		tar.Radius = dist
		tar.TargetName = str
	end
end

--------
-- Cartographer emulation

function Nx:CartGetDistanceToPoint (zx, zy, mapName)

	local map = Nx.Map:GetMap (1)
	local mapId = Nx.MapNameToId[mapName]
	if not mapId then
		return 1000
	end

	local wx, wy = map:GetWorldPos (mapId, zx * 100, zy * 100)
	local x = wx - map.PlyrX
	local y = wy - map.PlyrY
	local distYd = (x * x + y * y) ^ .5 * 4.575

	return distYd
end

function Nx:CartSetPointAsWaypoint (zx, zy)

	Nx:TTAddZWaypoint (nil, nil, zx * 100, zy * 100, "Waypoint")

--	local map = Nx.Map:GetMap (1)
--	map:ChangeTargetOrder (-1, 1)
end

function Nx:CartAddLHWaypoint (cont, zone, zx, zy, name)

	Nx:TTAddZWaypoint (cont, zone, zx, zy, name)
end

function Nx:CartAddRoutesWaypoint (mapName, yx, name)

--	Nx.prt ("AddRoutesWaypoint %s %s", mapName, name or "nil")

	local map = Nx.Map:GetMap (1)
	local mapId = Nx.MapNameToId[mapName]
	local cont, zone
	if mapId then
		cont, zone = map:IdToContZone (mapId)
	end

	local zx = (yx % 10001) / 100
	local zy = floor (yx / 10001) / 100

	Nx:TTAddZWaypoint (cont, zone, zx, zy, name)

--	map:ChangeTargetOrder (-1, 1)
end

function Nx:CartAddWaypoint (note)

	local map = Nx.Map:GetMap (1)
	local mapId = Nx.MapNameToId[note["z"]]
	local cont, zone
	if mapId then
		cont, zone = map:IdToContZone (mapId)
	end

	local id = Nx:TTAddZWaypoint (cont, zone, note["x"] * 100, note["y"] * 100, note["n"])

	note["WaypointID"] = id

--	map:ChangeTargetOrder (-1, 1)
end

function Nx:CartCancelWaypoint (id)

	local map = Nx.Map:GetMap (1)
	map:ClearTargets()						-- Just clear all, since id can be some weird junk
end

function Nx:CartSetWaypointHitDistance (dist)

--	Nx.prt ("SetWaypointHitDistance %s", dist)

	local map = Nx.Map:GetMap (1)

	if map.Targets[1] then
		map.Targets[1].Radius = dist
	end
end

function Nx:CartNotePointNew (zone, x, y, name)

	local note = {}

	if not y then
		y = floor (x / 10001) / 100
		x = (x % 10001) / 100
	end

--	note["WaypointID"] = 0
	note["z"] = zone
	note["x"] = x
	note["y"] = y
	note["n"] = name or ""

	return note
end

--------
-- For RareSeeker and others

function Nx.MapMinimapOwned()
	local map = Nx.Map:GetMap (1)
	return map.MMOwn
end

function Nx.MapInitIconType (iconType, drawMode)

	local map = Nx.Map:GetMap (1)
	map:InitIconType (iconType, drawMode)
end

function Nx.MapAddIconPoint (iconType, mapName, x, y, texture)

	local map = Nx.Map:GetMap (1)
	local mapId = Nx.MapNameToId[mapName]

	if mapId then
		local wx, wy = map:GetWorldPos (mapId, x, y)
		map:AddIconPt (iconType, wx, wy, nil, texture)
	end
end

function Nx.MapAddIconRect (iconType, mapName, x, y, x2, y2, color)

	local map = Nx.Map:GetMap (1)
	local mapId = Nx.MapNameToId[mapName]

	if mapId then
		map:AddIconRect (iconType, mapId, x, y, x2, y2, color)
	end
end

function Nx.MapSetIconTip (icon, tip)

	local map = Nx.Map:GetMap (1)
	map:SetIconTip (icon, tip)
end

--------

function Nx.NXMapKeyTargetSkip()

	local self = Nx.Map:GetMap (1)

	local tar = self.Targets[1]
	if tar then
		tar.Radius = 999999999999
	end
end

-------------------------------------------------------------------------------
--

function Nx.Map.Dock:Create()

--PAIDS!

	if Nx.Free then
		return
	end

	self.UpdateMod = 100		-- Prevent error

	local gopts = Nx.GetGlobalOpts()
	self.GOpts = gopts

	if not gopts["MapMMButOwn"] then
		return
	end

	-- Create Window

	Nx.Window:SetCreateFade (1, 0)

	local win = Nx.Window:Create ("NxMapDock", nil, nil, nil, 1, 1, nil, true)
	self.Win = win

	win:SetBGAlpha (0, 1)

--	if gopts["MapMMDockHigh"] then
--		win:SetStrata ("HIGH")
--	end

	win:CreateButtons()
	win:InitLayoutData (nil, 100045, -.08, 45, 50, 2)

--	win:SetUser (m, self.OnWin)

	win.Frm:SetToplevel (true)

	self:UpdateOptions()

	self.InitPending = true

	Nx.Timer:Start ("DockMinimapScan", 3, self, self.MinimapOwnInit)

--PAIDE!
end

--------
-- Init minimap button ownership

function Nx.Map.Dock:MinimapOwnInit()

	self.InitPending = nil

	local map = Nx.Map:GetMap (1)
	local mm = getglobal ("Minimap")

	local mmOwnerNames = {
		"NXMiniMapBut","GameTimeFrame","TimeManagerClockButton","MiniMapWorldMapButton","MiniMapMailFrame","MiniMapTracking","MiniMapVoiceChatFrame","QueueStatusMinimapButton","MiniMapInstanceDifficulty",		
	}

	local f = getglobal ("MinimapBackdrop")	-- Add so it gets ignored
	map.MMOwnedFrms[f] = 0

	self.MMFrms = {}

	for k, name in ipairs (mmOwnerNames) do
		local f = getglobal (name)
		if f then

			map.MMOwnedFrms[f] = 0
			tinsert (self.MMFrms, f)

			f:SetParent (self.Win.Frm)

			if name == "MiniMapTracking" then
				f:Show()
			end
		end
	end

	-- Scan all frames

	local texnames = { ["Interface\\AddOns\\CT_Core\\Images\\minimapIcon"] = 1, }

	local mapf = map.Frm
	local winf = self.Win.Frm

	local found = {}

	local f = EnumerateFrames()
	while f do

		if not f:IsObjectType ("Model") then
--		if f:IsShown() and not f:IsObjectType ("Model") then

			local pt, relTo = f:GetPoint()
			if relTo == mm then

				local parent = f:GetParent()
				if parent ~= mm and parent ~= mapf then
--					Nx.prtFrame ("Dock Scan", f)

					found[f] = 1
				end
			end

			local reg = { f:GetRegions() }
			for k, v in ipairs (reg) do

				if v:IsObjectType ("Texture") then
					local tname = v:GetTexture()
					if tname and texnames[tname] then
--					if tname and strfind (tname, "CT") then
--						Nx.prt ("Tex %s", tname)

						found[f] = 1
						break
					end
				end
			end
		end

		f = EnumerateFrames (f)
	end

	-- Add found frames to list

	for f in pairs (found) do

		if not map.MMOwnedFrms[f] then
			map.MMOwnedFrms[f] = 0
			tinsert (self.MMFrms, f)
			f:SetParent (winf)
		end
	end

	map.Win:Show (map.StartupShown)

	Nx.Map:MinimapButtonShowUpdate()

	if NxData.DebugDock then
		Nx.prt ("DockScan %s", #self.MMFrms)
	end
end

--------

function Nx.Map.Dock:UpdateOptions()

	local win = self.Win
	if win then

		local lock = win:IsLocked()
		win:SetBGAlpha (0, lock and 0 or 1)

		self.UpdateMod = 1
	end
end

--------

function Nx.Map.Dock:MinimapDetachFrms()

	if Nx.Tick % self.UpdateMod ~= 0 then
		return
	end

	if not self.Win then
		return
	end

	self.UpdateMod = 30

	if NxData.DebugDock then
		Nx.prt ("Dock %s", #self.MMFrms)
	end

	local mm = getglobal ("Minimap")
--	local mmt = getglobal ("MiniMapTracking")
	local mmClock = getglobal ("TimeManagerClockButton")
	local win = self.Win
	local winf = win.Frm
	local butLvl = winf:GetFrameLevel() + 1
	local cLvl = butLvl + 1
	local setCLvls = Nx.Util_SetChildLevels
	local strata = winf:GetFrameStrata()

	local mini = self.GOpts["MMButWinMinimize"]

	local cx, cy = win:GetClientOffset()
	local cw, ch = win:GetSize()

	local columnCnt = mini and 1 or self.GOpts["MapMMButColumns"]		-- max (floor (cw / 30), 1)
	local columnStart = 0
	local columnEnd = columnCnt - 1

	local colAdd = 1
	local spacing = self.GOpts["MapMMButSpacing"]
	local yAdd = spacing
	local y = cy + 6

	local s = self.GOpts["MapMMButCorner"]
	if s == "TopRight" or s == "BottomRight" then
		columnEnd = -columnEnd
--		columnStart, columnEnd = columnEnd, columnStart
		colAdd = -1
	end
	if s == "BottomLeft" or s == "BottomRight" then
		yAdd = -yAdd
		y = cy - 6
	end

	local column = columnStart
	local borderSize = win:GetBorderSize()
	local baseX = borderSize + 17
	local baseY = y
	local incRow

--	if IsAltKeyDown() then return end

	for n, f in ipairs (self.MMFrms) do

		if f:IsVisible() then

			local w = f:GetWidth()
			if w > 0 then

				local sc = 32 / max (w, 32)

				if incRow then
					incRow = false
					column = columnStart
					y = y + yAdd
				end

				if mini and n > 1 then
					column = 0
					y = baseY
					butLvl = 1
					cLvl = 1
					sc = .1
				end

				local x = baseX + column * spacing

				f:SetParent (winf)
				f:ClearAllPoints()

				if f == mmClock then
					sc = sc * 1.5
--					f:SetPoint ("CENTER", winf, "TOPLEFT", x / sc - 3, -y / sc + 3)
				end

				f:SetPoint ("CENTER", winf, "TOPLEFT", x / sc, -y / sc)

--				if f == mmt then
--					sc = .82
--					f:SetPoint ("CENTER", winf, "TOPLEFT", x / sc - 3, -y / sc + 3)
--				end

				f:SetScale (sc)

				f:SetFrameStrata (strata)
				f:SetFrameLevel (butLvl)
				setCLvls (f, cLvl)
--[[
				if IsControlKeyDown() then
					Nx.prt ("MMFrms #%d %s %s", n, f:GetName() or "nil", w)
					Nx.prtFrame ("", f)
				end
--]]
				if column == columnEnd then
					incRow = true
				end

				column = column + colAdd
			end

		elseif f:IsShown() then		-- Strange? Fixes Outfitter Minimap button not drawing

--			Nx.prt ("Frm vis error %s", f:GetName() or "nil")
			f:Show()
		end
	end

	if not win.MovSizing then
--		local h = min (ch, cy - y)

		local x = winf:GetLeft()

		win:SetSize (34, 11)
	end

	-- Debug

--[[

	if IsControlKeyDown() then

		local frms = {}

		for n, f in ipairs (self.MMFrms) do
			if frms[f] then
				Nx.prt ("Dup frm %s #%s", f:GetName() or "nil", n)
			end
			frms[f] = n
		end
	end
--]]
end

-------------------------------------------------------------------------------
-- Routing

--------
-- Gather icons

function Nx.Map:RouteGathers()

	local points = {}
	local cnt = self:GetIconCnt ("!Ga")

	for n = 1, cnt do
		local wx, wy = self:GetIconPt ("!Ga", n)
		local x, y = self:GetZonePos (self.MapId, wx, wy)

		local pt = {}
		tinsert (points, pt)
		pt.X = x
		pt.Y = y
	end

	self:RouteMerge (points)

	local route = self:Route (points)
	if route then
		self:RouteToTargets (route, false)
	end
end

function Nx.Map:RouteTargets()

	local points = {}

	for n, tar in ipairs (self.Targets) do

		local wx = tar.TargetMX
		local wy = tar.TargetMY
		local x, y = self:GetZonePos (self.MapId, wx, wy)

		local pt = {}
		tinsert (points, pt)
		pt.Name = tar.TargetName
		pt.X = x
		pt.Y = y
	end

	local route = self:Route (points)
	if route then
		self:RouteToTargets (route)
	end
end

function Nx.Map:RouteQuests (points)

	local route = self:Route (points)
	if route then
		self:RouteToTargets (route, false)
	end
end

--------
-- Merge close points

function Nx.Map:RouteMerge (points)

	local radius = self.GOpts["RouteMergeRadius"]

	if #points < 2 or radius < 1 then
		return
	end

	local tm = GetTime()

	sort (points, function (a, b) return a.X < b.X end)

--	for n, pt in ipairs (points) do
--		Nx.prt ("%s %s", n, pt.X)
--	end

	radius = radius / Nx.Map:GetWorldZoneScale (self.MapId) / 4.575
--	Nx.prt ("rad %s", radius)

	local radiusSq = radius ^ 2	-- Yards to world space squared

	local startCnt = #points
	local merged = true

	while merged do

		merged = false

		local close = 999999999
		local closeI1
		local closeI2

		for n1, pt1 in ipairs (points) do

--			local done

			for n2 = n1 + 1, #points do

				local pt2 = points[n2]

				if pt2.X - pt1.X > radius then
--					Nx.prt ("done %s %s", pt1.X, pt2.X)
--					done = true
					break
				end

				local d = (pt1.X - pt2.X) ^ 2 + ((pt1.Y - pt2.Y) / 1.5) ^ 2
				if d < close then
					close = d
					closeI1 = n1
					closeI2 = n2
--[[
					if d ^ .5 < radius * .5 then	-- Close enough? Early out
						Nx.prt ("%s + %s, %s", n1, n2, d ^ .5)
						done = true
						break
					end
--]]
				end
			end

--			if done then
--				break
--			end
		end

		if close ^ .5 < radius then

--			Nx.prt (" + %s %s", closeI1, closeI2)

			local pt1 = points[closeI1]
			local pt2 = points[closeI2]

			pt1.X = (pt1.X + pt2.X) * .5		-- Average
			pt1.Y = (pt1.Y + pt2.Y) * .5

			tremove (points, closeI2)
			merged = true

			sort (points, function (a, b) return a.X < b.X end)
		end
	end

	Nx.prt (L["Merged %s in %.1f secs"], startCnt - #points, GetTime() - tm)
end

--------
-- Make a route and target it

function Nx.Map:Route (points)

	if #points == 0 then
		return
	end

	-- Test

	local tm = GetTime()
--[[
	local blks = 20
	local scale = 5

	local points = {}
	for n = 0, 399 do
		local pt = {}
		points[n + 1] = pt
		pt.X = n % blks * scale + floor (n / 7) % 2 * 3
		pt.Y = floor (n / blks) * scale + floor (n / 3) % 2 * 4
--		pt.X = random (1, 20)
--		pt.Y = random (1, 20)
	end
--]]

	--

	local route = {}

	for n, pt in ipairs (points) do
		pt.Y = pt.Y / 1.5		-- Make Y same units as X
	end

	-- Nearest neighbor

	if #points > 1 then

		local x = points[1].X
		local y = points[1].Y
		if x == points[#points].X and y == points[#points].Y then	-- End same as start?
			tremove (points)
		end
	end

	local x, y = self:GetZonePos (self.MapId, self.PlyrX, self.PlyrY)
	y = y / 1.5

	while #points > 0 do

		local closeDist = 999999999
		local closeI

		for n, pt in ipairs (points) do

			local dist = (x - pt.X) ^ 2 + (y - pt.Y) ^ 2
			if dist < closeDist then
				closeDist = dist
				closeI = n
			end
		end

		local pt = tremove (points, closeI)

		local r = {}
		tinsert (route, r)
		r.Name = pt.Name
		r.X = pt.X
		r.Y = pt.Y
		r.Weight = pt.Weight or 1

		x = pt.X
		y = pt.Y
	end

	-- Add first node at end if needed for loop

	local x = route[1].X
	local y = route[1].Y

	if x ~= route[#route].X or y ~= route[#route].Y then

--		Nx.prt ("%f %f %f %f", x, route[#route].X, y, route[#route].Y)

		local r = {}
		r.X = x
		r.Y = y
		tinsert (route, r)
	end

	-- Calc length (sets node distances)

	local len = self:RouteLen (route)
--	Nx.prt ("Route len %s, %s secs", len, GetTime() - tm)

	-- Optimize .517 secs on 400

	for n = 1, 5 do
		local swap = self:RouteOptimize (route)
--		local len = self:RouteLen (route)
--		Nx.prt ("Route opt #%s len %s, %s secs", #route, len, GetTime() - tm)
		if not swap then
			break
		end
	end

	-- Show info

	local scale = self:GetWorldZoneScale (self.MapId)
	local len = self:RouteLen (route)
	Nx.prt (L["Routed %s nodes, %d yards in %.1f secs"], #route, len * scale * 4.575, GetTime() - tm)

	return route
end

function Nx.Map:RouteToTargets (route, targetIcon)

	Nx.Quest.Watch:ClearAutoTarget()

	local mapId = self.MapId

	for n, r in ipairs (route) do

		local wx, wy = self:GetWorldPos (mapId, r.X, r.Y * 1.5)
		local s = format ("Route%s (%s) %s", n, #route - n + 1, r.Name or "")
		local tar = self:SetTarget ("Route", wx, wy, wx, wy, targetIcon, nil, s, n ~= 1)

		tar.Radius = self.GOpts["RouteGatherRadius"]

--		self:SetTargetXY (mapId, r.X, r.Y * 1.5, "r" .. n, true)
	end
end

function Nx.Map:RouteLen (route)

	local len = 0

	for n = 1, #route - 1 do
		local r1 = route[n]
		local r2 = route[n + 1]
		r1.Dist = ((r1.X - r2.X) ^ 2 + (r1.Y - r2.Y) ^ 2) ^ .5
		len = len + r1.Dist
--		Nx.prt ("Route %s len %s", n, ((x - r.X) ^ 2 + (y - r.Y) ^ 2) ^ .5)
	end

	return len
end

function Nx.Map:RouteOptimize (route)

	local swap

---[[ 1394.4788 len
	for len = #route - 2, 2, -1 do

		for n = 1, #route - len - 1 do

			local r1 = route[n]
			local r2 = route[n + 1]
			local n2 = n + len
			local r3 = route[n2]
			local r4 = route[n2 + 1]

			if r1.Dist + r3.Dist >
				((r1.X - r3.X) ^ 2 + (r1.Y - r3.Y) ^ 2) ^ .5 + ((r2.X - r4.X) ^ 2 + (r2.Y - r4.Y) ^ 2) ^ .5 then

				self:RouteSwap (route, n + 1, len)

--				local dist1 = ((r1.X - r2.X) ^ 2 + (r1.Y - r2.Y) ^ 2) ^ .5 + ((r3.X - r4.X) ^ 2 + (r3.Y - r4.Y) ^ 2) ^ .5
--				local dist2 = ((r1.X - r3.X) ^ 2 + (r1.Y - r3.Y) ^ 2) ^ .5 + ((r2.X - r4.X) ^ 2 + (r2.Y - r4.Y) ^ 2) ^ .5
--				Nx.prt ("Route %s swap %s %s %s", len, n, dist1 or 0, dist2 or 0)

				swap = true
			end
		end
	end
--]]

--[[	Little slower
	for last = #route - 1, 2, -1 do

		for n = 1, last - 2 do

			local r1 = route[n]
			local r2 = route[n + 1]
			local n2 = last
			local r3 = route[n2]
			local r4 = route[n2 + 1]

			if r1.Dist + r3.Dist >
				((r1.X - r3.X) ^ 2 + (r1.Y - r3.Y) ^ 2) ^ .5 + ((r2.X - r4.X) ^ 2 + (r2.Y - r4.Y) ^ 2) ^ .5 then

				self:RouteSwap (route, n + 1, last - n)

--				local dist1 = ((r1.X - r2.X) ^ 2 + (r1.Y - r2.Y) ^ 2) ^ .5 + ((r3.X - r4.X) ^ 2 + (r3.Y - r4.Y) ^ 2) ^ .5
--				local dist2 = ((r1.X - r3.X) ^ 2 + (r1.Y - r3.Y) ^ 2) ^ .5 + ((r2.X - r4.X) ^ 2 + (r2.Y - r4.Y) ^ 2) ^ .5
				Nx.prt ("Route %s swap %s %s %s", last - n, n, dist1 or 0, dist2 or 0)

				swap = true
			end
		end
	end
--]]

	return swap
end

function Nx.Map:RouteSwap (route, first, len)

	-- 1 2 3 4 5 6 7 8	Before (3, +4)
	-- 1 2 6 5 4 3 7 8	After

	local last = first + len - 1
	local stop = first + floor (len / 2) - 1

--[[	Loop unroll does not help
	local loops = floor (len / 2)

--	if loops > 1 then

--		Nx.prt ("Route swap loops %s", loops)

		if loops % 2 ~= 0 then
			route[first], route[last] = route[last], route[first]
			first = first + 1
			last = last - 1
		end

		for n = first, stop, 2 do
			route[n], route[last] = route[last], route[n]
			route[n+1], route[last-1] = route[last-1], route[n+1]
			last = last - 2
		end
	else
--]]

	local n2 = last
	for n = first, stop do
		route[n], route[n2] = route[n2], route[n]
		n2 = n2 - 1
	end

	for n = first - 1, last do
		local r1 = route[n]
		local r2 = route[n + 1]
		r1.Dist = ((r1.X - r2.X) ^ 2 + (r1.Y - r2.Y) ^ 2) ^ .5
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Test code

function Nx.Map:VehicleDumpPos()

	-- Right Reaver guard .431 -.701  -359

	for n = 1, GetNumBattlefieldVehicles() do

		local x, y, unitName, possessed, typ, dir, player = GetBattlefieldVehicleInfo (n)
		if x and not player then

			local xo = self.PlyrRZX - x * 100
			local yo = (self.PlyrRZY - y * 100) / 1.5
			dir = dir / PI * -180
			xo, yo = xo * cos (dir) + yo * sin (dir), (xo * -sin (dir) + yo * cos (dir)) * 1.5

			Nx.prt ("#%s %s %f %f %.3f %s", n, unitName or L["nil"], xo, yo, dir or -1, typ or L["no type"])
		end
	end
end

--[[

--------
-- Get zone position of world location
-- (id, x, y)

function Nx.Map:OLD_GetZonePos (mapId, worldX, worldY)

--	Nx.prt ("WXY %f %f", worldX, worldY)

	local cont = floor (mapId / 1000)

	local info = self.MapInfo[cont]
	if info then

		local winfo = self.MapWorldInfo[mapId]
		if winfo then

			local scale = winfo[1]

			local x = (worldX - info.X - winfo[2]) / scale
			local y = (worldY - info.Y - winfo[3]) / scale * 1.5

--			Nx.prt ("XY %f %f %f", x, y, scale)

			return x, y
		end
	end

	return 0, 0
end

--------
-- Test empty function

function Nx.Map:TestEmpty()
end

function Nx.Map:Test1()

	local s = "########"
	local loc1 = strsub (s, 1, 4)
	local x, y = Nx.Quest:UnpackLocPtOff (loc1, 1)
end

function Nx.Map:Test2()
	local s = "####"
	local x, y = Nx.Quest:UnpackLocPtOff (s, 1)
end

--------
-- Do test

function Nx.Map:Test()

--[
	local tm = GetTime()
	for n = 1, 1000000 do
		self:TestEmpty()
	end
	Nx.prt ("Time %.3f empty", GetTime() - tm)

	local tm = GetTime()
	for n = 1, 1000000 do
		self:GetZonePos (1001, 0, 0)
	end
	Nx.prt ("Time %.3f", GetTime() - tm)

	local tm = GetTime()
	for n = 1, 1000000 do
		self:OLD_GetZonePos (1001, 0, 0)
	end
	Nx.prt ("Time %.3f", GetTime() - tm)
--]

	-- Precondition
---[
	for n = 1, 1000 do
		self:Test1()
		self:Test2()
	end

	-- Test

	local tm = GetTime()
	local func = Nx.Map.TestEmpty
	for n = 1, 5000000 do
		func (self)
	end
	Nx.prt ("Time %.3f empty", GetTime() - tm)

	local tm = GetTime()
	local func = Nx.Map.Test1
	for n = 1, 5000000 do
		func (self)
	end
	Nx.prt ("Time %.3f #1", GetTime() - tm)

	local tm = GetTime()
	local func = Nx.Map.Test2
	for n = 1, 5000000 do
		func (self)
	end
	Nx.prt ("Time %.3f #2", GetTime() - tm)
--]
end

--]]

-------------------------------------------------------------------------------
-- EOF














