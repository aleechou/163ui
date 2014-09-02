local mod	= DBM:NewMod(198, "DBM-Firelands", nil, 78)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(52409)
mod:SetZone()
mod:SetUsedIcons(1, 2)
mod:SetModelSound("Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_AGGRO.wav", "Sound\\Creature\\RAGNAROS\\VO_FL_RAGNAROS_KILL_03.wav")
--Long: blah blah blah (didn't feel like transcribing it)
--Short: This is my realm

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"RAID_BOSS_WHISPER",
	"UNIT_HEALTH",
	"UNIT_AURA",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnRageRagnaros		= mod:NewTargetAnnounce(101110, 3)--Staff quest ability (normal only)
local warnRageRagnarosSoon	= mod:NewAnnounce("warnRageRagnarosSoon", 4, 101109)--Staff quest ability (normal only)
local warnHandRagnaros		= mod:NewSpellAnnounce(98237, 3, nil, mod:IsMelee())--Phase 1 only ability
local warnWrathRagnaros		= mod:NewSpellAnnounce(98263, 3, nil, mod:IsRanged())--Phase 1 only ability
local warnBurningWound		= mod:NewStackAnnounce(99399, 3, nil, false)
local warnSulfurasSmash		= mod:NewSpellAnnounce(98710, 4)--Phase 1-3 ability.
local warnMagmaTrap			= mod:NewTargetAnnounce(98164, 3)--Phase 1 ability.
local warnPhase2Soon		= mod:NewPrePhaseAnnounce(2, 3)
local warnMoltenSeed		= mod:NewSpellAnnounce(98495, 4)--Phase 2 only ability
local warnSplittingBlow		= mod:NewAnnounce("warnSplittingBlow", 3, 98951)
local warnSonsLeft			= mod:NewAddsLeftAnnounce("ej2637", 2, 99014)
local warnEngulfingFlame	= mod:NewAnnounce("warnEngulfingFlame", 4, 99171)
local warnPhase3Soon		= mod:NewPrePhaseAnnounce(3, 3)
local warnBlazingHeat		= mod:NewTargetAnnounce(100460, 4)--Second transition adds ability.
local warnLivingMeteorSoon	= mod:NewPreWarnAnnounce(99268, 10, 3, nil, false)
local warnLivingMeteor		= mod:NewTargetAnnounce(99268, 4)--Phase 3 only ability
local warnBreadthofFrost	= mod:NewCountAnnounce(100479, 2)--Heroic phase 4 ability
local warnCloudBurst		= mod:NewSpellAnnounce(100714, 2)--Heroic phase 4 ability (only casts this once, doesn't seem to need a timer)
local warnEntrappingRoots	= mod:NewSpellAnnounce(100646, 3)--Heroic phase 4 ability
local warnEmpoweredSulf		= mod:NewAnnounce("warnEmpoweredSulf", 4, 100604)--Heroic phase 4 ability
local warnDreadFlame		= mod:NewCountAnnounce(100675, 3, nil, false)--Heroic phase 4 ability

local specWarnSulfurasSmash		= mod:NewSpecialWarningSpell(98710)
local specWarnScorchedGround= mod:NewSpecialWarningMove(98870)--Fire on ground left by Sulfuras Smash
local specWarnMagmaTrap		= mod:NewSpecialWarningMove(98164)
local specWarnMagmaTrapNear	= mod:NewSpecialWarningClose(98164)
local yellMagmaTrap			= mod:NewYell(98164)--May Return false tank yells
local specWarnBurningWound	= mod:NewSpecialWarningStack(99399, mod:IsTank() or mod:IsHealer(), 4)
local specWarnSplittingBlow	= mod:NewSpecialWarningSpell(98951)
local specWarnBlazingHeat	= mod:NewSpecialWarningYou(100460)--Debuff on you
local yellBlazingHeat		= mod:NewYell(100460)
local specWarnBlazingHeatMV	= mod:NewSpecialWarningMove(99144)--Standing in it
local specWarnMoltenSeed	= mod:NewSpecialWarningSpell(98495, nil, nil, nil, true)
local specWarnMeteor		= mod:NewSpecialWarningMove(99268)--Spawning on you
local specWarnMeteorNear	= mod:NewSpecialWarningClose(99268)--Spawning on you
local yellMeteor			= mod:NewYell(99268)
local specWarnFixate		= mod:NewSpecialWarningYou(99849)--Chasing you after it spawned
local yellFixate			= mod:NewYell(99849)
local specWarnWorldofFlames	= mod:NewSpecialWarningSpell(100171, nil, nil, nil, true)
local specWarnDreadFlame	= mod:NewSpecialWarningMove(100941)--Standing in dreadflame
local specWarnEmpoweredSulf	= mod:NewSpecialWarningSpell(100604, mod:IsTank() or mod:IsHealer())--Heroic ability Asuming only the tank cares about this? seems like according to tooltip 5 seconds to hide him into roots?
local specWarnSuperheated	= mod:NewSpecialWarningStack(100593, true, 12)

local timerRageRagnaros		= mod:NewTimer(5, "timerRageRagnaros", 101110)
local timerRageRagnarosCD	= mod:NewNextTimer(60, 101110)
local timerMagmaTrap		= mod:NewCDTimer(25, 98164)		-- Phase 1 only ability. 25-30sec variations.
local timerSulfurasSmash	= mod:NewNextTimer(30, 98710)		-- might even be a "next" timer
local timerHandRagnaros		= mod:NewCDTimer(25, 98237, nil, mod:IsMelee())-- might even be a "next" timer
local timerWrathRagnaros	= mod:NewCDTimer(30, 98263, nil, mod:IsRanged())--It's always 12 seconds after smash unless delayed by magmatrap or hand of rag.
local timerBurningWound		= mod:NewTargetTimer(20, 99399, nil, false)
local timerFlamesCD			= mod:NewNextTimer(40, 99171)
local timerMoltenSeedCD		= mod:NewCDTimer(60, 98495)--60 seconds CD in between from seed to seed. 50 seconds using the molten inferno trigger.
local timerMoltenInferno	= mod:NewNextTimer(10, 98518)--Cast bar for molten Inferno (seeds exploding)
local timerLivingMeteorCD	= mod:NewNextCountTimer(45, 99268)
local timerInvokeSons		= mod:NewCastTimer(17, 99014)--8 seconds for splitting blow, about 8-10 seconds after for them landing, using the average, 9.
local timerLavaBoltCD		= mod:NewNextTimer(4, 98981, nil, false)
local timerBlazingHeatCD	= mod:NewCDTimer(20, 100460)
local timerPhaseSons		= mod:NewTimer(45, "TimerPhaseSons", 99014)	-- lasts 45secs or till all sons are dead
local timerCloudBurstCD		= mod:NewCDTimer(51, 100714)
local timerBreadthofFrostCD	= mod:NewNextCountTimer(45, 100479)
local timerEntrapingRootsCD	= mod:NewCDTimer(56, 100646)--56-60sec variations. Always cast before empowered sulf, varies between 3 sec before and like 11 sec before.
local timerEmpowerdSulfCD	= mod:NewCDTimer(57, 100604)--56-64sec variations
local timerEmpoweredSulf	= mod:NewBuffActiveTimer(10, 100604, nil, mod:IsTank())
local timerDreadFlameCD		= mod:NewNextCountTimer(40, 100675, nil, false)--Off by default as only the people dealing with them care about it.

local berserkTimer			= mod:NewBerserkTimer(1080)
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndBB	= mod:NewSound(nil, "SoundBB", false)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("BlazingHeatIcons", true)
mod:AddBoolOption("InfoHealthFrame", false)--Phase 1 info framefor low health detection.
mod:AddBoolOption("AggroFrame", false)--Phase 2 info frame for seed aggro detection.
mod:AddBoolOption("MeteorFrame", true)--Phase 3 info frame for meteor fixate detection.

local firstSmash = false
local wrathcount = 0
local magmaTrapSpawned = 0
local magmaTrapGUID = {}
local elementalsGUID = {}
local elementalsSpawned = 0
local meteorSpawned = 0
local sonsLeft = 8
local scansDone = 0
local phase = 1
local prewarnedPhase2 = false
local prewarnedPhase3 = false
local blazingHeatIcon = 2
local transphase = false
local seedsActive = false
local meteorWarned = false
local dreadflame = GetSpellInfo(100675)
local meteorTarget = GetSpellInfo(99849)
local staffDebuff = GetSpellInfo(101109)
local seedCast = GetSpellInfo(98333)
local deluge = GetSpellInfo(100713)
local dreadFlameTimer = 45
local bofcount = 1
local dfcount = 1
local seedcount = 0

local function showRangeFrame()
	if UnitDebuff("player", staffDebuff) then return end--Staff debuff, don't change their range finder from 8.
	if mod.Options.RangeFrame then
		if phase == 1 and mod:IsRanged() then
			DBM.RangeCheck:Show(6)--For wrath of rag, only for ranged.
		elseif phase == 2 then
			DBM.RangeCheck:Show(6)--For seeds
		end
	end
end

local function hideRangeFrame()
	if UnitDebuff("player", staffDebuff) then return end--Staff debuff, don't hide it either.
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

local function TransitionEnded()
	timerPhaseSons:Cancel()
	timerLavaBoltCD:Cancel()
	sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
	sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
	sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
	sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
	sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	transphase = false
	if phase == 2 then
		if mod:IsDifficulty("heroic10", "heroic25") then
			timerSulfurasSmash:Start(6)
			sndWOP:Schedule(4, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
			sndWOP:Schedule(11.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\elementsoon.mp3")
			sndWOP:Schedule(12.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(13.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(14.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			timerMoltenSeedCD:Start(15)--14.8-16 variation. We use earliest time for safety.
		else
			timerSulfurasSmash:Start(15.5)
			sndWOP:Schedule(13.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
			sndWOP:Schedule(18, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\elementsoon.mp3")
			sndWOP:Schedule(19, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(20, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(21, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			timerMoltenSeedCD:Start(21.5)--Use the earliest known time, based on my logs is 21.5
		end
		timerFlamesCD:Start()--Probably the only thing that's really consistent.
		sndWOP:Schedule(37, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
		showRangeFrame()--Range 6 for seeds
	elseif phase == 3 then
		timerSulfurasSmash:Start(15.5)--Also a variation.
		sndWOP:Schedule(13.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
		timerFlamesCD:Start(30)
		sndWOP:Schedule(27, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
		warnLivingMeteorSoon:Schedule(35)
		timerLivingMeteorCD:Start(45, 1)
		sndWOP:Schedule(39.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteorsoon.mp3")
		sndWOP:Schedule(41, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Schedule(42, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(43, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(44, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(45, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	elseif phase == 4 then
		timerLivingMeteorCD:Cancel()
		warnLivingMeteorSoon:Cancel()
		timerFlamesCD:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
		timerSulfurasSmash:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteorsoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerBreadthofFrostCD:Start(33, bofcount)
		sndWOP:Schedule(30, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\frostsoon.mp3")
		timerDreadFlameCD:Start(48, dfcount)
		timerCloudBurstCD:Start(51)
		timerEntrapingRootsCD:Start(68)
		timerEmpowerdSulfCD:Start(86)
		if mod:IsTank() or mod:IsHealer() then
			sndWOP:Schedule(83, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\empowersulfsoon.mp3")
		end
		sndWOP:Schedule(7.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(8.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(9.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	end
end

function mod:MagmaTrapTarget(targetname)
	warnMagmaTrap:Show(targetname)
	if targetname == UnitName("player") then
		specWarnMagmaTrap:Show()
		yellMagmaTrap:Yell()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 6 then
				specWarnMagmaTrapNear:Show(targetname)
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			end
		end
	end
end

function mod:LivingMeteorTarget(targetname)
	warnLivingMeteor:Show(targetname)
	if targetname == UnitName("player") then
		specWarnMeteor:Show()
		yellMeteor:Yell()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 12 then
				specWarnMeteorNear:Show(targetname)
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			end
		end
	end
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss1's highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	return false
end

local function warnSeeds()
	seedcount = seedcount + 1
	warnMoltenSeed:Show()
	specWarnMoltenSeed:Show()
	if seedcount == 2 and mod:IsDifficulty("heroic10", "heroic25") then
		timerMoltenSeedCD:Start(64)
	else
		timerMoltenSeedCD:Start()
	end
end

function mod:TargetScanner(SpellID, Force)
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(52409)
	if UnitExists(targetname) then--Check if target exists.
		if isTank(uId) and not Force then--He's targeting his highest threat target.
			if scansDone < 12 then--Make sure no infinite loop.
				self:ScheduleMethod(0.025, "TargetScanner", SpellID)--Check multiple times to be sure it's not on something other then tank.
			else
				if SpellID == 98164 then return end--Magma Traps don't get cast on tanks
				self:TargetScanner(SpellID, true)--It's still on tank, force true isTank and activate else rule and Meteor is on tank.
			end
		else--He's not targeting highest threat target (or isTank was set to true after 12 scans) so this has to be right target.
			self:UnscheduleMethod("TargetScanner")--Unschedule all checks just to be sure none are running, we are done.
			if SpellID == 98164 then
				self:MagmaTrapTarget(targetname)
			else
				self:LivingMeteorTarget(targetname)
			end
		end
	else--target was nil, lets schedule a rescan here too.
		if scansDone < 12 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.025, "TargetScanner", SpellID)
		end
	end
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerWrathRagnaros:Start(6-delay)--4.5-6sec variation, as a result, randomizes whether or not there will be a 2nd wrath before sulfuras smash. (favors not tho)
	timerMagmaTrap:Start(16-delay)
	timerHandRagnaros:Start(-delay)
	timerSulfurasSmash:Start(-delay)
	sndWOP:Schedule(28-delay, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
	wrathcount = 0
	table.wipe(magmaTrapGUID)
	table.wipe(elementalsGUID)
	magmaTrapSpawned = 0
	elementalsSpawned = 0
	meteorSpawned = 0
	sonsLeft = 8
	scansDone = 0
	phase = 1
	firstSmash = false
	prewarnedPhase2 = false
	prewarnedPhase3 = false
	blazingHeatIcon = 2
	transphase = false
	seedsActive = false
	meteorWarned = false
	dreadFlameTimer = 45
	bofcount = 1
	dfcount = 1
	seedcount = 0
	showRangeFrame()
	if self:IsDifficulty("normal10", "normal25") then--register alternate kill detection, he only dies on heroic.
		self:RegisterKill("yell", L.Defeat)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.MeteorFrame or self.Options.InfoHealthFrame or self.Options.AggroFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(99399, 101238, 101239, 101240) then
		warnBurningWound:Show(args.destName, args.amount or 1)
		if (args.amount or 0) >= 4 then
			specWarnBurningWound:Show(args.amount)
		end
		timerBurningWound:Start(args.destName)
	elseif args:IsSpellID(100594, 100915) and args:IsPlayer() then
		if (args.amount or 0) >= 12 and args.amount % 4 == 0 then
			specWarnSuperheated:Show(args.amount)
		end
	elseif args:IsSpellID(100171, 100190) then--World of Flames, heroic version for engulfing flames.
		specWarnWorldofFlames:Show()
		if phase == 3 then
			timerFlamesCD:Start(30)--30 second CD in phase 3
			sndWOP:Schedule(27, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
		else
			timerFlamesCD:Start(61)--40 second CD in phase 2
			sndWOP:Schedule(58, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
		end
	elseif args:IsSpellID(100604, 100997) then
		warnEmpoweredSulf:Show(args.spellName)
		specWarnEmpoweredSulf:Show()
		timerEmpoweredSulf:Schedule(5)--Schedule 10 second bar to start when cast ends for buff active timer.
		timerEmpowerdSulfCD:Start()
		if self:IsTank() or self:IsHealer() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\empowersulf.mp3")
			sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(4.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			sndWOP:Schedule(54, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\empowersulfsoon.mp3")
		end		
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(99399, 101238, 101239, 101240) and not transphase then
		timerBurningWound:Cancel(args.destName)
		if self:IsTank() or self:IsHealer() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3")
		end	
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(98710, 100890, 100891, 100892) then
		firstSmash = true
		warnSulfurasSmash:Show()
		specWarnSulfurasSmash:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firewall.mp3")
		if phase == 1 or phase == 3 then
			timerSulfurasSmash:Start()--30 second cd in phase 1 and phase 3 in 3/4 difficulties
			sndWOP:Schedule(28, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
		else
			timerSulfurasSmash:Start(40)--40 seconds in phase 2
			sndWOP:Schedule(38, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
		end
	elseif args:IsSpellID(98951, 100883, 100884, 100885) or args:IsSpellID(98952, 100877, 100878, 100879) or args:IsSpellID(98953, 100880, 100881, 100882) then--This has 12 spellids, 1 for each possible location for hammer.
		sonsLeft = 8
		phase = phase + 1
		self:Unschedule(warnSeeds)
		if phase == 3 then
			timerFlamesCD:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
			timerMoltenSeedCD:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\elementsoon.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")		
		end
		transphase = true
		timerMagmaTrap:Cancel()
		timerSulfurasSmash:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firecirclesoon.mp3")
		timerHandRagnaros:Cancel()
		timerWrathRagnaros:Cancel()
		timerFlamesCD:Cancel()
		hideRangeFrame()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerPhaseSons:Start(60)--Longer on heroic
			sndWOP:Schedule(55, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(56, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(57, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(58, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(59, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		else
			timerPhaseSons:Start(60)--45 sec plus the 2 or so seconds he takes to actually come up and yell.
		end
		specWarnSplittingBlow:Show()
		timerInvokeSons:Start()
		timerLavaBoltCD:Start(17.3)--9.3 seconds + cast time for splitting blow
		--In 5.0 they remove all but 98951, 98952, 98953
		if args:IsSpellID(98951, 100883, 100884, 100885) then--West
			warnSplittingBlow:Show(args.spellName, L.West)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\hammerleft.mp3")
		elseif args:IsSpellID(98952, 100877, 100878, 100879) then--Middle
			warnSplittingBlow:Show(args.spellName, L.Middle)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\hammermiddle.mp3")
		elseif args:IsSpellID(98953, 100880, 100881, 100882) then--East
			warnSplittingBlow:Show(args.spellName, L.East)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\hammerright.mp3")
		end
	elseif args:IsSpellID(99172, 100175, 100176, 100177) or args:IsSpellID(99235, 100178, 100179, 100180) or args:IsSpellID(99236, 100181, 100182, 100183) then--Another scripted spell with a ton of spellids based on location of room. heroic purposely excluded do to different mechanic linked to World of Flames that will be used instead.
		if self:IsDifficulty("normal10", "normal25") then
			if phase == 3 then
				timerFlamesCD:Start(30)--30 second CD in phase 3
				sndWOP:Schedule(27, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
			else
				timerFlamesCD:Start()--40 second CD in phase 2
				sndWOP:Schedule(37, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerepeat.mp3")
			end
		end
		--North: 99172 (10N), 100175 (25N), 100176 (10H), 100177 (25H)
		--Middle: 99235 (10N), 100178 (25N), 100179 (10H), 100180 (25H)
		--South: 99236 (10N), 100181 (25N), 100182 (10H), 100183 (25H)
		if args:IsSpellID(99172, 100175, 100176, 100177) then--North
			warnEngulfingFlame:Show(args.spellName, L.North)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamemelee.mp3")
		elseif args:IsSpellID(99235, 100178, 100179, 100180) then--Middle
			warnEngulfingFlame:Show(args.spellName, L.Middle)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamemiddle.mp3")
		elseif args:IsSpellID(99236, 100181, 100182, 100183) then--South
			warnEngulfingFlame:Show(args.spellName, L.South)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\flamerange.mp3")
		end
	elseif args:IsSpellID(100646) then
		warnEntrappingRoots:Show()
		timerEntrapingRootsCD:Start()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\rootnow.mp3")
	elseif args:IsSpellID(100479) then
		warnBreadthofFrost:Show(bofcount)
		bofcount = bofcount + 1
		timerBreadthofFrostCD:Start(45, bofcount)
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\frostappear.mp3")
		sndWOP:Schedule(42, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\"..GetLocale().."\\frostsoon.mp3")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(98237, 100383, 100384, 100387) and not args:IsSrcTypePlayer() then -- can be stolen which triggers a new SPELL_CAST_SUCCESS event...
		warnHandRagnaros:Show()
		timerHandRagnaros:Start()
	elseif args:IsSpellID(98164) then	--98164 confirmed
		magmaTrapSpawned = magmaTrapSpawned + 1
		scansDone = 0
		timerMagmaTrap:Start()
		self:TargetScanner(98164)
		if self.Options.InfoHealthFrame and not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(L.HealthInfo)
			DBM.InfoFrame:Show(5, "health", 100000)
		end
	elseif args:IsSpellID(98263, 100113, 100114, 100115) and self:AntiSpam(4, 1) then
		warnWrathRagnaros:Show()
		--Wrath of Ragnaros has a 25 second cd if 2 happen before first smash, otherwise it's 30.
		--In this elaborate function we count the wraths before first smash
		--As well as even dynamically start correct timer based on when first one was cast so people know right away if there will be a 2nd before smash
		if not firstSmash then--First smash hasn't happened yet
			wrathcount = wrathcount + 1--So count wraths
		end
		if GetTime() - self.combatInfo.pull <= 5 or wrathcount == 2 then--We check if there were two wraths before smash, or if pull was within last 5 seconds.
			timerWrathRagnaros:Start(25)--if yes to either, this bar is always 25 seconds.
		else--First wrath was after 5 second mark and wrathcount not 2 so we have a 30 second cd wrath.
			if firstSmash then--Check if first smash happened yet to determine at this point whether to start a 30 second bar or the one time only 36 bar.
				timerWrathRagnaros:Start()--First smash already happened so it's later fight and this is always gonna be 30.
			else
				timerWrathRagnaros:Start(36)--First smash didn't happen yet, and first wrath happened later then 5 seconds into pull, 2nd smash will be delayed by sulfuras smash.
			end
		end
	elseif args:IsSpellID(100460, 100981, 100982, 100983) then	-- Blazing heat
		warnBlazingHeat:Show(args.destName)
		timerBlazingHeatCD:Start(args.sourceGUID)--args.sourceGUID is to support multiple cds when more then 1 is up at once
		if args:IsPlayer() then
			specWarnBlazingHeat:Show()
			yellBlazingHeat:Yell()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\justrun.mp3")
		end
		if self.Options.BlazingHeatIcons then
			self:SetIcon(args.destName, blazingHeatIcon, 8)
			if blazingHeatIcon == 2 then-- Alternate icons, they are cast too far apart to sort in a table or do icons at once, and there are 2 adds up so we need to do it this way.
				blazingHeatIcon = 1
			else
				blazingHeatIcon = 2
			end
		end
	elseif args:IsSpellID(99268) then
		meteorSpawned = meteorSpawned + 1
		if meteorSpawned == 1 or meteorSpawned % 2 == 0 then--Spam filter, announce at 1, 2, 4, 6, 8, 10 etc. The way that they spawn
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteorrun.mp3")
			scansDone = 0
			self:TargetScanner(99268)
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteorsoon.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			timerLivingMeteorCD:Start(45, meteorSpawned+1)--Start new one with new count.
			sndWOP:Schedule(39.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteorsoon.mp3")
			sndWOP:Schedule(41, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(42, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(43, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(44, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(45, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			warnLivingMeteorSoon:Schedule(35)
		end		
		if self.Options.MeteorFrame and meteorSpawned == 1 then--Show meteor frame and clear any health or aggro frame because nothing is more important then meteors.
			DBM.InfoFrame:SetHeader(L.MeteorTargets)
			DBM.InfoFrame:Show(6, "playerbaddebuff", 99849)--If you get more then 6 chances are you're screwed unless it's normal mode and he's at like 11%. Really anything more then 4 is chaos and wipe waiting to happen.
		end
	elseif args:IsSpellID(100714) then
		warnCloudBurst:Show()
		sndBB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\bbappear.mp3")
	elseif args:IsSpellID(101110) then
		warnRageRagnaros:Show(args.destName)
		if self.Options.RangeFrame and args:IsPlayer() then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 98518 or spellId == 100252 or spellId == 100253 or spellId == 100254) and not elementalsGUID[sourceGUID] then--Molten Inferno. elementals cast this on spawn.
		elementalsGUID[sourceGUID] = true--Add unit GUID's to ignore
		elementalsSpawned = elementalsSpawned + 1--Add up the total elementals
	elseif (spellId == 98175 or spellId == 100106 or spellId == 100107 or spellId == 100108) and not magmaTrapGUID[sourceGUID] then--Magma Trap Eruption. We use it to count traps that have been set off
		magmaTrapGUID[sourceGUID] = true--Add unit GUID's to ignore
		magmaTrapSpawned = magmaTrapSpawned - 1--Add up total traps
		if magmaTrapSpawned == 0 and self.Options.InfoHealthFrame and not seedsActive then--All traps are gone hide the health frame.
			DBM.InfoFrame:Hide()
		end
	elseif (spellId == 98870 or spellId == 100122 or spellId == 100123 or spellId == 100124) and destGUID == UnitGUID("player") and self:AntiSpam(5, 2) then
		specWarnScorchedGround:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif (spellId == 99144 or spellId == 100303 or spellId == 100304 or spellId == 100305) and destGUID == UnitGUID("player") and self:AntiSpam(5, 2) then
		specWarnBlazingHeatMV:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif (spellId == 100941 or spellId == 100998) and destGUID == UnitGUID("player") and self:AntiSpam(5, 2) and not UnitBuff("player", deluge) then
		specWarnDreadFlame:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif (spellId == 98981 or spellId == 100289 or spellId == 100290 or spellId == 100291) and self:AntiSpam(3, 1) then
		timerLavaBoltCD:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE--Have to track absorbs too for this method to work.

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.TransitionEnded1 or msg:find(L.TransitionEnded1) or msg == L.TransitionEnded2 or msg:find(L.TransitionEnded2) or msg == L.TransitionEnded3 or msg:find(L.TransitionEnded3) then--This is more reliable then adds which may or may not add up to 8 cause blizz sucks. Plus it's more precise anyways, timers seem more consistent with this method.
		TransitionEnded()
	elseif (msg == L.Phase4 or msg:find(L.Phase4)) and self:IsInCombat() then
		phase = 4
		TransitionEnded()--Easier to just trigger this and keep all phase change stuff in one place.
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find(dreadflame) then--This is more reliable then adds which may or may not add up to 8 cause blizz sucks. Plus it's more precise anyways, timers seem more consistent with this method.
		if dreadFlameTimer > 15 then
			dreadFlameTimer = dreadFlameTimer - 5
		end
		warnDreadFlame:Show(dfcount)
		dfcount = dfcount + 1
		sndBB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\firearound.mp3")
		timerDreadFlameCD:Start(dreadFlameTimer, dfcount)
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find(staffDebuff) then--Only person with staff sees this.
		self:SendSync("RageOfRagnaros", UnitName("player"))--Send it out so others can get notice too.
	end
end

function mod:OnSync(event, target)
	if event == "RageOfRagnaros" then
		warnRageRagnarosSoon:Show(staffDebuff, target)
		timerRageRagnaros:Start(5, staffDebuff, target)
		timerRageRagnarosCD:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 52409 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 80 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 72 and h < 75 and not prewarnedPhase2 then
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		elseif h > 50 and prewarnedPhase3 then
			prewarnedPhase3 = false
		elseif h > 42 and h < 45 and not prewarnedPhase3 then
			prewarnedPhase3 = true
			warnPhase3Soon:Show()
		end
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", meteorTarget) and not meteorWarned then--Warn you that you have a meteor
		specWarnFixate:Show()
		yellFixate:Yell()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\meteoryou.mp3")
		meteorWarned = true
	elseif not UnitDebuff("player", meteorTarget) and meteorWarned then--reset warned status if you don't have debuff
		meteorWarned = false
	end
end

local function clearSeedsActive()
	seedsActive = false
	if seedcount == 2 and mod:IsDifficulty("heroic10", "heroic25") then
		sndWOP:Schedule(43.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\elementsoon.mp3")
		sndWOP:Schedule(44.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(45.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(46.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	else
		sndWOP:Schedule(39.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\elementsoon.mp3")
		sndWOP:Schedule(40.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(41.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(42.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == seedCast and not seedsActive then -- The true molten seeds cast.
		seedsActive = true
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\justrun.mp3")
		timerMoltenInferno:Start(11.5)--1.5-2.5 variation, we use lowest +10 seconds
		sndWOP:Schedule(9, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(10, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(11, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		warnSeeds()
		self:Schedule(17.5, clearSeedsActive)--Clear active/warned seeds after they have all blown up.
		if self.Options.AggroFrame then--Show aggro frame regardless if health frame is still up, it should be more important than health frame at this point. Shouldn't be blowing up traps while elementals are up.
			DBM.InfoFrame:SetHeader(L.HasNoAggro)
			if self:IsDifficulty("normal25", "heroic25") then
				DBM.InfoFrame:Show(10, "playeraggro", 0)--20 man has at least 5 targets without aggro, often more do to immunities. because of it's size, it's now off by default.
			else
				DBM.InfoFrame:Show(5, "playeraggro", 0)
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 53140 then--Son of Flame
		sonsLeft = sonsLeft - 1
		if sonsLeft < 3 then
			warnSonsLeft:Show(sonsLeft)
		end
	elseif cid == 53500 then--Meteors
		meteorSpawned = meteorSpawned - 1
		if meteorSpawned == 0 and self.Options.MeteorFrame then--Meteors all gone, hide info frame
			DBM.InfoFrame:Hide()
			if magmaTrapSpawned >= 1 and self.Options.InfoHealthFrame then--If traps are still up we restore the health frame (why on earth traps would still up in phase 4 is beyond me).
				DBM.InfoFrame:SetHeader(L.HealthInfo)
				DBM.InfoFrame:Show(5, "health", 100000)
			end
		end	
	elseif cid == 53189 then--Molten elemental
		elementalsSpawned = elementalsSpawned - 1
		if elementalsSpawned == 0 and self.Options.AggroFrame then--Elementals all gone, hide info frame
			DBM.InfoFrame:Hide()
			if magmaTrapSpawned >= 1 and self.Options.InfoHealthFrame then--If traps are still up we restore the health frame.
				DBM.InfoFrame:SetHeader(L.HealthInfo)
				DBM.InfoFrame:Show(5, "health", 100000)
			end
		end
	elseif cid == 53231 then--Lava Scion
		timerBlazingHeatCD:Cancel(args.sourceGUID)
	end
end