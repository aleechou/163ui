local mod	= DBM:NewMod(857, "DBM-Pandaria", nil, 322)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 10266 $"):sub(12, -3))
mod:SetCreatureID(71952)
mod:SetZone()
mod:SetMinSyncRevision(10162)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

local warnInspiringSong			= mod:NewSpellAnnounce(144468, 3)
local warnBeaconOfHope			= mod:NewTargetAnnounce(144473, 1)
local warnFirestorm				= mod:NewSpellAnnounce(144461, 3)
local warnBlazingSong			= mod:NewSpellAnnounce(144471, 4)
local warnCraneRush				= mod:NewSpellAnnounce(144470, 3)--Health based, 66% and 33% (maybe register UNIT_HEALTH and give soon warning?)

local specWarnInspiringSong		= mod:NewSpecialWarningInterrupt(144468)
local specWarnBeaconOfHope		= mod:NewSpecialWarningSpell(144473)
local specWarnFirestorm			= mod:NewSpecialWarningSpell(144461, nil, nil, nil, 2)
local specWarnBlazingSong		= mod:NewSpecialWarningSpell(144471, nil, nil, nil, 3)
local specWarnCraneRush			= mod:NewSpecialWarningSpell(144470, nil, nil, nil, 2)

local timerInspiringSongCD		= mod:NewCDTimer(30, 144468)--30-50sec variation?

mod:AddBoolOption("HudMAP", true, "sound")
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local HopeMarkers = {}

local yellTriggered = false

function mod:OnCombatStart(delay)
	if yellTriggered then--We know for sure this is an actual pull and not diving into in progress
		timerInspiringSongCD:Start(20-delay)
	end
	table.wipe(HopeMarkers)
end

function mod:OnCombatEnd()
	yellTriggered = false
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 144468 then
		warnInspiringSong:Show()
		specWarnInspiringSong:Show()
		timerInspiringSongCD:Start()
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3") --快打斷
		end
	elseif args.spellId == 144471 then
		warnBlazingSong:Show()
		specWarnBlazingSong:Show()
		sndWOP:Schedule(2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(3, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(4, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		if mod:IsHealer() then
			sndWOP:Schedule(5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\healall.mp3") --注意群療
		else
			sndWOP:Schedule(5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3") --准备AOE
		end
	elseif args.spellId == 144470 then
		warnCraneRush:Show()
		specWarnCraneRush:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_shbx.mp3") --神鹤奔袭
	elseif args.spellId == 144473 then
		warnBeaconOfHope:Show()
		specWarnBeaconOfHope:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_xbzb.mp3") --信标准备
	elseif args.spellId == 144461 then
		warnFirestorm:Show()
		specWarnFirestorm:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	--This victory yell fails if curse of tongues is on boss
	if msg == L.Victory then
		self:SendSync("Victory")
	elseif msg == L.Pull and not self:IsInCombat() then
		if self:GetCIDFromGUID(UnitGUID("target")) == 71953 or self:GetCIDFromGUID(UnitGUID("targettarget")) == 71953 then--Whole zone gets yell, so lets not engage combat off yell unless he is our target (or the target of our target for healers)
			yellTriggered = true
			DBM:StartCombat(self, 0)
		end
	end
end

--This method works without local and doesn't fail with curse of tongues. However, it requires at least ONE person in raid targeting boss to be running dbm (which SHOULD be most of the time)
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 148318 or spellId == 148317 or spellId == 149304 and self:AntiSpam(3, 2) then--use all 3 because i'm not sure which ones fire on repeat kills
		self:SendSync("Victory")
	end
end

function mod:OnSync(msg)
	if msg == "Victory" and self:IsInCombat() then
		DBM:EndCombat(self)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 144473 then
		warnBeaconOfHope:Show(args.destName)
		if args:IsPlayer() then
			specWarnBeaconOfHope:Show()
			yellBeaconOfHope:Yell()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_so_xbdn.mp3") --信标点你
		else
			specWarnBeaconOfHopeOther:Show(args.destName)
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\gather.mp3")--快集合
			if self.Options.BeaconArrow then
				DBM.Arrow:ShowRunTo(args.destName, 3, 3, 5)
			end
			if self.Options.HudMAP then
				HopeMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 5, 20, 1, 1, 1, 0.8):Appear():RegisterForAlerts():Rotate(360, 20.5):SetAlertColor(0, 0, 1, 0.4))
				HopeMarkers[args.destName.."Edge"] = register(DBMHudMap:AddEdge(0, 0, 1, 1, 5, "player", args.destName))
			end
		end
		if self.Options.SetIconOnBeacon then
			self:SetIcon(args.destName, 1)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 144473 then
		if self.Options.SetIconOnBeacon then
			self:SetIcon(args.destName, 0)
		end
		if HopeMarkers[args.destName] then
			HopeMarkers[args.destName] = free(HopeMarkers[args.destName])
		end
	end
end
