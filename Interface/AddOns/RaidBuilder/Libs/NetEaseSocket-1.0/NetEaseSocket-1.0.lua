
--[[

by ldz5

--]]

local SocketServer = assert(LibStub('SocketServer-1.0', true), 'NetEaseSocket-1.0 requires SocketServer-1.0')

local MAJOR, MINOR = 'NetEaseSocket-1.0', 1
local Socket,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Socket then return end

Socket._Handlers = Socket._Handlers or {}

local function _GetHandler(object)
    return Socket._Handlers[object]
end

function Socket:ListenSocket(prefix, loggerHandler)
    if type(prefix) ~= 'string' then
        error(([[bad argument #1 to 'ListenSocket' (string expected, got %s)]]):format(type(prefix)), 2)
    end
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    handler:Listen(prefix, loggerHandler)
end

function Socket:SendSocket(target, cmd, ...)
    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end
    handler:Send(target, cmd, ...)
end

local mixins = {
    'RegisterSocket',
    'UnregisterSocket',
    'UnregisterAllSocket',
    'ListenSocket',
    'SendSocket',
}

function Socket:Embed(object)
    local handler = SocketServer:New()

    for i, v in ipairs(mixins) do
        object[v] = handler[v] or self[v]
    end

    self._Handlers[object] = handler
end
