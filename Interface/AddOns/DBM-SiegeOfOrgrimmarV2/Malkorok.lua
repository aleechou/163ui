local mod	= DBM:NewMod(846, "DBM-SiegeOfOrgrimmarV2", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11360 $"):sub(12, -3))
mod:SetCreatureID(71454)
mod:SetEncounterID(1595)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6, 4, 3, 2, 1)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Endless Rage
local warnBloodRage						= mod:NewSpellAnnounce(142879, 3)
local warnDisplacedEnergy				= mod:NewTargetAnnounce(142913, 3)
--Might of the Kor'kron
local warnArcingSmash					= mod:NewCountAnnounce(142815, 4)--Target scanning doesn't work, no boss1target or boss1targettarget
local warnSeismicSlam					= mod:NewCountAnnounce(142851, 3)
local warnBreathofYShaarj				= mod:NewCountAnnounce(142842, 4)
local warnFatalStrike					= mod:NewStackAnnounce(142990, 2, nil, mod:IsTank())

--Endless Rage
local specWarnBloodRage					= mod:NewSpecialWarningSpell(142879, nil, nil, nil, 2)
local specWarnBloodRageEnded			= mod:NewSpecialWarningFades(142879)
local specWarnDisplacedEnergy			= mod:NewSpecialWarningRun(142913)
local yellDisplacedEnergy				= mod:NewYell(142913)
--Might of the Kor'kron
local specWarnArcingSmash				= mod:NewSpecialWarningCount(142815, nil, nil, nil, 2)
local specWarnImplodingEnergySoon		= mod:NewSpecialWarningPreWarn(142986, nil, 5)
local specWarnBreathofYShaarj			= mod:NewSpecialWarningCount(142842, nil, nil, nil, 3)
local specWarnFatalStrike				= mod:NewSpecialWarningStack(142990, mod:IsTank(), 12)--stack guessed, based on CD
local specWarnFatalStrikeOther			= mod:NewSpecialWarningTarget(142990, mod:IsTank())

local timerBloodRage					= mod:NewBuffActiveTimer(20.5, 142879)--2.5sec cast plus 20 second duration
local timerDisplacedEnergyCD			= mod:NewNextTimer(11, 142913)
local timerBloodRageCD					= mod:NewNextTimer(124.7, 142879)
--Might of the Kor'kron
local timerArcingSmashCD				= mod:NewNextCountTimer(17.5, 142815)--17-18 variation (the 23 second ones are delayed by Breath of Yshaarj)
local timerImplodingEnergy				= mod:NewCastTimer(10, 142986)--Always 10 seconds after arcing
local timerSeismicSlamCD				= mod:NewNextCountTimer(17.5, 142851)--Works exactly same as arcingsmash 18 sec unless delayed by breath. two sets of 3
local timerBreathofYShaarjCD			= mod:NewNextCountTimer(70, 142842)
local timerFatalStrike					= mod:NewTargetTimer(30, 142990, nil, mod:IsTank())

local berserkTimer						= mod:NewBerserkTimer(360)

--local countdownImplodingEnergy			= mod:NewCountdown(10, 142986)
--local soundDisplacedEnergy				= mod:NewSound(142913)

mod:AddBoolOption("Malhelper", true, "sound")
mod:AddBoolOption("MalhelperSend", false, "sound", 
function()
	if mod.Options.MalhelperSend then
		DBM.MalHelperEnabled = true
		DBM:AddMsg("|cFFFA6BC1"..MHExRTL.sendnote.."|r")
	else
		DBM.MalHelperEnabled = false
	end
end)

mod:AddBoolOption("RangeFrame", true)--Various things
mod:AddBoolOption("SetIconOnDisplacedEnergy", false)
mod:AddBoolOption("HudMAP", false, "sound")

mod:AddBoolOption("LTshow", true, "sound")

mod:AddBoolOption("dr", true, "sound")
for i = 1, 12 do
	mod:AddBoolOption("dr"..i, false, "sound")
end

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local DisplacedMaker = {}

local displacedEnergyTargets	= {}
local displacedEnergyTargetsIcons = {}
local displacedEnergyDebuff = GetSpellInfo(142913)
local playerDebuffs = 0
local breathCast = 0
local arcingSmashCount = 0
local seismicSlamCount = 0
local ieCount = 0
local displacedCast = false
local UnitDebuff = UnitDebuff
local UnitIsDeadOrGhost = UnitIsDeadOrGhost

local needshowshield = false

local function MyJS()
	if mod.Options["dr"..ieCount] then
		return true
	end
	return false
end

local debuffFilter
do
	debuffFilter = function(uId)
		return UnitDebuff(uId, displacedEnergyDebuff)
	end
end

--BH ADD
local function getPerShield(shieldamount)
	local maxhp = UnitHealthMax("player")
	local pershield = math.max(1, math.floor(shieldamount / maxhp * 100))
	if pershield <= 100 then
		return pershield
	end
	return 100
end

local function getShieldState()
	local colors = {"Red", "Yellow", "Green"}
	local ShieldDebuffs = {GetSpellInfo(142863), GetSpellInfo(142864), GetSpellInfo(142865)}	
	local amount
	for i= 1, 3 do
		amount = select(15, UnitDebuff("player", ShieldDebuffs[i]))
		if amount then
			local per = getPerShield(amount)
			return colors[i], per
		end
	end
	return "Red", 0
end

local elapsed = 0
local showShieldLT
do
	local frame = CreateFrame("Frame")
	local shieldcolor, shieldper
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if not needshowshield then
			frame:Hide()
		end
		if elapsed >= 0.5 then
			shieldcolor, shieldper = getShieldState()
			if needshowshield then
				if shieldcolor == "Red" then
					DBM:ShowLTSpecialWarning(_G["ABSORB"].."("..shieldper.."%)", 1, 0, 0)
				elseif shieldcolor == "Yellow" then
					DBM:ShowLTSpecialWarning(_G["ABSORB"].."("..shieldper.."%)", 1, 1, 0)
				elseif shieldcolor == "Green" then
					DBM:ShowLTSpecialWarning(_G["ABSORB"].."("..shieldper.."%)", 0, 1, 0)
				end
			end
			elapsed = 0
		end
	end)
	function showShieldLT()
		frame:Show()
	end
end
--BH ADD END

local function warnDisplacedEnergyTargets()
	if mod.Options.RangeFrame then
		if UnitDebuff("player", displacedEnergyDebuff) then--You have debuff, show everyone
			DBM.RangeCheck:Show(8, nil)
		else--You do not have debuff, only show players who do
			DBM.RangeCheck:Show(8, debuffFilter)
		end
	end
	warnDisplacedEnergy:Show(table.concat(displacedEnergyTargets, "<, >"))
	if not displacedCast then--Only cast twice, so we only start cd bar once here
		timerDisplacedEnergyCD:Start()
		displacedCast = true
	end
	table.wipe(displacedEnergyTargets)
end

local function ClearIconTargets()
	table.wipe(displacedEnergyTargetsIcons)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetIcons()
		table.sort(displacedEnergyTargetsIcons, sort_by_group)
		local Icon = 1
		for i, v in ipairs(displacedEnergyTargetsIcons) do
			self:SetIcon(v, Icon)
			Icon = Icon + 1
		end
		self:Schedule(1.5, ClearIconTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

function mod:OnCombatStart(delay)
	table.wipe(displacedEnergyTargets)
	table.wipe(displacedEnergyTargetsIcons)
	table.wipe(DisplacedMaker)
	playerDebuffs = 0
	breathCast = 0
	arcingSmashCount = 0
	seismicSlamCount = 0
	ieCount = 0
	timerSeismicSlamCD:Start(5-delay, 1)
	timerArcingSmashCD:Start(11-delay, 1)
	timerBreathofYShaarjCD:Start(-delay, 1)
	sndWOP:Schedule(67, DBM.SoundMMPath.."\\ex_so_yszb.ogg") --亞煞極之息準備
	sndWOP:Schedule(68, DBM.SoundMMPath.."\\countthree.ogg")
	sndWOP:Schedule(69, DBM.SoundMMPath.."\\counttwo.ogg")
	sndWOP:Schedule(70, DBM.SoundMMPath.."\\countone.ogg")
	timerBloodRageCD:Start(122-delay)
	if self:IsLFR() then
		berserkTimer:Start(720-delay)
	else
		berserkTimer:Start(-delay)
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(5)
	end
	--[[if self.Options.Malhelper and (not IsAddOnLoaded("Malkorok")) then
		if self:IsHeroic() or self:IsMythic() then
			ExRT:MalkorokAILoad()
		else
			ExRT:MalkorokLoad()
		end
		if self.Options.MalhelperSend then
			DBM.MalHelperEnabled = true
		else
			DBM.MalHelperEnabled = false
		end
	end
	--BH ADD
	if self.Options.LTshow then
		needshowshield = true
		showShieldLT()
	else
		needshowshield = false
	end]]--
	--BH ADD END
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
	if self.Options.Malhelper and (not IsAddOnLoaded("Malkorok")) then
		ExRT:ExBossmodsCloseAll()
	end
	--BH ADD
	if self.Options.LTshow then
		needshowshield = false
		DBM:HideLTSpecialWarning()
	end
	--BH ADD END
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 142879 then
		displacedCast = false
		warnBloodRage:Show()
		specWarnBloodRage:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\gather.ogg")--快集合
--		timerBloodRage:Start()
		timerDisplacedEnergyCD:Start(3.5)
	elseif args.spellId == 142842 then
		breathCast = breathCast + 1
		warnBreathofYShaarj:Show(breathCast)
		specWarnBreathofYShaarj:Show(breathCast)
		if breathCast == 1 then
			arcingSmashCount = 0
			seismicSlamCount = 0
			timerSeismicSlamCD:Start(5, 1)
			timerArcingSmashCD:Start(11, 1)
			timerBreathofYShaarjCD:Start(nil, 2)
			sndWOP:Schedule(67, DBM.SoundMMPath.."\\ex_so_yszb.ogg") --亞煞極之息準備
			sndWOP:Schedule(68, DBM.SoundMMPath.."\\countthree.ogg")
			sndWOP:Schedule(69, DBM.SoundMMPath.."\\counttwo.ogg")
			sndWOP:Schedule(70, DBM.SoundMMPath.."\\countone.ogg")
		end
	elseif args.spellId == 143199 then
		breathCast = 0
		arcingSmashCount = 0
		seismicSlamCount = 0
		specWarnBloodRageEnded:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\scattersoon.ogg")--注意分散
		timerSeismicSlamCD:Start(5, 1)
		timerArcingSmashCD:Start(11, 1)
		timerBreathofYShaarjCD:Start(nil, 1)
		sndWOP:Schedule(67, DBM.SoundMMPath.."\\ex_so_yszb.ogg") --亞煞極之息準備
		sndWOP:Schedule(68, DBM.SoundMMPath.."\\countthree.ogg")
		sndWOP:Schedule(69, DBM.SoundMMPath.."\\counttwo.ogg")
		sndWOP:Schedule(70, DBM.SoundMMPath.."\\countone.ogg")
		timerBloodRageCD:Start()
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 142851 then
		seismicSlamCount = seismicSlamCount + 1
		warnSeismicSlam:Show(seismicSlamCount)
		if seismicSlamCount < 3 then
			timerSeismicSlamCD:Start(nil, seismicSlamCount+1)
		end
	elseif args.spellId == 143913 then--May not be right spell event
		--5 rage gained from Essence of Y'Shaarj would progress timer about 2.5 seconds
		--May choose a more accurate UNIT_POWER monitoring method if this doesn't feel accurate enough
		if self:AntiSpam() then
			local elapsed, total = timerBloodRageCD:GetTime()
			timerBloodRageCD:Update(elapsed+2.5, total)
		end
	elseif args.spellId == 142879 then
		timerBloodRage:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 142913 then
		displacedEnergyTargets[#displacedEnergyTargets + 1] = args.destName
		playerDebuffs = playerDebuffs + 1
		if args:IsPlayer() then
			specWarnDisplacedEnergy:Show()
--			soundDisplacedEnergy:Play()
			yellDisplacedEnergy:Yell()
			sndWOP:Play(DBM.SoundMMPath.."\\runout.ogg")
			sndWOP:Schedule(1, DBM.SoundMMPath.."\\runout.ogg")
			sndWOP:Schedule(2.5, DBM.SoundMMPath.."\\countseven.ogg")
			sndWOP:Schedule(3.5, DBM.SoundMMPath.."\\countsix.ogg")
			sndWOP:Schedule(4.5, DBM.SoundMMPath.."\\countfive.ogg")
			sndWOP:Schedule(5.5, DBM.SoundMMPath.."\\countfour.ogg")
			sndWOP:Schedule(6.5, DBM.SoundMMPath.."\\countthree.ogg")
			sndWOP:Schedule(7.5, DBM.SoundMMPath.."\\counttwo.ogg")
			sndWOP:Schedule(8.5, DBM.SoundMMPath.."\\countone.ogg")
		end
		if self.Options.HudMAP then
			DisplacedMaker[args.destName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("timer", args.destName, 8, 9, 0, 1, 0, 0.6):Appear():RegisterForAlerts():Rotate(360, 9.5))
		end
		if self.Options.SetIconOnDisplacedEnergy and args:IsDestTypePlayer() then--Filter further on icons because we don't want to set icons on grounding totems
			table.insert(displacedEnergyTargetsIcons, DBM:GetRaidUnitId(DBM:GetFullPlayerNameByGUID(args.destGUID)))
			self:UnscheduleMethod("SetIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(0.5, "SetIcons")
			end
		end
		self:Unschedule(warnDisplacedEnergyTargets)
		self:Schedule(0.5, warnDisplacedEnergyTargets)
	elseif args.spellId == 142990 then
		local amount = args.amount or 1
		if amount % 3 == 0 then
			warnFatalStrike:Show(args.destName, amount)
		end
		timerFatalStrike:Start(args.destName)
		if amount % 3 == 0 and amount >= 12 then
			if args:IsPlayer() then--At this point the other tank SHOULD be clear.
				specWarnFatalStrike:Show(amount)
			else--Taunt as soon as stacks are clear, regardless of stack count.
				if not UnitDebuff("player", GetSpellInfo(142990)) and not UnitIsDeadOrGhost("player") then
					specWarnFatalStrikeOther:Show(args.destName)
					if mod:IsTank() then
						sndWOP:Play(DBM.SoundMMPath.."\\changemt.ogg") --換坦嘲諷
					end
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 142913 then
		playerDebuffs = playerDebuffs - 1
		if args:IsPlayer() then
			sndWOP:Play(DBM.SoundMMPath.."\\safenow.ogg") --安全
			sndWOP:Cancel(DBM.SoundMMPath.."\\runout.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\countseven.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\countsix.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\countfive.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\countfour.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\countthree.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\counttwo.ogg")
			sndWOP:Cancel(DBM.SoundMMPath.."\\countone.ogg")
			if self.Options.RangeFrame and playerDebuffs >= 1 then
				DBM.RangeCheck:Show(10, debuffFilter)--Change to debuff filter based check since theirs is gone but there are still others in raid.
			end
		end
		if self.Options.RangeFrame and playerDebuffs == 0 then--All of them are gone. We do it this way since some may cloak/bubble/iceblock early and we don't want to just cancel range finder if 1 of 3 end early.
--			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnDisplacedEnergy then
			self:SetIcon(args.destName, 0)
		end
		if DisplacedMaker[args.destName] then
			DisplacedMaker[args.destName] = free(DisplacedMaker[args.destName])
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 142898 then--Faster than combat log
		arcingSmashCount = arcingSmashCount + 1
		ieCount = ieCount + 1
		warnArcingSmash:Show(arcingSmashCount)
		specWarnArcingSmash:Show(arcingSmashCount)
		timerImplodingEnergy:Start()
--		countdownImplodingEnergy:Start()
		specWarnImplodingEnergySoon:Schedule(5)
		sndWOP:Play(DBM.SoundMMPath.."\\ex_so_yhz.ogg") --圓弧斬快躲
		sndWOP:Schedule(5, DBM.SoundMMPath.."\\ex_so_fscq.ogg") --分散踩圈
		if MyJS() then
			sndWOP:Schedule(5.8, DBM.SoundMMPath.."\\defensive.ogg") --注意減傷
			sndWOP:Schedule(6.5, DBM.SoundMMPath.."\\defensive.ogg")
		end
		if arcingSmashCount < 3 then
			timerArcingSmashCD:Start(nil, arcingSmashCount+1)
		end
	end
end
