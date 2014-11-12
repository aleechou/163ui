local mod	= DBM:NewMod(742, "DBM-TerraceofEndlessSpring", nil, 320)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")
local sndJK		= mod:SoundMM("SoundWOP")
local sndGH		= mod:NewSound(nil, mod:IsHealer(), "SoundGH")
local sndHX		= mod:NewSound(nil, mod:IsTank() or mod:IsHealer(), "SoundHX")
local sndMY		= mod:NewSound(nil, false, "SoundMY")

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(62442)--62919 Unstable Sha, 62969 Embodied Terror
mod:SetReCombatTime(60)--fix lfr combat re-starts after killed.

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.Victory)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED",
	"UNIT_DIED"
)

local warnNight							= mod:NewSpellAnnounce("ej6310", 2, 108558)
local warnSunbeam						= mod:NewSpellAnnounce(122789, 3)
local warnShadowBreath					= mod:NewSpellAnnounce(122752, 3)
local warnNightmares					= mod:NewTargetAnnounce(122770, 4)--Target scanning will only work on 1 target on 25 man (only is 1 target on 10 man so they luck out)
local warnDarkOfNight					= mod:NewCountAnnounce("ej6550", 4, 130013)--Heroic
local warnDay							= mod:NewSpellAnnounce("ej6315", 2, 122789)
local warnSummonUnstableSha				= mod:NewSpellAnnounce("ej6320", 3, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local warnSummonEmbodiedTerror			= mod:NewSpellAnnounce("ej6316", 4, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local warnTerrorize						= mod:NewTargetAnnounce(123012, 4, nil, mod:IsHealer())
local warnSunBreath						= mod:NewSpellAnnounce(122855, 3)
local warnLightOfDay					= mod:NewCountAnnounce("ej6551", 4, 123716, mod:IsHealer())--Heroic

local specWarnShadowBreath				= mod:NewSpecialWarningSpell(122752, mod:IsTank() or mod:IsHealer())
local specWarnSunBreath					= mod:NewSpecialWarningSpell(122855, mod:IsHealer())
local specWarnDreadShadows				= mod:NewSpecialWarningStack(122768, nil, 9)--For heroic, 10 is unhealable, and it stacks pretty fast so adaquate warning to get over there would be abou 5-6
local specWarnNightmares				= mod:NewSpecialWarningYou(122770)
local specWarnNightmaresNear			= mod:NewSpecialWarningClose(122770)
local specWarnSunbeam					= mod:NewSpecialWarningSpell(122789)
local yellNightmares					= mod:NewYell(122770)
local specWarnDarkOfNight				= mod:NewSpecialWarningSwitch("ej6550", mod:IsDps())
local specWarnTerrorize					= mod:NewSpecialWarningDispel(123012, mod:IsHealer())
local specWarnLightOfDay				= mod:NewSpecialWarningSpell("ej6551", mod:IsHealer())
local specWarnJSA						= mod:NewSpecialWarning("SpecWarnJSA")

local timerNightCD						= mod:NewNextTimer(121, "ej6310", nil, nil, nil, 130013)
local timerSunbeamCD					= mod:NewCDTimer(41, 122789)
local timerShadowBreathCD				= mod:NewCDTimer(28, 122752, nil, mod:IsTank() or mod:IsHealer())
local timerNightmaresCD					= mod:NewCDTimer(15.5, 122770)
local timerDarkOfNightCD				= mod:NewCDTimer(30.5, "ej6550", nil, nil, nil, 130013)
local timerDayCD						= mod:NewNextTimer(121, "ej6315", nil, nil, nil, 122789)
local timerSummonUnstableShaCD			= mod:NewCDTimer(18, "ej6320", nil, nil,nil, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local timerSummonEmbodiedTerrorCD		= mod:NewCDTimer(41, "ej6316", nil, nil, nil, "Interface\\Icons\\achievement_raid_terraceofendlessspring04")
local timerTerrorizeCD					= mod:NewNextTimer(14, 123012)--Besides being cast 14 seconds after they spawn, i don't know if they recast it if they live too long, their health was too undertuned to find out.
local timerSunBreathCD					= mod:NewCDTimer(29, 122855)
local timerBathedinLight				= mod:NewBuffFadesTimer(6, 122858, nil, mod:IsHealer())
local timerLightOfDayCD					= mod:NewCDTimer(10, "ej6551", nil, mod:IsHealer(), nil, 123716)--Don't have timing for this yet, heroic logs i was sent always wiped VERY early in light phase.

local berserkTimer						= mod:NewBerserkTimer(490)--a little over 8 min, basically 3rd dark phase is auto berserk.

local terrorName = EJ_GetSectionInfo(6316)
local targetScansDone = 0

mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("WarnJK", mod:IsHealer(), "sound")

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local NightmaresMarkers = {}

local sndJKNext = {}

local DSn = 0
local terrorN = 0
local daytime = 0
local lodcount = 0
local mobcount = 0
local hxcount = 0

for i = 1, 6 do
	mod:AddBoolOption("unseenjs"..i, false, "sound")
end

for i = 1, 11 do
	mod:AddBoolOption("lod"..i, false, "sound")
end

mod:AddDropdownOption("optDS", {"six", "nine", "twelve", "fifteen", "none"}, "six", "sound")

mod:AddDropdownOption("optTS", {"TS1", "TS2", "TS3", "noms"}, "noms", "sound")

local function MyJS()
	if (mod.Options.unseenjs1 and mobcount == 1) or (mod.Options.unseenjs2 and mobcount == 2) or (mod.Options.unseenjs3 and mobcount == 3) or (mod.Options.unseenjs4 and mobcount == 4) or (mod.Options.unseenjs5 and mobcount == 5) or (mod.Options.unseenjs6 and mobcount == 6) then
		return true
	end
	return false
end

local function MyTS()
	if (mod.Options.optTS == "TS1" and hxcount == 1) or (mod.Options.optTS == "TS2" and hxcount == 2) or (mod.Options.optTS == "TS3" and hxcount == 3) then
		return true
	end
	return false
end

local function isTank(unit)
	-- 1. check blizzard tanks first
	-- 2. check blizzard roles second
	-- 3. check boss1's highest threat target
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	if UnitExists("boss1target") and UnitDetailedThreatSituation(unit, "boss1") then
		return true
	end
	return false
end

function mod:LightOfDayRepeat()
	lodcount = lodcount + 1
	warnLightOfDay:Show(lodcount)
	specWarnLightOfDay:Show()
	sndGH:Play("ex_mop_ghcx")--光華出現
	if lodcount == 1 then
		sndGH:Schedule(1, "countone")
		if self.Options.lod1 then
			sndWOP:Schedule(1.5, "uu") --~
		end
	elseif lodcount == 2 then
		sndGH:Schedule(1, "counttwo")
		if self.Options.lod2 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 3 then
		sndGH:Schedule(1, "countthree")
		if self.Options.lod3 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 4 then
		sndGH:Schedule(1, "countfour")
		if self.Options.lod4 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 5 then
		sndGH:Schedule(1, "countfive")
		if self.Options.lod5 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 6 then
		sndGH:Schedule(1, "countsix")
		if self.Options.lod6 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 7 then
		sndGH:Schedule(1, "countseven")
		if self.Options.lod7 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 8 then
		sndGH:Schedule(1, "counteight")
		if self.Options.lod8 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 9 then
		sndGH:Schedule(1, "countnine")
		if self.Options.lod9 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 10 then
		sndGH:Schedule(1, "countten")
		if self.Options.lod10 then
			sndWOP:Schedule(1.5, "uu")
		end
	elseif lodcount == 11 then
		sndGH:Schedule(1, "counteleven")
		if self.Options.lod11 then
			sndWOP:Schedule(2, "uu")
		end
	end
	if self:IsDifficulty("heroic10") then
		timerLightOfDayCD:Start(25)
		self:ScheduleMethod(25, "LightOfDayRepeat")
	else
		timerLightOfDayCD:Start(10)
		self:ScheduleMethod(10, "LightOfDayRepeat")
	end
end

function mod:ShadowsTarget(targetname)
	warnNightmares:Show(targetname)
	if self.Options.HudMAP and self:IsDifficulty("normal10", "heroic10") then
		NightmaresMarkers[targetname] = register(DBMHudMap:PlaceStaticMarkerOnPartyMember("highlight", targetname, 9, 4, 0, 1, 0, 0.5):Appear():RegisterForAlerts())
	end
	if targetname == UnitName("player") then
		specWarnNightmares:Show()
		sndWOP:Play("runaway")--快躲開
		yellNightmares:Yell()
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local inRange = DBM.RangeCheck:GetDistance("player", uId)
			if inRange and inRange < 10 then
				specWarnNightmaresNear:Show(targetname)
				sndWOP:Play("runaway")--快躲開
			end
		end
	end
end

function mod:TargetScanner(ScansDone)
	targetScansDone = targetScansDone + 1
	local targetname, uId = self:GetBossTarget(62442)
	if UnitExists(targetname) then--Better way to check if target exists and prevent nil errors at same time, without stopping scans from starting still. so even if target is nil, we stil do more checks instead of just blowing off a warning.
		if isTank(uId) and not ScansDone then--He's targeting his highest threat target.
			if targetScansDone < 16 then--Make sure no infinite loop.
				self:ScheduleMethod(0.05, "TargetScanner")--Check multiple times to be sure it's not on something other then tank.
			else
				self:TargetScanner(true)--It's still on tank, force true isTank and activate else rule and warn target is on tank.
			end
		else--He's not targeting highest threat target (or isTank was set to true after 16 scans) so this has to be right target.
			self:UnscheduleMethod("TargetScanner")--Unschedule all checks just to be sure none are running, we are done.
			self:ShadowsTarget(targetname)
		end
	else--target was nil, lets schedule a rescan here too.
		if targetScansDone < 16 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.05, "TargetScanner")
		end
	end
end

function mod:OnCombatStart(delay)
	timerShadowBreathCD:Start(8.5-delay)
	sndHX:Cancel("ex_mop_zbhx")
	sndHX:Cancel("countthree")
	sndHX:Cancel("counttwo")
	sndHX:Cancel("countone")
	sndHX:Schedule(5, "ex_mop_zbhx")--準備火息
	sndHX:Schedule(6, "countthree")
	sndHX:Schedule(7, "counttwo")
	sndHX:Schedule(8, "countone")
	timerNightmaresCD:Start(13.5-delay)
	sndMY:Cancel("countseven")
	sndMY:Cancel("countsix")
	sndMY:Cancel("countfive")
	sndMY:Cancel("countfour")
	sndMY:Cancel("countthree")
	sndMY:Cancel("counttwo")
	sndMY:Cancel("countone")
	sndMY:Schedule(7, "countseven")
	sndMY:Schedule(8, "countsix")
	sndMY:Schedule(9, "countfive")
	sndMY:Schedule(10, "countfour")
	sndMY:Schedule(11, "countthree")
	sndMY:Schedule(12, "counttwo")
	sndMY:Schedule(13, "countone")
	timerDayCD:Start(-delay)
	sndWOP:Cancel("dayphase")
	sndWOP:Cancel("countthree")
	sndWOP:Cancel("counttwo")
	sndWOP:Cancel("countone")
	sndWOP:Schedule(116.5, "dayphase")--白天準備
	sndWOP:Schedule(118, "countthree")
	sndWOP:Schedule(119, "counttwo")
	sndWOP:Schedule(120, "countone")
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerDarkOfNightCD:Start(10-delay)
	end
	terrorN = 0
	daytime = 0
	lodcount = 0
	mobcount = 0
	hxcount = 0
	table.wipe(NightmaresMarkers)
	table.wipe(sndJKNext)
end

function mod:OnCombatEnd()
	if self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(122768) and args:IsPlayer() then
		DSn = self.Options.optDS == "six" and 6 or self.Options.optDS == "nine" and 9 or self.Options.optDS == "twelve" and 12 or self.Options.optDS == "fifteen" and 15 or self.Options.optDS == "none" and 99
		DSn = tonumber(DSn)
		if (args.amount or 1) >= DSn then
			if args.amount % 3 == 0 then
				specWarnDreadShadows:Show(args.amount)
				sndWOP:Play("ex_mop_kzyg")--快找陽光
			end
		end
	elseif args:IsSpellID(123012) then
		warnTerrorize:Show(args.destName)
		if mod:IsHealer() then
			specWarnTerrorize:Show(args.destName)
			sndWOP:Play("dispelnow")--快驅散
		end
		if self.Options.WarnJK then
			if GetTime() - daytime < 96 then
				sndJKNext[args.sourceGUID] = mod:SoundMM("SoundWOP")
				sndJKNext[args.sourceGUID]:Schedule(18, "ex_mop_qszb")--驅散準備
				sndJKNext[args.sourceGUID]:Schedule(19, "countthree")
				sndJKNext[args.sourceGUID]:Schedule(20, "counttwo")
				sndJKNext[args.sourceGUID]:Schedule(21, "countone")
			end
		end
	elseif args:IsSpellID(122789) then
		if args:IsPlayer() then
			specWarnSunbeam:Show()
		end
	elseif args:IsSpellID(122858) and args:IsPlayer() then
		timerBathedinLight:Start()

	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(122855) then
		warnSunBreath:Show()
		specWarnSunBreath:Show()
		timerSunBreathCD:Start()
		if not mod:IsDps() then
			sndWOP:Play("ex_mop_zbhx")
		end
		hxcount = hxcount + 1
		if MyTS() then
			sndWOP:Schedule(1, "ex_mop_kgts") --快給天使
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(122752) then
		warnShadowBreath:Show()
		specWarnShadowBreath:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerShadowBreathCD:Start(25)
		else
			timerShadowBreathCD:Start()
		end
		sndHX:Cancel("ex_mop_zbhx")
		sndHX:Cancel("countthree")
		sndHX:Cancel("counttwo")
		sndHX:Cancel("countone")
		if self:IsDifficulty("heroic10", "heroic25") then
			sndHX:Schedule(21, "ex_mop_zbhx")
			sndHX:Schedule(22.5, "countthree")
			sndHX:Schedule(23.5, "counttwo")
			sndHX:Schedule(24.5, "countone")
		else
			sndHX:Schedule(24, "ex_mop_zbhx")
			sndHX:Schedule(25.5, "countthree")
			sndHX:Schedule(26.5, "counttwo")
			sndHX:Schedule(27.5, "countone")
		end
	elseif args:IsSpellID(124176, 123630) then
		DBM:EndCombat(self)
	end
end

function mod:RAID_BOSS_EMOTE(msg)
	if msg:find("spell:122789") then
		timerSunbeamCD:Start()
	elseif msg:find(terrorName) then
		timerTerrorizeCD:Start()--always cast 14-15 seconds after one spawns (Unless stunned, if you stun the mob you can delay the cast, using this timer)
		warnSummonEmbodiedTerror:Show()
		sndWOP:Play("ex_mop_kjjx")--恐懼具現
		terrorN = terrorN + 1
		if self.Options.WarnJK then
			sndJK:Schedule(10, "ex_mop_qszb")--驅散準備
			sndJK:Schedule(11, "countthree")
			sndJK:Schedule(12, "counttwo")
			sndJK:Schedule(13, "countone")
		end
		timerSummonEmbodiedTerrorCD:Start()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 122770 and self:AntiSpam(2, 1) then--Nightmares (Night Phase)
		if self:IsDifficulty("normal25", "heroic25", "lfr25") then
			sndWOP:Play("firecircle")--注意火圈
		end
		targetScansDone = 0		
		self:TargetScanner()
		if timerDayCD:GetTime() < 106 then
			timerNightmaresCD:Start()
			sndMY:Schedule(9, "countseven")
			sndMY:Schedule(10, "countsix")
			sndMY:Schedule(11, "countfive")
			sndMY:Schedule(12, "countfour")
			sndMY:Schedule(13, "countthree")
			sndMY:Schedule(14, "counttwo")
			sndMY:Schedule(15, "countone")
		end
	elseif spellId == 123252 and self:AntiSpam(2, 2) and self:IsInCombat() then--Dread Shadows Cancel (Sun Phase)
		daytime = GetTime()
		lodcount = 0
		mobcount = 0
		hxcount = 0
		timerShadowBreathCD:Cancel()
		sndHX:Cancel("ex_mop_zbhx")
		sndHX:Cancel("countthree")
		sndHX:Cancel("counttwo")
		sndHX:Cancel("countone")
		timerSunbeamCD:Cancel()
		timerNightmaresCD:Cancel()
		sndMY:Cancel("countseven")
		sndMY:Cancel("countsix")
		sndMY:Cancel("countfive")
		sndMY:Cancel("countfour")
		sndMY:Cancel("countthree")
		sndMY:Cancel("counttwo")
		sndMY:Cancel("countone")
		timerDarkOfNightCD:Cancel()
		warnDay:Show()
		sndWOP:Cancel("countthree")
		sndWOP:Cancel("counttwo")
		sndWOP:Cancel("countone")
		sndWOP:Play("phasechange")--階段轉換
		timerSunBreathCD:Start()
		timerNightCD:Start()
		sndWOP:Schedule(116.5, "ex_mop_hyzb")--黑夜準備
		sndWOP:Schedule(118, "countthree")
		sndWOP:Schedule(119, "counttwo")
		sndWOP:Schedule(120, "countone")
	elseif spellId == 122953 and self:AntiSpam(2, 1) then--Summon Unstable Sha (122946 is another ID, but it always triggers at SAME time as Dread Shadows Cancel so can just trigger there too without additional ID scanning.
		warnSummonUnstableSha:Show()
		if mod:IsDps() then
			sndWOP:Schedule(4, "ex_mop_kdbwds")--快打不穩定煞
		end
		timerSummonUnstableShaCD:Start()
		mobcount = mobcount + 1
		if MyJS() then
			specWarnJSA:Schedule(6, mobcount)
			sndWOP:Schedule(6, "defensive") --注意減傷
		end
	elseif spellId == 122767 and self:AntiSpam(2, 2) then--Dread Shadows (Night Phase)
		timerSummonUnstableShaCD:Cancel()
		timerSummonEmbodiedTerrorCD:Cancel()
		timerSunBreathCD:Cancel()
		timerLightOfDayCD:Cancel()
		lodcount = 0
		mobcount = 0
		hxcount = 0
		if self:IsDifficulty("heroic10", "heroic25") then
			self:UnscheduleMethod("LightOfDayRepeat")
		end
		warnNight:Show()
		if self.Options.WarnJK then
			sndJK:Cancel("ex_mop_qszb")
			sndJK:Cancel("countthree")
			sndJK:Cancel("counttwo")
			sndJK:Cancel("countone")
			for i,j in pairs(sndJKNext) do
				sndJKNext[i]:Cancel("ex_mop_qszb")
				sndJKNext[i]:Cancel("countthree")
				sndJKNext[i]:Cancel("counttwo")
				sndJKNext[i]:Cancel("countone")
			end
			table.wipe(sndJKNext)
		end
		sndWOP:Play("phasechange")
		timerShadowBreathCD:Start(10)
		sndHX:Schedule(6, "ex_mop_zbhx")--準備火息
		sndHX:Schedule(7.5, "countthree")
		sndHX:Schedule(8.5, "counttwo")
		sndHX:Schedule(9.5, "countone")
		timerNightmaresCD:Start(16)
		sndMY:Schedule(9.5, "countseven")
		sndMY:Schedule(10.5, "countsix")
		sndMY:Schedule(11.5, "countfive")
		sndMY:Schedule(12.5, "countfour")
		sndMY:Schedule(13.5, "countthree")
		sndMY:Schedule(14.5, "counttwo")
		sndMY:Schedule(15.5, "countone")
		timerDayCD:Start()
		sndWOP:Schedule(116.5, "dayphase")
		sndWOP:Schedule(118, "countthree")
		sndWOP:Schedule(119, "counttwo")
		sndWOP:Schedule(120, "countone")
		if self:IsDifficulty("heroic10", "heroic25") then
--			timerDarkOfNightCD:Start(10-delay)--Not enough information yet, no logs of this phase starting anywhere but combat start, and those timers differ. This might have first cast IMMEDIATELY on phase start like day does
		end
	elseif spellId == 123813 and self:AntiSpam(2, 3) then--The Dark of Night (Night Phase)
		lodcount = lodcount + 1
		warnDarkOfNight:Show(lodcount)
		specWarnDarkOfNight:Show()
		timerDarkOfNightCD:Start()
		if mod:IsDps() then
			sndWOP:Play("ex_mop_aykd")--暗影快打
		end
	elseif spellId == 123816 and self:AntiSpam(2, 3) then--The Light of Day (Day Phase)
		if self:IsDifficulty("heroic10") then
			timerLightOfDayCD:Start(25)
			self:ScheduleMethod(25, "LightOfDayRepeat")
		else
			timerLightOfDayCD:Start(10)
			self:ScheduleMethod(10, "LightOfDayRepeat")
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 62969 then
		terrorN = terrorN - 1
		if self.Options.WarnJK then
			if terrorN == 0 then
				sndJK:Cancel("ex_mop_qszb")
				sndJK:Cancel("countthree")
				sndJK:Cancel("counttwo")
				sndJK:Cancel("countone")
			end
			if sndJKNext[args.destGUID] then
				sndJKNext[args.destGUID]:Cancel("ex_mop_qszb")
				sndJKNext[args.destGUID]:Cancel("countthree")
				sndJKNext[args.destGUID]:Cancel("counttwo")
				sndJKNext[args.destGUID]:Cancel("countone")
			end
		end
	end
end