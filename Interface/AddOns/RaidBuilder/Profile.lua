
BuildEnv(...)

Profile = RaidBuilder:NewModule('Profile', 'AceEvent-3.0')

function Profile:OnInitialize()
    local gdb = {
        global = {
            blackList = {},
            setting = {
                -- signin = {},
            },
            favorites = {},
            recentlist = {},
            serverDatas = {},
            annData = {},
            eventProfiles = {},
        }
    }

    for eventCode in pairs(EVENT_NAMES) do
        local data = {
            MinLevel    = GetEventMinLevel(eventCode),
            MaxLevel    = MAX_PLAYER_LEVEL,
            ItemLevel   = 0,
            Summary     = '',
            PVPRating   = 0,
            ForceVerify = false,
            CrossRealm  = GetEventAllowCrossRealm(eventCode),
            Rules       = '',
        }

        data.TotalTANK, data.TotalHEALER,
        data.TotalDAMAGER, data.TotalNONE = GetEventDefaultMemberRole(eventCode)

        gdb.global.eventProfiles[eventCode] = data
    end

    local cdb = {
        profile = {
            eventCache = {},
            memberList = {},
            memberCache = {},
            appliedCache = {},
            groupCacheProfile = {
                unitCache = {},
                unitRoles = {},
            },
            batchApplyProfile = {
                refuseList = {},
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
                panel = UnitFactionGroup('player') ~= 'Neutral',
                panelLock = false,
                storage = { point = 'TOP', x = 0, y = -20},
                teamNotice = true,
                socialEnabled = true,
                eventPusher = true,
                microButton = true,
            },

            sharecontent = false,
        }
    }

    self.gdb = LibStub('AceDB-3.0'):New('RAIDBUILDER_UI_DB', gdb)
    self.cdb = LibStub('AceDB-3.0'):New('RAIDBUILDER_CHARACTER_DB', cdb)

    -- self.gdb.profile.eventProfiles = nil
    -- self.cdb.profile.serverDatas = nil
    self.cdb.profile.settings.minimap = nil
    self.cdb.profile.settings.minimapPack = nil
end

function Profile:OnEnable()
    local settings = {
        'panel',
        'panelLock',
        'teamNotice',
        'microButton',
    }

    for _, key in ipairs(settings) do
        self:SendMessage('RAIDBUILDER_SETTING_CHANGED', key, self.cdb.profile.settings[key])
    end
end

function Profile:SaveEventProfile(event)
    self.gdb.global.eventProfiles[event:GetEventCode()] = {
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
    local profile = self.gdb.global.eventProfiles[eventCode]
    if profile then
        return Event:New(profile)
    end
end

function Profile:GetGlobalDB()
    return self.gdb
end

function Profile:GetCharacterDB()
    return self.cdb
end


function Profile:AddBlackList(battleTag, reason)
    self.gdb.global.blackList[battleTag] = {
        reason = reason,
        recordDate = time(),
    }
    self:SendMessage('RAIDBUILDER_BLACKLIST_UPDATE')
end

function Profile:DeleteBlackList(battleTag)
    self.gdb.global.blackList[battleTag] = nil
    self:SendMessage('RAIDBUILDER_BLACKLIST_UPDATE')
end

function Profile:IsInBlackList(battleTag)
    return self.gdb.global.blackList[battleTag]
end

function Profile:GetBlackList()
    return self.gdb.global.blackList
end

function Profile:GetReferenced()
    return self.gdb.global.setting.reference
end

function Profile:SetReferenced(result)
    self.gdb.global.setting.reference = result
end

-- function Profile:IsSignIn(id)
--     return self.gdb.global.setting.signin[id] == date('%Y-%m-%d')
-- end

-- function Profile:SetSignIn(id)
--     self.gdb.global.setting.signin[id] = date('%Y-%m-%d')
-- end

function Profile:AddFavorite(battleTag, reason, isFav)
    local info = self.gdb.global.favorites[battleTag]
    if info and info.isFav and not isFav then
        return
    end

    self.gdb.global.favorites[battleTag] = {
        reason = reason,
        recordDate = time(),
        isFav = isFav,
        eventCode = info and info.eventCode or nil
    }
    self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
end

function Profile:UpdateFavoriteEventCode(battleTag, eventCode)
    local info = self.gdb.global.favorites[battleTag]
    if info then
        info.eventCode = eventCode
        info.recordDate = time()
        self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
    end
end

function Profile:DeleteFavorite(battleTag)
    local info = self.gdb.global.favorites[battleTag]
    if not info then
        return
    end

    self.gdb.global.favorites[battleTag] = nil
    self:SendMessage('RAIDBUILDER_FAVORITES_UPDATE')
end

function Profile:GetFavorites()
    return self.gdb.global.favorites
end

function Profile:IsInFavorite(battleTag, isFav)
    local info = self.gdb.global.favorites[battleTag]
    if not info then
        return false
    end
    if isFav then
        return info.isFav
    else
        return not not info
    end
end

function Profile:AddRecentList(name, realm, race, class, level, battleTag, from)
    local list = self.gdb.global.recentlist
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
    return self.gdb.global.recentlist
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

    -- self:RefreshAnnData()
end

function Profile:GetAnnList()
    return self.gdb.global.annData
end

function Profile:SetAnnRead(index)
    local list = self:GetAnnList()

    if list[index] then
        list[index].unread = nil
    end

    -- self:RefreshAnnData()
end

function Profile:GetCurrentAnnData()
    local list = self:GetAnnList()
    return list and list[1]
end

-- function Profile:RefreshAnnData()
--     local hasUnread = false
--     for i, v in ipairs(self:GetAnnList()) do
--         if v.unread then
--             hasUnread = true
--             break
--         end
--     end
--     self:SendMessage('RAIDBUILDER_ANNOUNCEMENT_UPDATE', hasUnread)
-- end

function Profile:IsYiXinValid()
    local db = self.cdb.profile.yiXin
    local flag = db.times > 2 and db.lastSend > GetGameDateTime(true) and 0 or 1
    return flag == 1
end

function Profile:IsSocialEnabled()
    return self.cdb.profile.settings.socialEnabled
end

function Profile:SaveVersion()
    self.gdb.global.version = ADDON_VERSION
end

function Profile:IsNewVersion()
    local pVersion = tonumber(self.gdb.global.version) or 0
    local cVersion = tonumber(ADDON_VERSION) or 0

    return pVersion < cVersion
end

function Profile:GetDefalutPanel()
    return self.cdb.profile.settings.defaultPanel
end

function Profile:SetDefaultPanel(index)
    self.cdb.profile.settings.defaultPanel = index
end

function Profile:GetBatchApplyProfile()
    return self.cdb.profile.batchApplyProfile
end
