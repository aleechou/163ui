local mod	= DBM:NewMod("GrandMagusTelestra", "DBM-Party-WotLK", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 3369 $"):sub(12, -3))
mod:SetCreatureID(26731)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"UNIT_HEALTH",
	"CHAT_MSG_MONSTER_YELL"
)

local warningSplitSoon	= mod:NewAnnounce("WarningSplitSoon", 2)
local warningSplitNow	= mod:NewAnnounce("WarningSplitNow", 3)
local warningMerge		= mod:NewAnnounce("WarningMerge", 2)

local warnedSplit1		= false
local warnedSplit2		= false

function mod:OnCombatStart()
	warnedSplit1 = false
	warnedSplit2 = false
end

function mod:UNIT_HEALTH(uId)
	if not warnedSplit1 and self:GetUnitCreatureId(uId) == 26731 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.58 then
		warnedSplit1 = true
		warningSplitSoon:Show()
	elseif not warnedSplit2 and mod:IsDifficulty("heroic5") and self:GetUnitCreatureId(uId) == 26731 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.19 then
		warnedSplit2 = true
		warningSplitSoon:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.SplitTrigger1 or msg == L.SplitTrigger2 then
		warningSplitNow:Show()
	elseif msg == L.MergeTrigger then
		warningMerge:Show()
	end
end
