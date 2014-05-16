local qhub = QuestHubber
if not qhub then return end

local fg = UnitFactionGroup("player")
if fg == "Alliance" then

qhub:RegisterQuests({
	[486] = {
		[11873] = "16:0:0:71:68:6160:3580:25807:Iggy \"Tailspin\" Cogtoggle::11796:0:0",
		[12141] = "16:0:0:71:68:5659:7260:25301:Counselor Talbot::0:11613:11619",
		[11889] = "16:0:0:71:68:5639:6959:25816:Sergeant Hammerhill::11797:11897:0",
		[12019] = "16:0:0:72:68:8480:4160:26170:Thassarian::11942:0:0",
		[11897] = "16:0:0:71:68:5639:6959:25816:Sergeant Hammerhill::11889:0:0",
		[11645] = "16:0:0:71:69:5820:1840:25477:Crafty Wobblesprocket::0:11650:0",
		[11901] = "16:0:0:71:68:5820:6280:26083:Gerald Green::11928:11902:11965",
		[11902] = "32:0:0:71:68:5679:5560:188085:Plagued Grain::11901:11903:11965",
		[11903] = "16:0:0:71:68:5820:6280:26083:Gerald Green::11902:11904:11965",
		[11650] = "16:0:0:71:69:5820:1840:25477:Crafty Wobblesprocket::11645:0:0",
		[11653] = "16:0:0:71:69:5820:1840:25477:Crafty Wobblesprocket::0:11658:0",
		[12035] = "16:0:0:71:68:5820:6280:26084:Jeremiah Hawning::11908:0:0",
		[11658] = "16:0:0:71:69:5820:1840:25477:Crafty Wobblesprocket::11653:0:0",
		[11913] = "16:0:0:71:68:5820:6280:26085:Wendy Darren::0:0:0",
		[11788] = "16:0:0:71:68:5740:1880:25747:Jinky Wingnut::11712:11798:0",
		[11789] = "16:0:0:71:68:5500:6879:25825:Medic Hawthorn::0:0:0",
		[11790] = "32:0:0:71:68:5750:6919:187851:Cultist Shrine::0:0:0",
		[11791] = "16:0:0:71:68:5780:6919:25299:Admiral Cantlebree::0:0:0",
		[11792] = "16:0:0:71:68:5659:7240:25285:Harbinger Vurenn::0:11793:11794",
		[11920] = "32:0:0:71:68:5750:6919:187851:Cultist Shrine::0:0:0",
		[11794] = "16:0:0:71:68:5840:6740:25826:Vindicator Yaala::11793:0:0",
		[11795] = "16:0:0:71:68:6160:3580:25807:Iggy \"Tailspin\" Cogtoggle::11728:11796:11873",
		[11796] = "16:0:0:71:68:6160:3580:25807:Iggy \"Tailspin\" Cogtoggle::11795:11873:0",
		[11670] = "16:0:0:72:69:5820:1840:25477:Crafty Wobblesprocket::0:0:0",
		[11798] = "16:0:0:72:68:5740:1880:25747:Jinky Wingnut::11788:0:0",
		[11672] = "16:0:0:71:68:5780:6760:25307:Recruitment Officer Blythe::28709:0:0",
		[11927] = "16:0:0:71:68:5659:6939:26155:Mark Hanes::0:11599:12088",
		[11928] = "16:0:0:71:68:5639:6959:25816:Sergeant Hammerhill::0:11901:11965",
		[11932] = "16:0:0:71:68:5659:7140:25395:Private Brau::11604:12086:12088",
		[11938] = "16:0:0:72:68:8480:4160:26170:Thassarian::11956:11942:12019",
		[11942] = "16:0:0:72:68:8480:4160:26170:Thassarian::11938:12019:0",
		[11944] = "16:0:0:72:68:8200:4640:26187:Corporal Venn::12086:12088:0",
		[11692] = "16:0:0:71:68:5740:1860:25702:Mordle Cogspinner::11710:11693:11694",
		[11693] = "16:0:0:71:68:7340:1880:25705:Bixie Wrenchshanker::11692:11694:0",
		[11694] = "16:0:0:71:68:7340:1880:25705:Bixie Wrenchshanker::11693:0:0",
		[11697] = "16:0:0:71:68:7340:1880:25705:Bixie Wrenchshanker::0:11699:0",
		[11698] = "16:0:0:71:68:7340:1880:25705:Bixie Wrenchshanker::0:0:0",
		[11699] = "16:0:0:72:68:6979:1460:25714:Tinky Wickwhistle::11697:0:0",
		[11700] = "16:0:0:71:68:6979:1460:25714:Tinky Wickwhistle::0:0:0",
		[11701] = "16:0:0:71:68:7340:1880:25705:Bixie Wrenchshanker::0:0:0",
		[11956] = "16:0:0:71:68:8480:4160:26170:Thassarian::0:11938:12019",
		[11704] = "16:0:0:71:69:5740:1860:25702:Mordle Cogspinner::0:11571:0",
		[12086] = "16:0:0:72:68:6380:4600:26169:Ataika::11932:11944:12088",
		[12088] = "16:0:0:72:68:8200:4640:26187:Corporal Venn::11944:0:0",
		[11708] = "16:0:0:71:68:5699:1860:25590:Fizzcrank Fullthrottle::11707:11712:11798",
		[11963] = "16:0:0:71:68:5719:6660:25235:Hilda Stoneforge::11962:11965:0",
		[11710] = "16:0:0:71:68:5740:1860:25702:Mordle Cogspinner::0:11692:11694",
		[11965] = "16:0:0:71:68:5820:6280:26083:Gerald Green::11963:0:0",
		[11712] = "16:0:0:71:68:5740:1880:25747:Jinky Wingnut::11708:11788:11798",
		[11713] = "16:0:0:71:68:5699:2000:25780:Abner Fizzletorque::0:11715:11723",
		[11715] = "16:0:0:71:68:5699:2000:25780:Abner Fizzletorque::11713:11718:11723",
		[12157] = "16:0:0:72:71:8200:4640:26186:Private Casey::0:12297|12171:12311",
		[11718] = "16:0:0:71:68:5699:2000:25780:Abner Fizzletorque::11715:11723:0",
		[11793] = "16:0:0:71:68:5659:7240:25285:Harbinger Vurenn::11792:11794:0",
		[11726] = "16:0:0:71:68:6160:3580:25807:Iggy \"Tailspin\" Cogtoggle::0:11728:11873",
		[11575] = "16:0:0:71:69:5840:6780:25249:Midge::0:11587:11679",
		[11728] = "16:0:0:71:68:6160:3580:25807:Iggy \"Tailspin\" Cogtoggle::11726:11795:11873",
		[11723] = "16:0:0:71:68:5699:2000:25780:Abner Fizzletorque::11718:0:0",
		[11797] = "16:0:0:71:68:5639:6959:25816:Sergeant Hammerhill::11727:11889:11897",
		[11725] = "16:0:0:71:68:5699:1860:25590:Fizzcrank Fullthrottle::0:0:0",
		[11599] = "16:0:0:71:68:5860:6820:25251:Leryssa::11927:11600:12088",
		[11727] = "16:0:0:71:68:5659:7260:25250:General Arlos::0:11797:11897",
		[11601] = "16:0:0:71:68:5860:6820:25251:Leryssa::11600:11603:12088",
		[11729] = "18:0:0:71:68:6460:2300:25753:Sentry-bot 57-K::0:11730:0",
		[11730] = "16:0:0:71:68:5820:1840:25477:Crafty Wobblesprocket::11729:0:0",
		[11604] = "16:0:0:71:68:5840:6800:25302:Old Man Colburn::11603:11932:12088",
		[11603] = "16:0:0:71:68:5820:6800:25245:James Deacon::11601:11604:12088",
		[11673] = "16:0:0:72:69:5540:1260:25589:Bonker Togglevolt::0:0:0",
		[11707] = "16:0:0:71:68:5880:6860:25737:Airman Skyhopper::0:11708:11798",
		[11962] = "16:0:0:71:68:5820:6280:26083:Gerald Green::11904:11963:11965",
		[11600] = "16:0:0:71:68:5600:5540:25385:William Allerton::11599:11601:12088",
		[11904] = "16:0:0:71:68:5820:6280:26083:Gerald Green::11903:11962:11965",
		[11908] = "16:0:0:71:68:5820:6280:26084:Jeremiah Hawning::0:12035:0",
	},
	[488] = {
		[12119] = "16:0:0:72:71:2900:5540:26673:Image of Archmage Modera::12107|12110:12767|12766:12372",
		[11995] = "16:0:0:72:71:4800:7480:26440:Emissary Skyhaven::12439:12000:12004",
		[12123] = "16:0:0:75:71:5780:5420:26443:Tariolstrasz::12769|12768:12435:12372",
		[12251] = "16:0:0:72:71:7700:5000:27317:Gryphon Commander Urik::12237:12253:12311",
		[12253] = "16:0:0:72:71:7840:4820:27136:High Commander Halford Wyrmbane::12251:12309:12311",
		[12000] = "16:0:0:72:71:2900:5540:26673:Image of Archmage Modera::11995&12440:12004:0",
		[12511] = "16:0:0:73:73:7700:5000:27317:Gryphon Commander Urik::0:0:0",
		[12766] = "16:0:0:72:71:5780:5420:26443:Tariolstrasz::12119|12122:12460|12461:12372",
		[12768] = "16:0:0:75:71:5220:5000:27506:Ceristrasz::12418|12450:12123|12124:12372",
		[12269] = "16:0:0:72:71:7780:5020:27156:Highlord Leoric Von Zeldig::0:0:0",
		[12143] = "16:0:0:73:72:6440:2640:26978:Duane::12142:0:0",
		[12272] = "16:0:0:72:71:7780:5020:27159:Siege Engineer Quarterflash::0:0:0",
		[12146] = "18:0:0:73:72:7220:2800:27005:Chilltusk::0:12148:12151",
		[12275] = "16:0:0:72:71:7840:4820:27136:High Commander Halford Wyrmbane::0:12276:12277",
		[12276] = "16:0:0:72:71:7780:5020:27159:Siege Engineer Quarterflash::12275:12277:0",
		[12277] = "16:0:0:72:71:8139:4220:27412:Slinkin the Demo-gnome::12276:0:0",
		[12281] = "16:0:0:72:71:7780:5020:27159:Siege Engineer Quarterflash::0:0:0",
		[12282] = "16:0:0:72:71:7900:4720:27314:Zelig the Visionary::0:12287:12478",
		[12287] = "16:0:0:72:71:7900:4720:27314:Zelig the Visionary::12282:12290:12478",
		[12416] = "16:0:0:74:71:5220:5000:27506:Ceristrasz::12460|12461:12417|12449:12372",
		[12290] = "16:0:0:72:71:8700:5740:27347:Orik Trueheart::12287:12291:12478",
		[12418] = "16:0:0:75:71:5220:5000:27506:Ceristrasz::12417|12449:12769|12768:12372",
		[12166] = "16:0:0:72:71:2920:5560:26973:Warden Jodi Moonsong::0:12167:0",
		[12167] = "16:0:0:72:71:2920:5560:26973:Warden Jodi Moonsong::12166:0:0",
		[12168] = "18:0:0:72:71:2500:4480:26319:Anub'ar Cultist::0:12169:0",
		[12169] = "16:0:0:72:71:2920:5560:26973:Warden Jodi Moonsong::12168:0:0",
		[12171] = "16:0:0:72:71:2880:5600:27060:Courier Lanson::12157:12174|12298:12311",
		[12174] = "16:0:0:72:71:2900:5520:26881:Palena Silvercloud::12297&12171:12235:12311",
		[12305] = "16:0:0:72:71:8700:5740:27347:Orik Trueheart::12301:12475:12478",
		[12309] = "16:0:0:72:71:7840:4820:27136:High Commander Halford Wyrmbane::12253:12311:0",
		[12438] = "32:0:0:74:71:7730:5140:190020:Wanted!::0:0:0",
		[12439] = "16:0:0:72:71:7880:4520:27158:Vas the Unstable::0:11995|12440:12004",
		[12440] = "16:0:0:72:71:7700:4980:26878:Rodney Wells::12439:12000:12004",
		[12441] = "32:0:0:74:71:7730:5140:190020:Wanted!::0:0:0",
		[12442] = "32:0:0:74:71:7730:5140:190020:Wanted!::0:0:0",
		[12319] = "16:0:0:73:71:7900:5320:27318:Cavalier Durkon::12312:12320:0",
		[12320] = "16:0:0:73:71:7840:4820:27136:High Commander Halford Wyrmbane::12319:0:0",
		[12321] = "16:0:0:73:71:7660:4740:27316:Inquisitor Hallard::0:0:0",
		[12325] = "16:0:0:73:71:7840:4820:27136:High Commander Halford Wyrmbane::0:12326:12472",
		[12326] = "16:0:0:73:71:8960:4640:27157:Duke August Foehammer::12325:12455:12472",
		[12455] = "16:0:0:73:71:8600:5080:1293:Ambo Cash::12326:12457:12472",
		[12457] = "16:0:0:73:71:8600:5080:1293:Ambo Cash::12455:12463:12472",
		[12460] = "16:0:0:74:71:6000:5500:27803:Lauriel Trueblade::12767|12766:12448|12416:12372",
		[12462] = "16:0:0:73:71:8580:5100:27319:Yord \"Calamity\" Icebeard::0:0:0",
		[12463] = "16:0:0:73:71:8600:5080:1293:Ambo Cash::12457:12465:12472",
		[12464] = "16:0:0:73:71:7680:4740:27784:Commander Eligor Dawnbringer::0:0:0",
		[12465] = "16:0:0:73:71:8420:5460:27828:Plunderbeard::12463:12466:12472",
		[12466] = "16:0:0:73:71:8600:5080:1293:Ambo Cash::12465:12467:12472",
		[12467] = "16:0:0:73:71:6460:2780:27844:Legion Commander Tyralion::12466:12472:0",
		[12472] = "16:0:0:73:71:7840:4820:27136:High Commander Halford Wyrmbane::12467:0:0",
		[12473] = "16:0:0:73:71:8120:5060:27857:Legion Commander Yorik::0:12224|12474:12498",
		[12474] = "16:0:0:73:71:7840:4820:27136:High Commander Halford Wyrmbane::12473:12495|12496:12498",
		[12475] = "16:0:0:73:71:7900:4720:27314:Zelig the Visionary::12305:12478:0",
		[12476] = "16:0:0:73:71:7860:4820:27155:Commander Lynore Windstryke::0:0:0",
		[12477] = "16:0:0:73:71:7840:4820:27136:High Commander Halford Wyrmbane::0:0:0",
		[12478] = "16:0:0:73:71:7900:4720:27314:Zelig the Visionary::12475:0:0",
		[12098] = "16:0:0:72:71:2900:5540:26673:Image of Archmage Modera::12084|12083:12107|12110:12372",
		[12083] = "16:0:0:72:71:2900:5540:26673:Image of Archmage Modera::12065|12066:12106|12098:12372",
		[12142] = "16:0:0:73:72:6440:2640:26978:Duane::0:12143:0",
		[12301] = "16:0:0:72:71:8700:5740:27347:Orik Trueheart::12291:12305:12478",
		[12004] = "16:0:0:73:71:2900:5540:26673:Image of Archmage Modera::12000:0:0",
		[12067] = "18:0:0:72:71:2640:6460:26762:Captain Emmy Malin::0:0:0",
		[12312] = "32:0:0:73:71:7860:5230:189311:Flesh-bound Tome::0:12319:12320",
		[12107] = "16:0:0:72:71:4020:6680:26873:Mage-Commander Evenstar::12106|12098:12119|12122:12372",
		[12235] = "16:0:0:72:71:7840:4820:27136:High Commander Halford Wyrmbane::12174&12298:12237:12311",
		[12258] = "16:0:0:72:71:7860:4820:27155:Commander Lynore Windstryke::0:0:0",
		[12237] = "16:0:0:72:71:7700:5000:27317:Gryphon Commander Urik::12235:12251:12311",
		[12065] = "16:0:0:72:71:2900:5540:26673:Image of Archmage Modera::12060|12061:12084|12083:12372",
		[12417] = "16:0:0:74:71:5220:5000:27506:Ceristrasz::12448|12416:12418|12450:12372",
		[12055] = "18:0:0:72:71:1940:5780:26349:Goramosh::0:12060|12061:12372",
		[12495] = "16:0:0:74:71:3780:2340:27872:Highlord Bolvar Fordragon::12224|12474:12497:12498",
		[12060] = "16:0:0:72:71:2900:5540:26673:Image of Archmage Modera::12059|12055:12065|12066:12372",
		[12311] = "16:0:0:72:71:7900:5320:27318:Cavalier Durkon::12309:0:0",
		[12092] = "16:0:0:72:71:2880:5699:26837:Sarendryana::0:0:0",
		[12499] = "16:0:0:74:71:5980:5460:26917:Alexstrasza the Life-Binder::0:0:0",
		[12291] = "16:0:0:72:71:8700:5740:27347:Orik Trueheart::12290:12301:12478",
	},
	[504] = {
		[29071] = "32:0:0:80:80:3760:6280:208316:Hero's Call Board::0:0:0",
		[24454] = "16:0:0:80:80:3960:5760:36669:Arcanist Tybalin::20439:0:0",
		[20438] = "16:0:0:80:80:3960:5760:36669:Arcanist Tybalin::14457:20439:24454",
		[20439] = "16:0:0:80:80:3960:5760:36669:Arcanist Tybalin::20438:24454:0",
		[14457] = "16:0:0:80:80:3960:5760:36669:Arcanist Tybalin::14444:20438:24454",
	},
	[490] = {
		[12294] = "16:0:0:74:73:3479:5540:27469:Ivan::12293:12295:0",
		[12295] = "16:0:0:74:73:3180:6020:26875:Lieutenant Dumont::12294:0:0",
		[12138] = "16:0:0:75:73:7700:4860:26883:Raegar Breakbrow::12131:0:0",
		[12770] = "16:0:0:75:74:5940:2600:26212:Captain Gryan Stoutmantle::0:0:0",
		[12109] = "16:0:0:74:73:3180:6020:26875:Lieutenant Dumont::12105:12158:12160",
		[12299] = "16:0:0:74:73:2640:3580:27486:Sergei::0:0:0",
		[12300] = "16:0:0:74:73:2640:3580:27486:Sergei::0:12302:0",
		[12183] = "16:0:0:75:73:7700:4840:26885:Mountaineer Kilian::0:12184:12185",
		[11986] = "32:0:0:75:73:6430:1980:188261:Battered Journal::0:0:0",
		[12014] = "16:0:0:75:73:6740:1520:26514:Surveyor Orlond::12010:0:0",
		[12302] = "16:0:0:74:73:2180:3000:27497:Captured Trapper::12300:0:0",
		[12154] = "16:0:0:75:73:7700:4860:26883:Raegar Breakbrow::0:0:0",
		[11988] = "16:0:0:75:73:5980:2740:26361:Torthen Deepdig::0:0:0",
		[12227] = "16:0:0:73:73:3200:6000:27277:Master Woodsman Anderhol::12226:0:0",
		[12003] = "16:0:0:75:73:5980:2760:26226:Brugar Stoneshear::12002:12010:12014",
		[12210] = "16:0:0:73:73:3180:6020:26875:Lieutenant Dumont::0:11984:0",
		[12002] = "16:0:0:75:73:5980:2760:26226:Brugar Stoneshear::11998:12003:12014",
		[12129] = "16:0:0:75:73:7700:4860:26883:Raegar Breakbrow::12128:12130:12138",
		[12180] = "16:0:0:75:73:7700:4840:26885:Mountaineer Kilian::0:0:0",
		[12212] = "16:0:0:74:73:3200:6000:27277:Master Woodsman Anderhol::0:12216:0",
		[12307] = "16:0:0:74:73:2560:3340:27545:Katja::0:0:0",
		[12128] = "16:0:0:75:73:5980:2760:26226:Brugar Stoneshear::0:12129:12138",
		[12308] = "16:0:0:74:73:2640:3180:27499:Caged Prisoner::0:12310:0",
		[12247] = "16:0:0:75:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[12246] = "16:0:0:74:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[12215] = "16:0:0:74:73:3200:6000:27277:Master Woodsman Anderhol::0:12217:0",
		[12310] = "16:0:0:74:73:3180:6020:26875:Lieutenant Dumont::12308:0:0",
		[12153] = "16:0:0:75:73:7700:4860:26883:Raegar Breakbrow::0:0:0",
		[12248] = "16:0:0:75:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[12217] = "16:0:0:74:73:3200:6000:27277:Master Woodsman Anderhol::12215:0:0",
		[12249] = "16:0:0:75:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[11998] = "16:0:0:75:73:5940:2600:26212:Captain Gryan Stoutmantle::0:12002:12014",
		[12250] = "16:0:0:75:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[12219] = "16:0:0:74:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[12184] = "16:0:0:75:73:7700:4840:26885:Mountaineer Kilian::12183:12185:0",
		[12220] = "16:0:0:74:73:3120:5940:27295:Hierophant Thayreen::0:0:0",
		[12185] = "16:0:0:75:73:7700:4840:26885:Mountaineer Kilian::12184:0:0",
		[12158] = "16:0:0:75:73:5940:2600:26212:Captain Gryan Stoutmantle::12109:12159:12160",
		[11993] = "16:0:0:75:73:5980:2740:26361:Torthen Deepdig::0:0:0",
		[12222] = "16:0:0:74:73:3240:5980:27391:Woodsman Drake::0:0:0",
		[12443] = "16:0:0:74:73:2300:8000:27495:Barblefink::0:0:0",
		[12160] = "16:0:0:75:73:5500:2340:26932:Petrov::12159:0:0",
		[12255] = "16:0:0:74:73:3240:5980:27391:Woodsman Drake::0:0:0",
		[12161] = "16:0:0:75:73:5920:2620:27582:Private Arun::0:12328:12329",
		[12130] = "16:0:0:75:73:7700:4860:26883:Raegar Breakbrow::12129:12131:12138",
		[12225] = "32:0:0:73:73:3180:5960:188667:Amberseed::0:12226:12227",
		[12131] = "16:0:0:75:73:7700:4860:26883:Raegar Breakbrow::12130:12138:0",
		[12226] = "16:0:0:73:73:3200:6000:27277:Master Woodsman Anderhol::12225:12227:0",
		[12414] = "16:0:0:75:73:5900:2660:26377:Squire Percy::0:0:0",
		[12794] = "16:0:0:74:74:3200:5980:29161:Magistrix Haelenai::0:12790:0",
		[12027] = "16:0:0:74:73:4920:3400:26588:Emily::0:0:0",
		[12159] = "16:0:0:75:73:5500:2340:26932:Petrov::12158:12160:0",
		[12105] = "18:0:0:74:73:3540:6820:27546:Silverbrook Hunter::0:12109:12160",
		[12292] = "16:0:0:74:73:3180:6020:26875:Lieutenant Dumont::0:12293:12295",
		[12223] = "16:0:0:74:73:3240:5980:27391:Woodsman Drake::0:0:0",
		[12293] = "16:0:0:74:73:3180:6020:26875:Lieutenant Dumont::12292:12294:12295",
		[12010] = "16:0:0:75:73:5980:2760:26226:Brugar Stoneshear::12003:12014:0",
		[12216] = "16:0:0:74:73:3200:6000:27277:Master Woodsman Anderhol::12212:0:0",
	},
	[491] = {
		[11484] = "16:0:0:71:68:7500:6540:24807:Walt::0:0:0",
		[11485] = "16:0:0:71:68:7500:6540:24807:Walt::0:11489:11491",
		[11359] = "16:0:0:72:69:6240:1660:24376:Researcher Aderan::11358:0:0",
		[11489] = "16:0:0:71:68:7500:6540:24807:Walt::11485:11491:0",
		[11236] = "16:0:0:72:68:2880:4400:23749:Captain Adams::11235:0:0",
		[11491] = "16:0:0:71:68:7500:6540:24807:Walt::11489:0:0",
		[11238] = "16:0:0:72:68:2880:4420:23888:Mage-Lieutenant Malister::11237:0:0",
		[11239] = "16:0:0:71:68:2880:4400:24038:Father Levariol::11231:0:0",
		[11494] = "16:0:0:71:68:7500:6540:24807:Walt::0:0:0",
		[11495] = "16:0:0:71:68:7500:6540:24807:Walt::0:0:0",
		[11243] = "16:0:0:70:68:6040:6100:23546:Vice Admiral Keller::11228:11244:11291",
		[11244] = "16:0:0:70:68:6040:6100:23546:Vice Admiral Keller::11243:11255:11291",
		[11501] = "16:0:0:71:68:7500:6540:24807:Walt::0:0:0",
		[11248] = "16:0:0:71:68:2880:4400:23749:Captain Adams::11332:0:0",
		[11249] = "18:0:0:72:68:4380:2800:23664:Winterskorn Warrior::0:0:0",
		[11251] = "16:0:0:71:68:5600:5580:24106:Scout Valory::0:11252:0",
		[11255] = "16:0:0:70:68:6040:6100:23546:Vice Admiral Keller::11244:11290:11291",
		[11390] = "16:0:0:71:69:3080:2859:24399:Steel Gate Chief Archaeologist::11176:11391:0",
		[11393] = "16:0:0:71:69:3020:2859:23891:Overseer Irena Stonemantle::0:0:0",
		[11394] = "16:0:0:71:69:2420:3240:23833:Explorer Jaren::0:0:0",
		[11395] = "18:0:0:71:69:2320:3140:24485:Servitor Shade::0:11396:0",
		[11269] = "16:0:0:71:69:6260:1680:24139:Gil Grisert::0:11418:0",
		[11273] = "16:0:0:70:68:6020:6100:23548:Beltrand McSorf::0:11274:11475",
		[11274] = "16:0:0:70:68:5900:5440:24122:Pulroy the Archaeologist::11273:11276:11475",
		[11276] = "16:0:0:70:68:5659:5240:24145:Zedd::11274:11277:11475",
		[11277] = "16:0:0:71:68:5679:5360:24150:Glorenfeld::11276:11299:11475",
		[11278] = "16:0:0:71:68:5679:5360:24150:Glorenfeld::11300:11448:11475",
		[11406] = "16:0:0:70:68:3060:4260:24494:Quartermaster Brevin::0:0:0",
		[11154] = "16:0:0:71:69:3020:2859:24227:Engineer Feknut::0:0:0",
		[11155] = "16:0:0:71:68:3120:4079:23773:Chef Kettleblack::0:0:0",
		[11410] = "16:0:0:71:68:6020:1860:24056:Christopher Sloan::11329:0:0",
		[11284] = "16:0:0:71:68:6020:1560:24176:Foreman Colbey::0:0:0",
		[11414] = "16:0:0:71:69:2960:0560:24261:Ulfang::11325:11416:11326",
		[11288] = "16:0:0:71:68:5920:5540:24189:Ares the Oathbound::0:11289:0",
		[11416] = "16:0:0:71:69:2960:0560:24261:Ulfang::11414:11326:0",
		[11290] = "16:0:0:70:68:6040:6100:23546:Vice Admiral Keller::11255:11291:0",
		[11418] = "16:0:0:70:68:6260:1680:24139:Gil Grisert::11269:0:0",
		[11292] = "16:0:0:70:69:6260:1680:24131:Trapper Jethan::0:0:0",
		[11420] = "16:0:0:71:68:6000:6240:23728:Guard Captain Zorek::0:11426:11436",
		[11421] = "16:0:0:71:68:6440:4680:24634:Lieutenant Icehammer::11430:11436:0",
		[11426] = "16:0:0:71:68:6000:6240:23728:Guard Captain Zorek::11420:11427:11436",
		[11427] = "16:0:0:71:68:6000:6240:23728:Guard Captain Zorek::11426:11429:11436",
		[11429] = "16:0:0:71:68:6440:4680:24634:Lieutenant Icehammer::11427:11430:11436",
		[11430] = "16:0:0:71:68:6440:4680:24634:Lieutenant Icehammer::11429:11421:11436",
		[11235] = "16:0:0:71:68:2880:4400:23749:Captain Adams::0:11236:0",
		[11432] = "16:0:0:71:68:2880:4420:23888:Mage-Lieutenant Malister::0:0:0",
		[11299] = "16:0:0:71:68:5679:5360:24150:Glorenfeld::11277:11300:11475",
		[11176] = "16:0:0:71:69:3020:2859:23891:Overseer Irena Stonemantle::0:11390:11391",
		[11240] = "16:0:0:71:68:2900:4180:23976:Sapper Steelring::11218:0:0",
		[11436] = "16:0:0:71:68:6440:4680:24634:Lieutenant Icehammer::11421:0:0",
		[11175] = "16:0:0:71:69:3160:4200:23831:Old Man Stonemantle::0:0:0",
		[11302] = "16:0:0:70:68:6180:1719:24282:Lieutenant Maeve::0:11313:0",
		[11237] = "18:0:0:72:68:3500:1060:23991:Gjalerbron Warrior::0:11238:0",
		[11300] = "16:0:0:71:68:5560:5719:24151:Daegarn::11299:11278:11475",
		[11187] = "16:0:0:71:68:2880:4400:23749:Captain Adams::0:11188:0",
		[11188] = "16:0:0:71:68:2880:4420:23888:Mage-Lieutenant Malister::11187:0:0",
		[11443] = "16:0:0:71:68:6220:5719:23730:Harold Lagras::0:0:0",
		[11190] = "16:0:0:71:68:3380:4380:23770:Cannoneer Ely::0:0:0",
		[11231] = "16:0:0:71:68:2880:4400:24038:Father Levariol::0:11239:0",
		[11573] = "16:0:0:71:68:3220:4680:25233:Lunk-tusk::0:11504:11510",
		[11358] = "16:0:0:72:69:6240:1660:24376:Researcher Aderan::11355:11359:0",
		[11448] = "16:0:0:71:68:6020:6100:23548:Beltrand McSorf::11278:11474:11475",
		[11322] = "16:0:0:71:69:3000:2859:24273:Watcher Moonleaf::0:11325:11326",
		[11475] = "16:0:0:71:68:7500:6540:24807:Walt::11474:0:0",
		[11224] = "16:0:0:71:68:3160:4140:23978:Explorer Abigail::0:0:0",
		[11325] = "16:0:0:71:69:3000:2859:24273:Watcher Moonleaf::11322:11414:11326",
		[11199] = "16:0:0:71:68:2880:4400:23749:Captain Adams::0:11202:11328",
		[11327] = "16:0:0:71:68:4440:5760:23906:Scout Knowles::11202:11328:0",
		[11328] = "16:0:0:71:68:4440:5760:23906:Scout Knowles::11327:0:0",
		[11202] = "16:0:0:71:68:4440:5760:23906:Scout Knowles::11199:11327:11328",
		[11330] = "16:0:0:71:68:3080:4160:24283:Peppy Wrongnozzle::0:11331:11248",
		[11331] = "16:0:0:71:68:3080:4160:24283:Peppy Wrongnozzle::11330:11332:11248",
		[11332] = "16:0:0:71:68:2880:4400:23749:Captain Adams::11331:11248:0",
		[11333] = "16:0:0:71:68:5980:6140:23975:Thoralius the Wise::0:11343:11344",
		[11326] = "16:0:0:71:69:2960:0560:24261:Ulfang::11416:0:0",
		[12297] = "16:0:0:72:71:2880:4400:23749:Captain Adams::12157:12174|12298:12311",
		[12298] = "16:0:0:72:71:3120:4400:23859:Greer Orehammer::12297&12171:12235:12311",
		[11291] = "16:0:0:70:68:6040:6100:23546:Vice Admiral Keller::11290:0:0",
		[11465] = "16:0:0:71:68:7520:6500:24750:Hidalgo the Master Falconer::11460:11468:11470",
		[11228] = "16:0:0:70:68:6100:6260:23547:Macalroy::0:11243:11291",
		[11157] = "16:0:0:71:68:2880:4400:23749:Captain Adams::0:0:0",
		[11468] = "16:0:0:71:68:7520:6500:24750:Hidalgo the Master Falconer::11465:11470:0",
		[11460] = "16:0:0:71:68:7520:6500:24750:Hidalgo the Master Falconer::0:11465:11470",
		[11470] = "16:0:0:71:68:7520:6500:24750:Hidalgo the Master Falconer::11468:0:0",
		[11344] = "16:0:0:71:68:5980:6140:23975:Thoralius the Wise::11343:0:0",
		[11218] = "16:0:0:71:68:2900:4180:23976:Sapper Steelring::0:11240:0",
		[11346] = "16:0:0:71:69:6220:1719:24328:Prospector Belvar::0:11349:11348",
		[11474] = "16:0:0:71:68:7480:6540:24717:Stanwad::11448:11475:0",
		[11348] = "16:0:0:71:69:6220:1719:24328:Prospector Belvar::11349:0:0",
		[11349] = "16:0:0:71:69:6220:1719:24328:Prospector Belvar::11346:11348:0",
		[11477] = "16:0:0:70:68:7880:4880:24811:Donny::0:0:0",
		[11478] = "16:0:0:71:68:7880:4880:24811:Donny::0:0:0",
		[11289] = "16:0:0:71:68:5920:5540:24189:Ares the Oathbound::11288:0:0",
		[11329] = "16:0:0:70:69:6020:1860:24056:Christopher Sloan::0:11410:0",
		[11396] = "16:0:0:71:69:2420:3240:23833:Explorer Jaren::11395:0:0",
		[11355] = "16:0:0:72:69:6240:1660:24376:Researcher Aderan::0:11358:11359",
		[11483] = "16:0:0:71:68:7500:6540:24807:Walt::0:0:0",
		[11343] = "16:0:0:71:68:5980:6140:23975:Thoralius the Wise::11333:11344:0",
	},
	[492] = {
		[13334] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13335] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13399] = "16:0:0:80:77:7160:3760:32423:Matthias Lehner::13398:13400:13403",
		[13337] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13401] = "16:0:0:80:77:4920:7300:32497:Matthias Lehner::13400:13402:13403",
		[13402] = "16:0:0:80:77:5620:3820:29799:Thassarian::13401:13403:0",
		[13320] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:13321:0",
		[13403] = "16:0:0:80:77:7980:7180:31044:Highlord Tirion Fordring::13402:0:0",
		[13397] = "16:0:0:80:77:5620:3820:29799:Thassarian::13396:0:0",
		[13341] = "16:0:0:80:77:6180:5659:32302:Knight-Captain Drosche::0:0:0",
		[14444] = "16:0:0:80:80:7420:3120:36624:Caladis Brightspear::14443:14457:24454",
		[13342] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[24476] = "272:0:0:80:80:7420:3120:36624:Caladis Brightspear::24461:24480:24535",
		[13232] = "16:0:0:80:77:6879:6440:31304:Dying Soldier::0:0:0",
		[13339] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13231] = "16:0:0:80:77:6220:4920:30344:High Captain Justin Bartlett::0:0:0",
		[24795] = "16:0:0:80:80:7420:3120:36624:Caladis Brightspear::24595:0:0",
		[13345] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:13346:0",
		[13314] = "16:0:0:80:77:6220:4920:30344:High Captain Justin Bartlett::0:0:0",
		[13346] = "16:0:0:80:77:5620:3820:29799:Thassarian::13345:0:0",
		[13315] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13221] = "16:0:0:80:77:3180:6480:31279:Father Kamaros::0:0:0",
		[24796] = "16:0:0:80:80:7420:3120:36624:Caladis Brightspear::24553:0:0",
		[12896] = "16:0:0:80:77:4400:2460:29804:Baron Sliver::0:12899|12898:12943",
		[13380] = "16:0:0:80:77:5400:4280:32444:Kibli Killohertz::13383:0:0",
		[13286] = "16:0:0:80:77:6220:4920:30344:High Captain Justin Bartlett::0:13287:0",
		[13318] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13287] = "16:0:0:80:77:5620:3820:29799:Thassarian::13286:0:0",
		[13319] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13288] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13383] = "16:0:0:80:77:6140:4740:30345:Chief Engineer Boltwrench::0:13380:0",
		[13226] = "16:0:0:78:77:5639:4160:31259:Absalan the Pious::0:0:0",
		[13321] = "16:0:0:80:77:6140:4740:30345:Chief Engineer Boltwrench::13320:0:0",
		[13290] = "16:0:0:80:77:6220:4920:30344:High Captain Justin Bartlett::0:13291:0",
		[12898] = "16:0:0:80:77:5620:3820:29799:Thassarian::12897|12896:12938:12943",
		[13291] = "16:0:0:80:77:6140:4740:30345:Chief Engineer Boltwrench::13290:0:0",
		[13386] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:13387:13393",
		[13225] = "16:0:0:79:77:7940:7280:31241:Marshal Ivalius::0:0:0",
		[13387] = "16:0:0:80:77:5160:8660:31444:Captain Kendall::13386:13388:13393",
		[13482] = "16:0:0:80:77:3180:6480:32800:Father Kamaros::0:0:0",
		[13388] = "16:0:0:80:77:5160:8660:31444:Captain Kendall::13387:13389:13393",
		[13294] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:13295:0",
		[13389] = "32:0:0:80:77:5440:8620:193400:Saronite Bomb Stack::13388:13390:13393",
		[13295] = "16:0:0:80:77:5620:3820:29799:Thassarian::13294:0:0",
		[13390] = "32:0:0:80:77:5400:8730:193195:Pulsing Crystal::13389:13391:13393",
		[13296] = "16:0:0:80:77:6140:4740:30345:Chief Engineer Boltwrench::0:13280:0",
		[13391] = "16:0:0:80:77:5380:8700:31237:Matthias Lehner::13390:13392:13393",
		[12887] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:12891:12893",
		[13392] = "16:0:0:80:77:5380:8700:31237:Matthias Lehner::13391:13393:0",
		[13298] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13393] = "16:0:0:80:77:5620:3820:29799:Thassarian::13392:0:0",
		[13398] = "16:0:0:80:77:7160:3760:32423:Matthias Lehner::0:13399:13403",
		[13394] = "16:0:0:80:77:6800:5160:32408:Matthias Lehner::0:13395:13397",
		[13338] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13332] = "16:0:0:80:77:5620:3820:29799:Thassarian::0:0:0",
		[13400] = "16:0:0:80:77:4920:7300:32497:Matthias Lehner::13399:13401:13403",
		[13396] = "16:0:0:80:77:6440:4400:32404:Matthias Lehner::13395:13397:0",
		[13395] = "16:0:0:80:77:6440:4400:32404:Matthias Lehner::13394:13396:13397",
	},
	[495] = {
		[12986] = "16:0:0:80:77:3920:5960:30052:Creteus::12877:12878:12880",
		[12870] = "16:0:0:78:77:2880:7400:29744:Rork Sharpchin::0:0:0",
		[12878] = "16:0:0:80:77:3920:5960:30052:Creteus::12986:12879:12880",
		[12855] = "16:0:0:80:77:2960:7400:29650:Archaeologist Andorin::0:12858:12872",
		[12863] = "16:0:0:78:77:2940:7380:29743:Lagnus::0:12864:12868",
		[12879] = "16:0:0:80:77:4440:6460:30548:The Guardian's Charge::12878:12880:0",
		[12864] = "16:0:0:78:77:2920:7480:29727:Glorthal Stiffbeard::12863:12866:12868",
		[12872] = "32:0:0:80:77:3740:4680:191760:Inventor's Library Console::13415:0:0",
		[12880] = "16:0:0:80:77:3820:6160:30082:Creteus::12879:0:0",
		[12865] = "16:0:0:78:77:2980:7560:29732:Fjorlin Frostbrow::0:12867:0",
		[12873] = "16:0:0:80:77:2940:7380:29743:Lagnus::12871:12874:12880",
		[12866] = "16:0:0:78:77:2920:7480:29727:Glorthal Stiffbeard::12864:12868:0",
		[12874] = "16:0:0:80:77:3020:7480:29593:Yorg Stormheart::12873:12875:12880",
		[12867] = "16:0:0:78:77:2980:7560:29732:Fjorlin Frostbrow::12865:0:0",
		[12875] = "16:0:0:80:77:3020:7480:29593:Yorg Stormheart::12874:12877:12880",
		[12868] = "16:0:0:78:77:2920:7480:29727:Glorthal Stiffbeard::12866:0:0",
		[12876] = "16:0:0:80:77:2980:7560:29732:Fjorlin Frostbrow::0:0:0",
		[12973] = "16:0:0:80:77:3940:5639:30382:Brann Bronzebeard::0:0:0",
		[12877] = "16:0:0:80:77:2520:6840:29751:Drom Frostgrip::12875:12986:12880",
		[12854] = "16:0:0:80:77:2960:7400:29650:Archaeologist Andorin::0:0:0",
		[12862] = "16:0:0:78:77:4079:8540:29428:Ricket::0:0:0",
	},
})
end