local mod	= DBM:NewMod(639, "DBM-Party-WotLK", 10, 285)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(24200, 24201)
mod:SetEncounterID(573, 574)
mod:SetModelID(26349)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("kill", 24201)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warningEnfeeble	= mod:NewTargetAnnounce(43650, 2)
local warningSummon		= mod:NewSpellAnnounce(52611, 3)
local timerEnfeeble		= mod:NewTargetTimer(6, 43650)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 43650 then
		warningEnfeeble:Show(args.destName)
		timerEnfeeble:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 43650 then
		timerEnfeeble:Cancel(args.destName)
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 52611 and (args.GUID == 24201 or args.GUID == 24000) then
		warningSummon:Show()
	end
end