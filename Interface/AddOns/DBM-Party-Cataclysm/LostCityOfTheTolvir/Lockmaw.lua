local mod	= DBM:NewMod(118, "DBM-Party-Cataclysm", 5, 69)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(43614)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnScentBlood	= mod:NewTargetAnnounce(81690, 3)
local warnPoison	= mod:NewTargetAnnounce(81630, 3)
local warnDustFlail	= mod:NewSpellAnnounce(81642, 3)
local warnEnrage	= mod:NewSpellAnnounce(81706, 4)

local timerScentBlood	= mod:NewTargetTimer(30, 81690)
local timerPoison		= mod:NewBuffFadesTimer(12, 81630)
local timerDustFlail	= mod:NewBuffActiveTimer(5, 81642)

mod:AddBoolOption("RangeFrame")

local poisonTargets = {}
local poisonCount = 0

local function showPoisonWarning()
	warnPoison:Show(table.concat(poisonTargets, "<, >"))
	table.wipe(poisonTargets)
	timerPoison:Start()
end

function mod:OnCombatStart(delay)
	table.wipe(poisonTargets)
	poisonCount = 0
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 81690 then
		warnScentBlood:Show(args.destName)
		timerScentBlood:Start(args.destName)
	elseif args.spellId == 81630 then
		poisonCount = poisonCount + 1
		poisonTargets[#poisonTargets + 1] = args.destName
		self:Unschedule(showPoisonWarning)
		self:Schedule(0.3, showPoisonWarning)
	elseif args.spellId == 81706 then
		warnEnrage:Show()
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 81690 then
		timerScentBlood:Cancel(args.destName)
	elseif args.spellId == 75861 then
		poisonCount = poisonCount - 1
		if poisonCount == 0 then
			timerPoison:Cancel()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 81642 then
		warnDustFlail:Show()
		timerDustFlail:Start()
	end
end