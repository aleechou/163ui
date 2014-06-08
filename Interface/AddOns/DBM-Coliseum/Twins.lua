local mod	= DBM:NewMod("ValkTwins", "DBM-Coliseum")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 73 $"):sub(12, -3))
mod:SetCreatureID(34497, 34496)
mod:SetModelID(29240)
mod:SetMinCombatTime(30)
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEvents(
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
mod:AddBoolOption("SetIconOnDebuffTarget", true)
mod:AddBoolOption("HealthFrame", true)


local debuffTargets					= {}
local debuffIcon					= 8

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
	if args.spellId == 66046 then 			-- Light Vortex
		local debuff = UnitDebuff("player", lightEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 66058 then		-- Dark Vortex
		local debuff = UnitDebuff("player", darkEssence)
		self:SpecialAbility(debuff)
	elseif args.spellId == 65875 then 		-- Twin's Pact
		timerHeal:Start()
		self:SpecialAbility(true)
		if self:GetUnitCreatureId("target") == 34497 then	-- if lightbane, then switch to darkbane
			specWarnSwitch:Show()	
		end
	elseif args.spellId == 65876 then		-- Light Pact
		timerHeal:Start()
		self:SpecialAbility(true)
		if self:GetUnitCreatureId("target") == 34496 then	-- if darkbane, then switch to lightbane
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

local showShieldHealthBar, hideShieldHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local shieldedMob
	local absorbRemaining = 0
	local maxAbsorb = 0
	local function getShieldHP()
		return math.max(1, math.floor(absorbRemaining / maxAbsorb * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
		if shieldedMob == destGUID then
			local absorbed
			if subEvent == "SWING_MISSED" then 
				absorbed = select( 3, ... ) 
			elseif subEvent == "RANGE_MISSED" or subEvent == "SPELL_MISSED" or subEvent == "SPELL_PERIODIC_MISSED" then 
				absorbed = select( 6, ... )
			end
			if absorbed then
				absorbRemaining = absorbRemaining - absorbed
			end
		end
	end)
	
	function showShieldHealthBar(self, mob, shieldName)
		shieldedMob = mob
		maxAbsorb = mod:IsDifficulty("heroic25") and 1200000 or
					mod:IsDifficulty("heroic10") and 300000 or
					mod:IsDifficulty("normal25") and 700000 or
					mod:IsDifficulty("normal10") and 175000 or 0
		absorbRemaining = maxAbsorb
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, shieldName)
		self:Schedule(15, hideShieldHealthBar)
	end
	
	function hideShieldHealthBar()
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsPlayer() and args.spellId == 65724 then 		-- Empowered Darkness
		specWarnEmpoweredDarkness:Show()
	elseif args:IsPlayer() and args.spellId == 65748 then	-- Empowered Light
		specWarnEmpoweredLight:Show()
	elseif args.spellId == 65950 then	-- Touch of Light
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
	elseif args.spellId == 66001 then	-- Touch of Darkness
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
	elseif args:IsSpellID(65879, 65916) then -- Power of the Twins 
		self:Schedule(0.1, showPowerWarning, self, args:GetDestCreatureID())
	elseif args:IsSpellID(65874, 65858) and DBM.BossHealth:IsShown() then -- Shield of Darkness/Lights
		showShieldHealthBar(self, args.destGUID, args.spellName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 65874 then			-- Shield of Darkness
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34496 then
			specWarnKickNow:Show()
		end
		self:Unschedule(hideShieldHealthBar)
		if DBM.BossHealth:IsShown() then
			hideShieldHealthBar()
		end
	elseif args.spellId == 65858 then		-- Shield of Lights
		if UnitCastingInfo("target") and self:GetUnitCreatureId("target") == 34497 then
			specWarnKickNow:Show()
		end
		self:Unschedule(hideShieldHealthBar)
		if DBM.BossHealth:IsShown() then
			hideShieldHealthBar()
		end
	elseif args.spellId == 65950 then	-- Touch of Light
		timerLightTouch:Stop(args.destName)
		if self.Options.SetIconOnDebuffTarget then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 66001 then	-- Touch of Darkness
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