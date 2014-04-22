-- Author      : s1172
-- Create Date : 2013/5/6 15:56:12

-- locale
local L = TutorialApi.Localization

function NewbieAssistantToturialMouseFrame_OnMouseDown(self, button)
	if self.buttons == 1 and button == "RightButton" then
		self:Hide()
		self.buttons = 2
		self["LeftButton"]:SetTexCoord(0.009765625,0.140625,0.43359375,0.615234375)
		self["RightButton"]:SetTexCoord(0.162109375,0.29296875,0.43359375,0.615234375)
	end

	if self.buttons == 2 and button == "LeftButton" then
		self["LeftButton"]:SetTexCoord(0.162109375,0.29296875,0.43359375,0.615234375)
		self["RightButton"]:SetTexCoord(0.009765625,0.140625,0.630859375,0.81640625)
		self.buttons = 1
	end
end

function NewbieAssistantToturialMouseFrame_OnShow(self)
	self:SetSize(GetScreenWidth(),GetScreenHeight())
	self.buttons = 2

	self.LeftButtonText:SetText(L["Left-button useable."])
	self.RightButtonText:SetText(L["Right-button useable."])

	self.LeftButton:Show()
	self.LeftButtonText:Show()

	self.RightButton:Show()
	self.RightButtonText:Show()

	TutorialTinyMsgFrame_Show("BOTTOMLEFT","LEFT",NewbieAssistantToturialMouseFrame,"CENTER",100,100,L["follow the picture."])
end

function NewbieAssistantToturialMouseWheelFrame_OnMouseWheel(self, delta)
	local button = delta > 0 and "Up" or "Down"

	if self.buttons == 1 and button == "Down" then
		self:Hide()
	end

	if self.buttons == 2 and button == "Up" then
		self["UpButtonText"]:Hide()
		self["UpArrow"]:Hide()
		self["DownButtonText"]:Show()
		self["DownArrow"]:Show()
		self.buttons = 1
	end

	if delta > 0 then
		CameraZoomIn(delta)
	else
		CameraZoomOut(abs(delta))
	end

	
end

function NewbieAssistantToturialMouseWheelFrame_OnShow(self)
	self:SetSize(GetScreenWidth(),GetScreenHeight())
	self.buttons = 2
	self.UpButtonText:SetText(L["Up-Wheel useable."])
	self.DownButtonText:SetText(L["Down-Wheel useable."])

	self.UpButtonText:Show()
	self.UpArrow:Show()
	self.DownButtonText:Hide()
	self.DownArrow:Hide()

	TutorialTinyMsgFrame_Show("BOTTOMLEFT","LEFT",NewbieAssistantToturialMouseWheelFrame,"CENTER",100,100,L["follow the picture."])
end

function NewbieAssistantToturialMouseFrame_OnHide(self)
	TutorialTinyMsgFrame_Hide(-1)
	NewbieAssistantToturialMouseWheelFrame:Show()
end

function NewbieAssistantToturialMouseWheelFrame_OnHide(self)
	TutorialTinyMsgFrame_Hide(-1)
	ToolTip_Logic.MouseShow = true
	PanelKeyboardFrame:Show()
	--ToolTip_Logic:TutorialStart()
end