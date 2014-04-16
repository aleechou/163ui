------------------------------------------------------------
-- Seals.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "PALADIN" then return end

local UnitGUID = UnitGUID

local _, addon = ...
local L = addon.L

local seals =  {
    20154,
    20165,
    31801,
    20164,
}

local spellList = {}

local button = addon:CreateActionButton("PaladinSeals", L["seals"], nil, nil, "STANCE")
button:SetAttribute("type", "spell")

local function update()
    wipe(spellList)
    for _, id in next, seals do
        if(IsSpellKnown(id)) then
            addon:BuildSpellList(spellList, id)
        end
    end

    button:SetScrollable(spellList)
end

addon:__163_OnSpellChanged(update)

