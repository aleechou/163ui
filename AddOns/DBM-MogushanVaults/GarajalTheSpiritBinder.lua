local mod	= DBM:NewMod(682, "DBM-MogushanVaults", nil, 317)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:NewSound(nil, "SoundWOP", true)

mod:SetRevision(("$Revision: 9663 $"):sub(12, -3))
mod:SetCreatureID(60143)
mod:SetZone()
mod:SetUsedIcons(5, 6, 7, 8)
mod:SetMinSyncRevision(7751)

-- Sometimes it fails combat detection on "combat". Use yell instead until the problem being founded.
--seems that combat detection fails only in lfr. (like DS Zonozz Void of Unmaking summon event.)
mod:RegisterCombat("yell", L.Pull)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"UNIT_HEALTH",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--NOTES
--Syncing is used for all warnings because the realms don't share combat events. You won't get warnings for other realm any other way.
--Voodoo dolls do not have a CD, they are linked to banishment (or player deaths), when he banishes current tank, he reapplies voodoo dolls to new tank and new players. If tank dies, he just recasts voodoo on a new current threat target.
--Latency checks are used for good reason (to prevent lagging users from sending late events and making our warnings go off again incorrectly). if you play with high latency and want to bypass latency check, do so with in game GUI option.
local warnTotem						= mod:NewCountAnnounce(116174, 2)
local warnVoodooDolls				= mod:NewTargetAnnounce(122151, 3)
local warnCrossedOver				= mod:NewTargetAnnounce(116161, 3)
local warnBanishment				= mod:NewTargetAnnounce(116272, 3)
local warnSuicide					= mod:NewPreWarnAnnounce(116325, 5, 4)--Pre warn 5 seconds before you die so you take whatever action you need to, to prevent. (this is effect that happens after 30 seconds of Soul Sever

local specWarnTotem					= mod:NewSpecialWarningSpell(116174, false)
local specWarnBanishment			= mod:NewSpecialWarningYou(116272)
local specWarnBanishmentOther		= mod:NewSpecialWarningTarget(116272, mod:IsTank())
local specWarnVoodooDolls			= mod:NewSpecialWarningSpell(122151, false)
local specWarnGD					= mod:NewSpecialWarningYou(122181)
local specWarnVoodooDollsMe			= mod:NewSpecialWarningYou(122151, false)

local specWarnjs				= mod:NewSpecialWarning("SpecWarnjs")
local specWarninTT					= mod:NewSpecialWarning("specWarninTT")

local timerTotemCD					= mod:NewNextCountTimer(20, 116174)
local timerBanishmentCD				= mod:NewCDTimer(65, 116272)
local timerSoulSever				= mod:NewBuffFadesTimer(30, 116278)--Tank version of spirit realm
local timerCrossedOver				= mod:NewBuffFadesTimer(30, 116161)--Dps version of spirit realm
local timerShadowyAttackCD			= mod:NewCDTimer(8, "ej6698", nil, nil, nil, 117222)

local prewarnedPhase2 = false
local warnPhase2Soon					= mod:NewPrePhaseAnnounce(2, 3)
local inTotem = false
local totemn = 0
local myraidindex = 0
local mychooseindex = 0

local choseh = {}
local sh = {}
local healthname
local testn = 0
local chosed = {}
local dh = {}
local dpsname
local testd = 0
local dpssendn = 0

local incombat = false
local cansend = false
local scaned = false

--local countdownCrossedOver			= mod:NewCountdown(29, 116161)
local berserkTimer					= mod:NewBerserkTimer(360)

mod:AddBoolOption("SetIconOnVoodoo", true)

local voodooDollTargets = {}
local crossedOverTargets = {}
local voodooDollTargetIcons = {}
mod:AddBoolOption("InfoFrame", true, "sound")
mod:AddBoolOption("GoTotemAdmin", false, "sound")
mod:AddBoolOption("GoTotemClient", true, "sound")


for i = 1, 17 do
	mod:AddBoolOption("IgnoreTT"..i, false, "sound")
end

mod:AddDropdownOption("optAdminTT", {"send1", "send2", "send3", "send4"}, "send3", "sound")

mod:AddDropdownOption("optindex", {"noidex", "index1", "index2", "index3", "index4", "index5", "index6", "index7", "index8", "index9"}, "noidex", "sound")

mod:AddDropdownOption("countTT", {"countnone", "count3", "count4"}, "countnone", "sound")

if GetGuildInfo("player") then
	if string.find(GetGuildInfo("player"), "黑手") then
		mod:AddDropdownOption("optjs", {"non", "paltank", "monktank", "druid", "priest", "palheal", "warrior1", "warrior2", "paldps1", "paldps2"}, "non", "sound")
	end
end

local guids = {}
local voodooDollWarned = false
local guidTableBuilt = false--Entirely for DCs, so we don't need to reset between pulls cause it doesn't effect building table on combat start and after a DC then it will be reset to false always
local function buildGuidTable()
	table.wipe(guids)
	for i = 1, DBM:GetNumGroupMembers() do
		guids[UnitGUID("raid"..i) or "none"] = GetRaidRosterInfo(i)
	end
end

local function warnVoodooDollTargets()
	warnVoodooDolls:Show(table.concat(voodooDollTargets, "<, >"))
	if not voodooDollWarned then
		specWarnVoodooDolls:Show()
	end
	voodooDollWarned = false
	table.wipe(voodooDollTargets)
end

local function warnCrossedOverTargets()
	warnCrossedOver:Show(table.concat(crossedOverTargets, "<, >"))
	table.wipe(crossedOverTargets)
end

local function removeIcon(target)
	for i,j in ipairs(voodooDollTargetIcons) do
		if j == target then
			table.remove(voodooDollTargetIcons, i)
			mod:SetIcon(target, 0)
			break
		end
	end
end

local function getraidindex()
	for i = 1, DBM:GetNumGroupMembers() do
		if UnitName("raid"..i) == UnitName("player") then
			myraidindex = i
			break
		end
	end	
	if mod.Options.GoTotemClient then
		mychooseindex = mod.Options.optindex == "index1" and 1 or mod.Options.optindex == "index2" and 2 or mod.Options.optindex == "index3" and 3 or mod.Options.optindex == "index4" and 4 or mod.Options.optindex == "index5" and 5 or mod.Options.optindex == "index6" and 6 or mod.Options.optindex == "index7" and 7 or mod.Options.optindex == "index8" and 8 or mod.Options.optindex == "index9" and 9 or mod.Options.optindex == "noidex" and 99
	end
	if mod:IsDps() then
		myraidindex = myraidindex.."/"..mychooseindex
	end
end

local function IgnoreTotem()
	if (mod.Options.IgnoreTT1 and totemn == 1) or (mod.Options.IgnoreTT2 and totemn == 2) or (mod.Options.IgnoreTT3 and totemn == 3) or (mod.Options.IgnoreTT4 and totemn == 4) or (mod.Options.IgnoreTT5 and totemn == 5) or (mod.Options.IgnoreTT6 and totemn == 6) or (mod.Options.IgnoreTT7 and totemn == 7) or (mod.Options.IgnoreTT8 and totemn == 8) or (mod.Options.IgnoreTT9 and totemn == 9) or (mod.Options.IgnoreTT10 and totemn == 10) or (mod.Options.IgnoreTT11 and totemn == 11) or (mod.Options.IgnoreTT12 and totemn == 12) or (mod.Options.IgnoreTT13 and totemn == 13) or (mod.Options.IgnoreTT14 and totemn == 14) or (mod.Options.IgnoreTT15 and totemn == 15) or (mod.Options.IgnoreTT16 and totemn == 16) or (mod.Options.IgnoreTT17 and totemn == 17) then
		return false
	end
	return true
end

local function choosehealther()
	table.wipe(sh)
	for k,v in pairs(choseh) do
        table.insert(sh,{K=k,V=v})
	end
	table.sort (sh,function(a,b) return a.V< b.V end)
	
	if #sh == 0 and testn < 10 then
		mod:Schedule(0.1, choosehealther)
		testn = testn + 1
	elseif #sh > 0 and IgnoreTotem() then
		print("==主控治療分配===")
		for key, value in ipairs(sh) do
			if key == 1 then
				healthname = UnitName("raid"..value.K)
				print("已發送:"..healthname)
				mod:SendSync("Gointotem", healthname)
			end
		end
		testn = 0
		table.wipe(choseh)
	else
		if IgnoreTotem() then
			print("未分配治療入場")
		else
			print("此圖騰("..totemn..")被忽略")
		end
		testn = 0
		table.wipe(choseh)
	end
end

local function choosedps()
	table.wipe(dh)
	for k,v in pairs(chosed) do
        table.insert(dh,{K=k,V=v})
	end
	table.sort (dh,function(a,b) return a.V< b.V end)
	dpssendn = mod.Options.optAdminTT == "send1" and 2 or mod.Options.optAdminTT == "send2" and 3 or mod.Options.optAdminTT == "send3" and 4 or mod.Options.optAdminTT == "send4" and 5
	if #dh <= 2 and testd < 10 then
		mod:Schedule(0.1, choosedps)
		testd = testd + 1
	elseif #dh >= 1 and IgnoreTotem() then
		print("==主控DPS分配===")
		for key, value in ipairs(dh) do
			if key < dpssendn then
				dpsname = UnitName("raid"..value.K)
				print("已發送:"..dpsname.."  優先序列:"..value.V)
				mod:SendSync("Gointotem", dpsname)
			end
		end
		testd = 0
		table.wipe(chosed)
	elseif #dh == 0 then
		if IgnoreTotem() then
			print("未分配輸出入場")
		end
		testd = 0
		table.wipe(chosed)
	end
end

--[[
local function ClearVoodooTargets()
	table.wipe(voodooDollTargetIcons)
end--]]

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetVoodooIcons()
		table.sort(voodooDollTargetIcons, sort_by_group)
		local voodooIcon = 8
		for i, v in ipairs(voodooDollTargetIcons) do
			-- DBM:SetIcon() is used because of follow reasons
			--1. It checks to make sure you're on latest dbm version, if you are not, it disables icon setting so you don't screw up icons (ie example, a newer version of mod does icons differently)
			--2. It checks global dbm option "DontSetIcons"
			self:SetIcon(v, voodooIcon)
			voodooIcon = voodooIcon - 1
		end
--		self:Schedule(1.5, ClearVoodooTargets)--Table wipe delay so if icons go out too early do to low fps or bad latency, when they get new target on table, resort and reapplying should auto correct teh icon within .2-.4 seconds at most.
	end
end

local vd = 0
local ct = 0

function mod:OnCombatStart(delay)
	voodooDollWarned = false
	buildGuidTable()
	table.wipe(voodooDollTargets)
	table.wipe(crossedOverTargets)
	table.wipe(voodooDollTargetIcons)
	timerShadowyAttackCD:Start(7-delay)
	totemn = 0
	if self:IsDifficulty("normal25", "heroic25") then
		timerTotemCD:Start(20-delay, totemn+1)
	elseif self:IsDifficulty("lfr25") then
		timerTotemCD:Start(30-delay, totemn+1)
	else
		timerTotemCD:Start(36-delay, totemn+1)
	end
	timerBanishmentCD:Start(-delay)
	prewarnedPhase2 = false
	inTotem = false
	vd = 0
	ct = 0
	incombat = true
	if not self:IsDifficulty("lfr25") then -- lfr seems not berserks.
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	incombat = false
end



function mod:SPELL_AURA_APPLIED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args:IsSpellID(122151) then
		if args:IsPlayer() and (not mod:IsTank()) then
			specWarnVoodooDollsMe:Show()
			voodooDollWarned = true
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_wwsn.mp3")--娃娃是你
		end
		if self:LatencyCheck() then
			self:SendSync("VoodooTargets", args.destGUID)
		end
		vd = vd + 1
		if vd == 1 then
			if mod.Options.optjs == "druid" then
				self:Schedule(1, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("樹皮","彪哥")
				end)
			end
			if mod.Options.optjs == "priest" then
				self:Schedule(10, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("罩子","彪哥")
				end)
			end
			if mod.Options.optjs == "paltank" then
				self:Schedule(20, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("盾牆","你")
				end)
				self:Schedule(42, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("忠誠防禦者","你")
				end)
				self:Schedule(52, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("保護+群體減傷","你")
				end)
			end
			if mod.Options.optjs == "palheal" then
				self:Schedule(32, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","彪哥")
				end)
			end
			if mod.Options.optjs == "warrior1" then
				self:Schedule(32, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("減傷+破釜","彪哥")
				end)
			end
			if mod.Options.optjs == "warrior2" then
				self:Schedule(42, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("減傷+破釜","彪哥")
				end)
			end
		end
	elseif args:IsSpellID(116161, 116160) then -- 116161 is normal and heroic, 116160 is lfr.
		if args:IsPlayer() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kj.mp3")--跨界
			warnSuicide:Schedule(25)
--			countdownCrossedOver:Start(29)
			timerCrossedOver:Start(29)
			sndWOP:Schedule(23.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jjsw.mp3")--即將死亡
			sndWOP:Schedule(25, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(26, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(27, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(28, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(29, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(116161))
			DBM.InfoFrame:Show(10, "playerbaddebuff", 116161)
		end
		if not self:IsDifficulty("lfr25") then -- lfr totems not breakable, instead totems can click. so lfr warns can be spam, not needed to warn. also CLEU fires all players, no need to use sync.
			crossedOverTargets[#crossedOverTargets + 1] = args.destName
			self:Unschedule(warnCrossedOverTargets)
			self:Schedule(0.3, warnCrossedOverTargets)		
		end
	elseif args:IsSpellID(116278) then--this is tank spell, no delays?
		if args:IsPlayer() then--no latency check for personal notice you aren't syncing.
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kj.mp3")
			timerSoulSever:Start()
--			countdownCrossedOver:Start(29)
			warnSuicide:Schedule(25)
			sndWOP:Schedule(23.5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jjsw.mp3")
			sndWOP:Schedule(25, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(26, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(27, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(28, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(29, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
	elseif args:IsSpellID(116260) then
		if args:IsPlayer() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kj.mp3")
		end
		if mod.Options.InfoFrame then
			DBM.InfoFrame:SetHeader(GetSpellInfo(116260))
			DBM.InfoFrame:Show(10, "playerbaddebuff", 116260)
		end
	elseif args:IsSpellID(117752) then
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kl.mp3") --狂亂
	end
	if UnitDebuff("player", GetSpellInfo(122181)) then
		if not inTotem then
			specWarnGD:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jrgd.mp3") --進入管道
		end
		inTotem = true
	else
		inTotem = false
	end
end

function mod:SPELL_AURA_REMOVED(args)--We don't use spell cast success for actual debuff on >player< warnings since it has a chance to be resisted.
	if args:IsSpellID(116161, 116160) and args:IsPlayer() then
		warnSuicide:Cancel()
--		countdownCrossedOver:Cancel()
		timerCrossedOver:Cancel()	
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kj.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jjsw.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	elseif args:IsSpellID(116278) and args:IsPlayer() then
		timerSoulSever:Cancel()
		warnSuicide:Cancel()
--		countdownCrossedOver:Cancel()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kj.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_jjsw.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
	elseif args:IsSpellID(122151) then
		self:SendSync("VoodooGoneTargets", args.destGUID)
	elseif args:IsSpellID(116260) then
		if args:IsPlayer() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_kj.mp3")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(116174) then
		if self:LatencyCheck() then
			self:SendSync("SummonTotem")
		end
	elseif args:IsSpellID(116272) then
		if args:IsPlayer() then--no latency check for personal notice you aren't syncing.
			specWarnBanishment:Show()
		elseif not mod:IsDps() then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\changemt.mp3") --換坦嘲諷
		end
		if self:LatencyCheck() then
			self:SendSync("BanishmentTarget", args.destGUID)
		end
	end
end

function mod:OnSync(msg, guid)
	--Make sure we build a table if we DCed mid fight, before we try comparing any syncs to that table.
	if not guidTableBuilt then
		buildGuidTable()
		guidTableBuilt = true
	end
	if msg == "SummonTotem" and self:AntiSpam(10, 3) then
		totemn = totemn + 1
		warnTotem:Show(totemn)
		cansend = false
		scaned = false
		
		if incombat then
			if self.Options.GoTotemClient then
				getraidindex()
				if not UnitDebuff("player", GetSpellInfo(122151)) and not UnitDebuff("player", GetSpellInfo(116161)) and not UnitBuff("player", GetSpellInfo(117543)) and not UnitIsDeadOrGhost("player") then
					if UnitDebuff("player", GetSpellInfo(117723)) then
						for i = 1, 40 do
							if select(11, UnitDebuff("player", i)) == 117723 then
								scaned = true
								_, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", i)
								if expires - GetTime() < 6 then
									cansend = true
								end
								break
							end
						end
						if not scaned then cansend = true end
					else
						cansend = true
					end
				end
				if cansend then
					if mod:IsHealer() then
						self:SendSync("HealthSend", myraidindex)
					elseif mod:IsDps() then
						if mychooseindex~=99 then
							local sendtime = mychooseindex/10 - 0.09
							self:Schedule(sendtime, function()
								self:SendSync("DpsSend", myraidindex)
							end)
						end
					end
				end
			end
		end
		
		if self.Options.GoTotemAdmin and UnitIsGroupLeader("player") then
			if mod:IsDifficulty("heroic10", "heroic25") then
				self:Schedule(1.5, choosehealther)
				self:Schedule(1.5, choosedps)
			end
		end

		specWarnTotem:Show()
		if self:IsDifficulty("normal25", "heroic25") then
			timerTotemCD:Start(20, totemn+1)
		elseif self:IsDifficulty("lfr25") then
			timerTotemCD:Start(30, totemn+1)
		else
			timerTotemCD:Start(36, totemn+1)
		end
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_lhtt.mp3")
		
		if self.Options.countTT == "count4" then
			if totemn % 4 == 1 then
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			elseif totemn % 4 == 2 then
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			elseif totemn % 4 == 3 then
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			else
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			end
		elseif self.Options.countTT == "count3" then
			if totemn % 3 == 1 then
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
			elseif totemn % 3 == 2 then
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			else
				sndWOP:Schedule(1.2, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			end
		end
		
	elseif msg == "VoodooTargets" and guids[guid] then
		voodooDollTargets[#voodooDollTargets + 1] = guids[guid]
		self:Unschedule(warnVoodooDollTargets)
		self:Schedule(0.3, warnVoodooDollTargets)
		if self.Options.SetIconOnVoodoo then
			table.insert(voodooDollTargetIcons, DBM:GetRaidUnitId(guids[guid]))
			self:UnscheduleMethod("SetVoodooIcons")
			if self:LatencyCheck() then--lag can fail the icons so we check it before allowing.
				self:ScheduleMethod(1, "SetVoodooIcons")
			end
		end
	elseif msg == "VoodooGoneTargets" and guids[guid] and self.Options.SetIconOnVoodoo then
		removeIcon(DBM:GetRaidUnitId(guids[guid]))
	elseif msg == "BanishmentTarget" and guids[guid] then
		warnBanishment:Show(guids[guid])
		timerBanishmentCD:Start()
		if guid ~= UnitGUID("player") then--make sure YOU aren't target before warning "other"
			specWarnBanishmentOther:Show(guids[guid])
		end
		
		ct = ct + 1
		
		if ct == 1 then
			if mod.Options.optjs == "monktank" then
				self:Schedule(2, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("閃避+金剛不壞","你")
				end)
			end
			if mod.Options.optjs == "paldps1" then
				self:Schedule(10, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","夏洛特")
				end)
			end
			if mod.Options.optjs == "paltank" then
				self:Schedule(22, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","夏洛特")
				end)
			end
			if mod.Options.optjs == "priest" then
				self:Schedule(34, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("壓制","夏洛特")
				end)
			end
			if mod.Options.optjs == "paldps2" then
				self:Schedule(44, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲+群體減傷","夏洛特")
				end)
			end
			if mod.Options.optjs == "paldps1" then
				self:Schedule(54, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("保護","夏洛特")
				end)
			end
		elseif ct == 2 then		
			if mod.Options.optjs == "paltank" then
				self:Schedule(2, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("聖佑","你")
				end)
				self:Schedule(54, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("保護","你")
				end)
			end
			if mod.Options.optjs == "monktank" then
				self:Schedule(2, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("群體減傷","彪哥")
				end)
			end
			if mod.Options.optjs == "palheal" then
				self:Schedule(12, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","彪哥")
				end)
			end
			if mod.Options.optjs == "paldps2" then
				self:Schedule(24, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","彪哥")
				end)
			end
			if mod.Options.optjs == "druid" then
				self:Schedule(32, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("樹皮","彪哥")
				end)
			end
			if mod.Options.optjs == "paldps1" then
				self:Schedule(44, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲+群體減傷","彪哥")
				end)
			end
		elseif ct == 3 then		
			if mod.Options.optjs == "monktank" then
				self:Schedule(2, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("盾牆","你")
				end)
				self:Schedule(20, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("閃避+金剛不壞","你")
				end)
			end
			if mod.Options.optjs == "paltank" then
				self:Schedule(20, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("群體減傷","夏洛特")
				end)
				self:Schedule(40, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","夏洛特")
				end)
			end
			if mod.Options.optjs == "paldps1" then
				self:Schedule(30, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","夏洛特")
				end)
				self:Schedule(52, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("保護","夏洛特")
				end)
			end
			if mod.Options.optjs == "priest" then
				self:Schedule(45, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("罩子","夏洛特")
				end)
			end
		elseif ct == 4 then
			if mod.Options.optjs == "paltank" then
				self:Schedule(2, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("聖佑","你")
				end)
				self:Schedule(12, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("盾牆","你")
				end)
				self:Schedule(30, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("忠誠防禦者","你")
				end)
				self:Schedule(54, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("無敵","你")
				end)
			end
			if mod.Options.optjs == "palheal" then
				self:Schedule(2, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","彪哥")
				end)
			end
			if mod.Options.optjs == "monktank" then
				self:Schedule(12, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("群體減傷","彪哥")
				end)
			end
			if mod.Options.optjs == "priest" then
				self:Schedule(20, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("壓制","彪哥")
				end)
			end
			if mod.Options.optjs == "druid" then
				self:Schedule(30, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("樹皮","彪哥")
				end)
			end
			if mod.Options.optjs == "paldps2" then
				self:Schedule(30, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("群體減傷","彪哥")
				end)
				self:Schedule(42, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("犧牲","彪哥")
				end)
			end
			if mod.Options.optjs == "warrior1" then
				self:Schedule(42, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("減傷+破釜","彪哥")
				end)
			end
			if mod.Options.optjs == "warrior2" then
				self:Schedule(54, function()
					sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\didi.mp3")
					specWarnjs:Show("減傷+破釜","彪哥")
				end)
			end
		end
	elseif msg == "HealthSend" and guid then
		if self.Options.GoTotemAdmin then
			choseh[guid] = UnitPower("raid"..guid)
		end
	elseif msg == "DpsSend" and guid then
		if self.Options.GoTotemAdmin then
			local a,raidi,index
			a=string.find(guid, "/")
			raidi = string.sub(guid, 1, a-1)
			index = string.sub(guid, a+1)
			chosed[raidi] = index
		end
	elseif msg == "Gointotem" and guid then
		if self.Options.GoTotemClient then
			if not self.Options.GoTotemAdmin then
				print("接收分配: <"..guid..">入場")
			end
			if guid == UnitName("player") then
				specWarninTT:Show()
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ex_mop_zyjc.mp3")--注意進場
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if (spellId == 117215 or spellId == 117218 or spellId == 117219 or spellId == 117222) and self:AntiSpam(2, 1) then--Shadowy Attacks
		timerShadowyAttackCD:Start()
	elseif spellId == 116964 and self:AntiSpam(2, 2) then--Summon Totem
		if self:LatencyCheck() then
			self:SendSync("SummonTotem")
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self:GetUnitCreatureId(uId) == 60143 then
		local h = UnitHealth(uId) / UnitHealthMax(uId) * 100
		if h > 30 and prewarnedPhase2 then
			prewarnedPhase2 = false
		elseif h > 21 and h < 23 and not prewarnedPhase2 then
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\ptwo.mp3") --2階段準備
			prewarnedPhase2 = true
			warnPhase2Soon:Show()
		end
	end
end