local mod	= DBM:NewMod(744, "DBM-HeartofFear", nil, 330)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 9668 $"):sub(12, -3))
mod:SetCreatureID(62543)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnTempestSlash					= mod:NewSpellAnnounce(125692, 2)
local warnOverwhelmingAssault			= mod:NewStackAnnounce(123474, 3, nil, mod:IsTank() or mod:IsHealer())
local warnWindStep						= mod:NewTargetAnnounce(123175, 3)
local warnUnseenStrike					= mod:NewTargetAnnounce(122949, 4, 123017)
local warnIntensify						= mod:NewStackAnnounce(123471, 2)
local warnBladeTempest					= mod:NewCastAnnounce(125310, 4)--Phase 1 heroic
local warnStormUnleashed				= mod:NewSpellAnnounce(123815, 3)--Phase 2

local specWarnUnseenStrike				= mod:NewSpecialWarningTarget(122949)--Everyone needs to know this, and run to this person.
local yellUnseenStrike					= mod:NewYell(122949)
local specWarnOverwhelmingAssault		= mod:NewSpecialWarningStack(123474, mod:IsTank() or mod:IsHealer(), 2)
local specWarnOverwhelmingAssaultOther	= mod:NewSpecialWarning("SpecWarnOverwhelmingAssaultOther", mod:IsTank() or mod:IsHealer())
local specWarnBladeTempest				= mod:NewSpecialWarningRun(125310, true)
local specWarnStormUnleashed			= mod:NewSpecialWarningSpell(123814, nil, nil, nil, true)
local specWarnJSA						= mod:NewSpecialWarning("SpecWarnJSA")

local timerTempestSlashCD				= mod:NewNextTimer(15.5, 125692)
local timerOverwhelmingAssault			= mod:NewTargetTimer(45, 123474, nil, mod:IsTank())
local timerOverwhelmingAssaultCD		= mod:NewCDTimer(20.5, 123474, nil, mod:IsTank() or mod:IsHealer())--Only ability with a variation in 2 pulls so far. He will use every 20.5 seconds unless he's casting something else, then it can be delayed as much as an extra 15-20 seconds. TODO: See if there is a way to detect when variation is going to occur and call update timer.
local timerWindStepCD					= mod:NewCDTimer(25, 123175)
local timerUnseenStrike					= mod:NewCastTimer(4.8, 123017)
local timerUnseenStrikeCD				= mod:NewNextCountTimer(61, 123017) -- this spell seems to have 2 cooldowns. some fight 55, some  61. 
local timerIntensifyCD					= mod:NewNextTimer(60, 123471)
local timerBladeTempest					= mod:NewBuffActiveTimer(9, 125310)
local timerBladeTempestCD				= mod:NewNextTimer(60, 125310)--Always cast after immediately intensify since they essencially have same CD

local berserkTimer						= mod:NewBerserkTimer(490)

--local soundBladeTempest					= mod:NewSound(125310)

local unseencount = 0
local ptwo = false

local OAtime = 1
local warnedOA = false
local castOA = false
local prewarnedPhase2 = false

mod:AddBoolOption("RangeFrame", mod:IsRanged())--For Wind Step
mod:AddBoolOption("UnseenStrikeArrow", false)
mod:AddBoolOption("InfoFrame", not mod:IsDps(), "sound")

for i = 1, 9 do
	mod:AddBoolOption("unseenjs"..i, false, "sound")
end


local emoteFired = false
local intensifyCD = 60

local function MyJS()
	if (mod.Options.unseenjs1 and unseencount == 1) or (mod.Options.unseenjs2 and unseencount == 2) or (mod.Options.unseenjs3 and unseencount == 3) or (mod.Options.unseenjs4 and unseencount == 4) or (mod.Options.unseenjs5 and unseencount == 5) or (mod.Options.unseenjs6 and unseencount == 6) or (mod.Options.unseenjs7 and unseencount == 7) or (mod.Options.unseenjs8 and unseencount == 8) or (mod.Options.unseenjs9 and unseencount == 9) then
		return true
	end
	return false
end

local function checkUnseenEmote()
	if not emoteFired then
		warnUnseenStrike = mod:NewSpellAnnounce(123017, 4)
		specWarnUnseenStrike = mod:NewSpecialWarningSpell(122949)
		warnUnseenStrike:Show()
		specWarnUnseenStrike:Show()
		unseencount = unseencount + 1
		sndWOP:Cancel("ex_mop_wxdjzb")
		sndWOP:Play("gather") --快集合
		timerUnseenStrike:Start(4.2)
		timerUnseenStrikeCD:Start(61, unseencount + 1)
		sndWOP:Schedule(56, "ex_mop_wxdjzb") --無形打擊準備
		-- recover Unseen Strike Target Warning
		warnUnseenStrike = mod:NewTargetAnnounce(123017, 4)
		specWarnUnseenStrike = mod:NewSpecialWarningTarget(122949)
	end
end

mod:AddBoolOption("HudMAP", true, "sound")
local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end

local UnseenStrikeMarkers = {}

function mod:OnCombatStart(delay)
	emoteFired = false
	intensifyCD = 60
	timerTempestSlashCD:Start(10-delay)
	timerOverwhelmingAssaultCD:Start(15.5-delay)--Possibly wrong, the cd was shortened since beta, need better log with engage timestamp
	if not mod:IsDps() then
		sndWOP:Schedule(12, "ex_mop_yzgj") --壓制準備
	end
	timerWindStepCD:Start(20.5-delay)
	timerUnseenStrikeCD:Start(30.5-delay, 1)
	sndWOP:Schedule(27, "ex_mop_wxdjzb") --無形打擊準備
	timerIntensifyCD:Start(intensifyCD-delay)
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerBladeTempestCD:Start(-delay)
		sndWOP:Schedule(57, "wwsoon") --準備旋風
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	ptwo = false
	warnedOA = false
	castOA = false
	unseencount = 0
	prewarnedPhase2 = false
	table.wipe(UnseenStrikeMarkers)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.UnseenStrikeArrow then
		DBM.Arrow:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(123474) then
		warnOverwhelmingAssault:Show(args.destName, args.amount or 1)
		timerOverwhelmingAssault:Start(args.destName)
		if args:IsPlayer() then
			if (args.amount or 1) >= 2 then
				specWarnOverwhelmingAssault:Show(args.amount)
			end
		else
			if (args.amount or 1) >= 1 and not UnitDebuff("player", GetSpellInfo(123474)) and not UnitIsDeadOrGhost("player") then--Other tank has at least one stack and you have none
				specWarnOverwhelmingAssaultOther:Show(args.destName, args.amount or 1)--So nudge you to taunt it off other tank already.
			end
		end
	elseif args:IsSpellID(123471) then
		if ptwo and (args.amount or 1) % 3 == 0 or not ptwo then
			warnIntensify:Show(args.destName, args.amount or 1)
		end
		timerIntensifyCD:Start(intensifyCD)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssault:Cancel(args.destName)
		if mod:IsTank() and (not ptwo) then
			sndWOP:Play("changemt") --換坦嘲諷
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(125310) then
		warnBladeTempest:Show()
		specWarnBladeTempest:Show()
		sndWOP:Play("justrun") --快跑
--		soundBladeTempest:Play()
		timerBladeTempest:Start()
		sndWOP:Schedule(5, "countfive")
		sndWOP:Schedule(6, "countfour")
		sndWOP:Schedule(7, "countthree")
		sndWOP:Schedule(8, "counttwo")
		sndWOP:Schedule(9, "countone")
		timerBladeTempestCD:Start()
		sndWOP:Schedule(57, "wwsoon") --準備旋風
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(123474) then
		timerOverwhelmingAssaultCD:Start()--Start CD here, since this might miss.
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(123474))
			DBM.InfoFrame:Show(3, "playerdebuffstackstime", 123474)
		end
		if not mod:IsDps() then
			sndWOP:Cancel("ex_mop_yzgj")
			self:Schedule(17, function()
				warnedOA = true
				castOA = false
			end)
			sndWOP:Schedule(17, "ex_mop_yzgj")
		end
		OAtime = GetTime()
		warnedOA = false
		castOA = true
	elseif args:IsSpellID(123175) then
		warnWindStep:Show(args.destName)
		if self:IsDifficulty("lfr25") then
			timerWindStepCD:Start(30)
		else
			timerWindStepCD:Start()
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:find("spell:122949") then--Does not show in combat log except for after it hits. IT does fire a UNIT_SPELLCAST event but has no target info. You can get target 1 sec faster with UNIT_AURA but it's more cpu and not worth the trivial gain IMO
		local target = DBM:GetUnitFullName(target)
		emoteFired = true
		unseencount = unseencount + 1
		if MyJS() then
			specWarnJSA:Schedule(1.5)
			sndWOP:Schedule(1.5, "defensive") --注意減傷
		end
		warnUnseenStrike:Show(target)
		specWarnUnseenStrike:Show(target)
		timerUnseenStrike:Start()
		timerUnseenStrikeCD:Start(61, unseencount + 1)
		sndWOP:Cancel("ex_mop_wxdjzb")
		if target == UnitName("player") then
			yellUnseenStrike:Yell()
			sndWOP:Play("targetyou") --目標是你
		else
			sndWOP:Play("gather") --快集合
			if self.Options.HudMAP then
				UnseenStrikeMarkers[target] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", target, 2, 5, 0, 1, 0, 1):Appear():RegisterForAlerts():Rotate(360, 5))
				UnseenStrikeMarkers[target] = register(DBMHudMap:AddEdge(1, 1, 1, 1, 5, "player", target))
			end
		end
		sndWOP:Schedule(1.5, "countthree")
		sndWOP:Schedule(2.5, "counttwo")
		sndWOP:Schedule(3.5, "countone")
		sndWOP:Schedule(55, "ex_mop_wxdjzb") --無形打擊準備
		if self.Options.UnseenStrikeArrow then
			DBM.Arrow:ShowRunTo(target, 3, 3, 5)
		end
		self:Schedule(5, function()
			emoteFired = false
		end)
		if ((GetTime() - OAtime > 15) and not warnedOA) or (warnedOA and not castOA) then
			sndWOP:Cancel("ex_mop_yzgj")
			sndWOP:Schedule(7, "ex_mop_yzgj")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122839 then--Tempest Slash. DO NOT ADD OTHER SPELLID. 122839 is primary cast, 122842 is secondary cast 3 seconds later. We only need to warn for primary and start CD off it and it alone.
		warnTempestSlash:Show()
		if self:IsDifficulty("lfr25") then
			timerTempestSlashCD:Start(20)
		else
			timerTempestSlashCD:Start()
		end
	elseif spellId == 122949 and self:AntiSpam(2, 3) then-- sometimes Unseen Strike emote not fires. bliz bug.
		self:Schedule(0.8, checkUnseenEmote)
	elseif spellId == 123814 and self:AntiSpam(2, 2) then--Do not add other spellids here either. 123814 is only cast once, it starts the channel. everything else is cast every 1-2 seconds as periodic triggers.
		intensifyCD = 10
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		timerTempestSlashCD:Cancel()
		timerOverwhelmingAssaultCD:Cancel()
		if not mod:IsDps() then
			sndWOP:Cancel("ex_mop_yzgj")
		end
		timerWindStepCD:Cancel()
		timerUnseenStrikeCD:Cancel()
		sndWOP:Cancel("ex_mop_wxdjzb")
		timerIntensifyCD:Cancel()
		timerBladeTempestCD:Cancel()
		sndWOP:Cancel("wwsoon")
		warnStormUnleashed:Show()
		specWarnStormUnleashed:Show()
		sndWOP:Play("ptwo") --P2
		ptwo = true
		self:RegisterShortTermEvents(
			"UNIT_HEALTH"
		)
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 62543 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 10 and h < 13 and not prewarnedPhase2 then
			sndWOP:Play("checkhp") --注意血量
			prewarnedPhase2 = true
			self:SendSync("preptwo")
		end
	end
end

function mod:OnSync(msg)
	if msg == "preptwo" then
		if not prewarnedPhase2 then
			sndWOP:Play("checkhp")
			prewarnedPhase2 = true
		end
	end
end