
BuildEnv(...)

local RefreshButton = Addon:NewClass('RefreshButton', 'Button.UIMenuButtonStretchTemplate')

function RefreshButton:Constructor(parent)
    if not parent then
        return
    end

    local Icon = self:CreateTexture(nil, 'ARTWORK') do
        Icon:SetSize(16, 16)
        Icon:SetTexture([[Interface\BUTTONS\UI-RefreshButton]])
        Icon:SetPoint('LEFT', 10, 0)
    end

    local Label = self:GetFontString() do
        Label:ClearAllPoints()
        Label:SetPoint('CENTER', 8, 0)

        self:SetNormalFontObject('GameFontNormal')
        self:SetHighlightFontObject('GameFontHighlight')
        self:SetDisabledFontObject('GameFontDisable')
    end

    self:SetParent(parent)
    self:SetSize(83, 31)
    self:SetText(REFRESH)
    self.Icon = Icon

    self:HookScript('OnEnable', self.OnEnable)
    self:HookScript('OnDisable', self.OnDisable)
end

function RefreshButton:OnEnable()
    self.Icon:SetDesaturated(false)
    self.Icon:SetAlpha(1)
end

function RefreshButton:OnDisable()
    self.Icon:SetDesaturated(true)
    self.Icon:SetAlpha(0.5)
end

function RefreshButton:SetTooltip(...)
    GUI:SetTooltip(self, 'ANCHOR_RIGHT', ...)
end
