local mod = DBM:NewMod(547, "DBM-Party-BC", 10, 253)
local L = mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 553 $"):sub(12, -3))
mod:SetCreatureID(18708)
mod:SetUsedIcons(8)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"SPELL_AURA_REMOVED",
	"SPELL_CAST_START"
)

local warnBoom          = mod:NewCastAnnounce(33923, 4)
local warnTouch         = mod:NewTargetAnnounce(33711, 3)

local specWarnBoom		= mod:NewSpecialWarningRun(33923, nil, nil, nil, 4)
local specWarnTouch		= mod:NewSpecialWarningMoveAway(33711)

local timerBoomCast     = mod:NewCastTimer(5, 33923)
local timerTouch        = mod:NewTargetTimer(14, 33711)

mod:AddBoolOption("SetIconOnTouchTarget", true)

function mod:SPELL_CAST_START(args)
	if args.spellId == 33923 or args.spellId == 38796 then
		warnBoom:Show()
		specWarnBoom:Show()
		timerBoomCast:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 33711 then
		warnTouch:Show(args.destName)
		timerTouch:Start(args.destName)
		if self.Options.SetIconOnTouchTarget then
			self:SetIcon(args.destName, 8, 14)
		end
		if args:IsPlayer() then
            specWarnTouch:Show()
        end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if args.spellId == 33711 and self.Options.SetIconOnTouchTarget then
		self:SetIcon(args.destName, 0)
	end
end
