local mod	= DBM:NewMod(283, "DBM-Party-Cataclysm", 12, 184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7663 $"):sub(12, -3))
mod:SetCreatureID(54544)
mod:SetModelID(39617)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START"
)

local warnGuidance		= mod:NewSpellAnnounce(102472, 3)
local warnGuidanceStack	= mod:NewCountAnnounce(102472, 2, nil, false)
local warnStardust		= mod:NewSpellAnnounce(102173 ,3)
local specwarnStardust	= mod:NewSpecialWarningInterrupt(102173)

local timerGuidance		= mod:NewNextTimer(20, 102472)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(102472) then
		warnGuidanceStack:Show(args.amount or 1)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(102472) then
		warnGuidance:Show()
		timerGuidance:Start()
	elseif args:IsSpellID(102173) then
		warnStardust:Show()
		specwarnStardust:Show(args.sourceName)
	end
end