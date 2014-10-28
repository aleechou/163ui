local mod	= DBM:NewMod(713, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndFS		= mod:SoundMM("SoundFS")
local sndZN		= mod:NewSound(nil, mod:IsHealer(), "SoundZN")

mod:SetRevision(("$Revision: 9469 $"):sub(12, -3))
mod:SetCreatureID(63191)--Also has CID 62164. He has 2 CIDs for a single target, wtf? It seems 63191 is one players attack though so i'll try just it.
mod:SetZone()
mod:SetUsedIcons(2)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_AURA_REMOVED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--[[WoL Reg Expression (you can remove icy touch if you don't have a DK pull bosses, i use it for pull time)
spell = "Furious Swipe" and fulltype = SPELL_CAST_START or (spell = "Pheromones" or spell = "Fury") and (fulltype = SPELL_AURA_APPLIED or fulltype = SPELL_AURA_APPLIED_DOSE) or spell = "Broken Leg" and not (fulltype = SPELL_CAST_SUCCESS or fulltype = SPELL_DAMAGE) or spell = "Mend Leg" or (spell = "Icy Touch" or spell = "Crush") and fulltype = SPELL_CAST_SUCCESS
--]]
local warnFuriousSwipe			= mod:NewSpellAnnounce(122735, 3)
local warnPheromones			= mod:NewTargetAnnounce(122835, 4)
local warnFury					= mod:NewStackAnnounce(122754, 3)
local warnBrokenLeg				= mod:NewStackAnnounce(122786, 2)
local warnMendLeg				= mod:NewSpellAnnounce(123495, 1)
local warnCrush					= mod:NewSpellAnnounce(122774, 3)--On normal, only cast if you do fight wrong (be it on accident or actually on purpose. however, on heroic, this might have a CD)

local specwarnUnder				= mod:NewSpecialWarning("specwarnUnder")
local specwarnPheromonesTarget	= mod:NewSpecialWarningTarget(122835, false)
local specwarnPheromonesYou		= mod:NewSpecialWarningYou(122835)
local yellPheromones			= mod:NewYell(122835)
local specwarnPheromonesNear	= mod:NewSpecialWarningClose(122835)

local specwarnCrushH				= mod:NewSpecialWarning("specwarnCrushH")
local specwarnCrush				= mod:NewSpecialWarningSpell(122774, true, nil, nil, true)--Maybe set to true later, not sure. Some strats on normal involve purposely having tanks rapidly pass debuff and create lots of stomps
local specwarnLeg				= mod:NewSpecialWarningSwitch("ej6270", mod:IsMelee())--If no legs are up (ie all dead), when one respawns, this special warning can be used to alert of a respawned leg and to switch back.
local specwarnPheromoneTrail	= mod:NewSpecialWarningMove(123120)--Because this starts doing damage BEFORE the visual is there.
local specWarnJSA				= mod:NewSpecialWarning("SpecWarnJSA")
local specWarnFLM				= mod:NewSpecialWarning("specWarnFLM")

local specwarnPungency			= mod:NewSpecialWarningStack(123081, mod:IsTank(), 20)
local specWarnPungencyOtherFix	= mod:NewSpecialWarning("specWarnPungencyOtherFix")

local timerCrush				= mod:NewCastTimer(3.5, 122774)--Was 3 second, hotfix went live after my kill log, don't know what new hotfixed cast time is, 3.5, 4? Needs verification.
local timerCrushCD				= mod:NewNextCountTimer(37.5, 122774)
local timerFuriousSwipeCD		= mod:NewCDTimer(8, 122735)
local timerMendLegCD			= mod:NewCDTimer(30, 123495)
local timerFury					= mod:NewBuffActiveTimer(30, 122754)
local timerPungency				= mod:NewTargetTimer(120, 123081)

local berserkTimer				= mod:NewBerserkTimer(420)

mod:AddBoolOption("PheromonesIcon", true)
mod:AddBoolOption("InfoFrame", not mod:IsDps(), "sound")
mod:AddBoolOption("HudMAP", true, "sound")
local brokenLegs = 0
local Crushcount = 0

local flmxschoose = 0
local flmcdchoose = 0
local flmchoose = 0

for i = 1, 9 do
	mod:AddBoolOption("unseenjs"..i, false, "sound")
end

mod:AddEditBoxOption("optFLM", 130, "", "sound")

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local PheromonesMarkers = {}

local function MyJS()
	if (mod.Options.unseenjs1 and Crushcount == 0) or (mod.Options.unseenjs2 and Crushcount == 1) or (mod.Options.unseenjs3 and Crushcount == 2) or (mod.Options.unseenjs4 and Crushcount == 3) or (mod.Options.unseenjs5 and Crushcount == 4) or (mod.Options.unseenjs6 and Crushcount == 5) or (mod.Options.unseenjs7 and Crushcount == 6) or (mod.Options.unseenjs8 and Crushcount == 7) or (mod.Options.unseenjs9 and Crushcount == 8) then
		return true
	end
	return false
end

function mod:OnCombatStart(delay)
	brokenLegs = 0
	Crushcount = 0
	timerFuriousSwipeCD:Start(-delay)--8-11 sec on pull
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	else
		berserkTimer:Start(720-delay)
	end
	sndFS:Schedule(5, DBM.SoundMMPath.."\\countthree.ogg")
	sndFS:Schedule(6, DBM.SoundMMPath.."\\counttwo.ogg")
	sndFS:Schedule(7, DBM.SoundMMPath.."\\countone.ogg")
	table.wipe(PheromonesMarkers)	
	if self:IsDifficulty("heroic10", "heroic25") then
		timerCrushCD:Start(30-delay, Crushcount + 1)
		sndZN:Schedule(25.5, DBM.SoundMMPath.."\\countfive.ogg")
		sndZN:Schedule(26.5, DBM.SoundMMPath.."\\countfour.ogg")
		sndZN:Schedule(27.5, DBM.SoundMMPath.."\\countthree.ogg")
		sndZN:Schedule(28.5, DBM.SoundMMPath.."\\counttwo.ogg")
		sndZN:Schedule(29.5, DBM.SoundMMPath.."\\countone.ogg")
		if MyJS() then
			specWarnJSA:Schedule(24)
			sndWOP:Schedule(24, DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
		end
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122754) and args:GetDestCreatureID() == 63191 then--It applies to both creatureids, so we antispam it
		warnFury:Show(args.destName, args.amount or 1)
		if self:IsDifficulty("lfr25") then
			timerFury:Start(15)
		else
			timerFury:Start()
		end
	elseif args:IsSpellID(122786) and args:GetDestCreatureID() == 63191 then--This one also hits both the leg and the boss, so filter second one here as well.
		-- this warn seems not works? needs review.
		warnBrokenLeg:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(122835) then
		warnPheromones:Show(args.destName)
		specwarnPheromonesTarget:Show(args.destName)
		if args:IsPlayer() then
			specwarnPheromonesYou:Show()
			yellPheromones:Yell()
			sndWOP:Play(DBM.SoundMMPath.."\\targetyou.ogg") --目標是你
		else
			local uId = DBM:GetRaidUnitId(args.destName)
			if uId then
				local inRange = DBM.RangeCheck:GetDistance("player", uId)
				if inRange and inRange < 9 then
					specwarnPheromonesNear:Show(args.destName)
				end
			end
			if self.Options.HudMAP then
				local spelltext = GetSpellInfo(122835)
				PheromonesMarkers[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("targeting", args.destName, 2, nil, 0, 1, 0, 1):SetLabel(spelltext))
			end
		end
		if self.Options.PheromonesIcon then
			self:SetIcon(args.destName, 2)
		end
	elseif args:IsSpellID(123081) then
		if self:IsDifficulty("normal25", "heroic25") then--Is it also 4 min on LFR?
			timerPungency:Start(240, args.destName)
		elseif self:IsDifficulty("lfr25") then
			timerPungency:Start(20, args.destName)
		else
			timerPungency:Start(args.destName)
		end
		if (args.amount or 1) >= 10 and args.amount % 5 == 0 then
			specWarnPungencyOtherFix:Show(args.destName, args.amount)
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(123081))
			DBM.InfoFrame:Show(1, "other", args.amount or 1, args.destName)
		end
		if (args.amount or 1) == 3 then
			if mod.Options.optFLM == args.destName then
				specWarnFLM:Show(args.destName)
				sndWOP:Play(DBM.SoundMMPath.."\\ex_mop_xxszb.ogg") --信息素準備
				self:SendSync("MyPheromone", UnitName("player").."("..flmchoose..")")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(122786) and args:GetDestCreatureID() == 63191 then
		brokenLegs = (args.amount or 0)
		warnBrokenLeg:Show(args.destName, brokenLegs)
	elseif args:IsSpellID(122835) then
		if self.Options.PheromonesIcon then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			sndWOP:Play(DBM.SoundMMPath.."\\targetchange.ogg")--目標改變
		end
		if PheromonesMarkers[args.destName] then
			PheromonesMarkers[args.destName] = free(PheromonesMarkers[args.destName])
		end
	elseif args:IsSpellID(123081) then
		timerPungency:Cancel(args.destName)
	end
end
mod.SPELL_AURA_REMOVED_DOSE = mod.SPELL_AURA_REMOVED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122735) then
		warnFuriousSwipe:Show()
		sndFS:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndFS:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndFS:Cancel(DBM.SoundMMPath.."\\countone.ogg")
		sndFS:Play(DBM.SoundMMPath.."\\ex_mop_hj.ogg") --揮擊
		timerFuriousSwipeCD:Start()
		sndFS:Schedule(5, DBM.SoundMMPath.."\\countthree.ogg")
		sndFS:Schedule(6, DBM.SoundMMPath.."\\counttwo.ogg")
		sndFS:Schedule(7, DBM.SoundMMPath.."\\countone.ogg")
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123495) then
		warnMendLeg:Show()
		timerMendLegCD:Start()
		if brokenLegs == 4 then--all his legs were broken when heal was cast, which means dps was on body.
			specwarnLeg:Show()--Warn to switch to respawned leg.
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 123120 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specwarnPheromoneTrail:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\runaway.ogg") --快躲開
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:122774") then
		if self:AntiSpam(3, 2) then
			Crushcount = Crushcount + 1
			warnCrush:Show()
			specwarnCrushH:Show(Crushcount)
			sndWOP:Play(DBM.SoundMMPath.."\\ex_mop_nyjd.ogg") --碾壓
		end
		timerCrush:Start()
		if msg:find(L.UnderHim) then
			SendChatMessage(target.."不要進紫圈!", "YELL")
		end
		if msg:find(L.UnderHim) and target == UnitName("player") then
			specwarnUnder:Show()--it's a bit of a too little too late warning, but hopefully it'll help people in LFR understand it's not place to be and less likely to repeat it, eventually thining out LFR failure rate to this.
			sndWOP:Play(DBM.SoundMMPath.."\\ex_mop_lkzq.ogg") --離開紫圈
		end
		if msg:find(L.Heroicrush) then
			timerCrushCD:Cancel()
			sndZN:Cancel(DBM.SoundMMPath.."\\countfive.ogg")
			sndZN:Cancel(DBM.SoundMMPath.."\\countfour.ogg")
			sndZN:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
			sndZN:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
			sndZN:Cancel(DBM.SoundMMPath.."\\countone.ogg")
			timerCrushCD:Start(37.5, Crushcount + 1)
			sndZN:Schedule(33, DBM.SoundMMPath.."\\countfive.ogg")
			sndZN:Schedule(34, DBM.SoundMMPath.."\\countfour.ogg")
			sndZN:Schedule(35, DBM.SoundMMPath.."\\countthree.ogg")
			sndZN:Schedule(36, DBM.SoundMMPath.."\\counttwo.ogg")
			sndZN:Schedule(37, DBM.SoundMMPath.."\\countone.ogg")
			if MyJS() then
				specWarnJSA:Schedule(32)
				sndWOP:Schedule(32, DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
			end
		end
	elseif msg:find(L.Ptwostart) then
		sndWOP:Play(DBM.SoundMMPath.."\\ptwo.ogg")
		sndZN:Cancel(DBM.SoundMMPath.."\\countfive.ogg")
		sndZN:Cancel(DBM.SoundMMPath.."\\countfour.ogg")
		sndZN:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
		sndZN:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
		sndZN:Cancel(DBM.SoundMMPath.."\\countone.ogg")
	end
end

function mod:OnSync(msg, guid)
	if msg == "MyPheromone" and guid then
		print("下一次信息素："..guid)
	end
end