local mod	= DBM:NewMod("BigBadWolf", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(17521)
mod:SetModelID(17053)
mod:RegisterCombat("yell", L.DBM_BBW_YELL_1)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)

local warningFear		= mod:NewSpellAnnounce(30752, 3)
local warningRRH		= mod:NewTargetAnnounce(30753, 4)

local specWarnRRH		= mod:NewSpecialWarningYou(30753)

local timerRRH			= mod:NewTargetTimer(20, 30753)
local timerRRHCD		= mod:NewNextTimer(30, 30753)
local timerFearCD		= mod:NewNextTimer(24, 30752)

mod:AddBoolOption("RRHIcon")

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30753 then
		warningRRH:Show(args.destName)
		timerRRH:Start(args.destName)
		if self:IsInCombat() then--Because sometimes debuff goes out half sec after combat end
			timerRRHCD:Start()
			if args:IsPlayer() then
				specWarnRRH:Show()
			end
			if self.Options.RRHIcon then
				self:SetIcon(args.destName, 8, 20)
			end
		end
	elseif args.spellId == 30752 and self:AntiSpam() then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30753 and self.Options.RRHIcon then
		self:SetIcon(args.destName, 0)
	end
end
