--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.lua - Scans NPCs near you for specific rare NPC IDs.              *
  ****************************************************************************]]


local NS = select( 2, ... );
_NPCScan = NS;
local L = NS.L;

NS.Frame = CreateFrame( "Frame" );
NS.Updater = NS.Frame:CreateAnimationGroup();
--NS.Version = GetAddOnMetadata( ..., "Version" ):match( "^([%d.]+)" );
NS.Version = 5.1;

NS.Options = {
	Version = NS.Version;
	NPCs = {
		[ 64004 ] = "Ghostly Pandaren Fisherman";
		[ 64191 ] = "Ghostly Pandaren Craftsman";
		[ 50409 ] ="Mysterious Camel Figurine";
		[ 50410 ] = "Mysterious Camel Figurine";
		[ 62346 ] = "Galleon";
		[ 60491 ] = "Sha of Anger";
		[ 69099 ] = "Nalak";
		[ 69161 ] = "Oondasta";
		};

	NPCWorldIDs = {			
		[ 50409 ] = 1; -- Mysterious Camel Figurine
		[ 50410 ] = 1; -- Mysterious Camel Figurine
		[ 62346 ] = 6; -- Galleon
		[ 60491 ] = 6; --"Sha of Anger";
		[ 64004 ] =  6; --"Ghostly Pandaren Fisherman";
		[ 64191 ] = 6; --"Ghostly Pandaren Craftsman";
		[ 69099 ] = 6; -- "Nalak";
		[ 69161 ] = 6; -- "Oondasta";
		};
};

NS.OptionsCharacter = {
	Version = NS.Version;
	Achievements = {		
		[ 1312 ] = true; -- Bloody Rare (Outlands)
		[ 2257 ] = true; -- Frostbitten (Northrend)
		[ 7317 ] = true; -- One Of Many
		[ 7439 ] = true; -- Glorious! (Pandaria)
		[ 8103 ] = true; -- Champions of Lei Shen
		[ 8714 ] = true;  --Timeless Champion

			};
	FlightSupress = true;
	Modules = {};
	ModulesAlpha = {};
	ModulesExtra = {};
	ModulesSaved = {};
	NPCWorldIDs = {};
	ShowAll = false;
};

NS.OptionsDefault = {
	Version = NS.Version;
	NPCs = {
		[ 64004 ] = "Ghostly Pandaren Fisherman";
		[ 64191 ] = "Ghostly Pandaren Craftsman";
		[ 50409 ] ="Mysterious Camel Figurine";
		[ 50410 ] = "Mysterious Camel Figurine";
		[ 62346 ] = "Galleon";
		[ 60491 ] = "Sha of Anger";
		[ 69099 ] = "Nalak";
		[ 69161 ] = "Oondasta";
	};
	NPCWorldIDs = {			
		[ 50409 ] = 1; -- Mysterious Camel Figurine
		[ 50410 ] = 1; -- Mysterious Camel Figurine
		[ 62346 ] = 6; -- Galleon
		[ 60491 ] = 6; --"Sha of Anger";
		[ 64004 ] =  6; --"Ghostly Pandaren Fisherman";
		[ 64191 ] = 6; --"Ghostly Pandaren Craftsman";
		[ 69099 ] = 6; -- "Nalak";
		[ 69161 ] = 6; -- "Oondasta";
		};
};

NS.OptionsCharacterDefault = {
	Version = NS.Version;
	Achievements = {
		[ 1312 ] = true; -- Bloody Rare (Outlands)
		[ 2257 ] = true; -- Frostbitten (Northrend)
		[ 7439 ] = true; -- Glorious! (Pandaria)
		[ 8103 ] = true; -- Champions of Lei Shen
		[ 8714 ] = true;  --Timeless Champion
		[ 7317 ] = true; -- One Of Many
			};
	AchievementsAddFound = nil;
	AlertSoundUnmute = nil;
	AlertSound = nil; -- Default sound
	CacheWarnings = true;
	FlightSupress = true;
	Modules = {};
	ModulesSaved = {};
	ModulesAlpha = {};
	ModulesExtra = {};
	NPCWorldIDs = {};
	ShowAll = false;
};
--[[
do
	local DEEPHOLM = GetMapNameByID( 640 );
	local MOLTEN_FRONT = GetMapNameByID( 795 );
	NS.OptionsCharacterDefault = {
		Version = NS.Version;
			NPCs = {
		
	};
		NPCWorldIDs = {
			[ 18684 ] = 3; -- Bro'Gaz the Clanless
			[ 32491 ] = 4; -- Time-Lost Proto Drake
			[ 33776 ] = 4; -- Gondria
			[ 35189 ] = 4; -- Skoll
			[ 38453 ] = 4; -- Arcturis
			[ 49822 ] = DEEPHOLM; -- Jadefang
			[ 49913 ] = 2; -- Lady LaLa
			[ 50005 ] = 2; -- Poseidus
			[ 50009 ] = 2; -- Mobus
			[ 50050 ] = 2; -- Shok'sharak
			[ 50051 ] = 2; -- Ghostcrawler
			[ 50052 ] = 2; -- Burgy Blackheart
			[ 50053 ] = 1; -- Thartuk the Exile
			[ 50056 ] = 1; -- Garr
			[ 50057 ] = 1; -- Blazewing
			[ 50058 ] = 1; -- Terrorpene
			[ 50059 ] = DEEPHOLM; -- Golgarok
			[ 50060 ] = DEEPHOLM; -- Terborus
			[ 50061 ] = DEEPHOLM; -- Xariona
			[ 50062 ] = DEEPHOLM; -- Aeonaxx
			[ 50063 ] = 1; -- Akma'hat
			[ 50064 ] = 1; -- Cyrus the Black
			[ 50065 ] = 1; -- Armagedillo
			[ 50085 ] = 2; -- Overlord Sunderfury
			[ 50086 ] = 2; -- Tarvus the Vile
			[ 50089 ] = 2; -- Julak-Doom
			[ 50138 ] = 2; -- Karoma
			[ 50154 ] = 1; -- Madexx
			[ 50159 ] = 2; -- Sambas
			[ 50409 ] = 1; -- Mysterious Camel Figurine
			[ 50410 ] = 1; -- Mysterious Camel Figurine
			[ 50815 ] = MOLTEN_FRONT; -- Skarr
			[ 50959 ] = MOLTEN_FRONT; -- Karkin
			[ 51071 ] = 2; -- Captain Florence
			[ 51079 ] = 2; -- Captain Foulwind
			[ 51401 ] = 1; -- Madexx
			[ 51402 ] = 1; -- Madexx
			[ 51403 ] = 1; -- Madexx
			[ 51404 ] = 1; -- Madexx
			[ 54318 ] = 1; -- Ankha
			[ 54319 ] = 1; -- Magria
			[ 54320 ] = 1; -- Ban'thalos
			[ 54321 ] = MOLTEN_FRONT; -- Solix
			[ 54322 ] = MOLTEN_FRONT; -- Deth'tilac
			[ 54323 ] = MOLTEN_FRONT; -- Kirix
			[ 54324 ] = MOLTEN_FRONT; -- Skitterflame
			[ 54338 ] = MOLTEN_FRONT; -- Anthriss
			[ 62346 ] = 6; -- Galleon
		};
	};
end
]]--

NS.Achievements = { --- Criteria data for each achievement.
	[ 1312 ] = { WorldID = 3; }; -- Bloody Rare (Outlands)
	[ 2257 ] = { WorldID = 4; }; -- Frostbitten (Northrend)
	[ 7439 ] = { WorldID = 6; }; -- Glorious! (Pandaria)
	[ 7317 ] = { WorldID = 6; }; -- One Of Many
	[ 8103 ] = { WorldID = 6; }; -- Champions of Lei Shen
	[ 8714 ] = { WorldID = 6; };  --Timeless Champion
};
do
	local VirtualContinents = { --- Continents without physical maps aren't used.
		[ 5 ] = true; -- The Maelstrom
	};
	NS.ContinentNames = { GetMapContinents() };
	for ContinentID in pairs( VirtualContinents ) do
		NS.ContinentNames[ ContinentID ] = nil;
	end
	NS.ContinentIDs = {}; --- Reverse lookup of NS.ContinentNames.
end

NS.NpcIDMax = 0xFFFFF; --- Largest ID that will fit in a GUID's 20-bit NPC ID field.
NS.Updater.UpdateRate = 0.1;




--- Prints a message in the default chat window.
function NS.Print ( Message, Color )
	if ( not Color ) then
		Color = NORMAL_FONT_COLOR;
	end
	DEFAULT_CHAT_FRAME:AddMessage( L.PRINT_FORMAT:format(
		NS.Options.PrintTime and date( CHAT_TIMESTAMP_FORMAT or L.TIME_FORMAT ) or "",
		Message ), Color.r, Color.g, Color.b );
end


do
	local Tooltip = CreateFrame( "GameTooltip", "_NPCScanTooltip" );
	-- Add template text lines
	local Text = Tooltip:CreateFontString();
	Tooltip:AddFontStrings( Text, Tooltip:CreateFontString() );
	--- Checks the cache for a given NpcID.
	-- @return Localized name of the NPC if cached, or nil if not.
	function NS.TestID ( NpcID )
		Tooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
		Tooltip:SetHyperlink( ( "unit:0xF53%05X00000000" ):format( NpcID ) );
		if ( Tooltip:IsShown() ) then
			return Text:GetText();
		end
	end
end


local CacheListBuild;
do
	local TempList, AlreadyListed = {}, {};
	--- Compiles a cache list into a printable list string.
	-- @param Relist  True to relist NPC names that have already been printed.
	-- @return List string, or nil if the list was empty.
	function CacheListBuild ( self, Relist )
		if ( next( self ) ) then
			-- Build and sort list
			for NpcID, Name in pairs( self ) do
				if ( Relist or not AlreadyListed[ NpcID ] ) then
					if ( not Relist ) then -- Filtered to show NPCs only once
						AlreadyListed[ NpcID ] = true; -- Don't list again
					end
					-- Add quotes to all entries
					TempList[ #TempList + 1 ] = L.CACHELIST_ENTRY_FORMAT:format( Name );
				end
			end

			wipe( self );
			if ( #TempList > 0 ) then
				sort( TempList );
				local ListString = table.concat( TempList, L.CACHELIST_SEPARATOR );
				wipe( TempList );
				return ListString;
			end
		end
	end
end
local CacheList = {};
do
	--- Fills a cache list with all added NPCs, active or not.
	local function CacheListPopulate ( self )
		for NpcID in pairs( NS.Options.NPCs ) do
			self[ NpcID ] = NS.TestID( NpcID );
		end
		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			for CriteriaID, NpcID in pairs( NS.Achievements[ AchievementID ].Criteria ) do
				if ( NS.OptionsCharacter.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfoByID( AchievementID, CriteriaID ) ) ) then -- Not completed
					self[ NpcID ] = NS.TestID( NpcID );
				end
			end
		end
	end
	local FirstPrint = true;
	--- Prints a standard message listing cached mobs.
	-- Will also print details about the cache the first time it's called.
	-- @param ForcePrint  Overrides the user's option to not print cache warnings.
	-- @param FullListing  Adds all cached NPCs before printing, active or not.
	-- @return True if list printed.
	function NS.CacheListPrint ( ForcePrint, FullListing )
		if ( ForcePrint or NS.Options.CacheWarnings ) then
			if ( FullListing ) then
				CacheListPopulate( CacheList );
			end
			local ListString = CacheListBuild( CacheList, ForcePrint or FullListing ); -- Allow printing an NPC a second time if forced or full listing
			if ( ListString ) then
				NS.Print( L[ FirstPrint and "CACHED_LONG_FORMAT" or "CACHED_FORMAT" ]:format( ListString ), ForcePrint and RED_FONT_COLOR );
				FirstPrint = false;
				return true;
			end
		else
			wipe( CacheList );
		end
	end
end




local next, assert = next, assert;

local ScanIDs = {}; --- [ NpcID ] = Number of concurrent scans for this ID
--- Begins searching for an NPC.
-- @return True if successfully added.
local function ScanAdd ( NpcID )
	local Name = NS.TestID( NpcID );
	if ( Name ) then -- Already seen
		CacheList[ NpcID ] = Name;
	else -- Increment
		if ( ScanIDs[ NpcID ] ) then
			ScanIDs[ NpcID ] = ScanIDs[ NpcID ] + 1;
		else
			if ( not next( ScanIDs ) ) then -- First
				NS.Updater:Play();
			end
			ScanIDs[ NpcID ] = 1;
			NS.Overlays.Add( NpcID );
		end
		return true; -- Successfully added
	end
end
--- Stops searching for an NPC when nothing is searching for it.
local function ScanRemove ( NpcID )
	local Count = assert( ScanIDs[ NpcID ], "Attempt to remove inactive scan." );
	if ( Count > 1 ) then
		ScanIDs[ NpcID ] = Count - 1;
	else
		ScanIDs[ NpcID ] = nil;
		NS.Overlays.Remove( NpcID );
		if ( not next( ScanIDs ) ) then -- Last
			NS.Updater:Stop();
		end
	end
end




--- @return True if the given WorldID is active on the current world.
local function IsWorldIDActive ( WorldID )
	return not WorldID or WorldID == NS.WorldID; -- False/nil active on all worlds
end

local NPCActivate, NPCDeactivate;
do
	local NPCsActive = {};
	--- Starts actual scan for NPC if on the right world.
	function NPCActivate ( NpcID, WorldID )
		if ( not NPCsActive[ NpcID ] and IsWorldIDActive( WorldID ) and ScanAdd( NpcID ) ) then
			NPCsActive[ NpcID ] = true;
			NS.Config.Search.UpdateTab( "NPC" );
			return true; -- Successfully activated
		end
	end
	--- Ends actual scan for NPC.
	function NPCDeactivate ( NpcID )
		if ( NPCsActive[ NpcID ] ) then
			NPCsActive[ NpcID ] = nil;
			ScanRemove( NpcID );
			NS.Config.Search.UpdateTab( "NPC" );
			return true; -- Successfully deactivated
		end
	end
	--- @return True if a custom NPC is actively being searched for.
	function NS.NPCIsActive ( NpcID )
		return NPCsActive[ NpcID ];
	end
end
--- Adds an NPC name and ID to settings and begins searching.
-- @param NpcID  Numeric ID of the NPC (See Wowhead.com).
-- @param Name  Temporary name to identify this NPC by in the search table.
-- @param WorldID  Number or localized string WorldID to limit this search to.
-- @return True if custom NPC added.
function NS.NPCAdd ( NpcID, Name, WorldID )
	NpcID = assert( tonumber( NpcID ), "NpcID must be numeric." );
	local Options = NS.Options;
	if ( not Options.NPCs[ NpcID ] ) then
		assert( type( Name ) == "string", "Name must be a string." );
		assert( WorldID == nil or type( WorldID ) == "string" or type( WorldID ) == "number", "Invalid WorldID." );
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = Name, WorldID;
		if ( not NPCActivate( NpcID, WorldID ) ) then -- Didn't activate
			NS.Config.Search.UpdateTab( "NPC" ); -- Just add row
		end
		return true;
	end
end
--- Removes an NPC from settings and stops searching for it.
-- @param NpcID  Numeric ID of the NPC.
-- @return True if custom NPC removed.
function NS.NPCRemove ( NpcID )
	NpcID = tonumber( NpcID );
	local Options = NS.Options;
	if ( Options.NPCs[ NpcID ] ) then
		Options.NPCs[ NpcID ], Options.NPCWorldIDs[ NpcID ] = nil;
		if ( not NPCDeactivate( NpcID ) ) then -- Wasn't active
			NS.Config.Search.UpdateTab( "NPC" ); -- Just remove row
		end
		return true;
	end
end




--- Starts searching for an achievement's NPC if it meets all settings.
local function AchievementNPCActivate ( Achievement, NpcID, CriteriaID )
	if ( Achievement.Active and not Achievement.NPCsActive[ NpcID ]
		and ( NS.OptionsCharacter.AchievementsAddFound or not select( 3, GetAchievementCriteriaInfoByID( Achievement.ID, CriteriaID ) ) ) -- Not completed
		and ScanAdd( NpcID )
	) then
		Achievement.NPCsActive[ NpcID ] = CriteriaID;
		NS.Config.Search.UpdateTab( Achievement.ID );
		return true;
	end
end
--- Stops searching for an achievement's NPC.
local function AchievementNPCDeactivate ( Achievement, NpcID )
	if ( Achievement.NPCsActive[ NpcID ] ) then
		Achievement.NPCsActive[ NpcID ] = nil;
		ScanRemove( NpcID );
		NS.Config.Search.UpdateTab( Achievement.ID );
		return true;
	end
end
--- Starts actual scans for achievement NPCs if on the right world.
local function AchievementActivate ( Achievement )
	if ( not Achievement.Active and IsWorldIDActive( Achievement.WorldID ) ) then
		Achievement.Active = true;
		for CriteriaID, NpcID in pairs( Achievement.Criteria ) do
			AchievementNPCActivate( Achievement, NpcID, CriteriaID );
		end
		return true;
	end
end
-- Ends actual scans for achievement NPCs.
local function AchievementDeactivate ( Achievement )
	if ( Achievement.Active ) then
		Achievement.Active = nil;
		for NpcID in pairs( Achievement.NPCsActive ) do
			AchievementNPCDeactivate( Achievement, NpcID );
		end
		return true;
	end
end
--- @param Achievement  Achievement data table from NS.Achievements.
-- @return True if the achievement NPC is being searched for.
function NS.AchievementNPCIsActive ( Achievement, NpcID )
	return Achievement.NPCsActive[ NpcID ] ~= nil;
end
--- Adds a kill-related achievement to track.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement added.
function NS.AchievementAdd ( AchievementID )
	AchievementID = assert( tonumber( AchievementID ), "AchievementID must be numeric." );
	local Achievement = NS.Achievements[ AchievementID ];
	if ( Achievement and not NS.OptionsCharacter.Achievements[ AchievementID ] ) then
		if ( not next( NS.OptionsCharacter.Achievements ) ) then -- First
			NS.Frame:RegisterEvent( "ACHIEVEMENT_EARNED" );
			NS.Frame:RegisterEvent( "CRITERIA_UPDATE" );
		end
		NS.OptionsCharacter.Achievements[ AchievementID ] = true;
		NS.Config.Search.AchievementSetEnabled( AchievementID, true );
		AchievementActivate( Achievement );
		return true;
	end
end
--- Removes an achievement from settings and stops tracking it.
-- @param AchievementID  Numeric ID of achievement.
-- @return True if achievement removed.
function NS.AchievementRemove ( AchievementID )
	if ( NS.OptionsCharacter.Achievements[ AchievementID ] ) then
		AchievementDeactivate( NS.Achievements[ AchievementID ] );
		NS.OptionsCharacter.Achievements[ AchievementID ] = nil;
		if ( not next( NS.OptionsCharacter.Achievements ) ) then -- Last
			NS.Frame:UnregisterEvent( "ACHIEVEMENT_EARNED" );
			NS.Frame:UnregisterEvent( "CRITERIA_UPDATE" );
		end
		NS.Config.Search.AchievementSetEnabled( AchievementID, false );
		return true;
	end
end




--- Enables printing cache lists on login.
-- @return True if changed.
function NS.SetCacheWarnings ( Enable )
	if ( not Enable ~= not NS.Options.CacheWarnings ) then
		NS.Options.CacheWarnings = Enable or nil;

		NS.Config.CacheWarnings:SetChecked( Enable );
		return true;
	end
end
--- Enables adding a timestamp to printed messages.
-- @return True if changed.
function NS.SetPrintTime ( Enable )
	if ( not Enable ~= not NS.Options.PrintTime ) then
		NS.Options.PrintTime = Enable or nil;

		NS.Config.PrintTime:SetChecked( Enable );
		return true;
	end
end
--- Enables tracking of unneeded achievement NPCs.
-- @return True if changed.
function NS.SetAchievementsAddFound ( Enable )
	if ( not Enable ~= not NS.OptionsCharacter.AchievementsAddFound ) then
		NS.OptionsCharacter.AchievementsAddFound = Enable or nil;
		NS.Config.Search.AddFoundCheckbox:SetChecked( Enable );

		for _, Achievement in pairs( NS.Achievements ) do
			if ( AchievementDeactivate( Achievement ) ) then -- Was active
				AchievementActivate( Achievement );
			end
		end
		return true;
	end
end
--- Enables unmuting sound to play found alerts.
-- @return True if changed.
function NS.SetAlertSoundUnmute ( Enable )
	if ( not Enable ~= not NS.OptionsCharacter.AlertSoundUnmute ) then
		NS.OptionsCharacter.AlertSoundUnmute = Enable or nil;

		NS.Config.AlertSoundUnmute:SetChecked( Enable );
		return true;
	end
end
--- Sets the sound to play when NPCs are found.
-- @return True if changed.
function NS.SetAlertSound ( AlertSound )
	assert( AlertSound == nil or type( AlertSound ) == "string", "AlertSound must be a string or nil." );
	if ( AlertSound ~= NS.OptionsCharacter.AlertSound ) then
		NS.OptionsCharacter.AlertSound = AlertSound;

		UIDropDownMenu_SetText( NS.Config.AlertSound, AlertSound == nil and L.CONFIG_ALERT_SOUND_DEFAULT or AlertSound );
		return true;
	end
end

--- Enables Blocking alerts while on taxi.
-- @return True if changed.
function NS.SetBlockFlightScan ( Enable )
		NS.OptionsCharacter.FlightSupress = Enable 
		NS.Config.Search.BlockFlightScanCheckbox:SetChecked( Enable );
		return Enable;
	
end


local IsDefaultNPCValid;
do
	local IsHunter = select( 2, UnitClass( "player" ) ) == "HUNTER";
	local TamableExceptions = {
		[ 49822 ] = true; -- Jadefang drops a pet
	};
	local FactionRestrictions = { -- [NpcID] = FactionGroup to enable for
		[ 51071 ] = "Horde"; -- Captain Florence
		[ 51079 ] = "Alliance"; -- Captain Foulwind
	};
	--- @return True if NpcID should be a default for this character.
	function IsDefaultNPCValid ( NpcID )
		return ( IsHunter or not NS.TamableIDs[ NpcID ] or TamableExceptions[ NpcID ] )
			and ( not FactionRestrictions[ NpcID ] or FactionRestrictions[ NpcID ] == UnitFactionGroup( "player" ) );
	end
end
--- Resets the scanning list and reloads it from saved settings.
function NS.Synchronize ( Options, OptionsCharacter )
	-- Load defaults if settings omitted
	local IsDefaultScan;
	if ( not Options ) then
		Options = NS.OptionsDefault;
	end
	if ( not OptionsCharacter ) then
		OptionsCharacter, IsDefaultScan = NS.OptionsCharacterDefault, true;
	end

	-- Clear all scans
	for AchievementID in pairs( NS.Achievements ) do
		NS.AchievementRemove( AchievementID );
	end
	for NpcID in pairs( NS.Options.NPCs ) do
		NS.NPCRemove( NpcID );
	end

	for NpcID, WorldID in pairs( NS.RareMobData.NPCWorldIDs ) do
		NS.NPCRemove( NpcID );
	end
	assert( not next( ScanIDs ), "Orphan NpcIDs in scan pool!" );

	NS.SetCacheWarnings( Options.CacheWarnings );
	NS.SetPrintTime( Options.PrintTime );
	NS.SetAchievementsAddFound( OptionsCharacter.AchievementsAddFound );
	NS.SetAlertSoundUnmute( OptionsCharacter.AlertSoundUnmute );
	NS.SetAlertSound( OptionsCharacter.AlertSound );
	NS.SetBlockFlightScan(OptionsCharacter.FlightSupress);

	local AddAllDefaults = IsShiftKeyDown();
	for NpcID, Name in pairs( Options.NPCs ) do
		-- If defaults, only add tamable custom mobs if the player is a hunter
		if ( AddAllDefaults or not IsDefaultScan or IsDefaultNPCValid( NpcID ) ) then
			NS.NPCAdd( NpcID, Name, Options.NPCWorldIDs[ NpcID ] );
		end
	end
	for AchievementID in pairs( NS.Achievements ) do
		-- If defaults, don't enable completed achievements unless explicitly allowed
		if ( OptionsCharacter.Achievements[ AchievementID ] and (
			not IsDefaultScan or OptionsCharacter.AchievementsAddFound or not select( 4, GetAchievementInfo( AchievementID ) ) -- Not completed
		) ) then
			NS.AchievementAdd( AchievementID );
		end
	end
	NS.CacheListPrint( false, true ); -- Populates cache list with inactive mobs too before printing
end




do
	local PetList = {};

	--- Prints the list of cached pets when leaving a city or inn.
	function NS.Frame:PLAYER_UPDATE_RESTING ()
		if ( not IsResting() and next( PetList ) ) then
			if ( NS.Options.CacheWarnings ) then
				local ListString = CacheListBuild( PetList );
				if ( ListString ) then
					NS.Print( L.CACHED_PET_RESTING_FORMAT:format( ListString ), RED_FONT_COLOR );
				end
			else
				wipe( PetList );
			end
		end
	end

	--- @return True if the tamable mob is in its correct zone, else false with an optional reason string.
	local function OnFoundTamable ( NpcID, Name )
		local ExpectedZone = NS.TamableIDs[ NpcID ];
		local ZoneIDBackup = GetCurrentMapAreaID();

		local InCorrectZone, InvalidReason;
		if ( ExpectedZone == true ) then -- Expected zone is unknown (instance mob, etc.)
			InCorrectZone = not IsResting(); -- Assume any tamable mob found in a city/inn is a hunter pet
		else
			SetMapToCurrentZone();
			InCorrectZone = ExpectedZone == GetCurrentMapAreaID();
		end

		if ( not InCorrectZone ) then
			if ( IsResting() ) then
				PetList[ NpcID ] = Name;  -- Suppress error message until the player stops resting
			else
				-- Get details about expected zone
				local ExpectedZoneName = GetMapNameByID( ExpectedZone );
				if ( not ExpectedZoneName ) then -- GetMapNameByID returns nil for continent maps
					SetMapByID( ExpectedZone );
					local Continent = GetCurrentMapContinent();
					if ( Continent >= 1 ) then
						ExpectedZoneName = select( Continent, GetMapContinents() );
					end
				end
				InvalidReason = L.FOUND_TAMABLE_WRONGZONE_FORMAT:format(
					Name, GetRealZoneText(), ExpectedZoneName or L.FOUND_ZONE_UNKNOWN, ExpectedZone );
			end
		end

		SetMapByID( ZoneIDBackup ); -- Restore previous map view
		return InCorrectZone, InvalidReason;
	end
	--- @return Name of the source of NpcID's scan--either a custom name or achievement name.
	local function GetScanSource ( NpcID )
		local CustomName = NS.Options.NPCs[ NpcID ];
		if ( CustomName ) then
			return CustomName;
		end
		-- Must have been from an achievement
		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			if ( NS.Achievements[ AchievementID ].NPCsActive[ NpcID ] ) then
				return GetAchievementLink( AchievementID ); -- Colored link to distinguish from a custom name
			end
		end
	end
	--- Validates found mobs before showing alerts.
	local function OnFound ( NpcID, Name )
		-- Disable active scans
		NPCDeactivate( NpcID );
		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			AchievementNPCDeactivate( NS.Achievements[ AchievementID ], NpcID );
		end

		local Valid, InvalidReason = true;
		local Tamable = NS.TamableIDs[ NpcID ];
		if ( Tamable ) then
			Valid, InvalidReason = OnFoundTamable( NpcID, Name );
		end

		--Checks to see if player is on flightpath, this will block possible cross realm alerts
		if (NS.OptionsCharacter.FlightSupress) then
			local onTaxi = UnitOnTaxi("player")
			if onTaxi then
				Valid = false
				 SetMapToCurrentZone()
				local posX, posY = GetPlayerMapPosition("player");
				local zoneName = GetZoneText();
				InvalidReason = L.FOUND_UNIT_TAXI:format(Name,posX*100, posY*100, zoneName );
					--NS.PlaySound ( AlertSound )
				PlaySound("TellMessage", "master");
			end
		end

		if ( Valid ) then
			NS.Print( L[ Tamable and "FOUND_TAMABLE_FORMAT" or "FOUND_FORMAT" ]:format( Name ), GREEN_FONT_COLOR );
			NS.Button:SetNPC( NpcID, Name, GetScanSource( NpcID ) ); -- Sends added and found overlay messages
		elseif ( InvalidReason ) then
			NS.Print( InvalidReason );
		end
	end

	local pairs = pairs;
	local GetAchievementCriteriaInfoByID = GetAchievementCriteriaInfoByID;
	--- Scans all active criteria and removes any completed NPCs.
	local function AchievementCriteriaUpdate ()
		if ( not NS.OptionsCharacter.AchievementsAddFound ) then
			for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
				local Achievement = NS.Achievements[ AchievementID ];
				for NpcID, CriteriaID in pairs( Achievement.NPCsActive ) do
					local _, _, Complete = GetAchievementCriteriaInfoByID( AchievementID, CriteriaID );
					if ( Complete ) then
						AchievementNPCDeactivate( Achievement, NpcID );
					end
				end
			end
		end
	end
	local CriteriaUpdated = false;
	--- Stops tracking individual achievement NPCs when the player gets kill credit.
	function NS.Frame:CRITERIA_UPDATE ()
		CriteriaUpdated = true;
	end

	--- Scans all NPCs on a timer and alerts if any are found.
	function NS.Updater:OnLoop ()
		if ( CriteriaUpdated ) then -- CRITERIA_UPDATE bucket
			CriteriaUpdated = false;
			AchievementCriteriaUpdate();
		end

		for NpcID in pairs( ScanIDs ) do
			local Name = NS.TestID( NpcID );
			if ( Name ) then
				OnFound( NpcID, Name );
			end
		end
	end
end
if ( select( 2, UnitClass( "player" ) ) == "HUNTER" ) then
	local StableUpdater = CreateFrame( "Frame" );

	local StabledList = {};
	--- Stops scans for stabled hunter pets before a bogus alert can fire.
	function NS.Frame:PET_STABLE_UPDATE ()
		for NpcID in pairs( ScanIDs ) do
			local Name = NS.TestID( NpcID );
			if ( Name ) then
				StabledList[ NpcID ] = Name;
				NPCDeactivate( NpcID );
				for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
					AchievementNPCDeactivate( NS.Achievements[ AchievementID ], NpcID );
				end
			end
		end
		StableUpdater:Show();
	end
	--- Bucket to print cached stabled pets on one line.
	function StableUpdater:OnUpdate ()
		self:Hide();
		if ( NS.Options.CacheWarnings ) then
			local ListString = CacheListBuild( StabledList );
			if ( ListString ) then
				NS.Print( L.CACHED_STABLED_FORMAT:format( ListString ) );
			end
		else
			wipe( StabledList );
		end
	end

	StableUpdater:Hide();
	StableUpdater:SetScript( "OnUpdate", StableUpdater.OnUpdate );
	NS.Frame:RegisterEvent( "PET_STABLE_UPDATE" );

	local Backup = GetStablePetInfo;
	--- Prevents the pet UI from querying (and caching) stabled pets until actually viewing the stables.
	-- @param Override  Forces a normal query even if the stables aren't open.
	function GetStablePetInfo ( Slot, Override, ... )
		if ( Override or Slot <= NUM_PET_ACTIVE_SLOTS or IsAtStableMaster() ) then
			return Backup( Slot, Override, ... );
		end
	end
end




--- Loads defaults, validates settings, and starts scan.
-- Used instead of ADDON_LOADED to give overlay mods a chance to load and register for messages.
function NS.Frame:PLAYER_LOGIN ( Event )
	self[ Event ] = nil;

	local Options, OptionsCharacter = _NPCScanOptions, _NPCScanOptionsCharacter;
	_NPCScanOptions, _NPCScanOptionsCharacter = NS.Options, NS.OptionsCharacter;

	-- Update settings incrementally
	if ( Options and Options.Version ~= NS.Version ) then
	--Clears old settings and updates to new variables
		if ( (Options.Version == nil) or (Options.Version < "5.1") ) then
		Options = NS.OptionsDefault;
		OptionsCharacter = NS.OptionsCharacterDefault;
		Options.Version = NS.Version;
		end
	end
	-- Character settings
	--[[if ( OptionsCharacter and OptionsCharacter.Version ~= NS.Version ) then
		local Version = OptionsCharacter.Version;

		local WorldIDs = NS.OptionsCharacterDefault.NPCWorldIDs;
		--- Add NpcID if not already being searched for.
		local function AddDefault ( NpcID )
			if ( not OptionsCharacter.NPCs[ NpcID ] -- Not already searched for
				and IsDefaultNPCValid( NpcID )
			) then
				OptionsCharacter.NPCs[ NpcID ] = L.NPCs[ NpcID ];
				OptionsCharacter.NPCWorldIDs[ NpcID ] = WorldIDs[ NpcID ];
			end
		end

		if ( Version == "3.0.9.2" ) then -- 3.1.0.1: Remove NPCs that are duplicated by achievements
			local NPCs = OptionsCharacter.IDs;
			OptionsCharacter.IDs = nil;
			OptionsCharacter.NPCs = NPCs;
			OptionsCharacter.Achievements = {};
			local AchievementNPCs = {};
			for AchievementID, Achievement in pairs( NS.Achievements ) do
				for _, NpcID in pairs( Achievement.Criteria ) do
					AchievementNPCs[ NpcID ] = AchievementID;
				end
			end
			for Name, NpcID in pairs( NPCs ) do
				if ( AchievementNPCs[ NpcID ] ) then
					NPCs[ Name ] = nil;
					OptionsCharacter.Achievements[ AchievementNPCs[ NpcID ] ] = true;
				end
			end
			Version = "3.1.0.1";
		end
		if ( Version == "3.1.0.1" or Version == "3.2.0.1" or Version == "3.2.0.2" ) then
			-- 3.2.0.3: Added default scan for Skoll
			OptionsCharacter.NPCs[ L.NPCs[ 35189 ] ] = 35189;
			Version = "3.2.0.3";
		end
		if ( "3.2.0.3" <= Version and Version <= "3.3.0.1" ) then
			-- 3.3.0.2: Added default scan for Arcturis
			OptionsCharacter.NPCs[ L.NPCs[ 38453 ] ] = 38453;
			Version = "3.3.0.2";
		end
		if ( Version == "3.3.0.2" or Version == "3.3.0.3" or Version == "3.3.0.4" ) then
			-- 3.3.5.1: Custom NPC scans are indexed by ID instead of name, and can now be map-specific
			local DefaultWorldIDs = NS.OptionsCharacterDefault.NPCWorldIDs;
			local NPCsNew, NPCWorldIDs = {}, {};
			for Name, NpcID in pairs( OptionsCharacter.NPCs ) do
				NPCsNew[ NpcID ] = Name;
				NPCWorldIDs[ NpcID ] = DefaultWorldIDs[ NpcID ];
			end
			OptionsCharacter.NPCs, OptionsCharacter.NPCWorldIDs = NPCsNew, NPCWorldIDs;
			Version = "3.3.5.1";
		end
		if ( Version < "4.0.3.1" ) then
			-- 4.0.3.1: Added default scans for Cataclysm rares
			AddDefault( 49913 ); -- Lady LaLa
			AddDefault( 50005 ); -- Poseidus
			AddDefault( 50009 ); -- Mobus
			AddDefault( 50050 ); -- Shok'sharak
			AddDefault( 50051 ); -- Ghostcrawler
			AddDefault( 50052 ); -- Burgy Blackheart
			AddDefault( 50053 ); -- Thartuk the Exile
			AddDefault( 50056 ); -- Garr
			AddDefault( 50057 ); -- Blazewing
			AddDefault( 50058 ); -- Terrorpene
			AddDefault( 50059 ); -- Golgarok
			AddDefault( 50060 ); -- Terborus
			AddDefault( 50061 ); -- Xariona
			AddDefault( 50062 ); -- Aeonaxx
			AddDefault( 50063 ); -- Akma'hat
			AddDefault( 50064 ); -- Cyrus the Black
			AddDefault( 50065 ); -- Armagedillo
			AddDefault( 50085 ); -- Overlord Sunderfury
			AddDefault( 50086 ); -- Tarvus the Vile
			AddDefault( 50089 ); -- Julak-Doom
			AddDefault( 50138 ); -- Karoma
			AddDefault( 50154 ); -- Madexx
			AddDefault( 50159 ); -- Sambas
			AddDefault( 50409 ); -- Mysterious Camel Figurine
			AddDefault( 50410 ); -- Mysterious Camel Figurine
			AddDefault( 51071 ); -- Captain Florence
			AddDefault( 51079 ); -- Captain Foulwind
			AddDefault( 51401 ); -- Madexx
			AddDefault( 51402 ); -- Madexx
			AddDefault( 51403 ); -- Madexx
			AddDefault( 51404 ); -- Madexx
			Version = "4.0.3.1";
		end
		if ( Version < "4.0.3.3" ) then
			-- 4.0.3.3: Fixed omission of Jadefang.
			AddDefault( 49822 ); -- Jadefang
			Version = "4.0.3.3";
		end
		if ( Version < "4.2.0.2" ) then
			-- 4.2.0.2: Added 4.2's rare hunter pets.
			AddDefault( 50815 ); -- Skarr
			AddDefault( 50959 ); -- Karkin
			AddDefault( 54318 ); -- Ankha
			AddDefault( 54319 ); -- Magria
			AddDefault( 54320 ); -- Ban'thalos
			AddDefault( 54321 ); -- Solix
			AddDefault( 54322 ); -- Deth'tilac
			AddDefault( 54323 ); -- Kirix
			AddDefault( 54324 ); -- Skitterflame
			AddDefault( 54338 ); -- Anthriss
			Version = "4.2.0.2";
		end
		if ( Version < "5.0.0.1" ) then
			-- 5.0.0.1: Added MoP's rare achievement.
			OptionsCharacter.Achievements[ 7439 ] = true; -- Glorious!
			Version = "5.0.0.1";
		end
		if ( Version < "5.0.0.2" ) then
			-- 5.0.0.2: Made the achievement checkbox settings global
			OptionsCharacter.Achievements = nil;
			Version = "5.0.0.2";
		end
		if ( Version < "5.0.0.5" ) then
			-- 5.0.0.5: Added Galleon.
			AddDefault( 62346 ); -- Galleon
			Version = "5.0.0.5";
		end
		OptionsCharacter.Version = NS.Version;
	end
--]]
	NS.Overlays.Register();
	NS.Synchronize( Options, OptionsCharacter ); -- Loads defaults if either are nil
end
do
	local FirstWorld = true;
	--- Starts world-specific scans when entering a world.
	function NS.Frame:PLAYER_ENTERING_WORLD ()
		-- Print cached pets if player ported out of a city
		self:PLAYER_UPDATE_RESTING();

		-- Since real MapIDs aren't available to addons, a "WorldID" is a universal ContinentID or the map's localized name.
		local MapName = GetInstanceInfo();
		NS.WorldID = NS.ContinentIDs[ MapName ] or MapName;

		-- Activate scans on this world
		--Loads Any Custom Mobs
		for NpcID, WorldID in pairs( NS.Options.NPCWorldIDs ) do
			NPCActivate( NpcID, WorldID );
		end

		--Loads Rare Mob Databas
		for NpcID, WorldID in pairs( NS.RareMobData.NPCWorldIDs ) do
			NPCActivate( NpcID, WorldID );
		end

		for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
			local Achievement = NS.Achievements[ AchievementID ];
			if ( Achievement.WorldID ) then
				AchievementActivate( Achievement );
			end
		end

		if ( FirstWorld or not NS.Options.CacheWarnings ) then -- Full listing of cached mobs gets printed on login
			FirstWorld = false;
			wipe( CacheList );
		else -- Print list of cached mobs specific to new world
			local ListString = CacheListBuild( CacheList );
			if ( ListString ) then
				NS.Print( L.CACHED_WORLD_FORMAT:format( ListString, MapName ) );
			end
		end
		NS.Config.Search:UpdateTabNames()
	end
end
--- Stops world-specific scans when leaving a world.
function NS.Frame:PLAYER_LEAVING_WORLD ()
	-- Stop scans that were only active on the previous world
	for NpcID in pairs( NS.Options.NPCWorldIDs ) do
		NPCDeactivate( NpcID );
	end
	for AchievementID in pairs( NS.OptionsCharacter.Achievements ) do
		local Achievement = NS.Achievements[ AchievementID ];
		if ( Achievement.WorldID ) then
			AchievementDeactivate( Achievement );
		end
	end
	NS.WorldID = nil;
end
--- Stops tracking achievements when they finish.
function NS.Frame:ACHIEVEMENT_EARNED ( _, AchievementID )
	if ( not NS.OptionsCharacter.AchievementsAddFound ) then
		NS.AchievementRemove( AchievementID );
	end
end
--- Sets the update handler only after zone info is known.
function NS.Frame:ZONE_CHANGED_NEW_AREA ( Event )
	self:UnregisterEvent( Event );
	self[ Event ] = nil;

	NS.Updater:SetScript( "OnLoop", NS.Updater.OnLoop );
end
--- Global event handler.
function NS.Frame:OnEvent ( Event, ... )
	if ( self[ Event ] ) then
		return self[ Event ]( self, Event, ... );
	end
end




--- Slash command chat handler to open the options pane and manage the NPC list.
function NS.SlashCommand ( Input )
	local Command, Arguments = Input:match( "^(%S+)%s*(.-)%s*$" );
	if ( Command ) then
		Command = Command:upper();
		if ( Command == L.CMD_ADD ) then
			local ID, Name = Arguments:match( "^(%d+)%s+(.+)$" );
			if ( ID ) then
				ID = tonumber( ID );
				NS.NPCRemove( ID );
				if ( NS.NPCAdd( ID, Name ) ) then
					NS.CacheListPrint( true );
				end
				return;
			end
		elseif ( Command == L.CMD_REMOVE ) then
			local ID = tonumber( Arguments );
			if ( not ID ) then -- Search custom names
				for NpcID, Name in pairs( NS.Options.NPCs ) do
					if ( Name == Arguments ) then
						ID = NpcID;
						break;
					end
				end
			end
			if ( not NS.NPCRemove( ID ) ) then
				NS.Print( L.CMD_REMOVENOTFOUND_FORMAT:format( Arguments ), RED_FONT_COLOR );
			end
			return;
		elseif ( Command == L.CMD_CACHE ) then -- Force print full cache list
			if ( not NS.CacheListPrint( true, true ) ) then -- Nothing in cache
				NS.Print( L.CMD_CACHE_EMPTY, GREEN_FONT_COLOR );
			end
			return;
		end
		-- Invalid subcommand
		NS.Print( L.CMD_HELP );

	else -- No subcommand
		InterfaceOptionsFrame_OpenToCategory( NS.Config.Search );
	end
end




-- Create reverse lookup of continent names
for Index, Name in pairs( NS.ContinentNames ) do
	NS.ContinentIDs[ Name ] = Index;
end
-- Save achievement criteria data
for AchievementID, Achievement in pairs( NS.Achievements ) do
	Achievement.ID = AchievementID;
	Achievement.Criteria = {}; -- [ CriteriaID ] = NpcID;
	Achievement.NPCsActive = {}; -- [ NpcID ] = CriteriaID;
	for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
		local _, CriteriaType, _, _, _, _, _, AssetID, _, CriteriaID = GetAchievementCriteriaInfo( AchievementID, Criteria );
		if ( CriteriaType == 0 ) then -- Mob kill type
			Achievement.Criteria[ CriteriaID ] = AssetID;
		end
	end
end


local Frame = NS.Frame;
Frame:SetScript( "OnEvent", Frame.OnEvent );
if ( IsLoggedIn() ) then
	Frame:PLAYER_LOGIN( "PLAYER_LOGIN" );
else
	Frame:RegisterEvent( "PLAYER_LOGIN" );
end
Frame:RegisterEvent( "PLAYER_ENTERING_WORLD" );
Frame:RegisterEvent( "PLAYER_LEAVING_WORLD" );
Frame:RegisterEvent( "PLAYER_UPDATE_RESTING" );

NS.Updater:CreateAnimation( "Animation" ):SetDuration( NS.Updater.UpdateRate );
NS.Updater:SetLooping( "REPEAT" );
-- Set update handler after zone info loads
if ( GetZoneText() == "" ) then -- Zone information unknown (initial login)
	Frame:RegisterEvent( "ZONE_CHANGED_NEW_AREA" );
else -- Zone information is known
	Frame:ZONE_CHANGED_NEW_AREA( "ZONE_CHANGED_NEW_AREA" );
end

SlashCmdList[ "_NPCSCAN" ] = NS.SlashCommand;