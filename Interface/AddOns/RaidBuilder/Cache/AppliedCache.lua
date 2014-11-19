
BuildEnv(...)

AppliedCache = RaidBuilder:NewModule('AppliedCache', 'AceTimer-3.0', 'AceEvent-3.0')

local CHECK_INTERVAL = 60
local APPLIED_TIMEOUT = 1200
local APPLIED_TIMEOUT_AUTO = 300

function AppliedCache:OnInitialize()
    self.db = Profile:GetCharacterDB()
    self.Limit = 15

    self.applyTimers = {}

    self:ScheduleRepeatingTimer('CheckAppliedList', CHECK_INTERVAL)
end

function AppliedCache:CheckAppliedList()
    for leader, v in self:IterateAppliedList() do
        if self:IsAppliedTimeout(leader) then
            self:DeleteApplied(leader)

            self:SendMessage('RAIDBUILDER_APPLY_TIMEOUT', leader)
        end
    end
end

function AppliedCache:IsAppliedTimeout(leader)
    local v = self:GetApplied(leader)
    if not v then
        return true
    end
    if v.isAutoApply then
        return time() - v.applyTime > APPLIED_TIMEOUT_AUTO
    else
        return time() - v.applyTime > APPLIED_TIMEOUT
    end
end

function AppliedCache:GetApplied(leader)
    return self.db.profile.appliedCache[leader]
end

function AppliedCache:AddApplied(leader, role, active, isAutoApply)
    local v = self:GetApplied(leader) or {}

    v.applyTime = time()
    v.role = role or v.role
    v.isAutoApply = isAutoApply or v.isAutoApply
    v.active = active

    if not active then
        self.applyTimers[leader] = self:ScheduleTimer('OnApplyTimeout', 10, leader)
    else
        self:CancelTimer(self.applyTimers[leader])
    end

    self.db.profile.appliedCache[leader] = v
    
    self:SendMessage('RAIDBUILDER_APPLY_UPDATE')
end

function AppliedCache:OnApplyTimeout(leader)
    EventCache:RemoveEvent(leader)
    self:DeleteApplied(leader)
end

function AppliedCache:DeleteApplied(leader)
    self.db.profile.appliedCache[leader] = nil
    
    self:SendMessage('RAIDBUILDER_APPLY_UPDATE')
end

function AppliedCache:IsApplied(leader, flag)
    local v = self.db.profile.appliedCache[leader]
    if flag then
        return not not v
    else
        return v and v.active
    end
end

function AppliedCache:IsAutoApplied(leader)
    local v = self.db.profile.appliedCache[leader]
    return v and v.isAutoApply
end

function AppliedCache:IterateAppliedList()
    return pairs(self.db.profile.appliedCache)
end

function AppliedCache:IsAnyApplied()
    return not not next(self.db.profile.appliedCache)
end

function AppliedCache:Count()
    local appliedCount = 0
    local allCount = 0

    for k, v in pairs(self.db.profile.appliedCache) do
        if v.active then
            appliedCount = appliedCount + 1
        end
        allCount = allCount + 1
    end
    return appliedCount, allCount
end

function AppliedCache:Max()
    return self.Limit
end

function AppliedCache:IsCanApply()
    return select(2, self:Count()) < self:Max()
end

function AppliedCache:GetAppliedRole(leader)
    local v = self:GetApplied(leader)
    return v and v.role
end
