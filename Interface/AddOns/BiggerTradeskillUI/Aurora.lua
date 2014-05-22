local addonName, BTSUi = ...

-- This file contains Aurora support
if not IsAddOnLoaded("FreeUI") and not IsAddOnLoaded("Aurora") then return end


local F, C = unpack(Aurora or FreeUI)

-- Skin the controls added by BTSUi
F.ReskinCheck(_G["BTSUiHaveMatsCheck"])
F.ReskinCheck(_G["BTSUiOnlySkillupCheck"])

F.ReskinDropDown(BTSUiSubClassFilterDropDown)
F.ReskinDropDown(BTSUiSlotFilterDropDown)

-- Basically just hide all textures I added for the clean Aurora look
BTSUiVerticalBarTop:Hide()
BTSUiVerticalBarMiddle:Hide()
BTSUiVerticalBarBottom:Hide()

BTSUiTexDetailBackground:Hide()
TradeSkillDetailHeaderLeft:Hide()

-- These are the middle parts of the scrollbars
BTSUi_kjfeowjpfa:Hide()
BTSUi_afiepipnp:Hide()
BTSUiMiddle2Background:Hide()



