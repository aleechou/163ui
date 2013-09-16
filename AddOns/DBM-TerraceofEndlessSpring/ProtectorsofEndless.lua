local mod	= DBM:NewMod(683, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndSDQ	= mod:NewSound(nil, "SoundSDQ", mod:IsHealer())

mod:SetRevision(("$Revision: 9886 $"):sub(12, -3))
mod:SetCreatureID(60585, 60586, 60583)--60583 Protector Kaolan, 60585 Elder Regail, 60586 Elder Asani
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

--[[
--Both Elders use Overhwelming Corruption as their phase 3 ability. It's not worth warning for since it's just a periodic aoe you can't do anything about with stacking damage.
spellid = 117309 or spellid = 117227 or spellid = 111850 or spellid = 117519 and not(fulltype = SPELL_PERIODIC_DAMAGE) or spellid = 117986 or spellid = 117975 or spellid = 118077
--]]
local isDispeller = select(2, UnitClass("player")) == "MAGE"
	    		 or select(2, UnitClass("player")) == "PRIEST"
	    		 or select(2, UnitClass("player")) == "SHAMAN"

local warnPhase2					= mod:NewPhaseAnnounce(2)
local warnPhase3					= mod:NewPhaseAnnounce(3)
--Elder Asani
local warnCleansingWaters			= mod:NewTargetAnnounce(117309, 3)--Phase 1+ ability. If target scanning fails, will switch to spell announce
local warnCorruptingWaters			= mod:NewSpellAnnounce(117227, 4)--Phase 2+ ability.
--Elder Regail (Also uses Overwhelming Corruption in phase 3)
local warnLightningPrison			= mod:NewTargetAnnounce(111850, 3)--Phase 1+ ability.
local warnLightningStorm			= mod:NewSpellAnnounce(118077, 4)--Phase 2+ ability.								
--Protector Kaolan
local warnTouchofSha				= mod:NewTargetAnnounce(117519, 3, nil, mod:IsHealer())--Phase 1+ ability. He stops casting it when everyone in raid has it then ceases. If someone dies and is brezed, he casts it on them again.
local warnDefiledGround				= mod:NewSpellAnnounce(117986, 3, nil, mod:IsMelee())--Phase 2+ ability.
local warnExpelCorruption			= mod:NewSpellAnnounce(117975, 4)--Phase 3 ability.
--Heroic
local warnGroupOrder				= mod:NewAnnounce("warnGroupOrder", 1, 118191)--25 man for now, unless someone codes a 10 man version of it into code then it can be both.

--Elder Asani
local specWarnCleansingWaters		= mod:NewSpecialWarningTarget(117309, mod:IsTank())--It's being cast on the boss, move the boss
local specWarnCleansingWatersDispel	= mod:NewSpecialWarningDispel(117309, isDispeller)--The boss wasn't moved in time, now he needs to be dispelled.
local specWarnCorruptingWaters		= mod:NewSpecialWarningSwitch("ej5821", mod:IsDps())
--Elder Regail
local specWarnLightningPrison		= mod:NewSpecialWarningYou(111850)--Debuff you gain before you are hit with it.
local specWarnLightningPrisonOther	= mod:NewSpecialWarningTarget(111850)
local yellLightningPrison			= mod:NewYell(111850)
local specWarnLPmove				= mod:NewSpecialWarningMove(111850)
local specWarnLightningStorm		= mod:NewSpecialWarningSpell(118077, nil, nil, nil, true)--Since it's multiple targets, will just use spell instead of dispel warning.
--Protector Kaolan
local specWarnDefiledGround			= mod:NewSpecialWarningMove(117986)
local specWarnExpelCorruption		= mod:NewSpecialWarningSpell(117975, nil, nil, nil, true)--Entire raid needs to move.
--Minions of Fear
local specWarnYourGroup				= mod:NewSpecialWarning("specWarnYourGroup")
local specWarnYourEnd				= mod:NewSpecialWarning("specWarnYourEnd")
local specWarnCorruptedEssence		= mod:NewSpecialWarningStack(118191, true, 9)--You cannot get more than 9, if you get 9 you need to GTFO or you do big damage to raid

local specWarnwarterDD				= mod:NewSpecialWarningInterrupt(118312)
local specWarnDDL				= mod:NewSpecialWarning("specWarnDDL")
local specWarnJSA						= mod:NewSpecialWarning("SpecWarnJSA")

--Elder Asani
local timerCleansingWatersCD		= mod:NewCDTimer(32.5, 117309)
local timerCorruptingWatersCD		= mod:NewNextTimer(42, 117227)
--Elder Regail
local timerLightningPrisonCD		= mod:NewCDTimer(25, 111850)
local timerLightningStormCD			= mod:NewCDTimer(42, 118077)--Shorter Cd in phase 3 32 seconds.
local timerLightningStorm			= mod:NewBuffActiveTimer(14, 118077)
--Protector Kaolan
local timerTouchOfShaCD				= mod:NewCDTimer(29, 117519)--Need new heroic data, timers confirmed for 10 man and 25 man normal as 29 and 12
local timerDefiledGroundCD			= mod:NewNextTimer(15.5, 117986, nil, mod:IsMelee())
local timerExpelCorruptionCD		= mod:NewNextTimer(38.5, 117975)--It's a next timer, except first cast. that one variates.

mod:AddBoolOption("SoundDW", mod:IsDps() and isDispeller, "sound")

local berserkTimer					= mod:NewBerserkTimer(490)

mod:AddBoolOption("RangeFrame")--For Lightning Prison
mod:AddBoolOption("SetIconOnPrison", true)--For Lightning Prison (icons don't go out until it's DISPELLABLE, not when targetting is up).

local phase = 1
local totalTouchOfSha = 0
local scansDone = 0
local prisonTargets = {}
local prisonIcon = 1--Will try to start from 1 and work up, to avoid using icons you are probalby putting on bosses (unless you really fail at spreading).
local prisonDebuff = GetSpellInfo(79339)
local prisonCount = 0
local watercount = 0

local corruptedCount = 0
local myGroup = nil
local mobsetgroup = {}
local warnmob = {}
local warnmobone = {}
local warnmobtwo = {}
local warnmobthree = {}
local warnmobfour = {}
local warnmobfive = {}
local outgroup = false
local olddata = 0
local helpdisp = false

local helpstop = false

local senddr = {}
local warneddr = {}

mod:AddBoolOption("HudMAP", true, "sound")

mod:AddBoolOption("SoundWater", mod:IsTank(), "sound")

for i = 9, 1, -1 do
	mod:AddBoolOption("warndr"..i, false, "sound")
end

mod:AddBoolOption("opthelpDD", false, "sound")

mod:AddBoolOption("optDD4", false, "sound")

mod:AddDropdownOption("optDD", {"nodd", "DD1", "DD2", "DD3", "DD4"}, "nodd", "sound")

mod:AddDropdownOption("optMob", {"Mob1", "Mob2", "Mob3", "Mob4", "Mob5", "noMob"}, "noMob", "sound")

mod:AddEditBoxOption("optMobSet", 300, "52220,12220,12220,12220,11119", "sound")

mod:AddEditBoxOption("helpdispset", 150, "", "sound")

local function MyDR(msg)
	if (msg == "dr90" and mod.Options.warndr9) or (msg == "dr80" and mod.Options.warndr8) or (msg == "dr70" and mod.Options.warndr7) or (msg == "dr60" and mod.Options.warndr6) or (msg == "dr50" and mod.Options.warndr5) or (msg == "dr40" and mod.Options.warndr4) or (msg == "dr30" and mod.Options.warndr3) or (msg == "dr20" and mod.Options.warndr2) or (msg == "dr10" and mod.Options.warndr1) then
		local healthshow = string.sub(msg, 3, 4)
		specWarnJSA:Show(healthshow)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
	end
end

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local LightningPrisonCastMarkers = {}
local LightningPrisonMarkers = {}


local DebuffFilter
do
	DebuffFilter = function(uId)
		return UnitDebuff(uId, prisonDebuff)
	end
end

local function warnPrisonTargets()
	if mod.Options.RangeFrame then
		if UnitDebuff("player", GetSpellInfo(111850)) then--You have debuff, show everyone
			DBM.RangeCheck:Show(8, nil)
		else--You do not have debuff, only show players who do
			DBM.RangeCheck:Show(8, DebuffFilter)
			if helpdisp then
				local helpername = mod.Options.helpdispset
				specWarnLightningPrisonOther:Show(helpername)
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\helpdispel.mp3")
				sndWOP:Schedule(0.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(2.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				helpdisp = false
			else
				sndSDQ:Schedule(0.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndSDQ:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndSDQ:Schedule(2.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		end
	end
	warnLightningPrison:Show(table.concat(prisonTargets, "<, >"))
	timerLightningPrisonCD:Start()
	table.wipe(prisonTargets)
	prisonIcon = 1
end

local function SetmobTactics()
	table.wipe(mobsetgroup)
	table.wipe(warnmob)
	table.wipe(warnmobone)
	table.wipe(warnmobtwo)
	table.wipe(warnmobthree)
	table.wipe(warnmobfour)
	table.wipe(warnmobfive)
	myGroup = mod.Options.optMob == "Mob1" and 1 or mod.Options.optMob == "Mob2" and 2 or mod.Options.optMob == "Mob3" and 3 or mod.Options.optMob == "Mob4" and 4 or mod.Options.optMob == "Mob5" and 5
	local tacticsvalue = mod.Options.optMobSet
	tacticsvalue = string.gsub(tacticsvalue, "%s", "")
	tacticsvalue = string.gsub(tacticsvalue, "，", ",")
	local modecheck = string.find(tacticsvalue, "%p")
	for k in string.gmatch(tacticsvalue, "%d") do
		table.insert(mobsetgroup, k)
	end
	warnmob[1] = tonumber(mobsetgroup[1])
	olddata = warnmob[1]
	for i = 2, #mobsetgroup do
		olddata = olddata + mobsetgroup[i]
		if tonumber(mobsetgroup[i]) == 0 then 
			warnmob[i] = 0
		else
			warnmob[i] = olddata
		end
	end
	for i = 1, #warnmob do
		if modecheck == 5 then
			if i%4== 1 then
				table.insert(warnmobone, warnmob[i]-mobsetgroup[i])
			elseif i%4== 2 then
				table.insert(warnmobtwo, warnmob[i]-mobsetgroup[i])
			elseif i%4== 3 then
				table.insert(warnmobthree, warnmob[i]-mobsetgroup[i])
			elseif i%4== 0 then
				table.insert(warnmobfour, warnmob[i]-mobsetgroup[i])
			end
		elseif modecheck == 6 then
			if i%5== 1 then
				table.insert(warnmobone, warnmob[i]-mobsetgroup[i])
			elseif i%5== 2 then
				table.insert(warnmobtwo, warnmob[i]-mobsetgroup[i])
			elseif i%5== 3 then
				table.insert(warnmobthree, warnmob[i]-mobsetgroup[i])
			elseif i%5== 4 then
				table.insert(warnmobfour, warnmob[i]-mobsetgroup[i])
			elseif i%5== 0 then
				table.insert(warnmobfive, warnmob[i]-mobsetgroup[i])
			end
		end
	end
end

function mod:WatersTarget()
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(60586)
	if targetname and uId then
		if UnitIsFriend("player", uId) then--He's targeting a friendly unit, he doesn't cast this on players, so it's wrong target.
			if scansDone < 15 then--Make sure no infinite loop.
				self:ScheduleMethod(0.1, "WatersTarget")--Check multiple times to find a target that isn't a player.
			end
		else--He's not targeting a player, it's definitely breeze target.
			warnCleansingWaters:Show(targetname)
			for i = 1, 3 do
				if UnitName("boss"..i) == targetname then
					if UnitDetailedThreatSituation("player", "boss"..i) and (self.Options.SoundWater) then--You are targeting the target of this spell.
						specWarnCleansingWaters:Show(targetname)
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\bossout.mp3") --拉開boss
					else
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jhzs.mp3") --淨化之水
					end
				end
			end			
		end
	else--target was nil, lets schedule a rescan here too.
		if scansDone < 15 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.1, "WatersTarget")
		end
	end
end

function mod:OnCombatStart(delay)
	phase = 1
	totalTouchOfSha = 0
	prisonCount = 0
	scansDone = 0
	corruptedCount = 0
	watercount = 0
	outgroup = false
	helpdisp = false
	helpstop = false
	table.wipe(senddr)
	table.wipe(warneddr)
	table.wipe(prisonTargets)
	table.wipe(LightningPrisonCastMarkers)
	table.wipe(LightningPrisonMarkers)
	timerCleansingWatersCD:Start(10-delay)
	timerLightningPrisonCD:Start(15.5-delay)
	if self:IsDifficulty("normal10", "heroic10") then
		timerTouchOfShaCD:Start(35-delay)
	else
		timerTouchOfShaCD:Start(15-delay)
	end
	if not self:IsDifficulty("lfr25") then--lfr not berserks or more than 8m 10sec.
		berserkTimer:Start(-delay)
	end
	myGroup = mod.Options.optMob == "Mob1" and 1 or mod.Options.optMob == "Mob2" and 2 or mod.Options.optMob == "Mob3" and 3 or mod.Options.optMob == "Mob4" and 4 or mod.Options.optMob == "Mob5" and 5
	if self:IsDifficulty("heroic10", "heroic25") then
		self:Schedule(15, function()
			warnGroupOrder:Show(1)
			if myGroup == 1 then
				outgroup = true
				DBM.Flash:Show(1, 0, 0)
				specWarnYourGroup:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3") --準備小怪
			end
		end)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(117519) then
		totalTouchOfSha = totalTouchOfSha + 1
		warnTouchofSha:Show(args.destName)
		if totalTouchOfSha < DBM:GetNumGroupMembers() then--This ability will not be cast if everyone in raid has it.
			if self:IsDifficulty("normal10", "heroic10") then--Heroic is assumed same as 10 normal.
				timerTouchOfShaCD:Start()
			else
				timerTouchOfShaCD:Start(12)--every 12 seconds on 25 man. Not sure about LFR though. Will adjust next week accordingly
			end
		end
	elseif args:IsSpellID(111850) then--111850 is targeting debuff (NOT dispelable one)
		if args.destName == mod.Options.helpdispset then		
			helpdisp = true
		end
		prisonTargets[#prisonTargets + 1] = args.destName
		prisonCount = prisonCount + 1
		if args:IsPlayer() then
			specWarnLightningPrison:Show()
			yellLightningPrison:Yell()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runout.mp3") --跑開人群
			sndWOP:Schedule(0.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(2.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
		if self.Options.HudMAP then
			if args:IsPlayer() then
				LightningPrisonCastMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 8, 2.8, 1, 1, 1, 0.2):RegisterForAlerts():Rotate(360, 3):Appear())
			else
				LightningPrisonCastMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 8, 2.8, 1, 1, 1, 1):RegisterForAlerts():Rotate(360, 3):Appear())
			end
		end
		self:Unschedule(warnPrisonTargets)
		self:Schedule(0.3, warnPrisonTargets)
	elseif args:IsSpellID(117436) then--111850 is pre warning, mainly for player, 117436 is the actual final result, mainly for the healer dispel icons
		if self.Options.SetIconOnPrison then
			self:SetIcon(args.destName, prisonIcon)
			prisonIcon = prisonIcon + 1
		end
		if self:AntiSpam(2, 2) then
			sndSDQ:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_qssd.mp3")--驅散閃電
		end
		if self.Options.HudMAP then
			if not args:IsPlayer() then
				LightningPrisonMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", args.destName, 8, nil, 0, 1, 0, 1):RegisterForAlerts())
			end
		end
	elseif args:IsSpellID(117283) then
		if args.destName == UnitName("boss1") or args.destName == UnitName("boss2") or args.destName == UnitName("boss3") then
			specWarnCleansingWatersDispel:Show(args.destName)
			if isDispeller and self.Options.SoundDW and self:AntiSpam(2, 3) then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_qszl.mp3") --驅散治療
			end
		end
	elseif args:IsSpellID(117052) then--Phase changes
		--Here we go off applied because then we can detect both targets in phase 1 to 2 transition.
		--There is some possiblity that other timers are reset or altered on phase 2-3 start. Light in case of Lightning storm Cd resetting in phase 3.
		--If any are missing that actually ALTER during a phase 2 or 3 transition they will be updated here.
		if phase == 2 then
			if args:GetDestCreatureID() == 60585 then--Elder Regail
				timerLightningStormCD:Start(20)
			elseif args:GetDestCreatureID() == 60586 then--Elder Asani
				timerCorruptingWatersCD:Start(10)
			elseif args:GetDestCreatureID() == 60583 then--Protector Kaolan
				timerDefiledGroundCD:Start(5)
			end
		elseif phase == 3 then
			if args:GetDestCreatureID() == 60583 then--Elder Regail
				timerLightningStormCD:Start(9.5)--His LS cd seems to reset in phase 3 since the CD actually changes.
			elseif args:GetDestCreatureID() == 60583 then--Protector Kaolan
				timerExpelCorruptionCD:Start(5)--5-10 second variation for first cast.
			end
		end
	elseif args:IsSpellID(118191) then
		if args:IsPlayer() then
			if (args.amount or 1) >= 9 then
				specWarnCorruptedEssence:Show(args.amount)
				self:Schedule(1, function() DBM.Flash:Show(1, 0, 0) end)
				self:Schedule(1.5, function() DBM.Flash:Show(0, 0, 1) end)
				self:Schedule(2, function() DBM.Flash:Show(1, 0, 0) end)
				sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobenough.mp3") --能量已滿 遠離小怪
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(117519) then
		totalTouchOfSha = totalTouchOfSha - 1
	elseif args:IsSpellID(117436) then
		prisonCount = prisonCount - 1
		if prisonCount == 0 and self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnPrison then
			self:SetIcon(args.destName, 0)
		end
		if LightningPrisonMarkers[args.destName] then
			LightningPrisonMarkers[args.destName] = free(LightningPrisonMarkers[args.destName])
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(117309) then
		scansDone = 0
		self:WatersTarget()
		timerCleansingWatersCD:Start()
	elseif args:IsSpellID(117975) then
		warnExpelCorruption:Show()
		specWarnExpelCorruption:Show()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_ylhq.mp3") --遠離黑球
		timerExpelCorruptionCD:Start()
		sndWOP:Schedule(34, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Schedule(35, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(36, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(37, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(38, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	elseif args:IsSpellID(117227) then
		warnCorruptingWaters:Show()
		specWarnCorruptingWaters:Show()
		timerCorruptingWatersCD:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_sqkd.mp3")--水球快打
	elseif args:IsSpellID(118077) then
		warnLightningStorm:Show()
		specWarnLightningStorm:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\lightstorm.mp3") --閃電風暴
		sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndWOP:Schedule(4.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(7.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(10, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		helpstop = true
		if phase == 3 then
			timerLightningStormCD:Start(32)
		else
			timerLightningStormCD:Start(41)
		end
	elseif args:IsSpellID(118312) then --水箭
		watercount = watercount + 1
		if self.Options.optDD4 then
			if ((mod.Options.optDD == "DD1") and (watercount % 4 == 1)) or ((mod.Options.optDD == "DD2") and (watercount % 4 == 2)) or ((mod.Options.optDD == "DD3") and (watercount % 4 == 3)) or ((mod.Options.optDD == "DD4") and (watercount % 4 == 0)) then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3") --快打斷
				specWarnwarterDD:Show(args.sourceName)
			end	
			if ((mod.Options.optDD == "DD1") and (watercount % 4 == 0)) or ((mod.Options.optDD == "DD2") and (watercount % 4 == 1)) or ((mod.Options.optDD == "DD3") and (watercount % 4 == 2)) or ((mod.Options.optDD == "DD4") and (watercount % 4 == 3)) then
				sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
				specWarnDDL:Schedule(1)
			end
		else
			if ((mod.Options.optDD == "DD1") and (watercount % 3 == 1)) or ((mod.Options.optDD == "DD2") and (watercount % 3 == 2)) or ((mod.Options.optDD == "DD3") and (watercount % 3 == 0)) then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")
				specWarnwarterDD:Show(args.sourceName)
			end	
			if ((mod.Options.optDD == "DD1") and (watercount % 3 == 0)) or ((mod.Options.optDD == "DD2") and (watercount % 3 == 1)) or ((mod.Options.optDD == "DD3") and (watercount % 3 == 2)) then
				sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3")
				specWarnDDL:Schedule(1)
			end
		end
		if helpstop and self.Options.opthelpDD then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\helpkick.mp3")
			specWarnwarterDD:Show(args.sourceName)
			helpstop = false
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(117986) then
		warnDefiledGround:Show()
		timerDefiledGroundCD:Start()
		for i = 1, 3 do
			if UnitName("boss"..i) == args.sourceName then
				if UnitDetailedThreatSituation("player", "boss"..i) then
					specWarnDefiledGround:Show()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
				end
			end
		end
	elseif args:IsSpellID(117052) and phase < 3 then--Phase changes
		phase = phase + 1
		if phase == 2 then
			warnPhase2:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3") -- P2
		elseif phase == 3 then
			warnPhase3:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\pthree.mp3") -- P3
			table.wipe(senddr)
			table.wipe(warneddr)
			self:RegisterShortTermEvents(
				"UNIT_HEALTH"
			)
		end
		--We cancel timers for whatever boss just died (ie boss that cast the buff, not the ones getting it)
		if args:GetSrcCreatureID() == 60585 then--Elder Regail
			timerLightningPrisonCD:Cancel()
			timerLightningStormCD:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		elseif args:GetSrcCreatureID() == 60586 then--Elder Asani
			timerCleansingWatersCD:Cancel()
			timerCorruptingWatersCD:Cancel()
		elseif args:GetSrcCreatureID() == 60583 then--Protector Kaolan
			timerTouchOfShaCD:Cancel()
			timerDefiledGroundCD:Cancel()
		end
	elseif args:IsSpellID(118191) then--Corrupted Essence
		SetmobTactics()
		corruptedCount = corruptedCount + 1		
		if self:IsDifficulty("heroic10", "heroic25") then
			for i = 1, #warnmobone do
				if corruptedCount == warnmobone[i] then
					warnGroupOrder:Show(1)
					if myGroup == 1 then
						outgroup = true
						DBM.Flash:Show(1, 0, 0)
						specWarnYourGroup:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
					end
					if myGroup ~= 1 and outgroup then
						outgroup = false
						specWarnYourEnd:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3")
					end
				end
			end
			for i = 1, #warnmobtwo do
				if corruptedCount == warnmobtwo[i] then				
					warnGroupOrder:Show(2)
					if myGroup == 2 then
						outgroup = true
						DBM.Flash:Show(1, 0, 0)
						specWarnYourGroup:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3") --準備小怪
					end
					if myGroup ~= 2 and outgroup then
						outgroup = false
						specWarnYourEnd:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3") --快回人群
					end
				end
			end
			for i = 1, #warnmobthree do
				if corruptedCount == warnmobthree[i] then				
					warnGroupOrder:Show(3)
					if myGroup == 3 then
						outgroup = true
						DBM.Flash:Show(1, 0, 0)
						specWarnYourGroup:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
					end
					if myGroup ~= 3 and outgroup then
						outgroup = false
						specWarnYourEnd:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3")
					end
				end
			end
			for i = 1, #warnmobfour do
				if corruptedCount == warnmobfour[i] then				
					warnGroupOrder:Show(4)
					if myGroup == 4 then
						outgroup = true
						DBM.Flash:Show(1, 0, 0)
						specWarnYourGroup:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
					end
					if myGroup ~= 4 and outgroup then
						outgroup = false
						specWarnYourEnd:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3")
					end
				end
			end
			if #warnmobfive > 0 then
				for i = 1, #warnmobfive do
					if corruptedCount == warnmobfive[i] then						
						warnGroupOrder:Show(5)
						if myGroup == 5 then
							outgroup = true
							DBM.Flash:Show(1, 0, 0)
							specWarnYourGroup:Show()
							sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")
						end
						if myGroup ~= 5 and outgroup then
							outgroup = false
							specWarnYourEnd:Show()
							sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3")
						end
					end
				end
			end
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 117436 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnLPmove:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 117988 and destGUID == UnitGUID("player") and self:AntiSpam(3, 5) then
		specWarnDefiledGround:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 60586 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 85 and h < 90 and not senddr["dr90"] then
			self:SendSync("dr90")
			senddr["dr90"] = true
		elseif h > 75 and h < 80 and not senddr["dr80"] then
			self:SendSync("dr80")
			senddr["dr80"] = true
		elseif h > 65 and h < 70 and not senddr["dr70"] then
			self:SendSync("dr70")
			senddr["dr70"] = true
		elseif h > 55 and h < 60 and not senddr["dr60"] then
			self:SendSync("dr60")
			senddr["dr60"] = true
		elseif h > 45 and h < 50 and not senddr["dr50"] then
			self:SendSync("dr50")
			senddr["dr50"] = true
		elseif h > 35 and h < 40 and not senddr["dr40"] then
			self:SendSync("dr40")
			senddr["dr40"] = true
		elseif h > 25 and h < 30 and not senddr["dr30"] then
			self:SendSync("dr30")
			senddr["dr30"] = true
		elseif h > 15 and h < 20 and not senddr["dr20"] then
			self:SendSync("dr20")
			senddr["dr20"] = true
		elseif h > 5 and h < 10 and not senddr["dr10"] then
			self:SendSync("dr10")
			senddr["dr10"] = true
		end
	end
end

function mod:OnSync(msg)
	if msg and not warneddr[msg] then
		MyDR(msg)
		warneddr[msg] = true
	end
end