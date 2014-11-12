﻿local mod	= DBM:NewMod(853, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11372 $"):sub(12, -3))
mod:SetCreatureID(71152, 71153, 71154, 71155, 71156, 71157, 71158, 71160, 71161)
mod:SetEncounterID(1593)
mod:SetMinSyncRevision(10768)
mod:SetHotfixNoticeRev(10768)
mod:SetZone()
mod:SetUsedIcons(3, 1)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
)

----------------------------------------------------------------------------------------------------------------------------------------
-- A moment of silence to remember Malik the Unscathed, the 10th paragon that perished an honorable death in battle against Shek'zeer --
----------------------------------------------------------------------------------------------------------------------------------------
--All
local warnActivated					= mod:NewTargetAnnounce(118212, 3, 143542)
--Kil'ruk the Wind-Reaver
local warnGouge						= mod:NewTargetAnnounce(143939, 3, nil, mod:IsTank() or mod:IsHealer())--Timing too variable for a CD
local warnDeathFromAbove			= mod:NewTargetAnnounce(142232, 3)
local warnReave						= mod:NewCastAnnounce(148676, 3)
--Xaril the Poisoned-Mind
local warnToxicInjection			= mod:NewSpellAnnounce(142528, 3)
local warnCausticBlood				= mod:NewSpellAnnounce(142315, 4, nil, mod:IsTank(), nil, nil, nil, nil, 2)
mod:AddBoolOption("warnToxicCatalyst", true, "announce")
local warnToxicCatalystBlue			= mod:NewCastAnnounce(142725, 4, nil, nil, nil, false)
local warnToxicCatalystRed			= mod:NewCastAnnounce(142726, 4, nil, nil, nil, false)
local warnToxicCatalystYellow		= mod:NewCastAnnounce(142727, 4, nil, nil, nil, false)
local warnToxicCatalystOrange		= mod:NewCastAnnounce(142728, 4, nil, nil, nil, false)--Heroic
local warnToxicCatalystPurple		= mod:NewCastAnnounce(142729, 4, nil, nil, nil, false)--Heroic
local warnToxicCatalystGreen		= mod:NewCastAnnounce(142730, 4, nil, nil, nil, false)--Heroic
--local warnToxicCatalystWhite		= mod:NewCastAnnounce(142731, 3, nil, nil, nil, false)--Not in EJ
--Kaz'tik the Manipulator
local warnMesmerize					= mod:NewTargetAnnounce(142671, 3)
local warnSonicProjection			= mod:NewSpellAnnounce(143765, 3, nil, false)--Spammy, and target scaning didn't work
--Korven the Prime
local warnShieldBash				= mod:NewSpellAnnounce(143974, 3, nil, mod:IsTank() or mod:IsHealer())
local warnEncaseInAmber				= mod:NewTargetAnnounce(142564, 4)
--Iyyokuk the Lucid
local warnDiminish					= mod:NewSpellAnnounce(143666, 4, nil, false)--Spammy, target scanning was iffy
local warnCalculated				= mod:NewTargetAnnounce(144095, 3)--Wild variation on timing noted, 34-130.8 variation (wtf)
local warnInsaneCalculationFire		= mod:NewCastAnnounce(142416, 4)--3 seconds after 144095
--Ka'roz the Locust
local warnFlash						= mod:NewCastAnnounce(143709, 3, 2)--62-70
local warnWhirling					= mod:NewTargetAnnounce(143702, 3)
local warnHurlAmber					= mod:NewSpellAnnounce(143759, 3)
--Skeer the Bloodseeker
local warnBloodletting				= mod:NewSpellAnnounce(143280, 4)
--Rik'kal the Dissector
local warnInjection					= mod:NewStackAnnounce(143339)
local warnMutate					= mod:NewTargetAnnounce(143337, 3)

local warnResult					= mod:NewTargetAnnounce(144095, 3)
--Hisek the Swarmkeeper
local warnAim						= mod:NewTargetAnnounce(142948, 4)--Maybe wrong debuff id, maybe 144759 instead
local warnRapidFire					= mod:NewSpellAnnounce(143243, 3)

--All
--NOTE, this is purely off assumption the ones that make you vunerable to eachother don't spawn at same time.
--It's also possible tehse tank only activate warnings are useless if 4 vulnerability mobs always spawns in pairs
--Then it just means it's an anti solo tank mechanic and we don't need special warnings for it.
local specWarnActivated				= mod:NewSpecialWarningTarget(118212)
local specWarnActivatedVulnerable	= mod:NewSpecialWarning("specWarnActivatedVulnerable", mod:IsTank())--Alternate activate warning to warn a tank not to pick up a specific boss
--Kil'ruk the Wind-Reaver
local specWarnGouge					= mod:NewSpecialWarningYou(143939)
local specWarnGougeOther			= mod:NewSpecialWarningTarget(143939, mod:IsTank() or mod:IsHealer())
local specWarnDeathFromAbove		= mod:NewSpecialWarningYou(142232)
local specWarnDeathFromAboveNear	= mod:NewSpecialWarningClose(142232)
local yellDeathFromAbove			= mod:NewYell(142232)
local specWarnReave					= mod:NewSpecialWarningSpell(148676, nil, nil, nil, 2)--Heroic
--Xaril the Poisoned-Mind
local specWarnCausticBlood			= mod:NewSpecialWarningSpell(142315, mod:IsTank())
local specWarnToxicBlue				= mod:NewSpecialWarningYou(142532)
local specWarnToxicRed				= mod:NewSpecialWarningYou(142533)
local specWarnToxicYellow			= mod:NewSpecialWarningYou(142534)
--local specWarnToxicOrange			= mod:NewSpecialWarningYou(142547)--Heroic
--local specWarnToxicPurple			= mod:NewSpecialWarningYou(142548)--Heroic
--local specWarnToxicGreen			= mod:NewSpecialWarningYou(142549)--Heroic
local specWarnGas					= mod:NewSpecialWarningMove(142797)--BH ADD
--local specWarnToxicWhite			= mod:NewSpecialWarningYou(142550)--Not in EJ
local specWarnCatalystBlue			= mod:NewSpecialWarningYou(142725, nil, nil, nil, 3)
local specWarnCatalystRed			= mod:NewSpecialWarningYou(142726, nil, nil, nil, 3)
local specWarnCatalystYellow		= mod:NewSpecialWarningYou(142727, nil, nil, nil, 3)
local specWarnCatalystOrange		= mod:NewSpecialWarningYou(142728, nil, nil, nil, 3)--Heroic
local specWarnCatalystPurple		= mod:NewSpecialWarningYou(142729, nil, nil, nil, 3)--Heroic
local specWarnCatalystGreen			= mod:NewSpecialWarningYou(142730, nil, nil, nil, 3)--Heroic
--local specWarnCatalystWhite		= mod:NewSpecialWarningYou(142731, nil, nil, nil, 3)--Not in EJ
mod:AddBoolOption("yellToxicCatalyst", true, "misc")--And lastly, combine yells
local yellCatalystBlue				= mod:NewYell(142725, nil, nil, false)
local yellCatalystRed				= mod:NewYell(142726, nil, nil, false)
local yellCatalystYellow			= mod:NewYell(142727, nil, nil, false)
local yellCatalystOrange			= mod:NewYell(142728, nil, nil, false)
local yellCatalystPurple			= mod:NewYell(142729, nil, nil, false)
local yellCatalystGreen				= mod:NewYell(142730, nil, nil, false)
--Kaz'tik the Manipulator
local specWarnMesmerize				= mod:NewSpecialWarningYou(142671)
local yellMesmerize					= mod:NewYell(142671, nil, false)
local specWarnKunchongs				= mod:NewSpecialWarningSwitch("ej8043", mod:IsDps())
--Korven the Prime
local specWarnShieldBash			= mod:NewSpecialWarningYou(143974)
local specWarnShieldBashOther		= mod:NewSpecialWarningTarget(143974, mod:IsTank() or mod:IsHealer())
local specWarnEncaseInAmber			= mod:NewSpecialWarningTarget(142564, mod:IsDps())--Better than switch because on heroic, you don't actually switch to amber, you switch to a NON amber target. Plus switch gives no targetname
--Iyyokuk the Lucid
local specWarnCalculated			= mod:NewSpecialWarningYou(144095)
local yellCalculated				= mod:NewYell(144095, nil, false)
local specWarnCriteriaLinked		= mod:NewSpecialWarning("specWarnCriteriaLinked")--Linked to Calculated target
local specWarnInsaneCalculationFire	= mod:NewSpecialWarningSpell(142416, nil, nil, nil, 2)
--Ka'roz the Locust
local specWarnFlash					= mod:NewSpecialWarningSpell(143709, nil, nil, nil, 2)--I realize two abilities on same boss both using same sound is less than ideal, but user can change it now, and 1 or 3 feel appropriate for both of these
local specWarnWhirling				= mod:NewSpecialWarningYou(143701)
local yellWhirling					= mod:NewYell(143701, nil, false)
local specWarnWhirlingNear			= mod:NewSpecialWarningClose(143701)
local specWarnHurlAmber				= mod:NewSpecialWarningSpell(143759, nil, nil, nil, 2)--I realize two abilities on same boss both using same sound is less than ideal, but user can change it now, and 1 or 3 feel appropriate for both of these
local specWarnCausticAmber			= mod:NewSpecialWarningMove(143735)--Stuff on the ground
local specWarnFireline				= mod:NewSpecialWarningMove(142808)
--Skeer the Bloodseeker
local specWarnBloodletting			= mod:NewSpecialWarningSwitch(143280, not mod:IsHealer())
--Rik'kal the Dissector
local specWarnMutate				= mod:NewSpecialWarningYou(143337)
local specWarnParasiteFixate		= mod:NewSpecialWarningYou(143358)
local specWarnInjection				= mod:NewSpecialWarningSpell(143339, mod:IsTank(), nil, nil, 3)
--Hisek the Swarmkeeper
local specWarnAim					= mod:NewSpecialWarningYou(142948)
local yellAim						= mod:NewYell(142948)
local specWarnAimOther				= mod:NewSpecialWarningTarget(142948)
local specWarnRapidFire				= mod:NewSpecialWarningSpell(143243, nil, nil, nil, 2)

local timerJumpToCenter				= mod:NewCastTimer(5, 143545)
--Kil'ruk the Wind-Reaver
local timerGouge					= mod:NewTargetTimer(10, 143939, nil, mod:IsTank())
local timerGougeCD					= mod:NewCDTimer(20, 143939)
local timerReaveCD					= mod:NewCDTimer(33, 148676)
--Xaril the Poisoned-Mind
local timerToxicCatalystCD			= mod:NewCDTimer(33, "ej8036")
--Korven the Prime
local timerShieldBash				= mod:NewTargetTimer(6, 143974, nil, mod:IsTank())
local timerShieldBashCD				= mod:NewCDTimer(17, 143974, nil, mod:IsTank())
local timerEncaseInAmber			= mod:NewTargetTimer(10, 142564)
local timerEncaseInAmberCD			= mod:NewCDTimer(30, 142564)--Technically a next timer but we use cd cause it's only cast if someone is low when it comes off 30 second internal cd. VERY important timer for heroic
--Iyyokuk the Lucid
local timerCalculated				= mod:NewBuffFadesTimer(6, 144095)
local timerInsaneCalculationCD		= mod:NewCDTimer(25, 142416)--25 is minimum but variation is wild (25-50 second variation)
--Ka'roz the Locust
local timerFlashCD					= mod:NewCDTimer(62, 143709)
local timerWhirling					= mod:NewBuffFadesTimer(5, 143701)
local timerHurlAmberCD				= mod:NewCDTimer(62, 143759)--TODO< verify cd on spell itself. in my logs he died after only casting it once every time.
--Skeer the Bloodseeker
local timerBloodlettingCD			= mod:NewCDTimer(35, 143280)--35-65 variable. most of the time it's around 42 range
--Rik'kal the Dissector
local timerMutate					= mod:NewBuffFadesTimer(20, 143337)
local timerMutateCD					= mod:NewCDCountTimer(45, 143337)
local timerInjectionCD				= mod:NewNextCountTimer(9.5, 143339, nil, mod:IsTank())
--Hisek the Swarmkeeper
local timerAim						= mod:NewTargetTimer(5, 142948)--or is it 7, conflicting tooltips
local timerAimCD					= mod:NewCDTimer(42, 142948)
local timerRapidFireCD				= mod:NewCDTimer(47, 143243)--Heroic, unknown Cd

local berserkTimer					= mod:NewBerserkTimer(720)

--local countdownEncaseInAmber		= mod:NewCountdown(30, 142564)--Probably switch to secondary countdown if one of his other abilities proves to have priority

local twipe = table.wipe

local chongnum = 0
local firecount = 0
local injcount = 0
local mutatecount = 0
local dissectorlive = true

local showtank = false
local xiezireset = 0

local havecolor = false
local caled = false
local havedebuff = false

mod:AddBoolOption("LTIP", true, "sound")
mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnAim", true)--multi boss fight, will use star and avoid moving skull off a kill target
mod:AddBoolOption("LTchong", mod:IsTank(), "sound")
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("ShowGrouptarget", true, "sound")
mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudMAPMZ", true, "sound")

mod:AddBoolOption("dr", true, "sound")
for i = 1, 6 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

local function MyJS()
	if (mod.Options.dr1 and firecount == 1) or (mod.Options.dr2 and firecount == 2) or (mod.Options.dr3 and firecount == 3) or (mod.Options.dr4 and firecount == 4) or (mod.Options.dr5 and firecount == 5) or (mod.Options.dr6 and firecount == 6) then
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
local RedMarkers={}
local BlueMarkers={}
local YellowMarkers={}
local MZMarkers={}
local DFMarker={}
local CMMarkers={}

local activatedTargets = {}--A table, for the 3 on pull
local mutateTargets = {}
local activeBossGUIDS = {}
local UnitDebuff = UnitDebuff
local GetSpellInfo = GetSpellInfo
local calculatedShape = nil
local calculatedNumber = nil
local calculatedColor = nil
local calculatingDude = EJ_GetSectionInfo(8012)
local readyToFight = GetSpellInfo(143542)

local bossspellinfo = {}

local xiezi = {}

local ResultTargets = {}
local ResultMeleeTargets = {}
local ResultRangedTargets = {}
local ResultRangedDPSTargets = {}
local ResultGroupTargets = {}

local myGroup = 0

local ResultXFTargets = {}

--[[EJ_GetSectionInfo(8004) --掠风者 71161
EJ_GetSectionInfo(8009) 	--毒心者 71157
EJ_GetSectionInfo(8010) 	--操纵者 71156
EJ_GetSectionInfo(8011) 	--至尊者 71155
EJ_GetSectionInfo(8012) 	--明澈者 71160
EJ_GetSectionInfo(8013) 	--暴食蝗 71154
EJ_GetSectionInfo(8014) 	--觅血者 71152
EJ_GetSectionInfo(8015) 	--切割者 71158
EJ_GetSectionInfo(8016) 	--虫群卫士 71153 ]]

local function showspellinfo()
	if mod:IsDifficulty("heroic25") then return end
	if mod.Options.InfoFrame then
		twipe(bossspellinfo)
		local onlyactboss = 0
		for i = 1, 5 do
			local cid = mod:GetCIDFromGUID(UnitGUID("boss"..i))
			if cid == 71161 then
				bossspellinfo[i] = {name = L.LF, spell = L.LFspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71157 then
				bossspellinfo[i] = {name = L.DX, spell = L.DXspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71156 then
				bossspellinfo[i] = {name = L.CZ, spell = L.CZspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71155 then
				bossspellinfo[i] = {name = L.ZZ, spell = L.ZZspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71160 then
				bossspellinfo[i] = {name = L.MC, spell = L.MCspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71154 then
				bossspellinfo[i] = {name = L.BS, spell = L.BSspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71152 then
				bossspellinfo[i] = {name = L.MX, spell = L.MXspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71158 then
				bossspellinfo[i] = {name = L.QG, spell = L.QGspell}
				onlyactboss = onlyactboss + 1
			elseif cid == 71153 then
				bossspellinfo[i] = {name = L.CQ, spell = L.CQspell}
				onlyactboss = onlyactboss + 1
			end
			if onlyactboss == 3 then break end
		end
		local bossnum = 0
		for k,v in pairs(bossspellinfo) do
			bossnum = bossnum + 1
		end
		DBM.InfoFrame:SetHeader(L.BossSpellInfo)
		local firstboss = 1
		if not bossspellinfo[1] then firstboss = 2 end
		if bossnum == 1 then
			DBM.InfoFrame:Show(1, "other", bossspellinfo[firstboss].spell, bossspellinfo[firstboss].name)
		elseif bossnum == 2 then
			DBM.InfoFrame:Show(2, "other", bossspellinfo[firstboss].spell, bossspellinfo[firstboss].name, bossspellinfo[firstboss + 1].spell, bossspellinfo[firstboss + 1].name)
		elseif bossnum == 3 then
			DBM.InfoFrame:Show(3, "other", bossspellinfo[firstboss].spell, bossspellinfo[firstboss].name, bossspellinfo[firstboss + 1].spell, bossspellinfo[firstboss + 1].name, bossspellinfo[firstboss + 2].spell, bossspellinfo[firstboss + 2].name)
		end
	end
end

local function testinfo()
	if not mod:IsDifficulty("heroic25") then return end
	local showxiezi = {}
	local xiezinum = 0
	for k,v in pairs(xiezi) do
		xiezinum = xiezinum + 1
		showxiezi[xiezinum] = k
	end
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
		DBM.InfoFrame:SetHeader(EJ_GetSectionInfo(8065).." : "..chongnum)
		if showxiezi[3] then
			DBM.InfoFrame:Show(3, "other", xiezi[showxiezi[1]], showxiezi[1], xiezi[showxiezi[2]], showxiezi[2], xiezi[showxiezi[3]], showxiezi[3])
		end
		if (not dissectorlive) and (chongnum == 0) then			
			DBM.InfoFrame:Hide()
		end
	end	
	twipe(showxiezi)
	xiezinum = 0
end

local function warnActivatedTargets(vulnerable)
	if #activatedTargets > 1 then
		warnActivated:Show(table.concat(activatedTargets, "<, >"))
--		specWarnActivated:Show(table.concat(activatedTargets, ", "))
	else
		warnActivated:Show(activatedTargets[1])
		if vulnerable and mod:IsTank() then
			specWarnActivatedVulnerable:Show(activatedTargets[1])
		else
			specWarnActivated:Show(activatedTargets[1])
		end
	end
	twipe(activatedTargets)
end

local function warnMutatedTargets()	
	warnMutate:Show(table.concat(mutateTargets, "<, >"))	
	twipe(mutateTargets)
	if mod:AntiSpam(5, 1) then
		mutatecount = mutatecount + 1
		sndWOP:Play("ex_so_tb") --突變
		if mutatecount == 1 then
			sndWOP:Schedule(0.5, "countone")
		elseif mutatecount == 2 then
			sndWOP:Schedule(0.5, "counttwo")
		elseif mutatecount == 3 then
			sndWOP:Schedule(0.5, "countthree")
		elseif mutatecount == 4 then
			sndWOP:Schedule(0.5, "countfour")
		elseif mutatecount == 5 then
			sndWOP:Schedule(0.5, "countfive")
		elseif mutatecount == 6 then
			sndWOP:Schedule(0.5, "countsix")
		end
		timerMutateCD:Start(45, mutatecount+1)
	end
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

--Another pre target scan (ie targets player BEFORE cast like iron qon)
local function DFAScan()
	for i = 1, 5 do
		local unitID = "boss"..i
		if UnitExists(unitID) and mod:GetCIDFromGUID(UnitGUID(unitID)) == 71161 then
			if UnitExists(unitID.."target") and not mod:IsTanking(unitID.."target", unitID) then
				mod:Unschedule(DFAScan)
				local targetname = DBM:GetUnitFullName(unitID.."target")
				warnDeathFromAbove:Show(targetname)
				if UnitIsUnit(unitID.."target", "player") then
					specWarnDeathFromAbove:Show()
					yellDeathFromAbove:Yell()
					sndWOP:Play("runaway") --快躲開
				else
					local x, y = GetPlayerMapPosition(unitID.."target")
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(unitID.."target")
					end
					local inRange = DBM.RangeCheck:GetDistance("player", x, y)
					if inRange and inRange < 6 then
						specWarnDeathFromAboveNear:Show(targetname)
						sndWOP:Play("runaway") --快躲開
					end
				end
				if mod.Options.HudMAPMZ then					
					DFMarker[targetname] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", targetname, 8, 3, 0, 1, 0, 0.8):Appear():RegisterForAlerts())
				end
			else
				mod:Schedule(0.25, DFAScan)
			end
			return--If we found the boss before hitting 5, want to fire this return to break checking other bosses needlessly
		end
	end
end

local function HeroicDFAScan()
	for i = 1, 5 do
		local unitID = "boss"..i
		if UnitExists(unitID) and mod:GetCIDFromGUID(UnitGUID(unitID)) == 71161 then
			if (not UnitExists(unitID.."target")) or not mod:IsTanking(unitID.."target", unitID) then
				mod:Unschedule(HeroicDFAScan)
				sndWOP:Play("ex_so_sctj") --死從天降
				for i = 1, DBM:GetNumGroupMembers() do
					local _, class = UnitClass("raid"..i)
					if (class == "DRUID" and UnitPowerMax("raid"..i) > 200000) or class == "HUNTER" or class == "PRIEST" or class == "MAGE" or class == "WARLOCK" or (class == "SHAMAN" and UnitPowerMax("raid"..i) > 200000) or (class == "PALADIN" and UnitPowerMax("raid"..i) > 200000) then
						DFMarker[UnitName("raid"..i)] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", UnitName("raid"..i), 8, 3, 1, 1 ,1 ,0.4):Appear():RegisterForAlerts())
					end
				end
			else
				mod:Schedule(0.2, HeroicDFAScan)
			end
			return
		end
	end
end

local function CheckBosses()
	local vulnerable = false
	for i = 1, 3 do--Assume boss 4 is always the inactive one. Need to verify this works, because filtering by ready to fight causes start timers not to work
		local unitID = "boss"..i
		--Only 3 bosses activate on pull, however now the inactive or (next boss to activate) also fires IEEU. As such, we have to filter that boss by scaning for readytofight. Works well though.
		if UnitExists(unitID) and not activeBossGUIDS[UnitGUID(unitID)] then--Check if new units exist we haven't detected and added yet.
			local activetime = GetTime() - mod.combatInfo.pull
			activeBossGUIDS[UnitGUID(unitID)] = true
			activatedTargets[#activatedTargets + 1] = UnitName(unitID)
			--Activation Controller
			local cid = mod:GetCIDFromGUID(UnitGUID(unitID))
			if cid == 71161 then--Kil'ruk the Wind-Reaver
				if mod:IsDifficulty("heroic10", "heroic25") then
					timerReaveCD:Start(38.5)
				end
				if mod:IsDifficulty("heroic10", "heroic25") then
					mod:Schedule(15, HeroicDFAScan)--Not a large sample size, data shows it happen 29-30 seconds after IEEU fires on two different pulls. Although 2 is a poor sample
				else
					mod:Schedule(23, DFAScan)--Not a large sample size, data shows it happen 29-30 seconds after IEEU fires on two different pulls. Although 2 is a poor sample
				end
				timerGougeCD:Start()
				if UnitDebuff("player", GetSpellInfo(142929)) then vulnerable = true end
				if activetime >= 15 then
					sndWOP:Play("ex_so_lfz") --掠風者參戰
				end
			elseif cid == 71157 then--Xaril the Poisoned-Mind
				if UnitDebuff("player", GetSpellInfo(142931)) then vulnerable = true end
				if activetime >= 15 then
					sndWOP:Play("ex_so_dxz") --毒心者參戰
				end
			elseif cid == 71156 then--Kaz'tik the Manipulator
				if activetime >= 15 then
					sndWOP:Play("ex_so_czz") --操縱者參戰
					sndWOP:Schedule(1, "ex_so_ylcz")
				end
			elseif cid == 71155 then--Korven the Prime
				timerShieldBashCD:Start(19)--20seconds from REAL IEEU
				if activetime >= 15 then
					sndWOP:Play("ex_so_zzz") --至尊者參戰
				end
			elseif cid == 71160 then--Iyyokuk the Lucid
				timerInsaneCalculationCD:Start()
				if activetime >= 15 then
					sndWOP:Play("ex_so_mcz") --明澈者參戰
				end
			elseif cid == 71154 then--Ka'roz the Locust
				timerFlashCD:Start(14)--In final LFR test, he didn't cast this for 20 seconds. TODO check this change
				timerHurlAmberCD:Start(44)
				if activetime >= 15 then
					sndWOP:Play("ex_so_bsh") --暴食蝗參戰
				end
			elseif cid == 71152 then--Skeer the Bloodseeker
				timerBloodlettingCD:Start(9)
				if UnitDebuff("player", GetSpellInfo(143279)) then vulnerable = true end
				if activetime >= 15 then
					sndWOP:Play("ex_so_nxz") --覓血者參戰
				end
			elseif cid == 71158 then--Rik'kal the Dissector
				timerInjectionCD:Start(7.5, 1)
				if mod.Options.LTchong then
					DBM:ShowLTSpecialWarning("NEXT:1", 1, 0, 0, nil, 144286, nil, 7.5)
					showtank = true
				end
				timerMutateCD:Start(34, 1)
				if UnitDebuff("player", GetSpellInfo(143275)) then vulnerable = true end
				if activetime >= 15 then
					sndWOP:Play("ex_so_qgz") --切割者參戰					
				end
			elseif cid == 71153 then--Hisek the Swarmkeeper
				timerAimCD:Start(37)--Might be 32 now with the UnitBuff filter, so pay attention to that and adjust as needed
				if mod:IsDifficulty("heroic10", "heroic25") then
					timerRapidFireCD:Start(44.5)
				end
				if activetime >= 15 then
					sndWOP:Play("ex_so_cqws") --蟲群衛士參戰
				end
			end
		end
	end
	if #activatedTargets >= 1 then
		warnActivatedTargets(vulnerable)--Down here so we can send tank vulnerable status
	end
	showspellinfo()
end

function mod:OnCombatStart(delay)
	twipe(activeBossGUIDS)
	twipe(activatedTargets)
	twipe(mutateTargets)
	twipe(RedMarkers)
	twipe(BlueMarkers)
	twipe(YellowMarkers)
	twipe(MZMarkers)
	twipe(CMMarkers)
	twipe(DFMarker)
	
	twipe(xiezi)
	twipe(ResultXFTargets)
	
	twipe(ResultTargets)
	twipe(ResultMeleeTargets)
	twipe(ResultRangedTargets)
	twipe(ResultRangedDPSTargets)
	twipe(ResultGroupTargets)
	
	calculatedShape = nil
	calculatedNumber = nil
	calculatedColor = nil
	chongnum = 0
	firecount = 0
	injcount = 0
	mutatecount = 0
	dissectorlive = true
	self:RegisterShortTermEvents(
		"INSTANCE_ENCOUNTER_ENGAGE_UNIT"--We register here to make sure we wipe variables on pull
	)
	timerJumpToCenter:Start(-delay)
	berserkTimer:Start(-delay)
	xiezireset = 0
	showtank = false
	havecolor = false
	havedebuff = false
	caled = false
end

function mod:OnCombatEnd()
	warnWhirling:Show(table.concat(ResultXFTargets, "<, >"))
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.HudMAP or self.Options.HudMAPMZ then
		DBMHudMap:FreeEncounterMarkers()
	end
	if self.Options.LTchong or self.Options.LTIP then
		DBM:HideLTSpecialWarning()
	end
end

--"<13.6 19:16:29> [UNIT_SPELLCAST_SUCCEEDED] Iyyokuk the Lucid [[boss2:Jump to Center::0:143545]]", -- [95]
--^don't let above fool you, not all of the paragons fire this spell!!! that is why we MUST use IEEU
function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	self:Unschedule(CheckBosses)
	self:Schedule(1, CheckBosses)--Delay check to make sure we run function only once on pull
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142725 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystBlue:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142532)) then
			specWarnCatalystBlue:Show()
			if self.Options.yellToxicCatalyst then
				yellCatalystBlue:Yell()
			end
			sndWOP:Play("ex_so_lsbz") --藍色爆炸準備
		else
			sndWOP:Play("ex_so_lsch") --藍色催化
		end
	elseif args.spellId == 142726 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystRed:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142533)) then
			specWarnCatalystRed:Show()
			if self.Options.yellToxicCatalyst then
				yellCatalystRed:Yell()
			end
			sndWOP:Play("runout") --離開人群
		else
			sndWOP:Play("ex_so_hsch") --紅色催化
			if self.Options.HudMAP then
				for i = 1, DBM:GetNumGroupMembers() do
					if UnitDebuff("raid"..i, GetSpellInfo(142533)) then
						RedMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", UnitName("raid"..i), 10, 3, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts():Rotate(360, 3.2))
					end
				end
			end
		end
	elseif args.spellId == 142727 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystYellow:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142534)) then
			specWarnCatalystYellow:Show()
			if self.Options.yellToxicCatalyst then
				yellCatalystYellow:Yell()
			end
			sndWOP:Play("ex_so_hsdq") --黃色毒氣準備
		else
			sndWOP:Play("ex_so_ysch") --黃色催化
			if self.Options.HudMAP then
				for i = 1, DBM:GetNumGroupMembers() do
					if UnitDebuff("raid"..i, GetSpellInfo(142534)) then
						YellowMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", UnitName("raid"..i), 8, 3, 1, 1 ,0 ,0.8):Appear():RegisterForAlerts():Rotate(360, 3.2))
					end
				end
			end
		end		
	elseif args.spellId == 142728 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystOrange:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142533)) or UnitDebuff("player", GetSpellInfo(142534)) then--Red or Yellow
			specWarnCatalystOrange:Show()
			if self.Options.yellToxicCatalyst then
				yellCatalystOrange:Yell()
			end
			if self.Options.LTIP then
				DBM:ShowLTSpecialWarning(142728, 1, 0, 0, 1, 142728, 3)
			end
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
		else
			if havecolor then
				if self.Options.LTIP then
					DBM:ShowLTSpecialWarning(_G["NO"], 1, 1, 1, nil, 142728, 2)
				end
			else
				if self.Options.LTIP then
					DBM:ShowLTSpecialWarning(GetSpellInfo(142728).."??", 1, 0, 0, 1, 142728, 2)
				end
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
			end
		end
		sndWOP:Play("ex_so_csch") --橙色催化
		sndWOP:Schedule(3, "ex_so_bzhh") --爆炸火環準備
		sndWOP:Schedule(4, "countthree")
		sndWOP:Schedule(5, "counttwo")
		sndWOP:Schedule(6, "countone")
	elseif args.spellId == 142729 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystPurple:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142533)) or UnitDebuff("player", GetSpellInfo(142532)) then--Red or Blue
			specWarnCatalystPurple:Show()
			if self.Options.yellToxicCatalyst then
				yellCatalystPurple:Yell()
			end
			if self.Options.LTIP then
				DBM:ShowLTSpecialWarning(142729, 1, 0, 0, 1, 142729, 3)
			end
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
		else			
			if havecolor then
				if self.Options.LTIP then
					DBM:ShowLTSpecialWarning(_G["NO"], 1, 1, 1, nil, 142729, 2)
				end
			else
				if self.Options.LTIP then
					DBM:ShowLTSpecialWarning(GetSpellInfo(142729).."??", 1, 0, 0, 1, 142729, 2)
				end
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
			end
		end
		sndWOP:Play("ex_so_zsch") --紫色催化
	elseif args.spellId == 142730 then
		timerToxicCatalystCD:Start()
		if self.Options.warnToxicCatalyst then
			warnToxicCatalystGreen:Show()
		end
		if UnitDebuff("player", GetSpellInfo(142534)) or UnitDebuff("player", GetSpellInfo(142532)) then--Yellow or Blue
			specWarnCatalystGreen:Show()
			if self.Options.yellToxicCatalyst then
				yellCatalystGreen:Yell()
			end
			if self.Options.LTIP then
				DBM:ShowLTSpecialWarning(142730, 1, 0, 0, 1, 142730, 3)
			end
			PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
		else
			if havecolor then
				if self.Options.LTIP then
					DBM:ShowLTSpecialWarning(_G["NO"], 1, 1, 1, nil, 142730, 2)
				end
			else
				if self.Options.LTIP then
					DBM:ShowLTSpecialWarning(GetSpellInfo(142730).."??", 1, 0, 0, 1, 142730, 3)
				end
				PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.ogg", "Master")
			end
		end
		sndWOP:Play("ex_so_lvsch") --綠色催化
		sndWOP:Schedule(2, "ex_so_xxls") --小心綠水
	elseif args.spellId == 143765 then
		warnSonicProjection:Show()
	elseif args.spellId == 143666 then
		warnDiminish:Show()
	elseif args.spellId == 142416 then
		warnInsaneCalculationFire:Show()
		specWarnInsaneCalculationFire:Show()
		if caled then
			sndWOP:Play("linesoon") --準備連線
			caled = false
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_yllx") --遠離連線
		end
	elseif args.spellId == 143709 then
		warnFlash:Show()
		specWarnFlash:Show()
		timerFlashCD:Start()
		sndWOP:Play("chargemove") --衝鋒快躲
--[[DELETE		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(6)--Range assumed, spell tooltips not informative enough
			self:Schedule(5, hideRangeFrame)
		end]]
		if self.Options.LTIP and (not showtank) then
			DBM:ShowLTSpecialWarning(143709, 1, 0, 0, 1, 143709, 2)
		end
	elseif args.spellId == 143280 then
		warnBloodletting:Show()
		specWarnBloodletting:Show()
		timerBloodlettingCD:Start()
		sndWOP:Play("ex_so_zbrn")
		sndWOP:Schedule(3.5, "ex_so_rnkd")
	elseif args.spellId == 143974 then
		warnShieldBash:Show()
		timerShieldBashCD:Start()
	elseif args.spellId == 142315 then
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then--We are highest threat target
				warnCausticBlood:Show()
				specWarnCausticBlood:Show()--So show tank warning
				break
			end
		end
	elseif args.spellId == 143243 then
		warnRapidFire:Show()
		specWarnRapidFire:Show()
		sndWOP:Play("ex_mop_ybzb") --音波準備
		if self.Options.LTIP and (not showtank) then
			DBM:ShowLTSpecialWarning(143243, 1, 0, 0, 1, 143243, 2)
		end
		timerRapidFireCD:Start()
	elseif args.spellId == 143339 then
		for i = 1, 5 do
			local bossUnitID = "boss"..i
			if UnitExists(bossUnitID) and UnitGUID(bossUnitID) == args.sourceGUID and UnitDetailedThreatSituation("player", bossUnitID) then
				specWarnInjection:Show()
				break
			end
		end
		injcount = injcount + 1
		timerInjectionCD:Start(9.5, injcount + 1)
		if self.Options.LTchong then
			self:Schedule(1, function()
				if injcount == 7 then
					DBM:ShowLTSpecialWarning("NEXT:"..(injcount + 1), 1, 0, 0, nil, 144286, nil, 8.5)
				else
					DBM:ShowLTSpecialWarning("NEXT:"..(injcount + 1), 0, 1, 0, nil, 143339, nil, 8.5)
				end
			end)			
		end
	elseif args.spellId == 148676 then
		warnReave:Show()
		specWarnReave:Show()
		sndWOP:Play("ex_so_xft") --旋風準備
		timerReaveCD:Start()
		self:Unschedule(HeroicDFAScan)
		self:Schedule(15, HeroicDFAScan)		
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142528 then
		warnToxicInjection:Show()
		timerToxicCatalystCD:Start(21)--21-23 variance observed on normal and heroic
	elseif args.spellId == 142232 then
		self:Unschedule(DFAScan)
		self:Schedule(17, DFAScan)
	elseif args.spellId == 144286 then
		if xiezi[args.sourceName] then
			xiezi[args.sourceName] = xiezi[args.sourceName] + 1
			testinfo()
		end
	elseif args.spellId == 142416 then
		firecount = firecount + 1
		if MyJS() then
			sndWOP:Play("defensive") --注意減傷
			sndWOP:Schedule(0.7, "defensive")
		else
			DBM:PlayCountSound(firecount)
		end
		if firecount == 6 then firecount = 0 end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 143339 then
		local amount = args.amount or 1
		warnInjection:Show(args.destName, amount)
	elseif args.spellId == 142532 and args:IsPlayer() then
		specWarnToxicBlue:Show()
		sndWOP:Play("ex_so_lsds") --藍色毒素
		havecolor = true
	elseif args.spellId == 142533 and args:IsPlayer() then
		specWarnToxicRed:Show()
		sndWOP:Play("ex_so_hsds") --紅色毒素
		havecolor = true
	elseif args.spellId == 142534 and args:IsPlayer() then
		specWarnToxicYellow:Show()
		sndWOP:Play("ex_so_huds") --黃色毒素
		havecolor = true
--[[	elseif args.spellId == 142547 and args:IsPlayer() then
		specWarnToxicOrange:Show()
	elseif args.spellId == 142548 and args:IsPlayer() then
		specWarnToxicPurple:Show()
	elseif args.spellId == 142549 and args:IsPlayer() then
		specWarnToxicGreen:Show()--]]
	elseif args.spellId == 142671 then
		warnMesmerize:Show(args.destName)
		if args.IsPlayer() then
			specWarnMesmerize:Show()
			yellMesmerize:Yell()
			sndWOP:Play("ex_so_nbcm") --你被催眠
		else
			specWarnKunchongs:Show()
			sndWOP:Play("ex_so_czkd") --蟲子快打
			if self.Options.HudMAPMZ then
				CMMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", args.destName, 5, 15, 1, 1 ,0 ,1):Pulse(0.5, 0.5))
			end
		end
	elseif args.spellId == 142564 then
		warnEncaseInAmber:Show(args.destName)
		specWarnEncaseInAmber:Show(args.destName)
		timerEncaseInAmber:Start(args.destName)
		sndWOP:Play("ex_so_hupd") --琥珀快打
		timerEncaseInAmberCD:Start()
		if self:IsMythic() then
--			countdownEncaseInAmber:Start()
		end
	elseif args.spellId == 143939 then
		warnGouge:Show(args.destName)
		timerGouge:Start(args.destName)
		timerGougeCD:Start()
		if args.IsPlayer() then
			specWarnGouge:Show()
			sndWOP:Play("ex_so_zj") --鑿擊
		else
			specWarnGougeOther:Show(args.destName)
			if mod:IsHealer() then
				sndWOP:Play("tankheal") --注意刷坦
			end
		end
	elseif args.spellId == 143974 then
		timerShieldBash:Start(args.destName)
		if args.IsPlayer() then
			specWarnShieldBash:Show()
			sndWOP:Play("ex_so_dj") --盾擊
		else
			specWarnShieldBashOther:Show(args.destName)
			if mod:IsHealer() then
				sndWOP:Play("tankheal") --注意刷坦
			end
		end
	elseif args.spellId == 143701 then
		warnWhirling:CombinedShow(0.5, args.destName)
		if args.IsPlayer() then
			specWarnWhirling:Show()
			yellWhirling:Yell()
			timerWhirling:Start()
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				if inRange and inRange < 6 then
					specWarnWhirlingNear:Show(args.destName)
					sndWOP:Play("runaway") --快躲開
				end
			end
		end
		local xftime = GetTime() - mod.combatInfo.pull
		xftime = ("%d:%0.2d"):format(xftime/60, math.fmod(xftime, 60))
		ResultXFTargets[#ResultXFTargets + 1] = args.destName.."("..xftime..")"
	elseif args.spellId == 143759 then
		warnHurlAmber:Show()
		specWarnHurlAmber:Show()
		timerHurlAmberCD:Start()
		sndWOP:Play("ex_so_tzhp") --投擲琥珀
		if self.Options.LTIP and (not showtank) then
			DBM:ShowLTSpecialWarning(143759, 1, 0, 0, 1, 143759, 2)
		end
	elseif args.spellId == 143337 then
		mutateTargets[#mutateTargets + 1] = args.destName
		if args.IsPlayer() then
			specWarnMutate:Show()
			sndWOP:Play("ex_so_bsjx") --變身巨蠍
			timerMutate:Start()
		end
		self:Unschedule(warnMutatedTargets)
		self:Schedule(0.5, warnMutatedTargets)
		xiezireset = xiezireset + 1
		if xiezireset == 4 then
			twipe(xiezi)
			xiezireset = 1
		end
		if not xiezi[args.destName] then
			xiezi[args.destName] = 0
			testinfo()
		end
	elseif args.spellId == 143358 then
		if args.IsPlayer() then
			specWarnParasiteFixate:Show()
		end
	elseif args.spellId == 142948 then
		warnAim:Show(args.destName)
		timerAim:Start(args.destName)
		timerAimCD:Start()
		if args.IsPlayer() then
			specWarnAim:Show()
			sndWOP:Play("ex_so_nbmz") --你被瞄準
			yellAim:Yell()
		else
			specWarnAimOther:Show(args.destName)
			sndWOP:Play("ex_so_fdyb") --準備分擔音波
			sndWOP:Schedule(1.5, "countfour")
			sndWOP:Schedule(2.5, "countthree")
			sndWOP:Schedule(3.5, "counttwo")
			sndWOP:Schedule(4.5, "countone")
			if self.Options.HudMAPMZ then
				MZMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 5, 6, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts():Rotate(360, 5.2))
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		if self.Options.SetIconOnAim then
			self:SetIcon(args.destName, 1)
		end
	elseif args.spellId == 142797 and args.IsPlayer() and self:AntiSpam(2, 3) then
		specWarnGas:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 142564 then
		timerEncaseInAmber:Cancel(args.destName)
	elseif args.spellId == 143939 then
		timerGouge:Cancel(args.destName)
	elseif args.spellId == 143974 then
		timerShieldBash:Cancel(args.destName)
--[[DELETE	elseif args.spellId == 143700 and self.Options.RangeFrame then
		DBM.RangeCheck:Hide()]]
	elseif args.spellId == 142948 then
--[[DELETE		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end]]
		if self.Options.SetIconOnAim then
			self:SetIcon(args.destName, 0)
		end
		if MZMarkers[args.destName] then
			MZMarkers[args.destName] = free(MZMarkers[args.destName])
		end
	elseif args.spellId == 143339 then
		self:Schedule(3, function()
			if dissectorlive then
				chongnum = chongnum + 8
				testinfo()
			end
		end)
	elseif args.spellId == 142671 then
		if CMMarkers[args.destName] then
			CMMarkers[args.destName] = free(CMMarkers[args.destName])
		end
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 143735 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnCausticAmber:Show()
		sndWOP:Play("runaway") --快躲開
	elseif spellId == 142797 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnGas:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71161 then--Kil'ruk the Wind-Reaver
		if mod:IsDifficulty("heroic10", "heroic25") then
			self:Unschedule(HeroicDFAScan)
		else
			self:Unschedule(DFAScan)
		end		
		timerReaveCD:Cancel()
		timerGougeCD:Cancel()
	elseif cid == 71157 then--Xaril the Poisoned-Mind
		timerToxicCatalystCD:Cancel()
	elseif cid == 71156 then--Kaz'tik the Manipulator

	elseif cid == 71155 then--Korven the Prime
		timerShieldBashCD:Cancel()
		timerEncaseInAmberCD:Cancel()
--		countdownEncaseInAmber:Cancel()
	elseif cid == 71160 then--Iyyokuk the Lucid
		timerInsaneCalculationCD:Cancel()
	elseif cid == 71154 then--Ka'roz the Locust
		timerFlashCD:Cancel()
		timerHurlAmberCD:Cancel()
	elseif cid == 71152 then--Skeer the Bloodseeker
		timerBloodlettingCD:Cancel()
	elseif cid == 71158 then--Rik'kal the Dissector
		timerMutateCD:Cancel()
		timerInjectionCD:Cancel()
		dissectorlive = false
		if self.Options.LTchong then
			DBM:HideLTSpecialWarning()
			showtank = false
		end
		testinfo()
	elseif cid == 71153 then--Hisek the Swarmkeeper
		timerAimCD:Cancel()
		timerRapidFireCD:Cancel()
	elseif cid == 71578 then--chong		
		chongnum = chongnum - 1
		testinfo()
	end
end

------------------
--Normal Only
--143605 Red Sword
--143606 Purple Sword
--143607 Blue Sword
--143608 Green Sword
--143609 Yellow Sword

--143610 Red Drum
--143611 Purple Drum
--143612 Blue Drum
--143613 Green Drum
--143614 Yellow Drum

--143615 Red Bomb
--143616 Purple Bomb
--143617 Blue Bomb
--143618 Green Bomb
--143619 Yellow Bomb
----------------------
--25man Only
--143620 Red Mantid
--143621 Purple Mantid
--143622 Blue Mantid
--143623 Green Mantid
--143624 Yellow Mantid

--143627 Red Staff
--143628 Purple Staff
--143629 Blue Staff
--143630 Green Staff
--143631 Yellow Staff

local colors = {"Red", "Purple", "Blue", "Green", "Yellow"}

local RedDebuffs = {GetSpellInfo(143605), GetSpellInfo(143610), GetSpellInfo(143615), GetSpellInfo(143620), (GetSpellInfo(143627))}
local PurpleDebuffs = {GetSpellInfo(143606), GetSpellInfo(143611), GetSpellInfo(143616), GetSpellInfo(143621), (GetSpellInfo(143628))}
local BlueDebuffs = {GetSpellInfo(143607), GetSpellInfo(143612), GetSpellInfo(143617), GetSpellInfo(143622), (GetSpellInfo(143629))}
local GreenDebuffs = {GetSpellInfo(143608), GetSpellInfo(143613), GetSpellInfo(143618), GetSpellInfo(143623), (GetSpellInfo(143630))}
local YellowDebuffs = {GetSpellInfo(143610), GetSpellInfo(143614), GetSpellInfo(143619), GetSpellInfo(143624), (GetSpellInfo(143631))}

local SwordDebuffs = {GetSpellInfo(143605), GetSpellInfo(143606), GetSpellInfo(143607), GetSpellInfo(143608), GetSpellInfo(143609)}
local DrumDebuffs = {GetSpellInfo(143610), GetSpellInfo(143611), GetSpellInfo(143612), GetSpellInfo(143613), (GetSpellInfo(143614))}
local BombDebuffs = {GetSpellInfo(143615), GetSpellInfo(143616), GetSpellInfo(143617), GetSpellInfo(143618), (GetSpellInfo(143619))}
local MantidDebuffs = {GetSpellInfo(143620), GetSpellInfo(143621), GetSpellInfo(143622), GetSpellInfo(143623), (GetSpellInfo(143624))}
local StaffDebuffs = {GetSpellInfo(143627), GetSpellInfo(143628), GetSpellInfo(143629), GetSpellInfo(143630), (GetSpellInfo(143631))}

local AllDebuffs = {
GetSpellInfo(143605), GetSpellInfo(143606), GetSpellInfo(143607), GetSpellInfo(143608), GetSpellInfo(143609),
GetSpellInfo(143610), GetSpellInfo(143611), GetSpellInfo(143612), GetSpellInfo(143613), GetSpellInfo(143614),
GetSpellInfo(143615), GetSpellInfo(143616), GetSpellInfo(143617), GetSpellInfo(143618), GetSpellInfo(143619),
GetSpellInfo(143620), GetSpellInfo(143621), GetSpellInfo(143622), GetSpellInfo(143623), GetSpellInfo(143624),
GetSpellInfo(143627), GetSpellInfo(143628), GetSpellInfo(143629), GetSpellInfo(143630), (GetSpellInfo(143631))
}

local function parseDebuff(player)
	local count
	for i= 1, 5 do
		count = select(4, UnitDebuff(player, SwordDebuffs[i]))
		if count then
			return "Sword", colors[i], (count == 0) and 1 or count
		end
		count = select(4,UnitDebuff(player, DrumDebuffs[i]))
		if count then
			return "Drum", colors[i], (count == 0) and 1 or count
		end
		count = select(4,UnitDebuff(player, BombDebuffs[i]))
		if count then
			return "Bomb", colors[i], (count == 0) and 1 or count
		end
		count = select(4,UnitDebuff(player, MantidDebuffs[i]))
		if count then
			return "Mantid", colors[i], (count == 0) and 1 or count
		end
		count = select(4,UnitDebuff(player, StaffDebuffs[i]))
		if count then
			return "Staff", colors[i], (count == 0) and 1 or count
		end
	end
	return false
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc, _, _, target)
	local targetname = DBM:GetUnitFullName(target)
	if npc == calculatingDude then
--		warnCalculated:Show(targetname)
		timerCalculated:Start()
		timerInsaneCalculationCD:Start()
		if target == UnitName("player") then
			specWarnCalculated:Show()
			sndWOP:Play("ex_so_lxdn") --連線點你
			yellCalculated:Yell()
			caled = true
		end
		if self:IsMythic() then
			local resultshape, resultcolor, resultnumber = parseDebuff(target)
			local shape, color, number = parseDebuff("player")
			if shape then
				if shape == resultshape or color == resultcolor or number == resultnumber then
					if target ~= UnitName("player") then
						specWarnCalculated:Show()
						sndWOP:Play("ex_so_lxdn")
						yellCalculated:Yell()
						caled = true
					end
				else
					if target ~= UnitName("player") then
						caled = false
					end
				end
			end			
			twipe(ResultTargets)
			twipe(ResultGroupTargets)
			twipe(ResultMeleeTargets)
			twipe(ResultRangedTargets)
			twipe(ResultRangedDPSTargets)
			local _, _, mysubgroup = GetRaidRosterInfo(UnitInRaid("player"))
			myGroup = mysubgroup
			for i = 1, DBM:GetNumGroupMembers() do
				local shapecheck, colorcheck, numbercheck = parseDebuff(UnitName("raid"..i))
				if shapecheck then
					if shapecheck == resultshape or colorcheck == resultcolor or numbercheck == resultnumber then
						if mod.Options.ShowGrouptarget then
							local _, _, subgroup = GetRaidRosterInfo(i)
							if subgroup == myGroup then
								ResultGroupTargets[#ResultGroupTargets + 1] = UnitName("raid"..i)
							end
						else
							ResultTargets[#ResultTargets + 1] = UnitName("raid"..i)
							local _, class = UnitClass("raid"..i)
							if (class == "DRUID" and UnitPowerMax("raid"..i) > 200000) or class == "HUNTER" or class == "PRIEST" or class == "MAGE" or class == "WARLOCK" or (class == "SHAMAN" and UnitPowerMax("raid"..i) > 200000) or (class == "PALADIN" and UnitPowerMax("raid"..i) > 200000) then
								ResultRangedTargets[#ResultRangedTargets + 1] = UnitName("raid"..i)
								if self:UnitIsDps("raid"..i) then
									ResultRangedDPSTargets[#ResultRangedDPSTargets + 1] = UnitName("raid"..i)
								end
							else
								ResultMeleeTargets[#ResultMeleeTargets + 1] = UnitName("raid"..i)
							end
						end
					end
				end
			end
			if mod.Options.ShowGrouptarget and self:IsMythic() then
				DBM.InfoFrame:SetHeader(GetSpellInfo(144095).."("..(firecount+1)..")")
				if #ResultGroupTargets == 1 then
					DBM.InfoFrame:Show(1, "other", ResultGroupTargets[1], "1")
				elseif #ResultGroupTargets == 2 then
					DBM.InfoFrame:Show(2, "other", ResultGroupTargets[1], "1", ResultGroupTargets[2], "2")
				elseif #ResultGroupTargets == 3 then
					DBM.InfoFrame:Show(3, "other", ResultGroupTargets[1], "1", ResultGroupTargets[2], "2", ResultGroupTargets[3], "3")
				elseif #ResultGroupTargets == 4 then
					DBM.InfoFrame:Show(4, "other", ResultGroupTargets[1], "1", ResultGroupTargets[2], "2", ResultGroupTargets[3], "3", ResultGroupTargets[4], "4")
				elseif #ResultGroupTargets == 5 then
					DBM.InfoFrame:Show(5, "other", ResultGroupTargets[1], "1", ResultGroupTargets[2], "2", ResultGroupTargets[3], "3", ResultGroupTargets[4], "4", ResultGroupTargets[5], "5")
				else
					DBM.InfoFrame:Show(1, "other", "No one", "0")
				end
				twipe(ResultGroupTargets)
				
			end
			warnResult:Show(table.concat(ResultMeleeTargets, "<, >"))
			warnResult:Show(table.concat(ResultRangedTargets, "<, >"))
			--[[if #ResultMeleeTargets < 7 then
				local meleenum = #ResultMeleeTargets
				local needranged = 7 - meleenum
				for i = 1, needranged do
					if ResultRangedDPSTargets[i] == UnitName("player") then
						sndWOP:Play("gather")
					end
				end
			end]]
		end		
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 142809 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		if UnitDebuff("player", GetSpellInfo(142808)) then
			havedebuff = true
			self:Schedule(10, function() havedebuff = false end)
		end
		if (not havedebuff) then
			specWarnFireline:Show()
			sndWOP:Play("runaway") --快躲開
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
