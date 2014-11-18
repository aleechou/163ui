
BuildEnv(...)

local MallItem = RaidBuilder:NewClass('MallItem', GUI:GetClass('ItemButton'))

function MallItem:Constructor(parent)
    local Background = self:CreateTexture(nil, 'BACKGROUND')
    Background:SetTexture([[Interface\Store\Store-Main]])
    Background:SetTexCoord(0.18457031, 0.32714844, 0.64550781, 0.84960938)
    Background:SetSize(146, 209)
    Background:SetAllPoints(true)

    local Shadows = self:CreateTexture(nil, 'BACKGROUND', nil, 2)
    Shadows:SetTexture([[Interface\Store\Store-Main]])
    Shadows:SetTexCoord(0.84375000, 0.97851563, 0.29980469, 0.37011719)
    Shadows:SetSize(138, 72)
    Shadows:SetPoint('CENTER')

    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetSize(63, 63)
    Icon:SetPoint('TOP', 0, -36)
    local IconBorder = self:CreateTexture(nil, 'ARTWORK', nil, 2)
    IconBorder:SetTexture([[Interface\Store\Store-Main]])
    IconBorder:SetTexCoord(0.84375000, 0.92187500, 0.37207031, 0.45117188)
    IconBorder:SetSize(80, 81)
    IconBorder:SetPoint('TOP', 0, -33)

    local Price = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalMed3')
    Price:SetPoint('BOTTOM', 0, 32)

    local Name = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalMed3')
    Name:SetSize(120, 40)
    Name:SetPoint('BOTTOM', 0, 42)
    Name:SetTextColor(1, 1, 1, 1)

    local CheckedTexture = self:CreateTexture(nil, 'ARTWORK', nil, 1)
    CheckedTexture:SetTexture([[Interface\Store\Store-Main]])
    CheckedTexture:SetTexCoord(0.37011719, 0.50683594, 0.74218750, 0.94042969)
    CheckedTexture:SetBlendMode('ADD')
    CheckedTexture:SetSize(140, 203)
    CheckedTexture:SetPoint('CENTER')
    CheckedTexture:Hide()

    local HighlightTexture = self:CreateTexture(nil, 'ARTWORK', nil, 2)
    HighlightTexture:SetTexture([[Interface\Store\Store-Main]])
    HighlightTexture:SetTexCoord(0.37011719, 0.50683594, 0.54199219, 0.74023438)
    HighlightTexture:SetBlendMode('ADD')
    HighlightTexture:SetSize(140, 203)
    HighlightTexture:SetPoint('CENTER')
    HighlightTexture:Hide()

    local Model = CreateFrame('PlayerModel', nil, self)
    Model:SetSize(126, 124)
    Model:SetPoint('BOTTOM', 0, 80)

    local Magnifier = CreateFrame('Button', nil, self)
    Magnifier:SetSize(31, 35)
    Magnifier:SetPoint('TOPLEFT', 8, -8)
    Magnifier:SetNormalTexture([[Interface\Store\Store-Main]])
    Magnifier:GetNormalTexture():SetSize(31, 35)
    Magnifier:GetNormalTexture():SetTexCoord(0.32910156, 0.35937500, 0.72363281, 0.75781250)
    Magnifier:SetHighlightTexture([[Interface\Store\Store-Main]], 'ADD')
    Magnifier:GetHighlightTexture():SetSize(31, 35)
    Magnifier:GetHighlightTexture():SetTexCoord(0.32910156, 0.35937500, 0.72363281, 0.75781250)
    Magnifier:Hide()
    Magnifier:SetScript('OnEnter', function()
        self:SetMagnifier(true)
    end)
    Magnifier:SetScript('OnLeave', function()
        self:SetMagnifier(false)
    end)
    Magnifier:SetScript('OnClick', function()
        if not self.data.model then
            return
        end
        local frame = ModelPreviewFrame
        ModelPreviewFrame_ShowModel(self.data.model, true)
        frame.Display.Name:SetText(self.data.text)
    end)

    self:RegisterEvent('GET_ITEM_INFO_RECEIVED')
    self:SetScript('OnEvent', function()
        self:SetIcon(self.data.itemId)
    end)

    self:SetCheckedTexture(CheckedTexture)
    self:SetHighlightTexture(HighlightTexture)

    self.Price = Price
    self.Icon = Icon
    self.Shadows = Shadows
    self.Model = Model
    self.Magnifier = Magnifier
    self.Name = Name
    self.IconBorder = IconBorder
end

function MallItem:SetMagnifier(enable)
    if self:IsMagnifierShown() then
        self.Magnifier:SetShown(enable)
    else
        self.Magnifier:SetShown(false)
    end
end

function MallItem:SetPrice(text)
    self.Price:SetText(text and text .. '*' or nil)
end

function MallItem:SetText(text)
    self.Name:SetText(text)
end

function MallItem:SetModel(id)
    self.Model:SetShown(id)
    self.Shadows:SetShown(id)

    if not id then
        return
    end

    self.Model:SetDisplayInfo(id)
    self.Model:SetDoBlend(false)
    self.Model:SetAnimation(0, -1)
    self.Model:SetRotation(0.61)
    self.Model:SetPosition(0, 0, 0)
    self.Model:SetPortraitZoom(0)
end

function MallItem:IsMagnifierShown()
    return self.data.model
end

function MallItem:SetIcon(id)
    local enable = not self.data.model
    self.Icon:SetShown(enable)
    self.IconBorder:SetShown(enable)

    if not id then
        return
    end

    local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(id)

    if not texture then
        return
    end

    if enable then
        SetPortraitToTexture(self.Icon, texture)
    end

    self.data.link = link

    if not self.data.text then
        self.data.text = name
        self:SetText(name)
    end
end

function MallItem:SetData(data)
    self.data = data
    self:SetText(data.text)
    self:SetModel(data.model)
    self:SetPrice(data.price)
    self:SetIcon(data.itemId)
end
