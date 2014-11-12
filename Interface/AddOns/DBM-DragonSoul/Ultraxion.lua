local mod	= DBM:NewMod(331, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(55294)
mod:SetModelSound("sound\\CREATURE\\ULTRAXION\\VO_DS_ULTRAXION_INTRO_01.OGG", "sound\\CREATURE\\ULTRAXION\\VO_DS_ULTRAXION_AGGRO_01")
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

local warnHourofTwilightSoon		= mod:NewPreWarnAnnounce(106371, 15, 4)
local warnHourofTwilight			= mod:NewCountAnnounce(106371, 4)
local warnFadingLight				= mod:NewTargetCountAnnounce(109075, 3)

local specWarnHourofTwilight		= mod:NewSpecialWarningSpell(106371, nil, nil, nil, true)
local specWarnHourofTwilightN		= mod:NewSpecialWarning("specWarnHourofTwilightN", nil, false)
local specWarnFadingLight			= mod:NewSpecialWarningYou(109075)
local specWarnFadingLightOther		= mod:NewSpecialWarningTarget(109075, mod:IsTank())
local specWarnTwilightEruption		= mod:NewSpecialWarningSpell(106388, nil, nil, nil, true)

local timerCombatStart				= mod:NewTimer(35, "TimerCombatStart", 2457)
local timerHourofTwilightCD			= mod:NewNextCountTimer(45.5, 106371)
local timerTwilightEruption			= mod:NewCastTimer(5, 106388)
local timerFadingLight				= mod:NewBuffFadesTimer(10, 109075)
local timerFadingLightCD			= mod:NewNextTimer(10, 109075)
local timerGiftofLight				= mod:NewNextTimer(80, 105896, nil, mod:IsHealer())
local timerEssenceofDreams			= mod:NewNextTimer(155, 105900, nil, mod:IsHealer())
local timerSourceofMagic			= mod:NewNextTimer(215, 105903, nil, mod:IsHealer())

local berserkTimer					= mod:NewBerserkTimer(360)

mod:AddBoolOption("holditHoT1", false)
mod:AddBoolOption("holditHoT2", false)
mod:AddBoolOption("holditHoT3", false)
mod:AddBoolOption("holditHoT4", false)
mod:AddBoolOption("holditHoT5", false)
mod:AddBoolOption("holditHoT6", false)
mod:AddBoolOption("holditHoT7", false)
mod:AddDropdownOption("SpecWarnHoTN", {"Never", "One", "Two", "Three"}, "Never", "announce")

local hourOfTwilightCount = 0
local fadingLightCount = 0
local fadingLightTargets = {}
local lightme = false
local redbuff = GetSpellInfo(105896)
local greenbuff = GetSpellInfo(105900)
local bluebuff = GetSpellInfo(105903)

local function warnFadingLightTargets()
	warnFadingLight:Show(fadingLightCount, table.concat(fadingLightTargets, "<, >"))
	if not lightme then
		if mod:IsTank() or mod:IsHealer() then
			sndWOP:Play("changemt")
		end
	end
	table.wipe(fadingLightTargets)
end

function mod:OnCombatStart(delay)
	table.wipe(fadingLightTargets)
	hourOfTwilightCount = 0
	fadingLightCount = 0
	warnHourofTwilightSoon:Schedule(30.5)
	if self.Options.SpecWarnHoTN == "One" then
		specWarnHourofTwilightN:Schedule(40.5, GetSpellInfo(106371), hourOfTwilightCount+1)
	end
	lightme = false
	timerGiftofLight:Start(-delay)
	timerEssenceofDreams:Start(-delay)
	timerSourceofMagic:Start(-delay)
	timerHourofTwilightCD:Start(-delay, 1)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(106371) then
		fadingLightCount = 0
		hourOfTwilightCount = hourOfTwilightCount + 1
		warnHourofTwilight:Show(hourOfTwilightCount)
		specWarnHourofTwilight:Show()
		if self.Options.SpecWarnHoTN == "One" and hourOfTwilightCount == 0
		or self.Options.SpecWarnHoTN == "Two" and hourOfTwilightCount == 1
		or self.Options.SpecWarnHoTN == "Three" and hourOfTwilightCount == 2 then
			specWarnHourofTwilightN:Schedule(40.5, args.spellName, hourOfTwilightCount+1)
		end
		warnHourofTwilightSoon:Schedule(30.5)
		if hourOfTwilightCount == 1 and self.Options.holditHoT1 then
			sndWOP:Play("holdit")
		elseif hourOfTwilightCount == 2 and self.Options.holditHoT2 then
			sndWOP:Play("holdit")
		elseif hourOfTwilightCount == 3 and self.Options.holditHoT3 then
			sndWOP:Play("holdit")
		elseif hourOfTwilightCount == 4 and self.Options.holditHoT4 then
			sndWOP:Play("holdit")
		elseif hourOfTwilightCount == 5 and self.Options.holditHoT5 then
			sndWOP:Play("holdit")
		elseif hourOfTwilightCount == 6 and self.Options.holditHoT6 then
			sndWOP:Play("holdit")
		elseif hourOfTwilightCount == 7 and self.Options.holditHoT7 then
			sndWOP:Play("holdit")
		else		
			sndWOP:Play("twilighttime")
		end
		timerHourofTwilightCD:Start(45.5, hourOfTwilightCount+1)
		if self:IsDifficulty("heroic10", "heroic25") then
			timerFadingLightCD:Start(13)
			sndWOP:Schedule(1, "countthree")
			sndWOP:Schedule(2, "counttwo")
			sndWOP:Schedule(3, "countone")
		else
			timerFadingLightCD:Start(20)
			sndWOP:Schedule(2.5, "countthree")
			sndWOP:Schedule(3.5, "counttwo")
			sndWOP:Schedule(4.5, "countone")
		end
	elseif args:IsSpellID(106388) then
		specWarnTwilightEruption:Show()
		timerTwilightEruption:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(105925) then
		fadingLightCount = fadingLightCount + 1
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if self:IsDifficulty("heroic10", "heroic25") and fadingLightCount < 3 then
			timerFadingLightCD:Start()
		elseif self:IsDifficulty("normal10", "normal25", "lfr25") and fadingLightCount < 2 then
			timerFadingLightCD:Start(15)
		end
		if (args:IsPlayer() or UnitDebuff("player", GetSpellInfo(105925))) and self:AntiSpam(2) then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			specWarnFadingLight:Show()
			sndWOP:Schedule(duration - 5, "clickbravo")
			sndWOP:Schedule(duration - 3, "countthree")
			sndWOP:Schedule(duration - 2, "counttwo")
			sndWOP:Schedule(duration - 1, "countone")
			timerFadingLight:Start(duration)
			lightme = true
		else
			lightme = false
		end
		self:Unschedule(warnFadingLightTargets)
		if self:IsDifficulty("lfr25") or self:IsDifficulty("heroic25") and #fadingLightTargets >= 7 or self:IsDifficulty("normal25") and #fadingLightTargets >= 4 or self:IsDifficulty("heroic10") and #fadingLightTargets >= 3 or self:IsDifficulty("normal10") and #fadingLightTargets >= 2 then
			warnFadingLightTargets()
		else
			self:Schedule(0.5, warnFadingLightTargets)
		end		
	elseif args:IsSpellID(109075) then
		fadingLightTargets[#fadingLightTargets + 1] = args.destName
		if (args:IsPlayer() or UnitDebuff("player", GetSpellInfo(109075))) and self:AntiSpam(2) then
			local _, _, _, _, _, duration, expires, _, _ = UnitDebuff("player", args.spellName)
			specWarnFadingLight:Show()
			sndWOP:Schedule(duration - 5, "clickbravo")
			sndWOP:Schedule(duration - 3, "countthree")
			sndWOP:Schedule(duration - 2, "counttwo")
			sndWOP:Schedule(duration - 1, "countone")
			timerFadingLight:Start(duration)
			lightme = true
		else
			lightme = false
		end
		self:Unschedule(warnFadingLightTargets)
		if self:IsDifficulty("heroic25") and #fadingLightTargets >= 7 or self:IsDifficulty("normal25") and #fadingLightTargets >= 4 or self:IsDifficulty("heroic10") and #fadingLightTargets >= 3 or self:IsDifficulty("normal10") and #fadingLightTargets >= 2 then
			warnFadingLightTargets()
		else
			self:Schedule(0.5, warnFadingLightTargets)
		end	
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find(redbuff) then
		sndWOP:Play("redessence")
	elseif msg:find(greenbuff) then
		sndWOP:Play("greenessence")
	elseif msg:find(bluebuff) then
		sndWOP:Play("blueessence")
	end
end

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	end
end
