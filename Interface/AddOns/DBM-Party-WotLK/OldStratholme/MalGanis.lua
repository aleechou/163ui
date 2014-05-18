local mod	= DBM:NewMod("MalGanis", "DBM-Party-WotLK", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2322 $"):sub(12, -3))
mod:SetCreatureID(26533)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Outro)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningSleep	= mod:NewTargetAnnounce(52721, 2)
local timerSleep	= mod:NewTargetTimer(10, 52721)
local timerSleepCD	= mod:NewCDTimer(20, 52721)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(52721, 58849) then
		warningSleep:Show(args.destName)
		timerSleep:Start(args.destName)
		timerSleepCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(52721, 58849) then
		timerSleep:Cancel()
	end
end