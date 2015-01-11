local mod = DBM:NewMod(559, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 547 $"):sub(12, -3))

mod:SetCreatureID(17975)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS"
)

local WarnTranq		= mod:NewSpellAnnounce("ej5457", 3)

local specWarnTranq	= mod:NewSpecialWarningSwitch("ej5458", mod:IsDps())

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 34557 then      --Summon Frayer Protector
		WarnTranq:Show()
		specWarnTranq:Show()
	end
end