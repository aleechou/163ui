
local GUI = LibStub('NetEaseGUI-1.0')
local Help = GUI:NewEmbed('Help', 1)
if not Help then
    return
end
---- Help

local function HelpOnClick(self)
    if self.helpPlate and not HelpPlate_IsShowing(self.helpPlate) then
        HelpPlate_Show(self.helpPlate, self:GetParent(), self, true)
    else
        HelpPlate_Hide(true)
    end
end

local function HelpOnHide()
    HelpPlate_Hide()
end

function Help:AddHelpButton(parent, helpPlate)
    local HelpButton = CreateFrame('Button', nil, parent, 'MainHelpPlateButton')
    HelpButton:SetPoint('TOPLEFT', self, 39, 20)
    HelpButton.helpPlate = helpPlate
    HelpButton:SetScript('OnClick', HelpOnClick)
    HelpButton:SetScript('OnHide', HelpOnHide)

    self.helpButtons[parent] = HelpButton
end

function Help:HideHelpButtons()
    for _, button in pairs(self.helpButtons) do
        button:Hide()
    end
    HelpPlate_Hide()
end

function Help:ShowHelpButtons()
    for _, button in pairs(self.helpButtons) do
        button:Show()
    end
end

function Help:ShowHelpPlate(parent)
    local HelpButton = self.helpButtons[parent]
    if HelpButton then
        if not HelpPlate_IsShowing(HelpButton.helpPlate) then
            HelpPlate_Show(HelpButton.helpPlate, parent, HelpButton, true)
        end
    end
end

function Help:Embed(target)
    target.AddHelpButton = self.AddHelpButton
    target.HideHelpButtons = self.HideHelpButtons
    target.ShowHelpButtons = self.ShowHelpButtons
    target.ShowHelpPlate = self.ShowHelpPlate

    target.helpButtons = {}
end
