local mod = DBM:NewMod(543, "DBM-Party-BC", 9, 252)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(18473)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnSheep					= mod:NewTargetAnnounce(38245, 3)
local warnArcaneExplosion		= mod:NewCastAnnounce(38197, 4)

local specWarnArcaneExplosion	= mod:NewSpecialWarningSpell(38197, nil, nil, nil, 2)

local timerArcaneExplosion		= mod:NewCastTimer(5, 38197)


function mod:SPELL_CAST_START(args)
	if args:IsSpellID(38197, 40425) then
		warnArcaneExplosion:Show()
		specWarnArcaneExplosion:Show()
		timerArcaneExplosion:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(38245, 43309) then
		warnSheep:Show(args.destName)
	end
end