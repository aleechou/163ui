------------------------------------------------------------
-- Ghoul.lua
--
-- Abin
-- 2012/1/25
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "DEATHKNIGHT" then return end

local UnitExists = UnitExists

local _, addon = ...
local L = addon.L

local button = addon:CreateActionButton("DeathKnightGhoul", L["pets"], nil, nil, "DUAL")
button:SetSpell(46584)
button:SetAttribute("spell1", button.spell)
button:SetSpell2(47632)
button:SetAttribute("spell2", button.spell2)
button:SetAttribute("unit2", "pet")
button:RequireSpell(52143)
button:SetFlyProtect()

function button:OnUpdateTimer()
	return UnitExists("pet")
end