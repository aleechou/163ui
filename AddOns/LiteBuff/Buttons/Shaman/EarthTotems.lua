------------------------------------------------------------
-- EarthTotems.lua
--
-- Abin
-- 2012/9/08
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 2062)
addon:BuildSpellList(spellList, 8143)
addon:BuildSpellList(spellList, 2484)

local CATEGORY = GetSpellInfo(120218)

local button = addon:CreateActionButton("ShamanEarthTotems", CATEGORY, nil, 300, "TOTEM")
button:SetScrollable(spellList, "spell1")