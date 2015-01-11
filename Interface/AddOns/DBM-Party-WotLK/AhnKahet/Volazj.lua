local mod	= DBM:NewMod(584, "DBM-Party-WotLK", 1, 271)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 124 $"):sub(12, -3))
mod:SetCreatureID(29311)
mod:SetEncounterID(215, 263)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"UNIT_SPELLCAST_START target focus"
)

local warningInsanity	= mod:NewCastAnnounce(57496, 3)--Not currently working, no CLEU for it
local timerInsanity		= mod:NewCastTimer(5, 57496)--Not currently working, no CLEU for it
local timerAchieve		= mod:NewAchievementTimer(120, 1862, "TimerSpeedKill") 

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic5") then
		timerAchieve:Start(-delay)
	end
end

function mod:UNIT_SPELLCAST_START(uId, spellName)
   if spellName == GetSpellInfo(57496) then -- Insanity
   		self:SendSync("Insanity")
   end
end

function mod:OnSync(event, arg)
	if event == "Insanity" then
		warningInsanity:Show()
		timerInsanity:Start()
	end
end
