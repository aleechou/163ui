local mod	= DBM:NewMod(534, "DBM-Party-BC", 8, 250)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(18341)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warnShell     = mod:NewSpellAnnounce(32358, 3)

local timerShell    = mod:NewBuffActiveTimer(7, 32358)

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(32358, 38759) then
		warnShell:Show()
		timerShell:Start()
	end
end