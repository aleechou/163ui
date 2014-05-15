
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local ChatTabButton = CloudUI:NewClass('ChatTabButton', GUI:GetClass('ItemButton'))

local TabView = GUI:GetClass('TabView')

function ChatTabButton:Constructor(parent)
    self:SetSize(50, 26)

    local inTab = TabView:IsInstance(parent)

    if inTab then
        self.tLeft = self:CreateTexture(nil, 'BACKGROUND')
        self.tLeft:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
        self.tLeft:SetWidth(12)
        self.tLeft:SetTexCoord(0.81835938, 0.84179688, 0.02246094, 0.047851565)
        self.tLeft:SetPoint('BOTTOMLEFT')
        self.tLeft:SetPoint('TOPLEFT')

        self.tRight = self:CreateTexture(nil, 'BACKGROUND')
        self.tRight:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
        self.tRight:SetWidth(12)
        self.tRight:SetTexCoord(0.84570313, 0.86914063, 0.05957031, 0.084960935)
        self.tRight:SetPoint('BOTTOMRIGHT')
        self.tRight:SetPoint('TOPRIGHT')

        self.tMid = self:CreateTexture(nil, 'BACKGROUND')
        self.tMid:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures_Tile]])
        self.tMid:SetTexCoord(0, 1, 0.67382813, 0.72460938)
        self.tMid:SetPoint('TOPLEFT', self.tLeft, 'TOPRIGHT')
        self.tMid:SetPoint('BOTTOMRIGHT', self.tRight, 'BOTTOMLEFT')

        self.tActiveLeft = self:CreateTexture(nil, 'OVERLAY')
        self.tActiveLeft:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
        self.tActiveLeft:SetWidth(12)
        self.tActiveLeft:SetTexCoord(0.84570313, 0.86914063, 0.02246094, 0.047851565)
        self.tActiveLeft:SetPoint('BOTTOMLEFT')
        self.tActiveLeft:SetPoint('TOPLEFT')

        self.tActiveRight = self:CreateTexture(nil, 'OVERLAY')
        self.tActiveRight:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
        self.tActiveRight:SetWidth(12)
        self.tActiveRight:SetTexCoord(0.87304688, 0.89648438, 0.05957031, 0.084960935)
        self.tActiveRight:SetPoint('BOTTOMRIGHT')
        self.tActiveRight:SetPoint('TOPRIGHT')

        self.tActiveMid = self:CreateTexture(nil, 'OVERLAY')
        self.tActiveMid:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures_Tile]])
        self.tActiveMid:SetTexCoord(0, 1, 0.59960938, 0.65039063)
        self.tActiveMid:SetPoint('TOPLEFT', self.tActiveLeft, 'TOPRIGHT')
        self.tActiveMid:SetPoint('BOTTOMRIGHT', self.tActiveRight, 'BOTTOMLEFT')

        self.tLightLeft = self:CreateTexture(nil, 'HIGHLIGHT')
        self.tLightLeft:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
        self.tLightLeft:SetWidth(12)
        self.tLightLeft:SetTexCoord(0.81835938, 0.84179688, 0.05957031, 0.084960935)
        self.tLightLeft:SetPoint('BOTTOMLEFT')
        self.tLightLeft:SetPoint('TOPLEFT')

        self.tLightRight = self:CreateTexture(nil, 'HIGHLIGHT')
        self.tLightRight:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures]])
        self.tLightRight:SetWidth(12)
        self.tLightRight:SetTexCoord(0.87304688, 0.89648438, 0.02246094, 0.047851565)
        self.tLightRight:SetPoint('BOTTOMRIGHT')
        self.tLightRight:SetPoint('TOPRIGHT')

        self.tLightMid = self:CreateTexture(nil, 'HIGHLIGHT')
        self.tLightMid:SetTexture([[Interface\EncounterJournal\UI-EncounterJournalTextures_Tile]])
        self.tLightMid:SetTexCoord(0, 1, 0.52539063, 0.57617188)
        self.tLightMid:SetPoint('TOPLEFT', self.tLightLeft, 'TOPRIGHT')
        self.tLightMid:SetPoint('BOTTOMRIGHT', self.tLightRight, 'BOTTOMLEFT')

        self:SetScript('OnMouseDown', self.OnDragStart)
        self:SetScript('OnMouseUp', self.OnDragStop)
    else
        self:SetHighlightTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]], 'ADD')
    end

    local CloseButton = GUI:GetClass('ClearButton'):New(self)
    CloseButton:SetPoint('RIGHT', inTab and -5 or 0, inTab and -3 or 0)
    CloseButton:SetScript('OnClick', function()
        self:GetOwner():CloseTab(self:GetID())
    end)

    local Icon = self:CreateTexture(nil, 'OVERLAY')
    Icon:SetSize(16, 16)
    Icon:SetPoint('LEFT', inTab and 10 or 0, inTab and -3 or 0)
    Icon:SetTexture([[INTERFACE\FriendsFrame\StatusIcon-Online]])

    local Text = self:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmallLeft')
    Text:SetPoint('LEFT', Icon, 'RIGHT', 2, 0)
    Text:SetPoint('RIGHT', CloseButton, 'LEFT', -2, 0)

    local Flash = CreateFrame('frame', nil, self, 'WowSocialCallOutTemplate')
    Flash:SetPoint('TOPLEFT', -5, 3)
    Flash:SetPoint('BOTTOMRIGHT', 5, -8)
    Flash:SetBackdropBorderColor(0, 1, 1)

    if not inTab then
        Flash:SetBackdrop(nil)
        Flash.BG:Show()
    end

    self.CloseButton = CloseButton
    self.Icon = Icon
    self.Text = Text
    self.Flash = Flash

    self:SetFontString(Text)
end

function ChatTabButton:SetStatus(status)
    if status == 'SELECTED' then
        self.tActiveLeft:Show()
        self.tActiveRight:Show()
        self.tActiveMid:Show()
        self.Icon:SetVertexColor(1, 1, 1, 1)
        self:Disable()
        self:SetHeight(28)
    end
    if status == 'NORMAL' or status == 'MORE' then
        self.tActiveLeft:Hide()
        self.tActiveRight:Hide()
        self.tActiveMid:Hide()
        self:Enable()
        self:SetHeight(26)
    end
    if status == 'NORMAL' or status == 'MENU' then
        self.Icon:SetVertexColor(0.5, 0.5, 0.5, 0.5)
    end
    if status == 'MORE' then
        self:SetText('')
        self.CloseButton:Hide()
        self:SetIcon([[INTERFACE\PaperDollInfoFrame\Character-Plus]])
        self:SetWidth(36)
        return
    end
    self:SetWidth(self:GetAutoWidth())
end

function ChatTabButton:SetIcon(texture)
    self.Icon:SetTexture(texture)
end

function ChatTabButton:OnEnter()
    self.closeButton:Show()
end

function ChatTabButton:OnLeave()
    self.closeButton:Hide()
end

function ChatTabButton:SetUnread(flag)
    self.Flash:SetShown(flag > 0)
end

function ChatTabButton:OnDragStart()
    self:FireHandler('OnItemDragStart')
end

function ChatTabButton:OnDragStop()
    self:FireHandler('OnItemDragStop')
end

function ChatTabButton:GetAutoWidth()
    return min(self:GetTextWidth() + 55, 150)
end
