
BuildEnv(...)

local RadioButton = RaidBuilder:NewClass('RadioButton', GUI:GetClass('ItemButton'))

function RadioButton:Constructor(parent)
    if not parent then
        return
    end

    self:SetSize(100, 16)

    self:SetCheckedTexture([[Interface\Common\UI-DropDownRadioChecks]])
    self:GetCheckedTexture():SetTexCoord(0, 0.5, 0.5, 1.0)
    self:GetCheckedTexture():SetSize(16, 16)
    self:GetCheckedTexture():ClearAllPoints()
    self:GetCheckedTexture():SetPoint('LEFT', self)

    self:SetNormalTexture([[Interface\Common\UI-DropDownRadioChecks]])
    self:GetNormalTexture():SetTexCoord(0.5, 1.0, 0.5, 1.0)
    self:GetNormalTexture():SetSize(16, 16)
    self:GetNormalTexture():ClearAllPoints()
    self:GetNormalTexture():SetPoint('LEFT', self)

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLeft')
    Text:SetPoint('LEFT', 20, 0)
    self:SetFontString(Text)
end

