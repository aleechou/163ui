
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
            button:SetRaidTargetIcon(i)
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
        button:SetRaidTargetIcon(0)
    end})

local function CreateMenuTable()

    local menuTable = 
        {
            {
                text = function(button)
                    return UnitName(button:GetUnitId())
                end,
                isTitle = true,
            },
            {
                text = WHISPER,
                disabled = function(data, button)
                    return UnitIsUnit('player', button:GetUnitId())
                end,
                func = function(button)
                    ChatFrame_SendTell(UnitName(button:GetUnitId()), ChatFrame1)
                end,
            },
            {
                text = INSPECT,
                disabled = function(data, button)
                    return UnitIsUnit('player', button:GetUnitId())
                end,
                func = function(button)
                    InspectUnit(button:GetUnitId())
                end,
            },
            {
                text = PARTY_UNINVITE,
                disabled = function(data, button)
                    return not UnitIsGroupLeader('player') or UnitIsUnit('player', button:GetUnitId())
                end,
                func = function(button)
                    UninviteUnit(button:GetUnitId())
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
                text = SET_ROLE,
                hasArrow = true,
                disabled = function(data, button)
                    return (not UnitInRaid(button:GetUnitId()) and not UnitInParty(button:GetUnitId())) or not UnitIsGroupLeader('player')
                end,
                menuTable =
                {
                    {
                        text = INLINE_TANK_ICON..' '..TANK,
                        checkable = true,
                        checked = function(data, button)
                            return UnitGroupRolesAssigned(button:GetUnitId()) == 'TANK'
                        end,
                        disabled = function(data, button)
                            return not UnitGetAvailableRoles(button:GetUnitId()) or InCombatLockdown() or (not UnitInRaid(button:GetUnitId()) and not UnitInParty(button:GetUnitId())) or not UnitIsGroupLeader('player')
                        end,
                        func = function(button)
                            -- MemberCache:SetMemberRole(button:GetName(), 'TANK')
                            UnitSetRole(button:GetUnitId(), 'TANK')
                        end,
                    },
                    {
                        text = INLINE_HEALER_ICON..' '..HEALER,
                        checkable = true,
                        checked = function(data, button)
                            return UnitGroupRolesAssigned(button:GetUnitId()) == 'HEALER'
                        end,
                        disabled = function(data, button)
                            return not select(2, UnitGetAvailableRoles(button:GetUnitId())) or InCombatLockdown() or (not UnitInRaid(button:GetUnitId()) and not UnitInParty(button:GetUnitId())) or not UnitIsGroupLeader('player')
                        end,
                        func = function(button)
                            -- MemberCache:SetMemberRole(button:GetName(), 'HEALER')
                            UnitSetRole(button:GetUnitId(), 'HEALER')
                        end,
                    },
                    {
                        text = INLINE_DAMAGER_ICON..' '..DAMAGER,
                        checkable = true,
                        checked = function(data, button)
                            return UnitGroupRolesAssigned(button:GetUnitId()) == 'DAMAGER'
                        end,
                        disabled = function(data, button)
                            return not select(3, UnitGetAvailableRoles(button:GetUnitId())) or InCombatLockdown() or (not UnitInRaid(button:GetUnitId()) and not UnitInParty(button:GetUnitId())) or not UnitIsGroupLeader('player')
                        end,
                        func = function(button)
                            -- MemberCache:SetMemberRole(button:GetName(), 'DAMAGER')
                            UnitSetRole(button:GetUnitId(), 'DAMAGER')
                        end,
                    },
                    {
                        text = '|TInterface\\AddOns\\RaidBuilder\\Media\\RoleNone:16:16:0:0:64:64:0:38:0.5:40|t ' .. L['其他'],
                        checkable = true,
                        checked = function(data, button)
                            return UnitGroupRolesAssigned(button:GetUnitId()) == 'NONE'
                        end,
                        disabled = function(data, button)
                            return InCombatLockdown() or (not UnitInRaid(button:GetUnitId()) and not UnitInParty(button:GetUnitId())) or not UnitIsGroupLeader('player')
                        end,
                        func = function(button)
                            -- MemberCache:SetMemberRole(button:GetName(), 'NONE')
                            UnitSetRole(button:GetUnitId(), 'NONE')
                        end,
                    },
                },
            },
            {
                text = L['加入黑名单'],
                disabled = function(data, button)
                    local unit = GroupCache:GetUnitInfo(UnitName(button:GetUnitId()))
                    return not unit or not unit:GetBattleTag() or UnitIsUnit('player', button:GetUnitId())
                end,
                func = function(button)
                    local unit = GroupCache:GetUnitInfo(UnitName(button:GetUnitId()))
                    if unit then
                        BlackListPanel:Add(unit:GetBattleTag())
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
                    return UnitIsUnit(button:GetUnitId(), 'player')
                end,
                menuTable = {},
            }
            for i, v in ipairs(chatGroupList) do
                tinsert(menu.menuTable, {
                        text = v.text,
                        value = v.target,
                        disabled = function(data, button)
                            return UnitIsUnit(button:GetUnitId(), 'player')
                        end,
                        func = function(button, data)
                            InviteChatGroup(data.value, UnitFullName(button:GetUnitId()))
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

    local YiXinButton = CreateFrame('Button', nil, self)
    YiXinButton:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -80, 20)
    YiXinButton:SetSize(36, 36)
    YiXinButton:SetHighlightTexture([[INTERFACE\BUTTONS\ButtonHilight-Square]], 'ADD')
    YiXinButton:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
    }
    YiXinButton:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.8)
    YiXinButton:SetMotionScriptsWhileDisabled(true)
    local YiXinButtonText = YiXinButton:CreateFontString(nil, 'OVERLAY')
    YiXinButtonText:SetPoint('LEFT', YiXinButton, 'RIGHT', 5, 0)
    YiXinButton:SetFontString(YiXinButtonText)
    YiXinButton:SetNormalFontObject('GameFontNormalSmallLeft')
    YiXinButton:SetHighlightFontObject('GameFontHighlightSmallLeft')
    YiXinButton:SetDisabledFontObject('GameFontDisableSmallLeft')
    YiXinButton:SetText(L['易信推送'])
    YiXinButton:SetHitRectInsets(0, - YiXinButtonText:GetWidth(), 0, 0)
    
    local texture = YiXinButton:CreateTexture(nil, 'BACKGROUND')
    texture:SetTexture([[Interface\AddOns\RaidBuilder\Media\YiXin]])
    texture:SetPoint('TOPLEFT', 3, -3)
    texture:SetPoint('BOTTOMRIGHT', -3, 3)

    GUI:SetTooltip(YiXinButton,
        L['易信通知'],
        L['你每天有3次机会向关注你的玩家发送活动通知。']
    )

    local function onStatusChanged()
        texture:SetDesaturated(not YiXinButton:IsEnabled())
    end
    YiXinButton:SetScript('OnEnable', onStatusChanged)
    YiXinButton:SetScript('OnDisable', onStatusChanged)
    YiXinButton:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YixinConfirm', RaidBuilder:IsYiXinValid(), L['今日已达发送上限'])
    end)
    YiXinButton:Disable()

    local YXHelp = CreateFrame('Button', nil, self)
    YXHelp:SetPoint('RIGHT', YiXinButton, 'LEFT', -170, 0)
    local YXHelpText = YXHelp:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    YXHelpText:SetPoint('LEFT', YXHelp, 'RIGHT')
    YXHelp:SetFontString(YXHelpText)
    YXHelp:SetText(L['如何关注好团长?'])
    YXHelp:SetSize(32, 32)
    YXHelp:SetHitRectInsets(0, -YXHelp:GetTextWidth(), 0, 0)
    YXHelp:SetNormalFontObject('GameFontNormalSmall')
    YXHelp:SetHighlightFontObject('GameFontHighlightSmall')
    YXHelp:SetDisabledFontObject('GameFontDisableSmall')
    YXHelp:SetNormalTexture([[INTERFACE\GossipFrame\ActiveLegendaryQuestIcon]])
    YXHelp:SetPushedTexture([[INTERFACE\GossipFrame\ActiveLegendaryQuestIcon]]) -- [[INTERFACE\Calendar\EventNotification]]
    -- YXHelp:GetPushedTexture():ClearAllPoints()
    -- YXHelp:GetPushedTexture():SetPoint('CENTER', 1, -1)
    -- YXHelp:GetPushedTexture():SetSize(32, 32)
    YXHelp:SetHighlightTexture([[INTERFACE\BUTTONS\UI-Panel-MinimizeButton-Highlight]], 'ADD')
    -- YXHelp:GetHighlightTexture():ClearAllPoints()
    -- YXHelp:GetHighlightTexture():SetPoint('CENTER', -5, 2)
    YXHelp:SetScript('OnClick', function()
        RaidBuilder:ShowModule('YixinSummary')
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

            self:ToggleMenu(button, CreateMenuTable(), true)
        end)

    MemberList:SetCallback('OnItemEnter',
        function(MemberList, button, data)
            if not data then
                return
            end

            local member = GroupCache:GetUnitInfo(UnitName(data or 'none'))

            if member then
                self:OpenWaitTooltip(member)
            end
        end)

    MemberList:SetCallback('OnItemLeave',
        function(MemberList, button, data)
            self:CloseWaitTooltip()
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

    self.YiXinButton = YiXinButton
    self.TitleLabel = TitleLabel
    self.DisbandGroupButton = DisbandGroupButton
    self.GroupInfo = GroupInfo
    self.MemberList = MemberList
    self.Size = {x = self:GetWidth(), y = self:GetHeight()}

    self:RegisterBucketEvent({'PLAYER_LOGIN', 'GROUP_ROSTER_UPDATE'}, 1, 'UpdateGroup')
    self:RegisterEvent('RAID_TARGET_UPDATE', 'UpdateRaidTarget')
    self:RegisterMessage('RAIDBUILDER_CURRENTEVENT_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_EVENT_LIST_UPDATE', 'RefreshButton')
    self:RegisterMessage('RAIDBUILDER_UNIT_INFO_UPDATE', 'UpdateGroupItemLevel')
    self:ScheduleRepeatingTimer('OnTimer', 5)
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
    -- self:SetGroupItemLevel(result)
    self:UpdateMemberRole()
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
    for _, unit in ipairs(GetGroupUnitList()) do
        if UnitExists(unit) then
            local role = UnitGroupRolesAssigned(unit)
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
    self.DisbandGroupButton:SetEnabled(EventCache:GetCurrentEvent())
    self.YiXinButton:SetEnabled(EventCache:GetCurrentEvent())
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

function CurrentPanel:OpenWaitTooltip(member)
    WaitPanel:OpenWaitTooltip(member)
end

function CurrentPanel:CloseWaitTooltip()
    GameTooltip:Hide()
end

-- -- 取itemlink
-- local getLink = CreateFrame('GameTooltip', 'RaidBuilderCurrentPanelGetLink', UIParent, 'GameTooltipTemplate')
-- local function GetItemLink(unitId, slotId)
--     getLink:SetOwner(WorldFrame)
--     getLink:SetInventoryItem(unitId, slotId)
--     local _, link = getLink:GetItem()
--     getLink:Hide()
--     return link
-- end

-- -- 根据GUID取队员unitId
-- local function GetUnitByGUID(unitGUID)
--     if UnitGUID('player') == unitGUID then
--         return 'player'
--     end
--     for i = 1, 4 do
--         if UnitGUID('party'..i) == unitGUID then return 'party'..i end
--     end
--     for i = 1, 40 do
--         if UnitGUID('raid'..i) == unitGUID then return 'raid'..i end
--     end
-- end

-- -- 装备升级次数对照表
-- local levelAdjust={ -- 11th item:id field and level adjustment
--    [0]		=	0,	-- 0
--    [1]		=	8,	-- 1/1
--    [373]	=	4,	-- 1/2
--    [374]	=	8,	-- 2/2
--    [375]	=	4,	-- 1/3
--    [376]	=	4,	-- 2/3
--    [377]	=	4,	-- 3/3
--    [379]	=	4,	-- 1/2
--    [380]	=	4,	-- 2/2
--    [445]	=	0,	-- 0/2
--    [446]	=	4,	-- 1/2
--    [447]	=	8,	-- 2/2
--    [451]	=	0,	-- 0/1
--    [452]	=	8,	-- 1/1
--    [453]	=	0,	-- 0/2
--    [454]	=	4,	-- 1/2
--    [455]	=	8,	-- 2/2
--    [456]	=	0,	-- 0/1
--    [457]	=	8,	-- 1/1
--    [458]	=	0,	-- 0/4
--    [459]	=	4,	-- 1/4
--    [460]	=	8,	-- 2/4
--    [461]	=	12,	-- 3/4
--    [462]	=	16,	-- 4/4
--    [465]	=	0,	-- 0/2
--    [468]	=	0,	-- 0/2
--    [470]	=	8,	-- 2/4
--    [471]	=	12,	-- 3/4
--    [472]	=	16,	-- 4/4
--    [476]	=	0,	-- 0/4
--    [477]	=	4,	-- 1/4
--    [478]	=	8,	-- 2/4
--    [479]	=	0,	-- 0/4
--    [480]	=	8,	-- 2/4
--    [491]	=	0,	-- 0/4
--    [492]	=	4,	-- 1/4
--    [493]	=	8,	-- 2/4
--    [494]	=	0,	-- 0/4
--    [495]	=	4,	-- 1/4
--    [496]	=	8,	-- 2/4
--    [497]	=	12,	-- 3/4
--    [498]	=	16,	-- 4/4
-- }

-- -- 取装备真实等级
-- local function HGetItemLevel(link)
--     local baseLevel = select(4, GetItemInfo(link)) or 0
--     local upgrade = tonumber(string.match(link, ':(%d+)\124h%['))
--     return baseLevel + (levelAdjust[upgrade] or 0)
-- end

-- -- 计算table内数字和
-- local function TableSum(table)
--     local retVal = 0

--     for _, n in ipairs(table) do
--         retVal = retVal + n
--     end

--     return retVal
-- end

-- -- 取队员装等
-- local function GetUnitItemLevelGUID(unitGUID)
--     local unit = GetUnitByGUID(unitGUID)
--     local totaliLevel, totalItem = 0, 15

--     if unit then
--         for i = 1, 17 do
--             if i ~= 4 then
--                 local link = GetItemLink(unit, i)

--                 if link then
--                     if i == 17 then
--                         totalItem = totalItem + 1
--                     end

--                     local itemLevel = HGetItemLevel(link)

--                     if itemLevel > 0 then
--                         totaliLevel = totaliLevel + itemLevel
--                     end
--                 end
--             end
--         end
--     end

--     return floor(totaliLevel/totalItem)
-- end

-- -- 使用INSPECT_READY事件获取队员装等
-- function CurrentPanel:SetGroupItemLevel(list)
--     self.itemResult = {}
--     self.itemIndex = 1
--     self.itemTarget = list

--     self:RegisterEvent('INSPECT_READY')
--     NotifyInspect(list[self.itemIndex])
-- end

-- function CurrentPanel:INSPECT_READY(event, guid)
--     local list = self.itemTarget
--     local result = self.itemResult
--     self.itemIndex = self.itemIndex + 1

--     tinsert(self.itemResult, GetUnitItemLevelGUID(guid))

--     if list[self.itemIndex] then
--         NotifyInspect(list[self.itemIndex])
--     else
--         self:UnregisterEvent('INSPECT_READY')
--         self.GroupInfo:SetFormattedText(L['共 %d 名成员，平均装等 %d'], self.TotalMember, TableSum(result)/#result)
--     end
-- end
