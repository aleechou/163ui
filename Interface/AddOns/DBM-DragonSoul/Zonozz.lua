local mod	= DBM:NewMod(324, "DBM-DragonSoul", nil, 187)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 79 $"):sub(12, -3))
mod:SetCreatureID(55308)
mod:SetModelSound("sound\\CREATURE\\WarlordZonozz\\VO_DS_ZONOZZ_INTRO_01.OGG", "sound\\CREATURE\\WarlordZonozz\\VO_DS_ZONOZZ_SPELL_05.OGG")
mod:SetZone()
mod:SetUsedIcons()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"CHAT_MSG_MONSTER_YELL"
)

local warnVoidofUnmaking		= mod:NewSpellAnnounce(103571, 4, 103527)
local warnVoidDiffusion			= mod:NewStackAnnounce(106836, 2)
local warnFocusedAnger			= mod:NewStackAnnounce(104543, 3, nil, false)
local warnPsychicDrain			= mod:NewSpellAnnounce(104322, 4)
local warnShadows				= mod:NewSpellAnnounce(103434, 3)

local specWarnVoidofUnmaking	= mod:NewSpecialWarningSpell(103571, nil, nil, nil, true)
local specWarnBlackBlood		= mod:NewSpecialWarningSpell(104378, nil, nil, nil, true)
local specWarnPsychicDrain		= mod:NewSpecialWarningSpell(104322, false)
local specWarnShadows			= mod:NewSpecialWarningYou(103434)

local timerVoidofUnmakingCD		= mod:NewNextTimer(90, 103571, nil, nil, nil, 103527)
local timerPsychicDrainCD		= mod:NewCDTimer(20, 104322)
local timerShadowsCD			= mod:NewCDTimer(25, 103434)
local timerBlackBlood			= mod:NewBuffActiveTimer(30, 104378)
local timerphasetwobegin		= mod:NewTimer(71, "timerPhaseTwo", "Interface\\Icons\\Spell_Nature_WispSplode")

local berserkTimer				= mod:NewBerserkTimer(360)

mod:AddBoolOption("DisruptingShadowsIcons", true)
mod:AddDropdownOption("CustomRangeFrame", {"Never", "Normal", "DynamicPhase2", "DynamicAlways"}, "Dynamic3Always", "misc")

local shadowsTargets	= {}
local phase2Started = false
local shadowIcon = 8
local firstPsychicDrain = true
local lastvoid = 0

local function warnShadowsTargets()
	warnShadows:Show(table.concat(shadowsTargets, "<, >"))
	timerShadowsCD:Start()
	if mod:IsHealer() then
		sndWOP:Play(DBM.SoundMMPath.."\\dispelnow.ogg")
	end
	table.wipe(shadowsTargets)
	shadowIcon = 8
end

local shadowsDebuffFilter
do
	shadowsDebuffFilter = function(uId)
		return UnitDebuff(uId, (GetSpellInfo(103434)))
	end
end

function mod:updateRangeFrame()
	if self:IsDifficulty("normal10", "normal25", "lfr25") or self.Options.CustomRangeFrame == "Never" then return end
	if self.Options.CustomRangeFrame == "Normal" or UnitDebuff("player", GetSpellInfo(103434)) or self.Options.CustomRangeFrame == "DynamicPhase2" and not phase2Started then
		DBM.RangeCheck:Show(10, nil)
	else
		DBM.RangeCheck:Show(10, shadowsDebuffFilter)
	end
end

local function blackBloodEnds()
	phase2Started = false
	timerShadowsCD:Start(6)
	if mod:IsDifficulty("lfr25") then
		timerphasetwobegin:Start()
	end
	if GetTime() - lastvoid > 90 then
		timerVoidofUnmakingCD:Start(6)
	end
end

function mod:OnCombatStart(delay)
	phase2Started = false
	shadowIcon = 8
	firstPsychicDrain = true
	lastvoid = 0
	table.wipe(shadowsTargets)
	timerVoidofUnmakingCD:Start(6-delay)
	timerPsychicDrainCD:Start(15-delay)
	timerShadowsCD:Start(-delay)
	self:updateRangeFrame()
	if not self:IsDifficulty("lfr25") then
		berserkTimer:Start(-delay)
	else
		timerphasetwobegin:Start()
	end
end

function mod:OnCombatEnd()
	if self.Options.CustomRangeFrame ~= "Never" then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args:IsSpellID(104322) then
		warnPsychicDrain:Show()
		specWarnPsychicDrain:Show()
		timerPsychicDrainCD:Start()
	end
end	

function mod:SPELL_AURA_APPLIED(args)
	if args:IsSpellID(104543) then
		warnFocusedAnger:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(106836) then
		warnVoidDiffusion:Show(args.destName, args.amount or 1)
	elseif args:IsSpellID(103434) then
		shadowsTargets[#shadowsTargets + 1] = args.destName
		if self.Options.DisruptingShadowsIcons then
			self:SetIcon(args.destName, shadowIcon)
			shadowIcon = shadowIcon - 1
		end
		if args:IsPlayer() and self:IsDifficulty("heroic10", "heroic25") then
			specWarnShadows:Show()
			sndWOP:Play(DBM.SoundMMPath.."\\runout.ogg")
			self:updateRangeFrame()
		end
		self:Unschedule(warnShadowsTargets)
		if (self:IsDifficulty("normal10", "heroic10") and #shadowsTargets >= 3) then
			warnShadowsTargets()
		else
			self:Schedule(0.3, warnShadowsTargets)
		end
	end
end		
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	if args:IsSpellID(103434) then
		if self.Options.DisruptingShadowsIcons then
			self:SetIcon(args.destName, 0)
		end
		self:updateRangeFrame()
	end
end	

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if uId ~= "boss1" then return end
	if spellId == 103571 and not self:IsDifficulty("lfr25") then
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\"..GetLocale().."\\ballappear.ogg")
		timerVoidofUnmakingCD:Start()
		if not firstPsychicDrain then
			timerPsychicDrainCD:Start(8)
		end
		firstPsychicDrain = false
		lastvoid = GetTime()
	elseif spellId == 109413 then
		phase2Started = true
		timerPsychicDrainCD:Cancel()
		timerShadowsCD:Cancel()
		if self:IsDifficulty("lfr25") then
			timerphasetwobegin:Cancel()
		end
		specWarnBlackBlood:Show()
		if self:IsDifficulty("heroic10", "heroic25") then
			timerBlackBlood:Start(41)
			self:Schedule(41, blackBloodEnds)
		else
			timerBlackBlood:Start(31)
			self:Schedule(31, blackBloodEnds)
		end		
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.voidYell or msg:find(L.voidYell)) and self:IsDifficulty("lfr25") then
		warnVoidofUnmaking:Show()
		specWarnVoidofUnmaking:Show()
		sndWOP:Play(DBM.SoundMMPath.."\\"..GetLocale().."\\ballappear.ogg")
		timerVoidofUnmakingCD:Start()
		if not firstPsychicDrain then
			timerPsychicDrainCD:Start(8)
		end
		firstPsychicDrain = false
		lastvoid = GetTime()
	end
end