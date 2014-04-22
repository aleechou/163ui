-- Author      : S0493
-- Create Date : 2013/5/20 16:05:39

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "BloodElf" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={		
		["夺回逐日岛"] =  function()--提示按L,任务完成后选择奖励
			ToolTip_Logic:ViewQuestLog()
			ToolTip_Logic:SelectQuestReward(8325)
			ToolTip_Logic:LootTip()
		end,
		["令人遗憾的措施"] =  function()--提示看地图,任务完成后选择奖励,装备上个任务获取的装备
			ToolTip_Logic:BackpackTip()
			ToolTip_Logic:PickupItemQuest(15366) --"魔泉山猫幼崽"
		end,
		["向兰萨恩·派雷隆报到"] =  function()--提示附近有其他任务可以接,查看地图
			ToolTip_Logic:TakeMoreQuest()
		end,
		["放逐者菲伦德雷"] =  function()--提示任务位置
			ToolTip_Logic:InCastleQuest("这个任务需要沿着旋梯到达建筑物的上层。")
		end,
		["帮助信使"] =  function()--离开新手村
			ToolTip_Logic:LeaveBirthplace()
		end,
		["送信"] =  function()--进旅馆
			ToolTip_Logic:GoHotel(8350)
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA = {		
		[Race] = {
			["FirstQuestTargetId"] = 15274,--"法力浮龙",
			["targetPic"] = {
				["夺回逐日岛"] = "8325",
				["令人遗憾的措施"] = "8326",
				["索兰尼亚的物品"] = "8330",
				["攻势"] = "8334",
				["放逐者菲伦德雷"] = "8335",
				["奥术薄片"] = "8336",
				["达斯雷玛的神龛"] = "8345",
				["无尽的渴求"] = "8346",
				["失心者的牺牲品"] = "9704",
			},
		}
	}

	if Class == "WARRIOR" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class] = {
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 帮助信使
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "HUNTER" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "ROGUE" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "PRIEST" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "MAGE" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "WARLOCK" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "MONK" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	elseif Class == "PALADIN" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=8325,
			-- 从墓穴中醒来
			["8325"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["夺回逐日岛"],
			-- 令人遗憾的措施
			["8326"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["令人遗憾的措施"],
			-- 清扫战场
			["8327"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["向兰萨恩·派雷隆报到"],
			-- 放逐者菲伦德雷
			["8335"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["放逐者菲伦德雷"],
			-- 重要情报
			["8347"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["帮助信使"],
			--送信
			["8350"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["送信"]
		}
	end
end