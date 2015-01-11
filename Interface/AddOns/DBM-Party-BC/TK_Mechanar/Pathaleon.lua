local mod = DBM:NewMod(565, "DBM-Party-BC", 13, 258)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(19220)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnMC      = mod:NewTargetAnnounce(35280)
local timerMC     = mod:NewTargetTimer(10, 35280)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35280 then
		warnMC:Show(args.destName)
		timerMC:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 35280 then
		timerMC:Cancel(args.destName)
	end
end