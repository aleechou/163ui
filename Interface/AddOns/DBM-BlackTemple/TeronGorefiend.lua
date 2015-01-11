local mod	= DBM:NewMod("TeronGorefiend", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 535 $"):sub(12, -3))
mod:SetCreatureID(22871)
mod:SetModelID(21254)
mod:SetZone()
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS"
)

local warnCrushed			= mod:NewTargetAnnounce(40243, 3)
local warnIncinerate		= mod:NewTargetAnnounce(40239, 3)
local warnDeath				= mod:NewTargetAnnounce(40251, 3)

local specWarnDeath			= mod:NewSpecialWarningYou(40251)

local timerCrushed			= mod:NewBuffActiveTimer(15, 40243)
local timerDeath			= mod:NewTargetTimer(55, 40251)
local timerVengefulSpirit	= mod:NewTimer(60, "TimerVengefulSpirit", 40325)

mod:AddBoolOption("CrushIcon", false)

local warnCrushedTargets = {}
local crushIcon = 8

local function showCrushedTargets()
	warnCrushed:Show(table.concat(warnCrushedTargets, "<, >"))
	table.wipe(warnCrushedTargets)
	crushIcon = 8
end

function mod:OnCombatStart(delay)
	table.wipe(warnCrushedTargets)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 40243 then
		warnCrushedTargets[#warnCrushedTargets + 1] = args.destName
		timerCrushed:Start()
		self:Unschedule(showCrushedTargets)
		if self.Options.CrushIcon then
			self:SetIcon(args.destName, crushIcon, 15)
			crushIcon = crushIcon - 1
		end
		if #warnCrushedTargets >= 5 then
			showCrushedTargets()
		else
			self:Schedule(0.3, showCrushedTargets)
		end
	elseif args.spellId == 40251 then
		warnDeath:Show(args.destName)
		timerDeath:Start(args.destName)
		timerVengefulSpirit:Schedule(55, args.destName)
		if args:IsPlayer() then
			specWarnDeath:Show()
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 40243 then
		if self.Options.CrushIcon then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 40239 then
		warnIncinerate:Show(args.destName)
	end
end
