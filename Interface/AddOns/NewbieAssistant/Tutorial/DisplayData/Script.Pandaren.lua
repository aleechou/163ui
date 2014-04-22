-- Author      : s1172
-- Create Date : 2013/6/7 10:25:48

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Pandaren" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={
		["学海无涯"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 30041."))
		end,
		["武装训练"] = ToolTip_Logic["ViewQuestLog"],
		["沙袋训练"] = function()--提示任务位置
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29406."))
		end,
		["戒骄"] = ToolTip_Logic["BackpackTip"],--提示按b
		["烧毁卷轴"] = function()--提示任务位置
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29408."))
		end,
		["门徒的挑战"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["土水派的艾莎"] = ToolTip_Logic["BackpackTip"],--提示按b
		["失踪的车夫"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["至关重要的物品"] = function()
			ToolTip_Logic:PickupItemQuest(54130) --珀叶精怪
			ToolTip_Logic:LootTip()
		end,
		["土水之道"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["火金派的季"] = ToolTip_Logic["BackpackTip"],--提示按b
		["煽风"] = function()
			ToolTip_Logic["BackpackTip"]()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("quest 29523."),106299)
			ToolTip_Logic:PickupItemQuest(54631) --活体之气
			ToolTip_Logic:ClickGossip()
		end,--提示按b
		["元素之灵守护者"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["挑战者之火"] = function()--提示任务位置
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29664."))
		end,
		["上古火灵燧焰"] = function()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("quest 29422."),102522)
		end,
		["神真子的热情"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["咏之池"] = ToolTip_Logic["BackpackTip"],--提示按b
		["平衡训练"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29663."))
		end,
		["吃一蛰，长一智"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["上古水灵涓流"] = function()
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:UseItemQuestNoneChannel(TutorialApi:Localize("quest 29678."),103116)
		end,
		["新朋友"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29679."))
		end,
		["小无赖"] = ToolTip_Logic["TakeMoreQuest"],
		["还能吃！"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["比木头更硬"] = ToolTip_Logic["BackpackTip"],--提示按b
		["锣声震天"] = ToolTip_Logic["BackpackTip"],--提示按b
		["神真子的灵魂和躯体"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29775."))
		end,
		["晨息村"] = ToolTip_Logic["BackpackTip"],--提示按b
		["重写智慧"] = ToolTip_Logic["TakeMoreQuest"],
		["作案工具"] = function()
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:PickupItemQuest(55601) --狒狒村智者
		end,--提示看地图
		["警告猴子"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["平衡之念"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29784."))
		end,
		["天空之战"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29786."))
		end,
		["积跬步，致千里"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["通往卓越"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["捕食掠夺者"] = ToolTip_Logic["TakeMoreQuest"],
		["炸毁残骸"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["小心轻放"] = ToolTip_Logic["TakeMoreQuest"],
		["医疗物资"] = ToolTip_Logic["TakeMoreQuest"],
		["孤注一掷"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 30767."))
		end,
		["新的盟友"] = function()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 29775."))
		end,
		["新的命运"] = function()
			ToolTip_Logic:LeaveBirthplace()
			ToolTip_Logic:InCastleQuest(TutorialApi:Localize("quest 31450."))
			ToolTip_Logic:GoHotel(31450)
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={
		[Race]={
			["FirstQuestTargetId"] = 53714,
			["targetPic"] = {
				["沙袋训练"] = "29406",
				["门徒的挑战"] = "29409",
				["土水之道"] = "29414",
				["火金之道"] = "29417",
				["点火"] = "29418",
				["失踪的车夫"] = "29419",
				["胜者方能通行"] = "29421",
				["上古火灵燧焰"] = "29422",
				["至关重要的物品"] = "29424",
				["煽风"] = "29523",
				["戒骄"] = "29524",
				["武装训练"] = "30038",
			},
			[Class] = {
				-- [沙袋训练]
				["29406"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["沙袋训练"],
				-- [戒骄]
				["29524"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["戒骄"],
				-- [烧毁卷轴]
				["29408"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["烧毁卷轴"],
				-- [门徒的挑战]
				["29409"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["门徒的挑战"],
				-- [土水派的艾莎]
				["29410"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["土水派的艾莎"],
				-- [至关重要的物品]
				["29424"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["至关重要的物品"],
				-- [失踪的车夫]
				["29419"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["失踪的车夫"],
				-- [土水之道]
				["29414"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["土水之道"],
				-- [火金派的季]
				["29522"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["火金派的季"],
				-- [煽风]
				["29523"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["煽风"],
				-- [元素之灵守护者]
				["29420"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["元素之灵守护者"],
				-- [挑战者之火]
				["29664"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["挑战者之火"],
				-- [上古火灵燧焰]
				["29422"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["上古火灵燧焰"],
				-- [神真子的热情]
				["29423"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神真子的热情"],
				-- [咏之池]
				["29521"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["咏之池"],
				-- [平衡训练]
				["29663"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["平衡训练"],
				-- [寻找老朋友]
				["29676"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["寻找老朋友"],
				-- [吃一蛰，长一智]
				["29666"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["吃一蛰，长一智"],
				-- [上古水灵涓流]
				["29678"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["上古水灵涓流"],
				-- [新朋友]
				["29679"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["新朋友"],
				-- [生计来源]
				["29680"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["生计来源"],
				-- [小无赖]
				["29769"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["小无赖"],
				-- [还能吃！]
				["29770"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["还能吃！"],
				-- [比木头更硬]
				["29771"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["比木头更硬"],
				-- [锣声震天]
				["29772"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["锣声震天"],
				-- [神真子的灵魂和躯体]
				["29775"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神真子的灵魂和躯体"],
				-- [晨息村]
				["29776"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["晨息村"],
				-- [重写智慧]
				["29778"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["重写智慧"],
				-- [作案工具]
				["29777"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["作案工具"],
				-- [警告猴子]
				["29781"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["警告猴子"],
				-- [平衡之念]
				["29784"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["平衡之念"],
				-- [上古风灵大风]
				["29785"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["上古风灵大风"],
				-- [天空之战]
				["29786"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["天空之战"],
				-- [传承的价值]
				["29787"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["传承的价值"],
				-- [积跬步，致千里]
				["29789"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["积跬步，致千里"],
				-- [通往卓越]
				["29792"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["通往卓越"],
				-- [捕食掠夺者]
				["30591"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["捕食掠夺者"],
				-- [炸毁残骸]
				["30589"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["炸毁残骸"],
				-- [小心轻放]
				["30590"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["小心轻放"],
				-- [紧急消息]
				["29796"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["紧急消息"],
				-- [医疗物资]
				["29797"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["医疗物资"],
				-- [远古的邪恶]
				["29798"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["远古的邪恶"],
				-- [孤注一掷]
				["30767"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["孤注一掷"],
				-- [新的盟友]
				["29800"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["新的盟友"],
				-- [新的命运]
				["31450"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["新的命运"],
			},
		}
	}

	if Class == "WARRIOR" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30045
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30045"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30038"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	elseif Class == "HUNTER" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30041
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30041"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30034"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	elseif Class == "ROGUE" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30043
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30043"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30036"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	elseif Class == "PRIEST" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30042
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30042"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30035"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	elseif Class == "SHAMAN" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30044
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30044"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30037"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	elseif Class == "MAGE" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30040
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30040"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30033"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	elseif Class == "MONK" then
		-- 第一个任务ID
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["FirstQuestId"]=30039
		-- [学海无涯]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30039"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["学海无涯"]
		-- [武装训练]
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]["30027"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["武装训练"]
	end
end