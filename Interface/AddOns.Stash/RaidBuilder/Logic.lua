
BuildEnv(...)

Logic = RaidBuilder:NewModule('Logic', 
    'NetEaseBroad-1.0',
    'NetEaseSocket-1.0',
    'NetEaseSocketRepeater-1.0',
    'NetEaseSocketClient-1.0',
    'AceSerializer-3.0',
    'AceTimer-3.0',
    'AceEvent-3.0',
    'AceBucket-3.0')

function Logic:OnInitialize()
    self:RegisterBroad('BROAD_DISCONNECTED', 'BroadConnect')
    self:RegisterBroad('BROAD_CONNECTED', 'RefreshCurrentEvent')

    self:RegisterBroad('BEI', 'BROAD_EVENT_INFO')
    self:RegisterBroad('BED', 'BROAD_EVENT_DISBAND')
    self:RegisterBroad('BWEI', 'BROAD_WEBEVENT_INFO')

    self:RegisterServerBroad('BDV', 'BROAD_DATA_VALUE')
    self:RegisterServerBroad('BSYS', 'BROAD_SYSTEM')

    self:ListenSocket('NERB')
    self:RegisterSocket('SEJ', 'SOCKET_EVENT_JOIN')
    self:RegisterSocket('SEJT', 'SOCKET_EVENT_JOIN_RESULT')
    self:RegisterSocket('SEL', 'SOCKET_EVENT_LEAVE')
    self:RegisterSocket('SER', 'SOCKET_EVENT_REFUSE')
    self:RegisterSocket('GUI', 'GROUP_UNIT_INFO')

    self:RegisterSocket('WHISPER')
    self:RegisterServer('WHISPER_OFFLINE')
    
    self:RegisterServer('SOCKET_DISCONNECTED', 'ServerConnect')
    self:RegisterServer('SOCKET_CONNECTED')
    self:RegisterServer('SEI', 'SOCKET_EVENT_INFO')
    self:RegisterServer('SED', 'SOCKET_EVENT_DISBAND')
    self:RegisterServer('SWEI', 'SOCKET_WEBEVENT_INFO')
    -- self:RegisterServer('SDV', 'SOCKET_DATA_VALUE')
    -- self:RegisterServer('SDH', 'SOCKET_DATA_HASH')
    self:RegisterServer('SVERSION', 'SOCKET_VERSION')
    self:RegisterServer('SARGS', 'SOCKET_ARGS')

    self:RegisterServer('EXCHANGE_RESULT')
    self:RegisterServer('MALLPURCHASE_RESULT')
    self:RegisterServer('MALLQUERY_RESULT')

    self:ServerConnect()
    self:BroadConnect()

    self:RegisterEvent('PARTY_INVITE_REQUEST')
    self:RegisterEvent('GROUP_JOINED')

    self:RegisterBucketEvent('GROUP_ROSTER_UPDATE', 10, 'RefreshCurrentEvent')
    self:RegisterMessage('RAIDBUILDER_EVENT_LOCK_UPDATE', 'RefreshCurrentEvent')
    self:RegisterMessage('RAIDBUILDER_CURRENT_ROLE_UPDATE', 'RefreshCurrentEvent')
end

function Logic:ServerConnect()
    if not IsTrialAccount() then
        self:ConnectServer('NERB', 'S1' .. UnitFactionGroup('player'))
    end
end

function Logic:BroadConnect()
    if not IsTrialAccount() then
        self:ConnectBroad('CHANNEL', L.RaidBuilderChannel)
    end
end

local ADDON_NAME = ...
function Logic:GetAddonVersion()
    local version = GetAddOnMetadata(ADDON_NAME, 'Version')
    return tonumber(version) or 0
end

---- Event

function Logic:PARTY_INVITE_REQUEST(_, sender)
    sender = Ambiguate(sender:gsub('%s+', ''), 'none')

    GroupCache:SetCurrentRole(AppliedCache:GetAppliedRole(sender))
    AppliedCache:DeleteApplied(sender)
end

function Logic:GROUP_JOINED()
    self:LeaveAllEvents()

    if EventCache:GetCurrentEvent() and not EventCache:IsCurrentEventPaused() and not PlayerIsGroupLeader() then
        EventCache:PauseCurrentEvent()
        System:Errorf(L['你创建的活动已被暂停，如需继续活动，请点击|cffffd100小地图按钮右键菜单|r内的|cffffd100%s|r。'], L['恢复招募'])
    end
end

---- Broad

function Logic:BROAD_EVENT_INFO(event, sender, leader, ...)
    local leader = Ambiguate(leader or sender, 'none')
    if leader and not Profile:IsInBlackList(select(13, ...)) then
        EventCache:CacheEvent(leader, ...)
    end
end

function Logic:BROAD_WEBEVENT_INFO(event, sender, ...)
    WebEventCache:CacheEvent(...)
end

function Logic:BROAD_EVENT_DISBAND(event, sender, leader)
    local leader = Ambiguate(leader or sender, 'none')
    if UnitIsUnit(leader, 'player') and EventCache:GetCurrentEvent() then
        return
    end
    EventCache:RemoveEvent(leader)
    AppliedCache:DeleteApplied(leader)
end

function Logic:BROAD_DATA_VALUE(_, _, key, data)
    DataCache:SaveData(key, data)
end

---- Socket

function Logic:SOCKET_VERSION(_, version, url, isCompat)
    self:SendMessage('RAIDBUILDER_NEW_VERSION', version, url, isCompat)
end

function Logic:SOCKET_CONNECTED()
    self:SendServer('SLOGIN', self:GetAddonVersion(), UnitGUID('player'), self:GetAddonSource())
end

-- function Logic:SOCKET_DATA_VALUE(_, ...)
--     self:SendBroadMessage('BDV', ...)
--     self:BROAD_DATA_VALUE(nil, nil, ...)
-- end

function Logic:SOCKET_EVENT_INFO(_, ...)
    self:SendBroadMessage('BEI', ...)
    self:BROAD_EVENT_INFO(nil, nil, ...)
end

function Logic:SOCKET_WEBEVENT_INFO(_, ...)
    self:SendBroadMessage('BWEI', ...)
    self:BROAD_WEBEVENT_INFO(nil, nil, ...)
end

function Logic:SOCKET_EVENT_DISBAND(_, ...)
    self:SendBroadMessage('BED', ...)
    self:BROAD_EVENT_DISBAND(nil, nil, ...)
end

function Logic:SOCKET_EVENT_JOIN(_, sender, password, role, battleTag, class, level, itemLevel, pvpRating, stats, progression, msgId)
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

    if event:GetForceVerify() and role ~= 'NONE' then
        if level < event:GetMinLevel() or level > event:GetMaxLevel() then
            self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_LEVEL')
            return
        end
        if itemLevel < event:GetItemLevel() then
            self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_ITEMLEVEL')
            return
        end
        if pvpRating < event:GetPVPRating() then
            self:SendSocket(sender, 'SEJT', 'EVENT_ERROR_PVPRATING')
            return
        end
    end

    MemberCache:AddMember(sender, role, battleTag, class, level, itemLevel, pvpRating, stats, progression, msgId)
    GroupCache:SetUnitRole(sender, role)
    self:SendSocket(sender, 'SEJT')
end

function Logic:SOCKET_EVENT_JOIN_RESULT(_, sender, info)
    if info then
        if info == 'EVENT_ERROR_NULL' then
            EventCache:RemoveEvent(sender)
        end
        System:Logf(L['申请加入%s的活动失败，%s'], sender, L[info])
        AppliedCache:DeleteApplied(sender)
    else
        System:Logf(L['已提交申请加入%s的活动。'], sender)
        AppliedCache:AddApplied(sender, nil, true)
    end
end

function Logic:SOCKET_EVENT_LEAVE(_, sender)
    MemberCache:RemoveMember(sender)
end

function Logic:SOCKET_EVENT_REFUSE(_, sender)
    AppliedCache:DeleteApplied(sender, nil)

    System:Logf(L['%s拒绝了你的活动申请'], sender)
end

-- function Logic:SOCKET_DATA_HASH(_, key, hash)
--     DataCache:SaveHash(key, hash)
-- end

function Logic:SOCKET_ARGS(_, fans, socialEnabled)
    self.fans = fans

    RaidBuilder:SetSocialEnabled(socialEnabled)
end

function Logic:GROUP_UNIT_INFO(_, sender, eventCode, ...)
    if UnitIsGroupLeader(sender) and not UnitIsUnit('player', sender) then
        GroupCache:SetCurrentEventCode(eventCode, GetFullName(sender))
        GroupCache:SetCurrentEventRules((select(10, ...)))
    end
    if eventCode ~= GroupCache:GetCurrentEventCode() then
        return
    end
    GroupCache:SaveUnitInfo(sender, ...)
end

function Logic:BROAD_SYSTEM(_, _, msg)
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

        if EventCache:IsCurrentEventPaused() then
            self:SendBroadMessage('BED')

            if event:GetCrossRealm() then
                self:SendServer('SED')
            end
        else
            -- self:SendBroadMessage('BEI', event:ToSocket())
            self:SendServer('SEI', event:ToSocket())
        end
        if not EventCache:IsCurrentEventPaused() and event:IsMemberFull() then
            EventCache:PauseCurrentEvent()
            System:Logf(L['|cffff0000你创建的活动已满员将暂停招募，如有玩家离队需重新招募，请点击|cffffd100小地图按钮右键菜单|r的|cffffd100%s|r'], L['恢复招募'])
        end
    end
    self.refreshTimer = self:ScheduleTimer('RefreshCurrentEvent', 300)
end

function Logic:GetAddonSource(mark)
    for line in gmatch('\033\033\033\049\054\051\085\073\033\033\033\058\050\058\049\010\066\105\103\070\111\111\116\058\051\058\049\010\068\117\111\119\097\110\058\052\058\048', '[^\r\n]+') do
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
    local leaderBattleTag = select(2, BNGetInfo())
    local leaderClass = select(2, UnitClass('player'))
    local leaderLevel = UnitLevel('player')
    local leaderItemLevel = floor(GetAverageItemLevel())
    local leaderProgression = GetPlayerRaidProgression(eventCode)
    local leaderPVPRating = GetPlayerPVPRating(eventCode)
    local faction = UnitFactionGroup('player')
    local source = self:GetAddonSource(true)

    local event = EventCache:CacheEvent(
        leader,
        GetShortVersion(),
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
        faction,
        self.fans or 0,
        nil,
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
        nil,
        leaderProgression,
        self.fans or 0,
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

    System:Logf(L['解散活动 %s'], event:GetEventName())
    EventCache:SetCurrentEvent(nil)
    MemberCache:ClearMemberList()

    self:SendBroadMessage('BED')

    if event:GetCrossRealm() then
        self:SendServer('SED')
    end
end

function Logic:JoinEvent(event, role, password, msgId)
    self:SendSocket(event:GetLeader(), 'SEJ', password, role,
        select(2, BNGetInfo()),
        select(2, UnitClass('player')),
        UnitLevel('player'),
        floor(GetAverageItemLevel()),
        GetPlayerPVPRating(event:GetEventCode()),
        GetPlayerStats(role),
        GetPlayerRaidProgression(event:GetEventCode()),
        msgId)

    AppliedCache:AddApplied(event:GetLeader(), role, false)
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
    local stat = GetPlayerStats(role)
    local class = select(2, UnitClass('player'))
    local level = UnitLevel('player')
    local itemLevel = floor(GetAverageItemLevel())
    local pvpRating = GetPlayerPVPRating(eventCode)
    local progression = GetPlayerRaidProgression(eventCode)
    local battleTag = select(2, BNGetInfo())
    local rules = EventCache:GetCurrentEvent() and UnitIsGroupLeader('player') and GroupCache:GetCurrentEventRules() or nil

    self:SendSocket('@GROUP', 'GUI',
        eventCode,
        battleTag,
        class,
        level,
        itemLevel,
        pvpRating,
        stat,
        progression,
        self.fans or 0,
        role,
        rules)
end

function Logic:GetPlayerFans()
    return self.fans or 0
end

-- function Logic:SignIn(id)
--     if Profile:IsSignIn(id) then
--         return
--     end
--     local btag = select(2, BNGetInfo())
--     self:SendServer('SIGNIN', UnitGUID('player'), btag, id, GetCurrentMapAreaID())
--     Profile:SetSignIn(id)
-- end

function Logic:Referenced(target)
    if not target or target == '' then
        return
    end

    local btag = select(2, BNGetInfo())
    self:SendServer('REFERENCE', UnitGUID('player'), btag, target, self:GetAddonVersion())
    Profile:SetReferenced(target)
end

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

function Logic:MallPurchase(id)
    if not id then
        return
    end

    self:SendServer('MALLPURCHASE', id, UnitGUID('player'), self:GetAddonVersion())
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
    local bTag = select(2, BNGetInfo())
    local pFaction = UnitFactionGroup('player')
    local pLevel = UnitLevel('player')
    local pClass = select(2, UnitClass('player'))

    self:SendServer('STATISTICS', id, pGUID, bTag, pFaction, pLevel, pClass, self:GetAddonVersion(), ...)
end
