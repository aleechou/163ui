------------------------------------------------------------
-- WeaponEnchants.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L

--163uiedit
local flyoutID = 78
local spellList = {}
--163uiedit
-- addon:BuildSpellList(spellList, 8017)
-- addon:BuildSpellList(spellList, 8024)
-- addon:BuildSpellList(spellList, 8033)
-- addon:BuildSpellList(spellList, 8232)
-- addon:BuildSpellList(spellList, 51730)

local function Button_OnTooltipRightText(self, tooltip)
	tooltip:AddLine(L["right click"]..L["remove weapon enchant"], 1, 1, 1, 1)
end

local function CreateWeaponEnchantButton(slot)
	local button = addon:CreateActionButton("ShamanWeaponEnchant"..slot, L["enchants"], nil, 1800, "WEAPON_ENCHANT")
	button:SetFlyProtect("type1", "spell")
--163uiedit
	-- button:SetScrollable(spellList, "spell1")
	button:SetWeaponSlot(slot)
	button.OnTooltipRightText = Button_OnTooltipRightText
	return button
end

local button1 = CreateWeaponEnchantButton(16)
local button2 = CreateWeaponEnchantButton(17)
button2:RequireSpell(86629) -- Only enchantment shamans may dual-wield

--163uiedit
local function update()
    wipe(spellList)
    local name, desc, numSlots, isKnown = GetFlyoutInfo(flyoutID)
    if(isKnown) then
        for slot = 1, numSlots do
            local spellID, overrideSpellID, isKnown, spellName, slotSpecID = GetFlyoutSlotInfo(flyoutID, slot)
            if(isKnown) then
                addon:BuildSpellList(spellList, spellID)
            end
        end
    end

    button1:SetScrollable(spellList, 'spell1')
    button2:SetScrollable(spellList, 'spell1')
    button1:InvokeMethod'OnTalentSwitch'
    button2:InvokeMethod'OnTalentSwitch'

    if(not isKnown and button1:IsShown()) then
        button1:SetAttribute('missspell', name)
        button1:Hide()
    elseif(isKnown and not button1:IsShown()) then
        button1:SetAttribute('missspell', nil)
        button1:Show()
    end
end

addon:__163_OnSpellChanged(update)

