------------------------------------------------------------
-- Invocation.lua
--
-- Abin
-- 2012/11/15
------------------------------------------------------------

local GetTotemInfo = GetTotemInfo
local GetSpellCooldown = GetSpellCooldown

if select(2, UnitClass("player")) ~= "MAGE" then return end

local _, addon = ...
local L = addon.L

local INVOCATION = 12051
local INVOKER = GetSpellInfo(114003)
local INVOKERS_ENERGY = GetSpellInfo(116257)
local RUNE_OF_POWER = GetSpellInfo(116011)
local INCANTERS_WARD = GetSpellInfo(1463)

local button = addon:CreateActionButton("MageInvocation", 12051, nil, 60, "PLAYER_AURA")
button:SetFlyProtect()

local timerFuncs = {}
local currentSpell

function button:OnTalentUpdate(combat)
	if combat then
		return
	end

	local spellId

	if addon:PlayerHasTalent(INVOKER) then
		spellId = INVOCATION
	elseif addon:PlayerHasTalent(RUNE_OF_POWER) then
		spellId = 116011
	elseif addon:PlayerHasTalent(INCANTERS_WARD) then
		spellId = 1463
	end

	if currentSpell == spellId then
		return
	end

	currentSpell = spellId

	if spellId then
		self:SetSpell(spellId)
		self:SetAttribute("spell", self.spell)
		self.OnUpdateTimer = timerFuncs[spellId]
		self:UpdateTimer()
		self:Show()
	else
		self:Hide()
	end
end

-- Invoker's Energy
timerFuncs[INVOCATION] = function(self)
	local expires = addon:GetUnitBuffTimer("player", INVOKERS_ENERGY)
	return expires, expires
end

-- Rune of Power
timerFuncs[116011] = function(self)
	local buff = addon:GetUnitBuffTimer("player", RUNE_OF_POWER)
	local maxExpires = 0
	local i
	for i = 1, 4 do
		local haveTotem, name, startTime, duration = GetTotemInfo(i)
		if haveTotem and name == RUNE_OF_POWER and startTime and duration then
			local expires = startTime + duration
			if expires > maxExpires then
				maxExpires = expires
			end
		end
	end
	return buff, maxExpires
end

-- Incanter's Ward
timerFuncs[1463] = function(self)
	local expires = addon:GetUnitBuffTimer("player", INCANTERS_WARD)
	if expires then
		return expires, expires
	end

	local start, duration = GetSpellCooldown(1463)
	if start and duration then
		return nil, start + duration
	end
end