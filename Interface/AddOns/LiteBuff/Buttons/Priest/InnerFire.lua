------------------------------------------------------------
-- InnerFire.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "PRIEST" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 588)
addon:BuildSpellList(spellList, 73413)

local button = addon:CreateActionButton("PriestInnerFire", 588, nil, nil, "PLAYER_AURA")
button:SetFlyProtect()
button:SetScrollable(spellList)
button:RequireSpell(588)