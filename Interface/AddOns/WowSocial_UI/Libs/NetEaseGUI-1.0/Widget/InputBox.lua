
local WIDGET, VERSION = 'InputBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local InputBox = GUI:NewClass(WIDGET, 'EditBox', VERSION)
if not InputBox then
    return
end

function InputBox:Constructor(parent)
    local tLeft = self:CreateTexture(nil, 'BACKGROUND')
    tLeft:SetTexture([[Interface\Common\Common-Input-Border]])
    tLeft:SetTexCoord(0, 0.0625, 0, 0.625)
    tLeft:SetSize(8, 20)
    tLeft:SetPoint('LEFT')

    local tRight = self:CreateTexture(nil, 'BACKGROUND')
    tRight:SetTexture([[Interface\Common\Common-Input-Border]])
    tRight:SetTexCoord(0.9375, 1.0, 0, 0.625)
    tRight:SetSize(8, 20)
    tRight:SetPoint('RIGHT')

    local tMid = self:CreateTexture(nil, 'BACKGROUND')
    tMid:SetTexture([[Interface\Common\Common-Input-Border]])
    tMid:SetTexCoord(0.0625, 0.9375, 0, 0.625)
    tMid:SetPoint('TOPLEFT', tLeft, 'TOPRIGHT')
    tMid:SetPoint('BOTTOMRIGHT', tRight, 'BOTTOMLEFT')

    self:SetScript('OnEscapePressed', EditBox_ClearFocus)
    self:SetScript('OnEditFocusLost', EditBox_ClearHighlight)
    self:SetScript('OnEditFocusGained', EditBox_HighlightText)

    self:SetParent(parent)
    self:SetFontObject('GameFontDisable')
    self:SetAutoFocus(nil)
    self:SetTextInsets(8, 8, 0, 0)

    self:SetScript('OnEditFocusLost', self.OnEditFocusLost)
    self:SetScript('OnEditFocusGained', self.OnEditFocusGained)
    self:SetScript('OnShow', self.OnEditFocusLost)
end

local orig_GetText = InputBox.GetText
local orig_SetText = InputBox.SetText

function InputBox:OnEditFocusLost()
    self:HighlightText(0, 0)
    if self:GetText() == '' then
        orig_SetText(self, self.prompt)
        self:SetFontObject('GameFontDisable')
    end
end

function InputBox:OnEditFocusGained()
    self:HighlightText()
    self:SetFontObject('ChatFontSmall')
    if orig_GetText(self) == self.prompt then
        orig_SetText(self, '')
    end
end

function InputBox:SetPrompt(prompt)
    self.prompt = prompt
    self:SetText(prompt)
end

function InputBox:GetText()
    local text = orig_GetText(self)
    return text == self.prompt and '' or text
end

function InputBox:SetText(text)
    if not text or text == '' then
        orig_SetText(self, self.prompt or '')
    else
        orig_SetText(self, text)
    end
end
