local mod	= DBM:NewMod("Chromaggus", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 502 $"):sub(12, -3))
mod:SetCreatureID(14020)
mod:SetModelID(14367)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
--	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH target focus mouseover"
)

local warnBreath		= mod:NewAnnounce("WarnBreath", 2, 23316)
local warnRed			= mod:NewSpellAnnounce(23155, 2, nil, false)
local warnGreen			= mod:NewSpellAnnounce(23169, 2, nil, false)
local warnBlue			= mod:NewSpellAnnounce(23153, 2, nil, false)
local warnBlack			= mod:NewSpellAnnounce(23154, 2, nil, false)
local warnBronze		= mod:NewSpellAnnounce(23170, 4)
local warnEnrage		= mod:NewSpellAnnounce(23128)
local warnPhase2Soon	= mod:NewPrePhaseAnnounce(2, 1)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnBronze	= mod:NewSpecialWarningYou(23170)

local timerBreathCD		= mod:NewTimer(60, "TimerBreathCD", 23316)
local timerEnrage		= mod:NewBuffActiveTimer(8, 23128)

local prewarn_P2 = false

function mod:OnCombatStart(delay)
	timerBreathCD:Start(30-delay, L.Breath1)
	timerBreathCD:Start(-delay, L.Breath2)
	prewarn_P2 = false
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(23309, 23313, 23189, 23316) or args.spellId == 23312 then
		warnBreath:Show(args.spellName)
		timerBreathCD:Start(args.spellName)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 23155 and self:AntiSpam(3, 1) then
		warnRed:Show()
	elseif args.spellId == 23169 and self:AntiSpam(3, 2) then
		warnGreen:Show()
	elseif args.spellId == 23153 and self:AntiSpam(3, 3) then
		warnBlue:Show()
	elseif args.spellId == 23154 and self:AntiSpam(3, 4) then
		warnBlack:Show()
	elseif args.spellId == 23170 then
		if args:IsPlayer() then
			specWarnBronze:Show()
		end
		if self:AntiSpam(3, 5) then
			warnBronze:Show()
		end
	elseif args.spellId == 23128 then
		warnEnrage:Show()
		timerEnrage:Start()
	elseif args.spellId == 23537 then
		warnPhase2:Show()
	end
end

--Possibly needed hard to say. 
--mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 23128 then
		timerEnrage:Cancel()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 14020 and not prewarn_P2 then
		warnPhase2Soon:Show()
		prewarn_P2 = true
	end
end
