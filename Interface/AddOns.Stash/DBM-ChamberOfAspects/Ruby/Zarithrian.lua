local mod	= DBM:NewMod("Zarithrian", "DBM-ChamberOfAspects", 2)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 108 $"):sub(12, -3))
mod:SetCreatureID(39746)
mod:SetModelID(32179)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"CHAT_MSG_MONSTER_YELL"
)

local warningAdds				= mod:NewAnnounce("WarnAdds", 3, 74398)
local warnCleaveArmor			= mod:NewStackAnnounce(74367, 2, nil, mod:IsTank() or mod:IsHealer())
local warningFear				= mod:NewSpellAnnounce(74384, 3)

local specWarnCleaveArmor		= mod:NewSpecialWarningStack(74367, nil, 2)--ability lasts 30 seconds, has a 15 second cd, so tanks should trade at 2 stacks.

local timerAddsCD				= mod:NewTimer(45.5, "TimerAdds", 74398)
local timerCleaveArmor			= mod:NewTargetTimer(30, 74367, nil, mod:IsTank() or mod:IsHealer())
local timerFearCD				= mod:NewCDTimer(33, 74384)--anywhere from 33-40 seconds in between fears.

function mod:OnCombatStart(delay)
	timerFearCD:Start(14-delay)--need more pulls to verify consistency
	timerAddsCD:Start(15.5-delay)--need more pulls to verify consistency
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 74384 then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 74367 then
		local amount = args.amount or 1
		warnCleaveArmor:Show(args.destName, amount)
		timerCleaveArmor:Start(args.destName)
		if args:IsPlayer() and amount >= 2 then
			specWarnCleaveArmor:Show(amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SummonMinions or msg:match(L.SummonMinions) then
		warningAdds:Show()
		timerAddsCD:Start()
	end
end