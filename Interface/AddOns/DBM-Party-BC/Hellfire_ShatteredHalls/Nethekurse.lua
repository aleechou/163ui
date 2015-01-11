local mod	= DBM:NewMod(566, "DBM-Party-BC", 3, 259)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(16807)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
