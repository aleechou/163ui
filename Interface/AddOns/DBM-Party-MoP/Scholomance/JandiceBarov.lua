﻿local mod	= DBM:NewMod(663, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(59184)--59220 seem to be her mirror images
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnWondrousRapidity		= mod:NewSpellAnnounce(114062, 3)
local warnGravityFlux			= mod:NewTargetAnnounce(114059, 2)
local warnWhirlofIllusion		= mod:NewSpellAnnounce(113808, 4)

local specWarnWondrousRapdity	= mod:NewSpecialWarningMove(114062, mod:IsTank())--Frontal cone fixate attack, easily dodged (in fact if you don't, i imagine it'll wreck you on heroic)

local timerWondrousRapidity		= mod:NewBuffFadesTimer(7.5, 114062)
local timerWondrousRapidityCD	= mod:NewNextTimer(14, 114062)
local timerGravityFlux			= mod:NewCDTimer(12, 114059) -- needs more review.

function mod:GravityFluxTarget()
	local targetname = self:GetBossTarget(59184)
	if not targetname then return end
	warnGravityFlux:Show(targetname)
	if (targetname == UnitName("player")) and (not mod:IsTank()) then
		sndWOP:Play("runaway")--快躲開
	end
end

function mod:OnCombatStart(delay)
	timerWondrousRapidityCD:Start(6-delay)
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 114062 then
		timerWondrousRapidityCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 114062 then
		warnWondrousRapidity:Show()
		specWarnWondrousRapdity:Show()
		timerWondrousRapidity:Start()
		if mod:IsTank() then
			sndWOP:Play("runaway")--快躲開
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 114059 or spellId == 114047) and self:AntiSpam(2, 1) then -- found 2 spellids on first cast, 4 spellids total (114035, 114038, 114047, 114059). needs more logs to confirm whether spellid is correct.
		self:ScheduleMethod(0.1, "GravityFluxTarget")
		timerGravityFlux:Start()
	elseif spellId == 113808 and self:AntiSpam(2, 2) then
		warnWhirlofIllusion:Show()
		timerGravityFlux:Cancel()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)--120037 is a weak version of same spell by exit points, 115219 is the 50k per second icewall that will most definitely wipe your group if it consumes the room cause you're dps sucks.
	if spellId == 114062 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnWondrousRapdity:Show()
		sndWOP:Play("runaway")--快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE