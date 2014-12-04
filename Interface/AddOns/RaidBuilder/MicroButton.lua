
BuildEnv(...)

MicroButton = RaidBuilder:NewModule(CreateFrame('Button', nil, MainMenuBarArtFrame), 'MicroButton', 'AceEvent-3.0', 'AceHook-3.0')

function MicroButton:OnInitialize()
    GUI:Embed(self, 'Refresh')

    self:Hide()
    self:SetPoint('BOTTOMLEFT', LFDMicroButton, 'BOTTOMRIGHT', -2, 0)
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
    Icon:SetSize(24, 24)
    Icon:SetPoint('BOTTOM', 0, 6)
    Icon:SetTexture([[Interface\Addons\RaidBuilder\Media\Mark\0]])

    local Flash = GUI:GetClass('AlphaFlash'):New(self)
    Flash:SetPoint('TOPLEFT', -2, -18)
    Flash:SetSize(64, 64)
    Flash:SetTexture([[Interface\Buttons\Micro-Highlight]])
    Flash:Hide()

    local function Update()
        _G.UpdateMicroButtons()
    end

    local Frame = CreateFrame('Frame', nil, MainPanel)
    Frame:Hide()
    Frame:SetScript('OnShow', Update)
    Frame:SetScript('OnHide', Update)

    self.Flash = Flash
    self.Frame = Frame
    self.Icon = Icon
    self:Disable()
end

function MicroButton:OnEnable()
    self:SecureHook('UpdateMicroButtons')
    self:SecureHook('UpdateMicroButtonsParent', 'SetParent')

    self:SetParent(CharacterMicroButton:GetParent())

    self.Frame:Show()
    self:Show()
    self:Refresh()
end

function MicroButton:OnDisable()
    CompanionsMicroButton:ClearAllPoints()
    CompanionsMicroButton:SetPoint('BOTTOMLEFT', LFDMicroButton, 'BOTTOMRIGHT', -2, 0)

    if CharacterMicroButton:GetParent() == MainMenuBarArtFrame then
        CharacterMicroButton:ClearAllPoints()
        CharacterMicroButton:SetPoint('BOTTOMLEFT', MainMenuBarArtFrame, 'BOTTOMLEFT', 556, 2)
    end

    self:UnhookAll()
    self.Frame:Hide()
    self:Hide()
end

function MicroButton:OnMouseDown()
    self.Icon:SetPoint('BOTTOM', -1, 5)
    self.Icon:SetVertexColor(0.6, 0.6, 0.6)
end

function MicroButton:OnMouseUp()
    if not MainPanel:IsShown() then
        self.Icon:SetPoint('BOTTOM', 0, 6)
        self.Icon:SetVertexColor(1, 1, 1)
    end
end

function MicroButton:UpdateMicroButtons()
    self:Show()
    self:Refresh()
end

function MicroButton:Update()
    local parent = CharacterMicroButton:GetParent()
    if not (parent == MainMenuBarArtFrame or
            parent == OverrideActionBar or
            (PetBattleFrame and parent == PetBattleFrame.BottomFrame.MicroButtonFrame)) then
        return self:Hide()
    end

    CompanionsMicroButton:ClearAllPoints()
    CompanionsMicroButton:SetPoint('BOTTOMLEFT', self, 'BOTTOMRIGHT', -2, 0)

    if parent == MainMenuBarArtFrame then
        CharacterMicroButton:ClearAllPoints()
        CharacterMicroButton:SetPoint('BOTTOMLEFT', MainMenuBarArtFrame, 'BOTTOMLEFT', 545, 2)
    end

    MainMenuMicroButton:SetPoint('BOTTOMLEFT', C_StorePublic.IsEnabled() and StoreMicroButton or EJMicroButton, 'BOTTOMRIGHT', -2, 0)

    if MainPanel:IsShown() then
        self:SetButtonState('PUSHED', true)
        self:OnMouseDown()
    else
        self:SetButtonState('NORMAL')
        self:OnMouseUp()
    end
end

function MicroButton:ToggleFlash(flag)
    self.Flash:SetShown(flag)
end
