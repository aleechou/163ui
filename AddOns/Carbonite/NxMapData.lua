---------------------------------------------------------------------------------------
-- NxMapData - Map code
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

--[[

4 = Durotar
9 = Mulgore
11 = Barrens (Northern Barrens)
13 = Kalimdor (continent 1)
14 = Azeroth (continent 2)
15 = Alterac
16 = Arathi
17 = Badlands
19 = BlastedLands
20 = Tirisfal
21 = Silverpine
22 = WesternPlaguelands
23 = EasternPlaguelands
24 = Hilsbrad
26 = Hinterlands
27 = DunMorogh
28 = SearingGorge
29 = BurningSteppes
30 = Elwynn
32 = DeadwindPass
34 = Duskwood
35 = LochModan
36 = Redridge
37 = Stranglethorn (Northern Stranglethorn)
38 = SwampOfSorrows
39 = Westfall
40 = Wetlands
41 = Teldrassil
42 = Darkshore
43 = Ashenvale
61 = ThousandNeedles
81 = StonetalonMountains
101 = Desolace
121 = Feralas
141 = Dustwallow
161 = Tanaris
181 = Aszhara
182 = Felwood
201 = UngoroCrater
241 = Moonglade
261 = Silithus
281 = Winterspring
301 = Stormwind
321 = Ogrimmar
341 = Ironforge
362 = ThunderBluff
381 = Darnassis
382 = Undercity
401 = AlteracValley
443 = WarsongGulch
461 = ArathiBasin
462 = EversongWoods
463 = Ghostlands
464 = AzuremystIsle
465 = Hellfire
466 = Expansion01 (continent 3 Outland)
467 = Zangarmarsh
471 = TheExodar
473 = ShadowmoonValley
475 = BladesEdgeMountains
476 = BloodmystIsle
477 = Nagrand
478 = TerokkarForest
479 = Netherstorm
480 = SilvermoonCity
481 = ShattrathCity
482 = NetherstormArena
485 = Northrend (continent 4)
486 = BoreanTundra
488 = Dragonblight
490 = GrizzlyHills
491 = HowlingFjord
492 = IcecrownGlacier
493 = SholazarBasin
495 = TheStormPeaks
496 = ZulDrak
499 = Sunwell
501 = LakeWintergrasp
502 = ScarletEnclave
504 = Dalaran
510 = CrystalsongForest
512 = StrandoftheAncients
520 = TheNexus
521 = CoTStratholme
522 = Ahnkahet
523 = UtgardeKeep
524 = UtgardePinnacle
525 = HallsofLightning
526 = Ulduar77
527 = TheEyeofEternity
528 = Nexus80
529 = Ulduar
530 = Gundrak
531 = TheObsidianSanctum
532 = VaultofArchavon
533 = AzjolNerub
534 = DrakTharonKeep
535 = Naxxramas
536 = VioletHold
540 = IsleofConquest
541 = HrothgarsLanding
542 = TheArgentColiseum
609 = RubySanctum

Cataclysm

-- Continent 1
606 = Mount Hyjal
607 = Southern Barrens
720 = Uldum
772 = Ahn'Qiraj: The Fallen Kingdom

-- Continent 2
689 = Stranglethorn Vale (full map)
673 = The Cape of Stranglethorn (south part)

-- Continent 2 (Vashj'ir sub continent of EK)
613 = Vashj'ir (full map)
610 = Kelp'thar Forest
614 = Abyssal Depths
615 = Shimmering Expanse

-- Continent 5 (The Maelstrom)
751 = The Maelstrom (continent)
544 = The Lost Isles (goblin starting)
605 = Kezan (goblin city)
640 = Deepholm
737 = The Maelstrom

545 = Gilneas (starting phase)
611 = GilneasCity (starting city phase)
626 = TwinPeaks (battle ground)
680 = RagefireChasm
685 = Ruins of Gilneas City (Worgen city)
686 = ZulFarrak
687 = TheTempleOfAtalHakkar
688 = BlackfathomDeeps
690 = TheStockade
691 = Gnomeregan
692 = Uldaman
696 = MoltenCore
699 = DireMaul (multiple layers for each wing)
700 = Twilight Highlands
704 = BlackrockDepths
708 = Tol Barad (battle ground)
709 = Tol Barad Peninsula
717 = RuinsofAhnQiraj
718 = OnyxiasLair
721 = BlackrockSpire
736 = BattleForGilneas (battle ground)
747 = LostCityOfTheTolvir
749 = WailingCaverns
750 = Maraudon
752 = BardinHold
753 = BlackrockCaverns
754 = BlackwingDescent
755 = BlackwingLair
756 = TheDeadmines
757 = GrimBatol
758 = BastionOfTwilight
759 = HallsOfOrigination
760 = RazorfenDowns
761 = RazorfenKraul
762 = ScarletMonastery (multiple layers for each wing)
763 = Scholomance
764 = ShadowfangKeep
765 = Stratholme
766 = AhnQiraj
767 = ThroneOfTheTides
768 = TheStonecore
769 = TheVortexPinnacle
773 = ThroneOfTheFourWinds

775 = CoTMountHyjal
776 = GruulsLair
779 = MagtheridonsLair
780 = CoilfangReservoir
781 = ZulAman
782 = TempestKeep
789 = SunwellPlateau
793 = ZulGurub
795 = MoltenFront
796 = BlackTemple
797 = HellfireRamparts
798 = MagistersTerrace
799 = Karazhan
800 = Firelands
803 = TheNexusLegendary
806 = TheJadeForest
807 = ValleyoftheFourWinds
808 = TheWanderingIsle
809 = KunLaiSummit
810 = TownlongWastes
811 = ValeofEternalBlossoms
813 = NetherstormArena
816 = WellofEternity
819 = HourofTwilight
820 = EndTime
823 = DarkmoonFaireIsland
824 = DragonSoul
851 = DustwallowMarshScenario

--]]

-- Local

local Map = Nx.Map

--------
-- Map tables

Map.MapGenAreas = {	-- Auto gen by ConvertMapData()
	[122] = {
		11.52916601562, -- [1]
		-1714.166601562, -- [2]
		-979.5833007819999, -- [3]
		"boreantundra", -- [4]
	},
	[31] = {
		12.92916601564, -- [1]
		-603.3333007819999, -- [2]
		-1644.583203126, -- [3]
		"darkshore", -- [4]
	},
	[125] = {
		11.21666625976, -- [1]
		-725.41665039, -- [2]
		-1115, -- [3]
		"dragonblight", -- [4]
	},
	[126] = {
		10.49999975586, -- [1]
		222.083325196, -- [2]
		-1103.333300782, -- [3]
		"grizzlyhills", -- [4]
	},
	[32] = {
		3.07916674804, -- [1]
		-637.5, -- [2]
		-2092.91660156, -- [3]
		"darnassus", -- [4]
	},
	[128] = {
		12.541666625976, -- [1]
		-1088.75, -- [2]
		-1885.416601562, -- [3]
		"icecrownglacier", -- [4]
	},
	[33] = {
		4.999999877923999, -- [1]
		166.6666625976, -- [2]
		1973.333203126, -- [3]
		"deadwindpass", -- [4]
	},
	[132] = {
		9.987500000000001, -- [1]
		120, -- [2]
		-1533.749902344, -- [3]
		"zuldrak", -- [4]
	},
	[35] = {
		8.99166601562, -- [1]
		-846.666601562, -- [2]
		-90.4166625976, -- [3]
		"desolace", -- [4]
	},
	[37] = {
		9.795833007819999, -- [1]
		-427.5, -- [2]
		788.3333007819999, -- [3]
		"dunmorogh", -- [4]
	},
	[38] = {
		10.57499926758, -- [1]
		392.499975586, -- [2]
		-361.66665039, -- [3]
		"durotar", -- [4]
	},
	[39] = {
		5.399999877936, -- [1]
		-166.6666625976, -- [2]
		1943.333203126, -- [3]
		"duskwood", -- [4]
	},
	[10] = {
		11.02916699218, -- [1]
		674.5833007819999, -- [2]
		-1076.25, -- [3]
		"aszhara", -- [4]
	},
	[40] = {
		10.5, -- [1]
		195, -- [2]
		406.666796876, -- [3]
		"dustwallow", -- [4]
	},
	[41] = {
		8.0625, -- [1]
		457.5, -- [2]
		-740.8333007819999, -- [3]
		"easternplaguelands", -- [4]
	},
	[164] = {
		2.704166381844, -- [1]
		-425.833300782, -- [2]
		1546.249902344, -- [3]
		"kezan", -- [4]
	},
	[42] = {
		6.94166650392, -- [1]
		-307.083325196, -- [2]
		1587.916601562, -- [3]
		"elwynn", -- [4]
	},
	[168] = {
		5.60416601562, -- [1]
		-1014.166601562, -- [2]
		803.749951172, -- [3]
		"vashjirkelpforest", -- [4]
	},
	[43] = {
		9.85, -- [1]
		897.5, -- [2]
		-2208.33320312, -- [3]
		"eversongwoods", -- [4]
	},
	[11] = {
		8.1416660156, -- [1]
		2100, -- [2]
		558.75, -- [3]
		"azuremystisle", -- [4]
	},
	[174] = {
		10.19999975586, -- [1]
		-610.41665039, -- [2]
		-559.16665039, -- [3]
		"deepholm", -- [4]
	},
	[45] = {
		12.12499926758, -- [1]
		-359.583325196, -- [2]
		-1447.499902344, -- [3]
		"felwood", -- [4]
	},
	[180] = {
		10.54166601562, -- [1]
		487.5, -- [2]
		431.25, -- [3]
		"twilighthighlands_terrain1", -- [4]
	},
	[46] = {
		13.89999951172, -- [1]
		-1088.333300782, -- [2]
		473.333300782, -- [3]
		"feralas", -- [4]
	},
	[47] = {
		6.600000000000001, -- [1]
		1056.666601562, -- [2]
		-1653.333203126, -- [3]
		"ghostlands", -- [4]
	},
	[12] = {
		6.14166650392, -- [1]
		380.41665039, -- [2]
		1170.833300782, -- [3]
		"badlands", -- [4]
	},
	[206] = {
		3.6375, -- [1]
		2562.91640626, -- [2]
		720.833203124, -- [3]
		"ammenvalestart", -- [4]
	},
	[208] = {
		3.6125, -- [1]
		898.3332031260001, -- [2]
		105, -- [3]
		"echoislesstart", -- [4]
	},
	[210] = {
		2.700000000000001, -- [1]
		728.3332031259999, -- [2]
		-0, -- [3]
		"valleyoftrialsstart", -- [4]
	},
	[212] = {
		2.17916796876, -- [1]
		-429.583398438, -- [2]
		-454.166601562, -- [3]
		"deathknellstart", -- [4]
	},
	[214] = {
		1.9375, -- [1]
		-37.5, -- [2]
		1714.16640625, -- [3]
		"northshire", -- [4]
	},
	[55] = {
		10.32916601562, -- [1]
		-1107.916601562, -- [2]
		-296.25, -- [3]
		"hellfire", -- [4]
	},
	[56] = {
		9.724999755860001, -- [1]
		-369.999975586, -- [2]
		-296.25, -- [3]
		"hillsbradfoothills", -- [4]
	},
	[57] = {
		1.581250122062, -- [1]
		142.7182739258, -- [2]
		913.8482421880001, -- [3]
		"ironforge", -- [4]
	},
	[211] = {
		1.929166015626,
		-195.8333984376,
		1192.5,
		"coldridgevalley",
	},	
	[213] = {
		3.7, -- [1]
		-241.25, -- [2]
		945.416796876, -- [3]
		"newtinkertownstart", -- [4]
	},
	[215] = {
		3.2, -- [1]
		1076.666796876, -- [2]
		-2166.66660156, -- [3]
		"sunstriderislestart", -- [4]
	},
	[59] = {
		5.51666625976, -- [1]
		398.749975586, -- [2]
		897.5, -- [3]
		"lochmodan", -- [4]
	},
	[207] = {
		3.53333593751, -- [1]
		-46.666796875, -- [2]
		515.416796876, -- [3]
		"campnarachestart", -- [4]
	},
	[209] = {
		2.90000195313, -- [1]
		-298.333398438, -- [2]
		-2206.66660156, -- [3]
		"shadowglenstart", -- [4]
	},
	[146] = {
		6.325, -- [1]
		809.5833007819999, -- [2]
		-617.5, -- [3]
		"scarletenclave", -- [4]
	},
	[199] = {
		2.379166625976, -- [1]
		-186.6666625976, -- [2]
		-340.41665039, -- [3]
		"moltenfront", -- [4]
	},
	[197] = {
		8.099999664314, -- [1]
		-778.3333007819999, -- [2]
		1606.666601562, -- [3]
		"ahnqirajthefallenkingdom", -- [4]
	},
	[62] = {
		4.6166665039, -- [1]
		276.25, -- [2]
		-1698.333203126, -- [3]
		"moonglade", -- [4]
	},
	[166] = {
		14.825, -- [1]
		-271.25, -- [2]
		-40.8333312988, -- [3]
		"southernbarrens", -- [4]
	},
	[63] = {
		10.89999951172, -- [1]
		-440.833300782, -- [2]
		33.75, -- [3]
		"mulgore", -- [4]
	},
	[169] = {
		1.7791665039, -- [1]
		-386.66665039, -- [2]
		261.25, -- [3]
		"gilneascity", -- [4]
	},
	[64] = {
		11.04999999998, -- [1]
		-2059.16660156, -- [2]
		-8.333332824699999, -- [3]
		"nagrand", -- [4]
	},
	[129] = {
		8.7125, -- [1]
		-1385.833300782, -- [2]
		-1457.499902344, -- [3]
		"sholazarbasin", -- [4]
	},
	[66] = {
		11.149999343867, -- [1]
		-1096.666601562, -- [2]
		-1091.25, -- [3]
		"netherstorm", -- [4]
	},
	[182] = {
		3.675, -- [1]
		-482.5, -- [2]
		-75.4166625976, -- [3]
		"tolbaraddailyarea", -- [4]
	},
	[68] = {
		3.47875, -- [1]
		701.2708007819999, -- [2]
		-497.33334961, -- [3]
		"orgrimmar", -- [4]
	},
	[170] = {
		13.89166552736, -- [1]
		-1750.833203126, -- [2]
		744.16665039, -- [3]
		"vashjir", -- [4]
	},
	[179] = {
		13.10416601562, -- [1]
		-595.41665039, -- [2]
		2192.91660156, -- [3]
		"stranglethornvale", -- [4]
	},
	[178] = {
		1.7791665039, -- [1]
		-386.66665039, -- [2]
		261.25, -- [3]
		"ruinsofgilneascity", -- [4]
	},
	[72] = {
		5.13749975586, -- [1]
		295.833325196, -- [2]
		1702.916601562, -- [3]
		"redridge", -- [4]
	},
	[177] = {
		6.2916665039, -- [1]
		-687.91665039, -- [2]
		106.6666625976, -- [3]
		"ruinsofgilneas", -- [4]
	},
	[175] = {
		7.89166625976, -- [1]
		-421.66665039, -- [2]
		2503.33320312, -- [3]
		"thecapeofstranglethorn", -- [4]
	},
	[19] = {
		10.84999951172, -- [1]
		-1769.166601562, -- [2]
		-881.666601562, -- [3]
		"bladesedgemountains", -- [4]
	},
	[76] = {
		4.462499694831999, -- [1]
		64.58333129880001, -- [2]
		1220, -- [3]
		"searinggorge", -- [4]
	},
	[172] = {
		9.699999267579999, -- [1]
		-1336.249902344, -- [2]
		951.25, -- [3]
		"vashjirruins", -- [4]
	},
	[78] = {
		11, -- [1]
		-845, -- [2]
		389.583325196, -- [3]
		"shadowmoonvalley", -- [4]
	},
	[79] = {
		2.6125, -- [1]
		-1227.051757812, -- [2]
		294.790893554, -- [3]
		"shattrathcity", -- [4]
	},
	[80] = {
		8.116666503899999, -- [1]
		-596.66665039, -- [2]
		1174.583300782, -- [3]
		"silithus", -- [4]
	},
	[81] = {
		2.42291699218, -- [1]
		1280.15, -- [2]
		-2030.74179688, -- [3]
		"silvermooncity", -- [4]
	},
	[82] = {
		8.399999511719999, -- [1]
		-689.999951172, -- [2]
		-333.333325196, -- [3]
		"silverpine", -- [4]
	},
	[83] = {
		11.79999975586, -- [1]
		-780.41665039, -- [2]
		-680.8333007819999, -- [3]
		"stonetalonmountains", -- [4]
	},
	[84] = {
		3.4749999179908, -- [1]
		-344.583325196, -- [2]
		1599.166601562, -- [3]
		"stormwindcity", -- [4]
	},
	[85] = {
		8.19999975586, -- [1]
		-348.749975586, -- [2]
		2203.33320312, -- [3]
		"stranglethornjungle", -- [4]
	},
	[171] = {
		8.150000000000002, -- [1]
		-1646.666601562, -- [2]
		981.25, -- [3]
		"vashjirdepths", -- [4]
	},
	[22] = {
		6.304166381844, -- [1]
		92.9166625976, -- [2]
		1397.083300782, -- [3]
		"burningsteppes", -- [4]
	},
	[88] = {
		5.016666015619999, -- [1]
		416.25, -- [2]
		1907.083203126, -- [3]
		"swampofsorrows", -- [4]
	},
	[89] = {
		14.4249990310694, -- [1]
		12.49999923706, -- [2]
		1154.166601562, -- [3]
		"tanaris", -- [4]
	},
	[90] = {
		11.74999951172, -- [1]
		-847.0833007819999, -- [2]
		-2369.58320312, -- [3]
		"teldrassil", -- [4]
	},
	[181] = {
		4.02916658497544, -- [1]
		-402.083325196, -- [2]
		112.0833251954, -- [3]
		"tolbarad", -- [4]
	},
	[183] = {
		12.38749951172, -- [1]
		-488.333300782, -- [2]
		1605.833300782, -- [3]
		"uldum_terrain1", -- [4]
	},
	[185] = {
		3.1, -- [1]
		-311.25, -- [2]
		-274.16665039, -- [3]
		"themaelstrom", -- [4]
	},
	[165] = {
		8.491666748046001, -- [1]
		185.8333251954, -- [2]
		-1239.166601562, -- [3]
		"hyjal_terrain1", -- [4]
	},
	[163] = {
		9.02916601562, -- [1]
		-876.666601562, -- [2]
		-576.25, -- [3]
		"thelostisles_terrain2", -- [4]
	},
	[96] = {
		10.79999951172, -- [1]
		-1416.666601562, -- [2]
		199.999987793, -- [3]
		"terokkarforest", -- [4]
	},
	[97] = {
		11.491666656494, -- [1]
		-40.4166656494, -- [2]
		-362.083325196, -- [3]
		"barrens", -- [4]
	},
	[150] = {
		7.354166259774, -- [1]
		-559.5833007819999, -- [2]
		-2156.25, -- [3]
		"hrothgarslanding", -- [4]
	},
	[99] = {
		2.1135410156, -- [1]
		2213.2734375, -- [2]
		721.936669922, -- [3]
		"theexodar", -- [4]
	},
	[100] = {
		7.7, -- [1]
		315, -- [2]
		-293.333325196, -- [3]
		"hinterlands", -- [4]
	},
	[161] = {
		6.2916665039, -- [1]
		-687.91665039, -- [2]
		106.6666625976, -- [3]
		"gilneas_terrain2", -- [4]
	},
	[123] = {
		5.44583325196, -- [1]
		-288.75, -- [2]
		-1300.416601562, -- [3]
		"crystalsongforest", -- [4]
	},
	[103] = {
		8.799999389643999, -- [1]
		86.6666625976, -- [2]
		793.3333007819999, -- [3]
		"thousandneedles", -- [4]
	},
	[104] = {
		2.08749987793, -- [1]
		-103.3333251954, -- [2]
		169.999987793, -- [3]
		"thunderbluff", -- [4]
	},
	[105] = {
		9.037499755860001, -- [1]
		-606.66665039, -- [2]
		-767.499951172, -- [3]
		"tirisfal", -- [4]
	},
	[211] = {
		1.929166015626, -- [1]
		-195.8333984376, -- [2]
		1192.5, -- [3]
		"coldridgevalley", -- [4]
	},
	[107] = {
		7.399999633796, -- [1]
		-106.6666625976, -- [2]
		1193.333300782, -- [3]
		"ungorocrater", -- [4]
	},
	[108] = {
		1.918750061035, -- [1]
		-174.6385253906, -- [2]
		-375.5890625, -- [3]
		"undercity", -- [4]
	},
	[131] = {
		5.94999975586, -- [1]
		-865.8333007819999, -- [2]
		-1143.333300782, -- [3]
		"lakewintergrasp", -- [4]
	},
	[127] = {
		12.09166577148, -- [1]
		279.583325196, -- [2]
		-623.3333007819999, -- [3]
		"howlingfjord", -- [4]
	},
	[111] = {
		8.599999816887999, -- [1]
		-83.33333129880001, -- [2]
		-673.3333007819999, -- [3]
		"westernplaguelands", -- [4]
	},
	[112] = {
		6.999999633796, -- [1]
		-603.3333007819999, -- [2]
		1880, -- [3]
		"westfall", -- [4]
	},
	[113] = {
		8.270833374023999, -- [1]
		77.9166625976, -- [2]
		429.583300782, -- [3]
		"wetlands", -- [4]
	},
	[114] = {
		12.299999755866, -- [1]
		198.3333251954, -- [2]
		-1758.75, -- [3]
		"winterspring", -- [4]
	},
	[115] = {
		10.05416699218, -- [1]
		-1895, -- [2]
		-387.083325196, -- [3]
		"zangarmarsh", -- [4]
	},
	[130] = {
		14.22499926758, -- [1]
		-368.333325196, -- [2]
		-2039.58320312, -- [3]
		"thestormpeaks", -- [4]
	},
	[4] = {
		6.95416650392, -- [1]
		225.41665039, -- [2]
		28.3333312988, -- [3]
		"arathi", -- [4]
	},
	[5] = {
		11.53333276368, -- [1]
		-339.999975586, -- [2]
		-934.5833007819999, -- [3]
		"ashenvale", -- [4]
	},
	[119] = {
		6.654166015640001, -- [1]
		1060.416601562, -- [2]
		-2713.74980468, -- [3]
		"sunwell", -- [4]
	},
	[20] = {
		7.325, -- [1]
		238.75, -- [2]
		2116.66660156, -- [3]
		"blastedlands", -- [4]
	},
	[21] = {
		6.5249980468, -- [1]
		2015, -- [2]
		151.6666625976, -- [3]
		"bloodmystisle", -- [4]
	},
}

Map.MapInfo = {
	[0] = {	-- Dummy
		Name = "Instance",
		X = 0,
		Y = 0,
	},
	{
		Name = "Kalimdor",
		FileName = "Kalimdor",
		X = -1800,	-- Was 0
		Y = 200,
		Min = 1001,
		Max = 1033,
	},
	{
		Name = "Eastern Kingdoms",
		FileName = "Azeroth",
		X = 5884,	-- Was 3784
		Y = -200,
		Min = 2001,
		Max = 2048,
	},
	{
		Name = "Outland",
		FileName = "Expansion01",
		X = 7000,
		Y = -4000,
		Min = 3001,
		Max = 3008,
	},
	{
		Name = "Northrend",
		FileName = "Northrend",
		X = 600,
		Y = -4500,
		Min = 4001,
		Max = 4014,
	},
	{
		Name = "The Maelstrom",
		FileName = "TheMaelstromContinent",
		X = 1100,
		Y = -1800, 
		Min = 5001,
		Max = 5005,
	},
	[6] = {
	    Name = "Pandaria",
		FileName = "Pandaria",
		X = 2350,
		Y = 300,
		Min = 6001,
		Max = 6016,
	},
	[8] = {
		Name = "Instance",
		X = 2000,
		Y = 100,
	},
	[9] = {
		Name = "BG",
		X = 2000,
		Y = 200,
	},
}

Map.BloodelfXO = -503
Map.BloodelfYO = 516
Map.DraeneiXO = -3500
Map.DraeneiYO = -2010

Map.MapWorldInfo = {

	-- Dummy if we get a zero on startup
	[0] = {
		10,
		0, 0,
		0, 0,  -- Index 4,5 XY world position created for zones in continents 1-5, 9
		Overlay = "barrens",
	},

	[1000] = {
		73.3282, -- Scale
		-3398.85, -2552.91, -- Origin
	},
	[1001] = {
		Name = "Ashenvale",
		Fish = 150,
		QAchievementId = 4925,
		QAchievementIdH = 4976,
	},
	[1002] = {
		Name = "Azshara",
		Fish = 300,
		QAchievementIdH = 4927,
	},
	[1003] = {
		Name = "Azuremyst Isle",
		XOff = Map.DraeneiXO,
		YOff = Map.DraeneiYO,
		MId = 1003,
		Fish = 25,
	},
	[1004] = {
		Name = "Bloodmyst Isle",
		XOff = Map.DraeneiXO,
		YOff = Map.DraeneiYO,
		MId = 1003,
		Fish = 75,
		QAchievementIdA = 4926,
	},
	[1005] = {
		Name = "Darkshore",
		Fish = 75,
		QAchievementIdA = 4928,
	},
	[1006] = {
		Name = "Darnassus",
		2.116669, -- Scale (0.6668302)
		-587.6726, -2047.663, -- Origin (WH 211.6669, 141.1459)
		 -- -2012.279 -9985.129, 87.5039 35.8759
		 -- -2400.08 -9702.901, 50.8613 75.8668
		Overlay = "darnassis",
		City = true,
		MMOutside = true,
		Fish = 75,
	},
	[1007] = {
		Name = "Desolace",
		Fish = 225,
		QAchievementId = 4930,
	},
	[1008] = {
		Name = "Durotar",
		Fish = 25,
	},
	[1009] = {
		Name = "Dustwallow Marsh",
		Fish = 225,
		QAchievementId = 4929,
		QAchievementIdH = 4978,
	},
	[1010] = {
		Name = "Felwood",
		Fish = 300,
		QAchievementId = 4931,
	},
	[1011] = {
		Name = "Feralas",
		Fish = 300,
		QAchievementId = 4932,
		QAchievementIdH = 4979,
	},
	[1012] = {
		Name = "Moonglade",
		Fish = 300,
	},
	[1013] = {
		Name = "Mulgore",
		Fish = 25,
	},
	[1014] = {
		Name = "Orgrimmar",
		2.805208, -- Scale (0.6669141)
		736.1202, -454.7754, -- Origin (WH 280.5208, 187.0833)
		 -- 4362.793 -1397.708, 48.63751 93.66625
		 -- 4452.566 -1601.87, 55.03796 71.84045
		Overlay = "ogrimmar",
		City = true,
		MMOutside = true,
--		MId = 1014,
		Fish = 75,
	},
	[1015] = {
		Name = "Silithus",
		Fish = 425,
		QAchievementIdA = 4934,
	},
	[1016] = {
		Name = "Stonetalon Mountains",
		Fish = 150,
		QAchievementId = 4936,
		QAchievementIdH = 4980,
	},
	[1017] = {
		Name = "Tanaris",
		Fish = 300,
		QAchievementId = 4935,
	},
	[1018] = {
		Name = "Teldrassil",
		Fish = 25,
	},
	[1019] = {
		Name = "Northern Barrens",
		Fish = 75,
		QAchievementIdH = 4933,
	},
	[1020] = {
		Name = "The Exodar",
		XOff = Map.DraeneiXO,
		YOff = Map.DraeneiYO,
		City = true,
		MId = 1003,
	},
	[1021] = {
		Name = "Thousand Needles",
		Fish = 225,
		QAchievementId = 4938,
	},
	[1022] = {
		Name = "Thunder Bluff",
		2.087504, -- Scale (0.666666)
		-103.3333, 170, -- Origin (WH 208.7504, 139.1668)
		 -- -288.8936 975.1409, 21.8225 17.9843
		 -- -134.5071 1215.782, 36.614 52.5675
		 -- -180.5793 1321.172, 32.1999 67.7133
		Overlay = "thunderbluff",
		City = true,
		MMOutside = true,
		Fish = 75,
	},
	[1023] = {
		Name = "Un'Goro Crater",
		Fish = 300,
		QAchievementId = 4939,
	},
	[1024] = {
		Name = "Winterspring",
		Fish = 425,
		QAchievementId = 4940,
	},

	-- Cataclysm

	[1025] = {
		Name = "Ahn'Qiraj: The Fallen Kingdom",
		Fish = 1,
	},
	[1026] = {
		Name = "Mount Hyjal",
		Fish = 1,
		QAchievementId = 4870,
	},
	[1027] = {
		Name = "Southern Barrens",
		Fish = 75,
		QAchievementId = 4937,
		QAchievementIdH = 4981,
	},
	[1028] = {
		Name = "Uldum",
		Fish = 75,
		QAchievementId = 4872,
	},

	-- Mists

	[1029] = {
		Name = "Ammen Vale",
		XOff = Map.DraeneiXO,
		YOff = Map.DraeneiYO,
		MId = 1003,
		StartZone = true,
	},
	[1030] = {
		Name = "Camp Narache",
		StartZone = true,
	},
	[1031] = {
		Name = "Echo Isles",
		StartZone = true,
	},
	[1032] = {
		Name = "Shadowglen",
		StartZone = true,
	},
	[1033] = {
		Name = "Valley of Trials",
		StartZone = true,
	},

	[2000] = {
		81.53, -- Scale
		-3645.96, -2249.31, -- Origin
	},
	[2001] = {	-- Merged into Hillsbrad Foothills for Cataclysm
		Name = "Alterac Mountains",
		5.599993, -- Scale (0.6666676)
		-156.6661, -299.9998, -- Origin (WH 559.9993, 373.3334)
		 -- 599.2264 -222.7941, 49.3771 68.4217
		 -- 830.212 -798.6328, 57.6266 37.5732
		Overlay = "alterac",
		Fish = 225,
	},
	[2002] = {
		Name = "Arathi Highlands",
		Fish = 225,
		QAchievementId = 4896,
	},
	[2003] = {
		Name = "Badlands",
		QAchievementId = 4900,
	},
	[2004] = {
		Name = "Blasted Lands",
		QAchievementId = 4909,
	},
	[2005] = {
		Name = "Burning Steppes",
		Fish = 425,
		QAchievementId = 4901,
	},
	[2006] = {
		Name = "Deadwind Pass",
		Fish = 425,
	},
	[2007] = {
		Name = "Dun Morogh",
		Fish = 25,
	},
	[2008] = {
		Name = "Duskwood",
		Fish = 150,
		QAchievementIdA = 4907,
	},
	[2009] = {
		Name = "Eastern Plaguelands",
		Fish = 425,
		QAchievementId = 4892,
	},
	[2010] = {
		Name = "Elwynn Forest",
		Fish = 25,
	},
	[2011] = {
		Name = "Eversong Woods",
		XOff = Map.BloodelfXO,
		YOff = Map.BloodelfYO,
		MId = 2011,
		Fish = 25,
	},
	[2012] = {
		Name = "Ghostlands",
		XOff = Map.BloodelfXO,
		YOff = Map.BloodelfYO,
		MId = 2011,
		Fish = 75,
		QAchievementIdH = 4908,
	},
	[2013] = {
		Name = "Hillsbrad Foothills",
		Fish = 150,
		QAchievementIdH = 4895,
	},
	[2014] = {
		Name = "Ironforge",
		1.581249, -- Scale (0.6673273)
		142.7185, 913.8483, -- Origin (WH 158.1249, 105.521)
		 -- 1168.239 4834.522, 57.5047 50.2803
		 -- 1002.861 4949.052, 36.5874 71.9877
		 -- 953.4069 4990.946, 30.3323 79.9281
		Overlay = "ironforge",
		City = true,
		Fish = 75,
	},
	[2015] = {
		Name = "Loch Modan",
		Fish = 75,
		QAchievementIdA = 4899,
	},
	[2016] = {
		Name = "Redridge Mountains",
		Fish = 150,
		QAchievementIdA = 4902,
	},
	[2017] = {
		Name = "Searing Gorge",
		QAchievementId = 4910,
	},
	[2018] = {
		Name = "Silvermoon City",
		XOff = Map.BloodelfXO,
		YOff = Map.BloodelfYO,
		City = true,
		MId = 2011,
	},
	[2019] = {
		Name = "Silverpine Forest",
		Fish = 75,
		QAchievementIdH = 4894,
	},
	[2020] = {
		Name = "Stormwind City",
		City = true,
		MMOutside = true,
		Fish = 75,
	},
	[2021] = {
		Name = "Northern Stranglethorn",
--		Name = "Stranglethorn Vale",
		Fish = 225,
		QAchievementId = 4906,
	},
	[2022] = {
		Name = "Swamp of Sorrows",
		Fish = 225,
		QAchievementId = 4904,
	},
	[2023] = {
		Name = "The Hinterlands",
		Fish = 300,
		QAchievementId = 4897,
	},
	-- Tirisfal Glades
	[2024] = {
		Name = "Tirisfal Glades",
		Fish = 25,
	},
	-- Undercity
	[2025] = {
		Name = "Undercity", -- [26]
		1.9187478, -- Scale (0.6672102)
		-174.6383, -375.589, -- Origin (WH 191.8748, 128.0208)
		 -- -246.8386 -1631.841, 65.2877 38.4475
		 -- -241.8082 -1783.917, 65.812 14.6895
		 -- -343.3792 -1804.086, 55.2248 11.5385
		 -- -239.2218 -1836.685, 66.0816 6.4458
		Overlay = "undercity",
		City = true,
		Fish = 75,
	},
	[2026] = {
		Name = "Western Plaguelands",
		Fish = 300,
		QAchievementId = 4893,
	},
	[2027] = {
		Name = "Westfall",
		Fish = 75,
		QAchievementIdA = 4903,
	},
	[2028] = {
		Name = "Wetlands",
		Fish = 150,
		QAchievementIdA = 4898,
	},
	[2029] = {
		Name = "Isle of Quel'Danas",
		XOff = Map.BloodelfXO,
		YOff = Map.BloodelfYO,
		MId = 2011,
		Fish = 450,
	},
	[2030] = {
		Name = "Plaguelands: The Scarlet Enclave",
		XOff = 400,
		YOff = -33,
		City = true,	-- No explored areas
	},

-- Cataclysm

	[2031] = {
		Name = "Abyssal Depths",
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
	},
	[2032] = {
		Name = "Kelp'thar Forest",
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
	},
	[2033] = {
		Name = "Ruins of Gilneas",
		Fish = 75,
		Explored = true,
	},
	[2034] = {
		Name = "Ruins of Gilneas City",
		Fish = 75,
		City = true,	-- No explored areas
	},
	[2035] = {
		Name = "Shimmering Expanse",
		Fish = 75,
		QAchievementId = 4869,
		QAchievementIdH = 4982,
	},
	[2036] = {
		Name = "Stranglethorn Vale",	-- Fake parent map?
		Fish = 75,
	},
	[2037] = {
		Name = "The Cape of Stranglethorn",
		Fish = 75,
		QAchievementId = 4905,
	},
	[2038] = {
		Name = "Tol Barad",
		XOff = -600,
		YOff = 320,
		MId = 2038,
		Fish = 75,
		Explored = true,
	},
	[2039] = {
		Name = "Tol Barad Peninsula",
		XOff = -600,
		YOff = 320,
		MId = 2038,
		Fish = 75,
		Explored = true,
	},
	[2040] = {
		Name = "Twilight Highlands",
		Fish = 75,
		QAchievementId = 4873,
		QAchievementIdH = 5501,
	},
	[2041] = {	-- Need??? Sub continent
		Name = "Vashj'ir",
		Fish = 75,
	},
	[2042] = {
		Name = "Gilneas",
	},
	[2043] = {
		Name = "Gilneas City",
		City = true,			-- No explored areas
		MMOutside = true,
	},

	-- Mists

	[2044] = {
		Name = "Coldridge Valley",
		StartZone = true,
	},
	[2045] = {
		Name = "Deathknell",
		StartZone = true,
	},
	[2046] = {
		Name = "New Tinkertown",
		StartZone = true,
	},
	[2047] = {
		Name = "Northshire",
		StartZone = true,
	},
	[2048] = {
		Name = "Sunstrider Isle",
		XOff = Map.BloodelfXO,
		YOff = Map.BloodelfYO,
		MId = 2011,
		StartZone = true,
	},


	[3000] = {
		34.606,				-- Scale
		-2587.3, -1151.7,	-- Origin
	},
	[3001] = {
		Name = "Blade's Edge Mountains", -- [1]
		10.85003, -- Scale (0.666667)
		-1769.168, -881.6678, -- Origin (WH 1085.003, 723.3356)
		 -- -5982.262 -2399.672, 52.7847 55.539
		 -- -4709.442 -2041.002, 76.2468 65.4561
		 -- -4603.104 -2096.445, 78.2069 63.9231
		Overlay = "bladesedgemountains",
		QAchievementId = 1193,
	},
	[3002] = {
		Name = "Hellfire Peninsula", -- [2]
		10.32915, -- Scale (0.6668043)
		-1107.916, -296.2509, -- Origin (WH 1032.916, 688.7525)
		 -- -4976.093 697.7343, 10.9106 63.2735
		 -- -4605.781 414.6589, 18.0808 55.0536
		 -- -5056.561 188.3606, 9.3525 48.4823
		Overlay = "hellfire",
		Fish = 375,
		QAchievementId = 1189,
		QAchievementIdH = 1271,
	},
	[3003] = {
		Name = "Nagrand", -- [3]
		11.05005, -- Scale (0.6666639)
		-2059.17, -8.333105, -- Origin (WH 1105.005, 736.6674)
		 -- -6137.744 1568.903, 75.2595 43.7258
		 -- -6389.304 1749.084, 70.7064 48.6176
		 -- -6336.4 1318.156, 71.6639 36.9182
		 -- -6297.564 1158.649, 72.3668 32.5877
		Overlay = "nagrand",
		Fish = 475,
		QAchievementId = 1192,
		QAchievementIdH = 1273,
	},
	[3004] = {
		Name = "Netherstorm", -- [4]
		11.14996, -- Scale (0.6666698)
		-1096.665, -1091.25, -- Origin (WH 1114.996, 743.3344)
		 -- -4413.899 -2483.77, 19.1826 79.977
		 -- -3666.211 -3010.165, 32.5941 65.8139
		Overlay = "netherstorm",
		Fish = 475,
		QAchievementId = 1194,
	},
	--!
	[3005] = {
		Name = "Shadowmoon Valley", -- [5]
		11, -- Scale (0.6666666)
		-845.0001, 389.5833, -- Origin (WH 1100, 733.3334)
		 -- -3265.336 3224.464, 17.44844 34.81494
		 -- -2685.753 2841.652, 27.9863 24.3746
		Overlay = "shadowmoonvalley",
		Fish = 375,
		QAchievementId = 1195,
	},
	-- Shattrath City
	--!
	[3006] = {
		Name = "Shattrath City", -- [6]
		2.6125, -- Scale (0.6666668)
		-1227.052, 294.7909, -- Origin (WH 261.25, 174.1667)
		 -- -5785.705 1864.776, 26.76009 44.87901
		 -- -5098.179 1620.727, 79.39369 16.85428
		Overlay = "shattrathcity",
		City = true,
		MMOutside = true,
	},
	--!
	[3007] = {
		Name = "Terokkar Forest", -- [7]
		10.8, -- Scale (0.6666667)
		-1416.667, 200, -- Origin (WH 1080, 720)
		 -- -3295.501 3248.513, 70.14504 62.45869
		 -- -5076.772 1600.578, 37.15854 16.68273
		Overlay = "terokkarforest",
		Fish = 450,
		QAchievementId = 1191,
		QAchievementIdH = 1272,
	},
	[3008] = {
		Name = "Zangarmarsh", -- [8]
		10.05418, -- Scale (0.6668039)
		-1895, -387.0831, -- Origin (WH 1005.418, 670.4165)
		 -- -6286.6 1113.615, 63.4244 90.9593
		 -- -5236.717 810.7363, 84.3089 81.9237
		 -- -5265.634 100.2874, 83.7337 60.7295
		Overlay = "zangarmarsh",
		Fish = 400,
		QAchievementId = 1190,
	},

	[4000] = {
		35.5,		-- Scale
		0, 0,		-- Origin
	},
	[4001] = {
		Name = "Borean Tundra", -- [1]
		11.521,
		125.764810, 1139.054323, -- Origin (WH 1085.003, 723.3356)
		Overlay = "boreantundra",
		Fish = 475,
		QAchievementId = 33,
		QAchievementIdH = 1358,
	},
	[4002] = {
		Name = "Crystalsong Forest", -- [2]
		5.4416,
		1550.386409, 817.907816,
		Overlay = "crystalsongforest",
		Fish = 500,
	},
	[4003] = {	-- Main level
		Name = "Dalaran", -- [3]
		1.6589 / 1.3,
		1629, 861,		--		1580, 1739,
		Overlay = "dalaran",
		MapBaseName = "dalaran1_",
--		NoBackground = true,
		City = true,
		Alpha = .85,
		ScaleAdjust = 1.3,
		Fish = 525,
		MapLevel = 1,
		Level2Id = 4014,
	},
	[4014] = {	-- Level 2 (was id 4012)
		Name = "Dalaran Underbelly", -- [3]
		1.6589 / 1.3,
		1629, 861,		--		1580, 1739,
		Overlay = "dalaran",
		MapBaseName = "dalaran2_",
		City = true,
		Alpha = .85,
		ScaleAdjust = 1.3,
		Fish = 525,
		MapLevel = 2,
		Level1Id = 4003,
	},
	[4004] = {
		Name = "Dragonblight", -- [4]
		11.21,
		1113.94, 1003.78, -- Origin (WH 1085.003, 723.3356)
		Overlay = "dragonblight",
		Fish = 475,
		QAchievementId = 35,
		QAchievementIdH = 1359,
	},
	[4005] = {
		Name = "Grizzly Hills", -- [5]
		10.5,
		2061.032452, 1015.273026, -- Origin (WH 1085.003, 723.3356)
		Overlay = "grizzlyhills",
		Fish = 475,
		QAchievementId = 37,
		QAchievementIdH = 1357,
	},
	[4006] = {
		Name = "Howling Fjord", -- [6]
		12.085,
		2119.306683, 1495.527721, -- Origin (WH 1085.003, 723.3356)
		Overlay = "howlingfjord",
		Fish = 475,
		QAchievementId = 34,
		QAchievementIdH = 1356,
	},
	[4007] = {
		Name = "Icecrown", -- [7]
		12.533,
		750.941881, 233.475172, -- Origin (WH 1085.003, 723.3356)
		Overlay = "icecrownglacier",
		QAchievementId = 40,
	},
	[4008] = {
		Name = "Sholazar Basin", -- [8]
		8.7057,
		453.792401, 661.305837,
		Overlay = "sholazarbasin",
		Fish = 525,
		QAchievementId = 39,
	},
	[4009] = {
		Name = "The Storm Peaks", -- [9]
		14.214,
		1471.175866, 79.244441, -- Origin (WH 1085.003, 723.3356)
		Overlay = "thestormpeaks",
		QAchievementId = 38,
	},
	[4010] = {
		Name = "Wintergrasp", -- [10]
		5.9455,
		973.388866, 975.227557,
		Overlay = "lakewintergrasp",
		Explored = true,
	},
	[4011] = {
		Name = "Zul'Drak", -- [11]
		9.98,
		1959.324066, 584.635173, -- Origin (WH 1085.003, 723.3356)
		Overlay = "zuldrak",
		QAchievementId = 36,
	},
	[4012] = {	-- Patch 4.2 (AID 795)
		Name = "Molten Front",
		2.38,
		1000, 2500,
		MId = 4012,
		UseAId = true,
--		City = true,
		Overlay = "moltenfront",
		Explored = true,
	},
	[4013] = {
		Name = "Hrothgar's Landing",
		7.35,
		1280, -37.5,
		Overlay = "hrothgarslanding",
		Explored = true,
	},
--	[4014]	Used by Dalaran sewers!

	-- Lost Isles (Cataclysm)
	[5000] = {
		26,		-- Scale
		0, 0,		-- Origin
	},
	[5001] = {
		Name = "Deepholm",
		XOff = 1580,
		YOff = 700,
		QAchievementId = 4871,
		MId = 5001,
	},
	[5002] = {
		Name = "Kezan",
		XOff = 1256,
		YOff = -542,
		MId = 5002,
	},
	[5003] = {
		Name = "The Lost Isles",
		XOff = 750,
		YOff = 1150,
	},
	[5004] = {
		Name = "The Maelstrom",
		XOff = 1000,
		YOff = 600,
		City = true,
		Explored = true,
	},	
    [5005] = { 
	    Name = "Darkmoon Island",
		3.8,
		-300, -2750+2400,
		Explored = true,
		City = true,
		MMOutside = true,		
		UseAId=true,
		MId=5005,
		Overlay = "darkmoonfaireisland",
	},
	-- BGs/Arenas (note: add map win InitLayoutData when adding BGs)
    [6000] = {
		31.030601,
		-1756.42, 595.44,
	},
	[6001] = {
		Name="Dread Wastes",
		10.704166,
		-1234.27, 1648.84,
		Overlay = "dreadwastes",
		Fish = 525,
	},
	[6002] = {
		Name="Krasarang Wilds",
		9.375002,
		-595.94, 1954.25,
		Overlay = "krasarang",
		Fish = 525,
	},
	[6003] = {
		Name="Kun-Lai Summit",
		12.516666,
		-974.27, 808.42,
		Overlay = "kunlaisummit",
		Fish = 525,
	},
	[6004] = { 
		Name = "Shrine of Seven Stars",	
		0.55, 
		-82, 1751, 
		ScaleAdjust=0.9469, 
		City = true, 
		Level2Id = 6005,
	}, 
    [6005] = {
		Name = "Shrine of Seven Stars L2", 
		0.55,
		-82, 1751, 
		ScaleAdjust=1.14356, 
		City = true, 
		Level1Id = 6004,
	},
    [6006] = {
		Name="The Jade Forest",
		13.966666,
		-296.77,1201.75,
		Overlay = "thejadeforest",
		Fish = 525,
	},
	[6007] = {
		Name="The Veiled Stair",
		3.587500,
		-168.85,1594.25,
		Overlay = "thehiddenpass",
		Fish = 525,
	},
	[6008] = {
		Name="Townlong Steppes",
		11.487498,
		-1422.19,1020.50,
		Overlay = "townlongwastes",
		Fish = 525,
	},
	[6009] = {
		Name="Vale of Eternal Blossoms",
		5.066668,
		-502.60,1542.59,
		Overlay = "valeofeternalblossoms",
		Fish = 525,
	},
	[6010] = {
		Name="Valley of the Four Winds",
		7.850002,
		-542.19,1713.00,
		Overlay = "valleyofthefourwinds",
		Fish = 525,
	},
	[6011] = {
		Name="The Wandering Isle",
		5.341666015625,
		-500,-200,
		Overlay = "thewanderingisle",
		StartZone = true,
--		City = true,
		MMOutside = true,		
	},    
    [6012] = { 
		Name = "Shrine of Two Moons",	
		0.5,
		-217.8, 1573.5,
		Alpha=2,
		ScaleAdjust=0.87584,
		City = true,
		Level2Id = 6013,
	},
    [6013] = { 
		Name = "Shrine of Seven Stars",	
		0.5,
		-217.8, 1573.5,
		Alpha=2,	
		ScaleAdjust=1.03448,
		City = true, 
		Level1Id = 6012,
	},	
	[6014] = {
		Name = "Isle of Giants",
		3.575001968,
		-400.8334, 600.5832,
		Explored = true,
		Overlay = "isleofgiants",
	},
	[6015] = {
		Name = "Isle of Thunder",
		8.270832,
		-1535.8332, 514.5832,
		Explored = true,
		Overlay = "isleofthethunderking",
	},	
	[6016] = {
		Name = "Timeless Isle",
		4.8,
		810.2668,1885.6667968,
		Explored = true,
		Overlay = "timelessisle",
	},
	
	[9000] = {
		1,				-- Scale
		0, 0,			-- Origin
	},
	[9001] = {		-- AB
		Name = "Arathi Basin",
		3.508,		-- Scale
		-16000, 0,		-- Origin
		Short = "AB",
	},
	[9002] = {		-- WG
		Name = "Warsong Gulch",
		2.29,			-- Scale
		-16000,1000,	-- Origin
		Short = "WG",
	},
	[9003] = {		-- AV
		Name = "Alterac Valley",
		8.471,		-- Scale
		16000,2000,		-- Origin
		Short = "AV",
	},
	[9004] = {		-- EOS
		Name = "Eye of the Storm",
		4.538,		-- Scale
		-16000,3000,		-- Origin
		Short = "EOS",
	},
	[9005] = {		-- Blade's Edge Arena
		Name = "Blade's Edge Arena",
		1,
		-16000,4000,
		Short = "BEA",
		Arena = true
	},
	[9006] = {		-- Nagrand Arena
		Name = "Nagrand Arena",
		1,
		-16000,5000,
		Short = "NA",
		Arena = true
	},
	[9007] = {		-- Ruins of Lordaeron
		Name = "Ruins of Lordaeron",
		1,
		-16000,6000,
		Short = "RL",
		Arena = true
	},
	[9008] = {		-- SoA
		Name = "Strand of the Ancients",
		3.486,
		-14500,0,
		Short = "SoA",
	},
	[9009] = {		-- IC
		Name = "Isle of Conquest",
		5.295,
		-14500,1000,
		Short = "IC",
	},
	[9010] = {
		Name = "The Battle for Gilneas",
		3.0,
		-14500,2000,
		Short = "TBG",
	},
	[9011] = {
		Name = "Twin Peaks",
		3.0,
		-14500,3000,
		Short = "TP",
	},
    [9012] = {
		Name = "Temple of Kotmogu",
		3.0,
		-14500,4000,
		Short = "TK",
	},
	[9013] = {
		Name = "Silvershard Mines",
		8.0,
		-14500,5000,
		Short = "SSM",
		MapBaseName = "STVDiamondMineBG1_",
	},	
	[9014] = {
		Name = "Tol'vir Proving Grounds",
		3.0,
		-14500,6000,
		Short = "TPG",
		Arena = true
	},
	[9015] = {
		Name = "Deepwind Gorge",
		8.0,
		-13000,0,
		MapBaseName = "GoldRush",
		Short = "DG",
	},
	[9016] = {
		Name = "Tigers Peak Arena",
		1,
		-13000,1000,
		Short = "TPA",
		Arena = true,
	},
	-- Instances are created at 11000-14999 (cont * 1000 + 10000 + nxid)
	-- Manual adjustments are added here

	[11024] = {
		0,
		0, .02
	},
	[11025] = {
		0,
		0, .04
	},
	[11147] = {
		0,
		0, .06
	},
	[11201] = {
		0,
		.03, 0
	},
	[11202] = {
		0,
		.03, .02
	},
	[11203] = {
		0,
		.03, .04
	},
	[11204] = {
		0,
		.03, .06
	},
	[12017] = {
		0,
		0, .02
	},
	[12061] = {
		0,
		0, .04
	},
	[12189] = {
		0,
		.01, .07		-- Base coords off a little
	},
	[12190] = {
		0,
		.01, .09		-- Base coords off a little
	},
	[13027] = {
		0,
		.0, -.0
	},
	[13028] = {
		0,
		-.04, .0
	},
	[13029] = {
		0,
		-.02, .0
	},
	[13030] = {
		0,
		.02, .00
	},
}

--------

--Map.HotspotInfo = {
--}

--------
-- "Atlas\Images\Maps"

Map.AtlasInstanceInfo = {
--[[
	Atlas = 1,					-- Flag table as Atlas maps
	[13006] = {
		129 / 512, 386 / 512,		"AuchAuchenaiCrypts"
	},
	[13007] = {
		109 / 512, 44 / 512,		"AuchManaTombs",
	},
	[13008] = {
		458 / 512, 236 / 512,		"AuchSethekkHalls",
	},
	[13009] = {
		61 / 512, 77 / 512,		"AuchShadowLabyrinth", },
	[13013] = {
		104 / 512, 458 / 512,		"BlackTempleStart",
		104 / 512 - 1, 458 / 512,		"BlackTempleBasement",
		104 / 512, 458 / 512 + 1,		"BlackTempleTop",
	},
	[11014] = {
		171 / 512, 59 / 512,		"BlackfathomDeeps",
	},
	[12015] = {
		126 / 512, 420 / 512,		"BlackrockDepths",	},
	[12017] = {
		16 / 512, 71 / 512,		"BlackrockSpireLower",
		16 / 512, 71 / 512 + 1,		"BlackrockSpireUpper",
	},
	[12018] = {
		342 / 512, 361 / 512,		"BlackwingLair",
	},
	[11023] = {
		108 / 512, 252 / 512,		"CoTHyjal",
	},
	[11024] = {
		71 / 512, 206 / 512,		"CoTOldHillsbrad",
	},
	[11025] = {
		267 / 512, 135 / 512,		"CoTBlackMorass",
	},
	[13027] = {
		12 / 512, 339 / 512,		"CFRSerpentshrineCavern",
	},
	[13028] = {
		126 / 512, 119 / 512,		"CFRTheSlavePens",
	},
	[13029] = {
		14 / 512, 181 / 512,		"CFRTheSteamvault",
	},
	[13030] = {
		124 / 512, 341 / 512,		"CFRTheUnderbog",
	},
	[11036] = {
		385 / 512, 405 / 512,		"DireMaulNorth",
		385 / 512 + 1, 405 / 512,		"DireMaulWest",
		385 / 512 - 1, 405 / 512,		"DireMaulEast",
	},
	[12048] = {
		405 / 512, 73 / 512,		"Gnomeregan",
	},
	[13049] = {
		447 / 512, 364 / 512,	"GruulsLair",
	},
	[13051] = {
		213 / 512, 330 / 512,	"HCHellfireRamparts",
	},
	[13052] = {
		101 / 512, 81 / 512,		"HCMagtheridonsLair",
	},
	[13053] = {
		242 / 512, 473 / 512,	"HCBloodFurnace",
	},
	[13054] = {
		341 / 512, 497 / 512,	"HCTheShatteredHalls",
	},
	[12058] = {
		144 / 512, 217 / 512,		"KarazhanStart",
		144 / 512 - 1, 217 / 512,	"KarazhanEnd",
	},
	[11060] = {
		378 / 512, 63 / 512,		"Maraudon",
	},
	[12061] = {
		19 / 512, 114 / 512,		"MoltenCore",
	},
	[14065] = {
		210 / 512, 211 / 512,	"Naxxramas",
	},
	[11067] = {
		50 / 512, 66 / 512,		"OnyxiasLair",
	},
	[11069] = {
		379 / 512, 14 / 512,		"RagefireChasm",
	},
	[11070] = {
		26 / 512, 123 / 512,		"RazorfenDowns",
	},
	[11071] = {
		359 / 512, 361 / 512,	"RazorfenKraul",
	},
	[11073] = {
		320 / 512, 36 / 512,		"TheRuinsofAhnQiraj",
	},
	[12074] = {
		512 / 512, 512 / 512,	"SMArmory",
		0 / 512, 512 / 512,		"SMCathedral",
		512 / 512, 0 / 512,		"SMGraveyard",
		0 / 512, 0 / 512,			"SMLibrary",
	},
	[12075] = {
		124 / 512, 174 / 512,	"Scholomance",
	},
	[12077] = {
		373 / 512, 325 / 512,	"ShadowfangKeep",
	},
	[12086] = {
		266 / 512, 460 / 512,	"Stratholme",
	},
	[12087] = {
		307 / 512, 11 / 512,		"TheSunkenTemple",
	},
	[13091] = {
		193 / 512, 485 / 512,		"TempestKeepArcatraz",
	},
	[13092] = {
		494 / 512, 218 / 512,		"TempestKeepBotanica",
	},
	[13093] = {
		230 / 512, 482 / 512,		"TempestKeepTheEye",
	},
	[13094] = {
		219 / 512, 475 / 512,		"TempestKeepMechanar",
	},
	[11095] = {
		127 / 512, 193 / 512,		"TheTempleofAhnQiraj",
	},
	[12098] = {
		62 / 512, 100 / 512,		"TheDeadmines",
	},
	[12101] = {
		257 / 512, 347 / 512,		"TheStockade",
	},
	[12106] = {
		458 / 512, 379 / 512,		"Uldaman",
	},
	[11109] = {
		220 / 512, 298 / 512,		"WailingCaverns",
	},
	[12116] = {
		399 / 512, 453 / 512,		"ZulFarrak",
	},
	[12117] = {
		39 / 512, 259 / 512,		"ZulGurub",
	},
	[12118] = {
		39 / 512, 271 / 512,		"ZulAman",
	},
	[12120] = {
		209 / 512, 401 / 512,	"MagistersTerrace",
	},
	[12121] = {
		164 / 512, 69 / 512,		"SunwellPlateau",
	},
	[14133] = { 438 / 512, 349 / 512, "AhnKahet", },
	[14134] = { 108 / 512, 214 / 512, "AzjolNerub",	},
	[14135] = {  17 / 512, 279 / 512, "DrakTharonKeep", },
	[14136] = { 375 / 512, 172 / 512, "Gundrak", },
	[14137] = { 186 / 512, 459 / 512, "TheNexus", },
	[14138] = { 250 / 512, 244 / 512, "TheOculus", },
	[14139] = { 236 / 512, 481 / 512, "VioletHold", },
	[14140] = {   9 / 512, 154 / 512, "UlduarHallsofLightning", },
	[14141] = {  62 / 512, 209 / 512, "UlduarHallsofStone", },
	[14142] = { 334 / 512, 271 / 512, "UtgardeKeep", },
	[14144] = { 265 / 512, 257 / 512, "ObsidianSanctum", },
	[14145] = { 185 / 512,   9 / 512, "UtgardePinnacle", },
	[11147] = { 398 / 512, 489 / 512, "CoTOldStratholme", },
]]--
}

Map.InstanceInfo = {			-- Blizzard instance maps (SetInstanceMap uses size of 3 for table entries)
}	

Map.ZoneOverlays = {

	-- Kalimdor

		["moonglade"] = {
			["shrineofremulos"] = "209,91,271,296",
			["lakeeluneara"] = "219,273,431,319",
			["stormragebarrowdens"] = "542,210,275,346",
			["nighthaven"] = "370,135,346,244",
		},
		["barrens"] = {
			["dreadmistpeak"] = "290,104,241,195",
			["thornhill"] = "481,254,239,231",
			["thestagnantoasis"] = "344,379,336,289",
			["farwatchpost"] = "555,129,207,332",
			["thesludgefen"] = "403,6,257,249",
			["thewailingcaverns"] = "152,318,377,325",
			["thedryhills"] = "116,57,283,270",
			["themerchantcoast"] = "556,456,315,212",
			["boulderlodemine"] = "511,7,278,209",
			["theforgottenpools"] = "100,208,446,256",
			["morshanrampart"] = "258,6,261,216",
			["ratchet"] = "547,379,219,175",
			["thecrossroads"] = "362,275,233,193",
			["groldomfarm"] = "448,127,243,217",
		},
		["winterspring"] = {
			["icethistlehills"] = "581,314,249,217",
			["lakekeltheril"] = "372,268,271,258",
			["starfallvillage"] = "229,33,367,340",
			["mazthoril"] = "399,340,257,238",
			["frostsaberrock"] = "304,0,332,268",
			["timbermawpost"] = "92,302,362,252",
			["thehiddengrove"] = "500,17,333,255",
			["frostwhispergorge"] = "424,474,317,183",
			["everlook"] = "482,195,194,229",
			["owlwingthicket"] = "556,439,254,150",
			["winterfallvillage"] = "588,181,221,209",
			["frostfirehotsprings"] = "93,118,376,289",
		},
		["uldum_terrain1"] = {
			["thegateofunendingcycles"] = "647,15,161,236",
			["thecursedlanding"] = "752,170,237,316",
			["ruinsofammon"] = "217,289,203,249",
			["akhenetfields"] = "471,277,164,185",
			["orsis"] = "264,136,249,243",
			["nahom"] = "583,162,237,194",
			["ramkahen"] = "411,67,228,227",
			["obeliskofthemoon"] = "110,0,400,224",
			["obeliskofthesun"] = "340,282,269,203",
			["thetrailofdevestation"] = "657,349,206,204",
			["cradeloftheancient"] = "341,402,202,169",
			["schnottzslanding"] = "28,221,312,289",
			["marat"] = "406,174,160,193",
			["virnaaldam"] = "479,215,151,144",
			["throneofthefourwinds"] = "229,433,270,229",
			["thevortexpinnacle"] = "656,473,213,195",
			["hallsoforigination"] = "599,184,269,242",
			["templeofuldum"] = "132,127,296,209",
			["obeliskofthestars"] = "551,121,196,170",
			["ruinsofahmtul"] = "365,0,278,173",
			["khartutstomb"] = "542,0,203,215",
			["neferset"] = "407,384,209,254",
			["tahretgrounds"] = "545,193,150,159",
			["lostcityofthetolvir"] = "527,291,233,321",
		},
		["ashenvale"] = {
			["theshrineofassenia"] = "40,275,306,283",
			["nightrun"] = "595,253,221,257",
			["fallenskylake"] = "529,385,287,276",
			["warsonglumbercamp"] = "771,265,231,223",
			["lakefalathim"] = "112,148,184,232",
			["satyrnaar"] = "696,154,235,236",
			["thehowlingvale"] = "473,97,325,239",
			["raynewoodretreat"] = "481,221,231,256",
			["thezoramstrand"] = "0,0,262,390",
			["felfirehill"] = "714,317,277,333",
			["maelstraspost"] = "188,0,246,361",
			["thunderpeak"] = "377,121,203,310",
			["theruinsofstardust"] = "210,331,236,271",
			["orendilsretreat"] = "143,0,244,251",
			["astranaar"] = "255,164,251,271",
			["thistlefurvillage"] = "255,78,314,241",
			["silverwindrefuge"] = "338,335,347,308",
			["boughshadow"] = "836,148,166,211",
		},
		["teldrassil"] = {
			["banethilhollow"] = "374,221,175,235",
			["shadowglen"] = "481,104,241,217",
			["gnarlpinehold"] = "347,355,198,181",
			["thecleft"] = "432,109,144,226",
			["theoracleglade"] = "276,90,194,244",
			["rutheranvillage"] = "329,448,317,220",
			["lakealameth"] = "422,310,289,202",
			["wellspringlake"] = "382,83,165,249",
			["starbreezevillage"] = "544,217,187,196",
			["galardellvalley"] = "466,237,178,186",
			["poolsofarlithrien"] = "345,243,140,210",
			["darnassus"] = "149,181,298,337",
		},
		["mulgore"] = {
			["baeldundigsite"] = "226,220,218,192",
			["winterhoofwaterwell"] = "449,340,174,185",
			["redcloudmesa"] = "286,401,446,264",
			["redrocks"] = "514,43,186,185",
			["ravagedcaravan"] = "435,224,187,165",
			["thunderhornwaterwell"] = "333,202,201,167",
			["theventurecomine"] = "530,138,208,300",
			["wildmanewaterwell"] = "331,0,190,172",
			["thunderbluff"] = "208,62,373,259",
			["windfuryridge"] = "400,0,222,202",
			["bloodhoofvillage"] = "319,273,302,223",
			["stonetalonpass"] = "201,0,237,184",
			["therollingplains"] = "527,291,260,243",
			["palemanerock"] = "248,321,172,205",
			["thegoldenplains"] = "448,101,186,216",
		},
		["hyjal"] = {
			["archimondesvengeance"] = "320,5,270,300",
			["shrineofgoldrinn"] = "116,17,291,321",
			["nordrassil"] = "392,0,537,323",
			["gatesofsothann"] = "622,320,272,334",
			["sethriasroost"] = "139,436,277,232",
			["theregrowth"] = "52,253,441,319",
			["direforgehill"] = "303,197,270,173",
			["ashenlake"] = "6,78,282,418",
			["thescorchedplain"] = "411,216,365,264",
			["thethroneofflame"] = "318,378,419,290",
			["darkwhispergorge"] = "682,128,320,471",
		},
		["felwood"] = {
			["irontreewoods"] = "406,55,261,273",
			["morlosaran"] = "476,484,187,176",
			["bloodvenomfalls"] = "220,231,345,192",
			["jaedenar"] = "234,317,319,176",
			["felpawvillage"] = "471,0,307,161",
			["jadefirerun"] = "303,9,263,199",
			["ruinsofconstellas"] = "278,359,268,214",
			["deadwoodvillage"] = "410,505,173,163",
			["emeraldsanctuary"] = "394,382,274,212",
			["shatterscarvale"] = "243,107,343,250",
			["talonbranchglade"] = "531,57,209,226",
			["jadefireglen"] = "288,458,229,210",
		},
		["darkshore"] = {
			["lordanel"] = "391,54,277,281",
			["eyeofthevortex"] = "300,239,330,192",
			["nazjvel"] = "207,467,244,201",
			["wildbendriver"] = "280,378,314,193",
			["ruinsofauberdine"] = "280,182,203,194",
			["witheringthicket"] = "305,118,328,250",
			["shatterspearvale"] = "596,16,250,241",
			["shatterspearwarcamp"] = "565,0,245,147",
			["ametharan"] = "294,330,326,145",
			["ruinsofmathystra"] = "517,28,200,263",
			["themastersglaive"] = "277,483,303,185",
		},
		["aszhara"] = {
			["bearshead"] = "113,141,256,224",
			["thesecretlab"] = "353,396,184,213",
			["ruinsofarkkoran"] = "575,121,219,193",
			["darnassianbasecamp"] = "343,3,243,262",
			["lakemennar"] = "245,377,210,232",
			["ravencrestmonument"] = "476,401,295,267",
			["stormcliffs"] = "407,403,207,232",
			["theshatteredstrand"] = "316,168,206,329",
			["gallywixpleasurepalace"] = "70,222,250,230",
			["blackmawhold"] = "204,53,260,267",
			["bilgewaterharbor"] = "395,127,587,381",
			["towerofeldara"] = "684,22,306,337",
			["orgimmarreargate"] = "22,344,352,274",
			["bitterreaches"] = "477,0,321,247",
			["ruinsofeldarath"] = "228,229,218,237",
		},
		["ungorocrater"] = {
			["lakkaritarpits"] = "305,0,432,294",
			["ironstoneplateau"] = "706,201,197,222",
			["therollinggarden"] = "565,39,337,321",
			["golakkahotsprings"] = "145,226,309,277",
			["theslitheringscar"] = "335,384,381,274",
			["thescreamingreaches"] = "157,0,332,332",
			["mossypile"] = "328,179,186,185",
			["themarshlands"] = "573,256,263,412",
			["fireplumeridge"] = "356,192,321,288",
			["terrorrun"] = "162,357,316,293",
			["fungalrock"] = "557,0,224,191",
			["marshalsstand"] = "462,330,204,170",
		},
		["desolace"] = {
			["valleyofspears"] = "170,196,321,275",
			["gelkisvillage"] = "207,472,274,196",
			["mannoroccoven"] = "381,357,326,311",
			["thunderaxefortress"] = "440,49,220,205",
			["shokthokar"] = "589,319,309,349",
			["cenarionwildlands"] = "415,156,312,285",
			["sargeron"] = "655,0,317,293",
			["nijelspoint"] = "573,0,231,257",
			["magramterritory"] = "613,170,289,244",
			["thargadscamp"] = "275,376,212,186",
			["tethrisaran"] = "399,0,274,145",
			["kodograveyard"] = "360,273,250,215",
			["ranzjarisle"] = "210,0,161,141",
			["shadowbreakravine"] = "637,402,292,266",
			["shadowpreyvillage"] = "142,369,222,299",
			["slitherbladeshore"] = "208,24,338,342",
		},
		["tanaris"] = {
			["landsendbeach"] = "431,452,224,216",
			["southbreakshore"] = "437,289,274,186",
			["zulfarrak"] = "184,0,315,190",
			["valleryofthewatchers"] = "255,431,269,190",
			["southmoonruins"] = "301,349,232,211",
			["brokenpillar"] = "413,211,195,163",
			["thegapingchasm"] = "448,364,225,187",
			["cavernsoftime"] = "507,238,213,173",
			["gadgetzan"] = "412,92,189,180",
			["dunemaulcompound"] = "305,257,231,177",
			["gadgetzanbay"] = "479,9,254,341",
			["lostriggercover"] = "615,201,178,243",
			["eastmoonruins"] = "380,341,173,163",
			["abyssalsands"] = "297,148,255,194",
			["thistleshrubvalley"] = "185,280,221,293",
			["thenoxiouslair"] = "258,211,179,190",
			["sandsorrowwatch"] = "293,99,214,149",
		},
		["uldum"] = {
			["thegateofunendingcycles"] = "647,15,161,236",
			["thecursedlanding"] = "752,170,237,316",
			["ruinsofammon"] = "217,289,203,249",
			["akhenetfields"] = "471,277,164,185",
			["orsis"] = "264,136,249,243",
			["nahom"] = "583,162,237,194",
			["ramkahen"] = "411,67,228,227",
			["obeliskofthemoon"] = "110,0,400,224",
			["obeliskofthesun"] = "340,282,269,203",
			["thetrailofdevestation"] = "657,349,206,204",
			["cradeloftheancient"] = "341,402,202,169",
			["schnottzslanding"] = "28,221,312,289",
			["marat"] = "406,174,160,193",
			["virnaaldam"] = "479,215,151,144",
			["throneofthefourwinds"] = "229,433,270,229",
			["thevortexpinnacle"] = "656,473,213,195",
			["hallsoforigination"] = "599,184,269,242",
			["templeofuldum"] = "132,127,296,209",
			["obeliskofthestars"] = "551,121,196,170",
			["ruinsofahmtul"] = "365,0,278,173",
			["khartutstomb"] = "542,0,203,215",
			["neferset"] = "407,384,209,254",
			["tahretgrounds"] = "545,193,150,159",
			["lostcityofthetolvir"] = "527,291,233,321",
		},
		["ahnqirajthefallenkingdom"] = {
			["aqkingdom"] = "115,0,887,668",
		},
		["durotar"] = {
			["razormanegrounds"] = "302,264,248,158",
			["echoisles"] = "429,413,330,255",
			["thunderridge"] = "295,48,220,218",
			["skullrock"] = "438,0,208,157",
			["tiragardekeep"] = "462,298,210,200",
			["valleyoftrials"] = "304,312,254,258",
			["southfurywatershed"] = "282,174,244,222",
			["drygulchravine"] = "415,60,236,196",
			["senjinvillage"] = "457,406,192,184",
			["razorhill"] = "431,157,224,227",
			["northwatchfoothold"] = "399,440,162,157",
			["orgrimmar"] = "309,0,259,165",
		},
		["feralas"] = {
			["campmojache"] = "671,181,174,220",
			["feathermoonstronghold"] = "362,237,217,192",
			["darkmistruins"] = "568,287,172,198",
			["writhingdeep"] = "652,298,232,206",
			["ruinsoffeathermoon"] = "186,229,208,204",
			["theforgottencoast"] = "375,343,194,304",
			["feralscar"] = "457,281,191,179",
			["grimtotemcompund"] = "607,170,159,218",
			["ruinsofisildien"] = "467,354,206,237",
			["gordunnioutpost"] = "663,116,192,157",
			["thetwincolossals"] = "271,0,350,334",
			["diremaul"] = "485,101,265,284",
			["lowerwilds"] = "756,191,207,209",
		},
		["silithus"] = {
			["thescarabwall"] = "0,455,580,213",
			["valorsrest"] = "614,0,315,285",
			["twilightbasecamp"] = "100,151,434,231",
			["southwindvillage"] = "550,181,309,243",
			["thecrystalvale"] = "126,0,329,246",
			["hiveashi"] = "345,4,405,267",
			["cenarionhold"] = "427,143,292,260",
			["hiveregal"] = "380,310,489,358",
			["hivezora"] = "0,206,542,367",
		},
		["stonetalonmountains"] = {
			["windshearcrag"] = "533,179,374,287",
			["kromgarfortress"] = "588,341,183,196",
			["stonetalonpeak"] = "265,0,305,244",
			["unearthedgrounds"] = "654,369,265,206",
			["greatwoodvale"] = "602,448,322,220",
			["boulderslideravine"] = "532,512,194,156",
			["cliffwalkerpost"] = "366,95,241,192",
			["webwinderpath"] = "468,263,267,352",
			["sunrockretreat"] = "353,285,222,222",
			["webwinderhollow"] = "479,401,164,258",
			["ruinsofeldrethar"] = "367,411,221,235",
			["battlescarvalley"] = "220,189,290,297",
			["windshearhold"] = "516,289,176,189",
			["thaldarahoverlook"] = "252,121,210,189",
			["malakajin"] = "618,537,211,131",
			["mirkfallonlake"] = "417,143,244,247",
			["thecharredvale"] = "199,368,277,274",
		},
		["southernbarrens"] = {
			["huntershill"] = "300,64,218,178",
			["honorsstand"] = "201,0,315,170",
			["ruinsoftaurajo"] = "244,286,285,171",
			["razorfenkraul"] = "273,528,214,140",
			["vendettapoint"] = "267,196,254,214",
			["forwardcommand"] = "423,251,216,172",
			["battlescar"] = "274,307,384,248",
			["theovergrowth"] = "289,117,355,226",
			["baelmodan"] = "398,457,269,211",
			["northwatchhold"] = "548,147,280,279",
			["frazzlecrazmotherload"] = "269,436,242,195",
		},
		["dustwallow"] = {
			["witchhill"] = "428,0,270,353",
			["theramoreisle"] = "542,223,305,247",
			["direhornpost"] = "358,169,279,301",
			["blackhoofvillage"] = "199,0,344,183",
			["brackenwllvillage"] = "133,59,384,249",
			["alcazisland"] = "656,21,206,200",
			["mudsprocket"] = "109,313,433,351",
			["shadyrestinn"] = "137,188,317,230",
			["thewyrmbog"] = "359,369,436,299",
		},
		["hyjal_terrain1"] = {
			["archimondesvengeance"] = "320,5,270,300",
			["shrineofgoldrinn"] = "116,17,291,321",
			["nordrassil"] = "392,0,537,323",
			["gatesofsothann"] = "622,320,272,334",
			["sethriasroost"] = "139,436,277,232",
			["theregrowth"] = "52,253,441,319",
			["direforgehill"] = "303,197,270,173",
			["ashenlake"] = "6,78,282,418",
			["thescorchedplain"] = "411,216,365,264",
			["thethroneofflame"] = "318,378,419,290",
			["darkwhispergorge"] = "682,128,320,471",
		},
		["thousandneedles"] = {
			["southseaholdfast"] = "756,412,246,256",
			["thetwilightwithering"] = "347,329,374,339",
			["splithoofheights"] = "571,49,431,410",
			["thegreatlift"] = "136,0,272,232",
			["razorfendowns"] = "298,0,361,314",
			["theshimmeringdeep"] = "591,257,411,411",
			["freewindpost"] = "276,186,436,271",
			["highperch"] = "0,134,246,380",
			["rustmauldivesite"] = "527,465,234,203",
			["westreachsummit"] = "0,0,280,325",
			["twilightbulwark"] = "125,241,358,418",
			["darkcloudpinnacle"] = "169,116,317,252",
		},

	-- Eastern Kingdoms

		["vashjirruins"] = {
			["nespirah"] = "460,261,286,269",
			["glimmeringdeepgorge"] = "270,222,272,180",
			["silvertidehollow"] = "150,32,480,319",
			["shimmeringgrotto"] = "400,0,339,278",
			["ruinsofvashjir"] = "217,268,349,361",
			["ruinsoftherseral"] = "554,175,197,223",
			["bethmoraridge"] = "407,445,335,223",
		},
		["duskwood"] = {
			["theyorgenfarmstead"] = "401,396,233,248",
			["addlesstead"] = "32,348,299,296",
			["thetranquilgardenscemetary"] = "627,344,291,244",
			["darkshire"] = "640,128,329,314",
			["brightwoodgrove"] = "497,112,279,399",
			["vulgologremound"] = "228,355,268,282",
			["thehushedbank"] = "0,152,189,307",
			["thedarkenedbank"] = "71,26,931,235",
			["manormistmantle"] = "661,122,219,182",
			["racenhill"] = "96,292,205,157",
			["thetwilightgrove"] = "314,101,320,388",
			["therottingorchard"] = "539,368,291,263",
			["ravenhillcemetary"] = "91,132,323,309",
		},
		["vashjirkelpforest"] = {
			["darkwhispergorge"] = "528,228,220,189",
			["honorstomb"] = "380,43,291,206",
			["legionsfate"] = "210,35,278,315",
			["gnawsboneyard"] = "451,325,311,217",
			["theaccursedreef"] = "365,162,340,225",
			["gubogglesledge"] = "399,280,227,207",
			["holdingpens"] = "456,401,316,267",
		},
		["twilighthighlands_terrain1"] = {
			["victorypoint"] = "302,306,177,159",
			["dragonmawpass"] = "76,120,283,206",
			["bloodgulch"] = "416,205,215,157",
			["obsidianforest"] = "436,380,342,288",
			["thundermar"] = "374,93,238,229",
			["grimbatol"] = "83,223,230,276",
			["theblackbreach"] = "498,121,211,210",
			["wyrmsbend"] = "205,232,191,198",
			["dragonmawport"] = "631,245,251,207",
			["crucibleofcarnage"] = "387,268,203,208",
			["twilightshore"] = "610,345,260,202",
			["vermillionredoubt"] = "71,16,324,264",
			["thegullet"] = "269,179,175,180",
			["humboldtconflaguration"] = "344,89,143,141",
			["gorshakwarcamp"] = "543,220,194,170",
			["highbank"] = "697,403,220,227",
			["crushblow"] = "370,447,182,195",
			["thetwilightcitadel"] = "151,314,361,354",
			["highlandforest"] = "482,330,239,232",
			["thetwilightbreach"] = "312,192,199,212",
			["thekrazzworks"] = "654,0,226,232",
			["slitheringcove"] = "622,169,198,201",
			["thetwilightgate"] = "327,356,165,199",
			["ruinsofdrakgor"] = "296,0,206,182",
			["firebeardspatrol"] = "499,265,215,181",
			["dunwaldruins"] = "395,367,197,218",
			["weepingwound"] = "358,0,214,190",
			["kirthaven"] = "482,0,308,267",
			["glopgutshollow"] = "291,89,174,190",
		},
		["hinterlands"] = {
			["queldanillodge"] = "220,181,241,211",
			["thealtarofzul"] = "357,343,225,196",
			["shaolwatha"] = "565,208,281,261",
			["thecreepingruin"] = "390,252,199,199",
			["zunwatha"] = "152,284,226,225",
			["plaguemistravine"] = "133,105,191,278",
			["shadraalor"] = "220,379,240,196",
			["aeriepeak"] = "0,236,238,267",
			["valorwindlake"] = "286,269,199,212",
			["agolwatha"] = "367,159,208,204",
			["jinthaalor"] = "487,334,287,289",
			["skulkrock"] = "490,195,176,235",
			["seradane"] = "475,5,303,311",
			["theoverlookcliffs"] = "677,267,244,401",
		},
		["blastedlands"] = {
			["serpentscoil"] = "459,97,218,183",
			["nethergardekeep"] = "530,6,295,205",
			["dreadmaulpost"] = "327,182,235,188",
			["altarofstorms"] = "225,110,238,195",
			["riseofthedefiler"] = "375,102,168,170",
			["dreadmaulhold"] = "258,0,272,206",
			["thetaintedforest"] = "132,311,348,357",
			["surwich"] = "333,474,199,191",
			["thedarkportal"] = "368,179,370,298",
			["theredreaches"] = "533,268,268,354",
			["shattershore"] = "578,91,240,270",
			["sunveilexcursion"] = "386,374,233,266",
			["nethergardesupplycamps"] = "436,0,195,199",
			["thetaintedscar"] = "144,175,308,226",
		},
		["wetlands"] = {
			["sundownmarsh"] = "121,63,276,243",
			["blackchannelmarsh"] = "37,240,301,232",
			["dunalgaz"] = "346,419,298,215",
			["slabchiselssurvey"] = "532,352,300,316",
			["satlspray"] = "218,0,250,282",
			["greenwardensgrove"] = "460,102,250,269",
			["raptorridge"] = "599,123,256,245",
			["thelganrock"] = "371,335,258,207",
			["bluegillmarsh"] = "31,102,321,248",
			["mosshidefen"] = "506,232,369,235",
			["direforgehills"] = "506,34,329,228",
			["angerfangencampment"] = "359,201,236,256",
			["whelgarsexcavationsite"] = "185,195,298,447",
			["dunmodr"] = "356,7,257,185",
			["ironbeardstomb"] = "372,76,185,224",
			["menethilharbor"] = "0,297,325,363",
		},
		["easternplaguelands"] = {
			["zulmashar"] = "528,0,286,176",
			["thefungalvale"] = "183,211,274,216",
			["theundercroft"] = "56,457,280,211",
			["lightshopechapel"] = "687,271,196,220",
			["corinscrossing"] = "493,289,186,213",
			["tyrshand"] = "651,414,214,254",
			["eastwalltower"] = "541,184,181,176",
			["northpasstower"] = "401,69,250,192",
			["acherus"] = "774,102,228,273",
			["thondorilriver"] = "0,100,262,526",
			["themarrisstead"] = "133,335,202,202",
			["thenoxiousglade"] = "650,55,297,299",
			["thepestilentscar"] = "383,348,182,320",
			["theinfectisscar"] = "595,263,177,266",
			["terrordale"] = "0,10,258,320",
			["blackwoodlake"] = "382,151,238,231",
			["stratholme"] = "118,0,310,178",
			["quellithienlodge"] = "351,0,277,175",
			["plaguewood"] = "144,40,328,253",
			["darrowshire"] = "211,462,248,206",
			["ruinsofthescarletenclave"] = "738,295,264,373",
			["lightsshieldtower"] = "391,271,243,162",
			["northdale"] = "570,61,265,232",
			["crownguardtower"] = "258,351,202,191",
			["lakemereldar"] = "462,427,266,241",
		},
		["badlands"] = {
			["agmondsend"] = "230,315,342,353",
			["apocryphansrest"] = "0,66,252,353",
			["campcagg"] = "0,281,339,347",
			["uldaman"] = "336,0,266,210",
			["lethlorravine"] = "533,55,469,613",
			["campboff"] = "407,220,274,448",
			["hammertoesdigsite"] = "411,116,209,196",
			["campkosh"] = "504,19,236,260",
			["angorfortress"] = "230,68,285,223",
			["deathwingscar"] = "175,178,328,313",
			["thedustbowl"] = "144,99,214,285",
		},
		["silverpine"] = {
			["northtidesrun"] = "147,0,281,345",
			["thesepulcher"] = "341,157,218,200",
			["forsakenhighcommand"] = "445,0,361,175",
			["thedecrepitfields"] = "471,156,176,152",
			["northtidesbeachhead"] = "323,68,174,199",
			["theforsakenfront"] = "433,327,152,189",
			["valgansfield"] = "461,77,162,172",
			["deepelemmine"] = "483,212,217,198",
			["thebattlefront"] = "349,429,255,180",
			["fenrisisle"] = "581,15,352,302",
			["shadowfangkeep"] = "337,337,179,165",
			["olsensfarthing"] = "312,249,251,167",
			["ambermill"] = "509,250,283,243",
			["berensperil"] = "505,405,318,263",
			["forsakenrearguard"] = "369,0,186,238",
			["thegreymanewall"] = "318,506,409,162",
			["theskitteringdark"] = "236,0,227,172",
		},
		["thecapeofstranglethorn"] = {
			["bootybay"] = "289,341,225,255",
			["gurubashiarena"] = "345,0,238,260",
			["mistvalevalley"] = "408,248,253,242",
			["crystalveinmine"] = "528,73,271,204",
			["wildshore"] = "340,392,236,276",
			["nekmaniwellspring"] = "292,213,246,221",
			["ruinsofaboraz"] = "533,181,184,176",
			["jagueroisle"] = "471,404,240,264",
			["thesundering"] = "452,0,244,209",
			["hardwrenchhideaway"] = "208,116,356,221",
			["ruinsofjubuwal"] = "468,119,155,221",
		},
		["vashjirdepths"] = {
			["abyssalbreach"] = "497,0,491,470",
			["seabrush"] = "415,183,225,250",
			["fireplumetrench"] = "315,110,298,251",
			["lghorek"] = "162,210,306,293",
			["coldlightchasm"] = "266,280,267,374",
			["abandonedreef"] = "50,263,371,394",
			["korthunsend"] = "412,283,370,385",
			["deepfinridge"] = "275,32,363,262",
		},
		["stranglethornjungle"] = {
			["kurzenscompound"] = "499,0,244,238",
			["balalruins"] = "267,168,159,137",
			["thevilereef"] = "140,208,236,224",
			["moshoggogremound"] = "543,253,234,206",
			["ruinsofzulkunda"] = "158,0,228,265",
			["fortlivingston"] = "398,375,230,170",
			["mazthoril"] = "488,364,350,259",
			["nesingwarysexpedition"] = "306,63,227,190",
			["zuuldalaruins"] = "9,22,324,263",
			["kalairuins"] = "354,184,139,150",
			["zulgurub"] = "626,0,376,560",
			["baliamahruins"] = "397,243,239,205",
			["bambala"] = "566,164,190,176",
			["mizjahruins"] = "387,246,157,173",
			["lakenazferiti"] = "413,95,240,228",
			["gromgolbasecamp"] = "298,228,167,179",
			["rebelcamp"] = "306,0,302,166",
		},
		["ruinsofgilneas"] = {
			["gilneaspuzzle"] = "0,0,1002,668",
		},
		["gilneas_terrain2"] = {
			["greymanemanor"] = "141,202,244,241",
			["theblackwald"] = "504,394,280,224",
			["theheadlands"] = "160,0,328,336",
			["crowleyorchard"] = "261,427,210,166",
			["emberstonemine"] = "639,43,281,351",
			["duskhaven"] = "272,333,286,178",
			["tempestsreach"] = "652,290,350,345",
			["korothsden"] = "393,386,222,268",
			["hammondfarmstead"] = "167,352,194,236",
			["haywardfishery"] = "293,449,177,219",
			["stormglenvillage"] = "516,465,321,203",
			["northgatewoods"] = "482,14,282,298",
			["northernheadlands"] = "387,0,267,314",
			["keelharbor"] = "298,95,280,342",
		},
		["searinggorge"] = {
			["blackrockmountain"] = "243,424,304,244",
			["thoriumpoint"] = "255,38,429,301",
			["tannercamp"] = "413,360,571,308",
			["thecauldron"] = "232,171,481,360",
			["blackcharcave"] = "0,361,375,307",
			["grimsiltworksite"] = "531,241,441,266",
			["firewatchridge"] = "0,75,365,393",
			["dustfirevalley"] = "588,0,392,355",
		},
		["elwynn"] = {
			["westbrookgarrison"] = "116,355,269,313",
			["jerodslanding"] = "396,430,230,206",
			["northshirevalley"] = "355,138,295,296",
			["goldshire"] = "247,294,276,231",
			["stromwind"] = "0,0,512,422",
			["stonecairnlake"] = "552,186,340,272",
			["crystallake"] = "417,327,220,207",
			["towerofazora"] = "529,287,270,241",
			["ridgepointtower"] = "708,442,285,194",
			["brackwellpumpkinpatch"] = "532,424,287,216",
			["fargodeepmine"] = "240,420,269,248",
			["eastvaleloggingcamp"] = "703,292,294,243",
		},
		["arathi"] = {
			["refugepoint"] = "293,145,196,270",
			["galensfall"] = "0,144,212,305",
			["northfoldmanor"] = "132,105,227,268",
			["circleofeastbinding"] = "506,126,183,238",
			["bouldergor"] = "171,123,249,278",
			["goshekfarm"] = "430,249,306,248",
			["cirecleofouterbinding"] = "332,273,215,188",
			["hammerfall"] = "581,118,270,271",
			["thandolspan"] = "261,416,237,252",
			["boulderfisthall"] = "327,367,252,258",
			["faldirscove"] = "77,400,273,268",
			["witherbarkvillage"] = "476,359,260,220",
			["stromgardekeep"] = "21,269,284,306",
			["dabyriesfarmstead"] = "404,144,210,227",
			["circleofinnerbinding"] = "201,312,228,227",
			["circleofwestbinding"] = "85,24,220,287",
		},
		["dunmorogh"] = {
			["thegrizzledden"] = "374,287,211,160",
			["coldridgepass"] = "360,340,225,276",
			["kharanos"] = "449,220,184,188",
			["gnomeregan"] = "0,27,409,318",
			["thetundridhills"] = "579,306,174,249",
			["theshimmeringdeep"] = "397,132,171,234",
			["golbolarquarry"] = "663,288,198,251",
			["iceflowlake"] = "263,0,236,358",
			["amberstillranch"] = "595,225,249,183",
			["ironforgeairfield"] = "630,0,308,335",
			["frostmanehold"] = "50,227,437,249",
			["coldridgevalley"] = "100,366,398,302",
			["ironforge"] = "398,0,376,347",
			["helmsbedlake"] = "760,268,218,234",
			["northgateoutpost"] = "765,43,237,366",
			["frostmanefront"] = "469,256,226,335",
		},
		["westfall"] = {
			["thedaggerhills"] = "303,395,292,273",
			["furlbrowspumpkinfarm"] = "394,0,197,213",
			["thegapingchasm"] = "294,168,184,217",
			["jangoloadmine"] = "311,0,196,229",
			["goldcoastquarry"] = "199,79,235,306",
			["themolsenfarm"] = "348,118,202,224",
			["westfalllighthouse"] = "221,477,211,167",
			["sentinelhill"] = "404,226,229,265",
			["demontsplace"] = "203,376,201,195",
			["alexstonfarmstead"] = "167,263,346,222",
			["saldeansfarm"] = "451,81,244,237",
			["moonbrook"] = "308,325,232,213",
			["thedustplains"] = "480,378,317,261",
			["thedeadacre"] = "531,200,193,273",
			["thejansenstead"] = "474,0,202,179",
		},
		["burningsteppes"] = {
			["blackrockpass"] = "419,258,298,410",
			["dreadmaulrock"] = "568,151,274,263",
			["dracodar"] = "0,237,362,431",
			["altarofstorms"] = "0,0,182,360",
			["ruinsofthaurissan"] = "421,0,324,354",
			["blackrockmountain"] = "79,0,281,388",
			["terrorwingpath"] = "646,7,350,341",
			["blackrockstronghold"] = "235,0,320,385",
			["morgansvigil"] = "615,255,383,413",
			["pillarofash"] = "253,255,274,413",
		},
		["westernplaguelands"] = {
			["thebulwark"] = "48,235,316,316",
			["hearthglen"] = "235,0,432,271",
			["caerdarrow"] = "601,390,194,208",
			["sorrowhill"] = "261,448,368,220",
			["felstonefield"] = "229,228,241,212",
			["darrowmerelake"] = "510,354,492,314",
			["northridgelumbercamp"] = "231,123,359,182",
			["thewrithinghaunt"] = "472,332,169,195",
			["thondrorilriver"] = "533,0,311,436",
			["theweepingcave"] = "551,151,185,230",
			["redpinedell"] = "286,211,290,133",
			["dalsonsfarm"] = "300,232,325,192",
			["andorhal"] = "96,343,464,325",
			["gahrronswithering"] = "495,213,241,252",
		},
		["tirisfal"] = {
			["balnirfarmstead"] = "594,324,242,179",
			["venomwebvale"] = "752,150,250,279",
			["thebulwark"] = "709,330,293,338",
			["brill"] = "480,252,199,182",
			["scarletmonastery"] = "740,47,262,262",
			["scarletwatchpost"] = "692,99,161,234",
			["agamandmills"] = "324,90,285,260",
			["brightwaterlake"] = "573,122,210,292",
			["ruinsoflorderon"] = "423,359,390,267",
			["sollidenfarmstead"] = "201,192,286,225",
			["calstonestate"] = "389,255,179,169",
			["coldhearthmanor"] = "418,317,212,177",
			["deathknell"] = "9,207,431,407",
			["nightmarevale"] = "347,325,225,281",
			["crusaderoutpost"] = "686,232,175,210",
			["garrenshaunt"] = "477,129,190,214",
		},
		["redridge"] = {
			["rendersvalley"] = "451,377,427,291",
			["stonewatchkeep"] = "480,0,228,420",
			["lakeridgehighway"] = "148,316,392,352",
			["campeverstill"] = "445,286,189,193",
			["renderscamp"] = "214,0,357,246",
			["lakeeverstill"] = "81,214,464,250",
			["lakeshire"] = "0,110,410,256",
			["althersmill"] = "350,139,228,247",
			["shalewindcanyon"] = "688,283,306,324",
			["stonewatchfalls"] = "525,302,316,182",
			["galardellvalley"] = "574,0,428,463",
			["threecorners"] = "0,256,323,406",
			["redridgecanyons"] = "37,0,413,292",
		},
		["swampofsorrows"] = {
			["splinterspearjunction"] = "194,236,238,343",
			["stagalbog"] = "540,360,347,303",
			["marshtidewatch"] = "478,0,330,342",
			["pooloftears"] = "575,238,257,229",
			["theshiftingmire"] = "331,24,292,360",
			["sorrowmurk"] = "703,80,229,418",
			["ithariuscave"] = "7,242,268,316",
			["mistyreedstrand"] = "600,0,402,668",
			["stonard"] = "297,258,357,308",
			["mistyvalley"] = "0,80,268,285",
			["theharborage"] = "161,79,266,284",
			["bogpaddle"] = "600,0,262,193",
		},
		["lochmodan"] = {
			["thefarstriderlodge"] = "570,209,349,292",
			["stronewroughtdam"] = "339,0,333,200",
			["silverstreammine"] = "221,0,225,252",
			["northgatepass"] = "16,0,319,289",
			["ironbandsexcavationsite"] = "481,296,397,291",
			["stonesplintervalley"] = "177,345,273,294",
			["thelsamar"] = "0,146,455,295",
			["grizzlepawridge"] = "245,324,273,230",
			["valleyofkings"] = "0,311,310,345",
			["theloch"] = "340,81,330,474",
			["mogroshstronghold"] = "549,52,294,249",
		},
		["deadwindpass"] = {
			["deadmanscrossing"] = "83,0,617,522",
			["thevice"] = "433,208,350,449",
			["karazhan"] = "92,310,513,358",
		},
		["hillsbradfoothills"] = {
			["tarrenmill"] = "494,226,165,203",
			["gavinsnaze"] = "344,254,116,129",
			["lordamereinternmentcamp"] = "194,216,250,167",
			["mistyshore"] = "321,42,158,169",
			["nethandersteed"] = "502,373,204,244",
			["hillsbradfields"] = "191,302,302,175",
			["growlesscave"] = "359,191,171,136",
			["theheadland"] = "390,255,105,148",
			["azurelodemine"] = "287,399,180,182",
			["dalarancrater"] = "102,137,316,238",
			["gallowscorner"] = "451,140,155,147",
			["strahnbrad"] = "505,44,275,193",
			["darrowhill"] = "425,279,147,160",
			["southpointtower"] = "59,310,312,254",
			["dandredsfold"] = "341,0,258,113",
			["slaughterhollow"] = "413,55,148,120",
			["soferasnaze"] = "484,166,148,146",
			["ruinsofalterac"] = "347,85,189,181",
			["corrahnsdagger"] = "426,224,135,160",
			["purgationisle"] = "200,505,144,139",
			["crushridgehold"] = "463,101,134,124",
			["dungarok"] = "542,410,269,258",
			["durnholdekeep"] = "565,217,437,451",
			["chillwindpoint"] = "555,68,447,263",
			["theuplands"] = "441,0,212,160",
			["southshore"] = "383,352,229,219",
		},

	-- Jamie exports

	["azuremystisle"] = 
	{
		["ammenford"] = "515,279,256,256",
		["ammenvale"] = "527,104,475,512",
		["azurewatch"] = "383,249,256,256",
		["bristlelimbvillage"] = "174,363,256,256",
		["emberglade"] = "488,24,256,256",
		["fairbridgestrand"] = "356,0,256,128",
		["greezlescamp"] = "507,350,256,256",
		["moongrazewoods"] = "449,183,256,256",
		["odesyuslanding"] = "352,378,256,256",
		["podcluster"] = "281,305,256,256",
		["podwreckage"] = "462,349,128,256",
		["siltingshore"] = "291,3,256,256",
		["silvermystisle"] = "23,446,256,222",
		["stillpinehold"] = "365,49,256,256",
		["theexodar"] = "74,85,512,512",
		["valaarsberth"] = "176,303,256,256",
		["wrathscalepoint"] = "220,421,256,247",
	},
	["bladesedgemountains"] = 
	{
		["bashirlanding"] = "422,0,256,256",
		["bladedgulch"] = "623,147,256,256",
		["bladesiprehold"] = "314,161,256,507",
		["bloodmaulcamp"] = "412,95,256,256",
		["bloodmauloutpost"] = "342,371,256,297",
		["brokenwilds"] = "733,109,256,256",
		["circleofwrath"] = "439,210,256,256",
		["deathsdoor"] = "512,249,256,419",
		["forgecampanger"] = "586,147,416,256",
		["forgecampterror"] = "144,416,512,252",
		["forgecampwrath"] = "254,176,256,256",
		["grishnath"] = "286,28,256,256",
		["gruulslayer"] = "527,81,256,256",
		["jaggedridge"] = "446,414,256,254",
		["moknathalvillage"] = "658,297,256,256",
		["ravenswood"] = "214,55,512,256",
		["razorridge"] = "533,332,256,336",
		["ridgeofmadness"] = "554,258,256,410",
		["ruuanweald"] = "479,98,256,512",
		["skald"] = "673,71,256,256",
		["sylvanaar"] = "289,350,256,318",
		["thecrystalpine"] = "585,0,256,256",
		["thunderlordstronghold"] = "405,272,256,396",
		["veillashh"] = "271,428,256,240",
		["veilruuan"] = "563,151,256,128",
		["vekhaarstand"] = "629,406,256,256",
		["vortexpinnacle"] = "166,206,256,462",
	},
	["bloodmystisle"] = 
	{
		["amberwebpass"] = "44,62,256,512",
		["axxarien"] = "297,136,256,256",
		["blacksiltshore"] = "177,426,512,242",
		["bladewood"] = "367,209,256,256",
		["bloodscaleisle"] = "763,256,239,256",
		["bloodwatch"] = "437,258,256,256",
		["bristlelimbenclave"] = "546,410,256,256",
		["kesselscrossing"] = "517,527,485,141",
		["middenvale"] = "414,406,256,256",
		["mystwood"] = "309,483,256,185",
		["nazzivian"] = "250,404,256,256",
		["ragefeatherridge"] = "481,117,256,256",
		["ruinsofloretharan"] = "556,216,256,256",
		["talonstand"] = "657,78,256,256",
		["telathionscamp"] = "180,216,128,128",
		["thebloodcursedreef"] = "729,54,256,256",
		["thebloodwash"] = "302,27,256,256",
		["thecrimsonreach"] = "555,87,256,256",
		["thecryocore"] = "293,285,256,256",
		["thefoulpool"] = "221,136,256,256",
		["thehiddenreef"] = "205,39,256,256",
		["thelostfold"] = "503,470,256,198",
		["thevectorcoil"] = "43,238,512,430",
		["thewarppiston"] = "451,29,256,256",
		["veridianpoint"] = "637,0,256,256",
		["vindicatorsrest"] = "232,242,256,256",
		["wrathscalelair"] = "598,338,256,256",
		["wyrmscarisland"] = "613,82,256,256",
	},
	["eversongwoods"] = 
	{
		["azurebreezecoast"] = "669,228,256,256",
		["duskwithergrounds"] = "605,253,256,256",
		["eastsanctum"] = "460,373,256,256",
		["elrendarfalls"] = "580,399,128,256",
		["fairbreezevilliage"] = "386,386,256,256",
		["farstriderretreat"] = "524,359,256,128",
		["goldenboughpass"] = "243,469,256,128",
		["lakeelrendar"] = "584,471,128,197",
		["northsanctum"] = "361,298,256,256",
		["ruinsofsilvermoon"] = "307,136,256,256",
		["runestonefalithas"] = "378,496,256,172",
		["runestoneshandor"] = "464,494,256,174",
		["satherilshaven"] = "324,384,256,256",
		["silvermooncity"] = "440,87,512,512",
		["stillwhisperpond"] = "474,314,256,256",
		["sunsailanchorage"] = "231,404,256,128",
		["sunstriderisle"] = "195,5,512,512",
		["thegoldenstrand"] = "183,415,128,253",
		["thelivingwood"] = "511,420,128,248",
		["thescortchedgrove"] = "255,507,256,128",
		["thuronslivery"] = "539,305,256,128",
		["torwatha"] = "648,315,256,353",
		["tranquilshore"] = "215,298,256,256",
		["westsanctum"] = "292,319,128,256",
		["zebwatha"] = "554,475,128,193",
	},
	["ghostlands"] = 
	{
		["amanipass"] = "598,232,404,436",
		["bleedingziggurat"] = "184,238,256,256",
		["dawnstarspire"] = "575,0,427,256",
		["deatholme"] = "95,375,512,293",
		["elrendarcrossing"] = "326,0,512,256",
		["farstriderenclave"] = "573,136,429,256",
		["goldenmistvillage"] = "44,0,512,512",
		["howlingziggurat"] = "340,219,256,449",
		["isleoftribulations"] = "585,0,256,256",
		["sanctumofthemoon"] = "210,126,256,256",
		["sanctumofthesun"] = "448,150,256,512",
		["suncrownvillage"] = "460,0,512,256",
		["thalassiapass"] = "364,406,256,262",
		["tranquillien"] = "365,2,256,512",
		["windrunnerspire"] = "40,287,256,256",
		["windrunnervillage"] = "60,117,256,512",
		["zebnowa"] = "466,237,512,431",
	},
	["hellfire"] = 
	{
		["denofhaalesh"] = "182,412,256,256",
		["expeditionarmory"] = "261,413,512,255",
		["falconwatch"] = "183,326,512,342",
		["fallenskyridge"] = "34,142,256,256",
		["forgecamprage"] = "478,25,512,512",
		["hellfirecitadel"] = "338,210,256,458",
		["honorhold"] = "469,298,256,256",
		["magharpost"] = "206,110,256,256",
		["poolsofaggonar"] = "326,45,256,512",
		["ruinsofshanaar"] = "25,290,256,378",
		["templeoftelhamat"] = "38,152,512,512",
		["thelegionfront"] = "579,128,256,512",
		["thestairofdestiny"] = "737,156,256,512",
		["thrallmar"] = "467,154,256,256",
		["throneofkiljaeden"] = "477,6,512,256",
		["voidridge"] = "705,368,256,256",
		["warpfields"] = "308,408,256,260",
		["zethgor"] = "580,430,422,238",
	},
	["nagrand"] = 
	{
		["burningbladeruins"] = "660,334,256,334",
		["clanwatch"] = "532,363,256,256",
		["forgecampfear"] = "36,248,512,420",
		["forgecamphate"] = "162,154,256,256",
		["garadar"] = "431,143,256,256",
		["halaa"] = "335,193,256,256",
		["kilsorrowfortress"] = "558,427,256,241",
		["laughingskullruins"] = "351,52,256,256",
		["oshugun"] = "168,334,512,334",
		["ringoftrials"] = "533,267,256,256",
		["southwindcleft"] = "391,258,256,256",
		["sunspringpost"] = "219,199,256,256",
		["telaar"] = "387,390,256,256",
		["throneoftheelements"] = "504,53,256,256",
		["twilightridge"] = "10,107,256,512",
		["warmaulhill"] = "157,32,256,256",
		["windyreedpass"] = "598,79,256,256",
		["windyreedvillage"] = "666,233,256,256",
		["zangarridge"] = "277,54,256,256",
	},
	["netherstorm"] = 
	{
		["area52"] = "241,388,256,128",
		["arklonruins"] = "328,397,256,256",
		["celestialridge"] = "644,173,256,256",
		["ecodomefarfield"] = "396,10,256,256",
		["etheriumstaginggrounds"] = "481,208,256,256",
		["forgebaseog"] = "237,22,256,256",
		["kirinvarvillage"] = "490,523,256,145",
		["manaforgebanar"] = "147,281,256,387",
		["manaforgecoruu"] = "357,489,256,179",
		["manaforgeduro"] = "465,336,256,256",
		["manafrogeara"] = "171,155,256,256",
		["netherstone"] = "411,20,256,256",
		["netherstormbridge"] = "132,294,256,256",
		["ruinedmanaforge"] = "513,138,256,256",
		["ruinsofenkaat"] = "253,301,256,256",
		["ruinsoffarahlon"] = "354,49,512,256",
		["socretharsseat"] = "229,38,256,256",
		["sunfuryhold"] = "454,451,256,217",
		["tempestkeep"] = "593,284,409,384",
		["theheap"] = "239,455,256,213",
		["thescrapfield"] = "356,261,256,256",
		["thestormspire"] = "298,134,256,256",
	},
	["shadowmoonvalley"] = 
	{
		["altarofshatar"] = "520,93,256,256",
		["coilskarpoint"] = "348,8,512,512",
		["eclipsepoint"] = "343,310,512,358",
		["illadarpoint"] = "143,256,256,256",
		["legionhold"] = "104,155,512,512",
		["netherwingcliffs"] = "554,308,256,256",
		["netherwingledge"] = "510,445,492,223",
		["shadowmoonvilliage"] = "116,35,512,512",
		["theblacktemple"] = "606,126,396,512",
		["thedeathforge"] = "290,129,256,512",
		["thehandofguldan"] = "394,90,512,512",
		["thewardenscage"] = "469,258,512,410",
		["wildhammerstronghold"] = "168,229,512,439",
	},
	["terokkarforest"] = 
	{
		["allerianstronghold"] = "480,277,256,256",
		["auchenaigrounds"] = "247,434,256,234",
		["bleedinghollowclanruins"] = "103,301,256,367",
		["bonechewerruins"] = "521,275,256,256",
		["carrionhill"] = "377,272,256,256",
		["cenarionthicket"] = "314,0,256,256",
		["firewingpoint"] = "617,149,385,512",
		["grangolvarvilliage"] = "143,171,512,256",
		["raastokglade"] = "505,154,256,256",
		["razorthornshelf"] = "478,19,256,256",
		["refugecaravan"] = "316,268,128,256",
		["ringofobservance"] = "310,345,256,256",
		["sethekktomb"] = "245,289,256,256",
		["shattrathcity"] = "104,4,512,512",
		["skethylmountains"] = "449,348,512,320",
		["smolderingcaravan"] = "321,460,256,208",
		["stonebreakerhold"] = "397,165,256,256",
		["thebarrierhills"] = "116,4,256,256",
		["tuurem"] = "455,34,256,512",
		["veilrhaze"] = "222,362,256,256",
		["writhingmound"] = "417,327,256,256",
	},
	["zangarmarsh"] = 
	{
		["angoroshgrounds"] = "88,50,256,256",
		["angoroshstronghold"] = "124,0,256,128",
		["bloodscaleenclave"] = "596,412,256,256",
		["cenarionrefuge"] = "694,321,308,256",
		["coilfangreservoir"] = "462,90,256,512",
		["feralfenvillage"] = "314,332,512,336",
		["marshlightlake"] = "81,152,256,256",
		["oreborharborage"] = "329,25,256,512",
		["quaggridge"] = "141,325,256,343",
		["sporeggar"] = "20,202,512,256",
		["telredor"] = "569,112,256,512",
		["thedeadmire"] = "716,128,286,512",
		["thehewnbog"] = "219,51,256,512",
		["thelagoon"] = "512,303,256,256",
		["thespawningglen"] = "31,339,256,256",
		["twinspireruins"] = "342,249,256,256",
		["umbrafenvillage"] = "720,461,256,207",
		["zabrajin"] = "175,232,256,256",
	},

	-- Manually added for patch 2.4
	["sunwell"] =
	{
		["sunsreachharbor"] = "252,252,512,416",
		["sunsreachsanctum"] = "251,4,512,512",
	},

	-- WotLK

	["scarletenclave"] =
	{
		["scarletenclave"] = "0,0,1024,768",	-- FIX!!
	},
	["lakewintergrasp"] = {							
		["lakewintergrasp"] = "0,0,1024,768",		
	},
	["dalaran"] = {
		["dalaran1_"] = "0,0,1024,768",	-- FIX!!
	},

	["boreantundra"] = {
		["deathsstand"] = "707,181,289,279",
		["templecityofenkilah"] = "712,15,290,292",
		["warsongstronghold"] = "329,237,260,278",
		["riplashstrand"] = "293,383,382,258",
		["thedensofdying"] = "662,11,203,209",
		["thegeyserfields"] = "480,0,375,342",
		["torpsfarm"] = "272,237,186,276",
		["valiancekeep"] = "457,264,259,302",
		["garroshslanding"] = "153,238,267,378",
		["borgorokoutpost"] = "314,0,396,203",
		["amberledge"] = "325,140,244,214",
		["kaskala"] = "509,214,385,316",
		["steeljawscaravan"] = "397,66,244,319",
		["coldarra"] = "50,0,460,381",
	},
	["sholazarbasin"] = {
		["kartakshold"] = "76,375,329,293",
		["theavalanche"] = "596,92,322,265",
		["thesavagethicket"] = "396,51,293,229",
		["thesuntouchedpillar"] = "82,186,455,316",
		["themakersperch"] = "172,135,249,248",
		["themakersoverlook"] = "705,236,233,286",
		["rainspeakercanopy"] = "427,244,207,235",
		["themosslightpillar"] = "265,355,239,313",
		["theglimmeringpillar"] = "308,34,294,327",
		["thelifebloodpillar"] = "501,134,312,369",
		["thestormwrightsshelf"] = "138,58,268,288",
		["riversheart"] = "359,339,468,329",
	},
	["dragonblight"] = {
		["lightsrest"] = "703,7,299,278",
		["galakrondsrest"] = "433,118,258,225",
		["newhearthglen"] = "614,358,214,261",
		["rubydragonshrine"] = "374,208,188,211",
		["icemistvillage"] = "134,165,235,337",
		["venomspite"] = "661,264,226,212",
		["westwindrefugeecamp"] = "42,187,229,299",
		["obsidiandragonshrine"] = "256,104,304,203",
		["naxxramas"] = "691,160,311,272",
		["wyrmresttemple"] = "453,219,317,353",
		["scarletpoint"] = "569,7,235,354",
		["emeralddragonshrine"] = "543,362,196,218",
		["agmarshammer"] = "258,203,236,218",
		["theforgottenshore"] = "698,332,301,286",
		["thecrystalvice"] = "487,0,229,259",
		["angrathar"] = "210,0,306,242",
		["lakeindule"] = "217,313,356,300",
		["coldwindheights"] = "403,0,213,219",
	},
	["crystalsongforest"] = {
		["windrunnersoverlook"] = "444,383,558,285",
		["theunboundthicket"] = "500,105,502,477",
		["theazurefront"] = "0,244,416,424",
		["forlornwoods"] = "129,0,544,668",
		["violetstand"] = "0,176,264,303",
		["thegreattree"] = "0,91,252,260",
		["thedecrepitflow"] = "0,0,288,222",
		["sunreaverscommand"] = "536,40,446,369",
	},
	["howlingfjord"] = {
		["scalawagpoint"] = "168,410,350,258",
		["baleheim"] = "576,170,174,173",
		["giantsrun"] = "572,0,298,306",
		["halgrind"] = "397,208,187,263",
		["utgardekeep"] = "477,216,248,382",
		["vengeancelanding"] = "664,25,223,338",
		["nifflevar"] = "595,240,178,208",
		["emberclutch"] = "283,203,213,256",
		["ivaldsruin"] = "668,223,193,201",
		["cauldrosisle"] = "490,161,181,178",
		["fortwildervar"] = "490,0,251,192",
		["thetwistedglade"] = "420,57,266,210",
		["newagamand"] = "415,360,284,308",
		["baelgunsexcavationsite"] = "621,327,244,305",
		["apothecarycamp"] = "99,37,263,265",
		["ancientlift"] = "342,351,177,191",
		["kamagua"] = "99,278,333,265",
		["gjalerbron"] = "225,0,242,189",
		["explorersleagueoutpost"] = "585,336,232,216",
		["westguardkeep"] = "90,180,347,220",
		["skorn"] = "343,108,238,232",
		["campwinterhoof"] = "354,0,223,209",
		["steelgate"] = "222,100,222,168",
	},
	["zuldrak"] = {
		["zeramas"] = "7,412,307,256",
		["draksotrafields"] = "326,358,286,265",
		["altarofrhunok"] = "431,127,247,304",
		["altarofsseratus"] = "288,168,237,248",
		["kolramas"] = "380,437,302,231",
		["gundrak"] = "629,0,336,297",
		["altarofquetzlun"] = "607,251,261,288",
		["altarofharkoa"] = "533,345,265,257",
		["lightsbreach"] = "181,363,321,305",
		["thrymsend"] = "0,247,272,268",
		["amphitheaterofanguish"] = "289,287,266,254",
		["voltarus"] = "174,191,218,291",
		["altarofmamtoth"] = "575,88,291,258",
		["zimtorga"] = "479,241,249,258",
	},
	["grizzlyhills"] = {
		["grizzlemaw"] = "358,187,294,227",
		["voldrune"] = "176,421,283,247",
		["conquesthold"] = "17,307,332,294",
		["dunargol"] = "547,257,455,400",
		["ragefangshrine"] = "312,294,475,362",
		["drakiljinruins"] = "607,41,351,284",
		["venturebay"] = "18,461,274,207",
		["thormodan"] = "509,0,329,246",
		["granitesprings"] = "7,207,356,224",
		["blueskylogginggrounds"] = "232,129,249,235",
		["draktheronkeep"] = "0,46,382,285",
		["amberpinelodge"] = "217,244,278,290",
		["ursocsden"] = "331,32,328,260",
		["camponeqwah"] = "548,137,324,265",
	},
	["thestormpeaks"] = {
		["frosthold"] = "134,429,244,220",
		["templeofstorms"] = "239,301,169,164",
		["ulduar"] = "218,0,369,265",
		["sparksocketminefield"] = "242,468,251,200",
		["borsbreath"] = "109,375,322,195",
		["engineofthemakers"] = "316,296,210,179",
		["garmsbane"] = "395,470,184,191",
		["dunniffelem"] = "481,285,309,383",
		["narvirscradle"] = "214,144,180,239",
		["nidavelir"] = "108,206,221,200",
		["brunnhildarvillage"] = "339,370,305,298",
		["snowdriftplains"] = "162,143,205,232",
		["valkyrion"] = "98,318,228,158",
		["templeoflife"] = "570,113,182,270",
		["terraceofthemakers"] = "292,122,363,341",
		["thunderfall"] = "627,179,306,484",
	},
	["icecrownglacier"] = {
		["aldurthar"] = "355,37,373,375",
		["corprethar"] = "342,392,308,212",
		["thebombardment"] = "538,181,248,243",
		["onslaughtharbor"] = "0,167,204,268",
		["sindragosasfall"] = "626,31,300,343",
		["thefleshwerks"] = "218,291,219,283",
		["jotunheim"] = "22,122,393,474",
		["valleyofechoes"] = "715,390,269,217",
		["theconflagration"] = "327,305,227,210",
		["thebrokenfront"] = "558,329,283,231",
		["scourgeholme"] = "690,267,245,239",
		["ymirheim"] = "444,276,223,207",
		["theshadowvault"] = "321,15,223,399",
		["argenttournamentground"] = "616,30,314,224",
		["icecrowncitadel"] = "392,466,308,202",
		["valhalas"] = "217,50,238,240",
	},

	-- Patch 3.2
	["hrothgarslanding"] =
	{
--		["hrothgarslanding"] = "0,0,1024,768",
		["hrothgarslanding2"] = "256,0,256,256,1",	-- Just draw 4 parts
		["hrothgarslanding3"] = "512,0,256,256,1",
		["hrothgarslanding6"] = "256,256,256,256,1",
		["hrothgarslanding7"] = "512,256,256,256,1",
	},

	-- Cataclysm
	["tolbarad"] = {
		["tolbarad"] = "0,0,1024,768",	-- Manual
	},
	["tolbaraddailyarea"] = {
		["tolbaraddailyarea"] = "0,0,1024,768",	-- Manual
	},

	["themaelstrom"] = {
		["themaelstrom"] = "0,0,1024,768",	-- Manual
	},
	["thelostisles_terrain2"] = {
		["gallywixdocks"] = "351,21,173,180",
		["alliancebeachhead"] = "129,348,177,172",
		["bilgewaterlumberyard"] = "462,43,248,209",
		["thesavageglen"] = "213,325,231,216",
		["oostan"] = "492,161,210,258",
		["raptorrise"] = "416,368,168,205",
		["warchiefslookout"] = "264,144,159,230",
		["ooomlotvillage"] = "508,345,221,211",
		["scorchedgully"] = "323,185,305,288",
		["ktcoilplatform"] = "433,11,156,142",
		["hordebasecamp"] = "244,458,222,190",
		["lostpeak"] = "581,21,350,517",
		["shipwreckshore"] = "189,408,172,175",
		["skyfalls"] = "416,131,190,186",
		["ruinsofvashelan"] = "440,452,212,216",
		["landingsite"] = "377,359,142,133",
		["theslavepits"] = "279,68,212,193",
	},
	["kezan"] = {
		["bilgewaterport"] = "163,148,694,290",
		["firstbankofkezan"] = "98,325,376,343",
		["swindlestreet"] = "317,232,168,213",
		["theslick"] = "219,108,592,202",
		["kajamine"] = "586,308,354,360",
		["kajarofield"] = "383,260,250,307",
		["gallywixsvilla"] = "0,41,303,452",
		["kezanmap"] = "0,4,1002,664",
		["drudgetown"] = "180,367,351,301",
	},
	["deepholm"] = {
		["stonehearth"] = "0,314,371,354",
		["twilightterrace"] = "297,384,237,198",
		["scouredreach"] = "448,0,516,287",
		["needlerockchasm"] = "20,0,378,359",
		["stormsfurywreckage"] = "458,383,292,285",
		["twilightoverlook"] = "570,420,411,248",
		["deathwingsfall"] = "549,297,454,343",
		["thepaleroost"] = "85,0,467,273",
		["needlerockslag"] = "0,146,370,285",
		["theshatteredfield"] = "141,438,430,230",
		["therazanesthrone"] = "434,0,274,156",
		["crimsonexpanse"] = "540,12,462,400",
		["templeofearth"] = "287,177,355,345",
	},

	-- Patch 4.2
	["moltenfront"] = {
		["moltenfront"] = "0,0,1024,768",	-- Manual
	},
	-- Pandaria
 ["thejadeforest"] = {
    ["chuntianmonastery"] = "300,56,227,198",
    ["dawnsblossom"] = "325,178,234,210",
    ["dreamerspavillion"] = "474,520,218,148",
    ["emperorsomen"] = "430,21,202,204",
    ["glassfinvillage"] = "525,358,278,310",
    ["grookinmound"] = "182,214,253,229",
    ["hellscreamshope"] = "181,75,196,166",
    ["jademines"] = "400,146,236,142",
    ["nectarbreezeorchard"] = "290,330,219,256",
    ["nookanooka"] = "189,151,219,205",
    ["ruinsofganshi"] = "316,0,196,158",
    ["serpentsspine"] = "388,299,191,216",
    ["slingtailpits"] = "428,416,179,180",
    ["templeofthejadeserpent"] = "468,295,264,211",
    ["thearboretum"] = "481,215,242,210",
    ["waywardlanding"] = "346,482,219,186",
    ["windlessisle"] = "539,43,251,348",
    ["wreckoftheskyshark"] = "202,0,210,158",
  },
	["dreadwastes"] = {
		["klaxxivess"] = "458,110,236,204",
		["zanvess"] = "162,385,290,283",
		["brewgarden"] = "351,0,250,218",
		["dreadwaterlake"] = "437,313,322,211",
		["clutchesofshekzeer"] = "341,125,209,318",
		["horridmarch"] = "441,224,323,194",
		["brinymuck"] = "214,311,325,270",
		["soggysgamble"] = "450,406,268,241",
		["terraceofgurthan"] = "593,92,209,234",
		["rikkitunvillage"] = "236,32,218,186",
		["heartoffear"] = "191,122,262,293",
		["kyparivor"] = "485,0,325,190",
	},
	["krasarang"] = {
		["redwingrefuge"] = "317,63,212,265",
		["anglersoutpost"] = "545,205,265,194",
		["templeoftheredcrane"] = "300,215,219,259",
		["dojaniriver"] = "513,3,190,282",
		["krasarangcove"] = "701,19,286,268",
		["thedeepwild"] = "397,59,188,412",
		["lostdynasty"] = "589,27,217,279",
		["fallsongriver"] = "218,77,214,393",
		["thesouthernisles"] = "23,267,252,313",
		["zhusbastion"] = "612,0,306,204",
		["ruinsofdojan"] = "444,44,204,383",
		["theforbiddenjungle"] = "0,79,257,300",
		["ruinsofkorja"] = "125,88,211,395",
		["cradleofchiji"] = "176,376,272,250",
		["ungaingoo"] = "330,498,258,170",
		["nayelilagoon"] = "343,373,246,240",
	},
	["krasarang_terrain1"] = {
		["redwingrefuge"] = "317,63,212,265",
		["anglersoutpost"] = "545,205,265,194",
		["templeoftheredcrane"] = "300,215,219,259",
		["dojaniriver"] = "513,3,190,282",
		["krasarangcove"] = "701,19,295,293",
		["thedeepwild"] = "397,59,188,412",
		["lostdynasty"] = "589,27,217,279",
		["fallsongriver"] = "218,77,214,393",
		["thesouthernisles"] = "0,267,275,329",
		["zhusbastion"] = "612,0,306,204",
		["ruinsofdojan"] = "444,44,204,383",
		["theforbiddenjungle"] = "0,79,257,300",
		["ruinsofkorja"] = "125,88,211,395",
		["cradleofchiji"] = "176,376,272,250",
		["ungaingoo"] = "330,498,258,170",
		["nayelilagoon"] = "343,373,246,240",
	},	
	["kunlaisummit"] = {
		["binanvillage"] = "607,470,240,198",
		["mogujia"] = "462,411,253,208",
		["muskpawranch"] = "603,313,229,262",
		["mountneverset"] = "228,264,313,208",
		["zouchinvillage"] = "502,64,298,219",
		["templeofthewhitetiger"] = "587,170,250,260",
		["gateoftheaugust"] = "449,506,261,162",
		["shadopanmonastery"] = "88,92,385,385",
		["theburlaptrail"] = "398,310,310,276",
		["peakofserenity"] = "333,63,287,277",
		["valleyofemperors"] = "453,191,224,241",
		["kotapeak"] = "233,360,252,257",
		["iseoflostsouls"] = "602,4,259,233",
		["fireboughnook"] = "322,496,224,172",
	},	
	["valeofeternalblossoms"] = {
		["guolairuins"] = "87,3,337,349",
		["whitemoonshrine"] = "482,10,298,262",
		["mistfallvillage"] = "200,363,310,305",
		["settingsuntraining"] = "0,234,350,429",
		["tushenburialground"] = "349,316,267,308",
		["thestairsascent"] = "556,267,446,359",
		["winterboughglade"] = "4,107,361,333",
		["thegoldenstair"] = "328,16,242,254",
		["whitepetallake"] = "278,170,267,281",
		["thetwinmonoliths"] = "444,97,272,522",
		["mogushanpalace"] = "629,22,373,385",
	},
	["valleyofthefourwinds"] = {
		["thunderfootfields"] = "622,0,380,317",
		["poolsofpurity"] = "513,58,213,246",
		["rumblingterrace"] = "582,301,277,245",
		["paoquanhollow"] = "12,105,273,246",
		["stormsoutbrewery"] = "227,380,257,288",
		["dustbackgorge"] = "0,343,209,308",
		["cliffsofdispair"] = "215,404,510,264",
		["theheartland"] = "253,75,286,392",
		["silkenfields"] = "530,253,254,259",
		["harvesthome"] = "5,239,260,251",
		["gildedfan"] = "438,41,208,292",
		["grandgranery"] = "334,325,314,212",
		["singingmarshes"] = "170,130,175,291",
		["zhusdecent"] = "699,114,303,323",
		["halfhill"] = "438,177,206,245",
		["nesingwarysafari"] = "104,326,249,342",
		["mudmugsplace"] = "561,161,230,217",
		["kuzenvillage"] = "224,74,199,304",
	},
	["townlongwastes"] = {
		["niuzaotemple"] = "213,241,296,359",
		["shanzedao"] = "125,0,300,246",
		["thesumprushes"] = "545,369,271,205",
		["sikvess"] = "306,433,261,235",
		["gaoranblockade"] = "546,468,353,200",
		["mingchicrossroads"] = "417,447,247,221",
		["palewindvillage"] = "692,362,282,306",
		["osulmesa"] = "560,185,238,296",
		["shadopangarrison"] = "413,385,213,170",
		["krivess"] = "420,209,255,269",
		["srivess"] = "92,192,294,283",
	},
	["thewanderingisle"] = {
		["thedawningvalley"] = "325,0,677,667",
		["templeoffivedawns"] = "395,182,607,461",
		["mandorivillage"] = "392,294,610,374",
		["ridgeoflaughingwinds"] = "183,198,313,321",
		["pei-wuforest"] = "351,406,651,262",
		["poolofthepaw"] = "297,324,220,188",
		["skyfirecrash-site"] = "124,405,346,263",
		["therows"] = "504,295,385,373",
		["thesingingpools"] = "545,12,372,475",
		["morningbreezevillage"] = "203,36,261,315",
		["fe-fangvillage"] = "134,9,234,286",
		["thewoodofstaves"] = "13,202,989,466",
	},
	["darkmoonfaireisland"] = {
		["darkmoonfaireisland"] = "0,0,1024,768",
	},
	["thehiddenpass"] = {
		["thehiddencliffs"] = "443,0,294,220",
		["theblackmarket"] = "371,175,479,493",
		["thehiddensteps"] = "412,477,290,191",
	},

	["isleofgiants"] = {
		["isleofgiants"] = "0,0,1024,768",	-- Manual
	},
	["timelessisle"] = {
		["timelessisle"] = "0,0,1024,768",
	},
	["isleofthethunderking"] = {
		["isleofthethunderking"] = "0,0,1024,768",	-- Manual
		["HORDE"] = "183,95,278,325",
		["LOCK4"] = "396,9,446,429",
	},	
}

--------
-- OLD From Textures\Minimap\md5translate.trs
-- From art.mpq World\Minimaps

Map.OLMapBlks = {		-- Expansion01

	[1334] = "",
	[1335] = "",
	[1429] = "",
	[1430] = "",
	[1431] = "",
	[1432] = "",
	[1433] = "",
	[1434] = "",
	[1435] = "",
	[1436] = "",
	[1437] = "",
	[1528] = "",
	[1529] = "",
	[1530] = "",
	[1531] = "",
	[1532] = "",
	[1533] = "",
	[1534] = "",
	[1535] = "",
	[1536] = "",
	[1537] = "",
	[1538] = "",
	[1628] = "",
	[1629] = "",
	[1630] = "",
	[1631] = "",
	[1632] = "",
	[1633] = "",
	[1634] = "",
	[1635] = "",
	[1636] = "",
	[1637] = "",
	[1638] = "",
	[1725] = "",
	[1726] = "",
	[1727] = "",
	[1728] = "",
	[1729] = "",
	[1730] = "",
	[1731] = "",
	[1732] = "",
	[1733] = "",
	[1734] = "",
	[1735] = "",
	[1736] = "",
	[1737] = "",
	[1738] = "",
	[1824] = "",
	[1825] = "",
	[1826] = "",
	[1827] = "",
	[1828] = "",
	[1829] = "",
	[1830] = "",
	[1831] = "",
	[1832] = "",
	[1833] = "",
	[1834] = "",
	[1835] = "",
	[1836] = "",
	[1837] = "",
	[1838] = "",
	[1924] = "",
	[1925] = "",
	[1926] = "",
	[1927] = "",
	[1928] = "",
	[1929] = "",
	[1930] = "",
	[1931] = "",
	[1932] = "",
	[1933] = "",
	[1934] = "",
	[1935] = "",
	[1936] = "",
	[1937] = "",
	[1938] = "",
	[1939] = "",
	[1940] = "",
	[2024] = "",
	[2025] = "",
	[2026] = "",
	[2027] = "",
	[2028] = "",
	[2029] = "",
	[2030] = "",
	[2031] = "",
	[2032] = "",
	[2033] = "",
	[2034] = "",
	[2035] = "",
	[2036] = "",
	[2037] = "",
	[2038] = "",
	[2039] = "",
	[2040] = "",
	[2123] = "",
	[2124] = "",
	[2125] = "",
	[2126] = "",
	[2127] = "",
	[2128] = "",
	[2129] = "",
	[2130] = "",
	[2131] = "",
	[2132] = "",
	[2133] = "",
	[2134] = "",
	[2135] = "",
	[2136] = "",
	[2137] = "",
	[2138] = "",
	[2139] = "",
	[2140] = "",
	[2223] = "",
	[2224] = "",
	[2225] = "",
	[2226] = "",
	[2227] = "",
	[2228] = "",
	[2229] = "",
	[2230] = "",
	[2231] = "",
	[2232] = "",
	[2233] = "",
	[2234] = "",
	[2235] = "",
	[2236] = "",
	[2237] = "",
	[2238] = "",
	[2239] = "",
	[2240] = "",
	[2323] = "",
	[2324] = "",
	[2325] = "",
	[2326] = "",
	[2327] = "",
	[2328] = "",
	[2329] = "",
	[2330] = "",
	[2331] = "",
	[2332] = "",
	[2333] = "",
	[2334] = "",
	[2335] = "",
	[2336] = "",
	[2337] = "",
	[2338] = "",
	[2339] = "",
	[2340] = "",
	[2422] = "",
	[2423] = "",
	[2424] = "",
	[2425] = "",
	[2426] = "",
	[2427] = "",
	[2430] = "",
	[2431] = "",
	[2432] = "",
	[2433] = "",
	[2434] = "",
	[2435] = "",
	[2436] = "",
	[2437] = "",
	[2438] = "",
	[2439] = "",
	[2440] = "",
	[2522] = "",
	[2523] = "",
	[2524] = "",
	[2525] = "",
	[2526] = "",
	[2527] = "",
	[2528] = "",
	[2530] = "",
	[2531] = "",
	[2532] = "",
	[2533] = "",
	[2534] = "",
	[2535] = "",
	[2536] = "",
	[2537] = "",
	[2538] = "",
	[2539] = "",
	[2540] = "",
	[2622] = "",
	[2623] = "",
	[2624] = "",
	[2625] = "",
	[2626] = "",
	[2627] = "",
	[2628] = "",
	[2629] = "",
	[2630] = "",
	[2631] = "",
	[2632] = "",
	[2633] = "",
	[2634] = "",
	[2635] = "",
	[2636] = "",
	[2637] = "",
	[2638] = "",
	[2639] = "",
	[2640] = "",
	[2722] = "",
	[2723] = "",
	[2724] = "",
	[2725] = "",
	[2726] = "",
	[2727] = "",
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2732] = "",
	[2733] = "",
	[2734] = "",
	[2735] = "",
	[2736] = "",
	[2737] = "",
	[2738] = "",
	[2739] = "",
	[2740] = "",
	[2823] = "",
	[2824] = "",
	[2825] = "",
	[2826] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2833] = "",
	[2834] = "",
	[2836] = "",
	[2837] = "",
	[2838] = "",
	[2839] = "",
	[2840] = "",
	[2841] = "",
	[2923] = "",
	[2924] = "",
	[2925] = "",
	[2926] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[2933] = "",
	[2934] = "",
	[2936] = "",
	[2937] = "",
	[2938] = "",
	[2939] = "",
	[2940] = "",
	[2941] = "",
	[3026] = "",
	[3031] = "",
	[3032] = "",
	[3033] = "",
	[3034] = "",
	[3036] = "",
	[3037] = "",
	[3038] = "",
	[3039] = "",
	[3040] = "",
	[3041] = "",
	[3042] = "",
	[3132] = "",
	[3136] = "",
	[3137] = "",
	[3138] = "",
	[3139] = "",
	[3140] = "",
	[3141] = "",
	[3142] = "",
	[3237] = "",
	[3238] = "",
	[3239] = "",
	[3240] = "",
	[3241] = "",
	[3242] = "",
	[3337] = "",
	[3338] = "",
	[3339] = "",
}

Map.BloodelfMapBlks = {	-- Expansion01

--	[4010] = "",	-- Dark blue

	[4116] = "",
	[4117] = "",
	[4118] = "",

	[4211] = "",
	[4212] = "",
	[4213] = "",
	[4214] = "",
	[4215] = "",
	[4216] = "",
	[4217] = "",
	[4218] = "",
	[4219] = "",
	[4220] = "",
	[4221] = "",

	[4306] = "",
	[4307] = "",
	[4308] = "",
	[4309] = "",
	[4310] = "",
	[4311] = "",
	[4312] = "",
	[4313] = "",
	[4314] = "",
	[4315] = "",
	[4316] = "",
	[4317] = "",
	[4318] = "",
	[4319] = "",
	[4320] = "",
	[4321] = "",

	[4406] = "",
	[4407] = "",
	[4408] = "",
	[4409] = "",
	[4410] = "",
	[4411] = "",
	[4412] = "",
	[4413] = "",
	[4414] = "",
	[4415] = "",
	[4416] = "",
	[4417] = "",
	[4418] = "",
	[4419] = "",
	[4420] = "",
	[4421] = "",

	[4506] = "",
	[4507] = "",
	[4508] = "",
	[4509] = "",
	[4510] = "",
	[4511] = "",
	[4512] = "",
	[4513] = "",
	[4514] = "",
	[4515] = "",
	[4516] = "",
	[4517] = "",
	[4518] = "",
	[4519] = "",
	[4520] = "",
	[4521] = "",

	[4606] = "",
	[4607] = "",
	[4608] = "",
	[4609] = "",
	[4610] = "",
	[4611] = "",
	[4612] = "",
	[4613] = "",
	[4614] = "",
	[4615] = "",
	[4616] = "",
	[4617] = "",
	[4618] = "",
	[4619] = "",
	[4620] = "",
	[4621] = "",

	[4713] = "",
	[4714] = "",
	[4715] = "",
	[4716] = "",
	[4717] = "",
	[4718] = "",
	[4719] = "",
	[4720] = "",
}

Map.DraeneiMapBlks = {	-- Expansion01

	[5034] = "",
	[5035] = "",

	[5133] = "",
	[5134] = "",
	[5135] = "",
	[5136] = "",
	[5137] = "",
	[5140] = "",
	[5141] = "",
	[5142] = "",

	[5233] = "",
	[5234] = "",
	[5235] = "",
	[5236] = "",
	[5237] = "",
	[5238] = "",
	[5239] = "",
	[5240] = "",
	[5241] = "",
	[5242] = "",

	[5333] = "",
	[5334] = "",
	[5335] = "",
	[5336] = "",
	[5337] = "",
	[5338] = "",
	[5339] = "",
	[5340] = "",
	[5341] = "",
	[5342] = "",

	[5433] = "",
	[5434] = "",
	[5435] = "",
	[5436] = "",
	[5437] = "",
	[5438] = "",
	[5439] = "",
	[5440] = "",
	[5441] = "",

	[5533] = "",
	[5534] = "",
	[5535] = "",
	[5536] = "",
	[5537] = "",
	[5538] = "",
	[5539] = "",
	[5540] = "",
	[5541] = "",

	[5633] = "",
	[5634] = "",
	[5635] = "",
	[5636] = "",
	[5637] = "",
	[5638] = "",
	[5639] = "",
	[5640] = "",
	[5641] = "",

	[5737] = "",
	[5738] = "",
	[5739] = "",
	[5740] = "",
	[5741] = "",

	[5837] = "",
	[5838] = "",
	[5839] = "",
	[5840] = "",
	[5841] = "",

	[5938] = "",
	[5939] = "",
	[5940] = "",
}

Map.KalMapBlks = {	-- Kalimdor

	[2341] = "",
	[2342] = "",
	[2343] = "",
	[2344] = "",
	[2345] = "",

	[2439] = "",
	[2440] = "",
	[2441] = "",
	[2442] = "",
	[2443] = "",
	[2444] = "",
	[2445] = "",

	[2512] = "",
	[2513] = "",
	[2514] = "",
	[2515] = "",
	[2533] = "",
	[2534] = "",
	[2535] = "",
	[2536] = "",
	[2537] = "",
	[2538] = "",
	[2539] = "",
	[2540] = "",
	[2541] = "",
	[2542] = "",
	[2543] = "",
	[2544] = "",
	[2545] = "",
	[2546] = "",

	[2611] = "",
	[2612] = "",
	[2613] = "",
	[2614] = "",
	[2615] = "",
	[2616] = "",
	[2624] = "",
	[2625] = "",
	[2626] = "",
	[2627] = "",
	[2628] = "",
	[2629] = "",
	[2630] = "",
	[2631] = "",
	[2632] = "",
	[2633] = "",
	[2634] = "",
	[2635] = "",
	[2636] = "",
	[2637] = "",
	[2638] = "",
	[2639] = "",
	[2640] = "",
	[2641] = "",
	[2642] = "",
	[2643] = "",
	[2644] = "",
	[2645] = "",
	[2646] = "",
	[2647] = "",
	[2648] = "",
	[2649] = "",
	[2650] = "",
	[2651] = "",

	[2709] = "",
	[2710] = "",
	[2711] = "",
	[2712] = "",
	[2713] = "",
	[2714] = "",
	[2715] = "",
	[2716] = "",
	[2717] = "",
	[2718] = "",
	[2719] = "",
	[2720] = "",
	[2721] = "",
	[2722] = "",
	[2723] = "",
	[2724] = "",
	[2725] = "",
	[2726] = "",
	[2727] = "",
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2732] = "",
	[2733] = "",
	[2734] = "",
	[2735] = "",
	[2736] = "",
	[2737] = "",
	[2738] = "",
	[2739] = "",
	[2740] = "",
	[2741] = "",
	[2742] = "",
	[2743] = "",
	[2744] = "",
	[2745] = "",
	[2746] = "",
	[2747] = "",
	[2748] = "",
	[2749] = "",
	[2750] = "",
	[2751] = "",
	[2752] = "",

	[2809] = "",
	[2810] = "",
	[2811] = "",
	[2812] = "",
	[2813] = "",
	[2814] = "",
	[2815] = "",
	[2816] = "",
	[2817] = "",
	[2818] = "",
	[2819] = "",
	[2820] = "",
	[2821] = "",
	[2822] = "",
	[2823] = "",
	[2824] = "",
	[2825] = "",
	[2826] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2833] = "",
	[2834] = "",
	[2835] = "",
	[2836] = "",
	[2837] = "",
	[2838] = "",
	[2839] = "",
	[2840] = "",
	[2841] = "",
	[2842] = "",
	[2843] = "",
	[2844] = "",
	[2845] = "",
	[2846] = "",
	[2847] = "",
	[2848] = "",
	[2849] = "",
	[2850] = "",
	[2851] = "",
	[2852] = "",

	[2909] = "",
	[2910] = "",
	[2911] = "",
	[2912] = "",
	[2913] = "",
	[2914] = "",
	[2915] = "",
	[2916] = "",
	[2917] = "",
	[2918] = "",
	[2919] = "",
	[2920] = "",
	[2921] = "",
	[2922] = "",
	[2923] = "",
	[2924] = "",
	[2925] = "",
	[2926] = "",
	[2927] = "",
	[2928] = "",
	[2929] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[2933] = "",
	[2934] = "",
	[2935] = "",
	[2936] = "",
	[2937] = "",
	[2938] = "",
	[2939] = "",
	[2940] = "",
	[2941] = "",
	[2942] = "",
	[2943] = "",
	[2944] = "",
	[2945] = "",
	[2946] = "",
	[2947] = "",
	[2948] = "",
	[2949] = "",
	[2950] = "",
	[2951] = "",
	[2952] = "",

	[3009] = "",
	[3010] = "",
	[3011] = "",
	[3012] = "",
	[3013] = "",
	[3014] = "",
	[3015] = "",
	[3016] = "",
	[3017] = "",
	[3018] = "",
	[3019] = "",
	[3020] = "",
	[3021] = "",
	[3022] = "",
	[3023] = "",
	[3024] = "",
	[3025] = "",
	[3026] = "",
	[3027] = "",
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3032] = "",
	[3033] = "",
	[3034] = "",
	[3035] = "",
	[3036] = "",
	[3037] = "",
	[3038] = "",
	[3039] = "",
	[3040] = "",
	[3041] = "",
	[3042] = "",
	[3043] = "",
	[3044] = "",
	[3045] = "",
	[3046] = "",
	[3047] = "",
	[3048] = "",
	[3049] = "",
	[3050] = "",
	[3051] = "",
	[3052] = "",

	[3109] = "",
	[3110] = "",
	[3111] = "",
	[3112] = "",
	[3113] = "",
	[3114] = "",
	[3115] = "",
	[3116] = "",
	[3117] = "",
	[3118] = "",
	[3119] = "",
	[3120] = "",
	[3121] = "",
	[3122] = "",
	[3123] = "",
	[3124] = "",
	[3125] = "",
	[3126] = "",
	[3127] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
	[3132] = "",
	[3133] = "",
	[3134] = "",
	[3135] = "",
	[3136] = "",
	[3137] = "",
	[3138] = "",
	[3139] = "",
	[3140] = "",
	[3141] = "",
	[3142] = "",
	[3143] = "",
	[3144] = "",
	[3145] = "",
	[3146] = "",
	[3147] = "",
	[3148] = "",
	[3149] = "",
	[3150] = "",
	[3151] = "",
	[3152] = "",
	[3153] = "",

	[3210] = "",
	[3211] = "",
	[3212] = "",
	[3213] = "",
	[3214] = "",
	[3215] = "",
	[3216] = "",
	[3217] = "",
	[3218] = "",
	[3219] = "",
	[3220] = "",
	[3221] = "",
	[3222] = "",
	[3223] = "",
	[3224] = "",
	[3225] = "",
	[3226] = "",
	[3227] = "",
	[3228] = "",
	[3229] = "",
	[3230] = "",
	[3231] = "",
	[3232] = "",
	[3233] = "",
	[3234] = "",
	[3235] = "",
	[3236] = "",
	[3237] = "",
	[3238] = "",
	[3239] = "",
	[3240] = "",
	[3241] = "",
	[3242] = "",
	[3243] = "",
	[3244] = "",
	[3245] = "",
	[3246] = "",
	[3247] = "",
	[3248] = "",
	[3249] = "",
	[3250] = "",
	[3251] = "",
	[3252] = "",
	[3253] = "",

	[3311] = "",
	[3312] = "",
	[3313] = "",
	[3314] = "",
	[3315] = "",
	[3316] = "",
	[3317] = "",
	[3318] = "",
	[3319] = "",
	[3320] = "",
	[3321] = "",
	[3322] = "",
	[3323] = "",
	[3324] = "",
	[3325] = "",
	[3326] = "",
	[3327] = "",
	[3328] = "",
	[3329] = "",
	[3330] = "",
	[3331] = "",
	[3332] = "",
	[3333] = "",
	[3334] = "",
	[3335] = "",
	[3336] = "",
	[3337] = "",
	[3338] = "",
	[3339] = "",
	[3340] = "",
	[3341] = "",
	[3342] = "",
	[3343] = "",
	[3344] = "",
	[3345] = "",
	[3346] = "",
	[3347] = "",
	[3348] = "",
	[3349] = "",
	[3350] = "",
	[3351] = "",
	[3352] = "",
	[3353] = "",

	[3415] = "",
	[3416] = "",
	[3417] = "",
	[3418] = "",
	[3419] = "",
	[3420] = "",
	[3421] = "",
	[3422] = "",
	[3423] = "",
	[3424] = "",
	[3425] = "",
	[3426] = "",
	[3427] = "",
	[3428] = "",
	[3429] = "",
	[3430] = "",
	[3431] = "",
	[3432] = "",
	[3433] = "",
	[3434] = "",
	[3435] = "",
	[3436] = "",
	[3437] = "",
	[3438] = "",
	[3439] = "",
	[3440] = "",
	[3441] = "",
	[3442] = "",
	[3443] = "",
	[3444] = "",
	[3445] = "",
	[3446] = "",
	[3447] = "",
	[3448] = "",
	[3449] = "",
	[3450] = "",
	[3451] = "",
	[3452] = "",
	[3453] = "",

	[3515] = "",
	[3516] = "",
	[3517] = "",
	[3518] = "",
	[3519] = "",
	[3520] = "",
	[3521] = "",
	[3522] = "",
	[3523] = "",
	[3524] = "",
	[3525] = "",
	[3526] = "",
	[3527] = "",
	[3528] = "",
	[3529] = "",
	[3530] = "",
	[3531] = "",
	[3532] = "",
	[3533] = "",
	[3534] = "",
	[3535] = "",
	[3536] = "",
	[3537] = "",
	[3538] = "",
	[3539] = "",
	[3540] = "",
	[3541] = "",
	[3542] = "",
	[3543] = "",
	[3544] = "",
	[3545] = "",
	[3546] = "",
	[3547] = "",
	[3548] = "",
	[3549] = "",
	[3550] = "",
	[3551] = "",
	[3552] = "",
	[3553] = "",

	[3615] = "",
	[3616] = "",
	[3617] = "",
	[3618] = "",
	[3619] = "",
	[3620] = "",
	[3621] = "",
	[3622] = "",
	[3623] = "",
	[3624] = "",
	[3625] = "",
	[3626] = "",
	[3627] = "",
	[3628] = "",
	[3629] = "",
	[3630] = "",
	[3631] = "",
	[3632] = "",
	[3633] = "",
	[3634] = "",
	[3635] = "",
	[3636] = "",
	[3637] = "",
	[3638] = "",
	[3639] = "",
	[3640] = "",
	[3641] = "",
	[3642] = "",
	[3643] = "",
	[3644] = "",
	[3645] = "",
	[3646] = "",
	[3647] = "",
	[3648] = "",
	[3649] = "",
	[3650] = "",
	[3651] = "",
	[3652] = "",
	[3653] = "",

	[3714] = "",
	[3715] = "",
	[3716] = "",
	[3717] = "",
	[3718] = "",
	[3719] = "",
	[3720] = "",
	[3721] = "",
	[3722] = "",
	[3723] = "",
	[3724] = "",
	[3725] = "",
	[3726] = "",
	[3727] = "",
	[3728] = "",
	[3729] = "",
	[3730] = "",
	[3731] = "",
	[3732] = "",
	[3733] = "",
	[3734] = "",
	[3735] = "",
	[3736] = "",
	[3737] = "",
	[3738] = "",
	[3739] = "",
	[3740] = "",
	[3741] = "",
	[3742] = "",
	[3743] = "",
	[3744] = "",
	[3745] = "",
	[3746] = "",
	[3747] = "",
	[3748] = "",
	[3749] = "",
	[3750] = "",
	[3751] = "",
	[3752] = "",

	[3814] = "",
	[3815] = "",
	[3816] = "",
	[3817] = "",
	[3818] = "",
	[3819] = "",
	[3820] = "",
	[3821] = "",
	[3822] = "",
	[3823] = "",
	[3824] = "",
	[3825] = "",
	[3826] = "",
	[3827] = "",
	[3828] = "",
	[3829] = "",
	[3830] = "",
	[3831] = "",
	[3832] = "",
	[3833] = "",
	[3834] = "",
	[3835] = "",
	[3836] = "",
	[3837] = "",
	[3838] = "",
	[3839] = "",
	[3840] = "",
	[3841] = "",
	[3842] = "",
	[3843] = "",
	[3844] = "",
	[3845] = "",
	[3846] = "",
	[3847] = "",
	[3848] = "",
	[3849] = "",
	[3850] = "",
	[3851] = "",

	[3914] = "",
	[3915] = "",
	[3916] = "",
	[3917] = "",
	[3918] = "",
	[3919] = "",
	[3920] = "",
	[3921] = "",
	[3922] = "",
	[3923] = "",
	[3924] = "",
	[3925] = "",
	[3926] = "",
	[3927] = "",
	[3928] = "",
	[3929] = "",
	[3930] = "",
	[3931] = "",
	[3932] = "",
	[3933] = "",
	[3934] = "",
	[3935] = "",
	[3936] = "",
	[3937] = "",
	[3938] = "",
	[3939] = "",
	[3940] = "",
	[3941] = "",
	[3942] = "",
	[3943] = "",
	[3944] = "",
	[3945] = "",
	[3946] = "",
	[3947] = "",
	[3948] = "",
	[3949] = "",
	[3950] = "",
	[3951] = "",

	[4014] = "",
	[4015] = "",
	[4016] = "",
	[4017] = "",
	[4018] = "",
	[4019] = "",
	[4020] = "",
	[4021] = "",
	[4022] = "",
	[4023] = "",
	[4024] = "",
	[4025] = "",
	[4026] = "",
	[4027] = "",
	[4028] = "",
	[4029] = "",
	[4030] = "",
	[4031] = "",
	[4032] = "",
	[4033] = "",
	[4034] = "",
	[4035] = "",
	[4036] = "",
	[4037] = "",
	[4038] = "",
	[4039] = "",
	[4040] = "",
	[4041] = "",
	[4042] = "",
	[4043] = "",
	[4044] = "",
	[4045] = "",
	[4046] = "",
	[4047] = "",
	[4048] = "",
	[4049] = "",
	[4050] = "",
	[4051] = "",

	[4115] = "",
	[4116] = "",
	[4117] = "",
	[4118] = "",
	[4119] = "",
	[4120] = "",
	[4121] = "",
	[4122] = "",
	[4123] = "",
	[4124] = "",
	[4125] = "",
	[4126] = "",
	[4127] = "",
	[4128] = "",
	[4129] = "",
	[4130] = "",
	[4131] = "",
	[4132] = "",
	[4133] = "",
	[4134] = "",
	[4135] = "",
	[4136] = "",
	[4137] = "",
	[4138] = "",
	[4139] = "",
	[4140] = "",
	[4141] = "",
	[4142] = "",
	[4143] = "",
	[4144] = "",
	[4145] = "",
	[4146] = "",
	[4147] = "",
	[4148] = "",
	[4149] = "",
	[4150] = "",
	[4151] = "",

	[4216] = "",
	[4217] = "",
	[4218] = "",
	[4219] = "",
	[4220] = "",
	[4221] = "",
	[4222] = "",
	[4223] = "",
	[4224] = "",
	[4225] = "",
	[4226] = "",
	[4227] = "",
	[4228] = "",
	[4229] = "",
	[4230] = "",
	[4231] = "",
	[4232] = "",
	[4233] = "",
	[4234] = "",
	[4235] = "",
	[4236] = "",
	[4237] = "",
	[4238] = "",
	[4239] = "",
	[4240] = "",
	[4241] = "",
	[4242] = "",
	[4243] = "",
	[4244] = "",
	[4245] = "",
	[4246] = "",
	[4247] = "",
	[4248] = "",
	[4249] = "",
	[4250] = "",
	[4251] = "",

	[4316] = "",
	[4317] = "",
	[4318] = "",
	[4319] = "",
	[4320] = "",
	[4321] = "",
	[4322] = "",
	[4323] = "",
	[4324] = "",
	[4325] = "",
	[4326] = "",
	[4327] = "",
	[4328] = "",
	[4329] = "",
	[4330] = "",
	[4331] = "",
	[4332] = "",
	[4333] = "",
	[4334] = "",
	[4335] = "",
	[4344] = "",
	[4345] = "",
	[4346] = "",
	[4347] = "",
	[4348] = "",
	[4349] = "",

	[4421] = "",
	[4422] = "",
	[4423] = "",
	[4424] = "",
	[4425] = "",
	[4426] = "",
	[4427] = "",
	[4428] = "",
	[4429] = "",

	[4521] = "",
	[4522] = "",
	[4523] = "",
	[4524] = "",
	[4525] = "",
	[4526] = "",
	[4527] = "",
	[4528] = "",
	[4529] = "",

	[4621] = "",
	[4622] = "",
	[4623] = "",
	[4624] = "",
	[4625] = "",
	[4626] = "",
	[4627] = "",
	[4628] = "",
	[4629] = "",

	[4722] = "",
	[4723] = "",
	[4724] = "",
}

Map.EkMapBlks = {

	-- Use noLiquid maps
	[1741] = "1",
	[1742] = "1",
	[1743] = "1",
	[1744] = "1",
	[1745] = "1",
	[1746] = "1",
	[1841] = "1",
	[1842] = "1",
	[1843] = "1",
	[1844] = "1",
	[1845] = "1",
	[1846] = "1",
	[1941] = "1",
	[1942] = "1",
	[1943] = "1",
	[1944] = "1",
	[1945] = "1",
	[1946] = "1",
	[2039] = "1",
	[2040] = "1",
	[2041] = "1",
	[2042] = "1",
	[2043] = "1",
	[2044] = "1",
	[2045] = "1",
	[2046] = "1",
	[2139] = "1",
	[2140] = "1",
	[2141] = "1",
	[2142] = "1",
	[2143] = "1",
	[2144] = "1",
	[2145] = "1",
	[2146] = "1",
	[2239] = "1",
	[2240] = "1",
	[2241] = "1",
	[2242] = "1",
	[2243] = "1",
	[2244] = "1",
	[2245] = "1",
	[2246] = "1",
	[2339] = "1",
	[2340] = "1",
	[2341] = "1",
	[2342] = "1",
	[2343] = "1",
	[2344] = "1",
	[2345] = "1",
	[2346] = "1",
	[2439] = "1",
	[2440] = "1",
	[2441] = "1",
	[2442] = "1",
	[2443] = "1",
	[2444] = "1",
	[2445] = "1",
	[2446] = "1",
	[2539] = "1",
	[2540] = "1",
	[2541] = "1",
	[2542] = "1",
	[2543] = "1",
	[2544] = "1",
	[2545] = "1",
	[2546] = "1",
	[2639] = "1",
	[2640] = "1",
	[2641] = "1",
	[2642] = "1",
	[2643] = "1",
	[2644] = "1",
	[2645] = "1",

	[2627] = "",
	[2628] = "",
	[2629] = "",
	[2630] = "",
	[2631] = "",
	[2632] = "",
	[2633] = "",
	[2634] = "",
	[2635] = "",
	[2636] = "",
	[2637] = "",
	[2652] = "",
	[2653] = "",
	[2654] = "",

	[2726] = "",
	[2727] = "",
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2732] = "",
	[2733] = "",
	[2734] = "",
	[2735] = "",
	[2736] = "",
	[2737] = "",
	[2749] = "",
	[2750] = "",
	[2751] = "",
	[2752] = "",
	[2753] = "",
	[2754] = "",

	[2825] = "",
	[2826] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2833] = "",
	[2834] = "",
	[2835] = "",
	[2836] = "",
	[2837] = "",
	[2838] = "",
	[2839] = "",
	[2840] = "",
	[2841] = "",
	[2842] = "",
	[2843] = "",
	[2844] = "",
	[2845] = "",
	[2846] = "",
	[2847] = "",
	[2848] = "",
	[2849] = "",
	[2850] = "",
	[2851] = "",
	[2852] = "",
	[2853] = "",
	[2854] = "",
	[2855] = "",
	[2856] = "",
	[2857] = "",
	[2858] = "",
	[2859] = "",

	[2925] = "",
	[2926] = "",
	[2927] = "",
	[2928] = "",
	[2929] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[2933] = "",
	[2934] = "",
	[2935] = "",
	[2936] = "",
	[2937] = "",
	[2938] = "",
	[2939] = "",
	[2940] = "",
	[2941] = "",
	[2942] = "",
	[2943] = "",
	[2944] = "",
	[2945] = "",
	[2946] = "",
	[2947] = "",
	[2948] = "",
	[2949] = "",
	[2950] = "",
	[2951] = "",
	[2952] = "",
	[2953] = "",
	[2954] = "",
	[2955] = "",
	[2956] = "",
	[2957] = "",
	[2958] = "",
	[2959] = "",
	[2960] = "",

	[3025] = "",
	[3026] = "",
	[3027] = "",
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3032] = "",
	[3033] = "",
	[3034] = "",
	[3035] = "",
	[3036] = "",
	[3037] = "",
	[3038] = "",
	[3039] = "",
	[3040] = "",
	[3041] = "",
	[3042] = "",
	[3043] = "",
	[3044] = "",
	[3045] = "",
	[3046] = "",
	[3047] = "",
	[3048] = "",
	[3049] = "",
	[3050] = "",
	[3051] = "",
	[3052] = "",
	[3053] = "",
	[3054] = "",
	[3055] = "",
	[3056] = "",
	[3057] = "",
	[3058] = "",
	[3059] = "",
	[3060] = "",

	[3125] = "",
	[3126] = "",
	[3127] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
	[3132] = "",
	[3133] = "",
	[3134] = "",
	[3135] = "",
	[3136] = "",
	[3137] = "",
	[3138] = "",
	[3139] = "",
	[3140] = "",
	[3141] = "",
	[3142] = "",
	[3143] = "",
	[3144] = "",
	[3145] = "",
	[3146] = "",
	[3147] = "",
	[3148] = "",
	[3149] = "",
	[3150] = "",
	[3151] = "",
	[3152] = "",
	[3153] = "",
	[3154] = "",
	[3155] = "",
	[3156] = "",
	[3157] = "",
	[3158] = "",
	[3159] = "",
	[3160] = "",

	[3225] = "",
	[3226] = "",
	[3227] = "",
	[3228] = "",
	[3229] = "",
	[3230] = "",
	[3231] = "",
	[3232] = "",
	[3233] = "",
	[3234] = "",
	[3235] = "",
	[3236] = "",
	[3237] = "",
	[3238] = "",
	[3239] = "",
	[3240] = "",
	[3241] = "",
	[3242] = "",
	[3243] = "",
	[3244] = "",
	[3245] = "",
	[3246] = "",
	[3247] = "",
	[3248] = "",
	[3249] = "",
	[3250] = "",
	[3251] = "",
	[3252] = "",
	[3253] = "",
	[3254] = "",
	[3255] = "",
	[3256] = "",
	[3257] = "",
	[3258] = "",
	[3259] = "",
	[3260] = "",

	[3325] = "",
	[3326] = "",
	[3327] = "",
	[3328] = "",
	[3329] = "",
	[3330] = "",
	[3331] = "",
	[3332] = "",
	[3333] = "",
	[3334] = "",
	[3335] = "",
	[3336] = "",
	[3337] = "",
	[3338] = "",
	[3339] = "",
	[3340] = "",
	[3341] = "",
	[3342] = "",
	[3343] = "",
	[3344] = "",
	[3345] = "",
	[3346] = "",
	[3347] = "",
	[3348] = "",
	[3349] = "",
	[3350] = "",
	[3351] = "",
	[3352] = "",
	[3353] = "",
	[3354] = "",
	[3355] = "",
	[3356] = "",
	[3357] = "",
	[3358] = "",
	[3359] = "",
	[3360] = "",

	[3425] = "",
	[3426] = "",
	[3427] = "",
	[3428] = "",
	[3429] = "",
	[3430] = "",
	[3431] = "",
	[3432] = "",
	[3433] = "",
	[3434] = "",
	[3435] = "",
	[3436] = "",
	[3437] = "",
	[3438] = "",
	[3439] = "",
	[3440] = "",
	[3441] = "",
	[3442] = "",
	[3443] = "",
	[3444] = "",
	[3445] = "",
	[3446] = "",
	[3447] = "",
	[3448] = "",
	[3449] = "",
	[3450] = "",
	[3451] = "",
	[3452] = "",
	[3453] = "",
	[3454] = "",
	[3455] = "",
	[3456] = "",
	[3457] = "",
	[3458] = "",
	[3459] = "",
	[3460] = "",

	[3524] = "",
	[3525] = "",
	[3526] = "",
	[3527] = "",
	[3528] = "",
	[3529] = "",
	[3530] = "",
	[3531] = "",
	[3532] = "",
	[3533] = "",
	[3534] = "",
	[3535] = "",
	[3536] = "",
	[3537] = "",
	[3538] = "",
	[3539] = "",
	[3540] = "",
	[3541] = "",
	[3542] = "",
	[3543] = "",
	[3544] = "",
	[3545] = "",
	[3546] = "",
	[3547] = "",
	[3548] = "",
	[3549] = "",
	[3550] = "",
	[3551] = "",
	[3552] = "",
	[3553] = "",
	[3554] = "",
	[3555] = "",
	[3556] = "",
	[3557] = "",
	[3558] = "",

	[3623] = "",
	[3624] = "",
	[3625] = "",
	[3626] = "",
	[3627] = "",
	[3628] = "",
	[3629] = "",
	[3630] = "",
	[3631] = "",
	[3632] = "",
	[3633] = "",
	[3634] = "",
	[3635] = "",
	[3636] = "",
	[3637] = "",
	[3638] = "",
	[3639] = "",
	[3640] = "",
	[3641] = "",
	[3642] = "",
	[3643] = "",
	[3644] = "",
	[3645] = "",
	[3646] = "",
	[3647] = "",
	[3648] = "",
	[3649] = "",
	[3650] = "",
	[3651] = "",
	[3652] = "",
	[3653] = "",
	[3654] = "",
	[3655] = "",
	[3656] = "",

	[3723] = "",
	[3724] = "",
	[3725] = "",
	[3726] = "",
	[3727] = "",
	[3728] = "",
	[3729] = "",
	[3730] = "",
	[3731] = "",
	[3732] = "",
	[3733] = "",
	[3734] = "",
	[3735] = "",
	[3736] = "",
	[3737] = "",
	[3738] = "",
	[3739] = "",
	[3740] = "",
	[3741] = "",
	[3742] = "",
	[3743] = "",
	[3744] = "",
	[3745] = "",
	[3746] = "",
	[3747] = "",
	[3748] = "",
	[3749] = "",
	[3750] = "",
	[3751] = "",
	[3752] = "",
	[3753] = "",
	[3754] = "",
	[3755] = "",
	[3756] = "",

	[3823] = "",
	[3824] = "",
	[3825] = "",
	[3826] = "",
	[3827] = "",
	[3828] = "",
	[3829] = "",
	[3830] = "",
	[3831] = "",
	[3832] = "",
	[3833] = "",
	[3834] = "",
	[3835] = "",
	[3836] = "",
	[3837] = "",
	[3838] = "",
	[3839] = "",
	[3840] = "",
	[3841] = "",
	[3842] = "",
	[3843] = "",
	[3844] = "",
	[3845] = "",
	[3846] = "",
	[3847] = "",
	[3848] = "",
	[3849] = "",
	[3850] = "",
	[3851] = "",
	[3852] = "",
	[3853] = "",
	[3854] = "",
	[3855] = "",

	[3923] = "",
	[3924] = "",
	[3925] = "",
	[3926] = "",
	[3927] = "",
	[3928] = "",
	[3929] = "",
	[3930] = "",
	[3931] = "",
	[3932] = "",
	[3933] = "",
	[3934] = "",
	[3935] = "",
	[3936] = "",
	[3937] = "",
	[3938] = "",
	[3939] = "",
	[3940] = "",
	[3941] = "",
	[3942] = "",
	[3943] = "",
	[3944] = "",
	[3945] = "",
	[3946] = "",
	[3947] = "",
	[3948] = "",
	[3949] = "",
	[3950] = "",
	[3951] = "",
	[3952] = "",
	[3953] = "",
	[3954] = "",
	[3955] = "",

	[4023] = "",
	[4024] = "",
	[4025] = "",
	[4026] = "",
	[4027] = "",
	[4028] = "",
	[4029] = "",
	[4030] = "",
	[4031] = "",
	[4032] = "",
	[4033] = "",
	[4034] = "",
	[4035] = "",
	[4036] = "",
	[4037] = "",
	[4038] = "",
	[4039] = "",
	[4040] = "",
	[4041] = "",
	[4042] = "",
	[4043] = "",
	[4044] = "",
	[4045] = "",
	[4046] = "",
	[4047] = "",
	[4048] = "",
	[4049] = "",
	[4050] = "",
	[4051] = "",
	[4052] = "",
	[4053] = "",

	[4123] = "",
	[4124] = "",
	[4125] = "",
	[4126] = "",
	[4127] = "",
	[4128] = "",
	[4129] = "",
	[4130] = "",
	[4131] = "",
	[4132] = "",
	[4133] = "",
	[4136] = "",
	[4137] = "",
	[4138] = "",
	[4139] = "",
	[4140] = "",
	[4141] = "",
	[4142] = "",
	[4143] = "",
	[4144] = "",
	[4145] = "",
	[4146] = "",
	[4147] = "",
	[4148] = "",
	[4149] = "",
	[4150] = "",
	[4151] = "",
	[4152] = "",

	[4224] = "",
	[4225] = "",
	[4226] = "",
	[4227] = "",
	[4228] = "",
	[4229] = "",
	[4230] = "",
	[4236] = "",
	[4237] = "",
	[4238] = "",
	[4239] = "",
	[4240] = "",
	[4241] = "",
	[4242] = "",

	[4325] = "",
	[4326] = "",
	[4327] = "",
	[4328] = "",
	[4329] = "",
	[4336] = "",
	[4337] = "",
	[4338] = "",
	[4339] = "",
	[4340] = "",
	[4341] = "",

	[4425] = "",
	[4426] = "",
	[4436] = "",
	[4437] = "",
	[4438] = "",
	[4439] = "",
	[4440] = "",
	[4441] = "",
}

Map.NRMapBlks = {	-- Northrend
	[1609] = "",
	[1610] = "",
	[1611] = "",
	[1612] = "",
	[1613] = "",
	[1614] = "",
	[1615] = "",
	[1616] = "",
	[1617] = "",
	[1618] = "",
	[1619] = "",
	[1620] = "",
	[1621] = "",
	[1622] = "",
	[1623] = "",
	[1624] = "",
	[1625] = "",
	[1626] = "",
	[1627] = "",
	[1628] = "",
	[1629] = "",
	[1630] = "",
	[1631] = "",
	[1632] = "",
	[1633] = "",
	[1709] = "",
	[1710] = "",
	[1711] = "",
	[1712] = "",
	[1713] = "",
	[1714] = "",
	[1715] = "",
	[1716] = "",
	[1717] = "",
	[1718] = "",
	[1719] = "",
	[1720] = "",
	[1721] = "",
	[1722] = "",
	[1723] = "",
	[1724] = "",
	[1725] = "",
	[1726] = "",
	[1727] = "",
	[1728] = "",
	[1729] = "",
	[1730] = "",
	[1731] = "",
	[1732] = "",
	[1733] = "",
	[1809] = "",
	[1810] = "",
	[1811] = "",
	[1812] = "",
	[1813] = "",
	[1814] = "",
	[1815] = "",
	[1816] = "",
	[1817] = "",
	[1818] = "",
	[1819] = "",
	[1820] = "",
	[1821] = "",
	[1822] = "",
	[1823] = "",
	[1824] = "",
	[1825] = "",
	[1826] = "",
	[1827] = "",
	[1828] = "",
	[1829] = "",
	[1830] = "",
	[1831] = "",
	[1832] = "",
	[1833] = "",
	[1909] = "",
	[1910] = "",
	[1911] = "",
	[1912] = "",
	[1913] = "",
	[1914] = "",
	[1915] = "",
	[1916] = "",
	[1917] = "",
	[1918] = "",
	[1919] = "",
	[1920] = "",
	[1921] = "",
	[1922] = "",
	[1923] = "",
	[1924] = "",
	[1925] = "",
	[1926] = "",
	[1927] = "",
	[1928] = "",
	[1929] = "",
	[1930] = "",
	[1931] = "",
	[1932] = "",
	[1933] = "",
	[2009] = "",
	[2010] = "",
	[2011] = "",
	[2012] = "",
	[2013] = "",
	[2014] = "",
	[2015] = "",
	[2016] = "",
	[2017] = "",
	[2018] = "",
	[2019] = "",
	[2020] = "",
	[2021] = "",
	[2022] = "",
	[2023] = "",
	[2024] = "",
	[2025] = "",
	[2026] = "",
	[2027] = "",
	[2028] = "",
	[2029] = "",
	[2030] = "",
	[2031] = "",
	[2032] = "",
	[2033] = "",
	[2109] = "",
	[2110] = "",
	[2111] = "",
	[2112] = "",
	[2113] = "",
	[2114] = "",
	[2115] = "",
	[2116] = "",
	[2117] = "",
	[2118] = "",
	[2119] = "",
	[2120] = "",
	[2121] = "",
	[2122] = "",
	[2123] = "",
	[2124] = "",
	[2125] = "",
	[2126] = "",
	[2127] = "",
	[2128] = "",
	[2129] = "",
	[2130] = "",
	[2131] = "",
	[2132] = "",
	[2133] = "",
	[2209] = "",
	[2210] = "",
	[2211] = "",
	[2212] = "",
	[2213] = "",
	[2214] = "",
	[2215] = "",
	[2216] = "",
	[2217] = "",
	[2218] = "",
	[2219] = "",
	[2220] = "",
	[2221] = "",
	[2222] = "",
	[2223] = "",
	[2224] = "",
	[2225] = "",
	[2226] = "",
	[2227] = "",
	[2228] = "",
	[2229] = "",
	[2230] = "",
	[2231] = "",
	[2232] = "",
	[2233] = "",
	[2309] = "",
	[2310] = "",
	[2311] = "",
	[2312] = "",
	[2313] = "",
	[2314] = "",
	[2315] = "",
	[2316] = "",
	[2317] = "",
	[2318] = "",
	[2319] = "",
	[2320] = "",
	[2321] = "",
	[2322] = "",
	[2323] = "",
	[2324] = "",
	[2325] = "",
	[2326] = "",
	[2327] = "",
	[2328] = "",
	[2329] = "",
	[2330] = "",
	[2331] = "",
	[2332] = "",
	[2333] = "",
	[2409] = "",
	[2410] = "",
	[2411] = "",
	[2412] = "",
	[2413] = "",
	[2414] = "",
	[2415] = "",
	[2416] = "",
	[2417] = "",
	[2418] = "",
	[2419] = "",
	[2420] = "",
	[2421] = "",
	[2422] = "",
	[2423] = "",
	[2424] = "",
	[2425] = "",
	[2426] = "",
	[2427] = "",
	[2428] = "",
	[2429] = "",
	[2430] = "",
	[2431] = "",
	[2432] = "",
	[2433] = "",
	[2509] = "",
	[2510] = "",
	[2511] = "",
	[2512] = "",
	[2513] = "",
	[2514] = "",
	[2515] = "",
	[2516] = "",
	[2517] = "",
	[2518] = "",
	[2519] = "",
	[2520] = "",
	[2521] = "",
	[2522] = "",
	[2523] = "",
	[2524] = "",
	[2525] = "",
	[2526] = "",
	[2527] = "",
	[2528] = "",
	[2529] = "",
	[2530] = "",
	[2531] = "",
	[2532] = "",
	[2533] = "",
	[2609] = "",
	[2610] = "",
	[2611] = "",
	[2612] = "",
	[2613] = "",
	[2614] = "",
	[2615] = "",
	[2616] = "",
	[2617] = "",
	[2618] = "",
	[2619] = "",
	[2620] = "",
	[2621] = "",
	[2622] = "",
	[2623] = "",
	[2624] = "",
	[2625] = "",
	[2626] = "",
	[2627] = "",
	[2628] = "",
	[2629] = "",
	[2630] = "",
	[2631] = "",
	[2632] = "",
	[2633] = "",
	[2709] = "",
	[2710] = "",
	[2711] = "",
	[2712] = "",
	[2713] = "",
	[2714] = "",
	[2715] = "",
	[2716] = "",
	[2717] = "",
	[2718] = "",
	[2719] = "",
	[2720] = "",
	[2721] = "",
	[2722] = "",
	[2723] = "",
	[2724] = "",
	[2725] = "",
	[2726] = "",
	[2727] = "",
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2732] = "",
	[2733] = "",
	[2809] = "",
	[2810] = "",
	[2811] = "",
	[2812] = "",
	[2813] = "",
	[2814] = "",
	[2815] = "",
	[2816] = "",
	[2817] = "",
	[2818] = "",
	[2819] = "",
	[2820] = "",
	[2821] = "",
	[2822] = "",
	[2823] = "",
	[2824] = "",
	[2825] = "",
	[2826] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2833] = "",
	[2909] = "",
	[2910] = "",
	[2911] = "",
	[2912] = "",
	[2913] = "",
	[2914] = "",
	[2915] = "",
	[2916] = "",
	[2917] = "",
	[2918] = "",
	[2919] = "",
	[2920] = "",
	[2921] = "",
	[2922] = "",
	[2923] = "",
	[2924] = "",
	[2925] = "",
	[2926] = "",
	[2927] = "",
	[2928] = "",
	[2929] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[2933] = "",
	[3009] = "",
	[3010] = "",
	[3011] = "",
	[3012] = "",
	[3013] = "",
	[3014] = "",
	[3015] = "",
	[3016] = "",
	[3017] = "",
	[3018] = "",
	[3019] = "",
	[3020] = "",
	[3021] = "",
	[3022] = "",
	[3023] = "",
	[3024] = "",
	[3025] = "",
	[3026] = "",
	[3027] = "",
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3032] = "",
	[3033] = "",
	[3109] = "",
	[3110] = "",
	[3111] = "",
	[3112] = "",
	[3113] = "",
	[3114] = "",
	[3115] = "",
	[3116] = "",
	[3117] = "",
	[3118] = "",
	[3119] = "",
	[3120] = "",
	[3121] = "",
	[3122] = "",
	[3123] = "",
	[3124] = "",
	[3125] = "",
	[3126] = "",
	[3127] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
	[3132] = "",
	[3133] = "",
	[3209] = "",
	[3210] = "",
	[3211] = "",
	[3212] = "",
	[3213] = "",
	[3214] = "",
	[3215] = "",
	[3216] = "",
	[3217] = "",
	[3218] = "",
	[3219] = "",
	[3220] = "",
	[3221] = "",
	[3222] = "",
	[3223] = "",
	[3224] = "",
	[3225] = "",
	[3226] = "",
	[3227] = "",
	[3228] = "",
	[3229] = "",
	[3230] = "",
	[3231] = "",
	[3232] = "",
	[3233] = "",
	[3309] = "",
	[3310] = "",
	[3311] = "",
	[3312] = "",
	[3313] = "",
	[3314] = "",
	[3315] = "",
	[3316] = "",
	[3317] = "",
	[3318] = "",
	[3319] = "",
	[3320] = "",
	[3321] = "",
	[3322] = "",
	[3323] = "",
	[3324] = "",
	[3325] = "",
	[3326] = "",
	[3327] = "",
	[3328] = "",
	[3329] = "",
	[3330] = "",
	[3331] = "",
	[3332] = "",
	[3333] = "",
	[3409] = "",
	[3410] = "",
	[3411] = "",
	[3412] = "",
	[3413] = "",
	[3414] = "",
	[3415] = "",
	[3416] = "",
	[3417] = "",
	[3418] = "",
	[3419] = "",
	[3420] = "",
	[3421] = "",
	[3422] = "",
	[3423] = "",
	[3424] = "",
	[3425] = "",
	[3426] = "",
	[3427] = "",
	[3428] = "",
	[3429] = "",
	[3430] = "",
	[3431] = "",
	[3432] = "",
	[3433] = "",
	[3509] = "",
	[3510] = "",
	[3511] = "",
	[3512] = "",
	[3513] = "",
	[3514] = "",
	[3515] = "",
	[3516] = "",
	[3517] = "",
	[3518] = "",
	[3519] = "",
	[3520] = "",
	[3521] = "",
	[3522] = "",
	[3523] = "",
	[3524] = "",
	[3525] = "",
	[3526] = "",
	[3527] = "",
	[3528] = "",
	[3529] = "",
	[3530] = "",
	[3531] = "",
	[3532] = "",
	[3533] = "",
	[3609] = "",
	[3610] = "",
	[3611] = "",
	[3612] = "",
	[3613] = "",
	[3614] = "",
	[3615] = "",
	[3616] = "",
	[3617] = "",
	[3618] = "",
	[3619] = "",
	[3620] = "",
	[3621] = "",
	[3622] = "",
	[3623] = "",
	[3624] = "",
	[3625] = "",
	[3626] = "",
	[3627] = "",
	[3628] = "",
	[3629] = "",
	[3630] = "",
	[3631] = "",
	[3632] = "",
	[3633] = "",
	[3709] = "",
	[3710] = "",
	[3711] = "",
	[3712] = "",
	[3713] = "",
	[3714] = "",
	[3715] = "",
	[3716] = "",
	[3717] = "",
	[3718] = "",
	[3719] = "",
	[3720] = "",
	[3721] = "",
	[3722] = "",
	[3723] = "",
	[3724] = "",
	[3725] = "",
	[3726] = "",
	[3727] = "",
	[3728] = "",
	[3729] = "",
	[3730] = "",
	[3731] = "",
	[3732] = "",
	[3733] = "",
	[3809] = "",
	[3810] = "",
	[3811] = "",
	[3812] = "",
	[3813] = "",
	[3814] = "",
	[3815] = "",
	[3816] = "",
	[3817] = "",
	[3818] = "",
	[3819] = "",
	[3820] = "",
	[3821] = "",
	[3822] = "",
	[3823] = "",
	[3824] = "",
	[3825] = "",
	[3826] = "",
	[3827] = "",
	[3828] = "",
	[3829] = "",
	[3830] = "",
	[3831] = "",
	[3832] = "",
	[3833] = "",
	[3909] = "",
	[3910] = "",
	[3911] = "",
	[3912] = "",
	[3913] = "",
	[3914] = "",
	[3915] = "",
	[3916] = "",
	[3917] = "",
	[3918] = "",
	[3919] = "",
	[3920] = "",
	[3921] = "",
	[3922] = "",
	[3923] = "",
	[3924] = "",
	[3925] = "",
	[3926] = "",
	[3927] = "",
	[3928] = "",
	[3929] = "",
	[3930] = "",
	[3931] = "",
	[3932] = "",
	[3933] = "",
	[4009] = "",
	[4010] = "",
	[4011] = "",
	[4012] = "",
	[4013] = "",
	[4014] = "",
	[4015] = "",
	[4016] = "",
	[4017] = "",
	[4018] = "",
	[4019] = "",
	[4020] = "",
	[4021] = "",
	[4022] = "",
	[4023] = "",
	[4024] = "",
	[4025] = "",
	[4026] = "",
	[4027] = "",
	[4028] = "",
	[4029] = "",
	[4030] = "",
	[4031] = "",
	[4032] = "",
	[4033] = "",
	[4109] = "",
	[4110] = "",
	[4111] = "",
	[4112] = "",
	[4113] = "",
	[4114] = "",
	[4115] = "",
	[4116] = "",
	[4117] = "",
	[4118] = "",
	[4119] = "",
	[4120] = "",
	[4121] = "",
	[4122] = "",
	[4123] = "",
	[4124] = "",
	[4125] = "",
	[4126] = "",
	[4127] = "",
	[4128] = "",
	[4129] = "",
	[4130] = "",
	[4131] = "",
	[4132] = "",
	[4133] = "",
	[4209] = "",
	[4210] = "",
	[4211] = "",
	[4212] = "",
	[4213] = "",
	[4214] = "",
	[4215] = "",
	[4216] = "",
	[4217] = "",
	[4218] = "",
	[4219] = "",
	[4220] = "",
	[4221] = "",
	[4222] = "",
	[4223] = "",
	[4224] = "",
	[4225] = "",
	[4226] = "",
	[4227] = "",
	[4228] = "",
	[4229] = "",
	[4230] = "",
	[4231] = "",
	[4232] = "",
	[4233] = "",
	[4309] = "",
	[4310] = "",
	[4311] = "",
	[4312] = "",
	[4313] = "",
	[4314] = "",
	[4315] = "",
	[4316] = "",
	[4317] = "",
	[4318] = "",
	[4319] = "",
	[4320] = "",
	[4321] = "",
	[4322] = "",
	[4323] = "",
	[4324] = "",
	[4325] = "",
	[4326] = "",
	[4327] = "",
	[4328] = "",
	[4329] = "",
	[4330] = "",
	[4331] = "",
	[4332] = "",
	[4333] = "",
	[4409] = "",
	[4410] = "",
	[4411] = "",
	[4412] = "",
	[4413] = "",
	[4414] = "",
	[4415] = "",
	[4416] = "",
	[4417] = "",
	[4418] = "",
	[4419] = "",
	[4420] = "",
	[4421] = "",
	[4422] = "",
	[4423] = "",
	[4424] = "",
	[4425] = "",
	[4426] = "",
	[4427] = "",
	[4428] = "",
	[4429] = "",
	[4430] = "",
	[4431] = "",
	[4432] = "",
	[4433] = "",
	[4509] = "",
	[4510] = "",
	[4511] = "",
	[4512] = "",
	[4513] = "",
	[4514] = "",
	[4515] = "",
	[4516] = "",
	[4517] = "",
	[4518] = "",
	[4519] = "",
	[4520] = "",
	[4521] = "",
	[4522] = "",
	[4523] = "",
	[4524] = "",
	[4525] = "",
	[4526] = "",
	[4527] = "",
	[4528] = "",
	[4529] = "",
	[4530] = "",
	[4531] = "",
	[4532] = "",
	[4533] = "",
}

Map.TolBaradMapBlks = {
	[2731] = "",
	[2732] = "",
	[2733] = "",
	[2734] = "",
	[2735] = "",
	[2831] = "",
	[2832] = "",
	[2833] = "",
	[2834] = "",
	[2835] = "",
	[2931] = "",
	[2932] = "",
	[2933] = "",
	[2934] = "",
	[2935] = "",
	[3031] = "",
	[3032] = "",
	[3033] = "",
	[3034] = "",
	[3035] = "",
	[3131] = "",
	[3132] = "",
	[3133] = "",
	[3134] = "",
	[3135] = "",
}

-- Need??
-- Deephome (26,25 -> 35,34)
-- MaelstromZone (28,28 -> 32,32)

Map.LIMapBlks = {	-- LostIsles (32,51 max)
	[2426] = "",
	[2427] = "",
	[2428] = "",
	[2429] = "",
	[2430] = "",
	[2431] = "",
	[2432] = "",
	[2526] = "",
	[2527] = "",
	[2528] = "",
	[2529] = "",
	[2530] = "",
	[2531] = "",
	[2532] = "",
	[2626] = "",
	[2627] = "",
	[2628] = "",
	[2629] = "",
	[2630] = "",
	[2631] = "",
	[2632] = "",
	[2726] = "",
	[2727] = "",
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2732] = "",
	[2826] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2926] = "",
	[2927] = "",
	[2928] = "",
	[2929] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[3026] = "",
	[3027] = "",
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3032] = "",
	[3126] = "",
	[3127] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
}

Map.DeepholmMapBlks = {
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2927] = "",
	[2928] = "",
	[2929] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[3027] = "",
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3032] = "",
	[3127] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
	[3132] = "",
	[3227] = "",
	[3228] = "",
	[3229] = "",
	[3230] = "",
	[3231] = "",
	[3232] = "",
	[3328] = "",
	[3329] = "",
	[3330] = "",
	[3331] = "",
}

Map.KezanMapBlks = {
	[2648] = "",
	[2649] = "",
	[2650] = "",
	[2651] = "",
	[2746] = "",
	[2747] = "",
	[2748] = "",
	[2749] = "",
	[2750] = "",
	[2751] = "",
	[2846] = "",
	[2847] = "",
	[2848] = "",
	[2849] = "",
	[2850] = "",
	[2851] = "",
	[2946] = "",
	[2947] = "",
	[2948] = "",
	[2949] = "",
	[2950] = "",
	[2951] = "",
	[3046] = "",
	[3047] = "",
	[3048] = "",
	[3049] = "",
	[3050] = "",
	[3051] = "",
	[3148] = "",
	[3149] = "",
	[3150] = "",
	[3151] = "",
}

Map.MoltenFrontMapBlks = {
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
	[3228] = "",
	[3229] = "",
	[3230] = "",
	[3231] = "",
	[3328] = "",
	[3329] = "",
	[3330] = "",
	[3331] = "",
}

Map.DarkMoonFaireBlks = {
	[1636] = "",
	[1637] = "",
	[1638] = "",
	[1639] = "",
	[1640] = "",
	[1641] = "",
	[1642] = "",
	[1736] = "",
	[1737] = "",
	[1738] = "",
	[1739] = "",
	[1740] = "",
	[1741] = "",
	[1742] = "",
	[1836] = "",
	[1837] = "",
	[1838] = "",
	[1839] = "",
	[1840] = "",
	[1841] = "",
	[1842] = "",
	[1936] = "",
	[1937] = "",
	[1938] = "",
	[1939] = "",
	[1940] = "",
	[1941] = "",
	[1942] = "",
	[2036] = "",
	[2037] = "",
	[2038] = "",
	[2039] = "",
	[2040] = "",
	[2041] = "",
	[2042] = "",
	[2136] = "",
	[2137] = "",
	[2138] = "",
	[2139] = "",
	[2140] = "",
	[2141] = "",
	[2142] = "",
	[2236] = "",
	[2237] = "",
	[2238] = "",
	[2239] = "",
	[2240] = "",
	[2241] = "",
	[2242] = "",
}

Map.PandariaMapBlks = {
	[1818] = "",
	[1819] = "",
	[1820] = "",
	[1821] = "",
	[1822] = "",
	[1823] = "",
	[1824] = "",
	[1825] = "",
	[1826] = "",
	[1827] = "",
	[1828] = "",
	[1829] = "",
	[1830] = "",
	[1831] = "",
	[1832] = "",
	[1833] = "",
	[1834] = "",
	[1835] = "",
	[1836] = "",
	[1837] = "",
	[1838] = "",
	[1839] = "",
	[1840] = "",
	[1841] = "",
	[1918] = "",
	[1919] = "",
	[1920] = "",
	[1921] = "",
	[1922] = "",
	[1923] = "",
	[1924] = "",
	[1925] = "",
	[1926] = "",
	[1927] = "",
	[1928] = "",
	[1929] = "",
	[1930] = "",
	[1931] = "",
	[1932] = "",
	[1933] = "",
	[1934] = "",
	[1935] = "",
	[1936] = "",
	[1937] = "",
	[1938] = "",
	[1939] = "",
	[1940] = "",
	[1941] = "",
	[2018] = "",
	[2019] = "",
	[2020] = "",
	[2021] = "",
	[2022] = "",
	[2023] = "",
	[2024] = "",
	[2025] = "",
	[2026] = "",
	[2027] = "",
	[2028] = "",
	[2029] = "",
	[2030] = "",
	[2031] = "",
	[2032] = "",
	[2033] = "",
	[2034] = "",
	[2035] = "",
	[2036] = "",
	[2037] = "",
	[2038] = "",
	[2039] = "",
	[2040] = "",
	[2041] = "",
	[2118] = "",
	[2119] = "",
	[2120] = "",
	[2121] = "",
	[2122] = "",
	[2123] = "",
	[2124] = "",
	[2125] = "",
	[2126] = "",
	[2127] = "",
	[2128] = "",
	[2129] = "",
	[2130] = "",
	[2131] = "",
	[2132] = "",
	[2133] = "",
	[2134] = "",
	[2135] = "",
	[2136] = "",
	[2137] = "",
	[2138] = "",
	[2139] = "",
	[2140] = "",
	[2141] = "",
	[2218] = "",
	[2219] = "",
	[2220] = "",
	[2221] = "",
	[2222] = "",
	[2223] = "",
	[2224] = "",
	[2225] = "",
	[2226] = "",
	[2227] = "",
	[2228] = "",
	[2229] = "",
	[2230] = "",
	[2231] = "",
	[2232] = "",
	[2233] = "",
	[2234] = "",
	[2235] = "",
	[2236] = "",
	[2237] = "",
	[2238] = "",
	[2239] = "",
	[2240] = "",
	[2241] = "",
	[2318] = "",
	[2319] = "",
	[2320] = "",
	[2321] = "",
	[2322] = "",
	[2323] = "",
	[2324] = "",
	[2325] = "",
	[2326] = "",
	[2327] = "",
	[2328] = "",
	[2329] = "",
	[2330] = "",
	[2331] = "",
	[2332] = "",
	[2333] = "",
	[2334] = "",
	[2335] = "",
	[2336] = "",
	[2337] = "",
	[2338] = "",
	[2339] = "",
	[2340] = "",
	[2341] = "",
	[2418] = "",
	[2419] = "",
	[2420] = "",
	[2421] = "",
	[2422] = "",
	[2423] = "",
	[2424] = "",
	[2425] = "",
	[2426] = "",
	[2427] = "",
	[2428] = "",
	[2429] = "",
	[2430] = "",
	[2431] = "",
	[2432] = "",
	[2433] = "",
	[2434] = "",
	[2435] = "",
	[2436] = "",
	[2437] = "",
	[2438] = "",
	[2439] = "",
	[2440] = "",
	[2441] = "",
	[2518] = "",
	[2519] = "",
	[2520] = "",
	[2521] = "",
	[2522] = "",
	[2523] = "",
	[2524] = "",
	[2525] = "",
	[2526] = "",
	[2527] = "",
	[2528] = "",
	[2529] = "",
	[2530] = "",
	[2531] = "",
	[2532] = "",
	[2533] = "",
	[2534] = "",
	[2535] = "",
	[2536] = "",
	[2537] = "",
	[2538] = "",
	[2539] = "",
	[2540] = "",
	[2541] = "",
	[2618] = "",
	[2619] = "",
	[2620] = "",
	[2621] = "",
	[2622] = "",
	[2623] = "",
	[2624] = "",
	[2625] = "",
	[2626] = "",
	[2627] = "",
	[2628] = "",
	[2629] = "",
	[2630] = "",
	[2631] = "",
	[2632] = "",
	[2633] = "",
	[2634] = "",
	[2635] = "",
	[2636] = "",
	[2637] = "",
	[2638] = "",
	[2639] = "",
	[2640] = "",
	[2641] = "",
	[2718] = "",
	[2719] = "",
	[2720] = "",
	[2721] = "",
	[2722] = "",
	[2723] = "",
	[2724] = "",
	[2725] = "",
	[2726] = "",
	[2727] = "",
	[2728] = "",
	[2729] = "",
	[2730] = "",
	[2731] = "",
	[2732] = "",
	[2733] = "",
	[2734] = "",
	[2735] = "",
	[2736] = "",
	[2737] = "",
	[2738] = "",
	[2739] = "",
	[2740] = "",
	[2741] = "",
	[2818] = "",
	[2819] = "",
	[2820] = "",
	[2821] = "",
	[2822] = "",
	[2823] = "",
	[2824] = "",
	[2825] = "",
	[2826] = "",
	[2827] = "",
	[2828] = "",
	[2829] = "",
	[2830] = "",
	[2831] = "",
	[2832] = "",
	[2833] = "",
	[2834] = "",
	[2835] = "",
	[2836] = "",
	[2837] = "",
	[2838] = "",
	[2839] = "",
	[2840] = "",
	[2841] = "",
	[2918] = "",
	[2919] = "",
	[2920] = "",
	[2921] = "",
	[2922] = "",
	[2923] = "",
	[2924] = "",
	[2925] = "",
	[2926] = "",
	[2927] = "",
	[2928] = "",
	[2929] = "",
	[2930] = "",
	[2931] = "",
	[2932] = "",
	[2933] = "",
	[2934] = "",
	[2935] = "",
	[2936] = "",
	[2937] = "",
	[2938] = "",
	[2939] = "",
	[2940] = "",
	[2941] = "",
	[3018] = "",
	[3019] = "",
	[3020] = "",
	[3021] = "",
	[3022] = "",
	[3023] = "",
	[3024] = "",
	[3025] = "",
	[3026] = "",
	[3027] = "",
	[3028] = "",
	[3029] = "",
	[3030] = "",
	[3031] = "",
	[3032] = "",
	[3033] = "",
	[3034] = "",
	[3035] = "",
	[3036] = "",
	[3037] = "",
	[3038] = "",
	[3039] = "",
	[3040] = "",
	[3041] = "",
	[3118] = "",
	[3119] = "",
	[3120] = "",
	[3121] = "",
	[3122] = "",
	[3123] = "",
	[3124] = "",
	[3125] = "",
	[3126] = "",
	[3127] = "",
	[3128] = "",
	[3129] = "",
	[3130] = "",
	[3131] = "",
	[3132] = "",
	[3133] = "",
	[3134] = "",
	[3135] = "",
	[3136] = "",
	[3137] = "",
	[3138] = "",
	[3139] = "",
	[3140] = "",
	[3141] = "",
	[3218] = "",
	[3219] = "",
	[3220] = "",
	[3221] = "",
	[3222] = "",
	[3223] = "",
	[3224] = "",
	[3225] = "",
	[3226] = "",
	[3227] = "",
	[3228] = "",
	[3229] = "",
	[3230] = "",
	[3231] = "",
	[3232] = "",
	[3233] = "",
	[3234] = "",
	[3235] = "",
	[3236] = "",
	[3237] = "",
	[3238] = "",
	[3239] = "",
	[3240] = "",
	[3241] = "",
	[3318] = "",
	[3319] = "",
	[3320] = "",
	[3321] = "",
	[3322] = "",
	[3323] = "",
	[3324] = "",
	[3325] = "",
	[3326] = "",
	[3327] = "",
	[3328] = "",
	[3329] = "",
	[3330] = "",
	[3331] = "",
	[3332] = "",
	[3333] = "",
	[3334] = "",
	[3335] = "",
	[3336] = "",
	[3337] = "",
	[3338] = "",
	[3339] = "",
	[3340] = "",
	[3341] = "",
	[3418] = "",
	[3419] = "",
	[3420] = "",
	[3421] = "",
	[3422] = "",
	[3423] = "",
	[3424] = "",
	[3425] = "",
	[3426] = "",
	[3427] = "",
	[3428] = "",
	[3429] = "",
	[3430] = "",
	[3431] = "",
	[3432] = "",
	[3433] = "",
	[3434] = "",
	[3435] = "",
	[3436] = "",
	[3437] = "",
	[3438] = "",
	[3439] = "",
	[3440] = "",
	[3441] = "",
	[3518] = "",
	[3519] = "",
	[3520] = "",
	[3521] = "",
	[3522] = "",
	[3523] = "",
	[3524] = "",
	[3525] = "",
	[3526] = "",
	[3527] = "",
	[3528] = "",
	[3529] = "",
	[3530] = "",
	[3531] = "",
	[3532] = "",
	[3533] = "",
	[3534] = "",
	[3535] = "",
	[3536] = "",
	[3537] = "",
	[3538] = "",
	[3539] = "",
	[3540] = "",
	[3541] = "",
	[3618] = "",
	[3619] = "",
	[3620] = "",
	[3621] = "",
	[3622] = "",
	[3623] = "",
	[3624] = "",
	[3625] = "",
	[3626] = "",
	[3627] = "",
	[3628] = "",
	[3629] = "",
	[3630] = "",
	[3631] = "",
	[3632] = "",
	[3633] = "",
	[3634] = "",
	[3635] = "",
	[3636] = "",
	[3637] = "",
	[3638] = "",
	[3639] = "",
	[3640] = "",
	[3641] = "",
	[3718] = "",
	[3719] = "",
	[3720] = "",
	[3721] = "",
	[3722] = "",
	[3723] = "",
	[3724] = "",
	[3725] = "",
	[3726] = "",
	[3727] = "",
	[3728] = "",
	[3729] = "",
	[3730] = "",
	[3731] = "",
	[3732] = "",
	[3733] = "",
	[3734] = "",
	[3735] = "",
	[3736] = "",
	[3737] = "",
	[3738] = "",
	[3739] = "",
	[3740] = "",
	[3741] = "",
	[3818] = "",
	[3819] = "",
	[3820] = "",
	[3821] = "",
	[3822] = "",
	[3823] = "",
	[3824] = "",
	[3825] = "",
	[3826] = "",
	[3827] = "",
	[3828] = "",
	[3829] = "",
	[3830] = "",
	[3831] = "",
	[3832] = "",
	[3833] = "",
	[3834] = "",
	[3835] = "",
	[3836] = "",
	[3837] = "",
	[3838] = "",
	[3839] = "",
	[3840] = "",
	[3841] = "",
	[3918] = "",
	[3919] = "",
	[3920] = "",
	[3921] = "",
	[3922] = "",
	[3923] = "",
	[3924] = "",
	[3925] = "",
	[3926] = "",
	[3927] = "",
	[3928] = "",
	[3929] = "",
	[3930] = "",
	[3931] = "",
	[3932] = "",
	[3933] = "",
	[3934] = "",
	[3935] = "",
	[3936] = "",
	[3937] = "",
	[3938] = "",
	[3939] = "",
	[3940] = "",
	[3941] = "",
	[4018] = "",
	[4019] = "",
	[4020] = "",
	[4021] = "",
	[4022] = "",
	[4023] = "",
	[4024] = "",
	[4025] = "",
	[4026] = "",
	[4027] = "",
	[4028] = "",
	[4029] = "",
	[4030] = "",
	[4031] = "",
	[4032] = "",
	[4033] = "",
	[4034] = "",
	[4035] = "",
	[4036] = "",
	[4037] = "",
	[4038] = "",
	[4039] = "",
	[4040] = "",
	[4041] = "",	
	[4118] = "",
	[4119] = "",
	[4120] = "",
	[4121] = "",
	[4122] = "",
	[4123] = "",
	[4124] = "",
	[4125] = "",
	[4126] = "",
	[4127] = "",
	[4128] = "",
	[4129] = "",
	[4130] = "",
	[4131] = "",
	[4132] = "",
	[4133] = "",
	[4134] = "",
	[4135] = "",
	[4136] = "",
	[4137] = "",
	[4138] = "",
	[4139] = "",
	[4140] = "",
	[4141] = "",		
	[4218] = "",
	[4219] = "",
	[4220] = "",
	[4221] = "",
	[4222] = "",
	[4223] = "",
	[4224] = "",
	[4225] = "",
	[4226] = "",
	[4227] = "",
	[4228] = "",
	[4229] = "",
	[4230] = "",
	[4231] = "",
	[4232] = "",
	[4233] = "",
	[4234] = "",
	[4235] = "",
	[4236] = "",
	[4237] = "",
	[4238] = "",
	[4239] = "",
	[4240] = "",
	[4241] = "",		
	[4318] = "",
	[4319] = "",
	[4320] = "",
	[4321] = "",
	[4322] = "",
	[4323] = "",
	[4324] = "",
	[4325] = "",
	[4326] = "",
	[4327] = "",
	[4328] = "",
	[4329] = "",
	[4330] = "",
	[4331] = "",
	[4332] = "",
	[4333] = "",
	[4334] = "",
	[4335] = "",
	[4336] = "",
	[4337] = "",
	[4338] = "",
	[4339] = "",
	[4340] = "",
	[4341] = "",
}

Map.TheWanderingIsleMapBlks={
	[2328]="",
	[2329]="",
	[2330]="",
	[2331]="",
	[2428]="",
	[2429]="",
	[2430]="",
	[2431]="",
	[2528]="",
	[2529]="",
	[2530]="",
	[2531]="",
	[2628]="",
	[2629]="",
	[2630]="",
	[2631]="",
	[2728]="",
	[2729]="",
	[2730]="",
	[2731]="",
}

--[[
Map.OrgMapBlks = {
	[0000000] = "2874c241d5d9f4b84eba58c91d42943d",
	[0010000] = "d8957f3998081a5d4f7b8d6e52fcd2df",
}

Map.ExodarMapBlks = {
}
--]]

Map.MiniMapBlks = {
	[1] = {
		Map.KalMapBlks,
		1908,
		19, 8,
		-3187.5660,-2360.4561,
		"World\\Minimaps\\Kalimdor"
	},
	[2] = {
		Map.EkMapBlks,
		2420,
		24, 20,
		5030.591080,-1480.711746,				
		"World\\Minimaps\\Azeroth"
	},
	[3] = {
		Map.OLMapBlks,
		1221,
		12, 21,
		4866.173367,-5174.403157,
		"World\\Minimaps\\Expansion01"
	},
	[4] = {
		Map.NRMapBlks,
		1109,
		11, 09,
		198.700859,-4835.362984,
		"World\\Minimaps\\Northrend"
	},
	[5] = {
		Map.LIMapBlks,
		2324,
		23, 24,
		1164.91-1375+1100,397.60-100-1800,
		"World\\Minimaps\\LostIsles"
	},
	[6] = {
		Map.PandariaMapBlks,
		1816,
		18, 16,
		850, 2225-2500+800,
		"World\\Minimaps\\HawaiiMainLand"
	},
	[1003] = {
		Map.DraeneiMapBlks,
		5033,
		50, 33,
		-3380.243817,-1703.381588,
		"World\\Minimaps\\Expansion01"
	},
	[2011] = {
		Map.BloodelfMapBlks,
		4111,
		41, 11,
		6341.011121,-1924.128369,
		"World\\Minimaps\\Expansion01"
	},
	[2038] = {
		Map.TolBaradMapBlks,
		2731,
		27, 31,
		4750.5466,13.3466,
		"World\\Minimaps\\TolBarad"
	},
	[4012] = {
		Map.MoltenFrontMapBlks,
		2725,		-- 2725 to 3531
		27, 25,
		1253.256,-2406.387,
		"World\\Minimaps\\FirelandsDailies"
	},
	[5001] = {	-- 2625 to 3534
		Map.DeepholmMapBlks,
		2625,
		26, 25,
		2314.91-1375+1100,54.81-100-1800,
		"World\\Minimaps\\Deephome"
	},
	[5002] = {
		Map.KezanMapBlks,
		2324,
		23, 24,
		1670.80-1375+1100,-1295.70-100-1800,
		"World\\Minimaps\\LostIsles"
	},
	[5005] = {
		Map.DarkMoonFaireBlks,
		1636,
		16, 36,
		-1871.26-1375+1100+3000-300,-3133.00-100-1800+3000-2750+2400,
		"World\\Minimaps\\DarkmoonFaire"
	},
    [6009] = {
	     Map.TheWanderingIsleMapBlks,
		 2328,
		 23,28,
		 Map.MapWorldInfo[6009][2]+Map.MapInfo[6].X+35.7, Map.MapWorldInfo[6009][3]+Map.MapInfo[6].Y-69.55,
		 "World\\Minimaps\\NewRaceStartZone"
	},	
}

--------
-- Get minimap info for map
-- (map id)
-- ret: table, x, y

function Nx.Map:GetMiniInfo (mapId)

	local winfo = self.MapWorldInfo[mapId]
	local id = winfo.MId

	if not id then
		id = floor (mapId / 1000)

		if id == 9 then	-- BGs?
			return
		end

		local info = self.MapInfo[id]
		if not info then
			return
		end
	end

	local t = self.MiniMapBlks[id]

	if not t then		-- "Isle of Quel'Danas"??

--		if NxData.DebugMap then
--			Nx.prt ("GetMiniInfo: missing %s", id)
--		end
		return
	end

	return t, t[5], t[6]
end

--------
-- Get minimap block file name (256x256 texture)

function Nx.Map:GetMiniBlkName (miniT, x, y)

	local off = x * 100 + y

--	Nx.prtCtrl ("%s, %s, %s = %s", x, y, off, off + miniT[2])

	--V4

	local v = miniT[1][off + miniT[2]]

	if v then

		if #v > 0 then
			return format ("%s\\noLiquid_map%02d_%02d", miniT[7], x + miniT[3], y + miniT[4])
		end		
		if (strfind(miniT[7],"HawaiiMainLand")) then			
			local hasFac = false
			for factionIndex = 1, GetNumFactions() do
				local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)				
				if (name == "Operation: Shieldwall") or (name == "Dominance Offensive") then
					hasFac = true
				end
			end
			if (hasFac) then
				if ((x + miniT[3] == 33) or (x + miniT[3] == 34)) and ((y + miniT[4] == 33) or (y + miniT[4] == 34)) then
					return format("World\\Minimaps\\AllianceBeachDailyArea\\map%02d_%02d", x + miniT[3], y + miniT[4])
				end
				if ((x + miniT[3] == 27) or (x + miniT[3] == 28)) and ((y + miniT[4] == 35) or (y + miniT[4] == 36) or (y + miniT[4] == 37) or (y + miniT[4] == 38)) then
					return format("World\\Minimaps\\HordeBeachDailyArea\\map%02d_%02d", x + miniT[3], y + miniT[4])
				end
			end
			if (x + miniT[3] >= 18) and (x + miniT[3] <= 25) and (y + miniT[4] >= 17) and (y + miniT[4] <= 24) then
				return format("World\\Minimaps\\MoguIslandDailyArea\\map%02d_%02d",x+miniT[3], y + miniT[4]-2)
			end
		  return format ("%s\\map%02d_%02d", miniT[7], x + miniT[3], y + miniT[4])
		else
			return format ("%s\\map%02d_%02d", miniT[7], x + miniT[3], y + miniT[4])
		end
		
	end
end

Map.MapLevels={
    [811] = { [3] = 6010, [4] = 6011, },
    [903] = { [1] = 6012, [2] = 6013, },
    [905] = { [3] = 6010, [4] = 6011, }, 
    [504] = { [2] = 4014, },    
    [321] = { [2] = 1034, },   
}

-------------------------------------------------------------------------------



-- WorldMapArea.dbc
-- bounds y1, y2, x1, x2
-- 4.0.1 11,1,17,"Barrens",2622.91650391,-7510.41650391,1612.49987793,-5143.75,-1,0,0,0x0,
-- 4.0.3 11,1,17,"Barrens",202.083328247,-5543.75,1810.41662598,-2020.83325195,-1,0,0,0x0,
-- 5.0.4 11,1,17,"Barrens",202.083328247,-5543.75,1810.41662598,-2020.83325195,-1,0,0,0x0,10,20,

-- x = (x-maEntry->x1)/((maEntry->x2-maEntry->x1)/100);
-- y = (y-maEntry->y1)/((maEntry->y2-maEntry->y1)/100);    // client y coord from top to down
--
-- MapWorldInfo table calc:
-- Scale = -y2 + y1 / 500
-- X = -y1 / 5
-- Y = -x1 / 5
--[[function Nx.Map:ConvertMapData()

	local data = {}
	NxData.DumpZoneOverlays = data

	local areas = {}
	NxData.DumpMapAreas = areas

	local wma = { strsplit ("\n", self.WorldMapArea) }
	local wmo = { strsplit ("\n", self.WorldMapOverlay) }

	for n, s in ipairs (wma) do

		local aid, map, _, aname, ay1, ay2, ax1, ax2 = strsplit (",", s)
		aid = tonumber (aid)
		map = tonumber (map)

		aname = gsub (aname, '"', "")
		aname = strlower (aname)
		Nx.prt(aid)
		local nxid = Nx.ID2Zone[aid]
		if nxid and nxid > 0 then

			local name, minLvl, maxLvl, faction, cont = strsplit ("!", Nx.Zones[nxid])

			if faction ~= "3" then	-- Not instance

				ay1 = tonumber (ay1)
				ay2 = tonumber (ay2)
				ax1 = tonumber (ax1)
				ax2 = tonumber (ax2)

				local scale = (-ay2 + ay1) / 500
				Nx.prt(scale)
				if scale > 0 then
					local t = {}
					areas[nxid] = t
					t[1] = scale
					t[2] = -ay1 / 5						-- X
					t[3] = -ax1 / 5						-- Y
					t[4] = aname
					Nx.prt("%s %s %s %s",t[4],t[2],t[3],t[1])
				end
			end			
		end

--		if map == 0 or map == 1 then
--		if map == 648 or map == 646 or map == 730 then			-- Maelstrom
--		if map == 654 then	-- Gilneas
--		if map == 571 or map == 609 then			-- Northrend, DK start
		if map == 1064 or map == 870 then
--			Nx.prt ("%s %s %s", aid, map, aname)

			local area = {}

			for n, os in ipairs (wmo) do

				-- 84,41,736,0,0,0,"BanethilHollow",175,235,374,221,292,430,375,497,0x0,

				local _, oaid, _, _, _, _, oname, w, h, x, y = strsplit (",", os)

				oname = gsub (oname, '"', "")

				if tonumber (oaid) == aid and #oname > 0 then
					oname = strlower (oname)
					area[oname] = format ("%s,%s,%s,%s", x, y, w, h)
				end
			end

			if next (area) then	-- Not empty?
				data[aname] = area
			end
		end
	end
end
--]]
--Nx.Map.WorldMapArea = [[929,870,6661,"Isleofgiants",2004.167,216.666016,6697.916,5506.25,-1,0,0,0x0,0,0,]]

--Nx.Map.WorldMapOverlay = [[3564,928,0,0,0,0,"",0,0,0,0,490,290,256,378,0x0,]]


--Nx.Map:ConvertMapData()

-------------------------------------------------------------------------------
--EOF

















