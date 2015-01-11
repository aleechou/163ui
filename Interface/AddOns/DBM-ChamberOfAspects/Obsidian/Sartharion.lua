local mod	= DBM:NewMod("Sartharion", "DBM-ChamberOfAspects", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 178 $"):sub(12, -3))
mod:SetCreatureID(28860)
mod:SetEncounterID(1090)
mod:SetModelID(27035)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS",
	"SPELL_AURA_APPLIED",
	"SPELL_DAMAGE",
	"RAID_BOSS_EMOTE"
)
mod.onlyNormal = true

local warnShadowFissure	    = mod:NewSpellAnnounce(59127)
local warnTenebron          = mod:NewAnnounce("WarningTenebron", 2, 61248, false)
local warnShadron           = mod:NewAnnounce("WarningShadron", 2, 58105, false)
local warnVesperon          = mod:NewAnnounce("WarningVesperon", 2, 61251, false)

local warnFireWall			= mod:NewSpecialWarning("WarningFireWall", nil, nil, true)
local warnVesperonPortal	= mod:NewSpecialWarning("WarningVesperonPortal", false)
local warnTenebronPortal	= mod:NewSpecialWarning("WarningTenebronPortal", false)
local warnShadronPortal		= mod:NewSpecialWarning("WarningShadronPortal", false)

mod:AddBoolOption("AnnounceFails", false, "announce")

local timerShadowFissure    = mod:NewCastTimer(5, 59128)--Cast timer until Void Blast. it's what happens when shadow fissure explodes.
local timerWall             = mod:NewCDTimer(30, 43113)
local timerTenebron         = mod:NewTimer(30, "TimerTenebron", 61248)
local timerShadron          = mod:NewTimer(80, "TimerShadron", 58105)
local timerVesperon         = mod:NewTimer(120, "TimerVesperon", 61251)

local lastvoids = {}
local lastfire = {}
local GetSpellInfo, UnitDebuff = GetSpellInfo, UnitDebuff
local tsort, tinsert, twipe = table.sort, table.insert, table.wipe

local function isunitdebuffed(spellID)
	local name = GetSpellInfo(spellID)
	if not name then return false end

	for i=1, 40, 1 do
		local debuffname = UnitDebuff("player", i, "HARMFUL")
		if debuffname == name then
			return true
		end
	end
	return false
end

function mod:OnSync(event)
	if event == "FireWall" then
		timerWall:Start()
		warnFireWall:Show()
	elseif event == "VesperonPortal" then
		warnVesperonPortal:Show()
	elseif event == "TenebronPortal" then
		warnTenebronPortal:Show()
	elseif event == "ShadronPortal" then
		warnShadronPortal:Show()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
    if args:IsSpellID(57579, 59127) then
        warnShadowFissure:Show()
        timerShadowFissure:Start()
    end
end

function mod:RAID_BOSS_EMOTE(msg, mob)
	if msg == L.Wall or msg:find(L.Wall) then
		self:SendSync("FireWall")
	elseif msg == L.Portal or msg:find(L.Portal) then
		if mob == L.NameVesperon then
			self:SendSync("VesperonPortal")
		elseif mob == L.NameTenebron then
			self:SendSync("TenebronPortal")
		elseif mob == L.NameShadron then
			self:SendSync("ShadronPortal")
		end
	end
end

function mod:CheckDrakes(delay)
	if DBM.BossHealth:IsShown() then
		DBM.BossHealth:Show(L.name)
		DBM.BossHealth:AddBoss(28860, "Sartharion")
	end
	if isunitdebuffed(61248) then	-- Power of Tenebron
		timerTenebron:Start(30 - delay)
		warnTenebron:Schedule(25 - delay)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(30452, "Tenebron")
		end
	end
	if isunitdebuffed(58105) then	-- Power of Shadron
		timerShadron:Start(75 - delay)
		warnShadron:Schedule(70 - delay)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(30451, "Shadron")
		end
	end
	if isunitdebuffed(61251) then	-- Power of Vesperon
		timerVesperon:Start(120 - delay)
		warnVesperon:Schedule(115 - delay)
		if DBM.BossHealth:IsShown() then
			DBM.BossHealth:AddBoss(30449, "Vesperon")
		end
	end
end

function mod:OnCombatStart(delay)
	self:ScheduleMethod(5, "CheckDrakes", delay)
	timerWall:Start(-delay)

	twipe(lastvoids)
	twipe(lastfire)
end


local sortedFails = {}
local function sortFails1(e1, e2)
	return (lastvoids[e1] or 0) > (lastvoids[e2] or 0)
end
local function sortFails2(e1, e2)
	return (lastfire[e1] or 0) > (lastfire[e2] or 0)
end

function mod:OnCombatEnd(wipe)	
	if not self.Options.AnnounceFails then return end
	if DBM:GetRaidRank() < 1 or not self.Options.Announce then return end

	local voids = ""
	for k, v in pairs(lastvoids) do
		tinsert(sortedFails, k)
	end
	tsort(sortedFails, sortFails1)
	for i, v in ipairs(sortedFails) do
		voids = voids.." "..v.."("..(lastvoids[v] or "")..")"
	end
	SendChatMessage(L.VoidZones:format(voids), "RAID")
	twipe(sortedFails)
	
	local fire = ""
	for k, v in pairs(lastfire) do
		tinsert(sortedFails, k)
	end
	tsort(sortedFails, sortFails2)
	for i, v in ipairs(sortedFails) do
		fire = fire.." "..v.."("..(lastfire[v] or "")..")"
	end
	SendChatMessage(L.FireWalls:format(fire), "RAID")
	twipe(sortedFails)
end

function mod:SPELL_AURA_APPLIED(args)
	if self.Options.AnnounceFails and self.Options.Announce and args.spellId == 57491 and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(args.destName) ~= "none" and args.destName then
		lastfire[args.destName] = (lastfire[args.destName] or 0) + 1
		SendChatMessage(L.FireWallOn:format(args.destName), "RAID")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, destName, _, _, spellId)
	if self.Options.AnnounceFails and self.Options.Announce and spellId == 59128 and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(destName) ~= "none" and destName then
		lastvoids[destName] = (lastvoids[destName] or 0) + 1
		SendChatMessage(L.VoidZoneOn:format(destName), "RAID")
	end	
end
