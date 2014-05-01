-- Author      : S0493
-- Create Date : 2013/5/20 15:32:01

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Troll" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={		
		["暗矛的崛起"] = ToolTip_Logic["ViewQuestLog"],
		["粗暴的开始"] = function()--提示拾取
			ToolTip_Logic:PickupItemQuest(38046) -- "蛮鬃野豹"
		end,
		["喜出望外"] = ToolTip_Logic["WorldMapTip"],
		["莫拉亚"] = ToolTip_Logic["TakeMoreQuest"],
		["捉螃蟹"] = function()
			ToolTip_Logic:PickupItemQuest(39004)
			ToolTip_Logic:WorldMapTip()
		end,
		["巨魔的铁杆伙伴"] = ToolTip_Logic["WorldMapTip"],
		["拯救幼崽"] = function()--提示使用任务物品
			ToolTip_Logic:TakeMoreQuest()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Troll use item quest"),70874)
		end,
		["海巫的配偶"] = function()--提示拾取任务道具,选择奖励
			ToolTip_Logic:PickupItemQuest(39072) -- "纳杰特丝"
			ToolTip_Logic:SelectQuestReward(24625)
		end,
		["给迷失者的怜悯"] = ToolTip_Logic["WorldMapTip"],
		["年轻气盛"] = function()--提示装备上个任务获取的装备
			ToolTip_Logic:BackpackTip()
			ToolTip_Logic:SelectQuestReward(24626)
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("Quest 24626."),70927)
		end,
		["突破防线"] = ToolTip_Logic["BackpackTip"],
		["不再怜悯"] = function()
			ToolTip_Logic:SelectQuestReward(24812)
		end,
		["古老的宿敌"] = function()
			ToolTip_Logic:BackpackTip()
			ToolTip_Logic:SelectQuestReward(24814)
		end,
		["森金村"] = function()--离开新手村
			ToolTip_Logic:BackpackTip()
			ToolTip_Logic:LeaveBirthplace()
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={		
		[Race]={
			["FirstQuestTargetId"] = 38038,--"蒂基面具假人",
			["targetPic"] = {
				["拯救幼崽"] = "24623",
				["给迷失者的怜悯"] = "24624",
				["海巫的配偶"] = "24625",
				["年轻气盛"] = "24626",
				["基础教程：攻击目标"] = "24639",
				["试炼场"] = "24642",
				["粗暴的开始"] = "24761",
				["不再怜悯"] = "24812",
				["领土神像-"] = "24813",
				["古老的宿敌"] = "24814",
				["捉螃蟹"] = "25037",
			},
			[Class] = {
				-- [莫拉亚]
				["25064"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["莫拉亚"],
				-- [捉螃蟹]
				["25037"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["捉螃蟹"],
				-- [巨魔的铁杆伙伴]
				["24622"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["巨魔的铁杆伙伴"],
				-- 拯救幼崽
				["24623"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["拯救幼崽"],
				-- 海巫的配偶
				["24625"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["海巫的配偶"],
				--["给迷失者的怜悯"]
				["24624"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["给迷失者的怜悯"],
				-- 年轻气盛
				["24626"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["年轻气盛"],
				-- [突破防线]
				["25035"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["突破防线"],
				-- [不再怜悯]
				["24812"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["不再怜悯"],
				-- [古老的宿敌]
				["24814"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["古老的宿敌"],
				-- 森金村
				["25073"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["森金村"],
			},
		}
	}

	if Class == "WARRIOR" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24607
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24607"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24641"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24643"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "HUNTER" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24776
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24776"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24779"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24781"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "MAGE" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24750
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24750"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24753"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24755"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "ROGUE" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24770
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24770"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24773"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24775"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "PRIEST" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24782
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24782"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24785"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24787"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "SHAMAN" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24758
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24758"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24761"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24763"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "WARLOCK" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=26272
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["26272"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["26275"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["26277"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "MONK" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=31159
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["31159"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["31160"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["31163"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	elseif Class == "PALADIN" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=24764
		-- 暗矛的崛起
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24764"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["暗矛的崛起"]
		-- 粗暴的开始
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24767"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["粗暴的开始"]
		-- 喜出望外
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["24769"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["喜出望外"]
	end
end