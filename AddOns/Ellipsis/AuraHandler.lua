local Ellipsis = LibStub('AceAddon-3.0'):GetAddon('Ellipsis')

-- AURA EVENT HANDLER -------------------------------------

do
	local UnitCanAttack = _G.UnitCanAttack
	local handler

	local function AuraHandler(frame, event, unit)
		if (unit == 'target' or unit == 'focus') then
			if (UnitCanAttack('player', unit)) then
				Ellipsis:ScanAuras(unit, 'HARMFUL', true)
			else
				Ellipsis:ScanAuras(unit, 'HELPFUL', true)
			end
		else -- must be a friendly
			Ellipsis:ScanAuras(unit, 'HELPFUL')
		end
	end

	handler = CreateFrame('Frame')
	handler:SetScript('OnEvent', AuraHandler)

	function Ellipsis:ConfigureAuraScan()
		if (self.db.profile.trackBuffs or self.db.profile.trackDebuffs) then
			if (not handler:IsEventRegistered('UNIT_AURA')) then
				handler:RegisterEvent('UNIT_AURA')
			end
		else
			if (handler:IsEventRegistered('UNIT_AURA')) then
				handler:UnregisterEvent('UNIT_AURA')
			end
		end
	end
end

-- SECONDARY SCAN HANDLER ---------------------------------

do
	local handler = CreateFrame('Frame')
	local inRaid, doScanGroup
	local canScanPet, canScanGroup
	local min, max

	local unitGUIDs = {}

	local UnitExists = _G.UnitExists
	local UnitCanAttack = _G.UnitCanAttack
	local UnitGUID = _G.UnitGUID

	local targetLookup = setmetatable({}, { -- setup a unitID lookup for group and raid, populated as needed
		__index = function(t, k)
			if (k <= 40) then
				t[k] = format('raid%dtarget', k)
			else
				t[k] = format('party%dtarget', k - 40)
			end
			return t[k]
		end
	})

	local unit, guid
	local function DoSecondaryScan()
		unitGUIDs = wipe(unitGUIDs) -- clean out comparative table

		min, max = inRaid and 1 or 41, inRaid and GetNumGroupMembers() or (GetNumSubgroupMembers() + 40) -- set iterator points based on inRaid

		for x = min, max do
			unit = targetLookup[x]

			if (UnitExists(unit) and UnitCanAttack('player', unit)) then -- only existing hostile mobs (friendlies are tracked by UNIT_AURA)
				guid = UnitGUID(unit)

				if (not unitGUIDs[guid]) then -- haven't scanned this one yet
					unitGUIDs[guid] = unit -- add to compare table to avoid duplicate scans
				end
			end
		end

		for _, unitID in pairs(unitGUIDs) do
			Ellipsis:ScanAuras(unitID, 'HARMFUL', false)
		end
	end

	local throttle, rate = 0, 1.0
	local function SecondaryScan(frame, elapsed)
		throttle = throttle + elapsed

		if (throttle >= rate) then
			if (UnitExists('pettarget')) then
				Ellipsis:ScanAuras('pettarget', 'HARMFUL')
			end

			if (doScanGroup) then
				DoSecondaryScan()
			end

			throttle = throttle - rate
		end
	end

	function Ellipsis:SetSecondaryScan(inGroup, inRaid, hasPet)
		inRaid = inRaid

		if ((hasPet and canScanPet) or ((inGroup or inRaid) and canScanGroup)) then
			handler:SetScript('OnUpdate', SecondaryScan)
			doScanGroup = (canScanGroup and (inGroup or inRaid))
		else
			handler:SetScript('OnUpdate', nil)
		end
	end

	function Ellipsis:ConfigureSecondaryScan()
		canScanPet = self.db.profile.trackDebuffs
		canScanGroup = canScanPet and self.db.profile.secondaryScan
		rate = self.db.profile.secondaryScanRate
	end
end

local GetTime = _G.GetTime
local UnitHealth = _G.UnitHealth
local UnitAura = _G.UnitAura
local UnitGUID = _G.UnitGUID
local UnitIsUnit = _G.UnitIsUnit

local dntList, activeGUIDS, barMode, ghostShow, ignoreBreaksTime, minDur, maxDur, aoeSpells, trackPlayer, trackPet, showStackInName, trackBuffs, trackDebuffs
local name, icon, count, duration, expireTime, caster, index, guid, target, time, changed, percent, remains, t
local doQuery

function Ellipsis:ScanAuras(unit, auraType, isTargetFocus)
	-- Abort scanning if this is an auraType were not tracking
	if ((not trackDebuffs and auraType == 'HARMFUL') or (not trackBuffs and auraType == 'HELPFUL')) then return end

	-- Abort scanning if its the player or pet but were either not tracking them or they come from another unitID,
	-- also abort scanning if this isn't the target or focus, but the unitID is also the targer or focus (redundant scanning)
	if (UnitIsUnit('player', unit)) then
		if (not trackPlayer or unit ~= 'player') then return end
	elseif (UnitIsUnit('pet', unit)) then
		if (not trackPet or unit ~= 'pet') then return end
	elseif (not isTargetFocus) then
		if (UnitIsUnit('target', unit) or UnitIsUnit('focus', unit)) then return end
	end

	guid, index, time = UnitGUID(unit), 1, GetTime()
	target = activeGUIDS[guid] or nil

	name, _, icon, count, _, duration, expireTime, caster, _, _, spellID = UnitAura(unit, 1, auraType)
	doQuery = (caster == 'player' or caster == 'pet')

	while (name) do
		if (doQuery and duration >= minDur and duration <= maxDur and not dntList[name]) then -- this is one of our buffs we want to track, do so
			if (target and target.timers[spellID]) then -- already on target, update values
				t = target.timers[spellID]
				t.valid = time

				-- checks to see if anything major has changed about the timer, if so, update display
				if (t.ghost or t.count ~= count or t.start ~= (expireTime - duration) or t.finish ~= expireTime) then
					-- Something major has changed, update timer GUI
					percent = 1 - ((time - t.start) / (expireTime - t.start))
					remains = expireTime - time

					t.ghost = false
					t.count = count
					t.start = expireTime - duration
					t.finish = expireTime

					t.bar:SetValue(percent)
					t.spark:SetPoint('CENTER', t.bar, 'LEFT', percent * self.barWidth, 0)
					t.spark:Show()

					if (showStackInName) then
						if (t.count > 0) then
							t.nameUI:SetText(format(self.stackNameFormat, t.count, t.name))
						else
							t.nameUI:SetText(t.name)
						end
					else
						t.stack:SetText((t.count > 0 and t.count) or '')
					end

					t.time:SetFormattedText(self:GetFormattedTime(remains))
					t.border:SetVertexColor(self:GetTimerColours(remains))

					if (barMode) then
						t.time:SetTextColor(unpack(self.db.profile.colours.timertext))
						t.nameUI:SetWidth(self.barWidth - (t.time:GetStringWidth() + 6))
						t.bar:SetStatusBarColor(self:GetTimerColours(remains))
					else
						t.time:SetTextColor(self:GetTimerColours(remains))
					end
					self:UpdateTimerDisplay(guid)
				end
			elseif (not aoeSpells[spellID] and (expireTime - time) > 0.5) then
				-- not an aoe spell, not on target and not about to expire, add it (and a target if needed)
				if (not target) then
					self:CreateTarget(guid, unit, time, UnitName(unit), UnitLevel(unit), select(2, UnitClass(unit)), UnitClassification(unit), GetRaidTargetIndex(unit))
					target = activeGUIDS[guid]
				end

				self:CreateTimer(guid, spellID, name, icon, count, duration, expireTime, time)
			end
		end

		index = index + 1
		name, _, icon, count, _, duration, expireTime, caster, _, _, spellID = UnitAura(unit, index, auraType)
		doQuery = (caster == 'player' or caster == 'pet')
	end

	if (UnitHealth(unit) == 1) then return end -- Kind of a hack due to a 'final' unit_aura event being fired -just- as a mob dies (after stripping its debuffs)

	if (target) then -- this target is being tracked, check for broken timers
		changed = false
		for _, t in pairs(target.sortedTimers) do
			if (t.valid ~= time and not t.ghost and (t.finish - time) > ignoreBreaksTime) then
				-- we were tracking this timer, but it no longer exists as an active timer
				changed = true

				if (not ghostShow) then
					self:DestroyTimer(t.guid, t.spellID, false, 'broken')
				else
					t.finish = time -- to force onupdate to see this as a ghost timer as well
					self:TimerSetAsGhost(t, 'broken')
				end
			end
		end

		if (changed) then
			-- one or more timers were killed (or ghosted), update or destroy target
			if (#target.sortedTimers > 0) then
				self:UpdateTimerDisplay(guid)
			else
				self:DestroyTarget(guid)
			end
		end
	end
end

function Ellipsis:ConfigureScanAuras()
	dntList = self.db.profile.doNotTrack
	activeGUIDS = self:GetActiveGUIDS()
	barMode = (self.db.profile.mode == 'bars' and true) or false
	ghostShow = self.db.profile.ghostShow
	ignoreBreaksTime = self.db.profile.timerUpdateRate + 1.0
	minDur, maxDur = self.db.profile.minAuraDuration, self.db.profile.maxAuraDuration * 60
	if (maxDur == 0) then
		maxDur = 432000 -- Don't think theres any buffs with a duration > 5days
	else
		maxDur = maxDur + 1 -- Hack: fix an onload bug with buffs of duration equal to maxDur
	end
	aoeSpells = self.aoeSpells
	trackPlayer = self.db.profile.trackPlayer
	trackPet = self.db.profile.trackPet
	trackBuffs = self.db.profile.trackBuffs
	trackDebuffs = self.db.profile.trackDebuffs
	showStackInName = self.db.profile.showStackInName
end
