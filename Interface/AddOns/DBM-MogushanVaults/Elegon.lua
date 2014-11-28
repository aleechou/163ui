local mod	= DBM:NewMod(726, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndCC	= mod:SoundMM("SoundCC")
local sndDD = mod:NewSound(nil, false, "SoundDD")

mod:SetRevision(("$Revision: 10185 $"):sub(12, -3))
mod:SetCreatureID(60410)--Energy Charge (60913), Emphyreal Focus (60776), Cosmic Spark (62618), Celestial Protector (60793)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED",
	"RAID_BOSS_EMOTE",
	"UNIT_HEALTH",
	"SPELL_CAST_START"
)

local warnPhase1					= mod:NewPhaseAnnounce(1, 2)--117727 Charge Vortex
local warnBreath					= mod:NewSpellAnnounce(117960, 3)
local warnProtector					= mod:NewCountAnnounce(117954, 3)
local warnArcingEnergy				= mod:NewSpellAnnounce(117945, 2)--Cast randomly at 2 players, it is avoidable.
local warnClosedCircuit				= mod:NewTargetAnnounce(117949, 3, nil, mod:IsHealer())--what happens if you fail to avoid the above
local warnTotalAnnihilation			= mod:NewCastAnnounce(129711, 4)--Protector dying(exploding)
local warnStunned					= mod:NewTargetAnnounce(132222, 3, nil, mod:IsHealer())--Heroic / 132222 is stun debuff, 132226 is 2 min debuff. 
local warnPhase2					= mod:NewPhaseAnnounce(2, 3)--124967 Draw Power
local warnDrawPower					= mod:NewCountAnnounce(119387, 4)
local warnPhase3					= mod:NewPhaseAnnounce(3, 3)--116994 Unstable Energy Starting
local warnRadiatingEnergies			= mod:NewSpellAnnounce(118310, 4)

local warnCoresLeft				= mod:NewAddsLeftAnnounce("ej6193", 2, 117878)

local specWarnOvercharged			= mod:NewSpecialWarningStack(117878, nil, 6)
local specWarnTotalAnnihilation		= mod:NewSpecialWarningSpell(129711, nil, nil, nil, 2)
local specWarnProtector				= mod:NewSpecialWarning("specWarnProtector")
local specWarnCharge				= mod:NewSpecialWarning("specWarnCharge")
local specWarnCore					= mod:NewSpecialWarningSwitch("ej6193")
local specWarnClosedCircuit			= mod:NewSpecialWarningDispel(117949, false)--Probably a spammy mess if this hits a few at once. But here in case someone likes spam.
local specWarnDrawPower				= mod:NewSpecialWarningStack(119387, nil, 1)
local specWarnDespawnFloor			= mod:NewSpecialWarning("specWarnDespawnFloor", nil, nil, nil, 3)
local specWarnRadiatingEnergies		= mod:NewSpecialWarningSpell(118310, nil, nil, nil, 2)

local specwarnYB			= mod:NewSpecialWarning("specwarnYB")


local timerBreathCD					= mod:NewCDTimer(18, 117960)
local timerProtectorCD				= mod:NewCDTimer(41, 117954)
local timerArcingEnergyCD			= mod:NewCDTimer(11.5, 117945)
local timerTotalAnnihilation		= mod:NewCastTimer(4, 129711)
local timerDestabilized				= mod:NewBuffFadesTimer(120, 132226)
local timerFocusPower				= mod:NewCastTimer(16, 119358)
local timerDespawnFloor				= mod:NewTimer(6.5, "timerDespawnFloor", 116994)--6.5-7.5 variation. 6.5 is safed to use so you don't fall and die.

local berserkTimer					= mod:NewBerserkTimer(570)

mod:AddBoolOption("SetIconOnDestabilized", true)

local phase2Started = false
local protectorCount = 0
local powerCount = 0
local closedCircuitTargets = {}
local stunTargets = {}
local stunIcon = 8
local focusActivated = 0
local LowHP = {}
local sentAEHP = {}
local warnedAEHP = {}
local warned = 0
local coresCount = 0

local ptwo = false
local warnfailed = false
local YBTargets = {}

local Protector = EJ_GetSectionInfo(6178)
mod:AddBoolOption("optDBPull", false, "sound")
mod:AddDropdownOption("optOC", {"six", "nine", "twelve", "fifteen", "none"}, "six", "sound")
mod:AddDropdownOption("optPos", {"nonepos", "posA", "posB", "posC", "posD", "posE", "posF"}, "nonepos", "sound")

mod:AddDropdownOption("optYB", {"noYB", "YB1", "YB2", "YB3", "YB4", "YB5"}, "noYB", "sound")
mod:AddDropdownOption("optYBT", {"noYBT", "YBT1", "YBT2", "YBT3", "YBT4", "YBT5"}, "noYBT", "sound")

local pthree = false
local OCn = 0
local POSn = ""

local chargePos = {
  ["A"] = 	{ 25, 45 },
  ["B"] = 	{ 21, 42 },
  ["C"] = 	{ 17, 45 },
  ["D"] = 	{ 17, 57 },
  ["E"] = 	{ 21, 60 },
  ["F"] = 	{ 25, 58 },
}

local function warnClosedCircuitTargets()
	warnClosedCircuit:Show(table.concat(closedCircuitTargets, "<, >"))
	table.wipe(closedCircuitTargets)
end

local function warnStunnedTargets()
	warnStunned:Show(table.concat(stunTargets, "<, >"))
	table.wipe(stunTargets)
end

local function warnYBfendan()
	print("本輪分擔: <"..table.concat(YBTargets, ">, <")..">")
	table.wipe(YBTargets)
end

function mod:OnCombatStart(delay)
	protectorCount = 0
	coresCount = 0
	stunIcon = 8
	focusActivated = 0
	powerCount = 0
	table.wipe(closedCircuitTargets)
	table.wipe(stunTargets)
	table.wipe(YBTargets)
	timerBreathCD:Start(8-delay)
	table.wipe(LowHP)
	table.wipe(sentAEHP)
	table.wipe(warnedAEHP)
	warned = 0
	pthree = false
	ptwo = false
	warnfailed = false
	if not mod:IsDps() then
		sndWOP:Schedule(6, "ex_mop_zbhx") --準備火息
	end
	timerProtectorCD:Start(10-delay)
	berserkTimer:Start(-delay)
end

function checkTankPull()
	if (not (mod:IsTank() and UnitName("target") == Protector)) or mod.Options.optDBPull then
		sndWOP:Play("ex_mop_zbhx")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(124967) and not phase2Started then--Phase 2 begin/Phase 1 end
		phase2Started = true--because if you aren't fucking up, you should get more then one draw power.
		ptwo = true
		protectorCount = 0
		powerCount = 0
		warnPhase2:Show()
		sndWOP:Play("ptwo") --P2
		POSn = self.Options.optPos == "posA" and "A" or self.Options.optPos == "posB" and "B" or self.Options.optPos == "posC" and "C" or self.Options.optPos == "posD" and "D" or self.Options.optPos == "posE" and "E" or self.Options.optPos == "posF" and "F" or self.Options.optPos == "nonepos" and "NONE"
		if POSn ~= "NONE" then
			DBM.Arrow:ShowRunTo(chargePos[POSn][1]/100,chargePos[POSn][2]/100)
		end
		timerBreathCD:Cancel()
		timerFocusPower:Start()
		if not mod:IsHealer() then
			sndWOP:Schedule(12, "countthree")
			sndWOP:Schedule(13, "counttwo")
			sndWOP:Schedule(14, "countone")
		end
		if not mod:IsDps() then
			sndWOP:Cancel("ex_mop_zbhx")
			self:Unschedule(checkTankPull)
		end
		timerProtectorCD:Cancel()	
	elseif args:IsSpellID(116994) then--Phase 3 begin/Phase 2 end
		focusActivated = 0
		phase2Started = false
		protectorCount = 0
--		warnPhase3:Show()
--		sndWOP:Play("pthree") --P3
	elseif args:IsSpellID(117878) and args:IsPlayer() then
		OCn = self.Options.optOC == "six" and 6 or self.Options.optOC == "nine" and 9 or self.Options.optOC == "twelve" and 12 or self.Options.optOC == "fifteen" and 15 or self.Options.optOC == "none" and 99
		if (args.amount or 1) >= OCn and args.amount % 3 == 0 and self:IsInCombat() then--Warn every 3 stacks at 6 and above.
			specWarnOvercharged:Show(args.amount)
			if not pthree then
				sndWOP:Play("ex_mop_czgg") --超載過高
			end
		end
	elseif args:IsSpellID(119387) then -- do not add other spellids.
		powerCount = powerCount + 1
		warnDrawPower:Show(powerCount)
		specWarnDrawPower:Show(powerCount)
	elseif args:IsSpellID(118310) then--Below 50% health
		warnRadiatingEnergies:Show()
		specWarnRadiatingEnergies:Show()--Give a good warning so people standing outside barrior don't die.
	elseif args:IsSpellID(132226) then
		if args:IsPlayer() then
			timerDestabilized:Start()
		end
	elseif args:IsSpellID(132222) then
		stunTargets[#stunTargets + 1] = args.destName
		if self.Options.SetIconOnDestabilized then
			self:SetIcon(args.destName, stunIcon)
			stunIcon = stunIcon - 1
		end
		self:Unschedule(warnStunnedTargets)
		self:Schedule(0.3, warnStunnedTargets)
	elseif args:IsSpellID(132265, 116598) and self:AntiSpam(30, 2) then
		warnPhase3:Show()
		SendChatMessage("才打了"..(coresCount-1).."波...太水了吧" ,"SAY")
		sndWOP:Play("pthree") --P3
		coresCount = 0
		if not mod:IsHealer() then
			sndWOP:Cancel("countthree")
			sndWOP:Cancel("counttwo")
			sndWOP:Cancel("countone")
		end
		DBM.Arrow:Hide()
		specWarnCore:Show()
		-- DBM.Flash:Shake(1, 0, 0)
--		timerDespawnFloor:Start()--Should be pretty accurate, may need minor tweak
	elseif args:IsSpellID(119360) then
		if not mod:IsHealer() then
			sndWOP:Schedule(0.2, "countthree")
			sndWOP:Schedule(1.2, "counttwo")
			sndWOP:Schedule(2.2, "countone")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(116994) then--phase 3 end
		warnPhase1:Show()
		sndWOP:Play("phasechange")
		warned = warned + 1
		if warned == 2 then
			pthree = true
			self:Schedule(2, function()
				if not UnitDebuff("player", GetSpellInfo(117870)) then
					sndWOP:Play("ex_mop_kjzc") --快進中場
					SendChatMessage("进中场" ,"SAY")
				end
			end)
		end
	elseif args:IsSpellID(132226) then
		if args:IsPlayer() then
			timerDestabilized:Cancel()
		end
	elseif args:IsSpellID(117878) and args:IsPlayer() and self:IsInCombat() then
		sndDD:Play("didi") --~
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(116598, 132265) then--Cast when these are activated
		focusActivated = focusActivated + 1
		if not DBM.BossHealth:HasBoss(args.sourceGUID) then
			DBM.BossHealth:AddBoss(args.sourceGUID, args.sourceName)
		end
		if focusActivated == 6 then
--			timerDespawnFloor:Start()
		end
	elseif args:IsSpellID(116989) then--Cast when defeated (or rathor 1 HP)
		DBM.BossHealth:RemoveBoss(args.sourceGUID)
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(117960) then
		warnBreath:Show()
		timerBreathCD:Start()
		if not mod:IsDps() then
			if warned ~=2 then
				self:Schedule(16, checkTankPull)
			else
				sndWOP:Schedule(10, "ex_mop_zbhx")
			end
		end
	elseif args:IsSpellID(117954) then
		if self:LatencyCheck() then
			self:SendSync("Summonprotector")
		end
	elseif args:IsSpellID(117945) then
		warnArcingEnergy:Show()
		timerArcingEnergyCD:Start(args.sourceGUID)
	elseif args:IsSpellID(129711) then
		warnTotalAnnihilation:Show()
		specWarnTotalAnnihilation:Show()
		timerTotalAnnihilation:Start()
		sndWOP:Play("ex_mop_zbbz") --準備爆炸
		if mod:IsHealer() then
			sndWOP:Schedule(1.5, "countthree")
			sndWOP:Schedule(2.5, "counttwo")
			sndWOP:Schedule(3.5, "countone")
		end
		timerArcingEnergyCD:Cancel(args.sourceGUID)--add is dying, so this add is done casting arcing Energy
	elseif args:IsSpellID(117949) then
		closedCircuitTargets[#closedCircuitTargets + 1] = args.destName
		specWarnClosedCircuit:Show(args.destName)
		self:Unschedule(warnClosedCircuitTargets)
		self:Schedule(0.3, warnClosedCircuitTargets)
		if self:AntiSpam(3, 1) then
			sndCC:Play("ex_mop_qssd")--驅散閃電
		end
	elseif args:IsSpellID(119358) then
		local _, _, _, _, startTime, endTime = UnitCastingInfo("boss1")
		local castTime
		if startTime and endTime then
			castTime = ((endTime or 0) - (startTime or 0)) / 1000
			timerFocusPower:Start(castTime)
		end
		sndWOP:Play("ex_mop_dqkd") --電球快打
		coresCount = coresCount + 1
		specWarnCharge:Show(coresCount)
		if coresCount == 1 then
			sndWOP:Schedule(1, "countone")
		elseif coresCount == 2 then
			sndWOP:Schedule(1, "counttwo")
		elseif coresCount == 3 then
			sndWOP:Schedule(1, "countthree")
		elseif coresCount == 4 then
			sndWOP:Schedule(1, "countfour")
		elseif coresCount == 5 then
			sndWOP:Schedule(1, "countfive")
		elseif coresCount == 6 then
			sndWOP:Schedule(1, "countsix")
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Floor or msg:find(L.Floor) then
		SendChatMessage("速度离开中场 摔死不分金","YELL")
		if UnitDebuff("player", GetSpellInfo(117870)) then
			sndWOP:Schedule(1, "leavecenter") --離開中場
		else
			sndWOP:Schedule(1, "ex_mop_zcxs") --中場即將消失
		end
		specWarnDespawnFloor:Show()
		timerDespawnFloor:Start()--Should be pretty accurate, may need minor tweak
	end
end

function mod:UNIT_HEALTH(uId)
	local cid = self:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	if cid == 60793 then
		if UnitHealth(uId) / UnitHealthMax(uId) <= 0.4 and not LowHP[guid] then
			if mod:IsTank() and UnitName("target") == Protector then
				sndWOP:Play("checkhp") --注意血量
				LowHP[guid] = true
			end
		end
		if UnitHealth(uId) / UnitHealthMax(uId) <= 0.4 and not sentAEHP[guid] then
			sentAEHP[guid] = true
			self:SendSync("aehealth", guid)
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "aehealth" and guid and not warnedAEHP[guid] then
		warnedAEHP[guid] = true
		if mod:IsHealer() then
			sndWOP:Play("aesoon") --準備AE
		end
	elseif msg == "YBnow" and guid then
		YBTargets[#YBTargets + 1] = guid
		self:Unschedule(warnYBfendan)
		self:Schedule(2, warnYBfendan)
	elseif msg == "Summonprotector" and self:AntiSpam(10, 4) then
		protectorCount = protectorCount + 1
		warnProtector:Show(protectorCount)
		specWarnProtector:Show(protectorCount)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerProtectorCD:Start(26)--26-28 variation on heroic
		else
			timerProtectorCD:Start()--35-37 on normal
		end
		warnedPH = false
		if mod:IsDps() then
			sndWOP:Play("ex_mop_bwzkd") --保衛者快打
		else
			sndWOP:Play("ex_mop_bwzcx") --保衛者出現
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			if (((self.Options.optYB == "YB1" and protectorCount == 1) or (self.Options.optYB == "YB2" and protectorCount == 2) or (self.Options.optYB == "YB3" and protectorCount == 3) or (self.Options.optYB == "YB4" and protectorCount == 4) or (self.Options.optYB == "YB5" and protectorCount == 5)) and not ptwo) or (((self.Options.optYBT == "YBT1" and protectorCount == 1) or (self.Options.optYBT == "YBT2" and protectorCount == 2) or (self.Options.optYBT == "YBT3" and protectorCount == 3) or (self.Options.optYBT == "YBT4" and protectorCount == 4) or (self.Options.optYBT == "YBT5" and protectorCount == 5)) and ptwo) then
				sndWOP:Schedule(4, "ex_mop_ybfd") --分擔異變
				specwarnYB:Schedule(4)
				self:SendSync("YBnow", UnitName("player"))
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 127362 and not warnfailed and self:AntiSpam(5, 3) then
		warnfailed = true
		sndWOP:Play("failed") --~
	end
end