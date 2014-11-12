﻿local mod	= DBM:NewMod(870, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11358 $"):sub(12, -3))
mod:SetCreatureID(73720, 71512)
mod:SetEncounterID(1594)
mod:SetMinSyncRevision(10768)
mod:SetHotfixNoticeRev(10768)
mod:SetZone()

--Can use IEEU to engage now, it's about 4 seconds slower but better than registering an out of combat CLEU event in entire zone.
--"<10.8 23:23:13> [CLEU] SPELL_CAST_SUCCESS#false#0xF13118D10000674F#Secured Stockpile of Pandaren Spoils#2632#0##nil#-2147483648#-2147483648#145687#Unstable Defense Systems#1", -- [169]
--"<14.2 23:23:16> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Mogu Spoils#0xF1311FF800006750#elite#1#1#1#Mantid Spoils#0xF131175800006752
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SWING_DAMAGE",
	"SWING_MISSED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_WHISPER",
	"UPDATE_WORLD_STATES"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnSuperNova				= mod:NewCastAnnounce(146815, 4, nil, false, nil, nil, nil, nil, 2)--Heroic
--Massive Crate of Goods
----Mogu
local warnReturnToStone			= mod:NewSpellAnnounce(145489, 2)
----Mantid
local warnSetToBlow				= mod:NewTargetAnnounce(145987, 4)--145996 is cast ID
--Stout Crate of Goods
----Mogu
local warnForbiddenMagic		= mod:NewTargetAnnounce(145230, 2)
local warnMatterScramble		= mod:NewSpellAnnounce(145288, 3)
local warnCrimsonRecon			= mod:NewSpellAnnounce(142947, 4, nil, mod:IsTank(), nil, nil, nil, nil, 2)
local warnEnergize				= mod:NewSpellAnnounce(145461, 3)--May be script spellid that doesn't show in combat log
local warnTorment				= mod:NewSpellAnnounce(142934, 3, nil, mod:IsHealer())
----Mantid
local warnMantidSwarm			= mod:NewSpellAnnounce(142539, 3, nil, mod:IsTank())
local warnResidue				= mod:NewCastAnnounce(145786, 4, nil, nil, mod:IsMagicDispeller())
local warnRageoftheEmpress		= mod:NewCastAnnounce(145812, 4, nil, nil, mod:IsMagicDispeller())
local warnWindStorm				= mod:NewSpellAnnounce(145286, 3)
local warnEnrage				= mod:NewTargetAnnounce(145692, 3, nil, mod:IsTank() or mod:CanRemoveEnrage())--Do not have timer for this yet, add not alive long enough.
--Lightweight Crate of Goods
----Mogu
local warnHardenFlesh			= mod:NewSpellAnnounce(144922, 2, nil, false)
local warnEarthenShard			= mod:NewSpellAnnounce(144923, 2, nil, false)
local warnSparkofLife			= mod:NewSpellAnnounce(142694, 3, nil, false)
--Crate of Pandaren Relics
local warnBreathofFire			= mod:NewSpellAnnounce(146222, 3)--Do not have timer for this yet, add not alive long enough.
local warnGustingCraneKick		= mod:NewSpellAnnounce(146180, 3)

local specWarnSuperNova			= mod:NewSpecialWarningSpell(146815, false, nil, nil, 2, 2)
--Massive Crate of Goods
local specWarnSetToBlowYou		= mod:NewSpecialWarningYou(145987)
local specWarnSetToBlow			= mod:NewSpecialWarningPreWarn(145996, nil, 4, nil, 3)
--Stout Crate of Goods
----Mogu
local specWarnForbiddenMagic	= mod:NewSpecialWarningInterrupt(145230, mod:IsMelee())
local specWarnMatterScramble	= mod:NewSpecialWarningSpell(145288, nil, nil, nil, 2)
local specWarnCrimsonRecon		= mod:NewSpecialWarningMove(142947, mod:IsTank(), nil, nil, 3)
local specWarnTorment			= mod:NewSpecialWarningSpell(142934, mod:IsHealer())
----Mantid
local specWarnMantidSwarm		= mod:NewSpecialWarningSpell(142539, mod:IsTank())
local specWarnResidue			= mod:NewSpecialWarningSpell(145786, mod:IsMagicDispeller())
local specWarnRageoftheEmpress	= mod:NewSpecialWarningSpell(145812, mod:IsMagicDispeller())
local specWarnEnrage			= mod:NewSpecialWarningDispel(145692, mod:CanRemoveEnrage())--Question is, do we want to dispel it? might make this off by default since kiting it may be more desired than dispeling it
--Lightweight Crate of Goods
----Mogu
local specWarnHardenFlesh		= mod:NewSpecialWarningInterrupt(144922, false)
local specWarnEarthenShard		= mod:NewSpecialWarningInterrupt(144923, false)
----Mantid
local specWarnBlazingCharge		= mod:NewSpecialWarningMove(145716)
local specWarnBubblingAmber		= mod:NewSpecialWarningMove(145748)
local specWarnPathOfBlossoms	= mod:NewSpecialWarningMove(146257)
--Crate of Pandaren Relics
local specWarnGustingCraneKick	= mod:NewSpecialWarningSpell(146180, nil, nil, nil, 2)

local timerCombatStarts			= mod:NewCombatTimer(18)
--Massive Crate of Goods
local timerReturnToStoneCD		= mod:NewNextTimer(12, 145489)
local timerSetToBlowCD			= mod:NewNextTimer(9.6, 145996)
local timerSetToBlow			= mod:NewBuffFadesTimer(30, 145996)
--Stout Crate of Goods
local timerMatterScrambleCD		= mod:NewCDTimer(18, 145288)--18-22 sec variation. most of time it's 20 exactly, unsure what causes the +-2 variations
local timerCrimsonReconCD		= mod:NewNextTimer(15, 142947)
local timerMantidSwarmCD		= mod:NewCDTimer(35, 142539)
local timerResidueCD			= mod:NewCDTimer(18, 145786, nil, mod:IsMagicDispeller())
local timerWindstormCD			= mod:NewCDTimer(34, 145286, nil, false)--Spammy but might be useful to some, if they aren't releasing a ton of these at once.
local timerRageoftheEmpressCD	= mod:NewCDTimer(18, 145812, nil, mod:IsMagicDispeller())
--Lightweight Crate of Goods
----Most of these timers are included simply because of how accurate they are. Predictable next timers. However, MANY of these adds up at once.
----They are off by default and a user elected choice to possibly pick one specific timer they are in charge of dispeling/interrupting or whatever
local timerEnrage				= mod:NewTargetTimer(10, 145692)
local timerHardenFleshCD		= mod:NewNextTimer(8, 144922, nil, false)
local timerEarthenShardCD		= mod:NewNextTimer(10, 144923, nil, false)
local timerBlazingChargeCD		= mod:NewNextTimer(12, 145712, nil, false)
--Crate of Pandaren Relics
local timerGustingCraneKickCD	= mod:NewCDTimer(18, 146180)
local timerPathOfBlossomsCD		= mod:NewCDTimer(15, 146253)

--local countdownSetToBlow		= mod:NewCountdownFades(29, 145996)

--Berserk Timer stuff
local berserkTimer				= mod:NewTimer(480, DBM_CORE_GENERIC_TIMER_BERSERK, 28131, nil, "timer_berserk")
local countdownBerserk			= mod:NewCountdown(20, 26662, nil, nil, 10, nil, true)
local berserkWarning1			= mod:NewAnnounce(DBM_CORE_GENERIC_WARNING_BERSERK, 1, nil, "warning_berserk", false)
local berserkWarning2			= mod:NewAnnounce(DBM_CORE_GENERIC_WARNING_BERSERK, 4, nil, "warning_berserk", false)

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("LTZD", true, "sound")
mod:AddBoolOption("Filterarea", true, "sound")

local bossDamageTarget = {}
local worldTimer = 0
local maxTimer = 0

local function checkTankDistance(guid)
	local uId, _
	if mod.Options.Filterarea then
		uId = bossDamageTarget[guid]
	else
		_, uId = mod:GetBossTarget(guid)
	end
	if uId then
		local inRange, checkedRange = UnitInRange(uId)
		if checkedRange then
			return inRange
		else
			return true
		end
	end
	return false
end

local function warnspecmob(guid)
	if not checkTankDistance(guid) then return end
	local cid = mod:GetCIDFromGUID(guid)
	if cid == 71382 then
		if mod:IsDps() or mod:IsTank() then
			sndWOP:Play("ex_so_hpkd") --花瓶快打
		end
	elseif cid == 71395 then
		if mod:IsDps() then
			sndWOP:Play("ex_so_mxkd") --魔像快打
		else
			sndWOP:Play("ex_so_mxcx") --魔像出现
		end
	elseif cid == 71385 then
		sndWOP:Play("ex_so_tdsd") --投彈手快打
	elseif cid == 71388 then
		if mod:IsDps() or mod:IsTank() then
			sndWOP:Play("ex_so_hupd") --琥珀快打
		end
	end
end

local function hideRangeFrame()
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(bossDamageTarget)
	worldTimer = 0
	maxTimer = 0
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.LTZD then
		DBM:HideLTSpecialWarning()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 145996 and checkTankDistance(args.sourceGUID) then
		timerSetToBlowCD:Start(args.sourceGUID)
	elseif args.spellId == 145288 and checkTankDistance(args.sourceGUID) then
		warnMatterScramble:Show()
		specWarnMatterScramble:Show()
		timerMatterScrambleCD:Start(args.sourceGUID)
		sndWOP:Play("stepring") --注意踩圈
	elseif args.spellId == 145461 and checkTankDistance(args.sourceGUID) then
		warnEnergize:Show()
		sndWOP:Play("ex_so_llfw") --力量符文
	elseif args.spellId == 142934 and checkTankDistance(args.sourceGUID) then
		warnTorment:Show()
		specWarnTorment:Show()
		if mod:IsHealer() then
			sndWOP:Play("ex_so_zmcx") --折磨出現
		end
	elseif args.spellId == 142539 and checkTankDistance(args.sourceGUID) then
		warnMantidSwarm:Show()
		specWarnMantidSwarm:Show()
		timerMantidSwarmCD:Start(args.sourceGUID)
		if mod:IsDps() or mod:IsTank() then
			sndWOP:Play("ex_so_zhcq") --召喚蟲群
		end
	elseif args.spellId == 145816 and checkTankDistance(args.sourceGUID) then
		warnWindStorm:Show()
		timerWindstormCD:Start(args.sourceGUID)
	elseif args.spellId == 144922 and checkTankDistance(args.sourceGUID) then
		local source = args.sourceName
		warnHardenFlesh:Show()
		timerHardenFleshCD:Start(args.sourceGUID)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnHardenFlesh:Show(source)
			sndWOP:Play("kickcast") --快打斷
		end
	elseif args.spellId == 144923 and checkTankDistance(args.sourceGUID) then
		local source = args.sourceName
		warnEarthenShard:Show()
		timerEarthenShardCD:Start(args.sourceGUID)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnEarthenShard:Show(source)
		end
	elseif args.spellId == 146222 and checkTankDistance(args.sourceGUID) then
		warnBreathofFire:Show()
	elseif args.spellId == 146180 and checkTankDistance(args.sourceGUID) then
		warnGustingCraneKick:Show()
		specWarnGustingCraneKick:Show()
		timerGustingCraneKickCD:Start(args.sourceGUID)
		sndWOP:Play("ex_so_xft") --旋風準備
	elseif args.spellId == 145489 and checkTankDistance(args.sourceGUID) then
		warnReturnToStone:Show()
		timerReturnToStoneCD:Start(args.sourceGUID)
	elseif args.spellId == 142947 and checkTankDistance(args.sourceGUID) then--Pre warn more or less
		warnCrimsonRecon:Show()
	elseif args.spellId == 146815 and self:AntiSpam(2, 4)  then--Will do more work on this later, not enough time before raid, but i have an idea for it
		warnSuperNova:Show()
		specWarnSuperNova:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142694 and checkTankDistance(args.sourceGUID) then
		warnSparkofLife:Show()
--		specWarnSparkofLife:Show()
	elseif args.spellId == 142947 and checkTankDistance(args.sourceGUID) then
		specWarnCrimsonRecon:Show()--Done here because we want to warn when we need to move mobs, not on cast start (when we can do nothing)
		timerCrimsonReconCD:Start(args.sourceGUID)
		if mod:IsTank() then
			sndWOP:Play("bossout") --拉開BOSS
		end
	elseif args.spellId == 145712 and checkTankDistance(args.sourceGUID) then
		timerBlazingChargeCD:Start(args.sourceGUID)
	elseif args.spellId == 146253 and checkTankDistance(args.sourceGUID) then
		timerPathOfBlossomsCD:Start(args.sourceGUID)
	elseif args.spellId == 145230 and checkTankDistance(args.sourceGUID) then
		local source = args.sourceName
		warnForbiddenMagic:Show(args.destName)
		if source == UnitName("target") or source == UnitName("focus") then 
			specWarnForbiddenMagic:Show(source)
			sndWOP:Play("kickcast") --快打斷
		end
	elseif args.spellId == 145786 and checkTankDistance(args.sourceGUID) then
		warnResidue:Show()
		timerResidueCD:Start(args.sourceGUID)
		specWarnResidue:Show()
		if mod:IsMagicDispeller() then
			sndWOP:Play("dispelnow") --快驅散
		end
	elseif args.spellId == 145812 and checkTankDistance(args.sourceGUID) then
		warnRageoftheEmpress:Show()
		specWarnRageoftheEmpress:Show()
		timerRageoftheEmpressCD:Start(args.sourceGUID)
		if mod:IsMagicDispeller() then
			sndWOP:Play("dispelnow") --快驅散
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145987 and checkTankDistance(args.sourceGUID) then
		warnSetToBlow:CombinedShow(0.5, args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 10) then
			specWarnSetToBlowYou:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("runout") --離開人群
--			countdownSetToBlow:Start()
			timerSetToBlow:Start(15)
			specWarnSetToBlow:Schedule(10)
			sndWOP:Schedule(10, "bombnow") --準備爆炸
			sndWOP:Schedule(11, "countfour")
			sndWOP:Schedule(12, "countthree")
			sndWOP:Schedule(13, "counttwo")
			sndWOP:Schedule(14, "countone")
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)--Range assumed, spell tooltips not informative enough
				self:Schedule(16, hideRangeFrame)
			end
			if self.Options.LTZD then
				DBM:ShowLTSpecialWarning(145987, 1, 0, 0, 1, 145987, 15, 15)
			end
		end
	elseif args.spellId == 145692 and checkTankDistance(args.sourceGUID) then
		warnEnrage:Show(args.destName)
		specWarnEnrage:Show(args.destName)
		timerEnrage:Start(args.destName)
		if mod:IsTank() or mod:CanRemoveEnrage() then
			local source = args.sourceName
			if (source == UnitName("target") or source == UnitName("focus")) and mod:IsTank() then
				sndWOP:Play("enrage") -- 激怒
			elseif mod:CanRemoveEnrage() then
				sndWOP:Play("trannow") -- 注意寧神
			end
		end
	elseif args.spellId == 145998 and checkTankDistance(args.sourceGUID) then--This is a massive crate mogu spawning
		timerReturnToStoneCD:Start(6)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 145987 and args:IsPlayer() then
--		countdownSetToBlow:Cancel()
		timerSetToBlow:Cancel()
		specWarnSetToBlow:Cancel()
		sndWOP:Cancel("bombnow")
		sndWOP:Cancel("countfour")
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
		if self.Options.LTZD then
			DBM:HideLTSpecialWarning()
		end
	elseif args.spellId == 145692 then
		timerEnrage:Cancel(args.destName)
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId)
	if spellId == 145716 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnBlazingCharge:Show()
		sndWOP:Play("runaway") --快躲開
	elseif spellId == 145748 and destGUID == UnitGUID("player") and self:AntiSpam(2, 2) then
		specWarnBubblingAmber:Show()
		sndWOP:Play("runaway") --快躲開
	elseif spellId == 146257 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnPathOfBlossoms:Show()
		sndWOP:Play("runaway") --快躲開
	end
	if self.Options.Filterarea then
		if (not bossDamageTarget[sourceGUID]) then
			local uId = DBM:GetRaidUnitId(destName)
			if uId then
				bossDamageTarget[sourceGUID] = uId
				warnspecmob(sourceGUID)
			end
		end
		if (not bossDamageTarget[destGUID]) then
			local uId = DBM:GetRaidUnitId(sourceName)
			if uId then
				bossDamageTarget[destGUID] = uId
				warnspecmob(destGUID)
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID, sourceName, _, _, destGUID, destName)
	if self.Options.Filterarea then
		if (not bossDamageTarget[sourceGUID]) then
			local uId = DBM:GetRaidUnitId(destName)
			if uId then
				bossDamageTarget[sourceGUID] = uId
				warnspecmob(sourceGUID)
			end
		end
		if (not bossDamageTarget[destGUID]) then
			local uId = DBM:GetRaidUnitId(sourceName)
			if uId then
				bossDamageTarget[destGUID] = uId
				warnspecmob(destGUID)
			end
		end
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71408 then--Shao-Tien Colossus
		timerReturnToStoneCD:Cancel(args.destGUID)
	elseif cid == 71409 then--Ka'thik Demolisher
		timerSetToBlowCD:Cancel(args.destGUID)
	elseif cid == 71395 then--Modified Anima Golem
		timerMatterScrambleCD:Cancel(args.destGUID)
		timerCrimsonReconCD:Cancel(args.destGUID)
	elseif cid == 71397 then--Ka'thik Swarmleader
		timerMantidSwarmCD:Cancel(args.destGUID)
		timerResidueCD:Cancel(args.destGUID)
	elseif cid == 71405 then--Ka'thik Wind Wielder
		timerWindstormCD:Cancel(args.destGUID)
		timerRageoftheEmpressCD:Cancel(args.destGUID)
	elseif cid == 71380 then--Animated Stone Mogu
		timerHardenFleshCD:Cancel(args.destGUID)
		timerEarthenShardCD:Cancel(args.destGUID)
	elseif cid == 71385 then--Ka'thik Bombardier
		timerBlazingChargeCD:Cancel(args.destGUID)
	elseif cid == 72810 then--Wise Mistweaver Spirit
		timerGustingCraneKickCD:Cancel(args.destGUID)
	elseif cid == 72828 then--Nameless Windwalker Spirit
		timerPathOfBlossomsCD:Cancel(args.destGUID)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.wasteOfTime then
		self:SendSync("prepull")
	end
end

function mod:UPDATE_WORLD_STATES()
	local text = select(4, GetWorldStateUIInfo(5))
	local time = tonumber(string.match(text or "", "%d+"))
	if not time then return end
	if time > worldTimer then
		maxTimer = time
		berserkTimer:Cancel()
		countdownBerserk:Cancel()
		berserkTimer:Start(time+1)
	end
	if time % 10 == 0 then
		berserkTimer:Update(maxTimer-time-1, maxTimer)
		if time == 300 and self.Options["timer_berserk"] then
			berserkWarning1:Show(5, DBM_CORE_MIN)
		elseif time == 180 and self.Options["timer_berserk"] then
			berserkWarning1:Show(3, DBM_CORE_MIN)
		elseif time == 60 and self.Options["timer_berserk"] then
			berserkWarning2:Show(1, DBM_CORE_MIN)
		elseif time == 30 and self.Options["timer_berserk"] then
			berserkWarning2:Show(30, DBM_CORE_SEC)
		elseif time == 20 then
			countdownBerserk:Start()
		elseif time == 10 and self.Options["timer_berserk"] then
			berserkWarning2:Show(10, DBM_CORE_SEC)
		end
	end
	worldTimer = time
end

function mod:OnSync(msg)
	if msg == "prepull" then
		timerCombatStarts:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_WHISPER(msg)
	if msg:find("spell:145996") and self:AntiSpam(3, 10) then
		specWarnSetToBlowYou:Show()
		DBM.Flash:Shake(1, 0, 0)
		sndWOP:Play("runout") --離開人群
--		countdownSetToBlow:Start()
		timerSetToBlow:Start(15)
		specWarnSetToBlow:Schedule(10)
		sndWOP:Schedule(10, "bombnow") --準備爆炸
		sndWOP:Schedule(11, "countfour")
		sndWOP:Schedule(12, "countthree")
		sndWOP:Schedule(13, "counttwo")
		sndWOP:Schedule(14, "countone")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)--Range assumed, spell tooltips not informative enough
			self:Schedule(16, hideRangeFrame)
		end
		if self.Options.LTZD then
			--DBM:ShowLTSpecialWarning(145987, 1, 0, 0, 1, 145987, 15, 15)
		end
	end
end
