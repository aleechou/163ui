local mod	= DBM:NewMod(596, "DBM-Party-WotLK", 5, 274)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 105 $"):sub(12, -3))
mod:SetCreatureID(29306)
mod:SetModelID(27061)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
