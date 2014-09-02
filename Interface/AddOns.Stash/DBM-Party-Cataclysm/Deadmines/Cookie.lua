local mod	= DBM:NewMod(93, "DBM-Party-Cataclysm", 2, 63)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(47739)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)