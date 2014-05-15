
BuildEnv(...)

MemberCache = RaidBuilder:NewModule('MemberCache', 'AceEvent-3.0', 'AceTimer-3.0')

local CHECK_INTERVAL = 60
local MEMBER_TIMEOUT = 900

function MemberCache:OnInitialize()
    self.db = RaidBuilder:GetDB()
    
    self.memberCache = {}
    self.memberList = {}

    self:RegisterMessage('RAIDBUILDER_EVENT_LOADED')
    self:ScheduleRepeatingTimer('CheckMemberList', CHECK_INTERVAL)
end

function MemberCache:CheckMemberList()
    local now = time()
    for i, v in ipairs(self.db.profile.memberList) do
        local member = self:GetMemberInfo(v)
        if member then
            if now - member:GetApplyTime() > MEMBER_TIMEOUT then
                Logic:RefuseEventMember(member)
            end
        end
    end
end

function MemberCache:RAIDBUILDER_EVENT_LOADED()
    if not EventCache:GetCurrentEvent() then
        wipe(self.db.profile.memberList)
        wipe(self.db.profile.memberCache)
    else
        self:RefreshMemberList()
    end
end

function MemberCache:RefreshMemberList()
    wipe(self.memberList)

    for i, v in ipairs(self.db.profile.memberList) do
        tinsert(self.memberList, self:GetMemberInfo(v))
    end
    self:SendMessage('RAIDBUILDER_MEMBER_LIST_UPDATE')
end

function MemberCache:AddMember(target, role, battleTag, class, level, itemLevel, pvpRating, stats, progression)
    tDeleteItem(self.db.profile.memberList, target)

    local proxy = {
        Name = target,
        Role = role,
        BattleTag = battleTag,
        Class = class,
        Level = level,
        ItemLevel = itemLevel,
        PVPRating = pvpRating,
        Stats = stats,
        Progression = progression,
        ApplyTime = time(),
    }

    tinsert(self.db.profile.memberList, target)

    self.db.profile.memberCache[target] = proxy

    self:RefreshMemberList()
end

function MemberCache:RemoveMember(target)
    self.memberCache[target] = nil
    self.db.profile.memberCache[target] = nil

    tDeleteItem(self.db.profile.memberList, target)

    self:RefreshMemberList()
end

function MemberCache:ClearMemberList()
    wipe(self.db.profile.memberList)
    self:RefreshMemberList()
end

function MemberCache:GetMemberList()
    return self.memberList
end

function MemberCache:GetMemberCount()
    return #self.memberList
end

function MemberCache:GetMemberInfo(target)
    local proxy = self.db.profile.memberCache[target]
    if not proxy then
        return
    end

    self.memberCache[target] = self.memberCache[target] or Member:New(proxy)
    self.memberCache[target]:SetProxy(proxy)
    return self.memberCache[target]
end
