-- Author      : s1172
-- Create Date : 2013/2/25 11:22:20

local L = TutorialApi.Localization

if GetLocale() == "zhCN" then
	L["Quest Complete."] = "恭喜您任务完成，可以按|cffff0000M|r找|TInterface\\AddOns\\NewbieAssistant\\Media\\Textures\\Icons\\TurnIn:32:32|t交任务。"
	L["LeftClick this button, accpet quest."] = "点这里接任务"
	L["LeftClick this button, complete quest."] = "点这里完成任务"
	L["This is you`re equipment Item"] = "这是您穿上的装备"
	L["LeftClick this button close paper doll window."] = "点这里关闭角色框"
	L["This is Minimap."] = "这里是小地图，|TInterface\\WorldMap\\WorldMapArrow:28:28|t表示角色面对的方向，|TInterface\\MINIMAP\\Minimap-QuestArrow:28:28|t表示任务所在方向。"
	L["Press B to open Bag"] = "请按|cffff0000B|r键打开屏幕右下方的背包。"
	L["Right-click to equip the item"] = "鼠标右键单击装备图标可自动穿上"
	L["Press C to open Character Paperdoll window"] = "按|cffff0000C|r键查看角色信息"
	L["Press M to open world map."] = "您可以按|cffff0000M|r键打开大地图查看任务区域。"
	L["Right-click the monster`s body to pickup items"] = {
		title = "战斗胜利",
		content = "您可以用鼠标右键点击[发光]的怪物尸体，拾取其中的物品。",
	}
	L["Low hp."] = "|cffffff00警告：您的生命值过低，请注意自保。|r"
	L["You can talk with Npc to bind stone"] = {
		title = "绑定炉石",
		content = "您可以和旁边的NPC旅店老板对话，绑定炉石哦。",
	}
	L["You can use stone"] = "您可以使用背包中的“炉石”快速返回出生地。"
	L["Left-click the world map will inzoom/ourzoom"] = "点这里缩小地图"
	L["This area is the quest aim."] = "|cff2982fc蓝色|r区域为任务怪所在。|TInterface\\AddOns\\NewbieAssistant\\Media\\Textures\\Icons\\TurnIn:14:14|t为交任务的位置。点|cffffff00黄色|r数字查看任务怪。\n|TInterface\\AddOns\\NewbieAssistant\\Media\\Textures\\circle:7:7|t引导您到达任务区域。|TInterface\\WorldMap\\WorldMapArrow:14:14|t为您的角色面对的方向。"
	L["This arrow will guild you to quest area."] = "这个箭头将引导您前往任务怪。"
	L["Follow the pink line."] = "跟随|TInterface\\AddOns\\NewbieAssistant\\Media\\Textures\\circle:7:7|t抵达任务目的地"
	
	L["This is action bar."] = "技能条\n可使用快捷键（1、2、3等）触发对应技能"
	L["Different between Red with Yellow health bar."] = "正面面对怪物使用技能条就可以发动攻击啦。"

	L["Left-click this close quest log."] = "点这关闭任务日志"
	L["This is the Prospective content."] = "这里是前瞻内容面板，您可以在这里查看各类游戏内容的介绍，点击△开/关面板"

	L["Press P to open Character Skill window"] = "恭喜您学会了新技能，可以按P键查看法术书和技能。"
	L["spellbook Tutorial"] = "点击这里开启/关闭本窗口的帮助系统。"
	L["Talk to NPC bind hearthstone"] = "与旅馆老板对话可以将炉石绑定在这里。"
	L["This is your HP and MP"] = "角色生命值与职业能力值"
	L["This quest is in the castle."] = "这个任务在建筑内。"
	L["Two Quest."] = "任务[黑石兽人的入侵]需要您击杀怪物后拾取尸体内的任务道具\n任务[灭火拯救希望]您可以在任务地点看到地上的火焰，对着火焰使用任务名称旁的道具即可。"
	L["Tip:You can press Num Lock start AutoRun."] = "小提示：您可以按小键盘上的Num Lock键自动前进。"
	L["you can take more than one quests at one time."] = "附近还有任务，可一同领取并完成噢！"
	L["quest reward select"] = "许多任务会有多种奖励可供选择其一，若装备显示|cffff0000红色|r,表示此装备您|cffff0000无法使用|r。您可根据自己需要进行选择。"
	L["You can Left-click this button release soul."] = "您的角色死亡了，可以点击这个按钮释放灵魂。"
	L["This arrow will guild you to your character corpse."] = "您可以跟着箭头方向找到角色尸体进行复活。"
	L["Left-click this button will resurrect."] = "点击接受您的角色就可以复活了，请注意附近怪物噢。"
	L["press m find body`s pos."] = "您可以按M打开地图查看尸体（咖啡色矩形）位置，复活角色。"
	L["Right-click the NPC that you can accept quest."] = "请点击|cffffff00黄色叹号（！）|r接取任务"
	L["Left-click this can hide this frame."] = "您可以左键点击这里关闭介绍框。"
	L["Left-click here to complete quest."] = "点击这里的|cffffff00黄色|r问号交任务。"
	-- callby ToolTip_Logic:ViewQuestLog()
	L["Press L to open quest list."] = "您可以点击 L 键打开任务列表。"
	L["Left-click this button can track quest or not."] = "追踪或停止追踪目标任务"
	L["This is the quest track window."] = "目标任务进度提示"
	
	-- TutorialMiniFrame_Show 标题
	L["Bind Hearthstone Title"] = "绑定炉石"
	L["Use Hearthstone Title"] = "使用炉石"
	L["New Area Title"] = "发现新区域"
	L["Player Dead Title"] = "复活角色"
	L["More Quests Title"] = "发现多个任务"
	L["Start Quest Title"] = "领取任务"
	L["HP bar color Title"] = "怪物说明"
	L["Backpack Full Title"] = "您的包包满啦～"
	L["Open Quest Title"] = "查看任务"
	L["Open Map Title"] = "查看地图"
	L["Quest Complete Title"] = "任务完成"
	L["Equip Item Title"] = "穿装备"
	L["Finish Quest Title"] = "完成任务"
	L["Pickup Quest Item Title"] = "拾取任务道具"

	-- 新区域提示
	L["NEW_AREA_MSG"] = {
		["Human"] = "发现：闪金镇",
	}
	L["NEW_AREA_MSG_CONTENT"] = {
		["Human"] = "欢迎来到闪金镇，如在NPC头顶看到灰色叹号，说明您的级别略低，请继续努力！",
	}

	-- 飞行管理员用法
	L["How to use the Taxi Npc."] = "|cff00ff00绿色|r图标是您的人物目前所在的地方，您可以点击|cffd7d2cb灰色|r图标飞往该目的地。"

	-- 键盘用法
	L["You can follow the arrow to move your character."] = [[
您可根据图示使用键盘移动角色。
%s：前进   %s：后退
%s：左平移 %s：右平移
%s：左转身 %s：右转身
	]]
	
	-- 鼠标用法
	L["follow the picture."] = "跟我一起按"

	L["Right-click the monster`s body to pickup quest item."] = "请右键点击怪物尸体，拾取任务道具。"
	L["Use Quest Item"] = "对准任务区域地面上的火苗使用任务道具"
	L["Use Quest Item Dwarf"] = "对受伤的寒脊巡山人使用该道具"
	L["Don`t move when you casting channeling magic."] = "使用道具时请不要移动，会打断噢！"
	L["Your backpack is full."] = "您的背包满了，可以找附近的商人清理一下背包。"
	L["Left-click this close world map."] = "点这儿关闭地图。"
	L["This arrow will guild you to complete quest."] = "您可以跟随箭头方向找NPC交任务。"
	L["You can go here to complete quest."] = "请至|TInterface\\AddOns\\NewbieAssistant\\Media\\Textures\\Icons\\TurnIn:20:20|t地点，完成任务并获取奖励"
	L["You can follow the direction of the arrow to leave the place of birth, has taken the first step in exploring Azeroth!"] = "您可以跟随箭头方向离开出生地，迈出探索艾泽拉斯大陆的第一步！"
	-- 鼠标作用
	L["Left-button useable."] = "|cffff0000左键单击|r可选中玩家、NPC或怪物"
	L["Right-button useable."] = "|cffff0000右键单击|r可与目标互动（对话、攻击）"
	L["Up-Wheel useable."] = "|cffff0000滚轮向上滚动|r：拉近镜头"
	L["Down-Wheel useable."] = "|cffff0000滚轮向下滚动|r：拉远镜头"

	-- 矮人
	L["Dwarf use item quest"] = "选中受伤的寒脊巡山人使用该道具完成任务"
	-- 侏儒
	L["quest 26760."] = "可以到门外找NPC完成任务"
	L["Gnome use item quest"] = "选中幸存者使用该道具完成任务"
	L["you can follow S.A.F.E Operator finish quest."] = "您可以跟随NPC“S.A.F.E操作员”完成任务"
	L["quest 27635."] = "您可以在旁边的装载室内搭乘“净化者500型”完成任务"
	L["quest 27674."] = "您可以在搭乘旁边的电梯上楼完成任务"
	L["quest 26208."] = "您可以聆听NPC“大工匠梅卡托克”介绍诺莫瑞根行动"
	L["quest 26566."] = "您可以沿着NPC“大工匠梅卡托克”背后小路完成任务"
	L["quest 26284."] = "您可以右键点击附近的“临时牢笼”营救爆破师完成任务"
	L["quest 26364."] = "可以到“涌冰湖”中心找NPC“大工匠梅卡托克”激活战斗完成任务"
	L["Gnome use item quest2"] = "您可以选中“修复的步行坦克”使用炸弹完成任务"
	L["Gnome use item quest3"] = "您可以选中“碎轮哨戒机器人”使用道具完成任务"
	L["Gnome use item quest4"] = "您可以在战斗中使用该道具攻击目标"
	L["Orc use item quest"] = "选中懒惰的苦工使用该道具完成任务"
	-- 牛头人
	L["Tauren use item quest"] = "走到食槽附近面对食槽使用该道具完成任务"
	L["Quest 24861."] = "在原地使用水罐献上祭品"
	L["Quest 24215."] = "在原地使用视像之水召唤雄鹰"
	-- 巨魔
	L["Troll use item quest"] = "在丢失的血爪幼崽旁边使用血爪之哨解救它"
	L["Quest 24626."] = "跟着迅爪在它旁边使用套索捉住它"
	L["Goblin use item quest"] = "使用这把钥匙，临时拥有一辆豪车。"
	L["Worgen use item quest"]="使用 [吉尔尼斯巨犬项圈] 召唤/收回巨犬。"
	-- 狼人
	L["quest 28850."] = "顺着楼梯上去完成任务"
	L["quest 14159."] = "在任务提示附近的地窖内完成任务"
	L["quest 14293."] = "小马奔跑的路上选中树上的NPC并按1营救"
	L["quest 14212."] = "骑乘旁边的小马，按1击杀小怪完成任务"
	L["quest 14218."] = "使用附近的大炮击杀血牙猎手"
	-- 熊猫人
	L["quest 30041."] = "点击屏幕右侧的|TInterface\\Addons\\NewbieAssistant\\Media\\Textures\\Icons\\Autoquest:16:16:2:0|t领取任务"
	L["quest 29406."] = "您可以攻击下方习武场的沙袋完成任务"
	L["quest 29408."] = "点击“尚喜师父”头顶的闪光，拿到火焰后从旁边的楼梯上楼烧毁“戒酒令”"
	L["quest 29523."] = "您可以在“藏风石”附近点击“风之石”完成任务"
	L["quest 29664."] = "可以点击旁边的“火盆”完成任务"
	L["quest 29422."] = "在楼梯上面的“燧焰”旁边使用“燧焰的祭品”完成任务"
	L["quest 29663."] = "可以在左面水池的岸边点击“梅花桩”完成任务"
	L["quest 29678."] = "可以从东北方水池中的石块上传送到“倒影之池”使用“炎阳珠”完成任务"
	L["quest 29679."] = "站在“涓流”释放的水流喷涌中完成任务"
	L["quest 29775."] = "可以搭乘旁边的“牛车”抵达任务地点"
	L["quest 29784."] = "可以沿着旁边的绳子到湖中完成任务"
	L["quest 29786."] = "可以到风语厅外使用“焰火”击杀“炤壬”完成任务"
	L["quest 30767."] = "跟紧NPC完成任务"
	L["quest 31450."] = "将进行阵营选择，准备好可以和“尚喜师父的灵魂”对话"
	-- 暗夜
	L["quest 28725."] = "您可以在黑丝洞内完成该任务"
	L["quest 28729."] = "您可以在黑丝洞右边小路上找到月亮井完成任务"
	L["quest 28730."] = "您可以在奥达希尔西侧找到楼梯到最顶层完成任务"
	L["quest 3116."] = "您可以在前方建筑内完成该任务，一层。"
	L["quest 3119."] = "您可以在前方建筑内完成该任务，二层。"
	-- 人类
	L["quest 3103."] = "这个任务在城堡内，进入后左手边第二个屋子内，一层。"
	L["quest 3100."] = "这个任务在城堡内，进入后右手边第二个屋子内。"
	L["quest 3101."] = "这个任务在城堡内，进入后右手边第二个屋子内。"
	L["quest 26910."] = "这个任务在城堡外侧，正对城门右手边。"
	L["quest 3102."] = "这个任务在城堡外侧，城堡右上角。"
	L["quest 3104."] = "这个任务在城堡内，进入后左手边第二个屋子内，二层。"
	L["quest 3105."] = "这个任务在城堡外侧，城堡右下角。"
	L["quest 31141."] = "这个任务在城堡内，进入后右手边第二个屋子内。"
	-- 亡灵
	L["quest 28608."] = "这个任务在任务NPC身后的墓穴中。"
	L["quest 24972."] = "恭喜您完成丧钟镇的任务，您可以顺着大路离开。"
	--德莱尼
	L["Quest 9303."] = "对枭兽使用道具，使用过程中切勿移动"

	-- 隐藏
	L["DisableAddon"] = "是否启用新兵助手？"
	L["DisableAddonTip"] = "开启/禁用新兵助手"
	L["DisableAddonTip1"] = "禁用后本角色下次登录时将自动关闭插件，"
	L["DisableAddonTip2"] = "如果需要可以在角色选择画面重新开启。"
	L["CopyNewbieAssistantFeedbackUrl"] = "感谢您使用魔兽世界新兵助手，您可以点击 Ctrl + C 复制以下链接地址在网页中打开调查表"
	L["Feed back url"] = "http://survey2.163.com/html/addon/paper.html"

end

