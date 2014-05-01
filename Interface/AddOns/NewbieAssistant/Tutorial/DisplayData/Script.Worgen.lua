-- Author      : S0493
-- Create Date : 2013/5/24 11:18:53

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Worgen" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={		
		["戒严！"] =  function()--提示按L
			ToolTip_Logic:ViewQuestLog()
		end,
		["事有蹊跷"] = ToolTip_Logic["WorldMapTip"],
		["天下大乱"] = function()
			ToolTip_Logic:TakeMoreQuest()
			ToolTip_Logic:LootTip()
		end,
		["抢救补给品"] = ToolTip_Logic["WorldMapTip"],
		["皇家命令"] = ToolTip_Logic["BackpackTip"],
		["职业任务"] = ToolTip_Logic["WorldMapTip"],
		["人多安全"] = ToolTip_Logic["WorldMapTip"],
		["旧日的分歧"] = ToolTip_Logic["TakeMoreQuest"],
		["顺路除害"] =  function()--提示选择任务奖励
			ToolTip_Logic:SelectQuestReward(24930)
			ToolTip_Logic["WorldMapTip"]()
		end,
		["监狱的屋顶"] =  function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 28850."))
		end,
		["命悬一线"] =  function()--提示选择任务奖励
			ToolTip_Logic:SelectQuestReward(14154)
		end,
		["兄弟情深"] = ToolTip_Logic["BackpackTip"],
		["叛军领主的军械库"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 14159."))
		end,
		["来自阴影"] =  function()--提示选择任务奖励
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Worgen use item quest"),67807)
			ToolTip_Logic:SelectQuestReward(14204)
		end,
		["给格雷迈恩的消息"] =  ToolTip_Logic["BackpackTip"],
		["救援克雷南·阿朗纳斯"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 14293."))
		end,
		["重整旗鼓"] = ToolTip_Logic["WorldMapTip"],
		["牺牲"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 14212."))
		end,
		["以鲜血与灰烬之名"] = function()
			ToolTip_Logic:SelectQuestReward(14218)
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 14218."))
		end,
		["恢复人性"] =  function()--离开新手村
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:GoHotel(14313)
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={		
		[Race]={
			["FirstQuestTargetId"] = 34884,--暴怒的狼人
			["targetPic"] = {
				["天下大乱"] = "14093",
				["抢救补给品"] = "14094",
				["疏散商人广场"] = "14098",
				["命悬一线"] = "14154",
				["来自阴影"] = "14204",
				["牺牲"] = "14212",
				["以鲜血与灰烬之名"] = "14218",
				["破釜沉舟"] = "14222",
				["救援克雷南·阿朗纳斯"] = "14293",
				["顺路除害"] = "24930",
			},
			[Class]={
				-- 第一个任务ID
				["FirstQuestId"]=14078,
				-- 戒严！
				["14078"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["戒严！"],
				-- [事有蹊跷]
				["14091"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["事有蹊跷"],
				-- 天下大乱
				["14093"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["天下大乱"],
				-- [抢救补给品]
				["14094"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["抢救补给品"],
				-- 皇家命令
				["14099"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["皇家命令"],

				-- [冲锋]
				["14266"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],
				-- [稳固射击]
				["14099"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],
				-- [刺骨]
				["14272"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],
				-- [学习暗言术]
				["14279"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],
				-- [冰霜新星]
				["14281"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],
				-- [腐蚀术]
				["14274"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],
				-- [月火术]
				["14283"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["职业任务"],

				-- [人多安全]
				["14290"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["人多安全"],
				-- [旧日的分歧]
				["14157"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["旧日的分歧"],
				-- 顺路除害
				["24930"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["顺路除害"],
				-- [监狱的屋顶]
				["28850"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["监狱的屋顶"],
				-- 命悬一线
				["14154"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["命悬一线"],
				-- [兄弟情深]
				["26129"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["兄弟情深"],
				-- [叛军领主的军械库]
				["14159"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["叛军领主的军械库"],
				-- 来自阴影
				["14204"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["来自阴影"],
				-- 给格雷迈恩的消息
				["14214"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["给格雷迈恩的消息"],
				-- [救援克雷南·阿朗纳斯]
				["14293"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["救援克雷南·阿朗纳斯"],
				-- [重整旗鼓]
				["14294"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["重整旗鼓"],
				-- [牺牲]
				["14212"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["牺牲"],
				-- [以鲜血与灰烬之名]
				["14218"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["以鲜血与灰烬之名"],
				-- [恢复 人性]
				["14313"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["恢复人性"],
			},
		}
	}
end