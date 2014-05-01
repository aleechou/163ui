-- Author      : s1172
-- Create Date : 2013/4/29 13:41:02

local SCROLL_MAX_VALUE = 800
BUTTONS_COLLECTION = {}

function NewbieAssistantPanelSkillFrameScrollFrame_OnMouseWheel(self, delta)
	local slider = NewbieAssistantPanelSkillFrame.ScrollFrame.Slider
	local current = slider:GetValue()
	if IsShiftKeyDown() and delta > 0 then
		slider:SetValue(0)
	elseif IsShiftKeyDown() and delta < 0 then
		slider:SetValue(SCROLL_MAX_VALUE)
	elseif delta < 0 and current < SCROLL_MAX_VALUE then
		slider:SetValue(current + 20)
	elseif delta > 0 and current > 1 then
		slider:SetValue(current - 20)
	end
end

function NewbieAssistantPanelSkillFrame_OnShow(self)
	local data = self.data
	local list = data.Detial
	local listframe = NewbieAssistantPanelSkillFrame.ScrollFrame.List
	local frame = NewbieAssistantPanelSkillFrame.ScrollFrame

	self.Title:SetText(data.TypeTitle)

	if not list or type(list)~="table" then
		local button = CreateFrame("BUTTON",nil,listframe,"NewbieAssistantPanelSkillInfoTemplate")
		button:Hide()
		button.data = data
		button:SetPoint("TOPLEFT",listframe,"TOPLEFT",20,-10)
		SCROLL_MAX_VALUE = 0
		tinsert(BUTTONS_COLLECTION, button)
		frame.Slider:Hide()
		self:SetHeight(200)
		button:Show()
	else
		local value = 0
		for i = 1, #list, 1 do
			local button = CreateFrame("BUTTON",nil,listframe,"NewbieAssistantPanelSkillInfoTemplate")
			button:Hide()
			button.data = list[i]
			if i == 1 then
				button:SetPoint("TOPLEFT",listframe,"TOPLEFT",20,-10)
			else
				button:SetPoint("TOPLEFT",BUTTONS_COLLECTION[i-1].Description,"BOTTOMLEFT",-47,-20)
			end
			value = value + button.Description:GetHeight() + 145
			tinsert(BUTTONS_COLLECTION, button)
			button:Show()
		end
		listframe:SetHeight(value)
		SCROLL_MAX_VALUE = value
		frame.Slider:Show()
		self:SetHeight(495)
	end

	
	frame:SetScrollChild(listframe)
	frame.Slider:SetOrientation("VERTICAL")
	frame.Slider:SetMinMaxValues(0, SCROLL_MAX_VALUE)
	frame.Slider:SetValue(0)
end

function NewbieAssistantPanelSkillFrame_OnHide(self)
	for i = 1, #BUTTONS_COLLECTION, 1 do
		BUTTONS_COLLECTION[i]:Hide()
	end

	BUTTONS_COLLECTION = {}
end