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

		mainFrame = {
			bgColor = {0.45, 0.45, 0.45, 1},
			scale = 1,
			title = {
				bgColor = { 0.05, 0.05, 0.05, 1 },
				textColor = {1, 1, 1, 1},
				size = 12,
				font = "Friz Quadrata TT",
			},
		},
		contentTopBar = {
			bgColor = {0.05, 0.05, 0.05, 0.7},
			useContentColor = true,
			font = {
				color = {1, 1, 1, 1},
				size = 16,
				font = "Friz Quadrata TT",
			},
		},
		content = {
			showBgImage = false,
			bgColor = {0, 0, 0, 0.9},
		},
		contentBottomBar = {
			bgColor = {0.05, 0.05, 0.05, 0.5},
			useContentColor = false,
		},
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
		mainFrame = {
			bgColor = {0, 0, 0, 1},
			bgColorModel = {1, 1, 1, 1},
			scale = 1,
			title = {
				bgColor = { 0, 0.86, 1, 1 },
				textColor = {1, 1, 1, 1},
				size = 12,
				font = "Friz Quadrata TT",
			},
		},
		contentTopBottom = {
			bgColor = {0, 0.86, 1, 1},
			textColor = {1, 1, 1, 1},
			textFont = "Friz Quadrata TT",
			textSize = 12,
		},
		content = {
			bgColor = {1, 1, 1, 1},
			textColor = {1, 0.82, 0, 1},
			textFont = "Friz Quadrata TT",
			textSize = 12,
		},
	},
	MiniMapButton = {
		point = false,
		shown = true,
		locked = false,
		lockedAroundMiniMap = true,
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