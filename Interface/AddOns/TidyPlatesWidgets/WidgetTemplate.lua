
local widgetPath = "Interface\\Addons\\TidyPlatesWidgets\\MyWidget\\"
local defaultTexture = widgetPath.."art"
local WidgetList = {}

-- Update Graphics
local function UpdateWidgetFrame(frame)
	-- Custom Code I
	--------------------------------------
	if something then 
		-- Do something
	else frame:_Hide() end	
	--------------------------------------
	-- End Custom Code
end

-- Context
local function UpdateWidgetContext(frame, unit)
	local guid = unit.guid
	frame.guid = guid
	
	-- Add to Widget List
	if guid then
		WidgetList[guid] = frame
	end
	
	-- Custom Code II
	--------------------------------------
	if UnitGUID("target") == guid then 
		UpdateWidgetFrame(frame) 
	else
		frame:_Hide()
	end
	--------------------------------------
	-- End Custom Code
end

local function ClearWidgetContext(frame)
	local guid = frame.guid
	if guid then
		WidgetList[guid] = nil
		frame.guid = nil
	end
end

-- Widget Creation
local function CreateWidgetFrame(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:Hide()
	
	-- Custom Code III
	--------------------------------------
	frame:SetHeight(32)
	frame:SetWidth(64)
	frame.Icon = frame:CreateTexture(nil, "OVERLAY")
	frame.Icon:SetAllPoints(frame)	
	frame.Icon:SetTexture(defaultTexture)
	--if not isEnabled then EnableWatcherFrame(true) end
	--------------------------------------
	-- End Custom Code
	
	-- Required Widget Code
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetFrame
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end
	
	return frame
end

TidyPlatesWidgets.CreateMyWidget = CreateWidgetFrame