------------------------------------------------------------
-- WaterTotems.lua
--
-- Abin
-- 2012/9/08
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 16190)
addon:BuildSpellList(spellList, 5394)

local CATEGORY = GetSpellInfo(120214)

local button = addon:CreateActionButton("ShamanWaterTotems", CATEGORY, nil, 300, "TOTEM")
button:SetScrollable(spellList, "spell1")