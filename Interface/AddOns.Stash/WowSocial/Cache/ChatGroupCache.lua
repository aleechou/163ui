
BuildEnv(...)

ChatGroupCache = Cloud:NewModule('ChatGroupCache', 'AceEvent-3.0')

local AceSerializer = LibStub('AceSerializer-3.0')

function ChatGroupCache:OnInitialize()
    self.normalListForUI = {}
    self.recommendListForUI = {}
    self.joinListForUI = {}

    self.searchCache = {}
    self.search = {}

    self.cache = {}
    self.db = self:InitDB('WOWSOCIAL_DB_GROUP')

    self:RegisterMessage('NE_LOGIC_LOGIN_SUCCESS')
    self:RegisterMessage('NE_LOGIC_GROUP_LIST')
    self:RegisterMessage('NE_LOGIC_SEARCH')
    self:RegisterMessage('NE_LOGIC_USER_STATUS')

    self:RegisterMessage('NECLOUD_READY')
end

function ChatGroupCache:InitDB(name)
    local db = _G[name] or {}

    for k, v in pairs(db) do
        self.cache[k] = ChatGroup:New(v)
    end

    _G[name] = db
    return db
end

function ChatGroupCache:NECLOUD_READY()
    for i, gid in ipairs(self.normalList) do
        self:RequestChatGroupUserList(gid)
    end
    for i, gid in ipairs(self.recommendList) do
        local group = self:GetChatGroup(gid)
        if group and group:IsPublicFirstTouch() then
            JoinChatGroup(gid)
        end
    end
end

function ChatGroupCache:NE_LOGIC_USER_STATUS(event, target)
    for gid, group in self:IterateGroups() do
        if group:UserIsMember(target) then
            group:SortUserList()
        end
    end
    self:SendMessage('NECLOUD_USER_STATUS')
end

local NORMAL_SEARCH_DATA = {
    text = UNKNOWN,
    avatar = 0,
    interest = 0,
    onlineTime = 0,
    summary = '',
    userCount = 0,
    fansCount = 0,
}

local function unpackSearchData(data)
    local ok, name, avatar, interest, onlineTime, summary, userCount, fansCount = AceSerializer:Deserialize(data)
    if ok then
        return {
            text = name,
            avatar = avatar,
            interest = interest,
            onlineTime = onlineTime,
            summary = summary,
            userCount = userCount,
            fansCount = fansCount,
        }
    end
    return NORMAL_SEARCH_DATA
end 

function ChatGroupCache:NE_LOGIC_SEARCH(event, head, cache)
    if head == 'B' or head == 'O' then
        wipe(self.searchCache)
    end

    if head == 'E' or head == 'O' then
        self.search.noMore = true
    end

    for i, v in ipairs(cache) do
        tinsert(self.searchCache, unpackSearchData(v))
    end

    self:SendMessage('NECLOUD_SEARCH_UPDATE')
end

function ChatGroupCache:GetChatGroupSearchList()
    return self.searchCache
end

function ChatGroupCache:SetChatGroupSearch(interest, onlineTime)
    if self.search.interest == interest and self.search.onlineTime == onlineTime then
        return
    end

    wipe(self.search)

    self.search.interest = interest
    self.search.onlineTime = onlineTime
end

function ChatGroupCache:RequestChatGroupSearch()
    if self.search.noMore then
        return
    end
    Cloud:GetModule('Logic'):SendServer('COMM_GROUP_SEARCH', self.search.interest, self.search.onlineTime)
    return true
end

function ChatGroupCache:NE_LOGIC_LOGIN_SUCCESS()
    self:RegisterMessage('NE_LOGIC_GROUP_INFO')
    self:RegisterMessage('NE_LOGIC_GROUP_USER_LIST')
    self:RegisterMessage('NE_LOGIC_GROUP_JOIN_LIST')
    self:RegisterMessage('NE_LOGIC_GROUP_JOIN')

    Cloud:GetModule('Logic'):SendServer('COMM_GROUP_LIST_REQ')
end

function ChatGroupCache:ClearCache()
    for gid, group in pairs(self.cache) do
        if not (tContains(self.normalList, gid) or tContains(self.recommendList, gid)) then
            self:DeleteChatGroup(gid)
            ChatLogCache:DeleteChatGroup(gid)
        end
    end
end

function ChatGroupCache:SyncList(list)
    list = list or {}
    for i, gid in ipairs(list) do
        tinsert(self.initList, gid)

        self:RequestChatGroupInfo(gid)
    end
end

function ChatGroupCache:NE_LOGIC_GROUP_LIST(event, normalList, recommendList)
    self.normalList = normalList or {}
    self.recommendList = recommendList or {}
    self.initList = {}

    self:ClearCache()
    self:SyncList(normalList)
    self:SyncList(recommendList)

    if #self.initList == 0 then
        self.initList = nil
        self:RefreshList()
        self:SendMessage('NECLOUD_READY')
    end 
end

function ChatGroupCache:NE_LOGIC_GROUP_JOIN(event, gid)
    local group = self:GetChatGroup(gid)
    if not group then
        return
    end
    self:JoinChatGroup(gid)
end

function ChatGroupCache:NE_LOGIC_GROUP_INFO(event, gid, stamp, name, groupType, key, owner, ...)
    local group = self:GetChatGroup(gid) or self:CreateChatGroup(gid)

    if stamp then
        group:SetName(name)
        group:SetChatGroupId(gid)
        group:SetInfoStamp(stamp)
        group:SetKey(key)
        group:SetOwner(owner)
        group:SetGroupType(groupType)
        group:FromSocket(...)
    end
    
    if self.initList then
        tDeleteItem(self.initList, gid)

        if #self.initList == 0 then
            self.initList = nil
            self:RefreshList()

            for i, gid in ipairs(self.recommendList) do
                local group = self:GetChatGroup(gid)
                if group and group:GetJoined() then
                    self:JoinChatGroup(gid)
                end
            end

            self:SendMessage('NECLOUD_READY')
        end 
    else
        self:RefreshList()
        self:RequestChatGroupUserList(gid)
        self:SendMessage('NECLOUD_GROUP_INFO', gid)
    end
end

function ChatGroupCache:NE_LOGIC_GROUP_USER_LIST(event, gid, stamp, list)
    local group = self:GetChatGroup(gid)

    if stamp then
        group:SetUserListStamp(stamp)
        group:SetUserList(list)
    end

    self:SendMessage('NECLOUD_GROUP_USER_LIST', gid)
end

function ChatGroupCache:NE_LOGIC_GROUP_JOIN_LIST(event, gid, stamp, list)
    local group = self:GetChatGroup(gid)
    
    if stamp then
        group:SetJoinList(list)
        group:SetJoinListStamp(stamp)
    end

    self:SendMessage('NECLOUD_GROUP_JOIN_LIST', group:GetName(), gid)
end

local function sortFunc(a, b)
    return a.text < b.text
end

function ChatGroupCache:RefreshList()
    local list = wipe(self.normalListForUI)
    for i, gid in ipairs(self.normalList) do
        tinsert(list, {
            target = gid,
            chatType = 'GROUP',
            text = self:GetChatGroup(gid):GetName()
        })
    end
    sort(list, sortFunc)

    local list = wipe(self.recommendListForUI)
    for i, gid in ipairs(self.recommendList) do
        tinsert(list, {
            target = gid,
            chatType = 'GROUP',
            text = self:GetChatGroup(gid):GetName()
        })
    end
    sort(list, sortFunc)
end

function ChatGroupCache:RequestChatGroupInfo(gid)
    local group = self:GetChatGroup(gid)
    
    Cloud:GetModule('Logic'):SendServer('COMM_GROUP_INFO_REQ', gid, group and group:GetInfoStamp() or nil)
end

function ChatGroupCache:GetChatGroup(gid)
    return self.cache[gid]
end

function ChatGroupCache:IterateGroups()
    return pairs(self.cache)
end

function ChatGroupCache:CreateChatGroup(gid)
    local info = {}
    self.db[gid] = info
    self.cache[gid] = ChatGroup:New(info)
    return self.cache[gid]
end

function ChatGroupCache:DeleteChatGroup(gid)
    local group = self:GetChatGroup(gid)
    if not group then
        return
    end

    if not tContains(self.recommendList, gid) then
        self.db[gid] = nil
        self.cache[gid] = nil
    end

    self:DeleteJoinList(gid)
end

function ChatGroupCache:JoinChatGroup(gid)
    local group = self:GetChatGroup(gid)
    if not group then
        return
    end

    tinsert(self.normalList, gid)

    self:RefreshList()
end

function ChatGroupCache:LeaveChatGroup(gid)
    for i, v in ipairs(self.normalList) do
        if v == gid then
            tremove(self.normalList, i)
        end
    end

    self:DeleteChatGroup(gid)

    self:RefreshList()
end

function ChatGroupCache:GetChatGroupList()
    return self.normalListForUI
end

function ChatGroupCache:GetRecommendGroupList()
    return self.recommendListForUI
end

function ChatGroupCache:RequestChatGroupUserList(gid)
    local group = self:GetChatGroup(gid)
    if not group then
        return
    end
    Cloud:GetModule('Logic'):SendServer('COMM_GROUP_USER_LIST_REQ', gid, group:GetUserListStamp() or nil)
end

function ChatGroupCache:RequestChatGroupJoinList(gid, page)
    local group = self:GetChatGroup(gid)
    if not group then
        return
    end
    Cloud:GetModule('Logic'):SendServer('COMM_GROUP_JOIN_LIST_REQ', gid, group:GetJoinListStamp() or nil)
end

function ChatGroupCache:GetChatGroupJoinList(gid)
    local group = self:GetChatGroup(gid)
    if not group then
        return
    end
    return group:GetJoinList()
end

function ChatGroupCache:AddJoinList(gid, count)
    for i, v in ipairs(self.joinListForUI) do
        if v.target == gid then
            tremove(self.joinListForUI, i)
            break
        end
    end

    tinsert(self.joinListForUI, 1, {
        target = gid,
        count = count,
    })
    
    self:SendMessage('NECLOUD_JOINLIST_CHANGED')
end

function ChatGroupCache:DeleteJoinList(gid)
    for i, v in ipairs(self.joinListForUI) do
        if v.target == gid then
            tremove(self.joinListForUI, i)
            self:SendMessage('NECLOUD_JOINLIST_CHANGED')
            return
        end
    end
end

function ChatGroupCache:GetJoinList()
    return self.joinListForUI
end
