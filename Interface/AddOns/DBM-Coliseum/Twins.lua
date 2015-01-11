local mod	= DBM:NewMod("ValkTwins", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 142 $"):sub(12, -3))
mod:SetCreatureID(34497, 34496)
mod:SetEncounterID(1089)
mod:SetModelID(29240)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_INTERRUPT"
)

mod:SetBossHealthInfo(
	34497, L.Fjola,
	34496, L.Eydis
)

local warnSpecial					= mod:NewAnnounce("WarnSpecialSpellSoon", 3)
local warnTouchDebuff				= mod:NewAnnounce("WarningTouchDebuff", 2, 66823)
local warnPoweroftheTwins			= mod:NewAnnounce("WarningPoweroftheTwins", 4)
local specWarnSpecial				= mod:NewSpecialWarning("SpecWarnSpecial")
local specWarnSwitch				= mod:NewSpecialWarning("SpecWarnSwitchTarget")
local specWarnKickNow 				= mod:NewSpecialWarning("SpecWarnKickNow")
local specWarnPoweroftheTwins		= mod:NewSpecialWarning("SpecWarnPoweroftheTwins")
local specWarnEmpoweredDarkness		= mod:NewSpecialWarningYou(65724)
local specWarnEmpoweredLight		= mod:NewSpecialWarningYou(65748)

local enrageTimer					= mod:NewBerserkTimer(360)
local timerSpecial					= mod:NewTimer(45, "TimerSpecialSpell", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")
local timerHeal						= mod:NewCastTimer(15, 65875)
local timerLightTouch				= mod:NewTargetTimer(20, 65950)
local timerDarkTouch				= mod:NewTargetTimer(20, 66001)
local timerAchieve					= mod:NewAchievementTimer(180, 3815, "TimerSpeedKill")

mod:AddBoolOption("SpecialWarnOnDebuff", false, "announce")
mod:AddBoolOption("SetIconOnDebuffTarget", false)
mod:AddBoolOption("HealthFrame", true)

local debuffTargets					= {}
local debuffIcon					= 8

local shieldHealth = {
	["heroic25"] = 1200000,
	["heroic10"] = 300000,
	["normal25"] = 700000,
	["normal10"] = 175000
}

function mod:OnCombatStart(delay)
	timerSpecial:Start(-delay)
	warnSpecial:Schedule(40-delay)
	timerAchieve:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		enrageTimer:Start(360-delay)
	else
		enrageTimer:Start(480-delay)
	end
	debuffIcon = 8
end

local lightEssence = GetSpellInfo(67223)
local darkEssence = GetSpellInfo(67176)

function mod:SPELL_CAST_START(args)
	if args.spellId == 66046 then
		local debuff = UnitDebuff("player", lightEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 66058 then
		local debuff = UnitDebuff("player", darkEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 65875 then
		timerHeal:Start()
		self:SpecialAbility(true)
		if self:GetUnitCreatureId("target") == 34497 then
			specWarnSwitch:Show()
		end
	elseif args.spellId == 65876 then
		timerHeal:Start()
		self:SpecialAbility(true)
		if self:GetUnitCreatureId("target") == 34496 then
			specWarnSwitch:Show()
		end
	end
end

function mod:SpecialAbility(debuff)
	if not debuff then
		specWarnSpecial:Show()
	end
	timerSpecial:Start()
	warnSpecial:Schedule(40)
end

function mod:resetDebuff()
	debuffIcon = 8
end

function mod:warnDebuff()
	warnTouchDebuff:Show(table.concat(debuffTargets, "<, >"))
	table.wipe(debuffTargets)
	self:UnscheduleMethod("resetDebuff")
	self:ScheduleMethod(5, "resetDebuff")
end

local function showPowerWarning(self, cid)
	local target = self:GetBossTarget(cid)
	warnPoweroftheTwins:Show(target)
	if target == UnitName("player") then
		specWarnPoweroftheTwins:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args.spellId == 65724 then
		specWarnEmpoweredDarkness:Show()
	elseif args:IsPlayer() and args.spellId == 65748 then
		specWarnEmpoweredLight:Show()
	elseif args.spellId == 65950 then
		if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
			specWarnSpecial:Show()
		end
		timerLightTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, debuffIcon, 15)
			debuffIcon = debuffIcon - 1
		end
		debuffTargets[#debuffTargets + 1] = args.destName
		self:UnscheduleMethod("warnDebuff")
		self:ScheduleMethod(0.9, "warnDebuff")
	elseif args.spellId == 66001 then
		if args:IsPlayer() and self.Options.SpecialWarnOnDebuff then
			specWarnSpecial:Show()
		end
		timerDarkTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, debuffIcon)
			debuffIcon = debuffIcon - 1
		end
		debuffTargets[#debuffTargets + 1] = args.destName
		self:UnscheduleMethod("warnDebuff")
		self:ScheduleMethod(0.75, "warnDebuff")
	elseif args:IsSpellID(65879, 65916) then
		self:Schedule(0.1, showPowerWarning, self, args:GetDestCreatureID())
	elseif args:IsSpellID(65874, 65858) and DBM.BossHealth:IsShown() then
		self:ShowShieldHealthBar(args.destGUID, args.spellName, shieldHealth[(DBM:GetCurrentInstanceDifficulty())])
		self:ScheduleMethod(15, "RemoveShieldHealthBar", args.destGUID)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 65874 then
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34496 then
			specWarnKickNow:Show()
		end
		self:UnscheduleMethod("RemoveShieldHealthBar", args.destGUID)
		self:RemoveShieldHealthBar(args.destGUID)
	elseif args.spellId == 65858 then
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34497 then
			specWarnKickNow:Show()
		end
		self:UnscheduleMethod("RemoveShieldHealthBar", args.destGUID)
		self:RemoveShieldHealthBar(args.destGUID)
	elseif args.spellId == 65950 then
		timerLightTouch:Stop(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 66001 then
		timerDarkTouch:Start(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and (args.extraSpellId == 65875 or args.extraSpellId == 65876) then
		timerHeal:Cancel()
	end
end
