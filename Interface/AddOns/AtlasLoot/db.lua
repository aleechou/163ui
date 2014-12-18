AtlasLoot.AtlasLootDBDefaults = {
	BonusRoll = {	
		Load = {	-- single modules can be disabled here
			["*"] = true,
		},
	},
	Tooltip = {	-- Core\Tooltip.lua
		tooltip = "AtlasLootTooltip",
	},
	GUI = {		-- GUI\GUI.lua
		point = {"CENTER"},
		DefaultFrameLocked = false,
		selected = {"AtlasLoot_WarlordsofDraenor", "Highmaul", 1, 0},
		classFilter = false,
		hideBGImage = false,
	},
	Map = {		-- Map\
		point = {"CENTER"},
		locked = false,
	},
	QuickLootFrame = {
		point = {"CENTER"},
	},
	SetViewFrame = {
		point = {"CENTER"},
		currentContentType = "stats",
	},
	MiniMapButton = {
		point = false,
		shown = true,
	},
	Button = {	-- Button
		["*"] = {
			ClickHandler = {},
		},
		Item = {
			showDropRate = true,
			alwaysShowCompareTT = false,
			showCompletedHook = false,
			ClickHandler = {}
		},
	},
	Addons = {
		BonusRoll = {
			enabled = true,
			useEncounterJournalInfo = false,
		},
		Search = {
			point = {"CENTER"},
		},
	},
}