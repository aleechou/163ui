
--local CurrentVariableVersion = 591

local CallIn = TidyPlatesUtility.CallIn
local copytable = TidyPlatesUtility.copyTable
local mergetable = TidyPlatesUtility.mergeTable
local PanelHelpers = TidyPlatesUtility.PanelHelpers

local currentThemeName = ""
local activespec = "primary"
local useAutohide = false

local defaultPrimaryTheme = "Neon/|cFFFF4400Damage"
local defaultSecondaryTheme = "Neon/|cFF3782D1Tank"

local NO_AUTOMATION = "不自动"
local DURING_COMBAT = "战斗中显示, 战斗结束隐藏"
local OUT_OF_COMBAT = "战斗开始隐藏, 战斗结束显示"

local function SetAutoHide(option)
	useAutoHide = option
	if useAutoHide and (not InCombat) then SetCVar("nameplateShowEnemies", 0) end
end

--[[
local function SetSpellCastWatcher(enable)
	if enable then TidyPlates:StartSpellCastWatcher()
	else TidyPlates:StopSpellCastWatcher()	end
end
--]]

local function SetSoftTransitions(enable)
	if enable then TidyPlates:EnableFadeIn()
		else TidyPlates:DisableFadeIn() end
end

local EnableCompatibilityMode = TidyPlates.EnableCompatibilityMode


-------------------------------------------------------------------------------------
--  Default Options
-------------------------------------------------------------------------------------

TidyPlatesOptions = {
	primary = defaultPrimaryTheme,
	secondary = defaultSecondaryTheme,
	FriendlyAutomation = NO_AUTOMATION,
	EnemyAutomation = NO_AUTOMATION,
	--EnableCastWatcher = false,
	DisableSoftTransitions = false,
	CompatibilityMode = false,
	WelcomeShown = false,
	--VariableVersion = CurrentVariableVersion,
	--EnableMinimapButton = false,
	--_EnableMiniButton = false,
}

local TidyPlatesOptionsDefaults = copytable(TidyPlatesOptions)
local TidyPlatesThemeNames = {}
local warned = {}

-------------------------------------------------------------------------------------
-- Pre-Processor
-------------------------------------------------------------------------------------
local function LoadTheme(incomingtheme)
	local theme, style, stylename, newvalue, propertyname, oldvalue

	-- Sends a notification to all available themes, if possible.
	for themename, themetable in pairs(TidyPlatesThemeList) do
		if themetable.OnActivateTheme then themetable.OnActivateTheme(nil, nil) end
	end

	-- Get theme table
	if type(TidyPlatesThemeList) == "table" then
		if type(incomingtheme) == 'string' then
			theme = TidyPlatesThemeList[incomingtheme]
		end
	end

	-- If theme does not exist, try to use the default themes
	--[[
	if type(theme) ~= 'table' then
		if activespec == "primary" then
			theme = TidyPlatesThemeList[defaultPrimaryTheme]
		else
			theme = TidyPlatesThemeList[defaultSecondaryTheme]
		end
	end
	--]]

	-- Try to load theme
	if type(theme) == 'table' then
		if theme.SetStyle and type(theme.SetStyle) == "function" then
			-- Multi-Style Theme
			for stylename, style in pairs(theme) do
				if type(style) == "table" then theme[stylename] = mergetable(TidyPlates.Template, style) end
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
		if theme.OnActivateTheme then theme.OnActivateTheme(theme, incomingtheme) end
			-- ie. (Theme Table, Theme Name) -- nil is sent for all themes, to reset everything, and then the current theme is activated

		currentThemeName = incomingtheme
		return theme
	else
		TidyPlatesOptions[activespec] = TidyPlatesDefaultThemeName
		currentThemeName = TidyPlatesDefaultThemeName
		TidyPlates:ActivateTheme(TidyPlatesThemeList[TidyPlatesDefaultThemeName])
		return nil
	end

	--if TidyPlates.PostLoadTheme and type(TidyPlates.PostLoadTheme) == "function" then TidyPlates:PostLoadTheme() end
end

--TidyPlates.PostLoadTheme = function() end
TidyPlates.LoadTheme = LoadTheme
TidyPlates._LoadTheme = LoadTheme

function TidyPlates:ReloadTheme()
	LoadTheme(TidyPlatesOptions[activespec])
	TidyPlates:ForceUpdate()
end


-------------------------------------------------------------------------------------
-- Panel
-------------------------------------------------------------------------------------
local ThemeDropdownMenuItems = {}
local ApplyPanelSettings

local version = GetAddOnMetadata("TidyPlates", "version")
--local versionString = string.gsub(string.gsub(string.gsub(version, "%$", ""), "%(", ""), "%)", "")
local versionString = "|cFF666666"..version
--local versionString = string.gsub(version, "%$", "")
local addonString = GetAddOnMetadata("TidyPlates", "title")
local titleString = addonString			-- .." |cFF444444"..versionString
local firstShow = true



local AutomationDropdownItems = {
					{ text = NO_AUTOMATION, notCheckable = 1 } ,
					{ text = DURING_COMBAT, notCheckable = 1 } ,
					{ text = OUT_OF_COMBAT, notCheckable = 1 } ,
					}

local panel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptions", "Tidy Plates", titleString )
local helppanel = PanelHelpers:CreatePanelFrame( "TidyPlatesInterfaceOptionsHelp", "Troubleshooting" )
panel:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", insets = { left = 2, right = 2, top = 2, bottom = 2 },})

panel:SetBackdropColor(0.06, 0.06, 0.06, .7)

-- Convert the Theme List into a Menu List
local function UpdateThemeNames()
	local themecount = 1
	if type(TidyPlatesThemeList) == "table" then
		for themename, themepointer in pairs(TidyPlatesThemeList) do
			TidyPlatesThemeNames[themecount] = themename
			--TidyPlatesThemeIndexes[themename] = themecount
			themecount = themecount + 1
		end
		-- Theme Choices
		for index, name in pairs(TidyPlatesThemeNames) do ThemeDropdownMenuItems[index] = {text = name, notCheckable = 1 } end
	end
	sort(ThemeDropdownMenuItems, function (a,b)
	  return (a.text < b.text)
    end)
end


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


local function ActivateInterfacePanel()


	panel.Label:SetFont("Fonts\\bLEI00D.TTF", 26)
	panel.Label:SetPoint("TOPLEFT", panel, "TOPLEFT", 16+6, -16-4)

	panel.Version = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	panel.Version:SetPoint("TOPRIGHT", panel, "TOPRIGHT", -16, -16-4)
	panel.Version:SetHeight(15)
	panel.Version:SetWidth(350)
	panel.Version:SetJustifyH("RIGHT")
	panel.Version:SetJustifyV("TOP")
	panel.Version:SetText(versionString)
	panel.Version:SetFont("Fonts\\ARKai_T.ttf", 18)

-- Get Spec Info
--[[
local primarySpecIndex = GetSpecialization( false, false, 1 )
local primarySpecName, primarySpecDescription, primarySpecIcon, primarySpecBackground = select(2, GetSpecializationInfo(primaryspecindex))

--local secondarySpecIndex = GetSpecialization( false, false, 2 )
--local secondarySpecName, secondarySpecDescription, secondarySpecIcon, secondarySpecBackground = select(2, GetSpecializationInfo(secondarySpecIndex))
--]]

--[[
	local font = "Fonts\\ARKai_T.ttf"

	panel.ThemeHeading = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	-- frame.Text:SetFont("Fonts\\FRIZQT__.TTF", 18 )
	-- frame.Text:SetFont("Fonts\\ARIALN.TTF", 18 )
	frame.ThemeHeading:SetFont(font, 22)
	frame.ThemeHeading:SetTextColor(255/255, 105/255, 6/255)
	frame.ThemeHeading:SetAllPoints()
	frame.ThemeHeading:SetText("Theme")
	frame.ThemeHeading:SetJustifyH("LEFT")
	frame.ThemeHeading:SetJustifyV("BOTTOM")
	panel.ThemeHeading:SetPoint("TOPLEFT", panel, "TOPLEFT", 35, -45)

--]]


	----------------------
	-- Primary Spec
	----------------------
	--  Dropdown
	panel.PrimarySpecTheme = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown", panel, ThemeDropdownMenuItems, TidyPlatesDefaultThemeName, nil, true)
	panel.PrimarySpecTheme:SetPoint("TOPLEFT", 16-8, -85)

	-- [[	Prim. Edit Button
	panel.PrimaryEditButton = CreateFrame("Button", "TidyPlatesEditButton", panel)
	panel.PrimaryEditButton:SetPoint("LEFT", panel.PrimarySpecTheme, "RIGHT", 30, 2)
	panel.PrimaryEditButton.Texture = panel.PrimaryEditButton:CreateTexture(nil, "OVERLAY")
	panel.PrimaryEditButton.Texture:SetAllPoints(panel.PrimaryEditButton)
	panel.PrimaryEditButton.Texture:SetTexture( "Interface\\Addons\\TidyPlates\\media\\Wrench")
	panel.PrimaryEditButton:SetHeight(20)
	panel.PrimaryEditButton:SetWidth(20)
	panel.PrimaryEditButton:Enable()
	--panel.PrimaryEditButton.tooltipText = "Theme Settings"
	panel.PrimaryEditButton:EnableMouse()
	panel.PrimaryEditButton:SetScript("OnClick", function() ConfigureTheme("primary") end)
	--]]


	-- Label
	panel.PrimaryLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.PrimaryLabel:SetPoint("BOTTOMLEFT", panel.PrimarySpecTheme,"TOPLEFT", 20, 5)
	panel.PrimaryLabel:SetWidth(170)
	panel.PrimaryLabel:SetJustifyH("LEFT")
	panel.PrimaryLabel:SetText("第一天赋:")

	----------------------
	-- Secondary Spec
	----------------------
	-- Dropdown
	panel.SecondarySpecTheme = PanelHelpers:CreateDropdownFrame("TidyPlatesChooserDropdown2", panel, ThemeDropdownMenuItems, TidyPlatesDefaultThemeName, nil, true)
	panel.SecondarySpecTheme:SetPoint("TOPLEFT",panel.PrimarySpecTheme, "TOPRIGHT", 55, 0)

	-- [[	Sec. Edit Button
	panel.SecondaryEditButton = CreateFrame("Button", "TidyPlatesEditButton", panel)
	panel.SecondaryEditButton:SetPoint("LEFT", panel.SecondarySpecTheme, "RIGHT", 30, 2)
	panel.SecondaryEditButton.Texture = panel.SecondaryEditButton:CreateTexture(nil, "OVERLAY")
	panel.SecondaryEditButton.Texture:SetAllPoints(panel.SecondaryEditButton)
	panel.SecondaryEditButton.Texture:SetTexture( "Interface\\Addons\\TidyPlates\\media\\Wrench")
	panel.SecondaryEditButton:SetHeight(20)
	panel.SecondaryEditButton:SetWidth(20)
	panel.SecondaryEditButton:Enable()
	--panel.SecondaryEditButton.tooltipText = "Theme Settings"
	panel.SecondaryEditButton:EnableMouse()
	panel.SecondaryEditButton:SetScript("OnClick", function() ConfigureTheme("secondary") end)
	--]]

	-- Label
	panel.SecondaryLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.SecondaryLabel:SetPoint("BOTTOMLEFT", panel.SecondarySpecTheme,"TOPLEFT", 20, 5)
	panel.SecondaryLabel:SetWidth(170)
	panel.SecondaryLabel:SetJustifyH("LEFT")
	panel.SecondaryLabel:SetText("第二天赋:")

	----------------------
	-- Other Options
	----------------------


	-- Enemy Visibility
	panel.AutoShowEnemy = PanelHelpers:CreateDropdownFrame("TidyPlatesAutoShowEnemy", panel, AutomationDropdownItems, NO_AUTOMATION, nil, true)
	panel.AutoShowEnemy:SetPoint("TOPLEFT", panel.PrimarySpecTheme, "TOPLEFT", 0, -75)
	--
	panel.AutoShowEnemyLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.AutoShowEnemyLabel:SetPoint("BOTTOMLEFT", panel.AutoShowEnemy,"TOPLEFT", 20, 5)
	panel.AutoShowEnemyLabel:SetWidth(170)
	panel.AutoShowEnemyLabel:SetJustifyH("LEFT")
	panel.AutoShowEnemyLabel:SetText("敌对姓名面板:")

	-- Friendly Visibility
	panel.AutoShowFriendly = PanelHelpers:CreateDropdownFrame("TidyPlatesAutoShowFriendly", panel, AutomationDropdownItems, NO_AUTOMATION, nil, true)
	--panel.AutoShowFriendly:SetPoint("TOPLEFT", panel.PrimarySpecTheme, "TOPLEFT", 0, -75)
	panel.AutoShowFriendly:SetPoint("TOPLEFT",panel.AutoShowEnemy, "TOPRIGHT", 55, 0)
	--
	panel.AutoShowFriendlyLabel = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	panel.AutoShowFriendlyLabel:SetPoint("BOTTOMLEFT", panel.AutoShowFriendly,"TOPLEFT", 20, 5)
	panel.AutoShowFriendlyLabel:SetWidth(170)
	panel.AutoShowFriendlyLabel:SetJustifyH("LEFT")
	panel.AutoShowFriendlyLabel:SetText("友方姓名面板:")

	--[[
	panel.AutomationDescription = panel:CreateFontString(nil, 'ARTWORK') --, 'GameFontLarge'
	panel.AutomationDescription:SetFont("Fonts\\ARKai_T.ttf", 10, nil)
	panel.AutomationDescription:SetPoint("BOTTOMLEFT", panel.AutoShowEnemy, "TOPLEFT", 20, 20)
	panel.AutomationDescription:SetWidth(340)
	panel.AutomationDescription:SetHeight(50)
	panel.AutomationDescription:SetJustifyH("LEFT")
	panel.AutomationDescription:SetText(
		"Automation can automatically turn on or off Friendly and Enemy nameplates. ")
	panel.AutomationDescription:SetTextColor(1,1,1,1)
--]]

	-- Blizz Button
	local BlizzOptionsButton = CreateFrame("Button", "TidyPlatesOptions_BlizzOptionsButton", panel, "TidyPlatesPanelButtonTemplate")
	--BlizzOptionsButton:SetPoint("TOPRIGHT", ResetButton, "TOPLEFT", -8, 0)
	BlizzOptionsButton:SetPoint("TOPLEFT", panel.AutoShowEnemy, "TOPLEFT", 16, -55)
	BlizzOptionsButton:SetWidth(260)
	BlizzOptionsButton:SetText("暴雪姓名面板")

	--[[
	-- Cast Watcher
	panel.EnableCastWatcher = PanelHelpers:CreateCheckButton("TidyPlatesOptions_EnableCastWatcher", panel, "Show Off-Target Cast Bars")
	panel.EnableCastWatcher:SetPoint("TOPLEFT", BlizzOptionsButton, "TOPLEFT", 0, -35)
	panel.EnableCastWatcher:SetScript("OnClick", function(self) SetSpellCastWatcher(self:GetChecked()) end)
--]]

	-- Soft Transitions
	panel.DisableSoftTransitions = PanelHelpers:CreateCheckButton("TidyPlatesOptions_DisableSoftTransitions", panel, "关闭Transition（什么功能我也不懂）")
	panel.DisableSoftTransitions:SetPoint("TOPLEFT", BlizzOptionsButton, "TOPLEFT", 0, -35)
	panel.DisableSoftTransitions:SetScript("OnClick", function(self) SetSoftTransitions(not self:GetChecked()) end)

	-- CompatibilityMode
	panel.CompatibilityMode = PanelHelpers:CreateCheckButton("TidyPlatesOptions_CompatibilityMode", panel, "兼容模式 (重置下UI生效)")
	panel.CompatibilityMode:SetPoint("TOPLEFT", panel.DisableSoftTransitions, "TOPLEFT", 0, -35)
	panel.CompatibilityMode:SetScript("OnClick", function(self) if self:GetChecked() then EnableCompatibilityMode() end; end)

	-- Minimap Button
	--[[
	panel.EnableMinimapButton = PanelHelpers:CreateCheckButton("TidyPlatesOptions_EnableMinimapButton", panel, "Enable Minimap Icon")
	panel.EnableMinimapButton:SetPoint("TOPLEFT", panel.DisableSoftTransitions, "TOPLEFT", 0, -35)
	-- panel.EnableMinimapButton:SetScript("OnClick", function(self) if self:GetChecked() then TidyPlatesUtility:ShowMinimapButton() else TidyPlatesUtility:HideMinimapButton() end; end)
	panel.EnableMinimapButton:Hide()
	--]]

	-- Reset
	ResetButton = CreateFrame("Button", "TidyPlatesOptions_ResetButton", panel, "TidyPlatesPanelButtonTemplate")
	ResetButton:SetPoint("BOTTOMRIGHT", -16, 8)
	ResetButton:SetWidth(155)
	ResetButton:SetText("重新配置")

	-- Update Functions
	panel.okay = ApplyPanelSettings
	panel.PrimarySpecTheme.OnValueChanged = ApplyPanelSettings
	panel.SecondarySpecTheme.OnValueChanged = ApplyPanelSettings

	local function RefreshPanel()
		panel.PrimarySpecTheme:SetValue(TidyPlatesOptions.primary)
		panel.SecondarySpecTheme:SetValue(TidyPlatesOptions.secondary)
		--panel.EnableCastWatcher:SetChecked(TidyPlatesOptions.EnableCastWatcher)
		panel.DisableSoftTransitions:SetChecked(TidyPlatesOptions.DisableSoftTransitions)
		panel.CompatibilityMode:SetChecked(TidyPlatesOptions.CompatibilityMode)

		--panel.EnableMinimapButton:SetChecked(TidyPlatesOptions.EnableMinimapButton)
		panel.AutoShowFriendly:SetValue(TidyPlatesOptions.FriendlyAutomation)
		panel.AutoShowEnemy:SetValue(TidyPlatesOptions.EnemyAutomation)

		if ThemeHasPanelLink(TidyPlatesOptions["primary"]) then panel.PrimaryEditButton:Show() else panel.PrimaryEditButton:Hide() end
		if ThemeHasPanelLink(TidyPlatesOptions["secondary"]) then panel.SecondaryEditButton:Show() else panel.SecondaryEditButton:Hide() end

	end

	panel.refresh = RefreshPanel

	local yellow, blue, red, orange = "|cffffff00", "|cFF3782D1", "|cFFFF1100", "|cFFFF6906"

	BlizzOptionsButton:SetScript("OnClick", function()
		InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
	end)

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
			RefreshPanel()
			ApplyPanelSettings()
			-- InterfaceOptionsNamesPanel
			-- InterfaceOptionsNamesPanelUnitNameplatesFriends
			-- InterfaceOptionsFrame_OpenToCategory(
			--print(_G["InterfaceOptionsNamesPanelUnitNameplatesFriends"]:GetChecked())
			-- InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"])
			print(yellow.."Resetting "..orange.."Tidy Plates"..yellow.." Theme Selection to Default")
			print(yellow.."Holding down "..blue.."Shift"..yellow.." while clicking "..red.."Reset Configuration"..yellow.." will clear your saved settings, AND reload the user interface.")
		end

	end)


end


TidyPlatesInterfacePanel = panel
InterfaceOptions_AddCategory(panel);


local function ApplyAutomationSettings()
	--SetSpellCastWatcher(TidyPlatesOptions.EnableCastWatcher)
	SetSoftTransitions(not TidyPlatesOptions.DisableSoftTransitions)
	if TidyPlatesOptions.CompatibilityMode then EnableCompatibilityMode() end

	if TidyPlatesOptions._EnableMiniButton then
		TidyPlatesUtility:CreateMinimapButton()
		TidyPlatesUtility:ShowMinimapButton()
	end

	TidyPlates:ForceUpdate()
end

ApplyPanelSettings = function()
	TidyPlatesOptions.primary = panel.PrimarySpecTheme:GetValue()
	TidyPlatesOptions.secondary = panel.SecondarySpecTheme:GetValue()
	TidyPlatesOptions.FriendlyAutomation = panel.AutoShowFriendly:GetValue()
	TidyPlatesOptions.EnemyAutomation = panel.AutoShowEnemy:GetValue()
	--TidyPlatesOptions.EnableCastWatcher = panel.EnableCastWatcher:GetChecked()
	TidyPlatesOptions.DisableSoftTransitions = panel.DisableSoftTransitions:GetChecked()
	TidyPlatesOptions.CompatibilityMode = panel.CompatibilityMode:GetChecked()

	--TidyPlatesOptions.EnableMinimapButton = panel.EnableMinimapButton:GetChecked()

	-- Clear Widgets
	if TidyPlatesWidgets then TidyPlatesWidgets:ResetWidgets() end

	if currentThemeName ~= TidyPlatesOptions[activespec] then
		LoadTheme(TidyPlatesOptions[activespec])
	end

	-- Update Appearance
	ApplyAutomationSettings()

	-- Editing Link
	if ThemeHasPanelLink(TidyPlatesOptions["primary"]) then panel.PrimaryEditButton:Show() else panel.PrimaryEditButton:Hide() end
	if ThemeHasPanelLink(TidyPlatesOptions["secondary"]) then panel.SecondaryEditButton:Show() else panel.SecondaryEditButton:Hide() end

end

--[[
local function CreatePopup()
	StaticPopupDialogs["EXAMPLE_HELLOWORLD"] = {
				text = "Tidy Plates: The configuration format has changed! The addon may not work properly with older settings.",
				button1 = "Reset Configuration",
				button2 = "Ignore",
				OnCancel = function()

				end,
				OnAccept = function()
					-- InterfaceOptionsFrame_OpenToCategory(panel)

					-- Wipe Core
					TidyPlatesOptions = wipe(TidyPlatesOptions)
					for i, v in pairs(TidyPlatesOptionsDefaults) do TidyPlatesOptions[i] = v end
					SetCVar("nameplateShowFriends", 0)

					-- Wipe Hub
					for objectname, set in pairs(TidyPlatesHubSettings) do
						for varname, data in pairs(set) do
							TidyPlatesHubSettings[objectname][varname] = nil
						end
						TidyPlatesHubSettings[objectname] = nil
					end

					ReloadUI()

				end,
				--timeout = 10,
				whileDead = true,
				hideOnEscape = true,
				preferredIndex = STATICPOPUP_NUMDIALOGS + 1,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
	}
	StaticPopup_Show ("EXAMPLE_HELLOWORLD")
end
--]]


local function ShowWelcome()
	if not TidyPlatesOptions.WelcomeShown then
		SetCVar("ShowClassColorInNameplate", 1)		-- Required for Class Detection
		SetCVar("nameplateShowEnemies", 1)
		SetCVar("nameplateShowFriends", 0)
		SetCVar("threatWarning", 3)		-- Required for threat/aggro detection
		TidyPlatesOptions.WelcomeShown = true
	end

	--[[
	if TidyPlatesOptions.VariableVersion ~= CurrentVariableVersion then
		CreatePopup()
		TidyPlatesOptions.VariableVersion = CurrentVariableVersion
	end
	--]]

end

-------------------------------------------------------------------------------------
-- Auto-Loader
-------------------------------------------------------------------------------------
local panelevents = {}

local function ShowWarnings()
	if TidyPlatesWidgets then
		if not( TidyPlatesWidgets.DebuffWidgetBuild and TidyPlatesWidgets.DebuffWidgetBuild > 1) then
			print("|cFFFF6600Tidy Plates: |cFFFFFFFFWidget file versions do not match.  This may be caused by an issue with auto-updater software.",
				"Please uninstall Tidy Plates, and then re-install.  You do NOT need to clear your variables.")
		end
	end


	--[[ Warn user if no theme is selected
	if currentThemeName == TidyPlatesDefaultThemeName and not warned[activespec] then
		print("|cFF77FF00Use |cFFFFFF00/tidyplates|cFF77FF00 to bring up the Theme Selection Window")
		warned[activespec] = true
	end
	--]]
end

function panelevents:ACTIVE_TALENT_GROUP_CHANGED()
	if TidyPlatesUtility.GetSpec(false, false) == 2 then activespec = "secondary"
	else activespec = "primary" end
	LoadTheme(TidyPlatesOptions[activespec])

	if TidyPlatesWidgets then TidyPlatesWidgets:ResetWidgets() end
	TidyPlates:ForceUpdate()

	CallIn(ShowWarnings, 2)
end

function panelevents:PLAYER_ENTERING_WORLD() panelevents:ACTIVE_TALENT_GROUP_CHANGED() end

-- NO_AUTOMATION, DURING_COMBAT, OUT_OF_COMBAT
--if TidyPlatesOptions.FriendlyAutomation
--if TidyPlatesOptions.EnemyAutomation

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

function panelevents:PLAYER_REGEN_ENABLED()
	SetCVarCombatCondition("nameplateShowEnemies", TidyPlatesOptions.EnemyAutomation, false)
	SetCVarCombatCondition("nameplateShowFriends", TidyPlatesOptions.FriendlyAutomation, false)
end

function panelevents:PLAYER_REGEN_DISABLED()
	SetCVarCombatCondition("nameplateShowEnemies", TidyPlatesOptions.EnemyAutomation, true)
	SetCVarCombatCondition("nameplateShowFriends", TidyPlatesOptions.FriendlyAutomation, true)
end


function panelevents:PLAYER_LOGIN()
	--TidyPlatesUtility:CreateMinimapButton()
	UpdateThemeNames()
	ActivateInterfacePanel()
	ShowWelcome()
	LoadTheme(TidyPlatesDefaultThemeName)
	ApplyAutomationSettings()
	SetCVar("repositionfrequency", 0)
end

panel:SetScript("OnEvent", function(self, event, ...) panelevents[event]() end)
for eventname in pairs(panelevents) do panel:RegisterEvent(eventname) end

-------------------------------------------------------------------------------------
-- Slash Commands
-------------------------------------------------------------------------------------

TidyPlatesSlashCommands = {}
--TidyPlatesSlashCommands.reset = function() print("Tidy Plates: Variables have been reset"); TidyPlatesOptions = copytable(TidyPlatesOptionsDefaults); LoadTheme(TidyPlatesOptions[activespec]) end


function slash_TidyPlates(arg)
	if type(TidyPlatesSlashCommands[arg]) == 'function' then
		TidyPlatesSlashCommands[arg]()
		TidyPlates:ForceUpdate()
	else
		--InterfaceOptionsFrame_OpenToCategory("Tidy Plates")
		--InterfaceOptionsFrame_OpenToCategory(panel)
		--InterfaceOptionsFrame_OpenToCategory_Fix(panel)
		TidyPlatesUtility.OpenInterfacePanel(panel)
	end
end

SLASH_TIDYPLATES1 = '/tidyplates'
SlashCmdList['TIDYPLATES'] = slash_TidyPlates;

