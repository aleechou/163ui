--
-- JSHB - global variables
--

-- Static variables and simple settings, keeping everything in the JSHB namespace of the addon
JSHB.myAddonName = select(1, ...)
JSHB.myVersion = GetAddOnMetadata( ..., "Version" ):match( "^([aAbBvVrR%d.]+)" )
JSHB.myVersionRaw = GetAddOnMetadata( ..., "Version" )
JSHB.myRevision = 0 -- Needed for database upgrades
JSHB.playerClass = select(2, UnitClass("player") )
JSHB.wowBuild = tonumber(select(4, GetBuildInfo() ), 10)

JSHB.timerPositions = {
	["TOP"] = JSHB.L["TOP"],
	["CENTER"] = JSHB.L["CENTER"],
	["BOTTOM"] = JSHB.L["BOTTOM"],
	["LEFT"] = JSHB.L["LEFT"],
	["RIGHT"] = JSHB.L["RIGHT"],
}

JSHB.stationaryTimerAnchors = {
	["FORWARD"] = JSHB.L["LEFT/BOTTOM"],
	["CENTER"] = JSHB.L["CENTER"],
	["REVERSE"] = JSHB.L["RIGHT/TOP"],
}

JSHB.chatChannels = {
	["AUTO"] = JSHB.L["Automatic"],
	["RAID"] = JSHB.L["Raid"],
	["YELL"] = JSHB.L["Yell"],
	["OFFICER"] = JSHB.L["Officer"],
	["GUILD"] = JSHB.L["Guild"],
	["BATTLEGROUND"] = JSHB.L["Battleground"],
	["PARTY"] = JSHB.L["Party"],
	["EMOTE"] = JSHB.L["Emote"],
	["SAY"] = JSHB.L["Say"],
	["SELFWHISPER"] = JSHB.L["Self Whisper"],
	["NONE"] = JSHB.L["No Announce"],
}

JSHB.timerOwners = {
	["PLAYERS"] = JSHB.L["Yours"],
	["ANY"] = JSHB.L["Any"],
}

JSHB.whenToShow = {
	[0] = JSHB.L["Always"],
	[1] = JSHB.L["Active"],
}

JSHB.alertTypes = {
	["BUFF"] = JSHB.L["Buff"],
	["DEBUFF"] = JSHB.L["Debuff"],
	["CAST"] = JSHB.L["Spell Cast Start"],
	["HEALTH"] = JSHB.L["Player Health"],
	["PETHEALTH"] = JSHB.L["Pet Health"],
}

JSHB.targets = {
	["target"] = JSHB.L["Target"],
	["player"] = JSHB.L["Player"],
	["pet"] = JSHB.L["Pet"],
	["focus"] = JSHB.L["Focus"],
	["boss"] = JSHB.L["Any Boss"],
	["boss1"] = JSHB.L["Boss 1"],
	["boss2"] = JSHB.L["Boss 2"],
	["boss3"] = JSHB.L["Boss 3"],
	["boss4"] = JSHB.L["Boss 4"],
	["arena"] = JSHB.L["Any Arena Enemy"],
	["arena1"] = JSHB.L["Arena Enemy 1"],
	["arena2"] = JSHB.L["Arena Enemy 2"],
	["arena3"] = JSHB.L["Arena Enemy 3"],
	["arena4"] = JSHB.L["Arena Enemy 4"],
	["arena5"] = JSHB.L["Arena Enemy 5"],
	["party"] = JSHB.L["Any Party Member"],
	["partypet"] = JSHB.L["Any Party Pet"],
	["raid"] = JSHB.L["Any Raid Member"],
	["raidpet"] = JSHB.L["Any Raid Pet"],
	["vehicle"] = JSHB.L["Vehicle"],
}

--[[ 
	Tracking new spells with no duration returns (MoP & Synapse Springs)
	
	Table format:
		[spellID] = { <GUID applied to>, <expireTime>, <knownDuration in seconds> }
]]
JSHB.spellTracker = CreateFrame("Frame", "JSHB_DURATIONTRACKER")
JSHB.spellTracker.spells = {
	["131894"] = { nil, 0, 30.5 }, -- Murder of Crows
	["120679"] = { nil, 0, 15.5 }, -- Dire Beast
	["120697"] = { nil, 0, 4.5 }, -- Lynx Rush
	["121818"] = { nil, 0, 20.5 }, -- Stampede
	["109248"] = { nil, 0, 10.5 }, -- Binding Shot
--	["1978"] = { nil, 0, 15 }, -- Serpent Sting (for testing)
}
JSHB.engineeringTinkerInfo = {	-- { <ItemID>, <ItemName> }
	GetInventoryItemID("player", GetInventorySlotInfo("HandsSlot") ),
	GetInventoryItemID("player", GetInventorySlotInfo("HandsSlot") ) and GetItemInfo(GetInventoryItemID("player", GetInventorySlotInfo("HandsSlot") ) ) or nil,
}

JSHB.spellTracker:SetScript("OnEvent", function(self, event, ...)

	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
	
		local timeStamp, subEvent, hideCaster, sourceGUID, sourceName, sourceFlags,
			sourceFlags2, destGUID, destName, destFlags, destFlags2, spellId, spellName,
			spellSchool, extraSpellID, extraSpellName, extraSchool, auraType = ...
			
		if (sourceGUID == UnitGUID("player") ) and (subEvent == "SPELL_CAST_SUCCESS") then
			if (JSHB.spellTracker.spells[tostring(spellId)]) then
				--print("SPELLCAST: ", spellId, spellName, sourceGUID, destGUID) -- debug testing
				JSHB.spellTracker.spells[tostring(spellId)][1] = (destGUID and tonumber(destGUID) and (tonumber(destGUID) > 0) ) and destGUID or sourceGUID
				JSHB.spellTracker.spells[tostring(spellId)][2] = GetTime() + (JSHB.spellTracker.spells[tostring(spellId)][3])
			end
		end
		
	elseif (event == "UNIT_INVENTORY_CHANGED") then

		local unitID = ...
		if (unitID == "player") then
			JSHB.engineeringTinkerInfo[1] = GetInventoryItemID("player", GetInventorySlotInfo("HandsSlot") )
			JSHB.engineeringTinkerInfo[2] = GetInventoryItemID("player", GetInventorySlotInfo("HandsSlot") ) and GetItemInfo(GetInventoryItemID("player", GetInventorySlotInfo("HandsSlot") ) ) or nil
			--print("SLOT 10 INFO UPDATED", JSHB.engineeringTinkerInfo[1], JSHB.engineeringTinkerInfo[2])
		end
		
	end
end)
JSHB.spellTracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
JSHB.spellTracker:RegisterEvent("UNIT_INVENTORY_CHANGED")
