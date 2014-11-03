------------------------------------------------------------
-- Stances.lua
--
-- Abin
-- 2012/10/02
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "MONK" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 103985)
addon:BuildSpellList(spellList, 115069)
addon:BuildSpellList(spellList, 115070)

local button = addon:CreateActionButton("MonkStances", L["stances"], nil, nil, "STANCE")
button:SetAttribute("type", "spell")
button:SetScrollable(spellList)