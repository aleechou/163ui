------------------------------------------------------------
-- BeaconOfLight.lua
--
-- Abin
-- 2011/2/05
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, addon = ...

local button = addon:CreateActionButton("PaladinBeaconOfLight", 53563, nil, nil, "GROUP_UNIQUE")
button:SetSpell(53563)
button:SetAttribute("spell", button.spell)
button:AllowSelf()
button:RequireSpell(53563)
button:SetFlyProtect()