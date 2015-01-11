local mod	= DBM:NewMod("Kurinnaxx", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 501 $"):sub(12, -3))
mod:SetCreatureID(15348)
mod:SetModelID(15742)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnWound		= mod:NewStackAnnounce(25646, 3)
local warnSandTrap	= mod:NewTargetAnnounce(25656, 4)

local specWarnWound	= mod:NewSpecialWarningStack(25646, nil, 5)

local timerWound	= mod:NewTargetTimer(15, 25646)
local timerSandTrap	= mod:NewTargetTimer(20, 25656)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 25646 and not self:IsTrivial(80) then
		local amount = args.amount or 1
		warnWound:Show(args.destName, amount)
		timerWound:Start(args.destName)
		if amount >= 5 and args:IsPlayer() then
			specWarnWound:Show(amount)
		end
	elseif args.spellId == 25656 then
		warnSandTrap:Show(args.destName)
		timerSandTrap:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED