
BuildEnv(...)

MicroButton = RaidBuilder:NewModule(CreateFrame('Button', nil, MainMenuBarArtFrame), 'MicroButton', 'AceEvent-3.0', 'AceHook-3.0')

local RaidBuilderMicroButton = MicroButton

function MicroButton:OnInitialize()
    self:SetNormalTexture([[Interface\Buttons\UI-MicroButtonCharacter-Up]])
    self:SetPushedTexture([[Interface\Buttons\UI-MicroButtonCharacter-Down]])
    self:SetHighlightTexture([[Interface\Buttons\UI-MicroButton-Hilight]])
    self.tooltipText = MicroButtonTooltipText(L['集合石'], 'RAIDBUILDER_TOGGLE')
    self.newbieText = L['集合石插件帮助你快速找到队伍。']
    self:SetHitRectInsets(0, 0, 18, 0)
    self:SetSize(28, 58)
    self:SetScript('OnEnter', MicroButton_OnEnter)
    self:SetScript('OnLeave', GameTooltip_Hide)
    self:SetScript('OnMouseDown', self.OnMouseDown)
    self:SetScript('OnMouseUp', self.OnMouseUp)
    self:SetScript('OnClick', function()
        DataBroker:Toggle()
    end)

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetSize(20, 20)
    Icon:SetPoint('BOTTOM', 0, 8)
    Icon:SetTexture([[Interface\Addons\RaidBuilder\Media\Mark\0]])

    local Flash = GUI:GetClass('AlphaFlash'):New(self)
    Flash:SetPoint('TOPLEFT', -2, -18)
    Flash:SetSize(64, 64)
    Flash:SetTexture([[Interface\Buttons\Micro-Highlight]])
    Flash:Hide()

    local Frame = CreateFrame('Frame', nil, MainPanel)
    Frame:SetScript('OnShow', self.UpdateMicroButtons)
    Frame:SetScript('OnHide', self.UpdateMicroButtons)

    self.Flash = Flash
    self.Frame = Frame
    self.Icon = Icon
    self:Disable()
end

function MicroButton:OnEnable()
    self.Frame:Show()
    self:Show()
    self:SecureHook('UpdateMicroButtons')
    self:SecureHook('UpdateMicroButtonsParent')
    self:UpdateMicroButtons()
end

function MicroButton:OnDisable()
    self.Frame:Hide()
    self:Hide()
    self:UnhookAll()

    if CharacterMicroButton:GetParent() == MainMenuBarArtFrame then
        CharacterMicroButton:SetPoint('BOTTOMLEFT', MainMenuBarArtFrame, 'BOTTOMLEFT', 556, 2)
    end
    CompanionsMicroButton:SetPoint('BOTTOMLEFT', LFDMicroButton, 'BOTTOMRIGHT', -3, 0)

    UpdateMicroButtons()
end

function MicroButton:OnMouseDown()
    self.Icon:SetPoint('BOTTOM', -1, 7)
    self.Icon:SetVertexColor(0.6, 0.6, 0.6)
end

function MicroButton:OnMouseUp()
    self.Icon:SetPoint('BOTTOM', 0, 8)
    self.Icon:SetVertexColor(1, 1, 1)
end

function MicroButton:UpdateMicroButtonsParent(parent)
    self:SetParent(parent)
end

function MicroButton:UpdateMicroButtons()
    local parent = CharacterMicroButton:GetParent()
    RaidBuilderMicroButton:SetParent(parent)

    if parent == MainMenuBarArtFrame then
        CharacterMicroButton:ClearAllPoints()
        RaidBuilderMicroButton:ClearAllPoints()
        CompanionsMicroButton:ClearAllPoints()
        MainMenuMicroButton:ClearAllPoints()

        CharacterMicroButton:SetPoint('BOTTOMLEFT', parent, 'BOTTOMLEFT', 545, 2)
        RaidBuilderMicroButton:SetPoint('BOTTOMLEFT', LFDMicroButton, 'BOTTOMRIGHT', -3, 0)
        CompanionsMicroButton:SetPoint('BOTTOMLEFT', RaidBuilderMicroButton, 'BOTTOMRIGHT', -3, 0)
        MainMenuMicroButton:SetPoint('BOTTOMLEFT', C_StorePublic.IsEnabled() and StoreMicroButton or EJMicroButton, 'BOTTOMRIGHT', -3, 0)
    elseif parent == OverrideActionBar or (PetBattleFrame and parent == PetBattleFrame.BottomFrame.MicroButtonFrame) then
        RaidBuilderMicroButton:ClearAllPoints()
        CompanionsMicroButton:ClearAllPoints()
        MainMenuMicroButton:ClearAllPoints()

        RaidBuilderMicroButton:SetPoint('BOTTOMLEFT', LFDMicroButton, 'BOTTOMRIGHT', -2, 0)
        CompanionsMicroButton:SetPoint('BOTTOMLEFT', RaidBuilderMicroButton, 'BOTTOMRIGHT', -2, 0)
        MainMenuMicroButton:SetPoint('BOTTOMLEFT', C_StorePublic.IsEnabled() and StoreMicroButton or EJMicroButton, 'BOTTOMRIGHT', -2, 0)
    end

    if MainPanel:IsShown() then
        RaidBuilderMicroButton:SetButtonState('PUSHED', true)
        RaidBuilderMicroButton:OnMouseDown()
    else
        RaidBuilderMicroButton:SetButtonState('NORMAL')
        RaidBuilderMicroButton:OnMouseUp()
    end
end

function MicroButton:ToggleFlash(flag)
    self.Flash:SetShown(flag)
end
