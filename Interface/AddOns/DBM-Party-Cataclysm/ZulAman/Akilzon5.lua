﻿local mod	= DBM:NewMod(186, "DBM-Party-Cataclysm", 10, 77)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7759 $"):sub(12, -3))
mod:SetCreatureID(23574)
mod:SetModelID(21630)
mod:SetZone()
mod:SetUsedIcons(1, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnStorm			= mod:NewTargetAnnounce(43648, 4)
local warnStormSoon		= mod:NewSoonAnnounce(43648, 5, 3)
local warnPlucked		= mod:NewTargetAnnounce(97318, 3)

local specWarnStorm		= mod:NewSpecialWarningSpell(43648)

local timerStorm		= mod:NewCastTimer(8, 43648)
local timerStormCD		= mod:NewCDTimer(55, 43648)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("StormIcon", true)
mod:AddBoolOption("StormArrow", true)
mod:AddBoolOption("SetIconOnEagle", true)

local eagleGUID = nil

mod:RegisterOnUpdateHandler(function(self)
	if self.Options.SetIconOnEagle and eagleGUID then
		for i = 0, GetNumGroupMembers() do
			local uId = (i == 0 and "target") or "party"..i.."target"
			local guid = UnitGUID(uId)
			if guid == eagleGUID then
				SetRaidTarget(uId, 8)
				eagleGUID = nil
			end
		end
	end
end, 1)

function mod:OnCombatStart(delay)
	warnStormSoon:Schedule(43)
	timerStormCD:Start(48)
	berserkTimer:Start(-delay)
	eagleGUID = nil
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(6)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(97318) then
		if args:IsDestTypePlayer() then
			warnPlucked:Show(args.destName)	
		else
			eagleGUID = args.destGUID
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(43648) then
		warnStorm:Show(args.destName)
		specWarnStorm:Show()
		timerStorm:Start()
		warnStormSoon:Schedule(50)
		timerStormCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
			mod:Schedule(10, function()
				DBM.RangeCheck:Show(6)
			end)
		end
		if self.Options.StormIcon then
			self:SetIcon(args.destName, 1, 8)
		end
		if self.Options.StormArrow then
			DBM.Arrow:ShowRunTo(args.destName, 0, 0, 8)
		end
	end
end

