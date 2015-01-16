local _, T = ...
if T.Mark ~= 23 then return end
local EV, G, L = T.Evie, T.Garrison, T.L

local roamingParty, easyDrop = T.MissionsUI.roamingParty, T.MissionsUI.easyDrop
local MISSION_PAGE_FRAME = GarrisonMissionFrame.MissionTab.MissionPage

do -- GarrisonFollowerList_SortFollowers
	local toggle = CreateFrame("CheckButton", nil, GarrisonMissionFrameFollowers, "InterfaceOptionsCheckButtonTemplate")
	toggle:SetSize(24, 24) toggle:SetHitRectInsets(0,0,0,0)
	toggle:SetPoint("LEFT", GarrisonMissionFrameFollowers.SearchBox, "RIGHT", 12, 0)
	toggle:SetScript("OnClick", function(self)
		MasterPlan:SetSortFollowers(self:GetChecked())
	end)
	
	local missionFollowerSort do
		local finfo, cinfo, tinfo, mlvl
		local statusPriority = {
		  [GARRISON_FOLLOWER_WORKING] = 5,
		  [GARRISON_FOLLOWER_ON_MISSION] = 4,
		  [GARRISON_FOLLOWER_EXHAUSTED] = 3,
		  [GARRISON_FOLLOWER_INACTIVE] = 2,
		  [""]=1,
		}
		local function cmp(a, b)
			local af, bf = finfo[a], finfo[b]
			local ac, bc = af.isCollected and 1 or 0, bf.isCollected and 1 or 0
			if ac == bc then
				ac, bc = statusPriority[af.status] or 6, statusPriority[bf.status] or 6
			end
			if ac == bc then
				ac, bc = cinfo[af.followerID] and (#cinfo[af.followerID])*100 or 0, cinfo[bf.followerID] and (#cinfo[bf.followerID])*100 or 0
				ac, bc = ac + (tinfo[af.followerID] and #tinfo[af.followerID] or 0), bc + (tinfo[bf.followerID] and #tinfo[bf.followerID] or 0)
				if (ac > 0) ~= (bc > 0) then
					return ac > 0
				elseif ac > 0 and ((af.level >= mlvl) ~= (bf.level >= mlvl)) then
					return af.level >= mlvl
				end
			end
			if ac == bc then
				ac, bc = af.level, bf.level
			end
			if ac == bc then
				ac, bc = af.iLevel, bf.iLevel
			end
			if ac == bc then
				ac, bc = af.quality, bf.quality
			end
			if ac == bc then
				ac, bc = 0, strcmputf8i(af.name, bf.name)
			end
			return ac > bc
		end
		function missionFollowerSort(t, followers, counters, traits, level)
			finfo, cinfo, tinfo, mlvl = followers, counters, traits, level
			table.sort(t, cmp)
			finfo, cinfo, tinfo, mlvl = nil
		end
	end
	local oldSortFollowers = GarrisonFollowerList_SortFollowers
	function GarrisonFollowerList_SortFollowers(self)
	   local followerCounters = GarrisonMissionFrame.followerCounters
	   local followerTraits = GarrisonMissionFrame.followerTraits
		for k,v in pairs(self.followers) do
			local tmid = MasterPlan:GetFollowerTentativeMission(v.followerID)
			if tmid and (v.status or "") == "" then
				v.status = GARRISON_FOLLOWER_IN_PARTY
			elseif (v.status or "") == "" and T.config.ignore[v.followerID] then
				v.status = GARRISON_FOLLOWER_WORKING
			end
		end
		toggle:SetShown(GarrisonMissionFrame.MissionTab:IsShown())
		local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
	   if followerCounters and followerTraits and GarrisonMissionFrame.MissionTab:IsVisible() and mi and MasterPlan:GetSortFollowers() then
			return missionFollowerSort(self.followersList, self.followers, followerCounters, followerTraits, mi.level)
		end
		return oldSortFollowers(self)
	end
	EV.RegisterEvent("MP_SETTINGS_CHANGED", function(_, s)
		if (s == nil or s == "sortFollowers") then
			if GarrisonMissionFrame:IsVisible() then
				GarrisonFollowerList_UpdateFollowers(GarrisonMissionFrame.FollowerList)
			end
			toggle:SetChecked(MasterPlan:GetSortFollowers())
		end
	end)
end

local GarrisonFollower_OnDoubleClick do
	local old = GarrisonFollowerListButton_OnClick
	local function resetAndReturn(followerFrame, ...)
		followerFrame.FollowerList.canExpand = true
		GarrisonFollowerList_Update(followerFrame)
		return ...
	end
	function GarrisonFollowerListButton_OnClick(self, ...)
		local followerFrame = self:GetParent():GetParent().followerFrame
		if self.PortraitFrame and self.PortraitFrame:IsMouseOver() and GarrisonMissionFrame.MissionTab.MissionPage.missionInfo and GarrisonMissionFrame.MissionTab.MissionPage:IsShown() then
			followerFrame.FollowerList.canExpand = false
			return resetAndReturn(followerFrame, old(self, ...))
		end
		return old(self, ...)
	end
	function GarrisonFollower_OnDoubleClick(self)
		if self.PortraitFrame and self.PortraitFrame:IsMouseOver() then
			local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
			local fi = self.info
			if fi and fi.followerID and mi and mi.missionID and fi.status == nil then
				local f = GarrisonMissionFrame.MissionTab.MissionPage.Followers
				for i=1, mi.numFollowers do
					if not f[i].info then
						GarrisonMissionPage_SetFollower(f[i], fi)
						GarrisonFollowerButton_Collapse(self)
						return
					end
				end
				if mi.numFollowers == 1 then
					GarrisonMissionPage_SetFollower(f[1], fi)
				else
					local f1, f2, f3 = f[1].info, f[2].info, f[3].info
					f1, f2, f3 = f1 and f1.followerID, f2 and f2.followerID, f3 and f3.followerID
					local g = G.GetBackfillMissionGroups(mi, G.GroupFilter.IDLE, G.GetMissionDefaultGroupRank(mi), 1, f1, f2, f3, fi.followerID)
					if g and g[1] then
						local p1, p2, p3 = g[1][5], g[1][6], g[1][7]
						for i=1,mi.numFollowers do
							if p1 ~= f1 and p2 ~= f1 and p3 ~= f1 then
								GarrisonMissionPage_SetFollower(f[i], fi)
								break
							end
							f1, f2 = f2, f3
						end
					end
				end
			elseif fi and fi.status == GARRISON_FOLLOWER_IN_PARTY then
				local f = GarrisonMissionFrame.MissionTab.MissionPage.Followers
				for i=1, #f do
					if f[i].info and f[i].info.followerID == fi.followerID then
						GarrisonMissionPage_ClearFollower(f[i], true)
						break
					end
				end
			end
		end
	end
end
hooksecurefunc("GarrisonFollowerList_Update", function(self)
	local buttons = self.FollowerList.listScroll.buttons
	local mi = GarrisonMissionFrame.MissionTab.MissionPage:IsShown() and GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
	local mlvl = mi and G.GetFMLevel(mi)
	for i=1, #buttons do
		local btn = buttons[i]
		if btn:IsShown() then
			local follower, st = btn.info, btn.XPBar.statusText
			if not st then
				st = btn:CreateFontString(nil, "ARTWORK", "TextStatusBarText")
				st:SetTextColor(0.7, 0.6, 0.85)
				st:SetPoint("TOPRIGHT", -4, -44)
				btn.UpArrow:ClearAllPoints() btn.UpArrow:SetPoint("TOP", 16, -38)
				btn.DownArrow:ClearAllPoints() btn.DownArrow:SetPoint("TOP", 16, -38)
				btn.XPBar.statusText = st
				btn:SetScript("OnDoubleClick", GarrisonFollower_OnDoubleClick)
			end
			if mi then
				local ef = G.GetLevelEfficiency(G.GetFMLevel(follower), mlvl)
				if ef < 0.5 then
					btn.PortraitFrame.Level:SetTextColor(1, 0.1, 0.1)
				elseif ef < 1 then
					btn.PortraitFrame.Level:SetTextColor(1, 0.5, 0.25)
				else
					btn.PortraitFrame.Level:SetTextColor(1, 1, 1)
				end
			else
				btn.PortraitFrame.Level:SetTextColor(1, 1, 1)
			end
			if not follower.isCollected or follower.status == GARRISON_FOLLOWER_INACTIVE or follower.levelXP == 0 then
				st:SetText("")
			else
				st:SetFormattedText(L"%s XP", BreakUpLargeNumbers(follower.levelXP - follower.xp))
			end
		end
	end
end)
do -- Follower counter button tooltips
	local fake, old = {}
	local function OnEnter(self, ...)
		old, fake.info = self, self.info
		return GarrisonMissionMechanicFollowerCounter_OnEnter(self, ...)
	end
	hooksecurefunc("GarrisonFollowerButton_UpdateCounters", function(self)
		if old and (fake.info ~= old.info or not (old:IsShown() and old:IsMouseOver())) then
			GarrisonMissionMechanicFollowerCounter_OnLeave(fake)
			old, fake.info = nil
		end
		for i=1,#self.Counters do
			local self = self.Counters[i]
			self:SetScript("OnEnter", OnEnter)
			if self:IsShown() and self:IsMouseOver() then
				OnEnter(self)
			end
		end
	end)
end

hooksecurefunc("GarrisonFollowerList_Update", function(self)
	local buttons, fl = self.FollowerList.listScroll.buttons, G.GetFollowerInfo()
	local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
	local mid = mi and mi.missionID
	for i=1, #buttons do
		local fi = fl[buttons[i].id]
		if fi then
			local tmid = MasterPlan:GetFollowerTentativeMission(fi.followerID)
			local status = buttons[i].info.status or ""
			if tmid then
				status = tmid == mid and GARRISON_FOLLOWER_IN_PARTY or L"In Tentative Party"
			elseif fi.status == nil and status == GARRISON_FOLLOWER_WORKING and T.config.ignore[fi.followerID] then
				status = L"Ignored"
			end
			if fi.missionTimeLeft then
				buttons[i].Status:SetFormattedText("%s (%s)", status, fi.missionTimeLeft)
			else
				buttons[i].Status:SetText(status)
			end
			if status == "" and fi.level == 100 then
				local _weaponItemID, weaponItemLevel, _armorItemID, armorItemLevel = C_Garrison.GetFollowerItems(fi.followerID)
				if weaponItemLevel ~= armorItemLevel then
					buttons[i].ILevel:SetText(ITEM_LEVEL_ABBR .. " " .. fi.iLevel .. " (" .. weaponItemLevel .. "/" .. armorItemLevel .. ")")
				end
			end
		end
	end
end)
local function Mechanic_OnClick(self)
	if self:IsMouseOver() and self.info and self.info.name then
		GarrisonMissionFrameFollowers.SearchBox:SetText(self.info.name)
		GarrisonMissionFrameFollowers.SearchBox.clearText = self.info.name
	end
end
hooksecurefunc("GarrisonMissionPage_SetEnemies", function(enemies)
	local f = GarrisonMissionFrame.MissionTab.MissionPage
	for i=1, #enemies do
		local m = f.Enemies[i] and f.Enemies[i].Mechanics
		for i=1,m and #m or 0 do
			if not m[i].highlight then
				m[i].highlight = m[i]:CreateTexture(nil, "HIGHLIGHT")
				m[i].highlight:SetAllPoints()
				m[i].highlight:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
				m[i].highlight:SetBlendMode("ADD")
				m[i]:SetScript("OnMouseUp", Mechanic_OnClick)
			end
			m[i].hasCounter = nil
			m[i].Check:Hide()
			m[i].Anim:Stop()
		end
	end
end)

local lfgButton do
	local seen = GarrisonMissionFrame.MissionTab.MissionPage.Stage:CreateFontString(nil, "OVERLAY", "GameFontNormalMed2")
	seen:SetPoint("TOPLEFT", GarrisonMissionFrame.MissionTab.MissionPage.Stage.MissionEnv, "BOTTOMLEFT", 0, -3)
	seen:SetJustifyH("LEFT")
	GarrisonMissionFrame.MissionTab.MissionPage.Stage.MissionSeen = seen
	
	lfgButton = CreateFrame("Button", nil, GarrisonMissionFrame.MissionTab.MissionPage.Stage)
	lfgButton:SetSize(33,33)
	lfgButton:SetHighlightTexture("?") local hi = lfgButton:GetHighlightTexture()
	hi:SetAtlas("groupfinder-eye-highlight", true)
	hi:SetBlendMode("ADD")
	hi:SetAlpha(0.25)
	local border = lfgButton:CreateTexture("OVERLAY")
	border:SetSize(52, 52)
	border:SetPoint("TOPLEFT", 1, -1.5)
	border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
	local ico = lfgButton:CreateTexture(nil, "ARTWORK")
	ico:SetTexture("Interface\\LFGFrame\\BattlenetWorking28")
	ico:SetAllPoints()
	lfgButton:SetPoint("TOPRIGHT", GarrisonMissionFrame.MissionTab.MissionPage.Stage, "TOPRIGHT", -6, -25)
	local curIco, nextSwap, overTime, overTimeState = 28, 0.08, 0
	lfgButton:SetScript("OnUpdate", function(self, elapsed)
		local goal, isOver
		if easyDrop:IsOpen(self) then
			goal, isOver = 17, self:IsMouseOver() or (DropDownList1:IsVisible() and DropDownList1:IsMouseOver(4,-4,-4,4))
			if isOver ~= overTimeState then overTimeState, overTime = isOver, 0 end
			overTime = overTime + elapsed
			if not overTimeState and self.clickOpen == "hover" and overTime > 0.20 then
				CloseDropDownMenus()
				self.clickOpen = false
			end
		else
			goal, isOver = 28, self:IsMouseOver()
			if isOver ~= overTimeState then
				overTimeState, overTime = isOver, 0
				if overTimeState == false and self.clickOpen then
					self.clickOpen = false
				end
			end
			overTime = overTime + elapsed
			if overTimeState and overTime > 0.15 and not easyDrop:IsOpen(self) and not self.clickOpen then
				self:Click()
				self.clickOpen = "hover"
			end
		end
		if curIco ~= goal or (goal ~= 17 and overTimeState) then
			if nextSwap < elapsed then
				curIco, nextSwap = (curIco + 1) % 29, 0.08
				local curIco = curIco > 4 and curIco < 9 and (8-curIco) or (curIco == 16 and 15) or curIco
				ico:SetTexture("Interface\\LFGFrame\\BattlenetWorking" .. curIco)
			else
				nextSwap = nextSwap - elapsed
			end
		end
	end)
	lfgButton:SetScript("OnHide", function(self)
		curIco, nextSwap, self.clickOpen = 28, 0.08
		ico:SetTexture("Interface\\LFGFrame\\BattlenetWorking28")
		if easyDrop:IsOpen(self) then
			CloseDropDownMenus()
		end
	end)

	lfgButton:SetScript("OnClick", function(self)
		if easyDrop:IsOpen(self) and (not overTimeState or overTime > 0.85 or self.clickOpen ~= "hover") then
			self.clickOpen = true
			CloseDropDownMenus()
			return
		end
		self.clickOpen = true

		local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
		local ff = GarrisonMissionFrame.MissionTab.MissionPage.Followers
		local f1, f2, f3 = ff[1].info, ff[2].info, ff[3].info
		f1, f2, f3 = f1 and f1.followerID, mi.numFollowers > 1 and f2 and f2.followerID, mi.numFollowers > 1 and f3 and f3.followerID

		local mm = G.GetSuggestedGroups(mi, false, f1, f2, f3)
		if #mm > 1 then
			easyDrop:Open(self, mm, "TOPRIGHT", self, "TOPLEFT", -2, 12)
		end
	end)
end
hooksecurefunc("GarrisonMissionPage_ShowMission", function()
	local sb = GarrisonMissionFrameFollowers.SearchBox
	if sb:GetText() == sb.clearText then
		sb:SetText("")
	end
	sb.clearText = nil
	local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
	local min, max, exp = G.GetMissionSeen(mi and mi.missionID)
	if exp and exp > 0 then
		local text = math.max(0,exp-floor(max/3600+0.5))
		if min - max >= 3600 and text > 0 then
			text = math.max(0, exp-floor(min/3600+0.5)) .. "-" .. text
		end
		GarrisonMissionFrame.MissionTab.MissionPage.Stage.MissionSeen:SetText(L"Expires in:" .. " " .. HIGHLIGHT_FONT_COLOR_CODE .. LASTONLINE_HOURS:gsub("%%[%d$]*d", "%%s"):format(text))
	else
		GarrisonMissionFrame.MissionTab.MissionPage.Stage.MissionSeen:SetText("")
	end
	lfgButton:Show()
end)

do -- Minimize mission
	local min = CreateFrame("Button", nil, GarrisonMissionFrame.MissionTab.MissionPage, "UIPanelCloseButton")
	GarrisonMissionFrame.MissionTab.MissionPage.MinimizeButton = min
	min:SetNormalTexture("Interface\\Buttons\\UI-Panel-HideButton-Up")
	min:SetPushedTexture("Interface\\Buttons\\UI-Panel-HideButton-Down")
	min:SetPoint("RIGHT", GarrisonMissionFrame.MissionTab.MissionPage.CloseButton, "LEFT", 8, 0)
	min:SetHitRectInsets(0,8,0,0)
	min:SetScript("OnClick", function(self)
		local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
		local f1, f2, f3
		for i=1, mi.numFollowers do
			local fi = GarrisonMissionFrame.MissionTab.MissionPage.Followers[mi.numFollowers+1-i].info
			f1, f2, f3 = fi and fi.followerID, f1, f2
		end
		MasterPlan:SaveMissionParty(mi.missionID, f1, f2, f3)
		roamingParty:DropFollowers(f1, f2, f3)
		GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:Click()
	end)
	min:SetScript("OnHide", function(self)
		if GarrisonMissionFrame.MissionTab.MissionPage.missionInfo then
			if GarrisonMissionFrame.MissionTab.MissionPage:IsShown() and self:IsShown() then
				self:Click()
			end
		end
	end)
	
	hooksecurefunc("GarrisonMissionPage_SetFollower", function(slot, info)
		if info and info.followerID then
			MasterPlan:DissolveMissionByFollower(info.followerID)
		end
		G.PushFollowerPartyStatus(info.followerID)
	end)
	EV.RegisterEvent("GARRISON_MISSION_NPC_CLOSED", function()
		MasterPlan:DissolveAllMissions()
	end)
end

do -- GarrisonFollowerTooltip xp textures
	GarrisonFollowerTooltip.XPGained = GarrisonFollowerTooltip:CreateTexture(nil, "ARTWORK", nil, 2)
	GarrisonFollowerTooltip.XPGained:SetTexture(1, 0.8, 0.2)
	GarrisonFollowerTooltip.XPRewardBase = GarrisonFollowerTooltip:CreateTexture(nil, "ARTWORK", nil, 2)
	GarrisonFollowerTooltip.XPRewardBase:SetTexture(0.6, 1, 0)
	GarrisonFollowerTooltip.XPRewardBase:SetPoint("TOPLEFT", GarrisonFollowerTooltip.XPBar, "TOPRIGHT")
	GarrisonFollowerTooltip.XPRewardBase:SetPoint("BOTTOMLEFT", GarrisonFollowerTooltip.XPBar, "BOTTOMRIGHT")
	GarrisonFollowerTooltip.XPRewardBonus = GarrisonFollowerTooltip:CreateTexture(nil, "ARTWORK", nil, 2)
	GarrisonFollowerTooltip.XPRewardBonus:SetTexture(0, 0.75, 1)
	GarrisonFollowerTooltip.XPRewardBonus:SetPoint("TOPLEFT", GarrisonFollowerTooltip.XPRewardBase, "TOPRIGHT")
	GarrisonFollowerTooltip.XPRewardBonus:SetPoint("BOTTOMLEFT", GarrisonFollowerTooltip.XPRewardBase, "BOTTOMRIGHT")
	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetGarrisonFollower", function(self, data)
		self.lastShownData = data
		if self.XPGained then
			self.XPGained:Hide()
			self.XPRewardBase:Hide()
			self.XPRewardBonus:Hide()
		end
	end)
end
do -- Projected XP rewards
	local function MissionFollower_OnEnter(self)
		G.ExtendFollowerTooltipMissionRewardXP(MISSION_PAGE_FRAME.missionInfo, self.info)
	end
	for i=1,3 do
		GarrisonMissionFrame.MissionTab.MissionPage.Followers[i]:HookScript("OnEnter", MissionFollower_OnEnter)
	end
end
do -- Counter-follower lists
	local function GetCounterListText(mech, mlvl)
		local finfo, cinfo = G.GetFollowerInfo(), G.GetCounterInfo()
		local c, t = cinfo[mech], ""
		if c then
			local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
			t, mlvl = {}, mlvl or (mi and G.GetFMLevel(mi))
			T.Garrison.sortByFollowerLevels(c, finfo)
			for i=1,#c do
				t[#t+1] = T.Garrison.GetFollowerLevelDescription(c[i], mlvl, finfo[c[i]])
			end
			t = #t > 0 and NORMAL_FONT_COLOR_CODE .. L"Can be countered by:" .. "|r\n" .. table.concat(t, "\n") or ""
		end
		return t
	end
	local function GetTraitListText(trait, mlvl)
		local finfo, c, c2, cn = G.GetFollowerInfo(), {}, {}, 1
		for k,v in pairs(finfo) do
			if v.isCollected and v.traits and v.traits[trait] then
				c[cn], cn = k, cn + 1
			end
			if v.isCollected and v.affinity == trait then
				c2[#c2 + 1] = k
			end
		end
		local mi = GarrisonMissionFrame.MissionTab.MissionPage.missionInfo
		local mlvl = mlvl or mi and G.GetFMLevel(mi) or 0
		T.Garrison.sortByFollowerLevels(c, finfo)
		T.Garrison.sortByFollowerLevels(c2, finfo)
		for i=1,#c do
			c[i] = T.Garrison.GetFollowerLevelDescription(c[i], mlvl, finfo[c[i]])
		end
		local base = cn > 1 and (NORMAL_FONT_COLOR_CODE .. L"Followers with this trait:" .. "|r\n" .. table.concat(c, "\n")) or ""
		if #c2 > 0 then
			for i=1,#c2 do
				c2[i] = T.Garrison.GetFollowerLevelDescription(c2[i], mlvl, finfo[c[i]])
			end
			base = (cn > 1 and (base .. "\n\n") or "") .. NORMAL_FONT_COLOR_CODE .. L"Followers activating this trait:" .. "|r\n" .. table.concat(c2, "\n")
		end
		return base
	end
	
	local atip = GarrisonFollowerAbilityTooltip
	atip.CounterOthers = atip:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	atip.CounterOthers:SetJustifyH("LEFT")
	local function atip_Resize()
		atip:SetWidth(math.max(245, 46 + atip.CounterOthers:GetStringWidth()))
		atip.Description:SetWidth(atip:GetWidth()-245+190)
		if atip.Details:IsShown() then
			atip.CounterOthers:SetPoint("TOPLEFT", atip.Details, "BOTTOMLEFT", -26, -16)
		else
			atip.CounterOthers:SetPoint("TOPLEFT", atip.Description, "BOTTOMLEFT", 0, -8)
		end
		if not atip:GetTop() then
		elseif atip.CounterOthers:GetText() ~= "" then
			atip:SetHeight(atip:GetTop()-atip.CounterOthers:GetBottom() + 12)
		else
			atip:SetHeight(atip:GetTop()-atip.Details:GetBottom() + 18)
		end
	end
	hooksecurefunc("GarrisonFollowerAbilityTooltipTemplate_SetAbility", function(self, aid)
		if self.CounterOthers then
			local text
			if self.Details:IsShown() then
				text = GetCounterListText((C_Garrison.GetFollowerAbilityCounterMechanicInfo(aid))) or ""
				self.CounterIcon:SetMask("")
				self.CounterIcon:SetTexCoord(4/64,60/64,4/64,60/64)
			else
				text = GetTraitListText(aid) or ""
			end
			self.CounterOthers:SetText(text)
			if text ~= "" then
				atip_Resize() C_Timer.After(0.03, atip_Resize)
			end
		end
	end)
	hooksecurefunc("GarrisonFollowerTooltipTemplate_SetGarrisonFollower", function(self, data)
		for i=1,#self.Abilities do
			local ci = self.Abilities[i].CounterIcon
			if ci:IsShown() then
				ci:SetMask("")
				ci:SetTexCoord(4/64,60/64,4/64,60/64)
			end
		end
	end)
	
	local ctip = GarrisonMissionMechanicFollowerCounterTooltip
	ctip.CounterOthers = ctip:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	ctip.CounterOthers:SetJustifyH("LEFT")
	local function ctip_Resize()
		ctip:SetWidth(math.max(280, 20 + ctip.CounterOthers:GetStringWidth()))
		if ctip:GetTop() and ctip.CounterOthers:GetBottom() then
			ctip:SetHeight(ctip:GetTop() - ctip.CounterOthers:GetBottom() + 12)
		end
	end
	ctip:HookScript("OnShow", function(self)
		local mech = G.GetMechanicInfo((self.Icon:GetTexture() or ""):lower())
		local text = GetCounterListText(mech)
		self.CounterOthers:SetText(text)
		if self.CounterName:IsShown() then
			self.CounterOthers:SetPoint("TOPLEFT", ctip.CounterName, "BOTTOMLEFT", -24, -16)
		else
			self.CounterOthers:SetPoint("TOPLEFT", ctip.Name, "BOTTOMLEFT", -24, -12)
		end
		ctip_Resize() C_Timer.After(0.03, ctip_Resize)
	end)
	
	GarrisonMissionMechanicTooltip:HookScript("OnShow", function(self)
		local mech = T.Garrison.GetMechanicInfo((self.Icon:GetTexture() or ""):lower())
		local text = GetCounterListText(mech, self.missionLevel)
		if text ~= "" then
			local height, dt = self:GetHeight()-self.Description:GetHeight(), self.Description:GetText()
			self.Description:SetText((dt and dt .. "\n\n" .. text or text))
			self:SetHeight(height + self.Description:GetHeight() + 4)
		end
	end)
end
do -- suppress completion toast while missions UI is visible
	local registered = false
	GarrisonMissionFrame:HookScript("OnShow", function(self)
		if AlertFrame:IsEventRegistered("GARRISON_MISSION_FINISHED") then
			registered = true
			AlertFrame:UnregisterEvent("GARRISON_MISSION_FINISHED")
		end
	end)
	GarrisonMissionFrame:HookScript("OnHide", function(self)
		if registered then
			AlertFrame:RegisterEvent("GARRISON_MISSION_FINISHED")
			registered = false
		end
	end)
end
do -- Rewards
	local function Reward_OnClick(self)
		if IsModifiedClick("CHATLINK") then
			local q, text = self.quantity and self.quantity > 1 and self.quantity .. " " or ""
			if self.itemID then
				text = select(2, GetItemInfo(self.itemID))
				if text then
					text = q .. text
				end
			elseif self.currencyID and self.currencyID > 0 and self.currencyQuantity then
				text = self.currencyQuantity .. " " .. GetCurrencyLink(self.currencyID)
			elseif self.title then
				text = q .. self.title
			end
			if text then
				ChatEdit_InsertLink(text)
			end
		end
	end
	hooksecurefunc("GarrisonMissionPage_SetReward", function(self, reward)
		self.quantity = reward.quantity or reward.followerXP
		self:SetScript("OnMouseUp", Reward_OnClick)
	end)
end

local function SetFollowerIgnore(_, fid, val)
	MasterPlan:SetFollowerIgnored(fid, val)
	GarrisonMissionFrame.FollowerList.dirtyList = true
	GarrisonFollowerList_UpdateFollowers(GarrisonMissionFrame.FollowerList)
end
hooksecurefunc(GarrisonFollowerOptionDropDown, "initialize", function(self)
	local fi = self.followerID and C_Garrison.GetFollowerInfo(self.followerID)
	if fi and fi.isCollected and fi.status ~= GARRISON_FOLLOWER_INACTIVE then
		DropDownList1.numButtons = DropDownList1.numButtons - 1
		
		local info, ignored = UIDropDownMenu_CreateInfo(), T.config.ignore[fi.followerID]
		info.text, info.notCheckable = ignored and L"Unignore" or L"Ignore", true
		info.func, info.arg1, info.arg2 = SetFollowerIgnore, fi.followerID, not ignored
		UIDropDownMenu_AddButton(info)
		
		info.text, info.func = CANCEL
		UIDropDownMenu_AddButton(info)
	end
end)

do -- Follower headcounts
	local mf = GarrisonMissionFrame.MissionTab.MissionList.MaterialFrame
	local ff, fs = CreateFrame("Frame", nil, mf), mf:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	local ni, nw, nx, nm = 0, 0, 0, 0
	ff:SetWidth(190) ff:SetPoint("TOPLEFT") ff:SetPoint("BOTTOMLEFT")
	fs:SetPoint("LEFT", 16, 0)
	ff:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
		GameTooltip:AddLine(GARRISON_FOLLOWERS_TITLE, 1,1,1)
		if ni > 0 then
			GameTooltip:AddLine("|cff40ff40" .. ni .. " " .. L"Idle")
		end
		if nx > 0 then
			GameTooltip:AddLine("|cffc864ff" .. nx .. " " .. L"Idle (max-level)")
		end
		if nw > 0 then
			GameTooltip:AddLine(nw .. " " .. GARRISON_FOLLOWER_WORKING)
		end
		if nm > 0 then
			GameTooltip:AddLine("|cff80dfff" .. nm .. " " .. GARRISON_FOLLOWER_ON_MISSION)
		end
		GameTooltip:Show()
	end)
	ff:SetScript("OnLeave", function(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
	end)
	for _, s in pairs({mf:GetRegions()}) do
		if s:IsObjectType("FontString") and s:GetText() == GARRISON_YOUR_MATERIAL then
			s:Hide()
		end
	end
	local function sync()
		ni, nw, nx, nm = 0, 0, 0, 0
		for k, v in pairs(G.GetFollowerInfo()) do
			if not v.isCollected or T.config.ignore[k] then
			elseif v.status == GARRISON_FOLLOWER_WORKING then
				nw = nw + 1
			elseif v.status == GARRISON_FOLLOWER_ON_MISSION then
				nm = nm + 1
			elseif (v.status or "") ~= "" and v.status ~= GARRISON_FOLLOWER_IN_PARTY then
			elseif v.level == 100 and v.quality == 4 then
				nx = nx + 1
			else
				ni = ni + 1
			end
		end
		local ico, spacer, t = "|TInterface\\FriendsFrame\\UI-Toast-FriendOnlineIcon:11:11:3:0:32:32:8:24:8:24:", "|TInterface\\Buttons\\UI-Quickslot2:9:9:0:0:64:64:31:32:31:32|t"
		if ni > 0 then t = ni .. ico .. "50:255:50|t" end
		if nx > 0 then t = (t and t .. spacer or "") .. nx .. ico .. "200:100:255|t" end
		if nw > 0 then t = (t and t .. spacer or "") .. nw .. ico .. "255:208:0|t" end
		if nm > 0 then t = (t and t .. spacer or "") .. nm .. ico .. "125:230:255|t" end
		fs:SetText(t or "")
	end
	
	hooksecurefunc("GarrisonMissionFrame_UpdateCurrency", sync)
	EV.RegisterEvent("GARRISON_MISSION_NPC_OPENED", sync)
	mf:HookScript("OnShow", sync)
end