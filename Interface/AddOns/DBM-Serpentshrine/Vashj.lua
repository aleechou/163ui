local mod	= DBM:NewMod("Vashj", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 548 $"):sub(12, -3))
mod:SetCreatureID(21212)
mod:SetModelID(20748)
mod:SetZone()
mod:SetUsedIcons(1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED",
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_LOOT"
)

local warnCharge		= mod:NewTargetAnnounce(38280, 4)
local warnEntangle		= mod:NewSpellAnnounce(38316, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnElemental		= mod:NewAnnounce("WarnElemental", 4, 31687)
local warnStrider		= mod:NewAnnounce("WarnStrider", 3, 475)
local warnNaga			= mod:NewAnnounce("WarnNaga", 3, 2120)
local warnShield		= mod:NewAnnounce("WarnShield", 3)
local warnLoot			= mod:NewAnnounce("WarnLoot", 4, 38132)
local warnPhase3		= mod:NewPhaseAnnounce(3)

local specWarnCharge	= mod:NewSpecialWarningYou(38280)
local specWarnElemental	= mod:NewSpecialWarning("SpecWarnElemental")--Changed from soon to a now warning. the soon warning not accurate because of 11 second variation so not useful special warning.
local specWarnToxic		= mod:NewSpecialWarningMove(38575)

local timerCharge		= mod:NewTargetTimer(20, 38280)
local timerElemental	= mod:NewTimer(22, "TimerElementalActive", 39088)--Blizz says they are active 20 seconds per patch notes, but my logs don't match those results. 22 second up time.
local timerElementalCD	= mod:NewTimer(45, "TimerElemental", 39088)--46-57 variation. because of high variation the pre warning special warning not useful, fortunately we can detect spawns with precise timing.
local timerStrider		= mod:NewTimer(63, "TimerStrider", 475)
local timerNaga			= mod:NewTimer(47.5, "TimerNaga", 2120)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("ChargeIcon", false)
mod:AddBoolOption("AutoChangeLootToFFA", true)

local shieldLeft = 4
local nagaCount = 1
local striderCount = 1
local elementalCount = 1
local lootmethod, masterlooterRaidID
local elementals = {}

function mod:StriderSpawn()
	striderCount = striderCount + 1
	timerStrider:Start(nil, tostring(striderCount))
	warnStrider:Schedule(57, tostring(striderCount))
	self:ScheduleMethod(63, "StriderSpawn")
end

function mod:NagaSpawn()
	nagaCount = nagaCount + 1
	timerNaga:Start(nil, tostring(nagaCount))
	warnNaga:Schedule(42.5, tostring(nagaCount))
	self:ScheduleMethod(47.5, "NagaSpawn")
end

function mod:OnCombatStart(delay)
	table.wipe(elementals)
	shieldLeft = 4
	nagaCount = 1
	striderCount = 1
	elementalCount = 1
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show()
	end
	if IsInGroup() and DBM:GetRaidRank() == 2 then
		lootmethod, _, masterlooterRaidID = GetLootMethod()
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
		if masterlooterRaidID then
			SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
		else
			SetLootMethod(lootmethod)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38280 then
		warnCharge:Show(args.destName)
		timerCharge:Start(args.destName)
		if args:IsPlayer() then
			specWarnCharge:Show()
		end
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 1, 20)
		end
	elseif args.spellId == 38575 and args:IsPlayer() and self:AntiSpam() then
		specWarnToxic:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 38280 then
		timerCharge:Cancel(args.destName)
		if self.Options.ChargeIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 38132 then
		if self.Options.LootIcon then
			self:SetIcon(args.destName, 0)
		end
	--[[elseif args.spellId == 38112 then
		shieldLeft = shieldLeft - 1
		warnShield:Show(shieldLeft)]]
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38253 and not elementals[args.sourceGUID] then
		specWarnElemental:Show()
		timerElemental:Start()
		elementals[args.sourceGUID] = true
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 38316 then
		warnEntangle:Show()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 22009 then
		elementalCount = elementalCount + 1
		timerElementalCD:Start(nil, tostring(elementalCount))
		warnElemental:Schedule(45, tostring(elementalCount))
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_VASHJ_YELL_PHASE2 or msg:find(L.DBM_VASHJ_YELL_PHASE2) then
		nagaCount = 1
		striderCount = 1
		elementalCount = 1
		shieldLeft = 4
		warnPhase2:Show()
		timerNaga:Start(nil, tostring(nagaCount))
		warnNaga:Schedule(42.5, tostring(elementalCount))
		self:ScheduleMethod(47.5, "NagaSpawn")
		timerElementalCD:Start(nil, tostring(elementalCount))
		warnElemental:Schedule(45, tostring(elementalCount))
		timerStrider:Start(nil, tostring(striderCount))
		warnStrider:Schedule(57, tostring(striderCount))
		self:ScheduleMethod(63, "StriderSpawn")
		if IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
			SetLootMethod("freeforall")
		end
	elseif msg == L.DBM_VASHJ_YELL_PHASE3 or msg:find(L.DBM_VASHJ_YELL_PHASE3) then
		warnPhase3:Show()
		timerNaga:Cancel()
		warnNaga:Cancel()
		timerElementalCD:Cancel()
		warnElemental:Cancel()
		timerStrider:Cancel()
		warnStrider:Cancel()
		self:UnscheduleMethod("NagaSpawn")
		self:UnscheduleMethod("StriderSpawn")
		if IsInGroup() and self.Options.AutoChangeLootToFFA and DBM:GetRaidRank() == 2 then
			if masterlooterRaidID then
				SetLootMethod(lootmethod, "raid"..masterlooterRaidID)
			else
				SetLootMethod(lootmethod)
			end
		end
	end
end

function mod:CHAT_MSG_LOOT(msg)
	-- DBM:AddMsg(msg) --> Meridium receives loot: [Magnetic Core]
	local player, itemID = msg:match(L.LootMsg)
	player = DBM:GetUnitFullName(player)
	if player and itemID and tonumber(itemID) == 31088 and self:IsInCombat() then
		self:SendSync("LootMsg", player)
	end
end

function mod:OnSync(event, args)
	if event == "LootMsg" and args then
		warnLoot:Show(args)
	end
end
