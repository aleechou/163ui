
BuildEnv(...)

Whisper = Cloud:NewModule('Whisper', 'AceEvent-3.0')

function Whisper:OnInitialize()
    self.friendList = {}

    self:RegisterEvent('FRIENDLIST_UPDATE')
    self:RegisterEvent('CHAT_MSG_WHISPER')
    self:RegisterEvent('CHAT_MSG_WHISPER_INFORM')

    self:FRIENDLIST_UPDATE()
end

local GetClassTag
do
    local CLASS_CACHE = {}
    for i = 1, GetNumClasses() do
        local name, tag, id = GetClassInfo(i)
        CLASS_CACHE[name] = tag
    end

    function GetClassTag(name)
        return CLASS_CACHE[name]
    end
end

function Whisper:FRIENDLIST_UPDATE()
    wipe(self.friendList)
    
    for i = 1, GetNumFriends() do
        local name, level, class, _, isOnline, note = GetFriendInfo(i)
        name = GetFullName(name)

        UserCache:SetUserOnline(name, isOnline)
        
        tinsert(self.friendList, {
            text = name,
            target = name,
            chatType = 'WHISPER',
        })

        if isOnline then
            local info = UserCache:GetUserInfo(name) or UserCache:CreateUserInfo(name)

            info.Class = GetClassTag(class)
            info.level = level
        end
    end
end

function Whisper:CHAT_MSG_WHISPER(event, ...)
    local filter, msg, sender, _, _, _, flag, _, _, _, _, _, guid = self:SystemFilter(event, ...)
    if filter then
        return
    end
    if flag == 'GM' then
        return
    end

    sender = GetFullName(sender)

    UserCache:CacheUserBaseInfo(guid, true)
    ChatLogCache:AddChatLog('WHISPER', sender, msg, sender, guid, flag)
    self:SendMessage('CHAT_MSG_GROUP')

    ChatLogCache:AddRecent('WHISPER', sender)
    ChatLogCache:AddUnread('WHISPER', sender)
end

function Whisper:CHAT_MSG_WHISPER_INFORM(event, ...)
    local filter, msg, sender, _, _, _, flag, _, _, _, _, _, guid = self:SystemFilter(event, ...)
    if filter then
        return
    end
    if flag == 'GM' then
        return
    end

    sender = GetFullName(sender)

    UserCache:CacheUserBaseInfo(guid, true)
    ChatLogCache:AddChatLog('WHISPER', sender, msg, PLAYER_NAME, guid, flag)
    ChatLogCache:SendMessage('CHAT_MSG_GROUP')

    ChatLogCache:AddRecent('WHISPER', sender)
    ChatLogCache:AddUnread('WHISPER', sender)
end

function Whisper:SystemFilter(event, ...)
    local filters = ChatFrame_GetMessageEventFilters(event)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14 = ...
    if filters then
        local newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12, newarg13, newarg14
        local filter
        for _, filterFunc in pairs(filters) do
            filter, newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12, newarg13, newarg14 = filterFunc(self, event, ...)
            if filter then
                return true
            elseif newarg1 then
                arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14 = newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12, newarg13, newarg14
            end
        end
    end
    return nil, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14
end

function Whisper:GetFriendList()
    return self.friendList
end

function GetFriendList()
    return Whisper:GetFriendList()
end
