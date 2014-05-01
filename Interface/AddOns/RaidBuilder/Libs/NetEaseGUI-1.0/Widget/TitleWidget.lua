
local WIDGET, VERSION = 'TitleWidget', 1

local GUI = LibStub('NetEaseGUI-1.0')
local TitleWidget = GUI:NewClass(WIDGET, 'Frame', VERSION)
if not TitleWidget then
    return
end

function TitleWidget:Constructor(parent)
    if not parent then
        return
    end

    local Bg = self:CreateTexture(nil, 'BACKGROUND')
    Bg:SetAllPoints(self)
    Bg:SetTexture(0.95, 0.95, 1, 0.09)

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
    Text:SetPoint('TOPLEFT', 5, -5)

    self.Text = Text
    self:SetParent(parent)
end

function TitleWidget:SetText(text)
    self.Text:SetText(text)
end

function TitleWidget:GetText()
    return self.Text:GetText()
end

function TitleWidget:SetObject(object)
    object:SetParent(self)
    object:ClearAllPoints()
    object:SetPoint('TOPLEFT', self, 'TOPLEFT', 5, -20)
    object:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -5, 5)
    object:Show()

    self.Object = object
    return object
end

function TitleWidget:GetObject()
    return self.Object
end
