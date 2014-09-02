

--[[

Create Widget
Track Widget via Table
Widget Search Function (The search function must search the whole library in order to catch duplicates)

FullUpdateWidget Handler
UpdateContext Handler

Callback/Delegate Functions:



--]]


function UpdateWidget(frame)
		-- Check for ID
		local unit = frame.unit
		if not unit then return end
		
		local guid = unit.guid
		
		if not guid then
			-- Attempt to ID widget via Name or Raid Icon
			if unit.type == "PLAYER" then guid = ByName[unit.name]
			elseif unit.isMarked then guid = ByRaidIcon[unit.raidIcon] end
			
			
			if guid then 
				unit.guid = guid	-- Feed data back into unit table		-- Testing
			else
				frame:Hide()
				return
			end
		end
		
		UpdateIconGrid(frame, guid)
		TidyPlates:RequestDelegateUpdate()		-- Delegate Update, For Debuff Widget-Controlled Scale and Opacity Functions
end

local function UpdateWidgetTarget(frame)
	UpdateIconGrid(frame, UnitGUID("target"))
end


-- Context Update (mouseover, target change)
local function UpdateWidgetContextFull(frame, unit)
	local guid = unit.guid
	frame.unit = unit
	frame.guidcache = guid
	
	WidgetList[frame] = true
	if guid then WidgetGUID[guid] = frame end
	
	if unit.isTarget then UpdateAurasByUnitID("target")
	elseif unit.isMouseover then UpdateAurasByUnitID("mouseover") end
	
	local raidicon, name
	if unit.isMarked then
		raidicon = unit.raidIcon
		if guid and raidicon then ByRaidIcon[raidicon] = guid end
	end
	if unit.type == "PLAYER" and unit.reaction == "HOSTILE" then name = unit.name end
	
	CallForWidgetUpdate(guid, raidicon, name)
end

local function UpdateWidgetContextTargetOnly(frame, unit)
	if unit.isTarget then 
		-- UpdateAurasByUnitID("target")
		
	end
end

local UpdateWidgetContext = UpdateWidgetContextFull

local function ClearWidgetContext(frame)
	if frame.guidcache then 
		WidgetGUID[frame.guidcache] = nil 
		frame.unit = nil
	end
	WidgetList[frame] = nil
	
end



--[[
-- Usage:

-- In Your Addon:
local my_widget_list = {}
CreateWidget(my_parent_frame, my_widget_list)

-- You need to create the Enable and Disable functions, and the event watchers.

-- You create the NewWidget, UpdateWidget, UpdateWidgetContext functions
-- Pass the

-- Opin: I think Widget creation should be a global function, which themes could hook and overload



--]]


-- Create the Main Widget Body and Icon Array
local function CreateWidget(parent, widgetlist)
	--if not WatcherIsEnabled then Enable() end
	-- Create Base frame
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(128); frame:SetHeight(32); frame:Show()
	-- Create Icon Array

	-- Functions
	frame._Hide = frame.Hide
	frame.Hide = function() ClearWidgetContext(frame); frame:_Hide() end
	frame:SetScript("OnHide", function() for index = 1, 4 do PolledHideIn(AuraIconFrames[index], 0) end end)	
	frame.Filter = nil
	frame.UpdateContext = UpdateWidgetContext
	frame.Update = UpdateWidgetContext
	frame.UpdateTarget = UpdateWidgetTarget
	return frame
end
