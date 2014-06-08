local mod	= DBM:NewMod(155, "DBM-ThroneFourWinds", nil, 75)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(46753)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Classes that can drop stacks of acid rain, but only if they can time AMS/bubble right, they use it wrong and they do no good.
local isDKorPaly	= select(2, UnitClass("player")) == "DEATHKNIGHT"
					or select(2, UnitClass("player")) == "PALADIN"

local warnIceStorm			= mod:NewSpellAnnounce(88239, 3)
local warnSquallLine		= mod:NewSpellAnnounce(91129, 4)
local warnWindBurst			= mod:NewSpellAnnounce(87770, 3)
local warnAdd				= mod:NewSpellAnnounce(88272, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnAcidRain			= mod:NewCountAnnounce(88301, 2, nil, false)
local warnFeedback			= mod:NewStackAnnounce(87904, 2)
local warnPhase3			= mod:NewPhaseAnnounce(3)
--local warnCloud				= mod:NewSpellAnnounce(89588, 3)
local warnLightningRod		= mod:NewTargetAnnounce(89668, 4)
local warnMovingPosition   = mod:NewAnnounce("warnMovingPosition", 3, 89588)

local specWarnWindBurst		= mod:NewSpecialWarningSpell(87770, nil, nil, nil, true)
local specWarnIceStorm		= mod:NewSpecialWarningMove(91020)
local specWarnCloud			= mod:NewSpecialWarningMove(89588)
local specWarnLightningRod	= mod:NewSpecialWarningYou(89668)
local yellLightningRod		= mod:NewYell(89668)

local timerWindBurst		= mod:NewCastTimer(5, 87770)
local timerWindBurstCD		= mod:NewCDTimer(25, 87770)		-- 25-30 Variation
local timerAddCD			= mod:NewCDTimer(20, 88272)
local timerFeedback			= mod:NewTimer(20, "TimerFeedback", 87904)
local timerAcidRainStack	= mod:NewNextTimer(15, 88301, nil, isDKorPaly)
local timerLightningRod		= mod:NewTargetTimer(5, 89668)
local timerLightningRodCD	= mod:NewNextTimer(15, 89668)
local timerLightningCloudCD	= mod:NewNextTimer(15, 89588)
local timerIceStormCD		= mod:NewCDTimer(25, 88239)
local timerSquallLineCD		= mod:NewCDTimer(20, 91129)

local berserkTimer			= mod:NewBerserkTimer(600)

local countdownClouds		= mod:NewCountdown(10, 89588, false)

mod:AddBoolOption("LightningRodIcon")
mod:AddBoolOption("RangeFrame", true)

local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

local phase3Started = false
local phase2Started = false
local strikeStarted = false
local cloudcount = 0
local squallName = GetSpellInfo(91129)
local iceName = GetSpellInfo(88239)
local stormlingName = GetSpellInfo(88272)
local acidName = GetSpellInfo(88290)
local cloudsName = GetSpellInfo(89639)

function mod:CloudRepeat()
	self:UnscheduleMethod("CloudRepeat")
--	warnCloud:Show()
	cloudcount = cloudcount + 1
	if self:IsInCombat() then--Don't schedule if not in combat, prevent an infinite loop from happening if for some reason one got scheduled exactly on boss death.
		if mod:IsDifficulty("heroic10", "heroic25") then
			if cloudcount == 7 then
				cloudcount = 1
			end
			if cloudcount == 2 then
				warnMovingPosition:Show(L.Cloudtwo)
			elseif cloudcount == 3 then
				warnMovingPosition:Show(L.Cloudthree)
			elseif cloudcount == 4 then
				warnMovingPosition:Show(L.Cloudsix)
			elseif cloudcount == 5 then
				warnMovingPosition:Show(L.Cloudfive)
			elseif cloudcount == 6 then
				warnMovingPosition:Show(L.Cloudfour)
			elseif cloudcount == 1 then
				warnMovingPosition:Show(L.Cloudone)
			end
			timerLightningCloudCD:Start(10)
			countdownClouds:Start(10)
			sndWOP:Schedule(10, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\awaycloud.mp3")
			self:ScheduleMethod(10, "CloudRepeat")
		else
			if cloudcount == 5 then
				cloudcount = 1
			end
			if cloudcount == 2 then
				warnMovingPosition:Show(L.Cloudthree)
			elseif cloudcount == 3 then
				warnMovingPosition:Show(L.Cloudsix)
			elseif cloudcount == 4 then
				warnMovingPosition:Show(L.Cloudfour)
			elseif cloudcount == 1 then
				warnMovingPosition:Show(L.Cloudone)
			end
			timerLightningCloudCD:Start()
			countdownClouds:Start(15)
			sndWOP:Schedule(15, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\awaycloud.mp3")
			self:ScheduleMethod(15, "CloudRepeat")
		end
	end
end

function mod:OnCombatStart(delay)
	phase2Started = false
	phase3Started = false
	strikeStarted = false
	cloudcount = 0
	berserkTimer:Start(-delay)
	timerWindBurstCD:Start(20-delay)
	timerIceStormCD:Start(6-delay)
--Only needed in phase 1
	self:RegisterShortTermEvents(
		"SPELL_PERIODIC_DAMAGE",
		"SPELL_PERIODIC_MISSED"
	)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(87904, 101458, 101459, 101460) and not phase3Started then
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\backsoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		warnFeedback:Show(args.destName, args.amount or 1)
		timerFeedback:Cancel()--prevent multiple timers spawning with diff args.
		if self:IsDifficulty("normal10", "normal25") then
			timerFeedback:Start(30, args.amount or 1)
			sndWOP:Schedule(22, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\backsoon.mp3")
			sndWOP:Schedule(25, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(26, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
			sndWOP:Schedule(27, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(28, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(29, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		else
			timerFeedback:Start(20, args.amount or 1)
			sndWOP:Schedule(12, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\backsoon.mp3")
			sndWOP:Schedule(15, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(16, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
			sndWOP:Schedule(17, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(18, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(19, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	elseif args:IsSpellID(88301, 93279, 93280, 93281) then--Acid Rain (phase 2 debuff)
		if args.amount and args.amount > 1 and args:IsPlayer() then
			warnAcidRain:Show(args.amount)
		end
	elseif args:IsSpellID(89668) then
		warnLightningRod:Show(args.destName)
		timerLightningRod:Show(args.destName)
		timerLightningRodCD:Start()
		if args:IsPlayer() then
			specWarnLightningRod:Show()
			yellLightningRod:Yell()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\shockrun.mp3")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(20)
			end
		end
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, 8)
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(89668) then
		timerLightningRod:Cancel(args.destName)
		if self.Options.LightningRodIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(87770, 93261, 93262, 93263) then--Phase 1 wind burst
		warnWindBurst:Show()
		specWarnWindBurst:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\windblast.mp3")
		timerWindBurstCD:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerWindBurst:Start(4)--4 second cast on heroic according to wowhead.
			sndWOP:Schedule(1.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		else
			timerWindBurst:Start()
			sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(4.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 88858 or spellId == 93286 or spellId == 93287 or spellId == 93288) and self:AntiSpam(5, 1) then--Phase 3 wind burst, does not use cast success :(
		warnWindBurst:Show()
		timerWindBurstCD:Start(20)
		sndWOP:Schedule(16, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\windblast.mp3")
	elseif (spellId == 89588 or spellId == 93299 or spellId == 93298 or spellId == 93297) and self:AntiSpam(3, 2) and destGUID == UnitGUID("player") then
		specWarnCloud:Show()
	end
end

mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 91020 or spellId == 93258 or spellId == 93259 or spellId == 93260) and self:AntiSpam(4, 1) and destGUID == UnitGUID("player") then
		specWarnIceStorm:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
--	"<42.5> [CAST_SUCCEEDED] Al'Akir:Possible Target<Erej>:boss1:Squall Line::0:91129", -- [870]
	if spellName == squallName and self:AntiSpam(2, 3) then -- Squall Line (Tornados)
		warnSquallLine:Show()
		if not phase2Started then
			timerSquallLineCD:Start(30)--Seems like a longer CD in phase 1? That or had some electrocute and windburst delays, need more data.
		else
			timerSquallLineCD:Start()
		end
--	"<37.6> [CAST_SUCCEEDED] Al'Akir:Possible Target<Erej>:boss1:Ice Storm::0:88239", -- [462]
	elseif spellName == iceName and self:AntiSpam(2, 4) then -- Ice Storm (Phase 1)
		warnIceStorm:Show()
		timerIceStormCD:Start()
--	"<94.2> [CAST_SUCCEEDED] Al'Akir:Possible Target<Erej>:boss1:Stormling::0:88272", -- [5155]
	elseif spellName == stormlingName and self:AntiSpam(2, 4) then -- Summon Stormling (Phase 2 add)
		warnAdd:Show()
		timerAddCD:Start()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\squall.mp3")
--	"<83.2> [CAST_SUCCEEDED] Al'Akir:Possible Target<Erej>:boss1:Acid Rain::0:101452", -- [4307]
	elseif spellName == acidName and self:AntiSpam(2, 5) then -- Acid Rain
		if self:IsDifficulty("normal10", "normal25") then
			timerAcidRainStack:Start(20)
		else
			timerAcidRainStack:Start()
		end
		if not phase2Started then
			phase2Started = true
			warnPhase2:Show()
			timerWindBurstCD:Cancel()
			timerIceStormCD:Cancel()
		end
--	"<229.0> [CAST_SUCCEEDED] Al'Akir:Possible Target<Erej>:boss1:Relentless Storm Initial Vehicle Ride Trigger::0:89528", -- [18459]
	elseif spellId == 89528 and self:AntiSpam(2, 6) then -- Relentless Storm Initial Vehicle Ride Trigger (phase 3 start trigger)
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\backsoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		warnPhase3:Show()
		cloudcount = cloudcount + 1
		warnMovingPosition:Show(L.Cloudone)
		phase3Started = true
		timerLightningCloudCD:Start(15.5)
		timerWindBurstCD:Start(25)
		sndWOP:Schedule(21, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\windblastsoon.mp3")
		timerLightningRodCD:Start(20)
		timerAddCD:Cancel()
		timerAcidRainStack:Cancel()
		self:UnregisterShortTermEvents()
--	"<244.5> [CAST_SUCCEEDED] Al'Akir:Possible Target<nil>:boss1:Lightning Clouds::0:93304", -- [19368]
	elseif spellName == cloudsName and self:AntiSpam(2, 3) then -- Phase 3 Lightning cloud trigger (only cast once)
		self:CloudRepeat()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\awaycloud.mp3")
		--Only needed in phase 2
		self:RegisterShortTermEvents(
			"SPELL_DAMAGE",
			"SPELL_MISSED"
		)
	end
end