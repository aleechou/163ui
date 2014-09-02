﻿local mod	= DBM:NewMod(737, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndADD	= mod:NewSound(nil, "SoundADD", true)

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(62511)
mod:SetZone()
mod:SetMinSyncRevision(8052)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"UNIT_SPELLCAST_STOP boss1 boss2",
	"UNIT_POWER"
)

--[[WoL Reg Expression
(spellid = 45477 or spellid = 122540 or spellid = 122532 or spellid = 122348) and fulltype = SPELL_CAST_SUCCESS or (spellid =122784 or spellid =121949 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_APPLIED or (spellid =122370 or spellid = 122540 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_REMOVED or (spellid = 122408 or spellid = 122413 or spellid = 122398 or spellid = 122540 or spellid = 122402) and fulltype = SPELL_CAST_START or fulltype = UNIT_DIED and (targetname = "Omegal" or targetname = "Shiramune")
(spellid = 45477 or spellid = 122540) and fulltype = SPELL_CAST_SUCCESS or (spellid =122784 or spellid =121949 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_APPLIED or (spellid =122370 or spellid = 122540 or spellid = 122395 or spellid = 121994) and fulltype = SPELL_AURA_REMOVED or (spellid = 122408 or spellid = 122413 or spellid = 122398 or spellid = 122540 or spellid = 122402) and fulltype = SPELL_CAST_START or fulltype = UNIT_DIED and (targetname = "Omegal" or targetname = "Shiramune")
--]]
--Boss
local warnReshapeLifeTutor		= mod:NewAnnounce("warnReshapeLifeTutor", 1, 122784)--Another LFR focused warning really.
local warnReshapeLife			= mod:NewAnnounce("warnReshapeLife", 4, 122784)
local warnWillPower				= mod:NewAnnounce("warnWillPower", 3, 63050)
local warnAmberScalpel			= mod:NewSpellAnnounce(121994, 3)
local warnParasiticGrowth		= mod:NewTargetAnnounce(121949, 4, nil, mod:IsHealer())
local warnAmberGlob				= mod:NewTargetAnnounce(125502, 4)--Heroic drycode, might need some tweaks
--Construct
local warnAmberExplosion		= mod:NewAnnounce("warnAmberExplosion", 3, 122398, false)--In case you want to get warned for all of them, but could be spammy later fight so off by default. This announce includes source of cast.
local warnStruggleForControl	= mod:NewTargetAnnounce(122395, 2, nil, false)--Disabled in phase 3 as at that point it's just a burn.
local warnDestabalize			= mod:NewStackAnnounce(123059, 1, nil, false)--This can be super spammy so off by default.
--Living Amber
local warnLivingAmber			= mod:NewSpellAnnounce("ej6261", 2, nil, false)--122348 is what you check spawns with. ALso spamming and off by default
local warnBurningAmber			= mod:NewCountAnnounce("ej6567", 2, nil, false)--Keep track of Burning Amber Puddles. Spammy, but nessesary for heroic for someone managing them.
--Amber Monstrosity
local warnAmberCarapace			= mod:NewTargetAnnounce(122540, 4)--Monstrosity Shielding Boss (phase 2 start)
local warnMassiveStomp			= mod:NewCastAnnounce(122408, 3, nil, nil, mod:IsHealer() or mod:IsMelee())
local warnAmberExplosionSoon	= mod:NewSoonAnnounce(122402, 3)
local warnFling					= mod:NewSpellAnnounce(122413, 3, nil, mod:IsTank())--think this always does his aggro target but not sure. If it does random targets it will need target scanning.
local warnInterruptsAvailable	= mod:NewAnnounce("warnInterruptsAvailable", 1, 122398)

--Boss
local specwarnAmberScalpel			= mod:NewSpecialWarningSpell(121994, nil, nil, nil, 2)
local yellAmberScalpel				= mod:NewYell(121994)
local specwarnAmberScalpelNear		= mod:NewSpecialWarningClose(121994)
local specwarnReshape				= mod:NewSpecialWarningYou(122784)
local specwarnParasiticGrowth		= mod:NewSpecialWarningTarget(121949, mod:IsHealer())
local specwarnParasiticGrowthYou	= mod:NewSpecialWarningYou(121949) -- This warn will be needed at player is clustered together. Especially on Phase 3.
local specwarnAmberGlob				= mod:NewSpecialWarningYou(125502)
--Construct
local specwarnAmberExplosionYou		= mod:NewSpecialWarning("specwarnAmberExplosionYou")--Only interruptable by the player controling construct casting, so only that person gets warning. non generic used to make this one more specific.
local specwarnAmberExplosionAM		= mod:NewSpecialWarning("specwarnAmberExplosionAM")--Must be on by default. Amber montrosity's MUST be interrupted on heroic or it's an auto wipe. it hits for over 500k.
local specwarnAmberExplosionOther	= mod:NewSpecialWarning("specwarnAmberExplosionOther", false)--A compromise. loose non player controled constructs now off by default but should still be an option as they are still perfectly interruptable (and should be)
local specwarnAmberExplosion		= mod:NewSpecialWarningTarget(122398, nil, nil, nil, true)--One you can't interrupt it
local specwarnWillPower				= mod:NewSpecialWarning("specwarnWillPower")--Special warning for when your will power is low (construct)
--local specwarnBossDebuff			= mod:NewSpecialWarning("specwarnBossDebuff")--Some special warning that says "get your ass to boss and refresh debuff NOW" (Debuff stacks up to 255 with 10% damage taken increase every stack, keeping buff up and stacking is paramount to dps check on heroic)
--Living Amber
local specwarnBurningAmber		= mod:NewSpecialWarningMove(122504)--Standing in a puddle
local specwarnScalpel			= mod:NewSpecialWarningMove(121995)
local specwarnScalpelAmber		= mod:NewSpecialWarningMove(122005)
--Amber Monstrosity
local specwarnAmberMonstrosity	= mod:NewSpecialWarningSwitch("ej6254", not mod:IsHealer())
local specwarnFling				= mod:NewSpecialWarningSpell(122413, mod:IsTank())
local specwarnMassiveStomp		= mod:NewSpecialWarningSpell(122408, nil, nil, nil, true)

local specwarnHupo				= mod:NewSpecialWarning("specwarnHupo")
local specwarnOOYou				= mod:NewSpecialWarning("specwarnOOYou")
local specwarnOOYouD				= mod:NewSpecialWarning("specwarnOOYouD")

--Boss
local timerReshapeLifeCD		= mod:NewNextCountTimer(50, 122784)--50 second cd in phase 1-2, 15 second in phase 3. if no construct is up, cd is ignored and boss casts it anyways to make sure 1 is always up.
local timerAmberScalpelCD		= mod:NewNextTimer(40, 121994)--40 seconds after last one ENDED
local timerAmberScalpel			= mod:NewBuffActiveTimer(10, 121994)
local timerParasiticGrowthCD	= mod:NewCDTimer(35, 121949, nil, mod:IsHealer())--35-50 variation (most of the time 50, rare pulls he decides to use 35 sec cd instead)
local timerParasiticGrowth		= mod:NewTargetTimer(30, 121949, nil, mod:IsHealer())
--Construct
local timerAmberExplosionCD		= mod:NewNextSourceTimer(13, 122398)--13 second cd on player controled units, 18 seconds on non player controlled constructs
local timerDestabalize			= mod:NewTargetTimer(15, 123059, nil, false)
local timerStruggleForControl	= mod:NewTargetTimer(5, 122395, nil, false)
--Amber Monstrosity
local timerMassiveStompCD		= mod:NewCDTimer(18, 122408, nil, mod:IsHealer() or mod:IsMelee())--18-25 seconds variation
local timerFlingCD				= mod:NewCDTimer(25, 122413, nil, mod:IsTank())--25-40sec variation.
local timerAmberExplosionAMCD	= mod:NewTimer(46, "timerAmberExplosionAMCD", 122402)--Special timer just for amber monstrosity. easier to cancel, easier to tell apart. His bar is the MOST important and needs to be seperate from any other bar option.
local timerAmberExplosion		= mod:NewCastTimer(2.5, 122402)

local berserkTimer				= mod:NewBerserkTimer(600)

mod:AddBoolOption("FixNameplates", true)--Because having 215937495273598637205175t9 hostile nameplates on screen when you enter a construct is not cool.

mod:AddDropdownOption("optInfoFrame", {"noIF", "IF1", "IF2"}, "IF1", "sound")


local Phase = 1
local Puddles = 0
local Constructs = 0
local constructCount = 0--NOT same as Constructs variable above. this is one is for counting them mainly in phase 1
local hupocount = 0
local bossdebuff = 0
local boss2debuff = 0
local otherconstruct = nil
local playerIsConstruct = false
local warnedWill = false
local willNumber = 100--Last warned player will power number (not same as actual player will power)
local lastStrike = 0
local scansDone = 0
local Totems = nil
local Guardians = nil
local Pets = nil
local TPTPNormal = nil
local amberExplosion = GetSpellInfo(122402)
local Monstrosity = EJ_GetSectionInfo(6254)
local MutatedConstruct = EJ_GetSectionInfo(6249)
local canInterrupt = {}
local guids = {}
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always

local warnedoo = {}

local function buildGuidTable()
	table.wipe(guids)
	for i = 1, DBM:GetNumGroupMembers() do
		guids[UnitGUID("raid"..i) or "none"] = GetRaidRosterInfo(i)
	end
end

local function updateInfoFrame()
	if mod.Options.optInfoFrame == "IF1" then
		if Phase == 2 then
			DBM.InfoFrame:SetHeader("大黃動搖:"..boss2debuff)
		else
			DBM.InfoFrame:SetHeader("首領動搖:"..bossdebuff)
		end
		DBM.InfoFrame:Show(5, "playerpower", 1, ALTERNATE_POWER_INDEX, nil, nil, true)--At a point i need to add an arg that lets info frame show the 5 LOWEST not the 5 highest, instead of just showing 10
	elseif mod.Options.optInfoFrame == "IF2" then
		if otherconstruct and (Phase < 3) then
			DBM.InfoFrame:SetHeader("我的能量:"..UnitPower("player", ALTERNATE_POWER_INDEX).."  其他能量"..UnitPower(otherconstruct, ALTERNATE_POWER_INDEX))
		else
			DBM.InfoFrame:SetHeader("我的能量:"..UnitPower("player", ALTERNATE_POWER_INDEX))
		end
		DBM.InfoFrame:Show(2, "bossdebuffstacks", 123059)
	end
end

function mod:ScalpelTarget()
	if playerIsConstruct then return end--Don't need this info as a construct
	scansDone = scansDone + 1
	local targetname = DBM:GetUnitFullName("boss1targettarget")--Not a mistake, just clever use of available api to get the target of an invisible mob the boss is targeting ;)
	if UnitExists("boss1targettarget") and not UnitIsUnit("boss1", "boss1targettarget") then
		warnAmberScalpel:Show(targetname)
		if targetname == UnitName("player") then
			specwarnAmberScalpel:Show()
			yellAmberScalpel:Yell()
			timerAmberScalpel:Start()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\justrun.mp3") --快跑
		else
			local uId = DBM:GetRaidUnitId(targetname)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 5 then--Guessed range
					specwarnAmberScalpelNear:Show(targetname)
				end
			end
		end
	else--He failed sanity check (ie boss1targettarget was himself, so he was obviously still targeting tank, reschedule check)
		if scansDone < 6 then
			self:ScheduleMethod(0.2, "ScalpelTarget")
		end
	end
end

local function warnAmberExplosionCast(spellId)
	if #canInterrupt == 0 then--This will never happen if fired by "InterruptAvailable" sync since it should always be 1 or greater. This is just a fallback if contructs > 0 and we scheduled "warnAmberExplosionCast" there
		specwarnAmberExplosion:Show(spellId == 122402 and Monstrosity or MutatedConstruct)--No interupts, warn the raid to prep for aoe damage with beware! alert.
		if spellId == 122398 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_hpbz.mp3") --琥珀爆炸
		end
	else--Interrupts available, lets call em out as a great tool to give raid leader split second decisions on who to allocate to the task (so they don't all waste it on same target and not have for next one).
		warnInterruptsAvailable:Show(spellId == 122402 and Monstrosity or MutatedConstruct, table.concat(canInterrupt, "<, >"))
	end
	table.wipe(canInterrupt)
end

function mod:OnCombatStart(delay)
	warnedWill = true--avoid wierd bug on pull
	willNumber = 100
	buildGuidTable()
	Phase = 1
	Puddles = 0
	Constructs = 0
	constructCount = 0
	hupocount = 0
	lastStrike = 0
	otherconstruct = nil
	table.wipe(canInterrupt)
	table.wipe(warnedoo)
	playerIsConstruct = false
	timerAmberScalpelCD:Start(9-delay)
	timerReshapeLifeCD:Start(20-delay, 1)
	timerParasiticGrowthCD:Start(23.5-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	updateInfoFrame()
	if self.Options.FixNameplates then
		--Blizz settings either return 1 or nil, we pull users original settings first, then change em if appropriate after.
		Totems = GetCVarBool("nameplateShowEnemyTotems")
		Guardians = GetCVarBool("nameplateShowEnemyGuardians")
		Pets = GetCVarBool("nameplateShowEnemyPets")
		--Now change all settings to make the nameplates while in constructs not terrible.
		if Totems then
			SetCVar("nameplateShowEnemyTotems", 0)
		end
		if Guardians then
			SetCVar("nameplateShowEnemyGuardians", 0)
		end
		if Pets then
			SetCVar("nameplateShowEnemyPets", 0)
		end
		--Check for threat plates on pull and save users setting.
		if IsAddOnLoaded("TidyPlates_ThreatPlates") then
			TPTPNormal = TidyPlatesThreat.db.profile.nameplate.toggle["Normal"]--Returns true or false, use TidyPlatesNormal to save that value on pull
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.optInfoFrame == "IF1" or self.Options.optInfoFrame == "IF2" then
		Phase = 0
		DBM.InfoFrame:Hide()
	end
	if self.Options.FixNameplates then
		--if any of settings were on before pull, we put them back to way they were.
		if Totems then
			SetCVar("nameplateShowEnemyTotems", 1)
		end
		if Guardians then
			SetCVar("nameplateShowEnemyGuardians", 1)
		end
		if Pets then
			SetCVar("nameplateShowEnemyPets", 1)
		end
		if IsAddOnLoaded("TidyPlates_ThreatPlates") then
			if TPTPNormal == true and not TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] then--Normal plates were on when we pulled but aren't on now.
				TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] = true--Turn them back on
				TidyPlates:ReloadTheme()--Call the Tidy plates update methods
				TidyPlates:ForceUpdate()
			end
		end
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123059) and args:GetDestCreatureID() ~= 62691 then--Only track debuffs on boss, constructs, or monstrosity, ignore oozes.
		warnDestabalize:Show(args.destName, args.amount or 1)
		if self:IsDifficulty("lfr25") then
			timerDestabalize:Start(60, args.destName)
		else
			timerDestabalize:Start(args.destName)
		end		
		if args:GetDestCreatureID() == 62511 then
			bossdebuff = args.amount or 1
		elseif args:GetDestCreatureID() == 62711 then
			boss2debuff = args.amount or 1
		end
		updateInfoFrame()
	elseif args:IsSpellID(121949) then
		warnParasiticGrowth:Show(args.destName)
		if not playerIsConstruct then--Healers do need to know this, but it's still a distraction as a construct for sound, they got the reg warning.
			specwarnParasiticGrowth:Show(args.destName)
		end
		if args:IsPlayer() then
			specwarnParasiticGrowthYou:Show()
		end
		timerParasiticGrowth:Start(args.destName)
		timerParasiticGrowthCD:Start()
		if mod:IsHealer() and (not playerIsConstruct) then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_jscz.mp3") --寄生成長
		end
	elseif args:IsSpellID(122540) then
		constructCount = 0
		Phase = 2
		warnAmberCarapace:Show(args.destName)
		if not playerIsConstruct then
			specwarnAmberMonstrosity:Show()
		end
		timerMassiveStompCD:Start(20)
		timerFlingCD:Start(33)
		warnAmberExplosionSoon:Schedule(50.5)
		timerAmberExplosionAMCD:Start(55.5, amberExplosion)
		sndWOP:Schedule(48.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndWOP:Schedule(49.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndWOP:Schedule(50.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Schedule(51.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(52.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(53.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(54.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")--P2
	elseif args:IsSpellID(122395) and Phase < 3 and not playerIsConstruct then
		warnStruggleForControl:Show(args.destName)
		timerStruggleForControl:Start(args.destName)
	elseif args:IsSpellID(122784) then
		Constructs = Constructs + 1
		constructCount = constructCount + 1
		hupocount = hupocount + 1
		specwarnHupo:Show(hupocount, args.destName)
		warnReshapeLife:Show(args.spellName, args.destName, constructCount)
		if args.destName ~= UnitName("player") then
			otherconstruct = args.destName
		end
		if args:IsPlayer() then
			playerIsConstruct = true
			warnedWill = true -- fix bad low will special warning on entering Construct. After entering vehicle, this will be return to false. (on alt.power changes)
			specwarnReshape:Show()
			warnReshapeLifeTutor:Show()
			timerAmberExplosionCD:Start(15, args.destName)--Only player needs to see this, they are only person who can do anything about it.
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_nbzh.mp3") --你被轉化
			if self.Options.FixNameplates and IsAddOnLoaded("TidyPlates_ThreatPlates") then
				if TPTPNormal == true then
					TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] = false
					TidyPlates:ReloadTheme()--Call the Tidy plates update methods
					TidyPlates:ForceUpdate()
				end
			end
		end
		if Phase < 3 then
			timerReshapeLifeCD:Start(nil, constructCount+1)
		else
			timerReshapeLifeCD:Start(15, constructCount+1)--More often in phase 3
		end
	elseif args:IsSpellID(125502) then
		warnAmberGlob:Show(args.destName)
		if args:IsPlayer() then
			specwarnAmberGlob:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\orbrun.mp3") --寶珠快跑
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122754) then
		timerDestabalize:Cancel(args.destName)
	elseif args:IsSpellID(122370) then
		Constructs = Constructs - 1
		if args.destName == otherconstruct then
			otherconstruct = nil
		end
		if args:IsPlayer() then
			playerIsConstruct = false
			if self.Options.FixNameplates and IsAddOnLoaded("TidyPlates_ThreatPlates") then
				if TPTPNormal == true and not TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] then--Normal plates were on when we pulled but aren't on now.
					TidyPlatesThreat.db.profile.nameplate.toggle["Normal"] = true--Turn them back on
					TidyPlates:ReloadTheme()--Call the Tidy plates update methods
					TidyPlates:ForceUpdate()
				end
			end
		end
		timerAmberExplosionCD:Cancel(args.destName)
	elseif args:IsSpellID(121994) then
		timerAmberScalpelCD:Start()
	elseif args:IsSpellID(121949) then
		timerParasiticGrowth:Cancel(args.destName)
	elseif args:IsSpellID(122540) then--Phase 3
		constructCount = 0
		Phase = 3
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\pthree.mp3")--p3
		timerMassiveStompCD:Cancel()
		timerFlingCD:Cancel()
		timerAmberExplosionAMCD:Cancel()
		timerDestabalize:Cancel(Monstrosity)
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		warnAmberExplosionSoon:Cancel()
		updateInfoFrame()
		--He does NOT reset reshape live cd here, he finishes out last CD first, THEN starts using new one.
	elseif args:IsSpellID(123059) then
		if args:GetDestCreatureID() == 62511 then
			bossdebuff = 0
		elseif args:GetDestCreatureID() == 62711 then
			boss2debuff = 0
		end
		updateInfoFrame()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122398) then
		warnAmberExplosion:Show(args.sourceName, args.spellName)
		if args:GetSrcCreatureID() == 62701 then--Cast by a wild construct not controlled by player
			if playerIsConstruct and GetTime() - lastStrike >= 4 then--Player is construct and Amber Strike will be available before cast ends.
				specwarnAmberExplosionOther:Show(args.spellName, args.sourceName)
				if self:LatencyCheck() then--if you're too laggy we don't want you telling us you can interrupt it 2-3 seconds from now. we only care if you can interrupt it NOW
					self:SendSync("InterruptAvailable", UnitGUID("player")..":122398")
				end
			end
			timerAmberExplosionCD:Start(18, args.sourceName, args.sourceGUID)--Longer CD if it's a non player controlled construct. Everyone needs to see this bar because there is no way to interrupt these.
			self:Unschedule(warnAmberExplosionCast)
			self:Schedule(0.5, warnAmberExplosionCast, 122398)--Always check available interrupts and special warn if not
		elseif args.sourceGUID == UnitGUID("player") then--Cast by YOU
			specwarnAmberExplosionYou:Show(args.spellName)
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stopcast.mp3") --停止施法
			timerAmberExplosionCD:Start(13, args.sourceName)--Only player needs to see this, they are only person who can do anything about it.
		end
	elseif args:IsSpellID(122402) then--Amber Monstrosity
		if playerIsConstruct and GetTime() - lastStrike >= 4 then--Player is construct and Amber Strike will be available before cast ends.
			specwarnAmberExplosionAM:Show(args.spellName, args.sourceName)--On heroic, not interrupting amber montrosity is an auto wipe. this is single handedly the most important special warning of all!!!!!!
			if self:LatencyCheck() then--if you're too laggy we don't want you telling us you can interrupt it 2-3 seconds from now. we only care if you can interrupt it NOW
				self:SendSync("InterruptAvailable", UnitGUID("player")..":122402")
			end
		end
		warnAmberExplosion:Show(args.sourceName, args.spellName)
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_jgbz.mp3") --巨怪爆炸
		warnAmberExplosionSoon:Cancel()
		warnAmberExplosionSoon:Schedule(41)
		timerAmberExplosion:Start()
		timerAmberExplosionAMCD:Start(46, args.spellName)
		sndWOP:Schedule(39, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndWOP:Schedule(40, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndWOP:Schedule(41, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Schedule(42, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(43, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(44, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(45, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		self:Unschedule(warnAmberExplosionCast)
		self:Schedule(0.5, warnAmberExplosionCast, 122402)--Always check available interrupts and special warn if not
	elseif args:IsSpellID(122408) then
		if not playerIsConstruct then
			warnMassiveStomp:Show()--Don't even need normal warning as a construct, it just doesn't matter
			specwarnMassiveStomp:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stompsoon.mp3") --準備踐踏
		end
		timerMassiveStompCD:Start()--Still start timer so you still have it when you leave construct
	elseif args:IsSpellID(122413) then
		warnFling:Show()--Tanks and healers still need to know this even as a construct
		if not playerIsConstruct then
			specwarnFling:Show()
		end
		timerFlingCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(122348) then
		warnLivingAmber:Show()
	elseif args:IsSpellID(121994) then
		warnAmberScalpel:Show()
		specwarnAmberScalpel:Show()
--		scansDone = 0
--		self:ScheduleMethod(0.2, "ScalpelTarget")
	elseif args:IsSpellID(122532) then
		Puddles = Puddles + 1
		warnBurningAmber:Show(Puddles)
		if warnedoo[args.sourceGUID] and not playerIsConstruct then
			specwarnOOYouD:Show()
			warnedoo[args.sourceGUID] = nil
		end
	elseif args:IsSpellID(123156) then
		Puddles = Puddles - 1
		warnBurningAmber:Show(Puddles)
	elseif args:IsSpellID(122389) and args.sourceGUID == UnitGUID("player") then--Amber Strike
		lastStrike = GetTime()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 122504 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specwarnBurningAmber:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 121995 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specwarnScalpel:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif spellId == 122005 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specwarnScalpelAmber:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_POWER(uId)
	if Phase ~= 0 then updateInfoFrame() end
	if uId ~= "player" then return end
	local playerWill = UnitPower(uId, ALTERNATE_POWER_INDEX)
	if playerWill > willNumber then willNumber = playerWill end--Will power has gone up since last warning so reset that warning.
	if playerWill == 80 and willNumber > 80 then
		willNumber = 80
		warnWillPower:Show(willNumber)
	elseif playerWill == 50 and willNumber > 50 then--Works
		willNumber = 50
		warnWillPower:Show(willNumber)
	elseif playerWill == 30 and willNumber > 30 then
		willNumber = 30
		warnWillPower:Show(willNumber)
	elseif playerWill >= 22 and warnedWill then
		warnedWill = false
	elseif playerWill < 18 and not warnedWill then--5 seconds before 0 (after subtracking a budget of 8 for interrupt)
		warnedWill = true
		specwarnWillPower:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_yzgd.mp3") --意志過低
	elseif playerWill == 10 and willNumber > 10 then--Works
		willNumber = 10
		warnWillPower:Show(willNumber)
	elseif playerWill == 4 and willNumber > 4 then
		willNumber = 4
		warnWillPower:Show(willNumber)
	end
end

function mod:UNIT_SPELLCAST_STOP(uId, _, _, _, spellId)
	if spellId == 122402 then--SPELL_INTERRUPT not always fires, so use UNIT_SPELLCAST_STOP
		timerAmberExplosion:Cancel()
	end
end

function mod:OnSync(msg, str)
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	local guid, spellId
	if str then
		guid, spellId = string.split(":", str)
		spellId = tonumber(spellId or "")
	end
	if msg == "InterruptAvailable" and guids[guid] and spellId then
		canInterrupt[#canInterrupt + 1] = guids[guid]
		self:Unschedule(warnAmberExplosionCast)
		self:Schedule(0.5, warnAmberExplosionCast, spellId)
	end
end

function mod:SWING_DAMAGE(sourceGUID, _, _, _, destGUID)
	local cid = self:GetCIDFromGUID(sourceGUID)
	if cid == 62691 and destGUID == UnitGUID("player") and not warnedoo[sourceGUID] and not playerIsConstruct then
		sndADD:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
		specwarnOOYou:Show()
		warnedoo[sourceGUID] = true
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE