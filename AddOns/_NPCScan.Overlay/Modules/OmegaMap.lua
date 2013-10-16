--[[****************************************************************************
  * _NPCScanner by SLOKnightfall, a branch of _NPCScan.Overlay by Saiket       *
  * Modules/OmegaMap.lua - Canvas for the OmegaMap   addon.                    *
  ****************************************************************************]]

local Overlay = select( 2, ... );
local NS = Overlay.Modules.WorldMapTemplate.Embed( CreateFrame( "Frame", "NPCScanOmegaMapOverlay" ) );


NS.AlphaDefault = 0.8;




--- Attaches the canvas to Omegamap's custom frame when it loads.
--function NS:OnShow ( ... )
	--self:SetParent( OmegaMapNoteFrame );

	--return self.super.OnLoad( self, ... );
--end




Overlay.Modules.Register( "OmegaMap", NS,
	Overlay.L.MODULE_OMEGAMAP,
	"OmegaMap" );