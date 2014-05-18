local mod	= DBM:NewMod("Bronjahm", "DBM-Party-WotLK", 14)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3726 $"):sub(12, -3))
mod:SetCreatureID(36497)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"UNIT_HEALTH"
)

local warnSoulstormSoon		= mod:NewSoonAnnounce(68872, 2)
local warnCorruptSoul		= mod:NewTargetAnnounce(68839, 3)
local specwarnSoulstorm		= mod:NewSpecialWarning("specwarnSoulstorm")
local timerSoulstormCast	= mod:NewCastTimer(4, 68872)

local warned_preStorm = false

function mod:OnCombatStart(delay)
	warned_preStorm = false
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(68872) then							-- Soulstorm
		specwarnSoulstorm:Show()
		timerSoulstormCast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(68839) then							-- Corrupt Soul
		warnCorruptSoul:Show(args.destName)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preStorm and self:GetUnitCreatureId(uId) == 36497 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.40 then
		warned_preStorm = true
		warnSoulstormSoon:Show()	
	end
end