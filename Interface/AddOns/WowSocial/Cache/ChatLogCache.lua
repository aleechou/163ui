
BuildEnv(...)

ChatLogCache = Cloud:NewModule('ChatLogCache', 'AceEvent-3.0', 'NetEaseTextFilter-1.0')

local CHAT_LOG_FORMAT = '%x\n%s\n%s\n%s\n%d'

function ChatLogCache:OnInitialize()
    self.db = self:InitDB('WOWSOCIAL_DB_CHATLOG')
    
    self.db.UNREAD = self.db.UNREAD or {}
    self.db.RECENT = self.db.RECENT or {}

    self.unreadList = self.db.UNREAD
    self.recentList = self.db.RECENT

    self:RegisterMessage('NECLOUD_GROUP_MSG')

    self:RegisterMessage('NECLOUD_GROUP_KICK', 'NECLOUD_GROUP_LEAVE')
    self:RegisterMessage('NECLOUD_GROUP_LEAVE')
    self:RegisterMessage('NECLOUD_GROUP_DISBAND')
end

function ChatLogCache:NECLOUD_GROUP_DISBAND(event, name, gid)
    self:DeleteChatGroup(gid)
end

function ChatLogCache:NECLOUD_GROUP_LEAVE(event, name, gid, target)
    if target  then
        return
    end
    self:DeleteChatGroup(gid)
end

function ChatLogCache:DeleteChatGroup(gid)
    self:DeleteRecent('GROUP', gid)
    self:DeleteUnread('GROUP', gid)
    self:ClearChatLog('GROUP', gid)
end

function ChatLogCache:InitDB(name)
    _G[name] = _G[name] or {}
    return _G[name]
end

function ChatLogCache:NECLOUD_GROUP_MSG(event, gid, msg, sender, guid, flag)
    sender = GetFullName(sender)
    msg = self:TextFilter(msg)

    self:AddChatLog('GROUP', gid, msg, sender, guid, flag)
    self:SendMessage('CHAT_MSG_GROUP', gid)

    self:AddRecent('GROUP', gid)

    if not IsSelf(sender) then
        self:AddUnread('GROUP', gid)
    end
end

function ChatLogCache:GetChatLog(chatType, target)
    self.db[chatType] = self.db[chatType] or {}
    self.db[chatType][target] = self.db[chatType][target] or {}
    return self.db[chatType][target]
end

function ChatLogCache:AddChatLog(chatType, target, msg, sender, guid, flag)
    local chatLog = self:GetChatLog(chatType, target)

    tinsert(chatLog, CHAT_LOG_FORMAT:format(
        time(),
        msg,
        sender,
        guid or '',
        flag or ''
    ))
end

function ChatLogCache:ClearChatLog(chatType, target)
    if self.db[chatType] then
        self.db[chatType][target] = nil
    end
end

function ChatLogCache:GetNumUnread(chatType, target)
    for i, v in ipairs(self.unreadList) do
        if v.chatType == chatType and v.target == target then
            return v.count, i
        end
    end
    return 0
end

function ChatLogCache:AddUnread(chatType, target)
    if self:IsChatInRead(chatType, target) then
        return
    end

    local count, index = self:GetNumUnread(chatType, target)
    if index then
        tremove(self.unreadList, index)
    end

    count = (count or 0) + 1
    tinsert(self.unreadList, 1, {
        chatType = chatType,
        target = target,
        count = count,
    })

    self:SendMessage('NECLOUD_UNREAD_CHANGED')
end

function ChatLogCache:DeleteUnread(chatType, target)
    local count, index = self:GetNumUnread(chatType, target)
    if index then
        tremove(self.unreadList, index)
        self:SendMessage('NECLOUD_UNREAD_CHANGED')
    end
end

function ChatLogCache:GetUnreadList()
    return self.unreadList
end

function ChatLogCache:AddRecent(chatType, target)
    for i, v in ipairs(self.recentList) do
        if v.chatType == chatType and v.target == target then
            tremove(self.recentList, i)
            break
        end
    end

    tinsert(self.recentList, 1, {
        chatType = chatType,
        target = target,
    })

    self:SendMessage('NECLOUD_RECENT_CHANGED')
end

function ChatLogCache:DeleteRecent(chatType, target)
    for i, v in ipairs(self.recentList) do
        if v.chatType == chatType and v.target == target then
            tremove(self.recentList, i)
            self:SendMessage('NECLOUD_RECENT_CHANGED')
            return
        end
    end
end

function ChatLogCache:ClearAllRecent()
    wipe(self.recentList)

    self:SendMessage('NECLOUD_RECENT_CHANGED')
end

function ChatLogCache:GetRecentList()
    return self.recentList
end

function ChatLogCache:SetChatInRead(chatType, target)
    self.inReadChatType, self.inReadTarget = chatType, target

    self:DeleteUnread(chatType, target)
end

function ChatLogCache:IsChatInRead(chatType, target)
    return self.inReadTarget == target and self.inReadChatType == chatType
end
