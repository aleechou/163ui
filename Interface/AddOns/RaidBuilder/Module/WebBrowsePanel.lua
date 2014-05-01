
BuildEnv(...)

WebBrowsePanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MainPanel), 'WebBrowsePanel', 'AceEvent-3.0')

local WEB_HEADER = {
    {
        key = 'EventName',
        text = L['副本名称'],
        style = 'LEFT',
        width = 170,
        showHandler = function(event)
            return event:GetEventName(), 1, 0.82, 0
        end,
        sortHandler = function(event)
            local typeId = bit.band(event:GetEventCode(), TYPE_MATCH)
            local diffId = bit.band(event:GetEventCode(), DIFF_MATCH)
            local nameId = bit.band(event:GetEventCode(), NAME_MATCH)

            return (bit.lshift(typeId, 8) + bit.lshift(0xFFFF - nameId, 8) + bit.rshift(diffId, 24))-- * IsLeaderInLeaderboard(event:GetLeader())
        end,
    },
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
        width = 100,
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
        width = 100,
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
        style = 'LEFT',
        width = 150,
        showHandler = function(event)
            return
        end,
    },
}

function WebBrowsePanel:OnInitialize()
    GUI:Embed(self, 'Owner')

    MainPanel:RegisterPanel(L['网站活动'], self, 5, 90)
    MainPanel:DisablePanel(self)

    local function Refresh()
        self:Refresh()
    end

    local FilterLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    FilterLabel:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', 80, -40)
    FilterLabel:SetText(L['活动类型'])

    local Filter = GUI:GetClass('Dropdown'):New(self)
    Filter:SetPoint('LEFT', FilterLabel, 'RIGHT', 10, 0)
    Filter:SetSize(170, 26)
    Filter:SetMenuTable(EVENT_FILTER_MENUTABLE)
    Filter:SetValue(0)
    Filter:SetText(L['全部'])
    Filter:SetCallback('OnSelectChanged', Refresh)

    local LeaderLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallLeft')
    LeaderLabel:SetPoint('LEFT', Filter, 'RIGHT', 10, 0)
    LeaderLabel:SetText(L['团长查找'])

    local LeaderInput = GUI:GetClass('SearchBox'):New(self)
    LeaderInput:SetPoint('LEFT', LeaderLabel, 'RIGHT', 5, 0)
    LeaderInput:SetSize(140, 15)
    LeaderInput:SetScript('OnTextChanged', Refresh)

    local EventList = GUI:GetClass('DataGridView'):New(self)
    EventList:SetAllPoints(self)
    EventList:SetItemHeight(32)
    EventList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    EventList:SetSelectMode('RADIO')
    EventList:SetSortHandler(WEB_HEADER[1].sortHandler)
    EventList:SetItemSpacing(1)
    EventList:InitHeader(WEB_HEADER)
    EventList:SetHeaderPoint('BOTTOMLEFT', EventList, 'TOPLEFT', -2, 2)

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

    self.Filter = Filter
    self.EventList = EventList
    self.TotalEvents = TotalEvents
    self.LeaderInput = LeaderInput

    self:SetScript('OnShow', self.Refresh)
    self:RegisterMessage('RAIDBUILDER_WEBEVENT_LIST_UPDATE', 'Refresh')
end

function WebBrowsePanel:GetEventList(eventCode, leader)
    local list = {}
    local total = 0
    for _, event in WebEventCache:IterateEvents() do
        if event:Match(eventCode, leader) then
            tinsert(list, event) 
        end
        total = total + 1
    end
    return list, total
end

function WebBrowsePanel:Refresh()
    local events, total = self:GetEventList(
        self.Filter:GetValue(),
        self.LeaderInput:GetText()
    )
    self.EventList:SetItemList(events)
    self.EventList:Refresh()
    self.TotalEvents:SetText((L['活动总数 %d/%d']):format(#events, total))
end
