local mod	= DBM:NewMod("Kazrogal", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 532 $"):sub(12, -3))
mod:SetCreatureID(17888)
mod:SetModelID(17886)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnMark		= mod:NewCountAnnounce(31447, 3)
local warnStomp		= mod:NewSpellAnnounce(31480, 2)

local timerMark		= mod:NewBuffFadesTimer(6.2, 31447)
local timerMarkCD	= mod:NewNextCountTimer(45, 31447)

local count = 0
local time = 45

function mod:OnCombatStart(delay)
	time = 45
	count = 0 
	timerMark:Start(time-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 31447 then
		count = count + 1
		if time > 10 then
			time = time - 5
		end
		warnMark:Show(count)
		timerMark:Start()
		timerMarkCD:Start(nil, time)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31480 then
		warnStomp:Show()
	end
end
