local mod	= DBM:NewMod(597, "DBM-Party-WotLK", 6, 275)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(28586)
mod:SetEncounterID(555, 556)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warningWhirlwind = mod:NewSpellAnnounce(52027, 3)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(52027, 52028) then
		warningWhirlwind:Show()
	end
end