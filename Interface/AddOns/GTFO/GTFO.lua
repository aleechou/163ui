--------------------------------------------------------------------------
-- GTFO.lua 
--------------------------------------------------------------------------
--[[
GTFO
Author: Zensunim of Dragonblight

Usage: /GTFO or go to Interface->Add-ons->GTFO

Note: Place your own custom spells and setups in GTFO_Custom.lua

Special thanks: 
		Smacker (Power Auras)
		Freydis88, GusBackus, and Zaephyr81 (German Translations)
		pcki11 and D_Angel (Russian Translations)
		lsjyzjl, Wowuicn, and xazhaoyang (Simplified and Traditional Chinese Translations)
		Blubibulga and TrAsHeR (French Translations)
		Sunyruru and Maknae (Korean Translations)
		Pablous (Spanish Translations)
		Andyca, and BNSSNB (Traditional Chinese Translations)
		Phalk and Omukeka (Brazilian Portuguese Translations)


Change Log:
	v0.1
		- Beta Release
		- Added menu options
	v0.2
		- Put spells in its own area
	v0.3
		- Updated for Wrath spells
	v0.3.1
		- Updated for Naxx spells
	v0.3.2
		- More spells
	v0.3.3
		- More spells
	v1.0
		- Public Release
		- More spells
		- High/Low options
	v1.0.1
		- Added spells, replaced names with spell IDs
	v1.1
		- Bug fixes
		- Added "test" buttons to the menu option
		- Added spells, replaced names with spell IDs
		- Sound spam prevention
		- Alerts on "afflicted by" event
	v1.1.1
		- Spell fixes, new spells, replaced names with spell IDs
		- Added the ability to alert only on DoT application
		- Fixed "afflicted by" alerts to support stacking debuffs
	v1.1.2
		- Added spells
	v1.1.3
		- Added spells
	v1.1.4
		- Added spells
	v1.2
		- Patch 3.3 Compatible
		- Added version checking and update notification
		- Added spells
	v1.2.1
		- Added spells
	v1.2.2
		- Added spells
		- Casting Hellfire no longer triggers alerts
	v1.2.3
		- Added spells
	v1.2.4
		- Added spells
	v1.2.5
		- Added spells
		- Fixed bug in version updates
	v1.2.6
		- Added spells
	v2.0
		- Added "Fail" mode/sound
		- Added spells
	v2.0.1
		- Added spells
	v2.0.2
		- Added spells
	v2.0.3
		- Added spells
	v2.0.4
		- Added spells
	v2.0.5
		- Added/fixed spells
	v2.1
		- Added Power Auras Integration
	v2.2
		- Added volume control
		- Added "/gtfo options" command
		- Added melee hit/miss detection
	v2.2.1
		- Added spells
	v2.2.2
		- Fixed spells
	v2.2.3
		- Reduced memory footprint
		- Added spells
		- Improved help documentation
	v2.3
		- Added tank vs. non-tank alert support (alerts coming soon!)
		- Added Cataclysm beta spells (requires test mode)
		- Added test mode for untested alerts
		- Fixed a crash with users running a very old version of Power Auras Classic
	v2.4
		- Added Cataclysm compatibility
		- WAV sound effects converted to MP3s for Cataclysm support
		- Added Cataclysm beta spells
		- Removed test mode status of tested Cataclysm beta spells 
	v2.5
		- Added localization support
		- Split spell files into multiple sections
		- Added spells
		- Removed test mode status of tested Cataclysm beta spells 
	v2.5.1
		- Added Cataclysm spells from Blackrock Depths, Vortex Pinnacle, Grim Batol, Twilight Highlands
		- Added Classic spells from Molten Core
		- Added Wrath spells from Icecrown Citadel, Obsidian Sanctum, Ruby Sanctum
	v2.5.2
		- Added Cataclysm spells for Halls of Origination
		- Added Cataclysm spells for Lost City of the Tol'vir
		- Added Cataclysm spells for Blackrock Depths (Heroic)
		- Added Cataclysm spells for Throne of the Tides (Heroic)
		- Added Cataclysm spells for Vortex Pinnacle (Heroic)
		- Added Cataclysm spells for Grim Batol (Heroic)
	v2.5.3
		- Added Cataclysm spells for Halls of Origination
		- Added Cataclysm spells for Grim Batol
		- Added Cataclysm spells for Deadmines (Heroic)
		- Added Cataclysm spells for Shadowfang Keep (Heroic)
		- Added Wrath spells for Halls of Reflection
		- Added Wrath spells for Icecrown Citadel
	v2.6
		- WAV sound effects converted to OGGs for Cataclysm support and better sound quality
		- Updated for 4.0 compatibility
	v2.7
		- Changed Death Knight tank detection to look for Blood Presence instead of Frost
		- Fixed Paladin tank detection to look for tanking shields only
	v2.8
		- Fixed "You're not in a raid" spam in battlegrounds
	v2.8.1
		- Added German localization - Thanks Freydis88
		- Added Russian localization - Thanks pcki11
	v2.8.2
		- Added new player 4.x spells
	v2.9
		- Removed "3.x vs. 4.x" support code
		- Optimized sound code
		- Added Wrath spells for Icecrown Citadel
		- Fixed Wrath spells for Icecrown Citadel
	v2.9.1
		- Added Wrath spells for Icecrown Citadel
		- Added Burning Crusade spells for Hellfire Ramparts
		- Added Burning Crusade spells for Blood Furnace
		- Added Classic spells for Molten Core
		- Added Generic spells (Rain of Fire)
	v3.0
		- General code optimizations
		- Added Simplified Chinese localization - Thanks Wowuicn
		- Added Traditional Chinese localization - Thanks Wowuicn
		- Enabled optimized sound code added in 2.9 (oops!)
		- Added 5th volume level
		- Added the ability to hear sounds when game sounds are normally muted
		- Added support for "always alert" spells to ignore absorb/immune/missed
		- Added support for vehicle spell alerts (Malygos, Flame Leviathan)
		- Fixed all "English only" alerts to support all clients
		- Added Burning Crusade spells (Untested)
		- Added Wrath spells for Ulduar
		- Added Wrath spells for Icecrown Citadel
		- Added Wrath spells for Eye of Eternity
	v3.0.1
		- Added Burning Crusade spells for Karazhan
		- Added Burning Crusade spells for Slave Pens
		- Added Burning Crusade spells for the Underbog
		- Added Burning Crusade spells for the Steamvaults
		- Added Burning Crusade spells for Sethekk Halls
		- Added Burning Crusade spells for Shadow Labyrinth
		- Added Burning Crusade spells for Old Hillsbrad Foothills
		- Added Burning Crusade spells for Black Morass
		- Added Burning Crusade spells for Hyjal Summit
		- Added Burning Crusade spells for Black Temple
		- Added Burning Crusade spells for Auchenai Crypts
		- Updated Cataclysm spells for Deadmines (Heroic)
	v3.0.2
		- Added Cataclysm spells for Baradin Hold
		- Added Cataclysm spells for the Bastion of Twilight
		- Added Classic spells
		- Added comments to the LUA code
	v3.1
		- Added "friendly fire" alert and sound
		- Added experimental/beta mode option in config
		- Added trivial alert mode option in config
		- Added "minimum stacks" variable to alerts
		- Added "level" variable to determine trivial alerts
		- Added friendly pop-up message for first-time users and version upgraders
		- Updated Wrath spells for Icecrown Citadel
		- Added Wrath spells for Nexus
		- Added Wrath spells for Azjol-Nerub
		- Added Wrath spells for Ulduar
		- Updated Cataclysm spells for Bastion of Twilight
		- Added Cataclysm spells for Blackwing Descent
		- Added Cataclysm spells for Throne of the Four Winds
		- Added Cataclysm spells for Shadowfang Keep (Heroic)
		- Updated German localization - Thanks Freydis88
	v3.2
		- Added French localization - Thanks Blubibulga
		- Fixed Mob GUID function
		- Added "specific mob" variable to alerts
		- Added Burning Crusade spells for Sethekk Halls
		- Added Burning Crusade spells for Shattered Halls
		- Added Burning Crusade spells for Black Temple
		- Added Burning Crusade spells for Serpentshrine Cavern
		- Added Burning Crusade spells for Arcatraz
		- Added Burning Crusade spells for Mechanar
		- Added Burning Crusade spells for Shadow Labyrinth
		- Added Burning Crusade spells for Botanica
		- Added Classic spells for Molten Core
		- Added Wrath spells for Onyxia's Lair
	v3.2.1
		- Removed GTFO_Custom.lua reference
		- Added and updated Wrath spells for Icecrown Citadel
		- Added generic spells
		- Added Classic spells for Blackrock Spire
		- Added Classic spells for Deadmines
		- Added Classic spells for Stockades
		- Added Classic spells for Scholomance
		- Added Classic spells for Stratholme
		- Added Classic spells for Shadowfang Keep
		- Added Burning Crusade spells for Magtheridon's Lair
		- Added Burning Crusade spells for Gruul's Lair
		- Added Wrath spells for Naxxramas
		- Added Wrath spells for Nexus
	v3.2.2
		- Activated Chinese and French translations (oops!)
		- Fixed a bug with missing translations
	v3.2.3
		- Fixed a bug with tanking shield detection during load
		- Added Classic spells for Gnomeregan
		- Added Classic spells for Scarlet Monastery
		- Added Classic spells for Maraudon
	v3.2.4
		- Added Classic spells for Scarlet Monastery
		- Added Classic spells for Maraudon
		- Added Classic spells for Molten Core
		- Added Burning Crusade for Karazhan
	v3.2.5
		- Updated Cataclysm spells for Blackrock Caverns
		- Added Cataclysm spells for Vashj'ir
		- Added Cataclysm spells for Uldum
		- Added Cataclysm spells for Vortex Pinnacle
		- Added Cataclysm spells for Throne of the Tides
		- Added Wrath spells for Nexus
		- Added Wrath spells for Utgarde Pinnacle
		- Added Wrath spells for Obsidian Sanctum
		- Added Classic spells for Blackrock Spire
		- Added Classic spells for Sunken Temple
	v3.2.6
		- Added Cataclysm spells for Twilight Highlands
		- Added Cataclysm spells for Uldum
		- Added Cataclysm spells for Lost City of the Tol'vir
		- Added Cataclysm spells for Vortex Pinnacle
		- Added Cataclysm spells for Deepholm
		- Added Cataclysm spells for Tol Barad
		- Added Cataclysm spells for Hyjal
	v3.2.7
		- Added Cataclysm spells for Halls of Origination (Heroic)
		- Added Cataclysm spells for Blackrock Caverns
		- Added Cataclysm spells for Hyjal
		- Added Cataclysm spells for Stonecore (Heroic)
		- Added Cataclysm spells for Grim Batol (Heroic)
	v3.3
		- Added Cataclysm spells for Halls of Origination (Heroic)
		- Added Cataclysm spells for Deadmines (Heroic)
		- Added Cataclysm spells for Stonecore (Heroic)
		- Added Cataclysm spells for Throne of the Tides (Heroic)
		- Updated Cataclysm spells for Blackwing Descent
		- Updated Cataclysm spells for Throne of the Four Winds
		- Updated Cataclysm spells for Bastion of Twilight
		- Updated Cataclysm spells for Baradin Hold
		- Updated Traditional Chinese localization - Thanks Wowuicn
		- Updated Traditional Russian localization - Thanks D_Angel
	v3.3.1
		- Added Cataclysm spells for Blackwing Descent
		- Updated Cataclysm spells for Shadowfang Keep (Heroic)
		- Added Cataclysm spells for Vortex Pinnacle
	v3.3.2
		- Added Cataclysm spells for Blackwing Descent
		- Added Cataclysm spells for Bastion of Twilight
	v3.4
		- Added support to detect "energize" events
		- Added Cataclysm spells for Blackwing Descent
		- Added Cataclysm spells for Grim Batol
		- Updated Cataclysm spells for Throne of the Tides
	v3.4.1
		- Fixed Cataclysm spells for Bastion of Twilight
	v3.4.2
		- Updated French localization - Thanks Blubibulga
		- Removed Cataclysm spells for Bastion of Twilight
	v3.5
		- Added alert for Fatigue
		- Updated alert for Drowning
		- Added Cataclysm spells for Bastion of Twilight
		- Added Cataclysm spells for Blackwing Descent
		- Added Cataclysm spells for Hyjal
		- Added Cataclysm spells for Twilight Highlands
		- Added Cataclysm spells for Stonecore
	v3.5.1
		- Added Cataclysm spells for Bastion of Twilight
		- Updated German localization - Thanks GusBackus
		- Added Korean localization - Thanks Sunyruru
	v3.5.2
		- Updated Korean localization - Thanks Sunyruru
		- Updated spells for Love is in the Air
	v3.5.3
		- Added Cataclysm spells for Throne of the Four Winds
		- Updated Cataclysm spells for Throne of the Four Winds
	v3.5.4
		- Added Cataclysm spells for Bastion of Twilight
	v3.5.5
		- Fixed Cataclysm spells for Throne of the Four Winds
		- Added Cataclysm spells for Bastion of Twilight
		- Added Cataclysm spells for Blackwing Descent
		- Added Burning Crusade spells for Tempest Keep
	v3.5.6
		- Added Cataclysm spells for Bastion of Twilight
	v3.6
		- Updated sounds to play on the Master channel instead of the SFX channel
		- SFX channel is no longer unmuted when "Play sounds when muted" option is checked
	v4.0
		- Added 4.1.0 support (PTR)
		- Added alerts for when the player is damaging other party/raid members
		- Added support for alerts based on player's debuffs
		- Fixed Cataclysm spells for Throne of the Four Winds
		- Added Cataclysm spells for Bastion of Twilight
		- Added Cataclysm spells for Blackwing Descent
		- Added Cataclysm spells for Zul'Gurub
		- Added Cataclysm spells for Zul'Aman
		- Added Wrath spells for Icecrown Citadel
	v4.0.1
		- Fixed Cataclysm spells for Zul'Gurub
		- Fixed Cataclysm spells for Blackwing Descent
		- Fixed Cataclysm spells for Bastion of Twilight
	v4.1
		- Added Recount integration
		- Added support for alerts based on player's buffs
		- Added Cataclysm spells for Bastion of Twilight
		- Added Wrath spells for Ruby Sanctum
	v4.2
		- Added addon message registration (PTR)
		- Added support for alerts based on minimum damage taken
		- Added and fixed Cataclysm spells for Blackwing Descent
		- Added Cataclysm spells for Bastion of Twilight
		- Removed Cataclysm spells for Throne of the Four Winds
	v4.2.1
		- Updated French localization - Thanks Blubibulga
		- Added Spanish localization - Thanks Pablous
		- Added Cataclysm spells for Zul'Aman
	v4.2.2
		- Updated Cataclysm spells for Throne of the Four Winds
		- Added Cataclysm spells for Blackwing Descent
		- Added Latin American Spanish localization (copied from the Spanish localization)
	v4.2.3
		- Updated Traditional Chinese localization - Thanks Wowuicn
		- Added Cataclysm spells for Zul'Gurub
		- Added Cataclysm spells for Blackwing Descent
	v4.3
		- Removed support for versions prior to GTFO 4.3 due to WoW 4.1 combat log changes
		- Changed addon communications to use "GTFO" only instead of "GTFO_u" and "GTFO_v"
		- Updated Korean localization - Thanks Sunyruru
	v4.3.1
		- Added Cataclysm spells for Zul'Gurub
		- Added Cataclysm spells for Zul'Aman
		- Updated Generic spells (PvP)
	v4.3.2
		- Added Classic spells for Thousand Needles
		- Updated Cataclysm spells for Blackwing Descent
	v4.4
		- Fixed cross-server version check bug
		- Added 4.2.0 support (PTR)
		- Added Cataclysm spells for Baradin Hold
		- Added Cataclysm spells for Firelands (Experimental Mode)
	v4.5
		- Revamped event handling system
		- Added advanced custom logic handling to work around Blizzard's bugs
		- Reworked test console commands so "/gtfo test2" and "/gtfo test 2" are both valid
		- Updated French localization - Thanks Blubibulga	
		- Added Cataclysm spells for Blackwing Descent
		- Fixed Cataclysm spells for Throne of the Four Winds
		- Fixed Cataclysm spells for Baradin Hold
		- Fixed Cataclysm spells for Throne of the Tides
		- Maloriak's Frost Chill and Al'akir's Lightning Rod no longer spams friendly fire warnings when you have the debuff
		- Removed low alert warning for lava when gaining stacks of magma in Blackwing Descent or Bastion of Twilight
		- Removed Cataclysm spells for Vashj'ir
	v4.6
		- Added Skada integration
		- Friendly fire alerts now record who caused the damage (when this info is available) in Recount/Skada
		- Environmental, PvP, generic alerts, and campfires that damage less than 0.5% of your total HP are considered trivial alerts
		- Improved memory management of disabled integration features
		- Fixed several spells incorrectly sounding friendly fire alerts on the final tick of damage
		- Magma is now being ignored briefly at the beginning of Phase 2 Nefarian
		- Added Cataclysm spells for Baradin Hold (PTR)
		- Added Cataclysm spells for Firelands (PTR)
		- Added and updated Cataclysm spells for Blackwing Descent
		- Updated Cataclysm spells for Zul'Gurub
		- Added and updated Cataclysm spells for Throne of the Four Winds
		- Fixed Cataclysm spells for Vashj'ir
		- Fixed label bug in Recount
	v4.7
		- Fixed localization bug that causes untranslated strings to appear as blank instead of English
		- Revamped display handling system for easier hooking
		- Updated French localization - Thanks Blubibulga
		- Updated Cataclysm spells for Throne of the Tides
		- Added and updated Cataclysm spells for Deadmines (Heroic)
	v4.8
		- Removed support for versions prior to GTFO 4.8 due to WoW 4.2 combat log changes
		- Added and updated Cataclysm spells for Uldum
		- Updated Cataclysm spells for Firelands
		- Updated Cataclysm spells for Shadowfang Keep (Heroic)
		- Added holiday event spells for Ahune
	v4.8.1
		- Added Cataclysm spells for Firelands
		- Fixed version numbering bug
	v4.8.2
		- Added Cataclysm spells for Firelands
		- Added Cataclysm spells for Hyjal
		- Added Cataclysm spells for the Molten Front
		- Added generic spells
	v4.8.3
		- Fixed Cataclysm spells for Firelands
		- Added Cataclysm spells for Vortex Pinnacle
		- Added Cataclysm spells for Hyjal
		- Added Cataclysm spells for the Molten Front
	v4.8.4
		- Added Cataclysm spells for Firelands
		- Added Cataclysm spells for Hyjal
		- Added Cataclysm spells for the Molten Front
	v4.8.5
		- Fixed lua error with Skada integration
		- Added Cataclysm spells for Firelands
		- Added Cataclysm spells for the Molten Front
	v4.8.6
		- Updated German Localization - Thanks Zaephyr81
		- Fixed another lua error with Skada integration
		- Added Cataclysm spells for the Molten Front
		- Added Cataclysm spells for Hyjal
		- Added Cataclysm spells for Blasted Lands
		- Updated Cataclysm spells for Zul'Gurub
		- Updated Cataclysm spells for Firelands
	v4.8.7
		- Updated Simplified Chinese localization - Thanks Wowuicn
		- Added Cataclysm spells for Firelands
	v4.9
		- Updated Traditional Chinese localization - Thanks lsjyzjl
		- Recount integration is disabled when using the LUI mod
		- Added handling of alerts when a debuff gets refreshed
		- Added Cataclysm spells for Firelands - Thanks Ferret2
		- Added Classic spells for Ruins of Ahn'Qiraj
	v4.9.1
		- Fixed lua error with Skada integration
		- Added Cataclysm spells for Firelands (Volcanus encounter)
	v4.9.2
		- Restored Recount integration when using the LUI mod
		- Fixed Skada integration from being subjected to the sound spam filter
		- Added Cataclysm spells for Firelands (Ragnaros)
		- Fixed Cataclysm spells for Icecrown Citadel (Blood Queen)
	v4.9.3
		- Added Cataclysm spells for Baradin Hold (Occu'thar)
	v4.9.4
		- Updated Korean localization - Thanks Sunyruru
		- Added holiday event spells for Brewfest
	v4.9.5
		- Added Brazilian Portuguese localization - Thanks Phalk and Omukeka
		- Updated Simplified Chinese localization - Thanks xazhaoyang
		- Updated Traditional Chinese localization - Thanks xazhaoyang
		- Added Cataclysm spells for Firelands (Trash, Ragnaros, Lord Rhyolith)
		- Updated Cataclysm spells for Throne of the Four Winds (Al'Akir)
		- Added Cataclysm spells for End Time
		- Added Cataclysm spells for Hour of Twilight
		- Added Cataclysm spells for Baradin Hold (Alizabal, Trash)
		- Added Cataclysm spells for the Nexus (Legendary quest) - Thanks Alaw & Blubibulga
	v4.10
		- Added PowerAuras 5.0 integration
		- Updated Nefarian for Simplified Chinese
		- Updated French localization - Thanks TrAsHeR
		- Added Cataclysm spells for Well of Eternity
		- Added Cataclysm spells for Dragon Soul
		- Added Cataclysm spells for Firelands (Heroic Alysrazor)
	v4.11
		- Updated for patch 4.3 compatibility
	v4.11.1
		- Fixed GTFO high buzzer sound to work with 4.3
		- Added Cataclysm spells for Dragon Soul
		- Added Cataclysm spells for Well of Eternity
		- Added Cataclysm spells for Hour of Twilight
	v4.11.2
		- Added Cataclysm spells for Dragon Soul (Ultraxion, Warmaster Blackhand, Deathwing)
	v4.11.3
		- Added Cataclysm spells for Dragon Soul (Warmaster Blackhorn)
		- Added Cataclysm spells for Hour of Twilight
		- Added Cataclysm spells for Darkmoon Faire
		- Updated Cataclysm spells for Dragon Soul (Deathwing)
		- Updated Cataclysm spells for Well of Eternity (Peroth'arn)
	v4.11.4
		- Updated Cataclysm spells for End Time
		- Added Classic spells for Eastern Plaguelands
	v4.11.5
		- Added Cataclysm spells for Dragon Soul (Warmaster Blackhand)
		- Updated generic spells
	v4.12
		- Added "special alerts" section for managing specific alert categories
		- Updated Traditional Chinese localization - Thanks Andyca
	v4.12.1
		- Fixed LUA error in config options for some clients
	v4.12.2
		- Fixed lua error with Skada integration
	v4.12.3
		- Removed "GTFO Loaded" startup message
		- Updated French localization - Thanks Blubibulga
		- Added command line option to disable version notifications
	v4.12.4
		- Preventative taint protection on pop-up box
		- Updated French localization - Thanks Blubibulga
	v4.13
		- Added support for Mists of Pandaria (5.0.1)
		- Added "INSTAKILL" event for fail alerts
		- Added "Fatigue" to "special alerts"
		- Added Cataclysm spells for Dragon Soul (Heroic Hagara)
		- Added Pandaria spells for Scholomance
		- Added Pandaria spells for Scarlet Cathedral
		- Added Pandaria spells for Scarlet Halls
		- Added Pandaria spells for Stormstout Brewery
		- Added Pandaria spells for Temple of the Jade Serpent
	v4.14
		- Updated for patch 5.0.4
		- Reorganized spells for easier maintainability
		- Added Pandaria spells for Mogu'shan Vaults
	v4.14.1
		- Code optimizations
		- Added Cataclysm spells for Dragon Soul (Heroic Madness)
		- Added placeholders for Pandaria spells
		- Added Pandaria spells for Gate of the Setting Sun
		- Added Pandaria spells for Mogu'shan Palace
		- Added Pandaria spells for Heart of Fear	
	v4.14.2
		- Added Pandaria spells for Theramore's Fall
		- Added Traditional Chinese localization - Thanks BNSSNB
	v4.14.3
		- Added Pandaria spells for world bosses
		- Added Pandaria spells for Shado-Pan Monastery
		- Added Pandaria spells for Siege of Nivzao Temple
		- Added Pandaria spells for Mogu'shan Vaults
	v4.15
		- Fixed a bug with debuffs
		- Fixed Pandaria spells for Temple of the Jade Serpent
		- Removed Pandaria spells for Scarlet Cathedral
		- Added Pandaria spells for Pandaria
		- Added Pandaria spells for Stormstout Brewery
	v4.16
		- Added support for different spell alerts at different difficulty levels
		- Removed change logs from most individual files to reduce addon install size
		- Updated Cataclysm spells for Dragon Soul (Heroic Hagara)
		- Updated Pandaria spells for Stormstout Brewery
		- Added Pandaria spells for Temple of the Jade Serpent
		- Added Pandaria spells for Shado-Pan Monastery
		- Added Pandaria spells for Mogu'shan Palace
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Pandaria (world)
	v4.16.1
		- Updated Pandaria spells for Stormstout Brewery
		- Added Pandaria spells for Shado-Pan Monastery
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for A Brewing Storm
		- Added Pandaria spells for Crypt of the Forgotten Kings
		- Added Pandaria spells for Arena of Annihilation
		- Added Pandaria spells for Brewmoon Festival
		- Added Pandaria spells for Greenstone Village
		- Added Pandaria spells for Siege of Nivzao Temple
		- Added Pandaria spells for Scarlet Cathedral
		- Added Pandaria spells for Scarlet Halls
		- Added Pandaria spells for Gate of the Setting Sun
	v4.16.2
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Headless Horseman
	v4.16.3
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Arena of Annihilation
		- Added Pandaria spells for Gate of the Setting Sun
		- Added Pandaria spells for Siege of Nivzao Temple
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Heart of Fear
	v4.16.4
		- Alerts for Pheromones of Zeal for Imperial Vizier Zor'lok have been toned down
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Heart of Fear
	v4.17
		- PvP alerts no longer sound during the Amber-Shaper Un'sok encounter
		- Added Korean localization - Thanks Maknae
		- Added Brazilian Portuguese localization - Thanks Phalk
		- Added Pandaria spells for Siege of Nivzao Temple
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Heart of Fear
		- Added Pandaria spells for The Eye
	v4.17.1
		- Updated for patch 5.1
		- Added Pandaria spells for Terrace of Endless Spring
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Heart of Fear
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Stormstout Brewery
		- Added Pandaria spells for Brewmoon Festival
	v4.18
		- Fixed addon message handling in LFD/LFR/Battlegrounds
		- Updated Pandaria spells for Terrace of Endless Spring
	v4.18.1
		- Added Pandaria spells for Heart of Fear
		- Added Pandaria spells for Assault on Zan'vess
		- Added Pandaria spells for Darkmoon Faire
		- Added Pandaria spells for Terrace of Endless Spring
		- Added Pandaria spells for Pandaria (world)
		- Added Classic spells for Temple of Ahn'Qiraj
	v4.19
		- Fixed addon support with WeakAuras and other display hooks
		- Debugging mode commented out to improve performance
		- Added trivial alert slider
		- Added Simplified Chinese localization - Thanks lsjyzjl
		- Added Pandaria spells for Lion's Landing
		- Added Pandaria spells for Domination Point
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Terrace of Endless Spring
		- Added Pandaria spells for Brawler's Guild
	v4.19.1
		- Fixed missing localization strings
	v4.20
		- Added Traditional Chinese localization - Thanks BNSSNB
		- Added native WeakAuras integration
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Brawler's Guild		
		- Added Pandaria spells for Heart of Fear	
	v4.20.1
		- Added 5.2 support (PTR)
		- Added French localization - Thanks Blubibulga
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Throne of Thunder
	v4.21
		- Fixed trivial alert slider settings
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Trove of the Thunder King
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Mogu'shan Vaults
		- Added Pandaria spells for Terrace of Endless Spring
	v4.22
		- Updated for patch 5.2
		- Added support for Brewmaster monk tanks
		- Added Pandaria spells for Throne of Thunder
	v4.22.1
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Mogu'shan Vaults
	v4.22.2
		- Fixed Pandaria spells for Throne of Thunder
		- Fixed Pandaria spells for Brawler's Guild
	v4.23
		- Added support for LFR filters
		- Added Pandaria spells for Black Temple
		- Fixed Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Heart of Fear	
	v4.23.1
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for A Little Patience
		- Added Pandaria spells for Dagger in the Dark
		- Added Pandaria spells for Pandaria (world)
	v4.23.2
		- Updated for patch 5.3
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Theramore's Fall
		- Added Pandaria spells for Blood in the Snow
		- Added Pandaria spells for The Secrets of Ragefire
		- Added Pandaria spells for Dark Heart of Pandaria
		- Added Pandaria spells for Battle on the High Seas
		- Added Pandaria spells for Unga Ingoo
	v4.23.3
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Dark Heart of Pandaria
		- Added Pandaria spells for The Secrets of Ragefire
	v4.23.4
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Crypt of the Forgotten Kings
		- Added Pandaria spells for A Brewing Storm
		- Added Pandaria spells for Trove of the Thunder King
		- Added/Updated Pandaria spells for Throne of Thunder (thanks Oscarucb)
	v4.23.5
		- Added Pandaria spells for Pandaria (world)
		- Removed Pandaria spells for Throne of Thunder
	v4.23.6
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Pandaria (world)
	v4.23.7
		- Updated for patch 5.4
		- Added Pandaria spells for Proving Grounds
		- Added Pandaria spells for Throne of Thunder
		- Added Pandaria spells for Siege of Orgrimmar
	v4.23.8
		- Added Pandaria spells for Siege of Orgrimmar
		- Added Pandaria spells for Pandaria (world)
	v4.24
		- Added additional detection to prevent false friendly-fire alerts
		- Added Pandaria spells for Siege of Orgrimmar
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Temple of the Jade Serpent
		- Added Pandaria spells for Gate of the Setting Sun
	v4.24.1
		- Added Pandaria spells for Siege of Orgrimmar
	v4.24.2
		- Added Pandaria spells for Siege of Orgrimmar
		- Added Pandaria spells for Pandaria (world)
		- Fixed Pandaria spells for The Secrets of Ragefire
	v4.24.3
		- Fixed Pandaria spells for Siege of Orgrimmar
	v4.25
		- Added support for maximum stacks for alerts
		- Added Pandaria spells for Siege of Orgrimmar
		- Added Pandaria spells for Pandaria (world)
	v4.26
		- Updated PowerAuras integration
		- Added Pandaria spells for Siege of Orgrimmar
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Darkmoon Faire
	v4.26.1
		- Added Pandaria spells for Siege of Orgrimmar
		- Added Pandaria spells for Brawler's Guild
	v4.27
		- Updated PowerAuras integration
		- Added Pandaria spells for Siege of Orgrimmar
	v4.27.1
		- Added Pandaria spells for Siege of Orgrimmar (Heroic)
		- Added Pandaria spells for Feast of Winter Veil
	v4.27.2
		- Added Pandaria spells for Siege of Orgrimmar (Heroic)
	v4.28
		- Fixed a bug with GTFO options causing Trivial damage filters to stop working
		- Added Pandaria spells for Siege of Orgrimmar (Heroic)
		- Updated spells for Love is in the Air
	v4.29
		- Updated for patch 5.4.7, resolved communication issues
		- Raised default trivial % from .5% HP (200+ ticks to death) to 2% of HP (50+ ticks to death)
		- Trivial slider increments in .5% intervals with .5% as the minimum
		- /gtfo options now opens directly to the options frame
		- Added Pandaria spells for Pandaria (world)
	v4.30
		- Disabled tank alerts when soloing
		- Added Pandaria spells for Pandaria (world)
		- Added Pandaria spells for Siege of Orgrimmar (Heroic)
	v4.30.1
		- Added Pandaria spells for Siege of Orgrimmar (Heroic)
	v4.30.2
		- Added and fixed Pandaria spells for Siege of Orgrimmar (Heroic)
		- Added Pandaria spells for Gate of the Setting Sun

]]--
GTFO = {
	DefaultSettings = {
		Active = true;
		Sounds = { true, true, true, true };
		ScanMode = nil;
		DebugMode = nil; -- Turn on debug alerts
		TestMode = nil; -- Activate alerts for events marked as "test only"
		UnmuteMode = nil;
		TrivialMode = nil;
		NoVersionReminder = nil;
		Volume = 3; -- Volume setting, 3 = default
		IgnoreOptions = { };
		TrivialDamagePercent = 2; -- Minimum % of HP lost required for an alert to be trivial
	};
	Version = "4.30.1a"; -- Version number (text format)
	VersionNumber = 43001; -- Numeric version number for checking out-of-date clients
	DataLogging = nil; -- Indicate whether or not the addon needs to run the datalogging function (for hooking)
	DataCode = "4"; -- Saved Variable versioning, change this value to force a reset to default
	CanTank = nil; -- The active character is capable of tanking
	TankMode = nil; -- The active character is a tank
	SpellName = { }; -- List of spells (legacy placeholder, not supported)
	SpellID = { }; -- List of spell IDs
	FFSpellID = { }; -- List of friendly fire spell IDs
	IgnoreSpellCategory = { }; -- List of spell groups to ignore
	IgnoreScan = { }; -- List of spell groups to ignore during scans
	MobID = { }; -- List of mob IDs for melee attack detection
	GroupGUID = { }; -- List of GUIDs of members in your group
	UpdateFound = nil; -- Upgrade available?
	IgnoreTimeAmount = .2; -- Number of seconds between alert sounds
	IgnoreTime = nil;
	IgnoreUpdateTimeAmount = 5; -- Number of seconds between sending out version updates
	IgnoreUpdateTime = nil;
	IgnoreUpdateRequestTimeAmount = 90; -- Number of seconds between sending out version update requests
	IgnoreUpdateRequestTime = nil;
	Events = { }; -- Event queue
	Users = { }; -- User version database
	Sounds = { }; -- Sound Files
	SoundSettings = { }; -- CVARs for temporary muting
	SoundTimes = { .5, .3, .4, .5 }; -- Length of sound files in seconds (for auto-unmute)
	PartyMembers = 0;
	RaidMembers = 0;
	PowerAuras = nil; -- PowerAuras Integration enabled
	WeakAuras = nil; -- WeakAuras Integration enabled
	Recount = nil; -- Recount Integration enabled
	Skada = nil; -- Skada Integration enabled
	ShowAlert = nil;
	Settings = { };
	UIRendered = nil;
	VariableStore = { -- Variable storage for special circumstances
		StackCounter = 0;
		DisableGTFO = nil;
	};
	BetaMode = nil; -- WoW Beta client detection
};

GTFOData = {};

--[[
if (select(4, GetBuildInfo()) >= 50200) then
	GTFO.BetaMode = true;
end
]]--

StaticPopupDialogs["GTFO_POPUP_MESSAGE"] = {
	preferredIndex = 3,
	text = GTFOLocal.LoadingPopup_Message,
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		GTFO_Command_Options()
	end,
	OnCancel = function()
		GTFO_ChatPrint(string.format(GTFOLocal.ClosePopup_Message," |cFFFFFFFF/gtfo options|r"))
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
};	

function GTFO_ChatPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 0.25, 1.0, 0.25);
end

function GTFO_ErrorPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 1.0, 0.5, 0.5);
end

function GTFO_DebugPrint(str)
	if (GTFO.Settings.DebugMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 0.75, 1.0, 0.25);
	end
end

function GTFO_ScanPrint(str)
	if (GTFO.Settings.ScanMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..str, 0.5, 0.5, 0.85);
	end
end

function GTFO_GetMobId(GUID)
    if not GUID then return 0 end
    return tonumber(GUID:sub(6, 10), 16) or 0
end

function GTFO_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") then
		RegisterAddonMessagePrefix("GTFO");
		if (GTFOData.DataCode ~= GTFO.DataCode) then
			GTFO_SetDefaults();
                        --163uiedit
			--GTFO_ChatPrint(string.format(GTFOLocal.Loading_NewDatabase, GTFO.Version));
			--GTFO_DisplayConfigPopupMessage();
		end
		GTFO.Settings = {
			Active = GTFOData.Active;
			Sounds = { GTFOData.Sounds[1], GTFOData.Sounds[2], GTFOData.Sounds[3], GTFOData.Sounds[4] };
			ScanMode = GTFOData.ScanMode;
			DebugMode = GTFOData.DebugMode;
			TestMode = GTFOData.TestMode;
			UnmuteMode = GTFOData.UnmuteMode;
			TrivialMode = GTFOData.TrivialMode;
			NoVersionReminder = GTFOData.NoVersionReminder;
			Volume = GTFOData.Volume;
			TrivialDamagePercent = GTFOData.TrivialDamagePercent or GTFO.DefaultSettings.TrivialDamagePercent;
			IgnoreOptions = { };
		};
		if (GTFOData.IgnoreOptions) then
			for key, option in pairs(GTFOData.IgnoreOptions) do
				GTFO.Settings.IgnoreOptions[key] = GTFOData.IgnoreOptions[key];
			end
		end

		GTFO_RenderOptions();
		GTFO_SaveSettings();
		GTFO_AddEvent("RefreshOptions", .1, function() GTFO_RefreshOptions(); end);

		-- Power Auras Integration
		if (IsAddOnLoaded("PowerAuras")) then
			local PowaAurasEnabled
			if (PowaAuras_GlobalTrigger) then
				PowaAurasEnabled = PowaAuras_GlobalTrigger()
			end
			-- Power Auras 5.x
			if (PowaAuras and PowaAuras.MarkAuras) then
				GTFO.PowerAuras = true;
			-- Power Auras 4.24.2+
			elseif (PowaAurasEnabled) then
				GTFO.PowerAuras = true;
			-- Power Auras 4.x
			elseif (PowaAuras and PowaAuras.AurasByType) then
				if (PowaAuras.AurasByType.GTFOHigh) then
					GTFO.PowerAuras = true;
				else
                                        --163uiedit
					--GTFO_ChatPrint(GTFOLocal.Loading_PowerAurasOutOfDate);
				end
			else
				GTFO_ChatPrint(GTFOLocal.Loading_PowerAurasOutOfDate);
			end
		end
		if (IsAddOnLoaded("WeakAuras")) then
			GTFO.WeakAuras = true;
		else
			GTFO_DisplayAura_WeakAuras = nil;
		end
		if not (GTFO.PowerAuras) then
				GTFO_DisplayAura_PowerAuras = nil
		end
		if (GTFO.Settings.Active) then
			--GTFO_ChatPrint(string.format(GTFOLocal.Loading_Loaded, GTFO.Version));
		else
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_LoadedSuspended, GTFO.Version));
		end
		
		-- Recount Integration
		if (IsAddOnLoaded("Recount")) then
			GTFO.Recount = GTFO_Recount();
			GTFO.DataLogging = true;
		else
			GTFO_Recount = nil;
			GTFO_RecordRecount = nil;
		end
		if (IsAddOnLoaded("Skada")) then
			GTFO.Skada = GTFO_Skada();
			GTFO.DataLogging = true;
		else
			GTFO_Skada = nil;
		end
		
		GTFO.Users[UnitName("player")] = GTFO.VersionNumber;
		GTFO_GetSounds();
		GTFO.CanTank = GTFO_CanTankCheck("player");
		if (GTFO.CanTank) then
			GTFO_RegisterTankEvents();
		end
		GTFO.TankMode = GTFO_CheckTankMode()
		GTFO_SendUpdateRequest();
		return;
	end
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		if (GTFO.IgnoreTime and not (GTFO.DataLogging)) then
			if (GetTime() < GTFO.IgnoreTime) then
				-- Alerts are currently being ignored and data logging is off, don't bother with processing anything
				return;
			end
		end

		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, misc1, misc2, misc3, misc4, misc5, misc6, misc7 = ...; 

		local SpellType = tostring(eventType);
		local vehicle = nil;

		if (GTFO.VariableStore.DisableGTFO) then
			if GTFO_FindEvent("ReshapeLife") then
				if (GTFO_HasDebuff("player", 122784)) then
					GTFO_AddEvent("ReshapeLife", 5);
				end
				return;
			end
			GTFO.VariableStore.DisableGTFO = nil;
		end
	
		if (destGUID ~= UnitGUID("player")) then
			-- Damage happened to someone/something other than the player
			if (destGUID == UnitGUID("vehicle")) then
				-- Player's vehicle is targetted, not the player
				vehicle = true;
			else
				if (sourceGUID == UnitGUID("player")) then
					-- Player was the source of event, but not the target
					if (SpellType=="SPELL_DAMAGE") then
						local SpellID = tonumber(misc1);
						local SpellName = tostring(misc2);
						local SpellSourceGUID = tostring(sourceGUID);
						SpellID = tostring(SpellID);
						--GTFO_ScanPrint(SpellType.." - "..SpellID.." - "..SpellName.." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName));
						if (GTFO.FFSpellID[SpellID]) then
							-- Friendly fire alerts
							if not (tContains(GTFO.GroupGUID, destGUID)) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Damage wasn't a raid member");
								return;
							end
							if (GTFO.FFSpellID[SpellID].test and not GTFO.Settings.TestMode) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Test mode off");
								-- Test mode is off, ignore
								return;
							end
							if (GTFO.FFSpellID[SpellID].trivialLevel and not GTFO.Settings.TrivialMode and GTFO.FFSpellID[SpellID].trivialLevel <= UnitLevel("player")) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Trivial spell - Level");
								-- Trivial mode is off, ignore trivial spell
								return;
							end
							if (GTFO.FFSpellID[SpellID].ignoreSelfInflicted and destGUID == UnitGUID("player")) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore self inflicted");
								-- Self-inflicted wound and "Ignore Self Inflicated" is set
								return;
							end
							local damage = tonumber(misc4) or 0
							if ((GTFO.FFSpellID[SpellID].trivialPercent or 0) >= 0 and not GTFO.FFSpellID[SpellID].alwaysAlert and not GTFO.Settings.TrivialMode) then
								local damagePercent = tonumber((damage * 100) / UnitHealthMax("player"));
							 	if (((GTFO.FFSpellID[SpellID].trivialPercent or 0) == 0 and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) or (GTFO.FFSpellID[SpellID].trivialPercent and GTFO.FFSpellID[SpellID].trivialPercent > 0 and damagePercent < GTFO.FFSpellID[SpellID].trivialPercent)) then
									--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Trivial spell - Damage %");
									-- Trivial mode is off, ignore trivial spell based on damage %
									return;
								end
							end

							if (GTFO.FFSpellID[SpellID].test) then
								GTFO_ScanPrint("TEST ALERT: Spell ID #"..SpellID);
							end
							alertID = GTFO_GetAlertID(GTFO.FFSpellID[SpellID], "player");
							GTFO_PlaySound(alertID);
							GTFO_RecordStats(alertID, SpellID, SpellName, tonumber(damage), nil);
						end
					end
				end
				return;
			end
		end
		if (SpellType == "ENVIRONMENTAL_DAMAGE") then
			local environment = string.upper(tostring(misc1))
			local damage = tonumber(misc2) or 0
			local damagePercent = tonumber((damage * 100) / UnitHealthMax("player"))
			-- Environmental detection
			GTFO_ScanPrint(SpellType.." - "..environment);
			local alertID;
			if (environment == "DROWNING") then
				alertID = 1;
			elseif (environment == "FATIGUE") then
				if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Fatigue"]) then
					-- Fatigue being ignored
					--GTFO_DebugPrint("Won't alert FATIGUE - Manually ignored");
					return;
				end
				alertID = 1;
			elseif (environment == "LAVA") then
				alertID = 2;
				if (GTFO_HasDebuff("player", 81118) or GTFO_HasDebuff("player", 94073) or GTFO_HasDebuff("player", 94074) or GTFO_HasDebuff("player", 94075) or GTFO_HasDebuff("player", 97151)) then
					-- Magma debuff exception
					--GTFO_DebugPrint("Won't alert LAVA - Magma debuff found");
					return;
				end
				if (not GTFO.Settings.TrivialMode and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) then
					-- Trivial
					--GTFO_DebugPrint("Won't alert LAVA - Trivial");
					return;
				end
			elseif (environment ~= "FALLING") then
				alertID = 2;
				if (not GTFO.Settings.TrivialMode and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) then
					-- Trivial
					--GTFO_DebugPrint("Won't alert "..tostring(environment).." - Trivial");
					return;
				end
			else
				return;
			end
			GTFO_PlaySound(alertID);
			GTFO_RecordStats(alertID, 0, GTFOLocal.Recount_Environmental, tonumber(damage), nil);
			return;
		elseif (SpellType=="SPELL_PERIODIC_DAMAGE" or SpellType=="SPELL_DAMAGE" or SpellType=="SPELL_MISSED" or SpellType=="SPELL_PERIODIC_MISSED" or SpellType=="SPELL_ENERGIZE" or SpellType=="SPELL_INSTAKILL" or ((SpellType=="SPELL_AURA_APPLIED" or SpellType=="SPELL_AURA_APPLIED_DOSE" or SpellType=="SPELL_AURA_REFRESH") and misc4=="DEBUFF")) then
			-- Spell detection
			local SpellID = tonumber(misc1);
			local SpellName = tostring(misc2);
			local SpellSourceGUID = tostring(sourceGUID);
			local SpellSourceName = tostring(sourceName);
			local damage = tonumber(misc4) or 0

			-- Special exception for Onyxia Breath's and her stupid 92 different spell IDs
			if ((SpellID > 17086 and SpellID <= 17097) or (SpellID >= 18351 and SpellID <= 18361) or (SpellID >= 18564 and SpellID <= 18607) or SpellID == 18609 or (SpellID >= 18611 and SpellID <= 18628)) then
				SpellID = 17086;
			end
			
			SpellID = tostring(SpellID);

			if (GTFO.Settings.ScanMode and not GTFO.IgnoreScan[SpellID]) then
				if (vehicle) then
					GTFO_ScanPrint("V: "..SpellType.." - "..SpellID.." - "..GetSpellLink(SpellID).." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName));
				elseif (SpellType~="SPELL_ENERGIZE" or (SpellType=="SPELL_ENERGIZE" and sourceGUID ~= UnitGUID("player"))) then
					GTFO_ScanPrint(SpellType.." - "..SpellID.." - "..GetSpellLink(SpellID).." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName).." for "..tostring(misc4));
				end
			end
			if (GTFO.SpellID[SpellID]) then
				if (GTFO.SpellID[SpellID].category) then
					if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions[GTFO.SpellID[SpellID].category]) then
						-- Spell is being ignored completely
						--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Player activated ignore option: "..GTFO.SpellID[SpellID].category);
						return;						
					end
				end

				if (vehicle and not GTFO.SpellID[SpellID].vehicle) then
					-- Vehicle damage and vehicle mode is not set
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Vehicle not enabled");
					return;
				end
				if (GTFO.SpellID[SpellID].test and not GTFO.Settings.TestMode) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Test mode off");
					-- Experiemental/Beta option is off, ignore
					return;
				end
				if (GTFO.SpellID[SpellID].ignoreEvent and GTFO_FindEvent(GTFO.SpellID[SpellID].ignoreEvent)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore Event ("..GTFO.SpellID[SpellID].ignoreEvent..") is active");
					-- Ignore event code found
					return;
				end
				if (GTFO.SpellID[SpellID].negatingDebuffSpellID and GTFO_HasDebuff("player", GTFO.SpellID[SpellID].negatingDebuffSpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Negating debuff ("..GTFO.SpellID[SpellID].negatingDebuffSpellID..") is active");
					-- Player has a spell negating debuff
					if (GTFO.SpellID[SpellID].negatingIgnoreTime) then
						GTFO_AddEvent("Negate"..SpellID, GTFO.SpellID[SpellID].negatingIgnoreTime);
					end
					return;
				end
				if (GTFO.SpellID[SpellID].negatingBuffSpellID and GTFO_HasBuff("player", GTFO.SpellID[SpellID].negatingBuffSpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Negating buff ("..GTFO.SpellID[SpellID].negatingBuffSpellID..") is active");
					-- Player has a spell negating buff
					if (GTFO.SpellID[SpellID].negatingIgnoreTime) then
						GTFO_AddEvent("Negate"..SpellID, GTFO.SpellID[SpellID].negatingIgnoreTime);
					end
					return;
				end
				if (GTFO.SpellID[SpellID].negatingIgnoreTime and GTFO_FindEvent("Negate"..SpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore Event (Negate"..SpellID..") is active");
					-- Ignore event code found (keep this code after AddEvent triggers so the triggers can continue to refresh)
					return;
				end
				if (GTFO.SpellID[SpellID].affirmingDebuffSpellID and not GTFO_HasDebuff("player", GTFO.SpellID[SpellID].affirmingDebuffSpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Affirming debuff ("..GTFO.SpellID[SpellID].affirmingDebuffSpellID..") is not active");
					-- Player doesn't have spell affirming debuff
					return;
				end
				if (not GTFO.Settings.TrivialMode) then
					if (GTFO.SpellID[SpellID].trivialLevel and GTFO.SpellID[SpellID].trivialLevel <= UnitLevel("player")) then
						--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Trivial spell - Low level");
						-- Trivial mode is off, ignore trivial spell based on level
						return;
					end
					if ((GTFO.SpellID[SpellID].trivialPercent or 0) >= 0 and not GTFO.SpellID[SpellID].alwaysAlert and (SpellType=="SPELL_PERIODIC_DAMAGE" or SpellType=="SPELL_DAMAGE")) then
						local damagePercent = tonumber((damage * 100) / UnitHealthMax("player"));
					 	if (((GTFO.SpellID[SpellID].trivialPercent or 0) == 0 and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) or (GTFO.SpellID[SpellID].trivialPercent and GTFO.SpellID[SpellID].trivialPercent > 0 and damagePercent < GTFO.SpellID[SpellID].trivialPercent)) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Trivial spell - Damage %");
							-- Trivial mode is off, ignore trivial spell based on damage %
							return;
						end
					end
				end
				if (GTFO.SpellID[SpellID].specificMobs and not tContains(GTFO.SpellID[SpellID].specificMobs, GTFO_GetMobId(sourceGUID))) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Mob isn't on the list");
					-- Mob isn't on the list, ignore spell
					return;
				end
				if ((SpellType == "SPELL_MISSED" or SpellType == "SPELL_PERIODIC_MISSED") and not GTFO.SpellID[SpellID].alwaysAlert) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Spell missed & always alert off");
					-- Always Alert is off, ignore missed spell
					return;
				end
				if (GTFO.SpellID[SpellID].applicationOnly) then
					if (GTFO.SpellID[SpellID].minimumStacks or GTFO.SpellID[SpellID].maximumStacks) then
						if (SpellType ~= "SPELL_AURA_APPLIED_DOSE" or not misc5) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only w/ minimum stacks & not a dosage event");
							-- Not a dose application event
							return;
						end
						local stacks = tonumber(misc5);
						if (GTFO.SpellID[SpellID].minimumStacks and stacks <= tonumber(GTFO.SpellID[SpellID].minimumStacks)) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only w/ minimum stacks & not enough stacks");
							-- Not enough stacks
							return;
						elseif (GTFO.SpellID[SpellID].maximumStacks and stacks >= tonumber(GTFO.SpellID[SpellID].maximumStacks)) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only w/ maximum stacks & too many stacks");
							-- Too many stacks
							return;
						end
					elseif (not (SpellType == "SPELL_AURA_APPLIED" or SpellType == "SPELL_AURA_APPLIED_DOSE" or SpellType == "SPELL_AURA_REFRESH")) then
						--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only & non-application event");
						-- Application Only is set and this was a non-application event
						return;
					end
				end
				if (GTFO.SpellID[SpellID].ignoreSelfInflicted and SpellSourceGUID == UnitGUID("player")) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore self inflicted");
					-- Self-inflicted wound and "Ignore Self Inflicated" is set
					return;
				end
				if (GTFO.SpellID[SpellID].damageMinimum and GTFO.SpellID[SpellID].damageMinimum > damage) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Minimum damage amount not exceeded");
					-- Not enough damage was caused
					return;
				end
				alertID = GTFO_GetAlertID(GTFO.SpellID[SpellID], "player");
				if (GTFO.SpellID[SpellID].test) then
					GTFO_ScanPrint("TEST ALERT: Spell ID #"..SpellID);
				end
				GTFO_PlaySound(alertID);
				if (SpellType == "SPELL_PERIODIC_DAMAGE" or SpellType == "SPELL_DAMAGE" or SpellType == "SPELL_ENERGIZE") then
					GTFO_RecordStats(alertID, SpellID, SpellName, damage, SpellSourceName);
				else
					GTFO_RecordStats(alertID, SpellID, "+"..SpellName, 0, SpellSourceName);
				end
				return;
			end
		elseif (SpellType=="SWING_DAMAGE" or SpellType=="SWING_MISSED") then
			-- Melee hit detection
			local SourceMobID = tostring(GTFO_GetMobId(sourceGUID));
			if (GTFO.MobID[SourceMobID]) then
				if (GTFO.MobID[SourceMobID].test and not GTFO.Settings.TestMode) then
					return;
				end
				if (GTFO.MobID[SourceMobID].trivialLevel and not GTFO.Settings.TrivialMode and GTFO.MobID[SourceMobID].trivialLevel <= UnitLevel("player")) then
					-- Trivial mode is off, ignore trivial mob
					return;
				end
				if (SpellType=="SWING_DAMAGE") then
					local damage = tonumber(misc1) or 0
					if (damage > 0 or not GTFO.MobID[SourceMobID].damageOnly) then
						alertID = GTFO_GetAlertID(GTFO.MobID[SourceMobID], "player");
						GTFO_PlaySound(alertID);
						GTFO_RecordStats(alertID, 6603, sourceName, tonumber(damage), nil);
						return;						
					end
				elseif (not GTFO.MobID[SourceMobID].damageOnly and SpellType=="SWING_MISSED") then
					alertID = GTFO_GetAlertID(GTFO.MobID[SourceMobID], "player");
					GTFO_PlaySound(alertID);
					GTFO_RecordStats(alertID, 6603, sourceName, 0, nil);
					return;						
				end
			end
		end
		return;
	end
	if (event == "MIRROR_TIMER_START") then
		-- Fatigue bar warning
		local sType, iValue, iMaxValue, iScale, bPaused, sLabel = ...;
		if (sType == "EXHAUSTION" and iScale < 0) then
			if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Fatigue"]) then
				-- Fatigue being ignored
				--GTFO_DebugPrint("Won't alert FATIGUE - Manually ignored");
				return;
			end
			GTFO_PlaySound(1);
		end
		return;
	end
	if (event == "CHAT_MSG_ADDON") then
		local msgPrefix, msgMessage, msgType, msgSender = ...;
		if (msgPrefix == "GTFO" and msgMessage and msgMessage ~= "") then
			local iSlash = string.find(msgMessage,":",1);
			if (iSlash) then
				local sCommand = string.sub(msgMessage,1,iSlash - 1);
				local sValue = string.sub(msgMessage,iSlash + 1);
				if (sCommand == "V" and sValue) then
					-- Version update received
					--GTFO_DebugPrint(msgSender.." sent version info '"..sValue.."' to "..msgType);
					if (not GTFO.Users[msgSender]) then
						GTFO_SendUpdate(msgType);
					end
					GTFO.Users[msgSender] = sValue;
					if ((tonumber(sValue) > GTFO.VersionNumber) and not GTFO.UpdateFound) then
						GTFO.UpdateFound = GTFO_ParseVersionNumber(sValue);
						if (not GTFO.Settings.NoVersionReminder) then
                                                --163uiedit
						--GTFO_ChatPrint(string.format(GTFOLocal.Loading_OutOfDate, GTFO.UpdateFound));
						end
					end
					return;
				elseif (sCommand == "U" and sValue) then
					-- Version Request
					--GTFO_DebugPrint(msgSender.." requested update to "..sValue);
					GTFO_SendUpdate(sValue);
					return;
				end
			end
		end
		return;
	end
	if (event == "GROUP_ROSTER_UPDATE") then
		--GTFO_DebugPrint("Group roster was updated");
		local sentUpdate = nil;
		GTFO_ScanGroupGUID();
		local PartyMembers = GetNumSubgroupMembers();
		if (PartyMembers > GTFO.PartyMembers and GTFO.RaidMembers == 0) then
			if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
				GTFO_SendUpdate("INSTANCE_CHAT");
			else
				GTFO_SendUpdate("PARTY");
			end
			sentUpdate = true;
		end
		GTFO.PartyMembers = PartyMembers;

		local RaidMembers = GetNumGroupMembers();		
		if (not IsInRaid()) then
			RaidMembers = 0
		end

		if (RaidMembers > GTFO.RaidMembers) then
			if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
				if (not sentUpdate) then
					GTFO_SendUpdate("INSTANCE_CHAT");
				end
			else
				GTFO_SendUpdate("RAID");
			end
		end
		GTFO.RaidMembers = RaidMembers;		
		return;
	end
	if (event == "UNIT_INVENTORY_CHANGED") then
		local msgUnit = ...;
		if (UnitIsUnit(msgUnit, "PLAYER")) then
			--GTFO_DebugPrint("Inventory changed, check tank mode");
			GTFO.TankMode = GTFO_CheckTankMode();
		end
		return;
	end
	if (event == "UPDATE_SHAPESHIFT_FORM") then
		--GTFO_DebugPrint("Form changed, check tank mode");
		GTFO.TankMode = GTFO_CheckTankMode();
		return;
	end
	if (event == "CHAT_MSG_MONSTER_YELL") then
		local msgBoss = ...;
		if (msgBoss == GTFOLocal.Boss_Nefarian_Phase2) then
			GTFO_AddEvent("NefarianIgnoreMagma", 17); -- 17 seconds from Nefarian's warning to getting on the pillar
		end
		return;
	end
end

function GTFO_ScanGroupGUID()
	GTFO.GroupGUID = { };
	local partyMembers, raidMembers;
	raidMembers = GetNumGroupMembers();
	partyMembers = GetNumSubgroupMembers();
	if (not IsInRaid()) then
		raidMembers = 0
	end
	if (raidMembers > 0) then
		for i = 1, raidMembers, 1 do
			if not (UnitIsUnit("raid"..i, "player")) then
				tinsert(GTFO.GroupGUID, UnitGUID("raid"..i));
			end;
		end
	end
	if (partyMembers > 0) then
		for i = 1, partyMembers, 1 do
			if not (UnitIsUnit("party"..i, "player")) then
				tinsert(GTFO.GroupGUID, UnitGUID("party"..i));
			end;
		end
	end
end

function GTFO_Command(arg1)
	local Command = string.upper(arg1);
	local DescriptionOffset = string.find(arg1,"%s",1);
	local Description = nil;
	
	if (DescriptionOffset) then
		Command = string.upper(string.sub(arg1, 1, DescriptionOffset - 1));
		Description = tostring(string.sub(arg1, DescriptionOffset + 1));
	end
	
	--GTFO_DebugPrint("Command executed: "..Command);
	
	if (Command == "OPTION" or Command == "OPTIONS") then
		GTFO_Command_Options();
	elseif (Command == "STANDBY") then
		GTFO_Command_Standby();
	elseif (Command == "DEBUG") then
		GTFO_Command_Debug();
	elseif (Command == "SCAN" or Command == "SCANNER") then
		GTFO_Command_Scan();
	elseif (Command == "TESTMODE") then
		GTFO_Command_TestMode();
	elseif (Command == "VERSION") then
		GTFO_Command_Version();
	elseif (Command == "TEST") then
		if (DescriptionOffset) then
			GTFO_Command_Test(tonumber(Description));
		else
			GTFO_Command_Test(1);
		end
	elseif (Command == "TEST1") then
		GTFO_Command_Test(1);
	elseif (Command == "TEST2") then
		GTFO_Command_Test(2);
	elseif (Command == "TEST3") then
		GTFO_Command_Test(3);
	elseif (Command == "TEST4") then
		GTFO_Command_Test(4);
	elseif (Command == "NOVERSION") then
		GTFO_Command_VersionReminder();
	elseif (Command == "HELP" or Command == "") then
		GTFO_Command_Help();
	else
		GTFO_Command_Help();
	end
end

function GTFO_Command_Test(iSound)
	if (iSound == 1) then
		GTFO_PlaySound(1);
		if (GTFO.Settings.Sounds[1]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_High);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_HighMuted);		
		end
	elseif (iSound == 2) then
		GTFO_PlaySound(2);
		if (GTFO.Settings.Sounds[2]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Low);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_LowMuted);		
		end
	elseif (iSound == 3) then			
		GTFO_PlaySound(3);
		if (GTFO.Settings.Sounds[3]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Fail);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FailMuted);		
		end
	elseif (iSound == 4) then			
		GTFO_PlaySound(4);
		if (GTFO.Settings.Sounds[4]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_FriendlyFire);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FriendlyFireMuted);		
		end
	end
end

function GTFO_Command_Debug()
	if (GTFO.Settings.DebugMode) then
		GTFO.Settings.DebugMode = nil;
		GTFO_ChatPrint("Debug mode off.");
	else
		GTFO.Settings.DebugMode = true;
		GTFO_ChatPrint("Debug mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_Scan()
	if (GTFO.Settings.ScanMode) then
		GTFO.Settings.ScanMode = nil;
		GTFO_ChatPrint("Scan mode off.");
	else
		GTFO.Settings.ScanMode = true;
		GTFO_ChatPrint("Scan mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_TestMode()
	if (GTFO.Settings.TestMode) then
		GTFO.Settings.TestMode = nil;
		GTFO_ChatPrint("Test mode off.");
	else
		GTFO.Settings.TestMode = true;
		GTFO_ChatPrint("Test mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_Standby()
	if (GTFO.Settings.Active) then
		GTFO.Settings.Active = nil;
		GTFO_ChatPrint(GTFOLocal.Active_Off);
	else
		GTFO.Settings.Active = true;
		GTFO_ChatPrint(GTFOLocal.Active_On);
	end
	GTFO_SaveSettings();
	GTFO_ActivateMod();
end

function GTFO_Command_VersionReminder()
	if (GTFO.Settings.NoVersionReminder) then
		GTFO.Settings.NoVersionReminder = nil;
		GTFO_ChatPrint(GTFOLocal.Version_On);
	else
		GTFO.Settings.NoVersionReminder = true;
		GTFO_ChatPrint(GTFOLocal.Version_Off);
	end
	GTFO_SaveSettings();
end

function GTFO_OnLoad()
	GTFOFrame:RegisterEvent("VARIABLES_LOADED");
	GTFOFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
	GTFOFrame:RegisterEvent("CHAT_MSG_ADDON");
	GTFOFrame:RegisterEvent("MIRROR_TIMER_START");
	GTFOFrame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	SlashCmdList["GTFO"] = GTFO_Command;
	SLASH_GTFO1 = "/GTFO";
end

function GTFO_PlaySound(iSound, bOverride)
	if ((iSound or 0) == 0) then
		return;
	end
	
	local currentTime = GetTime();
	if (GTFO.IgnoreTime) then
		if (currentTime < GTFO.IgnoreTime) then
			return;
		end
	end
	GTFO.IgnoreTime = currentTime + GTFO.IgnoreTimeAmount;

	if (bOverride or GTFO.Settings.Sounds[iSound]) then
		if (bOverride and getglobal("GTFO_UnmuteButton"):GetChecked()) then
			GTFO_UnmuteSound(GTFO.SoundTimes[iSound]);
		elseif (GTFO.Settings.UnmuteMode and GTFO.SoundTimes[iSound] and not bOverride) then
			GTFO_UnmuteSound(GTFO.SoundTimes[iSound]);
		end
		PlaySoundFile(GTFO.Sounds[iSound], "Master");
		if (GTFO.Settings.Volume >= 4) then
			PlaySoundFile(GTFO.Sounds[iSound], "Master");
		end
		if (GTFO.Settings.Volume >= 5) then
			PlaySoundFile(GTFO.Sounds[iSound], "Master");
		end
	end
	GTFO_DisplayAura(iSound);
end

-- Create Addon Menu options and interface
function GTFO_RenderOptions()
	GTFO.UIRendered = true;

	local ConfigurationPanel = CreateFrame("FRAME","GTFO_MainFrame");
	ConfigurationPanel.name = "GTFO";
	InterfaceOptions_AddCategory(ConfigurationPanel);

	local IntroMessageHeader = ConfigurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
	IntroMessageHeader:SetPoint("TOPLEFT", 10, -10);
	IntroMessageHeader:SetText("GTFO "..GTFO.Version);

	local EnabledButton = CreateFrame("CheckButton", "GTFO_EnabledButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	EnabledButton:SetPoint("TOPLEFT", 10, -35)
	EnabledButton.tooltip = GTFOLocal.UI_EnabledDescription;
	getglobal(EnabledButton:GetName().."Text"):SetText(GTFOLocal.UI_Enabled);

	local HighSoundButton = CreateFrame("CheckButton", "GTFO_HighSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	HighSoundButton:SetPoint("TOPLEFT", 10, -65)
	HighSoundButton.tooltip = GTFOLocal.UI_HighDamageDescription;
	getglobal(HighSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_HighDamage);

	local LowSoundButton = CreateFrame("CheckButton", "GTFO_LowSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	LowSoundButton:SetPoint("TOPLEFT", 10, -95)
	LowSoundButton.tooltip = GTFOLocal.UI_LowDamageDescription;
	getglobal(LowSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_LowDamage);

	local FailSoundButton = CreateFrame("CheckButton", "GTFO_FailSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	FailSoundButton:SetPoint("TOPLEFT", 10, -125)
	FailSoundButton.tooltip = GTFOLocal.UI_FailDescription;
	getglobal(FailSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_Fail);

	local FriendlyFireSoundButton = CreateFrame("CheckButton", "GTFO_FriendlyFireSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	FriendlyFireSoundButton:SetPoint("TOPLEFT", 10, -155)
	FriendlyFireSoundButton.tooltip = GTFOLocal.UI_FriendlyFireDescription;
	getglobal(FriendlyFireSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_FriendlyFire);

	local HighTestButton = CreateFrame("Button", "GTFO_HighTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	HighTestButton:SetPoint("TOPLEFT", 300, -65);
	HighTestButton.tooltip = GTFOLocal.UI_TestDescription;
	HighTestButton:SetScript("OnClick",GTFO_Option_HighTest);
	getglobal(HighTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local LowTestButton = CreateFrame("Button", "GTFO_LowTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	LowTestButton:SetPoint("TOPLEFT", 300, -95);
	LowTestButton.tooltip = GTFOLocal.UI_TestDescription;
	LowTestButton:SetScript("OnClick",GTFO_Option_LowTest);
	getglobal(LowTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local FailTestButton = CreateFrame("Button", "GTFO_FailTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	FailTestButton:SetPoint("TOPLEFT", 300, -125);
	FailTestButton.tooltip = GTFOLocal.UI_TestDescription;
	FailTestButton:SetScript("OnClick",GTFO_Option_FailTest);
	getglobal(FailTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local FriendlyFireTestButton = CreateFrame("Button", "GTFO_FriendlyFireTestButton", ConfigurationPanel, "OptionsButtonTemplate");
	FriendlyFireTestButton:SetPoint("TOPLEFT", 300, -155);
	FriendlyFireTestButton.tooltip = GTFOLocal.UI_TestDescription;
	FriendlyFireTestButton:SetScript("OnClick",GTFO_Option_FriendlyFireTest);
	getglobal(FriendlyFireTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

	local VolumeText = ConfigurationPanel:CreateFontString("GTFO_VolumeText","ARTWORK","GameFontNormal");
	VolumeText:SetPoint("TOPLEFT", 170, -195);
	VolumeText:SetText("");

	local VolumeSlider = CreateFrame("Slider", "GTFO_VolumeSlider", ConfigurationPanel, "OptionsSliderTemplate");
	VolumeSlider:SetPoint("TOPLEFT", 12, -195);
	VolumeSlider.tooltip = GTFOLocal.UI_VolumeDescription;
	VolumeSlider:SetScript("OnValueChanged",GTFO_Option_SetVolume);
	getglobal(GTFO_VolumeSlider:GetName().."Text"):SetText(GTFOLocal.UI_Volume);
	getglobal(GTFO_VolumeSlider:GetName().."High"):SetText(GTFOLocal.UI_VolumeMax);
	getglobal(GTFO_VolumeSlider:GetName().."Low"):SetText(GTFOLocal.UI_VolumeMin);
	VolumeSlider:SetMinMaxValues(1,5);
	VolumeSlider:SetValueStep(1);
	VolumeSlider:SetValue(GTFO.Settings.Volume);
	GTFO_Option_SetVolumeText(GTFO.Settings.Volume);
	
	local UnmuteButton = CreateFrame("CheckButton", "GTFO_UnmuteButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	UnmuteButton:SetPoint("TOPLEFT", 10, -240)
	UnmuteButton.tooltip = GTFOLocal.UI_UnmuteDescription.."\n\n("..GTFOLocal.UI_UnmuteDescription2..")";
	getglobal(UnmuteButton:GetName().."Text"):SetText(GTFOLocal.UI_Unmute);

	local TrivialButton = CreateFrame("CheckButton", "GTFO_TrivialButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	TrivialButton:SetPoint("TOPLEFT", 10, -270)
	TrivialButton.tooltip = GTFOLocal.UI_TrivialDescription.."\n\n"..GTFOLocal.UI_TrivialDescription2;
	getglobal(TrivialButton:GetName().."Text"):SetText(GTFOLocal.UI_Trivial);

	local TrivialDamageText = ConfigurationPanel:CreateFontString("GTFO_TrivialDamageText","ARTWORK","GameFontNormal");
	TrivialDamageText:SetPoint("TOPLEFT", 450, -270);
	TrivialDamageText:SetText("");

	local TrivialDamageSlider = CreateFrame("Slider", "GTFO_TrivialDamageSlider", ConfigurationPanel, "OptionsSliderTemplate");
	TrivialDamageSlider:SetPoint("TOPLEFT", 300, -270);
	TrivialDamageSlider.tooltip = GTFOLocal.UI_TrivialSlider;
	TrivialDamageSlider:SetScript("OnValueChanged",GTFO_Option_SetTrivialDamage);
	getglobal(GTFO_TrivialDamageSlider:GetName().."Text"):SetText(GTFOLocal.UI_TrivialSlider);
	getglobal(GTFO_TrivialDamageSlider:GetName().."High"):SetText(" ");
	getglobal(GTFO_TrivialDamageSlider:GetName().."Low"):SetText(" ");
	TrivialDamageSlider:SetMinMaxValues(.5,10);
	TrivialDamageSlider:SetValueStep(.5);
	TrivialDamageSlider:SetValue(GTFO.Settings.TrivialDamagePercent);
	GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent);

	local TestModeButton = CreateFrame("CheckButton", "GTFO_TestModeButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
	TestModeButton:SetPoint("TOPLEFT", 10, -300)
	TestModeButton.tooltip = GTFOLocal.UI_TestModeDescription.."\n\n"..string.format(GTFOLocal.UI_TestModeDescription2,"zensunim","gmail","com");
	getglobal(TestModeButton:GetName().."Text"):SetText(GTFOLocal.UI_TestMode);

	-- Special Alerts frame

	local IgnoreOptionsPanel = CreateFrame("FRAME","GTFO_IgnoreOptionsFrame");
	IgnoreOptionsPanel.name = GTFOLocal.UI_SpecialAlerts;
	IgnoreOptionsPanel.parent = ConfigurationPanel.name;
	InterfaceOptions_AddCategory(IgnoreOptionsPanel);

	local IntroMessageHeader2 = IgnoreOptionsPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
	IntroMessageHeader2:SetPoint("TOPLEFT", 10, -10);
	IntroMessageHeader2:SetText("GTFO "..GTFO.Version.." - "..GTFOLocal.UI_SpecialAlertsHeader);

	local yCount = -20;
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (GTFO.IgnoreSpellCategory[key].spellID) then
			yCount = yCount - 30;

			local IgnoreAlertButton = CreateFrame("CheckButton", "GTFO_IgnoreAlertButton_"..key, IgnoreOptionsPanel, "ChatConfigCheckButtonTemplate");
			IgnoreAlertButton:SetPoint("TOPLEFT", 10, yCount)
			getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
			if (GTFO.IgnoreSpellCategory[key].tooltip) then
				_G["GTFO_IgnoreAlertButton_"..key].tooltip = GTFO.IgnoreSpellCategory[key].tooltip;
			end
		end
	end

	GTFOSpellTooltip:ClearLines();

	-- Confirmation buttons Logic

	ConfigurationPanel.okay = 
		function (self)
			GTFO.Settings.Active = EnabledButton:GetChecked();
			GTFO.Settings.Sounds[1] = HighSoundButton:GetChecked();
			GTFO.Settings.Sounds[2] = LowSoundButton:GetChecked();
			GTFO.Settings.Sounds[3] = FailSoundButton:GetChecked();
			GTFO.Settings.Sounds[4] = FriendlyFireSoundButton:GetChecked();
			GTFO.Settings.Volume = VolumeSlider:GetValue();
			GTFO.Settings.TrivialDamagePercent = TrivialDamageSlider:GetValue();
			GTFO.Settings.TestMode = TestModeButton:GetChecked();
			GTFO.Settings.UnmuteMode = UnmuteButton:GetChecked();
			GTFO.Settings.TrivialMode = TrivialButton:GetChecked();
			for key, option in pairs(GTFO.IgnoreSpellCategory) do
				if (getglobal("GTFO_IgnoreAlertButton_"..key):GetChecked()) then
					GTFO.Settings.IgnoreOptions[key] = nil;
				else
					-- Option unchecked, add to ignore list
					GTFO.Settings.IgnoreOptions[key] = true;
				end
			end

			GTFO_SaveSettings();
		end
	ConfigurationPanel.cancel = 
		function (self)
			VolumeSlider:SetValue(GTFO.Settings.Volume);
			TrivialDamageSlider:SetValue(GTFO.Settings.TrivialDamagePercent);
			GTFO_SaveSettings();
		end
	ConfigurationPanel.default = 
		function (self)
			GTFO_SetDefaults();
		end
end

function GTFO_RefreshOptions()
	-- Spell info isn't available right away, so do this after loading
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (GTFO.IgnoreSpellCategory[key].spellID and not (GetLocale() == "enUS" and GTFO.IgnoreSpellCategory[key].override)) then
			local IgnoreAlertButton = _G["GTFO_IgnoreAlertButton_"..key];
			if (IgnoreAlertButton) then
				local spellID = GTFO.IgnoreSpellCategory[key].spellID;
				local spellName = GetSpellInfo(spellID);
				if (spellName) then
					getglobal(IgnoreAlertButton:GetName().."Text"):SetText(spellName);
				
					GTFOSpellTooltip:SetOwner(_G["GTFOFrame"],"ANCHOR_NONE");
					GTFOSpellTooltip:ClearLines();
					GTFOSpellTooltip:SetHyperlink(GetSpellLink(spellID));
					local tooltipText = tostring(getglobal("GTFOSpellTooltipTextLeft1"):GetText());
					if (GTFOSpellTooltip:NumLines()) then
						if (getglobal("GTFOSpellTooltipTextLeft"..tostring(GTFOSpellTooltip:NumLines()))) then
							tooltipText = tooltipText.."\n"..tostring(getglobal("GTFOSpellTooltipTextLeft"..tostring(GTFOSpellTooltip:NumLines())):GetText());
						end
					end
					IgnoreAlertButton.tooltip = tooltipText;
				else
					getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
				end
			end
		end
	end
end

function GTFO_ActivateMod()
	if (GTFO.Settings.Active) then
		GTFOFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	else
		GTFOFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end	
end

-- Event handling
function GTFO_OnUpdate()
	local currentTime = GetTime();
	
	if (#GTFO.Events > 0) then
		for index, event in pairs(GTFO.Events) do
			if (currentTime > event.ExecuteTime) then
				if (event.Code) then
					event:Code();
				end
				if (event.Repeat > 0) then
					event.ExecuteTime = currentTime + event.Repeat;
					--GTFO_DebugPrint("Repeating event #"..index.." for "..event.Repeat.." seconds.");
				else
					--GTFO_DebugPrint("Removing event #"..index.." - "..event.Name);
					tremove(GTFO.Events, index);
				end				
			end
		end
	end
	
	-- Check for GTFO events
	if (#GTFO.Events <= 0) then
		GTFOFrame:SetScript("OnUpdate", nil);
		--GTFO_DebugPrint("Event update checking disabled.");
	end	
end

function GTFO_UnmuteSound(delayTime)
	if (not GTFO_FindEvent("Mute")) then
		GTFO.SoundSettings.EnableAllSound = GetCVarBool("Sound_EnableAllSound");
		SetCVar("Sound_EnableAllSound", 1);
		--GTFO_DebugPrint("Temporarily unmuting volume for "..delayTime.. " seconds.");
	end
	GTFO_AddEvent("Mute", delayTime, function() GTFO_MuteSound(); end);
end

function GTFO_MuteSound()
	SetCVar("Sound_EnableAllSound", GTFO.SoundSettings.EnableAllSound);
	--GTFO_DebugPrint("Muting sound again.");
end

function GTFO_Command_Help()
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..string.format(GTFOLocal.Help_Intro, GTFO.Version), 0.25, 1.0, 0.25);
	if not (GTFO.Settings.Active) then
		DEFAULT_CHAT_FRAME:AddMessage(GTFOLocal.Help_Suspended, 1.0, 0.1, 0.1);		
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo options|r -- "..GTFOLocal.Help_Options, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo standby|r -- "..GTFOLocal.Help_Suspend, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo version|r -- "..GTFOLocal.Help_Version, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test|r -- "..GTFOLocal.Help_TestHigh, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test2|r -- "..GTFOLocal.Help_TestLow, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test3|r -- "..GTFOLocal.Help_TestFail, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test4|r -- "..GTFOLocal.Help_TestFriendlyFire, 0.25, 1.0, 0.75);
end

function GTFO_Option_HighTest()
	GTFO_PlaySound(1, true);
end

function GTFO_Option_LowTest()
	GTFO_PlaySound(2, true);
end

function GTFO_Option_FailTest()
	GTFO_PlaySound(3, true);
end

function GTFO_Option_FriendlyFireTest()
	GTFO_PlaySound(4, true);
end

-- Get a list of all the people in your group/raid using GTFO and their version numbers
function GTFO_Command_Version()
	GTFO_SendUpdateRequest();
	local partymembers, raidmembers;

	partymembers = GetNumSubgroupMembers();
	raidmembers = GetNumGroupMembers();
	if (not IsInRaid()) then
		raidmembers = 0
	end

	local users = 0;

	if (raidmembers > 0 or partymembers > 0) then
		if (raidmembers > 0) then
			for i = 1, raidmembers, 1 do
				local displayName;
				local name, server = UnitName("raid"..i);
				local fullname = name;
				if (server and server ~= "") then
					fullname = name.."-"..server;
					displayName = fullname;
				else
					fullname = name.."-"..GetRealmName()
					displayName = name;
				end
				if (GTFO.Users[fullname]) then
					GTFO_ChatPrint(displayName..": "..GTFO_ParseVersionColor(GTFO.Users[fullname]));
					users = users + 1;
				else
					GTFO_ChatPrint(displayName..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_RaidMembers, users, raidmembers));
		elseif (partymembers > 0) then
			GTFO_ChatPrint(UnitName("player")..": "..GTFO_ParseVersionColor(GTFO.VersionNumber));
			users = 1;
			for i = 1, partymembers, 1 do
				local displayName;
				local name, server = UnitName("party"..i);
				local fullname = name;
				if (server and server ~= "") then
					fullname = name.."-"..server
					displayName = fullname;
				else
					fullname = name.."-"..GetRealmName()
					displayName = name;
				end
				if (GTFO.Users[fullname]) then
					GTFO_ChatPrint(displayName..": "..GTFO_ParseVersionColor(GTFO.Users[fullname]));
					users = users + 1;
				else
					GTFO_ChatPrint(displayName..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_PartyMembers, users, (partymembers + 1)));
		end
	else
		GTFO_ErrorPrint(GTFOLocal.Group_NotInGroup);
	end		
end

function GTFO_ParseVersionColor(iVersionNumber)
	local Color = "";
	if (GTFO.VersionNumber < iVersionNumber * 1) then
		Color = "|cFFFFFF00"
	elseif (GTFO.VersionNumber == iVersionNumber * 1) then
		Color = "|cFFFFFFFF"
	else
		Color = "|cFFAAAAAA"
	end
	return Color..GTFO_ParseVersionNumber(iVersionNumber).."|r"
end

function GTFO_ParseVersionNumber(iVersionNumber)
	local sVersion = "";
	local iMajor = math.floor(iVersionNumber * 0.0001);
	local iMinor = math.floor((iVersionNumber - (iMajor * 10000)) * 0.01)
	local iMinor2 = iVersionNumber - (iMajor * 10000) - (iMinor * 100)
	if (iMinor2 > 0) then
		sVersion = iMajor.."."..iMinor.."."..iMinor2
	else
		sVersion = iMajor.."."..iMinor
	end
	return sVersion;
end

function GTFO_SendUpdate(sMethod)
	if not (sMethod == "PARTY" or sMethod == "RAID" or sMethod == "INSTANCE_CHAT") then
		return;
	end
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateTime) then
		if (currentTime < GTFO.IgnoreUpdateTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateTime = currentTime + GTFO.IgnoreUpdateTimeAmount;

	--GTFO_DebugPrint("Sending version info to "..sMethod);
	SendAddonMessage("GTFO","V:"..GTFO.VersionNumber,sMethod)
end

function GTFO_SendUpdateRequest()
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateRequestTime) then
		if (currentTime < GTFO.IgnoreUpdateRequestTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateRequestTime = currentTime + GTFO.IgnoreUpdateRequestTimeAmount;

	raidmembers = GetNumGroupMembers();
	partymembers = GetNumSubgroupMembers();
	if (not IsInRaid()) then
		raidmembers = 0
	end
	
	if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
		SendAddonMessage("GTFO","U:INSTANCE_CHAT","INSTANCE_CHAT");
	elseif (raidmembers > 0) then
		SendAddonMessage("GTFO","U:RAID","RAID");
	elseif (partymembers > 0) then
		SendAddonMessage("GTFO","U:PARTY","PARTY");
	end
end

function GTFO_Command_Options()
	InterfaceOptionsFrame_OpenToCategory("GTFO");
	InterfaceOptionsFrame_OpenToCategory("GTFO");
	InterfaceOptionsFrame_OpenToCategory("GTFO");
end

function GTFO_Option_SetVolume()
	if (not GTFO.UIRendered) then
		return;
	end
	GTFO.Settings.Volume = getglobal("GTFO_VolumeSlider"):GetValue() * 1;
	GTFO_GetSounds();
	GTFO_Option_SetVolumeText(GTFO.Settings.Volume)
end

function GTFO_Option_SetVolumeText(iVolume)
	if (iVolume == 1) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeQuiet);
	elseif (iVolume == 2) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeSoft);
	elseif (iVolume == 4) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLoud);
	elseif (iVolume == 5) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLouder);
	elseif (iVolume > 5) then
		getglobal("GTFO_VolumeText"):SetText(iVolume);
	else
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeNormal);
	end
end

function GTFO_Option_SetTrivialDamage()
	if (not GTFO.UIRendered) then
		return;
	end
	GTFO.Settings.TrivialDamagePercent = math.floor(getglobal("GTFO_TrivialDamageSlider"):GetValue() * 10)/10;
	getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.Settings.TrivialDamagePercent);
	GTFO_GetSounds();
	GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent)
end

function GTFO_Option_SetTrivialDamageText(iTrivialDamagePercent)
	if (not GTFO.UIRendered) then
		return;
	end
	getglobal("GTFO_TrivialDamageText"):SetText(iTrivialDamagePercent.."%");
end

-- Detect if the player is tanking or not
function GTFO_CheckTankMode()
	if (GTFO.CanTank) then
		local x, class = UnitClass("player");
		if (class == "PALADIN") then
			-- While it's more obvious to check for Righteous Fury, that ended up being more CPU intensive than desired
			-- Checking for the shield is good enough.
			if (GetInventoryItemID("PLAYER",17)) then
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(GetInventoryItemID("PLAYER",17));
				local itemStats = {};
				if (not itemLink) then
						--GTFO_DebugPrint("Item found, but unable to scan it - Tank mode off for now");
						return nil;						
				end
				itemStats = GetItemStats(itemLink, itemStats);
				for statType, statValue in pairs(itemStats) do
					if (statType == "ITEM_MOD_INTELLECT_SHORT" or statType == "ITEM_MOD_SPIRIT_SHORT") then
						--GTFO_DebugPrint("Healing Shield found - Tank mode off");
						return nil;
					end
				end
				--GTFO_DebugPrint("Tanking Shield found - tank mode activated");
				return true;
			end
		else
			local stance = GetShapeshiftForm();
			if (class == "DRUID") then
				if (stance == 1) then
					--GTFO_DebugPrint("Bear Form found - tank mode activated");
					return true;
				end
			elseif (class == "DEATHKNIGHT") then
				if (stance == 1) then
					--GTFO_DebugPrint("Blood Presence found - tank mode activated");
					return true;
				end
			elseif (class == "WARRIOR") then
				if (stance == 2) then
					--GTFO_DebugPrint("Defensive stance found - tank mode activated");
					return true;
				end
			elseif (class == "MONK") then
				local spec = GetSpecialization();
				if (spec and GetSpecializationRole(spec) == "TANK" and stance == 1) then
					--GTFO_DebugPrint("Ox stance found - tank mode activated");
					return true;
				end
			else
				--GTFO_DebugPrint("Failed Tank Mode - This code shouldn't have ran");
				GTFO.CanTank = nil;
			end
		end
	end
	--GTFO_DebugPrint("Tank mode off");
	return nil;
end

function GTFO_IsTank(target)
	if (GTFO_CanTankCheck(target)) then
		local _, class = UnitClass(target);
		if (class == "PALADIN") then
			-- Check for Righteous Fury
			if (GTFO_HasBuff(target, 25780)) then
				return true;
			end
		elseif (class == "DRUID") then
			-- Check for Bear Form
			if (GTFO_HasBuff(target, 5487)) then
				return true;
			end
		elseif (class == "DEATHKNIGHT") then
			-- Check for Blood Presence
			if (GTFO_HasBuff(target, 48263)) then
				return true;
			end
		elseif (class == "WARRIOR" or class == "MONK") then
			-- No definitive way to determine...take a guess.
			if (UnitGroupRolesAssigned(target) == "TANK" or GetPartyAssignment("MAINTANK", target)) then
				return true;
			end
		end	
	end
	return;
end

function GTFO_CanTankCheck(target)
	local _, class = UnitClass(target);
	if (class == "PALADIN" or class == "DRUID" or class == "DEATHKNIGHT" or class == "WARRIOR" or class == "MONK") then
		----GTFO_DebugPrint("Possible tank detected for "..target);
		return true;
	else
		----GTFO_DebugPrint("This class isn't a tank");
	end
	return;
end

function GTFO_RegisterTankEvents()
	local _, class = UnitClass("player");
	if (class == "PALADIN") then
		GTFOFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	else
		GTFOFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	end
end

-- Cache sound file locations 
function GTFO_GetSounds()
	if (GTFO.Settings.Volume == 2) then
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz.mp3",
		};
	elseif (GTFO.Settings.Volume == 1) then
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz.mp3",
		};
	else	
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.mp3",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz.mp3",
		};
	end
end

-- Save settings to persistant storage, refresh UI options
function GTFO_SaveSettings()
	--GTFO_DebugPrint("Saving settings");
	GTFO_Option_SetVolume();

	GTFOData.DataCode = GTFO.DataCode;
	GTFOData.Active = GTFO.Settings.Active;
	GTFOData.Sounds = { };
	GTFOData.Sounds[1] = GTFO.Settings.Sounds[1];
	GTFOData.Sounds[2] = GTFO.Settings.Sounds[2];
	GTFOData.Sounds[3] = GTFO.Settings.Sounds[3];
	GTFOData.Sounds[4] = GTFO.Settings.Sounds[4];
	GTFOData.Volume = GTFO.Settings.Volume;
	GTFOData.ScanMode = GTFO.Settings.ScanMode;
	GTFOData.DebugMode = GTFO.Settings.DebugMode;
	GTFOData.TestMode = GTFO.Settings.TestMode;
	GTFOData.UnmuteMode = GTFO.Settings.UnmuteMode;
	GTFOData.TrivialMode = GTFO.Settings.TrivialMode;
	GTFOData.TrivialDamagePercent = GTFO.Settings.TrivialDamagePercent
	GTFOData.NoVersionReminder = GTFO.Settings.NoVersionReminder;
	GTFOData.IgnoreOptions = { };
	if (GTFO.Settings.IgnoreOptions) then
		for key, option in pairs(GTFO.Settings.IgnoreOptions) do
			GTFOData.IgnoreOptions[key] = GTFO.Settings.IgnoreOptions[key];
		end
	end
	

	if (GTFO.UIRendered) then
		getglobal("GTFO_EnabledButton"):SetChecked(GTFO.Settings.Active);
		getglobal("GTFO_HighSoundButton"):SetChecked(GTFO.Settings.Sounds[1]);
		getglobal("GTFO_LowSoundButton"):SetChecked(GTFO.Settings.Sounds[2]);
		getglobal("GTFO_FailSoundButton"):SetChecked(GTFO.Settings.Sounds[3]);
		getglobal("GTFO_FriendlyFireSoundButton"):SetChecked(GTFO.Settings.Sounds[4]);
		getglobal("GTFO_TestModeButton"):SetChecked(GTFO.Settings.TestMode);
		getglobal("GTFO_UnmuteButton"):SetChecked(GTFO.Settings.UnmuteMode);
		getglobal("GTFO_TrivialButton"):SetChecked(GTFO.Settings.TrivialMode);

		for key, option in pairs(GTFO.IgnoreSpellCategory) do
			getglobal("GTFO_IgnoreAlertButton_"..key):SetChecked(not GTFO.Settings.IgnoreOptions[key]);
		end
	end
	
	GTFO_ActivateMod();
end

-- Reset all settings to default
function GTFO_SetDefaults()
	GTFO.Settings.Active = GTFO.DefaultSettings.Active;
	GTFO.Settings.Sounds = { };
	GTFO.Settings.Sounds[1] = GTFO.DefaultSettings.Sounds[1];
	GTFO.Settings.Sounds[2] = GTFO.DefaultSettings.Sounds[2];
	GTFO.Settings.Sounds[3] = GTFO.DefaultSettings.Sounds[3];
	GTFO.Settings.Sounds[4] = GTFO.DefaultSettings.Sounds[4];
	GTFO.Settings.Volume = GTFO.DefaultSettings.Volume;
	GTFO.Settings.ScanMode = GTFO.DefaultSettings.ScanMode;
	GTFO.Settings.DebugMode = GTFO.DefaultSettings.DebugMode;
	GTFO.Settings.TestMode = GTFO.DefaultSettings.TestMode;
	GTFO.Settings.UnmuteMode = GTFO.DefaultSettings.UnmuteMode;
	GTFO.Settings.TrivialMode = GTFO.DefaultSettings.TrivialMode;
	GTFO.Settings.NoVersionReminder = GTFO.DefaultSettings.NoVersionReminder;
	GTFO.Settings.TrivialDamagePercent = GTFO.DefaultSettings.TrivialDamagePercent;
	if (GTFO.UIRendered) then
		getglobal("GTFO_VolumeSlider"):SetValue(GTFO.DefaultSettings.Volume);
		getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.DefaultSettings.TrivialDamagePercent);
	end
	GTFO.Settings.IgnoreOptions = GTFO.DefaultSettings.IgnoreOptions;
	GTFO_SaveSettings();
end

-- Show pop-up alert
function GTFO_DisplayConfigPopupMessage()
	StaticPopup_Show("GTFO_POPUP_MESSAGE");
end

function GTFO_HasBuff(target, iSpellID)
	local spellName = GetSpellInfo(tonumber(iSpellID));
	if (spellName and UnitBuff(target, spellName)) then
		return true;
	else
		return nil;
	end
end

function GTFO_HasDebuff(target, iSpellID)
	local spellName = GetSpellInfo(tonumber(iSpellID));
	if (spellName and UnitDebuff(target, spellName)) then
		return true;
	else
		return nil;
	end
end

function GTFO_DebuffStackCount(target, iSpellID)
	local spellName = GetSpellInfo(tonumber(iSpellID));
	if (spellName) then
		local debuffInfo = select(4, UnitDebuff(target, spellName));
		if (debuffInfo) then
			return tonumber(debuffInfo);
		end
	end
	return 0;
end

function GTFO_GetAlertID(alert, target)
	if (alert.soundFunction) then
		return alert:soundFunction();
	end	

	local alertLevel;
	local tankAlert = false;

	if (alert.tankSound) then
		if (UnitIsUnit("player", target)) then
			if (GTFO.TankMode or (GTFO.RaidMembers == 0 and GTFO.PartyMembers == 0)) then
				-- Tank or soloing
				tankAlert = true;
			end
		elseif (GTFO_IsTank(target)) then
			tankAlert = true;
		end
	end
	
	if (tankAlert and alert.tankSound) then
		alertLevel = alert.tankSound;
	else
		alertLevel = alert.sound or 0;
	end
	
	if ((alert.soundLFR or (tankAlert and alert.tankSoundLFR)) and GTFO_IsInLFR()) then
		if (tankAlert and alert.tankSoundLFR) then
			alertLevel = alert.tankSoundLFR;
		elseif (alert.soundLFR) then
			alertLevel = alert.soundLFR;
		end
	elseif (alert.soundHeroic or alert.soundChallenge or (tankAlert and (alert.tankSoundHeroic or alert.tankSoundChallenge))) then
		local isHeroic, isChallenge = select(3, GetDifficultyInfo(select(3, GetInstanceInfo())));
		if (isChallenge == true) then
			-- Challenge Mode
			if (tankAlert and (alert.tankSoundChallenge or alert.tankSoundHeroic)) then
				alertLevel = alert.tankSoundChallenge or alert.tankSoundHeroic;
			elseif (alert.soundChallenge or alert.soundHeroic) then
				alertLevel = alert.soundChallenge or alert.soundHeroic;
			end
		elseif (isHeroic == true) then
			-- Heroic Mode
			if (tankAlert and alert.tankSoundHeroic) then
				alertLevel = alert.tankSoundHeroic;
			elseif (alert.soundHeroic) then
				alertLevel = alert.soundHeroic;
			end
		end
	end
	
	return alertLevel;
end

function GTFO_GetAlertType(alertID)
	if (alertID == 1) then
		return GTFOLocal.AlertType_High;
	elseif (alertID == 2) then
		return GTFOLocal.AlertType_Low;
	elseif (alertID == 3) then
		return GTFOLocal.AlertType_Fail;
	elseif (alertID == 4) then
		return GTFOLocal.AlertType_FriendlyFire;
	end
	return nil;
end

function GTFO_GetAlertByID(alertName)
	if (alertName == GTFOLocal.AlertType_High) then
		return 1;
	elseif (alertName == GTFOLocal.AlertType_Low) then
		return 2;
	elseif (alertName == GTFOLocal.AlertType_Fail) then
		return 3;
	elseif (alertName == GTFOLocal.AlertType_FriendlyFire) then
		return 4;
	end
	return nil;
end

function GTFO_GetAlertIcon(alertID)
	if (alertID == 1) then
		return "Interface\\Icons\\Spell_Fire_Fire";
	elseif (alertID == 2) then
		return "Interface\\Icons\\Spell_Fire_BlueFire";
	elseif (alertID == 3) then
		return "Interface\\Icons\\Ability_Suffocate";
	elseif (alertID == 4) then
		return "Interface\\Icons\\Spell_Fire_FelFlameRing";
	end
	return nil;
end

function GTFO_AlertIncoming(soundAlert, vehicle, ...)
	local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, misc1, misc2, misc3, misc4, misc5, misc6, misc7 = ...; 
end

function GTFO_AddEvent(eventName, eventTime, eventCode, eventRepeat)
		local event = {
			Name = tostring(eventName);
			ExecuteTime = GetTime() + eventTime;
			Code = eventCode;
			Repeat = 0;
		};
		local eventIndex = nil;
		
		if (eventRepeat) then
			event.Repeat = eventRepeat;
		end

		-- Check for existing event
		eventIndex = GTFO_FindEvent(event.Name);
		
		if (eventIndex) then
			GTFO.Events[eventIndex].ExecuteTime = event.ExecuteTime;
			--GTFO_DebugPrint("Extending event '"..event.Name.."' to be executed in "..eventTime.." seconds.");
		else
			tinsert(GTFO.Events, event);
			--GTFO_DebugPrint("Adding event '"..event.Name.."' to be executed in "..eventTime.." seconds.");			
			GTFOFrame:SetScript("OnUpdate", GTFO_OnUpdate);
			--GTFO_DebugPrint("Event update checking enabled.");
		end
end

function GTFO_FindEvent(eventName)
	if (#GTFO.Events > 0) then
		for index, currentEvent in pairs(GTFO.Events) do
			if (currentEvent.Name == eventName) then
				return index;
			end
		end
	end	
	return nil;
end

function GTFO_RecordStats(alertID, SpellID, SpellName, damage, sourceName)
	if (alertID and alertID > 0 and (GTFO.Recount or GTFO.Skada)) then
		local spellName = SpellName;
		-- Append the name of the person that did damage for Friendly Fire alerts
		if (alertID == 4) then
			if (sourceName and tostring(sourceName) ~= "nil") then
				spellName = spellName.." ("..sourceName..")";
			end
		end
		
		-- Integration
		if (GTFO.Recount) then
			GTFO_RecordRecount(UnitName("player"), alertID, spellName, damage);
		end
		if (GTFO.Skada) then
			GTFO_RecordSkada(UnitName("player"), UnitGUID("player"), alertID, tonumber(SpellID), spellName, tonumber(damage));
		end
	end
end

function GTFO_DisplayAura(alertTypeID)
	-- Integration
	if (GTFO.PowerAuras) then
		GTFO_DisplayAura_PowerAuras(alertTypeID);
	end
	if (GTFO.WeakAuras) then
		GTFO_DisplayAura_WeakAuras(alertTypeID);
	end
end

function GTFO_IsInLFR()
	return IsInGroup(LE_PARTY_CATEGORY_INSTANCE);
end

