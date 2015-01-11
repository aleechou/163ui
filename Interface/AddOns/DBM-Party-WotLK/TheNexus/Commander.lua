local mod = DBM:NewMod("Commander", "DBM-Party-WotLK", 8)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetEncounterID(519)

if UnitFactionGroup("player") == "Alliance" then
	mod:SetCreatureID(26798)
	mod:SetModelID(24352)
else
	mod:SetCreatureID(26796)
	mod:SetModelID(24366)
end

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START"
)

local warningFear		= mod:NewSpellAnnounce(19134, 3)
local warningWhirlwind	= mod:NewSpellAnnounce(38619, 3)
local timerFearCD		= mod:NewCDTimer(20, 19134)
local timerWhirlwindCD	= mod:NewCDTimer(15, 38619)


function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 19134 and self:IsInCombat() then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(38619, 38618) and self:IsInCombat() then
		warningWhirlwind:Show()
		timerWhirlwindCD:Start()
	end
end