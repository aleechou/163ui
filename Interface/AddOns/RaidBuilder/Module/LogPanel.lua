
BuildEnv(...)

local LogPanel = RaidBuilder:NewModule(CreateFrame('Frame', nil, OptionPanel), 'LogPanel', 'AceEvent-3.0')

function LogPanel:OnInitialize()
    GUI:Embed(self, 'Owner')

    OptionPanel:RegisterPanel(L['操作记录'], self, 8)

    local LogFrame = CreateFrame('ScrollingMessageFrame', nil, self)
    GUI:Embed(LogFrame, 'Scroll', 'Refresh')
    LogFrame:SetAllPoints(self)
    LogFrame:SetFading(nil)
    LogFrame:SetMaxLines(1000)
    LogFrame:SetInsertMode('TOP')
    LogFrame:SetFontObject('ChatFontNormal')
    LogFrame:SetJustifyH('LEFT')
    LogFrame:EnableMouseWheel(true)

    local ScrollBar = GUI:GetClass('ScrollBar'):New(LogFrame)
    ScrollBar:SetPoint('TOPRIGHT', 0, -16)
    ScrollBar:SetPoint('BOTTOMRIGHT', 0, 16)
    ScrollBar.scrollStep = 3
    ScrollBar:SetScript('OnValueChanged', function(self, value)
        local minValue, maxValue = self:GetMinMaxValues()
        local value = floor(value + 0.5)
        LogFrame:SetScrollOffset(value)

        self.ScrollUpButton:Enable()
        self.ScrollDownButton:Enable()
        if value == minValue then
            self.ScrollUpButton:Disable()
        end
        if value == maxValue then
            self.ScrollDownButton:Disable()
        end
    end)
    ScrollBar:SetMinMaxValues(1, 1)
    ScrollBar:SetValueStep(1)
    ScrollBar:SetValue(1)

    LogFrame:SetScript('OnMouseWheel', function(self, delta)
        ScrollBar:SetValue(ScrollBar:GetValue() - delta)
    end)

    local function msgOnChanged()
        local maxValue = max(0, LogFrame:GetNumMessages() - 1)
        ScrollBar:SetMinMaxValues(0, maxValue)
    end

    hooksecurefunc(LogFrame, 'AddMessage', msgOnChanged)
    hooksecurefunc(LogFrame, 'Clear', msgOnChanged)

    local ClearButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    ClearButton:SetPoint('BOTTOM', self:GetOwner():GetOwner(), 'BOTTOM', 0, 4)
    ClearButton:SetSize(120, 22)
    ClearButton:SetText(L['清除记录'])
    ClearButton:SetScript('OnClick', function()
        self:ClearLogs()
    end)

    local Tips = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmallRight')
    Tips:SetPoint('BOTTOMRIGHT', self:GetOwner():GetOwner(), -7, 7)
    Tips:SetText(L['|cffff0000注意：该记录仅储存在本地配置中|r'])

    self.LogFrame = LogFrame

    self:SetScript('OnUpdate', self.OnUpdate)
end

function LogPanel:RAIDBUILDER_LOG_ADDED(_, msg)
    self.LogFrame:AddMessage(msg, 1, 1, 1)
end

function LogPanel:RAIDBUILDER_LOG_CLEARED()
    self.LogFrame:Clear()
end

function LogPanel:OnUpdate()
    self.index = (self.index or 0) + 1
    local logs = Log:GetLogs()

    if self.index > #logs then
        self:SetScript('OnUpdate', nil)
        self:RegisterMessage('RAIDBUILDER_LOG_ADDED')
        self:RegisterMessage('RAIDBUILDER_LOG_CLEARED')
    else
        self.LogFrame:AddMessage(logs[self.index], 1, 1, 1)
    end
end

function LogPanel:ClearLogs()
    Log:ClearLogs()
    self.LogFrame:Clear()
end
