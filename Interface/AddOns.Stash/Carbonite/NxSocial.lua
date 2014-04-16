local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
--local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxSocial - Social Window (friends, guild)
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
-- Init

function Nx.Social:Init()

	self.List.Sorted = {}

	local opts = Nx:GetGlobalOpts()
	self.GOpts = opts

	if opts["SocialEnable"] then

--		Nx.prt ("SocialEnable")

		local ff = FriendsFrame
		GetUIPanelWidth (ff)
		ff:SetAttribute ("UIPanelLayout-enabled", false)

		hooksecurefunc ("PanelTemplates_SetTab", Nx.Social.PanelTemplates_SetTab)
	end

	self.Punks = Nx:GetSocial ("Pk")
	self.PunksActive = Nx:GetSocial ("PkAct")

	for k, v in pairs (self.PunksActive) do
		if not (v.MId and v.X and v.Y and v.Time) then	-- Munge changed?
			Nx:ClearSocial ("PkAct")
			self.PunksActive = Nx:GetSocial ("PkAct")
			break
		end
	end

	self.PunkNewDir = 0

	self.PunksHUD:Create()

	self.TeamHUD:Create()

	-- TEST!!

--	self.HookOrig = FriendsFrame_ShowSubFrame
--	FriendsFrame_ShowSubFrame = self.Hook
end

--[[
function Nx.Social.Hook (v)
	Nx.prt ("HOOK %s", v)
	Nx.Social.HookOrig (v)

	Nx.prtFrame ("GuildFrame", GuildFrame)
end
--]]

function Nx.Social:ShowUIPanel (frame)

	if not GameMenuFrame:IsShown() and not self.NoShow then

		if self.InOnTabBar then
			return
		end

--		Nx.prtFrame ("FF", frame)

		if InCombatLockdown() and(GetNumGroupMembers()>0 or _G["RaidGroupFrame_Update"]) then
			return
		end

--		Nx.prt ("Social:ShowUIPanel %s", debugstack (2, 3, 0))

--		if IsAltKeyDown() then
--			return
--		end

--		Nx.prt ("Social:ShowUIPanel")

		self.NoShow = true

		self:Create()

		local win = self.Win
		local wf	= win.Frm

		wf:Raise()

		if not win:IsShown() then		-- Toggle off?

--			Nx.prt ("Social:ShowUIPanel show win")

			win:Show()
			self:ShowBlizzTabs (false)

			self.Bar:Select (self.TabSelected, true)
		end

--[[	--V4
		local guildTabI = self.OrigTabI + 2

		self.Bar:Enable (guildTabI, IsInGuild() ~= nil)

		if self.TabSelected == guildTabI then

			local function func()
				GuildFrame:Show()
--				Nx.prt ("FF G UPD")
			end

			Nx.Timer:Start ("SocialFFUpdate", 0, self, func)
		end
--]]

		self.NoShow = false
	end
end

function Nx.Social:HideUIPanel (frame)

	if self.Win then

--		Nx.prt ("Social:HideUIPanel")

		self.NoShow = true

		self:RestoreFriendsFrame()
		self:Show (false)

		self.NoShow = false

--		Nx.prt ("Social:HideUIPanel2")
	end
end

--------

function Nx.Social:RestoreFriendsFrame()

	local ff = FriendsFrame

--	Nx.prtFrame ("RestoreFF", ff)

	if ff:GetParent() == self.FFHolder then

--		Nx.prt ("Social:RestoreFriendsFrame")

--		ff:SetAttribute ("UIPanelLayout-enabled", false)

		local l = ff:GetFrameLevel (ff)

--		self.Win:Detach (ff)
		self:ShowBlizzTabs()

		ff:SetParent (UIParent)		-- This can cause ShowUIPanel calls if Esc key was pressed
		ff:SetToplevel (true)
		ff:SetFrameLevel (l)
		ff:Raise()
		ff:Hide()
	end
end

--------
-- Open window

function Nx.Social:Show (on)

	self:Create()

	if self.Win then
		self.Win:Show (on)
	end
end

--------
-- Hide window. Used before combat lockdown

function Nx.Social:PreCombatHide()

	if self.Win then
		if IsInRaid() then

--			Nx.prt ("PreCombatHide")

			local ff = FriendsFrame
--			ff:SetAttribute ("UIPanelLayout-enabled", true)
--			ff:SetMovable (true)

			self:HideUIPanel (ff)
		end
	end
end

--------
-- Create window

function Nx.Social:Create()

	local opts = Nx:GetGlobalOpts()

	if not opts["SocialEnable"] then
		return
	end

	if self.Win then
		return
	end

	local tbH = Nx.TabBar:GetHeight()

	-- Create Window

	local win = Nx.Window:Create ("NxSocial")
	self.Win = win
	local frm = win.Frm

	win:CreateButtons (true, true)

	win:InitLayoutData (nil, -.25, -.18, -.5, -.64)

	frm:SetToplevel (true)
	frm:Hide()

	tinsert (UISpecialFrames, frm:GetName())

	win:SetUser (self, self.OnWin)
	win:RegisterEvent ("FRIENDLIST_SHOW", self.OnFriendListUpdate)
	win:RegisterEvent ("FRIENDLIST_UPDATE", self.OnFriendListUpdate)
	win:RegisterEvent ("GUILD_ROSTER_UPDATE", self.OnFriendListUpdate)

	-- FF

	local ffH = CreateFrame ("Frame", "NxSocFFH", UIParent)
	self.FFHolder = ffH

	ffH:SetWidth (384)
	ffH:SetHeight (512)

	local ff = FriendsFrame
	ff:SetParent (ffH)
	ff:SetPoint ("TOPLEFT", ffH, "TOPLEFT", 0, 0)

	win:Attach (ffH, 0, 1, 0, -tbH, 384 - 20, 512 - 40)

--	win:Attach (ff, 0, 1, 0, -tbH)

	-- Create Tab Bar

	local bar = Nx.TabBar:Create (nil, frm, 1, 1)
	self.Bar = bar

	win:Attach (bar.Frm, 0, 1, -tbH, 1)

	bar:SetUser (self, self.OnTabBar)

	local palw = 0
	local selected = 2
--PAIDS!
	palw = 40
	selected = 1
--PAIDE!

	local orig = 3

	bar:AddTab (L["Pals"], 1, palw)
	bar:AddTab (L["Punks"], 2, 46)

	if NxData.NXVerDebug then
		bar:AddTab (L["Com"], 3, 38)
		orig = 4
	end

	self.OrigTabI = orig

	bar:AddTab (L["Friends"], orig, 60, false, "FriendsFrameTabTemplate", 1)
	bar:AddTab (L["Who"], orig + 1, 45, false, "FriendsFrameTabTemplate", 2)
--	bar:AddTab ("Guild", orig + 2, 45, false, "FriendsFrameTabTemplate", 3)		--V4 moved
	bar:AddTab (L["Chat"], orig + 2, 45, false, "FriendsFrameTabTemplate", 3)
	bar:AddTab (L["Raid"], orig + 3, 45, false, "FriendsFrameTabTemplate", 4)

	--

	self.List:Create()

	self.TabSelected = selected
	bar:Select (selected)					-- Select after list is created
end

--------

function Nx.Social:OnWin (typ)

	if typ == "Close" then
		self:HideUIPanel (FriendsFrame)
	end
end

function Nx.Social:OnFriendListUpdate (event)

--[[
	Nx.prt ("OnFriendListUpdate %s", event)

	for n = 1, GetNumFriends() do
		local name, level, class, area, connected, status, note = GetFriendInfo (n)
		Nx.prt ("#%s %s", n, name or "nil")
	end
--]]

	self.List:Update()
end

--------

function Nx.Social:OnUpdate()

	if self.Win then

		local wf = self.Win.Frm
		if wf:IsVisible() then

			if self.Win:IsMovingOrSizing() then
				return
			end

--			Nx.prt ("Soc vis")

--[[
			local f = GuildControlPopupFrame
			if f:IsVisible() then

				if f:GetFrameStrata() ~= wf:GetFrameStrata() then
					f:SetFrameStrata (wf:GetFrameStrata())
				end

				if f:GetFrameLevel() <= self.Win.Frm:GetFrameLevel() then
					f:Raise()
--					Nx.prt ("raise")
				end
			end
--]]

			local f = ChannelFrameDaughterFrame
			if f:IsVisible() then
				f:SetFrameLevel (wf:GetFrameLevel() + 100)
			end
		end
	end
end

--------

function Nx.Social.PanelTemplates_SetTab (frame, index)

	local self = Nx.Social
	local ff = FriendsFrame

	if frame == ff and self.Bar and not self.InOnTabBar then

		index = index + self.OrigTabI - 1

--		Nx.prt ("PanelTemplates_SetTab #%s", index)
		self.Bar:Select (index)
	end
end

--------

function Nx.Social:OnTabBar (index, click, inSetTab)

	if self.InOnTabBar then
--		Nx.prt ("OnTabBar %s in tab bar", index)
		return
	end

--	Nx.prt ("OnTabBar %s", index)

--	local oldSel = self.TabSelected
	self.TabSelected = index

	if not self.Win:IsShown() then
--		Nx.prt ("OnTabBar %s !win", index)
		return
	end

	self.InOnTabBar = true
--[[
	if self.TabSelected == self.OrigTabI + 2 and not IsInGuild() then
		self.Bar:Select (oldSel)
		self.InOnTabBar = false
		return
	end
--]]
	local list = self.List.List
	local ff = FriendsFrame
	local tbH = Nx.TabBar:GetHeight()

	if ff:GetParent() ~= self.FFHolder then

--		Nx.prt ("OnTabBar %s Parent", index)

		local ffH = self.FFHolder

		ff:SetToplevel (false)
		ff:SetParent (ffH)
		ff:SetPoint ("TOPLEFT", ffH, "TOPLEFT", 0, 0)

		self:ShowBlizzTabs (false)
	end

	if index < self.OrigTabI then

		self.FFHolder:Hide()
		list.Frm:Show()

	else

		list.Frm:Hide()
		self.FFHolder:Show()
		ff:Show()
	end

	self.List:Update()

	self.InOnTabBar = false

--	Nx.prt ("OnTabBar %s done", index)
end

function Nx.Social:ShowBlizzTabs (show)

	for n = 1, 10 do
		local tabf = getglobal ("FriendsFrameTab" .. n)
		if tabf then
			if show ~= false then
				tabf:Show()
			else
				tabf:Hide()
			end
		end
	end
end

--------
-- Create social list

function Nx.Social.List:Create()

	local win = Nx.Social.Win
	local tbH = Nx.TabBar:GetHeight()

	-- Dummy frame
--[[
	local f = CreateFrame ("Frame", nil, UIParent)
	self.Frm = f
	f.NxSocialList = self

	f:SetMovable (true)
	f:EnableMouse (true)

	f:SetFrameStrata ("MEDIUM")

	local t = f:CreateTexture()
	t:SetTexture (.2, .2, .2, .5)
	t:SetAllPoints (f)
	f.texture = t

	f:Show()

	win:Attach (f, 0, .02, 0, -tbH)
--]]

	-- List

	Nx.List:SetCreateFont ("FontM")

	local list = Nx.List:Create (L["Social"], 2, -2, 100, 12 * 3, win.Frm)
	self.List = list

	list:SetUser (self, self.OnListEvent)
--	list:SetLineHeight (12)

	list:ColumnAdd ("", 1, 80)
	list:ColumnAdd (L["Character"], 2, 110)
	list:ColumnAdd (L["Lvl"], 3, 20)
	list:ColumnAdd (L["Class"], 4, 65)
	list:ColumnAdd (L["Zone"], 5, 150)
	list:ColumnAdd (L["Note"], 6, 500)

	win:Attach (list.Frm, 0, 1, 0, -tbH)

	-- FF

	local ff = FriendsFrame
	self.FriendsFrame = ff

	self:SetLevels()

	-- Generic menu

	local function funcOpenOptions()
		Nx.Opts:Open (L["Social & Punks"])
	end

	-- Create pals menu

	local menu = Nx.Menu:Create (list.Frm, 230)
	self.PalsMenu = menu

	local function func (self)
		if self.MenuSelName then

			local box = ChatEdit_ChooseBoxForSend()	--V4
			ChatEdit_ActivateChat (box)
			box:SetText ("/w " .. self.MenuSelName .. " " .. box:GetText())
--[[
			local frm = DEFAULT_CHAT_FRAME
			local eb = frm["editBox"]
			if not eb:IsVisible() then
				ChatFrame_OpenChat ("/w " .. self.MenuSelName, frm)
			else
				eb:SetText ("/w " .. self.MenuSelName .. " " .. eb:GetText())
			end
--]]
		end
	end

	menu:AddItem (0, L["Whisper"], func, self)

	local function func (self)
		if self.MenuSelName then
			InviteUnit (self.MenuSelName)
		end
	end

	menu:AddItem (0, L["Invite"], func, self)

	menu:AddItem (0, "")

	local function func (self)
		if UnitIsPlayer ("target") and UnitCanCooperate ("player", "target") then
--			Nx.prt ("target %s", UnitName ("target"))
			AddFriend (UnitName ("target"))			--V4 was AddFriend ("target")
		else
			StaticPopup_Show ("ADD_FRIEND")
		end
	end

	menu:AddItem (0, L["Add Pal And Friend"], func, self)

	local function func (self)
		if self.MenuSelName then
			self:ClrFriend (self.MenuSelName)
			local i = self:FindFriendI (self.MenuSelName)
			if i then
				RemoveFriend (self.MenuSelName)
			else
				self:Update()
			end
		end
	end

	menu:AddItem (0, L["Remove Pal And Friend"], func, self)

	menu:AddItem (0, "")

	local function func (self)
		if self.MenuSelName then
			local i = self:FindFriendI (self.MenuSelName)
			if i then
				self.FriendsFrame["NotesID"] = i
				StaticPopup_Show ("SET_FRIENDNOTE", GetFriendInfo (i))
			end
		end
	end

	self.PalMenuINote = menu:AddItem (0, L["Set Note"], func, self)
	menu:AddItem (0, L["Set Person"], self.Menu_OnSetPerson, self)

	menu:AddItem (0, "")

	menu:AddItem (0, L["Make Pal (Red) Into Friend"], self.Menu_OnMakePalFriend, self)
	menu:AddItem (0, L["Make All Pals Into Friends"], self.Menu_OnMakePalsFriends, self)

	menu:AddItem (0, "")
	menu:AddItem (0, L["Options..."], funcOpenOptions, self)

	-- Create punks menu

	local menu = Nx.Menu:Create (list.Frm)
	self.PunksMenu = menu

	local function func (self)
		self:GotoPunk (self.List.MenuSelName)
	end

	menu:AddItem (0, L["Goto"], func, Nx.Social)

	menu:AddItem (0, L["Add Character"], self.Menu_OnPunkAdd, self)
	menu:AddItem (0, L["Remove Character"], self.Menu_OnPunkRemove, self)

	menu:AddItem (0, L["Set Note"], self.Menu_OnPunkSetNote, self)

	local function func (self)
		Nx:ClearSocial ("PkAct")
		self.PunksActive = Nx:GetSocial ("PkAct")
	end

	menu:AddItem (0, L["Clear Actives"], func, Nx.Social)

	menu:AddItem (0, "")
	menu:AddItem (0, L["Options..."], funcOpenOptions, self)

end

function Nx.Social.List:SetLevels()

	local win = Nx.Social.Win
	local wf	= win.Frm
	local ff = self.FriendsFrame

	ff:SetToplevel (false)
--	ff:SetAlpha (1)

--	Nx.prt ("Lev1 "..wf:GetFrameLevel().." "..ff:GetFrameLevel())

	wf:Raise()

--	Nx.prt ("Lev2 "..wf:GetFrameLevel().." "..ff:GetFrameLevel())

	local f = getglobal ("FriendsFrameCloseButton")
	local lev = f:GetFrameLevel()
	ff:SetFrameLevel (lev - 1)
	wf:SetFrameLevel (lev - 2)

--	Nx.prt ("Lev3 "..wf:GetFrameLevel().." "..ff:GetFrameLevel())
end

function Nx.Social.List:Menu_OnSetPerson()

	if self.MenuSelName then
		local person = self:FindFriendPerson (self.MenuSelName) or ""
		Nx:ShowEditBox (L["Set person who owns character"], person, self.MenuSelName, self.SetPersonAccept)
	end
end

function Nx.Social.List.SetPersonAccept (person, friend)

	person = Nx.Util_CleanName (person)
	local list = Nx.Social.List
	list:SetPersonFriend (person, friend)
	list:Update()
end

function Nx.Social.List:Menu_OnMakePalFriend()
	if self.MenuSelName then
		AddFriend (self.MenuSelName)
	end
end

function Nx.Social.List:Menu_OnMakePalsFriends()

	local pal = Nx:GetSocial ("Pal")

	for _, friends in pairs (pal) do
		for fName, v in pairs (friends) do
			if not self:FindFriendI (fName) then	-- Not a friend?
				AddFriend (fName)
			end
		end
	end
end

function Nx.Social.List:Menu_OnPunkAdd()

	local name = UnitName ("target")

	if name and UnitIsPlayer ("target") and UnitIsEnemy ("player", "target") then
		self:PunkAdd (name, UnitLevel ("target"), UnitClass ("target"))
		self:Update()
	else
		Nx:ShowEditBox (L["Add punk name"], self.MenuSelName or Nx.Social.LastLocalPunk or "", self, self.PunkAddAccept)
	end
end

function Nx.Social.List.PunkAddAccept (name, list)

	list:PunkAdd (name)
	list:Update()
end

function Nx.Social.List:PunkAdd (name, level, class)

	local punks = Nx:GetSocial ("Pk")
	name = Nx.Util_CleanName (name)

	local punk = Nx.Social.PunksActive[name]
	if punk then
		level = level or punk.Lvl
		class = class or punk.Class
	end

	punks[name] = format ("%s~%s~%s", time(), level or "", class or "")
end

function Nx.Social.List:Menu_OnPunkRemove()
	if self.MenuSelName then
		local punks = Nx:GetSocial ("Pk")
		punks[self.MenuSelName] = nil
		self:Update()
	end
end

function Nx.Social.List:Menu_OnPunkSetNote()

	if self.MenuSelName then
		local punks = Nx:GetSocial ("Pk")
		local punk = punks[self.MenuSelName]

		if punk then
			self.MenuPunkName = self.MenuSelName
			local tm, lvl, class, note = strsplit ("~", punk)
			Nx:ShowEditBox (L["Set note"], note or "", self, self.PunkSetNote)
		end
	end
end

function Nx.Social.List.PunkSetNote (text, list)

	local punks = Nx:GetSocial ("Pk")
	local punk = punks[list.MenuPunkName]
	local tm, lvl, class, note = strsplit ("~", punk)
	punks[list.MenuPunkName] = format ("%s~%s~%s~%s", tm, lvl, class, text)
	list:Update()
end

--------
-- On list control updates

function Nx.Social.List:OnListEvent (eventName, sel, val2, click)

	local name = self.List:ItemGetData (sel)
	self.SelName = name

	local tabI = Nx.Social.TabSelected

	if tabI == 1 then

		local i = self:FindFriendI (name)
		if i then
--			Nx.prt ("Sel %s", i)
			SetSelectedFriend (i)
		end
	end

	if eventName == "select" or eventName == "mid" or eventName == "back" then

	elseif eventName == "menu" then

--		Nx.prt ("OnListEvent %s", val2)

		self.MenuSelName = self.SelName

		if tabI == 1 then

			local i = self:FindFriendI (self.SelName)
			self.PalMenuINote:Show (i ~= nil)

			self.PalsMenu:Open()

		elseif tabI == 2 then
			self.PunksMenu:Open()

		else
			self.ComMenu:Open()
		end

	end
end

function Nx.Social.List:FindFriendI (friend)

	local cnt = GetNumFriends()
	for n = 1, cnt do

		local name, level, class, area, connected, status, note = GetFriendInfo (n)

		if name == friend then
			return n
		end
	end
end

--------
-- Find person who has friend
-- (friend name)
-- ret person name

function Nx.Social.List:FindFriendPerson (friend)

	local pal = Nx:GetSocial ("Pal")

	for person, friends in pairs (pal) do
		for fname, v in pairs (friends) do
			if friend == fname then
				return person
			end
		end
	end
end

function Nx.Social.List:SetPersonFriend (person, friend)

	self:ClrFriend (friend)

	local pal = Nx:GetSocial ("Pal")

	local friends = pal[person] or {}
	pal[person] = friends

	friends[friend] = ""
end

--------
-- Clear friend from all persons

function Nx.Social.List:ClrFriend (friend)

	local pal = Nx:GetSocial ("Pal")

	for person, friends in pairs (pal) do
		friends[friend] = nil
--		Nx.prt ("delete %s", friend)

		if not next (friends) then		-- No friends left?
			if person ~= "" then
--				Nx.prt ("delete %s", person)
				pal[person] = nil
			end
		end
	end
end

function Nx.Social.List:Update()
--	self:Update_()
end

--------
--

function Nx.Social.List:Update_()

--	Nx.prt ("SocialListUpdate")

	local soc = Nx.Social

	local win = soc.Win
	local list = self.List
	if not (win and list) then		-- Can be called with nil List if GuildProfiler present during create
		return
	end

	self.SelName = nil

	local pal = Nx:GetSocial ("Pal")
	local tabI = soc.TabSelected

	win:SetTitle ("")

	list:Empty()

	if tabI == 1 then

--PAIDS!
		list:ColumnSetName (1, L["Person"])

		-- Person A Char A
		-- Person A Char B
		-- Person B Char A

		local data = {}
		local f2p = {}
		local fConnected = {}

		for pName, friends in pairs (pal) do
			for fName, _ in pairs (friends) do
				tinsert (data, format ("%s~%s", pName, fName))
				f2p[fName] = pName
			end
		end

		local fI = {}

		local cnt = GetNumFriends()

		for n = 1, cnt do
			local name, level, class, area, connected, status, note = GetFriendInfo (n)
			if name then

				fI[name] = n
				fConnected[name] = connected

				local pName = f2p[name]
				local pData = pal[pName or ""]

				if connected then
					pData[name] = format ("%s~%s", level, class)
				else
					pData[name] = pData[name] or ""	-- Keep last data or start a new entry
				end

				if not pName then
					tinsert (data, format ("~%s", name))
				end
			end
		end

		local function func (a, b)
			local pName1, fName1 = strsplit ("~", a)
			local pName2, fName2 = strsplit ("~", b)

			if fConnected[fName1] and not fConnected[fName2] then
				return true
			end
			if not fConnected[fName1] and fConnected[fName2] then
				return false
			end

			if pName1 == pName2 then
				return fName1 < fName2
			end
			if pName1 == "" then
				return false
			end
			if pName2 == "" then
				return true
			end

			return pName1 < pName2
		end

		sort (data, func)

		win:SetTitle (format (L["Pals: |cffffffff%d/%d"], cnt, 50))

		for _, plyr in ipairs (data) do

			local pName, fName = strsplit ("~", plyr)
			local i = fI[fName]

			list:ItemAdd (fName)

			local conCol = fConnected[fName] and "|cff80f080" or "|cff808080"

			if #pName > 0 then
				list:ItemSet (1, conCol .. pName)
			end

			if not i then
				conCol = "|cfff04040"
			end

			list:ItemSet (2, conCol .. fName)

			local name, level, class, area, connected, status, note

			if i then
				name, level, class, area, connected, status, note = GetFriendInfo (i)
			end

			if connected then
				list:ItemSet (5, area)
			else
				local pData = pal[pName]
				level, class = strsplit ("~", pData[fName])
			end

			if level ~= "" then
				list:ItemSet (3, format ("%s", level))
				local color = Nx.ClassColorStrs[NXlClassLocToCap[class]] or ""
				list:ItemSet (4, color .. class)
			end

			local s = status or ""

			if note then
				s = s .. " " .. note
			end

			list:ItemSet (6, s)
		end
--PAIDE!

	elseif tabI == 2 then

		list:ColumnSetName (1, L["Status"])

		local punks = soc.Punks
		local punksA = soc.PunksActive

		local tm = GetTime()
		local myCnt = 0
		local actCnt = 0

		local data = {}

		for pName, str in pairs (punks) do
			tinsert (data, pName)
		end

		sort (data)

		for _, pName in ipairs (data) do

			myCnt = myCnt + 1

			local tm, lvl, class, note = strsplit ("~", punks[pName])

			list:ItemAdd (pName)

			if punksA[pName] then
				list:ItemSet (1, L["|cffff6060Found"])
			end
			list:ItemSet (2, pName)

			if lvl and lvl ~= 0 then
				list:ItemSet (3, tostring (lvl))
			end

			if class then
				local color = Nx.ClassColorStrs[NXlClassLocToCap[class]] or ""
				list:ItemSet (4, color .. class)
			end

			if note and #note > 0 then
				list:ItemSet (6, note)
			end
		end

		list:ItemAdd()
		list:ItemAdd()
		list:ItemSet (2, L["|cff8080ff-- Active --"])

		local data = {}

		for pName in pairs (punksA) do
--			Nx.prt ("PkList %s", pName)
			tinsert (data, pName)
		end

--		Nx.prtVar ("", data)

		sort (data)

		for _, pName in ipairs (data) do

			actCnt = actCnt + 1

			local punk = punksA[pName]

			list:ItemAdd (pName)
			local seconds = tm - punk.Time
			list:ItemSet (1, format ("%d:%02d", seconds / 60 % 60, seconds % 60))

			local name = punks[pName] and pName or ("|cffafafaf" .. pName)
			list:ItemSet (2, name)
			if punk.Lvl ~= 0 then
				list:ItemSet (3, tostring (punk.Lvl))
			end
			if punk.Class then
				list:ItemSet (4, punk.Class)
			end
			local mapName = Nx.MapIdToName[punk.MId] or "?"
			list:ItemSet (5, format ("%s %d %d", mapName, punk.X, punk.Y))

			list:ItemSet (6, format (L["Near %s"], punk.FinderName))
		end

		win:SetTitle (format (L["Punks: %s  Active: %s"], myCnt, actCnt))

	elseif NxData.NXVerDebug and tabI == 3 then

		local actCnt = Nx.Util_tcount (Nx.Quest.CapturePlyrData)

		for _, data in pairs (Nx.Quest.CapturePlyrData) do
			list:ItemAdd()
			list:ItemSet (2, data.Name)
			list:ItemSet (3, data.Level)
			list:ItemSet (6, format ("%s/%s", data.RcvCnt, data.Total))
		end

		if actCnt > 0 then
			list:ItemAdd()
		end

		local data = Nx.Com:SortUserQuests()

		local cnt = 0
		local qcnt = 0

		for n, msg in ipairs (data) do

			local name, ver, r, c, dt, ver1, qCnt, lvl, mId = strsplit ("^", msg)
			ver = tonumber (ver)

			cnt = cnt + 1
			qcnt = qcnt + (qCnt or 0)

			list:ItemAdd()
			list:ItemSet (2, name)
			if lvl then
				list:ItemSet (3, tostring (tonumber (lvl, 16)))
			end

			if mId then
				local name = Nx.MapIdToName[tonumber (mId, 16)] or "?"
				list:ItemSet (5, name)
			end

			local i = strfind (msg, "%^")
			if i then
				msg = strsub (msg, i + 1)
			end
			list:ItemSet (6, msg)
		end

		local capCnt = Nx.Util_tcount (Nx:GetCap()["Q"])

		win:SetTitle (format (L["Total: %s Q%s, active %s, data %s"], cnt, qcnt, actCnt, capCnt))
	end

	list:Update()
end

-------------------------------------------------------------------------------
-- Punks management

function Nx.Social:DecodeComRcvPunks (finderName, info, punksStr)

--	Nx.prt ("%s: %s %s %s", finderName, punksStr, info.X, info.Y)

	local punksT = { strsplit ("!", punksStr) }

	for n, v in ipairs (punksT) do

		local lvl = tonumber (strsub (v, 1, 2), 16)
		if not lvl then	-- Error?
			break
		end

		local name = strsub (v, 3)
		if lvl >= 0xff then
			name = strsub (v, 9)
			lvl = 0
		end

		local punk = self:GetPunk (name, nil, info.MId, info.X, info.Y)

		punk.FinderName = finderName
		punk.Lvl = max (lvl, punk.Lvl or 0)
		punk.Time = info.T
	end

	if not Nx.Timer:IsActive ("SocialUpdate") then
		Nx.Timer:Start ("SocialUpdate", 2, self, self.OnUpdateTimer)
	end
end

--------
-- Add a punk we detected ourselves

function Nx.Social:AddLocalPunk (name, plyrNear, level, class)

--	Nx.prt ("AddLocalPunk %s", name)

	if Nx.InBG and not plyrNear then
		return
	end

	local map = Nx.Map:GetMap (1)

	name = strmatch (name, "[^-]+")		-- Remove server name

	self.LastLocalPunk = name

	local rMapId = map.RMapId
	local x, y = map.PlyrRZX, map.PlyrRZY

	if plyrNear then
		
		plyrNear = strmatch (plyrNear, "[^-]+")		-- Remove server name
		local i = Nx.GroupMembers[plyrNear]

		if i then

			local unit = Nx.GroupType .. i
			local s = UnitName (unit)
			if s then

				local pX, pY = GetPlayerMapPosition (unit)

				if pX ~= 0 or pY ~= 0 then
					x = pX * 100
					y = pY * 100
				end

				-- DEBUG!
--				if IsControlKeyDown() then
--					Nx.prt ("Local punk %s near %s #%s %s %s", name, plyrNear, i, x, y)
--				end
			end
		end
	end

	-- DEBUG!
--	if IsControlKeyDown() then
--		Nx.prt ("-Local punk %s near %s %s %s", name, plyrNear or "nil", x, y)
--	end

	local punk = self:GetPunk (name, plyrNear, rMapId, x, y)

	if not punk.Time and not Nx.InBG and self.GOpts["PunkNewLocalWarnChat"] then	-- New?

		if not Nx.InSanctuary or self.GOpts["PunkShowInSafeArea"] then
--		if (rMapId ~= 3006 and rMapId ~= 4003 and rMapId ~= 4012) or self.GOpts["PunkShowInSafeArea"] then

			local typ = self.Punks[name] and L["|cffff4040Punk"] or L["Enemy"]

			Nx.prt (L["%s %s detected near you"], typ, name)

			if self.GOpts["PunkNewLocalWarnSnd"] then
				Nx:PlaySoundFile ("sound\\doodad\\belltolltribal.wav")
			end
		end
	end

	punk.FinderName = "me"
	punk.Lvl = level or punk.Lvl or 0
	punk.Class = class or punk.Class
	if not punk.Time or GetTime() - punk.Time > 2 then
		punk.Time = GetTime()
	end

	if not Nx.Timer:IsActive ("SocialUpdate") then
		Nx.Timer:Start ("SocialUpdate", 2, self, self.OnUpdateTimer)
	end

	self.PunksHUD:Add (name)
end

--------

function Nx.Social:GetPunk (name, plyrNear, mId, x, y)

	local punk = self.PunksActive[name]
	if not punk then
		punk = {}
		self.PunksActive[name] = punk

		punk.DrawDir = self.PunkNewDir

		self.PunkNewDir = self.PunkNewDir + 3.14159 / 4.25

		punk.CircleTime = GetTime()
	end

	if not Nx.InBG or not punk.PlyrNear or plyrNear and plyrNear ~= punk.PlyrNear then

--		Nx.prt ("Punk %s near %s %s %s", name, plyrNear or "nil", x, y)

		punk.PlyrNear = plyrNear
		punk.MId = mId
		punk.X = x
		punk.Y = y
	end

--	punk.Alert = nil

	if not punk.Alert and self.Punks[name] then

		self.PunksHUD:Add (name)

		if self.GOpts["PunkMAlertText"] then

			local tm, lvl, class, note = strsplit ("~", self.Punks[name])

--			note = "Test note. xyz. abc 12213213872xxx"

			if note then
				UIErrorsFrame:AddMessage (format (L["Note: %s"], note), 1, 0, 1, 1)
			end

			local map = Nx.Map:GetMap (1)
			local wx, wy = map:GetWorldPos (mId, x, y)
			local dist = ((map.PlyrX - wx) ^ 2 + (map.PlyrY - wy) ^ 2) ^ .5 * 4.575
			local s = dist < 100 and L["|cffff4000near you"] or format (L["at %d yards"], dist)

			UIErrorsFrame:AddMessage (format (L["|cffff4000%s|r detected %s!"], name, s), 1, 1, 0, 1)
		end
		if self.GOpts["PunkMAlertSnd"] then
			Nx:PlaySoundFile ("sound\\spells\\antiholy.wav")
		end
		punk.Alert = true
	end

	if GetTime() - punk.CircleTime > 4 then	-- Long enough for visual refresh?
		punk.CircleTime = GetTime()
	end

	return punk
end

--------

function Nx.Social:OnUpdateTimer()

	self:CalcPunks()

	-- Check tab selection first, since they could be nil
	if self.TabSelected == 2 and self.Win:IsShown() then
		self.List:Update()
		return 3
	end
end

--------
-- Update punks data

function Nx.Social:CalcPunks()

	local punks = self.Punks
	local punksA = self.PunksActive
	local tm = GetTime() - (Nx.InBG and 30 or 90)				-- Expire time (1.5 min)

	for pName, punk in pairs (punksA) do

		if punks[pName] then					-- On our list?
			if tm - 240 > punk.Time then	-- Expired? (5 mins)
				punksA[pName] = nil
				self.PunksHUD:Remove (pName)
			end
		else
			if tm > punk.Time then			-- Expired?
				punksA[pName] = nil
				self.PunksHUD:Remove (pName)
			end
		end
	end
end

--------
-- Update map icons (called by map)

function Nx.Social:UpdateIcons (map)

	if Nx.Tick % 120 == 4 then
		self:CalcPunks()
	end

	local math = math
	local alt = IsAltKeyDown()
	local tm = GetTime()

	local idToName = Nx.MapIdToName
	local punks = self.Punks
	local punksA = self.PunksActive

	local size = self.GOpts["PunkAreaSize"] * map.ScaleDraw
	local sizeM = self.GOpts["PunkMAreaSize"] * map.ScaleDraw

	local areaR, areaG, areaB = Nx.Util_num2rgba (self.GOpts["PunkAreaColor"])
	local iconR, iconG, iconB, iconA = Nx.Util_num2rgba (self.GOpts["PunkIconColor"])
	local areaRM, areaGM, areaBM = Nx.Util_num2rgba (self.GOpts["PunkMAreaColor"])

	local showInNorthrend = self.GOpts["PunkShowInNorthrend"]
	local showInSafeArea = self.GOpts["PunkShowInSafeArea"]

	local decay = .24
	local decayM = .21

	local inBG = Nx.InBG

	if inBG then
		if not self.GOpts["PunkShowInBG"] or Nx.Free then
			return
		end

		size = self.GOpts["PunkBGAreaSize"] * map.ScaleDraw
		areaR, areaG, areaB = Nx.Util_num2rgba (self.GOpts["PunkBGAreaColor"])

		local decay = 2
		local decayM = .25
	end

	local iconGlow = abs (GetTime() * 400 % 200 - 100) / 400 + .75

	if alt then
		map.Level = map.Level + 11
	end

	for pName, punk in pairs (punksA) do

		local dur = tm - punk.Time
		local circleDur = tm - punk.CircleTime
		local punkMId = punk.MId

		local wx, wy = map:GetWorldPos (punkMId, punk.X, punk.Y)
		local x = wx + math.sin (punk.DrawDir) * 2
		local y = wy + math.cos (punk.DrawDir) * 2

		-- DEBUG!
--		if IsControlKeyDown() then
--			local sz = size / (circleDur * decay + 1)
--			Nx.prt ("Punk %s near %s %s %s sz%s", pName, punk.PlyrNear or "nil", x, y, sz)
--		end

		if punks[pName] then	-- Punk match?

			local sz = sizeM / (circleDur * decayM + 1)

			if sz >= 1 then
				sz = max (sz, 25)

				local f = map:GetIconNI()

				if map:ClipFrameW (f, x, y, sz, sz, 0) then

					f.texture:SetBlendMode ("ADD")
					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCircle")

					if dur < .1 then
						f.texture:SetVertexColor (.3, 1, .3, 1)
					else
						f.texture:SetVertexColor (areaRM, areaGM, areaBM, 1)
					end
				end
			end

		else

			if (not Nx.InSanctuary or showInSafeArea) and
--			if ((punkMId ~= 3006 and punkMId ~= 4003 and punkMId ~= 4012) or showInSafeArea) and
				((punkMId < 4000 or punkMId > 4999) or showInNorthrend) then

				local sz = size / (circleDur * decay + 1)

				if sz >= 1 then
					sz = max (sz, 22)

					local f = map:GetIconNI()

					if map:ClipFrameW (f, x, y, sz, sz, 0) then

						f.texture:SetBlendMode ("ADD")
						f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCircle")

						if dur < .05 then
							if inBG then
								f.texture:SetVertexColor (.15, .15, .15, 1)
							else
								f.texture:SetVertexColor (.25, .25, .25, 1)
							end
						else
							f.texture:SetVertexColor (areaR, areaG, areaB, 1)
						end
					end
				end
			end
		end

		-- Draw punk dot

		if punks[pName] then	-- Punk match?

			local f = map:GetIcon (2)

			if map:ClipFrameW (f, x, y, 14, 14, 0) then

				local lvl = punk.Lvl > 0 and punk.Lvl or "?"
				local mapName = idToName[punkMId] or "?"

				f.NxTip = format (L["*|cffff0000%s %s, %d:%02d ago\n%s (%d,%d)"], pName, lvl, dur / 60 % 60, dur % 60, mapName, punk.X, punk.Y)
				f.NXType = 3001
				f.NXData = pName
				f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconPlyrZ")
				f.texture:SetVertexColor (iconR, iconG, iconB, iconA * iconGlow)

				if alt then
					local txt = map:GetText (format ("*|cffff0000%s|r*", pName))
					map:MoveTextToIcon (txt, f, 18, 1)
				end
			end

		else

			if (not Nx.InSanctuary or showInSafeArea) and
--			if ((punkMId ~= 3006 and punkMId ~= 4003 and punkMId ~= 4012) or showInSafeArea) and
				((punkMId < 4000 or punkMId > 4999) or showInNorthrend) then

				local i = dur < 10 and 2 or 1
				local f = map:GetIcon (i)

				if map:ClipFrameW (f, x, y, 10, 10, 0) then

					local lvl = punk.Lvl > 0 and punk.Lvl or "?"
					local mapName = idToName[punkMId] or "?"

					f.NxTip = format (L["|cffff6060%s %s, %d:%02d ago\n%s (%d,%d)"], pName, lvl, dur / 60 % 60, dur % 60, mapName, punk.X, punk.Y)
					f.NXType = 3001
					f.NXData = pName

					f.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconPlyrZ")

					if dur < 10 then
						f.texture:SetVertexColor (iconR, iconG, iconB, iconA * iconGlow)
					else
						f.texture:SetVertexColor (iconR, iconG, iconB, iconA * .6)
					end
				end
			end
		end
	end

	if alt then
		map.Level = map.Level - 11
	else
		map.Level = map.Level + 3
	end
end

--------
-- Goto a named punk

function Nx.Social:GotoPunk (name)

	local punk = self.PunksActive[name]
	if punk then

		local map = Nx.Map:GetMap (1)
		local wx, wy = map:GetWorldPos (punk.MId, punk.X, punk.Y)
		local x = wx + math.sin (punk.DrawDir) * 2
		local y = wy + math.cos (punk.DrawDir) * 2

		map:SetTarget ("Goto", x, y, x, y, false, 0, name)
	end
end

--------
-- Get a named punks paste info

function Nx.Social:GetPunkPasteInfo (name)

	local punk = self.PunksActive[name]
	if punk then

		local lvl = punk.Lvl > 0 and punk.Lvl or "?"
		local class = punk.Class or "?"
		return format (L["Punk: %s, %s %s at %s %d %d"], name, lvl, class, Nx.MapIdToName[punk.MId] or "?", punk.X, punk.Y)
	end

	return ""
end

-------------------------------------------------------------------------------

--------
-- Create punk HUD

function Nx.Social.PunksHUD:Create()

--PAIDS!

	local opts = Nx:GetGlobalOpts()
	self.Opts = opts

	self.Punks = {}
	self.Buts = {}
	self.NumButs = opts["PunkTWinMaxButs"]
	self.NumButsUsed = 0

	self.Changed = true

	-- Create Window

--	Nx.Window:ClrSaveData ("NxPunkHUD")		-- DEBUG!

	Nx.Window:SetCreateFade (.5, 0)

	local win = Nx.Window:Create ("NxPunkHUD", nil, nil, true, 1, 1, nil, true)
	self.Win = win

	win:InitLayoutData (nil, -.6, -.1, 128, 68)

--	win:CreateButtons (nil, true)

	win:SetBGAlpha (0, .5)
	win.Frm:SetToplevel (true)

	-- Create buttons

	local ox, oy = win:GetClientOffset()
	local x = ox - 2
	local y = -oy

	for n = 1, self.NumButs do

--		Nx.prt ("But #%s create", n)

		local but = CreateFrame ("Button", nil, win.Frm, "SecureUnitButtonTemplate")
		self.Buts[n] = but

		but:SetPoint ("TOPLEFT", x, y)
		y = y - 13

		but:SetAttribute ("type1", "macro")
--		but:SetAttribute ("macrotext1", "/targetenemy")

--		but:SetAttribute ("type2", "target")
--		but:SetAttribute ("unit", "player")

		but:SetAttribute ("*type2", "click")
		but:SetAttribute ("*clickbutton2", but)

		but["Click"] = Nx.Social.PunksHUD.Click

		but:RegisterForClicks ("LeftButtonDown", "RightButtonDown")

		local t = but:CreateTexture()
		t:SetTexture (1, 1, 1, 1)
		t:SetAllPoints (but)
		but.texture = t

		but:SetWidth (125)
		but:SetHeight (12)

		but:Hide()

		local fstr = but:CreateFontString()
		but.NXFStr = fstr
		fstr:SetFontObject ("GameFontNormalSmall")
		fstr:SetJustifyH ("LEFT")
		fstr:SetPoint ("TOPLEFT", 0, 1)
		fstr:SetWidth (125)
		fstr:SetHeight (12)
	end

--PAIDE!

end

--------
-- SecureTemplates Click handler
-- self is button frame

function Nx.Social.PunksHUD:Click()

	local but = self
--	Nx.prt ("click %s", but.NXName or "nil")

	if IsShiftKeyDown() then
		Nx.Social.List:PunkAdd (but.NXName)
		Nx.prt (L["Punk %s added"], but.NXName or "")
	else
		Nx.Social.PunksHUD:Remove (but.NXName)
	end
end

--------

function Nx.Social.PunksHUD:Add (name)

--PAIDS!

	if not self.Punks[name] then

		local punks = Nx.Social.Punks

		if punks[name] then		-- Match?
			tinsert (self.Punks, 1, name)		-- Top of list

		else
			local found
			for n = 1, #self.Punks do
				if not punks[self.Punks[n]] then
					tinsert (self.Punks, n, name)		-- Top of non matches
					found = true
					break
				end
			end
			if not found then
				tinsert (self.Punks, name)		-- End
			end
		end
	end

	self.Punks[name] = true
	self.Changed = true

--PAIDE!
end

--------

function Nx.Social.PunksHUD:Remove (name)

--PAIDS!

	for n = 1, #self.Punks do
		if self.Punks[n] == name then
			tremove (self.Punks, n)
			break
		end
	end

	self.Punks[name] = nil
	self.Changed = true

--PAIDE!
end

--------

function Nx.Social.PunksHUD:Update()

--PAIDS!

	if not self.Win then
		return
	end

	local Social = Nx.Social

	if self.Changed then

		local lockDown = InCombatLockdown() ~= nil
		local lchanged = self.LockedDown ~= lockDown
		self.LockedDown = lockDown

		if not lockDown then

			self.Changed = false

			local punks = Social.Punks
			local punksA = Social.PunksActive

			local n = 1

			for index, name in ipairs (self.Punks) do

				local punk = self.Punks[name]

--				Nx.prt ("But #%s update %s", n, name)

				local but = self.Buts[n]

				local function func (self)
					Nx.prt ("hey")
				end

				but:SetAttribute ("macrotext1", "/targetexact " .. name)
--				but:SetAttribute ("shift-macrotext1", "/target " .. name .. "-target")

				but.NXName = name

				local s = name

				if punks[name] then	-- Match?
					s = "|cffff80ff*" .. name
				end

				local class = punksA[name] and punksA[name].Class
				if class then
					s = s .. ", |cffa0a0a0" .. class
				end

				but.NXFStr:SetText (s)
				but:Show()

				n = n + 1
				if n > self.NumButs then
					break
				end
			end

			self.NumButsUsed = n - 1

			for i = n, self.NumButs do
				local but = self.Buts[i]
				but:Hide()
			end

			self.Win:SetSize (120, n * 13 - 15)
		end

		if lchanged then

			local win = self.Win

			if lockDown then
				win:SetTitle ("|cffff2020" .. self.Opts["PunkTWinTitle"])
			else
				win:SetTitle (self.Opts["PunkTWinTitle"])
			end
		end
	end

	--

	local punksA = Social.PunksActive
	local tm = GetTime()

	for n = 1, self.NumButsUsed do

		local but = self.Buts[n]
		local punk = punksA[but.NXName]
		if punk then

			local dur = tm - punk.Time
			dur = dur < .3 and dur or dur * .05 + .285		-- Quick pulse, then slow fade
--			Nx.prt ("Punk #%s %s", n, dur)
			local r = min (max (1 - dur, .1), 1)
			but.texture:SetVertexColor (r, 0, 0, .5)
		end
	end

--PAIDE!
end

-------------------------------------------------------------------------------

--------
-- Create group HUD

function Nx.Social.TeamHUD:Create()

--PAIDS!

	local opts = Nx:GetGlobalOpts()
	if not opts["TeamTWinEnable"] then
		return
	end

	self.Players = {}

	for n = 1, MAX_RAID_MEMBERS do
		local data = {}
		data.Dist = 999999999
		self.Players[n] = data
	end

	self.Buts = {}
	self.NumButs = opts["TeamTWinMaxButs"]
	self.HealthFrms = {}
	self.FStrs = {}

	self.UpdateTime = 0

	-- Create Window

--	Nx.Window:ClrSaveData ("NxTeamHUD")		-- DEBUG!

	Nx.Window:SetCreateFade (.5, 0)

	local win = Nx.Window:Create ("NxTeamHUD", 20, nil, true, 1, nil, true, true)	-- Hidden
	self.Win = win

	win:SetBGAlpha (0, 1)

	win:InitLayoutData (nil, -.6, -.3, 100, 10)

--	win:CreateButtons (nil, true)

	win.Frm:SetToplevel (true)

	-- Create buttons

	local ox, oy = win:GetClientOffset()
	local x = ox - 2
	local y = -oy

	for n = 1, self.NumButs do

--		Nx.prt ("But #%s create", n)

		local but = CreateFrame ("Button", nil, win.Frm, "SecureUnitButtonTemplate")
		self.Buts[n] = but

		but:SetPoint ("TOPLEFT", x, y)
		y = y - 14

		if n == 1 then
			but:SetAttribute ("type", "target")
			but:SetAttribute ("unit1", "player")
			but:SetAttribute ("unit2", "targetenemy")
		else
			but:SetAttribute ("type", "macro")
			but:Hide()
		end

		but:RegisterForClicks ("LeftButtonDown", "RightButtonDown")

		local t = but:CreateTexture()
		t:SetTexture (0, .1, 0, .9)
		t:SetAllPoints (but)
		but.texture = t

		but:SetWidth (50)
		but:SetHeight (12)

		local f = CreateFrame ("Frame", nil, but)
		self.HealthFrms[n] = f

		f:SetPoint ("TOPLEFT", 0, 0)

		local t = f:CreateTexture()
--		t:SetTexture (0, .1, 0, .4)
		t:SetAllPoints (f)
		f.texture = t

--		f:SetWidth (50)
		f:SetHeight (12)

		local fstr = f:CreateFontString()
		self.FStrs[n] = fstr
		fstr:SetAllPoints (but)
		fstr:SetFontObject ("GameFontNormalSmall")
		fstr:SetJustifyH ("LEFT")
		fstr:SetPoint ("TOPLEFT", 0, 0)
		fstr:SetWidth (50)
		fstr:SetHeight (12)

		fstr:SetText ("Me")
	end

--PAIDE!
end

--------

function Nx.Social.TeamHUD:Update()

--PAIDS!

	if not self.Win or not self.Win.Frm:IsVisible() then
		return
	end

	local tm = GetTime()
	local update = tm - self.UpdateTime > 1
	if update then
		self.UpdateTime = tm
	end

	local cw, ch = self.Win:GetSize()

	local Social = Nx.Social
	local lockDown = InCombatLockdown() ~= nil
	local lchanged = self.LockedDown ~= lockDown
	self.LockedDown = lockDown

	if update and not lockDown then

		local Map = Nx.Map
		local map = Map:GetMap (1)
		local mapId, plX, plY = map.RMapId, map.PlyrRZX, map.PlyrRZY
		local plX, plY = Map:GetWorldPos (mapId, plX, plY)

		local inArena = Nx.InArena

		local members = MAX_PARTY_MEMBERS
		local unitName = "party"
		local maxDist = 999999990

		if IsInRaid() then		-- Arenas are raids
			members = MAX_RAID_MEMBERS
			unitName = "raid"
			maxDist = 250
		end

		for n = 1, members do

			local player = self.Players[n]

			local unit = unitName .. n
			local name = UnitName (unit)
			player.Name = name or "zzz"

--			if IsControlKeyDown() then
--				Nx.prt ("%s %s", n, name or "nil")
--			end

			player.Dist = 999999999

			if name and not UnitIsUnit (unit, "player") then

				player.Unit = unit

--				Nx.prt ("Pal %s %s", name, per)

				local pX, pY = GetPlayerMapPosition (unit)

				if pX == 0 then
					player.Dist = 999999
				else

					pX = pX * 100
					pY = pY * 100

					local wx, wy = Map:GetWorldPos (map.MapId, pX, pY)
					local dist = (plX - wx) ^ 2 + (plY - wy) ^ 2
					player.Dist = dist ^ .5 * 4.575
				end
			end
		end

		if not lockDown then

			if inArena then
				sort (self.Players, function (a, b) return a.Name < b.Name end)
			else
				local func = function (a, b)
						if a.Dist < 100 then
							if b.Dist < 100 then
								return a.Name < b.Name
							end
							return true
						else
							if b.Dist < 100 then
								return false
							end
							return a.Dist < b.Dist
						end
						return a.Name < b.Name
					end
				sort (self.Players, func)
			end

			local but = self.Buts[1]
			but:SetWidth (cw)

			local n = 2

			for index, player in ipairs (self.Players) do

				player.But = nil

				if player.Dist < maxDist or player.Dist == 999999 then

					local name = player.Name

--					Nx.prt ("But #%s update %s", n, name)

					local but = self.Buts[n]
					player.But = but
					player.FrmI = n

					but:SetAttribute ("macrotext1", "/targetexact " .. name)
					but:SetAttribute ("macrotext2", "/target " .. name .. "-target")

					but:SetWidth (cw)
					but:Show()

					local f = self.HealthFrms[n]
					player.HealthFrm = f

					n = n + 1
					if n > self.NumButs then
						break
					end
				end
			end

			for i = n, self.NumButs do
				local but = self.Buts[i]
				but:Hide()
			end

			self.Win:SetSize (cw, n * 14 - 14)
		end
	end

	-- Update text

	local fstr = self.FStrs[1]

	local h = UnitIsDeadOrGhost ("player") and 0 or UnitHealth ("player")
	local per = min (h / UnitHealthMax ("player"), 1)		-- Can overflow?

--	Nx.prt ("%s %s", h, per)
	local f = self.HealthFrms[1]
	f:SetWidth (per * cw + 1)
	f.texture:SetTexture (1 - per, per, 0, .5)

	local plTarget = UnitName ("target")

	for index, player in ipairs (self.Players) do

		local but = player.But
		if but then

			local unit = player.Unit

			local h = UnitIsDeadOrGhost (unit) and 0 or UnitHealth (unit)
			local per = min (h / UnitHealthMax (unit), 1)		-- Can overflow?

			local f = player.HealthFrm
			f:SetWidth (per * cw + 1)
			f.texture:SetTexture (.6 - per * .6, per * .6, 0, .7)

			local name = player.Name
--			local cls = UnitClass (unit) or ""
			local targetStr = plTarget == name and "|cff8080ff>" or ""
			local combatStr = UnitAffectingCombat (unit) and "|cffff4040*" or ""
			local colStr = player.Dist < 41 and "|cffc0ffc0" or "|cff808080"
			local distStr = player.Dist ~= 999999 and format (L["%d yds"], player.Dist) or ""
			local s = format ("%s%s%s%s %s", targetStr, combatStr, colStr, name, distStr)

			self.FStrs[player.FrmI]:SetText (s)
		end
	end

	if lchanged then

		local win = self.Win

		if lockDown then
			win:SetTitle (L["|cffff2020Team:"])
		else
			win:SetTitle ("Team:")
		end
	end

--PAIDE!
end

-------------------------------------------------------------------------------
-- EOF

















