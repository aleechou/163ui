local mod	= DBM:NewMod(181, "DBM-Party-Cataclysm", 11, 76)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7759 $"):sub(12, -3))
mod:SetCreatureID(52059)
mod:SetModelID(37805)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_INTERRUPT",
	"CHAT_MSG_MONSTER_YELL"
)

local warnTears		= mod:NewSpellAnnounce(96435, 3)
local warnLash		= mod:NewTargetAnnounce(96423, 3)
local warnRavage	= mod:NewTargetAnnounce(96592, 3)
local warnPhase2	= mod:NewPhaseAnnounce(2)

local specWarnTears	= mod:NewSpecialWarningInterrupt(96435)
local specWarnWaveAgony	= mod:NewSpecialWarningMove(96457)

local timerTears	= mod:NewCastTimer(6, 96435)
local timerLash		= mod:NewTargetTimer(10, 96423)
local timerWaveAgony	= mod:NewCDTimer(32, 96457)
local timerRavage	= mod:NewTargetTimer(10, 96592)

local phase2warned = false

function mod:OnCombatStart(delay)
	phase2warned = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(96435) then	-- Tears of Blood, CD 27-37 secs
		warnTears:Show()
		specWarnTears:Show(args.sourceName)
		timerTears:Start()
	elseif args:IsSpellID(96423, 96958) then -- unconfirmed in mop
		warnLash:Show(args.destName)
		timerLash:Start(args.destName)
	elseif args:IsSpellID(96592) then
		warnRavage:Show(args.destName)
		timerRavage:Start(args.destName)
	elseif args:IsSpellID(97380) and not phase2warned then
		phase2warned = true
		warnPhase2:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(96958) then
		timerLash:Cancel(args.destName)
	end
end

function mod:SPELL_INTERRUPT(args)
	if type(args.extraSpellId) == "number" and args.extraSpellId == 96435 then
		timerTears:Cancel()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.WaveAgony then
		specWarnWaveAgony:Show()
		timerWaveAgony:Start()
	end
end
