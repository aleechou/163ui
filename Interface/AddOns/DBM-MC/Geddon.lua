local mod	= DBM:NewMod("Geddon", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 550 $"):sub(12, -3))
mod:SetCreatureID(12056)
--mod:SetEncounterID(668)
mod:SetModelID(12129)
mod:SetUsedIcons(8)
mod:RegisterCombat("combat")

mod:RegisterEvents(
	"SPELL_AURA_APPLIED 20475",
	"SPELL_AURA_REMOVED 20475",
	"SPELL_CAST_SUCCESS 19695 19659 20478"
)

local warnInferno		= mod:NewSpellAnnounce(19695, 3)
local warnIgnite		= mod:NewSpellAnnounce(19659, 2)
local warnBomb			= mod:NewTargetAnnounce(20475, 4)
local warnArmageddon	= mod:NewSpellAnnounce(20478, 3)

local specWarnBomb		= mod:NewSpecialWarningYou(20475, nil, nil, nil, 3)
local yellBomb			= mod:NewYell(20475)
local specWarnInferno	= mod:NewSpecialWarningSpell(19695, nil, nil, nil, 2)

local timerInferno		= mod:NewBuffActiveTimer(8, 19695)
local timerBombCD		= mod:NewCDTimer(16, 20475)
local timerBomb			= mod:NewTargetTimer(8, 20475)
local timerArmageddon	= mod:NewCastTimer(8, 20478)

mod:AddSetIconOption("SetIconOnBombTarget", 20475)

function mod:OnCombatStart(delay)
	timerBombCD:Start(11-delay)
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 20475 then
		warnBomb:Show(args.destName)
		timerBomb:Start(args.destName)
		timerBombCD:Start()
		if self.Options.SetIconOnBombTarget then
			self:SetIcon(args.destName, 8)
		end
		if args:IsPlayer() then
			specWarnBomb:Show()
			if self:IsDifficulty("event40") then
				yellBomb:Yell()
			end
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 20475 then
		timerBomb:Cancel(args.destName)
		if self.Options.SetIconOnBombTarget then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 19695 then
		warnInferno:Show()
		if self:IsDifficulty("event40") then
			specWarnInferno:Show()
		end
		timerInferno:Start()
	elseif spellId == 19659 then
		warnIgnite:Show()
	elseif spellId == 20478 then
		warnArmageddon:Show()
		timerArmageddon:Start()
	end
end

