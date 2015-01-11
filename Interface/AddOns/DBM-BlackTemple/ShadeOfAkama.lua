local mod	= DBM:NewMod("Akama", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 501 $"):sub(12, -3))
mod:SetCreatureID(23421, 22841, 23215, 23216)
mod:SetModelID(21357)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetWipeTime(30)

mod:RegisterEventsInCombat(
	"UNIT_DIED"
)

local warnPhase2	= mod:NewPhaseAnnounce(2)

local phase2started = false

function mod:OnCombatStart(delay)
	phase2started = false
	self:RegisterShortTermEvents(
		"SWING_DAMAGE",
		"SWING_MISSED"
	)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(22841, L.name)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SWING_DAMAGE(_, sourceName)
	if sourceName == L.name and not phase2started then
		self:UnregisterShortTermEvents()
		phase2started = true
		warnPhase2:Show()
	end
end
mod.SWING_MISSED = mod.SWING_DAMAGE

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 22841 then
		DBM:EndCombat(self)
	end
end
