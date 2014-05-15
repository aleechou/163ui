
BuildEnv(...)

Profile = RaidBuilder:NewModule('Profile', 'AceEvent-3.0')

function Profile:OnInitialize()
    local db = {
        profile = {
            eventProfiles = {},
        },
        global = {
            blackList = {},
            setting = {},
        }
    }

    self.db = LibStub('AceDB-3.0'):New('RAIDBUILDER_UI_DB', db)
end

function Profile:SaveEventProfile(event)
    self.db.profile.eventProfiles[event:GetEventCode()] = {
        MinLevel    = event:GetMinLevel(),
        MaxLevel    = event:GetMaxLevel(),
        ItemLevel   = event:GetItemLevel(),
        Summary     = event:GetSummary(),
        PVPRating   = event:GetPVPRating(),
        ForceVerify = event:GetForceVerify(),
        CrossRealm  = event:GetCrossRealm(),
        TotalTANK   = event:GetRoleTotal('TANK'),
        TotalHEALER = event:GetRoleTotal('HEALER'),
        TotalDAMAGER= event:GetRoleTotal('DAMAGER'),
        TotalNONE   = event:GetRoleTotal('NONE'),
    }
end

function Profile:GetEventProfile(eventCode)
    local profile = self.db.profile.eventProfiles[eventCode]
    if profile then
        return Event:New(profile)
    end
end

function Profile:GetDB()
    return self.db
end

function Profile:AddBlackList(battleTag, reason)
    self.db.global.blackList[battleTag] = {
        reason = reason,
        recordDate = time(),
    }
    self:SendMessage('RAIDBUILDER_BLACKLIST_UPDATE')
end

function Profile:DeleteBlackList(battleTag)
    self.db.global.blackList[battleTag] = nil
    self:SendMessage('RAIDBUILDER_BLACKLIST_UPDATE')
end

function Profile:IsInBlackList(battleTag)
    return self.db.global.blackList[battleTag]
end

function Profile:GetBlackList()
    return self.db.global.blackList
end

function Profile:GetReferenced()
    return self.db.global.setting.reference
end

function Profile:SetReferenced(result)
    self.db.global.setting.reference = result
end

function Profile:IsSignIn()
    return self.db.global.setting.signin == date('%Y-%m-%d')
end

function Profile:SetSignIn()
    self.db.global.setting.signin = date('%Y-%m-%d')
end
