
BuildEnv(...)

Invite = RaidBuilder:NewModule('Invite', 'AceEvent-3.0', 'AceBucket-3.0', 'AceSerializer-3.0', 'AceTimer-3.0')

function Invite:OnInitialize()
    self.db = RaidBuilder:GetDB()

    self.inviteQueue = self.db.profile.inviteQueue
    self.invitedBTags = self.db.profile.invitedBTags
    self.invitedNames = self.db.profile.invitedNames
    self.accepted = {}
    self.bnToons = {}

    self:RegisterEvent('PLAYER_LOGIN')
    self:RegisterEvent('CHAT_MSG_SYSTEM')
    self:RegisterEvent('BN_FRIEND_INVITE_ADDED')
    self:RegisterEvent('CHAT_MSG_BN_INLINE_TOAST_ALERT')
    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:RegisterBucketEvent('BN_FRIEND_INFO_CHANGED', 1)

    self.btagCheckTimer = self:ScheduleRepeatingTimer('CheckBattleTagTimeout', 60)
end

function Invite:GROUP_ROSTER_UPDATE()
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')

    -- if not UnitIsGroupLeader('player') then
    --     return
    -- end
    -- local event = EventCache:GetCurrentEvent()
    -- if not event then
    --     return
    -- end
    -- local total = event:GetRoleTotalAll()
    -- if total > 5 then
    --     if IsInGroup() and not IsInRaid() then
    --         ConvertToRaid()
    --     end
    -- else
    --     if IsInRaid() then
    --         ConvertToParty()
    --     end
    -- end
end

function Invite:PLAYER_LOGIN()
    self.realms = {}

    local cache = GetAutoCompleteRealms()
    if cache then
        for i, v in ipairs(cache) do
            self.realms[v] = true
        end
    else
        self.realms[GetRealmName():gsub('%s+', '')] = true
    end

    self:ClearBNet()
    self:CacheBNetTonns()
    self:StartInvite()
end

function Invite:BN_FRIEND_INFO_CHANGED()
    self:CacheBNetTonns()
    self:CheckInvitedBTags()
end

function Invite:ClearBNet()
    for i = 1, BNGetNumFriendInvites() do
        local id, _, isBattleTag, data = BNGetFriendInviteInfoByAddon(i)
        if id and isBattleTag and data and data ~= '' then
            local ok, tag, battleTag, leaderName, selfName = self:Deserialize(data)
            if ok and tag == 'RaidBuilder' then
                BNDeclineFriendInvite(id)
            end
        end
    end
end

function Invite:CheckInvitedBTags()
    for i, v in ipairs(self.invitedBTags) do
        if v.battleTag == self:GetBattleTagByName(v.name) then
            self:StartInvite(v.name)
        end
    end
end

function Invite:CacheBNetTonns()
    wipe(self.bnToons)
    for i = 1, BNGetNumFriends() do
        local id, _, battleTag, _, _, _, _, isOnline = BNGetFriendInfo(i)
        if isOnline then
            for toonIndex = 1, BNGetNumFriendToons(i) do
                local _, toonName, client, realmName, _, faction = BNGetFriendToonInfo(i, toonIndex)
                if client == 'WoW' and faction == UnitFactionGroup('player') then
                    local name = Ambiguate(GetFullName(toonName, realmName), 'none')

                    self.bnToons[name] = battleTag
                end
            end
        end
    end
end

function Invite:GetBattleTagByName(name)
    return self.bnToons[name]
end

function Invite:BN_FRIEND_INVITE_ADDED()
    for i = 1, BNGetNumFriendInvites() do
        local id, _, isBattleTag, data = BNGetFriendInviteInfoByAddon(i)
        if id and isBattleTag and data and data ~= '' then
            local ok, tag, battleTag, leaderName, selfName = self:Deserialize(data)
            if ok and tag == 'RaidBuilder' then
                if selfName ~= UnitFullName('player') and AppliedCache:IsApplied(leaderName) then
                    BNDeclineFriendInvite(id)
                else
                    BNAcceptFriendInvite(id)
                    self.accepted[id] = true
                end
            end
        end
    end
end

function Invite:CHAT_MSG_BN_INLINE_TOAST_ALERT(_, action, ...)
    if action == 'BATTLETAG_FRIEND_ADDED' then
        local id = select(12, ...)
        local id, _, battleTag, isBattleTag = BNGetFriendInfoByID(id)
        if isBattleTag and battleTag then
            if self:IsBattleTagRegistered(battleTag) then
                BNSetFriendNote(id, 'RaidBuilderAdd')
            elseif self.accepted[id] then
                BNSetFriendNote(id, 'RaidBuilderAdd')
                self.accepted[id] = nil
            else
                local note = select(13, BNGetFriendInfoByID(id))
                if note and note == 'RaidBuilderAdd' then
                    BNSetFriendNote(id, '')
                end
            end
        end
    end
end

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
        if self:IsNameRegistered(name) then
            return name, v
        end
    end
end

function Invite:CHAT_MSG_SYSTEM(_, msg)
    local name, errorType = self:CheckMemberError(msg)
    if name then
        if  errorType == 'INGROUP' or
            errorType == 'DECLINE' or
            errorType == 'JOINED' or
            errorType == 'OFFLINE' then

            local battleTag = self:GetBattleTagByName(name)
            if battleTag then
                self:UnregisterBattleTag(battleTag, name)
            end

            self:UnregisterName(name)
            MemberCache:RemoveMember(name)

        elseif errorType == 'INVITING' then
            local battleTag = self:GetBattleTagByName(name)
            if battleTag and self:IsBattleTagRegistered(battleTag) then
                self:UnregisterBattleTag(battleTag, name)
            end
        end
        System:Log(msg)
    end
end

function Invite:IsSameRealm(name)
    local realm = name:match('%-([^-]+)$')
    if not realm then
        return true
    end
    return self.realms[realm]
end

function Invite:InviteMember(name, battleTag, isWeb)
    if not self:IsInGroup(name) then
        if self:IsSameRealm(name) or self:GetBattleTagByName(name) then
            self:StartInvite(name)
        else
            self:RegisterBattleTag(battleTag, name, isWeb)
        end
    end
end

function Invite:IsInGroup(name)
    name = Ambiguate(name, 'none')

    return UnitInRaid(name) or UnitInParty(name)
end

function Invite:GetMemberStatus(name, battleTag)
    if self:IsInGroup(name) then
        return INVITE_STATUS_JOINED
    elseif self:IsNameRegistered(name) then
        return INVITE_STATUS_INVITING
    elseif self:IsInQueue(name) then
        return INVITE_STATUS_QUEUE
    elseif self:IsBattleTagRegistered(battleTag) then
        return INVITE_STATUS_BNETTING
    else
        return INVITE_STATUS_UNKNOWN
    end
end

function Invite:StartInvite(name)
    if name then
        self:InsertQueue(name)
    end
    if not self.inviteTimer then
        self.inviteTimer = self:ScheduleRepeatingTimer('DoInvite', 1)
    end
end

function Invite:DoInvite()
    local name = next(self.inviteQueue)
    if not name then
        self:CancelTimer(self.inviteTimer)
        self.inviteTimer = nil
        return
    end

    local timeStamp = self.inviteQueue[name]
    if time() - timeStamp > 900 then
        self:RemoveQueue(name)
        return
    end

    if GetNumGroupMembers() >= 5 and not IsInRaid(LE_PARTY_CATEGORY_HOME) then
        ConvertToRaid()
        return
    end

    self:RemoveQueue(name)
    self:RegisterName(name)
    InviteUnit(name)
end

function Invite:AddBNetFriendTimeout(battleTag, name)
    if self:IsBattleTagRegistered(battleTag) and not self:GetBattleTagByName(name) then
        self:CHAT_MSG_SYSTEM(nil, ERR_BAD_PLAYER_NAME_S:format(name))
    end
    self:UnregisterBattleTag(battleTag, name)
end

function Invite:RegisterBattleTag(battleTag, name, isWeb)
    self:RemoveBattleTag(battleTag, name)

    local data = self:Serialize(
        isWeb and 'RaidBuilder-Web' or 'RaidBuilder',
        select(2, BNGetInfo()),
        UnitFullName('player'),
        name)
    
    BNSendFriendInvite(battleTag, data)

    tinsert(self.invitedBTags, {
        battleTag = battleTag,
        name = name,
        time = time(),
        isWeb = isWeb,
    })

    if not isWeb then
        self:ScheduleTimer('AddBNetFriendTimeout', 10, battleTag, name)
    else
        self:CancelTimer(self.btagCheckTimer)
        self.btagCheckTimer = self:ScheduleRepeatingTimer('CheckBattleTagTimeout', 60)
    end
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:CheckBattleTagTimeout()
    local now = time()
    for i = #self.invitedBTags, 1, -1 do
        local v = self.invitedBTags[i]
        if now - (v.time or 0) > 900 then
            self:UnregisterBattleTag(v.battleTag, v.name)
        end
    end
end

function Invite:RemoveBattleTag(battleTag, name)
    for i, v in ipairs(self.invitedBTags) do
        if v.battleTag == battleTag and v.name == v.name then
            tremove(self.invitedBTags, i)
            break
        end
    end
end

function Invite:UnregisterBattleTag(battleTag, name)
    self:RemoveBattleTag(battleTag, name)

    if not self:IsBattleTagRegistered(battleTag) then
        for i = 1, BNGetNumFriends() do
            local id, _, bTag = BNGetFriendInfo(i)
            if battleTag == bTag then
                BNRemoveFriend(id)
                break
            end
        end
    end
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:IsBattleTagRegistered(battleTag)
    for i, v in ipairs(self.invitedBTags) do
        if v.battleTag == battleTag then
            return true
        end
    end
end

function Invite:RegisterName(name)
    self.invitedNames[name] = true
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:UnregisterName(name)
    self.invitedNames[name] = nil
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:IsNameRegistered(name)
    return self.invitedNames[name]
end

function Invite:InsertQueue(name)
    self.inviteQueue[name] = time()
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:RemoveQueue(name)
    self.inviteQueue[name] = nil
    self:SendMessage('RAIDBUILDER_INVITE_STATUS_UPDATE')
end

function Invite:IsInQueue(name)
    return self.inviteQueue[name]
end
