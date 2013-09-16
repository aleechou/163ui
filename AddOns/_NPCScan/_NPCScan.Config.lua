--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * _NPCScan.Config.lua - Adds an options pane to the Interface Options menu.  *
  ****************************************************************************]]


local _NPCScan = select( 2, ... );
local L = _NPCScan.L;
local NS = CreateFrame( "Frame" );
_NPCScan.Config = NS;

NS.CacheWarnings = CreateFrame( "CheckButton", "_NPCScanConfigCacheWarningsCheckbox", NS, "InterfaceOptionsCheckButtonTemplate" );
NS.PrintTime = CreateFrame( "CheckButton", "_NPCScanConfigPrintTimeCheckbox", NS, "InterfaceOptionsCheckButtonTemplate" );

local AlertOptions = CreateFrame( "Frame", "_NPCScanConfigAlert", NS, "OptionsBoxTemplate" );
NS.Test = CreateFrame( "Button", "_NPCScanTest", AlertOptions, "UIPanelButtonTemplate" );
NS.AlertSoundUnmute = CreateFrame( "CheckButton", "_NPCScanConfigUnmuteCheckbox", AlertOptions, "InterfaceOptionsCheckButtonTemplate" );
NS.AlertSound = CreateFrame( "Frame", "_NPCScanConfigSoundDropdown", AlertOptions, "UIDropDownMenuTemplate" );




--- Builds a standard tooltip for a control.
function NS:ControlOnEnter ()
	GameTooltip:SetOwner( self, "ANCHOR_TOPRIGHT" );
	GameTooltip:SetText( self.tooltipText, nil, nil, nil, nil, 1 );
end


--- Sets the CacheWarnings option when its checkbox is clicked.
function NS.CacheWarnings.setFunc ( Enable )
	_NPCScan.SetCacheWarnings( Enable == "1" );
end
--- Sets the PrintTime option when its checkbox is clicked.
function NS.PrintTime.setFunc ( Enable )
	_NPCScan.SetPrintTime( Enable == "1" );
end

--- Plays a fake found alert and shows the target button.
function NS.Test:OnClick ()
	local Name = L.CONFIG_TEST_NAME;
	_NPCScan.Print( L.FOUND_FORMAT:format( Name ), GREEN_FONT_COLOR );
	_NPCScan.Print( L.CONFIG_TEST_HELP_FORMAT:format( GetModifiedClick( "_NPCSCAN_BUTTONDRAG" ) ) );

	_NPCScan.Button:SetNPC( "player", Name, L.CONFIG_TEST );
end
--- Sets the AlertSoundUnmute option when its checkbox is clicked.
function NS.AlertSoundUnmute.setFunc ( Enable )
	_NPCScan.SetAlertSoundUnmute( Enable == "1" );
end
--- Sets an alert sound chosen from the LibSharedMedia dropdown.
function NS.AlertSound:OnSelect ( NewValue )
	_NPCScan.Button.PlaySound( NewValue ); -- Play sample
	_NPCScan.SetAlertSound( NewValue );
end
--- Builds a dropdown menu for alert sounds with LibSharedMedia options.
function NS.AlertSound:initialize ()
	local Value = _NPCScan.Options.AlertSound;

	local Info = UIDropDownMenu_CreateInfo();
	Info.func = self.OnSelect;
	Info.text = L.CONFIG_ALERT_SOUND_DEFAULT;
	Info.checked = Value == nil;
	UIDropDownMenu_AddButton( Info );

	local LSM = LibStub( "LibSharedMedia-3.0" );
	for _, Key in ipairs( LSM:List( LSM.MediaType.SOUND ) ) do
		Info.text, Info.arg1 = Key, Key;
		Info.checked = Value == Key;
		UIDropDownMenu_AddButton( Info );
	end
end


--- Reverts to default options.
function NS:default ()
	_NPCScan.Synchronize(); -- Resets all
end




NS.name = L.CONFIG_TITLE;
NS:Hide();

-- Pane title
local Title = NS:CreateFontString( nil, "ARTWORK", "GameFontNormalLarge" );
Title:SetPoint( "TOPLEFT", 16, -16 );
Title:SetText( L.CONFIG_TITLE );
local SubText = NS:CreateFontString( nil, "ARTWORK", "GameFontHighlightSmall" );
SubText:SetPoint( "TOPLEFT", Title, "BOTTOMLEFT", 0, -8 );
SubText:SetPoint( "RIGHT", -32, 0 );
SubText:SetHeight( 32 );
SubText:SetJustifyH( "LEFT" );
SubText:SetJustifyV( "TOP" );
SubText:SetText( L.CONFIG_DESC );


-- Miscellaneous checkboxes
NS.CacheWarnings:SetPoint( "TOPLEFT", SubText, "BOTTOMLEFT", -2, -8 );
_G[ NS.CacheWarnings:GetName().."Text" ]:SetText( L.CONFIG_CACHEWARNINGS );
NS.CacheWarnings.tooltipText = L.CONFIG_CACHEWARNINGS_DESC;

NS.PrintTime:SetPoint( "TOPLEFT", NS.CacheWarnings, "BOTTOMLEFT", 0, -8 );
_G[ NS.PrintTime:GetName().."Text" ]:SetText( L.CONFIG_PRINTTIME );
NS.PrintTime.tooltipText = L.CONFIG_PRINTTIME_DESC;


-- Alert options section
AlertOptions:SetPoint( "TOPLEFT", NS.PrintTime, "BOTTOMLEFT", 0, -16 );
AlertOptions:SetPoint( "BOTTOMRIGHT", -14, 16 );
_G[ AlertOptions:GetName().."Title" ]:SetText( L.CONFIG_ALERT );

-- Test button
NS.Test:SetPoint( "TOPLEFT", 16, -16 );
NS.Test:SetSize( 144, 21 );
NS.Test:SetScript( "OnClick", NS.Test.OnClick );
NS.Test:SetScript( "OnEnter", NS.ControlOnEnter );
NS.Test:SetScript( "OnLeave", GameTooltip_Hide );
NS.Test:SetText( L.CONFIG_TEST );
NS.Test.tooltipText = L.CONFIG_TEST_DESC;

NS.AlertSoundUnmute:SetPoint( "TOPLEFT", NS.Test, "BOTTOMLEFT", -2, -16 );
_G[ NS.AlertSoundUnmute:GetName().."Text" ]:SetText( L.CONFIG_ALERT_UNMUTE );
NS.AlertSoundUnmute.tooltipText = L.CONFIG_ALERT_UNMUTE_DESC;

NS.AlertSound:SetPoint( "TOPLEFT", NS.AlertSoundUnmute, "BOTTOMLEFT", -12, -18 );
NS.AlertSound:SetPoint( "RIGHT", -12, 0 );
NS.AlertSound:EnableMouse( true );
NS.AlertSound:SetScript( "OnEnter", NS.ControlOnEnter );
NS.AlertSound:SetScript( "OnLeave", GameTooltip_Hide );
UIDropDownMenu_JustifyText( NS.AlertSound, "LEFT" );
_G[ NS.AlertSound:GetName().."Middle" ]:SetPoint( "RIGHT", -16, 0 );
local Label = NS.AlertSound:CreateFontString( nil, "ARTWORK", "GameFontNormalSmall" );
Label:SetPoint( "BOTTOMLEFT", NS.AlertSound, "TOPLEFT", 16, 3 );
Label:SetText( L.CONFIG_ALERT_SOUND );
NS.AlertSound.tooltipText = L.CONFIG_ALERT_SOUND_DESC;
UIDropDownMenu_SetText( NS.AlertSound, L.CONFIG_ALERT_SOUND_DEFAULT );


InterfaceOptions_AddCategory( NS );
if ( select( 4, GetAddOnInfo( "_NPCScan.Tools" ) ) ) then
	-- Add stub panel to load tools UI
	local Panel = CreateFrame( "Frame" );
	_NPCScan.ToolsPanel = Panel;
	Panel.name, Panel.parent = L.TOOLS_TITLE, NS.name;
	Panel:Hide();
	Panel:SetScript( "OnShow", function ( self )
		self:SetScript( "OnShow", nil );
		UIParentLoadAddOn( "_NPCScan.Tools" );
	end );
	InterfaceOptions_AddCategory( Panel );
end