local mod	= DBM:NewMod("Anubarak", "DBM-Party-WotLK", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29120)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warningPound		= mod:NewSpellAnnounce(53472, 3)
local timerAchieve		= mod:NewAchievementTimer(240, 1860, "TimerSpeedKill") 

function mod:OnCombatStart(delay)
	if mod:IsDifficulty("heroic5") then
		timerAchieve:Start(-delay)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(53472, 59433) then
		warningPound:Show()
	end
end