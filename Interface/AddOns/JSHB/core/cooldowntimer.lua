--
-- JSHB - cooldown module for showing time remaining for timers, etc.
--

local ICON_SIZE = 36 --the normal size for an icon (don't change this)
local DAY, HOUR, MINUTE = 86400, 3600, 60 --used for formatting text
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5 --used for formatting text at transition points
local HALFDAYISH, HALFHOURISH, HALFMINUTEISH = DAY/2 + 0.5, HOUR/2 + 0.5, MINUTE/2 + 0.5 --used for calculating next update times

local MIN_SCALE = 0.5 --the minimum scale we want to show cooldown counts at, anything below this will be hidden
local MIN_DURATION = 2.5 --the minimum duration to show cooldown text for
local EXPIRING_DURATION = 3 --the minimum number of seconds a cooldown must be to use to display in the expiring format

--returns both what text to display, and how long until the next update
function JSHB.getTimeText(s)

	local db = JSHB.profiles.cooldowns
	
	--format text as seconds when below a minute
	if s < MINUTEISH then
		local seconds = tonumber(JSHB.Round(s) )
		if seconds > EXPIRING_DURATION then
			return JSHB.RGBToHex(JSHB.GetActiveColor(db["secondscolor"]) )..'%d|r', seconds, s - (seconds - 0.51)
		else
			return JSHB.RGBToHex(JSHB.GetActiveColor(db["expiringcolor"]) )..'%.1f|r', s, 0.051
		end
	--format text as minutes when below an hour
	elseif s < HOURISH then
		local minutes = tonumber(JSHB.Round(s/MINUTE) )
		return JSHB.RGBToHex(JSHB.GetActiveColor(db["minutescolor"]) )..'%dm|r', minutes, minutes > 1 and (s - (minutes*MINUTE - HALFMINUTEISH) ) or (s - MINUTEISH)
	--format text as hours when below a day
	elseif s < DAYISH then
		local hours = tonumber(JSHB.Round(s/HOUR) )
		return JSHB.RGBToHex(JSHB.GetActiveColor(db["hourscolor"]) )..'%dh|r', hours, hours > 1 and (s - (hours*HOUR - HALFHOURISH) ) or (s - HOURISH)
	--format text as days
	else
		local days = tonumber(JSHB.Round(s/DAY) )
		return JSHB.RGBToHex(JSHB.GetActiveColor(db["dayscolor"]) )..'%dd|r', days,  days > 1 and (s - (days*DAY - HALFDAYISH) ) or (s - DAYISH)
	end
end

local function Timer_Stop(self)
	self.enabled = nil
	self:Hide()
end

local function Timer_ForceUpdate(self)
	self.nextUpdate = 0
	self:Show()
end

local function Timer_OnSizeChanged(self, width, height)
	local fontScale = E.Round(width) / ICON_SIZE
	if (fontScale == self.fontScale) then
		return
	end

	self.fontScale = fontScale
	if (fontScale < MIN_SCALE) then
		self:Hide()
	else
		local db = JSHB.profiles.cooldowns

		self.text:SetFont(JSHB.GetActiveFont(db["font"], 1), fontScale * JSHB.GetActiveFont(db["font"], 2), JSHB.GetActiveFont(db["font"], 3) )
		self.text:SetShadowColor(JSHB.GetActiveColor(db["shadowcolor"]) )
		self.text:SetShadowOffset(JSHB.GetActiveOffset(db["fontshadowoffset"]) )
		if self.enabled then
			Timer_ForceUpdate(self)
		end
	end
end

local function Timer_OnUpdate(self, elapsed)

	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local remain = self.duration - (GetTime() - self.start)

		if remain > 0.01 then
			if (self.fontScale * self:GetEffectiveScale() / UIParent:GetScale() ) < MIN_SCALE then
				self.text:SetText("")
				self.nextUpdate  = 1
			else
				local formatStr, time, nextUpdate = JSHB.getTimeText(remain)
				self.text:SetFormattedText(formatStr, time)
				self.nextUpdate = nextUpdate
			end
		else
			Timer_Stop(self)
		end
	end
end

local function Timer_Create(self)

	local scaler = CreateFrame('Frame', nil, self)
	scaler:SetAllPoints(self)

	local timer = CreateFrame('Frame', nil, scaler)
	timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", Timer_OnUpdate)

	local text = timer:CreateFontString(nil, "OVERLAY")
	text:SetPoint("CENTER", 1, 1)
	text:SetJustifyH("CENTER")
	timer.text = text

	Timer_OnSizeChanged(timer, scaler:GetSize() )
	scaler:SetScript("OnSizeChanged", function(self, ...) Timer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end
