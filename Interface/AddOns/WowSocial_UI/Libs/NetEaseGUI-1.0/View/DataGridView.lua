
local WIDGET, VERSION = 'DataGridView', 4

local GUI = LibStub('NetEaseGUI-1.0')
local DataGridView = GUI:NewClass(WIDGET, GUI:GetClass('ListView'), VERSION)
if not DataGridView then
    return
end

function DataGridView:Constructor()
    self.sortButtons = {}
    self:SetCallback('OnItemCreated', self.OnItemCreated)
    self:SetCallback('OnItemFormatted', self.OnItemFormatted)
end

function DataGridView:OnItemCreated(button)
    local x = 0
    for i, v in ipairs(self.sortButtons) do
        local Grid
        if LibStub('LibClass-1.0'):IsClass(v.alignOrClass) then
            Grid = v.alignOrClass:New(button)
        else
            Grid = GUI:GetClass('DataGridViewGridItem'):New(button, v.alignOrClass)
        end

        Grid:SetPoint('TOPLEFT', x, 0)
        Grid:SetPoint('BOTTOMLEFT', x, 0)
        Grid.key = v.key

        if i == #self.sortButtons then
            Grid:SetPoint('TOPRIGHT')
        else
            Grid:SetWidth(v.width)
        end
        x = v.width + x - 1

        button[v.key] = Grid

        self:Fire('OnGridCreated', Grid, v.key)
    end
end

function DataGridView:OnItemFormatted(button, data)
    for i, v in ipairs(self.sortButtons) do
        local grid = button[v.key]
        if grid and data then
            if v.showHandler then
                local text, r, g, b, icon, left, right, top, bottom, width, height = v.showHandler(data)

                grid:SetText(text)
                grid:GetFontString():SetTextColor(r or 1, g or 1, b or 1)
                grid:SetIcon(icon, left, right, top, bottom, width, height)
            end
            if  v.formatHandler then
                v.formatHandler(grid, data)
            end
        end
    end
end

function DataGridView:SetHeaderPoint(...)
    if not self.sortButtons[1] then
        error('message', 2)
    end
    self.sortButtons[1]:SetPoint(...)
end

function DataGridView:AddHeader(key, text, width, alignOrClass, showHandler, sortHandler, formatHandler)
    if type(key) ~= 'string' then
        error(([[bad argument #1 to 'AddHeader' (string expected, got %s)]]):format(type(key)), 2)
    end
    if type(text) ~= 'string' then
        error(([[bad argument #2 to 'AddHeader' (string expected, got %s)]]):format(type(text)), 2)
    end
    if type(width) ~= 'number' then
        error(([[bad argument #3 to 'AddHeader' (number expected, got %s)]]):format(type(width)), 2)
    end
    if not (type(showHandler) == 'function' or type(showHandler) == 'nil') then
        error(([[bad argument #5 to 'AddHeader' (function/nil expected, got %s)]]):format(type(showHandler)), 2)
    end
    if not (type(formatHandler) == 'function' or type(formatHandler) == 'nil') then
        error(([[bad argument #6 to 'AddHeader' (function/nil expected, got %s)]]):format(type(formatHandler)), 2)
    end
    
    local Button = GUI:GetClass('SortButton'):New(self)
    Button:SetSize(width, 19)
    Button:SetText(text)
    Button.key = key
    Button.width = width
    Button.sortHandler = sortHandler
    Button.showHandler = showHandler
    Button.formatHandler = formatHandler
    Button.alignOrClass = alignOrClass

    if #self.sortButtons > 0 then
        Button:SetPoint('LEFT', self.sortButtons[#self.sortButtons], 'RIGHT', -1, 0)
    end
    tinsert(self.sortButtons, Button)
end

function DataGridView:InitHeader(data)
    for i, v in ipairs(data) do
        self:AddHeader(
            v.key,
            v.text,
            v.width,
            v.style or v.class,
            v.showHandler,
            v.sortHandler,
            v.formatHandler
        )
    end
end

function DataGridView:SetSortHandler(sortHandler)
    if sortHandler ~= self.sortHandler then
        self.sortDesc = false
    else
        self.sortDesc = not self.sortDesc
    end
    self.sortHandler = sortHandler
    self:Sort()
    self:Refresh()
end

function DataGridView:GetSortHandler()
    return self.sortHandler
end

function DataGridView:GetSortDesc()
    return self.sortDesc
end

local orig_Update = DataGridView.Update
function DataGridView:Update()
    for i, button in ipairs(self.sortButtons) do
        if button.sortHandler and button.sortHandler == self.sortHandler then
            button:SetArrowStyle(self.sortDesc and 'UP' or 'DOWN')
        else
            button:SetArrowStyle('NONE')
        end
    end
    orig_Update(self)
end

function DataGridView:Sort()
    if not self.sortHandler then
        return
    end
    local itemList = self:GetItemList()
    if type(itemList) == 'table' then
        if self.sortDesc then
            sort(itemList, function(a, b)
                return self.sortHandler(a) > self.sortHandler(b)
            end)
        else
            sort(itemList, function(a, b)
                return self.sortHandler(a) < self.sortHandler(b)
            end)
        end
    end
end

local orig_SetItemList = DataGridView.SetItemList
function DataGridView:SetItemList(itemList)
    orig_SetItemList(self, itemList)
    self:Sort()
    self:Refresh()
end
