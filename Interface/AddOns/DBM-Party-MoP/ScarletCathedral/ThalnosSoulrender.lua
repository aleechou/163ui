local mod	= DBM:NewMod(688, "DBM-Party-MoP", 9, 316)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(59789)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)


local warnEvictSoul				= mod:NewTargetAnnounce(115297, 3)
local warnRaiseCrusade			= mod:NewSpellAnnounce(115139, 3)
local warnSummonSpirits			= mod:NewSpellAnnounce(115147, 4)
local warnEmpowerZombie			= mod:NewSpellAnnounce(115250, 4)

local specWarnFallenCrusader	= mod:NewSpecialWarningSwitch("ej5863", not mod:IsHealer())--Need more data, nots sure if they are meaningful enough to kill or ignore.
local specWarnEmpoweredSpirit	= mod:NewSpecialWarningSwitch("ej5869", not mod:IsHealer())--These need to die before they become zombies. Cannot see a way in combat log to detect target, i'll have to watch for target scanning next time to warn that player to run away from dead crusaders.
local specWarnWind				= mod:NewSpecialWarningMove(115291)  --voice


local timerEvictSoul			= mod:NewTargetTimer(6, 115297)
local timerEvictSoulCD			= mod:NewCDTimer(41, 115297)
local timerRaiseCrusadeCD		= mod:NewNextTimer(60, 115139)--Both of these are 40 second cds in challenge modes
local timerSummonSpiritsCD		= mod:NewNextTimer(60, 115147)--Although correction is only needed in one spot

function mod:OnCombatStart(delay)
	timerRaiseCrusadeCD:Start(6-delay)
	sndWOP:Schedule(5, "mobsoon")--準備小怪
	timerEvictSoulCD:Start(15.5-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(115297, 116648) then
		warnEvictSoul:Show(args.destName)
		timerEvictSoul:Start(args.destName)
		if mod:IsHealer() then
			sndWOP:Play("dispelnow")--快驅散
		end
	elseif args:IsSpellID(115297, 116648) and args:IsPlayer() and self:AntiSpam() then
		specWarnWind:Show()
		sndWOP:Play("runaway")--快躲開
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(115297, 116648) then
		timerEvictSoul:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 115297 then--Trigger CD off success, since we can resist it. do NOT add ID 115548, it's a similcast to 115297
		timerEvictSoulCD:Start()
	elseif args.spellId == 115147 then--Summon Empowering Spirits
		warnSummonSpirits:Show()
		specWarnEmpoweredSpirit:Show()
		sndWOP:Play("killspirit") --靈魂快打
		timerRaiseCrusadeCD:Start(20)--Raise crusaders always 20 seconds after spirits in all modes
		sndWOP:Schedule(19, "mobsoon") --準備小怪
	elseif args.spellId == 115139 then--Raise Fallen Crusade
		warnRaiseCrusade:Show()
		specWarnFallenCrusader:Show()
		if self:IsDifficulty("challenge5") then
			timerSummonSpiritsCD:Start(20)
		else
			timerSummonSpiritsCD:Start(40)
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 115250 then--Empower Zombie (used by empowering Spirits on fallen Crusaders to make them hulking hard hitting zombies)
		warnEmpowerZombie:Show()
	end
end