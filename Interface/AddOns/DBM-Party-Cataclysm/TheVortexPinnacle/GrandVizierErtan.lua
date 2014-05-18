local mod	= DBM:NewMod(114, "DBM-Party-Cataclysm", 8, 68)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7759 $"):sub(12, -3))
mod:SetCreatureID(43878)
mod:SetModelID(35181)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"RAID_BOSS_EMOTE"
)

local warnSummonTempest		= mod:NewSpellAnnounce(86340, 2)

local timerSummonTempest	= mod:NewCDTimer(17, 86340)
local timerShield			= mod:NewNextTimer(31.5, 86292)

function mod:OnCombatStart(delay)
	timerShield:Start(24-delay)
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86340) then
		warnSummonTempest:Show()
		timerSummonTempest:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Retract or msg:find(L.Retract) then
		timerShield:Start()
	end
end