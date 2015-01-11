local mod	= DBM:NewMod("Leotheras", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 547 $"):sub(12, -3))
mod:SetCreatureID(21215, 21806)
mod:SetModelID(20514)
mod:SetZone()
mod:SetUsedIcons(5, 6, 7, 8)

mod:RegisterCombat("combat")

--Not using RegisterEventsInCombat on purpose because it uses weird combat rules
mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"UNIT_DIED"
)

local warnWhirl			= mod:NewSpellAnnounce(37640, 3)
local warnPhase			= mod:NewAnnounce("WarnPhase", 1)
local warnDemon			= mod:NewTargetAnnounce(37676, 4)
local warnMC			= mod:NewTargetAnnounce(37749, 4)
local warnPhase2		= mod:NewPhaseAnnounce(2)

local specWarnWhirl		= mod:NewSpecialWarningRun(37640)
local specWarnDemon		= mod:NewSpecialWarningYou(37676)

local timerWhirlCD		= mod:NewCDTimer(27, 37640)
local timerWhirl		= mod:NewBuffActiveTimer(12, 37640)
local timerPhase		= mod:NewTimer(60, "TimerPhase", 39088)
local timerDemonCD		= mod:NewCDTimer(23, 37676)
local timerDemon		= mod:NewBuffFadesTimer(30, 37676)

local berserkTimer		= mod:NewBerserkTimer(600)

mod:AddBoolOption("DemonIcon", false)

local warnDemonTargets = {}
local warnMCTargets = {}
local binderKill = 0
local demonIcon = 8
local whirlCount = 0
local phase2 = false

local function humanWarns()
	whirlCount = 0
	warnPhase:Show(L.Human)
	timerWhirlCD:Start(15)
	timerPhase:Start(nil, L.Demon)
end

local function showDemonTargets()
	warnDemon:Show(table.concat(warnDemonTargets, "<, >"))
	table.wipe(warnDemonTargets)
	demonIcon = 8
	timerDemon:Start()
end

local function showMCTargets()
	warnMC:Show(table.concat(warnMCTargets, "<, >"))
	table.wipe(warnMCTargets)
end

function mod:OnCombatEnd()
	binderKill = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 37640 then
		warnWhirl:Show()
		specWarnWhirl:Show()
		timerWhirl:Start()
		if not phase2 then
			whirlCount = whirlCount + 1
			if whirlCount < 3 then
				timerWhirlCD:Start()
			end
		else
			timerWhirlCD:Start()
		end
	elseif args.spellId == 37676 then
		warnDemonTargets[#warnDemonTargets + 1] = args.destName
		self:Unschedule(showDemonTargets)
		if self.Options.DemonIcon then
			self:SetIcon(args.destName, demonIcon)
			demonIcon = demonIcon - 1
		end
		if args:IsPlayer() then
			specWarnDemon:Show()
		end
		if #warnDemonTargets >= 5 then
			showDemonTargets()
		else
			self:Schedule(0.7, showDemonTargets)
		end
	elseif args.spellId == 37749 then
		warnMCTargets[#warnMCTargets + 1] = args.destName
		self:Unschedule(showMCTargets)
		self:Schedule(0.3, showMCTargets)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDemon or msg:find(L.YellDemon) then
		warnPhase:Show(L.Demon)
		timerWhirl:Cancel()
		timerWhirlCD:Cancel()
		timerPhase:Cancel()
		timerDemonCD:Start()
		timerPhase:Start(nil, L.Human)
		self:Schedule(60, humanWarns)
	elseif msg == L.YellPhase2 or msg:find(L.YellPhase2) then
		phase2 = true
		self:Unschedule(60, humanWarns)
		timerPhase:Cancel()
		timerWhirl:Cancel()
		timerWhirlCD:Cancel()
		timerDemonCD:Cancel()
		warnPhase2:Show()
		timerWhirlCD:Start(22.5)
	end
end

function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21806 then
		binderKill = binderKill + 1
		if binderKill == 3 and not self:IsInCombat() then
			DBM:StartCombat(self, 0)
			demonIcon = 8
			whirlCount = 0
			phase2 = false
			table.wipe(warnMCTargets)
			table.wipe(warnDemonTargets)
			timerWhirlCD:Start(15)
			timerPhase:Start(nil, L.Demon)
			berserkTimer:Start()
		end
	elseif cId == 21215 and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end
