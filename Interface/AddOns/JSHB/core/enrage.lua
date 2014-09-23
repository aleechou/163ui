--
-- JSHB enrage module (for tranquilizing shot/shiv alert)
--

if not (tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) ) then return end

local enrageTexture = "Interface\\Icons\\Spell_Nature_Drowsy" -- 19801 (Tranq Shot)
if (select(2, UnitClass("player") ) == "ROGUE") then
	enrageTexture = "Interface\\Icons\\INV_ThrowingKnife_04" -- 5938 (Shiv)
end

local enrageAlerts = {
	80084, 	-- BWD: Maimgor
	80158, 	--  SC: Warbringers
	81706, 	--  TV: Lockmaw - Venomous Rage
	36828, 	-- BOT: Crossfires
	124172, -- SoNT: Sik'thik Vanguard
	117837, -- MV: Meng the Demented - Delirious
	12880, 18499, -- Warrior: Berserker Rage
	--61573, 61574 -- Alliance banner, horde banner, trap launcher (testing)
}

local ENRAGE_UPDATEINTERVAL = 0.1
function JSHB.SetupEnrageModule(lockName)

	-- Deconstruction
	if JSHB.F.EnrageAlert then
		if (not lockName) or (lockName == "MOVER_ENRAGEALERT") then
			JSHB.F.EnrageAlert:Hide()
			JSHB.F.EnrageAlert:SetScript("OnUpdate", nil)
			JSHB.F.EnrageAlert:SetScript("OnEvent", nil)
			JSHB.F.EnrageAlert:UnregisterAllEvents()
			JSHB.DeregisterMovableFrame("MOVER_ENRAGEALERT")
			JSHB.F.EnrageAlert:SetParent(nil)
		end
	end
	
	if JSHB.F.EnrageAlertRemovables then
		if (not lockName) or (lockName == "MOVER_ENRAGEREMOVABLES") then
			JSHB.F.EnrageAlertRemovables:Hide()
			JSHB.DeregisterMovableFrame("MOVER_ENRAGEREMOVABLES")
			JSHB.F.EnrageAlertRemovables:SetParent(nil)
		end
	end
	
	if not JSHB.db.profile.enrage.enabled then return end
	
	-- Construction
	if ( (not lockName) or (lockName == "MOVER_ENRAGEALERT") ) then
		-- Create the Frame
		JSHB.F.EnrageAlert = JSHB.MakeFrame(JSHB.F.EnrageAlert, "Frame", "JSHB_ENRAGEALERT", JSHB.db.profile.enrage.anchor[2] or UIParent)
		JSHB.F.EnrageAlert:SetParent(JSHB.db.profile.enrage.anchor[2] or UIParent)
		JSHB.F.EnrageAlert:ClearAllPoints()
		JSHB.F.EnrageAlert:SetSize(JSHB.db.profile.enrage.iconsize, JSHB.db.profile.enrage.iconsize)
		JSHB.F.EnrageAlert:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.enrage.anchor) )

		JSHB.F.EnrageAlert.Icon = JSHB.F.EnrageAlert.Icon or JSHB.F.EnrageAlert:CreateTexture(nil, "BACKGROUND")
		JSHB.F.EnrageAlert.Icon:ClearAllPoints()
		JSHB.F.EnrageAlert.Icon:SetTexture(enrageTexture)
		if JSHB.db.profile.enrage.enabletexcoords then
			JSHB.F.EnrageAlert.Icon:SetTexCoord(unpack(JSHB.db.profile.enrage.texcoords) )
		else
			JSHB.F.EnrageAlert.Icon:SetTexCoord(0, 1, 0, 1)
		end
		JSHB.F.EnrageAlert.Icon:SetAllPoints(JSHB.F.EnrageAlert)

		-- Add sparkle to make it more noticable
		JSHB.F.EnrageAlert.shine = JSHB.F.EnrageAlert.shine or CreateFrame("Frame", "AutocastShine_ENRAGEALERT", UIParent, "AutoCastShineTemplate")
		JSHB.F.EnrageAlert.shine:SetParent(UIParent)
		JSHB.F.EnrageAlert.shine:ClearAllPoints()
		JSHB.F.EnrageAlert.shine:Show()
		JSHB.F.EnrageAlert.shine:SetSize(JSHB.db.profile.enrage.iconsize+2, JSHB.db.profile.enrage.iconsize+2)
		JSHB.F.EnrageAlert.shine:SetPoint("CENTER", JSHB.F.EnrageAlert, "CENTER", 1, 0)	
		JSHB.F.EnrageAlert.shine:SetAlpha(1)
		
		-- Create the Background and border if the user wants one
		JSHB.F.EnrageAlert.background = JSHB.MakeBackground(JSHB.F.EnrageAlert, JSHB.db.profile.enrage, nil, nil, JSHB.F.EnrageAlert.background)

		JSHB.F.EnrageAlert:SetAlpha(0)
		JSHB.F.EnrageAlert:Show()
		
		JSHB.RegisterMovableFrame(
			"MOVER_ENRAGEALERT",
			JSHB.F.EnrageAlert,
			JSHB.F.EnrageAlert,
			JSHB.L["Enrage Alert"],
			JSHB.db.profile.enrage,
			JSHB.SetupEnrageModule,
			JSHB.defaults.profile.enrage,
			JSHB.db.profile.enrage
		)
		
		JSHB.F.EnrageAlert.updateTimer = 0
		JSHB.F.EnrageAlert:SetScript("OnUpdate", function(self, elapsed)

			self.updateTimer = self.updateTimer + elapsed
		
			if self.updateTimer <= ENRAGE_UPDATEINTERVAL then return else self.updateTimer = 0 end
		
			if (not JSHB.moversLocked) then return end

			if (not UnitExists("target") ) or (not (UnitReaction("player", "target") ) ) or (UnitExists("target") and (UnitReaction("player", "target") > 4) ) or UnitIsDeadOrGhost("player") then
				AutoCastShine_AutoCastStop(self.shine)
				self:SetAlpha(0)
				self.amShowing = nil
				return
			else
				for x=1,#enrageAlerts do
					if UnitAura("target", GetSpellInfo(enrageAlerts[x]), nil, "HELPFUL") then
						if not self.amShowing then
							AutoCastShine_AutoCastStart(JSHB.F.EnrageAlert.shine, 1, .5, .5)
							self:SetAlpha(1)
							if JSHB.db.profile.enrage.enablesound then
								PlaySoundFile(JSHB.GetActiveSoundFile(JSHB.db.profile.enrage.sound), JSHB.db.profile.masteraudio and "Master" or nil)
							end
							self.amShowing = true
							return
						else
							return
						end
					end
				end
			end
			AutoCastShine_AutoCastStop(self.shine)
			self:SetAlpha(0)
			self.amShowing = nil
		end)
	end

	if ( (not lockName) or (lockName == "MOVER_ENRAGEREMOVABLES") ) then

		-- Notification setup
		if (JSHB.db.profile.enrage.removednotify == true) then
			JSHB.F.EnrageAlert:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
			JSHB.F.EnrageAlert:SetScript("OnEvent", function(self, event, ...)
			
				self._, self._subEvent, self._, self._sourceGUID, self._, self._, self._, self._destGUID, self._destName,
					self._, self._, self._spellId, self._spellName, self._, self._extraSpellID, self._extraSpellName = ...
				
				if (self._subEvent == "SPELL_DISPEL") and (self._sourceGUID == UnitGUID("player") ) and (self._destGUID ~= UnitGUID("pet") ) then
					if (JSHB.GetChatChan(JSHB.db.profile.enrage[strlower(JSHB.GetGroupType() ).."chan"]) ~= "NONE") then
						SendChatMessage("\124cff71d5ff|Hspell:" .. self._spellId .. "\124h[" .. self._spellName .. "]\124h\124r " .. JSHB.L["removed"] .. " \124cff71d5ff\124Hspell:" .. self._extraSpellID .. "\124h[" .. self._extraSpellName .. "]\124h\124r "
							.. JSHB.L["from"] .. " " .. self._destName .. ".", JSHB.GetChatChan(JSHB.db.profile.enrage[strlower(JSHB.GetGroupType() ).."chan"]), nil, GetUnitName("player") )
					end
				end
			end)
		end
		
		-- Removables setup
		if not JSHB.db.profile.enrage.enableremovables then return end
		if (not (select(2, UnitClass("player") ) == "HUNTER") ) then return end -- Only for Hunters right now
		
		JSHB.F.EnrageAlertRemovables = JSHB.MakeFrame(JSHB.F.EnrageAlertRemovables, "Frame", "JSHB_ENRAGEALERT_REMOVABLES", JSHB.db.profile.enrage.anchor_removables[2] or UIParent)
		JSHB.F.EnrageAlertRemovables:SetParent(JSHB.db.profile.enrage.anchor_removables[2] or UIParent)
		JSHB.F.EnrageAlertRemovables:ClearAllPoints()
		JSHB.F.EnrageAlertRemovables:SetSize(50,50) -- Temp size, we'll re-set this after we create the buff frames to get proper offsets
		JSHB.F.EnrageAlertRemovables:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.enrage.anchor_removables) )

		JSHB.F.EnrageAlertRemovables.buffFrames = JSHB.F.EnrageAlertRemovables.buffFrames or {} -- recycle
		
		for i=1,40 do
			JSHB.F.EnrageAlertRemovables.buffFrames[i] = JSHB.MakeFrame(JSHB.F.EnrageAlertRemovables.buffFrames[i], "Frame", nil, JSHB.F.EnrageAlertRemovables)
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetParent(JSHB.F.EnrageAlertRemovables)
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:ClearAllPoints()
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetSize(JSHB.db.profile.enrage.iconsizeremovables, JSHB.db.profile.enrage.iconsizeremovables)		
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetPoint("CENTER", JSHB.F.EnrageAlertRemovables, "CENTER") -- Temporary

			JSHB.F.EnrageAlertRemovables.buffFrames[i].Icon = JSHB.F.EnrageAlertRemovables.buffFrames[i].Icon or JSHB.F.EnrageAlertRemovables.buffFrames[i]:CreateTexture(nil, "BACKGROUND")
			JSHB.F.EnrageAlertRemovables.buffFrames[i].Icon:ClearAllPoints()
			JSHB.F.EnrageAlertRemovables.buffFrames[i].Icon:SetAllPoints(JSHB.F.EnrageAlertRemovables.buffFrames[i])
			JSHB.F.EnrageAlertRemovables.buffFrames[i].Icon:SetTexture("Interface\Icons\Spell_Nature_Drowsy") -- Temporary
			if JSHB.db.profile.enrage.removablesenabletexcoords then
				JSHB.F.EnrageAlert.Icon:SetTexCoord(unpack(JSHB.db.profile.enrage.removablestexcoords) )
			else
				JSHB.F.EnrageAlert.Icon:SetTexCoord(0, 1, 0, 1)
			end

			JSHB.F.EnrageAlertRemovables.buffFrames[i].background = JSHB.MakeBackground(JSHB.F.EnrageAlertRemovables.buffFrames[i], JSHB.db.profile.enrage, "removables", nil, nil, JSHB.F.EnrageAlertRemovables.buffFrames[i].background)
			
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:ClearAllPoints() -- Now that we made the backdrop/border we have offsets to use.

			-- Flip expanding left to right or right to left depending on anchor point X
			local xPos = ( (JSHB.db.profile.enrage.iconsizeremovables +
						(JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[i], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[i], "RIGHT", 1) + 2) )
							* mod(i-1, 8) )
			
			local yPos = (JSHB.db.profile.enrage.iconsizeremovables +  -- Vertical Offset
						(JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[i], "TOP", 1) + JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[i], "BOTTOM", 1) + 2) )
							* floor( (i-1) / 8)

			if JSHB.db.profile.enrage.anchor_removables[4] >= 0 then
				JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetPoint("TOPLEFT", JSHB.F.EnrageAlertRemovables, "TOPLEFT", xPos, -yPos)
			else
				JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetPoint("TOPRIGHT", JSHB.F.EnrageAlertRemovables, "TOPRIGHT", -xPos, -yPos)
			end
							
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetAlpha(1)
			JSHB.F.EnrageAlertRemovables.buffFrames[i]:Hide()
			JSHB.F.EnrageAlertRemovables.buffFrames[i].spellID = 0
			
			if JSHB.db.profile.enrage.removablestips then
				JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetScript("OnEnter", function(self)
					if (self.spellID == 0) then return end
					for index=1,40 do
						if (select(11, UnitBuff("target", index) ) == self.spellID) then
							GameTooltip:SetOwner(self)
							GameTooltip:SetUnitBuff("target", index)
							GameTooltip:Show()
							return
						end
					end
				end)
				JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetScript("OnLeave", function(self)
					if self.spellID == 0 then return end
					GameTooltip:Hide()
				end)
			else
				JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetScript("OnEnter", nil)
				JSHB.F.EnrageAlertRemovables.buffFrames[i]:SetScript("OnLeave", nil)
			end
		end
		
		-- Now we can properly set the size of the parent frame for the buff icons because we now have offsets.
		JSHB.F.EnrageAlertRemovables:SetSize(		
			( (JSHB.db.profile.enrage.iconsizeremovables + -- WIDTH
				(JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "LEFT", 1) + JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "RIGHT", 1) + 2) ) * 8) 
				- JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "LEFT", 1) - JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "RIGHT", 1) - 2,
			( (JSHB.db.profile.enrage.iconsizeremovables + -- HEIGHT
				(JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "TOP", 1) + JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "BOTTOM", 1) + 2) ) * 5) 
				- JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "LEFT", 1) - JSHB.GetFrameOffset(JSHB.F.EnrageAlertRemovables.buffFrames[1], "RIGHT", 1) - 2)

		-- Register the mover frame
		JSHB.RegisterMovableFrame(
			"MOVER_ENRAGEREMOVABLES",
			JSHB.F.EnrageAlertRemovables,
			JSHB.F.EnrageAlertRemovables,
			JSHB.L["Enrage Alert Removable Buffs"],
			JSHB.db.profile.enrage,
			JSHB.SetupEnrageModule,
			JSHB.defaults.profile.enrage,
			JSHB.db.profile.enrage,
			"_removables"
		)

		JSHB.F.EnrageAlertRemovables.updateTimer = 0
		JSHB.F.EnrageAlertRemovables:SetScript("OnUpdate", function(self, elapsed, ...)
		
			self.updateTimer = self.updateTimer + elapsed		
			if self.updateTimer < ENRAGE_UPDATEINTERVAL then return else self.updateTimer = 0 end
			
			if (not UnitCanAttack("player", "target") ) or (JSHB.db.profile.enrage.removablespvponly and (JSHB.GetGroupType() ~= "ARENA") and (JSHB.GetGroupType() ~= "PVP") ) then
				for i=1,40 do
					JSHB.F.EnrageAlertRemovables.buffFrames[i].spellID = 0
					JSHB.F.EnrageAlertRemovables.buffFrames[i]:Hide()
				end			
			else
				self._j = 1
				for i=1,40 do			
					self._, self._, self._, self._, self._debuffType, self._, self._, self._, self._, self._, self._spellId  = UnitBuff("target", i)
					if (self._debuffType == "Magic") then
						JSHB.F.EnrageAlertRemovables.buffFrames[self._j].spellID = self._spellId
						JSHB.F.EnrageAlertRemovables.buffFrames[self._j].Icon:SetTexture(select(3, GetSpellInfo(self._spellId) ) ) --"Interface\\Icons\\Spell_Nature_Drowsy")
						if JSHB.db.profile.enrage.removablesenabletexcoords then
							JSHB.F.EnrageAlert.Icon:SetTexCoord(unpack(JSHB.db.profile.enrage.removablestexcoords) )
						end
						JSHB.F.EnrageAlertRemovables.buffFrames[self._j]:Show()
						self._j = self._j + 1
					end
				end			
				for i=self._j,40 do
					JSHB.F.EnrageAlertRemovables.buffFrames[i]:Hide()
					JSHB.F.EnrageAlertRemovables.buffFrames[i].spellID = 0
				end
			end
		end)
		JSHB.F.EnrageAlertRemovables:Show()
	end
end
