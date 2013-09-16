local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxHelp - User help and docs code
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

--------
-- Init Help data

function Nx.Help:Init()
	Nx.Timer:Start ("HelpSC", 5, self, self.StartupCheckTimer)
end

--------
-- Open Help

function Nx.Help:StartupCheckTimer()
	if _G["Cartographer3"] then
		Nx.prt (L["\n|cffffff00Cartographer 3 may conflict with Carbonite\nThis can cause BLAH! to appear"])
	end
end

--------
-- Open Help

function Nx.Help:Open()

	local win = self.Win

	if not win then
		self:Create()
		win = self.Win
	end

	win:Show()
end

--------
-- Open Help

function Nx.Help:Create()

	-- Create Window

	local win = Nx.Window:Create ("NxHelp", nil, nil, nil, 1)
	self.Win = win
	local frm = win.Frm

	win:CreateButtons (true, true)
	win:InitLayoutData (nil, -.25, -.1, -.5, -.7)

	tinsert (UISpecialFrames, frm:GetName())

	frm:SetToplevel (true)

	local str = Nx.TXTBLUE .. NXTITLEFULL .. " " .. Nx.VERSION .. L["|cffffffff Help"]
	win:SetTitle (str)

	--

	local listW = 70
	local data = { "Welcome", "Using", "WotLK Help", "Keys", "Map", "5.041", "4.301", "4.3", "4.22", "4.21", "4.2", "4.11", "4.1", "4.034", "4.033", "4.032", "4.031", "4.013", "4.012", "4.011" }

	local list = Nx.List:Create (false, 0, 0, 1, 1, frm)
	self.List = list

	list:SetUser (self, self.OnListEvent)
	win:Attach (list.Frm, 0, listW, 0, 1)

	list:ColumnAdd (L["Page"], 1, listW)

	for k, str in ipairs (data) do

		list:ItemAdd()
		list:ItemSet (1, _TRANS(str))
	end

	--

	local scf = CreateFrame ("ScrollFrame", nil, UIParent)
	self.ScFrm = scf

	win:Attach (scf, listW, 1, 0, 1)

	--
--[[
	local f = CreateFrame ("SimpleHTML", "NxHH", UIParent)
	self.Frm = f

	win:Attach (f, 0, 1, 0, 1)

	f:SetTextColor (1, 1, 1)

	f:SetFontObject ("H1", "GameFontNormal")
	f:SetFontObject ("P", "GameFontNormalSmall")
--	f:SetFont ("P", "Fonts\\FRIZQT__.TTF", 20)

	f:SetText ("<HTML><BODY><H1>Header 1</H1><P>TEST xxx\nABCDEFG\nHelp me!</P></BODY></HTML>")
--	f:Show()

	local t = f:CreateTexture()
	t:SetTexture (.2, .2, .2, .5)
	t:SetAllPoints (f)
	f.texture = t

	scf:SetScrollChild (f)
--]]

	-- Text

	local f = CreateFrame ("Frame", nil, UIParent)
	self.Frm = f

	local fstr = f:CreateFontString()
	self.FStr = fstr
	fstr:SetFontObject ("GameFontNormalSmall")
	fstr:SetJustifyH ("LEFT")
	fstr:SetPoint ("TOPLEFT", 0, -6)

	f.NxSetSize = self.OnSetSize
	win:Attach (f, listW, 1, 0, 1)

	scf:SetScrollChild (f)

	self:SetText (1)
end

function Nx.Help:OnSetSize (w, h)

	Nx.Help.FStr:SetWidth (w)
end

function Nx.Help:OnListEvent (eventName, sel, val2)

	if eventName == "select" or eventName == "back" then
		self:SetText (sel)
	end
end

function Nx.Help:SetText (page)

	local str

--PAIDS!

	str = {
[[
  |cffffffffWelcome to CARBONITE!|r

  Open the |cff7fff7fCarboniteReadMe.txt|r file in your Carbonite AddOns directory for additional help and the user guide.

  |cffefefefVisit |cff8f8fffcarboniteaddon.com |rto get the latest version or more info.|r


  To the left is the page selection list. Click it to see help pages or changes in recent versions.


  |cffcfcfcfOverview:|r

   UI: All windows are sizeable (select any border, click and drag) and moveable (select the top of the window, click and drag)

   CARBONITE Minimap button: Left click the (C) button to toggle the map. Right clicking will bring up the menu.

   Map: The CARBONITE map replaces the Blizzard map; if you wish to see the Blizzard map or another map press ALT + m.  Left click and drag to scroll the map around.  Use the mouse wheel to zoom in/out.  Pressing 'm' toggles between the maximized and normal size map.

   Quest Log: The CARBONITE quest log replaces the Blizzard one.  Some features are available from the menu.  Shift + click will toggle watching the quest like it did before.  Shift + click a header to watch all quests under the header.

   Quest Watch:  The quest watch window has buttons to the left of the quests and objective names.  Left clicking this will activate the tracking feature.  Shift + left click will toggle the location on/off without tracking and right click will bring up a menu.  New quests are automatically added to your watch list.

   Guide:  Left click any guide icon will display icons for the selection and track to the closest one.  Shift + left click will turn the icons on/off without tracking.  Many categories have subcategories that are selected by left clicking on the name of the item.  Click the back button at the top of the list to go back.

   Warehouse:  Log each of your characters and open the bank to capture the items in the bank.  Select "All characters" to make the item list show all items.
]],
[[
There are dozens of settings you can configure and lots of ways to use Carbonite, but you really can ignore most of that stuff initially.

I would:

1 Read the help window that opens when you first sign in. Right click the Carbonite minimap button and select "Help" to see it again.

2 Drag the Carbonite map window (using the title bar) to the top right of the screen leaving a little room on the right edge.

3 Size the map window by dragging the edges.

4 Drag the Quest Watch List (title bar) to a nice spot under the map.

5 Drag the little window under (around) the Carbonite minimap button icon, so the icons start at the very top right of the screen.

6 Right click the Carbonite minimap button and select "Show Info 1 2" to get the HUD for you and your target. Select again if you don't like it to hide them.

When you start questing, you would click the purple "Auto Track" button at the top of the Quest Watch List or click a grey button on a specific quest objective to get the HUD arrow to start tracking it. Follow the arrow.
]],
[[
|cffffffffWotLK Expansion:|r

When you head over to Northrend you have a choice of two starting zones - Borean Tundra & Howling Fjord.  If you take a look on the map you'll see Borean Tundra is on the southwest and Howling Fjord is on the southeast.  Both zones have quests in the 68-72 range and if you're like us you'll want to clear both zones before moving on.

Zoom in the map to the point where the POI icons turn on and you'll see we have all the flight masters.  This is a great way of ensuring you don't miss any flight paths and to locate major quest hubs.  You can also turn on quest givers in the guide to locate the various quest hubs.

Both starting areas are populated with the various profession trainers and these are also in the guide.

If you wish to travel between Borean Tundra and Howling Fjord there are two boats (turtles actually) that shuttle back and forth between neutral camps in each zone and Dragonblight.  These can easily be located by zooming in to turn on the POI icons and looking for the icons with water & bubbles.

There is a neutral city called Dalaran that will eventually become your home base.  It has portals to all the major cities and Shatrath.  You can't actually get into Dalaran (that we are aware of) until you reach level 74, upon which you pick up a quest that teleports you there.  It may be possible for mages/warlocks to port you there at a lower level but until then, when you need to go back to the "old world" to train you're stuck using the boat/zeppelin.

For Alliance there is a boat to Borean Tundra from Stormwind and a boat to Howling Fjord from Menethil Harbor.

For Horde there is a zeppelin to Borean Tundra outside of Orgrimmar and a zeppelin to Howling Fjord outside of Undercity.

Happy adventuring!
]],
[[
|cffffffffKeyboard modifiers|r

Map:

 Shift down - Makes player arrow small. Draws BG objectives on top
 Shift left click - Pings Minimap if near player
 Ctrl left click - Sets goto
 Shift Ctrl left click - Adds goto
 Alt down - Shows player icon names and makes icons draw on top
 Alt right click - Map shows current zone

Minimap (in Carbonite map):

 Shift click - Pings
 Ctrl down - Makes integrated Minimap draw on top or bottom if already on top
 Alt down - Makes docked transparency 50%

List:

 Shift down - Makes mouse wheel scroll 5 times faster
 Shift + ctrl down - Makes mouse wheel scroll 100 times faster

Quest Watch:

 Alt left click button - Send quest status to party or whisper

Key Bindings you can set:

 Toggle Original Map
 Toggle Normal or Max Map
 Toggle None or Max Map
 Toggle None or Normal Map
 Restore Saved Map Scale
 Toggle Full Size Minimap
 Toggle Favorites
 Toggle Guide
 Toggle Warehouse
 Toggle Watch List Minimize
]],
[[
|cffffffffMap Icons|r

 Round solid icons are players:

  Yellow - friend
  Green - guild
  Blue - party
  Grey - non of the above

  Top Horizontal Bar - player health
  Mid Horizontal Bar - friendly target health
  Left Vertical Bar - enemy health (red glow if a player)
  x in center - in combat
  red in center - health low
  black in center - dead

 Round icons with black centers are for quests:

  White - quest ender if quest is simply to get to the end location

  By default there are 12 quest colors. Each quest starting at the top of the quest log has a different color. Once the 12 colors are used it repeats.

  Red - first quest in quest log
  Green - second quest in quest log
  Blue - third quest in quest log
  Yellow - forth quest and so on

  If "Use one color per quest" is off then
   Red - objective 1 or 4
   Green - objective 2 or 5
   Blue - objective 3 or 6

 Yellow ! - quest starter when you add a goto quest giver
 Yellow ? - quest ender

 Square icons with 4 black arrows are the closest point to reach a quest area:

  White color - is being tracked
  Non white colors match the same quest colors as described above.
]],
[[
|cffffffffChanges: 5.041|r

  Added map handling of new starting zones.
  Increased max quest level to 90.

  Fixed Dun Morogh and Twilight Highlands map overlays.
  Fixed GetNumRaidMembers/GetNumPartyMembers error.
  Fixed GetPOITextureCoords error.
  Fixed RangedSlot removal.
  Fixed getting quests from server error.
]],
[[
|cffffffffChanges: 4.301|r

  Fixed warning that version is old.
]],
[[
|cffffffffChanges: 4.3|r

  Added End Time, Well of Eternity, Hour of Twilight and Dragon Soul instance maps.

  Fixed map error from patch 4.3.
  Fixed distorted minimap graphics if node glow on.
]],
[[
|cffffffffChanges: 4.22|r

  Updated quest database. 189 quests missing data now have some.
  Added <category> after quest names in giver tooltip and database list if quest has a category.
  Updated TomTom emulation to work with latest Routes version.
  Allow "Quest Giver x Levels To Show" sliders to go to 85.
  Added "Show Lowest Equipped Rarity" slider to menu of Warehouse all item list. Default 7 will show just heirloom items.

  Fixed quest end location being replaced by Blizzard quest data if objective missing data.
  Fixed error if "Show Auction Buyout Per Item" on and button not found.
  Fixed error when making a route if quest module disabled.
  Fixed Molten Front map's minimap scale, switching to detail view and selecting when not in zone.
]],
[[
|cffffffffChanges: 4.21|r

  Updated quest database. 147 quests were added.

  Added Molten Front zone map and Firelands instance maps.
  Added Baradin Hold, Onyxia's Lair, Ruins of Ahn'Qiraj, Throne of the Four Winds, Vault of Archavon instance maps.
  Added Zul'Aman and Zul'Gurub instance maps and fixed dungeon info.
  Fixed Azjol-Nerub, Gundrak and Halls of Reflection instance maps.

  Added visited vendor detection of valor item cost.
  Fixed visited vendor not being recorded if they have an item without a link.
  Fixed visited vendor showing wrong item if different id, but same name.
]],
[[
|cffffffffChanges: 4.2|r

  Fixed combat message parsing error from patch 4.2.
]],
[[
|cffffffffChanges: 4.11|r

  Updated quest database. 352 quests were added.

  Added innkeepers and mailboxes for Kalimdor, Eastern Kingdoms and Deepholm to Guide.
  Added some missing flight masters.
  Added "Show Mailboxes" to map "Show..." menu, so they can be hidden.

  Added zone connection Loch Modan to Searing Gorge.
  Fixed zone connections Badlands to Searing Gorge and Uldum.

  Fixed player location being zero in instances.
  Added instance map switching when player location changes between map levels.

  Made digsite icons draw above artifact icons.
  Made digsite icons not hide while zoomed into map when "Show Artifact Locations" is on.

  Added Info Window Tol Barad wait time after Wintergrasp time.
  Fixed Info Window error when showing Wintergrasp wait time.

  Added check for active tracking spell before changing minimap dots.
  Multipled delay of "Minimap herb/ore dot glow delay (0 is off)" x4, so flicker is less annoying. Appears to be a game bug. Set to 0 or 999 if you can't stand flicker.

  Added ignoring of riding skill for routing while Alt key is down.
]],
[[
|cffffffffChanges: 4.1|r

  Fixed map tile error.
  Fixed combat message parsing error.
  Fixed addon message channel.
  Fixed Blackwing Descent instance location on map and added instance maps. This should fix map error.
  Fixed The Bastion of Twilight instance location on map and added instance maps.
  Fixed new minimap icons missing from node glow graphics.
  Fixed Russian map name.
  Removed FindClose debug message.
]],
[[
|cffffffffChanges: 4.034|r

  Updated quest database. About 100 quests were added.
  Added these tracking options to the "Tracking HUD" options page so they can be disabled.
    "Pals in battlegrounds"
    "Taxi destination"
    "Your corpse"

  Fixed German mining node names.
  Fixed format of Flight Master location data, which stopped the taxi destination being tracked.
]],
[[
|cffffffffChanges: 4.033|r

  Added Archaeology, Riding and Flying Trainers to Guide.
  Updated many Guide locations. (Inkeepers, mailboxes and stable masters not yet updated)

  Added "Show Artifact Locations" to map Show menu. Saved per character.
  Added 7000 herb, 5000 mining, 2100 artifact and 36 gas nodes to Carbonite Nodes.
  Added "Delete Misc (artifacts, gas) gather locations" to Guide options page.
  Added "Import Carbonite Nodes Misc (artifacts, gas) locations" to Guide options page.
  Removed old Cartographer node import.

  Fixed not using location of quest DB objective if no quest ender.
  Fixed tooltip losing added quest info when mousing over repeatedly.
  Fixed recording of artifact locations on non English clients.
]],
[[
|cffffffffChanges: 4.032|r

  Added new quest database.
  Updated CarboniteItems data.

  Added support for new herb and mining nodes.
  Added gathering of Archeology nodes. Display using Gather section of Guide.
  Added support for Blackrock Caverns, The Stonecore, Throne of the Tides, The Vortex Pinnacle, Grim Batol, Halls of Origination, Lost City of the Tol'vir and Throne of the Four Winds instances.
  Added Deepholm map detail graphics.
  Added Tol Barad maps and detail graphics.
  Added The Battle for Gilneas and Twin Peaks BG maps.
  Added missing Alliance achievements for "Show questing achievement for zone".
  Made self complete quests appear at top of Watch List.
  Improved map selection of instances. Quest givers show in first level of instance.
  Added "(Complete)" after name above Tracking Arrow if quest is complete.
  Added "New:" before quest name in Watch List for 60 seconds after accepted.

  Fixed display of Zygor minimap markers.
  Fixed self complete quests not showing ? button if it was tracked.
  Fixed bad speed display in instances by clearing it.
  Fixed map position in Orgrimmar when in Cleft of Shadows.
  Fixed tracking inside of instances zooming out and reaching destination early.
  Fixed auto accept quests not being watched.
  Fixed Warehouse tooltip info not counting equipped items.
  Fixed some zone and instance level ranges and instance entry locations.
]],
[[
|cffffffffChanges: 4.031|r

  Added routing check for Flight Master's License.
  Reset recorded flight times and known Flight Masters (talk to one to scan them).
  Reset current gather locations (import herbs and ore from CarboniteNodes again).
  Deleted Kalimdor and Eastern Kingdoms nodes from CarboniteNodes.
  Removed HonorGain chat message.
  Added "Auto accept quests (shift+ctrl inverts)" option.
  Added support for self complete quests to Watch List.
  Added "Auto trigger self completion quests" option.
  Disabled "Auto remove watched quests when completed" option for self complete quests.
  Improved quest tooltip info to merge with Blizzard's quest info if present.
  Added new achievements to "Show questing achievement for zone".
  Added new instance maps for Kalimdor and Eastern Kingdoms.
  Added /carb gotoadd command.
  Added .1 degree display of tiny angles when "Show direction text" tracking arrow option is on.
  Added moving of minimap instance difficulty button into button window.

  Fixed map for Cataclysm.
  Fixed Flight Masters, Auctioneers, Bankers, Travel locations for Cataclysm.
  Fixed routing choosing connections instead of Flight Master in certain cases.
  Fixed error from missing name in combat event.
  Fixed battleground map locations for Cataclysm. Middle click map to reset position when inside BGs.
]],
[[
|cffffffffChanges: 4.013|r

  Added "Questing" to Modules page of Options window. Disables Quest and Watch List windows and database.
  Added Russian data to Localization.lua.
  Compressed Event window data and improved cleanup process.
  Stopped the map kill and death icons from scaling.
  Added "Ignore mouse on map except when Alt key pressed" map option and improved maximized mouse ignore option.
  Changed minimap transparency key modifier. Ctrl key makes 80%. Ctrl+Alt makes 100%.

  Fixed helper for "Troll Patrol: The Alchemist's Apprentice" quest.
  Fixed quests being auto watched on login.
  Fixed long decimal being shown on bonus honor in battle ground message.
  Fixed amount of honor gained from players and objectives in Event window.
  Fixed session honor not showing in Warehouse.
  Fixed FPS drop when tracking achievements and a quest updates.
  Fixed excess garbage generation in Quest Watch update.
]],
[[
|cffffffffChanges: 4.012|r

  Added "Delete settings of a character" to Reset page of Options window.

  Fixed dragging of Carbonite minimap button when around minimap.
  Fixed FPS drop when tracking achievements and Quest Watch List item buttons shown.
  Fixed minimum mining skill for Thorium, Fel Iron and Nethercite in Guide.
  Fixed drawing of map battleground objectives above player icons not happening when shift key is down.
  Fixed window position if off the right side of screen.
]],
[[
|cffffffffChanges: 4.011|r

  Fixed an error displaying minimap buttons if a button is missing.

4.01
  Added "Show 'Clock' minimap button" on Map Minimap Options page.
  Fixed routing riding skill check.

4.0006
  Fixed missing map detail graphics.

4.0005
  Fixed German and French map name localization.

4.0004
  Fixed error if quest objective description missing in quest change check and quest list.
  Fixed quest complete sound.
  Fixed minimap icons when herb/ore dot glow is enabled.

4.0003
  Fixed error if quest objective description missing for tooltip scanner.

4.0002
  Fixed vender scan error.
  Fixed error opening Social window if chat tab selected.
  Fixed error if objective description missing in Watch List.

4.0001
  Version for WoW 4.0.1 patch.
]],
	}
--PAIDE!


	self.FStr:SetText (str[page])
end

-------------------------------------------------------------------------------
-- Demo

function Nx.Help.Demo:Create()

	if self.NXFrm then		-- Created?
		self.NXFrm:Show()
		return
	end

	local f = CreateFrame ("Frame", "NxDemo", UIParent)
	f.NxInst = self
	self.NXFrm = f

	tinsert (UISpecialFrames, f:GetName())

	f:SetFrameStrata ("DIALOG")

	f:SetWidth (400)
	f:SetHeight (100)

	local t = f:CreateTexture()
	t:SetTexture (.05, .05, .05, .95)
	t:SetAllPoints (f)
	f.texture = t

	local fstr = f:CreateFontString()
	fstr:SetFontObject ("GameFontNormalSmall")
	fstr:SetJustifyH ("CENTER")
	fstr:SetJustifyV ("TOP")
	fstr:SetPoint ("TOPLEFT", 0, -3)
	fstr:SetWidth (400)
	fstr:SetHeight (100)
	fstr:SetText (L["CARBONITE demo. Press escape key to cancel"])

	for n = 1, 1 do
		local fstr = f:CreateFontString()
		self["NXFStr"..n] = fstr
		fstr:SetFontObject ("GameFontNormal")
		fstr:SetJustifyH ("CENTER")
		fstr:SetJustifyV ("CENTER")
		fstr:SetPoint ("TOPLEFT", 0, 0)
		fstr:SetWidth (400)
		fstr:SetHeight (100)
--		fstr:Show()
	end

--	self.NXFStr1:SetText (format ("TEST!!!"))
--[[
	local f = CreateFrame ("Frame", nil, UIParent)
	self.NXFrmGlow = f

	f:SetFrameStrata ("DIALOG")

	f:SetWidth (100)
	f:SetHeight (100)

	local t = f:CreateTexture()
	t:SetTexture (.3, .3, .3, 1)
	t:SetAllPoints (f)
	f.texture = t
--]]
end

function Nx.Help.Demo:StartOnce()

	local opts = Nx:GetGlobalOpts()
	if not opts["DemoShown"] then
		opts["DemoShown"] = true
		Nx.Help.Demo:Start (true)
	end
end

function Nx.Help.Demo:Start (quick)

	self:Create()

	self.X = 0
	self.Y = 0
	self.NXXV = 0
	self.NXYV = 0
	self.Scale = 1
	self.ScaleTarget = 1
	self.Alpha = 0
	self.NXAlphaTarget = 1

	local cmds = {
		"Text^NXFStr1^Demo starting...",
		"^240",
		"Text^NXFStr1^The CARBONITE minimap icon can be clicked",
		"^240",
		"Text^NXFStr1^Left click to toggle map\nRight click for menu",
		"^240",
		"Text^NXFStr1^The menu can be used to open the help window",
		"^240",
		"Func^NXOpenHelp",
		"Text^NXFStr1^Read the help to learn the basic features\n\nThe End",
		"^240",
		"Set^NXAlphaTarget^0",
		"Set^NXYV^-2",
		"^240",
--		"Prt^Demo End",
--		"Restart",
	}

--	quick = 1

	if quick then
		cmds = {
			"Func^NXOpenHelp",
		}
	end

	self.Script = Nx.Script:New (self, cmds)

	Nx.Proc:New (self, self.Tick, 1)
end

function Nx.Help.Demo:NXOpenHelp()
	Nx.Help:Open()
end

function Nx.Help.Demo:Tick()

	local f = self.NXFrm

	local ret = Nx.Script:Tick (self.Script)

	if ret or not f:IsShown() then
--		Nx.prt ("Demo End")
		f:Hide()
		return -1
	end

	self.X = self.X + self.NXXV
	self.Y = self.Y + self.NXYV

	self.Scale = Nx.Util_StepValue (self.Scale, self.ScaleTarget, .8 / 60)

	f:SetPoint ("CENTER", self.X / self.Scale, self.Y / self.Scale)
	f:SetScale (self.Scale)

	self.Alpha = Nx.Util_StepValue (self.Alpha, self.NXAlphaTarget, .8 / 120)
	f:SetAlpha (self.Alpha)

end

-------------------------------------------------------------------------------

function Nx.Script:New (data, cmds)

	local script = {}
	script.Data = data
	script.Cmds = cmds
	script.Pos = 1
	script.Delay = 0

	return script
end

function Nx.Script:Tick (script)

	script.Delay = script.Delay - 1

	if script.Delay > 0 then
		return
	end

	local pos = script.Pos
	local cmd = script.Cmds[pos]

	while cmd do

		pos = pos + 1

		local name, a1, a2, a3 = strsplit ("^", cmd)

		if name == "" then	-- Wait
			script.Delay = tonumber (a1)
			break

		elseif name == "Restart" then
			pos = 1

		elseif name == "Show" then
			script.Data[a1]:Show()

		elseif name == "Hide" then
			script.Data[a1]:Hide()

		elseif name == "Text" then
			script.Data[a1]:SetText (_TRANS(a2))

		elseif name == "Func" then
			script.Data[a1] (script.Data, a2, a3)

		elseif name == "Set" then
			script.Data[a1] = tonumber (a2)

		elseif name == "PosAt" then

		elseif name == "Prt" then
			Nx.prt (a1)
		end

		cmd = script.Cmds[pos]
	end

	if not cmd then
		return true		-- Done
	end

	script.Pos = pos
end

-------------------------------------------------------------------------------

function Nx.Proc:Init()

	self.Procs = {}
	self.TimeLeft = 0
end

function Nx.Proc:New (user, func, delay)

	local p = {}
	tinsert (self.Procs, p)
	p.User = user
	p.Func = func
	p.Delay = delay or 1
end

function Nx.Proc:SetFunc (proc, func)
	proc.Func = func
end

function Nx.Proc:OnUpdate (elapsed)

--	Nx.prt ("Proc Elapsed raw %s", elapsed)

	elapsed = min (elapsed, .2) * 60

--	Nx.prt ("Proc Elapsed %s", elapsed)

	elapsed = elapsed + self.TimeLeft

	while elapsed >= 1 do

		elapsed = elapsed - 1

		local n = 1

		while 1 do
			local p = self.Procs[n]
			if not p then
				break
			end

			local d = p.Delay - 1
			if d <= 0 then
				d = p.Func (p.User, p) or 1

				if d < 0 then						-- No time?
					tremove (self.Procs, n)		-- Kill proc
					n = n - 1						-- Same index again
				end
			end
			p.Delay = d

			n = n + 1
		end

	end

	self.TimeLeft = elapsed
end

-------------------------------------------------------------------------------
-- License display

function Nx.Help.License:ShowOnce()

--[[
	local opts = Nx:GetGlobalOpts()

-- Test
--	opts["LicenseAccept" .. Nx.VERSION] = nil

	if not opts["LicenseAccept" .. Nx.VERSION] and not Nx.Free then
		self:Create()
	else
		Nx.Sec:Start()
	end
--]]

	Nx.Sec:Start()
end

--------
-- Create license window

function Nx.Help.License:Create()

	self.Top = 0

	-- Create Window

	Nx.Window:ClrSaveData ("NxLic")

	local win = Nx.Window:Create ("NxLic", nil, nil, nil, 1, false)
	self.Win = win
	local frm = win.Frm

--	win:CreateButtons (true, true)
	win:InitLayoutData (nil, -.3, -.15, -.4, -.6, 3)

	frm:SetToplevel (true)

	win:SetTitle (Nx.TXTBLUE.."CARBONITE " .. Nx.VERSION)

	win:SetBGColor (.1, .1, .1, 0)
--	win:Lock (true)

	local bk = {
		["bgFile"] = "Interface\\Buttons\\White8x8",
		["edgeFile"] = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
		["tile"] = true,
		["tileSize"] = 16,
		["edgeSize"] = 16,
		["insets"] = { ["left"] = 2, ["right"] = 2, ["top"] = 2, ["bottom"] = 2 }
	}

--	frm.texture = nil
	frm:SetBackdrop (bk)
	frm:SetBackdropColor (.1, .1, .1, 1)

	-- Scroll Frame

	local scf = CreateFrame ("ScrollFrame", nil, UIParent)
	self.ScFrm = scf

	scf.NxInst = self
	scf.NxSetSize = self.OnSetSize

	scf:SetScript ("OnMouseWheel", self.OnMouseWheel)
	scf:EnableMouseWheel (true)

	-- Text

	local f = CreateFrame ("Frame", nil, UIParent)
	self.Frm = f

	f:SetPoint ("TOPLEFT", 0, 0)
	f:SetWidth (1)
	f:SetHeight (1)

	local fstr = f:CreateFontString()
	self.FStr = fstr
	fstr:SetFontObject ("GameFontNormal")
	fstr:SetJustifyH ("LEFT")
	fstr:SetPoint ("TOPLEFT", 0, 0)

	f.NxSetSize = self.OnSetSize

	scf:SetScrollChild (f)

	self:SetText (1)

	-- Buttons

	local buta = Nx.Button:Create (f, "Txt64", L["Accept"], nil, x, 0, "TOPLEFT", 64, 20, self.OnButAccept, self)
	buta.Frm:SetPoint ("TOPLEFT", self.FStr, "BOTTOMLEFT", 10, 0)

	local butd = Nx.Button:Create (f, "Txt64", L["Decline"], nil, x, 0, "TOPLEFT", 64, 20, self.OnButDecline, self)
	butd.Frm:SetPoint ("TOPLEFT", buta.Frm, "TOPRIGHT", 10, 0)

	-- Attach at end or crash

	win:Attach (scf, 0, 1, 0, 1)

	-- Slider

	self.Slider = Nx.Slider:Create (scf, "V", 10, 0)
	self.Slider:SetUser (self, self.OnSlider)

	self.Slider:Set (0, 0, 1700, 100)
	self.Slider:Update()

end

function Nx.Help.License:OnSetSize (w, h)

--	Nx.prt ("Lic SetSize %s %s", w, h)

	local self = Nx.Help.License

--	Nx.prt ("Lic top %s", self.Top)

	self.Frm:SetPoint ("TOPLEFT", 0, self.Top)
	self.FStr:SetWidth (w - 20)
end

function Nx.Help.License:OnMouseWheel (value)

--	Nx.prt ("Lic MouseWheel "..tostring (value))

	value = value * 30

	if IsShiftKeyDown() then
		value = value * 5
	end

	local self = this.NxInst
	self.Top = max (self.Top - value, 0)

	self.Frm:SetPoint ("TOPLEFT", 0, self.Top)
	self.Slider:Set (self.Top)
	self.Slider:Update()
end

function Nx.Help.License:OnSlider (slider, pos)

	self.Top = floor (pos)
	self.Frm:SetPoint ("TOPLEFT", 0, self.Top)
end

--------
-- Accepted

function Nx.Help.License:OnButAccept()

	self.Win:Show (false)

	local opts = Nx:GetGlobalOpts()
	opts["LicenseAccept" .. Nx.VERSION] = true

	Nx.Sec:Start()
end

--------
-- Declined

function Nx.Help.License:OnButDecline()

	self.Frm:Hide()
	Nx:ShowMessage (L["|cffff4f4fYou have declined the license agreement:\n\n|rPress the Escape key twice.\nSelect 'Exit Game'.\nDelete your copy of CARBONITE from the AddOns folder."], L["OK"], Nx.Help.License.OnCancel, nil, Nx.Help.License.OnCancel)
end

function Nx.Help.License:OnCancel()
	Nx.Help.License.Frm:Show()
end

function Nx.Help.License:SetText()

	local str =
[[
Copyright 2007-2012 Carbon Based Creations, LLC

LICENSE AGREEMENT

Click a button below to "Accept" or "Decline".
]]

	self.FStr:SetText (str)
end


-------------------------------------------------------------------------------
-- EOF

















