local mod	= DBM:NewMod("Augh", "DBM-Party-Cataclysm", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(49045)
mod:SetModelID(37339)--Needs hardcode because he's in EJ as a separate boss even though he is.
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnSmokeBomb		= mod:NewSpellAnnounce(84768, 3)
local warnParalyticDart		= mod:NewTargetAnnounce(84799, 3)
local warnWhirlWind		= mod:NewSpellAnnounce(84784, 3)

local timerParalyticDart	= mod:NewTargetTimer(9, 84799)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 84768 and self:AntiSpam(5) then
		warnSmokeBomb:Show()
	elseif args.spellId == 84799 then
		warnParalyticDart:Show(args.destName)
		timerParalyticDart:Start(args.destName)
	elseif args.spellId == 84784 then
		warnWhirlWind:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 84799 then
		timerParalyticDart:Cancel()
	end
end