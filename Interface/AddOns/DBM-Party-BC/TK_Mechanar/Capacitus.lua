local mod = DBM:NewMod(563, "DBM-Party-BC", 13, 258)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 526 $"):sub(12, -3))

mod:SetCreatureID(19219)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnPolarity          = mod:NewCastAnnounce(39096)
local warnMagicShield       = mod:NewSpellAnnounce(35158)
local warnDamageShield      = mod:NewSpellAnnounce(35159)
local timerMagicShield      = mod:NewBuffActiveTimer(10, 35158)
local timerDamageShield     = mod:NewBuffActiveTimer(10, 35159)

local enrageTimer	= mod:NewBerserkTimer(180)

function mod:OnCombatStart(delay)
	if self:IsDifficulty("heroic5") then
        enrageTimer:Start(-delay)
    end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 39096 then          --Robo Thaddius AMG!
		warnPolarity:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 35158 then          --Magic Shield
		warnMagicShield:Show(args.destName)
		timerMagicShield:Start()
	elseif args.spellId == 35159 then      --Damage Shield
		warnDamageShield:Show(args.destName)
		timerDamageShield:Start()
	end
end