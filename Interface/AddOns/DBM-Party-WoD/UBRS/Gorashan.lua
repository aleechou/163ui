local mod	= DBM:NewMod(1226, "DBM-Party-WoD", 8, 559)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 12112 $"):sub(12, -3))
mod:SetCreatureID(76413)
mod:SetEncounterID(1761)
mod:SetZone()

mod:RegisterCombat("combat")
mod.disableHealthCombat = true

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154448",
	"SPELL_AURA_APPLIED 166168",
	"SPELL_AURA_APPLIED_DOSE 166168",
	"SPELL_AURA_REMOVED 166168",
	"SPELL_AURA_REMOVED_DOSE 166168"
)


local warnPowerConduit			= mod:NewCountAnnounce(166168, 3)
local warnPowerConduitLeft		= mod:NewAddsLeftAnnounce(166168, 2)
local warnShrapnelNova			= mod:NewSpellAnnounce(154448, 4, nil, not mod:IsTank())

local specWarnPowerConduit		= mod:NewSpecialWarningSpell(166168, nil, nil, nil, 2)
local specWarnPowerConduitEnded	= mod:NewSpecialWarningEnd(166168)
local specWarnShrapnelNova		= mod:NewSpecialWarningRun(154448, not mod:IsTank())

function mod:SPELL_CAST_START(args)
	if args.spellId == 154448 then
		warnShrapnelNova:Show()
		specWarnShrapnelNova:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 166168 and self:IsInCombat() then
		warnPowerConduit:Cancel()
		warnPowerConduit:Schedule(0.5, args.amount or 1)
		specWarnPowerConduit:Show()
	end
end
function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 166168 and self:IsInCombat() then
		warnPowerConduit:Cancel()
		warnPowerConduit:Schedule(0.5, args.amount or 1)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 166168 and self:IsInCombat() then
		local amount = args.amount or 0
		warnPowerConduitLeft:Show(amount)
		if amount == 0 then
			specWarnPowerConduitEnded:Show()
		end
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED
