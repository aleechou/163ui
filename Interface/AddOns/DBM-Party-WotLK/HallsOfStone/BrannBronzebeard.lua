local mod	= DBM:NewMod("BrannBronzebeard", "DBM-Party-WotLK", 7)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 4282 $"):sub(12, -3))
mod:SetCreatureID(28070)
--mod:SetZone()
mod:SetMinSyncRevision(2861)

mod:RegisterCombat("yell", L.Pull)
mod:RegisterKill("yell", L.Kill)
mod:SetMinCombatTime(50)
mod:SetWipeTime(25)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warningPhase	= mod:NewAnnounce("WarningPhase", 2, "Interface\\Icons\\Spell_Nature_WispSplode")
local timerEvent	= mod:NewTimer(302, "timerEvent", "Interface\\Icons\\Spell_Holy_BorrowedTime")

function mod:OnCombatStart(delay)
	timerEvent:Start(-delay)
end

function mod:CHAT_MSG_MONSTER_YELL(msg, sender)
	if L.Phase1 == msg then
		warningPhase:Show(1)
	elseif msg == L.Phase2 then
		warningPhase:Show(2)
	elseif msg == L.Phase3 then
		warningPhase:Show(3)
	end
end


