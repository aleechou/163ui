--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * _NPCScan.Overlay.lua - Adds mob patrol paths to your map.                  *
  ****************************************************************************]]


_NPCScan = _NPCScan or {};
local _NPCScan = _NPCScan;
local FOLDER_NAME, private = ...
local L = private.L
_G._NPCScan.Overlay = private

--local MiniMapIcon = LibStub("LibDBIcon-1.0")
_NPCScanMiniMapIcon = {}

private.Version = GetAddOnMetadata( FOLDER_NAME, "Version" ):match( "^([%d.]+)" );

private.Options = {
	Version = private.Version,
	Modules = {},
	ModulesAlpha = {},
	ModulesExtra = {},
	MiniMapIcon = {},
};

private.OptionsDefault = {
	Version = private.Version,
	Modules = {},
	ModulesAlpha = {},
	ModulesExtra = {},
	MiniMapIcon = {},
	ShowAll = false,
	ShowKey = true,
};

private.TextureTable = {};
private.CurrentTexture = nil;
private.CurrentTextureMob = nil;

private.NPCsEnabled = {};
private.NPCCounts = {}; -- Number of enabled NPCs that use this NPC path
private.NPCMaps = {}; -- [ NpcID ] = { [ MapID1 ] = (true|{FoundX,FoundY}); ... };
private.NPCsFoundIgnored = {
	[ 32487 ] = true; -- Putridus the Ancient
	[ 50009 ] = true; -- Mobus
};
private.NPCAliases = { -- (Key) NPC shows (Value) NPC's path instead
	-- Note: Circular references will lock client!
	-- Madexx (Brown)
	[ 51401 ] = 50154; -- Madexx (Red)
	[ 51402 ] = 50154; -- Madexx (Green)
	[ 51403 ] = 50154; -- Madexx (Black)
	[ 51404 ] = 50154; -- Madexx (Blue)
};
private.Achievements = { -- Achievements whos criteria mobs are all mapped
		[ 1312 ] = true; -- Bloody Rare (Outlands)
		[ 2257 ] = true; -- Frostbitten (Northrend)
		[ 7317 ] = true; -- One Of Many
		[ 7439 ] = true; -- Glorious! (Pandaria)
		[ 8103 ] = true; -- Champions of Lei Shen
		[ 8714 ] = true;  --Timeless Champion
};

--Color's used for the paths.  Need to revisit to replace the duplicated colors if possible
private.Colors = {
	RAID_CLASS_COLORS.SHAMAN,
	RAID_CLASS_COLORS.DEATHKNIGHT,
	GREEN_FONT_COLOR,
	RAID_CLASS_COLORS.DRUID,
	RAID_CLASS_COLORS.PALADIN,
	UnitPopupButtons.RAID_TARGET_1.color,
	UnitPopupButtons.RAID_TARGET_5.color,
	UnitPopupButtons.RAID_TARGET_6.color,
	UnitPopupButtons.RAID_TARGET_3.color,
	RAID_CLASS_COLORS.MONK,
	RAID_CLASS_COLORS.HUNTER,

	RAID_CLASS_COLORS.SHAMAN,
	RAID_CLASS_COLORS.DEATHKNIGHT,
	GREEN_FONT_COLOR,
	RAID_CLASS_COLORS.DRUID,
	RAID_CLASS_COLORS.PALADIN,
	UnitPopupButtons.RAID_TARGET_1.color,
	UnitPopupButtons.RAID_TARGET_5.color,
	UnitPopupButtons.RAID_TARGET_6.color,
	UnitPopupButtons.RAID_TARGET_3.color,
	RAID_CLASS_COLORS.MONK,
	RAID_CLASS_COLORS.HUNTER,

	RAID_CLASS_COLORS.SHAMAN,
	RAID_CLASS_COLORS.DEATHKNIGHT,
	GREEN_FONT_COLOR,
	RAID_CLASS_COLORS.DRUID,
	RAID_CLASS_COLORS.PALADIN,
	UnitPopupButtons.RAID_TARGET_1.color,
	UnitPopupButtons.RAID_TARGET_5.color,
	UnitPopupButtons.RAID_TARGET_6.color,
	UnitPopupButtons.RAID_TARGET_3.color,
	RAID_CLASS_COLORS.MONK,
	RAID_CLASS_COLORS.HUNTER,
};

_NPCScanOverlayKeyColors = private.Colors


private.DetectionRadius = 100; -- yards

local TexturesUnused = CreateFrame( "Frame" );

private.Events = LibStub( "AceEvent-3.0" ):Embed( {} );
local MESSAGE_REGISTER = "NpcOverlay_RegisterScanner";
local MESSAGE_ADD = "NpcOverlay_Add";
local MESSAGE_REMOVE = "NpcOverlay_Remove";
local MESSAGE_FOUND = "NpcOverlay_Found";




--- Prepares an unused texture on the given frame.
-- @param Layer  Draw layer for texture.
-- @param ...  Color and optional alpha to set texture to.
local TextureCount = 0;
function private:TextureCreate ( Layer, R, G, B, A )
	TextureCount = TextureCount + 1;
	local Texture = #TexturesUnused > 0 and TexturesUnused[ #TexturesUnused ];
	if ( Texture ) then
		TexturesUnused[ #TexturesUnused ] = nil;
		Texture:SetParent( self );
		Texture:SetDrawLayer( Layer );
		Texture:ClearAllPoints();
		Texture:Show();
	else
		Texture = self:CreateTexture( "ScannerOverlayMobTexture"..TextureCount, Layer );
	end
	Texture:SetVertexColor( R, G, B, A or 1 );
	Texture:SetBlendMode( "BLEND" );

	self[ #self + 1 ] = Texture;
	return Texture;
end
do
	local ApplyTransform;
	do
		local Det, AF, BF, CD, CE;
		local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy;
		--- Applies an affine transformation to Texture.
		-- @param Texture  Texture to set TexCoords for.
		-- @param ...  First 6 elements of transformation matrix.
		function ApplyTransform( Texture, A, B, C, D, E, F )
			Det = A * E - B * D;
			if ( Det == 0 ) then
				return Texture:Hide(); -- Scaled infinitely small
			end
			AF, BF, CD, CE = A * F, B * F, C * D, C * E;

			ULx, ULy = ( BF - CE ) / Det, ( CD - AF ) / Det;
			LLx, LLy = ( BF - CE - B ) / Det, ( CD - AF + A ) / Det;
			URx, URy = ( BF - CE + E ) / Det, ( CD - AF - D ) / Det;
			LRx, LRy = ( BF - CE + E - B ) / Det, ( CD - AF - D + A ) / Det;

			-- Bounds to prevent "TexCoord out of range" errors
			if ( ULx < -1e4 ) then ULx = -1e4; elseif ( ULx > 1e4 ) then ULx = 1e4; end
			if ( ULy < -1e4 ) then ULy = -1e4; elseif ( ULy > 1e4 ) then ULy = 1e4; end
			if ( LLx < -1e4 ) then LLx = -1e4; elseif ( LLx > 1e4 ) then LLx = 1e4; end
			if ( LLy < -1e4 ) then LLy = -1e4; elseif ( LLy > 1e4 ) then LLy = 1e4; end
			if ( URx < -1e4 ) then URx = -1e4; elseif ( URx > 1e4 ) then URx = 1e4; end
			if ( URy < -1e4 ) then URy = -1e4; elseif ( URy > 1e4 ) then URy = 1e4; end
			if ( LRx < -1e4 ) then LRx = -1e4; elseif ( LRx > 1e4 ) then LRx = 1e4; end
			if ( LRy < -1e4 ) then LRy = -1e4; elseif ( LRy > 1e4 ) then LRy = 1e4; end

			return Texture:SetTexCoord( ULx, ULy, LLx, LLy, URx, URy, LRx, LRy );
		end
	end
	local min, max = min, max;
	local MinX, MinY, WindowX, WindowY;
	local ABx, ABy, BCx, BCy;
	local ScaleX, ScaleY, ShearFactor, Sin, Cos;
	local Parent, Width, Height;
	local SinScaleX, SinScaleY, CosScaleX, CosScaleY;
	local BorderScale, BorderOffset = 512 / 510, -1 / 512; -- Removes one-pixel transparent border
	local TrianglePath = [[Interface\AddOns\]]..FOLDER_NAME..[[\Skin\Triangle]]
	--- Draw a triangle texture with vertices at relative coords.  (0,0) is top-left, (1,1) is bottom-right.
	function private:TextureAdd ( Layer, R, G, B, Ax, Ay, Bx, By, Cx, Cy )
		ABx, ABy, BCx, BCy = Ax - Bx, Ay - By, Bx - Cx, By - Cy;
		ScaleX = ( BCx * BCx + BCy * BCy ) ^ 0.5;
		if ( ScaleX == 0 ) then
			return; -- Points B and C are the same
		end
		ScaleY = ( ABx * BCy - ABy * BCx ) / ScaleX;
		if ( ScaleY == 0 ) then
			return; -- Points are co-linear
		end
		ShearFactor = -( ABx * BCx + ABy * BCy ) / ( ScaleX * ScaleX );
		Sin, Cos = BCy / ScaleX, -BCx / ScaleX;

		-- Note: The texture region is made as small as possible to improve framerates.
		MinX, MinY = min( Ax, Bx, Cx ), min( Ay, By, Cy );
		WindowX, WindowY = max( Ax, Bx, Cx ) - MinX, max( Ay, By, Cy ) - MinY;


		-- Get a texture
		local Texture = private.TextureCreate( self, Layer, R, G, B );
		Texture:SetTexture( TrianglePath );
		Width, Height = self:GetSize();
		Texture:SetPoint( "TOPLEFT", MinX * Width, -MinY * Height );
		Texture:SetSize( WindowX * Width, WindowY * Height );


		--[[ Transform parallelogram so its corners lie on the tri's points:
		local Matrix = Identity;
		-- Remove transparent border
		Matrix = Matrix:Scale( BorderScale, BorderScale );
		Matrix = Matrix:Translate( BorderOffset, BorderOffset );

		Matrix = Matrix:Shear( ShearFactor ); -- Shear the image so its bottom left corner aligns with point A
		Matrix = Matrix:Scale( ScaleX, ScaleY ); -- Scale X by the length of line BC, and Y by the length of the perpendicular line from BC to point A
		Matrix = Matrix:Rotate( Sin, Cos ); -- Align the top of the triangle with line BC.

		Matrix = Matrix:Translate( Bx - MinX, By - MinY ); -- Move origin to overlap point B
		Matrix = Matrix:Scale( 1 / WindowX, 1 / WindowY ); -- Adjust for change in texture size

		ApplyTransform( unpack( Matrix, 1, 6 ) );
		]]

		-- Common operations
		WindowX, WindowY = BorderScale / WindowX, BorderScale / WindowY;
		SinScaleX, SinScaleY = -Sin * ScaleX, Sin * ScaleY;
		CosScaleX, CosScaleY =  Cos * ScaleX, Cos * ScaleY;

		 ApplyTransform( Texture,
			WindowX * CosScaleX,
			WindowX * ( SinScaleY + CosScaleX * ShearFactor ),
			WindowX * ( ( SinScaleY + CosScaleX * ( 1 + ShearFactor ) ) * BorderOffset + Bx - MinX ) / BorderScale,
			WindowY * SinScaleX,
			WindowY * ( CosScaleY + SinScaleX * ShearFactor ),
			WindowY * ( ( CosScaleY + SinScaleX * ( 1 + ShearFactor ) ) * BorderOffset + By - MinY ) / BorderScale );
		
		return Texture;
	end
end
--- Recycles all textures added to a frame using TextureCreate.
function private:TextureRemoveAll ()
	for Index = #self, 1, -1 do
		local Texture = self[ Index ];
		self[ Index ] = nil;
		Texture:Hide();
		Texture:SetParent( TexturesUnused );
		TexturesUnused[ #TexturesUnused + 1 ] = Texture;
	end
end


do
	local DWORD_LENGTH = 4;
	--- @return DWORD read from binary Data at Offset.
	local function ReadDWord ( Data, Offset )
		local B1, B2, B3, B4 = Data:byte( Offset + 1, Offset + DWORD_LENGTH );
		return B1 * 2 ^ 24 + B2 * 2 ^ 16 + B3 * 2 ^ 8 + B4; -- Big-endian
	end
	--- @return Offset of points, lines, and triangles within PathData.
	function private.GetPathPrimitiveOffsets ( PathData )
		return ReadDWord( PathData, 0 ) + 1, -- Points
			ReadDWord( PathData, DWORD_LENGTH ) + 1, -- Lines
			ReadDWord( PathData, DWORD_LENGTH * 2 ) + 1; -- Triangles
	end
end
do
	local COORD_MAX = 2 ^ 16 - 1;
	local BYTES_PER_TRIANGLE = 2 * 2 * 3;
	local Ax1, Ax2, Ay1, Ay2, Bx1, Bx2, By1, By2, Cx1, Cx2, Cy1, Cy2;
	--- Draws the given NPC's path onto a frame.
	-- @param PathData  Binary path data string.
	function private:DrawPath ( PathData, Layer, R, G, B )
		local PointsOffset, LinesOffset, TrianglesOffset = private.GetPathPrimitiveOffsets( PathData );
		for Index = TrianglesOffset, #PathData, BYTES_PER_TRIANGLE do
			Ax1, Ax2, Ay1, Ay2, Bx1, Bx2, By1, By2, Cx1, Cx2, Cy1, Cy2 = PathData:byte( Index, Index + BYTES_PER_TRIANGLE - 1 );
			local Texture = private.TextureAdd( self, Layer, R, G, B,
				( Ax1 * 256 + Ax2 ) / COORD_MAX, 1 - ( Ay1 * 256 + Ay2 ) / COORD_MAX,
				( Bx1 * 256 + Bx2 ) / COORD_MAX, 1 - ( By1 * 256 + By2 ) / COORD_MAX,
				( Cx1 * 256 + Cx2 ) / COORD_MAX, 1 - ( Cy1 * 256 + Cy2 ) / COORD_MAX );

				local Name = Texture:GetName()
				if (private.TextureTable[private.CurrentTextureMob]) then

				private.TextureTable[private.CurrentTextureMob][Name] = true;

				else private.TextureTable[private.CurrentTextureMob] = {[Name] = true}; end
		end
	end
end
do
	local RingWidth = 1.14; -- Ratio of texture width to ring width
	local GlowWidth = 1.25;
	local FoundCount = 0;
	local FoundCountMax = 3
	local FoundTextures = {};
	--- Adds a found NPC's range circle onto a frame.
	-- @param X..Y  Relative coordinate to center circle on.  (0,0) is top-left, (1,1) is bottom-right.
	-- @param RadiusX  Radius relative to the frame's width.  That is, 0.5 for a circle as wide as the frame.
	function private:DrawFound ( X, Y, RadiusX, Layer, R, G, B )
		local Width, Height = self:GetSize();
		FoundCount = FoundCount + 1;
		if FoundCount > FoundCountMax then
			FoundCount = 1;
		end

		local OldTexture = FoundTextures[FoundCount]
		if OldTexture then
			OldTexture[1]:Hide()
			OldTexture[2]:Hide()
		end


		X, Y = X * Width, -Y * Height;
		local Size = RadiusX * 2 * Width;

		local Texture = private.TextureCreate( self, Layer, R, G, B );
		Texture:SetTexture( [[Interface\Minimap\Ping\ping2]] );
		Texture:SetTexCoord( 0, 1, 0, 1 );
		Texture:SetBlendMode( "ADD" );
		Texture:SetPoint( "CENTER", self, "TOPLEFT", X, Y );
		Texture:SetSize( Size * RingWidth, Size * RingWidth );
		local FoundRing = Texture

		Texture = private.TextureCreate( self, Layer, R, G, B, 0.5 );
		Texture:SetTexture( [[Textures\SunCenter]] );
		Texture:SetTexCoord( 0, 1, 0, 1 );
		Texture:SetBlendMode( "ADD" );
		Texture:SetPoint( "CENTER", self, "TOPLEFT", X, Y );
		Texture:SetSize( Size * GlowWidth, Size * GlowWidth );
		local FoundGlow = Texture
		FoundTextures[FoundCount] = {[1] = FoundRing, [2]= FoundGlow};

	end
end

-- Cache achievement NPC names
local AchievementNPCNames = {};
for AchievementID in pairs( private.Achievements ) do
	for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
		local Name, CriteriaType, _, _, _, _, _, AssetID = GetAchievementCriteriaInfo( AchievementID, Criteria );
		if ( CriteriaType == 0 ) then -- Mob kill type
			AchievementNPCNames[ AssetID ] = Name;
		end
	end
end

-- Passes info for all enabled NPCs in a zone to a callback function.
-- @param Callback  Function( self, PathData, [FoundX], [FoundY], R, G, B, NpcID )
function private:ApplyZone ( Map, Callback )
	local MapData = private.PathData[ Map ];

	if (MapData) then
		local ColorIndex = 0;
		local AlphaList = {} --List of mob names to sort
		local NPCList = {} --Index of Mob Name to MobIDs

	--Sorts Mobs in current zone by name
		for MobID, pathx in pairs(MapData) do
			local MobName = AchievementNPCNames[MobID] or L.NPCs[tostring(MobID)] or MobID
			NPCList[MobName] = MobID
			table.insert(AlphaList, MobName)
			table.sort(AlphaList)
		end

		for _, NpcName in pairs(AlphaList) do
			local NpcID, PathData = NPCList[NpcName], MapData[NPCList[NpcName]]
			ColorIndex = ColorIndex + 1;
			if ( private.Options.ShowAll or private.NPCCounts[ NpcID ] ) then
				local Color = assert( _NPCScanOverlayKeyColors[ ColorIndex ], "Ran out of unique path colors." );
				local Found, FoundX, FoundY = private.NPCMaps[ NpcID ][ Map ];
				if ( type( Found ) == "table" ) then
					FoundX, FoundY = unpack( Found );
				end
				Callback( self, PathData, FoundX, FoundY, Color.r, Color.g, Color.b, NpcID );
			end
		end
	end
end

--- @return Aliased NPC ID, or original if not aliased.
local function GetRealNpcID ( NpcID )
	local AliasID = private.NPCAliases[ NpcID ];
	while ( AliasID ) do
		NpcID, AliasID = AliasID, private.NPCAliases[ AliasID ];
	end
	return NpcID;
end
--- @return First Map ID that NpcID can be found on or nil if unknown.
function private.GetNPCMapID ( NpcID )
	local Maps = private.NPCMaps[ GetRealNpcID( NpcID ) ];
	if ( Maps ) then
		return ( next( Maps ) );
	end
end

--- Enables an NPC map overlay by NpcID.
local function NPCAdd ( NpcID )
	local AliasID, NpcID = NpcID, GetRealNpcID( NpcID );
	if ( not private.NPCsEnabled[ AliasID ] and private.NPCMaps[ NpcID ] ) then
		private.NPCsEnabled[ AliasID ] = true;

		private.NPCCounts[ NpcID ] = ( private.NPCCounts[ NpcID ] or 0 ) + 1;
		if ( private.NPCCounts[ NpcID ] == 1 and not private.Options.ShowAll ) then
			for Map in pairs( private.NPCMaps[ NpcID ] ) do
				private.Modules.UpdateMap( Map );
			end
		end
	end
end
--- Disables an NPC map overlay by NpcID.
local function NPCRemove ( NpcID )
	if ( private.NPCsEnabled[ NpcID ] ) then
		private.NPCsEnabled[ NpcID ] = nil;

		NpcID = GetRealNpcID( NpcID );
		local Count = assert( private.NPCCounts[ NpcID ], "Enabled NPC wasn't active." );
		private.NPCCounts[ NpcID ] = Count > 1 and Count - 1 or nil;

		if ( not ( Count > 1 or private.Options.ShowAll ) ) then
			for Map in pairs( private.NPCMaps[ NpcID ] ) do
				private.Modules.UpdateMap( Map );
			end
		end
	end
end
local NPCFound;
do
	--- Saves the position of NpcID on Map and updates displays.
	local function SaveFound ( NpcID, Map, X, Y )
		local Found = private.NPCMaps[ NpcID ][ Map ];
		if ( type( Found ) ~= "table" ) then
			Found = {};
			private.NPCMaps[ NpcID ][ Map ] = Found;
		end
		Found[ 1 ], Found[ 2 ] = X, Y;
		if ( private.Options.ShowAll or private.NPCCounts[ NpcID ] ) then
			private.Modules.UpdateMap( Map );
		end
	end
	--- Saves an NPC's last seen position at the given position or the player.
	function NPCFound ( NpcID, Map, X, Y )
		NpcID = GetRealNpcID( NpcID );
		if ( not private.NPCMaps[ NpcID ] or private.NPCsFoundIgnored[ NpcID ] ) then
			return;
		end
		if ( Map and X and Y ) then
			if ( private.NPCMaps[ NpcID ][ Map ] ) then
				SaveFound( NpcID, Map, X, Y );
				local MapOld = GetCurrentMapAreaID();
				SetMapByID( Map );
				local X, Y = GetPlayerMapPosition( "player" );
				if ( X == 0 and Y == 0 ) then -- Player isn't on the same map
					SetMapByID( MapOld ); -- Undo map change if mob isn't nearby
				end
			end
		else
			local MapOld, MapNew = GetCurrentMapAreaID(), nil;
			SetMapToCurrentZone();
			local MapCurrent = GetCurrentMapAreaID();
			for Map in pairs( private.NPCMaps[ NpcID ] ) do
				SetMapByID( Map );
				local X, Y = GetPlayerMapPosition( "player" );
				if ( X ~= 0 or Y ~= 0 ) then -- Found on this map
					SaveFound( NpcID, Map, X, Y );
					if ( not MapNew or Map == MapCurrent ) then -- Current map has priority if found there
						MapNew = Map; -- Force map to view found rare
					end
				end
			end
			SetMapByID( MapNew or MapOld );
		end
	end
end


do
	-- See <http://sites.google.com/site/wowsaiket/Add-Ons/NPCScanOverlay/API>
	-- for Overlay message documentation.
	local ScannerAddOn;
	--- Grants exclusive control of mob path visibility to the first addon that registers.
	-- @param AddOn  Logically true identifier for the controller addon.  Must be
	--   used in all subsequent messages.
	private.Events[ MESSAGE_REGISTER ] = function ( self, Event, AddOn )
		self:UnregisterMessage( Event );
		self[ Event ] = nil;
		ScannerAddOn = assert( AddOn, "Registration message must provide an addon identifier." );

		-- Quit showing all by default and let the scanning addon control visibility
		for NpcID in pairs( private.NPCsEnabled ) do
			NPCRemove( NpcID );
		end

		self:RegisterMessage( MESSAGE_ADD );
		self:RegisterMessage( MESSAGE_REMOVE );
	end;
	--- Shows a mob's path, if available.
	-- @param NpcID  Numeric creature ID to add.
	-- @param AddOn  Identifier used in registration message.
	private.Events[ MESSAGE_ADD ] = function ( self, _, NpcID, AddOn )
		if ( ScannerAddOn and AddOn == ScannerAddOn ) then
			return NPCAdd( assert( tonumber( NpcID ),
				"Add message NpcID must be numeric." ) );
		end
	end;
	--- Removes a mob's path if it has already been shown.
	-- @param NpcID  Numeric creature ID to remove.
	-- @param AddOn  Identifier used in registration message.
	private.Events[ MESSAGE_REMOVE ] = function ( self, _, NpcID, AddOn )
		if ( ScannerAddOn and AddOn == ScannerAddOn ) then
			return NPCRemove( assert( tonumber( NpcID ),
				"Remove message NpcID must be numeric." ) );
		end
	end;
	--- Saves an NPC's last seen position at the given position or at the player.
	-- Will fail if the given or current zone doesn't have path data.
	-- @param NpcID  Numeric creature ID that was found.
	-- @param MapID  Optional numeric map ID that the NPC was found on.
	-- @param X..Y  Optional numeric coordinates of NPC on MapID.
	private.Events[ MESSAGE_FOUND ] = function ( self, _, NpcID, MapID, X, Y )
		return NPCFound( assert( tonumber( NpcID ), "Found message Npc ID must be a number." ),
			tonumber( MapID ), tonumber( X ), tonumber( Y ) );
	end;
end




--- Enables always showing all paths.
-- @return True if changed.
function private.SetShowAll ( Enable )
	Enable = not not Enable;
	if ( Enable ~= private.Options.ShowAll ) then
		private.Options.ShowAll = Enable;

		private.Config.ShowAll:SetChecked( Enable );

		-- Update all affected maps
		for Map, MapData in pairs( private.PathData ) do
			-- If a map has a disabled path, it must be redrawn
			for NpcID in pairs( MapData ) do
				if ( not private.NPCCounts[ NpcID ] ) then
					private.Modules.UpdateMap( Map );
					break;
				end
			end
		end

		return true;
	end
end


--- Reloads enabled modules from saved settings.
function private.Synchronize ( Options )
	-- Load defaults if settings omitted
	if ( not Options ) then
		Options = private.OptionsDefault;
	end
	_NPCScanOverlayOptions.ShowKey = Options.ShowKey 
	private.SetShowAll( Options.ShowAll );
	private.Modules.OnSynchronize( Options );

end
 
 --Creates LDB icon and click actgions
local LDB = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("_NPCScan.Overlay", {
	type = "launcher",
	text = "_NPCScan.Overlay",
	icon = "Interface\\Icons\\INV_Misc_EngGizmos_20",
	OnClick = function(_, button)
		if button == "LeftButton" then
			-- for LeftButton, toggle the module Enabled or Disabled
			if( IsShiftKeyDown() ) then
				NSO_KeyToggleOnClick()
			else
								-- if Control Key down, toggle stuff on Main World Map
				if ( private.Options.Modules[ "WorldMap" ] ) then
					private.Modules.Disable( "WorldMap" );
				else
					private.Modules.Enable( "WorldMap" );
				end
			end
		elseif button == "RightButton" then
							-- else toggle Stuff Mini Map
				if ( private.Options.Modules[ "Minimap" ] ) then
					private.Modules.Disable( "Minimap" );
				else
					private.Modules.Enable( "Minimap" );
				end
		elseif button == "MiddleButton" then
			if( IsShiftKeyDown() ) then
				InterfaceOptionsFrame_OpenToCategory( private.Config );
			else
				if ( private.Options.Modules[ "Minimap" ] ) then
					private.Modules.Disable( "Minimap" );
					private.Modules.Disable( "WorldMap" );
				else
					private.Modules.Enable( "Minimap" );
					private.Modules.Enable( "WorldMap" );
				end
			end
		end
	end,
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine(L.BUTTON_TOOLTIP_LINE1)
		tooltip:AddLine(L.BUTTON_TOOLTIP_LINE2)
		tooltip:AddLine(L.BUTTON_TOOLTIP_LINE3)
		tooltip:AddLine(L.BUTTON_TOOLTIP_LINE4)
		tooltip:AddLine(L.BUTTON_TOOLTIP_LINE5)
		tooltip:AddLine(L.BUTTON_TOOLTIP_LINE6)
	end,
})



do
	private.GetMapName = GetMapNameByID; -- For backwards compatibility with older versions of _NPCScan
	local MapIDs = {}; -- [ LocalizedZoneName ] = MapID;
	--- @return Map ID for localized zone name or nil if unknown.
	-- Note that only true continent sub-zones are supported.
	function private.GetMapID ( Name )
		return MapIDs[ Name ];
	end
	local MapWidths, MapHeights = {}, {};
	--- @return Width and height of Map in yards or nil if unavailable.
	function private.GetMapSize ( Map )
		return MapWidths[ Map ], MapHeights[ Map ];
	end

	--- Loads defaults, validates settings, and begins listening for Overlay API messages.
	function private.Events:ADDON_LOADED ( Event, AddOn )
		if ( AddOn == FOLDER_NAME ) then
			self[ Event ] = nil;
			self:UnregisterEvent( Event );

			-- Build a reverse lookup of NpcIDs to zones, and add them all by default
			for Map, MapData in pairs( private.PathData ) do
				SetMapByID( Map );
				local _, X1, Y1, X2, Y2 = GetCurrentMapZone();
				local Width, Height = X1 - X2, Y1 - Y2;
				if ( Width == 0 or Height == 0 ) then
					error( "Zone dimensions unavailable for map "..Map.."." );
				end
				MapWidths[ Map ], MapHeights[ Map ] = Width, Height;
				MapIDs[ GetMapNameByID( Map ) ] = Map;

				for NpcID in pairs( MapData ) do
					if ( not private.NPCMaps[ NpcID ] ) then
						private.NPCMaps[ NpcID ] = {};
					end
					private.NPCMaps[ NpcID ][ Map ] = true;
					NPCAdd( NpcID );
				end
			end

			local Options = _NPCScanOverlayOptions;
			_NPCScanOverlayOptions = private.Options;
			if ( Options and not Options.ModulesExtra ) then -- 3.3.5.1: Moved module options to options sub-tables
				Options.ModulesExtra = {};
			end

			private.Synchronize( Options ); -- Loads defaults if nil
			self:RegisterMessage( MESSAGE_REGISTER );
			self:RegisterMessage( MESSAGE_FOUND );
			--MiniMapIcon:Register("_NPCScan.Minimap", LDB, _NPCScanMiniMapIcon)
			
		end
	end
end



local FlashTable = {};

--Flashes selected Mob route
function private.FlashRoute(MobID)
	for ID, Mob in pairs(private.TextureTable) do
		 if MobID == ID then
			flashtable = nil;
			for text in pairs(Mob) do
				local flasher = _G[text]:CreateAnimationGroup()
				FlashTable[text] = flasher
				local fade1 = flasher:CreateAnimation("Alpha")
				fade1:SetDuration(0.25)
				fade1:SetChange(1)
				fade1:SetOrder(1)

				local fade2 = flasher:CreateAnimation("Alpha")
				fade2:SetDuration(0.25)
				fade2:SetChange(-1)
				fade2:SetOrder(2)

				flasher:SetLooping("BOUNCE")
				flasher:SetScript("OnFinished", function() _G[text]:SetAlpha(1) end)

				flasher:Play() 
			end
		end
	end
end

--Stops the Slected route from flashing
function private.FlashStop(MobID)
	for text, flash in pairs(FlashTable) do
		flash:Finish()
	end
end

private.Events:RegisterEvent( "ADDON_LOADED" );




--http://wowprogramming.com/BlizzArt/Interface/ICONS/Ability_Hunter_MasterMarksman.png
--http://wowprogramming.com/BlizzArt/Interface/ICONS/INV_Misc_EngGizmos_20.png