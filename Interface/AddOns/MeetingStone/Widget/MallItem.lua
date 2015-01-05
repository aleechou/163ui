
BuildEnv(...)

local MallItem = Addon:NewClass('MallItem', GUI:GetClass('ItemButton'))

function MallItem:Constructor(parent)
    local Background = self:CreateTexture(nil, 'BACKGROUND') do
        Background:SetTexture([[Interface\Store\Store-Main]])
        Background:SetTexCoord(0.18457031, 0.32714844, 0.64550781, 0.84960938)
        Background:SetSize(146, 209)
        Background:SetAllPoints(true)
    end

    local Shadows = self:CreateTexture(nil, 'BACKGROUND', nil, 2) do
        Shadows:SetTexture([[Interface\Store\Store-Main]])
        Shadows:SetTexCoord(0.84375000, 0.97851563, 0.29980469, 0.37011719)
        Shadows:SetSize(138, 72)
        Shadows:SetPoint('CENTER')
    end

    local Icon = self:CreateTexture(nil, 'ARTWORK') do
        Icon:SetSize(63, 63)
        Icon:SetPoint('TOP', 0, -36)
        local IconBorder = self:CreateTexture(nil, 'ARTWORK', nil, 2)
        IconBorder:SetTexture([[Interface\Store\Store-Main]])
        IconBorder:SetTexCoord(0.84375000, 0.92187500, 0.37207031, 0.45117188)
        IconBorder:SetSize(80, 81)
        IconBorder:SetPoint('CENTER', Icon, 0, -3)

        local org_SetShown = Icon.SetShown
        Icon.SetShown = function(_, enable)
            org_SetShown(Icon, enable)
            IconBorder:SetShown(enable)
        end
    end

    local Price = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall2', 3) do
        Price:SetPoint('BOTTOM', 0, 30)
    end

    local SalePrice = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalMed3', 3) do
        SalePrice:SetPoint('LEFT', Price, 'RIGHT', 10, 0)
        SalePrice:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
        SalePrice:Hide()
    end

    local Strikethrough = self:CreateTexture(nil, 'OVERLAY') do
        Strikethrough:SetTexture([[Interface\Store\Store-Main]])
        Strikethrough:SetTexCoord(0.93457031, 0.96582031, 0.14257813, 0.15234375)
        Strikethrough:SetSize(32, 10)
        Strikethrough:SetPoint('TOPLEFT', Price, -2, 0)
        Strikethrough:SetPoint('BOTTOMRIGHT', Price, 2, 0)
        Strikethrough:Hide()
    end

    local Discount = CreateFrame('Frame', nil, self) do
        Discount:SetPoint('TOPRIGHT', 1, -2)
        Discount:SetSize(32,32)
        Discount:Hide()

        local DiscountRight = Discount:CreateTexture(nil, 'ARTWORK', nil, 3)
        DiscountRight:SetTexture([[Interface\Store\Store-Main]])
        DiscountRight:SetTexCoord(0.98828125, 0.99609375, 0.19921875, 0.23046875)
        DiscountRight:SetSize(8, 32)
        DiscountRight:SetPoint('TOPRIGHT', 1, -2)

        local DiscountLeft = Discount:CreateTexture(nil, 'ARTWORK', nil, 3)
        DiscountLeft:SetTexture([[Interface\Store\Store-Main]])
        DiscountLeft:SetTexCoord(0.98828125, 0.99609375, 0.10546875, 0.13671875)
        DiscountLeft:SetSize(8, 32)
        DiscountLeft:SetPoint('RIGHT', DiscountRight, 'LEFT', -40, 0)

        local DiscountMiddle = Discount:CreateTexture(nil, 'ARTWORK', nil, 3)
        DiscountMiddle:SetTexture([[Interface\Store\Store-Main]])
        DiscountMiddle:SetTexCoord(0.32910156, 0.36230469, 0.69042969, 0.72167969)
        DiscountMiddle:SetSize(34, 32)
        DiscountMiddle:SetPoint('RIGHT', DiscountRight, 'LEFT', 0, 0)
        DiscountMiddle:SetPoint('LEFT', DiscountLeft, 'RIGHT', 0, 0)

        local Text = Discount:CreateFontString(nil, 'OVERLAY', 'GameFontNormalMed2')
        Text:SetPoint('CENTER', DiscountMiddle, 1, 2)
        Text:SetSize(50, 30)
        Text:SetTextColor(1, 1, 1)

        Discount.SetText = function(_, text)
            Text:SetText(text)
        end
    end

    local Name = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalMed3') do
        Name:SetSize(120, 40)
        Name:SetPoint('BOTTOM', 0, 42)
        Name:SetTextColor(1, 1, 1, 1)
    end

    local CheckedTexture = self:CreateTexture(nil, 'ARTWORK', nil, 1) do
        CheckedTexture:SetTexture([[Interface\Store\Store-Main]])
        CheckedTexture:SetTexCoord(0.37011719, 0.50683594, 0.74218750, 0.94042969)
        CheckedTexture:SetBlendMode('ADD')
        CheckedTexture:SetSize(140, 203)
        CheckedTexture:SetPoint('CENTER')
        CheckedTexture:Hide()
    end

    local HighlightTexture = self:CreateTexture(nil, 'ARTWORK', nil, 2) do
        HighlightTexture:SetTexture([[Interface\Store\Store-Main]])
        HighlightTexture:SetTexCoord(0.37011719, 0.50683594, 0.54199219, 0.74023438)
        HighlightTexture:SetBlendMode('ADD')
        HighlightTexture:SetSize(140, 203)
        HighlightTexture:SetPoint('CENTER')
        HighlightTexture:Hide()
    end

    local Model = CreateFrame('PlayerModel', nil, self) do
        Model:SetSize(126, 124)
        Model:SetPoint('BOTTOM', 0, 80)
    end

    local Magnifier = CreateFrame('Button', nil, self) do
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
    end

    self:RegisterEvent('GET_ITEM_INFO_RECEIVED', function()
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
    self.Strikethrough = Strikethrough
    self.SalePrice = SalePrice
    self.Discount = Discount
end

function MallItem:SetMagnifier(enable)
    if self:IsMagnifierShown() then
        self.Magnifier:SetShown(enable)
    else
        self.Magnifier:SetShown(false)
    end
end

function MallItem:SetPrice(price, discount)
    self.Price:ClearAllPoints()

    if discount then
        self.Price:SetPoint('BOTTOMRIGHT', self, 'BOTTOM', -2, 30)

        self.SalePrice:ClearAllPoints()
        self.SalePrice:SetPoint('BOTTOMLEFT', self, 'BOTTOM', 2, 30)
        self.SalePrice:SetFormattedText('%d*', discount)

        self.Discount:SetText(format('-%d%%', (1-discount/price)*100))
    else
        self.Price:SetPoint('BOTTOM', self, 0, 30)
    end

    self.Discount:SetShown(discount)
    self.SalePrice:SetShown(discount)
    self.Strikethrough:SetShown(discount)
    self.Price:SetText(format('%d*', price or ''))
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
    self:SetPrice(data.price, data.discount)
    self:SetIcon(data.itemId)
end
