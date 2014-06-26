
local WIDGET, VERSION = 'NumericBox', 1

local GUI = LibStub('NetEaseGUI-1.0')
local NumericBox = GUI:NewClass(WIDGET, GUI:GetClass('InputBox2'), VERSION)
if not NumericBox then
    return
end

local function ButtonOnClick(self)
    local parent = self:GetParent()
    parent:SetNumber(parent:GetNumber() + self.delta * parent.step)
end

function NumericBox:Constructor(parent)
    self:SetNumeric(true)

    local PlusButton = CreateFrame('Button', nil, self)
    PlusButton:SetSize(16, 16)
    PlusButton:SetPoint('BOTTOMLEFT', self, 'RIGHT')
    PlusButton:SetNormalTexture([[INTERFACE\BUTTONS\UI-PlusButton-Up]])
    PlusButton:SetPushedTexture([[INTERFACE\BUTTONS\UI-PlusButton-Down]])
    PlusButton:SetDisabledTexture([[INTERFACE\BUTTONS\UI-PlusButton-Disabled]])
    PlusButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-PlusButton-Hilight]], 'ADD')
    PlusButton:SetScript('OnClick', ButtonOnClick)
    PlusButton.delta = 1
    
    local MinusButton = CreateFrame('Button', nil, self)
    MinusButton:SetSize(16, 16)
    MinusButton:SetPoint('TOPLEFT', self, 'RIGHT')
    MinusButton:SetNormalTexture([[INTERFACE\BUTTONS\UI-MinusButton-Up]])
    MinusButton:SetPushedTexture([[INTERFACE\BUTTONS\UI-MinusButton-Down]])
    MinusButton:SetDisabledTexture([[INTERFACE\BUTTONS\UI-MinusButton-Disabled]])
    MinusButton:SetHighlightTexture([[INTERFACE\BUTTONS\UI-PlusButton-Hilight]], 'ADD')
    MinusButton:SetScript('OnClick', ButtonOnClick)
    MinusButton.delta = -1

    self.PlusButton = PlusButton
    self.MinusButton = MinusButton

    self:SetMinMaxValues(0, 99)
    self:SetValueStep(1)

    self:SetScript('OnTextChanged', self.OnTextChanged)
    self:SetScript('OnMouseWheel', self.OnMouseWheel)
    self:SetScript('OnEditFocusLost', self.OnTextChanged)

    self:HookScript('OnEnable', self.OnEnableChanged)
    self:HookScript('OnDisable', self.OnEnableChanged)
end

function NumericBox:SetMinMaxValues(minValue, maxValue)
    if type(minValue) ~= 'number' then
        error(([[bad argument #1 to 'SetMinMaxValues' (number expected, got %s)]]):format(type(minValue)), 2)
    end
    if type(maxValue) ~= 'number' then
        error(([[bad argument #2 to 'SetMinMaxValues' (number expected, got %s)]]):format(type(maxValue)), 2)
    end
    if minValue < 0 then
        error('err min value', 2)
    end
    if minValue > maxValue then
        error('err max value', 2)
    end

    self.minValue = floor(minValue)
    self.maxValue = floor(maxValue)

    self:SetMaxBytes(#(tostring(self.maxValue)) + 1)

    self:OnEnableChanged()

    self:Fire('OnMinMaxChanged', minValue, maxValue)
end

function NumericBox:SetValueStep(step)
    self.step = step
end

function NumericBox:OnTextChanged(userInput)
    if not userInput or #self:GetText() == self:GetMaxBytes() - 1 then
        local value = self:GetNumber()
        if value < self.minValue then
            return self:SetNumber(self.minValue)
        elseif value > self.maxValue then
            return self:SetNumber(self.maxValue)
        end
    end

    self:OnEnableChanged()
    self:Fire('OnValueChanged', value)
end

function NumericBox:OnMouseWheel(delta)
    if not self:IsEnabled() then
        return
    end
    if delta > 0 then
        self.PlusButton:Click()
    else
        self.MinusButton:Click()
    end
end

function NumericBox:OnEnableChanged()
    local isEnabled = self:IsEnabled()
    local value = self:GetNumber()

    self.PlusButton:SetEnabled(isEnabled and value < self.maxValue)
    self.MinusButton:SetEnabled(isEnabled and value > self.minValue)
end
