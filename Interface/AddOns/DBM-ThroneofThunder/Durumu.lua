local mod	= DBM:NewMod(818, "DBM-ThroneofThunder", nil, 362)
local L		= mod:GetLocalizedStrings()
--BH ADD
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11365 $"):sub(12, -3))
mod:SetCreatureID(68036)--Crimson Fog 69050
mod:SetEncounterID(1572)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 1)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISS",
	"CHAT_MSG_MONSTER_EMOTE",
	"UNIT_DIED",
	"UNIT_AURA",
	"UNIT_SPELLCAST_SUCCEEDED"
)

local warnHardStare					= mod:NewSpellAnnounce(133765, 3, nil, mod:IsTank() or mod:IsHealer())--Announce CAST not debuff, cause it misses a lot, plus we have 1 sec to hit an active mitigation
local warnForceOfWill				= mod:NewTargetAnnounce(136413, 4)
local warnLingeringGaze				= mod:NewTargetAnnounce(138467, 3)
mod:AddBoolOption("warnBeam", nil, "announce")
local warnBeamNormal				= mod:NewAnnounce("warnBeamNormal", 4, 139204, true, false)
local warnBeamHeroic				= mod:NewAnnounce("warnBeamHeroic", 4, 139204, true, false)
local warnAddsLeft					= mod:NewAnnounce("warnAddsLeft", 2, 134123)
local warnDisintegrationBeam		= mod:NewSpellAnnounce("ej6882", 4)
local warnLifeDrain					= mod:NewTargetAnnounce(133795, 3)--Some times needs to block this even dps. So warn for everyone.
local warnDarkParasite				= mod:NewTargetAnnounce(133597, 3, nil, mod:IsHealer())--Heroic
local warnIceWall					= mod:NewSpellAnnounce(134587, 3, 111231)

local specWarnSeriousWound			= mod:NewSpecialWarningStack(133767, mod:IsTank(), 5)--This we will use debuff on though.
local specWarnSeriousWoundOther		= mod:NewSpecialWarningTarget(133767, mod:IsTank())
local specWarnForceOfWill			= mod:NewSpecialWarningYou(136413, nil, nil, nil, 3)--VERY important, if you get hit by this you are out of fight for rest of pull.
local specWarnForceOfWillNear		= mod:NewSpecialWarningClose(136413, nil, nil, nil, 3)
local yellForceOfWill				= mod:NewYell(136413)
local specWarnLingeringGaze			= mod:NewSpecialWarningYou(134044)
local yellLingeringGazeFix			= mod:NewYell(134044)
local specWarnLingeringGazeMove		= mod:NewSpecialWarningMove(134044)
local specWarnBlueBeam				= mod:NewSpecialWarning("specWarnBlueBeam", nil, nil, nil, 3)
local specWarnBlueBeamLFR			= mod:NewSpecialWarningYou(139202, nil, nil, nil, 3)
local specWarnRedBeam				= mod:NewSpecialWarningYou(139204, nil, nil, nil, 3)
local specWarnYellowBeam			= mod:NewSpecialWarningYou(133738, nil, nil, nil, 3)
local specWarnDarkParasite			= mod:NewSpecialWarningYou(133597)
local yellDarkParasite				= mod:NewYell(133597)
local specWarnFogRevealed			= mod:NewSpecialWarning("specWarnFogRevealed", nil, nil, nil, 2)--Use another "Be Aware!" sound because Lingering Gaze comes on Spectrum phase.
local specWarnDisintegrationBeam	= mod:NewSpecialWarningSpell("ej6882", nil, nil, nil, 2)
local specWarnEyeSore				= mod:NewSpecialWarningMove(140502)
local specWarnLifeDrain				= mod:NewSpecialWarningTarget(133795, mod:IsTank())
local yellLifeDrainFix				= mod:NewYell(133795)
local specWarnHold					= mod:NewSpecialWarning("specWarnHold", nil, nil, nil, 2)

local timerHardStareCD				= mod:NewCDTimer(12, 133765, mod:IsTank() or mod:IsHealer())
local timerSeriousWound				= mod:NewTargetTimer(60, 133767, mod:IsTank() or mod:IsHealer())
local timerLingeringGazeCD			= mod:NewCDTimer(46, 138467)
local timerForceOfWillCD			= mod:NewCDTimer(20, 136413)--Actually has a 20 second cd but rarely cast more than once per phase because of how short the phases are (both beams phases cancel this ability)
local timerLightSpectrumCD			= mod:NewNextTimer(60, "ej6891")
local timerDisintegrationBeam		= mod:NewBuffActiveTimer(55, "ej6882")
local timerDisintegrationBeamCD		= mod:NewNextTimer(136, "ej6882")
local timerLifeDrainCD				= mod:NewCDTimer(40, 133795)
local timerLifeDrain				= mod:NewBuffActiveTimer(18, 133795)
local timerIceWallCD				= mod:NewNextTimer(120, 134587, nil, nil, nil, 111231)
local timerDarkParasiteCD			= mod:NewNextTimer(62, 133597)
local timerDarkParasite				= mod:NewTargetTimer(30, 133597, mod:IsHealer())--Only healer/dispeler needs to know this.
local timerDarkPlague				= mod:NewTargetTimer(30, 133598)--EVERYONE needs to know this, if dispeler messed up and dispelled parasite too early you're going to get a new add every 3 seconds for remaining duration of this bar.
local timerObliterateCD				= mod:NewNextTimer(80, 137747)--Heroic

--BH DELETE local soundLingeringGaze			= mod:NewSound(134044)

local berserkTimer					= mod:NewBerserkTimer(600)

mod:AddBoolOption("SetIconRays", true)
mod:AddBoolOption("SetIconLifeDrain", true)
mod:AddBoolOption("InfoFrameLife", not mod:IsHealer()) -- may be need special warning or generic warning high stack player? or do not needed at all?
mod:AddBoolOption("InfoFrame", mod:IsHealer()) -- may be need special warning or generic warning high stack player? or do not needed at all?
mod:AddBoolOption("Sayam", true, "sound")
mod:AddBoolOption("SetIconOnParasite", false)
mod:AddBoolOption("SetParticle", false)

local totalFogs = 3
local lingeringGazeTargets = {}
local lingeringGazeCD = 46
local darkParasiteTargets = {}
local darkParasiteTargetsIcons = {}
local lastRed = nil
local lastBlue = nil
local lastYellow = nil
local spectrumStarted = false
local lifeDrained = false
local lfrCrimsonFogRevealed = false
local lfrAmberFogRevealed = false
local lfrAzureFogRevealed = false
local lfrEngaged = false
local blueTracking = GetSpellInfo(139202)
local redTracking = GetSpellInfo(139204)
local crimsonFog = EJ_GetSectionInfo(6892)
local amberFog = EJ_GetSectionInfo(6895)
local azureFog = EJ_GetSectionInfo(6898)
local playerName = UnitName("player")
local CVAR = nil

--BH ADD
local rgbcount = 0
local lifecount = 0
local paracount = 0
local lightmaker = {}
local linemaker = {}
local lightcheck = {}
local lightphase = false
local paranmu = 0
mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("DXsound", false, "sound")
mod:AddDropdownOption("optDD", {"nodd", "DD1", "DD2", "DD3", "HDD1", "HDD2", "HDD3"}, "nodd", "sound")
mod:AddEditBoxOption("soundhold", 50, "20", "sound")
mod:AddEditBoxOption("sounddisp", 50, "15", "sound")
mod:AddEditBoxOption("xx1", 300, L.xx1noset, "sound")
mod:AddEditBoxOption("xx2", 300, L.xx2noset, "sound")
mod:AddEditBoxOption("xx3", 300, L.xx3noset, "sound")

mod:AddEditBoxOption("lifeA", 150, "", "sound")
mod:AddEditBoxOption("lifeB", 150, "", "sound")
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local function lightchoose()
	if ((rgbcount == 1) and (mod.Options.optDD == "DD1")) or ((rgbcount == 2) and (mod.Options.optDD == "DD3")) or ((rgbcount == 3) and (mod.Options.optDD == "DD2")) or (mod.Options.optDD == "HDD1") then
		sndWOP:Play("ex_tt_hsfd") --紅色分擔
		if mod.Options.HudMAP then
			lightmaker[lastRed] = register(DBMHudMap:AddEdge(0, 0, 1, 1, 10, "player", lastRed))
		end
	elseif ((rgbcount == 1) and ((mod.Options.optDD == "DD2") or (mod.Options.optDD == "HDD3"))) or ((rgbcount == 2) and ((mod.Options.optDD == "DD1") or (mod.Options.optDD == "HDD3"))) or ((rgbcount == 3) and ((mod.Options.optDD == "DD3") or (mod.Options.optDD == "HDD2"))) then
		sndWOP:Play("ex_tt_hufd") --黃色分擔
		if mod.Options.HudMAP then
			lightmaker[lastYellow] = register(DBMHudMap:AddEdge(0, 0, 1, 1, 10, "player", lastYellow))
		end
	elseif ((rgbcount == 1) and ((mod.Options.optDD == "DD3") or (mod.Options.optDD == "HDD2"))) or ((rgbcount == 2) and ((mod.Options.optDD == "DD2") or (mod.Options.optDD == "HDD2"))) or ((rgbcount == 3) and ((mod.Options.optDD == "DD1") or (mod.Options.optDD == "HDD3"))) then
		sndWOP:Play("ex_tt_lsfd") --藍色分擔
		if mod.Options.HudMAP then
			lightmaker[lastBlue] = register(DBMHudMap:AddEdge(0, 0, 1, 1, 10, "player", lastBlue))
		end	
	end
end

--BH ADD END

local function warnLingeringGazeTargets()
	warnLingeringGaze:Show(table.concat(lingeringGazeTargets, "<, >"))
	table.wipe(lingeringGazeTargets)
end

local function warnDarkParasiteTargets()
	warnDarkParasite:Show(table.concat(darkParasiteTargets, "<, >"))
	table.wipe(darkParasiteTargets)
	if UnitDebuff("player", GetSpellInfo(133597)) then
		sndWOP:Play("ex_tt_nbjs")--你被寄生		
	elseif mod:IsHealer() then
		sndWOP:Play("ex_tt_hajs")--黑暗寄生
	end
end

local function warnBeam()
	if mod:IsDifficulty("heroic10", "heroic25", "lfr25") then
		warnBeamHeroic:Show(lastRed, lastBlue, lastYellow)
	else
		warnBeamNormal:Show(lastRed, lastBlue)
	end
end

local function BeamEnded()
	timerLingeringGazeCD:Start(17)
	timerForceOfWillCD:Start(19)
	if mod:IsDifficulty("heroic10", "heroic25") then
		timerIceWallCD:Start(32)
	end
	if mod:IsDifficulty("lfr25") then
		timerLightSpectrumCD:Start(66)
		sndWOP:Schedule(63, "ex_tt_syg") --三原光準備
		sndWOP:Schedule(64, "countthree")
		sndWOP:Schedule(65, "counttwo")
		sndWOP:Schedule(66, "countone")
		timerDisintegrationBeamCD:Start(186)
		mod:Schedule(176, function()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_tt_tenwj") --10秒後瓦解光束
			sndWOP:Schedule(5, "countfive")
			sndWOP:Schedule(6, "countfour")	
			sndWOP:Schedule(7, "countthree")
			sndWOP:Schedule(8, "counttwo")
			sndWOP:Schedule(9, "countone")
		end)
	else
		timerLightSpectrumCD:Start(39)
		sndWOP:Schedule(36, "ex_tt_syg") --三原光準備
		sndWOP:Schedule(37, "countthree")
		sndWOP:Schedule(38, "counttwo")
		sndWOP:Schedule(39, "countone")
		timerDisintegrationBeamCD:Start()
		mod:Schedule(126, function()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_tt_tenwj") --10秒後瓦解光束
			sndWOP:Schedule(5, "countfive")
			sndWOP:Schedule(6, "countfour")	
			sndWOP:Schedule(7, "countthree")
			sndWOP:Schedule(8, "counttwo")
			sndWOP:Schedule(9, "countone")
		end)
	end
end

local function HideInfoFrame()
	if mod.Options.InfoFrameLife then
		DBM.InfoFrame:Hide()
	end
	if mod.Options.InfoFrame and mod:IsDifficulty("heroic10", "heroic25") then
		DBM.InfoFrame:SetHeader(GetSpellInfo(133597).."("..paracount..")")
		DBM.InfoFrame:Show(3, "playerdebuffstackstime", 133597)
	end
end

function mod:OnCombatStart(delay)
	lingeringGazeCD = 46
	lastRed = nil
	lastBlue = nil
	lastYellow = nil
	spectrumStarted = false
	lifeDrained = false
	lfrCrimsonFogRevealed = false
	lfrAmberFogRevealed = false
	lfrAzureFogRevealed = false
	CVAR = nil
	--BH ADD
	lightphase = false
	rgbcount = 0
	lifecount = 0
	paracount = 0
	paranmu = 0
	table.wipe(lightmaker)
	table.wipe(linemaker)
	table.wipe(lightcheck)
	--BH ADD END
	table.wipe(lingeringGazeTargets)
	table.wipe(darkParasiteTargets)
	timerHardStareCD:Start(5-delay)
	timerLingeringGazeCD:Start(15.5-delay)
	timerForceOfWillCD:Start(33.5-delay)
	timerLightSpectrumCD:Start(40-delay)
	sndWOP:Schedule(37-delay, "ex_tt_syg") --三原光準備
	sndWOP:Schedule(38-delay, "countthree")
	sndWOP:Schedule(39-delay, "counttwo")
	sndWOP:Schedule(40-delay, "countone")
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDarkParasiteCD:Start(-delay)
		timerIceWallCD:Start(127-delay)
	end
	if self:IsDifficulty("lfr25") then
		lfrEngaged = true
		timerLifeDrainCD:Start(151)
		timerDisintegrationBeamCD:Start(161-delay)
		self:Schedule(151, function()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_tt_tenwj") --10秒後瓦解光束
			sndWOP:Schedule(5, "countfive")
			sndWOP:Schedule(6, "countfour")	
			sndWOP:Schedule(7, "countthree")
			sndWOP:Schedule(8, "counttwo")
			sndWOP:Schedule(9, "countone")
		end)
	else
		timerLifeDrainCD:Start(210)
		timerDisintegrationBeamCD:Start(135-delay)
		self:Schedule(125, function()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_tt_tenwj") --10秒後瓦解光束
			sndWOP:Schedule(5, "countfive")
			sndWOP:Schedule(6, "countfour")	
			sndWOP:Schedule(7, "countthree")
			sndWOP:Schedule(8, "counttwo")
			sndWOP:Schedule(9, "countone")
		end)
	end
	berserkTimer:Start(-delay)
	if self.Options.SetParticle and GetCVar("particleDensity") then
		CVAR = GetCVar("particleDensity")--Cvar was true on pull so we remember that.
		SetCVar("particleDensity", 10)
	end
end

function mod:OnCombatEnd()
--[[	if self.Options.ArrowOnBeam then
		DBM.Arrow:Hide()
	end--]]
	lfrEngaged = false
	if self.Options.SetIconRays and lastRed then
		self:SetIcon(lastRed, 0)
	end
	if self.Options.SetIconRays and lastBlue then
		self:SetIcon(lastBlue, 0)
	end
	if self.Options.InfoFrame or self.Options.InfoFrameLife then
		DBM.InfoFrame:Hide()
	end
	if CVAR then--CVAR was set on pull which means we changed it, change it back
		SetCVar("particleDensity", CVAR)
	end
end

local function ClearParasiteTargets()
	table.wipe(darkParasiteTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetParasiteIcons()
		table.sort(darkParasiteTargetsIcons, sort_by_group)
		local parasiteIcon = 5
		for i, v in ipairs(darkParasiteTargetsIcons) do
			self:SetIcon(v, parasiteIcon)
			parasiteIcon = parasiteIcon - 1
		end
		self:Schedule(1.5, ClearParasiteTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 133765 then
		warnHardStare:Show()
		timerHardStareCD:Start()
	elseif args.spellId == 138467 then
		timerLingeringGazeCD:Start(lingeringGazeCD)
	elseif args.spellId == 136154 and self:IsDifficulty("lfr25") and not lfrCrimsonFogRevealed then--Only use in lfr.
		lfrCrimsonFogRevealed = true
		specWarnFogRevealed:Show(crimsonFog)
		sndWOP:Play("ex_hong") --紅色快打
	elseif args.spellId == 134587 and self:AntiSpam(3, 3) then
		warnIceWall:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 136932 then--Force of Will Precast
		warnForceOfWill:Show(args.destName)
		if timerLightSpectrumCD:GetTime() > 22 or timerDisintegrationBeamCD:GetTime() > 110 then--Don't start timer if either beam or spectrum will come first (cause both disable force ability)
			timerForceOfWillCD:Start()
		end
		if args:IsPlayer() then
			specWarnForceOfWill:Show()
			yellForceOfWill:Yell()
			if not self:IsDifficulty("lfr25") then
				DBM.Flash:Shake(1, 0, 0)
				sndWOP:Play("runaway")
			end
		else
			if not self:IsDifficulty("lfr25") then
				sndWOP:Play("carefly") --小心擊飛
			end
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				if inRange and inRange < 21 then--Range hard to get perfect, a player 30 yards away might still be in it. I say 15 is probably good middle ground to catch most of the "near"
					specWarnForceOfWillNear:Show(args.destName)
				end
			end
		end
	elseif args.spellId == 134122 then--Blue Beam Precas
		lingeringGazeCD = not spectrumStarted and 25 or 40 -- First spectrum Lingering Gaze CD = 25, second = 40
		spectrumStarted = true
		lastBlue = args.destName
		--BH ADD
		if rgbcount == 3 then rgbcount = 0 end
		rgbcount = rgbcount + 1
		--BH ADD END
		if args:IsPlayer() then
			if self:IsDifficulty("lfr25") and self.Options.specWarnBlueBeam then
				specWarnBlueBeamLFR:Show()
			else
				specWarnBlueBeam:Show()
			end
			DBM.Flash:Shake(0, 0, 1)
			sndWOP:Play("ex_tt_lgzb") --藍光
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 6)--Square
		end
		self:Schedule(0.5, warnBeam)
	elseif args.spellId == 134123 then--Red Beam Precast
		lastRed = args.destName
		if args:IsPlayer() then
			specWarnRedBeam:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_tt_hgzb") --紅光
		end
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 7)--Cross
		end
	elseif args.spellId == 134124 then--Yellow Beam Precast
		lastYellow = args.destName
		totalFogs = 3
		lfrCrimsonFogRevealed = false
		lfrAmberFogRevealed = false
		lfrAzureFogRevealed = false
		timerForceOfWillCD:Cancel()
		mod:Schedule(10, function()
			lightphase = true
		end)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerObliterateCD:Start()
			if lifeDrained then -- Check 1st Beam ended.
				timerIceWallCD:Start(88.5)
			end
		end
		if args:IsPlayer() then
			specWarnYellowBeam:Show()
			DBM.Flash:Shake(1, 1, 0)			
			sndWOP:Play("ex_tt_hgsd") --黃光
		end
		mod:Schedule(1.5, function()
			if (lastRed ~= UnitName("player")) and (lastBlue ~= UnitName("player")) and (lastYellow ~= UnitName("player")) then
				lightchoose()
			elseif lastYellow == UnitName("player") then
				mod:Schedule(8.5, function()
					lightchoose()
				end)
			end
		end)
		if self.Options.SetIconRays then
			self:SetIcon(args.destName, 1, 10)--Star (auto remove after 10 seconds because this beam untethers one initial person positions it.
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 133767 then
		timerSeriousWound:Start(args.destName)
		if (args.amount or 1) >= 5 then
			if args:IsPlayer() then
				specWarnSeriousWound:Show(args.amount)
			else
				if not UnitDebuff("player", GetSpellInfo(133767)) and not UnitIsDeadOrGhost("player") then
					specWarnSeriousWoundOther:Show(args.destName)
					if mod:IsTank() then
						sndWOP:Play("changemt") --換坦嘲諷
					end
				end
			end
		end
	elseif args.spellId == 133597 and not args:IsDestTypeHostile() then--Dark Parasite (filtering the wierd casts they put on themselves periodicly using same spellid that don't interest us and would mess up cooldowns)
		darkParasiteTargets[#darkParasiteTargets + 1] = args.destName
		local _, _, _, _, _, duration = UnitDebuff(args.destName, args.spellName)
		timerDarkParasite:Start(duration, args.destName)
		self:Unschedule(warnDarkParasiteTargets)
		if (self:IsDifficulty("heroic25") and #darkParasiteTargets >= 3) or self:IsDifficulty("heroic10") then
			warnDarkParasiteTargets()
		else
			self:Schedule(0.5, warnDarkParasiteTargets)
		end
		if self.Options.SetIconOnParasite and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(darkParasiteTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetParasiteIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				if (self:IsDifficulty("heroic25") and #darkParasiteTargets >= 3) or self:IsDifficulty("heroic10") then
					self:SetParasiteIcons()
				else
					self:ScheduleMethod(0.5, "SetParasiteIcons")
				end
			end
		end
		paranmu = paranmu + 1
		if args:IsPlayer() then
			specWarnDarkParasite:Show()
			yellDarkParasite:Yell()
			local soundholdtime = tonumber(mod.Options.soundhold)
			if soundholdtime > 0 then				
				self:Schedule(soundholdtime, function()
					if UnitDebuff("player", GetSpellInfo(133597)) then
						specWarnHold:Show(soundholdtime)
						DBM.Flash:Shake(1, 0, 0)
						sndWOP:Play("holdit") --快開自保
					end
				end)
			end
		end
		if self:AntiSpam(5, 4) then
			paracount = paracount + 1
			local sounddisptime = tonumber(mod.Options.sounddisp)
			if sounddisptime > 0 and sounddisptime < 30 then
				self:Schedule(30 - sounddisptime, function()
					if paranmu > 0 then
						sndWOP:Play("helpdispel") --幫忙驅散
					end
				end)
			end
			if paracount == 1 then
				timerDarkParasiteCD:Start(60)
			elseif paracount == 2 then
				timerDarkParasiteCD:Start(78)
			elseif paracount == 3 then
				timerDarkParasiteCD:Start(72)
			elseif paracount == 4 then
				timerDarkParasiteCD:Start(117)
			elseif paracount == 5 then
				timerDarkParasiteCD:Start(72)
			end
			if mod.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(GetSpellInfo(133597).."("..paracount..")")
				DBM.InfoFrame:Show(3, "playerdebuffstackstime", 133597)
			end
		end
	elseif args.spellId == 133598 then--Dark Plague
		local _, _, _, _, _, duration = UnitDebuff(args.destName, args.spellName)
		--maybe add a warning/special warning for everyone if duration is too high and many adds expected
		timerDarkPlague:Start(duration, args.destName)
	elseif args.spellId == 134626 then
		lingeringGazeTargets[#lingeringGazeTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnLingeringGaze:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("ex_tt_xxns")--小心凝視
			sndWOP:Schedule(1, "leavecenter")
			sndWOP:Schedule(2, "leavecenter")
			yellLingeringGazeFix:Yell()
--BH DELETE		soundLingeringGaze:Play()
		end
		self:Unschedule(warnLingeringGazeTargets)
		if #lingeringGazeTargets >= 5 and self:IsDifficulty("normal25", "heroic25") or #lingeringGazeTargets >= 2 and self:IsDifficulty("normal10", "heroic10") then--TODO, add LFR number of targets
			warnLingeringGazeTargets()
		else
			self:Schedule(0.5, warnLingeringGazeTargets)
		end
	elseif args.spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target. If target warning needed, insert into this block. (maybe very spammy)
		self:SetIcon(args.destName, 8)--Skull
	elseif args.spellId == 133798 then
		if (args.amount or 1) >= 2 and (args.amount or 1) % 2 == 0 then
			sndWOP:Play("ex_tt_bmdx")--幫忙擋線
		end
		if args:IsPlayer() then
			if self.Options.Sayam then
				if (args.amount or 1) == 1 then
					local sayxx1 = mod.Options.xx1
					SendChatMessage(sayxx1, "SAY")
				elseif (args.amount or 1) == 2 then
					local sayxx2 = mod.Options.xx2
					SendChatMessage(sayxx2, "SAY")
					if mod.Options.lifeA ~= "" then
						local saytara = mod.Options.lifeA
						SendChatMessage(L.dx ,"WHISPER" ,nil ,saytara);
						SendChatMessage(L.dx ,"WHISPER" ,nil ,saytara);
						SendChatMessage(L.dx ,"WHISPER" ,nil ,saytara);
					end
					if mod.Options.lifeB ~= "" then
						local saytarb = mod.Options.lifeB
						SendChatMessage(L.dx ,"WHISPER" ,nil ,saytarb);
						SendChatMessage(L.dx ,"WHISPER" ,nil ,saytarb);
						SendChatMessage(L.dx ,"WHISPER" ,nil ,saytarb);
					end
				else
					local sayxx3 = mod.Options.xx3
					sayxx3 = sayxx3.."("..args.amount..args.amount..args.amount..args.amount..args.amount..args.amount..args.amount..")"
					SendChatMessage(sayxx3, "SAY")
				end
			end
		end
		if self.Options.InfoFrameLife and (not self.Options.InfoFrame) then
			DBM.InfoFrame:Update("playerdebuffstacks")
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 133767 then
		timerSeriousWound:Cancel(args.destName)
	elseif args.spellId == 137727 and self.Options.SetIconLifeDrain then -- Life Drain current target.
		self:SetIcon(args.destName, 0)
	elseif args.spellId == 133597 then--Dark Parasite
		if self.Options.SetIconOnParasite then
			self:SetIcon(args.destName, 0)
		end
		paranmu = paranmu - 1
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 134044 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnLingeringGazeMove:Show()
		sndWOP:Play("runaway") --快躲開
	elseif spellId == 133677 then --藍
		lightcheck[destName] = "blue"
	elseif spellId == 133738 then --黃
		lightcheck[destName] = "yellow"
	elseif spellId == 133732 then --紅
		lightcheck[destName] = "red"
	end
	if not lfrEngaged or lfrAmberFogRevealed then return end -- To reduce cpu usage normal and heroic.
	if destName == amberFog and not lfrAmberFogRevealed then -- Lfr Amger fog do not have CLEU, no unit events and no emote.
		lfrAmberFogRevealed = true
		specWarnFogRevealed:Show(amberFog)
		sndWOP:Play("ex_huang") --黃色快打
	end
end

function mod:SPELL_MISSED(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 134044 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnLingeringGazeMove:Show()
		sndWOP:Play("runaway") --快躲開
	elseif spellId == 133677 then --藍
		lightcheck[destName] = "blue"
	elseif spellId == 133738 then --黃
		lightcheck[destName] = "yellow"
	elseif spellId == 133732 then --紅
		lightcheck[destName] = "red"
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 134755 and destGUID == UnitGUID("player") and self:AntiSpam(3, 2) then
		specWarnEyeSore:Show()
		sndWOP:Play("runaway") --快躲開
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

--Blizz doesn't like combat log anymore for some spells
function mod:CHAT_MSG_MONSTER_EMOTE(msg, npc, _, _, target)
	if (npc == crimsonFog or npc == amberFog or npc == azureFog) and self:AntiSpam(1, npc) then
		if self:IsDifficulty("lfr25") and npc == azureFog and not lfrAzureFogRevealed then
			lfrAzureFogRevealed = true
			specWarnFogRevealed:Show(npc)
			sndWOP:Play("ex_lan") --藍色快打
		elseif not lfrAzureFogRevealed or not self:IsDifficulty("lfr25") then
			specWarnFogRevealed:Show(npc)
			--BH ADD
			if npc == azureFog then
				if lastBlue == UnitName("player") then
					DBM.Flash:Shake(0, 0, 1)
					sndWOP:Play("stopmove") --停止移動
				else
					sndWOP:Play("ex_tt_lgcx") --蓝怪出現
				end
			elseif npc == crimsonFog then
				if lastRed == UnitName("player") then
					DBM.Flash:Shake(1, 0, 0)
					sndWOP:Play("stopmove") --停止移動
				else
					sndWOP:Play("ex_hong") --紅色快打
				end
			elseif npc == amberFog then
				DBM.Flash:Shake(1, 1, 0)
				sndWOP:Play("ex_huang") --黃色快打
			end
			--BH ADD END
		end
	elseif msg:find("spell:133795") then--Does show in combat log, but emote gives targetname 3 seconds earlier.
		local target = DBM:GetUnitFullName(target)
		warnLifeDrain:Show(target)
		specWarnLifeDrain:Show(target)
		timerLifeDrain:Start()
		lifecount = lifecount + 1
		if lifecount == 3 then
			timerLifeDrainCD:Start(105)
		else
			timerLifeDrainCD:Start()
		end
		lifeDrained = true
		if target == UnitName("player") then
			DBM.Flash:Shake(1, 0, 0)
			yellLifeDrainFix:Yell()
			sndWOP:Play("ex_tt_xxdn") --吸血點你
		else
			if lightphase then
				if lightcheck[target] then
					if lightcheck[target] == "blue" then
						sndWOP:Play("ex_tt_lqxx") --藍區吸血
					elseif lightcheck[target] == "red" then
						sndWOP:Play("ex_tt_hqxx") --紅區吸血
					elseif lightcheck[target] == "yellow" then
						sndWOP:Play("ex_tt_yqxx") --黃區吸血
					end
				else
					sndWOP:Play("ex_tt_smxq") --生命吸取
				end
			else
				sndWOP:Play("ex_tt_smxq")
			end
		end		
		if self.Options.SetIconLifeDrain then
			self:SetIcon(target, 8)--Skull
		end
		if self.Options.InfoFrameLife then
			DBM.InfoFrame:SetHeader(GetSpellInfo(133795))
			DBM.InfoFrame:Show(5, "playerdebuffstacks", 133798)
		end
		self:Schedule(21, HideInfoFrame)
		if mod.Options.DXsound then
			linemaker[target] = register(DBMHudMap:AddEdge(1, 0, 0, 1, 1, "player", target))
			self:Schedule(1.5, function()
				linemaker[target] = register(DBMHudMap:AddEdge(1, 0, 0, 1, 1, "player", target))
			end)
			self:Schedule(3, function()
				linemaker[target] = register(DBMHudMap:AddEdge(1, 0, 0, 1, 1, "player", target))
			end)
			self:Schedule(4.5, function()
				linemaker[target] = register(DBMHudMap:AddEdge(1, 0, 0, 1, 1, "player", target))
			end)
		end
	elseif msg:find("spell:134169") then
		lingeringGazeCD = 46 -- Return to Original CD.
		timerForceOfWillCD:Cancel()
		timerLingeringGazeCD:Cancel()
		warnDisintegrationBeam:Show()
		specWarnDisintegrationBeam:Show()
		--Best to start next phase bars when this one ends, so artifically create a "phase end" trigger
		timerDisintegrationBeam:Start()
		sndWOP:Schedule(51, "countfive")
		sndWOP:Schedule(52, "countfour")	
		sndWOP:Schedule(53, "countthree")
		sndWOP:Schedule(54, "counttwo")
		sndWOP:Schedule(55, "countone")
		self:Schedule(55, BeamEnded)
	end
end

--Because blizz sucks and these do NOT show in combatlog AND the emote only fires for initial application,
--we register high performance costing event to work around for beam jump detection
function mod:UNIT_AURA(uId)
	if UnitDebuff(uId, blueTracking) then
		local name = DBM:GetUnitFullName(uId)
		if lastBlue ~= name then
			lastBlue = name
			if name == UnitName("player") then
				if self:IsDifficulty("lfr25") and self.Options.specWarnBlueBeam then
					specWarnBlueBeamLFR:Show()
				else
					specWarnBlueBeam:Show()
				end
				DBM.Flash:Shake(0, 0, 1)
				sndWOP:Play("ex_tt_lgzb") --藍光
			end
--[[		if self.Options.SetIconRays then
				self:SetIcon(name, 6)--Square
			end]]
		end
	elseif UnitDebuff(uId, redTracking) then
		local name = DBM:GetUnitFullName(uId)
		if lastRed ~= name then
			lastRed = name
			if name == UnitName("player") then
				specWarnRedBeam:Show()
				DBM.Flash:Shake(1, 0, 0)
				sndWOP:Play("ex_tt_hgzb") --紅光
			end
--[[		if self.Options.SetIconRays then
				self:SetIcon(name, 7)--Cross
			end]]
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 69050 then--Crimson Fog
		totalFogs = totalFogs - 1
		if totalFogs >= 1 then
			warnAddsLeft:Show(totalFogs)
			if lastRed == UnitName("player") then
				sndWOP:Play("cntnuemove") --紅怪死亡
			end
		else--No adds left, force ability is re-enabled
			timerObliterateCD:Cancel()
			timerForceOfWillCD:Start(15)
			if self.Options.SetIconRays and lastRed then
				self:SetIcon(lastRed, 0)
			end
			if self.Options.SetIconRays and lastBlue then
				self:SetIcon(lastBlue, 0)
			end
			lastRed = nil
			lastBlue = nil
			lastYellow = nil
			lightphase = false
			table.wipe(lightcheck)
		end
	elseif cid == 69051 then--Amber Fog
		--Maybe do something for heroic here too, if timers for the crap this thing does gets added.
		if self:IsDifficulty("lfr25") then
			totalFogs = totalFogs - 1
			if totalFogs >= 1 then
				--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
				warnAddsLeft:Show(totalFogs)
			else--No adds left, force ability is re-enabled
				timerObliterateCD:Cancel()
				timerForceOfWillCD:Start(15)
				if self.Options.SetIconRays and lastRed then
					self:SetIcon(lastRed, 0)
				end
				if self.Options.SetIconRays and lastBlue then
					self:SetIcon(lastBlue, 0)
				end
				lastRed = nil
				lastBlue = nil
				lastYellow = nil
				lightphase = false
				table.wipe(lightcheck)
			end
		end
	elseif cid == 69052 then--Azure Fog (endlessly respawn in all but LFR, so we ignore them dying anywhere else)
		--Maybe do something for heroic here too, if timers for the crap this thing does gets added.
		if self:IsDifficulty("lfr25") then
			totalFogs = totalFogs - 1
			if totalFogs >= 1 then
				--LFR does something completely different than kill 3 crimson adds to end phase. in LFR, they kill 1 of each color (which is completely against what you do in 10N, 25N, 10H, 25H)
				warnAddsLeft:Show(totalFogs)
			else--No adds left, force ability is re-enabled
				timerObliterateCD:Cancel()
				timerForceOfWillCD:Start(15)
				if self.Options.SetIconRays and lastRed then
					self:SetIcon(lastRed, 0)
				end
				if self.Options.SetIconRays and lastBlue then
					self:SetIcon(lastBlue, 0)
				end
				lastRed = nil
				lastBlue = nil
				lastYellow = nil
				lightphase = false
				table.wipe(lightcheck)
			end
		end
	end
end
