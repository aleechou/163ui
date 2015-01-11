local mod = DBM:NewMod(542, "DBM-Party-BC", 9, 252)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 540 $"):sub(12, -3))

mod:SetCreatureID(23035)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH target focus" ,
	"CHAT_MSG_MONSTER_EMOTE"
)
mod.onlyHeroic = true

local warnBirds             = mod:NewSpellAnnounce("ej5253", 2, 32038)
local warnStoned            = mod:NewAnnounce("warnStoned", 1, 32810, false)
local warnScreech           = mod:NewSpellAnnounce(40184, 3)
local warnCyclone           = mod:NewTargetAnnounce(40321, 2)
local warnSpellBomb         = mod:NewTargetAnnounce(40303, 2)

local specWarnScreech		= mod:NewSpecialWarningSpell(40184, nil, nil, nil, 2)

local timerScreech          = mod:NewCastTimer(5, 40184)
local timerScreechDebuff    = mod:NewBuffActiveTimer(6, 40184)
local timerCyclone          = mod:NewTargetTimer(6, 40321)
local timerSpellBomb        = mod:NewTargetTimer(8, 40303)
local timerScreechCD        = mod:NewCDTimer(30, 40184)--Best guess on screech CD. Might need tweaking.

local warnedbirds1 = false
local warnedbirds2 = false

function mod:OnCombatStart(delay)
	timerScreechCD:Start()
    warnedbirds1 = false
    warnedbirds2 = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 40184 then
		warnScreech:Show()
		specWarnScreech:Show()
		timerScreech:Start()
		timerScreechCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 40321 then
		warnCyclone:Show(args.destName)
		timerCyclone:Start(args.destName)
	elseif args.spellId == 40184 then
		timerScreechDebuff:Show()
	elseif args.spellId == 40303 then
		warnSpellBomb:Show(args.destName)
		timerSpellBomb:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 40303 then
		timerSpellBomb:Cancel(args.destName)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warnedbirds1 and self:GetUnitCreatureId(uId) == 23035 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.70 then
		warnedbirds1 = true
		warnBirds:Show()
	elseif not warnedbirds2 and self:GetUnitCreatureId(uId) == 23035 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.37 then
		warnedbirds2 = true
		warnBirds:Show()
	end
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc)
	if msg == L.BirdStone or msg:find(L.BirdStone) then		-- Spirits returning to stone.
		warnStoned:Show(npc)
	end
end
