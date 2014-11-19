
BuildEnv(...)

Logic = RaidBuilder:NewModule('Logic',
    'NetEaseSocket-2.0',
    'NetEaseSocketRepeater-2.0',
    'AceSerializer-3.0',
    'AceTimer-3.0',
    'AceEvent-3.0',
    'AceBucket-3.0',
    'AceHook-3.0',
    'NetEaseTextFilter-1.0')

function Logic:OnInitialize()
    self:ListenSocket('NERB', 'S1' .. UnitFactionGroup('player'))
    
    self:RegisterSocket('SEJ', 'SOCKET_EVENT_JOIN')
    self:RegisterSocket('SEJT', 'SOCKET_EVENT_JOIN_RESULT')
    self:RegisterSocket('SEL', 'SOCKET_EVENT_LEAVE')
    self:RegisterSocket('SER', 'SOCKET_EVENT_REFUSE')
    self:RegisterSocket('GUI', 'GROUP_UNIT_INFO')

    self:RegisterSocket('WHISPER')
    self:RegisterServer('WHISPER_OFFLINE')
    
    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SERVER_DISCONNECTED', 'ServerConnect')

    self:RegisterServer('CHANNEL_CONNECTED', 'RefreshCurrentEvent')
    self:RegisterServer('CHANNEL_DISCONNECTED', 'ConnectChannel')
    self:RegisterServer('CHANNEL_CONNECT_FAILED')

    self:RegisterServer('SEI', 'SOCKET_EVENT_INFO')
    self:RegisterServer('SED', 'SOCKET_EVENT_DISBAND')
    self:RegisterServer('SWEI', 'SOCKET_WEBEVENT_INFO')
    self:RegisterServer('SDV', 'SOCKET_DATA_VALUE')
    self:RegisterServer('SSM', 'SOCKET_SYSTEM_MESSAGE')
    self:RegisterServer('SARGS', 'SOCKET_ARGS')
    self:RegisterServer('SVERSION', 'SOCKET_VERSION')

    self:RegisterServer('EXCHANGE_RESULT')
    self:RegisterServer('MALLPURCHASE_RESULT')
    self:RegisterServer('MALLQUERY_RESULT')

    self:ServerConnect()

    self:RegisterEvent('GROUP_JOINED')
    self:RegisterEvent('PARTY_INVITE_REQUEST')

    self:SecureHook('DeclineGroup', 'OnInviteReset')
    self:SecureHook('AcceptGroup', 'OnInviteReset')

    self:RegisterBucketEvent('GROUP_ROSTER_UPDATE', 10, 'RefreshCurrentEvent')
    self:RegisterMessage('RAIDBUILDER_EVENT_LOCK_UPDATE', 'RefreshCurrentEvent')
    self:RegisterMessage('RAIDBUILDER_CURRENT_ROLE_UPDATE', 'RefreshCurrentEvent')
end

function Logic:IsRaidBuilderUsable()
    return not IsTrialAccount() and UnitFactionGroup('player') ~= 'Neutral' and not self.isNotSupport
end

function Logic:ServerConnect()
    if self:IsRaidBuilderUsable() then
        self:ConnectServer()
    end
end

function Logic:GetAddonVersion()
    return tonumber(ADDON_VERSION) or 0
end

---- Hook

function Logic:OnInviteReset()
    self:UnregisterEvent('CHAT_MSG_SYSTEM')
    self:SendMessage('RAIDBUILDER_INVITE_RESET')
end

---- Event

function Logic:PARTY_INVITE_REQUEST(_, sender, arg2, arg3, arg4, isXRealm)
    sender = Ambiguate(sender:gsub(' ', ''), 'none')

    local event = EventCache:GetEvent(sender)
    if event and event:IsApplied() then
        local which = isXRealm and 'PARTY_INVITE_XREALM' or 'PARTY_INVITE'
        local dialog = StaticPopup_FindVisible(which)
        if dialog then
            _G[dialog:GetName()..'Text']:SetFormattedText(L['集合石活动 |cffffd100%s|r\n\n'] .. StaticPopupDialogs[which].text, event:GetEventName(), event:GetLeaderText())

            StaticPopup_Resize(dialog, which)
        end
    end

    GroupCache:SetCurrentRole(AppliedCache:GetAppliedRole(sender))
    AppliedCache:DeleteApplied(sender)

    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:SendMessage('RAIDBUILDER_INVITE_REQUEST', sender)
end

local ERR_INVITED_ALREADY_IN_GROUP_MATCH = ERR_INVITED_ALREADY_IN_GROUP_SS:format('(.+)', '(.+)'):gsub('([%[%]])', '%%%1')
function Logic:CHAT_MSG_SYSTEM(_, msg)
    local name = msg:match(ERR_INVITED_ALREADY_IN_GROUP_MATCH)
    if name then
        name = Ambiguate(name, 'none')
        AppliedCache:DeleteApplied(name)
        self:SendMessage('RAIDBUILDER_APPLY_FAILED', name)
    end
end

function Logic:GROUP_JOINED()
    self:LeaveAllEvents()

    if EventCache:GetCurrentEvent() and not EventCache:IsCurrentEventPaused() and (not PlayerIsGroupLeader() or IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
        EventCache:PauseCurrentEvent()
        System:Errorf(L['你创建的活动已被暂停，如需继续活动，请点击|cffffd100小地图按钮右键菜单|r内的|cffffd100%s|r。'], L['恢复招募'])
    end
end

---- Broad

function Logic:CHANNEL_CONNECT_FAILED()
    self:SendServer('SCJF', L.RaidBuilderChannel)
    self:ScheduleTimer('ConnectChannel', 5)
end

---- Socket

function Logic:SERVER_CONNECTED()
    self:SendServer('SLOGIN', self:GetAddonVersion(), UnitGUID('player'), self:GetAddonSource())

    self:SendMessage('RAIDBUILDER_SERVER_CONNECTED')
end

function Logic:SOCKET_VERSION(_, ...)
    self.isNotSupport = not select(3, ...)
    self:SendMessage('RAIDBUILDER_NEW_VERSION', ...)
end

function Logic:SOCKET_DATA_VALUE(_, key, data)
    DataCache:SaveData(key, data)
end

function Logic:SOCKET_EVENT_INFO(_, leader, ...)
    local leader = Ambiguate(leader, 'none')
    if leader and not Profile:IsInBlackList(select(13, ...)) then
        EventCache:CacheEvent(leader, ...)
    end
end

function Logic:SOCKET_WEBEVENT_INFO(_, ...)
    WebEventCache:CacheEvent(...)
end

function Logic:SOCKET_EVENT_DISBAND(_, leader)
    local leader = Ambiguate(leader or sender, 'none')
    if UnitIsUnit(leader, 'player') and EventCache:GetCurrentEvent() then
        return
    end
    EventCache:RemoveEvent(leader)
    AppliedCache:DeleteApplied(leader)
end

function Logic:SOCKET_EVENT_JOIN(_, sender, password, role, battleTag, class, level, itemLevel, pvpRating, progression, raidInfo, msg)
    local event = EventCache:GetCurrentEvent()
    if not event then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_NULL')
        return
    end

    if Profile:IsInBlackList(battleTag) then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_BLOCK')
        return
    end

    if event:GetHasPassword() and event:GetPassword() ~= password then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_PASSWORD')
        return
    end

    if level < 10 and event:GetRoleTotalAll() > 5 then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_LEVEL')
        return
    end

    if level < event:GetMinLevel() or level > event:GetMaxLevel() then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_LEVEL')
        return
    end

    if event:GetForceVerify() and role ~= 'NONE' then
        if itemLevel < event:GetItemLevel() then
            self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_ITEMLEVEL')
            return
        end
        if pvpRating < event:GetPVPRating() then
            self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_PVPRATING')
            return
        end
    end

    if event:IsMemberFull() then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_FULL')
        return
    end

    if event:IsRoleFull(role) then
        self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_ROLEFULL')
        return
    end

    MemberCache:AddMember(sender, role, battleTag, class, level, itemLevel, pvpRating, progression, raidInfo, msg)
    GroupCache:SetUnitRole(sender, role)
    self:SendSocket(sender, 'SEJT')
end

function Logic:SOCKET_EVENT_JOIN_RESULT(_, sender, info)
    if info then
        if info == 'EVENT_ERROR_NULL' then
            EventCache:RemoveEvent(sender)
        end
        AppliedCache:DeleteApplied(sender)
        System:Logf(L['申请加入%s的活动失败，%s'], sender, L[info])
        self:SendMessage('RAIDBUILDER_APPLY_FAILED', sender)
    else
        System:Logf(L['已提交申请加入%s的活动。'], sender)
        AppliedCache:AddApplied(sender, nil, true)
    end
end

function Logic:SOCKET_EVENT_LEAVE(_, sender)
    MemberCache:RemoveMember(sender)
end

function Logic:SOCKET_EVENT_REFUSE(_, sender)
    AppliedCache:DeleteApplied(sender)
    System:Logf(L['%s拒绝了你的活动申请'], sender)
    self:SendMessage('RAIDBUILDER_APPLY_FAILED', sender)
end

function Logic:SOCKET_ARGS(_, fans, socialEnabled)
    RaidBuilder:SetSocialEnabled(socialEnabled)
end

function Logic:GROUP_UNIT_INFO(_, sender, eventCode, battleTag, ...)
    if UnitIsGroupLeader(sender) and not UnitIsUnit('player', sender) then
        GroupCache:SetCurrentEventCode(eventCode, GetFullName(sender))
        GroupCache:SetCurrentEventRules((select(9, ...)))
        Profile:AddFavorite(battleTag)
        Profile:UpdateFavoriteEventCode(battleTag, eventCode)
    end
    if eventCode ~= GroupCache:GetCurrentEventCode() then
        return
    end
    GroupCache:SaveUnitInfo(sender, battleTag, ...)
end

function Logic:SOCKET_SYSTEM_MESSAGE(_, msg)
    SendSystemMessage(msg)
end

---- Methods

local function _GetGroupRoles()
    local roles = {}
    
    for _, unit in ipairs(GetGroupUnitList()) do
        if UnitExists(unit) then
            local role = GroupCache:GetUnitRole(UnitName(unit)) or 'NONE'
            roles[role] = (roles[role] or 0) + 1
        end
    end

    return roles.TANK or 0, roles.HEALER or 0, roles.DAMAGER or 0, roles.NONE or 0
end

function Logic:RefreshCurrentEvent()
    self:CancelTimer(self.refreshTimer)
    local event = EventCache:GetCurrentEvent()
    if event then
        event:SetTimeStamp(time())
        event:SetCurrentMemberRole(_GetGroupRoles())

        if not EventCache:IsCurrentEventPaused() then
            self:SendServer('SEI', event:ToSocket())
        end
        if not EventCache:IsCurrentEventPaused() and event:IsMemberFull() then
            EventCache:PauseCurrentEvent()
            self:SendServer('SED', event:GetCrossRealm())
            System:Logf(L['|cffff0000你创建的活动已满员将暂停招募，如有玩家离队需重新招募，请点击|cffffd100小地图按钮右键菜单|r的|cffffd100%s|r'], L['恢复招募'])
        end
    end
    self.refreshTimer = self:ScheduleTimer('RefreshCurrentEvent', 300)
end

function Logic:GetAddonSource(mark)
    for line in gmatch('\033\033\033\049\054\051\085\073\033\033\033\058\050\058\049\010\066\105\103\070\111\111\116\058\051\058\049\010\068\117\111\119\097\110\058\052\058\048\010\069\108\118\085\073\058\053\058\049', '[^\r\n]+') do
        local n, v, c = line:match('^(.+):(%d+):(%d+)$')
        if IsAddOnLoaded(n) and (not mark or c == '1') then
            return tonumber(v)
        end
    end
end

function Logic:OnPauseTimer()
    self.toggleTimer = nil
    self:SendMessage('RAIDBUILDER_EVENT_LOCK_STATUS_UPDATE')
end

function Logic:ToggleEventStatus()
    if self.toggleTimer then
        return
    end

    if EventCache:IsCurrentEventPaused() then
        EventCache:RestoreCurrentEvent()
        System:Logf(L['已恢复招募']);
    else
        EventCache:PauseCurrentEvent()
        System:Logf(L['已暂停招募']);
        self:SendServer('SED', EventCache:GetCurrentEvent():GetCrossRealm())
    end

    self.toggleTimer = self:ScheduleTimer('OnPauseTimer', 5)
    self:SendMessage('RAIDBUILDER_EVENT_LOCK_STATUS_UPDATE')
end

function Logic:IsEventStatusLockdown()
    return not not self.toggleTimer
end

function Logic:CreateEvent(...)
    local eventCode, eventMode,
          minLevel, maxLevel, itemLevel, pvpRating,
          summary, crossRealm, forceVerify, password, memberRole, eventRules = ...

    local leader = UnitName('player')
    local leaderBattleTag = GetPlayerBattleTag()
    local leaderClass = GetPlayerClass()
    local leaderLevel = UnitLevel('player')
    local leaderItemLevel = GetPlayerItemLevel()
    local leaderProgression = GetPlayerRaidProgression(eventCode)
    local leaderPVPRating = GetPlayerPVPRating(eventCode)
    local leaderRaidInfo = GetPlayerSavedInstance(eventCode)
    local source = self:GetAddonSource(true)

    local event = EventCache:CacheEvent(
        leader,
        ADDON_VERSION_SHORT,
        eventCode,
        eventMode,
        minLevel,
        maxLevel,
        itemLevel,
        pvpRating,
        summary,
        crossRealm,
        forceVerify,
        password and true or false,
        memberRole,
        leaderBattleTag,
        leaderClass,
        leaderLevel,
        leaderItemLevel,
        leaderPVPRating,
        leaderProgression,
        leaderRaidInfo,
        source)
    event:SetRules(eventRules)

    if not event then
        System:Logf(L['创建活动失败 %s'], EVENT_NAMES[eventCode] or '')
        return
    end

    event:SetPassword(password)

    EventCache:RestoreCurrentEvent()
    EventCache:SetCurrentEvent(event)
    Profile:SaveEventProfile(event)
    GroupCache:SaveUnitInfo(
        leader,
        leaderBattleTag,
        leaderClass,
        leaderLevel,
        leaderItemLevel,
        leaderPVPRating,
        leaderProgression,
        nil,
        GroupCache:GetCurrentRole())

    self:RefreshCurrentEvent()

    System:Logf(L['创建/更新活动成功 %s'], event:GetEventName())
    GUI:CallWarningDialog(format(L['创建/更新活动成功 %s'], event:GetEventName()), 1, 'CE')
end

function Logic:DisbandEvent()
    local event = EventCache:GetCurrentEvent()
    if not event then
        return
    end

    local crossRealm = event:GetCrossRealm()

    System:Logf(L['解散活动 %s'], event:GetEventName())
    EventCache:SetCurrentEvent(nil)
    MemberCache:ClearMemberList()

    self:SendServer('SED', crossRealm)
end

function Logic:JoinEvent(event, role, password, msg, isAutoApply)
    local eventCode = event:GetEventCode()
    local leader = event:GetLeader()

    self:SendSocket(leader, 'SEJ', password, role,
        GetPlayerBattleTag(),
        GetPlayerClass(),
        UnitLevel('player'),
        GetPlayerItemLevel(),
        GetPlayerPVPRating(eventCode),
        GetPlayerRaidProgression(eventCode),
        GetPlayerSavedInstance(eventCode),
        self:TextFilter(msg),
        isAutoApply)

    AppliedCache:AddApplied(leader, role, false, isAutoApply)
end

function Logic:LeaveEvent(event)
    self:LeaveEventByLeader(event:GetLeader())
end

function Logic:LeaveEventByLeader(leader)
    self:SendSocket(leader, 'SEL')
    AppliedCache:DeleteApplied(leader)
    System:Logf(L['已取消申请加入%s的活动。'], leader)
end

function Logic:LeaveAllEvents()
    for leader in AppliedCache:IterateAppliedList() do
        self:LeaveEventByLeader(leader)
    end
end

function Logic:AcceptEventMember(member)
    Invite:InviteMember(member:GetName(), member:GetBattleTag())
end

function Logic:RefuseEventMember(member)
    MemberCache:RemoveMember(member:GetName())

    self:SendSocket(member:GetName(), 'SER')
end

function Logic:SendYiXinNotify()
    local event = EventCache:GetCurrentEvent()
    if not event then
        return
    end
    local db = Profile:GetCharacterDB().profile.yiXin
    local resetTime = GetGameDateTime(true)
    local now = GetGameDateTime()
    db.times = db.lastSend < resetTime and now > resetTime and 1 or db.times + 1
    db.lastSend = now
    self:SendServer('SYN', event:GetEventName(), event:GetSummary())
    System:Logf(L['%s 开始推送易信（若超过推送次数上限将无法发送）'], event:GetEventName())
end

function Logic:BroadPlayerInfo()
    local eventCode = GroupCache:GetCurrentEventCode()
    if not eventCode then
        return
    end

    local role = GroupCache:GetCurrentRole() or UnitGroupRolesAssigned('player')
    local class = GetPlayerClass()
    local level = UnitLevel('player')
    local itemLevel = GetPlayerItemLevel()
    local pvpRating = GetPlayerPVPRating(eventCode)
    local progression = GetPlayerRaidProgression(eventCode)
    local battleTag = GetPlayerBattleTag()
    local rules = EventCache:GetCurrentEvent() and UnitIsGroupLeader('player') and GroupCache:GetCurrentEventRules() or nil
    local raidInfo = GetPlayerSavedInstance(eventCode)

    self:SendSocket('@GROUP', 'GUI',
        eventCode,
        battleTag,
        class,
        level,
        itemLevel,
        pvpRating,
        progression,
        raidInfo,
        role,
        rules)
end

function Logic:GetPlayerFans()
    return 0
end

-- function Logic:SignIn(id)
--     if Profile:IsSignIn(id) then
--         return
--     end
--     local btag = GetPlayerBattleTag()
--     self:SendServer('SIGNIN', UnitGUID('player'), btag, id, GetCurrentMapAreaID())
--     Profile:SetSignIn(id)
-- end

-- function Logic:Referenced(target)
--     if not target or target == '' then
--         return
--     end

--     local btag = GetPlayerBattleTag()
--     self:SendServer('REFERENCE', UnitGUID('player'), btag, target, self:GetAddonVersion())
--     Profile:SetReferenced(target)
-- end

function Logic:ReportEvent(input, event)
    self:SendServer('SREPORT', input, event:GetLeaderBattleTag(), event:GetLeader(), event:GetSummary(), self:GetAddonVersion())

    System:Log(L['已成功提交举报信息。'])
end

function Logic:WHISPER(event, from, text)
    MakeChatEvent('CHAT_MSG_WHISPER', text, from:gsub('-', '@'), '', '', nil, 'RAIDBUILDER', 0, 0, nil, nil, 0, nil)
end

function Logic:WHISPER_OFFLINE(event, to)
    SendSystemMessage(format(ERR_CHAT_PLAYER_NOT_FOUND_S, to:gsub('-', '@')))
end

function Logic:Exchange(text)
    if not text or text == '' then
        return
    end

    self:SendServer('EXCHANGE', text, UnitGUID('player'), self:GetAddonVersion())
end

function Logic:EXCHANGE_RESULT(event, ...)
    self:SendMessage('RAIDBUILDER_REWARD_RESULT', ...)
end

function Logic:MallPurchase(id, ok)
    if not id then
        return
    end

    self:SendServer('MALLPURCHASE', id, UnitGUID('player'), self:GetAddonVersion(), ok)
end

function Logic:MALLPURCHASE_RESULT(event, ...)
    self:SendMessage('RAIDBUILDER_MALLPURCHASE_RESULT', ...)
end

function Logic:MallQueryPoint()
    self:SendServer('MALLQUERY', UnitGUID('player'), self:GetAddonVersion())
end

function Logic:MALLQUERY_RESULT(event, ...)
    self:SendMessage('RAIDBUILDER_MALLQUERY_RESULT', ...)
end

function Logic:Statistics(id, ...)
    if not id then
        return
    end

    local pGUID = UnitGUID('player')
    local bTag = GetPlayerBattleTag()
    local pFaction = UnitFactionGroup('player')
    local pLevel = UnitLevel('player')
    local pClass = select(2, UnitClass('player'))

    self:SendServer('STATISTICS', id, pGUID, bTag, pFaction, pLevel, pClass, self:GetAddonVersion(), ...)
end
