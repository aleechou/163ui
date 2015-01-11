local mod	= DBM:NewMod("Fankriss", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 503 $"):sub(12, -3))
mod:SetCreatureID(15510)
mod:SetModelID(15743)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_SUMMON"
)

local warnWound			= mod:NewStackAnnounce(25646, 3)
local warnWorm			= mod:NewSpellAnnounce(25831, 3)

local timerWound		= mod:NewTargetTimer(20, 25646)

local specWarnWound		= mod:NewSpecialWarningStack(25646, nil, 5)

function mod:OnCombatStart(delay)
	if not self:IsTrivial(85) then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED",
			"SPELL_AURA_APPLIED_DOSE",
			"SPELL_AURA_REMOVED"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 25646 then
		local amount = args.amount or 1
		warnWound:Show(args.destName, amount)
		timerWound:Show(args.destName)
		if amount >= 5 then
			specWarnWound:Show(amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 25646 then
		timerWound:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(518, 25832, 25831) then
		warnWorm:Show()
	end
end
