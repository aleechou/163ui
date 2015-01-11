local mod	= DBM:NewMod(97, "DBM-Party-Cataclysm", 6, 64)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(3887)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnVeilShadow	= mod:NewSpellAnnounce(93956, 3)
local warnWorgenSpirit	= mod:NewSpellAnnounce(93857, 3)

local timerVeilShadow	= mod:NewBuffFadesTimer(8, 93956)
local timerWorgenSpirit	= mod:NewCastTimer(2, 93857)

local veilShadowCast = 0

function mod:OnCombatStart(delay)
	veilShadowCast = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 93956 then
		veilShadowCast = veilShadowCast + 1
		if self:AntiSpam(4) then
			warnVeilShadow:Show()
			timerVeilShadow:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 93956 then
		veilShadowCast = veilShadowCast - 1
		if veilShadowCast == 0 then
			timerVeilShadow:Cancel()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 93857 then
		warnWorgenSpirit:Show()
		timerWorgenSpirit:Start()
	end
end