local mod	= DBM:NewMod(693, "DBM-Party-MoP", 6, 324)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(61567)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


local warnDetonate			= mod:NewSpellAnnounce(120001, 3)

local specWarnSapResidue	= mod:NewSpecialWarningStack(119941, true, 6)
local specWarnDetonate		= mod:NewSpecialWarningSpell(120001, mod:IsHealer(), nil, nil, true)
local specWarnGlob			= mod:NewSpecialWarningSwitch("ej6494", not mod:IsHealer())

local timerDetonateCD		= mod:NewNextTimer(45.5, 120001)
local timerDetonate			= mod:NewCastTimer(5, 120001)
local timerSapResidue		= mod:NewBuffFadesTimer(10, 119941)
--local timerGlobCD			= mod:NewNextTimer(45.5, 119990)--Need more logs

function mod:OnCombatStart(delay)
	timerDetonateCD:Start(30-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 119941 and args:IsPlayer() then
		timerSapResidue:Start()
		if (args.amount or 1) >= 6 and self:AntiSpam(1, 2) then
			specWarnSapResidue:Show(args.amount)
			sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg")--快躲開
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 120001 then
		warnDetonate:Show()
		specWarnDetonate:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\aesoon.ogg")--準備AE
		sndWOP:Schedule(1.5, DBM.SoundMMPath.."\\countfour.ogg")
		sndWOP:Schedule(2.5, DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Schedule(3.5, DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Schedule(4.5, DBM.SoundMMPath.."\\countone.ogg")
		timerDetonate:Start()
		timerDetonateCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 119990 then
		specWarnGlob:Show()
	end
end
