-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local DS = LibStub("LibBabble-DigSites-3.0"):GetLookupTable()

local sessionErrors = {}

-----------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------
local DigsiteRaces = {
	Dwarf = 1,
	Draenei = 2,
	Fossil = 3,
	Nightelf = 4,
	Nerubian = 5,
	Orc = 6,
	Tolvir = 7,
	Troll = 8,
	Vrykul = 9,
	Mantid = 10,
	Pandaren = 11,
	Mogu = 12,
	Arakkoa = 13,
	DraenorClans = 14,
	Ogre = 15,
	Unknown = 0,
}

private.DigsiteRaces = DigsiteRaces

local DIG_SITES = {
	-----------------------------------------------------------------------
	-- Kalimdor
	-----------------------------------------------------------------------
	[DS["Abyssal Sands Fossil Ridge"]] = {
		continent = 1,
		map = 161,
		blob_id = 56375,
		race = DigsiteRaces.Fossil
	},
	[DS["Akhenet Fields Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56608,
		race = DigsiteRaces.Tolvir
	},
	[DS["Bael Modan Digsite"]] = {
		continent = 1,
		map = 607,
		blob_id = 55410,
		race = DigsiteRaces.Dwarf
	},
	[DS["Broken Commons Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56329,
		race = DigsiteRaces.Nightelf
	},
	[DS["Broken Pillar Digsite"]] = {
		continent = 1,
		map = 161,
		blob_id = 56367,
		race = DigsiteRaces.Troll
	},
	[DS["Constellas Digsite"]] = {
		continent = 1,
		map = 182,
		blob_id = 56343,
		race = DigsiteRaces.Nightelf
	},
	[DS["Cursed Landing Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56609,
		race = DigsiteRaces.Tolvir
	},
	[DS["Darkmist Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56337,
		race = DigsiteRaces.Nightelf
	},
	[DS["Dire Maul Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56327,
		race = DigsiteRaces.Nightelf
	},
	[DS["Dunemaul Fossil Ridge"]] = {
		continent = 1,
		map = 161,
		blob_id = 56373,
		race = DigsiteRaces.Fossil
	},
	[DS["Eastmoon Ruins Digsite"]] = {
		continent = 1,
		map = 161,
		blob_id = 56369,
		race = DigsiteRaces.Troll
	},
	[DS["Ethel Rethor Digsite"]] = {
		continent = 1,
		map = 101,
		blob_id = 55420,
		race = DigsiteRaces.Nightelf
	},
	[DS["Fields of Blood Fossil Bank"]] = {
		continent = 1,
		map = 607,
		blob_id = 56358,
		race = DigsiteRaces.Fossil
	},
	[DS["Forest Song Digsite"]] = {
		continent = 1,
		map = 43,
		blob_id = 55402,
		race = DigsiteRaces.Nightelf
	},
	[DS["Frostwhisper Gorge Digsite"]] = {
		continent = 1,
		map = 281,
		blob_id = 56356,
		race = DigsiteRaces.Nightelf
	},
	[DS["Grove of Aessina Digsite"]] = {
		continent = 1,
		map = 606,
		blob_id = 56570,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ironwood Digsite"]] = {
		continent = 1,
		map = 182,
		blob_id = 56349,
		race = DigsiteRaces.Nightelf
	},
	[DS["Jaedenar Digsite"]] = {
		continent = 1,
		map = 182,
		blob_id = 56347,
		race = DigsiteRaces.Nightelf
	},
	[DS["Keset Pass Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56611,
		race = DigsiteRaces.Tolvir
	},
	[DS["Khartut's Tomb Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56591,
		race = DigsiteRaces.Tolvir
	},
	[DS["Kodo Graveyard"]] = {
		continent = 1,
		map = 101,
		blob_id = 55426,
		race = DigsiteRaces.Fossil
	},
	[DS["Lake Kel'Theril Digsite"]] = {
		continent = 1,
		map = 281,
		blob_id = 56351,
		race = DigsiteRaces.Nightelf
	},
	[DS["Lower Lakkari Tar Pits"]] = {
		continent = 1,
		map = 201,
		blob_id = 56380,
		race = DigsiteRaces.Fossil
	},
	[DS["Mannoroc Coven Digsite"]] = {
		continent = 1,
		map = 101,
		blob_id = 55424,
		race = DigsiteRaces.Nightelf
	},
	[DS["Marshlands Fossil Bank"]] = {
		continent = 1,
		map = 201,
		blob_id = 56388,
		race = DigsiteRaces.Fossil
	},
	[DS["Morlos'Aran Digsite"]] = {
		continent = 1,
		map = 182,
		blob_id = 56345,
		race = DigsiteRaces.Nightelf
	},
	[DS["Nazj'vel Digsite"]] = {
		continent = 1,
		map = 42,
		blob_id = 55354,
		race = DigsiteRaces.Nightelf
	},
	[DS["Neferset Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56597,
		race = DigsiteRaces.Tolvir
	},
	[DS["Nightmare Scar Digsite"]] = {
		continent = 1,
		map = 607,
		blob_id = 56362,
		race = DigsiteRaces.Nightelf
	},
	[DS["North Isildien Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56341,
		race = DigsiteRaces.Nightelf
	},
	[DS["Obelisk of the Stars Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 60358,
		race = DigsiteRaces.Tolvir
	},
	[DS["Oneiros Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56333,
		race = DigsiteRaces.Nightelf
	},
	[DS["Orsis Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56599,
		race = DigsiteRaces.Tolvir
	},
	[DS["Owl Wing Thicket Digsite"]] = {
		continent = 1,
		map = 281,
		blob_id = 56354,
		race = DigsiteRaces.Nightelf
	},
	[DS["Quagmire Fossil Field"]] = {
		continent = 1,
		map = 141,
		blob_id = 55757,
		race = DigsiteRaces.Fossil
	},
	[DS["Ravenwind Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56331,
		race = DigsiteRaces.Nightelf
	},
	[DS["River Delta Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 60350,
		race = DigsiteRaces.Tolvir
	},
	[DS["Ruins of Ahmtul Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56607,
		race = DigsiteRaces.Tolvir
	},
	[DS["Ruins of Ammon Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56601,
		race = DigsiteRaces.Tolvir
	},
	[DS["Ruins of Arkkoran"]] = {
		continent = 1,
		map = 181,
		blob_id = 55414,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ruins of Eldarath"]] = {
		continent = 1,
		map = 181,
		blob_id = 55412,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ruins of Eldre'Thar"]] = {
		continent = 1,
		map = 81,
		blob_id = 55406,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ruins of Khintaset Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56603,
		race = DigsiteRaces.Tolvir
	},
	[DS["Ruins of Lar'donir Digsite"]] = {
		continent = 1,
		map = 606,
		blob_id = 56566,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ruins of Ordil'Aran"]] = {
		continent = 1,
		map = 43,
		blob_id = 55398,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ruins of Stardust"]] = {
		continent = 1,
		map = 43,
		blob_id = 55400,
		race = DigsiteRaces.Nightelf
	},
	[DS["Sahket Wastes Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 60361,
		race = DigsiteRaces.Tolvir
	},
	[DS["Sanctuary of Malorne Digsite"]] = {
		continent = 1,
		map = 606,
		blob_id = 56572,
		race = DigsiteRaces.Nightelf
	},
	[DS["Sargeron Digsite"]] = {
		continent = 1,
		map = 101,
		blob_id = 55428,
		race = DigsiteRaces.Nightelf
	},
	[DS["Schnottz's Landing"]] = {
		continent = 1,
		map = 720,
		blob_id = 60363,
		race = DigsiteRaces.Tolvir
	},
	[DS["Scorched Plain Digsite"]] = {
		continent = 1,
		map = 606,
		blob_id = 56574,
		race = DigsiteRaces.Nightelf
	},
	[DS["Screaming Reaches Fossil Field"]] = {
		continent = 1,
		map = 201,
		blob_id = 56386,
		race = DigsiteRaces.Fossil
	},
	[DS["Shrine of Goldrinn Digsite"]] = {
		continent = 1,
		map = 606,
		blob_id = 56568,
		race = DigsiteRaces.Nightelf
	},
	[DS["Slitherblade Shore Digsite"]] = {
		continent = 1,
		map = 101,
		blob_id = 55418,
		race = DigsiteRaces.Nightelf
	},
	[DS["Solarsal Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56335,
		race = DigsiteRaces.Nightelf
	},
	[DS["South Isildien Digsite"]] = {
		continent = 1,
		map = 121,
		blob_id = 56339,
		race = DigsiteRaces.Nightelf
	},
	[DS["Southmoon Ruins Digsite"]] = {
		continent = 1,
		map = 161,
		blob_id = 56371,
		race = DigsiteRaces.Troll
	},
	[DS["Southwind Village Digsite"]] = {
		continent = 1,
		map = 261,
		blob_id = 56390,
		race = DigsiteRaces.Nightelf
	},
	[DS["Steps of Fate Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56595,
		race = DigsiteRaces.Tolvir
	},
	[DS["Stonetalon Peak"]] = {
		continent = 1,
		map = 81,
		blob_id = 55404,
		race = DigsiteRaces.Nightelf
	},
	[DS["Temple of Uldum Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56605,
		race = DigsiteRaces.Tolvir
	},
	[DS["Terror Run Fossil Field"]] = {
		continent = 1,
		map = 201,
		blob_id = 56384,
		race = DigsiteRaces.Fossil
	},
	[DS["Tombs of the Precursors Digsite"]] = {
		continent = 1,
		map = 720,
		blob_id = 56593,
		race = DigsiteRaces.Tolvir
	},
	[DS["Unearthed Grounds"]] = {
		continent = 1,
		map = 81,
		blob_id = 55408,
		race = DigsiteRaces.Fossil
	},
	[DS["Upper Lakkari Tar Pits"]] = {
		continent = 1,
		map = 201,
		blob_id = 56382,
		race = DigsiteRaces.Fossil
	},
	[DS["Valley of Bones"]] = {
		continent = 1,
		map = 101,
		blob_id = 55422,
		race = DigsiteRaces.Fossil
	},
	[DS["Wyrmbog Fossil Field"]] = {
		continent = 1,
		map = 141,
		blob_id = 55755,
		race = DigsiteRaces.Fossil
	},
	[DS["Zoram Strand Digsite"]] = {
		continent = 1,
		map = 43,
		blob_id = 55356,
		race = DigsiteRaces.Nightelf
	},
	[DS["Zul'Farrak Digsite"]] = {
		continent = 1,
		map = 161,
		blob_id = 56364,
		race = DigsiteRaces.Troll
	},

	-----------------------------------------------------------------------
	-- Eastern Kingdoms
	-----------------------------------------------------------------------
	[DS["Aerie Peak Digsite"]] = {
		continent = 2,
		map = 26,
		blob_id = 54136,
		race = DigsiteRaces.Dwarf
	},
	[DS["Agol'watha Digsite"]] = {
		continent = 2,
		map = 26,
		blob_id = 54141,
		race = DigsiteRaces.Troll
	},
	[DS["Altar of Zul Digsite"]] = {
		continent = 2,
		map = 26,
		blob_id = 54138,
		race = DigsiteRaces.Troll
	},
	[DS["Andorhal Fossil Bank"]] = {
		continent = 2,
		map = 22,
		blob_id = 55482,
		race = DigsiteRaces.Fossil
	},
	[DS["Bal'lal Ruins Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55458,
		race = DigsiteRaces.Troll
	},
	[DS["Balia'mah Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55460,
		race = DigsiteRaces.Troll
	},
	[DS["Dreadmaul Fossil Field"]] = {
		continent = 2,
		map = 19,
		blob_id = 55436,
		race = DigsiteRaces.Fossil
	},
	[DS["Dun Garok Digsite"]] = {
		continent = 2,
		map = 24,
		blob_id = 54134,
		race = DigsiteRaces.Dwarf
	},
	[DS["Dunwald Ruins Digsite"]] = {
		continent = 2,
		map = 700,
		blob_id = 56583,
		race = DigsiteRaces.Dwarf
	},
	[DS["Eastern Ruins of Thaurissan"]] = {
		continent = 2,
		map = 29,
		blob_id = 55444,
		race = DigsiteRaces.Dwarf
	},
	[DS["Eastern Zul'Kunda Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55454,
		race = DigsiteRaces.Troll
	},
	[DS["Eastern Zul'Mamwe Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55464,
		race = DigsiteRaces.Troll
	},
	[DS["Felstone Fossil Field"]] = {
		continent = 2,
		map = 22,
		blob_id = 55478,
		race = DigsiteRaces.Fossil
	},
	[DS["Greenwarden's Fossil Bank"]] = {
		continent = 2,
		map = 40,
		blob_id = 54127,
		race = DigsiteRaces.Fossil
	},
	[DS["Grim Batol Digsite"]] = {
		continent = 2,
		map = 700,
		blob_id = 56589,
		race = DigsiteRaces.Dwarf
	},
	[DS["Grimesilt Digsite"]] = {
		continent = 2,
		map = 28,
		blob_id = 55438,
		race = DigsiteRaces.Dwarf
	},
	[DS["Gurubashi Arena Digsite"]] = {
		continent = 2,
		map = 673,
		blob_id = 55474,
		race = DigsiteRaces.Troll
	},
	[DS["Hammertoe's Digsite"]] = {
		continent = 2,
		map = 17,
		blob_id = 54832,
		race = DigsiteRaces.Dwarf
	},
	[DS["Humboldt Conflagration Digsite"]] = {
		continent = 2,
		map = 700,
		blob_id = 56587,
		race = DigsiteRaces.Dwarf
	},
	[DS["Infectis Scar Fossil Field"]] = {
		continent = 2,
		map = 23,
		blob_id = 55452,
		race = DigsiteRaces.Fossil
	},
	[DS["Ironband's Excavation Site"]] = {
		continent = 2,
		map = 35,
		blob_id = 54097,
		race = DigsiteRaces.Dwarf
	},
	[DS["Ironbeard's Tomb"]] = {
		continent = 2,
		map = 40,
		blob_id = 54124,
		race = DigsiteRaces.Dwarf
	},
	[DS["Jintha'Alor Lower City Digsite"]] = {
		continent = 2,
		map = 26,
		blob_id = 54139,
		race = DigsiteRaces.Troll
	},
	[DS["Jintha'Alor Upper City Digsite"]] = {
		continent = 2,
		map = 26,
		blob_id = 54140,
		race = DigsiteRaces.Troll
	},
	[DS["Lakeridge Highway Fossil Bank"]] = {
		continent = 2,
		map = 36,
		blob_id = 55416,
		race = DigsiteRaces.Fossil
	},
	[DS["Misty Reed Fossil Bank"]] = {
		continent = 2,
		map = 38,
		blob_id = 54864,
		race = DigsiteRaces.Fossil
	},
	[DS["Nek'mani Wellspring Digsite"]] = {
		continent = 2,
		map = 673,
		blob_id = 55476,
		race = DigsiteRaces.Troll
	},
	[DS["Northridge Fossil Field"]] = {
		continent = 2,
		map = 22,
		blob_id = 55480,
		race = DigsiteRaces.Fossil
	},
	[DS["Plaguewood Digsite"]] = {
		continent = 2,
		map = 23,
		blob_id = 60444,
		race = DigsiteRaces.Nerubian
	},
	[DS["Pyrox Flats Digsite"]] = {
		continent = 2,
		map = 28,
		blob_id = 55440,
		race = DigsiteRaces.Dwarf
	},
	[DS["Quel'Lithien Lodge Digsite"]] = {
		continent = 2,
		map = 23,
		blob_id = 55450,
		race = DigsiteRaces.Nightelf
	},
	[DS["Red Reaches Fossil Bank"]] = {
		continent = 2,
		map = 19,
		blob_id = 55434,
		race = DigsiteRaces.Fossil
	},
	[DS["Ruins of Aboraz"]] = {
		continent = 2,
		map = 673,
		blob_id = 55470,
		race = DigsiteRaces.Troll
	},
	[DS["Ruins of Jubuwal"]] = {
		continent = 2,
		map = 673,
		blob_id = 55472,
		race = DigsiteRaces.Troll
	},
	[DS["Savage Coast Raptor Fields"]] = {
		continent = 2,
		map = 37,
		blob_id = 55468,
		race = DigsiteRaces.Fossil
	},
	[DS["Shadra'Alor Digsite"]] = {
		continent = 2,
		map = 26,
		blob_id = 54137,
		race = DigsiteRaces.Troll
	},
	[DS["Southshore Fossil Field"]] = {
		continent = 2,
		map = 24,
		blob_id = 54135,
		race = DigsiteRaces.Fossil
	},
	[DS["Sunken Temple Digsite"]] = {
		continent = 2,
		map = 38,
		blob_id = 54862,
		race = DigsiteRaces.Troll
	},
	[DS["Terror Wing Fossil Field"]] = {
		continent = 2,
		map = 29,
		blob_id = 55446,
		race = DigsiteRaces.Fossil
	},
	[DS["Terrorweb Tunnel Digsite"]] = {
		continent = 2,
		map = 23,
		blob_id = 55443,
		race = DigsiteRaces.Nerubian
	},
	[DS["Thandol Span"]] = {
		continent = 2,
		map = 40,
		blob_id = 54133,
		race = DigsiteRaces.Dwarf
	},
	[DS["Thoradin's Wall"]] = {
		continent = 2,
		map = 16,
		blob_id = 54129,
		race = DigsiteRaces.Dwarf
	},
	[DS["Thundermar Ruins Digsite"]] = {
		continent = 2,
		map = 700,
		blob_id = 56585,
		race = DigsiteRaces.Dwarf
	},
	[DS["Tomb of the Watchers Digsite"]] = {
		continent = 2,
		map = 17,
		blob_id = 54834,
		race = DigsiteRaces.Dwarf
	},
	[DS["Twilight Grove Digsite"]] = {
		continent = 2,
		map = 34,
		blob_id = 55350,
		race = DigsiteRaces.Nightelf
	},
	[DS["Uldaman Entrance Digsite"]] = {
		continent = 2,
		map = 17,
		blob_id = 54838,
		race = DigsiteRaces.Dwarf
	},
	[DS["Vul'Gol Fossil Bank"]] = {
		continent = 2,
		map = 34,
		blob_id = 55352,
		race = DigsiteRaces.Fossil
	},
	[DS["Western Ruins of Thaurissan"]] = {
		continent = 2,
		map = 29,
		blob_id = 55442,
		race = DigsiteRaces.Dwarf
	},
	[DS["Western Zul'Kunda Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55456,
		race = DigsiteRaces.Troll
	},
	[DS["Western Zul'Mamwe Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55466,
		race = DigsiteRaces.Troll
	},
	[DS["Whelgar's Excavation Site"]] = {
		continent = 2,
		map = 40,
		blob_id = 54126,
		race = DigsiteRaces.Dwarf
	},
	[DS["Witherbark Digsite"]] = {
		continent = 2,
		map = 16,
		blob_id = 54132,
		race = DigsiteRaces.Troll
	},
	[DS["Ziata'jai Digsite"]] = {
		continent = 2,
		map = 37,
		blob_id = 55462,
		race = DigsiteRaces.Troll
	},
	[DS["Zul'Mashar Digsite"]] = {
		continent = 2,
		map = 23,
		blob_id = 55448,
		race = DigsiteRaces.Troll
	},

	-----------------------------------------------------------------------
	-- Outland
	-----------------------------------------------------------------------
	[DS["Ancestral Grounds Digsite"]] = {
		continent = 3,
		map = 477,
		blob_id = 56412,
		race = DigsiteRaces.Orc
	},
	[DS["Arklon Ruins Digsite"]] = {
		continent = 3,
		map = 479,
		blob_id = 56408,
		race = DigsiteRaces.Draenei
	},
	[DS["Bleeding Hollow Ruins Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56428,
		race = DigsiteRaces.Orc
	},
	[DS["Boha'mu Ruins Digsite"]] = {
		continent = 3,
		map = 467,
		blob_id = 56402,
		race = DigsiteRaces.Draenei
	},
	[DS["Bone Wastes Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56432,
		race = DigsiteRaces.Draenei
	},
	[DS["Bonechewer Ruins Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56430,
		race = DigsiteRaces.Orc
	},
	[DS["Burning Blade Digsite"]] = {
		continent = 3,
		map = 477,
		blob_id = 56420,
		race = DigsiteRaces.Orc
	},
	[DS["Coilskar Point Digsite"]] = {
		continent = 3,
		map = 473,
		blob_id = 56441,
		race = DigsiteRaces.Draenei
	},
	[DS["Dragonmaw Fortress"]] = {
		continent = 3,
		map = 473,
		blob_id = 56455,
		race = DigsiteRaces.Orc
	},
	[DS["East Auchindoun Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56434,
		race = DigsiteRaces.Draenei
	},
	[DS["Eclipse Point Digsite"]] = {
		continent = 3,
		map = 473,
		blob_id = 56448,
		race = DigsiteRaces.Draenei
	},
	[DS["Gor'gaz Outpost Digsite"]] = {
		continent = 3,
		map = 465,
		blob_id = 56392,
		race = DigsiteRaces.Orc
	},
	[DS["Grangol'var Village Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56424,
		race = DigsiteRaces.Orc
	},
	[DS["Halaa Digsite"]] = {
		continent = 3,
		map = 477,
		blob_id = 56422,
		race = DigsiteRaces.Draenei
	},
	[DS["Hellfire Basin Digsite"]] = {
		continent = 3,
		map = 465,
		blob_id = 56396,
		race = DigsiteRaces.Orc
	},
	[DS["Hellfire Citadel Digsite"]] = {
		continent = 3,
		map = 465,
		blob_id = 56398,
		race = DigsiteRaces.Orc
	},
	[DS["Illidari Point Digsite"]] = {
		continent = 3,
		map = 473,
		blob_id = 56439,
		race = DigsiteRaces.Draenei
	},
	[DS["Laughing Skull Digsite"]] = {
		continent = 3,
		map = 477,
		blob_id = 56418,
		race = DigsiteRaces.Orc
	},
	[DS["Ruins of Baa'ri Digsite"]] = {
		continent = 3,
		map = 473,
		blob_id = 56446,
		race = DigsiteRaces.Draenei
	},
	[DS["Ruins of Enkaat Digsite"]] = {
		continent = 3,
		map = 479,
		blob_id = 56406,
		race = DigsiteRaces.Draenei
	},
	[DS["Ruins of Farahlon Digsite"]] = {
		continent = 3,
		map = 479,
		blob_id = 56410,
		race = DigsiteRaces.Draenei
	},
	[DS["Sha'naar Digsite"]] = {
		continent = 3,
		map = 465,
		blob_id = 56400,
		race = DigsiteRaces.Draenei
	},
	[DS["Sunspring Post Digsite"]] = {
		continent = 3,
		map = 477,
		blob_id = 56416,
		race = DigsiteRaces.Orc
	},
	[DS["Tuurem Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56426,
		race = DigsiteRaces.Draenei
	},
	[DS["Twin Spire Ruins Digsite"]] = {
		continent = 3,
		map = 467,
		blob_id = 56404,
		race = DigsiteRaces.Draenei
	},
	[DS["Warden's Cage Digsite"]] = {
		continent = 3,
		map = 473,
		blob_id = 56450,
		race = DigsiteRaces.Orc
	},
	[DS["West Auchindoun Digsite"]] = {
		continent = 3,
		map = 478,
		blob_id = 56437,
		race = DigsiteRaces.Draenei
	},
	[DS["Zeth'Gor Digsite"]] = {
		continent = 3,
		map = 465,
		blob_id = 56394,
		race = DigsiteRaces.Orc
	},

	-----------------------------------------------------------------------
	-- Northrend
	-----------------------------------------------------------------------
	[DS["Altar of Quetz'lun Digsite"]] = {
		continent = 4,
		map = 496,
		blob_id = 56539,
		race = DigsiteRaces.Troll
	},
	[DS["Altar of Sseratus Digsite"]] = {
		continent = 4,
		map = 496,
		blob_id = 56533,
		race = DigsiteRaces.Troll
	},
	[DS["Baleheim Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56512,
		race = DigsiteRaces.Vrykul
	},
	[DS["Brunnhildar Village Digsite"]] = {
		continent = 4,
		map = 495,
		blob_id = 56549,
		race = DigsiteRaces.Vrykul
	},
	[DS["Drakil'Jin Ruins Digsite"]] = {
		continent = 4,
		map = 490,
		blob_id = 56547,
		race = DigsiteRaces.Troll
	},
	[DS["En'kilah Digsite"]] = {
		continent = 4,
		map = 486,
		blob_id = 56522,
		race = DigsiteRaces.Nerubian
	},
	[DS["Gjalerbron Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56516,
		race = DigsiteRaces.Vrykul
	},
	[DS["Halgrind Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56506,
		race = DigsiteRaces.Vrykul
	},
	[DS["Jotunheim Digsite"]] = {
		continent = 4,
		map = 492,
		blob_id = 56562,
		race = DigsiteRaces.Vrykul
	},
	[DS["Kolramas Digsite"]] = {
		continent = 4,
		map = 496,
		blob_id = 56524,
		race = DigsiteRaces.Nerubian
	},
	[DS["Moonrest Gardens Digsite"]] = {
		continent = 4,
		map = 488,
		blob_id = 56520,
		race = DigsiteRaces.Nightelf
	},
	[DS["Nifflevar Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56514,
		race = DigsiteRaces.Vrykul
	},
	[DS["Njorndar Village Digsite"]] = {
		continent = 4,
		map = 492,
		blob_id = 56564,
		race = DigsiteRaces.Vrykul
	},
	[DS["Pit of Fiends Digsite"]] = {
		continent = 4,
		map = 492,
		blob_id = 60367,
		race = DigsiteRaces.Nerubian
	},
	[DS["Pit of Narjun Digsite"]] = {
		continent = 4,
		map = 488,
		blob_id = 56518,
		race = DigsiteRaces.Nerubian
	},
	[DS["Riplash Ruins Digsite"]] = {
		continent = 4,
		map = 486,
		blob_id = 56526,
		race = DigsiteRaces.Nightelf
	},
	[DS["Ruins of Shandaral Digsite"]] = {
		continent = 4,
		map = 510,
		blob_id = 56530,
		race = DigsiteRaces.Nightelf
	},
	[DS["Sands of Nasam"]] = {
		continent = 4,
		map = 486,
		blob_id = 60369,
		race = DigsiteRaces.Nerubian
	},
	[DS["Scourgeholme Digsite"]] = {
		continent = 4,
		map = 492,
		blob_id = 56555,
		race = DigsiteRaces.Nerubian
	},
	[DS["Shield Hill Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56510,
		race = DigsiteRaces.Vrykul
	},
	[DS["Sifreldar Village Digsite"]] = {
		continent = 4,
		map = 495,
		blob_id = 56551,
		race = DigsiteRaces.Vrykul
	},
	[DS["Skorn Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56504,
		race = DigsiteRaces.Vrykul
	},
	[DS["Talramas Digsite"]] = {
		continent = 4,
		map = 486,
		blob_id = 56541,
		race = DigsiteRaces.Nerubian
	},
	[DS["Valkyrion Digsite"]] = {
		continent = 4,
		map = 495,
		blob_id = 56553,
		race = DigsiteRaces.Vrykul
	},
	[DS["Violet Stand Digsite"]] = {
		continent = 4,
		map = 510,
		blob_id = 56528,
		race = DigsiteRaces.Nightelf
	},
	[DS["Voldrune Digsite"]] = {
		continent = 4,
		map = 490,
		blob_id = 56543,
		race = DigsiteRaces.Vrykul
	},
	[DS["Wyrmskull Digsite"]] = {
		continent = 4,
		map = 491,
		blob_id = 56508,
		race = DigsiteRaces.Vrykul
	},
	[DS["Ymirheim Digsite"]] = {
		continent = 4,
		map = 492,
		blob_id = 56560,
		race = DigsiteRaces.Vrykul
	},
	[DS["Zim'Rhuk Digsite"]] = {
		continent = 4,
		map = 496,
		blob_id = 56535,
		race = DigsiteRaces.Troll
	},
	[DS["Zol'Heb Digsite"]] = {
		continent = 4,
		map = 496,
		blob_id = 56537,
		race = DigsiteRaces.Troll
	},

	-----------------------------------------------------------------------
	-- Pandaria
	-----------------------------------------------------------------------
	[DS["Tiger's Wood Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66767,
		race = DigsiteRaces.Pandaren
	},
	[DS["Tian Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66784,
		race = DigsiteRaces.Pandaren
	},
	[DS["Shrine of the Dawn Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66789,
		race = DigsiteRaces.Pandaren
	},
	[DS["Ruins of Gan Shi Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66795,
		race = DigsiteRaces.Mogu
	},
	[DS["Emperor's Omen Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66817,
		race = DigsiteRaces.Pandaren
	},
	[DS["The Arboretum Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66854,
		race = DigsiteRaces.Pandaren
	},
	[DS["Thunderwood Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 66890,
		race = DigsiteRaces.Mogu
	},
	[DS["Singing Marshes Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66917,
		race = DigsiteRaces.Mogu
	},
	[DS["North Great Wall Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66919,
		race = DigsiteRaces.Mogu
	},
	[DS["South Great Wall Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66923,
		race = DigsiteRaces.Mogu
	},
	[DS["Torjari Pit Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66925,
		race = DigsiteRaces.Mogu
	},
	[DS["The Spring Road Digsite"]] = {
		continent = 6,
		map = 873,
		blob_id = 66929,
		race = DigsiteRaces.Mogu
	},
	[DS["Paoquan Hollow Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66933,
		race = DigsiteRaces.Pandaren
	},
	[DS["North Fruited Fields Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66935,
		race = DigsiteRaces.Pandaren
	},
	[DS["South Fruited Fields Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66939,
		race = DigsiteRaces.Pandaren
	},
	[DS["Pools of Purity Digsite"]] = {
		continent = 6,
		map = 807,
		blob_id = 66941,
		race = DigsiteRaces.Pandaren
	},
	[DS["Fallsong Village Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 66943,
		race = DigsiteRaces.Mogu
	},
	[DS["Ruins of Korja Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 66945,
		race = DigsiteRaces.Mogu
	},
	[DS["Krasarang Wilds Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 66949,
		race = DigsiteRaces.Mogu
	},
	[DS["Lost Dynasty Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 66951,
		race = DigsiteRaces.Mogu
	},
	[DS["North Temple of the Red Crane Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 66957,
		race = DigsiteRaces.Pandaren
	},
	[DS["Zhu Province Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 66961,
		race = DigsiteRaces.Pandaren
	},
	[DS["Valley of Kings Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66965,
		race = DigsiteRaces.Mogu
	},
	[DS["Gate to Golden Valley Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66967,
		race = DigsiteRaces.Mogu
	},
	[DS["Snow Covered Hills Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66969,
		race = DigsiteRaces.Mogu
	},
	[DS["East Snow Covered Hills Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66971,
		race = DigsiteRaces.Mogu
	},
	[DS["Remote Village Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66973,
		race = DigsiteRaces.Pandaren
	},
	[DS["Destroyed Village Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66979,
		race = DigsiteRaces.Pandaren
	},
	[DS["Old Village Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66983,
		race = DigsiteRaces.Pandaren
	},
	[DS["Grumblepaw Ranch Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66985,
		race = DigsiteRaces.Pandaren
	},
	[DS["Chow Farmstead Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66987,
		race = DigsiteRaces.Pandaren
	},
	[DS["West Old Village Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66989,
		race = DigsiteRaces.Pandaren
	},
	[DS["Small Gate Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 66991,
		race = DigsiteRaces.Pandaren
	},
	[DS["Kun-Lai Peak Digsite"]] = {
		continent = 6,
		map = 809,
		blob_id = 67005,
		race = DigsiteRaces.Pandaren
	},
	[DS["Forest Heart Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67021,
		race = DigsiteRaces.Pandaren
	},
	[DS["Gong of Hope Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67023,
		race = DigsiteRaces.Pandaren
	},
	[DS["Great Bridge Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67025,
		race = DigsiteRaces.Pandaren
	},
	[DS["Orchard Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67027,
		race = DigsiteRaces.Pandaren
	},
	[DS["Jade Temple Grounds Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67031,
		race = DigsiteRaces.Pandaren
	},
	[DS["South Orchard Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67033,
		race = DigsiteRaces.Pandaren
	},
	[DS["Den of Sorrow Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67035,
		race = DigsiteRaces.Pandaren
	},
	[DS["Shrine Meadow Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67037,
		race = DigsiteRaces.Pandaren
	},
	[DS["Veridian Grove Digsite"]] = {
		continent = 6,
		map = 806,
		blob_id = 67039,
		race = DigsiteRaces.Pandaren
	},
	[DS["Setting Sun Garrison Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92020,
		race = DigsiteRaces.Mogu
	},
	[DS["Mistfall Village Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92022,
		race = DigsiteRaces.Pandaren
	},
	[DS["Five Sisters Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92026,
		race = DigsiteRaces.Pandaren
	},
	[DS["North Ruins of Guo-Lai Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92030,
		race = DigsiteRaces.Mogu
	},
	[DS["South Ruins of Guo-Lai Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92032,
		race = DigsiteRaces.Mogu
	},
	[DS["Tu Shen Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92038,
		race = DigsiteRaces.Mogu
	},
	[DS["West Ruins of Guo-Lai Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92046,
		race = DigsiteRaces.Mogu
	},
	[DS["Winterbough Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92150,
		race = DigsiteRaces.Mogu
	},
	[DS["Emperor's Approach Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92156,
		race = DigsiteRaces.Mogu
	},
	[DS["West Summer Fields Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92160,
		race = DigsiteRaces.Mogu
	},
	[DS["North Summer Fields Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92162,
		race = DigsiteRaces.Mogu
	},
	[DS["East Summer Fields Digsite"]] = {
		continent = 6,
		map = 811,
		blob_id = 92166,
		race = DigsiteRaces.Mogu
	},
	[DS["Sra'thik Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 92172,
		race = DigsiteRaces.Pandaren
	},
	[DS["Niuzao Temple Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 92174,
		race = DigsiteRaces.Pandaren
	},
	[DS["Fire Camp Osul Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 92178,
		race = DigsiteRaces.Mogu
	},
	[DS["Hatred's Vice Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 92180,
		race = DigsiteRaces.Mogu
	},
	[DS["Shanze'Dao Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 92196,
		race = DigsiteRaces.Mogu
	},
	[DS["Terrace of Gurthan Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 92202,
		race = DigsiteRaces.Mogu
	},
	[DS["Writhingwood Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 92206,
		race = DigsiteRaces.Mogu
	},
	[DS["South Ruins of Dojan Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 92210,
		race = DigsiteRaces.Mogu
	},
	[DS["North Ruins of Dojan Digsite"]] = {
		continent = 6,
		map = 857,
		blob_id = 92212,
		race = DigsiteRaces.Mogu
	},
	[DS["Kor'vess Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177485,
		race = DigsiteRaces.Mantid
	},
	[DS["Sra'thik Swarmdock Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177487,
		race = DigsiteRaces.Mantid
	},
	[DS["West Sra'vess Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177489,
		race = DigsiteRaces.Mantid
	},
	[DS["The Feeding Pits Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177491,
		race = DigsiteRaces.Mantid
	},
	[DS["Kzzok Warcamp Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177493,
		race = DigsiteRaces.Mantid
	},
	[DS["East Sra'vess Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177495,
		race = DigsiteRaces.Mantid
	},
	[DS["The Underbough Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177497,
		race = DigsiteRaces.Mantid
	},
	[DS["Ikz'ka Ridge Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177501,
		race = DigsiteRaces.Mantid
	},
	[DS["Sik'vess Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177503,
		race = DigsiteRaces.Mantid
	},
	[DS["West Sik'vess Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177505,
		race = DigsiteRaces.Mantid
	},
	[DS["North Sik'vess Digsite"]] = {
		continent = 6,
		map = 810,
		blob_id = 177507,
		race = DigsiteRaces.Mantid
	},
	[DS["The Clutches of Shek'zeer Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177509,
		race = DigsiteRaces.Mantid
	},
	[DS["Kypari'ik Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177511,
		race = DigsiteRaces.Mantid
	},
	[DS["Zan'vess Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177513,
		race = DigsiteRaces.Mantid
	},
	[DS["Venomous Ledge Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177515,
		race = DigsiteRaces.Mantid
	},
	[DS["Amber Quarry Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177517,
		race = DigsiteRaces.Mantid
	},
	[DS["The Briny Muck Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177519,
		race = DigsiteRaces.Mantid
	},
	[DS["Kypari'zar Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177523,
		race = DigsiteRaces.Mantid
	},
	[DS["Lake of Stars Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177525,
		race = DigsiteRaces.Mantid
	},
	[DS["Kypari Vor Digsite"]] = {
		continent = 6,
		map = 858,
		blob_id = 177529,
		race = DigsiteRaces.Mantid
	},

	-----------------------------------------------------------------------
	-- Draenor
	-----------------------------------------------------------------------
	[DS["Frozen Lake Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264223,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Wor'gol Ridge Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264225,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Daggermaw Flows Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264227,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Lashwind Cleft Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264229,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["The Crackling Plains Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264231,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Grom'gar Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264233,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Frostwind Crag Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 264237,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Frostboar Drifts Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 307916,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Icewind Drifts Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 307918,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["East Coldsnap Bluffs Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 307920,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Coldsnap Bluffs Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 307922,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Shaz'gul Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307924,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Burial Fields Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307926,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Anguish Fortress Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307928,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Cursed Woods Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307930,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Umbrafen Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307934,
		race = DigsiteRaces.Ogre,
	},
	[DS["Shimmering Moor Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307936,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Gloomshade Digsite"]] = {
		continent = 7,
		map = 947,
		blob_id = 307940,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Sethekk Hollow South Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307942,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Sethekk Hollow North Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307944,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Veil Akraz Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307946,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Writhing Mire Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307948,
		race = DigsiteRaces.Ogre,
	},
	[DS["Bloodmane Pridelands Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307950,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Pinchwhistle Point Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307952,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Bloodmane Valley Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307954,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Veil Zekk Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307956,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Apexis Excavation Digsite"]] = {
		continent = 7,
		map = 948,
		blob_id = 307958,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Gordal Fortress Digsite"]] = {
		continent = 7,
		map = 946,
		blob_id = 307960,
		race = DigsiteRaces.Ogre,
	},
	[DS["Veil Shadar Digsite"]] = {
		continent = 7,
		map = 946,
		blob_id = 307962,
		race = DigsiteRaces.Arakkoa,
	},
	[DS["Duskfall Island Digsite"]] = {
		continent = 7,
		map = 946,
		blob_id = 307964,
		race = DigsiteRaces.Ogre,
	},
	[DS["Zangarra Digsite"]] = {
		continent = 7,
		map = 946,
		blob_id = 307966,
		race = DigsiteRaces.Ogre,
	},
	[DS["Ango'rosh Digsite"]] = {
		continent = 7,
		map = 946,
		blob_id = 307971,
		race = DigsiteRaces.Ogre,
	},
	[DS["Forgotten Ogre Ruin Digsite"]] = {
		continent = 7,
		map = 946,
		blob_id = 307973,
		race = DigsiteRaces.Ogre,
	},
	[DS["Ruins of Na'gwa Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307975,
		race = DigsiteRaces.Ogre,
	},
	[DS["Overgrown Highmaul Road Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307977,
		race = DigsiteRaces.Ogre,
	},
	[DS["Razed Warsong Outpost Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307979,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Stonecrag Excavation Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307981,
		race = DigsiteRaces.Ogre,
	},
	[DS["North Spirit Woods Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307983,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Kag'ah Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307985,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Ancestral Grounds Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307987,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Ring of Trials Sludge Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307989,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Howling Plateau Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307991,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Rumbling Plateau Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307993,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Drowning Plateau Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307995,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Burning Plateau Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 307997,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["Highmaul Watchtower Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 308001,
		race = DigsiteRaces.Ogre,
	},
	[DS["Mar'gok's Overwatch Digsite"]] = {
		continent = 7,
		map = 950,
		blob_id = 308003,
		race = DigsiteRaces.Ogre,
	},
	[DS["Deadgrin Ruins Digsite"]] = {
		continent = 7,
		map = 949,
		blob_id = 308005,
		race = DigsiteRaces.DraenorClans,
	},
	[DS["The Broken Spine Digsite"]] = {
		continent = 7,
		map = 949,
		blob_id = 308007,
		race = DigsiteRaces.Ogre,
	},
	[DS["Overlook Ruins Digsite"]] = {
		continent = 7,
		map = 949,
		blob_id = 308011,
		race = DigsiteRaces.Ogre,
	},
	[DS["Wildwood Wash Dam Digsite"]] = {
		continent = 7,
		map = 949,
		blob_id = 308013,
		race = DigsiteRaces.Ogre,
	},
	[DS["Ruins of the First Bastion Digsite"]] = {
		continent = 7,
		map = 949,
		blob_id = 308015,
		race = DigsiteRaces.Ogre,
	},
	[DS["Southwind Cliffs Digsite"]] = {
		continent = 7,
		map = 941,
		blob_id = 308018,
		race = DigsiteRaces.DraenorClans,
	},
}

-- Workaround for Blizzard bug with GetMapLandmarkInfo()
DIG_SITES[DS["Grimsilt Digsite"]] = DIG_SITES[DS["Grimesilt Digsite"]]

local EMPTY_DIGSITE = {
	continent = 0,
	map = 0,
	blob_id = 0,
	race = DigsiteRaces.Unknown
}

_G.setmetatable(DIG_SITES, {
	__index = function(t, k)
		if k and not sessionErrors[k] then
			_G.DEFAULT_CHAT_FRAME:AddMessage("Archy is missing data for dig site " .. k)
			sessionErrors[k] = true
		end
		return EMPTY_DIGSITE
	end
})

private.dig_sites = DIG_SITES
