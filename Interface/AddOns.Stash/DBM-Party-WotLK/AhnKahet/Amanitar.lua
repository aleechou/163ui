local mod	= DBM:NewMod(583, "DBM-Party-WotLK", 1, 271)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 105 $"):sub(12, -3))
mod:SetCreatureID(30258)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warningMini	= mod:NewSpellAnnounce(57055, 3)
local timerMiniCD	= mod:NewCDTimer(30, 57055)

function mod:SPELL_CAST_START(args)
	if args.spellId == 57055 then
		warningMini:Show()
		timerMiniCD:Start()
	end
end