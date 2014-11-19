
local Socket = LibStub('NetEaseSocket-2.0')
local AceEvent = LibStub('AceEvent-3.0')

local MAJOR, MINOR = 'NetEaseSocketRepeater-2.0', 1
local Repeater,oldminor = LibStub:NewLibrary(MAJOR, MINOR)
if not Repeater then return end

AceEvent:Embed(Repeater)
Socket:Embed(Repeater)

function Repeater:OnLoad()
    self:ListenSocket('NE_REPEATER')
    self:RegisterServer('REP', 'OnRepeater')
    self:RegisterServer('SERVER_DISCONNECTED', 'Connect')
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
    self:ConnectServer('S1' .. UnitFactionGroup('player'))
end

function Repeater:OnRepeater(_, prefix, sender, cmd, ...)
    for _, handler in pairs(Socket.handlers) do
        if handler.prefix == prefix then
            handler:FireSocket(cmd, sender, ...)
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
    return Socket.handlers[object]
end

function Repeater:SendSocket(target, cmd, ...)
    target = Ambiguate(target, 'none')

    local handler = _GetHandler(self)
    if not handler then
        error('no handler', 2)
    end

    if _IsSameRealm(target) then
        handler:SendSocket(target, cmd, ...)
    else
        Repeater:SendServer('REP', handler.prefix, target, cmd, ...)
    end
end

function Repeater:Embed(target)
    if not target.SendSocket then
        error([[Cannot embed NetEaseSocketRepeater-2.0]], 3)
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
