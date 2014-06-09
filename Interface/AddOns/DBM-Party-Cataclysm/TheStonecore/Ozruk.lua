local mod	= DBM:NewMod(112, "DBM-Party-Cataclysm", 7, 67)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(42188)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warnShatterSoon		= mod:NewSoonAnnounce(78807, 3)
local warnShatter			= mod:NewSpellAnnounce(78807, 4)
local warnBulwark			= mod:NewSpellAnnounce(78939, 3)
local warnGroundSlam		= mod:NewCastAnnounce(78903, 4)
local warnEnrage			= mod:NewSpellAnnounce(80467, 3)
local warnEnrageSoon		= mod:NewSoonAnnounce(80467, 2)

local specWarnGroundSlam	= mod:NewSpecialWarningMove(78903, mod:IsTank())
local specWarnShatter		= mod:NewSpecialWarningRun(78807, mod:IsMelee())

--local timerShatterCD		= mod:NewCDTimer(19, 78807)
local timerBulwark			= mod:NewBuffActiveTimer(10, 78939)
local timerBulwarkCD		= mod:NewCDTimer(20, 78939)
local timerGroundSlam		= mod:NewCastTimer(3, 78903)
local timerShatter			= mod:NewCastTimer(3, 78807)

local soundShatter			= mod:NewSound(78807, nil, mod:IsMelee())

local prewarnEnrage = false

function mod:OnCombatStart(delay)
	prewarnEnrage = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 80467 then
		warnEnrage:Show()
	elseif args.spellId == 78939 then
		warnBulwark:Show()
		timerBulwark:Start()
		timerBulwarkCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 78939 then--This can be dispelled.
		timerBulwark:Cancel()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 78807 then
		warnShatter:Show()
		timerShatter:Start()
--		timerShatterCD:Start()
		specWarnShatter:Show()
		soundShatter:Play()
	elseif args.spellId == 92426 then
		warnShatterSoon:Show()
	elseif args.spellId == 78903 then
		warnGroundSlam:Show()
		specWarnGroundSlam:Show()
		timerGroundSlam:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId)
		if h > 75 and prewarnEnrage then
			prewarnEnrage = false
		elseif h > 33 and h < 37 and not prewarnEnrage then
			warnEnrageSoon:Show()
			prewarnEnrage = true
		end
	end
end