------------------------------------------------------------
-- OptionFrame.lua
--
-- Abin
-- 2013/7/10
------------------------------------------------------------

local module = CompactRaid:FindModule("Direction")
if not module then return end

local L = CompactRaid:GetLocale("Direction")
local CL = CompactRaid.L

local frame = module.optionPage

local group = frame:CreateMultiSelectionGroup(L["general options"])
frame:AnchorToTopLeft(group, 0, -6)
group:AddButton(L["target only"], "targetonly")

function group:OnCheckInit(value)
	return module.db[value]
end

function group:OnCheckChanged(value, checked)
	module.db[value] = checked
end

local scaleSlider = frame:CreateSmallSlider(L["scale"], 50, 200, 5, "%d%%")
scaleSlider:SetPoint("TOPLEFT", group[1], "BOTTOMLEFT", 8, -32)

function scaleSlider:OnSliderInit()
	return module.db.scale
end

function scaleSlider:OnSliderChanged(value)
	module.db.scale = value
	module:EnumVisuals("SetScale", value / 100)
end

local XOffSlider = frame:CreateSmallSlider(L["x-offset"], -30, 30)
XOffSlider:SetPoint("TOPLEFT", scaleSlider, "BOTTOMLEFT", 0, -40)

function XOffSlider:OnSliderInit()
	return module.db.xoffset
end

function XOffSlider:OnSliderChanged(value)
	module.db.xoffset = value
	module:EnumVisuals("ClearAllPoints")
	module:EnumVisuals("SetPoint", "CENTER", value, module.db.yoffset)
end

local YOffSlider = frame:CreateSmallSlider(L["y-offset"], -30, 30)
YOffSlider:SetPoint("LEFT", XOffSlider, "RIGHT", 20, 0)

function YOffSlider:OnSliderInit()
	return module.db.yoffset
end

function YOffSlider:OnSliderChanged(value)
	module.db.yoffset = value
	module:EnumVisuals("ClearAllPoints")
	module:EnumVisuals("SetPoint", "CENTER", module.db.xoffset, value)
end