local mod	= DBM:NewMod("Buru", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 513 $"):sub(12, -3))
mod:SetCreatureID(15370)
mod:SetModelID(15654)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

local WarnDismember		= mod:NewStackAnnounce(96, 3)
local warnPursue		= mod:NewAnnounce("WarnPursue", 3, 62374)

local specWarnDismember	= mod:NewSpecialWarningStack(96, nil, 5)
local specWarnPursue	= mod:NewSpecialWarning("SpecWarnPursue")

local timerDismember	= mod:NewTargetTimer(10, 96)

function mod:OnCombatStart(delay)
	if not self:IsTrivial(80) then
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED",
			"SPELL_AURA_APPLIED_DOSE"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 96 then
		local amount = args.amount or 1
		WarnDismember:Show(args.destName, amount)
		timerDismember:Start(args.destName)
		if amount >= 5 and args:IsPlayer() then
			specWarnDismember:Show(amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:CHAT_MSG_MONSTER_EMOTE(msg, _, _, _, target)
	if not msg:find(L.PursueEmote) then return end
	local target = DBM:GetUnitFullName(target)
	if not target then return end
	if target then
		warnPursue:Show(target)
		if target == UnitName("player") then
			specWarnPursue:Show()
		end
	end
end