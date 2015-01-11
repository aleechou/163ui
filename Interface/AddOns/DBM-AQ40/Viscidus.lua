local mod	= DBM:NewMod("Viscidus", "DBM-AQ40", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 538 $"):sub(12, -3))
mod:SetCreatureID(15299)
mod:SetModelID(15686)
mod:SetMinSyncRevision(428)

mod:RegisterCombat("combat")

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_EMOTE"
)

local warnFreeze		= mod:NewAnnounce("WarnFreeze", 2, 33395)
local warnShatter		= mod:NewAnnounce("WarnShatter", 2, 12982)

local timerFrozen		= mod:NewBuffActiveTimer(30, 25937)

local meleeHits = 0

function mod:OnCombatStart(delay)
	meleeHits = 0
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
end

function mod:CHAT_MSG_MONSTER_EMOTE(msg)
	if msg:find(L.Phase4) then
		self:SendSync("Phase", 1)
	elseif msg:find(L.Phase5) then
		self:SendSync("Phase", 2)
	elseif msg:find(L.Phase6) then
		self:SendSync("Phase", 3)
	elseif msg:find(L.Slow) then
		self:SendSync("Slow")
	elseif msg:find(L.Freezing) then
		self:SendSync("Freezing")
	elseif msg:find(L.Frozen) then
		self:SendSync("Frozen")
	end
end

function mod:RANGE_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, _, _, _, overkill)
	local cid = self:GetCIDFromGUID(destGUID)
	if cid == 15299 then
		meleeHits = meleeHits + 1
		if meleeHits > 30 then
			self:UnregisterShortTermEvents()
		end
	end
end

function mod:SWING_DAMAGE(_, _, _, _, destGUID, _, _, _, _, overkill)
	local cid = self:GetCIDFromGUID(destGUID)
	if cid == 15299 then
		meleeHits = meleeHits + 1
		if meleeHits > 30 then
			self:UnregisterShortTermEvents()
		end
	end
end

function mod:OnSync(msg, arg)
	if msg == "Phase" then
		warnShatter:Show(tonumber(arg))
		if tonumber(arg) == 3 then
			timerFrozen:Cancel()
		end
	elseif msg == "Slow" then
		warnFreeze:Show(1)
	elseif msg == "Freezing" then
		warnFreeze:Show(2)
	elseif msg == "Frozen" then
		self:RegisterShortTermEvents(
			"SWING_DAMAGE",
			"RANGE_DAMAGE"
		)
		meleeHits = 0
		warnFreeze:Show(3)
		timerFrozen:Start()
	end
end
