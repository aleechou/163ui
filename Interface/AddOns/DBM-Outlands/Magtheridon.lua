local mod	= DBM:NewMod("Magtheridon", "DBM-Outlands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 164 $"):sub(12, -3))
mod:SetCreatureID(17257)
mod:SetModelID(18527)
mod:RegisterCombat("emote", L.DBM_MAG_EMOTE_PULL)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL"
)

local warningHeal			= mod:NewSpellAnnounce(30528, 3)
local warningInfernal		= mod:NewSpellAnnounce(30511, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warningBlastNova		= mod:NewSpellAnnounce(30616, 4)
local warnPhase3			= mod:NewPhaseAnnounce(3)

local specWarnBlastNova		= mod:NewSpecialWarningSpell(30616)
local specWarnHeal			= mod:NewSpecialWarningInterrupt(30528)

local timerHeal				= mod:NewCastTimer(2, 30528)
local timerPhase2			= mod:NewTimer(120, "timerP2", "Interface\\Icons\\INV_Weapon_Halberd16")
local timerBlastNovaCD		= mod:NewCDTimer(54, 30616)
local timerDebris			= mod:NewNextTimer(15, 36449)--Only happens once per fight, after the phase 3 yell.

function mod:OnCombatStart(delay)
	timerPhase2:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30528 then
		warningHeal:Show()
		if args.sourceGUID == UnitGUID("target") then
			specWarnHeal:Show(args.sourceName)
			timerHeal:Start()
		end
	elseif args.spellId == 30616 then
		warningBlastNova:Show()
		timerBlastNovaCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30511 then
		warningInfernal:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_MAG_YELL_PHASE2 or msg:find(L.DBM_MAG_YELL_PHASE2) then
		warnPhase2:Show()
		timerBlastNovaCD:Start()
		timerPhase2:Cancel()
	elseif msg == L.DBM_MAG_YELL_PHASE3 or msg:find(L.DBM_MAG_YELL_PHASE3) then
		warnPhase3:Show()
		timerDebris:Start()
	end
end