-- Arenas mod v3.0
-- rewrite by Tandanu
--

local mod		= DBM:NewMod("Arenas", "DBM-PvP", 1)
local L			= mod:GetLocalizedStrings()

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

mod:SetRevision(("$Revision: 9938 $"):sub(12, -3))
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents("CHAT_MSG_BG_SYSTEM_NEUTRAL")

local timerShadow	= mod:NewTimer(90, "TimerShadow", 34709)
local timerDamp		= mod:NewCastTimer(300, 110310)

local countdownMatchStart	= mod:NewCountdown(15, 91344)

function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
	if not IsActiveBattlefieldArena() then return end
	if msg == L.Start15 then
		timerShadow:Schedule(16)
		timerDamp:Schedule(16)
		countdownMatchStart:Start()
	end
end
