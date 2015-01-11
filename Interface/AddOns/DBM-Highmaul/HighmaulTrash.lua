local mod	= DBM:NewMod("HighmaulTrash", "DBM-Highmaul")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 12295 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 175636 173827 172066 166200"
)

--Maybe add auto range finder for moveaway warnings, and REMOVED event to close it after
local warnRuneofDestruction			= mod:NewTargetAnnounce("OptionVersion2", 175636, 3, nil, false)
local warnRadiatingPoison			= mod:NewTargetAnnounce("OptionVersion2", 172066, 3, nil, false)
local warnArcaneVol					= mod:NewTargetAnnounce("OptionVersion2", 166200, 3, nil, false)

local specWarnRuneofDestruction		= mod:NewSpecialWarningMoveAway(175636)
local yellRuneofDestruction			= mod:NewYell(175636)
local specWarnRadiatingPoison		= mod:NewSpecialWarningMoveAway(172066)
local yellRadiatingPoison			= mod:NewYell(172066)
local specWarnArcaneVol				= mod:NewSpecialWarningMoveAway(166200)
local yellArcaneVol					= mod:NewYell(166200)
local specWarnWildFlames			= mod:NewSpecialWarningMove(173827)

mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 175636 then
		warnRuneofDestruction:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnRuneofDestruction:Show()
			if not self:IsLFR() then
				yellRuneofDestruction:Yell()
			end
		end
	elseif spellId == 172066 then
		warnRadiatingPoison:CombinedShow(1, args.destName)
		if args:IsPlayer() and not self:IsTank() then--tank can't run out even if they have debuff
			specWarnRadiatingPoison:Show()
			if not self:IsLFR() then
				yellRadiatingPoison:Yell()
			end
		end
	elseif spellId == 166200 then
		warnArcaneVol:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnArcaneVol:Show()
			if not self:IsLFR() then
				yellArcaneVol:Yell()
			end
		end
	elseif spellId == 173827 and args:IsPlayer() then
		specWarnWildFlames:Show()
	end
end
