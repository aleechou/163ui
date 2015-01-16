

unit.health
unit.healthMax
--[[

	- Aura Widget
	- Threat Widget
	(No Range Widget)
--]]





TidyPlatesHubTargetFrame = CreateFrame(nil, "Frame")



local function CreateFauxNameplate(parent)

		local carrier = CreateFrame("Frame", frameName, WorldFrame)
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

		-- In 6.9.9, the 'health' object was hooked for OnShow and OnHide
		-- In 6.10, this has been changed to plate, to allow us to hide 'health' to gain some FPS
		carrier:SetPoint("CENTER", bargroup, "CENTER")
	end


-- Steal Styler Function
-- Monolithic Update Function
-- Monolithic Gather





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
			if (not unit.guid) then
				unit.guid = UnitGUID("mouseover")
				if unit.guid then GUID[unit.guid] = plate end
			end
		else visual.highlight:Hide() end

		if unit.isTarget then
			if not unit.guid then
				-- UpdateCurrentGUID
				unit.guid = UnitGUID("target")
				if unit.guid then GUID[unit.guid] = plate end
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