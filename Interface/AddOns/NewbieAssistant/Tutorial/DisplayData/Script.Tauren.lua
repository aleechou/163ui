-- Author      : S0493
-- Create Date : 2013/5/20 15:10:53

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Tauren" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={		
		["第一步"] =  ToolTip_Logic["ViewQuestLog"],
		["力量仪祭"] =  function()--任务完成提示选择装备
			ToolTip_Logic:SelectQuestReward(14452)
			ToolTip_Logic:LootTip()
		end,
		["被囚禁的部族"] =  function()--提示装装备
			ToolTip_Logic:BackpackTip()
			ToolTip_Logic:SelectQuestReward(24852)
		end,
		["去找阿达娜"] = ToolTip_Logic["WorldMapTip"],
		["勇气仪祭"] = function()--提示拾取任务物品
			ToolTip_Logic:SelectQuestReward(14456)
			ToolTip_Logic:PickupItemQuest(36708) --刺背枪匪
			ToolTip_Logic:TakeMoreQuest()
		end,
		["阻止号角手"] = function()--提示拾取任务物品
			ToolTip_Logic:SelectQuestReward(14455)
		end,
		["邪恶的食粮"] =  function()--提示使用任务道具
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Tauren use item quest"),69228)
			ToolTip_Logic:BackpackTip()
		end,
		["斗猪"] = function()--提示拾取任务物品
			ToolTip_Logic:SelectQuestReward(14459)
		end,
		["荣誉仪祭"] = function()
			ToolTip_Logic:SelectQuestReward(14460)
			ToolTip_Logic:PickupItemQuest(36712)
			ToolTip_Logic:BackpackTip()
		end,
		["最后的仪式，最初的仪式"] = function()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Quest 24861."),71898)
		end,
		["大地母亲的仪式"] = ToolTip_Logic["WorldMapTip"],
		["风之仪式"] =  function()--离开新手村
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Quest 24215."),69340)
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:GoHotel(24215)
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={		
		[Race]={
			["FirstQuestTargetId"] = 36943,--刺背入侵者
			["targetPic"] = {
				["力量仪祭"] = "14452",
				["阻止号角手"] = "14455",
				["勇气仪祭"] = "14456",
				["斗猪"] = "14459",
				["荣誉仪祭"] = "14460",
				["邪恶的食粮"] = "14461",
				["被囚禁的部族"] = "24852",
				["最后的仪式，最初的仪式"] = "24861",
			},
			[Class] = {
				-- 第一个任务ID
				["FirstQuestId"]=14449,
				-- 第一步
				["14449"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["第一步"],
				-- 力量仪祭
				["14452"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["力量仪祭"],
				-- 被囚禁的部族
				["24852"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["被囚禁的部族"],
				-- 去找阿达娜
				["14458"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去找阿达娜"],
				-- 勇气仪祭
				["14456"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["勇气仪祭"],
				-- [阻止号角手]
				["14455"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["阻止号角手"],
				-- [斗猪]
				["14459"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["斗猪"],
				-- 邪恶的食粮 --直接使用型
				["14461"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["邪恶的食粮"],
				-- [荣誉仪祭]
				["14460"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["荣誉仪祭"],
				-- [最后的仪式，最初的仪式]
				["24861"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["最后的仪式，最初的仪式"],
				-- [大地母亲的仪式]
				["23733"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["大地母亲的仪式"],
				-- 风之仪式
				["24215"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["风之仪式"],
			},
		}
	}
end