local mod	= DBM:NewMod(641, "DBM-Party-WotLK", 11, 286)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 125 $"):sub(12, -3))
mod:SetCreatureID(26668)
mod:SetEncounterID(577, 578)
mod:DisableESCombatDetection()
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

local warningSacrifice	= mod:NewTargetAnnounce(48267, 2)
local timerSacrifice	= mod:NewBuffActiveTimer(25, 48276)
local timerRoleplay		= mod:NewTimer(67, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime")--roleplay for boss is active

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 48267 then
		warningSacrifice:Show(args.destName)
	elseif args.spellId == 48276 then
		timerSacrifice:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SvalaRoleplayStart or msg:find(L.SvalaRoleplayStart) then
		timerRoleplay:Start()
	end
end