﻿local mod	= DBM:NewMod(856, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11360 $"):sub(12, -3))
mod:SetCreatureID(71859, 71858)--haromm, Kardris
mod:SetEncounterID(1606)
mod:SetZone()
mod:SetUsedIcons(5, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

--Dogs
local warnRend						= mod:NewStackAnnounce(144304, 2, nil, mod:IsTank())

--General
local warnPoisonmistTotem			= mod:NewSpellAnnounce(144288, 3)--85%
local warnFoulstreamTotem			= mod:NewSpellAnnounce(144289, 3)--65%
local warnAshflareTotem				= mod:NewSpellAnnounce(144290, 3)--45%
local warnRustedIronTotem			= mod:NewSpellAnnounce(144291, 3)--Heroic (95%)

--Earthbreaker Haromm
local warnFroststormStrike			= mod:NewStackAnnounce(144215, 2, nil, mod:IsTank())
local warnToxicMists				= mod:NewTargetAnnounce(144089, 3)
local warnFoulStream				= mod:NewTargetAnnounce(144090, 3)
local warnAshenWall					= mod:NewSpellAnnounce(144070, 4)
local warnIronTomb					= mod:NewSpellAnnounce(144328, 3)
--Wavebinder Kardris
local warnFrostStormBolt			= mod:NewSpellAnnounce(144214, 2, nil, mod:IsTank())
local warnToxicStorm				= mod:NewSpellAnnounce(144005, 3)
local warnFoulGeyser				= mod:NewTargetAnnounce(143990, 4)
local warnFallingAsh				= mod:NewCastAnnounce(143973, 3, 15)
local warnIronPrison				= mod:NewTargetAnnounce(144330, 3)

--Earthbreaker Haromm
local specWarnFroststormStrikeCast	= mod:NewSpecialWarningSpell(144215, false)--spammy, but useful for a tank if they want to time active mitigation around it.
local specWarnFroststormStrike		= mod:NewSpecialWarningStack(144215, mod:IsTank(), 6)
local specWarnFroststormStrikeOther	= mod:NewSpecialWarningTarget(144215, mod:IsTank())
local specWarnFoulStreamYou			= mod:NewSpecialWarningYou(144090)
local yellFoulStream				= mod:NewYell(144090)
local specWarnFoulStream			= mod:NewSpecialWarningSpell(144090, nil, nil, nil, 2)
local specWarnAshenWall				= mod:NewSpecialWarningSpell(144070, nil, nil, nil, 2)
local specWarnIronTomb				= mod:NewSpecialWarningSpell(144328, nil, nil, nil, 2)
--Wavebinder Kardris
local specWarnFrostStormBolt		= mod:NewSpecialWarningSpell(144214, false)--spammy, but useful for a tank if they want to time active mitigation around it.
local specWarnToxicStormFix			= mod:NewSpecialWarningSpell(144017) --BH FIX
local specWarnToxicStormNear		= mod:NewSpecialWarningClose(144005)
local yellToxicStorm				= mod:NewYell(144005)
local specWarnFoulGeyser			= mod:NewSpecialWarningSpell(143990)
local yellFoulGeyser				= mod:NewYell(143990)
local specWarnFallingAsh			= mod:NewSpecialWarningSpell(143973, nil, nil, nil, 2)--Seems like an everyone waring.
local specWarnIronPrison			= mod:NewSpecialWarningSoon(144330)--If this generic isn't too clear i'll localize it. this is warning that it's about to expire not that it's just been applied
local yellIronPrisonFades			= mod:NewYell(144330, L.PrisonYell, false)--Off by default since it's an atypical yell (it's not used for avoiding person it's used to get healer attention to person)

--Earthbreaker Haromm
local timerFroststormStrike			= mod:NewTargetTimer(30, 144215, nil, mod:IsTank())
local timerFroststormStrikeCD		= mod:NewCDTimer(6, 144215, nil, mod:IsTank())
local timerToxicMistsCD				= mod:NewCDTimer(32, 144089)--Pretty much a next timers unless boss is casting something else
local timerFoulStreamCD				= mod:NewCDTimer(32.5, 144090)--Pretty much a next timers unless boss is casting something else
local timerAshenWallCD				= mod:NewCDTimer(32.5, 144070)--Pretty much a next timers unless boss is casting something else
local timerIronTombCD				= mod:NewCDTimer(31.5, 144328)--Pretty much a next timers unless boss is casting something else
--Wavebinder Kardris
local timerFrostStormBoltCD			= mod:NewCDTimer(6.8, 144214, nil, mod:IsTank())
local timerToxicStormCD				= mod:NewCDTimer(32, 144005)--Pretty much a next timers unless boss is casting something else
local timerFoulGeyserCD				= mod:NewCDTimer(32.5, 143990)--Pretty much a next timers unless boss is casting something else
local timerFallingAshCD				= mod:NewCDTimer(32.5, 143973)--Pretty much a next timers unless boss is casting something else
local timerFallingAsh				= mod:NewBuffFadesTimer(15, 143973) --BH ADD
local timerIronPrisonCD				= mod:NewCDTimer(31.5, 144330)--Pretty much a next timers unless boss is casting something else
local timerIronPrison				= mod:NewBuffFadesTimer(60, 144330)

--local countdownFoulGeyser			= mod:NewCountdown(32.5, 143990)
--local countdownAshenWall			= mod:NewCountdown(32.5, 144070, nil, nil, nil, nil, true)

local berserkTimer					= mod:NewBerserkTimer(540)

mod:AddBoolOption("RangeFrame")--This is more or less for foul geyser and foul stream splash damage
mod:AddBoolOption("SetIconOnToxicMists", false)

mod:AddBoolOption("SoundEle", true, "sound")
mod:AddBoolOption("SoundEnh", true, "sound")

local toxicMistsTargets = {}
local toxicMistsTargetsIcons = {}
local ironPrisonTargets = {}
local UnitExists, UnitGUID, UnitDetailedThreatSituation = UnitExists, UnitGUID, UnitDetailedThreatSituation
local playerName = UnitName("player")

mod:AddBoolOption("dr", true, "sound")
for i = 1, 6 do
	mod:AddBoolOption("dr"..i, false, "sound")
end
local ashCount = 0
local function MyJS()
	if (mod.Options.dr1 and ashCount == 1) or (mod.Options.dr2 and ashCount == 2) or (mod.Options.dr3 and ashCount == 3) or (mod.Options.dr4 and ashCount == 4) or (mod.Options.dr5 and ashCount == 5) or (mod.Options.dr6 and ashCount == 6) then
		return true
	end
	return false
end

local function warnToxicMistTargets()
	warnToxicMists:Show(table.concat(toxicMistsTargets, "<, >"))
	timerToxicMistsCD:Start()
	table.wipe(toxicMistsTargets)
end

local function warnIronPrisonTargets()
	warnIronPrison:Show(table.concat(ironPrisonTargets, "<, >"))
	table.wipe(ironPrisonTargets)
end

local function ClearToxicMistTargets()
	table.wipe(toxicMistsTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetToxicIcons()
		table.sort(toxicMistsTargetsIcons, sort_by_group)
		local toxicIcon = 1
		for i, v in ipairs(toxicMistsTargetsIcons) do
			self:SetIcon(v, toxicIcon)
			toxicIcon = toxicIcon + 1
		end
		self:Schedule(1.5, ClearToxicMistTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:FoulStreamTarget(targetname, uId)
	if not targetname then return end
	if self:IsTanking(uId) then--Never target tanks, so if target is tank, that means scanning failed.
		specWarnFoulStream:Show()
		sndWOP:Play("ex_so_xxsl")
	else
		warnFoulStream:Show(targetname)
		timerFoulStreamCD:Start()
		if targetname == UnitName("player") then
			specWarnFoulStreamYou:Show()
			yellFoulStream:Yell()
			sndWOP:Play("ex_so_xxsl")
		else
			specWarnFoulStream:Show()
			sndWOP:Play("ex_so_xxsl") --小心水流
		end
	end
end

function mod:ToxicStormTarget(targetname, uId)
	if not targetname then return end
	warnToxicStorm:Show(targetname)
	if (targetname == UnitName("player")) and (not mod:IsTank()) then
--		specWarnToxicStormFix:Show()
		yellToxicStorm:Yell()
	else
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 8 then--Range guesswork
				specWarnToxicStormNear:Show(targetname)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	table.wipe(toxicMistsTargets)
	ashCount = 0
	if self:IsLFR() then
		berserkTimer:Start(600-delay)
	else
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144005 and mod.Options.SoundEle then
		self:BossTargetScanner(71858, "ToxicStormTarget", 0.5, 5)
		timerToxicStormCD:Start()
		specWarnToxicStormFix:Show()
		sndWOP:Play("wwsoon") --準備旋風
	elseif args.spellId == 144090 and mod.Options.SoundEnh then
		self:BossTargetScanner(71859, "FoulStreamTarget", 0.05, 16)
	elseif args.spellId == 143990 and mod.Options.SoundEle then
		timerFoulGeyserCD:Start()
		specWarnFoulGeyser:Show()
--		countdownFoulGeyser:Start()
	elseif args.spellId == 144070 and mod.Options.SoundEnh then
		warnAshenWall:Show()
		timerAshenWallCD:Start()
		specWarnAshenWall:Show()--Give special warning cause this ability concerns you
		sndWOP:Play("ex_so_yszq") --元素之牆
	elseif args.spellId == 143973 then
		ashCount = ashCount + 1
		warnFallingAsh:Show()
		timerFallingAshCD:Start()
		timerFallingAsh:Start()
		specWarnFallingAsh:Show()--Give special warning cause this ability concerns you
		sndWOP:Schedule(10, "ex_so_wmys") -- 5s後隕石爆炸
		if MyJS() then
			sndWOP:Schedule(12, "defensive") --注意減傷
		else
			sndWOP:Schedule(12, "countfour")
		end
		sndWOP:Schedule(13, "countthree")
		sndWOP:Schedule(14, "counttwo")
		sndWOP:Schedule(15, "countone")
		if ashCount == 6 then ashCount = 0 end
	elseif args.spellId == 144330 and mod.Options.SoundEle then
		warnIronPrison:Show()
		timerIronPrisonCD:Start()
	elseif args.spellId == 144328 and mod.Options.SoundEnh then
		warnIronTomb:Show()
		timerIronTombCD:Start()
		specWarnIronTomb:Show()
		sndWOP:Play("watchstep") --注意腳下
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 144288 and self:AntiSpam() then
		warnPoisonmistTotem:Show()
		sndWOP:Play("ex_so_dwtt") --毒霧圖騰
	elseif args.spellId == 144289 and self:AntiSpam() then
		warnFoulstreamTotem:Show()
		sndWOP:Play("ex_so_wltt") --污流圖騰
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(4)
		end
	elseif args.spellId == 144290 and self:AntiSpam() then
		warnAshflareTotem:Show()
		sndWOP:Play("ex_so_hhtt") --灰火圖騰
	elseif args.spellId == 144291 and self:AntiSpam() then
		warnRustedIronTotem:Show()
		sndWOP:Play("ex_so_xttt") --鏽鐵圖騰
	elseif args.spellId == 143990 and mod.Options.SoundEle then
		warnFoulGeyser:Show(args.destName)
		if args:IsPlayer() then
			yellFoulGeyser:Yell()
			sndWOP:Play("ex_so_rnkd") --软泥快打
			sndWOP:Schedule(28, "ex_so_zbrn") --準備軟泥
		else
			if not mod:IsMeleeDps() then
				specWarnFoulGeyser:Show()
				sndWOP:Play("ex_so_rnkd")
				sndWOP:Schedule(28, "ex_so_zbrn")
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144304 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnRend:Show(args.destName, amount)
		end
	elseif args.spellId == 144089 then
		toxicMistsTargets[#toxicMistsTargets + 1] = args.destName
		self:Unschedule(warnToxicMistTargets)
		self:Schedule(0.5, warnToxicMistTargets)
		if self.Options.SetIconOnToxicMists and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(toxicMistsTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetToxicIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetToxicIcons")
			end
		end
	elseif args.spellId == 144330 then
		ironPrisonTargets[#ironPrisonTargets + 1] = args.destName
		self:Unschedule(warnIronPrisonTargets)
		self:Schedule(0.5, warnIronPrisonTargets)
		if args:IsPlayer() then
			specWarnIronPrison:Schedule(55)
			timerIronPrison:Start()
			yellIronPrisonFades:Schedule(59, playerName, 1)
			yellIronPrisonFades:Schedule(58, playerName, 2)
			yellIronPrisonFades:Schedule(57, playerName, 3)
			yellIronPrisonFades:Schedule(56, playerName, 4)
			yellIronPrisonFades:Schedule(55, playerName, 5)
			sndWOP:Schedule(55, "holdit") --快開自保
		end
		if self:AntiSpam(5, 1) then
			sndWOP:Schedule(50, "ex_so_tentl") --10秒後鐵牢
		end
	elseif args.spellId == 144215 and mod.Options.SoundEnh then
		local amount = args.amount or 1
		timerFroststormStrike:Start(args.destName)
		if amount % 2 == 0 then
			warnFroststormStrike:Show(args.destName, amount)
		end
		if amount >= 6 then
			if args:IsPlayer() then
				specWarnFroststormStrike:Show(amount)
			else
				specWarnFroststormStrikeOther:Show(args.destName)
				if mod:IsTank() then
					sndWOP:Play("changemt") --換坦嘲諷
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144089 and self.Options.SetIconOnToxicMists then
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 144215 then
		timerFroststormStrike:Cancel(args.destName)
	elseif args.spellId == 144330 and args:IsPlayer() then
		specWarnIronPrison:Cancel()
		yellIronPrisonFades:Cancel()
		timerIronPrison:Cancel()
		sndWOP:Cancel("holdit")
	end
end
