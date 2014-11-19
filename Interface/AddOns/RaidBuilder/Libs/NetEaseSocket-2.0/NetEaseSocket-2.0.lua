
local SocketHandler = LibStub('SocketHandler-2.0')

local MAJOR, MINOR = 'NetEaseSocket-2.0', 1
local Socket,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Socket then return end

Socket.handlers = Socket.handlers or setmetatable({}, {
    __index = function(o, k)
        o[k] = SocketHandler:New()
        return o[k]
    end
})

local function handlerCall(obj, interface, ...)
    local handler = Socket.handlers[obj]
    if handler then
        handler[interface](handler, ...)
    end
end

local interfaces = {
    'ListenSocket',
    'SendSocket',
    'SendServer',
    'ConnectServer',
    'ConnectChannel',
}

for i, v in ipairs(interfaces) do
    Socket[v] = function(self, ...)
        handlerCall(self, v, ...)
    end
end

local mixins = {
    'RegisterSocket', 'UnregisterSocket', 'UnregisterAllSocket',
    'RegisterServer', 'UnregisterServer', 'UnregisterAllServer',
    'SendSocket', 'SendServer',
    'ListenSocket', 'ConnectServer', 'ConnectChannel',
}

function Socket:Embed(target)
    local handler = Socket.handlers[target]
    for i, v in ipairs(mixins) do
        target[v] = self[v] or handler[v]
    end
end
