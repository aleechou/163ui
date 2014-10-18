
-- Rapid Panel Functions
local CreateQuickSlider = TidyPlatesHubRapidPanel.CreateQuickSlider
local CreateQuickCheckbutton = TidyPlatesHubRapidPanel.CreateQuickCheckbutton
local SetSliderMechanics = TidyPlatesHubRapidPanel.SetSliderMechanics
local CreateQuickEditbox = TidyPlatesHubRapidPanel.CreateQuickEditbox
local CreateQuickColorbox = TidyPlatesHubRapidPanel.CreateQuickColorbox
local CreateQuickDropdown = TidyPlatesHubRapidPanel.CreateQuickDropdown
local CreateQuickHeadingLabel = TidyPlatesHubRapidPanel.CreateQuickHeadingLabel
local CreateQuickItemLabel = TidyPlatesHubRapidPanel.CreateQuickItemLabel
local OnMouseWheelScrollFrame = TidyPlatesHubRapidPanel.OnMouseWheelScrollFrame
local CreateInterfacePanel = TidyPlatesHubRapidPanel.CreateInterfacePanel

local SetColumn = TidyPlatesHubRapidPanel.SetColumn
local SetActivePanel = TidyPlatesHubRapidPanel.SetActivePanel
local SetOffset = TidyPlatesHubRapidPanel.SetOffset
local UndoOffset = TidyPlatesHubRapidPanel.UndoOffset

-- Modes
local ThemeList = TidyPlatesHubModes.ThemeList
local StyleModes = TidyPlatesHubModes.StyleModes
local TextModes = TidyPlatesHubModes.TextModes
local RangeModes = TidyPlatesHubModes.RangeModes
local AuraWidgetModes = TidyPlatesHubModes.AuraWidgetModes
local DebuffStyles = TidyPlatesHubModes.DebuffStyles
local OpacityModes = TidyPlatesHubModes.OpacityModes
local ScaleModes = TidyPlatesHubModes.ScaleModes
local HealthColorModes = TidyPlatesHubModes.HealthColorModes
local WarningGlowModes = TidyPlatesHubModes.WarningGlowModes
local ThreatWidgetModes = TidyPlatesHubModes.ThreatWidgetModes
local NameColorModes = TidyPlatesHubModes.NameColorModes
local TextPlateFieldModes = TidyPlatesHubModes.TextPlateFieldModes
local ArtStyles = TidyPlatesHubModes.ArtStyles
local ArtModes = TidyPlatesHubModes.ArtModes
local ThreatModes = TidyPlatesHubModes.ThreatModes

------------------------------------------------------------------
-- Generate Panel
------------------------------------------------------------------
local function CreateInterfacePanelWidgets(panel)
	local objectName = panel.objectName
	local AlignmentColumn = panel.AlignmentColumn
	local OffsetColumnB = 200	-- 240

	SetActivePanel(panel)
	SetColumn(AlignmentColumn, nil)

	------------------------------
	-- Style
	------------------------------
	CreateQuickHeadingLabel("StyleLabel", "Style", 0, 5)

	-- Enemy Nameplates
	CreateQuickDropdown("StyleEnemyMode", "Enemy Nameplates:", StyleModes, 1, 0, 2)
	CreateQuickDropdown("ColorEnemyHealthBarMode", "Health Bar Color:", HealthColorModes, 1 )
	CreateQuickDropdown("ColorEnemyDangerGlowMode", "Warning Border/Glow:", WarningGlowModes, 1)
	CreateQuickDropdown("TextEnemyNameColorMode", "Name Text Color:", NameColorModes, 1)
	CreateQuickDropdown("TextEnemyHealthTextMode", "Optional Text Field:", TextModes, 1)

	-- Friendly Nameplates
	--[[
	SetOffset("StyleLabel")
	CreateQuickDropdown("StyleFriendlyMode", "Friendly Nameplates:", StyleModes, 1, OffsetColumnB, 2)
	CreateQuickDropdown("ColorFriendlyHealthBarMode", "Health Bar Color:", HealthColorModes, 1, OffsetColumnB)
	CreateQuickDropdown("ColorFriendlyDangerGlowMode", "Warning Border/Glow:", WarningGlowModes, 1, OffsetColumnB)
	CreateQuickDropdown("TextFriendlyNameColorMode", "Name Text Color:", NameColorModes, 1, OffsetColumnB)
	CreateQuickDropdown("TextFriendlyHealthTextMode", "Optional Text Field:", TextModes, 1, OffsetColumnB)
	UndoOffset()
	--]]

	------------------------------
	-- Headline View
	------------------------------
	CreateQuickHeadingLabel("HeadlineModeLabel", "Headline Mode", 0, 5)
	CreateQuickDropdown("TextPlateNameColorMode", "Name Text Color:", NameColorModes, 1)	-- |cffee9900Text-Only Style
	CreateQuickDropdown("TextPlateFieldMode", "Optional Text Field:", TextPlateFieldModes, 1)	-- |cffee9900Text-Only Style

	------------------------------
    -- Health Bar Mode:
	------------------------------
    -- Color & Text: Column 1
	CreateQuickHeadingLabel("HealthBarModeLabel", "Health Bar Mode", 0, 5)

	CreateQuickCheckbutton("TextShowLevel", "Show Level", OffsetColumnB)
	CreateQuickCheckbutton("TextUseBlizzardFont", "Use Default Blizzard Font", OffsetColumnB)
    CreateQuickCheckbutton("TextShowOnlyOnTargets", "Only Show Optional Text on Target", OffsetColumnB)

	------------------------------
	--Opacity
	------------------------------
	CreateQuickHeadingLabel("OpacityLabel", "Opacity", 0, 5)
	CreateQuickSlider("OpacityTarget", "Current Target Opacity:", 0, 2)
	CreateQuickSlider("OpacityNonTarget", "Non-Target Opacity:", 0, 2)
	CreateQuickDropdown("OpacitySpotlightMode", "Opacity Spotlight Mode:", OpacityModes, 1)
	CreateQuickSlider("OpacitySpotlight", "Spotlight Opacity:", 0, 2)
	CreateQuickCheckbutton("OpacityFullSpell", "Bring Casting Units to Target Opacity", 16)
	CreateQuickCheckbutton("OpacityFullMouseover", "Bring Mouseovers to Target Opacity", 16)
	panel.OpacityFullNoTarget = CreateQuickCheckbutton("OpacityFullNoTarget", "Use Target Opacity When No Target Exists", 16)

	------------------------------
	-- Filter
	--------------------------------
	panel.FilterLabel = CreateQuickHeadingLabel("FilterLabel", "Filter", 0, 5)
	panel.OpacityFiltered = CreateQuickSlider("OpacityFiltered", "Filtered Unit Opacity:", 0, 2)
	panel.ScaleFiltered = CreateQuickSlider("ScaleFiltered", "Filtered Unit Scale:", 0, 2)

	panel.OpacityFilterNeutralUnits = CreateQuickCheckbutton("OpacityFilterNeutralUnits", "Filter Neutral Units", 8, 4)
	panel.OpacityFilterNonElite = CreateQuickCheckbutton("OpacityFilterNonElite", "Filter Non-Elite", 8)
	panel.OpacityFilterNPC = CreateQuickCheckbutton("OpacityFilterNPC", "Filter NPC", 8)
	panel.OpacityFilterFriendlyNPC = CreateQuickCheckbutton("OpacityFilterFriendlyNPC", "Filter Friendly NPC", 8)

    panel.OpacityFilterPlayers = CreateQuickCheckbutton("OpacityFilterPlayers", "Filter Players", OffsetColumnB, 4)
	panel.OpacityFilterInactive = CreateQuickCheckbutton("OpacityFilterInactive", "Filter Inactive", OffsetColumnB)
	panel.OpacityFilterMini = CreateQuickCheckbutton("OpacityFilterMini", "Filter Mini-Mobs", OffsetColumnB)

	panel.OpacityCustomFilterLabel = CreateQuickItemLabel("OpacityCustomFilterLabel", "Filter By Unit Name:", 8, 4)
	panel.OpacityFilterList = CreateQuickEditbox("OpacityFilterList", 8)

	------------------------------
	--Scale
	------------------------------
	panel.ScaleLabel = CreateQuickHeadingLabel("ScaleLabel", "Scale", 0, 5)
	panel.ScaleStandard = CreateQuickSlider("ScaleStandard", "Normal Scale:", 0, 2)
	panel.ScaleSpotlightMode =  CreateQuickDropdown("ScaleSpotlightMode", "Scale Spotlight Mode:", ScaleModes, 1)
	panel.ScaleSpotlight = CreateQuickSlider("ScaleSpotlight", "Spotlight Scale:", 0, 2)
	panel.ScaleIgnoreNeutralUnits= CreateQuickCheckbutton("ScaleIgnoreNeutralUnits", "Ignore Neutral Units", 16)
	panel.ScaleIgnoreNonEliteUnits= CreateQuickCheckbutton("ScaleIgnoreNonEliteUnits", "Ignore Non-Elite Units", 16)
	panel.ScaleIgnoreInactive= CreateQuickCheckbutton("ScaleIgnoreInactive", "Ignore Inactive Units", 16)
	panel.ScaleCastingSpotlight= CreateQuickCheckbutton("ScaleCastingSpotlight", "Bring Casting Units to Spotlight Scale", 0)

    ------------------------------
	-- Reaction
	------------------------------

    panel.ReactionLabel = CreateQuickHeadingLabel("ReactionLabel", "Reaction", 0, 5)
	panel.ReactionColorLabel = CreateQuickItemLabel("ReactionColorLabel", "Health Bar Color:", 0, 2)
	panel.ColorFriendlyNPC = CreateQuickColorbox("ColorFriendlyNPC", "Friendly NPC" , 16)
	panel.ColorFriendlyPlayer = CreateQuickColorbox("ColorFriendlyPlayer", "Friendly Player" , 16)
	panel.ColorNeutral= CreateQuickColorbox("ColorNeutral", "Neutral" , 16)
	panel.ColorHostileNPC = CreateQuickColorbox("ColorHostileNPC", "Hostile NPC" , 16)
	panel.ColorHostilePlayer = CreateQuickColorbox("ColorHostilePlayer", "Hostile Player" , 16)
	panel.ColorGuildMember = CreateQuickColorbox("ColorGuildMember", "Guild Member" , 16)
        -- Column 2
        panel.TextReactionColorLabel = CreateQuickItemLabel("TextReactionColorLabel", "Text Color:", OffsetColumnB )
	panel.TextColorFriendlyNPC = CreateQuickColorbox("TextColorFriendlyNPC", "Friendly NPC" , OffsetColumnB + 16)
	panel.TextColorFriendlyPlayer = CreateQuickColorbox("TextColorFriendlyPlayer", "Friendly Player" , OffsetColumnB + 16)
	panel.TextColorNeutral= CreateQuickColorbox("TextColorNeutral", "Neutral" , OffsetColumnB + 16)
	panel.TextColorHostileNPC = CreateQuickColorbox("TextColorHostileNPC", "Hostile NPC" , OffsetColumnB + 16)
	panel.TextColorHostilePlayer = CreateQuickColorbox("TextColorHostilePlayer", "Hostile Player" , OffsetColumnB + 16)
	panel.TextColorGuildMember = CreateQuickColorbox("TextColorGuildMember", "Guild Member" , OffsetColumnB + 16)

	------------------------------
	-- Threat
	------------------------------
        -- Column 1
	panel.ThreatLabel = CreateQuickHeadingLabel("ThreatLabel", "Threat", 0, 5)
	panel.ThreatMode =  CreateQuickDropdown("ThreatMode", "Threat Mode:", ThreatModes, 1, 0, 2)
	panel.ColorThreatColorLabels = CreateQuickItemLabel("ColorThreatColorLabels", "Threat Colors:", 0, 2)
	panel.ColorAttackingMe = CreateQuickColorbox("ColorAttackingMe", "Warning" , 16)
	panel.ColorAggroTransition = CreateQuickColorbox("ColorAggroTransition", "Transition" , 16)
	panel.ColorAttackingOthers = CreateQuickColorbox("ColorAttackingOthers", "Safe", 16)

        -- Column 2
	panel.ColorEnableOffTank = CreateQuickCheckbutton("ColorEnableOffTank", "Highlight Mobs Tanked by other Tanks", OffsetColumnB)
	panel.ColorAttackingOtherTank = CreateQuickColorbox("ColorAttackingOtherTank", "Attacking another Tank" , 16+OffsetColumnB)

	panel.ColorShowPartyAggro = CreateQuickCheckbutton("ColorShowPartyAggro", "Highlight Group Members holding Aggro", OffsetColumnB)
	panel.ColorPartyAggro = CreateQuickColorbox("ColorPartyAggro", "Group Member Aggro" , 14+OffsetColumnB)
	panel.ColorPartyAggroBar = CreateQuickCheckbutton("ColorPartyAggroBar", "Health Bar Color", 16+OffsetColumnB)
	panel.ColorPartyAggroGlow = CreateQuickCheckbutton("ColorPartyAggroGlow", "Border/Warning Glow", 16+OffsetColumnB)
	panel.ColorPartyAggroText = CreateQuickCheckbutton("ColorPartyAggroText", "Name Text Color", 16+OffsetColumnB)

	------------------------------
	-- Health
	------------------------------
	panel.HealthLabel = CreateQuickHeadingLabel("HealthLabel", "Health", 0, 5)
	panel.HighHealthThreshold = CreateQuickSlider("HighHealthThreshold", "High Health Threshold:", 0, 2)
	panel.LowHealthThreshold =  CreateQuickSlider("LowHealthThreshold", "Low Health Threshold:", 0, 2)
	panel.HealthColorLabels = CreateQuickItemLabel("HealthColorLabels", "Health Colors:", 0)
	panel.ColorHighHealth = CreateQuickColorbox("ColorHighHealth", "High Health" , 16)
	panel.ColorMediumHealth = CreateQuickColorbox("ColorMediumHealth", "Medium Health" , 16)
	panel.ColorLowHealth = CreateQuickColorbox("ColorLowHealth", "Low Health" , 16)

        ------------------------------
	-- Casting
	------------------------------
        panel.SpellCastLabel = CreateQuickHeadingLabel("SpellCastLabel", "Spell Casting", 0, 5)
	panel.SpellCastColorLabel = CreateQuickItemLabel("SpellCastColorLabel", "Cast Bar Colors:", 0, 2)
	panel.ColorNormalSpellCast = CreateQuickColorbox("ColorNormalSpellCast", "Normal" , 16)
	panel.ColorUnIntpellCast = CreateQuickColorbox("ColorUnIntpellCast", "Un-interruptible" , 16)

	------------------------------
	-- Aura (Buff and Debuff) Widget
	------------------------------
	panel.DebuffsLabel = CreateQuickHeadingLabel("DebuffsLabel", "Buffs & Debuffs", 0, 5)
	panel.WidgetsDebuff = CreateQuickCheckbutton("WidgetsDebuff", "Show Aura Timers")
	panel.WidgetsDebuffStyle =  CreateQuickDropdown("WidgetsDebuffStyle", "Icon Style:", DebuffStyles, 1, 16)
	panel.WidgetsAuraMode =  CreateQuickDropdown("WidgetsAuraMode", "Filter Mode:", AuraWidgetModes, 1, 16)		-- used to be WidgetsDebuffMode
	panel.WidgetsDebuffListLabel = CreateQuickItemLabel("WidgetsDebuffListLabel", "Aura List:", 16)
	panel.WidgetsDebuffTrackList = CreateQuickEditbox("WidgetsDebuffTrackList", 16)

	panel.WidgetAuraTrackDispelFriendly = CreateQuickCheckbutton("WidgetAuraTrackDispelFriendly", "Track Dispellable Debuffs on Friendly Units", 0, 4)
	panel.WidgetAuraTrackCurse = CreateQuickCheckbutton("WidgetAuraTrackCurse", "Curse", 16, -2)
	panel.WidgetAuraTrackDisease = CreateQuickCheckbutton("WidgetAuraTrackDisease", "Disease", 16, -2)
	panel.WidgetAuraTrackMagic = CreateQuickCheckbutton("WidgetAuraTrackMagic", "Magic", 16, -2)
	panel.WidgetAuraTrackPoison = CreateQuickCheckbutton("WidgetAuraTrackPoison", "Poison", 16, -2)
	--panel.WidgetAuraColorDispelFriendly = CreateQuickCheckbutton("WidgetAuraColorDispelFriendly", "Colored Highlight ", AlignmentColumn, panel.WidgetAuraTrackMagic, 16, -2)

	------------------------------
	-- Debuff Help Tip
	panel.DebuffHelpTip = CreateQuickItemLabel("DebuffHelpTip", "Tip: |cffCCCCCCAuras should be listed with the exact name, or a spell ID number. "..
		"You can use the prefixes, 'My' or 'All', to distinguish personal damage spells from global crowd control spells. "..
		"Auras at the top of the list will get displayed before lower ones.", 225+40) -- 210, 275, )
	panel.DebuffHelpTip:SetHeight(128)
	panel.DebuffHelpTip:SetWidth(200)
	panel.DebuffHelpTip.Text:SetJustifyV("TOP")


	--[[
		Stage 2:
			- Expand Options
			- Filtering mode: Show raid targets, show only my target

	--]]

	------------------------------
	--Widgets
	------------------------------
	panel.WidgetsLabel = CreateQuickHeadingLabel("WidgetsLabel", "Other Widgets", 0, 5)
	panel.WidgetTargetHighlight = CreateQuickCheckbutton("WidgetTargetHighlight", "Show Target Highlight")
	panel.WidgetEliteIndicator = CreateQuickCheckbutton("WidgetEliteIndicator", "Show Elite Icon")
	panel.ClassEnemyIcon = CreateQuickCheckbutton("ClassEnemyIcon", "Show Enemy Class Art")
	panel.ClassPartyIcon = CreateQuickCheckbutton("ClassPartyIcon", "Show Friendly Class Art")
	panel.WidgetsTotemIcon = CreateQuickCheckbutton("WidgetsTotemIcon", "Show Totem Art")
	panel.WidgetsComboPoints = CreateQuickCheckbutton("WidgetsComboPoints", "Show Combo Points")

	panel.WidgetsEnableExternal = CreateQuickCheckbutton("WidgetsEnableExternal", "Enable External Widgets")

	panel.WidgetsThreatIndicator = CreateQuickCheckbutton("WidgetsThreatIndicator", "Show Threat Indicator", OffsetColumnB)
	panel.WidgetsThreatIndicatorMode =  CreateQuickDropdown("WidgetsThreatIndicatorMode", "Threat Indicator:", ThreatWidgetModes, 1, OffsetColumnB+16)
	panel.WidgetsRangeIndicator = CreateQuickCheckbutton("WidgetsRangeIndicator", "Show Party Range Warning", OffsetColumnB)
	panel.WidgetsRangeMode =  CreateQuickDropdown("WidgetsRangeMode", "Range:", RangeModes, 1, OffsetColumnB+16)

	------------------------------
	-- Advanced
	------------------------------
	panel.AdvancedLabel = CreateQuickHeadingLabel("AdvancedLabel", "Advanced", 0, 5)
	panel.AdvancedEnableUnitCache = CreateQuickCheckbutton("AdvancedEnableUnitCache", "Enable Class & Title Caching ")
	panel.FrameVerticalPosition = CreateQuickSlider("FrameVerticalPosition", "Vertical Position of Artwork: (May cause targeting problems)", 0, 4)

	--panel.AdvancedCustomCodeLabel = CreateQuickItemLabel(nil, "Custom Theme Code:", AlignmentColumn, panel.FrameVerticalPosition, 0, 4)
	--panel.AdvancedCustomCodeTextbox = CreateQuickEditbox("AdvancedCustomCodeTextbox", AlignmentColumn, panel.AdvancedHealthTextLabel, 8)


	--loadstring( [[return function(unit) ]]..LocalVars.AdvancedCustomCodeTextbox..[[ end]])
	--[[
	--function(theme)

	theme.Default.name.size = 18
	--]]

	local BlizzOptionsButton = CreateFrame("Button", objectName.."BlizzButton", AlignmentColumn, "TidyPlatesPanelButtonTemplate")
	BlizzOptionsButton:SetPoint("TOPLEFT", panel.FrameVerticalPosition, "BOTTOMLEFT",-6, -18)
	--BlizzOptionsButton:SetPoint("TOPLEFT", panel.AdvancedCustomCodeTextbox, "BOTTOMLEFT",-6, -18)
	BlizzOptionsButton:SetWidth(300)
	BlizzOptionsButton:SetText("Blizzard Nameplate Motion & Visibility...")
	BlizzOptionsButton:SetScript("OnClick", function() InterfaceOptionsFrame_OpenToCategory(_G["InterfaceOptionsNamesPanel"]) end)


	------------------------------
	-- Set Sizes and Mechanics
	------------------------------
	panel.MainFrame:SetHeight(2800)

	-- Edit Box Widths
	--panel.AdvancedCustomCodeTextbox:SetWidth(300)
	panel.OpacityFilterList:SetWidth(200)
	panel.WidgetsDebuffTrackList:SetWidth(200)

	-- Slider Ranges
	SetSliderMechanics(panel.OpacityTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityNonTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacitySpotlight, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityFiltered, 1, 0, 1, .01)
	SetSliderMechanics(panel.ScaleFiltered, 1, .1, 3, .01)
	SetSliderMechanics(panel.ScaleStandard, 1, .1, 3, .01)
	SetSliderMechanics(panel.ScaleSpotlight, 1, .1, 3, .01)
	SetSliderMechanics(panel.FrameVerticalPosition, .5, 0, 1, .02)

	SetSliderMechanics(panel.HighHealthThreshold, .7, .5, 1, .01)
	SetSliderMechanics(panel.LowHealthThreshold, .3, 0, .5, .01)

	-- "RefreshSettings" is called; A) When PLAYER_ENTERING_WORLD is called, and; B) When changes are made to settings

	local ConvertStringToTable = TidyPlatesHubHelpers.ConvertStringToTable
	local ConvertDebuffListTable = TidyPlatesHubHelpers.ConvertDebuffListTable
	local CallForStyleUpdate = TidyPlatesHubHelpers.CallForStyleUpdate

	function panel.RefreshSettings(LocalVars)
		CallForStyleUpdate()
		-- Convert Debuff Filter Strings
		ConvertDebuffListTable(LocalVars.WidgetsDebuffTrackList, LocalVars.WidgetsDebuffLookup, LocalVars.WidgetsDebuffPriority)
		-- Convert Unit Filter Strings
		ConvertStringToTable(LocalVars.OpacityFilterList, LocalVars.OpacityFilterLookup)
		-- Convert Custom Code...  (Testing)
		--local func, err = loadstring( [[return function(unit) ]]..LocalVars.AdvancedCustomCodeTextbox..[[ end]])
		--if func == nil and err then print(panel.name, "|r CUSTOM SCRIPT ERROR", err)
		--elseif func then LocalVars.CustomHealthFunction = func()	end

	end
end

--local function OnLogin()
	-- Init
	--InitializeTidyPlatesHubModes()

	-- Create Instances of Panels

	--[[
	local TankPanel = CreateInterfacePanel( "HubPanelSettingsTank", "Tidy Plates Hub: |cFF3782D1Tank", nil )
	CreateInterfacePanelWidgets(TankPanel)
	InterfaceOptions_AddCategory(TankPanel)
	function ShowTidyPlatesHubTankPanel() TidyPlatesUtility.OpenInterfacePanel(TankPanel) end
	--]]

	local DamagePanel = CreateInterfacePanel( "HubPanelSettingsDamage", "Tidy Plates Hub: |cFFFF1100Damage", nil )
	CreateInterfacePanelWidgets(DamagePanel)
	InterfaceOptions_AddCategory(DamagePanel)
	function ShowTidyPlatesHubDamagePanel() TidyPlatesUtility.OpenInterfacePanel(DamagePanel) end
--end

--local HubHandler = CreateFrame("Frame")
--HubHandler:SetScript("OnEvent", OnLogin)
--HubHandler:RegisterEvent("PLAYER_LOGIN")





--[[
local GladiatorPanel = CreateInterfacePanel( "HubPanelSettingsGladiator", "Tidy Plates Hub: |cFFAA6600Gladiator", nil )
CreateInterfacePanelWidgets(GladiatorPanel)
function ShowTidyPlatesHubGladiatorPanel() InterfaceOptionsFrame_OpenToCategory(GladiatorPanel) end
--]]
--[[

-- Testing

/run print(HubDamageConfigFrame:GetParent())
/run HubDamageConfigFrame:SetParent(UIParent); HubDamageConfigFrame:SetPoint("TOPLEFT")

HubDamageConfigFrame = DamagePanel

local HealerPanel = CreateInterfacePanel( "HubPanelSettingsHealer", "Tidy Plates Hub: |cFF44DD55Healer", nil )
CreateInterfacePanelWidgets(HealerPanel)
function ShowTidyPlatesHubHealerPanel() InterfaceOptionsFrame_OpenToCategory(HealerPanel) end
--]]

