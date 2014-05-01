
BuildEnv(...)

local RoleCheckBox = RaidBuilder:NewClass('RoleCheckBox', GUI:GetClass('ItemButton'))

function RoleCheckBox:Constructor(parent)
    self:SetParent(parent)

    self:SetNormalTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]])
    self:GetNormalTexture():SetTexCoord(0, 0.25, 0, 1)
    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetPoint('TOPLEFT')
    self:GetNormalTexture():SetSize(16, 16)

    self:SetCheckedTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]])
    self:GetCheckedTexture():SetTexCoord(0.25, 0.5, 0, 1)
    self:GetCheckedTexture():ClearAllPoints()
    self:GetCheckedTexture():SetPoint('TOPLEFT')
    self:GetCheckedTexture():SetSize(16, 16)

    self:SetHighlightTexture([[INTERFACE\BUTTONS\UI-RADIOBUTTON]], 'ADD')
    self:GetHighlightTexture():SetTexCoord(0.5, 0.75, 0, 1)
    self:GetHighlightTexture():ClearAllPoints()
    self:GetHighlightTexture():SetPoint('TOPLEFT')
    self:GetHighlightTexture():SetSize(16, 16)

    self.Icon = self:CreateTexture(nil, 'BACKGROUND')
    self.Icon:SetPoint('TOPRIGHT')

    local Text = self:CreateFontString(nil, 'OVERLAY')
    Text:SetPoint('TOP', self.Icon, 'BOTTOM', 0, -1)
    self:SetFontString(Text)
    self:SetNormalFontObject('GameFontNormalSmall')
    self:SetHighlightFontObject('GameFontHighlightSmall')
    self:SetDisabledFontObject('GameFontDisableSmall')

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
end

function RoleCheckBox:OnSizeChanged(width, height)
    self.Icon:SetSize(height-15, height-15)
end

function RoleCheckBox:SetStyle(style)
    local icon, coords = GetRoleIconLarge(style)
    local text, note = GetRoleInfo(style)
    self.Icon:SetTexture(icon)
    self.Icon:SetTexCoord(unpack(coords))
    self:SetText(text)
end
