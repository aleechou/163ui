local mod	= DBM:NewMod(100, "DBM-Party-Cataclysm", 6, 64)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(46964)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnMortalWound			= mod:NewStackAnnounce(93675, 2, nil, mod:IsTank() or mod:IsHealer())
local warnGhouls				= mod:NewSpellAnnounce(93707, 4)
local warnCursedBullets			= mod:NewTargetAnnounce(93629, 3)
local warnPistolBarrage			= mod:NewSpellAnnounce(93520, 4)

local specWarnMortalWound		= mod:NewSpecialWarningStack(93675, nil, 5)

local timerMortalWound			= mod:NewTargetTimer(6, 93675)
local timerGhouls				= mod:NewNextTimer(30, 93707)
local timerPistolBarrage		= mod:NewBuffActiveTimer(6, 93520)
local timerPistolBarrageNext	= mod:NewNextTimer(30, 93520)
local timerCursedBullets		= mod:NewTargetTimer(15, 93629)

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 93675 then
		warnMortalWound:Show(args.destName, args.amount or 1)
		timerMortalWound:Start(args.destName)
		if args:IsPlayer() and (args.amount or 1) >= 5 then
			specWarnMortalWound:Show(args.amount)
		end
	elseif args.spellId == 93707 then
		warnGhouls:Show()
		timerGhouls:Start()
	elseif args.spellId == 93629 then
		warnCursedBullets:Show(args.destName)
		timerCursedBullets:Start(args.destName)
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 93629 then
		timerCursedBullets:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 93520 then
		warnPistolBarrage:Show()
		timerPistolBarrage:Start()
		timerPistolBarrageNext:Start()
	end
end