local mod	= DBM:NewMod(117, "DBM-Party-Cataclysm", 5, 69)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(44577)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnShockwave 	= mod:NewCastAnnounce(83445, 3)
local warnIntentions	= mod:NewSpellAnnounce(83113, 3)
local warnDetonate		= mod:NewSpellAnnounce(91263, 3)

local timerShockwave	= mod:NewCastTimer(5, 83445)
local timerIntentions	= mod:NewNextTimer(25, 83113)

function mod:OnCombatStart(delay)
	timerIntentions:Start(-delay)	-- might needs tuning
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 83445 then
		warnShockwave:Show()
		timerShockwave:Start()
	elseif args.spellId == 91263 then
		warnDetonate:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 83113 then
		warnIntentions:Show()
		timerIntentions:Start()
	end
end