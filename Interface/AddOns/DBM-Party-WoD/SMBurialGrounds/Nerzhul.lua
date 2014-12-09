local mod	= DBM:NewMod(1160, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11958 $"):sub(12, -3))
mod:SetCreatureID(76407)
mod:SetEncounterID(1682)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154442",
	"SPELL_SUMMON 154350",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--All data confirmed and accurate for normal mode scarlet halls. heroic data should be quite similar but with diff spellids, will wait for logs to assume anything there.
local warnRitualOfBones			= mod:NewSpellAnnounce(154671, 4)
local warnOmenOfDeath			= mod:NewTargetAnnounce(154350, 3)
local warnMalevolence			= mod:NewSpellAnnounce("OptionVersion2", 154442, 3)--Some tank has terrible move. May need everyone

local specWarnRitualOfBones		= mod:NewSpecialWarningSpell(154671, nil, nil, nil, true)
local specWarnOmenOfDeath		= mod:NewSpecialWarningMove(154350)
local yellOmenOfDeath			= mod:NewYell(154350)
local specWarnMalevolence		= mod:NewSpecialWarningSpell(154442)--Assume tank is in front

local timerRitualOfBonesCD		= mod:NewNextTimer(50.5, 154671)
local timerOmenOfDeathCD		= mod:NewCDTimer(10.5, 154350)

function mod:OmenOfDeathTarget(targetname, uId)
	if not targetname then return end
	warnOmenOfDeath:Show(targetname)
	if targetname == UnitName("player") then
		specWarnOmenOfDeath:Show()
		yellOmenOfDeath:Yell()
		sndWOP:Play("runaway")
	end
end

function mod:OnCombatStart(delay)
	timerOmenOfDeathCD:Start(12-delay)
	timerRitualOfBonesCD:Start(20-delay)
	sndWOP:Schedule(15, "specialsoon")
	sndWOP:Schedule(17, "countthree")
	sndWOP:Schedule(18, "counttwo")
	sndWOP:Schedule(19, "countone")
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 154442 then
		warnMalevolence:Show()
		specWarnMalevolence:Show()
		sndWOP:Play("shockwave")
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 154350 then
		self:BossTargetScanner(76407, "OmenOfDeathTarget", 0.04, 15)
		timerOmenOfDeathCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 154671 then
		warnRitualOfBones:Show()
		specWarnRitualOfBones:Show()
		timerRitualOfBonesCD:Start()
		sndWOP:Schedule(45.5, "specialsoon")
		sndWOP:Schedule(47.5, "countthree")
		sndWOP:Schedule(48.5, "counttwo")
		sndWOP:Schedule(49.5, "countone")
	end
end
