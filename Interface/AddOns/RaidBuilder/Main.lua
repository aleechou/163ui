
BuildEnv(...)

GUI = LibStub('NetEaseGUI-1.0')

RaidBuilder = LibStub('AceAddon-3.0'):NewAddon('RaidBuilder',
    'AceEvent-3.0',
    'AceHook-3.0',
    'LibModule-1.0',
    'LibClass-1.0')

function RaidBuilder:OnInitialize()
    local default = {
        profile = {
            eventCache = {},
            memberList = {},
            memberCache = {},
            memberRoles = {},
            appliedCache = {},
            otherMemberRoles = {},
            logs = {},
            serverDatas = {},
            yiXin = {
                times = 0,
                lastSend = GetGameDateTime(),
            },
            minimap = {
                minimapPos = 243,
            }
        }
    }

    self.db = LibStub('AceDB-3.0'):New('RAIDBUILDER_CHARACTER_DB', default)

    self:RawHook('PromoteToLeader', 'PromoteToLeader', true)
    self:RawHook('LeaveParty', 'LeaveParty', true)
end

function RaidBuilder:PromoteToLeader(...)
    if EventCache:GetCurrentEvent() then
        System:Error(L['当前正在组织活动，不能转移队长。'])
    else
        return self.hooks.PromoteToLeader(...)
    end
end

function RaidBuilder:LeaveParty(...)
    if EventCache:GetCurrentEvent() and UnitIsGroupLeader('player') and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        System:Error(L['当前正在组织活动，不能离开队伍，请先解散活动。'])
    else
        return self.hooks.LeaveParty(...)
    end
end

function RaidBuilder:GetDB()
    return self.db
end

function RaidBuilder:IsYiXinValid()
    local db = self:GetDB().profile.yiXin
    local flag = db.times > 2 and db.lastSend > GetGameDateTime(true) and 0 or 1
    return flag == 1
end
