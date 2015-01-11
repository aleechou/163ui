local mod = DBM:NewMod(601, "DBM-Party-WotLK", 16, 276)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(38112)
mod:SetEncounterID(842, 841)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnFear					= mod:NewSpellAnnounce(72435, 3)
local warnImpendingDespair		= mod:NewTargetAnnounce(72426, 3)
local warnQuiveringStrike		= mod:NewTargetAnnounce(72422, 3)

local timerFear					= mod:NewBuffActiveTimer(4, 72435)
local timerImpendingDespair		= mod:NewTargetTimer(6, 72426)
local timerQuiveringStrike		= mod:NewTargetTimer(5, 72422)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72422 then
		timerQuiveringStrike:Start(args.destName)
		warnQuiveringStrike:Show(args.destName)
	elseif args.spellId == 72426 then
		timerImpendingDespair:Start(args.destName)
		warnImpendingDespair:Show(args.destName)
	elseif args.spellId == 72435 and self:AntiSpam() then
		warnFear:Show()
		timerFear:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 72422 then
		timerQuiveringStrike:Cancel(args.destName)
	elseif args.spellId == 72426 then
		timerImpendingDespair:Cancel(args.destName)
	end
end