-- Author      : s1172
-- Create Date : 2013/6/12 13:02:30

local isTrialAcc = IsTrialAccount()

function NewbieAssistantPanelPaymentFrameButton_OnClick(self)
	local btnframe = self:GetParent()
	local contentframe = NewbieAssistantPanelPaymentFrameContent
	local buttons = {
		TrialLimitFrame = "LimitButton",
		PaidFrame = "PaidButton",
		HowFrame = "HowButton",
	}

	for i,k in pairs(buttons) do
		local button = btnframe[k]
		if button ~= self then
			button:SetChecked(false)
			contentframe[i]:Hide()
		else
			button:SetChecked(true)
			contentframe[i]:Show()
		end
	end

end

function NewbieAssistantPanelPaymentFrame_OnShow(self)
	NewbieAssistantPanelPaymentFrameMenu.LimitButton:Click()
end

function NewbieAssistantPanelPaymentTipFrame_Show()
	if isTrialAcc then
		local frame = NewbieAssistantPanelPaymentTipFrame
		ShowUIPanel(frame)
	end
end

function NewbieAssistantPanelPaymentTipFrame_OnEvent(self, event, ...)
	if event == "PLAYER_LEVEL_UP" and isTrialAcc then
		local lvl = ...
		if tonumber(lvl) == 20 then
			self:Show()
		end
	end
end

function NewbieAssistantPanelPaymentTipFrame_OnLoad(self)
	self:SetScale(.7)
	if isTrialAcc and UnitLevel("player") < 20 then
		self:RegisterEvent("PLAYER_LEVEL_UP")
	end
end