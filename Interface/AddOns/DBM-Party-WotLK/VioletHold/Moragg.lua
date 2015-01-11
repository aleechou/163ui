local mod	= DBM:NewMod(627, "DBM-Party-WotLK", 12, 283)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 105 $"):sub(12, -3))
mod:SetCreatureID(29316)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

local warningLink 	= mod:NewTargetAnnounce(54396, 2)
local timerLink		= mod:NewTargetTimer(12, 54396)
local timerLinkCD	= mod:NewCDTimer(45, 54396)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 54396 then
		warningLink:Show(args.destName)
		timerLink:Start(args.destName)
		timerLinkCD:Cancel()
		timerLinkCD:Start()
	end
end