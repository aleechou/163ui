BINDING_HEADER_GOGOHEADER = "GoGoMount"
BINDING_NAME_GOGOBINDING = "Mount/Dismount"
BINDING_NAME_GOGOBINDING2 = "Mount/Dismount (no flying)"
BINDING_NAME_GOGOBINDING3 = "Mount/Dismount Passenger Mounts"

GoGo_Variables = {}
GoGo_Variables.ZoneExclude = {}
GoGo_Variables.Player = {}
GoGo_Variables.MountList = {}
--GoGo_DebugLog = {}
GoGo_Variables.Localize = {}
GoGo_Variables.Localize.Zone = {}
GoGo_Variables.Localize.String = {}
GoGo_Variables.Localize.Skill = {}
GoGo_Variables.Localize.Talent = {}
GoGo_Variables.GroundSpeed = {}
GoGo_Variables.AirSpeed = {}
GoGo_Variables.WaterSpeed = {}
GoGo_Variables.WaterSurfaceSpeed = {}
GoGo_Variables.Debug = 0
GoGo_Variables.TestVersion = true

---------
function GoGo_GetMountDB()
---------
	GoGo_Variables.MountDB = {
		[25953] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Blue Qiraji Battle Tank
		[26055] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Yellow Qiraji Battle Tank
		[26054] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Red Qiraji Battle Tank
		[26056] = {[38] = true, [201] = true, [330]=true, [402]=true, [10002]=160},  -- Green Qiraji Battle Tank
		[26656] = {[38] = true, [330]=true, [400]=true, [402]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Qiraji Battle Tank
		[92155] = {[38] = true, [330]=true, [400]=true, [402]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ultramarine Qiraji Battle Tank

		[30174] = {[15] = true, [39] = true, [10001]=67, [10002]=100, [10004]=67},  -- Riding Turtle
		[64731] = {[15] = true, [39] = true, [402]=true, [404]=true, [10001]=108, [10002]=100, [10004]=108},  -- Sea Turtle
		
		[120395] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Dragon Turtle
		[120822] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Red Dragon Turtle
		[127286] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Dragon Turtle
		[127287] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Dragon Turtle
		[127288] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Dragon Turtle
		[127289] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Dragon Turtle
		[127290] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Dragon Turtle
		[127293] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Green Dragon Turtle
		[127295] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Black Dragon Turtle
		[127302] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Blue Dragon Turtle
		[127308] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Brown Dragon Turtle
		[127310] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Purple Dragon Turtle
		
	--	[42692] = {[15] = true, [39] = true, [999] = true, [10002]=100},  -- Rickety Magic Broom


	--	[42680] = {[38] = true, [999] = true},  -- Magic Broom

	---	[42681] = {[38] = true, [999] = true},  -- Magic Broom

	--	[42683] = {[38] = true, [999] = true},  -- Swift Magic Broom
	---	[42684] = {[38] = true, [999] = true},  -- Swift Magic Broom

	--	[42667] = {[12] = true, [36] = true, [9] = true, [999] = true},  -- Flying Broom
	---	[42673] = {[12] = true, [36] = true, [9] = true, [999] = true},  -- Flying Broom

		[33184] = {[38] = true, [9] = true, [4] = true, [999] = true},  -- Swift Magic Broom  --  itemid
	--	[42668] = {[11] = true, [36] = true, [9] = true, [999] = true},  -- Swift Flying Broom

	---	[42679] = {[11] = true, [36] = true, [9] = true, [999] = true},  -- Swift Flying Broom


	--	[33183] = {[38] = true, [4] = true},  -- Magic Broom  --  itemid
	--	[33189] = {[4] = true, [15] = true, [39] = true, [10002]=100},  -- Rickety Magic Broom  --  See item dable below
		[42667] = {[7] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [402]=true, [403]=true, [600]=true, [601]=true, [10002]=160, [10003]=250, [50000]=33176},  -- Flying Broom  --  itemid
		[42668] = {[9] = true, [11] = true, [36] = true, [50000]=33182},  -- Swift Flying Broom  --  [50000]=33184
		[47977] = {[7]=true, [9] = true, [10]=true, [38] = true, [300]=true, [301]=true, [330]=true, [402]=true, [403]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [50000]=37011},  -- Magic Broom -- itemid

	
		[32243] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tawny Wind Rider
		[32244] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blue Wind Rider
		[32245] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Green Wind Rider
		[32246] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Red Wind Rider
		[32295] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Green Wind Rider
		[32296] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Yellow Wind Rider
		[32297] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Purple Wind Rider
		[61230] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Blue Wind Rider
		[64762] = {[9] = true, [39] = true, [52] = true, ["FlightOnly"] = true, [10003]=250, [50000]=44229},  -- Loaned Wind Rider Reins
		[107517] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Spectral Wind Rider

		[135418] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Armored Wyvern
		[136164] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Wyvern

		[37015] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Swift Nether Drake
		[41513] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Onyx Netherwing Drake
		[41514] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Azure Netherwing Drake
		[41515] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Cobalt Netherwing Drake
		[41516] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Purple Netherwing Drake
		[41517] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Veridian Netherwing Drake
		[41518] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Violet Netherwing Drake
		[44317] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Merciless Nether Drake
		[44744] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Merciless Nether Drake
		[49193] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Vengeful Nether Drake
		[58615] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Brutal Nether Drake

		[39798] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Green Riding Nether Ray
		[39800] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Red Riding Nether Ray
		[39801] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Purple Riding Nether Ray
		[39802] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Silver Riding Nether Ray
		[39803] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Blue Riding Nether Ray

		[43927] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Cenarion War Hippogryph
		[63844] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Argent Hippogryph
		[66087] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Silver Covenant Hippogryph
		[74856] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Blazing Hippogryph
		[97359] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flameward Hippogryph
		[102514] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Corrupted Hippogryph

		[43810] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Frost Wyrm
		[51960] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Frostwyrm Mount
		[64927] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Deadly Gladiator's Frostwyrm
		[65439] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Furious Gladiator's Frost Wyrm
		[67336] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Relentless Gladiator's Frost Wyrm
		[71810] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Wrathful Gladiator's Frost Wyrm
		
		[72807] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Icebound Frostbrood Vanquisher
		[72808] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Bloodbathed Frostbrood Vanquisher

		[3363] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Nether Drake
		[28828] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Nether Drake
		[49345] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37815},  -- Emerald Drake
		[49461] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37859},  -- Amber Drake
		[49462] = {[9] = true, [54] = true, ["FlightOnly"] = true, [50000]=37860},  -- Ruby Drake
		[59567] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Azure Drake
		[59568] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Blue Drake
		[59569] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Bronze Drake
		[59570] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Red Drake
		[59571] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Twilight Drake
		[59650] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Black Drake
		[60025] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Albino Drake
		[69395] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Onyxian Drake
		[88331] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250}, -- Volcanic Stone Drake
		[88335] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Drake of the East Wind
		[88718] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Phosphorescent Stone Drake
		[88741] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Drake of the West Wind
		[88742] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Drake of the North Wind
		[88744] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Drake of the South Wind
		[88746] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Vitreous Stone Drake
		[93326] = {[2] = true, [9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Sandstone Drake
		[93463] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=25},  -- Mottled Drake
		[93623] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Mottled Drake
		[101282] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Vicious Gladiator's Twilight Drake
		[101821] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Ruthless Gladiator's Twilight Drake
		[107842] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Blazing Drake
		[107844] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Twilight Harbinger
		[107845] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Life-Binder's Handmaiden
		[113120] = {[9]=true, [38]=true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Feldrake

		[59961] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Red Proto-Drake
		[59976] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Black Proto-Drake
		[59996] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Blue Proto-Drake
		[60002] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Time-Lost Proto-Drake
		[60021] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Plagued Proto-Drake
		[60024] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Violet Proto-Drake
		[61294] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Green Proto-Drake
		[63956] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Ironbound Proto-Drake
		[63963] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Rusted Proto-Drake
		[148392] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Spawn of Galakras

		[32345] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Peep the Phoenix Mount
		[40192] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Ashes of Al'ar
		[88990] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Dark Phoenix
		[129552] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Crimson Pandaren Phoenix
		[132117] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Ashen Pandaren Phoenix
		[132118] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Emerald Pandaren Phoenix
		[132119] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Violet Pandaren Phoenix

		[97493] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Pureblood Fire Hawk / Crimson Fire Hawk
		[97501] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Green Fire Hawk / Beryl Fire Hawk
		[97560] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Corrupted Fire Hawk

		[54726] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Winged Steed of the Ebon Blade
		[54727] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Winged Steed of the Ebon Blade
		[54729] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Winged Steed of the Ebon Blade

		[32235] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Golden Gryphon
		[32239] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ebon Gryphon
		[32240] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Snowy Gryphon
		[32242] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Blue Gryphon
		[32289] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Red Gryphon
		[32290] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Green Gryphon
		[32292] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Purple Gryphon
		[55164] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Swift Spectral Gryphon
		[61229] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Snowy Gryphon
		[64749] = {[9] = true, [18] = true, [39] = true, [52] = true, ["FlightOnly"] = true, [10003]=250, [50000]=44221},  -- Loaned Gryphon Reins
		[107516] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Spectral Gryphon
		[135416] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Armored Gryphon
		[136163] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Grand Gryphon


		[578] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Wolf
		[579] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Wolf
		[580] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Timber Wolf
		[581] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Winter Wolf
		[6653] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dire Wolf
		[6654] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Wolf
		[16080] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Wolf
		[16081] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Winter Wolf
		[22724] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Wolf
		[23250] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Wolf
		[23251] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Timber Wolf
		[23252] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Gray Wolf
		[23509] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frostwolf Howler
		[63640] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Origimmar Wolf (Swift Orgrimmar Wolf)
		[64658] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Wolf
		[65646] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Burgundy Wolf
		[68056] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Horde Wolf
		[92232] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spectral Wolf
		[100333] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Wolf
		[148396] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kor'kron War Wolf

		[18363] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Riding Kodo
		[18989] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Kodo
		[18990] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Kodo
		[18991] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Kodo
		[18992] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Teal Kodo
		[22718] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Kodo
		[23247] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great White Kodo
		[23248] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Gray Kodo
		[23249] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Brown Kodo
		[49378] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Riding Kodo
		[49379] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Brewfest Kodo
		[50869] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Kodo
		[63641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Thunder Bluff Kodo (Great Mulgore Kodo)
		[64657] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Kodo
		[65641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Golden Kodo
		[69820] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sunwalker Kodo
		[69826] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Sunwalker Kodo

		[34795] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Hawkstrider
		[35018] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Hawkstrider
		[35020] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Hawkstrider
		[35022] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Hawkstrider
		[33660] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Pink Hawkstrider
		[35025] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Green Hawkstrider
		[35027] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  --Swift Purple Hawkstrider
		[35028] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Warstrider
		[46628] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Hawkstrider
		[41252] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Raven Lord
		[63642] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Silvermoon Hawkstrider (Swift Silvermoon Hawkstrider)
		[65639] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Red Hawkstrider
		[66091] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Sunreaver Hawkstrider
		[101542] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Flametalon of Alyzrazor

		[101573] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Shorestrider
		[102346] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Forest Strider
		[102349] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Springstrider
		[102350] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Lovebird
		
		[65917] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster
		[66122] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster
		[66123] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster
		[66124] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Magic Rooster

		[34790] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dark War Talbuk
		[34896] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cobalt War Talbuk
		[34897] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White War Talbuk
		[34898] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Silver War Talbuk
		[34899] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tan War Talbuk
		[39315] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cobalt Riding Talbuk
		[39316] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dark Riding Talbuk
		[39317] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Silver Riding Talbuk
		[39318] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tan Riding Talbuk
		[39319] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Talbuk

		[130086] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Riding Goat
		[130137] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Goat
		[130138] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Riding Goat

		[6777] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Ram
		[6898] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Ram
		[6899] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Ram
		[17460] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Frost Ram
		[17461] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Ram
		[22720] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Ram
		[23238] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Ram
		[23239] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Gray Ram
		[23240] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Ram
		[23510] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Stormpike Battle Charger
		[43899] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brewfest Ram
		[43900] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brewfest Ram
		[63636] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ironforge Ram (Swift Ironforge Ram)
		[65643] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Violet Ram

		[10873] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Mechanostrider
		[10969] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Mechanostrider
		[15779] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Mechanostrider Mod B
		[15780] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Mechanostrider
		[15781] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Steel Mechanostrider
		[17453] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Mechanostrider
		[17454] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Unpainted Mechanostrider
		[17455] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Mechanostrider
		[17456] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red and Blue Mechanostrider
		[17458] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fluorescent Green Mechanostrider
		[17459] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Icy Blue Mechanostrider Mod A
		[22719] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Battlestrider
		[23222] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Yellow Mechanostrider
		[23223] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Mechanostrider
		[23225] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Green Mechanostrider
		[33630] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Mechanostrider
		[63638] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gnomeregan Mechanostrider (Turbostrider)
		[65642] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Turbostrider

		[123160] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Riding Crane
		[127174] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Azure Riding Crane
		[127176] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Riding Crane
		[127177] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Regal Riding Crane
		[127178] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Jungle Riding Crane
		[127180] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Albino Riding Crane

		[8395] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Emerald Raptor
		[10795] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ivory Raptor
		[10796] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Turquoise Raptor
		[10799] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Violet Raptor
		[16084] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mottled Red Raptor
		[17450] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ivory Raptor
		[22721] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Raptor
		[23241] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Blue Raptor
		[23242] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Olive Raptor
		[23243] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Orange Raptor
		[24242] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Razzashi Raptor
		[63635] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Darkspear Raptor (Swift Darkspear Raptor)
		[64659] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Venomhide Ravasaur
		[65644] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Purple Raptor
		[84751] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fossilized Raptor
		[96491] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Razzashi Raptor
		[97581] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Savage Raptor
		[138640] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Bone-White Primal Raptor
		[138641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Primal Raptor
		[138642] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Primal Raptor
		[138643] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Primal Raptor

		[138423] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Cobalt Primordial Direhorn
		[138424] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amber Primordial Direhorn
		[138425] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Slate Primordial Direhorn
		[138426] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Jade Primordial Direhorn
		[140249] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Primal Direhorn
		[140250] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Primal Direhorn
		

		[43688] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amani War Bear
		[51412] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Big Battle Bear
		[54753] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Polar Bear Mount
		[58983] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Big Blizzard Bear  -------------------------------------------------------------
		[59572] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Polar Bear
		[59573] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Polar Bear
		[60114] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Brown Bear
		[60116] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Armored Brown Bear
		[60118] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Bear
		[60119] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Bear
		--[64987] = {[38] = true, [999] = true, [400]=true, [402]=true, [405]=true, [10001]=67, [10004]=67},  --Big Blizzard Bear [PH] - ticket 211
		[98204] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amani Battle Bear
		[103081] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Darkmoon Dancing Bear
		
		[8394] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Striped Frostsaber
		[10789] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spotted Frostsaber
		[10793] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Striped Nightsaber
		[16055] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Nightsaber
		[16056] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ancient Frostsaber
		[16058] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Primal Leopard
		[16059] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tawny Sabercat
		[16060] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden Sabercat
		[17229] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Winterspring Frostsaber
		[22723] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Tiger
		[23219] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Mistsaber
		[23220] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Dawnsaber
		[23221] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Frostsaber
		[23338] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Stormsaber
		[24252] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zulian Tiger
		[42776] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spectral Tiger
		[42777] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Spectral Tiger
		[63637] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Darnassian Nightsaber (Swift Darnassian Mistsaber)
		[65638] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Moonsaber
		[66847] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Striped Dawnsaber
		[96499] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zulian Panther
		[129932] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Shado-Pan Riding Tiger
		[129934] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Shado-Pan Riding Tiger
		[129935] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Shado-Pan Riding Tiger
		[145133] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Moonfang
		[146615] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Warsaber
		
		[120043] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Jeweled Onyx Panther
		[121836] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sapphire Panther
		[121837] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Jade Panther / Emerald Panther
		[121838] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ruby Panther
		[121839] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Sunstone Panther / Dawnstone Panther

		[458] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Horse
		[468] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Stallion
		[470] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Stallion
		[471] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Palamino
		[472] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Pinto
		[5784] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felsteed
		[6648] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Chestnut Mare
		[13819] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Warhorse
		[16082] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Palomino
		[16083] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Stallion
		[17462] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Skeletal Horse
		[17463] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Skeletal Horse
		[17464] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Skeletal Horse
		[17465] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Green Skeletal Warhorse
		[17481] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Rivendare's Deathcharger
		[22717] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Steed
		[22722] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Red Skeletal Warhorse
		[23161] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dreadsteed
		[23214] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Charger
		[23227] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Palomino
		[23228] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift White Steed
		[23229] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Steed
		[23246] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Skeletal Warhorse
		[34767] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Charger
		[34769] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Summon Warhorse
		[36702] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Fiery Warhorse
		[48025] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Headless Horseman's Mount
		[48778] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Acherus Deathcharger
		[58819] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Brown Steed
		[63232] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Stormwind Steed (Swift Stormwind Steed)
		[63643] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Forsaken Warhorse
		[64656] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blue Skeletal Warhorse
		[64977] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Skeletal Horse
		[65640] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Gray Steed
		[65645] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Skeletal Warhorse
		[66090] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Quel'dorei Steed
		[66846] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ochre Skeletal Warhorse
		[66906] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Charger
		[66907] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Warhorse
		[67466] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Argent Warhorse
		[68057] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Alliance Steed
		[68187] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crusader's White Warhorse
		[68188] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crusader's Black Warhorse
		[72286] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Invincible
		[73313] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Crimson Deathcharger
		[75614] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Celestial Steed
		[92231] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spectral Steed
		[100332] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious War Steed
		[103195] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mountain Horse
		[103196] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Mountain Horse
		[107203] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Tyrael's Charger
		[134573] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Windsteed
		[136505] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Ghastly Charger
		[142073] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Hearthsteed
		[146622] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Vicious Skeletal Warhorse
		[148970] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [10001]=67, [10002]=160, [10004]=67},  -- Felsteed
		[148972] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [406]=true, [10001]=67, [10002]=160, [10004]=67},  -- Dreadsteed

		[34406] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Elekk
		[34407] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Elite Elekk
		[35710] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Gray Elekk
		[35711] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Purple Elekk
		[35712] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Green Elekk
		[35713] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Blue Elekk
		[35714] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Purple Elekk
		[47037] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift War Elekk
		[48027] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Elekk
		[63639] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Exodar Elekk  (Great Azuremyst Elekk)
		[65637] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grea Red Elekk (Blizzard typo on PTR?)
		[73629] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Exarch's Elekk
		[73630] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Great Exarch's Elekk

		[122708] = {[2]=true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Expedition Yak
		[123182] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Yak
		[127209] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Riding Yak
		[127213] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Riding Yak
		[127216] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grey Riding Yak
		[127220] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Blonde Riding Yak
		
		[88748] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brown Riding Camel
		[88749] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Tan Riding Camel
		[88750] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grey Riding Camel
		[102488] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- White Riding Camel

		[50281] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black Warp Stalker

		[118089] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=200},  -- Azure Water Strider  (walks on water)
		[127271] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=200},  -- Crimson Water Strider  (walks on water)
		[127272] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=200},  -- Orange Water Strider  (walks on water)
		[127274] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=200},  -- Jade Water Strider  (walks on water)
		[127278] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=200},  -- Golden Water Strider  (walks on water)
	
		[59785] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Mammoth
		[59788] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Black War Mammoth
		[59791] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wooly Mammoth
		[59793] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wooly Mammoth
		[59797] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ice Mammoth
		[59799] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ice Mammoth
		[59802] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[59804] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[59810] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[59811] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[60136] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Caravan Mammoth
		[60140] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Caravan Mammoth
		[61425] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Traveler's Tundra Mammoth
		[61447] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Traveler's Tundra Mammoth
		[61465] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61466] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61467] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Black War Mammoth
		[61469] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		[61470] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Grand Ice Mammoth
		
		[48954] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zhevra
		[49322] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Swift Zhevra

		[46199] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-51 Nether-Rocket X-TREME
		[46197] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-51 Nether-Rocket
		[71342] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [403]=true, [10002]=160, [10003]=250},  -- Big Love Rocket
		[75973] = {[2] = true, [9] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- X-53 Touring Rocket
		[126507] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Depleted-Kyparium Rocket
		[126508] = {[9] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Geosynchronous World Spinner

		[44151] = {[9] = true, [39] = true, [46] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Turbo-Charged Flying Machine
		[44153] = {[9] = true, [36] = true, [45] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flying Machine
		[55531] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mechano-hog
		[60424] = {[2] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Mekgineer's Chopper
		[63796] = {[9] = true, [36] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Mimiron's Head
		[76203] = {[55] = true, [200] = true, [10004]=286, [50000]=55121},  -- River Boat
		[87090] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67}, -- Goblin Trike
		[87091] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67}, -- Goblin Turbo-Trike
		[134359] = {[2] = true, [9] = true, [36] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- The Sky Claw

		[61309] = {[9] = true, [49] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Magnificent Flying Carpet
		[61442] = {[9] = true, [47] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Mooncloth Carpet
		[61444] = {[9] = true, [47] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Shadoweave Carpet
		[61446] = {[9] = true, [47] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Swift Spellfire Carpet
		[61451] = {[9] = true, [48] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Flying Carpet
		[75596] = {[9] = true, [49] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Frosty Flying Carpet
		--	[????] = {[11] = true, [47] = true, [9] = true, [36] = true, [400]=true, [402]=true, [405]=true, [10001]=67, [10004]=67},  -- Swift Flying Carpet   --- item 39303

		[61996] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Blue Dragonhawk
		[61997] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Red Dragonhawk
		[62048] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Black Dragonhawk Mount
		[66088] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Sunreaver Dragonhawk
		[96503] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Amani Dragonhawk
		[142266] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Armored Red Dragonhawk
		[142478] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Armored Blue Dragonhawk
		
		[113199] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Jade Cloud Serpent
		[123992] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Azure Cloud Serpent
		[123993] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Golden Cloud Serpent
		[124408] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Thundering Jade Cloud Serpent
		[127154] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Onyx Cloud Serpent
		[127156] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Crimson Cloud Serpent
		[127158] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Heavenly Onyx Cloud Serpent
		[127161] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Heavenly Crimson Cloud Serpent
		[127164] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Heavenly Golden Cloud Serpent
		[127165] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Heavenly Jade Cloud Serpent
		[127169] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Heavenly Azure Cloud Serpent
		[127170] = {[9] = true, [36] = true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Astral Cloud Serpent
		[129918] = {[9] = true, [36]=true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Thundering August Cloud Serpent
		[132036] = {[9] = true, [36]=true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Thundering Ruby Cloud Serpent
		[139407] = {[9] = true, [36]=true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Malevolent Gladiator's Cloud Serpent
		[139442] = {[9] = true, [36]=true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Thundering Cobolt Cloud Serpent
		[148476] = {[9] = true, [36]=true, ["FlightOnly"] = true, [100]=true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Thundering Onyx Cloud Serpent
		[148618] = {[9] = true, [36]=true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Tyrannical Gladiator's Cloud Serpent
		[148619] = {[9] = true, [36]=true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Grievous Gladiator's Cloud Serpent
		[148620] = {[9] = true, [36]=true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Prideful Gladiator's Cloud Serpent

		[139448] = {[9] = true, [36]=true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Clutch of Ji-Kun

		[75207] = {[36] = true, [53] = true, [401] = true, [10001]=371, [10004]=371},  -- Abyssal Seahorse (was Abyssal Manta)
		[98718] = {[36] = true, [53] = true, [404] = true, [10001]=108, [10004]=108},  -- Subdued Seahorse

		[142641] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Brawler's Burly Mushan Beast
		[148428] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Ashhide Mushan Beast

		[121820] = {[2] = true, [9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Obsidian Nightwing

		[118737] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Pandaren Kite
		[130985] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Pandaren Kite
		[133023] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Jade Pandaren Kite

		[93644] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kor'kron Annihilator
		[123886] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Amber Scorpion
		[148417] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Kor'kron Juggernaut

		[24347] = {[7]=true, [8]=true, [10001]=91, [10004]=91, [50000]=19979},  -- Master Angler
		
		[74918] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Wooly White Rhino
		[136471] = {[37] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Spawn of Horridon
		
		[90621] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Golden King

		[136400] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Skyscreamer

		[98727] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Winged Guardian
		[101641] = {[9] = true, [19] = true, [39] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67, [50000]=71086},  -- Tarecgosa's Visage
	--	[62087] = {[5] = true, [15] = true, [39] = true, [53] = true, [999] = true},  -- Aquatic Riding Ray   -- removed from the 3.1 PTR datafiles
		[110039] = {[9] = true, [36] = true, ["FlightOnly"] = true, [300]=true, [301]=true, [403]=true, [10003]=250},  -- Experiment 12-B
		[110051] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Heart of the Aspects
		[124659] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Imperial Quilen
		[130092] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Red Flying Cloud
		[130965] = {[38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Son of Galleon
		[139595] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Armored Bloodwing
		[142878] = {[9] = true, [38] = true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Enchanted Fey Dragon

		[147595] = {[9]=true, [38]=true, [300]=true, [301]=true, [330]=true, [400]=true, [402]=true, [403]=true, [405]=true, [10001]=67, [10002]=160, [10003]=250, [10004]=67},  -- Stormcrow

	-- Spells, shape forms, etc
		[40120] = {[7] = true, [9] = true, [300] = true, [403] = true, [9998] = true, ["FlightOnly"] = true, [10003]=380},  -- Druid Fast Flight Form
		[33943] = {[7] = true, [9] = true, [300] = true, [301] = true, [403] = true, [9998] = true, ["FlightOnly"] = true, [10003]=250},  -- Druid Flight Form
		[783] = {[7] = true, [500] = true, [10002]=140}, -- Druid Travel Form
		[2645] = {[7] = true, [8] = true, [500] = true, [1000] = true, ["DefaultInstance"] = true, [10002]=130}, -- Shaman Ghost Wolf Form
		[768] = {[7] = true, [8] = true, [1000] = true, [500] = true, ["DefaultInstance"] = true, [10002]=125},  -- Druid Cat Form
		[1066] = {[7] = true, [53] = true, [500]=true, [1000]=true, [10001]=101, [10004]=101, ["DefaultInstance"] = true},  -- Druid Aqua form
		[5118] = {[7] = true, [8] = true, [500] = true, ["DefaultInstance"] = true, [10002]=130},  -- Aspect of the Cheeta
		[13159] = {[7] = true, [8] = true, [500] = true, ["DefaultInstance"] = true, [10002]=130},  -- Aspect of the Pack
		[87840] = {[14] = true, [38] = true, [330]=true, [400]=true, [402]=true, [405]=true, [10001]=67, [10002]=160, [10004]=67},  -- Running Wild (Worgen Racial)
		[125883] = {[7]=true, [9]=true, [403]=true, ["FlightOnly"]=true, [10003]=160},	-- Zen Flight (Monk glyph)
	}
end --if

GoGo_Variables.MountItemIDs = {
	[19979] = {[50000]=24347, [51001]=true},  -- Hook of the Master Angler
	[33176] = {[50000]=42667, [51000] = true},  -- Flying Broom 
	[33182] = {[50000]=42668, [51000] = true},  -- Swift Flying Broom
	-- [33183] = {[51000] = true},  -- Old Magic Broom  -- no longer in game
	[33184] = {[50000]=42668, [51000] = true},  -- Swift Flying Broom
--	[33189] = {[51000] = true},  -- Rickety Magic Broom  -- no speed increase but doesn't seem to cast a spell either..
	[37011] = {[50000]=47977, [51000] = true},	-- Magic Broom
	[37815] = {[50000]=49345, [51000] = true},  -- Emerald Essence
	[37859] = {[50000]=49461, [51000] = true},  -- Amber Essence
	[37860] = {[50000]=49462, [51000] = true},  -- Ruby Essence
	[44221] = {[50000]=64749, [51000] = true},  -- Loaned Gryphon Reins
	[44229] = {[50000]=64762, [51000] = true},  -- Loaned Wind Rider Reins
	[55121] = {[50000]=76203, [51000] = true},  -- River Boat
	[71086] = {[50000]=101641, [51001] = true},  -- Dragonwrath, Tarecgosa's Rest
}


--[[
GoGo_FlyCoOrds = {   -- x = west / east,  y = north / south
	["Dalaran"] = {
		["Underbelly"] = {
			[1] = {0.09200777113437, 0.53064680099487, 0.30007892847061, 0.88580405712128},  -- south west pipe
--			[2] = {0.00000000000000, 0.00000000000000, 0.00000000000000, 0.00000000000000},  -- 3.0.8 PTR the pipe did not have any location co-ordinates as well as other parts of underbelly
		},
		["Dalaran"] = {
			[1] = {0.32762300968170, 0.92964243888855, 0.44406870007515, 0.99999999999999},  -- south floating rock - south part of rock is off dalaran map and zero's out
			[2] = {0.00000000000000, 0.00000000000000, 0.00000000000000, 0.00000000000000},  -- south end of south floating rock that's considered off the dalaran map, north end of north floating rock
			[3] = {0.84375905990601, 0.53441548347473, 0.92961716651917, 0.56119620800018},  -- east floating rock near Karasus' Landing - north half
			[4] = {0.81565266847610, 0.56119620800018, 0.92961716651917, 0.62259274721146},  -- east floating rock near Karasus' Landing - middle section
			[5] = {0.82037299871445, 0.62259274721146, 0.92961716651917, 0.65996080636978},  -- east floating rock near Karasus' Landing - south of above middle section
			[6] = {0.83119285106659, 0.65996080636978, 0.92961716651917, 0.69355386495590},  -- east floating rock near Karasus' Landing - south half
			[7] = {0.24048496782780, 0.00000000000000, 0.35678505897522, 0.06878154724837},  -- north floating rock - middle section
			[8] = {0.24048496782780, 0.06878154724837, 0.32650312781334, 0.09258409589529},  -- north floating rock - south section
			[9] = {0.73049765825272, 0.58968532085419, 0.82789492607117, 0.69320708513260},  -- outer rim - south of Karasus' Landing
			[10] = {0.78565186262131, 0.69320708513260, 0.82789492607117, 0.90059036016464},  -- outer rim - south of above
			[11] = {0.19430139660835, 0.73027163743973, 0.82789492607117, 0.91422116756439},  -- outer rim - south end
			[12] = {0.07060649325275, 0.27633512020111, 0.26812949776649, 0.73027163743973},  -- outer rim - west end
			[13] = {0.12171425670385, 0.13289329409599, 0.29824274778366, 0.34425541758537},  -- outer rim - north end - east from above
			[14] = {0.29824274778366, 0.13289329409599, 0.30157667398453, 0.34425541758537},  -- outer rim - north end - east from above
			[15] = {0.30157667398453, 0.13289329409599, 0.30533048510551, 0.33688980340958},  -- outer rim - north end - east from above
			[16] = {0.30533048510551, 0.13289329409599, 0.30807453393936, 0.32788288593292},  -- outer rim - north end - east from above
			[17] = {0.30807453393936, 0.13289329409599, 0.31300327181816, 0.32129821181297},  -- outer rim - north end - east from above
			[18] = {0.31300327181816, 0.13289329409599, 0.31939730048180, 0.30955401062965},  -- outer rim - north end - east from above
			[19] = {0.31939730048180, 0.05900426954031, 0.42953002452850, 0.27856853604317},  -- outer rim - north end - east from above
			[20] = {0.42953002452850, 0.01805531047284, 0.52528887987137, 0.16944953799248},  -- outer rim - north end - east from above
			[21] = {0.52528887987137, 0.01805531047284, 0.74681603908539, 0.16944953799248},  -- outer rim - north end - east from above
			[22] = {0.67614758014679, 0.16781881451607, 0.82789492607117, 0.73049765825272},  -- outer rim - north east - south east from above to Karasus' Landing
		},
		["VioletCitadel"] = {
			[1] = {0.24813342094431, 0.42324751615524, 0.26391690969467, 0.43607267737389},  -- upper level south part
			[2] = {0.25418719649315, 0.41306078433990, 0.26763379573822, 0.42324751615524},  -- upper level north east from above
			[3] = {0.25979378819466, 0.40825596451759, 0.26960688829422, 0.41306078433990},  -- upper level north from above
			[4] = {0.26259636878967, 0.39096131920815, 0.27175131440163, 0.40825596451759},  -- upper level north from above
			[5] = {0.26015603542328, 0.37608715891838, 0.27175131440163, 0.39096131920815},  -- upper level north west from above
			[6] = {0.24976442754269, 0.36279606819153, 0.26814296841621, 0.37608715891838},  -- upper level north west from above
			[7] = {0.21763536334038, 0.34758481383324, 0.26284533739090, 0.36279606819153},  -- upper level north part
			[8] = {0.21075734496117, 0.36279606819153, 0.23006491363049, 0.38133582472801},  -- upper level south west from above
			[9] = {0.20883683860302, 0.38133582472801, 0.22105532884598, 0.41938513517380},  -- upper level south from above
		},
	},
}
]]

GoGo_Variables.DebuffDB = {
	21848,	-- Snowman constume from Xmas time -- requires 2 clicks to mount
	24347,  -- Master Angler (from Hook of the Master Angler)
	24723,  -- Skeleton costume (from trick-or-treating in Inns)
	24732,  -- Bat costume (from trick-or-treating in Inns)
	24741,  -- Wisp Costume (from Hallowed Wand - Wisp during Halloween)
--	24858,	-- Moonkin Form (Druids)  -- still needs to be removed for worgens shifting to running wild stance - handled in code
	45438,  -- Ice Block (Mages)  -- takes too long to cool down after removal
	59831,  -- Underbelly Elixir (from Underbelly Elixir - Dalaran) - one of the random effects turning player into a wasp
	--	61316,	-- Arcane Brilliance (Mages) -- USED FOR TESTING PURPOSES ONLY
	61716,  -- Rabbit Costume (from Blossoming Branch - Noblegarden / Easter)
	61734,  -- Noblegarden Bunny (from Brightly Colored Egg - Noblegarden / Easter)
	71484,  -- Strength of the Taunka (from Deathbringer's Will)
	71485,  -- Agility of the Vrykul (from Deathbringer's Will)
	71486,  -- Power of the Taunka (from Deathbringer's Will)
	--71487,  -- Precision of the Iron Dwarves (from Deathbringer's Will)			-- removed by Blizzard on MoP beta
	71491,  -- Aim of the Iron Dwarves (from Deathbringer's Will)
	71492,  -- Speed of the Vrykul (from Deathbringer's Will)
	71556,  -- Agility of the Vrykul (from Heroic Deathbringer's Will)
	--71557,  -- Precision of the Iron Dwarves (from Heroic Deathbringer's Will)		 -- removed by Blizzard on MoP beta
	71558,  -- Power of the Taunka (from Heroic Deathbringer's Will)
	71559,  -- Aim of the Iron Dwarves (from Heroic Deathbringer's Will)
	71560,  -- Speed of the Vrykul (from Heroic Deathbringer's Will)
	71561,  -- Strength of the Taunka (from Heroic Deathbringer's Will)
	75724,	-- Seeds of Discord (Mount Hyjal quest from item "Ogre Disguise" itemid 55137)
	91760,	-- Endure the Transformation (from Bones of Transformation)
	91771,	-- Wisp Form (from Wisp Amulet)
	98445,  -- Trapped In Amber (from Ancient Amber)  -- requires 2 clicks to mount
	122099,  -- Bamboozled (from /love Meng Meng in SW)
	
}

GoGo_Variables.GroundSpeed = {
	200,  -- Ground fast
	160,  -- Ground slow
	100,  -- Ground really slow
}

GoGo_Variables.AirSpeed = {
	410,  -- Air faster
	380,  -- Air fast
	250,  -- Air slow
}

GoGo_Variables.WaterSpeed = {
	371,  -- Abyssal Seahorse
	108,  -- Subdued Seahorse
	91,  -- Master Angler
	67,  -- Water normal
}

GoGo_Variables.WaterSurfaceSpeed = {
	371,  -- Abyssal Seahorse
	200,  -- Water surface ground mounts such as water striders
	108,  -- Subdued Seahorse
	91,  -- Master Angler
	67,  -- Water normal
}
