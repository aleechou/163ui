--
-- JSHB - movable frame handling
--

JSHB.moversLocked = true
JSHB.moverFrames = {}

local movers = JSHB.moverFrames
local MOVERPOOL = {}
local FRAMEPOOL = {}

local moverName = 1 -- name that will be given to the mover frame that gets created to identify it
local sourceFrame = 2 -- frame to hide so that we can put up a movement frame
local sizeFrame = 3 -- frame we will use to get the size for the mover frame
local moverTitle = 4 -- title of the mover frame
local moverFrame = 5 -- the mover frame
local moverAnchor = 6 -- table for settings like anchor points (root key, the key before .anchor)
local setupCaller = 7 -- function that will be called to reconfigure the frame, or nil if not needed
local frameDefaults = 8 -- full key path in V["defaults"] (for example) where defaults for positions can be found (root key)
local frameSettings = 9 -- full key path to where the source frame's settings can be found (JSHB.db.timers.<set name> for example)
local anchorKeyPost = 10 -- 
local bgKeyPre = 11 -- Pretext to add in front of normal keynames to allow multiple keys in the same table level
local widthOverride = 12 -- Overrride for width of the mover frame
local heightOverride = 13 -- Overrride for height of the mover frame

-- This is the frame that pops up to allow Direct fram positioning.
local xWidget, yWidget, statusWidget
local function CreateDirectMovementFrame()

	local AceGUI = LibStub("AceGUI-3.0")
	
	local f = AceGUI:Create("Frame")
	f.frame:SetClampedToScreen(true)
	f.frame:SetResizable(false)
	f.frame:ClearAllPoints()
	f.frame:SetPoint("TOP", UIParent, "TOP", 0, -8)
	
	f:SetCallback("OnClose", function(self) JSHB.ToggleMoversLock() end)
	f:SetTitle(JSHB.L["JSHB"] .. " " .. JSHB.L["Frame Positioning"])
	f:SetStatusText(JSHB.L["Click to select a frame to move..."])
	f:SetLayout("Flow")
	f:SetAutoAdjustHeight(false)
	f:SetWidth(436)
	f:SetHeight(118)
	
	-- Disable sizing
	f.sizer_e:Hide()
	f.sizer_s:Hide()
	f.sizer_se:Hide()
	
	-- Create sliders for X and Y positions
	xWidget = AceGUI:Create("Slider")
	xWidget:SetLabel(JSHB.L["X offset"])
	xWidget:SetValue(100)
	xWidget:SetSliderValues( -(math.floor(GetScreenWidth() / 2) ), math.floor(GetScreenWidth() / 2), 1)
	xWidget:SetCallback("OnValueChanged", function(self)
		local oldPoints = { JSHB.DirectMovementFrameTarget:GetPoint() }
		JSHB.DirectMovementFrameTarget:ClearAllPoints()
		JSHB.DirectMovementFrameTarget:SetPoint(oldPoints[1], oldPoints[2], oldPoints[3], self:GetValue(), oldPoints[5])
	end)
	f:AddChild(xWidget)
		
	yWidget = AceGUI:Create("Slider")
	yWidget:SetLabel(JSHB.L["Y offset"])
	yWidget:SetValue(100)
	yWidget:SetSliderValues( -(math.floor(GetScreenHeight() / 2) ), math.floor(GetScreenHeight() / 2), 1)
	yWidget:SetCallback("OnValueChanged", function(self)
		local oldPoints = { JSHB.DirectMovementFrameTarget:GetPoint() }
		JSHB.DirectMovementFrameTarget:ClearAllPoints()
		JSHB.DirectMovementFrameTarget:SetPoint(oldPoints[1], oldPoints[2], oldPoints[3], oldPoints[4], self:GetValue() )
	end)
	f:AddChild(yWidget)
	
	xWidget:SetDisabled(true)
	yWidget:SetDisabled(true)
	return f
end

-- Registers a frame as being movable when JSHB is unlocked.
function JSHB.RegisterMovableFrame(moverName1, sourceFrame1, sizeFrame1, MoverText1, moverAnchor1, setupCaller1,
									defaultPositions1, frameSettings1, anchorKeyPost1, bgKeyPre1, widthOverride1, heightOverride1)

	local c = #movers + 1
	for i=1,#movers do
		if movers[i][moverName] == moverName1 then
			print(JSHB.L["JSHB_PRE"].."\""..moverName1.."\"".." exists, JSHB.RegisterMovableFrame(...) failed!")
			return
		end
	end
	
	movers[c] = tremove(MOVERPOOL) or {} -- recycle
	
	movers[c][1] = moverName1
	movers[c][2] = sourceFrame1
	movers[c][3] = sizeFrame1
	movers[c][4] = MoverText1
	movers[c][5] = movers[c][5] -- nil -- changed for recycling
	movers[c][6] = moverAnchor1
	movers[c][7] = setupCaller1
	movers[c][8] = defaultPositions1
	movers[c][9] = frameSettings1
	movers[c][10] = anchorKeyPost1 or ""
	movers[c][11] = bgKeyPre1
	movers[c][12] = widthOverride1
	movers[c][13] = heightOverride1
	
	return(c)
end

function JSHB.DeregisterMovableFrame(n)
	for i=1,#movers do
		if (movers[i][moverName] == n) then
			tinsert(MOVERPOOL, movers[i])
			tremove(movers, i)
			return
		end
	end
	-- Returns silently if no mover is found with given name.
end

function JSHB.UnlockAllMovers()

	local c
	for i=1,#movers do
		if (movers[i][sourceFrame][1] ~= nil) then
			c = 1
			while (movers[i][sourceFrame][c] ~= nil) do
				movers[i][sourceFrame][c]:Hide()
				c = c + 1
			end
		else
			movers[i][sourceFrame]:Hide()
		end
	end

	-- Setup the direct movement / exact positioning frame
	JSHB.DirectMovementFrameTarget = nil
	JSHB.DirectMovementFrame = CreateDirectMovementFrame()
	
	for i=1,#movers do
		movers[i][moverFrame] = JSHB.MakeFrame(movers[i][moverFrame] or tremove(FRAMEPOOL),
			"Frame", nil, movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2] == nil and UIParent or movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2])
			
		movers[i][moverFrame]:SetParent(movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2] == nil and UIParent or movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2])
		movers[i][moverFrame]:ClearAllPoints()
		movers[i][moverFrame]:SetSize(movers[i][widthOverride] or movers[i][sizeFrame]:GetWidth(), movers[i][heightOverride] or movers[i][sizeFrame]:GetHeight() )
		movers[i][moverFrame]:SetPoint(JSHB.GetActiveAnchor(movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ]) )
		
		movers[i][moverFrame].artwork = movers[i][moverFrame].artwork or movers[i][moverFrame]:CreateTexture()
		movers[i][moverFrame].artwork:ClearAllPoints()
		movers[i][moverFrame].artwork:SetAllPoints(movers[i][moverFrame])
		movers[i][moverFrame].artwork:SetTexture(0, .5, 0, .8)
		movers[i][moverFrame].artwork:SetAlpha(.7)
		
		-- Apply the same border and background effects to the mover so the user has a better idea of positioning with them shown.
		if movers[i][sourceFrame].background and movers[i][sourceFrame].background:IsShown() and movers[i][frameSettings] then
		
			movers[i][moverFrame].background = JSHB.MakeBackground(movers[i][moverFrame], movers[i][frameSettings], movers[i][bgKeyPre], nil, movers[i][moverFrame].background)
			if (movers[i][moverFrame].background) then
				movers[i][moverFrame].background:Show()
			end
			
		elseif movers[i][moverFrame].background then
			movers[i][moverFrame].background:Hide()
		end
		
		movers[i][moverFrame].value = movers[i][moverFrame].value or movers[i][moverFrame]:CreateFontString(nil, "OVERLAY", movers[i][moverFrame])
		movers[i][moverFrame].value:ClearAllPoints()
		movers[i][moverFrame].value:SetJustifyH("CENTER")
		movers[i][moverFrame].value:SetPoint("BOTTOM", movers[i][moverFrame], "TOP", 0, 2)
		movers[i][moverFrame].value:SetFont("Fonts\\ARIALN.TTF", 15, "OUTLINE")
		movers[i][moverFrame].value:SetTextColor(1, 1, 1, 1)
		movers[i][moverFrame].value:SetText(movers[i][moverTitle])

		movers[i][moverFrame]:Show()
		movers[i][moverFrame]:EnableMouse(true)
		movers[i][moverFrame]:SetMovable(true)
		movers[i][moverFrame]:SetClampedToScreen()
		
		-- Setup click interaction for selecting a direct movement frame
		movers[i][moverFrame]:SetScript("OnMouseDown", function(self)
			-- save frame anchors properly
			self.framePoint, self._nil, self.parentPoint, self.xPosition, self.yPosition = self:GetPoint()
			self:StartMoving()
			self._nil, self._nil, self._nil, self.screenX, self.screenY = self:GetPoint()
			if (JSHB.DirectMovementFrameTarget) then
				JSHB.DirectMovementFrameTarget.artwork:SetTexture(0, .5, 0, .8)
			end
			JSHB.DirectMovementFrameTarget = self
			xWidget:SetDisabled(false)
			yWidget:SetDisabled(false)
			self.artwork:SetTexture(.8, .2, 0)
			
			JSHB.DirectMovementFrame:SetStatusText(self.value:GetText() )
			xWidget:SetValue( select(4, self:GetPoint() ) )
			yWidget:SetValue( select(5, self:GetPoint() ) )
		end)
		
		movers[i][moverFrame]:SetScript("OnMouseUp", function(self)
			local fPoint, _, pPoint, x, y = self:GetPoint()
			self:StopMovingOrSizing()
			x = (x - self.screenX) + self.xPosition
			y = (y - self.screenY) + self.yPosition
			self:ClearAllPoints()
			self:SetPoint(self.framePoint, self:GetParent(), self.parentPoint, x, y)
		end)
	end
end

function JSHB.LockAllMovers()

	if JSHB.DirectMovementFrame then JSHB.DirectMovementFrame:Release() end

	local i = #movers
	while (i > 0) and movers[i] do

		movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][1],
		movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2],
		movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][3],		
		movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][4],
		movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][5] = movers[i][moverFrame]:GetPoint()
			
		if (movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2] == UIParent) then movers[i][moverAnchor]["anchor"..movers[i][anchorKeyPost] ][2] = nil end

		-- Destroy the mover frames
		movers[i][moverFrame]:Hide()
		movers[i][moverFrame]:StopMovingOrSizing()
		movers[i][moverFrame]:SetMovable(false)
		movers[i][moverFrame]:EnableMouse(false)
		--movers[i][moverFrame]:RegisterForDrag()
		--movers[i][moverFrame]:SetScript("OnMouseDown", nil)
		--movers[i][moverFrame]:SetScript("OnMouseUp", nil)
		if movers[i][moverFrame].background then
			movers[i][moverFrame].background:Hide()
		end
		movers[i][moverFrame]:SetParent(nil)
		tinsert(FRAMEPOOL, movers[i][moverFrame])
		movers[i][moverFrame] = nil

		-- Run the setup function if one was given to do any frame updating because of the move.
		-- If a Setup function is given, that setup function needs to de-register the mover frame properly.
		if movers[i][setupCaller] then 
			movers[i][setupCaller](movers[i][moverName])
		else
			tinsert(MOVERPOOL, movers[i])
			tremove(movers, i)
		end
		i = i - 1
	end
	collectgarbage("collect")
end


-- Used to show live changes when mover options are changed
function JSHB.RedrawLiveMovers()
	if (not JSHB.moversLocked) then
		JSHB.LockAllMovers()
		JSHB.UnlockAllMovers()
	end
end

function JSHB.ToggleMoversLock()
	JSHB.moversLocked = not JSHB.moversLocked
	if JSHB.moversLocked then -- LOCK
		print(JSHB.L["JSHB_PRE"]..JSHB.L["JSHBLOCKED"])
		JSHB.LockAllMovers()
	else -- UNLOCK
		print(JSHB.L["JSHB_PRE"]..JSHB.L["JSHBUNLOCKED"])
		JSHB.UnlockAllMovers()
	end
end

function JSHB.SetDefaultMoversPositions()
	local relock = false
	if JSHB.moversLocked then
		relock = true
		JSHB.moversLocked = not JSHB.moversLocked
		JSHB.UnlockAllMovers()		
	end
	
	for i=1,#movers do
		local frameName = movers[i][moverFrame]:GetName() -- To get better error reports
		movers[i][moverFrame]:ClearAllPoints()
		movers[i][moverFrame]:SetPoint(JSHB.GetActiveAnchor(movers[i][frameDefaults]["anchor"..movers[i][anchorKeyPost] ]) )
	end
	
	if relock then
		JSHB.moversLocked = not JSHB.moversLocked
		JSHB.LockAllMovers()	
	end
end
