local mod	= DBM:NewMod("Maulgar", "DBM-Outlands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 163 $"):sub(12, -3))
mod:SetCreatureID(18831, 18832, 18834, 18835, 18836)
mod:SetModelID(18649)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

--Maulgar
local warningWhirlwind		= mod:NewSpellAnnounce(33238, 4)
--Olm
local warningFelHunter		= mod:NewSpellAnnounce(33131, 3)
--Krosh
local warningShield			= mod:NewTargetAnnounce(33054, 4)
--Blindeye
local warningPWS			= mod:NewTargetAnnounce(33147, 3, nil, false)
local warningPoH			= mod:NewCastAnnounce(33152, 4)
local warningHeal			= mod:NewCastAnnounce(33144, 4)

local specWarnWhirlwind		= mod:NewSpecialWarningSpell(33238, mod:IsMelee())
local specWarnPoH			= mod:NewSpecialWarningInterrupt(33152)
local specWarnHeal			= mod:NewSpecialWarningInterrupt(33144)

local timerWhirlwindCD		= mod:NewCDTimer(55, 33238)
local timerWhirlwind		= mod:NewBuffActiveTimer(15, 33238)
local timerFelhunter		= mod:NewBuffActiveTimer(48.5, 33131)--Buff Active or Cd timer?
local timerPoH				= mod:NewCastTimer(4, 33152)
local timerHeal				= mod:NewCastTimer(2, 33144)

local lastFear = 0

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(58-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 33152 then--Prayer of Healing
		warningPoH:Show()
		timerPoH:Start()
		if self:GetUnitCreatureId("target") == 18836 or self:GetUnitCreatureId("focus") == 18836 then
			specWarnPoH:Show(args.sourceName)
		end
	elseif args.spellId == 33144 then--Heal
		warningHeal:Show()
		timerHeal:Start()
		if self:GetUnitCreatureId("target") == 18836 or self:GetUnitCreatureId("focus") == 18836 then
			specWarnHeal:Show(args.sourceName)
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33238 then
		warningWhirlwind:Show()
		specWarnWhirlwind:Show()
		timerWhirlwind:Start()
		timerWhirlwindCD:Start()
	elseif args.spellId == 33054 and not args:IsDestTypePlayer() then
		warningShield:Show(args.destName)
	elseif args.spellId == 33147 and not args:IsDestTypePlayer() then
		warningPWS:Show(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 33131 then
		warningFelHunter:Show()
		timerFelhunter:Start()
	end
end