local mod	= DBM:NewMod(595, "DBM-Party-WotLK", 5, 274)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 157 $"):sub(12, -3))
mod:SetCreatureID(29932)
mod:SetEncounterID(389)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
mod.onlyHeroic = true

local enrageTimer	= mod:NewBerserkTimer(120)

function mod:OnCombatStart(delay)
	enrageTimer:Start(120 - delay)
end