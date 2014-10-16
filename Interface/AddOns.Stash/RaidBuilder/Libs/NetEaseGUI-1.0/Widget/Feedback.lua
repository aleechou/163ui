
local GUI = assert(LibStub('NetEaseGUI-1.0'), 'NetEaseGUI-DropMenu-1.0 requests NetEaseGUI')

local Feedback = GUI.Feedback or GUI:GetClass('TitlePanel'):New(UIParent)
Feedback:Hide()
GUI.Feedback = Feedback

local L = {
    Title = '意见建议',
    Prompt = '请在这里输入反馈内容',
    Mail = '如有更多意见，可以发送电邮：wow_social@163.com',
    Commit = '提交',
    FeedbackSummary = [[
<html>
<body>
<p>感谢您使用 |cffffd100%s v%s|r</p>
<p>您的支持就是我们最大的动力！</p>
<br />
<h1>论坛地址：</h1>
<p>|Hurl:http://www.battlenet.com.cn/wow/zh/forum/12507946/|h|cff00ffff[http://www.battlenet.com.cn/wow/zh/forum/12507946/]|r|h</p>
<h1>专题：</h1>
<p>|Hurl:http://w.163.com/special/wowsocial/|h|cff00ffff[http://w.163.com/special/wowsocial/]|r|h</p>
</body>
</html>
]],
}

function Feedback:OnLoad()
    self:SetSize(420, 400)
    self:SetPoint('CENTER')
    self:SetText(L.Title)
    self:SetFrameStrata('DIALOG')

    local bottomBackground = self:CreateTexture(nil, 'ARTWORK')
    bottomBackground:SetTexture([[Interface\Buttons\UI-Button-Borders]])
    bottomBackground:SetTexCoord(0, 1.0, 0.59375, 1.0)
    bottomBackground:SetSize(256, 26)
    bottomBackground:SetPoint('BOTTOMLEFT', 11, 9)
    bottomBackground:SetPoint('BOTTOMRIGHT', -11, 9)

    local SummaryHtml = GUI:GetClass('SummaryHtml'):New(self)
    SummaryHtml:SetSize(380, 120)
    SummaryHtml:SetPoint('TOP', 0, -30)
    
    local text = GUI:GetClass('EditBox'):New(self)
    text:SetPoint('TOPLEFT', SummaryHtml, 'BOTTOMLEFT', 0, -20)
    text:SetPoint('BOTTOMRIGHT', -20, 85)
    text:SetPrompt(L.Prompt)

    local Label = self:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
    Label:SetPoint('BOTTOMLEFT', 20, 45)
    Label:SetText(L.Mail)

    local sendButton = CreateFrame('Button', nil, self, 'UIPanelButtonTemplate')
    sendButton:SetPoint('BOTTOMRIGHT', -20, 12)
    sendButton:SetSize(72, 22)
    sendButton:SetText(L.Commit)
    sendButton:SetScript('OnClick', function()
        self:Send(strtrim(text:GetText()))
    end)

    self.FinishAnimation = finishTextAnimationGroup
    self.Text = text
    self.SummaryHtml = SummaryHtml
    self.SendButton = sendButton

    self:SetScript('OnShow', self.OnShow)
    self:OnShow()
end

function Feedback:OnShow()
    self.SummaryHtml:SetText(format(L.FeedbackSummary, self.title, self.version))
    self.Text:SetText()
    self.Text:SetFocus(true)
end

function Feedback:Open(addonName, callback)
    local title = select(2, GetAddOnInfo(addonName))
    local version = GetAddOnMetadata(addonName, 'Version')

    self.title = title
    self.addonName = addonName
    self.version = version
    self.callback = callback

    self:Show()
end

function Feedback:Send(text)
    if #text > 0 and type(self.callback) == 'function' then
        self.callback(true, text)
    end
    self:Hide()
end

Feedback:SetScript('OnShow', Feedback.OnLoad)
