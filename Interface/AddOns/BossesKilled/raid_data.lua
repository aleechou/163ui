local _, addon = ...

-- Index is from the first argument of DungeonInfoFunc.
-- This table is needed as there's no way to find out how many encounters are in each part of the same raid (to my knowledge).
addon.raidData = {
	-- MoP Raid finder as of 5.4
	[527] = { numEncounters = 3, startFrom =  1}, -- Guardians of Mogu'shan
	[528] = { numEncounters = 3, startFrom =  4}, -- The Vault of Mysteries
	[529] = { numEncounters = 3, startFrom =  1}, -- The Dread Approach
	[530] = { numEncounters = 3, startFrom =  4}, -- Nightmare of Shek'zeer
	[526] = { numEncounters = 4, startFrom =  1}, -- Terrace of Endless Spring
	[610] = { numEncounters = 3, startFrom =  1}, -- Last Stand of the Zandalari
	[611] = { numEncounters = 3, startFrom =  4}, -- Forgotten Depths
	[612] = { numEncounters = 3, startFrom =  7}, -- Halls of Flesh-Shaping
	[613] = { numEncounters = 3, startFrom = 10}, -- Pinnacle of Storms
	[716] = { numEncounters = 4, startFrom =  1}, -- Vale of Eternal Sorrows
	[717] = { numEncounters = 4, startFrom =  5}, -- Gates of Retribution
	[724] = { numEncounters = 3, startFrom =  9}, -- The Underhold
	[725] = { numEncounters = 3, startFrom = 12}, -- Downfall
	-- MoP Flex raids as of 5.4
	[726] = { numEncounters = 4, startFrom =  1}, -- Vale of Eternal Sorrows
	[728] = { numEncounters = 4, startFrom =  5}, -- Gates of Retribution
	[729] = { numEncounters = 3, startFrom =  9}, -- The Underhold
	[730] = { numEncounters = 3, startFrom = 12}, -- Downfall
}