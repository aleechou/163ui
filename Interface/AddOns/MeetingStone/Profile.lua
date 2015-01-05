
BuildEnv(...)

Profile = Addon:NewModule('Profile', 'AceEvent-3.0')

function Profile:OnInitialize()
    local gdb = {
        global = {
            ActivityProfiles = {
                Voice = nil,
                VoiceSoft = nil,
            },
            annData = {},
            serverDatas = {},
        }
    }

    local cdb = {
        profile = {
            settings = {
                storage = { point = 'TOP', x = 0, y = -20},
            }
        }
    }

    self.gdb = LibStub('AceDB-3.0'):New('MEETINGSTONE_UI_DB', gdb)
    self.cdb = LibStub('AceDB-3.0'):New('MEETINGSTONE_CHARACTER_DB', cdb)
end

function Profile:OnEnable()
end

function Profile:SaveActivityProfile(activity)
    self.gdb.global.ActivityProfiles.Voice = activity:GetActivityVoice()

    self.gdb.global.ActivityProfiles[activity:GetActivityTypeText()] = {
        ActivityItemLevel   = activity:GetActivityItemLevel(),
        ActivitySummary     = activity:GetActivitySummary(),
        MinLevel    = activity:GetMinLevel(),
        MaxLevel    = activity:GetMaxLevel(),
        PvPRating   = activity:GetPvPRating(),
    }
end

function Profile:GetActivityProfile(activityType)
    return self.gdb.global.ActivityProfiles[activityType], self.gdb.global.ActivityProfiles.Voice
end

function Profile:GetGlobalDB()
    return self.gdb
end

function Profile:GetCharacterDB()
    return self.cdb
end

function Profile:GetLastSearchValue()
    return self.cdb.profile.lastSearchValue or '6-0-0-0'
end

function Profile:SetLastSearchValue(searchValue)
    self.cdb.profile.lastSearchValue = searchValue
end

function Profile:SaveVersion()
    self.gdb.global.version = ADDON_VERSION
end

function Profile:IsNewVersion()
    local pVersion = tonumber(self.gdb.global.version) or 0
    local cVersion = tonumber(ADDON_VERSION) or 0

    return pVersion < cVersion
end

function Profile:IsAnnReaded()
    return not self.gdb.global.annData.notRead
end

function Profile:SetAnnReaded()
    self.gdb.global.annData.notRead = nil
end

function Profile:GetAnnData()
    local annData = self.gdb.global.annData
    return annData.title, annData.content
end

function Profile:SetAnnData(title, content)
    local annData = self.gdb.global.annData
    annData.title, annData.content, annData.notRead = title, content, true
end
