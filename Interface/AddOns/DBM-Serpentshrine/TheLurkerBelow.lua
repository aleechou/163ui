local mod	= DBM:NewMod("LurkerBelow", "DBM-Serpentshrine")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 531 $"):sub(12, -3))
mod:SetCreatureID(21217)
mod:SetModelID(20216)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"RAID_BOSS_EMOTE",
	"UNIT_DIED",
	"UNIT_SPELLCAST_SUCCEEDED target focus"
)

local warnSubmerge		= mod:NewAnnounce("WarnSubmerge", 1)
local warnEmerge		= mod:NewAnnounce("WarnEmerge", 1)
local warnSpout			= mod:NewSpellAnnounce(37433, 4)
local warnWhirl			= mod:NewSpellAnnounce(37363, 2)

local specWarnSpout		= mod:NewSpecialWarningSpell(37433, nil, nil, nil, 2)

local timerSubmerge		= mod:NewTimer(105, "TimerSubmerge", 39091)
local timerEmerge		= mod:NewTimer(60, "TimerEmerge", 39088)
local timerSpoutCD		= mod:NewCDTimer(50, 37433)
local timerSpout		= mod:NewBuffActiveTimer(22, 37433)
local timerWhirlCD		= mod:NewCDTimer(18, 37363)

local submerged = false
local guardianKill = 0
local ambusherKill = 0

local function emerged()
	submerged = false
	timerEmerge:Cancel()
	warnEmerge:Show()
	timerSubmerge:Start()
end

function mod:OnCombatStart(delay)
	submerged = false
	timerWhirlCD:Start(15-delay)
	timerSpoutCD:Start(37-delay)
	timerSubmerge:Start(90-delay)
end

function mod:RAID_BOSS_EMOTE(msg, source)
	if (source or "") == L.name then
		warnSpout:Show()
		specWarnSpout:Show()
		timerSpout:Start()
		timerSpoutCD:Start()
	end
end

function mod:UNIT_DIED(args)
	local cId = self:GetCIDFromGUID(args.destGUID)
	if cId == 21865 then
		ambusherKill = ambusherKill + 1
		if ambusherKill == 6 and guardianKill == 3 and submerged then
			self:Unschedule(emerged)
			self:Schedule(2, emerged)
		end
	elseif cId == 21873 then
		guardianKill = guardianKill + 1
		if ambusherKill == 6 and guardianKill == 3 and submerged then
			self:Unschedule(emerged)
			self:Schedule(2, emerged)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, _, _, spellId)
	if spellId == 28819 and self:AntiSpam(2, 1) then--Submerge Visual
		self:SendSync("Submerge")
	elseif spellId == 37660 and self:AntiSpam(2, 2) then
		self:SendSync("Whirl")
	end
end

function mod:OnSync(msg)
	if msg == "Submerge" then
		submerged = true
		guardianKill = 0
		ambusherKill = 0
		timerSubmerge:Cancel()
		timerSpoutCD:Cancel()
		timerWhirlCD:Cancel()
		warnSubmerge:Show()
		timerEmerge:Start()
		self:Schedule(60, emerged)
	elseif msg == "Whirl" then
		warnWhirl:Show()
		timerWhirlCD:Start()
	end
end
