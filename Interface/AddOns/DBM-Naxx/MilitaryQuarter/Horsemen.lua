local mod	= DBM:NewMod("Horsemen", "DBM-Naxx", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(16063, 16064, 16065, 30549)
mod:SetEncounterID(1121)
mod:SetModelID(10729)
mod:RegisterCombat("combat")

mod:EnableModel()

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED_DOSE"
)

-- local warnMarkSoon			= mod:NewAnnounce("WarningMarkSoon", 1, 28835, false)
-- local warnMarkNow			= mod:NewAnnounce("WarningMarkNow", 2, 28835)

local specWarnMarkOnPlayer	= mod:NewSpecialWarning("SpecialWarningMarkOnPlayer", nil, nil, true)

mod:AddBoolOption("HealthFrame", true)

mod:SetBossHealthInfo(
	16064, L.Korthazz,
	30549, L.Rivendare,
	16065, L.Blaumeux,
	16063, L.Zeliek
)

local markCounter = 0

function mod:OnCombatStart(delay)
	markCounter = 0
--	warnMarkSoon:Schedule(12, markCounter + 1)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(28832, 28833, 28834, 28835) and self:AntiSpam(5) then
		markCounter = markCounter + 1
--		warnMarkNow:Show(markCounter)
--		warnMarkSoon:Schedule(5, markCounter + 1)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(28832, 28833, 28834, 28835) and args:IsPlayer() then
		if args.amount >= 4 then
			specWarnMarkOnPlayer:Show(args.spellName, args.amount)
		end
	end
end

