local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxWarehouse - Warehouse inventory tracker
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

--------

function Nx.Warehouse:Init()

	self.Enabled = Nx:GetGlobalOpts()["WarehouseEnable"]

	self.SkillRiding = 0

	self.ClassIcons = {
		["Druid"] = "Ability_Druid_Maul",
		["Hunter"] = "INV_Weapon_Bow_07",
		["Mage"] = "INV_Staff_13",
		["Paladin"] = "INV_Hammer_01",
		["Priest"] = "INV_Staff_30",
		["Rogue"] = "INV_ThrowingKnife_04",
		["Shaman"] = "Spell_Nature_BloodLust",
		["Warlock"] = "Spell_Nature_FaerieFire",
		["Warrior"] = "INV_Sword_27",
		["Death Knight"] = "Spell_Deathknight_ClassIcon",
		["Monk"] = "class_monk",
	}

	self.InvNames = {
		"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot",
		"ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
		"Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot",
		"MainHandSlot", "SecondaryHandSlot", "AmmoSlot",	-- "RangedSlot" removed 5.0
		"Bag0Slot", "Bag1Slot", "Bag2Slot", "Bag3Slot" 
	}

--	self.LProfessions = TRADE_SKILLS
--	self.LSecondarySkills = gsub (SECONDARY_SKILLS, ":", "")

	self.ItemTypes = NXlItemTypes

	self.RidingSpells = {
		[75] = GetSpellInfo (33389) or "",
		[150] = GetSpellInfo (33392) or "",
		[225] = GetSpellInfo (34092) or "",		-- Expert
		[300] = GetSpellInfo (34093) or "",		-- Artisan
		[375] = GetSpellInfo (90265) or "",		-- Master
	}

	-- Create durability scanner tooltip

	self.DurInvNames = {
		"HeadSlot", "ShoulderSlot", "ChestSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot",
		"MainHandSlot", "SecondaryHandSlot"		-- "RangedSlot" removed 5.0
	}

	self.DurTooltipFrm = CreateFrame ("GameTooltip", "NxTooltipD", UIParent, "GameTooltipTemplate")
	self.DurTooltipFrm:SetOwner (UIParent, "ANCHOR_NONE")		-- We won't see with this anchor
end

--------
-- Debug print

function Nx.Warehouse:prtdb (...)
	if self.Debug then
		Nx.prt (...)
	end
end

--------
-- Create warehouse window

function Nx.Warehouse:Create()

--PAIDS!

	if not self.Enabled then
		return
	end

	self.SelectedChar = 1
--	self.SelectedProf = nil

	self.ShowItemCategory = true

	-- Create Window

	local win = Nx.Window:Create ("NxWarehouse", nil, nil, nil, 1)
	self.Win = win
	win.Frm.NxInst = self

	win:CreateButtons (true, true)

	win:InitLayoutData (nil, -.25, -.15, -.5, -.6)
	win.Frm:SetToplevel (true)

	win:Show (false)

	tinsert (UISpecialFrames, win.Frm:GetName())

	-- Back button

--	but = Nx.Button:Create (win.Frm, "Txt", "Back", nil, 0, 0, "TOPLEFT", 100, 16, self.But_OnBack, g)

--	win:Attach (but.Frm, 2, 2+40, 1.01, 11)

	-- Character List

	Nx.List:SetCreateFont ("FontM", 16)

	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm)
	self.List = list

	list:SetUser (self, self.OnListEvent)

	list:SetLineHeight (4)

	list:ColumnAdd ("", 1, 24)
	list:ColumnAdd (L["Name"], 2, 900)

	win:Attach (list.Frm, 0, .5, 0, 1)

	-- Item List

	Nx.List:SetCreateFont ("FontWarehouseI", 16)

	local list = Nx.List:Create (false, 0, 0, 1, 1, win.Frm)
	self.ItemList = list

	list:SetUser (self, self.OnItemListEvent)

--	list:SetLineHeight (3)

	list:ColumnAdd ("", 1, 17)
	list:ColumnAdd ("", 2, 35, "RIGHT", "FontS")
	list:ColumnAdd ("", 3, 900)

	win:Attach (list.Frm, .5, 1, 18, 1)

	-- Filter Edit Box

	self.EditBox = Nx.EditBox:Create (win.Frm, self, self.OnEditBox, 30)

	win:Attach (self.EditBox.Frm, .5, 1, 0, 18)

	--

	self:CreateMenu()

	--

	self:Update()

	self.List:Select (3)
	self.List:FullUpdate()

--PAIDE!

end

--------
-- Create menu

function Nx.Warehouse:CreateMenu()

	local menu = Nx.Menu:Create (self.List.Frm, 250)
	self.Menu = menu

	local item = menu:AddItem (0, L["Remove Character or Guild"], self.Menu_OnRemoveChar, self)

	menu:AddItem (0, "", nil, self)
	menu:AddItem (0, L["Import settings from selected character"], self.Menu_OnImport, self)
	menu:AddItem (0, L["Export current settings to all characters"], self.Menu_OnExport, self)

	menu:AddItem (0, "", nil, self)
	menu:AddItem (0, L["Sync account transfer file"], self.Menu_OnSyncAccount, self)

	local menu = Nx.Menu:Create (self.List.Frm, 250)
	self.IListMenu = menu

	self.NXEqRarityMin = 7

	local item = menu:AddItem (0, L["Show Lowest Equipped Rarity"], self.Menu_OnRarityMin, self)
	item:SetSlider (self, 0, 7, 1, "NXEqRarityMin")

	local item = menu:AddItem (0, L["Show Item Headers"], self.Menu_OnShowItemCat, self)
	item:SetChecked (true)

	local item = menu:AddItem (0, L["Sort By Rarity"], self.Menu_OnSortByRarity, self)
	item:SetChecked (false)

	self.NXRarityMin = 0

	local item = menu:AddItem (0, L["Show Lowest Rarity"], self.Menu_OnRarityMin, self)
	item:SetSlider (self, 0, 7, 1, "NXRarityMin")

	local item = menu:AddItem (0, L["Sort By Slot"], self.Menu_OnSortBySlot, self)
	item:SetChecked (false)
end

function Nx.Warehouse:Menu_OnRemoveChar (item)

	if self.SelectedGuild then

		self:GuildDelete (self.SelectedGuild)
		self.SelectedGuild = false

	else

		local cn = self.SelectedChar
		local rc = Nx.RealmChars[cn]
		if cn > 1 and rc then

			tremove (Nx.RealmChars, cn)
			NxData.Characters[rc] = nil
			self.SelectedChar = 1
		end
	end

	self:Update()
end

function Nx.Warehouse:Menu_OnImport (item)

	local cn = self.SelectedChar
	local rc = Nx.RealmChars[cn]
	if cn > 1 and rc then

		local rname, sname = strsplit (".", rc)
		self.ImportChar = sname

		local s = format (L["Import %s's character data and reload?"], sname)
		Nx:ShowMessage (s, L["Import"], Nx.Warehouse.ImportDo, L["Cancel"])
	end
end

function Nx.Warehouse.ImportDo()

	local self = Nx.Warehouse
	local dname = UnitName ("player")

	if Nx:CopyCharacterData (self.ImportChar, dname) then
		ReloadUI()
	end
end

function Nx.Warehouse:Menu_OnExport (item)
	local s = format (L["Overwrite all character settings and reload?"], sname)
	Nx:ShowMessage (s, L["Export"], Nx.Warehouse.ExportDo, L["Cancel"])
end

function Nx.Warehouse.ExportDo()

	if Nx:CopyCharacterData() then
		ReloadUI()
	end
end

function Nx.Warehouse:Menu_OnSyncAccount()
	Nx:ImportCharacterData()
	Nx:ExportCharacterData()
	Nx:CalcRealmChars()
	self:Update()
end

function Nx.Warehouse:Menu_OnShowItemCat (item)
	self.ShowItemCategory = item:GetChecked()
	self:Update()
end

function Nx.Warehouse:Menu_OnSortByRarity (item)
	self.SortByRarity = item:GetChecked()
	self:Update()
end

function Nx.Warehouse:Menu_OnRarityMin (item)
	self:Update()
end

function Nx.Warehouse:Menu_OnSortBySlot (item)
	self.SortBySlot = item:GetChecked()
	self:Update()
end

--------
-- Show or hide

function Nx:NXWarehouseKeyToggleShow()
	Nx.Warehouse:ToggleShow()
end

--------
-- Show or hide

function Nx.Warehouse:ToggleShow()
	Nx.Sec:ValidateMsg()
end

--------
-- Show or hide window

function Nx.Warehouse:ToggleShow_()

--PAIDS!

	if not self.Enabled then
		Nx.prt (L["Disabled"])
		return
	end

	if not self.Win then
		self:Create()
	end

	self.Win:Show (not self.Win:IsShown())

	if self.Win:IsShown() then

		self:CaptureInvDurabilityTimer()
		self:Update()
	end

--PAIDE!
end

--------
-- Handle item list filter edit box

function Nx.Warehouse:OnEditBox (editbox, message)

	if message == "Changed" then
		self:Update()
	end
end

--------
-- On list events

function Nx.Warehouse:OnListEvent (eventName, sel, val2, click)

--	Nx.prt ("Guide list event "..eventName)

	local data = self.List:ItemGetData (sel) or 0
	local id = data % 1000
--	local prof = floor (data / 1000)

	local prof = self.List:ItemGetDataEx (sel, 1)

	self.SelectedGuild = false
	self.SelectedProf = false

	if (id >= 1 and id <= #Nx.RealmChars) or id == 99 then
		self.SelectedChar = id
	end

	if eventName == "select" or eventName == "mid" or eventName == "menu" then

		if id == 100 then
			self.SelectedGuild = prof
		else
			self.SelectedProf = prof
		end

		self.ItemOwnersId = nil

		if eventName == "menu" then
			self.Menu:Open()
		end

		self:Update()

	elseif eventName == "button" then	-- Button icon

		self.List:Select (sel)		-- Select char name line

		self.SelectedProf = prof

		if prof then

			local ch = NxData.Characters[Nx.RealmChars[id]]
			local profT = ch["Profs"][prof]

			local frm = DEFAULT_CHAT_FRAME
			local eb = frm["editBox"]
			if eb:IsVisible() and profT["Link"] then

				eb:SetText (eb:GetText() .. profT["Link"])

			else
				Nx.prt (L["No edit box open!"])
			end

		elseif id >= 1 and id <= #Nx.RealmChars then

			local ch = NxData.Characters[Nx.RealmChars[id]]
			if ch then
				ch["WHHide"] = val2		-- Pressed
			end

		elseif id == 99 then

			for cnum, rc in ipairs (Nx.RealmChars) do

				local ch = NxData.Characters[rc]
				if ch then
					ch["WHHide"] = true
				end
			end
		end

		self:Update()
	end
end

--------
-- On item list events

function Nx.Warehouse:OnItemListEvent (eventName, sel, val2, click)

--	Nx.prt ("List event "..eventName)

	local list = self.ItemList	

	local id = list:ItemGetData (sel) or 0

	if eventName == "select" or eventName == "mid" or eventName == "menu" then

		if eventName == "menu" then
			self.IListMenu:Open()
		else

			if id > 0 then
				if not IsModifiedClick() then
					SetItemRef ("item:" .. id)
--					Nx.Item:ShowTooltip (id, true)
				end

			elseif id == 0 then

				local oldId = self.ItemOwnersId
				self.ItemOwnersId = nil

				local tip = list:ItemGetButtonTip (sel)
				if tip then
					tip = strsub (tip, 2)	-- Remove !

					local str, count = self:FindCharsWithItem (tip)
					if str then

						if oldId then
							if sel > self.ItemOwnersSel then
								sel = sel - self.ItemOwnersCount
								list:Select (sel)
							end
						end

						self.ItemOwnersSel = sel
						self.ItemOwnersCount = count

						local id = strmatch (tip, "item:(%d+)")
						self.ItemOwnersId = id
						self.ItemOwners = str
					end
				end
			end
		end

		self:Update()

	elseif eventName == "button" then	-- Button icon

--		if IsShiftKeyDown() then

			local tip = list:ItemGetButtonTip (sel)
			if tip then

				local name, link

				link = strsub (tip, 2)	-- Remove !

				if id > 0 then
					name, link = GetItemInfo (id)
				elseif id < 0 then
					name = GetSpellInfo (-id)
					link = GetSpellLink (-id)
				else
					name = GetItemInfo (link)
				end

				local frm = DEFAULT_CHAT_FRAME
				local eb = frm["editBox"]
				if eb:IsVisible() and link then

					eb:SetText (eb:GetText() .. link)

				elseif BrowseName and BrowseName:IsVisible() then

					if name then
						BrowseName:SetText (name)
						AuctionFrameBrowse_Search()
					end
				else
					Nx.prt (L["No edit box open!"])
				end
			end
--		end
	end
end

--------
-- Update Warehouse

function Nx.Warehouse:Update()

	local Nx = Nx

	if not Nx.CurCharacter then	-- Can even happen?
		return
	end

	if not self.Win then
		return
	end

	-- Title

	self.Win:SetTitle (format (L["Warehouse: %d characters"], #Nx.RealmChars))

	-- List

	local myName = UnitName ("player")

	local totalChars = 0
	local totalMoney = 0
	local totalPlayed = 0
	local hicol = "|cffcfcfcf"

	local list = self.List

	list:Empty()

	list:ItemAdd (99)
	list:ItemSetButton ("Warehouse", false, "Interface\\Icons\\INV_Misc_GroupNeedMore")
	local allIndex = list:ItemGetNum()

	local ware = NxData.NXWare
	local rn = GetRealmName()

	for name, guilds in pairs (ware) do
		if name == rn then

			for gName, guild in pairs (guilds) do

				local moneyStr = guild["Money"] and Nx.Util_GetMoneyStr (guild["Money"]) or "?"

				list:ItemAdd (100)
				list:ItemSet (2, format ("|cffff7fff%s %s", gName, moneyStr))
				list:ItemSetDataEx (nil, gName, 1)
			end
		end
	end

	list:ItemAdd (0)
	list:ItemSet (2, "-------------------------")

	for cnum, rc in ipairs (Nx.RealmChars) do

		local rname, cname = strsplit (".", rc)

		local cnameCol = "|cffafdfaf"

		if cname == myName then		-- Me?
			cnameCol = "|cffdfffdf"
		end

		local ch = NxData.Characters[rc]
		if ch then

			totalChars = totalChars + 1
			totalPlayed = totalPlayed + ch["TimePlayed"]

			local lvl = tonumber (ch["Level"] or 0)

--			ch["Class"] = "Deathknight"	-- TEST

			local cls = ch["Class"] or "?"

			local money = ch["Money"]
			totalMoney = totalMoney + (money or 0)
			local moneyStr = Nx.Util_GetMoneyStr (money)

			list:ItemAdd (cnum)
			local s = ch["Account"] and format ("%s (%s)", cname, ch["Account"]) or cname
			list:ItemSet (2, format ("%s%s %s %s  %s", cnameCol, s, lvl, _TRANS(cls), moneyStr))

			local hide = ch["WHHide"]

			if self.ClassIcons[ch["Class"]] then
				list:ItemSetButton ("Warehouse", hide, "Interface\\Icons\\" .. self.ClassIcons[ch["Class"]])
			end

			if not hide then

				if cname == myName then		-- Me?

					local secs = difftime (time(), ch["LTime"])
					local mins = secs / 60 % 60
					local hours = secs / 3600
					local lvlHours = difftime (time(), ch["LvlTime"]) / 3600
					local played = Nx.Util_GetTimeElapsedStr (ch["TimePlayed"])

					list:ItemAdd (cnum)
					list:ItemSet (2, format (L[" Time On: %s%2d:%02d:%02d|r, Played: %s%s"], hicol, hours, mins, secs % 60, hicol, played))

					local money = (ch["Money"] or 0) - ch["LMoney"]
					local moneyStr = Nx.Util_GetMoneyStr (money)
					local moneyHStr = Nx.Util_GetMoneyStr (money / hours)

					list:ItemAdd (cnum)
					list:ItemSet (2, format (L[" Session Money: %s|r, Per Hour: %s"], moneyStr, moneyHStr))

					if ch["DurPercent"] then

						local col = (ch["DurPercent"] < 50 or ch["DurLowPercent"] < 50) and "|cffff0000" or hicol

						list:ItemAdd (cnum)
						list:ItemSet (2, format (L[" Durability: %s%d%%, lowest %d%%"], col, ch["DurPercent"], ch["DurLowPercent"]))
					end

					if lvl < MAX_PLAYER_LEVEL then
						local rest = ch["LXPRest"] / ch["LXPMax"] * 100		-- Sometimes over 150%?
						local xp = ch["XP"] - ch["LXP"]
						list:ItemAdd (cnum)
						list:ItemSet (2, format (L[" Session XP: %s, Per Hour: %.0f"], xp, xp / lvlHours))

						xp = max (1, xp)
						local lvlTime = (ch["XPMax"] - ch["XP"]) / (xp / lvlHours)

						if lvlTime < 100 then
							list:ItemAdd (cnum)
							list:ItemSet (2, format (L[" Hours To Level: %s%.1f"], hicol, lvlTime))
						end
					end
				else

					if ch["Time"] then

						local secs = difftime (time(), ch["Time"])
						local str = Nx.Util_GetTimeElapsedStr (secs)
						local played = Nx.Util_GetTimeElapsedStr (ch["TimePlayed"])

						list:ItemAdd (cnum)
						list:ItemSet (2, format (L[" Last On: %s%s|r, Played: %s%s"], hicol, str, hicol, played))
					end

					if ch["Pos"] then

						local mid, x, y = strsplit ("^", ch["Pos"])

						local map = Nx.Map:GetMap (1)
						local name = map:IdToName (tonumber (mid))

						list:ItemAdd (cnum)
						list:ItemSet (2, format (L[" Location: %s%s (%d, %d)"], hicol, name, x, y))
					end
				end

				if lvl < MAX_PLAYER_LEVEL then
					if ch["XP"] then

						local rest = ch["LXPRest"] / ch["LXPMax"] * 100
						list:ItemAdd (cnum)
						list:ItemSet (2, format (L[" Start XP: %s%s/%s (%.0f%%)|r Rest: %s%.0f%%"], hicol, ch["LXP"], ch["LXPMax"], ch["LXP"] / ch["LXPMax"] * 100, hicol, rest))

						local rest = ch["XPRest"] / ch["XPMax"] * 100

						if ch["Time"] then
							rest = min (150, rest + difftime (time(), ch["Time"]) * .0001736111)
						end

						list:ItemAdd (cnum)
						list:ItemSet (2, format (L[" XP: %s%s/%s (%.0f%%)|r Rest: %s%.0f%%"], hicol, ch["XP"], ch["XPMax"], ch["XP"] / ch["XPMax"] * 100, hicol, rest))
					end
				end

				if ch["Honor"] then

					local honorStr = ""

					if cname == myName then		-- Me?
						local _, honor = GetCurrencyInfo (392)		--V4
						honor = honor - ch["LHonor"]
--						local hk, honor = GetPVPSessionStats()		-- OLD
						if honor > 0 then
							honorStr = format (" (+%d)", honor)
						end
					end

					list:ItemAdd (cnum)
					list:ItemSet (2, format (L[" Honor: %s%s%s|r, Arena Pts: %s%s"], hicol, ch["Honor"], honorStr, hicol, ch["ArenaPts"]))
				end
--[[
				if ch["Professions"] then
					for n, data in ipairs (ch["Professions"]) do
						local name, rank = strsplit ("^", data)
						list:ItemAdd (cnum)
						list:ItemSetDataEx (nil, name, 1)
						list:ItemSet (2, format (" %s %s%s", name, hicol, rank))
					end
				end
--]]
				if ch["Profs"] then

					local profs = ch["Profs"]

					local names = {}

					for name, data in pairs (profs) do
						tinsert (names, name)
					end

					sort (names)

					for n, name in ipairs (names) do

						local p = profs[name]
						list:ItemAdd (cnum)
						list:ItemSetDataEx (nil, name, 1)
						list:ItemSet (2, format (" %s %s%s", name, hicol, p["Rank"]))

						if p["Link"] then
							list:ItemSetButton ("WarehouseProf", false)
						end
					end
				end
			end
		end
	end

	local money = Nx.Util_GetMoneyStr (totalMoney)
	local played = Nx.Util_GetTimeElapsedStr (totalPlayed)
	list:ItemSet (2, format (L["|cffafdfafAll: %s. |cffafdfafPlayed: %s%s"], money, hicol, played), allIndex)

	list:Update()

	-- Right side list

	if not self.SelectedProf then
		self:UpdateItems()
	else
		self:UpdateProfessions()
	end
end

function Nx.Warehouse:UpdateItems()

	local list = self.ItemList

	list:Empty()

	local items = {}

	local cn1 = 1
	local cn2 = 1

	cn2 = #Nx.RealmChars

	if self.SelectedChar ~= 99 then

		cn1 = self.SelectedChar
		cn2 = cn1

		local rc = Nx.RealmChars[cn1]

		local rname, cname = strsplit (".", rc)
		list:ColumnSetName (3, format (L["%s's Items"], cname))

		local ch = NxData.Characters[rc]

		local bank = ch["WareBank"]
		if not bank then
			list:ItemAdd (0)
			list:ItemSet (3, L["|cffff1010No bank data - visit your bank"])
		end

		local inv = ch["WareInv"]

		if inv then

			list:ItemAdd (0)
			list:ItemSet (3, L["---- Equipped ----"])

			for _, data in ipairs (inv) do

				local slot, link = strsplit ("^", data)
				Nx.Item:Load (link)

				slot = gsub (slot, "Slot", "")
				slot = gsub (slot, "%d", "")
				slot = _TRANS(slot)

				local name = GetItemInfo (link)

				self:UpdateItem (format ("  %s - ", slot), name, 1, 0, 0, link, true)
			end
		end
	else

		for cn = cn1, cn2 do

			local rc = Nx.RealmChars[cn]
			local ch = NxData.Characters[rc]

			local inv = ch["WareInv"]

			if inv then

				local hdr

				for _, data in ipairs (inv) do

					local slot, link = strsplit ("^", data)
					Nx.Item:Load (link)

					slot = gsub (slot, "Slot", "")
					slot = gsub (slot, "%d", "")
					slot = _TRANS(slot)

					local name, _, iRarity = GetItemInfo (link)
					if iRarity and iRarity >= self.NXEqRarityMin then

						if not hdr then
							hdr = true
							list:ItemAdd (0)
							local rname, cname = strsplit (".", rc)
							local s = format (L["---- %s Equipped ----"], cname)
							list:ItemSet (3, s)
						end

						self:UpdateItem (format ("  %s - ", slot), name, 1, 0, 0, link, true)
					end
				end
			end
		end

		list:ColumnSetName (3, L["All Items"])
--[[
		if Nx.Free then
			list:ItemAdd (0)
			list:ItemSet (3, "See All Is " .. Nx.FreeMsg)
			return
		end
--]]
	end

	for cn = cn1, cn2 do

		local rc = Nx.RealmChars[cn]
		local ch = NxData.Characters[rc]

		local bags = ch["WareBags"]

		if bags then
			for name, data in pairs (bags) do
				self:AddItem (items, 2, name, data)
			end
		end

		local bank = ch["WareBank"]

		if bank then
			for name, data in pairs (bank) do
				self:AddItem (items, 3, name, data)
			end
		end

		local mail = ch["WareMail"]

		if mail then
			for name, data in pairs (mail) do
				self:AddItem (items, 4, name, data)
			end
		end
	end

	local sortRare = true

	local isorted = {}

	for name, data in pairs (items) do

		local bagCnt, bankCnt, mailCnt, link = strsplit ("^", data)
		Nx.Item:Load (link)

		if self.SortByRarity or self.SortBySlot then

			local _, iLink, iRarity, lvl, minLvl, itype, _, _, equipLoc = GetItemInfo (link)

			local sortStr = ""

			if self.SortByRarity then
				sortStr = 9 - (iRarity or 0)
			end

			if self.SortBySlot and itype == ARMOR and equipLoc then
				local loc = getglobal (equipLoc) or ""
				name = format ("%s - %s", loc, name)
				sortStr = format ("%s%s", loc, sortStr)
			end

			tinsert (isorted, format ("%s^%s^%s", sortStr, name, data))
		else
			tinsert (isorted, format ("^%s^%s", name, data))
		end

	end

	sort (isorted)

	if not self.ShowItemCategory then

		for _, v in ipairs (isorted) do

			local _, name, bagCnt, bankCnt, mailCnt, link = strsplit ("^", v)
			local _, iLink, iRarity = GetItemInfo (link)

			iRarity = iRarity or 0	-- Happens if item not in cache

			if iRarity >= self.NXRarityMin then
				self:UpdateItem ("", name, bagCnt, bankCnt, mailCnt, link)
			end
--[[
			local name, iLink, iRarity, lvl, minLvl, itype = GetItemInfo (link)
			Nx.prt ("item %s", itype)
--]]
		end
	else

		for _, typ in ipairs (self.ItemTypes) do

			for n = 1, #isorted do

				local _, name, bagCnt, bankCnt, mailCnt, link = strsplit ("^", isorted[n])
				local _, iLink, iRarity, lvl, minLvl, itype = GetItemInfo (link)

				if itype == typ then	-- Found one of type?

					list:ItemAdd (0)
					list:ItemSet (3, "---- " .. typ .. " ----")

					for n2 = n, #isorted do

						local _, name, bagCnt, bankCnt, mailCnt, link = strsplit ("^", isorted[n2])
						local _, iLink, iRarity, lvl, minLvl, itype = GetItemInfo (link)

						if itype == typ then

							if iRarity >= self.NXRarityMin then
								self:UpdateItem ("  ", name, bagCnt, bankCnt, mailCnt, link)
							end
						end
					end

					break
				end
			end
		end
	end

	list:Update()
end

function Nx.Warehouse:AddItem (items, typ, name, data)

	local totalBag = 0
	local totalBank = 0
	local totalMail = 0

	if items[name] then
		totalBag, totalBank, totalMail = strsplit ("^", items[name])
	end

	local count, iLink = strsplit ("^", data)

	if typ == 2 then
		totalBag = totalBag + count

	elseif typ == 3 then
		totalBank = totalBank + count

	elseif typ == 4 then
		totalMail = totalMail + count
	end

	items[name] = format ("%d^%d^%d^%s", totalBag, totalBank, totalMail, iLink)
end

function Nx.Warehouse:UpdateItem (pre, name, bagCnt, bankCnt, mailCnt, link, showILvl)

	local list = self.ItemList

	name = name or link

	bagCnt = tonumber (bagCnt)
	bankCnt = tonumber (bankCnt)
	mailCnt = tonumber (mailCnt)

	local total = bagCnt + bankCnt + mailCnt

	local str

	if bankCnt + mailCnt == 0 then
		if bagCnt <= 1 then
			str = format ("%s", name)
		else
			str = format ("%s  |r%s", name, bagCnt)
		end
	else
		str = format ("%s  |r%s", name, bagCnt)

		if bankCnt > 0 then
			str = format (L["%s |cffcfcfff(%s Bank)"], str, bankCnt)
		end

		if mailCnt > 0 then
			str = format (L["%s |cffcfffff(%s Mail)"], str, mailCnt)
		end
	end

	local iname, iLink, iRarity, lvl, minLvl, itype, subType, stackCount, equipLoc, tx = GetItemInfo (link)

	if not iname then
		iLink = link
		iRarity = 0
		minLvl = 0
	end

--	str = str .. " |r" .. itype .. " " .. subType

	iRarity = min (iRarity, 6)		-- Fix Blizz bug with color table only going to 6. Account bound are 6 or 7
	local col = iRarity == 1 and "|cffe7e7e7" or ITEM_QUALITY_COLORS[iRarity]["hex"]

	local show = true
	local istr = pre .. col .. str

	if showILvl and lvl then
		istr = istr .. ",  |ri" .. lvl 
	end

	local filterStr = self.EditBox:GetText()

	if filterStr ~= "" then

		local lstr = strlower (format ("%s", istr))
		local filtStr = strlower (filterStr)

		show = strfind (lstr, filtStr, 1, true)
	end

	if show then

		list:ItemAdd (0)

		if total > 1 then
			list:ItemSet (2, format ("|cffcfcfff%s  ", bagCnt + bankCnt + mailCnt))
		end

		if minLvl > UnitLevel ("player") then
			istr = format ("%s |cffff4040[%s]", istr, minLvl)
		end

		list:ItemSet (3, istr)
		list:ItemSetButton ("WarehouseItem", false, tx, "!" .. iLink)

		local s1, s2, id = strfind (link, "item:(%d+)")
		assert (s1)
		assert (id)

		if self.ItemOwnersId == id then

			local pos = 1

			for n = 1, 99 do

--				Nx.prt ("Owners %s", self.ItemOwners)

				local e = strfind (self.ItemOwners, "\n", pos)

				str = strsub (self.ItemOwners, pos, e and e - 1)

				list:ItemAdd (0)
				list:ItemSet (3, format ("        %s", str))

				if not e then
					break
				end

				pos = e + 1
			end
		end
	end
end

--------
-- Find all chars who have item

function Nx.Warehouse:FindCharsWithItem (link)

--	local tm = GetTime()

	local s1, s2, link = strfind (link, "item:(%d+)")
--  assert (s1)

--	Nx.prt ("Find Link %s", link)

	local str
	local charCnt = 0
	local totalCnt = 0

	for cnum, rc in ipairs (Nx.RealmChars) do

		local bagCnt = 0
		local bankCnt = 0
		local invCnt = 0
		local mailCnt = 0

		local rname, cname = strsplit (".", rc)
		local ch = NxData.Characters[rc]

		local bags = ch["WareBags"]

		if bags then
			for name, data in pairs (bags) do
				local iCount, iLink = strsplit ("^", data)
				local s1, s2, iLink = strfind (iLink, "item:(%d+)")
				if iLink == link then
					bagCnt = bagCnt + iCount
					break
				end
			end
		end

		local bank = ch["WareBank"]

		if bank then
			for name, data in pairs (bank) do
				local iCount, iLink = strsplit ("^", data)
				local s1, s2, iLink = strfind (iLink, "item:(%d+)")
				if iLink == link then
					bankCnt = bankCnt + iCount
					break
				end
			end
		end

		local inv = ch["WareInv"]

		if inv then
			for name, data in pairs (inv) do
				local slot, iLink = strsplit ("^", data)
				local s1, s2, iLink = strfind (iLink, "item:(%d+)")
				if iLink == link then
					invCnt = invCnt + 1
				end
			end
			bagCnt = bagCnt + invCnt	-- Just add to bag cnt
		end

		local mail = ch["WareMail"]

		if mail then
			for name, data in pairs (mail) do
				local iCount, iLink = strsplit ("^", data)
				local s1, s2, iLink = strfind (iLink, "item:(%d+)")
				if iLink == link then
					mailCnt = mailCnt + iCount
					break
				end
			end
		end

		local cnt = bagCnt + bankCnt + mailCnt

		if cnt > 0 then

			charCnt = charCnt + 1
			totalCnt = totalCnt + cnt

			local s
			if bankCnt > 0 then
				s = format (L["%s %d (%d Bank)"], cname, bagCnt, bankCnt)
			else
				s = format ("%s %d", cname, bagCnt)
			end

			if mailCnt > 0 then
				s = format (L["%s (%s Mail)"], s, mailCnt)
			end

			if not str then
				str = s
			else
				str = format ("%s\n%s", str, s)
			end
		end
	end

--	Nx.prt ("FindCharsWithItem %f secs", GetTime() - tm)

	return str, charCnt, totalCnt
end

function Nx.Warehouse:UpdateProfessions()

	local list = self.ItemList

	list:Empty()

	local cn1 = self.SelectedChar
	local rc = Nx.RealmChars[cn1]
	local ch = NxData.Characters[rc]

	local rname, cname = strsplit (".", rc)
	local pname = self.SelectedProf

	list:ColumnSetName (3, format (L["%s's %s Skills"], cname, pname))

	local profsT = ch["Profs"]
	local profT = profsT[pname]
	if profT then

		local items = {}

		for id, itemId in pairs (profT) do

			if type (id) == "number" then

				local name = GetSpellInfo (id)
				local iName, iLink, iRarity, iLvl, iMinLvl, iType, iSubType, iStackCount, iEquipLoc = GetItemInfo (itemId)

				name = iName or name or "?"

				local cat = ""

				if self.ShowItemCategory then
					cat = iType or ""
				end

				local sortStr = ""

				if self.SortBySlot and iType == ARMOR and iEquipLoc then
--				if self.SortBySlot and iEquipLoc then
					local loc = getglobal (iEquipLoc) or ""
					name = format ("%s - %s", loc, name)
					sortStr = format ("%s%s", loc, sortStr)
				end

				tinsert (items, format ("%s^%s%02d^%s^%s", cat, sortStr, iMinLvl or 0, name, id))
			end
		end

		sort (items)

		local filterStr = strlower (self.EditBox:GetText())
		local curCat = ""

		for _, str in ipairs (items) do

			local cat, _, name, id = strsplit ("^", str)
			local id = tonumber (id)

			local link = GetSpellLink (id)
			local iName, iLink, iRarity, iLvl, iMinLvl, iType, iSubType, iStackCount, iEquipLoc, iTx
			local col = ""

			local itemId = -id		-- Use negatives for enchants

			if profT[id] > 0 then

				itemId = profT[id]

				Nx.Item:Load (itemId)

				iName, iLink, iRarity, iLvl, iMinLvl, iType, iSubType, iStackCount, iEquipLoc, iTx = GetItemInfo (itemId)
				if iRarity then
					iRarity = min (iRarity, 6)		-- Fix Blizz bug with color table only going to 6. Account bound are 6 or 7
					col = iRarity == 1 and "|cffe7e7e7" or ITEM_QUALITY_COLORS[iRarity]["hex"]
				end
			end

			local iStr = col .. name

			if iMinLvl and iMinLvl > 0 then
				if iMinLvl > UnitLevel ("player") then
					iStr = format ("%s |cffff4040[%s]", iStr, iMinLvl)
				else
					iStr = format ("%s |cff40ff40[%s]", iStr, iMinLvl)
				end
			end

			local show = true

			if filterStr ~= "" then
				local lstr = strlower (iStr)
				show = strfind (lstr, filterStr, 1, true)
			end

			if show then

				if cat ~= curCat then
					curCat = cat
					list:ItemAdd (0)
					list:ItemSet (3, format ("---- %s ----", cat))
				end

				list:ItemAdd (itemId)		-- Neg enchant, pos item
				list:ItemSet (3, iStr)
				if link then
					list:ItemSetButton ("WarehouseItem", false, iTx, "#" .. link)
				end
			end
		end

	else

		list:ItemAdd (0)
		list:ItemSet (3, format (L["|cffff1010No data - open %s window"], pname))
	end

	list:Update()
end

--------
--

function Nx.Warehouse:TooltipProcess()

	if not self.Enabled or not Nx:GetGlobalOpts()["WarehouseAddTooltip"] then
		return
	end

	local tip = GameTooltip
	local name, link = tip:GetItem()

	if name then

--		Nx.prt ("TTItem %s", name or "nil")

		local titleStr = format (L["|cffffffffW%sarehouse:"], Nx.TXTBLUE)

		local textName = "GameTooltipTextLeft"

		for n = 2, tip:NumLines() do
			local s1 = strfind (getglobal (textName .. n):GetText() or "", titleStr)
			if s1 then
				return
			end
		end

		local str, count, total = self:FindCharsWithItem (link)
		if total > 1 then
			str = gsub (str, "\n", "\n ")
			tip:AddLine (format ("%s |cffe0e020%s\n |cffb0b0b0%s", titleStr, total, str))
			return true
		end
	end
end

--------
--

function Nx.Warehouse:GuildDelete (guildName)

	local ware = NxData.NXWare
	local rn = GetRealmName()

	for name, guilds in pairs (ware) do
		if name == rn then
			guilds[guildName] = nil
			return
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Capture item changes

function Nx.Warehouse.OnBankframe_opened()
--	Nx.prt ("Bank open")

	local self = Nx.Warehouse

	if self.Enabled then
		self.BankOpen = true
		self:CaptureUpdate()
	end
end

function Nx.Warehouse.OnBankframe_closed()
--	Nx.prt ("Bank close")

	local self = Nx.Warehouse

	if self.Enabled then
		self.BankOpen = false
		self:CaptureUpdate()
	end
end

function Nx.Warehouse.OnGuildbankframe_opened()
--	Nx.prt ("GBank open %s", GetGuildBankMoney())

	local self = Nx.Warehouse

	if self.Enabled then
		self:GuildRecord (true)
	end
end

function Nx.Warehouse.OnGuildbankframe_closed()
--	Nx.prt ("GBank close %s", GetGuildBankMoney())

	local self = Nx.Warehouse

	if self.Enabled then
		self:GuildRecord (true)
	end
end

function Nx.Warehouse:GuildRecord (open)

	local gName = GetGuildInfo ("player")

	if gName then

		local ware = NxData.NXWare
		local rn = GetRealmName()

		local rnGuilds = ware[rn] or {}
		ware[rn] = rnGuilds

		local guild = rnGuilds[gName] or {}
		rnGuilds[gName] = guild

		if open then
			guild["Money"] = GetGuildBankMoney()
		end
	end
end

function Nx.Warehouse.OnBag_update()

	local self = Nx.Warehouse

	if self.Enabled then
		local delay = self.BankOpen and 0 or .8
		Nx.Timer:Start ("WarehouseCap", delay, self, self.CaptureUpdate)
	end
end

function Nx.Warehouse.OnMail_inbox_update()

--	Nx.prt ("MAIL_INBOX_UPDATE")

	local self = Nx.Warehouse

	if not self.Enabled then
		return
	end

	local ch = Nx.CurCharacter

	local inv = {}
	ch["WareMail"] = inv

	for n = 1, GetInboxNumItems() do

		local _, _, sender, subject, money, COD, daysLeft, hasItem, wasRead = GetInboxHeaderInfo (n)

		if hasItem then
--			Nx.prt ("Mail #%d cnt %d", n, hasItem)

			for i = 1, ATTACHMENTS_MAX_RECEIVE do

				local name, _, count = GetInboxItem (n, i)
				if name then

					local link = GetInboxItemLink (n, i)

					if link then
						self:AddLink (link, count, inv)
					end

--					Nx.prt ("Mail %s", link or "nil")
				end
			end
		end
	end

	self:Update()
end

function Nx.Warehouse.OnItem_lock_changed()

	if type (arg2) ~= "number" then	-- Inventory item?
		return
	end

	local self = Nx.Warehouse

	if not self.Enabled then
		return
	end

	if arg1 == KEYRING_CONTAINER or arg1 == BACKPACK_CONTAINER or (arg1 >= 1 and arg1 <= NUM_BAG_SLOTS) or
			arg1 == BANK_CONTAINER or (arg1 >= NUM_BAG_SLOTS + 1 and arg1 <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) then

		self.LockBank = nil

		if arg1 == BANK_CONTAINER or (arg1 >= NUM_BAG_SLOTS + 1 and arg1 <= NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) then
			self.LockBank = true
		end

		self:prtdb ("LockChg %s %s", arg1, tostring(arg2))

		self.LockBag = arg1
		self.LockSlot = arg2
		local tx, count, locked = GetContainerItemInfo (arg1, arg2)
		if tx then
			self.LockCnt = count
			self.LockLink = GetContainerItemLink (arg1, arg2)
		end

		if locked then

--			Nx.prt ("Lock %d %d", arg1, arg2)
			self.Locked = true

		else

--			Nx.prt ("Unlock %d %d", arg1, arg2)
			self.Locked = false
		end

		self:CaptureUpdate()
		self.LockBag = nil		-- Off
	end
end

--------
-- Capture and update UI

function Nx.Warehouse:CaptureUpdate()

	self:CaptureItems()

	if self.Win then
		Nx.Timer:ProfilerStart ("WH CaptureUpdate")
		self:Update()
		Nx.Timer:ProfilerEnd ("WH CaptureUpdate")
	end
end

--------
-- Capture items

function Nx.Warehouse:CaptureItems()

	Nx.Timer:ProfilerStart ("WH CaptureItems")

	local ch = Nx.CurCharacter

--	ch["WareBank"] = nil

	local inv = {}
	ch["WareInv"] = inv

	for _, name in ipairs (self.InvNames) do

		local id = GetInventorySlotInfo (name)
		local link = GetInventoryItemLink ("player", id)
		if link then
			tinsert (inv, format ("%s^%s", name, link))
		end
	end

	-- Bag slots

--	local oldBags = ch["WareBags"]

	local inv = {}
	ch["WareBags"] = inv

	self:AddBag (KEYRING_CONTAINER, false, inv)
	self:AddBag (BACKPACK_CONTAINER, false, inv)

	for bag = 1, NUM_BAG_SLOTS do
		self:AddBag (bag, false, inv)
	end

--	self:prtdb ("Bags %d", Nx.Util_tcount (inv))

	-- Bank slots

	if self.BankOpen then
--	if BankFrame and BankFrame:IsShown() then

		local inv = {}

		self:AddBag (BANK_CONTAINER, true, inv)

		for bag = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
			self:AddBag (bag, true, inv)
		end

		if next (inv) then		-- Get any bank items?
			ch["WareBank"] = inv

--			self:prtdb ("Bank %d", Nx.Util_tcount (inv))
		end

	else

		if self.LockBank and self.LockBag and not self.Locked then
--			Nx.prt ("Bank add back")
			self:AddLink (self.LockLink, self.LockCnt, ch["WareBank"])
		end
	end

	Nx.Timer:ProfilerEnd ("WH CaptureItems")

	self:prtdb ("WH CapItems %s", Nx.Timer:ProfilerGetLastTime ("WH CaptureItems"))
end

function Nx.Warehouse:AddBag (bag, isBank, inv)

	local slots = GetContainerNumSlots (bag)

	for slot = 1, slots do

		local tx, count, locked = GetContainerItemInfo (bag, slot)
		if not locked then

			local link = GetContainerItemLink (bag, slot)
			if link then

				self:AddLink (link, count, inv)
			end
		end
	end
end

function Nx.Warehouse:AddLink (link, count, inv)

	local name, iLink = GetItemInfo (link)

	if name and inv then		-- inv can somehow be nil. bank addon?

		local total = 0

		if inv[name] then
			total = strsplit ("^", inv[name])
		end

		total = total + count

		inv[name] = format ("%d^%s", total, iLink)
	else
--		Nx.prt ("AddLink nil %s", link)
	end
end

--------

function Nx.Warehouse.OnUnit_inventory_changed()

--	Nx.prt ("OnUNIT_INVENTORY_CHANGED %s", arg1)
	if arg1 == "player" and not UnitAffectingCombat ("player") and Nx.Info and Nx.Info.NeedDurability then
		Nx.Warehouse:CaptureInvDurability()
	end
end

function Nx.Warehouse.OnMerchant_closed()

--	Nx.prt ("OnMERCHANT_CLOSED %s", arg1)
	Nx.Warehouse:CaptureInvDurability()
end

function Nx.Warehouse:CaptureInvDurability()

	Nx.Timer:Start ("WarehouseDur", 3, self, self.CaptureInvDurabilityTimer)
end

--------

function Nx.Warehouse:CaptureInvDurabilityTimer()

--PAIDS!

--	local tm = GetTime()

--	local tip = GameTooltip
--	local textName = "GameTooltipTextLeft"
	local tip = self.DurTooltipFrm
	local textName = "NxTooltipDTextLeft"

	self.DurTooltipFrm:SetOwner (UIParent, "ANCHOR_NONE")	-- Fixes numlines 0 problem if UI was hidden

	local durPattern = NXlDurPattern
	local durAll = 0
	local durAllMax = 0
	local durLow = 1

	for _, invName in ipairs (self.DurInvNames) do

		local id = GetInventorySlotInfo (invName)

		if tip:SetInventoryItem ("player", id) then		-- Slot has item?

--			Nx.prt ("Slot %s %s #%s", invName, id, tip:NumLines())

			for n = 4, tip:NumLines() do

--				Nx.prt ("Tip line #%s %s", n, getglobal (textName .. n):GetText() or "nil")

				local _, _, dur, durMax = strfind (getglobal (textName .. n):GetText() or "", durPattern)
				if dur and durMax then
					durAll = durAll + tonumber (dur)
					durAllMax = durAllMax + tonumber (durMax)
					durLow = min (durLow, tonumber (dur) / tonumber (durMax))

--					Nx.prt (" %s", dur)

					break
				end
			end
		end
	end

--	tip:Hide()

	local ch = Nx.CurCharacter

	ch["DurPercent"] = durAll / durAllMax * 100
	ch["DurLowPercent"] = durLow * 100

--	Nx.prt ("GetDur %s", GetTime() - tm)

--PAIDE!
end

--------
-- Looting

function Nx.Warehouse.OnLoot_opened()

	local self = Nx.Warehouse

	if not self.LootTarget then
		self.LootTarget = format ("U^%s", UnitName ("target") or "")
	end

	self.LootItems = {}

	for n = 1, GetNumLootItems() do
		self.LootItems[n] = GetLootSlotLink (n)		-- Money is nil
	end

	self:prtdb ("LOOT_OPENED %s (%s %s)", self.LootTarget, arg1, arg2 or "nil")
end

function Nx.Warehouse.OnLoot_slot_cleared()

	local self = Nx.Warehouse

	if not self.LootTarget then
		self:prtdb ("no LootTarget")
		return
	end

	if self.LootItems[arg1] then
		local name, iLink, iRarity, lvl, minLvl, iType = GetItemInfo (self.LootItems[arg1])
		if iType == "Quest" then
			self:prtdb ("LOOT_SLOT_CLEARED #%s %s (quest)", arg1, self.LootItems[arg1])
			self:Capture (iLink)
		end
	end
end

function Nx.Warehouse.OnLoot_closed()

	local self = Nx.Warehouse

	self.LootTarget = nil
--	self.LootItems = nil				-- Cant do. Sometimes called before OnLOOT_SLOT_CLEARED

	self:prtdb ("LOOT_CLOSED")
end

--[[
function Nx.Warehouse:DiffBags (oldBags)

	local ch = Nx.CurCharacter

	for name, v in pairs (ch["WareBags"]) do

		local newCnt, link = strsplit ("^", v)

		if oldBags[name] then
			local oldCnt = strsplit ("^", oldBags[name])
			if newCnt > oldCnt then

				local name, iLink, iRarity, lvl, minLvl, itype = GetItemInfo (link)
				if itype == "Quest" then
					self:prtdb ("Quest item added: %s", name)
					self:Capture (link)
				end
			end
		else
			local name, iLink, iRarity, lvl, minLvl, itype = GetItemInfo (link)
			if itype == "Quest" then
				self:prtdb ("Quest item added: %s", name)
				self:Capture (link)
			end
		end
	end
end
--]]

function Nx.Warehouse:Capture (link)
--[[
	local opts = Nx:GetGlobalOpts()

	if not opts["CaptureEnable"] then
		return
	end

	local s1, s2, id = strfind (link, "item:(%d+)")
	if not s1 then
		Nx.prt ("Warehouse Capture Error")
		return
	end

	local map = Nx.Map:GetMap (1)
	local zone = Nx.MapIdToNxzone[map.RMapId] or 0
	local cap = Nx:GetCap()

	local facName = UnitFactionGroup ("player")
	local facs = self:CaptureGet (cap, facName)
	local oq = self:CaptureGet (facs, "OQ")

--	Nx.prt ("qo tables %s", Nx.Util_tcountrecurse (oq))
	if Nx.Util_tcountrecurse (oq) > 600 then
		return
	end

	local zones = self:CaptureGet (oq, zone)
	local idt = self:CaptureGet (zones, id)
	local targett = self:CaptureGet (idt, self.LootTarget)

	local loc = format ("%f^%f", map.PlyrRZX, map.PlyrRZY)
	tinsert (targett, loc)

--]]
end

function Nx.Warehouse:CaptureGet (t, key)

	assert (type (t) == "table" and key)

	local d = t[key] or {}
	t[key] = d
	return d
end

--------
-- Skill message

function Nx.Warehouse.OnChat_msg_skill()

	local self = Nx.Warehouse

	if self.Enabled then

--		Nx.prt ("OnChat_msg_skill")

		Nx.Timer:Start ("WarehouseRec", .5, self, self.RecordCharacterSkills)
	end
end

--------
-- Record 2 professions name rank and riding skill

function Nx.Warehouse:RecordCharacterSkills()

--	Nx.prt ("Warehouse Rec skill")

	local ch = Nx.CurCharacter

	for _, v in pairs (ch["Profs"]) do
		v.Old = true	-- Flag for delete
	end

	-- Check riding spells to get skill

	self.SkillRiding = 0

	for skill, name in pairs (self.RidingSpells) do
		if GetSpellInfo (name) then
			self.SkillRiding = skill
			break
		end
	end

--	Nx.prt ("WH riding %s", self.SkillRiding)

	-- Scan professions

--	local prof_1, prof_2, archaeology, fishing, cooking, firstaid = GetProfessions()		-- Indices for GetProfessionInfo
	local proI = { GetProfessions() }		-- Indices for GetProfessionInfo

	for _, i in pairs (proI) do

		local name, icon, rank, maxrank, numspells, spelloffset, skillline = GetProfessionInfo (i)
		if name then

--			Nx.prt ("Prof %s %s %d", i, name, rank)

			local t = ch["Profs"]
			local p = t[name] or {}
			t[name] = p
			p["Rank"] = rank
			p.Old = nil
		end
	end


--[[	OLD <4.0
	for n = 1, GetNumSkillLines() do

		local name, hdr, expanded = GetSkillLineInfo (n)
		if not name then
			break
		end

		if hdr and (name == self.LProfessions or name == self.LSecondarySkills) then

--			Nx.prt ("hdr %s", name)

			local open

			if not expanded then
--				Nx.prt (" #%s %s", n, GetNumSkillLines())
				ExpandSkillHeader (n)
				open = n
--				Nx.prt (" #%s %s", n, GetNumSkillLines())
			end

			for n2 = n + 1, GetNumSkillLines() do

				local name, hdr, expanded, rank, tempPoints, modifier = GetSkillLineInfo (n2)

				if hdr then
					break
				end

				if name == NXlRiding then
					self.SkillRiding = rank

				else

--					Nx.prt (" skill %s", name)

					local t = ch["Profs"]
					local p = t[name] or {}
					t[name] = p
					p["Rank"] = rank
					p.Old = nil
				end
			end

			if open then
				CollapseSkillHeader (open)
			end
		end
	end
--]]

	-- Nuke any old ones

	for name, v in pairs (ch["Profs"]) do
		if v.Old then
			ch["Profs"][name] = nil
			Nx.prt ("%s deleted", name)
		end
	end

--	Nx.prt ("Riding %s", self.SkillRiding)
end

-------------------------------------------------------------------------------

--PAIDS!

--------
-- Skill update

function Nx.Warehouse.OnTrade_skill_update()

	local self = Nx.Warehouse

	if self.Enabled then

--		Nx.prt ("OnTrade_skill_update")
--		Nx.prt ("#skills %s", GetNumTradeSkills())

		Nx.Timer:Start ("WarehouseRecProf", 0, self, self.RecordProfession)
	end
end

--[[
function Nx.Map.Guide.OnTrade_skill_show()	-- Your own trade window

--	local self = Nx.Map.Guide

	Nx.prt ("OnTRADE_SKILL_SHOW")

	Nx.prtStrHex ("Trade", GetTradeSkillListLink())
	local link = GetTradeSkillListLink()

--	self:SavePlayerNPCTarget()
end
--]]

--------
-- Record profession

function Nx.Warehouse:RecordProfession()

--	Nx.prt ("Rec #skills %s", GetNumTradeSkills())

	local linked = IsTradeSkillLinked()
	if linked then
--		Nx.prt (" Linked, skip")
		return
	end

	local cnt = GetNumTradeSkills()

	if cnt == 0 then		-- Not a proper update?
		return
	end

	local ch = Nx.CurCharacter

	local title = GetTradeSkillLine()
--	Nx.prt ("Trade %s", title)

	local profT = ch["Profs"][title]
	if not profT then
		return
	end

	local link = GetTradeSkillListLink()
	if link then
		profT["Link"] = link
	end

	for n = 1, cnt do

		local name, typ, available, isExpanded = GetTradeSkillInfo (n)
		if typ ~= "header" then

			local link = GetTradeSkillRecipeLink (n)	-- Alchemy research causes nil?
			local rId = link and strmatch (link, "enchant:(%d+)")

			local link = GetTradeSkillItemLink (n)
			local itemId = link and strmatch (link, "item:(%d+)") or 0

			if rId then
				profT[tonumber (rId)] = tonumber (itemId)
--			else
--				Nx.prt ("  %s", gsub (link, "|", "||"))
			end

--			Nx.prt ("#%s %s %s", n, name, link)
		end
	end
end

--PAIDE!

-------------------------------------------------------------------------------
-- EOF














