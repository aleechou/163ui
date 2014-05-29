
BuildEnv(...)

WebEventCache = RaidBuilder:NewModule('WebEventCache', 'AceEvent-3.0', 'AceTimer-3.0')

function WebEventCache:OnInitialize()
    self.eventCache = {}
end

function WebEventCache:CacheEvent(id, ...)
    local event = self.eventCache[id] or WebEvent:New()
    event:FromSocket(id, ...)

    self.eventCache[id] = event

    self:SendMessage('RAIDBUILDER_WEBEVENT_LIST_UPDATE')
end

function WebEventCache:IterateEvents()
    return pairs(self.eventCache)
end
