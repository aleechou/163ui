
------------------------------------------------------------------------------------
-- Tidy Plates Hub
------------------------------------------------------------------------------------
local AddonName, HubData = ...;
local LocalVars = TidyPlatesHubDefaults
------------------------------------------------------------------------------------
HubData.Functions = {}
HubData.Colors = {}
TidyPlatesHubFunctions = {}
------------------------------------------------------------------------------------
local CallbackList = {}
function HubData.RegisterCallback(func) CallbackList[func] = true end
function HubData.UnRegisterCallback(func) CallbackList[func] = nil end

local InCombatLockdown = InCombatLockdown

local WidgetLib = TidyPlatesWidgets
local valueToString = TidyPlatesUtility.abbrevNumber
local EnableTankWatch = TidyPlatesWidgets.EnableTankWatch
local DisableTankWatch = TidyPlatesWidgets.DisableTankWatch
local EnableAggroWatch = TidyPlatesWidgets.EnableAggroWatch
local DisableAggroWatch = TidyPlatesWidgets.DisableAggroWatch

local GetAggroCondition = TidyPlatesWidgets.GetThreatCondition
local IsTotem = TidyPlatesUtility.IsTotem
local IsAuraShown = TidyPlatesWidgets.IsAuraShown
local IsHealer = TidyPlatesUtility.IsHealer
local InstanceStatus = TidyPlatesUtility.InstanceStatus

local CachedUnitDescription = TidyPlatesUtility.CachedUnitDescription
local CachedUnitGuild = TidyPlatesUtility.CachedUnitGuild
local CachedUnitClass = TidyPlatesUtility.CachedUnitClass
local IsFriend = TidyPlatesUtility.IsFriend
local IsGuildmate = TidyPlatesUtility.IsGuildmate


local isTanked = TidyPlatesWidgets.IsTankedByAnotherTank
local function IsTankedByAnotherTank(...)

	-- Testing
	if LocalVars.EnableOffTankHighlight then
		local unit = ...
		if not unit.isTarget then return true end
	end

	if LocalVars.EnableOffTankHighlight and isTanked(...) then return true end
end

HubData.Functions.IsTankedByAnotherTank = IsTankedByAnotherTank

local function IsTankingAuraActive()
	return TidyPlatesWidgets.IsTankingAuraActive
end

HubData.Functions.IsTankingAuraActive = IsTankingAuraActive

-- General
local function DummyFunction() return end

local function GetFriendlyClass(name)
	local class = TidyPlatesUtility.GroupMembers.Class[name]

	if (not IsInInstance()) and (not class) and LocalVars.AdvancedEnableUnitCache then
		class = CachedUnitClass(name) end
	return class
end

local function GetEnemyClass(name)
	if LocalVars.AdvancedEnableUnitCache then
			return CachedUnitClass(name) end
end

HubData.Functions.GetFriendlyClass = GetFriendlyClass
HubData.Functions.GetEnemyClass = GetEnemyClass

-- Define the Menu for Threat Modes
TidyPlatesHubDefaults.ThreatWarningMode = "Auto"
TidyPlatesHubMenus.ThreatWarningModes = {
					{ text = "Auto (Color Swap)", value = "Auto",} ,
					{ text = "Tank", value = "Tank",} ,
					{ text = "DPS/Healer", value = "DPS",} ,
					}


--local NormalGrey = {r = .5, g = .5, b = .5, a = .3}
--local EliteGrey = {r = .8, g = .7, b = .4, a = .5}
--local BossGrey = {r = .8, g = .6, b = .1, a = 1}

local NormalGrey = {r = .65, g = .65, b = .65, a = .4}
local EliteGrey = {r = .9, g = .7, b = .3, a = .5}
local BossGrey = {r = 1, g = .85, b = .1, a = .8}

-- Colors
local BlueColor = {r = 60/255, g =  168/255, b = 255/255, }
local GreenColor = { r = 96/255, g = 224/255, b = 37/255, }
local RedColor = { r = 255/255, g = 51/255, b = 32/255, }
local YellowColor = { r = 252/255, g = 220/255, b = 27/255, }
local GoldColor = { r = 252/255, g = 140/255, b = 0, }
local OrangeColor = { r = 255/255, g = 64/255, b = 0, }
local WhiteColor = { r = 250/255, g = 250/255, b = 250/255, }

local White = {r = 1, g = 1, b = 1}
local Black = {r = 0, g = 0, b = 0}
local BrightBlue =  {r = 0, g = 70/255, b = 240/255,} -- {r = 0, g = 75/255, b = 240/255,}
local BrightBlueText = {r = 112/255, g = 219/255, b = 255/255,}
local PaleBlue = {r = 0, g = 130/255, b = 225/255,}
local PaleBlueText = {r = 194/255, g = 253/255, b = 1,}
local DarkRed = {r = .9, g = 0.08, b = .08,}

local RaidClassColors = RAID_CLASS_COLORS

------------------------------------------------------------------------------------

local ReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 0, g = 0, b = 1,},
		["NPC"] = {r = 0, g = 1, b = 0,},
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 1, g = 0, b = 0,},
		["NPC"] = {r = 1, g = 0, b = 0,},
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 1, g = 1, b = 0,},
	},
	["TAPPED"] = {
		--["NPC"] = {r = .53, g = .53, b = 1,},
		["NPC"] = {r = .45, g = .45, b = .45,},
	},
}



local NameReactionColors = {
	["FRIENDLY"] = {
		["PLAYER"] = {r = 60/255, g = 168/255, b = 255/255,},
		["NPC"] = {r = 96/255, g = 224/255, b = 37/255,},
	},
	["HOSTILE"] = {
		["PLAYER"] = {r = 255/255, g = 51/255, b = 32/255,},
		["NPC"] = {r = 255/255, g = 51/255, b = 32/255,},
	},
	["NEUTRAL"] = {
		["NPC"] = {r = 252/255, g = 180/255, b = 27/255,},
	},
	["TAPPED"] = {
		--["NPC"] = {r = .8, g = .8, b = 1,},
		["NPC"] = {r = .7, g = .7, b = .7,},
	},
}

HubData.Colors.ReactionColors = ReactionColors
HubData.Colors.NameReactionColors = NameReactionColors

------------------------------------------------------------------------------------
-- Helper Functions
------------------------------------------------------------------------------------

local function GetFriendlyClass(name)
	local class = TidyPlatesUtility.GroupMembers.Class[name]

	if (not IsInInstance() ) and (not class) and LocalVars.AdvancedEnableUnitCache then
		class = CachedUnitClass(name) end
	return class
end

local function GetEnemyClass(name)
	if LocalVars.AdvancedEnableUnitCache then
			return CachedUnitClass(name) end
end

local function CallbackUpdate()
			for func in pairs(CallbackList) do
				func(LocalVars)
			end
end

local function EnableWatchers()
	if LocalVars.WidgetsDebuffStyle == 2 then TidyPlatesWidgets.UseSquareDebuffIcon() else TidyPlatesWidgets.UseWideDebuffIcon()end
	TidyPlatesUtility:EnableGroupWatcher()
	if LocalVars.AdvancedEnableUnitCache then TidyPlatesUtility:EnableUnitCache() else TidyPlatesUtility:DisableUnitCache() end

	TidyPlatesUtility:EnableHealerTrack()
	TidyPlatesWidgets:EnableTankWatch()

	CallbackUpdate()
end

local CreateVariableSet = TidyPlatesHubRapidPanel.CreateVariableSet


-- [[
-- TidyPlatesHubSettings["HubPanelSettingsDamage"]
local function UseDamageVariables()
	local objectName = "HubPanelSettingsDamage"
	LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)

	CallbackUpdate()

	--EnableWatchers()
	return LocalVars
end

local function UseTankVariables()
	local objectName = "HubPanelSettingsTank"
	LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)

	CallbackUpdate()

	--EnableWatchers()
	return LocalVars
end
--]]

local function UseVariables(profileName)

	local suffix = profileName or "Damage"
	if suffix then

		local objectName = "HubPanelSettings"..suffix
		---ocal objectName = "HubProfileSettings"..suffix

		LocalVars = TidyPlatesHubSettings[objectName] or CreateVariableSet(objectName)

		CallbackUpdate()

		--EnableWatchers()
		return LocalVars
	end
end

---------------
-- Apply customization
---------------
local blizzfont =				STANDARD_TEXT_FONT;

local function ApplyFontCustomization(style)
	if not style then return end

	-- Store Original Fonts
	style.name.oldfont = style.name.oldfont or style.name.typeface
	style.level.oldfont = style.level.oldfont or style.level.typeface
	style.customtext.oldfont = style.customtext.oldfont or style.customtext.typeface
	style.spelltext.oldfont = style.spelltext.oldfont or style.spelltext.typeface

	-- Apply Font
	if LocalVars.TextUseBlizzardFont then
		style.name.typeface = blizzfont
		style.level.typeface = blizzfont
		style.customtext.typeface = blizzfont
		style.spelltext.typeface = blizzfont
	else
		--local typeface = style.oldfont or style.name.typeface
		style.name.typeface =  style.name.oldfont or style.name.typeface
		style.level.typeface =  style.level.oldfont or style.level.typeface
		style.customtext.typeface =  style.customtext.oldfont or style.customtext.typeface
		style.spelltext.typeface =  style.spelltext.oldfont or style.spelltext.typeface
	end
	style.frame.y = ((LocalVars.FrameVerticalPosition-.5)*50)-16
end

local function ApplyCustomBarSize(style)
	-- Store Default Sizes
	style.threatborder._width = style.threatborder._width or style.threatborder.width or 1
	style.healthborder._width = style.healthborder._width or style.healthborder.width or 1
	style.target._width = style.target._width or style.target.width or 1
	style.healthbar._width = style.healthbar._width or style.healthbar.width or 1
	style.eliteicon._x = style.eliteicon._x or style.eliteicon.x or 0

	-- Alter Widths
	style.threatborder.width = style.threatborder._width * (LocalVars.FrameBarWidth or 1)
	style.healthborder.width = style.healthborder._width * (LocalVars.FrameBarWidth or 1)
	style.target.width = style.target._width * (LocalVars.FrameBarWidth or 1)
	style.healthbar.width = style.healthbar._width * (LocalVars.FrameBarWidth or 1)
	style.eliteicon.x = style.eliteicon._x * (LocalVars.FrameBarWidth or 1)
end

local function ApplyStyleCustomization(style)
	if not style then return end
	style.level.show = (LocalVars.TextShowLevel == true)
	style.target.show = (LocalVars.WidgetTargetHighlight == true)
	style.eliteicon.show = (LocalVars.WidgetEliteIndicator == true)

 	ApplyCustomBarSize(style)
	ApplyFontCustomization(style)
end


local function ApplyThemeCustomization(theme)

	if not theme then return end

	ReactionColors.FRIENDLY.NPC = LocalVars.ColorFriendlyNPC
	ReactionColors.FRIENDLY.PLAYER = LocalVars.ColorFriendlyPlayer
	ReactionColors.HOSTILE.NPC = LocalVars.ColorHostileNPC
	ReactionColors.HOSTILE.PLAYER = LocalVars.ColorHostilePlayer
	ReactionColors.NEUTRAL.NPC = LocalVars.ColorNeutral

	NameReactionColors.FRIENDLY.NPC = LocalVars.TextColorFriendlyNPC
	NameReactionColors.FRIENDLY.PLAYER = LocalVars.TextColorFriendlyPlayer
	NameReactionColors.HOSTILE.NPC = LocalVars.TextColorHostileNPC
	NameReactionColors.HOSTILE.PLAYER = LocalVars.TextColorHostilePlayer
	NameReactionColors.NEUTRAL.NPC = LocalVars.TextColorNeutral

	EnableWatchers()
	ApplyStyleCustomization(theme["Default"])
	ApplyFontCustomization(theme["NameOnly"])

	--ApplyUserProgram(theme["Default"], theme["NameOnly"])

	TidyPlates:ForceUpdate()
	RaidClassColors = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
end


-- From Neon.lua...
local LocalVars = TidyPlatesHubDamageVariables

local function OnInitialize(plate, theme)
	if theme and theme.WidgetConfig then
		TidyPlatesHubFunctions.OnInitializeWidgets(plate, theme.WidgetConfig)
	end
end

local function OnActivateTheme(themeTable, profileName)
		--print("NeonDamage", themeTable, other)
		if Theme == themeTable then
			--LocalVars = TidyPlatesHubFunctions:UseDamageVariables()
			--ApplyDamageCustomization()
			--print("OnActivateTheme", profileName)
			TidyPlatesHubFunctions.UseVariables(profileName)
			ApplyThemeCustomization(Theme)
		end
end

-- Quickly add functions to a Theme
local function ApplyHubFunctions(theme)
	theme.SetNameColor = TidyPlatesHubFunctions.SetNameColor
	theme.SetScale = TidyPlatesHubFunctions.SetScale
	theme.SetAlpha = TidyPlatesHubFunctions.SetAlpha
	theme.SetHealthbarColor = TidyPlatesHubFunctions.SetHealthbarColor
	theme.SetThreatColor = TidyPlatesHubFunctions.SetThreatColor
	theme.SetCastbarColor = TidyPlatesHubFunctions.SetCastbarColor
	theme.OnUpdate = TidyPlatesHubFunctions.OnUpdate
	theme.OnContextUpdate = TidyPlatesHubFunctions.OnContextUpdate
	theme.ShowConfigPanel = ShowTidyPlatesHubDamagePanel
	theme.SetStyle = TidyPlatesHubFunctions.SetStyleBinary
	theme.SetCustomText = TidyPlatesHubFunctions.SetCustomTextBinary
	theme.OnInitialize = OnInitialize		-- Need to provide widget positions
	theme.OnActivateTheme = OnActivateTheme -- called by Tidy Plates Core, Theme Loader
	--theme.OnApplyThemeCustomization = OnApplyCustomization -- Called By Hub Panel
	theme.OnApplyThemeCustomization = TidyPlatesHubFunctions.ApplyThemeCustomization
	theme.OnChangeProfile = TidyPlatesHubFunctions.UseVariables

	return theme
end

---------------------------------------------
-- Function List
---------------------------------------------


TidyPlatesHubFunctions.UseDamageVariables = UseDamageVariables
TidyPlatesHubFunctions.UseTankVariables = UseTankVariables
TidyPlatesHubFunctions.UseVariables = UseVariables
TidyPlatesHubFunctions.EnableWatchers = EnableWatchers

TidyPlatesHubFunctions.ApplyFontCustomization = ApplyFontCustomization
TidyPlatesHubFunctions.ApplyStyleCustomization = ApplyStyleCustomization
TidyPlatesHubFunctions.ApplyThemeCustomization = ApplyThemeCustomization

TidyPlatesHubFunctions.ApplyHubFunctions = ApplyHubFunctions











