-- DEBUG
ATLASLOOT_DEBUGMODE = false

-- difficultys
ATLASLOOT_DIFFICULTYS = {
	[1] = "Normal",
	[2] = "Heroic",
	[3] = "25 Player",
	[4] = "25 Player Heroic",
	[5] = "Raid Finder",
	[6] = "Flexible"
}
-- PreSet ID's for special itemtable options

--- Ignore this item while filter is enabled
-- ATLASLOOT_IT_FILTERIGNORE = true
ATLASLOOT_IT_FILTERIGNORE = 900

--- Setup the item for a faction
-- ATLASLOOT_IT_HORDE = true		<- this is a Horde only item (shown in lootpage but with horde background you can hide the item if you set ATLASLOOT_IT_ALLIANCE = false( example { 1, 1234, [ATLASLOOT_IT_HORDE] = true } )
-- ATLASLOOT_IT_HORDE = 1234		<- the Horde version of this item is 1234 ( example { 1, [ATLASLOOT_IT_HORDE] = 1234, [ATLASLOOT_IT_ALLIANCE] = 5678 }
ATLASLOOT_IT_HORDE = 901
ATLASLOOT_IT_ALLIANCE = 902

-- bonusIDs ( need check this later there are many bonus ID's with the same effect... )
ATLASLOOT_ITEM_BONUSIDS = {
	-- Raid
	["LFR"] = 451,
	["Warforged"] = 448,
	["HeroicRaid"] = 566,
	["MythicRaid"] = 567,
}

-- colors
ATLASLOOT_COLLECTION_COLOR = {0.3, 0.3, 0, 1}
ATLASLOOT_CRAFTING_COLOR = {0.46, 0.14, 0, 1}
ATLASLOOT_DUNGEON_COLOR = {0, 0, 0.3, 1}
ATLASLOOT_FACTION_COLOR = {0, 0.3, 0, 1}
ATLASLOOT_PVP_COLOR = {0, 0.36, 0.24, 1}
ATLASLOOT_RAID_COLOR = {0.3, 0, 0, 1}
ATLASLOOT_REMOVED_COLOR = {0.4, 0.2, 0, 1}
ATLASLOOT_UNKNOWN_COLOR = {0, 0, 0, 1}
ATLASLOOT_WORLDEVENTS_COLOR = {0.36, 0, 0.24, 1}

ATLASLOOT_ITEM_BACKGROUND_ALPHA = 0.9

ATLASLOOT_STYLE_TT_BACKDROP = {bgFile = "Interface/Tooltips/UI-Tooltip-Background",
						edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
						tile = true, tileSize = 16, edgeSize = 16, 
						insets = { left = 4, right = 4, top = 4, bottom = 4 }}
						
ATLASLOOT_STYLE_BOX_BACKDROP = {bgFile = "Interface/Tooltips/UI-Tooltip-Background"}