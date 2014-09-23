--
-- JSHB crowd control module
--

local function stopCCTimer(spellID, targetGUID)
	for i=1,4 do
		if (JSHB.F.CrowdControl.ccFrame[i].active == true) and (JSHB.F.CrowdControl.ccFrame[i].spellID == spellID) and (JSHB.F.CrowdControl.ccFrame[i].guid == targetGUID) then

			JSHB.F.CrowdControl.ccFrame[i]:SetAlpha(0)
			JSHB.F.CrowdControl.ccFrame[i].guid = 0
			JSHB.F.CrowdControl.ccFrame[i].spellID = 0
			JSHB.F.CrowdControl.ccFrame[i].active = false
			JSHB.F.CrowdControl.ccFrame[i].killtime = 0

			if JSHB.F.CrowdControl.ccFrame[i].timer then
				JSHB.F.CrowdControl.ccFrame[i].timer.enabled = nil
				JSHB.F.CrowdControl.ccFrame[i].timer:Hide()
			end
			break -- Found the right one, stop the loop
		end
	end
end

local function addCCTimer(spellID, targetGUID, expireTime)
	for i=2,4 do -- Position Wyvern first, as it's only a 30s duration.
		if (JSHB.F.CrowdControl.ccFrame[i].active == false) or
			tContains({ 19386, 6358, 6770 }, spellID) then -- Wyvern Sting, Seduction, Sap
			
			-- Slot 1 is secondary CC abilities, easier to assign a static to 1.
			if tContains({ 19386, 6358, 6770 }, spellID) then
				i = 1 
			end

			JSHB.F.CrowdControl.ccFrame[i].Icon:ClearAllPoints()
			JSHB.F.CrowdControl.ccFrame[i].Icon:SetAllPoints(JSHB.F.CrowdControl.ccFrame[i])
			JSHB.F.CrowdControl.ccFrame[i].Icon:SetTexture(select(3, GetSpellInfo(spellID) ))
			if JSHB.db.profile.crowdcontrol.enabletexcoords then
				JSHB.F.CrowdControl.ccFrame[i].Icon:SetTexCoord(unpack(JSHB.db.profile.crowdcontrol.texcoords) )
			end

			if JSHB.moversLocked then
				JSHB.F.CrowdControl.ccFrame[i]:SetAlpha(1) 
			end

			JSHB.F.CrowdControl.ccFrame[i].killtime = GetTime() + expireTime + .2
			JSHB.F.CrowdControl.ccFrame[i].guid = targetGUID -- Need to know the target id associated with this frame.
			JSHB.F.CrowdControl.ccFrame[i].spellID = spellID
			JSHB.F.CrowdControl.ccFrame[i].active = true

			local timer = JSHB.F.CrowdControl.ccFrame[i].timer or JSHB.Timer_Create(JSHB.F.CrowdControl.ccFrame[i])
			timer.start = GetTime()
			timer.duration = expireTime
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()
			break
		end
	end
end

local function refreshCCTimer(spellID, targetGUID, expireTime)
	for i=1,4 do
		if (JSHB.F.CrowdControl.ccFrame[i].active == true) and (JSHB.F.CrowdControl.ccFrame[i].spellID == spellID) and (JSHB.F.CrowdControl.ccFrame[i].guid == targetGUID) then

			JSHB.F.CrowdControl.ccFrame[i].killtime = GetTime() + expireTime + .2
			local timer = JSHB.F.CrowdControl.ccFrame[i].timer or JSHB.Timer_Create(JSHB.F.CrowdControl.ccFrame[i])
			timer.start = GetTime()
			timer.duration = expireTime
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()
			break
		end
	end
end

function JSHB.SetupCrowdControlModule(lockName)

	-- Deconstruction
	if JSHB.F.CrowdControl then
		JSHB.F.CrowdControl:Hide()
		JSHB.F.CrowdControl.ccFrame[1]:SetScript("OnUpdate", nil)
		JSHB.F.CrowdControl.ccFrame[1]:UnregisterAllEvents()
		for i=1,4 do
			JSHB.F.CrowdControl.ccFrame[i]:SetAlpha(0)
		end
		JSHB.DeregisterMovableFrame("MOVER_CROWDCONTROL")
		JSHB.F.CrowdControl:SetParent(nil)
		--JSHB.F.CrowdControl = nil
	end

	if not JSHB.db.profile.crowdcontrol.enabled then return end

	-- Construction
	local CROWDCONTROL_UPDATEINTERVAL = 0.15

	-- Create the Frame
	JSHB.F.CrowdControl = JSHB.MakeFrame(JSHB.F.CrowdControl, "Frame", "JSHB_CROWDCONTROL", JSHB.db.profile.crowdcontrol.anchor[2] or UIParent)
	JSHB.F.CrowdControl:SetParent(JSHB.db.profile.crowdcontrol.anchor[2] or UIParent)
	JSHB.F.CrowdControl:ClearAllPoints()
	JSHB.F.CrowdControl:SetSize(50, 50) -- Temporary, will set it after we get offsets
	JSHB.F.CrowdControl:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.crowdcontrol.anchor) )

	JSHB.F.CrowdControl.ccFrame = {}
	
	for i=1,4 do -- Allocating 4 frames, more than enough, low overhead

		JSHB.F.CrowdControl.ccFrame[i] = JSHB.MakeFrame(JSHB.F.CrowdControl.ccFrame[i], "Frame", nil, JSHB.F.CrowdControl)
		JSHB.F.CrowdControl.ccFrame[i]:SetParent(JSHB.F.CrowdControl)
		JSHB.F.CrowdControl.ccFrame[i]:ClearAllPoints()
		JSHB.F.CrowdControl.ccFrame[i]:SetSize(JSHB.db.profile.crowdcontrol.iconsize, JSHB.db.profile.crowdcontrol.iconsize)
		JSHB.F.CrowdControl.ccFrame[i]:SetPoint("CENTER", JSHB.F.CrowdControl, "CENTER") -- Temporary
		
		JSHB.F.CrowdControl.ccFrame[i].background = JSHB.MakeBackground(JSHB.F.CrowdControl.ccFrame[i], JSHB.db.profile.crowdcontrol, nil, JSHB.F.CrowdControl.ccFrame[i].background)
		
		JSHB.F.CrowdControl.ccFrame[i]:ClearAllPoints() -- Now that we made the backdrop/border we have offsets to use.

		local x = ( (i-1) * (JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[i], "LEFT", 1) + 
			JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[i], "RIGHT", 1) + JSHB.db.profile.crowdcontrol.iconsize + 2) )
			
		if JSHB.db.profile.crowdcontrol.anchor[4] >= 0 then -- Expand to Right
			JSHB.F.CrowdControl.ccFrame[i]:SetPoint("TOPLEFT", JSHB.F.CrowdControl, "TOPLEFT", x, 0)
		else -- Expand to Left
			JSHB.F.CrowdControl.ccFrame[i]:SetPoint("TOPRIGHT", JSHB.F.CrowdControl, "TOPRIGHT", -x, 0)				
		end

		JSHB.F.CrowdControl.ccFrame[i].Icon = JSHB.F.CrowdControl.ccFrame[i].Icon or JSHB.F.CrowdControl.ccFrame[i]:CreateTexture(nil, "BACKGROUND")
		JSHB.F.CrowdControl.ccFrame[i].Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up") -- Temporary Texture
		
		if JSHB.db.profile.crowdcontrol.enabletexcoords then
			JSHB.F.CrowdControl.ccFrame[i].Icon:SetTexCoord(unpack(JSHB.db.profile.crowdcontrol.texcoords) )
		else
			JSHB.F.CrowdControl.ccFrame[i].Icon:SetTexCoord(0, 1, 0, 1)
		end

		JSHB.F.CrowdControl.ccFrame[i]:SetAlpha(0)
		JSHB.F.CrowdControl.ccFrame[i]:Show()		
		JSHB.F.CrowdControl.ccFrame[i].guid = 0
		JSHB.F.CrowdControl.ccFrame[i].spellID = 0
		JSHB.F.CrowdControl.ccFrame[i].active = false
	end
	
	-- Properly set the host frame's size for the movers functionality
	JSHB.F.CrowdControl:SetSize(
		( (JSHB.db.profile.crowdcontrol.iconsize +
			(JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[1], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[1], "RIGHT", 1) + 2) ) * 3) - 
				JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[1], "LEFT", 1) - JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[1], "RIGHT", 1) - 2,
					JSHB.db.profile.crowdcontrol.iconsize)
					
	-- Register the mover frame
	JSHB.RegisterMovableFrame(
		"MOVER_CROWDCONTROL",
		JSHB.F.CrowdControl,
		JSHB.F.CrowdControl,
		JSHB.L["Crowd Control"],
		JSHB.db.profile.crowdcontrol,
		JSHB.SetupCrowdControlModule,
		JSHB.defaults.profile.crowdcontrol,
		JSHB.db.profile.crowdcontrol
	)
	
	-- First frame calls the update routine.
	JSHB.F.CrowdControl.ccFrame[1].updateTimer = 0
	JSHB.F.CrowdControl.ccFrame[1]:SetScript("OnUpdate", function(s, elapsed)

		s.updateTimer = s.updateTimer + elapsed
		if s.updateTimer > CROWDCONTROL_UPDATEINTERVAL then
			s._j = 1
			for i=1,4 do
				if (JSHB.F.CrowdControl.ccFrame[i].active == true) then
					if (JSHB.F.CrowdControl.ccFrame[i].killtime < GetTime() ) then
						stopCCTimer(JSHB.F.CrowdControl.ccFrame[i].spellID, JSHB.F.CrowdControl.ccFrame[i].guid)
					else
						s._x = ( (s._j-1) * (JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[i], "LEFT", 1) + 
							JSHB.GetFrameOffset(JSHB.F.CrowdControl.ccFrame[i], "RIGHT", 1) + JSHB.db.profile.crowdcontrol.iconsize + 2) )
					
						if JSHB.db.profile.crowdcontrol.anchor[4] >= 0 then -- Expand to Right
							JSHB.F.CrowdControl.ccFrame[i]:SetPoint("TOPLEFT", JSHB.F.CrowdControl, "TOPLEFT", s._x, 0)
						else -- Expand to Left
							JSHB.F.CrowdControl.ccFrame[i]:SetPoint("TOPRIGHT", JSHB.F.CrowdControl, "TOPRIGHT", -s._x, 0)				
						end
						s._j = s._j + 1
					end
				end
			end
		end
	end)
	
	-- Event handler
	JSHB.F.CrowdControl.ccFrame[1]:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	JSHB.F.CrowdControl.ccFrame[1]:SetScript("OnEvent", function(s, event, ...)
	
		s._, s._subEvent, s._, s._sourceGUID, s._, s._, s._, s._destGUID, s._, s._destFlags, s._, s._spellId = ...
		
		if (s._subEvent == "SPELL_AURA_APPLIED") and (s._sourceGUID == UnitGUID("player") ) then

			-- Hunter Stuff
			if (s._spellId == 3355) then -- Freezing trap Aura
				addCCTimer(1499, s._destGUID, -- Freezing trap spell id
					(bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or (60 * (GetSpecialization() == 3 and 1.3 or 1) ) ) -- account for trap mastery
			elseif (s._spellId == 19386) then -- wyvern
				addCCTimer(19386, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 30) -- wyvern

			-- Warlock Stuff
			elseif (s._spellId == 118699) then -- Fear (feared)
				addCCTimer(118699, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 20)-- 5782??
			elseif (s._spellId == 710) then -- Banish (banished)
				addCCTimer(710, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 30)
			elseif (s._spellId == 1098) then -- Enslave Demon (enslaved)
				addCCTimer(1098, s._destGUID, 300)
			elseif (s._spellId == 6358) then -- Seduction (seduced)
				addCCTimer(6358, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 30)
			
			-- Rogue Stuff
			elseif (s._spellId == 6770) then -- Sap
				addCCTimer(6770, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 60) -- Sap
			elseif (s._spellId == 2094) then -- Blind
				addCCTimer(2094, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 60) -- Blind
			end
			
		elseif (s._subEvent == "SPELL_AURA_REFRESH") and (s._sourceGUID == UnitGUID("player") ) then
		
			-- Hunter Stuff
			if (s._spellId == 3355) then -- Freezing Trap Aura
				refreshCCTimer(1499, s._destGUID,
					(bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or (60 * (GetSpecialization() == 3 and 1.3 or 1) ) ) -- account for trap mastery
				
			-- Warlock Stuff
			elseif (s._spellId == 118699) then -- Fear (feared)
				refreshCCTimer(118699, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 20) -- 5782??
			elseif (s._spellId == 710) then -- Banish (banished)
				refreshCCTimer(710, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 30)
			elseif (s._spellId == 1098) then -- Enslave Demon (enslaved)
				refreshCCTimer(1098, s._destGUID, 300)
			elseif (s._spellId == 6358) then -- Seduction (seduced)
				refreshCCTimer(6358, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 30)
			
			-- Rogue Stuff
			elseif (s._spellId == 6770) then -- Sap
				addCCTimer(6770, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 60) -- Sap
			elseif (s._spellId == 2094) then -- Blind
				addCCTimer(2094, s._destGUID, (bit.band(s._destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) > 0) and 8 or 60) -- Blind
			end
			
			
		elseif (s._subEvent == "SPELL_AURA_REMOVED") and (s._sourceGUID == UnitGUID("player") ) then
		
			-- Hunter Stuff
			if (s._spellId == 3355) then -- Freezing Trap Aura
				stopCCTimer(1499, s._destGUID)
			elseif (s._spellId == 19386) then -- wyvern
				stopCCTimer(19386, s._destGUID) -- wyvern
				
			-- Warlock Stuff
			elseif (s._spellId == 118699) then -- Fear (feared)
				stopCCTimer(118699, s._destGUID) -- 5782??
			elseif (s._spellId == 710) then -- Banish (banished)
				stopCCTimer(710, s._destGUID)
			elseif (s._spellId == 1098) then -- Enslave Demon (enslaved)
				stopCCTimer(1098, s._destGUID)
			elseif (s._spellId == 6358) then -- Seduction (seduced)
				stopCCTimer(6358, s._destGUID)
			
			-- Rogue Stuff
			elseif (s._spellId == 6770) then -- Sap
				stopCCTimer(6770, s._destGUID)
			elseif (s._spellId == 2094) then -- Blind
				stopCCTimer(2094, s._destGUID)
			end
		end	
	end)
	
	JSHB.F.CrowdControl:Show()
end
