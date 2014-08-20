
local SocketClient = assert(LibStub('NetEaseSocketClient-1.0', true), 'NetEaseRepeater-1.0 requests NetEaseSocketClient-1.0')
local Socket = assert(LibStub('NetEaseSocket-1.0', true), 'NetEaseRepeater-1.0 requests NetEaseSocket-1.0')
local AceEvent = assert(LibStub('AceEvent-3.0', true), 'NetEaseRepeater-1.0 requests AceEvent-3.0')

local MAJOR, MINOR = 'NetEaseSocketRepeater-1.0', 4
local Repeater,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Repeater then return end

SocketClient:Embed(Repeater)
AceEvent:Embed(Repeater)

function Repeater:OnLoad()
    self:RegisterServer('REP', 'OnRepeater')
    self:RegisterServer('SOCKET_DISCONNECTED', 'Connect')
    self:Connect()

    self.realms = {}

    local realms = GetAutoCompleteRealms()
    if realms then
        for i, v in ipairs(realms) do
            self.realms[v] = true
        end
    else
        self.realms[GetRealmName():gsub('%s+', '')] = true
    end
end

function Repeater:Connect()
    self:ConnectServer('NE_REPEATER', 'S1' .. UnitFactionGroup('player'), nil, true)
end

function Repeater:OnRepeater(_, prefix, sender, cmd, ...)
    for _, handler in pairs(Socket._Handlers) do
        if handler.prefix == prefix then
            handler:Fire(cmd, sender, ...)
        end
    end
end

local function _IsSameRealm(target)
    local realm = target:match('%-([^%-]+)$')
    if not realm then
        return true
    end
    return Repeater.realms[realm]
end

local function _GetHandler(object)
    return Socket._Handlers[object]
end

function Repeater:SendSocket(target, cmd, ...)
    target = Ambiguate(target, 'none')

    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end

    if _IsSameRealm(target) then
        handler:Send(target, cmd, ...)
    else
        Repeater:SendServer('REP', handler.prefix, target, cmd, ...)
    end
end

function Repeater:Embed(target)
    if not target.SendSocket then
        error([[Cannot embed NetEaseRepeater-1.0]], 3)
    end

    target.SendSocket = Repeater.SendSocket
end

if IsLoggedIn() then
    Repeater:OnLoad()
else
    Repeater:RegisterEvent('PLAYER_LOGIN', function()
        Repeater:OnLoad()
        Repeater:UnregisterEvent('PLAYER_LOGIN')
    end)
end
