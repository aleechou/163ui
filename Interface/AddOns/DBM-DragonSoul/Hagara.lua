local mod	= DBM:NewMod(317, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(55689)
mod:SetModelSound("sound\\CREATURE\\HAGARA\\VO_DS_HAGARA_INTRO_01.OGG", "sound\\CREATURE\\HAGARA\\VO_DS_HAGARA_CRYSTALDEAD_05.OGG")
mod:SetZone()
mod:SetUsedIcons(3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnAssault			= mod:NewCountAnnounce(107851, 4, nil, mod:IsHealer() or mod:IsTank())
local warnShatteringIce		= mod:NewTargetAnnounce(105289, 3, nil, false)
local warnIceLance			= mod:NewTargetAnnounce(105297, 3)
local warnFrostTombCast		= mod:NewAnnounce("warnFrostTombCast", 4, 104448)
local warnFrostTomb			= mod:NewTargetAnnounce(104451, 4)
local warnTempest			= mod:NewCastAnnounce(105256, 4)
local warnLightningStorm	= mod:NewSpellAnnounce(105465, 4)
local warnFrostflake		= mod:NewTargetAnnounce(109325, 3)
local warnStormPillars		= mod:NewSpellAnnounce(109557, 3)
local warnPillars			= mod:NewAnnounce("WarnPillars", 2, 105311)

local specWarnAssault		= mod:NewSpecialWarningSpell(107851, mod:IsTank())
local specWarnShattering	= mod:NewSpecialWarningYou(105289, false)
local specWarnFrostTombCast	= mod:NewSpecialWarningSpell(104451, nil, nil, nil, true)
local specWarnTempest		= mod:NewSpecialWarning("specWarnFrozenPhase")
local specWarnLightingStorm	= mod:NewSpecialWarning("specWarnLightningPhase")
local specWarnWatery		= mod:NewSpecialWarningYou(110317)
local specWarnFrostflake		= mod:NewSpecialWarningYou(109325)
local specWarnIceLance		= mod:NewSpecialWarningStack(105316, nil, 3)
local yellFrostflake					= mod:NewYell(109325)

local timerAssaultCD		= mod:NewCDCountTimer(15, 107851, nil, mod:IsTank() or mod:IsHealer())
local timerShatteringCD  = mod:NewCDTimer(10, 105289, nil, mod:IsHealer())
local timerIceLance			= mod:NewBuffActiveTimer(15, 105269)
local timerIceLanceCD		= mod:NewNextTimer(30, 105269)
local timerFrostTomb		= mod:NewCastTimer(8, 104448)
local timerFrostTombCD		= mod:NewNextTimer(20, 104451)
local timerSpecialCD		= mod:NewTimer(30, "TimerSpecial", "Interface\\Icons\\Spell_Nature_WispSplode")
local timerTempestCD		= mod:NewNextTimer(62, 105256)
local timerLightningStormCD	= mod:NewNextTimer(62, 105465)
local timerFeedback			= mod:NewBuffActiveTimer(15, 108934)

local berserkTimer				= mod:NewBerserkTimer(480)

mod:AddBoolOption("RangeFrame")
mod:AddBoolOption("SetIconOnFrostflake", true)
mod:AddBoolOption("DispelYell", true)
mod:AddBoolOption("SetIconOnFrostTomb", true)
mod:AddBoolOption("SetIconOnLance", true)
mod:AddBoolOption("SetIconOnShatteringIce", true)
mod:AddBoolOption("AnnounceFrostTombIcons", false)
mod:AddBoolOption("SetBubbles", true)--because chat bubble hides Ice Tomb target indication if bubbles are on.

local lanceTargets = {}
local tombTargets = {}
local tombIconTargets = {}
local firstPhase = true
local iceFired = false
local assaultCount = 0
local pillarsRemaining = 4
local frostPillar = EJ_GetSectionInfo(4069)
local lightningPillar = EJ_GetSectionInfo(3919)
local lanceIcon = 6
local frostflakeIcon = 8
local dispelIcon = 1
local igotlance = false
local CVAR = false
local CVAR2 = false

function mod:ShatteredIceTarget()
	local targetname = self:GetBossTarget(55689)
	if not targetname then return end
	warnShatteringIce:Show(targetname)
	if UnitName("player") == targetname then
		specWarnShattering:Show()
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerShatteringCD:Start(15)
		if self:IsHealer() then
			sndWOP:Schedule(12, "shattericesoon")
		end
	else
		timerShatteringCD:Start()
	end
	if self.Options.SetIconOnShatteringIce then
		self:SetIcon(targetname, 8, 4)
	end
end

function mod:OnCombatStart(delay)
	table.wipe(lanceTargets)
	table.wipe(tombIconTargets)
	table.wipe(tombTargets)
	firstPhase = true
	iceFired = false
	assaultCount = 0
	lanceIcon = 6
	frostflakeIcon = 8
	dispelIcon = 1
	igotlance = false
	timerAssaultCD:Start(4-delay, 1)
	timerIceLanceCD:Start(12-delay)
	timerSpecialCD:Start(30-delay)
	berserkTimer:Start(-delay)
end

function mod:OnCombatEnd()
	if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
		SetCVar("chatBubbles", 1)
		CVAR = false
	end
	if self.Options.SetBubbles and not GetCVarBool("chatBubblesParty") and CVAR2 then--Only turn them back on if they are off now, but were on when we pulled
		SetCVar("chatBubblesParty", 1)
		CVAR2 = false
	end
	if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
		DBM.RangeCheck:Hide()
	end
end

local function warnLanceTargets()
	warnIceLance:Show(table.concat(lanceTargets, "<, >"))
	timerIceLance:Start()
	if not firstPhase and not iceFired then
		timerIceLanceCD:Start()
	end
	iceFired = true
	table.wipe(lanceTargets)
	lanceIcon = 6
end

local function ClearTombTargets()
	table.wipe(tombIconTargets)
end

local function ClearLanceOnMe()
	igotlance = false
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetTombIcons()
		table.sort(tombIconTargets, sort_by_group)
		local tombIcons = 1
		for i, v in ipairs(tombIconTargets) do
			if self.Options.AnnounceFrostTombIcons and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.TombIconSet:format(tombIcons, DBM:GetUnitFullName(v)), "RAID")
			end
			self:SetIcon(v, tombIcons)
			tombIcons = tombIcons + 1
		end
		self:Schedule(8, ClearTombTargets)
	end
end

local function warnTombTargets()
	warnFrostTomb:Show(table.concat(tombTargets, "<, >"))
	specWarnFrostTombCast:Show()
	if not mod:IsHealer() then
		sndWOP:Play("killicetomb")
	end
	table.wipe(tombTargets)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(105297) then
		lanceTargets[#lanceTargets + 1] = args.sourceName
		if args.sourceName == UnitName("player") then
			igotlance = true
			self:Schedule(20, ClearLanceOnMe)
		end
		if self.Options.SetIconOnLance then
			self:SetIcon(args.sourceName, lanceIcon, 18)
			lanceIcon = lanceIcon - 1
			if lanceIcon == 0 then
				lanceIcon = 6
			end
		end		
		self:Unschedule(warnLanceTargets)
		if (self:IsDifficulty("normal10", "heroic10", "lfr25") and #lanceTargets >= 3) then
			warnLanceTargets()
		else
			self:Schedule(0.5, warnLanceTargets)
		end
	elseif args:IsSpellID(109557, 109541) then
		warnStormPillars:Show()
		sndWOP:Play("stormpillar")
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104451) then
		tombTargets[#tombTargets + 1] = args.destName
		if self.Options.SetIconOnFrostTomb then
			table.insert(tombIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetTombIcons")
			if (self:IsDifficulty("normal25") and #tombIconTargets >= 5) or (self:IsDifficulty("heroic25") and #tombIconTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombIconTargets >= 2) then
				self:SetTombIcons()
			else
				if self:LatencyCheck() then
					self:ScheduleMethod(0.3, "SetTombIcons")
				end
			end
		end
		self:Unschedule(warnTombTargets)
		if (self:IsDifficulty("normal25") and #tombTargets >= 5) or (self:IsDifficulty("heroic25") and #tombTargets >= 6) or (self:IsDifficulty("normal10", "heroic10") and #tombTargets >= 2) then
			warnTombTargets()
		else
			self:Schedule(0.3, warnTombTargets)
		end
	elseif args:IsSpellID(107851) then
		assaultCount = assaultCount + 1
		warnAssault:Show(assaultCount)
		specWarnAssault:Show()
		sndWOP:Play("focusattack")
		if (firstPhase and assaultCount < 2) or (not firstPhase and assaultCount < 3) then
			timerAssaultCD:Start(nil, assaultCount+1)
		end
		if self:IsTank() or self:IsHealer() then
			sndWOP:Schedule(12, "countthree")
			sndWOP:Schedule(13, "counttwo")
			sndWOP:Schedule(14, "countone")
		end
	elseif args:IsSpellID(110317) then
		if args:IsPlayer() then
			specWarnWatery:Show()
			if UnitDebuff("player", GetSpellInfo(109325)) and self.Options.DispelYell then
				SendChatMessage(L.YellDispel, "YELL")
			end
		end
		if UnitDebuff(args.destName, GetSpellInfo(109325)) then
			if self:IsHealer() then
				sndWOP:Play("dispelnow")
			end
			if self.Options.SetIconOnFrostflake then
				self:SetIcon(args.destName, dispelIcon)
				dispelIcon = dispelIcon + 1
				if dispelIcon == 4 then
					dispelIcon = 1
				end
			end
		end
	elseif args:IsSpellID(109325) then
		warnFrostflake:Show(args.destName)
		if self.Options.SetIconOnFrostflake then
			self:SetIcon(args.destName, frostflakeIcon)
			frostflakeIcon = frostflakeIcon - 1
			if frostflakeIcon == 5 then
				frostflakeIcon = 8
			end				
		end
		if args:IsPlayer() then
			specWarnFrostflake:Show()
			sndWOP:Play("frostflake")
			yellFrostflake:Yell()
		end
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args:IsSpellID(105316) and args:IsPlayer() and self:IsDifficulty("heroic10", "heroic25") then
		if (args.amount or 0) == 3 or (args.amount or 0) == 5 or (args.amount or 0) == 7 or (args.amount or 0) == 9 then
			specWarnIceLance:Show(args.amount or 1)
			if not igotlance then
				sndWOP:Play("awayline")
			else
				SendChatMessage(L.YellIceLance, "SAY")
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(104451) and self.Options.SetIconOnFrostTomb then
		self:SetIcon(args.destName, 0)
	elseif args:IsSpellID(105256) then
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			SetCVar("chatBubbles", 0)
			CVAR = true
		end
		if self.Options.SetBubbles and GetCVarBool("chatBubblesParty") then
			SetCVar("chatBubblesParty", 0)
			CVAR2 = true
		end
		sndWOP:Play("shieldoff")
		timerIceLanceCD:Start(12)
		timerFeedback:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerShatteringCD:Start(20)
			if self:IsHealer() then
				sndWOP:Schedule(17, "shattericesoon")
			end
		else
			timerShatteringCD:Start(17)		
		end
		if not self:IsDifficulty("lfr25") then
			timerFrostTombCD:Start()
		end
		firstPhase = false
		iceFired = false
		assaultCount = 0
		timerAssaultCD:Start(nil, 1)
		if self:IsTank() or self:IsHealer() then
			sndWOP:Schedule(12, "countthree")
			sndWOP:Schedule(13, "counttwo")
			sndWOP:Schedule(14, "countone")
		end
		timerLightningStormCD:Start()
	elseif args:IsSpellID(105311) then--Frost defeated.
		pillarsRemaining = pillarsRemaining - 1
		warnPillars:Show(frostPillar, pillarsRemaining)
	elseif args:IsSpellID(105482) then--Lighting defeated.
		pillarsRemaining = pillarsRemaining - 1
		warnPillars:Show(lightningPillar, pillarsRemaining)
	elseif args:IsSpellID(105409) then
		if self.Options.SetBubbles and GetCVarBool("chatBubbles") then
			SetCVar("chatBubbles", 0)
			CVAR = true
		end
		if self.Options.SetBubbles and GetCVarBool("chatBubblesParty") then
			SetCVar("chatBubblesParty", 0)
			CVAR2 = true
		end
		sndWOP:Play("shieldoff")
		timerIceLanceCD:Start(12)
		timerFeedback:Start()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerShatteringCD:Start(20)
			if self:IsHealer() then
				sndWOP:Schedule(17, "shattericesoon")
			end
		else
			timerShatteringCD:Start(17)		
		end
		if not self:IsDifficulty("lfr25") then
			timerFrostTombCD:Start()
		end
		firstPhase = false
		iceFired = false
		assaultCount = 0
		timerAssaultCD:Start(nil, 1)
		if self:IsTank() or self:IsHealer() then
			sndWOP:Schedule(12, "countthree")
			sndWOP:Schedule(13, "counttwo")
			sndWOP:Schedule(14, "countone")
		end
		timerTempestCD:Start()
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Hide()
		end
	elseif args:IsSpellID(109325) then
		if self.Options.SetIconOnFrostflake then
			self:SetIcon(args.destName, 0)
		end
		if args:IsPlayer() then
			sndWOP:Play("safenow")
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args:IsSpellID(104448) then
		warnFrostTombCast:Show(args.spellName)
		sndWOP:Play("icetombsoon")
		timerFrostTomb:Start()
	elseif args:IsSpellID(105256) then
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
		if self.Options.SetBubbles and not GetCVarBool("chatBubblesParty") and CVAR2 then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubblesParty", 1)
			CVAR2 = false
		end
		pillarsRemaining = 4
		timerAssaultCD:Cancel()
		timerIceLanceCD:Cancel()
		timerShatteringCD:Cancel()
		if self:IsHealer() and self:IsDifficulty("heroic10", "heroic25") then
			sndWOP:Cancel("shattericesoon")
		end
		if self:IsTank() or self:IsHealer() then
			sndWOP:Cancel("countthree")
			sndWOP:Cancel("counttwo")
			sndWOP:Cancel("countone")
		end
		warnTempest:Show()
		specWarnTempest:Show()
	elseif args:IsSpellID(105409) then
		if self.Options.SetBubbles and not GetCVarBool("chatBubbles") and CVAR then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubbles", 1)
			CVAR = false
		end
		if self.Options.SetBubbles and not GetCVarBool("chatBubblesParty") and CVAR2 then--Only turn them back on if they are off now, but were on when we pulled
			SetCVar("chatBubblesParty", 1)
			CVAR2 = false
		end
		if self:IsDifficulty("heroic10") then
			pillarsRemaining = 8
		else
			pillarsRemaining = 4
		end
		timerAssaultCD:Cancel()
		timerIceLanceCD:Cancel()
		timerShatteringCD:Cancel()
		if self:IsHealer() and self:IsDifficulty("heroic10", "heroic25") then
			sndWOP:Cancel("shattericesoon")
		end
		if self:IsTank() or self:IsHealer() then
			sndWOP:Cancel("countthree")
			sndWOP:Cancel("counttwo")
			sndWOP:Cancel("countone")
		end
		warnLightningStorm:Show()
		specWarnLightingStorm:Show()
		if self.Options.RangeFrame and not self:IsDifficulty("lfr25") then
			DBM.RangeCheck:Show(10)
		end
	elseif args:IsSpellID(105289) then
		self:ScheduleMethod(0.2, "ShatteredIceTarget")
	end
end
