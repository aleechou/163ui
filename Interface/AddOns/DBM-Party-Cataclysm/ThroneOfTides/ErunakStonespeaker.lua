local mod	= DBM:NewMod(103, "DBM-Party-Cataclysm", 9, 65)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(40825, 40788)		-- 40788 = Mindbender Ghur'sha
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warnLavaBolt			= mod:NewCastAnnounce(76171, 2)
local warnMagmaSplash		= mod:NewTargetAnnounce(76170, 3)
local warnEmberstrike		= mod:NewTargetAnnounce(76165, 3)
local warnEarthShards		= mod:NewTargetAnnounce(84931, 2)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnEnslave			= mod:NewTargetAnnounce(76207, 2)
local warnAbsorbMagic		= mod:NewSpellAnnounce(76307, 4)
local warnMindFog			= mod:NewSpellAnnounce(76234, 3)
local warnAgony				= mod:NewSpellAnnounce(76339, 3)

local timerLavaBolt			= mod:NewCastTimer(2, 76171)
local timerMagmaSplash		= mod:NewBuffActiveTimer(10, 76170)
local timerEmberstrike		= mod:NewTargetTimer(10, 76165)
local timerAbsorbMagic		= mod:NewBuffActiveTimer(3, 76307)
local timerMindFog			= mod:NewBuffActiveTimer(20, 76234)
local timerAgony			= mod:NewBuffActiveTimer(10, 76339)

local specWarnLavaBolt		= mod:NewSpecialWarningInterrupt(76171)
local specWarnAbsorbMagic	= mod:NewSpecialWarningCast(76307, nil, nil, nil, true)
local specWarnEarthShards	= mod:NewSpecialWarningMove(84931)

local magmaTargets = {}
local magmaCount = 0

local function showMagmaWarning()
	warnMagmaSplash:Show(table.concat(magmaTargets, "<, >"))
	table.wipe(magmaTargets)
	timerMagmaSplash:Start()
end

function mod:EarthShardsTarget()
	local targetname = self:GetBossTarget(40825)
	if not targetname then return end
	warnEarthShards:Show(targetname)
	if targetname == UnitName("player") then
		specWarnEarthShards:Show()
	end
end

function mod:OnCombatStart(delay)
	table.wipe(magmaTargets)
	magmaCount = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 76170 then
		magmaCount = magmaCount + 1
		magmaTargets[#magmaTargets + 1] = args.destName
		self:Unschedule(showMagmaWarning)
		self:Schedule(0.3, showMagmaWarning)
	elseif args.spellId == 76165 then
		warnEmberstrike:Show(args.destName)
		timerMagmaSplash:Start(args.destName)
	elseif args.spellId == 76207 then
		warnEnslave:Show(args.destName)
	elseif args.spellId == 76307 then
		timerAbsorbMagic:Start()
	elseif args.spellId == 76339 then
		warnAgony:Show()
		timerAgony:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 76170 then
		magmaCount = magmaCount - 1
		if magmaCount == 0 then
			timerMagmaSplash:Cancel()
		end
	elseif args.spellId == 76165 then
		timerMagmaSplash:Cancel(args.destName)
	elseif args.spellId == 76339 then
		timerAgony:Cancel(args.destName)
	elseif args.spellId == 76616 then
		if args.destName == L.name then
			warnPhase2:Show(2)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 76171 then
		warnLavaBolt:Show()
		timerLavaBolt:Start()
		specWarnLavaBolt:Show(args.sourceName)
	elseif args.spellId == 84931 then
		self:ScheduleMethod(0.1, "EarthShardsTarget")
	elseif args.spellId == 76307 then
		warnAbsorbMagic:Show(76307)
		specWarnAbsorbMagic:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 76234 then
		warnMindFog:Show()
		timerMindFog:Start()
	end
end

function mod:UNIT_DIED(args)
	if self:GetCIDFromGUID(args.destGUID) == 40788 then
		DBM:EndCombat(self)
	end
end