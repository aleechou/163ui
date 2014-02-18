
if not IsAddOnLoaded('Bagnon') then return end

local ipairs = ipairs
local tinsert = table.insert

local tdPack = tdCore(...)
local PackButton = tdPack('PackButton')

local SIZE = 20
local NORMAL_TEXTURE_SIZE = 64 * (SIZE/36)

function PackButton:Init()
    self:SetSize(SIZE, SIZE)
    
    local nt = self:CreateTexture()
    nt:SetTexture([[Interface\Buttons\UI-Quickslot2]])
    nt:SetSize(NORMAL_TEXTURE_SIZE, NORMAL_TEXTURE_SIZE)
    nt:SetPoint('CENTER', 0, -1)
    self:SetNormalTexture(nt)

    local pt = self:CreateTexture()
    pt:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
    pt:SetAllPoints(self)
    self:SetPushedTexture(pt)

    local ht = self:CreateTexture()
    ht:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
    ht:SetAllPoints(self)
    self:SetHighlightTexture(ht)

    local icon = self:CreateTexture()
    icon:SetAllPoints(self)
    icon:SetTexture([[Interface\Icons\INV_Misc_Bag_10_Green]])
end

local orig_PlaceMenuButtons = Bagnon.Frame.PlaceMenuButtons
function Bagnon.Frame:PlaceMenuButtons()
    local width, height = orig_PlaceMenuButtons(self)
    
    local frameID = self:GetFrameID()
    if frameID == 'inventory' or frameID == 'bank' then
        local packButton = PackButton:GetPackButton(self)
        if self:HasSearchToggle() then
            tinsert(self.menuButtons, #self.menuButtons, packButton)
        else
            tinsert(self.menuButtons, packButton)
        end
        
        for i, button in ipairs(self.menuButtons) do
            button:ClearAllPoints()
            if i == 1 then
                button:SetPoint('TOPLEFT', self, 'TOPLEFT', 8, -8)
            else
                button:SetPoint('TOPLEFT', self.menuButtons[i-1], 'TOPRIGHT', 4, 0)
            end
            button:Show()
        end
        width = width + packButton:GetWidth() + 4
        height = packButton:GetHeight()
    end
    return width, height
end
