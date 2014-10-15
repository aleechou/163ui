--
-- JSHB Options
--

JSHB.Options = {}
JSHB.Options.fontFlagTable = {}
local L = _G.JSHB.L

function JSHB.Options:SetupFontFlags(db, keyname, state)
	local t = { strsplit(",", db[3]) }	
	if tContains(t, keyname) and (state == false) then
		tremove(t, JSHB.GetMatchTableValSimple(t, keyname, true) )
	elseif (not tContains(t, keyname) ) and (state == true) then
		t[#t+1] = keyname
	end	
	db[3] = strtrim(strjoin(",", unpack(t) ),",")
end

function JSHB.Options:GetPlayerFocusSpells()
	local spellTable = {}
	for i = 1, MAX_SKILLLINE_TABS do
		local name, texture, offset, numSpells = GetSpellTabInfo(i)
		if not name then break end
		
		for s = offset + 1, offset + numSpells do
			local spellName, spellSubName = GetSpellBookItemName(s, BOOKTYPE_SPELL)
			if not spellName then do break end end

			local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellName)
			if cost and (cost > 0) then
				spellTable[name] = name .. " (" .. cost .. ")"
			end
		end
	end

	return spellTable
end

function JSHB.Options:LockDown(func)
	if (not JSHB.moversLocked) then
		JSHB.moversLocked = not JSHB.moversLocked
		JSHB.LockAllMovers() 
	end	
	func()
end

function JSHB.Options:SetTimerSetCollapsed(which)
	for i=1,#which do
		which[i][21] = nil
	end
end

-- Collapse all expanded options areas
function JSHB.Options:CollapseAll()
	local function recurseTree(tree)
		for k,v in pairs(tree) do
			if (type(v) == "table") then
				recurseTree(tree[k])
			elseif ( (k == "showsettings") or (k == "showsettings2") or (k == "showsettings3") ) then
				tree[k] = nil
			end
		end
	end
	-- This function sets all "showsettings" database entries to nil to collapse all expanded options areas
	recurseTree(_G.JSHB.Options.DB)
	-- Also collapse the timer sets
	JSHB.Options:SetTimerSetCollapsed(_G.JSHB.Options.DB.timers.timerbar1.timers)
	JSHB.Options:SetTimerSetCollapsed(_G.JSHB.Options.DB.timers.timerbar2.timers)
	JSHB.Options:SetTimerSetCollapsed(_G.JSHB.Options.DB.timers.timerbar3.timers)
end

-- Timer table validation.  The table should be sorted properly already, if it is - this does nothing harmful
function JSHB.Options:ReOrderTimerList(which)
	if not _G.JSHB.Options.DB.timers["timerbar"..which].stationary then return end
	for i=1,#_G.JSHB.Options.DB.timers["timerbar"..which].timers do
		_G.JSHB.Options.DB.timers["timerbar"..which].timers[i][19] = i
	end
end

function JSHB.Options:CheckTimerListOrder19(which)
	for i=1,#_G.JSHB.Options.DB.timers["timerbar"..which].timers do
		if _G.JSHB.Options.DB.timers["timerbar"..which].timers[i][19] == nil then
			JSHB.Options:ReOrderTimerList(which)
			return
		end
	end
end

-- This is a sort function for timers in a set.  It only sorts, changes need to be notified and reconfigured separatly
function JSHB.Options:SortTimerList(which)
	if _G.JSHB.Options.DB.timers["timerbar"..which].stationary then
		JSHB.Options:CheckTimerListOrder19(which)
		table.sort(_G.JSHB.Options.DB.timers["timerbar"..which].timers, function(a,b) return(a[19] < b[19]) end)
		JSHB.Options:ReOrderTimerList(which)
	else
		table.sort(_G.JSHB.Options.DB.timers["timerbar"..which].timers, function(a,b)
			local aComp = (a[1] ~= nil) and (tonumber(a[1]) and (select(1, GetSpellInfo(a[1]) ) ) or a[1]) or (tonumber(a[2]) and (select(1, GetItemInfo(a[2]) ) ) or a[2])
			local bComp = (b[1] ~= nil) and (tonumber(b[1]) and (select(1, GetSpellInfo(b[1]) ) ) or b[1]) or (tonumber(b[2]) and (select(1, GetItemInfo(b[2]) ) ) or b[2])
			return(tostring(aComp) < tostring(bComp) )
		end)
	end
end

function JSHB.Options:PopulateDB()
	JSHB.Options.DB = _G.JSHB.db.profile
	-- Sort timers
	JSHB.Options:SortTimerList(1)
	JSHB.Options:SortTimerList(2)
	JSHB.Options:SortTimerList(3)
end

function JSHB.Options:SetupOptions()
	local t 						= { handler = JSHB, type = "group", name = "JSHB " .. JSHB.myVersion, guiInline = true, childGroups = "tree", args = {} }
	t.args.main						= JSHB.Options:Panel_Main(1)
	t.args.cooldown					= JSHB.Options:Panel_Cooldown(2)
	t.args.crowdcontrol				= JSHB.Options:Panel_CrowdControl(3)
	if tContains({ "HUNTER", "WARRIOR", "ROGUE", "WARLOCK" }, select(2, UnitClass("player") ) ) then
		t.args.energybar			= JSHB.Options:Panel_EnergyBar(4)
	end
	if tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) then
		t.args.enrage				= JSHB.Options:Panel_Enrage(5)
	end
	if tContains({ "HUNTER", "WARRIOR", "ROGUE" }, select(2, UnitClass("player") ) ) then
		t.args.aspectindicator		= JSHB.Options:Panel_AspectIndicator(6)
	end
	t.args.interrupts				= JSHB.Options:Panel_Interrupts(8)
	if tContains({ "HUNTER" }, select(2, UnitClass("player") ) ) then
		t.args.masterscall			= JSHB.Options:Panel_MastersCall(9)
	end
	if tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) then
		t.args.misdirection			= JSHB.Options:Panel_Misdirection(10)
	end
	t.args.timers1					= {	order = 40,	type = "group",	name = L["Timer Bar 1"], childGroups = "tab", args = JSHB.Options:CreateTimerSet(1) }
	t.args.timers2					= {	order = 42,	type = "group",	name = L["Timer Bar 2"], childGroups = "tab", args = JSHB.Options:CreateTimerSet(2) }
	t.args.timers3					= {	order = 44,	type = "group",	name = L["Timer Bar 3"], childGroups = "tab", args = JSHB.Options:CreateTimerSet(3) }
	t.args.alerts					= { order = 48, type = "group", name = L["Alerts"], childGroups = "tab", args = JSHB.Options:CreateAlerts() }
	t.args.profile					= LibStub("AceDBOptions-3.0"):GetOptionsTable(JSHB.db)
	t.args.profile.order 			= 49
	
	return t
end

local optionsAreLoaded = nil
function JSHB.Options.Initialize()

	if optionsAreLoaded then return end
	
	JSHB.Options:PopulateDB() -- Populate the local DB upvalue variable
	JSHB.Options:CollapseAll() -- Collapse all expanded option frames on load
	
	optionsAreLoaded = true -- Flag the options as being loaded

	-- Local tables for use in options
	JSHB.Options.fontFlagTable = {}
	JSHB.Options.fontFlagTable["OUTLINE"] = L["OUTLINE"]
	JSHB.Options.fontFlagTable["THICKOUTLINE"] = L["THICKOUTLINE"]
	JSHB.Options.fontFlagTable["MONOCHROME"] = L["MONOCHROME"]
	
	-- Setup the actual options panels
	local ACD3 = LibStub("AceConfigDialog-3.0")
	
	-- Register the options table
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("JSHB", JSHB.Options.SetupOptions)
	
	local status = ACD3:GetStatusTable("JSHB")
	status.width = 820
	status.height = 700
	
	JSHB.SetMinimapButton( (JSHB.db.profile.minimapbutton == true) and true or nil)
end

-- Creates the mimimap button to open the options panel
-- Code primarily from DBM - credit's to them www.deadlybossmods.com
do
	local dragMode = nil
	local function moveButton(self)
		if dragMode == "free" then
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", x, y)
		else
			local centerX, centerY = Minimap:GetCenter()
			local x, y = GetCursorPosition()
			x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
			centerX, centerY = math.abs(x), math.abs(y)
			centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2) ) * 80, (centerY / sqrt(centerX^2 + centerY^2) ) * 80
			centerX = (x < 0) and -centerX or centerX
			centerY = (y < 0) and -centerY or centerY
			self:ClearAllPoints()
			self:SetPoint("CENTER", centerX, centerY)
		end
	end

	local button = CreateFrame("Button", "JSHBMinimapButton", Minimap)
	button:SetHeight(32)
	button:SetWidth(32)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", -25.0, -76.0)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("Interface\\AddOns\\JSHB\\media\\graphics\\Minimap-Button-Up")
	button:SetPushedTexture("Interface\\AddOns\\JSHB\\media\\graphics\\Minimap-Button-Down")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

	button:SetScript("OnMouseDown", function(self, button)
		if (button == "RightButton") then return end
		if IsShiftKeyDown() and IsAltKeyDown() then
			dragMode = "free"
			self:SetScript("OnUpdate", moveButton)
		elseif IsShiftKeyDown() then
			dragMode = nil
			self:SetScript("OnUpdate", moveButton)
		end
	end)
	button:SetScript("OnMouseUp", function(self, button)
		if (button == "RightButton") then
			if (GetMouseFocus():GetName() == "JSHBMinimapButton") then
				JSHB.ToggleMoversLock()
			end
		else
			self:SetScript("OnUpdate", nil)
		end
	end)
	button:SetScript("OnClick", function(self, button)
		if IsShiftKeyDown() then return end
		if LibStub("AceConfigDialog-3.0").OpenFrames["JSHB"] then
			JSHB.CloseOptions()
		else
			JSHB.OpenOptions()
		end
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self)
		GameTooltip:SetText(JSHB.L["JSHB"].." "..JSHB.myVersion, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(JSHB.L["MINIMAP_BUTTON_INFO"], RAID_CLASS_COLORS[select(2, UnitClass("player") )].r, RAID_CLASS_COLORS[select(2, UnitClass("player") )].g, RAID_CLASS_COLORS[select(2, UnitClass("player") )].b, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	function JSHB.SetMinimapButton(state)
		if state then
			JSHB.db.profile.minimapbutton = true
			button:Show()
		else
			JSHB.db.profile.minimapbutton = false
			button:Hide()
		end
	end
end

local onCloseHandler = nil
local savedPoints = nil
function JSHB.OpenOptions()
	if LibStub("AceConfigDialog-3.0").OpenFrames["JSHB"] then return end
	
	PlaySound("igMainMenuOptionCheckBoxOn")
	LibStub("AceConfigDialog-3.0"):Open("JSHB")
	local f = LibStub("AceConfigDialog-3.0").OpenFrames["JSHB"]
	f.frame:SetClampedToScreen(true)
	f.frame:SetResizable(true)
	if savedPoints then
		f.frame:ClearAllPoints()
		f.frame:SetPoint(unpack(savedPoints) )
	end
	f.sizer_e:Hide()
	f.sizer_se:Hide()
	-- We need to free memory from garbage created by Ace after closing the options panel
	onCloseHandler = f.events["OnClose"] -- Ace hack
	f:SetCallback("OnClose", function(...)
			savedPoints = { f.frame:GetPoint() }
			collectgarbage("collect")
			onCloseHandler(...)
			collectgarbage("collect")
		end)
end

function JSHB.CloseOptions()
	if LibStub("AceConfigDialog-3.0").OpenFrames["JSHB"] then
		PlaySound("igMainMenuOptionCheckBoxOn")
		LibStub("AceConfigDialog-3.0"):Close("JSHB")
		collectgarbage("collect")
	end
end
