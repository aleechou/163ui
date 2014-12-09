local mod	= DBM:NewMod(1185, "DBM-Party-WoD", 1, 547)
local L		= mod:GetLocalizedStrings()
local sndWOP	= mod:SoundMM("SoundWOP")

mod:SetRevision(("$Revision: 11901 $"):sub(12, -3))
mod:SetCreatureID(75839)--Soul Construct
mod:SetEncounterID(1686)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 153002 153006 157465",
	"SPELL_DAMAGE 161457",
	"SPELL_MISSED 161457"
)

local warnHolyShield			= mod:NewTargetAnnounce(153002, 3)
local warnConsecratedLight		= mod:NewSpellAnnounce(153006, 4)
local warnFate					= mod:NewSpellAnnounce(157465, 2)

local specWarnHolyShield		= mod:NewSpecialWarningTarget(153002)
local yellHolyShield			= mod:NewYell(153002)
local specWarnConsecreatedLight	= mod:NewSpecialWarningSpell(153006, nil, nil, nil, 3)
local specWarnFate				= mod:NewSpecialWarningSpell(157465, nil, nil, nil, 2)
local specWarnSanctifiedGround	= mod:NewSpecialWarningMove(161457)

local timerHolyShieldCD			= mod:NewNextTimer(47, 153002)
local timerConsecratedLightCD	= mod:NewNextTimer(7, 153006)
local timerConsecratedLight		= mod:NewBuffActiveTimer(8, 153006)
local timerFateCD				= mod:NewCDTimer(37, 157465)--Need more logs to confirm

local countdownHolyShield		= mod:NewCountdown(47, 153002)
local countdownConsecratedLight	= mod:NewCountdown("Alt7", 153006)

mod:AddArrowOption("ShieldArrow", 153002, true, true)

function mod:ShieldTarget(targetname, uId)
	if not targetname then return end
	warnHolyShield:Show(targetname)
	specWarnHolyShield:Show(targetname)
	if targetname == UnitName("player") then
		yellHolyShield:Yell()
	else
		if self.Options.ShieldArrow then
			DBM.Arrow:ShowRunTo(uId, 3, 3, 9)
		end
		sndWOP:Schedule(3, "findshield")
	end
end

function mod:OnCombatStart(delay)
	timerFateCD:Start(25-delay)
	timerHolyShieldCD:Start(30-delay)
	countdownHolyShield:Start(30-delay)
end

function mod:OnCombatEnd()
	if self.Options.ShieldArrow then
		DBM.Arrow:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 153002 then
		self:BossTargetScanner(75839, "ShieldTarget", 0.02, 16)
		timerConsecratedLightCD:Start()
		countdownConsecratedLight:Start()
		timerHolyShieldCD:Start()
		countdownHolyShield:Start()
	elseif spellId == 153006 then
		warnConsecratedLight:Show()
		specWarnConsecreatedLight:Show()
		timerConsecratedLight:Start()
	elseif spellId == 157465 then
		warnFate:Show()
		specWarnFate:Show()
		timerFateCD:Start()
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 161457 and destGUID == UnitGUID("player") and self:AntiSpam() then
		specWarnSanctifiedGround:Show()
		sndWOP:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
