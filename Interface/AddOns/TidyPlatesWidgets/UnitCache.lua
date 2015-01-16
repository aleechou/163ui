local LocalDescription, LocalGuild, LocalClass = {}, {}, {}

TidyPlatesWidgetData.UnitDescriptions = TidyPlatesWidgetData.UnitDescriptions or {}
TidyPlatesWidgetData.UnitGuild = TidyPlatesWidgetData.UnitGuild or {}
TidyPlatesWidgetData.UnitClass = TidyPlatesWidgetData.UnitClass or {}
TidyPlatesWidgetData.UnitLastSeen = TidyPlatesWidgetData.UnitLastSeen or {}

local Friends = Friends or {}
local Guild = Guild or {}

local ReputationStringList = {
	[FACTION_STANDING_LABEL1] = true, -- "Hated";
	[FACTION_STANDING_LABEL2] = true, -- "Hostile";
	[FACTION_STANDING_LABEL3] = true, -- "Unfriendly";
	[FACTION_STANDING_LABEL4] = true, -- "Neutral";
	[FACTION_STANDING_LABEL5] = true, -- "Friendly";
	[FACTION_STANDING_LABEL6] = true, -- "Honored";
	[FACTION_STANDING_LABEL7] = true, -- "Revered";
	[FACTION_STANDING_LABEL8] = true, -- "Exalted";
}
--/run print("?", TidyPlatesWidgetData); for i,v in pairs(TidyPlatesWidgetData) do print(i,v); if type(v) == 'table' then for x,y in pairs(v) do print(x,y) end end end
--/run wipe(TidyPlatesWidgetData.UnitClass)

local UnitCacheMonitorFrame


local UnitCacheMonitorFrameEvents = {}
local _
local myRealm = GetRealmName("player")
local inInstance



-- GameTooltipScanner
local ScannerName = "TidyPlatesScanningTooltip"
local TooltipScanner = CreateFrame( "GameTooltip", ScannerName , nil, "GameTooltipTemplate" ); -- Tooltip name cannot be nil
TooltipScanner:SetOwner( WorldFrame, "ANCHOR_NONE" );

-- Do I even need this line?
--[[
TooltipScanner:AddFontStrings(
    TooltipScanner:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
    TooltipScanner:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) );
--]]

--  local right = _G[ScannerName.."TextRight"..i]:GetText()



local function UpdateGuildCache()
	if Guild then
		Guild = wipe(Guild)
	else
		Guild = {}
	end
	-- Blah blah blah
	local guildname = GetGuildInfo("player")
	if not guildname then return end
	local numGuildMembers, numOnline = GetNumGuildMembers()
	for index = 1, numGuildMembers do
		local name, rank, rankIndex, level, class, _, _, _, online = GetGuildRosterInfo(index)
		--local name, rank, rankIndex, level, class = GetGuildRosterInfo(index)
		if online then
			Guild[Ambiguate(name, "guild")] = class
			--print(Ambiguate(name, "guild"))
			--TidyPlatesWidgetData.UnitClass[name] = class
			--TidyPlatesWidgetData.UnitGuild[name] = guildname
		end
	end
end

--[[
local function UpdateCacheByZone(zone)
	-- /run TidyPlatesUtility.UpdateCacheByZone("Stormwind")
	SendWho(zone or GetZoneText())
end


local function UpdateCacheByCharacterName(character)
	-- /run SendWho("Binbwen"); print(GetWhoInfo(1)); print(GetWhoInfo(2))
	SendWho(character)

	local name, guild, level, race, class = GetWhoInfo(1)

	--print(name, guild, level, race, class)
	if character == name then
		TidyPlatesWidgetData.UnitClass[name] = class
		TidyPlatesWidgetData.UnitGuild[name] = guild
	end
end
--]]

local function UpdateFriendCache()
	if Friends then
		Friends = wipe(Friends)
	else
		Friends = {}
	end
	--
	local numFriends = GetNumFriends()
	for index = 1, numFriends do
		local name, level, class, _, connected = GetFriendInfo(index)
		if connected and name then
			Friends[name] = true
		end
	end
end


--[[
		local RealmRelationship = UnitRealmRelationship("mouseover")
		if RealmRelationship == LE_REALM_RELATION_COALESCED then
			-- Foreign units
			name = UnitName("mouseover").." (*)"
		else
			-- Local units
			name = UnitName("mouseover")
		end
--]]



local function CacheUnitByID(unitid)

	-- Bypass caching while in an instance
	if inInstance or (not UnitExists(unitid)) then return end

	-- Vars
	local name, class, realm, description, unitadded

	-- Player
	------------------------------------
	if UnitIsPlayer( unitid ) then

		local RealmRelationship = UnitRealmRelationship(unitid)
		if RealmRelationship == LE_REALM_RELATION_COALESCED then
			-- Foreign units
			name = UnitName(unitid)..FOREIGN_SERVER_LABEL  	-- " (*)"
		else
			-- Local units
			name = UnitName(unitid)
		end

		description = GetGuildInfo(unitid)
		class = select(2, UnitClass(unitid))

		-- Check for alterations
		if TidyPlatesWidgetData.UnitGuild[name] ~= description or TidyPlatesWidgetData.UnitClass[name] ~= class then
			unitadded = true
		end

	-- NPC
	------------------------------------
	else
		TooltipScanner:ClearLines()
 		TooltipScanner:SetUnit(unitid)

 		local TooltipTextLeft1 = _G[ScannerName.."TextLeft1"]
 		local TooltipTextLeft2 = _G[ScannerName.."TextLeft2"]

 		name = TooltipTextLeft1:GetText()
 		class = "NPC"

		if name then name = gsub( gsub( (name), "|c........", "" ), "|r", "" ) else return end	-- Strip color escape sequences: "|c"
		if name ~= UnitName(unitid) then return end	-- Avoid caching information for the wrong unit
		if UnitPlayerControlled(unitid) then return end	-- Avoid caching pet names

		-- Tooltip Format Priority:  Faction, Description, Level
		--local toolTip2, toolTip3 = TPUnitScanTextLeft2:GetText(), TPUnitScanTextLeft3:GetText()
		local toolTipText = TooltipTextLeft2:GetText() or "UNKNOWN"

		if string.match(toolTipText, UNIT_LEVEL_TEMPLATE) then	-- If the description line is a "Level", use the next line
			description = nil
		else
			description = toolTipText
		end

		if TidyPlatesWidgetData.UnitGuild[name] ~= description then
			unitadded = true
		end
	end

	-- Time Code, etc.
	------------------------------------
	local dateTable = date("*t")

	-- Store Timecode
	if name then
		TidyPlatesWidgetData.UnitLastSeen[name] = ((dateTable.year - 2006) * 365) + dateTable.yday
	end

	-- For temporary cache
	LocalClass[name] = class
	LocalGuild[name] = description

	-- For saved cache
	if unitadded then
		TidyPlatesWidgetData.UnitClass[name] = class
		TidyPlatesWidgetData.UnitGuild[name] = description

		TidyPlates:RequestDelegateUpdate()
	end
end


local InstanceTypes = {
	["none"] = 1,
	["party"] = 2,
	["raid"] = 2,
	["arena"] = 3,
	["pvp"] = 3,
}

function UnitCacheMonitorFrameEvents.WHO_LIST_UPDATE()
	local name, guild, level, race, class, zone, localClass

	for i = 1, GetNumWhoResults() do
		name, guild, level, race, localClass, zone, class	= GetWhoInfo(i)
		-- Check for alterations
		if TidyPlatesWidgetData.UnitGuild[name] ~= guild or TidyPlatesWidgetData.UnitClass[name] ~= class then
			unitadded = true
			TidyPlatesWidgetData.UnitClass[name] = class
			TidyPlatesWidgetData.UnitGuild[name] = guild
		end
	end

	if unitadded then TidyPlates:RequestDelegateUpdate() end
end


function UnitCacheMonitorFrameEvents.PLAYER_ENTERING_WORLD()
	local itype = select(2, GetInstanceInfo())
	if itype and itype ~= "none" then inInstance = true else inInstance = false end
end


function UnitCacheMonitorFrameEvents.PLAYER_TARGET_CHANGED(self, ...)
	CacheUnitByID("target")
end


function UnitCacheMonitorFrameEvents.UPDATE_MOUSEOVER_UNIT(self, ...)
	CacheUnitByID("mouseover")
end


function UnitCacheMonitorFrameEvents.GUILD_ROSTER_UPDATE(self, ...)
	--
	--print("GUILD_ROSTER_UPDATE")
	UpdateGuildCache()
	TidyPlates:RequestDelegateUpdate()
end


function UnitCacheMonitorFrameEvents.FRIENDLIST_UPDATE(self, ...)
	--
	--print("FRIENDLIST_UPDATE")
	UpdateFriendCache()
	TidyPlates:RequestDelegateUpdate()
end

local function OnEvent(frame, event, ...)
	UnitCacheMonitorFrameEvents[event](...)
end


local cleaned = false
local function CleanCaches()
	if cleaned == true then return end

	local d = date("*t")
	local now = ((d.year - 2006) * 365) + d.yday

	-- Clean Out caches
	for i,v in pairs(TidyPlatesWidgetData.UnitDescriptions) do
		local last = TidyPlatesWidgetData.UnitLastSeen[i]
		if last == nil or (now - last > 60) then
			TidyPlatesWidgetData.UnitDescriptions[i] = nil
		end
	end

	for i,v in pairs(TidyPlatesWidgetData.UnitGuild) do
		local last = TidyPlatesWidgetData.UnitLastSeen[i]
		if last == nil or (now - last > 60) then
			TidyPlatesWidgetData.UnitGuild[i] = nil
		end
	end

	for i,v in pairs(TidyPlatesWidgetData.UnitClass) do
		local last = TidyPlatesWidgetData.UnitLastSeen[i]
		if last == nil or (now - last > 60) then
			TidyPlatesWidgetData.UnitClass[i] = nil
		end
	end
	cleaned = true
end


local function Enable()
	if not UnitCacheMonitorFrame then UnitCacheMonitorFrame = CreateFrame("Frame") end
	for event in pairs(UnitCacheMonitorFrameEvents) do UnitCacheMonitorFrame:RegisterEvent(event) end
	UnitCacheMonitorFrame:SetScript("OnEvent", OnEvent)

	if not TidyPlatesWidgetData.UnitDescriptions then TidyPlatesWidgetData.UnitDescriptions = {} end
	if not TidyPlatesWidgetData.UnitClass then TidyPlatesWidgetData.UnitClass = {} end
	if not TidyPlatesWidgetData.UnitGuild then TidyPlatesWidgetData.UnitGuild = {} end
	if not TidyPlatesWidgetData.UnitLastSeen then TidyPlatesWidgetData.UnitLastSeen = {} end
	if not Guild then Guild = {} end
	if not Friends then Friends = {} end

	GuildRoster()
	UpdateFriendCache()
	CleanCaches()
	--print("TidyPlatesBeta Message: Unit Data Caching is Enabled")
end

local function Disable()
	if UnitCacheMonitorFrame then
		UnitCacheMonitorFrame:SetScript("OnEvent", nil)
		UnitCacheMonitorFrame:UnregisterAllEvents()

	end
	--print("TidyPlatesBeta Message: Unit Data Caching is Disabled")
end

local function InstanceStatus()
	return inInstance
end


local function CachedUnitGuild(name)

	if inInstance then 		-- If inInstance, don't both looking up the data...  might cause a hiccup if the table is huge
		return nil
	elseif LocalGuild[name] then
		return LocalGuild[name]
	elseif TidyPlatesWidgetData.UnitGuild[name] then
		LocalGuild[name] = TidyPlatesWidgetData.UnitGuild[name]
		return LocalGuild[name]
	end

	--if inInstance then return nil else return TidyPlatesWidgetData.UnitGuild[name] end
end

local function CachedUnitClass(name)
	if inInstance then 		-- If inInstance, don't bother looking up the data...  might cause a hiccup if the table is huge
		return nil
	elseif LocalClass[name] then
		return LocalClass[name]
	elseif TidyPlatesWidgetData.UnitClass[name] then
		LocalClass[name] = TidyPlatesWidgetData.UnitClass[name]
		return LocalClass[name]
	end

	--if inInstance then return nil else return TidyPlatesWidgetData.UnitClass[name] end
end

local function CachedUnitDescription(name)
	return CachedUnitGuild(name)
end

local function IsFriend(name)
	return Friends[name]
end

local function IsGuildmate(name)
	return Guild[name]
end

-- InstanceStatus, CachedUnitDescription, CachedUnitGuild, CachedUnitClass, IsFriend, IsGuildmate
TidyPlatesUtility.CachedUnitDescription = CachedUnitDescription
TidyPlatesUtility.CachedUnitGuild = CachedUnitGuild
TidyPlatesUtility.CachedUnitClass = CachedUnitClass


TidyPlatesUtility.IsFriend = IsFriend
TidyPlatesUtility.IsGuildmate = IsGuildmate

TidyPlatesUtility.InstanceStatus = InstanceStatus
TidyPlatesUtility.EnableUnitCache = Enable
TidyPlatesUtility.DisableUnitCache = Disable
--TidyPlatesUtility.UpdateCacheByZone = UpdateCacheByZone



