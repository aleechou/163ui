local mod	= DBM:NewMod("Shadron", "DBM-ChamberOfAspects", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 157 $"):sub(12, -3))
mod:SetCreatureID(30451)
mod:SetEncounterID(1091)
mod:SetModelID(27421)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
    "SPELL_CAST_SUCCESS"
)
mod.onlyNormal = true

local warnShadowFissure		= mod:NewSpellAnnounce(59127)
local timerShadowFissure	= mod:NewCastTimer(5, 59128)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.


function mod:SPELL_CAST_SUCCESS(args)
    if args:IsSpellID(57579, 59127) then
        warnShadowFissure:Show()
        timerShadowFissure:Start()
    end
end