------------------------------------------------------------
-- Shields.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 324)
addon:BuildSpellList(spellList, 52127)

local button = addon:CreateActionButton("ShamanShields", L["shields"], nil, 600, "PLAYER_AURA")
button:SetFlyProtect()
button:SetScrollable(spellList)
button:RequireSpell(324)
