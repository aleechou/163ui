local addonname,addon = ...
local L = addon.L

addon.PetBaseDate={
	[1] = {510.5,8,9.5},
	[2] = {8.5,7.5,8},
	[3] = {7,8.5,8.5},
	[4] = {6.5,9,8.5},
	[5] = {7,9,8},
	[6] = {7.5,7.5,9},
	[7] = {8,7.5,8.5},
	[8] = {9,7,8},
	[9] = {9,8,7},
	[10] = {8.5,8,7.5},
	[11] = {8,8,8},
	[12] = {8.5,7,8.5},
	[13] = {8.5,9,6.5},
	[14] = {8,7,9},
	[15] = {7.5,8.5,8},
	[16] = {8,8.5,7.5},
	[17] = {7,7,10},
	[18] = {8.5,8.5,7},
	[19] = {7.5,8,8.5},
	[20] = {7.5,7,9.5},
	[21] = {9,7.5,7.5},
	[22] = {9,9,6},
	[23] = {7.5,9,7.5},
	[24] = {8,9,7},
	[25] = {9.5,8,6.5},
	[26] = {9.5,8.5,6},
	[27] = {8,9.5,6.5},
	[28] = {8,8.75,7.25},
	[29] = {7,8,9},
	[30] = {9,6.5,8.5},
	[31] = {6,8,10},
	[32] = {8,6.5,9.5},
	[33] = {9,8.5,6.5},
	[34] = {9.5,7.5,7},
	[35] = {6.5,8,9.5},
	[36] = {6.75,10.5,6.75},
	[37] = {7.5,8.5,8.5},
	[38] = {11.5,15.5,7.5},
	[39] = {8.25,8,7.75},
	[40] = {11.625,15.375,7.625},
	[41] = {11.375,15.125,7.75},
	[42] = {11.875,16,7.25},
	[43] = {11.125,14.25,7.875},
	[44] = {12,15.75,7},
	[45] = {11.625,15,7.375},
	[46] = {11,14.5,7.5},
	[47] = {11.25,15.25,7.875},
	[48] = {11,15,8},
	[49] = {8,8.25,7.75},
	[50] = {7.75,8,8.25},
	[51] = {8.25,8.25,7.5},
	[52] = {7.75,8.25,8},
	[53] = {8.25,8.5,7.25},
	[54] = {7.5,8.25,8.25},
	[55] = {11,16,7},
	[56] = {7.75,8.375,7.875},
	[57] = {9,8,8},
	[58] = {11.25,15.25,7},
	[59] = {9,8.375,6.625},
	[60] = {8,9.25,6.75},
	[61] = {8,8.25,7.25},
	[62] = {8,8.5,8},
	[63] = {9.25,8,6.75},
	[64] = {7.875,7.875,8.25},
	[65] = {8,9,7.25},
	[66] = {8,9.5,7},
	[67] = {8,8,6.75},
	[68] = {8,7.5,8},
	[69] = {8,8.75,7},
	[70] = {9.25,8,7},
	[71] = {8,8,8.25},
	[72] = {11.25,15.25,7.375},
	[73] = {11.25,15.25,6.75},
	[74] = {11.25,15.25,7.35},
	[75] = {7.75,8.5,7.75},
	[76] = {13,19.5,5},
	[77] = {48,8,6.5},
	[78] = {12,15.25,7.35},
	[79] = {8.3,7.9,7.8},
	[80] = {8.125,8.375,7.5},
	[81] = {12.25,12,7.375},
	[82] = {13.32,7.5,7.5},
	[83] = {8,8,7.5},
	[84] = {13,8,5.5},
	[85] = {7.625,7.875,8.5},
	[86] = {8,8,7.25},
	[87] = {7.625,8.25,8.125},
	[88] = {11.375,16,7.75},
	[89] = {11.375,16,7.25},
	[90] = {12.5,9.25,8},
	[91] = {15.5,13,7.5},
	[92] = {12.5,9.25,7},
	[93] = {8,14,7.5},
	[94] = {10.5,8,5.5},
	[95] = {15.5,11.75,7.5},
	[96] = {12.5,10.5,6.75},
	[97] = {12.5,10.5,7},
	[98] = {11.75,10.5,7.5},
	[99] = {10,11,7.25},
	[100] = {7.75,9.5,6.75},
	[101] = {7.75,7.75,8.5},
	[102] = {8,9,8},
	[103] = {12.5,10.5,8.5},
	[104] = {10,6.5,6.25},
	[105] = {8,8.5,7},
	[106] = {7.25,7.25,9.25},
	[107] = {38,11.25,6},
	[108] = {8,8.75,6.75},
	[109] = {7.25,9.25,7.5},
	[110] = {9.25,9.25,5.5},
	[111] = {8,10.75,8},
	[112] = {8,9.5,8},
	[113] = {8,10,8},
	[114] = {9.75,7.25,7},
	[115] = {7.5,9.5,7},
	[116] = {6.75,9.25,8},
	[117] = {10,7.5,6.5},
}
addon.PetDate={
	[39] = "2:11",
	[40] = "3:8",
	[41] = "3:4",
	[42] = "4:7",
	[43] = "5:3",
	[44] = "3:5",
	[45] = "3:3",
	[46] = "6:12",
	[47] = "7:3,5",
	[49] = "8:3",
	[50] = "9:11",
	[51] = "10:3,5",
	[52] = "11:3,10,11,12",
	[55] = "12:3,5,6,9",
	[56] = "13:8",
	[57] = "2:4",
	[58] = "5:8",
	[59] = "10:9",
	[64] = "2:9",
	[65] = "2:12",
	[67] = "11:3,8,10",
	[68] = "11:3,6,7",
	[69] = "6:3,10,11",
	[70] = "7:3,5,12",
	[72] = "14:3,5,11",
	[74] = "6:11",
	[75] = "15:5",
	[77] = "11:3",
	[78] = "15:12",
	[83] = "2:8",
	[84] = "11:3,10,11,12",
	[85] = "2:9",
	[86] = "2:7",
	[87] = "16:5",
	[89] = "11:6",
	[90] = "3:7",
	[92] = "11:3",
	[93] = "4:4",
	[94] = "17:5",
	[95] = "11:3",
	[106] = "2:10",
	[107] = "11:3",
	[111] = "11:12",
	[114] = "18:12",
	[116] = "11:12",
	[117] = "11:3",
	[118] = "11:3",
	[119] = "11:3",
	[120] = "11:3",
	[121] = "11:3",
	[122] = "11:5",
	[124] = "11:3",
	[125] = "11:5",
	[126] = "11:10",
	[127] = "7:7",
	[128] = "11:3",
	[130] = "11:3",
	[131] = "7:8",
	[132] = "9:6",
	[136] = "11:3,7,10,12",
	[137] = "14:3,5,11",
	[138] = "2:3,12",
	[139] = "15:3,8,12",
	[140] = "16:3,4,12",
	[141] = "6:3,6,12",
	[142] = "16:3,5",
	[143] = "15:3,5,8",
	[144] = "6:3,5,11",
	[145] = "2:3,5,6,8",
	[146] = "19:3,5,9,12",
	[149] = "20:9",
	[153] = "11:7",
	[155] = "11:7",
	[156] = "11:3",
	[157] = "11:3",
	[158] = "11:3",
	[159] = "11:6",
	[160] = "11:4",
	[162] = "16:10",
	[163] = "16:8",
	[164] = "16:3",
	[165] = "2:9",
	[166] = "18:7",
	[167] = "21:3,6,9",
	[168] = "2:5",
	[169] = "11:5",
	[170] = "11:7",
	[171] = "11:7",
	[172] = "15:10",
	[173] = "16:7",
	[174] = "16:3",
	[175] = "15:5",
	[179] = "10:7",
	[180] = "10:7",
	[183] = "11:3",
	[186] = "15:3,4,5,8",
	[187] = "18:8",
	[188] = "18:6",
	[189] = "11:3",
	[190] = "18:6,7,12",
	[191] = "2:3",
	[192] = "11:9",
	[193] = "16:4",
	[194] = "11:3,5,8,9,11",
	[195] = "6:5,8,9,11",
	[196] = "10:7",
	[197] = "19:8",
	[198] = "11:11",
	[199] = "11:10",
	[200] = "14:5",
	[201] = "11:7",
	[202] = "11:7",
	[203] = "14:12",
	[204] = "11:3",
	[205] = "11:7",
	[206] = "18:3,9,11",
	[207] = "11:8",
	[209] = "11:3",
	[210] = "11:5",
	[211] = "10:6",
	[212] = "11:3",
	[213] = "11:5",
	[214] = "11:3",
	[215] = "2:10",
	[216] = "11:3",
	[217] = "11:7",
	[218] = "2:4",
	[220] = "11:9",
	[224] = "3:10",
	[225] = "11:3",
	[226] = "11:4",
	[227] = "11:4",
	[228] = "11:7",
	[229] = "11:3",
	[231] = "10:3",
	[232] = "3:8",
	[233] = "3:8",
	[234] = "3:10",
	[235] = "3:10",
	[236] = "15:6",
	[237] = "3:3",
	[238] = "3:11",
	[239] = "11:4",
	[240] = "18:3",
	[241] = "11:12",
	[242] = "15:8",
	[243] = "22:10",
	[244] = "13:7",
	[245] = "11:8",
	[246] = "11:3",
	[247] = "11:6",
	[248] = "11:8",
	[249] = "18:7",
	[250] = "23:8",
	[251] = "18:3",
	[253] = "11:3",
	[254] = "11:3,5,8",
	[255] = "23:6",
	[256] = "24:7",
	[258] = "13:6",
	[259] = "2:12",
	[260] = "16:8",
	[261] = "2:4",
	[262] = "2:5",
	[264] = "18:8",
	[265] = "25:6",
	[266] = "18:8",
	[267] = "11:3",
	[268] = "13:4",
	[270] = "18:9",
	[271] = "7:3,9,10",
	[272] = "21:6,9",
	[277] = "2:11",
	[278] = "11:9",
	[279] = "11:8",
	[280] = "11:3",
	[281] = "11:3",
	[282] = "11:3",
	[283] = "11:3",
	[285] = "24:10",
	[286] = "9:7",
	[287] = "7:3",
	[289] = "26:6",
	[291] = "21:12",
	[292] = "11:3",
	[293] = "11:9",
	[294] = "11:8",
	[296] = "11:3",
	[297] = "27:4",
	[298] = "11:3",
	[301] = "3:11",
	[302] = "18:7",
	[303] = "3:5",
	[306] = "3:11",
	[307] = "11:3",
	[308] = "11:3",
	[309] = "4:8",
	[310] = "11:8",
	[311] = "10:3",
	[316] = "2:3",
	[317] = "18:3",
	[318] = "15:3",
	[319] = "4:10",
	[320] = "2:7",
	[321] = "11:6",
	[323] = "11:8",
	[325] = "23:5,8,10",
	[328] = "11:4",
	[329] = "11:8",
	[330] = "11:10",
	[331] = "11:3",
	[332] = "11:3",
	[333] = "11:11",
	[335] = "21:12",
	[336] = "11:3",
	[337] = "11:12",
	[338] = "2:7",
	[339] = "11:12",
	[340] = "11:3",
	[341] = "11:3",
	[342] = "11:3",
	[343] = "3:3,8",
	[346] = "11:3",
	[347] = "28:3",
	[348] = "18:8",
	[374] = "11:7,8,9,10,11,12",
	[378] = "14:3,5,7,9,11,12",
	[379] = "7:3,5,10,11,12",
	[380] = "11:3,12",
	[381] = "11:9",
	[383] = "7:8,11",
	[385] = "7:3,5,8,11,12",
	[386] = "7:3,5,11",
	[387] = "19:3,5",
	[388] = "10:3,6,7",
	[389] = "2:3,4,5,6,7,8,9,10,11,12",
	[391] = "14:3,5,9",
	[392] = "7:3,5,9,11",
	[393] = "12:5,6,7,9,11,12",
	[395] = "10:3,6,7",
	[396] = "3:8,11",
	[397] = "11:3,9,11,12",
	[398] = "7:3,5,9,11",
	[399] = "19:3,5,8",
	[400] = "3:3,4,9,11",
	[401] = "10:3,6,7",
	[402] = "10:3,9,12",
	[403] = "19:3,5,8,10",
	[404] = "7:3,12",
	[405] = "19:3,4,7",
	[406] = "2:3,6,7,9",
	[407] = "3:3,5,8,11",
	[408] = "19:3,5,11",
	[409] = "29:5,8,10",
	[410] = "7:3,5,9,11",
	[411] = "11:3,4",
	[412] = "3:3,5,11",
	[414] = "11:3,8",
	[415] = "15:6,7,9",
	[416] = "11:3,5,8",
	[417] = "7:3,5,9,11",
	[418] = "19:3,11",
	[419] = "2:3,11",
	[420] = "2:3,7,12",
	[421] = "16:3,9,12",
	[422] = "15:3,5,8",
	[423] = "18:3,6,9",
	[424] = "12:5,6,7,9,11,12",
	[425] = "19:3,8,10",
	[427] = "3:3,9",
	[428] = "3:3,5,8,11",
	[429] = "15:4,6,7,9",
	[430] = "16:5",
	[431] = "19:8,9",
	[432] = "11:3,8",
	[433] = "19:3,5,7",
	[437] = "11:3,10",
	[438] = "19:6,9",
	[439] = "10:6,9",
	[440] = "11:3,4,8",
	[441] = "14:5,7,9",
	[442] = "30:6,7,9,12",
	[443] = "11:3,5,7,9,11,12",
	[445] = "11:6,7,9,10",
	[446] = "10:3,4,6,9",
	[447] = "7:3,5,9,11,12",
	[448] = "14:3,5,7,9,11,12",
	[449] = "11:3,5,11",
	[450] = "9:3,6",
	[452] = "11:3,5,10,11,12",
	[453] = "9:6,7",
	[454] = "7:3,5,9,11",
	[455] = "11:7,8,10",
	[456] = "16:3,6,7,8",
	[457] = "9:6,9",
	[458] = "18:3,6",
	[459] = "3:3,5,8,11",
	[460] = "15:3,6,9",
	[461] = "9:3",
	[463] = "22:6,9",
	[464] = "11:3,5,9",
	[465] = "3:3,4,8",
	[466] = "19:3,5,7",
	[467] = "15:3,6,7,9",
	[468] = "15:3,6,7,9",
	[469] = "3:3,4,6,7,9",
	[470] = "3:3,4,7,11",
	[471] = "2:3,5,6,8,9,10",
	[472] = "2:3,4,5,6,7,8,10,11",
	[473] = "21:3,9",
	[474] = "31:5",
	[475] = "12:3,12",
	[477] = "6:3,11",
	[478] = "10:3,9,11,12",
	[479] = "32:3,11",
	[480] = "16:3,6,9",
	[482] = "19:3,5",
	[483] = "2:3,12",
	[484] = "3:3,5,8,11",
	[485] = "21:6,7,9",
	[487] = "11:3,5,7,10,11,12",
	[488] = "19:12",
	[489] = "16:4,8,10",
	[491] = "5:5,8",
	[492] = "16:3,6,9",
	[493] = "26:3,6,7",
	[494] = "11:3,6,7",
	[495] = "2:3,12",
	[496] = "26:3,9,12",
	[497] = "12:6,7,9,12",
	[498] = "10:3,8,9",
	[499] = "7:7",
	[500] = "11:3,4,6,7,8,10",
	[502] = "2:3,12",
	[503] = "6:3,5,11",
	[504] = "16:3,4,10",
	[505] = "19:3,5,7,11",
	[506] = "3:3,6,9,11",
	[507] = "15:3,9,12",
	[508] = "11:3,4,7",
	[509] = "11:6,7,9",
	[511] = "19:3,5,11",
	[512] = "15:4,6,9,12",
	[513] = "11:3,4,5,6,7,8,9,10,11,12",
	[514] = "11:3,4,5,6,7,8,9,10,11,12",
	[515] = "11:3,4,5,6,7,8,9,10,11,12",
	[517] = "11:3,8",
	[518] = "33:3,6",
	[519] = "10:6,7,9",
	[521] = "5:10",
	[523] = "9:6,9",
	[525] = "11:3,5,12",
	[528] = "19:9,12",
	[529] = "11:4,7",
	[530] = "11:3,6,7,9",
	[532] = "13:4,6",
	[534] = "15:3,4,5,8,10",
	[535] = "11:3,9",
	[536] = "10:7,9",
	[537] = "10:3,4,6,7",
	[538] = "18:6,8",
	[539] = "7:3,5,10,11,12",
	[540] = "7:3,5,10,11,12",
	[541] = "12:5,6,7,9",
	[542] = "2:3,12",
	[543] = "15:3,5,9",
	[544] = "18:5,11,12",
	[545] = "11:3,5,8",
	[546] = "15:6,9,12",
	[547] = "14:3,5,7,9,10,11",
	[548] = "15:3,4,5,6,7,8,9,10,11,12",
	[549] = "11:3,5,10,11,12",
	[550] = "7:3,5,10,11,12",
	[552] = "15:3,4,6,7,11",
	[553] = "7:3,5,10,11,12",
	[554] = "15:3,7,9",
	[555] = "12:5,6,7,9",
	[556] = "15:6,9,12",
	[557] = "15:4,5,7,10,11",
	[558] = "11:8",
	[559] = "23:4,6,7,9",
	[560] = "2:3,5,10",
	[562] = "19:3,5,8",
	[564] = "34:3,6,12",
	[565] = "2:3,12",
	[566] = "6:3,9,12",
	[567] = "19:5,10",
	[568] = "26:3,9",
	[569] = "2:3,12",
	[570] = "11:3,10",
	[571] = "19:3,5",
	[572] = "10:4,6",
	[573] = "8:3,5,10,11",
	[626] = "19:4,5,7,8,10,11",
	[627] = "18:7,10",
	[628] = "10:3,10",
	[629] = "10:3,4,7",
	[630] = "11:3,5,8,10",
	[631] = "19:7,9",
	[632] = "19:3,10",
	[633] = "11:3,7,9,12",
	[634] = "3:3,9",
	[635] = "19:3,8,10",
	[637] = "11:3,5,11",
	[638] = "12:5,6,7,9",
	[639] = "7:3,5,10,11,12",
	[640] = "14:3,5,7,9,11,12",
	[641] = "14:3,5,7,9,11,12",
	[644] = "7:3,5,10,11,12",
	[645] = "11:3,8,9",
	[646] = "11:3,5,11,12",
	[647] = "11:3,5,8,10,11",
	[648] = "21:3,6,7,12",
	[649] = "21:3,7,8",
	[650] = "10:8",
	[652] = "11:11",
	[665] = "15:11",
	[671] = "11:8",
	[675] = "7:3,5,10,11,12",
	[677] = "11:3,5,8",
	[678] = "11:6,9",
	[679] = "11:5,11",
	[680] = "11:5,11",
	[699] = "3:3,9,11,12",
	[702] = "2:3,5,12",
	[703] = "11:3,11",
	[706] = "11:3,5,8",
	[707] = "11:3,5",
	[708] = "7:3,5,10,11,12",
	[709] = "7:3,5,11,12",
	[710] = "11:3,9,11",
	[711] = "11:3,5,11",
	[712] = "11:3,5,11",
	[713] = "21:3,9",
	[714] = "3:3,4,10,11",
	[716] = "3:7,9",
	[717] = "15:5,6,9,12",
	[718] = "11:3,8,9",
	[722] = "15:3,9,10,12",
	[723] = "21:3,6,9",
	[724] = "11:5,10",
	[725] = "11:3,11",
	[726] = "3:3,5,7",
	[727] = "11:3,5,8,11,12",
	[728] = "11:3,5,11,12",
	[729] = "14:3,5,7,9,11,12",
	[730] = "14:3,5,9,11,12",
	[731] = "3:7,9",
	[732] = "16:8,9",
	[733] = "11:3,5,11",
	[737] = "35:5,8",
	[739] = "29:5,8",
	[740] = "7:3,9,10,11,12",
	[741] = "11:3,12",
	[742] = "11:3,5",
	[743] = "26:3,5,12",
	[744] = "12:5,6,7,9,11,12",
	[745] = "11:3,9",
	[746] = "13:4,6",
	[747] = "15:3,9,10,12",
	[748] = "16:3,5,7,8,9,10,11,12",
	[749] = "11:5,11",
	[750] = "11:3,5,11",
	[751] = "7:3,9,11,12",
	[752] = "21:3,4,12",
	[753] = "15:3,9",
	[754] = "11:3,5,7,8,9,11,12",
	[755] = "30:8,10",
	[756] = "12:3,5,9",
	[757] = "10:5",
	[758] = "15:8",
	[792] = "16:3,12",
	[802] = "18:4",
	[817] = "10:7",
	[818] = "16:8",
	[819] = "15:5",
	[820] = "11:12",
	[821] = "11:11",
	[823] = "11:3,5,9,12",
	[834] = "10:7",
	[835] = "11:5",
	[836] = "20:5",
	[837] = "10:3,4,5,6,7,8,9,10,11,12",
	[838] = "11:3,4,5,6,7,8,9,10,11,12",
	[844] = "16:5",
	[845] = "11:3,8,10",
	[846] = "31:5",
	[847] = "11:12",
	[848] = "14:3,5,9",
	[849] = "11:3",
	[850] = "11:3",
	[851] = "19:3,5,7",
	[855] = "15:3",
	[856] = "11:9,12",
	[868] = "11:9",
	[872] = "11:3",
	[873] = "11:3",
	[874] = "11:3",
	[875] = "11:8",
	[876] = "11:7",
	[877] = "11:9",
	[878] = "11:3",
	[879] = "11:7",
	[880] = "11:7",
	[881] = "11:8",
	[882] = "11:9",
	[883] = "11:6",
	[884] = "11:8",
	[885] = "11:8",
	[886] = "11:9",
	[887] = "11:8",
	[888] = "11:3",
	[889] = "11:3",
	[890] = "11:3",
	[891] = "11:5",
	[892] = "11:8",
	[893] = "11:3",
	[894] = "11:5",
	[895] = "11:8",
	[896] = "11:6",
	[897] = "11:9",
	[898] = "11:3",
	[899] = "11:8",
	[900] = "11:6",
	[901] = "11:6",
	[902] = "11:9",
	[903] = "23:10",
	[904] = "11:9",
	[905] = "11:8",
	[906] = "11:5",
	[907] = "11:9",
	[908] = "11:8",
	[909] = "11:5",
	[911] = "16:7",
	[912] = "16:4",
	[913] = "16:8",
	[915] = "11:7",
	[916] = "11:8",
	[917] = "11:6",
	[921] = "11:7",
	[922] = "11:4",
	[923] = "2:6",
	[924] = "11:9",
	[925] = "11:7",
	[926] = "11:8",
	[927] = "11:5",
	[928] = "11:8",
	[929] = "11:9",
	[931] = "11:9",
	[932] = "11:6",
	[933] = "11:5",
	[934] = "11:6",
	[935] = "11:8",
	[936] = "11:3",
	[937] = "11:8",
	[938] = "11:9",
	[939] = "11:7",
	[941] = "11:8",
	[942] = "11:6",
	[943] = "11:9",
	[944] = "11:6",
	[945] = "11:7",
	[946] = "11:5",
	[947] = "11:9",
	[948] = "11:5",
	[949] = "11:8",
	[950] = "11:6",
	[951] = "11:7",
	[952] = "11:7",
	[953] = "11:6",
	[954] = "11:3",
	[955] = "11:5",
	[956] = "11:6",
	[957] = "11:8",
	[958] = "11:3",
	[959] = "11:8",
	[960] = "11:4",
	[961] = "11:4",
	[962] = "11:8",
	[963] = "11:7",
	[964] = "11:3",
	[965] = "11:3",
	[966] = "11:9",
	[967] = "11:8",
	[968] = "11:7",
	[969] = "11:9",
	[970] = "11:8",
	[971] = "11:7",
	[972] = "11:9",
	[973] = "11:8",
	[974] = "11:8",
	[975] = "11:6",
	[976] = "11:7",
	[977] = "11:9",
	[978] = "11:8",
	[979] = "11:6",
	[980] = "11:6",
	[981] = "11:8",
	[982] = "11:5",
	[983] = "11:6",
	[984] = "11:9",
	[985] = "11:7",
	[986] = "11:4",
	[987] = "11:9",
	[988] = "11:8",
	[989] = "11:9",
	[990] = "11:5",
	[991] = "11:8",
	[992] = "11:6",
	[993] = "11:5",
	[994] = "11:8",
	[995] = "11:9",
	[996] = "11:6",
	[997] = "11:7",
	[998] = "11:9",
	[999] = "11:6",
	[1000] = "11:8",
	[1001] = "11:8",
	[1002] = "11:9",
	[1003] = "11:9",
	[1004] = "11:9",
	[1005] = "11:9",
	[1006] = "11:6",
	[1007] = "11:4",
	[1008] = "11:6",
	[1009] = "11:7",
	[1010] = "11:8",
	[1011] = "11:7",
	[1012] = "11:5",
	[1013] = "21:3,6,9",
	[1039] = "6:6",
	[1040] = "11:6",
	[1042] = "36:8",
	[1061] = "11:5",
	[1062] = "7:3,9,10,12",
	[1063] = "18:8",
	[1065] = "18:8",
	[1066] = "11:10",
	[1067] = "2:7",
	[1068] = "11:3,5,8,10",
	[1073] = "11:12",
	[1117] = "37:3",
	[1124] = "11:8",
	[1125] = "11:3",
	[1126] = "11:7",
	[1127] = "15:8",
	[1128] = "11:3,12",
	[1129] = "38:7",
	[1130] = "11:8",
	[1131] = "11:11",
	[1132] = "11:5",
	[1133] = "11:10",
	[1134] = "11:9",
	[1135] = "11:12",
	[1136] = "11:3",
	[1137] = "11:6",
	[1138] = "11:9",
	[1139] = "11:8",
	[1140] = "11:3",
	[1141] = "11:7",
	[1142] = "2:11",
	[1143] = "11:8",
	[1144] = "11:9",
	[1145] = "11:5",
	[1146] = "11:7",
	[1147] = "11:4",
	[1149] = "11:8",
	[1150] = "11:9",
	[1151] = "11:7",
	[1152] = "15:6",
	[1153] = "11:4",
	[1154] = "11:9",
	[1155] = "16:6",
	[1156] = "11:8",
	[1157] = "11:3,12",
	[1158] = "11:12",
	[1159] = "15:12",
	[1160] = "10:8",
	[1161] = "16:4,8,10",
	[1162] = "5:5,8",
	[1163] = "9:6,7",
	[1164] = "19:3,5,11",
	[1165] = "16:4,8,10",
	[1166] = "16:4,8,10",
	[1167] = "16:4,8,10",
	[1168] = "11:12",
	[1174] = "15:12",
	[1175] = "11:3,12",
	[1176] = "11:3",
	[1177] = "9:6,7,9,10",
	[1178] = "11:4",
	[1179] = "16:3",
	[1180] = "3:4,5,8,10",
	[1181] = "19:6,9",
	[1182] = "2:3,12",
	[1183] = "11:4",
	[1184] = "39:4",
	[1185] = "11:9",
	[1187] = "40:4",
	[1188] = "41:3",
	[1189] = "42:9",
	[1190] = "43:11",
	[1191] = "44:6",
	[1192] = "45:10",
	[1193] = "46:12",
	[1194] = "47:8",
	[1195] = "48:5",
	[1196] = "11:9",
	[1197] = "11:7",
	[1198] = "11:8",
	[1200] = "39:8",
	[1201] = "3:10",
	[1202] = "7:3,10",
	[1204] = "2:11",
	[1205] = "39:3,6,7,9,10",
	[1206] = "19:10",
	[1207] = "37:12",
	[1208] = "19:11",
	[1209] = "19:3",
	[1211] = "3:4,5,8,10",
	[1212] = "3:4,5,8,10",
	[1213] = "3:4,5,8,10",
	[1226] = "15:3,4,5,8,10",
	[1227] = "10:6,7,9",
	[1228] = "49:4,6,8",
	[1229] = "50:5,8,10",
	[1230] = "51:6,7,9",
	[1231] = "11:3,10,11,12",
	[1232] = "52:3,10,12",
	[1233] = "53:4,6,7,8",
	[1234] = "39:3,6,7,9",
	[1235] = "11:5,11,12",
	[1236] = "54:8",
	[1237] = "49:8",
	[1238] = "18:3,6",
	[1243] = "11:8",
	[1244] = "11:7",
	[1245] = "11:3,6,9",
	[1247] = "55:8",
	[1248] = "39:3",
	[1255] = "56:8",
	[1256] = "11:10,11",
	[1257] = "11:3",
	[1258] = "24:8",
	[1259] = "57:6",
	[1266] = "49:4",
	[1267] = "58:8",
	[1268] = "59:6",
	[1269] = "60:4",
	[1271] = "7:3",
	[1276] = "11:4,5,8",
	[1277] = "10:5",
	[1278] = "61:4",
	[1279] = "10:6",
	[1280] = "10:6",
	[1281] = "62:5",
	[1282] = "60:8",
	[1283] = "27:4",
	[1284] = "63:6",
	[1285] = "7:5",
	[1286] = "64:5",
	[1287] = "65:4",
	[1288] = "25:6",
	[1289] = "66:4",
	[1290] = "39:3",
	[1291] = "25:3",
	[1292] = "67:7",
	[1293] = "68:5",
	[1295] = "69:8",
	[1296] = "70:6",
	[1297] = "71:5",
	[1298] = "11:4",
	[1299] = "11:5",
	[1300] = "11:4",
	[1301] = "11:6",
	[1303] = "51:8",
	[1304] = "3:8",
	[1305] = "10:8",
	[1311] = "72:8",
	[1317] = "73:8",
	[1319] = "74:6",
	[1320] = "11:5",
	[1321] = "16:4,5,7,8,10",
	[1322] = "18:4,6,7",
	[1323] = "54:3,4,5,10,11",
	[1324] = "11:3,8,9,11",
	[1325] = "11:3,8,9",
	[1326] = "11:3,8,9",
	[1328] = "11:3,6,7,9,12",
	[1329] = "11:5,8,9,11",
	[1330] = "19:3,4,5,6,8",
	[1331] = "11:4,8,10",
	[1332] = "11:4,5,6",
	[1333] = "75:3,5,8,9",
	[1334] = "19:6,7,9",
	[1335] = "11:8",
	[1336] = "11:3,6,7,9,12",
	[1337] = "23:4,6",
	[1338] = "2:3,7,12",
	[1339] = "76:3",
	[1343] = "11:4,5,7,8,9",
	[1344] = "39:7",
	[1345] = "11:6,9",
	[1346] = "11:9",
	[1348] = "11:8",
	[1349] = "52:4",
	[1350] = "11:3",
	[1351] = "11:7",
	[1352] = "77:6",
	[1354] = "78:3",
	[1363] = "11:8",
	[1364] = "79:4",
	[1365] = "11:9",
	[1385] = "11:4,10",
	[1386] = "80:4",
	[1387] = "16:4,6,7,8,10",
	[1394] = "10:6",
	[1395] = "11:6",
	[1396] = "10:8,10",
	[1400] = "4:4",
	[1401] = "11:3",
	[1402] = "11:9",
	[1403] = "11:4,7,10,11",
	[1409] = "81:8",
	[1411] = "11:10",
	[1412] = "11:4,5,6",
	[1416] = "11:7",
	[1424] = "83:11",
	[1426] = "84:6",
	[1427] = "85:3,4,5,6,7,8,12",
	[1428] = "11:7",
	[1430] = "11:12",
	[1432] = "11:3,4,5,6,7,9,10,11",
	[1434] = "11:5,10,12",
	[1435] = "33:3,6",
	[1441] = "2:3,12",
	[1442] = "11:6",
	[1443] = "86:12",
	[1444] = "83:3",
	[1446] = "11:10",
	[1447] = "11:4,6,7,8",
	[1450] = "11:8",
	[1451] = "11:5",
	[1455] = "11:3,10,11,12",
	[1456] = "11:3,10,11,12",
	[1457] = "11:3,10,11,12",
	[1462] = "11:3,10,11,12",
	[1463] = "11:3,10,11,12",
	[1464] = "11:3,10,11,12",
	[1465] = "11:3,10,11,12",
	[1467] = "11:4,5",
	[1469] = "87:3,4,7,10,12",
	[1470] = "87:3,4,7,10,12",
	[1471] = "11:10",
	[1472] = "88:3",
	[1473] = "89:3",
	[1474] = "72:6",
	[1475] = "83:6",
	[1476] = "83:4",
	[1477] = "83:8",
	[1478] = "11:7",
	[1479] = "90:4",
	[1480] = "91:8",
	[1482] = "92:4",
	[1483] = "93:8",
	[1484] = "11:3",
	[1485] = "94:6",
	[1486] = "95:11",
	[1487] = "96:3",
	[1488] = "97:3",
	[1489] = "98:6",
	[1490] = "99:6",
	[1492] = "9:7",
	[1493] = "100:10",
	[1494] = "11:12",
	[1495] = "101:3,4,10,11",
	[1496] = "102:10",
	[1497] = "87:4",
	[1498] = "23:8",
	[1499] = "97:3",
	[1500] = "103:3",
	[1501] = "104:3",
	[1502] = "25:3",
	[1503] = "105:3",
	[1504] = "106:3",
	[1505] = "11:3",
	[1506] = "11:3",
	[1507] = "107:3",
	[1508] = "11:3",
	[1509] = "108:3",
	[1510] = "18:3",
	[1515] = "11:4,8",
	[1516] = "11:10",
	[1518] = "16:4",
	[1521] = "11:8",
	[1523] = "11:5",
	[1524] = "11:7,9",
	[1530] = "11:4",
	[1531] = "12:7",
	[1532] = "23:8",
	[1533] = "13:8",
	[1537] = "11:6",
	[1538] = "11:5",
	[1540] = "11:8",
	[1541] = "11:4,10",
	[1542] = "11:8",
	[1543] = "9:4,7",
	[1544] = "11:10",
	[1545] = "11:3,12",
	[1546] = "11:10",
	[1547] = "11:3",
	[1548] = "25:6",
	[1549] = "109:3",
	[1550] = "11:4",
	[1552] = "11:5",
	[1553] = "11:7",
	[1554] = "11:7",
	[1555] = "11:7",
	[1556] = "110:6",
	[1557] = "11:4",
	[1558] = "11:7",
	[1559] = "11:7",
	[1560] = "111:7",
	[1561] = "112:7",
	[1562] = "113:7",
	[1563] = "11:4,5,7,9",
	[1564] = "11:7",
	[1565] = "11:4,5,7,10,11",
	[1566] = "11:5",
	[1568] = "11:8",
	[1569] = "114:7",
	[1570] = "23:8",
	[1571] = "11:3",
	[1572] = "11:3,4,5,9,10",
	[1573] = "11:3,4,5,9,10",
	[1574] = "115:8",
	[1576] = "116:4",
	[1578] = "23:4,6",
	[1579] = "23:4,6",
	[1582] = "23:4,6",
	[1583] = "23:4,6",
	[1587] = "11:3,8,9",
	[1590] = "7:3,9,10,12",
	[1593] = "7:3,9,10,12",
	[1594] = "11:3,6,7,9",
	[1595] = "11:3,6,7,9",
	[1596] = "23:8",
	[1597] = "23:8",
	[1599] = "21:3,6,9",
	[1601] = "116:4",
	[1602] = "116:8",
	[1605] = "27:7",
	[1607] = "72:6",
	[1608] = "89:3",
	[1609] = "88:3",
	[1615] = "19:3,5,7",
}