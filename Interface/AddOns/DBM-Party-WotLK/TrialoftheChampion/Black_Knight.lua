local mod	= DBM:NewMod(637, "DBM-Party-WotLK", 13, 284)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))
mod:SetCreatureID(35451, 10000)		-- work around, DBM API failes to handle a Boss to die, rebirth, die again, rebirth again and die to loot...
mod:SetEncounterID(340, 341)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")
mod:RegisterKill("yell", L.YellCombatEnd)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL"
)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"SPELL_MISSED"
)

local warnExplode			= mod:NewSpellAnnounce(67729)
local warnGhoulExplode		= mod:NewTargetAnnounce(67751, 4)
local warnMarked			= mod:NewTargetAnnounce(67823, 3)

local specWarnDesecration	= mod:NewSpecialWarningMove(67781)
local specWarnExplode		= mod:NewSpecialWarningRun("OptionVersion2", 67751, mod:IsMelee(), nil, nil, 4)

local timerCombatStart		= mod:NewCombatTimer(55.5)
local timerMarked			= mod:NewTargetTimer(10, 67823)
local timerExplode			= mod:NewCastTimer(4, 67729)

mod:AddBoolOption("SetIconOnMarkedTarget", false)
mod:AddBoolOption("AchievementCheck", false, "announce")

local warnedfailed = false

function mod:OnCombatStart(delay)
	warnedfailed = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 67729 and self:AntiSpam(2, 2) then
		warnExplode:Show()
		specWarnExplode:Show()
		timerExplode:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, destName, _, _, spellId)
	if spellId == 67781 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		specWarnDesecration:Show()
	elseif spellId == 67729 then
		if self.Options.AchievementCheck and not warnedfailed then
			SendChatMessage(L.AchievementFailed:format(destName), "PARTY")
			warnedfailed = true
		end
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 67823 and args:IsDestTypePlayer() then
		if self.Options.SetIconOnMarkedTarget then
			self:SetIcon(args.destName, 8, 10)
		end
		warnMarked:Show(args.destName)
		timerMarked:Show(args.destName)
	elseif args.spellId == 67751 and self:AntiSpam(2, 2) then	-- Ghoul Explode (BK exlodes Army of the dead. Phase 3)
		warnGhoulExplode:Show(args.destName)
		specWarnExplode:Show()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.Pull or msg:find(L.Pull) then
		timerCombatStart:Start()
	end
end