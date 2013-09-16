--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Locales/Locale-enUS.lua - Localized string constants (en-US).              *
  ****************************************************************************]]


-- See http://wow.curseforge.com/addons/npcscan-overlay/localization/enUS/
select( 2, ... ).L = setmetatable( {
	NPCs = { -- Note: Don't use a metatable default; Missing keys must return nil
		[ 18684 ] = "Bro'Gaz the Clanless",
		[ 32491 ] = "Time-Lost Proto Drake",
		[ 33776 ] = "Gondria",
		[ 35189 ] = "Skoll",
		[ 38453 ] = "Arcturis",
		[ 49822 ] = "Jadefang",
		[ 49913 ] = "Lady LaLa",
		[ 50005 ] = "Poseidus",
		[ 50009 ] = "Mobus",
		[ 50050 ] = "Shok'sharak",
		[ 50051 ] = "Ghostcrawler",
		[ 50052 ] = "Burgy Blackheart",
		[ 50053 ] = "Thartuk the Exile",
		[ 50056 ] = "Garr",
		[ 50057 ] = "Blazewing",
		[ 50058 ] = "Terrorpene",
		[ 50059 ] = "Golgarok",
		[ 50060 ] = "Terborus",
		[ 50061 ] = "Xariona",
		[ 50062 ] = "Aeonaxx",
		[ 50063 ] = "Akma'hat",
		[ 50064 ] = "Cyrus the Black",
		[ 50065 ] = "Armagedillo",
		[ 50085 ] = "Overlord Sunderfury",
		[ 50086 ] = "Tarvus the Vile",
		[ 50089 ] = "Julak-Doom",
		[ 50138 ] = "Karoma",
		[ 50154 ] = "Madexx",
		[ 50159 ] = "Sambas",
		[ 50815 ] = "Skarr",
		[ 50959 ] = "Karkin",
		[ 51071 ] = "Captain Florence",
		[ 51079 ] = "Captain Foulwind",
		[ 54318 ] = "Ankha",
		[ 54319 ] = "Magria",
		[ 54320 ] = "Ban'thalos",
		[ 54321 ] = "Solix",
		[ 54322 ] = "Deth'tilac",
		[ 54323 ] = "Kirix",
		[ 54324 ] = "Skitterflame",
		[ 54338 ] = "Anthriss",
		[ 60491 ] = "Sha of Anger",
		[ 62346 ] = "Galleon",
		[ 64403 ] = "Alani",
	};

	CONFIG_ALPHA = "Alpha",
	CONFIG_DESC = "Control which maps will show mob path overlays.  Most map-modifying addons are controlled with the World Map option.",
	CONFIG_SHOWALL = "Always show all paths",
	CONFIG_SHOWALL_DESC = "Normally when a mob isn't being searched for, its path gets taken off the map.  Enable this setting to always show every known patrol instead.",
	CONFIG_TITLE = "Overlay",
	CONFIG_TITLE_STANDALONE = "_|cffCCCC88NPCScan|r.Overlay",
	MODULE_ALPHAMAP3 = "AlphaMap3 AddOn",
	MODULE_BATTLEFIELDMINIMAP = "Battlefield-Minimap Popout",
	MODULE_MINIMAP = "Minimap",
	MODULE_RANGERING_DESC = "Note: The range ring only appears in zones with tracked rares.",
	MODULE_RANGERING_FORMAT = "Show %dyd ring for approximate detection range",
	MODULE_WORLDMAP = "Main World Map",
	MODULE_WORLDMAP_KEY_FORMAT = "• %s",
	MODULE_WORLDMAP_TOGGLE = "NPCs",
	MODULE_WORLDMAP_TOGGLE_DESC = "Toggle _|cffCCCC88NPCScan|r.Overlay's paths for tracked NPCs.",

	-- Phrases localized by default UI
	CONFIG_ENABLE = ENABLE;
}, {
	__index = function ( self, Key )
		if ( Key ~= nil ) then
			rawset( self, Key, Key );
			return Key;
		end
	end;
} );


SLASH__NPCSCAN_OVERLAY1 = "/npcscanoverlay";
SLASH__NPCSCAN_OVERLAY2 = "/npcoverlay";
SLASH__NPCSCAN_OVERLAY3 = "/overlay";