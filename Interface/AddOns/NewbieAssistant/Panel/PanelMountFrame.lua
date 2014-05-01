-- Author      : s1172
-- Create Date : 2013/4/29 13:51:59

function NewbieAssistantPanelMountFrame_OnShow(self)
	local race = select(2,UnitRace("player"))
	if race == "Dwarf" then
		self.data[4] = { -- 白山羊
			id = 5873,
			Title = "白山羊",
			Texture = [[Interface\Icons\Ability_Mount_MountainRam]],
			Link = "|cff0070dd|Hitem:5873:0:0:0:0:0:0:0:10:0:0|h[白山羊]|h|r",
			bgTitle = "【传说】",
			bgDescription = "来自丹莫罗的白山羊，是一种古老的山羊品种，其头颅宽大，鼻梁平直，颈短而厚，背腰长而平直，四肢粗壮。毛色若白雪纯净无暇，双角向后弯曲呈倒“八”字型，性烈好斗，因为丹莫罗长常积雪，白山羊全身覆盖20厘米长的粗毛。矮人种族的角色升至20级便可以购买这头坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在铁炉堡外面的【冻石农场】找【奥萨姆·铁角】学习骑术，『维隆·冻石』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\dwarf-20",
		}
		self.data[8] = { -- 迅捷白山羊
			id = 18785,
			Title = "迅捷白山羊",
			Texture = [[Interface\Icons\Ability_Mount_MountainRam]],
			Link = "|cffa335ee|Hitem:18785:0:0:0:0:0:0:0:10:0:0|h[迅捷白山羊]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是白山羊的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。矮人玩家在40级后即可购买这头山羊。",
			getTitle = "【获取途径】",
			getDescript = "在铁炉堡外面的【冻石农场】找【奥萨姆·铁角】学习骑术，『维隆·冻石』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\dwarf-40",
		}
	elseif race == "NightElf" then
		self.data[4] = { -- 条纹霜刃豹缰绳
			id = 8631,
			Title = "条纹霜刃豹缰绳",
			Texture = [[Interface\Icons\Ability_Mount_WhiteTiger]],
			Link = "|cff0070dd|Hitem:8631:0:0:0:0:0:0:0:10:0:0|h[条纹霜刃豹缰绳]|h|r",
			bgTitle = "【传说】",
			bgDescription = "古老的霜刃豹主要生活在卡利姆多北部森林，它们具有宠大的体形，身长最大3米开外，它们拥有长达30厘米的剑齿，所以它们又是艾泽拉斯大陆最大的剑齿猫科动物，暗夜精灵长期驯化霜刃豹成为精灵们的朋友，当游戏中的角色达到20级时，大家就可以购买霜刃豹成为大家的坐骑了。",
			getTitle = "【获取途径】",
			getDescript = "在达纳苏斯的【塞纳里奥区】找【贾萨姆】学习骑术，『莱兰奈』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\nightelf-20",
		}
		self.data[8] = { -- 迅捷霜刃豹缰绳
			id = 18766,
			Title = "迅捷霜刃豹缰绳",
			Texture = [[Interface\Icons\Ability_Mount_WhiteTiger]],
			Link = "|cffa335ee|Hitem:18766:0:0:0:0:0:0:0:10:0:0|h[迅捷霜刃豹缰绳]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是条纹霜刃豹的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。暗夜精灵玩家在40级后即可购买这头霜刃豹。",
			getTitle = "【获取途径】",
			getDescript = "在达纳苏斯的【塞纳里奥区】找【贾萨姆】学习骑术，『莱兰奈』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\nightelf-40",
		}
	elseif race == "Draenei" then
		self.data[4] = { -- 紫色雷象
			id = 29743,
			Title = "紫色雷象",
			Texture = [[Interface\Icons\Ability_Mount_RidingElekk_Purple]],
			Link = "|cff0070dd|Hitem:29743:0:0:0:0:0:0:0:10:0:0|h[紫色雷象]|h|r",
			bgTitle = "【传说】",
			bgDescription = "埃索达雷象目前是德莱尼种族的专属坐骑，巨大的身驱并不防碍它们的速度与迅捷，尖锐且削长的獠牙使敌人不敢轻视德莱尼人的勇猛，幸存的德莱尼勇士升至20级时就可以购买并拥有一只雷象成为坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在埃索达【正门门口】找【埃亚伦】学习骑术，『象群管理者妥拉留斯』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\draenei-20",
		}
		self.data[8] = { -- 重型蓝色雷象
			id = 29745,
			Title = "重型蓝色雷象",
			Texture = [[Interface\Icons\Ability_Mount_RidingElekkElite_Blue]],
			Link = "|cffa335ee|Hitem:29745:0:0:0:0:0:0:0:10:0:0|h[重型蓝色雷象]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是雷象的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。德莱尼玩家在40级后即可购买这头雷象。",
			getTitle = "【获取途径】",
			getDescript = "在埃索达【正门门口】找【埃亚伦】学习骑术，『象群管理者妥拉留斯』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\draenei-40",
		}
	elseif race == "Goblin" then
		self.data[4] = { -- 地精三轮摩托钥匙
			id = 62461,
			Title = "地精三轮摩托钥匙",
			Texture = [[Interface\Icons\inv_misc_key_03]],
			Link = "|cff0070dd|Hitem:62461:0:0:0:0:0:0:0:10:0:0|h[地精三轮摩托钥匙]|h|r",
			bgTitle = "【传说】",
			bgDescription = "地精科技出品，三轮构造增加了机械动力的平衡性能，全金属节点视觉给人一种永恒的感受，相对于价格高昴的双轮摩托，地精的此类产品无疑在性价比上更具市场竞争力。地精玩家在20级后即可购买这一坐骑。",
			getTitle = "【获取途径】",
			getDescript = "【奥格瑞玛】地图的最左下方，找NPC【卡尔·万金】购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\goblin-20",
		}
		self.data[8] = { -- 地精三轮摩托涡轮增压型
			id = 62462,
			Title = "地精三轮摩托涡轮增压型",
			Texture = [[Interface\Icons\inv_misc_key_04]],
			Link = "|cffa335ee|Hitem:62462:0:0:0:0:0:0:0:10:0:0|h[地精三轮摩托涡轮增压型]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是三轮摩托的升级版产品，也是再次通过精心设计的产品，它已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。地精玩家在40级后即可购买这一坐骑。",
			getTitle = "【获取途径】",
			getDescript = "【奥格瑞玛】地图的最左下方，找NPC【卡尔·万金】购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\goblin-40",
		}
	elseif race == "Troll" then
		self.data[4] = { -- 青色迅猛龙之哨
			id = 8591,
			Title = "青色迅猛龙之哨",
			Texture = [[Interface\Icons\Ability_Mount_Raptor]],
			Link = "|cff0070dd|Hitem:8591:0:0:0:0:0:0:0:10:0:0|h[青色迅猛龙之哨]|h|r",
			bgTitle = "【传说】",
			bgDescription = "迅猛龙又称为伶盗龙、速龙，在巨魔语中意为敏捷的盗贼，是一种蜥臀目兽脚亚目驰龙科恐龙，它们生活在艾泽拉斯各个版块之上，巨魔们驯化此类生物成为他们的坐骑，其敏捷的身手，强悍的暴发力，灵巧的双足奔跑能力使之成为坐骑种类中不可多得的极品。巨魔玩家在20级时即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在杜隆塔尔的【森金村】找【克萨尔迪】处学习骑术，『祖尼尔』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\troll-20",
		}
		self.data[8] = { -- 迅捷蓝色迅猛龙
			id = 18788,
			Title = "迅捷蓝色迅猛龙",
			Texture = [[Interface\Icons\Ability_Mount_Raptor]],
			Link = "|cffa335ee|Hitem:18788:0:0:0:0:0:0:0:10:0:0|h[迅捷蓝色迅猛龙]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是迅猛龙的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。巨魔玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在杜隆塔尔的【森金村】找【克萨尔迪】处学习骑术，『祖尼尔』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\troll-40",
		}
	elseif race == "Worgen" then
		self.data[4] = { -- 高山马
			id = 73838,
			Title = "高山马",
			Texture = [[Interface\Icons\Ability_Mount_RidingHorse]],
			Link = "|cff0070dd|Hitem:73838:0:0:0:0:0:0:0:10:0:0|h[高山马]|h|r",
			bgTitle = "【传说】",
			bgDescription = "高山马来自狼人的故乡吉尔尼斯，优秀及高贵的血统赋予它强健的体魄和坚韧的性格，马膝之下生有长长的白色粗毛，跑起来如奔腾于云雾之中。狼人玩家将在20级即可获得购买此马的权力。",
			getTitle = "【获取途径】",
			getDescript = "在【达纳苏斯】城内的风嚎橡树外找一位叫阿斯特丽德·长袜的小女孩购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\worgen-20",
		}
		self.data[8] = { -- 迅捷高山马
			id = 73839,
			Title = "迅捷高山马",
			Texture = [[Interface\Icons\Ability_Mount_RidingHorse]],
			Link = "|cffa335ee|Hitem:73839:0:0:0:0:0:0:0:10:0:0|h[迅捷高山马]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是高山马的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。狼人玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在【达纳苏斯】城内的风嚎橡树外找一位叫阿斯特丽德·长袜的小女孩购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\worgen-40",
		}
	elseif race == "Tauren" then
		self.data[4] = { -- 白色科多兽
			id = 46100,
			Title = "白色科多兽",
			Texture = [[Interface\Icons\Ability_Mount_Kodo_01]],
			Link = "|cff0070dd|Hitem:46100:0:0:0:0:0:0:0:10:0:0|h[白色科多兽]|h|r",
			bgTitle = "【传说】",
			bgDescription = "生活在卡利姆多平原上的巨大科多兽是牛头人部落极有价值的盟友，这种威力无穷的巨兽背着沉重的战鼓步入战场，作为牛头人力量和勇气的标志，也会利用它们无人能敌的硕大身躯和力量进行支援。科多兽比它们野生的同类更加迅捷，同时体型也稍小，但无论是在活力还是勇气方面都丝毫不逊于它们。牛头人玩家在升级至20级后便可以购买它们。",
			getTitle = "【获取途径】",
			getDescript = "在莫高雷的【血蹄村】找【卡尔·雷歌】学习骑术，『哈布·爪蹄』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\tauren-20",
		}
		self.data[8] = { -- 大型白色科多兽
			id = 18793,
			Title = "大型白色科多兽",
			Texture = [[Interface\Icons\Ability_Mount_Kodo_01]],
			Link = "|cffa335ee|Hitem:18793:0:0:0:0:0:0:0:10:0:0|h[大型白色科多兽]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是科多兽的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。牛头人玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在莫高雷的【血蹄村】找【卡尔·雷歌】学习骑术，『哈布·爪蹄』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\tauren-40",
		}
	elseif race == "Orc" then
		self.data[4] = { -- 恐狼号角
			id = 5665,
			Title = "恐狼号角",
			Texture = [[Interface\Icons\Ability_Mount_WhiteDireWolf]],
			Link = "|cff0070dd|Hitem:5665:0:0:0:0:0:0:0:10:0:0|h[恐狼号角]|h|r",
			bgTitle = "【传说】",
			bgDescription = "恐狼及森林狼是兽人部落专为作战驯养的战斗坐骑，它们略显矮小的身材，并不防碍他们的残暴与勇猛，森森的獠牙也足以让任何遇见它们的敌人胆寒心惊。兽人玩家在等级达到20级后，就可以购买这匹坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在奥格瑞玛的【荣誉谷】左上角木桩边上找【基尔达】学习骑术，『奥古纳罗』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\orc-20",
		}
		self.data[8] = { -- 迅捷森林狼号角
			id = 18797,
			Title = "迅捷森林狼号角",
			Texture = [[Interface\Icons\Ability_Mount_WhiteDireWolf]],
			Link = "|cffa335ee|Hitem:18797:0:0:0:0:0:0:0:10:0:0|h[迅捷森林狼号角]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是恐狼的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。兽人玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在奥格瑞玛的【荣誉谷】左上角木桩边上找【基尔达】学习骑术，『奥古纳罗』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\orc-40",
		}
	elseif race == "Scourge" then
		self.data[4] = { -- 蓝色骸骨军马
			id = 13332,
			Title = "蓝色骸骨军马",
			Texture = [[Interface\Icons\Ability_Mount_Undeadhorse]],
			Link = "|cff0070dd|Hitem:13332:0:0:0:0:0:0:0:10:0:0|h[蓝色骸骨军马]|h|r",
			bgTitle = "【传说】",
			bgDescription = "凄美的希尔瓦娜斯女王，黑暗的不死魂灵，森森的白骨迷宫，这里的亡灵大军育养着浪漫而又惊悚的骸骨战马，它呼吸逝者魂灵的气息，压抑着不死之族的信念，它所到之处，毕竟已寸草不生。亡灵玩家在20级后即可购得这匹战马。",
			getTitle = "【获取途径】",
			getDescript = "在幽暗城北部的【布瑞尔】找【维尔玛·瓦纳姆】学习骑术，『撒迦利亚·普斯特』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\scourge-20",
		}
		self.data[8] = { -- 紫色骷髅战马
			id = 18791,
			Title = "紫色骷髅战马",
			Texture = [[Interface\Icons\Ability_Mount_Undeadhorse]],
			Link = "|cffa335ee|Hitem:18791:0:0:0:0:0:0:0:10:0:0|h[紫色骷髅战马]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是骸骨军马的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。亡灵玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "在幽暗城北部的【布瑞尔】找【维尔玛·瓦纳姆】学习骑术，『撒迦利亚·普斯特』处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\scourge-40",
		}
	elseif race == "BloodElf" then
		self.data[4] = { -- 紫色陆行鸟
			id = 29222,
			Title = "紫色陆行鸟",
			Texture = [[Interface\Icons\Ability_Mount_CockatriceMount_Purple]],
			Link = "|cff0070dd|Hitem:29222:0:0:0:0:0:0:0:10:0:0|h[紫色陆行鸟]|h|r",
			bgTitle = "【传说】",
			bgDescription = "华美的陆行鸟坐骑来自于血精灵种族，受到永恒魔法的影响，这些艾泽拉斯平常的陆行鸟拥有了绚丽的羽毛和更加强健的体魄，而其脚踝上的碧玉镶金宝石也代表着其主人的奢华与高贵。血精灵玩家在20级后就可以购买此坐骑。",
			getTitle = "【获取途径】",
			getDescript = "银月城出门左手边，沿路的第一个房子【苏伦的养殖场】，找『佩拉斯卡米』学习骑术，【维奈丝拉特】处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\bloodelf-20",
		}
		self.data[8] = { -- 迅捷粉色陆行鸟
			id = 28936,
			Title = "迅捷粉色陆行鸟",
			Texture = [[Interface\Icons\Ability_Mount_CockatriceMountElite]],
			Link = "|cffa335ee|Hitem:28936:0:0:0:0:0:0:0:10:0:0|h[迅捷粉色陆行鸟]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是一般陆行鸟的升级版坐骑，绚丽的配饰及精致的外观也处处呈现出高端的品质，它是万里挑一的品种，它们已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。血精灵玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "银月城出门左手边，沿路的第一个房子【苏伦的养殖场】，找『佩拉斯卡米』学习骑术，【维奈丝拉特】处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\bloodelf-40",
		}
	elseif race == "Gnome" then
		self.data[4] = { -- 蓝色机械陆行鸟
			id = 8595,
			Title = "蓝色机械陆行鸟",
			Texture = [[Interface\Icons\Ability_Mount_MechaStrider]],
			Link = "|cff0070dd|Hitem:8595:0:0:0:0:0:0:0:10:0:0|h[蓝色机械陆行鸟]|h|r",
			bgTitle = "【传说】",
			bgDescription = "侏儒科技产品，相较于地精科技，此项产品更多的加入了动物工程学技术，仿真的陆行鸟模型使其拥有陆行鸟类的敏捷与迅速，全合金工艺更是增强了其护甲防护功能，然而作为机械，这种坐骑永远都不会疲惫。侏儒玩家在20级后就可以购买这个坐骑。",
			getTitle = "【获取途径】",
			getDescript = "铁炉堡出门顺路左转，在【卡拉诺斯】边上的【钢架补给站】找『宾吉·羽哨』处学习骑术，【米利·羽哨】处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\gnome-20",
		}
		self.data[8] = { -- 迅捷白色机械陆行鸟
			id = 18773,
			Title = "迅捷白色机械陆行鸟",
			Texture = [[Interface\Icons\Ability_Mount_MechaStrider]],
			Link = "|cffa335ee|Hitem:18773:0:0:0:0:0:0:0:10:0:0|h[迅捷白色机械陆行鸟]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是一般机械陆行鸟的升级版产品，也是再次通过精心设计的产品，它已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。侏儒玩家在40级后即可购买这个坐骑。",
			getTitle = "【获取途径】",
			getDescript = "铁炉堡出门顺路左转，在【卡拉诺斯】边上的【钢架补给站】找『宾吉·羽哨』处学习骑术，【米利·羽哨】处购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\gnome-40",
		}
	elseif race == "Pandaren" then
		self.data[4] = { -- 蓝色龙龟缰绳
			Id = 87796,
			Title = "蓝色龙龟缰绳",
			Texture = [[Interface\Icons\ABILITY_MOUNT_PANDARANMOUNTBLUE]],
			Link = "|cff0070dd|Hitem:87796:0:0:0:0:0:0:0:1:0:0|h[蓝色龙龟缰绳]|h|r",
			bgTitle = "【传说】",
			bgDescription = "龙龟是神秘的熊猫人古籍中记载的一种瑞兽，其头是龙，身为龟，称纯阳之神兽，亦是权力和长寿的象征，古云，“其神龙之子，负河图之书，揭天地之数，物一太极，上通天文，下知地理，中和人世。”熊猫人玩家在20级后就可以购买这个坐骑。",
			getTitle = "【获取途径】",
			getDescript = "【部落】熊猫人在奥格瑞玛的荣誉谷，找气球下方的『柔爪』购买坐骑。\n【联盟】熊猫人在暴风城的矮人区上方，找气球下方的『老白鼻』购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\pandaren-20",
		}
		self.data[8] = { -- 巨型蓝色龙龟缰绳
			Id = 87803,
			Title = "巨型蓝色龙龟缰绳",
			Texture = [[Interface\Icons\ABILITY_MOUNT_PANDARANMOUNTEPICBLUE]],
			Link = "|cffa335ee|Hitem:87803:0:0:0:0:0:0:0:1:0:0|h[巨型蓝色龙龟缰绳]|h|r",
			bgTitle = "【传说】",
			bgDescription = "绝对优异的乘骑体验，它是普通龙龟坐骑的升级版，绚丽的熊猫人配饰及威严的兽角都处处呈现着其神兽级别的品质，它的速度如风，已达到艾泽拉斯地面坐骑的最快速度，是任务升级，战场杀敌，游览旅行的必备座驾。熊猫人玩家在40级后即可购买这种坐骑。",
			getTitle = "【获取途径】",
			getDescript = "【部落】熊猫人在奥格瑞玛的荣誉谷，找气球下方的『柔爪』购买坐骑。\n【联盟】熊猫人在暴风城的矮人区上方，找气球下方的『老白鼻』购买坐骑。",
			bgPic = "Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Mount\\pandaren-40",
		}
	end

	for	i=1, 8, 1 do
		self["Icon"..i].data = self.data[i]
		self["Icon"..i].icon:SetTexture(self["Icon"..i].data.Texture)
		self["Icon"..i].link = self["Icon"..i].data.Link
	end

	NewbieAssistantPanelMountMiddleIconTemplate_OnClick(self.Icon4)
end