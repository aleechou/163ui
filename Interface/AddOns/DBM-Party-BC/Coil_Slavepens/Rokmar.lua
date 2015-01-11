local mod	= DBM:NewMod(571, "DBM-Party-BC", 4, 260)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17991)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

local WarnFrenzy	= mod:NewSpellAnnounce(34970)
local WarnWound		= mod:NewTargetAnnounce(38801)

local specWarnWound	= mod:NewSpecialWarningTarget(38801, mod:IsHealer())

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(31956, 38801) then
		WarnWound:Show(args.destName)
		specWarnWound:Show(args.destName)
	elseif args.spellId == 34970 and self:IsInCombat() then
		WarnFrenzy:Show(args.destName)
	end
end