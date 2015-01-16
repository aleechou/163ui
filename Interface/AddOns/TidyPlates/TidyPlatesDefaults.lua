if not TidyPlatesThemeList then TidyPlatesThemeList = {} end

-------------------------------------------------------------------------------------
-- Template
-------------------------------------------------------------------------------------

local TemplateTheme = {}
local defaultArtPath = "Interface\\Addons\\TidyPlates\\Media"
--local font =					"FONTS\\arialn.ttf"
local font =					NAMEPLATE_FONT
local EMPTY_TEXTURE = defaultArtPath.."\\Empty"

TemplateTheme.hitbox = {
	width = 149,
	height = 40,
}

TemplateTheme.highlight = {
	texture =					EMPTY_TEXTURE,
	width = 128,
	height = 64,
}

TemplateTheme.healthborder = {
	texture		 =				EMPTY_TEXTURE,
	width = 0,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = true,
	-- Texture Coordinates
	left = 0,
	right = 1,
	top = 0,
	bottom = 1,
}

TemplateTheme.eliteicon = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = false,
	-- Texture Coordinates
	left = 0,
	right = 1,
	top = 0,
	bottom = 1,
}

TemplateTheme.threatborder = {
	texture =			EMPTY_TEXTURE,
	--elitetexture =			EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = true,
	-- Texture Coordinates
	left = 0,
	right = 1,
	top = 0,
	bottom = 1,
}


TemplateTheme.castborder = {
	texture =					EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -11,
	anchor = "CENTER",
	show = true,
}

TemplateTheme.castnostop = {
	texture = 				EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -11,
	anchor = "CENTER",
	show = true,
}

TemplateTheme.name = {
	typeface =					font,
	size = 9,
	width = 88,
	height = 10,
	x = 0,
	y = 1,
	align = "LEFT",
	anchor = "LEFT",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true,
}

TemplateTheme.level = {
	typeface =					font,
	size = 9,
	width = 25,
	height = 10,
	x = 36,
	y = 1,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = true,
}

TemplateTheme.healthbar = {
	texture =					 EMPTY_TEXTURE,
	backdrop = 				EMPTY_TEXTURE,
	height = 12,
	--width = 101,
	width = 0,
	x = 0,
	y = 10,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

TemplateTheme.castbar = {
	texture =					EMPTY_TEXTURE,
	backdrop = 				EMPTY_TEXTURE,
	height = 12,
	width = 99,
	x = 0,
	y = -19,
	anchor = "CENTER",
	orientation = "HORIZONTAL",
}

TemplateTheme.spelltext = {
	typeface =					font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 11,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false,
}

TemplateTheme.customtext = {
	typeface =					font,
	size = 8,
	width = 100,
	height = 10,
	x = 1,
	y = -19,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false,
}

TemplateTheme.spellicon = {
	width = 18,
	height = 18,
	x = 62,
	y = -19,
	anchor = "CENTER",
	show = true,
}

TemplateTheme.raidicon = {
	texture = "Interface\\TargetingFrame\\UI-RaidTargetingIcons",
	width = 20,
	height = 20,
	x = -35,
	y = 7,
	anchor = "TOP",
	show = true,
}

TemplateTheme.skullicon = {
	texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull",
	width = 14,
	height = 14,
	x = 44,
	y = 3,
	anchor = "CENTER",
	show = true,
}

TemplateTheme.frame = {
	width = 101,
	height = 45,
	x = 0,
	y = 0,
	anchor = "CENTER",
}

TemplateTheme.target = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = false,
}

TemplateTheme.threatcolor = {
	LOW = { r = .75, g = 1, b = 0, a= 1, },
	MEDIUM = { r = 1, g = 1, b = 0, a = 1, },
	HIGH = { r = 1, g = 0, b = 0, a = 1, },
}



--[[
-- Prototype Tidy Plates 7.0 Theme Format
TemplateTheme.threatborder = {
	-- Shown Texture
	texture =			EMPTY_TEXTURE,

	-- Positioning
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",

	--
	root_object_table[i]....  etc.

	root_object = "healthborder",		-- If nil or "default", use the default root and copy the self anchor point. (Core)
	root_anchor = "CENTER",

	-- Texture/Cropping Coordinates
	left = 0,
	right = 1,
	top = 0,
	bottom = 1,

	-- Visibility
	show = true,

	--
}

StyleLibrary[StyleName]

Style
	- Graphical Element Definitions
	- Widget Positions
	- Functional Overrides

Widgets
	- Managed widget system
	- As-Needed distribution
	-



--]]




--[[

------------------------------------------------
--	Blizzard-Style (Used for the default/fallback theme)
------------------------------------------------

local BlizzardTheme = TidyPlatesUtility.copyTable(TemplateTheme)
local BlizzardThemeVertical = 8

BlizzardTheme.highlight.texture = "Interface\\Tooltips\\Nameplate-Glow"
BlizzardTheme.highlight.width = 128
BlizzardTheme.highlight.height = 32

BlizzardTheme.healthborder.texture		 =				"Interface\\Tooltips\\Nameplate-Border"
BlizzardTheme.healthborder.width = 128
BlizzardTheme.healthborder.height = 32
BlizzardTheme.healthborder.x = 0
BlizzardTheme.healthborder.y = 0 + BlizzardThemeVertical
BlizzardTheme.healthborder.right = .50

BlizzardTheme.eliteicon.texture = "Interface\\Tooltips\\EliteNameplateIcon"
BlizzardTheme.eliteicon.width = 32
BlizzardTheme.eliteicon.height = 32
BlizzardTheme.eliteicon.x = 22
BlizzardTheme.eliteicon.y = -8.5 + BlizzardThemeVertical
BlizzardTheme.eliteicon.anchor = "RIGHT"
BlizzardTheme.eliteicon.show = true
BlizzardTheme.eliteicon.left = 0
BlizzardTheme.eliteicon.right = .578125
BlizzardTheme.eliteicon.top = 0
BlizzardTheme.eliteicon.bottom = .84375

BlizzardTheme.threatborder.texture =			"Interface\\TargetingFrame\\UI-TargetingFrame-Flash"
BlizzardTheme.threatborder.width = 140
BlizzardTheme.threatborder.height = 32
BlizzardTheme.threatborder.x = 0
BlizzardTheme.threatborder.y = -10 + BlizzardThemeVertical
BlizzardTheme.threatborder.left = 0
BlizzardTheme.threatborder.right = .555
BlizzardTheme.threatborder.top = .53
BlizzardTheme.threatborder.bottom = .6

BlizzardTheme.castborder.texture =					"Interface\\Tooltips\\Nameplate-CastBar"
BlizzardTheme.castborder.width = 128
BlizzardTheme.castborder.height = 32
BlizzardTheme.castborder.x = -17
BlizzardTheme.castborder.y = -24 + BlizzardThemeVertical

BlizzardTheme.castnostop.texture = 				"Interface\\Tooltips\\Nameplate-CastBar-Shield"
BlizzardTheme.castnostop.width = 128
BlizzardTheme.castnostop.height = 32
BlizzardTheme.castnostop.x = -17
BlizzardTheme.castnostop.y = -24 + BlizzardThemeVertical

BlizzardTheme.name.typeface = NAMEPLATE_FONT
BlizzardTheme.name.size = 12
BlizzardTheme.name.width = 200
BlizzardTheme.name.height = 16
BlizzardTheme.name.x = 0
BlizzardTheme.name.y = 8 + BlizzardThemeVertical
BlizzardTheme.name.align = "CENTER"
BlizzardTheme.name.anchor = "CENTER"
BlizzardTheme.name.shadow = true
BlizzardTheme.name.vertical = "BOTTOM"
BlizzardTheme.name.flags = "OUTLINE"

BlizzardTheme.level.typeface = NAMEPLATE_FONT
BlizzardTheme.level.size = 9
BlizzardTheme.level.width = 25
BlizzardTheme.level.height = 10
BlizzardTheme.level.x = 15
BlizzardTheme.level.y = -6.5 + BlizzardThemeVertical
BlizzardTheme.level.align = "CENTER"
BlizzardTheme.level.anchor = "RIGHT"
BlizzardTheme.level.vertical = "BOTTOM"
BlizzardTheme.level.shadow = true
BlizzardTheme.level.flags = "NONE"

BlizzardTheme.healthbar.texture =					 "Interface\\TARGETINGFRAME\\UI-StatusBar"
BlizzardTheme.healthbar.backdrop = 				EMPTY_TEXTURE
BlizzardTheme.healthbar.height = 9
BlizzardTheme.healthbar.width = 104
BlizzardTheme.healthbar.x = -8.5
BlizzardTheme.healthbar.y = -7	+ BlizzardThemeVertical

BlizzardTheme.castbar.texture =					"Interface\\TARGETINGFRAME\\UI-StatusBar"
BlizzardTheme.castbar.backdrop = 				EMPTY_TEXTURE
BlizzardTheme.castbar.height = 9
BlizzardTheme.castbar.width = 102
BlizzardTheme.castbar.x = -8.5
BlizzardTheme.castbar.y = -24 + BlizzardThemeVertical

BlizzardTheme.spellicon.width = 14
BlizzardTheme.spellicon.height = 14
BlizzardTheme.spellicon.x = -25.5
BlizzardTheme.spellicon.y = -24 + BlizzardThemeVertical
BlizzardTheme.spellicon.anchor = "LEFT"
BlizzardTheme.spellicon.show = true

BlizzardTheme.raidicon.width = 20
BlizzardTheme.raidicon.height = 20
BlizzardTheme.raidicon.x = 0
BlizzardTheme.raidicon.y = 8 + BlizzardThemeVertical
BlizzardTheme.raidicon.anchor = "TOP"
BlizzardTheme.raidicon.show = true

BlizzardTheme.skullicon.texture = "Interface\\TargetingFrame\\UI-TargetingFrame-Skull"
BlizzardTheme.skullicon.width = 15
BlizzardTheme.skullicon.height = 15
BlizzardTheme.skullicon.x = 53
BlizzardTheme.skullicon.y = -7 + BlizzardThemeVertical
BlizzardTheme.skullicon.anchor = "CENTER"
BlizzardTheme.skullicon.show = true

BlizzardTheme.customtext.size = 9
BlizzardTheme.customtext.y = -6.5 + BlizzardThemeVertical
BlizzardTheme.customtext.x = -7
BlizzardTheme.customtext.align = "CENTER"
BlizzardTheme.customtext.anchor = "CENTER"
BlizzardTheme.customtext.height = 10
BlizzardTheme.customtext.width = 100

BlizzardTheme.frame.width = 101
BlizzardTheme.frame.height = 45
BlizzardTheme.frame.x = 0
BlizzardTheme.frame.y = 0
BlizzardTheme.frame.anchor = "CENTER"

--]]

--[[
BlizzardTheme.target = {
	texture = EMPTY_TEXTURE,
	width = 128,
	height = 64,
	x = 0,
	y = -5,
	anchor = "CENTER",
	show = false,
}


BlizzardTheme.spelltext = {
	typeface =					font,
	size = 9,
	width = 93,
	height = 10,
	x = 0,
	y = 11,
	align = "RIGHT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false,
}

BlizzardTheme.customtext = {
	typeface =					font,
	size = 8,
	width = 100,
	height = 10,
	x = 1,
	y = -19,
	align = "LEFT",
	anchor = "CENTER",
	vertical = "BOTTOM",
	shadow = true,
	flags = "NONE",
	show = false,
}


--]]

-----------------------------------------------
-- References
-----------------------------------------------
TidyPlates.Template = TemplateTheme
--TidyPlatesThemeList["None"] = TemplateTheme
TidyPlates:ActivateTheme(TemplateTheme)

--TidyPlatesDefaultThemeName = "Blizzard"
--TidyPlatesThemeList[TidyPlatesDefaultThemeName] = BlizzardTheme
--TidyPlates:ActivateTheme(BlizzardTheme)		-- Activates the template as a holder theme, until the user preference is loaded



--[[  Delegate Functions
-- Appearance and Indicators
BlizzardTheme.SetNameColor

BlizzardTheme.SetCustomText = function(unit) return "Text to Display" end
BlizzardTheme.SetScale = function(unit) local scale = 1; return scale end
BlizzardTheme.SetAlpha = function(unit) local alpha = 1; return alpha end
BlizzardTheme.SetHealthbarColor = function(unit) local r, g, b = 1, 1, 1; return r, g, b end
BlizzardTheme.SetThreatColor = function(unit) local r, g, b = 1, 1, 1, a; return r, g, b, a end

-- Advanced Behaviors & Widgets
BlizzardTheme.OnInitialize = function(frame) end
BlizzardTheme.OnUpdate = function(frame, unit) end
BlizzardTheme.OnContextUpdate = function(frame, unit) end
BlizzardTheme.OnActivateTheme = function(themetable, themename)		-- Fired for each theme during unloading, and once for the incoming theme during loading

-- Special Objects
BlizzardTheme.ShowConfigPanel = function() end	-- This function is called when the 'wrench' icon is clicked in the theme chooser menu.  it can be used to activate a theme config panel
--]]

--[[
-- Unit Information Table
unit.threatSituation				"LOW", "MEDIUM", "HIGH"
unit.reaction						"FRIENDLY", "NEUTRAL", "HOSTILE"
unit.type							"NPC", "PLAYER"
unit.isBoss							true, if the skull icon is active (the creature is a boss/level ??)
unit.isDangerous					Same as isBoss
unit.isElite						true, if unit is elite (ie. elite symbol is shown)
unit.isMarked						true, if the unit is marked with a raid icon
unit.name							the unit's name
unit.alpha							float, the alpha of the nameplate (ie. 1 = target, Less than 1 = non-target)
unit.level							integer, the unit's level
unit.health							integer, the unit's health
unit.isMouseover					true, if the highlight region is showing (ie. mouse is over the frame)
unit.red, unit.green, unit.blue 	0.0-1 Values, the raw color of the health bar
unit.isCasting						true, if cast bar is being shown
_, unit.healthmax 					integer, the maximum health of the unit
unit.class 							"DEATHKNIGHT", "DRUID","HUNTER", etc.. Only for PvP Enemies
unit.isInCombat						true, if name text is red (ie. unit is in combat with you; Unreliable because of the way that Blizz's nameplates work)
unit.raidIcon
unit.threatValue
	0 - Unit has less than 100% raw threat (default UI shows no indicator)
	1 - Unit has 100% or higher raw threat but isn't mobUnit's primary target (default UI shows yellow indicator)
	2 - Unit is mobUnit's primary target, and another unit has 100% or higher raw threat (default UI shows orange indicator)
	3 - Unit is mobUnit's primary target, and no other unit has 100% or higher raw threat (default UI shows red indicator)
--]]


--[[

	Texture Coordinate Explanation
	coords.left, coords.right, coords.top, coords.bottom

	+----- 0 -----+
	|             |
	|             |
	0      | ---> 1
	|      |      |
	|      V      |
	+----- 1 -----+

	+----- 0 -----+
	|             |
	|      |      |
	0      V      1
	| ... 0.75 .. |
	|             |
	+----- 1 -----+

--]]