local mod	= DBM:NewMod(1160, "DBM-Party-WoD", 6, 537)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11370 $"):sub(12, -3))
mod:SetCreatureID(76407)
mod:SetEncounterID(1682)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 154442",
	"SPELL_CAST_SUCCESS 154350",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--All data confirmed and accurate for normal mode scarlet halls. heroic data should be quite similar but with diff spellids, will wait for logs to assume anything there.
local warnRitualOfBones			= mod:NewSpellAnnounce(154671, 4)
local warnOmenOfDeath			= mod:NewSpellAnnounce(154350, 3)
local warnMalevolence			= mod:NewSpellAnnounce(154442, 3, nil, mod:IsTank())

local specWarnRitualOfBones		= mod:NewSpecialWarningSpell(154671, nil, nil, nil, true)
local specWarnMalevolence		= mod:NewSpecialWarningMove(154442, mod:IsTank())--Assume tank is in front

local timerRitualOfBonesCD		= mod:NewNextTimer(50.5, 154671)
local timerOmenOfDeathCD		= mod:NewNextTimer(10.5, 154350)

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
		if mod:IsTank() then
			sndWOP:Play("runaway")
		end
		warnMalevolence:Show()
		specWarnMalevolence:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 154350 then
		warnOmenOfDeath:Show()
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
