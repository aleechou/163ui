
local GUI = assert(LibStub('NetEaseGUI-1.0'), 'NetEaseGUI-DropMenu-1.0 requests NetEaseGUI')

local lib = LibStub:NewLibrary('NetEaseGUI-DropMenu-1.0', 1)
if not lib then
    return
end

local DropMenu = GUI:GetClass('DropMenu')

local function _GetOpenPosition(owner, cursor)
    if cursor then
        local x, y = GetCursorPosition()
        local uiScale = owner:GetEffectiveScale()

        x = x / uiScale - owner:GetLeft() + 20
        y = y / uiScale - owner:GetTop() - 2

        return 'TOPLEFT', owner, 'TOPLEFT', x, y

    elseif owner:GetBottom() >= GetScreenHeight() - owner:GetTop() then
        return 'TOPLEFT', owner, 'BOTTOMLEFT'
    else
        return 'BOTTOMLEFT', owner, 'TOPLEFT'
    end
end

function lib:OpenMenu(owner, menuTable, cursor)
    DropMenu:OpenMenu(1, menuTable, owner, _GetOpenPosition(owner, cursor))
end

function lib:ToggleMenu(owner, menuTable, cursor)
    DropMenu:ToggleMenu(1, menuTable, owner, _GetOpenPosition(owner, cursor))
end

function lib:CloseMenu()
    DropMenu:CloseMenu(1)
end

local mixins = {
    'ToggleMenu',
    'OpenMenu',
    'CloseMenu',
}

function lib:Embed(target)
    for i, v in ipairs(mixins) do
        target[v] = self[v]
    end
end
