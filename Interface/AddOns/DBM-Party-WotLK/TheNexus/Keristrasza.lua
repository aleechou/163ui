local mod	= DBM:NewMod(621, "DBM-Party-WotLK", 8, 281)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(26723)
mod:SetEncounterID(526, 527)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED"
)

local warningChains		= mod:NewTargetAnnounce(50997, 4)
local warningNova		= mod:NewSpellAnnounce(48179, 3)
local warningEnrage		= mod:NewSpellAnnounce(8599, 3)

local timerChains		= mod:NewTargetTimer(10, 50997)
local timerChainsCD		= mod:NewCDTimer(25, 50997)
local timerNova			= mod:NewBuffActiveTimer(10, 48179)
local timerNovaCD		= mod:NewCDTimer(25, 48179)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 50997 then
		warningChains:Show(args.destName)
		timerChains:Start(args.destName)
		timerChainsCD:Start()
	elseif args.spellId == 8599 and args.souceGUID == 26723 then
		warningEnrage:Show()
	elseif args.spellId == 48179 then
		warningNova:Show()
		timerNova:Start()
		timerNovaCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 50997 then
		timerChains:Cancel()
	end
end