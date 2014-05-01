-- Author      : S0493
-- Create Date : 2013/5/20 16:11:55

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Goblin" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={		
		["照看生意"] =  function()--提示按L
			ToolTip_Logic:ViewQuestLog()
		end,
		["矿井的麻烦事"] =  function()--提示选择装备
			ToolTip_Logic:SelectQuestReward(14075)
			ToolTip_Logic:LootTip()
		end,
		["卡亚可乐"] =  function()--提示装备任务奖励的装备
			ToolTip_Logic:BackpackTip()
		end,
		["呼朋唤友"] =  function()--提示使用物品
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Goblin use item quest"),66393)
		end,
		["参加预选赛"] =  function()--提示查看地图
			ToolTip_Logic:WorldMapTip()
		end,
		["热力追踪"] =  function()--提示拾取任务物品
			ToolTip_Logic:PickupItemQuest(35234) --受雇的抢掠者
		end,
		["毕生积蓄"] =  function()--结束新手提示
			ToolTip_Logic:LeaveBirthplace()
		end,
	}
	
	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={		
		[Race]={
			["FirstQuestTargetId"] = 34865,
			["targetPic"] = {
				["好帮手很难找"] = "14069",
				["亲自动手"] = "14070",
				["呼朋唤友"] = "14071",
				["矿井的麻烦事"] = "14075",
				["崭新的你"] = "14109",
				["聚会生活"] = "14113",
				["捣乱的海盗"] = "14115",
				["热力追踪"] = "14121",
				["紧急措施"] = "14122",
				["别墅漫步"] = "14123",
				["搜刮卡亚矿石"] = "14124",
				["447"] = "14125",
				["替代品"] = "24488",
				["必要的粗暴"] = "24502",
			},
		}
	}

	if Class == "WARRIOR" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	elseif Class == "HUNTER" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	elseif Class == "PRIEST" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	elseif Class == "SHAMAN" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	elseif Class == "MAGE" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	elseif Class == "WARLOCK" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	elseif Class == "ROGUE" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=14138,
			-- 从墓穴中醒来
			["14138"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["照看生意"],
			-- 矿井的麻烦事
			["14075"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矿井的麻烦事"],
			-- 不可拯救的死者
			["25473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["卡亚可乐"],
			-- 清扫战场
			["14071"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["呼朋唤友"],
			-- 被诅咒者
			["24521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["参加预选赛"], 
			-- 热力追踪
			["14121"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["热力追踪"],
			-- 毕生积蓄
			["14126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["毕生积蓄"],
		}
	end
end