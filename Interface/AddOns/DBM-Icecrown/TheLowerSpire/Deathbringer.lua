local mod	= DBM:NewMod("Deathbringer", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 167 $"):sub(12, -3))
mod:SetCreatureID(37813)
mod:SetEncounterID(1096)
mod:SetModelID(30790)
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_CAST_SUCCESS",
	"SPELL_SUMMON",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH target focus mouseover",
	"UNIT_POWER target focus mouseover"
)

local warnFrenzySoon		= mod:NewSoonAnnounce(72737, 2, nil, mod:IsTank() or mod:IsHealer())
local warnAddsSoon			= mod:NewPreWarnAnnounce(72173, 10, 3)
local warnAdds				= mod:NewSpellAnnounce(72173, 4)
local warnFrenzy			= mod:NewSpellAnnounce(72737, 2, nil, mod:IsTank() or mod:IsHealer())
local warnBloodNova			= mod:NewSpellAnnounce(72378, 2)
local warnMark 				= mod:NewTargetCountAnnounce(72293, 4, 72293)
local warnBoilingBlood		= mod:NewTargetAnnounce(72385, 2, nil, mod:IsHealer())
local warnRuneofBlood		= mod:NewTargetAnnounce(72410, 3, nil, mod:IsTank() or mod:IsHealer())

local specwarnMark			= mod:NewSpecialWarningTarget(72293, false)
local specwarnRuneofBlood	= mod:NewSpecialWarningTarget(72410, mod:IsTank())

local timerCombatStart		= mod:NewCombatTimer(48)
local timerRuneofBlood		= mod:NewNextTimer(20, 72410, nil, mod:IsTank() or mod:IsHealer())
local timerBoilingBlood		= mod:NewNextTimer(15.5, 72385)
local timerBloodNova		= mod:NewNextTimer(20, 72378)
local timerCallBloodBeast	= mod:NewNextTimer(40, 72173)

local enrageTimer			= mod:NewBerserkTimer(480)

mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("RunePowerFrame", true, "misc")
mod:AddBoolOption("BeastIcons", true)
mod:AddBoolOption("BoilingBloodIcons", false)

local warned_preFrenzy = false
local boilingBloodTargets = {}
local boilingBloodIcon 	= 8
local Mark = 0
local lastPower = 0

local function warnBoilingBloodTargets()
	warnBoilingBlood:Show(table.concat(boilingBloodTargets, "<, >"))
	table.wipe(boilingBloodTargets)
	boilingBloodIcon = 8
end

local function getPower()
	return lastPower
end

function mod:OnCombatStart(delay)
	if DBM.BossHealth:IsShown() and self.Options.RunePowerFrame then
		local name = GetSpellInfo(72370)
		DBM.BossHealth:AddBoss(getPower, name)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		enrageTimer:Start(360-delay)
	else
		enrageTimer:Start(-delay)
	end
	timerCallBloodBeast:Start(-delay)
	warnAddsSoon:Schedule(30-delay)
	timerBloodNova:Start(-delay)
	timerRuneofBlood:Start(-delay)
	timerBoilingBlood:Start(19-delay)
	table.wipe(boilingBloodTargets)
	warned_preFrenzy = false
	boilingBloodIcon = 8
	Mark = 0
	lastPower = 0
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(12)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 72378 then
		warnBloodNova:Show()
		timerBloodNova:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 72410 then
		warnRuneofBlood:Show(args.destName)
		specwarnRuneofBlood:Show(args.destName)
		timerRuneofBlood:Start()
	end
end

do
	local beastIcon = {}
	local currentIcon = 1
	local iconsSet = 0
	local function resetBeastIconState()
		table.wipe(beastIcon)
		currentIcon = 1
		iconsSet = 0
	end
	
	local lastBeast = 0
	function mod:SPELL_SUMMON(args)
		if args:IsSpellID(72172, 72173, 72356, 72357, 72358) then
			if self:AntiSpam(5) then
				warnAdds:Show()
				warnAddsSoon:Schedule(30)
				timerCallBloodBeast:Start()
				if self.Options.BeastIcons then
					resetBeastIconState()
				end
			end
			if self.Options.BeastIcons then
				beastIcon[args.destGUID] = currentIcon
				currentIcon = currentIcon + 1
			end
		end
	end
	
	mod:RegisterOnUpdateHandler(function(self)
		if self.Options.BeastIcons and (DBM:GetRaidRank() > 0 and not (iconsSet == 5 and self:IsDifficulty("normal25", "heroic25") or iconsSet == 2 and self:IsDifficulty("normal10", "heroic10"))) then
			for uId in DBM:GetGroupMembers() do
				local unitId = uId.."target"
				local guid = UnitGUID(unitId)
				if beastIcon[guid] then
					SetRaidTarget(unitId, beastIcon[guid])
					iconsSet = iconsSet + 1
					beastIcon[guid] = nil
				end
			end
		end
	end, 1)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 72293 then
		Mark = Mark + 1
		warnMark:Show(Mark, args.destName)
		specwarnMark:Show(args.destName)
	elseif args.spellId == 72385 then
		boilingBloodTargets[#boilingBloodTargets + 1] = args.destName
		timerBoilingBlood:Start()
		if self.Options.BoilingBloodIcons then
			self:SetIcon(args.destName, boilingBloodIcon, 15)
			boilingBloodIcon = boilingBloodIcon - 1
		end
		self:Unschedule(warnBoilingBloodTargets)
		if self:IsDifficulty("normal10", "heroic10") or (self:IsDifficulty("normal25", "heroic25") and #boilingBloodTargets >= 3) then
			warnBoilingBloodTargets()
		else
			self:Schedule(0.3, warnBoilingBloodTargets)
		end
	elseif args.spellId == 72737 then
		warnFrenzy:Show()
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 72385 then
		self:SetIcon(args.destName, 0)
	end
end

function mod:UNIT_HEALTH(uId)
	if not warned_preFrenzy and self:GetUnitCreatureId(uId) == 37813 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.33 then
		warned_preFrenzy = true
		warnFrenzySoon:Show()
	end
end

function mod:UNIT_POWER(uId)
	if self:GetUnitCreatureId(uId) == 37813 then
		lastPower = math.floor(UnitPower(uId)/UnitPowerMax(uId) * 100)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg:find(L.PullAlliance, 1, true) then
		timerCombatStart:Start()
	elseif msg:find(L.PullHorde, 1, true) then
		timerCombatStart:Start(94.5)
	end
end
