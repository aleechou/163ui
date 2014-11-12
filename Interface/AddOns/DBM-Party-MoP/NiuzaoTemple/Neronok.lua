local mod	= DBM:NewMod(727, "DBM-Party-MoP", 6, 324)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(62205)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"RAID_BOSS_EMOTE",
	"SPELL_INTERRUPT"
)

local warnGustingWinds		= mod:NewSpellAnnounce(121282, 4)
local warnResin				= mod:NewTargetAnnounce(121447, 4)

local specWarnGustingWinds	= mod:NewSpecialWarningSpell(121282, nil, nil, nil, true)
local specWarnResin			= mod:NewSpecialWarningYou(121447)
local specWarnCausticPitch	= mod:NewSpecialWarningMove(121443)
local specWarnFly			= mod:NewSpecialWarning("specWarnFly")

local timerResinCD			= mod:NewCDTimer(20, 121447)--20-25 sec variation

local windsActive = false

function mod:OnCombatStart(delay)
	windsActive = false
	timerResinCD:Start(7-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 121447 then
		warnResin:Show(args.destName)
		if args:IsPlayer() then
			specWarnResin:Show()
			sndWOP:Play("keepjump")--保持跳動
		end
	elseif args.spellId == 121443 then
		if args:IsPlayer() then
			specWarnCausticPitch:Show()
			sndWOP:Play("runaway")--快躲開
		end
	elseif args.spellId == 121282 and not windsActive then
		windsActive = true
		timerResinCD:Cancel()
		warnGustingWinds:Show()
		specWarnGustingWinds:Show()
	end
end

function mod:SPELL_INTERRUPT(args)
	if (type(args.extraSpellId) == "number" and args.extraSpellId == 121282) and self:AntiSpam() then
		windsActive = false
		timerResinCD:Start(10)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Fly or msg:find(L.Fly) then
		sndWOP:Play("justrun")--快跑
		specWarnFly:Show()
	end
end
