local mod = DBM:NewMod(561, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(17980)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnAllergic       = mod:NewTargetAnnounce(34697)
local timerAllergic      = mod:NewTargetTimer(18, 34697)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34697 then
		warnAllergic:Show(args.destName)
		timerAllergic:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 34697 then
		timerAllergic:Cancel(args.destName)
	end
end