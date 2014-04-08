local mod	= DBM:NewMod(743, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndYB		= mod:NewSound(nil, "SoundYB", true)

mod:SetRevision(("$Revision: 9668 $"):sub(12, -3))
mod:SetCreatureID(62837)--62847 Dissonance Field, 63591 Kor'thik Reaver, 63589 Set'thik Windblade
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL",
	"RAID_BOSS_EMOTE",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnScreech				= mod:NewSpellAnnounce(123735, 3, nil, false)--Not useful.
local warnCryOfTerror			= mod:NewTargetAnnounce(123788, 3, nil, mod:IsRanged())
local warnEyes					= mod:NewStackAnnounce(123707, 2, nil, mod:IsTank())
local warnDissonanceField		= mod:NewCountAnnounce(123255, 3)
local warnDr					= mod:NewAnnounce("warnDr", 1, 118191)
local warnSonicDischarge		= mod:NewSoonAnnounce(123504, 4)--Iffy reliability but better then nothing i suppose.
local warnRetreat				= mod:NewSpellAnnounce(125098, 4)
local warnAmberTrap				= mod:NewAnnounce("warnAmberTrap", 2, 125826)
local warnTrapped				= mod:NewTargetAnnounce(125822, 1)--Trap used
local warnStickyResin			= mod:NewTargetAnnounce(124097, 3)
local warnFixate				= mod:NewTargetAnnounce(125390, 3, nil, false)--Spammy
local warnAdvance				= mod:NewSpellAnnounce(125304, 4)
local warnVisions				= mod:NewTargetAnnounce(124862, 4)--Visions of Demise
local warnPhase3				= mod:NewPhaseAnnounce(3)
local warnCalamity				= mod:NewSpellAnnounce(124845, 3, nil, mod:IsHealer())
local warnConsumingTerror		= mod:NewSpellAnnounce(124849, 4, nil, not mod:IsTank())
local warnHeartOfFear			= mod:NewTargetAnnounce(125638, 4)

local specwarnSonicDischarge	= mod:NewSpecialWarningSpell(123504, nil, nil, nil, true)
local specWarnEyes				= mod:NewSpecialWarningStack(123707, mod:IsTank(), 4)
local specWarnEyesOther			= mod:NewSpecialWarningTarget(123707, mod:IsTank())
local specwarnCryOfTerror		= mod:NewSpecialWarningYou(123788)
local specWarnRetreat			= mod:NewSpecialWarningSpell(125098)
local specwarnAmberTrap			= mod:NewSpecialWarningSpell(125826, false)
local specwarnStickyResin		= mod:NewSpecialWarningYou(124097)
local yellStickyResin			= mod:NewYell(124097, nil, false)
local specwarnFixate			= mod:NewSpecialWarningYou(125390)
local specWarnDispatch			= mod:NewSpecialWarningInterrupt(124077, mod:IsMelee())
local specWarnAdvance			= mod:NewSpecialWarningSpell(125304)
local specwarnVisions			= mod:NewSpecialWarningYou(124862)
local specwarnXJ				= mod:NewSpecialWarningMove(123184)
local yellVisions				= mod:NewYell(124862, nil, false)
local specWarnConsumingTerror	= mod:NewSpecialWarningSpell(124849, not mod:IsTank())
local specWarnHeartOfFear		= mod:NewSpecialWarningYou(125638)
local yellHeartOfFear			= mod:NewYell(125638)
local specWarnjs				= mod:NewSpecialWarning("specWarnjs")
local specWarnTT				= mod:NewSpecialWarning("specWarnTT")

local timerScreechCD			= mod:NewNextTimer(7, 123735, nil, false)
local timerCryOfTerror			= mod:NewTargetTimer(20, 123788, nil, mod:IsHealer())
local timerCryOfTerrorCD		= mod:NewCDTimer(25, 123788, nil, mod:IsRanged())
local timerEyes					= mod:NewTargetTimer(30, 123707, nil, mod:IsTank())
local timerEyesCD				= mod:NewNextTimer(11, 123707, nil, mod:IsTank())
local timerDissonanceFieldCD	= mod:NewNextCountTimer(65, 123255)
local timerPhase1				= mod:NewNextTimer(156.4, 125304)--156.4 til ENGAGE fires and boss is out, 157.4 until "advance" fires though. But 156.4 is more accurate timer
local timerDispatchCD			= mod:NewCDTimer(12, 124077)--Every 12-15 seconds on 25 man. on 10 man i've heard it's every 20ish?
local timerPhase2				= mod:NewNextTimer(151, 125098)--152 until trigger, but probalby 150 or 151 til adds are targetable.
local timerCalamityCD			= mod:NewCDTimer(6, 124845, nil, mod:IsHealer())
local timerVisionsCD			= mod:NewCDTimer(19.5, 124862)
local timerConsumingTerrorCD	= mod:NewCDTimer(32, 124849, nil, not mod:IsTank())
local timerCorruptedDissonance	= mod:NewNextTimer(20, 126122)--10 seconds after first and 20 seconds after
local timerHeartOfFear			= mod:NewBuffFadesTimer(6, 125638)

local berserkTimer				= mod:NewBerserkTimer(900)

local timerQJ					= mod:NewTargetTimer(120, 124821)
local timerDQ					= mod:NewBuffFadesTimer(30, 124827)

mod:AddBoolOption("InfoFrame")--On by default because these do more then just melee, they interrupt spellcasting (bad for healers)

mod:AddBoolOption("InfoYB", true, "sound")

mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("StickyResinIcons", true)

local warnedLowHP = {}
local warnedLowHP5 = {}
local warnedLowHP4 = {}
local warnedLowHP3 = {}
local warnedLowHP2 = {}
local warnedLowHP1 = {}
local visonsTargets = {}
local resinTargets = {}
local resinIcon = 2
local shaName = EJ_GetEncounterInfo(709)
local phase3Started = false
local warnedhp = false
local hp = 100
local warnhp = 11

local ybhp = {}
local sh = {}

local fieldCount = 0
local swcount = 0
local hjplayer = 0
local sendhjpos = ""

local function MyDR()  --公會P3減傷提示
	mod:Schedule(10, function()
		warnDr:Show("薩滿A","靈魂連接",10)
		if mod.Options.optjs == "shaman1" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("靈魂連接")
		end
	end)
	mod:Schedule(20, function()
		warnDr:Show("薩滿A","寧靜圖騰",20)
		if mod.Options.optjs == "shaman1" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("寧靜圖騰")
		end
	end)
	mod:Schedule(30, function()
		warnDr:Show("騎士A","虔誠光環",30)
		if mod.Options.optjs == "pal1" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("虔誠光環")
		end
	end)
	mod:Schedule(40, function()
		warnDr:Show("補牧A","罩子",40)
		if mod.Options.optjs2 == "priest1" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("罩子")
		end
	end)
	mod:Schedule(50, function()
		warnDr:Show("騎士B","虔誠光環",50)
		if mod.Options.optjs == "pal2" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("虔誠光環")
		end
	end)
	mod:Schedule(60, function()
		warnDr:Show("補牧B","罩子",60)
		if mod.Options.optjs2 == "priest2" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("罩子")
		end
	end)
	mod:Schedule(70, function()
		warnDr:Show("騎士C","虔誠光環",70)
		if mod.Options.optjs == "pal3" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("虔誠光環")
		end
	end)
	mod:Schedule(80, function()
		warnDr:Show("戰士A","吼血",80)
		if mod.Options.optjs == "warrior1" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("吼血")
		end
	end)
	mod:Schedule(90, function()
		warnDr:Show("暗牧","吸血鬼",90)
		if mod.Options.optjs2 == "priest4" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("吸血鬼")
		end
	end)
	mod:Schedule(100, function()
		warnDr:Show("死騎","罩子",100)
		if mod.Options.optjs == "dk" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("罩子")
		end
	end)
	mod:Schedule(110, function()
		warnDr:Show("牧師C","罩子",110)
		if mod.Options.optjs2 == "priest3" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("罩子")
		end
	end)
	mod:Schedule(120, function()
		warnDr:Show("薩滿B","寧靜圖騰",120)
		if mod.Options.optjs == "shaman2" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("寧靜圖騰")
		end
	end)
	mod:Schedule(130, function()
		warnDr:Show("薩滿B","靈魂連接",130)
		if mod.Options.optjs == "shaman2" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("靈魂連接")
		end
	end)
	mod:Schedule(140, function()
		warnDr:Show("小德","寧靜",140)
		if mod.Options.optjs == "druid" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("寧靜")
		end
	end)
	mod:Schedule(150, function()
		warnDr:Show("戰士B","吼血",150)
		if mod.Options.optjs == "warrior2" then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
			specWarnjs:Show("吼血")
		end
	end)
end

--[[
1:1 5 6 9
2:2 7 10 11
3:3 4 8 12
]]

local function MyTT()
	if (mod.Options.optDR == "DR1" and (swcount == 1 or swcount == 5 or swcount == 6 or swcount == 9 )) or (mod.Options.optDR == "DR2" and (swcount == 2 or swcount == 7 or swcount == 10 or swcount == 11 )) or (mod.Options.optDR == "DR3" and (swcount == 3 or swcount == 4 or swcount == 8 or swcount == 12 )) then
		return true
	end
	return false
end

local RunPos = {
  ["A"] = 	{ 442, 233 },
  ["B"] = 	{ 442, 268 },
  ["C"] = 	{ 451, 250 },
  ["D"] = 	{ 426, 227 },
  ["E"] = 	{ 427, 274 },
}

local function warnVisionsTargets()
	warnVisions:Show(table.concat(visonsTargets, "<, >"))
	timerVisionsCD:Start()
	table.wipe(visonsTargets)
end

local ptwo = false

mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("HudMAPOther", true, "sound")
mod:AddBoolOption("HudMAP2", false, "sound")
mod:AddBoolOption("SendPos", true, "sound")
mod:AddBoolOption("AcceptPos", true, "sound")
mod:AddDropdownOption("optDR", {"noDR", "DR1", "DR2", "DR3"}, "noDR", "sound")
if GetGuildInfo("player") then
	if string.find(GetGuildInfo("player"), "黑手") then
		mod:AddDropdownOption("optjs", {"non", "shaman1", "shaman2", "pal1", "pal2", "pal3", "dk", "warrior1", "warrior2", "druid"}, "non", "sound")
		mod:AddDropdownOption("optjs2", {"non2", "priest1", "priest2", "priest3", "priest4"}, "non2", "sound")
	end
end

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local DeadMarkers = {}
local DeadEg = nil
local QJMarkers = {}

function mod:OnCombatStart(delay)
	phase3Started = false
	resinIcon = 2
	fieldCount = 0
	timerScreechCD:Start(-delay)
	timerEyesCD:Start(-delay)
	timerDissonanceFieldCD:Start(20.5-delay, 1)
	timerPhase2:Start(-delay)
	berserkTimer:Start(-delay)
	table.wipe(warnedLowHP)
	table.wipe(warnedLowHP5)
	table.wipe(warnedLowHP4)
	table.wipe(warnedLowHP3)
	table.wipe(warnedLowHP2)
	table.wipe(warnedLowHP1)
	table.wipe(ybhp)
	table.wipe(visonsTargets)
	table.wipe(resinTargets)
	table.wipe(DeadMarkers)
	table.wipe(QJMarkers)
	ptwo = false
	warnedhp = false
	hp = 100
	hp1 = 100
	hp2 = 100
	swcount = 0
	hjplayer = 0
	DeadEg = nil
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
	self:RegisterShortTermEvents(
		"UNIT_HEALTH_FREQUENT_UNFILTERED"
	)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMAP or self.Options.HudMAP2 or self.Options.HudMAPOther then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123707) then
		warnEyes:Show(args.destName, args.amount or 1)
		timerEyes:Start(args.destName)
		timerEyesCD:Start()
		if args:IsPlayer() and (args.amount or 1) >= 4 then
			specWarnEyes:Show(args.amount)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_csgg.mp3") --層數過高
		else
			if (args.amount or 1) >= 3 and not UnitDebuff("player", GetSpellInfo(123735)) and not UnitIsDeadOrGhost("player") then
				specWarnEyesOther:Show(args.destName)
				if mod:IsTank() then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
				end
			end
		end
	elseif args:IsSpellID(123788) then
		warnCryOfTerror:Show(args.destName)
		timerCryOfTerror:Start(args.destName)
		timerCryOfTerrorCD:Start()
		if args:IsPlayer() then
			specwarnCryOfTerror:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_kjyy.mp3") --快進音域
		end
	elseif args:IsSpellID(124748) then
		warnAmberTrap:Show(args.amount or 1)
		table.wipe(resinTargets)
	elseif args:IsSpellID(125822) then
		warnTrapped:Show(args.destName)
	elseif args:IsSpellID(125390) then
		warnFixate:Show(args.destName)
		if args:IsPlayer() then
			specwarnFixate:Show()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\justrun.mp3") --快跑
		end
	elseif args:IsSpellID(124862) then
		visonsTargets[#visonsTargets + 1] = args.destName
		if args:IsPlayer() then
			specwarnVisions:Show()
			yellVisions:Yell()
			DBM.Flash:Shake(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runout.mp3") --離開人群
			sndWOP:Schedule(1.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
		if self:AntiSpam(5, 3) then
			swcount = swcount + 1
			if MyTT() then
				specWarnTT:Schedule(1, swcount, 3)
				specWarnTT:Schedule(2, swcount, 2)
				specWarnTT:Schedule(3, swcount, 1)
				sndWOP:Schedule(1, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_zlzb.mp3") --戰慄準備
				sndWOP:Schedule(1.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(2.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(3.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
			if swcount == 12 then swcount = 0 end
		end
		if mod:IsHealer() then
			sndWOP:Schedule(4, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3")
		end
		self:Unschedule(warnVisionsTargets)
		self:Schedule(0.3, warnVisionsTargets)
		if args:IsPlayer() then
			if self.Options.HudMAP then
				DeadMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("reticle", args.destName, 9, nil, 0, 1, 0, 0.5):Appear():RegisterForAlerts():Rotate(360, 4))
			end
		else	
			if self.Options.HudMAPOther then
				DeadMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("ring", args.destName, 9, nil, 0, 1, 0, 1):Appear():RegisterForAlerts())
			end
		end
		if self.Options.SendPos and UnitIsGroupLeader("player") then
			hjplayer = hjplayer + 1
			self:Schedule(5, function() hjplayer = 0 end)
			sendhjpos = (hjplayer == 1) and "A" or (hjplayer == 2) and "B" or (hjplayer == 3) and "C" or (hjplayer == 4) and "D" or (hjplayer == 5) and "E"
			self:SendSync("swpos", args.destName, sendhjpos)
		end
	elseif args:IsSpellID(124097) then
		if args:IsPlayer() and self:AntiSpam(5, 2) then --prevent spam in heroic
			specwarnStickyResin:Show()
			DBM.Flash:Shake(1, 1, 0)
			yellStickyResin:Yell()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_szkp.mp3") --樹脂
		end
		if not resinTargets[args.destName] then --prevent spam in heroic
			resinTargets[args.destName] = true
			warnStickyResin:Show(args.destName)
			if self.Options.StickyResinIcons then
				self:SetIcon(args.destName, resinIcon)
				if resinIcon == 2 then
					resinIcon = 1
				else
					resinIcon = 2
				end
			end
		end
	elseif args:IsSpellID(123184) then
		if not UnitDebuff("player", GetSpellInfo(123788)) then
			if args:IsPlayer() then
				specwarnXJ:Show()
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開
			end
		end
	elseif args:IsSpellID(124821) then
		timerQJ:Start(120, args.destName)
		if self.Options.HudMAP2 then
			QJMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 2, nil, 0, 1, 0, 1):Appear():RegisterForAlerts():Rotate(360, 120))
		end
	elseif args:IsSpellID(124827) then
		if args:IsPlayer() then
			timerDQ:Start()
		end
	elseif args:IsSpellID(124077) then
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then--Only show warning for your own target.
			specWarnDispatch:Show(args.sourceName)
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--快打斷
		end
		if self:IsDifficulty("normal25", "heroic25", "lfr25") then
			timerDispatchCD:Start()--25 is about 12-15 variation
		else
			timerDispatchCD:Start(21)--Longer Cd on 10 man (21-24 variation)
		end
	elseif args:IsSpellID(123845) then
		warnHeartOfFear:Show(args.destName)
		if args:IsPlayer() then
			specWarnHeartOfFear:Show()
			yellHeartOfFear:Yell()
			timerHeartOfFear:Start()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_lxkp.mp3")--連線快跑
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123788) then
		timerCryOfTerror:Cancel(args.destName)
	elseif args:IsSpellID(123707) then
		if mod:IsTank() and (not ptwo) then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
		end
	elseif args:IsSpellID(125390) then
		if args:IsPlayer() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\safenow.mp3") --安全
		end
	elseif args:IsSpellID(124097) then
		if self.Options.StickyResinIcons then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(124862) then
		if DeadMarkers[args.destName] then
			DeadMarkers[args.destName] = free(DeadMarkers[args.destName])
		end
	elseif args:IsSpellID(124821) then
		timerQJ:Cancel(args.destName)
		if QJMarkers[args.destName] then
			QJMarkers[args.destName] = free(QJMarkers[args.destName])
		end
	elseif args:IsSpellID(124827) then
		if args:IsPlayer() then
			timerDQ:Cancel()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123735) then
		warnScreech:Show()
		timerScreechCD:Start()
	elseif args:IsSpellID(125826) then
		specwarnAmberTrap:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_xjwc.mp3") --陷阱完成
	elseif args:IsSpellID(124845) then
		warnCalamity:Show()
		timerCalamityCD:Start()
	--"<33.5 22:57:49> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#No more excuses, Empress! Eliminate these cretins or I will kill you myself!#Sha of Fear###Grand Empress Shek'zeer
	--"<36.8 22:57:52> [CLEU] SPELL_CAST_SUCCESS#false#0xF130F9C600007497#Sha of Fear#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#125451#Ultimate Corruption#1", -- [7436]
	--backup phase 3 trigger for unlocalized languages
	elseif args:IsSpellID(125451) and not phase3Started then
		phase3Started = true
		self:UnregisterShortTermEvents()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerPhase2:Cancel()
		timerConsumingTerrorCD:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerDissonanceFieldCD:Cancel()
		timerScreechCD:Cancel()
		warnPhase3:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\pthree.mp3")--p3
		timerVisionsCD:Start(4)
		timerCalamityCD:Start(9)
		timerConsumingTerrorCD:Start(11)
		if GetGuildInfo("player") then
			if string.find(GetGuildInfo("player"), "黑手") and self:IsDifficulty("heroic25") then
				MyDR()
			end
		end
	elseif args:IsSpellID(123255) and self:AntiSpam(2, 4) then
		fieldCount = fieldCount + 1
		warnDissonanceField:Show(fieldCount)
		if fieldCount < 2 then
			timerDissonanceFieldCD:Start(nil, fieldCount+1)
		end
		if self:IsDifficulty("heroic10", "heroic25") then
			if fieldCount == 1 then
				timerCorruptedDissonance:Start(10)
			else
				timerCorruptedDissonance:Start()
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(124849) then
		warnConsumingTerror:Show()
		specWarnConsumingTerror:Show()
		timerConsumingTerrorCD:Start()
		if mod:IsTank() then
			DBM.Flash:Shake(1, 0, 0)
		end
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_kjts.mp3")--恐懼吞噬
	end
end

--[[ Yell comes 3 seconds sooner then combat log event, so it's better phase 3 transitioner to start better timers, especially for first visions of demise
"<33.5 22:57:49> [CHAT_MSG_MONSTER_YELL] CHAT_MSG_MONSTER_YELL#No more excuses, Empress! Eliminate these cretins or I will kill you myself!#Sha of Fear###Grand Empress Shek'zeer
"<36.8 22:57:52> [CLEU] SPELL_CAST_SUCCESS#false#0xF130F9C600007497#Sha of Fear#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#125451#Ultimate Corruption#1", -- [7436]
--]]
function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.YellPhase3 or msg:find(L.YellPhase3)) and not phase3Started then
		phase3Started = true
		self:UnregisterShortTermEvents()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		timerPhase2:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerConsumingTerrorCD:Cancel()
		timerDissonanceFieldCD:Cancel()
		timerScreechCD:Cancel()
		warnPhase3:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\pthree.mp3")--p3
		timerVisionsCD:Start(7)
		timerCalamityCD:Start(12)
		timerConsumingTerrorCD:Start(14)
		if GetGuildInfo("player") then
			if string.find(GetGuildInfo("player"), "黑手") and self:IsDifficulty("heroic25") then
				MyDR()
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 125098 then--Yell is about 1.5 seconds faster then this event, BUT, it also requires localizing. I don't think doing it this way hurts anything.
		self:UnregisterShortTermEvents()
		table.wipe(resinTargets)
		timerScreechCD:Cancel()
		timerCryOfTerrorCD:Cancel()
		timerDissonanceFieldCD:Cancel()
		timerEyesCD:Cancel()
		warnRetreat:Show()
		specWarnRetreat:Show()
		timerPhase1:Start()
		ptwo = true
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\phasechange.mp3")--階段轉換
		sndWOP:Schedule(152, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_nwzb.mp3") --女王準備
		sndWOP:Schedule(153, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(154, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(155, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(156, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		if self.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(L.PlayerDebuffs)
			DBM.InfoFrame:Show(10, "playerbaddebuff", 125390)
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 125304 then
		fieldCount = 0
		timerPhase1:Cancel()--If you kill everything it should end early.
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_nwzb.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		warnAdvance:Show()
		specWarnAdvance:Show()
		timerDissonanceFieldCD:Start(20, 1)
		timerPhase2:Start()--Assumed same as pull
		ptwo = false
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\phasechange.mp3")--階段轉換
		sndWOP:Schedule(147, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")--P2
		sndWOP:Schedule(148, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Schedule(149, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(150, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(151, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		if self.Options.InfoFrame then--Will do this more accurately when i have an accurate count of mobs for all difficulties and then i can hide it when mobcount reaches 0
			DBM.InfoFrame:Hide()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
		self:RegisterShortTermEvents(
			"UNIT_HEALTH_FREQUENT_UNFILTERED"
		)
	end
end

--May not be that reliable, because they don't have a special unitID and there is little reason to target them.
--So it may miss some of them, not sure of any other way to PRE-warn though. Can warn on actual cast/damage but not too effective.
function mod:UNIT_HEALTH_FREQUENT_UNFILTERED(uId)
	local cid = self:GetUnitCreatureId(uId)
	local guid = UnitGUID(uId)
	if cid == 62847 then
		hp = UnitHealth(uId)
		if self:LatencyCheck() then
			self:SendSync("ybhealth", guid, hp)
		end
	end
	if uId == "player" then
		if UnitDebuff("player", GetSpellInfo(123184)) then
			if self:IsDifficulty("heroic10", "heroic25") then
				if UnitHealth(uId) / UnitHealthMax(uId) <= 0.8 and not warnedhp then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\checkhp.mp3")--注意血量
					warnedhp = true
				end
			else
				if UnitHealth(uId) / UnitHealthMax(uId) <= 0.5 and not warnedhp then
					sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\checkhp.mp3")
					warnedhp = true
				end
			end
		else
			warnedhp = false
		end
	end
end

function mod:OnSync(msg, guid, hp)
	if msg == "ybhealth" and guid and hp then
		ybhp[guid] = hp
		table.wipe(sh)
		for k,v in pairs(ybhp) do
			table.insert(sh,{K=k,V=v})
		end
		table.sort (sh,function(a,b) return a.V< b.V end)
		if self.Options.InfoYB then
			DBM.InfoFrame:SetHeader(GetSpellInfo(123184))
			if #sh == 2 then
				DBM.InfoFrame:Show(1, "other", sh[2].V, sh[1].V)
			elseif #sh == 1 then
				DBM.InfoFrame:Show(1, "other", "-", sh[1].V)
			end
		end
		warnhp = tonumber(ybhp[guid])
		if warnhp < 11 and not warnedLowHP[guid] then
			warnedLowHP[guid] = true
			warnSonicDischarge:Show()--This only works if someone in raid is actually targeting them :(
			specwarnSonicDischarge:Show()--But is extremly useful when they are.
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_ybbz.mp3") --音波爆炸準備
		end
		if warnhp == 5  and not warnedLowHP5[guid] then
			warnedLowHP5[guid] = true
			sndYB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		end
		if warnhp == 4  and not warnedLowHP4[guid] then
			warnedLowHP4[guid] = true
			sndYB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		end
		if warnhp == 3  and not warnedLowHP3[guid] then
			warnedLowHP3[guid] = true
			sndYB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		end
		if warnhp == 2  and not warnedLowHP2[guid] then
			warnedLowHP2[guid] = true
			sndYB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		end
		if warnhp == 1  and not warnedLowHP1[guid] then
			warnedLowHP1[guid] = true
			sndYB:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	elseif msg == "swpos" and guid and hp then
		if guid == UnitName("player") then
			if self.Options.AcceptPos then
				DeadEg = register(DBMHudMap:PlaceRangeMarker("timer", RunPos[hp][1], RunPos[hp][2], 2, 5, 0, 1, 0, 1):Appear():RegisterForAlerts())
				DeadEg = register(DBMHudMap:AddEdge(0, 0, 1, 1, 5, "player", nil, nil, nil, RunPos[hp][1],RunPos[hp][2]))
			end
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, _, _, _, _, spellId)
	if spellId == 123504 then
		if self.Options.InfoYB then
			if ybhp[sourceGUID] then ybhp[sourceGUID] = nil end
			table.wipe(sh)
			for k,v in pairs(ybhp) do
				table.insert(sh,{K=k,V=v})
			end
			if #sh == 0 then
				DBM.InfoFrame:Hide()
			end
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:126121") then
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_mop_yyfh.mp3") --音域腐化
	end
end