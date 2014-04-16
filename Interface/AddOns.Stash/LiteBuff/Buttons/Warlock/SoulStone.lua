------------------------------------------------------------
-- SoulStone.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local _, addon = ...
local L = addon.L

local button = addon:CreateActionButton("WarlockSoulStone", 20707, nil, 900, "GROUP_UNIQUE")
button:SetSpell(20707)
button:SetAttribute("spell", button.spell)
button:AllowSelf()
button:RequireSpell(20707)
button:SetFlyProtect()