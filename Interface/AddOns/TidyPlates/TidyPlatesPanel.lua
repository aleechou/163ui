
-------------------------------------------------------------------------------------



local TidyPlatesInterfacePanel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptions", "Tidy Plates", titleString )

local CallIn = TidyPlatesUtility.CallIn
local copytable = TidyPlatesUtility.copyTable
local mergetable = TidyPlatesUtility.mergeTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers



local NO_AUTOMATION = "不自动"
local DURING_COMBAT = "战斗中显示, 战斗结束隐藏"
local OUT_OF_COMBAT = "战斗开始隐藏, 战斗结束显示"

local font = "Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf"
local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"

local function SetSoftTransitions(enable)
	if enable then TidyPlates:EnableFadeIn()
		else TidyPlates:DisableFadeIn() end
end

local EnableCompatibilityMode = TidyPlates.EnableCompatibilityMode


-------------------------------------------------------------------------------------
--  Default Options
-------------------------------------------------------------------------------------

local FirstTryTheme = "Neon"
local DefaultProfile = "Damage"
local ActiveProfile = "None"
local ActiveThemeName = ""
local ActiveSpec = "Primary"
local ActiveSpecVarReference = "PrimaryTheme"

TidyPlatesOptions = {
	PrimaryTheme = FirstTryTheme,
	SecondaryTheme = FirstTryTheme,

	PrimaryProfile = DefaultProfile,
	SecondaryProfile = DefaultProfile,

	FriendlyAutomation = NO_AUTOMATION,
	EnemyAutomation = NO_AUTOMATION,
	DisableSoftTransitions = false,
	CompatibilityMode = false,
	WelcomeShown = false,
}

local AutomationDropdownItems = {
					{ text = NO_AUTOMATION, value = NO_AUTOMATION } ,
					{ text = DURING_COMBAT, value = DURING_COMBAT } ,
					{ text = OUT_OF_COMBAT, value = OUT_OF_COMBAT } ,
					}

local ProfileList = {
	{ text = "Damage", r = 1 , g =.1 , b = 0, value = "Damage" },
	{ text = "Healer", value = "Healer"},
	{ text = "Tank", value = "Tank"},
}



local TidyPlatesOptionsDefaults = copytable(TidyPlatesOptions)
local TidyPlatesThemeNames = {}
local warned = {}


local function SetCVarCombatCondition(cvar, mode, combat)
	if mode == DURING_COMBAT then
		if combat then
			SetCVar(cvar, 1)
		else
			SetCVar(cvar, 0)
		end
	elseif mode == OUT_OF_COMBAT then
		if combat then
			SetCVar(cvar, 0)
		else
			SetCVar(cvar, 1)
		end
	end
end
--[[

local function ConfigureTheme(spec)
	local themename = TidyPlatesOptions[spec]
	if themename then
		local theme = TidyPlatesThemeList[themename]
		--print("Opening Interface Panel for", themename, theme)
		if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then theme.ShowConfigPanel() end
	end
end

local function ThemeHasPanelLink(themename)
	if themename then
		local theme = TidyPlatesThemeList[themename]
		if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then return true end
	end
end
--]]



-------------------------------------------------------------------------------------
-- Pre-Processor
-------------------------------------------------------------------------------------

local function LoadTheme(incomingtheme)

	local theme, style, stylename, newvalue, propertyname, oldvalue

	-- Sends a reset notification to all available themes, if possible.
	for themename, themetable in pairs(TidyPlatesThemeList) do
		if themetable.OnActivateTheme then themetable.OnActivateTheme(nil, nil) end
	end

	-- Get theme table
	if type(TidyPlatesThemeList) == "table" then
		if type(incomingtheme) == 'string' then
			theme = TidyPlatesThemeList[incomingtheme]
		end
	end

	-- Scrub theme data, and attempt to load
	if type(theme) == 'table' then
		if theme.SetStyle and type(theme.SetStyle) == "function" then
			-- Multi-Style Theme
			for stylename, style in pairs(theme) do
				if type(style) == "table" and style._meta then						-- _meta tag skips parsing
					theme[stylename] = copytable(style)
				elseif type(style) == "table" then									-- merge style with template style
					theme[stylename] = mergetable(TidyPlates.Template, style)		-- ie. fill in the blanks
				end
			end
		else
			-- Single-Style Theme
			for propertyname, oldvalue in pairs(TidyPlates.Template) do
				newvalue = theme[propertyname]
				if type(newvalue) == "table" then theme[propertyname] = mergetable(oldvalue, newvalue)
				else theme[propertyname] = copytable(oldvalue) end
			end
		end

		-- Choices: Overwrite incomingtheme as it's processed, or Overwrite after the processing is done
		TidyPlates:ActivateTheme(theme)

		-- ie. (Theme Table, Theme Name) -- nil is sent for all themes, to reset everything, and then the current theme is activated
		if theme.OnActivateTheme then theme.OnActivateTheme(theme, ActiveProfile) end

		ActiveThemeName = incomingtheme

		return theme
	else

		-- This block falls back to the template, and leaves the field blank...
		ActiveThemeName = nil
		TidyPlatesOptions[ActiveSpecVarReference] = ""
		TidyPlates:ActivateTheme(TidyPlates.Template)

		return nil
	end


end

--TidyPlates.PostLoadTheme = function() end
TidyPlates.LoadTheme = LoadTheme
TidyPlates._LoadTheme = LoadTheme

function TidyPlates:ReloadTheme()
	LoadTheme(TidyPlatesOptions[ActiveSpecVarReference])
	TidyPlates:ForceUpdate()
end


-------------------------------------------------------------------------------------
-- Panel
-------------------------------------------------------------------------------------
local ThemeDropdownMenuItems = {}



local function ApplyAutomationSettings()
	SetSoftTransitions(not TidyPlatesOptions.DisableSoftTransitions)

	if TidyPlatesOptions.CompatibilityMode then EnableCompatibilityMode() end

	if TidyPlatesOptions._EnableMiniButton then
		TidyPlatesUtility:CreateMinimapButton()
		TidyPlatesUtility:ShowMinimapButton()
	end

	TidyPlates:ForceUpdate()
end

local function ApplyThemeSettings()
	--[[
	Right now, the profile system assumes that there's a fixed set of profiles, defined within this file.
	In the future, this will be expanded; Right now, it's simple and dumb
	--]]

	local ActiveSpec = "Primary"
	if TidyPlatesUtility.GetSpec(false, false) == 2 then ActiveSpec = "Secondary" end

	ActiveSpecVarReference = ActiveSpec.."Theme"
	ActiveProfile = TidyPlatesOptions[ActiveSpec.."Profile"] or DefaultProfile

	LoadTheme(TidyPlatesOptions[ActiveSpecVarReference])

	-- Update/Apply
	local Theme = TidyPlatesThemeList[ActiveThemeName]
	if Theme and Theme.OnChangeProfile then Theme.OnChangeProfile(ActiveProfile) end


	if TidyPlatesWidgets then TidyPlatesWidgets:ResetWidgets() end
	TidyPlates:ForceUpdate()
end

local function GetPanelValues(panel)
	TidyPlatesOptions.PrimaryTheme = panel.PrimaryThemeDropdown:GetValue()
	TidyPlatesOptions.SecondaryTheme = panel.SecondaryThemeDropdown:GetValue()
	TidyPlatesOptions.FriendlyAutomation = panel.AutoShowFriendly:GetValue()
	TidyPlatesOptions.EnemyAutomation = panel.AutoShowEnemy:GetValue()
	TidyPlatesOptions.DisableSoftTransitions = panel.DisableSoftTransitions:GetChecked()
	TidyPlatesOptions.CompatibilityMode = panel.CompatibilityMode:GetChecked()
	TidyPlatesOptions.PrimaryProfile = panel.PrimaryProfileDropdown:GetValue()
	TidyPlatesOptions.SecondaryProfile = panel.SecondaryProfileDropdown:GetValue()
end

local function isProfileCompatible(themeName, profile)
	local theme = TidyPlatesThemeList[themeName]
	if theme and theme.OnChangeProfile then
		return true
	end
end

local function ValidateProfiles(panel)
	-- Check Profile Availability
	if isProfileCompatible(TidyPlatesOptions.PrimaryTheme) then
		panel.PrimaryProfileDropdown.Button:Enable()
	else
		panel.PrimaryProfileDropdown.Button:Disable()
	end

	if isProfileCompatible(TidyPlatesOptions.SecondaryTheme) then
		panel.SecondaryProfileDropdown.Button:Enable()
	else
		panel.SecondaryProfileDropdown.Button:Disable()
	end
end


local function OnValueChange(object)
	local panel = object:GetParent()

	-- Get Panel Values
	GetPanelValues(panel)

	ValidateProfiles(panel)

	-- Apply Theme Settings
	ApplyThemeSettings()

	-- Update the profile List
	--print(panel.PrimaryProfileDropdown:GetValue())

	--ActiveProfile = panel.PrimaryProfileDropdown:GetValue()
	-- Check to see if theme is profile enabled

	-- Update Edit Button

	--if ThemeHasPanelLink(TidyPlatesOptions["PrimaryTheme"]) then panel.PrimaryThemeEditButton:Show() else panel.PrimaryThemeEditButton:Hide() end
	--if ThemeHasPanelLink(TidyPlatesOptions["SecondaryTheme"]) then panel.SecondaryThemeEditButton:Show() else panel.SecondaryThemeEditButton:Hide() end
end

local function OnOkay(panel)
	GetPanelValues(panel)
	ApplyThemeSettings()
	ApplyAutomationSettings()
end

-- Loads values from the saved vars, and preps for display of the panel
local function OnRefresh(panel)

	-- GetNumSpecializations()
	local primarySpec = GetSpecialization(false, false, 1)
	local secondarySpec = GetSpecialization(false, false, 2)
	local activeGroup = GetActiveSpecGroup()

	local primarySpecName = "Primary"
	local secondarySpecName = "Secondary"

	if primarySpec then
		local id, name, desc, icon = GetSpecializationInfo(primarySpec)
		primarySpecName = name
	end

	if secondarySpec then
		local id, name, desc, icon = GetSpecializationInfo(secondarySpec)
		secondarySpecName = name
	end

	panel.PrimaryProfileLabel:SetText(primarySpecName.. " Profile:")
	panel.PrimaryThemeLabel:SetText(primarySpecName.. " Theme:")

	panel.SecondaryProfileLabel:SetText(secondarySpecName.. " Profile:")
	panel.SecondaryThemeLabel:SetText(secondarySpecName.. " Theme:")

	ValidateProfiles(panel)

	panel.PrimaryThemeDropdown:SetValue(TidyPlatesOptions.PrimaryTheme)
	panel.SecondaryThemeDropdown:SetValue(TidyPlatesOptions.SecondaryTheme)
	panel.DisableSoftTransitions:SetChecked(TidyPlatesOptions.DisableSoftTransitions)
	panel.CompatibilityMode:SetChecked(TidyPlatesOptions.CompatibilityMode)
	panel.AutoShowFriendly:SetValue(TidyPlatesOptions.FriendlyAutomation)
	panel.AutoShowEnemy:SetValue(TidyPlatesOptions.EnemyAutomation)
	panel.PrimaryProfileDropdown:SetValue(TidyPlatesOptions.PrimaryProfile)
	panel.SecondaryProfileDropdown:SetValue(TidyPlatesOptions.SecondaryProfile)

	-- Update the profile List
	--print(panel.PrimaryProfileDropdown:GetValue())
	-- Check to see if theme is profile enabled

	-- Edit link
	--if ThemeHasPanelLink(TidyPlatesOptions["PrimaryTheme"]) then panel.PrimaryThemeEditButton:Show() else panel.PrimaryThemeEditButton:Hide() end
	--if ThemeHasPanelLink(TidyPlatesOptions["SecondaryTheme"]) then panel.SecondaryThemeEditButton:Show() else panel.SecondaryThemeEditButton:Hide() end
end



local version = GetAddOnMetadata("TidyPlates", "version")
--local versionString = string.gsub(string.gsub(string.gsub(version, "%$", ""), "%(", ""), "%)", "")
local versionString = "|cFF666666"..version
--local versionString = string.gsub(version, "%$", "")
local addonString = GetAddOnMetadata("TidyPlates", "title")
local titleString = addonString			-- .." |cFF444444"..versionString
local firstShow = true


local function CreateMenuTables()
	-- Convert the Theme List into a Menu List
	local themecount = 1

	ThemeDropdownMenuItems = {{text = "           ",},}

	if type(TidyPlatesThemeList) == "table" then
		for themename, themepointer in pairs(TidyPlatesThemeList) do
			TidyPlatesThemeNames[themecount] = themename
			--TidyPlatesThemeIndexes[themename] = themecount
			themecount = themecount + 1
		end
		-- Theme Choices
		for index, name in pairs(TidyPlatesThemeNames) do ThemeDropdownMenuItems[index] = {text = name, value = name } end
	end
	sort(ThemeDropdownMenuItems, function (a,b)
	  return (a.text < b.text)
    end)

end

local function CreateTidyPlatesInterfacePanel(panel)
	panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})
	panel:SetBackdropColor(0.06, 0.06, 0.06, .7)

	panel.Label:SetFont("Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf", 26)
	panel.Label:SetPoint("TOPLEFT", panel, "TOPLEFT", 16+6, -16-4)
	panel.Label:SetTextColor(255/255, 105/255, 6/255)

	panel.Version = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	panel.Version:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -16, -16-4)
	panel.Version:SetHeight(15)
	panel.Version:SetWidth(350)
	panel.Version:SetJustifyH("RIGHT")
	panel.Version:SetJustifyV("TOP")
	panel.Version:SetText(versionString)
	panel.Version:SetFont("Interface\\Addons\\TidyPlates\\Media\\DefaultFont.ttf", 18)

	panel.DividerLine = panel:CreateTexture(nil, 'ARTWORK')
	panel.DividerLine:SetTexture("Interface\\Addons\\TidyPlatesHub\\shared\\ThinBlackLine")
	panel.DividerLine:SetSize( 500, 12)
	panel.DividerLine:SetPoint("TOPLEFT", panel.Label, "BOTTOMLEFT", -6, -12)

	----------------------
	-- Spec
	----------------------
	--  Dropdown
	panel.PrimaryThemeDropdown = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown", panel, ThemeDropdownMenuItems, TidyPlatesDefaultThemeName, nil, true)
	panel.PrimaryThemeDropdown:SetPoint("TOPLEFT", 16-8, -110)

	-- Label
	panel.PrimaryThemeLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.PrimaryThemeLabel:SetPoint("BOTTOMLEFT", panel.PrimaryThemeDropdown,"TOPLEFT", 20, 5)
	panel.PrimaryThemeLabel:SetWidth(170)
	panel.PrimaryThemeLabel:SetJustifyH("LEFT")
	panel.PrimaryThemeLabel:SetText("第一天赋:")

	-- Dropdown
	panel.SecondaryThemeDropdown = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown2", panel, ThemeDropdownMenuItems, TidyPlatesDefaultThemeName, nil, true)
	panel.SecondaryThemeDropdown:SetPoint("TOPLEFT",panel.PrimaryThemeDropdown, "TOPRIGHT", 65, 0)

	-- Label
	panel.SecondaryThemeLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.SecondaryThemeLabel:SetPoint("BOTTOMLEFT", panel.SecondaryThemeDropdown,"TOPLEFT", 20, 5)
	panel.SecondaryThemeLabel:SetWidth(170)
	panel.SecondaryThemeLabel:SetJustifyH("LEFT")
	panel.SecondaryThemeLabel:SetText("第二天赋:")

	panel.ThemeLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.ThemeLabel:SetFont(font, 22)
	panel.ThemeLabel:SetText("Theme")
	panel.ThemeLabel:SetPoint("BOTTOMLEFT", panel.PrimaryThemeDropdown, "TOPLEFT", 16+4, 22)
	panel.ThemeLabel:SetTextColor(255/255, 105/255, 6/255)

-- [[
	----------------------
	-- Profiles
	----------------------

	--  Primary Dropdown
	panel.PrimaryProfileDropdown = PanelHelpers:CreateDropdownFrame("TidyPlatesPrimaryProfileDropdown", panel, ProfileList, DefaultProfile, nil, true)
	--panel.PrimaryProfileDropdown:SetPoint("TOPLEFT", panel.PrimaryThemeDropdown, "TOPLEFT", 16-8, -85)
	panel.PrimaryProfileDropdown:SetPoint("TOPLEFT", panel.PrimaryThemeDropdown, "TOPLEFT", 0, -90)

	-- Label
	panel.PrimaryProfileLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.PrimaryProfileLabel:SetPoint("BOTTOMLEFT", panel.PrimaryProfileDropdown,"TOPLEFT", 20, 5)
	panel.PrimaryProfileLabel:SetWidth(170)
	panel.PrimaryProfileLabel:SetJustifyH("LEFT")
	panel.PrimaryProfileLabel:SetText("第一天赋:")

	-- [[ Button
	panel.EditPrimaryProfile = CreateFrame("Button", "TidyPlatesOptions_EditPrimaryProfile", panel)
	panel.EditPrimaryProfile:SetPoint("TOPLEFT", panel.PrimaryProfileDropdown, "TOPRIGHT", 29, 2)
	panel.EditPrimaryProfile:SetWidth(32)
	panel.EditPrimaryProfile:SetHeight(32)

	panel.EditPrimaryProfile:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	panel.EditPrimaryProfile:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	panel.EditPrimaryProfile:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	panel.EditPrimaryProfile:SetScript("OnClick", function() ShowTidyPlatesHubPanel(TidyPlatesOptions.PrimaryProfile) end)

	-- Secondary Dropdown
	panel.SecondaryProfileDropdown = PanelHelpers:CreateDropdownFrame("TidyPlatesSecondaryProfileDropdown", panel, ProfileList, DefaultProfile, nil, true)
	panel.SecondaryProfileDropdown:SetPoint("TOPLEFT",panel.PrimaryProfileDropdown, "TOPRIGHT", 65, 0)

	-- Label
	panel.SecondaryProfileLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.SecondaryProfileLabel:SetPoint("BOTTOMLEFT", panel.SecondaryProfileDropdown,"TOPLEFT", 20, 5)
	panel.SecondaryProfileLabel:SetWidth(170)
	panel.SecondaryProfileLabel:SetJustifyH("LEFT")
	panel.SecondaryProfileLabel:SetText("第二天赋:")

	panel.ProfileLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.ProfileLabel:SetFont(font, 22)
	panel.ProfileLabel:SetText("Profile")
	panel.ProfileLabel:SetPoint("BOTTOMLEFT", panel.PrimaryProfileDropdown, "TOPLEFT", 16+4, 22)
	panel.ProfileLabel:SetTextColor(255/255, 105/255, 6/255)

	-- [[ Button
	panel.EditSecondaryProfile = CreateFrame("Button", "TidyPlatesOptions_EditSecondaryProfile", panel)
	panel.EditSecondaryProfile:SetPoint("TOPLEFT", panel.SecondaryProfileDropdown, "TOPRIGHT", 29, 2)
	panel.EditSecondaryProfile:SetWidth(32)
	panel.EditSecondaryProfile:SetHeight(32)
	panel.EditSecondaryProfile:SetText("Edit...")
	panel.EditSecondaryProfile:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
	panel.EditSecondaryProfile:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
	panel.EditSecondaryProfile:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
	panel.EditSecondaryProfile:SetScript("OnClick", function() ShowTidyPlatesHubPanel(TidyPlatesOptions.SecondaryProfile) end)



	----------------------
	-- Automation
	----------------------
	-- Enemy Visibility
	panel.AutoShowEnemy = PanelHelpers:CreateDropdownFrame("TidyPlatesAutoShowEnemy", panel, AutomationDropdownItems, NO_AUTOMATION, nil, true)
	--panel.AutoShowEnemy:SetPoint("TOPLEFT", panel.PrimaryThemeDropdown, "TOPLEFT", 0, -75)
	panel.AutoShowEnemy:SetPoint("TOP", panel.PrimaryProfileDropdown, "BOTTOM", 0, -65)
	panel.AutoShowEnemy:SetPoint("LEFT", panel.PrimaryProfileDropdown, "LEFT", 0, 0)
	--panel.AutoShowEnemy:SetPoint("TOPLEFT", panel.PrimaryProfileDropdown, "TOPLEFT", 0, -120)
	--
	panel.AutoShowEnemyLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.AutoShowEnemyLabel:SetPoint("BOTTOMLEFT", panel.AutoShowEnemy,"TOPLEFT", 20, 5)
	panel.AutoShowEnemyLabel:SetWidth(170)
	panel.AutoShowEnemyLabel:SetJustifyH("LEFT")
	panel.AutoShowEnemyLabel:SetText("敌对姓名面板:")

	-- Friendly Visibility
	panel.AutoShowFriendly = PanelHelpers:CreateDropdownFrame("TidyPlatesAutoShowFriendly", panel, AutomationDropdownItems, NO_AUTOMATION, nil, true)
	--panel.AutoShowFriendly:SetPoint("TOPLEFT", panel.PrimaryThemeDropdown, "TOPLEFT", 0, -75)
	panel.AutoShowFriendly:SetPoint("TOPLEFT",panel.AutoShowEnemy, "TOPRIGHT", 65, 0)

	panel.AutoShowFriendlyLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.AutoShowFriendlyLabel:SetPoint("BOTTOMLEFT", panel.AutoShowFriendly,"TOPLEFT", 20, 5)
	panel.AutoShowFriendlyLabel:SetWidth(170)
	panel.AutoShowFriendlyLabel:SetJustifyH("LEFT")
	panel.AutoShowFriendlyLabel:SetText("友方姓名面板:")


	panel.AutomationLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.AutomationLabel:SetFont(font, 22)
	panel.AutomationLabel:SetText("Automation")
	panel.AutomationLabel:SetPoint("BOTTOMLEFT", panel.AutoShowEnemy, "TOPLEFT", 16+4, 22)
	panel.AutomationLabel:SetTextColor(255/255, 105/255, 6/255)

	----------------------
	-- Other Options
	----------------------
	-- Blizz Button
	local BlizzOptionsButton = CreateFrame("Button", "TidyPlatesOptions_BlizzOptionsButton", panel, "TidyPlatesPanelButtonTemplate")
	--BlizzOptionsButton:SetPoint("TOPRIGHT", ResetButton, "TOPLEFT", -8, 0)
	BlizzOptionsButton:SetPoint("TOPLEFT", panel.AutoShowEnemy, "TOPLEFT", 16, -55)
	BlizzOptionsButton:SetWidth(260)
	BlizzOptionsButton:SetText("暴雪姓名面板")

	-- Soft Transitions
	panel.DisableSoftTransitions = PanelHelpers:CreateCheckButton("TidyPlatesOptions_DisableSoftTransitions", panel, "关闭Transition（什么功能我也不懂）")
	panel.DisableSoftTransitions:SetPoint("TOPLEFT", BlizzOptionsButton, "TOPLEFT", 0, -35)
	panel.DisableSoftTransitions:SetScript("OnClick", function(self) SetSoftTransitions(not self:GetChecked()) end)

	-- CompatibilityMode
	panel.CompatibilityMode = PanelHelpers:CreateCheckButton("TidyPlatesOptions_CompatibilityMode", panel, "兼容模式 (重置下UI生效)")
	panel.CompatibilityMode:SetPoint("TOPLEFT", panel.DisableSoftTransitions, "TOPLEFT", 0, -35)
	panel.CompatibilityMode:SetScript("OnClick", function(self) if self:GetChecked() then EnableCompatibilityMode() end; end)

	-- Reset
	ResetButton = CreateFrame("Button", "TidyPlatesOptions_ResetButton", panel, "TidyPlatesPanelButtonTemplate")
	ResetButton:SetPoint("BOTTOMRIGHT", -16, 8)
	ResetButton:SetWidth(155)
	ResetButton:SetText("重新配置")

	-- Update Functions
	panel.okay = OnOkay
	panel.refresh = OnRefresh
	panel.PrimaryThemeDropdown.OnValueChanged = OnValueChange
	panel.SecondaryThemeDropdown.OnValueChanged = OnValueChange
	panel.PrimaryProfileDropdown.OnValueChanged = OnValueChange
	panel.SecondaryProfileDropdown.OnValueChanged = OnValueChange


	-- Blizzard Nameplate Options Button
	BlizzOptionsButton:SetScript("OnClick", function()
		InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
	end)

	-- Reset Button
	ResetButton:SetScript("OnClick", function()
		SetCVar("ShowClassColorInNameplate", 1)		-- Required for Class Detection
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("threatWarning", 3)		-- Required for threat/aggro detection
		_G["InterfaceOptionsNamesPanelUnitNameplatesFriends"]:SetChecked(false)

		if IsShiftKeyDown() then
			TidyPlatesOptions = wipe(TidyPlatesOptions)
			for i, v in pairs(TidyPlatesOptionsDefaults) do TidyPlatesOptions[i] = v end
			SetCVar("nameplateShowFriends", 0)
			ReloadUI()
		else
			TidyPlatesOptions = wipe(TidyPlatesOptions)
			for i, v in pairs(TidyPlatesOptionsDefaults) do TidyPlatesOptions[i] = v end
			OnRefresh(panel)
			ApplyThemeSettings()
			print(yellow.."Resetting "..orange.."Tidy Plates"..yellow.." Theme Selection to Default")
			print(yellow.."Holding down "..blue.."Shift"..yellow.." while clicking "..red.."Reset Configuration"..yellow.." will clear your saved settings, AND reload the user interface.")
		end

	end)
end

-------------------------------------------------------------------------------------
-- Auto-Loader
-------------------------------------------------------------------------------------
local panelevents = {}

function panelevents:ACTIVE_TALENT_GROUP_CHANGED()
	ApplyThemeSettings()
end

function panelevents:PLAYER_ENTERING_WORLD()
	local fallBackTheme

	if TidyPlatesThemeList[FirstTryTheme] then
		fallBackTheme = FirstTryTheme
	else
		for i,v in pairs(TidyPlatesThemeList) do fallBackTheme = i break; end
	end

	-- Check to make sure the selected themes exist, and replace with first available
	if not TidyPlatesThemeList[TidyPlatesOptions.PrimaryTheme] then
		TidyPlatesOptions.PrimaryTheme = fallBackTheme end
	if not TidyPlatesThemeList[TidyPlatesOptions.SecondaryTheme] then
		TidyPlatesOptions.SecondaryTheme = fallBackTheme end

	ApplyThemeSettings()
	ApplyAutomationSettings()
	SetCVar("repositionfrequency", 0)
end

function panelevents:PLAYER_REGEN_ENABLED()
	SetCVarCombatCondition("nameplateShowEnemies", TidyPlatesOptions.EnemyAutomation, false)
	SetCVarCombatCondition("nameplateShowFriends", TidyPlatesOptions.FriendlyAutomation, false)
end

function panelevents:PLAYER_REGEN_DISABLED()
	SetCVarCombatCondition("nameplateShowEnemies", TidyPlatesOptions.EnemyAutomation, true)
	SetCVarCombatCondition("nameplateShowFriends", TidyPlatesOptions.FriendlyAutomation, true)
end

function panelevents:PLAYER_LOGIN()
	CreateMenuTables()
	CreateTidyPlatesInterfacePanel(TidyPlatesInterfacePanel)
	InterfaceOptions_AddCategory(TidyPlatesInterfacePanel);

	if not TidyPlatesOptions.WelcomeShown then
		SetCVar("ShowClassColorInNameplate", 1)		-- Required for Class Detection
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("threatWarning", 3)		-- Required for threat/aggro detection
		TidyPlatesOptions.WelcomeShown = true
	end
end



TidyPlatesInterfacePanel:SetScript("OnEvent", function(self, event, ...) panelevents[event]() end)
for eventname in pairs(panelevents) do TidyPlatesInterfacePanel:RegisterEvent(eventname) end



-------------------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------------------

TidyPlatesSlashCommands = {}
--TidyPlatesSlashCommands.reset = function() print("Tidy Plates: Variables have been reset"); TidyPlatesOptions = copytable(TidyPlatesOptionsDefaults); LoadTheme(TidyPlatesOptions[ActiveSpec]) end


function slash_TidyPlates(arg)
	if type(TidyPlatesSlashCommands[arg]) == 'function' then
		TidyPlatesSlashCommands[arg]()
		TidyPlates:ForceUpdate()
	else
		--InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
		--InterfaceOptionsFrame_OpenToCategory(panel)
		--InterfaceOptionsFrame_OpenToCategory_Fix(panel)
		TidyPlatesUtility.OpenInterfacePanel(TidyPlatesInterfacePanel)
	end
end

SLASH_TIDYPLATES1 = '/tidyplates'
SLASH_TIDYPLATES2 = '/tp'
SlashCmdList['TIDYPLATES'] = slash_TidyPlates;

