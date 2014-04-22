-- Author      : s1172
-- Create Date : 2013/4/26 14:09:12


function NewbieAssistantPannelFrame_OnShow(self)
	
	if MultiBarRight:IsShown() then
		if MultiBarLeft:IsShown() then
			self:SetPoint("RIGHT",UIParent,"RIGHT",-100,0)
		else
			self:SetPoint("RIGHT",UIParent,"RIGHT",-45,0)
		end
	else
		self:SetPoint("RIGHT",UIParent,"RIGHT",0,0)
	end

	local data = self.data
	if not data then return end
	local lvl = self.level

	-- 主窗口标题
	self.Title:SetText(data.Title)

	-- 主窗口介绍
	self.Description:SetText(data.Description)

	-- 常驻区按钮1
	if lvl <= 5 then
		self.ButtomIcon1.data = data.PetBattle
	else
		self.ButtomIcon1.data = data.Battleground
	end
	self.ButtomIcon1.icon:SetTexture(self.ButtomIcon1.data.Texture)
	self.ButtomIcon1.Title:SetText(self.ButtomIcon1.data.Title)
	self.ButtomIcon1.Description:SetText(self.ButtomIcon1.data.Description)
	self.ButtomIcon1:Show()

	-- 常驻区按钮2
	if lvl <= 10 then
		self.ButtomIcon2.data = data.Talent
	else
		self.ButtomIcon2.data = data.Dungeon
	end
	self.ButtomIcon2.icon:SetTexture(self.ButtomIcon2.data.Texture)
	self.ButtomIcon2.Title:SetText(self.ButtomIcon2.data.Title)
	self.ButtomIcon2.Description:SetText(self.ButtomIcon2.data.Description)
	self.ButtomIcon2:Show()

	-- 常驻区按钮3
	self.ButtomIcon3.data = data.Mount
	self.ButtomIcon3.icon:SetTexture(self.ButtomIcon3.data.Texture)
	self.ButtomIcon3.Title:SetText(self.ButtomIcon3.data.Title)
	self.ButtomIcon3.Description:SetText(self.ButtomIcon3.data.Description)
	self.ButtomIcon3:Show()

	-- 前瞻区按钮
	for i = 1, 3, 1 do
		self["MidIcon"..i].data = data[i]
		if self["MidIcon"..i].data then
			self["MidIcon"..i].icon:SetTexture(self["MidIcon"..i].data.Texture)
			self["MidIcon"..i].Title:SetText(self["MidIcon"..i].data.Title)
			self["MidIcon"..i].Description:SetText(self["MidIcon"..i].data.Description)
			self["MidIcon"..i]:Show()
		else
			self["MidIcon"..i]:Hide()
		end
	end
	
end

function NewbieAssistantPannelFrame_OnEvent(self, event, ...)
	local level, IsLevelUp
	
	if event == "PLAYER_LEVEL_UP" then
		level = ...
		IsLevelUp = true
	else
		level = UnitLevel("player")
	end

	self.level = level

	if level > 20 then
		NewbieAssistantPannelFrame:Hide()
		NewbieAssistantPannelFrameToggleButton:Hide()
		return
	end

	NewbieAssistantPannelFrame_Update(level, IsLevelUp)

	if IsLevelUp then
		if NewbieAssistantPannelFrame:IsShown() then
			NewbieAssistantPannelFrameToggleButton_Update(NewbieAssistantPannelFrameToggleButton)
		end
		NewbieAssistantPannelFrameToggleButton_Update(NewbieAssistantPannelFrameToggleButton)
		NAApi:Sleep(30,function()
			if NewbieAssistantPannelFrame:IsShown() then
				NewbieAssistantPannelFrameToggleButton_Update(NewbieAssistantPannelFrameToggleButton)
			end
		end)
	end
end

function NewbieAssistantPannelFrame_Update(level, IsLevelUp)
	if not level then return end

	local self = NewbieAssistantPannelFrame
	local data = NAtPanel_Script.Cache[tonumber(level)]

	self.data = {}
	
	if data then
		self.data = data
	else
		self.data.Description = "本级暂无提示"
	end
	
	if IsLevelUp then
		self.data.Title = format("恭喜您升到%s级",level)
	else
		self.data.Title = format("当前等级%s级",level)
	end
end

function NewbieAssistantPannelFrameToggleButton_OnClick(self)
	NewbieAssistantPannelFrame_Update(NewbieAssistantPannelFrame.level)
	NewbieAssistantPannelFrameToggleButton_Update(self)
	--self:SetFrameLevel(100)
end

function NewbieAssistantPannelFrameToggleButton_Update(self)
	local frame = NewbieAssistantPannelFrame
	local offsetX = 0

	if MultiBarRight:IsShown() then
		if MultiBarLeft:IsShown() then
			offsetX = -80
		else
			offsetX = -35
		end
	end

	if frame:IsShown() then
		NewbieAssistantPannelFrame_HideAllChildFrame()
		frame:Hide()
		local tex = self:GetNormalTexture()
		tex:SetTexCoord(0.5,1,0,1)
		tex = self:GetHighlightTexture()
		tex:SetTexCoord(0.5,1,0,1)
		self:SetPoint("RIGHT",UIParent,"RIGHT",0,115)
	else
		frame:Show()
		local tex = self:GetNormalTexture()
		tex:SetTexCoord(0,0.4,0,1)
		tex = self:GetHighlightTexture()
		tex:SetTexCoord(0,0.4,0,1)
		self:SetPoint("RIGHT",UIParent,"RIGHT",-203 + offsetX,115)
	end
end

function NewbieAssistantPannelFrameButtomIcon3_OnClick(self)
	local frame = NewbieAssistantPanelMountFrame
	frame.data = self.data.Detial

	ToggleFrame(frame)
end

function NewbieAssistantPannelFrameButtomIcon2_OnClick(self)
	local lvl = self:GetParent().level
	local frame

	if	lvl <=10 then 
		frame = NewbieAssistantPanelTalentFrame
		frame.data = self.data.Detial
	else
		frame = NewbieAssistantPanelDungeonFrame
	end
	
	ToggleFrame(frame)
end

function NewbieAssistantPannelFrameButtomIcon1_OnClick(self)
	local lvl = self:GetParent().level
	local frame

	if lvl <= 5 then
		frame = NewbieAssistantPanelPetBattleFrame
	else 
		frame = NewbieAssistantPanelBattlegroundFrame
	end

	frame.data = self.data.Detial

	ToggleFrame(frame)
end

function NewbieAssistantPannelFrame_OnHide(self)
	self.ButtomIcon1:Hide()
	self.ButtomIcon2:Hide()
	self.ButtomIcon3:Hide()
end

function NewbieAssistantPannelFrame_OnLoad(self)
	self:SetScale(.8)
	self:RegisterEvent("PLAYER_LEVEL_UP")
	self:RegisterEvent("VARIABLES_LOADED")
	self.level = UnitLevel("player")
	if IsTrialAccount() then
		NewbieAssistantPannelFrameKeyboardTechButton:SetPoint("TOPLEFT",self,"TOPLEFT",30,-69)
		NewbieAssistantPannelFramePaymentTechButton:Show()
	end
end