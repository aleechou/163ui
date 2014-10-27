AtlasLoot.AtlasLootDBDefaults = {
	profile = {
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
			selected = {"AtlasLoot_MistsofPandaria", "SiegeofOrgrimmar", 1, 0},
			classFilter = false,
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
				ClickHandler = {}
			},
		},
		Addons = {
			BonusRoll = {
				useEncounterJournalInfo = false,
			},
			Search = {
				point = {"CENTER"},
			},
		},
	}
}