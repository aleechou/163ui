
local WIDGET, VERSION = 'SearchBox', 2

local GUI = LibStub('NetEaseGUI-1.0')
local SearchBox = GUI:NewClass(WIDGET, GUI:GetClass('InputBox'), VERSION)
if not SearchBox then
    return
end

function SearchBox:Constructor(parent)
    local SearchIcon = self:CreateTexture(nil, 'ARTWORK')
    SearchIcon:SetTexture([[Interface\Common\UI-Searchbox-Icon]])
    SearchIcon:SetPoint('LEFT', 5, -2)
    SearchIcon:SetSize(14, 14)
    SearchIcon:SetVertexColor(0.6, 0.6, 0.6)

    local ClearButton = GUI:GetClass('ClearButton'):New(self)
    ClearButton:SetPoint('RIGHT', -3, 0)
    ClearButton:SetScript('OnClick', function()
        self:Clear()
    end)
    ClearButton:Hide()

    self.SearchIcon = SearchIcon
    self.ClearButton = ClearButton

    self:SetPrompt(SEARCH)
    self:SetTextInsets(21, 20, 0, 0)
    self:SetFontObject('GameFontHighlightSmall')

    self:SetScript('OnEditFocusLost', self.OnEditFocusLost)
    self:SetScript('OnEditFocusGained', self.OnEditFocusGained)
    self:SetScript('OnHide', self.OnHide)

    self.Prompt:ClearAllPoints();
    self.Prompt:SetPoint('TOPLEFT', self, 'TOPLEFT', 21, 0)
    self.Prompt:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -20, 0)
end

function SearchBox:OnEditFocusLost()
    self:HighlightText(0, 0)

    if self:GetText() == '' then
        self.SearchIcon:SetVertexColor(0.6, 0.6, 0.6)
        self.ClearButton:Hide()
    end
end

function SearchBox:OnEditFocusGained()
    self:HighlightText()
    self.SearchIcon:SetVertexColor(1.0, 1.0, 1.0)
    self.ClearButton:Show()
end

function SearchBox:Clear()
    PlaySound('igMainMenuOptionCheckBoxOn')
    self:SetText('')
    self:ClearFocus()
    self:OnEditFocusLost()
end

function SearchBox:OnHide()
    self:SetText('')
end
