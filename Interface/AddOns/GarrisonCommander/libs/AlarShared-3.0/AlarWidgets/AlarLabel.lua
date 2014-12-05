local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local me,ns=...
local pp=print
local Type, Version = "AlarLabel", 24
LibStub("AlarLoader-3.0"):loadingList(__FILE__,me)

--[[-----------------------------------------------------------------------------
Label Widget
Displays text and optionally an icon.
-------------------------------------------------------------------------------]]
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local AWG=LibStub("AlarWidgets-3.0")
local InjectStandardMethods=AWG.InjectStandardMethods

-- Lua APIs
local max, select, pairs = math.max, select, pairs

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: GameFontHighlightSmall

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]

local function UpdateImageAnchor(self)
	if self.resizing then return end
	local frame = self.frame
	local width = frame.width or frame:GetWidth() or 0
	local image = self.image
	local label = self.label
	local imagealign=self.imagealign
	local height

	label:ClearAllPoints()
	image:ClearAllPoints()

	if self.imageshown then
		local imagewidth = image:GetWidth()
		if (imagealign=='a') then
			-- image goes on top centered when less than 200 width for the text, or if there is no text
			if (width - imagewidth) < 200 or (label:GetText() or "") == "" then
				imagealign='t'
			else
				imagealign='l'
			end
		end
		if (imagealign=='t') then
			image:SetPoint("TOP")
			label:SetPoint("TOP", image, "BOTTOM")
			label:SetPoint("LEFT")
			label:SetWidth(width)
			height = image:GetHeight() + label:GetHeight()
		elseif (imagealign=='l') then
			-- image on the left
			image:SetPoint("TOPLEFT")
			label:SetPoint("TOPLEFT", image, "TOPRIGHT", 4, 0)
			label:SetWidth(width - imagewidth - 4)
			height = max(image:GetHeight(), label:GetHeight())
		elseif (imagealign=='r') then
			-- image on the right
			label:SetPoint("TOPLEFT")
			image:SetPoint("TOPLEFT", label, "TOPRIGHT", 4, 0)
			label:SetWidth(width - imagewidth - 4)
			height = max(image:GetHeight(), label:GetHeight())
		end
	else
		-- no image shown
		label:SetPoint("TOPLEFT")
		label:SetWidth(width)
		height = label:GetHeight()
	end

	self.resizing = true
	frame:SetHeight(height)
	frame.height = height
	self.resizing = nil
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		-- set the flag to stop constant size updates
		self.resizing = true
		-- height is set dynamically by the text and image size
		self:SetWidth(200)
		self:SetText()
		self:SetImage(nil)
		self:SetImageSize(16, 16)
		self:SetColor()
		self:SetFontObject()
		self.imagealign="l" --left aligned image is the default
		self:SetTextAlign() -- by default, text is aligned LEFT,TOP

		-- reset the flag
		self.resizing = nil
		-- run the update explicitly
		UpdateImageAnchor(self)
	end,

	-- ["OnRelease"] = nil,

	["OnWidthSet"] = function(self, width)
		UpdateImageAnchor(self)
	end,

	["SetText"] = function(self, text)
		self.label:SetText(text)
		UpdateImageAnchor(self)
	end,
	["SetTextAlign"] = function(self,hAlign,vAlign)
		self.label:SetJustifyH(hAlign or "LEFT")
		self.label:SetJustifyV(vAlign or "MIDDLE")
	end,
	["SetColor"] = function(self, r, g, b)
		if not (r and g and b) then
			r, g, b = 1, 1, 1
		end
		self.label:SetVertexColor(r, g, b)
	end,
	["SetImageAlign"] =function (self,align)
		self.imagealign=strlower(tostring(align):sub(1,1))
		UpdateImageAnchor(self)
	end,

	["SetImage"] = function(self, path, ...)
		local image = self.image
		image:SetTexture(path)

		if image:GetTexture() then
			self.imageshown = true
			local n = select("#", ...)
			if n == 4 or n == 8 then
				image:SetTexCoord(...)
			else
				image:SetTexCoord(0, 1, 0, 1)
			end
		else
			self.imageshown = nil
		end
		UpdateImageAnchor(self)
	end,

	["SetFont"] = function(self, font, height, flags)
		self.label:SetFont(font, height, flags)
	end,

	["SetFontObject"] = function(self, font)
		self:SetFont((font or GameFontHighlightSmall):GetFont())
	end,

	["SetImageSize"] = function(self, width, height)
		self.image:SetWidth(width)
		self.image:SetHeight(height)
		UpdateImageAnchor(self)
	end,
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:Hide()

	local label = frame:CreateFontString(nil, "BACKGROUND", "GameFontHighlightSmall")
	label:SetJustifyH("LEFT")
	label:SetJustifyV("TOP")

	local image = frame:CreateTexture(nil, "BACKGROUND")

	-- create widget
	local widget = {
		label = label,
		image = image,
		frame = frame,
		type  = Type
	}
	InjectStandardMethods(widget)
	widget:Inject(methods)

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)