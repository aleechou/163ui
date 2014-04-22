
BuildEnv(...)

local RecommendItem = RaidBuilder:NewClass('RecommendItem', GUI:GetClass('ItemButton'))

function RecommendItem:Constructor()
    self:SetCheckedTexture([[Interface\HelpFrame\HelpFrameButton-Highlight]])
    self:GetCheckedTexture():SetTexCoord(0, 1, 0, 0.57)

    self:SetHighlightTexture([[Interface\HelpFrame\HelpFrameButton-Highlight]], 'ADD')
    self:GetHighlightTexture():SetTexCoord(0, 1, 0, 0.57)

    local tLeft = self:CreateTexture(nil, 'BACKGROUND')
    tLeft:SetTexture([[Interface\AuctionFrame\UI-AuctionItemNameFrame]])
    tLeft:SetTexCoord(0, 0.078125, 0, 1)
    tLeft:SetWidth(10)
    tLeft:SetPoint('TOPLEFT')
    tLeft:SetPoint('BOTTOMLEFT')

    local tRight = self:CreateTexture(nil, 'BACKGROUND')
    tRight:SetTexture([[Interface\AuctionFrame\UI-AuctionItemNameFrame]])
    tRight:SetTexCoord(0.75, 0.828125, 0, 1)
    tRight:SetWidth(10)
    tRight:SetPoint('TOPRIGHT')
    tRight:SetPoint('BOTTOMRIGHT')

    local tMid = self:CreateTexture(nil, 'BACKGROUND')
    tMid:SetTexture([[Interface\AuctionFrame\UI-AuctionItemNameFrame]])
    tMid:SetTexCoord(0.078125, 0.75, 0, 1)
    tMid:SetPoint('TOPLEFT', tLeft, 'TOPRIGHT')
    tMid:SetPoint('BOTTOMRIGHT', tRight, 'BOTTOMLEFT')

    local CreateButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CreateButton:SetSize(60, 22)
    CreateButton:SetPoint('RIGHT', -5, 0)
    CreateButton:SetText(L['开团'])
    CreateButton:SetScript('OnClick', function()
        local CreatePanel = RaidBuilder:GetModule('CreatePanel')
        MainPanel:SelectPanel(CreatePanel)
        CreatePanel:QuickToggle(self.Event.code, self.Event.mode)
    end)

    local JoinButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    JoinButton:SetSize(60, 22)
    JoinButton:SetPoint('RIGHT', CreateButton, 'LEFT', -5, 0)
    JoinButton:SetText(L['找团'])
    JoinButton:SetScript('OnClick', function()
        local BrowsePanel = RaidBuilder:GetModule('BrowsePanel')
        MainPanel:SelectPanel(BrowsePanel)
        BrowsePanel:QuickToggle(self.Event.code)
    end)

    local Title = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    Title:SetPoint('LEFT', 5, 0)

    self.Title = Title
end

function RecommendItem:SetEvent(event)
    self.Event = event
    self.Title:SetText(event.text)
end

function RecommendItem:SetHighlight(status)
    if status then
        self:SetHighlightTexture([[Interface\HelpFrame\HelpFrameButton-Highlight]], 'ADD')
        self:GetHighlightTexture():SetTexCoord(0, 1, 0, 0.57)
    else
        self:SetHighlightTexture(nil)
    end
end

local RecommendPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'RecommendPanel', 'AceEvent-3.0')

function RecommendPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MainPanel:RegisterPanel(L['主题活动'], self, 8, 170, 130)
    MainPanel:DisablePanel(self)

    local recommendData = DataCache:NewObject('Recommend')
    recommendData:SetCallback('OnCacheChanged', function(self, cache)
        local data = {}

        for k, v in ipairs(cache) do
            local eventCode, eventName = (':'):split(v)

            eventCode = tonumber(eventCode)

            if not eventName then
                eventName = RECOMMEND_NAMES[eventCode]
            else
                RECOMMEND_NAMES[eventCode] = eventName
            end

            local control, name, level, maxMembers, roleNum = eventName:match('([@!]?)([^ !@]*)#(%d+)#(%d+)#(.*)%s*$')

            eventCode = eventCode + EVENT_TYPE_RECOMMEND

            data[k] = {
                text = name,
                code = eventCode,
                mode = 7,
            }

            InsertMenuTable(L['主题活动'], name, eventCode, control, level, maxMembers, roleNum, k == 1)
        end
        self:SetData(data)
    end)
    recommendData:SetCallback('OnDataChanged', function(_, data)
        self:SetList(data)
        MainPanel:EnablePanel(self)
    end)

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetTexture([[Interface\ARCHEOLOGY\Arch-Race-Mogu]])
    Icon:SetPoint('TOPLEFT', self:GetOwner(), 60, -30)
    Icon:SetSize(36, 36)
    Icon:SetTexCoord(0, 0.578125, 0, 0.6796875)

    local TitleTip = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalHuge')
    TitleTip:SetPoint('LEFT', Icon, 'RIGHT')
    TitleTip:SetText(L['今日热门主题活动'])

    local TopTex = CreateFrame('Frame', nil, self, 'InsetFrameTemplate')
    TopTex:SetPoint('TOPLEFT', Icon, 'BOTTOMLEFT', -55, 0)
    TopTex:SetPoint('TOPRIGHT', self:GetOwner(), -10, 0)
    TopTex:SetHeight(60)

    local TopModel = CreateFrame('PlayerModel', nil, TopTex)
    TopModel:SetPoint('LEFT', 0, 0)
    TopModel:SetFacing(math.pi/4)
    TopModel:SetScript('OnSizeChanged', function(self)
        self:SetDisplayInfo(41399)
    end)
    TopModel:SetSize(300, 300)

    local Title = TopTex:CreateFontString(nil, 'OVERLAY', 'GameFontNormalHuge')
    Title:SetPoint('LEFT', TopModel, 'RIGHT')
    Title:SetPoint('RIGHT')

    local ListTip = GUI:GetClass('SortButton'):New(self)
    ListTip:SetSize(200, 19)
    ListTip:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -5, 8)
    ListTip:SetText(L['|cffffd100全部主题活动|r'])

    local EventList = GUI:GetClass('ListView'):New(self)
    EventList:SetAllPoints(true)
    EventList:SetItemClass(RaidBuilder:GetClass('RecommendItem'))
    EventList:SetItemHeight(42)
    EventList:SetItemSpacing(1)
    -- EventList:SetSelectMode('RADIO')

    EventList:SetCallback('OnItemFormatted',
        function(EventList, button, data)
            button:SetEvent(data)
            end)

    EventList:SetCallback('OnItemEnter',
        function(EventList, button, data)
            button:SetHighlight(not button:GetChecked())
            end)

    local SummaryBox = CreateFrame('Frame', nil, self, 'InsetFrameTemplate')
    SummaryBox:SetPoint('BOTTOMLEFT', self:GetOwner(), 5, 25)
    SummaryBox:SetPoint('BOTTOMRIGHT', self:GetOwner(), -10, 25)
    SummaryBox:SetHeight(100)
    local box = GUI:GetClass('TitleWidget'):New(SummaryBox)
    box:SetAllPoints(true)
    box:SetText(L['活动须知：'])
    local Summary = GUI:GetClass('EditBox'):New(box)
    Summary:SetText(L['|cffffd100        亲爱的朋友，还在苦恼没人一起陪你畅游艾泽拉斯吗？那就快来这里吧，每天从扭曲虚空会发布三个主题活动来到艾泽拉斯，您可以快速的创建或加入指定的活动，与同样喜欢这些活动的玩家一起活动，希望能给大家带来不同的游戏感受！|r'])
    Summary:SetReadOnly(true)
    Summary:ClearCopy()
    box:SetObject(Summary)

    self.Title = Title
    self.EventList = EventList
end

function RecommendPanel:SetList(eventList)
    self.EventList:SetItemList(eventList)
    self.EventList:Refresh()
    self.Title:SetText(eventList[1].text)
end

