local AtlasLoot = _G.AtlasLoot

-- lua
local rawget = rawget
local _, tmp1
local months = {CalendarGetMonthNames()}

local GetAchievementInfo = GetAchievementInfo
local GetMapNameByID = GetMapNameByID

local function GetSpecNameById(id)
	_, tmp1 = GetSpecializationInfoByID(id)
	return tmp1
end

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
	["The August Celestials"] = GetFactionInfoByID(1341),

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
	-- Class Specs
	-- ######################################################################
	["Balance"] = GetSpecNameById(102),
	["Feral"] = GetSpecNameById(103),
	["Guardian"] = GetSpecNameById(104),
	["Restoration"] = GetSpecNameById(105),
	["Blood"] = GetSpecNameById(250),
	["Frost"] = GetSpecNameById(251),
	["Unholy"] = GetSpecNameById(252),
	["Brewmaster"] = GetSpecNameById(268),
	["Mistweaver"] = GetSpecNameById(270),
	["Windwalker"] = GetSpecNameById(269),
	["Discipline"] = GetSpecNameById(256),
	["Holy"] = GetSpecNameById(257),
	["Shadow"] = GetSpecNameById(258),
	["Protection"] = GetSpecNameById(66),
	["Retribution"] = GetSpecNameById(70),
	["Elemental"] = GetSpecNameById(262),
	["Enhancement"] = GetSpecNameById(263),
	["Arms"] = GetSpecNameById(71),
	["Fury"] = GetSpecNameById(72),

	-- ######################################################################
	-- Zones
	-- ######################################################################
	-- Classic
	["Ahn'Qiraj"] = GetMapNameByID(766),
	["Blackrock Depths"] = GetMapNameByID(704),
	["Blackwing Lair"] = GetMapNameByID(755),
	["Lower Blackrock Spire"] = GetAchievementName(643),
	["Molten Core"] = GetMapNameByID(696),
	["Orgrimmar"] = GetMapNameByID(321),
	["Ruins of Ahn'Qiraj"] = GetMapNameByID(717),
	["Shadowfang Keep"] = GetMapNameByID(764),
	["Stormwind City"] = GetMapNameByID(301),
	["Upper Blackrock Spire"] = GetAchievementName(1307),

	-- Burning Crusade
	["Black Temple"] = GetMapNameByID(796),
	["Gruul's Lair"] = GetMapNameByID(776),
	["Hyjal Summit"] = GetMapNameByID(775),
	["Karazhan"] = GetMapNameByID(799),
	["Magtheridon's Lair"] = GetMapNameByID(779),
	["Outland"] = GetAchievementCriteriaInfo(46,3),
	["Serpentshrine Cavern"] = GetMapNameByID(780),
	["Shattrath City"] = GetMapNameByID(481),
	["Sunwell Plateau"] = GetMapNameByID(789),
	["Tempest Keep"] = GetMapNameByID(782),
	["The Slave Pens"] = GetMapNameByID(728),

	-- Wrath of the Lich King
	["Dalaran"] = GetMapNameByID(504),
	["Icecrown"] = GetMapNameByID(492),
	["Icecrown Citadel"] = GetMapNameByID(604),
	["Naxxramas"] = GetMapNameByID(535),
	["Northrend"] = GetAchievementCriteriaInfo(46,4),
	["Onyxia's Lair"] = GetMapNameByID(718),
	["The Eye of Eternity"] = GetMapNameByID(527),
	["The Obsidian Sanctum"] = GetMapNameByID(531),
	["The Ruby Sanctum"] = GetMapNameByID(609),
	["Trial of the Crusader"] = GetMapNameByID(543),
	["Ulduar"] = GetMapNameByID(529),
	["Vault of Archavon"] = GetMapNameByID(532),

	-- Cataclysm
	["Molten Front"] = GetMapNameByID(795),

	-- Mists of Pandaria
	["Scarlet Monastery"] = GetMapNameByID(874),
	["Timeless Isle"] = GetMapNameByID(951),
	
	-- data from Core/ItemInfo.lua is generated after loading
}
AtlasLoot.IngameLocales = IngameLocales

setmetatable(IngameLocales, { __index = function(tab, key) return rawget(tab, key) or key end } )