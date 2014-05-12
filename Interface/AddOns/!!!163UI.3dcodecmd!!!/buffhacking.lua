local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� n="!!!163UI.3dcodecmd!!!"
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
� � i(...)
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
� a=0
� o=�
� h=0
� s=�
� e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
� t=e:CreateTexture(�,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..n.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",�(i)
� e=""
� t=0
� a<60 �
e="不到1分钟"
�
t=floor(a/60)
� a=floor(t/60)
� a>0 �
e=a.."小时"
�
mindisplay=t%60
� mindisplay>0 �
e=e..mindisplay.."分钟"
�
�
GameTooltip:SetOwner(i,'ANCHOR_BOTTOMLEFT')
� o �
GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
�
GameTooltip:AddLine("有爱连接 |cffFFCC00[已连接，未登录]|r")
�
GameTooltip:AddLine('|cffffffff今日在线：|r'..e)
� � o �
GameTooltip:AddLine('|cffffffff请点击Buff图标登陆网易通行证，|r')
GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
�
� s �
GameTooltip:AddLine('|cffffffff单击Buff图标完成签到|r')
�
� t<30 �
GameTooltip:AddLine('|cffffffff还有'..(30-t)..'分钟完成签到|r')
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
� s=t:CreateTexture(�,"BACKGROUND")
s:SetTexture("Interface\\AddOns\\"..n.."\\Textures\\logo-offline.tga")
s:SetAllPoints(t)
e.tooltip=CreateFrame("BUTTON","ConsolidatedBuffsTooltipBuff_buff163uiLinkage_online",ConsolidatedBuffsTooltip,"ConsolidatedBuffTemplate");
t:SetScript("OnEnter",�(e)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMLEFT')
GameTooltip:AddLine("有爱连接 |cffaaaaaa[断开]|r")
GameTooltip:AddLine('|cffffffff在游戏时启动有爱客户端，|r')
GameTooltip:AddLine('|cffffffff可保持有爱连接，并积累|r')
GameTooltip:AddLine('|cffffffff游戏时间用于签到|r')
GameTooltip:AddLine('|cffffffff或参与其他官方活动|r')
GameTooltip:Show()
�)
t:SetScript("OnLeave",�(e)
GameTooltip:Hide()
�)
� � s(o,t)
� a=ConsolidatedBuffsCount:GetText()
� e=0
� ConsolidatedBuffs:IsVisible()�
i("ConsolidatedBuffs:IsVisible() true",a)
� a~=� �
� t=a:find("/")
e=a:sub(1,t-1)
e=tonumber(e)
i("consolidated",e)
�
� e~=� � e>0 �
t=t-e+1
�
�
� e=floor(t/BUFFS_PER_ROW)
� e=-e*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
� a=t%BUFFS_PER_ROW
� a=a*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
i("index:",t,"x",a,"y",e)
o:SetPoint("TOPRIGHT",a,e)
o:Show()
�
� � n(a)
� � a �
a=time()
�
� a-h>=15 �
i("display offline buff")
t:Show()
e:Hide()
s(t,BUFF_ACTUAL_DISPLAY)
�
i("display online buff")
e:Show()
t:Hide()
s(e,BUFF_ACTUAL_DISPLAY)
�
�
� s=BuffFrame_UpdateAllBuffAnchors
� BuffFrame_UpdateAllBuffAnchors(...)
s(...)
n()
�
� s=0
CreateFrame("frame"):SetScript("OnUpdate",�()
� e=time()
� e-s>5 �
n(e)
s=e
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
� n=string.byte(e:sub(1,1))
� o=string.byte(e:sub(2,2))
� t=0
� s=�
a=bitfunc.bor(bitfunc.lshift(o,8),n)
�#e>2 �
t=string.byte(e:sub(3,3))
� e=bitfunc.band(t,1)
a=bitfunc.bor(bitfunc.lshift(e,16),a)
�
i("ping","#"..#e,n,o,t,a)
�
n()
h=time()
�
� hide163buff()
e:Hide()
t:Hide()
�]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()