local mod	= DBM:NewMod(538, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17848)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnShot      = mod:NewTargetAnnounce(33792)
local timerShot     = mod:NewTargetTimer(6, 33792)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33792 then
		warnShot:Show(args.destName)
		timerShot:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 33792 then
		timerShot:Cancel(args.destName)
	end
end