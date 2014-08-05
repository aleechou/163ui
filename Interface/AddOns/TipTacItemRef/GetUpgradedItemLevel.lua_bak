--[[
	GetUpgradedItemLevelFromItemLink(itemLink)
	Until Blizzard adds an easier solution, this function can be used to get the true upgraded itemLevel.
	The Lua file is easily portable between addons. The function is placed in the global namespace.
	* REV-05 (14.05.24) Patch 5.4.8:	Added IDs 504 to 507.
	* REV-04 (13.09.21) Patch 5.4:		Added IDs 491 to 498 to the table.
	* REV-03 (13.05.22) Patch 5.3:		Added the 465/466/467 IDs (0/4/8 lvls) to the table.
	* REV-02 (13.xx.xx) Patch 5.2:		Added the 470 ID (8 lvls) to the table.
--]]

-- Make sure we do not override a newer revision.
local REVISION = 5;
if (type(GET_UPGRADED_ITEM_LEVEL_REV) == "number") and (GET_UPGRADED_ITEM_LEVEL_REV >= REVISION) then
	return;
end
GET_UPGRADED_ITEM_LEVEL_REV = REVISION;

-- ItemLink pattern
local ITEMLINK_PATTERN = "(item:[^|]+)";
-- Finds the last and 11th parameter of an itemLink, which is the upgradeId
local ITEMLINK_PATTERN_UPGRADE = ":(%d+)$";
-- Table for adjustment of levels due to upgrade -- Source: http://www.wowinterface.com/forums/showthread.php?t=45388
local UPGRADED_LEVEL_ADJUST = {
	[001] = 8, -- 1/1
	-- Patch 5.1 --
	[373] = 4, -- 1/2
	[374] = 8, -- 2/2
	[375] = 4, -- 1/3
	[376] = 4, -- 2/3
	[377] = 4, -- 3/3
	[379] = 4, -- 1/2
	[380] = 4, -- 2/2
--	[445] = 0, -- 0/2
	[446] = 4, -- 1/2
	[447] = 8, -- 2/2
--	[451] = 0, -- 0/1
	[452] = 8, -- 1/1
--	[453] = 0, -- 0/2
	[454] = 4, -- 1/2
	[455] = 8, -- 2/2
--	[456] = 0, -- 0/1
	[457] = 8, -- 1/1
--	[458] = 0, -- 0/4
	[459] = 4, -- 1/4
	[460] = 8, -- 2/4
	[461] = 12, -- 3/4
	[462] = 16, -- 4/4
	-- Patch 5.3 --
--	[465] = 0,
	[466] = 4,
	[467] = 8,
	-- Patch ?? --
--	[468] = 0,
	[469] = 4,
	[470] = 8,
	[471] = 12,
	[472] = 16,
	-- Patch 5.4 --
--	[491] = 0,
	[492] = 4,
	[493] = 8,
--	[494] = 0,
	[495] = 4,
	[496] = 8,
	[497] = 12,
	[498] = 16,
	-- Patch 5.4.8 --
	[504] = 12,	-- US/EU upgrade 3/4
	[505] = 16,	-- US/EU upgrade 4/4
	[506] = 20,	-- Asia upgrade 5/6
	[507] = 24,	-- Asis upgrade 6/6
};

-- Analyses the itemLink and checks for upgrades that affects itemLevel -- Only itemLevel 450 and above will have this
function GetUpgradedItemLevelFromItemLink(itemLink)
	-- Make certain we only have the raw itemLink, and not the full itemString
	itemLink = itemLink:match(ITEMLINK_PATTERN);
	local _, _, _, itemLevel = GetItemInfo(itemLink);
	local upgradeId = tonumber(itemLink:match(ITEMLINK_PATTERN_UPGRADE));
	if (itemLevel) and (itemLevel >= 450) and (upgradeId) and (UPGRADED_LEVEL_ADJUST[upgradeId]) then
		return itemLevel + UPGRADED_LEVEL_ADJUST[upgradeId];
	else
		return itemLevel;
	end
end