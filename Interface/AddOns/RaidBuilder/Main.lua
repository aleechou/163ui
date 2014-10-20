
BuildEnv(...)

_G.BINDING_HEADER_RAIDBUILDER = ADDON_TITLE
_G.BINDING_NAME_RAIDBUILDER_TOGGLE = L['打开主界面']

GUI = LibStub('NetEaseGUI-1.0')

RaidBuilder = LibStub('AceAddon-3.0'):NewAddon('RaidBuilder',
    'AceEvent-3.0',
    'AceHook-3.0',
    'LibModule-1.0',
    'LibClass-1.0')

function RaidBuilder:OnInitialize()
    self:RawHook('PromoteToLeader', 'PromoteToLeader', true)
    self:RawHook('LeaveParty', 'LeaveParty', true)
end

function RaidBuilder:PromoteToLeader(arg1, arg2)
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

function RaidBuilder:SetSocialEnabled(flag)
    self.socialServerEnabled = flag

    if flag and Profile:IsSocialEnabled() then
        LoadAddOn('WowSocial')
    end
end

function RaidBuilder:IsSocialServerEnabled()
    return self.socialServerEnabled
end
