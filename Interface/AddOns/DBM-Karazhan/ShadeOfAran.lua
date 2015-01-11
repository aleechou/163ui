local mod	= DBM:NewMod("Aran", "DBM-Karazhan")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 553 $"):sub(12, -3))
mod:SetCreatureID(16524)
mod:SetModelID(16621)
mod:RegisterCombat("combat")
mod:SetUsedIcons(1, 2, 3, 4, 5, 6, 7, 8)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_SUMMON"
)

local warningFlameCast		= mod:NewCastAnnounce(30004, 4)
local warningFlameTargets	= mod:NewTargetAnnounce(29946, 4)
local warningArcaneCast		= mod:NewCastAnnounce(29973, 4)
local warningBlizzard		= mod:NewSpellAnnounce(29969, 3)
local warningElementals		= mod:NewSpellAnnounce(37053, 3)
local warningChains			= mod:NewTargetAnnounce(29991, 2)

local specWarnDontMove		= mod:NewSpecialWarning("DBM_ARAN_DO_NOT_MOVE")
local specWarnArcane		= mod:NewSpecialWarningRun(29973, nil, nil, nil, 4)
local specWarnBlizzard		= mod:NewSpecialWarningMove(29951)

local timerSpecial			= mod:NewTimer(30, "timerSpecial", "Interface\\Icons\\INV_Enchant_EssenceMagicLarge")
local timerFlameCast		= mod:NewCastTimer(5, 30004)
local timerArcaneExplosion	= mod:NewCastTimer(10, 29973)
local timerFlame			= mod:NewBuffActiveTimer(20.5, 29946)
local timerBlizzad			= mod:NewBuffActiveTimer(30, 29951)
local timerElementals		= mod:NewBuffActiveTimer(90, 37053)
local timerChains			= mod:NewTargetTimer(10, 29991)

local berserkTimer			= mod:NewBerserkTimer(900)

mod:AddBoolOption("WreathIcons", true)
mod:AddBoolOption("ElementalIcons", true)

local WreathTargets = {}
local flameWreathIcon = 8

local function warnFlameWreathTargets()
	warningFlameTargets:Show(table.concat(WreathTargets, "<, >"))
	table.wipe(WreathTargets)
	flameWreathIcon = 8
end

function mod:OnCombatStart(delay)
	berserkTimer:Start(-delay)
	flameWreathIcon = 8
	table.wipe(WreathTargets)
	if not self:IsTrivial(85) then
		self:RegisterShortTermEvents(
			"SPELL_PERIODIC_DAMAGE",
			"SPELL_PERIODIC_MISSED"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 30004 then
		warningFlameCast:Show()
		timerFlameCast:Start()
		timerSpecial:Start()
	elseif args.spellId == 29973 then
		warningArcaneCast:Show()
		timerArcaneExplosion:Start()
		specWarnArcane:Show()
		timerSpecial:Start()
	elseif args.spellId == 29969 then
		warningBlizzard:Show()
		timerBlizzad:Start()
		timerSpecial:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 29991 then
		warningChains:Show(args.destName)
		timerChains:Start(args.destName)
	elseif args.spellId == 29946 then
		WreathTargets[#WreathTargets + 1] = args.destName
		timerFlame:Start()
		if args:IsPlayer() then
			specWarnDontMove:Show()
		end
		if self.Options.WreathIcons then
			self:SetIcon(args.destName, flameWreathIcon, 20)
			flameWreathIcon = flameWreathIcon - 1
		end
		self:Unschedule(warnFlameWreathTargets)
		self:Schedule(0.3, warnFlameWreathTargets)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 29991 then
		timerChains:Cancel(args.destName)
	elseif args.spellId == 29946 and self.Options.WreathIcon then
		self:SetIcon(args.destName, 0)
	end
end

do
	local elementalIcon = {}
	local currentIcon = 1
	local iconsSet = 0
	local function resetElementalIconState()
		table.wipe(elementalIcon)
		currentIcon = 1
		iconsSet = 0
	end
	
	local lastElemental = 0
	function mod:SPELL_SUMMON(args)
		if args:IsSpellID(29962, 37051, 37052, 37053) then -- Summon Water elementals
			if time() - lastElemental > 5 then
				warningElementals:Show()
				timerElementals:Show()
				lastElemental = time()
				if self.Options.ElementalIcons then
					resetElementalIconState()
				end
			end
			if self.Options.ElementalIcons then
				elementalIcon[args.destGUID] = currentIcon
				currentIcon = currentIcon + 1
			end
		end
	end
	
	mod:RegisterOnUpdateHandler(function(self)
		if self.Options.ElementalIcons and (DBM:GetRaidRank() > 0 and not iconsSet == 4) then
			for uId in DBM:GetGroupMembers() do
				uId = uId .. "target"
				local guid = UnitGUID(uId)
				if elementalIcon[guid] then
					SetRaidTarget(uId, elementalIcon[guid])
					iconsSet = iconsSet + 1
					elementalIcon[guid] = nil
				end
			end
		end
	end, 1)
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 29951 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnBlizzard:Show()
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
