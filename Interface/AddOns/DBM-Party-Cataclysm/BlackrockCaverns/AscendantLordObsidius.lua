local mod	= DBM:NewMod(109, "DBM-Party-Cataclysm", 1, 66)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7663 $"):sub(12, -3))
mod:SetCreatureID(39705)
mod:SetModelID(36465)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED"
)

local warnTransformation	= mod:NewSpellAnnounce(76200, 3)
local warnCorrupion			= mod:NewTargetAnnounce(76188, 2)

local timerCorruption		= mod:NewTargetTimer(12, 76188)
local timerVeil				= mod:NewTargetTimer(4, 76189)

mod:AddBoolOption("SetIconOnBoss")

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(76200) then
		warnTransformation:Show()
	elseif args:IsSpellID(76188, 93613) then
		warnCorrupion:Show(args.destName)
		timerCorruption:Start(args.destName)
	elseif args:IsSpellID(76189) then
		timerVeil:Start(args.destName)
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(76242) and self.Options.SetIconOnBoss then
		self:SetIcon(L.name, 8)
	elseif args:IsSpellID(76188, 93613) then
		timerCorruption:Cancel(args.destName)
	end
end