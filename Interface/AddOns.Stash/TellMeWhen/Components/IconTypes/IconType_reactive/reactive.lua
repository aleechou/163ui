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

local GetSpellCooldown, IsUsableSpell, GetSpellInfo, GetSpellCharges, GetSpellCount =
	  GetSpellCooldown, IsUsableSpell, GetSpellInfo, GetSpellCharges, GetSpellCount
local SpellHasNoMana = TMW.SpellHasNoMana
local OnGCD = TMW.OnGCD
local print = TMW.print
local isString = TMW.isString
local _, pclass = UnitClass("player")
local SpellTextures = TMW.SpellTextures
local strlowerCache = TMW.strlowerCache
local mindfreeze = strlower(GetSpellInfo(47528))

local IsSpellInRange = LibStub("SpellRange-1.0").IsSpellInRange

local Type = TMW.Classes.IconType:New("reactive")
Type.name = L["ICONMENU_REACTIVE"]
Type.desc = L["ICONMENU_REACTIVE_DESC"]
Type.menuIcon = "Interface\\Icons\\ability_warrior_revenge"

-- AUTOMATICALLY GENERATED: UsesAttributes
Type:UsesAttributes("noMana")
Type:UsesAttributes("spell")
Type:UsesAttributes("charges, maxCharges")
Type:UsesAttributes("inRange")
Type:UsesAttributes("stack, stackText")
Type:UsesAttributes("start, duration")
Type:UsesAttributes("alpha")
Type:UsesAttributes("texture")
-- END AUTOMATICALLY GENERATED: UsesAttributes

Type:SetModuleAllowance("IconModule_PowerBar_Overlay", true)

Type:RegisterIconDefaults{
	UseActvtnOverlay		= false,
	CooldownCheck			= false,
	IgnoreNomana			= false,
	RangeCheck				= false,
	ManaCheck				= false,
	IgnoreRunes				= false,
}

Type:RegisterConfigPanel_XMLTemplate(100, "TellMeWhen_ChooseName", {
	text = L["CHOOSENAME_DIALOG"] .. "\r\n\r\n" .. L["CHOOSENAME_DIALOG_PETABILITIES"],
})

Type:RegisterConfigPanel_XMLTemplate(165, "TellMeWhen_WhenChecks", {
	text = L["ICONMENU_SHOWWHEN"],
	[0x2] = { text = "|cFF00FF00" .. L["ICONMENU_USABLE"], 			},
	[0x1] = { text = "|cFFFF0000" .. L["ICONMENU_UNUSABLE"], 		},
})

Type:RegisterConfigPanel_ConstructorFunc(150, "TellMeWhen_ReactiveSettings", function(self)
	self.Header:SetText(Type.name)
	TMW.IE:BuildSimpleCheckSettingFrame(self, {
		{
			setting = "UseActvtnOverlay",
			title = L["ICONMENU_USEACTIVATIONOVERLAY"],
			tooltip = L["ICONMENU_USEACTIVATIONOVERLAY_DESC"],
		},
		{
			setting = "IgnoreNomana",
			title = L["ICONMENU_IGNORENOMANA"],
			tooltip = L["ICONMENU_IGNORENOMANA_DESC"],
		},
		{
			setting = "CooldownCheck",
			title = L["ICONMENU_COOLDOWNCHECK"],
			tooltip = L["ICONMENU_COOLDOWNCHECK_DESC"],
		},
		{
			setting = "RangeCheck",
			title = L["ICONMENU_RANGECHECK"],
			tooltip = L["ICONMENU_RANGECHECK_DESC"],
		},
		{
			setting = "ManaCheck",
			title = L["ICONMENU_MANACHECK"],
			tooltip = L["ICONMENU_MANACHECK_DESC"],
		},
		pclass == "DEATHKNIGHT" and {
			setting = "IgnoreRunes",
			title = L["ICONMENU_IGNORERUNES"],
			tooltip = L["ICONMENU_IGNORERUNES_DESC"],
			disabledtooltip = L["ICONMENU_IGNORERUNES_DESC_DISABLED"],
			disabled = function(self)
				return not TMW.CI.ics.CooldownCheck
			end,
		},
	})
end)


local function Reactive_OnEvent(icon, event, arg1)
	if event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" or event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then
		if icon.NameFirst == arg1 or strlowerCache[GetSpellInfo(arg1)] == icon.NameName then
			icon.forceUsable = event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"
			icon.NextUpdateTime = 0
		end
	elseif event ~= "UNIT_POWER_FREQUENT" or arg1 == "player" then
		icon.NextUpdateTime = 0
	end
end

local function Reactive_OnUpdate(icon, time)

	local n, inrange, nomana, start, duration, CD, usable, charges, maxCharges, stack, start_charge, duration_charge = 1
	local NameArray, NameNameArray, RangeCheck, ManaCheck, CooldownCheck, IgnoreRunes, forceUsable, IgnoreNomana =
	 icon.NameArray, icon.NameNameArray, icon.RangeCheck, icon.ManaCheck, icon.CooldownCheck, icon.IgnoreRunes, icon.forceUsable, icon.IgnoreNomana

	for i = 1, #NameArray do
		local iName = NameArray[i]
		n = i
		
		charges, maxCharges, start_charge, duration_charge = GetSpellCharges(iName)
		if charges then
			if charges < maxCharges then
				start, duration = start_charge, duration_charge
			else
				start, duration = GetSpellCooldown(iName)
			end
			stack = charges
		else
			start, duration = GetSpellCooldown(iName)
			stack = GetSpellCount(iName)
		end
		
		if duration then
			inrange, CD = 1
			if RangeCheck then
				inrange = IsSpellInRange(iName, "target") or 1
			end
			usable, nomana = IsUsableSpell(iName)
			if IgnoreNomana then
				usable = usable or nomana
			end
			if not ManaCheck then
				nomana = nil
			end
			if CooldownCheck then
				if IgnoreRunes and duration == 10 and NameNameArray[i] ~= mindfreeze then
					start, duration = 0, 0
				end
				CD = not (duration == 0 or OnGCD(duration))
			end
			usable = forceUsable or usable
			if usable and not CD and not nomana and inrange == 1 then --usable
				icon:SetInfo("alpha; texture; start, duration; charges, maxCharges; stack, stackText; spell; inRange; noMana",
					icon.Alpha,
					SpellTextures[iName],
					start, duration,
					charges, maxCharges,
					stack, stack,
					iName,
					inrange,
					nomana			
				)
				return
			end
		end
	end

	local NameFirst = icon.NameFirst
	if n > 1 then -- if more than 1 spell was checked, we need to get these again for the first spell, otherwise reuse the values obtained above since they are just for the first one
		
		charges, maxCharges, start_charge, duration_charge = GetSpellCharges(NameFirst)
		if charges then
			if charges < maxCharges then
				start, duration = start_charge, duration_charge
			else
				start, duration = GetSpellCooldown(NameFirst)
			end
			stack = charges
		else
			start, duration = GetSpellCooldown(NameFirst)
			stack = GetSpellCount(NameFirst)
		end
		
		if IgnoreRunes and duration == 10 and icon.NameName ~= mindfreeze then
			start, duration = 0, 0
		end
		inrange, nomana = 1
		if RangeCheck then
			inrange = IsSpellInRange(NameFirst, "target") or 1
		end
		if ManaCheck then
			nomana = SpellHasNoMana(NameFirst)
		end
	end
	
	if duration then
		icon:SetInfo("alpha; texture; start, duration; charges, maxCharges; stack, stackText; spell; inRange; noMana",
			icon.UnAlpha,
			icon.FirstTexture,
			start, duration,
			charges, maxCharges,
			stack, stack,
			NameFirst,
			inrange,
			nomana
		)
	else
		icon:SetInfo("alpha", 0)
	end
end


function Type:Setup(icon, groupID, iconID)
	icon.NameFirst = TMW:GetSpellNames(icon, icon.Name, 1, nil, nil, nil, 1)
	icon.NameName = TMW:GetSpellNames(icon, icon.Name, 1, 1, nil, nil, 1)
	icon.NameArray = TMW:GetSpellNames(icon, icon.Name, nil, nil, nil, nil, 1)
	icon.NameNameArray = TMW:GetSpellNames(icon, icon.Name, nil, 1, nil, nil, 1)
	icon.forceUsable = nil

	icon.FirstTexture = SpellTextures[icon.NameFirst]

	icon:SetInfo("texture", Type:GetConfigIconTexture(icon))
	
	if pclass ~= "DEATHKNIGHT" then
		icon.IgnoreRunes =  nil
	end
	
	if icon.UseActvtnOverlay then
		icon:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_SHOW")
		icon:RegisterEvent("SPELL_ACTIVATION_OVERLAY_GLOW_HIDE")
		icon:SetScript("OnEvent", Reactive_OnEvent)
	end
	
	if not icon.RangeCheck then
		icon:RegisterSimpleUpdateEvent("SPELL_UPDATE_COOLDOWN")
		icon:RegisterSimpleUpdateEvent("SPELL_UPDATE_USABLE")
		icon:RegisterSimpleUpdateEvent("SPELL_UPDATE_CHARGES")
		if icon.IgnoreRunes then
			icon:RegisterSimpleUpdateEvent("RUNE_POWER_UPDATE")
			icon:RegisterSimpleUpdateEvent("RUNE_TYPE_UPDATE")
		end	
		if icon.ManaCheck then
			icon:RegisterSimpleUpdateEvent("UNIT_POWER_FREQUENT", "player")
			-- icon:RegisterSimpleUpdateEvent("SPELL_UPDATE_USABLE") -- already registered
		end
	
		icon:SetUpdateMethod("manual")
	end
	
	icon:SetUpdateFunction(Reactive_OnUpdate)
	icon:Update()
end

Type:Register(70)
