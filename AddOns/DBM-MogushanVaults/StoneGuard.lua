local mod	= DBM:NewMod(679, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9656 $"):sub(12, -3))
mod:SetCreatureID(60051, 60043, 59915, 60047)--Cobalt: 60051, Jade: 60043, Jasper: 59915, Amethyst: 60047
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4",
	"UNIT_DIED"
)

local warnCobaltOverload			= mod:NewSpellAnnounce(115840, 4)
local warnJadeOverload				= mod:NewSpellAnnounce(115842, 4)
local warnJasperOverload			= mod:NewSpellAnnounce(115843, 4)
local warnAmethystOverload			= mod:NewSpellAnnounce(115844, 4)
local warnCobaltMine				= mod:NewSpellAnnounce(129424, 4)
local warnJadeShards				= mod:NewSpellAnnounce(116223, 3, nil, false)
local warnJasperChains				= mod:NewTargetAnnounce(130395, 4)
local warnAmethystPool				= mod:NewTargetAnnounce(130774, 3, nil, false)
local warnPowerDown					= mod:NewSpellAnnounce(116529, 4, nil, not mod:IsTank())
local warnGSD						= mod:NewSpellAnnounce(116008)
local warnBSD						= mod:NewSpellAnnounce(115861)
local warnPSD						= mod:NewSpellAnnounce(116060)
local warnRSD						= mod:NewSpellAnnounce(116038)

local specWarnOverloadSoon			= mod:NewSpecialWarning("SpecWarnOverloadSoon", nil, nil, nil, 2)
local specWarnJasperChains			= mod:NewSpecialWarningYou(130395)
local specWarnBreakJasperChains		= mod:NewSpecialWarning("specWarnBreakJasperChains")
local yellJasperChains				= mod:NewYell(130395, nil, false)
--local specWarnCobaltMine			= mod:NewSpecialWarningYou(129424)
local specWarnCobaltMineNear		= mod:NewSpecialWarningClose(129424)
--local yellCobaltMine				= mod:NewYell(129424)
local specWarnAmethystPool			= mod:NewSpecialWarningMove(130774)
local yellAmethystPool				= mod:NewYell(130774, nil, false)
local specWarnPowerDown				= mod:NewSpecialWarningSpell(116529, not mod:IsTank())
local specWarnMySD					= mod:NewSpecialWarning("specWarnMySD")

local timerPetrification			= mod:NewNextTimer(76, 125091)
local timerCobaltMineCD				= mod:NewNextTimer(8.5, 129424)
local timerJadeShardsCD				= mod:NewCDTimer(9, 116223, nil, false)--9~12
local timerJasperChainsCD			= mod:NewCDTimer(12, 130395)--11-13
local timerAmethystPoolCD			= mod:NewCDTimer(6, 130774, nil, false)

local berserkTimer					= mod:NewBerserkTimer(420)

mod:AddBoolOption("ArrowOnJasperChains")
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("AInfoFrame", false, "sound")

local expectedBosses = 3
local Jade = EJ_GetSectionInfo(5773)
local Jasper = EJ_GetSectionInfo(5774)
local Cobalt = EJ_GetSectionInfo(5771)
local Amethyst = EJ_GetSectionInfo(5691)
local Overload = {
	["Cobalt"] = GetSpellInfo(115840),
	["Jade"] = GetSpellInfo(115842),
	["Jasper"] = GetSpellInfo(115843),
	["Amethyst"] = GetSpellInfo(115844)
}
--local scansDone = 0
local activePetrification = nil
local playerHasChains = false
local jasperChainsTargets = {}
local amethystPoolTargets = {}

local function warnAmethystPoolTargets()
	warnAmethystPool:Show(table.concat(amethystPoolTargets, "<, >"))
	timerAmethystPoolCD:Start()
	table.wipe(amethystPoolTargets)
end

local function poolTargetCheck(name)
	if #amethystPoolTargets > 0 and name then
		for i = 1, #amethystPoolTargets do
			if amethystPoolTargets[i] == name then
				return false
			end
		end
	end
	return true
end

local function warnJasperChainsTargets()
	warnJasperChains:Show(table.concat(jasperChainsTargets, "<, >"))
	table.wipe(jasperChainsTargets)
end

local function getBossuId(Boss)
	local uId
	if UnitExists("boss1") or UnitExists("boss2") or UnitExists("boss3") or UnitExists("boss4") then
		for i = 1, 4 do
			if UnitName("boss"..i) == Boss then
				uId = "boss"..i
				break
			end
		end
	else
		for i = 1, DBM:GetNumGroupMembers() do
			if UnitName("raid"..i.."target") == Boss and not UnitIsPlayer("raid"..i.."target") then
				uId = "raid"..i.."target"
				break
			end			
		end
	end
	return uId
end

local function isTank(unit)
	if GetPartyAssignment("MAINTANK", unit, 1) then
		return true
	end
	if UnitGroupRolesAssigned(unit) == "TANK" then
		return true
	end
	local uId = getBossuId(Cobalt)
	if uId and UnitExists(uId.."target") and UnitDetailedThreatSituation(unit, uId) then
		return true
	end
	return false
end

--[[
function mod:ClobaltMineTarget(targetname)
	warnCobaltMine:Show(targetname)
	if targetname == UnitName("player") then
		specWarnCobaltMine:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
		yellCobaltMine:Yell()
		if activePetrification ~= "Cobalt" then
			DBM.Flash:Show(1, 0, 0)
		end
	else
		local uId = DBM:GetRaidUnitId(targetname)
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 8 then
				specWarnCobaltMineNear:Show(targetname)
				if activePetrification ~= "Cobalt" then
					DBM.Flash:Show(1, 0, 0)
				end
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
			end
		end
	end
end

function mod:ScanHandler(ScansCompleted)
	scansDone = scansDone + 1
	local targetname, uId = self:GetBossTarget(60051)
	-- UnitExists also accepts not unit id but unitname. so we can use unitname as UnitExists parameter. and it also works with player controlled pet.
	if UnitExists(targetname) then
		if isTank(uId) and not ScansCompleted then--He's targeting a tank.
			if scansDone < 12 then--Make sure no infinite loop.
				self:ScheduleMethod(0.05, "ScanHandler")--Check multiple times to be sure it's not on something other then tank.
			else
				self:ScanHandler(true)--It's still on tank, force true isTank and activate else rule and warn trap is on tank.
			end
		else--He's not targeting a tank target (or isTank was set to true after 12 scans) so this has to be right target.
			self:UnscheduleMethod("ScanHandler")--Unschedule all checks just to be sure none are running, we are done.
			self:ClobaltMineTarget(targetname)
		end
	else--target was nil, lets schedule a rescan here too.
		if scansDone < 12 then--Make sure not to infinite loop here as well.
			self:ScheduleMethod(0.05, "ScanHandler")
		end
	end
end
--]]

local RPN, GPN, BPN, PPN = 0, 0, 0, 0
local Nextoverloadboss
local SDSTAT, NOSTAT

local SDNOW = {
	["Rsdnow"] = {true} ,
	["Gsdnow"] = {true} ,
	["Bsdnow"] = {true} ,
	["Psdnow"] = {true}
}


local function 	ChecknextOverload()
	for i = 1, 4 do
		if UnitName("boss"..i) == Jasper then
			RPN = UnitPower("boss"..i)
		elseif UnitName("boss"..i) == Jade then
			GPN = UnitPower("boss"..i)
		elseif UnitName("boss"..i) == Cobalt then
			BPN = UnitPower("boss"..i)
		elseif UnitName("boss"..i) == Amethyst then
			PPN = UnitPower("boss"..i)
		end
	end
	if SDNOW["Rsdnow"] then RPN = 0 end
	if SDNOW["Gsdnow"] then GPN = 0 end
	if SDNOW["Bsdnow"] then BPN = 0 end
	if SDNOW["Psdnow"] then PPN = 0 end
	if RPN == 0 and GPN == 0 and BPN == 0 and PPN == 0 then return end
	Nextoverloadboss = math.max(RPN, GPN, BPN, PPN)
	if Nextoverloadboss == RPN then
		NOSTAT = L.NEXTR
	elseif Nextoverloadboss == GPN then
		NOSTAT = L.NEXTG
	elseif Nextoverloadboss == BPN then
		NOSTAT = L.NEXTB
	elseif Nextoverloadboss == PPN then
		NOSTAT = L.NEXTP
	end
	if mod.Options.InfoFrame then
		DBM.InfoFrame:SetHeader(NOSTAT.."  "..SDSTAT)
		DBM.InfoFrame:Show(4, "cobalypower", SDNOW)
	end
	if mod.Options.AInfoFrame then
		DBM.InfoFrame:SetHeader(SDSTAT)
		DBM.InfoFrame:Show(4, "cobalypower", SDNOW, true)
	end
end

function mod:ThreeBossStart(delay)
	for i = 1, 5 do
		local id = self:GetUnitCreatureId("boss"..i)
		if id == 60051 then -- cobalt
			if self:IsDifficulty("lfr25") then
				timerCobaltMineCD:Start(10.5-delay-1)
			else
				timerCobaltMineCD:Start(-delay-1)
			end
		elseif id == 60043 then -- jade
			timerJadeShardsCD:Start(-delay-1)
		elseif id == 59915 then -- jasper
			timerJasperChainsCD:Start(-delay-1)
		elseif id == 60047 then -- amethyst
			timerAmethystPoolCD:Start(-delay-1)
		end
	end
end

function mod:OnCombatStart(delay)
	activePetrification = nil
--	scansDone = 0
	playerHasChains = false
	table.wipe(jasperChainsTargets)
	table.wipe(amethystPoolTargets)
	berserkTimer:Start()--7 min berserk on heroic 10 and 25 at least, unsure about normal/LFR, since i've never seen a log reach 7 min yet in LFR or normal
	if self:IsDifficulty("normal25", "heroic25") then
		timerCobaltMineCD:Start(-delay)
		timerJadeShardsCD:Start(-delay)
		timerJasperChainsCD:Start(-delay)
		timerAmethystPoolCD:Start(-delay)
		expectedBosses = 4--Only fight all 4 at once on 25man (excluding LFR)
	else
		expectedBosses = 3--Else you get a random set of 3/4
		self:ScheduleMethod(1, "ThreeBossStart", delay)
	end
	SDSTAT = L.SDNOT
	RPN, GPN, BPN, PPN = 0, 0, 0, 0
	SDNOW = {
	["Rsdnow"] = {true} ,
	["Gsdnow"] = {true} ,
	["Bsdnow"] = {true} ,
	["Psdnow"] = {true}
	}
	if self.Options.InfoFrame and not self.Options.AInfoFrame then
		DBM.InfoFrame:SetHeader(SDSTAT)
		DBM.InfoFrame:Show(4, "cobalypower", SDNOW)
	end
	if self.Options.AInfoFrame then
		DBM.InfoFrame:SetHeader(SDSTAT)
		DBM.InfoFrame:Show(4, "cobalypower", SDNOW, true)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame or self.Options.AInfoFrame then
		SDSTAT = nil
		DBM.InfoFrame:Hide()
	end
	if self.Options.ArrowOnJasperChains then
		DBM.Arrow:Hide()
	end
end 

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(130395) then
		jasperChainsTargets[#jasperChainsTargets + 1] = args.destName
		timerJasperChainsCD:Start()
		self:Unschedule(warnJasperChainsTargets)
		self:Schedule(0.3, warnJasperChainsTargets)
		if activePetrification ~= "Jasper" then
			if self.Options.ArrowOnJasperChains and #jasperChainsTargets == 2 then
				if jasperChainsTargets[1] == UnitName("player") then
					DBM.Arrow:ShowRunTo(jasperChainsTargets[2])
				elseif jasperChainsTargets[2] == UnitName("player") then
					DBM.Arrow:ShowRunTo(jasperChainsTargets[1])
				end
			end
		end
		if args:IsPlayer() then
			playerHasChains = true
			if not self:IsDifficulty("lfr25") then
				yellJasperChains:Yell()
			end
			local uId = getBossuId(Jasper)
			if uId and (UnitPower(uId) <= 80) and (activePetrification == "Jasper") then--Make sure his energy isn't already high, otherwise breaking chains when jasper will only be active for a few seconds is bad
				specWarnBreakJasperChains:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_ldsl.mp3") --拉斷鎖鏈
				DBM.Arrow:Hide()
			else
				specWarnJasperChains:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lx.mp3")--連線快靠近
			end
		end
	elseif args:IsSpellID(130774) and args:IsPlayer() then
		specWarnAmethystPool:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")--快躲開
	elseif args:IsSpellID(115745) then
		if args.destName == Jasper then SDNOW["Rsdnow"] = true end
		if args.destName == Jade then SDNOW["Gsdnow"] = true end
		if args.destName == Cobalt then SDNOW["Bsdnow"] = true end
		if args.destName == Amethyst then SDNOW["Psdnow"] = true end
		if SDSTAT ~=nil then
			ChecknextOverload()
		end
		if args.sourceGUID == UnitGUID("target") then
			if mod:IsTank() then
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_mbsh.mp3")--目標石化
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(130395) and args:IsPlayer() then
		playerHasChains = false
		if self.Options.ArrowOnJasperChains then
			DBM.Arrow:Hide()
		end
	elseif args:IsSpellID(115745) then
		if args.destName == Jasper then SDNOW["Rsdnow"] = false end
		if args.destName == Jade then SDNOW["Gsdnow"] = false end
		if args.destName == Cobalt then SDNOW["Bsdnow"] = false end
		if args.destName == Amethyst then SDNOW["Psdnow"] = false end	
		ChecknextOverload()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(115840) then -- Cobalt
		warnCobaltOverload:Show()
		if activePetrification == "Cobalt" then
			timerPetrification:Cancel()
			SDSTAT = L.SDNOT
			ChecknextOverload()
			activePetrification = nil
		else
			ChecknextOverload()
		end
	elseif args:IsSpellID(115842) then -- Jade
		warnJadeOverload:Show()
		if activePetrification == "Jade" then
			timerPetrification:Cancel()
			SDSTAT = L.SDNOT
			ChecknextOverload()
			activePetrification = nil
		else
			ChecknextOverload()
		end
	elseif args:IsSpellID(115843) then -- Jasper
		warnJasperOverload:Show()
		if activePetrification == "Jasper" then
			timerPetrification:Cancel()
			SDSTAT = L.SDNOT
			ChecknextOverload()
			activePetrification = nil
		else
			ChecknextOverload()
		end
	elseif args:IsSpellID(115844) then -- Amethyst
		warnAmethystOverload:Show()
		if activePetrification == "Amethyst" then
			timerPetrification:Cancel()
			SDSTAT = L.SDNOT
			ChecknextOverload()
			activePetrification = nil
		else
			ChecknextOverload()
		end
	elseif args:IsSpellID(116223) then
		warnJadeShards:Show()
		timerJadeShardsCD:Start()
	elseif args:IsSpellID(116235, 130774) then--is 116235 still used? my logs show ONLY 130774 being used.
		if poolTargetCheck(args.destName) then--antispam can not prevent spam, try another way.
			amethystPoolTargets[#amethystPoolTargets + 1] = args.destName
			self:Unschedule(warnAmethystPoolTargets)
			self:Schedule(0.5, warnAmethystPoolTargets)
		end
	end
end

function mod:RAID_BOSS_EMOTE(msg, boss)
	if msg == L.Overload or msg:find(L.Overload) then--Cast trigger is an emote 7 seconds before, CLEU only shows explosion. Just like nefs electrocute
		self:SendSync("Overload", boss == Cobalt and "Cobalt" or boss == Jade and "Jade" or boss == Jasper and "Jasper" or boss == Amethyst and "Amethyst" or "Unknown")
	elseif msg:find("spell:116529") then
		warnPowerDown:Show()
		specWarnPowerDown:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_dzcz.mp3")--地磚重置
	end
end

function mod:OnSync(msg, boss)
	-- if boss aprats from 10 yard and get Solid Stone, power no longer increase. If this, overlord not casts. So timer can be confusing. Disabled for find better way. 
	if msg == "Overload" and self:AntiSpam(2, 6) then
		specWarnOverloadSoon:Show(Overload[boss])
		if boss == "Cobalt" then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lscz.mp3") --藍色超載		
		elseif boss == "Jade" then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lvscz.mp3") --綠色超載
		elseif boss == "Jasper" then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_hscz.mp3") --紅色超載
		elseif boss == "Amethyst" then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zscz.mp3") --紫色超載
		end
		ChecknextOverload()
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 60051 or cid == 60043 or cid == 59915 or cid == 60047 then--Fight is over. NYI, amethyst guardian CID is not yet known.
		expectedBosses = expectedBosses - 1
		if expectedBosses == 0 then
			DBM:EndCombat(self)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 115852 then
		activePetrification = "Cobalt"
		timerPetrification:Start()
		warnBSD:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lssh.mp3") --藍色石化
		SDSTAT = L.SDBLUE		
		ChecknextOverload()
		if UnitName(getBossuId(Cobalt).."target") == UnitName("player") then
			if mod:IsTank() then
				specWarnMySD:Show()
			end
		end
	elseif spellId == 116006 then
		activePetrification = "Jade"
		timerPetrification:Start()
		warnGSD:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lvssh.mp3") --綠色石化
		SDSTAT = L.SDGREEN
		ChecknextOverload()
		if UnitName(getBossuId(Jade).."target") == UnitName("player") then
			if mod:IsTank() then
				specWarnMySD:Show()
			end
		end
	elseif spellId == 116036 then
		activePetrification = "Jasper"
		timerPetrification:Start()
		warnRSD:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_hssh.mp3") --紅色石化
		SDSTAT = L.SDRED
		ChecknextOverload()
		if UnitName(getBossuId(Jasper).."target") == UnitName("player") then
			if mod:IsTank() then
				specWarnMySD:Show()
			end
		end
		if playerHasChains then
			local uId = getBossuId(Jasper)
			if uId and (UnitPower(uId) <= 80) and (activePetrification == "Jasper") then
				specWarnBreakJasperChains:Show()
				sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_ldsl.mp3") --拉斷鎖鏈
				DBM.Arrow:Hide()
			end
		end
	elseif spellId == 116057 then
		activePetrification = "Amethyst"
		timerPetrification:Start()
		warnPSD:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zssh.mp3") --紫色石化
		SDSTAT = L.SDPURPLE
		ChecknextOverload()
		if UnitName(getBossuId(Amethyst).."target") == UnitName("player") then
			if mod:IsTank() then
				specWarnMySD:Show()
			end
		end
	elseif spellId == 129424 then
		warnCobaltMine:Show()
		if self:IsDifficulty("lfr25") then
			timerCobaltMineCD:Start(10.5)
		else
			timerCobaltMineCD:Start()
		end
	end
end

-- overload this to handle the 10-men version (which only has 3 of the bosses) properly
function mod:GetHP()
	-- shared health pool, we only need to find one of these mobs, reporting all of them would be pointless
	local cobaltHp = self:GetBossHPString(60051)
	local jadeHp = self:GetBossHPString(60043)
	return cobaltHp ~= DBM_CORE_UNKNOWN and cobaltHp or jadeHp
end

