--
-- JSHB - master's call announce module
--

if not (select(2, UnitClass("player") ) == "HUNTER") then return end

function JSHB.SetupMastersCallAnnounceModule()

	-- Deconstruction
	if JSHB.F.MastersCall then
		JSHB.F.MastersCall:Hide()
		JSHB.F.MastersCall:SetScript("OnEvent", nil)
		JSHB.F.MastersCall:UnregisterAllEvents() 
		JSHB.F.MastersCall:SetParent(nil)
	end

	-- Construction	
	if not JSHB.db.profile.masterscallannounce.enable then return end
	
	JSHB.F.MastersCall = JSHB.F.MastersCall or CreateFrame("Frame", "JSHB_MASTERSCALLANNOUNCE", UIParent)
	JSHB.F.MastersCall:SetParent(UIParent)
	JSHB.F.MastersCall:SetScript("OnEvent", function(self, event, ...)
		
		if (event == "UNIT_SPELLCAST_SENT") then
			
			self._unitID, self._spell, self._, self._target = ...
			if (self._unitID == "player") and (self._spell == select(1, GetSpellInfo(53271) ) ) then
				self._TargetForMC = self._target
			end
			
		elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		
			self._, self._subEvent, self._, self._sourceGUID, self._, self._, self._, self._, self._destName, self._, self._, self._spellId, self._spellName  = ...
		
			if (self._subEvent == "SPELL_AURA_APPLIED") and (self._spellId == 54216) and UnitExists("pet") and (self._sourceGUID == UnitGUID("pet") ) then
				self._TargetForMC = self._destName
				if (JSHB.GetChatChan(JSHB.db.profile.masterscallannounce[strlower(JSHB.GetGroupType() ).."chan"]) ~= "NONE") then
					SendChatMessage("|cff71d5ff|Hspell:" .. self._spellId .. "|h[" .. self._spellName .. "]|h|r "
						.. JSHB.L["cast on"] .. " " .. self._destName ..".", JSHB.GetChatChan(JSHB.db.profile.masterscallannounce[strlower(JSHB.GetGroupType() ).."chan"]), nil, GetUnitName("player") )					
				end
			end
			
			if (self._subEvent == "SPELL_AURA_REMOVED") and (self._spellId == 54216) and (self._destName == self._TargetForMC) then -- 54216 = Master's Call Effect Buff
				if JSHB.db.profile.masterscallannounce.enableoverannounce and (JSHB.GetChatChan(JSHB.db.profile.masterscallannounce[strlower(JSHB.GetGroupType() ).."chan"]) ~= "NONE") then
					SendChatMessage("|cff71d5ff|Hspell:" .. self._spellId .. "|h[" .. self._spellName .. "]|h|r "
						.. JSHB.L["finished."], JSHB.GetChatChan(JSHB.db.profile.masterscallannounce[strlower(JSHB.GetGroupType() ).."chan"]), nil, GetUnitName("player") )
				end
				self._TargetForMC = nil
			end
		end
	end)
	JSHB.F.MastersCall:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	JSHB.F.MastersCall:RegisterEvent("UNIT_SPELLCAST_SENT")
	JSHB.F.MastersCall:Show()
end
