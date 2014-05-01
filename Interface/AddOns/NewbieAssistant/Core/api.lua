-- Author      : s1172
-- Create Date : 2013/2/22 17:04:51

local NAApi = CreateFrame("frame", "NAApi")

NAApi.AddonName = "NewbieAssistant" -- 插件名称
NAApi.DBEventFunc = {} -- 事件库
NAApi.DBSecureHook = {} -- 钩子库

--- 注册事件
-- @param target 注入的目标Frame
-- @param event 事件名称
-- @param func  执行动作
-- @param oneTime 是否单次
function NAApi:RegEvent(target,event,func,oneTime)
	if type(target) == "table" and type(event) == "string" and event ~= "" and type(func) == "function" then
		if not target:IsEventRegistered(event) then
			target:RegisterEvent(event)
			target:SetScript("OnEvent",function(event, ...)
				event1, name = ...
				NAApi.DBEventFunc[target] = NAApi.DBEventFunc[target] or {}
				for i, k in pairs(NAApi.DBEventFunc[target]) do
					_event = i
					_func = nil
					_oneTime = nil

					for h,l in pairs(k) do
						_func = l[1]
						_oneTime = l[2]
					end

					if _event == event1 and (name == NAApi.AddonName or type(_func) == "function") then
						if _oneTime then
							NAApi:UnregEvent(target,_event,_func)
						end
						if _func then
							_func(event,...)
						end
					end
				end
			end)
		end
		
		NAApi.DBEventFunc[target] = NAApi.DBEventFunc[target] or {}
		NAApi.DBEventFunc[target][event] = NAApi.DBEventFunc[target][event] or {}
		local _store = NAApi.DBEventFunc[target][event][func]

		if not _store then
			NAApi.DBEventFunc[target][event][func] = setmetatable({},{_mode="k"})
			_store = NAApi.DBEventFunc[target][event][func]

			NAApi.DBEventFunc[target][event][func]={
				func,
				oneTime,
			}
		end
		return true
	else
		return false
	end
end

--- 注销事件
-- @param target 注入的目标Frame
-- @param event 事件名称
-- @param func  动作
function NAApi:UnregEvent(target,event,func)
	if type(target) == "table" and type(event) == "string" and type(func) == "function" then
		index = nil
		eventCount = 0
		targetCount = 0
		
		NAApi.DBEventFunc[target] = NAApi.DBEventFunc[target] or {}
		NAApi.DBEventFunc[target][event] = NAApi.DBEventFunc[target][event] or {}
		local _store = NAApi.DBEventFunc[target][event][func]

		if _store then
			NAApi.DBEventFunc[target][event][func]=nil

			for h,l in pairs(NAApi.DBEventFunc[target]) do
				targetCount = targetCount + 1
				for i,k in pairs(l) do
					eventCount = eventCount + 1
				end
			end

			if targetCount == 1 then
				NAApi.DBEventFunc[target]=nil
				target:UnregisterEvent(event)
			elseif eventCount == 1 then
				NAApi.DBEventFunc[target][event]=nil
				target:UnregisterEvent(event)
			end

		end
	end
end

--- 脚本钩子（安全)
-- @param target  目标func所在table
-- @param targetFunc  目标func名称
-- @param handler  执行动作
-- @param oneTime  是否一次性
function NAApi:SecureHook(target,targetFunc,handler,oneTime)
	if type(target) ~= "table" then
		target, targetFunc, handler, oneTime = _G, target, targetFunc, handler
	end

	if type(target) ~= "table" then
		print("Usage: NAApi:SecureHook([taget,] targetFunc[, handler]) - 'target' must be a table.")
	end

	if type(targetFunc) ~= "string" then
		print("Usage: NAApi:SecureHook([taget,] targetFunc[, handler]) - 'targetFunc' must be the name of the method.")
	end

	if type(target[targetFunc]) == "function" or (NAApi.DBSecureHook[target] and NAApi.DBSecureHook[target][targetFunc]) then
		NAApi.DBSecureHook[target] = NAApi.DBSecureHook[target] or {}

		local _store = NAApi.DBSecureHook[target][targetFunc]

		if not _store then
			NAApi.DBSecureHook[target][targetFunc]=setmetatable({},{_mode="k"})
			_store = NAApi.DBSecureHook[target][targetFunc]

			NAApi.DBSecureHook[target][targetFunc][0]=function(...)
				if _store[1] then
					for i,k in pairs(_store[1]) do
						if i~=0 and k.run and type(k.func) == "function" then
							if k.oneTime then
								_store[1]=nil
							end
							k.func(...)
						end
					end
				end
			end
			
			hooksecurefunc(target, targetFunc, NAApi.DBSecureHook[target][targetFunc][0])
		end

		_store[1]={{
			oneTime=oneTime,
			run=true,
			func=handler
		}}
	else
		print(("No method named '%s' can be found."):format(targetFunc))
	end
end

--- 注销脚本钩子（安全)
-- @param target  目标func所在table
-- @param targetFunc  目标func名称
function NAApi:SecureUnHook(target,targetFunc)
	if type(target) ~= "table" then
		target, targetFunc = _G, target
	end
	if type(target) ~= "table" then
		print("Usage: NAApi:SecureUnHook([taget,] targetFunc) - 'target' must be a table.")
	end
	if type(targetFunc) ~= "string" then
		print("Usage: NAApi:SecureUnHook([taget,] targetFunc) - 'targetFunc' must be the name of the method.")
	end

	if NAApi.DBSecureHook[target] then
		if type(targetFunc)=="string" then
			if NAApi.DBSecureHook[target][targetFunc] then
				NAApi.DBSecureHook[target][targetFunc][1]=nil
			end
		end
	end
end

--- 添加导航坐标
-- @param x,y 横纵坐标 c 描述 m 地图 f 楼层
-- @return nil.
function NAApi:AddWayPoint(x,y,c,m,f)
	x=tonumber(x)
	y=tonumber(y)
	desc=c
	if not m then
		local m, f = TomTom:GetCurrentPlayerPosition()
	end
    if m and x and y then
        TomTom:AddMFWaypoint(m, f, x/100, y/100, {
            title = desc
        })
    end
end

--- 只导航手动添加的坐标
-- @param x,y 横纵坐标 c 描述 m 地图 f 楼层
-- @param IsDisableAutoArrowQuest 导航完成后是否继续禁止自动任务
NAApi.WayPointFrame = CreateFrame("frame")
function NAApi:ShowUserWayPoint(x,y,c,m,f,IsDisableAutoArrowQuest)
	TomTomDB.profiles.Default.poi.setClosest = false
	TomTom:EnableDisablePOIIntegration()
	NAApi:AddWayPoint(x,y,c,m,f)
	if not IsDisableAutoArrowQuest then
		NAApi.WayPointFrame:SetScript("OnUpdate",function()
			if not TomTomCrazyArrow:IsShown() then
				NAApi.WayPointFrame:SetScript("OnUpdate",nil)
				TomTomDB.profiles.Default.poi.setClosest = true
				TomTom:EnableDisablePOIIntegration()
			end
		end)
	end
end

function NAApi:EnableQuestArrow()
	TomTomDB.profiles.Default.poi.setClosest = true
	TomTom:EnableDisablePOIIntegration()
end

--- 延迟执行
-- @param s 时间
-- @param handler function
function NAApi:Sleep(s,handler)
	if type(s)~="number" or type(handler)~="function" then
		print("Usage: NAApi:Sleep(s,handler) - 's' must be a number, 'handler' must be a function.")
	else
		local o=NAApi.Timer:new()
		o:Delay(s,handler)
	end
end

--- 重复执行
-- @param s 时间 
-- @param handler method 
-- @param t 重复次数
function NAApi:Repeat(s,handler,t)
	if type(s)~="number" or type(handler)~="function" then
		print("Usage: NAApi:Repeat(s,handler,t) - 's' must be a number, 't' must be a number, 'handler' must be a function.")
	else
		local o=NAApi.Timer:new()
		o:Repeat(s,handler,t)
	end
end

--- 获取人物等级
-- @param target UnitId
function NAApi:GetLvl(target)
	if type(target) == "string" then
		return UnitLevel(target)
	else
		print([[Usage: NAApi:GetLvl(target) - 'target' must be a string - The UnitId to query (e.g. "player", "party2", "pet", "target" etc.) ]])
	end
end

--- frame淡入淡出
-- @param target 目标frame
-- @param mode 模式，淡入：“IN”淡出：“OUT”
-- @param timeToFade 持续时间
-- @param callBackFunc 回调函数
function NAApi:UIFrameFade(target,mode,timeToFade,callBackFunc)
	if type(target) == "table" and type(mode) == "string" and type(timeToFade) == "number" and (not callBackFunc or type(callBackFunc) == "function") then
		UIFrameFade(target,{
			mode=mode,
			timeToFade=timeToFade,
			finishedFunc=callBackFunc
		})
	else
		print([[Usage: NAApi:UIFrameFade(target,mode,timeToFade,finishedFunc) - 'target' must be a frame, mode must be "OUT/IN", timeToFade must be a number, finishedFunc must be a function.]])
	end
end

--- 给指定FontString添加一行内容
-- @param frameText 需添加内容的frame.Text
-- @param addText 待添加的内容
function NAApi:AddLine(frameText,addText)
	oldText = frameText:GetText() or ""
	if string.len(oldText) > 0 then 
		enterStr="\n"
	else
		enterStr=""
	end

	newText = string.format("%s%s%s",oldText,enterStr,addText)
	frameText:SetText(newText)
end

--- 检查table是否为空
-- @param t 待检测的table
function NAApi:IsTableNull(t)
	for i,k in pairs(t) do
		if next(k) then
			return false
		end
	end

	return true
end

--- 检测t是否包含v
-- @param v待检测字段
function NAApi:IsInTable(v,t)
	for i,k in pairs(t) do
		if v==k then
			return true
		end
	end
	return false
end

--- 获取Json格式任务Id列表
-- @return Json
function NAApi:GetAllCompletedQuests()
	local function serialize(tbl)
		local tmp = {}
		for k, v in pairs(tbl) do
			local key = k
			tmp[#tmp + 1] = key and tostring(key) or nil
		end
		return "["..table.concat(tmp, ",").."]"  
	end
	t=GetQuestsCompleted()
	assert(type(t) == "table")
	return serialize(t)
end

--- 播放声音
-- @param url 声音文件路径
function NAApi:PlayMusic(url)
	if url then
		PlayMusic(url)
	end
end

--- 获取NPC ID
--@param guid
function NAApi:GetNpcIDByGUID(guid)
	if not guid then return end
	local valid_unit_types = {
		[0x003] = true, -- npcs
		[0x005] = true, -- vehicles
	}
	local unit_type = bit.band(tonumber("0x"..strsub(guid, 3, 5)), 0x00f)
	if not valid_unit_types[unit_type] then return end
	return tonumber("0x"..strsub(guid, 6, 10))
end

--- 获取数据
--@param key
function NAApi:GetAddonDB(key)
	if NewbieAssistantDB_Char then
		return NewbieAssistantDB_Char[key]
	end
end

--- 设置数据
--@param key, valu
function NAApi:SetAddonDB(key, value)
	if NewbieAssistantDB_Char then
		NewbieAssistantDB_Char[key] = value
	end
end

-- 初始化
NAApi:RegEvent(NAApi, "VARIABLES_LOADED", function() 
	NewbieAssistantDB_Char = NewbieAssistantDB_Char or {} 
end, true)

--- 字符串编码
function NAApi:URLEncode(obj)
	local currentIndex = 1
	local charArray = {}
	while currentIndex <= #obj do
		local char = string.byte(obj, currentIndex)
		charArray[currentIndex] = char
		currentIndex = currentIndex + 1
	end
	local converchar = ""
	for _, char in ipairs(charArray) do
		converchar = converchar..string.format("%%%X", char)
	end
	return converchar
end