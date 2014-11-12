local mod	= DBM:NewMod("Festergut", "DBM-Icecrown", 2)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 58 $"):sub(12, -3))
mod:SetCreatureID(36626)
mod:SetModelID(31006)
mod:RegisterCombat("combat")
mod:SetUsedIcons(6, 7, 8)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_APPLIED_DOSE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnInhaledBlight		= mod:NewStackAnnounce(69166, 3)
local warnGastricBloat		= mod:NewStackAnnounce(72219, 2, nil, mod:IsTank() or mod:IsHealer())
local warnGasSpore			= mod:NewTargetAnnounce(69279, 4)
local warnVileGas			= mod:NewTargetAnnounce(69240, 3)

local specWarnPungentBlight	= mod:NewSpecialWarningSpell(69195)
local specWarnGasSpore		= mod:NewSpecialWarningYou(69279)
local specWarnVileGas		= mod:NewSpecialWarningYou(69240)
local specWarnGastricBloat	= mod:NewSpecialWarningStack(72219, nil, 9)
local specWarnInhaled3		= mod:NewSpecialWarningStack(69166, mod:IsTank(), 3)
local specWarnGoo			= mod:NewSpecialWarningSpell(72297, mod:IsMelee())

local timerGasSpore			= mod:NewBuffActiveTimer(12, 69279)
local timerVileGas			= mod:NewBuffActiveTimer(6, 69240, nil, mod:IsRanged())
local timerGasSporeCD		= mod:NewNextTimer(40, 69279)		-- Every 40 seconds except after 3rd and 6th cast, then it's 50sec CD
local timerPungentBlight	= mod:NewNextTimer(33, 69195)		-- 33 seconds after 3rd stack of inhaled
local timerInhaledBlight	= mod:NewNextTimer(34, 69166)		-- 34 seconds'ish
local timerGastricBloat		= mod:NewTargetTimer(100, 72219, nil, mod:IsTank() or mod:IsHealer())	-- 100 Seconds until expired
local timerGastricBloatCD	= mod:NewCDTimer(11, 72219, nil, mod:IsTank() or mod:IsHealer()) 		-- 10 to 14 seconds



local berserkTimer			= mod:NewBerserkTimer(300)

local warnGoo				= mod:NewSpellAnnounce(72297, 4)
local timerGooCD			= mod:NewNextTimer(10, 72297)

mod:AddBoolOption("RangeFrame", mod:IsRanged())
mod:AddBoolOption("SetIconOnGasSpore", true)
mod:AddBoolOption("AnnounceSporeIcons", false)
mod:AddBoolOption("AchievementCheck", false, "announce")

local gasSporeTargets	= {}
local gasSporeIconTargets	= {}
local vileGasTargets	= {}
local gasSporeCast 	= 0
local warnedfailed = false

local function ClearSporeTargets()
	table.wipe(gasSporeIconTargets)
end

do
	local function sort_by_group(v1, v2)
		return DBM:GetRaidSubgroup(DBM:GetUnitFullName(v1)) < DBM:GetRaidSubgroup(DBM:GetUnitFullName(v2))
	end
	function mod:SetSporeIcons()
		table.sort(gasSporeIconTargets, sort_by_group)
		local gasSporeIcon = 8
		for i, v in ipairs(gasSporeIconTargets) do
			if self.Options.AnnounceSporeIcons and DBM:GetRaidRank() > 0 then
				SendChatMessage(L.SporeSet:format(gasSporeIcon, DBM:GetUnitFullName(v)), "RAID")
			end
			self:SetIcon(v, gasSporeIcon, 12)
			gasSporeIcon = gasSporeIcon - 1
		end
		self:Schedule(5, ClearSporeTargets)
	end
end

local function warnGasSporeTargets()
	warnGasSpore:Show(table.concat(gasSporeTargets, "<, >"))
	sndWOP:Play("spore")
	sndWOP:Schedule(9, "countthree")
	sndWOP:Schedule(10, "counttwo")
	sndWOP:Schedule(11, "countone")
	timerGasSpore:Start()
	table.wipe(gasSporeTargets)
end

local function warnVileGasTargets()
	warnVileGas:Show(table.concat(vileGasTargets, "<, >"))
	table.wipe(vileGasTargets)
	timerVileGas:Start()
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	timerInhaledBlight:Start(-delay)
	timerGasSporeCD:Start(20-delay)--This may need tweaking
	table.wipe(gasSporeTargets)
	table.wipe(vileGasTargets)
	table.wipe(gasSporeIconTargets)
	gasSporeCast = 0
	warnedfailed = false
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(8)
	end
	if self:IsDifficulty("heroic10", "heroic25") then
		timerGooCD:Start(13-delay)
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 69195 then	-- Pungent Blight
		specWarnPungentBlight:Show()
		sndWOP:Play("bomb")
		timerInhaledBlight:Start(38)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, spellName)
	if spellName == GetSpellInfo(72299) and self:LatencyCheck() then -- Malleable Goo Summon Trigger (10 player normal) (the other 3 spell ids are not needed here since all spells have the same name)
		self:SendSync("Goo")
	end
end

function mod:OnSync(event, arg)
	if event == "Goo" then
		if self:AntiSpam(5, 2) then
			warnGoo:Show()
			specWarnGoo:Show()
			sndWOP:Play("greenball")
			if self:IsDifficulty("heroic25") then
				timerGooCD:Start()
			else
				timerGooCD:Start(30)--30 seconds in between goos on 10 man heroic
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69279 then	-- Gas Spore
		gasSporeTargets[#gasSporeTargets + 1] = args.destName
		gasSporeCast = gasSporeCast + 1
		if (gasSporeCast < 9 and self:IsDifficulty("normal25", "heroic25")) or (gasSporeCast < 6 and self:IsDifficulty("normal10", "heroic10")) then
			timerGasSporeCD:Start()
		elseif (gasSporeCast >= 9 and self:IsDifficulty("normal25", "heroic25")) or (gasSporeCast >= 6 and self:IsDifficulty("normal10", "heroic10")) then
			timerGasSporeCD:Start(50)--Basically, the third time spores are placed on raid, it'll be an extra 10 seconds before he applies first set of spores again.
			gasSporeCast = 0
		end
		if args:IsPlayer() then
			specWarnGasSpore:Show()
		end
		if self.Options.SetIconOnGasSpore then
			table.insert(gasSporeIconTargets, DBM:GetRaidUnitId(args.destName))
			self:UnscheduleMethod("SetSporeIcons")
			if (self:IsDifficulty("normal25", "heroic25") and #gasSporeIconTargets >= 3) or (self:IsDifficulty("normal10", "heroic10") and #gasSporeIconTargets >= 2) then
				self:SetSporeIcons()--Sort and fire as early as possible once we have all targets.
			else
				if self:LatencyCheck() then--Icon sorting is still sensitive and should not be done by laggy members that don't have all targets.
					self:ScheduleMethod(0.3, "SetSporeIcons")
				end
			end
		end
		self:Unschedule(warnGasSporeTargets)
		if #gasSporeTargets >= 3 then
			warnGasSporeTargets()
		else
			self:Schedule(0.3, warnGasSporeTargets)
		end
	elseif args.spellId == 69166 then	-- Inhaled Blight
		local amount = args.amount or 1
		warnInhaledBlight:Show(args.destName, amount)
		if amount >= 3 then
			specWarnInhaled3:Show(amount)
			timerPungentBlight:Start()
		else	--Prevent timer from starting after 3rd stack since he won't cast it a 4th time, he does Pungent instead.
			timerInhaledBlight:Start()
		end
	elseif args.spellId == 72219 then	-- Gastric Bloat
		local amount = args.amount or 1
		warnGastricBloat:Show(args.destName, amount)
		timerGastricBloat:Start(args.destName)
		timerGastricBloatCD:Start()
		if args:IsPlayer() and amount >= 9 then
			specWarnGastricBloat:Show(amount)
			if mod:IsTank() or mod:IsHealer() then
				sndWOP:Play("changemt")
			end
		end
	elseif args.spellId == 69240 and args:IsDestTypePlayer() then	-- Vile Gas
		vileGasTargets[#vileGasTargets + 1] = args.destName
		if args:IsPlayer() then
			specWarnVileGas:Show()
		end
		self:Unschedule(warnVileGasTargets)
		self:Schedule(0.8, warnVileGasTargets)
	elseif args.spellId == 69291 and args:IsDestTypePlayer() then	--Inoculated
		local amount = args.amount or 1
		if self.Options.AchievementCheck and DBM:GetRaidRank() > 0 and not warnedfailed and self:AntiSpam(3, 1) then
			if amount == 3 then
				warnedfailed = true
				SendChatMessage(L.AchievementFailed:format(args.destName, amount), "RAID_WARNING")
			end
		end
	end
end

mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED
