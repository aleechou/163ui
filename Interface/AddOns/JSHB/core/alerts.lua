--
-- JSHB alerts module
--

local mod, strupper, select, pairs, unpack, tonumber, floor, GetSpellInfo, UnitAura, UnitCastingInfo
	= mod, strupper, select, pairs, unpack, tonumber, floor, GetSpellInfo, UnitAura, UnitCastingInfo
	
local FRAMEPOOL = {} -- For re-using frames

-- Numerics are quicker compares than strings.
local _Buff = 0
local _Debuff = 1
local _Cast = 2
local _Health = 3
local _PetHealth = 4

JSHB.totalAlertIcons = 0

--[[
	This function tests for the alert on a specific target
	returns: (name if found or nil), (texture if found or nil), (time remaining if found or nil), (targetGUID if found or nil), (stacks if found or nil)
]]
local function checkTargetForAlert(caller, target)

	if (caller.alertTrigger == _Debuff) then
	
		caller.___name, caller.____, caller.___texture, caller.___stacks, caller.____, caller.___duration, caller.___expires
			= UnitAura(target, caller.checkID and GetSpellInfo(caller.checkID) or caller.checkName, nil, "HARMFUL")
		caller.___calculatedRemaining = caller.___expires and (caller.___expires - GetTime() ) or 0
		
	elseif (caller.alertTrigger == _Buff) then
	
		caller.___name, caller.____, caller.___texture, caller.___stacks, caller.____, caller.___duration, caller.___expires
			= UnitAura(target, caller.checkID and GetSpellInfo(caller.checkID) or caller.checkName, nil, "HELPFUL")
		caller.___calculatedRemaining = caller.___expires and (caller.___expires - GetTime() ) or 0
		
	elseif (caller.alertTrigger == _Cast) then
	
		caller.___name, caller.____, caller.____, caller.___texture, caller.____, caller.___endTime = UnitCastingInfo(target)
		if ( caller.___name ) then
			caller.___name = strupper(caller.___name)
			if (caller.checkName) then
				caller.___name = (caller.___name == caller.checkName) and caller.___name or nil
			else
				caller.___name = (caller.___name == strupper(select(1, GetSpellInfo(caller.checkID) ) ) ) and caller.___name or nil
			end
			caller.___calculatedRemaining = caller.___endTime and (caller.___endTime / 1000 - GetTime() ) or 0
		end
		
	elseif (caller.alertTrigger == _Health) then

		caller.___name = nil
		if ( (UnitHealth("player") / UnitHealthMax("player") ) <= caller.healthpercent) and (not UnitIsDeadOrGhost("player") ) then
			caller.___name = "HEALTH"
			caller.___texture = "Interface\\Icons\\INV_MISC_BANDAGE_WINDWOOL_HEAVY"
			caller.___calculatedRemaining = 0
		end
		
	elseif (caller.alertTrigger == _PetHealth) then

		caller.___name = nil
		if (UnitExists("pet") ) and ( (UnitHealth("pet") / UnitHealthMax("pet") ) <= caller.healthpercent) and (not UnitIsDeadOrGhost("pet") ) then
			caller.___name = "PETHEALTH"
			caller.___texture = "Interface\\Icons\\Ability_Hunter_MendPet"
			caller.___calculatedRemaining = 0
		end
		
	end
	
	return (caller.___name and caller.___name or nil), (caller.___name and caller.___texture or nil), (caller.___name and (caller.___calculatedRemaining > 0 and caller.___calculatedRemaining or 0) or nil), (caller.___name and UnitGUID(target) ), (caller.___name and caller.___stacks or nil)
end

--[[
	returns (name), (texture), (remainingTime), (targetGUID), (stacks)
]]
local function checkForAlert(caller)

	if (caller.target == "raid") or (caller.target == "raidpet") then	
		if IsInRaid() then
			if IsInInstance() then 
				caller.__maxPlayers = select(5, GetInstanceInfo() ) 
			else
				caller.__maxPlayers = 40
			end

			for i=1,caller.__maxPlayers do
				caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, caller.target..i)
				if ( caller.__name ) then
					return (caller.__name), (caller.__texture), (caller.__remainingTime), (caller.__targetGUID), (caller.__stacks)
				end
			end
		end
		return (nil), (nil), (nil), (nil), (nil)

	elseif (caller.target == "party") or (caller.target == "partypet") then
		
		if (caller.target == "party") then
			caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, "player")
		else
			caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, "pet")
		end
		if ( caller.__name ) then
			return (caller.__name), (caller.__texture), (caller.__remainingTime), (caller.__targetGUID), (caller.__stacks)
		end
		if IsInGroup() then
			for i=1,GetNumGroupMembers() do
				caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, caller.target..i)
				if ( caller.__name ) then
					return (caller.__name), (caller.__texture), (caller.__remainingTime), (caller.__targetGUID), (caller.__stacks)
				end
			end
		end
		return (nil), (nil), (nil), (nil), (nil)
		
	elseif (caller.target == "arena") then
	
		caller.__inInstance, caller.__instanceType = IsInInstance()
		if caller.__inInstance and (caller.__instanceType == "arena") then
			for i=1,5 do
				caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, caller.target..i)
				if ( caller.__name ) then
					return (caller.__name), (caller.__texture), (caller.__remainingTime), (caller.__targetGUID), (caller.__stacks)
				end
			end
		end
		return (nil), (nil), (nil), (nil), (nil)
		
	elseif (caller.target == "boss") then
		for i=1,4 do
			caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, caller.target..i)
			if ( caller.__name ) then
				return (caller.__name), (caller.__texture), (caller.__remainingTime), (caller.__targetGUID), (caller.__stacks)
			end
		end
		return (nil), (nil), (nil), (nil), (nil)
	end

	-- Last check is the exact target name
	caller.__name, caller.__texture, caller.__remainingTime, caller.__targetGUID, caller.__stacks = checkTargetForAlert(caller, caller.target)
	if ( caller.__name ) then
		return (caller.__name), (caller.__texture), (caller.__remainingTime), (caller.__targetGUID), (caller.__stacks)
	end
	return (nil), (nil), (nil), (nil), (nil) -- No match
end

local function repositionFrames(caller)
	caller.____index = 1
	for i=1,JSHB.totalAlertIcons do
		if JSHB.F.Alerts[i].active then
		
			JSHB.F.Alerts[i]:ClearAllPoints()

			-- Flip expanding left to right or right to left depending on anchor point X
			caller.____xPos = ( (JSHB.db.profile.alerts.icons.iconsize +
						(JSHB.GetFrameOffset(JSHB.F.Alerts[1], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.Alerts[1], "RIGHT", 1) + 2) )
							* mod(caller.____index - 1, 5) )
			
			caller.____yPos = (JSHB.db.profile.alerts.icons.iconsize +  -- Vertical Offset
						(JSHB.GetFrameOffset(JSHB.F.Alerts[1], "TOP", 1) + JSHB.GetFrameOffset(JSHB.F.Alerts[1], "BOTTOM", 1) + 2) )
							* floor( (caller.____index - 1) / 5)

			if JSHB.db.profile.alerts.anchor[4] >= 0 then
				JSHB.F.Alerts[i]:SetPoint("TOPLEFT", JSHB.F.AlertIconsHost, "TOPLEFT", caller.____xPos, -caller.____yPos)
			else
				JSHB.F.Alerts[i]:SetPoint("TOPRIGHT", JSHB.F.AlertIconsHost, "TOPRIGHT", -caller.____xPos, -caller.____yPos)
			end
			caller.____index = caller.____index + 1
		end	
	end
end

function JSHB.SetupAlertsModule()

	if (not JSHB.F.Alerts) then JSHB.F.Alerts = {} end

	-- Destruction
	local i = 1
	while JSHB.F.Alerts[i] ~= nil do
		if (JSHB.F.Alerts[i].shine) then
			AutoCastShine_AutoCastStop(JSHB.F.Alerts[i].shine)
		end
		JSHB.F.Alerts[i]:Hide()
		JSHB.F.Alerts[i]:SetScript("OnUpdate", nil)
		JSHB.F.Alerts[i]:ClearAllPoints()
		JSHB.F.Alerts[i]:UnregisterAllEvents()
		JSHB.F.Alerts[i]:SetParent(nil)
		tinsert(FRAMEPOOL, JSHB.F.Alerts[i]) -- recycle
		JSHB.F.Alerts[i] = nil
		i = i + 1
	end
	
	-- Clean up the mover frame	
	if JSHB.F.AlertIconsHost then
		JSHB.F.AlertIconsHost:Hide()
		JSHB.F.AlertIconsHost:ClearAllPoints()
		JSHB.F.AlertIconsHost:UnregisterAllEvents()
		JSHB.DeregisterMovableFrame("MOVER_ALERT_ICONS")
		JSHB.F.AlertIconsHost:SetParent(nil)
--		JSHB.F.AlertIconsHost = nil -- recycle
	end
	
	JSHB.totalAlertIcons = 0

	-- Construction
	local ALERT_UPDATEINTERVAL = 0.08
	local key,val
	local index = 1
	for key,val in pairs(JSHB.db.profile.alerts.alerts) do

		if JSHB.db.profile.alerts.alerts[key] and JSHB.db.profile.alerts.alerts[key].enabled then
	
			-- Create the host frame
			if (index == 1) then
				JSHB.F.AlertIconsHost = JSHB.MakeFrame(JSHB.F.AlertIconsHost, "Frame", "JSHB_ALERT_ICON_HOST", JSHB.db.profile.alerts.anchor[2] or UIParent) -- recycle
				JSHB.F.AlertIconsHost:SetParent(JSHB.db.profile.alerts.anchor[2] or UIParent)
				JSHB.F.AlertIconsHost:ClearAllPoints()
				JSHB.F.AlertIconsHost:SetSize(JSHB.db.profile.alerts.icons.iconsize, JSHB.db.profile.alerts.icons.iconsize) -- Temporary size
				JSHB.F.AlertIconsHost:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.alerts.anchor) )
				JSHB.F.AlertIconsHost:SetAlpha(1)
				JSHB.F.AlertIconsHost:Show()
			end
	
			-- Create this Alert's Frame
			JSHB.F.Alerts[index] = JSHB.MakeFrame(JSHB.F.Alerts[index] or tremove(FRAMEPOOL), "Frame", nil, JSHB.F.AlertIconsHost)
			JSHB.F.Alerts[index]:SetParent(JSHB.F.AlertIconsHost)
			JSHB.F.Alerts[index]:SetSize(JSHB.db.profile.alerts.icons.iconsize, JSHB.db.profile.alerts.icons.iconsize)
			JSHB.F.Alerts[index]:SetPoint("CENTER", JSHB.F.AlertIconsHost, "CENTER")
			JSHB.F.Alerts[index]:SetAlpha(0)
			
			JSHB.F.Alerts[index].Icon = JSHB.F.Alerts[index].Icon or JSHB.F.Alerts[index]:CreateTexture(nil, "BACKGROUND")
			JSHB.F.Alerts[index].Icon:SetTexture("Interface\\ICONS\\INV_Misc_QuestionMark") -- Just a place-holder
			if JSHB.db.profile.alerts.icons.enabletexcoords then
				JSHB.F.Alerts[index].Icon:SetTexCoord(unpack(JSHB.db.profile.alerts.icons.texcoords) )
			else
				JSHB.F.Alerts[index].Icon:SetTexCoord(0, 1, 0, 1)
			end
			JSHB.F.Alerts[index].Icon:ClearAllPoints()
			JSHB.F.Alerts[index].Icon:SetAllPoints(JSHB.F.Alerts[index])
			
			-- Create the Background and border if the user wants one
			JSHB.F.Alerts[index].background = JSHB.MakeBackground(JSHB.F.Alerts[index], JSHB.db.profile.alerts.icons, nil, JSHB.F.Alerts[index].background)

			-- Now we can properly set the size of the host frame for the alert icons because we now have offsets.
			if (index == 1) then
				JSHB.F.AlertIconsHost:SetSize(		
					( (JSHB.db.profile.alerts.icons.iconsize + -- WIDTH
						(JSHB.GetFrameOffset(JSHB.F.Alerts[1], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.Alerts[1], "RIGHT", 1) + 2) ) * 5) 
						- JSHB.GetFrameOffset(JSHB.F.Alerts[1], "LEFT", 1) - JSHB.GetFrameOffset(JSHB.F.Alerts[1], "RIGHT", 1) - 2,
						
					( (JSHB.db.profile.alerts.icons.iconsize + -- HEIGHT
						(JSHB.GetFrameOffset(JSHB.F.Alerts[1], "TOP", 1) + JSHB.GetFrameOffset(JSHB.F.Alerts[1], "BOTTOM", 1) + 2) ) * 4) 
						- JSHB.GetFrameOffset(JSHB.F.Alerts[1], "LEFT", 1) - JSHB.GetFrameOffset(JSHB.F.Alerts[1], "RIGHT", 1) - 2)

				JSHB.RegisterMovableFrame(
					"MOVER_ALERT_ICONS",
					JSHB.F.AlertIconsHost,
					JSHB.F.AlertIconsHost,
					JSHB.L["Alerts"],
					JSHB.db.profile.alerts,
					index == 1 and JSHB.SetupAlertsModule or nil,
					JSHB.defaults.profile.alerts,
					nil) -- No background / Border ever on the mover frame
			end
			
			-- Setup Stacks
			JSHB.F.Alerts[index].stacks = JSHB.F.Alerts[index].stacks or JSHB.F.Alerts[index]:CreateFontString(nil, "OVERLAY")
			JSHB.F.Alerts[index].stacks:ClearAllPoints()
			JSHB.F.Alerts[index].stacks:SetJustifyH("RIGHT")
			JSHB.F.Alerts[index].stacks:SetJustifyV("BOTTOM")
			JSHB.F.Alerts[index].stacks:SetPoint("BOTTOMRIGHT", JSHB.F.Alerts[index], "BOTTOMRIGHT", 0, -3)
			JSHB.F.Alerts[index].stacks:SetFont(JSHB.GetActiveFont(JSHB.db.profile.alerts.icons.stackfont) )
			JSHB.F.Alerts[index].stacks:SetTextColor(unpack(JSHB.db.profile.alerts.icons.stackfontcolor) )
			JSHB.F.Alerts[index].stacks:SetText("")
			JSHB.F.Alerts[index].stacks:SetAlpha(1)
			
			-- Setup Timer Value
			JSHB.F.Alerts[index].value = JSHB.F.Alerts[index].value or JSHB.F.Alerts[index]:CreateFontString(nil, "OVERLAY")
			JSHB.F.Alerts[index].value:ClearAllPoints()
			JSHB.F.Alerts[index].value:SetJustifyH("CENTER")
			JSHB.F.Alerts[index].value:SetJustifyV("CENTER")
			JSHB.F.Alerts[index].value:SetPoint("CENTER", JSHB.F.Alerts[index], "CENTER", 0, 0)
			JSHB.F.Alerts[index].value:SetFont(JSHB.GetActiveFont(JSHB.db.profile.cooldowns.font) )
			JSHB.F.Alerts[index].value:SetTextColor(1, 1, 1, 1)
			if (not JSHB.F.Alerts[index].value.oriShadowColor) then
				JSHB.F.Alerts[index].value.oriShadowColor = { JSHB.F.Alerts[index].value:GetShadowColor() }
				JSHB.F.Alerts[index].value.oriShadowOffset = { JSHB.F.Alerts[index].value:GetShadowOffset() }
			end
			if (JSHB.db.profile.cooldowns.enableshadow) then 
				JSHB.F.Alerts[index].value:SetShadowColor(unpack(JSHB.db.profile.cooldowns.shadowcolor) )
				JSHB.F.Alerts[index].value:SetShadowOffset(unpack(JSHB.db.profile.cooldowns.fontshadowoffset) )
			else
				JSHB.F.Alerts[index].value:SetShadowColor(unpack(JSHB.F.Alerts[index].value.oriShadowColor) )
				JSHB.F.Alerts[index].value:SetShadowOffset(unpack(JSHB.F.Alerts[index].value.oriShadowOffset) )
			end
			JSHB.F.Alerts[index].value:SetText("")
			JSHB.F.Alerts[index].value:SetAlpha(1)
			
			-- Setup the Sparkles if turned on for this Alert frame
			if JSHB.db.profile.alerts.alerts[key].sparkles then
				JSHB.F.Alerts[index].shine = JSHB.F.Alerts[index].shine or CreateFrame("Frame", "AutocastShine_AlertShine", UIParent, "AutoCastShineTemplate")
				JSHB.F.Alerts[index].shine:ClearAllPoints()
				JSHB.F.Alerts[index].shine:Show()
				JSHB.F.Alerts[index].shine:SetSize(JSHB.db.profile.alerts.icons.iconsize+2, JSHB.db.profile.alerts.icons.iconsize+2)
				JSHB.F.Alerts[index].shine:SetPoint("CENTER", JSHB.F.Alerts[index], "CENTER", 1, -1)
				JSHB.F.Alerts[index].shine:SetAlpha(1)
				AutoCastShine_AutoCastStop(JSHB.F.Alerts[index].shine)
			elseif JSHB.F.Alerts[index].shine then
				JSHB.F.Alerts[index].shine:Hide()
				JSHB.F.Alerts[index].shine:ClearAllPoints()
			end

			-- Setup the script for handling the Alert
			JSHB.F.Alerts[index].index = index
			JSHB.F.Alerts[index].updateTimer = 0
			JSHB.F.Alerts[index].active = false
			JSHB.F.Alerts[index].activeGUID = -1
			JSHB.F.Alerts[index].checkID = tonumber(JSHB.db.profile.alerts.alerts[key].aura) and tonumber(JSHB.db.profile.alerts.alerts[key].aura) or nil
			JSHB.F.Alerts[index].checkName = (not tonumber(JSHB.db.profile.alerts.alerts[key].aura) ) and strupper(JSHB.db.profile.alerts.alerts[key].aura) or nil
			JSHB.F.Alerts[index].hasSparkles = JSHB.db.profile.alerts.alerts[key].sparkles
			JSHB.F.Alerts[index].soundFile = JSHB.db.profile.alerts.alerts[key].enablesound and JSHB.db.profile.alerts.alerts[key].sound or nil
			JSHB.F.Alerts[index].target = JSHB.db.profile.alerts.alerts[key].target
			JSHB.F.Alerts[index].healthpercent = JSHB.db.profile.alerts.alerts[key].healthpercent or 0
			
			if (JSHB.db.profile.alerts.alerts[key].alerttype == "BUFF") then
				JSHB.F.Alerts[index].alertTrigger = _Buff
				
			elseif (JSHB.db.profile.alerts.alerts[key].alerttype == "DEBUFF") then
				JSHB.F.Alerts[index].alertTrigger = _Debuff
				
			elseif (JSHB.db.profile.alerts.alerts[key].alerttype == "CAST") then
				JSHB.F.Alerts[index].alertTrigger = _Cast
				
			elseif (JSHB.db.profile.alerts.alerts[key].alerttype == "HEALTH") then
				JSHB.F.Alerts[index].alertTrigger = _Health
			
			elseif (JSHB.db.profile.alerts.alerts[key].alerttype == "PETHEALTH") then
				JSHB.F.Alerts[index].alertTrigger = _PetHealth
				
			else
				print("INVALID ALERT FOUND! Index:", index, "Type:", JSHB.db.profile.alerts.alerts[key].alerttype)
				return
			end

			-- OnUpdate handler		
			JSHB.F.Alerts[index]:SetScript("OnUpdate", function(self, elapsed)

				self.updateTimer = self.updateTimer + elapsed				
				if (self.updateTimer < ALERT_UPDATEINTERVAL) then return else self.updateTimer = 0 end

				self._name, self._texture, self._remainingTime, self._targetGUID, self._stacks = checkForAlert(self)

				if (self.active == true) then -- This alert is currently active, check if it's still valid
				
					if (self._name) and ( (self._targetGUID == self.activeGUID) or (self.alertTrigger == _Health) or (self.alertTrigger == _PetHealth) ) then -- Alert is still active, so update it
					
						if self._stacks and (self._stacks > 1) then
							self.stacks:SetText(self._stacks)
							self.stacks:Show()
						else
							self.stacks:Hide()
						end
						
						if self._remainingTime and (self._remainingTime > 0) then
							self.value:SetText(" "..JSHB.FormatTimeText(self._remainingTime, (self._remainingTime < 3) and true or nil, true) )
							if self._stacks and (self._stacks > 1) then
								self.value:ClearAllPoints()
								self.value:SetPoint("CENTER", self, "CENTER", -2, 4)
							else
								self.value:ClearAllPoints()
								self.value:SetPoint("CENTER", self, "CENTER", 0, 0)
							end
							self.value:Show()
						else
							self.value:SetText("")
							self.value:Hide()
						end
						
					else -- It's no longer active
					
						if self.hasSparkles then
							AutoCastShine_AutoCastStop(self.shine)
						end
						
						self.Icon:Hide()
						self.stacks:Hide()
						self.value:Hide()
						self:SetAlpha(0)
						self.active = false
						self.activeGUID = -1
						
						repositionFrames(self)
					end
				
				else -- Alert is not active, check if we need to activate it

					if (self._name) then -- Now it's active!
					
						self.active = true
						
						if self.soundFile then
							PlaySoundFile(JSHB.GetActiveSoundFile(self.soundFile), JSHB.db.profile.masteraudio and "Master" or nil)
						end
						
						self.Icon:SetTexture(self._texture)
						self.Icon:Show()

						if self._stacks and (self._stacks > 1) then
							self.stacks:SetText(self._stacks)
							self.stacks:Show()
						else
							self.stacks:Hide()
						end
						
						if self._remainingTime and (self._remainingTime > 0) then
							self.value:SetText(" "..JSHB.FormatTimeText(self._remainingTime, (self._remainingTime < 3) and true or nil, true) )
							if self._stacks and (self._stacks > 1) then
								self.value:ClearAllPoints()
								self.value:SetPoint("CENTER", self, "CENTER", -2, 4)
							else
								self.value:ClearAllPoints()
								self.value:SetPoint("CENTER", self, "CENTER", 0, 0)
							end
							self.value:Show()
						else
							self.value:SetText("")
							self.value:Hide()
						end
						
						if JSHB.moversLocked then
							self:SetAlpha(1)
						else
							self:SetAlpha(0)
						end
						
						self.triggerGUID = self.resolvedTarget and UnitGUID(self.resolvedTarget) or -1
						
						if self.hasSparkles then
							AutoCastShine_AutoCastStart(self.shine, 1, .5, .5)
						end
						
						self.activeGUID = self._targetGUID
						
						repositionFrames(self)
					end
				end
			end)	
			
			JSHB.F.Alerts[index]:Show()
			index = index + 1
		end
	end
	JSHB.totalAlertIcons = index - 1
end
