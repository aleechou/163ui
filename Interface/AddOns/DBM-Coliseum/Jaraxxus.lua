local mod	= DBM:NewMod("Jaraxxus", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))
mod:SetCreatureID(34780)
mod:SetEncounterID(1087)
mod:SetModelID(29615)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

local warnFelFireball			= mod:NewCastAnnounce(66532, 2)
local warnPortalSoon			= mod:NewSoonAnnounce(66269, 3)
local warnVolcanoSoon			= mod:NewSoonAnnounce(66258, 3)
local warnFlame					= mod:NewTargetAnnounce(66197, 4)
local warnFlesh					= mod:NewTargetAnnounce(66237, 4, nil, mod:IsHealer())
local warnNetherPower			= mod:NewTargetAnnounce(67009, 4)

local specWarnFlame				= mod:NewSpecialWarningRun("OptionVersion2", 66877, nil, nil, nil, 4)
local specWarnFlesh				= mod:NewSpecialWarningYou(66237)
local specWarnKiss				= mod:NewSpecialWarningYou("OptionVersion2", 66334, mod:IsSpellCaster())
local specWarnNetherPower		= mod:NewSpecialWarningDispel(67009, mod:IsMagicDispeller())
local specWarnFelInferno		= mod:NewSpecialWarningMove(66496)
local SpecWarnFelFireball		= mod:NewSpecialWarningInterrupt(66532, false)
local SpecWarnFelFireballDispel	= mod:NewSpecialWarningDispel("OptionVersion2", 66532, false)

local timerCombatStart			= mod:NewCombatTimer(82)--rollplay for first pull
local enrageTimer				= mod:NewBerserkTimer(600)
local timerFlame 				= mod:NewTargetTimer(8, 66197)--There are 8 debuff Ids. Since we detect first to warn, use an 8sec timer to cover duration of trigger spell and damage debuff.
local timerFlameCD				= mod:NewCDTimer(30, 66197)
local timerNetherPowerCD		= mod:NewCDTimer(42, 67009)
local timerFlesh				= mod:NewTargetTimer(12, 66237)
local timerFleshCD				= mod:NewCDTimer(23, 66237) 
local timerPortalCD				= mod:NewCDTimer(120, 66269)
local timerVolcanoCD			= mod:NewCDTimer(120, 66258)

mod:AddSetIconOption("LegionFlameIcon", 66197)
mod:AddSetIconOption("IncinerateFleshIcon", 66237)
mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("IncinerateShieldFrame", true, "misc")

local absorbHealth = {
	["heroic25"] = 85000,
	["heroic10"] = 40000,
	["normal25"] = 60000,
	["normal10"] = 30000
}

function mod:OnCombatStart(delay)
	if self.Options.IncinerateShieldFrame and DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(34780, L.name)
	end
	timerPortalCD:Start(20-delay)
	warnPortalSoon:Schedule(15-delay)
	timerVolcanoCD:Start(80-delay)
	warnVolcanoSoon:Schedule(75-delay)
	timerFleshCD:Start(14-delay)
	timerFlameCD:Start(20-delay)
	enrageTimer:Start(-delay)
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 66877 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnFlame:Show()
	elseif spellId == 66496 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnFelInferno:Show()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 66237 then
		warnFlesh:Show(args.destName)
		timerFlesh:Start(args.destName)
		timerFleshCD:Start()
		if self.Options.IncinerateFleshIcon then
			self:SetIcon(args.destName, 8, 15)
		end
		if args:IsPlayer() then
			specWarnFlesh:Show()
		end
		if self.Options.IncinerateShieldFrame then
			self:ShowAbsorbedHealHealthBar(args.destGUID, L.IncinerateTarget:format(args.destName), absorbHealth[(DBM:GetCurrentInstanceDifficulty())])
			self:ScheduleMethod(15, "RemoveAbsorbedHealHealthBar", args.destGUID)
		end
	elseif args.spellId == 66197 then
		timerFlame:Start(args.destName)
		timerFlameCD:Start()
		if args:IsPlayer() then
			specWarnFlame:Show()
		end
		if self.Options.LegionFlameIcon then
			self:SetIcon(args.destName, 7, 8)
		end
	elseif args.spellId == 66334 and args:IsPlayer() then
		specWarnKiss:Show()
	elseif args.spellId == 66532 then
		SpecWarnFelFireballDispel:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 66237 then
		timerFlesh:Stop()
		if self.Options.IncinerateShieldFrame and DBM.BossHealth:IsShown() then
			self:UnscheduleMethod("RemoveAbsorbedHealHealthBar", args.destGUID)
			self:RemoveAbsorbedHealHealthBar(args.destGUID)
		end
		if self.Options.IncinerateFleshIcon then
			self:RemoveIcon(args.destName)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 66532 and self:GetUnitCreatureId("target") == 34780 then
		warnFelFireball:Show()
		SpecWarnFelFireball:Show(args.sourceName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 67009 then
		warnNetherPower:Show(args.sourceName)
		specWarnNetherPower:Show(args.sourceName)
		timerNetherPowerCD:Start()
	elseif args.spellId == 66258 then
		timerVolcanoCD:Start()
		warnVolcanoSoon:Schedule(110)
	elseif args.spellId == 66269 then
		timerPortalCD:Start()
		warnPortalSoon:Schedule(110)
	elseif args.spellId == 66197 then
		warnFlame:Show(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.FirstPull or msg:find(L.FirstPull) then
		timerCombatStart:Start()
	end
end
