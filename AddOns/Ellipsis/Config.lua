local Ellipsis = LibStub('AceAddon-3.0'):GetAddon('Ellipsis')
local L = LibStub('AceLocale-3.0'):GetLocale('Ellipsis')

local defaults = {
	profile = {
		lock = false,

		-- Base Display
		tooltips = true,
		clickable = true,
		auraAlpha = 1.0,
		auraScale = 1.0,
		width = 150,
		cdAlpha = 1.0,
		cdScale = 1.0,

		-- Positioning
		auraPosition = {x = 350, y = 300, point = 'CENTER'}, -- {x = 0, y = 0, point = 'CENTER'},
		promPosition = {x = 350, y = 0, point = 'CENTER'},
        barPosition = {x = 0, y = 170, point = 'BOTTOM'}, -- {x = 0, y = -64, point = 'CENTER'},

		-- Display (Aura Targets)
		sortTarget = true,			-- These four settings
		sortFocus = true,			-- are all set in a single
		showTargetOnly = false,		-- function to ensure a
		showFocusOnly = false,		-- valid combination.
		showNumTargets = 5,
		targetFont = 'Friz Quadrata TT',
		targetFontHeight = 12,
		targetPadding = 1,
		growTargets = 'DOWN', -- all 4 directions
		showLevel = true,
		showClassColours = false,
		showRaidIcons = false,
		prominentItems = {
			['notarget'] = false,
			['player'] = false,
			['pet'] = false,
		},

		-- Display (Aura Timers)
		sortTimerMethod = 1, -- Alphabetical (A or D), Remaining Duration (A or D), Time Added (no sorting)
		timerFormat = 4, -- 1-4
		showTenths = true,
		mode = 'bars',
		growTimers = 'DOWN',  -- all but up
		ghostShow = true,
		ghostDuration = 5,
		barHeight = 16,
		iconHeight = 24,
		timerPadding = 1,
		texture = 'Aluminium', -- 'Blizzard',
		timerFont = 'Friz Quadrata TT',
		timerFontHeight = 10,
		showStackInName = false,

		-- Display (Cooldowns)
		cdHorizontal = true,
		cdHideWhenNone = false,
        cdLength = 400, -- 200, XXX
		cdThickness = 16,
		cdTimeDetail = true, -- false,
		cdMaxTimeDisplay = 60,
		cdFontHeight = 10,
		cdTexture = 'Aluminium', -- 'Blizzard',
		cdShowOffsetTags = true,
		cdOffset1 = 0, -- spell
		cdOffset2 = 0, -- pet
		cdOffset3 = 0, -- item

		-- Display (Colours)
		colours = {
			['background'] = {0.25, 0.25, 0.25, 1.0},
			['ghost'] = {0.5, 0.5, 0.5},
			['targettext'] = {1, 0.82, 0},
			['timertext'] = {1, 1, 1},
			['cdbar'] = {0.5, 0.5, 0.5, 1.0},
			['cdborder'] = {0, 0, 0, 1.0},
			['cdbackdrop'] = {0, 0, 0, 1.0},
			['cdtext'] = {0.75, 0.75, 0.75},
			['cd1'] = {1, 0, 0}, -- spell
			['cd2'] = {0, 1, 0}, -- pet
			['cd3'] = {0, 0, 1}, -- item
		},

		-- Aura Tracking
		trackBuffs = true,
		trackDebuffs = true,
		trackPlayer = false,
		trackPet = false,
		minAuraDuration = 0,
		maxAuraDuration = 0,
		doNotTrack = {},

		-- Cooldown Tracking
		cdSpell = true,
		cdPet = true,
		cdItem = true,
		cdMinDuration = 2,
		cdMaxDuration = 0,
		cdDoNotTrack = {},

		-- Output (Audio)
		playSounds = false,
		sounds = {
			['expired'] = 'Simon Chime',
			['broken'] = 'Short Circuit',
			['cdexpired'] = 'Humm',
		},

		-- Output (Visual)
		notifyExpire = false,
		notifyBreak = false,
		notifyCDExpire = false,
		sinkOptions = {
			['sink20OutputSink'] = 'Default',
		},

		-- Advanced
		timerUpdateRate = 0.1,
		secondaryScan = true,
		secondaryScanRate = 1.0,
	}
}

-- MAIN OPTION CONFIG -------------------------------------

local doLoadOnce = true
local function LoadEllipsisOptions()
	if (doLoadOnce) then
		if (not IsAddOnLoaded('Ellipsis_Options')) then
			local loaded = LoadAddOn('Ellipsis_Options')

			if (loaded) then
				Ellipsis:LoadOptions()
			end
		end

		doLoadOnce = false
	end
end

function Ellipsis:InitializeConfig()
	self.db = LibStub("AceDB-3.0"):New("EllipsisDB", defaults)
	self:RegisterChatCommand("ellipsis", "OpenOptFrame")
	self:SetSinkStorage(self.db.profile.sinkOptions) -- Setup LibSink

	hooksecurefunc('InterfaceOptionsList_DisplayPanel', LoadEllipsisOptions)
end

function Ellipsis:OpenOptFrame()
	LoadEllipsisOptions()

	if (not self.optFrame) then
		self:Print(L.EllipsisOptionsNotEnabled)
		return
	end

	InterfaceOptionsFrame_OpenToCategory(Ellipsis.optFrame)
end

local prominenceAssociation = {
	[0] = 'notarget',
	[1] = 'player',
	[2] = 'pet',
}

function Ellipsis:ApplyConfigSettings()
	self.barWidth = self.db.profile.width - self.db.profile.barHeight

	self:ConfigureTimerUpdate()
	self:ConfigureScanAuras()

	self:ConfigureAnchors(true) -- also configures the cooldown base

	self:ConfigureTargetAnchors()
	self:ConfigureTimerAnchorsAndSize()

	self:ConfigureCooldowns()

	self:ConfigureAuraScan()
	self:ConfigureSecondaryScan()
	self:SetSecondaryScan((IsInGroup() or IsInRaid()), UnitExists('pet'))

	if (self.db.profile.showRaidIcons) then
		self:RegisterEvent('RAID_TARGET_UPDATE')
		self:RAID_TARGET_UPDATE() -- show new raid icons
	else
		self:UnregisterEvent('RAID_TARGET_UPDATE')
	end

	-- If buffs on player or pet and not tracking them anymore, clear entries
	if (not self.db.profile.trackPlayer) then
		if (self:GetActiveGUIDS()[self.playerGUID]) then self:DestroyTarget(self.playerGUID) end
	end

	if (not self.db.profile.trackPet) then
		if (self:GetActiveGUIDS()[UnitGUID('pet')]) then self:DestroyTarget(UnitGUID('pet')) end
	end

	-- apply settings to all active targets and timers and their layouts (a bit intensive but only happens on option changes)
	local currentTime = GetTime()
	local percent, remains
	local showStackInName = self.db.profile.showStackInName
	for _, t in pairs(self:GetActiveTimers()) do
		self:ApplyTimerSettings(t)

		-- apply active timer only settings
		percent = 1 - ((currentTime - t.start) / (t.finish - t.start))
		remains = t.finish - currentTime

		if (t.ghost) then
			t.time:SetText('')
			t.bar:SetStatusBarColor(unpack(self.db.profile.colours.ghost))
			t.bar:SetValue(1)
			t.border:SetVertexColor(unpack(self.db.profile.colours.ghost))
			t.stack:SetText('')
			t.spark:Hide()
		else
			t.time:SetFormattedText(self:GetFormattedTime(remains))
			t.border:SetVertexColor(self:GetTimerColours(remains))
			t.bar:SetStatusBarColor(self:GetTimerColours(remains))
			t.spark:Show()

			if (showStackInName) then
				if (t.count > 0) then
					t.nameUI:SetText(format(self.stackNameFormat, t.count, t.name))
				else
					t.nameUI:SetText(t.name)
				end
				t.stack:SetText('')
			else
				t.nameUI:SetText(t.name)
				t.stack:SetText((t.count > 0 and t.count) or '')
			end
		end

		if (self.db.profile.mode == 'bars') then
			t.time:SetTextColor(unpack(self.db.profile.colours.timertext))
			t.nameUI:SetWidth(self.barWidth - (t.time:GetStringWidth() + 6))
		elseif (self.db.profile.mode == 'icons') then
			t.time:SetTextColor(self:GetTimerColours(remains))
		end
	end

	for guid, t in pairs(self:GetActiveGUIDS()) do
		self:ApplyTargetSettings(t)
		self:SetTargetText(t)
		self:UpdateTimerDisplay(guid)
	end


	-- Sort out target display based on prominence settings, then update both anchors displays
	local pAssoc = 0

	for k, t in pairs(self:GetSortedTargets()) do
		if (t.created < 3) then -- this could be a prominent item
			pAssoc = prominenceAssociation[t.created]
			if (self.db.profile.prominentItems[pAssoc]) then -- this is a prominent item, shift it to the prominence anchor
				t.prominent = true
				tinsert(self:GetProminentTargets(), t)
				tremove(self:GetSortedTargets(), k)
			end
		end
	end

	for k, t in pairs(self:GetProminentTargets()) do
		pAssoc = prominenceAssociation[t.created]
		if (not self.db.profile.prominentItems[pAssoc]) then -- this is no longer a prominent item, shift it to normal anchor
			t.prominent = false
			tinsert(self:GetSortedTargets(), t)
			tremove(self:GetProminentTargets(), k)
		end
	end

	self:UpdateTargetDisplay(self:GetSortedTargets(), self.targetAnchor)
	self:UpdateTargetDisplay(self:GetProminentTargets(), self.prominenceAnchor)

	-- apply settings to inactive targets and timers as well (so much less work)
	for k in pairs(self:GetUnusedTargets()) do self:ApplyTargetSettings(k) end
	for k in pairs(self:GetUnusedTimers()) do self:ApplyTimerSettings(k) end

	-- apply settings to active cooldown timers
	for _, t in pairs(self:GetActiveCDTimers()) do
		self:ApplyCDTimerSettings(t)
		self:ConfigureCDTag(t)
	end

	-- apply settings to inactive cooldown timers
	for k in pairs(self:GetUnusedCDTimers()) do self:ApplyCDTimerSettings(k) end

	-- and finally scan player and pet incase anything changed about tracking their buff status
	self:ScanAuras('player', 'HELPFUL', true)
	self:ScanAuras('pet', 'HELPFUL', true)
end

-- OPTION UTILITY FUNCTIONS -------------------------------

do
	local timeStrings = {
		{'%.1f', '%d', '%d:%02d'},
		{'0:%02.1f', '0:%02d', '%d:%02d'},
		{L.TimeStringSecTenth, L.TimeStringSec, L.TimeStringMinSec},
		{L.TimeStringSecTenth, L.TimeStringSec, L.TimeStringMin},
	}

	function Ellipsis:GetFormattedTimeStrings()
		local format = self.db.profile.timerFormat
		return timeStrings[format][1], timeStrings[format][2], timeStrings[format][3], L.TimeStringHour, format
	end
end
