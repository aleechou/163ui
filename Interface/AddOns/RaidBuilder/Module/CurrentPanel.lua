
BuildEnv(...)

local raidTargetItem = {}
for i = 1, 8 do
    local sys = UnitPopupButtons['RAID_TARGET_' .. i]
    tinsert(raidTargetItem, {
        text = format('|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_%d:13|t %s%s|r', i, RGBTableToColorCode(sys.color), sys.text),
        checkable = true,
        checked = function(data, button)
            return GetRaidTargetIndex(button:GetUnitId()) == i
        end,
        disabled = function(data, button)
            return not UnitIsGroupLeader('player')
        end,
        func = function(button)
            SetRaidTarget(button:GetUnitId(), i)
        end})
end
tinsert(raidTargetItem, {
    text = RAID_TARGET_NONE,
    checkable = true,
    checked = function(data, button)
        return not GetRaidTargetIndex(button:GetUnitId())
    end,
    disabled = function(data, button)
        return not UnitIsGroupLeader('player')
    end,
    func = function(button)
        SetRaidTarget(button:GetUnitId(), 0)
    end})

local function _UnitSetRole(unit, role)
    if role == GroupCache:GetUnitRole(UnitName(unit)) then
        return
    end
    if UnitGroupRolesAssigned(unit) == role then
        UnitSetRole(unit, role ~= 'NONE' and 'NONE' or 'DAMAGER')
    end
    UnitSetRole(unit, role)
end

local function _UnitGetRole(unit)
    return GroupCache:GetUnitRole(UnitName(unit)) or UnitGroupRolesAssigned(unit) or 'NONE'
end

local function CreateMenuTable(unit)
    local role = GroupCache:GetUnitRole(UnitName(unit)) or UnitGroupRolesAssigned(unit) or 'NONE'
    local isCanSetRole = UnitIsGroupLeader('player') and not InCombatLockdown() and UnitInGroup(unit)

    local menuTable =
        {
            {
                text = function(button)
                    return UnitName(unit)
                end,
                isTitle = true,
            },
            {
                text = WHISPER,
                disabled = function(data, button)
                    return UnitIsUnit('player', unit)
                end,
                func = function(button)
                    ChatFrame_SendTell(UnitName(unit), ChatFrame1)
                end,
            },
            {
                text = INSPECT,
                disabled = function(data, button)
                    return UnitIsUnit('player', unit)
                end,
                func = function(button)
                    InspectUnit(unit)
                end,
            },
            {
                text = PARTY_UNINVITE,
                disabled = function(data, button)
                    return not UnitIsGroupLeader('player') or UnitIsUnit('player', unit)
                end,
                func = function(button)
                    UninviteUnit(unit)
                end,
            },
            {
                text = RAID_TARGET_ICON,
                hasArrow = true,
                disabled = function(data, button)
                    return not UnitIsGroupLeader('player')
                end,
                menuTable = raidTargetItem,
            },
            {
                text = L['设置友团职责'],
                hasArrow = true,
                disabled = function(data, button)
                    return (not UnitInRaid(unit) and not UnitInParty(unit)) or not UnitIsGroupLeader('player')
                end,
                menuTable =
                {
                    {
                        text = INLINE_TANK_ICON..' '..TANK,
                        checkable = true,
                        checked = function()
                            return _UnitGetRole(unit) == 'TANK'
                        end,
                        disabled = not isCanSetRole or not UnitGetAvailableRoles(unit),
                        func = function(button)
                            _UnitSetRole(unit, 'TANK')
                        end,
                    },
                    {
                        text = INLINE_HEALER_ICON..' '..HEALER,
                        checkable = true,
                        checked = function()
                            return _UnitGetRole(unit) == 'HEALER'
                        end,
                        disabled = not isCanSetRole or not select(2, UnitGetAvailableRoles(unit)),
                        func = function(button)
                            _UnitSetRole(unit, 'HEALER')
                        end,
                    },
                    {
                        text = INLINE_DAMAGER_ICON..' '..DAMAGER,
                        checkable = true,
                        checked = function()
                            return _UnitGetRole(unit) == 'DAMAGER'
                        end,
                        disabled = not isCanSetRole or not select(3, UnitGetAvailableRoles(unit)),
                        func = function(button)
                            _UnitSetRole(unit, 'DAMAGER')
                        end,
                    },
                    {
                        text = '|TInterface\\AddOns\\RaidBuilder\\Media\\RoleNone:16:16:0:0:64:64:0:38:0.5:40|t ' .. L['其他'],
                        checkable = true,
                        checked = function()
                            return _UnitGetRole(unit) == 'NONE'
                        end,
                        disabled = not isCanSetRole,
                        func = function(button)
                            _UnitSetRole(unit, 'NONE')
                        end,
                    },
                },
            },
            {
                text = L['加入黑名单'],
                disabled = function(data, button)
                    local member = GroupCache:GetUnitInfo(UnitName(unit))
                    return not member or not member:GetBattleTag() or UnitIsUnit('player', unit)
                end,
                func = function(button)
                    local member = GroupCache:GetUnitInfo(UnitName(unit))
                    if member then
                        BlackListPanel:Add(member:GetBattleTag())
                    end
                end,
            },
            {
                text = CANCEL,
            },
        }

    if IsAddOnLoaded('WowSocial') then
        local chatGroupList = GetOwnChatGroupList(UnitFullName('player'))
        if #chatGroupList > 0 then
            local menu = {
                text = L['|cff33ff99邀请入群|r'],
                hasArrow = true,
                disabled = function(data, button)
                    return UnitIsUnit(unit, 'player')
                end,
                menuTable = {},
            }
            for i, v in ipairs(chatGroupList) do
                tinsert(menu.menuTable, {
                        text = v.text,
                        value = v.target,
                        disabled = function(data, button)
                            return UnitIsUnit(unit, 'player')
                        end,
                        func = function(button, data)
                            InviteChatGroup(data.value, UnitFullName(unit))
                        end,
                    })
            end
            tinsert(menuTable, #menuTable - 1, menu)
        end
    end

	return menuTable
end

local CurrentPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'CurrentPanel', 'AceEvent-3.0', 'AceTimer-3.0', 'NetEaseGUI-DropMenu-1.0', 'AceBucket-3.0')

function CurrentPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MainPanel:RegisterPanel(L['我的队伍'], self, 8)

    local function MakeRole(style, index)
        local icon, coords = GetRoleIconSmall(style)
        local Icon = self:CreateTexture(nil, 'ARTWORK')
        Icon:SetSize(20, 20)
        Icon:SetTexture(icon)
        Icon:SetTexCoord(unpack(coords))
        Icon:SetPoint('BOTTOMLEFT', self:GetOwner(), 'BOTTOMLEFT', 15 + (index - 1) * 50, 3)

        local Label = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
        Label:SetPoint('LEFT', Icon, 'RIGHT', 3, 0)

        return Icon, Label
    end

    self.Roles = {}
    for i, role in ipairs(RAID_ROLE_LIST) do
        local Icon, Label = MakeRole(role, i)
        self.Roles[role] = {
            Icon = Icon,
            Label = Label,
        }
    end

    local TitleTex = self:CreateTexture(nil, 'ARTWORK')
    TitleTex:SetTexture([[INTERFACE\ARCHEOLOGY\Arch-Race-Mantid]])
    TitleTex:SetSize(64, 64)
    TitleTex:SetPoint('TOPLEFT', self:GetOwner(), 'TOPLEFT', 60, -30)

    local TitleLabel = self:CreateFontString(nil, 'ARTWORK', 'GameFontNormalHuge')
    TitleLabel:SetPoint('TOPLEFT', TitleTex, 'TOPRIGHT', -20, -10)
    TitleLabel:SetText(L['当前没有活动'])

    local YiXinButton = Button:New(self)
    YiXinButton:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -80, 20)
    YiXinButton:SetText(L['易信推送'])
    YiXinButton:SetIcon([[Interface\AddOns\RaidBuilder\Media\YiXin]])
    YiXinButton:SetTooltip(
        L['易信通知'],
        L['你每天有3次机会向关注你的玩家发送活动通知。']
    )
    YiXinButton:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YixinConfirm', RaidBuilder:IsYiXinValid(), L['今日已达发送上限'])
    end)
    YiXinButton:Disable()

    local ShareButton = Button:New(self)
    ShareButton:SetPoint('RIGHT', YiXinButton, 'LEFT', -80, 0)
    ShareButton:SetText(L['活动通告'])
    ShareButton:SetIcon([[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]])
    ShareButton:SetIconTexCoord(64/256, 96/256, 0, 1)
    ShareButton:SetTooltip(L['活动通告'])
    ShareButton:Disable()
    ShareButton:SetScript('OnClick', function()
        local content = GroupCache:GetAnnouncementContent()
        if not content then
            return
        end
        RaidBuilder:ShowModule('SharePanel', L['活动通告'], content)
    end)

    local YXHelp = Button:New(self)
    YXHelp:SetPoint('RIGHT', ShareButton, 'LEFT', -130, 0)
    YXHelp:SetText(L['如何关注好团长?'])
    YXHelp:SetIcon([[INTERFACE\ICONS\INV_Misc_QuestionMark]])
    YXHelp:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YiXinSummary')
    end)

    local MemberList = GUI:GetClass('GridView'):New(self)
    MemberList:SetPoint('TOPLEFT')
    MemberList:SetPoint('BOTTOMRIGHT')
    MemberList:SetItemClass(RaidBuilder:GetClass('ModelItem'))
    MemberList:SetSelectMode('NONE')
    MemberList:SetItemSpacing(1)
    MemberList:SetCallback('OnItemFormatted',
        function(MemberList, button, data)
            button:SetSize(MemberList:GetItemWidth(), MemberList:GetItemHeight())
            button:SetUnit(data, self.Shown)
        end)

    MemberList:SetCallback('OnItemMenu',
        function(MemberList, button, data)
            if not data then
                return
            end

            self:ToggleMenu(button, CreateMenuTable(button:GetUnitId()), true)
        end)

    MemberList:SetCallback('OnItemEnter',
        function(MemberList, button, data)
            if not data then
                return
            end

            local member = GroupCache:GetUnitInfo(UnitName(data or 'none'))

            if member then
                MainPanel:OpenWaitTooltip(member)
            end
        end)

    MemberList:SetCallback('OnItemLeave',
        function(MemberList, button, data)
            MainPanel:CloseTooltip()
        end)

    local DisbandGroupButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    DisbandGroupButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 0, 4)
    DisbandGroupButton:SetSize(120, 22)
    DisbandGroupButton:SetText(L['解散活动'])
    DisbandGroupButton:Disable()
    DisbandGroupButton:SetScript('OnClick',
        function(DisbandGroupButton)
            GUI:CallMessageDialog(L['你确定要解散这个活动？'], function(result)
                if result then
                    Logic:DisbandEvent()
                    DisbandGroupButton:Disable()
                end
            end)
        end)

    local GroupInfo = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    GroupInfo:SetPoint('BOTTOMRIGHT', self:GetOwner(), -7, 7)
    GroupInfo:SetWidth(200)

    if IsAddOnLoaded('WowSocial') then
        DisbandGroupButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', -65, 4)

        local InviteChatGroupButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
        InviteChatGroupButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 65, 4)
        InviteChatGroupButton:SetSize(120, 22)
        InviteChatGroupButton:SetText(L['批量邀请入群'])
        InviteChatGroupButton:Disable()
        InviteChatGroupButton:SetScript('OnClick',
            function(InviteChatGroupButton)
                local chatGroupList = GetOwnChatGroupList(UnitFullName('player'))
                local memberList = self.MemberList:GetItemList()
                local menuTable = {}
                for i, v in ipairs(chatGroupList) do
                    tinsert(menuTable, {
                            text = v.text,
                            value = v.target,
                            disabled = function()
                                return #memberList == 1
                            end,
                            func = function(button, data)
                                for i, v in ipairs(memberList) do
                                    local fullName = UnitFullName(v)
                                    if UnitIsPlayer(v) and Invite:IsSameRealm(fullName) and not UnitIsUnit(v, 'player') then
                                        InviteChatGroup(data.value, fullName)
                                    end
                                end
                                self:SetInviteButtonStatus(false)
                                self:ScheduleTimer(function()
                                    self:SetInviteButtonStatus(true)
                                    end, 60)
                            end,
                        })
                end
                self:ToggleMenu(InviteChatGroupButton, menuTable)
            end)
        self.InviteChatGroupButton = InviteChatGroupButton
    end

    self.ShareButton = ShareButton
    self.YiXinButton = YiXinButton
    self.TitleLabel = TitleLabel
    self.DisbandGroupButton = DisbandGroupButton
    self.GroupInfo = GroupInfo
    self.MemberList = MemberList
    self.Size = {x = self:GetWidth(), y = self:GetHeight()}

    self:RegisterBucketEvent({'PLAYER_LOGIN', 'GROUP_ROSTER_UPDATE'}, 1, 'UpdateGroup')
    self:RegisterEvent('RAID_TARGET_UPDATE', 'UpdateRaidTarget')
    self:RegisterMessage('RAIDBUILDER_CURRENT_EVENT_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_UNIT_INFO_UPDATE', 'UpdateGroup')
    self:ScheduleRepeatingTimer('OnTimer', 5)
end

function CurrentPanel:RAIDBUILDER_UNIT_INFO_UPDATE()
    self:UpdateGroupItemLevel()
    self:UpdateMemberRole()
end

-- 横转纵
local function H2V(t, row)
    local result = {}
    local m = math.ceil(#t/row)
    local index = 1

    for i = 1, row do
        for j = 1, m do
            index = j == 1 and i or index + row
            tinsert(result, t[index] or false)
        end
    end

    return result
end

function CurrentPanel:SetList(list)
    local num = #list
    local MemberList = self.MemberList
    local size = self.Size

    if num < 11 then
        if num < 6 then
            MemberList:SetItemHeight(size.y)
            MemberList:SetRowCount(1)
        else
            MemberList:SetItemHeight(size.y / 2)
            MemberList:SetRowCount(2)
        end
        MemberList:SetItemWidth(size.x / num)
        MemberList:SetColumnCount(5)
        self.Shown = true
    else
        local column = math.ceil(num / 5)
        MemberList:SetItemWidth(size.x / column)
        MemberList:SetItemHeight(size.y / 5)
        MemberList:SetRowCount(5)
        MemberList:SetColumnCount(column)
        self.Shown = false
        list = H2V(list, 5)
    end

    MemberList:SetItemList(list)
    MemberList:UpdateLayout()
    MemberList:Refresh()
end

function CurrentPanel:GetList()
    return self.MemberList:GetItemList()
end

function CurrentPanel:UpdateGroup()
    local list = GetGroupUnitList()
    local m = GetNumGroupMembers()
    m = m == 0 and 1 or m
    local result = {}

    for i = 1, m do
        local v = list[i]
        if UnitIsGroupLeader(v) then
            tinsert(result, 1, v)
        elseif UnitIsUnit(v, 'player') then
            tinsert(result, i == 1 and 1 or 2, v)
        else
            tinsert(result, v)
        end
    end

    self.TotalMember = m
    self:SetList(result)
    self:UpdateMemberRole()
    self:UpdateGroupItemLevel()
end

function CurrentPanel:UpdateGroupItemLevel()
    local list = self:GetList()

    if not list then
        return
    end

    local total, count = 0, 0

    for i, v in ipairs(list) do
        local unit = v and GroupCache:GetUnitInfo(UnitName(v))
        if unit then
            count = count + 1
            total = total + unit:GetItemLevel()
        end
    end

    self.GroupInfo:SetFormattedText(L['共|cffffd100%d|r名成员，平均装等|cffffd100%s|r'], self.TotalMember, count ~= 0 and floor(total/count) or L['暂无'])
end

function CurrentPanel:UpdateMemberRole()
    local roles = {}

    for i, unit in ipairs(GetGroupUnitList()) do
        if UnitExists(unit) then
            local role = GroupCache:GetUnitRole(UnitName(unit)) or UnitGroupRolesAssigned(unit) or 'NONE'

            roles[role] = (roles[role] or 0) + 1
        end
    end

    for role, v in pairs(self.Roles) do
        v.Label:SetText(roles[role] or 0)
    end
end

function CurrentPanel:OnTimer()
    local MemberList = self.MemberList
    local num = MemberList:GetItemList() and #MemberList:GetItemList()
    if MemberList:GetItemList() and num > 1 then
        MemberList:Refresh()
    end
end

function CurrentPanel:UpdateRaidTarget()
    self.MemberList:Refresh()
end

function CurrentPanel:GetCurrentTitle()
    return GroupCache:GetCurrentEventName()
end

function CurrentPanel:RefreshButton()
    local event = EventCache:GetCurrentEvent()
    local eventCode = GroupCache:GetCurrentEventCode()
    self.DisbandGroupButton:SetEnabled(event)
    self.YiXinButton:SetEnabled(event)
    self.ShareButton:SetEnabled(eventCode)
    self.TitleLabel:SetText(self:GetCurrentTitle())

    if self.InviteChatGroupButton then
        self.InviteChatGroupButton:SetEnabled(#GetOwnChatGroupList(UnitFullName('player')) > 0 and not self:GetInviteButtonStatus())
    end
end

function CurrentPanel:SetInviteButtonStatus(flag)
    self.inviteButtonStatus = not flag
    self.InviteChatGroupButton:SetEnabled(flag)
end

function CurrentPanel:GetInviteButtonStatus()
    return self.inviteButtonStatus
end
