-- Author      : s1172
-- Create Date : 2013/3/26 13:30:26

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "NightElf" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={
		["自然的平衡"] = function()
			ToolTip_Logic:ViewQuestLog()--按L
			ToolTip_Logic:SelectQuestReward(28713)--挑选多任务奖励
			ToolTip_Logic:LootTip()
		end,--提示按l
		["腐化的魔苔"] = function()
			ToolTip_Logic:SelectQuestReward(28714)--挑选多任务奖励
			ToolTip_Logic:TakeMoreQuest()--附近还有任务
		end,--提示按b
		["恶魔窃贼"] = function()
			ToolTip_Logic:BackpackTip()--按B
		end,
		["简易符记"] = function(str)
			ToolTip_Logic:InCastleQuest(str)--提示任务NPC位置
			ToolTip_Logic:ClickGossip()--交任务时提示按黄色问号
		end,
		["月神女祭司"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["埃沃隆的解药"] = function()
			ToolTip_Logic:SelectQuestReward(28724)--挑选多任务奖励
		end,
		["森林守护者"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 28725."))--提示任务位置
		end,
		["树林蜘蛛的腐蚀"] = function()
			TutorialSmallMsgFrame_Hide(-1)--隐藏现有提示框
			ToolTip_Logic:SelectQuestReward(28726)--挑选多任务奖励
		end,--提示看地图
		["邪恶的触摸"] = function()
			ToolTip_Logic:SelectQuestReward(28727)--挑选多任务奖励
		end,--提示看地图
		["泰达希尔：艾泽拉斯之冠"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 28729."))--提示任务NPC位置
		end,
		["珍贵的水"] = function()
			ToolTip_Logic:SelectQuestReward(28730)--挑选多任务奖励
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 28730."))--提示任务NPC位置
		end,
		["泰达希尔：传递信息"] = ToolTip_Logic["LeaveBirthplace"],
		["多兰纳尔的货物"] = function()
			TutorialSmallMsgFrame_Hide(-1)--隐藏现有提示框
			ToolTip_Logic:GoHotel(2159)-- 交任务后提示绑定炉石
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={
		[Race]={
			["FirstQuestTargetId"] = 2031,--夜刃豹幼崽
			["targetPic"] = {
				["自然的平衡"] = "28713",
				["腐化的魔苔"] = "28714",
				["恶魔窃贼"] = "28715",
				["埃沃隆冬解药"] = "28724",
				["树林蜘蛛的腐蚀"] = "28726",
				["邪恶的触摸"] = "28727",
				["泰达希尔：艾泽拉斯之冠"] = "28729",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=28713,
				-- [自然的平衡]
				["28713"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["自然的平衡"],
				-- [腐化的魔苔]
				["28714"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["腐化的魔苔"],
				-- [恶魔窃贼]
				["28715"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["恶魔窃贼"],
				-- [简易符记]
				["3116"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3116."))
				end,
				["3117"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3116."))
				end,
				["3118"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3116."))
				end,
				["3119"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3119."))
				end,
				["26841"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3119."))
				end,
				["31168"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3116."))
				end,
				["3120"]=function()
					NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["简易符记"](TutorialApi:Localize("quest 3116."))
				end,
				-- [月神女祭司]
				["28723"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["月神女祭司"],
				-- [埃沃隆的解药]
				["28724"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["埃沃隆的解药"],
				-- [森林守护者]
				["28725"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["森林守护者"],
				-- [树林蜘蛛的腐蚀]
				["28726"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["树林蜘蛛的腐蚀"],
				-- [邪恶的触摸]
				["28727"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["邪恶的触摸"],
				-- [泰达希尔：艾泽拉斯之冠]
				["28729"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["泰达希尔：艾泽拉斯之冠"],
				-- [珍贵的水]
				["28730"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["珍贵的水"],
				-- [泰达希尔：传递信息]
				["28731"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["泰达希尔：传递信息"],
				-- [多兰纳尔的货物]
				["2159"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["多兰纳尔的货物"],
			},
		}
	}
end