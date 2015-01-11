local mod	= DBM:NewMod("TerestianIllhoof", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(15688)
mod:SetModelID(11343)

--mod:RegisterCombat("yell", L.DBM_TI_YELL_PULL)
mod:RegisterCombat("combat", 15688)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_DIED"
)

local warningWeakened	= mod:NewTargetAnnounce(30065, 2)
local warningImp		= mod:NewSpellAnnounce(30066, 3)
local warningSacrifice	= mod:NewTargetAnnounce(30115, 4)

local specWarnSacrifice	= mod:NewSpecialWarningYou(30115)

local timerWeakened		= mod:NewBuffActiveTimer(31, 30065)
local timerSacrifice	= mod:NewTargetTimer(30, 30115)
local timerSacrificeCD	= mod:NewNextTimer(43, 30115)

local berserkTimer		= mod:NewBerserkTimer(600)

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30115 then
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(17248, L.DChains)
		end
		warningSacrifice:Show(args.destName)
		timerSacrifice:Start(args.destName)
		timerSacrificeCD:Start()
		if args:IsPlayer() then
			specWarnSacrifice:Show()
		end
	elseif args.spellId == 30065 then
		warningWeakened:Show(args.destName)
		timerWeakened:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 30115 then
		timerSacrifice:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 30066 then
		warningImp:Show()
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(17229, L.Kilrek)
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 17229 and DBM.BossHealth:IsShown() then--Kil'rek
		DBM.BossHealth:RemoveBoss(cid)
	elseif cid == 17248 and DBM.BossHealth:IsShown() then--Demon Chains
		DBM.BossHealth:RemoveBoss(cid)
	end
end
