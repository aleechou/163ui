local mod	= DBM:NewMod("Brutallus", "DBM-Sunwell")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(24882)
mod:SetModelID(22711)
mod:SetMinSyncRevision(441)--Block bad pulls from old versions
mod:SetZone()
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.Pull)
mod.disableHealthCombat = true


mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_MISSED"
)

local warnMeteor		= mod:NewSpellAnnounce(45150, 3)
local warnBurn			= mod:NewTargetAnnounce(46394, 3)
local warnStomp			= mod:NewTargetAnnounce(45185, 3)

local specWarnMeteor	= mod:NewSpecialWarningStack(45150, nil, 4)
local specWarnBurn		= mod:NewSpecialWarningYou(46394)

local timerMeteorCD		= mod:NewCDTimer(12, 45150)
local timerStompCD		= mod:NewCDTimer(31, 45185)
local timerBurn			= mod:NewTargetTimer(60, 46394)
local timerBurnCD		= mod:NewCDTimer(20, 46394)

local berserkTimer		= mod:NewBerserkTimer(360)

mod:AddBoolOption("BurnIcon", true)
mod:AddBoolOption("RangeFrame", true)

local burnIcon = 8

local DebuffFilter
do
	DebuffFilter = function(uId)
		return UnitDebuff(uId, GetSpellInfo(46394))
	end
end

function mod:OnCombatStart(delay)
	burnIcon = 8
	timerBurnCD:Start(-delay)
	timerStompCD:Start(-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 46394 then
		warnBurn:Show(args.destName)
		timerBurn:Start(args.destName)
		if self:AntiSpam(19, 1) then
			timerBurnCD:Start()
		end
		if self.Options.BurnIcon then
			self:SetIcon(args.destName, burnIcon)
			if burnIcon == 1 then
				burnIcon = 8
			else
				burnIcon = burnIcon - 1
			end
		end
		if args:IsPlayer() then
			specWarnBurn:Show()
		end
		if self.Options.RangeFrame then
			if UnitDebuff("player", GetSpellInfo(46394)) then--You have debuff, show everyone
				DBM.RangeCheck:Show(4, nil)
			else--You do not have debuff, only show players who do
				DBM.RangeCheck:Show(4, DebuffFilter)
			end
		end
	elseif args.spellId == 45185 then
		warnStomp:Show(args.destName)
		timerStompCD:Start()
	elseif args.spellId == 45150 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 4 then
			specWarnMeteor:Show(amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 46394 then
		if self.Options.BurnIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 45150 then
		warnMeteor:Show()
		timerMeteorCD:Start()
	end
end

function mod:SPELL_MISSED(_, _, _, _, _, _, _, _, spellId)
	if spellId == 46394 then
		warnBurn:Show("MISSED")
		if self:AntiSpam(19, 1) then
			timerBurnCD:Start()
		end
	end
end
