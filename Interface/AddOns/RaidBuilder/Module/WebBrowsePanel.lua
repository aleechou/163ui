
BuildEnv(...)

WebBrowsePanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MainPanel), 'WebBrowsePanel', 'AceEvent-3.0')

local WEB_HEADER = {
    {
        key = 'EventName',
        text = L['副本名称'],
        style = 'LEFT',
        width = 200,
        showHandler = function(event)
            return event:GetEventName(), 1, 0.82, 0
        end,
        sortHandler = function(event)
            return event:GetEventName()
        end
    },
    -- {
    --     key = 'Faction',
    --     text = L['阵营'],
    --     style = 'ICON:24:24',
    --     width = 70,
    --     showHandler = function(event)
    --         return nil, nil, nil, nil, format([[INTERFACE\COMMON\icon-%s]], event:GetFaction()), 0.2, 0.8, 0.2, 0.8
    --     end,
    --     sortHandler = function(event)
    --         return event:GetFaction()
    --     end
    -- },
    {
        key = 'PersonNum',
        text = L['当前人数'],
        width = 100,
        showHandler = function(event)
            return event:GetPersonNum()
        end,
        sortHandler = function(event)
            return event:GetPersonNum()
        end,
    },
    {
        key = 'LeaderLevel',
        text = L['等级'],
        width = 80,
        showHandler = function(event)
            return event:GetLevel()
        end,
        sortHandler = function(event)
            return event:GetLevel()
        end,
    },
    {
        key = 'LeaderItemLevel',
        text = L['装等'],
        width = 80,
        showHandler = function(event)
            return event:GetItemLevel()
        end,
        sortHandler = function(event)
            return event:GetItemLevel()
        end,
    },
    {
        key = 'Leader',
        text = L['团长'],
        style = 'LEFT',
        width = 150,
        showHandler = function(event)
            return event:GetLeader()
        end,
        sortHandler = function(event)
            return event:GetLeader()
        end,
    },
    {
        key = 'Option',
        text = L['操作'],
        width = 170,
        class = RaidBuilder:GetClass('WebOperationGrid'),
        showHandler = function(event)
            return
        end,
    },
}

function WebBrowsePanel:OnInitialize()
    GUI:Embed(self, 'Owner')

    MainPanel:RegisterPanel(L['网站活动'], self, 5, 90)
    -- MainPanel:DisablePanel(self)

    local LeaderLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallLeft')
    LeaderLabel:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', 80, -40)
    LeaderLabel:SetText(L['活动过滤'])

    local LeaderInput = GUI:GetClass('SearchBox'):New(self)
    LeaderInput:SetPoint('LEFT', LeaderLabel, 'RIGHT', 5, 0)
    LeaderInput:SetSize(240, 15)
    LeaderInput:SetScript('OnTextChanged', function()
        self:Refresh()
    end)

    local EventList = GUI:GetClass('DataGridView'):New(self)
    EventList:SetAllPoints(self)
    EventList:SetItemHeight(32)
    EventList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    -- EventList:SetSelectMode('RADIO')
    EventList:SetSortHandler(WEB_HEADER[1].sortHandler)
    EventList:SetItemSpacing(1)
    EventList:InitHeader(WEB_HEADER)
    EventList:SetHeaderPoint('BOTTOMLEFT', EventList, 'TOPLEFT', -2, 2)
    EventList:SetCallback('OnItemGoto', function(_, _, event)
        GUI:CallUrlDialog(GetWebEventUrl(event:GetEventId(), event:GetEventSource()))
    end)

    local TotalEvents = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    TotalEvents:SetPoint('BOTTOMRIGHT', self:GetOwner(), -7, 7)

    local InviteButton = Button:New(self)
    InviteButton:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -80, 30)
    InviteButton:SetText(L['快捷邀请'])
    InviteButton:SetIcon([[Interface\AddOns\RaidBuilder\Media\WebEvent]])
    InviteButton:SetTooltip(
        L['快捷邀请'],
        L['团长可以使用网站上的组队代码实现一键组队']
    )
    InviteButton:SetScript('OnClick', function()
        RaidBuilder:ShowModule('WebInvitePanel')
    end)

    self.EventList = EventList
    self.TotalEvents = TotalEvents
    self.LeaderInput = LeaderInput

    self:SetScript('OnShow', self.Refresh)
    self:RegisterMessage('RAIDBUILDER_WEBEVENT_LIST_UPDATE', 'Refresh')
end

function WebBrowsePanel:GetEventList(text)
    local list = {}
    local total = 0
    for _, event in WebEventCache:IterateEvents() do
        if event:Match(text) then
            tinsert(list, event) 
        end
        total = total + 1
    end
    return list, total
end

function WebBrowsePanel:Refresh()
    local events, total = self:GetEventList(self.LeaderInput:GetText())
    self.EventList:SetItemList(events)
    self.EventList:Refresh()
    self.TotalEvents:SetText((L['活动总数 %d/%d']):format(#events, total))
end
