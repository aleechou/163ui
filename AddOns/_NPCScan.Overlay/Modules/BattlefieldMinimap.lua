--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Modules/BattlefieldMinimap.lua - Canvas for Blizzard_BattlefieldMinimap.   *
  ****************************************************************************]]


local Overlay = select( 2, ... );
local NS = Overlay.Modules.WorldMapTemplate.Embed( CreateFrame( "Frame" ) );

NS.AlphaDefault = 0.8;




--- Attaches the canvas to the zone map when it loads.
function NS:OnLoad ( ... )
	self:SetParent( BattlefieldMinimap );

	return self.super.OnLoad( self, ... );
end




Overlay.Modules.Register( "BattlefieldMinimap", NS,
	Overlay.L.MODULE_BATTLEFIELDMINIMAP,
	"Blizzard_BattlefieldMinimap" );