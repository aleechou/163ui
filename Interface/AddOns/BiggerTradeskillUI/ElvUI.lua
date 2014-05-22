local addonName, BTSUi = ...

-- This file contains ElvUI support
if not IsAddOnLoaded("ElvUI") then return end

local E = _G["ElvUI"][1]
local S = E:GetModule('Skins')

-- I think this means the user wants to use the normal Blizzard skin
if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.tradeskill ~= true then return end

BTSUiHaveMatsCheckText:GetPoint(0) 
-- Skin the controls added by BTSUi
S:HandleCheckBox(BTSUiHaveMatsCheck, true)
BTSUiHaveMatsCheckText:SetPoint("LEFT", BTSUiHaveMatsCheck, "RIGHT", 3, 0) 
S:HandleCheckBox(BTSUiOnlySkillupCheck, true)
BTSUiOnlySkillupCheckText:SetPoint("LEFT", BTSUiOnlySkillupCheck, "RIGHT", 3, 0) 

S:HandleDropDownBox(BTSUiSubClassFilterDropDown, 155)
S:HandleDropDownBox(BTSUiSlotFilterDropDown, 155)

-- Basically just hide all textures I added for the clean ElvUI look
BTSUiVerticalBarTop:Hide()
BTSUiVerticalBarMiddle:Hide()
BTSUiVerticalBarBottom:Hide()

BTSUiTexDetailBackground:Hide()
TradeSkillDetailHeaderLeft:Hide()

-- These are the middle parts of the scrollbars
BTSUi_kjfeowjpfa:Hide()
BTSUi_afiepipnp:Hide()
BTSUiMiddle2Background:Hide()



