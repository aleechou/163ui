local mod	= DBM:NewMod(687, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndDSA	= mod:NewSound(nil, "SoundDSA", true)

mod:SetRevision(("$Revision: 10296 $"):sub(12, -3))
mod:SetCreatureID(60701, 60708, 60709, 60710)--Adds: 60731 Undying Shadow, 60958 Pinning Arrow
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_POWER",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"CHAT_MSG_MONSTER_YELL"
)

local isDispellerZ = select(2, UnitClass("player")) == "PRIEST"
--on heroic 2 will be up at same time, so most announces are "target" type for source distinction.
--Unless it's a spell that doesn't directly affect the boss (ie summoning an add isn't applied to boss, it's a new mob).
--Zian
local warnChargedShadows		= mod:NewTargetAnnounce(117685, 2)
local warnUndyingShadows		= mod:NewSpellAnnounce(117506, 3)--Target scanning?
local warnFixate				= mod:NewTargetAnnounce(118303, 4)--Maybe spammy late fight, if zian is first boss you get? (adds are immortal, could be many up)
local warnShieldOfDarknessSoon	= mod:NewAnnounce("DarknessSoon", 4, 117697, nil, nil, true)
local warnShieldOfDarkness		= mod:NewTargetAnnounce(117697, 4)
--Meng
local warnCrazyThought			= mod:NewCastAnnounce(117833, 2, nil, nil, false)--Just doesn't seem all that important right now.
local warnMaddeningShout		= mod:NewSpellAnnounce(117708, 4)
local warnCrazed				= mod:NewTargetAnnounce(117737, 3)--Basically stance change
local warnCowardice				= mod:NewTargetAnnounce(117756, 3)--^^
local warnDelirious				= mod:NewTargetAnnounce(117837, 4, nil, mod:CanRemoveEnrage() or mod:IsTank())--Heroic Ability
--Qiang
local warnAnnihilate			= mod:NewCastAnnounce(117948, 4)
local warnFlankingOrders		= mod:NewSpellAnnounce(117910, 4)
local warnImperviousShieldSoon	= mod:NewPreWarnAnnounce(117961, 5, 3)--Less dangerous than Shield of darkness, doesn't need as much spam
local warnImperviousShield		= mod:NewTargetAnnounce(117961, 4)--Heroic Ability
--Subetai
local warnVolley				= mod:NewSpellAnnounce(118094, 3)--118088 trigger ID, but we use the other ID cause it has a tooltip/icon
local warnPinnedDown			= mod:NewTargetAnnounce(118135, 4)--We warn for this one since it's more informative then warning for just Rain of Arrows
local warnPillage				= mod:NewTargetAnnounce(118047, 3)
local warnSleightOfHand			= mod:NewTargetAnnounce(118162, 4)--Heroic Ability
--All
local warnActivated				= mod:NewTargetAnnounce(118212, 3, 78740)

--Zian
local specWarnUndyingShadow		= mod:NewSpecialWarningSwitch("ej5854", mod:IsDps())
local specWarnFixate			= mod:NewSpecialWarningYou(118303)
local yellFixate				= mod:NewYell(118303)
local specWarnCoalescingShadows	= mod:NewSpecialWarningMove(117558)
local specWarnShadowBlast		= mod:NewSpecialWarningInterrupt(117628, false)--very spammy. better to optional use
local specWarnShieldOfDarkness	= mod:NewSpecialWarningTarget(117697, nil, nil, nil, 3)--Heroic Ability
local specWarnShieldOfDarknessD	= mod:NewSpecialWarningDispel(117697, mod:IsMagicDispeller())--Heroic Ability
--Meng
local specWarnMaddeningShout	= mod:NewSpecialWarningSpell(117708, nil, nil, nil, true)
local specWarnCrazyThought		= mod:NewSpecialWarningInterrupt(117833, false)--At discretion of whoever to enable. depending on strat, you may NOT want to interrupt these (or at least not all of them)
local specWarnDelirious			= mod:NewSpecialWarningDispel(117837, mod:CanRemoveEnrage() or mod:IsTank())--Heroic Ability
--Qiang
local specWarnAnnihilate		= mod:NewSpecialWarningSpell(117948)--Maybe tweak options later or add a bool for it, cause on heroic, it's not likely ranged will be in front of Qiang if Zian or Subetai are up.
local specWarnFlankingOrders	= mod:NewSpecialWarningSpell(117910, nil, nil, nil, true)
local specWarnImperviousShield	= mod:NewSpecialWarningTarget(117961)--Heroic Ability
local specWarnImperviousShieldD	= mod:NewSpecialWarningDispel(117961, isDispellerZ)--Heroic Ability
--Subetai
local specWarnVolley			= mod:NewSpecialWarningSpell(118094, nil, nil, nil, true)
local specWarnPinningArrow		= mod:NewSpecialWarningSwitch("ej5861", mod:IsDps())
local specWarnPillage			= mod:NewSpecialWarningMove(118047)--Works as both a You and near warning
local specWarnSleightOfHand		= mod:NewSpecialWarningTarget(118162)--Heroic Ability

--Zian
local timerChargingShadowsCD	= mod:NewCDTimer(12, 117685)
local timerUndyingShadowsCD		= mod:NewCDTimer(41.5, 117506)--For most part it's right, but i also think on normal he can only summon a limited amount cause he did seem to skip one? leaving a CD for now until know for sure.
local timerFixate			  	= mod:NewTargetTimer(20, 118303)
local timerCoalescingShadowsCD	= mod:NewNextTimer(60, 117539)
local timerShieldOfDarknessCD  	= mod:NewNextTimer(42.5, 117697)
--Meng
local timerMaddeningShoutCD		= mod:NewCDTimer(47, 117708)--47-50 sec variation. So a CD timer instead of next.
local timerDeliriousCD			= mod:NewCDTimer(20.5, 117837, nil, mod:CanRemoveEnrage())
--Qiang
local timerAnnihilateCD			= mod:NewNextTimer(39, 117948)
local timerFlankingOrdersCD		= mod:NewCDTimer(40, 117910)--Every 40 seconds on normal, but on heroic it has a 40-50 second variation so has to be a CD bar instead of next
local timerImperviousShieldCD	= mod:NewCDTimer(42, 117961)
--Subetai
local timerVolleyCD				= mod:NewNextTimer(41, 118094)
local timerRainOfArrowsCD		= mod:NewNextTimer(50.5, 118122)
local timerPillageCD			= mod:NewNextTimer(41, 118047)
local timerSleightOfHandCD		= mod:NewCDTimer(42, 118162)
local timerSleightOfHand		= mod:NewBuffActiveTimer(11, 118162)--2+9 (cast+duration)

local timerJL					= mod:NewNextTimer(5, 117921)

local berserkTimer				= mod:NewBerserkTimer(600)

local specWarnDDL				= mod:NewSpecialWarning("specWarnDDL")
local specWarnQBH				= mod:NewSpecialWarning("specWarnQBH")
local specWarnQBHT				= mod:NewSpecialWarning("specWarnQBHT")
local specWarnDSoon				= mod:NewSpecialWarning("specWarnDSoon")

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For multiple abilities. the abiliies don't seem to target melee (unless a ranged is too close or a melee is too far.)

mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudMAP2", true, "sound")

mod:AddDropdownOption("optDD", {"nodd", "DD1", "DD2", "DD3", "DD4"}, "nodd", "sound")

mod:AddDropdownOption("optKZ", {"noKZ", "KZ1", "KZ2"}, "noKZ", "sound")


local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local PillageMarkers = {}
local FixatelMarkers = {}

local Zian = EJ_GetSectionInfo(5852)
local Meng = EJ_GetSectionInfo(5835)
local Qiang = EJ_GetSectionInfo(5841)
local Subetai = EJ_GetSectionInfo(5846)
local bossesActivated = {}
local zianActive = false
local mengActive = false
local qiangActive = false
local subetaiActive = false
local pinnedTargets = {}

local Warned = false
local fanshang = false

local mengfirstime = 0

local countzsb = 0

local countxk = 0
local diedShadow = {}
local shadowdd = 0
local ctdd = 0

local fixHdead = 0

local function warnPinnedDownTargets()
	warnPinnedDown:Show(table.concat(pinnedTargets, "<, >"))
	specWarnPinningArrow:Show()
	sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_yzjkd.mp3") --壓制箭快打
	table.wipe(pinnedTargets)
end

function mod:OnCombatStart(delay)
	zianActive = false
	mengActive = false
	qiangActive = false
	subetaiActive = false
	table.wipe(bossesActivated)
	table.wipe(pinnedTargets)
	table.wipe(diedShadow)
	table.wipe(PillageMarkers)
	table.wipe(FixatelMarkers)
	berserkTimer:Start(-delay)
	mengfirstime = 0
	Warned = false
	fanshang = false
	countzsb = 0
	countxk = 0
	shadowdd = 0
	ctdd = 0
	fixHdead = 0
	qiangActive = true
	timerAnnihilateCD:Start(10.5)
	timerFlankingOrdersCD:Start(25)
	sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zwjh.mp3") --戰王激活
	sndWOP:Schedule(21, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bczb.mp3")
	if self:IsDifficulty("heroic10", "heroic25") then
		timerImperviousShieldCD:Start(40.7)
		warnImperviousShieldSoon:Schedule(35.7)
		sndDSA:Schedule(37.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zwhd.mp3") -- 戰王護盾準備
		self:Schedule(37.5, function()
			if UnitName("target") == Qiang then
				specWarnDSoon:Show()
			end
		end)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.HudMAP or self.Options.HudMAP2 then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(117539) and not diedShadow[args.destGUID] then--They only ressurrect once so only start timer once per GUID
		diedShadow[args.destGUID] = true
		timerCoalescingShadowsCD:Start(args.destGUID)--Basically, the rez timer for a defeated Undying Shadow that is going to re-animate in 60 seconds.
	elseif args:IsSpellID(117837) then
		warnDelirious:Show(args.destName)
		specWarnDelirious:Show(args.destName)
		timerDeliriousCD:Start()
		if mod:CanRemoveEnrage() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\trannow.mp3") --快寧神
			sndWOP:Schedule(18, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kwjn.mp3")
		end
	elseif args:IsSpellID(117756) then
		warnCowardice:Show(args.destName)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_fsxt.mp3") --反傷形態
		Warned = false
		fanshang = true
	elseif args:IsSpellID(117737) then
		warnCrazed:Show(args.destName)
		mengfirstime = mengfirstime + 1
		if mengfirstime > 1 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_dkxt.mp3") --癲狂形態
		end
		Warned = false
		fanshang = false
	elseif args:IsSpellID(117697) then
			specWarnShieldOfDarknessD:Show(args.destName)
	elseif args:IsSpellID(117961) then
		if args.sourceGUID == UnitGUID("target") then
			specWarnImperviousShieldD:Show(args.destName)
		end
	elseif args:IsSpellID(118303) then
		warnFixate:Show(args.destName)
		timerFixate:Start(args.destName)
		if args:IsPlayer() then
			specWarnFixate:Show()
			yellFixate:Yell()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\shadowrun.mp3") --快跑 暗影點你
		elseif self:AntiSpam(10, 5) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_hqcx.mp3") --黑球出現
		end
		if self.Options.HudMAP2 then
			local spelltext = GetSpellInfo(118303).."-"..args.destName
			FixatelMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("targeting", args.destName, 3, nil, 1, 0, 0, 1):SetLabel(spelltext))
		end
	elseif args:IsSpellID(118135) then
		pinnedTargets[#pinnedTargets + 1] = args.destName
		self:Unschedule(warnPinnedDownTargets)
		self:Schedule(0.3, warnPinnedDownTargets)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(118303) then
		timerFixate:Cancel(args.destName)
		if FixatelMarkers[args.destName] then
			FixatelMarkers[args.destName] = free(FixatelMarkers[args.destName])
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(117685) then
		warnChargedShadows:Show(args.destName)
		timerChargingShadowsCD:Start()
	elseif args:IsSpellID(117506) then
		warnUndyingShadows:Show()
		if zianActive then
			timerUndyingShadowsCD:Start()
		else
			timerUndyingShadowsCD:Start(85)
		end
	elseif args:IsSpellID(117910) then
		warnFlankingOrders:Show()
		specWarnFlankingOrders:Show()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bczb.mp3")
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bckd.mp3") --包抄快躲
		if qiangActive then
			timerFlankingOrdersCD:Start()
			sndWOP:Schedule(37, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bczb.mp3") --包抄準備
		else
			timerFlankingOrdersCD:Start(75)
			sndWOP:Schedule(72, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bczb.mp3")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(118162) then
		warnSleightOfHand:Show(args.sourceName)
		if args.sourceGUID == UnitGUID("target") then
			specWarnSleightOfHand:Show(args.sourceName)
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\stopatk.mp3") --注意停手
			DBM.Flash:Shake(1, 0, 0)
		end
		timerSleightOfHand:Start()
		timerSleightOfHandCD:Start()
		sndDSA:Schedule(39, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_dwhd.mp3") -- 盜王護盾準備
		self:Schedule(39, function()
			if UnitName("target") == Subetai then
				specWarnDSoon:Show()
			end
		end)
		if mod.Options.optKZ == "KZ1" then
			sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzc.mp3") --快製裁
		elseif mod.Options.optKZ == "KZ2" then
			sndWOP:Schedule(5.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzc.mp3")
		end
	elseif args:IsSpellID(117506) then
		warnUndyingShadows:Show()
		timerUndyingShadowsCD:Start()
	elseif args:IsSpellID(117628) then
		shadowdd = shadowdd + 1	
		if ((mod.Options.optDD == "DD1") and (shadowdd % 4 == 1)) or ((mod.Options.optDD == "DD2") and (shadowdd % 4 == 2)) or ((mod.Options.optDD == "DD3") and (shadowdd % 4 == 3)) or ((mod.Options.optDD == "DD4") and (shadowdd % 4 == 0)) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3") --快打斷
			specWarnShadowBlast:Show(args.sourceName)
		end	
		if ((mod.Options.optDD == "DD1") and (shadowdd % 4 == 0)) or ((mod.Options.optDD == "DD2") and (shadowdd % 4 == 1)) or ((mod.Options.optDD == "DD3") and (shadowdd % 4 == 2)) or ((mod.Options.optDD == "DD4") and (shadowdd % 4 == 3)) then
			specWarnDDL:Schedule(2)
			sndWOP:Schedule(2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
		end
	elseif args:IsSpellID(117697) then
		warnShieldOfDarkness:Show(args.sourceName)
		warnShieldOfDarknessSoon:Schedule(37.5, 5)--Start pre warning with regular warnings only as you don't move at this point yet.
		warnShieldOfDarknessSoon:Schedule(38.5, 4)
		warnShieldOfDarknessSoon:Schedule(39.5, 3)
		warnShieldOfDarknessSoon:Schedule(40.5, 2)
		warnShieldOfDarknessSoon:Schedule(41.5, 1)
		timerShieldOfDarknessCD:Start()
		sndDSA:Schedule(39, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_wwhd.mp3") -- 巫王護盾準備
		self:Schedule(39, function()
			if UnitName("target") == Zian then
				specWarnDSoon:Show()
			end
		end)
		if args.sourceGUID == UnitGUID("target") then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\stopatk.mp3") --注意停手
			specWarnShieldOfDarkness:Show(args.sourceName)
			DBM.Flash:Shake(1, 0, 0)
		elseif mod:IsMagicDispeller() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zyhd.mp3") --注意护盾
			specWarnShieldOfDarkness:Show(args.sourceName)
			DBM.Flash:Shake(1, 0, 0)
		end
		if mod:IsMagicDispeller() then
			sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3") --快驅散
		end
	elseif args:IsSpellID(117833) then
		ctdd = ctdd + 1
		warnCrazyThought:Show()
		if zianActive then return end
		if (((mod.Options.optDD == "DD1") and (ctdd % 4 == 1)) or ((mod.Options.optDD == "DD2") and (ctdd % 4 == 2)) or ((mod.Options.optDD == "DD3") and (ctdd % 4 == 3)) or ((mod.Options.optDD == "DD4") and (ctdd % 4 == 0))) and (not Warned) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3") --快打斷
			specWarnCrazyThought:Show(args.sourceName)
		end		
		if (((mod.Options.optDD == "DD1") and (ctdd % 4 == 0)) or ((mod.Options.optDD == "DD2") and (ctdd % 4 == 1)) or ((mod.Options.optDD == "DD3") and (ctdd % 4 == 2)) or ((mod.Options.optDD == "DD4") and (ctdd % 4 == 3))) and (not Warned) then
			specWarnDDL:Schedule(1)
			sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
		end
	elseif args:IsSpellID(117708) then
		countxk = countxk + 1
		warnMaddeningShout:Show()
		specWarnMaddeningShout:Show()
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\findmc.mp3") --注意心控
		if mengActive then
			if countxk == 1 then
				timerMaddeningShoutCD:Start()
				sndWOP:Schedule(40, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
			else
				timerMaddeningShoutCD:Start(50)
				sndWOP:Schedule(45, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
			end
		else
			timerMaddeningShoutCD:Start(77)
			sndWOP:Schedule(75, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
		end
	elseif args:IsSpellID(117948) then
		warnAnnihilate:Show()
		specWarnAnnihilate:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerAnnihilateCD:Start(32.5)
		else
			timerAnnihilateCD:Start()
		end
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\shockwave.mp3") --震懾波
		timerJL:Start(8)
		countzsb = countzsb + 1
	elseif args:IsSpellID(117961) then
		warnImperviousShield:Show(args.sourceName)
		specWarnImperviousShield:Show(args.sourceName)
		if self:IsDifficulty("heroic10") then
			warnImperviousShieldSoon:Schedule(57)
			timerImperviousShieldCD:Start(62)
--			countdownImperviousShield:Start(62)
			sndDSA:Schedule(59, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zwhd.mp3") -- 戰王護盾準備
			self:Schedule(59, function()
				if UnitName("target") == Qiang then
					specWarnDSoon:Show()
				end
			end)
		else
			warnImperviousShieldSoon:Schedule(37)
			timerImperviousShieldCD:Start()
--			countdownImperviousShield:Start(42)
			sndDSA:Schedule(39, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zwhd.mp3") -- 戰王護盾準備
			self:Schedule(39, function()
				if UnitName("target") == Qiang then
					specWarnDSoon:Show()
				end
			end)
		end
		if isDispellerZ then
			specWarnImperviousShield:Show(args.sourceName)
			sndWOP:Schedule(1.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
			DBM.Flash:Shake(1, 0, 0)
		elseif args.sourceGUID == UnitGUID("target") then
			specWarnImperviousShield:Show(args.sourceName)
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\stopatk.mp3") --注意停手
			DBM.Flash:Shake(1, 0, 0)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 117558 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnCoalescingShadows:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	elseif spellId == 117921 and self:AntiSpam(2, 6) then--巨力攻擊
		if (countzsb == 0 and timerAnnihilateCD:GetTime() < 6) or (countzsb >= 1 and timerAnnihilateCD:GetTime() < 27) then
			timerJL:Start()
		else
			if self:IsDifficulty("heroic10", "heroic25") then
				if mod:IsTank() then
					specWarnQBHT:Show()
				else
					specWarnQBH:Show()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jmzb.mp3") -- 殲滅準備
				end
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE



function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 118088 and self:AntiSpam(2, 1) then--Volley
		warnVolley:Show()
		specWarnVolley:Show()
		timerVolleyCD:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zyjy.mp3") --注意箭雨
	elseif spellId == 118121 and self:AntiSpam(2, 2) then--Rain of Arrows
		if self:IsDifficulty("heroic10", "heroic25") then
			timerRainOfArrowsCD:Start(41)
		else
			timerRainOfArrowsCD:Start()
		end
--	"<63.5 21:23:16> [UNIT_SPELLCAST_SUCCEEDED] Qiang the Merciless [[boss1:Inactive Visual::0:118205]]", -- [14066]
--	"<63.5 21:23:16> [UNIT_SPELLCAST_SUCCEEDED] Qiang the Merciless [[boss1:Cancel Activation::0:118219]]", -- [14068]
	elseif spellId == 118205 and self:AntiSpam(2, 3) then--Inactive Visual
		if UnitName(uId) == Zian then
			zianActive = false
			timerChargingShadowsCD:Cancel()
			timerShieldOfDarknessCD:Cancel()
			sndDSA:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_wwhd.mp3")
			warnShieldOfDarknessSoon:Cancel()
			timerUndyingShadowsCD:Start(30)--This boss retains Undying Shadows
			if self.Options.RangeFrame and not subetaiActive then--Close range frame, but only if zian is also not active, otherwise we still need it
				DBM.RangeCheck:Hide()
			end
		elseif UnitName(uId) == Meng then
			mengActive = false
			timerDeliriousCD:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kwjn.mp3")
			timerMaddeningShoutCD:Start(30)--This boss retains Maddening Shout
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
			sndWOP:Schedule(28, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
		elseif UnitName(uId) == Qiang then
			qiangActive = false
			timerJL:Cancel()
			timerAnnihilateCD:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jmzb.mp3")
			timerImperviousShieldCD:Cancel()
			sndDSA:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zwhd.mp3")
			warnImperviousShieldSoon:Cancel()
			timerFlankingOrdersCD:Start(30)--This boss retains Flanking Orders
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bczb.mp3")
			sndWOP:Schedule(27, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_bczb.mp3")
		elseif UnitName(uId) == Subetai then
			subetaiActive = false
			timerVolleyCD:Cancel()
			timerRainOfArrowsCD:Cancel()
			timerSleightOfHandCD:Cancel()
			sndDSA:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_dwhd.mp3")
			timerPillageCD:Start(30)--This boss retains Pillage
			if self.Options.RangeFrame and not zianActive then--Close range frame, but only if subetai is also not active, otherwise we still need it
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:118047") then
		local target = DBM:GetUnitFullName(target)
		if subetaiActive then
			timerPillageCD:Start()
		else
			timerPillageCD:Start(75)
		end
		if target then
			warnPillage:Show(target)
			if self.Options.HudMAP then
				local spelltext = GetSpellInfo(118047)
				PillageMarkers[target] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", target, 9, 3, 0, 1, 0, 0.4):RegisterForAlerts(true, spelltext))
			end
			if target == UnitName("player") then
				specWarnPillage:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
				local uId = DBM:GetRaidUnitId(target)
				if uId then
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					local inRange = DBM.RangeCheck:GetDistance("player", x, y)
					if inRange and inRange < 9 then
						specWarnPillage:Show()
						sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
					end
				end
			end
		end
	end
end

--Phase change controller. Even for pull.
function mod:CHAT_MSG_MONSTER_YELL(msg, boss)
	if not self:IsInCombat() or bossesActivated[boss] then return end--Ignore yells out of combat or from bosses we already activated.
	if not bossesActivated[boss] then bossesActivated[boss] = true end--Once we activate off bosses first yell, add them to ignore.
	if boss == Zian then
		warnActivated:Show(boss)
		zianActive = true
		timerChargingShadowsCD:Start()
		timerUndyingShadowsCD:Start(20)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_wwjh.mp3") --巫王激活
		if mod.Options.optDD == "DD1" then
			specWarnDDL:Schedule(1)
			sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			warnShieldOfDarknessSoon:Schedule(35, 5)--Start pre warning with regular warnings only as you don't move at this point yet.
			warnShieldOfDarknessSoon:Schedule(36, 4)
			warnShieldOfDarknessSoon:Schedule(37, 3)
			warnShieldOfDarknessSoon:Schedule(38, 2)
			warnShieldOfDarknessSoon:Schedule(39, 1)
			timerShieldOfDarknessCD:Start(40)
			sndDSA:Schedule(37.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_wwhd.mp3") -- 巫王護盾準備
			self:Schedule(37.5, function()
				if UnitName("target") == Zian then
					specWarnDSoon:Show()
				end
			end)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(118303))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 118303)
		end
	elseif boss == Meng then
		warnActivated:Show(boss)
		mengActive = true
		if self:IsDifficulty("heroic10", "heroic25") then
			timerDeliriousCD:Start()
			if mod:CanRemoveEnrage() then
				sndWOP:Schedule(18, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kwjn.mp3") -- 狂王激怒準備
			end
			timerMaddeningShoutCD:Start(40)
			sndWOP:Schedule(35, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
		else
			timerMaddeningShoutCD:Start(20.5)
			sndWOP:Schedule(15, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jknh.mp3")
		end
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kwjh.mp3") --狂王激活
		if mod.Options.optDD == "DD1" then
			specWarnDDL:Schedule(1)
			sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\interruptsoon.mp3") --打斷準備
		end
	elseif boss == Qiang then
		warnActivated:Show(boss)
	elseif boss == Subetai then
		warnActivated:Show(boss)
		subetaiActive = true
		timerVolleyCD:Start(5)
		timerPillageCD:Start(25)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_dwjh.mp3") --盜王激活
		if self:IsDifficulty("heroic10", "heroic25") then
			timerSleightOfHandCD:Start(40.7)
			timerRainOfArrowsCD:Start(40)
			sndDSA:Schedule(37.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_dwhd.mp3") -- 盜王護盾準備
			self:Schedule(37.5, function()
				if UnitName("target") == Subetai then
					specWarnDSoon:Show()
				end
			end)
		else
			timerRainOfArrowsCD:Start(15)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
	end
end

function mod:UNIT_POWER(uId)
	if (self:GetUnitCreatureId(uId) == 60708) and UnitPower(uId) > 60 and not Warned then
		Warned = true
		if (not mod:IsDps()) or ((UnitGUID(uId) == UnitGUID("target")) and fanshang) then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\energyhigh.mp3") --能量過高
		end
	end
end