
local WIDGET, VERSION = 'BorderLabel', 1

local GUI = LibStub('NetEaseGUI-1.0')
local BorderLabel = GUI:NewClass(WIDGET, 'Frame', VERSION)
if not BorderLabel then
    return
end

function BorderLabel:Constructor(parent)
    if not parent then
        return
    end

    self:SetParent(parent)

    local tLeft = self:CreateTexture(nil, 'BACKGROUND')
    tLeft:SetTexture([[Interface\Glues\CharacterCreate\CharacterCreate-LabelFrame]])
    tLeft:SetTexCoord(0, 0.1953125, 0, 1)
    tLeft:SetSize(25, 64)
    tLeft:SetPoint('LEFT', -16, 0)

    local tRight = self:CreateTexture(nil, 'BACKGROUND')
    tRight:SetTexture([[Interface\Glues\CharacterCreate\CharacterCreate-LabelFrame]])
    tRight:SetTexCoord(0.8046875, 1, 0, 1)
    tRight:SetSize(25, 64)
    tRight:SetPoint('RIGHT', 16, 0)

    local tMid = self:CreateTexture(nil, 'BACKGROUND')
    tMid:SetTexture([[Interface\Glues\CharacterCreate\CharacterCreate-LabelFrame]])
    tMid:SetTexCoord(0.1953125, 0.8046875, 0, 1)
    tMid:SetPoint('TOPLEFT', tLeft, 'TOPRIGHT')
    tMid:SetPoint('BOTTOMRIGHT', tRight, 'BOTTOMLEFT')

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallLeft')
    Text:SetPoint('LEFT', 10, 0)

    self.Text = Text
end

function BorderLabel:GetText()
    return self.Text:GetText()
end

function BorderLabel:SetText(text)
    self.Text:SetText(text)
end

function BorderLabel:SetTime(time)
    self:SetText(date('%Y/%m/%d %H:%M', time))
end
