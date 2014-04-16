local L = LibStub("AceLocale-3.0"):GetLocale("Skada", false)

local Skada = Skada

local mod = Skada:NewModule(L["Damage"])
local dpsmod = Skada:NewModule(L["DPS"])
local playermod = Skada:NewModule(L["Damage spell list"])
local spellmod = Skada:NewModule(L["Damage spell details"])
local damagedmod = Skada:NewModule(L["Damaged mobs"])

local function getDPS(set, player)
	local totaltime = Skada:PlayerActiveTime(set, player)

	return player.damage / math.max(1,totaltime)
end

local function getRaidDPS(set)
	if set.time > 0 then
		return set.damage / math.max(1, set.time)
	else
		local endtime = set.endtime
		if not endtime then
			endtime = time()
		end
		return set.damage / math.max(1, endtime - set.starttime)
	end
end

local function log_damage(set, dmg)
	-- Get the player.
	local player = Skada:get_player(set, dmg.playerid, dmg.playername)
	if player then

		-- Subtract overkill
--		local amount = math.max(0,dmg.amount - dmg.overkill)
		-- Or don't. Seems to be the way other meters do it.
		local amount = dmg.amount
--		self:Print(player.name..": "..dmg.spellname.." for "..tostring(amount))

		-- Also add to set total damage.
		set.damage = set.damage + amount

		-- Add spell to player if it does not exist.
		if not player.damagespells[dmg.spellname] then
			player.damagespells[dmg.spellname] = {id = dmg.spellid, hit = 0, totalhits = 0, damage = 0, critical = 0, glancing = 0, crushing = 0, ABSORB = 0, BLOCK = 0, DEFLECT = 0, DODGE= 0, EVADE = 0, IMMUNE = 0, PARRY = 0, REFLECT = 0, RESIST = 0, MISS = 0}
		end

		-- Add to player total damage.
		player.damage = player.damage + amount

		-- Get the spell from player.
		local spell = player.damagespells[dmg.spellname]

		spell.totalhits = spell.totalhits + 1

		if spell.max == nil or amount > spell.max then
			spell.max = amount
		end

		if (spell.min == nil or amount < spell.min) and not dmg.missed then
			spell.min = amount
		end

		spell.damage = spell.damage + amount
		if dmg.critical then
			spell.critical = spell.critical + 1
		elseif dmg.missed ~= nil then
			if spell[dmg.missed] ~= nil then	-- Just in case.
				spell[dmg.missed] = spell[dmg.missed] + 1
			end
		elseif dmg.glancing then
			spell.glancing = spell.glancing + 1
		elseif dmg.crushing then
			spell.crushing = spell.crushing + 1
		else
			spell.hit = spell.hit + 1
		end

		-- For now, only save damaged info to current set.
		-- Saving this to Total may become a memory hog deluxe, and besides, it does not make much sense
		-- to see in Total. Why care which particular mob you damaged the most in a whole raid, for example?
		if set == Skada.current and dmg.dstname then
			-- Make sure destination exists in player.
			if not player.damaged[dmg.dstname] then
				player.damaged[dmg.dstname] = 0
			end

			-- Add to destination.
			player.damaged[dmg.dstname] = player.damaged[dmg.dstname] + dmg.amount
		end

	end
end

local dmg = {}

local function SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Spell damage.
	if srcGUID ~= dstGUID then
		local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...

		dmg.playerid = srcGUID
		dmg.playerflags = srcFlags
		dmg.dstname = dstName
		dmg.playername = srcName
		dmg.spellid = spellId
		dmg.spellname = spellName
		dmg.amount = samount
		dmg.overkill = soverkill
		dmg.resisted = sresisted
		dmg.blocked = sblocked
		dmg.absorbed = sabsorbed
		dmg.critical = scritical
		dmg.glancing = sglancing
		dmg.crushing = scrushing
		dmg.missed = nil

		Skada:FixPets(dmg)
		log_damage(Skada.current, dmg)
		log_damage(Skada.total, dmg)
	end
end

local function SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- White melee.
	if srcGUID ~= dstGUID then
		local samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...

		dmg.playerid = srcGUID
		dmg.playername = srcName
		dmg.playerflags = srcFlags
		dmg.dstname = dstName
		dmg.spellid = 6603
		dmg.spellname = L["Attack"]
		dmg.amount = samount
		dmg.overkill = soverkill
		dmg.resisted = sresisted
		dmg.blocked = sblocked
		dmg.absorbed = sabsorbed
		dmg.critical = scritical
		dmg.glancing = sglancing
		dmg.crushing = scrushing
		dmg.missed = nil

		Skada:FixPets(dmg)
		log_damage(Skada.current, dmg)
		log_damage(Skada.total, dmg)
	end
end

local function SwingMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	if srcGUID ~= dstGUID then
		-- Melee misses

		dmg.playerid = srcGUID
		dmg.playername = srcName
		dmg.playerflags = srcFlags
		dmg.dstname = dstName
		dmg.spellid = 6603
		dmg.spellname = L["Attack"]
		dmg.amount = 0
		dmg.overkill = 0
		dmg.resisted = nil
		dmg.blocked = nil
		dmg.absorbed = nil
		dmg.critical = nil
		dmg.glancing = nil
		dmg.crushing = nil
		dmg.missed = select(1, ...)

		Skada:FixPets(dmg)
		log_damage(Skada.current, dmg)
		log_damage(Skada.total, dmg)
	end
end

local function SpellMissed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	-- Misses
	if srcGUID ~= dstGUID then
		local spellId, spellName, spellSchool, missType, samount = ...
		dmg.playerid = srcGUID
		dmg.playername = srcName
		dmg.playerflags = srcFlags
		dmg.dstname = dstName
		dmg.spellid = spellId
		dmg.spellname = spellName
		dmg.amount = 0
		dmg.overkill = 0
		dmg.resisted = nil
		dmg.blocked = nil
		dmg.absorbed = nil
		dmg.critical = nil
		dmg.glancing = nil
		dmg.crushing = nil
		dmg.missed = missType

		Skada:FixPets(dmg)
		log_damage(Skada.current, dmg)
		log_damage(Skada.total, dmg)
	end
end

-- Damage overview.
function mod:Update(win, set)
	-- Max value.
	local max = 0

	local nr = 1
	for i, player in ipairs(set.players) do
		if player.damage > 0 then
			local dps = getDPS(set, player)

			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.label = player.name

			d.valuetext = Skada:FormatValueText(
											Skada:FormatNumber(player.damage), self.metadata.columns.Damage,
											Skada:FormatNumber(dps), self.metadata.columns.DPS,
											string.format("%02.1f%%", player.damage / set.damage * 100), self.metadata.columns.Percent
										)

			d.value = player.damage
			d.id = player.id
			d.class = player.class
			if player.damage > max then
				max = player.damage
			end
			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

-- Tooltip for a specific player.
local function dps_tooltip(win, id, label, tooltip)
	local set = win:get_selected_set()
	local player = Skada:find_player(set, id)
	if player then

		local activetime = Skada:PlayerActiveTime(set, player)
		local totaltime = Skada:GetSetTime(set)
		tooltip:AddLine(player.name.." - "..L["DPS"])
		tooltip:AddDoubleLine(L["Segment time"], totaltime.."s", 255,255,255,255,255,255)
		tooltip:AddDoubleLine(L["Active time"], activetime.."s", 255,255,255,255,255,255)
		tooltip:AddDoubleLine(L["Damage done"], Skada:FormatNumber(player.damage), 255,255,255,255,255,255)
		tooltip:AddDoubleLine(Skada:FormatNumber(player.damage) .. " / " .. activetime .. ":", ("%02.1f"):format(player.damage / math.max(1,activetime)), 255,255,255,255,255,255)

	end
end

-- Tooltip for a specific player.
local function player_tooltip(win, id, label, tooltip)
	local player = Skada:find_player(win:get_selected_set(), playermod.playerid)
	if player then
		local spell = player.damagespells[label]
		if spell then
			tooltip:AddLine(player.name.." - "..label)
			if spell.max and spell.min then
				tooltip:AddDoubleLine(L["Minimum hit:"], Skada:FormatNumber(spell.min), 255,255,255,255,255,255)
				tooltip:AddDoubleLine(L["Maximum hit:"], Skada:FormatNumber(spell.max), 255,255,255,255,255,255)
			end
			tooltip:AddDoubleLine(L["Average hit:"], Skada:FormatNumber(spell.damage / spell.totalhits), 255,255,255,255,255,255)
		end
	end
end

-- Tooltip for a specific player.
-- This is a post-tooltip
local function damage_tooltip(win, id, label, tooltip)
	local set = win:get_selected_set()
	local player = Skada:find_player(set, id)
	--ChatFrame4:AddMessage(("Set: %s, id: %s"):format(set, id))
	if player then
		local activetime = Skada:PlayerActiveTime(set, player)
		local totaltime = Skada:GetSetTime(set)
		tooltip:AddDoubleLine(L["Activity"], ("%02.1f%%"):format(activetime/math.max(1,totaltime)*100), 255,255,255,255,255,255)
	end
end

function playermod:Enter(win, id, label)
	local player = Skada:find_player(win:get_selected_set(), id)
	if player then
		playermod.playerid = id
		playermod.title = player.name..L["'s Damage"]
	end
end

-- Detail view of a player.
function playermod:Update(win, set)
	-- View spells for this player.

	local player = Skada:find_player(set, self.playerid)
	local max = 0

	-- If we reset we have no data.
	if player then

		local nr = 1
		if player then
			for spellname, spell in pairs(player.damagespells) do

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				d.label = spellname
				d.id = spellname
				d.icon = select(3, GetSpellInfo(spell.id))
				d.spellid = spell.id
				d.value = spell.damage
				d.valuetext = Skada:FormatValueText(
												Skada:FormatNumber(spell.damage), self.metadata.columns.Damage,
												string.format("%02.1f%%", spell.damage / player.damage * 100), self.metadata.columns.Percent
											)
				if spell.damage > max then
					max = spell.damage
				end
				nr = nr + 1
			end
		end
	end

	win.metadata.maxvalue = max
end

function damagedmod:Enter(win, id, label)
	local player = Skada:find_player(win:get_selected_set(), id)
	damagedmod.playerid = id
	damagedmod.title = (player and player.name or "Unknown")..L["'s "]..L["Damaged mobs"]
end

-- Player view showing damaged mobs.
function damagedmod:Update(win, set)
	local player = Skada:find_player(set, self.playerid)
	local max = 0

	-- If we reset we have no data.
	if player then

		local nr = 1
		if player then
			for mob, amount in pairs(player.damaged) do

				local d = win.dataset[nr] or {}
				win.dataset[nr] = d
				d.label = mob
				d.id = mob
				d.value = amount
				d.valuetext = Skada:FormatValueText(
												Skada:FormatNumber(amount), self.metadata.columns.Damage,
												string.format("%02.1f%%", amount / player.damage * 100), self.metadata.columns.Percent
											)
				if amount > max then
					max = amount
				end
				nr = nr + 1
			end
		end
	end

	win.metadata.maxvalue = max
end

local function add_detail_bar(win, nr, title, value)
	local d = win.dataset[nr] or {}
	win.dataset[nr] = d

	d.value = value
	d.label = title
	d.id = title
	d.valuetext = Skada:FormatValueText(
									value, mod.metadata.columns.Damage,
									string.format("%02.1f%%", value / win.metadata.maxvalue * 100), mod.metadata.columns.Percent
								)
end

function spellmod:Enter(win, id, label)
	local player = Skada:find_player(win:get_selected_set(), playermod.playerid)
	spellmod.spellname = label
	spellmod.title = player.name..L["'s "]..label
end

function spellmod:Update(win, set)
	local player = Skada:find_player(set,playermod.playerid)

	if player then
		local spell = player.damagespells[self.spellname]

		if spell then
			win.metadata.maxvalue = spell.totalhits

			if spell.hit > 0 then
				add_detail_bar(win, 1, L["Hit"], spell.hit)
			end
			if spell.critical > 0 then
				add_detail_bar(win, 2, L["Critical"], spell.critical)
			end
			if spell.glancing > 0 then
				add_detail_bar(win, 3, L["Glancing"], spell.glancing)
			end
			if spell.crushing > 0 then
				add_detail_bar(win, 4, L["Crushing"], spell.crushing)
			end
			if spell.ABSORB and spell.ABSORB > 0 then
				add_detail_bar(win, 5, L["Absorb"], spell.ABSORB)
			end
			if spell.BLOCK and spell.BLOCK > 0 then
				add_detail_bar(win, 6, L["Block"], spell.BLOCK)
			end
			if spell.DEFLECT and spell.DEFLECT > 0 then
				add_detail_bar(win, 7, L["Deflect"], spell.DEFLECT)
			end
			if spell.DODGE and spell.DODGE > 0 then
				add_detail_bar(win, 8, L["Dodge"], spell.DODGE)
			end
			if spell.EVADE and spell.EVADE > 0 then
				add_detail_bar(win, 9, L["Evade"], spell.EVADE)
			end
			if spell.IMMUNE and spell.IMMUNE > 0 then
				add_detail_bar(win, 10, L["Immune"], spell.IMMUNE)
			end
			if spell.MISS and spell.MISS > 0 then
				add_detail_bar(win, 11, L["Missed"], spell.MISS)
			end
			if spell.PARRY and spell.PARRY > 0 then
				add_detail_bar(win, 12, L["Parry"], spell.PARRY)
			end
			if spell.REFLECT and spell.REFLECT > 0 then
				add_detail_bar(win, 13, L["Reflect"], spell.REFLECT)
			end
			if spell.RESIST and spell.RESIST > 0 then
				add_detail_bar(win, 14, L["Resist"], spell.RESIST)
			end

		end
	end

end

-- DPS-only view
function dpsmod:GetSetSummary(set)
	return Skada:FormatNumber(getRaidDPS(set))
end

function dpsmod:Update(win, set)
	local max = 0
	local nr = 1

	for i, player in ipairs(set.players) do
		local dps = getDPS(set, player)

		if dps > 0 then
			local d = win.dataset[nr] or {}
			win.dataset[nr] = d
			d.label = player.name
			d.id = player.id
			d.value = dps
			d.class = player.class
			d.valuetext = Skada:FormatNumber(dps)
			if dps > max then
				max = dps
			end

			nr = nr + 1
		end
	end

	win.metadata.maxvalue = max
end

function mod:OnEnable()
	dpsmod.metadata = 		{showspots = true, tooltip = dps_tooltip}
	playermod.metadata = 	{tooltip = player_tooltip, click1 = spellmod, columns = {Damage = true, Percent = true}}
	mod.metadata = 			{post_tooltip = damage_tooltip, showspots = true, click1 = playermod, click2 = damagedmod, columns = {Damage = true, DPS = true, Percent = true}}
	damagedmod.metadata = 	{columns = {Damage = true, Percent = true}}
	spellmod.metadata =		{columns = {Damage = true, Percent = true}}

	Skada:RegisterForCL(SpellDamage, 'DAMAGE_SHIELD', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_DAMAGE', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellDamage, 'SPELL_BUILDING_DAMAGE', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellDamage, 'RANGE_DAMAGE', {src_is_interesting = true, dst_is_not_interesting = true})

	Skada:RegisterForCL(SwingDamage, 'SWING_DAMAGE', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SwingMissed, 'SWING_MISSED', {src_is_interesting = true, dst_is_not_interesting = true})

	Skada:RegisterForCL(SpellMissed, 'SPELL_MISSED', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellMissed, 'SPELL_PERIODIC_MISSED', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellMissed, 'RANGE_MISSED', {src_is_interesting = true, dst_is_not_interesting = true})
	Skada:RegisterForCL(SpellMissed, 'SPELL_BUILDING_MISSED', {src_is_interesting = true, dst_is_not_interesting = true})

	Skada:AddFeed(L["Damage: Personal DPS"], function()
								if Skada.current then
									local player = Skada:find_player(Skada.current, UnitGUID("player"))
									if player then
										return Skada:FormatNumber(getDPS(Skada.current, player)).." "..L["DPS"]
									end
								end
							end)
	Skada:AddFeed(L["Damage: Raid DPS"], function()
								if Skada.current then
									return Skada:FormatNumber(getRaidDPS(Skada.current)).." "..L["RDPS"]
								end
							end)
	Skada:AddMode(self)
end

function mod:OnDisable()
	Skada:RemoveMode(self)

	Skada:RemoveFeed(L["Damage: Personal DPS"])
	Skada:RemoveFeed(L["Damage: Raid DPS"])
end

function dpsmod:OnEnable()
	Skada:AddMode(self)
end

function dpsmod:OnDisable()
	Skada:RemoveMode(self)
end

function mod:AddToTooltip(set, tooltip)
 	GameTooltip:AddDoubleLine(L["DPS"], Skada:FormatNumber(getRaidDPS(set)), 1,1,1)
end

function mod:GetSetSummary(set)
	return Skada:FormatValueText(
						Skada:FormatNumber(set.damage), self.metadata.columns.Damage,
						Skada:FormatNumber(getRaidDPS(set)), self.metadata.columns.DPS
					)
end

-- Called by Skada when a new player is added to a set.
function mod:AddPlayerAttributes(player)
	if not player.damage then
		player.damage = 0
		player.damagespells = {}
	end
	if not player.damaged then
		player.damaged = {}
	end
end

-- Called by Skada when a new set is created.
function mod:AddSetAttributes(set)
	if not set.damage then
		set.damage = 0
	end
end
