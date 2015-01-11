local mod	= DBM:NewMod("Sartura", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 500 $"):sub(12, -3))
mod:SetCreatureID(15516)
mod:SetModelID(15583)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH target focus mouseover"
)

local warnEnrageSoon	= mod:NewSoonAnnounce(8269, 2)
local warnEnrage		= mod:NewSpellAnnounce(8269, 4)
local warnWhirlwind		= mod:NewSpellAnnounce(26083, 3)

local timerWhirlwind	= mod:NewBuffActiveTimer(15, 26083)

local prewarn_enrage
function mod:OnCombatStart(delay)
	prewarn_enrage = false
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(26083, 26082) and self:AntiSpam() then
		timerWhirlwind:Start()
		warnWhirlwind:Show()
	elseif args.spellId == 8269 then
		warnEnrage:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.35 and self:GetUnitCreatureId(uId) == 15516 and not prewarn_enrage then
		warnEnrageSoon:Show()
		prewarn_enrage = true
	end
end
