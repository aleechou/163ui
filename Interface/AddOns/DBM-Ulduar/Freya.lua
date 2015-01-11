local mod	= DBM:NewMod("Freya", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))

mod:SetCreatureID(32906)
mod:SetEncounterID(1133)
mod:SetModelID(28777)
mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellKill)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL"
)

-- Trash: 33430 Guardian Lasher (flower)
-- 33355 (nymph)
-- 33354 (tree)

--
-- Elder Stonebark (ground tremor / fist of stone)
-- Elder Brightleaf (unstable sunbeam)

local warnPhase2			= mod:NewPhaseAnnounce(2, 3)
local warnSimulKill			= mod:NewAnnounce("WarnSimulKill", 1)
local warnFury				= mod:NewTargetAnnounce(63571, 2)
local warnRoots				= mod:NewTargetAnnounce(62438, 2)
local warnLifebinder		= mod:NewTargetAnnounce(62869, 3)--Actual spell is hidden from CLEU so we use a diff trigger.

local specWarnLifebinder	= mod:NewSpecialWarningSpell(62869, false)
local specWarnFury			= mod:NewSpecialWarningMoveAway(63571)
local specWarnTremor		= mod:NewSpecialWarningCast(62859)	-- Hard mode
local specWarnBeam			= mod:NewSpecialWarningMove(62865)	-- Hard mode

local enrage 				= mod:NewBerserkTimer(600)
local timerAlliesOfNature	= mod:NewCDTimer(25, 62678)--I seen 25-35 Variation
local timerSimulKill		= mod:NewTimer(12, "TimerSimulKill")
local timerFury				= mod:NewTargetTimer(10, 63571)
local timerTremorCD 		= mod:NewCDTimer(28, 62859)
local timerLifebinderCD 	= mod:NewCDTimer(40, 62869)

mod:AddBoolOption("HealthFrame", true)
mod:AddSetIconOption("SetIconOnFury", 63571, false)
mod:AddSetIconOption("SetIconOnRoots", 62438, false)

local adds		= {}
local rootedPlayers 	= {}
local altIcon 		= true
local iconId		= 6

function mod:OnCombatStart(delay)
	enrage:Start()
	table.wipe(adds)
end

local function showRootWarning()
	warnRoots:Show(table.concat(rootedPlayers, "< >"))
	table.wipe(rootedPlayers)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(62437, 62859) then
		specWarnTremor:Show()
		timerTremorCD:Start()
	end
end 

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62678 then -- Summon Allies of Nature
		timerAlliesOfNature:Start()
	elseif args.spellId == 62619 and self:GetUnitCreatureId(args.sourceName) == 33228 then -- Pheromones spell, cast by newly spawned Eonar's Gift second they spawn to allow melee to dps them while protector is up.
		warnLifebinder:Show()
		specWarnLifebinder:Show()
		timerLifebinderCD:Start()
	elseif args:IsSpellID(63571, 62589) then -- Nature's Fury
		if self.Options.SetIconOnFury then
			altIcon = not altIcon	--Alternates between Skull and X
			self:SetIcon(args.destName, altIcon and 7 or 8, 10)
		end
		warnFury:Show(args.destName)
		if args:IsPlayer() then -- only cast on players; no need to check destFlags
			specWarnFury:Show()
		end
		timerFury:Start(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(62861, 62438) then
		if self.Options.SetIconOnRoots then
			iconId = iconId - 1
			self:SetIcon(args.destName, iconId, 15)
		end
		table.insert(rootedPlayers, args.destName)
		self:Unschedule(showRootWarning)
		if #rootedPlayers >= 3 then
			showRootWarning()
		else
			self:Schedule(0.5, showRootWarning)
		end

	elseif args:IsSpellID(62451, 62865) and args:IsPlayer() then
		specWarnBeam:Show()
	end 
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 62519 then
		warnPhase2:Show()
	elseif args:IsSpellID(62861, 62438) and self.Options.SetIconOnRoots then
		self:RemoveIcon(args.destName)
		iconId = iconId + 1
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SpawnYell then
		if DBM.BossHealth:IsShown() then
			if not adds[33202] then DBM.BossHealth:AddBoss(33202, L.WaterSpirit) end -- ancient water spirit
			if not adds[32916] then DBM.BossHealth:AddBoss(32916, L.Snaplasher) end  -- snaplasher
			if not adds[32919] then DBM.BossHealth:AddBoss(32919, L.StormLasher) end -- storm lasher
		end
		adds[33202] = true
		adds[32916] = true
		adds[32919] = true
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 33202 or cid == 32916 or cid == 32919 then
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:RemoveBoss(cid)
		end
		if self:AntiSpam(20) then
			timerSimulKill:Start()
			warnSimulKill:Show()
		end
		adds[cid] = nil
		local counter = 0
		for i, v in pairs(adds) do
			counter = counter + 1
		end
		if counter == 0 then
			timerSimulKill:Stop()
		end
	end

end