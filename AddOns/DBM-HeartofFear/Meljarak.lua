local mod	= DBM:NewMod(741, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndJR	= mod:NewSound(nil, "SoundJR", true)
local sndDS	= mod:NewSound(nil, "SoundDS", true)

mod:SetRevision(("$Revision: 9886 $"):sub(12, -3))
mod:SetCreatureID(62397)
mod:SetZone()
mod:SetUsedIcons(1, 2)

mod:RegisterCombat("combat")

-- CC can be cast before combat. So needs to seperate SPELL_AURA_APPLIED for pre-used CCs before combat.
mod:RegisterEvents(
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_APPLIED"
)

mod:RegisterEventsInCombat(
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_AURA_UNFILTERED"
)

local warnWhirlingBlade					= mod:NewTargetAnnounce(121896, 4)--Target scanning not tested
local warnRainOfBlades					= mod:NewSpellAnnounce(122406, 4)
local warnRecklessness					= mod:NewTargetAnnounce(125873, 3)
local warnImpalingSpear					= mod:NewPreWarnAnnounce(122224, 20, 3)--Pre warn your CC is about to break. Maybe need to localize it later to better explain what option is for.
local warnAmberPrison					= mod:NewTargetAnnounce(121881, 3)
local warnCorrosiveResin				= mod:NewTargetAnnounce(122064, 3)
local warnMending						= mod:NewCastAnnounce(122193, 4)
local warnQuickening					= mod:NewCountAnnounce(122149, 4)--for Mass Dispel
local warnKorthikStrike					= mod:NewTargetAnnounce(123963, 3)
local warnWindBomb						= mod:NewTargetAnnounce(131830, 4)

local specWarnWhirlingBlade				= mod:NewSpecialWarningSpell(121896, nil, nil, nil, true)
local specWarnRainOfBlades				= mod:NewSpecialWarningSpell(122406, nil, nil, nil, true)
local specWarnRecklessness				= mod:NewSpecialWarningTarget(125873)
local specWarnReinforcements			= mod:NewSpecialWarningSpell("ej6554", mod:IsTank())
local specWarnAmberPrison				= mod:NewSpecialWarningYou(121881)
local yellAmberPrison					= mod:NewYell(121881)
local specWarnAmberPrisonOther			= mod:NewSpecialWarningSpell(121881, false)--Only people who are freeing these need to know this.
local specWarnCorrosiveResin			= mod:NewSpecialWarningRun(122064)
local yellCorrosiveResin				= mod:NewYell(122064, nil, false)
local specWarnCorrosiveResinPool		= mod:NewSpecialWarningMove(122125)
local specWarnMending					= mod:NewSpecialWarningInterrupt(122193)--Whoever is doing this or feels responsible should turn it on.
local specWarnQuickening				= mod:NewSpecialWarningTarget(122149, false)--^^
local specWarnQuickeningX				= mod:NewSpecialWarning("specWarnQuickeningX")
local specWarnBH						= mod:NewSpecialWarning("specWarnBH")
local specWarnKorthikStrike				= mod:NewSpecialWarningYou(123963)
local specWarnKorthikStrikeOther		= mod:NewSpecialWarningTarget(123963, mod:IsHealer())
local yellKorthikStrike					= mod:NewYell(123963)
local specWarnWindBomb					= mod:NewSpecialWarningMove(131830)
local specWarnWhirlingBladeMove			= mod:NewSpecialWarningMove(121898)
local yellWindBomb						= mod:NewYell(131830)

local timerWhirlingBladeCD				= mod:NewNextTimer(45.5, 121896)
local timerRainOfBladesCD				= mod:NewNextTimer(61.5, 122406)--60 CD, but Cd starts when last cast ends, IE 60+cast time. Starting cd off cast start is 61.5, but on pull it's 60.0
local timerRecklessness					= mod:NewBuffActiveTimer(30, 125873)
local timerReinforcementsCD				= mod:NewNextCountTimer(50, "ej6554")--EJ says it's 45 seconds after adds die but it's actually 50 in logs. EJ is not updated for current tuning.
local timerImpalingSpear				= mod:NewTargetTimer(50, 122224)--Filtered to only show your own target, may change to a popup option later that lets you pick whether you show ALL of them or your own (all will be spammy)
local timerAmberPrisonCD				= mod:NewCDTimer(36, 121876, nil, false)--Reduce bar spam like Zarthik / each add has their own CD. This is on by default since it concerns everyone.
local timerCorrosiveResinCD				= mod:NewCDTimer(36, 122064, nil, false)--^^
local timerResidue						= mod:NewBuffFadesTimer(120, 122055)
local timerMendingCD					= mod:NewNextTimer(37, 122193, nil, false)--To reduce bar spam, only those dealing with this should turn CD bar on, off by default / 37~37.5 sec
local timerQuickeningCD					= mod:NewNextTimer(37.3, 122149, nil, false)--^^37.3~37.6sec.
local timerKorthikStrikeCD				= mod:NewCDTimer(50, 123963)--^^
local timerWindBombCD					= mod:NewCDTimer(6, 131830)--^^

local berserkTimer						= mod:NewBerserkTimer(480)

mod:AddBoolOption("AmberPrisonIcons", true)
mod:AddBoolOption("NearAP", true, "sound")
mod:AddBoolOption("ReapetAP", true, "sound")
mod:AddBoolOption("RangeFrame", true, "sound")
mod:AddBoolOption("InfoFrame", not mod:IsDps(), "sound")

local apnear = 20
local addsCount = 0
local amberPrisonIcon = 2
local zarthikCount = 0
local firstStriked = false
local strikeTarget = GetSpellInfo(123963)
local strikeWarned = false
local amberPrisonTargets = {}
local ptwo = false

local qscount = 0
local cfcount = 0

local windBombTargets = {}
local zarthikGUIDS = {}
local guids = {}
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, DBM:GetNumGroupMembers() do
		guids[UnitGUID("raid"..i) or "none"] = GetRaidRosterInfo(i)
	end
end

mod:AddBoolOption("HudMAP", true, "sound")

mod:AddDropdownOption("optQS", {"noQS", "QS1", "QS2", "QS3", "allQS"}, "allQS", "sound")

mod:AddDropdownOption("optBH", {"noBH", "BH1", "BH2", "BH3", "BH4", "allBH"}, "noBH", "sound")

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local AmberPrisonMarkerscast = {}
local windBombTargets = {}

local function warnAmberPrisonTargets()
	warnAmberPrison:Show(table.concat(amberPrisonTargets, "<, >"))
	table.wipe(amberPrisonTargets)
end

local function warnWindBombTargets()
	warnWindBomb:Show(table.concat(windBombTargets, "<, >"))
	table.wipe(windBombTargets)
	timerWindBombCD:Start()
end

function mod:checkdebuff()
    if UnitDebuff("player", GetSpellInfo(121885)) then
		SendChatMessage(L.Helpme, "SAY")
        self:ScheduleMethod(4, "checkdebuff")
	end
end

function mod:OnCombatStart(delay)
	addsCount = 0
	qscount = 0
	cfcount = 0
	amberPrisonIcon = 2
	zarthikCount = 0
	firstStriked = false
	strikeWarned = false
	ptwo = false
	table.wipe(amberPrisonTargets)
	table.wipe(windBombTargets)
	table.wipe(zarthikGUIDS)
	timerWhirlingBladeCD:Start(35.5-delay)
	timerKorthikStrikeCD:Start(18-delay)
	timerRainOfBladesCD:Start(60-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	if mod:IsHealer() then
		sndWOP:Schedule(57, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(58, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(59, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	end
	table.wipe(AmberPrisonMarkerscast)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(3)
	end
end

function mod:OnCombatEnd()
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122224, 61721) and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		warnImpalingSpear:Schedule(30)
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzjs.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countten.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countnine.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counteight.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzjs.mp3")
		sndDS:Schedule(30, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzjs.mp3") --控制即將結束	
		sndDS:Schedule(40, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countten.mp3")
		sndDS:Schedule(41, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countnine.mp3")
		sndDS:Schedule(42, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counteight.mp3")	
		sndDS:Schedule(43, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndDS:Schedule(44, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndDS:Schedule(45, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")	
		sndDS:Schedule(46, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndDS:Schedule(47, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndDS:Schedule(48, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndDS:Schedule(49, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")	
		timerImpalingSpear:Start(args.destName)
	elseif args:IsSpellID(121881) then--Not a mistake, 121881 is targeting spellid.
		amberPrisonTargets[#amberPrisonTargets + 1] = args.destName
		if self.Options.HudMAP then
			AmberPrisonMarkerscast[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 3, 3, 1, 1, 1, 1):Appear():RegisterForAlerts():Rotate(360, 3))
		end
		if args:IsPlayer() then
			specWarnAmberPrison:Show()
			yellAmberPrison:Yell()
			if self.Options.ReapetAP then
				self:ScheduleMethod(7, "checkdebuff")
			end
			if not self:IsDifficulty("lfr25") then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runout.mp3") --離開人群
			end
		else
			self:Unschedule(warnAmberPrisonTargets)
			self:Schedule(0.3, warnAmberPrisonTargets)
			specWarnAmberPrisonOther:Show()
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				apnear = self.Options.NearAP and 30 or 200
				if inRange and inRange < apnear then
					if not UnitDebuff("player", GetSpellInfo(122055)) then
						if self:AntiSpam(2, 7) then
							if math.random(1, 2) == 1 then
								sndJR:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\helpme.mp3") --救我
							else
								sndJR:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\helpme2.mp3")
							end
						end
					end
				end
			end
		end
		if self.Options.AmberPrisonIcons then
			self:SetIcon(args.destName, amberPrisonIcon)
			if amberPrisonIcon == 2 then
				amberPrisonIcon = 1
			else
				amberPrisonIcon = 2
			end
		end
	elseif args:IsSpellID(122064) then
		warnCorrosiveResin:Show(args.destName)
		if args:IsPlayer() and self:AntiSpam(3, 7) then
			specWarnCorrosiveResin:Show()
			yellCorrosiveResin:Yell()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\keepmove.mp3")--保持移動
		end
	elseif args:IsSpellID(122055) and args:IsPlayer() then
		local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
		timerResidue:Start(expires-GetTime())
	elseif args:IsSpellID(122125) and args:IsPlayer() then
		specWarnCorrosiveResinPool:Show()
	elseif args:IsSpellID(125873) then
		addsCount = addsCount + 1
		warnRecklessness:Show(args.destName)
		specWarnRecklessness:Show(args.destName)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lumang.mp3") --魯莽
		timerRecklessness:Start()
		timerReinforcementsCD:Start(50, addsCount)--We count them cause some groups may elect to kill a 2nd group of adds and start a second bar to form before first ends.
	elseif args:IsSpellID(122149) then
		if args:GetDestCreatureID() == 62397 then
			if mod.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(GetSpellInfo(122149))
				DBM.InfoFrame:Show(1, "other", args.amount or 1, args.destName)
			end
			qscount = qscount + 1
			if ((mod.Options.optQS == "QS1") and (qscount % 3 == 1)) or ((mod.Options.optQS == "QS2") and (qscount % 3 == 2)) or ((mod.Options.optQS == "QS3") and (qscount % 3 == 0)) or (mod.Options.optQS == "allQS") then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\dispelnow.mp3") --快驅散
				specWarnQuickeningX:Show(args.spellName)
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REFRESH(args)
	if args:IsSpellID(122224, 61721) and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		warnImpalingSpear:Schedule(30)
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzjs.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countten.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countnine.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counteight.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndDS:Schedule(30, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzjs.mp3") --控制即將結束
		sndDS:Schedule(40, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countten.mp3")
		sndDS:Schedule(41, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countnine.mp3")
		sndDS:Schedule(42, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counteight.mp3")	
		sndDS:Schedule(43, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndDS:Schedule(44, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndDS:Schedule(45, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")	
		sndDS:Schedule(46, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndDS:Schedule(47, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndDS:Schedule(48, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndDS:Schedule(49, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")		
		timerImpalingSpear:Start(args.destName)
	elseif args:IsSpellID(125873) then
		addsCount = addsCount + 1
		warnRecklessness:Show(args.destName)
		specWarnRecklessness:Show(args.destName)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lumang.mp3") --魯莽
		timerRecklessness:Start()
		timerReinforcementsCD:Start(50, addsCount)--We count them cause some groups may elect to kill a 2nd group of adds and start a second bar to form before first ends.
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122224, 61721) and args.sourceName == UnitName("player") then
		warnImpalingSpear:Cancel()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countten.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countnine.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counteight.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countseven.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countsix.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")	
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		sndDS:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kzjs.mp3")
		timerImpalingSpear:Cancel(args.destName)
	elseif args:IsSpellID(121885) and self.Options.AmberPrisonIcons then--Not a mistake, 121885 is frozon spellid
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(122149) then
		if args:GetDestCreatureID() == 62397 then
			if mod.Options.InfoFrame then
				DBM.InfoFrame:SetHeader(GetSpellInfo(122149))
				DBM.InfoFrame:Show(1, "other", 0, args.destName)
			end
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122406) then
		warnRainOfBlades:Show()
		specWarnRainOfBlades:Show()
		if not ptwo then
			timerRainOfBladesCD:Start()
		else
			timerRainOfBladesCD:Start(48)
		end
		if mod:IsHealer() then
			if not ptwo then
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\healall.mp3") --注意群療
				sndWOP:Schedule(58, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(59, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(60, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			else
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\healall.mp3") --注意群療
				sndWOP:Schedule(45, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(46, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(47, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		else
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		end
	elseif args:IsSpellID(121876) then
		timerAmberPrisonCD:Start(36, args.sourceGUID)
	elseif args:IsSpellID(122064) then
		timerCorrosiveResinCD:Start(36, args.sourceGUID)
	elseif args:IsSpellID(122193) then
		warnMending:Show()
		timerMendingCD:Start(nil, args.sourceGUID)
		if args.sourceGUID == UnitGUID("target") or args.sourceGUID == UnitGUID("focus") then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\kickcast.mp3")--快打斷
			specWarnMending:Show(args.sourceName)
		end
	elseif args:IsSpellID(122149) then
		if not zarthikGUIDS[args.sourceGUID] then
			zarthikCount = zarthikCount + 1
			zarthikGUIDS[args.sourceGUID] = zarthikCount
		end
		warnQuickening:Show(zarthikGUIDS[args.sourceGUID] or 0)--maybe better to warn when spell applied?
		specWarnQuickening:Show("("..(zarthikGUIDS[args.sourceGUID] or 0)..") - "..args.sourceName)
		timerQuickeningCD:Start(nil, args.sourceGUID)
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 131830 then
		windBombTargets[#windBombTargets + 1] = destName
		self:Unschedule(warnWindBombTargets)
		self:Schedule(0.3, warnWindBombTargets)
		if destGUID == UnitGUID("player") and self:AntiSpam(3, 4) then
			specWarnWindBomb:Show()
			yellWindBomb:Yell()
			DBM.Flash:Show(1, 0, 0)
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
		end
	elseif spellId == 122125 and destGUID == UnitGUID("player") and self:AntiSpam(3, 5) then
		specWarnCorrosiveResinPool:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	elseif spellId == 121898 and destGUID == UnitGUID("player") and not self:IsDifficulty("lfr25") and self:AntiSpam(3, 10) then
		specWarnWhirlingBladeMove:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.SPELL_PERIODIC_MISSED = mod.SPELL_DAMAGE

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Reinforcements or msg:find(L.Reinforcements) then
		specWarnReinforcements:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_xcqcx.mp3") --新蟲群出現
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 62405 then--Sra'thik Amber-Trapper
		timerAmberPrisonCD:Cancel(args.destGUID)
		timerCorrosiveResinCD:Cancel(args.destGUID)
	elseif cid == 62408 then--Zar'thik Battle-Mender
		timerMendingCD:Cancel(args.destGUID)
		timerQuickeningCD:Cancel(args.destGUID)
		zarthikCount = 0
		table.wipe(zarthikGUIDS)
	elseif cid == 62402 then--The Kor'thik
		timerKorthikStrikeCD:Cancel()--No need for GUID cancelation, this ability seems to be off a timed trigger and they all do it together, unlike other mob sets.
		if self:IsDifficulty("heroic10", "heroic25") then
			timerKorthikStrikeCD:Start(79)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 124850 and self:AntiSpam(2, 1) then--Whirling Blade (Throw Cast spellid)
		specWarnWhirlingBlade:Show()
		timerWhirlingBladeCD:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_fd.mp3") --飛刀
--	"<173.1> [UNIT_SPELLCAST_SUCCEEDED] The Kor'thik [[boss4:Kor'thik Strike::0:123963]]", -- [10366]
--	"<175.6> [CLEU] SPELL_CAST_START#false#0xF130F3C200000FC8#Kor'thik Elite Blademaster#2632#0#0x0000000000000000#nil#-2147483648#-2147483648#122409#Kor'thik Strike#1", -- [10535]
--	"<175.6> [CLEU] SPELL_CAST_START#false#0xF130F3C200000FC7#Kor'thik Elite Blademaster#2632#8#0x0000000000000000#nil#-2147483648#-2147483648#122409#Kor'thik Strike#1", -- [10536]
	elseif spellId == 123963 and self:AntiSpam(2, 2) then--Kor'thik Strike Trigger, only triggered once, then all non CCed Kor'thik cast the strike about 2 sec later
		if firstStriked then--first Strike 32~33 sec cd. after 2nd strike 50~51 sec cd.
			timerKorthikStrikeCD:Start()
		else
			firstStriked = true
			timerKorthikStrikeCD:Start(32)
		end
	elseif spellId == 131813 and self:AntiSpam(2, 3) then
		if not ptwo then
			timerRainOfBladesCD:Cancel()
			timerRainOfBladesCD:Start(20)
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3")--P2
			if mod:IsHealer() then
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
				sndWOP:Schedule(17, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
				sndWOP:Schedule(18, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
				sndWOP:Schedule(19, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			end
		end
		ptwo = true
	end
end

function mod:UNIT_AURA_UNFILTERED(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", strikeTarget) and not strikeWarned then--Warn you that you have a meteor
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\holdit.mp3")--自保技能
		DBM.Flash:Show(1, 0, 0)
		specWarnKorthikStrike:Show()
		yellKorthikStrike:Yell()
		strikeWarned = true
		self:SendSync("KorthikStrikeTarget", UnitGUID("player"))--Screw target scanning, this way is much better, never wrong.
	elseif not UnitDebuff("player", strikeTarget) and strikeWarned then--reset warned status if you don't have debuff
		strikeWarned = false
	end
end

function mod:OnSync(msg, guid)
	--Make sure we build a table if we DCed mid fight, before we try comparing any syncs to that table.
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	if msg == "KorthikStrikeTarget" and guids[guid] then
		cfcount = cfcount + 1
		if ((mod.Options.optBH == "BH1") and (cfcount % 4 == 1)) or ((mod.Options.optBH == "BH2") and (cfcount % 4 == 2)) or ((mod.Options.optBH == "BH3") and (cfcount % 4 == 3)) or ((mod.Options.optBH == "BH4") and (cfcount % 4 == 0)) then
			if guid ~= UnitGUID("player") then--make sure YOU aren't target before warning "other"
				specWarnBH:Show(guids[guid])
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kgbh.mp3") --快給保護
			end
			self:SendSync("BHnow", UnitName("player"))
		end
		if mod.Options.optBH == "allBH" then
			if guid ~= UnitGUID("player") then--make sure YOU aren't target before warning "other"
				specWarnKorthikStrikeOther:Show(guids[guid])
			end
		end
		warnKorthikStrike:Show(guids[guid])
	elseif msg == "BHnow" and guid then
		print("本輪保護: <"..guid..">")
	end
end
