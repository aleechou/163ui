
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local SpecTabButton = CloudUI:NewClass('SpecTabButton', GUI:GetClass('ItemButton'))

local TabView = GUI:GetClass('TabView')

function SpecTabButton:Constructor(parent)
    self:SetParent(parent)
    self:SetSize(32, 32)

    local Border = self:CreateTexture(nil, 'BACKGROUND')
    Border:SetTexture([[Interface\SpellBook\SpellBook-SkillLineTab]])
    Border:SetSize(64, 64)

    local Icon = self:CreateTexture(nil, 'ARTWORK')
    Icon:SetPoint('TOPLEFT')
    Icon:SetSize(32, 32)

    local Shine = GUI:GetClass('ShineWidget'):New(self)
    Shine:SetAllPoints(self)

    self.Shine = Shine
    self.Border = Border
    self.Icon = Icon
    
    self:SetReverse(false)

    if TabView:IsInstance(parent) then
        self:SetCheckedTexture([[INTERFACE\BUTTONS\CheckButtonHilight]])
        self:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]], 'ADD')
    else
        Border:Hide()

        self:SetHighlightTexture([[INTERFACE\QUESTFRAME\UI-QuestTitleHighlight]], 'ADD')
    end
end

local orig_SetChecked = SpecTabButton.SetChecked
function SpecTabButton:SetChecked(...)
    orig_SetChecked(self, ...)
    if self:GetChecked() then
        self.Shine:Start()
    else
        self.Shine:Stop()
    end
end

function SpecTabButton:SetReverse(reverse)
    if self.reverse == reverse then
        return
    end
    self.reverse = reverse

    if reverse then
        self.Border:ClearAllPoints()
        self.Border:SetPoint('TOPRIGHT', 3, 11)
        self.Border:SetTexCoord(1, 0, 0, 1)
    else
        self.Border:ClearAllPoints()
        self.Border:SetPoint('TOPLEFT', -3, 11)
        self.Border:SetTexCoord(0, 1, 0, 1)
    end
end

function SpecTabButton:SetIcon(texture)
    self.Icon:SetTexture(texture)
end

function SpecTabButton:SetValue(value)
    self.value = value
end

function SpecTabButton:GetValue()
    return self.value
end

function SpecTabButton:SetStatus(status)
    if status == 'MORE' then
        self:SetReverse(true)
        self:SetIcon([[INTERFACE\PaperDollInfoFrame\Character-Plus]])
    end
end
