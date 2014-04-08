local mod	= DBM:NewMod(817, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
--BH ADD
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9745 $"):sub(12, -3))
mod:SetCreatureID(68078, 68079, 68080, 68081)--Ro'shak 68079, Quet'zal 68080, Dam'ren 68081, Iron Qon 68078
mod:SetMainBossID(68078)
mod:SetQuestID(32754)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	--BH ADD
	"UNIT_POWER",
	"SPELL_SUMMON",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"UNIT_DIED"
)

local warnImpale						= mod:NewStackAnnounce(134691, 2, nil, mod:IsTank() or mod:IsHealer())
local warnThrowSpear					= mod:NewTargetAnnounce(134926, 3)--Target scanning does not work for this.
local warnPhase1						= mod:NewPhaseAnnounce(1)
local warnMoltenInferno					= mod:NewSpellAnnounce(134664, 2, nil, false)--highly variables cd, also can be spammy. disbled by default.
local warnUnleashedFlame				= mod:NewSpellAnnounce(134611, 3, nil, false)--Spammy and unnesssary. Every 6 seconds is too often for a non important warning. people can turn it on if they want.
local warnMoltenOverload				= mod:NewSpellAnnounce(137221, 4)
local warnWhirlingWinds					= mod:NewSpellAnnounce(139167, 3)--Heroic Phase 1
local warnPhase2						= mod:NewPhaseAnnounce(2)
local warnWindStorm						= mod:NewSpellAnnounce(136577, 4)
local warnWindStormEnd					= mod:NewEndAnnounce(136577, 4)
local warnLightningStorm				= mod:NewTargetAnnounce(136192, 3)
local warnFrostSpike					= mod:NewSpellAnnounce(139180, 3)--Heroic Phase 2
local warnPhase3						= mod:NewPhaseAnnounce(3)
local warnDeadZone						= mod:NewAnnounce("warnDeadZone", 3, 137229)
local warnFreeze						= mod:NewTargetAnnounce(135145, 3, nil, false)--Spammy, more of a duh type warning I think
local warnPhase4						= mod:NewPhaseAnnounce(4)
local warnRisingAnger					= mod:NewStackAnnounce(136323, 2, nil, false)
local warnFistSmash						= mod:NewCountAnnounce(136146, 3)

local specWarnImpale					= mod:NewSpecialWarningStack(134691, mod:IsTank(), 2)
local specWarnImpaleOther				= mod:NewSpecialWarningTarget(134691, mod:IsTank())
local specWarnThrowSpear				= mod:NewSpecialWarningSpell(134926, nil, nil, nil, 2)
local specWarnThrowSpearYou				= mod:NewSpecialWarningYou(134926)
local specWarnThrowSpearNear			= mod:NewSpecialWarningClose(134926)
local yellThrowSpear					= mod:NewYell(134926)
local specWarnScorched					= mod:NewSpecialWarningStack(134647, false, 3)--We do a 4 and 2 strat (4 melee 2 ranged). 3 is not an everyone strat.
local specWarnBurningCinders			= mod:NewSpecialWarningMove(137668)
local specWarnMoltenOverload			= mod:NewSpecialWarningSpell(137221, nil, nil, nil, 2)
local specWarnWindStorm					= mod:NewSpecialWarningSpell(136577, nil, nil, nil, 2)
local specWarnStormCloud				= mod:NewSpecialWarningMove(137669)
local specWarnLightningStorm			= mod:NewSpecialWarningYou(136192)
local yellLightningStorm				= mod:NewYell(136192)
local specWarnFrozenBlood				= mod:NewSpecialWarningMove(136520)
local specWarnFistSmash					= mod:NewSpecialWarningCount(136146, nil, nil, nil, 2)
--BH ADD
local specWarnJSA						= mod:NewSpecialWarning("SpecWarnJSA")

local timerImpale						= mod:NewTargetTimer(40, 134691, mod:IsTank() or mod:IsHealer())
local timerImpaleCD						= mod:NewCDTimer(20, 134691, mod:IsTank() or mod:IsHealer())
local timerThrowSpearCD					= mod:NewCDTimer(30, 134926)--30-42 second variation observed
local timerUnleashedFlameCD				= mod:NewCDTimer(6, 134611, nil, false)--CD for the periodic trigger, not when he'll actually be at 30 energy and use it.
local timerScorched						= mod:NewBuffFadesTimer(30, 134647)
local timerMoltenOverload				= mod:NewBuffActiveTimer(10, 137221)
local timerLightningStormCD				= mod:NewCDTimer(20, 136192)
local timerWindStorm					= mod:NewBuffActiveTimer(19.8, 136577)--19.8~21.7sec variables
local timerWindStormCD					= mod:NewNextTimer(70, 136577)
local timerFreezeCD						= mod:NewCDTimer(7, 135145, nil, false)
local timerDeadZoneCD					= mod:NewCDTimer(15, 137229)
local timerRisingAngerCD				= mod:NewNextTimer(15, 136323, nil, false)
local timerFistSmash					= mod:NewBuffActiveTimer(8, 136146)
local timerFistSmashCD					= mod:NewNextCountTimer(20, 136146)
local timerWhirlingWindsCD				= mod:NewCDTimer(30, 139167)--Heroic Phase 1
local timerFrostSpikeCD					= mod:NewCDTimer(11, 139180)--Heroic Phase 2

local berserkTimer						= mod:NewBerserkTimer(720)

mod:AddBoolOption("SetIconOnLightningStorm")

-- BH ADD
local Warned = false
local stormcount = 0
local lightmaker = {}
local FireMarkers={}

local morestack = 0

mod:AddBoolOption("ReapetAP", true, "sound")
mod:AddBoolOption("SoundARAT", mod:IsDps(), "sound")
mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudLight", false, "sound")

-- BH ADD END
mod:AddBoolOption("RangeFrame", true)--One tooltip says 8 yards, other says 10. Confirmed it's 10 during testing though. Ignore the 8 on spellid 134611
mod:AddBoolOption("InfoFrame")

local Roshak = select(2, EJ_GetCreatureInfo(2, 817))
local Quetzal = select(2, EJ_GetCreatureInfo(3, 817))
local Damren = select(2, EJ_GetCreatureInfo(4, 817))
local arcingName = GetSpellInfo(136193)
local phase = 1--Not sure this is useful yet, coding it in, in case spear cd is different in different phases
local fistSmashCount = 0
--Spear/arcing methods called VERY often, so cache these globals locally
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local UnitExists = UnitExists
local UnitClass = UnitClass
local UnitDebuff = UnitDebuff

local function updateHealthFrame()
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		if phase == 1 then
			DBM.BossHealth:AddBoss(68079, Roshak)
		elseif phase == 2 then
			DBM.BossHealth:AddBoss(68080, Quetzal)
		elseif phase == 3 then
			DBM.BossHealth:AddBoss(68081, Damren)
		elseif phase == 4 then
			DBM.BossHealth:AddBoss(68078, L.name)
			if mod:IsDifficulty("heroic10", "heroic25") then
				DBM.BossHealth:AddBoss(68081, Damren)
				DBM.BossHealth:AddBoss(68080, Quetzal)
				DBM.BossHealth:AddBoss(68079, Roshak)
			end
		end
	end
end

--Custom, don't use IsTanking prototype here
local function notEligable(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss' highest threat target
	-- 4. Check monks
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	if UnitExists("boss2target") and UnitDetailedThreatSituation(unit, "boss2") then
		return true
	end
	--He CAN spear monks that are not in melee (I seen our mistweaver get many spears at ranged).
	--However, if he targets a monk that IS in melee, he switches to a different target (again, i've seen him target our mistweaver in melee range, then instantly switched to ANOTHER target because the mistweaver was in melee).
	--We assume any monk within 15 yards of tank is in melee range, may be wrong once in a blue moon.
	--Should fairly accurately allow the mod to announce spears on monks outside melee range while ignoring monk targets in melee range
	if (select(2, UnitClass(unit)) == "MONK") and (DBM.RangeCheck:GetDistance(unit, "boss2target") <= 15) then
		return true
	end
	return false
end

--Spear target happens BEFORE cast, so we have to pre schedule scan it to grab target
--This will fail if the spear target actually IS his highest threat
--In that case the aoe failsafe warning will just be used, so 1/10 or 1/25 odds in phase 1.
local function checkSpear()
	if UnitExists("boss1target") and not notEligable("boss1target") then--Boss 1 is looking at someone that isn't his highest threat or a tank (have to filter tanks cause he looks at them to cast impale, have to filter his highest threat in case it's not a tank, ie a healer)
		mod:Unschedule(checkSpear)
		local targetname = DBM:GetUnitFullName("boss1target")
		warnThrowSpear:Show(targetname)
		if UnitIsUnit("boss1target", "player") then--you are spear target
			specWarnThrowSpearYou:Show()
			yellThrowSpear:Yell()
		else--Not spear target
			local x, y = GetPlayerMapPosition("boss1target")
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition("boss1target")
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 10 then
				specWarnThrowSpearNear:Show(targetname)--Near spear target
			elseif mod:AntiSpam(15, 6) then--Smart way to do a failsafe in case we never get a valid target
				specWarnThrowSpear:Show()--not spear target or near spear target, generic aoe warning (for the lines and stuff)
			end
		end
	else
		mod:Schedule(0.25, checkSpear)
	end
end

local function checkArcing()
	local arcingDebuffs = 0
	for uId in DBM:GetGroupMembers() do
		if UnitDebuff(uId, arcingName) then
			arcingDebuffs = arcingDebuffs + 1
		end
	end
	if arcingDebuffs == 0 then
		mod:Unschedule(checkArcing)
		if mod.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:Hide()
		end
	else
		mod:Schedule(5, checkArcing)
	end
end
-- BH ADD
for i = 1, 7 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

mod:AddBoolOption("dispsetLight", true, "sound")
mod:AddEditBoxOption("dispsetLight1", 150, "", "sound")
mod:AddEditBoxOption("dispsetLight2", 150, "", "sound")

local function MyJS()
	if (mod.Options.dr1 and fistSmashCount == 1) or (mod.Options.dr2 and fistSmashCount == 2) or (mod.Options.dr3 and fistSmashCount == 3) or (mod.Options.dr4 and fistSmashCount == 4) or (mod.Options.dr5 and fistSmashCount == 5) or (mod.Options.dr6 and fistSmashCount == 6) or (mod.Options.dr7 and fistSmashCount == 7) then
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
function mod:checkmydebuff()
    if UnitDebuff("player", GetSpellInfo(136192)) then
		SendChatMessage(L.Helpme, "SAY")
		self:ScheduleMethod(4, "checkmydebuff")
	end
end
local function fixdebuffremovebug(checkplayer)
    if UnitDebuff(checkplayer, GetSpellInfo(136192)) then
		mod:Schedule(2, function()
			fixdebuffremovebug(checkplayer)
		end)
	else
		if lightmaker[checkplayer] then
			lightmaker[checkplayer] = free(lightmaker[checkplayer])
		end
	end
end

local function fixdebuffremovebug2(checkplayer)
    if UnitDebuff(checkplayer, GetSpellInfo(136193)) then
		mod:Schedule(2, function()
			fixdebuffremovebug2(checkplayer)
		end)
	else
		if FireMarkers[checkplayer] then
			FireMarkers[checkplayer] = free(FireMarkers[checkplayer])
		end
	end
end
-- BH ADD END

function mod:OnCombatStart(delay)
	phase = 1
	fistSmashCount = 0
	morestack = 0
	updateHealthFrame()
	warnPhase1:Show()
	--BH ADD
	Warned = false
	stormcount = 0
	table.wipe(lightmaker)
	table.wipe(FireMarkers)
	sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_hyxt.mp3") --火焰形态
	--BH ADD END
	timerThrowSpearCD:Start(-delay)
	self:Schedule(25, checkSpear)
	if self.Options.RangeFrame then
		if self:IsDifficulty("normal10", "heroic10") then
			DBM.RangeCheck:Show(10, nil, nil, 2)
		else
			DBM.RangeCheck:Show(10, nil, nil, 4)
		end
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerWhirlingWindsCD:Start(15-delay)
		timerLightningStormCD:Start(22-delay)
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(136193))
			DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
		end
	end
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	--BH ADD
	if self.Options.HudMAP or self.Options.HudLight then
		DBMHudMap:FreeEncounterMarkers()
	end
	--BH ADD END
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 134691 then
		local amount = args.amount or 1
		warnImpale:Show(args.destName, amount)
		timerImpaleCD:Start()
		if amount >= 2 then
			if args:IsPlayer() then
				specWarnImpale:Show(args.amount)
			else
				specWarnImpaleOther:Show(args.destName)
			end
		end
	elseif args.spellId == 134647 then
		if args:IsPlayer() then
			local amount = args.amount or 1
			timerScorched:Start()
			if amount > 2 then
				specWarnScorched:Show(amount)
			end
		end
		--[[
		if morestack < (args.amount or 1) then
			morestack = (args.amount or 1)
		end
		self:Schedule(0.2, function()
			if morestack == 1 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			elseif morestack == 2 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			elseif morestack == 3 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			elseif morestack == 4 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			elseif morestack == 5 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			elseif morestack == 6 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
			end
			morestack = 0
		end)
		]]
	elseif args.spellId == 137221 then
		warnMoltenOverload:Show()
		specWarnMoltenOverload:Show()
		timerMoltenOverload:Start()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_rycz.mp3") --熔岩超載
	elseif args.spellId == 136192 then
		warnLightningStorm:Show(args.destName)
		if phase == 2 then
			timerLightningStormCD:Start()
		else--Heroic phase 1 or 4
			timerLightningStormCD:Start(37.5)
		end
		if self.Options.SetIconOnLightningStorm and not self:IsDifficulty("lfr25") then
			self:SetIcon(args.destName, 8)
		end
		--BH ADD
		if args:IsPlayer() then
			specWarnLightningStorm:Show()
			yellLightningStorm:Yell()
			if self.Options.ReapetAP then
				self:ScheduleMethod(4, "checkmydebuff")
			end
		else
			if (mod.Options.dispsetLight1 == "") and (mod.Options.dispsetLight2 == "") then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\helpme.mp3") --救我
				if self.Options.HudMAP then
					lightmaker[args.destName] = register(DBMHudMap:AddEdge(0, 0, 1, 1, nil, "player", args.destName))
					fixdebuffremovebug(args.destName)
				end				
			else
				if (args.destName == mod.Options.dispsetLight1) or (args.destName == mod.Options.dispsetLight2) then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\helpme.mp3") --救我
					if self.Options.HudMAP then
						lightmaker[args.destName] = register(DBMHudMap:AddEdge(0, 0, 1, 1, nil, "player", args.destName))
						fixdebuffremovebug(args.destName)
					end
				end
			end
		end
		--BH ADD END
	elseif args.spellId == 135145 then
		warnFreeze:Show(args.destName)
		if phase == 3 then
			timerFreezeCD:Start()
		else--Heroic phase 2 or 4
			timerFreezeCD:Start(36)
		end
	elseif args.spellId == 136323 then
		warnRisingAnger:Show(args.destName, args.amount or 1)
		timerRisingAngerCD:Start()
	elseif args.spellId == 136193 then
		if phase > 2 then
			if self.Options.HudLight and not FireMarkers[args.destName] then
				FireMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", args.destName, 10, nil, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts())
				fixdebuffremovebug2(args.destName)
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 134647 and args:IsPlayer() then
		timerScorched:Cancel()
	--BH ADD
	elseif args.spellId == 136192 then
		if lightmaker[args.destName] then
			lightmaker[args.destName] = free(lightmaker[args.destName])
		end
		if (args.destName == mod.Options.dispsetLight1) or (args.destName == mod.Options.dispsetLight2) then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\thanks.mp3")
		end
		if self.Options.SetIconOnLightningStorm and not self:IsDifficulty("lfr25") then
			self:SetIcon(args.destName, 0)
		end
	--BH ADD END
	elseif args.spellId == 136193 then
		if FireMarkers[args.destName] then
			FireMarkers[args.destName] = free(FireMarkers[args.destName])
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 134664 then
		warnMoltenInferno:Show()
	--Dead zone IDs, each dead zone has two shields and two openings. Each spellid identifies those openings.
	elseif args.spellId == 137226 then--Front, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_FRONT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		if self.Options.SoundARAT then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\attmid.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_mq.mp3")
		end
		--Attack left or Behind (maybe add special warning that says where you can attack, for dps?)
	elseif args.spellId == 137227 then--Left, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		if self.Options.SoundARAT then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\attmid.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_mq.mp3")
		end
		--Attack Front or Behind
	elseif args.spellId == 137228 then--Left, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_LEFT, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		if self.Options.SoundARAT then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\attmid.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_mq.mp3")
		end
		--Attack Right or Behind
	elseif args.spellId == 137229 then--Back, Front Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_FRONT)
		timerDeadZoneCD:Start()
		if self.Options.SoundARAT then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\attleft.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_mq.mp3")
		end
		--Attack left or Right
	elseif args.spellId == 137230 then--Back, Left Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_LEFT)
		timerDeadZoneCD:Start()
		if self.Options.SoundARAT then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\attright.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_mq.mp3")
		end
		--Attack Front or Right
	elseif args.spellId == 137231 then--Back, Right Shielded
		warnDeadZone:Show(args.spellName, DBM_CORE_BACK, DBM_CORE_RIGHT)
		timerDeadZoneCD:Start()
		if self.Options.SoundARAT then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\attleft.mp3")
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_mq.mp3")
		end
		--Attack Front or Left
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 134926 and phase < 4 then
		if self:AntiSpam(15, 6) then--Basically, if the target scanning failed, we do an aoe warning on the actual summon.
			specWarnThrowSpear:Show()
		end
		timerThrowSpearCD:Start()
		self:Unschedule(checkSpear)
		self:Schedule(25, checkSpear)--Timing adjust to reduce cpu usage when we know for sure the best time to check target. spear cd is variable, minimum though is 30, 25 is probably too early to start scanning but a good place to start.
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\spear.mp3") --投擲長矛
	end
end

--[[
--One of these is standing in fire and you need to move,other is dot you can't do anything about cause you stood in it too long. I'm not sure which is which so mod may be backwards, if it is, swap the damage events
"<54.8 20:15:39> [CLEU] SPELL_PERIODIC_DAMAGE#true##nil#1297#2#0x0100000000001E03#Omegal#1297#2#137668#Burning Cinders#4#15972#-1#4#nil#nil#nil#nil#nil#nil#nil", -- [3846]
"<55.4 20:15:39> [CLEU] SPELL_DAMAGE#true##nil#1298#8#0x01000000000036C3#Ixila#1298#8#137668#Burning Cinders#4#8896#-1#4#nil#nil#17562#nil#nil#nil#nil", -- [3905]
--]]
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 137668 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnBurningCinders:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
	elseif spellId == 137669 and destGUID == UnitGUID("player") and self:AntiSpam(3, 3) then
		specWarnStormCloud:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	elseif spellId == 137664 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnFrozenBlood:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 134611 then--Unleashed Flame internal CD. He cannot use more often than every 6 seconds. 137991 is ability activation on pull, before 137991 is cast, he can't use ability at all
		warnUnleashedFlame:Show()
		timerUnleashedFlameCD:Start()
		--NOTE, on heroic phase 3-4, trigger still fires every 6 seconds but energy gain is slower so it won't actually go off often like it does in phase 1.
		--None the less, this timer is accurate on heroic as 6 seconds as it indicates when the next POSSIBLE cast is. in other words, if he reaches enough energy during this cd, he won't cast it until 6 second cd ends
		--This cast is the periodic trigger that checks whether or not boss has 30 energy, nothing more.
	elseif spellId == 50630 then--Eject All Passengers (heroic phase change trigger)
		local cid = self:GetCIDFromGUID(UnitGUID(uId))
		self:Unschedule(checkSpear)
		timerThrowSpearCD:Start()
		if cid == 68079 then--Ro'shak
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			--Only one log, but i looks like spear cd from phase 1 remains intact
			phase = 2
			stormcount = 0
			updateHealthFrame()
			if self:IsDifficulty("heroic10", "heroic25") then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_sdxt.mp3") --閃電形态
			end
			timerUnleashedFlameCD:Cancel()
			timerMoltenOverload:Cancel()
			timerWhirlingWindsCD:Cancel()
			warnPhase2:Show()
			self:Schedule(25, checkSpear)
			if self:IsDifficulty("heroic10", "heroic25") then
				timerFreezeCD:Start(13)
				timerFrostSpikeCD:Start(15)
			end
			timerLightningStormCD:Start()
			warnWindStorm:Schedule(52)
			specWarnWindStorm:Schedule(52)
			timerWindStorm:Schedule(52)
			timerWindStormCD:Start(52)
			sndWOP:Schedule(47, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")
			sndWOP:Schedule(48, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(49, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(50, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(51, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(52, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		elseif cid == 68080 then--Quet'zal
			phase = 3
			if self.Options.HudLight then
				for i = 1, DBM:GetNumGroupMembers() do
					if UnitDebuff("raid"..i, GetSpellInfo(136193)) then
						if UnitName("raid"..i) ~= UnitName("player") then
							FireMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", UnitName("raid"..i), 10, nil, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts())
						else
							FireMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", UnitName("raid"..i), 10, nil, 1, 1 ,1 ,0.4):Appear():RegisterForAlerts())
						end
						fixdebuffremovebug2(UnitName("raid"..i))
					end
				end
			end
			updateHealthFrame()
			if self:IsDifficulty("heroic10", "heroic25") then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_bsxt.mp3") --冰霜形態
			end
			timerLightningStormCD:Cancel()
			timerWindStorm:Cancel()
			timerWindStormCD:Cancel()
			warnWindStorm:Cancel()
			specWarnWindStorm:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			timerFrostSpikeCD:Cancel()
			warnPhase3:Show()
			self:Schedule(25, checkSpear)
			timerDeadZoneCD:Start(8.5)
			checkArcing()
		elseif cid == 68081 then--Dam'ren
			--confirmed, dam'ren's abilities do NOT reset in phase 4, cds from phase 3 carry over.
			phase = 4
			updateHealthFrame()
			warnPhase4:Show()
			timerRisingAngerCD:Start(15)
			timerFistSmashCD:Start(62, 1)
			self:Unschedule(checkArcing)--Phase 4, new arcings start going out again so no need to do waste time on this check until  quet'zal dies
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			if self.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(arcingName)
				DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
			end
			if self:IsDifficulty("heroic10", "heroic25") then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3") --2階段
			end
		end
	elseif spellId == 139172 then--Whirling Winds (Phase 1 Heroic).
		warnWhirlingWinds:Show()
		timerWhirlingWindsCD:Start()
	elseif spellId == 139181 then--Frost Spike (Phase 2 Heroic)
		warnFrostSpike:Show()
		timerFrostSpikeCD:Start()
	elseif spellId == 137656 and self:AntiSpam(2, 1) then--Rushing Winds (Wind Storm end trigger)
		warnWindStorm:Cancel()
		specWarnWindStorm:Cancel()
		warnWindStormEnd:Show()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")		
		if phase == 2 then
			warnWindStorm:Schedule(70)
			specWarnWindStorm:Schedule(70)
			timerWindStorm:Schedule(70)
			sndWOP:Schedule(65, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")
			sndWOP:Schedule(66, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(67, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(68, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(69, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(70, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
		timerWindStormCD:Start()
	elseif spellId == 136146 and self:AntiSpam(2, 5) then
		fistSmashCount = fistSmashCount + 1
		warnFistSmash:Show(fistSmashCount)
--		specWarnFistSmash:Show()
		timerFistSmash:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFistSmashCD:Start(30, fistSmashCount+1) -- heroic cd longer.
		else
			timerFistSmashCD:Start(nil, fistSmashCount+1)
		end		
		if MyJS() then
			specWarnJSA:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
		else
			specWarnFistSmash:Show(fistSmashCount)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68079 then--Ro'shak
		timerUnleashedFlameCD:Cancel()
		timerMoltenOverload:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10, nil, nil, 1)--Switch range frame back to 1. Range is assumed 10, no spell info
			end
			if self.Options.InfoFrame and not self:IsDifficulty("lfr25") then
				DBM.InfoFrame:SetHeader(arcingName)
				DBM.InfoFrame:Show(5, "playerbaddebuff", 136193)
			end
			phase = 2
			stormcount = 0
			updateHealthFrame()
			timerLightningStormCD:Start(17)
			self:Unschedule(checkSpear)
			self:Schedule(25, checkSpear)
			timerThrowSpearCD:Start()
			warnPhase2:Show()
			warnWindStorm:Schedule(49.5)
			specWarnWindStorm:Schedule(49.5)
			timerWindStorm:Schedule(49.5)
			sndWOP:Schedule(44.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")
			sndWOP:Schedule(45.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(46.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(47.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(48.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(49.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			timerWindStormCD:Start(49.5)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_sdxt.mp3") --閃電形态
		end
	elseif cid == 68080 then--Quet'zal
		timerLightningStormCD:Cancel()
		timerWindStormCD:Cancel()
		warnWindStorm:Cancel()
		specWarnWindStorm:Cancel()
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\wwsoon.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerWindStorm:Cancel()
		if not self:IsDifficulty("lfr25") then--LFR has no concept of clearing arcing, they certainly don't use info/range frames
			checkArcing()
		else--So just hide range frame when quet'zal dies
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
		if self:IsDifficulty("heroic10", "heroic25") then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			phase = 3
			if self.Options.HudLight then
				for i = 1, DBM:GetNumGroupMembers() do
					if UnitDebuff("raid"..i, GetSpellInfo(136193)) then
						if UnitName("raid"..i) ~= UnitName("player") then
							FireMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", UnitName("raid"..i), 10, nil, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts())
						else
							FireMarkers[UnitName("raid"..i)] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", UnitName("raid"..i), 10, nil, 1, 1 ,1 ,0.4):Appear():RegisterForAlerts())
						end
						fixdebuffremovebug2(UnitName("raid"..i))
					end
				end
			end
			updateHealthFrame()
			warnPhase3:Show()
			timerDeadZoneCD:Start(6)
			self:Unschedule(checkSpear)
			self:Schedule(25, checkSpear)
			timerThrowSpearCD:Start()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_bsxt.mp3") --冰霜形態
		end
	elseif cid == 68081 then--Dam'ren
		timerDeadZoneCD:Cancel()
		timerFreezeCD:Cancel()
		if self:IsDifficulty("heroic10", "heroic25") then--In heroic, all mounts die in phase 4.
			DBM.BossHealth:RemoveBoss(cid)
		else
			phase = 4
			updateHealthFrame()
			self:Unschedule(checkSpear)
			timerThrowSpearCD:Cancel()
			self:UnregisterShortTermEvents()
			warnPhase4:Show()
			timerRisingAngerCD:Start()
			timerFistSmashCD:Start(22.5, 1)--fist smash cd is random. (22.5 or 31.5)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3") --2階段
		end
	end
end

--BH ADD
function mod:UNIT_POWER(uId)
	if self:IsDifficulty("lfr25") then return end
	if (self:GetUnitCreatureId(uId) == 68079) and UnitPower(uId) > 50 and not Warned then
		Warned = true
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\energyhigh.mp3") --能量過高
	elseif (self:GetUnitCreatureId(uId) == 68079) and UnitPower(uId) < 20 and Warned then
		Warned = false
	end
end

--BH ADD END