------------------------------------------------------------
-- FireTotems.lua
--
-- Abin
-- 2012/9/08
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 3599)
addon:BuildSpellList(spellList, 8190)
addon:BuildSpellList(spellList, 2894)

local CATEGORY = GetSpellInfo(120217)

local button = addon:CreateActionButton("ShamanFireTotems", CATEGORY, nil, 300, "TOTEM")
button:SetScrollable(spellList, "spell1")




