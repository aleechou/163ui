-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...


-------------------------------------------------------------------------------
-- General constants.
-------------------------------------------------------------------------------
private.NPC_ID_MAX = 0xFFFFF -- Largest ID that will fit in a GUID's 20-bit NPC ID field.


private.CONTINENT_IDS = {
	KALIMDOR = 1,
	EASTERN_KINGDOMS = 2,
	OUTLAND = 3,
	NORTHREND = 4,
	THE_MAELSTROM = 5,
	PANDARIA = 6,
}


do
	local VIRTUAL_CONTINENTS = {
		[private.CONTINENT_IDS.THE_MAELSTROM] = true
	}


	private.LOCALIZED_CONTINENT_NAMES = { _G.GetMapContinents() }
	for continent_id in pairs(VIRTUAL_CONTINENTS) do
		private.LOCALIZED_CONTINENT_NAMES[continent_id] = nil
	end


	private.LOCALIZED_CONTINENT_IDS = {}
	for continent_id, continent_name in pairs(private.LOCALIZED_CONTINENT_NAMES) do
		private.LOCALIZED_CONTINENT_IDS[continent_name] = continent_id
	end
end -- do-block


private.ACHIEVEMENT_IDS = {
	BLOODY_RARE = 1312,
	FROSTBITTEN = 2257,
	ONE_MANY_ARMY = 7317,
	GLORIOUS = 7439,
	CHAMPIONS_OF_LEI_SHEN = 8103,
	TIMELESS_CHAMPION = 8714,
}


do
	private.ACHIEVEMENTS = {
		[private.ACHIEVEMENT_IDS.BLOODY_RARE]		= { WorldID = private.CONTINENT_IDS.OUTLAND },
		[private.ACHIEVEMENT_IDS.FROSTBITTEN]		= { WorldID = private.CONTINENT_IDS.NORTHREND },
		[private.ACHIEVEMENT_IDS.ONE_MANY_ARMY]		= { WorldID = private.CONTINENT_IDS.PANDARIA },
		[private.ACHIEVEMENT_IDS.GLORIOUS]		= { WorldID = private.CONTINENT_IDS.PANDARIA },
		[private.ACHIEVEMENT_IDS.CHAMPIONS_OF_LEI_SHEN]	= { WorldID = private.CONTINENT_IDS.PANDARIA },
		[private.ACHIEVEMENT_IDS.TIMELESS_CHAMPION]	= { WorldID = private.CONTINENT_IDS.PANDARIA },
	}


	local CRITERIA_TYPE_NPC_KILL = 0


	for achievement_id, achievement in pairs(private.ACHIEVEMENTS) do
		achievement.ID = achievement_id
		achievement.Criteria = {} -- [ CriteriaID ] = NpcID
		achievement.NPCsActive = {} -- [ NpcID ] = CriteriaID

		for criteria_index = 1, _G.GetAchievementNumCriteria(achievement_id) do
			local _, criteria_type, _, _, _, _, _, asset_id, _, criteria_id = _G.GetAchievementCriteriaInfo(achievement_id, criteria_index)
			local _, _, _, is_completed = _G.GetAchievementInfo(achievement_id)

			achievement.is_completed = is_completed

			if criteria_type == CRITERIA_TYPE_NPC_KILL then
				achievement.Criteria[criteria_id] = asset_id
			end
		end
	end
end -- do-block
