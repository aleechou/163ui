local mod	= DBM:NewMod("Nightbane", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 527 $"):sub(12, -3))
mod:SetCreatureID(17225)
mod:SetModelID(18062)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL"
)

local warningFear			= mod:NewSpellAnnounce(36922, 4)
local warningAsh			= mod:NewTargetAnnounce(30130, 2, nil, false)
local WarnAir				= mod:NewAnnounce("DBM_NB_AIR_WARN", 2, "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local warningBone			= mod:NewSpellAnnounce(37098, 3)

local specWarnCharred		= mod:NewSpecialWarningMove(30129)

local timerNightbane		= mod:NewCombatTimer(36)
local timerFearCD			= mod:NewCDTimer(31.5, 36922)
local timerAirPhase			= mod:NewTimer(57, "timerAirPhase", "Interface\\AddOns\\DBM-Core\\textures\\CryptFiendUnBurrow.blp")
local timerBone				= mod:NewBuffActiveTimer(11, 37098)

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg == L.DBM_NB_EMOTE_PULL then
		timerNightbane:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 36922 then
		warningFear:Show()
		timerFearCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 37098 then
		warningBone:Show()
		timerBone:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 30129 and args:IsPlayer() and not self:IsTrivial(85) and self:AntiSpam() then
		specWarnCharred:Show()
	elseif args.spellId == 30130 then
		warningAsh:Show(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.DBM_NB_YELL_AIR then
		WarnAir:Show()
		timerAirPhase:Start()
	elseif msg == L.DBM_NB_YELL_GROUND or msg == L.DBM_NB_YELL_GROUND2 then--needed. because if you deal more 25% damage in air phase, air phase repeated and shroten. So need to update exact ground phase.
		timerAirPhase:Update(43, 57)
	end
end
