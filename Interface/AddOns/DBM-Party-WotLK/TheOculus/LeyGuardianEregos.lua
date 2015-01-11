local mod	= DBM:NewMod(625, "DBM-Party-WotLK", 9, 282)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 112 $"):sub(12, -3))
mod:SetCreatureID(27656)
mod:SetEncounterID(534, 535)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED"
)

local warningShift		= mod:NewSpellAnnounce(51162, 4)
local warningShiftEnd	= mod:NewEndAnnounce(51162, 1)
local warningEnraged	= mod:NewSpellAnnounce(51170, 3)
local timerEnraged		= mod:NewBuffActiveTimer(12, 51170)
local timerShift		= mod:NewBuffActiveTimer(18, 51162)


function mod:OnCombatEnd(wipe)
	if not wipe then
		if DBM.Bars:GetBar(L.MakeitCountTimer) then
			DBM.Bars:CancelBar(L.MakeitCountTimer) 
		end	
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 51162 then
		warningShift:Show()
		warningShiftEnd:Schedule(13)
		timerShift:Start()
	elseif args.spellId == 51170 then
		warningEnraged:Show()
		timerEnraged:Start()
	end
end