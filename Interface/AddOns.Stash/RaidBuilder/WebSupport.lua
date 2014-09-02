
BuildEnv(...)

WebSupport = RaidBuilder:NewModule('WebSupport', 'AceEvent-3.0', 'AceTimer-3.0')

local Base64 = LibStub('NetEaseBase64-1.0')

local SUPPORT_EVENTCODES = {
    [0x1B7B200] = true,
    [0x1B7B400] = true,
    [0x1B7B600] = true,
}

local RAIDBUILDER_DIFFICULTY_NAMES = {
    [ 3] = '10人',
    [ 4] = '25人',
    [ 5] = '10人',
    [ 6] = '25人',
    [14] = '弹性',
}

function WebSupport:OnInitialize()
    self:RegisterEvent('ZONE_CHANGED', 'UpdateZone')
    self:RegisterEvent('ZONE_CHANGED_INDOORS', 'UpdateZone')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'UpdateZone')
    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'UpdateZone')

    self.db = Profile:GetCharacterDB().profile.webInvite

    if not self.db.record or time() - self.db.record > 3600 then
        wipe(self.db)
    end
    if self.db.code then
        self:SetInviteCode(self.db.code)
    end

    self:RegisterEvent('PLAYER_LOGOUT', function()
        if self.db.code and self.db.code ~= '' then
            self.db.record = time()
        else
            wipe(self.db)
        end
    end)
end

function WebSupport:UpdateZone()
    local eventCode = self:GetZoneEventCode()
    if eventCode and self.eventCode == eventCode and SUPPORT_EVENTCODES[eventCode] then
        self:RegisterEvent('ENCOUNTER_END')
        self:SendMessage('RAIDBUILDER_WEBSUPPORT_UPDATE', true)
    else
        self:UnregisterEvent('ENCOUNTER_END')
        self:SendMessage('RAIDBUILDER_WEBSUPPORT_UPDATE', false)
    end
end

function WebSupport:GetZoneEventCode()
    local name, _, difficulty = GetInstanceInfo()
    local difficultyName = RAIDBUILDER_DIFFICULTY_NAMES[difficulty]

    return EVENT_TYPES[name] or (difficultyName and EVENT_TYPES[name .. '-' .. difficultyName])
end

function WebSupport:ENCOUNTER_END(_, id, name, _, _, status)
    if status == 1 then
        self:CommitNewbie(name)
    end
end

function WebSupport:CommitNewbie(name)
    local list = {}
    for i, unit in ipairs(GetGroupUnitList()) do
        if UnitExists(unit) then
            local name = UnitFullName(unit)
            if self.newbieList[name] then
                tinsert(list, UnitGUID(unit))
            end
        end
    end
    if #list > 0 then
        Logic:SendServer('SWN', UnitGUID('player'), self:GetEventId(), name, unpack(list)) 
    end
end

function WebSupport:SetInviteCode(code)
    self:SendMessage('RAIDBUILDER_WEBSUPPORT_DATA_UPDATE', self:DeserializeCode(code))
    self:UpdateZone()
end

function WebSupport:DeserializeCode(code)
    if code and code == self.db.code and self.eventCode then
        return true, L['开始邀请'], self.inviteList, self.eventCode, self.eventId, self.eventSource, self.eventTime
    end

    wipe(self.db)
    self.inviteList = nil
    self.newbieList = nil
    self.eventCode = nil
    self.eventId = nil
    self.eventSource = nil
    self.eventTime = nil

    local crc, base64 = code:match('^%s*([%S]+)%s+([%S]+)%s*$')
    if not crc or not base64 then
        return false, L['组队码错误']
    end

    crc = tonumber(crc)
    if not crc then
        return false, L['组队码错误']
    end

    local data = Base64:DeCode(base64)
    if crc ~= crc32(data) then
        return false, L['组队码验证失败']
    end

    local m = gmatch(data, '[%S]+')

    local title = m()
    if not title then
        return false, L['组队码错误']
    end

    local eventId, eventCode, eventTime, eventSource = tonumberall(strsplit(',', title))
    if not eventId or not eventCode or not eventTime or not eventSource then
        return false, L['组队码错误']
    end

    local inviteList = {}
    local newbieList = {}

    for line in m do
        local btag, name, realm, isNewbie = strsplit(',', line)

        tinsert(inviteList, {
            btag = btag,
            name = name,
            realm = realm,
        })

        if isNewbie == '1' then
            newbieList[name .. '-' .. realm] = true
        end
    end

    if #inviteList == 0 then
        return false, L['名单信息错误']
    end

    self.inviteList = inviteList
    self.newbieList = newbieList
    self.eventId = eventId
    self.eventCode = OLD_EVENT_CODE[eventCode] or eventCode
    self.eventSource = eventSource
    self.eventTime = eventTime

    self.db.code = code
    self.db.record = time()

    return true, L['开始邀请'], self.inviteList, self.eventCode, self.eventId, self.eventSource, self.eventTime
end

function WebSupport:GetEventCode()
    return self.eventCode
end

function WebSupport:GetWebCode()
    return self.db.code
end

function WebSupport:GetInviteList()
    return self.inviteList
end

function WebSupport:GetEventId()
    return self.eventId
end
