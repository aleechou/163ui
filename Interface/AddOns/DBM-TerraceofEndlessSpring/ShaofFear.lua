local mod	= DBM:NewMod(709, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndDD	= mod:SoundMM("SoundDD")

mod:SetRevision(("$Revision: 9929 $"):sub(12, -3))
mod:SetCreatureID(60999)--61042 Cheng Kang, 61046 Jinlun Kun, 61038 Yang Guoshi, 61034 Terror Spawn
mod:SetUsedIcons(8, 7, 6, 5, 4)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED"
)

local warnThrash						= mod:NewSpellAnnounce(131996, 4, nil, mod:IsTank() or mod:IsHealer())
local warnConjureTerrorSpawns			= mod:NewSpellAnnounce(119108, 3)
local warnBreathOfFearSoon				= mod:NewPreWarnAnnounce(119414, 10, 10)
local warnBreathOfFear					= mod:NewSpellAnnounce(119414, 3)
local warnImplacableStrike				= mod:NewSpellAnnounce(120672, 4)
local warnWaterspout					= mod:NewTargetAnnounce(120519, 3)
local warnHuddleInTerror				= mod:NewTargetAnnounce(120629, 3)
local warnDreadSpray					= mod:NewSpellAnnounce(120047, 2)
local warnDreadThrash					= mod:NewSpellAnnounce(132007, 4, nil, mod:IsTank() or mod:IsHealer())
local warnSubmerge						= mod:NewCountAnnounce(120455)
local warnNakedAndAfraid				= mod:NewTargetAnnounce(120669, 2, nil, mod:IsTank())
local warnChampionOfTheLight			= mod:NewTargetAnnounce(120268, 3, nil, false)--seems spammy.
local warnOminousCackle					= mod:NewTargetAnnounce(129147, 4)--129147 is debuff, 119693 is cast. We do not reg warn cast cause we reg warn the actual targets instead. We special warn cast to give a little advanced heads up though.
local warnPhase2Soon					= mod:NewPrePhaseAnnounce(2, 3)

local specWarnThrash					= mod:NewSpecialWarningSpell(131996, mod:IsTank())
local specWarnImplacableStrike			= mod:NewSpecialWarningSpell(120672)
local specWarnBreathOfFear				= mod:NewSpecialWarningSpell(119414, nil, nil, nil, true)
local specWarnOminousCackle				= mod:NewSpecialWarningSpell(119693, nil, nil, nil, true)--Cast, warns the entire raid.
local specWarnOminousCackleYou			= mod:NewSpecialWarningYou(129147)--You have debuff, just warns you.
local specWarnTerrorSpawn				= mod:NewSpecialWarningSwitch("ej6088",  mod:IsDps())
local specWarnDreadSpray				= mod:NewSpecialWarningSpell(120047, nil, nil, nil, true)--Platform ability, particularly nasty damage, and fear.
local specWarnDeathBlossom				= mod:NewSpecialWarningSpell(119888, nil, nil, nil, true)--Cast, warns the entire raid.
local specWarnShot						= mod:NewSpecialWarningStack(119086, true, 2)
local specWarnshuipoYou					= mod:NewSpecialWarningMove(120519)
local specWarnzyg						= mod:NewSpecialWarning("specWarnzyg")
local specWarnshuipo					= mod:NewSpecialWarningSpell(120519, nil, nil, nil, true)
local specWarnWaterspoutNear			= mod:NewSpecialWarningClose(120519)
local specWarnyinmo						= mod:NewSpecialWarning("specWarnyinmo")
local specWarnfuxian					= mod:NewSpecialWarning("specWarnfuxian")
local specWarnweisuo					= mod:NewSpecialWarning("specWarnweisuo")
local MoveWarningBack					= mod:NewSpecialWarning("MoveWarningBack")
local MoveWarningLeft					= mod:NewSpecialWarning("MoveWarningLeft")
local MoveWarningRight					= mod:NewSpecialWarning("MoveWarningRight")
local specWarningpreHud					= mod:NewSpecialWarning("specWarningpreHud")
local specWarnshuipomove				= mod:NewSpecialWarningMove(120521)
local specWarnzhanli					= mod:NewSpecialWarningYou(120669)
local specWarnzhanliOther				= mod:NewSpecialWarningTarget(120669, mod:IsTank() or mod:IsHealer())
local specWarnDreadThrash				= mod:NewSpecialWarningSpell(132007, mod:IsTank())

local timerThrashCD						= mod:NewCDTimer(9, 131996, nil, mod:IsTank() or mod:IsHealer())--Every 9-12 seconds.
local timerHThrashCD					= mod:NewCDTimer(9, 131996, nil, mod:IsTank() or mod:IsHealer())
local timerNakedAndAfraid				= mod:NewTargetTimer(25, 120669)-- EJ says that debuff duration 25 sec.
local timerBreathOfFearCD				= mod:NewNextTimer(33.3, 119414)--Based off bosses energy, he casts at 100 energy, and gains about 3 energy per second, so every 33-34 seconds is a breath.
local timerOminousCackleCD				= mod:NewNextTimer(45.5, 119693)
local timerDreadSpray					= mod:NewBuffActiveTimer(8, 120047)
local timerDreadSprayCD					= mod:NewNextTimer(20.5, 120047)
local timerSpecialCD					= mod:NewTimer(10, "timerSpecialCD", 126554)
local timerWaterspoutCD					= mod:NewCDTimer(10, 120519)
local timerHuddleInTerrorCD				= mod:NewCDTimer(10, 120629)
local timerImplacableStrikeCD			= mod:NewCDTimer(10, 120672)
local timerSpoHudCD						= mod:NewTimer(10, "timerSpoHudCD", 64044)--Waterspout or Huddle in Terror next
local timerSpoStrCD						= mod:NewTimer(10, "timerSpoStrCD", 1953)--Waterspout or Implacable Strike next
local timerHudStrCD						= mod:NewTimer(10, "timerHudStrCD", 64044)-- Huddle in Terror or Implacable Strike next
local timerweisuo						= mod:NewNextCountTimer(50,120629)
local timeryinmo						= mod:NewNextCountTimer(50,120458)
local yellshuipo						= mod:NewYell(120519)
local timerFearless						= mod:NewBuffFadesTimer(30, 118977)
local timerDeathBlossom					= mod:NewBuffActiveTimer(5, 119888)
local timerNakedAndAfraidCD				= mod:NewCDTimer(30, 120669)-- unconfirmed.

local berserkTimer						= mod:NewBerserkTimer(900)

local ominousCackleTargets = {}
local platformGUIDs = {}
local onPlatform = false--Used to determine when YOU are sent to a platform, so we know to activate MobID on next shoot
local MobID = 0
local phase = 1
local ThrashCount = 0
local kongjuCount = 0
local yinmoCount = 0
local warnedBreath = false

local kbpscount = 0
local kjzz = 0
local kjzznow = 0
local infowjzz = 0

local huddle = 0
local spout = 0
local strike = 0
local wjcount = 0

local swingcount = 0

local wsIcon = 7

local prewarnedPhase2 = false
local lastyongshi = nil

local fearless = GetSpellInfo(118977)
local wallLight = GetSpellInfo(117964)

local playkbpsound = false

DBM.ShaOfFearAssistEnabled = true
DBM.ShaAssistStarModeChosed = nil

mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("InfoFrameTankMode", mod:IsTank(), "sound")
mod:AddBoolOption("SetIconOnWS", true)
mod:AddBoolOption("pscount", true, "sound")
mod:AddBoolOption("ShaAssist", true, "sound")
mod:AddBoolOption("ShaStarMode", false, "sound")
local sndWOPWSCOUNT = mod:NewSound(nil, "SoundWSCOUNT", not mod:IsTank())

for i = 1, 4 do
	mod:AddBoolOption("unseenjs"..i, false, "sound")
end

local function MyJS()
	if (mod.Options.unseenjs1 and kongjuCount % 4 == 1) or (mod.Options.unseenjs2 and kongjuCount % 4 == 2) or (mod.Options.unseenjs3 and kongjuCount % 4 == 3) or (mod.Options.unseenjs4 and kongjuCount % 4 == 0) then
		return true
	end
	return false
end

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local waterspoutTargets = {}
local huddleInTerrorTargets = {}

local function warnOminousCackleTargets()
	warnOminousCackle:Show(table.concat(ominousCackleTargets, "<, >"))
	table.wipe(ominousCackleTargets)
end

local function warnWaterspoutTargets()
	warnWaterspout:Show(table.concat(waterspoutTargets, "<, >"))
	table.wipe(waterspoutTargets)
end

local function warnHuddleInTerrorTargets()
	warnHuddleInTerror:Show(table.concat(huddleInTerrorTargets, "<, >"))
	table.wipe(huddleInTerrorTargets)
end

local function spectimestart()
	if huddle == 1 and spout == 1 and strike == 0 then
		sndWOP:Schedule(5, "ex_mop_ylxjzb")
		timerImplacableStrikeCD:Start()
	end
	if huddle == 1 and spout == 0 and strike == 1 then
		timerWaterspoutCD:Start()
	end
	if huddle == 1 and spout == 0 and strike == 0 then
		sndWOP:Schedule(6, "specialsoon")
		timerSpoStrCD:Start()
	end
	if huddle == 0 and spout == 1 and strike == 0 then
		timerHuddleInTerrorCD:Start()
		specWarningpreHud:Schedule(8)
		sndWOP:Schedule(6, "ex_mop_wszb")
		if not mod:IsTank() then
			sndWOP:Schedule(7, "holdit")
		end
	end
	if huddle == 0 and spout == 0 and strike == 1 then
		timerHuddleInTerrorCD:Start()
		specWarningpreHud:Schedule(8)
		sndWOP:Schedule(6, "ex_mop_wszb")
		if not mod:IsTank() then
			sndWOP:Schedule(7, "holdit")
		end
	end
end

function mod:LeavePlatform()
	if onPlatform then
		onPlatform = false
		playkbpsound = false
		MobID = nil
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:RemoveBoss(61038)
			DBM.BossHealth:RemoveBoss(61042)
			DBM.BossHealth:RemoveBoss(61046)
		end
		table.wipe(platformGUIDs)
		if phase == 2 then return end
		--Breath of fear timer recovery
		local fearlessApplied = UnitBuff("player", fearless)
		local shaPower = UnitPower("boss1") --Get Boss Power
		shaPower = shaPower / 3 --Divide it by 3 (cause he gains 3 power per second and we need to know how many seconds to subtrack from fear CD)
		if (not fearlessApplied and shaPower < 30.3) or (fearlessApplied and shaPower < 5) then--If you have no fearless and breath timer less then 3s, you may not reach to wall. So ignore below 3 sec. Also if you have fearless and breath timer less then 28.3s, not need to warn breath.
			timerBreathOfFearCD:Start(33.3-shaPower)
			if shaPower < 23.3 then
				mod:Schedule(23.3 - shaPower, function()
					if not warnedBreath then
						warnedBreath = true
						sndWOP:Play("ex_mop_tenkj") --10秒後恐懼之息
						DBM.Flash:Shake(1, 0, 0)
						sndWOP:Schedule(5.5, "countfive")
						sndWOP:Schedule(6.5, "countfour")
						sndWOP:Schedule(7.5, "countthree")
						sndWOP:Schedule(8.5, "counttwo")
						sndWOP:Schedule(9.5, "countone")
					end
				end)
			end
		end
	end
end

function mod:CheckPlatformLeaved()--Check you are leaved platform by Wall of Light buff. Failsafe for some siturations./
	if UnitBuff("player", wallLight) then
		self:UnscheduleMethod("CheckPlatformLeaved")
		self:LeavePlatform()
	else
		self:ScheduleMethod(3, "CheckPlatformLeaved")
	end
end

function mod:OnCombatStart(delay)
	warnBreathOfFearSoon:Schedule(23.4-delay)
	if self:IsDifficulty("normal10", "heroic10", "lfr25") then
		timerOminousCackleCD:Start(40-delay)
	else
		timerOminousCackleCD:Start(25.5-delay)
	end
	phase = 1
	ThrashCount = 0
	kongjuCount = 0
	yinmoCount = 0
	kbpscount = 0
	kjzz = 0
	huddle = 0
	spout = 0
	strike = 0
	wsIcon = 7
	wjcount = 0
	swingcount = 0
	warnedBreath = false
	prewarnedPhase2 = false
	table.wipe(waterspoutTargets)
	table.wipe(huddleInTerrorTargets)
	table.wipe(ominousCackleTargets)
	table.wipe(platformGUIDs)
	timerBreathOfFearCD:Start(-delay)
	onPlatform = false
	playkbpsound = false
	MobID = nil
	lastyongshi = nil
	berserkTimer:Start(-delay)
	self:Schedule(23.3, function()
		if not onPlatform then
			sndWOP:Play("ex_mop_tenkj") --10秒後恐懼之息
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Schedule(5.5, "countfive")
			sndWOP:Schedule(6.5, "countfour")
			sndWOP:Schedule(7.5, "countthree")
			sndWOP:Schedule(8.5, "counttwo")
			sndWOP:Schedule(9.5, "countone")
		end
	end)
	self:RegisterShortTermEvents(
		"UNIT_HEALTH"
	)
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame or self.Options.InfoFrameTankMode then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(119414) and self:AntiSpam(5, 1) then--using this with antispam is still better then registering SPELL_CAST_SUCCESS for a single event when we don't have to. Less cpu cause mod won't have to check every SPELL_CAST_SUCCESS event.
		warnBreathOfFear:Show()
		warnedBreath = false
		if not onPlatform then--not in middle, not your problem
			specWarnBreathOfFear:Show()
			timerBreathOfFearCD:Start()
		end
		warnBreathOfFearSoon:Schedule(23.3)
		self:Schedule(23.3, function()
			if (not onPlatform) and (phase == 1) and (not warnedBreath) then
				warnedBreath = true
				sndWOP:Play("ex_mop_tenkj") --10秒後恐懼之息
				DBM.Flash:Shake(1, 0, 0)
				sndWOP:Schedule(5.5, "countfive")
				sndWOP:Schedule(6.5, "countfour")
				sndWOP:Schedule(7.5, "countthree")
				sndWOP:Schedule(8.5, "counttwo")
				sndWOP:Schedule(9.5, "countone")
			end
		end)
	elseif args:IsSpellID(129147) then
		if self.Options.ShaAssist then
			DBM.ShaOfFearAssistEnabled = true
		else
			DBM.ShaOfFearAssistEnabled = false
		end
		if self.Options.ShaStarMode then
			if mod:IsDps() then
				DBM.ShaAssistStarModeChosed = "Dps"
			elseif mod:IsHealer() then
				DBM.ShaAssistStarModeChosed = "Healther"
			else
				DBM.ShaAssistStarModeChosed = "Tank"
			end
		else
			DBM.ShaAssistStarModeChosed = nil
		end
		self:UnscheduleMethod("CheckPlatformLeaved")
		ominousCackleTargets[#ominousCackleTargets + 1] = args.destName
		if args:IsPlayer() then
			onPlatform = true
			specWarnOminousCackleYou:Show()
			timerBreathOfFearCD:Cancel()
			if self:AntiSpam(2, 4) then
				sndWOP:Play("telesoon")--準備傳送
			end
		elseif (not mod:IsDps()) and (not onPlatform) and self:AntiSpam(2, 4) then
			sndWOP:Play("changemt")--換坦嘲諷
		end
		self:Unschedule(warnOminousCackleTargets)
		self:Schedule(2, warnOminousCackleTargets)
	elseif args:IsSpellID(132007) then
		if not mod:IsDps() then
			sndWOP:Play("ex_mop_llj")--六連擊
		end
		ThrashCount = 0
		swingcount = -1
		timerThrashCD:Start()
		warnDreadThrash:Show()
		specWarnDreadThrash:Show()
	elseif args:IsSpellID(120047) and MobID and MobID == args:GetSrcCreatureID() then--might change
		warnDreadSpray:Show()
		specWarnDreadSpray:Show()
		timerDreadSpray:Start(args.sourceGUID)
		timerDreadSprayCD:Start(args.sourceGUID)
		if not self.Options.pscount then
			sndWOP:Play("ex_mop_kbpszb")--恐怖噴散
		end
	elseif args:IsSpellID(119983) and MobID and MobID == args:GetSrcCreatureID() then--might change
		if (args.amount or 1) == 2 then
			if mod:IsHealer() and self:AntiSpam(3, 8) then
				sndWOP:Play("dispelnow") --快驅散
			end
		end
	elseif args:IsSpellID(119888) and MobID and MobID == args:GetSrcCreatureID() then
		timerDeathBlossom:Start()
		sndWOP:Schedule(1.5, "countfour")
		sndWOP:Schedule(2.5, "countthree")
		sndWOP:Schedule(3.5, "counttwo")
		sndWOP:Schedule(4.5, "countone")
	elseif args:IsSpellID(118977) and args:IsPlayer() then--Fearless, you're leaving platform
		timerFearless:Start()
		self:UnscheduleMethod("CheckPlatformLeaved")
		self:LeavePlatform()
	elseif args:IsSpellID(131996) and not onPlatform then
		swingcount = -1
		warnThrash:Show()
		specWarnThrash:Show()
		if not mod:IsDps() then
			sndDD:Play("doubleat")--雙重攻擊	
			timerThrashCD:Start()
			if phase == 2 then
				ThrashCount = ThrashCount + 1
				if ThrashCount == 3 then
					timerThrashCD:Cancel()
					timerHThrashCD:Start()
				end
			end
		end
	elseif args:IsSpellID(119086) then
		if args:IsPlayer() and (args.amount or 1) >= 2 and self:AntiSpam(3, 2) then
			sndWOP:Play("firecircle")--注意火圈
			specWarnShot:Show(args.amount)
		end
	elseif args:IsSpellID(120519) then --水魄
		waterspoutTargets[#waterspoutTargets + 1] = args.destName
		if args:IsPlayer() and self:AntiSpam(5, 20) then
			specWarnshuipoYou:Show()
			yellshuipo:Yell()
			if not UnitBuff("player", GetSpellInfo(120268)) then
				DBM.Flash:Shake(1, 0, 0)
				sndWOP:Play("runout")
			end
		else
 			local uId = DBM:GetRaidUnitId(args.destName)
 			if uId then
				local inRange = CheckInteractDistance(uId, 3)
				if inRange then
					self:Schedule(0.3, function()
						if self:AntiSpam(5, 20) then
							specWarnWaterspoutNear:Show(args.destName)
							sndWOP:Play("keepmove")
						end
					end)
 				end
 			end
		end
		self:Unschedule(warnWaterspoutTargets)
		self:Schedule(0.3, warnWaterspoutTargets)
		spout = 1
		if self:AntiSpam(5, 6) then
			spectimestart()
		end
	elseif args:IsSpellID(120268) then
		warnChampionOfTheLight:Show(args.destName)
		if args:IsPlayer() then
			if lastyongshi then
				specWarnzyg:Show(lastyongshi)
			end
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_mop_zyg") --轉移光
		end
		lastyongshi = args.destName
	elseif args:IsSpellID(120669) then--赤裸
		sndWOP:Cancel("ex_mop_clzb")
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
		warnNakedAndAfraid:Show(args.destName)
		if self:IsDifficulty("heroic10") then
			timerNakedAndAfraid:Start(args.destName)
		else
			timerNakedAndAfraid:Start(50, args.destName)
		end
		if args:IsPlayer() then
			specWarnzhanli:Show()
		else
			specWarnzhanliOther:Show(args.destName)
			if mod:IsTank() or mod:IsHealer() then
				sndWOP:Play("changemt")--換坦嘲諷
			end
		end
		timerNakedAndAfraidCD:Start()
		if mod:IsTank() then
			if timeryinmo:GetTime() < 20 then
				sndWOP:Schedule(26, "ex_mop_clzb") --赤裸準備
				sndWOP:Schedule(27.5, "countthree")
				sndWOP:Schedule(28.5, "counttwo")
				sndWOP:Schedule(29.5, "countone")
			end
		end
	elseif args:IsSpellID(120629) then
		if self.Options.SetIconOnWS then
			self:SetIcon(args.destName, wsIcon)
			wsIcon = wsIcon - 1
		end
		huddleInTerrorTargets[#huddleInTerrorTargets + 1] = args.destName
		self:Unschedule(warnHuddleInTerrorTargets)
		self:Schedule(0.5, warnHuddleInTerrorTargets)
		if self:AntiSpam(5, 6) then
			kongjuCount = kongjuCount + 1
			sndWOP:Play("ex_mop_wsks")
			specWarnweisuo:Show(kongjuCount)
			timerweisuo:Start(50, kongjuCount + 1)
			huddle = 1
			spectimestart()
			if kongjuCount % 4 == 1 then
				sndWOPWSCOUNT:Schedule(1, "countone")
			elseif kongjuCount % 4 == 2 then
				sndWOPWSCOUNT:Schedule(1, "counttwo")
			elseif kongjuCount % 4 == 3 then
				sndWOPWSCOUNT:Schedule(1, "countthree")
			elseif kongjuCount % 4 == 0 then
				sndWOPWSCOUNT:Schedule(1, "countfour")
			end
			if MyJS() then
				sndWOP:Schedule(2, "defensive") --注意減傷
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(120047) then
		kbpscount = 0
		timerDreadSpray:Cancel(args.sourceGUID)
	elseif args:IsSpellID(129147) then
		if args:IsPlayer() then
			playkbpsound = true
			onPlatform = true
		end
	elseif args:IsSpellID(118977) and args:IsPlayer() then
		timerFearless:Cancel()
	elseif args:IsSpellID(120629) then
		if self.Options.SetIconOnWS then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(119593, 119692, 119693) then--This seems to have multiple spellids, depending on which platform he's going to send you to. TODO, figure out which is which platform and add additional warnings
		specWarnOminousCackle:Show()
		if self:IsDifficulty("normal10", "heroic10", "lfr25") then
			timerOminousCackleCD:Start(90.5)--Far less often on LFR
		else
			timerOminousCackleCD:Start()
		end
	elseif args:IsSpellID(119862) and playkbpsound and not platformGUIDs[args.sourceGUID] then--Best way to track engaging one of the side adds, they cast this instantly.
		platformGUIDs[args.sourceGUID] = true
		MobID = self:GetCIDFromGUID(args.sourceGUID)
		timerDreadSprayCD:Start(10.5, args.sourceGUID)--We can accurately start perfectly accurate spray cd bar off their first shoot cast.
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(MobID, args.sourceName)
		end
	elseif args:IsSpellID(119888) and MobID and MobID == args:GetSrcCreatureID() then
		specWarnDeathBlossom:Show()
		DBM.Flash:Shake(1, 0, 0)
		self:ScheduleMethod(40, "CheckPlatformLeaved")
		sndWOP:Play("ex_mop_jykd") --劍雨快躲
	elseif args:IsSpellID(120519) then
		specWarnshuipo:Show()
		sndWOP:Play("ex_mop_spzb") --水魄準備
	elseif args:IsSpellID(120455) then --隐没
		yinmoCount = yinmoCount + 1
		warnSubmerge:Show(yinmoCount)
		specWarnyinmo:Show(yinmoCount)
		timerSpecialCD:Start(12)
		sndWOP:Schedule(9, "specialsoon") --準備特別技能
		timeryinmo:Start(51.5, yinmoCount + 1)
		huddle = 0
		spout = 0
		strike = 0
		wsIcon = 7
		DBM.Flash:Shake(1, 1, 0)
		sndWOP:Play("ex_mop_ymzb")
	elseif args:IsSpellID(120458) then --浮現
		if yinmoCount == 1 then
			timerNakedAndAfraidCD:Start(14)
			if mod:IsTank() then
				sndWOP:Schedule(10, "ex_mop_clzb") --赤裸準備
				sndWOP:Schedule(11.5, "countthree")
				sndWOP:Schedule(12.5, "counttwo")
				sndWOP:Schedule(13.5, "countone")
			end
		else
			if (timerNakedAndAfraidCD:GetTime() > 15) or (timerNakedAndAfraidCD:GetTime() == 0) then
				timerNakedAndAfraidCD:Update(15, 30)
				if mod:IsTank() then
					sndWOP:Schedule(11, "ex_mop_clzb") --赤裸準備
					sndWOP:Schedule(12.5, "countthree")
					sndWOP:Schedule(13.5, "counttwo")
					sndWOP:Schedule(14.5, "countone")
				end
			end
		end
		kjzznow = math.modf(yinmoCount/2) + 1
		wjcount = wjcount + 1
		specWarnfuxian:Show(kjzznow, wjcount)
		infowjzz = wjcount
		if (kjzznow == 1) or (wjcount == 2) then
			wjcount = 0
		end
		kjzz = kjzz + kjzznow
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(EJ_GetSectionInfo(6107).."["..kjzznow.."-"..infowjzz.."]: "..kjzz)
		end
	elseif args:IsSpellID(120672) then
		sndWOP:Play("shockwave") --震懾波
		warnImplacableStrike:Show()
		specWarnImplacableStrike:Show()
		strike = 1
		spectimestart()
	elseif args:IsSpellID(120394) and self:AntiSpam(5, 1) then
		if UnitBuff("player", GetSpellInfo(120268)) then
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("stilldanger")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(120047) then
		if not playkbpsound then return end
		kbpscount = 0
	elseif args:IsSpellID(119983) then
		if not playkbpsound then return end
		kbpscount = kbpscount + 1
		if self.Options.pscount then
			if kbpscount == 1 then
				sndWOP:Play("countone") --恐怖噴散計數
			elseif (kbpscount == 2) or (kbpscount == 5) or (kbpscount == 6) or (kbpscount == 10) or (kbpscount == 14) then
				sndWOP:Play("counttwo")
			elseif (kbpscount == 3) or (kbpscount == 7) or (kbpscount == 9) or (kbpscount == 11) or (kbpscount == 15) then
				sndWOP:Play("countthree")
			elseif (kbpscount == 4) or (kbpscount == 8) or (kbpscount == 12) or (kbpscount == 13) or (kbpscount == 16) then
				sndWOP:Play("countfour")
			end
		end
		if MobID == 61046 then
			if (DBM.ShaAssistStarModeChosed == "Dps" and kbpscount == 1) or (DBM.ShaAssistStarModeChosed == "Healther" and kbpscount == 6) then
				MoveWarningLeft:Show() --左
				if not self.Options.pscount then
					sndWOP:Play("moveleft")
				end
			end
		end	
		if MobID == 61042 then
			if (DBM.ShaAssistStarModeChosed == "Dps" and kbpscount == 1) or (DBM.ShaAssistStarModeChosed == "Healther" and kbpscount == 7) then
				MoveWarningRight:Show()  --右
				if not self.Options.pscount then
					sndWOP:Play("moveright")
				end
			end
		end	
		if MobID == 61038 then
			if (DBM.ShaAssistStarModeChosed == "Dps" and kbpscount == 4) or (DBM.ShaAssistStarModeChosed == "Healther" and kbpscount == 4) then
				MoveWarningRight:Show()  --右
				if not self.Options.pscount then
					sndWOP:Play("moveright")
				end
			end
		end
		if kbpscount == 16 then
			if DBM.ShaAssistStarModeChosed == "Dps" or DBM.ShaAssistStarModeChosed == "Healther" then
				MoveWarningBack:Show()
				if not self.Options.pscount then
					sndWOP:Play("end")
				end
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 119108 and self:AntiSpam(2, 3) then
		if not onPlatform then
			warnConjureTerrorSpawns:Show()	
			specWarnTerrorSpawn:Show()
			if mod:IsDps() then
				sndWOP:Play("ex_mop_kdkjzz") --快打恐懼之子
			end
		end
	elseif spellId == 114936 and self:AntiSpam(5, 6) then
		self:UnregisterShortTermEvents()
		self:UnscheduleMethod("CheckPlatformLeaved")
		phase = 2
		onPlatform = false
		timerThrashCD:Cancel()
		timerDreadSpray:Cancel()
		timerDreadSprayCD:Cancel()
		warnBreathOfFearSoon:Cancel()
		timerOminousCackleCD:Cancel()
		timerBreathOfFearCD:Cancel()
		berserkTimer:Cancel()
		berserkTimer:Start()
		timeryinmo:Start(16)
		if mod.Options.InfoFrame and (not mod.Options.InfoFrameTankMode) then
			DBM.InfoFrame:SetHeader(EJ_GetSectionInfo(6107))
			DBM.InfoFrame:Show(10, "playerbaddebuff", 120629)
		end
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:RemoveBoss(61038)
			DBM.BossHealth:RemoveBoss(61042)
			DBM.BossHealth:RemoveBoss(61046)
		end
		sndWOP:Play("phasechange") --階段轉換
		sndWOP:Cancel("ex_mop_tenkj")
		sndWOP:Cancel("countfive")
		sndWOP:Cancel("countfour")
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 61042 or cid == 61046 or cid == 61038 then
		if platformGUIDs[args.destGUID] then
			platformGUIDs[args.destGUID] = nil
			timerDreadSpray:Cancel(args.destGUID)
			timerDreadSprayCD:Cancel(args.destGUID)
			self:UnscheduleMethod("CheckPlatformLeaved")
			self:ScheduleMethod(7, "CheckPlatformLeaved")
			if DBM.BossHealth:IsShown() then
				DBM.BossHealth:RemoveBoss(cid)
			end
		end
	elseif cid == 61003 then
		kjzz = kjzz - 1
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(EJ_GetSectionInfo(6107).."["..kjzznow.."-"..infowjzz.."]: "..kjzz)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 120521 and destGUID == UnitGUID("player") and self:AntiSpam(3, 7) then
		specWarnshuipomove:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 60999 then
		if self:IsDifficulty("heroic10", "heroic25") then
			local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
			if h > 67 and h < 70 and not prewarnedPhase2 then
				sndWOP:Play("ptwo") --2階段準備
				prewarnedPhase2 = true
				warnPhase2Soon:Show()
				self:SendSync("preptwo")
			end
		end
	end
end

function mod:OnSync(msg)
	if msg == "preptwo" then
		if not prewarnedPhase2 then
			sndWOP:Play("ptwo")
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end

function mod:SWING_DAMAGE(sourceGUID)
	local cid = self:GetCIDFromGUID(sourceGUID)
	if cid == 60999 and self:AntiSpam(1, 11) then
		swingcount = swingcount + 1
		if mod.Options.InfoFrameTankMode then
			if phase == 1 then
				DBM.InfoFrame:SetHeader(GetSpellInfo(135088))
			end
			if phase == 2 then
				if swingcount == 0 then
					if ThrashCount == 0 then
						DBM.InfoFrame:Show(1, "other", "", GetSpellInfo(7389)..": "..L.liulian)
					else
						DBM.InfoFrame:Show(1, "other", L.sanlian..": "..ThrashCount, GetSpellInfo(7389)..": "..L.sanlian)
					end
				else
					DBM.InfoFrame:Show(1, "other", L.sanlian..": "..ThrashCount, GetSpellInfo(7389)..": "..swingcount)
				end
			else
				if swingcount == 0 then
					DBM.InfoFrame:Show(1, "other", "", GetSpellInfo(7389)..": "..L.sanlian)
				else
					DBM.InfoFrame:Show(1, "other", "", GetSpellInfo(7389)..": "..swingcount)
				end
			end
		end
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE