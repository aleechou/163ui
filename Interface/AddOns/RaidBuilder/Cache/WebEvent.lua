
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
    'EventName',
    'Faction',

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
            self:GetEventSource(),
            self:GetEventName(),
            self:GetFaction(),
            self:GetTimeStamp()
end

function WebEvent:FromSocket(...)
    local eventId, eventCode, personNum, leader, leaderLevel, leaderItemLevel, eventSource, eventName, faction, timeStamp = ...

    self:SetEventId(eventId)
    self:SetEventCode(eventCode)
    self:SetPersonNum(personNum)
    self:SetLeader(leader)
    self:SetLevel(leaderLevel)
    self:SetItemLevel(leaderItemLevel)
    self:SetEventSource(eventSource)
    self:SetEventName(eventName)
    self:SetFaction(faction)
    self:SetTimeStamp(timeStamp)
end

function WebEvent:Match(text)
    if not text or text == '' then
        return true
    end

    text = text:lower()

    if self:GetLeader():lower():match(text) then
        return true
    end
    if self:GetEventName():lower():match(text) then
        return true
    end
    return false
end
