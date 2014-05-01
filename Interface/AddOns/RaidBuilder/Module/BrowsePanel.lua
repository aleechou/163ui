
BuildEnv(...)

BrowsePanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MainPanel), 'BrowsePanel', 'AceEvent-3.0')

local function IsLeaderInLeaderboard(name)
    local weekScore = DataCache:GetObject('LeaderScore'):GetData()
    
    if not weekScore then
        return 1
    end

    local fullName = GetFullName(name)
    
    for i, v in ipairs(weekScore) do
        if v.name == fullName then
            return -1
        end
    end

    return 1
end

local function _NormalSortHandler(event)
    local typeId = bit.band(event:GetEventCode(), TYPE_MATCH)
    local diffId = bit.band(event:GetEventCode(), DIFF_MATCH)
    local nameId = bit.band(event:GetEventCode(), NAME_MATCH)

    return (bit.lshift(typeId, 8) + bit.lshift(0xFFFF - nameId, 8) + bit.rshift(diffId, 24)) * IsLeaderInLeaderboard(event:GetLeader())
end

local BROWSE_HEADER = {
    {
        key = 'EventStatus',
        text = '@',
        style = 'ICON',
        width = 25,
        showHandler = function(event)
            if event:IsSelf() then
                return nil, nil, nil, nil, [[INTERFACE\GROUPFRAME\UI-Group-LeaderIcon]]
            elseif event:IsInEvent() then
                return nil, nil, nil, nil, [[INTERFACE\CHATFRAME\UI-ChatConversationIcon]]
            elseif event:IsApplied() then
                return nil, nil, nil, nil, [[INTERFACE\HELPFRAME\HelpIcon-ReportLag]]
            elseif event:GetHasPassword() then
                return nil, nil, nil, nil, [[INTERFACE\PetBattles\PetBattle-LockIcon]]
            end
        end,
        sortHandler = function(event)
            return event:IsSelf() and 1 or event:IsInEvent() and 2 or event:IsApplied() and 3 or event:GetHasPassword() and 4 or 5
        end,
    },
    {
        key = 'EventName',
        text = L['副本名称'],
        style = 'LEFT',
        width = 150,
        showHandler = function(event)
            return event:GetEventName(), 1, 0.82, 0
        end,
        sortHandler = _NormalSortHandler
    },
    {
        key = 'EventMode',
        text = L['形式'],
        style = 'LEFT',
        width = 60,
        showHandler = function(event)
            return event:GetEventModeText()
        end,
        sortHandler = function(event)
            return event:GetEventMode()
        end,
    },
    {
        key = 'MemberRole',
        text = L['人数'],
        width = 145,
        class = RaidBuilder:GetClass('MemberRoleGrid'),
        sortHandler = function(event)
            return event:GetMemberRole()
        end,
        formatHandler = function(grid, event)
            grid:SetEvent(event)
        end
    },
    {
        key = 'Level',
        text = L['等级'],
        width = 60,
        showHandler = function(event)
            local minLevel = event:GetMinLevel()
            local maxLevel = event:GetMaxLevel()
            local text = minLevel == maxLevel and minLevel or minLevel .. '-' .. maxLevel
            if event:IsLevelValid() then
                return text, 0, 1, 0
            else
                return text, 1, 0, 0
            end
        end,
        sortHandler = function(event)
            return event:GetMinLevel()
        end
    },
    {
        key = 'ItemLevel',
        text = L['要求'],
        width = 60,
        showHandler = function(event)
            if event:IsArenaEvent() then
                if event:IsPVPRatingValid() then
                    return event:GetPVPRating(), 0, 1, 0
                else
                    return event:GetPVPRating(), 1, 0, 0
                end
            else
                if event:IsItemLevelValid() then
                    return event:GetItemLevel(), 0, 1, 0
                else
                    return event:GetItemLevel(), 1, 0, 0
                end
            end
        end,
        sortHandler = function(event)
            return event:GetItemLevel()
        end
    },
    {
        key = 'Leader',
        text = L['团长'],
        style = 'LEFT',
        width = 130,
        showHandler = function(event)
            local icon = IsLeaderInLeaderboard(event:GetLeader())
            icon = icon == -1 and [[|TINTERFACE\Challenges\ChallengeMode_Medal_Platinum:16|t]] or icon == -2 and [[|TINTERFACE\Challenges\ChallengeMode_Medal_Gold:16|t]] or ''
            return icon .. event:GetLeaderText()
        end,
        sortHandler = function(event)
            return event:GetLeader()
        end
    },
    {
        key = 'Summary',
        text = L['说明'],
        style = 'LEFT',
        width = 170,
        showHandler = function(event)
            return event:GetSummary()
        end
    },
}

function BrowsePanel:OnInitialize()
    GUI:Embed(self, 'Owner')

    MainPanel:RegisterPanel(L['查找活动'], self, 5, 90)

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

    local Usable = GUI:GetClass('CheckBox'):New(self)
    Usable:SetPoint('LEFT', LeaderInput, 'RIGHT', 10, 0)
    Usable:SetSize(20, 20)
    Usable:SetText(L['符合条件'])
    Usable:SetScript('OnClick', Refresh)

    local Encrypt = GUI:GetClass('CheckBox'):New(self)
    Encrypt:SetPoint('LEFT', Usable, 'RIGHT', 80, 0)
    Encrypt:SetSize(20, 20)
    Encrypt:SetText(L['没有密码'])
    Encrypt:SetScript('OnClick', Refresh)

    local BanButton = GUI:GetClass('ClearButton'):New(self)
    BanButton:Hide()
    BanButton:SetScript('OnClick', function(button)
        BlackListPanel:Add(button.data)
    end)
    GUI:SetTooltip(BanButton, 'ANCHOR_RIGHT', L['加入到黑名单'])

    local EventList = GUI:GetClass('DataGridView'):New(self)
    EventList:SetAllPoints(self)
    EventList:SetItemHeight(32)
    EventList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    EventList:SetSelectMode('RADIO')
    EventList:SetSortHandler(_NormalSortHandler)
    EventList:SetItemSpacing(1)
    EventList:SetCallback('OnGridEnter', function(_, grid, event, key)
        if key == 'MemberRole' then
            RoleTip:Open(grid, event)
        else
            if grid:GetTextWidth() > grid:GetWidth() then
                GameTooltip:SetOwner(grid, 'ANCHOR_TOP')
                GameTooltip:SetText(grid:GetText())
                GameTooltip:Show()
            end
        end
        if event and not event:IsSelf() then
            BanButton:SetParent(grid:GetParent())
            BanButton:ClearAllPoints()
            BanButton:SetPoint('RIGHT')
            BanButton:SetFrameLevel(grid:GetFrameLevel() + 10)
            BanButton:Show()
            BanButton.data = event:GetLeaderBattleTag()
        end
    end)
    EventList:SetCallback('OnGridLeave', function()
        RoleTip:Hide()
        GameTooltip:Hide()
        if not BanButton:IsMouseOver() then
            BanButton:Hide()
        end
    end)
    EventList:SetCallback('OnSelectChanged', function(_, index, event)
        self:UpdateSelecttedEvent(event)
    end)
    EventList:SetCallback('OnItemEnter', function(_, index, event)
        self:OpenEventTooltip(event)
    end)

    EventList:InitHeader(BROWSE_HEADER)
    EventList:SetHeaderPoint('BOTTOMLEFT', EventList, 'TOPLEFT', -2, 2)

    local JoinButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    JoinButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 0, 4)
    JoinButton:SetSize(120, 22)
    JoinButton:SetText(L['申请加入'])
    JoinButton:SetScript('OnClick', function()
        self:JoinEvent()
    end)

    local TotalEvents = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    TotalEvents:SetPoint('BOTTOMRIGHT', self:GetOwner(), -7, 7)

    local IconSummary = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmallLeft')
    IconSummary:SetPoint('BOTTOMLEFT', self:GetOwner(), 15, 5)
    IconSummary:SetFormattedText(
        '|TINTERFACE\\GROUPFRAME\\UI-Group-LeaderIcon:15|t %s |TINTERFACE\\CHATFRAME\\UI-ChatConversationIcon:15|t %s |TINTERFACE\\HELPFRAME\\HelpIcon-ReportLag:15|t %s |TINTERFACE\\PetBattles\\PetBattle-LockIcon:15|t %s', 
        L['团长'], L['在团'], L['申请'], L['加密'])

    self.JoinButton = JoinButton
    self.Filter = Filter
    self.Usable = Usable
    self.EventList = EventList
    self.TotalEvents = TotalEvents
    self.Encrypt = Encrypt
    self.LeaderInput = LeaderInput

    self:SetScript('OnShow', self.Refresh)
    self:SetScript('OnHide', function()
        RaidBuilder:HideModule('RolePanel')
    end)

    self:RegisterMessage('RAIDBUILDER_APPLIED_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'Refresh')
    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'Refresh')
end

function BrowsePanel:Refresh()
    local item = self.EventList:GetSelectedItem()
    local events, total = self:GetEventList(
        self.Filter:GetValue(),
        self.Usable:GetChecked(),
        self.Encrypt:GetChecked(),
        self.LeaderInput:GetText())
    self.EventList:SetItemList(events)
    self.EventList:SetSelectedItem(item)
    self.TotalEvents:SetText((L['申请中 %d/%d 活动总数 %d/%d']):format(AppliedCache:Count(), AppliedCache:Max(), #events, total))
end

function BrowsePanel:UpdateSelecttedEvent(event)
    if not event or event:IsSelf() or event:IsInEvent() then
        self.JoinButton:Disable()
        self.JoinButton:SetText(L['申请加入'])
    elseif event:IsApplied() then
        self.JoinButton:Enable()
        self.JoinButton:SetText(L['取消申请'])
    else
        self.JoinButton:Enable()
        self.JoinButton:SetText(L['申请加入'])
    end
end

function BrowsePanel:GetEventList(eventCode, usable, noPassword, leader)
    local equipLevel = select(2, GetAverageItemLevel())
    local level = UnitLevel('player')

    local list = {}
    local num = 0
    for _, event in EventCache:IterateEvents() do
        -- if not event:IsMemberFull() then
            if event:Match(eventCode, usable, noPassword, leader) then
                tinsert(list, event)
            end
            num = num + 1
        -- end
    end
    return list, num
end

function BrowsePanel:JoinEvent()
    local event = self.EventList:GetItem(self.EventList:GetSelected())
    if not event then
        return
    end
    if event:IsSelf() or event:IsInEvent() then
        return
    end
    if event:IsApplied() then
        GUI:CallMessageDialog(L['你确定要取消申请这个活动？'], function(result)
            if result then
                Logic:LeaveEvent(event)
            end
        end)
    else
        if AppliedCache:Count() > AppliedCache:Max() then
            System:Error(L['申请队列已经满员，请等待或取消之前的申请'])
        elseif EventCache:GetCurrentEvent() then
            System:Error(L['你正在组织一个活动，不能申请其它活动'])
        elseif IsInGroup() then
            System:Error(L['你已经在一个队伍中，不能申请其它活动。'])
        else
            RaidBuilder:ShowModule('RolePanel', function(role, password)
                Logic:JoinEvent(event, role, password)
            end, event)
        end
    end
end

local EVENT_INFO_TOOLTIP_ORDER = {
    { text = L['战网昵称：'],  method = 'GetLeaderBTag', },
    { text = L['团长：'],      method = 'GetLeaderText', true },
    { text = L['职业：'],      method = 'GetLeaderClassText', },
    { text = L['等级：'],      method = 'GetLeaderLevel', },
    { text = L['装等：'],      method = 'GetLeaderItemLevel', },
    { text = L['PVP：'],       method = 'GetLeaderPVPRating', },
    { text = L['易信关注度：'],method = 'GetLeaderFans', },
    { text = ' ', },
    { text = L['形式：'],      method = 'GetEventModeText', },
    { text = L['说明：'],      method = 'GetSummary', },
}

function BrowsePanel:OpenEventTooltip(event)
    if not event then
        return
    end
    
    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self:GetOwner(), 'TOPRIGHT', 1, -10)
    GameTooltip:SetText(event:GetEventName())

    for i, v in ipairs(EVENT_INFO_TOOLTIP_ORDER) do
        if not v.method or not event[v.method] then
            GameTooltip:AddLine(v.text, 1, 1, 1, true)
        else
            local value = event[v.method](event, unpack(v))
            if value then
                GameTooltip:AddLine(v.text .. value, 1, 1, 1, true)
            end
        end
    end

    local progessionTitle = FormatProgressionTitle(event:GetLeaderProgression())
    if progessionTitle then
        GameTooltip:AddLine(' ')
        GameTooltip:AddDoubleLine(L['团长副本经验'], progessionTitle)

        for i, v in ipairs(GetRaidBossNames(event:GetEventCode())) do
            GameTooltip:AddDoubleLine(v, FormatProgressionText(event:GetLeaderProgression(), i), 1, 1, 1)
        end
    end
    GameTooltip:Show()
end

function BrowsePanel:CloseEventTooltip()
    GameTooltip:Hide()
end

function BrowsePanel:QuickToggle(code)
    self.Filter:SetValue(code)
end
