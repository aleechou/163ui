local mod	= DBM:NewMod(168, "DBM-BastionTwilight", nil, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7749 $"):sub(12, -3))
mod:SetCreatureID(45213)
mod:SetModelID(34335)
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)
mod:SetModelSound("Sound\\Creature\\Sinestra\\VO_BT_Sinestra_Aggro01.wav", "Sound\\Creature\\Sinestra\\VO_BT_Sinestra_Kill02.wav")
--Long: We were fools to entrust an imbecile like Cho'gall with such a sacred duty! I will deal with you intruders myself!
--Short: Powerless....

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED"
)

local isPal = select(2, UnitClass("player")) == "PALADIN"

local warnBreath		= mod:NewAnnounce("WarnFlameBreath", 3, 90125)
local warnOrbSoon		= mod:NewAnnounce("WarnOrbSoon", 3, 92954, true, nil, true)--Still on by default but no longer plays it's own sounds
local warnOrbs			= mod:NewAnnounce("warnAggro", 4, 92954)
local warnWrack			= mod:NewTargetAnnounce(89421, 4)
local warnWrackJump		= mod:NewAnnounce("warnWrackJump", 3, 89421, false)--Not spammy at all (unless you're dispellers are retarded and make it spammy). Useful for a raid leader to coordinate quicker, especially on 10 man with low wiggle room.
local warnDragon			= mod:NewSpellAnnounce("ej3231", 3, 69002)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnExtinction	= mod:NewSpellAnnounce(86227, 4)
local warnPhase3		= mod:NewPhaseAnnounce(3, 2)
local warnRedEssence	= mod:NewSpellAnnounce(87946, 3)
local warnFieryBarrier	= mod:NewSpellAnnounce(87231, 3)

local specWarnOrbs		= mod:NewSpecialWarning("SpecWarnOrbs", nil, nil, nil, true)
local specWarnOrbOnYou	= mod:NewSpecialWarning("SpecWarnAggroOnYou")
local specWarnDispel	= mod:NewSpecialWarning("SpecWarnDispel", mod:IsHealer()) -- this can be personal stuff, but Warck dispel also important In sinestra. adjust appropriately. (Maybe add support for common 10 man variation with if/else rules?)
local specWarnBreath	= mod:NewSpecialWarningSpell(90125, false, nil, nil, true)
local specWarnEggShield		= mod:NewSpecialWarningSpell(87654, mod:IsRanged())
local specWarnEggWeaken		= mod:NewSpecialWarningSwitch("ej3238", mod:IsRanged())
local specWarnIndomitable	= mod:NewSpecialWarningDispel(90045, mod:CanRemoveEnrage())
local specWarnSacrifice	= mod:NewSpecialWarningSpell(6940)
local yellSlicer						= mod:NewYell(92852)
local specWarnControl	= mod:NewSpecialWarningSpell(31821)

local timerBreathCD		= mod:NewTimer(21, "TimerFlameBreath", 90125)
local timerOrbs			= mod:NewTimer(28, "TimerOrbs", 92954)
local timerWrack			= mod:NewNextTimer(61, 89421)
local timerExtinction	= mod:NewCastTimer(16, 86227)
local timerFieryBarrier	= mod:NewBuffActiveTimer(17, 87231)
local timerEggWeakening	= mod:NewTimer(4, "TimerEggWeakening", 61357)
local timerEggWeaken	= mod:NewTimer(30, "TimerEggWeaken", 61357)
local timerDragon			= mod:NewNextTimer(50, "ej3231", nil, nil,nil, 69002)
local timerRedEssenceCD	= mod:NewNextTimer(22, 87946)--21-23 seconds after red egg dies
local timerRedEssence	= mod:NewBuffFadesTimer(180, 87946)

local countdownOrbs		= mod:NewCountdown(28, 92954, false, "OrbsCountdown")

local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndDIS	= mod:NewSound(nil, "SoundDIS", mod:IsHealer())

mod:AddBoolOption("HealthFrame", false)
mod:AddBoolOption("SetIconOnOrbs", true)
mod:AddBoolOption("SoundPAL1", false)
mod:AddBoolOption("SoundPAL2", false)
mod:AddBoolOption("SoundMAura", false)
mod:AddBoolOption("InfoFrame", false)--Does not filter tanks. not putting ugly hack in info frame, its simpley an aggro tracker

local eggDown = 0
local lastDispeled = 0
local newWrackTime = 0
local oldWrackTime = 0
local newWrackCount = 0
local oldWrackCount = 0
local orbdamageSpam = 0
local eggRemoved = false
local wrackWarned2 = false
local wrackWarned4 = false
local wrackWarned8 = false
local calenGUID = 0
local orbList = {}
local orbWarned = nil
local playerWarned = nil
local wrackName = GetSpellInfo(89421)
local wrackTargets = {}
local fieryWarned = false
local breathcount = 1
local wrackloop = 0

local function resetPlayerOrbStatus()
	orbWarned = nil
	playerWarned = nil
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. anyone with Sinestra Aggro
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitIsUnit("boss1target", unit) then return true end
	return false
end

local function showOrbWarning(source)
	table.wipe(orbList)
	mod:Unschedule(showOrbWarning)
	for i = 1, GetNumGroupMembers() do
		-- do some checks for 25/10 man raid size so we don't warn for ppl who are not in the instance
		local _,_,diff = GetInstanceInfo()--GetInstanceDifficulty()
		if diff == 3 and i > 10 then return end
		if diff == 4 and i > 25 then return end
		local n = GetRaidRosterInfo(i)
		-- Has aggro on something, but not a tank
		if UnitThreatSituation(n) == 3 and not isTank(n) then
			orbList[#orbList + 1] = n
			if UnitIsUnit(n, "player") and not playerWarned then
				playerWarned = true
				specWarnOrbOnYou:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\orbrun.mp3")
				yellSlicer:Yell()
			end
		end
	end
	if source == "spawn" then
		if #orbList >= 2 then--only warn for 2 or more.
			warnOrbs:Show(table.concat(orbList, "<, >"))
			-- if we could guess orb targets lets wipe the orb list in 5 sec
			-- if not then we might as well just save them for next time
			if mod.Options.SetIconOnOrbs then
				mod:ClearIcons()
				if orbList[1] then mod:SetIcon(orbList[1], 8) end
				if orbList[2] then mod:SetIcon(orbList[2], 7) end
				if orbList[3] then mod:SetIcon(orbList[3], 6) end
				if orbList[4] then mod:SetIcon(orbList[4], 5) end
				if orbList[5] then mod:SetIcon(orbList[5], 4) end
				if orbList[6] then mod:SetIcon(orbList[6], 3) end
				if orbList[7] then mod:SetIcon(orbList[7], 2) end
				if orbList[8] then mod:SetIcon(orbList[8], 1) end
			end
		else
			mod:Schedule(0.5, showOrbWarning, "spawn")--check again soon since we didn't have 2 yet.
		end
	elseif source == "damage" then--Orbs are damaging people, they are without a doubt targeting 2 players by now, although may still have others with aggro :\
		warnOrbs:Show(table.concat(orbList, "<, >"))
		mod:Schedule(10, resetPlayerOrbStatus)
		if mod.Options.SetIconOnOrbs then
			mod:ClearIcons()
			if orbList[1] then mod:SetIcon(orbList[1], 8) end
			if orbList[2] then mod:SetIcon(orbList[2], 7) end
			if orbList[3] then mod:SetIcon(orbList[3], 6) end
			if orbList[4] then mod:SetIcon(orbList[4], 5) end
			if orbList[5] then mod:SetIcon(orbList[5], 4) end
			if orbList[6] then mod:SetIcon(orbList[6], 3) end
			if orbList[7] then mod:SetIcon(orbList[7], 2) end
			if orbList[8] then mod:SetIcon(orbList[8], 1) end
		end
	end
end

function mod:OrbsRepeat()
	resetPlayerOrbStatus()
	timerOrbs:Start()
	sndWOP:Schedule(27, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\blackorb.mp3")
	if self.Options.WarnOrbSoon then
		warnOrbSoon:Schedule(23, 5)
		warnOrbSoon:Schedule(24, 4)
		warnOrbSoon:Schedule(25, 3)
		warnOrbSoon:Schedule(26, 2)
		warnOrbSoon:Schedule(27, 1)
	end
	countdownOrbs:Start(28)
	specWarnOrbs:Show()--generic aoe warning on spawn, before we have actual targets yet.
	if self:IsInCombat() then
		self:ScheduleMethod(28, "OrbsRepeat")
		self:Schedule(0.5, showOrbWarning, "spawn")--Start spawn checks
	end
end

local function showWrackWarning()
	warnWrackJump:Show(wrackName, table.concat(wrackTargets, "<, >"))
	table.wipe(wrackTargets)
end

function mod:givesacrifice()
	specWarnSacrifice:Show()
	sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\sacrifice.mp3")
end

function mod:givemasteraura()
	specWarnControl:Show()
	sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\masteraura.mp3")
end

function mod:OnCombatStart(delay)
	eggDown = 0
	lastDispeled = 0
	newWrackTime = 0
	oldWrackTime = 0
	newWrackCount = 0
	orbdamageSpam = 0
	breathcount = 1
	wrackWarned2 = false
	wrackWarned4 = false
	wrackWarned8 = false
	eggRemoved = false
	calenGUID = 0
	wrackloop = 0
	timerDragon:Start(16-delay)
	timerBreathCD:Start(21-delay, breathcount)
	sndWOP:Schedule(19-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\firebreathsoon.mp3")
	timerOrbs:Start(29-delay)
	sndWOP:Schedule(27-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\blackorb.mp3")
	table.wipe(orbList)
	orbWarned = nil
	playerWarned = nil
	table.wipe(wrackTargets)
	fieryWarned = false
	if self.Options.WarnOrbSoon then
		warnOrbSoon:Schedule(24-delay, 5)
		warnOrbSoon:Schedule(25-delay, 4)
		warnOrbSoon:Schedule(26-delay, 3)
		warnOrbSoon:Schedule(27-delay, 2)
		warnOrbSoon:Schedule(28-delay, 1)
	end
	countdownOrbs:Start(29-delay)
	self:ScheduleMethod(29-delay, "OrbsRepeat")
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(L.HasAggro)
		DBM.InfoFrame:Show(6, "playeraggro", 3)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(90125, 92944) then
		warnBreath:Show(breathcount)
		specWarnBreath:Show()
		breathcount = breathcount + 1
		timerBreathCD:Start(21, breathcount)
		if breathcount == 3 and mod.Options.SoundMAura then
			self:ScheduleMethod(17.5, "givemasteraura")
		end
		sndWOP:Schedule(19, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\firebreathsoon.mp3")
	elseif args:IsSpellID(86227, 86226) then
		warnExtinction:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\twkill.mp3")
		timerExtinction:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(90045, 92946) then
		specWarnIndomitable:Show()
	elseif args:IsSpellID(89421, 92955) then--Cast wracks (10,25)
		wrackloop = wrackloop + 1
		warnWrack:Show(args.destName)
		timerWrack:Start()
		if oldWrackTime == 0 then
			oldWrackTime = GetTime()
		else
			oldWrackTime = newWrackTime
		end
		newWrackTime = GetTime()
		newWrackCount = 1
		lastDispeled = 0
		wrackWarned8 = false
		wrackWarned4 = false
		wrackWarned2 = false
		if mod:IsDifficulty("heroic10") then
			mod:SetIcon(args.destName, 8)
			if wrackloop % 2 == 0 then
				if mod.Options.SoundPAL2 then
					self:ScheduleMethod(13, "givesacrifice")
				end
			else
				if mod.Options.SoundPAL1 then
					self:ScheduleMethod(13, "givesacrifice")
				end
			end
			if args:IsPlayer() then
				sndWOP:Schedule(12, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\trinket.mp3")
			end
			specWarnDispel:Schedule(20, 20)
			sndDIS:Schedule(17, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Schedule(18, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Schedule(19, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Schedule(20, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
		else
			if wrackloop % 2 == 0 then
				if mod.Options.SoundPAL2 then
					self:ScheduleMethod(15, "givesacrifice")
				end
			else
				if mod.Options.SoundPAL1 then
					self:ScheduleMethod(15, "givesacrifice")
				end
			end
			if args:IsPlayer() then
				sndWOP:Schedule(14, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\trinket.mp3")
			end
			specWarnDispel:Schedule(22, 22)
			sndDIS:Schedule(19, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Schedule(20, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Schedule(21, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Schedule(22, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
		end
		self:Schedule(60, function()
			specWarnDispel:Cancel()
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
		end)
	elseif args:IsSpellID(89435, 92956) and (GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 12) then -- jumped wracks (10,25)
		newWrackCount = newWrackCount + 1
		wrackTargets[#wrackTargets + 1] = args.destName
		self:Unschedule(showWrackWarning)
		self:Schedule(0.3, showWrackWarning)
		if newWrackCount > 7 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not wrackWarned8 and mod:IsDifficulty("heroic10") then
			specWarnDispel:Cancel()
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			specWarnDispel:Schedule(12, 12)
			sndDIS:Schedule(9, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Schedule(10, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Schedule(11, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Schedule(12, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			wrackWarned8 = true
		elseif newWrackCount > 3 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not wrackWarned4 then
			specWarnDispel:Cancel()
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			if mod:IsDifficulty("heroic10") then
				specWarnDispel:Schedule(12, 12)
				sndDIS:Schedule(9, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndDIS:Schedule(10, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndDIS:Schedule(11, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndDIS:Schedule(12, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			else
				specWarnDispel:Schedule(14, 14)
				sndDIS:Schedule(11, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndDIS:Schedule(12, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndDIS:Schedule(13, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndDIS:Schedule(14, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			end
			wrackWarned4 = true
		elseif newWrackCount > 1 and GetTime() - lastDispeled < 5 and GetTime() - newWrackTime < 60 and not wrackWarned2 then
			specWarnDispel:Cancel()
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndDIS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			if mod:IsDifficulty("heroic10") then
				specWarnDispel:Schedule(12, 12)
				sndDIS:Schedule(9, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndDIS:Schedule(10, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndDIS:Schedule(11, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndDIS:Schedule(12, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			else
				specWarnDispel:Schedule(18, 18)
				sndDIS:Schedule(15, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndDIS:Schedule(16, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndDIS:Schedule(17, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndDIS:Schedule(18, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			end
			wrackWarned2 = true
		end
	elseif args:IsSpellID(87299) then
		eggDown = 0
		warnPhase2:Show()
		timerBreathCD:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\firebreathsoon.mp3")
		timerOrbs:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\blackorb.mp3")
		if self.Options.WarnOrbSoon then
			warnOrbSoon:Cancel()
		end
		countdownOrbs:Cancel()
		self:UnscheduleMethod("OrbsRepeat")
		if mod.Options.SetIconOnOrbs then
			mod:ClearIcons()
		end
	elseif args:IsSpellID(87231) and not args:IsDestTypePlayer() then
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)
			calenGUID = args.sourceGUID
		end
		if not fieryWarned then
			warnFieryBarrier:Show()
			timerFieryBarrier:Start()
			fieryWarned = true
		end
	elseif args:IsSpellID(87654) then
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)
		end
		if self:AntiSpam(3) then
			timerDragon:Cancel()
			if eggRemoved then
				specWarnEggShield:Show()
			end
		end
	elseif args:IsSpellID(87946) and args:IsNPC() then--NPC check just simplifies it cause he gains the buff too, before he dies, less local variables this way.
		warnRedEssence:Show()
		timerRedEssence:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(87654) and self:AntiSpam(3) then
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\killegg.mp3")
		timerEggWeaken:Show()
		specWarnEggWeaken:Show()
		eggRemoved = true
	elseif args:IsSpellID(89421, 92955) then
		mod:SetIcon(args.destName, 0)
		if GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 14 then
			newWrackCount = newWrackCount - 1
			if GetTime() - lastDispeled > 5 then
				lastDispeled = GetTime()
			end
		end
	elseif args:IsSpellID(89435, 92956) then
		if GetTime() - oldWrackTime < 60 or GetTime() - newWrackTime > 14 then
			newWrackCount = newWrackCount - 1
			if GetTime() - lastDispeled > 5 then
				lastDispeled = GetTime()
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 92954 or spellId == 92959 then
		if not orbWarned then
			orbWarned = true
			showOrbWarning("damage")
		end
		if destGUID == UnitGUID("player") and GetTime() - orbdamageSpam >= 4 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			orbdamageSpam = GetTime()
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDragon or msg:find(L.YellDragon) then
		warnDragon:Show()
		if mod:IsTank() then
			sndWOP:Schedule(4, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dragonnow.mp3")
		end
		timerDragon:Start()
	elseif msg == L.YellEgg or msg:find(L.YellEgg) then
		timerEggWeakening:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\eggsoon.mp3")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 46842 then
		DBM.BossHealth:RemoveBoss(args.destGUID)
		eggDown = eggDown + 1
		if eggDown >= 2 then
			DBM.BossHealth:RemoveBoss(calenGUID)
			timerEggWeaken:Cancel()
			warnPhase3:Show()
			breathcount = 1
			timerBreathCD:Start(21, breathcount)
			sndWOP:Schedule(19, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\firebreathsoon.mp3")
			timerOrbs:Start(30)
			sndWOP:Schedule(28, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\blackorb.mp3")
			timerDragon:Start()
			timerRedEssenceCD:Start()
			if self.Options.WarnOrbSoon then
				warnOrbSoon:Cancel()
				warnOrbSoon:Schedule(25, 5)
				warnOrbSoon:Schedule(26, 4)
				warnOrbSoon:Schedule(27, 3)
				warnOrbSoon:Schedule(28, 2)
				warnOrbSoon:Schedule(29, 1)
			end
			countdownOrbs:Cancel()
			self:UnscheduleMethod("OrbsRepeat")
			countdownOrbs:Start(30)
			self:ScheduleMethod(30, "OrbsRepeat")
		end
	end
end
