--[[
Copyright (c) 2009-2012, Hendrik "Nevcairiel" Leppkes < h.leppkes@gmail.com >
All rights reserved.
]]

local Mapster = LibStub("AceAddon-3.0"):NewAddon("Mapster", "AceEvent-3.0", "AceHook-3.0")

local LibWindow = LibStub("LibWindow-1.1")
local L = LibStub("AceLocale-3.0"):GetLocale("Mapster")

local PLAYER_ARROW_SIZE_WINDOW = 40
local PLAYER_ARROW_SIZE_FULL_WITH_QUESTS = 38
local PLAYER_ARROW_SIZE_FULL_NO_QUESTS = 28

local defaults = {
	profile = {
		hideMapButton = false,
		arrowScale = 0.88,
		questPanels = 1,
		modules = {
			['*'] = true,
		},
		x = 0,
		y = 0,
		points = "CENTER",
		scale = 0.75,
		poiScale = 0.8,
		ejScale = 0.8,
		alpha = 1,
		hideBorder = false,
		disableMouse = false,
		miniMap = false,
		mini = {
			x = 0,
			y = 0,
			point = "CENTER",
			scale = 1,
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

local wmfOnShow, wmfStartMoving, wmfStopMoving, dropdownScaleFix

function Mapster:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("MapsterDB", defaults, true)
	db_ = self.db.profile

	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")

	-- small migration
	if db.questObjectives then
		if db.questObjectives < 2 then
			db.questPanels = 0
		end
		db.questObjectives = nil
	end

	self.elementsToHide = {}

	self.UIHider = CreateFrame("Frame")
	self.UIHider:Hide()

	self:SetupOptions()
end

local realZone
function Mapster:OnEnable()
	local mini = GetCVarBool("miniWorldMap")
	SetCVar("miniWorldMap", nil)
	-- restore map to its vanilla state
	if mini then
		WorldMap_ToggleSizeUp()
	end

	self:SetupMapButton()

	LibWindow.RegisterConfig(WorldMapFrame, db)

	local vis = WorldMapFrame:IsVisible()
	if vis then
		HideUIPanel(WorldMapFrame)
	end

	UIPanelWindows["WorldMapFrame"] = nil
	WorldMapFrame:SetAttribute("UIPanelLayout-enabled", false)
	WorldMapFrame:SetAttribute("UIPanelLayout-area", nil)
	WorldMapFrame:HookScript("OnShow", wmfOnShow)
	BlackoutWorld:Hide()
	WorldMapTitleButton:Hide()

	WorldMapFrame:SetScript("OnKeyDown", nil)

	WorldMapFrame:SetMovable(true)
	WorldMapFrame:RegisterForDrag("LeftButton")
	WorldMapFrame:SetScript("OnDragStart", wmfStartMoving)
	WorldMapFrame:SetScript("OnDragStop", wmfStopMoving)

	WorldMapFrame:SetParent(UIParent)
	WorldMapFrame:SetToplevel(true)
	WorldMapFrame:SetWidth(1024)
	WorldMapFrame:SetHeight(768)
	WorldMapFrame:SetClampedToScreen(false)

	WorldMapContinentDropDownButton:SetScript("OnClick", dropdownScaleFix)
	WorldMapZoneDropDownButton:SetScript("OnClick", dropdownScaleFix)
	WorldMapZoneMinimapDropDownButton:SetScript("OnClick", dropdownScaleFix)

	WorldMapFrameSizeDownButton:SetScript("OnClick", function() Mapster:ToggleMapSize() end)
	WorldMapFrameSizeUpButton:SetScript("OnClick", function() Mapster:ToggleMapSize() end)
	self:RawHook("WorldMapFrame_ToggleWindowSize", "ToggleMapSize", true)

	WorldMapShowDropDown:SetPoint("BOTTOMRIGHT", WorldMapPositioningGuide, "BOTTOMRIGHT", 0, -2)

	local questOnlyBlobs = CreateFrame("CheckButton", "MapsterShowOnlyQuestBlobs", WorldMapFrame, "OptionsCheckButtonTemplate")
	questOnlyBlobs:SetWidth(24)
	questOnlyBlobs:SetHeight(24)
	MapsterShowOnlyQuestBlobsText:SetText(L["Hide Quest Panels"])
	questOnlyBlobs:SetPoint("RIGHT", WorldMapShowDropDown, "LEFT", -130, 0)
	questOnlyBlobs:Show()
	questOnlyBlobs:SetChecked(db.questPanels == 0)
	questOnlyBlobs:SetScript("OnClick", function(self)
		db.questPanels = self:GetChecked() and 0 or 1
		Mapster:WorldMapFrame_DisplayQuests()
	end)

	hooksecurefunc(WorldMapTooltip, "Show", function(self)
		self:SetFrameStrata("TOOLTIP")
	end)

	tinsert(UISpecialFrames, "WorldMapFrame")

	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	if db.miniMap then
		self:SizeDown()
	end
	self.miniMap = db.miniMap

	self:SetPosition()
	self:SetAlpha()
	self:SetArrow()
	self:UpdateBorderVisibility()
	self:UpdateMouseInteractivity()

	self:SecureHook("WorldMapFrame_DisplayQuestPOI")
	self:SecureHook("WorldMapFrame_DisplayQuests")
	self:RawHook("WorldMapFrame_SelectQuestFrame", true)
	self:SecureHook("WorldMapFrame_SetPOIMaxBounds")
	self:SecureHook("WorldMapLevelDropDown_Update", "UpdateMapElements")
	WorldMapFrame_SetPOIMaxBounds()
	self:SecureHook("EncounterJournal_AddMapButtons")

	self:RawHook(WorldMapPlayerLower, "SetPoint", "WorldMapPlayerSetPoint", true)
	self:RawHook(WorldMapPlayerUpper, "SetPoint", "WorldMapPlayerSetPoint", true)

	if vis then
		ShowUIPanel(WorldMapFrame)
	end
end

local secFrameList = {"WorldMapBlobFrame", "WorldMapArchaeologyDigSites", "ScenarioPOIFrame"}
local secFrameWasVisible, secFrameNewScale = {}, {}
local secFrameHideFunc = function(self) secFrameWasVisible[self:GetName()] = nil end
local secFrameShowFunc = function(self) secFrameWasVisible[self:GetName()] = true end
local secFrameScaleFunc = function(self, scale) secFrameNewScale[self:GetName()] = scale end

function Mapster:PLAYER_REGEN_DISABLED()
	for _,frame in pairs(secFrameList) do
		local frameRef = _G[frame]
		if frameRef then
			secFrameWasVisible[frame] = frameRef:IsShown()
			secFrameNewScale[frame] = nil
			frameRef:SetParent(nil)
			frameRef:ClearAllPoints()
			frameRef:SetPoint("TOP", UIParent, "BOTTOM")
			frameRef:Hide()
			frameRef.Hide = secFrameHideFunc
			frameRef.Show = secFrameShowFunc
			frameRef.SetScale = secFrameScaleFunc
		end
	end
end

local updateFrame = CreateFrame("Frame")
local function restoreBlobs()
	WorldMapBlobFrame_CalculateHitTranslations()
	if WorldMapQuestScrollChildFrame.selected and not WorldMapQuestScrollChildFrame.selected.completed then
		WorldMapBlobFrame:DrawBlob(WorldMapQuestScrollChildFrame.selected.questId, true)
	end
	updateFrame:SetScript("OnUpdate", nil)
end

function Mapster:PLAYER_REGEN_ENABLED()
	for _,frame in pairs(secFrameList) do
		local frameRef = _G[frame]
		if frameRef then
			frameRef:SetParent(WorldMapFrame)
			frameRef:ClearAllPoints()
			frameRef:SetPoint("TOPLEFT", WorldMapDetailFrame)
			frameRef.Hide = nil
			frameRef.Show = nil
			frameRef.SetScale = nil
			if secFrameWasVisible[frame] then
				frameRef:Show()
				if frame == "WorldMapBlobFrame" then
					updateFrame:SetScript("OnUpdate", restoreBlobs)
				end
			end
			if secFrameNewScale[frame] then
				frameRef:SetScale(secFrameNewScale[frame])
				frameRef.xRatio = nil
				secFrameNewScale[frame] = nil
			end
		end
	end
	if WorldMapQuestScrollChildFrame.selected then
		WorldMapBlobFrame:DrawBlob(WorldMapQuestScrollChildFrame.selected.questId, false)
	end
end

local WORLDMAP_POI_MIN_X = 12
local WORLDMAP_POI_MIN_Y = -12
local WORLDMAP_POI_MAX_X     -- changes based on current scale, see WorldMapFrame_SetPOIMaxBounds
local WORLDMAP_POI_MAX_Y     -- changes based on current scale, see WorldMapFrame_SetPOIMaxBounds

function Mapster:WorldMapFrame_DisplayQuestPOI(questFrame, isComplete)
	-- Recalculate Position to adjust for Scale
	local _, posX, posY = QuestPOIGetIconInfo(questFrame.questId)
	if posX and posY then
		local POIscale = WORLDMAP_SETTINGS.size
		posX = posX * WorldMapDetailFrame:GetWidth() * POIscale
		posY = -posY * WorldMapDetailFrame:GetHeight() * POIscale

		-- keep outlying POIs within map borders
		if ( posY > WORLDMAP_POI_MIN_Y ) then
			posY = WORLDMAP_POI_MIN_Y
		elseif ( posY < WORLDMAP_POI_MAX_Y ) then
			posY = WORLDMAP_POI_MAX_Y
		end
		if ( posX < WORLDMAP_POI_MIN_X ) then
			posX = WORLDMAP_POI_MIN_X
		elseif ( posX > WORLDMAP_POI_MAX_X ) then
			posX = WORLDMAP_POI_MAX_X
		end
		questFrame.poiIcon:SetPoint("CENTER", "WorldMapPOIFrame", "TOPLEFT", posX / db.poiScale, posY / db.poiScale)
		questFrame.poiIcon:SetScale(db.poiScale)
	end
end

function Mapster:WorldMapFrame_SetPOIMaxBounds()
	WORLDMAP_POI_MAX_Y = WorldMapDetailFrame:GetHeight() * -WORLDMAP_SETTINGS.size + 12;
	WORLDMAP_POI_MAX_X = WorldMapDetailFrame:GetWidth() * WORLDMAP_SETTINGS.size + 12;
end

function Mapster:WorldMapPlayerSetPoint(frame, point, relFrame, relPoint, x, y)
	if x and y then
		x = x / db.arrowScale
		y = y / db.arrowScale
	end
	return self.hooks[frame].SetPoint(frame, point, relFrame, relPoint, x, y)
end

function Mapster:EncounterJournal_AddMapButtons()
	local scale = WorldMapDetailFrame:GetScale();
	local width = WorldMapDetailFrame:GetWidth() * scale / db.ejScale
	local height = WorldMapDetailFrame:GetHeight() * scale / db.ejScale

	local index = 1
	local x, y, instanceID, name, description, encounterID = EJ_GetMapEncounter(index)

	local mini = WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE
	while name do
		local bossButton = _G["EJMapButton"..index];
		if bossButton then
			if db.showEJBosses then
				bossButton:SetPoint("CENTER", WorldMapBossButtonFrame, "BOTTOMLEFT", x*width, y*height);
				bossButton:SetScale(db.ejScale)
			else
				bossButton:Hide()
			end
		end
		index = index + 1
		x, y, instanceID, name, description, encounterID = EJ_GetMapEncounter(index)
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
	self:UpdateModuleMapsizes()
	WorldMapFrame_UpdateQuests()
	EncounterJournal_AddMapButtons()
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

	-- Notify the modules about the map size change,
	-- so they can re-anchor frames or stuff like that.
	self:UpdateModuleMapsizes()

	self:UpdateBorderVisibility()
	self:UpdateMouseInteractivity()

	ToggleFrame(WorldMapFrame)
	WorldMapFrame_UpdateQuests()
end

function Mapster:UpdateModuleMapsizes()
	for k,v in self:IterateModules() do
		if v:IsEnabled() and type(v.UpdateMapsize) == "function" then
			v:UpdateMapsize(self.miniMap)
		end
	end
end

function Mapster:SizeUp()
	WORLDMAP_SETTINGS.size = WORLDMAP_QUESTLIST_SIZE
	-- adjust main frame
	WorldMapFrame:SetWidth(1024)
	WorldMapFrame:SetHeight(768)
	WorldMapFrame_ResetFrameLevels()
	-- adjust map frames
	WorldMapPositioningGuide:ClearAllPoints()
	WorldMapPositioningGuide:SetPoint("CENTER")
	WorldMapDetailFrame:SetScale(WORLDMAP_QUESTLIST_SIZE)
	WorldMapDetailFrame:SetPoint("TOPLEFT", WorldMapPositioningGuide, "TOP", -726, -99)
	WorldMapButton:SetScale(WORLDMAP_QUESTLIST_SIZE)
	WorldMapFrameAreaFrame:SetScale(WORLDMAP_QUESTLIST_SIZE)
	WorldMapBlobFrame:SetScale(WORLDMAP_QUESTLIST_SIZE)
	WorldMapBlobFrame.xRatio = nil		-- force hit recalculations
	ScenarioPOIFrame:SetScale(WORLDMAP_FULLMAP_SIZE);	--If we ever need to add objectives on the map itself we should adjust this value
	WorldMapArchaeologyDigSites:SetScale(WORLDMAP_FULLMAP_SIZE)
	WorldMapArchaeologyDigSites.xRatio = nil		-- force hit recalculations
	-- show big window elements
	WorldMapZoneMinimapDropDown:Show()
	WorldMapZoomOutButton:Show()
	WorldMapZoneDropDown:Show()
	WorldMapContinentDropDown:Show()
	WorldMapQuestScrollFrame:Show()
	WorldMapQuestDetailScrollFrame:Show()
	WorldMapQuestRewardScrollFrame:Show()
	WorldMapFrameSizeDownButton:Show()
	WorldMapShowDropDown:Show()
	-- hide small window elements
	WorldMapTitleButton:Hide()
	WorldMapFrameMiniBorderLeft:Hide()
	WorldMapFrameMiniBorderRight:Hide()
	WorldMapFrameSizeUpButton:Hide()
	-- floor dropdown
	WorldMapLevelDropDown:ClearAllPoints()
	WorldMapLevelDropDown:SetPoint("TOPRIGHT", WorldMapPositioningGuide, "TOPRIGHT", -50, -35)
	WorldMapLevelDropDown.header:Show()
	-- tiny adjustments
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapPositioningGuide, 4, 4)
	WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapPositioningGuide, -16, 4)
	WorldMapTrackQuest:SetParent(WorldMapFrame)
	WorldMapTrackQuest:ClearAllPoints()
	WorldMapTrackQuest:SetPoint("BOTTOMLEFT", WorldMapPositioningGuide, "BOTTOMLEFT", 16, 4)
	WorldMapTrackQuest:Show()
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetPoint("CENTER", 0, 372)

	WorldMapFrame_SetPOIMaxBounds()
	if GetCVarBool("questPOI") then
		WorldMapPlayerLower:SetSize(PLAYER_ARROW_SIZE_FULL_WITH_QUESTS,PLAYER_ARROW_SIZE_FULL_WITH_QUESTS)
		WorldMapPlayerUpper:SetSize(PLAYER_ARROW_SIZE_FULL_WITH_QUESTS,PLAYER_ARROW_SIZE_FULL_WITH_QUESTS)
	else
		WorldMapPlayerLower:SetSize(PLAYER_ARROW_SIZE_FULL_NO_QUESTS,PLAYER_ARROW_SIZE_FULL_NO_QUESTS)
		WorldMapPlayerUpper:SetSize(PLAYER_ARROW_SIZE_FULL_NO_QUESTS,PLAYER_ARROW_SIZE_FULL_NO_QUESTS)
	end
	MapBarFrame_UpdateLayout(MapBarFrame)

	MapsterShowOnlyQuestBlobs:Show()

	self:WorldMapFrame_DisplayQuests()
	self.optionsButton:SetPoint("TOPRIGHT", WorldMapPositioningGuide, "TOPRIGHT", -43, -2)
end

function Mapster:SizeDown()
	WORLDMAP_SETTINGS.size = WORLDMAP_WINDOWED_SIZE
	-- adjust main frame
	WorldMapFrame:SetWidth(623)
	WorldMapFrame:SetHeight(437)
	WorldMapFrame_ResetFrameLevels()
	-- adjust map frames
	WorldMapPositioningGuide:ClearAllPoints()
	WorldMapPositioningGuide:SetAllPoints()
	WorldMapDetailFrame:SetScale(WORLDMAP_WINDOWED_SIZE)
	WorldMapButton:SetScale(WORLDMAP_WINDOWED_SIZE)
	WorldMapFrameAreaFrame:SetScale(WORLDMAP_WINDOWED_SIZE)
	WorldMapBlobFrame:SetScale(WORLDMAP_WINDOWED_SIZE)
	WorldMapBlobFrame.xRatio = nil		-- force hit recalculations
	ScenarioPOIFrame:SetScale(WORLDMAP_WINDOWED_SIZE);
	WorldMapArchaeologyDigSites:SetScale(WORLDMAP_WINDOWED_SIZE)
	WorldMapArchaeologyDigSites.xRatio = nil		-- force hit recalculations
	WorldMapFrameMiniBorderLeft:SetPoint("TOPLEFT", 10, -14)
	WorldMapDetailFrame:SetPoint("TOPLEFT", 37, -66)
	-- hide big window elements
	WorldMapZoneMinimapDropDown:Hide()
	WorldMapZoomOutButton:Hide()
	WorldMapZoneDropDown:Hide()
	WorldMapContinentDropDown:Hide()
	WorldMapLevelDropDown:Hide()
	WorldMapLevelUpButton:Hide()
	WorldMapLevelDownButton:Hide()
	WorldMapQuestScrollFrame:Hide()
	WorldMapQuestDetailScrollFrame:Hide()
	WorldMapQuestRewardScrollFrame:Hide()
	WorldMapFrameSizeDownButton:Hide()
	WorldMapShowDropDown:Hide()
	-- show small window elements
	WorldMapTitleButton:Show()
	WorldMapFrameMiniBorderLeft:Show()
	WorldMapFrameMiniBorderRight:Show()
	WorldMapFrameSizeUpButton:Show()
	-- floor dropdown
	WorldMapLevelDropDown:ClearAllPoints()
	WorldMapLevelDropDown:SetPoint("TOPLEFT", WorldMapDetailFrame, "TOPLEFT", -19, 3)
	WorldMapLevelDropDown:SetFrameLevel(WORLDMAP_POI_FRAMELEVEL + 2)
	WorldMapLevelDropDown.header:Hide()
	-- tiny adjustments
	WorldMapFrameCloseButton:SetPoint("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -44, 5)
	WorldMapFrameSizeDownButton:SetPoint("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -66, 5)
	WorldMapTrackQuest:SetParent(self.UIHider)
	WorldMapFrameTitle:ClearAllPoints()
	WorldMapFrameTitle:SetPoint("TOP", WorldMapDetailFrame, 0, 20)

	WorldMapFrame_SetPOIMaxBounds()
	WorldMapPlayerLower:SetSize(PLAYER_ARROW_SIZE_WINDOW,PLAYER_ARROW_SIZE_WINDOW)
	WorldMapPlayerUpper:SetSize(PLAYER_ARROW_SIZE_WINDOW,PLAYER_ARROW_SIZE_WINDOW)
	MapBarFrame_UpdateLayout(MapBarFrame)

	MapsterShowOnlyQuestBlobs:Hide()

	self.optionsButton:SetPoint("TOPRIGHT", WorldMapFrameMiniBorderRight, "TOPRIGHT", -93, -2)
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

	if WORLDMAP_SETTINGS.selectedQuest then
		WorldMapFrame_SelectQuestFrame(WORLDMAP_SETTINGS.selectedQuest)
	end
end

function wmfStartMoving(frame)
	Mapster:HideBlobs()

	frame:StartMoving()
end

function wmfStopMoving(frame)
	frame:StopMovingOrSizing()
	LibWindow.SavePosition(frame)

	Mapster:ShowBlobs()
end

function dropdownScaleFix(self)
	ToggleDropDownMenu(nil, nil, self:GetParent())
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

function Mapster:ShowBlobs()
	WorldMapBlobFrame_CalculateHitTranslations()
	if WORLDMAP_SETTINGS.selectedQuest and not WORLDMAP_SETTINGS.selectedQuest.completed then
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuest.questId, true)
	end
end

function Mapster:HideBlobs()
	if WORLDMAP_SETTINGS.selectedQuest then
		WorldMapBlobFrame:DrawBlob(WORLDMAP_SETTINGS.selectedQuest.questId, false)
	end
end

function Mapster:SetStrata()
	WorldMapFrame:SetFrameStrata("HIGH")
	-- restore some stratas
	WorldMapPing:SetFrameStrata("FULLSCREEN")
	WorldMapPlayerUpper:SetFrameStrata("FULLSCREEN")
	WorldMapCompareTooltip1:SetFrameStrata("TOOLTIP")
	WorldMapCompareTooltip2:SetFrameStrata("TOOLTIP")
	WorldMapCompareTooltip3:SetFrameStrata("TOOLTIP")
	WorldMapTooltip:SetFrameStrata("TOOLTIP")
end

function Mapster:SetAlpha()
	WorldMapFrame:SetAlpha(db.alpha)
end

function Mapster:SetArrow()
	WorldMapPlayerUpper:SetScale(db.arrowScale)
	WorldMapPlayerLower:SetScale(db.arrowScale)
	--PlayerArrowEffectFrame:SetModelScale(db.arrowScale)
end

function Mapster:SetScale()
	WorldMapFrame:SetScale(db.scale)
end

function Mapster:SetPosition()
	LibWindow.RestorePosition(WorldMapFrame)
end

function Mapster:GetModuleEnabled(module)
	return db.modules[module]
end

function Mapster:UpdateBorderVisibility()
	if db.hideBorder then
		Mapster.bordersVisible = false
		if self.miniMap then
			WorldMapFrameMiniBorderLeft:Hide()
			WorldMapFrameMiniBorderRight:Hide()
			--WorldMapQuestShowObjectives:SetPoint("BOTTOMRIGHT", WorldMapDetailFrame, "TOPRIGHT", -50 - WorldMapQuestShowObjectivesText:GetWidth(), 2);
		else
			-- TODO
		end
		WorldMapFrameTitle:Hide()
		self:RegisterEvent("WORLD_MAP_UPDATE", "UpdateDetailTiles")
		self:UpdateDetailTiles()
		self.optionsButton:Hide()
		if not self.hookedOnUpdate then
			self:HookScript(WorldMapFrame, "OnUpdate", "UpdateMapElements")
			self.hookedOnUpdate = true
		end
		self:UpdateMapElements()
	else
		Mapster.bordersVisible = true
		if self.miniMap then
			WorldMapFrameMiniBorderLeft:Show()
			WorldMapFrameMiniBorderRight:Show()
		else
			-- TODO
		end
		--WorldMapQuestShowObjectives_AdjustPosition()
		WorldMapFrameTitle:Show()
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
		--WorldMapQuestShowObjectives:Show()
		for _, frame in pairs(self.elementsToHide) do
			frame:Show()
		end
	elseif not self.elementsHidden and not mouseOver and db.hideBorder then
		self.elementsHidden = true
		WorldMapFrameSizeUpButton:Hide()
		WorldMapFrameSizeDownButton:Hide()
		WorldMapFrameCloseButton:Hide()
		--WorldMapQuestShowObjectives:Hide()
		for _, frame in pairs(self.elementsToHide) do
			frame:Hide()
		end
	end
	-- process elements that show/hide themself
	if self.elementsHidden then
		WorldMapLevelDropDown:Hide()
	else
		local levels = GetNumDungeonMapLevels()
		if levels and levels > 0 then
			WorldMapLevelDropDown:Show()
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

function Mapster:WorldMapFrame_DisplayQuests()
	if WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then return end
	if not (WatchFrame.showObjectives and WorldMapFrame.numQuests > 0) then return end
	if db.questPanels == 0 and WORLDMAP_SETTINGS.size == WORLDMAP_QUESTLIST_SIZE then
		WorldMapFrame_SetFullMapView()

		WorldMapBlobFrame:SetScale(WORLDMAP_FULLMAP_SIZE)
		WorldMapBlobFrame.xRatio = nil		-- force hit recalculations
		WorldMapArchaeologyDigSites:SetScale(WORLDMAP_FULLMAP_SIZE)
		WorldMapArchaeologyDigSites.xRatio = nil		-- force hit recalculations
		WorldMapFrame_SetPOIMaxBounds()
	elseif db.questPanels == 1 and WORLDMAP_SETTINGS.size ~= WORLDMAP_QUESTLIST_SIZE then
		WorldMapFrame_SetQuestMapView()

		WorldMapBlobFrame:SetScale(WORLDMAP_QUESTLIST_SIZE)
		WorldMapBlobFrame.xRatio = nil		-- force hit recalculations
		WorldMapArchaeologyDigSites:SetScale(WORLDMAP_QUESTLIST_SIZE)
		WorldMapArchaeologyDigSites.xRatio = nil		-- force hit recalculations
		WorldMapFrame_SetPOIMaxBounds()
	end
	WorldMapFrame_UpdateQuests()
end

function Mapster:WorldMapFrame_SelectQuestFrame(...)
	local old_size = WORLDMAP_SETTINGS.size
	if db.questPanels ~= 1 then
		WORLDMAP_SETTINGS.size = WORLDMAP_WINDOWED_SIZE
	end
	self.hooks.WorldMapFrame_SelectQuestFrame(...)
	WORLDMAP_SETTINGS.size = old_size
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
