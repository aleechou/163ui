local mod	= DBM:NewMod("Ouro", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 502 $"):sub(12, -3))
mod:SetCreatureID(15517)
mod:SetModelID(15509)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_SUMMON",
	"UNIT_HEALTH target focus mouseover"
)

local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 3, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warnSweep			= mod:NewSpellAnnounce(26103, 2)
local warnBlast			= mod:NewSpellAnnounce(26102, 4)
local warnEnrage		= mod:NewSpellAnnounce(26615, 3)
local warnEnrageSoon	= mod:NewSoonAnnounce(26615, 2)

local specWarnBlast		= mod:NewSpecialWarningSpell(26102, nil, nil, nil, 2)

--local timerSubmerge		= mod:NewTimer(30, "TimerSubmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendBurrow.blp")
local timerEmerge		= mod:NewTimer(30, "TimerEmerge", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerSweepCD		= mod:NewNextTimer(20.5, 26103)
local timerBlast		= mod:NewCastTimer(2, 26102)
local timerBlastCD		= mod:NewNextTimer(23, 26102)

local prewarn_enrage = false
local enraged = false

function mod:OnCombatStart(delay)
	prewarn_enrage = false
	enraged = false
end

function mod:Submerge()
	warnEmerge:Show()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 26615 then
		enraged = true
		warnEnrage:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 26102 then
		warnBlast:Show()
		specWarnBlast:Show()
		timerBlast:Start()
		timerBlastCD:Start()
	elseif args.spellId == 26103 then
		warnSweep:Show()
		timerSweepCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 26058 and self:AntiSpam(3) and not enraged then
		timerBlastCD:Cancel()
		timerSweepCD:Cancel()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:ScheduleMethod(30, "Submerge")
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and self:GetUnitCreatureId(uId) == 15517 and not prewarn_enrage then
		prewarn_enrage = true
		warnEnrageSoon:Show()
	end
end
