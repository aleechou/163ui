local mod	= DBM:NewMod(105, "DBM-Party-Cataclysm", 1, 66)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(39665)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"UNIT_HEALTH"
)

local warnWoundingStrike	= mod:NewTargetAnnounce(75571, 2)
local warnQuake				= mod:NewSpellAnnounce(75272, 3)
local warnChainsWoeSoon		= mod:NewSoonAnnounce(75539, 3)
local warnChainsWoe			= mod:NewSpellAnnounce(75539, 4)

local timerWoundingStrike	= mod:NewTargetTimer(6, 75571)
local timerQuake			= mod:NewCastTimer(3, 75272)
local timerQuakeCD			= mod:NewCDTimer(19, 75272)
local timerSkullcracker		= mod:NewCastTimer(12, 75543)

local warnedChains
function mod:OnCombatStart(delay)
	timerQuakeCD:Start(-delay)
	warnedChains = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 75571 then
		warnWoundingStrike:Show(args.destName)
		if self:IsDifficulty("heroic5") then
			timerWoundingStrike:Start(10, args.destName)
		else
			timerWoundingStrike:Start(args.destName)
		end
		timerWoundingStrike:Start(args.destName)
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 75272 then
		warnQuake:Show()
		timerQuake:Start()
		timerQuakeCD:Start()
	elseif args.spellId == 75539 then
		warnChainsWoe:Show()
	elseif args.spellId == 75543 then
		if self:IsDifficulty("heroic5") then
			timerSkullcracker:Start(8)
		else
			timerSkullcracker:Start()
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if warnedChains and (h > 80 or h > 45 and h < 60) then
			warnedChains = false
		elseif not warnedChains and (h > 68 and h < 73 or h > 35 and h < 40) then
			warnedChains = true
			warnChainsWoeSoon:Show()
		end
	end
end
