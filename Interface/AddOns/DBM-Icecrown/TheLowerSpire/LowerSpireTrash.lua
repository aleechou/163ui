local mod	= DBM:NewMod("LowerSpireTrash", "DBM-Icecrown", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 37 $"):sub(12, -3))
mod:SetModelID(30459)
mod:SetUsedIcons(8)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_AURA_APPLIED",
	"SPELL_CAST_START",
	"CHAT_MSG_MONSTER_YELL"
)

local warnDisruptingShout		= mod:NewSpellAnnounce(71022, 2)
local warnDarkReckoning			= mod:NewTargetAnnounce(69483, 3)

local specWarnDisruptingShout	= mod:NewSpecialWarningCast(71022)
local specWarnDarkReckoning		= mod:NewSpecialWarningMove(69483)
local specWarnTrap				= mod:NewSpecialWarning("SpecWarnTrap")

local timerDisruptingShout		= mod:NewCastTimer(3, 71022)
local timerDarkReckoning		= mod:NewTargetTimer(8, 69483)

local soundDarkReckoning		= mod:NewSound(69483)
mod:AddBoolOption("SetIconOnDarkReckoning", true)
mod:RemoveOption("HealthFrame")
mod:RemoveOption("SpeedKillTimer")


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 69483 then
		warnDarkReckoning:Show(args.destName)
		timerDarkReckoning:Start(args.destName)
		if args:IsPlayer() then
			specWarnDarkReckoning:Show()
			soundDarkReckoning:Play()
		end
		if self.Options.SetIconOnDarkReckoning then
			self:SetIcon(args.destName, 8, 8)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 71022 then
		warnDisruptingShout:Show()
		specWarnDisruptingShout:Show()
		timerDisruptingShout:Start()
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if (msg == L.WarderTrap1 or msg == L.WarderTrap2 or msg == L.WarderTrap3) and self:LatencyCheck() then
		self:SendSync("WarderTrap")
	end
end

function mod:OnSync(msg, arg)
	if msg == "WarderTrap" then
		specWarnTrap:Show()
	end
end
