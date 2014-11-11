local major = "DRData-1.0"
local minor = 1037
assert(LibStub, string.format("%s requires LibStub.", major))

local Data = LibStub:NewLibrary(major, minor)
if( not Data ) then return end

local wow_600 = select(4, GetBuildInfo()) >= 60000

local L = {
	["Roots"] = "Roots",
	["Stuns"] = "Stuns",
	["Cyclone"] = "Cyclone",
	["Disarms"] = "Disarms",
	["Mesmerizes"] = "Mesmerizes",
	["Mesmerizes (short)"] = "Mesmerizes (short)",
	["Fears"] = "Fears",
	["Horrors"] = "Horrors",
	["Mind Control"] = "Mind Control",
	["Stuns (short)"] = "Stuns (short)",
	["Silences"] = "Silences",
	["Taunts"] = "Taunts",
	["Roots (short)"] = "Roots (short)",
	["Knockbacks"] = "Knockbacks",
	["Incapacitates"] = "Incapacitates",
}

local locale = GetLocale()
if locale == "deDE" then
	
elseif locale == "esES" then
	L["Cyclone"] = "Ciclón"
L["Disarms"] = "Desarmes"
L["Fears"] = "Miedos"
L["Horrors"] = "Horrores"
L["Knockbacks"] = "Derribos"
L["Mesmerizes"] = "Hipnotizaciones"
L["Mesmerizes (short)"] = "Hipnotizaciones (cortas)"
L["Mind Control"] = "Control Mental"
L["Roots"] = "Raíces"
L["Roots (short)"] = "Raíces (cortas)"
L["Silences"] = "SIlencios"
L["Stuns"] = "Aturdimientos"
L["Stuns (short)"] = "Aturdimientos (cortos)"
L["Taunts"] = "Provocaciones"

elseif locale == "esMX" then
	L["Cyclone"] = "Ciclón"
L["Disarms"] = "Desarmes"
L["Fears"] = "Miedos"
L["Horrors"] = "Horrores"
L["Knockbacks"] = "Derribos"
L["Mesmerizes"] = "Hipnotizaciones"
L["Mesmerizes (short)"] = "Hipnotizaciones (cortas)"
L["Mind Control"] = "Control Mental"
L["Roots"] = "Raíces"
L["Roots (short)"] = "Raíces (cortas)"
L["Silences"] = "SIlencios"
L["Stuns"] = "Aturdimientos"
L["Stuns (short)"] = "Aturdimientos (cortos)"
L["Taunts"] = "Provocaciones"

elseif locale == "frFR" then
	L["Cyclone"] = "Cyclone"
L["Disarms"] = "Désarmements"
L["Fears"] = "Peurs"
L["Horrors"] = "Horreurs"
L["Knockbacks"] = "Projections"
L["Mesmerizes"] = "Désorientations"
L["Mesmerizes (short)"] = "Désorientations (courtes)"
L["Mind Control"] = "Contrôle mental"
L["Roots"] = "Immobilisations"
L["Roots (short)"] = "Immobilisations (courtes)"
L["Silences"] = "Silences"
L["Stuns"] = "Etourdissements"
L["Stuns (short)"] = "Etourdissements (courts)"
L["Taunts"] = "Provocations"

elseif locale == "itIT" then
	
elseif locale == "koKR" then
	
elseif locale == "ptBR" then
	
elseif locale == "ruRU" then
	
elseif locale == "zhCN" then
	
elseif locale == "zhTW" then
	L["Cyclone"] = "颶風術"
L["Disarms"] = "繳械"
L["Fears"] = "恐懼"
L["Horrors"] = "恐慌"
L["Knockbacks"] = "擊退"
L["Mesmerizes"] = "迷惑"
L["Mesmerizes (short)"] = "迷惑(短)"
L["Mind Control"] = "心靈控制"
L["Roots"] = "定身"
L["Roots (short)"] = "定身(短)"
L["Silences"] = "沉默"
L["Stuns"] = "昏迷"
L["Stuns (short)"] = "昏迷(短)"
L["Taunts"] = "嘲諷"

end

-- How long before DR resets ?
Data.resetTimes = {
	-- The official delay is 15 seconds, but the server only checks this every 5 seconds, so it
	-- actually ranges from 15 to 20 seconds, 18 is a good average.
	default   = 18,
	-- Knockbacks are a special case
	knockback = 10,
}
Data.RESET_TIME = Data.resetTimes.default

-- Successives diminished durations
Data.diminishedDurations = {
	-- Decreases by 50%, immune at the 4th application
	default   = { 0.50, 0.25 },
	-- Decreases by 35%, immune at the 5th application
	taunt     = { 0.65, 0.42, 0.27 },
	-- Immediately immune
	knockback = {},
}

-- Spells and providers by categories
--[[ Generic format:
	category = {
		-- When the debuff and the spell that applies it are the same:
		debuffId = true
		-- When the debuff and the spell that applies it differs:
		debuffId = spellId
		-- When several spells applies the debuff:
		debuffId = {spellId1, spellId2, ...}
	}
--]]
local spellsAndProvidersByCategory = wow_600 and {
-- Warlords of Draenor categories
-- See http://blue.mmo-champion.com/topic/326364-diminishing-returns-in-warlords-of-draenor/
-- The original thread on Blizzard forums is 404.

	--[[ TAUNT ]]--
	taunt = {
		-- Death Knight
		[ 56222] = true, -- Dark Command
		[ 57603] = true, -- Death Grip
		-- I have also seen these two spellIDs used for the Death Grip debuff in MoP.
		-- I have not seen the first one here in any of my MoP testing, but it may still be valid.
		[ 49560] = true, -- Death Grip
		[ 51399] = true, -- Death Grip
		-- Druid
		[  6795] = true, -- Growl
		-- Hunter
		[ 20736] = true, -- Distracting Shot
		-- Monk
		[116189] = 115546, -- Provoke
		[118635] = 115546, -- Provoke via the Black Ox Statue -- NEED TESTING
		[118585] = 115543, -- Leer of the Ox -- NEED TESTING
		-- Paladin
		[ 62124] = true, -- Reckoning
		-- Warlock
		[ 17735] = true, -- Suffering (Voidwalker)
		-- Warrior
		[   355] = true, -- Taunt
		-- Shaman
		[ 36213] = true, -- Angered Earth (Earth Elemental)
	},

	--[[ INCAPACITATES ]]--
	incapacitate = {
		-- Druid
		[    99] = true, -- Incapacitating Roar (talent)
		-- Hunter
		[  3355] = {1499, 60192}, -- Freezing Trap
		[ 19386] = true, -- Wyvern Sting
		-- Mage
		[   118] = true, -- Polymorph
		[ 28272] = true, -- Polymorph (pig)
		[ 28271] = true, -- Polymorph (turtle)
		[ 61305] = true, -- Polymorph (black cat)
		[ 61025] = true, -- Polymorph (serpent) -- FIXME: gone ?
		[ 61721] = true, -- Polymorph (rabbit)
		[ 61780] = true, -- Polymorph (turkey)
		[ 82691] = true, -- Ring of Frost
		[ 31661] = true, -- Dragon's Breath
		-- Monk
		[115078] = true, -- Paralysis
		[123393] = true, -- Breath of Fire (Glyphed)
		[137460] = 116844, -- Ring of Peace -- FIXME: correct spellIDs?
		-- Paladin
		[ 20066] = true, -- Repentance
		-- Priest
		[   605] = true, -- Dominate Mind
		[  9484] = true, -- Shackle Undead
		[ 64044] = true, -- Psychic Horror (Horror effect)
		[ 88625] = true, -- Holy Word: Chastise
		-- Rogue
		[  1776] = true, -- Gouge
		[  6770] = true, -- Sap
		-- Shaman
		[ 51514] = true, -- Hex
		-- Warlock
		[   710] = true, -- Banish -- Glyph of Crimson Banish ?
		[111397] = true, -- Blood Horror
		[  6789] = true, -- Mortal Coil
		-- Pandaren
		[107079] = true, -- Quaking Palm
	},

	--[[ SILENCES ]]--
	silence = {
		-- Death Knight
		[108194] = true, -- Asphyxiate (if target is immune to stun)
		[ 47476] = true, -- Strangulate
		-- Druid
		[114237] = true, -- Glyph of Fae Silence
		-- Mage
		[102051] = true, -- Frostjaw
		-- Paladin
		[ 31935] = true, -- Avenger's Shield
		-- Priest
		[ 15487] = true, -- Silence
		-- Rogue
		[  1330] = true, -- Garrote
		-- Blood Elf
		[ 25046] = true, -- Arcane Torrent (Energy version)
		[ 28730] = true, -- Arcane Torrent (Mana version)
		[ 50613] = true, -- Arcane Torrent (Runic power version)
		[ 69179] = true, -- Arcane Torrent (Rage version)
		[ 80483] = true, -- Arcane Torrent (Focus version)
	},

	--[[ DISORIENTS ]]--
	disorient = {
		-- Druid
		[ 33786] = true, -- Cyclone
		-- Paladin
		[105421] = true, -- Blinding Light -- FIXME: is this the right category? Its missing from blizzard's list
		[ 10326] = true, -- Turn Evil
		-- Priest
		[  8122] = true, -- Psychic Scream
		-- Rogue
		[  2094] = true, -- Blind
		-- Warlock
		[  5782] = true, -- Fear
		[118699] = 5782, -- Fear -- new SpellID in MoP, Blood Fear uses same ID
		[  5484] = true, -- Howl of Terror
		[115268] = true, -- Mesmerize (Shivarra)
		[  6358] = true, -- Seduction (Succubus)
		-- Warrior
		[  5246] = true, -- Intimidating Shout (main target)
	},

	--[[ STUNS ]]--
	ctrlstun = {
		-- Death Knight
		[108194] = true, -- Asphyxiate
		[ 91800] = true, -- Gnaw (Ghoul)
		[ 91797] = true, -- Monstrous Blow (Dark Transformation Ghoul)
		[115001] = true, -- Remorseless Winter
		-- Druid
		[ 22570] = true, -- Maim
		[  5211] = true, -- Mighty Bash
		-- FIXME: Pounce
		--[163505] = true, -- Rake (Stun from Prowl)
		-- Hunter
		[117526] = 109248, -- Binding Shot
		[ 24394] = 19577, -- Intimidation
		-- Mage
		[ 44572] = true, -- Deep Freeze
		-- Monk
		[119392] =   true, -- Charging Ox Wave
		[120086] = 113656, -- Fists of Fury
		[119381] =   true, -- Leg Sweep
		-- Paladin
		[   853] = true, -- Hammer of Justice
		[119072] = true, -- Holy Wrath
		[105593] = true, -- Fist of Justice
		-- Rogue
		[  1833] = true, -- Cheap Shot
		[   408] = true, -- Kidney Shot
		-- Shaman
		[118345] = true, -- Pulverize (Primal Earth Elemental)
		[118905] = true, -- Static Charge (Capacitor Totem)
		-- Warlock
		[ 89766] = true, -- Axe Toss (Felguard)
		[ 30283] = true, -- Shadowfury
		[ 22703] = 1122, -- Summon Infernal
		-- Warrior
		[132168] = true, -- Shockwave
		[132169] = true, -- Storm Bolt
		-- Tauren
		[ 20549] = true, -- War Stomp
	},

	--[[ ROOTS ]]--
	ctrlroot = {
		-- Death Knight
		[ 96294] = true, -- Chains of Ice (Chilblains Root)
		-- Druid
		[   339] = true, -- Entangling Roots
		[102359] = true, -- Mass Entanglement (talent)
		[113770] = true, -- Entangling Roots (Treants)
		-- Hunter
		[ 53148] = 61685, -- Charge (Tenacity pet)
		[135373] = true, -- Entrapment (passive)
		[136634] = true, -- Narrow Escape (passive talent)
		-- Mage
		[   122] = true, -- Frost Nova
		[ 33395] = true, -- Freeze (Water Elemental)
		[111340] = true, -- Ice Ward
		-- Monk
		[116706] = 116095, -- Disable
		-- Priest
		[ 87194] = true, -- Glyph of Mind Blast
		[114404] = true, -- Void Tendrils
		-- Shaman
		[ 63685] = true, -- Freeze (Frozen Power talent)
		[ 64695] = true, -- Earthgrab Totem
	},

	--[[ KNOCKBACK ]]--
	knockback = {
		-- Death Knight
		[108199] = true, -- Gorefiend's Grasp
		-- Druid
		[102793] = true, -- Ursol's Vortex
		[132469] = true, -- Typhoon
		-- Hunter
		[119403] = true, -- Glyph of Explosive Trap
		-- Shaman
		[ 51490] = true, -- Thunderstorm
		-- Warlock
		[  6360] = true, -- Whiplash
		[115770] = true, -- Fellash
	},
} or {
-- Mists of Pandaria categories
-- See http://us.battle.net/wow/en/forum/topic/10195910192

	--[[ TAUNT ]]--
	taunt = {
		-- Death Knight
		[ 56222] = true, -- Dark Command
		[ 57603] = true, -- Death Grip
		-- I have also seen these two spellIDs used for the Death Grip debuff in MoP.
		-- I have not seen the first one here in any of my MoP testing, but it may still be valid.
		[ 49560] = true, -- Death Grip
		[ 51399] = true, -- Death Grip
		-- Druid
		[  6795] = true, -- Growl
		-- Hunter
		[ 20736] = true, -- Distracting Shot
		-- Monk
		[116189] = 115546, -- Provoke
		[118635] = 115546, -- Provoke via the Black Ox Statue -- NEED TESTING
		[118585] = 115543, -- Leer of the Ox -- NEED TESTING
		-- Paladin
		[ 62124] = true, -- Reckoning
		-- Warlock
		[ 17735] = true, -- Suffering (Voidwalker)
		-- Warrior
		[   355] = true, -- Taunt
		-- Shaman
		[ 36213] = true, -- Angered Earth (Earth Elemental)
	},

	--[[ MESMERIZES ]]--
	-- Note: reuse the previously-used "disorient" category to avoid breaking addons
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#4
	disorient = {
		-- Druid
		[  2637] = true, -- Hibernate
		-- Hunter
		[  3355] = {1499, 60192}, -- Freezing Trap
		[ 19386] = true, -- Wyvern Sting
		-- Mage
		[   118] = true, -- Polymorph
		[ 28272] = true, -- Polymorph (pig)
		[ 28271] = true, -- Polymorph (turtle)
		[ 61305] = true, -- Polymorph (black cat)
		[ 61025] = true, -- Polymorph (serpent) -- FIXME: gone ?
		[ 61721] = true, -- Polymorph (rabbit)
		[ 61780] = true, -- Polymorph (turkey)
		[ 82691] = true, -- Ring of Frost
		-- Monk
		[115078] = true, -- Paralysis
		-- Paladin
		[ 20066] = true, -- Repentance
		-- Priest
		[  9484] = true, -- Shackle Undead
		-- Rogue
		[  1776] = true, -- Gouge
		[  6770] = true, -- Sap
		-- Shaman
		[ 76780] = true, -- Bind Elemental
		[ 51514] = true, -- Hex
		-- Warlock
		[   710] = true, -- Banish -- Glyph of Crimson Banish ?
		-- Pandaren
		[107079] = true, -- Quaking Palm
	},

	--[[ SHORT MESMERIZES ]]--
	-- Note: this category does not share diminishing returns with the above Mesmerize category.
	-- Called "Mesmerize". http://us.battle.net/wow/en/forum/topic/10195910192#4
	shortdisorient = {
		-- Druid
		[    99] = true, -- Disorienting Roar (talent)
		-- Hunter
		[ 19503] = true, -- Scatter Shot
		-- Mage
		[ 31661] = true, -- Dragon's Breath
		-- Monk
		[123393] = true, -- Breath of Fire (Glyphed)
		-- Priest
		[ 88625] = true, -- Holy Word: Chastise
	},

	--[[ SILENCES ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#6
	silence = {
		-- Death Knight
		[108194] = true, -- Asphyxiate (if target is immune to stun)
		[ 47476] = true, -- Strangulate
		-- Druid
		[114237] = true, -- Glyph of Fae Silence
		-- Hunter
		[ 34490] = true, -- Silencing Shot
		-- Mage
		[102051] = true, -- Frostjaw
		[ 55021] = true, -- Counterspell
		-- Monk
		[137460] = 116844, -- Ring of Peace (Silence effect)
		[116709] = 116705, -- Spear Hand Strike
		-- Paladin
		[ 31935] = true, -- Avenger's Shield
		-- Priest
		[ 15487] = true, -- Silence
		-- Rogue
		[  1330] = true, -- Garrote
		-- Warlock
		[ 24259] = 19647, -- Spell Lock (Fel Hunter)
		[115782] = 115781, -- Optical Blast (Observer)
		-- Blood Elf
		[ 25046] = true, -- Arcane Torrent (Energy version)
		[ 28730] = true, -- Arcane Torrent (Mana version)
		[ 50613] = true, -- Arcane Torrent (Runic power version)
		[ 69179] = true, -- Arcane Torrent (Rage version)
		[ 80483] = true, -- Arcane Torrent (Focus version)
	},

	--[[ DISARMS ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#7
	disarm = {
		-- Hunter
		[ 50541] = true, -- Clench (Scorpid pet)
		[ 91644] = true, -- Snatch (Bird of Prey pet)
		-- Monk
		[117368] =   true, -- Grapple Weapon
		[126458] =   true, -- Grapple Weapon (Symbiosis)
		[137461] = 116844, -- Ring of Peace (Disarm effect)
		-- Priest
		[ 64058] = true, -- Psychic Horror (Disarm effect)
		-- Rogue
		[ 51722] = true, -- Dismantle
		-- Warlock
		[118093] = true, -- Disarm (Voidwalker/Voidlord)
		-- Warrior
		[   676] = true, -- Disarm
	},

	--[[ FEARS ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#5
	fear = {
		-- Druid
		[113004] = true, -- Intimidating Roar (Symbiosis)
		[113056] = true, -- Intimidating Roar (Symbiosis)
		-- Hunter
		[  1513] = true, -- Scare Beast
		-- Paladin
		[105421] = true, -- Blinding Light
		[ 10326] = true, -- Turn Evil
		[145067] = true, -- Turn Evil (Evil is a Point of View)
		-- Priest
		[  8122] = true, -- Psychic Scream
		[113792] = true, -- Psychic Terror (Psyfiend)
		-- Rogue
		[  2094] = true, -- Blind
		-- Warlock
		[  5782] = true, -- Fear
		[118699] = 5782, -- Fear -- new SpellID in MoP, Blood Fear uses same ID
		[  5484] = true, -- Howl of Terror
		[115268] = true, -- Mesmerize (Shivarra)
		[  6358] = true, -- Seduction (Succubus)
	--	[104045] = true, -- Sleep (Metamorphosis) -- FIXME: verify this is the correct category
		-- Warrior
		[  5246] = true, -- Intimidating Shout (main target)
		[ 20511] = true, -- Intimidating Shout (secondary targets)
	},

	--[[ STUNS ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#3
	ctrlstun = {
		-- Death Knight
		[108194] = true, -- Asphyxiate
		[ 91800] = true, -- Gnaw (Ghoul)
		[ 91797] = true, -- Monstrous Blow (Dark Transformation Ghoul)
		[115001] = true, -- Remorseless Winter
		-- Druid
		[102795] = true, -- Bear Hug
		[ 22570] = true, -- Maim
		[  5211] = true, -- Mighty Bash
		[  9005] = true, -- Pounce
		[102546] = true, -- Pounce (Incarnation)
		[113801] = true, -- Bash (treants in feral spec) (Bugged by blizzard - it instantly applies all 3 levels of DR right now, making any target instantly immune to ctrlstuns)
		-- Hunter
		[117526] = 109248, -- Binding Shot
		[ 24394] = 19577, -- Intimidation
		[ 90337] = true, -- Bad Manner (Monkey pet)
		[126246] = true, -- Lullaby (Crane pet)
		[126423] = true, -- Petrifying Gaze (Basilisk pet)
		[126355] = true, -- Quill (Porcupine pet)
		[ 56626] = true, -- Sting (Wasp pet)
		[ 50519] = true, -- Sonic Blast (Bat pet)
		[ 96201] = true, -- Web Wrap (Shale Spider pet)
		-- Mage
		[118271] = true, -- Combustion
		[ 44572] = true, -- Deep Freeze
		-- Monk
		[119392] =   true, -- Charging Ox Wave
		[122242] = 122057, -- Clash
		[120086] = 113656, -- Fists of Fury
		[119381] =   true, -- Leg Sweep
		-- Paladin
		[115752] = true, -- Blinding Light (Glyphed)
		[   853] = true, -- Hammer of Justice
		[110698] = true, -- Hammer of Justice (Symbiosis)
		[119072] = true, -- Holy Wrath
		[105593] = true, -- Fist of Justice
		-- Rogue
		[  1833] = true, -- Cheap Shot
		[   408] = true, -- Kidney Shot
		-- Shaman
		[118345] = true, -- Pulverize (Primal Earth Elemental)
		[118905] = true, -- Static Charge (Capacitor Totem)
		-- Warlock
		[ 89766] = true, -- Axe Toss (Felguard)
		[ 30283] = true, -- Shadowfury
		[ 22703] = 1122, -- Summon Infernal
		-- Warrior
		[132168] = true, -- Shockwave
		[132169] = true, -- Storm Bolt
		-- Tauren
		[ 20549] = true, -- War Stomp
	},

	--[[ ROOTS ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#2
	ctrlroot = {
		-- Death Knight
		[ 96294] = true, -- Chains of Ice (Chilblains Root)
		-- Druid
		[   339] = true, -- Entangling Roots
		[113275] = true, -- Entangling Roots (Symbiosis)
		[ 19975] = true, -- Nature's Grasp (Uses different spellIDs than Entangling Roots for the same spell)
		[102359] = true, -- Mass Entanglement (talent)
		-- Hunter
		[ 53148] = 61685, -- Charge (Tenacity pet)
		[ 50245] = true, -- Pin (Crab)
		[  4167] = true, -- Web (Spider)
		[ 54706] = true, -- Venom Web Spray (Silithid)
		[ 90327] = true, -- Lock Jaw (Dog)
		[136634] = true, -- Narrow Escape (passive talent)
		-- Mage
		[   122] = true, -- Frost Nova
		[110693] = true, -- Frost Nova (Symbiosis)
		[ 33395] = true, -- Freeze (Water Elemental)
		-- Monk
		[116706] = 116095, -- Disable
		-- Priest
		[ 87194] = true, -- Glyph of Mind Blast
		[114404] = true, -- Void Tendrils
		-- Rogue
		[115197] = true, -- Partial Paralysis (Shiv effect with Paralytic Poison)
		-- Shaman
		[ 63685] = true, -- Freeze (Frozen Power talent)
		-- Warrior
		[107566] = true, -- Staggering Shout (talent)
	},

	--[[ SHORT ROOTS ]]--
	-- Note: this category does not share diminishing returns with the above Roots category.
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#2
	shortroot = {
		-- Hunter
		[135373] = true, -- Entrapment (passive)
		-- Mage
		[111340] = true, -- Ice Ward
		-- Monk
		[123407] = 115073, -- Spinning Fire Blossom
		-- Shaman
		[ 64695] = true, -- Earthgrab Totem
	},

	--[[ HORROR ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#5
	horror = {
		-- Priest
		[ 64044] = true, -- Psychic Horror (Horror effect)
		-- Warlock
		[111397] = true, -- Blood Horror
		[  6789] = true, -- Mortal Coil
	},

	--[[ MISC ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#9

	cyclone = {
		-- Druid
		[ 33786] = true, -- Cyclone
		[113506] = true, -- Cyclone (Symbiosis)
	},

	mc = {
		-- Priest
		[   605] = true, -- Dominate Mind
	},

	--[[ KNOCKBACK ]]--
	-- cf. http://us.battle.net/wow/en/forum/topic/10195910192#8
	knockback = {
		-- Death Knight
		[108199] = true, -- Gorefiend's Grasp
		-- Druid
		[102793] = true, -- Ursol's Vortex
		[132469] = true, -- Typhoon
		-- Hunter
		[119403] = true, -- Glyph of Explosive Trap
		-- Shaman
		[ 51490] = true, -- Thunderstorm
		-- Warlock
		[  6360] = true, -- Whiplash
		[115770] = true, -- Fellash
	},
}

local categoryNames = {
	ctrlroot       = L["Roots"],
	shortroot      = L["Roots (short)"],
	ctrlstun       = L["Stuns"],
	cyclone        = L["Cyclone"],
	disarm         = L["Disarms"],
	disorient      = L["Mesmerizes"],
	shortdisorient = L["Mesmerizes (short)"],
	fear           = L["Fears"],
	horror         = L["Horrors"],
	mc             = L["Mind Control"],
	rndstun        = L["Stuns (short)"],
	silence        = L["Silences"],
	taunt          = L["Taunts"],
	incapacitate   = L["Incapacitates"],
	knockback      = L["Knockbacks"]
}

local pveDR = {
	ctrlstun = true,
	rndstun  = true,
	taunt    = true,
	cyclone  = true
}

--- List of spellID -> DR category
Data.spells = {}

--- List of spellID => ProviderID
Data.providers = {}

--- DR Category names
Data.categoryNames = {}

--- Categories that have DR in PvE as well as PvP
Data.pveDR = {}

-- Dispatch the spells in the final tables
for category, spells in pairs(spellsAndProvidersByCategory) do

	-- Publish these categories as we have spells in it
	Data.pveDR[category] = pveDR[category] or false
	Data.categoryNames[category] = categoryNames[category] or category

	for spell, provider in pairs(spells) do
		Data.spells[spell] = category
		if provider == true then -- "== true" is really needed
			Data.providers[spell] = spell
			spells[spell] = spell
		else
			Data.providers[spell] = provider
		end
	end
end

-- Public APIs
-- Category name in something usable
function Data:GetCategoryName(cat)
	return cat and Data.categoryNames[cat] or nil
end

-- Spell list
function Data:GetSpells()
	return Data.spells
end

-- Provider list
function Data:GetProviders()
	return Data.providers
end

-- Seconds before DR resets
function Data:GetResetTime(category)
	return Data.resetTimes[category or "default"] or Data.resetTimes.default
end

-- Get the category of the spellID
function Data:GetSpellCategory(spellID)
	return spellID and Data.spells[spellID] or nil
end

-- Does this category DR in PvE?
function Data:IsPVE(cat)
	return cat and Data.pveDR[cat] or nil
end

-- List of categories
function Data:GetCategories()
	return Data.categoryNames
end

-- Next DR
function Data:NextDR(diminished, category)
	local durations = Data.diminishedDurations[category or "default"] or Data.diminishedDurations.default
	for i = 1, #durations do
		if diminished > durations[i] then
			return durations[i]
		end
	end
	return 0
end

-- Iterate through the spells of a given category.
-- Pass "nil" to iterate through all spells.
do
	local function categoryIterator(id, category)
		local newCat
		repeat
			id, newCat = next(Data.spells, id)
			if id and newCat == category then
				return id, category
			end
		until not id
	end

	function Data:IterateSpells(category)
		if category then
			return categoryIterator, category
		else
			return next, Data.spells
		end
	end
end

-- Iterate through the spells and providers of a given category.
-- Pass "nil" to iterate through all spells.
function Data:IterateProviders(category)
	if category then
		return next, spellsAndProvidersByCategory[category]
	else
		return next, Data.providers
	end
end

--[[ EXAMPLES ]]--
-- This is how you would track DR easily, you're welcome to do whatever you want with the below functions

--[[
local trackedPlayers = {}
local function debuffGained(spellID, destName, destGUID, isEnemy, isPlayer)
	-- Not a player, and this category isn't diminished in PVE, as well as make sure we want to track NPCs
	local drCat = DRData:GetSpellCategory(spellID)
	if( not isPlayer and not DRData:IsPVE(drCat) ) then
		return
	end

	if( not trackedPlayers[destGUID] ) then
		trackedPlayers[destGUID] = {}
	end

	-- See if we should reset it back to undiminished
	local tracked = trackedPlayers[destGUID][drCat]
	if( tracked and tracked.reset <= GetTime() ) then
		tracked.diminished = 1.0
	end
end

local function debuffFaded(spellID, destName, destGUID, isEnemy, isPlayer)
	local drCat = DRData:GetSpellCategory(spellID)
	if( not isPlayer and not DRData:IsPVE(drCat) ) then
		return
	end

	if( not trackedPlayers[destGUID] ) then
		trackedPlayers[destGUID] = {}
	end

	if( not trackedPlayers[destGUID][drCat] ) then
		trackedPlayers[destGUID][drCat] = { reset = 0, diminished = 1.0 }
	end

	local time = GetTime()
	local tracked = trackedPlayers[destGUID][drCat]

	tracked.reset = time + DRData:GetResetTime(drCat)
	tracked.diminished = DRData:NextDR(tracked.diminished, drCat)

	-- Diminishing returns changed, now you can do an update
end

local function resetDR(destGUID)
	-- Reset the tracked DRs for this person
	if( trackedPlayers[destGUID] ) then
		for cat in pairs(trackedPlayers[destGUID]) do
			trackedPlayers[destGUID][cat].reset = 0
			trackedPlayers[destGUID][cat].diminished = 1.0
		end
	end
end

local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_CONTROL_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER

local eventRegistered = {["SPELL_AURA_APPLIED"] = true, ["SPELL_AURA_REFRESH"] = true, ["SPELL_AURA_REMOVED"] = true, ["PARTY_KILL"] = true, ["UNIT_DIED"] = true}
local function COMBAT_LOG_EVENT_UNFILTERED(self, event, timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType)
	if( not eventRegistered[eventType] ) then
		return
	end

	-- Enemy gained a debuff
	if( eventType == "SPELL_AURA_APPLIED" ) then
		if( auraType == "DEBUFF" and DRData:GetSpellCategory(spellID) ) then
			local isPlayer = ( bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			debuffGained(spellID, destName, destGUID, (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE), isPlayer)
		end

	-- Enemy had a debuff refreshed before it faded, so fade + gain it quickly
	elseif( eventType == "SPELL_AURA_REFRESH" ) then
		if( auraType == "DEBUFF" and DRData:GetSpellCategory(spellID) ) then
			local isPlayer = ( bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			local isHostile = (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)
			debuffFaded(spellID, destName, destGUID, isHostile, isPlayer)
			debuffGained(spellID, destName, destGUID, isHostile, isPlayer)
		end

	-- Buff or debuff faded from an enemy
	elseif( eventType == "SPELL_AURA_REMOVED" ) then
		if( auraType == "DEBUFF" and DRData:GetSpellCategory(spellID) ) then
			local isPlayer = ( bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			debuffFaded(spellID, destName, destGUID, (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE), isPlayer)
		end

	-- Don't use UNIT_DIED inside arenas due to accuracy issues, outside of arenas we don't care too much
	elseif( ( eventType == "UNIT_DIED" and select(2, IsInInstance()) ~= "arena" ) or eventType == "PARTY_KILL" ) then
		resetDR(destGUID)
	end
end]]
