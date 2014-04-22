-- Author      : s1172
-- Create Date : 2013/5/24 12:02:04

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Draenei" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={
		["你活下来了！"] = ToolTip_Logic["ViewQuestLog"],--提示按l
		["补充治疗水晶"] = function ()
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:SelectQuestReward(9280)
			ToolTip_Logic:LootTip()
		end,
		["紧急物资！"] = ToolTip_Logic["BackpackTip"],--提示按b
		["拯救幸存者！"] = function()--提示附近还有任务
			ToolTip_Logic:TakeMoreQuest()
		end,
		["备用零件"] = function()--提示附近还有任务
			ToolTip_Logic:SelectQuestReward(9305)
		end,
		["疫苗"] = function()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Quest 9303."),29528)
		end,
		["植物学家塔蕾克丝"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["暴躁的变异体"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["必需的措施……"] = function()--提示附近还有任务、杀掉任务怪后提示可以拾取任务道具、点NPC完成后提示多个任务奖励选择方法
			ToolTip_Logic:TakeMoreQuest()
		end,
		["跑腿采花"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["净化湖水！"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["失踪的斥候"] = function()--提示看地图
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:BackpackTip()--提示按b
		end,
		["血精灵"] = function()-- 交任务后提示绑定炉石
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:SelectQuestReward(10303)
		end,
		["血精灵间谍"] = function()-- 交任务后提示绑定炉石
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:SelectQuestReward(9311)
		end,
		["图像发射器"] = ToolTip_Logic["BackpackTip"],--提示按b
		["前往碧蓝岗哨"] = function()
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:GoHotel(9313)
		end,--提示按b
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA = {		
		[Race]={
			["FirstQuestTargetId"] = 16520,--峡谷蛾
			["targetPic"] = {
				["补充治疗水晶"] = "9280",
				["拯救幸存者"] = "9283",
				["必需的措施……"] = "9293",
				["净化湖水"] = "9294",
				["疫苗"] = "9303",
				["备用零件"] = "9305",
				["血精灵间谍"] = "9311",
				["跑腿采花"] = "9799",
				["暴躁的变异体"] = "10302",
				["血精灵"] = "10303",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=9279,
				-- [你活下来了！]
				["9279"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["你活下来了！"],
				-- [补充治疗水晶]
				["9280"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["补充治疗水晶"],
				-- [紧急物资！]
				["9409"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["紧急物资！"],
				-- [拯救幸存者！]
				["28786"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["拯救幸存者！"],
				-- [疫苗]
				["9303"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["疫苗"],
				-- [备用零件]
				["9305"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["备用零件"],
				-- [植物学家塔蕾克丝]
				["9371"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["植物学家塔蕾克丝"],
				-- [必需的措施……]
				["9293"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["必需的措施……"],
				-- [跑腿采花]
				["9799"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["跑腿采花"],
				-- [净化湖水]
				["9294"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["净化湖水"],
				-- [失踪的斥候]
				["9309"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["失踪的斥候"],
				-- [血精灵]
				["10303"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["血精灵"],
				-- [血精灵间谍]
				["9311"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["血精灵间谍"],
				-- [图像发射器]
				["9312"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["图像发射器"],
				-- [前往碧蓝岗哨]
				["9313"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["前往碧蓝岗哨"],
			},
		}
	}
end