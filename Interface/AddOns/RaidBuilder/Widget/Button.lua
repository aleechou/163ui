
BuildEnv(...)

Button = RaidBuilder:NewClass('Button', 'Button')

function Button:Constructor(parent)
    if not parent then
        return
    end

    self:EnableMouse(true)
    self:RegisterForClicks('LeftButtonUp')
    self:SetParent(parent)
    self:SetSize(36, 36)
    self:SetBackdrop{
        edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
        tileSize = 16, edgeSize = 16, tile=true
    }
    self:SetBackdropBorderColor(0.8, 0.8, 0.8, 0.8)
    self:SetMotionScriptsWhileDisabled(true)

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('LEFT', self, 'RIGHT', 2, 0)
    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontNormalSmallLeft')
    self:SetHighlightFontObject('GameFontHighlightSmallLeft')
    self:SetDisabledFontObject('GameFontDisableSmallLeft')

    local Icon = self:CreateTexture(nil, 'BACKGROUND')
    Icon:SetPoint('TOPLEFT', 3, -3)
    Icon:SetPoint('BOTTOMRIGHT', -3, 3)

    local Highlight = self:CreateTexture(nil, 'HIGHLIGHT')
    Highlight:SetPoint('TOPLEFT', 3, -3)
    Highlight:SetPoint('BOTTOMRIGHT', -3, 3)
    Highlight:SetTexture([[INTERFACE\BUTTONS\ButtonHilight-Square]])
    Highlight:SetBlendMode('ADD')

    self:SetScript('OnEnable', self.OnEnable)
    self:SetScript('OnDisable', self.OnDisable)

    self.Icon = Icon
    self.Text = Text
end

function Button:SetText(text)
    self.Text:SetText(text)
    self:SetHitRectInsets(0, -self.Text:GetWidth(), 0, 0)
end

function Button:SetTooltip(...)
    GUI:SetTooltip(self, 'ANCHOR_RIGHT', ...)
end

function Button:OnEnable()
    self.Icon:SetDesaturated(false)
end

function Button:OnDisable()
    self.Icon:SetDesaturated(true)
end

function Button:SetIcon(icon)
    self.Icon:SetTexture(icon)
end
