local mod	= DBM:NewMod("Chess", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

local playerFactoin = UnitFactionGroup("player")
mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
--UNIT_DIED firing for king assumed
if playerFactoin == "Alliance" then
	mod:SetCreatureID(21752)--Warchief Blackhand
else
	mod:SetCreatureID(21684)--King Llane
end
mod:SetModelID(18720)
mod:RegisterCombat("combat")--Actually not how we register combat, bogus because SetWipeTime needs it
mod:SetWipeTime(600)

mod:RegisterEvents(
	"SPELL_AURA_APPLIED"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_DIED"
)

local timerHeroism			= mod:NewBuffActiveTimer(10, 37471)
local timerBloodlust		= mod:NewBuffActiveTimer(10, 37472)
local timerRecentlyInGame	= mod:NewBuffFadesTimer(10, 30529)
local timerNextCheat		= mod:NewTimer(108, "timerCheat", 39342)

local firstCheat = false
local secondCheat = false

function mod:OnCombatStart(delay)
	firstCheat = false
	secondCheat = false
	timerNextCheat:Start(111)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 39331 and not self:IsInCombat() then
		DBM:StartCombat(self, 0)
	elseif args.spellId == 30529 and args:IsPlayer() then
		timerRecentlyInGame:Start()
	elseif args.spellId == 30019 and not self:IsInCombat() then--Because game in session may not go away on wipe, we need to detect a repull off first hop into a chess peice
		DBM:StartCombat(self, 0)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 39331 and self:IsInCombat() then
		DBM:EndCombat(self, true)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37471 then
		timerHeroism:Start()
	elseif args.spellId == 37472 then
		timerBloodlust:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg == L.EchoCheats then
		timerNextCheat:Start()--All other cheats should be every 108 like clockwork. Only the second is random. Ie, 111, 120, 108 repeating, OR 111, 108 repeating.
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if playerFactoin == "Alliance" and (cid == 21684) then
		DBM:EndCombat(self, true)
	elseif playerFactoin == "Horde" and (cid == 21752) then
		DBM:EndCombat(self, true)
	end
end
