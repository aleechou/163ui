
local WIDGET, VERSION = 'CheckBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local CheckBox = GUI:NewClass(WIDGET, 'CheckButton', VERSION)
if not CheckBox then
    return
end

function CheckBox:Constructor(parent)
    self:SetParent(parent)

    self:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
    self:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
    self:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
    self:SetDisabledCheckedTexture([[INTERFACE\BUTTONS\UI-CheckBox-Check-Disabled]])
    self:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]], 'ADD')

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT', self, 'RIGHT', 2, 0)
    self:SetFontString(Text)

    self:SetNormalFontObject('GameFontNormalSmall')
    self:SetHighlightFontObject('GameFontHighlightSmall')
    self:SetDisabledFontObject('GameFontDisableSmall')
    
    self.Text = Text
end

function CheckBox:SetText(text)
    self.Text:SetText(text)
    self:SetHitRectInsets(0, - self.Text:GetWidth(), 0, 0)
end
