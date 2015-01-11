local mod	= DBM:NewMod(557, "DBM-Party-BC", 2, 256)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 494 $"):sub(12, -3))
mod:SetCreatureID(17377, 17653)--17377 is boss, 17653 are channelers that just pull with him.

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 17377 then
		DBM:EndCombat(self)
	end
end
