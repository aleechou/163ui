--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * _NPCScan.Overlay.Config.lua - Adds a configuration pane to enable and      *
  *   disable display modules like the WorldMap and BattlefieldMinimap.        *
  ****************************************************************************]]


local Overlay = select( 2, ... );
local L = Overlay.L;
local NS = CreateFrame( "Frame" );
Overlay.Config = NS;

NS.ShowAll = CreateFrame( "CheckButton", "_NPCScanOverlayConfigShowAllCheckbox", NS, "InterfaceOptionsCheckButtonTemplate" );

local ModuleMethods = setmetatable( {}, getmetatable( NS ) );
NS.ModuleMeta = { __index = ModuleMethods; };

local IsChildAddOn = IsAddOnLoaded( "_NPCScan" );




--- Adds a control to the module to automatically be enabled and disabled.
function ModuleMethods:AddControl ( Control )
	self[ #self + 1 ] = Control;
	Control:SetEnabled( self.Module.Registered and self.Enabled:GetChecked() );
end
do
	--- Enables/disables all registered controls.
	local function SetControlsEnabled ( Config, Enabled )
		for _, Control in ipairs( Config ) do
			Control:SetEnabled( Enabled );
		end
	end
	--- Sets the module's enabled checkbox and enables/disables all child controls.
	function ModuleMethods:SetEnabled ( Enabled )
		self.Enabled:SetChecked( Enabled );
		if ( self.Module.Registered ) then
			SetControlsEnabled( self, Enabled );
		end
	end
	--- Disables the module's configuration when it gets unregistered.
	function ModuleMethods:Unregister ()
		self.Enabled:SetEnabled( false );
		local Color = GRAY_FONT_COLOR;
		_G[ self:GetName().."Title" ]:SetTextColor( Color.r, Color.g, Color.b );

		SetControlsEnabled( self, false );
	end
end




--- Shows the control's tooltip.
function NS:ControlOnEnter ()
	if ( self.tooltipText ) then
		GameTooltip:SetOwner( self, "ANCHOR_TOPLEFT" );
		GameTooltip:SetText( self.tooltipText, nil, nil, nil, nil, 1 );
	end
end
--- Standard checkbox control SetEnabled method.
function NS:ModuleCheckboxSetEnabled ( Enable )
	( Enable and BlizzardOptionsPanel_CheckButton_Enable or BlizzardOptionsPanel_CheckButton_Disable )( self );
end
--- Standard slider control SetEnabled method.
function NS:ModuleSliderSetEnabled ( Enable )
	( Enable and BlizzardOptionsPanel_Slider_Enable or BlizzardOptionsPanel_Slider_Disable )( self );
end

--- Sets the ShowAll option when its checkbox is clicked.
function NS.ShowAll.setFunc ( Enable )
	Overlay.SetShowAll( Enable == "1" );
end

--- Toggles the module when its checkbox is clicked.
function NS:ModuleEnabledOnClick ()
	local Enable = self:GetChecked() == 1;

	PlaySound( Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff" );
	Overlay.Modules[ Enable and "Enable" or "Disable" ]( self:GetParent().Module.Name );
end
--- Sets a module's alpha setting when its slider gets adjusted.
function NS:ModuleAlphaOnValueChanged ( Value )
	Overlay.Modules.SetAlpha( self:GetParent().Module.Name, Value );
end




do
	local LastFrame;
	--- Creates a config entry for a module with basic controls.
	-- @return Settings frame for module.
	function NS.ModuleRegister ( Module, Label )
		local Frame = CreateFrame( "Frame", "_NPCScanOverlayModule"..Module.Name, NS.ScrollChild, "OptionsBoxTemplate" );
		Frame.Module = Module;
		setmetatable( Frame, NS.ModuleMeta );

		_G[ Frame:GetName().."Title" ]:SetText( Label );
		Frame:SetPoint( "RIGHT", NS.ScrollChild:GetParent(), -4, 0 );
		if ( LastFrame ) then
			Frame:SetPoint( "TOPLEFT", LastFrame, "BOTTOMLEFT", 0, -16 );
		else
			Frame:SetPoint( "TOPLEFT", 4, -14 );
		end
		LastFrame = Frame;

		local Enabled = CreateFrame( "CheckButton", "$parentEnabled", Frame, "UICheckButtonTemplate" );
		Frame.Enabled = Enabled;
		Enabled:SetPoint( "TOPLEFT", 6, -6 );
		Enabled:SetSize( 26, 26 );
		Enabled:SetScript( "OnClick", NS.ModuleEnabledOnClick );
		local Label = _G[ Enabled:GetName().."Text" ];
		Label:SetText( L.CONFIG_ENABLE );
		Enabled:SetHitRectInsets( 4, 4 - Label:GetStringWidth(), 4, 4 );
		Enabled.SetEnabled = NS.ModuleCheckboxSetEnabled;

		local Alpha = CreateFrame( "Slider", "$parentAlpha", Frame, "OptionsSliderTemplate" );
		Frame.Alpha = Alpha;
		Alpha:SetPoint( "TOP", 0, -16 );
		Alpha:SetPoint( "RIGHT", -8, 0 );
		Alpha:SetPoint( "LEFT", Label, "RIGHT", 16, 0 );
		Alpha:SetMinMaxValues( 0, 1 );
		Alpha:SetScript( "OnValueChanged", NS.ModuleAlphaOnValueChanged );
		Alpha.SetEnabled = NS.ModuleSliderSetEnabled;
		local AlphaName = Alpha:GetName();
		_G[ AlphaName.."Text" ]:SetText( L.CONFIG_ALPHA );
		_G[ AlphaName.."Low" ]:Hide();
		_G[ AlphaName.."High" ]:Hide();
		Frame:AddControl( Alpha );

		Frame:SetHeight( Alpha:GetHeight() + 16 + 4 );
		return Frame;
	end
end


--- Reverts to default options.
function NS:default ()
	Overlay.Synchronize();
end




--- Slash command chat handler to open the options pane.
function NS.SlashCommand ()
	InterfaceOptionsFrame_OpenToCategory( NS );
end




local Label = L[ IsChildAddOn and "CONFIG_TITLE" or "CONFIG_TITLE_STANDALONE" ];
NS.name = Label;
NS:Hide();

-- Pane title
NS.Title = NS:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
NS.Title:SetPoint( "TOPLEFT", 16, -16 );
NS.Title:SetText( Label );
local SubText = NS:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
NS.SubText = SubText;
SubText:SetPoint( "TOPLEFT", NS.Title, "BOTTOMLEFT", 0, -8 );
SubText:SetPoint( "RIGHT", -32, 0 );
SubText:SetHeight( 32 );
SubText:SetJustifyH( "LEFT" );
SubText:SetJustifyV( "TOP" );
SubText:SetText( L.CONFIG_DESC );


NS.ShowAll:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -8 );
_G[ NS.ShowAll:GetName().."Text" ]:SetText( L.CONFIG_SHOWALL );
NS.ShowAll.tooltipText = L.CONFIG_SHOWALL_DESC;


-- Module options scrollframe
local Background = CreateFrame( "Frame", nil, NS, "OptionsBoxTemplate" );
Background:SetPoint( "TOPLEFT", NS.ShowAll, "BOTTOMLEFT", 0, -8 );
Background:SetPoint( "BOTTOMRIGHT", -32, 16 );
local Texture = Background:CreateTexture( nil, "BACKGROUND" );
Texture:SetTexture( 0, 0, 0, 0.5 );
Texture:SetPoint( "BOTTOMLEFT", 5, 5 );
Texture:SetPoint( "TOPRIGHT", -5, -5 );

local ScrollFrame = CreateFrame( "ScrollFrame", "_NPCScanOverlayScrollFrame", Background, "UIPanelScrollFrameTemplate" );
ScrollFrame:SetPoint( "TOPLEFT", 4, -4 );
ScrollFrame:SetPoint( "BOTTOMRIGHT", -4, 4 );

NS.ScrollChild = CreateFrame( "Frame" );
ScrollFrame:SetScrollChild( NS.ScrollChild );
NS.ScrollChild:SetSize( 1, 1 );


if ( IsChildAddOn ) then
	NS.parent = assert( _NPCScan.Config.name, "Couldn't parent configuration to _NPCScan." );
end
InterfaceOptions_AddCategory( NS );

SlashCmdList[ "_NPCSCAN_OVERLAY" ] = NS.SlashCommand;