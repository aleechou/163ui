-- Author      : s1172
-- Create Date : 2013/5/1 15:40:00


function NewbieAssistantPanelEquipFrame_OnShow(self)
	local lvl = NewbieAssistantPannelFrame.level
	local data = NewbieAssitantPanelItemData[lvl]
	local map = GetMapInfo()
	local index = 1

	for i, k in ipairs(data) do
		if index > 8 then return end
		local icon = self["Icon"..index]
		if k.Map == map then
			icon.data = k
			icon.icon:SetTexture(k.Texture)
			icon.link = k.Link
			icon:Show()
			if self.data and self.data.Id == k.Id then
				NewbieAssistantPanelEquipItemIconTemplate_OnClick(icon)
			end
			index = index + 1
		end
	end

	for i = index, 8 do
		self["Icon"..i]:Hide()
	end
end

function NewbieAssistantPanelEquipFrame_OnLoad(self)
	self:SetScale(.8)
end

function NewbieAssistantPanelEquipFrame_ShowInfo(data)
	local frame = NewbieAssistantPanelEquipFrame
	--frame.EquipName:SetText(data.Title)
	--frame.EquipAttr:SetText(data.Attr)
	frame.GetEquip:SetText(data.Get)
end

function NewbieAssistantPanelEquipItemIconTemplate_OnClick(self)
	local check = NewbieAssistantPanelEquipFrame.selectionCheck
	check:ClearAllPoints()
	check:SetFrameLevel(self:GetFrameLevel()+10)
	check:SetAllPoints(self)

	
	if not ItemRefTooltip:IsShown() then
		ShowUIPanel(ItemRefTooltip)
	end
	ItemRefTooltip:SetOwner(self:GetParent(), "ANCHOR_LEFT")
	ItemRefTooltip:SetHyperlink(self.link)
	ItemRefTooltip:ClearAllPoints()
	ItemRefTooltip:SetPoint("TOP",self:GetParent(),"CENTER",0,50)
	GameTooltip:Hide()

	NewbieAssistantPanelEquipFrame_ShowInfo(self.data)
end