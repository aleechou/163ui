
BuildEnv(...)

Invite = RaidBuilder:NewModule('Invite', 'AceEvent-3.0', 'AceHook-3.0', 'AceTimer-3.0', 'AceBucket-3.0', 'AceSerializer-3.0')

function Invite:OnInitialize()
    self.db = RaidBuilder:GetDB()

    self.realms = {}
    self.accepted = {}
    self.bnToons = {}
    self.bnFriends = {}
    self.normalFriends = {}

    self.inviteQueue = self.db.profile.inviteQueue
    self.inviteBNets = self.db.profile.inviteBNets

    self.inviteBNetTimers = {}
    self.lastInviteRequest = 0

    self:RegisterEvent('PLAYER_LOGIN')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'CheckRaid')
    self:RegisterEvent('BN_FRIEND_INVITE_ADDED')
    self:RegisterBucketEvent('FRIENDLIST_UPDATE', 3, 'CacheNormalFriends')
    self:RegisterBucketEvent('BN_FRIEND_INFO_CHANGED', 1, 'CacheBNetToons')

    self:SecureHook('BNToastFrame_Show')
    self:SecureHook('PendingList_Scroll')

    self:SecureHook('BNet_EnableToasts')
    self:SecureHook('BNet_DisableToasts')

    ChatFrame_AddMessageEventFilter('CHAT_MSG_BN_INLINE_TOAST_ALERT', function(_, _, ...)
        local action = ...
        if action == 'FRIEND_REQUEST' then
            if time() - self.lastInviteRequest < 2 then
                return true
            end
        elseif action == 'BATTLETAG_FRIEND_ADDED' or action == 'FRIEND_ONLINE' then
            local id, _, battleTag = BNGetFriendInfoByID(select(13, ...))
            if battleTag and (self:IsInQueue(nil, battleTag) or self.accepted[id]) then
                return true
            end
        end
    end)
end

---- Cache
function Invite:PLAYER_LOGIN(event)
    self:UnregisterEvent(event)

    local realms = GetAutoCompleteRealms() or {(GetRealmName():gsub('%s+', ''))}
    for i, v in ipairs(realms) do
        self.realms[v] = true
    end

    for i = 1, BNGetNumFriendInvites() do
        local tag, id, stamp = self:GetFriendInviteInfo(i)
        if tag == 'RaidBuilder' then
            BNDeclineFriendInvite(id)
        end
    end

    self:CacheBNetToons()
    self:CacheNormalFriends()
    self:StartCheckTimer()
    self:CheckInviteTimeout()
    self:Start()
end

function Invite:CacheBNetToons()
    wipe(self.accepted)
    wipe(self.bnToons)
    wipe(self.bnFriends)
    for i = 1, BNGetNumFriends() do
        local id, _, battleTag, _, _, _, _, isOnline = BNGetFriendInfo(i)
        if isOnline then
            for toonIndex = 1, BNGetNumFriendToons(i) do
                local _, toonName, client, realmName, _, faction = BNGetFriendToonInfo(i, toonIndex)
                if client == 'WoW' and faction == UnitFactionGroup('player') then
                    local name = Ambiguate(GetFullName(toonName, (realmName:gsub('%s+', ''))), 'none')
                    
                    battleTag = battleTag or ''

                    self.bnToons[name] = battleTag
                    self:StopBNetInviteTimer(name, battleTag)
                end
            end
        end
        if battleTag and battleTag ~= '' then
            self.bnFriends[battleTag] = true
        end
    end
end

function Invite:GetBattleTagByName(name)
    return self.bnToons[name]
end

---- AutoBNetAccept
function Invite:BN_FRIEND_INVITE_ADDED()
    local playerName = UnitFullName('player')
    local now = time()

    for i = 1, BNGetNumFriendInvites() do
        local tag, id, stamp, leaderName, selfName = self:GetFriendInviteInfo(i)
        if tag == 'RaidBuilder' then
            if playerName == selfName then
                if AppliedCache:IsApplied(leaderName, true) then
                    BNAcceptFriendInvite(id)
                    self.accepted[id] = true
                    self.lastInviteRequest = now
                end
            end
        elseif tag == 'RaidBuilder-Web' then
            BNToastFrame_AddToast(5, 'RaidBuilder-Web')
            self.lastInviteRequest = now
        end
    end

    if self.lastInviteRequest ~= now and GetCVarBool('showToastWindow') then
        BNToastFrame_AddToast(5)
    end
end

function Invite:GetFriendInviteInfo(index)
    local id, _, isBattleTag, data, stamp = BNGetFriendInviteInfoByAddon(index)
    if isBattleTag and id and data and data ~= '' then
        local ok, tag, eventId, leaderName, selfName, eventSource = self:Deserialize(data)
        if ok and (tag == 'RaidBuilder' or tag == 'RaidBuilder-Web') then
            return tag, id, tonumber(stamp) or 0, leaderName, selfName, eventId, eventSource
        end
    end
end

---- Hook

function Invite:BN_FRIEND_ACCOUNT_ONLINE(_, id)
    local id, _, battleTag = BNGetFriendInfoByID(id)
    if battleTag and (self:IsInQueue(nil, battleTag) or self.accepted[id]) then
        return
    end
    BNToastFrame_AddToast(1, id)
end

function Invite:BNet_EnableToasts()
    BNToastFrame:UnregisterEvent('BN_FRIEND_INVITE_ADDED')
    BNToastFrame:UnregisterEvent('BN_FRIEND_ACCOUNT_ONLINE')
    self:RegisterEvent('BN_FRIEND_ACCOUNT_ONLINE')
end

function Invite:BNet_DisableToasts()
    self:UnregisterEvent('BN_FRIEND_ACCOUNT_ONLINE')
end

function Invite:BNToastFrame_Show()
    if BNToastFrame.toastType == 5 and BNToastFrame.toastData == 'RaidBuilder-Web' then
        BNToastFrameDoubleLine:SetText(L['收到一个|cff00ffff集合石|r预约活动请求，请验证是否合法。'])
    end
end

function Invite:PendingList_Scroll(offset)
    for i = 1, PENDING_INVITES_TO_DISPLAY do
        local button = _G['FriendsFramePendingButton'..i]
        if button and button.index then
            self:FormatPendingButton(button, self:GetFriendInviteInfo(button.index))
        end
    end
end

function Invite:FormatPendingButton(button, tag, id, stamp, leaderName, selfName, eventId, eventSource)
    if tag == 'RaidBuilder-Web' then
        button.webInviteButton = button.webInviteButton or WebInviteButton:New(button)
        button.webInviteButton:SetInfo(stamp, leaderName, selfName, eventId, eventSource)
        button.webInviteButton:Show()
    elseif button.webInviteButton then
        button.webInviteButton:Hide()
    end
end

-- GroupInviteResult

local _MEMBER_ERRORS = {
    [ERR_ALREADY_IN_GROUP_S:format('(.+)')] = 'INGROUP',
    [ERR_DECLINE_GROUP_S:format('(.+)')]    = 'DECLINE',
    [ERR_BAD_PLAYER_NAME_S:format('(.+)')]  = 'OFFLINE',
    [ERR_JOINED_GROUP_S:format('(.+)')]     = 'JOINED',
    [ERR_RAID_MEMBER_ADDED_S:format('(.+)')]= 'JOINED',
    [ERR_INVITE_PLAYER_S:format('(.+)')]    = 'INVITING',
}

function Invite:CheckMemberError(msg)
    for k, v in pairs(_MEMBER_ERRORS) do
        local name = msg:match(k)
        if name and self:IsInQueue(name) then
            return name, v
        end
    end
end

function Invite:CHAT_MSG_SYSTEM(_, msg)
    local name, errorType = self:CheckMemberError(msg)
    if name then
        if errorType == 'INVITING' then
            local index, info = self:GetInviteQueueNode(name, battleTag)
            if info then
                info.isInviting = true
            end
        else
            self:FinishInvite(name)
            MemberCache:RemoveMember(name)
        end
        System:Log(msg)
        self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
    elseif msg == ERR_GROUP_FULL then
        if IsInGroup(LE_PARTY_CATEGORY_HOME) then
            if IsInRaid(LE_PARTY_CATEGORY_HOME) then
                while true do
                    local info = tremove(self.inviteQueue, 1)
                    if not info then
                        break
                    end
                    self:FinishInvite(info.name)
                end
            else
                ConvertToRaid()
                for i, info in ipairs(self.inviteQueue) do
                    if not info.isInviting then
                        info.status = INVITE_STATUS_QUEUE
                    end
                end
            end
        end
        self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
    end
end

---- Method

function Invite:InviteMember(name, battleTag, isWeb, eventId, eventSource)
    name = Ambiguate(name, 'none')
    self:CheckRaid()
    self:EnQueue(name, battleTag, isWeb, eventId, eventSource)
    self:Start()
    self:StartCheckTimer()
end

function Invite:GetMemberStatus(name, battleTag)
    name = Ambiguate(name, 'none')
    if self:IsInGroup(name) then
        return INVITE_STATUS_JOINED
    end
    local index, info = self:GetInviteQueueNode(name, battleTag)
    if not index then
        return INVITE_STATUS_UNKNOWN
    end
    return info.status
end

---- Queue

function Invite:EnQueue(name, battleTag, isWeb, eventId, eventSource)
    if not self:IsInQueue(name, battleTag) then
        tinsert(self.inviteQueue, {
            name = name,
            battleTag = battleTag,
            isWeb = isWeb,
            status = INVITE_STATUS_QUEUE,
            stamp = time(),
            eventId = eventId,
            eventSource = eventSource,
        })
    end
end

function Invite:GetInviteQueueNode(name, battleTag)
    for i, v in ipairs(self.inviteQueue) do
        if (not name or name == v.name) and (not battleTag or battleTag == v.battleTag) then
            return i, v
        end
    end
end

function Invite:RemoveQueue(name, battleTag)
    local index, info = self:GetInviteQueueNode(name, battleTag)
    if index then
        tremove(self.inviteQueue, index)
    end
end

function Invite:DeQueue()
    return tremove(self.inviteQueue, 1)
end

function Invite:IsInQueue(name, battleTag)
    return self:GetInviteQueueNode(name, battleTag)
end

function Invite:GetQueueLength()
    return #self.inviteQueue
end

---- Check

function Invite:IsCanInvite(name)
    local realm = name:match('%-(.+)$')

    return not realm or self.realms[realm] or self:GetBattleTagByName(name)
end

function Invite:IsInGroup(name)
    return UnitInRaid(name) or UnitInParty(name) or UnitIsUnit('player', name)
end

function Invite:IsBNetFriend(battleTag)
    return self.bnFriends[battleTag]
end

---- Run

function Invite:Start()
    if not self.inviteTimer then
        self.inviteTimer = self:ScheduleRepeatingTimer('OnTimer', 1)
    end
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:Stop()
    self:CancelTimer(self.inviteTimer)
    self.inviteTimer = nil
end

function Invite:OnTimer()
    if self:GetQueueLength() == 0 then
        self:Stop()
    else
        local now = time()
        for i, info in ipairs(self.inviteQueue) do
            local status, noAction = self:Do(info)
            if not status then
                tremove(self.inviteQueue, i)
                self:RemoveBNetFriend(nil, info.battleTag)
            else
                if info.status < status then
                    info.status = status
                    info.stamp = now
                end
            end
            if not noAction then
                break
            end
        end
    end
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:Do(info)
    if self:IsInGroup(info.name) then
        return nil, true
    elseif self:IsCanInvite(info.name) then
        return self:DoGroupInvite(info)
    elseif self:IsBNetFriend(info.battleTag) then
        return self:DoFriendOffline(info.name, info.battleTag)
    else
        return self:DoBNetInvite(info)
    end
end

function Invite:DoGroupInvite(info)
    if info.status < INVITE_STATUS_INVITING then
        if self:CheckRaid() then
            return info.status, false
        else
            InviteUnit(info.name)
            return INVITE_STATUS_INVITING, false
        end
    end
    return INVITE_STATUS_INVITING, true
end

function Invite:MakeFriendInviteData(info)
    if info.isWeb then
        return self:Serialize('RaidBuilder-Web', info.eventId, UnitFullName('player'), info.name, info.eventId, info.eventSource)
    else
        return self:Serialize('RaidBuilder', nil, UnitFullName('player'), info.name)
    end
end

function Invite:DoBNetInvite(info)
    local noAction = true
    if info.status < INVITE_STATUS_BNETTING then
        BNSendFriendInvite(info.battleTag, self:MakeFriendInviteData(info))

        self.inviteBNets[info.battleTag] = true

        if not info.isWeb then
            self:StartBNetInviteTimer(info.name, info.battleTag)
        end

        noAction = false
    end
    return INVITE_STATUS_BNETTING, noAction
end

function Invite:DoFriendOffline(name, battleTag)
    self:RemoveQueue(name, battleTag)
    self:RemoveBNetFriend(name, battleTag)
    MemberCache:RemoveMember(name)
end

function Invite:StartBNetInviteTimer(name, battleTag)
    local key = name .. battleTag
    if not self.inviteBNetTimers[key] then
        self.inviteBNetTimers[key] = self:ScheduleTimer('BNetInviteTimeout', 10, name, battleTag)
    end
end

function Invite:StopBNetInviteTimer(name, battleTag)
    local key = name .. battleTag
    self:CancelTimer(key)
    self.inviteBNetTimers[key] = nil
end

function Invite:BNetInviteTimeout(name, battleTag)
    self.inviteBNetTimers[name .. battleTag] = nil

    if not self:GetBattleTagByName(name) and self:GetInviteQueueNode(name) then
        self:CHAT_MSG_SYSTEM(nil, ERR_BAD_PLAYER_NAME_S:format(name))
    end
end

function Invite:RemoveBNetFriend(name, battleTag)
    local battleTag = battleTag or self:GetBattleTagByName(name)
    if not battleTag or battleTag == '' then
        return
    end

    if not self.inviteBNets[battleTag] then
        return
    end

    if self:IsInQueue(nil, battleTag) then
        return
    end

    for i = 1, BNGetNumFriends() do
        local id, _, bTag = BNGetFriendInfo(i)
        if battleTag == bTag then
            BNRemoveFriend(id)
        end
    end
    self.inviteBNets[battleTag] = nil
end

function Invite:FinishInvite(name)
    self:RemoveQueue(name)
    self:RemoveBNetFriend(name)
end

function Invite:CheckRaid()
    if not UnitIsGroupLeader('player') then
        return
    end
    if not IsInGroup(LE_PARTY_CATEGORY_HOME) then
        return
    end
    if IsInRaid(LE_PARTY_CATEGORY_HOME) then
        return
    end
    if GetNumGroupMembers() + self:GetQueueLength() <= 5 then
        return
    end
    ConvertToRaid()
    return true
end

---- CheckTimeout

function Invite:StartCheckTimer()
    if not self.checkTimer then
        self.checkTimer = self:ScheduleRepeatingTimer('CheckInviteTimeout', 20)
    end
end

function Invite:IsInviteTimeout(info)
    local timeOut = time() - info.stamp
    if info.isInviting then
        if timeOut > 90 then
            return true
        end
    end
    if info.isWeb then
        if timeOut > 600 then
            return true
        end
    else
        if timeOut > 90 then
            return true
        end
    end
end

function Invite:CheckInviteTimeout()
    local count = #self.inviteQueue
    if count > 0 then
        for i = #self.inviteQueue, 1, -1 do
            local v = self.inviteQueue[i]
            if self:IsInviteTimeout(v) then
                tremove(self.inviteQueue, i)

                self:RemoveBNetFriend(nil, v.battleTag)
                MemberCache:RemoveMember(v.name)
            end
        end
        self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
    else
        self:CancelTimer(self.checkTimer)
        self.checkTimer = nil
    end
end

function Invite:AddFriend(name, realm, battleTag)
    if self.realms[realm] then
        AddFriend(format('%s-%s', name, realm))
    else
        BNSendFriendInvite(battleTag)
    end
end

function Invite:CacheNormalFriends()
    wipe(self.normalFriends)
    for i = 1, GetNumFriends() do
        local name = GetFriendInfo(i)
        if name then
            self.normalFriends[name] = true
        end
    end
end

function Invite:UnitIsFriend(name, realm, battleTag)
    return self.normalFriends[name] or self.normalFriends[format('%s-%s', name, realm)] or self:IsBNetFriend(battleTag)
end
