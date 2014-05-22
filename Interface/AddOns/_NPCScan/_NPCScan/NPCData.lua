-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs
local tostring = _G.tostring
local type = _G.type

-- Libraries
local string = _G.string
local table = _G.table


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L
local ZN = private.ZONE_NAMES


local NPC_DATA = {
	[61]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false, is_achievement = false }, -- Thuros Lightfingers
	[62]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHSHIRE,                  is_tamable = false, is_achievement = false }, -- Gug Fatcandle
	[79]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false, is_achievement = false }, -- Narg the Taskmaster
	[99]    = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false, is_achievement = false }, -- Morgaine the Sly
	[100]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false, is_achievement = false }, -- Gruff Swiftbite
	[462]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = true,  is_achievement = false }, -- Vultros
	[471]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Mother Fang
	[472]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = false, is_achievement = false }, -- Fedfennel
	[506]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false, is_achievement = false }, -- Sergeant Brashclaw
	[507]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Fenros
	[519]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false, is_achievement = false }, -- Slark
	[520]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false, is_achievement = false }, -- Brack
	[521]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = true,  is_achievement = false }, -- Lupos
	[534]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Nefaru
	[572]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false, is_achievement = false }, -- Leprithus
	[573]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false, is_achievement = false }, -- Foe Reaper 4000
	[574]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = true,  is_achievement = false }, -- Naraxis
	[584]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Kazon
	[596]   = { world_id = ZN.THE_DEADMINES,            map_name = ZN.THE_DEADMINES,               is_tamable = false, is_achievement = false }, -- Brainwashed Noble
	[599]   = { world_id = ZN.THE_DEADMINES,            map_name = ZN.THE_DEADMINES,               is_tamable = false, is_achievement = false }, -- Marisa du'Paige
	[616]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = true,  is_achievement = false }, -- Chatter
	[763]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Lost One Chieftain
	[947]   = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Rohh the Silent
	[1063]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Jade
	[1106]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Lost One Cook
	[1112]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = true,  is_achievement = false }, -- Leech Widow
	[1119]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = false, is_achievement = false }, -- Hammerspine
	[1130]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = true,  is_achievement = false }, -- Bjarn
	[1132]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NEW_TINKERTOWN,              is_tamable = true,  is_achievement = false }, -- Timber
	[1137]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = false, is_achievement = false }, -- Edan the Howler
	[1140]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = true,  is_achievement = false }, -- Razormaw Matriarch
	[1260]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUN_MOROGH,                  is_tamable = false, is_achievement = false }, -- Great Father Arctikus
	[1398]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Boss Galgosh
	[1399]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Magosh
	[1424]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTFALL,                    is_tamable = false, is_achievement = false }, -- Master Digger
	[1425]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Kubb
	[1531]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false, is_achievement = false }, -- Lost Soul
	[1533]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false, is_achievement = false }, -- Tormented Spirit
	[1552]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = true,  is_achievement = false }, -- Scale Belly
	[1837]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Scarlet Judge
	[1838]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Scarlet Interrogator
	[1839]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Scarlet High Clerist
	[1841]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Scarlet Executioner
	[1843]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Foreman Jerris
	[1844]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Foreman Marcrid
	[1847]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Foulmane
	[1848]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Lord Maldazzar
	[1849]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Dreadwhisper
	[1850]  = { world_id = ZN.SCHOLOMANCE,              map_name = ZN.SCHOLOMANCE,                 is_tamable = false, is_achievement = false }, -- Putridius
	[1851]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- The Husk
	[1885]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Scarlet Smith
	[1910]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false, is_achievement = false }, -- Muad
	[1911]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false, is_achievement = false }, -- Deeb
	[1936]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false, is_achievement = false }, -- Farmer Solliden
	[2090]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Ma'ruk Wyrmscale
	[2108]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Garneg Charskull
	[2162]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false, is_achievement = false }, -- Agal
	[2172]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = true,  is_achievement = false }, -- Strider Clutchmother
	[2175]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = true,  is_achievement = false }, -- Shadowclaw
	[2184]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Lady Moongazer
	[2186]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Carnivous the Breaker
	[2191]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Licillin
	[2192]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Firecaller Radison
	[2258]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Maggarrak
	[2452]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Skhowl
	[2453]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Lo'Grosh
	[2476]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true,  is_achievement = false }, -- Gosh-Haldir
	[2541]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false, is_achievement = false }, -- Lord Sakrasis
	[2598]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Darbel Montrose
	[2600]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Singer
	[2601]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Foulbelly
	[2602]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Ruul Onestone
	[2603]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Kovork
	[2604]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Molok the Crusher
	[2605]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Zalas Witherbark
	[2606]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Nimar the Slayer
	[2609]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Geomancer Flintdagger
	[2744]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false, is_achievement = false }, -- Shadowforge Commander
	[2749]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false, is_achievement = false }, -- Barricade
	[2751]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false, is_achievement = false }, -- War Golem
	[2752]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false, is_achievement = false }, -- Rumbler
	[2753]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Barnabus
	[2754]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false, is_achievement = false }, -- Anathemus
	[2779]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = false, is_achievement = false }, -- Prince Nazjak
	[2850]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Broken Tooth
	[2931]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Zaricotl
	[3058]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false, is_achievement = false }, -- Arra'chea
	[3068]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = true,  is_achievement = false }, -- Mazzranache
	[3253]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = true,  is_achievement = false }, -- Silithid Harvester
	[3270]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Elder Mystic Razorsnout
	[3295]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Sludge Anomaly
	[3398]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Gesharahan
	[3470]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Rathorian
	[3535]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false, is_achievement = false }, -- Blackmoss the Fetid
	[3581]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.STORMWIND_CITY,              is_tamable = true,  is_achievement = false }, -- Sewer Beast
	[3652]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Trigore the Lasher
	[3672]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Boahn
	[3735]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Apothecary Falthis
	[3736]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Darkslayer Mordenthal
	[3773]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Akkrilus
	[3792]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Terrowulf Packlord
	[3872]  = { world_id = ZN.SHADOWFANG_KEEP,          map_name = ZN.SHADOWFANG_KEEP,             is_tamable = false, is_achievement = false }, -- Deathsworn Captain
	[4066]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false, is_achievement = false }, -- Nal'taszar
	[4132]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Krkk'kx
	[4339]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false, is_achievement = false }, -- Brimgore
	[4380]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Darkmist Widow
	[4425]  = { world_id = ZN.RAZORFEN_KRAUL,           map_name = ZN.RAZORFEN_KRAUL,              is_tamable = true,  is_achievement = false }, -- Blind Hunter
	[4842]  = { world_id = ZN.RAZORFEN_KRAUL,           map_name = ZN.RAZORFEN_KRAUL,              is_tamable = false, is_achievement = false }, -- Earthcaller Halmgar
	[5343]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Lady Szallah
	[5345]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Diamond Head
	[5346]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Bloodroar the Stalker
	[5347]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Antilus the Soarer
	[5348]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Dreamwatcher Forktongue
	[5349]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true,  is_achievement = false }, -- Arash-ethis
	[5350]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true,  is_achievement = false }, -- Qirot
	[5352]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true,  is_achievement = false }, -- Old Grizzlegut
	[5354]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Gnarl Leafbrother
	[5356]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true,  is_achievement = false }, -- Snarler
	[5785]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false, is_achievement = false }, -- Sister Hatelash
	[5786]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false, is_achievement = false }, -- Snagglespear
	[5787]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false, is_achievement = false }, -- Enforcer Emilgund
	[5807]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = true,  is_achievement = false }, -- The Rake
	[5809]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false, is_achievement = false }, -- Sergeant Curtis
	[5822]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false, is_achievement = false }, -- Felweaver Scornn
	[5823]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = true,  is_achievement = false }, -- Death Flayer
	[5824]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false, is_achievement = false }, -- Captain Flat Tusk
	[5826]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUROTAR,                     is_tamable = false, is_achievement = false }, -- Geolord Mottle
	[5828]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = true,  is_achievement = false }, -- Humar the Pridelord
	[5829]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = true,  is_achievement = false }, -- Snort the Heckler
	[5830]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Sister Rathtalon
	[5831]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Swiftmane
	[5834]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = true,  is_achievement = false }, -- Azzere the Skyblade
	[5835]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Foreman Grills
	[5836]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Engineer Whirleygig
	[5837]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Stonearm
	[5838]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Brokespear
	[5841]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Rocklance
	[5842]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = true,  is_achievement = false }, -- Takk the Leaper
	[5847]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Heggin Stonewhisker
	[5848]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Malgin Barleybrew
	[5849]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Digger Flameforge
	[5851]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Captain Gerogg Hammertoe
	[5859]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Hagg Taurenbane
	[5863]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Geopriest Gukk'rok
	[5864]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.SOUTHERN_BARRENS,            is_tamable = false, is_achievement = false }, -- Swinegart Spearhide
	[5865]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.NORTHERN_BARRENS,            is_tamable = true,  is_achievement = false }, -- Dishu
	[5912]  = { world_id = ZN.WAILING_CAVERNS,          map_name = ZN.WAILING_CAVERNS,             is_tamable = false, is_achievement = false }, -- Deviate Faerie Dragon
	[5915]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false, is_achievement = false }, -- Brother Ravenoak
	[5928]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false, is_achievement = false }, -- Sorrow Wing
	[5930]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false, is_achievement = false }, -- Sister Riven
	[5932]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = false, is_achievement = false }, -- Taskmaster Whipfang
	[5933]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false, is_achievement = false }, -- Achellios the Banished
	[5935]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false, is_achievement = false }, -- Ironeye the Invincible
	[5937]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Vile Sting
	[6118]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false, is_achievement = false }, -- Varo'then's Ghost
	[6228]  = { world_id = ZN.GNOMEREGAN,               map_name = ZN.GNOMEREGAN,                  is_tamable = false, is_achievement = false }, -- Dark Iron Ambassador
	[6581]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true,  is_achievement = false }, -- Ravasaur Matriarch
	[6582]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true,  is_achievement = false }, -- Clutchmother Zavas
	[6583]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = false, is_achievement = false }, -- Gruff
	[6584]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true,  is_achievement = false }, -- King Mosh
	[6585]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.UNGORO_CRATER,               is_tamable = true,  is_achievement = false }, -- Uhk'loc
	[6648]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false, is_achievement = false }, -- Antilos
	[6649]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false, is_achievement = false }, -- Lady Sesspira
	[6650]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false, is_achievement = false }, -- General Fangferror
	[6651]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false, is_achievement = false }, -- Gatekeeper Rageroar
	[7015]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Flagglemurk the Cruel
	[7016]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Lady Vespira
	[7017]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.DARKSHORE,                   is_tamable = false, is_achievement = false }, -- Lord Sinslayer
	[7104]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false, is_achievement = false }, -- Dessecus
	[7137]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false, is_achievement = false }, -- Immolatus
	[7846]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Teremus the Devourer
	[8199]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Warleader Krazzilak
	[8200]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Jin'Zallah the Sandbringer
	[8201]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Omgorn the Lost
	[8203]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Kregg Keelhaul
	[8204]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Soriid the Devourer
	[8205]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Haarka the Ravenous
	[8207]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Emberwing
	[8210]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Razortalon
	[8211]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = true,  is_achievement = false }, -- Old Cliff Jumper
	[8212]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- The Reak
	[8213]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = true,  is_achievement = false }, -- Ironback
	[8214]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Jalinde Summerdrake
	[8215]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Grimungous
	[8216]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Retherokk the Berserker
	[8217]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Mith'rethis the Enchanter
	[8218]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Witherheart the Stalker
	[8219]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_HINTERLANDS,             is_tamable = false, is_achievement = false }, -- Zul'arek Hatefowler
	[8277]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Rekk'tilac
	[8278]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false, is_achievement = false }, -- Smoldar
	[8279]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false, is_achievement = false }, -- Faulty War Golem
	[8280]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false, is_achievement = false }, -- Shleipnarr
	[8281]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false, is_achievement = false }, -- Scald
	[8282]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false, is_achievement = false }, -- Highlord Mastrogonde
	[8283]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = false, is_achievement = false }, -- Slave Master Blackheart
	[8296]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Mojo the Twisted
	[8297]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Magronos the Unyielding
	[8298]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Akubar the Seer
	[8299]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true,  is_achievement = false }, -- Spiteflayer
	[8300]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true,  is_achievement = false }, -- Ravage
	[8301]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true,  is_achievement = false }, -- Clack the Reaver
	[8302]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Deatheye
	[8303]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = true,  is_achievement = false }, -- Grunter
	[8304]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Dreadscorn
	[8503]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NEW_TINKERTOWN,              is_tamable = false, is_achievement = false }, -- Gibblewilt
	[8660]  = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = true,  is_achievement = false }, -- The Evalcharr
	[8923]  = { world_id = ZN.BLACKROCK_DEPTHS,         map_name = ZN.BLACKROCK_DEPTHS,            is_tamable = false, is_achievement = false }, -- Panzor the Invincible
	[8976]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Hematos
	[8978]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Thauris Balgarr
	[8979]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Gruklash
	[8981]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Malfunctioning Reaver
	[9217]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Spirestone Lord Magus
	[9218]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Spirestone Battle Lord
	[9219]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Spirestone Butcher
	[9596]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Bannok Grimaxe
	[9602]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Hahk'Zor
	[9604]  = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Gorgon'och
	[9718]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Ghok Bashguud
	[9736]  = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Quartermaster Zigris
	[10077] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Deathmaw
	[10078] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Terrorspark
	[10080] = { world_id = ZN.ZULFARRAK,                map_name = ZN.ZULFARRAK,                   is_tamable = false, is_achievement = false }, -- Sandarr Dunereaver
	[10081] = { world_id = ZN.ZULFARRAK,                map_name = ZN.ZULFARRAK,                   is_tamable = false, is_achievement = false }, -- Dustwraith
	[10082] = { world_id = ZN.ZULFARRAK,                map_name = ZN.ZULFARRAK,                   is_tamable = false, is_achievement = false }, -- Zerillis
	[10119] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = false, is_achievement = false }, -- Volchan
	[10196] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false, is_achievement = false }, -- General Colbatann
	[10197] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false, is_achievement = false }, -- Mezzir the Howler
	[10198] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false, is_achievement = false }, -- Kashoch the Reaver
	[10199] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false, is_achievement = false }, -- Grizzle Snowpaw
	[10200] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Rak'shiri
	[10202] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = false, is_achievement = false }, -- Azurous
	[10263] = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Burning Felguard
	[10356] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Bayne
	[10357] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Ressan the Needler
	[10358] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = false, is_achievement = false }, -- Fellicent's Shade
	[10359] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Sri'skulk
	[10376] = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = true,  is_achievement = false }, -- Crystal Fang
	[10393] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false, is_achievement = false }, -- Skul
	[10509] = { world_id = ZN.BLACKROCK_SPIRE,          map_name = ZN.BLACKROCK_SPIRE,             is_tamable = false, is_achievement = false }, -- Jed Runewatcher
	[10558] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false, is_achievement = false }, -- Hearthsinger Forresten
	[10559] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Lady Vespia
	[10639] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Rorgish Jowl
	[10640] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Oakpaw
	[10641] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Branch Snapper
	[10642] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Eck'alom
	[10644] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = true,  is_achievement = false }, -- Mist Howler
	[10647] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = false, is_achievement = false }, -- Prince Raze
	[10741] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Sian-Rotam
	[10809] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false, is_achievement = false }, -- Stonespine
	[10817] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Duggan Wildhammer
	[10818] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Death Knight Soulbearer
	[10819] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Baron Bloodbane
	[10820] = { world_id = ZN.STRATHOLME,               map_name = ZN.STRATHOLME,                  is_tamable = false, is_achievement = false }, -- Duke Ragereaver
	[10821] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Hed'mush the Rotting
	[10823] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Zul'Brin Warpbranch
	[10824] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Death-Hunter Hawkspear
	[10825] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Gish the Unmoving
	[10826] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Lord Darkscythe
	[10827] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Deathspeaker Selendre
	[10828] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Lynnia Abbendis
	[11383] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false, is_achievement = false }, -- High Priestess Hai'watna
	[11447] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Mushgog
	[11467] = { world_id = ZN.DIRE_MAUL,                map_name = ZN.DIRE_MAUL,                   is_tamable = false, is_achievement = false }, -- Tsu'zee
	[11497] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = true,  is_achievement = false }, -- The Razza
	[11498] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Skarr the Broken
	[11688] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false, is_achievement = false }, -- Cursed Centaur
	[12037] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ASHENVALE,                   is_tamable = true,  is_achievement = false }, -- Ursol'lok
	[12237] = { world_id = ZN.MARAUDON,                 map_name = ZN.MARAUDON,                    is_tamable = false, is_achievement = false }, -- Meshlok the Harvester
	[12431] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Gorefang
	[12433] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Krethis the Shadowspinner
	[12902] = { world_id = ZN.BLACKFATHOM_DEEPS,        map_name = ZN.BLACKFATHOM_DEEPS,           is_tamable = false, is_achievement = false }, -- Lorgus Jett
	[13896] = { world_id = ZN.KALIMDOR,                 map_name = ZN.AZSHARA,                     is_tamable = false, is_achievement = false }, -- Scalebeard
	[14221] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Gravis Slipknot
	[14222] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Araga
	[14223] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Cranky Benj
	[14224] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = false, is_achievement = false }, -- 7:XT
	[14225] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false, is_achievement = false }, -- Prince Kellen
	[14226] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false, is_achievement = false }, -- Kaskk
	[14227] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false, is_achievement = false }, -- Hissperak
	[14228] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = true,  is_achievement = false }, -- Giggler
	[14229] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = false, is_achievement = false }, -- Accursed Slitherblade
	[14230] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false, is_achievement = false }, -- Burgle Eye
	[14231] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false, is_achievement = false }, -- Drogoth the Roamer
	[14232] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Dart
	[14233] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Ripscale
	[14234] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Hayoc
	[14235] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false, is_achievement = false }, -- The Rot
	[14236] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = false, is_achievement = false }, -- Lord Angler
	[14237] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Oozeworm
	[14266] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true,  is_achievement = false }, -- Shanda the Spinner
	[14267] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Emogg the Crusher
	[14268] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true,  is_achievement = false }, -- Lord Condar
	[14269] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Seeker Aqualon
	[14270] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Squiddic
	[14271] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Ribchaser
	[14272] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Snarlflare
	[14273] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = false, is_achievement = false }, -- Boulderheart
	[14275] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Tamra Stormpike
	[14276] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Scargil
	[14277] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Lady Zephris
	[14278] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Ro'Bark
	[14279] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Creepthess
	[14280] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Big Samras
	[14281] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Jimmy the Bleeder
	[14339] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Death Howl
	[14340] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false, is_achievement = false }, -- Alshirr Banebreath
	[14342] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false, is_achievement = false }, -- Ragepaw
	[14343] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Olm the Wise
	[14344] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Mongress
	[14345] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = false, is_achievement = false }, -- The Ongar
	[14424] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Mirelow
	[14425] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Gnawbone
	[14426] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false, is_achievement = false }, -- Harb Foulmountain
	[14427] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = false, is_achievement = false }, -- Gibblesnik
	[14428] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false, is_achievement = false }, -- Uruson
	[14429] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false, is_achievement = false }, -- Grimmaw
	[14430] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = true,  is_achievement = false }, -- Duskstalker
	[14431] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false, is_achievement = false }, -- Fury Shelda
	[14432] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TELDRASSIL,                  is_tamable = false, is_achievement = false }, -- Threggil
	[14433] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Sludginn
	[14445] = { world_id = ZN.THE_TEMPLE_OF_ATALHAKKAR, map_name = ZN.THE_TEMPLE_OF_ATALHAKKAR,    is_tamable = false, is_achievement = false }, -- Captain Wyrmak
	[14446] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Fingat
	[14447] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Gilmorian
	[14448] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = false, is_achievement = false }, -- Molt Thorn
	[14471] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = false, is_achievement = false }, -- Setis
	[14472] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Gretheer
	[14473] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Lapress
	[14474] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Zora
	[14475] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Rex Ashil
	[14476] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Krellack
	[14477] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Grubthor
	[14478] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = false, is_achievement = false }, -- Huricanian
	[14479] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = false, is_achievement = false }, -- Twilight Lord Everun
	[14487] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false, is_achievement = false }, -- Gluggl
	[14488] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false, is_achievement = false }, -- Roloch
	[14490] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false, is_achievement = false }, -- Rippa
	[14491] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = true,  is_achievement = false }, -- Kurmokk
	[14492] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.THE_CAPE_OF_STRANGLETHORN,   is_tamable = false, is_achievement = false }, -- Verifonix
	[16179] = { world_id = ZN.KARAZHAN,                 map_name = ZN.KARAZHAN,                    is_tamable = false, is_achievement = false }, -- Hyakiss the Lurker
	[16180] = { world_id = ZN.KARAZHAN,                 map_name = ZN.KARAZHAN,                    is_tamable = true,  is_achievement = false }, -- Shadikith the Glider
	[16181] = { world_id = ZN.KARAZHAN,                 map_name = ZN.KARAZHAN,                    is_tamable = true,  is_achievement = false }, -- Rokad the Ravager
	[16184] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = false, is_achievement = false }, -- Nerubian Overseer
	[16854] = { world_id = ZN.OUTLAND,                  map_name = ZN.EVERSONG_WOODS,              is_tamable = false, is_achievement = false }, -- Eldinarcus
	[16855] = { world_id = ZN.OUTLAND,                  map_name = ZN.EVERSONG_WOODS,              is_tamable = false, is_achievement = false }, -- Tregla
	[17144] = { world_id = ZN.OUTLAND,                  map_name = ZN.NAGRAND,                     is_tamable = true,  is_achievement = true  }, -- Goretooth
	[18241] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DESOLACE,                    is_tamable = true,  is_achievement = false }, -- Crusty
	[18677] = { world_id = ZN.OUTLAND,                  map_name = ZN.HELLFIRE_PENINSULA,          is_tamable = false, is_achievement = true  }, -- Mekthorg the Wild
	[18678] = { world_id = ZN.OUTLAND,                  map_name = ZN.HELLFIRE_PENINSULA,          is_tamable = false, is_achievement = true  }, -- Fulgorge
	[18679] = { world_id = ZN.OUTLAND,                  map_name = ZN.HELLFIRE_PENINSULA,          is_tamable = false, is_achievement = true  }, -- Vorakem Doomspeaker
	[18680] = { world_id = ZN.OUTLAND,                  map_name = ZN.ZANGARMARSH,                 is_tamable = true,  is_achievement = true  }, -- Marticar
	[18681] = { world_id = ZN.OUTLAND,                  map_name = ZN.ZANGARMARSH,                 is_tamable = false, is_achievement = true  }, -- Coilfang Emissary
	[18682] = { world_id = ZN.OUTLAND,                  map_name = ZN.ZANGARMARSH,                 is_tamable = false, is_achievement = true  }, -- Bog Lurker
	[18683] = { world_id = ZN.OUTLAND,                  map_name = ZN.NAGRAND,                     is_tamable = false, is_achievement = true  }, -- Voidhunter Yar
	[18684] = { world_id = ZN.OUTLAND,                  map_name = ZN.NAGRAND,                     is_tamable = false, is_achievement = true  }, -- Bro'Gaz the Clanless
	[18685] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = false, is_achievement = true  }, -- Okrek
	[18686] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = false, is_achievement = true  }, -- Doomsayer Jurim
	[18689] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = false, is_achievement = true  }, -- Crippler
	[18690] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLADES_EDGE_MOUNTAINS,       is_tamable = false, is_achievement = true  }, -- Morcrush
	[18692] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLADES_EDGE_MOUNTAINS,       is_tamable = false, is_achievement = true  }, -- Hemathion
	[18693] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLADES_EDGE_MOUNTAINS,       is_tamable = false, is_achievement = true  }, -- Speaker Mar'grom
	[18694] = { world_id = ZN.OUTLAND,                  map_name = ZN.SHADOWMOON_VALLEY,           is_tamable = false, is_achievement = true  }, -- Collidus the Warp-Watcher
	[18695] = { world_id = ZN.OUTLAND,                  map_name = ZN.SHADOWMOON_VALLEY,           is_tamable = false, is_achievement = true  }, -- Ambassador Jerrikar
	[18696] = { world_id = ZN.OUTLAND,                  map_name = ZN.SHADOWMOON_VALLEY,           is_tamable = false, is_achievement = true  }, -- Kraator
	[18697] = { world_id = ZN.OUTLAND,                  map_name = ZN.NETHERSTORM,                 is_tamable = false, is_achievement = true  }, -- Chief Engineer Lorthander
	[18698] = { world_id = ZN.OUTLAND,                  map_name = ZN.NETHERSTORM,                 is_tamable = false, is_achievement = true  }, -- Ever-Core the Punisher
	[20932] = { world_id = ZN.OUTLAND,                  map_name = ZN.NETHERSTORM,                 is_tamable = true,  is_achievement = true  }, -- Nuramoc
	[21724] = { world_id = ZN.OUTLAND,                  map_name = ZN.TEROKKAR_FOREST,             is_tamable = true,  is_achievement = false }, -- Hawkbane
	[22060] = { world_id = ZN.OUTLAND,                  map_name = ZN.BLOODMYST_ISLE,              is_tamable = false, is_achievement = false }, -- Fenissa the Assassin
	[22062] = { world_id = ZN.OUTLAND,                  map_name = ZN.GHOSTLANDS,                  is_tamable = false, is_achievement = false }, -- Dr. Whitherlimb
	[32357] = { world_id = ZN.NORTHREND,                map_name = ZN.BOREAN_TUNDRA,               is_tamable = false, is_achievement = true  }, -- Old Crystalbark
	[32358] = { world_id = ZN.NORTHREND,                map_name = ZN.BOREAN_TUNDRA,               is_tamable = false, is_achievement = true  }, -- Fumblub Gearwind
	[32361] = { world_id = ZN.NORTHREND,                map_name = ZN.BOREAN_TUNDRA,               is_tamable = true,  is_achievement = true  }, -- Icehorn
	[32377] = { world_id = ZN.NORTHREND,                map_name = ZN.HOWLING_FJORD,               is_tamable = false, is_achievement = true  }, -- Perobas the Bloodthirster
	[32386] = { world_id = ZN.NORTHREND,                map_name = ZN.HOWLING_FJORD,               is_tamable = false, is_achievement = true  }, -- Vigdis the War Maiden
	[32398] = { world_id = ZN.NORTHREND,                map_name = ZN.HOWLING_FJORD,               is_tamable = false, is_achievement = true  }, -- King Ping
	[32400] = { world_id = ZN.NORTHREND,                map_name = ZN.DRAGONBLIGHT,                is_tamable = false, is_achievement = true  }, -- Tukemuth
	[32409] = { world_id = ZN.NORTHREND,                map_name = ZN.DRAGONBLIGHT,                is_tamable = false, is_achievement = true  }, -- Crazed Indu'le Survivor
	[32417] = { world_id = ZN.NORTHREND,                map_name = ZN.DRAGONBLIGHT,                is_tamable = false, is_achievement = true  }, -- Scarlet Highlord Daion
	[32422] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = false, is_achievement = true  }, -- Grocklar
	[32429] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = false, is_achievement = true  }, -- Seething Hate
	[32438] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = false, is_achievement = true  }, -- Syreian the Bonecarver
	[32447] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = false, is_achievement = true  }, -- Zul'drak Sentinel
	[32471] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = false, is_achievement = true  }, -- Griegen
	[32475] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = true,  is_achievement = true  }, -- Terror Spinner
	[32481] = { world_id = ZN.NORTHREND,                map_name = ZN.SHOLAZAR_BASIN,              is_tamable = true,  is_achievement = true  }, -- Aotona
	[32485] = { world_id = ZN.NORTHREND,                map_name = ZN.SHOLAZAR_BASIN,              is_tamable = true,  is_achievement = true  }, -- King Krush
	[32487] = { world_id = ZN.NORTHREND,                map_name = ZN.ICECROWN,                    is_tamable = false, is_achievement = true  }, -- Putridus the Ancient
	[32491] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = false, is_achievement = false }, -- Time-Lost Proto-Drake
	[32495] = { world_id = ZN.NORTHREND,                map_name = ZN.ICECROWN,                    is_tamable = false, is_achievement = true  }, -- Hildana Deathstealer
	[32500] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = false, is_achievement = true  }, -- Dirkee
	[32501] = { world_id = ZN.NORTHREND,                map_name = ZN.ICECROWN,                    is_tamable = false, is_achievement = true  }, -- High Thane Jorfus
	[32517] = { world_id = ZN.NORTHREND,                map_name = ZN.SHOLAZAR_BASIN,              is_tamable = true,  is_achievement = true  }, -- Loque'nahak
	[32630] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = false, is_achievement = true  }, -- Vyragosa
	[33776] = { world_id = ZN.NORTHREND,                map_name = ZN.ZULDRAK,                     is_tamable = true,  is_achievement = false }, -- Gondria
	[35189] = { world_id = ZN.NORTHREND,                map_name = ZN.THE_STORM_PEAKS,             is_tamable = true,  is_achievement = false }, -- Skoll
	[38453] = { world_id = ZN.NORTHREND,                map_name = ZN.GRIZZLY_HILLS,               is_tamable = true,  is_achievement = false }, -- Arcturis
	[39183] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Scorpitar
	[39185] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Slaverjaw
	[39186] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Hellgazer
	[43488] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FERALAS,                     is_tamable = false, is_achievement = false }, -- Mordei the Earthrender
	[43613] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MULGORE,                     is_tamable = false, is_achievement = false }, -- Doomsayer Wiserunner
	[43720] = { world_id = ZN.KALIMDOR,                 map_name = ZN.CAMP_NARACHE,                is_tamable = false, is_achievement = false }, -- "Pokey" Thornmantle
	[44224] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Two-Toes
	[44225] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Rufus Darkshot
	[44226] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Sarltooth
	[44227] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = false, is_achievement = false }, -- Gazz the Loch-Hunter
	[44714] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Fronkle the Disturbed
	[44722] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Twisted Reflection of Narain
	[44750] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Caliph Scorpidsting
	[44759] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Andre Firebeard
	[44761] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Aquementas the Unchained
	[44767] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = false, is_achievement = false }, -- Occulus the Corrupted
	[45257] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Mordak Nightbender
	[45258] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Cassia the Slitherqueen
	[45260] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Blackleaf
	[45262] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BLASTED_LANDS,               is_tamable = false, is_achievement = false }, -- Narixxus the Doombringer
	[45369] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Morick Darkbrew
	[45380] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true,  is_achievement = false }, -- Ashtail
	[45384] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Sagepaw
	[45398] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Grizlak
	[45399] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Optimo
	[45401] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Whitefin
	[45402] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = true,  is_achievement = false }, -- Nix
	[45404] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.LOCH_MODAN,                  is_tamable = false, is_achievement = false }, -- Geoshaper Maren
	[45739] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- The Unknown Soldier
	[45740] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Watcher Eva
	[45771] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Marus
	[45785] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Carved One
	[45801] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Eliza
	[45811] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DUSKWOOD,                    is_tamable = false, is_achievement = false }, -- Marina DeSirrus
	[46981] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Nightlash
	[46992] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Berard the Moon-Crazed
	[47003] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Bolgaff
	[47008] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Fenwick Thatros
	[47009] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Aquarius the Unbound
	[47010] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = false, is_achievement = false }, -- Indigos
	[47012] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Effritus
	[47015] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Lost Son of Arugal
	[47023] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = false, is_achievement = false }, -- Thule Ravenclaw
	[47386] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Ainamiss the Hive Queen
	[47387] = { world_id = ZN.KALIMDOR,                 map_name = ZN.TANARIS,                     is_tamable = true,  is_achievement = false }, -- Harakiss the Infestor
	[49822] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = true,  is_achievement = false }, -- Jadefang
	[49913] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.KELPTHAR_FOREST,             is_tamable = false, is_achievement = false }, -- Lady La-La
	[50005] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SHIMMERING_EXPANSE,          is_tamable = false, is_achievement = false }, -- Poseidus
	[50050] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ABYSSAL_DEPTHS,              is_tamable = false, is_achievement = false }, -- Shok'sharak
	[50051] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ABYSSAL_DEPTHS,              is_tamable = true,  is_achievement = false }, -- Ghostcrawler
	[50052] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SHIMMERING_EXPANSE,          is_tamable = false, is_achievement = false }, -- Burgy Blackheart
	[50053] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = false, is_achievement = false }, -- Thartuk the Exile
	[50057] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = false, is_achievement = false }, -- Blazewing
	[50058] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true,  is_achievement = false }, -- Terrorpene
	[50059] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = false, is_achievement = false }, -- Golgarok
	[50060] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = false, is_achievement = false }, -- Terborus
	[50062] = { world_id = ZN.DEEPHOLM,                 map_name = ZN.DEEPHOLM,                    is_tamable = false, is_achievement = false }, -- Aeonaxx
	[50064] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = false, is_achievement = false }, -- Cyrus the Black
	[50065] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = false, is_achievement = false }, -- Armagedillo
	[50085] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = false, is_achievement = false }, -- Overlord Sunderfury
	[50086] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = false, is_achievement = false }, -- Tarvus the Vile
	[50138] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = true,  is_achievement = false }, -- Karoma
	[50154] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true,  is_achievement = false }, -- Madexx
	[50159] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TWILIGHT_HIGHLANDS,          is_tamable = true,  is_achievement = false }, -- Sambas
	[50328] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.DEATHKNELL,                  is_tamable = true,  is_achievement = false }, -- Fangor
	[50329] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Rrakk
	[50330] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Kree
	[50331] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Go-Kan
	[50332] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Korda Torros
	[50333] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Lon the Bull
	[50334] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Dak the Breaker
	[50335] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Alitus
	[50336] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Yorik Sharpeye
	[50337] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Cackle
	[50338] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Kor'nas Nightsavage
	[50339] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Sulik'shor
	[50340] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Gaarn the Toxic
	[50341] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Borginn Darkfist
	[50342] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Heronis
	[50343] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Quall
	[50344] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Norlaxx
	[50345] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Alit
	[50346] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Ronak
	[50347] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Karr the Darkener
	[50348] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Norissis
	[50349] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Kang the Soul Thief
	[50350] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Morgrinn Crackfang
	[50351] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Jonn-Dar
	[50352] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Qu'nas
	[50353] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Manas
	[50354] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Havak
	[50355] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Kah'tir
	[50356] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Krol the Blade
	[50357] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Sunwing
	[50358] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Haywire Sunreaver Construct
	[50359] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Urgolax
	[50361] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Ornat
	[50362] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Blackbog the Fang
	[50363] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Krax'ik
	[50364] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Nal'lak the Ripper
	[50370] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Karapax
	[50388] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Torik-Ethis
	[50724] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Spinecrawl
	[50725] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Azelisk
	[50726] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Kalixx
	[50727] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Strix the Barbed
	[50728] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Deathstrike
	[50730] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Venomspine
	[50731] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Needlefang
	[50733] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Ski'thik
	[50734] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Lith'ik the Stalker
	[50735] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Blinkeye the Rattler
	[50737] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Acroniss
	[50738] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Shimmerscale
	[50739] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Gar'lok
	[50741] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Kaxx
	[50742] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Qem
	[50743] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Manax
	[50744] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Qu'rik
	[50745] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Losaj
	[50746] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Bornix the Burrower
	[50747] = { world_id = ZN.KALIMDOR,                 map_name = ZN.AHNQIRAJ_THE_FALLEN_KINGDOM, is_tamable = true,  is_achievement = false }, -- Tix
	[50748] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Nyaj
	[50749] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Kal'tik the Blight
	[50750] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Aethis
	[50752] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Tarantis
	[50759] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Iriss the Widow
	[50763] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Shadowstalker
	[50764] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Paraliss
	[50765] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Miasmiss
	[50766] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Sele'na
	[50768] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Cournith Waterstrider
	[50769] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Zai the Outcast
	[50770] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Zorn
	[50772] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Eshelon
	[50775] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Likk the Hunter
	[50776] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Nalash Verdantis
	[50777] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Needle
	[50778] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Ironweb
	[50779] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Sporeggon
	[50780] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Sahn Tidehunter
	[50782] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Sarnak
	[50783] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Salyin Warscout
	[50784] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Anith
	[50785] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Skyshadow
	[50786] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Sparkwing
	[50787] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Arness the Scale
	[50788] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Quetzl
	[50789] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Nessos the Oracle
	[50790] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Ionis
	[50791] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Siltriss the Sharpener
	[50792] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Chiaa
	[50797] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Yukiko
	[50803] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Bonechewer
	[50804] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Ripwing
	[50805] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Omnis Grinlok
	[50806] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Moldo One-Eye
	[50807] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Catal
	[50808] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Urobi the Walker
	[50809] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Heress
	[50810] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Favored of Isiset
	[50811] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Nasra Spothide
	[50812] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Arae
	[50813] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Fene-mal
	[50814] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Corpsefeeder
	[50815] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Skarr
	[50816] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Ruun Ghostpaw
	[50817] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Ahone the Wanderer
	[50818] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- The Dark Prowler
	[50819] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Iceclaw
	[50820] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- Yul Wildpaw
	[50821] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Ai-Li Skymirror
	[50822] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Ai-Ran the Shifting Cloud
	[50823] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Mister Ferocious
	[50825] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Feras
	[50828] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Bonobos
	[50830] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = true  }, -- Spriggin
	[50831] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = true  }, -- Scritch
	[50832] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = true  }, -- The Yowler
	[50833] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Duskcoat
	[50836] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = true  }, -- Ik-Ik the Nimble
	[50837] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Kash
	[50838] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Tabbs
	[50839] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Chromehound
	[50840] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Major Nanners
	[50842] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Magmagan
	[50843] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = true,  is_achievement = false }, -- Portent
	[50846] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Slavermaw
	[50855] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BURNING_STEPPES,             is_tamable = true,  is_achievement = false }, -- Jaxx the Rabid
	[50856] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Snark
	[50858] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Dustwing
	[50864] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Thicket
	[50865] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Saurix
	[50874] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Tenok
	[50875] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Nychus
	[50876] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Avis
	[50882] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Chupacabros
	[50884] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Dustflight the Cowardly
	[50886] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Seawing
	[50891] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Boros
	[50892] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Cyn
	[50895] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Volux
	[50897] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Ffexk the Dunestalker
	[50901] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Teromak
	[50903] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Orlix the Swamplord
	[50905] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Cida
	[50906] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Mutilax
	[50908] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Nighthowl
	[50915] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Snort
	[50916] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Lamepaw the Whimperer
	[50922] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Warg
	[50925] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Grovepaw
	[50926] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Grizzled Ben
	[50929] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Little Bjorn
	[50930] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Hibernus the Sleeper
	[50931] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Mange
	[50937] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Hamhide
	[50940] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Swee
	[50942] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Snoot the Rooter
	[50945] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Scruff
	[50946] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Hogzilla
	[50947] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Varah
	[50948] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Crystalback
	[50949] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Finn's Gambit
	[50952] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Barnacle Jim
	[50955] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Carcinak
	[50957] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Hugeclaw
	[50959] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Karkin
	[50964] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WETLANDS,                    is_tamable = true,  is_achievement = false }, -- Chops
	[50967] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Craw the Ravager
	[50986] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Goldenback
	[50993] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Gal'dorak
	[50995] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Bruiser
	[50997] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Bornak the Gorer
	[51000] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Blackshell the Impenetrable
	[51001] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- Venomclaw
	[51002] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Scorpoxx
	[51004] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Toxx
	[51007] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Serkett
	[51008] = { world_id = ZN.KALIMDOR,                 map_name = ZN.THOUSAND_NEEDLES,            is_tamable = true,  is_achievement = false }, -- The Barbed Horror
	[51010] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Snips
	[51014] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Terrapis
	[51017] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Gezan
	[51018] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Zormus
	[51021] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.BADLANDS,                    is_tamable = true,  is_achievement = false }, -- Vorticus
	[51022] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Chordix
	[51025] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Dilennaa
	[51026] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Gnath
	[51027] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Spirocula
	[51028] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- The Deep Tunneler
	[51029] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Parasitus
	[51031] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Tracker
	[51037] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SILVERPINE_FOREST,           is_tamable = true,  is_achievement = false }, -- Lost Gilnean Wardog
	[51040] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Snuffles
	[51042] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Bleakheart
	[51044] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.TIRISFAL_GLADES,             is_tamable = true,  is_achievement = false }, -- Plague
	[51045] = { world_id = ZN.KALIMDOR,                 map_name = ZN.WINTERSPRING,                is_tamable = true,  is_achievement = false }, -- Arcanus
	[51046] = { world_id = ZN.KALIMDOR,                 map_name = ZN.FELWOOD,                     is_tamable = true,  is_achievement = false }, -- Fidonis
	[51048] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Rexxus
	[51052] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SWAMP_OF_SORROWS,            is_tamable = true,  is_achievement = false }, -- Gib the Banana-Hoarder
	[51053] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.EASTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Quirix
	[51057] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Weevil
	[51058] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.WESTERN_PLAGUELANDS,         is_tamable = true,  is_achievement = false }, -- Aphis
	[51059] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALLEY_OF_THE_FOUR_WINDS,    is_tamable = false, is_achievement = true  }, -- Blackhoof
	[51061] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Roth-Salam
	[51062] = { world_id = ZN.KALIMDOR,                 map_name = ZN.STONETALON_MOUNTAINS,        is_tamable = true,  is_achievement = false }, -- Khep-Re
	[51063] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Phalanax
	[51066] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SEARING_GORGE,               is_tamable = true,  is_achievement = false }, -- Crystalfang
	[51067] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ARATHI_HIGHLANDS,            is_tamable = true,  is_achievement = false }, -- Glint
	[51069] = { world_id = ZN.KALIMDOR,                 map_name = ZN.DUSTWALLOW_MARSH,            is_tamable = true,  is_achievement = false }, -- Scintillex
	[51071] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.SHIMMERING_EXPANSE,          is_tamable = false, is_achievement = false }, -- Captain Florence
	[51076] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.HILLSBRAD_FOOTHILLS,         is_tamable = true,  is_achievement = false }, -- Lopex
	[51077] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.ELWYNN_FOREST,               is_tamable = true,  is_achievement = false }, -- Bushtail
	[51078] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_JADE_FOREST,             is_tamable = false, is_achievement = true  }, -- Ferdinand
	[51079] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.VASHJIR,                     is_tamable = false, is_achievement = false }, -- Captain Foulwind
	[51401] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true,  is_achievement = false }, -- Madexx
	[51402] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true,  is_achievement = false }, -- Madexx
	[51403] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true,  is_achievement = false }, -- Madexx
	[51404] = { world_id = ZN.KALIMDOR,                 map_name = ZN.ULDUM,                       is_tamable = true,  is_achievement = false }, -- Madexx
	[51658] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = false, is_achievement = false }, -- Mogh the Dead
	[51661] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = true,  is_achievement = false }, -- Tsul'Kalu
	[51662] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = true,  is_achievement = false }, -- Mahamba
	[51663] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.NORTHERN_STRANGLETHORN,      is_tamable = true,  is_achievement = false }, -- Pogeyan
	[52146] = { world_id = ZN.EASTERN_KINGDOMS,         map_name = ZN.REDRIDGE_MOUNTAINS,          is_tamable = true,  is_achievement = false }, -- Chitter
	[54318] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true,  is_achievement = false }, -- Ankha
	[54319] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true,  is_achievement = false }, -- Magria
	[54320] = { world_id = ZN.KALIMDOR,                 map_name = ZN.MOUNT_HYJAL,                 is_tamable = true,  is_achievement = false }, -- Ban'thalos
	[54321] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Solix
	[54322] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Deth'tilac
	[54323] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Kirix
	[54324] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Skitterflame
	[54338] = { world_id = ZN.MOLTEN_FRONT,             map_name = ZN.MOLTEN_FRONT,                is_tamable = true,  is_achievement = false }, -- Anthriss
	[54533] = { world_id = ZN.KALIMDOR,                 map_name = ZN.SILITHUS,                    is_tamable = true,  is_achievement = false }, -- Prince Lakma
	[56081] = { world_id = ZN.HILLSBRAD_FOOTHILLS,      map_name = ZN.OLD_HILLSBRAD_FOOTHILLS,     is_tamable = false, is_achievement = false }, -- Optimistic Benj
	[58474] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = true,  is_achievement = true  }, -- Bloodtip
	[58768] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Cracklefang
	[58769] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Vicejaw
	[58771] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = false }, -- Quid
	[58778] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = false }, -- Aetha
	[58817] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Spirit of Lao-Fe
	[58949] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Bai-Jin the Butcher
	[59369] = { world_id = ZN.SCHOLOMANCE,              map_name = ZN.SCHOLOMANCE,                 is_tamable = false, is_achievement = false }, -- Doctor Theolen Krastinov
	[62880] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Gochao the Ironfist
	[62881] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Gaohun the Soul-Severer
	[63101] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- General Temuja
	[63240] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Shadowmaster Sydow
	[63509] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = true,  is_achievement = true  }, -- Wulon
	[63510] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = true,  is_achievement = true  }, -- Wulon
	[63691] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Huo-Shuang
	[63695] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Baolai the Immolator
	[63977] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Vyraxxis
	[63978] = { world_id = ZN.PANDARIA,                 map_name = ZN.VALE_OF_ETERNAL_BLOSSOMS,    is_tamable = false, is_achievement = true  }, -- Kri'chon
	[68317] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = false }, -- Mavis Harms
	[68318] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = false }, -- Dalan Nightbreaker
	[68319] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = false }, -- Disha Fearwarden
	[68320] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = false }, -- Ubunti the Shade
	[68321] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = false }, -- Kar Warmaker
	[68322] = { world_id = ZN.PANDARIA,                 map_name = ZN.KRASARANG_WILDS,             is_tamable = false, is_achievement = false }, -- Muerta
	[69099] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = false }, -- Nalak
	[69161] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_GIANTS,              is_tamable = false, is_achievement = false }, -- Oondasta
	[69664] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = false }, -- Mumta
	[69768] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = false }, -- Zandalari Warscout
	[69769] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = false }, -- Zandalari Warbringer
	[69841] = { world_id = ZN.PANDARIA,                 map_name = ZN.TOWNLONG_STEPPES,            is_tamable = false, is_achievement = false }, -- Zandalari Warbringer
	[69842] = { world_id = ZN.PANDARIA,                 map_name = ZN.DREAD_WASTES,                is_tamable = false, is_achievement = false }, -- Zandalari Warbringer
	[69843] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false, is_achievement = false }, -- Zao'cho
	[69996] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Ku'lai the Skyclaw
	[69997] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Progenitus
	[69998] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = true,  is_achievement = true  }, -- Goda
	[69999] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- God-Hulk Ramuk
	[70000] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Al'tabim the All-Seeing
	[70001] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Backbreaker Uru
	[70002] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Lu-Ban
	[70003] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = true  }, -- Molthor
	[70096] = { world_id = ZN.PANDARIA,                 map_name = ZN.ISLE_OF_GIANTS,              is_tamable = false, is_achievement = false }, -- War-God Dokah
	[70126] = { world_id = ZN.PANDARIA,                 map_name = ZN.THE_VEILED_STAIR,            is_tamable = false, is_achievement = false }, -- Willy Wilder
	[70238] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false, is_achievement = false }, -- Unblinking Eye
	[70249] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false, is_achievement = false }, -- Focused Eye
	[70276] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false, is_achievement = false }, -- No'ku Stormsayer
	[70323] = { world_id = ZN.PANDARIA,                 map_name = ZN.KUN_LAI_SUMMIT,              is_tamable = false, is_achievement = false }, -- Krakkanon
	[70430] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false, is_achievement = false }, -- Rocky Horror
	[70440] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.THRONE_OF_THUNDER,           is_tamable = false, is_achievement = false }, -- Monara
	[70530] = { world_id = ZN.ISLE_OF_THUNDER,          map_name = ZN.ISLE_OF_THUNDER,             is_tamable = false, is_achievement = false }, -- Ra'sha
	[71864] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Spelurk
	[71919] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Zhu-Gon the Sour
	[72045] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Chelon
	[72048] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Rattleskew
	[72049] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Cranegnasher
	[72193] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Karkanos
	[72245] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Zesqua
	[72769] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Spirit of Jadefire
	[72775] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Bufo
	[72808] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true,  is_achievement = true  }, -- Tsavo'ka
	[72909] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Gu'chi the Swarmbringer
	[72970] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Golganarr
	[73157] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Rock Moss
	[73158] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true,  is_achievement = true  }, -- Emerald Gander
	[73160] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Ironfur Steelhorn
	[73161] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true,  is_achievement = true  }, -- Great Turtle Furyshell
	[73163] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Imperial Python
	[73166] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = true,  is_achievement = true  }, -- Monstrous Spineclaw
	[73167] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Huolon
	[73169] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Jakur of Ordon
	[73170] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Watcher Osu
	[73171] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Champion of the Black Flame
	[73172] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Flintlord Gairan
	[73173] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Urdur the Cauterizer
	[73174] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Archiereus of Flame
	[73175] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Cinderfall
	[73277] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Leafmender
	[73279] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Evermaw
	[73281] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Dread Ship Vazuvius
	[73282] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Garnia
	[73293] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = false }, -- Whizzig
	[73666] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Archiereus of Flame
	[73704] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Stinkbraid
	[73854] = { world_id = ZN.PANDARIA,                 map_name = ZN.TIMELESS_ISLE,               is_tamable = false, is_achievement = true  }, -- Cranegnasher
}

private.NPC_ID_TO_MAP_NAME = {}
private.NPC_ID_TO_NAME = {}
private.NPC_ID_TO_WORLD_NAME = {}
private.NPC_NAME_TO_ID = {}


private.TAMABLE_ID_TO_MAP_NAME = {}
private.TAMABLE_ID_TO_NAME = {}
private.TAMABLE_ID_TO_WORLD_NAME = {}
private.TAMABLE_NON_ACHIEVMENT_LIST = {}


private.UNTAMABLE_ID_TO_MAP_NAME = {}
private.UNTAMABLE_ID_TO_NAME = {}
private.UNTAMABLE_ID_TO_WORLD_NAME = {}


for npc_id, data in pairs(NPC_DATA) do
	private.NPC_ID_TO_MAP_NAME[npc_id] = data.map_name
	private.NPC_ID_TO_NAME[npc_id] = L.NPCs[tostring(npc_id)]
	private.NPC_ID_TO_WORLD_NAME[npc_id] = data.world_id
	private.NPC_NAME_TO_ID[L.NPCs[tostring(npc_id)]] = npc_id

	if data.is_tamable then
		private.TAMABLE_ID_TO_MAP_NAME[npc_id] = data.map_name
		private.TAMABLE_ID_TO_NAME[npc_id] = L.NPCs[tostring(npc_id)]
		private.TAMABLE_ID_TO_WORLD_NAME[npc_id] = data.world_id
		--Builds a list of non achievement mobs for the Beast tab
		if not data.is_achievement then
			private.TAMABLE_NON_ACHIEVMENT_LIST[npc_id] = L.NPCs[tostring(npc_id)]
		end

	elseif not data.is_achievement then
		private.UNTAMABLE_ID_TO_MAP_NAME[npc_id] = data.map_name
		private.UNTAMABLE_ID_TO_NAME[npc_id] = L.NPCs[tostring(npc_id)]
		private.UNTAMABLE_ID_TO_WORLD_NAME[npc_id] = data.world_id
	end
end


do
	local function TableKeyFormat(input)
		if not input then
			return ""
		end

		return input:upper():gsub(" ", "_"):gsub("'", ""):gsub(":", ""):gsub("-", "_"):gsub("%(", ""):gsub("%)", "")
	end


	local function rpad(input, length)
		return (" "):rep(length - #input)
	end


	local CONTINENT_NAMES = {
		"KALIMDOR",
		"EASTERN_KINGDOMS",
		"OUTLAND",
		"NORTHREND",
		"THE_MAELSTROM",
		"PANDARIA",
	}


	function private.DumpNPCData()
		if not private.TextDump then
			return
		end
		local output = private.TextDump
		local data = NPC_DATA
		local dump_data = {}
		local longest_world = 0
		local longest_map = 0
		local longest_id = 0

		for npc_id, data in pairs(NPC_DATA) do
			local source = NPC_DATA[npc_id]
			dump_data[npc_id] = {
				world_id = ("ZN.%s"):format(TableKeyFormat(source.world_id)),
				map_name = source.map_name and ("ZN.%s"):format(TableKeyFormat(source.map_name)) or tostring(nil),
				is_tamable = source.is_tamable,
				is_achievement = source.is_achievement,
			}

			if #dump_data[npc_id].world_id > longest_world then
				longest_world = #dump_data[npc_id].world_id
			end

			if #dump_data[npc_id].map_name > longest_map then
				longest_map = #dump_data[npc_id].map_name
			end

			local id_str = tostring(npc_id)
			if #id_str > longest_id then
				longest_id = #id_str
			end
		end

		local npc_output = {}

		for npc_id in pairs(dump_data) do
			npc_output[#npc_output + 1] = npc_id
		end
		table.sort(npc_output)

		output:Clear()
		output:AddLine("local NPC_DATA = {")

		for index = 1, #npc_output do
			local npc_id = npc_output[index]
			local info = dump_data[npc_id]
			output:AddLine(("[%d]%s = { world_id = %s,%s map_name = %s,%s is_tamable = %s,%s is_achievement = %s%s }, -- %s"):format(
				npc_id,
				rpad(tostring(npc_id), longest_id),
				tostring(info.world_id),
				rpad(tostring(info.world_id), longest_world),
				tostring(info.map_name),
				rpad(tostring(info.map_name), longest_map),
				tostring(info.is_tamable),
				rpad(tostring(info.is_tamable), 5),
				tostring(info.is_achievement),
				rpad(tostring(info.is_achievement), 5),
				private.L.NPCs[tostring(npc_id)] or "**** NO LOCALIZATION ****")
			)
		end

		output:AddLine("}")
		output:Display()
	end
end -- do-block
