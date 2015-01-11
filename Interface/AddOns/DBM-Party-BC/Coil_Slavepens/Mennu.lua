local mod	= DBM:NewMod(570, "DBM-Party-BC", 4, 260)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17941)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_SUMMON"
)

local WarnCorruptedNova   	= mod:NewSpellAnnounce(31991)

local specWarnCorruptedNova	= mod:NewSpecialWarningSwitch(31991, mod:IsDps())

function mod:SPELL_SUMMON(args)
	if args.spellId == 31991 then
		WarnCorruptedNova:Show()
		specWarnCorruptedNova:Show()
	end
end