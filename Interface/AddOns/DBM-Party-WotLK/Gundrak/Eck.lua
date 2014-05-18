local mod	= DBM:NewMod("Eck", "DBM-Party-WotLK", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2869 $"):sub(12, -3))
mod:SetCreatureID(29932)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
)

local enrageTimer	= mod:NewBerserkTimer(120)

function mod:OnCombatStart(delay)
	enrageTimer:Start(120 - delay)
end