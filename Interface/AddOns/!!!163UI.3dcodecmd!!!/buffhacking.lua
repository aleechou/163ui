local addonName = "!!!163UI.3dcodecmd!!!"

if bit==nil and bit32~=nil then
	bitfunc = bit32
else
	bitfunc = bit
end


local show_log = {
	verbose = false ,
	info = false ,
	errro = true ,
}
local function verbose(...)
   if show_log.verbose then print("[verbose]",...) end
end
local function info(...)
   if show_log.info then print("[verbose]",...) end
end
local function error(...)
   if show_log.errro then print("[verbose]",...) end
end
function cmd3dcode_buff_showlog(name,show)
	if name==nil then name = "verbose" end
	if show==nil then show = true end
	show_log[name] = show
end



local todayGamingSec = 0
local hasLogin163 = false
local lastPingTime = 0
local todayCheckin = false




local buffMenuItemOpts = {
	screenshot = {
		text = "截图发送" ,
		notCheckable = true ,
		func = function()
			Cmd3DCode_Screenshot_Start()
		end ,
	} ,

	u1console = {
		text = "有爱控制台" ,
		notCheckable = true ,
		func = function()
			U1Frame:Show()
		end ,
	}
}
local function createMenuItem(itemopts,level)
	local info = UIDropDownMenu_CreateInfo()
	for k,v in pairs(itemopts) do
		info[k] = v
	end
	UIDropDownMenu_AddButton(info, level)
end
local function createMenu(name,itemsfunc)
	local menubtn = CreateFrame("Button", name, UIParent, "UIDropDownMenuTemplate")
	menubtn:ClearAllPoints()
	menubtn:SetPoint("TOPLEFT", UIParent, "BOTTOMRIGHT")
	menubtn:Show()
	UIDropDownMenu_Initialize(menubtn,itemsfunc,"MENU")
	return menubtn
end




local function createLinkageBuff(status)
	local buff = CreateFrame("button","buff163uiLinkage_"..status,BuffFrame)
	buff:SetWidth(BUFF_BUTTON_HEIGHT)
	buff:SetHeight(BUFF_BUTTON_HEIGHT)
	local texture = buff:CreateTexture(nil,"BACKGROUND")
	texture:SetTexture("Interface\\AddOns\\"..addonName.."\\Textures\\logo-"..status..".tga")
	texture:SetAllPoints(buff)
	return buff
end


createLinkageBuff("online")
buff163uiLinkage_online:SetScript("OnEnter",function(self)

	local timetext = "" 
	local min = 0

	if todayGamingSec<60 then
		timetext = "不到1分钟"
	else
		min = floor(todayGamingSec/60)
		local hor = floor(min/60)
		if hor>0 then
			timetext = hor.."小时"
		end
		
		mindisplay = min%60
		if mindisplay>0 then
			timetext = timetext .. mindisplay .. "分钟"
		end
	end
    GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT')

    if hasLogin163 then
	    GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
	else
	    GameTooltip:AddLine("有爱连接 |cffFFCC00[已连接，未登录]|r")
	end
    GameTooltip:AddLine('|cffffffff今日在线：|r'..timetext)

	-- 未登录163通行证
    if not hasLogin163 then
    	GameTooltip:AddLine('|cffffffff请登陆网易通行证，|r')
    	GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
   	-- 已登录163通行证
    else

    	-- 已经签到达成（由客户端报告）
    	if todayCheckin then
	    	GameTooltip:AddLine('|cffffffff单击Buff图标完成签到|r')
	    else
		    -- 未达到在线时间
	    	if min<30 then
	    		GameTooltip:AddLine('|cffffffff还有'..(30-min)..'分钟完成签到|r')
		    end
	    end
    end

    GameTooltip:AddLine('|cffffffff(可在有爱控制台>有爱设置里隐藏Buff)|r')

    GameTooltip:Show()
end)
buff163uiLinkage_online:SetScript("OnLeave",function(self)
	GameTooltip:Hide()
end)

buff163uiLinkage_online:SetScript("OnClick",function(self)
	if self and self.menu then
		ToggleDropDownMenu(1,nil,self.menu,self:GetName(),0,0)
	end
end)

buff163uiLinkage_online.menu = createMenu("buff163uiLinkage_online",function(self,level)
	createMenuItem(buffMenuItemOpts.u1console,level)
	createMenuItem(buffMenuItemOpts.screenshot,level)
end)


-- 163ui offline buff
createLinkageBuff("offline")

buff163uiLinkage_offline:SetScript("OnEnter",function(self)
    GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT')
    GameTooltip:AddLine("有爱连接 |cffaaaaaa[断开]|r")

    -- 检查窗口模式    
    if not ThreeDimensionsCode_IsFramesCreated() then
    	GameTooltip:AddLine('|cFFFF0000有爱连接没有创建(可能受其他插件影响)|r')
    	GameTooltip:AddLine('|cFFFF0000请点击Buff手动建立连接|r')
	elseif GetCVar("gxWindow")=='0' then
    	GameTooltip:AddLine('|cFFFF0000请点击Buff更改窗口模式|r')
	else
    	GameTooltip:AddLine('|cFFFF0000未检测到有爱客户端，请启动有爱客户端|r')
	end

    GameTooltip:AddLine(' ')
    GameTooltip:AddLine('|cffffffff在游戏时启动有爱客户端可保持有爱连接，|r')
    GameTooltip:AddLine('|cffffffff并积累游戏时间用于签到或参与其他官方活动|r')
    GameTooltip:AddLine('|cffffffff(可在有爱控制台>有爱设置里隐藏此Buff)|r')
    GameTooltip:Show()
end)

StaticPopupDialogs["163UI-Linkage:ChangeWindowMode"] = {
  text = "确定现在变更为全屏状态的窗口模式吗（不会重启WOW）？",
  button1 = "立即生效",
  button2 = "下次再说",
  OnAccept = function()
  	SetCVar("gxWindow","1")
  	SetCVar("gxMaximize","1")
    ConsoleExec("gxRestart")
  end,
  timeout = 0,
  whileDead = true,
  hideOnEscape = true,
  preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}
buff163uiLinkage_offline:SetScript("OnClick",function(self)

	if self and self.menu then
		ToggleDropDownMenu(1,nil,self.menu,self:GetName(),0,0)
	end

	-- 手动创建色块等frame
	if not ThreeDimensionsCode_IsFramesCreated() then
		ThreeDimensionsCode_Tell_AllAddOnsLoaded()
	end

	if GetCVar("gxWindow")=="0" then
		StaticPopup_Show ("163UI-Linkage:ChangeWindowMode")
	end
end)

buff163uiLinkage_offline:SetScript("OnLeave",function(self)
	GameTooltip:Hide()
end)

buff163uiLinkage_offline.menu = createMenu("buff163uiLinkage_offline",function(self,level)
	createMenuItem(buffMenuItemOpts.screenshot,level)
end)





local function ShownBuffNumber()
	local kids = { BuffFrame:GetChildren() }
	local num = 0
	verbose("ShownBuffNumber()-------------")
	for _, child in ipairs(kids) do
		-- verbose('buff icon:',child:IsVisible(),child:GetTop(),child~=buff163uiLinkage_offline,child~=buff163uiLinkage_online)
		if child:IsVisible() and child~=buff163uiLinkage_offline and child~=buff163uiLinkage_online then
			num = num + 1
			--local point, relativeTo, relativePoint, xOfs, yOfs = child:GetPoint()
			--verbose('visible buff positon:',child:GetNumPoints(),point, relativePoint, xOfs, yOfs)
		end
	end

	-- 去除 debuff
	num = num - DEBUFF_ACTUAL_DISPLAY

	-- 检查附魔武器buff (在BuffFrame 里占位，但不作为BuffFrame的child)
	local mainhand,_,_,offhand = GetWeaponEnchantInfo()
	if mainhand then num = num + 1 end
	if offhand then num = num + 1 end

	-- 检查团队buff整理
	if ConsolidatedBuffs:IsVisible() then
		num = num + 1
	end

	verbose("ShownBuffNumber()", num)

	return num
end


local function updateBuff(buff)

	local index = ShownBuffNumber()

   	local rowbase = floor(index/BUFFS_PER_ROW)
	local y = -rowbase*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
	local colbase = index%BUFFS_PER_ROW
	local x = colbase*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)

	verbose("index:",index,"x",x,"y",y)

	buff:SetPoint("TOPRIGHT",x,y)
	buff:Show()
end

local function update163UILinkageBuff(now)

	-- 控制台关闭选项
	if U1DB and U1DB.configs and U1DB.configs["!!!163ui!!!/displayLinkageStatusAsBuff"]=="_NIL" then
		buff163uiLinkage_offline:Hide()
		buff163uiLinkage_online:Hide()
		return
	end

	if not now then 
		now = time()
	end

	if GetCVar("gxWindow")=="0" or now-lastPingTime >= 45 then
		verbose("display offline buff")
		buff163uiLinkage_offline:Show()
		buff163uiLinkage_online:Hide()
		updateBuff(buff163uiLinkage_offline)
	else
		verbose("display online buff")
		buff163uiLinkage_online:Show()
		buff163uiLinkage_offline:Hide()
		updateBuff(buff163uiLinkage_online)
	end
end

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", update163UILinkageBuff);

local timerOnUpdate = 0
CreateFrame("frame"):SetScript("OnUpdate",function()
	local now = time()
	if now-timerOnUpdate>5 then -- 5秒检查一次 链接状态
		update163UILinkageBuff(now)
		timerOnUpdate = now
	end
end)


ThreeDimensionsCode_SafePipe_CmdHandles["ping"] = function (cmdid,arg)

	if #arg<1 then
		if hasLogin163 then
			print("|cff00aa00有爱客户端已退出登录状态|r")
		end
		hasLogin163 = false
		--print("ping unlogin")
	else

		if not hasLogin163 then
			print("|cff00aa00有爱客户端已登录网易通行证|r")
		end

		hasLogin163 = true

		local byte1 = string.byte(arg:sub(1,1))
		local byte2 = string.byte(arg:sub(2,2))
		local byte3 = 0
		local logined163passport = false

		todayGamingSec = bitfunc.bor( bitfunc.lshift(byte2,8), byte1 )

		-- 用3个字节发送时间
		if #arg>2 then
			byte3 = string.byte(arg:sub(3,3))
			local byte3_bit1 = bitfunc.band(byte3,1)	-- 第三个字节，只有第1位用于时间
			todayGamingSec = bitfunc.bor( bitfunc.lshift(byte3_bit1,16), todayGamingSec )

			-- 签到是否达成
		end

		verbose("ping","#"..#arg,byte1,byte2,byte3,todayGamingSec)
	end

	update163UILinkageBuff()
	lastPingTime = time()
end

function hide163buff()
	buff163uiLinkage_online:Hide()
	buff163uiLinkage_offline:Hide()
end

function cmd3dcode_lastPingTime()
	return lastPingTime
end


function Toggle3DCodeCmdBuff(v)
	update163UILinkageBuff()
end


function Cmd3DCode_CheckoutClient()
	return time()-lastPingTime < 45
end
function Cmd3DCode_CheckoutClientAndPrompt(message)
	if Cmd3DCode_CheckoutClient() then
		return true
	else
		message =  "|cFFCD853F"..(message or "没有检测到有爱客户端，无法完成操作，请启动有爱客户端继续。").."|r"
		for i=1,10 do
			if _G["ChatFrame"..i]:IsVisible() then
				_G["ChatFrame"..i]:AddMessage(message)
			end
		end
		return false
	end
end