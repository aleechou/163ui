-- 9月4日国服内测版 维护以后，GetAddOnInfo(),GetAddOnDependencies() 无法使用 name 作为参数

GetAddOnInfoByIdx = GetAddOnInfo

local mapAddOnName2Idx = {}
for i=1, GetNumAddOns() do
	local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
	mapAddOnName2Idx[name:lower()] = i
end

local function mkfunc(funcByIdx)
	return function(idxOrName)

		-- name 转换为 idx
		if type(idxOrName)=="string" then
			idxOrName = mapAddOnName2Idx[idxOrName:lower()]
			if not idxOrName then
				return
			end
		end

		return funcByIdx(idxOrName)
	end
end

GetAddOnInfo = mkfunc(GetAddOnInfo)
GetAddOnDependencies = mkfunc(GetAddOnDependencies)