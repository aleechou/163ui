local mod	= DBM:NewMod(157, "DBM-BastionTwilight", nil, 72)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 7780 $"):sub(12, -3))
mod:SetCreatureID(45992, 45993)
mod:SetModelID(34812)
mod:SetZone()
mod:SetUsedIcons(6, 7, 8)
mod:SetModelSound("Sound\\Creature\\Chogall\\VO_BT_Chogall_BotEvent10.wav", "Sound\\Creature\\Valiona\\VO_BT_Valiona_Event06.wav")
--Long: Valiona, Theralion put them in their place!
--Short: Enter twilight!

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REFRESH",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"SPELL_DAMAGE",
	"SPELL_MISSED",
	"SPELL_HEAL",
	"SPELL_PERIODIC_HEAL",
	"RAID_BOSS_EMOTE",
	"UNIT_AURA",
	"UNIT_SPELLCAST_SUCCEEDED"
)

--Valiona Ground Phase
local warnBlackout					= mod:NewTargetAnnounce(86788, 3)
local warnDevouringFlames			= mod:NewSpellAnnounce(86840, 3)
local warnDazzlingDestruction		= mod:NewCountAnnounce(86408, 4)--Used by Theralion just before landing
--Theralion Ground Phase
local warnFabFlames					= mod:NewTargetAnnounce(86505, 3)
local warnEngulfingMagic			= mod:NewTargetAnnounce(86622, 3)
local warnDeepBreath				= mod:NewCountAnnounce(86059, 4)--Used by Valiona just before landing

local warnTwilightShift				= mod:NewStackAnnounce(93051, 2)

--Valiona Ground Phase
local specWarnDevouringFlames		= mod:NewSpecialWarningSpell(86840, nil, nil, nil, true)
local specWarnDazzlingDestruction	= mod:NewSpecialWarningSpell(86408, nil, nil, nil, true)
local specWarnBlackout				= mod:NewSpecialWarningYou(86788)
mod:AddBoolOption("TBwarnWhileBlackout", false, "announce")
local specWarnTwilightBlast			= mod:NewSpecialWarningMove(86369)
local specWarnTwilightBlastNear		= mod:NewSpecialWarningClose(86369)
local yellTwilightBlast				= mod:NewYell(86369)
--Theralion Ground Phase
local specWarnDeepBreath			= mod:NewSpecialWarningSpell(86059, nil, nil, nil, true)
local specWarnFabulousFlames		= mod:NewSpecialWarningMove(86505)
local specWarnFabulousFlamesNear	= mod:NewSpecialWarningClose(86505)
local yellFabFlames					= mod:NewYell(86505)
local specWarnTwilightMeteorite		= mod:NewSpecialWarningYou(88518)
local yellTwilightMeteorite			= mod:NewYell(88518)
local specWarnEngulfingMagic		= mod:NewSpecialWarningYou(86622)
local yellEngulfingMagic			= mod:NewYell(86622)

local specWarnTwilightZone			= mod:NewSpecialWarningStack(86214, nil, 20)

--Valiona Ground Phase
local timerBlackout					= mod:NewTargetTimer(15, 86788)
local timerBlackoutCD				= mod:NewCDTimer(45.5, 86788)
local timerDevouringFlamesCD		= mod:NewCDTimer(40, 86840)
local timerNextDazzlingDestruction	= mod:NewNextTimer(132, 86408)
--Theralion Ground Phase
local timerTwilightMeteorite		= mod:NewCastTimer(6, 86013)		
local timerEngulfingMagic			= mod:NewBuffFadesTimer(20, 86622)
local timerEngulfingMagicNext		= mod:NewCDTimer(35, 86622)--30-40 second variations.
local timerNextFabFlames			= mod:NewNextTimer(15, 86505)
local timerNextDeepBreath			= mod:NewNextTimer(98, 86059)

local timerTwilightShift			= mod:NewTargetTimer(100, 93051)
local timerTwilightShiftCD			= mod:NewCDTimer(20, 93051)

local berserkTimer					= mod:NewBerserkTimer(600)

local sndWOP	= mod:NewSound(nil, "SoundWOP", true)
--local soundEngulfingMagic			= mod:NewSound(86622)

mod:AddBoolOption("TwilightBlastArrow", false)
mod:AddBoolOption("BlackoutIcon")
mod:AddBoolOption("EngulfingIcon")
mod:AddBoolOption("RangeFrame")
mod:RemoveOption("HealthFrame")
mod:AddBoolOption("BlackoutShieldFrame", true, "misc")

local engulfingMagicTargets = {}
local engulfingMagicIcon = 7
local dazzlingCast = 0
local breathCast = 0
local lastFab = 0
local markWarned = false
local blackoutActive = false
local ValionaLanded = false
local meteorTarget = GetSpellInfo(88518)
local fabFlames = GetSpellInfo(86497)

local setBlackoutTarget, clearBlackoutTarget
do
	local BlackoutTarget
	local healed = 0
	local maxAbsorb = 0
	local function getShieldHP()
		return math.max(1, math.floor(healed / maxAbsorb * 100))
	end
	
	function mod:SPELL_HEAL(sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, amount, overheal, absorbed)
		if destGUID == BlackoutTarget then
			healed = healed + (absorbed or 0)
		end
	end	
	mod.SPELL_PERIODIC_HEAL = mod.SPELL_HEAL
	
	function setBlackoutTarget(mod, target, name)--86788, 92876, 92877, 92878
		BlackoutTarget = target
		healed = 0
		maxAbsorb = mod:IsDifficulty("heroic25") and 75000 or
					mod:IsDifficulty("heroic10") and 40000 or
					mod:IsDifficulty("normal25") and 50000 or
					mod:IsDifficulty("normal10") and 50000 or 0
		DBM.BossHealth:RemoveBoss(getShieldHP)
		DBM.BossHealth:AddBoss(getShieldHP, L.BlackoutTarget:format(name))
	end
	
	function clearBlackoutTarget(self, name)
		DBM.BossHealth:RemoveBoss(getShieldHP)
	end
end

local function showEngulfingMagicWarning()
	warnEngulfingMagic:Show(table.concat(engulfingMagicTargets, "<, >"))
	timerEngulfingMagic:Start()
	table.wipe(engulfingMagicTargets)
	engulfingMagicIcon = 7
end

local function markRemoved()
	markWarned = false
end

local function valionaDelay()
	timerEngulfingMagicNext:Cancel()
	timerBlackoutCD:Start(10)
	timerDevouringFlamesCD:Start(25)
	sndWOP:Schedule(22, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\breathsoon.mp3")
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
end

local function theralionDelay()
	timerDevouringFlamesCD:Cancel()
	sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\breathsoon.mp3")
	timerBlackoutCD:Cancel()
	timerNextFabFlames:Start(10)
	timerEngulfingMagicNext:Start(15)
	timerNextDeepBreath:Start()
	sndWOP:Schedule(93, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\deepsoon.mp3")
	ValionaLanded = false
	if mod.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
end

local function AMSTimerDelay()
	timerTwilightShiftCD:Start()
end

function mod:FabFlamesTarget()
	local targetname, uId = self:GetBossTarget(45993)
	if not targetname then return end
	warnFabFlames:Show(targetname)
	if targetname == UnitName("player") then
		specWarnFabulousFlames:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		yellFabFlames:Yell()
		lastFab = GetTime()--Trigger the anti spam here so when we pre warn it thrown at them we don't double warn them again for taking 1 tick of it when it lands.
	else
		if uId then
			local x, y = GetPlayerMapPosition(uId)
			if x == 0 and y == 0 then
				SetMapToCurrentZone()
				x, y = GetPlayerMapPosition(uId)
			end
			local inRange = DBM.RangeCheck:GetDistance("player", x, y)
			if inRange and inRange < 11 then--What's exact radius of this circle?
				specWarnFabulousFlamesNear:Show(targetname)
				sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			end
		end
	end
end

function mod:TwilightBlastTarget()
	local targetname = self:GetBossTarget(45993)
	if not targetname then return end
	if self.Options.TBwarnWhileBlackout or not blackoutActive then
		if targetname == UnitName("player") then
			specWarnTwilightBlast:Show()
			sndWOP:Schedule(1, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
			yellTwilightBlast:Yell()
		else
			local uId = DBM:GetRaidUnitId(targetname)
			if uId then
				local x, y = GetPlayerMapPosition(uId)
				if x == 0 and y == 0 then
					SetMapToCurrentZone()
					x, y = GetPlayerMapPosition(uId)
				end
				local inRange = DBM.RangeCheck:GetDistance("player", x, y)
				if inRange and inRange < 9 then
					specWarnTwilightBlastNear:Show(targetname)
					if self.Options.TwilightBlastArrow then
						DBM.Arrow:ShowRunAway(x, y, 8, 5)
					end
				end
			end
		end
	end
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerBlackoutCD:Start(10-delay)
	timerDevouringFlamesCD:Start(25.5-delay)
	sndWOP:Schedule(22-delay, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\breathsoon.mp3")
	timerNextDazzlingDestruction:Start(85-delay)
	dazzlingCast = 0
	breathCast = 0
	lastFab = 0
	markWarned = false
	blackoutActive = false
	ValionaLanded = true
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self.Options.BlackoutShieldFrame then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(45992, 45993, L.name)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	DBM.BossHealth:Clear()
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		blackoutActive = true
		warnBlackout:Show(args.destName)
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\blackout.mp3")
		timerBlackout:Start(args.destName)
		timerBlackoutCD:Start()
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBlackout:Show()
		end
		setBlackoutTarget(self, args.destGUID, args.destName)
		self:Schedule(15, clearBlackoutTarget, self, args.destName)
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then
		engulfingMagicTargets[#engulfingMagicTargets + 1] = args.destName
		timerEngulfingMagicNext:Start()
		if args:IsPlayer() then
			specWarnEngulfingMagic:Show()
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runout.mp3")
--			soundEngulfingMagic:Play()
			yellEngulfingMagic:Yell()
		end
		if self.Options.EngulfingIcon then
			self:SetIcon(args.destName, engulfingMagicIcon)
			engulfingMagicIcon = engulfingMagicIcon - 1
		end
		self:Unschedule(showEngulfingMagicWarning)
		if (self:IsDifficulty("heroic25") and #engulfingMagicTargets >= 3) or (self:IsDifficulty("normal25", "heroic10") and #engulfingMagicTargets >= 2) or (self:IsDifficulty("normal10") and #engulfingMagicTargets >= 1) then
			showEngulfingMagicWarning()
		else
			self:Schedule(0.3, showEngulfingMagicWarning)
		end
	elseif args:IsSpellID(93051) then
		warnTwilightShift:Show(args.destName, args.amount or 1)
		timerTwilightShift:Cancel(args.destName.." (1)")
		timerTwilightShift:Cancel(args.destName.." (2)")
		timerTwilightShift:Cancel(args.destName.." (3)")
		timerTwilightShift:Cancel(args.destName.." (4)")
		timerTwilightShift:Cancel(args.destName.." (5)")
		timerTwilightShift:Show(args.destName.." ("..tostring(args.amount or 1)..")")
		timerTwilightShiftCD:Start()
		if args.amount == 4 then
			sndWOP:Schedule(14, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\telesoon.mp3")
			sndWOP:Schedule(15, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfive.mp3")
			sndWOP:Schedule(16, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countfour.mp3")
			sndWOP:Schedule(17, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
			sndWOP:Schedule(18, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
			sndWOP:Schedule(19, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		end
		self:Unschedule(AMSTimerDelay)
		self:Schedule(20, AMSTimerDelay)--Cause when a DK AMSes it we don't get another timer.
	elseif args:IsSpellID(92886, 92887) and args:IsPlayer() then
		if (args.amount or 1) >= 20 and self:AntiSpam(5, 1) then
			specWarnTwilightZone:Show(args.amount)
			sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\debuffhigh.mp3")
		end
	end
end

mod.SPELL_AURA_REFRESH = mod.SPELL_AURA_APPLIED

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(86788, 92876, 92877, 92878) then
		timerBlackout:Cancel(args.destName)
		if self.Options.BlackoutIcon then
			self:SetIcon(args.destName, 0)
		end
		blackoutActive = false
		self:Unschedule(clearBlackoutTarget)
		clearBlackoutTarget(self, args.destName)
	elseif args:IsSpellID(86622, 95639, 95640, 95641) then
		if self.Options.EngulfingIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args:IsSpellID(93051) then
		timerTwilightShift:Cancel(args.destName.." (1)")
		timerTwilightShift:Cancel(args.destName.." (2)")
		timerTwilightShift:Cancel(args.destName.." (3)")
		timerTwilightShift:Cancel(args.destName.." (4)")
		timerTwilightShift:Cancel(args.destName.." (5)")
	end
end	

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(86840, 90950) then--Strange to have 2 cast ids instead of either 1 or 4
		warnDevouringFlames:Show()
		timerDevouringFlamesCD:Start()
		specWarnDevouringFlames:Show()
		sndWOP:Schedule(38, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\breathsoon.mp3")
	elseif args:IsSpellID(86408) then
		dazzlingCast = dazzlingCast + 1
		warnDazzlingDestruction:Show(dazzlingCast)
		if dazzlingCast == 1 then
			specWarnDazzlingDestruction:Show()
		elseif dazzlingCast == 3 then
			self:Schedule(5, theralionDelay)--delayed so we don't cancel blackout timer until after 3rd cast.
			dazzlingCast = 0
		end
	elseif args:IsSpellID(86369, 92898, 92899, 92900) then--First cast of this is true phase change, as theralion can still cast his grounded phase abilities until he's fully in air casting this instead.
		self:ScheduleMethod(0.1, "TwilightBlastTarget")
		if not ValionaLanded then
			timerNextFabFlames:Cancel()
			ValionaLanded = true
		end
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if (spellId == 86505 or spellId == 92907 or spellId == 92908 or spellId == 92909) and destGUID == UnitGUID("player") and GetTime() - lastFab > 3 then
		specWarnFabulousFlames:Show()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runaway.mp3")
		lastFab = GetTime()
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE--Absorbs still show as spell missed, such as PWS, but with this you'll still get a special warning to GTFO, instead of dbm waiting til your shield breaks and you take a second tick :)

function mod:RAID_BOSS_EMOTE(msg)
	if msg == L.Trigger1 or msg:find(L.Trigger1) then
		breathCast = breathCast + 1
		warnDeepBreath:Show(breathCast)
		if breathCast == 1 then
			timerNextDeepBreath:Cancel()
			sndWOP:Cancel("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\deepsoon.mp3")
			specWarnDeepBreath:Show()
			timerNextDazzlingDestruction:Start()
			self:Schedule(40, valionaDelay)--We do this cause you get at least one more engulfing magic after this emote before they completely switch so we need a method to cancel bar more appropriately
		elseif breathCast == 3 then
			breathCast = 0
		end
	end
end

function mod:UNIT_AURA(uId)
	if uId ~= "player" then return end
	if UnitDebuff("player", meteorTarget) and not markWarned then
		specWarnTwilightMeteorite:Show()
		timerTwilightMeteorite:Start()
		sndWOP:Play("Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\runin.mp3")
		sndWOP:Schedule(4, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countthree.mp3")
		sndWOP:Schedule(5, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\counttwo.mp3")
		sndWOP:Schedule(6, "Interface\\AddOns\\DBM-Core\\extrasounds\\"..DBM.Options.CountdownVoice.."\\countone.mp3")
		yellTwilightMeteorite:Yell()
		markWarned = true
		self:Schedule(7, markRemoved)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == fabFlames and not ValionaLanded and self:AntiSpam(2, 2) then
		self:ScheduleMethod(0.1, "FabFlamesTarget")--Might need a timing tweak but should work.
		timerNextFabFlames:Start()
		lastFab = GetTime()
	end
end
