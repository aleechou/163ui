local mod	= DBM:NewMod(331, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 115 $"):sub(12, -3))
mod:SetCreatureID(55294)
mod:SetEncounterID(1297)
mod:SetZone()
mod:SetModelSound("sound\\CREATURE\\ULTRAXION\\VO_DS_ULTRAXION_INTRO_01.OGG", "sound\\CREATURE\\ULTRAXION\\VO_DS_ULTRAXION_AGGRO_01.OGG")

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 106371 106388",
	"SPELL_AURA_APPLIED 105925 109075 106498"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

local warnHourofTwilightSoon		= mod:NewPreWarnAnnounce(106371, 15, 4)--Why 15? because this warning signals the best time to pop 1min CDs a second time. (ie lets say you a tank in HoT1 group, you SW, your SW will be usuable one more time before next HoT1, but when do you use it? 15 seconds before the 3rd HoT exactly, then it's stil up for 3rd HoT and still back off cd for HoT1)
local warnHourofTwilight			= mod:NewCountAnnounce(106371, 4)
local warnFadingLight				= mod:NewTargetCountAnnounce(109075, 3)

local specWarnHourofTwilight		= mod:NewSpecialWarningSpell(106371, nil, nil, nil, true)
local specWarnHourofTwilightN		= mod:NewSpecialWarning("specWarnHourofTwilightN", nil, false)
local specWarnFadingLight			= mod:NewSpecialWarningYou(109075)
local specWarnFadingLightOther		= mod:NewSpecialWarningTarget(109075, mod:IsTank())
local specWarnTwilightEruption		= mod:NewSpecialWarningSpell(106388, nil, nil, nil, true)

local timerCombatStart				= mod:NewTimer(35, "TimerCombatStart", 2457)
local timerUnstableMonstrosity		= mod:NewNextTimer(60, 106372, nil, mod:IsHealer())
local timerHourofTwilight			= mod:NewCastTimer(5, 106371)
local timerHourofTwilightCD			= mod:NewNextCountTimer(45.5, 106371)
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
local timerFadingLight				= mod:NewBuffFadesTimer(10, 109075)
local timerFadingLightCD			= mod:NewNextTimer(10, 109075)
local timerGiftofLight				= mod:NewNextTimer(80, 105896, nil, mod:IsHealer())
local timerEssenceofDreams			= mod:NewNextTimer(155, 105900, nil, mod:IsHealer())
local timerSourceofMagic			= mod:NewNextTimer(215, 105903, nil, mod:IsHealer())
local timerLoomingDarkness			= mod:NewBuffFadesTimer(120, 106498)
local timerRaidCDs					= mod:NewTimer(60, "timerRaidCDs", 2565, nil, false)

local berserkTimer					= mod:NewBerserkTimer(360)

local countdownFadingLight			= mod:NewCountdownFades(10, 109075)
local countdownHourofTwilight		= mod:NewCountdown("Alt45", 106371)

--Raid CDs will have following options: Don't show Raid CDs, Show only My Raid CDs, Show all raid CDs

mod:AddDropdownOption("ResetHoTCounter", {"Never", "ResetDynamic", "Reset3Always"}, "Reset3Always", "announce")
--ResetDynamic = 3s on heroic and 2s on normal.
--Reset3Always = 3s on both heroic and normal.
mod:AddDropdownOption("SpecWarnHoTN", {"Never", "One", "Two", "Three"}, "Never", "announce")
--If ResetDynamic, SpecWarnHoTN will work for 1-2, if set to 3 on normal it'll just be ignored.
--If ResetHoTCounter is Never, SpecWarnHoTN will work in 3 counts still ie 1 4 7, 2 5, 3 6

local hourOfTwilightCount = 0
local fadingLightCount = 0
local fadingLightTargets = {}

local function warnFadingLightTargets()
	warnFadingLight:Show(fadingLightCount, table.concat(fadingLightTargets, "<, >"))
	table.wipe(fadingLightTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(fadingLightTargets)
	hourOfTwilightCount = 0
	fadingLightCount = 0
	warnHourofTwilightSoon:Schedule(30.5)
	if self.Options.SpecWarnHoTN == "One" then--Don't filter here, this is supposed to work for everyone. IF they don't want special warning they set SpecWarnHoTN to Never (it's default)
		specWarnHourofTwilightN:Schedule(40.5, GetSpellInfo(106371), hourOfTwilightCount+1)
	end
	timerHourofTwilightCD:Start(45.5-delay, 1)
	countdownHourofTwilight:Start(45.5)
	timerGiftofLight:Start(-delay)
	timerEssenceofDreams:Start(-delay)
	timerSourceofMagic:Start(-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 106371 then
		fadingLightCount = 0
		hourOfTwilightCount = hourOfTwilightCount + 1
		warnHourofTwilight:Show(hourOfTwilightCount)
		specWarnHourofTwilight:Show()
		--Reset Mechanic begin
		if self:IsDifficulty("heroic10", "heroic25") and (self.Options.ResetHoTCounter == "ResetDynamic" or self.Options.ResetHoTCounter == "Reset3Always") and hourOfTwilightCount == 3
		or self.Options.ResetHoTCounter == "ResetDynamic" and self:IsDifficulty("normal10", "normal25", "lfr25") and hourOfTwilightCount == 2 then
			hourOfTwilightCount = 0
		end
		-- If reset is set to never, then we still schedule special warnings for 4-7 on a 3 set rule
		if self.Options.SpecWarnHoTN == "One" and (hourOfTwilightCount == 0 or hourOfTwilightCount == 3 or hourOfTwilightCount == 6)--All use this..
		or self.Options.SpecWarnHoTN == "Two" and (hourOfTwilightCount == 1 or hourOfTwilightCount == 4)--All use this
		or self.Options.SpecWarnHoTN == "Three" and (hourOfTwilightCount == 2 or hourOfTwilightCount == 5) then--ResetDynamic doesn't use this on normal, however, no reason to filter it here as hourOfTwilightCount was already reset before this ran. Never also uses this safely.
			specWarnHourofTwilightN:Schedule(40.5, args.spellName, hourOfTwilightCount+1)
		end
		warnHourofTwilightSoon:Schedule(30.5)
		timerHourofTwilightCD:Start(45.5, hourOfTwilightCount+1)
		countdownHourofTwilight:Start(45.5)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFadingLightCD:Start(13)
			timerHourofTwilight:Start(3)
		else
			timerFadingLightCD:Start(20)
			timerHourofTwilight:Start()
		end
	elseif spellId == 106388 then
		specWarnTwilightEruption:Show()
		timerTwilightEruption:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 105925 then--Tank Only SpellID
		fadingLightCount = fadingLightCount + 1
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if self:IsDifficulty("heroic10", "heroic25") and fadingLightCount < 3 then
			timerFadingLightCD:Start()
		elseif self:IsDifficulty("normal10", "normal25", "lfr25") and fadingLightCount < 2 then
			timerFadingLightCD:Start(15)
		end
		if (args:IsPlayer() or UnitDebuff("player", GetSpellInfo(105925))) and self:AntiSpam(2) then--Sometimes the combatlog doesn't report all fading lights, so we perform an additional aura check 
			local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)--Find out what our specific fading light is
			specWarnFadingLight:Show()
			countdownFadingLight:Start(duration-1)--For some reason need to offset it by 1 second to make it accurate but otherwise it's perfect
			timerFadingLight:Start(duration-1)
		else
			specWarnFadingLightOther:Show(args.destName)
		end
		self:Unschedule(warnFadingLightTargets)
		if self:IsDifficulty("lfr25") or self:IsDifficulty("heroic25") and #fadingLightTargets >= 7 or self:IsDifficulty("normal25") and #fadingLightTargets >= 4 or self:IsDifficulty("heroic10") and #fadingLightTargets >= 3 or self:IsDifficulty("normal10") and #fadingLightTargets >= 2 then
			warnFadingLightTargets()
		else
			self:Schedule(0.5, warnFadingLightTargets)
		end
	elseif spellId == 109075 then--Non Tank ID
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if (args:IsPlayer() or UnitDebuff("player", GetSpellInfo(109075))) and self:AntiSpam(2) then
			local _, _, _, _, _, duration, expires = UnitDebuff("player", args.spellName)
			specWarnFadingLight:Show()
			countdownFadingLight:Start(duration-1)
			timerFadingLight:Start(duration-1)
		end
		self:Unschedule(warnFadingLightTargets)
		if self:IsDifficulty("heroic25") and #fadingLightTargets >= 7 or self:IsDifficulty("normal25") and #fadingLightTargets >= 4 or self:IsDifficulty("heroic10") and #fadingLightTargets >= 3 or self:IsDifficulty("normal10") and #fadingLightTargets >= 2 then
			warnFadingLightTargets()
		else
			self:Schedule(0.5, warnFadingLightTargets)
		end
	elseif spellId == 106498 and args:IsPlayer() then
		timerLoomingDarkness:Start()
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	end
end
