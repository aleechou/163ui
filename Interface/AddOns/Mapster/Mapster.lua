--[[
Copyright (c) 2009-2014, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local Mapster = LibStub("AceAddon-3.0"):NewAddon("Mapster", "AceEvent-3.0", "AceHook-3.0")

local LibWindow = LibStub("LibWindow-1.1")
local L = LibStub("AceLocale-3.0"):GetLocale("Mapster")

local defaults = {
	profile = {
		hideMapButton = false,
		arrowScale = 0.9,
		modules = {
			['*'] = true,
		},
		x = 0,
		y = 0,
		point = "CENTER",
		scale = 1,
		poiScale = 0.9,
		ejScale = 0.8,
		alpha = 1,
		hideBorder = false,
		disableMouse = false,
		miniMap = false,
		mini = {
			x = 230,
			y = -165,
			point = "TOPLEFT",
			scale = 0.7,
			alpha = 0.9,
			hideBorder = true,
			disableMouse = true,
		}
	}
}

-- Variables that are changed on "mini" mode
local miniList = { x = true, y = true, point = true, scale = true, alpha = true, hideBorder = true, disableMouse = true }

local db_
local db = setmetatable({}, {
	__index = function(t, k)
		if Mapster.miniMap and miniList[k] then
			return db_.mini[k]
		else
			return db_[k]
		end
	end,
	__newindex = function(t, k, v)
		if Mapster.miniMap and miniList[k] then
			db_.mini[k] = v
		else
			db_[k] = v
		end
	end
})

local format = string.format

local wmfOnShow, wmfStartMoving, wmfStopMoving, dropdownScaleFix, WorldMapFrameGetAlpha

function Mapster:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("MapsterDB", defaults, true)
	db_ = self.db.profile

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	self.elementsToHide = {}

	self.UIHider = CreateFrame("Frame")
	self.UIHider:Hide()

	self:SetupOptions()
end

local realZone
function Mapster:OnEnable()
	SetCVar("miniWorldMap", 1)

	-- force map into window mode
	if not WorldMapFrame_InWindowedMode() then
		WorldMap_ToggleSizeDown()
	end

	-- ensure the map remains movable
	SetCVar("lockedWorldMap", 0);
	WORLDMAP_SETTINGS.locked = false

	self:SetupMapButton()

	LibWindow.RegisterConfig(WorldMapFrame, db)

	-- remove from UI panel system
	UIPanelWindows["WorldMapFrame"] = nil
	WorldMapFrame:SetAttribute("UIPanelLayout-area", nil)
	WorldMapFrame:SetAttribute("UIPanelLayout-enabled", false)
	WorldMapFrame:HookScript("OnShow", wmfOnShow)
	BlackoutWorld:Hide()

	--WorldMapFrame:SetScript("OnKeyDown", nil)

	WorldMapFrame:SetMovable(true)
	WorldMapFrame:RegisterForDrag("LeftButton")
	WorldMapFrame:SetScript("OnDragStart", wmfStartMoving)
	WorldMapFrame:SetScript("OnDragStop", wmfStopMoving)

	WorldMapTitleButton:Hide()
	WorldMapTitleButton:SetParent(self.UIHider)

	WorldMapFrame:SetParent(UIParent)
	WorldMapFrame:SetToplevel(true)
	WorldMapFrame:SetClampedToScreen(false)

	self:SecureHook("NavBar_ToggleMenu")

	WorldMapFrameSizeDownButton:SetScript("OnClick", function() Mapster:ToggleMapSize() end)
	WorldMapFrameSizeUpButton:SetScript("OnClick", function() Mapster:ToggleMapSize() end)
	self:RawHook("WorldMapFrame_ToggleWindowSize", "ToggleMapSize", true)

	WorldMapFrame.GetAlphaMapster = WorldMapFrame.GetAlpha
	WorldMapFrame.GetAlpha = WorldMapFrameGetAlpha

	tinsert(UISpecialFrames, "WorldMapFrame")

	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")

	if db.miniMap then
		self:SizeDown()
	else
		WorldMapFrameSizeUpButton:Hide()
		WorldMapFrameSizeDownButton:Show()
	end
	self.miniMap = db.miniMap
	self.bordersVisible = true

	self:SetPosition()
	self:SetAlpha()
	self:SetArrow()
	self:SetScale()
	self:UpdateBorderVisibility()
	self:UpdateMouseInteractivity()

	-- hook to overwrite scale to include our custom scale
	self:SecureHook("WorldMapBlobFrame_CalculateHitTranslations")
	self:SecureHook("WorldMap_CreateTaskPOI")

	self:SecureHook("WorldMapPOIFrame_AnchorPOI")

	for i = 1, NUM_WORLDMAP_TASK_POIS do
		self:WorldMap_CreateTaskPOI(i)
	end

	self:SecureHook("EncounterJournal_AddMapButtons")

	self:RawHook(WorldMapPlayerLower, "SetPoint", "WorldMapPlayerSetPoint", true)
	self:RawHook(WorldMapPlayerUpper, "SetPoint", "WorldMapPlayerSetPoint", true)

	self:SecureHook("HelpPlate_Show")
	self:SecureHook("HelpPlate_Hide")
	self:SecureHook("HelpPlate_Button_AnimGroup_Show_OnFinished")

	-- Update digsites, the Blizzard map doesn't set this properly on load
	local _, _, arch = GetProfessions()
	if arch then
		if GetCVarBool("digSites") then
			WorldMapArchaeologyDigSites:Show()
		else
			WorldMapArchaeologyDigSites:Hide()
		end
	end
end

function Mapster:Refresh()
	db_ = self.db.profile

	for k,v in self:IterateModules() do
		if self:GetModuleEnabled(k) and not v:IsEnabled() then
			self:EnableModule(k)
		elseif not self:GetModuleEnabled(k) and v:IsEnabled() then
			self:DisableModule(k)
		end
		if type(v.Refresh) == "function" then
			v:Refresh()
		end
	end

	if (db.miniMap and not self.miniMap) then
		self:SizeDown()
	elseif (not db.miniMap and self.miniMap) then
		self:SizeUp()
	end
	self.miniMap = db.miniMap

	self:SetStrata()
	self:SetAlpha()
	self:SetArrow()
	self:SetScale()
	self:SetPosition()

	if self.optionsButton then
		if db.hideMapButton then
			self.optionsButton:Hide()
		else
			self.optionsButton:Show()
		end
	end

	self:UpdateBorderVisibility()
	self:UpdateMouseInteractivity()

	for i = 1, NUM_WORLDMAP_TASK_POIS do
		_G["WorldMapFrameTaskPOI"..i]:SetScale(db.poiScale)
	end
	WorldMap_UpdateQuestBonusObjectives()
	WorldMapScrollFrame_ReanchorQuestPOIs()
	self:EncounterJournal_AddMapButtons()
end

function Mapster:NavBar_ToggleMenu(frame)
	if frame:GetParent() and frame:GetParent():GetParent() == WorldMapFrame then
		dropdownScaleFix()
	end
end

function Mapster:WorldMapPlayerSetPoint(frame, point, relFrame, relPoint, x, y)
	if x and y then
		x = x / db.arrowScale
		y = y / db.arrowScale
	end
	return self.hooks[frame].SetPoint(frame, point, relFrame, relPoint, x, y)
end

function Mapster:WorldMapBlobFrame_CalculateHitTranslations()
	WorldMapBlobFrame.scale = WorldMapFrame:GetScale() * UIParent:GetScale()
end

function Mapster:WorldMap_CreateTaskPOI(index, isObjectIcon, atlasIcon)
	local button = _G["WorldMapFrameTaskPOI"..index]
	button:SetScale(db.poiScale)
	button.__SetPoint = button.SetPoint
	self:SecureHook(button, "SetPoint", "WorldMapPOISetPoint")
end

function Mapster:WorldMapPOISetPoint(frame, point, relFrame, relPoint, x, y)
	if x and y then
		x = x / db.poiScale
		y = y / db.poiScale
	end
	return frame:__SetPoint(point, relFrame, relPoint, x, y)
end

function Mapster:WorldMapPOIFrame_AnchorPOI(poiButton, posX, posY)
	if posX and posY then
		local point, frame, relPoint, x, y = poiButton:GetPoint()
		poiButton:SetScale(db.poiScale)
		poiButton:SetPoint(point, frame, relPoint, x / db.poiScale, y / db.poiScale)
	end
end

function Mapster:EncounterJournal_AddMapButtons()
	local index = 1
	local bossButton = _G["EJMapButton"..index]

	local width = WorldMapDetailFrame:GetWidth() / db.ejScale
	local height = WorldMapDetailFrame:GetHeight() / db.ejScale

	while bossButton do
		if bossButton:IsShown() then
			local x, y = EJ_GetMapEncounter(index, WorldMapFrame.fromJournal)
			bossButton:SetScale(db.ejScale)
			bossButton:SetPoint("CENTER", WorldMapBossButtonFrame, "BOTTOMLEFT", x*width, y*height);
		end
		index = index + 1
		bossButton = _G["EJMapButton"..index]
	end
end

function Mapster:HelpPlate_Show(plate)
	if plate == WorldMapFrame_HelpPlate then
		HelpPlate:SetScale(db.scale)
		HelpPlate.__Mapster = true
	end
end

function Mapster:HelpPlate_Hide(userToggled)
	if HelpPlate.__Mapster then
		if not userToggled then
			HelpPlate:SetScale(1.0)
			HelpPlate.__Mapster = nil
		end
	end
end

function Mapster:HelpPlate_Button_AnimGroup_Show_OnFinished()
	if HelpPlate.__Mapster then
		HelpPlate:SetScale(1.0)
		HelpPlate.__Mapster = nil
	end
end

function Mapster:ToggleMapSize()
	self.miniMap = not self.miniMap
	db.miniMap = self.miniMap
	ToggleFrame(WorldMapFrame)
	if self.miniMap then
		self:SizeDown()
	else
		self:SizeUp()
	end
	self:SetAlpha()
	self:SetPosition()

	self:UpdateBorderVisibility()
	self:UpdateMouseInteractivity()

	for k,v in self:IterateModules() do
		if v:IsEnabled() and type(v.UpdateMapSize) == "function" then
			v:UpdateMapSize(self.miniMap)
		end
	end

	ToggleFrame(WorldMapFrame)
end

function Mapster:SizeUp()
	WorldMapFrameSizeUpButton:Hide()
	WorldMapFrameSizeDownButton:Show()

	WorldMapFrame.UIElementsFrame.OpenQuestPanelButton:Show()
	WorldMapFrame.MainHelpButton:Show()

	if GetCVarBool("questLogOpen") or WorldMapFrame.questLogMode then
		QuestMapFrame_Show()
	end

	WorldMapFrame_UpdateMap()
	QuestMapFrame_UpdateAll()
end

function Mapster:SizeDown()
	WorldMapFrameSizeUpButton:Show()
	WorldMapFrameSizeDownButton:Hide()

	WorldMapFrame.UIElementsFrame.OpenQuestPanelButton:Hide()
	HelpPlate_Hide()
	WorldMapFrame.MainHelpButton:Hide()

	QuestMapFrame_Hide()

	WorldMapFrame_UpdateMap()
	QuestMapFrame_UpdateAll()
end

local function getZoneId()
	return (GetCurrentMapZone() + GetCurrentMapContinent() * 100)
end

function Mapster:ZONE_CHANGED_NEW_AREA()
	if not WorldMapFrame:IsShown() then
		return
	end
	local prevZone = getZoneId()
	SetMapToCurrentZone()
	local newRealZone = getZoneId()
	if prevZone ~= realZone and prevZone ~= newRealZone then
		local cont, zone = floor(prevZone / 100), mod(prevZone, 100)
		SetMapZoom(cont, zone)
	end
	realZone = newRealZone
end

function wmfOnShow(frame)
	Mapster:SetStrata()
	Mapster:SetScale()
	realZone = getZoneId()

	if IsPlayerMoving() and GetCVarBool("mapFade") then
		if not WorldMapFrame:IsMouseOver() then
			WorldMapFrame:SetAlpha(WORLD_MAP_MIN_ALPHA)
		end
		WorldMapFrame.fadeOut = true
	end
end

function wmfStartMoving(frame)
	WorldMapFrame:StartMoving()
end

function wmfStopMoving(frame)
	WorldMapFrame:StopMovingOrSizing()
	LibWindow.SavePosition(WorldMapFrame)

	WorldMapBlobFrame_ResetHitTranslations()
end

function dropdownScaleFix()
	local uiScale = 1
	local uiParentScale = UIParent:GetScale()
	if GetCVar("useUIScale") == "1" then
		uiScale = tonumber(GetCVar("uiscale"))
		if uiParentScale < uiScale then
			uiScale = uiParentScale
		end
	else
		uiScale = uiParentScale
	end
	DropDownList1:SetScale(uiScale * db.scale)
end

function Mapster:SetStrata()
	WorldMapFrame:SetFrameStrata("HIGH")
	-- restore some stratas
	WorldMapPing:SetFrameStrata("FULLSCREEN")
	WorldMapPlayerUpper:SetFrameStrata("FULLSCREEN")
	WorldMapCompareTooltip1:SetFrameStrata("TOOLTIP")
	WorldMapCompareTooltip2:SetFrameStrata("TOOLTIP")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")
end

function Mapster:SetAlpha()
	WorldMapFrame:SetAlpha(db.alpha)
	WORLD_MAP_MAX_ALPHA =  db.alpha
end

function WorldMapFrameGetAlpha(frame)
	local alpha = WorldMapFrame:GetAlphaMapster()
	if abs(alpha - WORLD_MAP_MAX_ALPHA) < 0.05 then
		return WORLD_MAP_MAX_ALPHA
	end
	if abs(alpha - WORLD_MAP_MIN_ALPHA) < 0.05 then
		return WORLD_MAP_MIN_ALPHA
	end
	return alpha
end

function Mapster:SetArrow()
	WorldMapPlayerUpper:SetScale(db.arrowScale)
	WorldMapPlayerLower:SetScale(db.arrowScale)
end

function Mapster:SetScale()
	WorldMapFrame:SetScale(db.scale)
	if HelpPlate.__Mapster then
		HelpPlate:SetScale(db.scale)
	end

	WorldMapBlobFrame_UpdateBlobs()
	WorldMapBlobFrame_ResetHitTranslations()
end

function Mapster:SetPosition()
	LibWindow.RestorePosition(WorldMapFrame)
end

function Mapster:GetModuleEnabled(module)
	return db.modules[module]
end

function Mapster:UpdateBorderVisibility()
	if db.hideBorder and Mapster.bordersVisible then
		Mapster.bordersVisible = false

		WorldMapFrame.BorderFrame:Hide()
		WorldMapFrameNavBar:Hide()
		WorldMapFrame.UIElementsFrame.TrackingOptionsButton:Hide()

		WorldMapFrameSizeDownButton:SetParent(WorldMapFrame)
		WorldMapFrameSizeUpButton:SetParent(WorldMapFrame)
		WorldMapFrameCloseButton:SetParent(WorldMapFrame)

		self:RegisterEvent("WORLD_MAP_UPDATE", "UpdateDetailTiles")
		self:UpdateDetailTiles()
		self.optionsButton:Hide()

		if not self.hookedOnUpdate then
			self:HookScript(WorldMapFrame, "OnUpdate", "UpdateMapElements")
			self.hookedOnUpdate = true
		end
		self:UpdateMapElements()
	elseif not db.hideBorder and not Mapster.bordersVisible then
		Mapster.bordersVisible = true

		WorldMapFrame.BorderFrame:Show()
		WorldMapFrameNavBar:Show()

		WorldMapFrameSizeDownButton:SetParent(WorldMapFrame.BorderFrame)
		WorldMapFrameSizeUpButton:SetParent(WorldMapFrame.BorderFrame)
		WorldMapFrameCloseButton:SetParent(WorldMapFrame.BorderFrame)

		self:UnregisterEvent("WORLD_MAP_UPDATE")
		self:UpdateDetailTiles()
		if not db.hideMapButton then
			self.optionsButton:Show()
		end
		if self.hookedOnUpdate then
			self:Unhook(WorldMapFrame, "OnUpdate")
			self.hookedOnUpdate = nil
		end
		self:UpdateMapElements()
	end

	for k,v in self:IterateModules() do
		if v:IsEnabled() and type(v.BorderVisibilityChanged) == "function" then
			v:BorderVisibilityChanged(not db.hideBorder)
		end
	end
end

function Mapster:UpdateMapElements()
	local mouseOver = WorldMapFrame:IsMouseOver()
	if self.elementsHidden and (mouseOver or not db.hideBorder) then
		self.elementsHidden = nil
		(self.miniMap and WorldMapFrameSizeUpButton or WorldMapFrameSizeDownButton):Show()
		WorldMapFrameCloseButton:Show()
		for _, frame in pairs(self.elementsToHide) do
			frame:Show()
		end
	elseif not self.elementsHidden and not mouseOver and db.hideBorder then
		self.elementsHidden = true
		WorldMapFrameSizeUpButton:Hide()
		WorldMapFrameSizeDownButton:Hide()
		WorldMapFrameCloseButton:Hide()
		for _, frame in pairs(self.elementsToHide) do
			frame:Hide()
		end
	end
end

function Mapster:UpdateMouseInteractivity()
	if db.disableMouse then
		WorldMapButton:EnableMouse(false)
		WorldMapFrame:EnableMouse(false)
	else
		WorldMapButton:EnableMouse(true)
		WorldMapFrame:EnableMouse(true)
	end
end

local function hasOverlays()
	if Mapster:GetModuleEnabled("FogClear") then
		return Mapster:GetModule("FogClear"):RealHasOverlays()
	else
		return GetNumMapOverlays() > 0
	end
end

function Mapster:UpdateDetailTiles()
	local mapFileName, textureHeight, _, isMicroDungeon, microDungeonMapName = GetMapInfo()
	if db.hideBorder and GetCurrentMapZone() > 0 and hasOverlays() and not isMicroDungeon then
		for i=1, GetNumberOfDetailTiles() do
			_G["WorldMapDetailTile"..i]:Hide()
		end
	else
		for i=1, GetNumberOfDetailTiles() do
			_G["WorldMapDetailTile"..i]:Show()
		end
	end
end

function Mapster:SetModuleEnabled(module, value)
	local old = db.modules[module]
	db.modules[module] = value
	if old ~= value then
		if value then
			self:EnableModule(module)
		else
			self:DisableModule(module)
		end
	end
end
