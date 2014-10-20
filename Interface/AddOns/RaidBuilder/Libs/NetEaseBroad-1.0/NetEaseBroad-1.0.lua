
--[[

by ldz5

--]]

local MAJOR, MINOR = 'NetEaseBroad-1.0', 4
local Broad,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Broad then return end

local BroadHandler = assert(LibStub('BroadHandler-1.0'), 'NetEaseBroad-1.0 requires BroadHandler-1.0')

Broad._Handlers = Broad._Handlers or {}

local function _GetHandler(object)
    return Broad._Handlers[object]
end

function Broad:ConnectBroad(chatType, channel, password, onlySend)
    if type(chatType) ~= 'string' then
        error(([[bad argument #1 to 'ConnectBroad' (string expected, got %s)]]):format(type(chatType)), 2)
    end
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    handler:Connect(chatType, channel, password, onlySend)
end

function Broad:SendBroadMessage(cmd, ...)
    if type(cmd) ~= 'string' then
        error(([[bad argument #1 to 'SendBroadMessage' (string expected, got %s)]]):format(type(cmd)), 2)
    end
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    handler:Send(cmd, ...)
end

function Broad:GetBroadChat()
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    return handler:GetChat()
end

function Broad:RegisterServerBroad(name, ...)
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    handler:SetServerBroad(name, true)

    return self:RegisterBroad(name, ...)
end

local mixins = {
    'RegisterBroad',
    'UnregisterBroad',
    'UnregisterAllBroad',
    'SendBroadMessage',
    'ConnectBroad',
    'GetBroadChat',
    'RegisterServerBroad',
}

function Broad:Embed(object)
    local handler = BroadHandler:New()

    for i, v in ipairs(mixins) do
        object[v] = self[v] or handler[v]
    end

    self._Handlers[object] = handler
end
