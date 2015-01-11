local mod	= DBM:NewMod("Bloodboil", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(22948)
mod:SetModelID(21443)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE"
)

local warnBlood			= mod:NewTargetAnnounce(42005, 3)
local warnWound			= mod:NewStackAnnounce(40481, 2)
local warnStrike		= mod:NewTargetAnnounce(40491, 3)
local warnRage			= mod:NewTargetAnnounce(40604, 4)
local warnRageSoon		= mod:NewSoonAnnounce(40604, 3)
local warnRageEnd		= mod:NewEndAnnounce(40604, 4)

local specWarnBlood		= mod:NewSpecialWarningYou(42005)
local specWarnRage		= mod:NewSpecialWarningYou(40604)

local timerBlood		= mod:NewCDTimer(10, 42005)
local timerWound		= mod:NewTargetTimer(60, 40481)
local timerStrikeCD		= mod:NewCDTimer(30, 40491)
local timerRage			= mod:NewCDTimer(52, 40604)
local timerRageEnd		= mod:NewBuffActiveTimer(28, 40604)

local berserkTimer		= mod:NewBerserkTimer(600)

local warnBloodTargets = {}
local rage = false

local function nextRage()
	rage = false
	warnRageEnd:Show()
	timerRage:Start()
	warnRageSoon:Schedule(47)
	timerBlood:Start(11.5)
	table.wipe(warnBloodTargets)
end

local function showBlood()
	warnBlood:Show(table.concat(warnBloodTargets, "<, >"))
	table.wipe(warnBloodTargets)
	timerBlood:Start()
end

function mod:OnCombatStart(delay)
	rage = false
	berserkTimer:Start(-delay)
	warnRageSoon:Schedule(47-delay)
	timerBlood:Start(11.5-delay)
	timerStrikeCD:Start(37-delay)
	timerRage:Start(-delay)
	table.wipe(warnBloodTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 42005 then
		warnBloodTargets[#warnBloodTargets + 1] = args.destName
		self:Unschedule(showBlood)
		if #warnBloodTargets >= 6 then
			showBlood()
		else
			self:Schedule(0.8, showBlood)
		end
		if args:IsPlayer() then
			specWarnBlood:Show()
		end
	elseif args.spellId == 40481 and not rage then
		local amount = args.amount or 1
		if (amount == 1) or (amount % 3 == 0) then
			warnWound:Show(args.destName, amount)
			timerWound:Show(args.destName)
		end
	elseif args.spellId == 40491 then
		warnStrike:Show(args.destName)
		timerStrikeCD:Start()
	elseif args.spellId == 40604 then
		rage = true
		warnRage:Show(args.destName)
		timerBlood:Cancel()
		timerRageEnd:Start()
		self:Schedule(28, nextRage)
		if args:IsPlayer() then
			specWarnRage:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
