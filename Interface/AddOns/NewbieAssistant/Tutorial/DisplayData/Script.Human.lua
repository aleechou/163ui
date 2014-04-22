-- Author      : s1172
-- Create Date : 2013/3/26 13:30:26

local _, Race = UnitRace("player")
local _, Class = UnitClass("player")

if Race == "Human" then
	local NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC={
		["击退敌人"] = function()
			ToolTip_Logic:ViewQuestLog()
			ToolTip_Logic:LootTip()
		end,--提示按l
		["狮入羊口"] = ToolTip_Logic["BackpackTip"],--提示按b
		["神圣信件"] = function(str)--提示任务位置
			ToolTip_Logic:InCastleQuest(str)--"这个任务在城堡内，进入后左手边第二个屋子内，一层。")
			ToolTip_Logic:ClickGossip()
		end,
		["加入战斗！"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["他们派来了刺客"] = ToolTip_Logic["TakeMoreQuest"],
		["别畏惧邪恶"] = ToolTip_Logic["WorldMapTip"],--提示看地图
		["后方已经安全"] = ToolTip_Logic["BackpackTip"],--提示按b
		["黑石兽人的入侵"] = function()--提示附近还有任务、杀掉任务怪后提示可以拾取任务道具、点NPC完成后提示多个任务奖励选择方法
			ToolTip_Logic:TakeMoreQuest()
			ToolTip_Logic:PickupItemQuest(42937) --黑石侵略者
			ToolTip_Logic:SelectQuestReward(26389)
		end,
		["灭火拯救希望"] = function()--提示看地图、按自动跑步、使用任务道具
			ToolTip_Logic:UseItemQuest(TutorialApi:Localize("Use Quest Item"),80199)
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:TipAutoRunAgain()
		end,
		["终结入侵！"] = function()-- 任务完成后提示用炉石
			ToolTip_Logic:WorldMapTip()
			ToolTip_Logic:UseHearthstone(26390)
		end,
		["去闪金镇报到"] = ToolTip_Logic["LeaveBirthplace"],
		["休息和放松"] = function()-- 交任务后提示绑定炉石
			TutorialSmallMsgFrame_Hide(-1)
			ToolTip_Logic:GoHotel(2158)
		end,
	}

	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA={
		[Race]={
			["FirstQuestTargetId"] = 49871,--"黑石战狼",
			["targetPic"] = {
				["击退敌人！"] = "28764",
				["黑石兽人的入侵"] = "26389",
				["终结入侵！"] = "26390",
				["狮入羊口"] = "28772",
				["他们派来了刺客"] = "28795",
				["别畏惧邪恶"] = "28811",
			},
		}
	}

	if Class == "PRIEST" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28763,
			-- [击退敌人]
			["28763"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28771"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["3103"]=function()
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 3103."))
			end,
			-- [加入战斗！]
			["28786"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["28794"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28810"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28820"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "WARRIOR" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28766,
			-- [击退敌人]
			["28766"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28774"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["3100"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 3100."))
			end,
			-- [加入战斗！]
			["28789"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["28797"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28813"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28823"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "PALADIN" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28762,
			-- [击退敌人]
			["28762"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28770"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["3101"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 3101."))
			end,
			-- [加入战斗！]
			["28785"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["28793"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28809"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28819"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "HUNTER" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28767,
			-- [击退敌人]
			["28767"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28759"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["26910"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 26910."))
			end,
			-- [加入战斗！]
			["28780"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["28791"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28806"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28817"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "ROGUE" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28764,
			-- [击退敌人]
			["28764"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28772"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["3102"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 3102."))
			end,
			-- [加入战斗！]
			["28787"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["28795"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28811"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28821"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "MAGE" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28757,
			-- [击退敌人]
			["28757"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28769"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["3104"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 3104."))
			end,
			-- [加入战斗！]
			["28784"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人！"],
			--  [他们派来了刺客]
			["28792"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28808"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28818"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "WARLOCK" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=28765,
			-- [击退敌人]
			["28765"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["28773"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["3105"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 3105."))
			end,
			-- [加入战斗！]
			["28788"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["28796"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["他们派来了刺客"],
			--  [别畏惧邪恶]
			["28812"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["28822"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	elseif Class == "MONK" then
		NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][Class]={
			-- 第一个任务ID
			["FirstQuestId"]=31139,
			-- [击退敌人]
			["31139"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["击退敌人"],
			-- [狮入羊口]
			["31140"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["狮入羊口"],
			-- [神圣信件]
			["31141"]=function(str)
				NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["神圣信件"](TutorialApi:Localize("quest 31141."))
			end,
			-- [加入战斗！]
			["31143"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["加入战斗！"],
			--  [他们派来了刺客]
			["31144"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["别畏惧邪恶"],
			-- [后方已经安全]
			["31145"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["后方已经安全"],
			-- [黑石兽人的入侵]
			["26389"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["黑石兽人的入侵"],
			-- [灭火拯救希望]
			["26391"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["灭火拯救希望"],
			-- [终结入侵！]
			["26390"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["终结入侵！"],
			-- [去闪金镇报到]
			["54"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["去闪金镇报到"],
			-- [休息和放松]
			["2158"]=NEWBIE_ASSISTANT_TUTORIAL_QUEST_FUNC["休息和放松"],
		}
	end
end