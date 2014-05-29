
BuildEnv(...)

---- UserInfo

function RequestUserInfo(name)
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'RequestUserInfo' (string expected, got %s)]]):format(type(name)), 2)
    end
    return UserCache:RequestUserInfo(name)
end

function GetUserInfo(name)
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'GetUserInfo' (string expected, got %s)]]):format(type(name)), 2)
    end
    return UserCache:GetUserInfo(name)
end

function SetPlayerInfo(t)
    if type(t) ~= 'table' then
        error(([[bad argument #1 to 'SetPlayerInfo' (table expected, got %s)]]):format(type(t)), 2)
    end
    return Logic:SendServer('COMM_USER_INFO',
        t.Avatar,
        t.Interest,
        t.OnlineTime,
        t.City,
        t.Summary)
end

function IsUserOnline(target)
    return UserCache:IsUserOnline(target)
end

---- GroupInfo

function IsChatGroupPublic(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'IsChatGroupPublic' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:IsPublic(gid)
end

function RequestChatGroupInfo(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'RequestChatGroupInfo' (number expected, got %s)]]):format(type(gid)), 2)
    end
    return ChatGroupCache:RequestChatGroupInfo(gid)
end

function RequestChatGroupUserList(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'RequestChatGroupInfo' (number expected, got %s)]]):format(type(gid)), 2)
    end
    return ChatGroupCache:RequestChatGroupUserList(gid)
end

function RequestChatGroupJoinList(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'RequestChatGroupJoinList' (number expected, got %s)]]):format(type(gid)), 2)
    end
    return ChatGroupCache:RequestChatGroupJoinList(gid)
end

function GetChatGroupInfo(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'GetChatGroupInfo' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group.proxy
end

function GetChatGroupName(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'GetChatGroupName' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:GetName() or ''
end

function GetChatGroupIcon(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'GetChatGroupIcon' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:GetAvatar()
end

function GetChatGroupJoinList(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'GetChatGroupJoinList' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:GetJoinList()
end

function GetChatGroupUserList(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'GetChatGroupUserList' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:GetUserList()
end

function GetChatGroupEventList(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'GetChatGroupEventList' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:GetEventList()
end

function SetChatGroupInfo(gid, t)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'SetChatGroupInfo' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(t) ~= 'table' then
        error(([[bad argument #2 to 'SetChatGroupInfo' (table expected, got %s)]]):format(type(t)), 2)
    end
    return Logic:SendServer('COMM_GROUP_INFO', gid,
        t.Avatar,
        t.Interest,
        t.OnlineTime,
        t.Summary,
        t.Announcement,
        t.ValiType)
end

function SetChatGroupManager(gid, target, flag)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'SetChatGroupManager' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(target) ~= 'string' then
        error(([[bad argument #2 to 'SetChatGroupManager' (string expected, got %s)]]):format(type(target)), 2)
    end
    if type(flag) ~= 'boolean' then
        error(([[bad argument #3 to 'SetChatGroupManager' (boolean expected, got %s)]]):format(type(flag)), 2)
    end
    return Logic:SendServer('COMM_GROUP_SETMANAGER', gid, target, flag)
end

function CreateChatGroup(name)
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'CreateChatGroup' (string expected, got %s)]]):format(type(name)), 2)
    end
    return Logic:SendServer('COMM_GROUP_CREATE', name)
end

function JoinChatGroup(gid)
    local group = ChatGroupCache:GetChatGroup(gid)
    if group and group:IsPublic() then
        group:SetJoined(true)

        ChatGroupCache:JoinChatGroup(gid)

        Logic:SendMessage('NECLOUD_GROUP_JOIN', group:GetName(), group:GetChatGroupId())
    else
        Logic:SendServer('COMM_GROUP_JOIN', gid)
    end
end

function LeaveChatGroup(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'LeaveChatGroup' (number expected, got %s)]]):format(type(gid)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    if group and group:IsPublic() then
        group:SetJoined(false)

        ChatGroupCache:LeaveChatGroup(gid)
        
        Logic:SendMessage('NECLOUD_GROUP_LEAVE', group:GetName(), group:GetChatGroupId())
    else
        Logic:SendServer('COMM_GROUP_LEAVE', gid)
    end
end

function DisbandChatGroup(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'DisbandChatGroup' (number expected, got %s)]]):format(type(gid)), 2)
    end
    return Logic:SendServer('COMM_GROUP_DISBAND', gid)
end

function KickChatGroup(gid, target)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'KickChatGroup' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(target) ~= 'string' then
        error(([[bad argument #1 to 'KickChatGroup' (string expected, got %s)]]):format(type(target)), 2)
    end
    return Logic:SendServer('COMM_GROUP_KICK', gid, target)
end

function InviteChatGroup(gid, target)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'InviteChatGroup' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(target) ~= 'string' then
        error(([[bad argument #1 to 'InviteChatGroup' (string expected, got %s)]]):format(type(target)), 2)
    end
    return Logic:SendServer('COMM_GROUP_INVITE', gid, target)
end

function InviteChatGroupAccept(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'InviteChatGroupAccept' (number expected, got %s)]]):format(type(gid)), 2)
    end
    return Logic:SendServer('COMM_GROUP_INVITE_ACCEPT', gid)
end

function InviteChatGroupCancel(gid)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'InviteChatGroupCancel' (number expected, got %s)]]):format(type(gid)), 2)
    end
    return Logic:SendServer('COMM_GROUP_INVITE_CANCEL', gid)
end

function JoinChatGroupAccept(gid, target)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'JoinChatGroupAccept' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(target) ~= 'string' then
        error(([[bad argument #1 to 'JoinChatGroupAccept' (string expected, got %s)]]):format(type(target)), 2)
    end
    return Logic:SendServer('COMM_GROUP_JOIN_ACCEPT', gid, target)
end

function JoinChatGroupCancel(gid, target)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'JoinChatGroupCancel' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(target) ~= 'string' then
        error(([[bad argument #1 to 'JoinChatGroupCancel' (string expected, got %s)]]):format(type(target)), 2)
    end
    return Logic:SendServer('COMM_GROUP_JOIN_CANCEL', gid, target)
end

function SendChatGroupMessage(gid, msg)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'SendChatGroupMessage' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(msg) ~= 'string' then
        error(([[bad argument #1 to 'SendChatGroupMessage' (string expected, got %s)]]):format(type(msg)), 2)
    end
    return Channel:SendGroupMessage(gid, msg)
end

function SendChatMessage(text, chatType, target)
    if chatType == 'GROUP' then
        SendChatGroupMessage(target, text)
    else
        _G.SendChatMessage(text, chatType, nil, target)
    end
end

---- GroupList

function GetChatGroupList()
    return ChatGroupCache:GetChatGroupList()
end

function GetRecommendGroupList()
    return ChatGroupCache:GetRecommendGroupList()
end

function SetChatGroupSearch(interest, onlineTime)
    return ChatGroupCache:SetChatGroupSearch(interest, onlineTime)
end

function RequestChatGroupSearch()
    return ChatGroupCache:RequestChatGroupSearch()
end

function GetChatGroupSearchList()
    return ChatGroupCache:GetChatGroupSearchList()
end

---- GroupUser

function UserIsChatGroupManager(gid, name)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'UserIsChatGroupManager' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'UserIsChatGroupManager' (string expected, got %s)]]):format(type(name)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:UserIsManager(name)
end

function UserIsChatGroupOwner(gid, name)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'UserIsChatGroupOwner' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'UserIsChatGroupOwner' (string expected, got %s)]]):format(type(name)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:UserIsOwner(name)
end

function UserIsChatGroupMember(gid, name)
    if type(gid) ~= 'number' then
        error(([[bad argument #1 to 'UserIsChatGroupMember' (number expected, got %s)]]):format(type(gid)), 2)
    end
    if type(name) ~= 'string' then
        error(([[bad argument #1 to 'UserIsChatGroupMember' (string expected, got %s)]]):format(type(name)), 2)
    end
    local group = ChatGroupCache:GetChatGroup(gid)
    return group and group:UserIsMember(name) or nil
end

---- ChatLog

function GetChatLog(chatType, target)
    return ChatLogCache:GetChatLog(chatType, target)
end

function GetChatUnread(chatType, target)
    return ChatLogCache:GetNumUnread(chatType, target)
end

function ClearChatUnread(chatType, target)
    return ChatLogCache:DeleteUnread(chatType, target)
end

function GetUnreadList()
    return ChatLogCache:GetUnreadList()
end

function GetRecentList()
    return ChatLogCache:GetRecentList()
end

function SetChatInRead(chatType, target)
    return ChatLogCache:SetChatInRead(chatType, target)
end

function SendFeedBack(addonName, feedType, msg)
    if type(addonName) ~= 'string' then
        error(([[bad argument #1 to 'SendFeedBack' (string expected, got %s)]]):format(type(addonName)), 2)
    end
    if type(feedType) ~= 'string' then
        error(([[bad argument #2 to 'SendFeedBack' (string expected, got %s)]]):format(type(feedType)), 2)
    end
    if type(msg) ~= 'string' then
        error(([[bad argument #3 to 'SendFeedBack' (string expected, got %s)]]):format(type(msg)), 2)
    end
    if msg == '' then
        error([[bad argument #3 to 'SendFeedBack' (got nil)]], 2)
    end
    return Logic:SendServer('COMM_FEEDBACK', addonName, feedType, msg)
end

function GetJoinList()
    return ChatGroupCache:GetJoinList()
end

function DeleteJoinList(gid)
    return ChatGroupCache:DeleteJoinList(gid)
end

function SendChatGroupYixinNotify()
    Calendar:SendEventNotify()
end

---- Ann

function GetAnnList()
    return Logic.db.annList
end

function GetAnnInfo(index)
    local list = GetAnnList()
    local info = list and list[index]
    if info then
        return info.title, info.content
    end
end

function SetAnnRead(index)
    local list = GetAnnList()
    if list and list[index] then
        list[index].unread = nil
    end

    local hasUnread = false
    for i, v in ipairs(list) do
        if v.unread then
            hasUnread = true
            break
        end
    end
    Logic:SendMessage('NECLOUD_ANNOUNCEMENT_UPDATE', hasUnread)
end

function GetOwnChatGroupList(fullName)
    local list = GetChatGroupList()
    local result = {}
    for i, v in ipairs(list) do
        if UserIsChatGroupOwner(v.target, fullName) then
            tinsert(result, v)
        end
    end

    return result
end

function GetJoinedChatGroupList()
    local result = {}
    for i, v in ipairs(GetChatGroupList()) do
        if UserIsChatGroupMember(v.target, PLAYER_NAME) then
            tinsert(result, v)
        end
    end
    return result
end
