﻿local mod	= DBM:NewMod(826, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 10466 $"):sub(12, -3))
mod:SetCreatureID(69161)
mod:SetReCombatTime(20)
mod:SetQuestID(32519)
mod:SetZone()
mod:SetMinSyncRevision(10466)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnCrush					= mod:NewStackAnnounce(137504, 2, nil, mod:IsTank() or mod:IsHealer())--Cast every 30 seconds roughly, lasts 1 minute. you need 3 tanks to be able to tank the boss without debuff. 2 tanks CAN do but they will always have 1 stack and take 25% more damage
local warnPiercingRoar			= mod:NewSpellAnnounce(137457, 2)
local warnSpiritfireBeam		= mod:NewTargetAnnounce(137511, 3)
local warnFrillBlast			= mod:NewSpellAnnounce(137505, 4, nil, mod:IsTank() or mod:IsHealer())

local specWarnCrush				= mod:NewSpecialWarningStack(137504, mod:IsTank(), 2)
local specWarnCrushOther		= mod:NewSpecialWarningTarget(137504, mod:IsTank())
local specWarnPiercingRoar		= mod:NewSpecialWarningCast(137457, mod:IsRanged() or mod:IsHealer())
local specWarnFrillBlast		= mod:NewSpecialWarningSpell(137505, nil, nil, nil, 2)

local timerCrush				= mod:NewTargetTimer(60, 137504, nil, mod:IsTank() or mod:IsHealer())
local timerCrushCD				= mod:NewCDTimer(26, 137504)
local timerPiercingRoarCD		= mod:NewCDTimer(25, 137457)--25-60sec variation (i'm going to guess like all the rest of the variations, the timers are all types of fucked up when the boss is running around untanked, which delays casts of crush and frill blast, but makes him cast spitfire twice as often)
local timerFrillBlastCD			= mod:NewCDTimer(25, 137505)--25-30sec variation

mod:AddBoolOption("RangeFrame", true)

local yellTriggered = false

function mod:OnCombatStart(delay)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
--		timerCrushCD:Start(-delay)--There was no tank, so he pretty much never cast this, just ran like a wild animal around area while corpse cannoned
		timerPiercingRoarCD:Start(20-delay)
		timerFrillBlastCD:Start(40-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)--range is guessed. spell tooltip and EJ do not save what range is right now.
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	yellTriggered = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 137457 then
		warnPiercingRoar:Show()
		specWarnPiercingRoar:Show()
		timerPiercingRoarCD:Start()
		if mod:IsManaUser() and mod:IsRanged() then
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\stopcast.mp3") --停止施法
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		end
	elseif args.spellId == 137505 then
		warnFrillBlast:Show()
		specWarnFrillBlast:Show()
		timerFrillBlastCD:Start()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\watchwave.mp3") --衝擊波
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(137508, 137511) then
		warnSpiritfireBeam:Show(args.destName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 137504 then
		warnCrush:Show(args.destName, args.amount or 1)
		timerCrush:Start(args.destName)
		timerCrushCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 2 then
			specWarnCrush:Show(args.amount)
		else
			if (args.amount or 1) >= 2 and not UnitIsDeadOrGhost("player") or not UnitDebuff("player", GetSpellInfo(137504)) then
				specWarnCrushOther:Show(args.destName)
				if mod:IsTank() then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 137504 then
		timerCrush:Cancel(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 69161 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 69161 then--Whole zone gets yell, so lets not engage combat off yell unless he is our target (or the target of our target for healers)
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end

