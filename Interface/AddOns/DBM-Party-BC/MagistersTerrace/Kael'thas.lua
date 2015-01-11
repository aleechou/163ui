local mod = DBM:NewMod(533, "DBM-Party-BC", 16, 249)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))
mod:SetCreatureID(24664)
mod:SetModelID(22906)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnPhase2        = mod:NewPhaseAnnounce(2)
local WarnPhoenix       = mod:NewSpellAnnounce(44194, 3)
local WarnShockBarrior  = mod:NewSpellAnnounce(46165, 3)
local warnPyroblast		= mod:NewCastAnnounce(36819, 4)

local specwarnPyroblast = mod:NewSpecialWarningInterrupt(36819)

local timerPyroblast	= mod:NewCastTimer(4, 36819)
local timerShockBarrior = mod:NewNextTimer(60, 46165)--Best guess based on limited CL data
local timerPhoenix      = mod:NewCDTimer(45, 44194)--Best guess based on limited CL data

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic5") then
        timerShockBarrior:Start(-delay)
    end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 36819 then
		warnPyroblast:Show()
        timerPyroblast:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 44194 then
		WarnPhoenix:Show()
		timerPhoenix:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 46165 then
		WarnShockBarrior:Show(args.destName)
        timerShockBarrior:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 46165 then
        specwarnPyroblast:Show(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.KaelP2 then
		warnPhase2:Show()
		timerShockBarrior:Cancel()
		timerPhoenix:Cancel()
	end
end