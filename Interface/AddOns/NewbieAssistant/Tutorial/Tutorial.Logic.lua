-- Author      : s1172
-- Create Date : 2013/5/13 10:51:59


local ToolTip_Logic = CreateFrame("frame","ToolTip_Logic")

-- locale
local L = TutorialApi.Localization


function ToolTip_Logic:TutorialStart()
	-- 死亡提示
	NAApi:RegEvent(ToolTip_Logic,"PLAYER_DEAD",ToolTip_Logic["PLAYER_DEAD"])
	-- 任务提示
	NAApi:RegEvent(ToolTip_Logic,"QUEST_ACCEPTED",ToolTip_Logic["QUEST_ACCEPTED"])
	NAApi:RegEvent(ToolTip_Logic,"QUEST_COMPLETE",ToolTip_Logic["QUEST_COMPLETE"])
	-- 包满提示
	NAApi:RegEvent(ToolTip_Logic,"UNIT_INVENTORY_CHANGED",ToolTip_Logic["UNIT_INVENTORY_CHANGED"])
	-- 第一个任务
	ToolTip_Logic:CheckFirstQuest()
	-- 初始化系统参数
	SetCVar("nameplateShowEnemies", "1") -- 姓名版
	SetCVar("autoLootDefault","1") -- 自动拾取
	SetCVar("rotateMinimap", "0") -- 旋转小地图
	SetCVar("showTutorials",0) -- 关闭系统提示
	BlizzardOptionsPanel_SetCVarSafe("playerStatusText","1","STATUS_TEXT_PLAYER") -- 玩家血条数字
	BlizzardOptionsPanel_SetCVarSafe("targetStatusText","1","STATUS_TEXT_TARGET")
	BlizzardOptionsPanel_SetCVarSafe("xpBarText","1","XP_BAR_TEXT")
end

-- 拾取提示
function ToolTip_Logic:LootTip()
	-- 拾取物品提示
	local lootid = 0
	local function loot()
		if NAApi:GetLvl("player")==1 and lootid<5 then
			TutorialMiniFrame_Show(L["Right-click the monster`s body to pickup items"].title,L["Right-click the monster`s body to pickup items"].content,"gold")
			lootid = lootid + 1
		else
			NAApi:UnregEvent(ToolTip_Logic,"PLAYER_REGEN_ENABLED",loot)
		end
	end
	NAApi:RegEvent(ToolTip_Logic,"PLAYER_REGEN_ENABLED",loot)
end

-- 检测第一个任务是否领取
function ToolTip_Logic:CheckFirstQuest()
	local _,class = UnitClass("player")
	local _,race = UnitRace("player")
	firstquestid = NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[race][class].FirstQuestId

	if not IsQuestFlaggedCompleted(firstquestid) then

		if GetQuestLogIndexByID(firstquestid)==0 then
			TutorialMiniFrame_Show(L["Start Quest Title"],L["Right-click the NPC that you can accept quest."],"quest",20)
		end

		local function FocusOnTarget(self,event,unitid)
			local targetid = NAApi:GetNpcIDByGUID(UnitGUID("target"))
			local firstTargetId = NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[race].FirstQuestTargetId
			
			if unitid == "player" and targetid == firstTargetId then
				NAApi:UnregEvent(ToolTip_Logic,"UNIT_TARGET",FocusOnTarget)
				TutorialSmallMsgFrame_Show("DOWN","BOTTOMLEFT",ActionButton1,"TOPRIGHT",0,50,L["This is action bar."],true)

				TutorialMiniFrame_Show(L["HP bar color Title"],L["Different between Red with Yellow health bar."],"redname",10)

				NAApi:RegEvent(ToolTip_Logic,"PLAYER_REGEN_DISABLED",function()
					TutorialMiniFrame_Hide()
					TutorialSmallMsgFrame_Hide(-1)
					-- 血条
					TutorialSmallMsgFrame_Show("UP","TOPLEFT",PlayerFrame,"BOTTOM",0,0,L["This is your HP and MP"],true)
					-- 等待第一次任务完成
					NAApi:RegEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",ToolTip_Logic["QUEST_LOG_UPDATE"])

					NAApi:RegEvent(ToolTip_Logic,"PLAYER_REGEN_DISABLED",function()
						TutorialSmallMsgFrame_Hide(-1)
					end,true)

				end,true)
			end
		end

		NAApi:RegEvent(ToolTip_Logic,"UNIT_TARGET",FocusOnTarget)
		NAApi:RegEvent(ToolTip_Logic,"LEARNED_SPELL_IN_TAB",function()
			-- 提示技能框
			local smallMsgFrameId = TutorialSmallMsgFrame_Show("DOWN","BOTTOM",SpellbookMicroButton,"TOP",0,30,L["Press P to open Character Skill window"],true)
			NAApi:SecureHook("ToggleSpellBook",function()
				-- 提示“关闭提示框”
				TutorialSmallMsgFrame_Show("LEFT","LEFT",SpellBookFrameTutorialButton,"RIGHT",10,0,L["spellbook Tutorial"],true)
				NAApi:SecureHook("HelpPlate_Hide",function()
					TutorialSmallMsgFrame_Hide(smallMsgFrameId)
				end,true)
			end,true)
		end,true)

		--设置启动插件
		TutorialApi:SetUIStatus(true)
		NAApi:SetAddonDB("FirstLogin", true)
	end
end

-- 绑定炉石提示
function ToolTip_Logic:TipBindstone()
	TutorialMiniFrame_Show(L["You can talk with Npc to bind stone"].title,L["You can talk with Npc to bind stone"].content,"hearthstone",10)
end

-- 包满提示
function ToolTip_Logic:UNIT_INVENTORY_CHANGED(event,...)
	local unit = ...
	if unit == "player" then
		freeSlots = MainMenuBarBackpackButton.freeSlots
		if freeSlots == 0 then
			TutorialMiniFrame_Show(L["Backpack Full Title"],L["Your backpack is full."],"backpack",10)
			NAApi:Sleep(5,function()
				TutorialMiniFrame_Hide()
				NAApi:SecureUnHook("ToggleBackpack")
			end)
			NAApi:SecureHook("ToggleBackpack",function()
				TutorialMiniFrame_Hide()
			end,true)
		end
	end
end

-- 提示L查看任务
function ToolTip_Logic:ViewQuestLog()
	local firstopen = true
	TutorialMiniFrame_Show(L["Open Quest Title"],L["Press L to open quest list."],"quest",20)

	NAApi:SecureHook(QuestLogFrame,"Show",function()
		if NAApi:GetLvl("player") >= 5 then
			NAApi:SecureUnHook(QuestLogFrame,"Show")
		end

		if firstopen then
			TutorialMiniFrame_Hide()
		end

		--提示追踪按钮
		-- local smallMsgFrameId1 = TutorialSmallMsgFrame_Show("UP","TOP",QuestLogFrameTrackButton,"BOTTOM",0,-25,L["Left-click this button can track quest or not."],true)
		--提示任务进度框
		local smallMsgFrameId2 = TutorialSmallMsgFrame_Show("RIGHT","RIGHT",WatchFrameHeader,"LEFT",-25,0,L["This is the quest track window."],true)
		--提示关闭任务面板按钮
		local tinyMsgFrameId = TutorialTinyMsgFrame_Show("BOTTOMLEFT","BOTTOMLEFT",QuestLogFrameCloseButton,"RIGHT",0,0,L["Left-click this close quest log."])

		NAApi:SecureHook(QuestLogFrame,"Hide",function()
			--TutorialSmallMsgFrame_Hide(smallMsgFrameId1)
			TutorialSmallMsgFrame_Hide(smallMsgFrameId2)
			TutorialTinyMsgFrame_Hide(tinyMsgFrameId)
			if firstopen then
				ToolTip_Logic:WorldMapTip()
				firstopen=nil
			end
		end,true)
	end)
end

-- 提示M大地图
function ToolTip_Logic:WorldMapTip()
	-- 小地图提示M
	TutorialMiniFrame_Show(L["Open Map Title"],L["Press M to open world map."],"map",20)

	NAApi:SecureHook(WorldMapFrame,"Show",function()
		TutorialMiniFrame_Hide()

		show=function()
			TutorialTinyMsgFrame_Hide(-1)
			WorldMapShowDropDown_OnClick({checked=true,value="quests"})
			
			local relativePoint1 = poiWorldMapPOIFrame1_1 and "poiWorldMapPOIFrame1_1" or "poiWorldMapPOIFrame_Swap"
			-- 大地图提示蓝色区域为任务
			local smallMsgFrameId = TutorialSmallMsgFrame_Show(nil,"TOP",WorldMapFrame,"BOTTOM",0,0,L["This area is the quest aim."],nil,WorldMapFrame:GetWidth()-10)
			-- 提示红线
			-- local smallMsgFrameId1 = TutorialSmallMsgFrame_Show("LEFT","LEFT",WorldMapPlayerUpper,"RIGHT",0,0,L["Follow the pink line."],nil,WorldMapPlayerUpper)
			-- _G["TutorialSmallMsgFrame_"..smallMsgFrameId1]:SetScale(1.5)
			-- 提示左键点X可关闭大地图
			TutorialTinyMsgFrame_Show("BOTTOMLEFT","BOTTOMLEFT",WorldMapFrameCloseButton,"RIGHT",0,0,L["Left-click this close world map."])
			NAApi:SecureHook(WorldMapFrame,"Hide",function()
				TutorialSmallMsgFrame_Hide(smallMsgFrameId)
				-- TutorialSmallMsgFrame_Hide(smallMsgFrameId1)
				TutorialTinyMsgFrame_Hide(-1)
				if NAApi:GetAddonDB("FirstLogin") then
					NAApi:SetAddonDB("FirstLogin", nil)
					smallMsgFrameID = TutorialSmallMsgFrame_Show("RIGHT","RIGHT",Minimap,"LEFT",0,0,L["This is Minimap."],true)
					ToolTip_Logic:ShowIntegrated(smallMsgFrameID)
				end
			end,true)
		end 
		if WorldMapFrameSizeDownButton:IsShown() then
			-- 大地图提示缩小按钮
			TutorialTinyMsgFrame_Show("TOPRIGHT","TOPRIGHT",WorldMapFrameSizeDownButton,"BOTTOMLEFT",20,0,L["Left-click the world map will inzoom/ourzoom"])
			NAApi:SecureHook("WorldMap_ToggleSizeDown",show,true)
		else
			show()
		end
	end,true)
end

-- 提示前瞻框
function ToolTip_Logic:ShowIntegrated(id)
	NewbieAssistantPannelFrameToggleButton:Click()
	local smallMsgFrameId = TutorialSmallMsgFrame_Show("RIGHT","RIGHT",NewbieAssistantPannelFrameToggleButton,"LEFT",-50,0,L["This is the Prospective content."],true)
	NAApi:SecureHook(NewbieAssistantPannelFrame,"Hide",function()
		TutorialSmallMsgFrame_Hide(smallMsgFrameId)
		TutorialSmallMsgFrame_Hide(id)
	end,true)
end

-- 第一次完成任务提示找黄色问号
function ToolTip_Logic:QUEST_LOG_UPDATE()
	local Index = 1
	local questIndex = GetQuestIndexForWatch(Index)
	if not questIndex then return end

	while questIndex do
		local qid = select(9, GetQuestLogTitle(questIndex))
		local completed, x, y, objective = QuestPOIGetIconInfo(qid)
		Index = Index + 1
		questIndex = GetQuestIndexForWatch(Index)
		
		if not completed then
			return
		end
	end
	
	--NAApi:UnregEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",ToolTip_Logic["QUEST_LOG_UPDATE"])
	TutorialMiniFrame_Show(L["Quest Complete Title"],L["Quest Complete."],"quest",10)
	NAApi:SecureHook(WorldMapFrame,"Show",function()
		TutorialMiniFrame_Hide()
		local smallMsgFrameId = TutorialSmallMsgFrame_Show("LEFT","LEFT",poiWorldMapPOIFrame_Swap,"RIGHT",30,0,L["You can go here to complete quest."],true)
		NAApi:SecureHook(WorldMapFrame,"Hide",function()
			TutorialSmallMsgFrame_Hide(smallMsgFrameId)
		end,true)
	end,true)
end

-- 背包提示
function ToolTip_Logic:BackpackTip()
	-- 提示按B
	TutorialMiniFrame_Show(L["Equip Item Title"],L["Press B to open Bag"],"backpack",20)

	local function bag()
		local itemLocation = TutorialApi:GetItemLocation()
		if not itemLocation then
			itemLocation = "ContainerFrame1"
		end

		TutorialMiniFrame_Hide()

		-- 提示装备物品
		local smallMsgFrameId = TutorialSmallMsgFrame_Show("RIGHT","RIGHT",_G[itemLocation],"TOPLEFT",-20,-20,L["Right-click to equip the item"],true)

		NAApi:RegEvent(ToolTip_Logic,"PLAYER_EQUIPMENT_CHANGED",function(self,event,...)
			SlotId = ...
			-- 提示按C
			TutorialSmallMsgFrame_Hide(smallMsgFrameId)
			smallMsgFrameId = TutorialSmallMsgFrame_Show("DOWN","BOTTOM",CharacterMicroButton,"TOP",0,30,L["Press C to open Character Paperdoll window"],true)
			NAApi:SecureHook("ToggleCharacter",function()
				local Slot={
					[1]="CharacterHeadSlot",
					[2]="CharacterNeckSlot",
					[3]="CharacterShoulderSlot",
					[4]="CharacterShirtSlot",
					[5]="CharacterChestSlot",
					[6]="CharacterWaistSlot",
					[7]="CharacterLegsSlot",
					[8]="CharacterFeetSlot",
					[9]="CharacterWristSlot",
					[10]="CharacterHandsSlot",
					[11]="CharacterFinger0Slot",
					[12]="CharacterFinger0Slot",
					[13]="CharacterTrinket0Slot",
					[14]="CharacterTrinket1Slot",
					[15]="CharacterBackSlot",
					[16]="CharacterMainHandSlot",
					[17]="CharacterSecondaryHandSlot",
				}
				
				-- 提示穿上的装备位置
				TutorialSmallMsgFrame_Hide(smallMsgFrameId)
				smallMsgFrameId = TutorialSmallMsgFrame_Show("LEFT","LEFT",_G[Slot[SlotId]],"RIGHT",30,0,L["This is you`re equipment Item"],true)
				local tinyMsgFrameId = TutorialTinyMsgFrame_Show("BOTTOMLEFT","BOTTOMLEFT",CharacterFrameCloseButton,"RIGHT",0,0,L["LeftClick this button close paper doll window."])
				NAApi:SecureHook(CharacterFrame,"Hide",function()
					TutorialSmallMsgFrame_Hide(smallMsgFrameId)
					TutorialTinyMsgFrame_Hide(tinyMsgFrameId)
					ToolTip_Logic:WorldMapTip()
				end,true)
			end,true)
		end,true)
	end
	if IsAddOnLoaded("Combuctor") then
		NAApi:SecureHook(Combuctor,"Show",bag,true)
	else
		NAApi:SecureHook("ToggleBackpack",bag,true)
	end
end

-- 进城堡交任务
function ToolTip_Logic:InCastleQuest(str)
	TutorialMiniFrame_Show(L["Finish Quest Title"],str,"quest",20)

	local function QUEST_LOG_UPDATE()
		local questIndex = GetQuestIndexForWatch(1)
		if not questIndex then 
			TutorialMiniFrame_Hide()
			NAApi:UnregEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",QUEST_LOG_UPDATE)
		end
	end

	NAApi:RegEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",QUEST_LOG_UPDATE)
end

function ToolTip_Logic:ClickGossip()
	local function gossip()
		if GossipTitleButton1.type == "Active" then
			local smallMsgFrameId = TutorialSmallMsgFrame_Show("LEFT","LEFT",GossipFrame,"RIGHT",30,120,L["Left-click here to complete quest."],true)
			NAApi:UnregEvent(ToolTip_Logic,"GOSSIP_SHOW",gossip)
			NAApi:Sleep(10,function()
				TutorialSmallMsgFrame_Hide(smallMsgFrameId)
			end)
		end
	end
	NAApi:RegEvent(ToolTip_Logic,"GOSSIP_SHOW",gossip)
end


-- 任务完成后再次提示按Num自动奔跑
function ToolTip_Logic:TipAutoRunAgain()
	local function tipautoRun()
		local Index = 1
		local questIndex = GetQuestIndexForWatch(Index)

		while questIndex do
			local qid = select(9, GetQuestLogTitle(questIndex))
			local completed, x, y, objective = QuestPOIGetIconInfo(qid)
			Index = Index + 1
			questIndex = GetQuestIndexForWatch(Index)

			if not completed then
				return
			end
		end

		local smallMsgFrameId = TutorialSmallMsgFrame_Show(nil,"BOTTOM",CastingBarFrame,"TOP",0,30,L["Tip:You can press Num Lock start AutoRun."],true,UIParent)
		NAApi:Sleep(20,function()TutorialSmallMsgFrame_Hide(smallMsgFrameId)end)
		NAApi:UnregEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",tipautoRun)
	end

	NAApi:RegEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",tipautoRun)
	local smallMsgFrameId = TutorialSmallMsgFrame_Show(nil,"BOTTOM",CastingBarFrame,"TOP",0,30,L["Tip:You can press Num Lock start AutoRun."],true,UIParent)
	NAApi:Sleep(20,function()TutorialSmallMsgFrame_Hide(smallMsgFrameId)end)
end

-- 多个奖励任务，提示选择方法
function ToolTip_Logic:SelectQuestReward(questid)
	local function selectquest()
		if QuestFrameCompleteQuestButton:IsEnabled() and GetQuestID()==questid then
			NAApi:SecureUnHook(QuestFrame,"Show")
			ToolTip_Logic.SelectQuestRewardSmallMsgFrameId = TutorialSmallMsgFrame_Show("LEFT","LEFT",QuestFrameRewardPanel,"RIGHT",0,0,L["quest reward select"],true,QuestFrameRewardPanel)
			NAApi:SecureHook("GetQuestReward",function()
				TutorialSmallMsgFrame_Hide(ToolTip_Logic.SelectQuestRewardSmallMsgFrameId)
				ToolTip_Logic.SelectQuestRewardSmallMsgFrameId = nil
			end,true)
		end
	end
	NAApi:SecureHook(QuestFrame,"Show",selectquest)
end

-- 需要使用道具的任务，非引导
function ToolTip_Logic:UseItemQuestNoneChannel(str,itemid)
	local smallMsgFrameID 
	local tip=function()smallMsgFrameID=TutorialSmallMsgFrame_Show("RIGHT","RIGHT",WatchFrameItem1,"LEFT",-30,0,str,true)end
	NAApi:Sleep(1,tip)
	local function useitemquest(self,event,...)
		local unitId, _, _, _, id = ...
		if unitId == "player" and tonumber(id) == itemid then
			NAApi:UnregEvent(ToolTip_Logic,"UNIT_SPELLCAST_SUCCEEDED",useitemquest)
			TutorialSmallMsgFrame_Hide(smallMsgFrameID)
		end
	end
	NAApi:RegEvent(ToolTip_Logic,"UNIT_SPELLCAST_SUCCEEDED",useitemquest)
end

-- 需要使用道具的任务，引导
function ToolTip_Logic:UseItemQuest(str,itemid)
	local smallMsgFrameID = TutorialSmallMsgFrame_Show("RIGHT","RIGHT",WatchFrameItem1,"LEFT",-30,0,str,true)

	local function UseItemQuestStop(self,event,...)
		local unitId, spellname, _, _, spellId = ...
		if unitId == "player" then
			NAApi:UnregEvent(ToolTip_Logic,"UNIT_SPELLCAST_CHANNEL_STOP",UseItemQuestStop)
			TutorialSmallMsgFrame_Hide(smallMsgFrameID)
		end
	end

	local function UseItemQuestStart(self,event,...)
		local unitId, spellname, _, _, spellId = ...
		if unitId == "player" and tonumber(spellId) == itemid then
			TutorialSmallMsgFrame_Hide(smallMsgFrameID)
			NAApi:UnregEvent(ToolTip_Logic,"UNIT_SPELLCAST_CHANNEL_START",UseItemQuestStart)
			smallMsgFrameID = TutorialSmallMsgFrame_Show("DOWN","BOTTOM",CastingBarFrame,"TOP",0,50,L["Don`t move when you casting channeling magic."],true)
			NAApi:RegEvent(ToolTip_Logic,"UNIT_SPELLCAST_CHANNEL_STOP",UseItemQuestStop)
		end
	end

	NAApi:RegEvent(ToolTip_Logic,"UNIT_SPELLCAST_CHANNEL_START",UseItemQuestStart)
end

-- 需拾取道具的任务
function ToolTip_Logic:PickupItemQuest(id)
	local function pickup(self,event,...)
		local _, IsDead, _, _, target, _, _, guid = ...

		if target and target==UnitName("player") then
			if IsDead == "PARTY_KILL" and NAApi:GetNpcIDByGUID(guid) == id then
				TutorialMiniFrame_Show(L["Pickup Quest Item Title"],L["Right-click the monster`s body to pickup quest item."],"gold",20)
				NAApi:UnregEvent(ToolTip_Logic,"COMBAT_LOG_EVENT_UNFILTERED",pickup)
				NAApi:RegEvent(ToolTip_Logic,"LOOT_CLOSED",function()
					TutorialMiniFrame_Hide()
				end,true)
			end
		end
	end

	NAApi:RegEvent(ToolTip_Logic,"COMBAT_LOG_EVENT_UNFILTERED",pickup)
	
end

function ToolTip_Logic:IsQuestComplete(id)
	local isComplete = select(7, GetQuestLogTitle(GetQuestLogIndexByID(id)))
	return isComplete
end

-- 提示炉石
function ToolTip_Logic:UseHearthstone(questId)
	local function UNIT_QUEST_LOG_CHANGED(self,event,...)
		local unitId = ...
		if ToolTip_Logic:IsQuestComplete(questId) then
			TutorialMiniFrame_Show(L["Use Hearthstone Title"],L["You can use stone"],"hearthstone",20)
			NAApi:SecureHook("ToggleBackpack",function()
				TutorialMiniFrame_Hide()
			end,true)
			NAApi:UnregEvent(ToolTip_Logic,"UNIT_QUEST_LOG_CHANGED",UNIT_QUEST_LOG_CHANGED)
		end
	end
	NAApi:RegEvent(ToolTip_Logic,"UNIT_QUEST_LOG_CHANGED",UNIT_QUEST_LOG_CHANGED)
end

-- 回旅馆
function ToolTip_Logic:GoHotel(questid)
	local function gohotel(self,event,...)
		local finished = IsQuestFlaggedCompleted(questid)
		if finished then
			TutorialMiniFrame_Show(L["Bind Hearthstone Title"],L["Talk to NPC bind hearthstone"],"hearthstone",10)
			NAApi:UnregEvent(ToolTip_Logic,"QUEST_FINISHED",gohotel)
			NAApi:RegEvent(ToolTip_Logic,"UNIT_SPELLCAST_SUCCEEDED",ToolTip_Logic["BindHearthstone"])
		end
	end

	NAApi:RegEvent(ToolTip_Logic,"QUEST_FINISHED",gohotel)
end

-- 绑定炉石
function ToolTip_Logic:BindHearthstone(event,...)
	target, spellname, _, _, spellid = ...
	if spellid == 3286 and target == "target" then
		TutorialMiniFrame_Hide()
		NAApi:UnregEvent(ToolTip_Logic,"UNIT_SPELLCAST_SUCCEEDED",BindHearthstone)
	end
end

-- 离开出生地
function ToolTip_Logic:LeaveBirthplace()
	NAApi:RegEvent(ToolTip_Logic,"UI_INFO_MESSAGE",ToolTip_Logic["NEW_AREA_MSG"])
	NAApi:RegEvent(ToolTip_Logic,"TAXIMAP_OPENED",ToolTip_Logic["TAXIMAP_OPENED"],true)
	-- 注销提示
	NAApi:UnregEvent(ToolTip_Logic,"GOSSIP_SHOW",ToolTip_Logic["GOSSIP_SHOW"])
	NAApi:UnregEvent(ToolTip_Logic,"QUEST_COMPLETE",ToolTip_Logic["QUEST_COMPLETE"])
	NAApi:UnregEvent(ToolTip_Logic,"QUEST_LOG_UPDATE",ToolTip_Logic["QUEST_LOG_UPDATE"])
	
	--NAApi:UnregEvent(ToolTip_Logic,"PLAYER_DEAD",ToolTip_Logic["PLAYER_DEAD"])
	-- 清空提示框
	TutorialSmallMsgFrame_Hide(-1)
	-- 充值框
	NewbieAssistantPanelPaymentTipFrame_Show()
	-- 启动小提示
	NewbieAssistantElfintipFrame_OnEvent(NewbieAssistantElfintipFrame)
end

function ToolTip_Logic:NEW_AREA_MSG(event, msg)
	local LocalRace, Race = UnitRace("player")
	if msg == L["NEW_AREA_MSG"][Race] then
		TutorialMiniFrame_Show(L["New Area Title"],L["NEW_AREA_MSG_CONTENT"][Race],"map")
		NAApi:UnregEvent(ToolTip_Logic,"UI_INFO_MESSAGE",ToolTip_Logic["NEW_AREA_MSG"])
	end
end

function ToolTip_Logic:TAXIMAP_OPENED()
	TutorialSmallMsgFrame_Show("LEFT","LEFT",TaxiRouteMap,"RIGHT",-50,0,L["How to use the Taxi Npc."],true)
end


-- 任务触发
function ToolTip_Logic:QUEST_ACCEPTED(event,...)
	index, QuestId = ...
	local LocalClass, class = UnitClass("player")
	local LocalRace, Race = UnitRace("player")
	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race] = NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race] or {}
	NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][class] = NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][class] or {}
	func = NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race][class][tostring(QuestId)]
	if func then
		if QuestFrame:IsShown() then
			local tinyMsgFrameId = TutorialTinyMsgFrame_Show("TOPLEFT","TOP",QuestFrameAcceptButton,"BOTTOMRIGHT",0,-10,L["LeftClick this button, accpet quest."])
			NAApi:SecureHook(QuestFrame,"Hide",function()
				TutorialTinyMsgFrame_Hide(tinyMsgFrameId)
				func()
			end,true)
		else
			func()
		end
	end
	NAApi:Sleep(1,function()
		-- 任务目标
		local numEntries = QuestMapUpdateAllQuests();
		local questCount = 0
		for i = 1, numEntries do
			questId, questLogIndex = QuestPOIGetQuestIDByVisibleIndex(i)
			if questLogIndex and questLogIndex > 0 then
				questCount = questCount + 1
				if questId == QuestId and NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race]["targetPic"] then
					local questName = GetQuestLogTitle(questLogIndex)
					local targetPic = NEWBIE_ASSISTANT_TUTORIAL_QUEST_DATA[Race]["targetPic"][questName]
					if targetPic then
						TutorialQuestObjPicFrame_Show(QuestId,targetPic)
					end
					break
				end
			end
		end
	end)
end

function ToolTip_Logic:QUEST_COMPLETE()
	local tinyMsgFrameId = TutorialTinyMsgFrame_Show("TOPLEFT","TOPLEFT",QuestFrameCompleteQuestButton,"BOTTOM",0,-10,L["LeftClick this button, complete quest."])
	NAApi:SecureHook("GetQuestMoneyToGet",function()
		TutorialTinyMsgFrame_Hide(tinyMsgFrameId)
		NAApi:SecureUnHook(QuestFrame,"Hide")
	end,true)
	NAApi:SecureHook(QuestFrame,"Hide",function()
		TutorialTinyMsgFrame_Hide(tinyMsgFrameId)
		NAApi:SecureUnHook("GetQuestMoneyToGet")
	end,true)
end

-- 角色死亡提示
function ToolTip_Logic:PLAYER_DEAD()
	ToolTip_Logic.deadSmallMsgFrameId = nil

	local function PLAYER_UNGHOST()
		TutorialSmallMsgFrame_Hide(ToolTip_Logic.deadSmallMsgFrameId)
		ToolTip_Logic.deadSmallMsgFrameId = nil
		NAApi:UnregEvent(ToolTip_Logic,"CORPSE_OUT_OF_RANGE",CORPSE_OUT_OF_RANGE)
		NAApi:UnregEvent(ToolTip_Logic,"CORPSE_IN_RANGE",CORPSE_IN_RANGE)
		NAApi:UnregEvent(ToolTip_Logic,"PLAYER_ALIVE",PLAYER_ALIVE)
	end

	local function CORPSE_OUT_OF_RANGE()
		TutorialSmallMsgFrame_Hide(ToolTip_Logic.deadSmallMsgFrameId)
	end

	local function CORPSE_IN_RANGE()
		TutorialSmallMsgFrame_Hide(ToolTip_Logic.deadSmallMsgFrameId)
		ToolTip_Logic.deadSmallMsgFrameId = TutorialSmallMsgFrame_Show("LEFT","LEFT",StaticPopup1,"RIGHT",0,0,L["Left-click this button will resurrect."],true)
		NAApi:RegEvent(ToolTip_Logic,"CORPSE_OUT_OF_RANGE",CORPSE_OUT_OF_RANGE,true)
		NAApi:RegEvent(ToolTip_Logic,"PLAYER_UNGHOST",PLAYER_UNGHOST,true)
		TutorialMiniFrame_Hide()
	end

	local function PLAYER_ALIVE()
		if UnitIsGhost("player") then
			TutorialSmallMsgFrame_Hide(ToolTip_Logic.deadSmallMsgFrameId)
			TutorialMiniFrame_Show(L["Player Dead Title"],L["press m find body`s pos."],"ghost",20)
			WorldMapCorpse:SetSize(30,30)
			NAApi:RegEvent(ToolTip_Logic,"CORPSE_IN_RANGE",CORPSE_IN_RANGE)
		else
			NAApi:UnregEvent(ToolTip_Logic,"PLAYER_ALIVE",PLAYER_ALIVE)
			TutorialSmallMsgFrame_Hide(ToolTip_Logic.deadSmallMsgFrameId)
		end
	end

	if UnitLevel("player")>10 then
		NAApi:UnregEvent(ToolTip_Logic,"PLAYER_DEAD",ToolTip_Logic["PLAYER_DEAD"])
		return
	end
	ToolTip_Logic.deadSmallMsgFrameId = TutorialSmallMsgFrame_Show("LEFT","LEFT",StaticPopup1,"RIGHT",0,0,L["You can Left-click this button release soul."],true)
	NAApi:RegEvent(ToolTip_Logic,"PLAYER_ALIVE",PLAYER_ALIVE)
	NAApi:RegEvent(ToolTip_Logic,"PLAYER_UNGHOST",PLAYER_UNGHOST,true)
	NAApi:RegEvent(ToolTip_Logic,"RESURRECT_REQUEST",CORPSE_IN_RANGE,true)
end

function ToolTip_Logic:TakeMoreQuest()
	TutorialMiniFrame_Show(L["More Quests Title"],L["you can take more than one quests at one time."],"multiquest",10)
	--NAApi:Sleep(5,TutorialMiniFrame_Hide)
end