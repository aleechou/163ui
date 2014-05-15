
local GUI = assert(LibStub('NetEaseGUI-1.0'), 'NetEaseGUI-DropMenu-1.0 requests NetEaseGUI')

local WIDGET, VERSION = 'DropMenu', 1
local DropMenu = GUI:NewClass(WIDGET, GUI:GetClass('GridView'), VERSION, 'Owner')
if not DropMenu then
    return
end

local function check(value, data, owner)
    if type(value) == 'function' then
        return value(data, owner)
    end
    return value
end

local _MenuList = setmetatable({}, {__index = function(o, k)
    o[k] = DropMenu:New(UIParent)
    if k > 1 then
        o[k]:SetFrameLevel(o[k-1]:GetFrameLevel()+5)
    end
    return o[k]
end})

function DropMenu:Constructor()
    self:SetParent(UIParent)
    self:SetSize(100, 100)
    self:Hide()

    self:SetBackdrop{
        bgFile = [[Interface\ChatFrame\ChatFrameBackground]],
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        edgeSize = 16, tileSize = 16, tile = true,
        insets = {left = 4, right = 4, top = 4, bottom = 4},
    }
    self:SetBackdropColor(0, 0, 0, 0.8)
    self:SetBackdropBorderColor(1, 1, 1, 0.8)
    self:SetItemClass(GUI:GetClass('DropMenuItem'))
    self:SetItemHeight(16)
    self:SetPadding(10)
    self:SetAutoSize(true)
    self:SetRowCount(15)
    self:SetClampedToScreen(true)
    self:SetFrameStrata('DIALOG')
    self:EnableMouse(true)

    self:SetCallback('OnItemFormatted', self.OnItemFormatted)
    self:SetCallback('OnItemClick', self.OnItemClick)
    self:SetCallback('OnItemEnter', self.OnItemEnter)
    self:SetCallback('OnRefresh', self.OnRefresh)
    
    self:SetScript('OnHide', self.OnHide)
end

function DropMenu:OnRefresh()
    local level = self:GetLevel()
    if level == 1 then
        return
    end

    local prevMenu = _MenuList[level - 1]

    if self:GetWidth() > GetScreenWidth() - prevMenu:GetRight() then
        local anchor = select(2, self:GetPoint())
        self:ClearAllPoints()
        self:SetPoint('TOPRIGHT', anchor, 'TOPLEFT', 0, 3)
    end
end

function DropMenu:OnItemClick(button, data)
    if data.notClickable then
        return
    end
    self:Hide()
    
    local owner = self:GetOwner()
    if type(data.func) == 'function' then
        if data.confirm then
            if data.confirmInput then
                GUI:CallInputDialog(data.confirm, data.func, data.confirmKey, data.confirmDefault, data.confirmMaxBytes, owner, data)
            else
                GUI:CallMessageDialog(data.confirm, data.func, data.confirmKey, owner, data)
            end
        else
            data.func(owner, data, self)
        end
    end
    if owner then
        if type(owner.SetItem) == 'function' then
            owner:SetItem(data)
        end
    end
end

function DropMenu:OnItemFormatted(button, data)
    button:SetText(check(data.text, self:GetOwner()))
    button:SetCheckStatus(data.checkable, data.isNotRadio, check(data.checked, data, self:GetOwner()))
    button:SetHasArrow(data.hasArrow)
    button:SetWidth(button:GetAutoWidth())

    local isTitle = data.isTitle
    local disabled = check(data.disabled, data, self:GetOwner())

    if isTitle then
        button:Disable()
        button:SetDisabledFontObject('GameFontNormalSmallLeft')
    elseif disabled then
        button:Disable()
        button:SetDisabledFontObject('GameFontDisableSmallLeft')
    else
        button:Enable()
    end
end

function DropMenu:OnItemEnter(button, data)
    if not data.hasArrow then
        return self:CloseMenu(self:GetLevel() + 1)
    end

    self:OpenMenu(self:GetLevel() + 1,
        data.menuTable,
        self:GetOwner(), 'TOPLEFT', button, 'TOPRIGHT', 0, 3)
end

function DropMenu:OnHide()
    self:CloseMenu(self:GetLevel() + 1)
end

function DropMenu:SetLevel(level)
    self.level = level
end

function DropMenu:GetLevel()
    return self.level
end

function DropMenu:OpenMenu(level, menuTable, owner, ...)
    for i = #menuTable, 1, -1 do
        local v = menuTable[i]
        if check(v.hidden, v, owner) then
            tremove(menuTable, i)
        end
    end

    local Menu = _MenuList[level]
    Menu:SetLevel(level)
    Menu:SetItemList(menuTable)
    Menu:SetOwner(owner)
    Menu:ClearAllPoints()
    Menu:SetPoint(...)
    Menu:Show()
    Menu:Refresh()
end

function DropMenu:ToggleMenu(level, menuTable, owner, ...)
    local Menu = _MenuList[level]
    if Menu:IsShown() and Menu:GetOwner() == owner then
        Menu:Hide()
        return
    end
    Menu:Hide()
    self:OpenMenu(level, menuTable, owner, ...)
end

function DropMenu:CloseMenu(level)
    _MenuList[level]:Hide()
end

GUI:Embed(_MenuList[1], 'Menu')

local MenuFrame = _MenuList[1]:GetMenuFrame()

function MenuFrame:IsMenuOver()
    for i, menu in ipairs(_MenuList) do
        if menu:IsMouseOver() then
            return true
        end
    end
end
