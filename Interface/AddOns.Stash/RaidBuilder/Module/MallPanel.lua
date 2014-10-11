
BuildEnv(...)

MallPanel = RaidBuilder:NewModule(GUI:GetClass('InTabPanel'):New(MainPanel), 'MallPanel')

function MallPanel:OnInitialize()
    GUI:Embed(self, 'Owner')
    self.TabFrame:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 60, 0)

    MainPanel:RegisterPanel(L['兑换平台'], self, 0, 70)
end

local MallItemsPanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MallPanel), 'MallItemsPanel', 'AceEvent-3.0', 'AceTimer-3.0')

function MallItemsPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MallPanel:RegisterPanel(L['兑换列表'], self, 8)

    local CategoryWidget = GUI:GetClass('TitleWidget'):New(self)
    CategoryWidget:SetPoint('TOPLEFT')
    CategoryWidget:SetPoint('BOTTOMLEFT')
    CategoryWidget:SetWidth(186)

    local CategoryList = GUI:GetClass('GridView'):New(CategoryWidget)
    CategoryList:SetPoint('TOPLEFT', 5, -20)
    CategoryList:SetPoint('BOTTOMLEFT', -5, 5)
    CategoryList:SetWidth(176)
    CategoryList:SetItemClass(RaidBuilder:GetClass('MallCategoryItem'))
    CategoryList:SetItemHeight(38)
    CategoryList:SetItemSpacing(2)
    CategoryList:SetSelectMode('RADIO')
    CategoryList:SetItemList(MALL_DATA)
    CategoryList:SetItemHighlightWithoutChecked(true)
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

    local HowToGetPoint = Button:New(self)
    HowToGetPoint:SetPoint('RIGHT', QueryPointButton, 'RIGHT', -150, 0)
    HowToGetPoint:SetText(L['如何获取积分?'])
    HowToGetPoint:SetIcon([[INTERFACE\ICONS\INV_MISC_NOTE_01]])
    HowToGetPoint:SetScript('OnClick', function()
        GUI:CallUrlDialog('https://www.battlenet.com.cn/account/management/ebalance-purchase.html',
            L.HowToGetPoints,
            true)
    end)

    self:SetScript('OnShow', function(self)
        self:ScheduleTimer('SetBlocker', 0.01)
    end)

    self.ItemList = ItemList
    self.PurchaseButton = PurchaseButton
    self.QueryPointButton = QueryPointButton

    self:RegisterMessage('RAIDBUILDER_MALLQUERY_RESULT', 'QueryResult')
    self:RegisterMessage('RAIDBUILDER_MALLPURCHASE_RESULT', 'PurchaseResult')

    CategoryList:SetSelected(1)
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
    local text = result == -1 and L['查询失败：请稍后再试。'] or format(L['您当前可用积分为：%d'], result)
    GUI:CallWarningDialog(text)
    
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
    self.blocking = enable == nil and self.blocking or enable
    local item = self:GetItem() or {}
    MainPanel:SetBlocker(self.blocking and 'MALLPURCHASE', item.text, item.price)
    self:Timeout(self.blocking)
end

function MallItemsPanel:Timeout(enable)
    if enable and not self.timeout then
       self.timeout = self:ScheduleTimer('PurchaseResult', 120, nil, L['购买失败：操作超时，请稍后再试。'])
    end
end

function MallItemsPanel:PurchaseResult(event, result)
    self:SetBlocker(false)

    System:Error(result)

    if self.timeout then
        self:CancelTimer(self.timeout)
        self.timeout = nil
    end
end
