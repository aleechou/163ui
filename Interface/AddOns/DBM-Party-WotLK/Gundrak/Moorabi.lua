local mod	= DBM:NewMod(594, "DBM-Party-WotLK", 5, 274)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(29305)
mod:SetEncounterID(387, 388)
--mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"UNIT_HEALTH boss1 target focus mouseover"
)

local warningTransform	= mod:NewSpellAnnounce(55098, 3)
local timerTransform	= mod:NewCDTimer(10, 55098)--experimental

local lowHealth

function mod:OnCombatStart()
	lowHealth = nil
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 55098 then
		warningTransform:Show()
		if lowHealth then
			timerTransform:Start(5) --cast every 5 seconds below 50% health
		else
			timerTransform:Start() --cast every 10 seconds above 50% health
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 29305 then
		if UnitHealth(uId) / UnitHealthMax(uId) <= 0.50 then
			lowHealth = true
		else
			lowHealth = nil -- just in case the combat detection doesn't work
		end
	end
end
