
local WIDGET, VERSION = 'GridView', 2

local GUI = LibStub('NetEaseGUI-1.0')
local GridView = GUI:NewClass(WIDGET, 'Frame', VERSION, 'Refresh', 'View', 'Scroll', 'Select', 'Owner')
if not GridView then
    return
end

function GridView:Constructor(parent)
    if not parent then
        return
    end
    self.buttons = {}
    self:SetParent(parent)
    self:SetSelectMode('NONE')

    self:SetScript('OnShow', self.Refresh)
end

function GridView:Update()
    self:UpdateScrollBar()
    self:UpdateItems()
end

function GridView:GetMaxCount()
    return self:GetRowCount() * self:GetColumnCount()
end

function GridView:UpdateLayout()
    for i in ipairs(self.buttons) do
        self:UpdateItemPosition(i)
    end
end

function GridView:UpdateItemPosition(i)
    local button = self:GetButton(i)
    local itemSpacing = self:GetItemSpacing()
    local itemHeight = self:GetItemHeight()
    local itemWidth = self:GetItemWidth()
    local lineCount = self:GetColumnCount()
    local left, right, top, bot = self:GetPadding()

    right = right + (self:IsScrollBarShown() and 18 or 0)

    button:ClearAllPoints()

    if lineCount == 1 then
        button:SetHeight(itemHeight)
        button:SetPoint('TOPLEFT', left, -top-(i-1)*(itemHeight+itemSpacing))
        button:SetPoint('TOPRIGHT', -right, -top-(i-1)*(itemHeight+itemSpacing))
    else
        local row = floor((i-1)/lineCount)
        local col = (i-1)%lineCount

        button:SetSize(itemWidth, itemHeight)
        button:SetPoint('TOPLEFT', left+col*(itemWidth+itemSpacing), -top-row*(itemHeight+itemSpacing))
    end
end

function GridView:UpdateItems()
    local offset = self:GetOffset()
    local maxCount = min(self:GetColumnCount() * self:GetRowCount(), self:GetItemCount())
    local autoWidth = 1
    local maxRight = 0

    for i = 1, maxCount do
        local button = self:GetButton(i)
        local index = offset + i - 1 + self:GetExcludeCount()

        button:SetEnabled(self:IsEnabled())
        button:SetID(index)
        button:SetChecked(self:IsSelected(index))
        button:Show()
        button:Refresh()
        
        autoWidth = max(autoWidth, button:GetAutoWidth() or 0)
        maxRight = max(maxRight, button:GetRight())
    end

    for i = maxCount + 1, #self.buttons do
        self:GetButton(i):Hide()
    end

    if maxCount > 0 and self:GetAutoSize() then
        local left, right, top, bot = self:GetPadding()
        local height = self:GetTop() - self:GetButton(maxCount):GetBottom() + bot
        local width = self:IsScrollBarShown() and 18 or 0

        if self:GetColumnCount() == 1 then
            width = width + autoWidth + left + right
        else
            width = width + maxRight - self:GetLeft() + right
        end
        self:SetSize(width, height)
    end
end

function GridView:SetColumnCount(columnCount)
    if not self.autoSize then
        -- error([[Must set autosize do it.]], 2)
    end
    self.columnCount = columnCount
    self:SetScrollStep(columnCount)
end

function GridView:GetColumnCount()
    return self.columnCount or 1
end

function GridView:SetRowCount(rowCount)
    self.rowCount = rowCount
end

function GridView:GetRowCount()
    if not self.rowCount then
        local itemHeight = self:GetItemHeight()
        local itemSpacing = self:GetItemSpacing()
        local top, bot = select(2, self:GetPadding())
        local height = self:GetHeight() - top - bot + itemSpacing

        self.rowCount = floor(height / (itemHeight + itemSpacing))
    end
    return self.rowCount
end

function GridView:SetAutoSize(autoSize)
    self.autoSize = autoSize
end

function GridView:GetAutoSize()
    return self.autoSize
end

function GridView:SetItemWidth(itemWidth)
    self.itemWidth = itemWidth
end

function GridView:GetItemWidth()
    if not self:GetAutoSize() then
        local left, right = self:GetPadding()
        local itemSpacing = self:GetItemSpacing()
        local columnCount = self:GetColumnCount()
        local width = self:GetWidth() - left - right - (columnCount-1) * itemSpacing - (self:IsScrollBarShown() and 18 or 0)
        self.itemWidth = width / columnCount

        return self.itemWidth
    end
    return self.itemWidth or 20
end
