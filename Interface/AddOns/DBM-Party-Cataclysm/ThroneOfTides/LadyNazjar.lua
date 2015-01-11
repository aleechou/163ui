local mod	= DBM:NewMod(101, "DBM-Party-Cataclysm", 9, 65)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(40586)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH"
)

local warnWaterspout		= mod:NewSpellAnnounce(75863, 3)
local warnWaterspoutSoon	= mod:NewSoonAnnounce(75863, 2)
local warnShockBlast		= mod:NewSpellAnnounce(76008, 1, nil, false)
local warnGeyser			= mod:NewSpellAnnounce(75722, 3)
local warnFungalSpores		= mod:NewTargetAnnounce(80564, 3)

local timerWaterspout		= mod:NewBuffActiveTimer(60, 75863)
local timerShockBlast		= mod:NewCastTimer(3, 76008)
local timerShockBlastCD		= mod:NewCDTimer(13, 76008)
local timerGeyser			= mod:NewCastTimer(5, 75722)
local timerFungalSpores		= mod:NewBuffFadesTimer(15, 80564)

local specWarnShockBlast	= mod:NewSpecialWarningInterrupt(76008)

local sporeTargets = {}
local sporeCount = 0
local preWarnedWaterspout = false

function mod:OnCombatStart()
	table.wipe(sporeTargets)
	sporeCount = 0
	preWarnedWaterspout = false
end

local function showSporeWarning()
	warnFungalSpores:Show(table.concat(sporeTargets, "<, >"))
	table.wipe(sporeTargets)
	timerFungalSpores:Start()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 80564 then
		sporeCount = sporeCount + 1
		sporeTargets[#sporeTargets + 1] = args.destName
		self:Unschedule(showSporeWarning)
		self:Schedule(0.3, showSporeWarning)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 75690 then
		timerWaterspout:Cancel()
		timerShockBlastCD:Start(13)
	elseif args.spellId == 80564 then
		sporeCount = sporeCount - 1
		if sporeCount == 0 then
			timerFungalSpores:Cancel()
		end	
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 75863 then
		warnWaterspout:Show()
		timerWaterspout:Start()
		timerShockBlastCD:Cancel()
	elseif args.spellId == 76008 then
		warnShockBlast:Show()
		specWarnShockBlast:Show(args.sourceName)
		timerShockBlastCD:Start()
		if self:IsDifficulty("heroic5") then
			timerShockBlast:Start(2)
		else
			timerShockBlast:Start()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(75700, 75722) then
		warnGeyser:Show()
		timerGeyser:Start()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitName(uId) == L.name then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if (h > 80) or (h > 45 and h < 60) then
			preWarnedWaterspout = false
		elseif (h < 75 and h > 72 or h < 41 and h > 38) and not preWarnedWaterspout then
			preWarnedWaterspout = true
			warnWaterspoutSoon:Show()
		end
	end
end