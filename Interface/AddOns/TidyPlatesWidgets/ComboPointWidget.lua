
------------------------------
-- Combo Point Widget
------------------------------

--[[

	- Proc Widget

--]]
local comboWidgetPath = "Interface\\Addons\\TidyPlatesWidgets\\ComboWidget\\"
local artpath = "Interface\\Addons\\TidyPlatesWidgets\\ComboWidget\\"
local artfile = artpath.."PointArt.tga"
local grid = .0625
local monkOffset = 10

local WidgetList = {}

local Anticipation =  GetSpellInfo(115190)

local function GetRoguePoints()
	local points = GetComboPoints("player", "target")

	if points and points > 0 then

		-- Anticipation
		if points > 4 then
			local name, _, _, count = UnitAura("player", Anticipation)

			if name and count > 0 then
				points = points + count
			end
		end
	end

	return points
end

local function GetPaladinPoints()
	local points = UnitPower("player", SPELL_POWER_HOLY_POWER)

	if points > 0 then points = points + monkOffset end
	return points
end

local function GetMonkPoints()		-- 0 to 4
	local points = UnitPower("player", SPELL_POWER_CHI)
	local maxPoints = UnitPowerMax("player", SPELL_POWER_CHI)

	if points > 0 and maxPoints == 4 then
		points = points + monkOffset
	end

	return points
end

local function DummyFunction()
	return nil
end


local GetPoints
local PlayerClass = select(2,UnitClassBase("player"))

if PlayerClass == "ROGUE" or PlayerClass == "DRUID" then
	GetPoints = GetRoguePoints
elseif PlayerClass == "MONK" then
	GetPoints = GetMonkPoints
elseif PlayerClass == "PALADIN" then
	--GetPoints = GetPaladinPoints
	GetPoints = DummyFunction
else
	GetPoints = DummyFunction
end

-- Update Graphics
local function UpdateWidgetFrame(frame)
		local points
		if UnitExists("target") then
			points = GetPoints()
		end

		if points and points > 0 then
			--frame.Icon:SetTexture(comboWidgetPath..tostring(points))
			frame.Icon:SetTexCoord(0, 1, grid*(points-1), grid *(points))

			--object:SetTexCoord(objectstyle.left or 0, objectstyle.right or 1, objectstyle.top or 0, objectstyle.bottom or 1)

			frame:Show()
		else frame:_Hide() end
end

-- Context
local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid

	-- Add to Widget List
	if guid then
		if frame.guid then WidgetList[frame.guid] = nil end
		frame.guid = guid
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
WatcherFrame:RegisterEvent("UNIT_FLAGS")

local function WatcherFrameHandler(frame, event, unitid)
		local guid = UnitGUID("target")
		if UnitExists("target") then
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
	frame.Icon:SetPoint("CENTER", frame, "CENTER")
	frame.Icon:SetHeight(16)
	frame.Icon:SetWidth(64)

	frame.Icon:SetTexture(artfile)
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