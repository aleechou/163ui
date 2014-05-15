
--[[

by ldz5

--]]

local SocketClient = assert(LibStub('SocketClient-1.0', true), 'NetEaseSocketClient-1.0 requires SocketClient-1.0')

local MAJOR, MINOR = 'NetEaseSocketClient-1.0', 2
local Socket,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Socket then return end

Socket._Handlers = Socket._Handlers or {}

local function _GetHandler(object)
    return Socket._Handlers[object]
end

function Socket:ConnectServer(prefix, target, interval, noUserInfo)
    if type(prefix) ~= 'string' then
        error(([[bad argument #1 to 'ConnectServer' (string expected, got %s)]]):format(type(prefix)), 2)
    end
    if type(target) ~= 'string' then
        error(([[bad argument #2 to 'ConnectServer' (string expected, got %s)]]):format(type(target)), 2)
    end
    
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end

    if not handler:IsNormal() then
        error('Socket is connectting or connectted', 2)
    end
    handler:Connect(prefix, target, interval, noUserInfo)
end

function Socket:SendServer(cmd, ...)
    if type(cmd) ~= 'string' then
        error(([[bad argument #1 to 'SendServer' (string expected, got %s)]]):format(type(cmd)), 2)
    end
    
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    handler:Send(cmd, ...)
end

function Socket:GetServerTarget()
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    return handler.target
end

function Socket:IsServerConnected()
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    return handler:IsReady()
end

local mixins = {
    'RegisterServer',
    'UnregisterServer',
    'UnregisterAllServer',
    'ConnectServer',
    'SendServer',
    'GetServerTarget',
    'IsServerConnected',
}

function Socket:Embed(object)
    local handler = SocketClient:New()

    for i, v in ipairs(mixins) do
        object[v] = handler[v] or self[v]
    end

    self._Handlers[object] = handler
end
