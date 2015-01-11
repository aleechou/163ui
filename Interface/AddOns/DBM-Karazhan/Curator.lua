local mod	= DBM:NewMod("Curator", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(15691)
mod:SetModelID(16958)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_SUCCESS"
)

local warnAdd			= mod:NewAnnounce("warnAdd", 3)
local warnEvo			= mod:NewSpellAnnounce(30254, 2)
local warnArcaneInfusion= mod:NewSpellAnnounce(30403, 4)

local timerEvo			= mod:NewBuffActiveTimer(20, 30254)
local timerNextEvo		= mod:NewNextTimer(115, 30254)

local berserkTimer		= mod:NewBerserkTimer(720)

mod:AddBoolOption("RangeFrame", true)

local addGUIDS = {}

function mod:OnCombatStart(delay)
	table.wipe(addGUIDS)
	berserkTimer:Start(-delay)
	timerNextEvo:Start(109-delay)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30254 then
		warnEvo:Show()
		timerEvo:Start()
		timerNextEvo:Start()
	elseif args.spellId == 30403 then
		warnArcaneInfusion:Show()
		timerNextEvo:Cancel()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30235 and not addGUIDS[args.sourceGUID] then
		addGUIDS[args.sourceGUID] = true
		warnAdd:Show()
	end
end
