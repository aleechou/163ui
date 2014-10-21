
local L = LibStub("AceLocale-3.0"):GetLocale("TradeSkillInfo")


-- upvalues, will be populated in :CreateConfig() at the bottom of the file
local knownSelect = {} -- the multiselect array for "Known by", "Learnable by", "Will be learnable by"
local db


local function getOption(info)
	return db[info.arg]
end

local function setOption(info, value)
	db[info.arg] = value
end

local function getColor(info)
	return db[info.arg].r, db[info.arg].g, db[info.arg].b
end

local function setColor(info, r, g, b)
	db[info.arg] = { r = r, g = g, b = b }
end

local function getMultiSelect(info, key)
	return db[info.arg][key]
end

local function setMultiSelect(info, key, state)
	db[info.arg][key] = state
end


local tooltipOptions = {
	name = L["Tooltip"],
	type = "group",
	desc = L["Tooltip Options"],
	order = 1,
	args = {
		flags = {
			name = L["Flags"],
			type = "group",
			get = getOption,
			set = setOption,
			inline = true,
			order = 1,
			args = {
				usedIn = {
					name = L["Used in"],
					desc = L["Show what tradeskill an item is used"],
					type = "toggle",
					arg = "TooltipUsedIn",
					order = 1,
				},
				usableBy = {
					name = L["Usable by"],
					desc = L["Show who can use an item"],
					type = "toggle",
					arg = "TooltipUsableBy",
					order = 2,
				},
				colorUsableBy = {
					name = L["Color usable by"],
					desc = L["Color the alt names in tooltip according to maximum combine difficulty"],
					type = "toggle",
					arg = "TooltipColorUsableBy",
					disabled = function() return not db["TooltipUsableBy"] end,
					order = 3,
				},
				source = {
					name = L["Source"],
					desc = L["Show the source of the item"],
					type = "toggle",
					arg = "TooltipSource",
					order = 4,
				},
				recipeSource = {
					name = L["Recipe Source"],
					desc = L["Show the source of recipes"],
					type = "toggle",
					arg = "TooltipRecipeSource",
					order = 5,
				},
				recipePrice = {
					name = L["Recipe Price"],
					desc = L["Show the price of recipes sold by vendors"],
					type = "toggle",
					arg = "TooltipRecipePrice",
					order = 6,
				},
				itemID = {
					name = L["Item ID"],
					desc = L["Show the item's ID"],
					type = "toggle",
					arg = "TooltipID",
					order = 7,
				},
				stackSize = {
					name = L["Stack Size"],
					desc = L["Show the item's stack size"],
					type = "toggle",
					arg = "TooltipStack",
					order = 8,
				},
				marketValue = {
					name = L["Market Value"],
					desc = L["Show the profit calculation from Auctioneer Market Value"],
					type = "toggle",
					arg = "TooltipMarketValue",
					order = 9,
				},
				knownBy = {
					name = L["Known by"],
					desc = L["Show who knows a recipe"],
					type = "multiselect",
					control = "Dropdown",
					values = knownSelect,
					get = getMultiSelect,
					set = setMultiSelect,
					arg = "TooltipKnownBy",
					order = 10,
				},
				learnableBy = {
					name = L["Learnable by"],
					desc = L["Show who can learn a recipe"],
					type = "multiselect",
					control = "Dropdown",
					values = knownSelect,
					get = getMultiSelect,
					set = setMultiSelect,
					arg = "TooltipLearnableBy",
					order = 11,
				},
				willBeLearnable = {
					name = L["Will be able to learn"],
					desc = L["Show who will be able to learn a recipe"],
					type = "multiselect",
					control = "Dropdown",
					values = knownSelect,
					get = getMultiSelect,
					set = setMultiSelect,
					arg = "TooltipAvailableTo",
					order = 12,
				},
			},
		},
		colors = {
			name = L["Colors"],
			type = "group",
			get = getColor,
			set = setColor,
			inline = true,
			order = 2,
			args = {
				usedIn = {
					name = L["Used in"],
					desc = L["Show what tradeskill an item is used"],
					type = "color",
					arg = "ColorSource",
					order = 1,
				},
				usableBy = {
					name = L["Usable by"],
					desc = L["Show who can use an item"],
					type = "color",
					arg = "ColorUsableBy",
					width = "double",
					order = 2,
				},
				source = {
					name = L["Source"],
					desc = L["Show the source of the item"],
					type = "color",
					arg = "ColorSource",
					order = 3,
				},
				recipeSource = {
					name = L["Recipe Source"],
					desc = L["Show the source of recipes"],
					type = "color",
					arg = "ColorRecipeSource",
					order = 4,
				},
				recipePrice = {
					name = L["Recipe Price"],
					desc = L["Show the price of recipes sold by vendors"],
					type = "color",
					arg = "ColorRecipePrice",
					order = 5,
				},
				itemID = {
					name = L["Item ID"],
					desc = L["Show the item's ID"],
					type = "color",
					arg = "ColorID",
					order = 6,
				},
				stackSize = {
					name = L["Stack Size"],
					type = "color",
					arg = "ColorStack",
					order = 7,
				},
				marketValue = {
					name = L["Market Value"],
					desc = L["Show the profit calculation from Auctioneer Market Value"],
					type = "color",
					arg = "ColorMarketValue",
					order = 8,
				},
				knownBy = {
					name = L["Known by"],
					desc = L["Show who knows a recipe"],
					type = "color",
					arg = "ColorKnownBy",
					order = 9,
				},
				learnableBy = {
					name = L["Learnable by"],
					desc = L["Show who can learn a recipe"],
					type = "color",
					arg = "ColorLearnableBy",
					order = 10,
				},
				willBeLearnable = {
					name = L["Will be able to learn"],
					desc = L["Show who will be able to learn a recipe"],
					type = "color",
					arg = "ColorAvailableTo",
					order = 11,
				},
			},
		},
	},
}


local tradeskillOptions = {
	name = L["Trade Skill"],
	desc = L["Trade Skill Window options"],
	type = "group",
	order = 2,
	get = getOption,
	set = setOption,
	args = {
		skillReq = {
			name = L["Skill required"],
			desc = L["Show skill required"],
			type = "toggle",
			arg = "ShowSkillLevel",
			width = "full",
			order = 1,
		},
		combineCost = {
			name = L["Combine cost"],
			desc = L["Show combine cost"],
			type = "toggle",
			arg = "ShowSkillProfit",
			width = "full",
			order = 2,
		},
	},
}


local mouseSelect = {
	[1] = L["Left Button"],
	[2] = L["Right Button"],
}

local modSelect = {
	[1] = L["Shift"],
	[2] = L["Control"],
	[3] = L["Alt"],
}

local strataSelect = {
	[1] = L["LOW"],
	[2] = L["MEDIUM"],
	[3] = L["HIGH"],
}

local uiOptions = {
	name = L["UI"],
	desc = L["UI Options"],
	type = "group",
	order = 3,
	args = {
		saveFrame = {
			name = L["Save Frame Position"],
			desc = L["Remember TradeskillInfoUI frame position"],
			type = "toggle",
			arg = "SavePosition",
			get = getOption,
			set = setOption,
			order = 1,
		},
		strata = {
			name = L["Frame Strata"],
			desc = L["Set TradeskillInfoUI frame strata"],
			values = strataSelect,
			type = "select",
			get = getOption,
			set = setOption,
			arg = "FrameStrata",
			order = 2,
		},
		scale = {
			name = L["UI Scale"],
			type = "range",
			desc = L["Change scale of user interface"],
			min = 0.5, max = 2, step = 0.05,
			isPercent = false,
			get = getOption,
			set = setOption,
			arg = "UIScale",
			order = 3,
		},
		quickSearch = {
			name = L["Quick Search"],
			desc = L["Enable Quick Search"],
			type = "toggle",
			arg = "QuickSearch",
			get = getOption,
			set = setOption,
			order = 4,
		},
		mouse = {
			name = L["Search Mouse Button"],
			desc = L["Mouse button that does a quick search"],
			type  = "select",
			values = mouseSelect,
			get = getOption,
			set = setOption,
			arg = "SearchMouseButton",
			disabled = function() return not db["QuickSearch"] end,
			order = 5,
		},
		modifier = {
			name = L["Search Modifier Key"],
			desc = L["Modifier key to be held down for quick search"],
			type  = "select",
			values = modSelect,
			get = getOption,
			set = setOption,
			arg = "SearchShiftKey",
			disabled = function() return not db["QuickSearch"] end,
			order = 6,
		},
	},
}


local ahOptions = {
	name = L["Auction"],
	desc = L["Auction House Options"],
	type = "group",
	order = 4,
	get = getColor,
	set = setColor,
	args = {
		ahcolor = {
			name = L["Color Recipes"],
			desc =L["Color recipes in the Auction House"],
			type = "toggle",
			arg = "ColorAHRecipes",
			get = getOption,
			set = setOption,
			width = "full",
			order = 1,
		},
		playerCan = {
			name = L["You can learn"],
			type = "color",
			arg = "AHColorLearnable",
			width = "full",
			disabled = function() return not db["ColorAHRecipes"] end,
			order = 2,
		},
		altCan = {
			name = L["An alt can learn"],
			type = "color",
			arg = "AHColorAltLearnable",
			width = "full",
			disabled = function() return not db["ColorAHRecipes"] end,
			order = 3,
		},
		playerWill = {
			name = L["You will be able to learn"],
			type = "color",
			arg = "AHColorWillLearn",
			width = "full",
			disabled = function() return not db["ColorAHRecipes"] end,
			order = 4,
		},
		altWill = {
			name = L["An alt will be able to learn"],
			type = "color",
			arg = "AHColorAltWillLearn",
			width = "full",
			disabled = function() return not db["ColorAHRecipes"] end,
			order = 5,
		},
		unavailable = {
			name = L["Unavailable or already known"],
			type = "color",
			arg = "AHColorUnavailable",
			width = "full",
			disabled = function() return not db["ColorAHRecipes"] end,
			order = 6,
		},
	},
}


function TradeskillInfo:CreateConfig()
	-- do not use "self" in this function as it will be attributed
	-- to AceConfig-3.0's namespace, not TradeSkillInfo's

	db = TradeskillInfo.db.profile

	for x, y in pairs(TradeskillInfo.vars.tradeskills) do
		knownSelect[x] = y
	end

	local options = {
		name = "TradeSkillInfo",
		type = "group",
		childGroups = "tab",
		args = {
			tooltip = tooltipOptions,
			tradeskill = tradeskillOptions,
			ui = uiOptions,
			auction = ahOptions,
			profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(TradeskillInfo.db),
		},
	}

	TradeskillInfo.optionsLoaded = true

	return options
end
