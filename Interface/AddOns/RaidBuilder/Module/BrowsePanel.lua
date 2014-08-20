
BuildEnv(...)

BrowsePanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MainPanel), 'BrowsePanel', 'AceEvent-3.0', 'AceBucket-3.0', 'NetEaseGUI-DropMenu-1.0')

local function _NormalSortHandler(event)
    return format('%04d%08x', event:GetLeaderLogoIndex(), event:GetEventCode())
end

local BROWSE_HEADER = {
    {
        key = 'EventStatus',
        text = '@',
        style = 'ICON',
        width = 25,
        showHandler = function(event)
            if event:IsSelf() then
                return nil, nil, nil, nil, [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]], 128/256, 160/256, 0, 0.5
            elseif event:IsInEvent() then
                return nil, nil, nil, nil, [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]], 32/256, 64/256, 0, 0.5
            elseif event:IsApplied() then
                return nil, nil, nil, nil, [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]], 160/256, 192/256, 0, 0.5
            elseif event:GetHasPassword() then
                return nil, nil, nil, nil, [[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]], 192/256, 224/256, 0, 0.5
            elseif event:IsInFavorite() then
                return nil, nil, nil, nil, [[INTERFACE\COMMON\ReputationStar]], 0, 1/2, 0, 1/2
            end
        end,
        sortHandler = function(event)
            return event:GetStatusSortValue()
        end,
    },
    {
        key = 'EventName',
        text = L['活动名称'],
        style = 'LEFT',
        width = 175,
        showHandler = function(event)
            return event:GetEventName(), 1, 0.82, 0
        end,
        sortHandler = function(event)
            return event:GetEventCode()
        end,
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
        text = L['人数'] .. '         ' .. L['可申请'],
        width = 135,
        class = RaidBuilder:GetClass('MemberRoleGrid'),
        sortHandler = function(event)
            return event:GetRoleCurrentAll() - event:GetRoleTotalAll()
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
        style = 'ICONTEXT',
        width = 130,
        showHandler = function(event)
            return event:GetLeaderText(), nil, nil, nil, event:GetLeaderLogoTexture()
        end,
        sortHandler = function(event)
            return format('%04d%s', event:GetLeaderLogoIndex(), strpadright(event:GetLeader(), 40))
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
    GUI:Embed(self, 'Owner', 'Refresh')

    MainPanel:RegisterPanel(L['查找活动'], self, 5, 90)

    local function RefreshFilter()
        local leader = self.LeaderInput:GetText()
        local filter = self.Filter:GetValue()
        local usable = self.Usable:GetChecked() or nil
        local encrypt = self.Encrypt:GetChecked() or nil
        local favorite = self.Favorite:GetChecked() or nil
        local eventCode = filter ~= 0 and filter or nil

        self.EventList:SetFilterText(leader, eventCode, usable, encrypt, favorite)
    end

    local HelpButton = CreateFrame('Button', nil, self, 'MainHelpPlateButton')
    HelpButton:SetPoint('TOPLEFT', self:GetOwner(), 39, 20)
    HelpButton:SetScript('OnClick', function()
        self:ToggleHelpPlate()
    end)

    MainPanel:AddHelpButton(HelpButton)

    local FilterLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    FilterLabel:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', 80, -40)
    FilterLabel:SetText(L['活动类型'])

    local Filter = GUI:GetClass('Dropdown'):New(self)
    Filter:SetPoint('LEFT', FilterLabel, 'RIGHT', 10, 0)
    Filter:SetSize(170, 26)
    Filter:SetMenuTable(EVENT_FILTER_MENUTABLE)
    Filter:SetValue(0)
    Filter:SetText(L['全部'])
    Filter:SetCallback('OnSelectChanged', RefreshFilter)

    local LeaderLabel = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallLeft')
    LeaderLabel:SetPoint('LEFT', Filter, 'RIGHT', 10, 0)
    LeaderLabel:SetText(L['团长查找'])

    local LeaderInput = GUI:GetClass('SearchBox'):New(self)
    LeaderInput:SetPoint('LEFT', LeaderLabel, 'RIGHT', 5, 0)
    LeaderInput:SetSize(140, 15)
    LeaderInput:SetScript('OnTextChanged', RefreshFilter)

    local Usable = GUI:GetClass('CheckBox'):New(self)
    Usable:SetPoint('LEFT', LeaderInput, 'RIGHT', 10, 0)
    Usable:SetSize(20, 20)
    Usable:SetText(L['符合条件'])
    Usable:SetScript('OnClick', RefreshFilter)

    local Encrypt = GUI:GetClass('CheckBox'):New(self)
    Encrypt:SetPoint('LEFT', Usable, 'RIGHT', 80, 0)
    Encrypt:SetSize(20, 20)
    Encrypt:SetText(L['没有密码'])
    Encrypt:SetScript('OnClick', RefreshFilter)

    local Favorite = GUI:GetClass('CheckBox'):New(self)
    Favorite:SetPoint('LEFT', Encrypt, 'RIGHT', 80, 0)
    Favorite:SetSize(20, 20)
    Favorite:SetText(L['仅关注'])
    Favorite:SetScript('OnClick', RefreshFilter)

    local EventList = GUI:GetClass('DataGridView'):New(self)
    EventList:SetAllPoints(self)
    EventList:SetItemHeight(32)
    EventList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    EventList:SetSelectMode('RADIO')
    EventList:SetSortHandler(_NormalSortHandler)
    EventList:SetItemSpacing(1)
    EventList:SetItemList({})
    EventList:SetCallback('OnGridEnter', function(_, grid, event, key)
        if key == 'MemberRole' then
            RoleTip:Open(grid, event)
        else
            if grid:GetTextWidth() > grid:GetWidth() then
                GameTooltip:SetOwner(grid, 'ANCHOR_NONE')
                GameTooltip:SetPoint('BOTTOMRIGHT', grid, 'TOPRIGHT')
                GameTooltip:SetText(grid:GetText())
                GameTooltip:Show()
            end
        end
    end)
    EventList:SetCallback('OnGridLeave', function()
        RoleTip:Hide()
        GameTooltip:Hide()
        MainPanel:CloseTooltip()
    end)
    EventList:SetCallback('OnSelectChanged', function(_, index, event)
        self:UpdateSelecttedEvent(event)
    end)
    EventList:SetCallback('OnItemEnter', function(_, index, event)
        MainPanel:OpenEventTooltip(event)
        self.OnEnterHandler = true
    end)
    EventList:SetCallback('OnItemLeave', function()
        self.OnEnterHandler = nil
    end)
    EventList:SetCallback('OnItemMenu', function(_, button, event)
        self:ToggleEventMenu(button, event)
    end)
    EventList:SetCallback('OnRefresh', function(frame)
        self.EmptySummary:SetShown(frame:GetItemCount() == 0)
        self:UpdateSelecttedEvent()
    end)
    EventList:RegisterFilter(function(event, ...)
        return event:Match(...)
    end)

    EventList:InitHeader(BROWSE_HEADER)
    EventList:SetHeaderPoint('BOTTOMLEFT', EventList, 'TOPLEFT', -2, 2)

    local EmptySummary = GUI:GetClass('SummaryHtml'):New(EventList)
    EmptySummary:SetPoint('CENTER')
    EmptySummary:SetSize(300, 180)
    EmptySummary:SetText(L.EmptySummary)

    local JoinButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    JoinButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 0, 4)
    JoinButton:SetSize(120, 22)
    JoinButton:SetText(L['申请加入'])
    JoinButton:SetScript('OnClick', function()
        self:JoinOrLeaveEvent(self.EventList:GetItem(self.EventList:GetSelected()))
    end)

    local TotalEvents = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    TotalEvents:SetPoint('BOTTOMRIGHT', self:GetOwner(), -7, 7)

    local IconSummary = CreateFrame('Button', nil, self)
    IconSummary:SetSize(50, 16)
    IconSummary:SetPoint('BOTTOMLEFT', self:GetOwner(), 10, 5)
    local icon = IconSummary:CreateTexture(nil, 'OVERLAY')
    icon:SetSize(16, 16)
    icon:SetPoint('LEFT')
    icon:SetTexture([[INTERFACE\COMMON\ReputationStar]])
    icon:SetTexCoord(0, 0.5, 0, 0.5)
    local label = IconSummary:CreateFontString(nil, 'OVERLAY')
    label:SetPoint('LEFT', icon, 'RIGHT', 2, 0)
    IconSummary:SetFontString(label)
    IconSummary:SetNormalFontObject('GameFontHighlightSmall')
    IconSummary:SetHighlightFontObject('GameFontNormalSmall')
    IconSummary:SetText(L['图示'])
    
    IconSummary:SetScript('OnEnter', function(button)
        GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')
        GameTooltip:SetText(L['图示'])
        GameTooltip:AddLine(format([[|TInterface\AddOns\RaidBuilder\Media\RaidbuilderIcons:16:16:0:0:256:64:128:160:0:32|t %s]], L['我的活动']), 1, 1, 1)
        GameTooltip:AddLine(format([[|TInterface\AddOns\RaidBuilder\Media\RaidbuilderIcons:16:16:0:0:256:64:32:64:0:32|t %s]], L['已加入活动']), 1, 1, 1)
        GameTooltip:AddLine(format([[|TInterface\AddOns\RaidBuilder\Media\RaidbuilderIcons:16:16:0:0:256:64:160:192:0:32|t %s]], L['申请中活动']), 1, 1, 1)
        GameTooltip:AddLine(format([[|TInterface\AddOns\RaidBuilder\Media\RaidbuilderIcons:16:16:0:0:256:64:192:224:0:32|t %s]], L['加密活动']), 1, 1, 1)
        GameTooltip:AddLine(format([[|TINTERFACE\COMMON\ReputationStar:16:16:0:0:32:32:0:16:0:16|t %s]], L['关注团长的活动']), 1, 1, 1)

        GameTooltip:Show()
    end)
    IconSummary:SetScript('OnLeave', GameTooltip_Hide)

    local RecentButton = CreateFrame('Button', nil, self)
    RecentButton:SetSize(110, 16)
    RecentButton:SetPoint('LEFT', IconSummary, 'RIGHT', 20, 0)
    local icon = RecentButton:CreateTexture(nil, 'OVERLAY')
    icon:SetSize(16, 16)
    icon:SetPoint('LEFT')
    icon:SetTexture([[Interface\AddOns\RaidBuilder\Media\Icon]])
    local label = RecentButton:CreateFontString(nil, 'OVERLAY')
    label:SetPoint('LEFT', icon, 'RIGHT', 2, 0)
    RecentButton:SetFontString(label)
    RecentButton:SetNormalFontObject('GameFontHighlightSmall')
    RecentButton:SetHighlightFontObject('GameFontNormalSmall')
    RecentButton:SetText(L['最近的战友'])

    RecentButton:SetScript('OnClick', function()
        MainPanel:SelectPanel(OptionPanel)
        OptionPanel:SelectPanel(RecentMemberPanel)
    end)

    self.HelpButton = HelpButton
    self.JoinButton = JoinButton
    self.Filter = Filter
    self.Usable = Usable
    self.EventList = EventList
    self.TotalEvents = TotalEvents
    self.Encrypt = Encrypt
    self.Favorite = Favorite
    self.LeaderInput = LeaderInput
    self.EmptySummary = EmptySummary

    self:SetScript('OnShow', function(self)
        self:Refresh()
        if self.EventList:GetSortHandler() ~= _NormalSortHandler then
            self.EventList:SetSortHandler(_NormalSortHandler)
        end
    end)
    self:SetScript('OnHide', function()
        HelpPlate_Hide()
        RaidBuilder:HideModule('RolePanel')
    end)

    -- self:RegisterMessage('RAIDBUILDER_APPLIED_UPDATE', 'Refresh')
    -- self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'Refresh')
    self:RegisterBucketEvent('GROUP_ROSTER_UPDATE', 1, 'Refresh')
    self:RegisterBucketMessage({'RAIDBUILDER_APPLIED_UPDATE', 'RAIDBUILDER_EVENT_LIST_UPDATE'}, 1, 'Refresh')
end

function BrowsePanel:Update()
    if not self.OnEnterHandler then
        self.EventList:SetItemList(self:GetEventList())
    end
    self.TotalEvents:SetText((L['申请中 %d/%d 活动总数 %d/%d']):format(
        AppliedCache:Count(),
        AppliedCache:Max(),
        self.EventList:GetItemCount(),
        EventCache:GetEventCount()))
end

function BrowsePanel:UpdateSelecttedEvent(event)
    event = event or self.EventList:GetSelectedItem()
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

function BrowsePanel:GetEventList()
    local list = {}
    for _, event in EventCache:IterateEvents() do
        -- if not event:IsMemberFull() then
                tinsert(list, event)
        -- end
    end
    return list
end

function BrowsePanel:JoinOrLeaveEvent(event)
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
        elseif IsInGroup() then
            System:Error(L['你已经在一个队伍中，不能申请其它活动。'])
        elseif EventCache:GetCurrentEvent() then
            GUI:CallMessageDialog(L['你正在组织一个活动，是否解散活动以申请其它活动？'], function(result)
                if result then
                    Logic:DisbandEvent()
                    self:JoinEvent(event)
                end
            end)
        else
            self:JoinEvent(event)
        end
    end
end

function BrowsePanel:JoinEvent(event)
    RaidBuilder:ShowModule('RolePanel', function(role, password, msgId)
        Logic:JoinEvent(event, role, password, msgId)
    end, event)
end

function BrowsePanel:QuickToggle(code, item)
    self.Filter:SetValue(code)
    if item then
        self.EventList:SetSelectedItem(item)
    end
end

local helpPlate = {
    FramePos = { x = -10,          y = 75 },
    FrameSize = { width = 830, height = 425 },
    {
        ButtonPos = { x = 300,   y = -5 },
        HighLightBox = { x = 60, y = -5, width = 765, height = 45 },
        ToolTipDir = "DOWN",
        ToolTipText = L.BrowseHelp1,
    },
    {
        ButtonPos = { x = 370,  y = -190 },
        HighLightBox = { x = 5, y = -55, width = 820, height = 338 },
        ToolTipDir = "RIGHT",
        ToolTipText = L.BrowseHelp2,
    },
    {
        ButtonPos = { x = 90,  y = -389 },
        HighLightBox = { x = 5, y = -397, width = 130, height = 28 },
        ToolTipDir = "UP",
        ToolTipText = L.BrowseHelp3,
    },
    {
        ButtonPos = { x = 300,  y = -389 },
        HighLightBox = { x = 300, y = -397, width = 200, height = 28 },
        ToolTipDir = "UP",
        ToolTipText = L.BrowseHelp4,
    },
    {
        ButtonPos = { x = 550,  y = -389 },
        HighLightBox = { x = 550, y = -397, width = 275, height = 28 },
        ToolTipDir = "UP",
        ToolTipText = L.BrowseHelp5,
    },
}

function BrowsePanel:ToggleHelpPlate()
    if helpPlate and not HelpPlate_IsShowing(helpPlate) then
        HelpPlate_Show(helpPlate, self, self.HelpButton, true )
    else
        HelpPlate_Hide(true)
    end
end

function BrowsePanel:ToggleEventMenu(button, event)
    self:ToggleMenu(button, {
        {
            text = event:GetEventName(),
            isTitle = true,
        },
        {
            text = L['密语'],
            func = function()
                local name = event:GetLeader()
                ChatFrame_SendTell(Invite:IsSameRealm(name) and name or name:gsub('-', '@'), ChatFrame1)
            end,
        },
        {
            text = event:IsApplied() and L['取消申请'] or L['申请加入'],
            disabled = event:IsSelf() or event:IsInEvent(),
            func = function()
                self:JoinOrLeaveEvent(event)
            end,
        },
        {
            text = L['添加关注'],
            disabled = event:IsSelf(),
            func = function()
                FavoritePanel:Add(event:GetLeaderBattleTag())
            end
        },
        {
            text = L['加入黑名单'],
            disabled = event:IsSelf(),
            func = function()
                BlackListPanel:Add(event:GetLeaderBattleTag())
            end
        },
        {
            text = L['举报'],
            disabled = event:IsSelf(),
            confirmInput = true,
            confirmDefault = L['广告'],
            confirm = L['你确定要举报玩家 |cffffd100%s|r 吗？\n请填写举报原因。']:format(event:GetLeaderBattleTag()),
            func = function(result, input)
                if result then
                    Logic:ReportEvent(input, event)
                end
            end
        }
    }, 'cursor')
end
