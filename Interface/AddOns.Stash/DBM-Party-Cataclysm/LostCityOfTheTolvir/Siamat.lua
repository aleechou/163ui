local mod	= DBM:NewMod(122, "DBM-Party-Cataclysm", 5, 69)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(44819)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",	
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON"
)

local warnStaticShock		= mod:NewSpellAnnounce(84547, 4)	-- Summons a "Servant of Siamat"
local warnThunderCrash		= mod:NewCastAnnounce(84522, 3)
local warnDeflectingWinds	= mod:NewSpellAnnounce(84589, 3)
local warnWailingWinds		= mod:NewSpellAnnounce(83066, 3)
local warnAbsorbStorms		= mod:NewSpellAnnounce(83151, 2, false)
local warnGatheredStorms	= mod:NewSpellAnnounce(84982, 3)
local warnLightningCharge	= mod:NewCastAnnounce(91872, 3)

local specWarnPhase2Soon	= mod:NewSpecialWarning("specWarnPhase2Soon", true, nil, nil, true)

local timerThunderCrash		= mod:NewCastTimer(3, 84522)
local timerWailingWinds		= mod:NewBuffActiveTimer(6, 83066)
local timerAbsorbStorms		= mod:NewCDTimer(33, 83151)
local timerGatheredStorms	= mod:NewBuffActiveTimer(25, 84982)
local timerPhase2Start		= mod:NewTimer(5, "timerPhase2", 91872)

local servantSpawn = 0
local thirdServant = 0

function mod:OnCombatStart(delay)
	servantSpawn = 0
	thirdServant = 0
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 84982 then
		warnGatheredStorms:Show()
		timerGatheredStorms:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 84522 then
		warnThunderCrash:Show()
		timerThunderCrash:Start()
	elseif args.spellId == 91872 then
		warnLightningCharge:Show()
		if args.sourceGUID == thirdServant then--Third add to have spawned is dying and casting Lightning Charge
			specWarnPhase2Soon:Show()
			timerPhase2Start:Start()--Phase 2 starts 5 seconds after 3rd add casts static charge regardless of whether or not other adds are dead.
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 84589 then
		warnDeflectingWinds:Show()
	elseif args.spellId == 83066 then
		warnWailingWinds:Show()
		timerWailingWinds:Start()
	elseif args.spellId == 83151 then
		warnAbsorbStorms:Show()
		timerAbsorbStorms:Start()
	end
end

function mod:SPELL_SUMMON(args)
	if args:IsSpellID(84547, 84553, 84554) then
		warnStaticShock:Show()
		servantSpawn = servantSpawn + 1
		if servantSpawn == 3 then--Third add spawned
			thirdServant = args.destGUID
		end
	end
end