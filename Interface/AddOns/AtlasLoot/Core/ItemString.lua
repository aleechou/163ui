local AtlasLoot = _G.AtlasLoot
local ItemString = {}
AtlasLoot.ItemString = ItemString

-- lua
local format = string.format
local tbl_concat = table.concat

-- itemID:enchant:gem1:gem2:gem3:gem4:suffixID:uniqueID:level:upgradeId:instanceDifficultyID:numBonusIDs:bonusID1:bonusID2
local ITEM_FORMAT_STRING = "item:%d:0:0:0:0:0:0:0:0:0:0:0"
local ITEM_FORMAT_ALL_STRING = "item:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%s"
local ITEM_FORMAT_BONUS_STRING = "item:%d:0:0:0:0:0:0:0:0:0:0:%d:%s"


ATLASLOOT_ITEM_BONUSIDS = {
	-- Raid
	["LFR"] = 451,
	["SoOWarforged"] = 448,
	["HeroicRaid"] = 566,
	["MythicRaid"] = 567,
}

local ITEM_BONUS_PRESET = {
	-- Dungeons
	["BSM"]				= { 518 },
	["ID"]				= { 519 },
	["Auch"]			= { 520 },
	["Skyreach"]			= { 521 },
	["Dungeon"]			= { 522 },
	["HCDungeon"]			= { 524 },
	["HCDungeonWarforged"]		= { 524, 448 },
	-- Raids
	["LFR"]				= { 451 },
	["SoOWarforged"]		= { 448 },
	["HeroicSoO"] 			= { 449 },
	["HeroicSoOWarforged"]		= { 449, 448 },
	["MythicSoO"] 			= { 450 },
	["MythicSoOWarforged"]		= { 450, 448 },
	["RaidWarforged"]		= { 560 },
	["HeroicRaid"] 			= { 566 },
	["HeroicRaidWarforged"] 	= { 566, 561 },
	["MythicRaid"] 			= { 567 },
	["MythicRaidWarforged"]		= { 567, 562 },
	-- Crafting
	["Stage1"]			= { 525 },
	["Stage2"]			= { 526 },
	["Stage3"]			= { 527 },
	["Stage2W"]			= { 558 },
	["Stage3W"]			= { 559 },
}


function ItemString.Create(itemID, extra)
	if extra then
		return format( ITEM_FORMAT_EXTRA_STRING,
			itemID,									-- itemID
			extra.enchant or 0,						-- extra.enchant
			extra.gem1 or 0,						-- extra.gem1
			extra.gem2 or 0,						-- extra.gem2
			extra.gem3 or 0,						-- extra.gem3
			extra.gem4 or 0,						-- extra.gem4
			extra.suffixID or 0,					-- extra.suffixID
			extra.uniqueID or 0,					-- extra.uniqueID
			extra.level or 0,						-- extra.level
			extra.upgradeId or 0,					-- extra.upgradeId
			extra.instanceDifficultyID or 0,		-- extra.instanceDifficultyID
			extra.bonus and #extra.bonus or 0,
			extra.bonus and tbl_concat(extra.bonus, ":") or ""
		)
	else
		return format( ITEM_FORMAT_STRING,
			itemID			-- itemID
		)
	end
end

function ItemString.AddBonus(itemID, bonus)
	bonus = bonus and (ITEM_BONUS_PRESET[bonus] or ITEM_BONUS_PRESET[bonus[1]]) or bonus
	return format( ITEM_FORMAT_BONUS_STRING,
			itemID,
			bonus and #bonus or 0,
			bonus and tbl_concat(bonus, ":") or ""
		) 
end

-- /run print(AtlasLoot.ItemString.AddBonus(31051, {level = 100, bonus = {566}}))