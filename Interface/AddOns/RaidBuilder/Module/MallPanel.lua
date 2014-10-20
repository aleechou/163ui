
BuildEnv(...)

MallPanel = RaidBuilder:NewModule(GUI:GetClass('InTabPanel'):New(MainPanel), 'MallPanel', 'AceTimer-3.0')

function MallPanel:OnInitialize()
    GUI:Embed(self, 'Owner')
    self.TabFrame:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 60, 0)

    MainPanel:RegisterPanel(L['兑换平台'], self, 0, 70)

    local Blocker = CreateFrame('Frame', nil, self)
    Blocker:SetAllPoints(true)
    Blocker:SetFrameLevel(50)
    Blocker:EnableMouse(true)
    Blocker:EnableMouseWheel(true)
    Blocker:SetScript('OnMouseWheel', function() end)
    Blocker:Hide()

    local bg = Blocker:CreateTexture(nil, 'OVERLAY')
    bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
    bg:SetAllPoints(Blocker)

    local BlockerSummary = GUI:GetClass('SummaryHtml'):New(Blocker)
    BlockerSummary:SetSize(600, 200)
    BlockerSummary:SetPoint('CENTER')
    Blocker.Html = BlockerSummary

    local Loading = Blocker:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    Loading:SetPoint('TOPRIGHT')

    self.timeout = 120
    self.Loading = Loading
    self.Blocker = Blocker
end

function MallPanel:SetBlocker(enable, text, callback)
    if enable then
        self.Blocker.Html:SetText(text)
        self.Loading:SetText(self.timeout)

        if type(callback) == 'function' then
            if self.timeoutId then
                self:CancelTimer(self.timeoutId)
            end

            if self.loadingId then
                self:CancelTimer(self.loadingId)
            end

            self.timeoutId = self:ScheduleTimer(callback, self.timeout)
            self.loadingId = self:ScheduleRepeatingTimer('UpdateLoading', 1, true)
        else
            self:UpdateLoading(false)
        end

        self.Blocker:Show()
    else
        self:CancelTimer(self.timeoutId)
        self:CancelTimer(self.loadingId)
        self.timeoutId = nil
        self.loadingId = nil
        self.Loading.t = nil
        self.Blocker:Hide()
    end
end

function MallPanel:UpdateLoading(enable)
    local Loading = self.Loading
    if enable then
        if Loading.t == 0 then
            Loading.t = self.timeout
            self:CancelTimer(self.loadingId)
            self.loadingId = nil
        else
            Loading.t = not Loading.t and self.timeout or Loading.t
            Loading.t = Loading.t - 1
        end
        Loading:SetText(Loading.t)
        Loading:Show()
    else
        Loading:Hide()
    end
end

local MallItemsPanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MallPanel), 'MallItemsPanel', 'AceEvent-3.0', 'AceTimer-3.0')

function MallItemsPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MallPanel:RegisterPanel(L['兑换列表'], self, 8)

    local CategoryWidget = GUI:GetClass('TitleWidget'):New(self)
    CategoryWidget:SetPoint('TOPLEFT')
    CategoryWidget:SetPoint('BOTTOMLEFT')
    CategoryWidget:SetWidth(186)
    
    local CategoryBackground = CategoryWidget:CreateTexture(nil, 'BACKGROUND')
    CategoryBackground:SetTexture([[Interface\Store\Store-Main]])
    CategoryBackground:SetAllPoints(true)
    CategoryBackground:SetTexCoord(0.00097656, 0.18261719, 0.5898437525, 0.93652344)

    local CategoryList = GUI:GetClass('GridView'):New(CategoryWidget)
    CategoryList:SetPoint('TOPLEFT', 5, -20)
    CategoryList:SetPoint('BOTTOMLEFT', -5, 20)
    CategoryList:SetWidth(176)
    CategoryList:SetItemClass(RaidBuilder:GetClass('MallCategoryItem'))
    CategoryList:SetItemHeight(38)
    CategoryList:SetItemSpacing(2)
    CategoryList:SetSelectMode('RADIO')
    CategoryList:SetItemHighlightWithoutChecked(true)
    CategoryList:SetDescription(L['|cffffffff*战网积分价格|r'])
    CategoryList:SetCallback('OnItemFormatted', function(CategoryList, button, data)
        button:SetText(data.text)
        button:SetIcon(data.coord)
        button:SetNew(data.new)
    end)
    CategoryList:SetCallback('OnSelectChanged', function(CategoryList, index, data)
        self:UpdateWindow()
        self.ItemList:SetItemList(data.item)
        self.ItemList:Refresh()
    end)

    local ItemWidget = GUI:GetClass('TitleWidget'):New(self)
    ItemWidget:SetPoint('TOPLEFT', CategoryWidget, 'TOPRIGHT', 5, 0)
    ItemWidget:SetPoint('BOTTOMRIGHT', 0, 100)
    
    local ItemList = GUI:GetClass('GridView'):New(ItemWidget)
    ItemList:SetPoint('TOPLEFT', 5, -15)
    ItemList:SetSize(1, 1)
    ItemList:SetItemClass(RaidBuilder:GetClass('MallItem'))
    ItemList:SetItemWidth(146)
    ItemList:SetItemHeight(209)
    ItemList:SetColumnCount(4)
    ItemList:SetRowCount(1)
    ItemList:SetItemSpacing(2)
    ItemList:SetAutoSize(true)
    ItemList:SetSelectMode('RADIO')
    ItemList:SetItemHighlightWithoutChecked(true)
    ItemList:SetCallback('OnItemFormatted', function(ItemList, button, data)
        button:SetData(data)
    end)
    ItemList:SetCallback('OnItemEnter', function(ItemList, button, data)
        button:SetMagnifier(true)
        self:OpenTooltip(button, data)
    end)
    ItemList:SetCallback('OnItemLeave', function(ItemList, button)
        button:SetMagnifier(false)
        GameTooltip:Hide()
    end)
    ItemList:SetCallback('OnSelectChanged', function(ItemList, index, data)
        self:UpdateWindow()
    end)

    local SummaryWidget = GUI:GetClass('TitleWidget'):New(self)
    SummaryWidget:SetPoint('TOPLEFT', ItemWidget, 'BOTTOMLEFT', 0, -5)
    SummaryWidget:SetPoint('BOTTOMRIGHT')
    SummaryWidget:SetText(L['兑换说明'])

    local MallSummary = GUI:GetClass('SummaryHtml'):New(SummaryWidget)
    MallSummary:SetPoint('CENTER', 10, -10)
    MallSummary:SetSize(600, 70)
    MallSummary:SetText(L.MallSummary)

    local QueryPointButton = Button:New(self)
    QueryPointButton:SetIcon([[INTERFACE\ICONS\INV_MISC_NOTE_02]])
    QueryPointButton:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -130, 10)
    QueryPointButton:SetText(L['查询我的积分'])
    QueryPointButton:SetTooltip(L['查看您当前账号的可用积分'], L['查询间隔120秒'])
    QueryPointButton:SetScript('OnClick', function()
        self:QueryPoint()
    end)

    local PurchaseButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    PurchaseButton:SetPoint('BOTTOM', self:GetOwner():GetOwner(), 'BOTTOM', 0, 4)
    PurchaseButton:SetSize(120, 22)
    PurchaseButton:SetText(L['立即兑换'])
    PurchaseButton:Disable()
    PurchaseButton:SetScript('OnClick', function()
        self:Purchase()
    end)

    local PurchaseButtonFlashFrame = CreateFrame('Frame', nil, PurchaseButton)
    PurchaseButtonFlashFrame:SetAllPoints(true)
    PurchaseButtonFlashFrame:SetAlpha(0)
    local PurchaseButtonFlash = PurchaseButtonFlashFrame:CreateTexture(nil, 'OVERLAY')
    PurchaseButtonFlash:SetTexture([[Interface\Buttons\UI-Panel-Button-Glow]])
    PurchaseButtonFlash:SetBlendMode('ADD')
    PurchaseButtonFlash:SetTexCoord(0, 0.75, 0, 0.609375)
    PurchaseButtonFlash:SetPoint('CENTER')
    PurchaseButtonFlash:SetSize(141, 30)

    local PurchaseButtonFlashAnimGroup = PurchaseButtonFlashFrame:CreateAnimationGroup()
    local anim = PurchaseButtonFlashAnimGroup:CreateAnimation('Alpha')
    anim:SetChange(1.0)
    anim:SetDuration(0.5)
    anim:SetOrder(1)
    local anim = PurchaseButtonFlashAnimGroup:CreateAnimation('Alpha')
    anim:SetChange(-1.0)
    anim:SetDuration(0.5)
    anim:SetOrder(2)

    PurchaseButton:HookScript('OnEnable', function()
        PurchaseButtonFlashAnimGroup:Play()
    end)

    PurchaseButton:HookScript('OnDisable', function()
        PurchaseButtonFlashAnimGroup:Stop()
    end)

    local HowToGetPoint = Button:New(self)
    HowToGetPoint:SetPoint('RIGHT', QueryPointButton, 'RIGHT', -150, 0)
    HowToGetPoint:SetText(L['如何获取积分?'])
    HowToGetPoint:SetIcon([[INTERFACE\ICONS\INV_MISC_NOTE_01]])
    HowToGetPoint:SetScript('OnClick', function()
        GUI:CallUrlDialog('https://www.battlenet.com.cn/account/management/ebalance-purchase.html',
            L.HowToGetPoints,
            true)
    end)

    self.ItemList = ItemList
    self.PurchaseButton = PurchaseButton
    self.QueryPointButton = QueryPointButton
    self.CategoryList = CategoryList

    self:RegisterMessage('RAIDBUILDER_MALLQUERY_RESULT', 'QueryResult')
    self:RegisterMessage('RAIDBUILDER_MALLPURCHASE_RESULT', 'PurchaseResult')
    self:RegisterMessage('RAIDBUILDER_MALL_PRODUCT_LIST_UPDATED', 'MallDataUpdated')

    MallPanel:SetBlocker(true, L.GoodsLoadingSummary)
end

function MallItemsPanel:UpdateWindow()
    self.PurchaseButton:SetEnabled(self:GetItem())
end

function MallItemsPanel:UnlockQueryButton()
    self.QueryPointButton:Enable()
    self.QueryPointButton:SetText(L['查询我的积分'])
end

function MallItemsPanel:QueryPoint()
    self.QueryPointButton:Disable()
    self.QueryPointButton:SetText(L['查询中，请稍后 ...'])
    self:ScheduleTimer('UnlockQueryButton', 120)
    Logic:MallQueryPoint()
    self.queryTimeout = self:ScheduleTimer('QueryResult', 120, nil, -1)
end

function MallItemsPanel:QueryResult(event, result)
    self.QueryPointButton:SetText(L['查询我的积分'])
    local text = result == -1 and L['积分查询失败：请稍后再试。'] or format(L['您当前可用积分为：%d'], result)
    GUI:CallWarningDialog(text)
    
    System:Logf(L['兑换平台%s'], text)

    if self.queryTimeout then
        self:CancelTimer(self.queryTimeout)
        self.queryTimeout = nil
    end
end

function MallItemsPanel:OpenTooltip(frame, data)
    if data.tip then
        GameTooltip:SetOwner(frame, 'ANCHOR_RIGHT')
        for i = 1, #data.tip do
            if i == 1 then
                GameTooltip:SetText(data.tip[i], 1, 1, 1)
            elseif i == 2 then
                GameTooltip:AddLine(data.tip[i], 1, 1, 1)
            else
                GameTooltip:AddLine(data.tip[i])
            end
        end
        GameTooltip:Show()
    elseif data.link then
        GameTooltip:SetOwner(frame, 'ANCHOR_RIGHT')
        GameTooltip:SetHyperlink(data.link)
        GameTooltip:Show()
    end
end

function MallItemsPanel:GetItem()
    return self.ItemList:GetSelectedItem()
end

function MallItemsPanel:Purchase()
    local item = self:GetItem()
    if not item then
        return
    end

    GUI:CallMessageDialog(format(L['确认消耗 |cff00ff00%d|r 积分购买 |cff00ff00%s|r 吗？'], item.price, item.text), function(result)
        if result then
            self.PurchaseButton:Disable()
            self:SetBlocker(true)
            Logic:MallPurchase(item.id)
        end
    end)
end

function MallItemsPanel:SetBlocker(enable)
    if enable then
        local item = self:GetItem() or {}
        MallPanel:SetBlocker(true, format(L.MallPurchaseSummary, item.text, item.price),
            function()
                MallItemsPanel:PurchaseResult(nil, L['购买失败：操作超时，请稍后再试。'])
            end)
    else
        MallPanel:SetBlocker(false)
    end
end

function MallItemsPanel:PurchaseResult(event, result)
    self:SetBlocker(false)

    System:Error(result)

    local item = self:GetItem()
    if item then
        System:Logf(L['兑换平台购买%s，%s'], item.text, result)
    end
end

function MallItemsPanel:MallDataUpdated(event, list, isNew)
    self.CategoryList:SetItemList(list)
    self.CategoryList:SetSelected(1)
    self:SetBlocker(false)
    
    if isNew then
        System:Log(L['兑换平台商品列表已更新。'])
    end
end
