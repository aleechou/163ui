local pairs,n2s,type,wipe,UnitGUID,tinsert = pairs,n2s,type,wipe,UnitGUID,tinsert
--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
----------------------------------------------------------------------]]

local GRID, Grid = ...
local L = Grid.L

local GridStatus

local media = LibStub("LibSharedMedia-3.0", true)
if media then
	media:Register("statusbar", "Blizzard Raid Bar", "Interface\\RaidFrame\\Raid-Bar-Hp-Fill")
	media:Register("statusbar", "Gradient", "Interface\\Addons\\Grid\\gradient32x32")
end

local GridFrame = Grid:NewModule("GridFrame", "AceBucket-3.0", "AceTimer-3.0")

local format, gsub, pairs, tonumber, type = format, gsub, pairs, tonumber, type

------------------------------------------------------------------------

local SecureButton_GetModifiedUnit = SecureButton_GetModifiedUnit

local function GridFrame_OnShow(self)
	GridFrame:SendMessage("UpdateFrameUnits")
	GridFrame:SendMessage("Grid_UpdateLayoutSize")
end

local function GridFrame_OnAttributeChanged(self, name, value)
	if name == "unit" then
		GridFrame:SendMessage("UpdateFrameUnits")
	elseif name == "type1" and (not value or value == "") and self:CanChangeAttribute() then
		self:SetAttribute("type1", "target")
	end
end

GridFrame.InitialConfigFunction = function(self)
	GridFrame:RegisterFrame(self)

	self:SetScript("OnShow", GridFrame_OnShow)
	self:SetScript("OnAttributeChanged", GridFrame_OnAttributeChanged)
end

------------------------------------------------------------------------

GridFrame.prototype = { }

function GridFrame:InitializeFrame(frame)
	-- set media based on shared media
	local font = media and media:Fetch("font", self.db.profile.font) or STANDARD_TEXT_FONT
	local texture = media and media:Fetch("statusbar", self.db.profile.texture) or "Interface\\Addons\\Grid\\gradient32x32"

	for k, v in pairs(self.prototype) do
		frame[k] = v
	end

	frame:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")

	-- set our left-click action
	if frame:CanChangeAttribute() then
		frame:SetAttribute("*type1", "target")
	end

	-- tooltip support, use HookScript in case our template defined OnEnter/OnLeave
	frame:HookScript("OnEnter", frame.OnEnter)
	frame:HookScript("OnLeave", frame.OnLeave)

	-- create border
	frame:SetBackdrop({
		bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 8,
		edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = 1,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	})
	frame:SetBackdropBorderColor(0,0,0,0)
	frame:SetBackdropColor(0,0,0,1)

	-- create bar BG (which users will think is the real bar, as it is the one that has a shiny color)
	-- this is necessary as there's no other way to implement status bars that grow in the other direction than normal
	frame.BarBG = frame:CreateTexture()
	frame.BarBG:SetTexture(texture)
	frame.BarBG:SetVertexColor(0, 0, 0, 1)
	frame.BarBG:SetPoint("CENTER", frame, "CENTER")

	-- create healing bar
	frame.HealingBar = CreateFrame("StatusBar", nil, frame)
	frame.HealingBar:SetFrameLevel(frame:GetFrameLevel() + 1)
	frame.HealingBar:SetStatusBarTexture(texture)

	local bar_texture = frame.HealingBar:GetStatusBarTexture()
	if bar_texture then
		bar_texture:SetHorizTile(false)
		bar_texture:SetVertTile(false)
	end

	frame.HealingBar:SetOrientation("VERTICAL")
	frame.HealingBar:SetMinMaxValues(0, 100)
	frame.HealingBar:SetValue(0)
	frame.HealingBar:SetStatusBarColor(0, 0, 0, 0)
	frame.HealingBar:SetPoint("TOPLEFT", frame.BarBG, "TOPLEFT")
	frame.HealingBar:SetPoint("BOTTOMRIGHT", frame.BarBG, "BOTTOMRIGHT")

	-- create bar
	frame.Bar = CreateFrame("StatusBar", nil, frame)
	frame.Bar:SetFrameLevel(frame:GetFrameLevel() + 2)
	frame.Bar:SetStatusBarTexture(texture)

	bar_texture = frame.Bar:GetStatusBarTexture()
	if bar_texture then
		bar_texture:SetHorizTile(false)
		bar_texture:SetVertTile(false)
	end

	frame.Bar:SetOrientation("VERTICAL")
	frame.Bar:SetMinMaxValues(0,100)
	frame.Bar:SetValue(100)
	frame.Bar:SetStatusBarColor(0,0,0,0.8)
	frame.Bar:SetPoint("TOPLEFT", frame.HealingBar, "TOPLEFT")
	frame.Bar:SetPoint("BOTTOMRIGHT", frame.HealingBar, "BOTTOMRIGHT")

	-- create center text
	frame.Text = frame.Bar:CreateFontString(nil, "ARTWORK")
	frame.Text:SetFontObject(GameFontHighlightSmall)
	frame.Text:SetFont(font, GridFrame.db.profile.fontSize, GridFrame.db.profile.fontOutline)
	frame.Text:SetJustifyH("CENTER")
	frame.Text:SetJustifyV("CENTER")
	frame.Text:SetPoint("BOTTOM", frame, "CENTER")

	-- create center text2
	frame.Text2 = frame.Bar:CreateFontString(nil, "ARTWORK")
	frame.Text2:SetFontObject(GameFontHighlightSmall)
	frame.Text2:SetFont(font, GridFrame.db.profile.fontSize, GridFrame.db.profile.fontOutline)
	frame.Text2:SetJustifyH("CENTER")
	frame.Text2:SetJustifyV("CENTER")
	frame.Text2:SetPoint("TOP", frame, "CENTER")
	frame.Text2:Hide()

	if not GridFrame.db.profile.fontShadow then
		frame.Text:SetShadowOffset(0, 0)
		frame.Text2:SetShadowOffset(0, 0)
	end

	if GridFrame.db.profile.invertBarColor and GridFrame.db.profile.invertTextColor then
		frame.Text:SetShadowColor(1, 1, 1)
		frame.Text2:SetShadowColor(1, 1, 1)
	else
		frame.Text:SetShadowColor(0, 0, 0)
		frame.Text2:SetShadowColor(0, 0, 0)
	end

	-- create icon background/border
	frame.IconBG = CreateFrame("Frame", nil, frame)
	frame.IconBG:SetWidth(GridFrame.db.profile.iconSize)
	frame.IconBG:SetHeight(GridFrame.db.profile.iconSize)
	frame.IconBG:SetPoint("CENTER", frame, "CENTER", GridFrame.db.profile.iconxoffset, GridFrame.db.profile.iconyoffset)
	frame.IconBG:SetBackdrop({
			-- bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 8,
			edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = 2,
			insets = { left = 2, right = 2, top = 2, bottom = 2 },
		})
	frame.IconBG:SetBackdropBorderColor(1, 1, 1, 1)
	frame.IconBG:SetBackdropColor(0, 0, 0, 0)
	frame.IconBG:SetFrameLevel(5)
	frame.IconBG:Hide()

	-- create icon
	frame.Icon = frame.IconBG:CreateTexture("Icon", "OVERLAY")
	frame.Icon:SetPoint("CENTER", frame.IconBG, "CENTER")
	frame.Icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	frame.Icon:SetTexture(1,1,1,0)

	-- create icon text
	frame.IconText = frame.IconBG:CreateFontString(nil, "OVERLAY")
	frame.IconText:SetAllPoints(frame.IconBG)
	frame.IconText:SetFontObject(GameFontHighlightSmall)
	frame.IconText:SetFont(font, GridFrame.db.profile.fontSize)
	frame.IconText:SetJustifyH("CENTER")
	frame.IconText:SetJustifyV("CENTER")

	-- create icon cooldown
	frame.IconCD = CreateFrame("Cooldown", nil, frame.IconBG, "CooldownFrameTemplate")
	frame.IconCD:SetAllPoints(frame.Icon)
	frame.IconCD:SetReverse(true)
	frame.IconCD:SetScript("OnHide", function()
		frame.IconStackText:SetParent(frame.IconBG)
		frame.IconStackText:SetPoint("BOTTOMRIGHT", frame.IconBG, 2, -2)
	end)

	-- create icon stack text
	frame.IconStackText = frame.IconBG:CreateFontString(nil, "OVERLAY")
	frame.IconStackText:SetPoint("BOTTOMRIGHT", frame.IconBG, 2, -2)
	frame.IconStackText:SetFontObject(GameFontHighlightSmall)
	frame.IconStackText:SetFont(font, GridFrame.db.profile.fontSize, "OUTLINE")
	frame.IconStackText:SetJustifyH("RIGHT")
	frame.IconStackText:SetJustifyV("BOTTOM")

	-- set texture
	frame:SetNormalTexture("")
	frame:EnableMouseoverHighlight(GridFrame.db.profile.enableMouseoverHighlight)

	if frame:CanChangeAttribute() then
		frame:SetAttribute("initial-width", self.db.profile.frameWidth)
		frame:SetAttribute("initial-height", self.db.profile.frameHeight)
	end

	frame:Reset()

	ClickCastFrames = ClickCastFrames or {}
	ClickCastFrames[frame] = true

	return frame
end

-- used by GridFrame:UpdateOptionsMenu()
GridFrame.prototype.indicators = {
	{ type = "border",		order = 1,  name = L["Border"] },
	{ type = "bar",			order = 2,  name = L["Health Bar"] },
	{ type = "barcolor",	order = 3,  name = L["Health Bar Color"] },
	{ type = "healingBar",	order = 4,  name = L["Healing Bar"] },
	{ type = "text",		order = 5,  name = L["Center Text"] },
	{ type = "text2",		order = 6,  name = L["Center Text 2"] },
	{ type = "icon",		order = 7,  name = L["Center Icon"] },
	{ type = "corner4",		order = 8,  name = L["Top Left Corner"] },
	{ type = "corner3",		order = 9,  name = L["Top Right Corner"] },
	{ type = "corner1",		order = 10, name = L["Bottom Left Corner"] },
	{ type = "corner2",		order = 11, name = L["Bottom Right Corner"] },
	{ type = "frameAlpha",	order = 12, name = L["Frame Alpha"] },
}

function GridFrame.prototype:Reset()
	for i = 1, #self.indicators do
		self:ClearIndicator(self.indicators[i].type)
	end
	self:SetBorderSize(GridFrame.db.profile.borderSize)
	self:SetOrientation(GridFrame.db.profile.orientation)
	self:SetTextOrientation(GridFrame.db.profile.textorientation)
	self:EnableText2(GridFrame.db.profile.enableText2)
	self:SetIconSize(GridFrame.db.profile.iconSize, GridFrame.db.profile.iconBorderSize)
	self:EnableMouseoverHighlight(GridFrame.db.profile.enableMouseoverHighlight)
	self:SetIconoffset(GridFrame.db.profile.iconxoffset, GridFrame.db.profile.iconyoffset)
	self:ResetRoleIconStyle()
end

-- shows the default unit tooltip
function GridFrame.prototype:OnEnter()
	local unit = self.unit
	local showTooltip = GridFrame.db.profile.showTooltip

	if unit and UnitExists(unit) and (showTooltip == "Always" or (showTooltip == "OOC" and (not InCombatLockdown() or UnitIsDeadOrGhost(unit)))) then
		UnitFrame_OnEnter(self)
	else
		self:OnLeave()
	end
end

function GridFrame.prototype:OnLeave()
	UnitFrame_OnLeave(self)
end

function GridFrame.prototype:SetFrameWidth(width)
	if not InCombatLockdown() then
		self:SetWidth(width)
	end

	local newWidth = width - (GridFrame.db.profile.borderSize + 1) * 2
	self.Bar:SetWidth(newWidth)
	self.BarBG:SetWidth(newWidth)
	self.HealingBar:SetWidth(newWidth)

	self:PlaceIndicators()
end

function GridFrame.prototype:SetFrameHeight(height)
	if not InCombatLockdown() then
		self:SetHeight(height)
	end

	local newHeight = height - (GridFrame.db.profile.borderSize + 1) * 2
	self.Bar:SetHeight(newHeight)
	self.BarBG:SetHeight(newHeight)
	self.HealingBar:SetHeight(newHeight)

	self:PlaceIndicators()
end

function GridFrame.prototype:SetOrientation(orientation)
	self.orientation = orientation
	self:PlaceIndicators()
end

function GridFrame.prototype:SetTextOrientation(textorientation)
	self.textorientation = textorientation
	self:PlaceIndicators()
end

function GridFrame.prototype:EnableText2(enabled)
	self.enableText2 = enabled
	self:PlaceIndicators()
end

function GridFrame.prototype:PlaceIndicators()
	if self.orientation == "HORIZONTAL" then
		self.Bar:SetOrientation("HORIZONTAL")
		self.HealingBar:SetOrientation("HORIZONTAL")
	else
		self.Bar:SetOrientation("VERTICAL")
		self.HealingBar:SetOrientation("VERTICAL")
	end

	if self.textorientation == "HORIZONTAL" then
		self.Text:SetJustifyH("LEFT")
		self.Text:SetJustifyV("CENTER")
		self.Text:SetHeight(self:GetHeight())
		self.Text:ClearAllPoints()
		self.Text:SetPoint("LEFT", self, "LEFT", 2, 0)
		if self.enableText2 then
			self.Text:SetWidth(self.Bar:GetWidth()/2)
		else
			self.Text:SetWidth(self.Bar:GetWidth())
		end

		self.Text2:SetHeight(self:GetHeight())
		self.Text2:SetWidth(self.Bar:GetWidth()/2)
		self.Text2:SetJustifyH("RIGHT")
		self.Text2:SetJustifyV("CENTER")
		self.Text2:ClearAllPoints()
		if self.enableText2 then
			self.Text2:SetPoint("RIGHT", self, "RIGHT", -2, 0)
		end
	else
		self.Text:SetJustifyH("CENTER")
		self.Text:SetJustifyV("CENTER")
		self.Text:SetWidth(self:GetWidth())
		self.Text:ClearAllPoints()
		if self.enableText2 then
			self.Text:SetHeight(self.Bar:GetHeight()/2)
			self.Text:SetPoint("BOTTOM", self, "CENTER")
		else
			self.Text:SetHeight(self.Bar:GetHeight())
			self.Text:SetPoint("CENTER", self, "CENTER")
		end

		self.Text2:SetHeight(self.Bar:GetHeight()/2)
		self.Text2:SetWidth(self:GetWidth())
		self.Text2:SetJustifyH("CENTER")
		self.Text2:SetJustifyV("CENTER")
		self.Text2:ClearAllPoints()
		if self.enableText2 then
			self.Text2:SetPoint("TOP", self, "CENTER", 0, 3)
		end
	end
end

function GridFrame.prototype:SetBorderSize(borderSize)
	local backdrop = self:GetBackdrop()

	backdrop.edgeSize = borderSize
	backdrop.insets.left = borderSize
	backdrop.insets.right = borderSize
	backdrop.insets.top = borderSize
	backdrop.insets.bottom = borderSize

	local r, g, b, a = self:GetBackdropBorderColor()

	self:SetBackdrop(backdrop)
	self:SetBackdropBorderColor(r, g, b, a)
	self:SetBackdropColor(0,0,0,1)

	self:SetFrameWidth(GridFrame.db.profile.frameWidth)
	self:SetFrameHeight(GridFrame.db.profile.frameHeight)

	self:PositionAllIndicators()
end

function GridFrame.prototype:SetCornerSize(size)
	for i = 1, 4 do
		local corner = "corner" .. i
		if self[corner] then
			self[corner]:SetHeight(size)
			self[corner]:SetWidth(size)
		end
	end
end

function GridFrame.prototype:SetIconSize(size, borderSize)
	if size == nil then
		size = GridFrame.db.profile.iconSize
	end
	if borderSize == nil then
		borderSize = GridFrame.db.profile.iconBorderSize
	end

	local r, g, b, a = self.IconBG:GetBackdropBorderColor()

	local backdrop = self.IconBG:GetBackdrop()
	backdrop.edgeSize = borderSize
	backdrop.insets.left = borderSize
	backdrop.insets.right = borderSize
	backdrop.insets.top = borderSize
	backdrop.insets.bottom = borderSize
	self.IconBG:SetBackdrop(backdrop)

	if borderSize == 0 then
		self.IconBG:SetBackdropBorderColor(0, 0, 0, 0)
	else
		self.IconBG:SetBackdropBorderColor(r, g, b, a)
	end

	self.IconBG:SetWidth(size + borderSize * 2)
	self.IconBG:SetHeight(size + borderSize * 2)

	self.Icon:SetWidth(size)
	self.Icon:SetHeight(size)
end

function GridFrame.prototype:EnableMouseoverHighlight(enabled)
	self:SetHighlightTexture(enabled and "Interface\\QuestFrame\\UI-QuestTitleHighlight" or nil)
end

function GridFrame.prototype:SetIconoffset(xoffset,yoffset)
	if not xoffset then xoffset = GridFrame.db.profile.iconxoffset end
	if not yoffset then yoffset = GridFrame.db.profile.iconyoffset end

	self.IconBG:SetPoint("CENTER", self, "CENTER", xoffset, yoffset)
end

function GridFrame.prototype:SetFrameFont(font, size, outline, shadow)
	self.Text:SetFont(font, size, outline)
	self.Text2:SetFont(font, size, outline)
	self.IconStackText:SetFont(font, size, "OUTLINE")

	self.Text:SetShadowOffset(0, 0)
	self.Text2:SetShadowOffset(0, 0)

	-- If you don't set the shadow offset to 0 before setting another value,
	-- the new value is ignored.

	if shadow then
		self.Text:SetShadowOffset(1, -1)
		self.Text2:SetShadowOffset(1, -1)
	end
end

function GridFrame.prototype:SetFrameTexture(texture)
	self.BarBG:SetTexture(texture)
	self.Bar:SetStatusBarTexture(texture)
	self.HealingBar:SetStatusBarTexture(texture)

	local bar_texture = self.Bar:GetStatusBarTexture()
	if bar_texture then
		bar_texture:SetHorizTile(false)
		bar_texture:SetVertTile(false)
	end
	bar_texture = self.HealingBar:GetStatusBarTexture()
	if bar_texture then
		bar_texture:SetHorizTile(false)
		bar_texture:SetVertTile(false)
	end
end

-- SetPoint for lazy people
function GridFrame.prototype:SetPosition(parentFrame, x, y)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", x, y)
end

function GridFrame.prototype:SetBar(value, max)
	if max == nil then
		max = 100
	end

	self.Bar:SetMinMaxValues(0, max)
	self.Bar:SetValue(value)

	local perc = value / max
	--print("SetBar", math.floor(perc * 100))

	local coord = (perc > 0 and perc <= 1) and perc or 1
	if GridFrame.db.profile.orientation == "VERTICAL" then
		self.Bar:GetStatusBarTexture():SetTexCoord(0, 1, 1 - coord, 1)
	else
		self.Bar:GetStatusBarTexture():SetTexCoord(0, coord, 0, 1)
	end
end

function GridFrame.prototype:SetHealingBar(value, max)
	if max == nil then
		max = 100
	end

	self.HealingBar:SetMinMaxValues(0, max)
	self.HealingBar:SetValue(value)

	local perc = value / max
	--print("SetHealingBar", math.floor(perc * 100))

	local coord = (perc > 0 and perc <= 1) and perc or 1
	if GridFrame.db.profile.orientation == "VERTICAL" then
		self.Bar:GetStatusBarTexture():SetTexCoord(0, 1, 1 - coord, 1)
	else
		self.Bar:GetStatusBarTexture():SetTexCoord(0, coord, 0, 1)
	end
end

function GridFrame.prototype:SetBarColor(r, g, b, a)
	--print("SetBarColor", math.floor(r*100)/100, math.floor(g*100)/100, math.floor(g*100)/100)
	if GridFrame.db.profile.invertBarColor then
		self.Bar:SetStatusBarColor(r, g, b, 1)
		self.BarBG:SetVertexColor(r * 0.2, g * 0.2, b * 0.2, 1)
	else
		self.Bar:SetStatusBarColor(r * 0.2, g * 0.2, b * 0.2, 1)
		self.BarBG:SetVertexColor(r, g, b, 1)
	end
end

function GridFrame.prototype:SetHealingBarColor(r, g, b, a)
	--print("SetHealingBarColor", math.floor(r*100)/100, math.floor(g*100)/100, math.floor(g*100)/100, GridFrame.db.profile.healingBar_intensity)
	if GridFrame.db.profile.invertBarColor then
		self.HealingBar:SetStatusBarColor(r, g, b, GridFrame.db.profile.healingBar_intensity)
	else
		local int = GridFrame.db.profile.healingBar_intensity
		self.HealingBar:SetStatusBarColor(r * int, g * int, b * int, int)
	end
end

function GridFrame.prototype:InvertBarColor()
	if GridFrame.db.profile.invertBarColor then
		self:SetBarColor(self.BarBG:GetVertexColor())

		local r, g, b = self.HealingBar:GetStatusBarColor()
		local int = GridFrame.db.profile.healingBar_intensity
		self:SetHealingBarColor(r / int, g / int, b / int)

		if GridFrame.db.profile.invertTextColor then
			r, g, b = self.Text:GetTextColor()
			self.Text:SetTextColor(r * 0.2, g * 0.2, b * 0.2)
			self.Text:SetShadowColor(1, 1, 1)

			r, g, b = self.Text2:GetTextColor()
			self.Text2:SetTextColor(r * 0.2, g * 0.2, b * 0.2)
			self.Text2:SetShadowColor(1, 1, 1)
		end
	else
		self:SetBarColor(self.Bar:GetStatusBarColor())

		if GridFrame.db.profile.invertTextColor then
			local r, g, b = self.Text:GetTextColor()
			self.Text:SetTextColor(r * 5, g * 5, b * 5)
			self.Text:SetShadowColor(0, 0, 0)

			r, g, b = self.Text2:GetTextColor()
			self.Text2:SetTextColor(r * 5, g * 5, b * 5)
			self.Text2:SetShadowColor(0, 0, 0)
		end
	end
end

function GridFrame.prototype:InvertTextColor()
	local r, g, b
	if GridFrame.db.profile.invertTextColor then
		r, g, b = self.Text:GetTextColor()
		self.Text:SetTextColor(r * 0.2, g * 0.2, b * 0.2)
		self.Text:SetShadowColor(1, 1, 1)

		r, g, b = self.Text2:GetTextColor()
		self.Text2:SetTextColor(r * 0.2, g * 0.2, b * 0.2)
		self.Text2:SetShadowColor(1, 1, 1)
	else
		r, g, b = self.Text:GetTextColor()
		self.Text:SetTextColor(r * 5, g * 5, b * 5)
		self.Text:SetShadowColor(0, 0, 0)

		r, g, b = self.Text2:GetTextColor()
		self.Text2:SetTextColor(r * 5, g * 5, b * 5)
		self.Text2:SetShadowColor(0, 0, 0)
	end
end

function GridFrame.prototype:SetText(text, color)
	local c = strbyte(text, 1)
	if(c and c >= 224 and text.utf8sub) then
		text = text:utf8sub(1, math.floor(GridFrame.db.profile.textlength / 2));
	else
		text = text:sub(1, GridFrame.db.profile.textlength)
	end
	self.Text:SetText(text)
	if text and text ~= "" then
		self.Text:Show()
	else
		self.Text:Hide()
	end
	if color then
		if GridFrame.db.profile.invertBarColor and GridFrame.db.profile.invertTextColor then
			self.Text:SetTextColor(color.r * 0.2, color.g * 0.2, color.b * 0.2, color.a or 1)
		else
			self.Text:SetTextColor(color.r, color.g, color.b, color.a or 1)
		end
	end
end

function GridFrame.prototype:SetText2(text, color)
	local c = strbyte(text, 1)
	if(c and c >= 224 and text.utf8sub) then
		text = text:utf8sub(1, math.floor(GridFrame.db.profile.textlength / 2));
	else
		text = text:sub(1, GridFrame.db.profile.textlength)
	end
	self.Text2:SetText(text)
	if text and text ~= "" then
		self.Text2:Show()
	else
		self.Text2:Hide()
	end
	if color then
		self.Text2:SetTextColor(color.r, color.g, color.b, color.a or 1)
	end
end

function GridFrame.prototype:CreateIndicator(indicator)
	local f = CreateFrame("Frame", nil, self)

	f:SetWidth(GridFrame.db.profile.cornerSize)
	f:SetHeight(GridFrame.db.profile.cornerSize)
	f:SetBackdrop({
		bgFile = "Interface\\BUTTONS\\WHITE8X8", tile = true, tileSize = 8,
		edgeFile = "Interface\\BUTTONS\\WHITE8X8", edgeSize = 1,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	})
	f:SetBackdropBorderColor(0,0,0,1)
	f:SetBackdropColor(1,1,1,1)
	f:SetFrameLevel(5)
	f:Hide()

	self[indicator] = f

	self:PositionIndicator(indicator)
end

function GridFrame.prototype:PositionIndicator(indicator)
	local f = self[indicator]
	if f then
		local borderSize = GridFrame.db.profile.borderSize
		-- position indicator wherever needed
		if indicator == "corner1" then
			-- bottom left
			f:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", borderSize, borderSize)
		elseif indicator == "corner2" then
			-- bottom right
			f:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -borderSize, borderSize)
		elseif indicator == "corner3" then
			-- top right
			f:SetPoint("TOPRIGHT", self, "TOPRIGHT", -borderSize, -borderSize)
		elseif indicator == "corner4" then
			-- top left
			f:SetPoint("TOPLEFT", self, "TOPLEFT", borderSize, -borderSize)
		end
	end
end

function GridFrame.prototype:PositionAllIndicators()
	for indicator in pairs(GridFrame.db.profile.statusmap) do
		self:PositionIndicator(indicator)
	end
end

local COLOR_WHITE = { r = 1, g = 1, b = 1, a = 1 }
local COORDS_FULL = { left = 0, right = 1, top = 0, bottom = 1 }

function GridFrame.prototype:SetIndicator(indicator, color, text, value, maxValue, texture, start, duration, stack, texCoords)
	if not color then
		color = COLOR_WHITE
	end
	if texture and not texCoords then
		texCoords = COORDS_FULL
	end

	if indicator == "border" then
		self:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
	elseif indicator == "corner1" or indicator == "corner2" or indicator == "corner3" or indicator == "corner4" then
		-- create indicator on demand if not available yet
		if not self[indicator] then
			self:CreateIndicator(indicator)
		end
		self[indicator]:SetBackdropColor(color.r, color.g, color.b, color.a or 1)
		self[indicator]:Show()
	elseif indicator == "text" then
		self:SetText(text, color)
	elseif indicator == "text2" then
		self:SetText2(text, color)
	elseif indicator == "frameAlpha" and type(color) == "table" and type(color.a) == "number" then
		for i = 1, 4 do
			local corner = "corner" .. n2s(i)
			if self[corner] then
				self[corner]:SetAlpha(color.a)
			end
		end
		self:SetAlpha(color.a)
	elseif indicator == "bar" then
		if value and maxValue then
			self:SetBar(value, maxValue)
		end
		if not GridFrame.db.profile.enableBarColor and type(color) == "table" then
			self:SetBarColor(color.r, color.g, color.b, color.a or 1)
			if not GridFrame.db.profile.healingBar_useStatusColor then
				self:SetHealingBarColor(color.r, color.g, color.b, color.a or 1)
			end
		end
	elseif indicator == "barcolor" then
		if GridFrame.db.profile.enableBarColor and type(color) == "table" then
			self:SetBarColor(color.r, color.g, color.b, color.a or 1)
			if not GridFrame.db.profile.healingBar_useStatusColor then
				self:SetHealingBarColor(color.r, color.g, color.b, color.a or 1)
			end
		end
	elseif indicator == "healingBar" then
		if value and maxValue then
			self:SetHealingBar(value, maxValue)
		end
		if GridFrame.db.profile.healingBar_useStatusColor and type(color) == "table" then
			self:SetHealingBarColor(color.r, color.g, color.b, color.a or 1)
		end
	elseif indicator == "icon" then
		if texture then
			if type(texture) == "table" then
				self.Icon:SetTexture(texture.r, texture.g, texture.b, texture.a or 1)
			else
				self.Icon:SetTexture(texture)
			end

			self.Icon:SetTexCoord(texCoords.left, texCoords.right, texCoords.top, texCoords.bottom)

			if type(color) == "table" then
				if not color.ignore then
					if GridFrame.db.profile.iconBorderSize > 0 then
						self.IconBG:SetBackdropBorderColor(color.r, color.g, color.b, color.a or 1)
					end
				else
					self.IconBG:SetBackdropBorderColor(0, 0, 0, 0)
				end
				self.Icon:SetAlpha(color.a or 1)
			else
				self.IconBG:SetBackdropBorderColor(0, 0, 0, 0)
				self.Icon:SetAlpha(1)
			end

			if type(duration) == "number" and duration > 0 and type(start) == "number" and start > 0 and GridFrame.db.profile.enableIconCooldown then
				self.IconCD:SetCooldown(start, duration)
				self.IconCD:Show()
				self.IconStackText:SetParent(self.IconCD)
				self.IconStackText:SetPoint("BOTTOMRIGHT", self.IconBG, 2, -2)
			else
				self.IconCD:Hide()
			end

			if tonumber(stack) and tonumber(stack) > 1 and GridFrame.db.profile.enableIconStackText then
				self.IconStackText:SetText(stack)
			else
				self.IconStackText:SetText("")
			end

			self.IconBG:Show()
			self.Icon:Show()
		else
			self.IconBG:Hide()
		end
	end
end

function GridFrame.prototype:ClearIndicator(indicator)
	if indicator == "border" then
		self:SetBackdropBorderColor(0, 0, 0, 0)
	elseif indicator == "corner1" or indicator == "corner2" or indicator == "corner3" or indicator == "corner4" then
		if self[indicator] then
			self[indicator]:SetBackdropColor(1, 1, 1, 1)
			self[indicator]:Hide()
		end
	elseif indicator == "text" then
		self:SetText("")
	elseif indicator == "text2" then
		self:SetText2("")
	elseif indicator == "frameAlpha" then
		for i = 1, 4 do
			local corner = "corner" .. i
			if self[corner] then
				self[corner]:SetAlpha(1)
			end
		end
		self:SetAlpha(1)
	elseif indicator == "bar" then
		self:SetBar(100)
		if not GridFrame.db.profile.enableBarColor then
			self:SetBarColor(0, 0, 0, 1)
		end
	elseif indicator == "barcolor" then
		if GridFrame.db.profile.enableBarColor then
			self:SetBarColor(0, 0, 0, 1)
		end
	elseif indicator == "healingBar" then
		self:SetHealingBar(0)
	elseif indicator == "icon" then
		self.Icon:SetTexture(1, 1, 1, 0)
		self.Icon:SetTexCoord(0, 1, 0, 1)
		self.IconText:SetText("")
		self.IconText:SetTextColor(1, 1, 1, 1)
		self.IconBG:Hide()
		self.IconStackText:SetText("")
		self.IconCD:Hide()
	end
end

------------------------------------------------------------------------

GridFrame.defaultDB = {
	frameHeight = 26,
	frameWidth = 46,
	borderSize = 1,
	cornerSize = 6,
	orientation = "HORIZONTAL",
	textorientation = "VERTICAL",
	enableText2 = true,
	enableBarColor = false,
	font = "Friz Quadrata TT",
	fontSize = 11,
	fontOutline = "NONE",
	fontShadow = true,
	texture = "Gradient",
	iconSize = 16,
	iconxoffset = -6,
	iconyoffset = -2,
	iconBorderSize = 0,
	enableIconStackText = true,
	enableIconCooldown = true,
	enableMouseoverHighlight = true,
	invertBarColor = false,
	invertTextColor = false,
	showTooltip = "OOC",
	textlength = 5,
	healingBar_intensity = 0.4,
	healingBar_useStatusColor = false,
	throttleUpdates = false,
    statusmap = {
        ["text"] = {
            --alert_death = true,
            --alert_feignDeath = true,
            --alert_heals = true,
            --alert_offline = true,
            --debuff_Ghost = true,
            --unit_healthDeficit = true,
            unit_name = true,
        },
        ["text2"] = {
            alert_death = true,
            alert_feignDeath = true,
            alert_offline = true,
            debuff_Ghost = true,

            --alert_heals = true,
            alert_voice = true,
            --alert_tothots = true,
            alert_renew = true,
            alert_rejuv = true,
            alert_regrow = true,
            alert_lifebl = true,
            --alert_wgrowth = true,
            alert_beacon = true,
            alert_riptide = true,
            alert_gracedurstack = true,
        },
        ["border"] = {
            --alert_lowHealth = true,
            --alert_lowMana = true,
            --player_target = true,
            alert_aggro = true,
            alert_banzai = true,
        },
        ["corner1"] = { --left-bottom
            alert_heals = true,
        },
        ["corner2"] = { --right-bottom
            unitIsHostile  = true,
        },
        ["corner3"] = { --right-upper
            --debuff_curse = true,
            --debuff_disease = true,
            --debuff_magic = true,
            --debuff_poison = true,
        },
        ["corner4"] = { --left-upper
            --alert_aggro = true,
        },
        ["frameAlpha"] = {
            --alert_death = true,
            --alert_offline = true,
            alert_range = true,
        },
        ["bar"] = {
            alert_death = true,
            alert_offline = true,
            debuff_Ghost = true,
            unit_health = true,
        },
        ["barcolor"] = {
            alert_death = true,
            alert_offline = true,
            debuff_Ghost = true,
            unit_health = true,
        },
        ["healingBar"] = {
            alert_heals = true,
        },
        ["icon"] = {
            --debuff_curse = true,
            --debuff_disease = true,
            --debuff_magic = true,
            --debuff_poison = true,
            ready_check = true,
            alert_death = true,
            debuff_Ghost = true,
            alert_RaidDebuff = true,
            alert_res163 = true,
        },
        ["manabar"] = {
            unit_mana = true,
        },
        ["icontop"] = {},
        ["iconbottom"] = {},
        ["iconright"] = {
            alert_tankcd = true,
        },
        ["iconleft"] = {
            alert_raidicons_player = true,
            alert_incoming = true,
        },
        ["cornertextbottomleft"] = {
            alert_threat_text = true,
            --["buff_"..GetSpellInfo(8936)] = true,
            --["buff_"..GetSpellInfo(17)] = true,
        },
        ["cornertexttopleft"] = {
            ["buff_"..GetSpellInfo(974)] = true,
            --["buff_"..GetSpellInfo(139)] = true,
            --["buff_"..GetSpellInfo(774)] = true,
        },
        ["cornertexttopright"] = {
            --["buff_"..GetSpellInfo(61295)] = true,
            --["buff_"..GetSpellInfo(33763)] = true,
            --["debuff_"..GetSpellInfo(61295)] = true,
        },
    },
}

------------------------------------------------------------------------

function GridFrame:Grid_ReloadLayout()
	self:SendMessage("Grid_ReloadLayout")
end

GridFrame.options = {
	type = "group",
	name = L["Frame"],
	desc = L["Options for GridFrame."],
	disabled = InCombatLockdown,
	args = {
        ["main"] = {
            type = "group",
            name = L["Main"],
            desc = L["Change the main frame options."],
            args = {
                    ["framewidth"] = {
                        name = L["Frame Width"],
                        desc = L["Adjust the width of each unit's frame."],
                        order = 1110, width = "double",
                        type = "range", min = 10, max = 100, step = 1,
                        get = function(info)
                            return GridFrame.db.profile.frameWidth
                        end,
                        set = function(info, v)
                            GridFrame.db.profile.frameWidth = v
                            GridFrame:ResizeAllFrames()
                            GridFrame:ScheduleTimer("Grid_ReloadLayout", 0.5)
                        end,
                    },
                    ["frameheight"] = {
                        name = L["Frame Height"],
                        desc = L["Adjust the height of each unit's frame."],
                        order = 1115, width = "double",
                        type = "range", min = 10, max = 100, step = 1,
                        get = function()
                            return GridFrame.db.profile.frameHeight
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.frameHeight = v
                            GridFrame:ResizeAllFrames()
                            GridFrame:ScheduleTimer("Grid_ReloadLayout", 0.5)
                        end,
                    },
                    ["bordersize"] = {
                        name = L["Border Size"],
                        desc = L["Adjust the size of the border indicators."],
                        order = 30, width = "double",
                        type = "range", min = 1, max = 9, step = 1,
                        get = function()
                            return GridFrame.db.profile.borderSize
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.borderSize = v
                            GridFrame:WithAllFrames(function(f) f:SetBorderSize(v) end)
                        end,
                    },
                    ["cornersize"] = {
                        name = L["Corner Size"],
                        desc = L["Adjust the size of the corner indicators."],
                        order = 40, width = "double",
                        type = "range", min = 1, max = 20, step = 1,
                        get = function()
                            return GridFrame.db.profile.cornerSize
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.cornerSize = v
                            GridFrame:WithAllFrames(function(f) f:SetCornerSize(v) end)
                        end,
                    },
                    ["tooltip"] = {
                        name = L["Show Tooltip"],
                        desc = L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."],
                        order = 50, width = "double",
                        type = "select",
                        values = { ["Always"] = L["Always"], ["Never"] = L["Never"], ["OOC"] = L["OOC"] },
                        get = function()
                            return GridFrame.db.profile.showTooltip
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.showTooltip = v
                        end,
                    },
                    ["orientation"] = {
                        name = L["Orientation of Frame"],
                        desc = L["Set frame orientation."],
                        order = 60, width = "double",
                        type = "select",
                        values = { ["VERTICAL"] = L["Vertical"], ["HORIZONTAL"] = L["Horizontal"] },
                        get = function()
                            return GridFrame.db.profile.orientation
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.orientation = v
                            GridFrame:WithAllFrames(function(f) f:SetOrientation(v) end)
                        end,
                    },
                    ["textorientation"] = {
                        name = L["Orientation of Text"],
                        desc = L["Set frame text orientation."],
                        order = 70, width = "double",
                        type = "select",
                        values = { ["VERTICAL"] = L["Vertical"], ["HORIZONTAL"] = L["Horizontal"] },
                        get = function()
                            return GridFrame.db.profile.textorientation
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.textorientation = v
                            GridFrame:WithAllFrames(function(f) f:SetTextOrientation(v) end)
                        end,
                    },
                    ["mouseoverhighlight"] = {
                        name = format(L["Enable Mouseover Highlight"]),
                        desc = L["Toggle mouseover highlight."],
                        order = 80, width = "double",
                        type = "toggle",
                        get = function()
                            return GridFrame.db.profile.enableMouseoverHighlight
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.enableMouseoverHighlight = v
                            GridFrame:WithAllFrames(function(f) f:EnableMouseoverHighlight(v) end)
                        end,
                    },
                    ["text2"] = {
                        name = format(L["Enable %s indicator"], L["Center Text 2"]),
                        desc = format(L["Toggle the %s indicator."], L["Center Text 2"]),
                        order = 100, width = "double",
                        type = "toggle",
                        get = function()
                            return GridFrame.db.profile.enableText2
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.enableText2 = v
                            GridFrame:WithAllFrames(function(f) f:EnableText2(v) end)
                            GridFrame:UpdateOptionsMenu()
                        end,
                    },
                    ["throttleUpdates"] = {
                        name = L["Throttle Updates"],
                        desc = L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."],
                        type = "toggle",
                        order = 110, width = "double",
                        get = function()
                            return GridFrame.db.profile.throttleUpdates
                        end,
                        set = function(_, v)
                            GridFrame.db.profile.throttleUpdates = v
                            if v then
                                GridFrame:UnregisterMessage("UpdateFrameUnits")
                                GridFrame.bucket_UpdateFrameUnits = GridFrame:RegisterBucketMessage("UpdateFrameUnits", 0.1)
                            else
                                GridFrame:RegisterMessage("UpdateFrameUnits")
                                GridFrame:UnregisterBucket(GridFrame.bucket_UpdateFrameUnits, true)
                                GridFrame.bucket_UpdateFrameUnits = nil
                            end
                            GridFrame:UpdateFrameUnits()
                        end,
                    },
            }
        },
		["bar"] = {
			name = L["Bar Options"],
			desc = L["Options related to bar indicators."],
			order = 200,
			type = "group", --inline = true,
			args = {
				["healingBar_intensity"] = {
					name = L["Healing Bar Opacity"],
					desc = L["Sets the opacity of the healing bar."],
					order = 20, width = "double",
					type = "range", min = 0, max = 1, step = 0.01, bigStep = 0.05,
					get = function()
						return GridFrame.db.profile.healingBar_intensity
					end,
					set = function(_, v)
						GridFrame.db.profile.healingBar_intensity = v
						GridFrame:UpdateAllFrames()
					end,
				},
				["healingBar_useStatusColor"] = {
					name = L["Healing Bar Uses Status Color"],
					desc = L["Make the healing bar use the status color instead of the health bar color."],
					order = 40, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.healingBar_useStatusColor
					end,
					set = function(_, v)
						GridFrame.db.profile.healingBar_useStatusColor = v
						GridFrame:UpdateAllFrames()
					end,
				},
				["barcolor"] = {
					name = format(L["Enable %s indicator"], L["Health Bar Color"]),
					desc = format(L["Toggle the %s indicator."], L["Health Bar Color"]),
					order = 30, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.enableBarColor
					end,
					set = function(_, v)
						GridFrame.db.profile.enableBarColor = v
						GridFrame:UpdateOptionsMenu()
					end,
				},
				["invertBarColor"] = {
					name = L["Invert Bar Color"],
					desc = L["Swap foreground/background colors on bars."],
					order = 50, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.invertBarColor
					end,
					set = function(_, v)
						GridFrame.db.profile.invertBarColor = v
						GridFrame:InvertBarColor()
					end,
				},
				["invertTextColor"] = {
					name = L["Invert Text Color"],
					desc = L["Darken the text color to match the inverted bar."],
					order = 50, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.invertTextColor
					end,
					set = function(_, v)
						GridFrame.db.profile.invertTextColor = v
						GridFrame:InvertTextColor()
					end,
					disabled = function()
						return not GridFrame.db.profile.invertBarColor
					end,
					hidden = function()
						return not GridFrame.db.profile.invertBarColor
					end,
				},
			},
		},
		["icon"] = {
			name = L["Icon Options"],
			desc = L["Options related to icon indicators."],
			order = 300, width = "double",
			type = "group", --inline = true,
			args = {
				["size"] = {
					name = L["Icon Size"],
					desc = L["Adjust the size of the center icon."],
					order = 10, width = "double",
					type = "range", min = 5, max = 50, step = 1,
					get = function()
						return GridFrame.db.profile.iconSize
					end,
					set = function(_, v)
						GridFrame.db.profile.iconSize = v
						local iconBorderSize = GridFrame.db.profile.iconBorderSize
						GridFrame:WithAllFrames(function(f) f:SetIconSize(v, iconBorderSize) end)
					end,
				},
				["bordersize"] = {
					name = L["Icon Border Size"],
					desc = L["Adjust the size of the center icon's border."],
					order = 20, width = "double",
					type = "range", min = 0, max = 9, step = 1,
					get = function()
						return GridFrame.db.profile.iconBorderSize
					end,
					set = function(_, v)
						GridFrame.db.profile.iconBorderSize = v
						local iconSize = GridFrame.db.profile.iconSize
						GridFrame:WithAllFrames(function(f) f:SetIconSize(iconSize, v) end)
						GridFrame:UpdateAllFrames()
					end,
				},
				["cooldown"] = {
					name = format(L["Enable %s"], L["Icon Cooldown Frame"]),
					desc = L["Toggle center icon's cooldown frame."],
					order = 30, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.enableIconCooldown
					end,
					set = function(_, v)
						GridFrame.db.profile.enableIconCooldown = v
						GridFrame:UpdateAllFrames()
					end,
				},
				["stacktext"] = {
					name = format(L["Enable %s"], L["Icon Stack Text"]),
					desc = L["Toggle center icon's stack count text."],
					order = 40, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.enableIconStackText
					end,
					set = function(_, v)
						GridFrame.db.profile.enableIconStackText = v
						GridFrame:UpdateAllFrames()
					end,
				},
				["xoffset"] = {
					name = L["Icon X offset"],
					desc = L["Adjust the offset of the X-axis for center icon."],
					order = 50, width = "double",
					type = "range", min = -30, max = 30, step = 1,
					get = function ()
						return GridFrame.db.profile.iconxoffset
				        end,
					set = function (_, v)
						GridFrame.db.profile.iconxoffset = v
						local iconyoffset = GridFrame.db.profile.iconyoffset
						GridFrame:WithAllFrames(function (f) f:SetIconoffset(v, iconyoffset) end)
				        end,
				},
				["yoffset"] = {
					name = L["Icon Y offset"],
					desc = L["Adjust the offset of the Y-axis for center icon."],
					order = 60, width = "double",
					type = "range", min = -15, max = 15, step = 1,
					get = function ()
						return GridFrame.db.profile.iconyoffset
				        end,
					set = function (_, v)
						GridFrame.db.profile.iconyoffset = v
						local iconxoffset = GridFrame.db.profile.iconxoffset
						GridFrame:WithAllFrames(function (f) f:SetIconoffset(iconxoffset, v) end)
					end,
				},				
			},
		},
		["text"] = {
			name = L["Text Options"],
			desc = L["Options related to text indicators."],
			order = 400,
			type = "group", --inline = true,
			args = {
				["size"] = {
					name = L["Font Size"],
					desc = L["Adjust the font size."],
					order = 20, width = "double",
					type = "range", min = 6, max = 24, step = 1,
					get = function()
						return GridFrame.db.profile.fontSize
					end,
					set = function(_, v)
						GridFrame.db.profile.fontSize = v
						local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT
						GridFrame:WithAllFrames(function(f) f:SetFrameFont(font, v, GridFrame.db.profile.fontOutline, GridFrame.db.profile.fontShadow) end)
					end,
				},
				["outline"] = {
					name = L["Font Outline"],
					desc = L["Adjust the font outline."],
					order = 30, width = "double",
					type = "select",
					values = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] },
					get = function()
						return GridFrame.db.profile.fontOutline
					end,
					set = function(_, v)
						GridFrame.db.profile.fontOutline = v
						local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT
						GridFrame:WithAllFrames(function(f) f:SetFrameFont(font, GridFrame.db.profile.fontSize, v, GridFrame.db.profile.fontShadow) end)
					end,
				},
				["shadow"] = {
					name = L["Font Shadow"],
					desc = L["Toggle the font drop shadow effect."],
					order = 40, width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.fontShadow
					end,
					set = function(_, v)
						GridFrame.db.profile.fontShadow = v
						local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT
						GridFrame:WithAllFrames(function(f) f:SetFrameFont(font, GridFrame.db.profile.fontSize, GridFrame.db.profile.fontOutline, v) end)
					end,
				},
				["length"] = {
					name = L["Center Text Length"],
					desc = L["Number of characters to show on Center Text indicator."],
					order = 50, width = "double",
					type = "range", min = 0, max = 20, step = 1,
					get = function() return GridFrame.db.profile.textlength end,
					set = function(_, v)
						GridFrame.db.profile.textlength = v
						GridFrame:UpdateAllFrames()
					end,
				},
			},
		},
        ["third"] = { type = "group", order = 500, name = "---------------", args = {}},
	},
}

if media then
	GridFrame.options.args.text.args.font = {
		name = L["Font"],
		desc = L["Adjust the font settings"],
		order = 10, width = "double",
		type = "select",
		values = media:HashTable("font"),
		dialogControl = "LSM30_Font",
		get = function()
			return GridFrame.db.profile.font
		end,
		set = function(_, v)
			GridFrame.db.profile.font = v
			local font = media:Fetch("font", v)
			GridFrame:WithAllFrames(function(f) f:SetFrameFont(font, GridFrame.db.profile.fontSize, GridFrame.db.profile.fontOutline, GridFrame.db.profile.fontShadow) end)
		end,
	}
	GridFrame.options.args.bar.args.texture = {
		name = L["Frame Texture"],
		desc = L["Adjust the texture of each unit's frame."],
		order = 10, width = "double",
		type = "select",
		values = media:HashTable("statusbar"),
		dialogControl = "LSM30_Statusbar",
		get = function()
			return GridFrame.db.profile.texture
		end,
		set = function(_, v)
			GridFrame.db.profile.texture = v
			local texture = media:Fetch("statusbar", v)
			GridFrame:WithAllFrames(function(f) f:SetFrameTexture(texture) end)
		end,
	}
end

Grid.options.args["Indicators"] = {
	name = L["Indicators"],
	desc = L["Options for assigning statuses to indicators."],
	type = "group", -- childGroups = "select",
	args = {
	}
}

------------------------------------------------------------------------

function GridFrame:PostInitialize()
	GridStatus = Grid:GetModule("GridStatus")

	self.frames = {}
	self.registeredFrames = {}
	self.guidFrameMap = {}
	self.hasMoreMap = false
	self.guidFrameMoreMap = {}
end

function GridFrame:OnEnable()
	self:RegisterMessage("Grid_StatusGained")
	self:RegisterMessage("Grid_StatusLost")

    --slow when turn on taintLog
	self:RegisterBucketMessage("Grid_StatusRegistered", 0.2, "UpdateOptionsMenu")
	self:RegisterBucketMessage("Grid_StatusUnregistered", 0.2, "UpdateOptionsMenu")

	self:RegisterMessage("Grid_ColorsChanged", "UpdateAllFrames")

	self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateFrameUnits")

	self:RegisterEvent("PLAYER_ROLES_ASSIGNED", "UpdateAllRoleIcons")
	self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateAllRoleIcons")

	self:RegisterEvent("UNIT_ENTERED_VEHICLE", "SendMessage_UpdateFrameUnits")
	self:RegisterEvent("UNIT_EXITED_VEHICLE", "SendMessage_UpdateFrameUnits")
	self:RegisterMessage("Grid_RosterUpdated", "SendMessage_UpdateFrameUnits")

	if self.db.profile.throttleUpdates then
		self.bucket_UpdateFrameUnits = self:RegisterBucketMessage("UpdateFrameUnits", 0.1)
	else
		self:RegisterMessage("UpdateFrameUnits")
	end

	if media then
		media.RegisterCallback(self, "LibSharedMedia_Registered", "LibSharedMedia_Update")
		media.RegisterCallback(self, "LibSharedMedia_SetGlobal", "LibSharedMedia_Update")
	end

	self:Reset()
end

function GridFrame:SendMessage_UpdateFrameUnits()
	self:SendMessage("UpdateFrameUnits")
end

function GridFrame:LibSharedMedia_Update(callback, type, handle)
 	if type == "font" then
 		self:WithAllFrames(function(f)
			f:SetFrameFont(media:Fetch("font", self.db.profile.font), self.db.profile.fontSize, GridFrame.db.profile.fontOutline, GridFrame.db.profile.fontShadow)
		end)
 	elseif type == "statusbar" then
 		self:WithAllFrames(function(f)
			f:SetFrameTexture(media:Fetch("statusbar", self.db.profile.texture))
		end)
	end
end

function GridFrame:OnDisable()
	self:Debug("OnDisable")
	-- should probably disable and hide all of our frames here
end

function GridFrame:PostReset()
	self:UpdateOptionsMenu()

	-- Fix for font size not updating on profile change
	-- Can probably be done better
	local font = media and media:Fetch("font", GridFrame.db.profile.font) or STANDARD_TEXT_FONT
	GridFrame:WithAllFrames(function(f) f:SetFrameFont(font, GridFrame.db.profile.fontSize, GridFrame.db.profile.fontOutline, GridFrame.db.profile.fontShadow) end)

	self:ResetAllFrames()
	self:UpdateFrameUnits()
	self:UpdateAllFrames()

	-- different fix for ticket #556, maybe fixes #603 too
	self:ResizeAllFrames()
	self:ScheduleTimer("Grid_ReloadLayout", 0.1)
end

------------------------------------------------------------------------

function GridFrame:RegisterFrame(frame)
	self:Debug("RegisterFrame", frame:GetName())

	self.registeredFrameCount = (self.registeredFrameCount or 0) + 1
	self.registeredFrames[frame:GetName()] = self:InitializeFrame(frame)
	self:UpdateFrameUnits()
end

function GridFrame:WithAllFrames(func)
	for _, frame in pairs(self.registeredFrames) do
		func(frame)
	end
end

function GridFrame:WithGUIDFrames(guid, func)
    local frame = self.guidFrameMap[guid]
    if frame then
        func(frame)
        if self.hasMoreMap then
            local list = self.guidFrameMoreMap[guid]
            if list and #list>0 then
                for i=1,#list do
                    func(list[i])
                end
            end
        end
    end
end

function GridFrame:ResetAllFrames()
	self:WithAllFrames(function(f)
		f:Reset()
	end)
	self:SendMessage("Grid_UpdateLayoutSize")
end

function GridFrame:ResizeAllFrames()
	self:WithAllFrames(function(f)
		f:SetFrameWidth(self.db.profile.frameWidth)
		f:SetFrameHeight(self.db.profile.frameHeight)
	end)
	self:SendMessage("Grid_UpdateLayoutSize")
end

function GridFrame:UpdateAllFrames()
	self:WithAllFrames(function(f)
		GridFrame:UpdateIndicators(f)
	end)
end

function GridFrame:InvertBarColor()
	self:WithAllFrames(function(f)
		f:InvertBarColor()
	end)
end

function GridFrame:InvertTextColor()
	self:WithAllFrames(function(f)
		f:InvertTextColor()
	end)
end

------------------------------------------------------------------------

function GridFrame:UpdateFrameUnits()
	wipe(self.guidFrameMap)
	for k, v in pairs(self.guidFrameMoreMap) do wipe(v) end
	self.hasMoreMap = nil
	for frame_name, frame in pairs(self.registeredFrames) do
		if frame:IsVisible() then
			local old_unit = frame.unit
			local old_guid = frame.unitGUID
			local unitid = SecureButton_GetModifiedUnit(frame) --why not use GetAttribute
				  unitid = unitid and gsub(unitid, "petpet", "pet") -- http://forums.wowace.com/showpost.php?p=307619&postcount=3174
			local guid = unitid and UnitGUID(unitid) or nil

            if guid then
                if not self.guidFrameMap[guid] then
                    self.guidFrameMap[guid] = frame
                else
                    self.hasMoreMap = true
                    local list = self.guidFrameMoreMap[guid]
                    if not list then list={} self.guidFrameMoreMap[guid]=list end
                    tinsert(list, frame)
                end
            end

			if old_unit ~= unitid or old_guid ~= guid then
				self:Debug("Updating", frame_name, "to", unitid, guid, "was", old_unit, old_guid)

				if unitid then
					frame.unit = unitid
					frame.unitGUID = guid

					if guid then
						self:UpdateIndicators(frame)
						self:UpdateRoleIcon(frame)
					end
				else
					frame.unit = nil
					frame.unitGUID = nil

					self:ClearIndicators(frame)
				end
			end
		end
    end
    for k, v in pairs(self.guidFrameMoreMap) do if #v==0 then self.guidFrameMoreMap[k]=nil end end --clean unused guid
end

--[[------------------------------------------------------------
warbaby@163.com roleIcon 角色图标相关
---------------------------------------------------------------]]
--默认配置
GridFrame.defaultDB.roleIconSize = 12
GridFrame.defaultDB.roleIconEnable = true
GridFrame.defaultDB.roleIconNoDPS = false
GridFrame.defaultDB.roleIconX = -4
GridFrame.defaultDB.roleIconY = 4
GridFrame.defaultDB.roleIconDarkness = 0.5
GridFrame.defaultDB.roleIconAnchor = "TOPLEFT"

GridFrame.options.args["roleIcon"] = {
    name = L["角色图标"],
    desc = L["左上角用来显示治疗/坦克/输出，或者主坦克、主助理等角色的图标。"],
    order = 150, width = "double",
    type = "group", --inline = true,
    args = {
        ["enable"] = {
            name = L["Enable"],
            desc = L["是否显示角色图标"],
            order = 10, --width = "double",
            type = "toggle",
            get = function()
                return GridFrame.db.profile.roleIconEnable
            end,
            set = function(_, v)
                GridFrame.db.profile.roleIconEnable = v
                GridFrame:UpdateAllRoleIcons()
            end,
        },
        ['nodps'] = {
            name = L['不显示输出者'],
            desc = L['隐藏输出者的图标'],
            order = 15, --with = 'double',
            type = 'toggle',
            get = function()
                return GridFrame.db.profile.roleIconNoDPS
            end,
            set = function(_, v)
                GridFrame.db.profile.roleIconNoDPS = v
                GridFrame:UpdateAllRoleIcons()
            end,
        },
        ["size"] = {
            name = L["Icon Size"],
            order = 20, width = "double",
            type = "range", min = 6, max = 24, step = 1,
            get = function()
                return GridFrame.db.profile.roleIconSize
            end,
            set = function(_, v)
                GridFrame.db.profile.roleIconSize = v
                GridFrame:WithAllFrames(function(f) f:ResetRoleIconStyle() end)
            end,
        },
        ["tooltip"] = {
            name = L["图标位置"],
            desc = L["角色图标在框体内的相对位置。"],
            order = 30, width = "double",
            type = "select",
            values = { ["TOPLEFT"] = L["左上角"], ["TOPRIGHT"] = L["右上角"], ["BOTTOMLEFT"] = L["左下角"], ["BOTTOMRIGHT"] = L["右下角"], ["CENTER"] = L["中央"] },
            get = function()
                return GridFrame.db.profile.roleIconAnchor
            end,
            set = function(_, v)
                GridFrame.db.profile.roleIconAnchor = v
                GridFrame:WithAllFrames(function(f) f:ResetRoleIconStyle() end)
            end,
        },
        ["xoffset"] = {
            name = L["Icon X offset"],
            desc = L["距离锚点的横坐标偏移量，左侧为负值，右侧为正值。"],
            order = 40, width = "double",
            type = "range", min = -20, max = 20, step = 1,
            get = function ()
                return GridFrame.db.profile.roleIconX
            end,
            set = function (_, v)
                GridFrame.db.profile.roleIconX = v
                GridFrame:WithAllFrames(function(f) f:ResetRoleIconStyle() end)
            end,
        },
        ["yoffset"] = {
            name = L["Icon Y offset"],
            desc = L["距离锚点的纵坐标偏移量，下方为负值，上方为正值。"],
            order = 50, width = "double",
            type = "range", min = -20, max = 20, step = 1,
            get = function ()
                return GridFrame.db.profile.roleIconY
            end,
            set = function (_, v)
                GridFrame.db.profile.roleIconY = v
                GridFrame:WithAllFrames(function(f) f:ResetRoleIconStyle() end)
            end,
        },
        ["darkness"] = {
            name = L["图标亮度"],
            desc = L["因为图标是在背景上，调暗一些可以不影响角标等信息显示"],
            order = 60, width = "double",
            type = "range", min = 0.1, max = 1, step = 0.1,
            get = function ()
                return GridFrame.db.profile.roleIconDarkness
            end,
            set = function (_, v)
                GridFrame.db.profile.roleIconDarkness = v
                GridFrame:UpdateAllRoleIcons()
            end,
        },
    },
}

local updateRoleIcon
do
    updateRoleIcon = function(f)
        local profile = GridFrame.db.profile
        local icon = f.roleIcon
        if(profile.roleIconEnable) then
            local unit = f.unit

            if(UnitInVehicle(unit) and UnitHasVehicleUI(unit)) then
                icon:SetTexture[[Interface\Vehicles\UI-Vehicles-Raid-Icon]]
                icon:SetTexCoord(0, 1, 0, 1)
                icon:Show()
            else
                local raidID = UnitInRaid(f.unit)
                local role = raidID and select(10, GetRaidRosterInfo(raidID))
                if(raidID and role) then
                    icon:SetTexture('Interface\\GroupFrame\\UI-Group-'..role..'Icon')
                    icon:SetTexCoord(0, 1, 0, 1)
                    icon:Show()
                else
                    local role = UnitGroupRolesAssigned(unit)
                    if(role == 'TANK' or role == 'HEALER' or
                        (role == 'DAMAGER' and not profile.roleIconNoDPS)) then
                        icon:SetTexture[[Interface\LFGFrame\UI-LFG-ICON-PORTRAITROLES]]
                        icon:SetTexCoord(GetTexCoordsForRoleSmallCircle(role))
                        icon:Show()
                    else
                        icon:Hide()
                    end
                end
            end
        else
            icon:Hide()
        end
    end
end

function GridFrame.prototype:ResetRoleIconStyle()
    if not self.roleIcon then
        self.roleIcon = self.Bar:CreateTexture()
        self.roleIcon:SetDrawLayer("OVERLAY", -8)
        self.optionTable = hackOptionTable
    end

    local size = GridFrame.db.profile.roleIconSize
	self.roleIcon:SetSize(size, size)
    self.roleIcon:ClearAllPoints()
	self.roleIcon:SetPoint(GridFrame.db.profile.roleIconAnchor, GridFrame.db.profile.roleIconX, GridFrame.db.profile.roleIconY)
end

function GridFrame:UpdateRoleIcon(frame)
    if not GridFrame.db.profile.roleIconEnable then
        frame.roleIcon:Hide()
    else
        updateRoleIcon(frame)
        if frame.roleIcon:IsVisible() then
            local darkness = GridFrame.db.profile.roleIconDarkness
            frame.roleIcon:SetVertexColor(darkness,darkness,darkness)
        end
    end
end

function GridFrame:UpdateAllRoleIcons()
	for frame_name, frame in pairs(self.registeredFrames) do
		if frame.unit and frame:IsVisible() then
			self:UpdateRoleIcon(frame)
		end
	end
end

function GridFrame:UpdateIndicators(frame)
	local unitid = frame.unit
	if not unitid then return end

	-- self.statusmap[indicator][status]
	for indicator in pairs(self.db.profile.statusmap) do
		self:UpdateIndicator(frame, indicator)
	end
end

function GridFrame:ClearIndicators(frame)
	for indicator in pairs(self.db.profile.statusmap) do
		frame:ClearIndicator(indicator)
	end
end

function GridFrame:UpdateIndicatorsForStatus(frame, status)
	local unitid = frame.unit
	if not unitid then return end

	-- self.statusmap[indicator][status]
	local statusmap = self.db.profile.statusmap
	for indicator, map_for_indicator in pairs(statusmap) do
		if map_for_indicator[status] then
			self:UpdateIndicator(frame, indicator)
		end
	end
end

function GridFrame:UpdateIndicator(frame, indicator)
	local status = self:StatusForIndicator(frame.unit, frame.unitGUID, indicator)
	if status then
		-- self:Debug("Showing status", status.text, "for", name, "on", indicator)
		frame:SetIndicator(indicator,
			status.color,
			status.text,
			status.value,
			status.maxValue,
			status.texture,
			status.start,
			status.duration,
			status.stack,
			status.texCoords)
	else
		-- self:Debug("Clearing indicator", indicator, "for", name)
		frame:ClearIndicator(indicator)
	end
end

function GridFrame:StatusForIndicator(unitid, guid, indicator)
	local topPriority = 0
	local topStatus
	local statusmap = self.db.profile.statusmap[indicator]

	-- self.statusmap[indicator][status]
	for statusName, enabled in pairs(statusmap) do
		local status = enabled and GridStatus:GetCachedStatus(guid, statusName)
		if status then
			local valid = true

			-- make sure the status can be displayed
			if (indicator == "text" or indicator == "text2") and not status.text then
				self:Debug("unable to display", statusName, "on", indicator, ": no text")
				valid = false
			end
			if indicator == "icon" and not status.texture then
				self:Debug("unable to display", statusName, "on", indicator, ": no texture")
				valid = false
			end

			if status.priority and type(status.priority) ~= "number" then
				self:Debug("priority not number for", statusName)
				valid = false
			end

			-- only check range for valid statuses
			if valid then
				local inRange = not status.range or self:UnitInRange(unitid)

				if inRange and ((status.priority or 99) > topPriority) then
					topStatus = status
					topPriority = topStatus.priority
				end
			end
		end
	end

	return topStatus
end

local GridStatusRange
function GridFrame:UnitInRange(unit)
	if not unit or not UnitExists(unit) then return false end
	--print("GridFrame:UnitInRange", unit)

	if UnitIsUnit(unit, "player") then
		return true
	end

	if not GridStatusRange then
		GridStatusRange = Grid:GetModule("GridStatus"):GetModule("GridStatusRange")
	end
	if GridStatusRange then
		return GridStatusRange:UnitInRange(unit)
	end

	return UnitInRange(unit)
end

------------------------------------------------------------------------

function GridFrame:Grid_StatusGained(event, guid, status, priority, range, color, text, value, maxValue, texture, start, duration, stack)
    local frame = self.guidFrameMap[guid]
    if frame then
        self:UpdateIndicatorsForStatus(frame, status)
        if self.hasMoreMap then
            local list = self.guidFrameMoreMap[guid]
            if list and #list>0 then
                for i=1,#list do
                    self:UpdateIndicatorsForStatus(list[i], status)
                end
            end
        end
    end
--[[
	for _, frame in pairs(self.registeredFrames) do
		if frame.unitGUID == guid then
			self:UpdateIndicatorsForStatus(frame, status)
		end
	end
]]
end

function GridFrame:Grid_StatusLost(event, guid, status)
    local frame = self.guidFrameMap[guid]
    if frame then
        self:UpdateIndicatorsForStatus(frame, status)
        if self.hasMoreMap then
            local list = self.guidFrameMoreMap[guid]
            if list and #list>0 then
                for i=1,#list do
                    self:UpdateIndicatorsForStatus(list[i], status)
                end
            end
        end
    end
--[[
	for _, frame in pairs(self.registeredFrames) do
		if frame.unitGUID == guid then
			self:UpdateIndicatorsForStatus(frame, status)
		end
	end
]]
end

------------------------------------------------------------------------

function GridFrame:UpdateOptionsMenu()
	self:Debug("UpdateOptionsMenu()")

	for i = 1, #self.prototype.indicators do
		local indicator = self.prototype.indicators[i]
		self:UpdateOptionsForIndicator(indicator.type, indicator.name, indicator.order)
	end
end

function GridFrame:UpdateOptionsForIndicator(indicator, name, order)
	local menu = Grid.options.args["Indicators"].args
	local GridStatus = Grid:GetModule("GridStatus")

	if indicator == "bar" then
		menu[indicator] = nil
		return
	end

	if indicator == "text2" and not self.db.profile.enableText2 then
		self:Debug("indicator text2 is disabled")
		menu[indicator] = nil
		return
	end

	if indicator == "barcolor" and not self.db.profile.enableBarColor then
		self:Debug("indicator barcolor is disabled")
		menu[indicator] = nil
		return
	end

	-- ensure statusmap entry exists for indicator
	local statusmap = self.db.profile.statusmap
	if not statusmap[indicator] then
		statusmap[indicator] = {}
	end

	-- create menu for indicator
	if not menu[indicator] then
		menu[indicator] = {
			name = name,
			icon = "Interface\\AddOns\\Grid\\icons\\"..indicator,
			desc = string.format(L["Options for %s indicator."], name),
			order = order and (order + 1) or nil,
			type = "group",
			args = {
				["StatusesHeaderDesc"] = {
					type = "description",
					name = L["|cffffd200说明：灰色选项需要先在'状态'页中启用后才能选择，启用状态会增加占用，所以请尽量只启用自己需要的状态。|r"],
					order = 1,
				},
				["StatusesHeader"] = {
					type = "header",
					name = L["Statuses"],
					order = 2,
				},
			},
		}
		if indicator == "text2" then
			menu[indicator].disabled = function() return not GridFrame.db.profile.enableText2 end
		end
	end

	local indicatorMenu = menu[indicator].args

	-- remove statuses that are not registered
	for status, _ in pairs(indicatorMenu) do
		if status ~= "StatusesHeader" and status ~= "StatusesHeaderDesc" and not GridStatus:IsStatusRegistered(status) then
			indicatorMenu[status] = nil
			self:Debug("Removed", indicator, status)
		end
	end

	local indicatorMenuOld = indicatorMenu;
	-- create entry for each registered status
	for status, module, descr in GridStatus:RegisteredStatusIterator() do
		-- needs to be local for the get/set closures
		local indicatorType = indicator
		local statusKey = status

		if(GRID_IGNORE_STATUS_MENU and GRID_IGNORE_STATUS_MENU[status]) then 
		else
			-- self:Debug(indicator.type, status)
			if(GRID_GROUP_STATUS_MENU and GRID_GROUP_STATUS_MENU[module]) then
				if not indicatorMenuOld[module] then
					indicatorMenuOld[module] = {
						type="group",
						name=GRID_GROUP_STATUS_MENU[module],
						desc=GRID_GROUP_STATUS_MENU[module],
						args={},
					}
				end
				indicatorMenu = indicatorMenuOld[module].args;
			else
				indicatorMenu = indicatorMenuOld;
			end

			if not indicatorMenu[status] then
				indicatorMenu[status] = {
					name = descr,
					desc = L["Toggle status display."],
					--width = "double",
					type = "toggle",
					get = function()
						return GridFrame.db.profile.statusmap[indicatorType][statusKey]
					end,
					disabled = function(info) return not GridStatus:IsStatusEnabled(info[#info]) end,
					set = function(_, v)
						GridFrame.db.profile.statusmap[indicatorType][statusKey] = v
						GridFrame:UpdateAllFrames()
					end,
				}
				-- self:Debug("Added", indicator.type, status)
			end
		end
	end
end

------------------------------------------------------------------------

function GridFrame:ListRegisteredFrames()
	self:Debug("--[ BEGIN Registered Frame List ]--")
	self:Debug("FrameName", "UnitId", "UnitName", "Status")
	for frameName, frame in pairs(self.registeredFrames) do
		local frameStatus = "|cff00ff00"

		if frame:IsVisible() then
			frameStatus = frameStatus .. "visible"
		elseif frame:IsShown() then
			frameStatus = frameStatus .. "shown"
		else
			frameStatus = "|cffff0000"
			frameStatus = frameStatus .. "hidden"
		end

		frameStatus = frameStatus .. "|r"

		self:Debug(
			frameName == frame:GetName() and "|cff00ff00"..frameName.."|r" or "|cffff0000"..frameName.."|r",
			frame.unit == frame:GetAttribute("unit") and "|cff00ff00"..(frame.unit or "nil").."|r" or "|cffff0000"..(frame.unit or "nil").."|r",
			frame.unit and frame.unitGUID == UnitGUID(frame.unit) and "|cff00ff00"..(frame.unitName or "nil").."|r" or "|cffff0000"..(frame.unitName or "nil").."|r",
			frame:GetAttribute("type1"),
			frame:GetAttribute("*type1"),
			frameStatus)
	end
	GridFrame:Debug("--[ END Registered Frame List ]--")
end
