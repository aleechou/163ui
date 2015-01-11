local mod	= DBM:NewMod("Huhuran", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 500 $"):sub(12, -3))
mod:SetCreatureID(15509)
mod:SetModelID(15739)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH target focus mouseover"
)

local warnSting			= mod:NewTargetAnnounce(26180, 2)
local warnAcid			= mod:NewStackAnnounce(26050, 3)
local warnPoison		= mod:NewSpellAnnounce(26053, 3)
local warnEnrage		= mod:NewSpellAnnounce(26051, 2)
local warnBerserkSoon	= mod:NewSoonAnnounce(26068, 2)
local warnBerserk		= mod:NewSpellAnnounce(26068, 2)

local timerSting		= mod:NewBuffFadesTimer(12, 26180)
local timerStingCD		= mod:NewCDTimer(20, 26180)
local timerPoison		= mod:NewBuffFadesTimer(8, 26053)
local timerEnrageCD		= mod:NewNextTimer(18, 26052)
local timerEnrage		= mod:NewBuffActiveTimer(8, 26052)
local timerAcid			= mod:NewTargetTimer(30, 26050)

local specWarnAcid		= mod:NewSpecialWarningStack(26050, nil, 10)

local prewarn_berserk
local StingTargets = {}

function mod:OnCombatStart(delay)
	prewarn_berserk = false
	table.wipe(StingTargets)
end

local function warnStingTargets()
	warnSting:Show(table.concat(StingTargets, "<, >"))
	timerStingCD:Start()
	table.wipe(StingTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 26180 then
		StingTargets[#StingTargets + 1] = args.destName
		self:Unschedule(warnStingTargets)
		self:Schedule(0.3, warnStingTargets)
		if args:IsPlayer() then
			timerSting:Start()
		end
	elseif args.spellId == 26053 and args:IsPlayer() then
		timerPoison:Start()
	elseif args.spellId == 26051 then
		warnEnrage:Show()
		timerEnrage:Start()
		timerEnrageCD:Start()
	elseif args.spellId == 26068 then
		warnBerserk:Show()
	elseif args.spellId == 26050 and not self:IsTrivial(80) then
		local amount = args.amount or 1
		warnAcid:Show(args.spellName, args.destName, amount)
		timerAcid:Start(args.destName)
		if args:IsPlayer() and amount >= 10 then
			specWarnAcid:Show(amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 26180 and args:IsPlayer() then
		timerSting:Cancel()
	elseif args.spellId == 26053 and args:IsPlayer() then
		timerPoison:Cancel()
	elseif args.spellId == 26050 then
		timerAcid:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 26053 then
		warnPoison:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.35 and self:GetUnitCreatureId(uId) == 15509 and not prewarn_berserk then
		warnBerserkSoon:Show()
		prewarn_berserk = true
	end
end
