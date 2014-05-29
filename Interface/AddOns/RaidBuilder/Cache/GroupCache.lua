
BuildEnv(...)

GroupCache = RaidBuilder:NewModule('GroupCache', 'AceEvent-3.0', 'AceTimer-3.0', 'AceBucket-3.0')

function GroupCache:OnInitialize()
    self.unitCache = {}

    self.db = RaidBuilder:GetDB().profile.groupCacheProfile

    self:RegisterBucketEvent({
        'PLAYER_LOGIN',
        'GROUP_JOINED',
        'GROUP_ROSTER_UPDATE',
    }, 5, 'RefreshPlayerInfo')

    self:RegisterBucketMessage({
        'RAIDBUILDER_CURRENT_EVENT_UPDATE',
        'RAIDBUILDER_CURRENT_ROLE_UPDATE',
    }, 5, 'RefreshPlayerInfo')

    self:RegisterEvent('ROLE_CHANGED_INFORM')
    self:RegisterEvent('GROUP_ROSTER_UPDATE')

    self:ScheduleTimer(function()
        self:RegisterMessage('RAIDBUILDER_CURRENT_EVENT_UPDATE', 'GROUP_ROSTER_UPDATE')
        self:GROUP_ROSTER_UPDATE()
    end, 30)
end

function GroupCache:SaveUnitInfo(target, battleTag, class, level, itemLevel, pvpRating, stats, progression, fans, role)
    local member = self.unitCache[target]
    if not member then
        member = Member:New()
        self.unitCache[target] = member
        self.db.unitCache[target] = member:GetProxy()
    end

    member:SetName(target)
    member:SetBattleTag(battleTag)
    member:SetClass(class)
    member:SetLevel(level)
    member:SetItemLevel(itemLevel)
    member:SetPVPRating(pvpRating)
    member:SetStats(stats)
    member:SetProgression(progression)
    member:SetFans(fans or 0)

    if not PlayerIsGroupLeader() then
        self:SetUnitRole(target, role)
    end

    self:SendMessage('RAIDBUILDER_UNIT_INFO_UPDATE')
end

function GroupCache:RemoveUnit(target)
    self.unitCache[target] = nil
    self.db.unitCache[target] = nil
end

function GroupCache:GetUnitInfo(target)
    return self.unitCache[target]
end

function GroupCache:GetUnitRole(target)
    if not self:GetCurrentEventCode() then
        return
    end
    if UnitIsUnit('player', target) then
        return self:GetCurrentRole()
    end
    return self.db.unitRoles[target]
end

function GroupCache:SetUnitRole(target, role)
    if UnitIsUnit('player', target) then
        self:SetCurrentRole(role)
    end
    self.db.unitRoles[target] = role
    self:SendMessage('RAIDBUILDER_UNIT_INFO_UPDATE')
end

function GroupCache:SetCurrentRole(role)
    if role ~= self.db.currentRole then
        self.db.currentRole = role
        self:SendMessage('RAIDBUILDER_CURRENT_ROLE_UPDATE')
    end
end

function GroupCache:GetCurrentRole()
    return self.db.currentRole
end

function GroupCache:SetCurrentEventCode(eventCode, leader)
    if eventCode ~= self.db.currentEventCode then
        self.db.currentEventCode = eventCode
        self.db.currentEventLeader = leader
        self:SendMessage('RAIDBUILDER_CURRENT_EVENT_UPDATE')
    end
end

function GroupCache:SetCurrentEventRules(rules)
    if rules ~= self.db.currentEventRules then
        self.db.currentEventRules = rules
        self:SendMessage('RAIDBUILDER_CURRENT_EVENT_RULES_UPDATE')
    end
end

function GroupCache:GetCurrentEventCode()
    if PlayerIsGroupLeader() then
        local event = EventCache:GetCurrentEvent()
        if event then
            return event:GetEventCode()
        end
    end
    return self.db.currentEventCode
end

function GroupCache:GetCurrentEventRules()
    if PlayerIsGroupLeader() then
        local event = EventCache:GetCurrentEvent()
        if event then
            return event:GetRules()
        end
    end
    return self.db.currentEventRules
end

function GroupCache:GetCurrentEventLeader()
    return self.db.currentEventLeader
end

function GroupCache:GetCurrentEventName()
    local eventCode = self:GetCurrentEventCode()

    return eventCode and EVENT_NAMES[eventCode] or L['当前没有活动']
end

function GroupCache:RefreshPlayerInfo()
    if not IsInGroup(LE_PARTY_CATEGORY_HOME) then
        return
    end

    self:CancelTimer(self.broadTimer)
    Logic:BroadPlayerInfo()
    self.broadTimer = self:ScheduleTimer('RefreshPlayerInfo', 60)
end

function GroupCache:ROLE_CHANGED_INFORM(_, target, operator, _, role)
    if not UnitIsGroupLeader(operator) then
        return
    end
    self:SetUnitRole(target, role)
end

function GroupCache:GROUP_ROSTER_UPDATE()
    for target, member in pairs(self.unitCache) do
        if not UnitInGroup(target) then
            self:RemoveUnit(target)
        end
    end

    if not IsInGroup(LE_PARTY_CATEGORY_HOME) then
        wipe(self.db.unitRoles)

        self.db.currentEventCode = nil
        self.db.currentEventLeader = nil
        self.db.currentEventRules = nil

        if not EventCache:GetCurrentEvent() then
            self.db.currentRole = nil
        end
    end
    self:SendMessage('RAIDBUILDER_UNIT_INFO_UPDATE')
end

function GroupCache:GetAnnouncementContent()
    local event = EventCache:GetCurrentEvent()
    if event then
        return L.EVENT_ANNOUNCEMENT_CONTENT:format(event:GetEventName(), event:GetSummary())
    else
        local name = self:GetCurrentEventName()
        local leader = self:GetCurrentEventLeader()

        if name and leader then
            return L.EVENT_ANNOUNCEMENT_CONTENT_MEMBER:format(leader, name)
        end
    end
end
