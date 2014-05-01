
local WIDGET, VERSION = 'MultiBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local MultiBox = GUI:NewClass(WIDGET, GUI:GetClass('GridView'), VERSION)
if not MultiBox then
    return
end

local CheckBox = LibStub('LibClass-1.0'):NewClass('CheckBox', GUI:GetClass('ItemButton'))

function CheckBox:Constructor()
    self:SetNormalTexture([[Interface\Buttons\UI-CheckBox-Up]])
    self:SetCheckedTexture([[Interface\Buttons\UI-CheckBox-Check]])
    self:SetPushedTexture([[Interface\Buttons\UI-CheckBox-Down]])
    self:SetDisabledCheckedTexture([[INTERFACE\BUTTONS\UI-CheckBox-Check-Disabled]])
    self:SetHighlightTexture([[Interface\Buttons\UI-CheckBox-Highlight]], 'ADD')

    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetSize(20, 20)
    self:GetNormalTexture():SetPoint('LEFT')

    self:GetCheckedTexture():ClearAllPoints()
    self:GetCheckedTexture():SetSize(20, 20)
    self:GetCheckedTexture():SetPoint('LEFT')

    self:GetPushedTexture():ClearAllPoints()
    self:GetPushedTexture():SetSize(20, 20)
    self:GetPushedTexture():SetPoint('LEFT')

    self:GetHighlightTexture():ClearAllPoints()
    self:GetHighlightTexture():SetSize(20, 20)
    self:GetHighlightTexture():SetPoint('LEFT')

    self:GetDisabledCheckedTexture():ClearAllPoints()
    self:GetDisabledCheckedTexture():SetSize(20, 20)
    self:GetDisabledCheckedTexture():SetPoint('LEFT')

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    Text:SetPoint('LEFT', 20, 0)
    self:SetFontString(Text)

    self:SetNormalFontObject('GameFontHighlightSmall')
    self:SetDisabledFontObject('GameFontDisableSmall')
end


function MultiBox:Constructor(parent)
    if not parent then
        return
    end
    
    self.value = 0
    self:SetParent(parent)
    self:SetSelectMode('MULTI')
    self:SetItemClass(CheckBox)
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
