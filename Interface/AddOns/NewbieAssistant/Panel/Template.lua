-- Author      : s1172
-- Create Date : 2013/4/28 11:47:59

local NewbieAssistantPanelChildFrames = {
	["1"] = "NewbieAssistantPanelSkillFrame", -- 技能介绍面板
	["2"] = "NewbieAssistantPanelSkillFrame", -- 专业介绍面板
	["3"] = "NewbieAssistantPanelQuestFrame", -- 任务介绍面板
	["4"] = "NewbieAssistantPanelEquipFrame", -- 装备介绍面板
}

function NewbieAssistantPanelMiddleItemButtonTemplate_OnClick(self)
	for i,k in pairs(NewbieAssistantPanelChildFrames) do
		if tonumber(i) == self.data.Type and _G[k] then
			_G[k].data = self.data
			if _G[k]:IsShown() then
				_G[k]:Hide()
			else
				_G[k]:Show()
			end
		end
	end
end

function NewbieAssistantPanelSkillInfoTemplate_OnShow(self)
	local data = self.data
	if not data then return end

	self.Title:SetText(data.Title)
	if data.Detial then
		self.Description:SetText(data.Detial)
	else
		self.Description:SetText(data.Description)
	end
	self.icon:SetTexture(data.Texture)
	self.link=data.Link
	self.Description:SetPoint("TOPLEFT",self.Title,"BOTTOMLEFT",0,-5)
end

function NewbieAssistantPanelMountMiddleIconTemplate_OnClick(self)
	local frame = NewbieAssistantPanelMountFrame
	frame.data = self.data
	frame.largeIcon.icon:SetTexture(frame.data.Texture)
	frame.largeIcon.link = frame.data.Link
	frame.largeIcon.bgTitle:SetText(frame.data.bgTitle)
	frame.largeIcon.bgDescription:SetText(frame.data.bgDescription)
	frame.largeIcon.getTitle:SetText(frame.data.getTitle)
	frame.largeIcon.getDescript:SetText(frame.data.getDescript)
	frame.largeIcon.bgPic:SetTexture(frame.data.bgPic)
	frame.largeIcon.Title:SetText(frame.data.Title)
end

function NewbieAssistantPannelFrame_HideAllChildFrame()
	local chileframe = {
		"NewbieAssistantPanelSkillFrame", -- 技能介绍面板
		"NewbieAssistantPanelQuestFrame", -- 任务介绍面板
		"NewbieAssistantPanelEquipFrame", -- 装备介绍面板
		"NewbieAssistantPanelPetBattleFrame", -- 宠物战斗
		"NewbieAssistantPanelTalentFrame", -- 天赋
		"NewbieAssistantPanelMountFrame", -- 坐骑
		"NewbieAssistantPanelBattlegroundFrame", -- 战场
		"NewbieAssistantPanelDungeonFrame", -- 地下城
		"NewbieAssistantPanelPaymentFrame",-- 充值介绍
	}

	for i,k in pairs(chileframe) do
		if _G[k] and _G[k]:IsShown() then
			_G[k]:Hide()
		end
	end
end

function NewbieAssistantPanelBottomItemButtonTemplate_OnShow(self)
	local level = self:GetParent().level
	if self.data and level == self.data.OpenLvl then
		self.CalloutGlow:Show()
	end
end