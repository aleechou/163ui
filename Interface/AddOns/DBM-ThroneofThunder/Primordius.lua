﻿local mod	= DBM:NewMod(820, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11315 $"):sub(12, -3))
mod:SetCreatureID(69017)--69070 Viscous Horror, 69069 good ooze, 70579 bad ooze (patched out of game, :\)
mod:SetEncounterID(1574)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)--Although if you have 8 viscous horrors up, you are probably doing fight wrong.

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_AURA player",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnDebuffCount				= mod:NewAnnounce("warnDebuffCount", 1, 140546)
local warnMalformedBlood			= mod:NewStackAnnounce(136050, 2, nil, mod:IsTank() or mod:IsHealer())--No cd bars for this because it's HIGHLY variable (lowest priority spell so varies wildly depending on bosses 3 buffs)
local warnPrimordialStrike			= mod:NewSpellAnnounce(136037, 3, nil, mod:IsTank() or mod:IsHealer())
local warnGasBladder				= mod:NewTargetAnnounce(136215, 4)--Stack up in front for (but not too close or cleave will get you)
local warnCausticGas				= mod:NewCastAnnounce(136216, 3)
local warnEruptingPustules			= mod:NewTargetAnnounce(136246, 4)
local warnPustuleEruption			= mod:NewSpellAnnounce(136247, 3, nil, false)--Spammy
local warnPathogenGlands			= mod:NewTargetAnnounce(136225, 3)
local warnVolatilePathogen			= mod:NewTargetAnnounce(136228, 4)
local warnMetabolicBoost			= mod:NewTargetAnnounce(136245, 3)--Makes Malformed Blood, Primordial Strike and melee 50% more often
local warnVentralSacs				= mod:NewTargetAnnounce(136210, 2)--This one is a joke, if you get it, be happy.
local warnAcidicSpines				= mod:NewTargetAnnounce(136218, 3)
local warnViscousHorror				= mod:NewCountAnnounce("ej6969", mod:IsTank(), 137000)
local warnBlackBlood				= mod:NewStackAnnounce(137000, 2, nil, mod:IsTank() or mod:IsHealer())

local specWarnFullyMutated			= mod:NewSpecialWarningYou(140546)
local specWarnFullyMutatedFaded		= mod:NewSpecialWarningFades(140546)
local specWarnCausticGas			= mod:NewSpecialWarningSpell(136216, nil, nil, nil, 2)--All must be in front for this.
local specWarnVolatilePathogen		= mod:NewSpecialWarningYou(136228)
local specWarnViscousHorror			= mod:NewSpecialWarningCount("ej6969", mod:IsTank())
local specWarnPustuleEruption		= mod:NewSpecialWarningSpell(136247)

local timerFullyMutated				= mod:NewBuffFadesTimer(120, 140546)
local timerMalformedBlood			= mod:NewTargetTimer(60, 136050, nil, mod:IsTank() or mod:IsHealer())
local timerPrimordialStrikeCD		= mod:NewCDTimer(24, 136037)
local timerCausticGasCD				= mod:NewCDTimer(14, 136216)
local timerPustuleEruptionCD		= mod:NewCDTimer(10, 136247)
local timerVolatilePathogenCD		= mod:NewCDTimer(27, 136228)--Too cute blizzard, too cute. (those who get the 28 reference for pathogen get an A+)
local timerBlackBlood				= mod:NewTargetTimer(60, 137000, nil, mod:IsTank() or mod:IsHealer())
local timerViscousHorrorCD			= mod:NewNextCountTimer(30, "ej6969", nil, nil, nil, 137000)

local berserkTimer					= mod:NewBerserkTimer(480)

local bossspellinfo = {}

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("SetIconOnBigOozes", false)--These very hard to see when spawn. rooms red, boss is red, damn ooze is red.
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("HudMAPF", true, "sound")

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local FireMarkers = {}

local function showspellinfo()
	if mod.Options.InfoFrame then
		table.wipe(bossspellinfo)
		if UnitAura("boss1", GetSpellInfo(136210)) then
			bossspellinfo[GetSpellInfo(136210)] = L.AE1
		end
		if UnitAura("boss1", GetSpellInfo(136215)) then
			bossspellinfo[GetSpellInfo(136215)] = L.AE2
		end
		if UnitAura("boss1", GetSpellInfo(136218)) then
			bossspellinfo[GetSpellInfo(136218)] = L.tar5
		end
		if UnitAura("boss1", GetSpellInfo(136225)) then
			bossspellinfo[GetSpellInfo(136225)] = L.tar1
		end
		if UnitAura("boss1", GetSpellInfo(136245)) then
			bossspellinfo[GetSpellInfo(136245)] = L.speed
		end
		if UnitAura("boss1", GetSpellInfo(136246)) then
			bossspellinfo[GetSpellInfo(136246)] = L.tar2
		end
		local sh = {}
		table.wipe(sh)
		for k,v in pairs(bossspellinfo) do
			table.insert(sh,{K=k,V=v})
		end
		DBM.InfoFrame:SetHeader(L.BossSpellInfo)
		if #sh == 1 then
			DBM.InfoFrame:Show(1, "other", sh[1].V, sh[1].K)
		elseif #sh == 2 then
			DBM.InfoFrame:Show(2, "other", sh[1].V, sh[1].K, sh[2].V, sh[2].K)
		elseif #sh == 3 then
			DBM.InfoFrame:Show(3, "other", sh[1].V, sh[1].K, sh[2].V, sh[2].K, sh[3].V, sh[3].K)
		elseif #sh == 4 then
			DBM.InfoFrame:Show(4, "other", sh[1].V, sh[1].K, sh[2].V, sh[2].K, sh[3].V, sh[3].K, sh[4].V, sh[4].K)
		end
	end
end

local metabolicBoost = false
local acidSpinesActive = false--Spread of 5 yards
local postulesActive = false
local goodCount = 0
local badCount = 0
local bigOozeCount = 0
local bigOozeAlive = 0
local bigOozeGUIDS = {}

function mod:BigOoze()
	bigOozeCount = bigOozeCount + 1
	bigOozeAlive = bigOozeAlive + 1
--	print("DBM Debug Spawn: ", bigOozeAlive)
	warnViscousHorror:Show(bigOozeCount)
	specWarnViscousHorror:Show(bigOozeCount)
	if mod:IsTank() then
		sndWOP:Play("ex_tt_drn")--大軟泥
	end
	timerViscousHorrorCD:Start(30, bigOozeCount+1)
	self:ScheduleMethod(30, "BigOoze")
	--This is a means to try and do it without using lots of cpu on an already cpu bad fight. If it's not fast enough or doesn't work well (ie people with assist aren't doing this fast enough). may still have to scan all targets
	if DBM:GetRaidRank() > 0 and self.Options.SetIconOnBigOozes then--Only register event if option is turned on, otherwise no waste cpu
		self:RegisterShortTermEvents(
			"PLAYER_TARGET_CHANGED",
			"UPDATE_MOUSEOVER_UNIT"
		)
	end
end

function mod:PLAYER_TARGET_CHANGED()
	local guid = UnitGUID("target")
	if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
		local cId = tonumber(guid:sub(6, 10), 16)
		if cId == 69070 and not bigOozeGUIDS[guid] and not UnitIsDead("target") then
			local icon = 9 - bigOozeAlive--Start with skull for big ooze then subtrack from it based on number of oozes up to choose an unused icon
			bigOozeGUIDS[guid] = true--NOW we add this ooze to the table now that we're done counting old ones
			self:UnregisterShortTermEvents()--Add is marked, unregister events until next ooze spawns
			SetRaidTarget("target", icon)
			self:SendSync("BigOozeGUID", guid)--Make sure we keep everynoes ooze guid ignore list/counts up to date.
		end
	end
end

function mod:UPDATE_MOUSEOVER_UNIT()
	local guid = UnitGUID("mouseover")
	if guid and (bit.band(guid:sub(1, 5), 0x00F) == 3 or bit.band(guid:sub(1, 5), 0x00F) == 5) then
		local cId = tonumber(guid:sub(6, 10), 16)
		if cId == 69070 and not bigOozeGUIDS[guid] and not UnitIsDead("mouseover") then
			local icon = 9 - bigOozeAlive--Start with skull for big ooze then subtrack from it based on number of oozes up to choose an unused icon
			bigOozeGUIDS[guid] = true--NOW we add this ooze to the table now that we're done counting old ones
			self:UnregisterShortTermEvents()--Add is marked, unregister events until next ooze spawns
			SetRaidTarget("mouseover", icon)
			self:SendSync("BigOozeGUID", guid)
		end
	end
end

function mod:OnCombatStart(delay)
	metabolicBoost = false
	acidSpinesActive = false
	postulesActive = false
	goodCount = 0
	badCount = 0
	bigOozeCount = 0
	bigOozeAlive = 0
	table.wipe(bigOozeGUIDS)
	berserkTimer:Start(-delay)
	if self:IsDifficulty("heroic10", "heroic25") then
		timerViscousHorrorCD:Start(10-delay, 1)
		self:ScheduleMethod(10-delay, "BigOoze")
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 136216 then
		warnCausticGas:Show()
		specWarnCausticGas:Show()
		sndWOP:Play("ex_tt_kjfd")--靠近分擔
		timerCausticGasCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 136037 then
		warnPrimordialStrike:Show()
		if metabolicBoost then--Only issue is updating current bar when he gains buff in between CDs, it does seem to affect it to a degree
			timerPrimordialStrikeCD:Start(20)
		else
			timerPrimordialStrikeCD:Start()
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 136050 then
		warnMalformedBlood:Show(args.destName, args.amount or 1)
		timerMalformedBlood:Start(args.destName)
	elseif args.spellId == 137000 then
		warnBlackBlood:Show(args.destName, args.amount or 1)
		timerBlackBlood:Start(args.destName)
	elseif args.spellId == 136215 then
		warnGasBladder:Show(args.destName)
		showspellinfo()
	elseif args.spellId == 136246 then
		postulesActive = true
		warnEruptingPustules:Show(args.destName)
		timerPustuleEruptionCD:Start()--not affected by metabolicBoost?
		if self.Options.RangeFrame and not acidSpinesActive then--Check if acidSpinesActive is active, if they are, we should already have range 5 up
			DBM.RangeCheck:Show(3)
		end
		sndWOP:Play("range2")--2碼手雷
		showspellinfo()
	elseif args.spellId == 136225 then
		warnPathogenGlands:Show(args.destName)
		showspellinfo()	
	elseif args.spellId == 136228 then
		warnVolatilePathogen:Show(args.destName)
		timerVolatilePathogenCD:Start()
		if args:IsPlayer() then
			specWarnVolatilePathogen:Show()
			sndWOP:Play("holdit")--自保
			-- DBM.Flash:Shake(1, 0, 0)
		elseif mod:IsHealer() then
			sndWOP:Play("ex_tt_byt")--病原體出現
		end
	elseif args.spellId == 136245 then
		metabolicBoost = true
		sndWOP:Play("ex_tt_sljs")--加速
		warnMetabolicBoost:Show(args.destName)
		showspellinfo()		
	elseif args.spellId == 136210 then
		warnVentralSacs:Show(args.destName)
		showspellinfo()
	elseif args.spellId == 136218 then
		acidSpinesActive = true
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		sndWOP:Play("range5")--注意分散
		showspellinfo()
	elseif args.spellId == 140546 and args:IsPlayer() then
		specWarnFullyMutated:Show()
		-- DBM.Flash:Shake(0, 1, 0)
		timerFullyMutated:Start()
		sndWOP:Play("ex_tt_tbwc")--完美突變
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 136050 then
		timerMalformedBlood:Cancel(args.destName)
	elseif args.spellId == 136215 then
		timerCausticGasCD:Cancel()
		showspellinfo()
	elseif args.spellId == 136246 then
		postulesActive = false
		timerPustuleEruptionCD:Cancel()
		if self.Options.RangeFrame and not acidSpinesActive then--Check if acidSpinesActive is active, if they are, leave range frame alone
			DBM.RangeCheck:Hide()
		end
		showspellinfo()
	elseif args.spellId == 136225 then
		timerVolatilePathogenCD:Cancel()
		showspellinfo()
	elseif args.spellId == 136245 then
		metabolicBoost = false
		showspellinfo()
	elseif args.spellId == 136218 then
		acidSpinesActive = false
		if self.Options.RangeFrame then
			if postulesActive then
				DBM.RangeCheck:Show(3)
			else
				DBM.RangeCheck:Hide()
			end
		end
		showspellinfo()
	elseif args.spellId == 136210 then
		showspellinfo()
	elseif args.spellId == 140546 and args:IsPlayer() then
		timerFullyMutated:Cancel()--Can be dispeled
		specWarnFullyMutatedFaded:Show(args.spellName)
		sndWOP:Play("ex_tt_bsjs")--變身結束
	end
end

local good1 = GetSpellInfo(136180)
local good2 = GetSpellInfo(136182)
local good3 = GetSpellInfo(136184)
local good4 = GetSpellInfo(136186)
local bad1 = GetSpellInfo(136181)
local bad2 = GetSpellInfo(136183)
local bad3 = GetSpellInfo(136185)
local bad4 = GetSpellInfo(136187)

function mod:UNIT_AURA(uId)
	local gcnt, gcnt1, gcnt2, gcnt3, gcnt4, bcnt, bcnt1, bcnt2, bcnt3, bcnt4
	gcnt1 = select(4, UnitDebuff("player", good1)) or 0
	gcnt2 = select(4, UnitDebuff("player", good2)) or 0
	gcnt3 = select(4, UnitDebuff("player", good3)) or 0
	gcnt4 = select(4, UnitDebuff("player", good4)) or 0
	bcnt1 = select(4, UnitDebuff("player", bad1)) or 0
	bcnt2 = select(4, UnitDebuff("player", bad2)) or 0
	bcnt3 = select(4, UnitDebuff("player", bad3)) or 0
	bcnt4 = select(4, UnitDebuff("player", bad4)) or 0
	gcnt = gcnt1 + gcnt2 + gcnt3 + gcnt4
	bcnt = bcnt1 + bcnt2 + bcnt3 + bcnt4
	if goodCount ~= gcnt or badCount ~= bcnt then
		goodCount = gcnt
		badCount = bcnt
		warnDebuffCount:Show(goodCount, badCount)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 136248 and self:AntiSpam(2, 1) then--Pustule Eruption
		warnPustuleEruption:Show()
		timerPustuleEruptionCD:Start()
		if not self:IsDifficulty("lfr25") then
			specWarnPustuleEruption:Show()		
			sndWOP:Play("ex_tt_zynx")--注意膿血
			if mod.Options.HudMAPF then
				for i = 1, DBM:GetNumGroupMembers() do
					local uId = "raid"..i
					local x, y = GetPlayerMapPosition(uId)
					if x == 0 and y == 0 then
						SetMapToCurrentZone()
						x, y = GetPlayerMapPosition(uId)
					end
					local inRange = DBM.RangeCheck:GetDistance("player", x, y)
					if inRange and inRange < 20 then
						FireMarkers[UnitName(uId)] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", UnitName(uId), 3, 2, 1, 1 ,1 ,0.8):Appear():RegisterForAlerts())
					end
				end
			end
		end
	end
end

function mod:UNIT_DIED(args)
	if bigOozeGUIDS[args.destGUID] then
		bigOozeAlive = bigOozeAlive - 1
		bigOozeGUIDS[args.destGUID] = nil
	end
end

function mod:OnSync(msg, guid)
	if msg == "BigOozeGUID" and guid then
		bigOozeGUIDS[guid] = true
		self:UnregisterShortTermEvents()
	end
end
