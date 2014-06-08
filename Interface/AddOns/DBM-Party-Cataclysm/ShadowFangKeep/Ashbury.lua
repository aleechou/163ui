local mod	= DBM:NewMod(96, "DBM-Party-Cataclysm", 6, 64)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(46962)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnPain				= mod:NewTargetAnnounce(93581, 3)
local warnWracking			= mod:NewSpellAnnounce(93720, 2)
local warnArchangel			= mod:NewSpellAnnounce(93757, 4)


local timerAsphyxiate		= mod:NewCDTimer(45, 93423)

function mod:OnCombatStart(delay)
	timerAsphyxiate:Start(18-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 93581 then
		warnPain:Show(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 93757 then
		warnArchangel:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 93423 then
		timerAsphyxiate:Start()
	elseif args.spellId == 93720 then
		warnWracking:Show()
	end
end