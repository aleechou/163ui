local AtlasLoot = _G.AtlasLoot

-- lua
local rawget = rawget
local _, tmp1
local months = {CalendarGetMonthNames()}

local GetAchievementInfo = GetAchievementInfo
local GetMapNameByID = GetMapNameByID

local function GetAchievementName(id)
	_, tmp1 = GetAchievementInfo(id)
	return tmp1
end

local IngameLocales = {
	-- ######################################################################
	-- Factions
	-- ######################################################################
	-- Warlords of Draenor
	["Bizmo's Brawlpub"] = GetFactionInfoByID(1691),
	["Brawl'gar Arena"] = GetFactionInfoByID(1690),
	-- Mists of Pandaria
	["Nat Pagle"] = GetFactionInfoByID(1358),
	["Old Hillpaw"] = GetFactionInfoByID(1276),
	["Sho"] = GetFactionInfoByID(1278),

	-- ######################################################################
	--- Items
	-- ######################################################################
	-- Feast of Winter Veil
	["Carefully Wrapped Present"] = GetItemInfo(21191),
	["Gaily Wrapped Present"] = GetItemInfo(21310),
	["Gently Shaken Gift"] = GetItemInfo(21271),
	["Festive Gift"] = GetItemInfo(21363),
	["Smokywood Pastures Extra-Special Gift"] = GetItemInfo(21216),
	["Stolen Present"] = GetItemInfo(116762),
	["Ticking Present"] = GetItemInfo(21327),
	["Winter Veil Gift"] = GetItemInfo(116761),

	-- ######################################################################
	-- Months
	-- ######################################################################
	["January"] = months[1],
	["February"] = months[2],
	["March"] = months[3],
	["April"] = months[4],
	["May"] = months[5],
	["June"] = months[6],
	["July"] = months[7],
	["August"] = months[8],
	["September"] = months[9],
	["October"] = months[10],
	["November"] = months[11],
	["December"] = months[12],

	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic
	["Ahn'Qiraj"] = GetMapNameByID(766),
	["Blackrock Depths"] = GetMapNameByID(704),
	["Blackwing Lair"] = GetMapNameByID(755),
	["Lower Blackrock Spire"] = GetAchievementName(643),
	["Molten Core"] = GetMapNameByID(696),
	["Ruins of Ahn'Qiraj"] = GetMapNameByID(717),
	["Upper Blackrock Spire"] = GetAchievementName(1307),

	-- Burning Crusade
	["Black Temple"] = GetMapNameByID(796),
	["Gruul's Lair"] = GetMapNameByID(776),
	["Hyjal Summit"] = GetMapNameByID(775),
	["Karazhan"] = GetMapNameByID(799),
	["Magtheridon's Lair"] = GetMapNameByID(779),
	["Serpentshrine Cavern"] = GetMapNameByID(780),
	["Sunwell Plateau"] = GetMapNameByID(789),
	["Tempest Keep"] = GetMapNameByID(782),

	-- Wrath of the Lich King
	["Icecrown Citadel"] = GetMapNameByID(604),
	["Naxxramas"] = GetMapNameByID(535),
	["Onyxia's Lair"] = GetMapNameByID(718),
	["The Eye of Eternity"] = GetMapNameByID(527),
	["The Obsidian Sanctum"] = GetMapNameByID(531),
	["The Ruby Sanctum"] = GetMapNameByID(609),
	["Trial of the Crusader"] = GetMapNameByID(543),
	["Ulduar"] = GetMapNameByID(529),
	["Vault of Archavon"] = GetMapNameByID(532),

	-- Mists of Pandaria
	["Scarlet Monastery"] = GetMapNameByID(874),
	
	-- data from Core/ItemInfo.lua is generated after loading
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end } )