local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� i="!!!163UI.3dcodecmd!!!"
� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� o=0
� a=�
� s=0
� n=�
� e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
� t=e:CreateTexture(�,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",�(i)
� e=""
� t=0
� o<60 �
e="不到1分钟"
�
t=floor(o/60)
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
� a �
GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
�
GameTooltip:AddLine("有爱连接 |cffFFCC00[已连接，未登录]|r")
�
GameTooltip:AddLine('|cffffffff今日在线：|r'..e)
� � a �
GameTooltip:AddLine('|cffffffff请点击Buff图标登陆网易通行证，|r')
GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
�
� n �
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
� n=t:CreateTexture(�,"BACKGROUND")
n:SetTexture("Interface\\AddOns\\"..i.."\\Textures\\logo-offline.tga")
n:SetAllPoints(t)
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
� � n(o,t)
� a=ConsolidatedBuffsCount:GetText()
� e=0
� ConsolidatedBuffs:IsVisible()�
� a~=� �
� t=a:find("/")
e=a:sub(1,t-1)
e=tonumber(e)
�
� e~=� � e>0 �
t=t-e+1
�
�
� e=floor(t/BUFFS_PER_ROW)
� e=-e*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
� t=t%BUFFS_PER_ROW
� t=t*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
o:SetPoint("TOPRIGHT",t,e)
o:Show()
�
� � i(a)
� � a �
a=time()
�
� a-s>=15 �
t:Show()
e:Hide()
n(t,BUFF_ACTUAL_DISPLAY)
�
e:Show()
t:Hide()
n(e,BUFF_ACTUAL_DISPLAY)
�
�
� n=BuffFrame_UpdateAllBuffAnchors
� BuffFrame_UpdateAllBuffAnchors(...)
n(...)
i()
�
� n=0
CreateFrame("frame"):SetScript("OnUpdate",�()
� e=time()
� e-n>5 �
i(e)
n=e
�
�)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=�(t,e)
�#e<1 �
� a �
print("|cff00aa00有爱客户端已退出登录状态|r")
�
a=�
�
� � a �
print("|cff00aa00有爱客户端已登录网易通行证|r")
�
a=�
� a=string.byte(e:sub(1,1))
� i=string.byte(e:sub(2,2))
� t=0
� n=�
o=bitfunc.bor(bitfunc.lshift(i,8),a)
�#e>2 �
t=string.byte(e:sub(3,3))
� e=bitfunc.band(t,1)
o=bitfunc.bor(bitfunc.lshift(e,16),o)
�
�
i()
s=time()
�
� hide163buff()
e:Hide()
t:Hide()
�
]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()