local mod	= DBM:NewMod("GunshipBattle", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 131 $"):sub(12, -3))
local addsIcon
local bossID
--mod:SetEncounterID(1099)--No ES fires this combat
mod:RegisterCombat("combat")
mod:SetCreatureID(37215, 37540) -- Orgrim's Hammer, The Skybreaker
mod:SetMinSyncRevision(119)
if UnitFactionGroup("player") == "Alliance" then
	mod:SetMainBossID(37215)
	mod:SetModelID(30416)		-- High Overlord Saurfang
	addsIcon = 23334
	bossID = 36939
else
	mod:SetMainBossID(37540)
	mod:SetModelID(30508)		-- Muradin Bronzebeard
	addsIcon = 23336
	bossID = 36948
end

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2"
)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:SetBossHealthInfo(
	37215, L.Hammer,
	37540, L.Skybreaker
)

--TODO, see if IEEU fires here and if we need yell triggers for engage
local warnBelowZero			= mod:NewSpellAnnounce(69705, 4)
local warnExperienced		= mod:NewTargetAnnounce(71188, 1, nil, false)		-- might be spammy
local warnVeteran			= mod:NewTargetAnnounce(71193, 2, nil, false)		-- might be spammy
local warnElite				= mod:NewTargetAnnounce(71195, 3, nil, false)		-- might be spammy
local warnBattleFury		= mod:NewStackAnnounce("OptionVersion2", 69638, 2, nil, mod:IsTank() or mod:IsHealer())
local warnBladestorm		= mod:NewSpellAnnounce(69652, 3, nil, mod:IsMelee())
local warnWoundingStrike	= mod:NewTargetAnnounce(69651, 2)
local warnAddsSoon			= mod:NewAnnounce("WarnAddsSoon", 2, addsIcon)

local timerCombatStart		= mod:NewCombatTimer(45)
local timerBelowZeroCD		= mod:NewNextTimer(33.5, 69705)
local timerBattleFuryActive	= mod:NewBuffFadesTimer(17, 69638, nil, mod:IsTank() or mod:IsHealer())
local timerAdds				= mod:NewTimer(60, "TimerAdds", addsIcon)

mod:RemoveOption("HealthFrame")

local firstMage = false

function mod:Adds()
	timerAdds:Start()
	warnAddsSoon:Cancel()
	warnAddsSoon:Schedule(55)
	self:UnscheduleMethod("Adds")
	self:ScheduleMethod(60, "Adds")
end

function mod:OnCombatStart(delay)
	timerAdds:Start(15-delay)--First adds might come early or late so timer should be taken as a proximity only.
	warnAddsSoon:Schedule(10)
	self:ScheduleMethod(15, "Adds")
	firstMage = false
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 71195 then
		warnElite:Show(args.destName)
	elseif args.spellId == 71193 then
		warnVeteran:Show(args.destName)
	elseif args.spellId == 71188 then
		warnExperienced:Show(args.destName)
	elseif args.spellId == 69652 then
		warnBladestorm:Show()
	elseif args.spellId == 69651 then
		warnWoundingStrike:Show(args.destName)
	elseif args.spellId == 69638 and self:GetCIDFromGUID(args.destGUID) == bossID then
		timerBattleFuryActive:Start()		-- only a timer for 1st stack
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	if args.spellId == 69638 and self:GetCIDFromGUID(args.destGUID) == bossID then
		if args.amount % 5 == 0 then		-- warn every 5 stacks
			warnBattleFury:Show(args.destName, args.amount or 1)
		end
		timerBattleFuryActive:Start()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 69705 then
		timerBelowZeroCD:Start()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69705 then
		warnBelowZero:Show()
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(72340) then
		DBM:EndCombat(self)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.PullAlliance) or msg:find(L.PullHorde) then
		timerCombatStart:Start()
	elseif (msg:find(L.AddsAlliance) or msg:find(L.AddsHorde)) and self:IsInCombat() then
		self:Adds()
	elseif (msg:find(L.MageAlliance) or msg:find(L.MageHorde)) and self:IsInCombat() then
		if not firstMage then
			timerBelowZeroCD:Start(3.2)
			firstMage = true
		else
			timerBelowZeroCD:Update(30.3, 33.5)--Update the below zero timer to correct it with yells since it tends to be off depending on how bad your cannon operators are.
		end
	end
end
