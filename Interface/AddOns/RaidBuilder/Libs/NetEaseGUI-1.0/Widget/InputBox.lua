
local WIDGET, VERSION = 'InputBox', 2

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
    self:SetScript('OnEnterPressed', EditBox_ClearFocus)
    self:SetScript('OnEditFocusLost', EditBox_ClearHighlight)
    self:SetScript('OnEditFocusGained', EditBox_HighlightText)
    self:SetScript('OnTextChanged', self.OnTextChanged)

    self:SetParent(parent)
    self:SetFontObject('GameFontHighlightSmall')
    self:SetAutoFocus(nil)
    self:SetTextInsets(8, 8, 0, 0)

    local Prompt = self:CreateFontString(nil, 'ARTWORK', 'GameFontDisableSmall')
    Prompt:SetJustifyH('LEFT')
    Prompt:SetJustifyV('TOP')
    Prompt:SetPoint('LEFT', 8, 0)

    self.Prompt = Prompt
end

function InputBox:SetPrompt(prompt)
    self.Prompt:SetText(prompt)
end

function InputBox:GetPrompt()
    return self.Prompt:GetText()
end

function InputBox:OnTextChanged(...)
    self.Prompt:SetShown(self:GetText() == '')
    self:Fire('OnTextChanged', ...)
end

local _MatchChars = {
    ['('] = '%(',
    [')'] = '%)',
    ['.'] = '%.',
    ['%'] = '%%',
    ['+'] = '%+',
    ['-'] = '%-',
    ['*'] = '%*',
    ['?'] = '%?',
    ['['] = '%[',
    [']'] = '%]',
    ['^'] = '%^',
    ['$'] = '%$',
}

function InputBox:GetMatchText()
    return (self:GetText():gsub('[().%+-*?^$%%%[%]]', _MatchChars))
end
