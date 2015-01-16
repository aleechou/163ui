-- Tidy Plates - SMILE! :-D

TidyPlatesDebug = false
DebugCount = 1
---------------------------------------------------------------------------------------------------------------------
-- Variables and References
---------------------------------------------------------------------------------------------------------------------
TidyPlates = {}

-- Local References
local _
local select, pairs, tostring  = select, pairs, tostring 			    -- Local function copy
local CreateTidyPlatesStatusbar = CreateTidyPlatesStatusbar			    -- Local function copy
local WorldFrame, UIParent = WorldFrame, UIParent

-- Internal Data
local Plates, PlatesVisible, PlatesFading, GUID = {}, {}, {}, {}	            	-- Plate Lists
local nameplate, extended, bars, regions, visual, carrier				    		-- Temp/Local References
local unit, unitcache, style, stylename, unitchanged				    			-- Temp/Local References
local numChildren = -1                                                              -- Cache the current number of plates
local activetheme = {}                                                              -- Table Placeholder
local InCombat, HasTarget = false, false					                        -- Player State Data
local EnableFadeIn = true                                                           -- Enables Alpha Effects
local EMPTY_TEXTURE = "Interface\\Addons\\TidyPlates\\Media\\Empty"
local ResetPlates, UpdateAll = false, false
local CompatibilityMode = false

---------------------------------------------------------------------------------------------------------------------
-- Core Function Declaration
---------------------------------------------------------------------------------------------------------------------
-- Helpers
local function ClearIndices(t) if t then for i,v in pairs(t) do t[i] = nil end return t end end
local function IsPlateShown(plate) return plate and plate:IsShown() end

-- Queueing
local function SetUpdateMe(plate) plate.UpdateMe = true end
local function SetUpdateAll() UpdateAll = true end
local function SetUpdateHealth(source) source.parentPlate.UpdateHealth = true end

-- Style
local UpdateStyle

-- Indicators
local UpdateIndicator_CustomScaleText, UpdateIndicator_Standard, UpdateIndicator_CustomAlpha
local UpdateIndicator_Level, UpdateIndicator_ThreatGlow, UpdateIndicator_RaidIcon
local UpdateIndicator_EliteIcon, UpdateIndicator_UnitColor, UpdateIndicator_Name
local UpdateIndicator_HealthBar, UpdateIndicator_Target
local OnUpdateCastbar, OnShowCastbar, OnHideCastbar

-- Event Functions
local OnShowNameplate, OnHideNameplate, OnUpdateNameplate, OnResetNameplate
local OnHealthUpdate, UpdateUnitCondition
local UpdateUnitContext, OnRequestWidgetUpdate, OnRequestDelegateUpdate
local UpdateUnitIdentity
local OnNewNameplate

-- Main Loop
local OnUpdate
local OnNewNameplate
local ForEachPlate

-- Context
local function isHighlighted(plate)
	--local r,g,b = plate.extended.regions.name:GetTextColor()
	return (plate.extended.regions.highlight:IsShown())		-- 5.x Mouseover; Not valid in 6.0
	--return ((b < .1) and (g > .8)) --or (plate.extended.unit.guid == UnitGUID("mouseover"))
	-- ceil(select(3, plate.extended.regions.name:GetTextColor())) == 0	-- 6.0 Mouseover; Check name color
	--[[
		if you're in combat with something, the name goes red.
		if you've got it highlighted, the name goes yellow, but not if it's red.
	--]]
end

-- UpdateReferences
local function UpdateReferences(plate)
	nameplate = plate
	extended = plate.extended

	carrier = plate.carrier
	bars = extended.bars
	regions = extended.regions
	unit = extended.unit
	unitcache = extended.unitcache
	visual = extended.visual
	style = extended.style
	threatborder = visual.threatborder
end

---------------------------------------------------------------------------------------------------------------------
-- Nameplate Detection & Update Loop
---------------------------------------------------------------------------------------------------------------------
do
	-- Local References
	local WorldGetNumChildren, WorldGetChildren = WorldFrame.GetNumChildren, WorldFrame.GetChildren

	-- IsNameplate
	local function IsNameplate(frame)
		if frame:GetName() and strfind(frame:GetName(), '^NamePlate%d') then
			local textureChild, nameTextChild =frame:GetChildren()
			--local nameTextChild = select(2, frame:GetChildren())
			if nameTextChild then
				local nameTextRegion, otherRegion, anotherRegion = nameTextChild:GetRegions()
				--print(nameTextRegion:GetObjectType(), otherRegion, anotherRegion)
				return (nameTextRegion and nameTextRegion:GetObjectType() == 'FontString')
			end
		end
	end

	-- ForEachPlate
	function ForEachPlate(functionToRun, ...)
		for plate in pairs(PlatesVisible) do
			if plate.extended.Active then
				functionToRun(plate, ...)
			end
		end
	end

        -- OnUpdate; This function is run frequently, on every clock cycle
	function OnUpdate(self, e)
		-- Poll Loop
        local plate, curChildren


			DebugCount = DebugCount + 1
			if DebugCount > 200 then DebugCount = 1 end


		for plate in pairs(PlatesVisible) do
			local UpdateMe = UpdateAll or plate.UpdateMe
			local UpdateHealth = plate.UpdateHealth
			local carrier = plate.carrier
			local extended = plate.extended

			-- Hide Carrier; FPS Improvement while changing position, etc.
			carrier:Hide()

			-- Get Parent Alpha (Target Detection)
			if HasTarget then
				plate.alpha = plate:GetAlpha()
			end

			-- Positioning
			if CompatibilityMode then
				plate:SetAlpha(1)
			else
				--local _,_,_,x,y = extended.bars.group:GetPoint()
				--carrier:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", floor(x), floor(y+16))
				local x,y = plate:GetCenter()
				carrier:SetPoint("CENTER", WorldFrame, "BOTTOMLEFT", floor(x), floor(y))
			end

			-- Get Highlight (Mouseover Detection)
			if isHighlighted(plate) then
				if not plate.isMouseover then
					plate.isMouseover = true
					UpdateMe = true
				end

			elseif plate.isMouseover then
				plate.isMouseover = false
				UpdateMe = true
			else

			end


			-- Check for an Update Request
			if UpdateMe or UpdateHealth then
				if not UpdateMe then
					OnHealthUpdate(plate)
				else
					OnUpdateNameplate(plate)
				end
				plate.UpdateMe = false
				plate.UpdateHealth = false
			end

			-- Scaling Animation

			-- Alpha Animation
			--EnableFadeIn
			local increment = e * 7
			if extended.visibleAlpha ~= extended.requestedAlpha then

				if EnableFadeIn and extended.requestedAlpha > extended.visibleAlpha + increment then
					extended.visibleAlpha = extended.visibleAlpha + increment
				elseif EnableFadeIn and extended.requestedAlpha < extended.visibleAlpha - (increment * 1.5) then
					extended.visibleAlpha = extended.visibleAlpha - (increment * 1.5)
				else
					extended.visibleAlpha = extended.requestedAlpha
				end

				extended:SetAlpha(extended.visibleAlpha)
			end

			-- Restore Carrier
			carrier:Show()
		end

		-- Reset Mass-Update Flag
		UpdateAll = false

		-- Detect New Nameplates
		curChildren = select('#', WorldFrame:GetChildren())
		if numChildren ~= curChildren then
			local i, f
			for i = 1, curChildren do
			    f = select(i, WorldFrame:GetChildren())

				   if not Plates[f] and IsNameplate(f) then
						 OnNewNameplate(f)
				   end

			end
			numChildren = curChildren
		end

	end
end

---------------------------------------------------------------------------------------------------------------------
--  Nameplate Extension: Applies scripts, hooks, and adds additional frame variables and regions
---------------------------------------------------------------------------------------------------------------------
do
	-- ApplyPlateExtesion
	function OnNewNameplate(plate)
		Plates[plate] = true

		-- Blizzard References
		--------------------------------
		local bars, regions = {}, {}
		local bargroup, namegroup = plate:GetChildren()
		local health, cast = bargroup:GetChildren()

		bars.health = health
		bars.cast = cast
		bars.group = bargroup

		health.parentPlate = plate		-- Needed for OnHealthUpdate Hook
		cast.parentPlate = plate		-- Needed for UpdateCastBar Hook

		-- Region References
		regions.threatglow,
		regions.healthborder,
		regions.highlight,
		regions.level,
		regions.skullicon,
		regions.raidicon,
		regions.eliteicon
			= bargroup:GetRegions()

		regions.name
			= namegroup:GetRegions()

		regions.castborder,
		regions.castnostop,
		regions.spellicon,
		regions.spelltext,
		regions.spellshadow
			= select(2, cast:GetRegions())

		-- Make Blizzard Plate invisible
		-- [[
		health:SetStatusBarTexture(EMPTY_TEXTURE)
		cast:SetStatusBarTexture(EMPTY_TEXTURE)

		health:Hide()
		namegroup:Hide()

		regions.threatglow:SetTexture(nil)
		regions.healthborder:Hide()
		regions.highlight:SetTexture(nil)
		regions.level:SetWidth( 000.1 )
		regions.level:Hide()
		regions.skullicon:SetTexture(nil)
		--regions.skullicon:SetAlpha(0)
		regions.raidicon:SetAlpha( 0 )
		--regions.eliteicon:SetTexture(nil)
		regions.eliteicon:SetAlpha(0)

		regions.name:Hide()

		regions.castborder:SetTexture(nil)
		regions.castnostop:SetTexture(nil)
		regions.spellicon:SetTexCoord( 0, 0, 0, 0 )
		regions.spellicon:SetWidth(.001)
		regions.spellshadow:SetTexture(nil)
		regions.spellshadow:Hide()
		regions.spelltext:Hide()
		--]]

        -- Tidy Plates Frame
        --------------------------------
		local carrier
		local frameName = "TidyPlatesCarrier"..numChildren

		if CompatibilityMode then carrier = CreateFrame("Frame", frameName, plate)
			else carrier = CreateFrame("Frame", frameName, WorldFrame) end

		local extended = CreateFrame("Frame", nil, carrier)

		plate.carrier = carrier
		plate.extended = extended

        -- Add Graphical Elements
		local visual = {}
		-- Status Bars
		local healthbar = CreateTidyPlatesStatusbar(extended)
		local castbar = CreateTidyPlatesStatusbar(extended)
		healthbar:SetFrameStrata("BACKGROUND")
		castbar:SetFrameStrata("BACKGROUND")
		visual.healthbar = healthbar
		visual.castbar = castbar
		bars.healthbar = healthbar		-- For Threat Plates Compatibility
		bars.castbar = castbar			-- For Threat Plates Compatibility
		-- Parented to Health Bar - Lower Frame
		visual.healthborder = healthbar:CreateTexture(nil, "ARTWORK")
		visual.threatborder = healthbar:CreateTexture(nil, "ARTWORK")
		visual.highlight = healthbar:CreateTexture(nil, "OVERLAY")
		-- Parented to Extended - Middle Frame
		visual.raidicon = extended:CreateTexture(nil, "ARTWORK")
		visual.eliteicon = extended:CreateTexture(nil, "OVERLAY")
		visual.skullicon = extended:CreateTexture(nil, "OVERLAY")
		visual.target = extended:CreateTexture(nil, "BACKGROUND")
		visual.customtext = extended:CreateFontString(nil, "OVERLAY")
		visual.name  = extended:CreateFontString(nil, "OVERLAY")
		visual.level = extended:CreateFontString(nil, "OVERLAY")
		-- Cast Bar Frame - Highest Frame
		visual.castborder = castbar:CreateTexture(nil, "ARTWORK")
		visual.castnostop = castbar:CreateTexture(nil, "ARTWORK")
		visual.spellicon = castbar:CreateTexture(nil, "OVERLAY")
		visual.spelltext = castbar:CreateFontString(nil, "OVERLAY")
		-- Set Base Properties
		visual.raidicon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
		visual.highlight:SetAllPoints(visual.healthborder)
		visual.highlight:SetBlendMode("ADD")
		extended:SetFrameStrata("BACKGROUND")
		healthbar:SetFrameLevel(0)
		extended:SetFrameLevel(0)
		castbar:SetFrameLevel(0)
		castbar:Hide()
		castbar:SetStatusBarColor(1,.8,0)
		carrier:SetSize(16, 16)
		-- Default Fonts
		visual.customtext:SetFont(STANDARD_TEXT_FONT, 12, "NONE")
		visual.name:SetFont(STANDARD_TEXT_FONT, 12, "NONE")
		visual.level:SetFont(STANDARD_TEXT_FONT, 12, "NONE")
		visual.spelltext:SetFont(STANDARD_TEXT_FONT, 12, "NONE")

		-- Tidy Plates Frame References
		extended.regions = regions
		extended.bars = bars
		extended.visual = visual

		-- Allocate Tables
		extended.style,
		extended.unit,
		extended.unitcache,
		extended.stylecache,
		extended.widgets
			= {}, {}, {}, {}, {}

		extended.stylename = ""

   		-- Hook for Updates
		plate:HookScript("OnShow", OnShowNameplate )
		plate:HookScript("OnHide", OnHideNameplate )

		health:HookScript("OnValueChanged", SetUpdateHealth)
		health:HookScript("OnMinMaxChanged", SetUpdateHealth)

		cast:HookScript("OnShow", OnShowCastbar)
		cast:HookScript("OnHide", OnHideCastbar)
		cast:HookScript("OnValueChanged", OnUpdateCastbar)

		-- In 6.9.9, the 'health' object was hooked for OnShow and OnHide
		-- In 6.10, this has been changed to plate, to allow us to hide 'health' to gain some FPS
		if CompatibilityMode then
			carrier:SetPoint("CENTER", bargroup, "CENTER")
		end

		OnShowNameplate(plate)
	end

end

---------------------------------------------------------------------------------------------------------------------
-- Nameplate Script Handlers
---------------------------------------------------------------------------------------------------------------------
do

	-- UpdateUnitCache
	local function UpdateUnitCache() for key, value in pairs(unit) do unitcache[key] = value end end

	-- CheckNameplateStyle
	local function CheckNameplateStyle()
		if activetheme.SetStyle then
			stylename = activetheme.SetStyle(unit); extended.style = activetheme[stylename]
		else extended.style = activetheme; stylename = tostring(activetheme) end

		style = extended.style

		if extended.stylename ~= stylename then
			UpdateStyle()
			extended.stylename = stylename
			unit.style = stylename
		end

	end

	-- ProcessUnitChanges
	local function ProcessUnitChanges()
			-- Unit Cache
			unitchanged = false
			for key, value in pairs(unit) do
				if unitcache[key] ~= value then
					unitchanged = true
				end
			end

			-- Update Style/Indicators
			if unitchanged or (not style)then
				CheckNameplateStyle()
				UpdateIndicator_Standard()
				UpdateIndicator_HealthBar()
				UpdateIndicator_Target()
			end

			-- Update Widgets
			if activetheme.OnUpdate then activetheme.OnUpdate(extended, unit) end

			-- Update Delegates
			UpdateIndicator_ThreatGlow()
			UpdateIndicator_CustomAlpha()
			UpdateIndicator_CustomScaleText()

			-- Cache the old unit information
			UpdateUnitCache()
	end

	---------------------------------------------------------------------------------------------------------------------
	-- Create / Hide / Show Event Handlers
	---------------------------------------------------------------------------------------------------------------------

	-- OnShowNameplate
	function OnShowNameplate(plate)
		UpdateReferences(plate)

		carrier:Show()

		PlatesVisible[plate] = true
		wipe(extended.unit)
		wipe(extended.unitcache)

		unit.frame = extended
		unit.alpha = 0
		unit.isTarget = false
		unit.isMouseover = false
		extended.unitcache = ClearIndices(extended.unitcache)
		extended.stylename = ""
		extended.Active = true

		-- For Fading In
		PlatesFading[plate] = EnableFadeIn
		extended.requestedAlpha = 0
		extended.visibleAlpha = 0
		extended:Hide()		-- Yes, it seems counterintuitive, but...
		extended:SetAlpha(0)

		-- Graphics
		unit.isCasting = false
		visual.castbar:Hide()
		visual.highlight:Hide()
		regions.highlight:Hide()

		-- Widgets/Extensions
		if activetheme.OnInitialize then activetheme.OnInitialize(extended, activetheme) end

		-- Initial Data Gather
		-- 6.12.Beta3: Disabled initial Data Gather because certain units are showing up with Target Alpha on the first cycle.
		--UpdateUnitIdentity()
		--UpdateUnitContext(plate)
		--ProcessUnitChanges()

		plate.UpdateMe = true
	end


	-- OnHideNameplate
	function OnHideNameplate(plate)
		plate.extended:Hide()
		plate.carrier:Hide()

		UpdateReferences(plate)

		extended.Active = false

		PlatesVisible[plate] = nil
		if unit.guid then GUID[unit.guid] = nil end

		visual.castbar:Hide()
		visual.castbar:SetScript("OnUpdate", nil)
		unit.isCasting = false

		-- Remove anything from the function queue
		plate.UpdateMe = false

		for widgetname, widget in pairs(extended.widgets) do widget:Hide() end
	end

	-- OnUpdateNameplate
	function OnUpdateNameplate(plate)
		-- Gather Information
		UpdateReferences(plate)
		UpdateUnitIdentity()
		UpdateUnitContext(plate)

		ProcessUnitChanges()

		-- Keep Regions Hidden
		regions.level:Hide()
	end

	-- OnHealthUpdate
	function OnHealthUpdate(plate)
		UpdateUnitCondition(plate)
		ProcessUnitChanges()
		UpdateIndicator_HealthBar()		-- Just to be on the safe side
	end

     -- OnResetNameplate
	function OnResetNameplate(plate)
		local extended = plate.extended
		plate.UpdateMe = true
		extended.unitcache = ClearIndices(extended.unitcache)
		extended.stylename = ""
		OnShowNameplate(plate)
	end

end


---------------------------------------------------------------------------------------------------------------------
--  Unit Updates: Updates Unit Data, Requests indicator updates
---------------------------------------------------------------------------------------------------------------------
do
	-- Raid Icon Lookup table
	local RaidIconCoordinate = { --from GetTexCoord. input is ULx and ULy (first 2 values).
		[0]		= { [0]		= "STAR", [0.25]	= "MOON", },
		[0.25]	= { [0]		= "CIRCLE", [0.25]	= "SQUARE",	},
		[0.5]	= { [0]		= "DIAMOND", [0.25]	= "CROSS", },
		[0.75]	= { [0]		= "TRIANGLE", [0.25]	= "SKULL", }, }

	-- ColorToString: Converts a color to a string with a C- prefix (For Color Lookup)
	local function ColorToString(r,g,b) return "C"..math.floor((100*r) + 0.5)..math.floor((100*g) + 0.5)..math.floor((100*b) + 0.5) end


	-- Class Color Lookup Table
	local ClassReference = {}
	do
		for classname, color in pairs(RAID_CLASS_COLORS) do
			local r, g, b = color.r, color.g, color.b
			local colorstring = ColorToString(r, g, b)
			ClassReference[colorstring] = classname
		end
		ClassReference["C010060"] = "MONK"
	end

	-- GetUnitCombatStatus: Determines if a unit is in combat by checking the name text color
	local function GetUnitCombatStatus(r, g, b) return (r > .5 and g < .5) end

	-- GetUnitAggroStatus: Determines if a unit is attacking, by looking at aggro glow region
	local function GetUnitAggroStatus( threatRegion )
		if not  threatRegion:IsShown() then return "LOW", 0 end



		local red, green, blue, alpha = threatRegion:GetVertexColor()
		local opacity = threatRegion:GetVertexColor()


		if threatRegion:IsShown() and (alpha < .9 or opacity < .9) then
		--if threatRegion:IsShown() and alpha > .9 then
			print(unit.name, alpha, opacity)

		end


		if red > 0 then
			if green > 0 then
				if blue > 0 then return "MEDIUM", 1 end
				return "MEDIUM", 2
			end
			return "HIGH", 3
		end
	end

	-- GetUnitReaction: Determines the reaction, and type of unit from the health bar color
	local function GetUnitReaction(red, green, blue)
		if red < .01 then 	-- Friendly
			if blue < .01 and green > .99 then return "FRIENDLY", "NPC"
			elseif blue > .99 and green < .01 then return "FRIENDLY", "PLAYER"
			end
		elseif red > .99 then
			if blue < .01 and green > .99 then return "NEUTRAL", "NPC"
			elseif blue < .01 and green < .01 then return "HOSTILE", "NPC"
			end
		elseif red > .5 and red < .6 then
			if green > .5 and green < .6 and blue > .5 and blue < .6 then return "TAPPED", "NPC" end 	-- .533, .533, .99	-- Tapped Mob
		end
		return "HOSTILE", "PLAYER"
	end

	-- UpdateUnitIdentity: Updates Low-volatility Unit Data
	function UpdateUnitIdentity()
		unit.name = regions.name:GetText()
		unit.rawName = gsub(unit.name, " %(%*%)", "")

		unit.isBoss = regions.skullicon:IsShown()
		unit.isDangerous = unit.isBoss

		unit.isElite = regions.eliteicon:IsShown()						-- 6.0

		if bars.group:GetScale() > .9 then
			unit.platetype = 1
			unit.isTrivial = false; unit.isMini = false

		else
			unit.platetype = 2
			unit.isTrivial = true; unit.isMini = true

		end

		if unit.isBoss then
			unit.level = "??"
			unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue = 1, 0, 0
		else
			unit.level = regions.level:GetText()
			unit.levelcolorRed, unit.levelcolorGreen, unit.levelcolorBlue = regions.level:GetTextColor()
		end
	end


        -- UpdateUnitContext: Updates Target/Mouseover
	function UpdateUnitContext(plate)
		local guid

		UpdateReferences(plate)

		unit.isMouseover = plate.isMouseover

		if HasTarget then
			unit.alpha = plate.alpha
		else
			unit.alpha = 1
		end

		unit.isMouseover = isHighlighted(plate)

		unit.isTarget = HasTarget and unit.alpha == 1

		if unit.isMouseover then
			visual.highlight:Show()
			guid = UnitGUID("mouseover")
		else visual.highlight:Hide() end

		if unit.isTarget then
			guid = UnitGUID("target")
		end

		-- Update and verify guid
		if unit.guid then
			if guid and (unit.guid ~= guid) then
				GUID[unit.guid] = nil		-- Clear out old GUID
				GUID[guid] = plate			-- Update new GUID
				unit.guid = guid
			end
		else
			if guid then
				unit.guid = guid
				GUID[guid] = plate
			end
		end

		UpdateUnitCondition(plate)	-- This updates a bunch of properties
		if activetheme.OnContextUpdate then activetheme.OnContextUpdate(extended, unit) end
		if activetheme.OnUpdate then activetheme.OnUpdate(extended, unit) end
	end

	-- UpdateUnitCondition: High volatility data
	function UpdateUnitCondition(plate)
		UpdateReferences(plate)

		if InCombat then unit.threatSituation, unit.threatValue = GetUnitAggroStatus(regions.threatglow)
		else unit.threatSituation = "LOW"; unit.threatValue = 0 end

		unit.red, unit.green, unit.blue = bars.health:GetStatusBarColor()

		unit.reaction, unit.type = GetUnitReaction(unit.red, unit.green, unit.blue)
		unit.isInCombat = GetUnitCombatStatus(regions.name:GetTextColor())
		unit.class = ClassReference[ColorToString(unit.red, unit.green, unit.blue)] or "UNKNOWN"

		unit.health = tonumber(bars.health:GetValue()) or 0
		unit.healthmax = select(2, bars.health:GetMinMaxValues())

		unit.isMarked = regions.raidicon:IsShown() or false

		if unit.isMarked then
			local ux, uy = regions.raidicon:GetTexCoord()
			unit.raidIcon = RaidIconCoordinate[ux][uy]
		else unit.raidIcon = nil end

	end

	-- OnRequestWidgetUpdate: Calls Update on just the Widgets
	function OnRequestWidgetUpdate(plate)
		if not IsPlateShown(plate) then return end
		UpdateReferences(plate)
		if activetheme.OnContextUpdate then activetheme.OnContextUpdate(extended, unit) end
		if activetheme.OnUpdate then activetheme.OnUpdate(extended, unit) end
	end

	-- OnRequestDelegateUpdate: Updates just the delegate function indicators
	function OnRequestDelegateUpdate(plate)
			if not IsPlateShown(plate) then return end
			UpdateReferences(plate)
			UpdateIndicator_ThreatGlow()
			UpdateIndicator_CustomAlpha()
			UpdateIndicator_CustomScaleText()
	end

end		-- End of Nameplate/Unit Events


---------------------------------------------------------------------------------------------------------------------
-- Indicators: These functions update the color, texture, strings, and frames within a style.
---------------------------------------------------------------------------------------------------------------------
do
	local color = {}
	local threatborder, alpha, forcealpha, scale


	-- UpdateIndicator_HealthBar: Updates the value on the health bar
	function UpdateIndicator_HealthBar()
		visual.healthbar:SetMinMaxValues(bars.health:GetMinMaxValues())
		visual.healthbar:SetValue(bars.health:GetValue())
	end


	-- UpdateIndicator_Name:
	function UpdateIndicator_Name()
		visual.name:SetText(unit.name)

		-- Name Color
		if activetheme.SetNameColor then
			visual.name:SetTextColor(activetheme.SetNameColor(unit))
		else visual.name:SetTextColor(1,1,1,1) end
		--if activetheme.SetStatusbarWidthMatching then MatchTextWidth() end
	end


	-- UpdateIndicator_Level:
	function UpdateIndicator_Level()
		visual.level:SetText(unit.level)
		local tr, tg, tb = regions.level:GetTextColor()
		visual.level:SetTextColor(tr, tg, tb)
	end


	-- UpdateIndicator_ThreatGlow: Updates the aggro glow
	function UpdateIndicator_ThreatGlow()
		if not style.threatborder.show then return end
		threatborder = visual.threatborder
		if activetheme.SetThreatColor then

			threatborder:SetVertexColor(activetheme.SetThreatColor(unit) )
		else
			if InCombat and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
				local color = style.threatcolor[unit.threatSituation]
				threatborder:Show()
				threatborder:SetVertexColor(color.r, color.g, color.b, (color.a or 1))
			else threatborder:Hide() end
		end
	end


	-- UpdateIndicator_Target
	function UpdateIndicator_Target()
		if unit.isTarget and style.target.show then visual.target:Show() else visual.target:Hide() end
	end


	-- UpdateIndicator_RaidIcon
	function UpdateIndicator_RaidIcon()
		if unit.isMarked and style.raidicon.show then
			visual.raidicon:Show()
			visual.raidicon:SetTexCoord(regions.raidicon:GetTexCoord())
		else visual.raidicon:Hide() end
	end


	-- UpdateIndicator_EliteIcon: Updates the border overlay art and threat glow to Elite or Non-Elite art
	function UpdateIndicator_EliteIcon()
		threatborder = visual.threatborder
		if unit.isElite and style.eliteicon.show then visual.eliteicon:Show() else visual.eliteicon:Hide() end
	end


	-- UpdateIndicator_UnitColor: Update the health bar coloring, if needed
	function UpdateIndicator_UnitColor()
		-- Set Health Bar
		if activetheme.SetHealthbarColor then
			visual.healthbar:SetAllColors(activetheme.SetHealthbarColor(unit))
		else visual.healthbar:SetStatusBarColor(bars.health:GetStatusBarColor()) end
		-- Name Color
		if activetheme.SetNameColor then
			visual.name:SetTextColor(activetheme.SetNameColor(unit))
		else visual.name:SetTextColor(1,1,1,1) end
	end


	-- UpdateIndicator_Standard: Updates Non-Delegate Indicators
	function UpdateIndicator_Standard()
		if IsPlateShown(nameplate) then
			if unitcache.name ~= unit.name then UpdateIndicator_Name() end
			if unitcache.level ~= unit.level then UpdateIndicator_Level() end
			UpdateIndicator_RaidIcon()
			if unitcache.isElite ~= unit.isElite then UpdateIndicator_EliteIcon() end
		end
	end


	-- UpdateIndicator_CustomAlpha: Calls the alpha delegate to get the requested alpha
	function UpdateIndicator_CustomAlpha(event)
		if activetheme.SetAlpha then
			local previousAlpha = extended.requestedAlpha
			extended.requestedAlpha = activetheme.SetAlpha(unit) or previousAlpha or unit.alpha or 1
		else
			extended.requestedAlpha = unit.alpha or 1
		end

		if extended.requestedAlpha > 0 then
			if nameplate:IsShown() then extended:Show() end
		else
			extended:Hide()        -- FRAME HIDE TEST
		end

		-- Better Layering
		if unit.isTarget then
			extended:SetFrameLevel(3)
		elseif unit.isMouseover then
			extended:SetFrameLevel(2)
		else
			extended:SetFrameLevel(0)
		end
	end


	-- UpdateIndicator_CustomScaleText: Updates indicators for custom text and scale
	function UpdateIndicator_CustomScaleText()
		threatborder = visual.threatborder

		if unit.health and (extended.requestedAlpha > 0) then
			-- Scale
			if activetheme.SetScale then
				scale = activetheme.SetScale(unit)
				if scale then extended:SetScale( scale )end
			end

			-- Set Special-Case Regions
			if style.customtext.show then
				if activetheme.SetCustomText then
					local text, r, g, b, a = activetheme.SetCustomText(unit)
					visual.customtext:SetText( text or "")
					visual.customtext:SetTextColor(r or 1, g or 1, b or 1, a or 1)
				else visual.customtext:SetText("") end
			end

			UpdateIndicator_UnitColor()
		end
	end


    -- OnUpdateCastbar
	function OnUpdateCastbar(bar)
		UpdateReferences(bar.parentPlate)
		local castbar = visual.castbar
		local r, g, b, a = 1, .8, 0, 1

		unit.isCasting = true
		if regions.spelltext then unit.spellName = regions.spelltext:GetText() end
		unit.spellIsShielded = regions.castnostop:IsShown()
		unit.spellInterruptible = not unit.spellIsShielded

		if activetheme.SetCastbarColor then
			r, g, b, a = activetheme.SetCastbarColor(unit)
			if not (r and g and b and a) then return end
		end

		castbar:SetValue( bar:GetValue())
		castbar:SetMinMaxValues(bar:GetMinMaxValues())
		castbar:SetStatusBarColor( r, g, b)
		castbar:SetAlpha(a or 1)

		visual.spelltext:SetText(unit.spellName)

		visual.spellicon:SetTexture(regions.spellicon:GetTexture())

		if unit.spellIsShielded then
			   visual.castnostop:Show(); visual.castborder:Hide()
		else visual.castnostop:Hide(); visual.castborder:Show() end
	end


	-- OnShowCastbar
	function OnShowCastbar(bar)
		UpdateReferences(bar.parentPlate)
		local castbar = extended.visual.castbar

		if not unit.health then return end

		OnUpdateCastbar(bar)
		castbar:Show()
		regions.spellshadow:Hide()
		UpdateIndicator_CustomScaleText()
		UpdateIndicator_CustomAlpha()
	end


	-- OnHideCastbar
	function OnHideCastbar(bar)
		UpdateReferences(bar.parentPlate)

		if not unit.health then return end

		local castbar = extended.visual.castbar

		castbar:Hide()
		unit.isCasting = false
		UpdateIndicator_CustomScaleText()
		UpdateIndicator_CustomAlpha()
	end

end -- End Indicator section


--------------------------------------------------------------------------------------------------------------
-- WoW Event Handlers: sends event-driven changes to the appropriate gather/update handler.
--------------------------------------------------------------------------------------------------------------
do
	local events = {}
	local function EventHandler(self, event, ...)
		events[event](event, ...)
	end

	local TidyPlatesCore = CreateFrame("Frame", nil, WorldFrame)
	TidyPlatesCore:SetFrameStrata("TOOLTIP") 	-- When parented to WorldFrame, causes OnUpdate handler to run close to last
	TidyPlatesCore:SetScript("OnEvent", EventHandler)

	-- Events
	function events:PLAYER_ENTERING_WORLD() TidyPlatesCore:SetScript("OnUpdate", OnUpdate); end
	function events:PLAYER_REGEN_ENABLED() InCombat = false; SetUpdateAll() end
	function events:PLAYER_REGEN_DISABLED() InCombat = true; SetUpdateAll() end

	-- 6.0
	function events:PLAYER_TARGET_CHANGED() HasTarget = UnitExists("target") == true; 	SetUpdateAll() 	end

	function events:RAID_TARGET_UPDATE() SetUpdateAll() end
	function events:UNIT_THREAT_SITUATION_UPDATE() SetUpdateAll() end  -- Only fired when a target changes
	function events:UNIT_LEVEL() SetUpdateAll() end
	function events:PLAYER_CONTROL_LOST() SetUpdateAll() end
	events.PLAYER_CONTROL_GAINED = events.PLAYER_CONTROL_LOST
	events.UNIT_FACTION = events.PLAYER_CONTROL_LOST

	-- Registration of Blizzard Events
	for eventname in pairs(events) do TidyPlatesCore:RegisterEvent(eventname) end
	--TidyPlates.TidyPlatesCore = TidyPlatesCore
end


---------------------------------------------------------------------------------------------------------------------
--  Nameplate Styler: These functions parses the definition table for a nameplate's requested style.
---------------------------------------------------------------------------------------------------------------------
do
	-- Helper Functions
	local function SetObjectShape(object, width, height) object:SetWidth(width); object:SetHeight(height) end
	local function SetObjectFont(object,  font, size, flags) if not object:SetFont(font, size, flags) then object:SetFont("FONTS\\ARIALN.TTF", size or 12, flags) end end
	local function SetObjectJustify(object, horz, vert) object:SetJustifyH(horz); object:SetJustifyV(vert) end
	local function SetObjectAnchor(object, anchor, anchorTo, x, y) object:ClearAllPoints();object:SetPoint(anchor, anchorTo, anchor, x, y) end
	local function SetObjectTexture(object, texture) object:SetTexture(texture) end
	local function SetObjectBartexture(obj, tex, ori, crop) obj:SetStatusBarTexture(tex); obj:SetOrientation(ori); end

	-- SetObjectShadow:
	local function SetObjectShadow(object, shadow)
		if shadow then
			object:SetShadowColor(0,0,0, tonumber(shadow) or 1)
			object:SetShadowOffset(.5, -.5)
		else object:SetShadowColor(0,0,0,0) end
	end

	-- SetFontGroupObject
	local function SetFontGroupObject(object, objectstyle)
		if objectstyle then
			SetObjectFont(object, objectstyle.typeface or "FONTS\\ARIALN.TTF",  objectstyle.size or 12, objectstyle.flags or "NONE")
			SetObjectJustify(object, objectstyle.align or "CENTER", objectstyle.vertical or "BOTTOM")
			SetObjectShadow(object, objectstyle.shadow or 1)
		end
	end

	-- SetAnchorGroupObject
	local function SetAnchorGroupObject(object, objectstyle, anchorTo)
		if objectstyle and anchorTo then
			SetObjectShape(object, objectstyle.width or 128, objectstyle.height or 16) --end
			SetObjectAnchor(object, objectstyle.anchor or "CENTER", anchorTo, objectstyle.x or 0, objectstyle.y or 0)
		end
	end

	-- SetTextureGroupObject
	local function SetTextureGroupObject(object, objectstyle)
		if objectstyle then
			if objectstyle.texture then SetObjectTexture(object, objectstyle.texture or EMPTY_TEXTURE) end
			object:SetTexCoord(objectstyle.left or 0, objectstyle.right or 1, objectstyle.top or 0, objectstyle.bottom or 1)
		end
	end


	-- SetBarGroupObject
	local function SetBarGroupObject(object, objectstyle, anchorTo)
		if objectstyle then
			SetAnchorGroupObject(object, objectstyle, anchorTo)
			SetObjectBartexture(object, objectstyle.texture or EMPTY_TEXTURE, objectstyle.orientation or "HORIZONTAL")
			if objectstyle.backdrop then
				object:SetBackdropTexture(objectstyle.backdrop)
			end
			object:SetTexCoord(objectstyle.left, objectstyle.right, objectstyle.top, objectstyle.bottom)
		end
	end

	-- Style Groups
	local fontgroup = {"name", "level", "spelltext", "customtext"}

	local anchorgroup = {"healthborder", "threatborder", "castborder", "castnostop",
						"name",  "spelltext", "customtext", "level",
						"spellicon", "raidicon", "skullicon", "eliteicon", "target"}

	local bargroup = {"castbar", "healthbar"}

	local texturegroup = { "castborder", "castnostop", "healthborder", "threatborder", "eliteicon",
						"skullicon", "highlight", "target", "spellicon", }


	-- UpdateStyle:
	function UpdateStyle()
		local index
		local objectstyle, objectname, objectregion, objectenable

		-- Frame
		SetAnchorGroupObject(extended, style.frame, carrier)

		-- Anchorgroup
		for index = 1, #anchorgroup do
			objectname = anchorgroup[index]; SetAnchorGroupObject(visual[objectname], style[objectname], extended)
			objectenable = style[objectname].show
			if objectenable then visual[objectname]:Show() else visual[objectname]:Hide() end
		end
		-- Bars
		for index = 1, #bargroup do objectname = bargroup[index]; SetBarGroupObject(visual[objectname], style[objectname], extended) end
		-- Texture
		for index = 1, #texturegroup do objectname = texturegroup[index]; SetTextureGroupObject(visual[objectname], style[objectname]) end
		-- Raid Icon Texture
		visual.raidicon:SetTexture(style.raidicon.texture)
		-- Font Group
		for index = 1, #fontgroup do objectname = fontgroup[index];SetFontGroupObject(visual[objectname], style[objectname]) end
		-- Hide Stuff
		if unit.isElite then visual.eliteicon:Hide() else visual.eliteicon:Hide() end
		if unit.isBoss then visual.level:Hide() else visual.skullicon:Hide() end
		if not unit.isTarget then visual.target:Hide() end
		if not unit.isMarked then visual.raidicon:Hide() end

	end


end

--------------------------------------------------------------------------------------------------------------
-- External Commands: Allows widgets and themes to request updates to the plates.
-- Useful to make a theme respond to externally-captured data (such as the combat log)
--------------------------------------------------------------------------------------------------------------
function TidyPlates:ForceUpdate() ForEachPlate(OnResetNameplate) end
function TidyPlates:Update() SetUpdateAll() end
function TidyPlates:RequestWidgetUpdate(plate) if plate then SetUpdateMe(plate) else SetUpdateAll() end end
function TidyPlates:RequestDelegateUpdate(plate) if plate then SetUpdateMe(plate) else SetUpdateAll() end end
function TidyPlates:ActivateTheme(theme) if theme and type(theme) == 'table' then TidyPlates.ActiveThemeTable, activetheme = theme, theme; ResetPlates = true; end end
function TidyPlates:EnableFadeIn() EnableFadeIn = true; end
function TidyPlates:DisableFadeIn() EnableFadeIn = nil; end
function TidyPlates:EnableCompatibilityMode() CompatibilityMode = true; end
TidyPlates.NameplatesByGUID, TidyPlates.NameplatesAll, TidyPlates.NameplatesByVisible = GUID, Plates, PlatesVisible





