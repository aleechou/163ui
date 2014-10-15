--
-- JSHB - default timers for importing
--

--[[
	Index for timer fields
	
	1 : Spell
	2 : Item
	3 : Check target
	4 : Check type
	5 : Owner
	6 : What specilization (0 = all or 1 - 3 respectively)
	7 : Timer text position
	8 : Flash when expiring?
	9 : Only if known flag (nil or true)
	10: <removed, was growth setting>
	11:  - <removed, Grow start>
	12:  - <removed, Grow size>
	13: Change alpha over time?
	14:  - Alpha Start
	15:  - Alpha End
	16: Internal Cooldown time
	17: Last time for Internal Cooldown
	18: Show the icon when? { 1 = Active / 0 or nil = Always }
	19: Position on bar (values: 1 - total timers)
	20: Inactive Alpha when "always" on bar for stationary timers
	21: Collapse flag, for options (used internally)
	22: Conditions table or nil
]]

JSHB.importTimers = {
	DEATHKNIGHT = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 138759, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 9 , 0.5 }, -- Fabled Feather of Ji-Kun
			{ 138973, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Rune of Re-Origination
			{ 138702, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Brutal Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138759, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 2 , 0.5 }, -- Fabled Feather of Ji-Kun
			{ 138973, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4 , 0.5 }, -- Rune of Re-Origination
			{ 138702, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Brutal Talisman of the Shado-Pan Assault
		},
	},
	DRUID = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 138756, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 1 , 0.5 }, -- Renataki's Soul Charm
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 2 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 3 , 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 138973, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 4 , 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138756, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 22 , nil, 1 , 2 , 0.5 }, -- Renataki's Soul Charm
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30 , nil, 1 , 4 , 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 138973, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 6 , 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 7 , 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 8 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
	},
	HUNTER = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 1978  , nil, "target", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 1 , 0.5 }, -- Serpent Sting
			{ 82654 , nil, "target", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 2 , 0.5 }, -- Widow Venom
			{ 3045  , nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 3 , 0.5 }, -- Rapid Fire
			{ 34692 , nil, "player", "DURATION", "PLAYERS", 1, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 4 , 0.5 }, -- The Beast Within
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 136   , nil, "pet"   , "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 9 , 0.5 }, -- Mend Pet
			{ 53220 , nil, "player", "DURATION", "PLAYERS", 2, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Improved Steady Shot
			{ 3674  , nil, "target", "DURATION", "PLAYERS", 3, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Black Arrow
			{ 131894, nil, "target", "DURATION", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 12, 0.5 }, -- A Murder of Crows
			{ 82726 , nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Fervor
			{ 20572 , nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 14, 0.5 }, -- Blood Fury
			{ 121818, nil, "target", "DURATION", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 15, 0.5 }, -- Stampede
			{ 105697, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 16, 0.5 }, -- Virmen's Bite
			{ 128984, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 17, 0.5 }, -- Blessing of the Celestials
			{ 126649, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 18, 0.5 }, -- Terror in the Mists (Unrelenting Attacks)
			{ 109085, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 18, 0.5 }, -- Lord Blastington's Scope of Doom
			{ 138756, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 19, 0.5 }, -- Renataki's Soul Charm
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 20, 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 21, 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 19574 , nil, "pet"   , "COOLDOWN", "PLAYERS", 1, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 1 , 0.5 }, -- Bestial Wrath
			{ 34026 , nil, "player", "COOLDOWN", "PLAYERS", 1, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 2 , 0.5 }, -- Kill Command
			{ 117050, nil, "target", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 3 , 0.5 }, -- Glaive Toss
			{ 131894, nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 4 , 0.5 }, -- A Murder of Crows
			{ 121818, nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 5 , 0.5 }, -- Stampede
			{ 90361 , nil, "player", "COOLDOWN", "PLAYERS", 1, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Spirit Mend
			{ 3045  , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 7 , 0.5 }, -- Rapid Fire
			{ 23989 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 8 , 0.5 }, -- Readiness
			{ 3674  , nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 9 , 0.5 }, -- Black Arrow
			{ 109248, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Binding Shot
			{ 19386 , nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Wyvern Sting
			{ 109304, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Exhileration
			{ 120679, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 13, 0.5 }, -- Dire Beast
			{ 130392, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 14, 0.5 }, -- Blink Strike
			{ 120697, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 15, 0.5 }, -- Lynx Rush
			{ 109259, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 16, 0.5 }, -- Power Shot
			{ 120360, nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 0 , 17, 0.5 }, -- Barrage
			{ 34490 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 18, 0.5 }, -- Silencing Shot
			{ 105697, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 19, 0.5 }, -- Virmen's Bite
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 128984, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Blessing of the Celestials
			{ 126649, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 105, nil, 1 , 2 , 0.5 }, -- Terror in the Mists
			{ 126554, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 45, nil, 1 , 3 , 0.5 }, -- Full of Stars
			{ 127928, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 50, nil, 1 , 4 , 0.5 }, -- Reflection of Torment
			{ 126483, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 65, nil, 1 , 5 , 0.5 }, -- Windswept Pages
			{ 126489, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 85, nil, 1 , 6 , 0.5 }, -- Searing Words
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 7 , 0.5 }, -- Zen Alchemist Stone
			{ 126707, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 50, nil, 1 , 8 , 0.5 }, -- Surge of Conquest
			{ 125489, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 9 , 0.5 }, -- Swordguard Embroidery
			{ 109085, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 9 , 0.5 }, -- Lord Blastington's Scope of Doom
			{ 138756, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 22 , nil, 1 , 10, 0.5 }, -- Renataki's Soul Charm
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 11, 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 12, 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
		},
	},
	MAGE = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 1 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 2 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 3 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 4 , 0.5 }, -- Blood Lust
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Wushoolay's Final Choice
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 2 , 0.5 }, -- Wushoolay's Final Choice
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
	},
	MONK = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 128984, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0, nil, 1 , 9 , 0.5 }, -- Blessing of the Celestials
			{ 138756, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Renataki's Soul Charm
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 138973, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 14, 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 15, 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 16, 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138756, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 22 , nil, 1 , 2 , 0.5 }, -- Renataki's Soul Charm
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30 , nil, 1 , 4 , 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 138973, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 6 , 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 7 , 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 8 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
	},
	PALADIN = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 9 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 138759, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, .4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Fabled Feather of Ji-Kun
			{ 138973, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 14, 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
			{ 138702, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 15, 0.5 }, -- Brutal Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 2 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30 , nil, 1 , 3 , 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 138759, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4 , 0.5 }, -- Fabled Feather of Ji-Kun
			{ 138973, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 6 , 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 7 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
			{ 138702, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 6 , 0.5 }, -- Brutal Talisman of the Shado-Pan Assault
		},
	},
	PRIEST = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 9 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 2 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30 , nil, 1 , 3 , 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4 , 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
	},
	ROGUE = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 128984, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0, nil, 1 , 9 , 0.5 }, -- Blessing of the Celestials
			{ 126649, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Terror in the Mists (Unrelenting Attacks)
			{ 138756, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Renataki's Soul Charm
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138756, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 22, nil, 1 , 2 , 0.5 }, -- Renataki's Soul Charm
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4, 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
		},
	},
	SHAMAN = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
			{ 128984, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0, nil, 1 , 9 , 0.5 }, -- Blessing of the Celestials
			{ 126649, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Terror in the Mists (Unrelenting Attacks)
			{ 138756, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Renataki's Soul Charm
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 14, 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 15, 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 16, 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138756, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 22 , nil, 1 , 2 , 0.5 }, -- Renataki's Soul Charm
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Wushoolay's Final Choice
			{ 140380, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30 , nil, 1 , 4 , 0.5 }, -- Inscribed Bag of Hydra-Spawn
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Rune of Re-Origination
			{ 138699, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 6 , 0.5 }, -- Vicious Talisman of the Shado-Pan Assault
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 7 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
	},
	WARLOCK = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 1 , 0.5 }, -- Heroism
			{ 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 2 , 0.5 }, -- Ancient Hysteria
			{ 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 3 , 0.5 }, -- Time Warp
			{ 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 4 , 0.5 }, -- Blood Lust
			{ 138786, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Wushoolay's Final Choice
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138786, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 2 , 0.5 }, -- Wushoolay's Final Choice
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Rune of Re-Origination
			{ 138703, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4 , 0.5 }, -- Volatile Talisman of the Shado-Pan Assault
		},
	},
	WARRIOR = {
		DURATIONS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 32182 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Heroism
            { 90355 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Ancient Hysteria
            { 80353 , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Time Warp
            { 2825  , nil, "player", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Blood Lust
            { 105706, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 5 , 0.5 }, -- Potion of Mogu Power
            { 64382 , nil, "target", "DURATION", "ANY"    , 0, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Shattering Throw
            { 1719  , nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Recklessness
            { 871   , nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Shield Wall
            { 125565, nil, "player", "DURATION", "PLAYERS", 3, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 9 , 0.5 }, -- Demoralizing Shout
            { 118038, nil, "player", "DURATION", "PLAYERS", 2, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Die by the Sword - Fury
            { 118038, nil, "player", "DURATION", "PLAYERS", 1, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Die by the Sword - Arms
            { 12975 , nil, "player", "DURATION", "PLAYERS", 3, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Last Stand
            { 114192, nil, "player", "DURATION", "PLAYERS", 3, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Mocking Banner
            { 97462 , nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 14, 0.5 }, -- Rallying Cry
            { 132404, nil, "player", "DURATION", "PLAYERS", 3, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 15, 0.5 }, -- Shield Block
            { 115798, nil, "target", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 16, 0.5 }, -- Weakend Blows
			{ 138759, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 17, 0.5 }, -- Fabled Feather of Ji-Kun
			{ 138973, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 18, 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 19, 0.5 }, -- Rune of Re-Origination
			{ 138702, nil, "player", "DURATION", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 0 , nil, 1 , 20, 0.5 }, -- Brutal Talisman of the Shado-Pan Assault
		},
		COOLDOWNS = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 12294 , nil, "player", "COOLDOWN", "PLAYERS", 1, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 6 , 0.5 }, -- Mortal Strike
            { 23881 , nil, "player", "COOLDOWN", "PLAYERS", 2, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 7 , 0.5 }, -- Bloodthirst                   
            { 23922 , nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 8 , 0.5 }, -- Shield Bash
            { 86346 , nil, "player", "COOLDOWN", "PLAYERS", 1, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 9 , 0.5 }, -- Colossus Smash - Fury
            { 86346 , nil, "player", "COOLDOWN", "PLAYERS", 2, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 10, 0.5 }, -- Colossus Smash - Arms
            { 6572  , nil, "player", "COOLDOWN", "PLAYERS", 3, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 11, 0.5 }, -- Revenge
            { 18499 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 12, 0.5 }, -- Berserker Rage
            { 46924 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 13, 0.5 }, -- Bladestorm
            { 46968 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 14, 0.5 }, -- Shockwave
            { 118000, nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 15, 0.5 }, -- Dragon Roar
            { 85730 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 16, 0.5 }, -- Deadly calm
            { 107574, nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 17, 0.5 }, -- Avatar
            { 12292 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 18, 0.5 }, -- Bloodbath
            { 107570, nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, true, nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 19, 0.5 }, -- Storm Bolt
            { 114207, nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 20, 0.5 }, -- Skull Banner
            { 64382 , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 21, 0.5 }, -- Shattering Throw
            { 1719  , nil, "player", "COOLDOWN", "PLAYERS", 0, "CENTER", nil, nil , nil, 0.4, 1.4, nil, 0.4, 1 , 0 , nil, 1 , 22, 0.5 }, -- Recklessness
		},
		ICD = {
		----{ 1     , 2  , 3       , 4         , 5        , 6, 7       , 8  , 9  , 10 , 11 , 12 , 13 , 14, 15, 16, 17 , 18, 19, 20   , 21,  22 }, -- Index
			{ 105574, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 55, nil, 1 , 1 , 0.5 }, -- Zen Alchemist Stone
			{ 138759, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 2 , 0.5 }, -- Fabled Feather of Ji-Kun
			{ 138973, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 3 , 0.5 }, -- Ji-Kun's Rising Winds
			{ 139116, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 4 , 0.5 }, -- Rune of Re-Origination
			{ 138702, nil, "player", "ICOOLDOWN", "PLAYERS", 0, "CENTER", nil, nil, nil, nil, nil, nil, 0.4, 1 , 30, nil, 1 , 5 , 0.5 }, -- Brutal Talisman of the Shado-Pan Assault
		},
	},
}
