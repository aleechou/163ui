local mod	= DBM:NewMod(588, "DBM-Party-WotLK", 4, 273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(26630)
mod:SetEncounterID(369, 370)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
