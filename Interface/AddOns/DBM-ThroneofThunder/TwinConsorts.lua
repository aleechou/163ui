local mod	= DBM:NewMod(829, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndWOPCX	= mod:SoundMM("SoundWOP")
local sndYX		= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11446 $"):sub(12, -3))
mod:SetCreatureID(68905, 68904)--Lu'lin 68905, Suen 68904
mod:SetEncounterID(1560)
mod:SetZone()
mod:SetBossHPInfoToHighest()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_DAMAGE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"SPELL_SUMMON",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

local Lulin = EJ_GetSectionInfo(7629)
local Suen = EJ_GetSectionInfo(7642)

mod:SetBossHealthInfo(
	68905, Lulin,
	68904, Suen
)

--Darkness
local warnNight							= mod:NewAnnounce("warnNight", 2, 108558)
local warnCrashingStarSoon				= mod:NewCountAnnounce(137129, 2)
local warnTearsOfSun					= mod:NewSpellAnnounce(137404, 3)
local warnBeastOfNightmares				= mod:NewTargetAnnounce(137375, 3, nil, mod:IsTank() or mod:IsHealer())
--Light
local warnDay							= mod:NewAnnounce("warnDay", 2, 122789)
local warnLightOfDay					= mod:NewSpellAnnounce(137403, 2, nil, false)--Spammy, but leave it as an option at least
local warnFanOfFlames					= mod:NewStackAnnounce(137408, 2, nil, mod:IsTank() or mod:IsHealer())
local warnFlamesOfPassion				= mod:NewSpellAnnounce(137414, 3)--Todo, check target scanning
local warnIceComet						= mod:NewSpellAnnounce(137419, 1)
local warnNuclearInferno				= mod:NewCountAnnounce(137491, 4)--Heroic
--Dusk
local warnDusk							= mod:NewAnnounce("warnDusk", 2, "Interface\\Icons\\achievement_zone_easternplaguelands")--"achievement_zone_easternplaguelands" (best Dusk icon i could find)
local warnTidalForce					= mod:NewCountAnnounce(137531, 3)

--Darkness
local specWarnCrashingStarSoon			= mod:NewSpecialWarningCount(137129, false, nil, nil, 2)
local specWarnTearsOfSun				= mod:NewSpecialWarningSpell(137404, nil, nil, nil, 2)
local specWarnBeastOfNightmares			= mod:NewSpecialWarningSpell(137375, mod:IsTank())
--Light
local specWarnFanOfFlames				= mod:NewSpecialWarningStack(137408, mod:IsTank(), 2)
local specWarnFanOfFlamesOther			= mod:NewSpecialWarningTarget(137408, mod:IsTank())
local specWarnFlamesofPassionMove		= mod:NewSpecialWarningMove(137417)
local specWarnIceComet					= mod:NewSpecialWarningSpell(137419, false)
local specWarnNuclearInferno			= mod:NewSpecialWarningCount(137491, nil, nil, nil, 2)--Heroic
--Dusk
local specWarnTidalForce				= mod:NewSpecialWarningCount(137531, nil, nil, nil, 2)--Maybe switch to a stop dps warning, or a switch to Suen?

local specWarnTT1						= mod:NewSpecialWarningSpell(138300)
local specWarnTT2						= mod:NewSpecialWarningSpell(138855)
local specWarnTT3						= mod:NewSpecialWarningSpell(138306)


--Darkness
local timerDayCD						= mod:NewTimer(183, "timerDayCD", 122789) -- timer is 183 or 190 (confirmed in 10 man. variable)
local timerCrashingStar					= mod:NewNextTimer(5.5, 137129)
local timerCosmicBarrageCD				= mod:NewNextCountTimer(22, 136752)--Very high variation. (22~38s) Changed to Crashing Star stuff.
local timerTearsOfTheSunCD				= mod:NewCDTimer(41, 137404)
local timerTearsOfTheSun				= mod:NewBuffActiveTimer(10, 137404)
local timerBeastOfNightmaresCD			= mod:NewCDTimer(51, 137375, nil, mod:IsTank() or mod:IsHealer())
--Light
local timerDuskCD						= mod:NewTimer(360, "timerDuskCD", "Interface\\Icons\\achievement_zone_easternplaguelands")--it seems always 360s after combat entered. (day timer is variables, so not reliable to day phase)
local timerLightOfDayCD					= mod:NewCDTimer(6, 137403, nil, false)--Trackable in day phase using UNIT event since boss1 can be used in this phase. Might be useful for heroic to not run behind in shadows too early preparing for a special
local timerFanOfFlamesCD				= mod:NewNextTimer(12, 137408, nil, mod:IsTank() or mod:IsHealer())
local timerFanOfFlames					= mod:NewTargetTimer(30, 137408, nil, mod:IsTank())
--local timerFlamesOfPassionCD			= mod:NewCDTimer(30, 137414)--Also very high variation. (31~65). Can be confuse, no use.
local timerIceCometCD					= mod:NewCDTimer(20.5, 137419)--Every 20.5-25 seconds on normal. On 10 heroic, variables 20.5~41s. 25 heroic vary 20.5-27.
local timerNuclearInferno				= mod:NewBuffActiveTimer(12, 137491)
local timerNuclearInfernoCD				= mod:NewNextCountTimer(49.5, 137491)
--Dusk
local timerTidalForce					= mod:NewBuffActiveTimer(18 ,137531)
local timerTidalForceCD					= mod:NewNextCountTimer(73, 137531)

local berserkTimer						= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame")--For various abilities that target even melee. UPDATE, cosmic barrage (worst of the 3 abilities) no longer target melee. However, light of day and tears of teh sun still do. melee want to split into 2-3 groups (depending on how many) but no longer have to stupidly spread about all crazy and out of range of boss during cosmic barrage to avoid dying. On that note, MAYBE change this to ranged default instead of all.
local phase2Started = false
local phase3Started = false
local invokeTiger = GetSpellInfo(138264)
local invokeCrane = GetSpellInfo(138189)
local invokeSerpent = GetSpellInfo(138267)
local invokeOx = GetSpellInfo(138254)

local function isRunner(unit)
	if UnitDebuff(unit, invokeTiger) or UnitDebuff(unit, invokeCrane) or UnitDebuff(unit, invokeSerpent) or UnitDebuff(unit, invokeOx) then
		return true
	end
	return false
end

local constellationRunner
do
	constellationRunner = function(uId)
		return isRunner(uId)
	end
end

local CrashingStarCount = 0
local NuclearInfernoCount = 0
local TidalForceCount = 0
local Sunlive = true

mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("InfoFrame", true, "sound")

mod:AddBoolOption("drAchoose", true, "sound")
for i = 1, 8 do
	mod:AddBoolOption("drA"..i, false, "sound")
end
mod:AddBoolOption("drBchoose", true, "sound")
for i = 1, 3 do
	mod:AddBoolOption("drC"..i, false, "sound")
end
mod:AddBoolOption("drCchoose", true, "sound")
for i = 1, 3 do
	mod:AddBoolOption("drB"..i, false, "sound")
end

for i = 1, 2 do
	mod:AddBoolOption("drD"..i, false, "sound")
end

for i = 1, 2 do
	mod:AddBoolOption("drE"..i, false, "sound")
end

local function MyJSA()  --P1隕星
	if (mod.Options.drA1 and CrashingStarCount == 1) or (mod.Options.drA2 and CrashingStarCount == 2) or (mod.Options.drA3 and CrashingStarCount == 3) or (mod.Options.drA4 and CrashingStarCount == 4) or (mod.Options.drA5 and CrashingStarCount == 5) or (mod.Options.drA6 and CrashingStarCount == 6) or (mod.Options.drA7 and CrashingStarCount == 7) or (mod.Options.drA8 and CrashingStarCount == 8) then
		return true
	end
	return false
end

local function MyJSB()  --P3隕星
	if (mod.Options.drB1 and CrashingStarCount == 1) or (mod.Options.drB2 and CrashingStarCount == 2) or (mod.Options.drB3 and CrashingStarCount == 3) then
		return true
	end
	return false
end

local function MyJSC()  --P2煉獄
	if (mod.Options.drC1 and NuclearInfernoCount == 1) or (mod.Options.drC2 and NuclearInfernoCount == 2) or (mod.Options.drC3 and NuclearInfernoCount == 3) then
		return true
	end
	return false
end

local function MyJSD()  --P3煉獄
	if (mod.Options.drD1 and NuclearInfernoCount == 1) or (mod.Options.drD2 and NuclearInfernoCount == 2) then
		return true
	end
	return false
end

local function MyJSE()  --P3潮汐
	if (mod.Options.drE1 and TidalForceCount == 1) or (mod.Options.drE2 and TidalForceCount == 2) then
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
local lightmaker = {}

mod:AddEditBoxOption("XNA", 50, "0", "sound")
mod:AddEditBoxOption("QLA", 50, "0", "sound")
mod:AddEditBoxOption("BHA", 50, "0", "sound")
mod:AddEditBoxOption("HHA", 50, "0", "sound")
mod:AddEditBoxOption("XNB", 50, "0", "sound")
mod:AddEditBoxOption("QLB", 50, "0", "sound")
mod:AddEditBoxOption("BHB", 50, "0", "sound")
mod:AddEditBoxOption("HHB", 50, "0", "sound")
local TTA={}
local sortedTTA={}
local combatstarttime = 0
local TTstart = 0

local function intTTtime()
	local XN1 = tonumber(mod.Options.XNA)
	local QL1 = tonumber(mod.Options.QLA)
	local BH1 = tonumber(mod.Options.BHA)
	local HH1 = tonumber(mod.Options.HHA)
	local XN2 = tonumber(mod.Options.XNB)
	local QL2 = tonumber(mod.Options.QLB)
	local BH2 = tonumber(mod.Options.BHB)
	local HH2 = tonumber(mod.Options.HHB)
	table.wipe(TTA)
	TTA = {
		[L.XN1] = XN1,
		[L.QL1] = QL1,
		[L.BH1] = BH1,
		[L.HH1] = HH1,
		[L.XN2] = XN2,
		[L.QL2] = QL2,
		[L.BH2] = BH2,
		[L.HH2] = HH2,
	}
	if XN1 > 20 then
		sndWOP:Schedule(XN1-20, "ex_tt_xnzb")
	end
	if QL1 > 20 then
		sndWOP:Schedule(QL1-20, "ex_tt_qlzb")
	end
	if BH1 > 20 then
		sndWOP:Schedule(BH1-20, "ex_tt_bhzb")
	end
	if HH1 > 20 then
		sndWOP:Schedule(HH1-20, "ex_tt_hhttzb")
	end
	if XN2 > 20 then
		sndWOP:Schedule(XN2-20, "ex_tt_xnzb")
	end
	if QL2 > 20 then
		sndWOP:Schedule(QL2-20, "ex_tt_qlzb")
	end
	if BH2 > 20 then
		sndWOP:Schedule(BH2-20, "ex_tt_bhzb")
	end
	if HH2 > 20 then
		sndWOP:Schedule(HH2-20, "ex_tt_hhttzb")
	end
	local function sortFuncAsc(a, b) return TTA[a] < TTA[b] end
	table.wipe(sortedTTA)
	for i in pairs(TTA) do
		sortedTTA[#sortedTTA + 1] = i
	end
	table.sort(sortedTTA, sortFuncAsc)
	combatstarttime = GetTime()
end

local function showTTtime(nextTT)
	if TTA[sortedTTA[nextTT]] and TTA[sortedTTA[nextTT]] > 0 then
		if mod.Options.InfoFrame then
			DBM.InfoFrame:Hide()
			DBM.InfoFrame:SetHeader(L.NextTT)
			DBM.InfoFrame:Show(1, "time", sortedTTA[nextTT], TTA[sortedTTA[nextTT]]- (GetTime()-combatstarttime))
		end
	end
end

function mod:OnCombatStart(delay)
	phase2Started = false
	phase3Started = false	
	CrashingStarCount = 0
	NuclearInfernoCount = 0
	TidalForceCount = 0
	TTstart = 0
	Sunlive = true
	table.wipe(lightmaker)
	berserkTimer:Start(-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8, not constellationRunner)
	end	
	intTTtime()	
	showTTtime(TTstart+1)
end

function mod:OnCombatEnd()
	phase3Started = false
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 137491 then
		self:SendSync("Inferno")
	elseif args.spellId == 137531 then
		self:SendSync("TidalForce")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 136752 then
		self:SendSync("CosmicBarrage")
	elseif args.spellId == 137404 then
		self:SendSync("TearsOfSun")
	elseif args.spellId == 137375 then
		warnBeastOfNightmares:Show(args.destName)
		specWarnBeastOfNightmares:Show()
		if args:IsPlayer() or mod:IsHealer() then
			sndWOP:Play("ex_tt_mys") --夢魘獸出現
		else
			if not UnitDebuff("player", GetSpellInfo(137375)) and not UnitIsDeadOrGhost("player") then
				if mod:IsTank() then
					sndWOP:Play("changemt") --換坦嘲諷
				end
			end
		end
		if timerDayCD:GetTime() < 135 then
			timerBeastOfNightmaresCD:Start()
		end
	elseif args.spellId == 137408 then
		local amount = args.amount or 1
		warnFanOfFlames:Show(args.destName, amount)
		timerFanOfFlames:Start(args.destName)
		timerFanOfFlamesCD:Start()
		if args:IsPlayer() then
			if amount >= 2 then
				specWarnFanOfFlames:Show(amount)
			end
		else
			if amount >= 2 and not UnitDebuff("player", GetSpellInfo(137408)) and not UnitIsDeadOrGhost("player") then
				specWarnFanOfFlamesOther:Show(args.destName)
				if mod:IsTank() then
					sndWOP:Play("changemt") --換坦嘲諷
				end
			end
		end
	elseif args.spellId == 137417 and args:IsPlayer() and self:AntiSpam(3, 4) then
		specWarnFlamesofPassionMove:Show()
		sndWOP:Play("runaway") --快躲開
	elseif args.spellId == 138264 and args:IsPlayer() then  --白虎
		if self.Options.HudMAP then
			self:Schedule(1, function()
				lightmaker["A1"] = register(DBMHudMap:AddEdge(0, 1, 0, 1, nil, nil, nil,705,352,731,381))
				lightmaker["A2"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,731,381,709,377))
				lightmaker["A3"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,709,377,686,373))
				lightmaker["A4"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,686,373,712,398))
				lightmaker["A5"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,712,398,709,376))
				lightmaker["A6"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,709,376,705,354))
			end)
		end
	elseif args.spellId == 138267 and args:IsPlayer() then  --青龍
		if self.Options.HudMAP then
			self:Schedule(1, function()
				lightmaker["B1"] = register(DBMHudMap:AddEdge(0, 1, 0, 1, nil, nil, nil,693,393,686,371))
				lightmaker["B2"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,686,371,710,377))
				lightmaker["B3"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,710,377,704,353))
				lightmaker["B4"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,704,353,725,361))
			end)
		end
	elseif args.spellId == 138254 and args:IsPlayer() then  --玄牛
		if self.Options.HudMAP then
			self:Schedule(1, function()
				lightmaker["C1"] = register(DBMHudMap:AddEdge(0, 1, 0, 1, nil, nil, nil,713,401,709,376))
				lightmaker["C2"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,709,376,705,352))
				lightmaker["C3"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,705,352,688,370))
				lightmaker["C4"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,688,370,709,376))
				lightmaker["C5"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,709,376,732,383))
			end)
		end
	elseif args.spellId == 138189 and args:IsPlayer() then  --红鹤
		if self.Options.HudMAP then
			self:Schedule(1, function()
				lightmaker["D1"] = register(DBMHudMap:AddEdge(0, 1, 0, 1, nil, nil, nil,733,382,705,353))
				lightmaker["D2"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,705,353,687,371))
				lightmaker["D3"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,687,371,709,377))
				lightmaker["D4"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,709,377,732,383))
				lightmaker["D5"] = register(DBMHudMap:AddEdge(1, 1, 1, 1, nil, nil, nil,732,383,713,401))
			end)
		end		
	elseif args.spellId == 138300 and self:AntiSpam(40, 10) then
		sndWOP:Play("ex_tt_xntt")--玄牛圖騰
		specWarnTT1:Show()
		TTstart = TTstart + 1
		showTTtime(TTstart+1)
	elseif args.spellId == 138855 and self:AntiSpam(40, 11) then
		sndWOP:Play("ex_tt_bhtt")--白虎圖騰
		specWarnTT2:Show()
		TTstart = TTstart + 1
		showTTtime(TTstart+1)
	elseif args.spellId == 138306 and self:AntiSpam(40, 12) then
		sndWOP:Play("ex_tt_yjtt")--玉蛟圖騰
		specWarnTT3:Show()
		TTstart = TTstart + 1
		showTTtime(TTstart+1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 138318 and self:AntiSpam(40, 13) then
		TTstart = TTstart + 1
		showTTtime(TTstart+1)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 137408 then
		timerFanOfFlames:Cancel(args.destName)
	elseif args.spellId == 138264 and args:IsPlayer() then
		if self.Options.HudMAP then
			DBMHudMap:FreeEncounterMarkers()
			table.wipe(lightmaker)
		end
	elseif args.spellId == 138267 and args:IsPlayer() then
		if self.Options.HudMAP then
			DBMHudMap:FreeEncounterMarkers()
			table.wipe(lightmaker)
		end
	elseif args.spellId == 138254 and args:IsPlayer() then
		if self.Options.HudMAP then
			DBMHudMap:FreeEncounterMarkers()
			table.wipe(lightmaker)
		end
	elseif args.spellId == 138189 and args:IsPlayer() then
		if self.Options.HudMAP then
			DBMHudMap:FreeEncounterMarkers()
			table.wipe(lightmaker)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 137414 then
		warnFlamesOfPassion:Show()
		--timerFlamesOfPassionCD:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 137419 then
		self:SendSync("Comet")
	end
end

--"<333.5 18:37:56> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#Lu'lin! Lend me your strength!#Suen#####0#0##0#247#nil#0#false#false", -- [71265]
--"<339.3 18:38:02> [INSTANCE_ENCOUNTER_ENGAGE_UNIT] Fake Args:#1#1#Suen#0xF1310D2800005863#worldboss#410952978#nil#1#Unknown#0xF1310D2900005864#worldboss#310232488
function mod:CHAT_MSG_MONSTER_YELL(msg) -- Switch to yell. INSTANCE_ENCOUNTER_ENGAGE_UNIT fires too late. also yell ranage covers all rooms. Not need sync.
	if msg == L.DuskPhase or msg:find(L.DuskPhase) then
		self:SendSync("Phase3Yell")
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT(event) -- still remains backup trigger for phase3.
	if UnitExists("boss2") and tonumber(UnitGUID("boss2"):sub(6, 10), 16) == 68905 then--Make sure we don't trigger it off another engage such as wipe engage event
		self:SendSync("Phase3")
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68905 then--Lu'lin
		timerCosmicBarrageCD:Cancel()
		timerTidalForceCD:Cancel()
		timerDayCD:Cancel()
		timerDuskCD:Cancel()
		timerNuclearInfernoCD:Cancel()
		warnDay:Show()
		sndWOPCX:Cancel("defensive")
		sndWOPCX:Cancel("ex_tt_cxzb")
		sndWOPCX:Cancel("countfour")
		sndWOPCX:Cancel("countthree")
		sndWOPCX:Cancel("counttwo")
		sndWOPCX:Cancel("countone")
		timerLightOfDayCD:Start()
		timerFanOfFlamesCD:Start(19)
		--She also does Flames of passion, but this is done 3 seconds after Lu'lin dies, is a 3 second timer worth it?
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		phase3Started = true
	elseif cid == 68904 then--Suen
		--timerFlamesOfPassionCD:Cancel()
		timerBeastOfNightmaresCD:Start(64)
		timerNuclearInfernoCD:Cancel()
		Sunlive = false
		warnNight:Show()
		phase3Started = true
		timerTidalForceCD:Cancel()
		sndWOPCX:Cancel("ex_tt_cxzb")
		sndWOPCX:Cancel("countfour")
		sndWOPCX:Cancel("countthree")
		sndWOPCX:Cancel("counttwo")
		sndWOPCX:Cancel("countone")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 137105 then--Suen Ports away (Night Phase)
		timerLightOfDayCD:Cancel()
		timerFanOfFlamesCD:Cancel()
		--timerFlamesOfPassionCD:Cancel()
		warnNight:Show()
		sndWOP:Schedule(180, "dayphase")--白天準備
		sndWOP:Schedule(181, "countthree")
		sndWOP:Schedule(182, "counttwo")
		sndWOP:Schedule(183, "countone")
		if Sunlive then
			timerDayCD:Start()
			timerDuskCD:Start()
			timerCosmicBarrageCD:Start(17, 1)
			timerTearsOfTheSunCD:Start(28.5)			
		end
		timerBeastOfNightmaresCD:Start()
	elseif spellId == 137187 then--Lu'lin Ports away (Day Phase)
		self:SendSync("Phase2")
	elseif spellId == 138823 then
		warnLightOfDay:Show()
		timerLightOfDayCD:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 137417 and destGUID == UnitGUID("player") and self:AntiSpam(2, 4) then
		specWarnFlamesofPassionMove:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:OnSync(msg)
	if msg == "Phase2" and not phase2Started then
		phase2Started = true
		timerCosmicBarrageCD:Cancel()
		timerTearsOfTheSunCD:Cancel()
		timerBeastOfNightmaresCD:Cancel()
		warnDay:Show()
		timerLightOfDayCD:Start()
		timerIceCometCD:Start()
		timerFanOfFlamesCD:Start()
		--timerFlamesOfPassionCD:Start(12.5)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerNuclearInfernoCD:Start(50, 1)
		end
		sndWOP:Cancel("dayphase")
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
		sndWOP:Play("ex_tt_bzjd")--白晝開始
		self:RegisterShortTermEvents(
			"INSTANCE_ENCOUNTER_ENGAGE_UNIT"
		)
	elseif msg == "Phase3Yell" and not phase3Started then -- Split from phase3 sync to prevent who running older version not to show bad timers.
		phase3Started = true
		CrashingStarCount = 0
		NuclearInfernoCount = 0
		warnDusk:Show()
		timerIceCometCD:Start(17)--This seems to reset, despite what last CD was (this can be a bad thing if it was do any second)
		timerTidalForceCD:Start(30, 1)		
		if self:IsDifficulty("heroic10", "heroic25") then
			timerNuclearInfernoCD:Cancel()
			timerNuclearInfernoCD:Start(63, 1)
		end
		timerCosmicBarrageCD:Start(54, 1)
		sndWOP:Play("ex_tt_hhzb")--黃昏準備
		sndWOP:Schedule(1, "countfive")
		sndWOP:Schedule(2, "countfour")
		sndWOP:Schedule(3, "countthree")
		sndWOP:Schedule(4, "counttwo")
		sndWOP:Schedule(5, "countone")
		sndWOP:Schedule(6, "ex_tt_hhjd") --黃昏開始
		sndWOPCX:Schedule(25, "ex_tt_cxzb")
		sndWOPCX:Schedule(26, "countfour")
		sndWOPCX:Schedule(27, "countthree")
		sndWOPCX:Schedule(28, "counttwo")
		sndWOPCX:Schedule(29, "countone")
	elseif msg == "Phase3" then
		self:UnregisterShortTermEvents()
		timerFanOfFlamesCD:Cancel()--DO NOT CANCEL THIS ON YELL
	--[[if not phase3Started then
			warnDusk:Show()
			phase3Started = true
			timerIceCometCD:Start(11)--This seems to reset, despite what last CD was (this can be a bad thing if it was do any second)
			timerTidalForceCD:Start(20)
			if self:IsDifficulty("heroic10", "heroic25") then
				timerNuclearInfernoCD:Start(57)
			end
			timerCosmicBarrageCD:Start(48, 1)
		end]]
	elseif msg == "Comet" then
		if self:AntiSpam(10, 5) then
			warnIceComet:Show()
			specWarnIceComet:Show()
			sndWOP:Play("ex_tt_hbcx") --寒冰出現
			if phase3Started then -- cd longer on phase 3.
				timerIceCometCD:Start(30.5)
			else
				timerIceCometCD:Start()
			end
		end
	elseif msg == "TidalForce" then
		if self:AntiSpam(10, 6) then
			TidalForceCount = TidalForceCount + 1
			warnTidalForce:Show(TidalForceCount)
			specWarnTidalForce:Show(TidalForceCount)
			timerTidalForce:Start()
			timerTidalForceCD:Start(74, TidalForceCount + 1)
			sndWOPCX:Cancel("ex_tt_cxzb")
			sndWOPCX:Cancel("countfour")
			sndWOPCX:Cancel("countthree")
			sndWOPCX:Cancel("counttwo")
			sndWOPCX:Cancel("countone")
			if MyJSE() then
				sndWOP:Play("defensive")
			else
				sndWOP:Play("ex_tt_cxzl") --潮汐之力
			end
			sndWOPCX:Schedule(68, "ex_tt_cxzb")
			sndWOPCX:Schedule(69, "countfour")
			sndWOPCX:Schedule(70, "countthree")
			sndWOPCX:Schedule(71, "counttwo")
			sndWOPCX:Schedule(72, "countone")

		end
	elseif msg == "CosmicBarrage" then
		if self:AntiSpam(10, 7) then
			CrashingStarCount = CrashingStarCount + 1
			warnCrashingStarSoon:Show(CrashingStarCount)
			specWarnCrashingStarSoon:Show(CrashingStarCount)
			timerCrashingStar:Start()
			if phase3Started then
				timerCosmicBarrageCD:Start(35, CrashingStarCount + 1)
				if MyJSB() then
					sndWOP:Play("defensive") --注意減傷
				else
					if mod:IsRanged() then
						sndWOP:Play("scattersoon")--注意分散
					else
						sndWOP:Play("ex_tt_xzzb")--星宙准备
					end
				end
				sndYX:Schedule(1.5, "countfour")
				sndYX:Schedule(2.5, "countthree")
				sndYX:Schedule(3.5, "counttwo")
				sndYX:Schedule(4.5, "countone")
			else
				timerCosmicBarrageCD:Start(22, CrashingStarCount + 1)
				if MyJSA() then
					sndWOP:Play("defensive")
					sndYX:Schedule(1.5, "countfour")
					sndYX:Schedule(2.5, "countthree")
					sndYX:Schedule(3.5, "counttwo")
					sndYX:Schedule(4.5, "countone")
				elseif mod:IsRanged() then
					sndWOP:Play("scattersoon")
					sndYX:Schedule(1.5, "countfour")
					sndYX:Schedule(2.5, "countthree")
					sndYX:Schedule(3.5, "counttwo")
					sndYX:Schedule(4.5, "countone")
				end
			end
		end
	elseif msg == "Inferno" then
		if self:AntiSpam(10, 8) then
			NuclearInfernoCount = NuclearInfernoCount + 1
			warnNuclearInferno:Show(NuclearInfernoCount)
			specWarnNuclearInferno:Show(NuclearInfernoCount)
			timerNuclearInferno:Start()
			sndWOP:Play("ex_tt_hzly") --核子煉獄
			if phase3Started then
				timerNuclearInfernoCD:Start(73, NuclearInfernoCount + 1)
				if MyJSD() then
					sndWOP:Schedule(2, "defensive")
				end
			else
				timerNuclearInfernoCD:Start(49.5, NuclearInfernoCount + 1)
				if MyJSC() then
					sndWOP:Schedule(2, "defensive")
				end
			end
			sndWOP:Schedule(11, "scatter")
		end
	elseif msg == "TearsOfSun" then
		if self:AntiSpam(10, 9) then
			warnTearsOfSun:Show()
			specWarnTearsOfSun:Show()
			sndWOP:Play("ex_tt_lrzl")
			timerTearsOfTheSun:Start()
			if timerDayCD:GetTime() < 145 then
				timerTearsOfTheSunCD:Start()
			end
		end
	end
end