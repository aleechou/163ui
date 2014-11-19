
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
    local name = UnitName(unit)
    local role = GroupCache:GetUnitRole(name) or UnitGroupRolesAssigned(unit) or 'NONE'
    local playerIsLeader = UnitIsGroupLeader('player')
    local isCanSetRole = playerIsLeader and not InCombatLockdown() and UnitInGroup(unit)
    local isPlayer = UnitIsUnit('player', unit)
    local unitInfo = GroupCache:GetUnitInfo(name)
    local unitBtag = unitInfo and unitInfo:GetBattleTag()

    local T, H, D
    if isCanSetRole then
        T, H, D = UnitGetAvailableRoles(unit)
    end

    local menuTable =
        {
            {
                text = name,
                isTitle = true,
            },
            {
                text = SEND_BATTLETAG_REQUEST,
                disabled = isPlayer or not UnitIsConnected(unit),
                func = function()
                    BNCheckBattleTagInviteToUnit(unit)
                end,
            },
            {
                text = WHISPER,
                disabled = isPlayer,
                func = function()
                    ChatFrame_SendTell(name, ChatFrame1)
                end,
            },
            {
                text = INSPECT,
                disabled = isPlayer,
                func = function()
                    InspectUnit(unit)
                end,
            },
            {
                text = PARTY_UNINVITE,
                disabled = not playerIsLeader or isPlayer,
                func = function(button)
                    UninviteUnit(unit)
                end,
            },
            {
                text = RAID_TARGET_ICON,
                hasArrow = true,
                disabled = not playerIsLeader,
                menuTable = raidTargetItem,
            },
            {
                text = L['设置集合石职责'],
                hasArrow = true,
                disabled = not UnitInGroup(unit) or not playerIsLeader,
                menuTable =
                {
                    {
                        text = INLINE_TANK_ICON..' '..TANK,
                        checkable = true,
                        checked = function()
                            return _UnitGetRole(unit) == 'TANK'
                        end,
                        disabled = not isCanSetRole or not T,
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
                        disabled = not isCanSetRole or not H,
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
                        disabled = not isCanSetRole or not D,
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
                disabled = isPlayer or not unitBtag,
                func = function()
                    BlackListPanel:Add(unitBtag)
                end,
            },
            {
                text = L['添加关注'],
                disabled = function(data, button)
                    local member = GroupCache:GetUnitInfo(UnitName(unit))
                    return not member or not member:GetBattleTag() or UnitIsUnit('player', unit)
                end,
                func = function()
                    local member = GroupCache:GetUnitInfo(UnitName(unit))
                    if member then
                        FavoritePanel:Add(member:GetBattleTag())
                    end
                end
            },
            {
                text = CANCEL,
            },
        }

    -- if IsAddOnLoaded('WowSocial') then
    --     local chatGroupList = GetOwnChatGroupList(UnitFullName('player'))
    --     if #chatGroupList > 0 then
    --         local menu = {
    --             text = L['|cff33ff99邀请入群|r'],
    --             hasArrow = true,
    --             disabled = isPlayer,
    --             menuTable = {},
    --         }
    --         for i, v in ipairs(chatGroupList) do
    --             tinsert(menu.menuTable, {
    --                     text = v.text,
    --                     value = v.target,
    --                     disabled = isPlayer,
    --                     func = function(button, data)
    --                         InviteChatGroup(data.value, UnitFullName(unit))
    --                     end,
    --                 })
    --         end
    --         tinsert(menuTable, #menuTable - 2, menu)
    --     end
    -- end

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
    YiXinButton:SetPoint('TOPRIGHT', self:GetOwner(), 'TOPRIGHT', -94, -30)
    YiXinButton:SetText(L['易信推送'])
    YiXinButton:SetIcon([[Interface\AddOns\RaidBuilder\Media\YiXin]])
    YiXinButton:SetTooltip(
        L['易信推送'],
        L['你每天有3次机会向关注你的玩家发送活动通知。']
    )
    YiXinButton:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YixinConfirm', Profile:IsYiXinValid(), L['今日已达发送上限'])
    end)
    YiXinButton:Disable()

    local ShareButton = Button:New(self)
    ShareButton:SetPoint('RIGHT', YiXinButton, 'LEFT', -80, 0)
    ShareButton:SetText(L['活动通告'])
    ShareButton:SetIcon([[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]])
    ShareButton:SetIconTexCoord(64/256, 96/256, 0, 0.5)
    ShareButton:SetTooltip(L['活动通告'])
    ShareButton:Disable()
    ShareButton:SetScript('OnClick', function()
        local content = GroupCache:GetAnnouncementContent()
        if not content then
            return
        end
        RaidBuilder:ShowModule('SharePanel', L['活动通告'], content)
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
    DisbandGroupButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', -60, 4)
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

    local RestoreButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    RestoreButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 60, 4)
    RestoreButton:SetSize(120, 22)
    RestoreButton:SetText(L['暂停招募'])
    RestoreButton:SetScript('OnClick', function()
        Logic:ToggleEventStatus()
    end)

    local GroupInfo = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    GroupInfo:SetPoint('BOTTOMRIGHT', self:GetOwner(), -7, 7)
    GroupInfo:SetWidth(200)

    -- if IsAddOnLoaded('WowSocial') then
    --     DisbandGroupButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', -65, 4)

    --     local InviteChatGroupButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    --     InviteChatGroupButton:SetPoint('BOTTOM', self:GetOwner(), 'BOTTOM', 65, 4)
    --     InviteChatGroupButton:SetSize(120, 22)
    --     InviteChatGroupButton:SetText(L['批量邀请入群'])
    --     InviteChatGroupButton:Disable()
    --     InviteChatGroupButton:SetScript('OnClick',
    --         function(InviteChatGroupButton)
    --             local chatGroupList = GetOwnChatGroupList(UnitFullName('player'))
    --             local memberList = self.MemberList:GetItemList()
    --             local menuTable = {}
    --             for i, v in ipairs(chatGroupList) do
    --                 tinsert(menuTable, {
    --                         text = v.text,
    --                         value = v.target,
    --                         disabled = function()
    --                             return #memberList == 1
    --                         end,
    --                         func = function(button, data)
    --                             for i, v in ipairs(memberList) do
    --                                 local fullName = UnitFullName(v)
    --                                 if UnitIsPlayer(v) and Invite:IsSameRealm(fullName) and not UnitIsUnit(v, 'player') then
    --                                     InviteChatGroup(data.value, fullName)
    --                                 end
    --                             end
    --                             self:SetInviteButtonStatus(false)
    --                             self:ScheduleTimer(function()
    --                                 self:SetInviteButtonStatus(true)
    --                                 end, 60)
    --                         end,
    --                     })
    --             end
    --             self:ToggleMenu(InviteChatGroupButton, menuTable)
    --         end)
    --     self.InviteChatGroupButton = InviteChatGroupButton
    -- end

    local RulesPanel = CreateFrame('ScrollFrame', nil, self)
    RulesPanel:SetPoint('TOPRIGHT', MemberList, 7, 8)
    RulesPanel:SetSize(265, 0)
    RulesPanel:SetFrameLevel(MemberList:GetFrameLevel() + 10)

    local function ToggleRulesPanel()
        if RulesPanel:GetScript('OnUpdate') then
            return
        end
        local isShow = not (RulesPanel:GetHeight() > 0)
        local x = 0.01
        RulesPanel:SetScript('OnUpdate', function(self, elapsed)
            if x > 0 then
                x = x - elapsed
                return
            end
            x = 0.01
            if isShow then
                if self:GetHeight() < 320 then
                    self:SetHeight(self:GetHeight() + 32)
                else
                    self:SetScript('OnUpdate', nil)
                end
            else
                if self:GetHeight() > 0 then
                    self:SetHeight(self:GetHeight() - 32)
                else
                    self:SetScript('OnUpdate', nil)
                end
            end
        end)
    end

    local RulesChild = CreateFrame('Frame', nil, RulesPanel)
    RulesChild:SetAllPoints(true)
    RulesChild:SetSize(265, 320)
    RulesPanel:SetScrollChild(RulesChild)

    local RulesChildTexture = RulesChild:CreateTexture(nil, 'BACKGROUND')
    RulesChildTexture:SetTexture([[INTERFACE\BarberShop\UI-BARBERSHOP]])
    RulesChildTexture:SetTexCoord(0, 0.517578125, 0, 0.625)
    RulesChildTexture:SetAllPoints(true)

    local RulesCloseButton = CreateFrame('Button', nil, RulesChild)
    RulesCloseButton:SetNormalTexture([[Interface\AddOns\RaidBuilder\Media\RaidbuilderIcons]])
    RulesCloseButton:GetNormalTexture():SetTexCoord(192/256, 224/256, 0.5, 1)
    RulesCloseButton:SetHighlightTexture([[INTERFACE\Challenges\challenges-metalglow]], 'ADD')
    RulesCloseButton:GetHighlightTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
    RulesCloseButton:SetPoint('TOPRIGHT', -30, -40)
    RulesCloseButton:SetSize(32, 32)
    RulesCloseButton:SetScript('OnClick', ToggleRulesPanel)

    local RulesTextPanel = GUI:GetClass('ScrollFrame'):New(RulesChild)
    RulesTextPanel:SetPoint('TOPLEFT', 60, -80)
    RulesTextPanel:SetSize(197, 160)
    local RulesTextChild = CreateFrame('Frame', nil, RulesTextPanel)
    RulesTextChild:SetPoint('TOPLEFT')
    RulesTextChild:SetSize(150, 160)
    RulesTextPanel:SetScrollChild(RulesTextChild)
    local RulesText = GUI:GetClass('SummaryHtml'):New(RulesTextChild)
    RulesText:SetPoint('TOPLEFT')
    RulesText:SetSize(150, 160)

    local RulesButton = Button:New(self)
    RulesButton:SetIcon([[INTERFACE\ICONS\INV_MISC_NOTE_02]])
    RulesButton:SetPoint('RIGHT', ShareButton, 'LEFT', -80, 0)
    RulesButton:SetText(L['详细介绍'])
    RulesButton:SetTooltip(L['暂无详细介绍'])
    RulesButton:Disable()
    RulesButton:SetScript('OnClick', ToggleRulesPanel)

    self.ShareButton = ShareButton
    self.YiXinButton = YiXinButton
    self.TitleLabel = TitleLabel
    self.DisbandGroupButton = DisbandGroupButton
    self.GroupInfo = GroupInfo
    self.MemberList = MemberList
    self.RulesText = RulesText
    self.RulesButton = RulesButton
    self.Size = {x = self:GetWidth(), y = self:GetHeight()}
    self.RestoreButton = RestoreButton

    self:RegisterBucketEvent('GROUP_ROSTER_UPDATE', 1, 'UpdateGroup')
    self:RegisterEvent('RAID_TARGET_UPDATE', 'UpdateRaidTarget')
    self:RegisterMessage('RAIDBUILDER_CURRENT_EVENT_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_EVENT_LOCK_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_EVENT_LOCK_STATUS_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_UNIT_INFO_UPDATE', 'UpdateGroup')
    self:RegisterMessage('RAIDBUILDER_CURRENT_EVENT_RULES_UPDATE', 'UpdateRules')
    self:ScheduleRepeatingTimer('OnTimer', 5)

    self:SetScript('OnShow', self.RefreshButton)
end

function CurrentPanel:OnEnable()
    self:ScheduleTimer('UpdateGroup', 1)
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
    local paused = EventCache:IsCurrentEventPaused()
    local eventCode = GroupCache:GetCurrentEventCode()
    self.DisbandGroupButton:SetEnabled(event)
    self.YiXinButton:SetEnabled(event and not paused)
    self.ShareButton:SetEnabled(eventCode and not paused)
    self.TitleLabel:SetText(self:GetCurrentTitle())

    -- if self.InviteChatGroupButton then
    --     self.InviteChatGroupButton:SetEnabled(#GetOwnChatGroupList(UnitFullName('player')) > 0 and not self:GetInviteButtonStatus())
    -- end

    if event then
        self.RestoreButton:SetText(paused and L['恢复招募'] or L['暂停招募'])
        self.RestoreButton:SetEnabled(not Logic:IsEventStatusLockdown() and not event:IsMemberFull())
    else
        self.RestoreButton:Disable()
        self.RestoreButton:SetText(L['暂无活动'])
    end

    self:UpdateRules()
end

-- function CurrentPanel:SetInviteButtonStatus(flag)
--     self.inviteButtonStatus = not flag
--     self.InviteChatGroupButton:SetEnabled(flag)
-- end

function CurrentPanel:GetInviteButtonStatus()
    return self.inviteButtonStatus
end

function CurrentPanel:SetRulesText(text)
    self.RulesText:SetText(text:gsub('(%a[%w+.-]+://%S+)', '|Hurl:%1|h|cff00ffff[%1]|r|h'))
end

function CurrentPanel:UpdateRules()
    local event = GroupCache:GetCurrentEventCode()
    local rules = GroupCache:GetCurrentEventRules()

    local isEnable = event and rules and rules ~= ''
    self.RulesButton:SetEnabled(isEnable)
    self.RulesButton:SetTooltip(isEnable and L['点击查看详细介绍'] or L['暂无详细介绍'])
    if isEnable then
        self:SetRulesText(rules)
    end
end
