local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� h="!!!163UI.3dcodecmd!!!"
� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� e={
verbose=�,
info=�,
errro=�,
}
� � n(...)
� e.verbose � print("[verbose]",...)�
�
� � t(...)
� e.info � print("[verbose]",...)�
�
� � t(...)
� e.errro � print("[verbose]",...)�
�
� cmd3dcode_buff_showlog(t,a)
� t==� � t="verbose"�
� a==� � a=� �
e[t]=a
�
� i=0
� o=�
� s=0
� r=�
� e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
� t=e:CreateTexture(�,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..h.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",�(n)
� t=""
� e=0
� i<60 �
t="不到1分钟"
�
e=floor(i/60)
� a=floor(e/60)
� a>0 �
t=a.."小时"
�
mindisplay=e%60
� mindisplay>0 �
t=t..mindisplay.."分钟"
�
�
GameTooltip:SetOwner(n,'ANCHOR_BOTTOMLEFT')
� o �
GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
�
GameTooltip:AddLine("有爱连接 |cffFFCC00[已连接，未登录]|r")
�
GameTooltip:AddLine('|cffffffff今日在线：|r'..t)
� � o �
GameTooltip:AddLine('|cffffffff请登陆网易通行证，|r')
GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
�
� r �
GameTooltip:AddLine('|cffffffff单击Buff图标完成签到|r')
�
� e<30 �
GameTooltip:AddLine('|cffffffff还有'..(30-e)..'分钟完成签到|r')
�
�
�
GameTooltip:Show()
�)
e:SetScript("OnLeave",�(e)
GameTooltip:Hide()
�)
e:SetScript("OnClick",�()
ThreeDimensionsCode_Send("checkin")
�)
� t=CreateFrame("button","buff163uiLinkage_offline",BuffFrame)
t:SetWidth(BUFF_BUTTON_HEIGHT)
t:SetHeight(BUFF_BUTTON_HEIGHT)
� a=t:CreateTexture(�,"BACKGROUND")
a:SetTexture("Interface\\AddOns\\"..h.."\\Textures\\logo-offline.tga")
a:SetAllPoints(t)
e.tooltip=CreateFrame("BUTTON","ConsolidatedBuffsTooltipBuff_buff163uiLinkage_online",ConsolidatedBuffsTooltip,"ConsolidatedBuffTemplate");
t:SetScript("OnEnter",�(e)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMLEFT')
GameTooltip:AddLine("有爱连接 |cffaaaaaa[断开]|r")
� � ThreeDimensionsCode_IsFramesCreated()�
GameTooltip:AddLine('|cFFFF0000有爱连接没有创建(可能受其他插件影响)|r')
GameTooltip:AddLine('|cFFFF0000请点击Buff手动建立连接|r')
� GetCVar("gxWindow")=='0'�
GameTooltip:AddLine('|cFFFF0000请点击Buff更改窗口模式|r')
�
GameTooltip:AddLine('|cFFFF0000未检测到有爱客户端，请启动有爱客户端|r')
�
GameTooltip:AddLine(' ')
GameTooltip:AddLine('|cffffffff在游戏时启动有爱客户端，|r')
GameTooltip:AddLine('|cffffffff可保持有爱连接，并积累|r')
GameTooltip:AddLine('|cffffffff游戏时间用于签到|r')
GameTooltip:AddLine('|cffffffff或参与其他官方活动|r')
GameTooltip:Show()
�)
StaticPopupDialogs["163UI-Linkage:ChangeWindowMode"]={
text="确定现在变更为全屏状态的窗口模式吗（不会重启WOW）？",
button1="立即生效",
button2="下次再说",
OnAccept=�()
SetCVar("gxWindow","1")
SetCVar("gxMaximize","1")
ConsoleExec("gxRestart")
�,
timeout=0,
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
}
t:SetScript("OnClick",�()
� � ThreeDimensionsCode_IsFramesCreated()�
ThreeDimensionsCode_Tell_AllAddOnsLoaded()
�
� GetCVar("gxWindow")=="0"�
StaticPopup_Show("163UI-Linkage:ChangeWindowMode")
�
�)
t:SetScript("OnLeave",�(e)
GameTooltip:Hide()
�)
� ShownBuffNumber()
� o={BuffFrame:GetChildren()}
� a=0
n("ShownBuffNumber()-------------")
� i,o � ipairs(o)�
� o:IsVisible()� o~=t � o~=e �
a=a+1
�
�
a=a-DEBUFF_ACTUAL_DISPLAY
� e,o,o,t=GetWeaponEnchantInfo()
� e � a=a+1 �
� t � a=a+1 �
n("ShownBuffNumber()",a)
� a
�
� � h(t)
� e=ShownBuffNumber()
� a=floor(e/BUFFS_PER_ROW)
� a=-a*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
� o=e%BUFFS_PER_ROW
� o=o*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
n("index:",e,"x",o,"y",a)
t:SetPoint("TOPRIGHT",o,a)
t:Show()
�
� � a(a)
� � a �
a=time()
�
� GetCVar("gxWindow")=="0"� a-s>=45 �
n("display offline buff")
t:Show()
e:Hide()
h(t)
�
n("display online buff")
e:Show()
t:Hide()
h(e)
�
�
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors",a);
� h=0
CreateFrame("frame"):SetScript("OnUpdate",�()
� e=time()
� e-h>5 �
a(e)
h=e
�
�)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=�(t,e)
�#e<1 �
� o �
print("|cff00aa00有爱客户端已退出登录状态|r")
�
o=�
�
� � o �
print("|cff00aa00有爱客户端已登录网易通行证|r")
�
o=�
� o=string.byte(e:sub(1,1))
� a=string.byte(e:sub(2,2))
� t=0
� s=�
i=bitfunc.bor(bitfunc.lshift(a,8),o)
�#e>2 �
t=string.byte(e:sub(3,3))
� e=bitfunc.band(t,1)
i=bitfunc.bor(bitfunc.lshift(e,16),i)
�
n("ping","#"..#e,o,a,t,i)
�
a()
s=time()
�
� hide163buff()
e:Hide()
t:Hide()
�
� cmd3dcode_lastPingTime()
� s
�]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()