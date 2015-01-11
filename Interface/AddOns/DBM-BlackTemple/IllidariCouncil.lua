local mod	= DBM:NewMod("Council", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 535 $"):sub(12, -3))
mod:SetCreatureID(22949, 22950, 22951, 22592, 23426)
mod:SetModelID(21416)
mod:SetUsedIcons(8)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_HEAL",
	"SPELL_INTERRUPT",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

mod:SetBossHealthInfo(
	22949, L.Gathios,
	22950, L.Zerevor,
	22951, L.Malande,
	22952, L.Veras
)

local warnPoison			= mod:NewTargetAnnounce(41485, 3)
local warnVanish			= mod:NewTargetAnnounce(41476, 3)
local warnVanishEnd			= mod:NewEndAnnounce(41476, 3)
local warnShield			= mod:NewTargetAnnounce(41475, 3)
local warnMeleeImmune		= mod:NewTargetAnnounce(41450, 4)
local warnSpellImmune		= mod:NewTargetAnnounce(41451, 4)
local warnCoHCast			= mod:NewSpellAnnounce(41455, 4)
local warnDevAura			= mod:NewSpellAnnounce(41452, 3)
local warnResAura			= mod:NewSpellAnnounce(41453, 3)

local specWarnFlame			= mod:NewSpecialWarningMove(41481)
local specWarnBlizzard		= mod:NewSpecialWarningMove(41482)
local specWarnConsecration	= mod:NewSpecialWarningMove(41541)
local specWarnCoH			= mod:NewSpecialWarningInterrupt(41455)
local specWarnImmune		= mod:NewSpecialWarning("Immune")

local timerVanish			= mod:NewBuffActiveTimer(31, 41476)
local timerShield			= mod:NewBuffActiveTimer(20, 41475)
local timerMeleeImmune		= mod:NewTargetTimer(15, 41450)
local timerSpellImmune		= mod:NewTargetTimer(15, 41451)
local timerDevAura			= mod:NewBuffActiveTimer(30, 41452)
local timerResAura			= mod:NewBuffActiveTimer(30, 41453)
local timerCoH				= mod:NewCastTimer(2.5, 41455)
local timerNextCoH			= mod:NewCDTimer(14, 41455)

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddBoolOption("HealthFrame", false)
mod:AddBoolOption("PoisonIcon", false)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41485 then
		warnPoison:Show(args.destName)
		if self.Options.PoisonIcon then
			self:SetIcon(args.destName, 8)
		end
	elseif args.spellId == 41481 and args:IsPlayer() and self:AntiSpam(4, 1) and not self:IsTrivial(85) then
		 specWarnFlame:Show()
	elseif args.spellId == 41482 and args:IsPlayer() and self:AntiSpam(4, 1) and not self:IsTrivial(85) then
		 specWarnBlizzard:Show()
	elseif args.spellId == 41541 and args:IsPlayer() and self:AntiSpam(4, 1) and not self:IsTrivial(85) then
		 specWarnConsecration:Show()
	elseif args.spellId == 41476 then
		warnVanish:Show(args.destName)
		timerVanish:Start(args.destName)
	elseif args.spellId == 41475 then
		warnShield:Show(args.destName)
		timerShield:Start(args.destName)
	elseif args.spellId == 41452 and self:GetCIDFromGUID(args.destGUID) == 22949 then
		warnDevAura:Show()
		timerDevAura:Start()
	elseif args.spellId == 41453 and self:GetCIDFromGUID(args.destGUID) == 22949 then
		warnResAura:Show()
		timerResAura:Start()
	elseif args.spellId == 41450 and self:GetCIDFromGUID(args.destGUID) == 22951 then
		warnMeleeImmune:Show(args.destName)
		timerMeleeImmune:Start(args.destName)
		specWarnImmune:Show(L.Melee)
	elseif args.spellId == 41451 and self:GetCIDFromGUID(args.destGUID) == 22951 then
		warnSpellImmune:Show(args.destName)
		timerSpellImmune:Start(args.destName)
		specWarnImmune:Show(L.Spell)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 41479 then
		warnVanishEnd:Show()
	elseif args.spellId == 41485 then
		if self.Options.PoisonIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 41455 then
		warnCoHCast:Show()
		timerCoH:Start()
		if self:GetUnitCreatureId("target") == 22951 or self:GetUnitCreatureId("focus") == 22951 then
			specWarnCoH:Show(args.sourceName)
		end
	end
end

function mod:SPELL_HEAL(_, _, _, _, _, _, _, _, spellId)
	if spellId == 41455 then
		timerNextCoH:Start(19)
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 41455 then
		timerCoH:Cancel()
		timerNextCoH:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 23426 and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end
