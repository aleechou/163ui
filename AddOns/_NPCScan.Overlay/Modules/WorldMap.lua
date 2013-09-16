--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Modules/WorldMap.lua - Canvas for the WorldMapFrame.                       *
  ****************************************************************************]]


local Overlay = select( 2, ... );
local L = Overlay.L;
local NS = Overlay.Modules.WorldMapTemplate.Embed( CreateFrame( "Frame", nil, WorldMapDetailFrame ) );

NS.KeyMinScale = 0.5; -- Minimum effective scale to render the key at
NS.KeyMaxSize = 1 / 3; -- If the key takes up more than this fraction of the canvas, hide it




do
	local Points = { "BOTTOMLEFT", "BOTTOMRIGHT", "TOPRIGHT" };
	local Point = 0;
	--- Moves the key to a different corner if it gets in the way of the mouse.
	function NS:KeyOnEnter ()
		self:ClearAllPoints();
		self:SetPoint( Points[ Point % #Points + 1 ] );
		Point = Point + 1;
	end
end
do
	local Count, Height, Width;
	--- Callback for ApplyZone to add an NPC's name to the key.
	local function KeyAddLine ( self, PathData, FoundX, FoundY, R, G, B, NpcID )
		Count = Count + 1;
		local Line = self[ Count ];
		if ( not Line ) then
			Line = self.Body:CreateFontString( nil, "OVERLAY", self.Font:GetName() );
			Line:SetPoint( "RIGHT", -5, 0 );
			if ( Count == 1 ) then
				Line:SetPoint( "TOPLEFT", 5, -5 );
			else
				Line:SetPoint( "TOPLEFT", self[ Count - 1 ], "BOTTOMLEFT" );
			end
			self[ Count ] = Line;
		else
			Line:Show();
		end

		Line:SetText( L.MODULE_WORLDMAP_KEY_FORMAT:format( NS.AchievementNPCNames[ NpcID ] or L.NPCs[ NpcID ] or NpcID ) );
		Line:SetTextColor( R, G, B );

		Width = max( Width, Line:GetStringWidth() );
		Height = Height + Line:GetStringHeight();
	end
	--- Fills the key in when repainting a zone.
	-- @param Map  AreaID to add names for.
	function NS:KeyPaint ( Map )
		Width, Height = 0, 0;
		Count = 0;

		Overlay.ApplyZone( self, Map, KeyAddLine );

		for Index = Count + 1, #self do
			self[ Index ]:Hide();
		end
		self:SetSize( Width + 32, Height + 32 );
		self:Show();
		if ( not self.Container:IsShown() ) then -- Previously too large; OnSizeChanged won't fire
			NS.KeyOnSizeChanged( self ); -- Force size validation
		end
	end
end
--- Hides the key if it covers too much of the canvas.
function NS:KeyValidateSize ()
	local WindowWidth, WindowHeight = self.KeyParent:GetSize();
	local Scale, Width, Height = self:GetScale(), self:GetSize();
	if ( Width * Scale > WindowWidth * NS.KeyMaxSize or Height * Scale > WindowHeight * NS.KeyMaxSize ) then
		self.Container:Hide(); -- KeyParent must remain visible so OnSizeChanged still fires
	else
		self.Container:Show();
	end
end
--- Clamps key scale and validates key size when the canvas resizes.
function NS:KeyParentOnSizeChanged ()
	self.Key:SetScale( max( 1, NS.KeyMinScale / self:GetEffectiveScale() ) );
	NS.KeyValidateSize( self.Key );
end
--- Validates key size when its contents change.
function NS:KeyOnSizeChanged ()
	NS.KeyValidateSize( self );
end

--- Centers the range ring around Target frame.
function NS.RangeRingSetTarget ( Target )
	NS.RangeRing.Target:SetParent( Target );
	NS.RangeRing.Child:ClearAllPoints();
	NS.RangeRing.Child:SetPoint( "CENTER", Target );
end
--- Shows the range ring when its target is shown.
function NS:RangeRingTargetOnShow ()
	NS.RangeRing.Child:Show();
end
--- Hides the range ring when its target is hidden.
function NS:RangeRingTargetOnHide ()
	NS.RangeRing.Child:Hide();
end
--- Shows and resizes the range ring when repainting a zone.
-- @param Map  AreaID to resize to.
function NS:RangeRingPaint ( Map )
	if ( Overlay.Options.ModulesExtra[ "WorldMap" ].RangeRing ) then
		local Size = ( Overlay.DetectionRadius * 2 ) / Overlay.GetMapSize( Map ) * NS:GetWidth();
		self.Child:SetSize( Size, Size );
		self:Show();
	end
end

--- Shows a *world map* tooltip similar to the quest objective toggle button.
function NS:ToggleOnEnter ()
	WorldMapTooltip:SetOwner( self, "ANCHOR_TOPLEFT" );
	WorldMapTooltip:SetText( L.MODULE_WORLDMAP_TOGGLE_DESC, nil, nil, nil, nil, 1 );
end
--- Hides the *world map* tooltip.
function NS:ToggleOnLeave ()
	WorldMapTooltip:Hide();
end
--- Toggles the module like a checkbox.
function NS:ToggleOnClick ()
	local Enable = self:GetChecked();
	PlaySound( Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff" );
	Overlay.Modules[ Enable and "Enable" or "Disable" ]( "WorldMap" );
end
--- Adjusts the toggle button's display when changing state.
function NS:ToggleSetChecked ()
	local Enable = self:GetChecked();
	self.Normal:SetDesaturated( not Enable );
	self.Border:SetDesaturated( not Enable );
	local Color;
	if ( Enable ) then
		self.Disabled:Hide();
		Color = NORMAL_FONT_COLOR;
	else
		self.Disabled:Show();
		Color = GRAY_FONT_COLOR;
	end
	self.Text:SetTextColor( Color.r, Color.g, Color.b );
end




--- @return True if Map has a visible path on it.
local function MapHasNPCs ( Map )
	local MapData = Overlay.PathData[ Map ];
	if ( MapData ) then
		if ( Overlay.Options.ShowAll ) then
			return true;
		end
		for NpcID in pairs( MapData ) do
			if ( Overlay.NPCCounts[ NpcID ] ) then
				return true;
			end
		end
	end
end
--- Updates the key when repainting the zone.
function NS:Paint ( Map, ... )
	if ( MapHasNPCs( Map ) ) then
		self.KeyPaint( self.KeyParent.Key, Map );
		self.RangeRingPaint( self.RangeRing, Map );
	else
		self.KeyParent.Key:Hide();
		self.RangeRing:Hide();
	end
	return self.super.Paint( self, Map, ... );
end

function NS:OnEnable ( ... )
	self.Toggle:SetChecked( true );
	self.KeyParent:Show();
	return self.super.OnEnable( self, ... );
end
function NS:OnDisable ( ... )
	self.Toggle:SetChecked( false );
	self.KeyParent:Hide();
	self.RangeRing:Hide();
	return self.super.OnDisable( self, ... );
end
--- Adds a custom key frame to the world map template.
function NS:OnLoad ( ... )
	-- Add key frame to map
	local KeyParent = CreateFrame( "Frame", nil, WorldMapButton );
	self.KeyParent = KeyParent;
	KeyParent:Hide();
	KeyParent:SetAllPoints();
	KeyParent:SetScript( "OnSizeChanged", NS.KeyParentOnSizeChanged );

	local KeyContainer = CreateFrame( "Frame", nil, KeyParent );
	KeyContainer:SetAllPoints();

	local Key = CreateFrame( "Frame", nil, KeyContainer );
	KeyParent.Key = Key;
	Key.KeyParent, Key.Container = KeyParent, KeyContainer;
	Key:SetScript( "OnEnter", self.KeyOnEnter );
	Key:SetScript( "OnSizeChanged", NS.KeyOnSizeChanged );
	self.KeyOnEnter( Key ); -- Initialize starting point
	Key:EnableMouse( true );
	Key:SetBackdrop( { edgeFile = [[Interface\AchievementFrame\UI-Achievement-WoodBorder]]; edgeSize = 48; } );

	Key.Font = CreateFont( "_NPCScanOverlayWorldMapKeyFont" );
	Key.Font:SetFontObject( ChatFontNormal );
	Key.Font:SetJustifyH( "LEFT" );

	Key.Body = CreateFrame( "Frame", nil, Key );
	Key.Body:SetPoint( "BOTTOMLEFT", 10, 10 );
	Key.Body:SetPoint( "TOPRIGHT", -10, -10 );
	Key.Body:SetBackdrop( { edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]]; edgeSize = 16; } );
	Key.Body:SetBackdropBorderColor( 0.8, 0.4, 0.2 ); -- Light brown
	local Background = Key.Body:CreateTexture( nil, "BACKGROUND" );
	Background:SetPoint( "TOPLEFT", 3, -3 );
	Background:SetPoint( "BOTTOMRIGHT", -3, 3 );
	Background:SetTexture( [[Interface\AchievementFrame\UI-Achievement-AchievementBackground]] );
	Background:SetTexCoord( 0, 1, 0.5, 1 );
	Background:SetVertexColor( 0.8, 0.8, 0.8 );


	-- Add range ring
	local RangeRing = CreateFrame( "ScrollFrame", nil, WorldMapDetailFrame );
	self.RangeRing = RangeRing;
	RangeRing:Hide();
	RangeRing:SetAllPoints();
	RangeRing:SetAlpha( 0.8 );

	local RangeRingTarget = CreateFrame( "Frame" );
	RangeRing.Target = RangeRingTarget;
	RangeRingTarget:SetScript( "OnShow", NS.RangeRingTargetOnShow );
	RangeRingTarget:SetScript( "OnHide", NS.RangeRingTargetOnHide );

	local RangeRingChild = CreateFrame( "Frame", nil, RangeRing );
	RangeRing.Child = RangeRingChild;
	RangeRing:SetScrollChild( RangeRingChild );

	local Color = NORMAL_FONT_COLOR;
	local Texture = RangeRingChild:CreateTexture();
	Texture:SetAllPoints();
	Texture:SetTexture( [[Interface\BUTTONS\IconBorder-GlowRing]] );
	Texture:SetBlendMode( "ADD" );
	Texture:SetVertexColor( Color.r, Color.g, Color.b );

	NS.RangeRingSetTarget( PlayerArrowEffectFrame );


	-- Add toggle button
	local Toggle = CreateFrame( "CheckButton", nil, WorldMapButton );
	self.Toggle = Toggle;
	Toggle:SetPoint( "TOPLEFT" );
	hooksecurefunc( Toggle, "SetChecked", NS.ToggleSetChecked );
	Toggle:SetScript( "OnClick", NS.ToggleOnClick );
	Toggle:SetScript( "OnEnter", NS.ToggleOnEnter );
	Toggle:SetScript( "OnLeave", NS.ToggleOnLeave );
	local Normal = Toggle:CreateTexture();
	Toggle.Normal = Normal;
	Normal:SetTexture( [[Interface\AchievementFrame\UI-Achievement-Category-Background]] );
	Normal:SetTexCoord( 0, 0.65, 0.12, 0.75 );
	Normal:SetAllPoints();
	Toggle:SetNormalTexture( Normal );
	local Highlight = Toggle:CreateTexture( nil, "HIGHLIGHT" );
	Highlight:SetTexture( [[Interface\AchievementFrame\UI-Achievement-Category-Highlight]] );
	Highlight:SetTexCoord( 0, 0.65, 0.12, 0.75 );
	Highlight:SetAllPoints();
	Toggle:SetHighlightTexture( Highlight );
	local Text = Toggle:CreateFontString( nil, "OVERLAY", "GameFontHighlightLarge" );
	Toggle.Text = Text;
	Toggle:SetFontString( Text );
	local DisabledPadding = 8; -- Room to leave left of text for disabled "X"
	Text:ClearAllPoints()
	Text:SetPoint( "TOPRIGHT" );
	Text:SetPoint( "BOTTOMLEFT", DisabledPadding, 0 )
	Text:SetText( L.MODULE_WORLDMAP_TOGGLE );
	local Width, Height = Text:GetStringWidth() + 16 + DisabledPadding, Text:GetStringHeight() + 16;
	Toggle:SetSize( Width, Height );
	local Border = Toggle:CreateTexture( nil, "BACKGROUND" );
	Toggle.Border = Border;
	Border:SetPoint( "TOPLEFT" );
	Border:SetPoint( "BOTTOMRIGHT", 32, -32 );
	Border:SetTexture( [[Interface\AchievementFrame\UI-Achievement-Alert-Background]] );
	-- Keep bottom-right corner of border texture aligned with bottom-right of button
	Border:SetTexCoord( ( 325 - ( Width + 32 ) ) / 512, 325 / 512,
		( 97 - ( Height + 32 ) ) / 128, 97 / 128 );
	local Disabled = Toggle:CreateTexture( nil, "OVERLAY" );
	Toggle.Disabled = Disabled;
	Disabled:SetPoint( "LEFT", -2, 0 );
	local Size = Toggle:GetHeight() * 0.8;
	Disabled:SetSize( Size, Size );
	Disabled:SetTexture( [[Interface\RaidFrame\ReadyCheck-NotReady]] );
	Disabled:SetAlpha( 0.75 );
	Toggle:SetChecked( false ); -- Initialize button display


	-- Cache achievement NPC names
	self.AchievementNPCNames = {};
	for AchievementID in pairs( Overlay.Achievements ) do
		for Criteria = 1, GetAchievementNumCriteria( AchievementID ) do
			local Name, CriteriaType, _, _, _, _, _, AssetID = GetAchievementCriteriaInfo( AchievementID, Criteria );
			if ( CriteriaType == 0 ) then -- Mob kill type
				self.AchievementNPCNames[ AssetID ] = Name;
			end
		end
	end

	return self.super.OnLoad( self, ... );
end
function NS:OnUnload ( ... )
	self.Toggle:Hide();
	self.Toggle.SetChecked = nil;
	self.Toggle:SetScript( "OnClick", nil );
	self.KeyParent:SetScript( "OnSizeChanged", nil );
	self.KeyParent.Key:SetScript( "OnEnter", nil );
	self.KeyParent.Key:SetScript( "OnSizeChanged", nil );
	self.RangeRing.Target:SetScript( "OnShow", nil );
	self.RangeRing.Target:SetScript( "OnHide", nil );

	return self.super.OnUnload( self, ... );
end




--- Enables the WorldMap range ring.
-- @return True if changed.
function NS.RangeRingSetEnabled ( Enable )
	if ( Enable ~= Overlay.Options.ModulesExtra[ "WorldMap" ].RangeRing ) then
		Overlay.Options.ModulesExtra[ "WorldMap" ].RangeRing = Enable;

		NS.Config.RangeRing:SetChecked( Enable );

		if ( NS.Loaded ) then
			if ( Enable ) then
				NS:OnMapUpdate();
			else
				NS.RangeRing:Hide();
			end
		end
		return true;
	end
end
--- Synchronizes custom settings to options table.
function NS:OnSynchronize ( OptionsExtra )
	self.RangeRingSetEnabled( OptionsExtra.RangeRing ~= false );
end




Overlay.Modules.Register( "WorldMap", NS, L.MODULE_WORLDMAP );

local Config = NS.Config;
local Checkbox = CreateFrame( "CheckButton", "$parentRangeRing", Config, "InterfaceOptionsCheckButtonTemplate" );
Config.RangeRing = Checkbox;
--- Toggles the range ring when clicked.
function Checkbox.setFunc ( Enable )
	NS.RangeRingSetEnabled( Enable == "1" );
end

Checkbox:SetPoint( "TOPLEFT", Config.Enabled, "BOTTOMLEFT" );
local Label = _G[ Checkbox:GetName().."Text" ];
Label:SetPoint( "RIGHT", Config, "RIGHT", -6, 0 );
Label:SetJustifyH( "LEFT" );
Label:SetFormattedText( Overlay.L.MODULE_RANGERING_FORMAT, Overlay.DetectionRadius );
Checkbox:SetHitRectInsets( 4, 4 - Label:GetStringWidth(), 4, 4 );
Checkbox.SetEnabled = Overlay.Config.ModuleCheckboxSetEnabled;
Checkbox.tooltipText = Overlay.L.MODULE_RANGERING_DESC;
Config:AddControl( Checkbox );

Config:SetHeight( Config:GetHeight() + Checkbox:GetHeight() );