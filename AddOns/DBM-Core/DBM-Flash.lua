-- globals
DBM.Flash = {}
-- locals
local flashFrame = DBM.Flash
local t
local duration
local elapsed = 0

--------------------
--  Create flasher  --
--------------------
local flasher = CreateFrame("Frame", "DBMFlash", UIParent)
flasher:Hide()
flasher:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",})
flasher:SetAllPoints(UIParent)
flasher:SetFrameStrata("BACKGROUND")

local shaker = CreateFrame("Frame", "DBMShake", UIParent)
shaker:Hide()
shaker:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",})
shaker:SetAllPoints(UIParent)
shaker:SetFrameStrata("BACKGROUND")

------------------------
--  OnUpdate Handler  --
------------------------
do
	flasher:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + e
		if elapsed >= t then
			self:Hide()
			self:SetAlpha(0)
			return
		end
		-- quadratic fade in/out
		self:SetAlpha(-(elapsed / (duration / 2) - 1)^2 + 1)
	end)
	flasher:Hide()
end

do
	shaker:SetScript("OnShow", function(self)
		self.elapsed = 0
		self:SetAlpha(0)
	end)
	shaker:SetScript("OnUpdate", function(self, elapsed)
		elapsed = self.elapsed + elapsed
		if elapsed >= 0.8 then
			self:Hide()
			self:SetAlpha(0)
			return
		end
		local alpha = elapsed % 0.4
		if elapsed > 0.2 then
			alpha = 0.4 - alpha
		end
		self:SetAlpha(alpha * 5)
		self.elapsed = elapsed
	end)
	shaker:Hide()
end

function flashFrame:Show(red, green, blue, dur, alpha)
	if not DBM.Options.ShowFlashFrame then return end
	local r, g, b, a = red or 1, green or 0, blue or 0, alpha or 0.3
	t = dur or 0.4
	duration = dur
	elapsed = 0
	flasher:SetAlpha(0)
	flasher:SetBackdropColor(r, g, b, a)
	flasher:Show()
end

function flashFrame:IsShown()
	return flasher and flasher:IsShown()
end

function flashFrame:Shake(red, green, blue, alpha)
	if not DBM.Options.ShowShakeFrame then return end	
	local r, g, b, a = red or 1, green or 0, blue or 0, alpha or 0.5	
	shaker:SetBackdropColor(r, g, b, a)
	if flashFrame:IsShown() then flasher:Hide() end	
	shaker:Show()
end

function flashFrame:Hide()
	flasher:Hide()
	shaker:Hide()
end