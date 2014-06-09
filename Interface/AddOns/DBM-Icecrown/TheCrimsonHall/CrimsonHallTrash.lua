local mod	= DBM:NewMod("CrimsonHallTrash", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 37 $"):sub(12, -3))
mod:SetModelID(31037)
mod:SetUsedIcons(1, 2)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warnBloodMirror		= mod:NewTargetAnnounce(70451, 3, nil, mod:IsHealer())
local warnBloodSap			= mod:NewTargetAnnounce(70432, 4)
local warnChainsofShadow	= mod:NewTargetAnnounce(70645, 3)

local timerBloodMirror		= mod:NewTargetTimer(30, 70451, nil, mod:IsHealer())
local timerBloodSap			= mod:NewTargetTimer(8, 70432)
local timerChainsofShadow	= mod:NewTargetTimer(10, 70645)

mod:AddBoolOption("BloodMirrorIcon", false)
mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")

local BloodMirrorTargets = {}
local BloodMirrorIcons = 2

local function warnBloodMirrorTargets()
	warnBloodMirror:Show(table.concat(BloodMirrorTargets, "<, >"))
	table.wipe(BloodMirrorTargets)
	BloodMirrorIcons = 2
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 70451 and args:IsDestTypePlayer() then
		BloodMirrorTargets[#BloodMirrorTargets + 1] = args.destName
		timerBloodMirror:Start(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, BloodMirrorIcons, 30)
			BloodMirrorIcons = BloodMirrorIcons - 1
		end
		self:Unschedule(warnBloodMirrorTargets)
		if #BloodMirrorTargets >= 2 then
			warnBloodMirrorTargets()
		else
			self:Schedule(0.3, warnBloodMirrorTargets)
		end
	elseif args.spellId == 70432 then
		warnBloodSap:Show(args.destName)
		timerBloodSap:Start(args.destName)
	elseif args.spellId == 70645 and args:IsDestTypePlayer() then
		warnChainsofShadow:Show(args.destName)
		timerChainsofShadow:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 70451 then
		timerBloodMirror:Cancel(args.destName)
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 70432 then
		timerBloodSap:Cancel(args.destName)
	elseif args.spellId == 70645 then
		timerChainsofShadow:Cancel(args.destName)
	end
end
