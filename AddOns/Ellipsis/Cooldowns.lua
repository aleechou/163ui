local Ellipsis = LibStub('AceAddon-3.0'):GetAddon('Ellipsis')
local L = LibStub('AceLocale-3.0'):GetLocale('Ellipsis')

-- CORE COOLDOWN DATA -------------------------------------
local activeCDTimers = {} -- [name] = <framehandler>
local numActiveCDTimers = 0
local spellCooldowns = {} -- [name|group] = <info>
local petCooldowns = {}
local noCDTracked = false

function Ellipsis:GetSpellCooldowns()
	return spellCooldowns
end

function Ellipsis:GetPetSpellCooldowns()
	return petCooldowns
end

function Ellipsis:GetActiveCDTimers() return activeCDTimers end
function Ellipsis:GetNumActiveCDTimers() return numActiveCDTimers end

-- TIMER ONUPDATE FUNCTIONS -------------------------------

do
	local math_pow = math.pow
	local math_min = math.min
	local maxTime, endCap, workingLength, anchor, horz, baseSize, timers
	local loc, pulse

	local function PositionTimer(t, time)
		loc = math_pow((t.finish - time) / maxTime, 0.4) * workingLength

		if (horz) then
			t:SetPoint('CENTER', bar, 'LEFT', endCap + math_min(loc, workingLength), t.offset)
		else
			t:SetPoint('CENTER', bar, 'BOTTOM', t.offset, endCap + math_min(loc, workingLength))
		end
	end

	local function CDOnUpdate(time)
		for name, t in pairs(timers) do
			if (not t.inPulse) then -- not in pulse
				if (t.finish > time) then -- timer still counting down
					PositionTimer(t, time)
				else -- timer has expired
					Ellipsis:TimerSetInPulse(t)
				end
			else -- in pulse
				if (time - t.finish >= 1.0) then -- finished pulsing
					Ellipsis:DestroyCDTimer(t.spell)
				else
					pulse = time - t.finish
					t:SetHeight(baseSize * (1 + (2 * pulse)))
					t:SetWidth(baseSize * (1 + (2 * pulse)))
					t:SetAlpha(1 - pulse)
				end
			end
		end
	end

	-- OnUpdate Configuration
	function Ellipsis:ConfigureCDTimerUpdate()
		maxTime = self.db.profile.cdMaxTimeDisplay
		endCap = self.db.profile.cdThickness / 2
		workingLength = self.db.profile.cdLength - (endCap * 2)
		horz = self.db.profile.cdHorizontal
		bar = self.cooldownAnchor.bar
		baseSize = endCap * 2
		timers = self:GetActiveCDTimers()
	end

	-- External Accessors
	function Ellipsis:PositionTimer(t, time)
		PositionTimer(t, time)
	end

	function Ellipsis:GetCDOnUpdateFunction()
		return CDOnUpdate
	end
end

-- INITIALIZATION AND EVENT HOOKS -------------------------

function Ellipsis:InitializeCooldowns()
	self:RegisterEvent('LEARNED_SPELL_IN_TAB', 'PopulatePlayerSpellCooldowns')
	self:RegisterEvent('CHARACTER_POINTS_CHANGED', 'PopulatePlayerSpellCooldowns')
	self:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED', 'PopulatePlayerSpellCooldowns')
	self:RegisterEvent('PLAYER_SPECIALIZATION_CHANGED', 'PopulatePlayerSpellCooldowns')
	self:RegisterEvent('SPELLS_CHANGED', 'PopulatePetSpellCooldowns')
	self:RegisterEvent('PET_TALENT_UPDATE', 'PopulatePetSpellCooldowns')

	self:PopulatePlayerSpellCooldowns()
	self:PopulatePetSpellCooldowns()
end

do
	local GetSpellCooldown = _G.GetSpellCooldown
	local GetInventoryItemCooldown = _G.GetInventoryItemCooldown
	local GetContainerItemCooldown = _G.GetContainerItemCooldown
	local GetInventoryItemLink, GetContainerItemLink = _G.GetInventoryItemLink, _G.GetContainerItemLink
	local GetInventoryItemTexture = _G.GetInventoryItemTexture
	local GetContainerNumSlots = _G.GetContainerNumSlots
	local GetItemInfo, GetItemIcon = _G.GetItemInfo, _G.GetItemIcon
	local GetTime = _G.GetTime
	local strfind = _G.strfind
	local math_max = math.max
	local BT_SPELL, BT_PET = BOOKTYPE_SPELL, BOOKTYPE_PET
	local bTime, bStart, bDur, bT
	local pTime, pStart, pDur, pT
	local sTime, sStart, sDur, sT
	local minTime, maxTime, cdDoNotTrack, name

	function Ellipsis:BAG_UPDATE_COOLDOWN()
		bTime = GetTime()

		for slot = 1, 19 do
			bStart, bDur = GetInventoryItemCooldown('player', slot)

			if (bDur >= minTime and bDur <= maxTime) then
				name = GetItemInfo(GetInventoryItemLink('player', slot))

				if (not cdDoNotTrack[name]) then -- only continue if we want to track this cooldown
					bT = activeCDTimers[name] or self:CreateCDTimer(name, GetInventoryItemTexture('player', slot), bDur, bStart, bTime, 3)
					bT.valid = bTime
				end
			end
		end

		for bag = 0, 4 do
			for slot = 1, GetContainerNumSlots(bag) do
				bStart, bDur = GetContainerItemCooldown(bag, slot)

				if (bDur >= minTime and bDur <= maxTime) then
					name = GetItemInfo(GetContainerItemLink(bag, slot))

					if (not cdDoNotTrack[name]) then -- only continue if we want to track this cooldown
						bT = activeCDTimers[name] or self:CreateCDTimer(name, GetItemIcon(GetContainerItemLink(bag, slot)), bDur, bStart, bTime, 3)
						bT.valid = bTime
					end
				end
			end
		end

		-- No need to kill timers in this function, theres no way (I know of) to alter item cooldowns
	end

	function Ellipsis:PET_BAR_UPDATE_COOLDOWN()
		pTime = GetTime()

		for name, data in pairs(petCooldowns) do
			pStart, pDur = GetSpellCooldown(data.spellID)

			if (pDur >= minTime and pDur <= maxTime and not cdDoNotTrack[name]) then
				pT = activeCDTimers[name] or self:CreateCDTimer(name, data.icon, pDur, pStart, pTime, 2)
				pT.valid = pTime
			end
		end

		for _, t in pairs(activeCDTimers) do
			if (t.cdType == 2 and t.valid ~= pTime and not t.inPulse) then -- its gone (and not already pulsing), begin the pulse!
				self:TimerSetInPulse(t)
			end
		end
	end

	function Ellipsis:SPELL_UPDATE_COOLDOWN()
		sTime = GetTime()

		for name, data in pairs(spellCooldowns) do
			sStart, sDur = GetSpellCooldown(data.spellID)

			if (not cdDoNotTrack[name]) then
				sT = activeCDTimers[name] or nil

				if (sT) then
					sT.valid = sTime
					if (sT.finish > sTime) then
						sT.finish = sStart + sDur
					end
				elseif (sDur >= minTime and sDur <= maxTime) then
					self:CreateCDTimer(name, data.icon, sDur, sStart, sTime, 1)
				end
			end
		end

		for _, t in pairs(activeCDTimers) do
			if (t.cdType == 1 and t.valid ~= sTime and not t.inPulse) then -- its gone (and not already pulsing), begin the pulse!
				self:TimerSetInPulse(t)
			end
		end
	end

	function Ellipsis:ConfigureCDEventHooks()
		minTime, maxTime = self.db.profile.cdMinDuration, self.db.profile.cdMaxDuration * 60
		if (maxTime == 0) then maxTime = 432000 end -- Don't think theres any cooldowns with a duration > 5 days
		cdDoNotTrack = self.db.profile.cdDoNotTrack
	end
end

-- CONFIGURATION ------------------------------------------

do
	local function EventRegistration(event, register)
		if (register) then
			Ellipsis:RegisterEvent(event)
		else
			Ellipsis:UnregisterEvent(event)
		end
	end

	function Ellipsis:ConfigureCooldowns()
		EventRegistration('BAG_UPDATE_COOLDOWN', self.db.profile.cdItem)
		EventRegistration('PET_BAR_UPDATE_COOLDOWN', self.db.profile.cdPet)
		EventRegistration('SPELL_UPDATE_COOLDOWN', self.db.profile.cdSpell)

		-- if no cd's are being tracked, autohide the cooldown bar
		noCDTracked = (not self.db.profile.cdItem) and (not self.db.profile.cdPet) and (not self.db.profile.cdSpell)

		self:ConfigureCDTimerUpdate()
		self:ConfigureCDBarUpdate()
		self:ConfigureCDEventHooks()

		if (self.db.profile.cdItem) then self:BAG_UPDATE_COOLDOWN() end
		if (self.db.profile.cdPet) then self:PET_BAR_UPDATE_COOLDOWN() end
		if (self.db.profile.cdSpell) then self:SPELL_UPDATE_COOLDOWN() end
	end
end

function Ellipsis:ConfigureCDBarUpdate()
	if (numActiveCDTimers > 0) then
		self:TimerUpdateActive(true)
		self.cooldownAnchor:Show() -- show cd bar
	else
		self:TimerUpdateActive(#(self:GetSortedTargets()) > 0 or #(self:GetProminentTargets()) > 0 or false)

		if (self.db.profile.cdHideWhenNone or noCDTracked) then
			self.cooldownAnchor:Hide()
		else
			self.cooldownAnchor:Show()
		end
	end
end

-- TIMER CREATION & DESTRUCTION ---------------------------

function Ellipsis:CreateCDTimer(name, texture, duration, startTime, currentTime, cdType)
	if (activeCDTimers[name]) then return end

	local t = self:GetCDTimerFrame()

	t.spell = name
	t.start = startTime
	t.finish = startTime + duration
	t.cdType = cdType
	t.valid = currentTime
	t.inPulse = false

	-- set the gui
	t:SetAlpha(1.0)
	t:SetHeight(self.db.profile.cdThickness)
	t:SetWidth(self.db.profile.cdThickness)
	t.icon:SetTexture(texture)
	t:Show()

	-- set the tag and offset
	self:ConfigureCDTag(t)

	-- position timer
	self:PositionTimer(t, currentTime)

	-- add to data table
	numActiveCDTimers = numActiveCDTimers + 1
	activeCDTimers[name] = t

	-- setup display and onupdate activation
	self:ConfigureCDBarUpdate()

	return t
end

function Ellipsis:DestroyCDTimer(name)
	local timer = activeCDTimers[name]

	numActiveCDTimers = numActiveCDTimers - 1

	self:ReleaseCDTimerFrame(timer)

	activeCDTimers[name] = nil

	self:ConfigureCDBarUpdate() -- setup display and onupdate activation
end

-- okay the pulse functions just grows all its timers a certain size every 'tick' until X econds have passed
-- if its done it removes itself from the list and cancels the pulse onupdate


function Ellipsis:TimerSetInPulse(t)
	t.inPulse = true

	-- ensure the timer is at the 'end' of he bar for a proper pulse
	t.finish = GetTime()
	self:PositionTimer(t, t.finish)

	-- notifications and sounds
	self:PlaySound('cdexpired')
	self:Notification('cdexpired', t.spell, nil)
end

-- SPELL COOLDOWN DATA POPULATION -------------------------

do
	local find = _G.strfind
	local GetSpellBookItemName, GetSpellBookItemInfo, GetSpellTexture = _G.GetSpellBookItemName, _G.GetSpellBookItemInfo, _G.GetSpellTexture
	local BT_SPELL, BT_PET = BOOKTYPE_SPELL, BOOKTYPE_PET
	local tip, tipRight2, tipRight3, tipRight4
	local tr2Text, tr3Text, tr4Text

	local function BuildScanningTooltip()
		local tooltip = CreateFrame('GameTooltip', 'EllipsisScanningTooltip')
		Ellipsis.scanningTip = tooltip
		tooltip:SetOwner(WorldFrame, 'ANCHOR_NONE')
		for x = 1, 4 do
			tooltip:AddFontStrings(
				tooltip:CreateFontString('$parentTextLeft' .. x, nil, 'GameTooltipText'),
				tooltip:CreateFontString('$parentTextRight' .. x, nil, 'GameTooltipText')
			)
		end

		tip = tooltip
		tipRight2 = _G.EllipsisScanningTooltipTextRight2
		tipRight3 = _G.EllipsisScanningTooltipTextRight3
		tipRight4 = _G.EllipsisScanningTooltipTextRight4
	end

	local function GetNumSpellBookItems()
		local t = GetNumSpellTabs()
		local i, name, offset, numSpells

		while (true) do
			name, _, offset, numSpells = GetSpellTabInfo(t)

			if (not name) then break end

			i = offset + numSpells
			t = t + 1
		end

		return i
	end

	function Ellipsis:PopulatePlayerSpellCooldowns()
		if (not self.scanningTip) then BuildScanningTooltip() end

		local spCooldown = L.SearchPatternCooldown
		local spRecharge = L.SearchPatternRecharge

		local name

		for i = 1, GetNumSpellBookItems() do
			tipRight2:SetText('')
			tipRight3:SetText('')
			tipRight4:SetText('')
			tip:SetSpellBookItem(i, BT_SPELL)

			tr2Text = tipRight2:GetText() or nil
			tr3Text = tipRight3:GetText() or nil
			tr4Text = tipRight4:GetText() or nil

			if (
				(tr2Text and (find(tr2Text, spCooldown) or find(tr2Text, spRecharge))) or
				(tr3Text and (find(tr3Text, spCooldown) or find(tr3Text, spRecharge))) or
				(tr4Text and (find(tr4Text, spCooldown) or find(tr4Text, spRecharge)))
			) then
				-- this spell has a cooldown, store its data
				name = GetSpellBookItemName(i, BT_SPELL)

				if (not spellCooldowns[name]) then
					spellCooldowns[name] = {
						spellID = select(2, GetSpellBookItemInfo(i, BT_SPELL)),
						icon = GetSpellTexture(i, BT_SPELL),
					}
				end
			end
		end

		if (self.isWarlock) then -- special case to fix warlock's dark soul
			local name = GetSpellInfo(113858)
			if (spellCooldowns[name]) then spellCooldowns[name].spellID = 113858 end
			name = GetSpellInfo(113860)
			if (spellCooldowns[name]) then spellCooldowns[name].spellID = 113860 end
			name = GetSpellInfo(113861)
			if (spellCooldowns[name]) then spellCooldowns[name].spellID = 113861 end
		end
	end

	function Ellipsis:PopulatePetSpellCooldowns()
		if (not self.scanningTip) then BuildScanningTooltip() end

		if (not UnitExists('pet')) then return end -- abort if currently no pet

		local spCooldown = L.SearchPatternCooldown
		local index, name = 1, GetSpellBookItemName(1, BT_PET)

		while(true) do
			if (not name) then break end

			tipRight2:SetText('')
			tipRight3:SetText('')
			tip:SetSpellBookItem(index, BT_PET)

			if (find(tipRight2:GetText() or '', spCooldown) or find(tipRight3:GetText() or '', spCooldown)) then
				-- this spell has a cooldown, store its data
				if (not petCooldowns[name]) then
					petCooldowns[name] = {
						spellID = select(2, GetSpellBookItemInfo(index, BT_PET)),
						icon = GetSpellTexture(index, BT_PET)
					}
				end
			end

			index = index + 1
			name = GetSpellBookItemName(index, BT_PET)
		end
	end
end

-- UTILITY FUNCTIONS --------------------------------------

function Ellipsis.CooldownTimerOnClick(frame, button)
	if (button == 'LeftButton') then
		if (IsInRaid()) then
			Ellipsis:CooldownTimerAnnounce(frame, 'RAID')
		elseif (IsInGroup()) then
			Ellipsis:CooldownTimerAnnounce(frame, 'PARTY')
		else
			Ellipsis:CooldownTimerAnnounce(frame, 'SAY')
		end
	elseif (button == 'RightButton' and IsShiftKeyDown()) then
		Ellipsis:CooldownDoNotTrackAddition(frame.spell)
	end
end

function Ellipsis:CooldownTimerAnnounce(frame, channel)
	local remains = floor(frame.finish - GetTime())
	local min, sec = floor(remains / 60), mod(remains, 60)

	if (remains < 0) then return end -- its expired (in pulse), nothing to announce

	if (frame.cdType == 2) then
		SendChatMessage(format(L.CDTimerAnnouncePet, frame.spell, min, sec), channel)
	else
		SendChatMessage(format(L.CDTimerAnnounceSpellItem, frame.spell, min, sec), channel)
	end
end

function Ellipsis:CooldownDoNotTrackAddition(dnt)
	-- check to see if this is an item link
	local found, _, item = string.find(dnt, '|c.+|h(.+)|h|r')

	if (found and item ~= nil) then
		dnt = item -- it is
	end

	-- check for brackets and/or rank details and strip them
	dnt = string.gsub(dnt, '%[', '')
	dnt = string.gsub(dnt, '%]', '')
	dnt = string.gsub(dnt, '%(%w+ %d+%)', '')

	if (not self.db.profile.cdDoNotTrack[dnt]) then
		self.db.profile.cdDoNotTrack[dnt] = true

		if (activeCDTimers[dnt]) then
			self:DestroyCDTimer(dnt)
		end

		self:Print(format(L.CDDNTWontTrack, dnt))
	end
end
