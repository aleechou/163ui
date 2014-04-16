﻿-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- --------------------

local TMW = TMW
if not TMW then return end
local L = TMW.L

local print = TMW.print


local Type = TMW.Classes.IconType:New("")
Type.name = L["ICONMENU_TYPE"]
Type.spaceafter = true
Type.NoColorSettings = true

-- AUTOMATICALLY GENERATED: UsesAttributes
Type:UsesAttributes("alpha")
Type:UsesAttributes("texture")
-- END AUTOMATICALLY GENERATED: UsesAttributes

Type:UsesAttributes("conditionFailed", false)

Type:SetModuleAllowance("IconModule_PowerBar_Overlay", false)
Type:SetModuleAllowance("IconModule_TimerBar_Overlay", false)
Type:SetModuleAllowance("IconModule_Texts", false)
Type:SetModuleAllowance("IconModule_CooldownSweep", false)

Type:RegisterConfigPanel_XMLTemplate(110, "TellMeWhen_DefaultInstructions")


function Type:Setup(icon, groupID, iconID)
	if icon.Name ~= "" then
		icon:SetInfo("texture", "Interface\\Icons\\INV_Misc_QuestionMark")
	else
		icon:SetInfo("texture", "")
	end
	icon:SetInfo("alpha", 0)
end

function Type:DragReceived(icon, t, data, subType)
	local ics = icon:GetSettings()

	local newType, input
	if t == "spell" then
		if data == 0 and type(param4) == "number" then
			-- I don't remember the purpose of this anymore.
			-- It handles some special sort of spell, though, and is required.
			input = GetSpellInfo(param4)
		else
			local type, baseSpellID = GetSpellBookItemInfo(data, subType)
			
			if not baseSpellID or type ~= "SPELL" then
				return
			end
			
			
			local currentSpellName = GetSpellBookItemName(data, subType)		
			local baseSpellName = GetSpellInfo(baseSpellID)
			
			input = baseSpellName or currentSpellName
		end
	
		newType = "cooldown"
	elseif t == "item" then
		input = data
		newType = "item"
	end
	if not (input and newType) then return end

	ics.Type = newType
	ics.Enabled = true
	ics.Name = TMW:CleanString(ics.Name .. ";" .. input)
	return true -- signal success
end

function Type:GetIconMenuText(ics)
	return L["NOTYPE"], ""
end

Type:Register(1)