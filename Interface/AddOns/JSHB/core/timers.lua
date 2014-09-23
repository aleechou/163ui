--
-- JSHB timers module
--

local select, mod, ceil, floor, min, tinsert, tremove
	= select, mod, ceil, floor, min, tinsert, tremove

local FRAMEPOOL = {} -- recycle frames

--[[
	Quicksort is faster than table.sort, table.sort also has memory leak issues in WoW's implementation.
	I chose to use a custom Quicksort algorithm for speed and control over the leaks by re-using variables
	and not repeatedly declaring locals for temporary swaps.  Garbage collection is handled at idle times, so
	minimizing the garbage creation is a must.

	arr[x][1] = index of this element representing the timer index number
	arr[x][2] = current cooldown/duration/icd
	
	arr[endi+1] is not sorted and used for the temporary holder to swap
	arr[endi+1][3] is the pivot for the array
	tempPos = position in the array to use for a temporary swap variable
]]
local function QuickSortTimers(arr, start, endi, tempPos)
	if ( (endi - start) < 2) then
		return(arr)
	end 
	arr[tempPos][3] = start -- set pivot
	for i=start+1,endi do
		if (arr[i][2] < arr[arr[tempPos][3] ][2]) then
			-- We're swapping so temporarily assign the old position to the temporary variables
			arr[tempPos][1] = arr[arr[tempPos][3] + 1][1]
			arr[tempPos][2] = arr[arr[tempPos][3] + 1][2]
			
			arr[arr[tempPos][3] + 1][1] = arr[arr[tempPos][3] ][1]
			arr[arr[tempPos][3] + 1][2] = arr[arr[tempPos][3] ][2]
			
			if (i == (arr[tempPos][3] + 1) ) then
				arr[arr[tempPos][3] ][1] = arr[tempPos][1] 
				arr[arr[tempPos][3] ][2] = arr[tempPos][2]
			else
				arr[arr[tempPos][3] ][1] = arr[i][1]
				arr[arr[tempPos][3] ][2] = arr[i][2]
				
				arr[i][1] = arr[tempPos][1]
				arr[i][2] = arr[tempPos][2]
			end
			arr[tempPos][3] = arr[tempPos][3] + 1 -- Increment the pivot variable
		end
	end
	arr = QuickSortTimers(arr, start, arr[tempPos][3]-1, tempPos)
	return QuickSortTimers(arr, arr[tempPos][3]+1, endi, tempPos)
end

local function PrioritizeArray(parent)
	-- Every iteration needs to re-create the array then sort it
	for i=1,#parent.Timers do
		parent.priorityArray[i][1] = i
		parent.priorityArray[i][2] = parent.Timers[i].myRemaining
		parent.priorityArray[i][3] = 0
	end
	parent.priorityArray = QuickSortTimers(parent.priorityArray, 1, #parent.Timers, #parent.Timers+1)
end

local function SetTimerIconPositions(parent, usingPriority)

	-- If this timer set is using the priority system we need to sort based on time remaining
	if usingPriority then
		PrioritizeArray(parent)
	end

	parent._Index = 1
	for i=1,#parent.Timers do
		-- If we are using the priority setting, we need use the sorted order as opposed to simple sequential ordering
		parent._DerivedI = usingPriority and parent.priorityArray[i][1] or i

		if (parent.Timers[parent._DerivedI].myShowWhen == 0) or														-- Always show
			( (parent.inActionFlags[parent._DerivedI] == 1) and (parent.Timers[parent._DerivedI].myShowWhen == 1) ) then	-- In Action + Show only when Active
		
			if parent.myOrientation == "horizontal" then -- Horizontal
			
				if (not parent.myReverse) then -- Normal direction
					parent.Timers[parent._DerivedI]:ClearAllPoints()
					parent.Timers[parent._DerivedI]:SetPoint("LEFT", parent, "LEFT", (parent._Index == 1) and 0 or
						( (parent.iconSize + (JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) ) * (parent._Index - 1) ), 0)
				else
					parent.Timers[parent._DerivedI]:ClearAllPoints()
					parent.Timers[parent._DerivedI]:SetPoint("RIGHT", parent, "RIGHT", (parent._Index == 1) and 0 or
						(-( (parent.iconSize + (JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) ) * (parent._Index - 1) ) ), 0)
				end

			else -- Vertical
				if (not parent.myReverse) then -- Normal direction
				
					parent.Timers[parent._DerivedI]:ClearAllPoints()
					parent.Timers[parent._DerivedI]:SetPoint("BOTTOM", parent, "BOTTOM", 0, (parent._Index == 1) and 0 or
						( (parent.iconSize + (JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) ) * (parent._Index - 1) ) )
				else
					parent.Timers[parent._DerivedI]:ClearAllPoints()
					parent.Timers[parent._DerivedI]:SetPoint("TOP", parent, "TOP", 0, (parent._Index == 1) and 0 or
						(-( (parent.iconSize + (JSHB.GetFrameOffset(parent.Timers[1], "TOP", 1) + JSHB.GetFrameOffset(parent.Timers[1], "BOTTOM", 1) + 2) ) * (parent._Index - 1) ) ) )
				end
			end
		
			parent._Index = parent._Index + 1
			
		elseif (parent.Timers[parent._DerivedI].myShowWhen == 1) and (parent.inActionFlags[parent._DerivedI] ~= 1) then
			parent.Timers[parent._DerivedI]:SetAlpha(0)
		end
	end

	parent:SetSize(
		( (parent.iconSize + -- Width
			(JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) )
			* ( (parent.myOrientation == "vertical") and 1 or (parent._Index - 1) ) ) - 2,
			
		( (parent.iconSize + -- Height
			(JSHB.GetFrameOffset(parent.Timers[1], "TOP", 1) + JSHB.GetFrameOffset(parent.Timers[1], "BOTTOM", 1) + 2) )
			* ( (parent.myOrientation == "horizontal") and 1 or (parent._Index - 1) ) ) - 2
	)
	
	parent:ClearAllPoints()
	if (parent._Index == 1) then
		parent:SetPoint("BOTTOMRIGHT", UIParent, "TOPLEFT", -500, 500) -- No timers actively shown
	else
		parent:SetPoint(JSHB.GetActiveAnchor(parent.anchor) )
	end
end

local function GetTimerPos(self, orientation, reverse, timeLeft, timeMax)
	
	self._TimePercent = (timeLeft / timeMax) * 100
	self._UsableSize = ( (orientation == "horizontal") and self:GetParent():GetWidth() or self:GetParent():GetHeight() ) - self:GetWidth() -- the timer is a square base.
	
	--[[
		Calculate the amount of extra size if there is a backdrop on the timer itself.
		This is end dependant, meaning the 1st offset is the side the timer moves toward, not from.
	]]
	self._BackdropOffset1 = 0
	self._BackdropOffset2 = 0
	if (orientation == "horizontal") then
		self._BackdropOffset1 = JSHB.GetFrameOffset(self, reverse and "RIGHT" or "LEFT")
		self._BackdropOffset2 = JSHB.GetFrameOffset(self, reverse and "LEFT" or "RIGHT")
	else
		self._BackdropOffset1 = JSHB.GetFrameOffset(self, reverse and "TOP" or "BOTTOM")
		self._BackdropOffset2 = JSHB.GetFrameOffset(self, reverse and "BOTTOM" or "TOP")
	end

	-- Return the value based on orientation and reverse (make it positive or negative, properly)
	if ( (orientation == "horizontal") and (not reverse) ) or ( (orientation == "vertical") and (not reverse) ) then	
		return floor( (self._TimePercent * ( (self._UsableSize + (self._BackdropOffset1 + self._BackdropOffset2) ) / 100) ) - self._BackdropOffset1)
	else
		return floor(-( (self._TimePercent * ( (self._UsableSize + (self._BackdropOffset1 + self._BackdropOffset2) ) / 100) ) - self._BackdropOffset1) )
	end	
end

local function GetTimerPosLogarithmic(self, orientation, reverse, timeLeft, timeMax)
	
	self._UsableSize = ( (orientation == "horizontal") and self:GetParent():GetWidth() or self:GetParent():GetHeight() ) - self:GetWidth() -- the timer is a square base.
	self._TotalTimePercent = (timeLeft / timeMax) * 100
	self._TimePadding = 0
	
	-- Calculate positions based off a logarithmic scale
	if (timeLeft < 30) then -- under 30s
	
		self._TimePadding = 0
		self._TotalTimePercent = (timeLeft / min(30, timeMax) ) * 100
		self._UsableSize = self._UsableSize * 0.55
		
	elseif (timeLeft < 60) then -- under 60s
	
		self._TimePadding = self._UsableSize * 0.55
		self._TotalTimePercent = ( (timeLeft - 30) / 30) * 100
		self._UsableSize = self._UsableSize * 0.2
		
	elseif (timeLeft < 300) then -- under 5m
	
		self._TimePadding = self._UsableSize * 0.75
		self._TotalTimePercent = ( (timeLeft - 60) / 240) * 100
		self._UsableSize = self._UsableSize * 0.15
		
	else -- 5m or more
	
		self._TimePadding = self._UsableSize * 0.9
		self._TotalTimePercent = ( (timeLeft - 300) / (timeMax - 300) ) * 100
		self._UsableSize = self._UsableSize - (self._UsableSize * 0.9)
	end
	
	--[[
		Calculate the amount of extra size if there is a backdrop on the timer itself.
		This is end dependant, meaning the 1st offset is the side the timer moves toward, not from.
	]]
	self._BackdropOffset1 = 0
	self._BackdropOffset2 = 0
	if (orientation == "horizontal") then
		self._BackdropOffset1 = JSHB.GetFrameOffset(self, reverse and "RIGHT" or "LEFT")
		self._BackdropOffset2 = JSHB.GetFrameOffset(self, reverse and "LEFT" or "RIGHT")
	else
		self._BackdropOffset1 = JSHB.GetFrameOffset(self, reverse and "TOP" or "BOTTOM")
		self._BackdropOffset2 = JSHB.GetFrameOffset(self, reverse and "BOTTOM" or "TOP")
	end

	-- Return the value based on orientation and reverse (make it positive or negative, properly)
	if ( (orientation == "horizontal") and (not reverse) ) or ( (orientation == "vertical") and (not reverse) ) then	
		return floor( ( (self._TotalTimePercent * ( (self._UsableSize + (self._BackdropOffset1 + self._BackdropOffset2) ) / 100) ) + self._TimePadding) - self._BackdropOffset1)
	else
		return floor(-( ( (self._TotalTimePercent * ( (self._UsableSize + (self._BackdropOffset1 + self._BackdropOffset2) ) / 100) ) + self._TimePadding) - self._BackdropOffset1) )
	end	
end

local TIMER_UPDATEINTERVAL = 0.04
local function SetupTimers(parent, setsName, stationary)

	parent.Timers = parent.Timers or {}

	local index = 1
	for i=1,#JSHB.db.profile.timers[setsName].timers do
	
		-- Error fix introduced with field 17 of timers in v 3.6
		if (JSHB.db.profile.timers[setsName].timers[i][17] == true) or (JSHB.db.profile.timers[setsName].timers[i][17] == false) then
			JSHB.db.profile.timers[setsName].timers[i][17] = nil -- I accidentally re-used this field, OOPS!
		end
		-- End error fix
		
		if ( (JSHB.db.profile.timers[setsName].timers[i][6] == 0) or (JSHB.db.profile.timers[setsName].timers[i][6] == GetSpecialization() ) ) and -- Talent tree check
			( (JSHB.db.profile.timers[setsName].timers[i][9] ~= true) or  -- Not only if known check
			(JSHB.db.profile.timers[setsName].timers[i][9] == "ICOOLDOWN") or -- "Only if Known" does not apply to ICDs, procs are never "known"
			(JSHB.CheckIfKnown(JSHB.db.profile.timers[setsName].timers[i][1] or JSHB.db.profile.timers[setsName].timers[i][2]) ) ) then

			parent.Timers[index] = JSHB.MakeFrame(parent.Timers[index] or tremove(FRAMEPOOL), "Frame", nil, parent)
			parent.Timers[index]:SetParent(parent)
			parent.Timers[index]:ClearAllPoints()
			parent.Timers[index]:SetAlpha(0) -- Don't want it to show on the UI when being constructed.
			parent.Timers[index]:SetSize(JSHB.db.profile.timers[setsName].iconsize, JSHB.db.profile.timers[setsName].iconsize)
			
			-- Handle orientation
			if JSHB.db.profile.timers[setsName].layout == "horizontal" then -- Horizontal
				if not JSHB.db.profile.timers[setsName].reverse then -- Normal direction
					if stationary then
						parent.Timers[index]:SetPoint("LEFT", parent, "LEFT", (index == 1) and 0 or
							( (JSHB.db.profile.timers[setsName].iconsize +
							(JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) ) * (index - 1) ), 0)
					else
						parent.Timers[index]:SetPoint("LEFT", parent, "LEFT", 0, 0)
					end
				else -- Reversed direction
					if stationary then
						parent.Timers[index]:SetPoint("RIGHT", parent, "RIGHT", (index == 1) and 0 or
							(-( (JSHB.db.profile.timers[setsName].iconsize +
							(JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) ) * (index - 1) ) ), 0)
					else
						parent.Timers[index]:SetPoint("RIGHT", parent, "RIGHT", 0, 0)
					end
				end
			else -- Vertical
				if not JSHB.db.profile.timers[setsName].reverse then -- Normal direction
					if stationary then
						parent.Timers[index]:SetPoint("BOTTOM", parent, "BOTTOM", (index == 1) and 0 or
							( (JSHB.db.profile.timers[setsName].iconsize +
							(JSHB.GetFrameOffset(parent.Timers[1], "BOTTOM", 1) + JSHB.GetFrameOffset(parent.Timers[1], "TOP", 1) + 2) ) * (index - 1) ), 0)
					else
						parent.Timers[index]:SetPoint("BOTTOM", parent, "BOTTOM", 0, 0)
					end
				else -- Reversed direction
					if stationary then
						parent.Timers[index]:SetPoint("TOP", parent, "TOP", (index == 1) and 0 or
							(-( (JSHB.db.profile.timers[setsName].iconsize +
							(JSHB.GetFrameOffset(parent.Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(parent.Timers[1], "RIGHT", 1) + 2) ) * (index - 1) ) ), 0)
					else
						parent.Timers[index]:SetPoint("TOP", parent, "TOP", 0, 0)
					end
				end			
			end

			-- The Icon and backdrop / border need a parent frame nested inside the top level timer frame for animations.			
			parent.Timers[index].agparent = parent.Timers[index].agparent or CreateFrame("Frame", nil, parent.Timers[index])
			parent.Timers[index].agparent:SetParent(parent.Timers[index])
			parent.Timers[index].agparent:ClearAllPoints()
			parent.Timers[index].agparent:SetAllPoints(parent.Timers[index])
			
			parent.Timers[index].agparent.Icon = parent.Timers[index].agparent.Icon or parent.Timers[index].agparent:CreateTexture(nil, "BACKGROUND")
			parent.Timers[index].agparent.Icon:ClearAllPoints()
			parent.Timers[index].agparent.Icon:SetTexture("Interface\\ICONS\\INV_Misc_QuestionMark") -- Just a place-holder, this will change in the timer script.
			if JSHB.db.profile.timers[setsName].enabletexcoords then
				parent.Timers[index].agparent.Icon:SetTexCoord(unpack(JSHB.db.profile.timers[setsName].texcoords) )
			else
				parent.Timers[index].agparent.Icon:SetTexCoord(0, 1, 0, 1)
			end
			parent.Timers[index].agparent.Icon:SetAllPoints(parent.Timers[index].agparent)

			-- Create the Background and border if the user wants one (Parented to the Icon, to account for spin)
			parent.Timers[index].agparent.gapOffsets = JSHB.DeepCopy(parent.Timers[index].gapOffsets)
			parent.Timers[index].agparent.background = JSHB.MakeBackground(parent.Timers[index].agparent, JSHB.db.profile.timers[setsName], "timer", nil, parent.Timers[index].agparent.background)

			-- Manually adjust offsets because we parented to a sub-frame.
			parent.Timers[index].gapOffsets = JSHB.DeepCopy(parent.Timers[index].agparent.gapOffsets)

			-- Setup the timer font if needed
			if (JSHB.db.profile.timers[setsName].timers[i][7] ~= "NONE") then
			
				parent.Timers[index].fntparent = parent.Timers[index].fntparent or CreateFrame("Frame", nil, parent.Timers[index])
				parent.Timers[index].fntparent:SetParent(parent.Timers[index])
				parent.Timers[index].fntparent:ClearAllPoints()
				parent.Timers[index].fntparent:SetAllPoints(parent.Timers[index])
				
				parent.Timers[index].fntparent.value = parent.Timers[index].fntparent.value or parent.Timers[index].fntparent:CreateFontString(nil, "OVERLAY")
				parent.Timers[index].fntparent.value:ClearAllPoints()
				
				-- Anchor the font according to specified position
				if (JSHB.db.profile.timers[setsName].timers[i][7] == "TOP") then
				
					parent.Timers[index].fntparent.value:SetJustifyH("CENTER")
					parent.Timers[index].fntparent.value:SetJustifyV("BOTTOM")
					parent.Timers[index].fntparent.value:SetPoint("BOTTOM", parent.Timers[index], "TOP", 0, (1) + JSHB.GetFrameOffset(parent.Timers[index], "TOP") )
				
				elseif (JSHB.db.profile.timers[setsName].timers[i][7] == "BOTTOM") then
				
					parent.Timers[index].fntparent.value:SetJustifyH("CENTER")
					parent.Timers[index].fntparent.value:SetJustifyV("TOP")
					parent.Timers[index].fntparent.value:SetPoint("TOP", parent.Timers[index], "BOTTOM", 0, (-1) + JSHB.GetFrameOffset(parent.Timers[index], "BOTTOM") )
				
				elseif (JSHB.db.profile.timers[setsName].timers[i][7] == "LEFT") then
				
					parent.Timers[index].fntparent.value:SetJustifyH("RIGHT")
					parent.Timers[index].fntparent.value:SetJustifyV("CENTER")
					parent.Timers[index].fntparent.value:SetPoint("RIGHT", parent.Timers[index], "LEFT", (-1) + JSHB.GetFrameOffset(parent.Timers[index], "LEFT"), 0)
				
				elseif (JSHB.db.profile.timers[setsName].timers[i][7] == "RIGHT") then
				
					parent.Timers[index].fntparent.value:SetJustifyH("LEFT")
					parent.Timers[index].fntparent.value:SetJustifyV("CENTER")
					parent.Timers[index].fntparent.value:SetPoint("LEFT", parent.Timers[index], "RIGHT", (1) + JSHB.GetFrameOffset(parent.Timers[index], "RIGHT"), 0)
				
				else -- CENTER
				
					parent.Timers[index].fntparent.value:SetJustifyH("CENTER")
					parent.Timers[index].fntparent.value:SetJustifyV("CENTER")
					parent.Timers[index].fntparent.value:SetPoint("CENTER", parent.Timers[index], "CENTER", 0, 0)
				end

				parent.Timers[index].fntparent.value:SetFont(JSHB.GetActiveFont(JSHB.db.profile.timers[setsName].timefont) )
				if JSHB.db.profile.timers[setsName].timerfontcolorstatic then
					parent.Timers[index].fntparent.value:SetTextColor(unpack(JSHB.db.profile.timers[setsName].timerfontcolor) )
				end
				
				if JSHB.db.profile.timers[setsName].enabletimershadow then
					parent.Timers[index].fntparent.value:SetShadowColor(unpack(JSHB.db.profile.timers[setsName].timershadowcolor) )
					parent.Timers[index].fntparent.value:SetShadowOffset(unpack(JSHB.db.profile.timers[setsName].timershadowoffset) )
				end
				
				parent.Timers[index].fntparent.value:SetText("")
				parent.Timers[index].fntparent.value:SetAlpha(1)
				parent.Timers[index].fntparent:Show()
			elseif parent.Timers[index].fntparent then
				parent.Timers[index].fntparent:Hide()				
			end
			
			parent.Timers[index].stacksparent = parent.Timers[index].stacksparent or CreateFrame("Frame", nil, parent.Timers[index])
			parent.Timers[index].stacksparent:SetParent(parent.Timers[index])
			parent.Timers[index].stacksparent:ClearAllPoints()
			parent.Timers[index].stacksparent:SetAllPoints(parent.Timers[index])
			
			parent.Timers[index].stacksparent.stacks = parent.Timers[index].stacksparent.stacks or parent.Timers[index].stacksparent:CreateFontString(nil, "OVERLAY")
			parent.Timers[index].stacksparent.stacks:ClearAllPoints()
			parent.Timers[index].stacksparent.stacks:SetJustifyH("RIGHT")
			parent.Timers[index].stacksparent.stacks:SetJustifyV("BOTTOM")
			parent.Timers[index].stacksparent.stacks:SetPoint("BOTTOMRIGHT", parent.Timers[index], "BOTTOMRIGHT", -3, 1)
			parent.Timers[index].stacksparent.stacks:SetFont(JSHB.GetActiveFont(JSHB.db.profile.timers[setsName].stackfont) )
			parent.Timers[index].stacksparent.stacks:SetTextColor(unpack(JSHB.db.profile.timers[setsName].stackfontcolor), 1)
			parent.Timers[index].stacksparent.stacks:SetText("")
			parent.Timers[index].stacksparent.stacks:SetAlpha(1)
					
			parent.inActionFlags[index] = 0
			
			-- Script to control this individual timer
			parent.Timers[index].myIndex = index
			parent.Timers[index].noTexture = true
			parent.Timers[index].updateTimer = 0
			parent.Timers[index].myShowWhen = (JSHB.db.profile.timers[setsName].timers[i][18] == nil) and 0 or JSHB.db.profile.timers[setsName].timers[i][18]
			parent.Timers[index].myOrientation = JSHB.db.profile.timers[setsName].layout
			parent.Timers[index].myReverse = JSHB.db.profile.timers[setsName].reverse
			parent.Timers[index].myBaseSize = JSHB.db.profile.timers[setsName].iconsize
			parent.Timers[index].myCurrentSize = JSHB.db.profile.timers[setsName].iconsize
			parent.Timers[index].timerTable = JSHB.db.profile.timers[setsName].timers[i]
			parent.Timers[index].myPoints = { parent.Timers[index]:GetPoint() }
			parent.Timers[index].logarithmic = (JSHB.db.profile.timers[setsName].logarithmic == true) and true or nil
			parent.Timers[index].myRemaining = 0
			parent.Timers[index].showtimewithoneletter = JSHB.db.profile.timers[setsName].showtimewithoneletter
			parent.Timers[index].doICD = nil
			if (JSHB.db.profile.timers[setsName].timers[i][4] == "ICOOLDOWN") then
				parent.Timers[index].doICD = true
			end
			
			parent.Timers[index]:SetScript("OnUpdate", function(self, elapsed)

					self.updateTimer = self.updateTimer + elapsed
					if self.updateTimer < TIMER_UPDATEINTERVAL then return else self.updateTimer = 0 end

					self.__texture, self.__duration, self.__remaining, self.__stacks =
						JSHB.GetTimerInfo(self.timerTable[1], self.timerTable[2], self.timerTable[3], self.timerTable[4], self.timerTable[5], self.timerTable[16], self.timerTable[17])
						
					-- we save the current remaining duration / cooldown / icd for prioritizing
					self.myRemaining = (self.__remaining > 0) and self.__remaining or 0

					-- Do we need to deal with an ICD?  If so, we need to update the derived time data for this ICD
					if (self.doICD) and (not self.__texture) and (self.__remaining > 0) then
						self.timerTable[17] = GetTime()
					end

					if self.__texture and (not UnitIsDeadOrGhost("player") ) then

						if self.timerTable[8] and (not self.flashTime) then
							self.flashTime = ( (self.__duration * .25) < 10) and (self.__duration * .25) or 10
							self.flashChangeTime = .4
							self.flashCycles = ceil(self.flashTime / self.flashChangeTime)
							self.flashDown = true
						end
					
						if (not (self:GetParent().inActionFlags[self.myIndex] == 1) ) or (self.isFlashing and (self.__remaining > self.flashTime) ) then
						
							if self.isFlashing then
								self.isFlashing = nil
								self.agparent:SetAlpha(1)
							end
						
							if self.noTexture then
								self.agparent.Icon:SetTexture(self.__texture)
								self.noTexture = nil
							end

							-- We need to reposition the icons when an action flag is changed
							if self:GetParent().stationary then
								if (self:GetParent().inActionFlags[self.myIndex] ~= 1) then
									self:GetParent().inActionFlags[self.myIndex] = 1
									SetTimerIconPositions(self:GetParent(), self:GetParent().prioritize and true or nil)
									self:GetParent().updatePriorityTimer = 0 -- Clear the timer because it was just updated
								end
							else
								self:GetParent().inActionFlags[self.myIndex] = 1
							end
							
							if self.timerTable[13] then 
								self:SetAlpha(self.timerTable[14])
							else
								self:SetAlpha(1)
							end
						end

						if (not self:GetParent().stationary) then
							self:ClearAllPoints()
							self.__position = self.logarithmic and GetTimerPosLogarithmic(self, self.myOrientation, self.myReverse, self.__remaining, self.__duration)
												or GetTimerPos(self, self.myOrientation, self.myReverse, self.__remaining, self.__duration)
							self:SetPoint(self.myPoints[1], self.myPoints[2], self.myPoints[3],
								(self.myOrientation == "horizontal") and self.__position or 0, (self.myOrientation == "vertical") and self.__position or 0)
						end

						-- Handle flashing.
						if self.timerTable[8] and (self.__remaining <= self.flashTime) then
							if (not self.isFlashing) then
								self.isFlashing = true
							else
								self.__rt = (self.flashTime - self.__remaining)
								self.flashDown = (mod(ceil(self.__rt / self.flashChangeTime), 2) == 0) and true or nil
								self.__rct = mod(self.__rt, self.flashChangeTime)
								self.agparent:SetAlpha(	self.flashDown and ( ( (self.flashChangeTime / 1) * self.__rct) * 10) or (1 - ( ( (self.flashChangeTime / 1) * self.__rct) * 10) )	)
							end
						end
						
						-- Handle Alpha ramp up or down	
						if self.timerTable[13] and (not self.isFlashing) then
							self:SetAlpha( ( (self.timerTable[15] - self.timerTable[14]) - ( (self.timerTable[15] - self.timerTable[14]) * (self.__remaining / self.__duration) ) ) + self.timerTable[14]) 
						end
						
						if not (self.timerTable[7] == "NONE") then
							self.fntparent.value:SetText(JSHB.FormatTimeText(self.__remaining, (self.__remaining <= JSHB.db.profile.minfortenths) and true or false,
									not (JSHB.db.profile.timers[setsName].timerfontcolorstatic), self.showtimewithoneletter) )
						end
						self.stacksparent.stacks:SetText( (self.__stacks > 1) and tostring(self.__stacks) or "")

					elseif (self:GetParent().inActionFlags[self.myIndex] == 1) then

						if self.isFlashing then
							self.isFlashing = nil
							self.agparent:SetAlpha(1)
						end
						
						if not (self.timerTable[7] == "NONE") then
							self.fntparent.value:SetText("")
						end
						self.stacksparent.stacks:SetText("")
						self:SetAlpha(self:GetParent().stationary and (self.timerTable[20] ~= nil and self.timerTable[20] or 0.4) or 0)
						
						-- We need to reposition the icons when an action flag is changed
						if self:GetParent().stationary then
							if (self:GetParent().inActionFlags[self.myIndex] ~= 0) then
								self:GetParent().inActionFlags[self.myIndex] = 0
								SetTimerIconPositions(self:GetParent(), self:GetParent().prioritize and true or nil)
								self:GetParent().updatePriorityTimer = 0 -- Clear the timer because it was just updated
							end
						else
							self:GetParent().inActionFlags[self.myIndex] = 0
						end
					end
				end)
				
			if stationary then -- 3.7 addition for stationary timers
				texture = JSHB.GetTimerIconTexture(parent.Timers[index].timerTable[1], parent.Timers[index].timerTable[2])
				if texture then
					parent.Timers[index].agparent.Icon:SetTexture(texture)
					parent.Timers[index].noTexture = nil
				end
				parent.Timers[index]:SetAlpha(parent.Timers[index].timerTable[20] ~= nil and parent.Timers[index].timerTable[20] or 0.4)
			end
			
			parent.Timers[index]:Show()
			index = index + 1
		end
	end
	return(index - 1)
end

local TIMERSET_UPDATEINTERVAL = 0.09
local TIMER_PRIORITY_UPDATEINTERVAL = 0.2
local index = 1
function JSHB.SetupTimersModule()

	if (not JSHB.F.TimerSets) then JSHB.F.TimerSets = {} end
	
	-- Destruction	
	if JSHB.F.TimerSets then
		local i = 1
		while (JSHB.F.TimerSets[i] ~= nil) do
			JSHB.F.TimerSets[i]:Hide()
			JSHB.F.TimerSets[i]:SetScript("OnUpdate", nil)
			JSHB.F.TimerSets[i]:UnregisterAllEvents()
			JSHB.DeregisterMovableFrame("JSHB_MOVER_TIMERSET_"..tostring(i) )
			JSHB.F.TimerSets[i]:SetParent(nil)
			
			-- Now clean up the actual timers for this bar's set
			if (JSHB.F.TimerSets[i].Timers) then
				for c = #JSHB.F.TimerSets[i].Timers, 1, -1 do
					JSHB.F.TimerSets[i].Timers[c]:Hide()
					JSHB.F.TimerSets[i].Timers[c]:SetScript("OnUpdate", nil)
					JSHB.F.TimerSets[i].Timers[c]:UnregisterAllEvents()
					JSHB.F.TimerSets[i].Timers[c]:SetParent(nil)
					tinsert(FRAMEPOOL, JSHB.F.TimerSets[i].Timers[c]) -- recycle
					tremove(JSHB.F.TimerSets[i].Timers, c)
				end
			end
			i = i + 1
		end
	end

	-- Construction
	index = 1
	for key,val in pairs(JSHB.db.profile.timers) do

		if JSHB.db.profile.timers[key].enabled and (#JSHB.db.profile.timers[key].timers > 0) then
	
			-- Create the Set Frame
			JSHB.F.TimerSets[index] = JSHB.MakeFrame(JSHB.F.TimerSets[index], "Frame", nil, JSHB.db.profile.timers[key].anchor[2] or UIParent)
			JSHB.F.TimerSets[index]:SetParent(JSHB.db.profile.timers[key].anchor[2] or UIParent)
			JSHB.F.TimerSets[index]:ClearAllPoints()
			if (not JSHB.db.profile.timers[key].stationary) then
				JSHB.F.TimerSets[index]:SetSize(JSHB.db.profile.timers[key].width, JSHB.db.profile.timers[key].height)
			else
				JSHB.F.TimerSets[index]:SetSize(	JSHB.db.profile.timers[key].iconsize * (#JSHB.db.profile.timers[key].timers),
													JSHB.db.profile.timers[key].iconsize) -- temporary size - need to fix it later.
			end
			
			if JSHB.db.profile.timers[key].stationary then
				if (JSHB.db.profile.timers[key].stationaryanchorpoint == nil) or (JSHB.db.profile.timers[key].stationaryanchorpoint == "CENTER") then
					JSHB.db.profile.timers[key].anchor[1] = "CENTER"
				elseif (JSHB.db.profile.timers[key].layout == "horizontal") then
					if (JSHB.db.profile.timers[key].stationaryanchorpoint == "FORWARD") then -- and not reverse?
						JSHB.db.profile.timers[key].anchor[1] = "LEFT"
					else
						JSHB.db.profile.timers[key].anchor[1] = "RIGHT"
					end
				else -- vertical
					if (JSHB.db.profile.timers[key].stationaryanchorpoint == "FORWARD") then
						JSHB.db.profile.timers[key].anchor[1] = "BOTTOM"
					else
						JSHB.db.profile.timers[key].anchor[1] = "TOP"
					end
				end
			else
				JSHB.db.profile.timers[key].anchor[1] = "CENTER"
			end
			JSHB.F.TimerSets[index]:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.timers[key].anchor) )
			JSHB.F.TimerSets[index]:SetAlpha(0)
			
			-- Create the Background and border if the user wants one
			JSHB.F.TimerSets[index].background = JSHB.MakeBackground(JSHB.F.TimerSets[index], JSHB.db.profile.timers[key], nil, nil, JSHB.F.TimerSets[index].background)

			-- Setup the script for handling the Timer Set
			JSHB.F.TimerSets[index].updatePriorityTimer = 0
			JSHB.F.TimerSets[index].inActionFlags = {}
			JSHB.F.TimerSets[index].anchor = JSHB.db.profile.timers[key].anchor
			JSHB.F.TimerSets[index].iconSize = JSHB.db.profile.timers[key].iconsize
			JSHB.F.TimerSets[index].myOrientation = JSHB.db.profile.timers[key].layout
			JSHB.F.TimerSets[index].myReverse = JSHB.db.profile.timers[key].reverse
			JSHB.F.TimerSets[index].updateTimer = 0
			JSHB.F.TimerSets[index].prioritize = nil
			JSHB.F.TimerSets[index].stationary = nil
			if JSHB.db.profile.timers[key].stationary then
				JSHB.F.TimerSets[index].stationary = true
				if JSHB.db.profile.timers[key].prioritize then
					JSHB.F.TimerSets[index].prioritize = true
				end
			end
			
			-- Setup the actual timers for the set before the set script
			local indexedTimers = SetupTimers(JSHB.F.TimerSets[index], key, JSHB.db.profile.timers[key].stationary)
			
			-- If we are using the priority setting, we need to create a table to be used to sort timers based on times
			if JSHB.db.profile.timers[key].prioritize then
				JSHB.F.TimerSets[index].priorityArray = JSHB.F.TimerSets[index].priorityArray and wipe(JSHB.F.TimerSets[index].priorityArray) or {}
				for i = 1, indexedTimers do
					if (JSHB.F.TimerSets[index].priorityArray[i]) then
						JSHB.F.TimerSets[index].priorityArray[i][1] = i
						JSHB.F.TimerSets[index].priorityArray[i][2] = 0.00
						JSHB.F.TimerSets[index].priorityArray[i][3] = 0
					else
						JSHB.F.TimerSets[index].priorityArray[i] = { i, 0.00, 0 }
					end
				end
				if JSHB.F.TimerSets[index].priorityArray[indexedTimers + 1] then -- Used for table-swapping to not re-create locals when sorting
					JSHB.F.TimerSets[index].priorityArray[indexedTimers + 1][1] = 0
					JSHB.F.TimerSets[index].priorityArray[indexedTimers + 1][2] = 0
					JSHB.F.TimerSets[index].priorityArray[indexedTimers + 1][3] = 0
				else
					JSHB.F.TimerSets[index].priorityArray[indexedTimers + 1] = { 0, 0, 0 }
				end
				-- Now we need to clean up extra (unneeded fields in the array if this is a re-construction)
				if (#JSHB.F.TimerSets[index].priorityArray > (indexedTimers + 1) ) then
					while (#JSHB.F.TimerSets[index].priorityArray > (indexedTimers + 1) ) do
						tremove(JSHB.F.TimerSets[index].priorityArray, #JSHB.F.TimerSets[index].priorityArray)
					end
				end
			end
			
			local w = (JSHB.db.profile.timers[key].stationary and JSHB.F.TimerSets[index].Timers[1]) and 
					( ( (JSHB.db.profile.timers[key].iconsize +
					(JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "RIGHT", 1) + 2) )
					* ((JSHB.db.profile.timers[key].layout == "vertical") and 1 or (8) ) ) - 2) or nil
					
			local h = (JSHB.db.profile.timers[key].stationary and JSHB.F.TimerSets[index].Timers[1]) and 
					( ( (JSHB.db.profile.timers[key].iconsize +
					(JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "TOP", 1) + JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "BOTTOM", 1) + 2) )
					* ((JSHB.db.profile.timers[key].layout == "horizontal") and 1 or (8) ) ) - 2) or nil
			
			JSHB.RegisterMovableFrame(
				"JSHB_MOVER_TIMERSET_"..tostring(index), --"MOVER_TIMERSET_"..JSHB.F.TimerSets[index]:GetName(),
				JSHB.F.TimerSets[#JSHB.F.TimerSets],
				JSHB.F.TimerSets[#JSHB.F.TimerSets],
				JSHB.L["Timer Bar "..strsub(key, 9)],
				JSHB.db.profile.timers[key],
				(index == 1) and JSHB.SetupTimersModule or nil, -- last one gets the setup function (below)
				JSHB.defaults.profile.timers[key],
				JSHB.db.profile.timers[key],
				nil,
				nil,
				w, -- width override
				h -- height override				
			)
			
			-- Now we can set a proper block frame size, if using stationary icons instead of moving timers.
			if JSHB.db.profile.timers[key].stationary and JSHB.F.TimerSets[index].Timers[1] then
				JSHB.F.TimerSets[index]:SetSize(
					-- WIDTH
					( (JSHB.db.profile.timers[key].iconsize +
						(JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "RIGHT", 1) + 2) )
						* ((JSHB.db.profile.timers[key].layout == "vertical") and 1 or (indexedTimers - 1) ) ) - 2,
					-- HEIGHT
					( (JSHB.db.profile.timers[key].iconsize +
						(JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "TOP", 1) + JSHB.GetFrameOffset(JSHB.F.TimerSets[index].Timers[1], "BOTTOM", 1) + 2) )
						* ((JSHB.db.profile.timers[key].layout == "horizontal") and 1 or (indexedTimers - 1) ) ) - 2
				)
			end
			
			-- Setup Icon initial states
			if JSHB.db.profile.timers[key].stationary then
				SetTimerIconPositions(JSHB.F.TimerSets[index])
			end
			
			JSHB.F.TimerSets[index]:SetScript("OnUpdate", function(self, elapsed)
			
				self.updateTimer = self.updateTimer + elapsed
				
				if self.prioritize then
					self.updatePriorityTimer = self.updatePriorityTimer + elapsed
				end
				
				if self.updateTimer < TIMERSET_UPDATEINTERVAL then return else self.updateTimer = 0 end
			
				-- Overrides take precidence over normal alpha
				if C_PetBattles.IsInBattle() then
				
					self:SetAlpha(0) -- Hide when in a pet battle
					
				elseif JSHB.db.profile.timers[key].deadoverride and UnitIsDeadOrGhost("player") then
				
					self:SetAlpha(JSHB.db.profile.timers[key].deadoverridealpha)
					
				elseif JSHB.db.profile.timers[key].mountoverride and (IsMounted() or UnitUsingVehicle("player") ) then
				
					self:SetAlpha(JSHB.db.profile.timers[key].mountoverridealpha)
					
				elseif JSHB.db.profile.timers[key].oocoverride and (not InCombatLockdown() ) then
				
					self:SetAlpha(JSHB.db.profile.timers[key].oocoverridealpha)
					
				elseif tContains(self.inActionFlags, 1) then -- Timers set their value based on activity.
				
					self:SetAlpha(JSHB.db.profile.timers[key].activealpha)
				
				else
					self:SetAlpha(JSHB.db.profile.timers[key].inactivealpha)
				end
				
				-- Need to update the icons if we are using priority so refreshed buffs are re-ordered
				if self.prioritize and (self.updatePriorityTimer > TIMER_PRIORITY_UPDATEINTERVAL) then
					SetTimerIconPositions(self, self.prioritize and true or nil)
					self.updatePriorityTimer = 0
				end
			end)			
			JSHB.F.TimerSets[index]:Show()
			index = index + 1
		end
	end
end
