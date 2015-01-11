local mod	= DBM:NewMod(573, "DBM-Party-BC", 6, 261)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17797)
mod:SetModelID(11268)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningCloud = mod:NewSpellAnnounce(25033)
local warningWinds = mod:NewTargetAnnounce(31718)
local warningBurst = mod:NewTargetAnnounce(31481)
local timerWinds   = mod:NewTargetTimer(6, 31718)
local timerBurst   = mod:NewTargetTimer(10, 31481)

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 25033 then
		warningCloud:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31718 then
		warningWinds:Show(args.destName)
		timerWinds:Start(args.destName)
	elseif args.spellId == 31481 then
		warningBurst:Show(args.destName)
		timerBurst:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 31718 then
		timerWinds:Cancel(args.destName)
	elseif args.spellId == 31481 then
		timerBurst:Cancel(args.destName)
	end
end