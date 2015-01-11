local mod	= DBM:NewMod(535, "DBM-Party-BC", 8, 250)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(18343)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local WarnPrison   = mod:NewTargetAnnounce(32361)

local timerPrison   = mod:NewTargetTimer(5, 32361)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 32361 then
		WarnPrison:Show(args.destName)
		timerPrison:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 32361 then
		timerPrison:Cancel(args.destName)
	end
end