local Ellipsis = LibStub('AceAddon-3.0'):NewAddon('Ellipsis', 'AceConsole-3.0', 'AceEvent-3.0', 'LibSink-2.0')
_G.Ellipsis = Ellipsis

local L = LibStub('AceLocale-3.0'):GetLocale('Ellipsis')
local Media = LibStub('LibSharedMedia-3.0')

-- CORE DATA TABLES ---------------------------------------
local activeTimers = {} -- [1] = <timerFrame>
local activeGUIDS = {} -- [0x0001] = <targetFrame>
local sortedTargets = {} -- [1] = <targetFrame>
local prominentTargets = {} -- [1] = <targetFrame>

function Ellipsis:GetActiveTimers() return activeTimers end
function Ellipsis:GetActiveGUIDS() return activeGUIDS end
function Ellipsis:GetSortedTargets() return sortedTargets end
function Ellipsis:GetProminentTargets() return prominentTargets end
-- --------------------------------------------------------

-- TIMER ONUPDATE & MOB DEATH FUNCTIONS -------------------
do
	local handler -- main onupdate handler
	local Ellipsis, GetTime = _G.Ellipsis, _G.GetTime -- local references
	local timerList -- 'more' local reference
	local ghostShow, ghostDuration -- ghost vars
	local barWidth, iconMode -- misc vars
	local cdFunc -- cooldown onupdate function

	local function ColourByTime(remains)
		if (remains > 7.0) then -- green!
			return 0, 1, 0
		elseif (remains <= 4.0) then -- fade to red quickly
			return 1, max(remains - 3.0, 0), 0
		else -- fade to yellow quickly
			return 1 - min(remains - 6.0, 1), 1, 0
		end
	end

	local tenthString, secString, minString, hourString, tenths, formatFour -- time vars
	local function SecondsToTime(remains)
		if (remains < 10 and tenths) then
			return tenthString, remains
		elseif (remains < 61) then
			return secString, remains
		elseif (remains < 3601) then
			if (formatFour) then
				return minString, floor(remains / 60) -- special case if using timer format 4 (only 1 value)
			else
				return minString, floor(remains / 60), mod(remains, 60)
			end
		else
			return hourString, floor(remains / 3600) -- special case for 1hr+ entries, no precision
		end
	end

	local throttle, rate, percent, remains, current = 0, 0.1, 0, 0, 0
	local function TimerUpdate(frame, elapsed)
		throttle = throttle + elapsed

		if (throttle >= rate) then
			current = GetTime()

			cdFunc(current)

			for _, t in pairs(timerList) do
				percent = 1 - ((current - t.start) / (t.finish - t.start))
				remains = t.finish - current

				if (remains > 7.0) then
					t.bar:SetValue(percent)
					t.spark:SetPoint('CENTER', t.bar, 'LEFT', percent * barWidth, 0)
					t.time:SetFormattedText(SecondsToTime(remains))
					t.nameUI:SetWidth(barWidth - (t.time:GetStringWidth() + 6))
				elseif (remains > 0) then
					t.bar:SetValue(percent)
					t.bar:SetStatusBarColor(ColourByTime(remains))
					t.spark:SetPoint('CENTER', t.bar, 'LEFT', percent * barWidth, 0)
					t.border:SetVertexColor(ColourByTime(remains))
					t.time:SetFormattedText(SecondsToTime(remains))
					t.nameUI:SetWidth(barWidth - (t.time:GetStringWidth() + 6))
					if (iconMode) then t.time:SetTextColor(ColourByTime(remains)) end
				elseif (remains > -1.0) then
					if (not ghostShow) then
						Ellipsis:DestroyTimer(t.guid, t.spellID, true, 'expired')
					elseif (not t.ghost) then
						Ellipsis:TimerSetAsGhost(t, 'expired')
					end
				elseif (remains <= ghostDuration) then
					Ellipsis:DestroyTimer(t.guid, t.spellID, true)
				end
			end

			throttle = throttle - rate
		end
	end

	-- This is included here for speed mainly, as it saves on a few table lookups on a rapidly firing event
	local function CLEUEvent(frame, event, time, cleuEvent, hC, sguid, sname, sflags, srflags, dguid)
		if (cleuEvent == 'UNIT_DIED' and activeGUIDS[dguid]) then
			Ellipsis:DestroyTarget(dguid)
		end
	end

	-- External Accessors (used occasionally) -------------
	function Ellipsis:GetFormattedTime(remains)
		return SecondsToTime(remains)
	end

	function Ellipsis:GetTimerColours(remains)
		return ColourByTime(remains)
	end

	-- OnUpdate Configuration -----------------------------
	function Ellipsis:TimerUpdateActive(active)
		if (active) then
			if (not handler:IsVisible()) then handler:Show() end
			if (not handler:IsEventRegistered('COMBAT_LOG_EVENT_UNFILTERED')) then
				handler:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
			end
		else
			handler:Hide()
			if (handler:IsEventRegistered('COMBAT_LOG_EVENT_UNFILTERED')) then
				handler:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
			end
		end
	end

	function Ellipsis:ConfigureTimerUpdate()
		if (not handler) then
			handler = CreateFrame('Frame')
			handler:SetScript('OnUpdate', TimerUpdate)
			handler:SetScript('OnEvent', CLEUEvent)
			handler:Hide()
			cdFunc = self:GetCDOnUpdateFunction()
		end

		rate = self.db.profile.timerUpdateRate -- hope it wasn't a bad idea to let this be configured

		timerList = activeTimers
		ghostShow = self.db.profile.ghostShow
		ghostDuration = -(self.db.profile.ghostDuration)
		barWidth = self.barWidth
		iconMode = (self.db.profile.mode == 'icons') and true or false

		tenths = self.db.profile.showTenths
		tenthString, secString, minString, hourString, formatFour = self:GetFormattedTimeStrings()
		formatFour = (formatFour == 4 and true) or false
	end
end

-- 'GLOBAL' VARIABLES -------------------------------------

Ellipsis.barWidth = nil
Ellipsis.aoeSpells = {}
Ellipsis.uniqueSpells = {}
Ellipsis.cooldownGroups = {}
Ellipsis.specialSpell = ''
Ellipsis.isShaman = false
Ellipsis.isWarlock = false
Ellipsis.totemGroups = {}
Ellipsis.stackNameFormat = '(%d) %s'
Ellipsis.playerGUID = 0

-- INITIALIZATION AND EVENT HOOKS -------------------------

function Ellipsis:OnInitialize()
	self:InitializeGUI() -- build the base gui
	self:MediaRegistration() -- register built-in LibSharedMedia entries
	self:InitializeConfig() -- setup configuration options
end

function Ellipsis:OnEnable()
	-- Most loading pushed back to OnEnable due to some missing data (player GUID mainly) when init is called.
	self.playerGUID = UnitGUID('player') -- constant after init

	self:DefineClassSpells()
	self:InitializeCooldowns() -- not technically an init, but it is only done once
	self:ApplyConfigSettings() -- also called when config is changed

	self:RegisterEvent('GROUP_ROSTER_UPDATE')
	self:RegisterEvent('PLAYER_ALIVE')
	self:RegisterEvent('PLAYER_FOCUS_CHANGED')
	self:RegisterEvent('PLAYER_REGEN_ENABLED')
	self:RegisterEvent('PLAYER_TARGET_CHANGED')
	self:RegisterEvent('UNIT_PET')
	self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')

	if (self.isShaman) then
		self:RegisterEvent('PLAYER_TOTEM_UPDATE') -- used for totem destruction
	end
end

local inGroup, inRaid, hasPet = false, false, false

function Ellipsis:GROUP_ROSTER_UPDATE()
	if (IsInRaid()) then
		if (not inRaid) then
			inGroup, inRaid = false, true
			self:SetSecondaryScan(false, true, hasPet)
		end
	elseif(IsInGroup()) then
		if (not inGroup) then
			inGroup, inRaid = true, false
			self:SetSecondaryScan(true, false, hasPet)
		end
	else -- not in a group or raid
		if (inGroup or inRaid) then
			inGroup, inRaid = false, false
			self:SetSecondaryScan(false, false, hasPet)
		end
	end
end

function Ellipsis:PLAYER_ALIVE()
	if (UnitIsGhost('player')) then
		self:DestroyAllTargets(true) -- player has died and released, kill all timers
	end
end

function Ellipsis:PLAYER_FOCUS_CHANGED()
	if (self.db.profile.sortTarget or self.db.profile.sortFocus) then
		self:UpdateTargetDisplay(sortedTargets, self.targetAnchor)
	end

	if (UnitExists('focus')) then
		if (not UnitIsDeadOrGhost('focus')) then
			if (UnitCanAttack('player', 'focus')) then
				self:ScanAuras('focus', 'HARMFUL', true)
			else
				self:ScanAuras('focus', 'HELPFUL', true)
			end
		end

		if (self.db.profile.showRaidIcons) then
			self:UpdateRaidIcons('focus')
		end

	end
end

function Ellipsis:PLAYER_TARGET_CHANGED()
	if (self.db.profile.sortTarget or self.db.profile.sortFocus) then
		self:UpdateTargetDisplay(sortedTargets, self.targetAnchor)
	end

	if (UnitExists('target')) then
		if (not UnitIsDeadOrGhost('target')) then
			if (UnitCanAttack('player', 'target')) then
				self:ScanAuras('target', 'HARMFUL', true)
			else
				self:ScanAuras('target', 'HELPFUL', true)
			end
		end

		if (self.db.profile.showRaidIcons) then
			self:UpdateRaidIcons('target')
		end
	end
end

function Ellipsis:PLAYER_TOTEM_UPDATE()
	if (activeGUIDS['notarget']) then -- make sure we have some timers to check
		local aoeTimers = activeGUIDS['notarget'].timers

		for totem, group in pairs(self.totemGroups) do
			if (aoeTimers[totem] and select(3, GetTotemInfo(group)) == 0) then
				-- timer active for totem of group X, but no totem of that type exists, kill timer
				self:DestroyTimer('notarget', totem, true)
			end
		end
	end
end

function Ellipsis:PLAYER_REGEN_ENABLED()
	self:DestroyAllTargets(false) -- player has left combat, destroy all timers
end

do
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

	local groupLookup = setmetatable({}, {
		__index = function(t, k)
			if (k<= 40) then
				t[k] = format('raid%d', k)
			else
				t[k] = format('party%d', k - 40)
			end
			return t[k]
		end
	})

	local miscLookup = {player = true, target = true, focus = true, pet = true, pettarget = true}
	local checkedGUIDs = {}

	local unitID, unit, guid, icon, min, max
	local UnitGUID, GetRaidTargetIndex = _G.UnitGUID, _G.GetRaidTargetIndex

	function Ellipsis:RAID_TARGET_UPDATE()
		checkedGUIDs = wipe(checkedGUIDs) -- clean out comparative table

		if (inGroup or inRaid) then
			min, max = inRaid and 1 or 41, inRaid and GetNumGroupMembers() or (GetNumSubgroupMembers() + 40) -- set iterator points based on inRaid

			for id = min, max do
				unitID = groupLookup[id]
				unit = activeGUIDS[UnitGUID(unitID)]

				if (unit) then -- we're tracking this unit, check for raid icon change
					icon = GetRaidTargetIndex(unitID) or 0

					if (unit.raidicon ~= icon) then -- raid icon has changed
						unit.raidicon = icon
						self:SetTargetText(unit)
					end
				end

				unitID = targetLookup[id]
				guid = UnitGUID(unitID)
				unit = activeGUIDS[guid]

				if (unit and not checkedGUIDs[guid]) then
					icon = GetRaidTargetIndex(unitID) or 0

					if (unit.raidicon ~= icon) then -- raid icon has changed
						unit.raidicon = icon
						self:SetTargetText(unit)
					end

					checkedGUIDs[guid] = true
				end
			end
		end

		for unitID in pairs(miscLookup) do
			unit = activeGUIDS[UnitGUID(unitID)]

			if (unit) then
				icon = GetRaidTargetIndex(unitID) or 0

				if (unit.raidicon ~= icon) then -- raid icon has changed
					unit.raidicon = icon
					self:SetTargetText(unit)
				end
			end
		end
	end
end

function Ellipsis:UNIT_PET(event, unit)
	if (unit ~= 'player') then return end

	if (UnitExists('pet')) then
		if (not hasPet) then
			hasPet = true
			self:SetSecondaryScan(inGroup, inRaid, true)
		end
	else
		if (hasPet) then
			hasPet = false
			self:SetSecondaryScan(inGroup, inRaid, false)

			if (self.isWarlock) then
				-- If an enslave timer is running, its broken now, make sure the mod knows it
				local control = self.specialSpell
				for _, v in pairs(activeTimers) do
					if (v.spellID == control) then -- Enslave was running, its now broken!
						self:DestroyTimer(v.guid, v.spellID, true, 'broken')
						break
					end
				end
			end

			-- If were tracking pet buffs, remove the 'old' pet (because the new one will have a different guid)
			if (self.db.profile.trackPet) then
				for k, v in pairs(activeGUIDS) do
					if (v.created == 2) then -- this is a pet 'target'
						self:DestroyTarget(k)
						break
					end
				end
			end
		end
	end
end

local GetTime = _G.GetTime

function Ellipsis:UNIT_SPELLCAST_SUCCEEDED(event, unit, name, rank, lID, spellID)
	if (unit ~= 'player') then return end

	local time = GetTime()

	if (self.aoeSpells[spellID] and not self.db.profile.doNotTrack[name]) then -- aoe spell we want to track
		if (not activeGUIDS['notarget']) then
			self:CreateTarget('notarget', 'notarget', 0, L.NoTarget, -2, nil, nil, nil) -- No 'no target' entry yet, make one
		end

		local aoe = self.aoeSpells[spellID]

		-- Clear old aoe timer(s) out if present (in ghost form most likely)
		if (activeGUIDS['notarget']) then
			if (not self.isShaman) then
				if (activeGUIDS['notarget'].timers[spellID]) then
					self:DestroyTimer('notarget', spellID, false)
				end
			else
				-- shaman totem handling
				if (self.totemGroups[spellID]) then -- casting a totem, clear any other totems of this type
					local totemType = self.totemGroups[spellID]
					for spell in pairs(activeGUIDS['notarget'].timers) do
						if (self.totemGroups[spell] == totemType) then
							-- totem of the same type as the cast, kill it
							self:DestroyTimer('notarget', spell, false)
						end
					end
				end
			end
		end

		-- Create appropriate timer
		if (self.isShaman and self.totemGroups[spellID]) then
			self:CreateTimer('notarget', spellID, name, aoe[2], 0, aoe[1], time + aoe[1], time, self.totemGroups[spellID])
		else
			self:CreateTimer('notarget', spellID, name, aoe[2], 0, aoe[1], time + aoe[1], time)
		end
	end
end

-- TARGET CREATION & DESTRUCTION --------------------------

function Ellipsis:CreateTarget(guid, unit, created, name, level, class, classification, icon)
	if (activeGUIDS[guid]) then return end

	local t = self:GetTargetFrame()

	-- set local variables
	t.guid = guid
	t.name = name
	t.class = class or 'WARRIOR'
	t.raidicon = icon or 0
	t.created = (guid == self.playerGUID and 1) or (guid == UnitGUID('pet') and 2) or created

	if (level == -1 or level == 0) then
		if (classification == 'worldboss') then
			t.level = UnitLevel('player') + 3
		else
			t.level = '??'
		end
	elseif (level == -2) then
		t.level = 0 -- special case for 'no target'
	else
		t.level = level
	end

	-- set gui
	self:SetTargetText(t)
	self:SetTargetTextColour(t)

	-- add target to data tables
	activeGUIDS[guid] = t

	-- add to appropriate sorting list based on prominence settings
	if (self.db.profile.prominentItems[unit]) then
		-- this unit is prominent, add to prominent list
		t.prominent = true
		tinsert(prominentTargets, t)
		self:UpdateTargetDisplay(prominentTargets, self.prominenceAnchor)
	else
		-- this unit isn't prominent, add to standard list
		t.prominent = false
		tinsert(sortedTargets, t)
		self:UpdateTargetDisplay(sortedTargets, self.targetAnchor)
	end
end

function Ellipsis:DestroyTarget(guid)
	local target = activeGUIDS[guid] -- local reference for handling
	local timers = target.sortedTimers

	-- remove all active timers
	while(#timers > 0) do
		self:DestroyTimer(guid, timers[1].spellID, false)
	end


	-- remove from appropriate sorted list and update gui
	if (target.prominent) then
		for k, v in pairs(prominentTargets) do
			if (v.guid == guid) then
				tremove(prominentTargets, k)
				break
			end
		end
		self:UpdateTargetDisplay(prominentTargets, self.prominenceAnchor)
	else
		for k, v in pairs(sortedTargets) do
			if (v.guid == guid) then
				tremove(sortedTargets, k)
				break
			end
		end
		self:UpdateTargetDisplay(sortedTargets, self.targetAnchor)
	end

	-- remove from final data table and release frame
	activeGUIDS[guid] = nil
	self:ReleaseTargetFrame(target)
end

function Ellipsis:DestroyAllTargets(playerDead)
	if (playerDead) then
		-- kill no target, player, pet and hostile timers on player death
		for guid, t in pairs(activeGUIDS) do
			if (t.created < 3 or bit.band(0x00F0000000000000, guid) == 0x0030000000000000) then
				self:DestroyTarget(guid)
			end
		end
	else
		-- kill only hostile timers on combat end
		for guid, t in pairs(activeGUIDS) do
			if (t.created > 2 and bit.band(0x00F0000000000000, guid) == 0x0030000000000000) then
				self:DestroyTarget(guid)
			end
		end
	end
end

do
	local targetGUID, focusGUID, aC, bC

	local function SortTargets(a, b)
		aC = (a.created > 2 and ((a.guid == targetGUID and 3) or (a.guid == focusGUID and 4))) or a.created
		bC = (b.created > 2 and ((b.guid == targetGUID and 3) or (b.guid == focusGUID and 4))) or b.created

		return aC < bC
	end

	function Ellipsis:UpdateTargetDisplay(targetList, anchor)
		if (#sortedTargets < 1 and #prominentTargets < 1) then
			self:TimerUpdateActive(false or self:GetNumActiveCDTimers() > 0)
			return
		end

		targetGUID = self.db.profile.sortTarget and UnitGUID('target') or 0
		focusGUID = self.db.profile.sortFocus and UnitGUID('focus') or 0

		table.sort(targetList, SortTargets)

		self:AnchorTargets(targetList, anchor, targetGUID, focusGUID)

		self:TimerUpdateActive(true)
	end
end

-- TIMER CREATION & DESTRUCTION ---------------------------

function Ellipsis:CreateTimer(guid, spellID, name, texture, count, duration, expiryTime, currentTime, totemGroup)
	if (activeGUIDS[guid].timers[spellID]) then return end

	local t = self:GetTimerFrame()
	if (activeGUIDS[guid].hidden) then t:Hide() else t:Show() end -- set visibility based on parent target

	-- set local variables
	t.guid = guid
	t.spellID = spellID
	t.name = name
	t.count = count
	t.start = expiryTime - duration
	t.finish = expiryTime
	t.valid = currentTime
	t.ghost = false -- not a ghost timer!

	-- if this is a totem, set totem variable for cancellation options
	if (totemGroup) then
		t.totemType = totemGroup
	else
		t.totemType = false
	end

	local percent = 1 - ((currentTime - t.start) / (expiryTime - t.start))
	local remains = expiryTime - currentTime

	-- set gui
	t.bar:SetValue(percent)
	t.spark:SetPoint('CENTER', t.bar, 'LEFT', percent * self.barWidth, 0)
	t.spark:Show()

	if (self.db.profile.showStackInName) then
		if (t.count > 0) then
			t.nameUI:SetText(format(self.stackNameFormat, t.count, name))
		else
			t.nameUI:SetText(t.spell)
		end
		t.stack:SetText('')
	else
		t.nameUI:SetText(name)
		t.stack:SetText((t.count > 0 and t.count) or '')
	end

	t.time:SetFormattedText(self:GetFormattedTime(remains))
	t.border:SetVertexColor(self:GetTimerColours(remains))
	t.icon:SetTexture(texture)

	if (self.db.profile.mode == 'bars') then
		t.time:SetTextColor(unpack(self.db.profile.colours.timertext))
		t.nameUI:SetWidth(self.barWidth - (t.time:GetStringWidth() + 6))
		t.bar:SetStatusBarColor(self:GetTimerColours(remains))
	elseif (self.db.profile.mode == 'icons') then
		t.time:SetTextColor(self:GetTimerColours(remains))
	end

	-- add timer to data tables
	activeGUIDS[guid].timers[spellID] = t
	tinsert(activeGUIDS[guid].sortedTimers, t)
	tinsert(activeTimers, t)

	-- if this is a 'unique' spell, then kill any other instances of it (count them as breaks)
	if (self.uniqueSpells[spellID]) then
		for _, v in pairs(activeTimers) do
			if (v.spellID == spellID and v.guid ~= guid) then
				-- found the spell on a different mob, naughty! ... kill it
				self:DestroyTimer(v.guid, v.spellID, true, 'expired')
				break
			end
		end
	end

	self:UpdateTimerDisplay(guid)
end

function Ellipsis:DestroyTimer(guid, spellID, updateGUI, reason)
	local target = activeGUIDS[guid]
	local timer = target.timers[spellID]

	-- remove from data tables
	for k, v in ipairs(activeTimers) do
		if (v.guid == guid and v.spellID == spellID) then
			tremove(activeTimers, k)
			break
		end
	end
	for k, v in ipairs(target.sortedTimers) do
		if (v.spellID == spellID) then
			tremove(target.sortedTimers, k)
			break
		end
	end

	if (reason) then
		self:Notification(reason, timer.name, target.name)
		self:PlaySound(reason)
	end

	target.timers[spellID] = nil

	if (updateGUI) then
		if (#target.sortedTimers == 0) then -- this was the last timer on a target, destroy it
			self:DestroyTarget(guid)
		else -- some remaining timers, update display
			self:UpdateTimerDisplay(guid)
		end
	end

	self:ReleaseTimerFrame(timer)
end

function Ellipsis:TimerSetAsGhost(t, reason)
	t.ghost = true
	t.time:SetText('')
	t.nameUI:SetWidth(self.barWidth - (t.time:GetStringWidth() + 6))
	t.nameUI:SetText(t.name)
	t.border:SetVertexColor(unpack(self.db.profile.colours.ghost))
	t.bar:SetStatusBarColor(unpack(self.db.profile.colours.ghost))
	t.bar:SetValue(1)
	t.spark:Hide()
	t.stack:SetText('')

	if (reason) then
		self:Notification(reason, t.name, activeGUIDS[t.guid].name)
		self:PlaySound(reason)
	end
end

do
	local sortMethod

	local function SortTimers(a, b)
		if (sortMethod == 1) then
			return a.name < b.name
		elseif (sortMethod == 2) then
			return a.name > b.name
		elseif (sortMethod == 3) then
			return a.finish < b.finish
		else -- sortMethod == 4
			return a.finish > b.finish
		end
	end

	function Ellipsis:UpdateTimerDisplay(guid)
		local target = activeGUIDS[guid]

		sortMethod = self.db.profile.sortTimerMethod

		if (sortMethod ~= 5) then
			table.sort(target.sortedTimers, SortTimers)
		end

		self:AnchorTimersAndSizeTarget(target, target.sortedTimers)
	end
end

-- UTILITY FUNCTIONS --------------------------------------

function Ellipsis:UpdateRaidIcons(unit)
	local guid = UnitGUID(unit)

	if (activeGUIDS[guid]) then
		local t, icon = activeGUIDS[guid], GetRaidTargetIndex(unit) or 0

		if (icon ~= t.raidicon) then
			-- icon has changed, update display and ensure no other target has this icon
			t.raidicon = icon
			self:SetTargetText(t)

			for k, v in pairs(activeGUIDS) do
				if (v.guid ~= guid and v.raidicon == icon) then
					-- this is not the updated unit, but it has its icon, remove icon
					v.raidicon = 0
					self:SetTargetText(v)
				end
			end
		end
	end
end

function Ellipsis.TimerOnClick(frame, button)
	if (button == 'LeftButton') then
		if (IsInRaid()) then
			Ellipsis:TimerAnnounce(frame, 'RAID')
		elseif (IsInGroup()) then
			Ellipsis:TimerAnnounce(frame, 'PARTY')
		else
			Ellipsis:TimerAnnounce(frame, 'SAY')
		end
	elseif (button == 'RightButton') then
		if (IsShiftKeyDown()) then
			Ellipsis:DoNotTrackAddition(frame.name)
		elseif (IsControlKeyDown()) then
			if (frame.totemType) then
				DestroyTotem(frame.totemType)
			end
		end
        -- XXX 163
        Ellipsis:DestroyTimer(frame.guid, frame.spellID, true, nil)
	end
end

function Ellipsis:TimerAnnounce(frame, channel)
	local remains = floor(frame.finish - GetTime())
	local min, sec = floor(remains / 60), mod(remains, 60)

	if (frame.guid == 'notarget') then -- aoe spell
		if (remains < 0) then
			SendChatMessage(format(L.TimerAnnounceAoeGhost, frame.name), channel)
		else
			SendChatMessage(format(L.TimerAnnounceAoeActive, frame.name, min, sec), channel)
		end
	else -- any other spell
		if (remains < 0) then
			SendChatMessage(format(L.TimerAnnounceNormalGhost, frame.name, activeGUIDS[frame.guid].name), channel)
		else
			SendChatMessage(format(L.TimerAnnounceNormalActive, frame.name, activeGUIDS[frame.guid].name, min, sec), channel)
		end
	end
end

function Ellipsis:DoNotTrackAddition(dnt)
	-- check to see if this is an item link
	local found, _, item = string.find(dnt, '|c.+|h(.+)|h|r')

	if (found and item ~= nil) then
		dnt = item -- it is
	end

	-- check for brackets and/or rank details and strip them
	dnt = string.gsub(dnt, '%[', '')
	dnt = string.gsub(dnt, '%]', '')
	dnt = string.gsub(dnt, '%(%w+ %d+%)', '')

	if (not self.db.profile.doNotTrack[dnt]) then
		self.db.profile.doNotTrack[dnt] = true

		for k, v in ipairs(self:GetActiveTimers()) do
			if (v.spell == dnt) then
				self:DestroyTimer(v.guid, v.spellID, true)
			end
		end

		self:Print(format(L.DNTWontTrack, dnt))
	end
end

do
	local lastPlayed = {
		['expired'] = 0,
		['broken'] = 0,
		['cdexpired'] = 0
	}

	function Ellipsis:PlaySound(reason)
		if (self.db.profile.playSounds) then
			local time = GetTime()
			if ((time - lastPlayed[reason]) <= 0.1) then return end -- Abort if this sound has just been played (and probably still is playing)

			lastPlayed[reason] = time

			PlaySoundFile(Media:Fetch('sound', self.db.profile.sounds[reason]))
		end
	end
end

function Ellipsis:Notification(reason, name, target)
	if (reason == 'expired' and self.db.profile.notifyExpire) then
		self:Pour(format(L.NotifyExpiredTimer, name, target))
	elseif (reason == 'broken' and self.db.profile.notifyBreak) then
		self:Pour(format(L.NotifyBrokenTimer, name, target))
	elseif (reason == 'cdexpired' and self.db.profile.notifyCDExpire) then
		self:Pour(format(L.NotifyCDExpiredTimer, name))
	end
end
