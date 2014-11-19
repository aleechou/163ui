
local CallbackHandler = LibStub('CallbackHandler-1.0')
local SocketMiddleware = LibStub('NetEaseSocketMiddleware-2.0')
local AceTimer = LibStub('AceTimer-3.0')
local AceEvent = LibStub('AceEvent-3.0')

local MAJOR, MINOR = 'SocketHandler-2.0', 8
local SocketHandler,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not SocketHandler then return end

local SOCKET_NORMAL  = 1
local SOCKET_CONNECT = 2
local SOCKET_READY   = 3

local CONNECT_DELAY = 10

local NOT_FOUND_MATCH = ERR_CHAT_PLAYER_NOT_FOUND_S:format('(.+)')

local SOCKET_BASE_CMD = {
    NETEASE_CONNECT_SUCCESS = true,
    NETEASE_CHANNEL_OWNER = true,
}

SocketHandler.EventHandler = SocketHandler.EventHandler or {}

SocketHandler.objects = SocketHandler.objects or {}
SocketHandler.channels = SocketHandler.channels or {}
SocketHandler.connectQueue = SocketHandler.connectQueue or {}

SocketHandler.status = SOCKET_NORMAL
SocketHandler.isLoggedIn = false
SocketHandler._meta = {__index = SocketHandler}

local objects = SocketHandler.objects
local channels = SocketHandler.channels
local connectQueue = SocketHandler.connectQueue
local EventHandler = SocketHandler.EventHandler

local function OnUsed(registry, target, cmd)
    target:RegisterCallback(cmd, 'OnSocket')
end

local function formatTarget(target)
    if target then
        return Ambiguate(target .. '-' .. (GetAutoCompleteRealms() or {GetRealmName():gsub('%s+', '')})[1], 'none')
    end
end

local function getChannelId(channelName)
    local id = GetChannelName(channelName)
    if id and id > 0 then
        return id
    end
end

function SocketHandler:New()
    local obj = setmetatable({}, self._meta)

    local socketRegistry = CallbackHandler:New(obj, 'RegisterSocket', 'UnregisterSocket', 'UnregisterAllSocket')
    local serverRegistry = CallbackHandler:New(obj, 'RegisterServer', 'UnregisterServer', 'UnregisterAllServer')

    local function OnUnused(registry, target, cmd)
        if SOCKET_BASE_CMD[cmd] then
            return
        end
        if next(socketRegistry.events[cmd]) or next(socketRegistry.events[cmd]) then
            return
        end
        target:UnregisterCallback(cmd)
    end

    socketRegistry.OnUsed = OnUsed
    socketRegistry.OnUnused = OnUnused
    serverRegistry.OnUsed = OnUsed
    serverRegistry.OnUnused = OnUnused

    obj.FireSocket = socketRegistry.Fire
    obj.FireServer = serverRegistry.Fire

    SocketMiddleware:Embed(obj)
    AceTimer:Embed(obj)

    tinsert(objects, obj)

    return obj
end

function SocketHandler:PreServer(cmd, distribution, sender, ...)
    if cmd == 'NETEASE_CONNECT_SUCCESS' then
        local key, channelName = ...
        if self.connectKey and self.connectKey == key then
            self:CancelTimer(self.retryConnectTimer)
            self.target = sender
            self.status = SOCKET_READY
            self.connectKey = nil
            self.retryConnectTimer = nil

            self:SetChannel(channelName)

            self:FireServer('SERVER_CONNECTED')
        end
        return true
    end
    if cmd == 'NETEASE_CHANNEL_OWNER' then
        if self:IsServer(sender) or not self:IsReady() then
            SetChannelOwner(..., sender)
        end
        return true
    end
end

function SocketHandler:OnSocket(cmd, distribution, sender, ...)
    if self:PreServer(cmd, distribution, sender, ...) then
        return
    elseif self:IsServer(sender) and self:IsReady() then
        self:FireServer(cmd, ...)
    elseif not SOCKET_BASE_CMD[cmd] then
        self:FireSocket(cmd, sender, ...)
    end
end

function SocketHandler:ListenSocket(prefix, target)
    self.prefix = prefix
    self.connectTarget = formatTarget(target)
    self:Listen(prefix, 4)
end

function SocketHandler:CheckSendDistribution(target)
    if target == '@GROUP' then
        if IsInRaid(LE_PARTY_CATEGORY_HOME) then
            return 'RAID'
        elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
            return 'PARTY'
        end
    elseif target == '@CHANNEL' then
        if self.channelId then
            return 'CHANNEL', self.channelId
        end
    elseif target == '@GUILD' then
        return 'GUILD'
    elseif target == '@BATTLEGROUND' then
        return 'BATTLEGROUND'
    else
        return 'WHISPER', target
    end
end

function SocketHandler:SendSocket(target, cmd, ...)
    local distribution, target = self:CheckSendDistribution(target)
    if distribution then
        self:Send(distribution, target, cmd, ...)
    end
end

function SocketHandler:ConnectServer(target)
    self.connectTarget = formatTarget(target) or self.connectTarget
    self.status = SOCKET_CONNECT

    if not self.connectTarget then
        error('Can`t found connectTarget in object', 2)
    end

    self:RegisterCallback('NETEASE_CONNECT_SUCCESS', 'OnSocket')
    self:RegisterCallback('NETEASE_CHANNEL_OWNER', 'OnSocket')

    self:TryConnect()
end

function SocketHandler:DisconnectServer()
    self.target = nil
    self:ScheduleTimer('FireServer', 1, 'SERVER_DISCONNECTED')
end

function SocketHandler:ConnectChannel()
    if self.channelName then
        local id = getChannelId(self.channelName)
        if id then
            self.channelId = id
            self:FireServer('CHANNEL_CONNECTED')
        else
            self.channelId = nil
            JoinTemporaryChannel(self.channelName)
        end
    end
end

function SocketHandler:SendServer(cmd, ...)
    if self.target then
        self:Send('WHISPER', self.target, cmd, ...)
    end
end

function SocketHandler:TryConnect()
    if self.isLoggedIn then
        self:Send('WHISPER', self.connectTarget, 'NETEASE_CONNECT', self:GetConnectKey())
        self.retryConnectTimer = self:ScheduleTimer('TryConnect', 5)
    else
        tinsert(self.connectQueue, self)
    end
end

function SocketHandler:GetConnectKey()
    if not self.connectKey then
        self.connectKey = tostring(random(0x100000, 0xFFFFFF))
    end
    return self.connectKey
end

function SocketHandler:SetChannel(channelName)
    if self.channelName and self.channelName ~= channelName then
        if channels[self.channelName] then
            channels[self.channelName][self] = nil

            if next(channels[self.channelName]) then
                LeaveChannelByName(self.channelName)
            end
        end
    end

    self.channelName = channelName

    if self.channelName then
        channels[self.channelName] = channels[self.channelName] or {}
        channels[self.channelName][self] = true

        self:ConnectChannel()
    end
end

function SocketHandler:IsReady()
    return self.status == SOCKET_READY
end

function SocketHandler:IsServer(sender)
    return self.target == sender or self.connectTarget == sender
end

function SocketHandler:YOU_JOINED()
    self.channelId = getChannelId(self.channelName)
    self:ScheduleTimer('FireServer', 1, 'CHANNEL_CONNECTED')
end

function SocketHandler:YOU_LEFT()
    self.channelId = nil
    self:ScheduleTimer('FireServer', 1, 'CHANNEL_DISCONNECTED')
end

function SocketHandler:WRONG_PASSWORD()
    self.channelId = nil
    self:ScheduleTimer('FireServer', 1, 'CHANNEL_CONNECT_FAILED')
end

SocketHandler.YOU_CHANGED = SocketHandler.YOU_JOINED
SocketHandler.BANNED = SocketHandler.WRONG_PASSWORD

---- EventHandler

AceEvent:Embed(EventHandler)
AceTimer:Embed(EventHandler)

function EventHandler:CHAT_MSG_CHANNEL_NOTICE(_, event, _, _, _, _, _, _, id, channelName)
    local callback = SocketHandler[event]
    if callback and channels[channelName] then
        for handler in pairs(channels[channelName]) do
            callback(handler)
        end
    end

    if ChannelFrame:IsShown() then
        ChannelList_Update()
    end
end

function EventHandler:PLAYER_LOGOUT()
    for channelName in pairs(channels) do
        LeaveChannelByName(channelName)
    end
end

function EventHandler:PLAYER_LOGIN()
    SocketHandler.isLoggedIn = true

    for _, handler in ipairs(connectQueue) do
        handler:TryConnect()
    end
end

function EventHandler:CHAT_MSG_SYSTEM(_, msg)
    local name = msg:match(NOT_FOUND_MATCH)
    if not name then
        return
    end

    name = Ambiguate(name, 'none')

    for _, handler in pairs(objects) do
        if handler.target == name then
            if handler:IsReady() then
                handler:DisconnectServer()
            end
        end
    end
end

EventHandler:CancelAllTimers()
EventHandler:UnregisterAllEvents()
EventHandler:RegisterEvent('PLAYER_LOGOUT')
EventHandler:RegisterEvent('CHAT_MSG_SYSTEM')
EventHandler:RegisterEvent('CHAT_MSG_CHANNEL_NOTICE')

if IsLoggedIn() then
    EventHandler:ScheduleTimer('PLAYER_LOGIN', CONNECT_DELAY)
else
    EventHandler:RegisterEvent('PLAYER_LOGIN', function()
        EventHandler:UnregisterEvent('PLAYER_LOGIN')
        EventHandler:ScheduleTimer('PLAYER_LOGIN', CONNECT_DELAY)
    end)
end

---- ChatFilter

if not SocketHandler.chatFilter then
    ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', function(_, _, msg)
        local name = msg:match(NOT_FOUND_MATCH)
        if not name then
            return
        end

        name = Ambiguate(name, 'none')

        for _, handler in pairs(objects) do
            if handler:IsServer(name) then
                return true
            end
        end
    end)
    SocketHandler.chatFilter = true
end

---- hook
if not SocketHandler.hooked then
    SocketHandler.hooked = true

    local orig_GetChannelDisplayInfo = GetChannelDisplayInfo
    function GetChannelDisplayInfo(id)
        local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = orig_GetChannelDisplayInfo(id)
        if channels[name] then
            active = nil
        end
        return name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive
    end
end
