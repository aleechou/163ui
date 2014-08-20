
BuildEnv(...)

Profile = RaidBuilder:NewModule('Profile', 'AceEvent-3.0')

function Profile:OnInitialize()
    local globaldb = {
        global = {
            blackList = {},
            setting = {
                signin = {},
            },
            favorites = {},
            recentlist = {},
            serverDatas = {},
            annData = {},
            eventProfiles = {},
        }
    }

    local characterdb = {
        profile = {
            eventCache = {},
            memberList = {},
            memberCache = {},
            appliedCache = {},
            groupCacheProfile = {
                unitCache = {},
                unitRoles = {},
            },
            inviteQueue = {},
            inviteBNets = {},
            webInvite = {},

            logs = {},

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
                socialEnabled = true,
                eventPusher = true,
            },

            sharecontent = false,
        }
    }

    self.globaldb = LibStub('AceDB-3.0'):New('RAIDBUILDER_UI_DB', globaldb)
    self.characterdb = LibStub('AceDB-3.0'):New('RAIDBUILDER_CHARACTER_DB', characterdb)

    self.globaldb.profile.eventProfiles = nil
    self.characterdb.profile.serverDatas = nil
end

function Profile:OnEnable()
    local settings = {
        'minimap',
        'minimapPack',
        'panel',
        'panelLock',
        'teamNotice',
    }

    for _, key in ipairs(settings) do
        self:SendMessage('RAIDBUILDER_SETTING_CHANGED', key, self.characterdb.profile.settings[key])
    end
end

function Profile:SaveEventProfile(event)
    self.globaldb.global.eventProfiles[event:GetEventCode()] = {
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
    local profile = self.globaldb.global.eventProfiles[eventCode]
    if profile then
        return Event:New(profile)
    end
end

function Profile:GetGlobalDB()
    return self.globaldb
end

function Profile:GetCharacterDB()
    return self.characterdb
end


function Profile:AddBlackList(battleTag, reason)
    self.globaldb.global.blackList[battleTag] = {
        reason = reason,
        recordDate = time(),
    }
    self:SendMessage('RAIDBUILDER_BLACKLIST_UPDATE')
end

function Profile:DeleteBlackList(battleTag)
    self.globaldb.global.blackList[battleTag] = nil
    self:SendMessage('RAIDBUILDER_BLACKLIST_UPDATE')
end

function Profile:IsInBlackList(battleTag)
    return self.globaldb.global.blackList[battleTag]
end

function Profile:GetBlackList()
    return self.globaldb.global.blackList
end

function Profile:GetReferenced()
    return self.globaldb.global.setting.reference
end

function Profile:SetReferenced(result)
    self.globaldb.global.setting.reference = result
end

function Profile:IsSignIn(id)
    return self.globaldb.global.setting.signin[id] == date('%Y-%m-%d')
end

function Profile:SetSignIn(id)
    self.globaldb.global.setting.signin[id] = date('%Y-%m-%d')
end

function Profile:AddFavorite(battleTag, reason)
    self.globaldb.global.favorites[battleTag] = {
        reason = reason,
        recordDate = time(),
    }
    self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
end

function Profile:DeleteFavorite(battleTag)
    self.globaldb.global.favorites[battleTag] = nil
    self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
end

function Profile:GetFavorites()
    return self.globaldb.global.favorites
end

function Profile:IsInFavorite(battleTag)
    return self.globaldb.global.favorites[battleTag]
end

function Profile:AddRecentList(name, realm, race, class, level, battleTag, from)
    local list = self.globaldb.global.recentlist
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
    return self.globaldb.global.recentlist
end

function Profile:AddAnnData(title, content)
    local data
    local list = self:GetAnnList()

    for i, v in ipairs(list) do
        if v.title == title and v.content == content then
            data = tremove(list, i)
            break
        end
    end

    tinsert(list, 1, data or {
        title = title,
        content = content,
        unread = true
    })

    self:RefreshAnnData()
end

function Profile:GetAnnList()
    return self.globaldb.global.annData
end

function Profile:SetAnnRead(index)
    local list = self:GetAnnList()

    if list[index] then
        list[index].unread = nil
    end

    self:RefreshAnnData()
end

function Profile:RefreshAnnData()
    local hasUnread = false
    for i, v in ipairs(self:GetAnnList()) do
        if v.unread then
            hasUnread = true
            break
        end
    end
    self:SendMessage('RAIDBUILDER_ANNOUNCEMENT_UPDATE', hasUnread)
end

function Profile:IsYiXinValid()
    local db = self.characterdb.profile.yiXin
    local flag = db.times > 2 and db.lastSend > GetGameDateTime(true) and 0 or 1
    return flag == 1
end

function Profile:IsSocialEnabled()
    return self.characterdb.profile.settings.socialEnabled
end

function Profile:SaveVersion()
    self.globaldb.global.version = GetAddOnMetadata('RaidBuilder', 'Version')
end

function Profile:IsNewVersion()
    local pVersion = tonumber(self.globaldb.global.version) or 0
    local cVersion = tonumber(GetAddOnMetadata('RaidBuilder', 'Version')) or 0

    return pVersion < cVersion
end
