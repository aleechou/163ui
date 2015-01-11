local mod	= DBM:NewMod("Moroes", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(15687, 19875, 19874, 19872, 17007, 19876, 19873)--Moroes
mod:SetModelID(16540)
--19875, 19874, 19872, 17007, 19876, 19873--all the adds, for future use, when pull/kill handling by diff tables work right.
mod:RegisterCombat("combat")
--mod:RegisterCombat("yell", L.DBM_MOROES_YELL_START)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED"
)

local warningVanish			= mod:NewSpellAnnounce(29448, 4)
local warningGarrote		= mod:NewTargetAnnounce(37066, 2)
local warningGouge			= mod:NewTargetAnnounce(29425, 4)
local warningBlind			= mod:NewTargetAnnounce(34694, 3)
local warningMortalStrike	= mod:NewTargetAnnounce(29572, 1)
local warningFrenzy			= mod:NewSpellAnnounce(37023, 4)
local warningManaBurn		= mod:NewCastAnnounce(29405, 3, nil, false)
local warningGreaterHeal	= mod:NewCastAnnounce(35096, 3, nil, false)
local warningHolyLight		= mod:NewCastAnnounce(29562, 3, nil, false)

local timerVanishCD			= mod:NewCDTimer(31, 29448)
local timerGouge			= mod:NewTargetTimer(6, 29425)
local timerBlind			= mod:NewTargetTimer(10, 34694)
local timerMortalStrike		= mod:NewTargetTimer(5, 29572)

local lastVanish = 0

function mod:OnCombatStart(delay)
	timerVanishCD:Start(-delay)
	lastVanish = 0
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 29405 then
		warningManaBurn:Show()
	elseif args.spellId == 35096 then
		warningGreaterHeal:Show()
	elseif args.spellId == 29562 then
		warningHolyLight:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29448 then
		warningVanish:Show()
		lastVanish = GetTime()
	elseif args.spellId == 29425 then
		warningGouge:Show(args.destName)
		timerGouge:Show(args.destName)
	elseif args.spellId == 34694 then
		warningBlind:Show(args.destName)
		timerBlind:Show(args.destName)
	elseif args.spellId == 29572 then
		warningMortalStrike:Show(args.destName)
		timerMortalStrike:Show(args.destName)
	elseif args.spellId == 37023 then--Frenzy, he's no longer going to vanish.
		warningFrenzy:Show()
		timerVanishCD:Cancel()
	elseif args.spellId == 37066 then
		warningGarrote:Show(args.destName)
		if (GetTime() - lastVanish) < 20 then--firing this event here instead, since he does garrote as soon as he comes out of vanish.
			timerVanishCD:Start()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 34694 then
		timerBlind:Cancel(args.destName)
	elseif args.spellId == 29425 then
		timerGouge:Cancel(args.destName)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 15687 then
		DBM:EndCombat(self)
	end
end
