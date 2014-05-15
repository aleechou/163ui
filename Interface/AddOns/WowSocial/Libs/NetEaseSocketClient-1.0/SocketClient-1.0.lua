
--[[

by ldz5

--]]

local AceComm = assert(LibStub('AceComm-3.0', true), 'NetEaseSocketClient-1.0 requires AceComm-3.0')
local AceTimer = assert(LibStub('AceTimer-3.0', true), 'NetEaseSocketClient-1.0 requires AceTimer-3.0')
local AceEvent = assert(LibStub('AceEvent-3.0', true), 'NetEaseSocketClient-1.0 requires AceEvent-3.0')
local AceSerializer = assert(LibStub('AceSerializer-3.0', true), 'NetEaseSocketClient-1.0 requires AceSerializer-3.0')
local CallbackHandler = assert(LibStub('CallbackHandler-1.0', true), 'NetEaseSocketClient-1.0 requires CallbackHandler-1.0')
local CTL = assert(ChatThrottleLib, "NetEaseSocketClient-1.0 requires ChatThrottleLib")

local MAJOR, MINOR = 'SocketClient-1.0', 6
local SocketClient,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not SocketClient then return end

---- Lua APIs

local setmetatable, random = setmetatable, fastrandom
local tinsert, tconcat = table.insert, table.concat

---- WoW APIs
local GetAutoCompleteRealms = GetAutoCompleteRealms

local SOCKET_NORMAL  = 1
local SOCKET_CONNECT = 2
local SOCKET_READY   = 3

AceComm:Embed(SocketClient)
AceTimer:Embed(SocketClient)
AceSerializer:Embed(SocketClient)

SocketClient._Objects = SocketClient._Objects or {}
SocketClient.status = SOCKET_NORMAL

local _Meta = {__index = SocketClient}

function SocketClient:New()
    local object = {}

    object.Fire = CallbackHandler:New(object,
        'RegisterServer',
        'UnregisterServer',
        'UnregisterAllServer').Fire

    object.realms = {}
    object.index = 1

    self._Objects[object] = true

    return setmetatable(object, _Meta)
end

function SocketClient:OnCommReceived(prefix, data, distribution, target)
    if prefix ~= self.prefix or distribution ~= 'WHISPER' then
        return
    end
    self:DealPacket(target, self:Deserialize(data))
end

function SocketClient:DealPacket(target, ok, cmd, ...)
    if not ok then
        return
    end
    if cmd == 'NETEASE_CONNECT_SUCCESS' then
        local key = ...
        if self.connectKey and key == self.connectKey then
            self:CancelAllTimers()
            self:SetTarget(target)
            self:Fire('SOCKET_CONNECTED')

            if not self.noUserInfo then
                
                local msg = self:Serialize('<NETEASE>',
                    'UserInfo:' .. (self.prefix or ''),
                    (UnitFactionGroup('player')),
                    (UnitGUID('player')),
                    (UnitLevel('player')),
                    (select(2, UnitClass('player'))),
                    (select(2, UnitRace('player'))),
                    (select(2, BNGetInfo())))

                CTL:SendChatMessage('NORMAL', cmd, msg, 'WHISPER', nil, target, cmd)
            end

            self.connectKey = nil
            return
        end
        return
    end
    if not self:IsReady() then
        return
    end
    if target ~= self:GetTarget() then
        return
    end
    self:Fire(cmd, ...)
end

function SocketClient:Connect(prefix, name, interval, noUserInfo)
    self.prefix = prefix
    self.name = name
    self.status = SOCKET_CONNECT

    self:UnregisterAllComm()
    self:RegisterComm(prefix, 'OnCommReceived')

    if not interval or interval < 5 then
        interval = 5
    end
    self.interval = interval
    self.noUserInfo = noUserInfo
    self:TryConnect()
end

function SocketClient:TryConnect()
    self:Send('NETEASE_CONNECT', self:GetConnectKey())

    self:ScheduleTimer('TryConnect', self.interval)
end

function SocketClient:Disconnect()
    self:UnregisterAllComm()
    self.name = nil
    self.prefix = nil
    self.status = nil

    self:Fire('SOCKET_DISCONNECTED')
end

function SocketClient:GetTarget()
    if self:IsConnecting() then
        GetAutoCompleteRealms(self.realms)
        if #self.realms == 0 then
            self.target = self.name
        else
            self.target = self.name .. '-' .. self.realms[self.index]
            self.index = self.index % #self.realms + 1
        end
    end
    return self.target
end

function SocketClient:SetTarget(name)
    self.status = SOCKET_READY
    self.target = name
    self.targetOffline = ERR_CHAT_PLAYER_NOT_FOUND_S:format(name)
end

function SocketClient:Send(cmd, ...)
    local target = self:GetTarget()
    if not self.prefix or not target then
        return
    end
    self:SendCommMessage(self.prefix, self:Serialize(cmd, ...), 'WHISPER', target)
end

function SocketClient:GetConnectKey()
    if not self.connectKey then
        self.connectKey = tostring(random(0x100000, 0xFFFFFF))
    end
    return self.connectKey
end

function SocketClient:IsReady()
    return self.status == SOCKET_READY
end

function SocketClient:IsNormal()
    return self.status == SOCKET_NORMAL
end

function SocketClient:IsConnecting()
    return self.status == SOCKET_CONNECT
end

if not SocketClient.chatFilter then
    ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', function(_, _, msg)
        for handler in pairs(SocketClient._Objects) do
            if handler:IsReady() then
                if handler.targetOffline == msg then
                    handler:Disconnect()
                    return true
                end
            end
            if handler.name then
                if msg:match(ERR_CHAT_PLAYER_NOT_FOUND_S:format(handler.name .. '%-?(.*)')) then
                    return true
                end 
            end
        end
    end)

    ChatFrame_AddMessageEventFilter('CHAT_MSG_WHISPER_INFORM', function(_, _, msg, sender)
        if msg:match('<NETEASE>') then
            return true
        end
        for handler in pairs(SocketClient._Objects) do
            if sender == handler.target then
                return true
            end
        end
    end)
    
    FloatingChatFrameManager:SetScript('OnEvent', nil)
    FloatingChatFrameManager:SetScript('OnEvent', function(self, event, ...)
        local filters = ChatFrame_GetMessageEventFilters(event)
        if filters then
            for _, filterFunc in pairs(filters) do
                if filterFunc(self, event, ...) then
                    return
                end
            end
        end
        FloatingChatFrameManager_OnEvent(self, event, ...)
    end)

    if select(6, GetAddOnInfo('WhisperPop')) ~= 'MISSING' then
        local function CompatWhisperPop(event, addon)
            if addon and addon ~= 'WhisperPop' then
                return
            end
            if IsAddOnLoaded('WhisperPop') then

                ---- for WhisperPop 3.1
                if WhisperPop and WhisperPop.IGNORED_MESSAGES then
                    tinsert(WhisperPop.IGNORED_MESSAGES, '<NETEASE>')
                end

                ---- for WhisperPop 2.1
                if WhisperPop_OnEvent and WhisperPopFrame then
                    WhisperPopFrame:SetScript('OnEvent', function(self, event, text, ...)
                        if type(text) == 'string' and text:find('<NETEASE>') then
                            return
                        end
                        return WhisperPop_OnEvent(self, event, text, ...)
                    end)
                end

                AceEvent.UnregisterEvent(SocketClient, 'ADDON_LOADED', CompatWhisperPop)
            else
                AceEvent.RegisterEvent(SocketClient, 'ADDON_LOADED', CompatWhisperPop)
            end
        end
        CompatWhisperPop()
    end
    SocketClient.chatFilter = true
end
