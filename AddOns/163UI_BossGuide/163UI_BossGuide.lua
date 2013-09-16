local UIDROPDOWNMENUTEMPLATE = "UIDropDownMenuTemplate"
local FRAME_WIDTH = 100;
local _, BG = ...;
_G["BossGuide"] = BG;

--/print (string.gsub("[赞吉利之火]","\124","\\124"))
WW:Font("BossGuideNormalFontNormal", ChatFontNormal, 13, 1, 0.82, 0):un();
WW:Font("BossGuideNormalFontSpecial", ChatFontNormal, 13, 1, 0.6, 0):un();
WW:Font("BossGuideHighlightFont", ChatFontNormal, 13, 1, 1, 1):un();

local BG_TITLE = "网易攻略";

BG.data = {
    ["围攻砮皂寺"] = {
        [1] = { ["id"] = 693, ["name"] = "宰相金巴卡", ["text"] = "BOSS施放引爆的时候，场中的水池（腐蚀毒液），一定要有人去踩，踩了之后会变小，让引爆伤害降低。踩水池的会中树脂残渣，治疗刷好。", },
        [2] = { ["id"] = 738, ["name"] = "指挥官沃加克", ["text"] = "使用螳螂妖焦油桶时，丢向BOSS，不要丢在坦克的脚下，其他人注意躲好冲刺打击，千仞时近战远离BOSS。", },
        [3] = { ["id"] = 692, ["name"] = "将军帕克拉克", ["text"] = "注意躲好BOSS的利刃冲锋和空中的工程炸药，BOSS壁垒时，坦克拉好援军小怪，其他人全力打破壁垒，玩家可以在工程炸弹爆炸之前将其丢向BOSS或者小怪。", },
        [4] = { ["id"] = 727, ["name"] = "首领尼诺洛克", ["text"] = "躲开地上的粘稠沥青，中了加热的树脂的可以通过跳跃抵消，BOSS施放尘风时，使用快速移动技能到桥的另外一边，打断它。", },
        ["id"] = 324,
    },
    ["影踪禅院"] = {
        [1] = { ["id"] = 673, ["name"] = "古·穿云", ["text"] = "P1注意躲开地上的“静电力场”，P2直接去打天上的龙，中了“磁力帷幕”，治疗直接刷爆。P3直接开大技能rush掉。", },
        [2] = { ["id"] = 657, ["name"] = "雪流大师", ["text"] = "P1坦克和近战注意躲避“怒雷破”，BOSS施放此技能时不会移动。P2打掉两个假身，然后对真身输出。", },
        [3] = { ["id"] = 685, ["name"] = "狂之煞", ["text"] = "很简单的一个BOSS，当治疗被冲撞后，注意开技能保命。", },
        [4] = { ["id"] = 686, ["name"] = "祝踏岚", ["text"] = "仇恨值高的时候使用冥思技能将其清除，注意打断BOSS的渐燃之恨技能，优先击杀怨恨畸体，躲避地上的怨恨之环。", },
        ["id"] = 312,
    },
    ["青龙寺"] = {
        [1] = { ["id"] = 672, ["name"] = "贤者马里", ["text"] = "别长时间停留在堕落之水中。第一阶段优先击杀腐化之水，并躲开腐化之水留下来的残渣。第二阶段在躲避BOSS的喷涌的同时进行输出。", },
        [2] = { ["id"] = 664, ["name"] = "游学者石步", ["text"] = "如果碰到的是野牛人的考验，当其中的一个BOSS的buff叠加到10层后，迅速切换目标攻击另一个BOSS。如果是射日勇士，击杀天上的太阳，然后干掉boss。", },
        [3] = { ["id"] = 658, ["name"] = "刘·焰心", ["text"] = "远程职业注意躲避红色和青色的火焰波。BOSS的血量到30%后就会召唤玉龙，这时注意躲避地上的火焰，然后迅速击杀玉龙即可。", },
        [4] = { ["id"] = 335, ["name"] = "疑之煞", ["text"] = "BOSS施放“虚无之触”后，DPS优先击杀治疗的臆像，然后逐个干掉剩下的臆像。臆像不能被嘲讽，所以不要乱跑，尽可能快的杀掉臆像。", },
        ["id"] = 313,
    },
    ["残阳关"] = {
        [1] = { ["id"] = 655, ["name"] = "吉普提拉克", ["text"] = "注意永远不要和稳定的军火站一条线上。", },
        [2] = { ["id"] = 675, ["name"] = "突袭者加杜卡", ["text"] = "躲开地上的火焰（扫射），躲开地上的酸液炸弹，治疗和DPS注意跟着坦克集中。", },
        [3] = { ["id"] = 676, ["name"] = "指挥官瑞魔克", ["text"] = "躲开地上的流毒物质，在BOSS施放狂乱攻击的时候，不要站在BOSS正面。", },
        [4] = { ["id"] = 649, ["name"] = "莱公", ["text"] = "第一阶段：坦克拉好小怪，DPS在BOSS撞墙之前跳上边上的炮台，跳到BOSS头部，攻击BOSS的弱点，注意撞墙之前一定要下来。第二阶段：被BOSS凝视的玩家注意远离BOSS，其他人全力RUSH BOSS。", },
        ["id"] = 303,
    },
    ["血色修道院"] = {
        [1] = { ["id"] = 688, ["name"] = "裂魂者萨尔诺斯", ["text"] = "注意打断灵魂强风，如果没打断，注意躲开，坦克拉好小怪，迅速A掉。", },
        [2] = { ["id"] = 671, ["name"] = "科洛夫修士", ["text"] = "躲好正面的炙炎拳，火焰风暴踢时近战让开，躲好地上的火焰（炙灼之土）。", },
        [3] = { ["id"] = 674, ["name"] = "怀特迈恩", ["text"] = "第一阶段，躲好冲刺打击。第二阶段，优先打断怀特迈恩的技能，击杀怀特迈恩。", },
        ["id"] = 316,
    },
    ["血色大厅"] = {
        [1] = { ["id"] = 660, ["name"] = "驯犬者布兰恩", ["text"] = "远程注意分散站位，坦克拉好召唤出来的狗。", },
        [2] = { ["id"] = 654, ["name"] = "武器大师哈兰", ["text"] = "坦克将BOSS背对人群，拉好召唤的小怪，BOSS跳到场中间施放光明之刃时，注意远离。", },
        [3] = { ["id"] = 656, ["name"] = "织焰者孔格勒", ["text"] = "躲开焚烧书籍的火焰，BOSS施放巨龙之息的时，绕着BOSS躲开巨龙之息，打断BOSS的好连珠火球和炎爆术。", },
        ["id"] = 311,
    },
    ["通灵学院"] = {
        [1] = { ["id"] = 659, ["name"] = "指导者寒心", ["text"] = "第一阶段，在冰墙合拢之前击杀BOSS，不要碰到冰墙，远程分散站开，第二阶段，全力击杀护命匣，远程分散站开。", },
        [2] = { ["id"] = 663, ["name"] = "詹迪斯·巴罗夫", ["text"] = "坦克将BOSS背对人群，施放奇能迅击时，远离BOSS正面，BOSS施放扭曲幻象时，迅速击杀分身，寻找真身，找到后坦克迅速接住BOSS。", },
        [3] = { ["id"] = 665, ["name"] = "血肉傀儡", ["text"] = "躲开灵魂烈焰，玩家可以找到骨堆，点击骨堆获得骨甲术效果，坦克在BOSS生锈效果达到10层以上时，风筝BOSS，直到生锈效果消失。", },
        [4] = { ["id"] = 666, ["name"] = "莉莉安·沃斯", ["text"] = "第一阶段，远程分散站位，BOSS施放死亡之握之后，注意分散跑起来，直到黯焰效果结束。第二阶段，被凝视的玩家远离BOSS，如果BOSS击中玩家施放黯焰，其他人保持移动，躲开黯焰。", },
        [5] = { ["id"] = 684, ["name"] = "黑暗院长加丁", ["text"] = "坦克注意拉好小怪，被传送到书房的玩家，注意击杀小怪，然后出来。", },
        ["id"] = 246,
    },
    ["风暴烈酒酿造厂"] = {
        [1] = { ["id"] = 668, ["name"] = "乌克乌克", ["text"] = "BOSS的血量很高，正常输出要打很久。所以每次酒桶一出现，DPS一定要使用酒桶去撞击BOSS，每撞击一次能让BOSS受到的伤害提高10%，效果可以叠加。撞击10次左右基本就能完成击杀。", },
        [2] = { ["id"] = 669, ["name"] = "跳跳大王", ["text"] = "boss旋转和喷吐胡萝卜的时候，所有人都注意躲开。当出现跳舞兔后，DPS优先将它杀掉，然后拾取掉在地上的大棒槌，使用特殊技能迅速干掉周围的小怪。", },
        [3] = { ["id"] = 670, ["name"] = "破桶而出的炎诛", ["text"] = "中了“膨胀”debuff的玩家，注意转动方向，保证自己的左右两边没有队友。召唤出小怪后，迅速击杀掉，不然会恢复boss的血量。Boss施放“碳酸饱和”后，迅速点击周围的水泡，漂浮到上空继续输出。如果留在地面的话，你将无法施放任何技能。", },
        ["id"] = 302,
    },
    ["魔古山宫殿"] = {
        [1] = { ["id"] = 708, ["name"] = "国王的试炼", ["text"] = "力冠三军库乌艾：坦克将BOSS背对人群，躲好震荡波，拉好穆辛巴，治疗刷好穆辛巴的毁灭目标。鬼谋神算明谷子：躲开回旋风暴和磁场，打断好闪电箭。势不可挡的哈伊岩：施放流星时集中，施放燃烧时分散。", },
        [2] = { ["id"] = 690, ["name"] = "杰翰", ["text"] = "坦克拉好四只小怪，优先击杀铁皮战士，再击杀潜藏者，再击杀其他两种小怪，击杀BOSS。", },
        [3] = { ["id"] = 698, ["name"] = "武器大师席恩", ["text"] = "坦克将BOSS背对人群，BOSS施放砸击地面时，离开BOSS正面。所有人都要躲好烈焰之环，旋风之斧，利刃陷阱。", },
        ["id"] = 321,
    },
}

    -- ["魔古山寶庫"] = {
    --     [1] = { ["id"] = 679, ["name"] = "石衛士", ["text"] = "TODO", },
    --     [2] = { ["id"] = 689, ["name"] = "『咒魔』馮", ["text"] = "TODO", },
    --     [3] = { ["id"] = 682, ["name"] = "『縛靈者』卡拉賈", ["text"] = "TODO", },
    --     [4] = { ["id"] = 687, ["name"] = "帝王之魂", ["text"] = "TODO", },
    --     [5] = { ["id"] = 726, ["name"] = "艾拉岡", ["text"] = "TODO", },
    --     [6] = { ["id"] = 677, ["name"] = "大帝之志", ["text"] = "TODO", },
    --     ["id"] = 317,
    -- },
    -- ["恐懼之心"] = {
    --     [1] = { ["id"] = 745, ["name"] = "女皇大臣索拉格", ["text"] = "TODO", },
    --     [2] = { ["id"] = 744, ["name"] = "刀鋒領主塔亞克", ["text"] = "TODO", },
    --     [3] = { ["id"] = 713, ["name"] = "加拉隆", ["text"] = "TODO", },
    --     [4] = { ["id"] = 741, ["name"] = "風領主瑪爾加拉克", ["text"] = "TODO", },
    --     [5] = { ["id"] = 737, ["name"] = "塑珀者翁索克", ["text"] = "TODO", },
    --     [6] = { ["id"] = 743, ["name"] = "杉齊爾女皇", ["text"] = "TODO", },
    --     ["id"] = 330,
    -- },
    -- ["潘達利亞"] = {
    --     [1] = { ["id"] = 691, ["name"] = "憤怒之煞", ["text"] = "TODO", },
    --     [2] = { ["id"] = 725, ["name"] = "沙利斯的劫掠兵團", ["text"] = "TODO", },
    --     ["id"] = 322,
    -- },
    -- ["豐泉台"] = {
    --     [1] = { ["id"] = 683, ["name"] = "豐泉守衛者", ["text"] = "TODO", },
    --     [2] = { ["id"] = 742, ["name"] = "楚龍", ["text"] = "TODO", },
    --     [3] = { ["id"] = 729, ["name"] = "蕾希", ["text"] = "TODO", },
    --     [4] = { ["id"] = 709, ["name"] = "恐懼之煞", ["text"] = "TODO", },
    --     ["id"] = 320,
    -- },

    -- ["格瑞姆巴托"]	= { --  Grim Batol  --
    --     id=71,
    --     {id=131, name = "乌比斯将军", text = "躲好Boss的点名冲锋和范围震荡波，全程控制好紫色小怪。"},
    --     {id=132, name = "铸炉之主索朗格斯", text = "Boss选择双持武器的时候可以缴械他，选择双手武器的时候则风筝他，选择盾牌的时候则要在背后揍他。"},
    --     {id=133, name = "达加·燃影者", text = "全程优先击杀火元素，龙阶段注意躲好喷火。"},
    --     {id=134, name = "埃鲁达克", text = "Boss全屏Aoe的时候躲进风眼，Aoe过后马上到门口击杀小怪。如此往复即可。"},
    -- },
    -- ["黑石岩窟"]	= { --  Blackrock Caverns  --
    --     id=66,
    --     {id=105, name = "摧骨者罗姆欧格", text = "优先打锁链，躲开Boss蓄力旋风斩。Boss召唤出的小怪由T拉住让boss自己旋风斩劈死即可。"},
    --     {id=106, name = "柯尔拉，暮光之兆", text = "三个人挡三条线，Debuff到80层离开，Debuff消掉后继续挡，如此往复。T自己打断好boss恐惧。"},
    --     {id=107, name = "卡尔什·断钢", text = "T控制好时间让Boss一直处于被火烧的状态，不能太猛，也尽量不要断掉buff。断掉Buff场地周围会刷出小怪。"},
    --     {id=108, name = "如花", text = "控制好两条小狗，然后将如花击杀即可，无需注意技能。"},
    --     {id=109, name = "升腾者领主奥西迪斯", text = "由一名远程DPS风筝三只小怪，其他人打boss。Boss会在三个分身中切换，所以要保证一致攻击本体。"},
    -- },
    -- ["潮汐王座"]	= { --  The Throne of Tides  --
    --     id=65,
    --     {id=101, name = "纳兹夏尔女士", text = "第一阶段的震爆一定要打断，喷泉要拉着boss离开，第二阶段注意别被风吹起来，小怪控制左右先杀中间。"},
    --     {id=102, name = "指挥官乌尔索克", text = "Boss重击T要躲好，沿着场地最外侧拉boss直到将其击倒。"},
    --     {id=103, name = "蛊心魔古厄夏", text = "第一阶段地上的刺要躲好，熔岩爆裂要打断。第二阶段法系看见Boss给自己上盾要马上停手，不然它会回血。"},
    --     {id=104, name = "厄祖玛特", text = "第一阶段鱼人和无面者清理好，第二阶段杀掉三个小怪躲好黑水，T拉着血肉兽风筝。第三阶段找到大章鱼杀之。"},
    -- },
    -- ["旋云之巅"]	= { --  The Vortex Pinnacle  --
    --     id=68,
    --     {id=114, name = "大宰相尔埃尔坦", text = "旋风在外圈的时候要站在内圈，当旋风合拢时，所有人要站出来。碰到旋风攻击速度会减少很多"},
    --     {id=115, name = "阿尔泰鲁斯", text = "别碰到旋风，保持全程站在顺风位置即可。逆风的话读条会很久"},
    --     {id=116, name = "阿萨德", text = "分散站位，减少闪电链伤害。boss召唤法阵后全都站在法阵内，不然会被A死。"},
    -- },
    -- ["巨石之核"]	= { --  The Stonecore  --
    --     id=67,
    --     {id=110, name = "克伯鲁斯", text = "A好Boss喷出的小水晶，第二阶段Boss在底下，不要被他钻出来的时候撞到，会秒杀的。之后回到第一阶段。"},
    --     {id=111, name = "岩皮", text = "躲好地上的岩浆圈，Boss在地面全屏Aoe躲在柱子后面卡视角。空中阶段不要被落下来的石柱砸到。"},
    --     {id=112, name = "欧泽鲁克", text = "Boss给自己套盾的时候远程给Boss上dot反弹给自己，近战躲好粉碎，T拉好大地冲击"},
    --     {id=113, name = "高阶女祭司艾苏尔", text = "打断好boss的原力之握，将跑过来得信徒都引入重力之井会直接秒杀。第二阶段注意不要被石头砸到。"},
    -- },
    -- ["托维尔失落之城"]	= { --  Lost City of the Tol'vir  --
    --     id=69,
    --     {id=117, name = "胡辛姆将军", text = "躲好地上黄色光泽的炸弹，以及boss踩地板时候冒出的地刺"},
    --     {id=118, name = "锁喉", text = "A好小鳄鱼，别站鳄鱼屁股后面，鳄鱼狂暴后T记得开个技能。矮子战斗中旋风斩要远离"},
    --     {id=119, name = "高阶预言者巴林姆", text = "第一阶段打好红凤凰，蛋不用打哦。第二阶段打黑凤凰，尽量不要让凤凰吃到灵魂。黑凤凰死后返回现实世界击杀boss。"},
    --     {id=122, name = "希亚玛特", text = "第一阶段击杀全部由boss召唤出的小怪，先杀会闪电链的。第二阶段直接rush Boss即可。"},
    -- },
    -- ["起源大厅"]	= { --  Halls of Origination  --
    --     id=70,
    --     {id=124, name = "神殿守护者安努尔", text = "第二阶段2人一组开机关，一个引怪一个开，聚到上面一起干，打完小蛇打boss。"},
    --     {id=125, name = "地怒者塔赫", text = "没有难度，boss会散化一次出现很多小怪，杀了之后boss会再次合体，打死即可。"},
    --     {id=126, name = "安拉斐特", text = "躲好他放的黑圈，Aoe的时候注意全队血量。"},
    --     {id=127, name = "伊希斯特", text = "放Aoe的时候背对Boss，第一次分身杀雨，第二次分身杀纱，第三次过了。"},
    --     {id=128, name = "阿穆纳伊", text = "全程会不断的出小花，一定要用最快的速度打掉，没有难度。"},
    --     {id=129, name = "塞特斯", text = "优先打Boss开启的传送门，然后Rush boss，不用理会小怪。"},
    --     {id=130, name = "拉夏", text = "离Boss远的人躲好Boss的跳跃，打断好太阳之球，全团使劲打即可，木桩战"},
    -- },
    -- ["死亡矿井"]	= { --  The Deadmines  --
    --     id=63,
    --     {id=89, name = "格拉布托克", text = "第一阶段rush Boss，第二阶段躲好火墙继续Rush Boss"},
    --     {id=90, name = "赫利克斯·破甲", text = "躲好Boss随机扔的地雷，胖子死后击杀小地精即可。注意被小地精绑了炸弹的人要远离人群。"},
    --     {id=91, name = "死神5000", text = "一个玩家控制机器人在下面杀好火元素，其他人在斜坡杀好Boss，急速旋转近战记得远离"},
    --     {id=92, name = "撕心狼将军", text = "全程出气体怪全队优先击杀，然后再打boss，最后一次出三个气体怪的时候可直接rush boss"},
    --     {id=93, name = "“船长”曲奇", text = "再出好吃的抵消坏吃的的debuff并且获得施法加速的buff，轮着吃，边吃边打Boss，施法特别快，打的特别爽！"},
    --     {id=95, name = "梵妮莎·范克里夫", text = "全程优先打小怪，要爆炸的时候跳船边的绳子荡走。"},
    -- },
    -- ["影牙城堡"]	= { --  Shadowfang Keep  --
    --     id=64,
    --     {id=96, name = "灰葬男爵", text = "Boss读什么打断什么，加血的那个让他读两下再打断。如果你够猛也可以直接打断"},
    --     {id=97, name = "席瓦莱恩男爵", text = "出狼先打狼，打完狼再打Boss。"},
    --     {id=98, name = "指挥官斯普林瓦尔", text = "优先击杀小怪，躲好Boss喷火，不要站在绿圈里，小怪的邪恶活化尽量打断"},
    --     {id=99, name = "沃登勋爵", text = "绿瓶移动，红瓶不动，蓝瓶看情况动。"},
    --     {id=100, name = "高弗雷勋爵", text = "诅咒子弹一定要解，不能解就一定要打断。Boss的满天弹幕要躲开"},
    -- },
    -- ["祖尔格拉布"]	= { --  Zul'Gurub  --
    --     id=76,
    --     dbmName = "祖尔格拉布(5人)",
    --     {id=175, name = "高阶祭司温诺希斯", text = {
    --         "P1: 先在外面吃毒锅再进去开Boss。地上像“迷宫图案”的毒，千万不要踩到！ '毒之机关枪'要打断，中了连线的人要互相远离扯断连线，治疗要全力抬他们的血。"," ",
    --         "P2: 三次连线后进入第二阶段。Boss狂暴伤害提高100%，坦克要开启盾墙抵挡；地上会出现毒之喷泉，一定要注意躲避；同时Boss会向前方扇形喷毒，坦和近战要注意躲避(这段压力很大)。"," ",
    --         "P3: 躲Boss的毒光扫射，同时更要注意地上“迷宫图案”的毒和毒喷泉。之后，Boss会昏迷，受到伤害提高100%。火力全开把它打到20%。随后再次进入第一阶段。"," ",
    --     }},
    --     {id=176, name = "血领主曼多基尔", text = {
    --         "周围魂魄会复活你，每次被复活，伤害和治疗提高10%，受到伤害降低10%，可叠加。但迅猛龙会杀魂魄，所以每次血领主复活了龙都要立刻杀掉它。", " ",
    --         "Boss技能\124cff71d5ff\124Hspell:96740\124h[毁灭猛击]\124h\124r秒杀前方扇形范围，动画很显眼，一定要躲开。", " ",
    --     }},
    --     {id=181, name = "高阶祭司基尔娜拉", text = {
    --         "P1: 打断暗影AOE，躲避暗影风墙；P2(50%血量)：Boss变身呼唤周围小豹子(Boss周围有4波小豹子，进战斗后就可以杀)。"," ",
    --         "打法1：50%治疗停手防止拉仇恨，坦克群嘲拉住小豹子后dps大招全开A掉（此打法坦克要硬）。"," ",
    --         "打法2：开Boss后先清小豹子，留一波等到50%再A掉。"," ",
    --     }},
    --     {id=184, name = "赞吉尔", text = {
    --         "Boss技能\124cff71d5ff\124Hspell:96914\124h[赞吉利之火]\124h\124r碰到就死，坦克注意躲，近战全程身后输出。", " ",
    --         "记住场上3个大锅的位置：毒、冰、火，Boss随机使用以下3个技能，不同技能不同对策：", " ",
    --         " 全场毒气：看到场地变绿立刻点绿锅，否则5秒后每秒2万伤害。", " ",
    --         " 召唤1个巨怪：被点名的跑，一个dps吃冰锅冰冻其10秒，迅速杀掉。", " ",
    --         " 召唤大量僵尸：坦克和dps吃火锅，进去烧死他们，治疗注意抬血。", " ",
    --     }},
    --     {id=185, name = "碎神者金度", text = {
    --         "P1：无压力，躲在护罩里让物理DPS输出，70%左右进入P2。"," ",
    --         "P2：远程杀魂魄和巨怪，坦克拉巨怪，所有人等点名被砸，破掉一个锁链无敌，随即近战杀之。"," ",
    --         "解释：P2目标是打掉3条锁链，但锁链开始是无敌的，坦克拉一个巨怪，其他人找一个锁链重合站位，巨怪点名跳向一个队友就会破除他那个锁链的无敌。"," ",
    --     }},
    -- },
    -- ["祖阿曼"]	= { --  Zul'Aman  --
    --     id=77,
    --     dbmName = "祖阿曼(5人)",
    --     {id=186, name = "埃基尔松", dbmName = "埃基尔松(鹰)", text = "平时分散站位，否则会被闪电连到；\124cff71d5ff\124Hspell:97300\124h[电能风暴]\124h\124r拉起一个人后，迅速集中到他下面的云里；白鹰抓人迅速秒掉（被抓的也能打）。"},
    --     {id=187, name = "纳洛拉克", dbmName = "纳洛拉克(熊)", text = "所有人分散，Boss人形态会冲锋最远目标，被冲锋的去Boss脚下打，一般需要3个人去吃冲锋。熊形态下攻击比较猛，加好就行了。"},
    --     {id=188, name = "加亚莱", dbmName = "加亚莱(龙鹰)", text = "躲开吐息火墙和炸弹，控制孵化速度（一般一次留一个孵化者，孵化完一边后杀死他），注意20%时所有蛋全都变为小龙鹰。"},
    --     {id=189, name = "哈尔拉兹", dbmName = "哈尔拉兹(山猫)", text = "水图腾不要打，所有远程dps和治疗站进去，但坦克要第一时间把Boss拉开否则回血；闪电图腾秒掉就好，召唤的山猫可以不管，直接输出Boss。"},
    --     {id=190, name = "妖术领主玛拉卡斯", text = "可以控制小怪直接BOSS，也可以杀掉小的再打大的。Boss偷技能后稍微注意一下。另外注意打断BOSS加血。"},
    --     {id=191, name = "达卡拉", text = {
    --         "80%之前人形态，流血Debuff要顶满血；80%和40%血量会随机变身两种形态：",
    --         "\124cff71d5ff\124Hspell:42608\124h[龙鹰之形]\124h\124r 不要站在火柱里，躲好火焰吐息，治疗刷好全团就行",
    --         "\124cff71d5ff\124Hspell:42607\124h[山猫之形]\124h\124r 压力很大，建议开嗜血英勇大招，被选为目标后能自保的自保，不能的注意刷血。",
    --         "\124cff71d5ff\124Hspell:42594\124h[野熊之形]\124h\124r 跟熊Boss打法一样，中了冲锋就靠近BOSS。",
    --         "\124cff71d5ff\124Hspell:42606\124h[雄鹰之形]\124h\124r 施法会受到伤害，注意躲开场上的龙卷风，尽力打掉图腾即可。",
    --     }},
    -- },

    -- ["时光之末"] = {
    --     {id=340, name="贝恩的残影", text="贝恩会随机给一位玩家投掷图腾，注意点击图腾投掷给贝恩将他击晕。地面塌了之后马上游到别的岛上。",},
    --     {id=285, name="吉安娜的残影", text="进入场地之后先开16个碎片，然后杀BOSS。注意躲BOSS从脚下射出来的3道霜刃。",},
    --     {id=323, name="希尔瓦娜斯的残影", text="BOSS会把玩家拉到身边并在她周围复活食尸鬼，所有人集中杀一只，打开一道缺口后跑出去远离BOSS，近战杀食尸鬼的时候不要踩食尸鬼背后的黑水（踩到会被秒哦）。",},
    --     {id=283, name="泰兰德的残影", text="法系远离BOSS周围15码距离。注意打断BOSS施放的星尘。躲好月影枪（在地面从BOSS脚下射出的3道光）。",},
    --     {id=289, name="姆诺兹多", text="躲好扭曲炸弹（地上的光圈）。近战在BOSS侧面打。BOSS血量每降低20%就点一次中间的沙漏（重置所有技能cd，死人也复生）",},
    --     ["id"] = 184,
    -- },
    -- ["永恒之井"] = {
    --     {id=290, name="佩罗萨恩", text="躲好地上的火圈。到出眼球的阶段，DPS和治疗跑到场地最边上躲树后面不要让眼球碰到，尽量让T去碰眼球。",},
    --     {id=291, name="艾萨拉女王", text="所有人分散10码站位。一定要打断女王施放的“绝对服从”。躲好地上的火。队友中了女王的奴仆之后，其他队友注意打掉队友头上的女王之手。",},
    --     {id=292, name="玛诺洛斯与瓦罗森", text="先杀掉瓦罗森，泰兰德被困住的时候杀掉旁边的两个恐惧魔王，瓦罗森死后捡地上的灵魂刀投向玛诺洛斯。全程注意躲邪火风暴（地上一大堆火）。",},
    --     ["id"] = 185,
    -- },
    -- ["暮光审判"] = {
    --     {id=322, name="阿奎里恩", text="躲好地上的冰圈。治疗注意驱散队友的寒冰链（类似法师冰环效果）。DPS注意打掉萨尔的冰墓。",},
    --     {id=342, name="埃希拉·黎明克星", text="注意躲开BOSS在脚下放的烟雾弹。T尽量把BOSS拉到萨尔的图腾范围内（增加DPS）。",},
    --     {id=341, name="大主教本尼迪塔斯", text="躲好地上的光圈。BOSS在头上召唤出3个黑球的时候，所有人8码距离分散。地上的黑圈躲好。注意躲开横扫整个平台的暮光之潮（一道很大的暗影波浪）。",},
    --     ["id"] = 186,
    -- },
    -- ["巨龙之魂"] = {
    --     [1] = {id=311, name="莫卓克", text="所有人集中站BOSS脚下，和共鸣水晶连线后去和水晶重合，大地之怒的时候躲石头后面。",},
    --     [2] = {id=324, name="督军佐诺兹", text="除了T，其他人分两组（远程和近战）站BOSS背后，黑球出来后，近战组和远程组一起弹球，5层之后弹给BOSS，弹球时保证身边有人。BOSS放AOE集中站刷血。",},
    --     [3] = {id=325, name="不眠的约萨希", text="BOSS会从场地边上召唤6种颜色的软泥怪，所有DPS第一时间集中杀掉一只就行了，各种颜色软泥怪击杀优先级：紫-绿-黄-蓝-红-黑。",},
    --     [4] = {id=317, name="缚风者哈格拉", text="中冰抢远离人群，T退后躲专注打击。寒冰暴雨阶段：顺时针跑着打水晶，躲好寒冰之潮。闪电风暴阶段先杀掉束缚气元素，所有人把身上中的雷电导管效果带到每一个水晶导体上。",},
    --     [5] = {id=331, name="奥卓克希昂", text={"所有人集中一点站，每位玩家必须找到自己屏幕中下方动作条上面的“英勇意志”技能，你们要靠这个技能来躲避BOSS的暮光审判（BOSS读条的最后5秒使用）。","中了黯淡之光的玩家，如果不在BUFF即将消失的最后几秒使用“英勇意志”，那将直接被杀死。"},},
    --     [6] = {id=332, name="战争大师黑角", text={"P1.远程杀天上的龙，近战杀船上的怪（T把怪拉着背对人群，其他人分散站，注意躲小怪的冲锋）。暮光杀戮的时候，所有人跑到紫色漩涡圈分担伤害。","P2.随时躲开BOSS正面的震荡波，躲好地上的黑圈，法系远离BOSS周围10码。"},},
    --     [7] = {id=318, name="死亡之翼的背脊", text={"随便杀掉一根触须之后，T把融合怪拉到最前面，DPS把融合怪血量打到10%停手，熔岩怪必须死在融合怪身边，等融合怪的超热之核叠到9层就全力杀掉他（爆炸的时候远离）。","然后DPS马上转目标全力击杀最前面的装甲板连接束，以上重复3次就过了。"},},
    --     [8] = {id=333, name="疯狂的死亡之翼", text={"场地有4个台子，台子击杀顺序为绿、黄、红、蓝（颜色为每个台子对应的守护巨龙的颜色，台子顺序不固定），每个台子优先击杀后面的变异的腐蚀，穿刺注意换T。", "源质剑出来的时候，地上的小光圈躲开，迅速杀掉源质剑。然后杀肢体触须，召唤出来的血液连肢体触须一起给能顺带AOE的职业A掉。", "4个台子击杀完了之后，跳到绿龙的台子，全力RUSH死亡之翼。"},},
    --     author = "|cffff0000本攻略仅适用随机团队难度|r\n",
    --     ["id"] = 187,
    -- },

--[[
    ["怒焰裂谷"]	= {
        {name = "熔岩元素", text = "11111"},
        {name = "钻土虫", text = "22222"},
    },
--]]

local SEND_TIP = "|cff00d100点击查看地下城手册\nCtrl点击发送至频道|r"

for k, v in pairs(BG.data) do
    for i, info in ipairs(v) do
        if(type(info.text)=="string") then
            info.text = {info.name, info.text}
        else
            table.insert(info.text, 1, info.name);
        end
        if(v.author) then
            table.insert(info.text, v.author)
        end
        table.insert(info.text, SEND_TIP)
    end
end

BG.menus = {}

local function selectZone(self, arg1, arg2, checked)
    BG.frame.title:SetText(BG_TITLE);
    BG:SelectZone(arg1);
end

for k, v in pairs(BG.data) do
    table.insert(BG.menus, {text=k, value=k, arg1=k, func=selectZone, });
    table.sort(BG.menus, function(a,b)
        a = BG.data[a.value]
        b = BG.data[b.value]
        if not a.id or not b.id then
            return not b.id
        else
            return a.id > b.id
        end
    end)
end

function BG:Initialize()
    BG:CreateUI("BossGuideFrame");
    BG.ToggleMinimum(nil, true);
    CoreDispatchEvent(BG.frame, BG)
    BG:Enable();
    BG:SelectZone("暮光审判");
    self.frame:SetPoint("TOP", Minimap, "BOTTOM", 30, -50);
    self.frame:StartMoving();
    self.frame:StopMovingOrSizing();
end

function BG:PLAYER_ENTERING_WORLD(...)
    if self.data[GetZoneText()] then
        --BG:StartFlash();
        self:SelectZone(GetZoneText())
    end
end

BG.ZONE_CHANGED_INDOORS = BG.PLAYER_ENTERING_WORLD
BG.ZONE_CHANGED_NEW_AREA = BG.PLAYER_ENTERING_WORLD
BG.ZONE_CHANGED = BG.PLAYER_ENTERING_WORLD

local autoSent = {}
function BG:UNIT_TARGET(event, unit)
    local zone = GetZoneText();
    if zone and self.data[zone] and unit == "player" and UnitIsEnemy("target", "player") and UnitHealth("target") > 0 then
        autoSent[zone] = autoSent[zone] or {};
        local name = UnitName("target");
        if autoSent[zone][name] then return end
        autoSent[zone][name] = true
        for k, v in ipairs(self.data[zone]) do
            if(v.name==name) then
                self:StartFlash();
                self.frame.title:SetText(v.name);
                BG:SetButton(self.frame.title, v);
                return;
            end
        end
    end
end
---恢复名字
function BG:PLAYER_REGEN_ENABLED(event)
    self.frame.title:SetText(BG_TITLE);
end
function BG:Enable()
    BG.frame:Show();
    BG.frame:RegisterEvent("ZONE_CHANGED");
    BG.frame:RegisterEvent("PLAYER_ENTERING_WORLD");
    BG.frame:RegisterEvent("ZONE_CHANGED_INDOORS");
    BG.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    BG.frame:RegisterEvent("UNIT_TARGET");
    BG.frame:RegisterEvent("PLAYER_REGEN_ENABLED");
end

function BG:Disable()
    BG.frame:UnregisterAllEvents();
    BG.frame:Hide();
end

local function bossOnClick(self, button)
    --local button = DBM_GUI_OptionsFrameBossModsButton1 button.element.showsub = false; DBM_GUI_OptionsFrame:ToggleSubCategories(button.toggle)
    if self.info then
        local zone = UIDropDownMenu_GetSelectedValue(BG.frame.menu)
        if(IsControlKeyDown())then
            if(self.info.bosslink == nil) then
                local id = BG.data[zone] and BG.data[zone].id
                if(id) then
                    EJ_SelectInstance(id)
                    local i = 1
                    while(true) do
                        local name, desc, bossid, _, link = EJ_GetEncounterInfoByIndex(i)
                        if(not name) then
                            break
                        end
                        if(bossid == self.info.id) then
                            self.info.bosslink = link
                        end
                        i = i + 1
                    end
                end
            end

            local lineNo = 0
            for i=2, #self.info.text-1 do
                local text = self.info.text[i];
                if i==2 then
                    local header = "有爱攻略"..(self.info.bosslink or "["..self.info.name.."]")..":";
                    if #header + #text > 254 then
                        local channel = 'SAY'
                        if(U1UseInstanceChat()) then
                            channel = 'INSTANCE_CHAT'
                        elseif(IsInGroup()) then
                            channel = IsInRaid() and 'RAID' or 'PARTY'
                        end
                        SendChatMessage("网 易 "..header, channel)
                    else
                        text = header..text;
                    end
                end
                if text and #text:trim() > 0 then
                    lineNo = lineNo + 1
                    if lineNo > 1 then text = "["..lineNo.."] "..text end
                    local channel = 'SAY'
                    if(IsInGroup()) then
                        channel = IsInRaid() and 'RAID' or 'PARTY'
                    end
                    SendChatMessage(text, channel)
                end
            end
        else
            --local ids = BG.IDS[zone] print(ids.id, ids[self.info.name])
            if BG.data[zone].id then
                if not EncounterJournal or not EncounterJournal:IsShown() then
                    ToggleEncounterJournal();
                end
                EncounterJournal_ListInstances();
                EncounterJournal_DisplayInstance(BG.data[zone].id);
                if self.info.id then
                    EncounterJournal_DisplayEncounter(self.info.id)
                    if EJ_InstanceIsRaid() then
                        EJ_SetDifficulty(5);
                    else
                        EJ_SetDifficulty(2);
                    end
                end
            end
            
        --[=[
            if IsAddOnLoaded("DBM-Core") then
                if not IsAddOnLoaded("DBM-Party-Cataclysm") then
                    for k,addon in ipairs(DBM.AddOns) do
                        if addon.modId == "DBM-Party-Cataclysm" then
                            DBM:LoadMod(addon);
                            break;
                        end
                    end
                end
                DBM:LoadGUI();
                DBM_GUI:ShowHide(true);
                local zone = UIDropDownMenu_GetSelectedValue(BG.frame.menu)
                zone = BG.data[zone].dbmName or zone
                for i, v in ipairs(DBM_GUI_Bosses.Buttons) do
                    if v.parent == zone and v.frame and v.frame.name == (self.info.dbmName or self.info.name) then
                        DBM_GUI_OptionsFrame:DisplayFrame(v.frame)
                        break
                    end
                end
            end
        --]=]
        end
    end
end

function BG:SetButton(button, info)
    button.info = info;
    button.tooltipLines = info.text;
end

function BG:SelectZone(zone)
    local infos = BG.data[zone];
    if not infos then return end
    UIDropDownMenu_SetSelectedValue(self.frame.menu, zone);
    for i, info in ipairs(infos) do
        if not self.lines[i] then
            local btn = WW:Button(nil, self.frame.menuBtn):SetSize(FRAME_WIDTH,20)
            :SetButtonFont(BossGuideNormalFontNormal)
            :SetHighlightFontObject(BossGuideHighlightFont)
            :SetText(" ");

            if(i==1) then
                btn:TL(self.frame.menuBtn, "BOTTOMLEFT")
            else
                btn:TL(self.lines[i-1], "BOTTOMLEFT");
            end

            CoreUIMakeMovable(btn, self.frame);
            CoreUIEnableTooltip(btn);
            btn:SetScript("OnClick", bossOnClick)
            btn:GetButtonText():SetSize(FRAME_WIDTH-8,13);
            self.lines[i] = btn:un();
        end
        self.lines[i]:Show();
        BG:SetButton(self.lines[i], info);
        self.lines[i]:SetText(info.name);
    end
    self.numLines = #infos
    if self.frame.menuBtn:IsShown() then
        CoreUIKeepCorner(self.frame,"TOPLEFT");
        self.frame:SetSize(FRAME_WIDTH, 22 + 20*BG.numLines + (BG.numLines>0 and 5 or 0));
    end

    for i = #infos + 1, #self.lines do
        self.lines[i]:Hide();
    end
end

function BG:StartFlash()
    CoreUIShowCallOut(self.frame, nil, nil, -8, 8, 8, -8)
end

function BG:StopFlash()
    CoreUIHideCallOut();
end

function BG.ToggleMinimum(self, v)
    self = self or BG.frame.collapse;
    local f = BG.frame
    local menuBtn = f.menuBtn;
    CoreUIKeepCorner(f,"TOPRIGHT");
    if menuBtn:IsShown() and v~=false then
        f:SetSize(FRAME_WIDTH-16, 22);
        menuBtn:Hide();
        self:SetNormalTexture([[Interface\Minimap\UI-Minimap-ZoomInButton-Up]])
        self:SetPushedTexture([[Interface\Minimap\UI-Minimap-ZoomInButton-Down]])
    else
        f:SetSize(FRAME_WIDTH, 22 + 20*BG.numLines + (BG.numLines>0 and 5 or 0));
        menuBtn:Show();
        self:SetNormalTexture([[Interface\Minimap\UI-Minimap-ZoomOutButton-Up]])
        self:SetNormalTexture([[Interface\Minimap\UI-Minimap-ZoomOutButton-Up]])
    end
end

function BG:CreateUI(name)
    self.lines = {};
    self.numLines = 0;
    local f = WW:Frame(name, UIParent):Size(100,22):SetToplevel(true):SetClampedToScreen(true):Backdrop(
        [[Interface\GLUES\CHARACTERCREATE\UI-CHARACTERCREATE-BACKGROUND]],
        [[Interface\Tooltips\UI-Tooltip-Border]], 8, 2)
    CoreUIMakeMovable(f);
    f:SetScript("OnEnter", function()
        BG:StopFlash();
    end)

    local menu = f:Frame("$parentMenu", UIDROPDOWNMENUTEMPLATE, "menu"):un();
    local menuBtn = f:Button():Key("menuBtn"):SetSize(22,22):TL(1,0)
    :SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
    :SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
    :SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
    :SetScript("OnClick", function(self, button)
        for _, v in ipairs(BG.menus) do v.checked = nil end --必须手工清除清除，BG.menus以已被修改
        EasyMenu(BG.menus, menu, self, 0, 0, "MENU", 2);
    end)

    local collapse = f:Button():Key("collapse"):TR(-3,-3):Size(16)
    :SetHighlightTexture([[Interface\Minimap\UI-Minimap-ZoomButton-Highlight]])
    :SetScript("OnClick", BG.ToggleMinimum)

    local title = f:Button():Key("title"):RIGHT(collapse, "LEFT", 0, 1):SetSize(60,13):SetButtonFont(BossGuideNormalFontSpecial):GetButtonText():SetText(BG_TITLE):SetSize(60,13):up():un();
    CoreUIMakeMovable(title, f())
    CoreUIEnableTooltip(title, "网易有爱副本小攻略", "\n选中boss然后按Ctrl点击发送，如需关闭请通过插件中心-副本小攻略");
    title:SetScript("OnClick", bossOnClick);

    self.frame = f:un();
end

BG:Initialize()
--WWRun(function(name) BG:CreateUI(name) end, "BossGuideFrame");

--[=[
--获取副本ID和BOSSID

local zones = {}

for i=1, 100 do
  local instanceId,zname, _, _, _, _, zid = EJ_GetInstanceByIndex(i,true)
  if instanceId then zones[instanceId] = zname else break end
end

for i=1, 100 do
  local instanceId,zname, _, _, _, _, zid = EJ_GetInstanceByIndex(i,false)
  if instanceId then zones[instanceId] = zname else break end
end

U1DB.temp = {}
for instanceId, loc_zname in pairs(zones) do
  local map = {}
  U1DB.temp[loc_zname] = map
  map.id = instanceId
  EJ_SelectInstance(instanceId)
  for i=1, 100 do
    local name, description, bossID, _, link = EJ_GetEncounterInfoByIndex(i);
    if not name then break end
    map[name] = bossID
  end
end

---直接生成BossGuide数据框架
for instanceId, loc_zname in pairs(zones) do
  local map = {}
  U1DB.temp[loc_zname] = map
  map.id = instanceId
  EJ_SelectInstance(instanceId)
  for i=1, 100 do
    local name, description, bossID, _, link = EJ_GetEncounterInfoByIndex(i);
    if not name then break end
    tinsert(map, {id = bossID, name = name, text = 'TODO'})
  end
end

/save U1DB.temp

--]=]




