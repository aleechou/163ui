﻿local mod	= DBM:NewMod(698, "DBM-Party-MoP", 5, 321)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(61398)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)


local warnGroundSmash		= mod:NewCastAnnounce(119684, 3)
local warnStaff				= mod:NewSpellAnnounce("ej5973", 2)
local warnRoar				= mod:NewSpellAnnounce(122959, 3, nil, mod:IsTank() or mod:IsHealer())
local warnWhirlwindingAxe	= mod:NewSpellAnnounce(119374, 4)
local warnStreamBlades		= mod:NewSpellAnnounce("ej5972", 4)
local warnCrossbowTrap		= mod:NewSpellAnnounce("ej5974", 4)

local specWarnSmash			= mod:NewSpecialWarningMove(119684, mod:IsTank())
local specWarnBlades		= mod:NewSpecialWarningMove(119311)

local timerSmashCD			= mod:NewCDTimer(28, 119684)
local timerStaffCD			= mod:NewCDTimer(23, "ej5973")--23~25 sec.
local timerWhirlwindingAxe	= mod:NewNextTimer(15, 119374)
--local timerRoarCD			= mod:NewCDTimer(48, 122959)--Need to confirm, i crashed during log and only got 2 casts, so only one CD, not enough confirmation for me.

function mod:OnCombatStart(delay)
	timerStaffCD:Start(8-delay)
	timerSmashCD:Start(9.5-delay)
	timerWhirlwindingAxe:Start(-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 119684 then
		warnGroundSmash:Show()
		specWarnSmash:Show()
		timerSmashCD:Start()
		if mod:IsTank() then
			sndWOP:Play("runaway")--快躲開
		else
			sndWOP:Play("shockwave")--震懾波
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 122959 then
		warnRoar:Show()
--		timerRoarCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 120109 then
		warnStaff:Show()
		timerStaffCD:Start()
	elseif spellId == 120083 then
		warnWhirlwindingAxe:Show()
	elseif spellId == 120094 then
		warnStreamBlades:Show()
	elseif spellId == 120139 then
		warnCrossbowTrap:Show()
	end
end

--[[
Notes
1a. This boss has a LOT of traps that do not show in combat log, as a result, the mod will be incomplete until we have transcriptor logs
1b. If transcriptor doesn't show cast events, then we can use locals i guess from emotes.
1c. i'd rathor wait til mods are enabled and do it a non localized way first.
5/2 14:32:02.158  Xin the Weaponmaster activates his Whirlwinding Axe trap!
5/2 14:32:50.293  Xin the Weaponmaster activates his Stream of Blades trap!
--]]

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 119311 and destGUID == UnitGUID("player") and self:AntiSpam(2, 5) then
		specWarnBlades:Show()
		sndWOP:Play("runaway")--快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE