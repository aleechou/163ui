local mod = DBM:NewMod(560, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(17978)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSacrifice       = mod:NewTargetAnnounce(34661)
local timerSacrifice      = mod:NewTargetTimer(8, 34661)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 34661 then
		warnSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 34661 then
		timerSacrifice:Cancel(args.destName)
	end
end
