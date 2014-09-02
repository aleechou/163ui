
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
    'Rules',
    'Source',

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
    local eventCode = OLD_EVENT_MAP[self:GetEventCode()] or self:GetEventCode()
    return  leader ~= UnitName('player') and leader or nil,
            self:GetTimeStamp(),
            -- self:GetEventCode(),
            eventCode,
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
            self:GetRealm(),
            self:GetSource()
end

function Event:FromSocket(...)
    local   leader, timeStamp, eventCode, eventMode,
            minLevel, maxLevel, itemLevel, pvpRating,
            summary, crossRealm, forceVerify, hasPassword, memberRole,
            leaderBattleTag, leaderClass, leaderLevel,
            leaderItemLevel, leaderPVPRating, leaderProgression, faction, fans, realm, source = ...
    summary = self:TextFilter(summary:gsub('\n', ''))

    self.baseSortValue = nil
    self.eventCodeSortValue = nil

    eventCode = OLD_EVENT_CODE[eventCode] or eventCode
    
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
    self:SetSource(source)
end

function Event:GetEventName()
    return EVENT_NAMES[self:GetEventCode()] or UNKNOWN
end

local function _IsMatch(filterCode, eventCode)
    local f1, f2, f3, f4, f5 = GetEventCodeInfo(filterCode)
    local e1, e2, e3, e4, e5 = GetEventCodeInfo(eventCode)

    if f1 ~= e1 then
        return false
    end
    if f2 ~= 0 and f2 ~= e2 then
        return false
    end
    if f3 ~= 0 and f3 ~= e3 then
        return false
    end
    if f4 ~= 0 and f4 ~= e4 then
        return false
    end
    -- if f5 ~= 0 and bit.band(f5, e5) == 0 then
    if f5 ~= 0 and f5 ~= e5 then
        return false
    end
    return true
end

local MatchCache = setmetatable({}, {
    __index = function(o, filterCode)
        o[filterCode] = setmetatable({}, {
            __index = function(o, eventCode)
                o[eventCode] = _IsMatch(filterCode, eventCode)
                return o[eventCode]
            end
        })
        return o[filterCode]
    end
})

function Event:Match(leader, eventCode, usable, noPassword, favorite)
    -- if usable then
    --     if not self:IsUsable() then
    --         return false
    --     end
    --     for k, v in pairs(GetPlayerRoles()) do
    --         if v and not self:IsRoleFull(k) then
    --             return true
    --         end
    --     end
    --     return false
    -- end
    if usable and (not self:IsUsable() or not self:IsRoleUsable()) then
        return false
    end
    if noPassword and self:GetHasPassword() then
        return false
    end
    if favorite and not self:IsInFavorite() then
        return false
    end
    if leader and leader ~= '' and not self:GetLeader():lower():match(leader:lower()) then
        return false
    end
    if not eventCode or eventCode == 0 or eventCode == self:GetEventCode() then
        return true
    end
    return MatchCache[eventCode][self:GetEventCode()]
end

function Event:IsUsable()
    return self:IsLevelValid() and self:IsItemLevelValid() and self:IsPVPRatingValid()
end

function Event:IsRoleUsable()
    for k, v in pairs(GetPlayerRoles()) do
        if v and not self:IsRoleFull(k) then
            return true
        end
    end
end

function Event:IsLevelValid()
    local level = UnitLevel('player')
    return level >= self:GetMinLevel() and level <= self:GetMaxLevel()
end

function Event:IsItemLevelValid()
    local equipLevel = GetAverageItemLevel()
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
    return UnitIsUnit('player', self:GetLeader() or 'none')
end

function Event:IsInEvent()
    return UnitIsGroupLeader(self:GetLeader())
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
    return bit.band(self:GetEventCode(), EVENT_MATCH_TYPE) == EVENT_TYPE_ARENA
end

function Event:GetLeaderBTag()
    return FormatBattleTag(self:GetLeaderBattleTag())
end

function Event:IsApplied()
    return AppliedCache:IsApplied(self:GetLeader())
end

function Event:IsInFavorite()
    return Profile:IsInFavorite(self:GetLeaderBattleTag())
end

function Event:IsMemberFull()
    return self:GetRoleCurrentAll() >= self:GetRoleTotalAll() or
            (self:IsRoleFull('TANK') and
            self:IsRoleFull('HEALER') and
            self:IsRoleFull('DAMAGER') and
            self:IsRoleFull('NONE'))
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

function Event:GetLeaderLogoTooltip()
    local name, btag = self:GetLeader(), self:GetLeaderBattleTag()
    local logoName = GetUnitLogoName(name, btag)
    if logoName then
        return GetUnitLogoTexture(name, btag) .. logoName
    end
end

function Event:BaseSortHandler()
    if not self.baseSortValue then
        self.baseSortValue = format('%08x%02x%02x%s',
            self:GetEventCode(),
            self:GetEventMode(),
            self:GetStatusSortValue(),
            strpadright(self:GetLeader(), 40))
    end
    return self.baseSortValue
end

function Event:GetStatusSortValue()
    return  self:IsSelf() and 1 or
            self:IsInEvent() and 2 or
            self:IsApplied() and 3 or
            self:IsInFavorite() and 4 or
            self:GetHasPassword() and 5 or 6
end
