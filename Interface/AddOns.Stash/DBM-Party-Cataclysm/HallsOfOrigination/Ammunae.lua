local mod	= DBM:NewMod(128, "DBM-Party-Cataclysm", 4, 70)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(39731)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnWither		= mod:NewTargetAnnounce(76043, 3)
local warnConsume		= mod:NewTargetAnnounce(80968, 3)
local warnRampant		= mod:NewSpellAnnounce(75790, 4)

local timerWither		= mod:NewTargetTimer(10, 76043)
local timerWitherCD		= mod:NewCDTimer(18, 76043)
local timerConsume		= mod:NewTargetTimer(4, 80968)
local timerConsumeCD	= mod:NewCDTimer(15, 80968)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 76043 then
		warnWither:Show(args.destName)
		timerWither:Start(args.destName)
		timerWitherCD:Start()
	elseif args.spellId == 80968 then
		warnConsume:Show(args.destName)
		timerConsume:Start(args.destName)
		timerConsumeCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 75790 then
		warnRampant:Show()
	end
end