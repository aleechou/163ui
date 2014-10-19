local mod	= DBM:NewMod(967, "DBM-Party-WoD", 7, 476)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 11371 $"):sub(12, -3))
mod:SetCreatureID(76143)
mod:SetEncounterID(1700)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153810 153794"
)

local warnSolarFlare			= mod:NewSpellAnnounce(153810, 3)
local warnPierceArmor			= mod:NewSpellAnnounce(153794, 3, nil, mod:IsTank())

local specWarnSolarFlare		= mod:NewSpecialWarningSwitch(153810, false)--Not everyone needs to, really just requires 1 person, unless it's harder on heroic/challenge mode and needs more, then i'll default all damage dealers
local specWarnPierceArmor		= mod:NewSpecialWarningSpell(153794, mod:IsTank())

local timerSolarFlare			= mod:NewCDTimer(18, 153810)

function mod:OnCombatStart(delay)
	timerSolarFlare:Start(11-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153810 then
		warnSolarFlare:Show()
		specWarnSolarFlare:Show()
		timerSolarFlare:Start()
	elseif spellId == 153794 then
		warnPierceArmor:Show()
		specWarnPierceArmor:Show()
	end
end
