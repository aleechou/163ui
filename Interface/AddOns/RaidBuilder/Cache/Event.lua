
BuildEnv(...)

if ... == 'RaidBuilder' then
    Event = LibStub('NetEaseTextFilter-1.0'):Embed((RaidBuilder or Addon):NewClass('Event'))
else
    Event = (RaidBuilder or Addon):NewClass('Event')
    Event.TextFilter = function(self, str)
        return str
    end
end

function Event:Constructor(proxy)
    self.proxy = proxy or {
        TimeStamp = 0,
    }
end

function Event:GetProxy()
    return self.proxy
end

local attr = {
    'EventCode',
    'EventMode',
    'MinLevel',
    'MaxLevel',
    'ItemLevel',
    'PVPRating',
    'Summary',
    'CrossRealm',
    'HasPassword',
    'ForceVerify',

    'Leader',
    'LeaderBattleTag',
    'LeaderClass',
    'LeaderLevel',
    'LeaderItemLevel',
    'LeaderPVPRating',
    'LeaderProgression',
    'LeaderFans',

    'TimeStamp',

    'Password',

    'Faction',
    'Realm',
}

for i, v in ipairs(attr) do
    Event['Set' .. v] = function(self, value)
        self.proxy[v] = value
    end

    Event['Get' .. v] = function(self)
        return self.proxy[v]
    end
end

function Event:SetMemberRole(data)
    local ct, tt, ch, th, cd, td, cn, tn = UnpackMemberRole(data)

    self:SetRoleCurrent('TANK', ct)
    self:SetRoleCurrent('HEALER', ch)
    self:SetRoleCurrent('DAMAGER', cd)
    self:SetRoleCurrent('NONE', cn)

    self:SetRoleTotal('TANK', tt)
    self:SetRoleTotal('HEALER', th)
    self:SetRoleTotal('DAMAGER', td)
    self:SetRoleTotal('NONE', tn)
end

function Event:GetMemberRole()
    return PackMemberRole(
        self:GetRoleCurrent('TANK'),
        self:GetRoleTotal('TANK'),
        self:GetRoleCurrent('HEALER'),
        self:GetRoleTotal('HEALER'),
        self:GetRoleCurrent('DAMAGER'),
        self:GetRoleTotal('DAMAGER'),
        self:GetRoleCurrent('NONE'),
        self:GetRoleTotal('NONE'))
end

function Event:ToSocket()
    local leader = self:GetLeader()
    return  leader ~= UnitName('player') and leader or nil,
            self:GetTimeStamp(),
            self:GetEventCode(),
            self:GetEventMode(),
            self:GetMinLevel(),
            self:GetMaxLevel(),
            self:GetItemLevel(),
            self:GetPVPRating(),
            self:GetSummary(),
            self:GetCrossRealm(),
            self:GetForceVerify(),
            self:GetHasPassword(),
            self:GetMemberRole(),
            self:GetLeaderBattleTag(),
            self:GetLeaderClass(),
            self:GetLeaderLevel(),
            self:GetLeaderItemLevel(),
            self:GetLeaderPVPRating(),
            self:GetLeaderProgression(),
            self:GetFaction(),
            self:GetLeaderFans(),
            self:GetRealm()
end

function Event:FromSocket(...)
    local   leader, timeStamp, eventCode, eventMode,
            minLevel, maxLevel, itemLevel, pvpRating,
            summary, crossRealm, forceVerify, hasPassword, memberRole,
            leaderBattleTag, leaderClass, leaderLevel,
            leaderItemLevel, leaderPVPRating, leaderProgression, faction, fans, realm = ...
    summary = self:TextFilter(summary:gsub('\n', ''))

    self:SetLeader(leader)
    self:SetTimeStamp(timeStamp)
    self:SetEventCode(eventCode)
    self:SetEventMode(eventMode)
    self:SetMinLevel(minLevel)
    self:SetMaxLevel(maxLevel)
    self:SetItemLevel(itemLevel)
    self:SetPVPRating(pvpRating)
    self:SetSummary(summary)
    self:SetCrossRealm(crossRealm)
    self:SetForceVerify(forceVerify)
    self:SetHasPassword(hasPassword)
    self:SetMemberRole(memberRole)
    self:SetLeaderBattleTag(leaderBattleTag)
    self:SetLeaderClass(leaderClass)
    self:SetLeaderLevel(leaderLevel)
    self:SetLeaderItemLevel(leaderItemLevel)
    self:SetLeaderPVPRating(leaderPVPRating)
    self:SetLeaderProgression(leaderProgression)
    self:SetLeaderFans(fans)
    self:SetFaction(faction)
    self:SetRealm(realm)
end

function Event:GetEventName()
    return EVENT_NAMES[self:GetEventCode()] or UNKNOWN
end

function Event:Match(eventCode, usable, noPassword, leader)
    if usable and not self:IsUsable() then
        return false
    end
    if noPassword and self:GetHasPassword() then
        return false
    end
    if leader and leader ~= '' and not self:GetLeader():lower():match(leader:lower()) then
        return false
    end
    if eventCode == 0 or eventCode == self:GetEventCode() then
        return true
    end
    if bit.band(eventCode, 0xFF00FFFF) == 0 then
        return bit.band(eventCode, self:GetEventCode()) > 0
    end
    return false
end

function Event:IsUsable()
    return self:IsLevelValid() and self:IsItemLevelValid() and self:IsPVPRatingValid()
end

function Event:IsLevelValid()
    local level = UnitLevel('player')
    return level >= self:GetMinLevel() and level <= self:GetMaxLevel()
end

function Event:IsItemLevelValid()
    local equipLevel = select(2, GetAverageItemLevel())
    return equipLevel >= self:GetItemLevel()
end

function Event:IsPVPRatingValid()
    local pvpRating = GetPlayerPVPRating(self:GetEventCode())
    return pvpRating >= self:GetPVPRating()
end

function Event:IsRoleValid(role)
    local isUsable
    if self:GetForceVerify() then
        isUsable = self:IsUsable()
    else
        isUsable = self:IsLevelValid()
    end
    if role == 'NONE' then
        return self:IsLevelValid()
    else
        return PlayerIsRoleValid(role) and isUsable
    end
end

function Event:GetEventModeText()
    return EVENT_MODE_NAMES[self:GetEventMode()] or UNKNOWN
end

function Event:SetCurrentMemberRole(ct, ch, cd, cn)
    self:SetRoleCurrent('TANK', ct)
    self:SetRoleCurrent('HEALER', ch)
    self:SetRoleCurrent('DAMAGER', cd)
    self:SetRoleCurrent('NONE', cn)
end

function Event:IsSelf()
    return self:GetLeader() == UnitName('player')
end

function Event:IsInEvent()
    for _, unit in ipairs(GetGroupUnitList()) do
        if UnitName(unit) == self:GetLeader() then
            return true
        end
    end
end

function Event:GetLeaderClassText()
    local class = self:GetLeaderClass()
    local color = RAID_CLASS_COLORS[class].colorStr

    return ('|c%s%s|r'):format(color, CLASS_NAMES[class])
end

function Event:GetLeaderText(full)
    local name, realm = strsplit('-', self:GetLeader())
    local color = RAID_CLASS_COLORS[self:GetLeaderClass()].colorStr

    if realm  then
        if full then
            return ('|c%s%s|r'):format(color, self:GetLeader())
        else
            return ('|c%s%s|r'):format(color, name .. FOREIGN_SERVER_LABEL)
        end
    else
        return ('|c%s%s|r'):format(color, name)
    end
end

function Event:IsArenaEvent()
    return bit.band(self:GetEventCode(), TYPE_MATCH) == EVENT_TYPE_ARENA
end

function Event:GetLeaderBTag()
    return FormatBattleTag(self:GetLeaderBattleTag())
end

function Event:IsApplied()
    return AppliedCache:IsApplied(self:GetLeader())
end

function Event:IsMemberFull()
    return  self:IsRoleFull('TANK') and
            self:IsRoleFull('HEALER') and
            self:IsRoleFull('DAMAGER') and
            self:IsRoleFull('NONE')
end

function Event:IsRoleFull(role)
    local current, total = self:GetRoleCurrent(role), self:GetRoleTotal(role)
    return current >= total
end

function Event:SetRoleCurrent(role, value)
    if not role or not ROLE_DATA[role] then
        return
    end
    self.proxy['Current' .. role] = value
end

function Event:SetRoleTotal(role, value)
    if not role or not ROLE_DATA[role] then
        return
    end
    self.proxy['Total' .. role] = value
end

function Event:GetRoleCurrent(role)
    if not role or not ROLE_DATA[role] then
        return
    end
    return self.proxy['Current' .. role] or 0
end

function Event:GetRoleTotal(role)
    if not role or not ROLE_DATA[role] then
        return
    end
    return self.proxy['Total' .. role] or 0
end

function Event:GetRoleTotalAll()
    return  self:GetRoleTotal('TANK') +
            self:GetRoleTotal('HEALER') +
            self:GetRoleTotal('DAMAGER') +
            self:GetRoleTotal('NONE')
end

function Event:GetRoleCurrentAll()
    return  self:GetRoleCurrent('TANK') +
            self:GetRoleCurrent('HEALER') + 
            self:GetRoleCurrent('DAMAGER') +
            self:GetRoleCurrent('NONE')
end

function Event:GetLeaderLogoTexture()
    return GetUnitLogoTexture(self:GetLeader(), self:GetLeaderBattleTag())
end

function Event:GetLeaderLogoIndex()
    return GetUnitLogoIndex(self:GetLeader(), self:GetLeaderBattleTag())
end
