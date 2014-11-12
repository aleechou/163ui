local mod	= DBM:NewMod("Lanathel", "DBM-Icecrown", 3)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 58 $"):sub(12, -3))
mod:SetCreatureID(37955)
mod:SetEncounterID(1103)
mod:SetModelID(31165)
mod:SetUsedIcons(4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE",
	"SPELL_PERIODIC_DAMAGE",
	"SPELL_PERIODIC_MISSED",
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

local warnPactDarkfallen			= mod:NewTargetAnnounce(71340, 4)
local warnBloodMirror				= mod:NewTargetAnnounce(71510, 3, nil, mod:IsTank() or mod:IsHealer())
local warnSwarmingShadows			= mod:NewTargetAnnounce(71266, 4)
local warnInciteTerror				= mod:NewSpellAnnounce(73070, 3)
local warnVampricBite				= mod:NewTargetAnnounce(70946, 2)
local warnMindControlled			= mod:NewTargetAnnounce(70923, 4)
local warnBloodthirstSoon			= mod:NewSoonAnnounce(70877, 2)
local warnBloodthirst				= mod:NewTargetAnnounce(70877, 3, nil, false)
local warnEssenceoftheBloodQueen	= mod:NewTargetAnnounce(70867, 3, nil, false)

local specWarnBloodBolt				= mod:NewSpecialWarningSpell(71772)
local specWarnPactDarkfallen		= mod:NewSpecialWarningYou(71340)
local specWarnEssenceoftheBloodQueen= mod:NewSpecialWarningYou(70867)
local specWarnBloodthirst			= mod:NewSpecialWarningYou(70877)
local yellBloodthirst				= mod:NewYell(70877, L.YellFrenzy)
local specWarnSwarmingShadows		= mod:NewSpecialWarningMove(71266)
local specWarnMindConrolled			= mod:NewSpecialWarningTarget(70923, mod:IsTank())

local timerNextInciteTerror			= mod:NewNextTimer(100, 73070)
local timerFirstBite				= mod:NewCastTimer(15, 70946)
local timerNextPactDarkfallen		= mod:NewNextTimer(30.5, 71340)
local timerNextSwarmingShadows		= mod:NewNextTimer(30.5, 71266)
local timerInciteTerror				= mod:NewBuffActiveTimer(4, 73070)
local timerBloodBolt				= mod:NewBuffActiveTimer(6, 71772)
local timerBloodThirst				= mod:NewBuffActiveTimer(10, 70877)
local timerEssenceoftheBloodQueen	= mod:NewBuffActiveTimer(60, 70867)

local berserkTimer					= mod:NewBerserkTimer(320)



--local soundSwarmingShadows = mod:NewSound(71266)

mod:AddBoolOption("BloodMirrorIcon", false)
mod:AddBoolOption("SwarmingShadowsIcon", true)
mod:AddBoolOption("SetIconOnDarkFallen", true)
mod:AddBoolOption("RangeFrame", true)
mod:AddBoolOption("YellOnFrenzy", false, "announce")

local pactTargets = {}
local pactIcons = 6

local function warnPactTargets()
	warnPactDarkfallen:Show(table.concat(pactTargets, "<, >"))
	table.wipe(pactTargets)
	timerNextPactDarkfallen:Start(30)
	pactIcons = 6
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerFirstBite:Start(-delay)
	timerNextPactDarkfallen:Start(15-delay)
	timerNextSwarmingShadows:Start(-delay)
	table.wipe(pactTargets)
	pactIcons = 6
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self:IsDifficulty("normal10", "heroic10") then
		timerNextInciteTerror:Start(124-delay)
		sndWOP:Schedule(115, "ptwo")
	else
		timerNextInciteTerror:Start(127-delay)
		sndWOP:Schedule(120, "ptwo")
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71340 then		--Pact of the Darkfallen
		pactTargets[#pactTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnPactDarkfallen:Show()
			sndWOP:Play("followline")
		end
		if self.Options.SetIconOnDarkFallen then--Debuff doesn't actually last 30 seconds
			self:SetIcon(args.destName, pactIcons, 28)--it lasts forever, but if you still have it after 28 seconds
			pactIcons = pactIcons - 1--then you're probably dead anyways
		end
		self:Unschedule(warnPactTargets)
		if #pactTargets >= 3 then
			warnPactTargets()
		else
			self:Schedule(0.3, warnPactTargets)
		end
	elseif args:IsSpellID(71510, 70838) then
		warnBloodMirror:Show(args.destName)
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, 7)
		end
	elseif args.spellId == 70877 then
		warnBloodthirst:Show(args.destName)
		if args:IsPlayer() then
			specWarnBloodthirst:Show()
			yellBloodthirst:Yell()
			sndWOP:Play("bitethem")
			if self:IsDifficulty("normal10", "heroic10") then
				timerBloodThirst:Start(15)--15 seconds on 10 man
			else
				timerBloodThirst:Start()--10 seconds on 25 man
			end
		end
	elseif args:IsSpellID(70867, 70879) then	--Essence of the Blood Queen
		warnEssenceoftheBloodQueen:Show(args.destName)
		if args:IsPlayer() then
			specWarnEssenceoftheBloodQueen:Show()
			if self:IsDifficulty("normal10", "heroic10") then
				timerEssenceoftheBloodQueen:Start(75)--75 seconds on 10 man
				warnBloodthirstSoon:Schedule(70)
				sndWOP:Schedule(70, "bitesoon")
			else
				timerEssenceoftheBloodQueen:Start()--60 seconds on 25 man
				warnBloodthirstSoon:Schedule(55)
				sndWOP:Schedule(55, "bitesoon")
			end
		end
	elseif args.spellId == 70923 then
		warnMindControlled:Show(args.destName)
		specWarnMindConrolled:Show(args.destName)
	elseif args.spellId == 71772 then
		specWarnBloodBolt:Show()
		timerBloodBolt:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 71340 then				--Pact of the Darkfallen
		if self.Options.SetIconOnDarkFallen then
			self:SetIcon(args.destName, 0)		--Clear icon once you got to where you are supposed to be
		end
	elseif args:IsSpellID(71510, 70838) then	--Blood Mirror
		if self.Options.BloodMirrorIcon then
			self:SetIcon(args.destName, 0)
		end
	elseif args.spellId == 70877 then
		if args:IsPlayer() then
			timerBloodThirst:Cancel()
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 73070 then				--Incite Terror (fear before air phase)
		warnInciteTerror:Show()
		timerInciteTerror:Start()
		timerNextSwarmingShadows:Start()--This resets the swarming shadows timer
		timerNextPactDarkfallen:Start(25)--and the Pact timer also reset -5 seconds
		if self:IsDifficulty("normal10", "heroic10") then
			timerNextInciteTerror:Start(120)--120 seconds in between first and second on 10 man
			sndWOP:Schedule(112, "ptwo")
		else
			timerNextInciteTerror:Start()--100 seconds in between first and second on 25 man
			sndWOP:Schedule(92, "ptwo")
		end
	end
end

function mod:SPELL_DAMAGE(sourceGUID, _, _, _, _, destName, _, _, spellId)
	if (spellId == 71726 or spellId == 70946) and self:GetCIDFromGUID(sourceGUID) == 37955 then	-- Vampric Bite (first bite only, hers)
		warnVampricBite:Show(destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 71277 and destGUID == UnitGUID("player") and self:AntiSpam() then		--Swarn of Shadows (spell damage, you're standing in it.)
		specWarnSwarmingShadows:Show()
		sndWOP:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, target)
	if msg:match(L.SwarmingShadows) then
		local target = DBM:GetFullNameByShortName(target)
		warnSwarmingShadows:Show(target)
		timerNextSwarmingShadows:Start()
		if target == UnitName("player") then
			specWarnSwarmingShadows:Show()
--			soundSwarmingShadows:Play()
			sndWOP:Play("keepmove")
		end
		if self.Options.SwarmingShadowsIcon then
			self:SetIcon(target, 8, 6)
		end
	end
end
