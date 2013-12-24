local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
--local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxFav - Favorites window
-- Copyright 2008-2012 Carbon Based Creations, LLC
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

function Nx.Fav:Init()

	self.Folders = Nx.GetFav()

--[[
	local def = { "Default", "Quests" }

	for k, name in ipairs (def) do

		local found
		for k, folder in ipairs (self.Folders) do
			if folder["T"] == "F" then
				if folder["Name"] == name then
					found = true
				end
			end
		end

		if not found then
			local folder = self:AddFolder (name)
		end
	end
--]]

	self.NoteIcons = { "Star", "Circle", "Diamond", "Triangle", "Moon", "Square", "Cross", "Skull" }
end

function Nx.Fav:GetIconInline (index)
	local file = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. index
	return format ("|T%s:16|t", file)
end

function Nx.Fav:GetIconFile (index)
	return "Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. index
end

--------
-- Create favorites window

function Nx.Fav:Create()

	self.Side = 1

	-- Create Window

	local win = Nx.Window:Create ("NxFav", 240, nil, nil, 1)
	self.Win = win
	win.Frm.NxInst = self

	win:CreateButtons (true, true)
	win:SetTitleLineH (18)
	win:SetTitleXOff (220)

	win:InitLayoutData (nil, -.23, -.25, -.54, -.5)
	win.Frm:SetToplevel (true)

	win:Show (false)

	tinsert (UISpecialFrames, win.Frm:GetName())

	-- Buttons

	local bw, bh = win:GetBorderSize()

	local but = Nx.Button:Create (win.Frm, "Txt64B", L["Record"], nil, bw + 1, -bh, "TOPLEFT", 44, 20, self.But_OnRecord, self)
	self.RecBut = but

	local but = Nx.Button:Create (win.Frm, "Txt64", L["Up"], nil, bw + 48, -bh, "TOPLEFT", 40, 20, self.But_OnUp, self)
	local but = Nx.Button:Create (but.Frm, "Txt64", L["Down"], nil, 42, 0, "TOPLEFT", 40, 20, self.But_OnDown, self)
	Nx.Button:Create (but.Frm, "Txt64", L["Delete Item"], nil, 54, 0, "TOPLEFT", 72, 20, self.But_OnItemDel, self)

	-- Folder List

	Nx.List:SetCreateFont ("FontM", 16)

	local list = Nx.List:Create ("FavF", 0, 0, 1, 1, win.Frm)
	self.List = list

	list:SetUser (self, self.OnListEvent)

	list:SetLineHeight (4)

	list:ColumnAdd ("", 1, 20)
	list:ColumnAdd (L["Name"], 2, 900)

	win:Attach (list.Frm, 0, .3, 0, 1)

	-- Item List

	Nx.List:SetCreateFont ("FontM", 16)

	local list = Nx.List:Create (L["FavI"], 0, 0, 1, 1, win.Frm)
	self.ItemList = list

	list:SetUser (self, self.OnItemListEvent)

	list:SetLineHeight (2)

	list:ColumnAdd ("", 1, 17)
	list:ColumnAdd (L["Type"], 2, 90)
	list:ColumnAdd (L["Value"], 3, 250)
	list:ColumnAdd (L["Location"], 4, 900)

	win:Attach (list.Frm, .3, 1, 0, 1)			-- 18, 1 with editbox

	-- Filter Edit Box

--	self.EditBox = Nx.EditBox:Create (win.Frm, self, self.OnEditBox, 30)

--	win:Attach (self.EditBox.Frm, .3, 1, 0, 18)

	--

	self:CreateMenu()

	--

	self:Update()

	self.List:FullUpdate()
end

--------

function Nx.Fav:But_OnRecord (but)
	self:SetRecord (but:GetPressed())
end

function Nx.Fav:SetRecord (on)

	local but = self.RecBut

	if on then
		if self.CurFav then
			self.Recording = self.CurFav
			self.RecAlphaAnim = 1000
			Nx.Timer:Start ("FavRec", 0, self, self.RecordAnimTimer)
			but:SetPressed (true)
		else
			Nx.prt (L["Select a favorite before recording"])
			but:SetPressed (false)
		end
	else
		self.Recording = nil
		but:SetAlpha (1)
		but:SetPressed (false)
	end
end

function Nx.Fav:RecordAnimTimer()

	if self.Recording then
		local a = (self.RecAlphaAnim - 35) % 1000
		self.RecAlphaAnim = a
		self.RecBut:SetAlpha (abs (a - 500) / 1000 + .5)
		return .05
	end
end

function Nx.Fav:But_OnUp()
	self:MoveCur (true)
end

function Nx.Fav:But_OnDown()
	self:MoveCur()
end

function Nx.Fav:MoveCur (low)

	if self.Side == 1 then

		local item = self.CurFavOrFolder
		if item then

			local parent = self:GetParent (item)

			Nx.Util_TMoveItem (parent, item, low)

			local i = self:FindListI (item)
			if i > 0 then
				self.List:Select (i + 1)		-- Add one for "Root" entry
			end
		end
	else
		local fav = self.CurFav
		if fav and self.CurItemI then
			local i = Nx.Util_TMoveI (fav, self.CurItemI, low)
			if i then
				self.CurItemI = i
				self.ItemList:Select (i)
			end
		end
	end

	self:Update()
end

function Nx.Fav:But_OnItemDel()

	local fav = self.CurFav
	if fav and self.CurItemI then
		if fav[self.CurItemI] then
			tremove (fav, self.CurItemI)
		end
	end

	self:Update()
end

--------
-- Create menu

function Nx.Fav:CreateMenu()

	local menu = Nx.Menu:Create (self.List.Frm, 250)
	self.Menu = menu

	menu:AddItem (0, L["Add Folder"], self.Menu_OnAddFolder, self)
	menu:AddItem (0, L["Add Favorite"], self.Menu_OnAddFavorite, self)
	menu:AddItem (0, "")
	menu:AddItem (0, L["Rename"], self.Menu_OnRename, self)
	menu:AddItem (0, L["Cut"], self.Menu_OnCut, self)
	menu:AddItem (0, L["Copy"], self.Menu_OnCopy, self)
	menu:AddItem (0, L["Paste"], self.Menu_OnPaste, self)

	local function func()
		Nx.Opts:Open ("Favorites")
	end

	menu:AddItem (0, "")
	menu:AddItem (0, L["Options..."], func)

	local menu = Nx.Menu:Create (self.List.Frm, 250)
	self.ItemMenu = menu

	menu:AddItem (0, L["Add Comment"], self.IMenu_OnAddComment, self)
	menu:AddItem (0, "")
	menu:AddItem (0, L["Rename"], self.IMenu_OnRename, self)
	menu:AddItem (0, L["Cut"], self.IMenu_OnCut, self)
	menu:AddItem (0, L["Copy"], self.IMenu_OnCopy, self)
	menu:AddItem (0, L["Paste"], self.IMenu_OnPaste, self)

	menu:AddItem (0, "")
	menu:AddItem (0, L["Set Icon"], self.IMenu_OnSetIcon, self)
end

function Nx.Fav:Menu_OnAddFolder (item)

	local function func (str, self)
		self:AddFolder (str, self.CurFolder)
		self:Update()
	end

	Nx:ShowEditBox ("Name", "", self, func)
end

function Nx.Fav:Menu_OnAddFavorite (item)

	local function func (str, self)
		self:AddFavorite (str, self.CurFolder)
		self:Update()
	end

	Nx:ShowEditBox ("Name", "", self, func)
end

function Nx.Fav:Menu_OnRename (item)

	local function func (str, self)
		if self.CurFavOrFolder then
			self.CurFavOrFolder["Name"] = str
			self:Update()
		end
	end

	if self.CurFavOrFolder then
		local name = self.CurFavOrFolder["Name"]
		Nx:ShowEditBox ("Name", name, self, func)
	end
end

function Nx.Fav:Menu_OnCut()

	local item = self.CurFavOrFolder
	if item then

		local parent = self:GetParent (item)

		for i, it in ipairs (parent) do
			if it == item then
				tremove (parent, i)
				self.CopyBuf = item
				self:Update()
			end
		end

		self:SelectCur()
	end
end

function Nx.Fav:Menu_OnCopy()

	local item = self.CurFavOrFolder
	if item then
		self.CopyBuf = Nx.Util_TCopyRecurse (item)
	end
end

function Nx.Fav:Menu_OnPaste()

	if not self.CopyBuf then
		Nx.prt (L["Nothing to paste"])
		return
	end

	if type (self.CopyBuf) ~= "table" then
		Nx.prt (L["Can't paste that on the left side"])
		return
	end

	local new = Nx.Util_TCopyRecurse (self.CopyBuf)
	local item = self.CurFav

	if item then
		local parent = self:GetParent (item)
		local i = Nx.Util_TFindItemI (parent, item)
		tinsert (parent, i, new)
	else
		tinsert (self.CurFolder, 1, new)
	end

	self:Update()
	self:SelectCur()
end

--------

function Nx.Fav:IMenu_OnAddComment()

	local function func (str, self)
		local s = self:CreateItem ("", 0, str)
		self:AddItem (self.CurFav, self.CurItemI, s)
	end

	Nx:ShowEditBox ("Name", "", self, func)
end

function Nx.Fav:IMenu_OnRename()

	local function func (str, self)
		if self.CurFavOrFolder then
			self:SetItemName (self.CurItemI, str)
			self:Update()
		end
	end

	local typ, name = self:GetItemTypeName (self.CurItemI)
	Nx:ShowEditBox ("Name", name, self, func)
end

function Nx.Fav:IMenu_OnCut()
	local fav = self.CurFav
	if fav and self.CurItemI then

		if fav[self.CurItemI] then
			self.CopyBuf = fav[self.CurItemI]
			tremove (fav, self.CurItemI)
		end
	end

	self:Update()
end

function Nx.Fav:IMenu_OnCopy()
	local fav = self.CurFav
	if fav then
		self.CopyBuf = fav[self.CurItemI]
	end
end

function Nx.Fav:IMenu_OnPaste()

	if not self.CopyBuf then
		Nx.prt (L["Nothing to paste"])
		return
	end

	if type (self.CopyBuf) ~= "string" then
		Nx.prt (L["Can't paste that on the right side"])
		return
	end

	local fav = self.CurFav
	if fav then
		local i = min (self.CurItemI, #fav) + 1
		tinsert (fav, i, self.CopyBuf)
	end

	self:Update()
end

function Nx.Fav:IMenu_OnSetIcon()

	Nx.DropDown:Start (self, self.SetIconAccept)

	for i, name in ipairs (self.NoteIcons) do

		local iconStr = self:GetIconInline (i)
		local s = format ("%s %s", iconStr, name)

		Nx.DropDown:Add (s, false)
	end

	Nx.DropDown:Show (self.Win.Frm)
end

function Nx.Fav:SetIconAccept (name, sel)

	local fav = self.CurFav
	local index = self.CurItemI

	if fav and index then

		local item = fav[index]
		local typ, flags, name, data = self:ParseItem (item)

		flags = strbyte (flags) - 35

		if typ == "N" then
			local icon, id, x, y = self:ParseItemNote (data)
			fav[index] = self:CreateItem ("N", flags, name, sel, id, x, y)

			self:Update()
		end
	end
end

--------
-- Show or hide

function Nx:NXFavKeyToggleShow()
	Nx.Fav:ToggleShow()
end

--------
-- Show or hide

function Nx.Fav:ToggleShow()
	Nx.Sec:ValidateMsg()
end

--------
-- Show or hide window

function Nx.Fav:ToggleShow_()

	if not self.Win then
		self:Create()
	end

	self.Win:Show (not self.Win:IsShown())

	if self.Win:IsShown() then
		self:Update()
	end
end

--------
-- Handle item list filter edit box

function Nx.Fav:OnEditBox (editbox, message)

	if message == "Changed" then
		self:Update()
	end
end

--------
-- On list events

function Nx.Fav:OnListEvent (eventName, sel, val2, click)

--	Nx.prt ("Guide list event "..eventName)

	local data = self.List:ItemGetData (sel)

	if not data then
		self.CurFolder = self.Folders
		self.CurFav = nil
	else
		if data["T"] == "F" then
			self.CurFolder = data
			self.CurFav = nil
		else
			self.CurFolder = self:GetParent (data)
			self.CurFav = data
			self:SelectItems (1)
		end
	end

	self.CurFavOrFolder = data	-- This is nil if root

	self.Side = 1

	if eventName == "select" or eventName == "mid" or eventName == "menu" then

		if eventName == "menu" then
			self.Menu:Open()
		end

		self:Update()

	elseif eventName == "button" then	-- Button icon

		self.List:Select (sel)

		if data then

			if data["Hide"] then
				data["Hide"] = nil
			else
				data["Hide"] = true
			end

			self:Update()
		end
	end
end

--------
-- On item list events

function Nx.Fav:OnItemListEvent (eventName, sel, val2, click)

--	Nx.prt ("List event "..eventName)

	local list = self.ItemList	

	local item = list:ItemGetData (sel)

	self.CurItemI = sel
	self.Side = 2

	if eventName == "select" or eventName == "mid" or eventName == "menu" then

		if eventName == "menu" then
			self.ItemMenu:Show (self.CurFav and true or -1)
			self.ItemMenu:Open()
		end

	elseif eventName == "button" then	-- Button icon

		local flags = val2 and 1 or 0		-- Pressed
		self:SetItemFlags (sel, 0xfe, flags)

	end

	self:SelectItems (sel)
	self:Update()
end

--------
-- Update Fav

function Nx.Fav:Update()

	self.Draw = false		-- Force map to update icons

	local Nx = Nx

	if not self.Win then
		return
	end

	-- List

	local list = self.List

	list:Empty()

	list:ItemAdd()
	list:ItemSet (2, L["|cff808080Root"])

	self.FavCnt = 0

	self:UpdateFolder (self.Folders, 1)

	list:Update()

	-- Right side list

	self:UpdateItems()

	-- Title

	self.Win:SetTitle (format (L["Favorites: %s"], self.FavCnt))
end

function Nx.Fav:UpdateFolder (folder, level)

	local list = self.List

	local hide = folder["Hide"]

	if level > 1 then
		list:ItemAdd (folder)
		local space = strrep ("  ", level - 1)
		list:ItemSet (2, format ("%s%s", space, folder["Name"]))
		list:ItemSetButton ("QuestHdr", hide)
	end

	if not hide then

		local space = strrep ("  ", level)

		for index, item in ipairs (folder) do

			local typ = item["T"]
			local name = item["Name"]

			if typ == "F" then
				self:UpdateFolder (item, level + 1)
			else

				self.FavCnt = self.FavCnt + 1

				list:ItemAdd (item)
				list:ItemSet (2, format ("%s|cffdfdfdf%s", space, name))

				if self.FavToSelect == item then
					self.FavToSelect = nil
					list:Select (list:ItemGetNum())
				end
			end
		end
	end
end

function Nx.Fav:UpdateItems (selectI)

	local list = self.ItemList

	if not list then
		return
	end

	list:Empty()

	if self.CurFav then

		for index, str in ipairs (self.CurFav) do

			local typ, flags, name, data = self:ParseItem (str)

			list:ItemAdd (item)
			list:ItemSetButton ("Chk", bit.band (strbyte (flags) - 35, 1) > 0)

			if typ == "" then			-- Comment
				list:ItemSet (3, format ("|cffa0a0a0-- %s", name))

			elseif typ == "N" then			-- Note

				local icon, id, x, y = self:ParseItemNote (data)
				icon = self:GetIconInline (icon)
				id = Nx.MapIdToName[id] or "?"

				list:ItemSet (2, "Note:")
				list:ItemSet (3, format ("%s %s", icon, name))
				list:ItemSet (4, format ("|cff80ef80(%s %.1f %.1f)", id, x, y))

			elseif typ == "T" or typ == "t" then			-- Target

				local typName = typ == "T" and "Target 1st" or "Target"

				local mapId, x, y = self:ParseItemTarget (data)
				local mapName = Nx.MapIdToName[mapId] or "?"

				list:ItemSet (2, format ("%s:", typName))
				list:ItemSet (3, format ("%s", name))
				list:ItemSet (4, format ("|cff80ef80(%s %.1f %.1f)", mapName, x, y))
			end
		end
	end

	if selectI then
		list:Select (selectI)
	end

	list:Update()
end

--------
-- Select current favorite

function Nx.Fav:SelectCur()

	self.List:SendUserSelect()
	self:SelectItems (1)
end

--------
-- Get the parent of the item
-- (item, folder to start search or nil for root)

function Nx.Fav:GetParent (item, folder)

	folder = folder or self.Folders

	for _, it in ipairs (folder) do

		if it == item then
			return folder
		end

		local typ = it["T"]
		if typ == "F" then
			local v = self:GetParent (item, it)
			if v then
				return v
			end
		end
	end
end

--------
-- Find a folder by name
-- (name)

function Nx.Fav:FindFolder (name, parent)

	parent = parent or self.Folders

	for _, item in ipairs (parent) do

		if item["T"] == "F" then
			if item["Name"] == name then
				return item
			end
		end
	end
end

--------
-- Find a favorite by a variable name
-- (name)

function Nx.Fav:FindFav (val, varName, parent)

	parent = parent or self.Folders

	for _, item in ipairs (parent) do

		if item["T"] == nil then
			if item[varName] == val then
				return item
			end
		end
	end
end

--------
-- 
-- (item)

function Nx.Fav:OpenFoldersToFav (item, folder)

	folder = folder or self.Folders

	for index, it in ipairs (folder) do

		if it == item then
			return index
		end

		if it["T"] == "F" then

			index = self:OpenFoldersToFav (item, it)

			if index then	-- Found?
				it["Hide"] = nil
				return index
			end
		end
	end
end

--------
-- Find the index where an item would be in list
-- (item)

function Nx.Fav:FindListI (item, folder, index)

	folder = folder or self.Folders
	index = index or 1

	for _, it in ipairs (folder) do

		if it == item then
			return index
		end

		index = index + 1

		if it["T"] == "F" then
			if not it["Hide"] then
				index = self:FindListI (item, it, index)
				if index > 0 then	-- Found?
					return index
				end
				index = -index
			end
		end
	end

	return -index		-- Failed
end

function Nx.Fav:AddFolder (name, parent, index)

	local folder = {}
	folder["Name"] = name
	folder["T"] = "F"

	parent = parent or self.Folders

	if parent then
		index = index or #parent + 1
		tinsert (parent, index, folder)
	end

	return folder
end

function Nx.Fav:AddFavorite (name, parent, index)

	local fav = {}
	fav["Name"] = name

	parent = parent or self.Folders

	if parent then
		index = index or #parent + 1
		tinsert (parent, index, fav)
	end

	return fav
end

function Nx.Fav:AddItem (fav, index, item)

--	Nx.prt ("Fav AddItem %s #%s %s", fav["Name"], index or "nil", item)

	if fav then

		local i = max (min (index or 999999, #fav), 0) + 1
		tinsert (fav, i, item)

		self:SelectItems (i)
	end
end

function Nx.Fav:CreateItem (typ, flags, name, p1, p2, p3, p4)

	flags = flags + 35

	name = gsub (name, "[~^]", "")
	name = gsub (name, "\n", " ")

	if typ == "" then			-- Comment
		return format ("~%c~%s", flags, name)

	elseif typ == "N" then	-- Note

		local id = Nx.MapIdToNxzone[p2]
		s = self:MakeXY (p3, p4)
		return format ("N~%c~%s~%c%03x%s", flags, name, p1 + 35, id, s)

	elseif typ == "T" or typ == "t" then	-- Target

		local id = Nx.MapIdToNxzone[p1]
		s = self:MakeXY (p2, p3)
		return format ("%s~%c~%s~%03x%s", typ, flags, name, id, s)

	end
end

function Nx.Fav:MakeXY (x, y)
	local s = Nx:PackXY (x, y % 100)
	return s .. strchar (floor (y / 100) + 35)	-- Add dungeon level to end
end

function Nx.Fav:ParseItem (item)
	if item then
		return strsplit ("~", item)	-- Type~Flags (# based)~Name~Data
	end
end

function Nx.Fav:ParseItemNote (data)
	local iconI = strbyte (data, 1) - 35
	local zone, id, x, y, dLvl
	if(strlen(data) == 11) then
		zone = tonumber (strsub (data, 2, 4), 16)
		id = Nx.NxzoneToMapId[zone]
		x = tonumber (strsub (data, 5, 7), 16) / 4090 * 100
		y = tonumber (strsub (data, 8, 10), 16) / 4090 * 100
		dLvl = (strbyte (data, 11) or 35) - 35
	else
		zone = tonumber (strsub (data, 2, 3), 16)
		id = Nx.NxzoneToMapId[zone]
		x = tonumber (strsub (data, 4, 6), 16) / 4090 * 100
		y = tonumber (strsub (data, 7, 9), 16) / 4090 * 100
		 dLvl = (strbyte (data, 10) or 35) - 35
	end
	return iconI, id, x, y + dLvl * 100
end

function Nx.Fav:ParseItemTarget (data)
	local zone, id, x, y, dLvl

	if(strlen(data) == 9) then
		zone = tonumber (strsub (data, 1, 2), 16)
		id = Nx.NxzoneToMapId[zone]
		x = tonumber (strsub (data, 3, 5), 16) / 4090 * 100
		y = tonumber (strsub (data, 6, 8), 16) / 4090 * 100
		dLvl = (strbyte (data, 9) or 35) - 35
	else
		local zone = tonumber (strsub (data, 1, 3), 16)
		local id = Nx.NxzoneToMapId[zone]
		local x = tonumber (strsub (data, 4, 6), 16) / 4090 * 100
		local y = tonumber (strsub (data, 7, 9), 16) / 4090 * 100
		local dLvl = (strbyte (data, 10) or 35) - 35
	end
	return id, x, y + dLvl * 100
end

function Nx.Fav:GetItemTypeName (index)

	local fav = self.CurFav
	if fav then
		local typ, flags, name = strsplit ("~", fav[index])
		return typ, name
	end
end

function Nx.Fav:SetItemFlags (index, mask, orFlags)

	local fav = self.CurFav
	if fav then
		local typ, flags, name, data = strsplit ("~", fav[index])

		flags = bit.bor (bit.band (strbyte (flags) - 35, mask), orFlags) + 35

		if data then
			fav[index] = format ("%s~%c~%s~%s", typ, flags, name, data)
		else
			fav[index] = format ("%s~%c~%s", typ, flags, name)
		end
	end
end

function Nx.Fav:SetItemName (index, name)

	name = gsub (name, "[~^]", "")
	name = gsub (name, "\n", " ")

	local fav = self.CurFav
	if fav then
		local typ, flags, _, data = strsplit ("~", fav[index])
		if data then
			fav[index] = format ("%s~%s~%s~%s", typ, flags, name, data)
		else
			fav[index] = format ("%s~%s~%s", typ, flags, name)
		end
	end
end

--------
-- Select items in item list

function Nx.Fav:SelectItems (index)

	if self.CurFav then

		if self.Recording ~= self.CurFav then
			self:SetRecord (false)
		end

		self.CurItemI = min (index, #self.CurFav)

		self:UpdateItems (self.CurItemI)

		self:UpdateTargets()
	end
end

-------------------------------------------------------------------------------

function Nx.Fav:Record (typ, name, id, x, y)

	if self.InUpdateTarget then
		return
	end

	local fav = self.Recording

	self.RecId = id
	self.RecX = x
	self.RecY = y

	if typ == "Note" then

		local function func (name, self)
			local fav = self.Recording or self:GetNoteFav (self.RecId)
			local s = self:CreateItem ("N", 0, name, 1, self.RecId, self.RecX, self.RecY)
			self:AddItem (fav, self.CurItemI, s)
			self:Update()
		end

		Nx:ShowEditBox ("Name", name, self, func)

	elseif typ == "TargetS" then	-- Start

		local fav = self.Recording
		if fav then
			local s = self:CreateItem ("T", 0, name, self.RecId, self.RecX, self.RecY)
			self:AddItem (fav, self.CurItemI, s)
			self:Update()
		end

	elseif typ == "Target" then

		local fav = self.Recording
		if fav then
			local s = self:CreateItem ("t", 0, name, self.RecId, self.RecX, self.RecY)
			self:AddItem (fav, self.CurItemI, s)
			self:Update()
		end
	end
end

function Nx.Fav:GetNoteFav (mapId)

	local notes = self:FindFolder ("Notes")

	if not notes then
		notes = self:AddFolder ("Notes")
	end

	local name = Nx.Map:IdToName (mapId)

	local fav = self:FindFav (name, "Name", notes)

	if not fav then
		fav = self:AddFavorite (name, notes)
		fav["ID"] = mapId
		sort (notes, function (a, b) return a["Name"] < b["Name"] end)
	end

	return fav
end

function Nx.Fav:SetNoteAtStr (str)

	local words = {}
	local quote
	local strDone
	local curStr = ""

	for s in gmatch (str, ".") do

--		Nx.prt ("%s", s)

		if s == quote then
			quote = false
			strDone = true

		elseif not quote and (s == '"' or s == "'") then
			quote = s

		elseif s == ' ' and not quote then
			strDone = true

		else
			curStr = curStr .. s
		end

		if strDone then
			if #curStr > 0 then
				tinsert (words, curStr)
			end
			strDone = false
			curStr = ""
		end
	end

	if #curStr > 0 then
		tinsert (words, curStr)
	end

	--

	local map = Nx.Map:GetMap (1)

	local mId = map.RMapId
	local zx, zy = map.PlyrRZX, map.PlyrRZY

	if #words > 1 then
		mId, zx, zy = map:ParseTargetStr (table.concat (words, " ", 2))
	end

	if mId then
		local fav = self.Recording or self:GetNoteFav (mId)
		local s = self:CreateItem ("N", 0, words[1] or "", 1, mId, zx, zy)
		self:AddItem (fav, nil, s)
		self:Update()
	end
end

--------
-- Show note in window

function Nx.Fav:ShowIconNote (icon)

	local fav, index = Nx.Map:GetIconFavData (icon)

	self:OpenFoldersToFav (fav)
	self.FavToSelect = fav

	self.CurFolder = self:GetParent (fav)
	self.CurFav = fav
	self.CurItemI = index

	self.CurFavOrFolder = fav

	if not (self.Win and self.Win:IsShown()) then
		self:ToggleShow()
		if not self.Win then		-- Not validated?
			return
		end
	else
		self:Update()
	end

	self:SelectItems (index)
end

function Nx.Fav:UpdateTargets()

	local shown = self.Win and self.Win:IsShown()

	if self.CurFav and self.CurItemI	and (self.Recording or shown) then

		self.InUpdateTarget = true

		local map = Nx.Map:GetMap (1)

		local keep

		for n = self.CurItemI, #self.CurFav do

			local str = self.CurFav[n]
			local typ, flags, name, data = self:ParseItem (str)

			if typ == "T" then

				if n ~= self.CurItemI then		-- Another 1st target?
					break
				end

				local mapId, x, y = self:ParseItemTarget (data)
				map:SetTargetXY (mapId, x, y, name, keep)
				keep = true

			elseif typ == "t" then

				local mapId, x, y = self:ParseItemTarget (data)
				map:SetTargetXY (mapId, x, y, name, keep)
				keep = true

			else

				break
			end
		end

		if keep then	-- Had a target?
			map:GotoPlayer()
		end

		self.InUpdateTarget = false
	end
end

--------
--

function Nx.Fav:UpdateIcons()

	local Quest = Nx.Quest
	local Map = Nx.Map
	local map = Map:GetMap (1)

	if self.CurFav and self.CurItemI then

		map:InitIconType ("!Fav2", "WP", "", 21, 21)

		local str = self.CurFav[self.CurItemI]

		local typ, flags, name, data = self:ParseItem (str)

		if typ == "N" then

			local icon, mapId, x, y = self:ParseItemNote (data)
			icon = self:GetIconFile (icon)
			local wx, wy = Map:GetWorldPos (mapId, x, y)

			local icon = map:AddIconPt ("!Fav2", wx, wy, nil, icon)
			map:SetIconTip (icon, L["Note: "] .. name)
			map:SetIconFavData (icon, self.CurFav, self.CurItemI)

			map:SetIconTypeAlpha ("!Fav2", abs ((GetTime() * 100 % 100 - 50) / 50))
		end

	else
		map:ClearIconType ("!Fav2")
	end

	local mapId = map.MapId
	local draw = map.ScaleDraw > .3 and map.GOpts["MapShowNotes"]

	if mapId == self.DrawMapId and draw == self.Draw then
		return
	end

	self.DrawMapId = mapId
	self.Draw = draw

	map:InitIconType ("!Fav", "WP", "", 17, 17)
--	map:SetIconTypeAlpha ("!Fav", map.GOpts["MapIconFavAlpha"])

	if not draw then
		return
	end

	local cont = map:IdToContZone (mapId)

--	Nx.prt ("mapid %s, cont %s", mapId, cont)

	if cont > 0 and cont < 9 then

		local notes = self:FindFolder ("Notes")

		if notes then

			local fav = self:FindFav (mapId, "ID", notes)
			if fav then

				for n, str in ipairs (fav) do

					local typ, flags, name, data = self:ParseItem (str)

					if typ == "N" then

						local icon, _, x, y = self:ParseItemNote (data)
						icon = self:GetIconFile (icon)
						local wx, wy = Map:GetWorldPos (mapId, x, y)

						local icon = map:AddIconPt ("!Fav", wx, wy, nil, icon)

						map:SetIconTip (icon, L["Note: "] .. name)
						map:SetIconFavData (icon, fav, n)
					end
				end
			end
		end
	end
end

-------------------------------------------------------------------------------

function Nx.Fav:CartImportNotes()

	local notes = Cartographer_Notes
	local pois

	if notes then
		local db = notes["db"]
		if db then
			local account = db["account"]
			if account then
				pois = account["pois"]
			end
		end
	end

	if not pois then
		Nx.prt (L["Cartographer notes missing"])
		return
	end

	local getXY = notes["getXY"]
	if not getXY then
		Nx.prt (L["Cartographer getXY missing"])
		return
	end

	local importCnt = 0

	for zName, zData in pairs (pois) do

		if type (zData) == "table" then

			for id, data in pairs (zData) do

				local mId = Nx.MapNameToId[zName]
				if not mId then
					Nx.prt (L["Unknown zone %s"], zName)

				else

					importCnt = importCnt + 1

					local x, y = getXY (id)
					local iconStr = data["icon"]
					local name = data["title"] or iconStr or ""	-- Use icon text if missing

					local icon = 1

					for i, iName in ipairs (self.NoteIcons) do
						if iName == iconStr then
							icon = i
						end
					end

					local fav = self:GetNoteFav (mId)
					local s = self:CreateItem ("N", 0, name, icon, mId, x * 100, y * 100)
					self:AddItem (fav, nil, s)

					Nx.prt (L["Import %s %s %s %s %s"], name, zName, mId, x, y)
				end
			end
		end
	end

	Nx.prt (L["Imported %s notes"], importCnt)

	self:Update()
end

-------------------------------------------------------------------------------
-- EOF














