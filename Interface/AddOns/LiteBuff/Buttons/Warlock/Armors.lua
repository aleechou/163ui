------------------------------------------------------------
-- Armors.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 28176)
addon:BuildSpellList(spellList, 687)

local button = addon:CreateActionButton("WarlockArmors", L["armor spells"], nil, nil, "PLAYER_AURA")
button:SetFlyProtect()
button:SetScrollable(spellList)
button:RequireSpell(687)