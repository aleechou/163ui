local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� d=...
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
� � o(...)
� e.verbose � print("[verbose]",...)�
�
� � t(...)
� e.info � print("[verbose]",...)�
�
� � t(...)
� e.errro � print("[verbose]",...)�
�
� cmd3dcode_buff_showlog(a,t)
� a==� � a="verbose"�
� t==� � t=� �
e[a]=t
�
� a=0
� t=�
� n=0
� l=�
� i={
screenshot={
text="截图发送",
notCheckable=�,
func=�()
Cmd3DCode_Screenshot_Start()
�,
}
}
� � s(t,o)
� e=UIDropDownMenu_CreateInfo()
� t,a � pairs(t)�
e[t]=a
�
UIDropDownMenu_AddButton(e,o)
�
� � r(e,t)
� e=CreateFrame("Button",e,UIParent,"UIDropDownMenuTemplate")
e:ClearAllPoints()
e:SetPoint("CENTER",0,0)
e:Show()
UIDropDownMenu_Initialize(e,t,"MENU")
� e
�
� � h(a)
� e=CreateFrame("button","buff163uiLinkage_"..a,BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
� t=e:CreateTexture(�,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..d.."\\Textures\\logo-"..a..".tga")
t:SetAllPoints(e)
� e
�
h("online")
buff163uiLinkage_online:SetScript("OnEnter",�(i)
� o=""
� e=0
� a<60 �
o="不到1分钟"
�
e=floor(a/60)
� t=floor(e/60)
� t>0 �
o=t.."小时"
�
mindisplay=e%60
� mindisplay>0 �
o=o..mindisplay.."分钟"
�
�
GameTooltip:SetOwner(i,'ANCHOR_BOTTOMLEFT')
� t �
GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
�
GameTooltip:AddLine("有爱连接 |cffFFCC00[已连接，未登录]|r")
�
GameTooltip:AddLine('|cffffffff今日在线：|r'..o)
� � t �
GameTooltip:AddLine('|cffffffff请登陆网易通行证，|r')
GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
�
� l �
GameTooltip:AddLine('|cffffffff单击Buff图标完成签到|r')
�
� e<30 �
GameTooltip:AddLine('|cffffffff还有'..(30-e)..'分钟完成签到|r')
�
�
�
GameTooltip:AddLine('|cffffffff(可在有爱控制台>有爱设置里隐藏Buff)|r')
GameTooltip:Show()
�)
buff163uiLinkage_online:SetScript("OnLeave",�(e)
GameTooltip:Hide()
�)
buff163uiLinkage_online:SetScript("OnClick",�(e)
� e � e.menu �
ToggleDropDownMenu(1,�,e.menu,e:GetName(),0,0)
�
�)
buff163uiLinkage_online.menu=r("buff163uiLinkage_online",�(t,e)
s(i.screenshot,e)
�)
h("offline")
buff163uiLinkage_offline:SetScript("OnEnter",�(e)
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
GameTooltip:AddLine('|cffffffff在游戏时启动有爱客户端可保持有爱连接，|r')
GameTooltip:AddLine('|cffffffff并积累游戏时间用于签到或参与其他官方活动|r')
GameTooltip:AddLine('|cffffffff(可在有爱控制台>有爱设置里隐藏此Buff)|r')
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
buff163uiLinkage_offline:SetScript("OnClick",�(e)
� e � e.menu �
ToggleDropDownMenu(1,�,e.menu,e:GetName(),0,0)
�
� � ThreeDimensionsCode_IsFramesCreated()�
ThreeDimensionsCode_Tell_AllAddOnsLoaded()
�
� GetCVar("gxWindow")=="0"�
StaticPopup_Show("163UI-Linkage:ChangeWindowMode")
�
�)
buff163uiLinkage_offline:SetScript("OnLeave",�(e)
GameTooltip:Hide()
�)
buff163uiLinkage_offline.menu=r("buff163uiLinkage_offline",�(t,e)
s(i.screenshot,e)
�)
� � i()
� t={BuffFrame:GetChildren()}
� e=0
o("ShownBuffNumber()-------------")
� a,t � ipairs(t)�
� t:IsVisible()� t~=buff163uiLinkage_offline � t~=buff163uiLinkage_online �
e=e+1
�
�
e=e-DEBUFF_ACTUAL_DISPLAY
� t,i,i,a=GetWeaponEnchantInfo()
� t � e=e+1 �
� a � e=e+1 �
� ConsolidatedBuffs:IsVisible()�
e=e+1
�
o("ShownBuffNumber()",e)
� e
�
� � s(a)
� e=i()
� t=floor(e/BUFFS_PER_ROW)
� t=-t*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
� i=e%BUFFS_PER_ROW
� i=i*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
o("index:",e,"x",i,"y",t)
a:SetPoint("TOPRIGHT",i,t)
a:Show()
�
� � i(e)
� U1DB � U1DB.configs � U1DB.configs["!!!163ui!!!/displayLinkageStatusAsBuff"]=="_NIL"�
buff163uiLinkage_offline:Hide()
buff163uiLinkage_online:Hide()
�
�
� � e �
e=time()
�
� GetCVar("gxWindow")=="0"� e-n>=45 �
o("display offline buff")
buff163uiLinkage_offline:Show()
buff163uiLinkage_online:Hide()
s(buff163uiLinkage_offline)
�
o("display online buff")
buff163uiLinkage_online:Show()
buff163uiLinkage_offline:Hide()
s(buff163uiLinkage_online)
�
�
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors",i);
� s=0
CreateFrame("frame"):SetScript("OnUpdate",�()
� e=time()
� e-s>5 �
i(e)
s=e
�
�)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=�(s,e)
�#e<1 �
� t �
print("|cff00aa00有爱客户端已退出登录状态|r")
�
t=�
�
� � t �
print("|cff00aa00有爱客户端已登录网易通行证|r")
�
t=�
� i=string.byte(e:sub(1,1))
� n=string.byte(e:sub(2,2))
� t=0
� s=�
a=bitfunc.bor(bitfunc.lshift(n,8),i)
�#e>2 �
t=string.byte(e:sub(3,3))
� e=bitfunc.band(t,1)
a=bitfunc.bor(bitfunc.lshift(e,16),a)
�
o("ping","#"..#e,i,n,t,a)
�
i()
n=time()
�
� hide163buff()
buff163uiLinkage_online:Hide()
buff163uiLinkage_offline:Hide()
�
� cmd3dcode_lastPingTime()
� n
�
� Toggle3DCodeCmdBuff(e)
i()
�
]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()