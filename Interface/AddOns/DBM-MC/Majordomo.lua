local mod	= DBM:NewMod("Majordomo", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 549 $"):sub(12, -3))
mod:SetCreatureID(12018, 11663, 11664)
--mod:SetEncounterID(671)
mod:SetModelID(12029)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 20619 21075 20534"
)

local warnMagicReflect	= mod:NewSpellAnnounce(20619)
local warnDamageShield	= mod:NewSpellAnnounce(21075)
local warnTeleport		= mod:NewTargetAnnounce(20534)

local specWarnMagicReflect		= mod:NewSpecialWarningSpell(20619, not mod:IsMelee())

local timerMagicReflect	= mod:NewBuffActiveTimer(10, 20619)
local timerDamageShield	= mod:NewBuffActiveTimer(10, 21075)

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 20619 then
		warnMagicReflect:Show()
		specWarnMagicReflect:Show()
		timerMagicReflect:Start()
	elseif spellId == 21075 then
		warnDamageShield:Show()
		timerDamageShield:Start()
	elseif spellId == 20534 then
		warnTeleport:Show(args.destName)
	end
end