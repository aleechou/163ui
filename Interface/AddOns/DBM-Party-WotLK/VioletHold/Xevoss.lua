local mod	= DBM:NewMod("Xevoss", "DBM-Party-WotLK", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2250 $"):sub(12, -3))
mod:SetCreatureID(29266)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)
