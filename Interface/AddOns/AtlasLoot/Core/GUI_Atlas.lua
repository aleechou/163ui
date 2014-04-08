-- $Id: GUI_Atlas.lua 4201 2013-05-05 16:05:37Z lag123 $
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

function AtlasLoot:CreateAtlasInfoFrame()
	if AtlasLoot.AtlasInfoFrame then return end
	AtlasLoot.AtlasInfoFrame = CreateFrame("Frame","AtlasLootInfo2")

	local Frame = AtlasLoot.AtlasInfoFrame
	Frame:ClearAllPoints()

    Frame:SetParent(UIParent);
    Frame:SetPoint("TOPLEFT", "UIParent", "TOPLEFT", 535, -37);
	Frame:SetFrameStrata("HIGH")
	Frame:SetWidth(190)
	Frame:SetHeight(75)

	Frame.Version = Frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	Frame.Version:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, 0)
	Frame.Version:SetText(ATLASLOOT_VERSION);
	Frame.Version:SetWidth(Frame.Version:GetStringWidth() < 180 and Frame.Version:GetStringWidth()+5 or 180)
	Frame.Version:SetHeight(10)

	Frame.Info = Frame:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
	Frame.Info:SetPoint("TOPLEFT", Frame.Version, "TOPLEFT", 0, -12)
	Frame.Info:SetText(AL["Click boss name to view loot."])
	Frame.Info:SetWidth(Frame.Info:GetStringWidth() < 180 and Frame.Info:GetStringWidth()+5 or 180)
	Frame.Info:SetHeight(10)

	Frame.Button = CreateFrame("Button","AtlasLoot_AtlasInfoFrame_ToggleALButton",Frame,"UIPanelButtonTemplate")
	Frame.Button:SetText(AL["Toggle AL Panel"])
	Frame.Button:SetWidth(Frame.Button:GetTextWidth() + 30)
	Frame.Button:SetHeight(20)
	Frame.Button:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -24)
	Frame.Button:SetScript("OnClick", AtlasLoot.OptionsHidePanel)
	
	Frame:Hide()
end