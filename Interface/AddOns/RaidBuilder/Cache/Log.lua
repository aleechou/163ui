
BuildEnv(...)

Log = RaidBuilder:NewModule('Log', 'AceEvent-3.0', 'AceTimer-3.0')

function Log:OnInitialize()
    self.db = RaidBuilder:GetDB()
end

function Log:InsertLog(msg)
    if #self.db.profile.logs >= 1000 then
        tremove(self.db.profile.logs, 1)
    end

    msg = date('|cff00ffff%Y/%m/%d %H:%M:%S|r ') .. msg:gsub('%s', ' ')
    tinsert(self.db.profile.logs, msg)
    self:SendMessage('RAIDBUILDER_LOG_ADDED', msg)
end

function Log:ClearLogs()
    wipe(self.db.profile.logs)
    self:SendMessage('RAIDBUILDER_LOG_CLEARED')
end

function Log:GetLogs()
    return self.db.profile.logs
end
