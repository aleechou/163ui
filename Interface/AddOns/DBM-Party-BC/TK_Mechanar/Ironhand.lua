local mod	= DBM:NewMod("Ironhand", "DBM-Party-BC", 13)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 553 $"):sub(12, -3))
mod:SetCreatureID(19710)
mod:SetModelID(21191)--Bad angle, but not terrible enough to disable i guess

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE"
)

local warnShadowpower       = mod:NewSpellAnnounce(35322)
local WarnJackHammer		= mod:NewSpellAnnounce(39194)

local specWarnJackHammer	= mod:NewSpecialWarningRun(39194, mod:IsMelee(), nil, nil, 4)
local specWarnShadowpower   = mod:NewSpecialWarningDispel(35322, mod:IsMagicDispeller())

local timerShadowpower      = mod:NewBuffActiveTimer(15, 35322)
local timerJackhammer       = mod:NewBuffActiveTimer(8, 39194)

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() and self:IsInCombat() then     --Shadow Power
		warnShadowpower:Show(args.destName)
		timerShadowpower:Start(args.destName)
		specWarnShadowpower:Show(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(39193, 35322) and not args:IsDestTypePlayer() then     --Shadow Power
		timerShadowpower:Cancel(args.destName)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(39194, 35327) then     --Jackhammer
		timerJackhammer:Start()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.JackHammer then
		WarnJackHammer:Show()
		specWarnJackHammer:Show()
	end
end
