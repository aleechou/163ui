------------------------------------------------------------
-- ShadowProtection.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

do return end
if select(2, UnitClass("player")) ~= "PRIEST" then return end

local _, addon = ...
local L = addon.L

local button = addon:CreateActionButton("PriestShadowProtection", 27683, nil, 3600, "DUAL", "GROUP_AURA")
button:SetSpell(27683, 19891)
button:SetAttribute("spell", button.spell)
button:RequireSpell(27683)
button:SetFlyProtect()