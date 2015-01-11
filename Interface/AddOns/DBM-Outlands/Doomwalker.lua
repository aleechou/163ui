local mod	= DBM:NewMod("Doomwalker", "DBM-Outlands")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 183 $"):sub(12, -3))
mod:SetCreatureID(17711)
mod:SetModelID(21435)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED"
)

local warnCharge			= mod:NewSpellAnnounce(32637, 3)
local warnQuake				= mod:NewSpellAnnounce(32686, 3)

local timerChargeCD			= mod:NewCDTimer(42, 32637)
local timerQuakeCD			= mod:NewCDTimer(52, 32686)
local timerQuake			= mod:NewBuffActiveTimer(8, 32686)

mod:AddBoolOption("RangeFrame", true)

function mod:OnCombatStart(delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 32637 and self:AntiSpam(10, 1) then
		warnCharge:Show()
		timerChargeCD:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 32686 and self:AntiSpam(30, 2) then
		warnQuake:Show()
		timerQuake:Start()
		timerQuakeCD:Show()
	end
end
