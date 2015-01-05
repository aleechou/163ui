
local WIDGET, VERSION = 'ScrollBar', 3

local GUI = LibStub('NetEaseGUI-1.0')
local ScrollBar = GUI:NewClass(WIDGET, 'Slider.UIPanelScrollBarTemplate', VERSION)
if not ScrollBar then
    return
end

function ScrollBar:Constructor(parent)
    if not parent then
        return
    end
    self:SetParent(parent)
    self:SetScript('OnValueChanged', self.OnValueChanged)
    self:SetValueStep(1)
    self:SetMinMaxValues(0, 1)
    self:SetValue(0)
    self:Hide()
    self:SetStepsPerPage(1)
end

function ScrollBar:OnValueChanged(value)
    self:UpdateButton()
    self:GetParent():SetOffset(value)
end

function ScrollBar:UpdateButton()
    self.ScrollUpButton:Enable()
    self.ScrollDownButton:Enable()

    local value = self:GetValue()
    local minVal, maxVal = self:GetMinMaxValues()

    if value == minVal then
        self.ScrollUpButton:Disable()
    end
    if value == maxVal then
        self.ScrollDownButton:Disable()
    end
end

function ScrollBar:UpdateShown()
    if self.noScrollBarHidden then
        return
    end
    self:SetShown(self.minVal ~= self.maxVal)
end

ScrollBar.SetScrollStep = ScrollBar.SetStepsPerPage
ScrollBar.GetScrollStep = ScrollBar.GetStepsPerPage

local orig_SetMinMaxValues = ScrollBar.SetMinMaxValues

function ScrollBar:SetMinMaxValues(minVal, maxVal)
    orig_SetMinMaxValues(self, minVal, maxVal)
    self.minVal, self.maxVal = minVal, maxVal
    self:UpdateButton()
    self:UpdateShown()
end

function ScrollBar:AtTop()
    return self:GetValue() == self.minVal
end

function ScrollBar:AtBottom()
    return self:GetValue() == self.maxVal
end

function ScrollBar:ScrollToTop()
    self:SetValue(self.minVal)
end

function ScrollBar:ScrollToBottom()
    self:SetValue(self.maxVal)
end
