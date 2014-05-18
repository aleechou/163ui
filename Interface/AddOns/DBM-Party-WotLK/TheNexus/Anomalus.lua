local mod	= DBM:NewMod("Anomalus", "DBM-Party-WotLK", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3962 $"):sub(12, -3))
mod:SetCreatureID(26763)
mod:SetZone()

mod:RegisterCombat("combat")


mod:RegisterEvents(
	"SPELL_SUMMON",
	"UNIT_HEALTH"
)

local warningRiftSoon	= mod:NewSoonAnnounce(47743, 2)
local warningRiftNow	= mod:NewSpellAnnounce(47743, 3)

local warnedRift		= false

function mod:OnCombatStart()
	warnedRift = false
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(47743) then
		warningRiftNow:Show()
	end
end

function mod:UNIT_HEALTH(arg1)
	if UnitName(arg1) == L.name then
		local h = UnitHealth(arg1)
		if (h > 80) or (h < 70 and h > 55) or (h < 45 and h > 30) then
			warnedRift = false
		end
		if not warnedRift then
			if (h < 80 and h > 77) or (h < 55 and h > 52) or (h < 30 and h > 27) then
				warningRiftSoon:Show()
				warnedRift = true
			end
		end
	end
end

