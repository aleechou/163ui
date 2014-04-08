local mod	= DBM:NewMod(684, "DBM-Party-MoP", 7, 246)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(59080)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnLesson		= mod:NewTargetAnnounce(113395, 2)--Needs to be changed to target when transcriptor works, at present CLEU doesn't show anything.
local warnRise			= mod:NewSpellAnnounce(113143, 3)

local timerLessonCD		= mod:NewNextTimer(30, 113395)
local timerRiseCD		= mod:NewNextTimer(62.5, 113143)--Assuming this is even CD based, it could be boss health based, in which case timer is worthless

function mod:OnCombatStart(delay)
	timerLessonCD:Start(17-delay)
	sndWOP:Schedule(15, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\telesoon.mp3")--準備傳送
	timerRiseCD:Start(48-delay)--Assumed based off a single log. This may be health based.
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 113143 then
		warnRise:Show()
		timerRiseCD:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\mobsoon.mp3")--準備小怪
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)--Just until there is a better way
	if msg:find("spell:113395") then
		warnLesson:Show(DBM:GetFullNameByShortName(target))
		timerLessonCD:Start()
		sndWOP:Schedule(28, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\telesoon.mp3")--準備傳送
	end
end