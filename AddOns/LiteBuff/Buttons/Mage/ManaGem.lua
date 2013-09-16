------------------------------------------------------------
-- ManaGem.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "MAGE" then return end

local GetItemInfo = GetItemInfo

local _, addon = ...
local L = addon.L

local button = addon:CreateActionButton("MageManaGem", L["mana gem"], nil, 120, "DUAL", "ITEM")
button:SetFlyProtect("type1", "item", "type2", "spell")
button:SetSpell(759)
button:SetAttribute("spell", button.spell)
-- button:SetItem(81901, 10, 1, 36799, 3, 1)
button:SetItem(36799, 3, 1)
button.spell2 = button.spell
button:RequireSpell(759)

-- function button:OnBagUpdate(combat)
-- 	if combat or gemName == self.itemName then
-- 		return
-- 	end

-- 	gemName = self.itemName
-- 	if gemName then
-- 		self.itemName = gemName
-- 		self:SetAttribute("item", gemName)
-- 		self.icon:SetIcon(self.itemIcon)
-- 	end
-- end

local gemName
button.itemName = false
button:HookMethod('OnBagUpdate', function()
    local self = button
    if(InCombatLockdown() or gemName == self.itemName) then
        return
    end

    local itemIcon = GetItemIcon(self.itemID)
    gemName = GetItemInfo(self.itemID)

    if(gemName) then
        self.itemName = gemName
        self:SetAttribute('item', gemName)
        self.icon:SetIcon(itemIcon)
    end
end)

function button:OnUpdateTimer()
	return self.itemCount > 0, self.itemCooldownExpires
end

local function update()
    local bigGem = false
    for slot = 1, GetNumGlyphSockets() do
        local enabled, glyphType, ttindex, spellID, icon = GetGlyphSocketInfo(slot)
        if(enabled and glyphType == GLYPH_TYPE_MAJOR and spellID == 56383) then
            bigGem = true
            break
        end
    end

    if(button.bigGem == bigGem) then return end
    button.bigGem = bigGem

    if(bigGem) then
        button:SetItem(81901, 10, 1)
    else
        button:SetItem(36799, 3, 1)
    end

    -- force update
    button.itemName = false
    gemName = nil
    pcall(function() return button:InvokeMethod'OnBagUpdate' end)
end

local _regen = 'PLAYER_REGEN_ENABLED'
local f = CreateFrame'Frame'
f:SetScript('OnEvent', function(self, event)
    if(event == _regen) then
        self:UnregisterEvent(_regen)
    end
    if(InCombatLockdown()) then
        return self:RegisterEvent(_regen)
    end
    return update()
end)

for _, e in next, {'PLAYER_LOGIN', 'GLYPH_ADDED', 'GLYPH_REMOVED', 'GLYPH_UPDATED', 'PLAYER_SPECIALIZATION_CHANGED'} do
    f:RegisterEvent(e)
end
if(IsLoggedIn()) then
    if(InCombatLockdown()) then
        f:RegisterEvent(_regen)
    else
        pcall(update)
    end
end

