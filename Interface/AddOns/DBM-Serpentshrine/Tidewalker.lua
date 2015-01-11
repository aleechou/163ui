local mod	= DBM:NewMod("Tidewalker", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(21213)
mod:SetModelID(20739)
mod:SetZone()
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnTidal			= mod:NewSpellAnnounce(37730, 3)
local warnGrave			= mod:NewTargetAnnounce(38049, 4)
local warnMurlocs		= mod:NewAnnounce("WarnMurlocs", 3)
local warnBubble		= mod:NewSpellAnnounce(37854, 4)

local specWarnMurlocs	= mod:NewSpecialWarning("SpecWarnMurlocs")

local timerGraveCD		= mod:NewCDTimer(28.5, 38049)
local timerMurlocs		= mod:NewTimer(51, "TimerMurlocs", 39088)
local timerBubble		= mod:NewBuffActiveTimer(35, 37854)

mod:AddBoolOption("GraveIcon", true)

local warnGraveTargets = {}
local graveIcon = 8

local function showGraveTargets()
	warnGrave:Show(table.concat(warnGraveTargets, "<, >"))
	table.wipe(warnGraveTargets)
	timerGraveCD:Show()
end

function mod:OnCombatStart(delay)
	graveIcon = 8
	table.wipe(warnGraveTargets)
	timerGraveCD:Start(20-delay)
	timerMurlocs:Start(41-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(37850, 38023, 38024, 38025, 38049) then
		warnGraveTargets[#warnGraveTargets + 1] = args.destName
		self:Unschedule(showGraveTargets)
		if self.Options.GraveIcon then
			self:SetIcon(args.destName, graveIcon)
			graveIcon = graveIcon - 1
		end
		if #warnGraveTargets >= 4 then
			showGraveTargets()
		else
			self:Schedule(0.3, showGraveTargets)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 37730 then
		warnTidal:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37764 then
		warnMurlocs:Show()
		specWarnMurlocs:Show()
		timerMurlocs:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 37854 and self:AntiSpam(30) then
		warnBubble:Show()
		timerBubble:Start()
	end
end