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

local GetItemCooldown, IsItemInRange, IsEquippedItem, GetItemIcon, GetItemCount, GetItemInfo =
	  GetItemCooldown, IsItemInRange, IsEquippedItem, GetItemIcon, GetItemCount, GetItemInfo
local pairs =
	  pairs
local OnGCD = TMW.OnGCD
local print = TMW.print
local _, pclass = UnitClass("Player")
local SpellTextures = TMW.SpellTextures

local Type = TMW.Classes.IconType:New("item")
LibStub("AceEvent-3.0"):Embed(Type)
Type.name = L["ICONMENU_ITEMCOOLDOWN"]
Type.desc = L["ICONMENU_ITEMCOOLDOWN_DESC"]
Type.menuIcon = "Interface\\Icons\\inv_jewelry_trinketpvp_01"
Type.checksItems = true

-- AUTOMATICALLY GENERATED: UsesAttributes
Type:UsesAttributes("spell")
Type:UsesAttributes("inRange")
Type:UsesAttributes("stack, stackText")
Type:UsesAttributes("start, duration")
Type:UsesAttributes("alpha")
Type:UsesAttributes("texture")
-- END AUTOMATICALLY GENERATED: UsesAttributes

Type:RegisterIconDefaults{
	OnlyEquipped			= false,
	EnableStacks			= false,
	OnlyInBags				= false,
	RangeCheck				= false,
}

Type:RegisterConfigPanel_XMLTemplate(100, "TellMeWhen_ChooseName", {
	title = L["ICONMENU_CHOOSENAME_ITEMSLOT2"],
	text = L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"],
	SUGType = "itemwithslots",
})

Type:RegisterConfigPanel_XMLTemplate(165, "TellMeWhen_WhenChecks", {
	text = L["ICONMENU_SHOWWHEN"],
	[0x2] = { text = "|cFF00FF00" .. L["ICONMENU_USABLE"], 			},
	[0x1] = { text = "|cFFFF0000" .. L["ICONMENU_UNUSABLE"], 		},
})

Type:RegisterConfigPanel_ConstructorFunc(150, "TellMeWhen_ItemSettings", function(self)
	self.Header:SetText(Type.name)
	TMW.IE:BuildSimpleCheckSettingFrame(self, {
		numPerRow = 2,
		{
			setting = "OnlyInBags",
			title = L["ICONMENU_ONLYBAGS"],
			tooltip = L["ICONMENU_ONLYBAGS_DESC"],
			disabled = function(self)
				return TMW.CI.ics.OnlyEquipped
			end,
		},
		{
			setting = "OnlyEquipped",
			title = L["ICONMENU_ONLYEQPPD"],
			tooltip = L["ICONMENU_ONLYEQPPD_DESC"],
			OnState = function(self, button)
				if self:GetChecked() then
					TMW.CI.ics.OnlyInBags = true
					self:GetParent().OnlyInBags:ReloadSetting()
				end
			end,
		},
		{
			setting = "EnableStacks",
			title = L["ICONMENU_SHOWSTACKS"],
			tooltip = L["ICONMENU_SHOWSTACKS_DESC"],
		},
		{
			setting = "RangeCheck",
			title = L["ICONMENU_RANGECHECK"],
			tooltip = L["ICONMENU_RANGECHECK_DESC"],
		},
	})
end)



local function ItemCooldown_OnEvent(icon, event, unit)
	icon.NextUpdateTime = 0
end

local function ItemCooldown_OnUpdate(icon, time)

	local n, inrange, equipped, start, duration, count = 1

	local RangeCheck, OnlyEquipped, OnlyInBags, Items =
	icon.RangeCheck, icon.OnlyEquipped, icon.OnlyInBags, icon.Items
	
	for i = 1, #Items do
		local item = Items[i]
		n = i

		start, duration = item:GetCooldown()

		if duration then
			inrange, equipped, count = 1, true, item:GetCount()
			if RangeCheck then
				inrange = item:IsInRange("target") or 1
			end

			if (OnlyEquipped and not item:GetEquipped()) or (OnlyInBags and (count == 0)) then
				equipped = false
			end
			
			if equipped and inrange == 1 and (duration == 0 or OnGCD(duration)) then --usable
				icon:SetInfo("alpha; texture; start, duration; stack, stackText; spell; inRange",
					icon.Alpha,
					item:GetIcon() or "Interface\\Icons\\INV_Misc_QuestionMark",
					start, duration,
					count, icon.EnableStacks and count,
					item:GetID(),
					inrange
				)
				return
			end
		end
	end

	local item2
	if OnlyInBags then
		for i = 1, #Items do
			local item = Items[i]
			if (OnlyEquipped and item:GetEquipped()) or (not OnlyEquipped and item:GetCount() > 0) then
				item2 = item
				break
			end
		end
		if not item2 then
			icon:SetInfo("alpha", 0)
			return
		end
	else
		item2 = Items[1]
	end

	-- if there is more than 1 spell that was checked
	-- then we need to get these again for the first spell,
	-- otherwise reuse the values obtained above since they are just for the first one

	if n > 1 then
		start, duration = item2:GetCooldown()

		inrange, count = 1, item2:GetCount()
		if RangeCheck then
			inrange = item2:IsInRange("target") or 1
		end
		isGCD = OnGCD(duration)
	end
	if duration then
		if duration == 0.001 then
			duration = 0
		end
		icon:SetInfo("alpha; texture; start, duration; stack, stackText; spell; inRange",
			icon.UnAlpha,
			item2:GetIcon(),
			start, duration,
			count, icon.EnableStacks and count,
			item2:GetID(),
			inrange
		)
	else
		icon:SetInfo("alpha", 0)
	end
end


function Type:Setup(icon, groupID, iconID)
	icon.Items = TMW:GetItems(icon, icon.Name)

	if not icon.RangeCheck then
		icon:RegisterSimpleUpdateEvent("UNIT_INVENTORY_CHANGED", "player")
		icon:RegisterSimpleUpdateEvent("PLAYER_EQUIPMENT_CHANGED")
		icon:RegisterSimpleUpdateEvent("BAG_UPDATE_COOLDOWN")
		icon:RegisterSimpleUpdateEvent("BAG_UPDATE")
		icon:SetUpdateMethod("manual")
		icon:SetScript("OnEvent", ItemCooldown_OnEvent)
	end

	if icon.OnlyEquipped then
		icon.OnlyInBags = true
	end

	icon:SetInfo("texture", Type:GetConfigIconTexture(icon))

	icon:SetUpdateFunction(ItemCooldown_OnUpdate)
	icon:Update()
end

function Type:FormatSpellForOutput(icon, data, doInsertLink)
	if data then
		local name, link = GetItemInfo(data)
		local ret
		if doInsertLink then
			ret = link
		else
			ret = name
		end
		if ret then
			return ret
		end
	end
	
	return data, true
end

function Type:GetConfigIconTexture(icon)
	if icon.Name == "" then
		return "Interface\\Icons\\INV_Misc_QuestionMark", nil
	else
		local tbl = TMW:GetItems(nil, icon.Name)

		for _, item in ipairs(tbl) do
			local t = item:GetIcon()
			if t then
				return t, true
			end
		end
		
		return "Interface\\Icons\\INV_Misc_QuestionMark", false
	end
end


Type:Register(20)