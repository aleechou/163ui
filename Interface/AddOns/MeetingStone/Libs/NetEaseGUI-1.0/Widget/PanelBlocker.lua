
local WIDGET, VERSION = 'PanelBlocker', 1

local GUI = LibStub('NetEaseGUI-1.0')
local PanelBlocker = GUI:NewClass(WIDGET, 'Frame', VERSION)
if not PanelBlocker then
    return
end

function PanelBlocker:Constructor(parent)
    self:SetParent(parent)
    self:Hide()
    self:EnableMouse(true)
    self:EnableMouseWheel(true)
    self:SetScript('OnMouseWheel', nop)
    self:SetScript('OnShow', self.OnInit)
end

function PanelBlocker:OnInit()
    local bg = self:CreateTexture(nil, 'BACKGROUND') do
        bg:SetTexture([[Interface\DialogFrame\UI-DialogBox-Background-Dark]])
        bg:SetPoint('TOPLEFT')
        bg:SetPoint('BOTTOMRIGHT', 0, self.blockTabs and 35 or 0)
    end
    self:SetScript('OnShow', self.OnShow)
    self:Fire('OnInit')
    self:Fire('OnFormat')
end

function PanelBlocker:OnShow()
    self:Fire('OnFormat')
end

function PanelBlocker:SetOrder(order)
    self.order = order
end

function PanelBlocker:GetOrder()
    return self.order
end

function PanelBlocker:SetBlockTabs(blockTabs)
    self.blockTabs = blockTabs
end

function PanelBlocker:GetBlockTabs()
    return self.blockTabs
end
