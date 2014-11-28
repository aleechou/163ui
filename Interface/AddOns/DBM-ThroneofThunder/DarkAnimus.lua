local mod	= DBM:NewMod(824, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
--BH ADD
local sndWOP	= mod:SoundMM("SoundWOP")
local sndCQ		= mod:SoundMM("SoundCQ")

mod:SetRevision(("$Revision: 11365 $"):sub(12, -3))
mod:SetCreatureID(69427)
mod:SetEncounterID(1576)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("emote", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_WHISPER"
)

local warnCrimsonWake				= mod:NewTargetAnnounce(138480, 3)
local warnMatterSwap				= mod:NewTargetAnnounce(138609, 3)--Debuff.
local warnMatterSwapped				= mod:NewAnnounce("warnMatterSwapped", 3, 138618)--Actual swap(caused by dispel)
local warnExplosiveSlam				= mod:NewStackAnnounce(138569, 2, nil, mod:IsTank() or mod:IsHealer())
--Boss
local warnActivation				= mod:NewCastAnnounce(139537, 3, 60)
local warnAnimaRing					= mod:NewTargetAnnounce(136954, 3)
local warnAnimaFont					= mod:NewTargetAnnounce(138691, 3)
local warnInterruptingJolt			= mod:NewCountAnnounce(138763, 4)
local warnEmpowerGolem				= mod:NewTargetAnnounce(138780, 3)

local specWarnCrimsonWakeYou		= mod:NewSpecialWarningRun(138480)--Kiter
local specWarnCrimsonWake			= mod:NewSpecialWarningMove(138485)--Standing in stuff left behind by kiter
local yellCrimsonWake				= mod:NewYell(138480)
local specWarnMatterSwap			= mod:NewSpecialWarningYou(138609)
local specWarnExplosiveSlam			= mod:NewSpecialWarningStack(138569, mod:IsTank(), 4)--Assumed value drycode, won't know until cd is observed
local specWarnExplosiveSlamOther	= mod:NewSpecialWarningTarget(138569, mod:IsTank())
--Boss
local specWarnAnimaRing				= mod:NewSpecialWarningYou(136954)
local specWarnAnimaRingOther		= mod:NewSpecialWarningTarget(136954, false)
local yellAnimaRing					= mod:NewYell(136954)
local specWarnAnimaFont				= mod:NewSpecialWarningYou(138691, false)
local specWarnInterruptingJolt		= mod:NewSpecialWarningCount(138763, nil, nil, nil, 2)
local specWarnJSA			= mod:NewSpecialWarning("SpecWarnJSA")

local timerMatterSwap				= mod:NewTargetTimer(12, 138609)--If not dispelled, it ends after 12 seconds regardless
local timerExplosiveSlam			= mod:NewTargetTimer(25, 138569, nil, mod:IsTank() or mod:IsHealer())
--Boss
local timerAnimusActivation			= mod:NewCastTimer(60, 139537)--LFR only
local timerSiphonAnimaCD			= mod:NewNextCountTimer(20, 138644)--Needed mainly for heroic. not important on normal/LFR
local timerAnimaRingCD				= mod:NewNextTimer(24.2, 136954)--Updated/Verified post march 19 hotfix
local timerAnimaFontCD				= mod:NewCDTimer(25, 138691)

local timerInterruptingJoltCD		= mod:NewNextCountTimer(21.8, 138763)
local timerEmpowerGolemCD			= mod:NewCDTimer(16, 138780)

local berserkTimer					= mod:NewBerserkTimer(600)
----BH DELETE local soundCrimsonWake				= mod:NewSound(138480)

local crimsonWake = GetSpellInfo(138485)--Debuff ID I believe, not cast one. Same spell name though

local firstSiphonAnima = false
local SiphonAnimaCount = 0
local InterruptingJoltCount = 0
local fpower = true

mod:AddBoolOption("SetIconOnFont", true)

mod:AddBoolOption("Mob", true, "sound")
mod:AddBoolOption("MobA", false, "sound")
mod:AddBoolOption("MobB", false, "sound")
mod:AddBoolOption("MobC", false, "sound")

mod:AddBoolOption("dr", true, "sound")
for i = 1, 10 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

local function MyJS()
	if (mod.Options.dr1 and InterruptingJoltCount == 0) or (mod.Options.dr2 and InterruptingJoltCount == 1) or (mod.Options.dr3 and InterruptingJoltCount == 2) or (mod.Options.dr4 and InterruptingJoltCount == 3) or (mod.Options.dr5 and InterruptingJoltCount == 4) or (mod.Options.dr6 and InterruptingJoltCount == 5) or (mod.Options.dr7 and InterruptingJoltCount == 6) or (mod.Options.dr8 and InterruptingJoltCount == 7) or (mod.Options.dr9 and InterruptingJoltCount == 8) or (mod.Options.dr10 and InterruptingJoltCount == 9) then 
		return true
	end
	return false
end

function mod:AnimaRingTarget(targetname)
	warnAnimaRing:Show(targetname)
	if targetname == UnitName("player") then
		specWarnAnimaRing:Show()
		yellAnimaRing:Yell()
	else
		specWarnAnimaRingOther:Show(targetname)
	end
end

function mod:OnCombatStart(delay)
	firstSiphonAnima = false
	fpower = true
	InterruptingJoltCount = 0
	SiphonAnimaCount = 0
	berserkTimer:Start(-delay)
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to prevent detecting first heads on pull before variables reset from first engage fire. We'll catch them on delayed engages fired couple seconds later
	)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerAnimaFontCD:Start(14)
		timerAnimaRingCD:Start(23)
		timerSiphonAnimaCD:Start(120, 1)--VERY important on heroic. boss activaet on pull, you have 2 minutes to do as much with adds as you can before he starts using siphon anima
		if mod.Options.MobA then
			sndWOP:Schedule(88, "ex_tt_mobA")
			sndWOP:Schedule(90, "countfive")
			sndWOP:Schedule(92, "countfour")	
			sndWOP:Schedule(94, "countthree")
			sndWOP:Schedule(96, "counttwo")
			sndWOP:Schedule(97, "countone")
			sndWOP:Schedule(98, "mobkill")
		end
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	DBM.InfoFrame:Hide()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 136954 then
		self:BossTargetScanner(69427, "AnimaRingTarget", 0.02, 12)
		timerAnimaRingCD:Start()
		sndCQ:Play("ex_tt_bmcq") --幫忙吃球
	elseif args:IsSpellID(138763, 139867, 139869) then--Normal version is 2.2 sec cast. Heroic is 1.4 second cast. LFR is 3.8 sec cast (thus why it has different spellid)
		InterruptingJoltCount = InterruptingJoltCount + 1
		warnInterruptingJolt:Show(InterruptingJoltCount)
		specWarnInterruptingJolt:Show(InterruptingJoltCount)
		timerInterruptingJoltCD:Cancel()
		timerInterruptingJoltCD:Start(21.8, InterruptingJoltCount + 1)		
		sndWOP:Cancel("defensive")
		sndWOP:Cancel("countfour")
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
		if mod:IsManaUser() and mod:IsRanged() then
			-- DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("stopcast") --停止施法
		else
			sndWOP:Play("ex_tt_dfzj") --斷法震擊
		end
		if mod:IsHealer() then
			sndWOP:Cancel("ex_tt_tenzj")
			sndWOP:Schedule(11.8, "ex_tt_tenzj") -- 10秒後斷法震擊
		end
		if MyJS() then
			specWarnJSA:Schedule(18.8)
			sndWOP:Schedule(18.8, "defensive") --注意減傷
		else
			sndWOP:Schedule(18.8, "countfour")
		end		
		sndWOP:Schedule(19.8, "countthree")
		sndWOP:Schedule(20.8, "counttwo")
		sndWOP:Schedule(21.8, "countone")
		DBM.InfoFrame:Hide()
		DBM.InfoFrame:SetHeader(GetSpellInfo(138763).."("..(InterruptingJoltCount + 1)..")")
		DBM.InfoFrame:Show(1, "time", "", 22)
	end
end

local function PowerDelay()
	local power = UnitPower("boss1")
	if power >= 70 and fpower then
		fpower = false
		timerInterruptingJoltCD:Start(18, 1)
		if mod:IsHealer() then
			sndWOP:Schedule(8, "ex_tt_tenzj") -- 10秒後斷法震擊
		end
		if MyJS() then
			specWarnJSA:Schedule(15)
			sndWOP:Schedule(15, "defensive") --注意減傷
		else
			sndWOP:Schedule(15, "countfour")
		end		
		sndWOP:Schedule(16, "countthree")
		sndWOP:Schedule(17, "counttwo")
		sndWOP:Schedule(18, "countone")
		DBM.InfoFrame:SetHeader(GetSpellInfo(138763).."(1)")
		DBM.InfoFrame:Show(1, "time", "", 18)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138644 and self:IsDifficulty("heroic10", "heroic25") then--Only start on heroic, on normal it's 6 second cd, not worth using timer there
		SiphonAnimaCount = SiphonAnimaCount + 1
		timerSiphonAnimaCD:Start(nil, SiphonAnimaCount + 1)
		if mod.Options.MobB then
			if SiphonAnimaCount == 1 then
				sndWOP:Schedule(17, "ex_tt_echx")
			elseif SiphonAnimaCount == 2 then
				sndWOP:Cancel("ex_tt_echx")
				sndWOP:Play("mobkill")
				sndWOP:Schedule(1, "mobkill")
			end
		end
		if mod.Options.MobC then
			if SiphonAnimaCount == 3 then
				sndWOP:Schedule(17, "ex_tt_schx")
			elseif SiphonAnimaCount == 4 then
				sndWOP:Cancel("ex_tt_schx")
				sndWOP:Play("mobkill")
				sndWOP:Schedule(1, "mobkill")
			end
		end
		self:Schedule(2, PowerDelay)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 138569 then
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId, "boss1") then--Only want sprays that are on tanks, not bads standing on tanks.
			local amount = args.amount or 1
			warnExplosiveSlam:Show(args.destName, amount)
			timerExplosiveSlam:Start(args.destName)
			if args:IsPlayer() then
				if amount >= 4 then
					specWarnExplosiveSlam:Show(amount)
				end
			else
				if amount >= 4 and not UnitDebuff("player", GetSpellInfo(138569)) and not UnitIsDeadOrGhost("player") then
					specWarnExplosiveSlamOther:Show(args.destName)
					if mod:IsTank() then
						sndWOP:Play("changemt")--換坦嘲諷
					end
				end
			end
		end
	elseif args.spellId == 138609 then
		warnMatterSwap:Show(args.destName)
		timerMatterSwap:Start(args.destName)
		if args:IsPlayer() then
			specWarnMatterSwap:Show()
			sndWOP:Play("ex_tt_jhzb") --交換準備
		elseif mod:IsHealer() then		
			sndWOP:Play("ex_tt_wzjh") --物質交換
		end
	elseif args.spellId == 138780 then
		warnEmpowerGolem:Show(args.destName)
		timerEmpowerGolemCD:Start()
	elseif args.spellId == 139537 then
		warnActivation:Show()
		timerAnimusActivation:Start()
	elseif args.spellId == 138691 then
		warnAnimaFont:Show(args.destName)
		timerAnimaFontCD:Start()
		if args:IsPlayer() then
			specWarnAnimaFont:Show()
		end
		if self.Options.SetIconOnFont then
			self:SetIcon(args.destName, 1)--star
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 138609 then
		timerMatterSwap:Cancel(args.destName)
	elseif args.spellId == 138569 then
		timerExplosiveSlam:Cancel(args.destName)
	elseif args.spellId == 138691 and self.Options.SetIconOnFont then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 138485 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnCrimsonWake:Show()
		sndWOP:Play("runaway") --快躲開
	elseif spellId == 138618 then
		if sourceGUID == destGUID then return end--Filter first event then grab both targets from second event, as seen from log example above
		warnMatterSwapped:Show(spellName, DBM:GetFullPlayerNameByGUID(sourceGUID), DBM:GetFullPlayerNameByGUID(destGUID))
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

--Seems to have no debuff event on combat log. Could possibly use UNIT_AURA, but this should be tremendous cpu, plus hard to code in LFR since MANY large up at once
function mod:RAID_BOSS_WHISPER(msg, npc)
	if npc == crimsonWake then--In case target scanning fails, personal warnings still always go off. Target scanning is just so everyone else in raid knows who it's on (since only target sees this emote)
		if self:AntiSpam(3, 1) then--This actually doesn't spam, but we ues same antispam here so that the MOVE warning doesn't fire at same time unless you fail to move for 2 seconds
			specWarnCrimsonWakeYou:Show()
		end
		if not self:IsDifficulty("lfr25") then
			yellCrimsonWake:Yell()
		end
----BH DELETE	soundCrimsonWake:Play()
		-- DBM.Flash:Shake(1, 0, 0)
		sndWOP:Play("justrun")  --快跑
		self:SendSync("WakeTarget", UnitGUID("player"))
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	if UnitExists("boss1") and tonumber(UnitGUID("boss1"):sub(6, 10), 16) == 69427 then
		self:UnregisterShortTermEvents()--Once boss is out, unregister event, since we need it no longer.		
		if self:IsDifficulty("normal10", "normal25") then
			timerSiphonAnimaCD:Start(5.3, 1)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "WakeTarget" and guid then
		warnCrimsonWake:Show(DBM:GetFullPlayerNameByGUID(guid))
	end
end

