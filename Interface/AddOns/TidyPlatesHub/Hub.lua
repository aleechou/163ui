
--[[
Tidy Plates Hub: Interface Panel

Color Guide:
|cffffdd00		for Yellow
|cffff6906		for Orange
|cff999999		for Grey
|cffffaa33		for Brownish Orange

--]]

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

-- Modes
local ThemeList = TidyPlatesHubMenus.ThemeList
local StyleModes = TidyPlatesHubMenus.StyleModes
local TextModes = TidyPlatesHubMenus.TextModes
local RangeModes = TidyPlatesHubMenus.RangeModes
local AuraWidgetModes = TidyPlatesHubMenus.AuraWidgetModes
local DebuffStyles = TidyPlatesHubMenus.DebuffStyles
local EnemyOpacityModes = TidyPlatesHubMenus.EnemyOpacityModes
local FriendlyOpacityModes = TidyPlatesHubMenus.FriendlyOpacityModes
local ScaleModes = TidyPlatesHubMenus.ScaleModes
local FriendlyBarModes = TidyPlatesHubMenus.FriendlyBarModes
local EnemyBarModes = TidyPlatesHubMenus.EnemyBarModes
local ThreatWidgetModes = TidyPlatesHubMenus.ThreatWidgetModes
local EnemyNameColorModes = TidyPlatesHubMenus.EnemyNameColorModes
local FriendlyNameColorModes = TidyPlatesHubMenus.FriendlyNameColorModes
local EnemyNameSubtextModes = TidyPlatesHubMenus.EnemyNameSubtextModes
local ArtStyles = TidyPlatesHubMenus.ArtStyles
local ArtModes = TidyPlatesHubMenus.ArtModes
local ThreatWarningModes = TidyPlatesHubMenus.ThreatWarningModes
local CustomTextModes = TidyPlatesHubMenus.CustomTextModes
local BasicTextModes = TidyPlatesHubMenus.BasicTextModes

local cEnemy = "|cffff5544"
local cFriendly = "|cffc8e915"

------------------------------------------------------------------
-- Generate Panel
------------------------------------------------------------------
local function CreateInterfacePanelWidgets(panel)
	local objectName = panel.objectName
	local AlignmentColumn = panel.AlignmentColumn
	local OffsetColumnB = 200						-- 240
	local F = nil									-- Cache for anchoring
	local ColumnTop, ColumnEnd

	panel.StyleLabel, F = CreateQuickHeadingLabel(nil, "姓名版样式", AlignmentColumn, F, 0, 5)

	ColumnTop = F

	panel.StyleEnemyBarsLabel, F = CreateQuickItemLabel(nil, cEnemy.."敌对血量条:", AlignmentColumn, F, 0, 2)
	panel.StyleEnemyBarsOnNPC, F = CreateQuickCheckbutton(objectName.."StyleEnemyBarsOnNPC", "所有NPC", AlignmentColumn, F, 16, 0)
	panel.StyleEnemyBarsInstanceMode, F = CreateQuickCheckbutton(objectName.."StyleEnemyBarsInstanceMode", "排除实例", AlignmentColumn, F, 32*(1/.8), 0)
	panel.StyleEnemyBarsInstanceMode:SetScale(.8)
	panel.StyleEnemyBarsOnElite, F = CreateQuickCheckbutton(objectName.."StyleEnemyBarsOnElite", "精英单位", AlignmentColumn, F, 16, 0)
	panel.StyleEnemyBarsOnPlayers, F = CreateQuickCheckbutton(objectName.."StyleEnemyBarsOnPlayers", "玩家", AlignmentColumn, F, 16, 0)
	panel.StyleEnemyBarsOnActive, F = CreateQuickCheckbutton(objectName.."StyleEnemyBarsOnActive", "主动/受伤单位", AlignmentColumn, F, 16, 0)

	ColumnEnd = F

	panel.StyleFriendlyBarsLabel, F = CreateQuickItemLabel(nil, cFriendly.."友好血量条:", AlignmentColumn, ColumnTop, OffsetColumnB, 2)
	panel.StyleFriendlyBarsOnNPC, F = CreateQuickCheckbutton(objectName.."StyleFriendlyBarsOnNPC", "所有NPC", AlignmentColumn, F, OffsetColumnB+16, 0)
	panel.StyleFriendlyBarsInstanceMode, F = CreateQuickCheckbutton(objectName.."StyleFriendlyBarsInstanceMode", "排除实例", AlignmentColumn, F, (OffsetColumnB+32)*(1/.8), 0)
	panel.StyleFriendlyBarsInstanceMode:SetScale(.8)
	panel.StyleFriendlyBarsOnElite, F = CreateQuickCheckbutton(objectName.."StyleFriendlyBarsOnElite", "精英单位", AlignmentColumn, F, OffsetColumnB+16, 0)

	panel.StyleFriendlyBarsOnPlayers, F = CreateQuickCheckbutton(objectName.."StyleFriendlyBarsOnPlayers", "玩家", AlignmentColumn, F, OffsetColumnB+16, 0)
	panel.StyleFriendlyBarsOnActive, F = CreateQuickCheckbutton(objectName.."StyleFriendlyBarsOnActive", "主动/受伤单位", AlignmentColumn, F, OffsetColumnB+16, 0)

	F =  ColumnEnd
	panel.HealthBarStyleLabel, F = CreateQuickItemLabel(nil, "血量条预览:", AlignmentColumn, F, 0, 2)
	panel.StyleForceBarsOnTargets, F = CreateQuickCheckbutton(objectName.."StyleForceBarsOnTargets", "Force Bars on Targets", AlignmentColumn, F, 16, 2)

	panel.StyleHeadlineLabel, F = CreateQuickItemLabel(nil, "框架预览 (只有文本):", AlignmentColumn, F, 0, 2)
	panel.StyleHeadlineNeutral, F = CreateQuickCheckbutton(objectName.."StyleHeadlineNeutral", "Force Headline on Neutral Units", AlignmentColumn, F, 16, 2)
	panel.StyleHeadlineOutOfCombat, F = CreateQuickCheckbutton(objectName.."StyleHeadlineOutOfCombat", "Force Headline View while Out-of-Combat", AlignmentColumn, F, 16, 0)

	------------------------------
    -- Health Bars
	------------------------------

    panel.HealthBarLabel, F = CreateQuickHeadingLabel(nil, "血条样式", AlignmentColumn, F, 0, 5)

    -- Enemy
	panel.EnemyBarColorMode, F =  CreateQuickDropdown(objectName.."EnemyBarColorMode", cEnemy.."敌对血条颜色:", EnemyBarModes, 1, AlignmentColumn, F)
	panel.EnemyNameColorMode, F =  CreateQuickDropdown(objectName.."EnemyNameColorMode", cEnemy.."敌对名字颜色:", EnemyNameColorModes, 1, AlignmentColumn, F)
	panel.EnemyStatusTextMode, F =  CreateQuickDropdown(objectName.."EnemyStatusTextMode", cEnemy.."敌对血条上的文字:", TextModes, 1, AlignmentColumn, F )
	--panel.EnemyStatusTextModeCenter, F =  CreateQuickDropdown(objectName.."EnemyStatusTextModeCenter", "", BasicTextModes, 1, AlignmentColumn, F, 0, -14 )
	--panel.EnemyStatusTextModeRight, F =  CreateQuickDropdown(objectName.."EnemyStatusTextModeRight", "", BasicTextModes, 1, AlignmentColumn, F, 0, -14 )

	-- Friendly
	panel.FriendlyBarColorMode, F =  CreateQuickDropdown(objectName.."FriendlyBarColorMode", cFriendly.."友方血条颜色:", FriendlyBarModes, 1, AlignmentColumn, panel.HealthBarLabel, OffsetColumnB)
	panel.FriendlyNameColorMode, F =  CreateQuickDropdown(objectName.."FriendlyNameColorMode", cFriendly.."友方名字颜色:", FriendlyNameColorModes, 1, AlignmentColumn, F, OffsetColumnB)
	panel.FriendlyStatusTextMode, F =  CreateQuickDropdown(objectName.."FriendlyStatusTextMode", cFriendly.."友方血条上的文字:", TextModes, 1, AlignmentColumn, F, OffsetColumnB)
	--panel.FriendlyStatusTextModeCenter, F =  CreateQuickDropdown(objectName.."FriendlyStatusTextModeCenter", "", BasicTextModes, 1, AlignmentColumn, F, OffsetColumnB, -14)
	--panel.FriendlyStatusTextModeRight, F =  CreateQuickDropdown(objectName.."FriendlyStatusTextModeRight", "", BasicTextModes, 1, AlignmentColumn, F, OffsetColumnB, -14)

	-- Other
	panel.TextShowLevel, F = CreateQuickCheckbutton(objectName.."TextShowLevel", "显示等级", AlignmentColumn, F, 0, 2)
	panel.TextUseBlizzardFont, F = CreateQuickCheckbutton(objectName.."TextUseBlizzardFont", "使用暴雪默认字体", AlignmentColumn, F, 0)
    panel.TextShowOnlyOnTargets, F = CreateQuickCheckbutton(objectName.."TextShowOnlyOnTargets", "鼠标移上去显示血条文字", AlignmentColumn, F, 0)
    panel.TextShowOnlyOnActive, F = CreateQuickCheckbutton(objectName.."TextShowOnlyOnActive", "为主动/受伤单位显示状态文本", AlignmentColumn, F, 0)


	------------------------------
	-- Headline View
	------------------------------
	--[[
		Hostile Headline	(Current Selection in Dropdown)
			Default Bars
			Headline Always
			Out-of-Combat - Bars during Combat
			On Idle - Bars on Active
			On NPCs - Bars on Players
			On Non-Targets - Bar on Current Target
			On Aggroed Units - Bars on Low Threat (Tank Mode)

		Show Enemy/Friendly Health Bars:
			- On Elite Units
			- On NPCs
			- On Players (When available)
			- On Active/Damaged Units	- Low Threat (Tank Mode)  (Could roll the Tank mode into Active/Damaged units)

		- (Headline Neutral Units)
		- Force Headline Out-of-Combat		Bars during Combat; Headline Out-of-Combat 		(Eliminate this)

	--]]
	panel.StyleLabel, F = CreateQuickHeadingLabel(nil, "框架预览 (只有文本)", AlignmentColumn, F, 0, 5)

	ColumnTop = F

	panel.EnemyHeadlineColor, F = CreateQuickDropdown(objectName.."EnemyHeadlineColor", cEnemy.."敌对框架:", EnemyNameColorModes, 1, AlignmentColumn, F)	-- |cffee9900Text-Only Style
	panel.HeadlineEnemySubtext, F =  CreateQuickDropdown(objectName.."HeadlineEnemySubtext", cEnemy.."敌对血条颜色:", EnemyNameSubtextModes, 1, AlignmentColumn, F )	-- |cffee9900Text-Only Style

	ColumnEnd = F

	panel.FriendlyHeadlineColor, F = CreateQuickDropdown(objectName.."FriendlyHeadlineColor", cFriendly.."友方框架:", FriendlyNameColorModes, 1, AlignmentColumn, ColumnTop, OffsetColumnB)	-- |cffee9900Text-Only Style
	panel.HeadlineFriendlySubtext, F =  CreateQuickDropdown(objectName.."HeadlineFriendlySubtext", cFriendly.."友方血条颜色:", EnemyNameSubtextModes, 1, AlignmentColumn, F, OffsetColumnB )	-- |cffee9900Text-Only Style

	F = ColumnEnd

	------------------------------
	-- Aura (Buff and Debuff) Widget
	------------------------------
	panel.DebuffsLabel = CreateQuickHeadingLabel(nil, "Buffs以及Debuffs", AlignmentColumn, F, 0, 5)
	panel.WidgetsDebuff = CreateQuickCheckbutton(objectName.."WidgetsDebuff", "启用光环小部件", AlignmentColumn, panel.DebuffsLabel)

	--panel.WidgetsAuraMode =  CreateQuickDropdown(objectName.."WidgetsAuraMode", "Filter Mode:", AuraWidgetModes, 1, AlignmentColumn, panel.WidgetsDebuffStyle, 16)		-- used to be WidgetsDebuffMode

	panel.WidgetsMyDebuff = CreateQuickCheckbutton(objectName.."WidgetsMyDebuff", "包括我的Debuffs", AlignmentColumn, panel.WidgetsDebuff, 16)
	panel.WidgetsMyBuff = CreateQuickCheckbutton(objectName.."WidgetsMyBuff", "包括我的Buffs", AlignmentColumn, panel.WidgetsMyDebuff, 16)

	panel.WidgetsDebuffListLabel = CreateQuickItemLabel(nil, "额外的光环:", AlignmentColumn, panel.WidgetsMyBuff, 16)
	panel.WidgetsDebuffTrackList = CreateQuickEditbox(objectName.."WidgetsDebuffTrackList", AlignmentColumn, panel.WidgetsDebuffListLabel, 16)

	panel.WidgetsDebuffStyle =  CreateQuickDropdown(objectName.."WidgetsDebuffStyle", "图标样式:", DebuffStyles, 1, AlignmentColumn, panel.WidgetsDebuffTrackList, 16)

	panel.WidgetAuraTrackDispelFriendly = CreateQuickCheckbutton(objectName.."WidgetAuraTrackDispelFriendly", "包括在友好单位上的可驱散的Debuffs", AlignmentColumn, panel.WidgetsDebuffStyle, 16, 4)
	panel.WidgetAuraTrackCurse = CreateQuickCheckbutton(objectName.."WidgetAuraTrackCurse", "诅咒", AlignmentColumn, panel.WidgetAuraTrackDispelFriendly, 16+16, -2)
	panel.WidgetAuraTrackDisease = CreateQuickCheckbutton(objectName.."WidgetAuraTrackDisease", "疾病", AlignmentColumn, panel.WidgetAuraTrackCurse, 16+16, -2)
	panel.WidgetAuraTrackMagic = CreateQuickCheckbutton(objectName.."WidgetAuraTrackMagic", "魔法", AlignmentColumn, panel.WidgetAuraTrackDisease, 16+16, -2)
	panel.WidgetAuraTrackPoison = CreateQuickCheckbutton(objectName.."WidgetAuraTrackPoison", "中毒", AlignmentColumn, panel.WidgetAuraTrackMagic, 16+16, -2)


	------------------------------
	-- Debuff Help Tip
	panel.DebuffHelpTip = CreateQuickItemLabel(nil, "友情提示: |cffCCCCCC在左边写入你的法术名字或ID. "..
		"前+ 'My' or 'All', 来监视你要的光环 "..
		"谁在列表前，那么就优先显示", AlignmentColumn, panel.WidgetsDebuffListLabel, 225+40) -- 210, 275, )
	panel.DebuffHelpTip:SetHeight(150)
	panel.DebuffHelpTip:SetWidth(200)
	panel.DebuffHelpTip.Text:SetJustifyV("TOP")

	-- Expand Options
	-- Filtering mode: Show raid targets, show only my target

	------------------------------
	--Opacity
	------------------------------
	panel.OpacityLabel, F = CreateQuickHeadingLabel(nil, "透明度", AlignmentColumn, panel.WidgetAuraTrackPoison, 0, 5)
	panel.EnemyAlphaSpotlightMode =  CreateQuickDropdown(objectName.."EnemyAlphaSpotlightMode", cEnemy.."敌对焦点模式:", EnemyOpacityModes, 1, AlignmentColumn, F)
	panel.FriendlyAlphaSpotlightMode, F =  CreateQuickDropdown(objectName.."FriendlySpotlightMode", cFriendly.."友好焦点模式:", FriendlyOpacityModes, 1, AlignmentColumn, F, OffsetColumnB)

	panel.OpacitySpotlight = CreateQuickSlider(objectName.."OpacitySpotlight", "焦点透明度:", AlignmentColumn, F, 0, 2)
	panel.OpacityTarget = CreateQuickSlider(objectName.."OpacityTarget", "目标透明度:", AlignmentColumn, panel.OpacitySpotlight, 0, 2)
	panel.OpacityNonTarget = CreateQuickSlider(objectName.."OpacityNonTarget", "非目标透明度:", AlignmentColumn, panel.OpacityTarget, 0, 2)

	panel.OpacitySpotlightSpell = CreateQuickCheckbutton(objectName.."OpacitySpotlightSpell", "焦点施法单位", AlignmentColumn, panel.OpacityNonTarget, 0)
	panel.OpacitySpotlightMouseover = CreateQuickCheckbutton(objectName.."OpacitySpotlightMouseover", "鼠标悬停焦点", AlignmentColumn, panel.OpacitySpotlightSpell, 0)
	panel.OpacitySpotlightRaidMarked = CreateQuickCheckbutton(objectName.."OpacitySpotlightRaidMarked", "Raid标记焦点", AlignmentColumn, panel.OpacitySpotlightMouseover, 0)

	panel.OpacityFullNoTarget = CreateQuickCheckbutton(objectName.."OpacityFullNoTarget", "没目标下的透明度", AlignmentColumn, panel.OpacitySpotlightRaidMarked, 0)

	------------------------------
	--Scale
	------------------------------
	panel.ScaleLabel = CreateQuickHeadingLabel(nil, "比例", AlignmentColumn, panel.OpacityFullNoTarget, 0, 5)
	panel.ScaleStandard = CreateQuickSlider(objectName.."ScaleStandard", "全局比例:", AlignmentColumn, panel.ScaleLabel, 0, 2)

	panel.ScaleFunctionMode =  CreateQuickDropdown(objectName.."ScaleFunctionMode", "焦点比例类型:", ScaleModes, 1, AlignmentColumn, panel.ScaleStandard)


	panel.ScaleSpotlight = CreateQuickSlider(objectName.."ScaleSpotlight", "焦点比例:", AlignmentColumn, panel.ScaleFunctionMode, 0, 2)
	panel.ScaleIgnoreNeutralUnits= CreateQuickCheckbutton(objectName.."ScaleIgnoreNeutralUnits", "忽略中立", AlignmentColumn, panel.ScaleSpotlight, 16)
	panel.ScaleIgnoreNonEliteUnits= CreateQuickCheckbutton(objectName.."ScaleIgnoreNonEliteUnits", "忽略非精英", AlignmentColumn, panel.ScaleIgnoreNeutralUnits, 16)
	panel.ScaleIgnoreInactive, F = CreateQuickCheckbutton(objectName.."ScaleIgnoreInactive", "忽略非激活的", AlignmentColumn, panel.ScaleIgnoreNonEliteUnits, 16)

	panel.ScaleCastingSpotlight, F = CreateQuickCheckbutton(objectName.."ScaleCastingSpotlight", "为施法状态启用焦点", AlignmentColumn, F, 0)
	panel.ScaleTargetSpotlight, F = CreateQuickCheckbutton(objectName.."ScaleTargetSpotlight", "为当前目标启动焦点", AlignmentColumn, F, 0)
	panel.ScaleMouseoverSpotlight, F = CreateQuickCheckbutton(objectName.."ScaleMouseoverSpotlight", "为鼠标悬停启用焦点", AlignmentColumn, F, 0)
	panel.ScaleMiniMobs, F = CreateQuickCheckbutton(objectName.."ScaleMiniMobs", "自动缩放小宠物", AlignmentColumn, F, 0)

	-- panel.ScaleTrivialMobsMultiplier =
	-- Downscale Trivial Mobs  (70%)

	------------------------------
	-- Trivial Mobs
	------------------------------
	-- Scale Multiplier
	-- Override Target Settings
	-- Ignore Threat
	--

	-- Hiding Mobs vs Filtering Mobs

	------------------------------
    -- Unit Search Spotlight/Searchlight
	------------------------------

	--[[
	panel.UnitSpotlightLabel = CreateQuickHeadingLabel(nil, "Unit Spotlight", AlignmentColumn, panel.ScaleCastingSpotlight, 0, 5)

	-- Column 1
	panel.UnitSpotlightOpacity = CreateQuickSlider(objectName.."UnitSpotlightOpacity", "Spotlight Opacity:", AlignmentColumn, panel.UnitSpotlightLabel, 0, 2)
	panel.UnitSpotlightScale = CreateQuickSlider(objectName.."UnitSpotlightScale", "Spotlight Scale:", AlignmentColumn, panel.UnitSpotlightOpacity, 0, 2)
	panel.UnitSpotlightColorLabel = CreateQuickItemLabel(nil, "Spotlight Color:", AlignmentColumn, panel.UnitSpotlightScale, 0, 0)
	panel.UnitSpotlightColor = CreateQuickColorbox(objectName.."UnitSpotlightColor", "Bar & Glow Color", AlignmentColumn, panel.UnitSpotlightColorLabel , 6, 2)

	panel.UnitSpotlightListLabel = CreateQuickItemLabel(nil, "Unit Name:", AlignmentColumn, panel.UnitSpotlightColor, 0, 4)
	panel.UnitSpotlightList = CreateQuickEditbox(objectName.."UnitSpotlightList", AlignmentColumn, panel.UnitSpotlightListLabel, 0)

	-- Boss NPC units

	-- Column 2
	panel.UnitSpotlightOpacityEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightOpacityEnable", "Enable Opacity", AlignmentColumn, panel.UnitSpotlightListLabel, 8+ OffsetColumnB, 0)
	panel.UnitSpotlightScaleEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightScaleEnable", "Enable Scale", AlignmentColumn, panel.UnitSpotlightOpacityEnable, 8+ OffsetColumnB, 0)
	panel.UnitSpotlightBarEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightBarEnable", "Enable Bar Color", AlignmentColumn, panel.UnitSpotlightScaleEnable, 8+OffsetColumnB)
	panel.UnitSpotlightGlowEnable = CreateQuickCheckbutton(objectName.."UnitSpotlightGlowEnable", "Enable Glow Color", AlignmentColumn, panel.UnitSpotlightBarEnable, 8+OffsetColumnB)

	--]]

	------------------------------
	-- Filter
	--------------------------------
	panel.FilterLabel = CreateQuickHeadingLabel(nil, "单位过滤", AlignmentColumn, F, 0, 5)
	panel.OpacityFiltered = CreateQuickSlider(objectName.."OpacityFiltered", "过滤单位透明度:", AlignmentColumn, panel.FilterLabel, 0, 2)
	panel.ScaleFiltered = CreateQuickSlider(objectName.."ScaleFiltered", "过滤单位比例:", AlignmentColumn, panel.OpacityFiltered, 0, 2)
	panel.FilterScaleLock = CreateQuickCheckbutton(objectName.."FilterScaleLock", "打勾启动过滤", AlignmentColumn, panel.ScaleFiltered, 16)

	panel.OpacityFilterNeutralUnits = CreateQuickCheckbutton(objectName.."OpacityFilterNeutralUnits", "过滤中立", AlignmentColumn, panel.FilterScaleLock, 8, 4)
	panel.OpacityFilterNonElite = CreateQuickCheckbutton(objectName.."OpacityFilterNonElite", "过滤非精英", AlignmentColumn, panel.OpacityFilterNeutralUnits, 8)
	panel.OpacityFilterNPC = CreateQuickCheckbutton(objectName.."OpacityFilterNPC", "过滤npc", AlignmentColumn, panel.OpacityFilterNonElite, 8)
	panel.OpacityFilterFriendlyNPC = CreateQuickCheckbutton(objectName.."OpacityFilterFriendlyNPC", "过滤友方NPC", AlignmentColumn, panel.OpacityFilterNPC, 8)

    panel.OpacityFilterPlayers = CreateQuickCheckbutton(objectName.."OpacityFilterPlayers", "过滤玩家", AlignmentColumn, panel.FilterScaleLock, OffsetColumnB, 4)
	panel.OpacityFilterInactive = CreateQuickCheckbutton(objectName.."OpacityFilterInactive", "过滤未激活", AlignmentColumn, panel.OpacityFilterPlayers, OffsetColumnB)
	panel.OpacityFilterMini = CreateQuickCheckbutton(objectName.."OpacityFilterMini", "过滤小宠物", AlignmentColumn, panel.OpacityFilterInactive, OffsetColumnB)

	panel.OpacityCustomFilterLabel = CreateQuickItemLabel(nil, "过滤单位名字:", AlignmentColumn, panel.OpacityFilterFriendlyNPC, 8, 4)
	panel.OpacityFilterList, L = CreateQuickEditbox(objectName.."OpacityFilterList", AlignmentColumn, panel.OpacityCustomFilterLabel, 8)


-- [[

    ------------------------------
	-- Reaction
	------------------------------
	-- Health Bar Color
    panel.ReactionLabel = CreateQuickHeadingLabel(nil, "反应类型", AlignmentColumn, panel.OpacityFilterList, 0, 5)
	panel.ReactionColorLabel = CreateQuickItemLabel(nil, "血条颜色:", AlignmentColumn, panel.ReactionLabel, 0, 2)
	panel.ColorFriendlyNPC = CreateQuickColorbox(objectName.."ColorFriendlyNPC", "友方NPC", AlignmentColumn, panel.ReactionColorLabel , 16)
	panel.ColorFriendlyPlayer = CreateQuickColorbox(objectName.."ColorFriendlyPlayer", "友方玩家", AlignmentColumn, panel.ColorFriendlyNPC , 16)
	panel.ColorNeutral= CreateQuickColorbox(objectName.."ColorNeutral", "中立", AlignmentColumn, panel.ColorFriendlyPlayer , 16)
	panel.ColorHostileNPC = CreateQuickColorbox(objectName.."ColorHostileNPC", "敌对NPC", AlignmentColumn, panel.ColorNeutral , 16)
	panel.ColorHostilePlayer = CreateQuickColorbox(objectName.."ColorHostilePlayer", "敌对玩家", AlignmentColumn, panel.ColorHostileNPC , 16)
	panel.ColorGuildMember = CreateQuickColorbox(objectName.."ColorGuildMember", "公会成员", AlignmentColumn, panel.ColorHostilePlayer , 16)
    -- Text Color
    panel.TextReactionColorLabel = CreateQuickItemLabel(nil, "文字颜色:", AlignmentColumn, panel.ReactionLabel, OffsetColumnB )
	panel.TextColorFriendlyNPC = CreateQuickColorbox(objectName.."TextColorFriendlyNPC", "友方NPC", AlignmentColumn, panel.ReactionColorLabel , OffsetColumnB + 16)
	panel.TextColorFriendlyPlayer = CreateQuickColorbox(objectName.."TextColorFriendlyPlayer", "友方玩家", AlignmentColumn, panel.TextColorFriendlyNPC , OffsetColumnB + 16)
	panel.TextColorNeutral= CreateQuickColorbox(objectName.."TextColorNeutral", "中立", AlignmentColumn, panel.TextColorFriendlyPlayer , OffsetColumnB + 16)
	panel.TextColorHostileNPC = CreateQuickColorbox(objectName.."TextColorHostileNPC", "敌对NPC", AlignmentColumn, panel.TextColorNeutral , OffsetColumnB + 16)
	panel.TextColorHostilePlayer = CreateQuickColorbox(objectName.."TextColorHostilePlayer", "敌对玩家", AlignmentColumn, panel.TextColorHostileNPC , OffsetColumnB + 16)
	panel.TextColorGuildMember = CreateQuickColorbox(objectName.."TextColorGuildMember", "公会成员", AlignmentColumn, panel.TextColorHostilePlayer , OffsetColumnB + 16)
	-- Other
	panel.OtherColorLabel = CreateQuickItemLabel(nil, "其他颜色:", AlignmentColumn, panel.ColorGuildMember, 0, 2)
	panel.ColorTapped, L = CreateQuickColorbox(objectName.."ColorTapped", "Tapped Unit", AlignmentColumn, panel.OtherColorLabel , 16)
	--panel.ColorTotem = CreateQuickColorbox(objectName.."ColorTotem", "Totem", AlignmentColumn, panel.ColorTapped , 16)

--]]

	------------------------------
	-- Threat
	------------------------------
    -- Column 1
	panel.ThreatLabel = CreateQuickHeadingLabel(nil, "威胁", AlignmentColumn, L, 0, 5)
	panel.ThreatWarningMode =  CreateQuickDropdown(objectName.."ThreatWarningMode", "威胁模式:", ThreatWarningModes, 1, AlignmentColumn, panel.ThreatLabel, 0, 2)
	panel.ThreatGlowEnable = CreateQuickCheckbutton(objectName.."ThreatGlowEnable", "开启发光警告", AlignmentColumn, panel.ThreatWarningMode,0)

	panel.ColorThreatColorLabels = CreateQuickItemLabel(nil, "威胁颜色:", AlignmentColumn, panel.ThreatGlowEnable, 0, 2)
	panel.ColorThreatWarning = CreateQuickColorbox(objectName.."ColorThreatWarning", "警告", AlignmentColumn, panel.ColorThreatColorLabels , 16)
	panel.ColorThreatTransition = CreateQuickColorbox(objectName.."ColorThreatTransition", "转变", AlignmentColumn, panel.ColorThreatWarning , 16)
	panel.ColorThreatSafe = CreateQuickColorbox(objectName.."ColorThreatSafe", "安全", AlignmentColumn, panel.ColorThreatTransition, 16)

	--[[
	-- Warning Border Glow
	--]]

    -- Column 2
	panel.EnableOffTankHighlight = CreateQuickCheckbutton(objectName.."EnableOffTankHighlight", "Highlight Mobs Tanked by other Tanks", AlignmentColumn, panel.ThreatLabel, OffsetColumnB)
	panel.ColorAttackingOtherTank = CreateQuickColorbox(objectName.."ColorAttackingOtherTank", "攻击其他坦克", AlignmentColumn, panel.EnableOffTankHighlight , 16+OffsetColumnB)

	panel.ColorShowPartyAggro = CreateQuickCheckbutton(objectName.."ColorShowPartyAggro", "保持突出团队成员 Aggro", AlignmentColumn, panel.ColorAttackingOtherTank, OffsetColumnB)
	panel.ColorPartyAggro = CreateQuickColorbox(objectName.."ColorPartyAggro", "团队成员 Aggro", AlignmentColumn, panel.ColorShowPartyAggro , 14+OffsetColumnB)
	panel.ColorPartyAggroBar = CreateQuickCheckbutton(objectName.."ColorPartyAggroBar", "血条颜色", AlignmentColumn, panel.ColorPartyAggro, 16+OffsetColumnB)
	panel.ColorPartyAggroGlow = CreateQuickCheckbutton(objectName.."ColorPartyAggroGlow", "边界发光/发光警告", AlignmentColumn, panel.ColorPartyAggroBar, 16+OffsetColumnB)
	panel.ColorPartyAggroText = CreateQuickCheckbutton(objectName.."ColorPartyAggroText", "名字文本颜色", AlignmentColumn, panel.ColorPartyAggroGlow, 16+OffsetColumnB)

	------------------------------
	-- Health
	------------------------------
	panel.HealthLabel, F = CreateQuickHeadingLabel(nil, "血量", AlignmentColumn, panel.ColorPartyAggroText, 0, 5)
	panel.EnableHealerWarning, F = CreateQuickCheckbutton(objectName.."EnableHealerWarning", "开启血量预警", AlignmentColumn, F)
	panel.HighHealthThreshold = CreateQuickSlider(objectName.."HighHealthThreshold", "高血量的阈值:", AlignmentColumn, F, 0, 2)
	panel.LowHealthThreshold =  CreateQuickSlider(objectName.."LowHealthThreshold", "低血量的阈值:", AlignmentColumn, panel.HighHealthThreshold, 0, 2)
	panel.HealthColorLabels = CreateQuickItemLabel(nil, "Health Colors:", AlignmentColumn, panel.LowHealthThreshold, 0)
	panel.ColorHighHealth = CreateQuickColorbox(objectName.."ColorHighHealth", "高血量", AlignmentColumn, panel.HealthColorLabels , 16)
	panel.ColorMediumHealth = CreateQuickColorbox(objectName.."ColorMediumHealth", "中血量", AlignmentColumn, panel.ColorHighHealth , 16)
	panel.ColorLowHealth, F = CreateQuickColorbox(objectName.."ColorLowHealth", "低血量", AlignmentColumn, panel.ColorMediumHealth , 16)
	-- [ ]  Highlight Enemy Healers


	------------------------------
    -- Cast Bars
	------------------------------
    panel.SpellCastLabel, F = CreateQuickHeadingLabel(nil, "施法条", AlignmentColumn, F, 0, 5)
    panel.SpellCastEnableFriendly, F = CreateQuickCheckbutton(objectName.."SpellCastEnableFriendly", "启用友方施法条", AlignmentColumn, F)
	panel.SpellCastColorLabel, F = CreateQuickItemLabel(nil, "施法条颜色:", AlignmentColumn, F, 0, 2)
	panel.ColorNormalSpellCast, F = CreateQuickColorbox(objectName.."ColorNormalSpellCast", "可打断", AlignmentColumn, F , 16)
	panel.ColorUnIntpellCast, F = CreateQuickColorbox(objectName.."ColorUnIntpellCast", "不可打断", AlignmentColumn, F , 16)

	--[[
	------------------------------
	-- Text
	------------------------------
	panel.StatusTextLabel, F = CreateQuickHeadingLabel(nil, "Status Text", AlignmentColumn, F, 0, 5)

	panel.StatusTextLeft, F =  CreateQuickDropdown(objectName.."StatusTextLeft", "Custom Text Program:", CustomTextModes, 1, AlignmentColumn, F, 0, 0)
	panel.StatusTextLeftColor = CreateQuickCheckbutton(objectName.."StatusTextLeftColor", "Context Color", AlignmentColumn, F, 150, -16)
	--panel.StatusTextLeftBracket = CreateQuickCheckbutton(objectName.."StatusTextLeftBracket", "Bracket", AlignmentColumn, F, 300, -16)

	panel.StatusTextCenter, F =  CreateQuickDropdown(objectName.."StatusTextCenter", "", CustomTextModes, 1, AlignmentColumn, F, 0, -11)
	panel.StatusTextCenterColor = CreateQuickCheckbutton(objectName.."StatusTextCenterColor", "Context Color", AlignmentColumn, F, 150, -16)
	--panel.StatusTextCenterBracket = CreateQuickCheckbutton(objectName.."StatusTextCenterBracket", "Bracket", AlignmentColumn, F, 300, -16)

	panel.StatusTextRight, F =  CreateQuickDropdown(objectName.."StatusTextRight", "", CustomTextModes, 1, AlignmentColumn, F, 0, -11)
	panel.StatusTextRightColor = CreateQuickCheckbutton(objectName.."StatusTextRightColor", "Context Color", AlignmentColumn, F, 150, -16)
	--panel.StatusTextRightBracket = CreateQuickCheckbutton(objectName.."StatusTextRightBracket", "Bracket", AlignmentColumn, F, 300, -16)

	--]]

	------------------------------
	--Widgets
	------------------------------
	panel.WidgetsLabel, F = CreateQuickHeadingLabel(nil, "其他部件", AlignmentColumn, F, 0, 5)
	panel.WidgetTargetHighlight = CreateQuickCheckbutton(objectName.."WidgetTargetHighlight", "目标高亮", AlignmentColumn, panel.WidgetsLabel)
	panel.WidgetEliteIndicator = CreateQuickCheckbutton(objectName.."WidgetEliteIndicator", "显示精英图标", AlignmentColumn, panel.WidgetTargetHighlight)
	panel.ClassEnemyIcon = CreateQuickCheckbutton(objectName.."ClassEnemyIcon", "显示敌对职业图标", AlignmentColumn, panel.WidgetEliteIndicator)
	panel.ClassPartyIcon = CreateQuickCheckbutton(objectName.."ClassPartyIcon", "显示友好职业图标", AlignmentColumn, panel.ClassEnemyIcon)
	panel.WidgetsTotemIcon = CreateQuickCheckbutton(objectName.."WidgetsTotemIcon", "显示图腾图标", AlignmentColumn, panel.ClassPartyIcon)
	panel.WidgetsComboPoints = CreateQuickCheckbutton(objectName.."WidgetsComboPoints", "显示连击点", AlignmentColumn, panel.WidgetsTotemIcon)

	panel.WidgetsEnableExternal = CreateQuickCheckbutton(objectName.."WidgetsEnableExternal", "启用外部部件", AlignmentColumn, panel.WidgetsComboPoints)

	panel.WidgetsThreatIndicator, F = CreateQuickCheckbutton(objectName.."WidgetsThreatIndicator", "显示仇恨指示器", AlignmentColumn, panel.WidgetsLabel, OffsetColumnB)
	--panel.WidgetsThreatIndicatorMode =  CreateQuickDropdown(objectName.."WidgetsThreatIndicatorMode", "Threat Indicator:", ThreatWidgetModes, 1, AlignmentColumn, panel.WidgetsThreatIndicator, OffsetColumnB+16)
	panel.WidgetsRangeIndicator = CreateQuickCheckbutton(objectName.."WidgetsRangeIndicator", "小队距离警告", AlignmentColumn, F, OffsetColumnB)
	panel.WidgetsRangeMode =  CreateQuickDropdown(objectName.."WidgetsRangeMode", "距离:", RangeModes, 1, AlignmentColumn, panel.WidgetsRangeIndicator, OffsetColumnB+16)

	------------------------------
	-- Advanced
	------------------------------
	panel.AdvancedLabel = CreateQuickHeadingLabel(nil, "高级", AlignmentColumn, panel.WidgetsEnableExternal, 0, 5)
	panel.AdvancedEnableUnitCache, F = CreateQuickCheckbutton(objectName.."AdvancedEnableUnitCache", "允许对象数据缓存", AlignmentColumn, panel.AdvancedLabel)
	panel.FrameVerticalPosition, F = CreateQuickSlider(objectName.."FrameVerticalPosition", "血条垂直位置（设置太过分会影响鼠标点击面板）", AlignmentColumn, F, 0, 4)
	panel.FrameBarWidth, F = CreateQuickSlider(objectName.."FrameBarWidth", "血条宽度(%)", AlignmentColumn, F, 0, 4)

	--panel.AdvancedCustomCodeLabel = CreateQuickItemLabel(nil, "Custom Theme Code:", AlignmentColumn, panel.FrameVerticalPosition, 0, 4)
	--panel.AdvancedCustomCodeTextbox = CreateQuickEditbox(objectName.."AdvancedCustomCodeTextbox", AlignmentColumn, panel.AdvancedHealthTextLabel, 8)


	--[[
	theme.Default.name.size = 18
	--]]
	local ClearCacheButton = CreateFrame("Button", objectName.."ClearCacheButton", AlignmentColumn, "TidyPlatesPanelButtonTemplate")
	ClearCacheButton:SetPoint("TOPLEFT", F, "BOTTOMLEFT",-6, -18)
	--ClearCacheButton:SetPoint("TOPLEFT", panel.AdvancedCustomCodeTextbox, "BOTTOMLEFT",-6, -18)
	ClearCacheButton:SetWidth(300)
	ClearCacheButton:SetText("清理缓存")
	ClearCacheButton:SetScript("OnClick", function()
			local count = 0
			for index, obj in pairs(TidyPlatesWidgetData) do
				if type(obj) == 'table' then
					for subIndex in pairs(obj) do
						count = count + 1
						TidyPlatesWidgetData[index][subIndex] = nil
					end
				end
			end
			print("Tidy Plates Hub: Cleared", count, "entries from cache.")
		end)

	local BlizzOptionsButton = CreateFrame("Button", objectName.."BlizzButton", AlignmentColumn, "TidyPlatesPanelButtonTemplate")
	BlizzOptionsButton:SetPoint("TOPLEFT", ClearCacheButton, "BOTTOMLEFT", 0, -16)
	--BlizzOptionsButton:SetPoint("TOPLEFT", panel.AdvancedCustomCodeTextbox, "BOTTOMLEFT",-6, -18)
	BlizzOptionsButton:SetWidth(300)
	BlizzOptionsButton:SetText("暴雪姓名版...")
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
	--SetSliderMechanics(panel.UnitSpotlightOpacity, 1, 0, 1, .01)
	--SetSliderMechanics(panel.UnitSpotlightScale, 1, .1, 2.5, .01)

	SetSliderMechanics(panel.OpacityTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityNonTarget, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacitySpotlight, 1, 0, 1, .01)
	SetSliderMechanics(panel.OpacityFiltered, 1, 0, 1, .01)

	SetSliderMechanics(panel.ScaleFiltered, 1, .5, 2.2, .01)
	SetSliderMechanics(panel.ScaleStandard, 1, .5, 2.2, .01)
	SetSliderMechanics(panel.ScaleSpotlight, 1, .5, 2.2, .01)

	SetSliderMechanics(panel.FrameVerticalPosition, .5, 0, 1, .02)
	SetSliderMechanics(panel.FrameBarWidth, .5, 0, 1.2, .02)

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
		ConvertStringToTable(LocalVars.UnitSpotlightList, LocalVars.UnitSpotlightLookup)

		-- Convert Custom Code...  (Testing)

		-- local func, err = loadstring( [[return function(unit) ]]..LocalVars.AdvancedCustomCodeTextbox..[[ end]])
		-- if func == nil and err then print(panel.name, "|r CUSTOM SCRIPT ERROR", err)
		-- elseif func then LocalVars.CustomHealthFunction = func()	end
	end
end

--local function OnLogin()
	-- Init
	--InitializeTidyPlatesHubMenus()

	-- Create Instances of Panels
	-- [[
	local TankPanel = CreateInterfacePanel( "HubPanelSettingsTank", "Tidy Plates Hub: |cFF3782D1坦克", nil )
	CreateInterfacePanelWidgets(TankPanel)
	InterfaceOptions_AddCategory(TankPanel)
	function ShowTidyPlatesHubTankPanel() TidyPlatesUtility.OpenInterfacePanel(TankPanel) end
	--]]

	local DamagePanel = CreateInterfacePanel( "HubPanelSettingsDamage", "Tidy Plates Hub: |cFFFF1100输出", nil )
	CreateInterfacePanelWidgets(DamagePanel)
	InterfaceOptions_AddCategory(DamagePanel)
	function ShowTidyPlatesHubDamagePanel() TidyPlatesUtility.OpenInterfacePanel(DamagePanel) end


	local HealerPanel = CreateInterfacePanel( "HubPanelSettingsHealer", "Tidy Plates Hub: |cFF44DD55治疗", nil )
	CreateInterfacePanelWidgets(HealerPanel)
	InterfaceOptions_AddCategory(HealerPanel)
	function ShowTidyPlatesHubHealerPanel() InterfaceOptionsFrame_OpenToCategory(HealerPanel) end



---------------------------------------------
-- Slash Commands
---------------------------------------------

local function GetProfile()
	if TidyPlatesUtility.GetSpec(false, false) == 2 then return TidyPlatesOptions.SecondaryProfile
	else return TidyPlatesOptions.PrimaryProfile end
end

function ShowTidyPlatesHubPanel(profile)

	if profile == "Tank" then
		ShowTidyPlatesHubTankPanel()
	elseif profile == "Healer" then
		ShowTidyPlatesHubHealerPanel()
	else
		ShowTidyPlatesHubDamagePanel()
	end
	--local theme = TidyPlatesThemeList[TidyPlatesOptions[GetCurrentSpec()]]
	--if theme and theme.ShowConfigPanel and type(theme.ShowConfigPanel) == 'function' then theme.ShowConfigPanel() end
end

local function SlashCommandHub()
	local profile = GetProfile()
	ShowTidyPlatesHubPanel(profile)
end


SLASH_HUB1 = '/hub'
SlashCmdList['HUB'] = SlashCommandHub


--[[
	local ColorPanel = CreateInterfacePanel( "HubPanelSettingsColors", "Tidy Plates Hub: Colors", nil )
	ColorPanel.RefreshSettings = function() end
	InterfaceOptions_AddCategory(ColorPanel)
--]]
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

--]]


StaticPopupDialogs["TIDYPLATESHUB_RESETCHECK"] = {
  text = "Tidy Plates Hub: 你的设置无法在当前版本上运行...",
  button1 = "重置并重载UI",
  button2 = "忽略",

  OnAccept = function()
  		-- print()
  end,

  OnCancel = function()
  		-- print()
  end,

  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

--StaticPopup_Show ("TIDYPLATESHUB_RESETCHECK")
--StaticPopup_Hide ("EXAMPLE_HELLOWORLD")




