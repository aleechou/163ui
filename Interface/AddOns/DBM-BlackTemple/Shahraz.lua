local mod	= DBM:NewMod("Shahraz", "DBM-BlackTemple")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 535 $"):sub(12, -3))
mod:SetCreatureID(22947)
mod:SetModelID(21252)
mod:SetZone()
mod:SetUsedIcons(6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"RAID_BOSS_EMOTE",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH target focus mouseover",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnFA			= mod:NewTargetAnnounce(41001, 4)
local warnShriek		= mod:NewSpellAnnounce(40823)
local warnEnrageSoon	= mod:NewSoonAnnounce(21340)--not actual spell id
local warnEnrage		= mod:NewSpellAnnounce(21340)

local specWarnFA		= mod:NewSpecialWarningYou(41001)

local timerAura			= mod:NewTimer(15, "timerAura", 22599)

mod:AddBoolOption("FAIcons", false)

local warnFATargets = {}
local FAIcon = 8
local prewarn_enrage
local enrage

local aura = {
	[40880] = true,
	[40882] = true,
	[40883] = true,
	[40891] = true,
	[40896] = true,
	[40897] = true
}

local function showFATargets()
	warnFA:Show(table.concat(warnFATargets, "<, >"))
	table.wipe(warnFATargets)
	FAIcon = 8
end

function mod:OnCombatStart(delay)
	table.wipe(warnFATargets)
	FAIcon = 8
	prewarn_enrage = false
	enrage = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 41001 then
		warnFATargets[#warnFATargets + 1] = args.destName
		self:Unschedule(showFATargets)
		if args:IsPlayer() then
			specWarnFA:Show()
		end
		if self.Options.FAIcons then
			self:SetIcon(args.destName, FAIcon)
			FAIcon = FAIcon - 1
		end
		if #warnFATargets >= 3 then
			showFATargets()
		else
			self:Schedule(1, showFATargets)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 41001 and self.FAIcons then
		self:SetIcon(args.destName, 0)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 40823 then
		warnShriek:Show()
	end
end

function mod:RAID_BOSS_EMOTE(msg, source)
	if not enrage and (source or "") == L.name then
		enrage = true
		warnEnrage:Show()
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.23 and self:GetUnitCreatureId(uId) == 22947 and not prewarn_enrage then
		prewarn_enrage = true
		warnEnrageSoon:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName, _, _, spellId)
	if aura[spellId] then
		self:SendSync("Aura", spellName)
	end
end

function mod:OnSync(msg, name)
	if msg == "Aura" and name then
		timerAura:Start(name)
	end
end
