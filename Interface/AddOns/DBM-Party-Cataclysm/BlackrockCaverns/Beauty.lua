local mod	= DBM:NewMod(108, "DBM-Party-Cataclysm", 1, 66)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7663 $"):sub(12, -3))
mod:SetCreatureID(39700)
mod:SetModelID(34433)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnTerrifyingRoar	= mod:NewSpellAnnounce(76028, 2)
local warnMagmaSpit			= mod:NewTargetAnnounce(76031, 3)

local timerTerrifyingRoarCD	= mod:NewCDTimer(30, 76028)
local timerMagmaSpit		= mod:NewTargetTimer(9, 76031)

function mod:OnCombatStart(delay)
	timerTerrifyingRoarCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(76031) then
		warnMagmaSpit:Show(args.destName)
		timerMagmaSpit:Start(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(76028, 93586) then
		warnTerrifyingRoar:Show()
		timerTerrifyingRoarCD:Start()
	end
end