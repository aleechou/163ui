--[[

- Create Artificial Plate Frame
- Create Styler Function
- Create Data Gather Function

--]]

------------------------------------------------------------------------------------------------------------------------------

local function CreateTargetPlate()
		local extended = CreateFrame("Frame", nil, WorldFrame)

        -- Add Graphical Elements
		local visual = {}
		-- Status Bars
		local healthbar = CreateTidyPlatesStatusbar(extended)
		local castbar = CreateTidyPlatesStatusbar(extended)
		healthbar:SetFrameStrata("BACKGROUND")
		castbar:SetFrameStrata("BACKGROUND")
		visual.healthbar = healthbar
		visual.castbar = castbar
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

		-- Default Fonts
		visual.customtext:SetFont(STANDARD_TEXT_FONT, 12, "NONE")
		visual.name:SetFont(STANDARD_TEXT_FONT, 12, "NONE")
		visual.level:SetFont(STANDARD_TEXT_FONT, 12, "NONE")
		visual.spelltext:SetFont(STANDARD_TEXT_FONT, 12, "NONE")

		extended.visual = visual
		return extended
end


local function UpdateTargetPlate(frame, unitid)
	local visual = frame.visual
	local healthbar = visual.healthbar

	visual.name:SetText(UnitName(unitid))

	-- Health Bar
	visual.healthbar:SetMinMaxValues(0,UnitHealthMax(unitid))
	visual.healthbar:SetValue(UnitHealth(unitid))
	healthbar:SetAllColors(UnitSelectionColor(unitid))

	-- Icons
	visual.raidicon:Hide()
	visual.eliteicon:Hide()
	visual.skullicon:Hide()

	-- Target
	visual.target:Hide()
	visual.highlight:Hide()

	-- Threat
	visual.threatborder:Hide()
end




------------------------------------------------------------------------------------------------------------------------------


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
	local function UpdateStyle(extended, style)
		local index
		local visual = extended.visual
		local objectstyle, objectname, objectregion, objectenable

		-- Frame
		--SetAnchorGroupObject(extended, style.frame, carrier)

		-- Anchorgroup
		for index = 1, #anchorgroup do
			objectname = anchorgroup[index]; SetAnchorGroupObject(visual[objectname], style[objectname], extended)
			--objectenable = style[objectname].show
			--if objectenable then visual[objectname]:Show() else visual[objectname]:Hide() end
			visual[objectname]:Show()
		end
		-- Bars
		for index = 1, #bargroup do objectname = bargroup[index]; SetBarGroupObject(visual[objectname], style[objectname], extended) end
		-- Texture
		for index = 1, #texturegroup do objectname = texturegroup[index]; SetTextureGroupObject(visual[objectname], style[objectname]) end
		-- Raid Icon Texture
		--visual.raidicon:SetTexture(style.raidicon.texture)
		-- Font Group
		for index = 1, #fontgroup do objectname = fontgroup[index];SetFontGroupObject(visual[objectname], style[objectname]) end
		-- Hide Stuff
		--if unit.isElite then visual.eliteicon:Hide() else visual.eliteicon:Hide() end
		--if unit.isBoss then visual.level:Hide() else visual.skullicon:Hide() end
		--if not unit.isTarget then visual.target:Hide() end
		--if not unit.isMarked then visual.raidicon:Hide() end

	end




------------------------------------------------------------------------------------------------------------------------------

local TargetPlate = CreateTargetPlate()
TargetPlate:SetSize(175, 80)
TargetPlate:SetScript("OnDragStart", function(self, button) self:SetAlpha(.9); if button =="LeftButton" then self:StartMoving() end end)
TargetPlate:SetScript("OnDragStop", function(self, button) self:SetAlpha(1); self:StopMovingOrSizing() end)


local AuraWidget = TidyPlatesWidgets.CreateAuraWidget(TargetPlate)

AuraWidget:SetPoint("BOTTOM", TargetPlate, "TOP", 0, 0) --15, 20)
--AuraWidget:SetFrameLevel(plate:GetFrameLevel()+1)


function TestTargetStyle()
	--		/run TestTargetStyle()

	local DamageThemeName = "Neon/|cFFFF4400Damage"
	local theme = TidyPlatesThemeList[DamageThemeName]
	local style = theme["Default"]

	UpdateStyle(TargetPlate, style)

	TargetPlate:SetPoint("CENTER", WorldFrame, "CENTER")
	TargetPlate:SetClampedToScreen(true)
	TargetPlate:RegisterForDrag("LeftButton")
	TargetPlate:EnableMouse(true)
	TargetPlate:SetMovable(true)
	TargetPlate:Show()

	UpdateTargetPlate(TargetPlate, "player")
	AuraWidget:UpdateTarget("player")
end




