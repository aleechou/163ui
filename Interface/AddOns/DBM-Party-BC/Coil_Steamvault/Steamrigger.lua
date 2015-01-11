local mod	= DBM:NewMod(574, "DBM-Party-BC", 6, 261)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(17796)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local WarnSummon	= mod:NewSpellAnnounce("ej5999", 3)

local specWarnSummon= mod:NewSpecialWarningSwitch("ej5999", not mod:IsHealer())

local WarnNet		= mod:NewTargetAnnounce(35107, 2)
local timerNet		= mod:NewTargetTimer(6, 35107)

local enrageTimer	= mod:NewBerserkTimer(300)

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic5") then
        enrageTimer:Start(-delay)
    end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35107 then
		WarnNet:Show(args.destName)
		timerNet:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Mechs then		-- Adds
		WarnSummon:Show()
		specWarnSummon:Show()
	end
end
