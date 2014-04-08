local mod	= DBM:NewMod(831, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
-- BH ADD
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndStrike	= mod:NewSound(nil, "SoundStrike", true)

mod:SetRevision(("$Revision: 10044 $"):sub(12, -3))
mod:SetCreatureID(69473)--69888
mod:SetQuestID(32753)
mod:SetZone()
mod:SetUsedIcons(2, 6)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_MONSTER_YELL"
)

local warnMurderousStrike						= mod:NewSpellAnnounce(138333, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
local specWarnMurderousStrike					= mod:NewSpecialWarningSpell(138333, mod:IsTank() or mod:IsHealer(), nil, nil, 3)
local timerMurderousStrikeCD					= mod:NewCDTimer(33, 138333, nil, mod:IsTank())

local warnFatalStrike							= mod:NewSpellAnnounce(138334, 4, nil, mod:IsTank() or mod:IsHealer())--Tank (think thrash, like sha. Gains buff, uses on next melee attack)
local specWarnFatalStrike						= mod:NewSpecialWarningSpell(138334, mod:IsTank() or mod:IsHealer(), nil, nil, 3)--Do all need to switch? how dangerous adds? more info needed
local timerFatalStrikeCD						= mod:NewCDTimer(10, 138334, nil, mod:IsTank())

local warnMaterialsofCreation					= mod:NewCountAnnounce(138321, 3)
local specWarnMaterialsofCreation				= mod:NewSpecialWarningCount(138321)
local timerMaterialsofCreationCD				= mod:NewCDCountTimer(31, 138321)
local specWarnCreationSwitch					= mod:NewSpecialWarningSwitch(138321, not mod:IsHealer())

local warnUnstableVita							= mod:NewTargetAnnounce(138297, 4)
local timerUnstableVita							= mod:NewTargetTimer(12, 138297)
local yellUnstableVita							= mod:NewYell(138297)
local specWarnUnstableVita						= mod:NewSpecialWarningYou(138297)
local specWarnUnstableVitaOther					= mod:NewSpecialWarningTarget(138297, false)
local specWarnVitarun							= mod:NewSpecialWarning("specWarnVitarun")

local warnUnstableAnima							= mod:NewTargetAnnounce(138288, 4)
local timerUnstableAnima						= mod:NewTimer(15, "timerAnima", 138295)
local specWarnUnstableAnima						= mod:NewSpecialWarningYou(138288)
local specWarnUnstableAnimaOther				= mod:NewSpecialWarningTarget(138288)

local warnPhase2								= mod:NewPhaseAnnounce(2, 2)

local warnCallEssence							= mod:NewSpellAnnounce(139040, 4, 139071)
local specWarnCallEssence						= mod:NewSpecialWarningSpell(139040, mod:IsDps())
local timerCallEssenceCD						= mod:NewNextTimer(15.5, 139040)

local warnRuinBolt								= mod:NewSpellAnnounce(139087)

local warnSummonSanguineHorror					= mod:NewCountAnnounce(138338, 3)
local specWarnSummonSanguineHorror				= mod:NewSpecialWarningSpell(138338)
local timerSummonSanguineHorror					= mod:NewCDCountTimer(40, 138338)

local warnSummonCracklingStalker				= mod:NewCountAnnounce(138339, 3)
local specWarnSummonCracklingStalker			= mod:NewSpecialWarningSpell(138339)
local timerSummonCracklingStalker				= mod:NewCDCountTimer(40, 138339)

local warnImbuedwithAnima						= mod:NewSpellAnnounce(138331, 3)
local warnImbuedwithVita						= mod:NewSpellAnnounce(138332, 3)

local warnUnleashedVita							= mod:NewSpellAnnounce(138330, 3)
local specWarnUnleashedVita						= mod:NewSpecialWarningSpell(138330)

local UnstableAnimatarget = nil
local UnstableAnimaMarkers = {}
local mylightnum = 0
local lightcount = 0
local lastlightnum = 0
local combat = false

local creationCount = 0
local stalkerCount = 0
local horrorCount = 0
local lastStalker = 0

mod:AddBoolOption("SetIconOnUnstableVita", true)
mod:AddBoolOption("SetIconOnUnstableAnima", true)

mod:AddBoolOption("HudMAPAnima", false, "sound")
mod:AddBoolOption("HudMAP", true, "sound")

mod:AddDropdownOption("optDD", {"nodd", "DD1", "DD2", "DD3", "DD4", "DD5"}, "nodd", "sound")
mod:AddEditBoxOption("lightnumber", 50, "0", "sound")
mod:AddEditBoxOption("lastnumber", 50, "0", "sound")

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local FireMarkers = {}

local function LoopUnstableAnima()
	mod:Unschedule(LoopUnstableAnima)
	timerUnstableAnima:Start()
	mod:Schedule(15, LoopUnstableAnima)
	if mod.Options.HudMAPAnima and UnstableAnimatarget then
		UnstableAnimaMarkers[UnstableAnimatarget] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", UnstableAnimatarget, 8, 5, 1, 1, 0, 0.8):Appear():RegisterForAlerts():Rotate(360, 5.5):SetAlertColor(0, 0, 1, 0.5))
	end
end

function mod:OnCombatStart(delay)
	table.wipe(UnstableAnimaMarkers)
	lightcount = 0
	combat = true
	creationCount = 0
	stalkerCount = 0
	horrorCount = 0
	table.wipe(FireMarkers)
	mylightnum = tonumber(mod.Options.lightnumber)
	lastlightnum = tonumber(mod.Options.lastnumber)
	timerMaterialsofCreationCD:Start(10-delay, 1)
end

function mod:OnCombatEnd()
	combat = false
	if self.Options.HudMAP or self.Options.HudMAPAnima then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 138321 then --造物材料
		creationCount = creationCount + 1
		warnMaterialsofCreation:Show(creationCount)
		specWarnMaterialsofCreation:Show(creationCount)
		timerMaterialsofCreationCD:Start(nil, creationCount+1)
		specWarnCreationSwitch:Schedule(2)
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_zbdq.mp3") --準備打球
		self:Schedule(1, function()
			DBM:PlayCountSound(creationCount)
		end)
	elseif args.spellId == 138338 then --召喚恐魔
		horrorCount = horrorCount + 1
		warnSummonSanguineHorror:Show(horrorCount)
		specWarnSummonSanguineHorror:Show()
		timerSummonSanguineHorror:Start(nil, horrorCount+1)
		if self:AntiSpam(2, 1) then
			if not mod:IsHealer() then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xgkd.mp3") --小怪快打
			end
		end
	elseif args.spellId == 138339 then --召唤龟裂追踪者
		lastStalker = GetTime()
		stalkerCount = stalkerCount + 1
		warnSummonCracklingStalker:Show(stalkerCount)
		specWarnSummonCracklingStalker:Show()
		timerSummonCracklingStalker:Start(nil, stalkerCount+1)
		if self:AntiSpam(2, 1) then
			if not mod:IsHealer() then
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xgkd.mp3")
			end
		end
	elseif args.spellId == 139087 then --毀滅箭
		warnRuinBolt:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 138330 then
		warnUnleashedVita:Show()
		specWarnUnleashedVita:Show()
	elseif args.spellId == 138333 then
		warnMurderousStrike:Show()
		specWarnMurderousStrike:Show()
	elseif args.spellId == 138334 then
		warnFatalStrike:Show()
		specWarnFatalStrike:Show()
		timerFatalStrikeCD:Start()
		if mod:IsTank() or mod:IsHealer() then
			sndStrike:Schedule(7, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndStrike:Schedule(8, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndStrike:Schedule(9, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 138297 then --不穩定的生命
		lightcount = lightcount + 1
		warnUnstableVita:Show(args.destName)
		if self:IsDifficulty("heroic25") then
			timerUnstableVita:Start(5, args.destName)
		else
			timerUnstableVita:Start(args.destName)
		end
		if args:IsPlayer() then
			yellUnstableVita:Yell()
			specWarnUnstableVita:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_smdn.mp3") --生命點你
			sndWOP:Schedule(0.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")  --快跑位
			if self:IsDifficulty("heroic25") then
				sndWOP:Schedule(1, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
				sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(4, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			else
				sndWOP:Schedule(7, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
				sndWOP:Schedule(8, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
				sndWOP:Schedule(9, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(10, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(11, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		else
			specWarnUnstableVitaOther:Show(args.destName)
		end
		if self.Options.HudMAP then
			local spelltext = GetSpellInfo(138297)
			FireMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", args.destName, 3, 10, 1, 0 ,0 ,0.8):SetLabel(spelltext))
		end
		if self.Options.SetIconOnUnstableVita then
			self:SetIcon(args.destName, 5)
		end
		if (lightcount == mylightnum) and (mod.Options.optDD == "nodd") then
			if UnitDebuff("player", GetSpellInfo(138372)) or UnitIsDeadOrGhost("player") then
				mod:SendSync("Bench1")
			else
				specWarnVitarun:Show()
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
			end
		end
		if lightcount == lastlightnum then lightcount = 0 end
	elseif args.spellId == 138308 then --生命轉移
		lightcount = lightcount + 1
		warnUnstableVita:Show(args.destName)
		if self:IsDifficulty("heroic25") then
			timerUnstableVita:Start(5, args.destName)
		else
			timerUnstableVita:Start(args.destName)
		end
		if args:IsPlayer() then
			yellUnstableVita:Yell()
			specWarnUnstableVita:Show()
			if self:IsDifficulty("heroic25") then
				sndWOP:Schedule(1, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
				sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(4, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			else
				sndWOP:Schedule(7, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
				sndWOP:Schedule(8, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
				sndWOP:Schedule(9, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(10, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(11, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		else
			specWarnUnstableVitaOther:Show(args.destName)
		end
		if self.Options.HudMAP then
			local spelltext = GetSpellInfo(138308)
			FireMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("highlight", args.destName, 3, 10, 1, 0 ,0 ,0.8):SetLabel(spelltext))
		end
		if self.Options.SetIconOnUnstableVita then
			self:SetIcon(args.destName, 5)
		end
		if (lightcount == mylightnum) and (mod.Options.optDD == "nodd") then
			if UnitDebuff("player", GetSpellInfo(138372)) or UnitIsDeadOrGhost("player") then
				mod:SendSync("Bench1")
			else
				specWarnVitarun:Show()
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
			end
		end
		if lightcount == lastlightnum then lightcount = 0 end
	elseif args.spellId == 138288 then --不稳定的心能
		warnUnstableAnima:Show(args.destName)
		UnstableAnimatarget = args.destName
		if args:IsPlayer() then
			specWarnUnstableAnima:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_tt_xndn.mp3") --心能點你
		else
			specWarnUnstableAnimaOther:Show(args.destName)
		end
		if self.Options.SetIconOnUnstableAnima then
			self:SetIcon(args.destName, 2)
		end
		LoopUnstableAnima()
	elseif args.spellId == 138331 then --灌输心能
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 3
		horrorCount = 0
		timerFatalStrikeCD:Cancel()
		timerSummonCracklingStalker:Cancel()
		timerMurderousStrikeCD:Start(33-radenPower)
		warnImbuedwithAnima:Show()
		timerSummonSanguineHorror:Start(10, 1)
	elseif args.spellId == 138332 then --灌输生命
		local radenPower = UnitPower("boss1")
		radenPower = radenPower / 10
		local stalkerupdate = nil
		if GetTime() - lastStalker < 32 then--Check if it's been at least 32 seconds since last stalker
			stalkerupdate = 40 - (GetTime() - lastStalker)--if not, find out how much time is left on internal stalker cd (cause CD doesn't actually reset when you reset vita, it just extends to 8-9 seconds if less than 8-9 seconds remaining)
		else
			stalkerupdate = 8
		end
		stalkerCount = 0
		warnImbuedwithVita:Show()
		timerMurderousStrikeCD:Cancel()
		timerSummonSanguineHorror:Cancel()
		timerSummonCracklingStalker:Start(stalkerupdate, 1)
		timerFatalStrikeCD:Start(10-radenPower)
		if mod:IsTank() or mod:IsHealer() then
			sndStrike:Schedule(10-radenPower-3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndStrike:Schedule(10-radenPower-2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndStrike:Schedule(10-radenPower-1, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(138297, 138308) then
		if self.Options.SetIconOnUnstableVita then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runin.mp3") --快回人群
		end
		if FireMarkers[args.destName] then
			FireMarkers[args.destName] = free(FireMarkers[args.destName])
		end
	elseif args.spellId == 138288 then
		self:Unschedule(LoopUnstableAnima)
		timerUnstableAnima:Cancel()
		if self.Options.SetIconOnUnstableAnima then
			self:SetIcon(args.destName, 0)
		end
	end
end
--"<299.6 01:54:51> CHAT_MSG_MONSTER_YELL#You still think victory possible? Fools!#Ra-den#####0#0##0#298#nil#0#false#false",
--"<299.9 01:54:51> [UNIT_SPELLCAST_SUCCEEDED] Ra-den [boss1:Ruin::0:139073]
function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 139040 then--Call Essence
		warnCallEssence:Show()
		specWarnCallEssence:Show()
		timerCallEssenceCD:Start()
	elseif spellId == 139073 then--Phase 2 (the Ruin Trigger)
		self:SendSync("Phase2")
	end
end

function mod:OnSync(msg, msg2)
	if not combat then return end
	if msg == "Bench1" and mod.Options.optDD == "DD1" then
		if UnitDebuff("player", GetSpellInfo(138372)) or UnitIsDeadOrGhost("player") then
			mod:SendSync("Bench2")
		else
			specWarnVitarun:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
		end
	elseif msg == "Bench2" and mod.Options.optDD == "DD2" then
		if UnitDebuff("player", GetSpellInfo(138372)) or UnitIsDeadOrGhost("player") then
			mod:SendSync("Bench3")
		else
			specWarnVitarun:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
		end
	elseif msg == "Bench3" and mod.Options.optDD == "DD3" then
		if UnitDebuff("player", GetSpellInfo(138372)) or UnitIsDeadOrGhost("player") then
			mod:SendSync("Bench4")
		else
			specWarnVitarun:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
		end
	elseif msg == "Bench4" and mod.Options.optDD == "DD4" then
		if UnitDebuff("player", GetSpellInfo(138372)) or UnitIsDeadOrGhost("player") then
			mod:SendSync("Bench5")
		else
			specWarnVitarun:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
		end
	elseif msg == "Bench5" and mod.Options.optDD == "DD5" then
		if (not UnitDebuff("player", GetSpellInfo(138372))) and (not UnitIsDeadOrGhost("player")) then
			specWarnVitarun:Show()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\movesoon.mp3")
		end
	elseif msg == "Phase2" then
		warnPhase2:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
		timerSummonCracklingStalker:Cancel()
		timerSummonSanguineHorror:Cancel()
		timerMurderousStrikeCD:Cancel()
		timerFatalStrikeCD:Cancel()
		timerMaterialsofCreationCD:Cancel()
		timerCallEssenceCD:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Defeat or msg:find(L.Defeat) then
		DBM:EndCombat(self)
	end
end

