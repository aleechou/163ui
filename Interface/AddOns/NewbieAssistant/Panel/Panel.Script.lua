-- Author      : s1172
-- Create Date : 2013/4/8 15:40:20

local NAtPanel_Script = CreateFrame("frame", "NAtPanel_Script")

-- 内容模型
--NAtPanel_Script.Model = {
--	Id = nil, -- 任务、副本、装备等ID
--	Title = nil,
--	Type = nil, -- 任务：1，技能：2，专业：3，任务：4，装备介绍：5，试玩：6：战场 7：副本。
--	MapId = nil,-- 任务所属地图
--	IsPopup = nil,-- 是否自动弹出
--	Level = nil,-- 提示等级
--	Description = nil,-- 介绍
--	ModelId = nil,-- NPC的id
--	RewardId = {},-- 任务奖励等装备的id
--	Tooltip = {},-- 鼠标提示内容
--}

function NAtPanel_Script:ZONE_CHANGED_NEW_AREA()
	NAtPanel_Script.Cache[NewbieAssistantPannelFrame.level] = nil
end

NAApi:RegEvent(NAtPanel_Script,"ZONE_CHANGED_NEW_AREA",NAtPanel_Script["ZONE_CHANGED_NEW_AREA"])

NAtPanel_Script.Cache = setmetatable({},{
	__index = function(t,v)
		local data = NewbieAssitantPanelDisplayData["Toturial"][v]
		local item = NewbieAssitantPanelItemData[v]
		local showItem
		local map = GetMapInfo()

		if item then
			for i,k in pairs(item) do
				if k.Map == map then
					k.Description = "点击查看获取方式"
					k.Type = 4
					showItem = k
					break
				end
			end
		end

		local race = select(2, UnitRace("player"))
		local class = select(2, UnitClass("player"))
		local cache = {
			Mount = NewbieAssitantPanelDisplayData.Mount,
			PetBattle = NewbieAssitantPanelDisplayData.PetBattle,
			Talent = NewbieAssitantPanelDisplayData.Talent,
			Battleground = NewbieAssitantPanelDisplayData.Battleground,
			Dungeon = NewbieAssitantPanelDisplayData.Dungeon,
		}
		
		if data then
			cache.Description = data.Description
			cache.Title = data.Title

			for i = 1, #data do
				k = data[i]
				if not k then break end
				if k.Class or k.Race then
					if k.Class == class or k.Race == race then
						tinsert(cache, k)
					end
				elseif k.Map then
					local map = GetMapInfo()
					if k.Map == map then
						tinsert(cache, k)
					end
				else
					tinsert(cache, k)
				end
			end

			if #cache < 3 and showItem then
				tinsert(cache, showItem)
			end
		end

		t[v] = cache
		return cache
	end
})
