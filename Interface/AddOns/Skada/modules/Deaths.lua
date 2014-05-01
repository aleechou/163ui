
Skada:AddLoadableModule("Deaths", function(Skada, L)
	if Skada.db.profile.modulesBlocked.Deaths then return end

	local mod = Skada:NewModule(L["Deaths"], "AceTimer-3.0")
	local deathlog = Skada:NewModule(L["Death log"])

	local SORtime = {}

	local death_spell = 41220 -- Death

	local function log_deathlog(set, playerid, playername, srcname, spellid, spellname, amount, timestamp, logoverride, healthoverride)
		local player = Skada:get_player(set, playerid, playername)
		local log = logoverride or player.deathlog
		local pos = log.pos or 1

		local entry = log[pos] 
		if not entry then
		  entry = {}
		  log[pos] = entry
		end
		entry.srcname =   srcname
		entry.spellid =   spellid
		entry.spellname = spellname
		entry.amount =	  amount
		entry.ts = 	  timestamp
		entry.hp = 	  healthoverride or UnitHealth(playername)

		pos = pos + 1
		if pos > 15 then pos = 1 end
		log.pos = pos
	end

	local function log_death(set, playerid, playername, timestamp)
		local player = Skada:get_player(set, playerid, playername)

		if player then
			-- Add a fake entry for the actual death.
			local spellid = death_spell
			local spellname = string.format(L["%s dies"], player.name)
			local deathts = timestamp
			log_deathlog(set, playerid, playername, nil, spellid, spellname, 0, timestamp, nil, 0)
			local deathlog = player.deathlog

			for i,entry in ipairs(deathlog) do
				-- sometimes multiple close events arrive with the same timestamp
				-- add a small bias to ensure we preserve the order in which we recorded them
				-- this ensures sort stability (to prevent oscillation on :Update())
				-- and makes it more likely the health bar progression is correct
				entry.ts = entry.ts + i*0.00001 + (i < (deathlog.pos or 1) and 0.001 or 0)
				if entry.spellid == death_spell then deathts = entry.ts end
			end

			-- Change to a new deathlog.
			player.deathlog = {}

			-- Do our best to determine maxhp for the segment where death occurred
			local cplayer = Skada:get_player(Skada.current, playerid, playername)
			local maxhp = (cplayer and cplayer.maxhp) or player.maxhp

			return deathts, deathlog, maxhp
		end
	end

	local function save_death(set, playerid, playername, deathts, deathlog, maxhp)
		local player = Skada:get_player(set, playerid, playername)

		if player then
			-- Add a death along with it's timestamp.
			player.deaths = player.deaths or {}
			table.insert(player.deaths, 1, {["ts"] = deathts, ["log"] = deathlog, ["maxhp"] = maxhp}) 

			-- Also add to set deaths.
			set.deaths = set.deaths + 1
		end
	end

	local function log_resurrect(set, playerid, playername, srcname, spellid, spellname, timestamp)
		local player = Skada:get_player(set, playerid, playername)

		-- Add log entry to to previous death.
		if player and player.deaths and player.deaths[1] then
			log_deathlog(set, playerid, playername, srcname, spellid, spellname, 0, timestamp, player.deaths[1].log, 0)
		end
	end

	local function log_SORdeath(set, playerid, playername, timestamp)
		local player = Skada:get_player(set, playerid, playername)

		local spellid = death_spell
		local spellname = string.format(L["%s dies"], GetSpellInfo(20711))

		-- Add log entry to to previous death.
		if player and player.deaths and player.deaths[1] then
			log_deathlog(set, playerid, playername, playername, spellid, spellname, 0, timestamp, player.deaths[1].log, 0)
		end

		-- this event is the death of the Spirit of Redemption who is immune to all damage, so the deathlog is meaningless
		if player and player.deathlog then
			wipe(player.deathlog)
		end
	end

	local function UnitDied(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		local SORtime = SORtime[dstGUID] or 0
		if timestamp > SORtime + 1 and 
                   timestamp < SORtime + 20 then -- Spirit of Redemption lasts 15 sec, allow some padding for latency
			log_SORdeath(Skada.total,   dstGUID, dstName, timestamp)
		elseif not UnitIsFeignDeath(dstName) then	-- Those pesky hunters
			local deathts, deathlog, maxhp = log_death(Skada.total, dstGUID, dstName, timestamp)
			if deathlog then -- save the finalized death log to both sets. 
			        -- This log is deliberately aliased, both to save memory and capture post-death updates
				save_death(Skada.total,   dstGUID, dstName, deathts, deathlog, maxhp)
				save_death(Skada.current, dstGUID, dstName, deathts, deathlog, maxhp)
			end
		end
	end

	local function AuraApplied(...)
		local spellId = select(9,...)
		if spellId == 27827 then -- Spirit of Redemption, Holy priest just died
			local timestamp = ...
			local dstGUID = select(6,...)
			SORtime[dstGUID] = timestamp
			-- SOR AURA_APPLIED often arrives before the actual killing blow (although usually with the same timestamp)
			-- insert a short delay before closing the deathlog to increase the chances we capture the killing blow
			local args = { select(2,...) } -- sigh, ... cannot be an upvalue
			mod:ScheduleTimer(function()
                           UnitDied((timestamp+0.01), unpack(args)) -- add a ts bias for display of "simultaneous" killing blow
                        end, 0.01)
		end
	end

        local function Missed(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		if dstGUID and timestamp == SORtime[dstGUID] then -- this is actually the killing blow for the SOR we just recorded
			local spellId, samount
			if eventtype == "SWING_MISSED" then
				spellId = 88163
				samount = select(3,...)
			else
				spellId = ...
				samount = select(6,...)
			end
			-- print("SOR Miss killing blow: ",dstName, spellid, samount)
			log_deathlog(Skada.total, dstGUID, dstName, srcName, spellId, nil, 0-samount, timestamp)
		end
        end

	local function Resurrect(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- Resurrection.
		local spellId, spellName, spellSchool = ...

		log_resurrect(Skada.total, dstGUID, dstName, srcName, spellId, nil, timestamp)
	end

	local function SpellDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- Spell damage.
		local spellId, spellName, spellSchool, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...

		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		log_deathlog(Skada.total, dstGUID, dstName, srcName, spellId, nil, 0-samount, timestamp)
	end

	local function SwingDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- White melee.
		local samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...
		local spellid = 88163

		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		log_deathlog(Skada.total, dstGUID, dstName, srcName, spellid, nil, 0-samount, timestamp)
	end

	local function EnvironmentalDamage(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- Environmental damage.
		local environmentalType, samount, soverkill, sschool, sresisted, sblocked, sabsorbed, scritical, sglancing, scrushing = ...

		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		log_deathlog(Skada.total, dstGUID, dstName, srcName, nil, environmentalType, 0-samount, timestamp)
	end

	local function Instakill(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- Instakill events
		local spellId, spellName, spellSchool = ...
		spellId = spellId or 80468

		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		log_deathlog(Skada.total, dstGUID, dstName, srcName, spellId, spellName, -1e9, timestamp)
	end

	local function SpellHeal(timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
		-- Healing
		local spellId, spellName, spellSchool, samount, soverhealing, absorbed, scritical = ...
		local srcName_modified
		samount = max(0, samount - soverhealing)

		srcGUID, srcName_modified = Skada:FixMyPets(srcGUID, srcName)
		dstGUID, dstName = Skada:FixMyPets(dstGUID, dstName)
		log_deathlog(Skada.total, dstGUID, dstName, (srcName_modified or srcName), spellId, nil, samount, timestamp)
	end

	-- Death meter.
	function mod:Update(win, set)
		local nr = 1
		local max = 0

		for i, player in ipairs(set.players) do
			if player.deaths and #player.deaths > 0 then
				local d = win.dataset[nr] or {}
				win.dataset[nr] = d

				-- Find latest death timestamp.
				local maxdeathts = 0
				for j, death in ipairs(player.deaths) do
					if death.ts > maxdeathts then
						maxdeathts = death.ts
					end
				end

				d.id = player.id
				d.value = maxdeathts
				d.label = player.name
				d.class = player.class
				d.valuetext = Skada:FormatValueText(
						tostring(#player.deaths), self.metadata.columns.Deaths,
						date("%H:%M:%S", maxdeathts), self.metadata.columns.Timestamp
						)
				if maxdeathts > max then
					max = maxdeathts
				end

				nr = nr + 1
			end
		end

		win.metadata.maxvalue = max
	end

	function deathlog:Enter(win, id, label)
		deathlog.playerid = id
		deathlog.title = label..L["'s Death"]
	end

	local green = {r = 0, g = 255, b = 0, a = 1}
	local red = {r = 255, g = 0, b = 0, a = 1}

	local function cmp_ts(a,b) 
		return a and b and a.ts > b.ts 
	end

	-- Death log.
	function deathlog:Update(win, set)
		local player = Skada:get_player(set, self.playerid)

		if player and player.deaths then
			local nr = 1
			local winmax = 1

			-- Sort deaths.
			table.sort(player.deaths, cmp_ts)

			for i, death in ipairs(player.deaths) do
				local maxhp = death.maxhp or player.maxhp
				winmax = math.max(winmax, maxhp)
				-- Sort log entries.
				table.sort(death.log, cmp_ts)

				for j, log in ipairs(death.log) do
					local diff = tonumber(log.ts) - tonumber(death.ts)
					-- Ignore hits older than 60s before death.
					if diff > -60 then

						local d = win.dataset[nr] or {}
						win.dataset[nr] = d

						d.id = nr
						local spellid = log.spellid or 88163 -- "Attack" spell
						local spellname = log.spellname or GetSpellInfo(spellid)
						local rspellname
						if spellid == death_spell then
							rspellname = spellname -- nicely formatted death message
						else
							rspellname = GetSpellLink(spellid) or spellname	
						end
						local label
						if log.ts >= death.ts then
							label = date("%H:%M:%S", log.ts).. ": "
						else
							label = ("%2.2f"):format(diff) .. ": "
						end
						if log.srcname then 
							label = label..log.srcname..L["'s "]
						end
						d.label =       label..spellname
						d.reportlabel = label..rspellname
						d.ts = log.ts
						d.value = log.hp or 0
						local _, _, icon = GetSpellInfo(spellid)
						d.icon = icon
						d.spellid = spellid

						local change = Skada:FormatNumber(math.abs(log.amount))
						if log.amount > 0 then
							change = "+"..change
						else
							change = "-"..change
						end

						if log.ts >= death.ts then
							d.valuetext = ""
						else
							d.valuetext = Skada:FormatValueText(
								change, self.metadata.columns.Change,
								Skada:FormatNumber(log.hp or 0), self.metadata.columns.Health,
								string.format("%02.1f%%", (log.hp or 1) / (maxhp or 1) * 100), self.metadata.columns.Percent
							)
						end

						if log.amount >= 0 then
							d.color = green
						else
							d.color = red
						end

						nr = nr + 1
					end
				end
			end

			win.metadata.maxvalue = winmax
		end
	end

	function mod:OnEnable()
		mod.metadata 		= {click1 = deathlog, columns = {Deaths = true, Timestamp = true}}
		deathlog.metadata 	= {ordersort = true, columns = {Change = true, Health = false, Percent = true}}

		Skada:RegisterForCL(UnitDied, 'UNIT_DIED', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(AuraApplied, 'SPELL_AURA_APPLIED', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(SpellDamage, 'SPELL_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(SpellDamage, 'SPELL_PERIODIC_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(SpellDamage, 'SPELL_BUILDING_DAMAGE', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(SpellDamage, 'RANGE_DAMAGE', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(SwingDamage, 'SWING_DAMAGE', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(EnvironmentalDamage, 'ENVIRONMENTAL_DAMAGE', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(Instakill, 'SPELL_INSTAKILL', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(Instakill, 'RANGE_INSTAKILL', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(SpellHeal, 'SPELL_HEAL', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(SpellHeal, 'SPELL_PERIODIC_HEAL', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(Resurrect, 'SPELL_RESURRECT', {dst_is_interesting_nopets = true})

		Skada:RegisterForCL(Missed, 'SWING_MISSED', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(Missed, 'SPELL_MISSED', {dst_is_interesting_nopets = true})
		Skada:RegisterForCL(Missed, 'RANGE_MISSED', {dst_is_interesting_nopets = true})

 		Skada:AddMode(self)
	end

	function mod:OnDisable()
		Skada:RemoveMode(self)
	end

	-- Called by Skada when a set is complete.
	function mod:SetComplete(set)
		-- Clean
	end

	function mod:AddToTooltip(set, tooltip)
		GameTooltip:AddDoubleLine(L["Deaths"], set.deaths, 1,1,1)
	end

	function mod:GetSetSummary(set)
		return set.deaths
	end

	-- Called by Skada when a new player is added to a set.
	function mod:AddPlayerAttributes(player, set)
		if set == Skada.total and not player.deathlog then
			player.deathlog = {}
		end
		player.maxhp = math.max(UnitHealthMax(player.name) or 0, player.maxhp or 0)
	end

	-- Called by Skada when a new set is created.
	function mod:AddSetAttributes(set)
		if not set.deaths then
			set.deaths = 0
		end
	end
end)

