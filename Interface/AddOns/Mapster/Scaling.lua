--[[
Copyright (c) 2009-2014, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.

Initial implementation provided by yssaril
]]

local Mapster = LibStub("AceAddon-3.0"):GetAddon("Mapster")

local MODNAME= "Scale"
local Scale = Mapster:NewModule(MODNAME)

local LibWindow = LibStub("LibWindow-1.1")

local scaler, mousetracker
local SOS = { --Scaler Original State
	dist = 0,
	x = 0,
	y = 0,
	left = 0,
	top = 0,
	scale = 1,
}

local GetScaleDistance, OnUpdate

function Scale:OnInitialize()
	self:SetEnabledState(Mapster:GetModuleEnabled(MODNAME))
end

function Scale:OnEnable()
	if not scaler then
		scaler = CreateFrame("Frame", "MapsterScaler", WorldMapFrame.UIElementsFrame)
		scaler:SetWidth(15)
		scaler:SetHeight(15)
		scaler:SetFrameStrata("HIGH")
		scaler:SetFrameLevel(WorldMapFrame.UIElementsFrame:GetFrameLevel() + 15)
		scaler.tex = WorldMapFrame.UIElementsFrame:CreateTexture("MapsterScalerTex", "OVERLAY")
		scaler.tex:SetAllPoints(scaler)
		scaler.tex:SetTexture([[Interface\Buttons\UI-AutoCastableOverlay]])
		scaler.tex:SetTexCoord(0.619, 0.760, 0.612, 0.762)
		scaler.tex:SetDesaturated(true)

		scaler:SetPoint("BOTTOMRIGHT", WorldMapFrame, "BOTTOMRIGHT", 0, -2)

		mousetracker = CreateFrame("Frame", nil, WorldMapFrame.UIElementsFrame)
		mousetracker:SetFrameLevel(WorldMapFrame.UIElementsFrame:GetFrameLevel() + 20)
		mousetracker:SetAllPoints(scaler)
		mousetracker:EnableMouse(true)
		mousetracker:SetScript("OnEnter", function()
			scaler.tex:SetDesaturated(false)
		end)
		mousetracker:SetScript("OnLeave", function()
			scaler.tex:SetDesaturated(true)
		end)
		mousetracker:SetScript("OnMouseUp", function(self)
			LibWindow.SavePosition(WorldMapFrame)
			self:SetScript("OnUpdate", nil)
			self:SetAllPoints(scaler)

			WorldMapBlobFrame_ResetHitTranslations()
		end)
		mousetracker:SetScript("OnMouseDown",function(self)
			SOS.left, SOS.top = WorldMapFrame:GetLeft(), WorldMapFrame:GetTop()
			SOS.scale = WorldMapFrame:GetScale()
			SOS.x, SOS.y = SOS.left, SOS.top-(UIParent:GetHeight()/SOS.scale)
			SOS.EFscale = WorldMapFrame:GetEffectiveScale()
			SOS.dist = GetScaleDistance()
			self:SetScript("OnUpdate", OnUpdate)
			self:SetAllPoints(UIParent)
		end)
		tinsert(Mapster.elementsToHide, scaler)
	end
	scaler:Show()
	mousetracker:Show()
end

function Scale:OnDisable()
	if scaler then
		scaler:Hide()
		mousetracker:Hide()
	end
end

function GetScaleDistance() -- distance from cursor to TopLeft :)
	local left, top = SOS.left, SOS.top
	local scale = SOS.EFscale

	local x, y = GetCursorPosition()
	local x = x/scale - left
	local y = top - y/scale

	return sqrt(x*x+y*y)
end

function OnUpdate(self)
	local scale = GetScaleDistance()/SOS.dist*SOS.scale
	if scale < .2 then -- clamp min and max scale
		scale = .2
	elseif scale > 1.5 then 
		scale = 1.5
	end
	WorldMapFrame:SetScale(scale)

	if HelpPlate.__Mapster then
		HelpPlate:SetScale(scale)
	end

	local s = SOS.scale/WorldMapFrame:GetScale()
	local x = SOS.x*s
	local y = SOS.y*s
	WorldMapFrame:ClearAllPoints()
	WorldMapFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x, y)

	-- after scale changes, the blobs need re-drawing
	WorldMapBlobFrame_UpdateBlobs()
end
