
BuildEnv(...)

BigButton = RaidBuilder:NewClass('BigButton', 'Button')

function BigButton:Constructor(parent)
    if not parent then
        return
    end

    self:SetParent(parent)

    -- self:SetSize(174, 54)
    -- self:SetNormalTexture([[INTERFACE\HELPFRAME\HelpButtons]])
    -- self:SetPushedTexture([[INTERFACE\HELPFRAME\HelpButtons]])
    -- self:SetHighlightTexture([[INTERFACE\HELPFRAME\HelpButtons]], 'ADD')
    -- self:SetDisabledTexture([[INTERFACE\HELPFRAME\HelpButtons]])

    -- self:GetNormalTexture():SetTexCoord(0.00390625, 0.68359375, 0.44140625, 0.65234375)
    -- self:GetPushedTexture():SetTexCoord(0.00390625, 0.68359375, 0.22265625, 0.43359375)
    -- self:GetHighlightTexture():SetTexCoord(0.00390625, 0.68359375, 0.00390625, 0.21484375)
    -- self:GetDisabledTexture():SetTexCoord(0.00390625, 0.68359375, 0.44140625, 0.65234375)
    -- self:GetDisabledTexture():SetDesaturated(true)

    self:SetSize(228, 91)

    self:SetNormalTexture([[Interface\Glues\AccountUpgrade\upgrade-texture]])
    self:SetPushedTexture([[Interface\Glues\AccountUpgrade\upgrade-texture]])
    self:SetHighlightTexture([[Interface\Glues\AccountUpgrade\upgrade-texture]], 'ADD')
    self:SetDisabledTexture([[Interface\Glues\AccountUpgrade\upgrade-texture]])

    self:GetNormalTexture():SetTexCoord(0.45019531, 0.67285156, 0.00097656, 0.08984375)
    self:GetPushedTexture():SetTexCoord(0.22558594, 0.44824219, 0.00097656, 0.08984375)
    self:GetHighlightTexture():SetTexCoord(0.67480469, 0.89746094, 0.00097656, 0.08984375)
    self:GetHighlightTexture():SetAlpha(0.6)
    self:GetDisabledTexture():SetTexCoord(0.45019531, 0.67285156, 0.00097656, 0.08984375)
    self:GetDisabledTexture():SetDesaturated(true)

    -- self:GetNormalTexture():SetTexCoord(0.00097656, 0.22363281, 0.09179688, 0.18066406)
    -- self:GetPushedTexture():SetTexCoord(0.22558594, 0.44824219, 0.09179688, 0.18066406)
    -- self:GetHighlightTexture():SetTexCoord(0.00097656, 0.22363281, 0.00097656, 0.08984375)
    -- self:GetHighlightTexture():SetAlpha(0.6)
    -- self:GetDisabledTexture():SetTexCoord(0.00097656, 0.22363281, 0.09179688, 0.18066406)
    -- self:GetDisabledTexture():SetDesaturated(true)

    self:SetNormalFontObject('GameFontNormalLarge')
    self:SetDisabledFontObject('GameFontDisableLarge')
    self:SetHighlightFontObject('GameFontHighlightLarge')
end
