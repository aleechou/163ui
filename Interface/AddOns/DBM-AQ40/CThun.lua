local mod	= DBM:NewMod("CThun", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 500 $"):sub(12, -3))
mod:SetCreatureID(15589, 15727)
--mod:SetModelID(15787)--Does not scale correctly.
mod:RegisterCombat("combat")
mod:SetWipeTime(25)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED"
)

local warnDarkGlare			= mod:NewSpellAnnounce(26029, 4)
local warnEyeTentacle		= mod:NewAnnounce("WarnEyeTentacle", 2)
--local warnClawTentacle		= mod:NewAnnounce("WarnClawTentacle", 2)
--local warnGiantEyeTentacle	= mod:NewAnnounce("WarnGiantEyeTentacle", 3)
--local warnGiantClawTentacle	= mod:NewAnnounce("WarnGiantClawTentacle", 3)
local warnPhase2			= mod:NewPhaseAnnounce(2)
local warnWeakened			= mod:NewAnnounce("WarnWeakened", 4)

local specWarnDarkGlare		= mod:NewSpecialWarningSpell(26029, nil, nil, nil, 3)
local specWarnWeakened		= mod:NewSpecialWarning("SpecWarnWeakened", nil, nil, nil, 2)

local timerDarkGlareCD		= mod:NewNextTimer(86, 26029)
local timerDarkGlare		= mod:NewBuffActiveTimer(39, 26029)
local timerEyeTentacle		= mod:NewTimer(45, "TimerEyeTentacle")
--local timerGiantEyeTentacle	= mod:NewTimer(60, "TimerGiantEyeTentacle")
--local timerClawTentacle		= mod:NewTimer(11, "TimerClawTentacle")
--local timerGiantClawTentacle = mod:NewTimer(60, "TimerGiantClawTentacle")
local timerWeakened			= mod:NewTimer(45, "TimerWeakened")

mod:AddBoolOption("RangeFrame", true)

local phase2

function mod:OnCombatStart(delay)
	phase2 = false
	--timerClawTentacle:Start(-delay)
	timerEyeTentacle:Start(45-delay)
	timerDarkGlareCD:Start(48-delay)
	self:ScheduleMethod(45-delay, "EyeTentacle")
	self:ScheduleMethod(48-delay, "DarkGlare")
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Clear()
		DBM.BossHealth:AddBoss(15589, L.Eye)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:EyeTentacle()
	warnEyeTentacle:Show()
	timerEyeTentacle:Start()
	self:ScheduleMethod(45, "EyeTentacle")
end

function mod:DarkGlare()
	warnDarkGlare:Show()
	specWarnDarkGlare:Show()
	timerDarkGlare:Start()
	timerDarkGlareCD:Start()
	self:ScheduleMethod(86, "DarkGlare")
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.Weakened) then
		warnWeakened:Show()
		specWarnWeakened:Show()
		timerWeakened:Start()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 15589 then
		phase2 = true
		warnPhase2:Show()
		self:UnscheduleMethod("EyeTentacle")
		self:UnscheduleMethod("DarkGlare")
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:Clear()
			DBM.BossHealth:AddBoss(15727, L.name)
		end
	end
end
