local mod	= DBM:NewMod(529, "DBM-Party-BC", 1, 248)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17537, 17536)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

local warnMark      = mod:NewTargetAnnounce(30689)

local specwarnMark  = mod:NewSpecialWarningYou(30689)

local timerMark     = mod:NewTargetTimer(6, 30689)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30689 then
		warnMark:Show(args.destName)
		timerMark:Start(args.destName)
		if args:IsPlayer() then
            specwarnMark:Show()
        end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30689 then
		timerMark:Cancel(args.destName)
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 17537 then
		DBM:EndCombat(self)
	end
end
