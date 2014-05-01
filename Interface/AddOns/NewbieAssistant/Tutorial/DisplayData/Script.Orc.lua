-- Author      : s0493
-- Create Date : 2013/5/16 15:23:59

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Orc" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC = {		
		["你的位置"] =  ToolTip_Logic["ViewQuestLog"],
		["小试身手"] = function()--提示查看地图,完成任务时选择奖励,
			ToolTip_Logic:SelectQuestReward(25126)
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:LootTip()
		end,
		["家园里的入侵者"] = function()--提示装备物品
			ToolTip_Logic:SelectQuestReward(25172)
			ToolTip_Logic:TakeMoreQuest()
		end,
		["戈加尔的清凉果"] = ToolTip_Logic["BackpackTip"],
		["工蝎的尾巴"] = function()--提示拾取物品
			ToolTip_Logic:PickupItemQuest(3124) --蝎子
			ToolTip_Logic:SelectQuestReward(25127)
		end,
		["哈纳祖"] = ToolTip_Logic["WorldMapTip"],
		["懒惰的苦工"] = function()--提示使用道具，打开大地图
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Orc use item quest"),19938)
			ToolTip_Logic:WorldMapTip()
		end,
		["邪灵劣魔"] = function()
			ToolTip_Logic:SelectQuestReward(25131)
			ToolTip_Logic:TakeMoreQuest()
		end,
		["火刃奖章"] = function()
			ToolTip_Logic:SelectQuestReward(25132)
		end,
		["萨科斯"] = function()--提示拾取物品，完成时提示选择奖励
			ToolTip_Logic:PickupItemQuest(3281) --萨科斯
			ToolTip_Logic:WorldMapTip()
		end,
		["返回大兽穴"] = function()
			ToolTip_Logic:SelectQuestReward(25130)
			ToolTip_Logic:WorldMapTip()
		end,
		["去森金村报到"] = function()--离开新手村
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:BackpackTip()
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA = {		
		[Race]={
			["FirstQuestTargetId"] = 3098,--"杂斑野猪",
			["targetPic"] = {
				["小试身手"] = "25126",
				["工蝎的尾巴"] = "25127",
				["萨科斯"] = "25129",
				["邪灵劣魔"] = "25131",
				["火刃奖章"] = "25132",
				["懒惰的苦工"] = "25134",
				["塔兹利尔的镐"] = "25135",
				["戈加尔的清凉果"] = "25136",
				["家园里的入侵者"] = "25172",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=25152,
				-- [你的位置]
				["25152"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["你的位置"],
				--小试身手
				["25126"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["小试身手"],
				-- [家园里的入侵者]
				["25172"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["家园里的入侵者"],
				-- [戈加尔的清凉果]
				["25136"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["戈加尔的清凉果"],
				-- [工蝎的尾巴]
				["25127"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["工蝎的尾巴"],
				-- [哈纳祖]
				["25128"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["哈纳祖"],
				-- [懒惰的苦工]
				["25134"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["懒惰的苦工"],
				-- [邪灵劣魔]
				["25131"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["邪灵劣魔"],
				-- [火刃奖章]
				["25132"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["火刃奖章"],
				-- [萨科斯]
				["25129"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["萨科斯"],
				-- [返回大兽穴]
				["25130"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["返回大兽穴"],
				-- [去森金村报到]
				["25133"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去森金村报到"],
			},
		}
	}
end