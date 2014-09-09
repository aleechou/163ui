
if not IsAddOnLoaded('Combuctor') then return end

local tdPack = tdCore(...)
local L = tdPack:GetLocale()
local InventoryFrame = Combuctor.Frame

local function OnEnter(self)
    if not Combuctor.TogglePlayerDropdown then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetText(self:GetParent():GetPlayer(), 1, 1, 1)
    end
    GameTooltip:AddLine(L['<Right Click> '] .. L['Pack bags'])
    GameTooltip:AddLine(L['<Alt-Right> '] .. L['Show pack menu'])
    GameTooltip:Show()
end

local orig_InventoryFrame_New = InventoryFrame.New

local function OnClick(self, button)
    if button == 'LeftButton' then
        if Combuctor.TogglePlayerDropdown then
            Combuctor:TogglePlayerDropdown(self, self:GetParent(), 15, 10)
        end
    elseif button == 'RightButton' then
        if IsAltKeyDown() then
            tdCore('GUI'):ToggleMenu(self, 'ComboMenu', tdPack.PackMenu)
        else
            tdPack:Pack()
        end
    end
end

function InventoryFrame:New(...)
    local f = orig_InventoryFrame_New(self, ...)
    
    local btn = _G[f:GetName()..'IconButton']
    
    btn:SetScript('OnClick', OnClick)
    btn:HookScript('OnEnter', OnEnter)
    
    return f
end
