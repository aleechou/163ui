local L = Carbonite_Strings
local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxMapGuide - Map guide code
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
-- Tables

Nx.GuideAbr = {
	["K"] = "Kalimdor",
	["E"] = "Eastern Kingdoms",
	["O"] = "Outlands",
	["N"] = "Northrend",
	["M"] = "The Maelstrom",
	["P"] = "Pandaria",
}
Nx.GuideInfo = {
	Name = "All",
	Tx = "INV_Misc_Map02",
	{
		Name = "Quest Givers",
		T = "&",
		Tx = "INV_Misc_Note_02",
		Persist = "QMapShowQuestGivers3",
	},
	{
		T = "Stable Master",
		Tx = "Ability_Hunter_BeastTaming",
	},
	{
		T = "Flight Master",
		Tx = "Ability_Mount_Wyvern_01",
	},
	{
		Name = "Common Place",
		Tx = "INV_Misc_Map02",
		{
			T = "Auctioneer",
			Tx = "Racial_Dwarf_FindTreasure",
		},
		{
			T = "Banker",
			Tx = "INV_Misc_Coin_02",
		},
		{
			T = "Innkeeper",
			Tx = "Spell_Shadow_Twilight",
		},
		{
			T = "Arcane Reforger",
			Tx = "INV_Sword_67",
		},
        {
			T = "Void Storage",
			Tx = "spell_nature_astralrecalgroup",
		},
		{
			T = "Transmogrifier",
			Tx = "INV_Arcane_Orb",
		},
		{
			T = "Battle Pet Trainer",
			Tx = "INV_Pet_BattlePetTraining",
		},
		{
			T = "Barber",
			Tx = "INV_Misc_Comb_02",
		},
        {
			T = "Mailbox",
			Tx = "INV_Letter_15",
		},
		{
			T = "Anvil",
			Tx = "Trade_BlackSmithing",
		},
		{
			T = "Forge",
			Tx = "INV_Sword_09",
		},
	},
	
	{
		Name = "Class Trainer",
		T = "^C",
		Tx = "INV_Misc_Book_10",
		{
			T = "Death Knight Trainer",
			Tx = "Spell_Deathknight_ClassIcon",
		},
		{
			T = "Druid Trainer",
			Tx = "Ability_Druid_Maul",
		},
		{
			T = "Hunter Trainer",
			Tx = "INV_Weapon_Bow_07",
		},
		{
			T = "Mage Trainer",
			Tx = "INV_Staff_13",
		},
		{
			T = "Paladin Trainer",
			Tx = "INV_Hammer_01",
		},
		{
			T = "Priest Trainer",
			Tx = "INV_Staff_30",
		},
		{
			T = "Rogue Trainer",
			Tx = "INV_ThrowingKnife_04",
		},
		{
			T = "Shaman Trainer",
			Tx = "Spell_Nature_BloodLust",
		},
		{
			T = "Warlock Trainer",
			Tx = "Spell_Nature_FaerieFire",
		},
		{
			T = "Warrior Trainer",
			Tx = "INV_Sword_27",
		},
		{
			T = "Monk Trainer",
			Tx = "Class_Monk", 
		},
	},	
	{
		Name = "Trainer",
		T = "^C",
		Tx = "INV_Misc_Book_01",
		
		{
			Pre = "Alchemy",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Alchemy",
		},
		{
			Pre = "Archaeology",
			Name = "Trainer",
			T = "^P",
			Tx = "trade_archaeology",
		},
		{
			Pre = "Blacksmithing",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_BlackSmithing",
		},
		{
			Pre = "Enchanting",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Engraving",
		},
		{
			Pre = "Engineering",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Engineering",
		},
		{
			Pre = "Herbalism",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Herbalism",
		},
		{
			Pre = "Inscription",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Inscription_Tradeskill01",
		},
		{
			Pre = "Jewelcrafting",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Misc_Gem_02",
		},
		{
			Pre = "Leatherworking",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Misc_ArmorKit_17",
		},
		{
			Pre = "Mining",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Mining",
		},
		{
			Pre = "Skinning",
			Name = "Trainer",
			T = "^P",
			Tx = "INV_Misc_Pelt_Wolf_01",
		},
		{
			Pre = "Tailoring",
			Name = "Trainer",
			T = "^P",
			Tx = "Trade_Tailoring",
		},
		{
			Pre = "Cooking",
			Name = "Trainer",
			T = "^S",
			Tx = "INV_Misc_Food_15",
		},
		{
			Pre = "First Aid",
			Name = "Trainer",
			T = "^S",
			Tx = "Spell_Holy_SealOfSacrifice",
		},
		{
			Pre = "Fishing",
			Name = "Trainer",
			T = "^S",
			Tx = "Trade_Fishing",
		},
		{
			Pre = "Flying",
			Name = "Trainer",
			T = "^S",
			Tx = "inv_scroll_11",
		},
		{
			Pre = "Riding",
			Name = "Trainer",
			T = "^S",
			Tx = "spell_nature_swiftness",
		},
	},
	{
		Name = "Travel",
		Tx = "Ability_Townwatch",
	},
	
	{
		Name = "Visited Vendor",
		Tx = "INV_Misc_Coin_05",
		{
			Name = "All Items",
			NoShowChild = true,
		},
	},
	{
		Name = "Gather",
		Tx = "INV_Misc_Bag_10",
		{
			Name = "Herb",
			Tx = "INV_Misc_Flower_02",
			Persist = "MapShowGatherH",
		},
		{
			Name = "Ore",
			Tx = "INV_Ore_Copper_01",
			Persist = "MapShowGatherM",
		},
		{
			Name = "Artifacts",
			T = "$ A",
			Id = "Art",
			Tx = "Trade_Archaeology",
			Persist = "MapShowGatherA",
		},
		{
			Name = NXlEverfrost,
			T = "$ E",
			Id = "Everfrost",
			Tx = "spell_shadow_teleport",
		},
		{
			Name = NXlGas,
			T = "$ G",
			Id = "Gas",
			Tx = "inv_gizmo_zapthrottlegascollector",
		},
	},
	{
		Name = "Instances",
		Tx = "INV_Misc_ShadowEgg",
		{
			Name = "@K",
			Inst = 1
		},
		{
			Name = "@E",
			Inst = 2
		},
		{
			Name = "@O",
			Inst = 3
		},
		{
			Name = "@N",
			Inst = 4
		},
		{
			Name = "@M",
			Inst = 5
		},
		{
			Name = "@P",
			Inst = 6
		},
	},
	{
		Name = "Zone",
		Tx = "INV_Misc_Map_01",
		{
			Name = "All",
			Map = 0
		},
		{
			Name = "@K",
			Map = 1
		},
		{
			Name = "@E",
			Map = 2
		},
		{
			Name = "@O",
			Map = 3
		},
		{
			Name = "@N",
			Map = 4
		},
		{
			Name = "@M",
			Map = 5
		},
		{
			Name = "@P",
			Map = 6
		},
	},
	{
		Name = "Trade Skill",
		Tx = "INV_Misc_Note_04",
		{
			T = "Alchemy Lab",
			Tx = "INV_Potion_06",
		},
		{
			T = "Altar Of Shadows",
			Tx = "INV_Fabric_Felcloth_Ebon",
		},
		{
			T = "Mana Loom",
			Tx = "INV_Fabric_Netherweave_Bolt_Imbued",
		},
		{
			T = "Moonwell",
			Tx = "INV_Fabric_MoonRag_Primal",
		},
	},	
	
}
function Nx.Map.Guide:Create (map)
	self:PatchData()
	local g = {}
	setmetatable (g, self)
	self.__index = self
	g.Map = map
	g.GuideIndex = map.MapIndex
	local opts = NxMapOpts.NXMaps[g.GuideIndex]
	g.TitleH = 0
	g.ToolBarW = 0
	g.PadX = 0
	
	g:PatchFolder (Nx.GuideInfo, nil)
	g.PathHistory = {}
	g.PathHistory[1] = Nx.GuideInfo
	g.PathHistorySel = {}	
	g.ShowFolders = {}
	g.ShowQuestGiverCompleted = true			
	
	local win = Nx.Window:Create ("NxGuide" .. g.GuideIndex, nil, nil, nil, 1)
	g.Win = win
	win.Frm.NxInst = g
	win:SetUser (g, g.OnWin)
	win:RegisterHide()
	win:CreateButtons (true)
	win:SetTitleLineH (18)
	win:SetTitleXOff (50)
	win:InitLayoutData (nil, -.15, -.2, -.63, -.5)
	win.Frm:SetToplevel (true)
	win:Show (false)
	tinsert (UISpecialFrames, win.Frm:GetName())
	
	local but = Nx.Button:Create (win.Frm, "Txt64", L["Back "], nil, 0, 0, "TOPLEFT", 100, 24, self.But_OnBack, g)
	win:Attach (but.Frm, 1.01, 1.01+44, -10020, -10001)
	
	Nx.List:SetCreateFont ("FontM", 28)
	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm)
	g.List = list
	list:SetUser (g, g.OnListEvent)
	list:SetLineHeight (16, 3)
	list:ColumnAdd ("", 1, 35)
	list:ColumnAdd ("", 2, 900)
	win:Attach (list.Frm, 0, .33, 0, 1)
	g:CreateMenu()
	
	Nx.List:SetCreateFont ("FontM", 28)
	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm)
	g.List2 = list
	list:SetUser (g, g.OnList2Event)
	list:SetLineHeight (16, 11)
	list:ColumnAdd ("", 1, 35)
	list:ColumnAdd (L["Name"], 2, 220)
	list:ColumnAdd (L["Info"], 3, 80)
	list:ColumnAdd (L["Info2"], 4, 150)
	list:ColumnAdd (L["Info3"], 5, 230)
	win:Attach (list.Frm, .33, 1, 18, 1)
	
	g.EditBox = Nx.EditBox:Create (win.Frm, g, g.OnEditBox, 30)
	win:Attach (g.EditBox.Frm, .33, 1, 0, 18)
	
	g:ClearShowFolders()		
	g:UpdateVisitedVendors()
	g:Update()
	map:InitIconType ("!POI", "WP", "", 1, 1)		
	map:InitIconType ("!POIIn", "WP", "", 1, 1)	
	
	return g
end
function Nx.Map.Guide:PatchData()
	
	Nx.GuideData = Nx["GuideData"] or Nx.GuideData	
	Nx.NPCData = Nx["NPCData"] or Nx.NPCData			
	
	local data = Nx.GuideData
	local npc = Nx.NPCData
	local fix =	{
	  }
	local typ
	local n = 1
	while fix[n] do
		if type (fix[n]) == "string" then
			typ = fix[n]
			n = n + 1
		else
			local x = fix[n + 3] * 100
			local y = fix[n + 4] * 100
			local xs = strchar (floor (x / 221) + 35, x % 221 + 35)
			local ys = strchar (floor (y / 221) + 35, y % 221 + 35)
			local cont = floor (fix[n + 2] / 1000)
			local zone = fix[n + 2] % 1000			
			if fix[n + 1] then	
			else
				local s = format ("%c%c%s%s", fix[n] + 35, zone + 35, xs, ys)
				data[typ][cont] = data[typ][cont] .. s
			end
			n = n + 5
		end
	end
	
end
function Nx.Map.Guide:CreateMenu()
	local menu = Nx.Menu:Create (self.List.Frm)
	self.Menu = menu
	self.MenuIDelete = menu:AddItem (0, L["Delete"], self.Menu_OnDelete, self)
	self.MenuIGotoQ = menu:AddItem (0, L["Add Goto Quest"], self.Menu_OnAddGotoQ, self)
	local item = menu:AddItem (0, L["Show On All Continents"], self.Menu_OnShowAllCont, self)
	item:SetChecked (true)
	self.ShowAllCont = true
	local function func (self, item)
		self.ShowQuestGiverCompleted = item:GetChecked()
		self:Update()
	end
	local item = menu:AddItem (0, L["Show Completed Quest Givers"], func, self)
	item:SetChecked (false)
	self.ShowQuestGiverCompleted = false
	local str = UnitFactionGroup ("player") == "Horde" and "Alliance" or "Horde"
	local item = menu:AddItem (0, L["Show "] .. str, self.Menu_OnShowEnemy, self)
	item:SetChecked (false)
	menu:AddItem (0, L["Clear Selection"], self.Menu_OnClearSel, self)
	local function func()
		Nx.Opts:Open ("Guide")
	end
	menu:AddItem (0, L["Options..."], func, self)
end
function Nx.Map.Guide:OpenMenu (item)
	self.MenuCurItem = item
	local canDel = false
	local canGotoQ = false
	if type (item) == "table" then
		if item.T then
			local mode = strbyte (item.T)
			if mode == 40 then		
				canDel = true
			end
		end
		if item.QId then
			canGotoQ = true
		end
	end
	self.MenuIDelete:Show (canDel)
	self.MenuIGotoQ:Show (canGotoQ)
	self.Menu:Open()
end
function Nx.Map.Guide:Menu_OnDelete()
	local item = self.MenuCurItem
	local mode = strbyte (item.T)
	if mode == 40 then		
		local npcName = strsub (item.T, 2)
		local vv = NxData.NXVendorV
		vv[npcName] = nil
	end
	self:UpdateVisitedVendors()
	local parent = Nx.GuideInfo
	for n = 2, #self.PathHistory do
		local i = max (min (self.PathHistorySel[n - 1], #parent), 1)
		self.PathHistory[n] = parent[i]
		parent = self.PathHistory[n]
	end
	self:ClearAll()
	self:SelectLists()
end
function Nx.Map.Guide:Menu_OnAddGotoQ()
	local item = self.MenuCurItem
	if item.QId then
		Nx.Quest:Goto (item.QId)
	end
end
function Nx.Map.Guide:Menu_OnShowAllCont (item)
	self.ShowAllCont = item:GetChecked()
	self:Update()
end
function Nx.Map.Guide:Menu_OnShowEnemy (item)
	self.ShowEnemy = item:GetChecked()
	self:ClearAll()
end
function Nx.Map.Guide:Menu_OnClearSel()
	self:ClearAll()
end
function Nx.Map.Guide:But_OnBack()
	self:Back()
end
function Nx:NXGuideKeyToggleShow()
	local map = Nx.Map:GetMap (1)
	map.Guide:ToggleShow()
end
function Nx.Map.Guide:ToggleShow()
end
function Nx.Map.Guide:ToggleShow_()
	self.Win:Show (not self.Win:IsShown())
end
function Nx.Map.Guide:OnWin (typ)
	if typ == "Hide" then
		
	end
end
function Nx.Map.Guide:OnListEvent (eventName, sel, val2, click)
	self:OnListEventDo (self.List, eventName, sel, val2, click)
end
function Nx.Map.Guide:OnList2Event (eventName, sel, val2, click)
	self:OnListEventDo (self.List2, eventName, sel, val2, click)
end
function Nx.Map.Guide:OnListEventDo (list, eventName, sel, val2, click)
	local typ = list:ItemGetData (sel) or 0
	local pathI = max (#self.PathHistory - 1, 1)
	if list == self.List2 then
		pathI = #self.PathHistory
	end
	if eventName == "select" or eventName == "mid" or eventName == "menu" then
		self.PathHistorySel[pathI] = sel
		local folder = self.PathHistory[pathI]
		local item = folder[typ]
		if eventName ~= "menu" or list == self.List then
			if type (item) == "table" then
				if item[1] or item.Item then						
					self.PathHistory[pathI + 1] = item			
					self.PathHistorySel[pathI + 1] = 1
					self:SelectLists()
				else
					if list == self.List then
						if #self.PathHistory == 2 then
							self:Back()
						end
					end
				end
			end
		end
		if type (item) == "number" then
			local id = item
			if IsControlKeyDown() then
				DressUpItemLink (format ("item:%d", id))
			else
				local name, link = GetItemInfo (id)
				SetItemRef (format ("item:%d", id), link)
			end
		else
			if IsControlKeyDown() then
				if item.Link then
					DressUpItemLink (item.Link)
				end
			end
		end
		self:Update()
		if eventName == "menu" then
			self:OpenMenu (item)
		end
	elseif eventName == "back" then
		self:Back()
	elseif eventName == "sort" then
		if list == self.List2 then
			list:ColumnSort (val2)
			self:Update()
		end
	elseif eventName == "button" then	
		local pressed = val2
		if typ > 0 then
			local map = self.Map
			local folder = self.PathHistory[pathI]
			if type (folder[typ]) == "table" then
				folder = folder[typ]
			end
			if folder.TrialMsg then
				Nx.ShowMessageTrial()
			end
			local single = not (IsShiftKeyDown() or click == "MiddleButton")
            
			if folder.MId and pressed then
				map:SetCurrentMap (folder.MId)
				map:CenterMap (folder.MId, 1)
				Nx.Quest.List:Update()
				single = true
			end
			if single then
				self:ClearShowFolders() 
				map:ClearTargets (not pressed and "Guide")
			elseif not pressed then
				local typ, id = map:GetTargetInfo()
				if id == folder then
					map:ClearTargets()
				end
			end
			
			if folder.Persist and not pressed then
				local v = Nx.CharOpts[folder.Persist]
				if v then 
					self:AddShowFolders (folder, not pressed)
				end
			else
				self:AddShowFolders (folder, not pressed)
			end
			self:Update()
			if single and pressed then
				local typ, filt = self:CalcType (folder)
				self.FindingClosest = typ 
				if typ then
					local npcI, mapId, x, y, npcI2, mapId2, x2, y2 = self:FindClosest (typ)
					if npcI then
						Nx.Quest.Watch:ClearAutoTarget()
						map:SetTarget ("Guide", x, y, x, y, false, folder, folder.Name, false, mapId) 
                        if false and npcI2 then
                            map:SetTarget("Guide2", x2, y2, x2, y2, false, folder, folder.Name, true ,mapId2) 
                        end
						map:GotoPlayer()
					end
				else
					PlaySound ("igPlayerInviteDecline")
				end
			end
		end
	end
end
function Nx.Map.Guide:Back()
	if #self.PathHistory > 1 then
		tremove (self.PathHistory)
	end
	self:Update()
	self:SelectLists()
end
function Nx.Map.Guide:SelectLists()
	local i = self.PathHistorySel[max (#self.PathHistory - 1, 1)]
	if i and i <= self.List:ItemGetNum() then
		self.List:Select (i)
	end
	self.List:Update()
	local i = self.PathHistorySel[#self.PathHistory]
	if i and i <= self.List2:ItemGetNum() then
		self.List2:Select (i)
	end
	self.List2:Update()
end
function Nx.Map.Guide:OnEditBox (editbox, message)
	if message == "Changed" then
		self:Update()
	end
end
function Nx.Map.Guide:PatchFolder (folder, parent)
	local trainer
	if folder.Name == "Trainer" and folder.Pre then
		trainer = true
	end
	if folder.Pre and folder.Name then
		folder.Name = folder.Pre .. folder.Name
		folder.Name = strtrim (gsub (folder.Name, "%u", " %1"), " ")	
	end
	if parent and parent.Pre and folder.T then
		folder.T = parent.Pre .. folder.T
	end
	if not folder.Name and folder.T then
		local name = strsplit ("^", folder.T)
		folder.Name = strtrim (gsub (name, "%u", " %1"), " ")
	end
	if folder.Name then
		folder.Name = gsub (folder.Name, L[" Trainer"], "")	
	end
	if not folder.Tx then
		folder.Tx = parent.Tx
	end
	if not trainer then
		for showType, child in ipairs (folder) do
			if type (child) == "table" then
				self:PatchFolder (child, folder)
			end
		end
	end
	if folder.Name == "Travel" then
		local txT = {
			["Boat"] = "Spell_Shadow_DemonBreath",
			["Portal"] = "INV_Misc_QuestionMark",
			["Tram"] = "INV_Misc_MissileSmall_White",
			["Zeppelin"] = "INV_Misc_MissileSmall_Red",
		}
		local portalT = {
			["Blasted Lands"] = "Spell_Arcane_TeleportStonard",
			["Darnassus"] = "Spell_Arcane_TeleportDarnassus",
            ["Teldrassil"] = "Spell_Arcane_TeleportDarnassus",
			["The Exodar"] = "Spell_Arcane_TeleportExodar",
			["Hellfire Peninsula"] = "Spell_Arcane_TeleportStonard",
			["Ironforge"] = "Spell_Arcane_TeleportIronForge",
			["Isle of Quel'Danas"] = "Achievement_Zone_IsleOfQuelDanas",
			["Lake Wintergrasp"] = "Ability_WIntergrasp_rank1",
			["Orgrimmar"] = "Spell_Arcane_TeleportOrgrimmar",
			["Shattrath"] = "Spell_Arcane_TeleportShattrath",
			["Silvermoon City"] = "Spell_Arcane_TeleportSilvermoon",
			["Stormwind City"] = "Spell_Arcane_TeleportStormWind",
			["Thunder Bluff"] = "Spell_Arcane_TeleportThunderBluff",
			["Undercity"] = "Spell_Arcane_TeleportUnderCity",
            ["Dalaran"] = "Spell_Arcane_TeleportDalaran",
            ["Shattrath City"] = "Spell_Arcane_TeleportShattrath",
            ["The Jade Forest"] = "Spell_Arcane_TeleportShattrath",
		}
		for i, str in ipairs (Nx.ZoneConnections) do
			local flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2 = Nx.Map:ConnectionUnpack (str)
			if conTime ~= 1 then
				local fac = bit.band (flags, 6) / 2
				local facStr = fac == 1 and "^FA" or fac == 2 and "^FH" or ""
				if #name1 > 0 then
					local f = {}
					tinsert (folder, f)
					f.Name = format ("%s", _Travel(name1))
					f.Fac = fac
					f.MapId = mapId1
					f.ConIndex = i
					f.T = "*" .. i .. facStr
					local typ, locName = strmatch (name1, "(%S+) to (.+)")
					f.Tx = typ == "Portal" and portalT[locName] or txT[typ]
				end
				if #name2 > 0 and bit.band (flags, 1) ~= 0 then
					local f = {}
					tinsert (folder, f)
					f.Name = format ("%s", _Travel(name2))
					f.Fac = fac
					f.MapId = mapId2
					f.ConIndex = i
					f.Con2 = true
					f.T = "*b" .. i .. facStr
					local typ, locName = strmatch (name2, "(%S+) to (.+)")
					f.Tx = typ == "Portal" and portalT[locName] or txT[typ]
				end
			end
		end
		sort (folder, function (a, b) return a.Name < b.Name end)
	elseif folder.Name == "Herb" then
		for n = 1, 499 do
			local name, tx, skill = Nx:GetGather ("H", n)
			if not name then
				break
			end
			local f = {}
			f.Name = name
			f.Column2 = format ("%3d", skill)
			f.T = "$H" .. n
			f.Tx = tx
			f.Id = n
			folder[n] = f
		end
	elseif folder.Name == "Ore" then
		for n = 1, 499 do
			local name, tx, skill = Nx:GetGather ("M", n)
			if not name then
				break
			end
			local f = {}
			f.Name = name
			f.Column2 = format ("%3d", skill)
			f.T = "$M" .. (n + 500)
			f.Tx = tx
			f.Id = n
			folder[n] = f
		end
	elseif folder.Map then		
		if folder.Map == 4 and not Nx.V30 then
			parent[5] = nil	
			return
		end
		local Map = Nx.Map
		local cont1 = folder.Map
		local cont2 = cont1
		if cont1 == 0 then
			cont1 = 1
			cont2 = Map.ContCnt
		end
		for cont = cont1, cont2 do
			local info = Map.MapInfo[cont]
			for id = info.Min, info.Max do
				if Nx.V30 or id ~= 2030 then		
					local f = {}
					local color, infoStr, minLvl = Map:GetMapNameDesc (id)
					local name = Map:IdToName (id)
					f.Name = format ("%s%s", color, name)
					f.Column2 = infoStr
					local fish = Map.MapWorldInfo[id].Fish
					if fish then
						f.Column3 = format ("Fish %s, %s", max (1, fish - 95), fish) 
					end
					f.T = "#Map" .. id
					f.Tx = parent.Tx
					f.MId = id
					f.SrtN = name
					f.Srt = minLvl
					tinsert (folder, f)
				end
			end
		end
		if folder.Map == 0 then
			sort (folder, function (a, b) if a.Srt == b.Srt then return a.SrtN < b.SrtN else return a.Srt < b.Srt end end)
		else
			sort (folder, function (a, b) return a.SrtN < b.SrtN end)
		end
	elseif folder.Inst then		
		local fcont = folder.Inst
		local n = 1
		for nxid, v in pairs (Nx.Zones) do
			local longname, minLvl, maxLvl, faction, typ, owner, pos, numPlyr = strsplit ("!", v)
			if faction == "3" then		
				local mapId = Nx.Map.NxzoneToMapId[nxid]
				if mapId then
					local cont = Nx.Map:IdToContZone (mapId)
					if cont == fcont then
						if nxid == 16 then
							Nx.prt ("%s [%s] %s", longname, nxid, v)
						end
						local f = {}
						local numPlyrStr = numPlyr
						if tonumber (numPlyr) == 1025 then
							numPlyrStr = "10/25"
						end
						local plStr = format (L["|cffff4040 %s-Man"], numPlyrStr)
						f.Name = format ("%s %s", _MapName(longname), plStr)
						f.Column2 = "?"
						if minLvl ~= "0" then
							if minLvl == maxLvl then
								f.Column2 = format ("%d", minLvl)
							else
								f.Column2 = format ("%d-%d", minLvl, maxLvl)
							end
						end
						f.T = "%In" .. nxid
						f.InstMapId = mapId
						local ownName = strsplit ("!", Nx.Zones[tonumber (owner)])
						local x, y = Nx.Quest:UnpackLocPt (pos)
						f.InstTip = format (L["%s |cffe0e040Lvl %s\n|r%s (%.1f %.1f)"], f.Name, f.Column2, ownName, x, y)
						f.Tx = parent.Tx
						folder[n] = f
						n = n + 1
					end
				end
			end
		end
	end
end
function Nx.Map.Guide:CalcType (folder)
	local typ = type (folder) == "table" and folder.T
	if typ then
		local s1, s2 = strsplit ("^", typ)
		if s2 then
			local s21 = strsub (s2, 1, 1)
			if s2 == "C" then
				local _, cls = UnitClass ("player")
				cls = Nx.Util_CapStr (cls)
				cls = gsub (cls, "Deathknight", "Death Knight")
				return cls .. " Trainer", true
			elseif s21 == "F" then	
				local s22 = strsub (s2, 2, 2)
				local fac = self:GetHideFaction()
				if s22 == "A" and fac == 1 then
					return
				end
				if s22 == "H" and fac == 2 then
					return
				end
				return s1
			elseif s21 == "P" then	
				local name = strsub (s2, 2)	
				if name == "" then
					name = folder.Pre
				end
				local t = self:GetProfessionTrainer (name)
				t = folder.Pre .. t
				return t, true
			elseif s21 == "S" then	
				local name = strsub (s2, 2)	
				if name == "" then
					name = folder.Pre
				end
				local t = self:GetSecondaryTrainer (name)
				t = folder.Pre .. t
				return t, true
			elseif s21 == "G" then
				
				return
			end
		end
		return s1
	end
end
function Nx.Map.Guide:ClearAll()
	self.Map:ClearTargets ("Guide")
	self:ClearShowFolders()
	self:Update()
end
function Nx.Map.Guide:ClearShowFolders()
	local opts = Nx:GetGlobalOpts()
	self.ShowFolders = {}
	local gFolder = self:FindFolder ("Gather")
	if Nx.CharOpts["MapShowGatherH"] then
		local folder = self:FindFolder ("Herb", gFolder)
		self:AddShowFolders (folder)
	end
	if Nx.CharOpts["MapShowGatherM"] then
		local folder = self:FindFolder ("Ore", gFolder)
		self:AddShowFolders (folder)
	end
	if Nx.CharOpts["MapShowGatherA"] then
		local folder = self:FindFolder ("Artifacts", gFolder)
		self:AddShowFolders (folder)
	end
	if Nx.CharOpts["QMapShowQuestGivers3"] > 1 then
		local folder = self:FindFolder ("Quest Givers")
		self:AddShowFolders (folder)
	end
end
function Nx.Map.Guide:UpdateGatherFolders()
	self:ClearShowFolders()
	self:Update()
end
function Nx.Map.Guide:AddShowFolders (folder, remove, filter)
	if type (folder) == "table" then
		local typ, filt = self:CalcType (folder)
		filter = filter or filt and typ
		if filter and typ ~= filter and not remove then
			typ = nil
		end
		if typ then
			self.ShowFolders[typ] = not remove and folder or nil
		end
		if remove or not folder.NoShowChild then
			for showType, childFolder in ipairs (folder) do
				self:AddShowFolders (childFolder, remove, filter)
			end
		end
	end
end
function Nx.Map.Guide:IsShowFolders (folder)
	if folder.T then
		local t = self:CalcType (folder)
		if self.ShowFolders[t] then
			return true
		end
	end
	for showType, child in ipairs (folder) do
		if type (child) == "table" then
			if self:IsShowFolders (child) then
				return true
			end
		end
	end
end
function Nx.Map.Guide:FindFolder (name, folder)
	folder = folder or Nx.GuideInfo
	for n, child in ipairs (folder) do
		local cname = gsub (child.Name or child.T, "   >>", "")
		if cname == name then
			return child, n
		end
	end
end
function Nx.Map.Guide:Update()    
	local path = ""
	for n = 2, #self.PathHistory do
		local folder = self.PathHistory[n]
		local name = folder.Name
		if strbyte (name) == 64 then		
			name = Nx.GuideAbr[strsub (name, 2)]
		end
		if n == 2 then
			path = _TRANS(name)
		else
			path = path .. "." .. _TRANS(name)
		end
	end
	self.Win:SetTitle (path)
	local i = max (#self.PathHistory - 1, 1)
	self:UpdateList (self.List, i, 1)
	local i = #self.PathHistory
	if i <= 1 then
		i = 0				
	end
	self:UpdateList (self.List2, i, 2)
	self:UpdateMapIcons()
end
function Nx.Map.Guide:UpdateList (list, pathI, listSide)
	list:Empty()
	local curFolder = self.PathHistory[pathI]
	if curFolder then
		local filterStr = strlower (self.EditBox:GetText())
		if listSide == 1 then	
			filterStr = ""
		end
		if curFolder.Item then
			self:ItemsUpdateFolder (curFolder)
		end
		for index, folder in ipairs (curFolder) do
			if type (folder) == "number" then
				local id = folder
				Nx.Item:Load (id)
				local name, iLink, iRarity, lvl, minLvl, type, subType, stackCount, equipLoc, tx = GetItemInfo (id)
				local show = true
				if filterStr ~= "" then
					local lstr = strlower (format ("%s", name))
					show = strfind (lstr, filterStr, 1, true)
				end
				if show then
					if not name then
						name = id .. "?"
						tx = "Interface\\Icons\\INV_Misc_QuestionMark"
					else
						name = strsub (iLink, 1, 10) .. name	
					end
					list:ItemAdd (index)
					list:ItemSet (2, format ("%s", name))
					local tip = iLink and format ("!%s", iLink) or folder.Tip
					list:ItemSetButton ("Guide", false, tx, tip)
				end
			else
				local add = true
				if folder.T then
					add = self:CalcType (folder)		
				end
				if add then
					local name = folder.Name
					if strbyte (name) == 64 then		
						name = Nx.GuideAbr[strsub (name, 2)]
					end
					local show = true
					local column4
					if filterStr ~= "" then
						local ft = folder.FilterText
						local lstr = strlower (ft or name)
						show = strfind (lstr, filterStr, 1, true)
						if show and ft then
							for n = show, 10, -1 do	
								if strbyte (ft, n) == 10 or n == 10 then
									local ftEnd = strfind (ft, "\n", n + 1, true)
									column4 = strsub (ft, n + 1, ftEnd)
									break
								end
							end
						end
					end
					if show then
						local col = "|cffdfdfdf"
						if folder[1] or folder.Item then
							col = "|cff8fdf8f"
							name = _TRANS(name) .. "  |cffbf6f6f>>"
						else
							name = _TRANS(name)
						end
						list:ItemAdd (index)
						list:ItemSet (2, format ("%s%s", col, name))
						if listSide == 2 then	
							if folder.Column2 then
								list:ItemSet (3, folder.Column2)
							end
							if folder.Column3 then
								list:ItemSet (4, folder.Column3)
							end
							if column4 then
								list:ItemSet (5, column4)
							end
							if folder.Column4 then
								list:ItemSet (5, folder.Column4)
							end
						end
						local pressed = self:IsShowFolders (folder)
						local tx = folder.Tx
						if not tx then
							for n = #self.PathHistory, 1, -1 do
								local folder = self.PathHistory[n]
								tx = folder.Tx
								if tx then
									break
								end
							end
						end
						tx = "Interface\\Icons\\" .. tx
						local tip = folder.Link and format ("!%s^%s", folder.Link, folder.Tip or "") or folder.Tip
						list:ItemSetButton ("Guide", pressed, tx, tip)
					end
				end
			end
		end
	end
	list:Update()
end
function Nx.Map.Guide:UpdateMapIcons()    
	local Nx = Nx
	local Quest = Nx.Quest
	local Map = Nx.Map
	local map = self.Map
	assert (map)
	local hideFac = self:GetHideFaction()
	map:InitIconType ("!G", "WP", "", 16, 16)
	map:SetIconTypeChop ("!G", true)
	map:InitIconType ("!GIn", "WP", "", 20, 20)	
	map:SetIconTypeChop ("!GIn", true)
	map:InitIconType ("!Ga", "WP", "", 12, 12)
	local a = map.GOpts["MapIconGatherA"]
	map:SetIconTypeAlpha ("!Ga", a, a < 1 and a * .5)
	map:SetIconTypeChop ("!Ga", true)
	map:SetIconTypeAtScale ("!Ga", map.GOpts["MapIconGatherAtScale"])
	map:InitIconType ("!GQ", "WP", "", 16, 16)
	map:SetIconTypeChop ("!GQ", true)
	map:SetIconTypeLevel ("!GQ", 1)
	map:InitIconType ("!GQC", "WP", "", 10, 10)
	map:SetIconTypeChop ("!GQC", true)
	local cont1 = 1
	local cont2 = Map.ContCnt
	local mapId = map:GetCurrentMapId()
	if not mapId then return end
    if Nx.Map:IsMicroDungeon(mapId) then return end 
	if not self.ShowAllCont then
		cont1 = map:IdToContZone (mapId)
		cont2 = cont1
	end
	for showType, folder in pairs (self.ShowFolders) do		
		local mode = strbyte (showType)		
		local tx = "Interface\\Icons\\" .. (folder.Tx or "")
		if mode == 36 then					
			local type = strsub (showType, 2, 2)
			local longType = type == "H" and "Herb" or type == "M" and "Mine"
			local fid = folder.Id
			local data = longType and Nx:GetData (longType) or NxData.NXGather["Misc"]
			local zoneT = data[mapId]
			if zoneT then
				local nodeT = zoneT[fid]
				if nodeT then
					local iconType = fid == "Art" and "!G" or "!Ga"
					for k, node in ipairs (nodeT) do
						local x, y = Nx:GatherUnpack (node)
						local name, tex, skill = Nx:GetGather (type, fid)						
						name = _TRANS(name)
						assert (name)
						local wx, wy = Map:GetWorldPos (mapId, x, y)						
						icon = map:AddIconPt (iconType, wx, wy, nil, "Interface\\Icons\\"..tex)
						if skill > 0 then
							name = name .. " " .. skill
						end
						map:SetIconTip (icon, name)
					end
				end
			end
		elseif mode == 35 then		
		elseif mode == 37 then		
			local mapId = folder.InstMapId
			local winfo = Map.MapWorldInfo[mapId]
			local wx = winfo[2]
			local wy = winfo[3]
			local icon = map:AddIconPt ("!GIn", wx, wy, nil, tx)
			map:SetIconTip (icon, folder.InstTip)
			map:SetIconUserData (icon, folder.InstMapId)
		elseif mode == 38 then		
			if Quest and Quest.QGivers then	
				local mapId = map:GetCurrentMapId()
				mapId=Nx.Map:GCMI_OVERRIDE(mapId) 
				local zone = Nx.MapIdToNxzone[mapId]
				local stzone = Quest.QGivers[zone]
				if stzone then
					local opts = Nx:GetGlobalOpts()
					if not Nx.CurCharacter["Level"] then return end 
					local minLvl = Nx.CurCharacter["Level"] - opts["QMapQuestGiversLowLevel"]
					local maxLvl = Nx.CurCharacter["Level"] + opts["QMapQuestGiversHighLevel"]
					local state = Nx.CharOpts[folder.Persist]
					local debugMap = NxData.DebugMap
					local showComplete = self.ShowQuestGiverCompleted
					local qIds = Quest.QIds
					for namex, qdata in pairs (stzone) do
						local name = strsplit ("=", namex)
						local anyDaily
						local show
						local s = name
						for n = 1, #qdata, 4 do
							local qId = tonumber (strsub (qdata, n, n + 3), 16)
							local quest = Quest.IdToQuest[qId]
							local qname, _, lvl, minlvl = Quest:Unpack (quest[1])
							if lvl < 1 then	
								lvl = Nx.CurCharacter["Level"]
							end
							if lvl >= minLvl and lvl <= maxLvl then
								local col = "|r"
								local daily = Quest.DailyIds[qId] or Quest.DailyDungeonIds[qId]
								anyDaily = anyDaily or daily
								local status, qTime = Nx:GetQuest (qId)
								if daily then
									col = "|cffa0a0ff"
									show = true
								elseif status == "C" then
									col = "|cff808080"
								else
									if qIds[qId] then
										col = "|cff80f080"
									end
									show = true
								end
								local qcati = Quest:UnpackCategory (quest[1])
								if qcati > 0 then
									qname = qname .. " <" .. Nx.QuestCategory[qcati] .. ">"
								end
								s = format ("%s\n|cffbfbfbf%d%s %s", s, lvl, col, qname)
								if quest.CNum then
									s = s .. format (L[" (Part %d)"], quest.CNum)
								end
								if daily then
									s = s .. (Quest.DailyDungeonIds[qId] and L[" (Dungeon Daily"] or L[" (Daily"])
									local typ, money, rep, req = strsplit ("^", daily)
									if rep and #rep > 0 then
										s = s .. ", "
										for n = 0, 1 do	
											local i = n * 4 + 1
											local repChar = strsub (rep or "", i, i)
											if repChar == "" then
												break
											end
											s = s .. " " ..  _TRANS(Quest.Reputations[repChar])
										end
									end
									s = s .. ")"
								end
								if debugMap then
									s = s .. format (" [%d]", qId)
								end
							end
						end
						if state == 3 and not anyDaily then
							show = false
							showComplete = false
						end
						if show or showComplete then
							local qId = tonumber (strsub (qdata, 1, 4), 16)
							local quest = Quest.IdToQuest[qId]
							local startName, zone, x, y = Quest:GetSEPos (quest[2])
							local wx, wy = Map:GetWorldPos (mapId, x, y)
							local tx = anyDaily and "Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconExclaimB" or "Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconExclaim" 
							local icon = map:AddIconPt (show and "!GQ" or "!GQC", wx, wy, nil, tx)
							map:SetIconTip (icon, s)
							icon.UDataQuestGiverD = qdata
						end
					end
				end
			end
		elseif mode == 40 then		
			local mapId, x, y = strsplit ("^", folder.VendorPos)
			mapId = tonumber (mapId)
			x = tonumber (x)
			y = tonumber (y)
			local wx, wy = Map:GetWorldPos (mapId, x, y)
			local icon = map:AddIconPt ("!G", wx, wy, nil, tx)
			map:SetIconTip (icon, folder.Name)
		elseif mode == 41 then		
			local vv = NxData.NXVendorV
			local t = { strsplit ("^", folder.ItemSource) }
			for _, npcName in pairs (t) do
				local npc = vv[npcName]		
				if npc then
					local links = npc["POS"]
					local mapId, x, y = strsplit ("^", links)
					mapId = tonumber (mapId)
					x = tonumber (x)
					y = tonumber (y)
					local wx, wy = Map:GetWorldPos (mapId, x, y)
					local icon = map:AddIconPt ("!G", wx, wy, nil, tx)
					local tag, name = strsplit ("~", npcName)
					local iname = strsplit ("\n", folder.Name)
					map:SetIconTip (icon, format ("%s\n%s\n%s", name, tag, iname))
				end
			end
		elseif mode == 42 then		
			local conStr = Nx.ZoneConnections[folder.ConIndex]
			local flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2 = Nx.Map:ConnectionUnpack (conStr)
			if folder.Con2 then
				mapId1, x1, y1, name1 = mapId2, x2, y2, name2
			end
			local wx, wy = Map:GetWorldPos (mapId1, x1, y1)
			local icon = map:AddIconPt ("!G", wx, wy, nil, tx)
			map:SetIconTip (icon, format ("%s\n%s %.1f %.1f", _Travel(name1), Nx.MapIdToName[mapId1], x1, y1))
		else
			for cont = cont1, cont2 do
				self:UpdateMapGeneralIcons (cont, showType, hideFac, tx, folder.Name, "!G")
			end
		end
	end
end
function Nx.Map.Guide:UpdateMapGeneralIcons (cont, showType, hideFac, tx, name, iconType, showMapId)
	if cont >= 9 then
		return
	end
	local Quest = Nx.Quest
	local Map = Nx.Map
	local map = self.Map
	if not Nx.GuideData[showType] then
		Nx.prt (L["guide showType %s"], showType)
		return
	end
    
	local dataStr = Nx.GuideData[showType][cont]
	if not dataStr or dataStr == "" then			
		return
	end	
	local mode = strbyte (dataStr)
	if mode == 32 then		
		for n = 2, #dataStr, 6 do
			local fac = strbyte (dataStr, n) - 35
			if fac ~= hideFac then  
				local zone = strbyte (dataStr, n + 1) - 35						
				local mapId = Map.NxzoneToMapId[zone]
				if mapId == nil then
				else
					if not showMapId or mapId == showMapId then
						local x, y = Quest:UnpackLocPtOff (dataStr, n + 2)						
						local wx, wy = map:GetWorldPos (mapId, x, y)
						local icon = map:AddIconPt (iconType, wx, wy, nil, tx)
						if (Nx.MapIdToName[mapId] == nil) then
							Nx.prt("ERROR: No Map Name For " .. mapId)
						else
							local str = format ("%s\n%s %.1f %.1f", _TRANS(name), Nx.MapIdToName[mapId], x, y)
							map:SetIconTip (icon, str)
						end
					end
				end
			end
		end
	elseif mode == 33 then		
	else	
		for n = 1, #dataStr, 2 do
			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = Nx.NPCData[npcI]
			if not npcStr then
				Nx.prt ("%s", name)
			end
			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then
				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = Quest:UnpackObjective (oStr)
				desc = gsub (desc, "!", ", ")
				local mapId = Map.NxzoneToMapId[zone]
				if not mapId then
					local name, minLvl, maxLvl, faction, cont = strsplit ("!", Nx.Zones[zone])
					if tonumber (faction) ~= 3 then
						Nx.prt (L["Guide icon err %s %d"], desc, zone)
					end
				elseif not showMapId or mapId == showMapId then
					local mapName = Nx.MapIdToName[mapId]
					if strbyte (oStr, loc) == 32 then  
						loc = loc + 1
						local cnt = floor ((#oStr - loc + 1) / 4)
						for locN = loc, loc + cnt * 4 - 1, 4 do
							local x, y = Quest:UnpackLocPtOff (oStr, locN)
							local wx, wy = map:GetWorldPos (mapId, x, y)
							local icon = map:AddIconPt (iconType, wx, wy, nil, tx)
							local str = format ("%s\n%s\n%s %.1f %.1f", _TRANS(name), _Tax(desc:gsub("\239\188\140.*$","")), mapName, x, y)  
							map:SetIconTip (icon, str)
						end
					else
						local _, zone, x, y = Quest:GetObjectivePos (oStr)
						local wx, wy = map:GetWorldPos (mapId, x, y)
						local icon = map:AddIconPt (iconType, wx, wy, nil, tx)
						local str = format ("%s\n%s\n%s %.1f %.1f", _TRANS(name), _Tax(desc:gsub("\239\188\140.*$","")), mapName, x, y)
						map:SetIconTip (icon, str)
					end
				end
			end
		end
	end
end
Nx.GuidePOI = {
	"Auctioneer~Racial_Dwarf_FindTreasure",
	"Banker~INV_Misc_Coin_02",
	"Flight Master~Ability_Mount_Wyvern_01",
	"Innkeeper~Spell_Shadow_Twilight",
	"Mailbox~INV_Letter_15",
    "Arcane Reforger~INV_Sword_67",
	
}
function Nx.Map.Guide:UpdateZonePOIIcons()
	local Quest = Nx.Quest
	local Map = Nx.Map
	local map = self.Map
	local mapId = map.MapId
    mapId = Nx.Map:GCMI_OVERRIDE(mapId) 
	local atScale = map.LOpts.NXPOIAtScale
	local alphaRange = atScale * .25
	local s = atScale - alphaRange
	local draw = map.ScaleDraw > s and map.GOpts["MapShowPOI"]
    if Nx.Map:IsMicroDungeon(mapId) then draw = false end 
	local alpha = min ((map.ScaleDraw - s) / alphaRange, 1) * map.GOpts["MapIconPOIAlpha"]
	map:SetIconTypeAlpha ("!POI", alpha)
	map:SetIconTypeAlpha ("!POIIn", alpha)
	if mapId == self.POIMapId and draw == self.POIDraw then
		return
	end
	self.POIMapId = mapId
	self.POIDraw = draw
	map:InitIconType ("!POI", "WP", "", 17, 17)
	map:InitIconType ("!POIIn", "WP", "", 21, 21)
	if not draw then
		return
	end
	if Nx.Free then
		if mapId ~= Nx.MapIdFree1 and mapId ~= Nx.MapIdFree2 then
			return
		end
	end
	map:SetIconTypeChop ("!POI", true)
	map:SetIconTypeAlpha ("!POI", alpha)
	map:SetIconTypeChop ("!POIIn", true)
	map:SetIconTypeAlpha ("!POIIn", alpha)
	local hideFac = UnitFactionGroup ("player") == "Horde" and 1 or 2
	local cont = map:IdToContZone (mapId)
	if cont > 0 and cont < 9 then
		for k, name in ipairs (Nx.GuidePOI) do
			local showType, tx = strsplit ("~", name)
			if showType == "Mailbox" then
				showType = map.GOpts["MapShowMailboxes"] and showType
			end
			if showType then
				tx = "Interface\\Icons\\" .. tx
				self:UpdateMapGeneralIcons (cont, showType, hideFac, tx, showType, "!POI", mapId)
			end
		end
		self:UpdateInstanceIcons (cont)
		self:UpdateTravelIcons (hideFac)
	end
end
function Nx.Map.Guide:UpdateInstanceIcons (cont)
	local Map = Nx.Map
	local map = self.Map
	local folder = self:FindFolder ("Instances")
	local inst = folder[cont]
	if not inst then	
		return
	end
	for showType, folder in ipairs (inst) do
		local mapId = folder.InstMapId
		local winfo = Map.MapWorldInfo[mapId]
		if winfo.EntryMId == map.MapId then
			local wx = winfo[2]
			local wy = winfo[3]
			local icon = map:AddIconPt ("!POIIn", wx, wy, nil, "Interface\\Icons\\INV_Misc_ShadowEgg")
			map:SetIconTip (icon, folder.InstTip)
			map:SetIconUserData (icon, folder.InstMapId)
		end
	end
end
function Nx.Map.Guide:UpdateTravelIcons (hideFac)
	local Map = Nx.Map
	local map = self.Map
	local mapId = map.MapId
	local folder = self:FindFolder ("Travel")
	for showType, folder in ipairs (folder) do
		if folder.MapId == mapId and folder.Fac ~= hideFac then
			local conStr = Nx.ZoneConnections[folder.ConIndex]
			local flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2 = Nx.Map:ConnectionUnpack (conStr)
			if folder.Con2 then
				mapId1, x1, y1, name1 = mapId2, x2, y2, name2
			end
			local wx, wy = Map:GetWorldPos (mapId1, x1, y1)
			local icon = map:AddIconPt ("!POI", wx, wy, nil, "Interface\\Icons\\" .. folder.Tx)
			map:SetIconTip (icon, format ("%s\n%s %.1f %.1f", _Travel(name1), Nx.MapIdToName[mapId1], x1, y1))
		end
	end
	local winfo = Map.MapWorldInfo[mapId]
	if winfo then
		if winfo.Connections then
			for id, zcon in pairs (winfo.Connections) do
				for n, con in ipairs (zcon) do
					local wx, wy = con.StartX, con.StartY
					local icon = map:AddIconPt ("!POI", wx, wy, nil, "Interface\\Icons\\Spell_Nature_FarSight")
					map:SetIconTip (icon, L["Connection to "] .. Nx.MapIdToName[con.EndMapId])
					local wx, wy = con.EndX, con.EndY
					local icon = map:AddIconPt ("!POI", wx, wy, nil, "Interface\\Icons\\Spell_Nature_FarSight")
				end
			end
		end
	end
end
function Nx.Map.Guide:OnMapUpdate()
	local typ = self.FindingClosest
	if typ then
		local t, folder = self.Map:GetTargetInfo()
		if t == "Guide" and type (folder) == "table" then
			local npcI, mapId, x, y, npcI2, mapId2, x2, y2 = self:FindClosest (typ)
			if npcI then
				self.Map:SetTarget ("Guide", x, y, x, y, false, folder, folder.Name, false, mapId)
				if false and npcI2 then
					self.Map:SetTarget("Guide2",x2,y2,x2,y2,false,folder,folder.Name,true,mapId2) 
				end
			end
		end
	end
end
function Nx.Map.Guide:FindClosest (findType)
	local Quest = Nx.Quest
	local Map = Nx.Map
	local map = self.Map
	assert (map)
	local cont1 = 1
	local cont2 = Map.ContCnt
	if not self.ShowAllCont then
		local mapId = map.RMapId
		cont1 = map:IdToContZone (mapId)
		cont2 = cont1
	end
	local hideFac = self:GetHideFaction()
	local close, closeMapId, closeX, closeY
	local close2, closeMapId2, closeX2, closeY2	
	local closeDist = 999999999
	local px = map.PlyrX
	local py = map.PlyrY
	for showType, folder in pairs (self.ShowFolders) do
		if showType == findType then
			local mode = strbyte (showType)
			if mode == 36 then		
				local type = strsub (showType, 2, 2)
				local longType = type == "H" and "Herb" or type == "M" and "Mine"
				if longType then
					local fid = folder.Id
					local data = Nx:GetData (longType)
					for cont = cont1, cont2 do
						local idmin = Map.MapInfo[cont].Min
						local idmax = Map.MapInfo[cont].Max
						for mapId = idmin, idmax do
							local zoneT = data[mapId]
							if zoneT then
								local nodeT = zoneT[fid]
								if nodeT then
									for k, node in ipairs (nodeT) do
										local x, y = Nx:GatherUnpack (node)
										local wx, wy = Map:GetWorldPos (mapId, x, y)
										local dist = (wx - px) ^ 2 + (wy - py) ^ 2
										if dist < closeDist then
											closeDist = dist
											close = 0
											closeMapId = mapId
											closeX, closeY = wx, wy
										end
									end
								end
							end
						end
					end
				end
			elseif mode == 35 then		
			elseif mode == 37 then		
                local mapId=folder.InstMapId
                local win1=Nx.Map.MapWorldInfo[mapId]
                local wx=win1[2]
                local wy=win1[3]
                close, closeMapId, closeX, closeY = 0, folder.InstMapId, wx, wy
				
			elseif mode == 38 then		
			elseif mode == 40 then		
				local mapId, x, y = strsplit ("^", folder.VendorPos)
				mapId = tonumber (mapId)
				x = tonumber (x)
				y = tonumber (y)
				local wx, wy = Map:GetWorldPos (mapId, x, y)
				local dist = (wx - px) ^ 2 + (wy - py) ^ 2
				if dist < closeDist then
					closeDist = dist
					close = 0
					closeMapId = mapId
					closeX, closeY = wx, wy
				end
			elseif mode == 41 then		
				local vv = NxData.NXVendorV
				local t = { strsplit ("^", folder.ItemSource) }
				for _, npcName in pairs (t) do
					local links = vv[npcName]["POS"]
					local mapId, x, y = strsplit ("^", links)
					mapId = tonumber (mapId)
					x = tonumber (x)
					y = tonumber (y)
					local wx, wy = Map:GetWorldPos (mapId, x, y)
					local dist = (wx - px) ^ 2 + (wy - py) ^ 2
					if dist < closeDist then
						closeDist = dist
						close = 0
						closeMapId = mapId
						closeX, closeY = wx, wy
					end
				end
			elseif mode == 42 then		
			
			local conStr = Nx.ZoneConnections[folder.ConIndex]
			local flags, conTime, mapId1, x1, y1, mapId2, x2, y2, name1, name2 = Nx.Map:ConnectionUnpack (conStr)
			if folder.Con2 then
				mapId1, x1, y1, name1, mapId2, x2, y2, name2 = mapId2, x2, y2, name2, mapId1, x1, y1, name1
			end
			local wx, wy = Map:GetWorldPos (mapId1, x1, y1)
			local wx2, wy2 = Map:GetWorldPos (mapId2, x2, y2)
			close, closeMapId, closeX, closeY = 0, mapId1, wx, wy
			close2, closeMapId2, closeX2, closeY2 = 0, mapId2, wx2, wy2
			else
				for cont = cont1, cont2 do					
					local data0 = Nx.GuideData[showType]
					if not data0 then
						return
					end					
					local dataStr = data0[cont]					
					if strbyte (dataStr, 1) == 32 then		
						for n = 2, #dataStr, 6 do
							local fac = strbyte (dataStr, n) - 35
							if fac ~= hideFac then
								local zone = strbyte (dataStr, n + 1) - 35								
								local mapId = Map.NxzoneToMapId[zone]
								local x, y = Quest:UnpackLocPtOff (dataStr, n + 2)
								local wx, wy = map:GetWorldPos (mapId, x, y)
								local dist = (wx - px) ^ 2 + (wy - py) ^ 2
								if dist < closeDist then
									closeDist = dist
									close = 0
									closeMapId = mapId
									closeX, closeY = wx, wy
								end
							end
						end
					elseif strbyte (dataStr) == 33 then		
					else	
						for n = 1, #dataStr, 2 do
							local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
							local npcStr = Nx.NPCData[npcI]
							local fac = strbyte (npcStr, 1) - 35
							if fac ~= hideFac then
								local oStr = strsub (npcStr, 2)
								local desc, zone, loc = Quest:UnpackObjective (oStr)
								local mapId = Map.NxzoneToMapId[zone]
								if mapId then
									if strbyte (oStr, loc) == 32 then  
										loc = loc + 1
										local cnt = floor ((#oStr - loc + 1) / 4)
										for locN = loc, loc + cnt * 4 - 1, 4 do
											local x, y = Quest:UnpackLocPtOff (oStr, locN)
											local wx, wy = map:GetWorldPos (mapId, x, y)
											local dist = (wx - px) ^ 2 + (wy - py) ^ 2
											if dist < closeDist then
												closeDist = dist
												close = npcI
												closeMapId = mapId
												closeX, closeY = wx, wy
											end
										end
									else
										local desc, zone, x, y = Quest:GetObjectivePos (oStr)
										local wx, wy = map:GetWorldPos (mapId, x, y)
										local dist = (wx - px) ^ 2 + (wy - py) ^ 2
										if dist < closeDist then
											closeDist = dist
											close = npcI
											closeMapId = mapId
											closeX, closeY = wx, wy
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
	return close, closeMapId, closeX, closeY, close2, closeMapId2, closeX2, closeY2
end
function Nx.Map.Guide:GetHideFaction()
	local fac = UnitFactionGroup ("player") == "Horde" and 1 or 2
	if self.ShowEnemy then
		fac = fac == 1 and 2 or 1	
	end
	return fac
end
function Nx.Map.Guide:GetProfessionTrainer (profName)
	return " Trainer"
end
function Nx.Map.Guide:GetSecondaryTrainer (profName)
	return " Trainer"
end
function Nx.Map.Guide:SavePlayerNPCTarget()
    local visible = GameTooltip:IsVisible()
    GameTooltip:SetOwner(MerchantFrame) 
    GameTooltip:SetUnit("NPC")
	local tag = GameTooltipTextLeft2:GetText() or ""
	local lvl = GameTooltipTextLeft3:GetText() or ""
	local faction = GameTooltipTextLeft4:GetText() or ""
    if strfind(tag,"^" .. NXlLEVELSPC) or strfind(tag, "^|c%x%x%x%x%x%x%x%x" .. NXlLEVELSPC) then
        tag=""
        faction=lvl
    end
	local str=format("%s~%s~%s",tag,GameTooltipTextLeft1:GetText() or "",faction)
	self.PlayerNPCTarget = str
    if not visible then
        GameTooltip:Hide()
    end
		
	
	local map = Nx.Map:GetMap (1)
	local s = Nx:PackXY (map.PlyrRZX, map.PlyrRZY)
	self.PlayerNPCTargetPos = format ("%d^%s", Nx.MapIdToNxzone[map.RMapId] or 0, s)
end
function Nx.Map.Guide.OnGossip_show()
	local self = Nx.Map.Guide
	self:SavePlayerNPCTarget()
	self:CaptureNPC ("G")
end
function Nx.Map.Guide.OnTrainer_show()
	local self = Nx.Map.Guide
	self:SavePlayerNPCTarget()
	self:CaptureNPC ("T")
end
function Nx.Map.Guide:CaptureNPC (data)
	local opts = Nx:GetGlobalOpts()
	if not opts["CaptureEnable"] then
		return
	end
	local cap = Nx:GetCap()
	local npcs = Nx:CaptureFind (cap, "NPC")
	local len = 0
	for _, str in pairs (npcs) do
		len = len + 4 + #str + 1
	end
	if len > 5 * 1024 then		
		return
	end
	local name = self.PlayerNPCTarget
	local facI = UnitFactionGroup ("player") == "Horde" and 1 or 0
	npcs[name] = format ("%s^%d^%s", self.PlayerNPCTargetPos, facI, data)
end
function Nx.Map.Guide.OnMerchant_show()
	local self = Nx.Map.Guide
	self:SavePlayerNPCTarget()
	self.VendorRepair = CanMerchantRepair()
	self:CaptureNPC (format ("M%s", self.VendorRepair and 1 or 0))
	self.CanCap = true
	self.OnMerchant_update()
end
function Nx.Map.Guide.OnMerchant_update()
	local self = Nx.Map.Guide
	if self.CanCap then
		Nx.Timer:Start ("Vendor", .3, self, self.CapTimer)		
	end
end
function Nx.Map.Guide:CapTimer()
	Nx.Timer:ProfilerStart ("Guide CapTimer")
	local map = Nx.Map:GetMap (1)
	local g = map.Guide
	local ok = g:CaptureItems()  
	g:UpdateVisitedVendors()
	g:Update()
	Nx.Timer:ProfilerEnd ("Guide CapTimer")
	if not ok and MerchantFrame:IsVisible() then
		if Nx.LootOn then
			Nx.prt ("CapTimer retry")
		end
		return .5
	end
	self.CanCap = false		
end
function Nx.Map.Guide:UpdateVisitedVendors()
	local vv = NxData.NXVendorV
	if not vv or (NxData.NXVendorVVersion or 0) < Nx.VERSIONVENDORV then
		vv = {}
		NxData.NXVendorV = vv
		NxData.NXVendorVVersion = Nx.VERSIONVENDORV
	end
	local folder = self:FindFolder ("Visited Vendor")
	assert (folder)
	if folder then
		local allFolder = folder[1]
		for n = 1, #allFolder do
			allFolder[n] = nil
		end
		for n = 2, #folder do	
			folder[n] = nil
		end
		local unique = {}
		for npcName, links in pairs (vv) do
			local tag = strsplit ("~", npcName)
			unique [tag] = true
		end
		local uniqueTag
		local tagFolder
		local uniqueItems = {}
		local vsorted = {}
		for npcName, links in pairs (vv) do
			tinsert (vsorted, npcName)
		end
		sort (vsorted)
		for _, npcName in ipairs (vsorted) do
			local tag, name = strsplit ("~", npcName)
			if uniqueTag ~= tag then
				uniqueTag = tag
				tagFolder = {}
				tagFolder.Name = format ("%s", tag)
				tinsert (folder, tagFolder)
			end
			local links = vv[npcName]
			local npcF = {}
			local mapId = strsplit ("^", links["POS"])
			mapId = tonumber (mapId)
			npcF.T = "(" .. npcName
			npcF.Tx = "INV_Misc_Coin_05"
			local repair = links["R"] and L[" (Repair)"] or ""
			
			npcF.Name = name
			npcF.Column2 = repair
			npcF.Column3 = format("|cff8080c0%s|r",Nx.Map:IdToName(maI))
			npcF.VendorPos = links["POS"]
			npcF.NoShowChild = true
			tinsert (tagFolder, npcF)
			local n = 1
			while n <= #links do
				local id = strsplit ("^", links[n])
				local name = GetItemInfo (id)
				if not name then
					if Nx.Item:Load (id) then	
						tremove (links, n)
						Nx.prt (L["Removed old vendor item %s"], id)
						n = n - 1
					end
				end
				n = n + 1
			end
			for _, item in ipairs (links) do
				local id, price = strsplit ("^", item)
				local name, iLink, iRarity, lvl, minLvl, type, subType, stackCount, equipLoc, tx = GetItemInfo (id)
				name = name or format ("%s", id)
				local itemF = uniqueItems[id]
				if itemF then
					itemF.ItemSource = itemF.ItemSource .. "^" .. npcName
				else
					itemF = {}
					itemF.ItemSource = npcName
					itemF.SortName = name
					uniqueItems[id] = itemF
					itemF.T = ")" .. id
					if iLink then
						
						local col = strsub (iLink, 1, 10)
						
						itemF.Name = format ("%s%s|r", col, name)
						
						itemF.Link = iLink
						itemF.Tx = gsub (tx, "Interface\\Icons\\", "")
						
						if lvl > 1 then
							
							
							itemF.Column2 = format ("L%2d", lvl)
						end
                        itemF.Column3 = price
                        itemF.Column4 = type..(subType and "-"..subType or "")
					else
						itemF.Name = name
                        if name=="1?" then itemF.Name = price end
						itemF.Tx = "INV_Misc_QuestionMark"
					end
				end
				tinsert (npcF, itemF)
			end
			sort (npcF, function (a, b) return a.SortName < b.SortName end)
		end
		for name, itemF in pairs (uniqueItems) do
			tinsert (allFolder, itemF)
		end
		sort (allFolder, function (a, b) return a.SortName < b.SortName end)
	end
	Nx.Timer:ProfilerStart ("Guide CapTimer gc")
	collectgarbage ("collect")
	Nx.Timer:ProfilerEnd ("Guide CapTimer gc")
end
Nx.VendorCostAbr = {
	["INV_Jewelry_Amulet_07"] = "AB",
	["INV_Jewelry_Necklace_21"] = "AV",
	["Spell_Nature_EyeOfTheStorm"] = "EOS",
	["INV_Misc_Rune_07"] = "WG",
	["Spell_Holy_ChampionsBond"] = "Badge of Justice", 
	["INV_Misc_Dust_06"] = "Holy Dust",			
	["INV_Misc_Rune_05"] = "Arcane Rune",		
	["INV_Chest_Chain_03"] = "Chestguard Token", 
	["INV_Gauntlets_27"] = "Gloves Token",
	["INV_Helmet_24"] = "Helm Token",
	["INV_Pants_Plate_17"] = "Leggings Token",
	["INV_Shoulder_22"] = "Pauldrons Token",
	["INV_Misc_Apexis_Shard"] = "Apexis Shard",
	["INV_Misc_Apexis_Crystal"] = "Apexis Crystal",
	["INV_Misc_Token_Thrallmar"] = "Thrallmar Token",
	["INV_Misc_Rune_08"] = "Battle Token",
	["INV_Misc_Rune_09"] = "Research Token",
	["Spell_Holy_ProclaimChampion"] = "Emblem of Heroism",
	["Spell_Holy_ProclaimChampion_02"] = "Emblem of Valor",
	["INV_Misc_Platnumdisks"] = "Stone Keeper's Shard",
	["INV_Enchant_AbyssCrystal"] = "Abyss Crystal",
	["INV_Enchant_DreamShard_02"] = "Dream Shard",
	["INV_Misc_LeatherScrap_19"] = "Heavy Borean Leather",
	["INV_Misc_Pelt_14"] = "Arctic Fur",
}
function Nx.Map.Guide:CaptureItems()
	if not NxData.NXVendorV then
		return
	end
	local opts = Nx:GetGlobalOpts()
	local map = Nx.Map:GetMap (1)
	if MerchantFrame:IsVisible() then
		local vcabr = Nx.VendorCostAbr
		local npc = self.PlayerNPCTarget 
		local tag, name = strsplit ("~", npc)
		npc = format ("%s~%s", tag, name)
		local links = {}
		links["POS"] = format ("%d^%s^%s", map.RMapId, map.PlyrRZX, map.PlyrRZY)
		links["T"] = time()
		links["R"] = self.VendorRepair
		for n = 1, GetMerchantNumItems() do
			local name, tx, price, quantity, numAvail, usable, exCost = GetMerchantItemInfo (n)
			local link = GetMerchantItemLink (n)
			if not name then
				return	
			end
			if not link then
				link = " :" .. name	
			end
			local priceStr = Nx.Util_GetMoneyStr (price)
			if exCost then
				local iCnt = GetMerchantItemCostInfo (n)	
				if price <= 0 then
					priceStr = ""
				else
					priceStr = priceStr .. "|r "
				end
				if iCnt > 0 then
					for i = 1, MAX_ITEM_COST do
						local tx, value, costItemLink,costItemName = GetMerchantItemCostItem (n, i)  
						if value and value > 0 then
							
                            if costItemName then 
                                tx = costItemName
                            elseif costItemLink then
                                tx = costItemLink
                            elseif tx then
							
								tx = gsub (tx, "Interface\\Icons\\", "")
								if strfind (tx, "-Honor-") then	
									tx = " honor"
								end
								if strfind (tx, "-justice") then	
									tx = " justice"
								end
								if strfind (tx, "-valor") then	
									tx = " valor"
								end
							end
							
							priceStr = priceStr .. ( value>1 and value.." " or "") .. ( vcabr[tx] or tx )
							
						end
					end
				end
			end
			local _, id = strsplit (":", link)
			links[n] = id .. "^" .. strtrim (priceStr)
		end
		local vv = NxData.NXVendorV
		local nobefore = not vv[npc]
		vv[npc] = links
		local oName
		local maxCnt = min (max (1, opts["GuideVendorVMax"]), 1000)
		opts["GuideVendorVMax"] = maxCnt
		while true do
			local old = math.huge
			local cnt = 0
			for npcName, links in pairs (vv) do
				cnt = cnt + 1
				if links["T"] < old then	
					old = links["T"]
					oName = npcName
				end
			end
			if cnt <= maxCnt then		
				break
			end
			vv[oName] = nil	
		end
		if nobefore or Nx.LootOn then
			Nx.prt (L["Captured %s (%d)"], npc, #links)
		end
		return true
	end
end
function Nx.Map.Guide:FindTaxis (campName)
	local Map = Nx.Map
	local Quest = Nx.Quest
	local hideFac = UnitFactionGroup ("player") == "Horde" and 1 or 2
	for cont = 1, Map.ContCnt do
		local dataStr = Nx.GuideData["Flight Master"][cont] or ""
		for n = 1, #dataStr, 2 do
			local npcI = (strbyte (dataStr, n) - 35) * 221 + (strbyte (dataStr, n + 1) - 35)
			local npcStr = Nx.NPCData[npcI]
			local fac = strbyte (npcStr, 1) - 35
			if fac ~= hideFac then
				local oStr = strsub (npcStr, 2)
				local desc, zone, loc = Quest:UnpackObjective (oStr)
				local name, camp = strsplit ("!", desc)
				camp = NXlTaxiNames[camp] or camp	-- Localize it
				camp = _TaxiName(camp)  --by warbaby
				
				if camp == campName then
					local mapId = Map.NxzoneToMapId[zone]
					local x, y = Quest:UnpackLoc (oStr, loc)
					local wx, wy = Map:GetWorldPos (mapId, x, y)
					return name, wx, wy
				end
			end
		end
	end
end
Nx.Map.Guide.ItemCats = {
	{
		Name = "Armor",
		Tx = "Spell_Holy_ArdentDefender",
		{
			Name = "Cloth",
			Tx = "INV_Chest_Cloth_21",
			{
				Name = "Head",
				T = "Cloth",
				Tx = "INV_Helmet_31",
				Item = 1,
			},
			{
				Name = "Shoulders",
				T = "Cloth",
				Tx = "INV_Shoulder_09",
				Item = 3,
			},
			{
				Name = "Chest",
				T = "Cloth",
				Tx = "INV_Chest_Cloth_21",
				Item = 5,
			},
			{
				Name = "Wrists",
				T = "Cloth",
				Tx = "INV_Bracer_10",
				Item = 9,
			},
			{
				Name = "Hands",
				T = "Cloth",
				Tx = "INV_Gauntlets_18",
				Item = 10,
			},
			{
				Name = "Waist",
				T = "Cloth",
				Tx = "INV_Belt_02",
				Item = 6,
			},
			{
				Name = "Legs",
				T = "Cloth",
				Tx = "INV_Pants_Cloth_01",
				Item = 7,
			},
			{
				Name = "Feet",
				T = "Cloth",
				Tx = "INV_Boots_Cloth_03",
				Item = 8,
			},
			{
				Name = "Back",
				T = "Cloth",
				Tx = "INV_Misc_Cape_10",
				Item = 16,
			},
		},
		{
			Name = "Leather",
			Tx = "INV_Chest_Leather_01",
			{
				Name = "Head",
				T = "Leather",
				Tx = "INV_Helmet_43",
				Item = 1,
			},
			{
				Name = "Shoulders",
				T = "Leather",
				Tx = "INV_Shoulder_09",
				Item = 3,
			},
			{
				Name = "Chest",
				T = "Leather",
				Tx = "INV_Chest_Cloth_21",
				Item = 5,
			},
			{
				Name = "Wrists",
				T = "Leather",
				Tx = "INV_Bracer_10",
				Item = 9,
			},
			{
				Name = "Hands",
				T = "Leather",
				Tx = "INV_Gauntlets_18",
				Item = 10,
			},
			{
				Name = "Waist",
				T = "Leather",
				Tx = "INV_Belt_02",
				Item = 6,
			},
			{
				Name = "Legs",
				T = "Leather",
				Tx = "INV_Pants_Cloth_01",
				Item = 7,
			},
			{
				Name = "Feet",
				T = "Leather",
				Tx = "INV_Boots_Cloth_03",
				Item = 8,
			},
		},
		{
			Name = "Mail",
			Tx = "INV_Chest_Chain_05",
			{
				Name = "Head",
				T = "Mail",
				Tx = "INV_Helmet_43",
				Item = 1,
			},
			{
				Name = "Shoulders",
				T = "Mail",
				Tx = "INV_Shoulder_09",
				Item = 3,
			},
			{
				Name = "Chest",
				T = "Mail",
				Tx = "INV_Chest_Cloth_21",
				Item = 5,
			},
			{
				Name = "Wrists",
				T = "Mail",
				Tx = "INV_Bracer_10",
				Item = 9,
			},
			{
				Name = "Hands",
				T = "Mail",
				Tx = "INV_Gauntlets_18",
				Item = 10,
			},
			{
				Name = "Waist",
				T = "Mail",
				Tx = "INV_Belt_02",
				Item = 6,
			},
			{
				Name = "Legs",
				T = "Mail",
				Tx = "INV_Pants_Cloth_01",
				Item = 7,
			},
			{
				Name = "Feet",
				T = "Mail",
				Tx = "INV_Boots_Cloth_03",
				Item = 8,
			},
		},
		{
			Name = "Plate",
			Tx = "INV_Chest_Plate05",
			{
				Name = "Head",
				T = "Plate",
				Tx = "INV_Helmet_43",
				Item = 1,
			},
			{
				Name = "Shoulders",
				T = "Plate",
				Tx = "INV_Shoulder_09",
				Item = 3,
			},
			{
				Name = "Chest",
				T = "Plate",
				Tx = "INV_Chest_Cloth_21",
				Item = 5,
			},
			{
				Name = "Wrists",
				T = "Plate",
				Tx = "INV_Bracer_10",
				Item = 9,
			},
			{
				Name = "Hands",
				T = "Plate",
				Tx = "INV_Gauntlets_18",
				Item = 10,
			},
			{
				Name = "Waist",
				T = "Plate",
				Tx = "INV_Belt_02",
				Item = 6,
			},
			{
				Name = "Legs",
				T = "Plate",
				Tx = "INV_Pants_Cloth_01",
				Item = 7,
			},
			{
				Name = "Feet",
				T = "Plate",
				Tx = "INV_Boots_Cloth_03",
				Item = 8,
			},
		},
		{
			T = "Shields",
			Tx = "INV_Shield_04",
			Item = -9,
		},
	},
	{
		Name = "Consumables",
		Tx = "INV_Alchemy_Elixir_Empty",
		{
			Name = "Foods & Drinks",
			T = "Food & Drink",
			Tx = "INV_Misc_Food_64",
			Item = -9,
		},
		{
			Name = "Potions & Elixirs",
			T = "Potion^Elixir",
			Tx = "INV_Alchemy_Elixir_05",
			Item = -9,
		},
		{
			Name = "Flasks",
			T = "Flask",
			Tx = "INV_Alchemy_EndlessFlask_03",
			Item = -9,
		},
	},
	{
		Name = "Miscellaneous",
		Tx = "INV_Jewelry_Ring_42",
		{
			Name = "Gems",
			Tx = "INV_Jewelcrafting_IceDiamond_02",
			{
				Name = "Six Colors",
				T = "Red^Orange^Yellow^Green^Blue^Purple",
				Tx = "INV_Jewelcrafting_Gem_01",
				Item = -9,
			},
			{
				T = "Red",
				Tx = "INV_Jewelcrafting_LivingRuby_03",
				Item = -9,
			},
			{
				T = "Orange",
				Tx = "INV_Jewelcrafting_NobleTopaz_03",
				Item = -9,
			},
			{
				T = "Yellow",
				Tx = "INV_Jewelcrafting_Dawnstone_03",
				Item = -9,
			},
			{
				T = "Green",
				Tx = "INV_Jewelcrafting_Talasite_03",
				Item = -9,
			},
			{
				T = "Blue",
				Tx = "INV_Jewelcrafting_StarOfElune_03",
				Item = -9,
			},
			{
				T = "Purple",
				Tx = "INV_Jewelcrafting_Nightseye_03",
				Item = -9,
			},
			{
				T = "Meta",
				Item = -9,
			},
			{
				T = "Prismatic",
				Tx = "INV_Enchant_PrismaticSphere",
				Item = -9,
			},
		},
		{
			Name = "Glyphs",
			Tx = "INV_Glyph_MajorDeathKnight",
			{
				Name = "Death Knight",		
				T = "Death Knight",
				Item = -9,
			},
			{
				T = "Druid",
				Item = -9,
			},
			{
				T = "Hunter",
				Item = -9,
			},
			{
				T = "Mage",
				Item = -9,
			},
			{
				T = "Paladin",
				Item = -9,
			},
			{
				T = "Priest",
				Item = -9,
			},
			{
				T = "Rogue",
				Item = -9,
			},
			{
				T = "Shaman",
				Item = -9,
			},
			{
				T = "Warlock",
				Item = -9,
			},
			{
				T = "Warrior",
				Item = -9,
			},
			{
				T = "Monk",
				Item = -9,
			},
		},
		{
			Name = "Necklaces",
			T = "Miscellaneous",
			Tx = "INV_Jewelry_Necklace_02",
			Item = 2,
		},
		{
			Name = "Rings",
			T = "Miscellaneous",
			Tx = "INV_Jewelry_Ring_03",
			Item = 11,
		},
		{
			Name = "Trinkets",
			T = "Miscellaneous",
			Tx = "INV_Jewelry_TrinketPVP_02",
			Item = 12,
		},
		{
			Name = "Off-Hand",
			T = "Miscellaneous",
			Tx = "INV_Offhand_Hyjal_D_01",
			Item = 23,
		},
		{
			Name = "Idols",
			T = "Idols",
			Tx = "INV_Misc_Idol_03",
			Item = -9,
		},
		{
			Name = "Librams",
			T = "Librams",
			Tx = "INV_Misc_Idol_03",
			Item = -9,
		},
		{
			Name = "Sigils",
			T = "Sigils",
			Tx = "INV_Misc_Idol_03",
			Item = -9,
		},
		{
			Name = "Totems",
			T = "Totems",
			Tx = "INV_Misc_Idol_03",
			Item = -9,
		},
	},
	{
		Name = "Professions",
		Tx = "Trade_Tailoring",
		{
			Name = "Alchemy",
			T = "Alchemy",
			Tx = "Trade_Alchemy",
			Item = -9,
		},
		{
			Name = "Blacksmithing",
			T = "Blacksmithing",
			Tx = "Trade_Blacksmithing",
			Item = -9,
		},
		{
			Name = "Cooking",
			T = "Cooking",
			Tx = "INV_Misc_Food_15",
			Item = -9,
		},
		{
			Name = "Enchanting",
			T = "Enchanting",
			Tx = "Trade_Engraving",
			Item = -9,
		},
		{
			Name = "Engineering",
			T = "Engineering",
			Tx = "Trade_Engineering",
			Item = -9,
		},
		{
			Name = "Jewelcrafting",
			T = "Jewelcrafting",
			Tx = "INV_Misc_Gem_02",
			Item = -9,
		},
		{
			Name = "Leatherworking",
			T = "Leatherworking",
			Tx = "INV_Misc_ArmorKit_17",
			Item = -9,
		},
		{
			Name = "Tailoring",
			T = "Tailoring",
			Tx = "Trade_Tailoring",
			Item = -9,
		},
	},
	{
		Name = "Weapons",
		Tx = "Achievement_Arena_3v3_4",
		{
			Name = "One-Handed",
			Tx = "INV_Sword_04",
			{
				Name = "Daggers",
				T = "Daggers",
				Tx = "INV_Weapon_ShortBlade_01",
				Item = -9,
			},
			{
				Name = "Fist Weapons",
				T = "Fist Weapons",
				Tx = "INV_Weapon_Hand_02",
				Item = -9,
			},
			{
				Name = "One-Handed Axes",
				T = "One-Handed Axes",
				Tx = "INV_Axe_01",
				Item = -9,
			},
			{
				Name = "One-Handed Maces",
				T = "One-Handed Maces",
				Tx = "INV_Mace_04",
				Item = -9,
			},
			{
				Name = "One-Handed Swords",
				T = "One-Handed Swords",
				Tx = "INV_Sword_04",
				Item = -9,
			},
		},
		{
			Name = "Two-Handed",
			Tx = "INV_Sword_25",
			{
				Name = "Polearms",
				T = "Polearms",
				Tx = "INV_Spear_06",
				Item = -9,
			},
			{
				Name = "Staves",
				T = "Staves",
				Tx = "INV_Staff_10",
				Item = -9,
			},
			{
				Name = "Two-Handed Axes",
				T = "Two-Handed Axes",
				Tx = "INV_Axe_01",
				Item = -9,
			},
			{
				Name = "Two-Handed Maces",
				T = "Two-Handed Maces",
				Tx = "INV_Mace_04",
				Item = -9,
			},
			{
				Name = "Two-Handed Swords",
				T = "Two-Handed Swords",
				Tx = "INV_Sword_25",
				Item = -9,
			},
		},
		{
			Name = "Ranged",
			Tx = "INV_Weapon_Bow_07",
			{
				Name = "Arrows",
				T = "Arrow",
				Tx = "INV_Misc_Ammo_Arrow_01",
				Item = -9,
			},
			{
				Name = "Bullets",
				T = "Bullet",
				Tx = "INV_Misc_Ammo_Bullet_02",
				Item = -9,
			},
			{
				Name = "Bows",
				T = "Bows",
				Tx = "INV_Weapon_Bow_07",
				Item = -9,
			},
			{
				Name = "Crossbows",
				T = "Crossbows",
				Tx = "INV_Weapon_Crossbow_02",
				Item = -9,
			},
			{
				Name = "Guns",
				T = "Guns",
				Tx = "INV_Weapon_Rifle_01",
				Item = -9,
			},
			{
				Name = "Thrown",
				T = "Thrown",
				Tx = "INV_ThrowingKnife_02",
				Item = -9,
			},
			{
				Name = "Wands",
				T = "Wands",
				Tx = "INV_Wand_11",
				Item = -9,
			},
		},
	},
	{
		Name = "Creatures",
		Tx = "Spell_Frost_Stun",
		Item = -8,
	},
}
Nx.Map.Guide.ItemStatNames = {
	"",				
	"^%d - %d %s",					
	"^\tSpeed %.2f\n",
	"^+%d - %d %s\n",				
	"^(%.1f damage per second)\n",
	"Armor^%d Armor\n",
	"Block^%d Block\n",
	"Stamina",
	"Agility",
	"Strength",
	"Intellect",
	"Spirit",
	"Attack Power",
	"Spell Power",
	"Crit Rating",
	"Haste Rating",
	"Hit Rating",
	"Resilience",
	"Defense Rating",
	"Dodge Rating",
	"Parry Rating",
	"Shield Block Rating",
	"Expertise Rating",
	"Arcane Resistance",
	"Fire Resistance",
	"Frost Resistance",
	"Nature Resistance",
	"Shadow Resistance",
	"^|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Meta:16:16|t Meta Socket\n",
	"^|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Red:16:16|t Red Socket\n",
	"^|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Yellow:16:16|t Yellow Socket\n",
	"^|TInterface\\ItemSocketingFrame\\UI-EmptySocket-Blue:16:16|t Blue Socket\n",
	"",	
}
Nx.Map.Guide.ItemStatLen = {
	-3,
	-1, 3, -1, 3,
	2,	2, 2, 2, 2, 2, 2, 2, 2,
	1,
	2,
	1, 1, 1, 1, 2, 1, 1,
	1, 1, 1, 1, 1,
	0, 0, 0, 0,
	-2
}
Nx.Map.Guide.ItemStatAllowableClass = {
	"Death Knight",
	"Druid",
	"Hunter",
	"Mage",
	"Paladin",
	"Priest",
	"Rogue",
	"Shaman",
	"Warlock",
	"Warrior",
	"Monk",
}
Nx.Map.Guide.ItemStatRequiredSkill = {
	"Alchemy",
	"Blacksmithing",
	"Cooking",
	"Enchanting",
	"Engineering",
	"First Aid",
	"Fishing",
	"Herbalism",
	"Jewelcrafting",
	"Leatherworking",
	"Mining",
	"Inscription",
	"Riding",
	"Tailoring"
}
Nx.Map.Guide.ItemTypeNames = {
	"Arrow^Projectile","Bullet^Projectile","Bow^Ranged","Crossbow^Ranged","Gun^Ranged",
	"Fist Weapon","Dagger","Axe","Mace","Sword",
	"Polearm^Two-Hand","Staff^Two-Hand","Axe^Two-Hand","Mace^Two-Hand","Sword^Two-Hand",
	"Thrown^Thrown", "Wand^Ranged",
	"Idol^Relic", "Libram^Relic", "Sigil^Relic", "Totem^Relic",
	"Shield^Off Hand",
	"Cloth^1",
	"Cloth^3",
	"Cloth^5",
	"Cloth^6",
	"Cloth^7",
	"Cloth^8",
	"Cloth^9",
	"Cloth^10",
	"Cloth^16",
	"Leather^1",
	"Leather^3",
	"Leather^5",
	"Leather^6",
	"Leather^7",
	"Leather^8",
	"Leather^9",
	"Leather^10",
	"Mail^1",
	"Mail^3",
	"Mail^5",
	"Mail^6",
	"Mail^7",
	"Mail^8",
	"Mail^9",
	"Mail^10",
	"Plate^1",
	"Plate^3",
	"Plate^5",
	"Plate^6",
	"Plate^7",
	"Plate^8",
	"Plate^9",
	"Plate^10",
	"Miscellaneous^2",
	"Miscellaneous^11",
	"Miscellaneous^12",
	"Miscellaneous^23",
	"Alchemy","Blacksmithing","Cooking","Enchanting","Engineering",
	"Jewelcrafting","Leatherworking","Tailoring",
	"Food",
	"Elixir",
	"Flask",
	"Potion",
	"Death Knight",		
	"Druid",
	"Hunter",
	"Mage",
	"Paladin",
	"Priest",
	"Rogue",
	"Shaman",
	"Warlock",
	"Warrior",
	"Monk",
	"Red",					
	"Yellow",
	"Blue",
	"Orange",
	"Green",
	"Purple",
	"Meta",
	"Prismatic",
}
Nx.Map.Guide.ItemSlotNames = {
	"Head", "Neck", "Shoulder", "", "Chest",
	"Waist", "Legs", "Feet", "Wrist", "Hands",
	"Finger", "Trinket",
	[16] = "Back",
	[23] = "Off Hand",
}
function Nx.Map.Guide:ItemInit()
	self.ItemBindT = { "", L["Binds when picked up\n"], L["Binds when equipped\n"], L["Binds when used\n"] }
	self.ItemHandT = { L["One-Hand"], L["Main Hand"], L["Off Hand"] }
	self.ItemDamageT = { L["Damage"], L["Holy Damage"], L["Fire Damage"], L["Nature Damage"], L["Frost Damage"], L["Shadow Damage"], L["Arcane Damage"] }
	self.ItemTriggerT = { L["Use: "], L["Equip: "], L["Chance on hit: "], "", "", "", L["Use: "] }	-- #4 is mine for descriptions
	local folder = self:FindFolder ("Items")
	assert (folder)
	for n, data in pairs (self.ItemCats) do
		folder[n] = data	
	end
	self.ItemCats = nil
end
function Nx.Map.Guide:ItemsUpdateFolder (folder)
	if folder[1] then		
		return
	end
	self:ItemsLoad()
	local root = CarboniteItems
	if not root then
		folder[1] = { Name = L["CarboniteItems addon missing"] }
		return
	end
	if folder.Item == -8 then
		if not folder[1] then		
			self:ItemsInitCreatureFolders (folder)
		end
		return
	end
	local typs = { strsplit ("^", folder.T) }
	for _, typ in ipairs (typs) do
		local items = folder.ItemData or root[folder.Item < 0 and typ or typ .. folder.Item]
		assert (items)
		for n = 1, #items, 3 do
			local id = (strbyte (items, n) - 35) * 48841 + (strbyte (items, n + 1) - 35) * 221 + strbyte (items, n + 2) - 35
			self:ItemsAddItem (folder, id)
		end
		sort (folder, function (a, b) return a.Sort < b.Sort end)	
	end
end
function Nx.Map.Guide:ItemsInitCreatureFolders (folder)
	local cSrc = CarboniteItems["CSrc"]
	for areaName, areaData in pairs (cSrc) do
		local areaT = {}
		tinsert (folder, areaT)
		areaT.Name = strsub (areaName, 4)
		local aMin = strbyte (areaName) - 35
		local aMax = strbyte (areaName, 2) - 35
		local aGroup = strbyte (areaName, 3) - 35
		if aMin == aMax then
			areaT.Column2 = format ("%2d", aMin)
		else
			areaT.Column2 = format ("%2d-%d", aMin, aMax)
		end
		areaT.Column3 = format (L["%2d-Man"], aGroup)
		for cName, cData in pairs (areaData) do
			local cT = {}
			tinsert (areaT, cT)
			local dif = strbyte (cName)
			cName = strsub (cName, 2)
			if dif - 35 > 1 then
				cName = _TRANS(cName) .. L[" (Heroic)"]
			end
			cT.Name = cName
			cT.T = "#"
			cT.Item = -9
			cT.ItemData = cData
		end
		sort (areaT, function (a, b) return a.Name < b.Name end)	
	end
	sort (folder, function (a, b) return a.Name < b.Name end)	
end
function Nx.Map.Guide:ItemsAddItem (folder, id)
	local root = CarboniteItems
	local info, stats, statsExtra, src = strsplit ("\t", root["Items"][id])
	if not info then
		Nx.prt (L["bad %s"], id)
	end
	local flags = strbyte (info, 2) - 35
	local unique = bit.band (flags, 4) > 0
	local binding = bit.band (bit.rshift (flags, 3), 3) + 1
	local iMin = strbyte (info, 3) - 35
	local iLvl = (strbyte (info, 4) - 35) * 221 + strbyte (info, 5) - 35
	local quality = strbyte (info, 6) - 35
	local name = ""
	for n = 7, #info - 1, 2 do
		local h, l = strbyte (info, n, n + 1)
		name = name .. root.Words[(h - 35) * 221 + l - 35] .. " "
	end
	item = {}
	tinsert (folder, item)
	item.Name = Nx.QualityColors[quality] .. name
	item.Sort = name
	stats = self:ItemsUnpackStats (stats)
	statsExtra = self:ItemsUnpackStatsExtra (statsExtra, id)
	local srcStr = self:ItemsUnpackSource (src, item)
	local im = max (iMin, 0)
	item.Column2 = format ("L%2d i%3d", im, iLvl)
	item.Column3 = format ("%s", srcStr)
	local _, iLink, iRarity, lvl, minLvl, iType, subType, stackCount, equipLoc, tx = GetItemInfo (id)
	item.Link = iLink
	item.Tx = tx and gsub (tx, "Interface\\Icons\\", "") or "INV_Misc_QuestionMark"
	local typ, slot = strsplit ("^", self.ItemTypeNames[strbyte (info) - 35])
	local i = tonumber (slot)
	if i then
		slot = self.ItemSlotNames[i]
	elseif not slot then
		local i = bit.band (flags, 3)
		if i > 0 then		
			slot = self.ItemHandT[i]
		else
			slot = typ		
			typ = ""
		end
	end
	local s = item.Name .. "\n" .. self.ItemBindT[binding]
	if unique then
		s = s .. L["Unique\n"]
	end
	if iMin > 0 then	
		if bit.band (flags, 0x20) == 0 then		
			stats = stats .. format (L["Requires Level %d\n"], iMin)
		else
			stats = stats .. format (L["Quest Level %d\n"], iMin)
		end
	end
	item.Tip = format ("%s%s\n%s%s%s",
			s,
			slot .. "\t" .. typ,
			stats, statsExtra, srcStr)
	item.FilterText = item.Tip
end
function Nx.Map.Guide:ItemsUnpackStats (stats)
	if #stats == 0 then
		return ""
	end
	local sb = strbyte
	local out = ""
	local n = 1
	while n <= #stats do
		local typ = sb (stats, n) - 35
		local name, spec = strsplit ("^", self.ItemStatNames[typ] or "?")
		local val = 0
		local len = self.ItemStatLen[typ]
		if len == 1 then
			val = sb (stats, n + 1) - 35
			n = n + 2
		elseif len == 2 then
			val = (sb (stats, n + 1) - 35) * 221 + sb (stats, n + 2) - 35 - 1000
			n = n + 3
		elseif len == 3 then
			val = ((sb (stats, n + 1) - 35) * 48841 + (sb (stats, n + 2) - 35) * 221 + sb (stats, n + 3) - 35 - 1000) * .1
			n = n + 4
		elseif len == -1 then	
			local damTyp = sb (stats, n + 1) - 34		
			local damMin = (sb (stats, n + 2) - 35) * 221 + sb (stats, n + 3) - 35
			local damMax = (sb (stats, n + 4) - 35) * 221 + sb (stats, n + 5) - 35
			if damMin == damMax then
				spec = gsub (spec, " -- %%d", "")
				out = out .. format (spec, damMin, self.ItemDamageT[damTyp])
			else
				out = out .. format (spec, damMin, damMax, self.ItemDamageT[damTyp])
			end
			n = n + 6
		elseif len == -2 then	
			local skTyp = sb (stats, n + 1) - 35
			local skill = (sb (stats, n + 2) - 35) * 221 + sb (stats, n + 3) - 35
			out = out .. format (L["Requires %s (%d)\n"], self.ItemStatRequiredSkill[skTyp], skill)
			n = n + 4
		elseif len == -3 then	
			local s = ""
			local cnt = sb (stats, n + 1) - 35
			for n2 = 1, cnt do
				local cls = sb (stats, n + 1 + n2) - 35
				s = s .. format ("%s, ", self.ItemStatAllowableClass[cls])
			end
			out = out .. format (L["Classes: %s\n"], s)
			n = n + 2 + cnt
		else
			n = n + 1
		end
		if len >= 0 then
			if spec then
				out = out .. format (spec, val)
			else
				out = out .. format ("%+d %s\n", val, name)
			end
		end
	end
	return out
end
function Nx.Map.Guide:ItemsUnpackStatsExtra (stats, id)
	if #stats == 0 then
		return ""
	end
	local sb = strbyte
	local words = CarboniteItems["Words"]
	local out = ""
	local n = 1
	while n < #stats do
		local trigger = sb (stats, n) - 35
		local len = sb (stats, n + 1) - 35
		local desc = ""
		for n2 = n + 2, n + 1 + len, 2 do
			local h, l = strbyte (stats, n2, n2 + 1)
			desc = desc .. words[(h - 35) * 221 + l - 35] .. " "
		end
		out = out .. format ("|cff10f010%s%s\n", self.ItemTriggerT[trigger], desc)
		n = n + 2 + len
	end
	return out
end
function Nx.Map.Guide:ItemsUnpackSource (src, item)
	if #src == 0 then
		return ""
	end
	local itemDiff = { "", L["normal"], L["heroic"] }
	local ratesT = { ".1%", "1-2%", "3-14%", "15-24%", "25-50%", "51%-99%", "100%" }
	local s = ""
	local typ = strbyte (src, 1)
	if typ == 99 then		
		local cnt = strbyte (src, 2) - 35
		for n = 1, cnt do
		end
		local rate = ratesT[strbyte (src, 2) - 34]	
		local i = (strbyte (src, 3) - 35) * 221 + strbyte (src, 4) - 35
		local creature = CarboniteItems["Sources"][i]
		local dif = itemDiff[strbyte (creature, 1) - 34]	
		s = format (L["Creature drop: %s %s (%s)"], _TRANS(strsub (creature, 2)), dif, rate)
	elseif typ == 111 then		
		s = format (L["Container: %s"], _TRANS(strsub (src, 2)))
	elseif typ == 113 then		
		local cnt = strbyte (src, 2) - 35
		local qs = ""
		for n = 1, cnt do
			if n > 1 then
				qs = qs .. ", "
			end
			local i = n * 2
			local id = (strbyte (src, 1 + i) - 35) * 221 + strbyte (src, 2 + i) - 35
			local q = Nx.Quest.IdToQuest[id]
			if q then
				item.QId = id
				local qName, _, lvl = Nx.Quest:Unpack (q[1])
				qs = qs .. format ("[%d] %s", lvl, qName)
			else
				qs = qs .. id
			end
		end
		s = format (L["Quest: %s"], qs)
	elseif typ == 115 then		
		s = format (L["Spell"])
	elseif typ == 118 then		
		local cnt = strbyte (src, 2) - 35
		local i = (strbyte (src, 3) - 35) * 221 + strbyte (src, 4) - 35
		local vendor = CarboniteItems["Sources"][i]
		s = format (L["Vendor: %s"], _NPC(vendor))
		if cnt > 4 then
			s = s .. " (" .. cnt .. L[" Total)"]
		end
	elseif typ == 119 then		
		if #src == 1 then
			return L["World drop"]
		end
		local maxRate = ratesT[strbyte (src, 2) - 34]	
		local cnt = strbyte (src, 3) - 35
		s = format (L["World drop: %s (%s)"], strsub (src, 4), maxRate)
		if cnt > 1 then
			s = s .. " (" .. cnt .. L[" Total)"]
		end
	else
		s = format ("%s?", typ)
	end
	return "|cff8080e0" .. s
end
function Nx.Map.Guide:ItemsLoad()
	if CarboniteItems then
		return
	end
	if not LoadAddOn ("CarboniteItems") then
		Nx.prt (L["CarboniteItems addon could not be loaded!"])
		return
	end
	if not CarboniteItems then
		Nx.prt (L["CarboniteItems addon error!"])
		return
	end
	Nx.prt (L["CarboniteItems loaded"])
end
function Nx.Map.Guide:ItemsFree()
	local folder = self:FindFolder ("Items")
	self:ItemsFreeChildren (folder)
	collectgarbage ("collect")
end
function Nx.Map.Guide:ItemsFreeChildren (folder)
	for n, v in ipairs (folder) do
		if folder.Item and folder.Item ~= -8 then
			folder[n] = nil
		else
			self:ItemsFreeChildren (v)
		end
	end
end
-------------------------------------------------------------------------------
-- EOF














