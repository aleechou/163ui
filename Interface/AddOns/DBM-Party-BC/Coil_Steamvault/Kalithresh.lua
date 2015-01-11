local mod	= DBM:NewMod(575, "DBM-Party-BC", 6, 261)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17798)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED"
)

local WarnChannel   = mod:NewSpellAnnounce("ej6001", 2, 31543)
local WarnReflect   = mod:NewSpellAnnounce(31534, 4)

local specWarnChannel	= mod:NewSpecialWarningSwitch("ej6001", false)
local specWarnReflect	= mod:NewSpecialWarningSpell(31534, not mod:IsMelee())

local timerReflect  = mod:NewBuffActiveTimer(8, 31534)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 31543 then
		WarnChannel:Show()
		specWarnChannel:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31534 then
		WarnReflect:Show(args.destName)
		timerReflect:Start(args.destName)
		specWarnReflect:Show()
	end
end
