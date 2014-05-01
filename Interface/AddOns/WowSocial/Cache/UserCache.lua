
BuildEnv(...)

UserCache = Cloud:NewModule('UserCache', 'AceEvent-3.0')

function UserCache:OnInitialize()
    self.db = self:InitDB('WOWSOCIAL_DB_USER')
    self.onlineCache = {}

    self:RegisterMessage('NE_LOGIC_LOGIN_SUCCESS')
    self:RegisterMessage('NE_LOGIC_USER_INFO')

    self:RegisterEvent('CHAT_MSG_CHANNEL_JOIN')
    self:RegisterEvent('CHAT_MSG_CHANNEL_LEAVE')
    self:RegisterEvent('CHAT_MSG_CHANNEL')
end

function UserCache:InitDB(name)
    _G[name] = _G[name] or {}
    return _G[name]
end

function UserCache:GetUserInfo(name)
    return self.db[GetFullName(name)]
end

function UserCache:CreateUserInfo(name)
    name = GetFullName(name)

    self.db[name] = {}

    return self.db[name]
end

function UserCache:RequestUserInfo(name)
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'RequestUserInfo' (string expected, got %s)]]):format(type(name)), 2)
    end

    name = GetFullName(name)

    local info = self:GetUserInfo(name)

    Cloud:GetModule('Logic'):SendServer('COMM_USER_INFO_REQ', name, info and info.InfoStamp or nil)
end

function UserCache:NE_LOGIC_USER_INFO(event, name, stamp, avatar, interest, onlineTime, city, summary, level, class, race)
    local info = self:GetUserInfo(name) or self:CreateUserInfo(name)

    if stamp then
        info.InfoStamp = stamp
        info.OnlineTime = onlineTime
        info.City = city
        info.Interest = interest
        info.Summary = summary
        info.Avatar = avatar
        info.Level = level
        info.Class = class
        info.Race = race
    end

    self:SendMessage('NECLOUD_USER_INFO', name)
end

function UserCache:CHAT_MSG_CHANNEL_JOIN(event, _, target, _, _, _, _, _, id, _, _, _, guid)
    if not guid then
        return
    end
    if id ~= select(2, Channel:GetBroadChat()) then
        return
    end
    self:CacheUserBaseInfo(guid, true)
end

function UserCache:CHAT_MSG_CHANNEL_LEAVE(event, _, target, _, _, _, _, _, id, _, _, _, guid)
    if not guid then
        return
    end
    if id ~= select(2, Channel:GetBroadChat()) then
        return
    end
    self:CacheUserBaseInfo(guid, false)
end

function UserCache:CHAT_MSG_CHANNEL(event, _, target, _, _, _, _, _, id, _, _, _, guid)
    if not guid then
        return
    end
    if id ~= select(2, Channel:GetBroadChat()) then
        return
    end
    self:CacheUserBaseInfo(guid, true)
end

function UserCache:NE_LOGIC_LOGIN_SUCCESS()
    local info = self:GetUserInfo(PLAYER_NAME) or self:CreateUserInfo(PLAYER_NAME)

    self:CacheUserBaseInfo(UnitGUID('player'), true)
    self:RequestUserInfo(PLAYER_NAME)
end

function UserCache:CacheUserBaseInfo(guid, online)
    if not guid or guid == '' then
        return
    end
    local _, classTag, _, raceTag, sex, name, realm = GetPlayerInfoByGUID(guid)
    local target = GetFullName(name, realm)

    local info = self:GetUserInfo(target) or self:CreateUserInfo(target)
    
    info.Class = classTag
    info.Race = raceTag
    info.Guid = guid
    info.Sex = sex

    self:SetUserOnline(target, online)

    self:SendMessage('NE_LOGIC_USER_STATUS', target)
end

function UserCache:IsUserOnline(target)
    return self.onlineCache[target]
end

function UserCache:SetUserOnline(target, flag)
    self.onlineCache[target] = flag and true or nil
end
