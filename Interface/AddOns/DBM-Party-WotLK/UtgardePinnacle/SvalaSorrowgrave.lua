local mod	= DBM:NewMod("SvalaSorrowgrave", "DBM-Party-WotLK", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4439 $"):sub(12, -3))
mod:SetCreatureID(26668)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warningSacrifice	= mod:NewTargetAnnounce(48267, 2)
local timerSacrifice	= mod:NewBuffActiveTimer(25, 48276)
local timerRoleplay		= mod:NewTimer(67, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime")--roleplay for boss is active

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(48267) then
		warningSacrifice:Show(args.destName)
	elseif args:IsSpellID(48276) then
		timerSacrifice:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SvalaRoleplayStart or msg:find(L.SvalaRoleplayStart) then
		timerRoleplay:Start()
	end
end