BetterPowerBarAltDB = BetterPowerBarAltDB or {}

PlayerPowerBarAlt:SetMovable(true)

-- Don't manage the frame for me, thanks, and don't adjust other frames to account for it
UIPARENT_MANAGED_FRAME_POSITIONS["PlayerPowerBarAlt"] = nil
for k, v in next, UIPARENT_MANAGED_FRAME_POSITIONS do
	v.playerPowerBarAlt = nil
end

local locked = true
local moving = nil
local usurped = nil

local cvar, cvarLabel = "alternateResourceText", "ALTERNATE_RESOURCE_TEXT"

local overlay = CreateFrame("Frame", nil, PlayerPowerBarAlt)
overlay:SetAllPoints()

local texture = overlay:CreateTexture()
texture:SetAllPoints()
texture:SetTexture(1, 1, 1, 0.1)
texture:Hide()
overlay.texture = texture

overlay:EnableMouse(true)
overlay:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" and not locked then
		local frame = self:GetParent()
		frame:ClearAllPoints()
		frame:StartMoving()
		moving = true
	end
end)

overlay:SetScript("OnMouseUp", function(self, button)
	if button == "RightButton" then
		locked = not locked
		if locked then
			self.texture:Hide()
			self:EnableMouseWheel(false)
		else
			self.texture:Show()
			self:EnableMouseWheel(true)
		end

	elseif button == "MiddleButton" then
		if not locked then
			self:GetParent():SetScale(1)
			BetterPowerBarAltDB.scale = nil
		end

	elseif moving then
		moving = nil
		local frame = self:GetParent()
		frame:StopMovingOrSizing()
		frame:SetUserPlaced(false)

		local point, _, _, x, y = frame:GetPoint(1)
		BetterPowerBarAltDB.point = point
		BetterPowerBarAltDB.x = x
		BetterPowerBarAltDB.y = y

	elseif IsShiftKeyDown() then
		local state = not GetCVarBool(cvar) and 1
		SetCVar(cvar, state, cvarLabel)
	end
end)

overlay:SetScript("OnMouseWheel", function(self, delta)
	local frame = self:GetParent()
	local scale = frame:GetScale() + (0.1 * delta)
	frame:SetScale(scale)
	BetterPowerBarAltDB.scale = scale
end)

overlay:SetScript("OnShow", function(self)
	local frame = self:GetParent()
	-- use the counterBar region for clicks if its shown
	if frame.counterBar:IsShown() then
		self:SetAllPoints(frame.counterBar)
	else
		self:SetAllPoints(frame)
	end

	local parent = PlayerPowerBarAlt:GetParent()
	if parent == UIParent then
		if BetterPowerBarAltDB.point then
			frame:ClearAllPoints()
			frame:SetPoint(BetterPowerBarAltDB.point, BetterPowerBarAltDB.x, BetterPowerBarAltDB.y)
		end

		if BetterPowerBarAltDB.scale then
			frame:SetScale(BetterPowerBarAltDB.scale)
		end
	elseif not usurped then
		usurped = true
		local suspect = parent:GetName()
		print("|cff33ff99BetterPowerBarAlt|r:", "Another addon is positioning the frame.", type(suspect) == "string" and ("(%s)"):format(suspect) or "")
	end
end)

overlay:SetScript("OnHide", function(self)
	-- the last power value isn't cleared so it'll be shown if it isn't used again but the frame is (DMF counter/timer setup)
	self:GetParent().statusFrame.text:SetText("")
end)

overlay:SetScript("OnEnter", function(self) UnitPowerBarAlt_OnEnter(self:GetParent()) end)
overlay:SetScript("OnLeave", function(self) UnitPowerBarAlt_OnLeave(self:GetParent()) end)

-- in case the frame is under the ui or offscreen
SLASH_BETTERPOWERBARALT1 = "/bpba"
SlashCmdList["BETTERPOWERBARALT"] = function(input)
	if input:trim() == "reset" then
		PlayerPowerBarAlt:ClearAllPoints()
		PlayerPowerBarAlt:SetPoint("CENTER")
		print("|cff33ff99BetterPowerBarAlt|r:", "Frame position reset")
	else
		print("Usage: /bpba reset")
		print("Reset the frame position")
	end
end