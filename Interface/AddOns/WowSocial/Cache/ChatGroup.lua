
BuildEnv(...)

ChatGroup = Cloud:NewClass('ChatGroup')

function ChatGroup:Constructor(proxy)
    self.proxy = proxy or proxy
    
    self.proxy.UserList = self.proxy.UserList or {}
    self.proxy.JoinList = self.proxy.JoinList or {}

    self.eventList = {}
    self.memberList = {}

    self:SortUserList()
end

function ChatGroup:AddUser(name, flag)
    self.proxy.UserList[name] = flag or 0

    self:SortUserList()
end

function ChatGroup:DeleteUser(name)
    self.proxy.UserList[name] = nil

    self:SortUserList()
end

function ChatGroup:SetUserFlag(name, flag)
    self:AddUser(name, flag)
end

local function sortFunc(a, b)
    return a.sortKey < b.sortKey
end

function ChatGroup:SortUserList()
    local list = wipe(self.memberList)
    for k, v in pairs(self.proxy.UserList) do
        tinsert(list, {
            text = k,
            office = v,
            sortKey = ('%d%d%s'):format(IsUserOnline(k) and 0 or 1, 3 - v, k)
        })
    end
    sort(list, sortFunc)
end

function ChatGroup:SetUserList(list)
    self.proxy.UserList = list
    
    self:SortUserList()
end

function ChatGroup:GetUserList()
    return self.memberList
end

function ChatGroup:GetJoinList()
    return self.proxy.JoinList
end

function ChatGroup:GetEventList()
    return self.eventList
end

function ChatGroup:SetJoinList(list)
    wipe(self.proxy.JoinList)

    for i, v in ipairs(list) do
        tinsert(self.proxy.JoinList, v)
    end
end

local attr = {
    'ChatGroupId',
    'Name',
    'Key',
    'InfoStamp',
    'Owner',
    'Avatar',
    'Interest',
    'OnlineTime',
    'Announcement',
    'Summary',
    'UserListStamp',
    'JoinListStamp',
    'GroupType',
    'IsRecommend',
    'Joined',
    'ValiType',
    'YiXin',
    'Fans',
}

for i, v in ipairs(attr) do
    ChatGroup['Set' .. v] = function(self, value)
        self.proxy[v] = value
    end

    ChatGroup['Get' .. v] = function(self)
        return self.proxy[v]
    end
end

function ChatGroup:ToSocket()
    return  self:GetAvatar(),
            self:GetInterest(),
            self:GetOnlineTime(),
            self:GetSummary(),
            self:GetAnnouncement()
end

function ChatGroup:FromSocket(avatar, interest, onlinetime, summary, announcement, valiType, yixin, fans)
    self:SetAvatar(avatar)
    self:SetInterest(interest)
    self:SetOnlineTime(onlinetime)
    self:SetSummary(summary)
    self:SetAnnouncement(announcement)
    self:SetValiType(valiType)
    self:SetYiXin(yixin)
    self:SetFans(fans)
end

function ChatGroup:UserIsOwner(name)
    return self:GetOwner() == name
end

function ChatGroup:UserIsMember(name)
    if name == PLAYER_NAME then
        if self:IsPublic() then
            return self:GetJoined()
        end
    end
    return not not self.proxy.UserList[name]
end

function ChatGroup:UserIsManager(name)
    return self.proxy.UserList[name] and self.proxy.UserList[name] > 0
end

function ChatGroup:IsPublic()
    return self:GetGroupType() == GROUPTYPE_NETEASE or self:GetGroupType() == GROUPTYPE_AUTOJOIN
end

function ChatGroup:IsPublicFirstTouch()
    return self:GetGroupType() == GROUPTYPE_AUTOJOIN and self:UserIsMember(PLAYER_NAME) == nil
end
