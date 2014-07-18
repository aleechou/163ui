
BuildEnv(...)

local YiXinSummary = RaidBuilder:NewModule(GUI:GetClass('TitlePanel'):New(UIParent), 'YiXinSummary') 

function YiXinSummary:OnInitialize()
    self:Hide()
    self:SetFrameStrata('DIALOG')
    self:SetSize(450, 600)
    self:SetPoint('CENTER')
    self:SetText(L['易信推送'])

    local Summary = GUI:GetClass('SummaryHtml'):New(self)
    Summary:SetSize(390, 380)
    Summary:SetPoint('TOP', 0, -30)
    -- Summary:SetText(L.YiXinSummary)

    local qrYiXin = GUI:GetClass('QRCodeWidget'):New(self)
    qrYiXin:SetSize(150, 150)
    qrYiXin:SetToplevel(true)
    qrYiXin:SetPoint('TOPLEFT', Summary, 'BOTTOMLEFT', 20, 0)
    qrYiXin:SetValue('http://yixin.im/m')
    local qrcodeText = qrYiXin:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    qrcodeText:SetPoint('TOP', qrYiXin, 'BOTTOM', 0, -10)
    qrcodeText:SetText(L['易信下载二维码'])

    local qr = GUI:GetClass('QRCodeWidget'):New(self)
    qr:SetSize(150, 150)
    qr:SetToplevel(true)
    qr:SetPoint('BOTTOMLEFT', qrYiXin, 'BOTTOMRIGHT', 50, 0)
    qr:SetValue('http://yixin.im/g/MTE1NDMwODMtMTE1NDMwODMtMTM4Nzg2NzEwNg==')
    local qrText = qr:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
    qrText:SetPoint('TOP', qr, 'BOTTOM', 0, -10)
    qrText:SetText(L['魔兽世界公众号'])

    self.Summary = Summary
end

function YiXinSummary:SetArguments(name, realm)
    if name and realm then
        self.Summary:SetText(_format(L.YiXinSummary, name, realm))
    else
        self.Summary:SetText(_format(L.YiXinSummary, _G.UnitFullName('player')))
    end
end

local YixinConfirm = RaidBuilder:NewModule(CreateFrame('Frame', nil, UIParent), 'YixinConfirm', 'AceEvent-3.0', 'AceHook-3.0')

function YixinConfirm:OnInitialize()
    self:Hide()
    self:SetFrameStrata('DIALOG')
    self:ClearAllPoints()
    self:SetSize(400, 220)
    self:SetBackdrop{
        bgFile = [[Interface\DialogFrame\UI-DialogBox-Background-Dark]],
        edgeFile = [[Interface\DialogFrame\UI-DialogBox-Border]],
        insets = { left = 8, right = 8, top = 8, bottom = 8 },
        tileSize = 24, edgeSize = 24, tile = true,
    }

    local Label = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    Label:SetPoint('TOP', 0, -20)
    Label:SetWidth(290)
    Label:SetText(L['使用手机推送功能后，将会把本次活动信息通过易信消息发送到关注你的玩家手机上。'])

    local HelpButton = CreateFrame('Button', nil, self)
    HelpButton:SetPoint('TOPLEFT', Label, 'BOTTOMLEFT', 20, -10)
    HelpButton:SetPoint('TOPRIGHT', Label, 'BOTTOMRIGHT', -20, -10)
    HelpButton:SetHeight(30)

    local Icon = HelpButton:CreateTexture(nil, 'ARTWORK')
    Icon:SetTexture([[INTERFACE\Calendar\EventNotification]])
    Icon:SetSize(30, 30)
    Icon:SetPoint('LEFT')

    local Text = HelpButton:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT', Icon, 'RIGHT', 0, 0)
    HelpButton:SetFontString(Text)
    HelpButton:SetNormalFontObject('GameFontNormalSmall')
    HelpButton:SetHighlightFontObject('GameFontGreenSmall')
    HelpButton:SetText(L['使用本功能需要具备的条件？'])
    HelpButton:SetScript('OnClick', function(button)
        RaidBuilder:ShowModule('YiXinSummary')
        HideParentPanel(button)
    end)

    local Warning = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlightSmall')
    Warning:SetPoint('TOP', HelpButton, 'BOTTOM', 0, -10)
    Warning:SetWidth(290)
    Warning:SetText(L['你每天有三次发送活动通知的机会'])

    local Error = self:CreateFontString(nil, 'OVERLAY', 'GameFontRedSmall')
    Error:SetPoint('TOP', Warning, 'BOTTOM', 0, -3)
    Error:SetWidth(290)

    local SendButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    SendButton:SetPoint('BOTTOMRIGHT', self, 'BOTTOM', -5, 15)
    SendButton:SetSize(130, 22)
    SendButton:SetText(L['发送通知'])
    SendButton:SetScript('OnClick', function(button)
        Logic:SendYiXinNotify()
        HideParentPanel(button)
    end)

    local CancelButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    CancelButton:SetPoint('BOTTOMLEFT', self, 'BOTTOM', 5, 15)
    CancelButton:SetSize(130, 22)
    CancelButton:SetText(CANCEL)
    CancelButton:SetScript('OnClick', HideParentPanel)

    self:SetScript('OnHide', StaticPopupSpecial_Hide)
    
    self.Error = Error
    self.SendButton = SendButton
end

function YixinConfirm:SetArguments(flag, error)
    if flag then
        self.SendButton:Enable()
        self.Error:Hide()
    else
        self.SendButton:Disable()
        self.Error:Show()
        self.Error:SetText(error)
    end
    StaticPopupSpecial_Show(self)
end
