local mod	= DBM:NewMod(832, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
-- BH ADD
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11365 $"):sub(12, -3))
mod:SetCreatureID(68397)--Diffusion Chain Conduit 68696, Static Shock Conduit 68398, Bouncing Bolt conduit 68698, Overcharge conduit 68697
mod:SetEncounterID(1579)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--All icons can be used, because if a pillar is level 3, it puts out 4 debuffs on 25 man (if both are level 3, then you will have 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED"
)

mod:RegisterEvents(
	"CHAT_MSG_SAY"
)

--Conduits (All phases)
local warnStaticShock					= mod:NewTargetAnnounce(135695, 4)
local warnDiffusionChain				= mod:NewTargetAnnounce(135991, 3)--More informative than actually preventative. (you need to just spread out, and that's it. can't control who it targets only that it doesn't spread)
local warnDiffusionChainSpread			= mod:NewAnnounce("warnDiffusionChainSpread", 4, 135991)
local warnOvercharged					= mod:NewTargetAnnounce(136295, 3)
local warnBouncingBolt					= mod:NewSpellAnnounce(136361, 3)
--Phase 1
local warnDecapitate					= mod:NewTargetAnnounce(134912, 4, nil, mod:IsTank() or mod:IsHealer())
local warnThunderstruck					= mod:NewSpellAnnounce(135095, 3)--Target scanning seems to not work
--Phase 2
local warnPhase2						= mod:NewPhaseAnnounce(2)
local warnFusionSlash					= mod:NewSpellAnnounce(136478, 4, nil, mod:IsTank() or mod:IsHealer())
local warnLightningWhip					= mod:NewSpellAnnounce(136850, 3)
local warnSummonBallLightning			= mod:NewSpellAnnounce(136543, 3)--This seems to be VERY important to spread for. It spawns an orb for every person who takes damage. MUST range 6 this.
local warnGorefiendsGrasp				= mod:NewSpellAnnounce(108199, 1)
--Phase 3
local warnPhase3						= mod:NewPhaseAnnounce(3)
local warnViolentGaleWinds				= mod:NewSpellAnnounce(136889, 3)
--Heroic
local warnHelmOfCommand					= mod:NewTargetAnnounce(139011, 3)

--Conduits (All phases)
local specWarnStaticShock				= mod:NewSpecialWarningYou(135695)
local yellStaticShock					= mod:NewYell(135695)
local specWarnStaticShockNear			= mod:NewSpecialWarningClose(135695)
local specWarnDiffusionChainSoon		= mod:NewSpecialWarningPreWarn(135991, nil, 4)
local specWarnOvercharged				= mod:NewSpecialWarningYou(136295)
local yellOvercharged					= mod:NewYell(136295)
local specWarnOverchargedNear			= mod:NewSpecialWarningClose(136295)
local specWarnBouncingBoltSoon			= mod:NewSpecialWarningPreWarn(136361, nil, 4)
local specWarnBouncingBolt				= mod:NewSpecialWarningSpell(136361)
--Phase 1
local specWarnDecapitate				= mod:NewSpecialWarningRun(134912, mod:IsTank())
local specWarnDecapitateOther			= mod:NewSpecialWarningTarget(134912, mod:IsTank())
-- BH ADD
local specWarnDiffusionChain			= mod:NewSpecialWarningTarget(135991)
local specWarnThunderstruck				= mod:NewSpecialWarningSpell(135095, nil, nil, nil, 2)
local specWarnThunderstruckSoon			= mod:NewSpecialWarningPreWarn(135095, nil, 5)
local specWarnCrashingThunder			= mod:NewSpecialWarningMove(135150)
local specWarnIntermissionSoon			= mod:NewSpecialWarning("specWarnIntermissionSoon")
--Phase 2
local specWarnFusionSlash				= mod:NewSpecialWarningSpell(136478, mod:IsTank(), nil, nil, 3)--Cast (394514 is debuff. We warn for cast though because it knocks you off platform if not careful)
local specWarnLightningWhip				= mod:NewSpecialWarningSpell(136850, nil, nil, nil, 2)
local specWarnSummonBallLightning		= mod:NewSpecialWarningSpell(136543, nil, nil, nil, 2)
local specWarnOverloadedCircuits		= mod:NewSpecialWarningMove(137176)
local specWarnGorefiendsGrasp			= mod:NewSpecialWarningSpell(108199, false)--For heroic, gorefiends+stun timing is paramount to success
--Phase 3
local specWarnElectricalShock			= mod:NewSpecialWarningStack(136914, mod:IsTank(), 12)
local specWarnElectricalShockOther		= mod:NewSpecialWarningTarget(136914, mod:IsTank())
--Herioc
local specWarnHelmOfCommand				= mod:NewSpecialWarningYou(139011, nil, nil, nil, 3)
local specWarnHelmOfCommandOther		= mod:NewSpecialWarningTarget(139011)

--Conduits (All phases)
local timerStaticShock					= mod:NewBuffFadesTimer(8, 135695)
local timerStaticShockCD				= mod:NewCDTimer(40, 135695)
local timerDiffusionChainCD				= mod:NewCDTimer(40, 135991)
local timerOvercharge					= mod:NewCastTimer(6, 136295)
local timerOverchargeCD					= mod:NewCDTimer(40, 136295)
local timerBouncingBoltCD				= mod:NewCDTimer(40, 136361)
local timerSuperChargedConduits			= mod:NewBuffActiveTimer(47, 137045)--Actually intermission only, but it fits best with conduits
--Phase 1
local timerDecapitateCD					= mod:NewCDTimer(50, 134912, nil, mod:IsTank())--Cooldown with some variation. 50-57ish or so.
local timerThunderstruck				= mod:NewCastTimer(4.8, 135095)--4 sec cast. + landing 0.8~1.3 sec.
local timerThunderstruckCD				= mod:NewNextTimer(46, 135095)--Seems like an exact bar
local timerCrashingThunder				= mod:NewNextTimer(30, 135150)
--Phase 2
local timerFussionSlashCD				= mod:NewCDTimer(42.5, 136478, nil, mod:IsTank())
local timerLightningWhip				= mod:NewCastTimer(4, 136850)
local timerLightningWhipCD				= mod:NewNextTimer(45.5, 136850)--Also an exact bar
local timerSummonBallLightningCD		= mod:NewNextTimer(45.5, 136543)--Seems exact on live, versus the variable it was on PTR
--Phase 3
local timerViolentGaleWinds				= mod:NewBuffActiveTimer(18, 136889)
local timerViolentGaleWindsCD			= mod:NewNextTimer(30.5, 136889)
--Heroic
local timerHelmOfCommand				= mod:NewCDTimer(14, 139011)
local timerCommandTarget				= mod:NewTargetTimer(8, 139011)

local berserkTimer						= mod:NewBerserkTimer(900)--Confirmed in LFR, probably the same in all modes though?



mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("RangeFrameLB", true, "sound")
mod:AddBoolOption("OverchargeArrow")--On by default because the overcharge target is always pinned and unable to run away. You must always run to them, so everyone will want this arrow on
mod:AddBoolOption("StaticShockArrow", false)--Off by default as most static shock stack points are pre defined and not based on running to player, but rathor running to a raid flare on ground
mod:AddBoolOption("SetIconOnOvercharge", true)
mod:AddBoolOption("SetIconOnStaticShock", true)

mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudMAP2", true, "sound")
mod:AddBoolOption("drpendp2", true, "sound")
for i = 1, 5 do
	mod:AddBoolOption("drpend"..i, false, "sound")
end

mod:AddBoolOption("drpendp3", true, "sound")

for i = 1, 6 do
	mod:AddBoolOption("drend"..i, false, "sound")
end

mod:AddBoolOption("drpendp3b", true, "sound")

for i = 1, 6 do
	mod:AddBoolOption("drendb"..i, false, "sound")
end

mod:AddDropdownOption("optDD", {"nodd", "DD1", "DD2"}, "nodd", "sound")

mod:AddEditBoxOption("cancelhud", 150, "", "sound")

local lightp2count = 0
local windcount = 0
local thundercount = 0

local chaincount = 0

local firstchain = 0
local circletime = 0
local twocirle = false

local lbcount = 0
local StaticShockMarkers = {}
local OverchargedMarkers = {}
local canceledshock = {}
local checkmsg = ""

local function MyJSP2()
	if (mod.Options.drpend1 and lightp2count == 1) or (mod.Options.drpend2 and lightp2count == 2) or (mod.Options.drpend3 and lightp2count == 3) or (mod.Options.drpend4 and lightp2count == 4) or (mod.Options.drpend5 and lightp2count == 5) then
		return true
	end
	return false
end

local function MyJSP3()
	if (mod.Options.drend1 and windcount == 1) or (mod.Options.drend2 and windcount == 2) or (mod.Options.drend3 and windcount == 3) or (mod.Options.drend4 and windcount == 4) or (mod.Options.drend5 and windcount == 5) or (mod.Options.drend6 and windcount == 6) then
		return true
	end
	return false
end

local function MyJSP3B()
	if (mod.Options.drendb1 and thundercount == 1) or (mod.Options.drendb2 and thundercount == 2) or (mod.Options.drendb3 and thundercount == 3) or (mod.Options.drendb4 and thundercount == 4) or (mod.Options.drendb5 and thundercount == 5) or (mod.Options.drendb6 and thundercount == 6) then
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

local phase = 1
local warnedCount = 0
local intermissionActive = false--Not in use yet, but will be. This will be used (once we have CD bars for regular phases mapped out) to prevent those cd bars from starting during intermissions and messing up the custom intermission bars
local northDestroyed = false
local eastDestroyed = false
local southDestroyed = false
local westDestroyed = false
local staticshockTargets = {}
local diffusionTargets = {}
local staticIcon = 8--Start high and count down
local overchargeTarget = {}
local overchargeIcon = 1--Start low and count up
local helmOfCommandTarget = {}
local playerName = UnitName("player")

local function warnStaticShockTargets()
	warnStaticShock:Show(table.concat(staticshockTargets, "<, >"))
	table.wipe(staticshockTargets)
	staticIcon = 8
end

local function warnDiffusionSpreadTargets(spellName)
	warnDiffusionChainSpread:Show(spellName, table.concat(diffusionTargets, "<, >"))
	table.wipe(diffusionTargets)
end

local function warnOverchargeTargets()
	warnOvercharged:Show(table.concat(overchargeTarget, "<, >"))
	table.wipe(overchargeTarget)
	overchargeIcon = 1
end

local function warnHelmOfCommandTargets()
	warnHelmOfCommand:Show(table.concat(helmOfCommandTarget, "<, >"))
	table.wipe(helmOfCommandTarget)
end

local function warnSpellReflection()
	mod:SendSync("Refle")
end


function mod:OnCombatStart(delay)
	table.wipe(staticshockTargets)
	table.wipe(overchargeTarget)
	--BH ADD
	windcount = 0
	thundercount = 0
	lightp2count = 0
	lbcount = 0
	chaincount = 0
	checkmsg = mod.Options.cancelhud
	table.wipe(StaticShockMarkers)
	table.wipe(OverchargedMarkers)
	table.wipe(canceledshock)
	--BH ADD END
	phase = 1
	warnedCount = 0
	staticIcon = 8
	overchargeIcon = 1
	intermissionActive = false
	northDestroyed = false
	eastDestroyed = false
	southDestroyed = false
	westDestroyed = false
	timerThunderstruckCD:Start(25-delay)
	timerCrashingThunder:Start(7-delay)
	timerDecapitateCD:Start(40-delay)--First seems to be 45, rest 50. it's a CD though, not a "next"
	berserkTimer:Start(-delay)
	self:RegisterShortTermEvents(
		"UNIT_HEALTH_FREQUENT boss1",
		"SPELL_DAMAGE",
		"SPELL_MISSED",
		"SPELL_PERIODIC_DAMAGE",
		"SPELL_PERIODIC_MISSED"
	)-- Do not use on phase 3.
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.OverchargeArrow or self.Options.StaticShockArrow then
		DBM.Arrow:Hide()
	end
	self:UnregisterShortTermEvents()
	if self.Options.HudMAP or self.Options.HudMAP2 then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 135095 then
		warnThunderstruck:Show()
		specWarnThunderstruck:Show()
		timerThunderstruck:Start()
		DBM.Flash:Shake(1, 0, 0)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_yllj.ogg") --遠離雷擊
		if phase < 3 then
			timerThunderstruckCD:Start()
		else
			timerThunderstruckCD:Start(30)
			specWarnThunderstruckSoon:Schedule(25)
			sndWOP:Schedule(25, DBM.SoundMMPath.."\\ex_tt_wmlj.ogg") --5秒後雷擊
			thundercount = thundercount + 1
			self:Schedule(1, function()
				if MyJSP3B() then
					sndWOP:Play(DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
				else
					DBM:PlayCountSound(thundercount)
				end
			end)
		end	
	--"<206.2 20:38:58> [UNIT_SPELLCAST_SUCCEEDED] Lei Shen [[boss1:Lightning Whip::0:136845]]", -- [13762] --This event comes about .5 seconds earlier than SPELL_CAST_START. Maybe worth using?
	elseif args.spellId == 136850 then
		warnLightningWhip:Show()
		specWarnLightningWhip:Show()
		timerLightningWhip:Start()
		if phase < 3 then
			timerLightningWhipCD:Start()
		else
			timerLightningWhipCD:Start(30)
		end
		DBM.Flash:Shake(1, 0, 0)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sdb.ogg") --閃電鞭
	elseif args.spellId == 136478 then
		warnFusionSlash:Show()
		specWarnFusionSlash:Show()
		timerFussionSlashCD:Start()
		if UnitName("boss1target") == UnitName("player") then
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play(DBM.SoundMMPath.."\\carefly.ogg") --小心擊飛
		elseif mod:IsTank() or mod:IsHealer() then
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_jlz.ogg") --巨雷斬
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(135000, 134912) then--Is 135000 still used on 10 man?
		warnDecapitate:Show(args.destName)
		timerDecapitateCD:Start()
		if args:IsPlayer() then
			specWarnDecapitate:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_zs.ogg")--斬首快跑
		else
			specWarnDecapitateOther:Show(args.destName)
			if mod:IsTank() or mod:IsHealer() then
				sndWOP:Play(DBM.SoundMMPath.."\\changemt.ogg") --換坦嘲諷
			end
		end
	--Conduit activations
	elseif args.spellId == 135695 then
		staticshockTargets[#staticshockTargets + 1] = args.destName
		if self.Options.SetIconOnStaticShock then
			self:SetIcon(args.destName, staticIcon)
			staticIcon = staticIcon - 1
		end
		if not intermissionActive then
			if phase == 3 then--Perm abilities he retains in heroic final phase get a 5 second bump on CD
				timerStaticShockCD:Start(45)
			else
				timerStaticShockCD:Start()
			end
		end
		self:Unschedule(warnStaticShockTargets)
		self:Schedule(0.3, warnStaticShockTargets)
		if args:IsPlayer() then
			specWarnStaticShock:Show()
			yellStaticShock:Yell()
			timerStaticShock:Start()
			sndWOP:Play(DBM.SoundMMPath.."\\targetyou.ogg") --目標是你
			sndWOP:Schedule(1.5, DBM.SoundMMPath.."\\countseven.ogg")
			sndWOP:Schedule(2.5, DBM.SoundMMPath.."\\countsix.ogg")
			sndWOP:Schedule(3.5, DBM.SoundMMPath.."\\countfive.ogg")
			sndWOP:Schedule(4.5, DBM.SoundMMPath.."\\countfour.ogg")
			sndWOP:Schedule(5.5, DBM.SoundMMPath.."\\countthree.ogg")
			sndWOP:Schedule(6.5, DBM.SoundMMPath.."\\counttwo.ogg")
			sndWOP:Schedule(7.5, DBM.SoundMMPath.."\\countone.ogg")
		else
			if not intermissionActive and self:IsMelee() then return end--Melee do not help soak these during normal phases, only during intermissions
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				--BH MODIFY
				if inRange and inRange < 50 then
					specWarnStaticShockNear:Show(args.destName)
					if self.Options.StaticShockArrow then
						DBM.Arrow:ShowRunTo(args.destName, 3, 3, 8)
					end
					if self:AntiSpam(3, 11) then
						sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_jhfd.ogg") --集合分擔
						sndWOP:Schedule(1.5, DBM.SoundMMPath.."\\countseven.ogg")
						sndWOP:Schedule(2.5, DBM.SoundMMPath.."\\countsix.ogg")
						sndWOP:Schedule(3.5, DBM.SoundMMPath.."\\countfive.ogg")
						sndWOP:Schedule(4.5, DBM.SoundMMPath.."\\countfour.ogg")
						sndWOP:Schedule(5.5, DBM.SoundMMPath.."\\countthree.ogg")
						sndWOP:Schedule(6.5, DBM.SoundMMPath.."\\counttwo.ogg")
						sndWOP:Schedule(7.5, DBM.SoundMMPath.."\\countone.ogg")
					end
					if self.Options.HudMAP then
						StaticShockMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 8, 8, 1, 1, 1, 0.8):Appear():RegisterForAlerts():Rotate(360, 8.5):SetAlertColor(0, 0, 1, 0.5))
						StaticShockMarkers[args.destName.."Edge"] = register(DBMHudMap:AddEdge(0, 0, 1, 1, 8, "player", args.destName))
					end
				end
				--BH MODIFY END
			end
		end		
		if phase == 2 and self:AntiSpam(3, 12) then
			lightp2count = lightp2count + 1
			if MyJSP2() then
				sndWOP:Schedule(1, DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
			end
		end
	elseif args.spellId == 136295 then
		overchargeTarget[#overchargeTarget + 1] = args.destName
		timerOvercharge:Start()
		if self.Options.SetIconOnOvercharge then
			self:SetIcon(args.destName, overchargeIcon)
			overchargeIcon = overchargeIcon + 1
		end
		if not intermissionActive then
			if phase == 3 then--Perm abilities he retains in heroic final phase get a 5 second bump on CD
				timerOverchargeCD:Start(45)
			else
				timerOverchargeCD:Start()
			end
		end
		self:Unschedule(warnOverchargeTargets)
		self:Schedule(0.3, warnOverchargeTargets)
		if args:IsPlayer() then
			specWarnOvercharged:Show()
			yellOvercharged:Yell()
			sndWOP:Play(DBM.SoundMMPath.."\\targetyou.ogg") --目標是你
			sndWOP:Schedule(1.5, DBM.SoundMMPath.."\\countfive.ogg")
			sndWOP:Schedule(2.5, DBM.SoundMMPath.."\\countfour.ogg")
			sndWOP:Schedule(3.5, DBM.SoundMMPath.."\\countthree.ogg")
			sndWOP:Schedule(4.5, DBM.SoundMMPath.."\\counttwo.ogg")
			sndWOP:Schedule(5.5, DBM.SoundMMPath.."\\countone.ogg")
		else
			if not intermissionActive and self:IsMelee() then return end--Melee do not help soak these during normal phases, only during intermissions
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				--BH MODIFY
				if inRange and inRange < 50 then
					specWarnOverchargedNear:Show(args.destName)
					if self:AntiSpam(3, 6) then
						if intermissionActive and (firstchain == 1) then
							sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_hmzb.ogg") --昏迷圈準備
							twocirle = true
							circletime = GetTime()
						else
							sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_czjh.ogg") --超載集合
							sndWOP:Schedule(1.5, DBM.SoundMMPath.."\\countfour.ogg")
							sndWOP:Schedule(2.5, DBM.SoundMMPath.."\\countthree.ogg")
							sndWOP:Schedule(3.5, DBM.SoundMMPath.."\\counttwo.ogg")
							sndWOP:Schedule(4.5, DBM.SoundMMPath.."\\countone.ogg")
						end						
					end
					if self.Options.HudMAP2 then
						OverchargedMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 5, 6, 1, 1, 1, 0.8):Appear():RegisterForAlerts():Rotate(360, 6.5):SetAlertColor(0, 0, 1, 0.5))
						OverchargedMarkers[args.destName.."Edge"] = register(DBMHudMap:AddEdge(0, 0, 1, 1, 6, "player", args.destName))
					end
					if self.Options.OverchargeArrow then
						DBM.Arrow:ShowRunTo(args.destName, 3, 3, 6)
					end
				end
				--BH MODIFY END
			end
		end
	elseif args.spellId == 135680 and args:GetDestCreatureID() == 68397 then--North (Static Shock)
		--start timers here when we have em
	elseif args.spellId == 135681 and args:GetDestCreatureID() == 68397 then--East (Diffusion Chain)
		if self.Options.RangeFrame and self:IsRanged() then--Shouldn't target melee during a normal pillar, only during intermission when all melee are with ranged and out of melee range of boss
			DBM.RangeCheck:Show(8)--Assume 8 since spell tooltip has no info
		end
		-- BH ADD
		if phase > 1 then
			if self:AntiSpam(10, 20) then
				specWarnDiffusionChainSoon:Show()
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sdls.ogg")--閃電鏈準備
				self:Schedule(1, warnSpellReflection)
			end
		end
	elseif args.spellId == 137176 and self:AntiSpam(3, 5) and args:IsPlayer() then
		specWarnOverloadedCircuits:Show()
	elseif args.spellId == 139011 then
		helmOfCommandTarget[#helmOfCommandTarget + 1] = args.destName
		timerCommandTarget:Start(args.destName)
		if args:IsPlayer() then
			specWarnHelmOfCommand:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_jtzy.ogg") --注意擊退
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				--BH MODIFY
				if inRange and inRange < 30 then
					specWarnHelmOfCommandOther:Show(args.destName)
					sndWOP:Play(DBM.SoundMMPath.."\\didi.ogg")
				end
			end
		end
		self:Unschedule(warnHelmOfCommandTargets)
		self:Schedule(0.3, warnHelmOfCommandTargets)
	elseif args.spellId == 136914 then
		local amount = args.amount or 1
		if amount >= 12 and self:AntiSpam(2.5, 16) then
			if args:IsPlayer() then
				specWarnElectricalShock:Show(args.amount)
			else
				specWarnElectricalShockOther:Show(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 135991 then
		warnDiffusionChain:Show(args.destName)
		specWarnDiffusionChain:Show(args.destName)
		if not intermissionActive then
			timerDiffusionChainCD:Start()
			specWarnDiffusionChainSoon:Schedule(36)
			sndWOP:Schedule(36, DBM.SoundMMPath.."\\ex_tt_sdls.ogg")
			if phase > 1 then
				self:Schedule(37, warnSpellReflection)
			end
		end
		if intermissionActive and self:IsDifficulty("heroic10", "heroic25") then
			if firstchain == 0 then
				self:Schedule(5, function() firstchain = 1 end)
			else
				firstchain = 2
				if twocirle then
					sndWOP:Play(DBM.SoundMMPath.."\\gather.ogg")--快集合
					circletime = GetTime() - circletime
					sndWOP:Schedule(1.5-circletime, DBM.SoundMMPath.."\\countfour.ogg")
					sndWOP:Schedule(2.5-circletime, DBM.SoundMMPath.."\\countthree.ogg")
					sndWOP:Schedule(3.5-circletime, DBM.SoundMMPath.."\\counttwo.ogg")
					sndWOP:Schedule(4.5-circletime, DBM.SoundMMPath.."\\countone.ogg")
				end
			end
		end
	elseif args.spellId == 136543 and self:AntiSpam(2, 1) then
		warnSummonBallLightning:Show()
		specWarnSummonBallLightning:Show()
		if phase < 3 then
			timerSummonBallLightningCD:Start()
			sndWOP:Schedule(40, DBM.SoundMMPath.."\\ex_tt_wmdq.ogg") --5秒後電球
		else
			timerSummonBallLightningCD:Start(30)
			sndWOP:Schedule(25, DBM.SoundMMPath.."\\ex_tt_wmdq.ogg")
		end
		if self:IsDifficulty("heroic10", "heroic25") and self.Options.RangeFrameLB then
			DBM.RangeCheck:Show(3)
		end
	elseif args.spellId == 108199 and self:IsInCombat() then
		warnGorefiendsGrasp:Show()
		specWarnGorefiendsGrasp:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	--Conduit deactivations
	if args.spellId == 135680 and args:GetDestCreatureID() == 68397 and not intermissionActive then--North (Static Shock)
		timerStaticShockCD:Cancel()
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(8)
		end
	elseif args.spellId == 135681 and args:GetDestCreatureID() == 68397 and not intermissionActive then--East (Diffusion Chain)
		timerDiffusionChainCD:Cancel()
		specWarnDiffusionChainSoon:Cancel()
		sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_sdls.ogg")
		if phase > 1 then
			self:Unschedule(warnSpellReflection)
		end
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(8)
		end
	elseif args.spellId == 135682 and args:GetDestCreatureID() == 68397 and not intermissionActive then--South (Overcharge)
		timerOverchargeCD:Cancel()
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(8)
		end
	elseif args.spellId == 135683 and args:GetDestCreatureID() == 68397 and not intermissionActive then--West (Bouncing Bolt)
		timerBouncingBoltCD:Cancel()
		specWarnBouncingBoltSoon:Cancel()
		if self.Options.RangeFrame and self:IsRanged() then
			DBM.RangeCheck:Show(8)
		end
	--Conduit deactivations
	--BH MODIFY
	elseif args.spellId == 135695 then
		if self.Options.SetIconOnStaticShock then
			self:SetIcon(args.destName, 0)
		end
		if StaticShockMarkers[args.destName] then
			StaticShockMarkers[args.destName] = free(StaticShockMarkers[args.destName])
			StaticShockMarkers[args.destName.."Edge"] = free(StaticShockMarkers[args.destName.."Edge"])
		end
		if canceledshock[args.destName] then
			canceledshock[args.destName] = free(canceledshock[args.destName])
		end
	elseif args.spellId == 136295 then
		if self.Options.SetIconOnOvercharge then
			self:SetIcon(args.destName, 0)
		end
		if OverchargedMarkers[args.destName] then
			OverchargedMarkers[args.destName] = free(OverchargedMarkers[args.destName])
			OverchargedMarkers[args.destName.."Edge"] = free(OverchargedMarkers[args.destName.."Edge"])
		end
	--BH MODIFY END
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId, spellName)
	if spellId == 135150 and destGUID == UnitGUID("player") and self:AntiSpam(10, 4) then
		specWarnCrashingThunder:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
		timerCrashingThunder:Start()
	elseif spellId == 135991 and destName ~= diffusionCastTarget then--Filter actual target, so we only announce SPREADS
		diffusionTargets[#diffusionTargets + 1] = destName
		self:Unschedule(warnDiffusionSpreadTargets)
		if #diffusionTargets >= 1 then
			self:Schedule(0.3, warnDiffusionSpreadTargets, spellName)
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 135153 and destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
		specWarnCrashingThunder:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:137176") then--Overloaded Circuits (Intermission ending and next phase beginning)
		intermissionActive = false
		phase = phase + 1
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		--"<174.8 20:38:26> [CHAT_MSG_RAID_BOSS_EMOTE] CHAT_MSG_RAID_BOSS_EMOTE#|TInterface\\Icons\\spell_nature_unrelentingstorm.blp:20|t The |cFFFF0000|Hspell:135683|h[West Conduit]|h|r has burned out and caused |cFFFF0000|Hspell:137176|h[Overloaded Circuits]|h|r!#Bouncing Bolt Conduit
		if msg:find("spell:135680") then--North (Static Shock)
			northDestroyed = true
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_jdsh.ogg") --靜電震擊損毀
		elseif msg:find("spell:135681") then--East (Diffusion Chain)
			eastDestroyed = true
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_sssh.ogg") --散射電練損毀
		elseif msg:find("spell:135682") then--South (Overcharge)
			southDestroyed = true
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_czsh.ogg") --電能超載損毀
		elseif msg:find("spell:135683") then--West (Bouncing Bolt)
			westDestroyed = true
			sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_ttsh.ogg") --彈跳閃電損毀
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			--On heroic he gains ability perm when pillar dies.
			--it will be cast 14 seconds later unless you get him to cast one of other ones first then it may be at 15-16 right after the other one
			--not sure how it works after second intermission, probably up in air which one he casts first and other right after. thats why these are CD timers.
			if northDestroyed then
				timerStaticShockCD:Start(14)
			end
			if eastDestroyed then
				timerDiffusionChainCD:Start(14)
				specWarnDiffusionChainSoon:Schedule(10)
				sndWOP:Schedule(10, DBM.SoundMMPath.."\\ex_tt_sdls.ogg")
				self:Schedule(11, warnSpellReflection)
			end
			if southDestroyed then
				timerOverchargeCD:Start(14)
			end
			if westDestroyed then
				timerBouncingBoltCD:Start(14)
			end
		end
		sndWOP:Cancel(DBM.SoundMMPath.."\\ptwo.ogg")
		sndWOP:Cancel(DBM.SoundMMPath.."\\pthree.ogg")
		if phase == 2 then--Start Phase 2 timers
			warnPhase2:Show()
			lightp2count = 0
			timerSummonBallLightningCD:Start(15)
			sndWOP:Schedule(10, DBM.SoundMMPath.."\\ex_tt_wmdq.ogg") --5秒後電球
			timerLightningWhipCD:Start(30)
			timerFussionSlashCD:Start(44)
			if self.Options.RangeFrame and self:IsRanged() then
				DBM.RangeCheck:Show(8)
			end
		elseif phase == 3 then--Start Phase 3 timers
			warnPhase3:Show()
			windcount = 0
			thundercount = 0
			timerViolentGaleWindsCD:Start(20)
			sndWOP:Schedule(17, DBM.SoundMMPath.."\\ex_tt_qfzb.ogg") --強風準備
			timerLightningWhipCD:Start(21.5)
			timerThunderstruckCD:Start(36)
			specWarnThunderstruckSoon:Schedule(31)
			sndWOP:Schedule(31, DBM.SoundMMPath.."\\ex_tt_wmlj.ogg") --5秒後雷擊
			timerSummonBallLightningCD:Start(41.5)
			sndWOP:Schedule(36, DBM.SoundMMPath.."\\ex_tt_wmdq.ogg") --5秒後電球
			if self.Options.RangeFrame then
				if self:IsDifficulty("heroic10", "heroic25") then
					if self:IsRanged() then
						DBM.RangeCheck:Show(8)
					else
						DBM.RangeCheck:Show(6)
					end
				else
					DBM.RangeCheck:Show(6)
				end
			end
		end
	end
end

local function LoopIntermission()
	if not southDestroyed then
		if mod:IsDifficulty("lfr25") then
			timerOverchargeCD:Start(17.5)
		else
			timerOverchargeCD:Start(6.5)
		end
	end
	if not eastDestroyed then
		if mod:IsDifficulty("lfr25") then
			timerDiffusionChainCD:Start(17.5)
			specWarnDiffusionChainSoon:Schedule(13.5)
			sndWOP:Schedule(13.5, DBM.SoundMMPath.."\\scattersoon.ogg")--注意分散
		else
			timerDiffusionChainCD:Start(8)
			specWarnDiffusionChainSoon:Schedule(4)
			sndWOP:Schedule(4, DBM.SoundMMPath.."\\scattersoon.ogg")--注意分散
		end
	end
	if not westDestroyed then
		if mod:IsDifficulty("lfr25") then
			warnBouncingBolt:Schedule(9)
			specWarnBouncingBolt:Schedule(9)
			timerBouncingBoltCD:Start(9)
			sndWOP:Schedule(9, DBM.SoundMMPath.."\\ex_tt_fscq.ogg")
		else
			warnBouncingBolt:Schedule(14)
			specWarnBouncingBolt:Schedule(14)
			timerBouncingBoltCD:Start(14)
			sndWOP:Schedule(14, DBM.SoundMMPath.."\\ex_tt_fscq.ogg")
		end
	end
	if not mod:IsDifficulty("lfr25") and not northDestroyed then--Doesn't cast a 2nd one in LFR
		timerStaticShockCD:Start(16)
	end
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerHelmOfCommand:Start(15)
	end
end

function mod:UNIT_HEALTH_FREQUENT(uId)
	if UnitName(uId) == L.name then
		local hp = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if hp > 65 and hp < 66.5 and warnedCount == 0 then
			warnedCount = 1
			specWarnIntermissionSoon:Show()
		elseif hp > 30 and hp < 31.5 and warnedCount == 1 then
			warnedCount = 2
			specWarnIntermissionSoon:Show()
			self:UnregisterShortTermEvents()
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137146 and self:AntiSpam(2, 2) then--Supercharge Conduits (comes earlier than other events so we use this one)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_cjcn.ogg") --超級充能		
		intermissionActive = true
		firstchain = 0
		twocirle = false
		chaincount = 0
		specWarnDiffusionChainSoon:Cancel()
		sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_sdls.ogg")
		if phase > 1 then
			self:Unschedule(warnSpellReflection)
		end
		specWarnBouncingBoltSoon:Cancel()
		timerThunderstruckCD:Cancel()
		timerCrashingThunder:Cancel()
		timerDecapitateCD:Cancel()
		timerFussionSlashCD:Cancel()
		timerLightningWhipCD:Cancel()
		timerSummonBallLightningCD:Cancel()
		sndWOP:Cancel(DBM.SoundMMPath.."\\ex_tt_wmdq.ogg")
		if phase == 1 then
			sndWOP:Schedule(45, DBM.SoundMMPath.."\\ptwo.ogg")--2階段準備
		elseif phase == 2 then
			sndWOP:Schedule(45, DBM.SoundMMPath.."\\pthree.ogg")--3階段準備
		end
		timerSuperChargedConduits:Start()
		timerStaticShockCD:Cancel()
		timerDiffusionChainCD:Cancel()
		timerOverchargeCD:Cancel()
		timerBouncingBoltCD:Cancel()
		if not eastDestroyed then
			if self:IsDifficulty("lfr25") then
				timerDiffusionChainCD:Start(10)
				specWarnDiffusionChainSoon:Schedule(6)
				sndWOP:Schedule(6, DBM.SoundMMPath.."\\scattersoon.ogg")--注意分散
			else
				timerDiffusionChainCD:Start(6)
				specWarnDiffusionChainSoon:Schedule(2)
				sndWOP:Schedule(2, DBM.SoundMMPath.."\\scattersoon.ogg")--注意分散
			end
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(8)
		end
		if not southDestroyed then
			if self:IsDifficulty("lfr25") then
				timerOverchargeCD:Start(10)
			else
				timerOverchargeCD:Start(6)
			end
		end
		if not westDestroyed and not self:IsDifficulty("lfr25") then--Doesn't get cast in first wave in LFR, only second
			warnBouncingBolt:Schedule(14)
			specWarnBouncingBolt:Schedule(14)
			sndWOP:Schedule(14, DBM.SoundMMPath.."\\ex_tt_fscq.ogg")
			timerBouncingBoltCD:Start(14)
		end
		if not northDestroyed then
			if self:IsDifficulty("lfr25") then
				timerStaticShockCD:Start(21)
			else
				timerStaticShockCD:Start(19)
			end
		end
		self:Schedule(23, LoopIntermission)--Fire function to start second wave of specials timers
		if self:IsDifficulty("heroic10", "heroic25") then
			timerHelmOfCommand:Start(14)
		end
	elseif spellId == 136395 and self:AntiSpam(2, 3) and not intermissionActive then--Bouncing Bolt (During intermission phases, it fires randomly, use scheduler and filter this :\)
		warnBouncingBolt:Show()
		specWarnBouncingBolt:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_fscq.ogg")
		timerBouncingBoltCD:Start()
		specWarnBouncingBoltSoon:Schedule(36)
	elseif spellId == 136869 and self:AntiSpam(2, 4) then--Violent Gale Winds
		warnViolentGaleWinds:Show()
		timerViolentGaleWinds:Start()
		timerViolentGaleWindsCD:Start()
		sndWOP:Schedule(27, DBM.SoundMMPath.."\\ex_tt_qfzb.ogg") --強風準備
		self:Schedule(28, function()
			DBM:PlayCountSound(windcount + 1)
		end)
		windcount = windcount + 1
		if MyJSP3() then
			sndWOP:Play(DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 136543 then
		lbcount = lbcount + 1
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69232 then
		lbcount = lbcount - 1
--		print(GetSpellInfo(136543)..":"..lbcount)
		if lbcount == 0 then
			if self:IsDifficulty("heroic10", "heroic25") and self.Options.RangeFrameLB then
				DBM.RangeCheck:Hide()
				if self:IsRanged() then
					DBM.RangeCheck:Show(8)
				end
			end
		end
	end
end

function mod:CHAT_MSG_SAY(msg, sender)
	if checkmsg == "" then return end
	if msg:find(checkmsg) then
		if StaticShockMarkers[sender] and not canceledshock[sender] then
			StaticShockMarkers[sender] = free(StaticShockMarkers[sender])
			StaticShockMarkers[sender.."Edge"] = free(StaticShockMarkers[sender.."Edge"])
			StaticShockMarkers[sender] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", sender, 8, 8, 1, 1, 1, 0.8):Appear():RegisterForAlerts())
			if sender ~= UnitName("player") then
				canceledshock[sender] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("cross2", sender, 8, 8, 1, 1, 1, 1))
			end
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "Refle" then
		if self:AntiSpam(20, 15) then
			chaincount = chaincount + 1
			if ((mod.Options.optDD == "DD1") and (chaincount % 2 == 1)) or ((mod.Options.optDD == "DD2") and (chaincount % 2 == 0)) then
				sndWOP:Play(DBM.SoundMMPath.."\\ex_tt_kkdf.ogg")
			end
		end
	end
end