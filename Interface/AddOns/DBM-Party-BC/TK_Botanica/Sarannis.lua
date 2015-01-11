local mod = DBM:NewMod(558, "DBM-Party-BC", 14, 257)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(17976)
mod:SetModelID(18929)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)