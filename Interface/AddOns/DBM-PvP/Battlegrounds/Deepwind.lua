-- Deepwind Gorge mod v3.0
-- written by Cenuij

local mod		= DBM:NewMod("z1105", "DBM-PvP", 2)
local L			= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 30 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

local capTimer	= mod:NewTimer(60, "TimerCap", "Interface\\Icons\\Spell_Misc_HellifrePVPHonorHoldFavor")
local winTimer	= mod:NewTimer(30, "TimerWin", "Interface\\Icons\\INV_Misc_PocketWatch_01")

local bgzone = false
local GetMapLandmarkInfo, GetNumMapLandmarks = GetMapLandmarkInfo, GetNumMapLandmarks

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local ResPerSec = {
	[0] = 1e-300,
	[1] = 8/5,
	[2] = 16/5,
	[3] = 32/5,
}

local allyColor = {
	r = 0,
	g = 0,
	b = 1,
}
local hordeColor = {
	r = 1,
	g = 0,
	b = 0,
}

local objectives = {}

local function get_state_from_texture(id)
	if id == 18 then
		return 1	-- Alliance controlled
	elseif id == 20 then
		return 2	-- Horde controlled
	elseif id == 17 then
		return 3	-- Alliance assaulted
	elseif id == 19 then
		return 4	-- Horde assaulted
	else
		return -1
	end
end

local function get_objectives()
	local result = {}
	for i=1, GetNumMapLandmarks(), 1 do
		local name, _, texture = GetMapLandmarkInfo(i)
		if name and texture then
			result[name] = get_state_from_texture(texture)
		end
	end
	return result
end

local function get_basecount()
	local alliance = 0
	local horde = 0
	for name,state in pairs(objectives) do
		if 1 == state then
			alliance = alliance + 1
		elseif 2 == state then
			horde = horde + 1
		end
	end
	return alliance, horde
end

local function get_score()
	if not bgzone then return 0,0 end
	local AllyScore		= tonumber(string.match((select(4, GetWorldStateUIInfo(1)) or ""), L.ScoreExpr)) or 0
	local HordeScore	= tonumber(string.match((select(4, GetWorldStateUIInfo(2)) or ""), L.ScoreExpr)) or 0
	return AllyScore, HordeScore
end

local get_gametime
local update_gametime
do
	local gametime = 0
	function update_gametime()
		gametime = time()
	end
	function get_gametime()
		local systime = GetBattlefieldInstanceRunTime()
		if systime > 0 then
			return systime / 1000
		else
			return time() - gametime
		end
	end
end

local function Deepwind_Initialize()
	if 1105 == DBM:GetCurrentArea() then
		bgzone = true
		mod:RegisterShortTermEvents(
			"CHAT_MSG_BG_SYSTEM_HORDE",
			"CHAT_MSG_BG_SYSTEM_ALLIANCE",
			"CHAT_MSG_BG_SYSTEM_NEUTRAL",
			"CHAT_MSG_RAID_BOSS_EMOTE",
			"UPDATE_WORLD_STATES"
		)
		objectives = get_objectives()
	elseif bgzone then
		bgzone = false
		mod:UnregisterShortTermEvents()
	end
end

mod.OnInitialize = Deepwind_Initialize

function mod:ZONE_CHANGED_NEW_AREA()
	self:Schedule(1, Deepwind_Initialize)
end


--
-- capTimer
--
do
	local function check_for_updates()
		if not bgzone then return end
		local curobj = get_objectives()
		for name,state in pairs(curobj) do
			if state ~= objectives[name] then
				capTimer:Stop(name)
				if 3 == state then
					capTimer:Start(nil, name)
					capTimer:SetColor(allyColor, name)
					capTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02.blp", name)
				elseif 4 == state then
					capTimer:Start(nil, name)
					capTimer:SetColor(hordeColor, name)
					capTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01.blp", name)
				end
				objectives[name] = state
			end
		end
	end

	local function schedule_check(self)
		self:Schedule(1, check_for_updates)
	end

	mod.CHAT_MSG_BG_SYSTEM_ALLIANCE = schedule_check
	mod.CHAT_MSG_BG_SYSTEM_HORDE = schedule_check
	mod.CHAT_MSG_RAID_BOSS_EMOTE = schedule_check
	mod.CHAT_MSG_BG_SYSTEM_NEUTRAL = schedule_check
end

--
-- winTimer
--

function mod:UPDATE_WORLD_STATES()
	if not bgzone then return end

	local last_alliance_bases, last_horde_bases = get_basecount()
	local last_alliance_score, last_horde_score = get_score()

	local AllyTime = (1600 - last_alliance_score) / ResPerSec[last_alliance_bases]
	local HordeTime = (1600 - last_horde_score) / ResPerSec[last_horde_bases]

	if AllyTime > 5000 then		AllyTime = 5000 end
	if HordeTime > 5000 then	HordeTime = 5000 end

	if AllyTime == HordeTime then
		winner_is = 0
		winTimer:Stop()
		if self.ScoreFrame1Text then
			self.ScoreFrame1Text:SetText("")
			self.ScoreFrame2Text:SetText("")
		end

	elseif AllyTime > HordeTime then -- Horde wins
		if self.ScoreFrame1Text and self.ScoreFrame2Text then
			local AllyPoints = math.floor(math.floor(((HordeTime * ResPerSec[last_alliance_bases]) + last_alliance_score) / 10) * 10)
			self.ScoreFrame1Text:SetText("("..AllyPoints..")")
			self.ScoreFrame2Text:SetText("(1600)")
		end

		winner_is = 2
		winTimer:Update(get_gametime(), get_gametime()+HordeTime)
		winTimer:DisableEnlarge()
		local title = L.Horde or FACTION_HORDE--L.Horde is nil in english local, unless it's added to non english local, FACTION_HORDE will be used
		winTimer:UpdateName(L.WinBarText:format(title))
		winTimer:SetColor(hordeColor)
		winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_01.blp")

	elseif HordeTime > AllyTime then -- Alliance wins
		if self.ScoreFrame1Text and self.ScoreFrame2Text then
			local HordePoints = math.floor(math.floor(((AllyTime * ResPerSec[last_horde_bases]) + last_horde_score) / 10) * 10)
			self.ScoreFrame2Text:SetText("("..HordePoints..")")
			self.ScoreFrame1Text:SetText("(1600)")
		end

		winner_is = 1
		winTimer:Update(get_gametime(), get_gametime()+AllyTime)
		winTimer:DisableEnlarge()
		local title = L.Alliance or FACTION_ALLIANCE--L.Alliance is nil in english local, unless it's added to non english local, FACTION_ALLIANCE will be used
		winTimer:UpdateName(L.WinBarText:format(title))
		winTimer:SetColor(allyColor)
		winTimer:UpdateIcon("Interface\\Icons\\INV_BannerPVP_02.blp")
	end
end