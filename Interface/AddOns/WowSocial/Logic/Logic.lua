
local ADDON_NAME = ...

BuildEnv(...)

Logic = Cloud:NewModule('Logic',
    'AceEvent-3.0',
    'AceTimer-3.0',
    'NetEaseSocketClient-1.0')

local Base64 = LibStub('NetEaseBase64-1.0')
local AceSerializer = LibStub('AceSerializer-3.0')

Logic.timers = {}

local comm_events = {
    COMM_USER_INFO              = 'NE_LOGIC_USER_INFO',
    COMM_GROUP_INFO             = 'NE_LOGIC_GROUP_INFO',
    COMM_GROUP_LIST             = 'NE_LOGIC_GROUP_LIST',
    COMM_GROUP_JOIN             = 'NE_LOGIC_GROUP_JOIN',
    COMM_GROUP_USER_LIST        = 'NE_LOGIC_GROUP_USER_LIST',

    COMM_GROUP_JOIN_LIST        = 'NE_LOGIC_GROUP_JOIN_LIST',
    
    COMM_GROUP_JOIN_SUCCESS     = 'NE_LOGIC_GROUP_JOIN_SUCCESS',
    COMM_GROUP_JOIN_FAILED      = 'NE_LOGIC_GROUP_JOIN_FAILED',

    COMM_GROUP_KICK_SUCCESS     = 'NE_LOGIC_GROUP_KICK_SUCCESS',
    COMM_GROUP_KICK_FAILED      = 'NE_LOGIC_GROUP_KICK_FAILED',

    COMM_GROUP_LEAVE_FAILED     = 'NE_LOGIC_GROUP_LEAVE_FAILED',

    COMM_GROUP_SEARCH           = 'NE_LOGIC_SEARCH',

    COMM_LOGIN_SUCCESS          = 'NE_LOGIC_LOGIN_SUCCESS',
    -- COMM_CHANNEL                = 'NE_LOGIC_CHANNEL_UPDATE',

    COMM_LOGIN_FAILED           = 'NECLOUD_LOGIN_FAILED',
    COMM_GROUP_INFO_SAVED       = 'NECLOUD_GROUP_INFO_SAVED',
    COMM_NEWVERSION             = 'NECLOUD_NEWVERSION',
    COMM_MSG                    = 'NECLOUD_MSG',
}

function Logic:InitDB(name)
    _G[name] = _G[name] or {}
    return _G[name]
end

function Logic:OnInitialize()
    self.db = self:InitDB('WOWSOCIAL_DB_MISC')
    self.db.annList = self.db.annList or {}

    for k, v in pairs(comm_events) do
        self:RegisterServer(k, 'OnServerRecv')
    end

    self:RegisterServer('SOCKET_CONNECTED')
    self:RegisterServer('SOCKET_DISCONNECTED', 'SOCKET_DISCONNECTED')

    self:RegisterServer('COMM_GROUP_CREATE_SUCCESS')
    self:RegisterServer('COMM_GROUP_CREATE_FAILED')
    self:RegisterServer('COMM_GROUP_LEAVE_SUCCESS')
    self:RegisterServer('COMM_GROUP_INVITE')
    self:RegisterServer('COMM_GROUP_INVITE_FAILED')
    self:RegisterServer('COMM_GROUP_JOIN_FAILED')
    self:RegisterServer('COMM_GROUP_JOIN_SUCCESS')
    self:RegisterServer('COMM_ANNOUNCEMENT')

    self:RegisterServer('GD', 'NEBROAD_GROUP_DISBAND')
    self:RegisterServer('GL', 'NEBROAD_GROUP_LEAVE')
    self:RegisterServer('GJ', 'NEBROAD_GROUP_JOIN')
    self:RegisterServer('GK', 'NEBROAD_GROUP_KICK')
    self:RegisterServer('GI', 'NEBROAD_GROUP_INFO')
    self:RegisterServer('GC', 'NEBROAD_GROUP_JOIN_CANCEL')
    self:RegisterServer('GSM','NEBROAD_GROUP_SETMANAGER')
    self:RegisterServer('GUJ','NEBROAD_GROUP_USERJOIN')

    self:ConnectServer('NE_CLOUD', 'WOWCLOUD1')
end

function Logic:SOCKET_CONNECTED()
    self:SendServer('COMM_LOGIN',
        self:GetAddonVersion(),
        UnitFactionGroup('player'),
        UnitLevel('player'),
        UnitGUID('player'),
        (select(2, UnitClass('player'))))
end

function Logic:SOCKET_DISCONNECTED()
    self:ConnectServer('NE_CLOUD', 'WOWCLOUD1')
    self:SendMessage('NECLOUD_SERVER_OFFLINE')
end

function Logic:GetAddonVersion()
    local version = GetAddOnMetadata(ADDON_NAME, 'Version')
    return tonumber(version) or 0
end

function Logic:COMM_GROUP_CREATE_SUCCESS(cmd, gid)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    ChatGroupCache:JoinChatGroup(gid)
    self:SendMessage('NECLOUD_GROUP_CREATE_SUCCESS', group:GetName(), gid)
end

function Logic:COMM_GROUP_CREATE_FAILED(cmd, name, reason)
    self:SendMessage('NECLOUD_GROUP_CREATE_FAILED', name, 0, reason)
end

function Logic:COMM_GROUP_LEAVE_SUCCESS(cmd, gid)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    ChatGroupCache:LeaveChatGroup(gid)
    self:SendMessage('NECLOUD_GROUP_LEAVE', group:GetName(), gid)
end

function Logic:COMM_GROUP_INVITE(cmd, gid, name, inviter, avatar)
    self:SendMessage('NECLOUD_GROUP_INVITE', name, gid, inviter, avatar)
end

function Logic:COMM_GROUP_INVITE_FAILED(cmd, gid, reason, target)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    self:SendMessage('NECLOUD_GROUP_INVITE_FAILED', group:GetName(), gid, reason, target)
end

function Logic:COMM_GROUP_JOIN_FAILED(cmd, name, reason)
    self:SendMessage('NECLOUD_GROUP_JOIN_FAILED', name, nil, reason)
end

function Logic:COMM_GROUP_JOIN_SUCCESS(cmd, name)
    self:SendMessage('NECLOUD_GROUP_JOIN_SUCCESS', name)
end

function Logic:OnServerRecv(cmd, ...)
    local event = comm_events[cmd]
    if event then
        self:SendMessage(event, ...)
    end
end

function Logic:NEBROAD_GROUP_JOIN_CANCEL(cmd, gid, target, stamp)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    self:SendMessage('NECLOUD_GROUP_JOIN_CANCEL', group:GetName(), gid, target)
end

function Logic:NEBROAD_GROUP_DISBAND(cmd, gid)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    ChatGroupCache:LeaveChatGroup(gid)
    self:SendMessage('NECLOUD_GROUP_DISBAND', group:GetName(), gid)
end

function Logic:NEBROAD_GROUP_LEAVE(cmd, gid, target, stamp)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end
    group:DeleteUser(target)
    group:SetUserListStamp(stamp)

    self:SendMessage('NECLOUD_GROUP_LEAVE', group:GetName(), gid, target)
end

function Logic:NEBROAD_GROUP_JOIN(cmd, gid, target, stamp)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end

    group:AddUser(target)
    group:SetUserListStamp(stamp)

    self:SendMessage('NECLOUD_GROUP_JOIN', group:GetName(), gid, target)
end

function Logic:NEBROAD_GROUP_KICK(cmd, gid, target, stamp, oper)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end

    if IsSelf(target) then
        ChatGroupCache:LeaveChatGroup(gid)
        self:SendMessage('NECLOUD_GROUP_KICK', group:GetName(), gid, nil, oper)
    else
        group:DeleteUser(target)
        group:SetUserListStamp(stamp)
        self:SendMessage('NECLOUD_GROUP_KICK', group:GetName(), gid, target, oper)
    end
end

function Logic:NEBROAD_GROUP_INFO(cmd, gid, stamp, type, isRecommend, ...)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end

    group:SetInfoStamp(stamp)
    group:SetGroupType(type)
    group:SetIsRecommend(isRecommend)
    group:FromSocket(...)

    self:SendMessage('NECLOUD_GROUP_INFO')
end

function Logic:NEBROAD_GROUP_SETMANAGER(cmd, gid, stamp, target, oper, flag)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end

    group:SetUserFlag(target, flag and 1 or 0)
    group:SetUserListStamp(stamp)

    self:SendMessage('NECLOUD_GROUP_MANAGER', group:GetName(), gid, target, oper, flag)
end

function Logic:NEBROAD_GROUP_USERJOIN(cmd, gid, count)
    local group = ChatGroupCache:GetChatGroup(gid)
    if not group then
        return
    end

    ChatGroupCache:AddJoinList(gid, count)
end

function Logic:COMM_ANNOUNCEMENT(event, title, content)
    local hasUnread = false
    local data

    for i, v in ipairs(self.db.annList) do
        if v.unread then
            hasUnread = true
        end
        if v.title == title and v.content == content then
            data = tremove(self.db.annList, i)
        end
    end
    if not data then
        hasUnread = true
    end

    tinsert(self.db.annList, 1, data or {
        title = title,
        content = content,
        unread = true,
    })

    self:SendMessage('NECLOUD_ANNOUNCEMENT_UPDATE', hasUnread)
end
