
BuildEnv(...)

Invite = RaidBuilder:NewModule('Invite', 'AceEvent-3.0', 'AceTimer-3.0', 'AceBucket-3.0', 'AceSerializer-3.0')

function Invite:OnInitialize()
    self.db = RaidBuilder:GetDB()

    self.realms = {}
    self.accepted = {}
    self.bnToons = {}
    self.bnFriends = {}

    self.inviteQueue = self.db.profile.inviteQueue
    self.inviteBNets = self.db.profile.inviteBNets

    self:RegisterEvent('PLAYER_LOGIN')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'CheckRaid')
    self:RegisterEvent('BN_FRIEND_INVITE_ADDED')
    self:RegisterBucketEvent('BN_FRIEND_INFO_CHANGED', 1, 'CacheBNetToons')
end

---- Cache
function Invite:PLAYER_LOGIN(event)
    self:UnregisterEvent(event)

    local realms = GetAutoCompleteRealms() or {(GetRealmName():gsub('%s+', ''))}
    for i, v in ipairs(realms) do
        self.realms[v] = true
    end

    local now = time()
    local playerName = UnitFullName('player')
    for i = 1, BNGetNumFriendInvites() do
        local id, _, isBattleTag, data = BNGetFriendInviteInfoByAddon(i)
        if isBattleTag and id and data and data ~= '' then
            local ok, tag, stamp, leaderName, selfName = self:Deserialize(data)
            if ok and tag == 'RaidBuilder' then
                BNDeclineFriendInvite(id)
            end
        end
    end

    self:CacheBNetToons()
    self:CheckInviteTimeout()
    self:Start()
end

function Invite:CacheBNetToons()
    wipe(self.bnToons)
    wipe(self.bnFriends)
    for i = 1, BNGetNumFriends() do
        local id, _, battleTag, _, _, _, _, isOnline = BNGetFriendInfo(i)
        if isOnline then
            for toonIndex = 1, BNGetNumFriendToons(i) do
                local _, toonName, client, realmName, _, faction = BNGetFriendToonInfo(i, toonIndex)
                if client == 'WoW' and faction == UnitFactionGroup('player') then
                    local name = Ambiguate(GetFullName(toonName, (realmName:gsub('%s+', ''))), 'none')

                    self.bnToons[name] = battleTag
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
    local now = time()
    local playerName = UnitFullName('player')

    for i = 1, BNGetNumFriendInvites() do
        local id, _, isBattleTag, data = BNGetFriendInviteInfoByAddon(i)
        if isBattleTag and id and data and data ~= '' then
            local ok, tag, stamp, leaderName, selfName = self:Deserialize(data)
            if ok and tag == 'RaidBuilder' then
                if playerName == selfName and AppliedCache:IsApplied(leaderName) then
                    BNAcceptFriendInvite(id)
                end
            end
        end
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
                        info.status = status
                    end
                end
            end
        end
        self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
    end
end

---- Method

function Invite:InviteMember(name, battleTag, isWeb)
    name = Ambiguate(name, 'none')
    self:CheckRaid()
    self:EnQueue(name, battleTag, isWeb)
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

function Invite:EnQueue(name, battleTag, isWeb)
    if not self:IsInQueue(name, battleTag) then
        tinsert(self.inviteQueue, {
            name = name,
            battleTag = battleTag,
            isWeb = isWeb,
            status = INVITE_STATUS_QUEUE,
            stamp = time(),
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
    elseif self:IsCanInvite(info.name) or self:IsBNetFriend(info.battleTag) then
        return self:DoGroupInvite(info)
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

function Invite:DoBNetInvite(info)
    local noAction = true
    if info.status < INVITE_STATUS_BNETTING then
        local data = self:Serialize(
            info.isWeb and 'RaidBuilder-Web' or 'RaidBuilder',
            time(),
            UnitFullName('player'),
            info.name
        )
        BNSendFriendInvite(info.battleTag, data)

        self.inviteBNets[info.battleTag] = true

        if not info.isWeb then
            self:ScheduleTimer('BNetInviteTimeout', 10, info.name)
        end
        noAction = false
    end
    return INVITE_STATUS_BNETTING, noAction
end

function Invite:BNetInviteTimeout(name)
    if not self:GetBattleTagByName(name) and self:GetInviteQueueNode(name) then
        self:CHAT_MSG_SYSTEM(nil, ERR_BAD_PLAYER_NAME_S:format(name))
    end
end

function Invite:RemoveBNetFriend(name)
    local battleTag = self:GetBattleTagByName(name)
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
    if not checkTimer then
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
            if self:IsInviteTimeout(self.inviteQueue[i]) then
                tremove(self.inviteQueue, i)
            end
        end
        self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
    else
        self:CancelTimer(self.checkTimer)
        self.checkTimer = nil
    end
end
