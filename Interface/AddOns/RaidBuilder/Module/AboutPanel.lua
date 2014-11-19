
BuildEnv(...)

local AboutPanel = RaidBuilder:NewModule(CreateFrame('Frame'), 'AboutPanel')

function AboutPanel:OnInitialize()
    GUI:Embed(self, 'Owner')

    OptionPanel:RegisterPanel(L['联系我们'], self, 8)

    local QunQR = GUI:GetClass('QRCodeWidget'):New(self)
    QunQR:SetSize(150, 150)
    QunQR:SetPoint('RIGHT', -10, 20)
    QunQR:SetValue([[http://qm.qq.com/cgi-bin/qm/qr?k=qFhEd4KntwQhOqv0x6-0x2lcLs7pqa4o]])

    local QunQRLabel = QunQR:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
    QunQRLabel:SetText(L['官方QQ群'])
    QunQRLabel:SetPoint('TOP', QunQR, 'BOTTOM', 0, -10)

    local Summary = GUI:GetClass('SummaryHtml'):New(self)
    Summary:SetPoint('TOPLEFT', 20, -20)
    Summary:SetPoint('BOTTOMLEFT', 20, 20)
    Summary:SetPoint('RIGHT', QunQR, 'LEFT', -20, 0)
    Summary:SetText(L.AboutSummary)
end
