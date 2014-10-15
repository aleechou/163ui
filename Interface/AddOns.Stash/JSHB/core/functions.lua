--
-- JSHB - general functions
--

function JSHB.GetActiveAnchor(anchor, override1, override2, override3, override4, override5)
	return override1 or anchor[1], override2 or (anchor[2] == nil and UIParent or anchor[2]), override3 or anchor[3], override4 or anchor[4], override5 or anchor[5]
end

local f1, f2, f3
function JSHB.GetActiveFont(key, index, returnKey)
	f1, f2, f3 = unpack(key)
	if (index ~= nil) then
		if (index == 1) then
			return JSHB.GetLSMValueByKey(JSHB.defaultFonts, f1, "Arial Narrow", returnKey or "font")
		else
			return key[index]
		end
	end
	return JSHB.GetLSMValueByKey(JSHB.defaultFonts, f1, "Arial Narrow", returnKey or "font"), f2, f3
end

function JSHB.GetActiveFontFile(key, default, returnKey)
	return JSHB.GetLSMValueByKey(JSHB.defaultFonts, key, default or "Arial Narrow", returnKey)
end

function JSHB.GetActiveSoundFile(key, default, returnKey)
	return JSHB.GetLSMValueByKey(JSHB.defaultSounds, key, default or "Raid Warning", returnKey)
end

function JSHB.GetActiveTextureFile(key, default, returnKey)
	return JSHB.GetLSMValueByKey(JSHB.defaultTextures, key, default or "Blank", returnKey)
end

function JSHB.GetActiveBackgroundFile(key, default, returnKey)
	return JSHB.GetLSMValueByKey(JSHB.defaultBackgrounds, key, default or "None", returnKey)
end

function JSHB.GetActiveBorderFile(key, default, returnKey)
	return JSHB.GetLSMValueByKey(JSHB.defaultBorders, key, default or "None", returnKey)
end

function JSHB.CheckIfKnown(spell, item)
	if spell then
		if (tonumber(spell) and IsSpellKnown(spell) ) or -- Checking if the player knows the spell and it's a numeric (id)
			(tonumber(spell) and IsSpellKnown(spell, true) ) or -- Checking if the pet knows the spell and it's a numeric (id)
			( (not tonumber(spell) ) and JSHB.NameToSpellID(spell) and -- Checking if the player/pet knows the spell and it's a string (name)
			(IsSpellKnown(JSHB.NameToSpellID(spell) ) or IsSpellKnown(JSHB.NameToSpellID(spell), true ) ) ) then
			return true
		end
	elseif (item) and (GetItemInfo(item) ) then -- Items are easier to check, single call, no helpers
		return true
	end
	return nil
end

function JSHB.GetMatchTableValSimple(wTable, toMatch, returnIndex)
	for i=1,#wTable do
		if (wTable[i] == toMatch) then return (returnIndex and i or wTable[i]) end
	end
	return nil
end

function JSHB.GetMatchTableVal(wTable, colMatch, colReturn, toMatch)
	for i=1,#wTable do
		if (wTable[i][colMatch] == toMatch) then return wTable[i][colReturn] end
	end
	return nil
end

function JSHB.GetMatchTablePosition(wTable, colMatch, toMatch)
	for i=1,#wTable do
		if (wTable[i][colMatch] == toMatch) then return(i) end
	end
	return nil
end

--Return rounded number
function JSHB.Round(v, decimals)
    return ( ("%%.%df"):format(decimals or 0) ):format(v)
end

--Truncate a number off to n places
function JSHB.Truncate(v, decimals)
    return v - (v % (0.1 ^ (decimals or 0) ) )
end

function JSHB.ParseItemLink(itemLink, returnNil)
	if (not itemLink) then return(returnNil and nil or "") end
	return string.find(itemLink, "|?c?f?f?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?")
end
		
--RGB to Hex
function JSHB.RGBToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("\124cff%02x%02x%02x", r*255, g*255, b*255)
end

--Hex to RGB
local rhex, ghex, bhex
function JSHB.HexToRGB(hex)
	rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16), tonumber(ghex, 16), tonumber(bhex, 16)
end

function JSHB.UnpackColors(color)
	if color.a then
		return color.r and color.r or 0, color.g and color.g or 0, color.b and color.b or 0, color.a
	else
		return color.r and color.r or 0, color.g and color.g or 0, color.b and color.b or 0
	end
end

local DAY, HOUR, MINUTE = 86400, 3600, 60
local DAYISH, HOURISH, MINUTEISH = 3600 * 23.5, 60 * 59.5, 59.5
local EXPIRING_DURATION = 3.2
local SECONDWITHTENTHS_ABBR = '%.1f'.. strsub(SECOND_ONELETTER_ABBR, 4)
local SECONDS_ABBR = '%d' .. strsub(SECOND_ONELETTER_ABBR, 4)
local MINS_ABBR = '%d' .. strsub(MINUTE_ONELETTER_ABBR, 4)
local HOURS_ABBR = '%d' .. strsub(HOUR_ONELETTER_ABBR, 4)
local DAYS_ABBR = '%d' .. strsub(DAY_ONELETTER_ABBR, 4)
function JSHB.FormatTimeText(val, tenths, autoColor, timeIndicator)
	local db = JSHB.db.profile.cooldowns

	-- Expiring
	if (val <= EXPIRING_DURATION) then	
		if tenths then
			return autoColor and format(JSHB.RGBToHex(unpack(db["expiringcolor"]) )..(timeIndicator and (SECONDWITHTENTHS_ABBR .. '|r') or '%.1f|r'), val) or
				format(timeIndicator and SECONDWITHTENTHS_ABBR or '%.1f', val)
		else
			return autoColor and format(JSHB.RGBToHex(unpack(db["expiringcolor"]) )..(timeIndicator and (SECONDS_ABBR .. '|r') or '%d|r'), val) or
				format(timeIndicator and SECONDS_ABBR or '%d', val)
		end	
	
	-- Format seconds
	elseif (val <= MINUTEISH) then
		if tenths then
			return autoColor and format(JSHB.RGBToHex(unpack(db["secondscolor"]) )..(timeIndicator and (SECONDWITHTENTHS_ABBR .. '|r') or '%.1f|r'), val) or
				format(timeIndicator and SECONDWITHTENTHS_ABBR or '%.1f', val)
		else
			return autoColor and format(JSHB.RGBToHex(unpack(db["secondscolor"]) )..(timeIndicator and (SECONDS_ABBR .. '|r') or '%d|r'), tonumber(JSHB.Round(val) ) ) or
				format(timeIndicator and SECONDS_ABBR or '%d', tonumber(JSHB.Round(val) ) )
		end

	-- Format Minutes
	elseif (val <= HOURISH ) then
		return autoColor and format(JSHB.RGBToHex(unpack(db["minutescolor"]) )..(timeIndicator and (MINS_ABBR .. '|r') or '%d|r'), tonumber(JSHB.Round(val/MINUTE) ) ) or 
			format(timeIndicator and MINS_ABBR or '%d', tonumber(JSHB.Round(val/MINUTE) ) )

	-- Format Hours
	elseif (val <= DAYISH ) then
		return autoColor and format(JSHB.RGBToHex(unpack(db["hourscolor"]) )..(timeIndicator and (HOURS_ABBR .. '|r') or '%d|r'), tonumber(JSHB.Round(val/HOUR) ) ) or 
			format(timeIndicator and HOURS_ABBR or '%d', tonumber(JSHB.Round(val/HOUR) ) )

	-- Format Days
	else
		return autoColor and format(JSHB.RGBToHex(unpack(db["dayscolor"]) )..(timeIndicator and (DAYS_ABBR .. '|r') or '%d|r'), tonumber(JSHB.Round(val/DAY) ) ) or 
			format(timeIndicator and DAYS_ABBR or '%d', tonumber(JSHB.Round(val/DAY) ) )
	end
end

--[[
	Returns the proper chat channel to display a chat message in.
	Returns the same channel passed, unless it's a "SELFWHISPER" or
	value of 1.  Whispers make sure to hide the outgoing whisper so you
	do not need to see double messages, especially for "SELFWHISPER".
]]
function JSHB.GetChatChan(chan)
	local function HideOutgoing(self, event, msg, author, ...)
		if (author == GetUnitName("player") ) then
			ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", HideOutgoing)
    		return true
		end
	end
	if (chan ~= "AUTO") then	
		if (chan == "SELFWHISPER") then
			ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", HideOutgoing)
			return("WHISPER")
		end		
		return(chan)
	end
	-- Auto roll-down
	local zoneType = select(2, IsInInstance() )
	if (zoneType == "pvp") or (zoneType == "arena") then
		return "INSTANCE_CHAT" -- "BATTLEGROUND"
	elseif IsInRaid() then
		return(IsPartyLFG() and "INSTANCE_CHAT" or "RAID")
	elseif IsInGroup() then
		return(IsPartyLFG() and "INSTANCE_CHAT" or "PARTY")
	else
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", HideOutgoing)
		return "WHISPER" -- default to whisper as last resort unless directly specified
	end
end

function JSHB.GetGroupType()

	local zoneType = select(2, IsInInstance() )
	if (zoneType == "arena") then	
		return "ARENA"		
	elseif (zoneType == "pvp") then	
		return "PVP" -- was "BATTLEGROUND"
	elseif IsInRaid() then
		return "RAID"
	elseif IsInGroup() then
		return "PARTY"
	else
		return "SOLO"
	end	
end

 local spellLink
 function JSHB.NameToSpellID(spellName)
	spellLink = GetSpellLink(spellName)
	if spellLink then
		return(spellLink.match(spellLink, "spell:(%d+)") )
	end
	return nil
end

function JSHB.Timer_OnSizeChanged(self, width, height)

	self.text:SetFont(JSHB.GetActiveFont(JSHB.db.profile.cooldowns.font) )
	if JSHB.db.profile.cooldowns.enableshadow then
		self.text:SetShadowColor(unpack(JSHB.db.profile.cooldowns.shadowcolor) )
		self.text:SetShadowOffset(unpack(JSHB.db.profile.cooldowns.fontshadowoffset) )
	end
	if self.enabled then
		self.nextUpdate = 0
		self:Show()
	end
end

function JSHB.Timer_OnUpdate(self, elapsed)

	if self.nextUpdate > 0 then
		self.nextUpdate = self.nextUpdate - elapsed
	else
		local remain = self.duration - (GetTime() - self.start)
		if floor(remain + 0.1) > 0 then
			self.text:SetText(JSHB.FormatTimeText(remain, false, true, true) )
			self.nextUpdate = 0.1
		else
			self.enabled = nil
			self:Hide()
		end
	end
end

function JSHB.Timer_Create(self)

	local scaler = CreateFrame('Frame', nil, self)
	scaler:SetAllPoints(self)

	local timer = CreateFrame('Frame', nil, scaler)
	timer:Hide()
	timer:SetAllPoints(scaler)
	timer:SetScript("OnUpdate", JSHB.Timer_OnUpdate)

	local text = timer:CreateFontString(nil, 'OVERLAY')
	text:SetPoint("CENTER", (floor(self:GetWidth() + 0.5) / 30) * 2, 0) -- 2px offset based on 18px font and 30px standard icon width
	text:SetJustifyH("CENTER")
	text:SetJustifyV("CENTER")
	timer.text = text

	JSHB.Timer_OnSizeChanged(timer, scaler:GetSize() )
	scaler:SetScript("OnSizeChanged", function(self, ...) JSHB.Timer_OnSizeChanged(timer, ...) end)

	self.timer = timer
	return timer
end

function JSHB.CheckForDebuff(spell, target, owner)
	local name, rank, icon, count, _, duration, expirationTime, _, _, _, spellId = 
		UnitAura(target, tonumber(spell) and GetSpellInfo(tonumber(spell) ) or spell, nil, (owner == "PLAYERS") and "PLAYER|HARMFUL" or "HARMFUL")		

	-- MoP fix for missing durations of some spells
	local strSpellId = spellId and tostring(spellId) or ( (type(spell) == "number") and tostring(spell) or JSHB.NameToSpellID(spell) )

	if (target == "target") and strSpellId and JSHB.spellTracker.spells[strSpellId] then
		if (UnitGUID("target") and (UnitGUID("target") == JSHB.spellTracker.spells[strSpellId][1]) ) or (JSHB.spellTracker.spells[strSpellId][1] == UnitGUID("player") ) then
			if (JSHB.spellTracker.spells[strSpellId][2] > GetTime() ) then
				if (not name) then
					name, rank, icon = GetSpellInfo(spell)
					count = 1
				end
				duration = JSHB.spellTracker.spells[strSpellId][3] -- 3 is known duration
				expirationTime = JSHB.spellTracker.spells[strSpellId][2]
				--print("DEBUG:", name, strSpellId, duration, expirationTime, expirationTime - GetTime() )
			end
		end
	end

	return (name and icon or nil), (name and duration or 0), ( (name and (expirationTime - GetTime() ) > 0) and math.max(expirationTime - GetTime(), 0) or 0), (count)
end

function JSHB.CheckForBuff(spell, target, owner)
	local name, _, icon, count, debuffType, duration, expirationTime = 
		UnitAura(target, tonumber(spell) and GetSpellInfo(tonumber(spell) ) or spell, nil, (owner == "PLAYERS") and "PLAYER|HELPFUL" or "HELPFUL")
		
	return (name and icon or nil), (name and duration or 0), ( (name and (expirationTime - GetTime() ) > 0) and math.max(expirationTime - GetTime(), 0) or 0), (count)
end

--[[
	Wrapper to check for a timer's presence.
	
	returns:
	1 - spell's or item's texture if found or nil,
	2 - full duration time of the spell or item
	3 - remaining time on the cooldown or duration
	4 - stacks of the aura or 0 for none or n/a
]]--
function JSHB.GetTimerInfo(spell, item, target, timerType, owner, internalcd, lastTime)

	local _, i, icon, icon2, duration, remaining, stacks, itemName, itemLink, itemTexture, startTime, enable, name, rank, maxPlayers, inInstance, instanceType, timeremaining

	-- ITEM COOLDOWN
	if item then		
		itemName, itemLink, _, _, _, _, _, _, _, itemTexture = GetItemInfo(tonumber(item) or item)
		if (not itemLink) then
			return (nil), (0), (0), (0) 
		end
		startTime, duration, enable = GetItemCooldown(select(5, JSHB.ParseItemLink(itemLink) ) ) -- Why the hell doesn't GetItemInfo return the ID
		if (timerType == "ICOOLDOWN") then
			duration = internalcd
		end
		
		-- Icon change for Synapse Springs cooldown from the gloves icon to engineering icon
		if JSHB.engineeringTinkerInfo[1] and ( (item == JSHB.engineeringTinkerInfo[1]) or (item == JSHB.engineeringTinkerInfo[2]) ) then
			_, _, itemTexture = GetSpellInfo(82175)
		end
		
		return ( (itemName and (duration ~= 0) ) and itemTexture or nil), (itemName and duration or 0), (itemName and math.max(startTime + duration - GetTime(), 0) or 0), (0) -- no stacks needed for an item		
	end
	
	-- SPELL COOLDOWN (this is only for player spells - including pet spells)
	if (timerType == "COOLDOWN") then	
		name, rank, icon = GetSpellInfo(tonumber(spell) or spell)
		if (not name) then return (nil), (0), (0), (0) end
		startTime, duration, enable = GetSpellCooldown(name)
		-- Need to hack this code a bit, because if we are on GCD it will trigger this to have a duration.
		-- Assuming the duration cannot be less than 1.51, we can override the issues with a simple hack.
		if duration and (duration > 1.5) then
			return (duration == 0 and nil or icon), (duration == 0 and 0 or duration), (duration == 0 and 0 or math.max(startTime + duration - GetTime(), 0) ), (0)
		else
			return (nil), (0), (0), (0) -- easy!
		end
	end
	
	-- SPELL INTERNAL COOLDOWN (this is only for player spells - including pet spells)
	if (timerType == "ICOOLDOWN") then	
		-- Check if it's active on target (player)
		icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target, "ANY") -- owner should be field 3, but this breaks ICDs
		
		if icon then
			-- Active, so return times for updating the icd
			return (nil), (tonumber(internalcd) ), (remaining + tonumber(internalcd) ), (0)
		else
			-- Not active! We need the icon... Something wrong... Exit...
			name, rank, icon2 = GetSpellInfo(tonumber(spell) or spell)
			if (not name) or (not lastTime) or (type(lastTime) ~= "number") then
				return (nil), (0), (0), (0)
			end
			-- All ok... We need to check the remaining time
			timeremaining = math.max(lastTime + tonumber(internalcd) - GetTime(), 0)
			-- If no remaining time, return nil texture to hide the icon
			if (timeremaining > 0) then
				return (icon2), (tonumber(internalcd) ), (timeremaining), (0)
			else
				return (nil), (0), (0), (0)
			end
		end
	end

	-- SPELL DURATION (This is the tricky one dealing with hostile vs. friendly and full checks like all of raid/party, etc.)
	if ( (target == "raid") or (target == "raidpet") ) and IsInGroup() then
	
		if (GetNumGroupMembers() ~= 0) then
			if IsInInstance() then
				maxPlayers = select(5, GetInstanceInfo() )
			else
				maxPlayers = 40
			end			
			for i=1,maxPlayers do
				if UnitExists(target..i) then
					if (owner ~= "PLAYERS") then -- Player can not debuff a friendly unit, unless mind controlled or such!
						icon, duration, remaining, stacks = JSHB.CheckForDebuff(spell, target..i, owner)
						if icon then return (icon), (duration), (remaining), (stacks) end
					end
					
					icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target..i, owner)
					if icon then return (icon), (duration), (remaining), (stacks) end
				end
			end
		end
		return (nil), (0), (0), (0)
		
	elseif ( (target == "party") or (target == "partypet") ) and IsInGroup() then
	
		if (owner ~= "PLAYERS") then
			icon, duration, remaining, stacks = JSHB.CheckForDebuff(spell, target == "party" and "player" or "pet", owner)
			if icon then return (icon), (duration), (remaining), (stacks) end
		end
	
		icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target == "party" and "player" or "pet", owner)
		if icon then return (icon), (duration), (remaining), (stacks) end
		
		for i=1,GetNumGroupMembers() do
			if (owner ~= "PLAYERS") then
				icon, duration, remaining, stacks = JSHB.CheckForDebuff(spell, target..i, owner)
				if icon then return (icon), (duration), (remaining), (stacks) end
			end
			
			icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target..i, owner)
			if icon then return (icon), (duration), (remaining), (stacks) end
		end
		return (nil), (0), (0), (0)
		
	elseif (target == "arena") and IsInGroup() then
	
		inInstance, instanceType = IsInInstance()
		if inInstance and (instanceType == "arena") then
			for i=1,5 do
				if UnitExists(target..i) then
					icon, duration, remaining, stacks = JSHB.CheckForDebuff(spell, target..i, owner)
					if icon then return (icon), (duration), (remaining), (stacks) end
					
					icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target..i, owner)
					if icon then return (icon), (duration), (remaining), (stacks) end
				end
			end
		end
		return (nil), (0), (0), (0)
		
	elseif (target == "boss") then
		for i=1,4 do
			if UnitExists(target..i) then
				icon, duration, remaining, stacks = JSHB.CheckForDebuff(spell, target..i, owner)
				if icon then return (icon), (duration), (remaining), (stacks) end
			
				icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target..i, owner)
				if icon then return (icon), (duration), (remaining), (stacks) end
			end
		end
		return (nil), (0), (0), (0)
	end
	
	-- Lastly we check the exact target for a debuff first then buff
	icon, duration, remaining, stacks = JSHB.CheckForDebuff(spell, target, owner)
	if icon then return (icon), (duration), (remaining), (stacks) end
	
	icon, duration, remaining, stacks = JSHB.CheckForBuff(spell, target, owner)
	if icon then return (icon), (duration), (remaining), (stacks) end
	
	-- Nothing found for the spell given
	return (nil), (0), (0), (0)
end

function JSHB.GetTimerIconTexture(spell, item)

	if item then -- ITEM
		local itemName, _, _, _, _, _, _, _, _, itemTexture = GetItemInfo(tonumber(item) or item)
		if itemName and itemTexture then
			return itemTexture
		end
	else -- SPELL
		local name, rank, icon = GetSpellInfo(tonumber(spell) or spell)
		if name and icon then
			return icon
		end
	end

	return nil
end

function JSHB.ConfirmActionDialog(strText, onAcceptFunc, onCancelFunc, yesText, noText)
	StaticPopupDialogs["JSHB_CONFIRMACTIONDIALOG"] = {
		text = strText,
		button1 = yesText or YES,
		button2 = noText or NO,
		showAlert = true,
		OnAccept = onAcceptFunc,
		OnCancel = onCancelFunc,
		timeout = 0,
		hideOnEscape = true,
		whileDead  = true,
	}
	StaticPopup_Show ("JSHB_CONFIRMACTIONDIALOG")
end
