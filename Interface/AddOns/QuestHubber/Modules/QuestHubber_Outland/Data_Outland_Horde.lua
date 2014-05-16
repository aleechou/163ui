local qhub = QuestHubber
if not qhub then return end

local fg = UnitFactionGroup("player")
if fg == "Horde" then

qhub:RegisterQuests({
	[465] = {
		[10087] = "16:0:0:61:58:5520:3860:21283:Megzeg Nukklebust::10086:0:0",
		[10220] = "16:0:0:61:58:6160:8159:19682:Emissary Mordiba::0:0:0",
		[9466] = "32:0:0:63:58:2800:6030:181638:Wanted Poster::0:0:0",
		[9340] = "16:0:0:62:60:2839:6020:16789:Ranger Captain Venn'ren::9498&9499:9391:0",
		[10103] = "16:0:0:61:61:2839:6020:16789:Ranger Captain Venn'ren::0:0:0",
		[9472] = "16:0:0:62:60:2640:6040:16793:Magistrix Carinda::10287:0:0",
		[13411] = "1040:32:0:60:55:5580:3900:18267:Battlecryer Blackeye::0:0:0",
		[10875] = "16:0:0:61:58:5220:3640:16588:Apothecary Antonivich::10838:10876:0",
		[10876] = "16:0:0:63:58:5500:3600:3230:Nazgrel::10875:0:0",
		[10242] = "16:0:0:60:58:6620:4200:21257:Apothecary Zelana::0:0:0",
		[10120] = "16:0:0:61:58:8740:4980:19253:Lieutenant General Orion::9407&28705:10289:10162",
		[10756] = "16:0:0:70:68:5500:3600:3230:Nazgrel::10755:10757:10758",
		[10757] = "16:0:0:70:68:5320:3820:16583:Rohok::10756:10758:0",
		[10758] = "16:0:0:70:68:5320:3820:16583:Rohok::10757:0:0",
		[10124] = "16:0:0:61:58:5800:4120:19256:Sergeant Shatterskull::10123:10208:10162",
		[9366] = "16:0:0:62:60:2700:5960:16791:Ryathen the Somber::0:9370:0",
		[10129] = "16:0:0:62:58:6580:4360:19273:Forward Commander To'arch::10208:10162:0",
		[10258] = "16:0:0:61:58:6160:8159:19736:Althen the Historian::10250:0:0",
		[9370] = "16:0:0:62:60:2700:5960:16791:Ryathen the Somber::9366:0:0",
		[9498] = "16:0:0:62:60:5520:3900:16577:Martik Tor'seldori::0:9340:9391",
		[9499] = "16:0:512:62:60:5520:3900:16577:Martik Tor'seldori::0:9340:9391",
		[10389] = "16:0:0:61:58:5500:3600:21175:Magister Bloodhawk::0:0:0",
		[10136] = "16:0:0:63:58:5500:3600:3230:Nazgrel::0:0:0",
		[10391] = "16:0:0:61:58:5500:3600:3230:Nazgrel::10390:10392:0",
		[9376] = "16:0:0:63:61:2700:6180:17015:Taleris Dawngazer::9375:0:0",
		[10393] = "18:0:0:61:58:6580:2980:20798:Razorsaw::0:0:0",
		[9381] = "16:0:0:63:61:2760:6040:16790:Falconer Drenna Riverwind::0:0:0",
		[9387] = "16:0:0:63:60:2680:5960:16794:Apothecary Azethen::0:0:0",
		[10278] = "16:0:0:61:58:6180:8139:19683:Ogath the Mad::0:10294:10295",
		[9391] = "16:0:0:62:60:2839:6020:16789:Ranger Captain Venn'ren::9340:0:0",
		[10538] = "16:0:0:60:58:6120:8159:21279:Apothecary Albreck::0:10835:10876",
		[9396] = "16:0:0:62:60:2700:5980:16792:Arcanist Calesthris Dawnstar::0:0:0",
		[9397] = "16:0:0:62:60:2760:6040:16790:Falconer Drenna Riverwind::0:0:0",
		[10287] = "16:0:0:62:60:2600:6300:20159:Magister Aledis::10286:9472:0",
		[9400] = "16:0:0:62:60:5500:3600:3230:Nazgrel::0:9401:9406",
		[9401] = "16:0:0:62:60:3360:4360:17062:Fel Orc Corpse::9400:9405:9406",
		[10291] = "16:0:0:61:58:5580:3680:19255:General Krakork::10289:10121:10162",
		[10294] = "16:0:0:61:58:6180:8139:19683:Ogath the Mad::10278:10295:0",
		[10295] = "16:0:0:63:58:6180:8139:19683:Ogath the Mad::10294:0:0",
		[9410] = "16:0:0:62:60:5420:3780:16574:Far Seer Regulkut::9405:9406:0",
		[10809] = "32:0:0:60:58:6120:8060:185166:Wanted Poster::0:0:0",
		[10813] = "16:0:0:62:58:6160:8179:22231:Zezzak::0:10834:0",
		[10162] = "16:0:0:62:58:6580:4360:19273:Forward Commander To'arch::10129:0:0",
		[10289] = "16:0:0:61:58:8740:4820:18930:Vlagga Freyfeather::10120:10291:10162",
		[10864] = "16:0:0:61:58:5220:3640:16588:Apothecary Antonivich::10835:10838:10876",
		[10442] = "16:0:0:61:61:2760:6040:16790:Falconer Drenna Riverwind::0:9372:10255",
		[10286] = "16:0:0:62:60:2640:6040:16793:Magistrix Carinda::9374:10287:9472",
		[10121] = "16:0:0:61:58:5500:3600:3230:Nazgrel::10291:10123:10162",
		[10230] = "16:0:0:61:58:6160:8159:19736:Althen the Historian::10229:10250:10258",
		[10123] = "16:0:0:61:58:5800:4120:19256:Sergeant Shatterskull::10121:10124:10162",
		[10388] = "16:0:0:61:58:6580:4360:19273:Forward Commander To'arch::0:10390:10392",
		[10250] = "16:0:0:61:58:6160:8159:19736:Althen the Historian::10230:10258:0",
		[10449] = "16:0:0:60:58:5500:3620:21256:Vurtok Axebreaker::10450:0:0",
		[10450] = "16:0:0:60:58:5500:3620:21256:Vurtok Axebreaker::0:10449:0",
		[10792] = "16:0:0:61:58:6120:8120:22107:Captain Darkhowl::0:0:0",
		[9405] = "16:0:0:62:60:5500:3600:3230:Nazgrel::9401:9410:9406",
		[10834] = "16:0:0:62:58:6160:8179:22231:Zezzak::10813:0:0",
		[10835] = "16:0:0:61:58:6120:8159:21279:Apothecary Albreck::10538:10864:10876",
		[9374] = "16:0:0:62:60:2640:6040:16793:Magistrix Carinda::0:10286:9472",
		[9406] = "16:0:0:62:60:3200:2780:16845:Gorkan Bloodfist::9410:0:0",
		[10838] = "16:0:0:61:58:5220:3640:16588:Apothecary Antonivich::10864:10875:10876",
		[9442] = "16:0:0:63:60:3200:2819:17123:Earthcaller Ryga::0:9447:0",
		[9375] = "16:0:0:63:61:2460:7600:16993:Wounded Blood Elf Pilgrim::0:9376:0",
		[9345] = "16:0:0:61:58:6100:8159:16858:Grelag::0:10213:0",
		[13409] = "1040:0:0:60:55:5580:3900:18267:Battlecryer Blackeye::0:0:0",
		[10208] = "16:0:0:62:58:6580:4360:19273:Forward Commander To'arch::10124:10129:10162",
		[9447] = "16:0:0:63:60:3200:2819:17123:Earthcaller Ryga::9442:0:0",
		[10390] = "16:0:0:61:58:5500:3600:3230:Nazgrel::10388:10391:10392",
		[10229] = "18:0:0:61:58:5540:8280:16906:Unyielding Knight::0:10230:10258",
		[10392] = "16:0:0:61:58:5500:3600:3230:Nazgrel::10391:0:0",
		[10213] = "16:0:0:61:58:6100:8159:16858:Grelag::9345:0:0",
		[10086] = "16:0:0:61:58:5520:3860:21283:Megzeg Nukklebust::0:10087:0",
	},
	[473] = {
		[10751] = "16:0:0:70:68:5200:6520:21998:Kor'kron Wind Rider::10750:10765:10769",
		[10595] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::11048:10596:10600",
		[10627] = "16:0:0:69:67:2980:3120:19333:Grokom Deatheye::10623:0:0",
		[10596] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::10595:10597:10600",
		[11069] = "16:0:0:70:70:6520:8500:23345:Wing Commander Ichman::0:0:0",
		[10660] = "16:0:0:69:67:3000:2819:21770:Researcher Tiorus::0:10672:10673",
		[11070] = "16:0:0:70:70:6520:8500:23346:Wing Commander Mulverick::0:0:0",
		[10598] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::10597:10599:10600",
		[10599] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::10598:10600:0",
		[10663] = "16:0:0:69:67:2980:3120:19333:Grokom Deatheye::10626:10664:0",
		[10601] = "16:0:0:69:67:3860:3820:21475:Scout Zagran::0:0:0",
		[10633] = "16:0:0:70:67:2980:2760:21772:Chief Apothecary Hildagard::10625:0:0",
		[10602] = "16:0:0:69:67:3860:3820:21475:Scout Zagran::0:0:0",
		[10760] = "16:0:0:69:67:3100:2980:22043:Sergeant Kargrul::0:10761|10759:10808",
		[10603] = "16:0:0:69:67:3860:3820:21475:Scout Zagran::0:10604:10745",
		[10761] = "16:0:0:69:67:3100:2980:22043:Sergeant Kargrul::10760|10569:10777:10808",
		[10604] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::10603:10767:10745",
		[10765] = "16:0:0:70:68:5200:6520:21998:Kor'kron Wind Rider::10751:10768:10769",
		[10672] = "16:0:0:69:67:3000:2819:21770:Researcher Tiorus::10660:10673:0",
		[10767] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::10604:10611:10745",
		[10673] = "16:0:0:70:67:3000:2819:21770:Researcher Tiorus::10672:0:0",
		[10768] = "16:0:0:70:68:5200:6520:21998:Kor'kron Wind Rider::10765:10769:0",
		[10611] = "16:0:0:69:67:2740:2120:21789:Nakansi::10767:10613:10745",
		[10769] = "16:0:0:70:68:5200:6520:21998:Kor'kron Wind Rider::10768:0:0",
		[10613] = "16:0:0:69:67:2740:2120:21789:Nakansi::10611:10745:0",
		[10647] = "32:0:0:70:67:3040:3090:184945:Wanted Poster::0:0:0",
		[10681] = "16:0:0:70:68:2839:2640:21938:Earthmender Splinthoof::0:10458:10519",
		[10745] = "16:0:0:70:67:2740:2120:21789:Nakansi::10613:0:0",
		[10624] = "16:0:0:69:67:2980:2760:21772:Chief Apothecary Hildagard::11046:10625:10633",
		[10600] = "16:0:0:69:67:3860:3820:21475:Scout Zagran::10599:0:0",
		[10702] = "16:0:0:69:67:2839:2640:21769:Overlord Or'barokh::0:0:0",
		[10755] = "18:0:0:70:68:6760:3640:22037:Smith Gorlunk::0:10756:10758",
		[10639] = "16:0:0:70:67:5820:7080:21797:Ancient Shadowmoon Spirit::0:0:0",
		[11095] = "16:0:0:70:70:5620:5960:21955:Arcanist Thelis::11094:0:0",
		[10623] = "18:0:0:69:67:2220:3540:21499:Overseer Ripsaw::0:10627:0",
		[10625] = "16:0:0:69:67:2980:2760:21772:Chief Apothecary Hildagard::10624:10633:0",
		[10750] = "16:0:0:70:68:2839:2640:21769:Overlord Or'barokh::0:10751:10769",
		[10597] = "16:0:0:69:67:3040:3240:21359:Blood Guard Gulmok::10596:10598:10600",
	},
	[467] = {
		[9770] = "16:0:0:62:60:8500:5400:18012:Reavij::0:9898:0",
		[9771] = "16:0:0:62:59:8520:5460:18011:Zurai::9774:9772:0",
		[9903] = "16:0:0:64:62:3220:4960:18018:Zurjaya::9845:0:0",
		[10105] = "16:0:0:62:62:3060:5080:18013:Shadow Hunter Denjai::0:0:0",
		[9772] = "16:0:0:62:60:8080:3620:18035:Scout Jyoba::9771:0:0",
		[9904] = "16:0:0:64:62:3220:4960:18018:Zurjaya::0:0:0",
		[9842] = "16:0:0:64:62:3160:4920:18015:Gambarinka::9841:0:0",
		[9796] = "16:0:0:62:62:8520:5460:18011:Zurai::0:0:0",
		[9841] = "16:0:0:64:62:3160:4920:18015:Gambarinka::0:9842:0",
		[9775] = "16:0:0:62:62:8520:5460:18011:Zurai::0:0:0",
		[9820] = "32:0:0:64:58:3200:4940:182165:Wanted Poster::0:9822:9823",
		[9828] = "18:0:0:62:60:8080:3620:18124:Withered Giant::0:0:0",
		[9898] = "16:0:0:62:60:8500:5400:18012:Reavij::9770:0:0",
		[9774] = "16:0:0:62:59:8520:5460:18011:Zurai::0:9771:9772",
		[9797] = "16:0:0:64:64:3200:5040:18091:Messenger Gazgrigg::0:0:0",
		[9795] = "16:0:0:65:64:3060:5080:18013:Shadow Hunter Denjai::0:0:0",
		[9899] = "16:0:0:62:60:8440:5440:18016:Magasha::0:0:0",
		[9845] = "16:0:0:64:62:3220:4960:18018:Zurjaya::0:9903:0",
		[9822] = "16:0:0:64:62:3060:5080:18013:Shadow Hunter Denjai::9820:9823:0",
		[9814] = "16:0:0:64:62:3280:4880:18014:Witch Doctor Tor'gash::0:9816:0",
		[10117] = "32:0:0:64:58:3200:4940:182165:Wanted Poster::0:0:0",
		[9846] = "16:0:0:62:60:3240:5180:18017:Seer Janidi::0:9847:0",
		[9823] = "16:0:0:64:62:3060:5080:18013:Shadow Hunter Denjai::9822:0:0",
		[9769] = "16:0:0:62:60:8440:5440:18016:Magasha::0:0:0",
		[10118] = "16:0:0:64:62:3060:5080:18013:Shadow Hunter Denjai::0:0:0",
		[9816] = "16:0:0:64:62:3280:4880:18014:Witch Doctor Tor'gash::9814:0:0",
		[9847] = "16:0:0:64:60:3240:5180:18017:Seer Janidi::9846:0:0",
	},
	[475] = {
		[10845] = "16:0:0:68:65:7520:6080:22004:Leoroxx::10843:0:0",
		[10846] = "16:0:0:67:65:7520:6080:22004:Leoroxx::0:10843:10845",
		[11036] = "16:0:0:67:67:5300:5440:19471:Old Orok::0:10186:0",
		[10785] = "16:0:0:67:65:5320:4100:22103:Baron Sablemane::10721:10723:10742",
		[10565] = "16:0:0:66:61:7520:6200:21496:Dertrok::0:0:0",
		[10786] = "16:0:0:68:65:5180:5840:21147:Tor'chunk Twoclaws::0:0:0",
		[10566] = "16:0:0:66:61:7520:6200:21496:Dertrok::0:10615:0",
		[10724] = "16:0:0:67:65:5180:5840:21984:Rexxar::10723:10742:0",
		[10851] = "16:0:0:67:65:7480:6040:22312:Spiritcaller Dohgar::0:10853:10865",
		[10505] = "16:0:0:66:65:5180:5840:21147:Tor'chunk Twoclaws::10503:0:0",
		[10853] = "16:0:0:67:65:7480:6040:22312:Spiritcaller Dohgar::10851:10859:10865",
		[10542] = "16:0:0:66:65:4500:7220:21349:T'chali the Witch Doctor::0:10545:10544",
		[11047] = "16:0:0:67:67:5200:5440:23280:Agadai::0:0:0",
		[10859] = "16:0:0:67:65:7480:6040:22312:Spiritcaller Dohgar::10853:10865:0",
		[10860] = "16:0:0:67:65:7600:6020:21088:Matron Varah::0:0:0",
		[10867] = "16:0:0:68:65:7520:6080:22004:Leoroxx::0:0:0",
		[10865] = "16:0:0:68:65:7480:6040:22312:Spiritcaller Dohgar::10859:0:0",
		[10545] = "16:0:0:66:65:4500:7220:21349:T'chali the Witch Doctor::10542:10543:10544",
		[10928] = "16:0:0:65:65:5300:9620:22489:Grunt Grahk::0:0:0",
		[10486] = "16:0:0:66:65:5220:5760:21117:Gor'drek::0:10487:10488",
		[10544] = "16:0:0:66:65:4500:7220:21349:T'chali the Witch Doctor::10543:0:0",
		[10487] = "16:0:0:66:65:5220:5760:21117:Gor'drek::10486:10488:0",
		[10543] = "16:0:0:67:65:4500:7220:21349:T'chali the Witch Doctor::10545:10544:0",
		[10614] = "16:0:0:66:65:5180:5840:21984:Rexxar::10718:10709:10715",
		[10709] = "16:0:0:67:65:7520:6080:22004:Leoroxx::10614:10714:10715",
		[10489] = "32:0:0:66:65:5190:5780:184660:Wanted Poster::0:0:0",
		[10723] = "16:0:0:68:65:5180:5840:21984:Rexxar::10785:10724:10742",
		[10742] = "16:0:0:70:65:5180:5840:21984:Rexxar::10724:0:0",
		[10615] = "16:0:0:64:61:7520:6200:21496:Dertrok::10566:0:0",
		[10617] = "16:0:0:66:61:7580:6140:21895:Taerek::0:0:0",
		[10721] = "16:0:0:67:65:5180:5840:21984:Rexxar::10720:10785:10742",
		[10618] = "16:0:0:65:61:7580:6140:21896:Silmara::0:0:0",
		[10524] = "18:0:0:66:65:4320:4600:19995:Bladespire Brute::0:10525:10526",
		[10784] = "16:0:0:67:65:5180:5840:21147:Tor'chunk Twoclaws::0:0:0",
		[10714] = "16:0:0:67:65:5180:5840:21984:Rexxar::10709:10783:10715",
		[10720] = "16:0:0:67:65:5180:5840:21984:Rexxar::10749:10721:10742",
		[10715] = "16:0:0:67:65:5320:4100:22103:Baron Sablemane::10783:0:0",
		[10783] = "16:0:0:67:62:5180:5840:21984:Rexxar::10714:10715:0",
		[10526] = "16:0:0:67:65:5280:5880:21311:Rokgah Bloodgrip::10525:0:0",
		[10503] = "16:0:0:66:65:5180:5840:21147:Tor'chunk Twoclaws::0:10505:0",
		[10843] = "16:0:0:68:65:7520:6080:22004:Leoroxx::10846:10845:0",
		[10749] = "16:0:0:67:65:5320:4100:22103:Baron Sablemane::0:10720:10742",
		[10718] = "16:0:0:67:65:5260:5880:21950:Garm Wolfbrother::0:10614:10715",
		[10488] = "16:0:0:66:65:5220:5760:21117:Gor'drek::10487:0:0",
		[10525] = "16:0:0:66:65:5280:5880:21311:Rokgah Bloodgrip::10524:10526:0",
	},
	[477] = {
		[9870] = "16:0:0:66:64:5560:3780:18234:Elementalist Yal'hah::0:0:0",
		[9934] = "16:0:0:66:64:7380:6260:18261:Lantresor of the Blade::0:0:0",
		[11037] = "16:0:0:67:67:5560:3720:23265:Seer Nakha::0:10186:0",
		[9872] = "18:0:0:67:64:3100:5860:18238:Murkblood Invader::0:0:0",
		[9937] = "16:0:0:67:66:5580:3780:18407:Warden Bullrok::0:0:0",
		[9906] = "16:0:0:65:64:5560:3760:18106:Jorin Deadeye::9891:9907:10107",
		[9907] = "16:0:0:66:64:5560:3760:18106:Jorin Deadeye::9906:10107:0",
		[9939] = "32:0:0:66:64:5570:3800:182392:Garadar Bulletin Board::0:0:0",
		[9910] = "16:0:0:65:64:5560:3760:18300:Elkay'gan the Mystic::0:9916:0",
		[10101] = "16:0:0:68:66:2600:6060:18687:Mother Kashur::10085:10102:10172",
		[9944] = "16:0:0:67:65:5659:3420:18302:Matron Drakia::0:9945:9946",
		[10102] = "16:0:0:68:66:3540:7760:17545:K'ure::10101:10167:10172",
		[9945] = "16:0:0:67:65:3220:3620:18414:Elder Yorley::9944:9946:0",
		[11048] = "16:0:0:67:67:5540:3740:18090:Captain Kroghan::0:10595:10600",
		[9946] = "16:0:0:67:65:3220:3620:18414:Elder Yorley::9945:0:0",
		[9916] = "16:0:0:66:64:5560:3760:18300:Elkay'gan the Mystic::9910:0:0",
		[10074] = "1040:0:0:67:64:4120:4420:18816:Chief Researcher Amereldine::0:10075:0",
		[10107] = "16:0:0:66:64:5560:3760:18106:Jorin Deadeye::9907:0:0",
		[10171] = "16:0:0:68:66:5659:3420:18141:Greatmother Geyah::10170:10172:0",
		[9888] = "16:0:0:65:64:5560:3760:18106:Jorin Deadeye::0:9889:10107",
		[10172] = "16:0:0:68:66:5540:3760:18063:Garrosh::10171:0:0",
		[10081] = "16:0:0:68:66:5659:3420:18141:Greatmother Geyah::10045:10082:10172",
		[10479] = "16:0:0:67:65:5580:3780:18407:Warden Bullrok::0:0:0",
		[10082] = "16:0:0:68:66:2600:6060:18687:Mother Kashur::10081:10085:10172",
		[10114] = "16:0:0:65:64:5540:3740:19133:Ohlorn Farstrider::0:0:0",
		[9935] = "32:0:0:66:64:5570:3800:182392:Garadar Bulletin Board::0:0:0",
		[9863] = "16:0:0:66:64:5480:3940:18066:Farseer Kurkush::0:0:0",
		[9948] = "16:0:0:67:65:3220:3620:18415:Elder Ungriz::0:0:0",
		[9864] = "16:0:0:67:64:5480:3980:18067:Farseer Corhuk::0:9865:9866",
		[10085] = "16:0:0:68:66:2600:6060:18687:Mother Kashur::10082:10101:10172",
		[9865] = "16:0:0:67:64:3240:3600:18229:Saurfang the Younger::9864:9866:0",
		[10044] = "16:0:0:68:66:5540:3760:18063:Garrosh::0:10045:10172",
		[9866] = "16:0:0:67:64:3240:3600:18229:Saurfang the Younger::9865:0:0",
		[10045] = "16:0:0:68:66:5659:3420:18141:Greatmother Geyah::10044:10081:10172",
		[9867] = "16:0:0:67:64:5460:3980:18068:Farseer Margadesh::0:0:0",
		[10170] = "16:0:0:68:66:2600:6060:18687:Mother Kashur::10168:10171:10172",
		[9868] = "16:0:0:67:64:3140:4400:18210:Mag'har Captive::0:0:0",
		[9983] = "16:0:0:68:66:5520:3600:18301:Matron Celestine::0:9991:10011",
	},
	[478] = {
		[10041] = "16:0:0:65:62:3900:4380:18714:Scout Neftis::10039:10043:0",
		[9987] = "16:0:0:64:62:4880:4460:18386:Rokag::0:0:0",
		[9995] = "16:0:0:64:62:4420:2620:18446:Earthbinder Tavgren::0:10448:10006",
		[10003] = "16:0:0:64:62:6320:4260:18566:Shadowstalker Kaide::0:0:0",
		[10027] = "16:0:0:64:62:4880:4560:18383:Kurgatok::0:0:0",
		[10043] = "16:0:0:65:62:3900:4380:18714:Scout Neftis::10041:0:0",
		[9997] = "16:0:0:64:62:6320:4240:21007:Sergeant Chawni::10448:10447:10006",
		[10036] = "16:0:0:65:63:4920:4580:18705:Mawg Grimshot::10034:0:0",
		[10447] = "16:0:0:65:62:6320:4240:21007:Sergeant Chawni::9997:10006:0",
		[10052] = "16:0:0:64:62:7380:3520:18760:Isla Starmane::0:0:0",
		[10034] = "32:0:0:65:62:4980:4520:182588:Wanted Poster::0:10036:0",
		[10006] = "16:0:0:63:62:5000:4580:18447:Tooki::10447:0:0",
		[10448] = "16:0:0:64:62:5000:4580:18447:Tooki::9995:9997:10006",
		[9960] = "16:0:0:63:62:5000:4580:18447:Tooki::0:9968:9990",
		[10013] = "32:0:0:64:62:6790:5350:182549:Fel Orc Plans::0:0:0",
		[9891] = "16:0:0:65:64:1960:6080:18273:Kilrath::9890:9906:10107",
		[10201] = "16:0:0:65:62:5000:4480:18385:Rakoria::9993:0:0",
		[10023] = "16:0:0:64:62:5000:4640:18384:Malukaz::10018:10791:0",
		[10868] = "16:0:0:62:60:4880:4460:18712:Advisor Faila::0:0:0",
		[10039] = "16:0:0:64:62:4880:4460:18712:Advisor Faila::0:10041:10043",
		[10791] = "16:0:0:64:62:5000:4640:18384:Malukaz::10023:0:0",
		[9993] = "16:0:0:63:62:5000:4480:18385:Rakoria::0:10201:0",
		[10018] = "16:0:0:64:62:5000:4640:18384:Malukaz::0:10023:10791",
		[9890] = "16:0:0:65:64:2000:6340:18262:Unkor the Ruthless::9889:9891:10107",
		[9889] = "16:0:0:65:64:1960:6080:18273:Kilrath::9888:9890:10107",
		[10862] = "16:0:0:63:62:4880:4460:18386:Rokag::0:10847:10889",
		[10008] = "16:0:0:64:62:6320:4260:18566:Shadowstalker Kaide::0:0:0",
		[10000] = "16:0:0:63:62:4880:4560:18383:Kurgatok::0:0:0",
	},
	[481] = {
		[11046] = "16:0:0:67:67:6460:7020:19678:Fantei::0:10624:10633",
	},
})
end