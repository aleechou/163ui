local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� o="!!!163UI.3dcodecmd!!!"
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
� � a(...)
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
� n=0
� s=�
� h=0
� i=�
� e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
� t=e:CreateTexture(�,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",�(o)
� t=""
� e=0
� n<60 �
t="不到1分钟"
�
e=floor(n/60)
� a=floor(e/60)
� a>0 �
t=a.."小时"
�
mindisplay=e%60
� mindisplay>0 �
t=t..mindisplay.."分钟"
�
�
GameTooltip:SetOwner(o,'ANCHOR_BOTTOMLEFT')
� s �
GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
�
GameTooltip:AddLine("有爱连接 |cffFFCC00[已连接，未登录]|r")
�
GameTooltip:AddLine('|cffffffff今日在线：|r'..t)
� � s �
GameTooltip:AddLine('|cffffffff请点击Buff图标登陆网易通行证，|r')
GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
�
� i �
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
� i=t:CreateTexture(�,"BACKGROUND")
i:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-offline.tga")
i:SetAllPoints(t)
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
� ShownBuffNumber()
� i={BuffFrame:GetChildren()}
� o=0
a("ShownBuffNumber()-------------")
� n,i � ipairs(i)�
a(i:IsVisible(),i:GetTop(),i~=t,i~=e)
� i:IsVisible()� i~=t � i~=e �
o=o+1
�
�
� ConsolidatedBuffs:IsVisible()�
a("ConsolidatedBuffs:IsVisible()",ConsolidatedBuffs:IsVisible())
o=o+1
�
o=o-DEBUFF_ACTUAL_DISPLAY
a("ShownBuffNumber()",o)
� o
�
� � i(t)
� e=ShownBuffNumber()
� o=floor(e/BUFFS_PER_ROW)
� i=-o*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
� o=e%BUFFS_PER_ROW
� o=o*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
a("index:",e,"x",o,"y",i)
t:SetPoint("TOPRIGHT",o,i)
t:Show()
�
� � o(o)
� � o �
o=time()
�
� o-h>=45 �
a("display offline buff")
t:Show()
e:Hide()
i(t)
�
a("display online buff")
e:Show()
t:Hide()
i(e)
�
�
� i=BuffFrame_UpdateAllBuffAnchors
� BuffFrame_UpdateAllBuffAnchors(...)
i(...)
o()
�
� i=0
CreateFrame("frame"):SetScript("OnUpdate",�()
� e=time()
� e-i>5 �
o(e)
i=e
�
�)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=�(t,e)
�#e<1 �
� s �
print("|cff00aa00有爱客户端已退出登录状态|r")
�
s=�
�
� � s �
print("|cff00aa00有爱客户端已登录网易通行证|r")
�
s=�
� o=string.byte(e:sub(1,1))
� i=string.byte(e:sub(2,2))
� t=0
� s=�
n=bitfunc.bor(bitfunc.lshift(i,8),o)
�#e>2 �
t=string.byte(e:sub(3,3))
� e=bitfunc.band(t,1)
n=bitfunc.bor(bitfunc.lshift(e,16),n)
�
a("ping","#"..#e,o,i,t,n)
�
o()
h=time()
�
� hide163buff()
e:Hide()
t:Hide()
�
� cmd3dcode_lastPingTime()
� h
�]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()