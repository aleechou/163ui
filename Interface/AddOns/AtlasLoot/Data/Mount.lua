local AtlasLoot = _G.AtlasLoot
local Mount = {}
AtlasLoot.Data.Mount = Mount
local AL = AtlasLoot.Locales

-- lua

-- WoW
local C_MountJournal_GetNumMounts, C_MountJournal_GetMountInfo, C_MountJournal_GetMountInfoExtra = C_MountJournal.GetNumMounts, C_MountJournal.GetMountInfo, C_MountJournal.GetMountInfoExtra


local ALL_DATA_LOADED = false

local NO_ITEM_ID = 0

-- save all mountinfos
local MOUNT_INFO = {
	["spells"] = { -- [spellID] = itemID
		[171846] = 116789,	--Champion's Treadblade
		[17453] = 13321,	--Green Mechanostrider
		[98204] = 69747,	--Amani Battle Bear
		[60424] = 44413,	--Mekgineer's Chopper
		[32296] = 25532,	--Swift Yellow Wind Rider
		[87090] = 62461,	--Goblin Trike
		[92232] = 64999,	--Spectral Wolf
		[60025] = 44178,	--Albino Drake
		[64656] = NO_ITEM_ID,	--Blue Skeletal Warhorse
		[66906] = 47179,	--Argent Charger
		[40192] = 32458,	--Ashes of Al'ar
		[171626] = 116665,	--Armored Irontusk
		[22723] = 29471,	--Black War Tiger
		[121839] = 83089,	--Sunstone Panther
		[23250] = 18796,	--Swift Brown Wolf
		[171627] = 116666,	--Blacksteel Battleboar
		[65439] = 46171,	--Furious Gladiator's Frost Wyrm
		[34795] = 28927,	--Red Hawkstrider
		[171436] = 116383,	--Gorestrider Gronnling
		[44153] = 34060,	--Flying Machine
		[64657] = 46100,	--White Kodo
		[68057] = 49044,	--Swift Alliance Steed
		[46628] = 35513,	--Swift White Hawkstrider
		[64927] = 46708,	--Deadly Gladiator's Frost Wyrm
		[10799] = 8592,	--Violet Raptor
		[126507] = 87250,	--Depleted-Kyparium Rocket
		[171623] = 116662,	--Trained Meadowstomper
		[46197] = 49285,	--X-51 Nether-Rocket
		[37015] = 30609,	--Swift Nether Drake
		[171629] = 116668,	--Armored Frostboar
		[39316] = 28915,	--Dark Riding Talbuk
		[63635] = 45593,	--Darkspear Raptor
		[127174] = 87781,	--Azure Riding Crane
		[153489] = 107951,	--Iron Skyreaver
		[68056] = 49046,	--Swift Horde Wolf
		[123182] = NO_ITEM_ID,	--White Riding Yak
		[127302] = 87803,	--Great Blue Dragon Turtle
		[98718] = 67151,	--Subdued Seahorse
		[33660] = 28936,	--Swift Pink Hawkstrider
		[6653] = 5665,	--Dire Wolf
		[33630] = NO_ITEM_ID,	--Blue Mechanostrider
		[87091] = 62462,	--Goblin Turbo-Trike
		[138424] = 94230,	--Amber Primordial Direhorn
		[64658] = 46099,	--Black Wolf
		[39315] = 31829,	--Cobalt Riding Talbuk
		[10795] = NO_ITEM_ID,	--Ivory Raptor
		[46199] = 49286,	--X-51 Nether-Rocket X-TREME
		[23242] = 18789,	--Swift Olive Raptor
		[16084] = 8586,	--Mottled Red Raptor
		[75596] = 54797,	--Frosty Flying Carpet
		[23243] = 18790,	--Swift Orange Raptor
		[127271] = NO_ITEM_ID,	--Crimson Water Strider
		[17454] = 13322,	--Unpainted Mechanostrider
		[171632] = 116670,	--Frostplains Battleboar
		[32289] = 25527,	--Swift Red Gryphon
		[32297] = 25533,	--Swift Purple Wind Rider
		[171824] = 116767,	--Sapphire Riverbeast
		[68187] = 49096,	--Crusader's White Warhorse
		[121838] = 83087,	--Ruby Panther
		[102488] = 72575,	--White Riding Camel
		[59793] = 44231,	--Wooly Mammoth
		[6777] = 5864,	--Gray Ram
		[135416] = 93168,	--Grand Armored Gryphon
		[35020] = 29220,	--Blue Hawkstrider
		[127176] = 87782,	--Golden Riding Crane
		[148620] = 104327,	--Prideful Gladiator's Cloud Serpent
		[60024] = 44177,	--Violet Proto-Drake
		[16056] = 12302,	--Ancient Frostsaber
		[63636] = 45586,	--Ironforge Ram
		[171634] = 116672,	--Domesticated Razorback
		[23219] = 18767,	--Swift Mistsaber
		[23227] = 18776,	--Swift Palomino
		[22724] = 29469,	--Black War Wolf
		[68188] = 49098,	--Crusader's Black Warhorse
		[23251] = 18797,	--Swift Timber Wolf
		[43899] = 33976,	--Brewfest Ram
		[63844] = 45725,	--Argent Hippogryph
		[139442] = 95057,	--Thundering Cobalt Cloud Serpent
		[59788] = 44077,	--Black War Mammoth
		[66847] = 47100,	--Striped Dawnsaber
		[127177] = 87783,	--Regal Riding Crane
		[127209] = NO_ITEM_ID,	--Black Riding Yak
		[59976] = 44164,	--Black Proto-Drake
		[63956] = 45801,	--Ironbound Proto-Drake
		[134573] = 92724,	--Swift Windsteed
		[171636] = 116674,	--Great Greytusk
		[17229] = 13086,	--Winterspring Frostsaber
		[136505] = 93671,	--Ghastly Charger
		[171828] = 116771,	--Solar Spirehawk
		[120822] = 82811,	--Great Red Dragon Turtle
		[132036] = 90655,	--Thundering Ruby Cloud Serpent
		[59996] = 44151,	--Blue Proto-Drake
		[170347] = 115484,	--Core Hound
		[171637] = 116675,	--Trained Rocktusk
		[75207] = 54465,	--Vashj'ir Seahorse
		[63637] = 45591,	--Darnassian Nightsaber
		[171829] = 116772,	--Shadowmane Charger
		[129918] = 89304,	--Thundering August Cloud Serpent
		[16081] = 12351,	--Arctic Wolf
		[17464] = 13333,	--Brown Skeletal Horse
		[60140] = NO_ITEM_ID,	--Grand Caravan Mammoth
		[138423] = 94228,	--Cobalt Primordial Direhorn
		[93644] = 67107,	--Kor'kron Annihilator
		[163025] = 112327,	--Grinning Reaver
		[171830] = 116773,	--Swift Breezestrider
		[458] = 5656,	--Brown Horse
		[142266] = 98104,	--Armored Red Dragonhawk
		[126508] = 87251,	--Geosynchronous World Spinner
		[39317] = 31831,	--Silver Riding Talbuk
		[30174] = 103630,	--Riding Turtle
		[35710] = 29744,	--Gray Elekk
		[32243] = 25474,	--Tawny Wind Rider
		[171831] = 116774,	--Trained Silverpelt
		[459] = NO_ITEM_ID,	--Gray Wolf
		[65640] = 46752,	--Swift Gray Steed
		[75973] = 54860,	--X-53 Touring Rocket
		[122708] = 84101,	--Grand Expedition Yak
		[17463] = 13332,	--Blue Skeletal Horse
		[101821] = 71954,	--Ruthless Gladiator's Twilight Drake
		[142641] = 98405,	--Brawler's Burly Mushan Beast
		[171832] = 116775,	--Breezestrider Stallion
		[59568] = 43953,	--Blue Drake
		[88748] = 63044,	--Brown Riding Camel
		[130086] = 89362,	--Brown Riding Goat
		[93326] = 65891,	--Sandstone Drake
		[139448] = 95059,	--Clutch of Ji-Kun
		[43900] = 33977,	--Swift Brewfest Ram
		[35022] = 29221,	--Black Hawkstrider
		[171833] = 116776,	--Pale Thorngrazer
		[103195] = 73838,	--Mountain Horse
		[49378] = NO_ITEM_ID,	--Brewfest Riding Kodo
		[64977] = 46308,	--Black Skeletal Horse
		[127308] = 87804,	--Great Brown Dragon Turtle
		[22722] = 29470,	--Red Skeletal Warhorse
		[24242] = 19872,	--Swift Razzashi Raptor
		[23228] = 18778,	--Swift White Steed
		[171834] = 116777,	--Vicious War Ram
		[65637] = 46745,	--Great Red Elekk
		[23252] = 18798,	--Swift Gray Wolf
		[26056] = 21323,	--Green Qiraji Battle Tank
		[39318] = 31833,	--Tan Riding Talbuk
		[23338] = 18902,	--Swift Stormsaber
		[66907] = NO_ITEM_ID,	--Argent Warhorse
		[34767] = NO_ITEM_ID,	--Thalassian Charger
		[171835] = 116778,	--Vicious War Raptor
		[25863] = NO_ITEM_ID,	--Black Qiraji Battle Tank
		[472] = 2414,	--Pinto
		[155741] = 109013,	--Dread Raven
		[66088] = 46814,	--Sunreaver Dragonhawk
		[127154] = 87768,	--Onyx Cloud Serpent
		[61451] = 44554,	--Flying Carpet
		[61467] = 44083,	--Grand Black War Mammoth
		[171836] = 116779,	--Garn Steelmaw
		[65638] = 46744,	--Swift Moonsaber
		[59569] = 43951,	--Bronze Drake
		[61294] = 44707,	--Green Proto-Drake
		[65639] = 46751,	--Swift Red Hawkstrider
		[171617] = 116656,	--Trained Icehoof
		[64659] = 46102,	--Venomhide Ravasaur
		[63639] = 45590,	--Exodar Elekk
		[59567] = 43952,	--Azure Drake
		[124659] = 85870,	--Imperial Quilen
		[6899] = 5872,	--Brown Ram
		[61230] = 44690,	--Armored Blue Wind Rider
		[127310] = 87805,	--Great Purple Dragon Turtle
		[44317] = NO_ITEM_ID,	--Merciless Nether Drake
		[72286] = 50818,	--Invincible
		[149801] = 106246,	--Emerald Hippogryph
		[171838] = 116781,	--Armored Frostwolf
		[26055] = 21324,	--Yellow Qiraji Battle Tank
		[39798] = 32314,	--Green Riding Nether Ray
		[67336] = 47840,	--Relentless Gladiator's Frost Wyrm
		[39319] = 31835,	--White Riding Talbuk
		[97581] = 69228,	--Savage Raptor
		[163024] = 112326,	--Warforged Nightmare
		[96491] = 68823,	--Armored Razzashi Raptor
		[171839] = 116782,	--Ironside Warwolf
		[54729] = 40775,	--Winged Steed of the Ebon Blade
		[148972] = NO_ITEM_ID,	--Dreadsteed
		[32292] = 25529,	--Swift Purple Gryphon
		[18989] = 15277,	--Gray Kodo
		[98727] = 69846,	--Winged Guardian
		[10796] = 8591,	--Turquoise Raptor
		[34896] = 29102,	--Cobalt War Talbuk
		[101282] = 71339,	--Vicious Gladiator's Twilight Drake
		[468] = NO_ITEM_ID,	--White Stallion
		[132118] = 90711,	--Emerald Pandaren Phoenix
		[61447] = 44234,	--Traveler's Tundra Mammoth
		[54753] = 43962,	--White Polar Bear
		[103196] = 73839,	--Swift Mountain Horse
		[127156] = 87769,	--Crimson Cloud Serpent
		[63640] = 45595,	--Orgrimmar Wolf
		[171841] = 116784,	--Trained Snarler
		[127216] = 87788,	--Grey Riding Yak
		[88331] = 62900,	--Volcanic Stone Drake
		[135418] = 93169,	--Grand Armored Wyvern
		[129935] = 89306,	--Red Shado-Pan Riding Tiger
		[41252] = 32768,	--Raven Lord
		[23221] = 18766,	--Swift Frostsaber
		[22718] = 29466,	--Black War Kodo
		[61229] = 44689,	--Armored Snowy Gryphon
		[65641] = 46750,	--Great Golden Kodo
		[35711] = 29743,	--Purple Elekk
		[130137] = 89390,	--White Riding Goat
		[22719] = 29465,	--Black Battlestrider
		[61309] = 44558,	--Magnificent Flying Carpet
		[66124] = NO_ITEM_ID,	--Magic Rooster
		[34769] = NO_ITEM_ID,	--Thalassian Warhorse
		[171843] = 116786,	--Smoky Direwolf
		[136164] = 93386,	--Grand Wyvern
		[61465] = 43959,	--Grand Black War Mammoth
		[35025] = 29223,	--Swift Green Hawkstrider
		[32290] = 25528,	--Swift Green Gryphon
		[97359] = 69213,	--Flameward Hippogryph
		[129932] = 89305,	--Green Shado-Pan Riding Tiger
		[61469] = 44086,	--Grand Ice Mammoth
		[61996] = 44843,	--Blue Dragonhawk
		[65642] = 46747,	--Turbostrider
		[42776] = 49283,	--Spectral Tiger
		[130092] = 89363,	--Red Flying Cloud
		[123992] = 85430,	--Azure Cloud Serpent
		[110039] = 78919,	--Experiment 12-B
		[107844] = 77068,	--Twilight Harbinger
		[63641] = 45592,	--Thunder Bluff Kodo
		[171845] = 116788,	--Warlord's Deathwheel
		[6898] = 5873,	--White Ram
		[16082] = 12354,	--Palomino
		[97560] = 69230,	--Corrupted Fire Hawk
		[127158] = 87771,	--Heavenly Onyx Cloud Serpent
		[146615] = 102514,	--Vicious Warsaber
		[69820] = NO_ITEM_ID,	--Sunwalker Kodo
		[66090] = 46815,	--Quel'dorei Steed
		[36702] = 30480,	--Fiery Warhorse
		[65643] = 46748,	--Swift Violet Ram
		[23509] = 19029,	--Frostwolf Howler
		[6654] = 5668,	--Brown Wolf
		[123993] = 85429,	--Golden Cloud Serpent
		[113120] = 79771,	--Feldrake
		[101573] = 71718,	--Swift Shorestrider
		[8980] = NO_ITEM_ID,	--Skeletal Horse
		[32244] = 25475,	--Blue Wind Rider
		[58819] = NO_ITEM_ID,	--Swift Brown Steed
		[132117] = 90710,	--Ashen Pandaren Phoenix
		[66123] = NO_ITEM_ID,	--Magic Rooster
		[88990] = 63125,	--Dark Phoenix
		[17465] = 13334,	--Green Skeletal Warhorse
		[129934] = 89307,	--Blue Shado-Pan Riding Tiger
		[61470] = 43961,	--Grand Ice Mammoth
		[171848] = 116791,	--Challenger's War Yeti
		[65644] = 46743,	--Swift Purple Raptor
		[113199] = 79802,	--Jade Cloud Serpent
		[34899] = 29105,	--Tan War Talbuk
		[72808] = 51954,	--Bloodbathed Frostbrood Vanquisher
		[101542] = 71665,	--Flametalon of Alysrazor
		[171621] = 116660,	--Ironhoof Destroyer
		[63642] = 45596,	--Silvermoon Hawkstrider
		[171849] = 116792,	--Sunhide Gronnling
		[127220] = 87789,	--Blonde Riding Yak
		[132119] = 90712,	--Violet Pandaren Phoenix
		[73629] = NO_ITEM_ID,	--Exarch's Elekk
		[23510] = 19030,	--Stormpike Battle Charger
		[23214] = NO_ITEM_ID,	--Charger
		[23222] = 18774,	--Swift Yellow Mechanostrider
		[24252] = 19902,	--Swift Zulian Tiger
		[23238] = 18786,	--Swift Brown Ram
		[23246] = 18791,	--Purple Skeletal Warhorse
		[129552] = 89154,	--Crimson Pandaren Phoenix
		[102350] = 72146,	--Swift Lovebird
		[138426] = 94231,	--Jade Primordial Direhorn
		[48025] = 37012,	--Headless Horseman's Mount
		[148476] = 104269,	--Thundering Onyx Cloud Serpent
		[138640] = 94290,	--Bone-White Primal Raptor
		[171851] = 116794,	--Garn Nighthowl
		[148392] = 104208,	--Spawn of Galakras
		[67466] = 47180,	--Argent Warhorse
		[73630] = NO_ITEM_ID,	--Great Exarch's Elekk
		[10789] = 8632,	--Spotted Frostsaber
		[93623] = 68008,	--Mottled Drake
		[15779] = 13326,	--White Mechanostrider Mod B
		[139595] = 95341,	--Armored Bloodwing
		[107516] = 76889,	--Spectral Gryphon
		[65646] = 46749,	--Swift Burgundy Wolf
		[71810] = 50435,	--Wrathful Gladiator's Frost Wyrm
		[60002] = 44168,	--Time-Lost Proto-Drake
		[25953] = 21218,	--Blue Qiraji Battle Tank
		[146622] = 102533,	--Vicious Skeletal Warhorse
		[65917] = 49290,	--Magic Rooster
		[35027] = 29224,	--Swift Purple Hawkstrider
		[59571] = 43954,	--Twilight Drake
		[171624] = 116663,	--Shadowhide Pearltusk
		[578] = NO_ITEM_ID,	--Black Wolf
		[127286] = 87795,	--Black Dragon Turtle
		[6648] = 5655,	--Chestnut Mare
		[134359] = 95416,	--Sky Golem
		[579] = NO_ITEM_ID,	--Red Wolf
		[92155] = 64883,	--Ultramarine Qiraji Battle Tank
		[107517] = 76902,	--Spectral Wind Rider
		[34898] = 29104,	--Silver War Talbuk
		[580] = 1132,	--Timber Wolf
		[13819] = NO_ITEM_ID,	--Warhorse
		[55164] = NO_ITEM_ID,	--Swift Spectral Gryphon
		[39802] = 32318,	--Silver Riding Nether Ray
		[581] = NO_ITEM_ID,	--Winter Wolf
		[96499] = 68824,	--Swift Zulian Panther
		[32245] = 25476,	--Green Wind Rider
		[139407] = 95041,	--Malevolent Gladiator's Cloud Serpent
		[22720] = 29467,	--Black War Ram
		[127287] = 87796,	--Blue Dragon Turtle
		[26656] = 21176,	--Black Qiraji Battle Tank
		[10793] = 8629,	--Striped Nightsaber
		[138643] = 94293,	--Green Primal Raptor
		[100332] = 70909,	--Vicious War Steed
		[138641] = 94291,	--Red Primal Raptor
		[73313] = 52200,	--Crimson Deathcharger
		[23248] = 18795,	--Great Gray Kodo
		[23223] = 18773,	--Swift White Mechanostrider
		[17450] = 13317,	--Ivory Raptor
		[102349] = 72145,	--Swift Springstrider
		[17481] = 13335,	--Rivendare's Deathcharger
		[35028] = 34129,	--Swift Warstrider
		[59572] = NO_ITEM_ID,	--Black Polar Bear
		[51412] = 49282,	--Big Battle Bear
		[102346] = 72140,	--Swift Forest Strider
		[127288] = 87797,	--Brown Dragon Turtle
		[28828] = NO_ITEM_ID,	--Nether Drake
		[118089] = 81354,	--Azure Water Strider
		[136471] = 93666,	--Spawn of Horridon
		[100333] = 70910,	--Vicious War Wolf
		[23239] = 18787,	--Swift Gray Ram
		[23247] = 18793,	--Great White Kodo
		[39803] = 32319,	--Blue Riding Nether Ray
		[17462] = 13331,	--Red Skeletal Horse
		[148396] = 104246,	--Kor'kron War Wolf
		[48027] = 35906,	--Black War Elekk
		[48778] = NO_ITEM_ID,	--Acherus Deathcharger
		[127161] = 87773,	--Heavenly Crimson Cloud Serpent
		[133023] = 91802,	--Jade Pandaren Kite
		[148417] = 104253,	--Kor'kron Juggernaut
		[127164] = 87774,	--Heavenly Golden Cloud Serpent
		[127289] = 87799,	--Purple Dragon Turtle
		[61425] = 44235,	--Traveler's Tundra Mammoth
		[107203] = 76755,	--Tyrael's Charger
		[49193] = 37676,	--Vengeful Nether Drake
		[39800] = 32317,	--Red Riding Nether Ray
		[34406] = 28481,	--Brown Elekk
		[8394] = 8631,	--Striped Frostsaber
		[66846] = 47101,	--Ochre Skeletal Warhorse
		[62048] = NO_ITEM_ID,	--Black Dragonhawk Mount
		[88741] = 63039,	--Drake of the West Wind
		[103081] = 73766,	--Darkmoon Dancing Bear
		[127290] = 87800,	--Red Dragon Turtle
		[59961] = 44160,	--Red Proto-Drake
		[10873] = 8563,	--Red Mechanostrider
		[10969] = 8595,	--Blue Mechanostrider
		[60116] = 44226,	--Armored Brown Bear
		[64731] = 46109,	--Sea Turtle
		[58615] = 43516,	--Brutal Nether Drake
		[61997] = 44842,	--Red Dragonhawk
		[39801] = 32316,	--Purple Riding Nether Ray
		[48954] = NO_ITEM_ID,	--Swift Zhevra
		[63643] = 45597,	--Forsaken Warhorse
		[18992] = 15293,	--Teal Kodo
		[35018] = 29222,	--Purple Hawkstrider
		[59797] = 44080,	--Ice Mammoth
		[88742] = 63040,	--Drake of the North Wind
		[34790] = 29228,	--Dark War Talbuk
		[97493] = 69224,	--Pureblood Fire Hawk
		[96503] = 68825,	--Amani Dragonhawk
		[32246] = 25477,	--Swift Red Wind Rider
		[142478] = 98259,	--Armored Blue Dragonhawk
		[121820] = 83086,	--Obsidian Nightwing
		[5784] = NO_ITEM_ID,	--Felsteed
		[17459] = 13327,	--Icy Blue Mechanostrider Mod A
		[41513] = 32857,	--Onyx Netherwing Drake
		[138642] = 94292,	--Black Primal Raptor
		[35712] = 29746,	--Great Green Elekk
		[16083] = 12353,	--White Stallion
		[130985] = 89785,	--Pandaren Kite
		[148970] = NO_ITEM_ID,	--Felsteed
		[58983] = 43599,	--Big Blizzard Bear
		[60021] = 44175,	--Plagued Proto-Drake
		[16055] = 12303,	--Black Nightsaber
		[49322] = 37719,	--Swift Zhevra
		[84751] = 60954,	--Fossilized Raptor
		[26054] = 21321,	--Red Qiraji Battle Tank
		[171635] = 116673,	--Giant Coldsnout
		[107842] = 77067,	--Blazing Drake
		[75614] = 54811,	--Celestial Steed
		[171825] = 116768,	--Mosshide Riverwallow
		[63796] = 45693,	--Mimiron's Head
		[130965] = 89783,	--Son of Galleon
		[22721] = 29472,	--Black War Raptor
		[23240] = 18785,	--Swift White Ram
		[72807] = 51955,	--Icebound Frostbrood Vanquisher
		[44744] = 34092,	--Merciless Nether Drake
		[55531] = 41508,	--Mechano-Hog
		[88744] = 63041,	--Drake of the South Wind
		[63963] = 45802,	--Rusted Proto-Drake
		[60114] = 44225,	--Armored Brown Bear
		[127165] = 87775,	--Heavenly Jade Cloud Serpent
		[120043] = 82453,	--Jeweled Onyx Panther
		[140249] = 95564,	--Golden Primal Direhorn
		[18990] = 15290,	--Brown Kodo
		[127293] = 87801,	--Great Green Dragon Turtle
		[175700] = 118676,	--Emerald Drake
		[41514] = 32858,	--Azure Netherwing Drake
		[15780] = NO_ITEM_ID,	--Green Mechanostrider
		[138425] = 94229,	--Slate Primordial Direhorn
		[32240] = 25472,	--Snowy Gryphon
		[140250] = 95565,	--Crimson Primal Direhorn
		[169952] = 115363,	--Creeping Carpet
		[120395] = 82765,	--Green Dragon Turtle
		[148618] = 104325,	--Tyrannical Gladiator's Cloud Serpent
		[66087] = 46813,	--Silver Covenant Hippogryph
		[171842] = 116785,	--Swift Frostwolf
		[136400] = 93662,	--Armored Skyscreamer
		[6896] = NO_ITEM_ID,	--Black Ram
		[136163] = 93385,	--Grand Gryphon
		[60118] = 44223,	--Black War Bear
		[18991] = 15292,	--Green Kodo
		[148619] = 104326,	--Grievous Gladiator's Cloud Serpent
		[63232] = 45125,	--Stormwind Steed
		[65645] = 46746,	--White Skeletal Warhorse
		[59650] = 43986,	--Black Drake
		[59570] = 43955,	--Red Drake
		[148428] = 103638,	--Ashhide Mushan Beast
		[470] = 2411,	--Black Stallion
		[63638] = 45589,	--Gnomeregan Mechanostrider
		[88746] = 63043,	--Vitreous Stone Drake
		[66091] = 46816,	--Sunreaver Hawkstrider
		[59799] = 43958,	--Ice Mammoth
		[32239] = 25471,	--Ebon Gryphon
		[23229] = 18777,	--Swift Brown Steed
		[41517] = 32861,	--Veridian Netherwing Drake
		[107845] = 77069,	--Life-Binder's Handmaiden
		[127295] = 87802,	--Great Black Dragon Turtle
		[17460] = 13329,	--Frost Ram
		[41515] = 32859,	--Cobalt Netherwing Drake
		[32295] = 25531,	--Swift Green Wind Rider
		[26655] = NO_ITEM_ID,	--Black Qiraji Battle Tank
		[32242] = 25473,	--Swift Blue Gryphon
		[127213] = NO_ITEM_ID,	--Brown Riding Yak
		[35714] = 29747,	--Great Purple Elekk
		[74918] = 54068,	--Wooly White Rhino
		[130138] = 89391,	--Black Riding Goat
		[90621] = 62298,	--Golden King
		[23161] = NO_ITEM_ID,	--Dreadsteed
		[41518] = 32862,	--Violet Netherwing Drake
		[88749] = 63045,	--Tan Riding Camel
		[22717] = 29468,	--Black War Steed
		[60119] = 44224,	--Black War Bear
		[124408] = 85666,	--Thundering Jade Cloud Serpent
		[42777] = 49284,	--Swift Spectral Tiger
		[66122] = NO_ITEM_ID,	--Magic Rooster
		[23225] = 18772,	--Swift Green Mechanostrider
		[118737] = 81559,	--Pandaren Kite
		[23241] = 18788,	--Swift Blue Raptor
		[23249] = 18794,	--Great Brown Kodo
		[59791] = 44230,	--Wooly Mammoth
		[71342] = 50250,	--Big Love Rocket
		[43927] = 33999,	--Cenarion War Hippogryph
		[124550] = 85785,	--Cataclysmic Gladiator's Twilight Drake
		[69826] = NO_ITEM_ID,	--Great Sunwalker Kodo
		[127169] = 87776,	--Heavenly Azure Cloud Serpent
		[171844] = 108883,	--Dustmane Direwolf
		[34897] = 29103,	--White War Talbuk
		[32235] = 25470,	--Golden Gryphon
		[123886] = 85262,	--Amber Scorpion
		[171620] = 116659,	--Bloodhoof Bull
		[41516] = 32860,	--Purple Netherwing Drake
		[142073] = 98618,	--Hearthsteed
		[110051] = 78924,	--Heart of the Aspects
		[121836] = 83090,	--Sapphire Panther
		[74856] = 54069,	--Blazing Hippogryph
		[44151] = 34061,	--Turbo-Charged Flying Machine
		[102514] = 72582,	--Corrupted Hippogryph
		[148626] = 104329,	--Furious Ashhide Mushan
		[43688] = NO_ITEM_ID,	--Amani War Bear
		[69395] = 49636,	--Onyxian Drake
		[127170] = 87777,	--Astral Cloud Serpent
		[171625] = 116664,	--Dusty Rockhide
		[16080] = 12330,	--Red Wolf
		[142878] = 97989,	--Enchanted Fey Dragon
		[60136] = NO_ITEM_ID,	--Grand Caravan Mammoth
		[171622] = 116661,	--Mottled Meadowstomper
		[18363] = NO_ITEM_ID,	--Riding Kodo
		[49379] = 37828,	--Great Brewfest Kodo
		[17461] = 13328,	--Black Ram
		[121837] = 83088,	--Jade Panther
		[92231] = 64998,	--Spectral Steed
		[35713] = 29745,	--Great Blue Elekk
		[88718] = 63042,	--Phosphorescent Stone Drake
		[88750] = 63046,	--Grey Riding Camel
		[59785] = 43956,	--Black War Mammoth
		[97501] = 69226,	--Felfire Hawk
		[88335] = 62901,	--Drake of the East Wind
		[8395] = 8588,	--Emerald Raptor
		[171638] = 116676,	--Trained Riverwallow
	},
	["items"] = {
		[31830] = 39315,	--Cobalt Riding Talbuk
		[31832] = 39317,	--Silver Riding Talbuk
		[31834] = 39318,	--Tan Riding Talbuk
		[31836] = 39319,	--White Riding Talbuk
		[29227] = 34896,	--Cobalt War Talbuk
		[29229] = 34898,	--Silver War Talbuk
		[29230] = 34899,	--Tan War Talbuk
		[29231] = 34897,	--White War Talbuk
		[65356] = 88741,	--Drake of the West Wind		double entry....
	}, -- [itemID] = spellID
	["index"] = {}, -- [spellID] = index
}

--[[
local creatureName, spellID, icon, active, isUsable, sourceType = C_MountJournal.GetMountInfo(index);
local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal.GetMountInfoExtra(index);
MountJournal.MountDisplay.ModelFrame:SetDisplayInfo(creatureDisplayID)
]]--

local function LoadAllData()
	if ALL_DATA_LOADED then return end
	
	local _, spellID
	for i=1,C_MountJournal_GetNumMounts() do
		_, spellID = C_MountJournal_GetMountInfo(i)
		if MOUNT_INFO["spells"][spellID] then
			MOUNT_INFO["items"][ MOUNT_INFO["spells"][spellID] ] = spellID
		else
			MOUNT_INFO["spells"][spellID] = NO_ITEM_ID
		end
		MOUNT_INFO["index"][spellID] = i
	end
	
	ALL_DATA_LOADED = true
end

function Mount.GetItemIDfromSpellID(spellID)
	if not ALL_DATA_LOADED then LoadAllData() end
	return MOUNT_INFO["spells"][spellID]
end

function Mount.GetSpellIDfromItemID(itemID)
	if not ALL_DATA_LOADED then LoadAllData() end
	return MOUNT_INFO["items"][itemID]
end

function Mount.GetIndexFromSpellID(spellID)
	if not ALL_DATA_LOADED then LoadAllData() end
	return MOUNT_INFO["index"][spellID]
end

function Mount.GetIndexFromItemID(itemID)
	if not ALL_DATA_LOADED then LoadAllData() end
	return ( MOUNT_INFO["items"][itemID] and MOUNT_INFO["items"][itemID] ~= 0 ) and MOUNT_INFO["index"][ MOUNT_INFO["items"][itemID] ] or nil
end

function Mount.GetDisplayIDfromItemID(itemID)
	local displayID = C_MountJournal_GetMountInfoExtra( Mount.GetIndexFromItemID(itemID) )
	return ( displayID and displayID ~= 0 ) and displayID or nil
end

-- AtlasLoot.Data.Mount.DEV_SaveDataIntoDB()
function Mount.DEV_SaveDataIntoDB()
	AtlasLoot.db.MOUNTINFO = {}
	local numMounts = C_MountJournal.GetNumMounts()
	
	local name, spellID
	for i=1,numMounts do
		name, spellID = C_MountJournal_GetMountInfo(i)
		if name and spellID then
			AtlasLoot.db.MOUNTINFO[spellID] = name
		end
	end
end