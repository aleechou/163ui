--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * _NPCScan.Overlay.Config.lua - Adds a configuration pane to enable and      *
  *   disable display modules like the WorldMap and BattlefieldMinimap.        *
  ****************************************************************************]]
local FOLDER_NAME, private = ...
local L = private.L
local panel = _G.CreateFrame("Frame")
private.Config = panel

panel.ShowAll = CreateFrame( "CheckButton", "_NPCScanOverlayConfigShowAllCheckbox", panel, "InterfaceOptionsCheckButtonTemplate" );
panel.SetColor = CreateFrame( "Button", "_NPCScanOverlayConfigSetColorButton", panel, "UIPanelButtonTemplate" );

local ModuleMethods = setmetatable( {}, getmetatable( panel ) );
panel.ModuleMeta = { __index = ModuleMethods; };

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
function panel:ControlOnEnter ()
	if ( self.tooltipText ) then
		GameTooltip:SetOwner( self, "ANCHOR_TOPLEFT" );
		GameTooltip:SetText( self.tooltipText, nil, nil, nil, nil, 1 );
	end
end
--- Standard checkbox control SetEnabled method.
function panel:ModuleCheckboxSetEnabled ( Enable )
	( Enable and BlizzardOptionsPanel_CheckButton_Enable or BlizzardOptionsPanel_CheckButton_Disable )( self );
end
--- Standard slider control SetEnabled method.
function panel:ModuleSliderSetEnabled ( Enable )
	( Enable and BlizzardOptionsPanel_Slider_Enable or BlizzardOptionsPanel_Slider_Disable )( self );
end

--- Sets the ShowAll option when its checkbox is clicked.
function panel.ShowAll.setFunc ( Enable )
	private.SetShowAll( Enable == "1" );
end

--- Toggles the module when its checkbox is clicked.
function panel:ModuleEnabledOnClick ()
	local Enable = self:GetChecked() == 1;

	PlaySound( Enable and "igMainMenuOptionCheckBoxOn" or "igMainMenuOptionCheckBoxOff" );
	private.Modules[ Enable and "Enable" or "Disable" ]( self:GetParent().Module.Name );
end
--- Sets a module's alpha setting when its slider gets adjusted.
function panel:ModuleAlphaOnValueChanged ( Value )
	private.Modules.SetAlpha( self:GetParent().Module.Name, Value );
end




do
	local LastFrame;
	--- Creates a config entry for a module with basic controls.
	-- @return Settings frame for module.
	function panel.ModuleRegister ( Module, Label )
		local Frame = CreateFrame( "Frame", "_NPCScanOverlayModule"..Module.Name, panel.ScrollChild, "OptionsBoxTemplate" );
		Frame.Module = Module;
		setmetatable( Frame, panel.ModuleMeta );

		_G[ Frame:GetName().."Title" ]:SetText( Label );
		Frame:SetPoint( "RIGHT", panel.ScrollChild:GetParent(), -4, 0 );
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
		Enabled:SetScript( "OnClick", panel.ModuleEnabledOnClick );
		local Label = _G[ Enabled:GetName().."Text" ];
		Label:SetText( L.CONFIG_ENABLE );
		Enabled:SetHitRectInsets( 4, 4 - Label:GetStringWidth(), 4, 4 );
		Enabled.SetEnabled = panel.ModuleCheckboxSetEnabled;

		local Alpha = CreateFrame( "Slider", "$parentAlpha", Frame, "OptionsSliderTemplate" );
		Frame.Alpha = Alpha;
		Alpha:SetPoint( "TOP", 0, -16 );
		Alpha:SetPoint( "RIGHT", -8, 0 );
		Alpha:SetPoint( "LEFT", Label, "RIGHT", 16, 0 );
		Alpha:SetMinMaxValues( 0, 1 );
		Alpha:SetScript( "OnValueChanged", panel.ModuleAlphaOnValueChanged );
		Alpha.SetEnabled = panel.ModuleSliderSetEnabled;
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
function panel:default ()
	private.Synchronize();
end




--- Slash command chat handler to open the options pane.
function panel.SlashCommand ()
	InterfaceOptionsFrame_OpenToCategory( panel );
end




local Label = L[ IsChildAddOn and "CONFIG_TITLE" or "CONFIG_TITLE_STANDALONE" ];
panel.name = Label;
panel:Hide();

-- Pane title
panel.Title = panel:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
panel.Title:SetPoint( "TOPLEFT", 16, -16 );
panel.Title:SetText( Label );
local SubText = panel:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
panel.SubText = SubText;
SubText:SetPoint( "TOPLEFT", panel.Title, "BOTTOMLEFT", 0, -8 );
SubText:SetPoint( "RIGHT", -32, 0 );
SubText:SetHeight( 32 );
SubText:SetJustifyH( "LEFT" );
SubText:SetJustifyV( "TOP" );
SubText:SetText( L.CONFIG_DESC );


panel.ShowAll:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -8 );
_G[ panel.ShowAll:GetName().."Text" ]:SetText( L.CONFIG_SHOWALL );
panel.ShowAll.tooltipText = L.CONFIG_SHOWALL_DESC;

panel.SetColor:SetPoint( "TOPLEFT", panel.ShowAll, "BOTTOMLEFT", -2, -8 );
_G[ panel.SetColor:GetName().."Text" ]:SetText( L.CONFIG_SETCOLOR );
panel.SetColor:SetScript( "OnClick", function() _NPCScanOverlayPathColorList:Show()end);
panel.SetColor:SetHeight( 32 );
panel.SetColor:SetWidth( 150 );
panel.SetColor.tooltipText = L.CONFIG_SETCOLOR_DESC;


-- Module options scrollframe
local Background = CreateFrame( "Frame", nil, panel, "OptionsBoxTemplate" );
Background:SetPoint( "TOPLEFT", panel.SetColor, "BOTTOMLEFT", 0, -8 );
Background:SetPoint( "BOTTOMRIGHT", -32, 16 );
local Texture = Background:CreateTexture( nil, "BACKGROUND" );
Texture:SetTexture( 0, 0, 0, 0.5 );
Texture:SetPoint( "BOTTOMLEFT", 5, 5 );
Texture:SetPoint( "TOPRIGHT", -5, -5 );

local ScrollFrame = CreateFrame( "ScrollFrame", "_NPCScanOverlayScrollFrame", Background, "UIPanelScrollFrameTemplate" );
ScrollFrame:SetPoint( "TOPLEFT", 4, -4 );
ScrollFrame:SetPoint( "BOTTOMRIGHT", -4, 4 );

panel.ScrollChild = CreateFrame( "Frame" );
ScrollFrame:SetScrollChild( panel.ScrollChild );
panel.ScrollChild:SetSize( 1, 1 );


if ( IsChildAddOn ) then
	panel.parent = assert( _NPCScan.Config.name, "Couldn't parent configuration to _NPCScan." );
end
InterfaceOptions_AddCategory( panel );

SlashCmdList[ "_NPCSCAN_OVERLAY" ] = panel.SlashCommand;