local mod	= DBM:NewMod(127, "DBM-Party-Cataclysm", 4, 70)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(39587)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warnAstralRain	= mod:NewSpellAnnounce(74134, 3)
local warnVeilSky		= mod:NewSpellAnnounce(74133, 3)
local warnSupernova		= mod:NewCastAnnounce(74136, 4)
local warnSplitSoon		= mod:NewAnnounce("WarnSplitSoon", 3)

local timerAstralRain	= mod:NewBuffActiveTimer(8, 74134)
local timerSupernova	= mod:NewCastTimer(3, 74136)

local warnedSplit

function mod:OnCombatStart(delay)
	warnedSplit = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 74134 then--74365?
		warnAstralRain:Show()
		timerAstralRain:Start()
	elseif args.spellId == 74133 then
		warnVeilSky:Show()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 74136 then
		warnSupernova:Show()
		timerSupernova:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if (h > 80) or (h > 45 and h < 60) then
			warnedSplit = false
		elseif (h < 75 and h > 72 or h < 41 and h > 38) and not warnedSplit then
			warnedSplit = true
			warnSplitSoon:Show()
		end
	end
end
