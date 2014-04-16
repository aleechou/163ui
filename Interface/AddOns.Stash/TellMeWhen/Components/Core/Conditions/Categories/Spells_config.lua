﻿-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- --------------------


if not TMW then return end

local TMW = TMW
local L = TMW.L
local print = TMW.print

local SUG = TMW.SUG

local Module_spell = SUG:GetModule("spell")
local Module = SUG:NewModule("spellWithGCD", Module_spell)
function Module:Table_GetSpecialSuggestions(suggestions)
	local atBeginning = SUG.atBeginning
	local lastName = SUG.lastName


	if strfind("gcd", atBeginning) or strfind(L["GCD"]:lower(), atBeginning) then
		suggestions[#suggestions + 1] = "GCD"
	end
end
function Module:Entry_AddToList_2(f, id)
	if id == "GCD" then
		local spellID = TMW.GCDSpell

		local name = GetSpellInfo(spellID)

		f.Name:SetText(L["GCD"])
		f.ID:SetText(nil)

		f.tooltipmethod = "SetSpellByID"
		f.tooltiparg = spellID

		f.insert = "GCD"

		f.Icon:SetTexture(TMW.SpellTextures[spellID])
	end
end
function Module:Entry_Colorize_2(f, id)
	if id == "GCD" then
		f.Background:SetVertexColor(.58, .51, .79, 1) -- color item slots warlock purple
	end
end
function Module.Sorter_Spells(a, b)
	if a == "GCD" or b == "GCD" then
		return a == "GCD"
	end

	return Module_spell.Sorter_Spells(a, b)
end