local mod	= DBM:NewMod(115, "DBM-Party-Cataclysm", 8, 68)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(43873)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START"
)

local warnBreath		= mod:NewTargetAnnounce(88308, 2)
local warnUpwind		= mod:NewSpellAnnounce(88282, 3)
local warnDownwind		= mod:NewSpellAnnounce(88286, 4)

local specWarnBreath	= mod:NewSpecialWarningYou(88308, false)
local specWarnBreathNear= mod:NewSpecialWarningClose(88308)
local specWarnDownwind	= mod:NewSpecialWarningMove(88286)

local timerBreath		= mod:NewCastTimer(2, 88308)
local timerBreathCD		= mod:NewCDTimer(12, 88308)

mod:AddBoolOption("BreathIcon")

local activeWind = ""

function mod:BreathTarget()
	local targetname = self:GetBossTarget(43873)
	if not targetname then return end
		warnBreath:Show(targetname)
		if self.Options.BreathIcon then
			self:SetIcon(targetname, 8, 4)
		end
	if targetname == UnitName("player") then--Tank doesn't care about this so if your current spec is tank ignore this warning.
		specWarnBreath:Show()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = CheckInteractDistance(uId, 2)
			if inRange then
				specWarnBreathNear:Show(targetname)
			end
		end
	end
end

function mod:OnCombatStart(delay)
	activeWind = ""
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 88282 and args:IsPlayer() and activeWind ~= "up" then
		warnUpwind:Show()
		activeWind = "up"
	elseif args.spellId == 88286 and args:IsPlayer() and activeWind ~= "down" then
		warnDownwind:Show()
		specWarnDownwind:Show()
		activeWind = "down"
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 88308 then
		self:ScheduleMethod(0.2, "BreathTarget")
		timerBreath:Start()
		timerBreathCD:Start()
	end
end