
BuildEnv(...)

AppliedCache = RaidBuilder:NewModule('AppliedCache', 'AceTimer-3.0', 'AceEvent-3.0')

local CHECK_INTERVAL = 60
local APPLIED_TIMEOUT = 1200

function AppliedCache:OnInitialize()
    self.db = RaidBuilder:GetDB()
    self.Limit = 15

    self:ScheduleRepeatingTimer('CheckAppliedList', CHECK_INTERVAL)
end

function AppliedCache:CheckAppliedList()
    local now = time()
    for leader, applyTime in self:IterateAppliedList() do
        if now - applyTime > APPLIED_TIMEOUT then
            self:DeleteApplied(leader)
        end
    end
end

function AppliedCache:AddApplied(leader)
    self.db.profile.appliedCache[leader] = time()
    
    self:SendMessage('RAIDBUILDER_APPLIED_UPDATE')
end

function AppliedCache:DeleteApplied(leader)
    self.db.profile.appliedCache[leader] = nil
    
    self:SendMessage('RAIDBUILDER_APPLIED_UPDATE')
end

function AppliedCache:IsApplied(leader)
    return self.db.profile.appliedCache[leader]
end

function AppliedCache:IterateAppliedList()
    return pairs(self.db.profile.appliedCache)
end

function AppliedCache:IsAnyApplied()
    return not not next(self.db.profile.appliedCache)
end

function AppliedCache:Count()
    local num = 0

    for k, v in pairs(self.db.profile.appliedCache) do
        num = num + 1
    end

    return num
end

function AppliedCache:Max()
    return self.Limit
end
