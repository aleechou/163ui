
BuildEnv(...)

AppliedCache = RaidBuilder:NewModule('AppliedCache', 'AceTimer-3.0', 'AceEvent-3.0')

local CHECK_INTERVAL = 60
local APPLIED_TIMEOUT = 1200

function AppliedCache:OnInitialize()
    self.db = Profile:GetCharacterDB()
    self.Limit = 15

    self:ScheduleRepeatingTimer('CheckAppliedList', CHECK_INTERVAL)
end

function AppliedCache:CheckAppliedList()
    local now = time()
    for leader, v in self:IterateAppliedList() do
        if now - v.applyTime > APPLIED_TIMEOUT then
            self:DeleteApplied(leader)
        end
    end
end

function AppliedCache:GetApplied(leader)
    return self.db.profile.appliedCache[leader]
end

function AppliedCache:AddApplied(leader, role, active)
    local v = self:GetApplied(leader) or {}

    v.applyTime = time()
    v.role = role or v.role
    v.active = active

    self.db.profile.appliedCache[leader] = v
    
    self:SendMessage('RAIDBUILDER_APPLIED_UPDATE')
end

function AppliedCache:DeleteApplied(leader)
    self.db.profile.appliedCache[leader] = nil
    
    self:SendMessage('RAIDBUILDER_APPLIED_UPDATE')
end

function AppliedCache:IsApplied(leader, flag)
    local v = self.db.profile.appliedCache[leader]
    if flag then
        return not not v
    else
        return v and v.active
    end
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
        if v.active then
            num = num + 1
        end
    end
    return num
end

function AppliedCache:Max()
    return self.Limit
end

function AppliedCache:GetAppliedRole(leader)
    local v = self:GetApplied(leader)
    return v and v.role
end
