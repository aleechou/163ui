local mod	= DBM:NewMod(1237, "DBM-Party-WoD", 4, 558)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11689 $"):sub(12, -3))
mod:SetCreatureID(79852)
mod:SetEncounterID(1750)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 163054",
	"SPELL_AURA_APPLIED 162415"
)

--TODO, Roar cd 37 seconds? Verify
local warnRoar					= mod:NewSpellAnnounce(163054, 3)
local warnTimeToFeed			= mod:NewTargetAnnounce(162415, 3)

local specWarnRoar				= mod:NewSpecialWarningSpell(163054, nil, nil, nil, true)
local specWarnTimeToFeed		= mod:NewSpecialWarningYou(162415)--Can still move and attack during it, a personal warning lets a person immediately hit self heals/damage reduction abilities.
local specWarnTimeToFeedOther	= mod:NewSpecialWarningTarget(162415, mod:IsHealer())

local timerTimeToFeedCD			= mod:NewCDTimer(22, 162415)--22 to 30 second variation. In CM targets random players, not just tank, so timer for all.

function mod:OnCombatStart(delay)
	--timerTimeToFeedCD:Start(18-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 162415 then
		warnTimeToFeed:Show(args.destName)
		specWarnTimeToFeedOther:Show(args.destName)
		--timerTimeToFeedCD:Start()
		if args:IsPlayer() then
			specWarnTimeToFeed:Show()
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 163054 then--he do not target anything. so can't use target scan.
		warnRoar:Show()
		specWarnRoar:Show()
	end
end
