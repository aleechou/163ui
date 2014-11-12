local mod	= DBM:NewMod(194, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 115 $"):sub(12, -3))
mod:SetCreatureID(52530)
mod:SetEncounterID(1206)
mod:DisableEEKillDetection()
mod:SetZone()
mod:SetModelSound("Sound\\Creature\\ALYSRAZOR\\VO_FL_ALYSRAZOR_AGGRO.wav", "Sound\\Creature\\ALYSRAZOR\\VO_FL_ALYSRAZOR_TRANSITION_02.wav")
--Long: I serve a new master now, mortals!
--Short: Reborn in Flame!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEvents(
	"SPELL_CAST_START"
)

local warnMolting		= mod:NewSpellAnnounce(99464, 3)
local warnFirestormSoon	= mod:NewPreWarnAnnounce(100744, 10, 3)
local warnFirestorm		= mod:NewSpellAnnounce(100744, 4)
local warnCataclysm		= mod:NewCastAnnounce(102111, 3)
local warnPhase			= mod:NewAnnounce("WarnPhase", 3, "Interface\\Icons\\Spell_Nature_WispSplode")
local warnNewInitiate	= mod:NewAnnounce("WarnNewInitiate", 3, 61131)
local warnBlazingPower	= mod:NewStackAnnounce(99461, 3)

local specWarnFirestorm			= mod:NewSpecialWarningSpell(100744, nil, nil, nil, true)
local specWarnFieroblast		= mod:NewSpecialWarningInterrupt(101223)
local specWarnGushingWoundSelf	= mod:NewSpecialWarningYou(99308, false)
local specWarnTantrum			= mod:NewSpecialWarningSpell(99362, mod:IsTank() or mod:IsHealer())
local specWarnGushingWoundOther	= mod:NewSpecialWarningTarget(99308, false)

local timerCombatStart		= mod:NewTimer(35.5, "TimerCombatStart", 2457)
local timerFieryVortexCD	= mod:NewNextTimer(179, 99794)
local timerMoltingCD		= mod:NewNextTimer(60, 99464)
local timerCataclysm		= mod:NewCastTimer(5, 102111, nil, false)--Heroic
local timerCataclysmCD		= mod:NewCDTimer(31, 102111)--Heroic
local timerFirestormCD		= mod:NewCDTimer(83, 100744)--Heroic
local timerPhaseChange		= mod:NewTimer(33.5, "TimerPhaseChange", 99816)
local timerHatchEggs		= mod:NewTimer(50, "TimerHatchEggs", 42471)
local timerNextInitiate		= mod:NewTimer(32, "timerNextInitiate", 61131)
local timerBlazingPower		= mod:NewBuffActiveTimer(40, 99461)
local timerTantrum			= mod:NewBuffActiveTimer(10, 99362, nil, false)
local timerSatiated			= mod:NewBuffActiveTimer(15, 99359, nil, false)
local timerBlazingClaw		= mod:NewTargetTimer(15, 99844, nil, false)

local countdownFirestorm	= mod:NewCountdown(83, 100744)

mod:AddBoolOption("InfoFrame", false)

local initiatesSpawned = 0
local initiate = EJ_GetSectionInfo(2834)
local cataCast = 0
local clawCast = 0
local moltCast = 0
local PowerLevel = GetSpellInfo(98734)

local initiateSpawns = {
	[1] = L.Both,
	[2] = L.Both,
	[3] = L.East,
	[4] = L.West,
	[5] = L.East,
	[6] = L.West
}

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerFieryVortexCD:Start(243-delay)--Probably not right.
		timerCataclysmCD:Start(32-delay)
		timerFirestormCD:Start(94-delay)
		sndWOP:Schedule(84-delay, "firestormsoon")
		countdownFirestorm:Start(94-delay)--Perhaps some tuning.
		warnFirestormSoon:Schedule(84-delay)
		timerHatchEggs:Start(37-delay)
	else
		timerFieryVortexCD:Start(196-delay)
		timerHatchEggs:Start(47-delay)
	end
	timerNextInitiate:Start(27-delay, L.Both)--First one is same on both difficulties.
	initiatesSpawned = 0
	cataCast = 0
	clawCast = 0
	moltCast = 0
	if self.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(PowerLevel)
		DBM.InfoFrame:Show(5, "playerpower", 10, ALTERNATE_POWER_INDEX)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99362) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and (args.sourceGUID == UnitGUID("targettarget") or args.sourceGUID == UnitGUID("focustargettarget"))) then--Only give warning if it's mob you're targeting and you're a tank, or you're targeting the tank it's on and he's targeting the bird.
		specWarnTantrum:Show()
		timerTantrum:Start()
		sndWOP:Play("chickenfrenzy")
	elseif args:IsSpellID(99359, 100850, 100851, 100852) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and (args.sourceGUID == UnitGUID("targettarget") or args.sourceGUID == UnitGUID("focustargettarget"))) then--^^ Same as above only with diff spell
		if self:IsDifficulty("heroic10", "heroic25") then
			timerSatiated:Start(10)
		else
			timerSatiated:Start()
		end
	elseif args:IsSpellID(99308) then--Gushing Wound
		specWarnGushingWoundOther:Show(args.destName)
		if args:IsPlayer() then
			specWarnGushingWoundSelf:Show()
		end
	elseif args:IsSpellID(99432) then--Burnout applied (0 energy)
		warnPhase:Show(3)
	elseif args:IsSpellID(99461) and args:IsPlayer() then
		warnBlazingPower:Show(args.destName, args.amount or 1)
		timerBlazingPower:Start()
	elseif args:IsSpellID(99844, 101729, 101730, 101731) and args:IsDestTypePlayer() then
		timerBlazingClaw:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REFRESH(args)
	if args:IsSpellID(99359, 100850, 100851, 100852) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then--^^ Same as above only with diff spell
		if self:IsDifficulty("heroic10", "heroic25") then
			timerSatiated:Start(10)
		else
			timerSatiated:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(100744) then--Firestorm removed from boss. No reason for a heroic check here, this shouldn't happen on normal.
		timerHatchEggs:Start(16)
		if cataCast < 3 then
			timerCataclysmCD:Start(10)--10 seconds after first firestorm ends
		else
			timerCataclysmCD:Start(20)--20 seconds after second one ends. (or so i thought, my new logs show only 4 cataclysms not 5. wtf. I hate inconsistencies
		end
	elseif args:IsSpellID(99432) and self:IsInCombat() then--Burnout removed (50 energy)
		warnPhase:Show(4)
	elseif args:IsSpellID(99362) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then
		timerTantrum:Cancel()
	elseif args:IsSpellID(99359, 100850, 100851, 100852) and ((args.sourceGUID == UnitGUID("target") and self:IsTank()) or not self:IsTank() and args.sourceGUID == UnitGUID("targettarget")) then--^^ Same as above only with diff spell
		timerSatiated:Cancel()
	elseif args:IsSpellID(101731) then
		timerBlazingClaw:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(101223, 101294, 101295, 101296) then
		if args.sourceGUID == UnitGUID("target") then
			specWarnFieroblast:Show(args.sourceName)
		end
	elseif args:IsSpellID(102111, 100761) then
		cataCast = cataCast + 1
		warnCataclysm:Show()
		sndWOP:Play("catalysm")
		sndWOP:Schedule(7, "countthree")
		sndWOP:Schedule(8, "counttwo")
		sndWOP:Schedule(9, "countone")
		if cataCast < 5 then
			if not self:IsTank() and not self:IsHealer() then			
				sndWOP:Schedule(10, "killmeteor")
			end
		end
		timerCataclysm:Start()
		if cataCast == 1 or cataCast == 3 then--Cataclysm is cast 5 times, but there is a firestorm in middle them affecting CD on 2nd and 4th, so you only want to start 30 sec bar after first and third
			timerCataclysmCD:Start()
		end
	elseif args:IsSpellID(100744) then
		warnFirestorm:Show()
		specWarnFirestorm:Show()
		sndWOP:Play("firestorm")
		sndWOP:Schedule(2, "countthree")
		sndWOP:Schedule(3, "counttwo")
		sndWOP:Schedule(4, "countone")
		if cataCast < 3 then--Firestorm is only cast 2 times per phase. This essencially makes cd bar only start once.
			timerFirestormCD:Start()
			countdownFirestorm:Start(83)--Perhaps some tuning.
			sndWOP:Schedule(73, "firestormsoon")
			warnFirestormSoon:Cancel()--Just in case it's wrong. WoL may not be perfect, i'll have full transcriptor logs soon.
			warnFirestormSoon:Schedule(73)
		end
	elseif args:IsSpellID(100559) then--Roots from the first pull RP
		timerCombatStart:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(99464, 100698) and self:IsDifficulty("normal10", "normal25") then
		warnMolting:Show()
		if moltCast < 2 then
			timerMoltingCD:Start()
			moltCast = moltCast + 1
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 99336 or spellId == 100726) and self:AntiSpam(3) and destGUID == UnitGUID("player") then
		sndWOP:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_MONSTER_YELL(msg, mob)
	if not self:IsInCombat() then return end
	if msg == L.YellPhase2 or msg:find(L.YellPhase2) then--Basically the pre warn to feiry vortex
		warnPhase:Show(2)
		sndWOP:Schedule(6, "ptwo")
		sndWOP:Schedule(8, "countfive")
		sndWOP:Schedule(9, "countfour")
		sndWOP:Schedule(10, "countthree")
		sndWOP:Schedule(11, "counttwo")
		sndWOP:Schedule(12, "countone")
		timerMoltingCD:Cancel()
		timerPhaseChange:Start(33, 3)
		initiatesSpawned = 0
	--Yes it's ugly, but it works.
	elseif mob == initiate then
		initiatesSpawned = initiatesSpawned + 1
		warnNewInitiate:Show(initiateSpawns[initiatesSpawned])
		if initiatesSpawned == 6 then return end--All 6 are spawned, lets not create any timers.
		if self:IsDifficulty("heroic10", "heroic25") then
		--East: 2 adds, firestorm, 2 adds, firestorm, no adds.
		--West: 2 adds, firestorm, 1 add, firestorm, 1 add.
			if initiatesSpawned == 1 then--First on Both sides
				timerNextInitiate:Start(22, L.Both)--Next will be on both sides
			elseif initiatesSpawned == 2 then
				timerNextInitiate:Start(63, L.East)--Next will spawn on east only
			elseif initiatesSpawned == 3 then
				timerNextInitiate:Start(21, L.West)--Next will spawn west only
			elseif initiatesSpawned == 4 then
				timerNextInitiate:Start(21, L.East)--Next will spawn east only, just before fire storm
			elseif initiatesSpawned == 5 then
				timerNextInitiate:Start(40, L.West)--Last will be on west, after a fire storm
			end
		else
			--Using averages, 30-32 and 20-22 are variations.
			if initiatesSpawned == 1 then--First on Both sides
				timerNextInitiate:Start(31, L.Both)--Next will be on both sides
			elseif initiatesSpawned == 2 then
				timerNextInitiate:Start(31, L.East)--Next will spawn on east only
			elseif initiatesSpawned == 3 then
				timerNextInitiate:Start(21, L.West)--Next will spawn west only
			elseif initiatesSpawned == 4 then
				timerNextInitiate:Start(21, L.East)--Next will spawn east only
			elseif initiatesSpawned == 5 then
				timerNextInitiate:Start(21, L.West)--Last will be on west
			end
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.FullPower or msg:find(L.FullPower) then
		warnPhase:Show(1)
		timerNextInitiate:Start(13.5, L.Both)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFieryVortexCD:Start(225)
			timerHatchEggs:Start(22)
			timerCataclysmCD:Start(18)
			timerFirestormCD:Start(70)
			countdownFirestorm:Start(70)
			sndWOP:Schedule(60, "firestormsoon")
			warnFirestormSoon:Schedule(60)
			cataCast = 0
			clawCast = 0
		else
			timerFieryVortexCD:Start()
			timerHatchEggs:Start(32)
		end
	end
end
