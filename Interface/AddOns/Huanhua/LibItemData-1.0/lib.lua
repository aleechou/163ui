--------------------------------------------------------------------------------
-- 文件名: lib.lua
-- 作   者: 盒子哥
-- 日	  期: 2012-03-01
-- 描	  述: 幻化装备数据接口
-- 版权所有 (c) 多玩游戏网
--------------------------------------------------------------------------------

local DataVersion = 20100912223826 or 1
local lib = LibStub:NewLibrary("LibItemData-1.0", DataVersion)

lib.data = HuanhuaItemData;

local FindItemCache = {}
setmetatable(FindItemCache, {__mode = "kv"})

local function tableFind(t, value)
	for i, id in pairs(t) do
		if (id == tonumber(value)) then
			return id;
		end
	end

	return false;
end

function lib:FindItem(itemID)
	if FindItemCache[itemID] then
		if FindItemCache[itemID] == 'nil' then
			return nil
		else
			local iType, subType, setName = string.match(FindItemCache[itemID], "(.+)|(.+)|(.+)");
			local tmpInfo = self.data[iType][subType][setName];
			return iType, subType, setName, tmpInfo;
		end
	else
		local itemName, itemLink, itemQuality = GetItemInfo(itemID);
		if (itemQuality < 2 or itemQuality>5) then
			FindItemCache[itemID] = 'nil';
			return nil;
		end		

		local iType, subType, setName;
		for t in pairs(self.data) do
			for tt, b in pairs(self.data[t]) do
				for name, ids in pairs(b) do
					local retVal = tableFind(ids, itemID);
					if (retVal) then
						iType, subType, setName = t, tt, name;
					end
				end
			end
		end
		
		if (iType) then			
			FindItemCache[itemID] = string.format("%s|%s|%s", iType, subType, setName);
		else
			FindItemCache[itemID] = "nil";
		end
		
		if iType then
			local tmpInfo = self.data[iType][subType][setName];
			return iType, subType, setName, tmpInfo;
		else
			return nil;
		end
	end
end