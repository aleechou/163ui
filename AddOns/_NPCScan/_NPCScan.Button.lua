--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Button.lua - Displays a button to target found NPCs.              *
  ****************************************************************************]]


local _NPCScan = select( 2, ... );
local NS = CreateFrame( "Button", "_NPCScanButton", UIParent, "SecureActionButtonTemplate,SecureHandlerShowHideTemplate" );
_NPCScan.Button = NS;

NS.Drag = NS:CreateTitleRegion();
NS.Model = CreateFrame( "PlayerModel", nil, NS );
NS.Flash = CreateFrame( "Frame" );
NS.Flash.LoopCountMax = 3;

NS.PendingName, NS.PendingID, NS.PendingSource = nil;

NS.RotationRate = math.pi / 4;
NS.RaidTargetIcon = 4; -- Green triangle

NS.ModelDefaultScale = 0.75;
--- [ Model:lower() ] = "[Scale]|[X]|[Y]|[Z]", where any parameter can be left empty
NS.ModelCameras = {
	[ [[creature\alliancelionmount\alliancelion.m2]] ] = ".7|.3|.5"; -- Sambas
	[ [[creature\armadillo\armadillo.m2]] ] = "2||-.3"; -- Armagedillo
	[ [[creature\dragon\northrenddragon.m2]] ] = ".5||3|20"; -- Hemathion, Vyragosa
	[ [[creature\mammoth\mammoth.m2]] ] = ".3|.5|2.1"; -- Tukemuth
	[ [[creature\uldumwatcher\uldumwatcherleft.m2]] ] = "|||16"; -- Akma'hat
	[ [[creature\whaleshark\whaleshark.m2]] ] = ".7|-.5"; -- Mobus
	[ [[creature\wight\wight.m2]] ] = ".7"; -- Griegen
};




--- Plays an alert sound, temporarily enabling sound if necessary.
-- @param AlertSound  A LibSharedMedia sound key, or nil to play the default.
function NS.PlaySound ( AlertSound )
	if ( _NPCScan.Options.AlertSoundUnmute ) then
		if ( not NS.SoundEnableAllChanged and not GetCVarBool( "Sound_EnableAllSound" ) ) then
			NS.SoundEnableAllChanged = true;
			SetCVar( "Sound_EnableAllSound", 1 ); -- Restored when alert is closed
		end
		if ( not NS.SoundEnableSFXChanged and not GetCVarBool( "Sound_EnableSFX" ) ) then
			NS.SoundEnableSFXChanged = true;
			SetCVar( "Sound_EnableSFX", 1 );
		end
		if ( not NS.SoundInBGChanged and not GetCVarBool( "Sound_EnableSoundWhenGameIsInBG" ) ) then
			NS.SoundInBGChanged = true;
			SetCVar( "Sound_EnableSoundWhenGameIsInBG", 1 );
		end
	end
	if ( AlertSound == nil ) then -- Default
		PlaySoundFile( [[Sound\Event Sounds\Event_wardrum_ogre.wav]], "Master" );
		PlaySoundFile( [[Sound\Events\scourge_horn.wav]], "Master" );
	else
		local LSM = LibStub( "LibSharedMedia-3.0" );
		PlaySoundFile( LSM:Fetch( LSM.MediaType.SOUND, AlertSound ), "Master" );
	end
end


--- Plays alerts and sets the targetting button if not in combat.
-- If in combat, queues the button to appear when combat ends.
-- @see NS:Update
function NS:SetNPC ( ID, Name, Source )
	if ( tonumber( ID ) ) then
		ID = tonumber( ID );
		_NPCScan.Overlays.Add( ID );
		_NPCScan.Overlays.Found( ID );
	end

	self.PlaySound( _NPCScan.Options.AlertSound );
	if ( GetCVarBool( "screenEdgeFlash" ) ) then
		self.Flash:Show();
		self.Flash.Fade:Pause(); -- Forces OnPlay to fire again if it was already playing
		self.Flash.Fade:Play();
	end

	if ( InCombatLockdown() ) then
		if ( type( self.PendingID ) == "number" ) then -- Remove old pending NPC
			_NPCScan.Overlays.Remove( self.PendingID );
		end
		self.PendingID, self.PendingName, self.PendingSource = ID, Name, Source;
	else
		self:Update( ID, Name, Source );
	end
end
--- Updates the button out of combat to target a given unit.
-- @param ID  A numeric NpcID or string UnitID.
-- @param Name  Localized name of the unit.  If ID is an NpcID, Name is used in the targetting macro.
-- @param Source  Name of the scan, custom or achievement, that set off this alert.
function NS:Update ( ID, Name, Source )
	if ( type( self.ID ) == "number" ) then -- Remove last overlay
		_NPCScan.Overlays.Remove( self.ID );
	end
	self.ID = ID;

	self:SetText( Name );
	if ( Source == Name ) then
		Source = nil;
	end
	self.Source:SetText( Source );
	local Model = self.Model;
	Model:Reset();
	if ( type( ID ) == "number" ) then -- ID is NPC ID
		Model.UnitID = nil;
		Model:SetCreature( ID );
		self:UnregisterEvent( "UNIT_MODEL_CHANGED" );
	else -- ID is UnitID
		Model.UnitID, Name = ID, ID;
		Model:SetUnit( ID );
		self:RegisterEvent( "UNIT_MODEL_CHANGED" );
	end
	self:SetAttribute( "macrotext", "/cleartarget\n/targetexact "..Name );
	self:PLAYER_TARGET_CHANGED(); -- Updates the target icon

	self:Show();
	self:StopAnimating();
	self.Glow:Play();
	self.Shine:Play();
end
--- Enables or disables dragging the button.
-- Not a secure function; Can be run in combat.
function NS:EnableDrag ( Enable )
	local Drag = self.Drag;
	Drag:ClearAllPoints();
	if ( Enable ) then
		Drag:SetAllPoints();
	else -- Position offscreen
		Drag:SetPoint( "TOP", UIParent, 0, math.huge );
	end
end


--- Starts dragging or waits for drag key when shown.
function NS:OnShow ()
	self:RegisterEvent( "MODIFIER_STATE_CHANGED" );
	self:RegisterEvent( "PLAYER_TARGET_CHANGED" );
	self:EnableDrag( IsModifiedClick( "_NPCSCAN_BUTTONDRAG" ) );
end
--- Stops listening for events when hidden.
function NS:OnHide ()
	self:UnregisterEvent( "MODIFIER_STATE_CHANGED" );
	self:UnregisterEvent( "PLAYER_TARGET_CHANGED" );
	self:UnregisterEvent( "UNIT_MODEL_CHANGED" );
	self:EnableDrag( false );

	if ( NS.SoundEnableAllChanged ) then
		NS.SoundEnableAllChanged = nil;
		SetCVar( "Sound_EnableAllSound", 0 );
	end
	if ( NS.SoundEnableSFXChanged ) then
		NS.SoundEnableSFXChanged = nil;
		SetCVar( "Sound_EnableSFX", 0 );
	end
	if ( NS.SoundInBGChanged ) then
		NS.SoundInBGChanged = nil;
		SetCVar( "Sound_EnableSoundWhenGameIsInBG", 0 );
	end
	if ( type( self.ID ) == "number" ) then -- Remove current overlay
		_NPCScan.Overlays.Remove( self.ID );
	end
end
--- Highlights the button's border when moused over.
function NS:OnEnter ()
	self:SetBackdropBorderColor( 1, 1, 0.15 ); -- Yellow
end
--- Removes border highlights when mousing out.
function NS:OnLeave ()
	self:SetBackdropBorderColor( 0.7, 0.15, 0.05 ); -- Brown
end


--- Shows the button queued by NS:SetNPC when combat ends.
function NS:PLAYER_REGEN_ENABLED ()
	-- Update button after leaving combat
	if ( self.PendingName and self.PendingID ) then
		self:Update( self.PendingID, self.PendingName, self.PendingSource );
		self.PendingID, self.PendingName, self.PendingSource = nil;
	end
end
--- Enables or disables dragging when the drag modifier is held.
function NS:MODIFIER_STATE_CHANGED ()
	self:EnableDrag( IsModifiedClick( "_NPCSCAN_BUTTONDRAG" ) );
end
do
	--- @param ID  A numeric NpcID or string UnitID.
	-- @return True if the given ID represents the current target.
	local function TargetIsFoundRare ( ID ) -- Returns true if the button targetted its rare
		if ( type( ID ) == "number" ) then
			local GUID = UnitGUID( "target" );
			if ( GUID and ID == tonumber( GUID:sub( 6, 10 ), 16 ) ) then
				return true;
			end
		else -- UnitID
			return UnitIsUnit( ID, "target" );
		end
	end
	--- Raid marks the rare when it's targetted.
	function NS:PLAYER_TARGET_CHANGED ()
		local ID = self.ID;
		if ( TargetIsFoundRare( ID ) ) then
			if ( GetRaidTargetIndex( "target" ) ~= self.RaidTargetIcon -- Wrong mark
				and ( not IsInRaid() or ( UnitIsGroupAssistant( "player" ) or UnitIsGroupLeader( "player" ) ) ) -- Player can mark
			) then
				SetRaidTarget( "target", self.RaidTargetIcon );
			end

			if ( type( ID ) == "number" ) then -- Update model with more accurate visual
				self.Model.UnitID = "target";
				self:RegisterEvent( "UNIT_MODEL_CHANGED" );
				self:UNIT_MODEL_CHANGED( nil, "target" );
			end
		elseif ( self.Model.UnitID and type( ID ) == "number" ) then -- Quit updating model for creature ID
			self.Model.UnitID = nil;
			self:UnregisterEvent( "UNIT_MODEL_CHANGED" );
		end
	end
end
--- Updates the 3D preview display if the targetted rare changes appearance.
function NS:UNIT_MODEL_CHANGED ( _, UnitID )
	if ( UnitIsUnit( UnitID, self.Model.UnitID ) ) then
		self.Model:Reset( true ); -- Don't reset rotation
		self.Model:SetUnit( UnitID );
	end
end


--- Stops the animation after a number of loops.
function NS.Flash:OnLoop ( Direction )
	if ( Direction == "FORWARD" ) then
		self.LoopCount = self.LoopCount + 1;
		local Flash = self:GetParent();
		if ( self.LoopCount >= Flash.LoopCountMax ) then
			self:Stop();
			Flash:Hide();
		end
	end
end
--- Resets the loop count when resumed/restarted.
function NS.Flash:OnPlay ()
	self.LoopCount = 0;
end


do
	--- Adjusts the model camera to compensate for bad default camera angles.
	local function AdjustModel ( self )
		local Path = self:GetModel();
		if ( type( Path ) == "string" ) then
			local ID = self:GetParent().ID;
			if ( type( ID ) == "number" or not UnitIsPlayer( ID ) ) then -- Creature
				local Scale, X, Y, Z = ( "|" ):split( NS.ModelCameras[ Path:lower() ] or "" );
				self:SetModelScale( NS.ModelDefaultScale * ( tonumber( Scale ) or 1 ) );
				self:SetPosition( tonumber( Z ) or 0, tonumber( X ) or 0, tonumber( Y ) or 0 );
			else -- Player
				self:SetModelScale( NS.ModelDefaultScale );
			end
		end
	end
	local FrameCount = 0;
	--- Fires when the 3D model mesh loads and is ready to display.
	local function OnUpdateModel ( self )
		FrameCount = FrameCount - 1;
		if ( FrameCount <= 0 ) then
			-- Restore normal rotation
			self:SetScript( "OnUpdateModel", nil );
			self:SetScript( "OnUpdate", self.OnUpdate );
			AdjustModel( self );
			self:SetAlpha( 1 );
		end
	end
	--- Clears the model and readies it for a SetCreature/Unit call.
	function NS.Model:Reset ( KeepFacing )
		self:SetAlpha( 0 ); -- Keep hidden until scaled properly
		self:SetScript( "OnUpdateModel", nil );
		self:SetModelScale( 1 );
		self:SetPosition( 0, 0, 0 );
		if ( not KeepFacing ) then
			self:SetFacing( 0 );
		end
		self:ClearModel();

		-- Wait a while after model changes, or else the current model scale will
		--   display as 100% with later calls scaling relative to it.
		FrameCount = 10; -- Voodoo!  Larger means less chance of scale bug.
		self:SetScript( "OnUpdate", nil );
		self:SetScript( "OnUpdateModel", OnUpdateModel );
	end
end
--- Slowly rotates the 3D model preview.
function NS.Model:OnUpdate ( Elapsed )
	self:SetFacing( self:GetFacing() + Elapsed * NS.RotationRate );
end




NS:SetScale( 1.25 );
NS:SetSize( 150, 42 );
NS:SetPoint( "BOTTOM", UIParent, 0, 128 );
NS:SetMovable( true );
NS:SetUserPlaced( true );
NS:SetClampedToScreen( true );
NS:SetFrameStrata( "FULLSCREEN_DIALOG" );
NS:SetNormalTexture( [[Interface\AchievementFrame\UI-Achievement-Parchment-Horizontal]] );
local Background = NS:GetNormalTexture();
Background:SetDrawLayer( "BACKGROUND" );
Background:ClearAllPoints();
Background:SetPoint( "BOTTOMLEFT", 3, 3 );
Background:SetPoint( "TOPRIGHT", -3, -3 );
Background:SetTexCoord( 0, 1, 0, 0.25 );

NS:SetAttribute( "_onshow", "self:Enable();" );
NS:SetAttribute( "_onhide", "self:Disable();" );
NS:Hide();

local TitleBackground = NS:CreateTexture( nil, "BORDER" );
TitleBackground:SetTexture( [[Interface\AchievementFrame\UI-Achievement-Title]] );
TitleBackground:SetPoint( "TOPRIGHT", -5, -5 );
TitleBackground:SetPoint( "LEFT", 5, 0 );
TitleBackground:SetHeight( 18 );
TitleBackground:SetTexCoord( 0, 0.9765625, 0, 0.3125 );
TitleBackground:SetAlpha( 0.8 );

local Title = NS:CreateFontString( nil, "OVERLAY", "GameFontHighlightMedium", 1 );
Title:SetPoint( "TOPLEFT", TitleBackground, 0, 2 );
Title:SetPoint( "RIGHT", TitleBackground );
NS:SetFontString( Title );

NS.Source = NS:CreateFontString( nil, "OVERLAY", "SystemFont_Tiny" );
NS.Source:SetPoint( "BOTTOMLEFT", TitleBackground );
NS.Source:SetPoint( "RIGHT", -8, 0 );
NS.Source:SetTextHeight( 6 );
local Color = NORMAL_FONT_COLOR;
NS.Source:SetTextColor( Color.r, Color.g, Color.b );

local SubTitle = NS:CreateFontString( nil, "OVERLAY", "GameFontBlackTiny" );
SubTitle:SetPoint( "TOPLEFT", NS.Source, "BOTTOMLEFT", 0, -4 );
SubTitle:SetPoint( "RIGHT", NS.Source );
SubTitle:SetText( _NPCScan.L.BUTTON_FOUND );

-- Border
NS:SetBackdrop( {
	tile = true; edgeSize = 16;
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]];
} );
NS:OnLeave(); -- Set non-highlighted colors

-- Close button
local Close = CreateFrame( "Button", nil, NS, "UIPanelCloseButton" );
Close:SetPoint( "TOPRIGHT" );
Close:SetSize( 32, 32 );
Close:SetScale( 0.8 );
Close:SetHitRectInsets( 8, 8, 8, 8 );

-- Model view
local Model = NS.Model;
Model:SetPoint( "BOTTOMLEFT", NS, "TOPLEFT", 0, -4 );
Model:SetPoint( "RIGHT" );
Model:SetHeight( NS:GetWidth() * 0.6 );
NS:SetClampRectInsets( 0, 0, Model:GetHeight(), 0 ); -- Allow room for model


-- Glow animation
local Texture = Model:CreateTexture( nil, "OVERLAY" );
Texture:SetPoint( "CENTER", NS );
Texture:SetSize( 400 / 300 * NS:GetWidth(), 171 / 70 * NS:GetHeight() );
Texture:SetTexture( [[Interface\AchievementFrame\UI-Achievement-Alert-Glow]] );
Texture:SetBlendMode( "ADD" );
Texture:SetTexCoord( 0, 0.78125, 0, 0.66796875 );
Texture:SetAlpha( 0 );
NS.Glow = Texture:CreateAnimationGroup();
local FadeIn = NS.Glow:CreateAnimation( "Alpha" );
FadeIn:SetChange( 1.0 );
FadeIn:SetDuration( 0.2 );
local FadeOut = NS.Glow:CreateAnimation( "Alpha" );
FadeOut:SetOrder( 2 );
FadeOut:SetChange( -1.0 );
FadeOut:SetDuration( 0.5 );

-- Shine animation (reflection swipe)
local Texture = NS:CreateTexture( nil, "ARTWORK" );
Texture:SetPoint( "TOPLEFT", NS, 0, 8 );
Texture:SetSize( 67 / 300 * NS:GetWidth(), 1.28 * NS:GetHeight() );
Texture:SetTexture( [[Interface\AchievementFrame\UI-Achievement-Alert-Glow]] );
Texture:SetBlendMode( "ADD" );
Texture:SetTexCoord( 0.78125, 0.912109375, 0, 0.28125 );
Texture:SetAlpha( 0 );
NS.Shine = Texture:CreateAnimationGroup();
local Show = NS.Shine:CreateAnimation( "Alpha" );
Show:SetStartDelay( 0.3 );
Show:SetChange( 1.0 );
Show:SetDuration( 1e-5 ); -- Note: 0 is invalid
local Slide = NS.Shine:CreateAnimation( "Translation" );
Slide:SetOrder( 2 );
Slide:SetOffset( NS:GetWidth() - Texture:GetWidth() + 8, 0 );
Slide:SetDuration( 0.4 );
local FadeOut = NS.Shine:CreateAnimation( "Alpha" );
FadeOut:SetOrder( 2 );
FadeOut:SetStartDelay( 0.2 );
FadeOut:SetChange( -1.0 );
FadeOut:SetDuration( 0.2 );


-- Full screen flash
local Flash = NS.Flash;
Flash:Hide();
Flash:SetAllPoints();
Flash:SetAlpha( 0 );
Flash:SetFrameStrata( "FULLSCREEN_DIALOG" );

local Texture = Flash:CreateTexture();
Texture:SetBlendMode( "ADD" );
Texture:SetAllPoints();
Texture:SetTexture( [[Interface\FullScreenTextures\LowHealth]] );

Flash.Fade = Flash:CreateAnimationGroup();
Flash.Fade:SetLooping( "BOUNCE" );
Flash.Fade:SetScript( "OnLoop", Flash.OnLoop );
Flash.Fade:SetScript( "OnPlay", Flash.OnPlay );

local FadeIn = Flash.Fade:CreateAnimation( "Alpha" );
FadeIn:SetChange( 1.0 );
FadeIn:SetDuration( 0.5 );
FadeIn:SetEndDelay( 0.25 );


NS:SetAttribute( "type", "macro" );

NS:SetScript( "OnEnter", NS.OnEnter );
NS:SetScript( "OnLeave", NS.OnLeave );
NS:SetScript( "OnEvent", _NPCScan.Frame.OnEvent );
NS:HookScript( "OnShow", NS.OnShow );
NS:HookScript( "OnHide", NS.OnHide );
NS:RegisterEvent( "PLAYER_REGEN_ENABLED" );