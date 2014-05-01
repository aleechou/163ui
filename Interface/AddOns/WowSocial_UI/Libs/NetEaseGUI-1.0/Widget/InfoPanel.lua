
local WIDGET, VERSION = 'InfoPanel', 2

local GUI = LibStub('NetEaseGUI-1.0')
local InfoPanel = GUI:NewClass(WIDGET, GUI:GetClass('ScrollFrame'), VERSION, 'Refresh', 'Owner')
if not InfoPanel then
    return
end

function InfoPanel:Constructor(parent)
    local Frame = CreateFrame('Frame', nil, self)
    Frame:SetPoint('CENTER')
    Frame:SetSize(100, 100)

    self:SetScrollChild(Frame)
    self:EnableMouseWheel(true)

    self:Hide()
    self.Frame = Frame
    self.children = {}
end

function InfoPanel:AddWidget(box)
    if #self.children == 0 then
        local anchor = self.GetScrollChild and self:GetScrollChild() or self
        box:SetPoint('TOPLEFT', anchor, 'TOPLEFT')
        box:SetPoint('TOPRIGHT', anchor, 'TOPRIGHT')
    else
        local anchor = self.children[#self.children]
        box:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, -5)
        box:SetPoint('TOPRIGHT', anchor, 'BOTTOMRIGHT', 0, -5)
    end
    tinsert(self.children, box)
end

function InfoPanel:CreateSearchBox(text)
    local box = GUI:GetClass('TitleWidget'):New(self.Frame or self)
    box:SetText(text)
    box:SetHeight(87)
    box:SetObject(GUI:GetClass('SearchBox'):New(box))

    self:AddWidget(box)

    return box
end

function InfoPanel:CreateEditBox(text, prompt)
    local box = GUI:GetClass('TitleWidget'):New(self.Frame or self)
    box:SetText(text)
    box:SetHeight(87)

    local object = GUI:GetClass('EditBox'):New(box)
    object:SetPrompt(prompt)

    box:SetObject(object)

    self:AddWidget(box)

    return box
end

function InfoPanel:CreateMultiBox(text, itemList)
    local box = GUI:GetClass('TitleWidget'):New(self.Frame or self)
    box:SetText(text)
    box:SetHeight(65)

    local object = GUI:GetClass('MultiBox'):New(box)
    object:SetItemList(itemList)
    object:Refresh()

    box:SetObject(object)

    self:AddWidget(box)

    return box
end

function InfoPanel:CreateLoading()
    local Loading = CreateFrame('Frame', nil, self, 'NetEaseLoadingTemplate')
    Loading:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 20, -5)
    Loading:SetFrameLevel(self:GetFrameLevel() + 5)

    return Loading
end

function InfoPanel:CreateDropdown(text, menuTable)
    local box = GUI:GetClass('TitleWidget'):New(self.Frame or self)
    box:SetText(text)
    box:SetHeight(65)

    local object = GUI:GetClass('Dropdown'):New(box)
    object:SetMenuTable(menuTable)

    box:SetObject(object)

    self:AddWidget(box)

    return box
end

function InfoPanel:CreateLabel(text)
    local box = GUI:GetClass('TitleWidget'):New(self.Frame or self)
    box:SetText(text)
    box:SetHeight(45)

    local object = box:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    box:SetObject(object)

    self:AddWidget(box)

    return box
end
