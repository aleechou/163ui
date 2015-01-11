local mod	= DBM:NewMod("LordMarrowgar", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))
mod:SetCreatureID(36612)
mod:SetEncounterID(1101)
mod:SetModelID(31119)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 69076",
	"SPELL_AURA_REMOVED 69065 69076",
	"SPELL_CAST_START 69057",
	"SPELL_PERIODIC_DAMAGE 69146",
	"SPELL_PERIODIC_MISSED 69146",
	"SPELL_SUMMON 69062 72669 72670"
)

local preWarnWhirlwind   	= mod:NewSoonAnnounce(69076, 3)
local warnBoneSpike			= mod:NewCastAnnounce(69057, 2)
local warnImpale			= mod:NewTargetAnnounce(72669, 3)

local specWarnColdflame		= mod:NewSpecialWarningMove(69146)
local specWarnWhirlwind		= mod:NewSpecialWarningRun(69076, nil, nil, nil, 4)

local timerBoneSpike		= mod:NewCDTimer(18, 69057)
local timerWhirlwindCD		= mod:NewCDTimer(90, 69076)
local timerWhirlwind		= mod:NewBuffActiveTimer(20, 69076)
local timerBoned			= mod:NewAchievementTimer(8, 4610)

local berserkTimer			= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconOnImpale", true)

local impaleIcon	= 8

function mod:OnCombatStart(delay)
	preWarnWhirlwind:Schedule(40-delay)
	timerWhirlwindCD:Start(45-delay)
	timerBoneSpike:Start(15-delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69076 then						-- Bone Storm (Whirlwind)
		specWarnWhirlwind:Show()
		timerWhirlwindCD:Start()
		preWarnWhirlwind:Schedule(85)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerWhirlwind:Show(25)						-- Approx 30seconds on heroic
		else
			timerWhirlwind:Show()						-- Approx 20seconds on normal.
			timerBoneSpike:Cancel()						-- He doesn't do Bone Spike Graveyard during Bone Storm on normal
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69065 then						-- Impaled
		if self.Options.SetIconOnImpale then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 69076 then
		if self:IsDifficulty("normal10", "normal25") then
			timerWhirlwind:Cancel()
			timerBoneSpike:Start(15)					-- He will do Bone Spike Graveyard 15 seconds after whirlwind ends on normal
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69057 then	-- Bone Spike Graveyard
		warnBoneSpike:Show()
		timerBoneSpike:Start()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 69146 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnColdflame:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(69062, 72669, 72670) then			-- Impale
		warnImpale:CombinedShow(0.3, args.sourceName)
		timerBoned:Start()
		if self.Options.SetIconOnImpale then
			if impaleIcon < 1 then						-- Use a lot of icons in case bone spikes don't get killed and we need 6 instead of 3, or even all 8.
				impaleIcon = 8
			end
			self:SetIcon(args.sourceName, impaleIcon)
			impaleIcon = impaleIcon - 1
		end
	end
end
