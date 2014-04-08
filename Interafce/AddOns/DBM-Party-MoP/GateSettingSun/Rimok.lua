local mod	= DBM:NewMod(676, "DBM-Party-MoP", 4, 303)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(56636)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_CAST_START"
)

--This mod needs more stuff involving adds later.
local warnFrenziedAssault		= mod:NewSpellAnnounce(107120, 3)

local specWarnFrenziedAssault	= mod:NewSpecialWarningSpell(107120, mod:IsTank())
local specWarnViscousFluid		= mod:NewSpecialWarningMove(107122)
local specWarnAssaultMove		= mod:NewSpecialWarningMove(107121)  --voice

local timerFrenziedAssault		= mod:NewBuffActiveTimer(6, 107120)
local timerFrenziedAssaultCD	= mod:NewNextTimer(17, 107120)

function mod:OnCombatStart(delay)
	timerFrenziedAssaultCD:Start(6-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 107122 and args:IsPlayer() and self:AntiSpam(3, 1) then
		specWarnViscousFluid:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	elseif args.spellId == 107120 then
		timerFrenziedAssault:Start()
		timerFrenziedAssaultCD:Start()
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args.spellId == 107120 then
		warnFrenziedAssault:Show()
		specWarnFrenziedAssault:Show()
		if mod:IsTank() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 107121 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnAssaultMove:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE