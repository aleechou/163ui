
local MAJOR, MINOR = 'NetEaseEnv-1.0', 1
local Env = LibStub:NewLibrary(MAJOR, MINOR)
if not Env then return end

Env._NSList = Env._NSList or {}
Env._NSInclude = Env._NSInclude or setmetatable({}, {__index = function(o, k)
    o[k] = {}
    return o[k]
end})

local _NSList = Env._NSList
local _NSInclude = Env._NSInclude

local function FindKey(current, name)
    for _, ns in pairs(_NSInclude[current]) do
        if ns[name] then
            return ns[name]
        end
    end
    return _G[name]
end

local _Meta = {
    __index = function(o, k)
        local v = FindKey(o, k)
        o[k] = v
        return v
    end
}

local function getNameSpace(name)
    return _NSList[name]
end

local function include(current, name, slient)
    local ns = getNameSpace(name)
    if ns then
        _NSInclude[current][name] = ns
    elseif not slient then
        error(([[Cannot find namespace '%s']]):format(name), 2)
    end
end

local function buildNameSpace(name)
    if not getNameSpace(name) then
        local _ENV = setmetatable({}, _Meta)

        _ENV._ENV = _ENV
        _NSList[name] = _ENV
    end
    return _NSList[name]
end

function BuildEnv(name, ...)
    local ns = buildNameSpace(name)
    for i = 1, select('#', ...) do
        local n = select(i, ...)
        if type(n) == 'string' then
            include(ns, n)
        end
    end
    setfenv(2, ns)
end
