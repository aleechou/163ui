local mod	= DBM:NewMod(865, "DBM-SiegeOfOrgrimmar", nil, 369)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
local sndFMD	= mod:NewSound(nil, "SoundFMD", mod:IsRangedDps())
local sndDL		= mod:NewSound(nil, "SoundDL", mod:IsRangedDps())
local sndCZ		= mod:NewSound(nil, "SoundCZ", false)
local sndCZ4	= mod:NewSound(nil, "SoundCZ4", false)
local sndCZ5	= mod:NewSound(nil, "SoundCZ5", false)

local sndCS1	= mod:NewSound(nil, "SoundCS1", false)
local sndCS2	= mod:NewSound(nil, "SoundCS2", false)

mod:SetRevision(("$Revision: 10387 $"):sub(12, -3))
mod:SetCreatureID(71504)--71591 Automated Shredder
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_AURA_BROKEN",
	"SPELL_AURA_BROKEN_SPELL",
	"RAID_BOSS_WHISPER",
	"UNIT_AURA player"
)

--Siegecrafter Blackfuse
local warnLaunchSawblade				= mod:NewTargetAnnounce(143265, 3)
local warnProtectiveFrenzy				= mod:NewTargetAnnounce(145365, 3, nil, mod:IsTank() or mod:IsHealer())
local warnElectroStaticCharge			= mod:NewStackAnnounce(143385, 2, nil, mod:IsTank())
local warnOvercharge					= mod:NewTargetAnnounce(145774, 4)--Heroic. Probably doesn't show in combat log and will require emotes i'm sure.
--Automated Shredders
local warnAutomatedShredder				= mod:NewSpellAnnounce("ej8199", 3, 85914)
local warnDeathFromAbove				= mod:NewTargetAnnounce(144208, 4)--Player target, not vulnerable shredder target. (should always be cast on highest threat target, but i like it still being a "target" warning)
--The Assembly Line
local warnAssemblyLine					= mod:NewSpellAnnounce("ej8202", 3, 85914)
local warnShockwaveMissileActivated		= mod:NewSpellAnnounce("ej8204", 3, 143639)--Unsure if this will even show in CLEU, may need UNIT event or emote
local warnShockwaveMissile				= mod:NewCountAnnounce(143641, 3)
--local warnLaserTurretActivated			= mod:NewSpellAnnounce("ej8208", 3, 143867, false)--No event to detect it
local warnLaserFixate					= mod:NewTargetAnnounce(143828, 3, 143867)--Not in combat log, needs more debugging to find a way around blizz fail
local warnMagneticCrush					= mod:NewSpellAnnounce(144466, 3)--Unsure if correct ID, could be 143487 instead
local warnCrawlerMine					= mod:NewSpellAnnounce("ej8212", 3, 144010)--Crawler Mine Spawning
local warnReadyToGo						= mod:NewTargetAnnounce(145580, 4)--Crawler mine not dead fast enough
local warnCC							= mod:NewAnnounce("warnCC", 4, 1499, nil, nil, true)
local warnCSDps							= mod:NewTargetAnnounce("ej8202", 3, 85914)

--Siegecrafter Blackfuse
local specWarnLaunchSawblade			= mod:NewSpecialWarningYou(143265)
local yellLaunchSawblade				= mod:NewYell(143265)
local specWarnProtectiveFrenzy			= mod:NewSpecialWarningTarget(145365, mod:IsTank())
local specWarnOvercharge				= mod:NewSpecialWarningTarget(145774)
--Automated Shredders
local specWarnAutomatedShredder			= mod:NewSpecialWarningSpell("ej8199", mod:IsTank())--No sense in dps switching when spawn, has damage reduction. This for tank pickup
local specWarnDeathFromAbove			= mod:NewSpecialWarningYou(144208)
local specWarnDFANear					= mod:NewSpecialWarningClose(144208)
local specWarnAutomatedShredderSwitch	= mod:NewSpecialWarningSwitch("ej8199", false)--Strat dependant, you may just ignore them and have tank kill them with laser pools
--The Assembly Line
local specWarnCrawlerMine				= mod:NewSpecialWarningSwitch("ej8212")
local specWarnAssemblyLine				= mod:NewSpecialWarningSpell("ej8202", mod:IsDps())
local specWarnShockwaveMissileActive	= mod:NewSpecialWarningSpell("ej8204", nil, nil, nil, 2)
local specWarnReadyToGo					= mod:NewSpecialWarningTarget(145580)
local specWarnLaserFixate				= mod:NewSpecialWarningRun(143828)
local specWarnLaserFixateNear			= mod:NewSpecialWarningClose(143828)
local yellLaserFixate					= mod:NewYell(143828)
local specWarnSuperheated				= mod:NewSpecialWarningMove(143856)--From lasers. Hard to see, this warning will help a ton
local specWarnMagneticCrush				= mod:NewSpecialWarningSpell(144466, nil, nil, nil, 2)
local specWarnCrawlerMineFixate			= mod:NewSpecialWarningRun("ej8212")
--local yellCrawlerMineFixate				= mod:NewYell("ej8212", nil, false)

--Siegecrafter Blackfuse
local timerProtectiveFrenzy				= mod:NewBuffActiveTimer(10, 145365, nil, mod:IsTank() or mod:IsHealer())
local timerElectroStaticCharge			= mod:NewTargetTimer(60, 143385, nil, mod:IsTank())
local timerElectroStaticChargeCD		= mod:NewCDTimer(17, 143385, nil, mod:IsTank())--17-22 second variation
local timerLaunchSawbladeCD				= mod:NewCDTimer(10, 143265)--10-15sec cd
--Automated Shredders
local timerAutomatedShredderCD			= mod:NewNextTimer(60, "ej8199", nil, nil, nil, 85914)
local timerDeathFromAboveDebuff			= mod:NewTargetTimer(5, 144210, nil, not mod:IsHealer())
local timerDeathFromAboveCD				= mod:NewNextTimer(40, 144208, nil, not mod:IsHealer())
local timerOverloadCD					= mod:NewNextCountTimer(11, 145444)
--The Assembly Line
local timerAssemblyLineCD				= mod:NewNextCountTimer(40, "ej8202", nil, nil, nil, 59193)
local timerPatternRecognition			= mod:NewBuffActiveTimer(60, 144236)
--local timerDisintegrationLaserCD		= mod:NewNextCountTimer(10, 143867)
--local timerShockwaveMissileActive		= mod:NewBuffActiveTimer(30, 143639)
local timerShockwaveMissileCD			= mod:NewNextCountTimer(15, 143641)
local timerBreakinPeriod				= mod:NewTargetTimer(60, 145269, nil, false)--Many mines can be up at once so timer off by default do to spam

local missileCount = 0
local OverloadCount = 0
--local laserCount = 0--Fires 3 times
--local activeWeaponsGUIDS = {}
local shockwaveOvercharged = false
local weapon = 0
local zp = EJ_GetSectionInfo(8202)
local dl = EJ_GetSectionInfo(8212)
local fd = EJ_GetSectionInfo(8205)
local jg = EJ_GetSectionInfo(8208)
local dc = EJ_GetSectionInfo(8210)

local DBMHudMap = DBMHudMap
local free = DBMHudMap.free
local function register(e)	
	DBMHudMap:RegisterEncounterMarker(e)
	return e
end
local linemaker
local lasermaker = {}
local myweapon = false
local DLneedshow = true
local infire = false

mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("HudMAP", true, "sound")
mod:AddBoolOption("LTFD", true, "sound")
mod:AddBoolOption("LTHX", true, "sound")

mod:AddBoolOption("ShowDps", false, "sound")

mod:AddDropdownOption("optCS", {"CSA", "CSB", "CSALL", "none"}, "none", "sound")

for i = 1, 15 do
	mod:AddDropdownOption("optCSKILL"..i, {"killdl", "killfd", "killjg", "killdc", "killnone"}, "killnone", "sound")
end

local function showspellinfo(weaponnum)
	if mod.Options.InfoFrame then		
		DBM.InfoFrame:SetHeader(zp.."("..weaponnum..")")
		if weaponnum == 1 or weaponnum == 2 or weaponnum == 4 then
			DBM.InfoFrame:Show(1, "other", fd.." / "..jg, dl)
		elseif weaponnum == 3 then
			DBM.InfoFrame:Show(1, "other", fd.." / "..jg, dc)
		elseif weaponnum == 5 then
			DBM.InfoFrame:Show(1, "other", dc.." / "..fd, dl)
		elseif weaponnum == 6 then
			DBM.InfoFrame:Show(1, "other", dl.." / "..jg, dl)
		elseif weaponnum == 7 then
			DBM.InfoFrame:Show(1, "other", jg.." / "..fd, dl)
		elseif weaponnum == 8 then
			DBM.InfoFrame:Show(1, "other", dl.." / "..dc, fd)
		elseif weaponnum == 9 then
			DBM.InfoFrame:Show(1, "other", jg.." / "..dl, jg)
		elseif weaponnum == 10 then
			DBM.InfoFrame:Show(1, "other", dl.." / "..jg, fd)
		elseif weaponnum == 11 then
			DBM.InfoFrame:Show(1, "other", fd.." / "..dc, fd)
		elseif weaponnum == 12 then
			DBM.InfoFrame:Show(1, "other", dc.." / "..jg, dl)
		else
			DBM.InfoFrame:Show(1, "other", "", _G["UNKNOWN"])
		end
	end
end

function mod:LaunchSawBladeTarget(targetname, uId)
	warnLaunchSawblade:Show(targetname)
end

--May be two up at once so can't use generic boss scanner.
function mod:DeathFromAboveTarget(sGUID)
	local targetname = nil
	for uId in DBM:GetGroupMembers() do
		if UnitGUID(uId.."target") == sGUID then
			targetname = DBM:GetUnitFullName(uId.."targettarget")
			break
		end
	end
	warnDeathFromAbove:Show(targetname)
	if targetname == UnitName("player") then
		specWarnDeathFromAbove:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_sctj.mp3") --死從
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 20 then
				specWarnDFANear:Show(targetname)
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_sctj.mp3")
			end
		end
	end
end

local FDDamagedplayer = {}
local JGDamagedplayer = {}
local DLDamagedplayer = {}
local DCDamagedplayer = {}
local Damagesort = {}
local Petowner = {}

--[[
--like many important debuffs last tier and now this tier, APPLIED & REMOVED SPELL_CAST events are disabled, so we have to waste cpu to find them.
local spellName = GetSpellInfo(143828)
local function findLaser()
	for uId in DBM:GetGroupMembers() do
		local name = DBM:GetUnitFullName(uId)
		if UnitDebuff(uId, spellName) then
			print("DBM DEBUG: Possible match to laser targeting using "..spellName)
			warnLaserFixate:Show(name)
			if name == UnitName("player") then
				specWarnLaserFixate:Show()
				yellLaserFixate:Yell()
			end
			return
		end
	end
	mod:Schedule(0.1, findLaser)
end--]]

local function MyCS()
	local CSn = mod.Options.optCS == "CSA" and 1 or mod.Options.optCS == "CSB" and 0 or mod.Options.optCS == "none" and 99
	if weapon % 2 == CSn then return true end
	return false
end

function mod:OnCombatStart(delay)
--	table.wipe(activeWeaponsGUIDS)
	missileCount = 0
	OverloadCount = 0
--	laserCount = 0
	shockwaveOvercharged = false
	weapon = 0
	myweapon = false
	DLneedshow = true
	infire = false
	timerAutomatedShredderCD:Start(35-delay)
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.optCS ~= "none" or self.Options.HudMAP then
		DBMHudMap:FreeEncounterMarkers()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.LTHX then
		DBM:HideLTSpecialWarning()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 143265 then
		timerLaunchSawbladeCD:Start()
		self:BossTargetScanner(71504, "LaunchSawBladeTarget", 0.1, 16)
	elseif args.spellId == 144208 then
		timerDeathFromAboveCD:Start(args.sourceGUID)
		self:ScheduleMethod(0.2, "DeathFromAboveTarget", args.sourceGUID)--Always targets tank, so 1 scan all needed
		specWarnAutomatedShredderSwitch:Schedule(3)--Better here then when debuff goes up, give dps 2 seconds rampup time so spells in route when debuff goes up.
		sndFMD:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_fmjd.mp3") --伐木機快打
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 143639 then--Missile Activation
		warnShockwaveMissileActivated:Show()
		specWarnShockwaveMissileActive:Show()
--		timerShockwaveMissileActive:Start()
		missileCount = 0
		if not shockwaveOvercharged then--Works differently on heroic, different timing when overcharged, need a bigger sample size though since a ptr pug always wiped to this i didn't get heroic timing other than to find it's not 15
			timerShockwaveMissileCD:Start(3, 1)
		end
	elseif args.spellId == 145774 then
		warnOvercharge:Show(args.destName)
		specWarnOvercharge:Show(args.destName)
		local cid = self:GetCIDFromGUID(args.destGUID)
		if cid == 71638 then
			shockwaveOvercharged = true
		else
			shockwaveOvercharged = false
		end
		if cid == 71638 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_fdqh.mp3") --飛彈強化
		elseif cid == 71752 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_jgqh.mp3") --激光強化
		elseif cid == 71696 then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_ccqh.mp3") --磁場強化
		else
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dlqh.mp3") --地雷強化
		end
	elseif args.spellId == 145444 then
		OverloadCount = OverloadCount + 1
		timerOverloadCD:Start(11, OverloadCount)
		if OverloadCount == 3 then
			sndCZ4:Schedule(6, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_4cz.mp3") --超載4
			sndCZ4:Schedule(7.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3") --注意減傷
			sndCZ4:Schedule(8.2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3")
		elseif OverloadCount == 4 then
			sndCZ5:Schedule(6, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_5cz.mp3") --超載5
			sndCZ5:Schedule(7.5, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3")
			sndCZ5:Schedule(8.2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3")
		else
			sndCZ:Schedule(7, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3") --準備AOE
		end
	end
end

function mod:SPELL_SUMMON(args)
	if args.spellId == 143641 then--Missile Launching
		missileCount = missileCount + 1
		warnShockwaveMissile:Show(missileCount)
		if not shockwaveOvercharged then
			timerShockwaveMissileCD:Start(nil, missileCount+1)
		end
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_fdzb.mp3") --飛彈準備
	end
	if not Petowner[args.destGUID] then
		Petowner[args.destGUID] = args.sourceName
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 145365 then
		warnProtectiveFrenzy:Show(args.destName)
		specWarnProtectiveFrenzy:Show(args.destName)
		timerProtectiveFrenzy:Start()
		if mod:IsTank() or mod:IsHealer() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\speedup.mp3") --首領加速
		end
	elseif args.spellId == 143385 then
		if UnitIsPlayer(args.destName) == 1 then
			local amount = args.amount or 1
			warnElectroStaticCharge:Show(args.destName, amount)
			timerElectroStaticCharge:Start(args.destName)
			timerElectroStaticChargeCD:Start()
		end
	elseif args.spellId == 144210 and not args:IsDestTypePlayer() then
		timerDeathFromAboveDebuff:Start(args.destName)
	elseif args.spellId == 144236 and args:IsPlayer() then
		timerPatternRecognition:Start()
	elseif args.spellId == 145269 then
		if self:AntiSpam(30, 3) then --BHFIX
			warnCrawlerMine:Show()
			specWarnCrawlerMine:Show()
			sndDL:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\killmine.mp3") --地雷快打
			DLneedshow = true
		end
		timerBreakinPeriod:Start(args.destName, args.destGUID)
	elseif args.spellId == 145580 then
		warnReadyToGo:Show(args.destName)
		specWarnReadyToGo:Show(args.destName)
--[[	elseif args.spellId == 143867 then
		if not activeWeaponsGUIDS[args.sourceGUID] then
			activeWeaponsGUIDS[args.sourceGUID] = true
			laserCount = 0
			warnLaserTurretActivated:Show()
		end
		laserCount = laserCount + 1
		if laserCount < 3 then--Seems each laser construction casts 3 times, then disapears.
			timerDisintegrationLaserCD:Start(nil, laserCount+1)
		end
		self:Unschedule(findLaser)
		findLaser()--]]
	elseif args.spellId == 144466 and self:AntiSpam(15, 1) then--Only way i see to detect magnet activation, antispam is so it doesn't break if a player dies during it.
		warnMagneticCrush:Show()
		specWarnMagneticCrush:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dczd.mp3") --電磁震蕩
	elseif args.spellId == 143856 and args:IsPlayer() and self:AntiSpam(2, 2) then  --BHFIX
		specWarnSuperheated:Show()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runaway.mp3") --快躲開		
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 143385 then
		timerElectroStaticCharge:Cancel(args.destName)
	elseif args.spellId == 144236 and args:IsPlayer() then
		timerPatternRecognition:Cancel()
	elseif args.spellId == 145269 then
		timerBreakinPeriod:Cancel(args.destName, args.destGUID)
	elseif args.spellId == 143639 then
		timerShockwaveMissileCD:Cancel()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71591 then
		timerDeathFromAboveCD:Cancel(args.destGUID)
		OverloadCount = 0
		timerOverloadCD:Cancel()
		sndCZ:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\aesoon.mp3")
		sndCZ4:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_4cz.mp3")
		sndCZ4:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3")
		sndCZ5:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_5cz.mp3")
		sndCZ5:Cancel("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\defensive.mp3")
	end
end

function mod:SPELL_AURA_BROKEN(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 71788 and DLneedshow then
		DLneedshow = false
		local exspellname = args.extraSpellName or _G["MELEE_ATTACK"]
		warnCC:Show(args.sourceName, exspellname, args.destName, args.spellName)
	end
end
mod.SPELL_AURA_BROKEN_SPELL = mod.SPELL_AURA_BROKEN

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:143266") then--Target scanning works on this one, but is about 1 second slower than emote. emote is .2 seconds after SPELL_CAST_START, but target scanning can't grab right target until like 1.0 or 1.2 sec into cast
		specWarnLaunchSawblade:Show()
		DBM.Flash:Shake(1, 0, 0)
		yellLaunchSawblade:Yell()
		sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\runout.mp3") --離開人群
		if mod.Options.LTFD then
			DBM:ShowLTSpecialWarning(143266, 1, 0, 0, 1, 143266, 2)
		end
	--"<55.7 18:31:39> [RAID_BOSS_WHISPER] RAID_BOSS_WHISPER#|TInterface\\Icons\\Ability_Siege_Engineer_Detonate.blp:20|tA Crawler Mine has targeted you!#Crawler Mine#0#true", -- [4345]
	elseif msg:find("Ability_Siege_Engineer_Detonate") then--Doesn't show in combat log at all (what else is new)
		if self:AntiSpam(5, 4) then
			specWarnCrawlerMineFixate:Show()
--			yellCrawlerMineFixate:Yell()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dlsd.mp3") --地雷鎖定
		end
	elseif msg:find("Ability_Siege_Engineer_Superheated") then
		if self:AntiSpam(3, 10) then
			specWarnLaserFixate:Show()
			DBM.Flash:Shake(1, 0, 0)
			yellLaserFixate:Yell()
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\laserrun.mp3") --快跑,激光點你
			if mod.Options.LTFD then
				DBM:ShowLTSpecialWarning(143828, 1, 0, 0, 1, 143828, 2)
			end
			self:SendSync("LaserTarget", UnitGUID("player"))
		end
	end
end

local function showheroichx()
	if myweapon then
		local cdtext = ""
		DBM:ShowLTSpecialWarning(cdtext, 0, 1, 0, nil, 143856, nil, 3)
		mod:Schedule(3, function()
			showheroichx()
		end)
	else
		DBM:HideLTSpecialWarning()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg == L.newWeapons or msg:find(L.newWeapons) then
		warnAssemblyLine:Show()
		specWarnAssemblyLine:Show()
		weapon = weapon + 1
		timerAssemblyLineCD:Start(nil, weapon+1)
		if weapon == 1 and (not mod.Options.SoundCS2) then
			sndWOP:Schedule(30, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_tenwq.mp3") --10秒後武器啟動
		end
		
		if weapon % 2 == 1 then
			sndCS2:Schedule(30, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_2zu.mp3") --2組
			sndCS2:Schedule(31, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_2zu.mp3")
		end
		
		if weapon % 2 == 0 then
			sndCS1:Schedule(30, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_1zu.mp3") --1組
			sndCS1:Schedule(31, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_bh_1zu.mp3")
		end
		
		if MyCS() or (mod.Options.optCS == "CSALL") then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_kqcs.mp3") --快去傳送帶
			linemaker = register(DBMHudMap:AddEdge(0, 1, 0, 1, 10, "player", nil, nil, nil, 321, 258))
			local weaponoption = "optCSKILL"..weapon
			if mod.Options[weaponoption] == "killdl" then
				sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dddl.mp3") --打掉地雷
				sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dddl.mp3")
				if mod.Options.ShowDps then
					self:Schedule(40, function()
						table.wipe(Damagesort)
						for k, v in pairs(DLDamagedplayer) do
							v = string.format("%.2f", v/10^6).."M"
							Damagesort[#Damagesort + 1] = k..":"..v
						end
						warnCSDps:Show(table.concat(Damagesort, "<, >"))
						table.wipe(Damagesort)
						table.wipe(DLDamagedplayer)
						self:UnregisterShortTermEvents()
					end)
				end
			elseif mod.Options[weaponoption] == "killfd" then
				sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_ddfd.mp3") --打掉飛彈
				sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_ddfd.mp3")
				if mod.Options.ShowDps then
					self:Schedule(40, function()
						table.wipe(Damagesort)
						for k, v in pairs(FDDamagedplayer) do
							v = string.format("%.2f", v/10^6).."M"
							Damagesort[#Damagesort + 1] = k..":"..v
						end
						warnCSDps:Show(table.concat(Damagesort, "<, >"))
						table.wipe(Damagesort)
						table.wipe(FDDamagedplayer)
						self:UnregisterShortTermEvents()
					end)
				end
			elseif mod.Options[weaponoption] == "killjg" then
				sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_ddjg.mp3") --打掉激光
				sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_ddjg.mp3")
				if mod.Options.ShowDps then
					self:Schedule(40, function()
						table.wipe(Damagesort)
						for k, v in pairs(JGDamagedplayer) do
							v = string.format("%.2f", v/10^6).."M"
							Damagesort[#Damagesort + 1] = k..":"..v
						end
						warnCSDps:Show(table.concat(Damagesort, "<, >"))
						table.wipe(Damagesort)
						table.wipe(JGDamagedplayer)
						self:UnregisterShortTermEvents()
					end)
				end
			elseif mod.Options[weaponoption] == "killdc" then
				sndWOP:Schedule(2, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dddc.mp3") --打掉電磁鐵
				sndWOP:Schedule(3, "Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_dddc.mp3")
				if mod.Options.ShowDps then
					self:Schedule(40, function()
						table.wipe(Damagesort)
						for k, v in pairs(DCDamagedplayer) do
							v = string.format("%.2f", v/10^6).."M"
							Damagesort[#Damagesort + 1] = k..":"..v
						end
						warnCSDps:Show(table.concat(Damagesort, "<, >"))
						table.wipe(Damagesort)
						table.wipe(DCDamagedplayer)
						self:UnregisterShortTermEvents()
					end)
				end
			end
			myweapon = true
			self:Schedule(35, function() myweapon = false end)
			if self.Options.LTHX and self:IsDifficulty("heroic10", "heroic25") then
				self:Schedule(5, function()
					showheroichx()					
				end)
			end
			if self.Options.ShowDps then
				self:Schedule(5, function()
					table.wipe(FDDamagedplayer)
					table.wipe(JGDamagedplayer)
					table.wipe(DLDamagedplayer)
					table.wipe(DCDamagedplayer)
					self:RegisterShortTermEvents(
						"SWING_DAMAGE",
						"RANGE_DAMAGE",
						"SPELL_DAMAGE",
						"SPELL_PERIODIC_DAMAGE"
					)
				end)
			end
		end
		showspellinfo(weapon)			
	elseif msg == L.newShredder or msg:find(L.newShredder) then
		warnAutomatedShredder:Show()
		specWarnAutomatedShredder:Show()
		timerDeathFromAboveCD:Start(17)
		timerAutomatedShredderCD:Start()
		if mod:IsTank() or mod:IsHealer() then
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_fmjc.mp3") --伐木機出現
		end
	end
end

function mod:OnSync(msg, guid)
	if msg == "LaserTarget" and guid then		
		local targetName = DBM:GetFullPlayerNameByGUID(guid)		
		warnLaserFixate:Show(targetName)
		if guid ~= UnitGUID("player") then
			local uId = DBM:GetRaidUnitId(targetName)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 8 then
					specWarnLaserFixateNear:Show(targetName)
				end
			end
			if self.Options.HudMAP then
				local spelltext = GetSpellInfo(143828)..":"..targetName
				lasermaker[targetName] = register(DBMHudMap:PlaceRangeMarkerOnPartyMember("targeting", targetName, 5, 5, 1, 0 ,0 ,1):SetLabel(spelltext))
			end
			sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\ex_so_xxhx.mp3") --小心火線
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, _, _, spellDamage)
	local cid = self:GetCIDFromGUID(destGUID)
	if not UnitIsPlayer(sourceName) then
		if Petowner[sourceGUID] then
			sourceName = Petowner[sourceGUID]
		else
			for i = 1, DBM:GetNumGroupMembers() do
				if UnitGUID("raid"..i.."pet") then
					if UnitGUID("raid"..i.."pet") == sourceGUID then
						sourceName = UnitName("raid"..i)
						Petowner[UnitGUID("raid"..i.."pet")] = UnitName("raid"..i)
						break
					end
				end
			end
		end
	end
	if spellDamage then
		if cid == 71606 then --飛彈
			if not FDDamagedplayer[sourceName] then
				FDDamagedplayer[sourceName] = spellDamage
			else
				FDDamagedplayer[sourceName] = spellDamage + FDDamagedplayer[sourceName]
			end
		elseif cid == 71751 then --激光
			if not JGDamagedplayer[sourceName] then
				JGDamagedplayer[sourceName] = spellDamage
			else
				JGDamagedplayer[sourceName] = spellDamage + JGDamagedplayer[sourceName]
			end
		elseif cid == 71790 then --地雷
			if not DLDamagedplayer[sourceName] then
				DLDamagedplayer[sourceName] = spellDamage
			else
				DLDamagedplayer[sourceName] = spellDamage + DLDamagedplayer[sourceName]
			end
		elseif cid == 71694 then --電磁
			if not DCDamagedplayer[sourceName] then
				DCDamagedplayer[sourceName] = spellDamage
			else
				DCDamagedplayer[sourceName] = spellDamage + DCDamagedplayer[sourceName]
			end
		end
	end
end
mod.SPELL_PERIODIC_DAMAGE = mod.SPELL_DAMAGE
mod.RANGE_DAMAGE = mod.SPELL_DAMAGE

function mod:SWING_DAMAGE(sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellDamage)
	local cid = self:GetCIDFromGUID(destGUID)
	if not UnitIsPlayer(sourceName) then
		if Petowner[sourceGUID] then
			sourceName = Petowner[sourceGUID]
		else
			for i = 1, DBM:GetNumGroupMembers() do
				if UnitGUID("raid"..i.."pet") then
					if UnitGUID("raid"..i.."pet") == sourceGUID then
						sourceName = UnitName("raid"..i)
						Petowner[UnitGUID("raid"..i.."pet")] = UnitName("raid"..i)
						break
					end
				end
			end
		end
	end
	if spellDamage then
		if cid == 71606 then --飛彈
			if not FDDamagedplayer[sourceName] then
				FDDamagedplayer[sourceName] = spellDamage
			else
				FDDamagedplayer[sourceName] = spellDamage + FDDamagedplayer[sourceName]
			end
		elseif cid == 71751 then --激光
			if not JGDamagedplayer[sourceName] then
				JGDamagedplayer[sourceName] = spellDamage
			else
				JGDamagedplayer[sourceName] = spellDamage + JGDamagedplayer[sourceName]
			end
		elseif cid == 71790 then --地雷
			if not DLDamagedplayer[sourceName] then
				DLDamagedplayer[sourceName] = spellDamage
			else
				DLDamagedplayer[sourceName] = spellDamage + DLDamagedplayer[sourceName]
			end
		elseif cid == 71694 then --電磁
			if not DCDamagedplayer[sourceName] then
				DCDamagedplayer[sourceName] = spellDamage
			else
				DCDamagedplayer[sourceName] = spellDamage + DCDamagedplayer[sourceName]
			end
		end
	end
end

function mod:UNIT_AURA(uId)
	if UnitDebuff("player", GetSpellInfo(143828)) then
		if not infire then
			infire = true
			if self:AntiSpam(3, 10) then
				specWarnLaserFixate:Show()
				DBM.Flash:Shake(1, 0, 0)
				yellLaserFixate:Yell()
				sndWOP:Play("Interface\\AddOns\\"..DBM.Options.CountdownVoice.."\\laserrun.mp3") --快跑,激光點你
				if mod.Options.LTFD then
					DBM:ShowLTSpecialWarning(143828, 1, 0, 0, 1, 143828, 2)
				end
				self:SendSync("LaserTarget", UnitGUID("player"))
			end
		end		
	else
		infire = false
	end
end