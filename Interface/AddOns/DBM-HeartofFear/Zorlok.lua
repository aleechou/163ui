local mod	= DBM:NewMod(745, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9668 $"):sub(12, -3))
mod:SetCreatureID(62980)--63554 (Special invisible Vizier that casts the direction based spellid versions of attenuation)
mod:SetZone()

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Defeat)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_DIED"
)

--[[WoL Reg expression
(spellid = 123791 or spellid = 122713) and fulltype = SPELL_CAST_START or (spell = "Inhale" or spell = "Exhale") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE or fulltype = SPELL_AURA_REMOVED) or spellid = 127834 or spell = "Convert" or spellid = 124018
(spellid = 123791 or spellid = 122713 or spellid = 122740 or spellid = 127834) and fulltype = SPELL_CAST_START or spellid = 124018
--]]
--Notes: Currently, his phase 2 chi blast abiliteis are not detectable via traditional combat log. maybe with transcriptor.
local warnInhale			= mod:NewStackAnnounce(122852, 2)
local warnExhale			= mod:NewTargetAnnounce(122761, 3)
local warnForceandVerve		= mod:NewCastAnnounce(122713, 4, 4)
local warnAttenuation		= mod:NewSpellAnnounce(127834, 4)
local warnConvert			= mod:NewTargetAnnounce(122740, 4)

local specwarnPlatform		= mod:NewSpecialWarning("specwarnPlatform")
local specwarnForce			= mod:NewSpecialWarningSpell(122713)
local specwarnConvert		= mod:NewSpecialWarningSwitch(122740, not mod:IsHealer())
local specwarnExhale		= mod:NewSpecialWarning("specwarnExhale")
local specwarnExhaleB		= mod:NewSpecialWarning("specwarnExhaleB")
local specwarnAttenuation	= mod:NewSpecialWarningSpell(127834, nil, nil, nil, true)

local specwarnAttenuationL	= mod:NewSpecialWarning("specwarnAttenuationL")
local specwarnAttenuationR	= mod:NewSpecialWarning("specwarnAttenuationR")

local specwarnDR			= mod:NewSpecialWarning("specwarnDR")

--Timers aren't worth a crap, at all, but added anyways. if people complain about how inaccurate they are tell them to go to below thread or get bent.
--http://us.battle.net/wow/en/forum/topic/7004456927 for more info on lack of timers.
local timerExhale				= mod:NewTargetTimer(6, 122761)
local timerForceCD				= mod:NewCDTimer(35, 122713)--35-50 second variation
local timerForceCast			= mod:NewCastTimer(4, 122713)
local timerForce				= mod:NewBuffActiveTimer(12.5, 122713)
local timerAttenuationCD		= mod:NewCDTimer(32.5, 127834)--32.5-41 second variations, when not triggered off exhale. It's ALWAYS 11 seconds after exhale.
local timerAttenuation			= mod:NewBuffActiveTimer(14, 127834)
local timerConvertCD			= mod:NewCDTimer(33, 122740)--33-50 second variations

local berserkTimer				= mod:NewBerserkTimer(660)

mod:AddBoolOption("MindControlIcon", true)
mod:AddBoolOption("ArrowOnAttenuation", true)

local MCTargets = {}
local MCIcon = 8
local platform = 0
local EchoAlive = false--Will be used for the very accurate phase 2 timers when an echo is left up on purpose. when convert is disabled the other 2 abilities trigger failsafes that make them predictable. it's the ONLY time phase 2 timers are possible. otherwise they are too variable to be useful
local tqcount = 0
local qpcount = 0

local ptwo = false


mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudMAP2", true, "sound")
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local ExhaleMarkers = {}
local MindControlMarkers = {}

mod:AddDropdownOption("optarrowRTI", {"none", "arrow1", "arrow2", "arrow3", "arrow4", "arrow5", "arrow6", "arrow7"}, "none", "sound")

mod:AddDropdownOption("optDR", {"noDR", "DR1", "DR2", "DR3", "DR4", "DR5"}, "noDR", "sound")
mod:AddDropdownOption("optDRT", {"noDRT", "DRT1", "DRT2", "DRT3", "DRT4", "DRT5"}, "noDRT", "sound")

local function showMCWarning()
	warnConvert:Show(table.concat(MCTargets, "<, >"))
	timerConvertCD:Start()
	table.wipe(MCTargets)
	MCIcon = 8
end

local function ArrowRTI(rindex)
    for i = 1, GetNumGroupMembers() do
        if GetRaidTargetIndex(UnitName("raid"..i)) == rindex then
			HudMap:AddEdge(1, 1, 1, 1, 10, "player", UnitName("raid"..i))
			break
		end
	end
end

function mod:OnCombatStart(delay)
	platform = 0
	qpcount = 0
	ptwo = false
	EchoAlive = false
	table.wipe(MCTargets)
	if self:IsDifficulty("heroic10", "heroic25") then
		berserkTimer:Start(-delay)
	else
		berserkTimer:Start(600-delay)--still 10 min on normal. they only raised it to 11 minutes on heroic apparently.
	end
	table.wipe(ExhaleMarkers)
	table.wipe(MindControlMarkers)
end

function mod:OnCombatEnd()
	if self.Options.HudMAP or self.Options.HudMAP2 then
		DBMHudMap:FreeEncounterMarkers()
	end
	if self.Options.ArrowOnAttenuation then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122852) then
		warnInhale:Show(args.destName, args.amount or 1)
		tqcount = args.amount or 1
	elseif args:IsSpellID(122761) then
		warnExhale:Show(args.destName)
		specwarnExhale:Show(tqcount, args.destName)
		timerExhale:Start(args.destName)
		if args.destName == UnitName("player") then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\targetyou.mp3") --目標是你
		end
		if self.Options.HudMAP then
			local spelltext = GetSpellInfo(122761).." - "..args.destName
			ExhaleMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("targeting", args.destName, 3, 6, 1, 0, 0, 1):SetLabel(spelltext))
		end
	elseif args:IsSpellID(122740) then
		MCTargets[#MCTargets + 1] = args.destName
		if self.Options.MindControlIcon then
			self:SetIcon(args.destName, MCIcon)
			MCIcon = MCIcon - 1
		end
		self:Unschedule(showMCWarning)
		self:Schedule(0.9, showMCWarning)
		if self.Options.HudMAP2 then
			local spelltext2 = args.destName
			MindControlMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("targeting", args.destName, 3, nil, 1, 0, 0, 1):SetLabel(spelltext2))
		end
		if self:AntiSpam(2, 2) then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\findmc.mp3") --注意心控
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122761) then
		timerExhale:Cancel(args.destName)
		if ExhaleMarkers[args.destName] then
			ExhaleMarkers[args.destName] = free(ExhaleMarkers[args.destName])
		end
	elseif args:IsSpellID(122740) then
		if self.Options.MindControlIcon then
			self:SetIcon(args.destName, 0)
		end
		if MindControlMarkers[args.destName] then
			MindControlMarkers[args.destName] = free(MindControlMarkers[args.destName])
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122713) then
		timerForce:Start()
		specwarnForce:Show()
		if mod:IsHealer() then
			sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\healall.mp3") --注意群療
		end
		if self.Options.optarrowRTI == "arrow1" then
			ArrowRTI(1)
		elseif self.Options.optarrowRTI == "arrow2" then
			ArrowRTI(2)
		elseif self.Options.optarrowRTI == "arrow3" then
			ArrowRTI(3)
		elseif self.Options.optarrowRTI == "arrow4" then
			ArrowRTI(4)
		elseif self.Options.optarrowRTI == "arrow5" then
			ArrowRTI(5)
		elseif self.Options.optarrowRTI == "arrow6" then
			ArrowRTI(6)
		elseif self.Options.optarrowRTI == "arrow7" then
			ArrowRTI(7)
		end
	elseif args:IsSpellID(122761) and self:AntiSpam(2, 1) then
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_tqzb.mp3") --吐氣準備
		specwarnExhaleB:Show(tqcount)
	elseif args:IsSpellID(122474, 122496, 123721, 122513) then
		if self.Options.ArrowOnAttenuation then
			DBM.Arrow:ShowStatic(90, 12)
		end
		specwarnAttenuationL:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_zzyb.mp3") --左轉音波
		timerAttenuation:Start()
		if platform < 4 then
			timerAttenuationCD:Start()
		else
			if EchoAlive then--if echo isn't active don't do any timers
				if args:GetSrcCreatureID() == 65173 then--Echo
					timerAttenuationCD:Start(28, args.sourceGUID)--Because both echo and boss can use it in final phase and we want 2 bars
				else--Boss
					timerAttenuationCD:Start(54, args.sourceGUID)
				end
			end
		end
	elseif args:IsSpellID(122479, 122497, 123722, 122514) then
		if self.Options.ArrowOnAttenuation then
			DBM.Arrow:ShowStatic(270, 12)
		end
		specwarnAttenuationR:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_yzyb.mp3") --右轉音波
		timerAttenuation:Start()
		if platform < 4 then
			timerAttenuationCD:Start()
		else
			if EchoAlive then--if echo isn't active don't do any timers
				if args:GetSrcCreatureID() == 65173 then--Echo
					timerAttenuationCD:Start(28, args.sourceGUID)--Because both echo and boss can use it in final phase and we want 2 bars
				else--Boss
					timerAttenuationCD:Start(54, args.sourceGUID)
				end
			end
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(124018) then
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3") --P2
		ptwo = true
		qpcount = 0
		platform = 4--He moved to middle, it's phase 2, although platform "4" is better then adding an extra variable.
		timerConvertCD:Cancel()
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Platform or msg:find(L.Platform) then
		platform = platform + 1
		if platform > 1 then
			specwarnPlatform:Show()
			if platform < 4 then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\justrun.mp3") --快跑
			end
		end
		timerForceCD:Cancel()
		timerAttenuationCD:Cancel()
		if platform == 1 then
			timerForceCD:Start(16)
		elseif platform == 2 then
			timerAttenuationCD:Start(23)
		elseif platform == 3 then
			timerConvertCD:Start(22.5)
		end
	end
end

--"<55.0 21:38:55> [CLEU] UNIT_DIED#true#0x0000000000000000#nil#-2147483648#-2147483648#0xF130FE9600003072#Echo of Force and Verve#68168#0", -- [10971]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122933 then--Clear Throat (4 seconds before force and verve)
		if self:LatencyCheck() then
			self:SendSync("ForceandVerve")
		end
	elseif (spellId == 127542 or spellId == 127541 or spellId == 130297) and not EchoAlive then--Echo of Zor'lok (127542 is platform 1 echo spawn, 127541 is platform 2 echo spawn, 130297 is phase 2 echos)
		EchoAlive = true
		if platform == 1 then--Boss flew off from first platform to 2nd, and this means the echo that spawned is an Echo of Force and Verve
--			timerForceCD:Start()
		elseif platform == 2 then--Boss flew to 3rd platform and left an Echo of Attenuation behind on 2nd.
--			timerAttenuationCD:Start()
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 68168 then--Echo of Force and Verve
		EchoAlive = false
		timerForceCD:Cancel()
	elseif cid == 65173 then--Echo of Attenuation
		EchoAlive = false
		if platform < 4 then
			timerAttenuationCD:Cancel()
		else--No echo left up in final phase, cancel al timers because they are going to go back to clusterfuck random (as in may weave convert in but may not, and delay other abilities by as much as 30-50 seconds)
			timerAttenuationCD:Cancel()
			timerForceCD:Cancel()
		end
	end
end

function mod:OnSync(msg)
	if msg == "ForceandVerve" then
		warnForceandVerve:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_dyq.mp3") --快進定音區
		timerForceCast:Start()
		qpcount = qpcount + 1
		if (((self.Options.optDR == "DR1" and qpcount == 1) or (self.Options.optDR == "DR2" and qpcount == 2) or (self.Options.optDR == "DR3" and qpcount == 3) or (self.Options.optDR == "DR4" and qpcount == 4) or (self.Options.optDR == "DR5" and qpcount == 5)) and not ptwo) or (((self.Options.optDRT == "DRT1" and qpcount == 1) or (self.Options.optDRT == "DRT2" and qpcount == 2) or (self.Options.optDRT == "DRT3" and qpcount == 3) or (self.Options.optDRT == "DRT4" and qpcount == 4) or (self.Options.optDRT == "DRT5" and qpcount == 5)) and ptwo) then
			sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
			specwarnDR:Schedule(3)
		end
		if platform < 4 then
			timerForceCD:Start()
		else
			if EchoAlive then
				timerForceCD:Start(54)
			end
		end
	end
end