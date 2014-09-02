
local WIDGET, VERSION = 'SearchBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local SearchBox = GUI:NewClass(WIDGET, GUI:GetClass('InputBox'), VERSION)
if not SearchBox then
    return
end

local objects = {}

WorldFrame:HookScript('OnMouseDown', function()
    if next(objects) then
        for object in pairs(objects) do
            object:Clear()
        end
    end
end)

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
    self:SetFontObject('GameFontDisable')

    self:HookScript('OnEditFocusLost', self.OnEditFocusLost)
    self:HookScript('OnEditFocusGained', self.OnEditFocusGained)

    objects[self] = true
end

function SearchBox:OnEditFocusLost()
    self:HighlightText(0, 0)
    self:SetFontObject('GameFontDisable')
    self.SearchIcon:SetVertexColor(0.6, 0.6, 0.6)
    if self:GetText() == '' then
        self.ClearButton:Hide()
    end
end

function SearchBox:OnEditFocusGained()
    self:HighlightText()
    self:SetFontObject('ChatFontSmall')
    self.SearchIcon:SetVertexColor(1.0, 1.0, 1.0)
    self.ClearButton:Show()
end

function SearchBox:Clear()
    -- PlaySound('igMainMenuOptionCheckBoxOn')
    if self.clearFunc then
        self.clearFunc(self)
    end
    self:SetText('')
    if not self:HasFocus() then
        self:GetScript('OnEditFocusLost')(self)
    end
    self:ClearFocus()
end
