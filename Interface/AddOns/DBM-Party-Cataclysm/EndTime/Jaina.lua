local mod	= DBM:NewMod(285, "DBM-Party-Cataclysm", 12, 184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 121 $"):sub(12, -3))
mod:SetCreatureID(54445)
mod:SetModelID(38802)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)
mod.onlyHeroic = true

local warnFlarecore				= mod:NewSpellAnnounce(101927, 4)
local warnFrostBlades			= mod:NewSpellAnnounce(101339, 3)

local specWarnFlarecore			= mod:NewSpecialWarningSpell(101927, nil, nil, nil, true)

local timerFlarecore			= mod:NewCDTimer(20, 101927)
local timerFlarecoreDetonate	= mod:NewTimer(10, "TimerFlarecoreDetonate", 101927)
local timerFrostBlades			= mod:NewNextTimer(25, 101339)

function mod:OnCombatStart(delay)
	timerFlarecore:Start(16)
	timerFrostBlades:Start(21)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 101927 then
		warnFlarecore:Show()
		specWarnFlarecore:Show()
		timerFlarecore:Start()
		timerFlarecoreDetonate:Start()
	elseif args.spellId == 101812 then	-- Frost Blades is cast immediately after Blink (Frost Blades = 3 events, Blink = 1 event)
		warnFrostBlades:Show()
		timerFrostBlades:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 101980 then
		timerFlarecoreDetonate:Cancel()
	end
end