------------------------------------------------------------
-- Pets.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "WARLOCK" then return end

local UnitExists = UnitExists
local IsSpellKnown = IsSpellKnown

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 688)
addon:BuildSpellList(spellList, 697)
addon:BuildSpellList(spellList, 712)
addon:BuildSpellList(spellList, 691)
addon:BuildSpellList(spellList, 30146)

local button = addon:CreateActionButton("WarlockPets", L["pets"], nil, nil, "DUAL")
button:SetFlyProtect()
button:SetScrollable(spellList, "spell1")
button:SetSpell2(755)
button:SetAttribute("spell2", button.spell2)

local petSpells = { 6307, 3716, 7814, 19505, 30151 }

function button:OnUpdateTimer()
	if UnitExists("pet") then
		local spell = petSpells[self.index]
		return spell and IsSpellKnown(spell, true)
	end
end

function button:OnSpellUpdate()
	if IsSpellKnown(30146) then
		self:SetMaxIndex()
	else
		self:SetMaxIndex(4)
	end
	self:UpdateTimer()
end