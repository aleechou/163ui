local mod	= DBM:NewMod(156, "DBM-BastionTwilight", nil, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 99 $"):sub(12, -3))
mod:SetCreatureID(44600)
mod:SetEncounterID(1030)
mod:DisableEEKillDetection()
mod:SetZone()
mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent02.wav", "Sound\\Creature\\Halfus\\VO_BT_Halfus_Event07.wav")
--Long: Halfus! Hear me! The master calls, the master wants! Protect our secrets, Halfus! Destroy the intruders! Murder for his glory, murder for his hunger!
--Short: Dragons to my side!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warnBreath			= mod:NewSpellAnnounce(83707, 3)
local warnFuriousRoar		= mod:NewSpellAnnounce(83710, 3)
local warnVengeance			= mod:NewSpellAnnounce(87683, 3)
local warnShadowNova		= mod:NewSpellAnnounce(83703, 4)
local warnParalysis			= mod:NewSpellAnnounce(84030, 2)
local warnMalevolentStrike	= mod:NewStackAnnounce(83908, 2, nil, mod:IsTank() or mod:IsHealer())

local specWarnShadowNova	= mod:NewSpecialWarningInterrupt(83703, false)
local specWarnMalevolent	= mod:NewSpecialWarningStack(83908, nil, 8)

local timerFuriousRoar		= mod:NewCDTimer(30, 83710)
local timerBreathCD			= mod:NewCDTimer(20, 83707)--every 20-25 seconds.
local timerParalysis		= mod:NewBuffActiveTimer(12, 84030)
local timerParalysisCD		= mod:NewCDTimer(35, 84030)
local timerNovaCD			= mod:NewCDTimer(7.2, 83703)--7.2 is actually exact next timer, but since there are other variables like roars, or paralysis that could mis time it, we use CD bar instead so we don't give false idea of precision.
local timerMalevolentStrike	= mod:NewTargetTimer(30, 83908, nil, mod:IsTank() or mod:IsHealer())

local berserkTimer			= mod:NewBerserkTimer(360)

mod:AddBoolOption("ShowDrakeHealth", true)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	if mod:IsDifficulty("heroic10", "heroic25") then--On heroic we know for sure the drake has breath ability.
		timerBreathCD:Start(10-delay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 87683 then
		warnVengeance:Show()
	elseif args.spellId == 84030 then
		warnParalysis:Show()
		timerParalysis:Start()
		timerParalysisCD:Start()
	elseif args:IsSpellID(83601, 83603, 83611) and self.Options.ShowDrakeHealth and DBM.BossHealth:IsShown() then
		DBM.BossHealth:AddBoss(self:GetCIDFromGUID(args.sourceGUID), args.sourceName)
	elseif args.spellId == 83908 then
		timerMalevolentStrike:Start(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 87683 then
		warnVengeance:Show()
	elseif args.spellId == 83908 then
		local amount = args.amount or 1
		timerMalevolentStrike:Start(args.destName)
		if amount % 4 == 0 or amount >= 10 then		-- warn every 4th stack and every stack if 10 or more
			warnMalevolentStrike:Show(args.destName, amount)
		end
		if args:IsPlayer() and amount >= 8 then
			specWarnMalevolent:Show(amount)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 83710 and self:AntiSpam(6) then
		warnFuriousRoar:Show()
		timerFuriousRoar:Cancel()--We Cancel any scheduled roar timers before doing anything else.
		timerFuriousRoar:Start()--And start a fresh one.
		timerFuriousRoar:Schedule(30)--If it comes off CD while he's stunned by paralysis, he no longer waits to casts it after stun, it now consumes his CD as if it was cast on time. This is why we schedule this timer. So we get a timer for next roar after a stun.
	elseif args.spellId == 83707 then
		warnBreath:Show()
		timerBreathCD:Start()
	elseif args.spellId == 83703 then
		warnShadowNova:Show()
		specWarnShadowNova:Show(args.sourceName)
		timerNovaCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 83612 and self.Options.ShowDrakeHealth and DBM.BossHealth:IsShown() then
		DBM.BossHealth:AddBoss(self:GetCIDFromGUID(args.sourceGUID), args.sourceName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if self.Options.ShowDrakeHealth and (cid == 44652 or cid == 44645 or cid == 44797 or cid == 44650) and DBM.BossHealth:IsShown() then
		DBM.BossHealth:RemoveBoss(cid)
	end
end
