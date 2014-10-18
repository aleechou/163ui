
TidyPlatesWidgetData.UnitDescriptions = TidyPlatesWidgetData.UnitDescriptions or {}
TidyPlatesWidgetData.UnitGuild = TidyPlatesWidgetData.UnitGuild or {}
TidyPlatesWidgetData.UnitClass = TidyPlatesWidgetData.UnitClass or {}

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

local UnitCacheMonitor
local UnitCacheMonitorEvents = {}
local _
local myRealm = GetRealmName("player")
local inInstance

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

local InstanceTypes = {
	["none"] = 1,
	["party"] = 2,
	["raid"] = 2,
	["arena"] = 3,
	["pvp"] = 3,
}

function UnitCacheMonitorEvents.WHO_LIST_UPDATE()
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


function UnitCacheMonitorEvents.PLAYER_ENTERING_WORLD()
	local itype = select(2, GetInstanceInfo())
	if itype and itype ~= "none" then inInstance = true else inInstance = false end
end

function UnitCacheMonitorEvents.UPDATE_MOUSEOVER_UNIT(self, ...)
	-- Bypass caching while in an instance
	if inInstance then return end

	-- Vars
	local name, class, realm, description, unitadded, descriptionAlt

	-- Player
	------------------------------------

	if UnitIsPlayer( "mouseover" ) then
		--print(UnitName("mouseover"), UnitRealmRelationship("mouseover"))
		local RealmRelationship = UnitRealmRelationship("mouseover")
		if RealmRelationship == LE_REALM_RELATION_COALESCED then
			-- Foreign units
			name = UnitName("mouseover").." (*)"
		else
			-- Local units
			name = UnitName("mouseover")
		end

		description = GetGuildInfo("mouseover")
		class = select(2, UnitClass("mouseover"))

		-- Check for alterations
		if TidyPlatesWidgetData.UnitGuild[name] ~= description or TidyPlatesWidgetData.UnitClass[name] ~= class then
			unitadded = true
			TidyPlatesWidgetData.UnitClass[name] = class
			TidyPlatesWidgetData.UnitGuild[name] = description
		end

	-- NPC
	------------------------------------
	else
		name = GameTooltipTextLeft1:GetText()

		if name then name = gsub( gsub( (name), "|c........", "" ), "|r", "" ) else return end
		if name ~= UnitName("mouseover") then return end
		if UnitPlayerControlled("mouseover") then return end	-- Avoid caching pet names

		--name = GameTooltipTextLeft1:GetText()
		--name = GameTooltipTextLeft1:GetText():gsub( "|c........", "" ):gsub( "|r", "" )

		description, descriptionAlt = GameTooltipTextLeft2:GetText(), GameTooltipTextLeft3:GetText()

		if ReputationStringList[description] then description = descriptionAlt end

		if description then
			local level = select(2, strsplit( " ", description ))
			if tonumber(level) or level == "??" then description = nil end		-- If the description is a level, don't store it
		end

		if TidyPlatesWidgetData.UnitDescriptions[name] ~= description then
			unitadded = true
			TidyPlatesWidgetData.UnitDescriptions[name] = description
		end

	end

	if unitadded then TidyPlates:RequestDelegateUpdate() end
end

function UnitCacheMonitorEvents.GUILD_ROSTER_UPDATE(self, ...)
	--
	--print("GUILD_ROSTER_UPDATE")
	UpdateGuildCache()
	TidyPlates:RequestDelegateUpdate()
end

function UnitCacheMonitorEvents.FRIENDLIST_UPDATE(self, ...)
	--
	--print("FRIENDLIST_UPDATE")
	UpdateFriendCache()
	TidyPlates:RequestDelegateUpdate()
end

local function OnEvent(frame, event, ...)
	UnitCacheMonitorEvents[event](...)
end

local function Enable()
	if not UnitCacheMonitor then UnitCacheMonitor = CreateFrame("Frame") end
	for event in pairs(UnitCacheMonitorEvents) do UnitCacheMonitor:RegisterEvent(event) end
	UnitCacheMonitor:SetScript("OnEvent", OnEvent)

	if not TidyPlatesWidgetData.UnitDescriptions then TidyPlatesWidgetData.UnitDescriptions = {} end
	if not TidyPlatesWidgetData.UnitClass then TidyPlatesWidgetData.UnitClass = {} end
	if not TidyPlatesWidgetData.UnitGuild then TidyPlatesWidgetData.UnitGuild = {} end
	if not Guild then Guild = {} end
	if not Friends then Friends = {} end

	GuildRoster()
	UpdateFriendCache()
	--print("TidyPlatesBeta Message: Unit Data Caching is Enabled")
end

local function Disable()
	if UnitCacheMonitor then
		UnitCacheMonitor:SetScript("OnEvent", nil)
		UnitCacheMonitor:UnregisterAllEvents()

	end
	--print("TidyPlatesBeta Message: Unit Data Caching is Disabled")
end

local function InstanceStatus()
	return inInstance
end

local function CachedUnitDescription(name)
	if inInstance then return nil else return TidyPlatesWidgetData.UnitDescriptions[name] end
end

local function CachedUnitGuild(name)
	if inInstance then return nil else return TidyPlatesWidgetData.UnitGuild[name] end
end

local function CachedUnitClass(name)
	if inInstance then return nil else return TidyPlatesWidgetData.UnitClass[name] end
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



