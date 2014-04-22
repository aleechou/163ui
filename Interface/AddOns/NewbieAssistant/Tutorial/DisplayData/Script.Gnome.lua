-- Author      : s1172
-- Create Date : 2013/5/23 18:18:01

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Gnome" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={
		["被压制"] =  function()--提示按L，完成任务时提示选择奖励
			ToolTip_Logic:ViewQuestLog()
			ToolTip_Logic:LootTip()
		end,
		["向卡沃·爆弹报告"] = function ()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 26760."))
		end,
		["照料幸存者"] = function()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Gnome use item quest"),86264)
		end,
		["撤到装载室！"] = function ()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("you can follow S.A.F.E Operator finish quest."))
		end,
		["净化处理"] = function()--提示装备物品
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 27635."))
		end,
		["到地面去"] = function()--提示使用道具，打开大地图
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 27674."))
		end,
		["诺莫瑞根的未来"] = ToolTip_Logic["WorldMapTip"],--提示打开大地图
		["晋见大工匠"] = function()--提示附近还有任务
			ToolTip_Logic:TakeMoreQuest()
		end,
		["战斗继续"] = function()--提示使用道具，打开大地图
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 26208."))
		end,
		["侏儒才智的胜利"] = function()--提示使用道具，打开大地图
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 26566."))
		end,
		["寻找零件"] = ToolTip_Logic["WorldMapTip"],--提示打开大地图
		["多功能机器人的工作"] = ToolTip_Logic["TakeMoreQuest"],
		["身后物"] = ToolTip_Logic["WorldMapTip"],--提示打开大地图
		["杰萨普怎么了？"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["把我的炸药还回来！"] = ToolTip_Logic["TakeMoreQuest"],
		["失踪的士兵"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 26284."))
		end,
		["致命一击"] = function()
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:SelectQuestReward(26318)
		end,
		["还有一件事"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["碎轮的爪牙"] = ToolTip_Logic["TakeMoreQuest"],
		["没坦克！"] = function()
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Gnome use item quest2"),79751)
			ToolTip_Logic:SelectQuestReward(26333)
		end,--打开地图
		["烈酒村的准备"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["涂成黑色"] = function()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Gnome use item quest3"),79781)
		end,--打开地图
		["碎轮的倒台！"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 26364."))
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Gnome use item quest4"),80101)
			ToolTip_Logic:SelectQuestReward(26364)
		end,
		["前往卡拉诺斯"] = function ()
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:GoHotel(26380)
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={
		[Race]={
			["FirstQuestTargetId"] = 46391,--癫狂的麻疯侏儒
			["targetPic"] = {
				["碎轮的倒台！"] = "26364",
				["涂成黑色"] = "26342",
				["碎轮到爪"] = "26331",
				["没坦克!"] = "26333",
				["致命一击"] = "26318",
				["失踪的士兵"] = "26284",
				["把我的炸药还回来！"] = "26285",
				["处理辐射"] = "26265",
				["身后物"] = "26264",
				["多功能机器人的工作"] = "26205",
				["寻找零件"] = "26222",
				["净化处理"] = "27635",
				["照料幸存者"] = "27671",
				["被压制"] = "27670",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=27670,
				-- [被压制]
				["27670"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["被压制"],
				-- [向卡沃·爆弹报告]
				["26760"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向卡沃·爆弹报告"],
				-- [照料幸存者]
				["27671"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照料幸存者"],
				-- [撤到装载室！]
				["28169"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["撤到装载室！"],
				-- [净化处理]
				["27635"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["净化处理"],
				-- [到地面去]
				["27674"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["到地面去"],
				-- [诺莫瑞根的未来]
				["26203"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["诺莫瑞根的未来"],
				-- [晋见大工匠]
				["26425"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["晋见大工匠"],
				-- [战斗继续]
				["26208"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["战斗继续"],
				-- [侏儒才智的胜利]
				["26566"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["侏儒才智的胜利"],
				-- [寻找零件]
				["26222"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["寻找零件"],
				-- [多功能机器人的工作]
				["26205"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["多功能机器人的工作"],
				-- [身后物]
				["26264"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["身后物"],
				-- [杰萨普怎么了？]
				["26316"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["杰萨普怎么了？"],
				-- [把我的炸药还回来！]
				["26285"] = NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["把我的炸药还回来！"],
				-- [失踪的士兵]
				["26284"] = NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["失踪的士兵"],
				-- [致命一击]
				["26318"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["致命一击"],
				-- [还有一件事]
				["26329"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["还有一件事"],
				-- [碎轮的爪牙]
				["26331"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["碎轮的爪牙"],
				-- [没坦克！]
				["26333"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["没坦克！"],
				-- [烈酒村的准备]
				["26339"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["烈酒村的准备"],
				-- [涂成黑色]
				["26342"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["涂成黑色"],
				-- [碎轮的倒台！]
				["26364"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["碎轮的倒台！"],
				-- [前往卡拉诺斯]
				["26380"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["前往卡拉诺斯"],
			},
		}
	}
end