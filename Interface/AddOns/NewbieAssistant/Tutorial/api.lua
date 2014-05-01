-- Author      : s1172
-- Create Date : 2013/2/25 14:42:10

local TutorialApi=CreateFrame("frame","TutorialApi")

TutorialApi.Localization={}

--- Returns localized string
-- @param str The string to localize.
-- @return The localized string.
function TutorialApi:Localize(str)
	return self.Localization[str]
end

--- 获取运行状态
-- @return 返回NewbieAssistantDB_Char["Enable"]
function TutorialApi:UIStatus()
	return NAApi:GetAddonDB("Enable")
end

--- 设置运行状态
-- @param status = true/false
function TutorialApi:SetUIStatus(status)
	NAApi:SetAddonDB("Enable", status)
end

function TutorialApi:HideAllFrame()
	NewbieTutorialToolTip_Hide(TutorialTipFrame)
	NewbieTutorialToolTip_Hide(TutorialTipFrame1)
	NewbieTutorialToolTip_Hide(TutorialTipFrame2)
end

--- 获取装备位置
-- @return 装备所在背包位置的button名称
function TutorialApi:GetItemLocation()
	local itemLocation = nil
	local slotId = {
		1,--头
		2,--项链
		3,--肩膀
		5,--衣服
		6,--腰带
		7,--腿
		8,--鞋子
		9,--手腕
		10,--手套
		11,--戒指
		12,--戒指
		13,--饰品
		14,--饰品
		15,--披风
		16,--主手
		17,--副手
		18,--远程
	}
	local itemIndex = 1000

	for i,k in pairs(slotId) do
		local slotItem = {}
		GetInventoryItemsForSlot(k,slotItem)
		for	j,l in pairs(slotItem) do
			if not IsEquippedItem(l) then
				local _, _, _, _, slot, bagId = EquipmentManager_UnpackLocation(j)
				local maxSlot = GetContainerNumSlots(bagId)
				if maxSlot-slot+bagId < itemIndex then
					itemLocation = self:GetBagSlotName(bagId,slot)--"ContainerFrame"..(bagId + 1).."Item"..(maxSlot-slot+1)
					--if not _G[itemLocation] then
					--	itemLocation = "BaudBagSubBag"..(bagId + 1).."Item"..(maxSlot-slot+1)
					--end
					itemIndex = maxSlot-slot+bagId
				end
			end
		end
	end
	
	return itemLocation
end


function TutorialApi:GetBagSlotName(bagId,slotId)
	if IsAddOnLoaded("Combuctor") then
		local max=0
		for i=0,4 do
			max=max+GetContainerNumSlots(i)
		end
		for i=1,max do
			local btn = _G["CombuctorItem"..i]
			if btn then
				local _,bag,slot=btn:GetSlotInfo()
				if bag==bagId and slot==slotId then
					return "CombuctorItem"..i
				end
			end
		end
		return "CombuctorFrame1IconButton"
	else
		local maxSlot = GetContainerNumSlots(bagId)
		return "ContainerFrame"..(bagId + 1).."Item"..(maxSlot-slotId+1)
	end
end

