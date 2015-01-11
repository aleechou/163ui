local mod	= DBM:NewMod("Mobus", "DBM-Party-Cataclysm", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 121 $"):sub(12, -3))
mod:SetCreatureID(50009)
mod:SetModelID(37338)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)
mod.onlyNormal = true

local warnAlgae				= mod:NewTargetAnnounce(93491, 2)
local warnRam				= mod:NewCastAnnounce(93492, 3)
local warnWake				= mod:NewCastAnnounce(93494, 2)

local specWarnRam			= mod:NewSpecialWarningMove(93492, mod:IsTank())
local specWarnWake			= mod:NewSpecialWarningMove(93494, mod:IsMelee())
local specWarnAlgae			= mod:NewSpecialWarningMove(93490)

local timerAlgaeCD			= mod:NewNextTimer(12, 93490)
local timerRamCD			= mod:NewNextTimer(16, 93492)--16-17 seconds after wake seems more accurate then wild upwards of 20 second variations of starting timer after previous ram
local timerWakeCD			= mod:NewCDTimer(47, 93494)--47-60 second variations. also typcally 30-33sec after a ram AFTER first one.

function mod:AlgaeTarget()
	local targetname = self:GetBossTarget(50009)
	if not targetname then return end
	warnAlgae:Show(targetname)
end

function mod:OnCombatStart(delay)
	timerAlgaeCD:Start(10-delay)
	timerRamCD:Start(10-delay)--Not a large pool of logs to compare to.
	timerWakeCD:Start(30-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 93492 and self:IsInCombat() then
		warnRam:Show()
		specWarnRam:Show()
	elseif args.spellId == 93494 and self:IsInCombat() then
		warnWake:Show()
		specWarnWake:Show()
		timerWakeCD:Start()
		timerRamCD:Start()
	elseif args.spellId == 93491 and self:IsInCombat() then
		timerAlgaeCD:Start()
		self:ScheduleMethod(0.2, "AlgaeTarget")
	end
end

function mod:SPELL_AURA_APPLIED(args)--Assumed spell event, might need to use spell damage, or spell periodic damage instead.
	if args.spellId == 93490 and args:IsPlayer() then
		specWarnAlgae:Show()
	end
end
