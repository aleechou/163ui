
BuildEnv(...)

local RewardPanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, MallPanel), 'RewardPanel', 'AceEvent-3.0', 'AceTimer-3.0')

function RewardPanel:OnInitialize()
    GUI:Embed(self, 'Owner', 'Tab', 'Refresh')

    MallPanel:RegisterPanel(L['兑换平台'], self, 8)

    local CodeWidget = GUI:GetClass('TitleWidget'):New(self)
    CodeWidget:SetPoint('TOPLEFT')
    CodeWidget:SetPoint('TOPRIGHT')
    CodeWidget:SetHeight(205)
    CodeWidget:SetText(L['输入兑换码：'])

    local SummaryWidget = GUI:GetClass('TitleWidget'):New(self)
    SummaryWidget:SetPoint('TOPLEFT', CodeWidget, 'BOTTOMLEFT', 0, -5)
    SummaryWidget:SetPoint('BOTTOMRIGHT')
    SummaryWidget:SetText(L['兑换说明：'])

    local InputBox = GUI:GetClass('EditBox'):New(CodeWidget)
    InputBox:SetPoint('TOPLEFT', 158.5, -50)
    InputBox:SetSize(533, 50)
    InputBox:SetPrompt(L['请在这里输入兑换码'])
    InputBox:SetSinglelLine()
    InputBox:SetMaxLetters(16)

    local InputBoxLabel = InputBox:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    InputBoxLabel:SetPoint('TOPLEFT', InputBox, 'BOTTOMLEFT', 0, -5)
    InputBoxLabel:SetText(L['不区分大小写，无需输入空格或连字符。'])

    local ErrorLabel = InputBox:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
    ErrorLabel:SetPoint('TOP', InputBox, 'BOTTOM', 0, -50)

    local RewardSummary = GUI:GetClass('SummaryHtml'):New(SummaryWidget)
    RewardSummary:SetPoint('TOP', 0, -30)
    RewardSummary:SetSize(650, 100)
    RewardSummary:SetText(L.RewardSummary)

    local ConfirmButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    ConfirmButton:SetPoint('BOTTOM', self:GetOwner():GetOwner(), 'BOTTOM', 0, 4)
    ConfirmButton:SetSize(120, 22)
    ConfirmButton:SetText(L['确认兑换'])
    ConfirmButton:Disable()
    ConfirmButton:SetScript('OnClick', function()
        self:Purchase()
        end)

    InputBox:SetCallback('OnTextChanged', function(InputBox, text)
        local nText = select(2, text:find('%w+'))
        local isTextOK = not text:find('%W+')
        if isTextOK then
            if nText == 16 then
                ErrorLabel:SetText(L['格式正确，请点击[确认兑换]按钮'])
            else
                ErrorLabel:SetText()
            end
            InputBox:SetText(text:upper())
        else
            ErrorLabel:SetText(#text > 0 and L['兑换码格式错误'] or nil)
        end
        ConfirmButton:SetEnabled(isTextOK and nText == 16)
        end)

    self:SetScript('OnShow', function(self)
        self:ScheduleTimer('SetBlocker', 0.01)
        end)

    self.InputBox = InputBox
    self.ConfirmButton = ConfirmButton
    self.ErrorLabel = ErrorLabel

    self:RegisterMessage('RAIDBUILDER_REWARD_RESULT', 'Result')
end

function RewardPanel:Result(event, result)
    self:SetBlocker(false)

    if result then
        System:Error(result) 
    end

    if self.timeout then
        self:CancelTimer(self.timeout)
        self.timeout = nil
    end
end

function RewardPanel:SetBlocker(enable)
    self.blocking = enable == nil and self.blocking or enable
    MainPanel:SetBlocker(self.blocking and 'REWARDPURCHASE')
    self:Timeout(self.blocking)
end

function RewardPanel:Timeout(enable)
    if enable and not self.timeout then
        self.timeout = self:ScheduleTimer('Result', 30, nil, L['兑换失败：处理超时，请稍后再试。'])
    end
end

function RewardPanel:Purchase()
    GUI:CallMessageDialog(L['确认使用兑换码？'], function(result)
        if result then
            Logic:Exchange(self.InputBox:GetText())
            self.ConfirmButton:Disable()
            self.ErrorLabel:SetText()
            self:SetBlocker(true)
        end
        end)
    self.InputBox:ClearFocus()
end
