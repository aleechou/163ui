local mod	= DBM:NewMod("Lucifron", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 549 $"):sub(12, -3))
mod:SetCreatureID(12118)--, 12119
--mod:SetEncounterID(663)
mod:SetModelID(13031)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS 19702 19703",
	"SPELL_AURA_APPLIED 20604"
)

local warnDoom		= mod:NewSpellAnnounce(19702, 2)
local warnCurse		= mod:NewSpellAnnounce(19703, 3)
local warnMC		= mod:NewTargetAnnounce(20604, 4)

local timerCurseCD	= mod:NewNextTimer(20.5, 19703)
local timerDoomCD	= mod:NewCDTimer(20, 19702)
local timerDoom		= mod:NewCastTimer(10, 19702)

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 19702 then
		warnDoom:Show()
		timerDoom:Start()
		timerDoomCD:Start()
	elseif spellId == 19703 then
		timerCurseCD:Start()
		warnCurse:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20604 then
		warnMC:CombinedShow(1, args.destName)
	end
end