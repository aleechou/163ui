
BuildEnv(...)

Profile = RaidBuilder:NewModule('Profile', 'AceEvent-3.0')

function Profile:OnInitialize()
    local db = {
        profile = {
            eventProfiles = {},
        },
        global = {
            blackList = {},
            setting = {
                signin = {},
            },
            favorites = {},
            recentlist = {},
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
        Rules       = event:GetRules(),
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

function Profile:IsSignIn(id)
    return self.db.global.setting.signin[id] == date('%Y-%m-%d')
end

function Profile:SetSignIn(id)
    self.db.global.setting.signin[id] = date('%Y-%m-%d')
end

function Profile:AddFavorite(battleTag, reason)
    self.db.global.favorites[battleTag] = {
        reason = reason,
        recordDate = time(),
    }
    self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
end

function Profile:DeleteFavorite(battleTag)
    self.db.global.favorites[battleTag] = nil
    self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
end

function Profile:GetFavorites()
    return self.db.global.favorites
end

function Profile:IsInFavorite(battleTag)
    return self.db.global.favorites[battleTag]
end

function Profile:AddRecentList(name, realm, race, class, level, battleTag, from)
    local list = self.db.global.recentlist
    self.RecentCache = self.RecentCache or {}

    if #list >= 80 then
        tremove(list, #list)
    end

    local signature = name .. realm .. from .. date('%Y-%m-%d', time())
    if self.RecentCache[signature] then
        return
    else
        self.RecentCache[signature] = true
    end

    for i, v in ipairs(list) do
        if v.name == name and v.realm == realm and v.from == from and date('%Y-%m-%d', v.recordDate) == date('%Y-%m-%d', time()) then
            return
        end
    end
    
    tinsert(list, 1, {
        name        = name,
        realm       = realm,
        race        = race,
        class       = class,
        level       = level,
        battleTag   = battleTag,
        from        = from,
        recordDate  = time(),
    })

    self:SendMessage('RAIDBUILDER_RECENTLIST_UPDATE')
end

function Profile:GetRecentList()
    return self.db.global.recentlist
end
