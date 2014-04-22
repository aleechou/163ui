-- Author      : s1172
-- Create Date : 2013/4/15 15:26:07

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Dwarf" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={
		["坚守防线！"] =  function()--提示按L，完成任务时提示选择奖励
			ToolTip_Logic:ViewQuestLog()
			ToolTip_Logic:SelectQuestReward(24469)
			ToolTip_Logic:LootTip()
		end,
		["罪有应得！"] = function()--提示装备物品
			ToolTip_Logic:TakeMoreQuest()
			ToolTip_Logic:SelectQuestReward(24470)
		end,
		["疗伤"] = function()--提示使用道具，打开大地图
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Dwarf use item quest"),69855)
			ToolTip_Logic:BackpackTip()
		end,
		["安威玛尔紧急戒严"] = ToolTip_Logic["WorldMapTip"],--提示打开大地图
		["重要的事先做：我们需要啤酒"] = function()--提示附近还有任务
			ToolTip_Logic:TakeMoreQuest()
		end,
		["矮人圣物"] = ToolTip_Logic["WorldMapTip"],--提示打开大地图
		["其他的物资"] = function()--提示拾取物品，完成时提示选择奖励
			ToolTip_Logic:PickupItemQuest(708) --"小型峭壁野猪"
		end,
		["抓紧时机"] = function()--提示拾取物品，完成时提示选择奖励，打开地图
			ToolTip_Logic:PickupItemQuest(37105) --石腭挖掘者
			ToolTip_Logic:SelectQuestReward(24486)
			ToolTip_Logic:WorldMapTip()
		end,
		["白须需要你"] = function()--打开地图、自动跑步
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:TipAutoRunAgain()
		end,
		["巨魔的威胁"] = function()--提示附近还有任务
			ToolTip_Logic:SelectQuestReward(182)
			ToolTip_Logic:TakeMoreQuest()
		end,
		["打探消息"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["冰与火"] = function()--使用炉石、选择任务奖励
			ToolTip_Logic:SelectQuestReward(218)
			ToolTip_Logic:UseHearthstone(218)
		end,
		["铁炉堡之旅"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["跟上那架直升机！"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["收拾行囊"] = ToolTip_Logic["WorldMapTip"],--打开地图
		["别忘记我们"] = function()--完成任务时提示去绑定炉石
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:GoHotel(24493)
		end,
	}
	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={
		[Race]={
			["FirstQuestTargetId"] = 37070,--"石腭入侵者",
			["targetPic"] = {
				["巨魔的威胁"] = "182",
				["冰与火"] = "218",
				["逃难者的困境"] = "3361",
				["坚守防线！"] = "24469",
				["罪有应得！"] = "24470",
				["疗伤"] = "24471",
				["重要的事先做：我们需要啤酒"] = "24474",
				["其他的物资"] = "24475",
				["矮人圣物"] = "24477",
				["抓紧时机"] = "24486",
				["打探消息"] = "24489",
				["收拾行囊"] = "24492",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=24469,
				-- [坚守防线！]
				["24469"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["坚守防线！"],
				-- [罪有应得！]
				["24470"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["罪有应得！"],
				-- [疗伤]
				["24471"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["疗伤"],
				-- [安威玛尔紧急戒严]
				["24473"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["安威玛尔紧急戒严"],
				-- [重要的事先做：我们需要啤酒]
				["24474"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["重要的事先做：我们需要啤酒"],
				-- [矮人圣物]
				["24477"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["矮人圣物"],
				-- [其他的物资]
				["24475"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["其他的物资"],
				-- [抓紧时机]
				["24486"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["抓紧时机"],
				-- [白须需要你]
				["24487"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["白须需要你"],
				-- [巨魔的威胁]
				["182"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["巨魔的威胁"],
				-- [打探消息]
				["24489"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["打探消息"],
				-- [冰与火]
				["218"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["冰与火"],
				-- [铁炉堡之旅]
				["24490"] = NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["铁炉堡之旅"],
				-- [跟上那架直升机！]
				["24491"] = NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["跟上那架直升机！"],
				-- [收拾行囊]
				["24492"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["收拾行囊"],
				-- [别忘记我们]
				["24493"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别忘记我们"],
			},
		}
	}
end