
local WIDGET, VERSION = 'TimePicker', 1

local GUI = LibStub('NetEaseGUI-1.0')
local TimePicker = GUI:NewClass(WIDGET, 'Frame', VERSION)
if not TimePicker then
    return
end

local function OnTextChanged(self)
    if self:GetNumber() >= self.maxValue then
        self:SetNumber(self.maxValue - 1)
    end
end

local function StepInputBoxValue(self, y)
    local value = self:GetNumber()
    local delta = self.delta * y

    delta = value % delta == 0 and delta or delta-(value%delta)
    value = value + delta

    if value < 0 then
        value = self.maxValue + value
    end
    if value >= self.maxValue then
        value = 0
    end
    self:SetNumber(value)
end

local function ButtonOnClick(self)
    StepInputBoxValue(self.InputBox, self.y)
end

local function InputBoxOnMouseWheel(self, y)
    StepInputBoxValue(self, -y)
end

local function MakeArrowButton(parent, style)
    local Button = CreateFrame('Button', nil, parent)
    if style == 'ADD' then
        Button:SetNormalTexture([[INTERFACE\BUTTONS\Arrow-Down-Up]])
        Button:SetPushedTexture([[INTERFACE\BUTTONS\Arrow-Down-Down]])

        Button:GetNormalTexture():SetTexCoord(0, 1, 0, 0.5)
        Button:GetPushedTexture():SetTexCoord(0, 1, 0, 0.5)

        Button.y = 1
    elseif style == 'SUB' then
        Button:SetNormalTexture([[INTERFACE\BUTTONS\Arrow-Up-Up]])
        Button:SetPushedTexture([[INTERFACE\BUTTONS\Arrow-Up-Down]])

        Button:GetNormalTexture():SetTexCoord(0, 1, 0.5, 1)
        Button:GetPushedTexture():SetTexCoord(0, 1, 0.5, 1)

        Button.y = -1
    end

    Button:GetNormalTexture():ClearAllPoints()
    Button:GetNormalTexture():SetPoint('CENTER')
    Button:GetNormalTexture():SetSize(16, 8)

    Button:GetPushedTexture():ClearAllPoints()
    Button:GetPushedTexture():SetPoint('CENTER')
    Button:GetPushedTexture():SetSize(16, 8)

    Button:SetScript('OnClick', ButtonOnClick)

    return Button
end

function TimePicker:Constructor(parent)
    if not parent then
        return
    end

    local HourSub = MakeArrowButton(self, 'SUB')
    HourSub:SetPoint('TOPLEFT')
    HourSub:SetPoint('TOPRIGHT', self, 'TOP', -3, 0)
    HourSub:SetHeight(8)

    local HourAdd = MakeArrowButton(self, 'ADD')
    HourAdd:SetPoint('BOTTOMLEFT')
    HourAdd:SetPoint('BOTTOMRIGHT', self, 'BOTTOM', -3, 0)
    HourAdd:SetHeight(8)

    local Hour = GUI:GetClass('InputBox2'):New(self)
    Hour:SetPoint('TOPLEFT', HourSub, 'BOTTOMLEFT')
    Hour:SetPoint('BOTTOMRIGHT', HourAdd, 'TOPRIGHT')
    Hour:SetNumeric(true)
    Hour:SetMaxLetters(2)
    Hour:SetNumber(0)
    Hour:EnableMouseWheel(true)
    Hour:SetScript('OnTabPressed', function(self)
        self:GetParent().Minute:SetFocus()
    end)
    Hour:SetScript('OnMouseWheel', InputBoxOnMouseWheel)

    local MinuteSub = MakeArrowButton(self, 'SUB')
    MinuteSub:SetPoint('TOPRIGHT')
    MinuteSub:SetPoint('TOPLEFT', self, 'TOP', 3, 0)
    MinuteSub:SetHeight(8)

    local MinuteAdd = MakeArrowButton(self, 'ADD')
    MinuteAdd:SetPoint('BOTTOMRIGHT')
    MinuteAdd:SetPoint('BOTTOMLEFT', self, 'BOTTOM', 3, 0)
    MinuteAdd:SetHeight(8)

    local Minute = GUI:GetClass('InputBox2'):New(self)
    Minute:SetPoint('TOPLEFT', MinuteSub, 'BOTTOMLEFT')
    Minute:SetPoint('BOTTOMRIGHT', MinuteAdd, 'TOPRIGHT')
    Minute:SetNumeric(true)
    Minute:SetMaxLetters(2)
    Minute:SetNumber(0)
    Minute:EnableMouseWheel(true)
    Minute:SetScript('OnTabPressed', function(self)
        self:GetParent().Hour:SetFocus()
    end)
    Minute:SetScript('OnMouseWheel', InputBoxOnMouseWheel)

    local Label = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    Label:SetPoint('CENTER')
    Label:SetText(':')

    Hour.maxValue = 24
    Hour.delta = 1
    HourAdd.InputBox = Hour
    HourSub.InputBox = Hour

    Minute.maxValue = 60
    Minute.delta = 5
    MinuteAdd.InputBox = Minute
    MinuteSub.InputBox = Minute

    Hour:SetScript('OnTextChanged', OnTextChanged)
    Minute:SetScript('OnTextChanged', OnTextChanged)

    self.Hour = Hour
    self.Minute = Minute

    self:SetParent(parent)
end

function TimePicker:SetTime(hour, minute)
    self.Hour:SetTime(hour)
    self.Minute:SetTime(minute)
end

function TimePicker:GetTime()
    return self.Hour:GetNumber(), self.Minute:GetNumber()
end
