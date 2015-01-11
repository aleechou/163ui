local mod	= DBM:NewMod("Broodlord", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 436 $"):sub(12, -3))
mod:SetCreatureID(12017)
mod:SetModelID(14308)
mod:RegisterCombat("combat")--Leave this combat, so pull still works for non localized if user manages to leave combat before pull

mod:RegisterEvents(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warnBlastWave	= mod:NewSpellAnnounce(23331)
local warnKnockAway	= mod:NewSpellAnnounce(18670)
local warnMortal	= mod:NewTargetAnnounce(24573)

local timerMortal	= mod:NewTargetTimer(5, 24573)

function mod:OnCombatStart(delay)
end

--It's unfortunate this is a shared spellid.
--cause you are almost always in combat before pulling this boss which breaks "IsInCombat" detection
--these 2 of these warnings will never work.

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 23331 then
		warnBlastWave:Show()
	elseif args.spellId == 18670 and self:IsInCombat() then
		warnKnockAway:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 24573 and self:IsInCombat() then
		warnMortal:Show(args.destName)
		timerMortal:Start(args.destName)
	end
end

--Secondary pull trigger, so we can detect combat when he's pulled while already in combat (which is about 99% of time)
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.Pull or msg:find(L.Pull)) and not self:IsInCombat() then
		DBM:StartCombat(self, 0)
	end
end
