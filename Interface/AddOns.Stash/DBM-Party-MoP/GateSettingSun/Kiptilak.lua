local mod	= DBM:NewMod(655, "DBM-Party-MoP", 4, 303)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(56906)
mod:SetZone()
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED"
)


local warnSabotage				= mod:NewTargetAnnounce(107268, 4)
--local warnThrowExplosive		= mod:NewSpellAnnounce(102569, 3)--Doesn't show in chat/combat log, need transcriptor log
--local warnWorldinFlame		= mod:NewSpellAnnounce(101591, 4)--^, triggered at 66% and 33% boss health.

local specWarnSabotage			= mod:NewSpecialWarningYou(107268)
local specWarnSabotageNear		= mod:NewSpecialWarningClose(107268)

local timerSabotage				= mod:NewTargetTimer(5, 107268)
local timerSabotageCD			= mod:NewNextTimer(12, 107268)
--local timerThrowExplosiveCD	= mod:NewNextTimer(22, 102569)

mod:AddBoolOption("IconOnSabotage", true)

function mod:OnCombatStart(delay)
--	timerSabotageCD:Start(-delay)--Unknown, tank pulled before log got started, will need a fresh log.
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 107268 then
		warnSabotage:Show(args.destName)
		timerSabotage:Start(args.destName)
		sndWOP:Schedule(1.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(4.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerSabotageCD:Start()
		if self.Options.IconOnSabotage then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnSabotage:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runout.mp3")--跑開人群
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\bombsoon.mp3")--準備炸彈
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 10 then
					specWarnSabotageNear:Show(args.destName)
				end
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 107268 then
		timerSabotage:Cancel(args.destName)
		if self.Options.IconOnSabotage then
			self:SetIcon(args.destName, 0)
		end
	end
end
