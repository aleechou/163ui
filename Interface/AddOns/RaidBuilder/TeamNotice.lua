
BuildEnv(...)

local TeamNotice = RaidBuilder:NewModule('TeamNotice', 'AceBucket-3.0', 'AceEvent-3.0')

function TeamNotice:OnInitialize()
    self.memberCache = {}
    self.notLeader = true

    self:RegisterMessage('RAIDBUILDER_SETTING_CHANGED')
end

function TeamNotice:RAIDBUILDER_SETTING_CHANGED(_, key, value)
    if key ~= 'teamNotice' then
        return
    end
    if value then
        self.memberCache = self:GetMemberCache()
        self:RegisterBucketEvent('GROUP_ROSTER_UPDATE', 1)
    else
        self:UnregisterAllBuckets()
    end
end

function TeamNotice:GROUP_ROSTER_UPDATE()
    if UnitInBattleground('player') then
        return
    end

    local cache = self:GetMemberCache()
    local event = EventCache:GetCurrentEvent()
    if event then
        if self:IsFirstRaidLeader() then
            SendChatMessage(L.TEAM_NOTICE_CONTENT:format(event:GetEventName()), IsInRaid(LE_PARTY_CATEGORY_INSTANCE) and 'INSTANCE_CHAT' or 'RAID')
        elseif UnitIsGroupLeader('player') then
            for name in pairs(cache) do
                if not self.memberCache[name] then
                    SendChatMessage(L.TEAM_NOTICE_CONTENT_UNIT:format(event:GetEventName(), GetRoleInfo(GroupCache:GetUnitRole(name) or 'NONE')), 'WHISPER', nil, name)
                end
            end
        end
    end
    self.memberCache = cache
end

function TeamNotice:IsFirstRaidLeader()
    if IsInRaid() and UnitIsGroupLeader('player') then
        if self.notLeader then
            self.notLeader = nil
            return true
        end
    else
        self.notLeader = true
    end
end

function TeamNotice:GetMemberCache()
    local unitPrefix = IsInRaid() and 'raid' or 'party'
    local memberCount = IsInRaid() and GetNumGroupMembers() or GetNumSubgroupMembers()

    local cache = {}
    for i = 1, memberCount do
        local unit = unitPrefix .. i
        if UnitExists(unit) and not UnitIsUnit('player', unit) then
            cache[UnitName(unit)] = true
        end
    end
    return cache
end
