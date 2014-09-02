local mod	= DBM:NewMod(89, "DBM-Party-Cataclysm", 2, 63)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(47162)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnFistsFlame		= mod:NewSpellAnnounce(87859, 3)
local warnFistsFrost		= mod:NewSpellAnnounce(87861, 3)
local warnArcanePower		= mod:NewSpellAnnounce(88009, 3)
local warnSpiritStrike		= mod:NewSpellAnnounce(59304, 3)

local timerFistsFlame		= mod:NewBuffActiveTimer(10, 87859)
local timerFistsFrost		= mod:NewBuffActiveTimer(10, 87861)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 87859 and args.destName == args.srcName then
		warnFistsFlame:Show()
		timerFistsFlame:Start()
	elseif args.spellId == 87861 and args.destName == args.srcName then
		warnFistsFrost:Show()
		timerFistsFrost:Start()
	elseif args.spellId == 88009 then
		warnArcanePower:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 59304 and self:IsInCombat() then
		warnSpiritStrike:Show()
	end
end