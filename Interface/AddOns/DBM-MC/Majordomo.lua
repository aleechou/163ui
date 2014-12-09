local mod	= DBM:NewMod("Majordomo", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()
local Yike	= mod:SoundMM("SoundWOP")

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

local specWarnMagicReflect		= mod:NewSpecialWarningReflect(20619, mod:IsSpellCaster())
local specWarnDamageShield		= mod:NewSpecialWarningReflect(21075, not mod:IsSpellCaster())

local timerMagicReflect	= mod:NewBuffActiveTimer(10, 20619)
local timerDamageShield	= mod:NewBuffActiveTimer(10, 21075)

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 20619 then
		warnMagicReflect:Show()
		specWarnMagicReflect:Show()
		timerMagicReflect:Start()
		if mod:IsSpellCaster() then
			Yike:Play("20619")
			Yike:Schedule(1, "stopattack")
			Yike:Schedule(10, "shieldover")
		end
	elseif spellId == 21075 then
		warnDamageShield:Show()
		specWarnDamageShield:Show()
		timerDamageShield:Start()
		if not mod:IsSpellCaster() then
			Yike:Play("20619")
			Yike:Schedule(1, "stopattack")
			Yike:Schedule(10, "shieldover")
		end
	elseif spellId == 20534 then
		warnTeleport:Show(args.destName)
	end
end
