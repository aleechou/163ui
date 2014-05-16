
------------------------------
-- Combo Point Widget
------------------------------

--[[

	- Proc Widget

--]]
local comboWidgetPath = "Interface\\Addons\\TidyPlatesWidgets\\ComboWidget\\"

local WidgetList = {}

local Anticipation =  GetSpellInfo(115190)

-- Update Graphics
local function UpdateWidgetFrame(frame)
		local points
		if UnitExists("target") then points = GetComboPoints("player", "target") end
		if points and points > 0 then

			-- Anticipation

			if points > 4 then
				local name, _, _, count = UnitAura("player", Anticipation)

				if name and count > 0 then
					points = points + count
				end
			end

			frame.Icon:SetTexture(comboWidgetPath..tostring(points))
			frame:Show()
		else frame:_Hide() end
end

-- Context
local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid
	frame.guid = guid

	-- Add to Widget List
	if guid then
		WidgetList[guid] = frame
	end

	-- Update Widget
	if UnitGUID("target") == guid then
		UpdateWidgetFrame(frame)
	else
		frame:_Hide()
	end
end

local function ClearWidgetContext(frame)
	local guid = frame.guid
	if guid then
		WidgetList[guid] = nil
		frame.guid = nil
	end
end

-- Watcher Frame
local WatcherFrame = CreateFrame("Frame", nil, WorldFrame )
local isEnabled = false
WatcherFrame:RegisterEvent("UNIT_COMBO_POINTS")
WatcherFrame:RegisterEvent("UNIT_AURA")

local function WatcherFrameHandler(frame, event, unitid)
		local guid = UnitGUID("target")
		if guid then
			local widget = WidgetList[guid]
			if widget then UpdateWidgetFrame(widget) end				-- To update all, use: for guid, widget in pairs(WidgetList) do UpdateWidgetFrame(widget) end
		end
end

local function EnableWatcherFrame(arg)
	if arg then
		WatcherFrame:SetScript("OnEvent", WatcherFrameHandler); isEnabled = true
	else WatcherFrame:SetScript("OnEvent", nil); isEnabled = false end
end

-- Widget Creation
local function CreateWidgetFrame(parent)

	-- Required Widget Code
	local frame = CreateFrame("Frame", nil, parent)
	frame:Hide()

	-- Custom Code
	frame:SetHeight(32)
	frame:SetWidth(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)
	--frame.Icon:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -2, -2)
	--frame.Icon:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 2, 2)

	-- End Custom Code

	-- Required Widget Code
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetFrame
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end
	if not isEnabled then EnableWatcherFrame(true) end
	return frame
end

TidyPlatesWidgets.CreateComboPointWidget = CreateWidgetFrame