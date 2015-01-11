local mod	= DBM:NewMod(591, "DBM-Party-WotLK", 4, 273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(26632)
mod:SetEncounterID(375, 376)
mod:SetModelID(27072)--Does not scale, but at least it's on face. Leaving on for now.
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH boss1 target focus mousover"
)

local warningDecayFleshSoon	= mod:NewSoonAnnounce(49356, 2)
local warningCloud 			= mod:NewSpellAnnounce(49548, 3)

local warnedDecay = false

function mod:OnCombatStart()
	warnedDecay = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(49548, 59969) then
		warningCloud:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedDecay and self:GetUnitCreatureId(uId) == 26632 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.58 then
		warnedDecay = true
		warningDecayFleshSoon:Show()
	end
end
