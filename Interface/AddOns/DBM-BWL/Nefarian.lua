local mod	= DBM:NewMod("Nefarian-Classic", "DBM-BWL", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 502 $"):sub(12, -3))
mod:SetCreatureID(11583)
mod:SetModelID(11380)
mod:RegisterCombat("yell", L.YellPull)
mod:SetWipeTime(25)--guesswork

mod:RegisterEvents(
	"SPELL_CAST_START",
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"UNIT_HEALTH target focus mouseover",
	"CHAT_MSG_MONSTER_YELL"
)

local warnClassCall		= mod:NewAnnounce("WarnClassCall", 3)
local warnPhase			= mod:NewAnnounce("WarnPhase", 3)
local warnPhase3Soon	= mod:NewPrePhaseAnnounce(3)
local warnShadowFlame	= mod:NewCastAnnounce(22539, 2)
local warnFear			= mod:NewCastAnnounce(22686, 2)
local warnVeilShadow	= mod:NewTargetAnnounce(22687, 3)
local warnMC			= mod:NewTargetAnnounce(22667, 4)

local specwarnMC		= mod:NewSpecialWarningTarget(22667, mod:IsTank())

local timerClassCall	= mod:NewTimer(30, "TimerClassCall")
local timerShadowFlame	= mod:NewCastTimer(2, 22539)
local timerFearNext		= mod:NewNextTimer(30, 22686)
local timerVeilShadow	= mod:NewTargetTimer(6, 22687)
local timerMC			= mod:NewTargetTimer(15, 22667)

local prewarn_P3

function mod:OnCombatStart(delay)
	prewarn_P3 = false
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 22539 and self:IsInCombat() then
		warnShadowFlame:Show()
		timerShadowFlame:Start()
	elseif args.spellId == 22686 and self:IsInCombat() then
		warnFear:Show()
		timerFearNext:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 22687 then
		warnVeilShadow:Show(args.destName)
		timerVeilShadow:Start(args.destName)
	elseif args.spellId == 22667 then
		warnMC:Show(args.destName)
		specwarnMC:Show(args.destName)
		timerMC:Start(args.destName)
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 22687 then
		timerVeilShadow:Cancel(args.destName)
	end
end

function mod:UNIT_HEALTH(uId)
	if UnitHealth(uId) / UnitHealthMax(uId) <= 0.25 and self:GetUnitCreatureId(uId) == 11583 and not prewarn_P3 then
		warnPhase3Soon:Show()
		prewarn_P3 = true
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellDK or msg:find(L.YellDK) then
		self:SendSync("ClassCall", "DK")
	elseif msg == L.YellDruid or msg:find(L.YellDruid) then
		self:SendSync("ClassCall", "Druid")
	elseif msg == L.YellHunter or msg:find(L.YellHunter) then
		self:SendSync("ClassCall", "Hunter")
	elseif msg == L.YellMage or msg:find(L.YellMage) then
		self:SendSync("ClassCall", "Mage")
	elseif msg == L.YellPaladin or msg:find(L.YellPaladin) then
		self:SendSync("ClassCall", "Paladin")
	elseif msg == L.YellPriest or msg:find(L.YellPriest) then
		self:SendSync("ClassCall", "Priest")
	elseif msg == L.YellRogue or msg:find(L.YellRogue) then
		self:SendSync("ClassCall", "Rogue")
	elseif msg == L.YellShaman or msg:find(L.YellShaman) then
		self:SendSync("ClassCall", "Shaman")
	elseif msg == L.YellWarlock or msg:find(L.YellWarlock) then
		self:SendSync("ClassCall", "Warlock")
	elseif msg == L.YellWarrior or msg:find(L.YellWarrior) then
		self:SendSync("ClassCall", "Warrior")
	elseif msg == L.YellMonk or msg:find(L.YellMonk) then
		self:SendSync("ClassCall", "Monk")
	elseif msg == L.YellP2 or msg:find(L.YellP2) then
		self:SendSync("Phase", 2)
	elseif msg == L.YellP3 or msg:find(L.YellP3) then
		self:SendSync("Phase", 3)
	end
end

function mod:OnSync(msg, arg)
	if msg == "ClassCall" then
		warnClassCall:Show(arg)
		timerClassCall:Start(arg)
	elseif msg == "Phase" then
		warnPhase:Show(arg)
	end
end
