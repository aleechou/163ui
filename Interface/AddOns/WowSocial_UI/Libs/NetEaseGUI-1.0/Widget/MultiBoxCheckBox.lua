
local WIDGET, VERSION = 'MultiBoxCheckBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local MultiBoxCheckBox = GUI:NewClass(WIDGET, GUI:GetClass('ItemButton'), VERSION)
if not MultiBoxCheckBox then
    return
end

function MultiBoxCheckBox:Constructor()
    self:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
    self:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
    self:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
    self:SetDisabledCheckedTexture([[INTERFACE\BUTTONS\UI-CheckBox-Check-Disabled]])
    self:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]], 'ADD')

    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetSize(20, 20)
    self:GetNormalTexture():SetPoint('LEFT')

    self:GetCheckedTexture():ClearAllPoints()
    self:GetCheckedTexture():SetSize(20, 20)
    self:GetCheckedTexture():SetPoint('LEFT')

    self:GetPushedTexture():ClearAllPoints()
    self:GetPushedTexture():SetSize(20, 20)
    self:GetPushedTexture():SetPoint('LEFT')

    self:GetHighlightTexture():ClearAllPoints()
    self:GetHighlightTexture():SetSize(20, 20)
    self:GetHighlightTexture():SetPoint('LEFT')

    self:GetDisabledCheckedTexture():ClearAllPoints()
    self:GetDisabledCheckedTexture():SetSize(20, 20)
    self:GetDisabledCheckedTexture():SetPoint('LEFT')

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    Text:SetPoint('LEFT', 20, 0)
    self:SetFontString(Text)

    self:SetNormalFontObject('GameFontHighlightSmall')
    self:SetDisabledFontObject('GameFontDisableSmall')
end
