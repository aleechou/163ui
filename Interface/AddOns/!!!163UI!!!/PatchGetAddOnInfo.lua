-- 9月4日国服内测版 维护以后，GetAddOnInfo() 无法使用 name 作为参数

GetAddOnInfoByIdx = GetAddOnInfo

local mapAddOnName2Idx = {}
for i=1, GetNumAddOns() do
	local name = GetAddOnInfo(i)
	mapAddOnName2Idx[name] = i
end
function GetAddOnInfoByName(name)
	if mapAddOnName2Idx[name] then
		return GetAddOnInfoByIdx(mapAddOnName2Idx[name])
	end
end

GetAddOnInfo = function (idxOrName)
	return (type(idxOrName)=="string" and GetAddOnInfoByName or GetAddOnInfoByIdx) (idxOrName)
end
