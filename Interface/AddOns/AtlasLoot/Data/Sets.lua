-- Set data is mostly loaded with "AtlasLoot_Collections"

local AtlasLoot = _G.AtlasLoot
local Sets = {}
AtlasLoot.Data.Sets = Sets
local AL = AtlasLoot.Locales

-- lua
local assert = assert

-- contains all sets 
local Storage = {
	["Std"] = {		-- Standart sets
		["testSet"] = {
			contentTypes = {
				"stats",
				"droplocation",
			},
			data = {
				{	-- item1
					itemID = 31051,
					content = { 
						true,	-- this items should show stats
						{ "Instance 1", "INI 509", "INI 509", "INI 509" },
					},
				},
				{	-- item2
					itemID = 31054,
					content = { 
						true,	-- this items should show stats
						"Instance 2",
					},
				},
				{	-- item3
					itemID = 31052,
					content = { 
						true,	-- this items should show stats
						"Instance 3",
					},
				},
				{	-- item4
					itemID = 34436,
					content = { 
						true,	-- this items should show stats
						"Instance 4",
					},
				},
				{	-- item5
					itemID = 31050,
					content = { 
						true,	-- this items should show stats
						"Instance 5",
					},
				},
				{	-- item6
					itemID = 34541,
					content = { 
						true,	-- this items should show stats
						"Instance 5",
					},
				},
				{	-- item7
					itemID = 31053,
					content = { 
						true,	-- this items should show stats
						"Instance 5",
					},
				},
				{	-- item8
					itemID = 34564,
					content = { 
						true,	-- this items should show stats
						"Instance 5",
					},
				},
				{	-- item9
					itemID = 32374,
					content = { 
						true,	-- this items should show stats
						"Instance 5",
					},
				},
			},
		},
	},
}

function Sets:RegisterNewSets(addonName, tab)
	assert(not Storage[addonName], addonName.." already exists.")
	Storage[addonName] = tab
end

function Sets:GetSetTable(addonName)
	return Storage[addonName]
end

function Sets:GetSet(addonName, setName)
	return Storage[addonName] and Storage[addonName][setName] or nil
end

