local mod	= DBM:NewMod(289, "DBM-Party-Cataclysm", 12, 184)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 121 $"):sub(12, -3))
mod:SetCreatureID(54432)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Kill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)
mod.onlyHeroic = true

local warnBlast			= mod:NewSpellAnnounce(102381, 3)
local warnBreath		= mod:NewSpellAnnounce(102569, 4)
local warnRewind		= mod:NewSpellAnnounce(101591, 3)

local timerBlastCD		= mod:NewNextTimer(12, 102381)
local timerBreathCD		= mod:NewNextTimer(22, 102569)

function mod:OnCombatStart(delay)
	timerBlastCD:Start(-delay)
	timerBreathCD:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 101591 and self:AntiSpam() then
		warnRewind:Show()
		timerBlastCD:Cancel()
		timerBreathCD:Cancel()
		timerBlastCD:Start()
		timerBreathCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 102381 then
		warnBlast:Show()
		timerBlastCD:Start()
	elseif args.spellId == 102569 then
		warnBreath:Show()
		timerBreathCD:Start()
	end
end