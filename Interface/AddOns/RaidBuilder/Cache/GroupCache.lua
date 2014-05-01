
BuildEnv(...)

GroupCache = RaidBuilder:NewModule('GroupCache', 'AceEvent-3.0', 'AceTimer-3.0', 'AceBucket-3.0')

function GroupCache:OnInitialize()
    self.unitCache = {}

    self:RegisterBucketEvent({'GROUP_JOINED', 'PLAYER_LOGIN', 'GROUP_ROSTER_UPDATE'}, 5, 'RefreshPlayerInfo')
    self:RegisterBucketMessage('RAIDBUILDER_CURRENTEVENT_UPDATE', 5, 'RefreshPlayerInfo')

    -- self:RegisterEvent('GROUP_ROSTER_UPDATE')
end

function GroupCache:SaveUnitInfo(target, battleTag, class, level, itemLevel, pvpRating, stats, progression, fans)
    local proxy = {
        Name = target,
        BattleTag = battleTag,
        Class = class,
        Level = level,
        ItemLevel = itemLevel,
        PVPRating = pvpRating,
        Stats = stats,
        Progression = progression,
        Fans = fans,
    }

    self.unitCache[target] = Member:New(proxy)

    self:SendMessage('RAIDBUILDER_UNIT_INFO_UPDATE')
end

function GroupCache:GetUnitInfo(target)
    return self.unitCache[target]
end

function GroupCache:SetCurrentEventCode(eventCode)
    if eventCode ~= self.currentEventCode then
        self.currentEventCode = eventCode

        self:SendMessage('RAIDBUILDER_CURRENTEVENT_UPDATE')
    end
end

function GroupCache:GetCurrentEventCode()
    if PlayerIsGroupLeader() then
        local event = EventCache:GetCurrentEvent()
        if event then
            return event:GetEventCode()
        end
    else
        return self.currentEventCode
    end
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

function GroupCache:GROUP_ROSTER_UPDATE()
    for target, v in pairs(self.unitCache) do
        if UnitInRaid(target) or UnitInParty(target) then
            self.unitCache[target] = nil
        end
    end
end
