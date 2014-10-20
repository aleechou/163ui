
local WIDGET, VERSION = 'MultiBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local MultiBox = GUI:NewClass(WIDGET, GUI:GetClass('GridView'), VERSION)
if not MultiBox then
    return
end

function MultiBox:Constructor(parent)
    if not parent then
        return
    end
    
    self.value = 0
    self:SetParent(parent)
    self:SetSelectMode('MULTI')
    self:SetItemClass(GUI:GetClass('MultiBoxCheckBox'))
    self:SetItemHeight(20)
    self:SetItemSpacing(0)
    self:SetColumnCount(3)
    self:SetRowCount(5)
    self:SetCallback('OnItemFormatted', self.OnItemFormatted)
    self:SetCallback('OnItemClick', self.OnItemClick)

    self:SetScript('OnSizeChanged', self.UpdateLayout)
end

function MultiBox:OnItemClick()
    self:Fire('OnValueChanged', self:GetValue())
end

function MultiBox:OnItemFormatted(button, data)
    button:SetText(data)
end

function MultiBox:SetValue(value)
    value = value or 0
    for i = 1, self:GetItemCount() do
        self.selected[i] = (bit.band(bit.lshift(1, i-1), value) > 0) or nil
    end
    self:Refresh()
    self:OnItemClick()
end

function MultiBox:GetValue()
    local value = 0
    for i = 1, self:GetItemCount() do
        value = bit.bor(value, bit.lshift(self:IsSelected(i) and 1 or 0, i-1))
    end
    return value
end
