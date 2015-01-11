local mod	= DBM:NewMod("ThreeBugs", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 436 $"):sub(12, -3))
mod:SetCreatureID(15544, 15511, 15543)
mod:SetModelID(15657)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)
mod:SetBossHealthInfo(
	15543, L.Yauj,
	15544, L.Vem,
	15511, L.Kri
)

local warnFear	= mod:NewSpellAnnounce(26580, 2)
local warnHeal	= mod:NewCastAnnounce(25807, 3)

local timerFear	= mod:NewBuffActiveTimer(8, 26580)
local timerHeal	= mod:NewCastTimer(2, 25807)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 26580 and self:AntiSpam() then
		warnFear:Show()
		timerFear:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 25807 then
		warnHeal:Show()
		timerHeal:Start()
	end
end