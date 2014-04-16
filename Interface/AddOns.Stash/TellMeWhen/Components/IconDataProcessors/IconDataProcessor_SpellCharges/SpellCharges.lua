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

local format = format
local isNumber = TMW.isNumber

local Processor = TMW.Classes.IconDataProcessor:New("SPELLCHARGES", "charges, maxCharges")

function Processor:CompileFunctionSegment(t)
	-- GLOBALS: charges, maxCharges
	t[#t+1] = [[
	
	if attributes.charges ~= charges or attributes.maxCharges ~= maxCharges then

		attributes.charges = charges
		attributes.maxCharges = maxCharges
		
		TMW:Fire(SPELLCHARGES.changedEvent, icon, charges, maxCharges)
		doFireIconUpdated = true
	end
	--]]
end

TMW:RegisterCallback("TMW_ICON_TYPE_CHANGED", function(event, icon, typeData, oldTypeData)
	icon:SetInfo("charges, maxCharges", nil, nil)
end)
