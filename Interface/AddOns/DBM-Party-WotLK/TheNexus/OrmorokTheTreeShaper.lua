local mod	= DBM:NewMod("OrmorokTheTreeShaper", "DBM-Party-WotLK", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 2917 $"):sub(12, -3))
mod:SetCreatureID(26794)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local isCaster = select(2, UnitClass("player")) == "MAGE"
              or select(2, UnitClass("player")) == "WARLOCK"

local warningSpikes			= mod:NewSpellAnnounce(47958, 2)
local warningFrenzy			= mod:NewSpellAnnounce(48017, 3)
local warningReflection		= mod:NewSpellAnnounce(47981, 4)
local warningAdd			= mod:NewSpellAnnounce(61564, 1)

local specWarnReflection	= mod:NewSpecialWarningSpell(47981, isCaster)

local timerReflection		= mod:NewBuffActiveTimer(15, 47981)
local timerReflectionCD		= mod:NewCDTimer(30, 47981)

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(47958, 57082, 57083) then
		warningSpikes:Show()
	elseif args:IsSpellID(48017, 57086) then
		warningFrenzy:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(47981) then
		timerReflection:Start()
		warningReflection:Show()
		specWarnReflection:Show()
		timerReflectionCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(47981) then
		timerReflection:Cancel()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(61564) then
		warningAdd:Show()
	end
end