local mod	= DBM:NewMod("Fathomlord", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(21214)
mod:SetModelID(20662)
mod:SetZone()

mod:RegisterCombat("yell", L.YellPull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_SUMMON"
)

mod:SetBossHealthInfo(
	21214, L.name,
	21964, L.Caribdis,
	21965, L.Tidalvess,
	21966, L.Sharkkis
)

local warnHeal			= mod:NewSpellAnnounce(38330, 2)
local warnTotem			= mod:NewTargetAnnounce(38236, 4)
local warnCariPower		= mod:NewSpellAnnounce(38451, 3)
local warnTidalPower	= mod:NewSpellAnnounce(38452, 3)
local warnSharPower		= mod:NewSpellAnnounce(38455, 3)

local specWarnHeal		= mod:NewSpecialWarningInterrupt(38330, false)
local specWarnTotem		= mod:NewSpecialWarningSpell(38236)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("HealthFrame", false)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 38451 then
		warnCariPower:Show()
	elseif args.spellId == 38452 then
		warnTidalPower:Show()
	elseif args.spellId == 38455 then
		warnSharPower:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 38330 then
		warnHeal:Show()
		if self:GetUnitCreatureId("target") == 21964 then
			specWarnHeal:Show(args.sourceName)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 38236 then
		warnTotem:Show(args.sourceName)
	end
end
