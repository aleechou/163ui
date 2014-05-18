local mod	= DBM:NewMod(130, "DBM-Party-Cataclysm", 4, 70)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7663 $"):sub(12, -3))
mod:SetCreatureID(39378)
mod:SetModelID(33177)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS"
)

local warnBlessing		= mod:NewSpellAnnounce(76355, 3)
local warnLeap			= mod:NewSpellAnnounce(87653, 2)
local warnSunOrb		= mod:NewSpellAnnounce(80352, 3)
local warnSunStrike		= mod:NewSpellAnnounce(73872, 3)

local timerBlessing		= mod:NewBuffActiveTimer(23, 76355)
local timerSunStrike	= mod:NewCDTimer(27, 73872)

local specWarnSunOrb	= mod:NewSpecialWarningInterrupt(80352)

function mod:OnCombatStart(delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(76355, 89879) and self:AntiSpam(5) then
		warnBlessing:Show()
		timerBlessing:Start()
		timerSunStrike:Start(50)	-- or hack it into SPELL_AURA_REMOVED
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(87653) then
		warnLeap:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(80352) then
		warnSunOrb:Show()
		specWarnSunOrb:Show(args.sourceName)
	elseif args:IsSpellID(73872, 89887) then
		warnSunStrike:Show()
		timerSunStrike:Start()
	end
end