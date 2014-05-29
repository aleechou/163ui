
--[[

by ldz5

--]]

local AceTimer = assert(LibStub('AceTimer-3.0'), 'BroadHandler-1.0 requires AceTimer-3.0')
local AceBucket = assert(LibStub('AceBucket-3.0'), 'BroadHandler-1.0 requires AceBucket-3.0')
local AceEvent = assert(LibStub('AceEvent-3.0', true), 'BroadHandler-1.0 requires AceEvent-3.0')
local AceSerializer = assert(LibStub('AceSerializer-3.0', true), 'BroadHandler-1.0 requires AceSerializer-3.0')
local CallbackHandler = assert(LibStub('CallbackHandler-1.0', true), 'BroadHandler-1.0 requires CallbackHandler-1.0')
local CTL = assert(ChatThrottleLib, 'BroadHandler-1.0 requires ChatThrottleLib')
local Base64 = assert(LibStub('NetEaseBase64-1.0', true), 'BroadHandler-1,0 requires NetEaseBase64-1.0')

local MAJOR, MINOR = 'BroadHandler-1.0', 7
local BroadHandler,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not BroadHandler then return end

AceEvent:Embed(BroadHandler)
AceTimer:Embed(BroadHandler)
AceBucket:Embed(BroadHandler)
AceSerializer:Embed(BroadHandler)

BroadHandler.usedChannels = BroadHandler.usedChannels or {}
BroadHandler.joinChannelQueue = BroadHandler.joinChannelQueue or {}

local _Meta = {__index = BroadHandler}

local PACKET_FIRST = '#'
local PACKET_NEXT  = '&'
local PACKET_LAST  = '$'
local PACKET_ONE   = '@'
local MAX_LEN = 254

local CHANNEL_EVENTS = {
    PARTY = 'CHAT_MSG_PARTY CHAT_MSG_PARTY_LEADER',
    RAID  = 'CHAT_MSG_RAID CHAT_MSG_RAID_LEADER',
    GUILD = 'CHAT_MSG_GUILD',
    CHANNEL = 'CHAT_MSG_CHANNEL',
    BNCONVERSATION = 'CHAT_MSG_BN_CONVERSATION',
    WHISPER = 'CHAT_MSG_WHISPER',
}

function BroadHandler:OnChannelReady()
    if self.channelReady then
        return
    end
    self:UnregisterBucket('CHANNEL_UI_UPDATE')
    self:UnregisterBucket('CHAT_MSG_CHANNEL')
    self:UnregisterBucket('CHAT_MSG_CHANNEL_NOTICE')
    self:CancelAllTimers()
    self.OnChannelReady = nil
    self.channelReady = true

    repeat
        local v = tremove(BroadHandler.joinChannelQueue, 1)
        if v then
            v.handler:JoinChannel(v.channel, v.password, v.fg)
        end
    until not v
end
BroadHandler:RegisterBucketEvent({'CHANNEL_UI_UPDATE', 'CHAT_MSG_CHANNEL_NOTICE', 'CHAT_MSG_CHANNEL'}, 5, 'OnChannelReady')
BroadHandler:ScheduleTimer('OnChannelReady', 30)

---- Lua APIs
local setmetatable, error, strsub = setmetatable, error, string.sub
local tinsert, tconcat, wipe = table.insert, table.concat, wipe

function BroadHandler:Encode(...)
    return Base64:EnCode(self:Serialize(...))
end

function BroadHandler:Decode(data)
    return self:Deserialize(Base64:DeCode(data))
end

function BroadHandler:New()
    local object = {}

    object.Fire = CallbackHandler:New(object,
        'RegisterBroad',
        'UnregisterBroad',
        'UnregisterAllBroad').Fire

    object.cache = {}

    return setmetatable(object, _Meta)
end

function BroadHandler:GetChannelId()
    if self.chatType == 'CHANNEL' and not self.channelId then
        local temp = {GetChannelList()}
        for i = 2, #temp do
            if temp[i+1] == self.channel then
                self.channelId = temp[i]
                break
            end
        end
    end
    return self.channelId
end

function BroadHandler:GetChat()
    return self.chatType, self.channelId
end

function BroadHandler:Connect(chatType, channel, password, onlySend)
    local eventList = CHANNEL_EVENTS[chatType]
    if not eventList then
        error(('Cannot connect chat type %s'):format(chatType), 3)
    end

    self.chatType = chatType
    self.channel = channel

    if not onlySend then
        self:UnregisterAllEvents()

        for event in eventList:gmatch('[^ ]+') do
            self:RegisterEvent(event, 'OnEventData')
        end
    end

    if chatType == 'CHANNEL' then
        self:RegisterEvent('CHAT_MSG_CHANNEL_NOTICE')
        self:RegisterEvent('PLAYER_LOGOUT')

        self:JoinChannel(channel, password)
    else
        if chatType == 'BNCONVERSATION' or chatType == 'WHISPER' then
            self.channelId = self.channel
        end
        self:Fire('BROAD_CONNECTED')
    end
end

function BroadHandler:JoinChannel(channel, password, fg)
    if self.channelReady then
        if not self:GetChannelId() then
            JoinTemporaryChannel(channel, password)
            if fg then
                ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, channel)
            end
        else
            self:Fire('BROAD_CONNECTED')
        end
    else
        tinsert(self.joinChannelQueue, {
            handler = self,
            channel = channel,
            password = password,
        })
    end
end

function BroadHandler:Disconnect()
    self:UnregisterAllEvents()
    self.chatType = nil
    self.channelId = nil
    self:ScheduleTimer('Fire', 1, 'BROAD_DISCONNECTED')
end

function BroadHandler:GetCache(event, channel, target)
    local key = event .. channel .. target
    self.cache[key] = self.cache[key] or {}
    return self.cache[key]
end

function BroadHandler:OnEventData(event, msg, target, _, _, _, _, _, _, channel)
    if self.chatType == 'CHANNEL' and self.channel ~= channel then
        return
    end
    local control, data = msg:match('^([#&$@])(.*)$')
    if not control then
        return
    end

    target = Ambiguate(target, 'none')

    local cache = self:GetCache(event, channel, target)

    if control == PACKET_FIRST then
        tinsert(wipe(cache), data)
    elseif control == PACKET_NEXT or control == PACKET_LAST then
        tinsert(cache, data)
    end

    if control == PACKET_LAST or control == PACKET_ONE then
        if control == PACKET_LAST then
            data = tconcat(cache)
            wipe(cache)
        end
        self:DealPacket(target, self:Decode(data))
    end
end

function BroadHandler:DealPacket(target, ok, cmd, ...)
    if ok then
        self:Fire(cmd, target, ...)
    end
end

function BroadHandler:CHAT_MSG_CHANNEL_NOTICE(event, action, _, _, _, _, _, _, id, channel)
    if channel ~= self.channel then
        return
    end
    if action == 'YOU_JOINED' then
        self.usedChannels[channel] = true
        self.channelId = id
        self:Fire('BROAD_CONNECTED')
    elseif action == 'YOU_LEFT' then
        self.usedChannels[channel] = nil
        self:Disconnect()
    elseif action == 'WRONG_PASSWORD' then
        self:Fire('BROAD_CONNECT_FAILED')
    end

    if ChannelFrame:IsShown() then
        ChannelList_Update()
    end
end

function BroadHandler:PLAYER_LOGOUT()
    if self.channel then
        LeaveChannelByName(self.channel)
    end
end

function BroadHandler:Send(cmd, ...)
    if not self.chatType then
        return
    end
    local chatType = self.chatType
    local id = self:GetChannelId()
    if chatType == 'CHANNEL' and not id then
        return
    end
    local data = self:Encode(cmd, ...)
    local dataLen = #data
    local queueName = cmd

    if dataLen < MAX_LEN then
        CTL:SendChatMessage('NORMAL', cmd, PACKET_ONE..data, chatType, nil, id, queueName)
    else
        local chunk = strsub(data, 1, MAX_LEN)
        
        CTL:SendChatMessage('NORMAL', cmd, PACKET_FIRST..chunk, chatType, nil, id, queueName)

        local pos = 1 + MAX_LEN
        while pos + MAX_LEN <= dataLen do
            chunk = strsub(data, pos, pos + MAX_LEN - 1)

            CTL:SendChatMessage('NORMAL', cmd, PACKET_NEXT..chunk, chatType, nil, id, queueName)
            pos = pos + MAX_LEN
        end

        chunk = strsub(data, pos)
        CTL:SendChatMessage('NORMAL', cmd, PACKET_LAST..chunk, chatType, nil, id, queueName)
    end
end

if not BroadHandler.hooked then
    local orig_GetChannelDisplayInfo = GetChannelDisplayInfo
    function GetChannelDisplayInfo(id)
        local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = orig_GetChannelDisplayInfo(id)
        if BroadHandler.usedChannels[name] then
            active = nil
        end
        return name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive
    end

    ChatConfigChannelSettings:HookScript('OnShow', function(self)
        local baseName = 'ChatConfigChannelSettingsLeftCheckBox'
        for i, v in ipairs(ChatConfigChannelSettingsLeft.checkBoxTable) do
            local checkBox = _G[baseName .. i .. 'Check']
            local text = _G[baseName .. i .. 'CheckText']

            if not BroadHandler.usedChannels[v.channelName] then
                checkBox:Enable()
                text:SetTextColor(1, 1, 1)
            else
                checkBox:Disable()
                text:SetTextColor(.5, .5, .5)
            end
        end
    end)

    BroadHandler.hooked = true
end
