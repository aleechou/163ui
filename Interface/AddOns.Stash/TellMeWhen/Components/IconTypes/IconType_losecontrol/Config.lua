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
local get = TMW.get

local Type = rawget(TMW.Types, "losecontrol")

if not Type then return end


Type.CONFIG = {}
local CONFIG = Type.CONFIG


-- IMPORTANT NOTE: the setting used by this icon type (LoseContolTypes) is spelled wrong.
-- I noticed too late to change it, so just make sure and continue to spell it wrong.


CONFIG.Types = {
	-- Unconfirmed:
	[LOSS_OF_CONTROL_DISPLAY_BANISH] = { -- "Banished"
		value = "BANISH",
	},
	[LOSS_OF_CONTROL_DISPLAY_CHARM] = { -- "Charmed"  
		value = "CHARM",
	},
	[LOSS_OF_CONTROL_DISPLAY_CYCLONE] = { -- "Cycloned" 
		-- I don't know if this is used at all
		value = "CYCLONE",
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
	},
	--[[[LOSS_OF_CONTROL_DISPLAY_DAZE] = { -- "Dazed"
		-- I don't think this is used at all
		value = "DAZE",
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
	},]]
	[LOSS_OF_CONTROL_DISPLAY_DISARM] = { -- "Disarmed" 
		value = "DISARM",
	},
	[LOSS_OF_CONTROL_DISPLAY_DISORIENT] = { -- "Disoriented" 
		value = "DISORIENT",
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
	},
	[LOSS_OF_CONTROL_DISPLAY_DISTRACT] = { -- "Distracted" 
		value = "DISTRACT",
	},
	[LOSS_OF_CONTROL_DISPLAY_FREEZE] = { -- "Frozen"
		value = "FREEZE",
	},
	[LOSS_OF_CONTROL_DISPLAY_HORROR] = { -- "Horrified" 
		value = "HORROR",
	},
	[LOSS_OF_CONTROL_DISPLAY_INCAPACITATE] = { -- "Incapacitated" 
		value = "INCAPACITATE",
	},
	[LOSS_OF_CONTROL_DISPLAY_INTERRUPT] = { -- "Interrupted" 
		value = "INTERRUPT",
	},
	[LOSS_OF_CONTROL_DISPLAY_INVULNERABILITY] = { -- "Invulnerable" 
		value = "INVULNERABILITY", 
	},
	[LOSS_OF_CONTROL_DISPLAY_MAGICAL_IMMUNITY] = { -- "Pacified" 
		-- text = L["LOSECONTROL_TYPE_MAGICAL_IMMUNITY"] , -- "Magical Immunity"
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
		value = "MAGICAL_IMMUNITY", 
	},
	[LOSS_OF_CONTROL_DISPLAY_PACIFY] = { -- "Pacified" 
		value = "PACIFY", 
	},
	[LOSS_OF_CONTROL_DISPLAY_PACIFYSILENCE] = { -- "Disabled" 
		value = "PACIFYSILENCE",
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
	},
	[LOSS_OF_CONTROL_DISPLAY_POLYMORPH] = { -- "Polymorphed" 
		value = "POLYMORPH",
	},
	[LOSS_OF_CONTROL_DISPLAY_POSSESS] = { -- "Possessed" 
		value = "POSSESS",
	},
	[LOSS_OF_CONTROL_DISPLAY_SAP] = { -- "Sapped" 
		value = "SAP",
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
	},
	[LOSS_OF_CONTROL_DISPLAY_SHACKLE_UNDEAD] = { -- "Shackled" 
		value = "SHACKLE_UNDEAD",
	},
	[LOSS_OF_CONTROL_DISPLAY_SLEEP] = { -- "Asleep" 
		value = "SLEEP",
	},
	--[[ [LOSS_OF_CONTROL_DISPLAY_SNARE] = { -- "Snared" 
		value = "SNARE",
		desc = L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"],
	}, ]]
	[LOSS_OF_CONTROL_DISPLAY_TURN_UNDEAD] = { -- "Feared"
		value = "TURN_UNDEAD",
	},

	-- Confirmed:
	[L["LOSECONTROL_TYPE_SCHOOLLOCK"]] = {
		-- HAS SPECIAL HANDLING (per spell school)!
		value = "SCHOOL_INTERRUPT",
	},
	[LOSS_OF_CONTROL_DISPLAY_ROOT] = { -- "Rooted
		value = "ROOT",
	},
	[LOSS_OF_CONTROL_DISPLAY_CONFUSE] = { -- "Confused"
		value = "CONFUSE",
	},
	[LOSS_OF_CONTROL_DISPLAY_STUN] = { -- "Stunned"
		value = "STUN",
	},
	[LOSS_OF_CONTROL_DISPLAY_SILENCE] = { -- "Silenced"
		value = "SILENCE",
	},
	[LOSS_OF_CONTROL_DISPLAY_FEAR] = { -- "Feared"
		value = "FEAR",
	},
}
CONFIG.TypesByValue = {}
for k, v in pairs(CONFIG.Types) do
	v.text = k
	CONFIG.TypesByValue[v.value] = v
end

CONFIG.schools = {
	[0x1 ] = "|cffFFFF00" .. SPELL_SCHOOL0_CAP,
	[0x2 ] = "|cffFFE680" .. SPELL_SCHOOL1_CAP,
	[0x4 ] = "|cffFF8000" .. SPELL_SCHOOL2_CAP, 
	[0x8 ] = "|cff4DFF4D" .. SPELL_SCHOOL3_CAP,
	[0x10] = "|cff80FFFF" .. SPELL_SCHOOL4_CAP,
	[0x20] = "|cff8080FF" .. SPELL_SCHOOL5_CAP,
	[0x40] = "|cffFF80FF" .. SPELL_SCHOOL6_CAP,
}

function CONFIG:LoadConfig()
	if TellMeWhen_LoseControlTypes then
		CONFIG:DropdownMenu_SetText()
	end
end
TMW:RegisterCallback("TMW_CONFIG_ICON_LOADED", CONFIG, "LoadConfig")

function CONFIG.DropdownMenu_OnClick_Normal(dropDownButton, LoseContolTypes)
	LoseContolTypes[dropDownButton.value] = not LoseContolTypes[dropDownButton.value]
	
	CONFIG:DropdownMenu_SetText()
end

function CONFIG.DropdownMenu_OnClick_All(dropDownButton, LoseContolTypes)
	if not LoseContolTypes[dropDownButton.value] then
		wipe(LoseContolTypes)
		LoseContolTypes = TMW:CopyTableInPlaceWithMeta(TMW.DEFAULT_ICON_SETTINGS.LoseContolTypes, LoseContolTypes)
	end
	
	LoseContolTypes[dropDownButton.value] = not LoseContolTypes[dropDownButton.value]
	
	CloseDropDownMenus()
	
	CONFIG:DropdownMenu_SetText()
end

function CONFIG.DropdownMenu_OnClick_SchoolInterrupt(dropDownButton, LoseContolTypes, schoolFlag)
	LoseContolTypes[dropDownButton.value] = bit.bxor(LoseContolTypes[dropDownButton.value], schoolFlag)
	
	CONFIG:DropdownMenu_SetText()
end

function CONFIG.DropdownMenu_SelectTypes()
	local LoseContolTypes = TMW.CI.ics.LoseContolTypes
	
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		local info = UIDropDownMenu_CreateInfo()

		info.text = L["LOSECONTROL_TYPE_ALL"]
		
		info.tooltipTitle = L["LOSECONTROL_TYPE_ALL"]
		info.tooltipText = L["LOSECONTROL_TYPE_ALL_DESC"]
		info.tooltipOnButton = true
			
		info.value = ""
		info.arg1 = LoseContolTypes
		info.keepShownOnClick = true
		
		info.checked = LoseContolTypes[info.value]
		info.func = CONFIG.DropdownMenu_OnClick_All
		
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		
		TMW.AddDropdownSpacer()
		
		for text, data in TMW:OrderedPairs(CONFIG.Types) do
			local info = UIDropDownMenu_CreateInfo()

			info.text = get(text)
			
			info.tooltipTitle = get(text)
			info.tooltipText = (TMW.debug and (data.value and data.value .. "\r\n") or "") .. (get(data.desc) or "")
			info.tooltipOnButton = true
			
			info.value = data.value
			info.arg1 = LoseContolTypes
			info.keepShownOnClick = true
			
			if data.value == "SCHOOL_INTERRUPT" then
				info.hasArrow = true
				info.notCheckable = true
			else
				info.checked = LoseContolTypes[""] or LoseContolTypes[data.value]
				info.disabled = LoseContolTypes[""]
				info.func = CONFIG.DropdownMenu_OnClick_Normal
			end
			
			UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
		end
		
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		if UIDROPDOWNMENU_MENU_VALUE == "SCHOOL_INTERRUPT" then
			for bitFlag, name in TMW:OrderedPairs(CONFIG.schools) do
				local info = UIDropDownMenu_CreateInfo()
			
				info.text = LOSS_OF_CONTROL_DISPLAY_INTERRUPT_SCHOOL:format(name .. "|r")
				
				info.value = UIDROPDOWNMENU_MENU_VALUE
				info.keepShownOnClick = true
				
				info.arg1 = LoseContolTypes
				info.arg2 = bitFlag
				info.checked = LoseContolTypes[""] or bit.band(LoseContolTypes[UIDROPDOWNMENU_MENU_VALUE], bitFlag) == bitFlag
				info.disabled = LoseContolTypes[""]
				info.func = CONFIG.DropdownMenu_OnClick_SchoolInterrupt
			
				UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL)
			end
		end
	end
end

function CONFIG:DropdownMenu_SetText()
	local LoseContolTypes = TMW.CI.ics.LoseContolTypes
	local n = 0
	if LoseContolTypes[""] then
		n = L["LOSECONTROL_TYPE_ALL"]
	else
		for k, v in pairs(LoseContolTypes) do
			if k == "SCHOOL_INTERRUPT" then
				for bitFlag in TMW:OrderedPairs(CONFIG.schools) do
					if bit.band(LoseContolTypes[k], bitFlag) == bitFlag then
						n = n + 1
					end
				end
			elseif v then
				n = n + 1
			end
		end
	end
	if n == 0 then
		n = " |cFFFF5959(0)|r |TInterface\\AddOns\\TellMeWhen\\Textures\\Alert:0:2|t"
	else
		n = " (|cff59ff59" .. n .. "|r)"
	end
	UIDropDownMenu_SetText(TellMeWhen_LoseControlTypes.LocTypes, L["LOSECONTROL_DROPDOWNLABEL"] .. n)
end


function Type:GetIconMenuText(ics)
	local text = ""
	
	if not ics.LoseContolTypes then
		return "", ""
	end
	
	if ics.LoseContolTypes[""] then
		text = L["LOSECONTROL_TYPE_ALL"]
	else
		for locType, v in pairs(ics.LoseContolTypes) do
			local data = CONFIG.TypesByValue[locType]
			if locType == "SCHOOL_INTERRUPT" then
				if v ~= 0 then
					text = text .. ", " .. data.text
				end
			elseif v and data then
				text = text .. ", " .. data.text
			end
		end
		if text ~= "" then
			text = text:sub(3)
		end
	end

	return text, text and text ~= ""  and text .. "\r\n" or ""
end

