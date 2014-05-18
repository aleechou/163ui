local mod	= DBM:NewMod("Erekem", "DBM-Party-WotLK", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29315)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

local warningES	= mod:NewSpellAnnounce(54479, 3)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(54479, 59471)
	and mod:GetCIDFromGUID(args.sourceGUID) == 29315 then
		warningES:Show()
	end
end