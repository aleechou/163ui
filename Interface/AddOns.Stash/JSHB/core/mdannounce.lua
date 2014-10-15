--
-- JSHB - misdirection announce module
--

if not tContains({ "HUNTER", "ROGUE" }, select(2, UnitClass("player") ) ) then return end

local MDSPELLID = select(2, UnitClass("player") ) == "HUNTER" and 34477 or 57934 -- md / tricks
local TRANSFERRINGSPELLID = select(2, UnitClass("player") ) == "HUNTER" and 35079 or 59628 -- md / tricks

function JSHB.SetupMisdirectionAnnounceModule()

	-- Deconstruction
	if JSHB.F.Misdirection then
		JSHB.F.Misdirection:Hide()
		JSHB.F.Misdirection:SetScript("OnEvent", nil)
		JSHB.F.Misdirection:UnregisterAllEvents() 
		JSHB.F.Misdirection:SetParent(nil)
		--JSHB.F.Misdirection = nil
	end

	-- Construction	
	if not JSHB.db.profile.misdirectionannounce.enable then return end
	
	if (JSHB.MD and JSHB.MD.C) then -- Disable JSHBMisdirection announces, as JSHB takes priority
		JSHB.MD.C.cCAST = false
		JSHB.MD.C.cEXPIRE = false
		JSHB.MD.C.cTRANSFER = false
		JSHB.MD.C.cMOUNTED = false
	end
	
	JSHB.F.Misdirection = JSHB.F.Misdirection or CreateFrame("Frame", "JSHB_MDANNOUNCE", UIParent)
	JSHB.F.Misdirection:SetParent(UIParent)
	JSHB.F.Misdirection:SetScript("OnEvent", function(self, event, ...)
		
		if (event == "UNIT_SPELLCAST_SENT") then
			
			self._unitID, self._spell, self._, self._target = ...
			if (self._unitID == "player") and (self._spell == select(1, GetSpellInfo(MDSPELLID) ) ) then
				self._TargetForMD = self._target
			end
			
		elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		
			self._, self._subEvent, self._, self._sourceGUID, self._, self._, self._, self._, self._destName, self._, self._, self._spellId, self._spellName, self._, self._extraSpellID  = ...
		
			if (self._subEvent == "SPELL_CAST_SUCCESS") and (self._spellId == MDSPELLID) and (self._sourceGUID == UnitGUID("player") ) then
				self._TargetForMD = self._destName
				if JSHB.db.profile.misdirectionannounce.enablemdcastannounce and (JSHB.GetChatChan(JSHB.db.profile.misdirectionannounce[strlower(JSHB.GetGroupType() ).."chan"]) ~= "NONE") then
					SendChatMessage("|cff71d5ff|Hspell:" .. self._spellId .. "|h[" .. self._spellName .. "]|h|r "
						.. JSHB.L["cast on"] .. " " .. self._destName ..".", JSHB.GetChatChan(JSHB.db.profile.misdirectionannounce[strlower(JSHB.GetGroupType() ).."chan"]), nil, GetUnitName("player") )					
				end
			end
			
			if JSHB.db.profile.misdirectionannounce.enablemdmountwarn then
				if (self._subEvent == "SPELL_CAST_FAILED") and (self._spellId == MDSPELLID) and (self._sourceGUID == UnitGUID("player") ) then
					-- Be sure we are not trying to send a tell to a pet or player name not in party/raid!
					if self._TargetForMD and UnitIsPlayer(self._TargetForMD) and (UnitInParty(self._TargetForMD) or UnitInRaid(self._TargetForMD) ) then
						-- Need to be sure it's whispering cause the target was mounted and not cause spell was on cooldown.
						if (self._extraSpellID == SPELL_FAILED_NOT_ON_MOUNTED) or (self._extraSpellID == SPELL_FAILED_NOT_ON_SHAPESHIFT) then
							SendChatMessage("|cff71d5ff|Hspell:" .. self._spellId .. "|h[" .. self._spellName .. "]|h|r "
								.. JSHB.L["can not be cast on you when mounted!"], "WHISPER", nil, self._TargetForMD)
						end
					end
				end
			end

			if JSHB.db.profile.misdirectionannounce.enablemdtransferannounce then -- aggro transfer (35079)
				if (self._subEvent == "SPELL_AURA_APPLIED") and (self._spellId == TRANSFERRINGSPELLID) and (self._sourceGUID == UnitGUID("player") ) then
					if self._TargetForMD and (UnitInParty(self._TargetForMD) or UnitInRaid(self._TargetForMD) ) then
						SendChatMessage("|cff71d5ff|Hspell:" .. self._spellId .. "|h[" .. self._spellName .. "]|h|r "
							.. JSHB.L["is transferring threat to you!"], "WHISPER", nil, self._TargetForMD)
					end
				end
			end
			
			if JSHB.db.profile.misdirectionannounce.enablemdtransferannounce then -- aggro transfer (35079)
				if (self._subEvent == "SPELL_AURA_REMOVED") and (self._spellId == TRANSFERRINGSPELLID) and (self._sourceGUID == UnitGUID("player") ) then
					if self._TargetForMD and (UnitInParty(self._TargetForMD) or UnitInRaid(self._TargetForMD) ) then
						SendChatMessage(JSHB.L["...threat transfer complete!"], "WHISPER", nil, self._TargetForMD)
					end
				end
			end
			
			if (self._subEvent == "SPELL_AURA_REMOVED") and (self._spellId == MDSPELLID) and (self._sourceGUID == UnitGUID("player") ) then
				if JSHB.db.profile.misdirectionannounce.enablemdoverannounce and (JSHB.GetChatChan(JSHB.db.profile.misdirectionannounce[strlower(JSHB.GetGroupType() ).."chan"]) ~= "NONE") then
					SendChatMessage("|cff71d5ff|Hspell:" .. self._spellId .. "|h[" .. self._spellName .. "]|h|r "
						.. JSHB.L["finished."], JSHB.GetChatChan(JSHB.db.profile.misdirectionannounce[strlower(JSHB.GetGroupType() ).."chan"]), nil, GetUnitName("player") )
				end
			end
		end
	end)
	JSHB.F.Misdirection:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	JSHB.F.Misdirection:RegisterEvent("UNIT_SPELLCAST_SENT")
	JSHB.F.Misdirection:Show()
end
