-- Author      : s1172
-- Create Date : 2013/5/6 10:51:15

local api = CreateFrame("frame", "NAtPanel_API")

local itemIntfoCache = setmetatable({},{
	__index = function(t,v)
		local info
		while not info do
			info = {GetItemInfo(v)}
		end
		t[v] = info
		return info
	end
})

--- 获取物品信息
-- @param id 物品ID
-- @param index 内容序号
function api:GetItemInfo(id, index)
	local result = select(index, unpack(itemIntfoCache[id]))
	return result
end

local spellInfoCache = setmetatable({},{
	__index = function(t,v)
		local info
		while not info or #info == 0 do
			info = {GetSpellInfo(v)}
		end
		t[v] = info
		return info
	end
})

--- 获取法术信息
-- @param id 法术ID或名称
-- @param index 内容序号
function api:GetSpellInfo(id, index)
	local result=select(index, unpack(spellInfoCache[id]))
	return result
end

local spellLinkCache = setmetatable({},{
	__index = function(t,v)
		local info
		while not info do
			info = GetSpellLink(v)
		end
		t[v] = info
		return info
	end
})

--- 获取法术链接
-- @param id 法术ID或名称
function api:GetSpellLink(id)
	local result = spellLinkCache[id]
	return result
end