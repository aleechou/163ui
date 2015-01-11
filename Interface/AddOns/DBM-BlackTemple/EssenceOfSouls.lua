local mod	= DBM:NewMod("Souls", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 535 $"):sub(12, -3))
mod:SetCreatureID(23420)
mod:SetModelID(21483)
mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnFixate		= mod:NewTargetAnnounce(41294, 3)
local warnDrain			= mod:NewTargetAnnounce(41303, 3)
local warnEnrage		= mod:NewSpellAnnounce(41305, 4, 41292)
local warnEnrageSoon	= mod:NewPreWarnAnnounce(41305, 5, 3)
local warnEnrageEnd		= mod:NewEndAnnounce(41305, 3)
local warnPhase2		= mod:NewPhaseAnnounce(2)
local warnMana			= mod:NewAnnounce("WarnMana", 4, 41350)
local warnDeaden		= mod:NewTargetAnnounce(41410, 3)
local warnShockCast		= mod:NewSpellAnnounce(41426, 3, false)
local warnShield		= mod:NewSpellAnnounce(41431, 3)
local warnPhase3		= mod:NewPhaseAnnounce(3)
local warnSoul			= mod:NewSpellAnnounce(41545, 3)
local warnSpite			= mod:NewSpellAnnounce(41376, 3)

local specWarnShock		= mod:NewSpecialWarningInterrupt(41426, mod:IsMelee())
local specWarnShield	= mod:NewSpecialWarningDispel(41431)
local specWarnSpite		= mod:NewSpecialWarningYou(41376)

local timerEnrage		= mod:NewBuffActiveTimer(15, 41305)
local timerNextEnrage	= mod:NewNextTimer(32, 41305)
local timerDeaden		= mod:NewTargetTimer(10, 41410)
local timerNextDeaden	= mod:NewCDTimer(31, 41410)
local timerMana			= mod:NewTimer(160, "TimerMana", 41350)
local timerNextShield	= mod:NewCDTimer(15, 41431)
local timerNextSoul		= mod:NewCDTimer(10, 41545)
local timerNextShock	= mod:NewCDTimer(12, 41426)--Blizz lied, this is a 12-15 second cd. you can NOT solo interrupt these with most classes

mod:AddBoolOption("DrainIcon", false)
mod:AddBoolOption("SpiteIcon", false)

local warnDrainTargets = {}
local warnSpiteTargets = {}
local lastFixate = false
local drainIcon = 8
local spiteIcon = 8

local function showDrain()
	warnDrain:Show(table.concat(warnDrainTargets, "<, >"))
	table.wipe(warnDrainTargets)
	drainIcon = 8
end

local function showSpite()
	warnSpite:Show(table.concat(warnSpiteTargets, "<, >"))
	table.wipe(warnSpiteTargets)
	spiteIcon = 8
end

function mod:OnCombatStart(delay)
	lastFixate = false
	table.wipe(warnSpiteTargets)
	timerNextEnrage:Start(47-delay)
	warnEnrageSoon:Schedule(42-delay)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(23418, L.Suffering)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41305 then
		warnEnrage:Show()
		timerEnrage:Start()
	elseif args.spellId == 41431 and not args:IsDestTypePlayer() then
		warnShield:Show()
		timerNextShield:Start()
		specWarnShield:Show(args.destName)
	elseif args.spellId == 41376 then
		warnSpiteTargets[#warnSpiteTargets + 1] = args.destName
		self:Unschedule(showSpite)
		if self.Options.SpiteIcon then
			self:SetIcon(args.destName, spiteIcon)
			spiteIcon = spiteIcon - 1
		end
		if args:IsPlayer() then
			specWarnSpite:Show()
		end
		self:Schedule(0.3, showSpite)
	elseif args.spellId == 41303 then
		warnDrainTargets[#warnDrainTargets + 1] = args.destName
		self:Unschedule(showDrain)
		if self.Options.DrainIcon then
			self:SetIcon(args.destName, drainIcon)
			drainIcon = drainIcon - 1
		end
		self:Schedule(1, showDrain)
	elseif args.spellId == 41294 then
		if lastFixate ~= args.destName then
			warnFixate:Show(args.destName)
			lastFixate = args.destName
		end
	elseif args.spellId == 41410 then
		warnDeaden:Show(args.destName)
		timerDeaden:Start(args.destName)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 41305 then
		warnEnrageEnd:Show()
		warnEnrageSoon:Schedule(27)
		timerNextEnrage:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 41410 then
		timerNextDeaden:Start()
	elseif args.spellId == 41426 then
		warnShockCast:Show()
		timerNextShock:Start()
		if self:GetUnitCreatureId("target") == 23419 or self:GetUnitCreatureId("focus") == 23419 then
			specWarnShock:Show(args.sourceName)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 41350 then --Aura of Desire
		warnPhase2:Show()
		warnMana:Schedule(130)
		timerMana:Start()
		timerNextShield:Start(13)
		timerNextDeaden:Start(28)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(23419, L.Desire)
		end
	elseif args.spellId == 41337 then --Aura of Anger
		warnPhase3:Show()
		timerNextSoul:Start()
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(23450, L.Anger)
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, _, _, _, spellId)
	if spellId == 41545 and self:AntiSpam(3, 1) then
		warnSoul:Show()
		timerNextSoul:Start()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 28819 and self:AntiSpam(2, 2) then--Submerge Visual
		self:SendSync("PhaseEnd")
	end
end

function mod:OnSync(msg)
	if msg == "PhaseEnd" then
		warnEnrageEnd:Cancel()
		warnEnrageSoon:Cancel()
		warnMana:Cancel()
		timerNextEnrage:Cancel()
		timerEnrage:Cancel()
		timerMana:Cancel()
		timerNextShield:Cancel()
		timerNextDeaden:Cancel()
		timerNextShock:Cancel()
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
		end
	end
end
