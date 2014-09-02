
--[[

by ldz5

--]]

local AceSerializer = assert(LibStub('AceSerializer-3.0', true), 'NetEaseSocket-1.0 requires AceSerializer-3.0')
local CallbackHandler = assert(LibStub('CallbackHandler-1.0', true), 'NetEaseSocket-1.0 requires CallbackHandler-1.0')
local AceComm = assert(LibStub('AceComm-3.0', true), 'NetEaseSocket-1.0 requires AceComm-3.0')

local MAJOR, MINOR = 'SocketServer-1.0', 6
local SocketServer,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not SocketServer then return end

AceSerializer:Embed(SocketServer)
AceComm:Embed(SocketServer)

local _Meta = {__index = SocketServer}

local TARGET_DISTRIBUTION = {
    ['@GROUP'] = true,
    ['@GUILD'] = 'GUILD',
    ['@BATTLEGROUND'] = 'BATTLEGROUND',
}

local function _CheckSendDistribution(target)
    local distribution = TARGET_DISTRIBUTION[target]
    if distribution == true then
        if IsInRaid(LE_PARTY_CATEGORY_HOME) then
            return 'RAID'
        elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
            return 'PARTY'
        end
    elseif distribution then
        return distribution
    else
        return 'WHISPER', target
    end
end

function SocketServer:New()
    local object = {}

    object.Fire = CallbackHandler:New(object,
        'RegisterSocket',
        'UnregisterSocket',
        'UnregisterAllSocket').Fire

    return setmetatable(object, _Meta)
end

function SocketServer:OnCommReceived(prefix, data, distribution, target)
    if prefix ~= self.prefix then
        return
    end
    self:DealPacket(target, self:Deserialize(data))
end

function SocketServer:DealPacket(target, ok, cmd, ...)
    if not ok then
        return
    end
    
    if self.loggerHandler then
        self.loggerHandler(cmd, target, ...)
    end

    if cmd == 'NETEASE_CONNECT' then
        self:Send(target, 'NETEASE_CONNECT_SUCCESS', ...)
        self:Fire('SOCKET_USER_CONNECTED', target)
        return
    end

    self:Fire(cmd, target, ...)
end

function SocketServer:Send(target, cmd, ...)
    local distribution, target = _CheckSendDistribution(target)
    if distribution then
        self:SendCommMessage(self.prefix, self:Serialize(cmd, ...), distribution, target)
    end
end

function SocketServer:Listen(prefix, loggerHandler)
    self.prefix = prefix
    self.loggerHandler = loggerHandler
    self:UnregisterAllComm()
    self:RegisterComm(prefix, 'OnCommReceived')
end
