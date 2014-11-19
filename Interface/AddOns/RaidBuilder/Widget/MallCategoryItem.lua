
BuildEnv(...)

local MallCategoryItem = RaidBuilder:NewClass('MallCategoryItem', GUI:GetClass('ItemButton'))

function MallCategoryItem:Constructor(parent)
    local bg = self:CreateTexture(nil, 'BACKGROUND')
    bg:SetTexture([[Interface\Store\Store-Main]])
    bg:SetTexCoord(0.56542969, 0.73730469, 0.41992188, 0.45703125)
    bg:SetAllPoints(true)

    local Text = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    Text:SetJustifyH('LEFT')
    -- Text:SetWordWrap(true)
    -- Text:SetSize(60, 38)
    Text:SetPoint('LEFT', 48, 4)

    local hasNew = self:CreateTexture(nil, 'ARTWORK')
    hasNew:SetTexture([[Interface\Store\Store-Main]])
    hasNew:SetTexCoord(0.93457031, 0.94433594, 0.27929688, 0.29687500)
    hasNew:SetSize(10, 18)
    hasNew:SetPoint('RIGHT', -8, 2)
    hasNew:SetShown(false)

    local HighlightTexture = self:CreateTexture(nil, 'ARTWORK')
    HighlightTexture:SetTexture([[Interface\Store\Store-Main]])
    HighlightTexture:SetBlendMode('ADD')
    HighlightTexture:SetTexCoord(0.00097656, 0.16894531, 0.93847656, 0.97167969)
    HighlightTexture:SetSize(172, 34)
    HighlightTexture:SetPoint('CENTER', 0, 2)
    HighlightTexture:Hide()

    local CheckedTexture = self:CreateTexture(nil, 'ARTWORK')
    CheckedTexture:SetTexture([[Interface\Store\Store-Main]])
    CheckedTexture:SetBlendMode('ADD')
    CheckedTexture:SetTexCoord(0.73535156, 0.90332031, 0.46289063, 0.49609375)
    CheckedTexture:SetSize(172, 34)
    CheckedTexture:SetPoint('CENTER', 0, 2)
    CheckedTexture:Hide()

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetTexture([[Interface\AddOns\RaidBuilder\Media\MallIcons]])
    Icon:SetSize(32, 32)
    Icon:SetPoint('CENTER', self, 'LEFT', 15, 2)

    self:SetCheckedTexture(CheckedTexture)
    self:SetHighlightTexture(HighlightTexture, 'ADD')

    self.Text = Text
    self.hasNew = hasNew
    self.Icon = Icon
    self.HighlightTexture = HighlightTexture
    self.CheckedTexture = CheckedTexture
end

function MallCategoryItem:SetText(text)
    self.HighlightTexture:SetWidth(self:GetWidth() - 4)
    self.CheckedTexture:SetWidth(self:GetWidth() - 4)
    self.Text:SetText(text)
end

function MallCategoryItem:SetNew(enable)
    self.hasNew:SetShown(enable)
end

function MallCategoryItem:SetIcon(coord)
    self.Icon:SetTexCoord(unpack(coord))
end
