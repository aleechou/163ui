
local WIDGET, VERSION = 'Dropdown', 4

local GUI = LibStub('NetEaseGUI-1.0')
local Dropdown = GUI:NewClass(WIDGET, 'Button', VERSION)
if not Dropdown then
    return
end

local DropMenu = GUI:GetClass('DropMenu')

local function ButtonOnClick(self)
    PlaySound('igMainMenuOptionCheckBoxOn')
    self:GetParent():ToggleMenu()
end

function Dropdown:Constructor(parent)
    if not parent then
        return
    end

    self:SetParent(parent)

    local tLeft = self:CreateTexture(nil, 'BACKGROUND')
    tLeft:SetTexture([[Interface\Glues\CharacterCreate\CharacterCreate-LabelFrame]])
    tLeft:SetTexCoord(0, 0.1953125, 0, 1)
    tLeft:SetSize(25, 64)
    tLeft:SetPoint('LEFT', -16, 0)

    local tRight = self:CreateTexture(nil, 'BACKGROUND')
    tRight:SetTexture([[Interface\Glues\CharacterCreate\CharacterCreate-LabelFrame]])
    tRight:SetTexCoord(0.8046875, 1, 0, 1)
    tRight:SetSize(25, 64)
    tRight:SetPoint('RIGHT', 16, 0)

    local tMid = self:CreateTexture(nil, 'BACKGROUND')
    tMid:SetTexture([[Interface\Glues\CharacterCreate\CharacterCreate-LabelFrame]])
    tMid:SetTexCoord(0.1953125, 0.8046875, 0, 1)
    tMid:SetPoint('TOPLEFT', tLeft, 'TOPRIGHT')
    tMid:SetPoint('BOTTOMRIGHT', tRight, 'BOTTOMLEFT')

    local MenuButton = CreateFrame('Button', nil, self)
    MenuButton:SetSize(24, 24)
    MenuButton:SetPoint('RIGHT', 0, 1)
    MenuButton:SetNormalTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]])
    MenuButton:SetPushedTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]])
    MenuButton:SetDisabledTexture([[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Disabled]])
    MenuButton:SetHighlightTexture([[Interface\Buttons\UI-Common-MouseHilight]], 'ADD')
    MenuButton:SetScript('OnClick', ButtonOnClick)

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallLeft')
    Text:SetPoint('LEFT', 10, 0)
    Text:SetPoint('RIGHT', MenuButton, 'LEFT')

    self.Text = Text
    self.MenuButton = MenuButton

    self:SetScript('OnEnable', self.OnEnable)
    self:SetScript('OnDisable', self.OnDisable)
end

function Dropdown:OnEnable()
    self.MenuButton:Enable()
end

function Dropdown:OnDisable()
    self.MenuButton:Disable()
end

function Dropdown:SetText(text)
    self.Text:SetText(text)
end

function Dropdown:GetText()
    return self.Text:GetText()
end

local function _GetItem(menuTable, value)
    for i, v in ipairs(menuTable) do
        if v.value == value then
            return v
        end
        if v.menuTable then
            local item = _GetItem(v.menuTable, value)
            if item then
                return item
            end
        end
    end
end

function Dropdown:SetValue(value)
    if not value then
        self.value = nil
        self:SetText(self.defaultText)
    elseif self.menuTable then
        local item = _GetItem(self.menuTable, value)
        if item then
            self:SetItem(item)
        end
    end
end

function Dropdown:GetValue()
    return self.value
end

function Dropdown:SetMenuTable(menuTable)
    self.menuTable = menuTable
end

function Dropdown:GetMenuTable()
    return self.menuTable
end

function Dropdown:ToggleMenu()
    local menuTable = self:GetMenuTable()
    if menuTable and #menuTable > 0 then
        DropMenu:ToggleMenu(1, self:GetMenuTable(), self, 'TOPLEFT', self, 'BOTTOMLEFT')
    end
end

function Dropdown:SetItem(item)
    local noFire = self.value == item.value

    self.value = item.value
    self.item = item

    self:SetText(item.full or item.text)

    DropMenu:CloseMenu(1)

    if not noFire then
        self:Fire('OnSelectChanged', item)
    end
end

function Dropdown:GetItem()
    return self.item
end

function Dropdown:SetDefaultText(text)
    self.defaultText = text
    self:SetText(text)
end

function Dropdown:SetDefaultValue(value)
    -- body
end

function Dropdown:SetMaxItem(value)
    self.maxItem = value
end

function Dropdown:GetMaxItem()
    return self.maxItem
end
