------------------------------------------------------------
-- Armors.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 7302)
addon:BuildSpellList(spellList, 6117)
addon:BuildSpellList(spellList, 30482)

local button = addon:CreateActionButton("MageArmors", L["armor spells"], nil, nil, "PLAYER_AURA")
button:SetFlyProtect()
button:SetScrollable(spellList)
button:RequireSpell(7302)