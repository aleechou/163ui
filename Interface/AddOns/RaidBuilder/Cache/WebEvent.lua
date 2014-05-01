
BuildEnv(...)

WebEvent = (RaidBuilder or Addon):NewClass('WebEvent')

function WebEvent:Constructor(proxy)
    self.proxy = proxy or {

    }
end

local attr = {
    'EventId',
    'EventCode',
    'PersonNum',
    'Leader',
    'Level',
    'ItemLevel',
    'EventSource',

    'TimeStamp',
}

for i, v in ipairs(attr) do
    WebEvent['Set' .. v] = function(self, value)
        self.proxy[v] = value
    end

    WebEvent['Get' .. v] = function(self)
        return self.proxy[v]
    end
end

function WebEvent:ToSocket()
    return  self:GetEventId(),
            self:GetEventCode(),
            self:GetPersonNum(),
            self:GetLeader(),
            self:GetLevel(),
            self:GetItemLevel(),
            self:GetEventSource()
end

function WebEvent:FromSocket(...)
    local eventId, eventCode, personNum, leader, leaderLevel, leaderItemLevel, eventSource = ...

    self:SetEventId(eventId)
    self:SetEventCode(eventCode)
    self:SetPersonNum(personNum)
    self:SetLeader(leader)
    self:SetLevel(leaderLevel)
    self:SetItemLevel(leaderItemLevel)
    self:SetEventSource(eventSource)
end

function WebEvent:Match(eventCode, leader)
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

WebEvent.GetEventName = Event.GetEventName
