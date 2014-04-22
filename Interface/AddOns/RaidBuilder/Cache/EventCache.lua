
BuildEnv(...)

EventCache = RaidBuilder:NewModule('EventCache', 'AceEvent-3.0', 'AceTimer-3.0')

local CHECK_INTERVAL = 60
local EVENT_TIMEOUT  = 900

function EventCache:OnInitialize()
    self.eventCache = {}

    self.db = RaidBuilder:GetDB()

    self:RegisterEvent('PLAYER_LOGIN')
    self:RegisterMessage('RAIDBUILDER_BLACKLIST_UPDATE')
    self:ScheduleRepeatingTimer('CheckEventList', CHECK_INTERVAL)
end

function EventCache:PLAYER_LOGIN()
    local now = time()
    local p = self.db.profile.currentEvent
    if p then
        if now - p.TimeStamp > EVENT_TIMEOUT then
            self:SetCurrentEvent(nil)
        else
            self:SetCurrentEvent(Event:New(p))
        end
    end
    for leader, p in pairs(self.db.profile.eventCache) do
        if now - p.TimeStamp > EVENT_TIMEOUT then
            self:RemoveEvent(leader)
        else
            self:CacheEventByProxy(leader, p)
        end
    end
    self:SendMessage('RAIDBUILDER_EVENT_LOADED')
end

function EventCache:RAIDBUILDER_BLACKLIST_UPDATE()
    for leader, event in pairs(self.eventCache) do
        if Profile:IsInBlackList(event:GetLeaderBattleTag()) then
            self:RemoveEvent(leader)
        end
    end
end

function EventCache:CacheEvent(leader, ...)
    local event = self.eventCache[leader] or Event:New()
    event:FromSocket(leader, ...)
    event:SetTimeStamp(time())

    local crossRealm = GetEventAllowCrossRealm(event:GetEventCode())
    if not crossRealm and event:GetCrossRealm() then
        self:RemoveEvent(leader)
        return
    end

    self.eventCache[leader] = event
    self.db.profile.eventCache[leader] = event:GetProxy()
    self:SendMessage('RAIDBUILDER_EVENT_LIST_UPDATE')
    
    return event
end

function EventCache:CacheEventByProxy(leader, proxy)
    local event = self.eventCache[leader] or Event:New(proxy)

    self.eventCache[leader] = event
    self.db.profile.eventCache[leader] = proxy

    self:SendMessage('RAIDBUILDER_EVENT_LIST_UPDATE')
end

function EventCache:RemoveEvent(leader)
    self.eventCache[leader] = nil
    self.db.profile.eventCache[leader] = nil

    self:SendMessage('RAIDBUILDER_EVENT_LIST_UPDATE')
end

function EventCache:GetEvent(leader)
    return self.eventCache[leader]
end

function EventCache:IterateEvents()
    return pairs(self.eventCache)
end

function EventCache:CheckEventList()
    local now = time()
    for leader, event in pairs(self.eventCache) do
        if now - EVENT_TIMEOUT > event:GetTimeStamp() then
            self:RemoveEvent(leader)
        end
    end
end

function EventCache:SetCurrentEvent(event)
    if not event then
        self.event = nil
        self.db.profile.currentEvent = nil
        self.db.profile.currentEventPaused = nil
    else
        self.event = event
        self.db.profile.currentEvent = event:GetProxy()
    end
end

function EventCache:GetCurrentEvent()
    return self.event
end

function EventCache:PauseCurrentEvent()
    if not self:IsCurrentEventPaused() then
        self.db.profile.currentEventPaused = true
        self:SendMessage('RAIDBUILDER_EVENT_LOCK_UPDATE')
    end
end

function EventCache:RestoreCurrentEvent()
    if self:IsCurrentEventPaused() then
        self.db.profile.currentEventPaused = nil
        self:SendMessage('RAIDBUILDER_EVENT_LOCK_UPDATE')
    end
end

function EventCache:IsCurrentEventPaused()
    return not self.event or self.db.profile.currentEventPaused
end
