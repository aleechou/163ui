local _, T = ...
if T.Mark ~= 23 then return end
local L, EV, G, api = T.L, T.Evie, T.Garrison, {}

local MISSION_PAGE_FRAME = GarrisonMissionFrame.MissionTab.MissionPage
local RefreshActiveMissionsView, activeMissionsHandle
local RefreshAvailMissionsView, availMissionsHandle
local interestMissionsHandle

local function abridge(n)
	return (n >= 1000 and L"%.2gk" or "%d"):format(n >= 1000 and n/1000 or n)
end
local function oncePerFrame(f)
	local ff
	local function cf()
		ff = nil
		f()
	end
	return function()
		if not ff then
			ff = true
			C_Timer.After(0, cf)
		end
	end
end
local function OpenToMission(mi, f1, f2, f3, isResume)
	if not mi then
		return
	end
	
	local mp, _, s1, s2, s3, s4, s5, s6 = GarrisonMissionFrame.MissionTab.MissionPage
	if not (f1 or f2 or f3) then
		f1, f2, f3 = MasterPlan:GetMissionParty(mi.missionID)
		if not (f1 or f2 or f3) then
			f1, f2, f3 = api.roamingParty:GetFollowers()
		else
			isResume = true
		end
	end
	if (f1 or f2 or f3) then
		if not f2 then
			f2, f3 = f3
		end
		if not f1 then
			f1, f2, f3 = f2, f3
		end
	else
		isResume = true
	end
	if isResume then
		_, s1 = PlaySound("UI_Garrison_CommandTable_IncreaseSuccess")
		_, s2 = PlaySound("UI_Garrison_CommandTable_100Success")
		_, s3 = PlaySound("UI_Garrison_Mission_Threat_Countered")
		_, s4 = PlaySound("UI_Garrison_CommandTable_AssignFollower")
		_, s5 = PlaySound("UI_Garrison_CommandTable_UnassignFollower")
		_, s6 = PlaySound("UI_Garrison_CommandTable_ReducedSuccessChance")
	end
	
	PlaySound("UI_Garrison_CommandTable_SelectMission")
	GarrisonMissionFrame.MissionTab.MissionList:Hide()
	GarrisonMissionFrame.MissionTab.MissionPage:Show()
	GarrisonMissionPage_ShowMission(mi)
	GarrisonMissionFrame.followerCounters = C_Garrison.GetBuffedFollowersForMission(mi.missionID)
	GarrisonMissionFrame.followerTraits = C_Garrison.GetFollowersTraitsForMission(mi.missionID)
	
	GarrisonMissionPage_ClearParty()
	for i=1, mi.numFollowers do
		if f1 then
			GarrisonMissionPage_SetFollower(mp.Followers[i], C_Garrison.GetFollowerInfo(f1))
		end
		f1, f2, f3 = f2, f3, f1
	end
	if isResume then
		for i = 1, #mp.Enemies do
			local enemyFrame = mp.Enemies[i]
			for mechanicIndex = 1, #enemyFrame.Mechanics do
				local mech = enemyFrame.Mechanics[mechanicIndex]
				mech.Check:SetAlpha(mech.hasCounter and 1 or 0)
				mech.Check:SetShown(mech.hasCounter)
				mech.Anim:Stop()
			end
		end
		GarrisonMissionFrame.MissionTab.MissionPage.RewardsFrame.ChanceGlowAnim:Stop()
		MISSION_PAGE_FRAME.Stage.MissionEnvIcon.Anim:Stop()
	end
	GarrisonMissionPage_UpdateMissionForParty()
	GarrisonFollowerList_UpdateFollowers(GarrisonMissionFrame.FollowerList)
	for i=1,6 do
		s1, s2, s3, s4, s5, s6 = s2, s3, s4, s5, s6, s1 and StopSound(s1)
	end
end
GarrisonMissionFrame.MissionTab.MissionPage.StartMissionButton:SetScript("OnClick", function(self)
	if (not MISSION_PAGE_FRAME.missionInfo.missionID) then
		return
	end
	local f1, f2, f3 = G.StartMission(MISSION_PAGE_FRAME.missionInfo.missionID)
	api.roamingParty:DropFollowers(f1, f2, f3)
	PlaySound("UI_Garrison_CommandTable_MissionStart")
	GarrisonMissionPage_Close()
	RefreshAvailMissionsView(true)
	if (not GetCVarBitfield("closedInfoFrames", LE_FRAME_TUTORIAL_GARRISON_LANDING)) then
		GarrisonLandingPageTutorialBox:Show()
	end
end)

local missionList = CreateFrame("Frame", "MasterPlanMissionList", GarrisonMissionFrameMissions) do
	missionList:SetAllPoints()
	do
		local hidden = CreateFrame("Frame", nil, missionList)
		hidden:Hide()
		missionList:SetScript("OnShow", function(self)
			GarrisonMissionFrameMissionsTab1:SetParent(hidden)
			GarrisonMissionFrameMissionsTab2:SetParent(hidden)
			GarrisonMissionFrameMissionsListScrollFrame:SetParent(hidden)
		end)
		missionList:SetScript("OnHide", function(self)
			GarrisonMissionFrameMissionsTab1:SetParent(self:GetParent())
			GarrisonMissionFrameMissionsTab2:SetParent(self:GetParent())
			GarrisonMissionFrameMissionsListScrollFrame:SetParent(self:GetParent())
		end)
	end
end
local easyDrop = CreateFrame("Frame", "MasterPlanDropDown", nil, "UIDropDownMenuTemplate") do
	api.easyDrop = easyDrop
	function easyDrop:IsOpen(owner)
		return self.owner == owner and UIDROPDOWNMENU_OPEN_MENU == self and DropDownList1:IsShown()
	end
	local function CheckOwner(self)
		if self.owner and UIDROPDOWNMENU_OPEN_MENU == self and DropDownList1:IsShown() then
			if self.owner:IsVisible() then
				return
			end
			CloseDropDownMenus()
		end
		self:SetScript("OnUpdate", nil)
	end
	function easyDrop:Open(owner, menu, ...)
		self.owner = owner
		self:SetScript("OnUpdate", CheckOwner)
		EasyMenu(menu, self, "cursor", 9000, 9000, "MENU", 4)
		DropDownList1:ClearAllPoints()
		DropDownList1:SetPoint(...)
	end
end
local activeUI = CreateFrame("Frame", nil, missionList) do
	activeUI:SetSize(880, 22)
	activeUI:SetPoint("BOTTOMLEFT", GarrisonMissionFrameMissions, "TOPLEFT", 0, 4)
	activeUI:Hide()
	activeUI.CompleteAll = CreateFrame("Button", nil, activeUI, "UIPanelButtonTemplate") do
		local b = activeUI.CompleteAll
		b:SetSize(200, 26)
		b:SetPoint("BOTTOM", 0, 5)
		b:SetText(L"Complete All")
	end
	activeUI.batch = CreateFrame("CheckButton", nil, activeUI.CompleteAll, "InterfaceOptionsCheckButtonTemplate") do
		local b = activeUI.batch
		b:SetSize(22, 22)
		b:SetPoint("LEFT", activeUI, "LEFT", 12, 2)
		b.Text:SetText(L"Expedited mission completion")
		b.Text:SetFontObject(GameFontHighlightSmall)
		b:SetScript("OnClick", function(self)
			MasterPlan:SetBatchMissionCompletion(self:GetChecked())
		end)
		b:SetHitRectInsets(0, -b.Text:GetStringWidth()-6, 0,0)
		EV.RegisterEvent("MP_SETTINGS_CHANGED", function(ev, set)
			if set == "batchMissions" or set == nil then
				b:SetChecked(MasterPlan:GetBatchMissionCompletion())
			end
		end)
	end
	local lootFrame = CreateFrame("Frame", nil, activeUI) do
		local lf = lootFrame
		activeUI.lootFrame = lf
		lf:SetSize(560, 380)
		lf:SetPoint("CENTER", GarrisonMissionFrameMissions, "CENTER")
		local t = lf:CreateTexture(nil, "BACKGROUND", nil, -1)
		t:SetAllPoints(GarrisonMissionFrameMissions)
		t:SetTexture(0,0,0)
		t:SetAlpha(0.35)
		local w1, h1 = lf:GetSize()
		local w2, h2 = GarrisonMissionFrameMissions:GetSize()
		lf:SetHitRectInsets((w1-w2)/2, (w1-w2)/2, (h1-h2)/2, (h1-h2)/2)
		lf:EnableMouse(true) lf:EnableMouseWheel(true)
		lf:SetFrameStrata("DIALOG")
		t = lf:CreateTexture(nil, "BACKGROUND")
		t:SetAtlas("Garr_InfoBox-BackgroundTile", true)
		t:SetHorizTile(true) t:SetVertTile(true)
		t:SetAllPoints()
		t = lf:CreateTexture(nil, "BORDER")
		t:SetAtlas("_Garr_InfoBoxBorder-Top", true)
		t:SetHorizTile(true) t:SetPoint("TOPLEFT") t:SetPoint("TOPRIGHT")
		t = lf:CreateTexture(nil, "BORDER")
		t:SetAtlas("_Garr_InfoBoxBorder-Top", true)
		t:SetHorizTile(true) t:SetPoint("BOTTOMLEFT") t:SetPoint("BOTTOMRIGHT")
		t:SetTexCoord(0, 1, 1, 0)
		t = lf:CreateTexture(nil, "BORDER")
		t:SetAtlas("!Garr_InfoBoxBorder-Left", true)
		t:SetVertTile(true) t:SetPoint("TOPLEFT") t:SetPoint("BOTTOMLEFT")
		t = lf:CreateTexture(nil, "BORDER")
		t:SetAtlas("!Garr_InfoBoxBorder-Left", true)
		t:SetVertTile(true) t:SetPoint("TOPRIGHT") t:SetPoint("BOTTOMRIGHT")
		t:SetTexCoord(1,0, 0,1)
		t = lf:CreateTexture(nil, "BORDER", nil, -1)
		t:SetAtlas("!Garr_InfoBox-Left", true)
		t:SetPoint("TOPLEFT", -7, 0)
		t:SetPoint("BOTTOMLEFT", -7, 0)
		t:SetVertTile(true)
		t = lf:CreateTexture(nil, "BORDER", nil, -1)
		t:SetAtlas("!Garr_InfoBox-Left", true)
		t:SetPoint("TOPRIGHT", 7, 0)
		t:SetPoint("BOTTOMRIGHT", 7, 0)
		t:SetVertTile(true)
		t:SetTexCoord(1,0, 0,1)
		t = lf:CreateTexture(nil, "BORDER", nil, -1)
		t:SetAtlas("_Garr_InfoBox-Top", true)
		t:SetPoint("TOPLEFT", 0, 7)
		t:SetPoint("TOPRIGHT", 0, 7)
		t:SetHorizTile(true)
		t = lf:CreateTexture(nil, "BORDER", nil, -1)
		t:SetAtlas("_Garr_InfoBox-Top", true)
		t:SetPoint("BOTTOMLEFT", 0, -7)
		t:SetPoint("BOTTOMRIGHT", 0, -7)
		t:SetHorizTile(true)
		t:SetTexCoord(0,1, 1,0)
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBoxBorder-Corner", true)
		t:SetPoint("TOPLEFT")
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBoxBorder-Corner", true)
		t:SetPoint("TOPRIGHT") t:SetTexCoord(1,0, 0,1)
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBoxBorder-Corner", true)
		t:SetPoint("BOTTOMLEFT") t:SetTexCoord(0,1, 1,0)
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBoxBorder-Corner", true)
		t:SetPoint("BOTTOMRIGHT") t:SetTexCoord(1,0, 1,0)
		t = lf:CreateFontString(nil, "ARTWORK", "QuestFont_Super_Huge")
		t:SetPoint("TOP", 0, -12)
		t:SetText((GARRISON_MISSION_REPORT:gsub("\n", " ")))
		t = lf:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
		t:SetPoint("TOP", 0, -40)
		lf.numMissions = t
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBox-CornerShadow", true)
		t:SetPoint("BOTTOMRIGHT", lf, "TOPLEFT")
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBox-CornerShadow", true)
		t:SetPoint("BOTTOMLEFT", lf, "TOPRIGHT")
		t:SetTexCoord(1,0, 0,1)
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBox-CornerShadow", true)
		t:SetPoint("TOPRIGHT", lf, "BOTTOMLEFT")
		t:SetTexCoord(0,1, 1,0)
		t = lf:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("Garr_InfoBox-CornerShadow", true)
		t:SetPoint("TOPLEFT", lf, "BOTTOMRIGHT")
		t:SetTexCoord(1,0, 1,0)
		t = CreateFrame("Button", nil, lootFrame, "UIPanelButtonTemplate")
		t:SetSize(200, 24) t:SetText(L"Done") t:SetPoint("BOTTOM", 0, 18)
		t:SetScript("OnClick", function()
			lootFrame:Hide()
			GarrisonMissionFrame.MissionComplete.completeMissions = C_Garrison.GetCompleteMissions()
			GarrisonMissionList_UpdateMissions() -- TODO
			RefreshActiveMissionsView(not IsAltKeyDown())
		end)
		lf.Dismiss = t
		t = lf:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
		t:SetPoint("BOTTOM", lf.Dismiss, "TOP", 0, 6)
		t:SetText(("|cffff2020%s|r|n%s"):format(L"You have no free bag slots.", L"Additional mission loot may be delivered via mail."))
		lf.noBagSlots = t
		lf:Hide()
		lf:SetScript("OnShow", function(self)
			self.noBagSlots:Show()
			for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
				local freeSlots, bagFamily = GetContainerNumFreeSlots(i)
				if bagFamily == 0 and freeSlots > 0 then
					self.noBagSlots:Hide()
					break
				end
			end
			if self.onShowSound then
				PlaySound(self.onShowSound)
				self.onShowSound = nil
			end
		end)
	end
	local lootContainer, SetFollower = CreateFrame("Frame", nil, lootFrame) do
		lootContainer:SetSize(490, 280)
		lootContainer:SetPoint("TOP", 0, -65)
		lootContainer:RegisterEvent("GET_ITEM_INFO_RECEIVED")
		lootContainer:SetScript("OnEvent", function(self)
			for i=1,#self.items do
				local ii = self.items[i]
				if ii.itemID and ii:IsShown() then
					ii:SetIcon(select(10, GetItemInfo(ii.itemID)) or GetItemIcon(ii.itemID) or "Interface\\Icons\\Temp")
				end
			end
		end)
		do
			local function AnimateXP(self, elapsed)
				if self.levelUp:IsShown() then return end
				local elapsed = self.xpGainElapsed + elapsed
				local prog = elapsed > 0.75 and 1 or (elapsed/0.75)
				self.xpProgressTex2:SetWidth(math.max(0.01, sin(90*prog) * self.xpGainWidth))
				if prog == 1 then
					self.xpGainWidth, self.xpGainElapsed = nil
					self:SetScript("OnUpdate", nil)
				else
					self.xpGainElapsed = elapsed
				end
			end
			function SetFollower(btn, info, award, oldQuality)
				GarrisonMissionFrame_SetFollowerPortrait(btn, info, false)
				if info.levelXP > info.xp and award > 0 then
					local baseXP = info.xp - math.min(info.xp, award)
					btn.xpProgressTex:SetWidth(math.max(0.01,46*baseXP/info.levelXP))
					btn.xpProgressTex2:SetWidth(0.01)
					btn.xpGainWidth, btn.xpGainElapsed = 46*math.min(info.xp - baseXP, award)/info.levelXP, 0
					btn.xpProgressTex2:Show()
					btn:SetScript("OnUpdate", AnimateXP)
					btn.xpProgressTex:SetShown(baseXP > 0)
					btn.xpProgressTex2:Show()
				else
					btn:SetScript("OnUpdate", nil)
					btn.xpProgressTex:Hide()
					btn.xpProgressTex2:Hide()
				end
				btn.info, btn.awardXP = info, award or 0
				if award and award > (info.xp or 0) or (oldQuality and oldQuality ~= info.quality) then
					lootFrame.onShowSound = "UI_Garrison_CommandTable_Follower_LevelUp"
					btn.levelUp:Show()
					btn.levelUp:SetAlpha(1)
					btn.levelUp.Anim:Play()
					btn.Level:SetFontObject(GameFontNormalSmall)
					btn.LevelUpAnim:Play()
				else
					btn.levelUp:SetAlpha(0)
					btn.levelUp:Hide()
					btn.LevelUpAnim:Stop()
					btn.Level:SetFontObject(GameFontHighlightSmall)
				end
				btn:Show()
			end
		end
		lootContainer.followers = {} do
			local function FollowerButton_OnEnter(self)
				local tip = GarrisonFollowerTooltip
				GarrisonMissionPageFollowerFrame_OnEnter(self)
				local data = tip.lastShownData
				if tip.XP:IsShown() and self.awardXP and self.awardXP > 0 then
					tip.XP:SetText(tip.XP:GetText() .. "|n|cff10ff10" .. (L"%s XP gained"):format(BreakUpLargeNumbers(self.awardXP)))
					if tip.XPGained and data then
						tip.XPGained:ClearAllPoints()
						tip.XPGained:SetPoint("TOPRIGHT", tip.XPBar)
						tip.XPGained:SetPoint("BOTTOMRIGHT", tip.XPBar)
						tip.XPGained:SetWidth(math.max(0.01, math.min(data.xp, self.awardXP)*tip.XPBarBackground:GetWidth()/data.levelxp))
						tip.XPGained:Show()
					end
				end
			end
			local function LevelPulse_OnStop(self)
				self:GetParent().pulse:SetAlpha(0)
			end
			local function CreateFollower()
				local b = CreateFrame("Button", nil, lootContainer, "GarrisonFollowerPortraitTemplate")
				b.levelUp = CreateFrame("Frame", nil, b, "GarrisonFollowerLevelUpTemplate")
				b.levelUp:SetScale(0.5)
				b.levelUp:SetPoint("BOTTOM", 0, -47)
				b.xpProgressTex = b:CreateTexture(nil, "ARTWORK", nil, 2)
				b.xpProgressTex:SetPoint("TOPLEFT", b.LevelBorder, "TOPLEFT", 6, -6)
				b.xpProgressTex:SetTexture("Interface\\Buttons\\GradBlue")
				b.xpProgressTex:SetAlpha(0.4)
				b.xpProgressTex:SetSize(30, 12)
				b.xpProgressTex2 = b:CreateTexture(nil, "ARTWORK", nil, 2)
				b.xpProgressTex2:SetTexture("Interface\\Buttons\\GradBlue")
				b.xpProgressTex2:SetAlpha(0.6)
				b.xpProgressTex2:SetSize(30, 12)
				b.xpProgressTex2:SetPoint("LEFT", b.xpProgressTex, "RIGHT")
				b.pulse = b:CreateTexture(nil, "BORDER", nil, 0)
				b.pulse:SetAtlas("GarrMission_CurrentEncounter-Glow", true)
				b.pulse:SetPoint("CENTER", b.Portrait)
				b.pulse:SetAlpha(0)
				b.LevelUpAnim = b:CreateAnimationGroup()
				b.LevelUpAnim:SetLooping("REPEAT")
				b.LevelUpAnim:SetScript("OnStop", LevelPulse_OnStop)
				b.LevelUpAnim:SetIgnoreFramerateThrottle(true)
				local t = b.LevelUpAnim:CreateAnimation("Alpha")
				t:SetEndDelay(1.25)
				t:SetDuration(1.5) t:SetFromAlpha(0) t:SetToAlpha(1)
				t:SetChildKey("pulse")
				local t = b.LevelUpAnim:CreateAnimation("Alpha")
				t:SetStartDelay(1.5) t:SetEndDelay(0.25)
				t:SetDuration(1) t:SetFromAlpha(1) t:SetToAlpha(0)
				t:SetChildKey("pulse")
				
				b:SetScript("OnEnter", FollowerButton_OnEnter)
				b:SetScript("OnLeave", GarrisonMissionPageFollowerFrame_OnLeave)
				b:Hide()
				return b
			end
			setmetatable(lootContainer.followers, {__index=function(self, k)
				local b = CreateFollower()
				self[k] = b
				return b
			end})
		end
		lootContainer.items = {} do
			local function OnEnter(self)
				GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
				if self.itemID then
					GameTooltip:SetItemByID(self.itemID)
				elseif self.tooltipHeader and self.tooltipText then
					GameTooltip:AddLine(self.tooltipHeader)
					GameTooltip:AddLine(self.tooltipText, 1,1,1)
				elseif self.currencyID then
					GameTooltip:SetCurrencyByID(self.currencyID)
				else
					GameTooltip:Hide()
					return
				end
				if self.tooltipExtra then
					GameTooltip:AddLine(self.tooltipExtra, 1,1,1)
				end
				GameTooltip:Show()
			end
			local function OnLeave(self)
				if GameTooltip:IsOwned(self) then
					GameTooltip:Hide()
				end
			end
			local function SetIcon(self, texture)
				self.Icon:SetTexture(texture)
				self.Icon:SetTexCoord(4/64, 60/64, 4/64, 60/64)
			end
			setmetatable(lootContainer.items, {__index=function(self, k)
				local i = CreateFrame("Button", nil, lootContainer)
				i:SetSize(46, 46)
				i.Icon = i:CreateTexture(nil, "ARTWORK")
				i.Icon:SetPoint("TOPLEFT", 3*46/64, -3*46/64)
				i.Icon:SetPoint("BOTTOMRIGHT", -3*46/64, 3*46/64)
				i.Border = i:CreateTexture(nil, "ARTWORK", 2)
				i.Border:SetAllPoints()
				i.Border:SetTexture("Interface\\Buttons\\UI-Quickslot2")
				i.Border:SetTexCoord(12/64,52/64,12/64,52/64)
				i.Quantity = i:CreateFontString(nil, "OVERLAY", "GameFontHighlightOutline")
				i.Quantity:SetPoint("BOTTOMRIGHT", -3, 4)
				i:SetScript("OnEnter", OnEnter)
				i:SetScript("OnLeave", OnLeave)
				self[k], i.SetIcon = i, SetIcon
				return i
			end})
		end
	end
	function activeUI:SetCompletionRewards(rewards, followers, numMissions)
		lootFrame.numMissions:SetFormattedText(GARRISON_NUM_COMPLETED_MISSIONS, numMissions or 1)
		lootFrame.onShowSound = rewards and next(rewards) and "UI_Garrison_CommandTable_ChestUnlock_Gold_Success" or "UI_Garrison_CommandTable_ChestUnlock"
		
		local fi, fn = G.GetFollowerInfo(), 1
		for k,v in pairs(followers) do
			SetFollower(lootContainer.followers[fn], fi[k], v.xpAward, v.oqual)
			fn = fn + 1
		end
		for i=fn, #lootContainer.followers do
			lootContainer.followers[i]:Hide()
		end

		local ni = 1
		for k,v in pairs(rewards) do
			local quantity, icon, tooltipHeader, tooltipText, _, tooltipExtra = v.quantity
			if v.itemID then
				icon, tooltipExtra = select(10, GetItemInfo(v.itemID)) or GetItemIcon(v.itemID) or "Interface\\Icons\\Temp", v.itemID == 120205 and rewards.xp and rewards.xp.playerXP and XP_GAIN:format(BreakUpLargeNumbers(rewards.xp.playerXP)) or nil
			elseif v.currencyID == 0 then
				icon, tooltipHeader, tooltipText = "Interface\\Icons\\INV_Misc_Coin_02", GARRISON_REWARD_MONEY, GetMoneyString(v.quantity)
				quantity = floor(quantity/10000)
			elseif v.currencyID then
				_, _, icon = GetCurrencyInfo(v.currencyID)
			end
			if icon then
				local ib = lootContainer.items[ni]
				ib:SetPoint("CENTER", lootContainer.followers[fn], "CENTER", 0, 4)
				ib:SetIcon(icon)
				ib.Quantity:SetText(quantity > 1 and quantity)
				ib.itemID, ib.currencyID, ib.tooltipHeader, ib.tooltipText, ib.tooltipExtra = v.itemID, v.currencyID, tooltipHeader, tooltipText, tooltipExtra
				ib:Show()
				ni, fn = ni + 1, fn + 1
			end
		end
		for i=ni,#lootContainer.items do
			lootContainer.items[i]:Hide()
		end
		
		local numTotal = fn - 1 do
			local perRow, baseY = 9, 0, 0
			if numTotal <= 9 then
				perRow, baseY = numTotal, -76
			elseif numTotal <= 18 then
				perRow, baseY = 6, numTotal <= 12 and -64 or -32
			elseif numTotal <= 32 then
				perRow, baseY = 8, numTotal <= 24 and -24 or 0
			end
			local baseX = (504 - perRow*56)/2
			for i=1,numTotal do
				lootContainer.followers[i]:SetPoint("TOPLEFT", baseX + ((i-1) % perRow) * 56, baseY - 64*floor((i-1)/perRow))
			end
			lootContainer.count = numTotal
		end
		
		lootFrame:Show()
	end
end
local availUI = CreateFrame("Frame", nil, missionList) do
	availUI:SetSize(880, 22)
	availUI:SetPoint("BOTTOMLEFT", GarrisonMissionFrameMissions, "TOPLEFT", 0, 4)
	availUI:Hide()
	local sortIndicator = CreateFrame("Button", nil, availUI) do
		sortIndicator:SetPoint("BOTTOMLEFT", 6, -5)
		sortIndicator:SetSize(320, 43)
		local bg = sortIndicator:CreateTexture(nil, "BACKGROUND")
		bg:SetAtlas("Garr_Mission_MaterialFrame", true)
		bg:SetAllPoints()
		local lab = sortIndicator:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		lab:SetPoint("LEFT", 15, 0) lab:SetText(L"Mission order:")
		sortIndicator.label = lab
		sortIndicator:SetNormalFontObject(GameFontHighlight)
		sortIndicator:SetHighlightFontObject(GameFontGreen)
		sortIndicator:SetText("!")
		local fs = sortIndicator:GetFontString()
		fs:ClearAllPoints() fs:SetPoint("RIGHT", -15, 0)
		local function test(self)
			return sortIndicator.value == self.arg1
		end
		local menu, sortOrders = {
			{text=L"Chance of success", checked=test, func=MasterPlan.SetMissionOrder, arg1="threats"},
			{text=L"Follower experience", checked=test, func=MasterPlan.SetMissionOrder, arg1="xp"},
			{text=L"Follower experience per hour", checked=test, func=MasterPlan.SetMissionOrder, arg1="xptime"},
			{text=L"Mitigated threats", checked=test, func=MasterPlan.SetMissionOrder, arg1="threats2"},
			{text=L"Mission level", checked=test, func=MasterPlan.SetMissionOrder, arg1="level"},
			{text=L"Mission duration", checked=test, func=MasterPlan.SetMissionOrder, arg1="duration"},
			{text=L"Mission expiration", checked=test, func=MasterPlan.SetMissionOrder, arg1="expire"},
		}, {}
		for i=1,#menu do sortOrders[menu[i].arg1] = menu[i].text end
		EV.RegisterEvent("MP_SETTINGS_CHANGED", function(ev, s)
			if s == nil or s == "availableMissionSort" then
				local nv = MasterPlan:GetMissionOrder()
				nv = sortOrders[nv] and nv or "threats"
				sortIndicator:SetText(sortOrders[nv])
				sortIndicator.value = nv
				availMissionsHandle:Refresh(true)
			end
		end)

		sortIndicator:SetScript("OnClick", function(self)
			if easyDrop:IsOpen(self) then
				CloseDropDownMenus()
				return
			end
			easyDrop:Open(self, menu, "TOPRIGHT", self, "BOTTOMRIGHT", -6, 12)
		end)
		sortIndicator:SetScript("OnHide", function(self)
			if easyDrop:IsOpen(self) then
				CloseDropDownMenus()
			end
		end)
	end
	local roamingParty = CreateFrame("Frame", nil, availUI) do
		roamingParty:SetPoint("BOTTOM", 0, -3)
		roamingParty:SetSize(120, 36)
		function roamingParty:GetFollowers()
			return self[1].followerID, self[2].followerID, self[3].followerID
		end
		function roamingParty:DropFollowers(f1, f2, f3)
			for i=1,3 do
				local f = self[i].followerID
				if f and (f == f1 or f == f2 or f == f3) then
					self[i].followerID = nil
				end
			end
			self:Update()
		end
		function roamingParty:Update()
			local changed = false
			for i=1,3 do
				local f, fi = self[i].followerID
				if f then
					fi = C_Garrison.GetFollowerInfo(f)
					if not fi or ((fi.status or "") ~= "" and fi.status ~= GARRISON_FOLLOWER_IN_PARTY) then
						changed, f = true
					end
				end
				if f then
					self[i].portrait:SetToFileData(fi.portraitIconID)
					self[i].portrait:SetVertexColor(1, 1, 1)
				else
					self[i].portrait:SetTexture("Interface\\Garrison\\Portraits\\FollowerPortrait_NoPortrait")
					self[i].portrait:SetVertexColor(0.50, 0.50, 0.50)
				end
				self[i].followerID = f
			end
			if changed and GarrisonMissionFrameListScrollFrame:IsVisible() and GarrisonMissionFrame.selectedTab == 1 then
				RefreshAvailMissionsView(true)
			end
		end
		function roamingParty:Clear()
			for i=1,3 do
				self[i].followerID = nil
			end
			self:Update()
		end
		local function Roamer_SetFollower(_, slot, follower)
			if roamingParty[slot].followerID ~= follower then
				for i=1,3 do
					if roamingParty[slot].followerID == follower then
						roamingParty[slot].followerID = nil
					end
				end
				PlaySound(follower and "UI_Garrison_CommandTable_AssignFollower" or "UI_Garrison_CommandTable_UnassignFollower")
				roamingParty[slot].followerID = follower
				roamingParty:Update()
				RefreshAvailMissionsView(true)
			end
		end
		local function cmp(a,b)
			local am, bm = a.level == 100 and a.quality == 4, b.level == 100 and b.quality == 4
			if am ~= bm then
				return bm
			elseif a.level ~= b.level then
				return a.level > b.level
			elseif floor(a.iLevel/15) ~= floor(b.iLevel/15) then
				return a.iLevel > b.iLevel
			elseif a.quality ~= b.quality then
				return a.quality > b.quality
			else
				return strcmputf8i(a.name, b.name) < 0
			end
		end
		local function Roamer_OnEnter(self)
			if self.followerID and not easyDrop:IsOpen(self) then
				for i=1,#roamingParty do
					if easyDrop:IsOpen(roamingParty[i]) then
						return
					end
				end
				local info, id = C_Garrison.GetFollowerInfo(self.followerID), self.followerID
				GarrisonFollowerTooltip:ClearAllPoints()
				GarrisonFollowerTooltip:SetPoint("TOP", self, "BOTTOM", 0, -2)
				GarrisonFollowerTooltip_Show(info.garrFollowerID,
					info.isCollected,
					C_Garrison.GetFollowerQuality(id),
					C_Garrison.GetFollowerLevel(id),
					C_Garrison.GetFollowerXP(id),
					C_Garrison.GetFollowerLevelXP(id),
					C_Garrison.GetFollowerItemLevelAverage(id),
					C_Garrison.GetFollowerAbilityAtIndex(id, 1),
					C_Garrison.GetFollowerAbilityAtIndex(id, 2),
					C_Garrison.GetFollowerAbilityAtIndex(id, 3),
					C_Garrison.GetFollowerAbilityAtIndex(id, 4),
					C_Garrison.GetFollowerTraitAtIndex(id, 1),
					C_Garrison.GetFollowerTraitAtIndex(id, 2),
					C_Garrison.GetFollowerTraitAtIndex(id, 3),
					C_Garrison.GetFollowerTraitAtIndex(id, 4),
					true
				)
			end
		end
		local function Roamer_OnLeave(self)
			GarrisonFollowerTooltip:Hide()
		end
		local function Roamer_OnClick(self, button)
			if button == "RightButton" then
				Roamer_SetFollower(nil, self:GetID(), nil)
				GarrisonFollowerTooltip:Hide()
			elseif easyDrop:IsOpen(self) then
				CloseDropDownMenus()
				PlaySound("UChatScrollButton")
			else
				PlaySound("UChatScrollButton")
				local mn, f2, slot, cur = {}, C_Garrison.GetFollowers(), self:GetID(), self.followerID
				local a1, a2, a3 = roamingParty:GetFollowers()
				table.sort(f2, cmp)
				for i=1,#f2 do
					local fi, fid = f2[i], f2[i].followerID
					if fi.isCollected and (fi.status or "") == "" and (fid == cur or (fid ~= a1 and fid ~= a2 and fid ~= a3)) and not T.config.ignore[fid] and not MasterPlan:GetFollowerTentativeMission(fid) then
						local tt = ""
						for i=1,4 do
							local id = C_Garrison.GetFollowerTraitAtIndex(fid, i)
							if id and id > 0 then
								tt = (i > 1 and tt .. "|n" or "") .. "|TInterface\\Buttons\\UI-Quickslot2:20:1:-1:0:64:64:31:32:31:32|t|T" .. (C_Garrison.GetFollowerAbilityIcon(id) or "?") .. ":16:16:0:0:64:64:4:60:4:60|t " .. (C_Garrison.GetFollowerAbilityName(id) or "?")
							end
						end
						mn[#mn+1] = {text=G.GetFollowerLevelDescription(fi.followerID, nil), tooltipTitle=GARRISON_TRAITS, tooltipText=tt, tooltipOnButton=true, func=Roamer_SetFollower, arg1=slot, arg2=fi.followerID, checked=cur==fi.followerID}
					end
				end
				if cur then
					mn[#mn+1] = {text=REMOVE, func=Roamer_SetFollower, arg1=slot, justifyH="CENTER", notCheckable=true}
				end
				easyDrop:Open(self, mn, "TOP", self, "BOTTOM", 0, -2)
				GarrisonFollowerTooltip:Hide()
			end
		end
		local function Roamer_OnHide(self)
			if easyDrop:IsOpen(self) then
				CloseDropDownMenus()
			end
		end
		for i=1,3 do
			local x = CreateFrame("Button", nil, roamingParty, nil, i)
			x:SetSize(36, 36)	x:SetPoint("LEFT", 40*i-36, 0) x:RegisterForClicks("LeftButtonUp", "RightButtonUp")
			local v = x:CreateTexture(nil, "ARTWORK", nil, 1) v:SetPoint("TOPLEFT", 3, -3) v:SetPoint("BOTTOMRIGHT", -3, 3) v:SetTexture("Interface\\Garrison\\Portraits\\FollowerPortrait_NoPortrait")
			roamingParty[i], x.portrait = x, v
			local v = x:CreateTexture(nil, "ARTWORK", nil, 2) v:SetAllPoints() v:SetAtlas("Garr_FollowerPortrait_Ring", true)
			local v = x:CreateTexture(nil, "HIGHLIGHT") v:SetPoint("TOPLEFT", -2, 2) v:SetPoint("BOTTOMRIGHT", 1, -1) v:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight") v:SetBlendMode("ADD")
			x:SetScript("OnClick", Roamer_OnClick)
			x:SetScript("OnEnter", Roamer_OnEnter)
			x:SetScript("OnLeave", Roamer_OnLeave)
			x:SetScript("OnHide", Roamer_OnHide)
		end
		EV.RegisterEvent("GARRISON_MISSION_NPC_CLOSED", function() roamingParty:Clear() end)
	end
	api.roamingParty = roamingParty
end
local interestUI = CreateFrame("Frame", nil, missionList) do
	interestUI:Hide()
end
do -- tabs
	local activeTab = CreateFrame("Button", "GarrisonMissionFrameTab3", GarrisonMissionFrame, "GarrisonMissionFrameTabTemplate", 1)
	local availTab = GarrisonMissionFrameTab1
	local interestTab = CreateFrame("Button", "GarrisonMissionFrameTab4", GarrisonMissionFrame, "GarrisonMissionFrameTabTemplate", 1)
	missionList.activeTab, missionList.availTab, missionList.interestTab = activeTab, availTab, interestTab
	activeTab:SetPoint("LEFT", availTab, "RIGHT", -5, 0)
	interestTab:SetPoint("LEFT", activeTab, "RIGHT", -5, 0)
	activeTab.Pulse = activeTab:CreateAnimationGroup() do
		local function cloneTexture(parent, key)
			local t, o = parent:CreateTexture(nil, "BORDER"), parent[key]
			t:SetTexture(o:GetTexture())
			t:SetTexCoord(o:GetTexCoord())
			t:SetAllPoints(o)
			t:SetBlendMode(o:GetBlendMode())
			return t
		end
		activeTab.p1, activeTab.p2 = cloneTexture(activeTab, "LeftHighlight"), cloneTexture(activeTab, "RightHighlight")
		activeTab.p3, activeTab.p4 = cloneTexture(activeTab, "MiddleHighlight"), activeTab:CreateTexture(nil, "BACKGROUND", nil, 1)
		activeTab.p4:SetPoint("TOPLEFT", activeTab.p3, "TOPLEFT", -16, -1)
		activeTab.p4:SetPoint("BOTTOMRIGHT", activeTab.p3, "BOTTOMRIGHT", 6, 12)
		activeTab.p4:SetTexture("Interface\\Buttons\\UI-ListBox-Highlight")
		activeTab.p4:SetBlendMode("ADD")
		activeTab.p4:SetTexCoord(16/128, 112/128, 0, 1)
		
		local ag = activeTab.Pulse
		ag:SetLooping("BOUNCE")
		for i=1,4 do
			local ap = ag:CreateAnimation("Alpha")
			ap:SetDuration(1.25)
			ap:SetFromAlpha(0)
			ap:SetToAlpha(i < 4 and 0.5 or 0.2)
			ap:SetChildKey("p" .. i)
		end
		ag:Play()
		ag:SetScript("OnStop", function()
			for i=1,4 do
				activeTab["p" .. i]:SetAlpha(0)
			end
		end)
	end
	GarrisonMissionFrameTab2:SetPoint("LEFT", interestTab, "RIGHT", -5, 0)
	PanelTemplates_DeselectTab(activeTab)
	PanelTemplates_DeselectTab(interestTab)
	local function ResizeTabs()
		PanelTemplates_TabResize(activeTab, 10)
		PanelTemplates_TabResize(availTab, 10)
		PanelTemplates_TabResize(interestTab, 10)
	end
	local updateMissionTabs = oncePerFrame(function()
		local cm = GarrisonMissionFrame.MissionComplete.completeMissions
		activeTab:SetFormattedText(L"Active Missions (%d)", math.max(#GarrisonMissionFrameMissions.inProgressMissions, cm and #cm or 0))
		availTab:SetFormattedText(L"Available Missions (%d)", #GarrisonMissionFrameMissions.availableMissions)
		interestTab:SetText(L"Missions of Interest")
		ResizeTabs()
		C_Timer.After(0, ResizeTabs)
		if #GarrisonMissionFrameMissions.inProgressMissions == 0 and (cm and #cm or 0) == 0 then
			PanelTemplates_SetDisabledTabState(activeTab)
		else
			(GarrisonMissionFrame.selectedTab == 3 and PanelTemplates_SelectTab or PanelTemplates_DeselectTab)(activeTab)
		end
		(GarrisonMissionFrame.selectedTab == 4 and PanelTemplates_SelectTab or PanelTemplates_DeselectTab)(interestTab)
		if not missionList:IsShown() then
			PanelTemplates_SetDisabledTabState(interestTab)
		end
		api.roamingParty:Update()
		api:SetMissionsUI(GarrisonMissionFrame.selectedTab)
		if GarrisonMissionFrame.selectedTab == 3 or #C_Garrison.GetCompleteMissions() == 0 then
			activeTab.Pulse:Stop()
		else
			activeTab.Pulse:Play()
		end
	end)
	T.UpdateMissionTabs = updateMissionTabs
	hooksecurefunc("GarrisonMissionList_UpdateMissions", updateMissionTabs)
	hooksecurefunc("PanelTemplates_UpdateTabs", function(frame)
		if frame == GarrisonMissionFrame then
			updateMissionTabs()
		end
	end)
	activeTab:SetScript("OnClick", function()
		PlaySound("UI_Garrison_Nav_Tabs")
		if GarrisonMissionFrame.MissionTab.MissionPage:IsShown() then
			GarrisonMissionFrame.MissionTab.MissionPage.MinimizeButton:Click()
		end
		if GarrisonMissionFrame.selectedTab ~= 1 and GarrisonMissionFrame.selectedTab ~= 3 then
			GarrisonMissionFrame_SelectTab(1)
		end
		PanelTemplates_SetTab(GarrisonMissionFrame, 3)
		if not missionList:IsShown() then
			GarrisonMissionList_SetTab(GarrisonMissionFrameMissionsTab2)
		end
		GarrisonMissionFrame_CheckCompleteMissions()
	end)
	availTab:SetScript("OnClick", function()
		PlaySound("UI_Garrison_Nav_Tabs")
		GarrisonMissionFrame_SelectTab(1)
		api:SetMissionsUI(1)
		GarrisonMissionList_SetTab(GarrisonMissionFrameMissionsTab1)
	end)
	interestTab:SetScript("OnClick", function()
		PlaySound("UI_Garrison_Nav_Tabs")
		if GarrisonMissionFrame.MissionTab.MissionPage:IsShown() then
			GarrisonMissionFrame.MissionTab.MissionPage.MinimizeButton:Click()
		end
		GarrisonMissionFrame_SelectTab(1)
		PanelTemplates_SetTab(GarrisonMissionFrame, 4)
		api:SetMissionsUI(4)
	end)
	hooksecurefunc("GarrisonMissionList_SetTab", updateMissionTabs)
	EV.RegisterEvent("GARRISON_MISSION_FINISHED", function()
		if GarrisonMissionFrame:IsVisible() and GarrisonMissionFrame.selectedTab ~= 3 then
			updateMissionTabs()
			PlaySound("UI_Garrison_Toast_MissionComplete")
		end
	end)
end

local GetActiveMissions, StartCompleteAll, CompleteMission, ClearCompletionState do
	local completionMissions, expire, mark = {}, {}, {}

	local function cmp(a,b)
		local ac, bc = expire[a.missionID], expire[b.missionID]
		if (not ac) ~= (not bc) then
			return not ac
		end
		if ac == bc then
			ac, bc = strcmputf8i(a.name, b.name), 0
		end
		return ac < bc
	end
	function GetActiveMissions()
		local rt, rn, now = {}, 1, time()
		
		wipe(mark)
		for i=1,#completionMissions do
			rt[rn], rn, mark[completionMissions[i].missionID or 0] = completionMissions[i], rn + 1, 1
		end
		for j=1,2 do
			local t = C_Garrison[j == 1 and "GetCompleteMissions" or "GetInProgressMissions"]()
			for i=1,#t do
				local v = t[i]
				if not mark[v.missionID] then
					if j == 1 then
						v.timeLeftSeconds = 0
						completionMissions[#completionMissions+1] = v
					end
					if v.missionID and not v.successChance then
						local _, _, _, sc, partyBuffs, _, extraXP = C_Garrison.GetPartyMissionInfo(v.missionID)
						v.successChance, v.groupXPBuff, v.extraXP = sc, G.GetBuffsXPMultiplier(partyBuffs), extraXP
					end
					if v.timeLeft and not v.timeLeftSeconds then
						v.timeLeftSeconds = G.GetSecondsFromTimeString(v.timeLeft)
						v.readyTime = now + v.timeLeftSeconds
					end
					if v.timeLeftSeconds then
						v.readyTime = time() + v.timeLeftSeconds
					end
					rt[rn], rn, mark[v.missionID or 0] = v, rn + 1, 1
				end
			end
		end
		for i=1,rn-1 do
			local id, tl = rt[i].missionID, rt[i].timeLeftSeconds
			local diff = tl and expire[id] and (expire[id] - now - tl) or 1
			if (id and tl) and (diff > 0 or diff < -60) then
				expire[id] = now + tl
			end
		end
		table.sort(rt, cmp)
		table.sort(completionMissions, cmp)
		
		return rt
	end
	
	local function completeStep(state, stack, rew, fol, substate, mid)
		if (state == "DONE" or state == "ABORT") and activeUI.completionState == "RUNNING" then
			activeUI.completionState = state == "DONE" and "DONE" or nil
			if next(rew) or next(fol) then
				activeUI:SetCompletionRewards(rew, fol, #stack)
			end
		end
		if (substate == "FAIL" or substate == "COMPLETE") and mid then
			PlaySoundKitID(substate == "FAIL" and 43501 or 43502, nil, false)
			activeMissionsHandle:SetAnimation(mid, substate)
		end
		RefreshActiveMissionsView()
	end
	function StartCompleteAll()
		wipe(completionMissions)
		GetActiveMissions()
		if #completionMissions > 0 then
			activeUI.completionState = "RUNNING"
			G.CompleteMissions(completionMissions, completeStep)
			return true
		end
	end
	function CompleteMission(mi)
		GarrisonMissionFrame.MissionComplete:Show();
		GarrisonMissionFrame.MissionCompleteBackground:Show();
		GarrisonMissionFrame.MissionComplete.currentIndex = 1
		GarrisonMissionFrame.MissionComplete.completeMissions = {mi}
		GarrisonMissionComplete_Initialize(GarrisonMissionFrame.MissionComplete.completeMissions, 1)
		GarrisonMissionFrame.MissionComplete.NextMissionButton.returnToActiveList = true
	end
	function ClearCompletionState()
		wipe(completionMissions)
	end
end
activeUI.CompleteAll:SetScript("OnClick", function(self)
	PlaySound("UChatScrollButton")
	if IsAltKeyDown() == T.config.batchMissions then
		GarrisonMissionFrame.MissionComplete.completeMissions = C_Garrison.GetCompleteMissions()
		GarrisonMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:Click()
	else
		StartCompleteAll()
	end
end)

local core = {} do
	local int = {view={}}
	local sf, sc, bar = CreateFrame("ScrollFrame", nil, missionList) do
		sf:SetSize(882, 541)
		sf:SetPoint("CENTER")
		bar = CreateFrame("Slider", nil, sf) do
			bar:SetWidth(19)
			bar:SetPoint("TOPRIGHT", 0, -6)
			bar:SetPoint("BOTTOMRIGHT", 0, 8)
			bar:SetThumbTexture("Interface\\Buttons\\UI-ScrollBar-Knob")
			bar:GetThumbTexture():SetSize(18, 24)
			bar:GetThumbTexture():SetTexCoord(0.20, 0.80, 0.125, 0.875)
			bar:SetMinMaxValues(0, 100)
			bar:SetValue(0)
			local bg = bar:CreateTexture("BACKGROUND")
			bg:SetPoint("TOPLEFT", 0, 16)
			bg:SetPoint("BOTTOMRIGHT", 0, -14)
			bg:SetTexture(0,0,0)
			bg:SetAlpha(0.85)
			local top = bar:CreateTexture(nil, "ARTWORK")
			top:SetSize(24, 48)
			top:SetPoint("TOPLEFT", -4, 17)
			top:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
			top:SetTexCoord(0, 0.45, 0, 0.20)
			local bot = bar:CreateTexture(nil, "ARTWORK")
			bot:SetSize(24, 64)
			bot:SetPoint("BOTTOMLEFT", -4, -15)
			bot:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
			bot:SetTexCoord(0.515625, 0.97, 0.1440625, 0.4140625)
			local mid = bar:CreateTexture(nil, "ARTWORK")
			mid:SetPoint("TOPLEFT", top, "BOTTOMLEFT")
			mid:SetPoint("BOTTOMRIGHT", bot, "TOPRIGHT")
			mid:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar")
			mid:SetTexCoord(0, 0.45, 0.1640625, 1)
			local function Move(self)
				bar:SetValue(bar:GetValue() - (2-self:GetID()) * int.props.entryHeight)
			end
			local up = CreateFrame("Button", nil, bar, "UIPanelScrollUpButtonTemplate", 1)
			up:SetPoint("BOTTOM", bar, "TOP", 0, -2)
			local down = CreateFrame("Button", nil, bar, "UIPanelScrollDownButtonTemplate", 3)
			down:SetPoint("TOP", bar, "BOTTOM", 0, 2)
			up:SetScript("OnClick", Move)
			down:SetScript("OnClick", Move)
			sf:SetScript("OnMouseWheel", function(self, direction)
				(direction == 1 and up or down):Click()
			end)
			bar:SetScript("OnValueChanged", function(self, v, _isUserInteraction)
				local _, x = self:GetMinMaxValues()
				int:Update(v, true)
				up:SetEnabled(v > 0)
				down:SetEnabled(v < x)
			end)
		end
		sc = CreateFrame("Frame", nil, sf) do
			sc:SetSize(880, 551)
			sf:SetScrollChild(sc)
		end
		sf:SetScript("OnShow", function()
			int:Update(bar:GetValue())
		end)
	end
	local function Release(keepMin, keepMax)
		local t, w = int.view, int.props.widgets
		for k,v in pairs(t) do
			if k > keepMax or k < keepMin then
				v:SetParent(nil)
				v:ClearAllPoints()
				v:Hide()
				w[#w + 1], t[k] = v
			end
		end
	end
	function int:Update(ofs)
		if not self.props then return end
		if bar:GetValue() ~= ofs then return bar:SetValue(ofs) end
		local entryHeight, bot, w = self.props.entryHeight, ofs + sf:GetHeight(), self.props.widgets
		local baseIndex = (ofs - ofs % entryHeight) / entryHeight
		local maxIndex = (bot + entryHeight - bot % entryHeight) / entryHeight

		local minIndex, maxIndex, childLevel = max(1, baseIndex), min(#self.data, maxIndex), sc:GetFrameLevel()+1
		Release(minIndex, maxIndex)
		for i=minIndex,maxIndex do
			local f = self.view[i]
			if not f then
				f, w[#w] = w[#w] or securecall(self.props.Spawn)
			end
			if f then
				securecall(self.props.Update, f, self.data[i])
				f:SetID(i)
				f:SetParent(sc)
				f:SetFrameLevel(childLevel)
				f:SetPoint("TOP", -10, ofs - 2 - (i-1)*entryHeight)
				f:Show()
				self.view[i] = f
			end
		end
	end

	function core:SetData(data, propsHandle)
		local reset = int.props ~= propsHandle
		if int.props and reset then
			Release(0, -1)
		end
		int.data, int.props = data, propsHandle
		local mv = max(0, 3 + propsHandle.entryHeight * #data - sf:GetHeight())
		bar:SetMinMaxValues(0, mv > 10 and mv or 0)
		bar:GetScript("OnValueChanged")(bar, reset and 0 or bar:GetValue(), false)
	end
	function core:GetRowData(handle, row)
		local id = row:GetID()
		if int.props == handle and int.data and int.view[id] == row then
			return int.data[id]
		end
	end
	function core:Refresh(handle)
		if int.props == handle or handle == nil then
			int:Update(bar:GetValue())
		end
	end
	function core:SetShown(isShown)
		sf:SetShown(isShown)
	end
	function core:IsShown()
		return sf:IsShown()
	end
	function core:IsOwned(propsHandle)
		return int.props == propsHandle
	end
	function core:CreateHandle(createFunc, setFunc, entryHeight)
		return {Spawn=createFunc, Update=setFunc, entryHeight=entryHeight, widgets={}}
	end
end
local CreateMissionButton do
	local CreateRewards do
		local function Reward_OnEnter(self)
			if self.itemID then
				GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
				GameTooltip:SetItemByID(self.itemID)
				GameTooltip:Show()
			elseif self.tooltipTitle and self.tooltipText then
				GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
				GameTooltip:AddLine(self.tooltipTitle)
				GameTooltip:AddLine(self.tooltipText, 1,1,1,1)
				GameTooltip:Show()
			elseif self.currencyID then
				GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
				GameTooltip:SetCurrencyByID(self.currencyID)
				GameTooltip:Show()
			end
			if self:GetParent():IsEnabled() then
				self:GetParent():LockHighlight()
			end
		end
		local function Reward_OnLeave(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:Hide()
			end
			self:GetParent():UnlockHighlight()
		end
		local function Reward_OnClick(self)
			if IsModifiedClick("CHATLINK") then
				local qt, text, _ = self.quantity:GetText()
				if self.itemID then
					_, text = GetItemInfo(self.itemID)
				elseif self.currencyID and self.currencyID ~= 0 then
					text = GetCurrencyLink(self.currencyID)
				elseif self.tooltipTitle then
					text = self.tooltipTitle
				end
				qt = qt and not qt:match("|c") and qt or ""
				if text and qt ~= "" and qt ~= "1" then
					text = qt .. " " .. text
				end
				if text then
					ChatEdit_InsertLink(text)
				end
			end
		end
		local function CreateReward(parent, h)
			local r = CreateFrame("Button", nil, parent)
			r:SetSize(h, h)
			r:SetPoint("RIGHT", -12, 0)
			local t = r:CreateTexture(nil, "BACKGROUND")
			t:SetAtlas("GarrMission_RewardsShadow")
			t:SetPoint("CENTER")
			t:SetSize(h+4, h+4)
			t = r:CreateTexture(nil, "ARTWORK")
			t:SetAllPoints()
			t:SetTexture("Interface\\ICONS\\Temp")
			r.icon = t
			t = r:CreateFontString(nil, "ARTWORK", "GameFontHighlightOutline")
			t:SetPoint("BOTTOMRIGHT", h > 33 and -2 or -1, h > 33 and 3 or 1)
			r.quantity = t
			r:SetScript("OnEnter", Reward_OnEnter)
			r:SetScript("OnLeave", Reward_OnLeave)
			r:SetScript("OnHide", Reward_OnLeave)
			r:SetScript("OnClick", Reward_OnClick)
			return r
		end
		local rewardsMT = {__index=function(self, k)
			local l = self[k-1]
			local r = CreateReward(l:GetParent(), self._h)
			r:SetPoint("RIGHT", l, "LEFT", -4, 0)
			self[k] = r
			return self[k]
		end}
		function CreateRewards(parent, h)
			return setmetatable({_h=h, [1]=CreateReward(parent, h)}, rewardsMT)
		end
	end
	local function RaiseVeil(self)
		self:SetFrameLevel(self:GetParent():GetFrameLevel()+5)
	end
	function CreateMissionButton(h)
		local b = CreateFrame("Button")
		b:SetSize(845, h)
		
		local t = b:CreateTexture(nil, "BACKGROUND", nil, -1)
		t:SetAtlas("GarrMission_MissionParchment", true)
		t:SetPoint("TOPLEFT", 3, 0) t:SetPoint("BOTTOMRIGHT", -3, 0)
		t:SetVertTile(true) t:SetHorizTile(true)
		t = b:CreateTexture(nil, "BACKGROUND", nil, 1)
		t:SetAtlas("!GarrMission_Bg-Edge", true)
		t:SetVertTile(true)
		t:SetPoint("TOPLEFT", -10, 0)
		t:SetPoint("BOTTOMLEFT", -10, 0)
		t = b:CreateTexture(nil, "BACKGROUND", nil, 1)
		t:SetAtlas("!GarrMission_Bg-Edge", true)
		t:SetVertTile(true)
		t:SetPoint("TOPRIGHT", 10, 0)
		t:SetPoint("BOTTOMRIGHT", 10, 0)
		t:SetTexCoord(1,0, 0,1)
		t = b:CreateTexture(nil, "BACKGROUND", nil, 2)
		t:SetAtlas("_GarrMission_MissionListTopHighlight", true)
		t:SetHorizTile(true)
		t:SetPoint("TOPLEFT", 3, 0)
		t:SetPoint("TOPRIGHT", -3, 0)
		t = b:CreateTexture(nil, "BACKGROUND", nil, 2)
		t:SetAtlas("_GarrMission_Bg-BottomEdgeSmall", true)
		t:SetHorizTile(true)
		t:SetPoint("BOTTOMLEFT", 3, 0)
		t:SetPoint("BOTTOMRIGHT", -3, 0)
		t = b:CreateTexture(nil, "BORDER")
		t:SetAtlas("_GarrMission_TopBorder", true)
		t:SetPoint("TOPLEFT", 20, 4)
		t:SetPoint("TOPRIGHT", -20, 4)
		t = b:CreateTexture(nil, "BORDER")
		t:SetAtlas("_GarrMission_TopBorder", true)
		t:SetPoint("BOTTOMLEFT", 20, -4)
		t:SetPoint("BOTTOMRIGHT", -20, -4)
		t:SetTexCoord(0,1, 1,0)
		t = b:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner", true)
		t:SetPoint("TOPLEFT", -5, 4)
		t = b:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner", true)
		t:SetPoint("TOPRIGHT", 4, 4)
		t:SetTexCoord(1,0, 0,1)
		t = b:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner", true)
		t:SetPoint("BOTTOMLEFT", -5, -4)
		t:SetTexCoord(0,1, 1,0)
		t = b:CreateTexture(nil, "BORDER", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner", true)
		t:SetPoint("BOTTOMRIGHT", 4, -4)
		t:SetTexCoord(1,0, 1,0)
		t = b:CreateTexture(nil, "HIGHLIGHT")
		t:SetAtlas("_GarrMission_TopBorder-Highlight", true)
		t:SetHorizTile(true)
		t:SetPoint("TOPLEFT", 21, 4)
		t:SetPoint("TOPRIGHT", -22, 4)
		t = b:CreateTexture(nil, "HIGHLIGHT")
		t:SetAtlas("_GarrMission_TopBorder-Highlight", true)
		t:SetHorizTile(true)
		t:SetPoint("BOTTOMLEFT", 21, -4)
		t:SetPoint("BOTTOMRIGHT", -22, -4)
		t:SetTexCoord(0,1, 1,0)
		t = b:CreateTexture(nil, "HIGHLIGHT", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner-Highlight", true)
		t:SetPoint("TOPLEFT", -5, 4)
		t = b:CreateTexture(nil, "HIGHLIGHT", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner-Highlight", true)
		t:SetPoint("TOPRIGHT", 4, 4)
		t:SetTexCoord(1,0, 0,1)
		t = b:CreateTexture(nil, "HIGHLIGHT", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner-Highlight", true)
		t:SetPoint("BOTTOMLEFT", -5, -4)
		t:SetTexCoord(0,1, 1,0)
		t = b:CreateTexture(nil, "HIGHLIGHT", nil, 1)
		t:SetAtlas("GarrMission_TopBorderCorner-Highlight", true)
		t:SetPoint("BOTTOMRIGHT", 4, -4)
		t:SetTexCoord(1,0, 1,0)
		t = b:CreateTexture(nil, "HIGHLIGHT", nil, 1)
		t:SetAtlas("GarrMission_ListGlow-Highlight")
		t:SetGradient("VERTICAL", 0.5, 0.5, 0.5, 1,1,1)
		t:SetPoint("TOPLEFT") t:SetPoint("TOPRIGHT")
		t:SetHeight(30/44*h) -- SCALE
		t = b:CreateTexture(nil, "BACKGROUND", nil, 3)
		t:SetAtlas("Garr_MissionList-IconBG")
		t:SetPoint("TOPLEFT", 0, -1)
		t:SetPoint("BOTTOMLEFT", 0, 1)
		t:SetWidth(46 + h) -- SCALE
		t, b.iconBG = b:CreateTexture(nil, "ARTWORK"), t
		t:SetPoint("LEFT", 56, 0) t:SetSize(h-16, h-16) -- SCALE
		t, b.mtype = b:CreateFontString(nil, "ARTWORK", "Game30Font"), t
		t:SetPoint("CENTER", b, "LEFT", 33, 0)
		t:SetTextColor(0.84, 0.72, 0.57)
		t, b.level = b:CreateFontString(nil, "ARTWORK", "QuestFont_Super_Huge"), t
		t:SetPoint("LEFT", 52+h, 0) -- SCALE
		t:SetTextColor(1,1,1)
		t:SetShadowColor(0,0,0)
		t:SetShadowOffset(1,-1)
		t, b.title = b:CreateTexture(nil, "ARTWORK", nil, 2), t
		t:SetAtlas("GarrMission_RareOverlay", true)
		t:SetPoint("BOTTOMLEFT", -5, -4)
		t, b.rare = CreateFrame("Frame", nil, b), t
		t:SetScript("OnShow", RaiseVeil)
		b.veil, t = t, t:CreateTexture(nil, "OVERLAY", nil, -1)
		t:SetAllPoints(b)
		t:SetTexture(1,1,1)
		t:SetGradient("VERTICAL", 0.8, 0.8, 0.8, 0.6, 0.6, 0.6)
		t:SetBlendMode("MOD")
		
		b.rewards = CreateRewards(b, 32/44*h)
		b.rewards[1]:SetPoint("RIGHT", -14, 1)
		
		return b
	end
end
local CreateFollowerPortrait do
	local function Follower_OnEnter(self)
		if self.followerID then
			if self:GetParent():IsEnabled() then
				self:GetParent():LockHighlight()
			end
			local info, id = C_Garrison.GetFollowerInfo(self.followerID), self.followerID
			GarrisonFollowerTooltip:ClearAllPoints()
			GarrisonFollowerTooltip:SetPoint("TOP", self, "BOTTOM", 0, -2)
			GarrisonFollowerTooltip_Show(info.garrFollowerID,
				info.isCollected,
				C_Garrison.GetFollowerQuality(id),
				C_Garrison.GetFollowerLevel(id),
				C_Garrison.GetFollowerXP(id),
				C_Garrison.GetFollowerLevelXP(id),
				C_Garrison.GetFollowerItemLevelAverage(id),
				C_Garrison.GetFollowerAbilityAtIndex(id, 1),
				C_Garrison.GetFollowerAbilityAtIndex(id, 2),
				C_Garrison.GetFollowerAbilityAtIndex(id, 3),
				C_Garrison.GetFollowerAbilityAtIndex(id, 4),
				C_Garrison.GetFollowerTraitAtIndex(id, 1),
				C_Garrison.GetFollowerTraitAtIndex(id, 2),
				C_Garrison.GetFollowerTraitAtIndex(id, 3),
				C_Garrison.GetFollowerTraitAtIndex(id, 4),
				not self.showAbilityDescriptions
			)
			if self.postEnter then
				self:postEnter(info)
			end
		end
		if GarrisonFollowerTooltip:GetTop() > self:GetBottom() then
			GarrisonFollowerTooltip:ClearAllPoints()
			GarrisonFollowerTooltip:SetPoint("BOTTOM", self, "TOP", 0, 2)
		end
	end
	local function Follower_OnLeave(self)
		GarrisonFollowerTooltip:Hide()
		self:GetParent():UnlockHighlight()
	end
	function CreateFollowerPortrait(parent, size, id)
		local x = CreateFrame("Button", nil, parent, nil, id)
		x:SetSize(size, size)
		local v = x:CreateTexture(nil, "ARTWORK", nil, 3)
		v:SetPoint("TOPLEFT", 3, -3) v:SetPoint("BOTTOMRIGHT", -3, 3)
		v, x.portrait = x:CreateTexture(nil, "ARTWORK", nil, 4), v
		v:SetPoint("TOPLEFT", -2, 2) v:SetPoint("BOTTOMRIGHT", 2, -2)
		v:SetAtlas("Garr_FollowerPortrait_Ring")
		v, x.ring = x:CreateTexture(nil, "HIGHLIGHT"), v
		v:SetPoint("TOPLEFT", -2, 2) v:SetPoint("BOTTOMRIGHT", 2, -2)
		v:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
		v:SetBlendMode("ADD")
		x:SetScript("OnEnter", Follower_OnEnter)
		x:SetScript("OnLeave", Follower_OnLeave)
		x:SetScript("OnHide", Follower_OnLeave)
		return x
	end
end
do -- activeMissionsHandle
	local anim = {}
	
	local function Follower_OnEnter(self, info)
		if info then
			G.ExtendFollowerTooltipMissionRewardXP(core:GetRowData(activeMissionsHandle, self:GetParent()), info)
		end
	end
	local function ActiveMission_OnClick(self)
		local mi = core:GetRowData(activeMissionsHandle, self)
		if IsModifiedClick("CHATLINK") then
			local missionLink = C_Garrison.GetMissionLink(mi.missionID)
			if (missionLink) then
				ChatEdit_InsertLink(missionLink)
			end
		elseif mi.readyTime and mi.readyTime < time() and not (mi.succeeded or mi.failed) and activeUI.completionState ~= "RUNNING" then
			CompleteMission(mi)
		end
	end
	local function Banner_OnPlay(self)
		local par = self:GetParent()
		local fail = self == par.Fail
		par.banner:SetVertexColor(fail and 1 or 0.2, fail and 0.2 or 1, 0.2)
		par.banner:Show()
	end
	local function Banner_OnStop(self)
		local par = self:GetParent()
		par.banner:Hide()
	end
	local function CreateActiveMission()
		local b = CreateMissionButton(44)
		b:SetScript("OnClick", ActiveMission_OnClick)
		
		local t = b:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		t:SetPoint("RIGHT", -160, 0)
		t:SetTextColor(0.84, 0.72, 0.57)
		b.status = t
		t = b:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
		t:SetPoint("CENTER", b, "RIGHT", -120, 0)
		t:SetTextColor(0.84, 0.72, 0.57)
		b.chance = t
		t = b:CreateTexture(nil, "OVERLAY")
		t:SetAtlas("GarrMission_LevelUpBanner")
		t:SetPoint("CENTER", 0, -1) t:SetSize(832*1.3, 44*2.85)
		t:SetBlendMode("ADD")
		t:SetAlpha(0)
		b.banner = t
		
		for i=1,2 do
			local g = b:CreateAnimationGroup()
			g:SetToFinalAlpha(true)
			g:SetScript("OnPlay", Banner_OnPlay)
			g:SetScript("OnStop", Banner_OnStop)
			t = g:CreateAnimation("Alpha")
			t:SetChildKey("banner")
			t:SetFromAlpha(0) t:SetToAlpha(1)
			t:SetDuration(0.2)
			t = g:CreateAnimation("Scale")
			t:SetChildKey("banner")
			t:SetFromScale(0.3, 1) t:SetToScale(1, 1)
			t:SetDuration(0.4)
			t = g:CreateAnimation("Alpha")
			t:SetChildKey("banner")
			t:SetStartDelay(0.4) t:SetDuration(0.5)
			t:SetFromAlpha(1) t:SetToAlpha(0)
			b[i == 1 and "Fail" or "Success"] = g
		end
		
		b.followers = {}
		for i=1,3 do
			t = CreateFollowerPortrait(b, 32, i)
			t:SetPoint("RIGHT", -265-34*i, 1)
			t.postEnter, b.followers[i] = Follower_OnEnter, t
		end
	
		return b
	end
	local function TimerUpdate(self)
		local mi = core:GetRowData(activeMissionsHandle, self)
		if mi and mi.readyTime then
			local sec = mi.readyTime - time()
			self.status:SetText(G.GetTimeStringFromSeconds(sec))
			if sec < -1 then
				self:SetScript("OnUpdate", nil)
				RefreshActiveMissionsView(false)
			end
		end
	end
	local function setData(self, d)
		local isSame = core:GetRowData(activeMissionsHandle, self) == d
		self.level:SetText((d.isRare and "|cff4DB5FF" or "") .. (d.iLevel > 600 and d.iLevel or d.level))
		self.rare:SetShown(d.isRare or false)
		self.iconBG:SetVertexColor(0, d.isRare and 0.012 or 0, d.isRare and 0.291 or 0, 0.4)
		self.mtype:SetAtlas(d.typeAtlas)
		self.title:SetText(d.name)
		local tl, col, state = d.timeLeftSeconds or G.GetSecondsFromTimeString(d.timeLeft), ""
		self:SetScript("OnUpdate", tl > 0 and tl < 60 and TimerUpdate or nil)
		if tl > 0 then
			state = d.timeLeft
		elseif d.failed then
			col, state = "|cffff2020", L"Failed"
		elseif d.succeeded or d.state >= 0 then
			col, state = "|cff20ff20", L"Success"
		else
			col, state = "|cffffea10", L"Ready"
		end
		self.status:SetText(col .. state)
		self.chance:SetText(d.successChance and (d.successChance .. "%") or "")
		
		local sanim = anim[d.missionID]
		if sanim or (not isSame and (self.Fail:IsPlaying() or self.Success:IsPlaying())) then
			self.Fail:Stop()
			self.Success:Stop()
			if sanim then
				self[sanim == "COMPLETE" and "Success" or "Fail"]:Play()
			end
		end
		
		local nr, nf, r = 1, 1
		if type(d.followers) == "table" then
			local fin, fi, w = G.GetFollowerInfo()
			for i=1,#d.followers do
				fi, w = fin[d.followers[i]], self.followers[nf]
				if fi and w then
					w.followerID, nf = fi.followerID, nf + 1
					w.portrait:SetToFileData(fi.portraitIconID)
					w:Show()
				end
			end
		end
		if type(d.rewards) == "table" then
			for k,v in pairs(d.rewards) do
				local icon, quant = v.icon, v.quantity ~= 1 and v.quantity
				r, nr = self.rewards[nr], nr + 1
				r.itemID, r.tooltipTitle, r.tooltipText, r.currencyID = v.itemID, v.title, v.tooltip, v.currencyID
				if v.followerXP then
					quant = abridge(v.followerXP)
				elseif v.currencyID == 0 then
					quant = abridge(v.quantity/10000)
					r.tooltipText = GetMoneyString(v.quantity)
				elseif v.currencyID == GARRISON_CURRENCY then
					v.materialMultiplier = v.materialMultiplier or select(8, C_Garrison.GetPartyMissionInfo(d.missionID)) or 1
					quant = abridge(v.quantity * v.materialMultiplier)
				elseif v.itemID then
					local _, _, q, l, _, _, _, _, _, tex = GetItemInfo(v.itemID)
					if not tex then tex = GetItemIcon(v.itemID) end
					if v.quantity == 1 and q and l and l > 500 then
						quant = ITEM_QUALITY_COLORS[q].hex .. l
					end
					if tex then
						icon = tex
					end
				end
				r.quantity:SetText(quant or "")
				r.icon:SetTexture(icon or "Interface/Icons/Temp")
				r:Show()
			end
		end

		for i=nr, #self.rewards do
			self.rewards[i]:Hide()
		end
		for i=nf, #self.followers do
			self.followers[i]:Hide()
		end
		self.veil:SetShown(tl > 0)
	end
	activeMissionsHandle = core:CreateHandle(CreateActiveMission, setData, 48)
	function activeMissionsHandle:Activate(force)
		if force then
			ClearCompletionState()
		end
		local am = GetActiveMissions()
		local nextUpdate, hasComplete = 60, false
		for i=1,#am do
			local tl, m = am[i].timeLeftSeconds, am[i]
			if tl == 120 then
				nextUpdate = 1
			elseif tl == 0 and not (m.succeeded or m.failed) then
				hasComplete = true
			end
		end
		core:SetData(am, activeMissionsHandle)
		wipe(anim)
		activeUI.CompleteAll:SetShown(not activeUI.lootFrame:IsShown() and (hasComplete and activeUI.completionState ~= "RUNNING"))
		activeUI.nextRefresh = nextUpdate
		if force then
			if #am == 0 then
				GarrisonMissionFrame_SelectTab(1)
			end
		end
	end
	function activeMissionsHandle:SetAnimation(mid, state)
		anim[mid] = state
	end
end
do -- availMissionsHandle
	local used = {}
	local CreateThreat, SetThreat = {} do
		local GetThreatColor do
			local threatColors={[0]={1,0,0}, {0.15, 0.45, 1}, {0.20, 0.45, 1}, {1, 0.55, 0}, {0,1,0}}
			function GetThreatColor(counters, missionLevel, finfo, threatID, used)
				if not missionLevel then return 1,1,1 end
				local finfo, quality, bk = finfo or G.GetFollowerInfo(), 0
				for i=1,counters and #counters or 0 do
					local fi = finfo[counters[i]]
					local ld, mt = G.GetLevelEfficiency(G.GetFMLevel(fi), missionLevel), fi.missionTimeLeft and 0 or 2
					local uk = fi.isCombat and (threatID .. "#" .. i)
					if not fi.isCombat or (used and used[uk]) or T.config.ignore[fi.followerID] then
					elseif ld == 1 and quality < (2+mt) then
						quality, bk = 2+mt, uk
						if mt == 2 then break end
					elseif ld == 0.5 and quality < (1+mt) then
						quality, bk = 1+mt, uk
					end
				end
				if bk then used[bk] = 1 end
				return unpack(threatColors[quality])
			end
		end
		local function Threat_OnLeave(self)
			GarrisonMissionMechanicTooltip:Hide()
			self:GetParent():UnlockHighlight()
		end
		local function Threat_OnEnter(self)
			self:GetParent():LockHighlight()
			GarrisonMissionMechanicTooltip.missionLevel = self.missionLevel
			GarrisonMissionMechanic_OnEnter(self)
			GarrisonMissionMechanicTooltip.missionLevel = nil
		end
		function CreateThreat(parent)
			local b = CreateFrame("Button", nil, parent, "GarrisonAbilityCounterTemplate")
			b:SetScript("OnEnter", Threat_OnEnter)
			b:SetScript("OnLeave", Threat_OnLeave)
			return b
		end
		function SetThreat(self, info, level, counters, followers, threatID, used)
			self.info, self.missionLevel = info, level
			self.Icon:SetTexture(info.icon)
			self.Border:SetVertexColor(GetThreatColor(counters, level, followers, threatID, used))
			self:Show()
		end
	end
	local function AvailMission_OnClick(self)
		local mi = core:GetRowData(availMissionsHandle, self)
		if IsModifiedClick("CHATLINK") then
			local missionLink = C_Garrison.GetMissionLink(mi.missionID)
			if (missionLink) then
				ChatEdit_InsertLink(missionLink)
			end
		elseif mi.missionID then
			OpenToMission(mi)
		end
	end
	local function GroupButton_OnEnter(self)
		self:GetParent():LockHighlight()
		local mi = core:GetRowData(availMissionsHandle, self:GetParent())
		local g = mi and mi.groups and mi.groups[self:GetID()]
		if g then
			GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -6, 0)
			GameTooltip:AddLine(g[1] .. "% |cffc0c0c0(" .. SecondsToTime(g[4]) .. ")")
			local finfo, ml = G.GetFollowerInfo(), G.GetFMLevel(mi)
			for i=1,mi.numFollowers do
				GameTooltip:AddLine(G.GetFollowerLevelDescription(g[4+i], ml, finfo[g[4+i]]))
			end
			if g.expectedXP and g.expectedXP > 0 then
				local exp = BreakUpLargeNumbers(floor(g.expectedXP))
				GameTooltip:AddLine((L"+%s experience expected"):format(exp))
			end
			GameTooltip:Show()
		end
	end
	local function GroupButton_OnLeave(self)
		self:GetParent():UnlockHighlight()
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide()
		end
	end
	local function GroupButton_OnMouseUp(self, override)
		local tex = self.tex
		for i=1,6 do
			tex[i]:SetShown(i < 4)
		end
	end
	local function GroupButton_OnMouseDown(self, override)
		local tex, isDisabled = self.tex, self:GetButtonState() == "DISABLED"
		for i=1,6 do
			tex[i]:SetShown((i > 3) ~= isDisabled)
		end
	end
	local function GroupButton_OnClick(self)
		local mi = core:GetRowData(availMissionsHandle, self:GetParent())
		local g = mi and mi.groups and mi.groups[self:GetID()]
		if g then
			OpenToMission(mi, g[5], g[6], g[7])
		end
	end
	local function CreateGroupButton(parent, id)
		local b, bh, bw = CreateFrame("Button", nil, parent, nil, id), 24, 12
		b:SetSize(120, bh)
		local t, tt, tn = b:CreateTexture(nil, "BACKGROUND"), {}, 1
		t:SetPoint("LEFT") t:SetSize(bw, bh)
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		t:SetTexCoord(0.90039063, 0.925781255, 0.04980469, 0.07519531)
		t, tt[tn], tn = b:CreateTexture(nil, "BACKGROUND"), t, tn + 1
		t:SetPoint("RIGHT") t:SetSize(bw, bh)
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		t:SetTexCoord(0.925781255, 0.95117188, 0.04980469, 0.07519531)
		t, tt[tn], tn = b:CreateTexture(nil, "BACKGROUND"), t, tn + 1
		t:SetPoint("TOPLEFT", bw, 0) t:SetPoint("BOTTOMRIGHT", -bw, 0)
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures_Tile")
		t:SetHorizTile(true)
		t:SetTexCoord(0,1, 0.00195313, 0.05273438)
		t, tt[tn], tn = b:CreateTexture(nil, "BACKGROUND"), t, tn + 1
		t:SetPoint("LEFT") t:SetSize(bw, bh)
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		t:SetTexCoord(0.63476563, 0.660156255, 0.06738281, 0.09277344)
		t, tt[tn], tn = b:CreateTexture(nil, "BACKGROUND"), t, tn + 1
		t:SetPoint("RIGHT") t:SetSize(bw, bh)
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		t:SetTexCoord(0.660156255, 0.68554688, 0.06738281, 0.09277344)
		t, tt[tn], tn = b:CreateTexture(nil, "BACKGROUND"), t, tn + 1
		t:SetPoint("TOPLEFT", bw, 0) t:SetPoint("BOTTOMRIGHT", -bw, 0)
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures_Tile")
		t:SetHorizTile(true)
		t:SetTexCoord(0,1, 0.05664063, 0.10742188)
		t, tt[tn], tn = b:CreateTexture(nil, "HIGHLIGHT"), t, tn + 1
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		t:SetTexCoord(0.72656250, 0.751953125, 0.06738281, 0.09277344)
		t:SetSize(bw, bh) t:SetPoint("LEFT")
		t = b:CreateTexture(nil, "HIGHLIGHT")
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures")
		t:SetTexCoord(0.751953125, 0.77734375, 0.06738281, 0.09277344)
		t:SetSize(bw, bh) t:SetPoint("RIGHT")
		t = b:CreateTexture(nil, "HIGHLIGHT")
		t:SetTexture("Interface\\EncounterJournal\\UI-EncounterJournalTextures_Tile")
		t:SetTexCoord(0,1, 0.11132813,0.16210938) t:SetHorizTile(true)
		t:SetPoint("TOPLEFT", bw, 0) t:SetPoint("BOTTOMRIGHT", -bw, 0)
		b.tex = tt
		GroupButton_OnMouseUp(b, true)
		b:SetPushedTextOffset(0, -1)
		b:SetNormalFontObject(GameFontHighlightSmall)
		b:SetText("!")
		b:GetFontString():SetTextColor(0.973, 0.902, 0.581)
		
		b:SetMotionScriptsWhileDisabled(true)
		b:SetScript("OnEnter", GroupButton_OnEnter)
		b:SetScript("OnLeave", GroupButton_OnLeave)
		b:SetScript("OnMouseDown", GroupButton_OnMouseDown)
		b:SetScript("OnMouseUp", GroupButton_OnMouseUp)
		b:SetScript("OnClick", GroupButton_OnClick)
		
		return b
	end
	local function CreateAvailMission()
		local b = CreateMissionButton(64)
		b.title:ClearAllPoints()
		b.title:SetPoint("TOPLEFT", 68+48, -9)
		b.level:ClearAllPoints()
		b.level:SetPoint("CENTER", b, "LEFT", 31, 4)
		b:SetScript("OnClick", AvailMission_OnClick)
		local t = b:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge2")
		t:SetPoint("BOTTOMLEFT", b.title, "BOTTOMRIGHT", 6, 0)
		t:SetTextColor(0.8, 0.8, 0.8)
		t, b.stats = b:CreateTexture(nil, "BACKGROUND", nil, 3), t
		t:SetSize(780, 62)
		t:SetPoint("RIGHT")
		t, b.loc = b:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall"), t
		t:SetTextColor(0.84, 0.72, 0.57)
		t:SetPoint("TOP", b, "TOPLEFT", 78, -5)
		t, b.expire = b:CreateFontString(nil, "ARTWORK", "GameFontNormal"), t
		t:SetPoint("TOP", b.level, "BOTTOM", 0, -1)
		t, b.followers = {}, t
		
		for i=1,7 do
			t[i] = CreateThreat(b)
		end
		t[1]:SetPoint("TOPRIGHT", b, "RIGHT", -128, 23)
		t[3]:SetPoint("BOTTOMRIGHT", b, "RIGHT", -143, -21)
		t[2]:SetPoint("RIGHT", t[1], "LEFT", -9, 0)
		t[4]:SetPoint("RIGHT", t[3], "LEFT", -9, 0)
		t[5]:SetPoint("RIGHT", t[2], "LEFT", -9, 0)
		t[6]:SetPoint("RIGHT", t[4], "LEFT", -9, 0)
		t[7]:SetPoint("RIGHT", t[5], "LEFT", -9, 0)
		t, b.threats = {}, t
		
		for i=1,3 do
			t[i] = CreateGroupButton(b, i)
			t[i]:SetPoint("LEFT", t[i-1], "RIGHT", 4, 0)
		end
		t[1]:ClearAllPoints()
		t[1]:SetPoint("BOTTOMLEFT", 112, 5)
		b.groups = t

		return b
	end
	local GetAvailableResources do
		local numFollowers, garrResources
		local function forget()
			numFollowers, garrResources = nil
		end
		function GetAvailableResources(dropCost)
			if not numFollowers then
				local n, _, r = 0, GetCurrencyInfo(GARRISON_CURRENCY)
				for k,v in pairs(G.GetFollowerInfo()) do
					if v.isCombat and (v.status == GARRISON_FOLLOWER_IN_PARTY or v.status == nil) and not T.config.ignore[v.followerID] then
						n = n + 1
					end
				end
				numFollowers, garrResources = n, r
				C_Timer.After(0, forget)
			end
			return numFollowers, garrResources - (dropCost or 0)
		end
	end
	local function FormatCountdown(sec)
		if sec >= 3600 then
			return (sec % 3600 < 60) and HOUR_ONELETTER_ABBR:format(sec / 3600) or L("%dh %dm"):format(sec / 3600, sec / 60 % 60)
		else
			return format(SecondsToTimeAbbrev(sec < 0 and 0 or sec))
		end
	end
	local function setData(self, d)
		self.level:SetText((d.isRare and "|cff4DB5FF" or "") .. (d.iLevel > 600 and d.iLevel or d.level))
		self.rare:SetShown(d.isRare or false)
		self.iconBG:SetVertexColor(0, d.isRare and 0.012 or 0, d.isRare and 0.291 or 0, 0.4)
		self.mtype:SetAtlas(d.typeAtlas)
		self.title:SetText(d.name)
		local summary = d.duration
		if d.durationSeconds >= GARRISON_LONG_MISSION_TIME then
			summary = format(GARRISON_LONG_MISSION_TIME_FORMAT, summary)
		end
		if d.cost and d.cost > 0 and false then
			summary = summary .. "; " .. d.cost .. " |TInterface\\Garrison\\GarrisonCurrencyIcons:0:0:0:0:128:128:13:46:13:46|t"
		end
		self.stats:SetFormattedText(PARENS_TEMPLATE, summary)
		local min, max, exp = G.GetMissionSeen(d.missionID)
		if exp and exp > 0 then
			local text = math.max(0,exp-floor(max/3600+0.5))
			if min - max >= 3600 and text > 0 then
				text = math.max(0, exp-floor(min/3600+0.5)) .. "-" .. text
			end
			self.expire:SetFormattedText(GARRISON_DURATION_HOURS:gsub("%%[%d$]*d", "%%s"), text)
		else
			self.expire:SetText("")
		end

		if d.locPrefix then
			self.loc:SetAtlas(d.locPrefix.."-List")
		end
		self.loc:SetShown(not not d.locPrefix)
		local fol = "" do
			local nf = MasterPlan:HasTentativeParty(d.missionID)
			for i=1, d.numFollowers do
				fol = fol .. "|TInterface\\FriendsFrame\\UI-Toast-FriendOnlineIcon:11:11:3:0:32:32:8:24:8:24:" ..
				      (nf < i and "214:170:115|t" or "255:180:0|t")
			end
		end
		self.followers:SetText(fol)

		local nr = 1
		if type(d.rewards) == "table" then
			for k,v in pairs(d.rewards) do
				local icon, quant, r = v.icon, v.quantity ~= 1 and v.quantity
				r, nr = self.rewards[nr], nr + 1
				r.itemID, r.tooltipTitle, r.tooltipText, r.currencyID = v.itemID, v.title, v.tooltip, v.currencyID
				if v.followerXP then
					quant = v.followerXP
				elseif v.currencyID == 0 then
					quant = floor(v.quantity/10000)
					r.tooltipText = GetMoneyString(v.quantity)
				elseif v.currencyID == GARRISON_CURRENCY then
					quant = v.quantity
				elseif v.itemID then
					local _, _, q, l, _, _, _, _, _, tex = GetItemInfo(v.itemID)
					if not tex then tex = GetItemIcon(v.itemID) end
					if v.quantity == 1 and q and l and l > 500 then
						quant = ITEM_QUALITY_COLORS[q].hex .. l
					end
					if tex then
						icon = tex
					end
				end
				r.quantity:SetText(quant or "")
				r.icon:SetTexture(icon or "Interface/Icons/Temp")
				r:Show()
			end
		end
		for i=nr, #self.rewards do
			self.rewards[i]:Hide()
		end
		
		local cinfo, finfo, mlvl = G.GetCounterInfo(), G.GetFollowerInfo(), G.GetFMLevel(d)
		local enemies, ename, edesc, etex, _ = d.enemies, d.envName, d.envDescription, d.envTexture
		if not (enemies and ename and edesc and etex) then
			_, _, ename, edesc, etex, _, _, enemies = C_Garrison.GetMissionInfo(d.missionID)
			d.enemies, d.envName, d.envDescription, d.envTexture = enemies, ename, edesc, etex
		end
		local nt, tt, used = 1, self.threats, wipe(used) or used
		for i=1,#enemies do
			for id, minfo in pairs(enemies[i].mechanics) do
				nt = nt + 1, SetThreat(tt[nt], minfo, mlvl, cinfo[id], finfo, id, used)
			end
		end
		for i=nt,#tt do
			tt[i]:Hide()
		end

		local sg = d.groups
		for i=1,#sg do
			local b, g, text = self.groups[i], sg[i]
			local sc = "|cffffffff" .. g[1] .. "%"
			if g[3] and g[3] > 0 then
				text = floor(g[1]*g[3]/100) .. " |TInterface\\Garrison\\GarrisonCurrencyIcons:14:14:0:0:128:128:12:52:12:52|t"
			elseif g.expectedXP and g.expectedXP > 0 then
				if T.config.availableMissionSort == "xptime" then
					text = (L"%s XP/h"):format(abridge(floor(g.expectedXP*3600/g[4])))
				else
					text = (L"%s XP"):format(abridge(floor(g.expectedXP)))
				end
			end
			if g.earliestDeparture then
				if g[3] and g[3] > 0 then
					text = text .. ", " .. sc
				elseif sg.rankType == "threats" or not text then
					text = sc
				end
				text = "|cffb0b0b0" .. FormatCountdown(g.earliestDeparture-time()) .. ": " .. text
				b:Disable()
			else
				text = (text and text .. ", " or "") .. sc
				b:Enable()
			end
			b:SetText(text)
			local bw = b:GetFontString():GetStringWidth()+14
			bw = math.max(110, bw)
			b:SetWidth(bw + (10 - bw % 10) % 10)
			b:Show()
		end
		for i=#sg+1, #self.groups do
			self.groups[i]:Hide()
		end

		self.veil:SetShown(d.reqCheckFailed)
	end
	local GetAvailableMissions do
		local roamingParty, groupCache = api.roamingParty, {}
		local used, cinfo, finfo = {}
		EV.RegisterEvent("GARRISON_MISSION_NPC_CLOSED", function()
			wipe(groupCache)
		end)
		local function cmp(a,b)
			if a.reqCheckFailed ~= b.reqCheckFailed then
				return b.reqCheckFailed
			end
			local ac, bc = a.ord, b.ord
			if ac == bc then
				ac, bc = a.level, b.level
			end
			if ac == bc then
				ac, bc = a.iLevel, b.iLevel
			end
			if ac == bc then
				ac, bc = 0, strcmputf8i(a.name, b.name)
			end
			return ac > bc
		end
		local function computeThreat(a)
			local ret, threats, lvl = 0, T.Garrison.GetMissionThreats(a.missionID), G.GetFMLevel(a)
			for i=1,#threats do
				local c, quality, bk = cinfo[threats[i]], 0
				for j=1,c and #c or 0 do
					local fi = finfo[c[j]]
					local ld, mt = G.GetLevelEfficiency(G.GetFMLevel(fi), lvl), fi.missionTimeLeft and 0 or 2
					local uk = fi.isCombat and (threats[i] .. "#" .. fi.followerID)
					if not fi.isCombat or used[uk] then
					elseif ld == 1 and quality < (2+mt) then
						quality, bk = 2+mt, uk
						if mt == 2 then break end
					elseif ld == 0.5 and quality < (1+mt) then
						quality, bk = 1+mt, uk
					end
				end
				ret, used[bk or 1] = ret + (quality-4)*100, 1
			end
			wipe(used)
			return ret < 0 and -1 or 0
		end
		local fields = {threats=1, xp="equivXP", xptime="equivXPTime"}
		function GetAvailableMissions()
			local order, missions, droppedMissionCost = T.config.availableMissionSort, G.GetAvailableMissions()
			local field, f1, f2, f3 = fields[order] or 1, roamingParty:GetFollowers()
			local _, fid = G.GetFollowerIdentity()
			finfo, fid = G.GetFollowerInfo(), fid .. "#-ROAM-#" .. (f1 or "!") .. "-" .. (f2 or "!") .. "-" .. (f3 or "!")
			if groupCache._identity ~= fid then
				wipe(groupCache)
				groupCache._identity = fid
			end
			G.PrepareAllMissionGroups()
			for i=1, #missions do
				local mi, sg, g = missions[i]
				
				if groupCache[mi.missionID] then
					sg = groupCache[mi.missionID]
				else
					local rank, rt = G.GetMissionDefaultGroupRank(mi)
					local a = G.GetBackfillMissionGroups(mi, G.GroupFilter.IDLE, rank, 1, f1, f2, f3)
					local b = G.GetBackfillMissionGroups(mi, G.GroupFilter.IDLE, G.GroupRank.threats2, 2, f1, f2, f3)
					local c = G.GetBackfillMissionGroups(mi, G.GroupFilter.COMBAT, rank, 1, f1, f2, f3)
					if c and c[1] then G.AnnotateMissionParty(c[1], finfo, mi, true) end
					g = a and a[1] or nil
					b = b and (b[1] ~= g and b[1] or b[2] ~= g and b[2]) or nil
					c = c and c[1] and c[1].earliestDeparture and c[1] or nil
					if g and c and rank(g, c, finfo, mi, time()) then
						c = nil
					end
					sg = {g, rankType=rt}
					if b and g ~= b then
						sg[#sg+1] = b
					elseif a and a[2] then
						sg[#sg+1] = a[2]
					end
					if c then
						sg[#sg+1] = c
					end
				end
				for i=1,#sg do
					G.AnnotateMissionParty(sg[i], finfo, mi, true)
				end
				mi.groups, groupCache[mi.missionID], g = sg, sg, sg[1] and not sg[1].earliestDeparture and sg[1] or nil
				
				if field == "equivXPTime" and g and g.equivXP and g[4] then
					mi.ord = g.equivXP/g[4]
				else
					mi.ord = g and g[field] or -math.huge
				end
			end
			if order == "duration" then
				for i=1, #missions do
					missions[i].ord = -missions[i].durationSeconds
				end
			elseif order == "expire" then
				for i=1, #missions do
					local mi = missions[i]
					local max, _, dur = G.GetMissionSeen(mi.missionID)
					mi.ord = (dur or 0) > 0 and min(0, floor(max/1800 - dur*2)) or -math.huge
				end
			elseif order == "level" then
				for i=1, #missions do
					missions[i].ord = 0
				end
			elseif order == "threats2" then
				cinfo = G.GetCounterInfo()
				for i=1, #missions do
					local mi = missions[i]
					local g = G.GetBackfillMissionGroups(mi, G.GroupFilter.IDLE, G.GroupRank.threats, 1, roamingParty:GetFollowers())
					mi.ord = g and g[1] and g[1][1] == 100 and computeThreat(mi) or -1
				end
			end
			local nf, nr = GetAvailableResources(droppedMissionCost)
			if (nf < 3 or nr < 100) and T.config.availableMissionSort ~= "expire" then
				for i=1, #missions do
					local mi = missions[i]
					if mi.cost > nr or mi.numFollowers > nf then
						mi.reqCheckFailed = true
					end
				end
			end
			table.sort(missions, cmp)
			return missions
		end
	end
	local timeToNextRefresh = 0
	availUI:SetScript("OnUpdate", function(self, elapsed)
		if timeToNextRefresh < elapsed then
			availMissionsHandle:Refresh(false)
		else
			timeToNextRefresh = timeToNextRefresh - elapsed
		end
	end)
	availMissionsHandle = core:CreateHandle(CreateAvailMission, setData, 67)
	function availMissionsHandle:Activate(full)
		timeToNextRefresh = 60
		if full then
			core:SetData(GetAvailableMissions(), availMissionsHandle)
		else
			core:Refresh(availMissionsHandle)
		end
	end
	function availMissionsHandle:Refresh(reload)
		if core:IsOwned(self) and core:IsShown() then
			availMissionsHandle:Activate(reload)
		end
	end
end
do -- interestMissionsHandle
	local function Threat_OnLeave(self)
		GarrisonMissionMechanicTooltip:Hide()
	end
	local function Threat_OnEnter(self)
		GarrisonMissionMechanic_OnEnter(self)
	end
	local function CreateThreat(parent)
		local b = CreateFrame("Frame", nil, parent)
		b:SetSize(21, 21)
		local t = b:CreateTexture(nil, "ARTWORK")
		t:SetAllPoints()
		t, b.Icon = b:CreateTexture(nil, "ARWORK", nil, 1), t
		t:SetAtlas("GarrMission_EncounterAbilityBorder-Lg")
		t:SetSize(34.5, 34.5)
		t:SetPoint("CENTER")
		b.Border, b.info = t, {}
		b:SetScript("OnEnter", Threat_OnEnter)
		b:SetScript("OnLeave", Threat_OnLeave)
		return b
	end
	local function SetThreat(self, level, tid, name, icon)
		local info = self.info
		info.name, info.icon, self.missionLevel, info.description = name, icon, level, G.GetMechanicDescription(tid) or " "
		self.Icon:SetTexture(icon)
	end
	local function Follower_OnClick(self)
		if self.followerID then
			GarrisonMissionFrame.selectedFollower = self.followerID
			GarrisonFollowerPage_ShowFollower(GarrisonMissionFrame.FollowerTab, self.followerID)
			GarrisonMissionFrameTab2:Click()
		end
	end
	local function Follower_OnEnter(self, info)
		local data = core:GetRowData(interestMissionsHandle, self:GetParent())
		if info and data and data.best then
			for i=1,#GarrisonFollowerTooltip.Abilities do
				local b = GarrisonFollowerTooltip.Abilities[i]
				local tid, prefix = b:IsShown() and G.GetMechanicInfo((b.CounterIcon:GetTexture():lower():gsub("%.blp$", ""))), false
				if tid then
					for j=#data,6,-1 do
						if data[j] == tid then
							prefix = data.best[j] == 2 and "|cfff0ff10" or "|cff10ff10"
							break
						end
					end
					b.Details:SetText((prefix or "|cffa0a0a0")  .. b.Details:GetText())
				end
			end
		end
	end
	local function CreateInterestMission()
		local b = CreateMissionButton(58)
		b.title:ClearAllPoints()
		b.title:SetPoint("TOPLEFT", 68+42, -11)
		b.level:ClearAllPoints()
		b.level:SetPoint("CENTER", b, "LEFT", 32, 7)
		b.rare:Hide()
		b.iconBG:SetVertexColor(0, 0, 0, 0.4)
		b.veil:Hide()
		b:Disable()

		local t = b:CreateTexture(nil, "BACKGROUND", nil, 3)
		t:SetSize(780, 62)
		t:SetPoint("RIGHT")
		t, b.loc = b:CreateTexture(nil, "BACKGROUND", nil, 4), t
		t:SetAtlas("GarrMission_MissionParchment")
		t:SetVertexColor(0.25, 0.25, 0.25)
		t:SetHorizTile(true)
		t:SetAllPoints()
		t:Hide()
		t, b.altBG = b:CreateFontString(nil, "ARTWORK", "GameFontNormal"), t
		t:SetPoint("TOP", b.level, "BOTTOM", 0, -1)
		t:SetAlpha(0.8)
		t, b.fc = b:CreateFontString(nil, "ARTWORK", "GameFontNormalHuge"), t
		t:SetPoint("RIGHT", -70, 0)
		t, b.chance = b:CreateFontString(nil, "ARTWORK", "GameFontNormal"), t
		t:SetPoint("TOPLEFT", b.title, "BOTTOMLEFT", 0, -2)
		t, b.seen = {}, t
		for i=1,6 do
			t[i] = CreateThreat(b)
			t[i]:SetPoint("RIGHT", t[i-1], "LEFT", -10, 0)
		end
		t[1]:ClearAllPoints()
		t[1]:SetPoint("TOPRIGHT", -150, -5)
		t[4]:SetPoint("TOPRIGHT", t[1], "BOTTOMRIGHT", -15.5, -3)
		b.threats = t
		
		b.followers = {}
		for i=1,3 do
			t = CreateFollowerPortrait(b, 42, i)
			t:SetPoint("RIGHT", -225-44*i, 1)
			t:SetScript("OnClick", Follower_OnClick)
			t.showAbilityDescriptions, b.followers[i], t.postEnter = true, t, Follower_OnEnter
		end
		
		return b
	end
	local missionTypes = {[0]="Generic", [-1]="Trading", [-2]="Enchanting", [-3]="Enchanting", [-4]="Generic"}
	local missionLocations = {
		[133]="GarrMissionLocation-FrostfireRidge-List", [404]="GarrMissionLocation-FrostfireRidge-List",
		[361]="GarrMissionLocation-TannanJungle-List", [405]="GarrMissionLocation-TannanJungle-List",
		[268]="GarrMissionLocation-Gorgrond-List", [311]="GarrMissionLocation-Gorgrond-List",
		[407]="GarrMissionLocation-Talador-List", [132]="GarrMissionLocation-SpiresofArak-List", "GarrMissionLocation-Nagrand-List"
	}
	local missionRewards = {
		[-0]={0, 1},
		[-1]={0, 5000000},
		[-2]={115280, 3},
		[-3]={115510, 18},
		[-4]={122484, 1},
	}
	local GetHighmaulReward do
		local r = {
			{118531,15,9285,9289,9294,9300,9304,9311,9315},
			{118531,15,9284,9288,9293,9298,9303,9310,9314},
			{118530,15,9282,9287,9292,9297,9302,9308,9313},
			{118529,0}
		}
		function GetHighmaulReward()
			for i=1,#r do
				local c, r = 0, r[i]
				for i=3,#r do
					c = c + (tonumber(GetStatistic(r[i]) or 0) or 0)
				end
				if c >= r[2] then
					return r[1]
				end
			end
		end
	end
	local unusedFollowers = CreateFrame("Button") do
		unusedFollowers:SetSize(880, 38)
		local t = unusedFollowers:CreateFontString(nil, "ARTWORK", "GameFontNormal")
		t:SetText(L"Unused followers:")
		t:SetPoint("BOTTOM", unusedFollowers, "TOP", 0, 3)
		for i=1,21 do
			local t = CreateFollowerPortrait(unusedFollowers, 34, i)
			t:SetPoint("BOTTOMLEFT", 36*i-35, 3)
			t:SetScript("OnClick", Follower_OnClick)
			unusedFollowers[i], t.showAbilityDescriptions = t, true
		end
	end
	local function setUnused(self, d)
		self.altBG:Show()
		for i=1,#self.rewards do
			self.rewards[i]:Hide()
		end
		for i=1,#self.followers do
			self.followers[i]:Hide()
		end
		for i=1,#self.threats do
			self.threats[i]:Hide()
		end
		self.level:SetText("")
		self.fc:SetText("")
		self.title:SetText("")
		self.seen:SetText("")
		self.chance:SetText("")
		self.mtype:SetTexture(0,0,0,0)
		unusedFollowers:SetParent(self)
		unusedFollowers:SetPoint("BOTTOM")
		local finfo = G.GetFollowerInfo()
		for i=1,#d do
			local fb, fi = unusedFollowers[i], finfo[d[i]]
			if fb and fi then
				fb.followerID = fi.followerID
				fb.portrait:SetToFileData(fi.portraitIconID or 0)
				fb:Show()
			end
		end
		for i=#d+1,#unusedFollowers do
			unusedFollowers[i]:Hide()
		end
		unusedFollowers:SetWidth(36 * math.min(#d, #unusedFollowers))
		unusedFollowers:Show()
	end
	local function setData(self, d)
		if d.unused then
			return setUnused(self, d.unused)
		else
			if unusedFollowers:GetParent() == self then
				unusedFollowers:SetParent(nil)
				unusedFollowers:Hide()
			end
			self.altBG:Hide()
		end
		self.level:SetText(d[2])
		self.title:SetText((C_Garrison.GetMissionLink(d[1]) or ""):match("|h%[?(.-)%]?|h") or (L"Future Mission #%d"):format(d[1]))
		self.mtype:SetAtlas("GarrMission_MissionIcon-" .. (d[5] > 0 and "Provision" or missionTypes[d[5]] or "Combat"))
		self.loc:SetAtlas(missionLocations[d[1]] or missionLocations[1])
		self.fc:SetText(("|TInterface\\FriendsFrame\\UI-Toast-FriendOnlineIcon:11:11:3:0:32:32:8:24:8:24:214:170:115|t"):rep(d[3]))
		local _, _, _, lc = G.GetMissionSeen(d[1])
		for i=1,d[5] == 0 and 3 or 0 do
			local _, _, _, l2 = G.GetMissionSeen(d[1]+4*i)
			if l2 and (not lc or lc > l2) then
				lc = l2
			end
		end
		self.seen:SetText((lc and lc > 0) and (L"Last completed: %s ago"):format("|cffffffff" .. SecondsToTime(lc) .. "|r") or "")
		local best = d.best
		for i=1, #self.threats do
			local tb, tid = self.threats[i], d[6+i]
			tb:SetShown(tid)
			if tid then
				SetThreat(tb, d[2], G.GetMechanicInfo(tid))
				if best and best[6+i] then
					tb.Border:SetVertexColor(0.2, 1, 0.2)
				else
					tb.Border:SetVertexColor(1, 0.2, 0.2)
				end
			end
		end
		local nf, finfo = best and d[3] or 0, G.GetFollowerInfo()
		for i=1,nf do
			local fb, fi = self.followers[i], finfo[best[i]]
			fb.followerID = best[i]
			fb.portrait:SetToFileData(fi and fi.portraitIconID or 0)
			if fi.status == GARRISON_FOLLOWER_INACTIVE then
				fb.portrait:SetVertexColor(0.2, 0.2, 1)
			elseif d[2] > (d[2] > 100 and fi.iLevel or fi.level) then
				fb.portrait:SetVertexColor(1, 0.4, 0.4)
			else
				fb.portrait:SetVertexColor(1,1,1)
			end
			fb:Show()
		end
		for i=nf+1, #self.followers do
			self.followers[i]:Hide()
		end
		self.chance:SetText(best and ("%d%%"):format(best[5]*100) or "")
		if best and best[5] >= 1 then
			self.chance:SetTextColor(0, 1, 0)
		else
			self.chance:SetTextColor(1, 0.65, 0)
		end
		
		local r, ri = self.rewards[1], missionRewards[d[5]]
		if d[5] > 0 then
			r.currencyID, r.itemID, r.tooltipTitle, r.tooltipText = GARRISON_CURRENCY
			r.quantity:SetText(d[5] * (1 + 2*(best and best[4] or 0)))
			r.icon:SetTexture("Interface\\Icons\\inv_garrison_resource")
		elseif ri[1] == 0 then
			r.tooltipTitle, r.tooltipText, r.currencyID, r.itemID = GARRISON_REWARD_MONEY, GetMoneyString(ri[2]), 0
			r.icon:SetTexture("Interface\\Icons\\INV_Misc_Coin_02")
			r.quantity:SetFormattedText("%d", ri[2] / 1e4)
		else
			r.itemID, r.currencyID, r.tooltipTitle, r.tooltipText = ri[1]
			r.quantity:SetText(ri[2] > 1 and ri[2] or "")
			r.icon:SetTexture(select(10, GetItemInfo(r.itemID)) or GetItemIcon(r.itemID) or "Interface/Icons/Temp")
		end
		r:Show()
	end
	local missions, unusedEntry = {
		{313, 645, 3, 28800, 0, 28, 1, 2, 6, 8, 9, 10}, -- Highmaul Raid
		{314, 645, 3, 28800, 0, 17, 1, 3, 3, 4, 6, 7}, -- Highmaul Raid
		{315, 645, 3, 28800, 0, 12, 2, 4, 7, 9, 10, 10}, -- Highmaul Raid
		{316, 645, 3, 28800, 0, 29, 1, 6, 8, 9, 9, 10}, -- Highmaul Raid
		{311, 630, 3, 21600, 175, 11, 2, 3, 6, 10}, -- Can't Go Home This Way
		{312, 630, 3, 21600, 175, 25, 2, 4, 8, 10}, -- Magical Mystery Tour
		{268, 615, 3, 14400, 130, 22, 2, 3, 7}, -- Who's the Boss?
		{269, 615, 3, 14400, 130, 20, 1, 6, 10}, -- Griefing with the Enemy
		{132, 100, 2, 21600, 100, 15, 4, 6}, -- The Basilisk's Stare
		{133, 100, 2, 21600, 100, 18, 3, 8}, -- Elemental Territory
		{361, 100, 3, 36000, -1, 25, 2, 3, 7, 9}, -- Blingtron's Secret Vault
		{407, 100, 3, 86000, -2, 13, 3, 4, 6, 8, 8}, -- Tower of Terror
		{405, 100, 3, 86000, -2, 20, 1, 2, 4, 7, 9}, -- Lost in the Weeds
		{403, 100, 3, 86000, -2, 27, 3, 6, 7, 8}, -- Rock the Boat
		{404, 100, 3, 86000, -2, 12, 2, 6, 7, 8}, -- He Keeps it Where?
		{406, 100, 3, 86000, -2, 27, 1, 2, 3, 10}, -- It's Rigged!
		{410, 100, 3, 86000, -3, 16, 2, 3, 4, 8, 9}, -- A Rune with a View
		{412, 100, 3, 86000, -3, 24, 2, 2, 3, 3, 7, 9}, -- Beyond the Pale
		{413, 100, 3, 86000, -3, 27, 1, 2, 4, 6, 7, 8}, -- Pumping Iron
		{411, 100, 3, 86000, -3, 29, 2, 3, 3, 6, 8, 9}, -- Rocks Fall. Everyone Dies.
		{409, 100, 3, 86000, -3, 22, 1, 2, 3, 6, 9, 9}, -- The Great Train Robbery
		{446, 660, 3, 28800, -4, 18, 1, 3, 6, 7, 9, 10}, -- Slagworks
		{447, 660, 3, 28800, -4, 21, 1, 2, 3, 3, 6, 10}, -- Black Forge
		{448, 660, 3, 28800, -4, 24, 4, 4, 6, 7, 7, 8}, -- Iron Assembly
		{449, 660, 3, 28800, -4, 11, 1, 2, 3, 6, 9, 10}, -- Blackhand's Crucible
	}, {unused={}}
	interestMissionsHandle = core:CreateHandle(CreateInterestMission, setData, 60)
	interestUI:SetScript("OnShow", function()
		local reload = not core:IsOwned(interestMissionsHandle)
		local id = IsAltKeyDown() and "A" or "-" .. select(2,G.GetFollowerIdentity())
		reload, interestMissionsHandle.ident = reload or interestMissionsHandle.ident ~= id, id
		if reload then
			if missions[#missions] == unusedEntry then
				missions[#missions] = nil
			end
			missionRewards[-0][1] = GetHighmaulReward()
			local c2, c3, ni = IsQuestFlaggedCompleted(35998), IsQuestFlaggedCompleted(36013), 1
			if c2 or c3 then
				for i=1,#missions do
					local rt = missions[i][5]
					if (rt ~= -2 or not c2) and (rt ~= -3 or not c3) then
						missions[ni], ni = missions[i], ni + 1
					end
				end
				for i=ni,#missions do
					missions[i] = nil
				end
			end
			G.UpdateGroupEstimates(missions, IsAltKeyDown())
			local uf, ua = {}, unusedEntry.unused
			wipe(ua)
			for k, v in pairs(G.GetFollowerInfo()) do
				if v.status ~= GARRISON_FOLLOWER_INACTIVE and v.status ~= GARRISON_FOLLOWER_WORKING and not T.config.ignore[k] then
					uf[k] = true
				end
			end
			for i=1,#missions do
				local b = missions[i].best
				for j=1, b and missions[i][3] or 0 do
					uf[b[j] or 0] = nil
				end
			end
			for k in pairs(uf) do
				ua[#ua + 1] = k
			end
			if #ua > 0 then
				local fi = G.GetFollowerInfo()
				table.sort(ua, function(a,b)
					a, b = fi[a], fi[b]
					return (a.level + a.iLevel) > (b.level + b.iLevel)
				end)
				missions[#missions+1] = unusedEntry
			end
			core:SetData(missions, interestMissionsHandle)
		else
			core:Refresh()
		end
	end)
end
do -- RefreshActiveMissionsView
	local isFullRefresh, isDirty = true
	local function DoRefresh()
		local force = isFullRefresh
		isFullRefresh, isDirty = nil
		activeMissionsHandle:Activate(force)
	end
	function RefreshActiveMissionsView(force)
		if core:IsShown() and (force or core:IsOwned(activeMissionsHandle)) then
			isFullRefresh = isFullRefresh or force
			if not isDirty then
				isDirty = true
				C_Timer.After(0, DoRefresh)
			end
		end
	end
	activeUI:SetScript("OnShow", RefreshActiveMissionsView)
end
do -- RefreshAvailMissionsView
	local isFullRefresh, ph, isDirty = true, {}
	local function DoRefresh()
		local full = isFullRefresh
		isDirty, isFullRefresh = nil
		if core:IsOwned(availMissionsHandle) then
			availMissionsHandle:Activate(full)
		end
	end
	function RefreshAvailMissionsView(force)
		if core:IsShown() and (force or core:IsOwned(availMissionsHandle)) then
			if not isDirty then
				isDirty, isFullRefresh = true, isFullRefresh or force or not core:IsOwned(availMissionsHandle)
				if not core:IsOwned(availMissionsHandle) then
					core:SetData(ph, availMissionsHandle)
				end
				C_Timer.After(0, DoRefresh)
			end
		end
	end
	availUI:SetScript("OnShow", RefreshAvailMissionsView)
	EV.RegisterEvent("GARRISON_MISSION_LIST_UPDATE", function()
		if availUI:IsVisible() then
			RefreshAvailMissionsView(true)
		end
	end)
end
activeUI:SetScript("OnUpdate", function(self, elapsed)
	local nr = self.nextRefresh or 0
	if nr < elapsed then
		RefreshActiveMissionsView()
	else
		self.nextRefresh = nr - elapsed
	end
end)
EV.RegisterEvent("GET_ITEM_INFO_RECEIVED", function()
	if core:IsShown() then
		core:Refresh()
	end
end)
hooksecurefunc("GarrisonMissionFrame_HideCompleteMissions", function(onClose)
	if not onClose and core:IsOwned(activeMissionsHandle) then
		RefreshActiveMissionsView(true)
	end
end)

local oldComplete = GarrisonMissionFrame_CheckCompleteMissions
function GarrisonMissionFrame_CheckCompleteMissions(onShow, ...)
	if not missionList:IsShown() then
		return oldComplete(onShow, ...)
	end
	if not GarrisonMissionFrame.MissionComplete:IsShown() then
		GarrisonMissionFrame.MissionComplete.completeMissions = C_Garrison.GetCompleteMissions()
		if #GarrisonMissionFrame.MissionComplete.completeMissions > 0 then
			T.UpdateMissionTabs()
		end
	end
	if onShow and not activeUI:IsVisible() and GarrisonMissionFrame:IsShown() and #C_Garrison.GetCompleteMissions() > 0 then
		GarrisonMissionFrame_SelectTab(1)
		PanelTemplates_SetTab(GarrisonMissionFrame, 3)
	end
end
do -- periodic comleted missions check
	local isTimerRunning = false
	local function timer()
		if GarrisonMissionFrame:IsShown() then
			local cm = GarrisonMissionFrame.MissionComplete.completeMissions
			if (cm and #cm or 0) == 0 then
				GarrisonMissionFrame_CheckCompleteMissions()
			end
			C_Timer.After(15, timer)
			isTimerRunning = true
		else
			isTimerRunning = false
		end
	end
	GarrisonMissionFrame:HookScript("OnShow", function()
		if not isTimerRunning then
			timer()
		end
	end)
end

function api:SetMissionsUI(tab)
	availUI:SetShown(tab == 1)
	activeUI:SetShown(tab == 3)
	interestUI:SetShown(tab == 4)
	if not activeUI:IsShown() then
		if activeUI.completionState == "RUNNING" then
			G.AbortCompleteMissions()
		end
		activeUI.completionState = nil
	end
end
T.MissionsUI = api