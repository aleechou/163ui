------------------------------------------------------------
-- Aspects.lua
--
-- Abin
-- 2011/11/13
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "HUNTER" then return end

local IsSpellKnown = IsSpellKnown

local _, addon = ...
local L = addon.L

local spellList = {}
addon:BuildSpellList(spellList, 13165)
addon:BuildSpellList(spellList, 82661)
addon:BuildSpellList(spellList, 5118)
addon:BuildSpellList(spellList, 20043)

local aop = addon:BuildSpellList(nil, 13159)

local button = addon:CreateActionButton("HunterAspects", L["aspects"], nil, nil, "DUAL", "STANCE")
button:SetAttribute("type", "spell")
button:RequireSpell(13165)
button:SetFlyProtect("spell2", aop.spell)
button:SetScrollable(spellList, "spell1")

button.OnTooltipBottomText = nil -- Prevent "Fly protecting" text from showing up

function button:OnSpellUpdate()
	if IsSpellKnown(13159) then
		self:SetSpell2(aop)
	else
		self:SetSpell2()
	end
	self:UpdateTooltip()
end

function button:OnFlyStateChanged(flying)
	if flying then
		self.icon:SetDesaturated(false)
	end
end

local button = addon:CreateActionButton('HunterAspects2', L['aspects']..'2', nil, nil, 'DUAL', 'STANCE')
button:SetAttribute("type", "spell")
button:RequireSpell(13165)
button:SetFlyProtect('spell2', aop.spell)
button:SetScrollable(spellList, 'spell1')

button.OnTooltipBottomText = nil

function button:OnSpellUpdate()
    if(IsSpellKnown(13159)) then
        self:SetSpell2(aop)
    else
        self:SetSpell2()
    end
    self:UpdateTooltip()
end

function button:OnFlyStateChanged(flying)
    if(flying) then
        self.icon:SetDesaturated(false)
    end
end

