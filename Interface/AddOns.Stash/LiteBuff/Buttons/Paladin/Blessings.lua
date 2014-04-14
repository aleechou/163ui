------------------------------------------------------------
-- Blessings.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "PALADIN" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 20217, "STATS")
addon:BuildSpellList(spellList, 19740, "MASTERY")

local button = addon:CreateActionButton("PaladinBlessings", L["blessings"], nil, 3600, "DUAL", "GROUP_AURA")
button:SetScrollable(spellList)
button:RequireSpell(20217)
button:SetFlyProtect()