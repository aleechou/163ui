
BuildEnv(...)

_G.BINDING_HEADER_RAIDBUILDER = ADDON_NAME
_G.BINDING_NAME_RAIDBUILDER_TOGGLE = L['打开主界面']

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
            appliedCache = {},
            logs = {},
            serverDatas = {},
            yiXin = {
                times = 0,
                lastSend = GetGameDateTime(),
            },
            minimap = {
                minimapPos = 243,
            },
            settings = {
                minimap = true,
                minimapPack = false,
                panel = UnitFactionGroup('player') ~= 'Neutral',
                panelLock = false,
                storage = { point = 'TOP', x = 0, y = -20},
                teamNotice = true,
            },
            inviteQueue = {},
            inviteBNets = {},
            webInvite = {},
            sharecontent = false,

            groupCacheProfile = {
                unitCache = {},
                unitRoles = {},
            },
        }
    }

    self.db = LibStub('AceDB-3.0'):New('RAIDBUILDER_CHARACTER_DB', default)

    self:RawHook('PromoteToLeader', 'PromoteToLeader', true)
    self:RawHook('LeaveParty', 'LeaveParty', true)

    self:RegisterEvent('PLAYER_LOGIN', function()
        self:UnregisterEvent('PLAYER_LOGIN')

        local settings = {
            'minimap',
            'minimapPack',
            'panel',
            'panelLock',
            'teamNotice',
        }

        for _, key in ipairs(settings) do
            self:SendMessage('RAIDBUILDER_SETTING_CHANGED', key, self.db.profile.settings[key])
        end
    end)
end

function RaidBuilder:PromoteToLeader(...)
    local arg1, arg2 = ...
    if EventCache:GetCurrentEvent() then
        GUI:CallMessageDialog(L['当前正在组织活动，转移队长将解散当前活动，是否继续？'], function(result)
            if result then
                Logic:DisbandEvent()
                self.hooks.PromoteToLeader(arg1, arg2)
            end
        end)
    else
        return self.hooks.PromoteToLeader(arg1, arg2)
    end
end

function RaidBuilder:LeaveParty()
    if EventCache:GetCurrentEvent() and UnitIsGroupLeader('player') and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        GUI:CallMessageDialog(L['当前正在组织活动，离开队伍将解散当前活动，是否继续？'], function(result)
            if result then
                Logic:DisbandEvent()
                self.hooks.LeaveParty()
            end
        end)
    else
        return self.hooks.LeaveParty()
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
