local mod	= DBM:NewMod(816, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
--BH ADD
local sndWOP	= mod:SoundMM("SoundWOP")
local sndSpirit	= mod:SoundMM("Soundspirit")

mod:SetRevision(("$Revision: 11365 $"):sub(12, -3))
mod:SetCreatureID(69078, 69132, 69134, 69131)--69078 Sul the Sandcrawler, 69132 High Prestess Mar'li, 69131 Frost King Malakk, 69134 Kazra'jin --Adds: 69548 Shadowed Loa Spirit,
mod:SetEncounterID(1570)
mod:SetZone()
mod:SetUsedIcons(7, 6)
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5"
)

local Sul = EJ_GetSectionInfo(7049)
local Malakk = EJ_GetSectionInfo(7047)
local Marli = EJ_GetSectionInfo(7050)
local Kazrajin = EJ_GetSectionInfo(7048)

mod:SetBossHealthInfo(
	69078, Sul,
	69131, Malakk,
	69132, Marli,
	69134, Kazrajin
)

--All
local warnPossessed					= mod:NewStackAnnounce(136442, 2, nil, nil, "warnPossessed")

--Sul the Sandcrawler
local warnSandBolt					= mod:NewCountAnnounce(136189, 3, nil, false)--Spammy but important for heroic for internet rotation.
local warnQuicksand					= mod:NewSpellAnnounce(136521, 2)
local warnSandstorm					= mod:NewSpellAnnounce(136894, 3)
--High Prestess Mar'li
local warnBlessedLoaSpirit			= mod:NewSpellAnnounce(137203, 4)
local warnShadowedLoaSpirit			= mod:NewSpellAnnounce(137350, 4)
local warnSoulTaget					= mod:NewTargetAnnounce(136857, 4)
local warnMarkedSoul				= mod:NewTargetAnnounce(137359, 4)--Shadowed Loa Spirit fixate target, no need to warn for Shadowed Loa Spirit AND this, so we just warn for this
local warnTwistedFate				= mod:NewSpellAnnounce(137891, 4)--Heroic Only
--Frost King Malak
local warnBitingCold				= mod:NewTargetAnnounce(136992, 3)--136917 is cast ID version, 136992 is player debuff
local warnFrostBite					= mod:NewTargetAnnounce(136922, 4)--136990 is cast ID version, 136922 is player debuff
local warnFrigidAssault				= mod:NewStackAnnounce(136903, 3, nil, mod:IsTank() or mod:IsHealer())
--Kazra'jin
local warnRecklessCharge			= mod:NewCastAnnounce(137122, 3, 2, nil, false)
local warnDischarge					= mod:NewCountAnnounce(137166, 3)

--All
local specWarnPossessed				= mod:NewSpecialWarning("specWarnPossessed", mod:IsDps())
local specWarnDarkPower				= mod:NewSpecialWarningSpell(136507, nil, nil, nil, 2)
local specWarnSoulFragment			= mod:NewSpecialWarningYou(137641)
--Sul the Sandcrawler
local specWarnSandBolt				= mod:NewSpecialWarningInterrupt(136189, false)
local specWarnSandStorm				= mod:NewSpecialWarningSpell(136894, nil, nil, nil, 2)
local specWarnQuickSand				= mod:NewSpecialWarningMove(136860)
--High Prestess Mar'li
local specWarnBlessedLoaSpirit		= mod:NewSpecialWarningSwitch(137203, mod:IsRangedDps())--Ranged should handle this, melee chasing it around is huge dps loss for possessed. On 10 man 2 ranged was enough. If you do not have 2 ranged, 1 or 2 melee will have to help and probably turn this on manually
local specWarnShadowedLoaSpirit		= mod:NewSpecialWarningSwitch(137350, mod:IsRangedDps())
local specWarnMarkedSoul			= mod:NewSpecialWarningRun(137359)
local specWarnTwistedFate			= mod:NewSpecialWarningSwitch(137891)
--Frost King Malak
local specWarnBitingCold			= mod:NewSpecialWarningYou(136992)
local yellBitingCold				= mod:NewYell(136992)--This one you just avoid so chat bubble is useful
local specWarnFrostBite				= mod:NewSpecialWarningYou(136922)--This one you do not avoid you clear it hugging people so no chat bubble
local specWarnFrigidAssault			= mod:NewSpecialWarningStack(136903, mod:IsTank(), 9)
local specWarnFrigidAssaultOther	= mod:NewSpecialWarningTarget(136903, mod:IsTank())
local specWarnChilled				= mod:NewSpecialWarningYou(137085, false)--Heroic
--Kazra'jin
local specWarnDischarge				= mod:NewSpecialWarningCount(137166, nil, nil, nil, 2)
--BH ADD
local specWarnSP					= mod:NewSpecialWarningStack(137650, nil, 5)
local specWarnDDL					= mod:NewSpecialWarning("specWarnDDL")

--All
local timerDarkPowerCD				= mod:NewCDTimer(68, 136507)
--Kazra'jin
local timerRecklessChargeCD			= mod:NewCDTimer(6, 137122, nil, false)
--Sul the Sandcrawler
local timerQuickSandCD				= mod:NewCDTimer(35, 136521)
local timerSandStormCD				= mod:NewCDTimer(35, 136894)
--High Prestess Mar'li
local timerBlessedLoaSpiritCD		= mod:NewCDTimer(33, 137203)--Every 33-35 seconds.
local timerShadowedLoaSpiritCD		= mod:NewCDTimer(33, 137350)--Possessed version of above, shared CD
local timerTwistedFateCD			= mod:NewCDTimer(33, 137891)--On heroic, this replaces shadowed loa spirit
local timerMarkedSoul				= mod:NewTargetTimer(20, 137359)
--Frost King Malak
local timerBitingCold				= mod:NewBuffFadesTimer(30, 136917)
local timerBitingColdCD				= mod:NewCDTimer(45, 136917)--10 man Cds (and probably LFR), i have no doubt on 25 man this will either have a shorter cd or affect 3 targets with same CD. Watch for timer diffs though
local timerFrostBite				= mod:NewBuffFadesTimer(30, 136990)
local timerFrostBiteCD				= mod:NewCDTimer(45, 136990)--^same comment as above
local timerFrigidAssault			= mod:NewTargetTimer(15, 136903)
local timerFrigidAssaultCD			= mod:NewCDTimer(30, 136904)--30 seconds after last one ended (maybe even a next timer, i'll change it with more logs.)
--Kazra'jin

-- BH DELETE local soundMarkedSoul				= mod:NewSound(137359)

local berserkTimer					= mod:NewBerserkTimer(720)

-- BH DELETE mod:AddBoolOption("HealthFrame", true)
mod:AddBoolOption("PHealthFrame", true)
mod:AddBoolOption("RangeFrame")--For Sand Bolt and charge and biting cold
mod:AddBoolOption("SetIconOnBitingCold", true)
mod:AddBoolOption("SetIconOnFrostBite", true)

-- BH ADD
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudMAP2", true, "sound")
for i = 1, 3 do
	mod:AddBoolOption("dr"..i, false, "sound")
end
mod:AddDropdownOption("optDD", {"nodd", "DD1", "DD2", "DD3"}, "nodd", "sound")
mod:AddDropdownOption("optOC", {"five", "ten", "none"}, "five", "sound")
mod:AddEditBoxOption("helpcold", 150, "", "sound")
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end


-- BH ADD END

local lingeringPresence = GetSpellInfo(136467)
local chilledDebuff = GetSpellInfo(137085)
local boltCasts = 0
local kazraPossessed = false
local possessesDone = 0
local dischargeCount = 0
local chilledWarned = false
local darkPowerWarned = false

--BH ADD
local BitingColdMarkers = {}
local FrostBiteMarkers = {}
local coldsend = false
local coldDebuff = GetSpellInfo(137084)
local Sulcount = 0
local Malcount = 0
local Marlicount = 0
local Kazcount = 0
local speedcheck = 0
local OCn = 0

local function MyJS()
	if (mod.Options.dr1 and dischargeCount == 1) or (mod.Options.dr2 and dischargeCount == 2) or (mod.Options.dr3 and dischargeCount == 3) then
		return true
	end
	return false
end
--BH ADD END

local showDamagedHealthBar, hideDamagedHealthBar
do
	local frame = CreateFrame("Frame") -- using a separate frame avoids the overhead of the DBM event handlers which are not meant to be used with frequently occuring events like all damage events...
	local damagedMob
	local hpRemaining = 0
	local maxhp = 0
	local function getDamagedHP()
		return math.max(1, math.floor(hpRemaining / maxhp * 100))
	end
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	frame:SetScript("OnEvent", function(self, event, timestamp, subEvent, _, _, _, _, _, destGUID, _, _, _, ...)
		if damagedMob == destGUID then
			local damage
			if subEvent == "SWING_DAMAGE" then 
				damage = select( 1, ... ) 
			elseif subEvent == "RANGE_DAMAGE" or subEvent == "SPELL_DAMAGE" or subEvent == "SPELL_PERIODIC_DAMAGE" then 
				damage = select( 4, ... )
			end
			if damage then
				hpRemaining = hpRemaining - damage
			end
		end
	end)
	
	function showDamagedHealthBar(self, mob, spellName, health)
		damagedMob = mob
		hpRemaining = health
		maxhp = health
		DBM.BossHealth:RemoveBoss(getDamagedHP)
		DBM.BossHealth:AddBoss(getDamagedHP, spellName)
	end
	
	function hideDamagedHealthBar()
		DBM.BossHealth:RemoveBoss(getDamagedHP)
	end
end

function mod:OnCombatStart(delay)
	--BH ADD
	table.wipe(BitingColdMarkers)
	table.wipe(FrostBiteMarkers)
	coldsend = false
	Sulcount = 0
	Malcount = 0
	Marlicount = 0
	Kazcount = 0
	speedcheck = 0
	OCn = 0
	--BH ADD END
	kazraPossessed = false
	chilledWarned = false
	darkPowerWarned = false
	possessesDone = 0
	boltCasts = 0
	timerQuickSandCD:Start(8-delay)
	sndWOP:Schedule(3, DBM.SoundMMPath.."\\ex_tt_lszb.ogg") --流沙準備
	sndWOP:Schedule(4, DBM.SoundMMPath.."\\countthree.ogg")
	sndWOP:Schedule(5, DBM.SoundMMPath.."\\counttwo.ogg")
	sndWOP:Schedule(6, DBM.SoundMMPath.."\\countone.ogg")
	timerRecklessChargeCD:Start(10-delay)--the trigger is 6 seconds from pull, charge will happen at 10. I like timer ending at cast finish for this one though vs tryng to have TWO timers for something that literally only has 6 second cd
	timerBitingColdCD:Start(15-delay)--15 seconds until debuff, 13 til cast.
	timerBlessedLoaSpiritCD:Start(25-delay)
	berserkTimer:Start(-delay)
	sndSpirit:Schedule(21, DBM.SoundMMPath.."\\ghostsoon.ogg")
	sndSpirit:Schedule(22, DBM.SoundMMPath.."\\countthree.ogg")
	sndSpirit:Schedule(23, DBM.SoundMMPath.."\\counttwo.ogg")
	sndSpirit:Schedule(24, DBM.SoundMMPath.."\\countone.ogg")
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	--BH ADD
	if self.Options.HudMAP or self.Options.HudMAP2 then
		DBMHudMap:FreeEncounterMarkers()
	end
	if mod.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	--BH ADD END
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 136189 then
		if boltCasts == 3 then boltCasts = 0 end
		boltCasts = boltCasts + 1
		warnSandBolt:Show(boltCasts)
		--BH ADD
		if ((mod.Options.optDD == "DD1") and (boltCasts == 1)) or ((mod.Options.optDD == "DD2") and (boltCasts == 2)) or ((mod.Options.optDD == "DD3") and (boltCasts == 3)) then
			sndWOP:Play(DBM.SoundMMPath.."\\kickcast.ogg") --快打斷
			specWarnSandBolt:Show(args.sourceName)
		end	
		if ((mod.Options.optDD == "DD1") and (boltCasts == 3)) or ((mod.Options.optDD == "DD2") and (boltCasts == 1)) or ((mod.Options.optDD == "DD3") and (boltCasts == 2)) then
			specWarnDDL:Schedule(2)
			sndWOP:Schedule(2, DBM.SoundMMPath.."\\interruptsoon.ogg") --打斷準備
		end
		--BH ADD END
	elseif args.spellId == 136521 and args:GetSrcCreatureID() == 69078 then--Filter the ones cast by adds dying.
		warnQuicksand:Show()
		timerQuickSandCD:Start()
		sndWOP:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndWOP:Schedule(1, DBM.SoundMMPath.."\\ex_tt_zyls.ogg")
		sndWOP:Schedule(29, DBM.SoundMMPath.."\\ex_tt_lszb.ogg") --流沙準備
		sndWOP:Schedule(30, DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Schedule(31, DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Schedule(32, DBM.SoundMMPath.."\\countone.ogg")
	elseif args.spellId == 136894 then
		warnSandstorm:Show()
		specWarnSandStorm:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_scfb.ogg")  --沙塵風暴
		timerSandStormCD:Start()
	elseif args.spellId == 137203 then
		warnBlessedLoaSpirit:Show()
		specWarnBlessedLoaSpirit:Show()
		timerBlessedLoaSpiritCD:Start()
		sndSpirit:Play(DBM.SoundMMPath.."\\killspirit.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndSpirit:Schedule(29, DBM.SoundMMPath.."\\ghostsoon.ogg")
		sndSpirit:Schedule(30, DBM.SoundMMPath.."\\countthree.ogg")
		sndSpirit:Schedule(31, DBM.SoundMMPath.."\\counttwo.ogg")
		sndSpirit:Schedule(32, DBM.SoundMMPath.."\\countone.ogg")
	elseif args.spellId == 137350 then
		warnShadowedLoaSpirit:Show()
		specWarnShadowedLoaSpirit:Show()
		timerShadowedLoaSpiritCD:Start()
		sndSpirit:Play(DBM.SoundMMPath.."\\killspirit.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndSpirit:Schedule(29, DBM.SoundMMPath.."\\ghostsoon.ogg")
		sndSpirit:Schedule(30, DBM.SoundMMPath.."\\countthree.ogg")
		sndSpirit:Schedule(31, DBM.SoundMMPath.."\\counttwo.ogg")
		sndSpirit:Schedule(32, DBM.SoundMMPath.."\\countone.ogg")
	elseif args.spellId == 137891 then
		warnTwistedFate:Show()
		specWarnTwistedFate:Show()
		timerTwistedFateCD:Start()
		DBM.Flash:Shake(1, 0, 0)
		sndWOP:Play(DBM.SoundMMPath.."\\killspirit.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndSpirit:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndSpirit:Schedule(29, DBM.SoundMMPath.."\\ghostsoon.ogg")
		sndSpirit:Schedule(30, DBM.SoundMMPath.."\\countthree.ogg")
		sndSpirit:Schedule(31, DBM.SoundMMPath.."\\counttwo.ogg")
		sndSpirit:Schedule(32, DBM.SoundMMPath.."\\countone.ogg")
	--BH ADD
	elseif args.spellId == 136990 then
		timerFrostBiteCD:Schedule(1.5)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_zyjt.ogg")
	--BH ADD END
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 136442 then--Possessed
		local cid = args:GetDestCreatureID()
		local uid
		for i = 1, 5 do
			if UnitName("boss"..i) == args.destName then
				uid = "boss"..i
				break
			end
		end
		possessesDone = possessesDone + 1
		warnPossessed:Show(args.destName, possessesDone)
		specWarnPossessed:Show(args.spellName, args.destName)
		if uid and UnitBuff(uid, lingeringPresence) then
			local _, _, _, stack = UnitBuff(uid, lingeringPresence)
			if self:IsDifficulty("heroic10", "heroic25") then
				timerDarkPowerCD:Start(math.floor(68/(0.15*stack+1.0)+0.5))--(68, 59, 52, 47)
			elseif self:IsDifficulty("normal25") then
				timerDarkPowerCD:Start(math.floor(68/(0.10*stack+1.0)+0.5))--(68, 62, 57, 52)
			elseif self:IsDifficulty("normal10") then
				timerDarkPowerCD:Start(math.floor(68/(0.10*(stack-1)+1.0)+0.5))--(76, 68, 62, x)
			else
				timerDarkPowerCD:Start(math.floor(68/(0.05*(stack-6)+1.0)+0.5))--(97, 91, 85, x)
			end
		else
			if self:IsDifficulty("lfr25") then
				timerDarkPowerCD:Start(97)
			elseif self:IsDifficulty("normal10") then
				timerDarkPowerCD:Start(76)
			else
				timerDarkPowerCD:Start(68)
			end
		end
		if cid == 69078 then--Sul the Sandcrawler
			--BH ADD
			Sulcount = Sulcount + 1
			speedcheck = Sulcount
			if mod:IsDps() then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sxzk.ogg")  --沙行者快打
			else
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sxz.ogg") 	 --沙行者強化
			end
			--BH ADD END
			--Do nothing. He just casts sand storm right away and continues his quicksand cd as usual
			self:UnregisterShortTermEvents()
		elseif cid == 69132 then--High Prestess Mar'li
			--BH ADD
			Marlicount = Marlicount + 1
			speedcheck = Marlicount
			if mod:IsDps() then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_njsk.ogg")  --女祭祀快打
			else
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_njs.ogg") 	 --女祭祀強化
			end
			--BH ADD END
			--Swap timers. While possessed 
			local elapsed, total = timerBlessedLoaSpiritCD:GetTime()
			timerBlessedLoaSpiritCD:Cancel()
			if elapsed and total then--If for some reason it was nil, like it JUST came off cd, do nothing, she should cast loa spirit right away.
				if self:IsDifficulty("heroic10", "heroic25") then
					timerTwistedFateCD:Update(elapsed, total)
				else
					timerShadowedLoaSpiritCD:Update(elapsed, total)
				end
			end
			self:UnregisterShortTermEvents()
		elseif cid == 69131 then--Frost King Malakk
			--BH ADD
			Malcount = Malcount + 1
			speedcheck = Malcount
			if mod:IsDps() then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_shwk.ogg")	--霜王快打
			else
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_shw.ogg")	--霜王強化
			end
			--BH ADD END
			--Swap timers. While possessed 
			local elapsed, total = timerBitingColdCD:GetTime()
			timerBitingColdCD:Cancel()
			if elapsed and total and total ~= 0 then--If for some reason it was nil, like it JUST came off cd, do nothing, he should cast frost bite right away.
				timerFrostBiteCD:Update(elapsed, total)
				sndWOP:Schedule(total-elapsed-3.5, DBM.SoundMMPath.."\\ex_tt_hszb.ogg") --寒霜準備
			end
			self:RegisterShortTermEvents(
				"UNIT_AURA"
			)
		elseif cid == 69134 then--Kazra'jin
			--BH ADD
			Kazcount = Kazcount + 1
			speedcheck = Kazcount
			if mod:IsDps() then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_ljrk.ogg")  --綠巨人快打
			else
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_ljr.ogg") 	 --綠巨人強化
			end
			--BH ADD END
			dischargeCount = 0
			kazraPossessed = true
			self:UnregisterShortTermEvents()
		end
		if (self.Options.HealthFrame or DBM.Options.AlwaysShowHealthFrame) and self.Options.PHealthFrame then
			local bossHealth = math.floor(UnitHealthMax(uid or "boss4") * 0.25)
			showDamagedHealthBar(self, args.destGUID, args.spellName.." : "..args.destName, bossHealth)
		end
		--BH ADD
		if mod.Options.InfoFrame then
			if self:IsDifficulty("lfr25") then return end
			DBM.InfoFrame:Hide()
			local bosshealthnow
			for i = 1, 5 do
				if UnitName("boss"..i) == args.destName then
					bosshealthnow = ("%d"):format(UnitHealth("boss"..i) / UnitHealthMax("boss"..i) * 100)
					break
				end
			end				
			local bosspowerspeed
			if self:IsDifficulty("heroic10", "heroic25") then
				bosspowerspeed = math.modf(68*(0.85^(speedcheck-1)))
			else
				bosspowerspeed = math.modf(68*(0.9^(speedcheck-1)))
			end
			local actboss = args.destName
			DBM.InfoFrame:SetHeader(actboss.."["..bosshealthnow.."%]"..GetSpellInfo(136442))
			DBM.InfoFrame:Show(1, "time", bosshealthnow, bosspowerspeed, actboss)
		end
		--BH ADD END
	elseif args.spellId == 136903 then--Player Debuff version, not cast version
		timerFrigidAssault:Start(args.destName)
		if self:AntiSpam(2.5, 1) then
			warnFrigidAssault:Show(args.destName, args.amount or 1)
			if args:IsPlayer() then
				if (args.amount or 1) >= 9 then
					specWarnFrigidAssault:Show(args.amount)
				end
			else
				if (args.amount or 1) >= 9 and not UnitDebuff("player", GetSpellInfo(136903)) and not UnitIsDeadOrGhost("player") then
					specWarnFrigidAssaultOther:Show(args.destName)
					if mod:IsTank() then
						sndWOP:Play(DBM.SoundMMPath.."\\changemt.ogg") --換坦嘲諷
					end
				end
			end
		end
	elseif args.spellId == 136992 then--Player Debuff version, not cast version
		warnBitingCold:Show(args.destName)
		if self.Options.SetIconOnBitingCold then
			self:SetIcon(args.destName, 7)--Cross
		end
		timerBitingColdCD:Start()
		if args:IsPlayer() then
			specWarnBitingCold:Show()
			timerBitingCold:Start()
			sndWOP:Play(DBM.SoundMMPath.."\\runout.ogg") --離開人群 (刺骨之寒)
			yellBitingCold:Yell()
		end
		--BH ADD
		if self.Options.HudMAP then
			BitingColdMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 4, 30, 1, 1, 1, 0.8):Appear():RegisterForAlerts():Rotate(360, 31))
		end
		--BH ADD END
	elseif args.spellId == 136922 and (args.amount or 1) == 1 then--Player Debuff version, not cast version (amount is just a spam filter for ignoring SPELL_AURA_APPLIED_DOSE on this event)
		warnFrostBite:Show(args.destName)
		if self.Options.SetIconOnFrostBite then
			self:SetIcon(args.destName, 6)--Square
		end
		timerFrostBiteCD:Start()
		sndWOP:Schedule(42, DBM.SoundMMPath.."\\ex_tt_hszb.ogg") --寒霜準備
		if args:IsPlayer() then
			specWarnFrostBite:Show()
			timerFrostBite:Start()
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_zrkj.ogg") --找人靠近 (寒霜刺骨)
		else
			if mod:IsRanged() then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_jhfd.ogg")
			end
		end
		--BH ADD
		if self.Options.HudMAP2 then
			FrostBiteMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 4, 30, 1, 1, 0, 0.8):Appear():RegisterForAlerts():Rotate(360, 31):SetAlertColor(0, 0, 1, 0.5))
		end
		--BH ADD END
	elseif args:IsSpellID(136860, 136878) and args:IsPlayer() and self:AntiSpam(2, 3) then--Trigger off initial quicksand debuff and ensnared stacks. much less cpu them registering damage events and just as effective.
		specWarnQuickSand:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_xj.ogg") --陷阱跑開
	elseif args.spellId == 137359 then
		warnMarkedSoul:Show(args.destName)
		timerMarkedSoul:Start(args.destName)
		if args:IsPlayer() then
			specWarnMarkedSoul:Show()
--BH DELETE		soundMarkedSoul:Play()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play(DBM.SoundMMPath.."\\shadowrun.ogg") --快跑 暗影點你
		end
	elseif args.spellId == 137166 then
		dischargeCount = dischargeCount + 1
		warnDischarge:Show(dischargeCount)
		specWarnDischarge:Show(dischargeCount)
		if MyJS() then
			sndWOP:Play(DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
		else
			DBM:PlayCountSound(dischargeCount)
		end
	elseif args.spellId == 137641 and args:IsPlayer() then
		specWarnSoulFragment:Show()
	--BH ADD
	elseif args.spellId == 137650 then --幽暗碎片
		OCn = self.Options.optOC == "five" and 5 or self.Options.optOC == "ten" and 10 or self.Options.optOC == "none" and 99
		if args:IsPlayer() then
			if (args.amount or 1) >= OCn then
				specWarnSP:Show(args.amount)
				sndWOP:Play(DBM.SoundMMPath.."\\transplague.ogg")
			end
		end
	elseif args.spellId == 136857 then --沙牢
		warnSoulTaget:Show(args.destName)
	--BH ADD END
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 136442 then--Possessed
		--BH ADD
		if mod.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
		--BH ADD END
		darkPowerWarned = false
		timerDarkPowerCD:Cancel()
		if args:GetDestCreatureID() == 69078 then--Sul the Sandcrawler
			timerSandStormCD:Cancel()
		elseif args:GetDestCreatureID() == 69132 then--High Prestess Mar'li
			--Swap timer back
			local elapsed, total
			if self:IsDifficulty("heroic10", "heroic25") then
				elapsed, total = timerTwistedFateCD:GetTime()
			else
				elapsed, total = timerShadowedLoaSpiritCD:GetTime()
			end
			timerTwistedFateCD:Cancel()
			timerShadowedLoaSpiritCD:Cancel()
			if elapsed and total and total ~= 0 then
				timerBlessedLoaSpiritCD:Update(elapsed, total)
			end
		elseif args:GetDestCreatureID() == 69131 then--Frost King Malakk
			--Swap timer back
			local elapsed, total  = timerFrostBiteCD:GetTime()
			timerFrostBiteCD:Cancel()
			sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_hszb.ogg")
			if elapsed and total then
				timerBitingColdCD:Update(elapsed, total)
			end
		elseif args:GetDestCreatureID() == 69134 then--Kazra'jin
			kazraPossessed = false
			timerRecklessChargeCD:Cancel()--Because it's not going to be 25 sec anymore. It'll go back to 6 seconds. He'll probably do it right away since more than likely it'll be off CD
		end
		if (self.Options.HealthFrame or DBM.Options.AlwaysShowHealthFrame) and self.Options.PHealthFrame then
			hideDamagedHealthBar()
		end
	elseif args.spellId == 136903 then
		timerFrigidAssault:Cancel(args.destName)
	elseif args.spellId == 136904 then
		timerFrigidAssaultCD:Start()
	elseif args.spellId == 137359 then
		timerMarkedSoul:Cancel(args.destName)
	--BH ADD
	elseif args.spellId == 136992 then
		if self.Options.SetIconOnBitingCold then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			timerBitingCold:Cancel()
		end
		if BitingColdMarkers[args.destName] then
			BitingColdMarkers[args.destName] = free(BitingColdMarkers[args.destName])
		end
	elseif args.spellId == 136922 then
		if self.Options.SetIconOnFrostBite then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			timerFrostBite:Cancel()
		end
		if FrostBiteMarkers[args.destName] then
			FrostBiteMarkers[args.destName] = free(FrostBiteMarkers[args.destName])
		end
	--BH ADD END
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 136507 and not darkPowerWarned then
		darkPowerWarned = true
		specWarnDarkPower:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\aesoon.ogg")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", chilledDebuff) and not chilledWarned then
		specWarnChilled:Show()
		chilledWarned = true
	elseif not UnitDebuff("player", chilledDebuff) and chilledWarned then
		chilledWarned = false
	end
	--BH ADD
	if UnitDebuff("player", coldDebuff) and not coldsend then
		coldsend = true
		self:SendSync("mycold", UnitName("player"))
	elseif not UnitDebuff("player", coldDebuff) and coldsend then
		coldsend = false
	end
	--BH ADD END
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69078 then--Sul the Sandcrawler
		timerSandStormCD:Cancel()
		sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_lszb.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\countone.ogg")
	elseif cid == 69132 then--High Prestess Mar'li
		timerTwistedFateCD:Cancel()
		timerBlessedLoaSpiritCD:Cancel()
		timerShadowedLoaSpiritCD:Cancel()
	elseif cid == 69131 then--Frost King Malakk
		timerFrostBiteCD:Cancel()
		sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_hszb.ogg")
		timerBitingColdCD:Cancel()
		timerFrigidAssaultCD:Cancel()
	elseif cid == 69134 then--Kazra'jin
		timerRecklessChargeCD:Cancel()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137107 then--Pre cast trigger. there are other later spellids but they aren't consistent, only this one is.
		warnRecklessCharge:Schedule(2)--warning 4 seconds early on something cast every 6 seconds seems silly. Lets warn 2 seconds early.
		if kazraPossessed then--While possessed he gains "Overload" which will make his charge cd way different.
			timerRecklessChargeCD:Schedule(4, 25)--Will have timer actualy sync up to the cast finish so it also kind serves as a cast bar.
		else
			timerRecklessChargeCD:Schedule(4)--Will have timer actualy sync up to the cast finish so it also kind serves as a cast bar.
		end
	end
end
--BH ADD
function mod:OnSync(msg, guid)
	if msg == "mycold" and guid then
		if guid == mod.Options.helpcold then
			sndWOP:Schedule(5, DBM.SoundMMPath.."\\ex_tt_twjs.ogg")
		end
	end
end
--BH ADD END