------------------------------------------------------------
-- WindTotems.lua
--
-- Abin
-- 2012/9/08
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "SHAMAN" then return end

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 108273)
addon:BuildSpellList(spellList, 98008)
addon:BuildSpellList(spellList, 120668)
addon:BuildSpellList(spellList, 8177)
addon:BuildSpellList(spellList, 108269)

local CATEGORY = GetSpellInfo(120219)

local button = addon:CreateActionButton("ShamanWindTotems", CATEGORY, nil, 300, "TOTEM")
button:SetScrollable(spellList, "spell1")