--[[****************************************************************************
  * _NPCScanner by SLOKnightfall, a branch of _NPCScan.Overlay by Saiket       *
  * Modules/OmegaMap.lua - Canvas for the OmegaMap   addon.                    *
  ****************************************************************************]]

local private = select( 2, ... );
local panel = private.Modules.WorldMapTemplate.Embed( CreateFrame( "Frame", "NPCScanOmegaMapOverlay" ) );


panel.AlphaDefault = 0.8;




--- Attaches the canvas to Omegamap's custom frame when it loads.
--function panel:OnShow ( ... )
	--self:SetParent( OmegaMapNoteFrame );

	--return self.super.OnLoad( self, ... );
--end




private.Modules.Register( "OmegaMap", panel,
	private.L.MODULE_OMEGAMAP,
	"OmegaMap" );