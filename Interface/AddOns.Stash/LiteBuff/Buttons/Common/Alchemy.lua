------------------------------------------------------------
-- Alchemy.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

local UnitStat = UnitStat
local pairs = pairs

local _, addon = ...
local L = addon.L

local flaskName = GetSpellInfo(105617)
local flaskLink = "|cff0070dd"..flaskName.."|r"

local spellList = {}
addon:BuildSpellList(spellList, 79638, 79472, 79471, 79469, 79470)
addon:BuildSpellList(spellList, 79639, 79472, 79471, 79469, 79470)
addon:BuildSpellList(spellList, 79640, 79472, 79471, 79469, 79470, 86569)


local button = addon:CreateActionButton("AlchemyFlask", L["alchemy flask"], nil, 7200, "PLAYER_AURA")
button:RequireItem(75525)
button:SetFlyProtect("type", "item")
button:SetAttribute("item", flaskName)

function button:OnTooltipTitle(tooltip)
	tooltip:AddLine(flaskLink)
end

function button:OnTooltipText(tooltip, spell)
	tooltip:AddLine(L["effect"]..spell, 1, 1, 1, 1)
end

function button:OnTooltipLeftText(tooltip)
	tooltip:AddLine(L["left click"]..L["drink"]..flaskLink, 1, 1, 1, 1)
end

function button:OnUpdateTimer(spell)
	local conflict
	local expires = addon:GetUnitBuffTimer("player", spell)
	if not expires and self.conflicts then
		local other, icon
		for other, icon in pairs(self.conflicts) do
			expires = addon:GetUnitBuffTimer("player", other)
			if expires then
				conflict = icon
				break
			end
		end
	end

	self:SetConflictIcon(conflict)
	return expires or conflict, expires
end

function button:OnStatsUpdate()
	local index = 1
	local str = UnitStat("player", 1) or 0
	local agi = UnitStat("player", 2) or 0
	local int = UnitStat("player", 4) or 0
	if str > agi and str > int then
		index = 1
	elseif agi > str and agi > int then
		index = 2
	elseif int > str and int > agi then
		index = 3
	end

	self:SetSpell(spellList[index])
	self:UpdateTimer()
end