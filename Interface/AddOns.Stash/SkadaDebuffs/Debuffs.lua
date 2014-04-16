local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Debuff uptimes"], "AceTimer-3.0")
local auramod = Skada:NewModule(L["Debuff spell list"])

local buffs = Skada:NewModule(L["Buff uptimes"])
local buffspells = Skada:NewModule(L["Buff spell list"])

-- This is highly inefficient. Come up with something better.
local function tick_spells(set)
	for i, player in ipairs(set.players) do
		for spellname, spell in pairs(player.auras) do
			if spell.active > 0 then
				spell.uptime = spell.uptime + 1
			end
		end
	end
end

-- Adds 1s to the uptime of all currently active spells.
-- A spell is considered active if at least 1 instance of it is still active.
-- We determine this by incrementing or subtracting from a counter.
-- This is less messy than fooling around with the aura events.
function mod:Tick()
	if Skada.current then
		tick_spells(Skada.current)
		tick_spells(Skada.total)
	end
end

local function log_auraapply(set, aura)
	if set then

		-- Get the player.
		local player = Skada:get_player(set, aura.playerid, aura.playername)
		if player then
			--Skada:Print("applied "..aura.spellname.. " to "..player.name.. " - "..aura.auratype)
			-- Add aura to player if it does not exist.
			-- If it does exist, increment our counter of active instances by 1
			if not player.auras[aura.spellname] then
				player.auras[aura.spellname] = {id = aura.spellid, name = aura.spellname, active = 1, uptime = 0, auratype = aura.auratype}
			else
				player.auras[aura.spellname].active = player.auras[aura.spellname].active + 1
			end
		end

	end
end

local function log_auraremove(set, aura)
	if set then

		-- Get the player.
		local player = Skada:get_player(set, aura.playerid, aura.playername)
		if player then
			--Skada:Print("removed "..aura.spellname.. " to "..player.name.. " - "..aura.auraType)
			-- If aura does not exist, we know nothing about it and ignore it.
			-- If it does exist and we know of 1 or more active instances, subtract 1 from our counter.
			if player.auras[aura.spellname] then
				local a = player.auras[aura.spellname]
				if a.active > 0 then
					a.active = a.active - 1
				end
			end
		end

	end
end

local aura = {}

local function AuraApplied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, auraType = ...
	aura.playerid = srcGUID
	aura.playername = srcName
	aura.spellid = spellId
	aura.spellname = spellName
	aura.auratype = auraType

	Skada:FixPets(aura)
	log_auraapply(Skada.current, aura)
	log_auraapply(Skada.total, aura)
end

local function AuraRemoved(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local spellId, spellName, spellSchool, auraType = ...
	aura.playerid = srcGUID
	aura.playername = srcName
	aura.spellid = spellId
	aura.spellname = spellName
	aura.auratype = auraType

	Skada:FixPets(aura)
	log_auraremove(Skada.current, aura)
	log_auraremove(Skada.total, aura)
end

local function len(t)
	local l = 0
	for i,j in pairs(t) do
		l = l + 1
	end
	return l
end

local function updatefunc(auratype, win, set)
	local nr = 1
	local max = 0

	for i, player in ipairs(set.players) do
		-- Find number of debuffs.
		local auracount = 0
		local aurauptime = 0
		for spellname, spell in pairs(player.auras) do
			if spell.auratype == auratype then
				auracount = auracount + 1
				aurauptime = aurauptime + spell.uptime
			end
		end

		if auracount > 0 then
			-- Calculate player max possible uptime.
			local maxtime = Skada:PlayerActiveTime(set, player)

			-- Now divide by the number of spells to get the average uptime.
			local uptime = min(maxtime, aurauptime / auracount)

			local d = win.dataset[nr] or {}
			win.dataset[nr] = d

			d.id = player.id
			d.value = uptime
			d.label = player.name
			d.valuetext = ("%02.1f%% / %u"):format(uptime / maxtime * 100, auracount)
			d.class = player.class

			if uptime > max then
				max = uptime
			end

			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

-- Detail view of a player.
local function detailupdatefunc(auratype, win, set, playerid)
	-- View spells for this player.
	local nr = 1
	local max = 0
	local player = Skada:find_player(set, playerid)

	if player then
		-- Calculate player max possible uptime.
		local maxtime = Skada:PlayerActiveTime(set, player)

		win.metadata.maxvalue = maxtime
		for spellname, spell in pairs(player.auras) do
			if spell.auratype == auratype then
				local uptime = min(maxtime, spell.uptime)

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				d.id = spell.name
				d.value = uptime
				d.label = spell.name
				d.icon = select(3, GetSpellInfo(spell.id))
				d.spellid = spell.id
				d.valuetext = ("%02.1f%%"):format(uptime / maxtime * 100)

				nr = nr + 1
			end
		end
	end

end

function mod:Update(win, set)
	updatefunc("DEBUFF", win, set)
end

function auramod:Enter(win, id, label)
	auramod.playerid = id
	auramod.title = label..L["'s Debuffs"]
end

function auramod:Update(win, set)
	detailupdatefunc("DEBUFF", win, set, self.playerid)
end

function buffs:Update(win, set)
	updatefunc("BUFF", win, set)
end

function buffspells:Enter(win, id, label)
	buffspells.playerid = id
	buffspells.title = label..L["'s Buffs"]
end

-- Detail view of a player.
function buffspells:Update(win, set)
	detailupdatefunc("BUFF", win, set, self.playerid)
end

function mod:OnEnable()
	mod.metadata 		= {showspots = 1, click1 = auramod, click2 = buffspells}
	auramod.metadata 	= {}
	buffs.metadata 		= {showspots = 1, click1 = buffspells, click2 = auramod}
	buffspells.metadata = {}

	Skada:RegisterForCL(AuraApplied, 'SPELL_AURA_APPLIED', {src_is_interesting = true})
	Skada:RegisterForCL(AuraRemoved, 'SPELL_AURA_REMOVED', {src_is_interesting = true})

	self:ScheduleRepeatingTimer("Tick", 1)

	Skada:AddMode(self)
	Skada:AddMode(buffs)
end

function mod:OnDisable()
	Skada:RemoveMode(self)
	Skada:RemoveMode(buffs)
end

function mod:AddToTooltip(set, tooltip)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.auras then
		player.auras = {}
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
end
