
local function CheckSound(self)
	local sound = self:GetChecked() and 'On' or 'Off'
	PlaySound('igMainMenuOptionCheckBox'.. sound)
end


-- Creates a checkbox.
-- All args optional but parent is highly recommended
local function NewCheckBox(parent, size, ...)
	local check = CreateFrame("CheckButton", nil, parent)
	check:SetWidth(size or 26)
	check:SetHeight(size or 26)
	if select(1, ...) then check:SetPoint(...) end

	check:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
	check:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
	check:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	check:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
	check:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")

	check:SetScript("PreClick", CheckSound)

	return check
end

local aceEvent = LibStub'AceEvent-3.0'

local GameTooltip = GameTooltip

local L = {
	helmtip = "Toggles helmet model.",
	cloaktip = "Toggles cloak model.",
}


local hcheck = NewCheckBox(PaperDollFrame, 22,
                              "TOPLEFT", CharacterHeadSlot, "BOTTOMRIGHT", 5, 5)
hcheck:SetScript("OnClick", function() ShowHelm(not ShowingHelm()) end)
-- hcheck:SetScript("OnEnter", function(self)
--  	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
-- 	GameTooltip:SetText(L.helmtip)
-- end)
-- hcheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
hcheck:RegisterEvent("UNIT_MODEL_CHANGED")
hcheck:SetToplevel(true)


local ccheck = NewCheckBox(PaperDollFrame, 22,
                              "TOPLEFT", CharacterBackSlot, "BOTTOMRIGHT", 5, 5)
ccheck:SetScript("OnClick", function() ShowCloak(not ShowingCloak()) end)
-- ccheck:SetScript("OnEnter", function(self)
-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
-- 	GameTooltip:SetText(L.cloaktip)
-- end)
-- ccheck:SetScript("OnLeave", function() GameTooltip:Hide() end)
ccheck:RegisterEvent("UNIT_MODEL_CHANGED")
ccheck:SetToplevel(true)


local function OnLoad()
	hcheck:SetChecked(ShowingHelm())
	ccheck:SetChecked(ShowingCloak())
end

aceEvent:RegisterEvent("UNIT_MODEL_CHANGED", OnLoad)
aceEvent:RegisterEvent("PLAYER_LOGIN", OnLoad)


-- Honestly not sure why this fixes it on the initial load, but whatever
hcheck:SetFrameLevel(31)
ccheck:SetFrameLevel(31)
