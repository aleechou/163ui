
BuildEnv(...)

WaitPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'WaitPanel', 'AceEvent-3.0', 'AceBucket-3.0')

local WAIT_HEADER = {
    {
        key = 'Name',
        text = L['玩家名称'],
        width = 140,
        style = 'LEFT',
        showHandler = function(member)
            return member:GetNameText()
        end,
        sortHandler = function(member)
            return member:GetName()
        end
    },
    {
        key = 'Role',
        text = L['位置'],
        width = 70,
        style = 'ICON',
        showHandler = function(member)
            return nil, nil, nil, nil, GetRoleIconSmall(member:GetRole())
        end,
        sortHandler = function(member)
            return member:GetRole()
        end
    },
    {
        key = 'Class',
        text = L['职业'],
        width = 80,
        style = 'LEFT',
        showHandler = function(member)
            return member:GetClassText()
        end,
        sortHandler = function(member)
            return member:GetClass()
        end
    },
    {
        key = 'Level',
        text = L['等级'],
        width = 70,
        showHandler = function(member)
            return member:GetLevel()
        end,
        sortHandler = function(member)
            return member:GetLevel()
        end
    },
    {
        key = 'ItemLevel',
        text = L['装等'],
        width = 70,
        showHandler = function(member)
            return member:GetItemLevel()
        end,
        sortHandler = function(member)
            return member:GetItemLevel()
        end
    },
    {
        key = 'Haste',
        text = L['急速'],
        width = 70,
        showHandler = function(member)
            return member:GetStatInfo(STAT_HASTE)
        end,
        sortHandler = function(member)
            return member:GetStatInfo(STAT_HASTE) or 0
        end,
    },
    {
        key = 'Mastery',
        text = L['精通'],
        width = 70,
        showHandler = function(member)
            return member:GetStatInfo(STAT_MASTERY)
        end,
        sortHandler = function(member)
            return member:GetStatInfo(STAT_MASTERY) or 0
        end,
    },
    {
        key = 'Hit',
        text = L['命中'],
        width = 70,
        showHandler = function(member)
            return member:GetStatInfo(STAT_HIT)
        end,
        sortHandler = function(member)
            return member:GetStatInfo(STAT_HIT) or 0
        end,
    },
    {
        key = 'Option',
        text = L['操作'],
        width = 170,
        class = RaidBuilder:GetClass('OperationGrid'),
        formatHandler = function(grid, member)
            grid.AcceptButton:SetEnabled(PlayerIsGroupLeader() and not member:GetInviting())
            grid.RefuseButton:SetEnabled(not member:GetInviting())
        end
    }
}

function WaitPanel:OnInitialize()
    GUI:Embed(self, 'Owner')

    MainPanel:RegisterPanel(L['申请列表'], self, 5)

    local WaitList = GUI:GetClass('DataGridView'):New(self)
    WaitList:SetAllPoints(self)
    WaitList:SetItemHeight(32)
    WaitList:SetItemClass(RaidBuilder:GetClass('BrowseItem'))
    WaitList:SetItemSpacing(1)
    WaitList:SetSortHandler(WAIT_HEADER[2].sortHandler)
    WaitList:InitHeader(WAIT_HEADER)
    WaitList:SetHeaderPoint('BOTTOMLEFT', WaitList, 'TOPLEFT', -2, 2)
    WaitList:SetItemList(MemberCache:GetMemberList())
    WaitList:SetCallback('OnItemAccept', function(_, _, member)
        local event = EventCache:GetCurrentEvent()
        if event and event:IsMemberFull() then
            System:Error(L['活动人员已组满，无法继续邀请！'])
        else
            Logic:AcceptEventMember(member)
        end
    end)
    WaitList:SetCallback('OnItemRefuse', function(_, _, member)
        Logic:RefuseEventMember(member)
    end)
    WaitList:SetCallback('OnItemEnter', function(_, _, member)
        self:OpenWaitTooltip(member)
    end)
    WaitList:SetCallback('OnItemLeave', function()
        self:CloseWaitTooltip()
    end)
    WaitList:SetCallback('OnItemBan', function(_, _, member)
        RaidBuilder:GetModule('BlackListPanel'):Add(member:GetBattleTag(), function()
            Logic:RefuseEventMember(member)
        end)
    end)

    local NotLeader = self:CreateFontString(nil, 'OVERLAY', 'GameFontRedSmall')
    NotLeader:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -20, 30)
    NotLeader:SetText(L['你不是团长，不能邀请成员'])
    NotLeader:Hide()

    local RestoreButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    RestoreButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 0, 4)
    RestoreButton:SetSize(120, 22)
    RestoreButton:SetText(L['恢复活动'])
    RestoreButton:SetScript('OnClick', function()
        EventCache:RestoreCurrentEvent()
        self:Refresh()
    end)

    self.WaitList = WaitList
    self.NotLeader = NotLeader
    self.RestoreButton = RestoreButton

    self:SetScript('OnShow', self.Refresh)
    -- self:RegisterEvent('GROUP_ROSTER_UPDATE', 'Refresh')
    self:RegisterBucketEvent({'GROUP_ROSTER_UPDATE', 'UNIT_OTHER_PARTY_CHANGED'}, 5, 'Refresh')
    self:RegisterMessage('RAIDBUILDER_MEMBER_LIST_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_EVENT_LOCK_UPDATE', 'Refresh')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'Refresh')
end

function WaitPanel:Refresh()
    self.WaitList:Refresh()
    self.NotLeader:SetShown(not PlayerIsGroupLeader())

    local event = EventCache:GetCurrentEvent()
    local locked = EventCache:IsCurrentEventPaused()
    local full = event and event:IsMemberFull()
    local isLeader = PlayerIsGroupLeader()

    if full then
        if locked then
            self.RestoreButton:SetText(L['人员已满'])
            self.RestoreButton:Disable()
        else
            self.RestoreButton:SetText(L['Bug!!!'])
            self.RestoreButton:Disable()
        end
    else
        if locked then
            self.RestoreButton:SetText(L['恢复活动'])
            self.RestoreButton:SetEnabled(isLeader)
        else
            self.RestoreButton:SetText(L['正在招募'])
            self.RestoreButton:Disable()
        end
    end

    local count = MemberCache:GetMemberCount()
    if count == 0 then
        MainPanel:SetPanelText(self, L['申请列表'])
    else
        MainPanel:SetPanelText(self, L['申请列表'] .. ('|cff00ffff(%d)|r'):format(count))
    end
end

local MEMBER_INFO_TOOLTIP_ORDER = {
    { text = L['战网昵称：'],  method = 'GetBattleTagText', },
    { text = L['职业：'],      method = 'GetClassText', },
    { text = L['等级：'],      method = 'GetLevel', },
    { text = L['装等：'],      method = 'GetItemLevel', },
    { text = L['PVP：'],       method = 'GetPVPRating', },
    { text = L['易信关注度：'],method = 'GetFans', },
}

function WaitPanel:OpenWaitTooltip(member)
    if not member then
        return
    end
    
    GameTooltip:SetOwner(self, 'ANCHOR_NONE')
    GameTooltip:SetPoint('TOPLEFT', self:GetOwner(), 'TOPRIGHT', 1, -10)

    GameTooltip:SetText(member:GetNameText())

    for i, v in ipairs(MEMBER_INFO_TOOLTIP_ORDER) do
        if not v.method or not member[v.method] then
            GameTooltip:AddLine(v.text, 1, 1, 1, true)
        else
            local value = member[v.method](member, unpack(v))
            if value then
                GameTooltip:AddLine(v.text .. value, 1, 1, 1, true)
            end
        end
    end
    
    if type(member:GetStats()) == 'table' then
        GameTooltip:AddLine(' ')
        for i, v in ipairs(STAT_LIST) do
            if member:GetStatInfo(v) then
                GameTooltip:AddLine(STAT_NAMES[v] .. member:GetStatInfo(v), 1, 1, 1)
            end
        end
    end
    local eventCode = GroupCache:GetCurrentEventCode()
    if eventCode and type(member:GetProgression()) == 'table' then
        local progessionTitle = FormatProgressionTitle(member:GetProgression())
        if progessionTitle then
            GameTooltip:AddLine(' ')
            GameTooltip:AddDoubleLine(L['副本经验'], progessionTitle)

            for i, v in ipairs(GetRaidBossNames(eventCode)) do
                GameTooltip:AddDoubleLine(v, FormatProgressionText(member:GetProgression(), i), 1, 1, 1)
            end
        end
    end

    GameTooltip:Show()
end

function WaitPanel:CloseWaitTooltip()
    GameTooltip:Hide()
end
