﻿if GetLocale() == "koKR" then


function iclllocaleui()

arallbuttonmaint			= "지역 목록"
arallbuttontak				= "기능"
areachatlist1				= "공격대"
areachatlist2				= "공격대 경보"
areachatlist3				= "길드관리자"
areachatlist4				= "파티"
areachatlist5				= "길드"
areachatlist6				= "대화"
areachatlist7				= "외침"
areachatlist8				= "자신에게만"
	rallachdonel1 = "획득"
	rallachdonel2 = "획득하지못함"
	rallachievekologarnhp1 = "8십만 - 1백만"
	rallachievekologarnhp2 = "3백만 - 4백만"
	rallachiverepl1 = "획득하지 못한 업적"
	rallachiverepl10 = "'영예의 영웅/공격대원'의 모든 업적 (이미 획득한것 포함)"
	rallachiverepl11 = "'영예의 영웅/공격대원'중 획득하지 못한 업적만"
	rallachiverepl12 = "획득하지 못한 모든 업적 목록"
	rallachiverepl13 = "획득하지 못한 업적"
	rallachiverepl14 = "모든 업적 목록"
	rallachiverepl15 = "현재 설정에서 이 우두머리에서 찾을수있는 업적이 없음"
	rallachiverepl16 = "'영예의 영웅/공격대원'중 획득하지 못한 업적만"
	rallachiverepl17 = "'영예의 영웅/공격대원'의 모든 업적 (이미 획득한것 포함)"
	rallachiverepl18 = "획득하지 못한 모든 업적 목록"
	rallachiverepl19 = "모든 업적 목록"
	rallachiverepl2 = "당신은 이 지역의 모든 업적을 완료하였습니다"
	rallachiverepl3 = "현재 지역은 공격대나 영웅 던전이 아닙니다."
	rallachiverepl4 = "모든 업적의 목록"
	rallachiverepl5 = "DB에서 찾을수 없는 지역의 그룹 업적"
	rallachiverepl6 = "업적 확인 불가능"
	rallachiverepl7 = "10개 이상의 업적 발견(|cff00ff00%s|r). 옵션창에서 모든 목록을 이용할수있습니다(/rach - 현재 지역 목록)"
	rallachiverepl8 = "영예의 영웅/공격대원의 미완료 업적"
	rallachiverepl9 = "당신은 현재 지역의 영예의 영웅/공격대원의 업적을 모두 완료하였습니다."
	rallbutton2 = "다른 지역 선택"
	rallbutton3 = "<<< 설정으로 돌아가기"
	rallchatshowboss = "대화창으로 알림"
	ralldefaulttactic1 = "초입부 거리의 모든 좀비를 합쳐도 85 개체 이하이기 때문에 다음과 같은 진행이 필요합니다 :\n1. 첫 보스를 해치우세요.\n2. 두번째 보스를 잡아끌어 여관 입구로 갑니다(안쪽까지 따라오지 않기 때문에 계단 앞까지면 충분합니다).\n3. 보스를 당장 처치하지 말고 몇 분인가 기다려 좀비들이 리스폰되는 것을 확인하고 처치합니다.\n4. 아서스에게 말을 걸어 여관부분을 진행해 세번째 보스를 해치우곤 다시 말을 걸어 비밀통로를 엽니다.\n5. 하나 혹은 둘의 딜러는 두번째 보스를 잡았던 거리로 돌아가고 나머지는 전진해 좀비들을 풀링합니다.\n6. 양쪽에서 동시에 시작해서 업적이 뜰 때까지 좀비를 사살합시다."
	ralldefaulttactic10 = "보스는 반피 때부터 수액괴물을 소환하기 시작해 1/4 시점에서 소환을 중단합니다. 수액괴물이 소환되면 무쇠 녹괴물이 될 때까지 놔 뒀다가 처치합니다."
	ralldefaulttactic11 = "영구결빙은 매 2~3초마다 중첩됩니다. 사로나이트 덩어리를 이용해 보스에게 드러나지 않게 숨거나 디버프를 해제하거나 보스를 빠르게 녹입시다."
	ralldefaulttactic12 = "당신의 파티원 전체는 얼음동굴을 지날 때 떨어지는 어떠한 얼음파편에 맞지 않고 3번째 보스 앞에 도착해야 합니다.\n바닥에 파란 원이 생기는 것을 볼 수 있고 파편이 떨어지기까지 5초 정도의 시간이 걸립니다."
	ralldefaulttactic13 = "마지막 골목을 처리하고 말가니스 방에 진입하기 전에 스컬지가 점령한 것 같지 않은 지역에 진입합니다. 말가니스로부터 오른쪽 혹은 들어오는 길로부터 계속 왼쪽으로 들어갈 수 있습니다. 만약 타임어택 시간이 남아 있다면 안쪽에 무한의 타락자가 남아 있습니다."
	ralldefaulttactic14 = "매 30초 혹은 그 정도마다 보스가 파티원 중 한 명에게 영혼타락 주문을 시전해 타락한 영혼의 파편을 생성합니다. 타락한 영혼의 파편은 브론잠에게로 이동하고 그와 접촉하면 사라지기 때문에 가능한 한 그것들과 멀리 떨어져 브론잠에게 접근하지 못하게 해야 합니다.\n보스의 체력이 35% 이하가 되면 그는 본래 있던 장소로 텔레포트하고 움직이지 않습니다.\n전술 : 본래 위치에서 그를 풀링해 끌어내면서 파편이 4개가 되도록 유지한 후 빠르게 녹입시다. 타락한 영혼의 파편은 이동방해가 가능합니다."
	ralldefaulttactic15 = "파티원들이 돌아가며 \"환영 폭발\" 주문을 차단합시다."
	ralldefaulttactic16 = "보스는 전투 중 한 차례 45초 동안 무적상태가 됩니다. 혼돈의 균열은 건드리지 않고 무적이 풀릴 때까지 기다렸다가 보스만 처치합시다(광역기 주의하세요)."
	ralldefaulttactic17 = "개인 업적. 극심한 추위 효과가 매2초마다 플레이어에게 온다. 움직여서 효과를 풀어라.만약 5초동안 움직임 없이 서있는다면 업적은 실패다.주의 케리스트라자는 10동안 얼어붙게 만드는 능력을 가지고 있다 이것을 해제하라."
	ralldefaulttactic18 = "두 번째 보스는 은빛 고해사제 페이트리스와 성기사 에드릭 중 무작위로 선택됩니다. 페이트리스는 전투 중 25종류의 기억 중 한 가지를 소환합니다"
	ralldefaulttactic19 = "'심판의 망치' - 파티원 중 한 명을 6초 동안 기절시키고 '정의의 망치' 에 취약해지도록 만듭니다. '정의의 망치' - 망치를 집어던져 한 대상에게 14000의 신성 피해를 입힙니다. 만약 대상이 '심판의 망치' 효과를 받고 있지 않다면 주문을 되돌려 보낼 수 있습니다.\n공략 : 보스의 피를 25000으로 만들고 기다리다가 그가 누군가를 기절시키면 빠르게 해제합니다. 기절당했던 플레이어는 단축 바에 '망치 되돌려주기' 가 생기면 주문을 사용해주세요!"
	ralldefaulttactic2 = "그냥 계단에 머무르면서 몹을 처리하면 됩니다. 노보스의 실드가 벗겨져 교전을 시작하면 잡몹들은 더 이상 소환되지 않습니다. 그러면 더 이상 신경쓰지 않아도 됩니다."
	ralldefaulttactic20 = "구울들이 폭발시전을 시작한다면 구울과 보스를 죽이거나 재빨리 움직여서 피해라"
	ralldefaulttactic21 = "\"서리 무덤\" - 특정 대상을 얼음 덩어리에 가둡니다. 보스가 누군가에게 시전한 서리 무덤은 그냥 놔두고 보스를 녹입시다."
	ralldefaulttactic22 = "보스 근처에 스컬지 괴물이 있는데 업적을 위해서 이 스컬지 괴물 하나가 필요합니다. 보스는 반피가 될 경우 '검의 의식'을 시작하는데, 스컬지 괴물이 검의 폭발에 맞아 죽게 하면 됩니다"
	ralldefaulttactic23 = "그라우프에게 작살 3개를 한번에 발사해 처치합시다."
	ralldefaulttactic24 = "만약 보스를 빠르게 처치하지 못하면 - 보스는 \"파멸\" 을 사용합니다. 일단 이 주문이 사용되면 실패입니다. 보스가 이 주문을 사용하기 전에 녹입시다."
	ralldefaulttactic25 = "수액 폐기물이 보스와 합쳐지기 전에 이코르를 빨리 처치합시다."
	ralldefaulttactic26 = "벽 곳곳에 붙어 있는 방어 제어 수정을 전혀 사용하지 않은 채 몬스터들이 감옥문 봉인에 피해를 입히지 못하게 합니다."
	ralldefaulttactic27 = "이 던전에서는 매 회 6 종류의 보스 중 오로지 2 종류만 만날 수 있습니다."
	ralldefaulttactic28 = "안카하르 수호자가 보스의 근처에 있다면, 보스는 모든 피해에 면역 상태가 되므로 안카하르 수호자를 보스로부터 떨어뜨려 두고 보스를 빠르게 처치합시다."
	ralldefaulttactic29 = "장군 비야른그림은 세 곳의 장소마다 멈춰 서서 일시적 전하 충전 상태가 됩니다. 그가 일시적 전하 충전 상태일 때에 전투를 시작합시다."
	ralldefaulttactic3 = "보스는 50야드 내의 모든 대상에게 피해를 입힙니다. 이 기술로 피해를 입을 때마다 보스의 \"먹어치우기\"가 중첩됩니다.\n공략 : 보스 극딜"
	ralldefaulttactic30 = "보스는 강철 단련을 통해 2기의 용암 골렘을 만들어냅니다. 보스가 4기 이상의 골렘을 만들기 전에 그를 처치합시다."
	ralldefaulttactic31 = "오닉시아가 공중단계에서 깊은 숨을 시전할때 그녀의 정면에서 벗어나라. 오닉시아를 극딜하면 시전하기전에 다음단계에 돌입할 수 있다."
	ralldefaulttactic32 = "오닉시아는 체력이 65프로가 되면 두번째 단계로 들어가는데 오닉시아가 발을 떼고 난 후!! 10초안에 방 양옆에 있는 알로 달려가서 새끼용 50마리를 깨우고 오닉시아를 처치하면 된다."
	ralldefaulttactic33 = "고르목과의 전투를 끝내게 되면 스노볼트가 나오게 된다.(던질때까지 기다리지 않아도 됨) 스노볼트를 2마리(10인) 4마리(25인) 살아있는 상태에서 얼음울음을 처치한다."
	ralldefaulttactic34 = "보스의 체력이 35% 이하로 내려가면 더 이상 바닥으로 숨기, 무리딱정벌레를 사용하지 않습니다. 필요한 딱정벌레 수가 채워질 때까지 기다리다가 동시에 처치합시다."
	ralldefaulttactic35 = "Individual achievement. You must avoid Lava Strike NOT the flame wall. Lava Strike is a targeted AoE look up! Or die in the begging of the fight and you will get it ;)"
	ralldefaulttactic36 = "During the second phase (after boss reaches 50%) there will be some Scions of Eternity when 1 of them die he leaves a hover disk you need to take it and to do a killing blow to one of the Scion of Eternity"
	ralldefaulttactic37 = "There are two ways to get this achievement: 1. Don't kill adds 2. Kill adds very far from boss"
	ralldefaulttactic38 = "설명 : 타디우스는 '극성변환'을 시전합니다.극성변환 : 주위에 같은 극이 있을 경우 타디우스에게 입히는 피해 증가 주위에 다른 극이 있을 경우 다른 플레이어에게 피해를 입힘(업적 실패) 전술 : 2진영으로 나눠서 공격을 한후 각 진영당 양극 음극 을 정한 후 극성 변환후 자신의 디버프를 확인 후 곧바로 정해진 진영으로 직선으로 달린다.(탱커와 밀리는 칼끝딜 자신의 디버프 확인이 관건)"
	ralldefaulttactic39 = "켈투자드전투의 첫 단계에서 추가로 애드를 내어 누더기 골렘을 18마리를 잡고 켈투자드를 처치한다."
	ralldefaulttactic4 = "랩터왕 서슬발톱과의 전투중에 드라카리 학살자 혹은 드라카리 갈퀴발톱 랩터를 6마리 처리후에 보스 킬!"
	ralldefaulttactic40 = "보스와 싸우는동안 1개(10인) 3개(25인) 의 뼈가시가 생기는데 생긴지 8초안에 없애야 한다."
	ralldefaulttactic41 = "Boss calls adds of 2 types and transforms them only on the 1 phase. Be sure that you have all 5 different adds before passing in a 2nd phase: Cult Fanatic Deformed Fanatic Reanimated Fanatic Cult Adherent Reanimated Adherent (Empowered Adherent doesn`t count so just kill him)"
	ralldefaulttactic42 = "많은 방법이 있지만 공통적으로 한번 배로 다시 돌아온 사람은 다시는 넘어가지 말자!!"
	ralldefaulttactic43 = "Gas Spores will spawn three times before boss AoE that reset stacks. When the spore explode it gives everyone 1 stack of Inoculated (25% shadow resistance). Just don't get 3 stacks. The best strategy - to have each of the first 2 people who get the spores be the only ones to get the debuff. However the second time around you need to have everyone EXCEPT the first 2 get inoculated"
	ralldefaulttactic44 = "보스는 무작위 대상에게 디버프를 시전합니다. 이 디버프는 해제하거나 끝나면 작은 수액괴물을 생성합니다. 두개의 작은 수액괴물이 근접하면 그것들은 큰 수액괴물로 변합니다. 큰 수액괴물은  작은 수액괴물이 5번 중첩되면 폭팔하고 업적은 실패합니다. 보스를 빠르게 죽이고 수액괴물이 쌓지 마세요."
	ralldefaulttactic45 = "\"수액역류\"는 대상의 이동속도를 50% 감소시키고 20초동안 2초마다 6338~6662의 피해를 주는 효과가 있습니다. 이 기술을 사용하지 않고 보스를를 잡으세요."
	ralldefaulttactic46 = "켈레세스의 탱커는 큰 데미지를 받는 것을 막기위해 \"어둠핵\"을 많이 보유하고 있어야 한다."
	ralldefaulttactic47 = "The achievement is obtained by making sure that every portal is taken by someone every time portals spawn. Addon will NOT track it on a heroic difficulty"
	ralldefaulttactic48 = "\"Mystic Buffet\" - Buffets all nearby foes with magic every 6 sec. increasing magical damage taken by 10% per application. To reset stacks you have to get LOS from boss using Ice Tombs. It's difficult for tanks their rotation is quite complicated"
	ralldefaulttactic49 = "Description: \"Necrotic Plague\" -  If the target dies while afflicted or the effect ends this effect will gain an additional stack and jump to a nearby unit. If this effect is dispeled it will lose a stack and jump to a nearby unit.\nTactic: Off-tank will take all adds. 1 Necrotic Plague have to be dispeled FAR from mobs all of the following Plague you dispel near adds and wait until 1 of adds gets 30+ stacks of Necrotic Plague (addon will announce this!). Kill the Boss to get the achievement"
	ralldefaulttactic5 = "Engage boss before he comes up and block the doors"
	ralldefaulttactic50 = "Vile Spirit will join battle on a 3rd phase (<40%) just nuke them quick and kite. They explode when get close to raiders"
	ralldefaulttactic51 = "This achievement is soloable. Pull as many Steelforged Defenders as you can and kill them use game achieve tracker for it"
	ralldefaulttactic52 = "Individual achievement. Demolisher Passengers can be launched onto the Flame Leviathan where they can kill Defense Turrets to get the achievement you have to make a killing blow"
	ralldefaulttactic53 = "Players can be launched onto the Flame Leviathan from the Demolisher vehicles to take out its turrets. Taking out all turrets activates Overload Circuit which stuns the Leviathan makes him take 50% more damage and clears the entire stack of Gathering Speed. This achievement requires the raid to ignore this mechanic"
	ralldefaulttactic54 = "\"Slag Pot\" - Charges and grabs a random enemy target tossing them into the caster's slag pot. The target takes 4500 Fire damage every second for 10 sec. Main tank is not afflicted by this ability"
	ralldefaulttactic55 = "The Iron Constructs adds can gain the buff Heat by standing in the fire left by Ignis' Scorch. Once Heat reaches 10 stacks the Constructs gain the buff Molten which lasts for 20 seconds. If within this time frame they are kited to a pool of water they will loose the Molten buff and instead become Brittle for 15 seconds. A single blow dealing 5000 or more damage to a Brittle Construct will shatter it causing an explosion. Doing this last step to 2 or more Constructs within a 5 second window will grant this achievement"
	ralldefaulttactic56 = "광역기를 사용하지 않은체 암흑룬 수호병의 체력을 15000 이하로 만든 후 칼날 비늘의 정면에 세운 후 화염 숨결로 처치한다.이 업적은 누적이 된다.(25마리를 못잡았을경우 리셋이나 전멸을 통하여 다음 전투에 완료 가능)"
	ralldefaulttactic57 = "지상 2단계 일때 보스의 체력이 50프로 아래로 만든다."
	ralldefaulttactic58 = "Achievement description is not correct it's difficult to understand what fails it"
	ralldefaulttactic59 = "Do not allow any of the XS-013 Scrapbots to reach and heal X-002 Deconstructor on normal difficulty. These bots are spawned during the expose heart phases every 25% HP interval. They ignore aggro and keep moving towards the Deconstructor. The scrapbots can be slowed and rooted"
	ralldefaulttactic6 = "Don't let snakes to attack someone for a long time! Kill them or just nuke boss quick"
	ralldefaulttactic60 = "Every 25% HP interval X-002 Deconstructors heart becomes exposed and adds are spawned amongst them some XE-321 Boombots and many XS-013 Scrapbots which will move towards X-002. When XE-321 Boombots are killed they explode dealing damage to everything near them"
	ralldefaulttactic61 = "Requires the player to be under the effect of the Iron Boot Flask when the last of the tree Iron Council bosses is killed. The flask can be purchased in Storm Peaks from Olut Alegut (H) or Rork Sharpchin (A)"
	ralldefaulttactic62 = "Everyone stand in melee range except 3 rangers they will kite Focused Eye Beam"
	ralldefaulttactic63 = "Kill arms and wait their respawn. DON'T do any damage to the boss"
	ralldefaulttactic64 = "Burn the boss to %s HP kill both arms simultaneously"
	ralldefaulttactic65 = "The Feral Defender spawns after 1 minute and begins the fight with 8 stacks of Feral Essence. He can revive himself at the cost of 1 stack so getting this achievement requires killing the Defender 9 times. Be ready to kill boss after last add's life enrage will be near"
	ralldefaulttactic66 = "Individual achievement. Storm Power buffs a player for 30 seconds regardless of where he stands but the Toasty Fire and Starlight buffs appear to be limited to a random location you have to get all that 3 buffs"
	ralldefaulttactic67 = "NPC에 걸린 순간 빙결을 모두 없애서 NPC가 한명도 죽지 않게 하고 보스를 킬!!"
	ralldefaulttactic68 = "얼음파편이 땅에 떨어진 후에 모든 공대원들은 눈더미 위에 서서 순간 빙결에 걸리지 않고 보스 킬!!"
	ralldefaulttactic69 = "Do not allow a single raid member to get more then 2 stacks of Biting Cold while killing Hodir. Biting Cold stack size increase on the entire raid over time and each stack causes damage over time. Both movement and proximity to the Toasty Fires created by the mage adds will lower the amount of stacks. The dispelable close range Freeze and the avoidable Flash Freeze complicate using movement to clear the stack"
	ralldefaulttactic7 = "You have to interrupt all \"Transformation\" casts the cast time is increased by his health"
	ralldefaulttactic70 = "보스가 자신의 희귀 보관함을 부수기 전에 3분안에 죽여야 한다."
	ralldefaulttactic71 = "Once the raid has completed the gauntlet and engaged Thorim he will cast Lightning Charge every 15 seconds. It appears to be a cone based attack originating at Thorim and aimed at a lightning orb surrounding the arena"
	ralldefaulttactic72 = "Both of these adds are encountered by the raid group that goes through the gauntlet. But all raid members will earn this achievement once you kill boss"
	ralldefaulttactic73 = "The Dark Rune Warbringer - NPC that is spawned during the first phase he gives the \"Aura\" of Celerity aura. This NPC will have to be \"Mind controlled\" to buff the party with this aura at the time Thorim is defeated. The aura radius is 40 yards"
	ralldefaulttactic74 = "There will be 6 waves of adds. Kill 5 waves and then nuke boss with at least one wave alive"
	ralldefaulttactic75 = "The entire raid must avoid the Proximity Mines from phase 1 and 4 the Rocket Strikes from phases 2 and 4 and the explosions of Bomb Bot adds from phase 3. The achievement can be done in increments so avoiding all Bomb Bots will complete that condition and allow the raid to focus more on Proximity Mines or Rocket Strikes for the next week"
	ralldefaulttactic76 = "One of the Assault Bots from 3 phase must be left alive for phase 4. In Phase 4 Mimiron again casts the lethal Rocket Strike at a location preceded by a 3 second visible warning. Kite the Assault bot into this small area"
	ralldefaulttactic77 = "하드모드. 사로나이트 증기를 딜하지 않는다. 기다리면 이것들은 합쳐져서 사로나이트 원혼이 된다.원혼 생성후 원혼을 죽인후 보스를 잡으면 된다."
	ralldefaulttactic78 = "요그사론과의 전투 2단계시 사라의 감정이 겉으로 드러날때 사라에게 키스를 한다. 매크로로 만들어 두자.\n/대상 사라\n/키스"
	ralldefaulttactic79 = "During phase 2 portals will open next to Yogg. When you go inside you will be in one of the 3 visions"
	ralldefaulttactic8 = "In order to get the Residue debuff you need to be hit by Eck's frontal cone ability: Eck Spit. After that kill last boss without dying"
	ralldefaulttactic80 = "You start the fight with 100% sanity which goes down when hit by his abilities. During the fight Sanity Wells will spawn which are used to restore some of your sanity over time when you stand near them (only if you ask Freya to help you). When a person reaches 0% sanity they become mind controlled by Yogg-Saron till either one of them dies"
	ralldefaulttactic81 = "Black Holes are formed when Collapsing Stars die. This achievement refer to the closing of Black Holes by kiting the Living Constellations into them simultaneously"
	ralldefaulttactic82 = "Each time Lumbering Oaf uses his charge ability on a player random number of Mine Rats spawn around the lumber pile which the player was smashed into. Count doesn't reset so you can do it bit by bit"
	ralldefaulttactic83 = "You need to kill the boss on the first try and avoid the reaper to take any damage during trash (maybe BUG) and bossfight to get this achievement (reaper is immune to fire damage - boss adds)"
	ralldefaulttactic84 = "Individual achievement. Boss casts fire wall during all second phase"
	ralldefaulttactic85 = "After each 'Asphyxiate' boss channels his heal 'Stay of Execution' interrupt it immediately"
	ralldefaulttactic86 = "Adds (not boss) cast 'Unholy Empowerment' - interrupt all their casts"
	ralldefaulttactic87 = "When adds come - make one of them get into Geyser. No need to kill Boss to get this achievment"
	ralldefaulttactic88 = "Don't kill the Unyielding Behemoth until you get Tidal Surge effect on 3rd phase"
	ralldefaulttactic89 = "Let zealots evolve 1 by 1 and burn them down as fast as you can (before they destroy your tank). They get evolved if you don't stand in a ray"
	ralldefaulttactic9 = "Actually the impale spell won't be cast on the highest threat target so you either need 2 tanks. Kill boss after all party players will get impaled"
	ralldefaulttactic90 = "Individual achievement. Jump when boss casts 'Static Cling' - so you don't get rooted by his ability best way to get this achievement is to jump all the fight"
	ralldefaulttactic91 = "To get him affected you must kill an affected Trogg Dweller near him. Attention: 'Modgud's Malice' - Increases damage done by 100%"
	ralldefaulttactic92 = "Achievement will be awarded to all party. There are more then 5 orbs in instance you have to get only 5 of them. For example 2 of them are above the platform of the 2nd boss to get them - you have to use tornado during boss fight"
	ralldefaulttactic93 = "When you enter the 'spirit world' at 50% a Dark Hatchling will spawn. Every few seconds a soul fragment will spawn that channels a heal on the Dark Hatchling. Move them into the flame patches transforming them into Burning Souls. Kill 3 of then and you will get achieve without killing a boss!"
	ralldefaulttactic94 = "You can only perform half of this achievement on your first run here and the other half on a subsequent run. If you want to be bitten (or to NOT be bitten) then speak up now. The more DPS we do the less people will have to be bitten"
	ralldefaulttacticmain1 = "보스를 잡아도 될때 채팅창으로 알릴 것입니다."
	ralldefaulttacticmain2 = "주의 : 당신의 펫과 토템때문에 업적이 실패할수도 있습니다."
	ralldefaulttacticmain3 = "업적에 실패하면 인스턴스에 저장되고 당신은 일정기간동안 재시도 할수 없습니다."
	ralldifparty = "파티"
	ralldifraid = "공격대"
	rallglory = "영예의"
	rallmanualtxt1 = "확장팩:"
	rallmanualtxt2 = "난이도:"
	rallmanualtxt3 = "지역:"
	rallmenutxt1 = "현재 지역의 업적 목록을 이용할수 있습니다."
	rallmenutxt2 = "선택한 지역의 업적 목록"
	rallmenutxt3 = "그룹 업적을 위한 공략"
	rallnoaddontrack = "애드온 추적 없음"
	rallnotfoundachiv1 = "발견되지 않은 미완료 업적"
	rallnotfoundachiv2 = "업적 없음"
	rallnotfromboss = "보스 업적이 아님"
	rallsend = "보내기"
	ralltacticbutsave1 = "적용"
	ralltacticbutsave2 = "공략 기본값 복구"
	ralltactictext1 = "업적 선택:"
	ralltactictext2 = "공략 필요"
	ralltactictext3 = "공략보기: /raida"
	ralltitle2 = "이 모듈은 인스턴스에 입장할때 |cff00ff00|r현재 지역의 업적을 알려줍니다. 그리고 보스를 타겟팅 할때마다 업적을 알려줍니다.|cffff0000애드온에 의해 추적하지 않으면|r 현재 업적 추적을 할수없고 업적의 실패도 알려줄수 없습니다.|cffff0000보스 업적이 아님|r은 보스킬은 업적 기준이 아니라는것이고 특정 개체나 그밖의 것이라는 의미입니다. 현재 창에서 당신은 현재 지역에서 할수있는 모든 그룹 업적을 볼수 있습니다."
	ralltitle3 = "이 모듈은 현재 지역에서 가능한 업적을 보여줍니다. 채팅창으로 보낼수 있습니다."
	ralltitle33 = "공략보기: /raida' in chat displays tactics for achievments that may cause difficulties. Here you can see all tactics it`s very useful if you enter dungeon for the first time. You can edit text and send it in chat. All changes applies for all characters.\nP.S. Send your comments or tactics to me and they will be available in this addon to help others!\nP.S.2 Found many errors in english localization? Write me to get access to the curse project page to correct them!"
	ralltooltiptxt = "툴팁에 표시"
	ralltooltiptxt2 = "RA: %s 업적 발견"
	ralltooltiptxt21 = "RA: 업적 발견"
	ralltooltiptxt3 = "추가정보: /raida"
	ralltxt1 = "인스턴스에 입장할때 정보 알림:"
	ralltxt10 = "'영예의 영웅/공격대원'중 획득하지 못한 업적만"
	ralltxt11 = "'영예의 영웅/공격대원'의 모든 업적 (이미 획득한것 포함)"
	ralltxt12 = "모두 표시 - 일반/영웅 우두머리 처치을 포함한 획득하지 못한 모든 업적"
	ralltxt13 = "모두 표시 - 현 지역의 모든 업적 (이미 획득한것 포함)"
	ralltxt2 = "획득하지 못한 업적만"
	ralltxt3 = "모든 업적 (이미 획득한것 포함)"
	ralltxt4 = "'영예의 영웅/공격대원'중 획득하지 못한 업적만"
	ralltxt5 = "'영예의 영웅/공격대원'의 모든 업적 (이미 획득한것 포함)"
	ralltxt6 = "모두 표시 - 일반/영웅 우두머리 처치을 포함한 획득하지 못한 모든 업적"
	ralltxt7 = "보스를 선택할때 알림:"
	ralltxt8 = "획득하지 못한 업적만"
	ralltxt9 = "모든 업적 (이미 획득한것 포함)"
	ralltxtoff = "(끄기)"
	ralltxton = "(켜기)"
	ralluilooktactic1 = "공략 보기"
	ralluilooktactic3 = "|cffff0000공략 없음|r 이 업적은 너무 쉬워서 설명이 필요없다. 만약 당신의 공략을 |cff00ff00추가하길 원한다면 여기에 써넣어라|r"
	ralluilooktactic4 = "변경사항 저장 완료."
	ralluilooktactic5 = "공략"
	rallwhisper = "귓속말:"
	rallzonenotfound = "현재 지역은 DB에서 찾을수 없음"

end


end