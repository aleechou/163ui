------------------------------------------------------------
-- Traps.lua
--
-- Abin
-- 2012/2/06
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "HUNTER" then return end

local IsSpellKnown = IsSpellKnown
local UnitGUID = UnitGUID
local GetTime = GetTime
local pairs = pairs
local GetSpecialization = GetSpecialization

local _, addon = ...
local L = addon.L

local spellList = {}
local trapNames = {}
local placedTraps = {}
local activatedTraps = {}

local function RegisterTrap(id, duration, trapType, auraFlag)
	local data = addon:BuildSpellList(spellList, id)
	data.duration = duration
	data.origDuration = duration
	data.trapType = trapType
	data.auraFlag = auraFlag
	trapNames[data.spell] = data
end

RegisterTrap(1499, 60, "frost", "single") -- Frozen
RegisterTrap(13809, 30, "frost", "aoe") -- Frost
-- RegisterTrap(13795, 15, "fire", "single") -- Immo
RegisterTrap(13813, 20, "fire", "damage") -- Explosion
RegisterTrap(34600, 15, "natural", "guardian") -- Snake

local button = addon:CreateActionButton("HunterTraps", L["traps"], nil, 60, "DUAL")
button:SetSpell2(77769)
button:SetAttribute("spell2", button.spell2)
button:RequireSpell(1499)
button:SetFlyProtect()
button:SetScrollable(spellList, "spell1")

function button:OnSpellUpdate()
	if IsSpellKnown(77769) then
		self:SetSpell2(77769)
	else
		self:SetSpell2(nil)
	end
end

button:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

function button:COMBAT_LOG_EVENT_UNFILTERED(_, flag, _, srcGuid, _, _, _, _, _, _, _, _, spell)
	if srcGuid ~= UnitGUID("player") then
		return
	end

	local data = trapNames[spell]
	if not data then
		return
	end

	local notify
	if flag == "SPELL_CREATE" then
		placedTraps[spell] = GetTime() + 60
		activatedTraps[spell] = nil
		local name, other
		for name, other in pairs(trapNames) do
			if name ~= spell and data.trapType == other.trapType then
				placedTraps[other.spell] = nil
			end
		end
		notify = 1

	elseif flag == "SPELL_AURA_APPLIED" then
		placedTraps[spell] = nil
		if data.auraFlag == "single" or (data.auraFlag == "aoe" and not activatedTraps[spell]) then
			activatedTraps[spell] = GetTime() + data.duration
			if data.auraFlag == "single" then
				data.affection = (data.affection or 0) + 1
			end
			notify = 1
		end

	elseif flag == "SPELL_MISSED" then
		placedTraps[spell] = nil
		if data.auraFlag == "single" then
			activatedTraps[spell] = nil
			notify = 1
		elseif data.auraFlag then
			if not activatedTraps[spell] then
				activatedTraps[spell] = GetTime() + data.duration
			end
			notify = 1
		end

	elseif flag == "SPELL_AURA_REMOVED" then
		if data.auraFlag == "single" then
			data.affection = (data.affection or 0) - 1
			if data.affection < 1 then
				data.affection = nil
				activatedTraps[spell] = nil
			end
			notify = 1
		end

	elseif flag == "SPELL_DAMAGE" then
		if data.auraFlag == "damage" then
			placedTraps[spell] = nil
			if not activatedTraps[spell] then
				activatedTraps[spell] = GetTime() + data.duration
			end
			notify = 1
		end
	end

	if notify then
		self:UpdateTimer()
	end
end

function button:OnUpdateTimer(spell, spell2)
	local expires = addon:GetUnitBuffTimer("player", spell2)
	if expires then
		return -1, expires
	end

	local placed = placedTraps[spell]
	if placed then
		return 1, placed
	else
		local actTime = activatedTraps[spell]
		if actTime then
			return 1, actTime
		end
	end
end

function button:OnTalentUpdate()
	if GetSpecialization() == 3 then
		local data
		for _, data in pairs(trapNames) do
			if data.trapType == "frost" then
				data.duration  = data.origDuration * 1.3
			end
		end
	end
end

function button:OnEnterWorld()
	wipe(placedTraps)
	wipe(activatedTraps)
	local data
	for _, data in pairs(trapNames) do
		data.affection = nil
	end
	self:UpdateTimer()
end
