local Ellipsis = LibStub('AceAddon-3.0'):GetAddon('Ellipsis')
local L = LibStub('AceLocale-3.0'):GetLocale('Ellipsis')
local Media = LibStub('LibSharedMedia-3.0')

do
	local function GetNewPosition(drag)
		local s = drag:GetScale()
		local l, r = drag:GetLeft() * s, drag:GetRight()  * s
		local t, b = drag:GetTop()  * s, drag:GetBottom() * s
		local w, h = UIParent:GetWidth(), UIParent:GetHeight()

		local x, y, point

		if l < (w - r) and l < abs((l + r) / 2 - w / 2) then
			x = l
			point = 'LEFT'
		elseif (w - r) < abs((l + r) / 2 - w / 2) then
			x = r - w
			point = 'RIGHT'
		else
			x = (l + r) / 2 - w / 2
			point = ''
		end

		if b < (h - t) and b < abs((b + t) / 2 - h / 2) then
			y = b
			point = 'BOTTOM' .. point
		elseif (h - t) < abs((b + t) / 2 - h / 2) then
			y = t - h
			point = 'TOP' .. point
		else
			y = (b + t) / 2 - h / 2
		end

		if (point == '') then point = 'CENTER' end

		return point, x, y
	end

	local function OnDragStart(drag)
		drag.isMoving = true
		drag:StartMoving()
	end

	local function OnDragStop(drag)
		if (drag.isMoving) then
			drag.isMoving = nil
			drag:StopMovingOrSizing()

			local point, x, y = GetNewPosition(drag)

			Ellipsis.db.profile[drag.positionTable].point = point
			Ellipsis.db.profile[drag.positionTable].x = x
			Ellipsis.db.profile[drag.positionTable].y = y
		end
	end

    local function onClickOpenOpt(f)
        f:RegisterForClicks'RightButtonUp'
        f:SetScript('OnClick', function()
            Ellipsis:OpenOptFrame()
        end)
    end

	function Ellipsis:InitializeGUI()
		local f

		-- create target anchor
		f = CreateFrame('Button', nil, UIParent)
		self.targetAnchor = f
		f:SetScript('OnDragStart', OnDragStart)
		f:SetScript('OnDragStop', OnDragStop)
		f:SetHeight(10)
		f:SetWidth(150)
		f:SetClampedToScreen(true)
		f:SetMovable(true)
		f.dragTex = f:CreateTexture(nil, 'BORDER')
		f.dragTex:SetAllPoints()
		f.dragTex:SetTexture(0.5, 0.5, 1, 0.5)
		f.dragStr = f:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		f.dragStr:SetPoint('TOPLEFT', 0, 1)
		f.dragStr:SetPoint('BOTTOMRIGHT', 0, 1)
		f.dragStr:SetText(L.Targets)
		f.positionTable = 'auraPosition'
        onClickOpenOpt(f)

		-- create prominent target anchor
		f = CreateFrame('Button', nil, UIParent)
		self.prominenceAnchor = f
		f:SetScript('OnDragStart', OnDragStart)
		f:SetScript('OnDragStop', OnDragStop)
		f:SetHeight(10)
		f:SetWidth(150)
		f:SetClampedToScreen(true)
		f:SetMovable(true)
		f.dragTex = f:CreateTexture(nil, 'BORDER')
		f.dragTex:SetAllPoints()
		f.dragTex:SetTexture(0.5, 0.5, 1, 0.5)
		f.dragStr = f:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		f.dragStr:SetPoint('TOPLEFT', 0, 1)
		f.dragStr:SetPoint('BOTTOMRIGHT', 0, 1)
		f.dragStr:SetText(L.Prominence)
		f.positionTable = 'promPosition'
        onClickOpenOpt(f)

		-- create cooldown anchor
		f = CreateFrame('Button', nil, UIParent)
		self.cooldownAnchor = f
		f:SetScript('OnDragStart', OnDragStart)
		f:SetScript('OnDragStop', OnDragStop)
		f:SetHeight(10)
		f:SetWidth(150)
		f:SetClampedToScreen(true)
		f:SetMovable(true)
		f:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true, tileSize = 16,
			edgeSize = 6,
			insets = {left = 1, right = 1, top = 1, bottom = 1}
		})
		f.bar = f:CreateTexture(nil, 'BORDER')
		f.bar:SetPoint('TOPLEFT', 2, -2)
		f.bar:SetPoint('BOTTOMRIGHT', -2, 2)
		f.timeScale = CreateFrame('Frame', nil, f)
		f.timeScale:SetFrameLevel(f.timeScale:GetFrameLevel() + 1)
		f.timeScale:SetAllPoints(f)
		f.positionTable = 'barPosition'
        onClickOpenOpt(f)
	end
end

local function ConfigureDragFrame(frame, canDrag, dragTex)
	if (canDrag) then
		if (dragTex) then
			frame.dragTex:Show()
			frame.dragStr:Show()
		end
		frame:EnableMouse(true)
		frame:RegisterForDrag('LeftButton')

	else
		if (dragTex) then
			frame.dragTex:Hide()
			frame.dragStr:Hide()
		end
		frame:EnableMouse(false)
		frame:RegisterForDrag(nil)
	end
end

function Ellipsis:ConfigureAnchors(firstLoad)
	local canDrag = not self.db.profile.lock
	local opts = self.db.profile

	ConfigureDragFrame(self.targetAnchor, canDrag, true)
	ConfigureDragFrame(self.prominenceAnchor, canDrag, true)
	ConfigureDragFrame(self.cooldownAnchor, canDrag, false)
	-- timer
	self.targetAnchor:SetAlpha(opts.auraAlpha)
	self.targetAnchor:SetScale(opts.auraScale)
	self.targetAnchor:SetWidth(opts.width)

	local scale = opts.auraScale

	self.targetAnchor:ClearAllPoints()
	self.targetAnchor:SetPoint(opts.auraPosition.point, UIParent, opts.auraPosition.point, opts.auraPosition.x / scale, opts.auraPosition.y / scale)

	-- prominence
	self.prominenceAnchor:SetAlpha(opts.auraAlpha)
	self.prominenceAnchor:SetScale(opts.auraScale)
	self.prominenceAnchor:SetWidth(opts.width)

	self.prominenceAnchor:ClearAllPoints()
	self.prominenceAnchor:SetPoint(opts.promPosition.point, UIParent, opts.promPosition.point, opts.promPosition.x / scale, opts.promPosition.y / scale)

	-- cooldown
	self.cooldownAnchor:SetAlpha(opts.cdAlpha)
	self.cooldownAnchor:SetScale(opts.cdScale)
	self:ConfigureCooldownBase()

	scale = opts.cdScale

	self.cooldownAnchor:ClearAllPoints()
	self.cooldownAnchor:SetPoint(opts.barPosition.point, UIParent, opts.barPosition.point, opts.barPosition.x / scale, opts.barPosition.y / scale)
end

-- TARGET GUI FUNCTIONS -----------------------------------

local unusedTargets = {}

function Ellipsis:GetTargetFrame()
	local t = next(unusedTargets)

	if (t) then
		unusedTargets[t] = nil
		return t
	else
		t = CreateFrame('Frame', nil, self.targetAnchor)

		t.guid = 0
		t.name = ''
		t.level = 0
		t.class = 'WARRIOR'
		t.created = 0
		t.hidden = false
		t.prominent = false
		t.raidicon = 0 -- no icon
		t.timers = {}
		t.sortedTimers = {}

		t.title = t:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		t.title:SetPoint('TOPLEFT', t, 'TOPLEFT')
		t.title:SetPoint('TOPRIGHT', t, 'TOPRIGHT')
		t.title:SetJustifyH('CENTER')
		t.title:SetJustifyV('TOP')

		self:ApplyTargetSettings(t)

		return t
	end
end

function Ellipsis:ReleaseTargetFrame(t)
	t:Hide()
	unusedTargets[t] = true
end

local levelIconName = '|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t[%s] %s'
local iconName = '|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_%d:0|t%s'
local levelName = '[%s] %s'
local name = '%s'

function Ellipsis:SetTargetText(t)
	if (self.db.profile.showLevel and t.level ~= 0) then
		if (self.db.profile.showRaidIcons and t.raidicon ~= 0) then
			t.title:SetFormattedText(levelIconName, t.raidicon, t.level, t.name)
		else
			t.title:SetFormattedText(levelName, t.level, t.name)
		end
	else
		if (self.db.profile.showRaidIcons and t.raidicon ~= 0) then
			t.title:SetFormattedText(iconName, t.raidicon, t.name)
		else
			t.title:SetFormattedText(name, t.name)
		end
	end
end

function Ellipsis:SetTargetTextColour(t)
	if (self.db.profile.showClassColours) then
		t.title:SetTextColor(RAID_CLASS_COLORS[t.class].r, RAID_CLASS_COLORS[t.class].g, RAID_CLASS_COLORS[t.class].b)
	else
		t.title:SetTextColor(unpack(self.db.profile.colours.targettext))
	end
end

function Ellipsis:ApplyTargetSettings(t)
	t.title:SetHeight(self.db.profile.targetFontHeight + 4)
	t.title:SetFont(Media:Fetch('font', self.db.profile.targetFont), self.db.profile.targetFontHeight)

	self:SetTargetTextColour(t)
end

do
	local anchor, anchorRel, vertical, vertUp, horzLeft, padding
	local showTargetOnly, showFocusOnly, playerGUID, trackPlayer, trackPet, showNumTargets

	local alwaysShow = {}
	local numTargets, mustShow, numToShow = 0, 0, 0

	local function CalculateNumShownTargets(targets, targetGUID, focusGUID)
		numTargets, mustShow = #targets, 0

		for k, v in pairs(alwaysShow) do alwaysShow[k] = nil end -- clear out table

		alwaysShow['notarget'] = true

		if (trackPlayer) then alwaysShow[playerGUID] = true end
		if (trackPet and UnitExists('pet')) then alwaysShow[UnitGUID('pet')] = true end

		for x = 1, min(3, numTargets) do
			if (alwaysShow[targets[x].guid]) then
				alwaysShow[targets[x].guid] = nil
				mustShow = mustShow + 1
			end
		end

		if ((not showTargetOnly and not showFocusOnly) or numTargets <= mustShow) then
			-- either not 'only' showing target or focus, or the only entries are mustshows anyhow, return
			return min(mustShow + showNumTargets, numTargets)
		end

		-- showing only focus and/or target and there are more entries than the mustShows above
		if (showTargetOnly) then alwaysShow[targetGUID] = true end
		if (showFocusOnly) then alwaysShow[focusGUID] = true end

		for x = mustShow + 1, min(mustShow + 3, numTargets) do
			if (alwaysShow[targets[x].guid]) then
				alwaysShow[targets[x].guid] = nil
				mustShow = mustShow + 1
			end
		end

		return mustShow -- we only show the mustShows if we got this far
	end

	local function ShowTimers(target)
		if (target.hidden) then
			target.hidden = false
			for _, v in pairs(target.sortedTimers) do v:Show() end
		end
	end

	local function HideTimers(target)
		if (not target.hidden) then
			target.hidden = true
			for _, v in pairs(target.sortedTimers) do v:Hide() end
		end
	end

	function Ellipsis:AnchorTargets(targets, mainAnchor, targetGUID, focusGUID)
		if (#targets < 1) then return end

		numToShow = CalculateNumShownTargets(targets, targetGUID, focusGUID)

		if (numToShow > 0) then -- could be zero if showing only focus/target and no special entries
			targets[1]:ClearAllPoints()
			targets[1]:Show()
			ShowTimers(targets[1])

			if (vertical) then
				targets[1]:SetPoint(anchor, mainAnchor, anchor)

				if (numToShow > 1) then
					for x = 2, numToShow do
						targets[x]:ClearAllPoints()
						targets[x]:SetPoint(anchor, targets[x - 1], anchorRel, 0, vertUp and padding or -(padding))
						targets[x]:Show()
						ShowTimers(targets[x])
					end
				end
			else
				targets[1]:SetPoint('TOP', mainAnchor, 'TOP')

				if (numToShow > 1) then
					for x = 2, numToShow do
						targets[x]:ClearAllPoints()
						targets[x]:SetPoint(anchor, targets[x - 1], anchorRel, horzLeft and -(padding) or padding, 0)
						targets[x]:Show()
						ShowTimers(targets[x])
					end
				end
			end
		end

		if (#targets > numToShow) then
			for x = numToShow + 1, #targets do
				targets[x]:Hide()
				HideTimers(targets[x])
			end
		end
	end

	function Ellipsis:ConfigureTargetAnchors()
		local growTargets = self.db.profile.growTargets

		if (growTargets == 'UP' or growTargets == 'DOWN') then
			anchor = (growTargets == 'UP') and 'BOTTOM' or 'TOP'
			anchorRel = (growTargets == 'UP') and 'TOP' or 'BOTTOM'
			vertical = true
			vertUp = (growTargets == 'UP') and true or false
		else
			anchor = (growTargets == 'LEFT') and 'TOPRIGHT' or 'TOPLEFT'
			anchorRel = (growTargets == 'LEFT') and 'TOPLEFT' or 'TOPRIGHT'
			vertical = false
			horzLeft = (growTargets == 'LEFT') and true or false
		end

		padding = self.db.profile.targetPadding
		showTargetOnly = self.db.profile.showTargetOnly
		showFocusOnly = self.db.profile.showFocusOnly
		trackPlayer = self.db.profile.trackPlayer
		trackPet = self.db.profile.trackPet
		showNumTargets = self.db.profile.showNumTargets
		if (not playerGUID) then playerGUID = self.playerGUID end
	end
end

-- TIMER GUI FUNCTIONS ------------------------------------

local unusedTimers = {}
local auraClickColor

local function TimerOnEnter(frame)
	if (Ellipsis.db.profile.tooltips) then
		GameTooltip:SetOwner(frame, 'ANCHOR_RIGHT')
		GameTooltip:SetText(frame.name, 1, 0.82, 0, 1)

		auraClickColor = Ellipsis.db.profile.clickable and 1 or 0.5

		GameTooltip:AddLine(L.LeftClickToAnnounce, auraClickColor, auraClickColor, auraClickColor, 1)
		GameTooltip:AddLine(L.RightClickToCancel, auraClickColor, auraClickColor, auraClickColor, 1)
		GameTooltip:AddLine(L.ShiftRightClickToBlock, auraClickColor, auraClickColor, auraClickColor, 1)
		if (frame.totemType) then GameTooltip:AddLine(L.CtrlRightClickToDestroyTotem, auraClickColor, auraClickColor, auraClickColor, 1) end

		GameTooltip:Show()
	end
end

local function TimerOnLeave()
	GameTooltip:Hide()
end

function Ellipsis:GetTimerFrame()
	local t = next(unusedTimers)

	if (t) then
		unusedTimers[t] = nil
		return t
	else
		t = CreateFrame('Button', nil, self.targetAnchor)
		t:SetScript('OnEnter', TimerOnEnter)
		t:SetScript('OnLeave', TimerOnLeave)
		t:SetScript('OnClick', self.TimerOnClick)

		t.start = 0
		t.finish = 0
		t.name = ''
		t.spellID = 0
		t.count = 0 -- for stackable (de)buffs
		t.guid = 0 -- parent reference
		t.valid = 0 -- last validation time
		t.totemType = false
		t.ghost = false

		t.icon = t:CreateTexture(nil, 'BORDER')
		t.icon:SetPoint('TOPLEFT', t, 'TOPLEFT')
		t.icon:SetPoint('BOTTOMLEFT', t, 'BOTTOMLEFT')

		t.stack = t:CreateFontString(nil, 'OVERLAY', 'NumberFontNormal')
		t.stack:SetPoint('BOTTOMRIGHT', t.icon, 'BOTTOMRIGHT', -1.5, 1.5)
		t.stack:SetTextHeight(10)

		t.border = t:CreateTexture(nil, 'ARTWORK')
		t.border:SetPoint('TOPLEFT', t.icon, 'TOPLEFT')
		t.border:SetPoint('BOTTOMRIGHT', t.icon, 'BOTTOMRIGHT')
		t.border:SetTexCoord(0.296875, 0.5703125, 0, 0.515625)
		t.border:SetTexture('Interface\\Buttons\\UI-Debuff-Overlays')

		t.bar = CreateFrame('StatusBar', nil, t)
		t.bar:SetPoint('TOPRIGHT', t, 'TOPRIGHT')
		t.bar:SetPoint('BOTTOMRIGHT', t, 'BOTTOMRIGHT')
		t.bar:SetFrameLevel(t.bar:GetFrameLevel() - 1) -- ensure its 'behind' the frame with its text
		t.bar:SetMinMaxValues(0, 1)

		t.bg = t.bar:CreateTexture(nil, 'BACKGROUND')
		t.bg:SetAllPoints()

		t.spark = t.bar:CreateTexture(nil, 'OVERLAY')
		t.spark:SetTexture('Interface\\CastingBar\\UI-CastingBar-Spark')
		t.spark:SetVertexColor(1, 1, 1, 0.5)
		t.spark:SetBlendMode('ADD')
		t.spark:SetWidth(16)

		t.nameUI = t:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		t.nameUI:SetPoint('LEFT', t.bar, 'LEFT', 3, 0)
		t.nameUI:SetJustifyH('LEFT')
		t.nameUI:SetJustifyV('MIDDLE')

		t.time = t:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
		t.time:SetJustifyV('MIDDLE')

		self:ApplyTimerSettings(t)

		return t
	end
end

function Ellipsis:ReleaseTimerFrame(t)
	t:Hide()
	unusedTimers[t] = true
end

function Ellipsis:ApplyTimerSettings(t)
	t:SetWidth(self.db.profile.width)

	t.nameUI:SetFont(Media:Fetch('font', self.db.profile.timerFont), self.db.profile.timerFontHeight)
	t.time:SetFont(Media:Fetch('font', self.db.profile.timerFont), self.db.profile.timerFontHeight)

	if (self.db.profile.clickable) then
		t:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	else
		t:RegisterForClicks(nil)
	end

	if (self.db.profile.mode == 'bars') then
		local barHeight = self.db.profile.barHeight

		t:SetHeight(barHeight)
		t.icon:SetWidth(barHeight)

		t.nameUI:SetHeight(barHeight)
		t.nameUI:SetTextColor(unpack(self.db.profile.colours.timertext))
		t.nameUI:Show()

		t.time:SetPoint('RIGHT', t.bar, 'RIGHT', -3, 0)
		t.time:SetHeight(barHeight)
		t.time:SetTextColor(unpack(self.db.profile.colours.timertext))
		t.time:SetJustifyH('RIGHT')

		t.spark:SetHeight(barHeight * 1.8)
		t.bg:SetTexture(Media:Fetch('statusbar', self.db.profile.texture))
		t.bg:SetVertexColor(unpack(self.db.profile.colours.background))

		t.bar:SetWidth(self.barWidth)
		t.bar:SetStatusBarTexture(Media:Fetch('statusbar', self.db.profile.texture))
		t.bar:Show()
	elseif (self.db.profile.mode == 'icons') then
		local iconHeight = self.db.profile.iconHeight

		t:SetHeight(iconHeight)
		t.icon:SetWidth(iconHeight)

		t.bar:Hide() -- hides associated spark, bg
		t.nameUI:Hide()

		t.time:SetPoint('LEFT', t.icon, 'RIGHT', 5, 0)
		t.time:SetHeight(iconHeight)
		t.time:SetJustifyH('LEFT')
	end
end

do
	local anchor, anchorRel, vertical, horzLeft, padding, height, width, infoHeight

	function Ellipsis:AnchorTimersAndSizeTarget(target, timers)
		if (#timers < 1) then return end

		timers[1]:ClearAllPoints()
		timers[1]:SetPoint('TOP', target.title, 'BOTTOM', 0, -(padding))

		if (vertical) then
			for x = 2, #timers do
				timers[x]:ClearAllPoints()
				timers[x]:SetPoint(anchor, timers[x - 1], anchorRel, 0, -(padding))
			end

			target:SetHeight(infoHeight + (#timers * (height + padding)))
			target:SetWidth(width)
		else
			for x = 2, #timers do
				timers[x]:ClearAllPoints()
				timers[x]:SetPoint(anchor, timers[x - 1], anchorRel, horzLeft and -(padding) or padding, 0)
			end

			target:SetHeight(infoHeight + height + padding)
			target:SetWidth(#timers * (width + padding))
		end
	end

	function Ellipsis:ConfigureTimerAnchorsAndSize()
		local growTimers = self.db.profile.growTimers

		if (growTimers == 'DOWN') then
			anchor = (growTimers == 'UP') and 'BOTTOM' or 'TOP'
			anchorRel = (growTimers == 'UP') and 'TOP' or 'BOTTOM'
			vertical = true
		else
			anchor = (growTimers == 'LEFT') and 'TOPRIGHT' or 'TOPLEFT'
			anchorRel = (growTimers == 'LEFT') and 'TOPLEFT' or 'TOPRIGHT'
			vertical = false
			horzLeft = (growTimers == 'LEFT') and true or false
		end

		padding = self.db.profile.timerPadding
		height = (self.db.profile.mode == 'bars' and self.db.profile.barHeight) or self.db.profile.iconHeight
		width = self.db.profile.width
		infoHeight = self.db.profile.targetFontHeight + 4
	end
end

-- COOLDOWN TIMER GUI FUNCTIONS ---------------------------

local unusedCDTimers = {}
local cdClickColor

local function CDTimerOnEnter(frame)
	if (Ellipsis.db.profile.tooltips) then
		local remains = floor(frame.finish - GetTime())
		local min, sec = floor(remains / 60), mod(remains, 60)

		GameTooltip:SetOwner(frame, 'ANCHOR_RIGHT')
		GameTooltip:SetText(frame.spell, 1, 0.82, 0, 1)
		if (remains > 0) then GameTooltip:AddLine(format(L.TimeRemaining, min, sec), 1, 1, 1, 1) end
		GameTooltip:AddLine(' ', 1, 1, 1, 1)

		cdClickColor = Ellipsis.db.profile.clickable and 1 or 0.5

		GameTooltip:AddLine(L.LeftClickToAnnounce, cdClickColor, cdClickColor, cdClickColor, 1)
		GameTooltip:AddLine(L.ShiftRightClickToBlock, cdClickColor, cdClickColor, cdClickColor, 1)

		GameTooltip:Show()
	end
end

function Ellipsis:GetCDTimerFrame()
	local t = next(unusedCDTimers)

	if (t) then
		unusedCDTimers[t] = nil
		return t
	else
		t = CreateFrame('Button', nil, self.cooldownAnchor)
		t:SetScript('OnEnter', CDTimerOnEnter)
		t:SetScript('OnLeave', TimerOnLeave)
		t:SetScript('OnClick', self.CooldownTimerOnClick)

		t.start = 0
		t.finish = 0
		t.spell = ''
		t.valid = 0
		t.cdType = -1
		t.offset = 0
		t.inPulse = false

		t.icon = t:CreateTexture(nil, 'OVERLAY')
		t.icon:SetAllPoints()
		t.icon:SetTexCoord(0.0625, 0.9375, 0.0625, 0.9375)

		t.tag = t:CreateTexture(nil, 'BORDER')
		t.tag:SetHeight(1)
		t.tag:SetWidth(1)

		self:ApplyCDTimerSettings(t)

		return t
	end
end

function Ellipsis:ReleaseCDTimerFrame(t)
	t:Hide()
	unusedCDTimers[t] = true
end

function Ellipsis:ApplyCDTimerSettings(t)
	if (self.db.profile.clickable) then
		t:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
	else
		t:RegisterForClicks(nil)
	end

	if (not t.inPulse) then -- if not pulsing, set height and width
		t:SetHeight(self.db.profile.cdThickness)
		t:SetWidth(self.db.profile.cdThickness)
	end
end

function Ellipsis:ConfigureCDTag(t)
	t.offset = self.db.profile['cdOffset' .. mod(t.cdType, 4)] or 0 -- the mod is a hacky way to make 'sample' timers work

	if (t.offset == 0 or not self.db.profile.cdShowOffsetTags) then
		t.tag:Hide()
		return
	end

	t.tag:ClearAllPoints()
	t.tag:SetTexture(unpack(self.db.profile.colours['cd' .. mod(t.cdType, 4)]))
	t.tag:Show()

	if (self.db.profile.cdHorizontal) then
		t.tag:SetPoint('TOP', t.icon, 'CENTER', 0, (t.offset < 0 and -(t.offset)) or 0)
		t.tag:SetPoint('BOTTOM', t.icon, 'CENTER', 0, (t.offset > 0 and -(t.offset)) or 0)
	else
		t.tag:SetPoint('LEFT', t.icon, 'CENTER', (t.offset > 0 and -(t.offset)) or 0, 0)
		t.tag:SetPoint('RIGHT', t.icon, 'CENTER', (t.offset < 0 and -(t.offset)) or 0, 0)
	end
end

-- COOLDOWN CONFIG ----------------------------------------

local times = {0, 10, 60, 300, 900, 1800, 3600}
local timesDetail = {0, 2, 10, 30, 60, 120, 300, 600, 900, 1200, 1500, 1800, 2700, 3600}
local timeTags = {}

function Ellipsis:ConfigureCooldownBase()
	local cda = self.cooldownAnchor

	local maxTime = self.db.profile.cdMaxTimeDisplay
	local endCap = (self.db.profile.cdThickness / 2)
	local workingLength = self.db.profile.cdLength - (endCap * 2)
	local displayList = self.db.profile.cdTimeDetail and timesDetail or times
	local horz = self.db.profile.cdHorizontal
	local loc

	-- 'Clear' current time tags
	for x = 1, #timeTags do
		timeTags[x]:Hide()
	end

	-- Setup time display
	for k, v in ipairs(displayList) do
		if (v <= maxTime) then
			if (not timeTags[k]) then
				timeTags[k] = cda.timeScale:CreateFontString(nil, 'ARTWORK', 'GameFontNormalSmall')
			end

			loc = math.pow(v / maxTime, 0.4) * workingLength

			timeTags[k]:ClearAllPoints()
			timeTags[k]:SetFont(Media:Fetch('font', 'Blizzard'), self.db.profile.cdFontHeight)
			timeTags[k]:SetTextColor(unpack(self.db.profile.colours.cdtext))
			timeTags[k]:Show()

			if (loc == workingLength) then
				timeTags[k]:SetPoint(horz and 'RIGHT' or 'TOP', cda.bar, horz and 'RIGHT' or 'TOP', horz and -1 or 0, horz and 0 or -1)
				timeTags[k]:SetText(format('%d+', v > 60 and v / 60 or v))
			else
				timeTags[k]:SetPoint('CENTER', cda.bar, horz and 'LEFT' or 'BOTTOM', horz and (endCap + loc) or 0, horz and 0 or (endCap + loc))
				timeTags[k]:SetText(v > 60 and v / 60 or v)
			end
		end
	end

	cda:SetBackdropColor(unpack(self.db.profile.colours.cdbackdrop))
	cda:SetBackdropBorderColor(unpack(self.db.profile.colours.cdborder))

	cda.bar:SetTexture(Media:Fetch('statusbar', self.db.profile.cdTexture))
	cda.bar:SetVertexColor(unpack(self.db.profile.colours.cdbar))

	if (horz) then
		cda:SetHeight(self.db.profile.cdThickness + 4)
		cda:SetWidth(self.db.profile.cdLength + 4)
		cda.bar:SetTexCoord(0, 1, 0, 1)
	else
		cda:SetHeight(self.db.profile.cdLength + 4)
		cda:SetWidth(self.db.profile.cdThickness + 4)
		cda.bar:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
	end
end

-- GUI UTILITY FUNCTIONS ----------------------------------

function Ellipsis:GetUnusedTargets() return unusedTargets end
function Ellipsis:GetUnusedTimers() return unusedTimers end
function Ellipsis:GetUnusedCDTimers() return unusedCDTimers end

function Ellipsis:MediaRegistration()
	-- Copied from Omen giving the same selection whether its installed or not
	Media:Register('sound', 'Rubber Ducky', [[Sound\Doodad\Goblin_Lottery_Open01.wav]])
	Media:Register('sound', 'Cartoon FX', [[Sound\Doodad\Goblin_Lottery_Open03.wav]])
	Media:Register('sound', 'Explosion', [[Sound\Doodad\Hellfire_Raid_FX_Explosion05.wav]])
	Media:Register('sound', 'Shing!', [[Sound\Doodad\PortcullisActive_Closed.wav]])
	Media:Register('sound', 'Wham!', [[Sound\Doodad\PVP_Lordaeron_Door_Open.wav]])
	Media:Register('sound', 'Simon Chime', [[Sound\Doodad\SimonGame_LargeBlueTree.wav]])
	Media:Register('sound', 'War Drums', [[Sound\Event Sounds\Event_wardrum_ogre.wav]])
	Media:Register('sound', 'Cheer', [[Sound\Event Sounds\OgreEventCheerUnique.wav]])
	Media:Register('sound', 'Humm', [[Sound\Spells\SimonGame_Visual_GameStart.wav]])
	Media:Register('sound', 'Short Circuit', [[Sound\Spells\SimonGame_Visual_BadPress.wav]])
	Media:Register('sound', 'Fel Portal', [[Sound\Spells\Sunwell_Fel_PortalStand.wav]])
	Media:Register('sound', 'Fel Nova', [[Sound\Spells\SeepingGaseous_Fel_Nova.wav]])

	-- Additional Choices (all in-game sounds)
	Media:Register('sound', 'PVP Enter Queue', [[Sound\Spells\PVPEnterQueue.wav]])
	Media:Register('sound', 'PVP Through Queue', [[Sound\Spells\PVPThroughQueue.wav]])
	Media:Register('sound', 'Level Up', [[Sound\interface\LevelUp.wav]])
	Media:Register('sound', 'Raid Warning', [[Sound\interface\RaidWarning.wav]])

    if(true) then return end -- XXX

	-- Additional statusbar choices (imported from SharedMedia)
	Media:Register('statusbar', 'Aluminium',		[[Interface\Addons\Ellipsis\StatusBars\Aluminium]])
	Media:Register('statusbar', 'Armory',			[[Interface\Addons\Ellipsis\StatusBars\Armory]])
	Media:Register('statusbar', 'BantoBar',			[[Interface\Addons\Ellipsis\StatusBars\BantoBar]])
	Media:Register('statusbar', 'Bars',				[[Interface\Addons\Ellipsis\StatusBars\Bars]])
	Media:Register('statusbar', 'Bumps',			[[Interface\Addons\Ellipsis\StatusBars\Bumps]])
	Media:Register('statusbar', 'Button',			[[Interface\Addons\Ellipsis\StatusBars\Button]])
	Media:Register('statusbar', 'Charcoal',			[[Interface\Addons\Ellipsis\StatusBars\Charcoal]])
	Media:Register('statusbar', 'Cilo',				[[Interface\Addons\Ellipsis\StatusBars\Cilo]])
	Media:Register('statusbar', 'Cloud',			[[Interface\Addons\Ellipsis\StatusBars\Cloud]])
	Media:Register('statusbar', 'Comet',			[[Interface\Addons\Ellipsis\StatusBars\Comet]])
	Media:Register('statusbar', 'Dabs',				[[Interface\Addons\Ellipsis\StatusBars\Dabs]])
	Media:Register('statusbar', 'DarkBottom',		[[Interface\Addons\Ellipsis\StatusBars\DarkBottom]])
	Media:Register('statusbar', 'Diagonal',			[[Interface\Addons\Ellipsis\StatusBars\Diagonal]])
	Media:Register('statusbar', 'Empty',			[[Interface\Addons\Ellipsis\StatusBars\Empty]])
	Media:Register('statusbar', 'Falumn',			[[Interface\Addons\Ellipsis\StatusBars\Falumn]])
	Media:Register('statusbar', 'Fifths',			[[Interface\Addons\Ellipsis\StatusBars\Fifths]])
	Media:Register('statusbar', 'Flat',				[[Interface\Addons\Ellipsis\StatusBars\Flat]])
	Media:Register('statusbar', 'Fourths',			[[Interface\Addons\Ellipsis\StatusBars\Fourths]])
	Media:Register('statusbar', 'Frost',			[[Interface\Addons\Ellipsis\StatusBars\Frost]])
	Media:Register('statusbar', 'Glamour',			[[Interface\Addons\Ellipsis\StatusBars\Glamour]])
	Media:Register('statusbar', 'Glamour2',			[[Interface\Addons\Ellipsis\StatusBars\Glamour2]])
	Media:Register('statusbar', 'Glamour3',			[[Interface\Addons\Ellipsis\StatusBars\Glamour3]])
	Media:Register('statusbar', 'Glamour4',			[[Interface\Addons\Ellipsis\StatusBars\Glamour4]])
	Media:Register('statusbar', 'Glamour5',			[[Interface\Addons\Ellipsis\StatusBars\Glamour5]])
	Media:Register('statusbar', 'Glamour6',			[[Interface\Addons\Ellipsis\StatusBars\Glamour6]])
	Media:Register('statusbar', 'Glamour7',			[[Interface\Addons\Ellipsis\StatusBars\Glamour7]])
	Media:Register('statusbar', 'Glass',			[[Interface\Addons\Ellipsis\StatusBars\Glass]])
	Media:Register('statusbar', 'Glaze',			[[Interface\Addons\Ellipsis\StatusBars\Glaze]])
	Media:Register('statusbar', 'Glaze v2',			[[Interface\Addons\Ellipsis\StatusBars\Glaze2]])
	Media:Register('statusbar', 'Gloss',			[[Interface\Addons\Ellipsis\StatusBars\Gloss]])
	Media:Register('statusbar', 'Graphite',			[[Interface\Addons\Ellipsis\StatusBars\Graphite]])
	Media:Register('statusbar', 'Grid',				[[Interface\Addons\Ellipsis\StatusBars\Grid]])
	Media:Register('statusbar', 'Hatched',			[[Interface\Addons\Ellipsis\StatusBars\Hatched]])
	Media:Register('statusbar', 'Healbot',			[[Interface\Addons\Ellipsis\StatusBars\Healbot]])
	Media:Register('statusbar', 'LiteStep',			[[Interface\Addons\Ellipsis\StatusBars\LiteStep]])
	Media:Register('statusbar', 'LiteStepLite',		[[Interface\Addons\Ellipsis\StatusBars\LiteStepLite]])
	Media:Register('statusbar', 'Lyfe',				[[Interface\Addons\Ellipsis\StatusBars\Lyfe]])
	Media:Register('statusbar', 'Melli',			[[Interface\Addons\Ellipsis\StatusBars\Melli]])
	Media:Register('statusbar', 'Melli Dark',		[[Interface\Addons\Ellipsis\StatusBars\MelliDark]])
	Media:Register('statusbar', 'Melli Dark Rough',	[[Interface\Addons\Ellipsis\StatusBars\MelliDarkRough]])
	Media:Register('statusbar', 'Minimalist',		[[Interface\Addons\Ellipsis\StatusBars\Minimalist]])
	Media:Register('statusbar', 'Otravi',			[[Interface\Addons\Ellipsis\StatusBars\Otravi]])
	Media:Register('statusbar', 'Outline',			[[Interface\Addons\Ellipsis\StatusBars\Outline]])
	Media:Register('statusbar', 'Perl',				[[Interface\Addons\Ellipsis\StatusBars\Perl]])
	Media:Register('statusbar', 'Perl v2',			[[Interface\Addons\Ellipsis\StatusBars\Perl2]])
	Media:Register('statusbar', 'Pill',				[[Interface\Addons\Ellipsis\StatusBars\Pill]])
	Media:Register('statusbar', 'Rain',				[[Interface\Addons\Ellipsis\StatusBars\Rain]])
	Media:Register('statusbar', 'Rocks',			[[Interface\Addons\Ellipsis\StatusBars\Rocks]])
	Media:Register('statusbar', 'Round',			[[Interface\Addons\Ellipsis\StatusBars\Round]])
	Media:Register('statusbar', 'Ruben',			[[Interface\Addons\Ellipsis\StatusBars\Ruben]])
	Media:Register('statusbar', 'Runes',			[[Interface\Addons\Ellipsis\StatusBars\Runes]])
	Media:Register('statusbar', 'Skewed',			[[Interface\Addons\Ellipsis\StatusBars\Skewed]])
	Media:Register('statusbar', 'Smooth',			[[Interface\Addons\Ellipsis\StatusBars\Smooth]])
	Media:Register('statusbar', 'Smooth v2',		[[Interface\Addons\Ellipsis\StatusBars\Smoothv2]])
	Media:Register('statusbar', 'Smudge',			[[Interface\Addons\Ellipsis\StatusBars\Smudge]])
	Media:Register('statusbar', 'Steel',			[[Interface\Addons\Ellipsis\StatusBars\Steel]])
	Media:Register('statusbar', 'Striped',			[[Interface\Addons\Ellipsis\StatusBars\Striped]])
	Media:Register('statusbar', 'Tube',				[[Interface\Addons\Ellipsis\StatusBars\Tube]])
	Media:Register('statusbar', 'Water',			[[Interface\Addons\Ellipsis\StatusBars\Water]])
	Media:Register('statusbar', 'Wglass',			[[Interface\Addons\Ellipsis\StatusBars\Wglass]])
	Media:Register('statusbar', 'Wisps',			[[Interface\Addons\Ellipsis\StatusBars\Wisps]])
	Media:Register('statusbar', 'Xeon',				[[Interface\Addons\Ellipsis\StatusBars\Xeon]])
end
