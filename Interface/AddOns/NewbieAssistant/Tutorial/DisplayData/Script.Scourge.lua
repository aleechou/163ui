-- Author      : s0493
-- Create Date : 2013/5/17 17:06:09

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Scourge" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={		
		["从墓穴中醒来"] =  function()--提示按L
			ToolTip_Logic:ViewQuestLog()
		end,
		["灰影墓穴"] =  function()--提示任务在房子里
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 28608."))
		end,
		["不可拯救的死者"] =  function()--提示看地图,任务完成后选择奖励
			ToolTip_Logic:TakeMoreQuest()
			ToolTip_Logic:SelectQuestReward(26799)
			ToolTip_Logic:LootTip()
		end,
		["走出墓穴"] = ToolTip_Logic["WorldMapTip"],
		["清扫战场"] =  function()--提示附近有其他任务可以接
			ToolTip_Logic:TakeMoreQuest()
			ToolTip_Logic:SelectQuestReward(26800)
		end,
		["境内的天灾"] = ToolTip_Logic["WorldMapTip"],
		["墓中的真相"] = ToolTip_Logic["BackpackTip"],
		["战场上的执行官"] = ToolTip_Logic["WorldMapTip"],
		["被诅咒者"] =  function()--提示拾取任务物品
			ToolTip_Logic:PickupItemQuest(1512) --夜行蝙蝠
			ToolTip_Logic:PickupItemQuest(1508) --食腐狼幼崽
			ToolTip_Logic:SelectQuestReward(26802)
			ToolTip_Logic:WorldMapTip()
		end,
		["夜行蜘蛛洞穴"] = function()
			ToolTip_Logic:SelectQuestReward(24973)
			ToolTip_Logic:BackpackTip()
		end,
		["跟僵尸一样烂"] = function()
			ToolTip_Logic:SelectQuestReward(24970)
			ToolTip_Logic:BackpackTip()
		end,
		["袭击腐脑营地"] = function()
			ToolTip_Logic:SelectQuestReward(24971)
			ToolTip_Logic:BackpackTip()
		end,
		["重要情报"] =  function()--提示
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 24972."))
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={		
		[Race]={
			["FirstQuestTargetId"] = 1501,--"无脑的僵尸",
			["targetPic"] = {
				["苏醒"] = "24960",
				["墓中的真相"] = "24961",
				["袭击腐脑营地"] = "24971",
				["夜行蜘蛛洞穴"] = "24973",
				["不可拯救的死者"] = "26799",
				["清扫战场"] = "26800",
				["境内的天灾"] = "26801",
				["被诅咒者"] = "26802",
				["灰影墓穴"] = "28608",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=24959,
				-- 从墓穴中醒来
				["24959"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["从墓穴中醒来"],
				-- 灰影墓穴
				["28608"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灰影墓穴"],
				-- 不可拯救的死者
				["26799"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["不可拯救的死者"],
				-- [走出墓穴]
				["25089"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["走出墓穴"],
				-- 清扫战场
				["26800"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["清扫战场"],
				-- [境内的天灾]
				["26801"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["境内的天灾"],
				-- [墓中的真相]
				["24961"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["墓中的真相"],
				-- [战场上的执行官]
				["28672"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["战场上的执行官"],
				-- 被诅咒者
				["26802"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["被诅咒者"],
				-- [夜行蜘蛛洞穴]
				["24973"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夜行蜘蛛洞穴"],
				-- [跟僵尸一样烂]
				["24970"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["跟僵尸一样烂"],
				-- [袭击腐脑营地]
				["24971"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["袭击腐脑营地"],
				-- 重要情报
				["24972"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["重要情报"],
			},
		}
	}
end