local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� o="!!!163UI.3dcodecmd!!!"
� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� a=0
� i=�
� s=0
� e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
� t=e:CreateTexture(�,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",�(o)
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
GameTooltip:SetOwner(o,'ANCHOR_BOTTOMLEFT')
GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r")
GameTooltip:AddLine('|cffffffff今日在线：|r'..e)
� � i �
GameTooltip:AddLine('|cffffffff请点击Buff图标登陆网易通行证，|r')
GameTooltip:AddLine('|cffffffff以便积累的在线时间完成签到任务|r')
� t<30 �
GameTooltip:AddLine('|cffffffff还有'..(30-t)..'分钟完成签到|r')
�
GameTooltip:AddLine('|cffffffff单击Buff图标完成签到|r')
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
n:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-offline.tga")
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
� a~=� �
� t=a:find("/")
e=a:sub(1,t-1)
e=tonumber(e)
�
� e~=� � e>0 �
t=t-e+1
�
� e=floor(t/BUFFS_PER_ROW)
� a=-e*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
� e=t%BUFFS_PER_ROW
� e=e*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
o:SetPoint("TOPRIGHT",e,a)
o:Show()
�
� � o(a)
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
� e=BuffFrame_UpdateAllBuffAnchors
� BuffFrame_UpdateAllBuffAnchors(...)
e(...)
o()
�
� t=0
CreateFrame("frame"):SetScript("OnUpdate",�()
� e=time()
� e-t>5 �
o(e)
t=e
�
�)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=�(t,e)
�#e<1 �
i=�
�
i=�
� o=string.byte(e:sub(1,1))
� i=string.byte(e:sub(2,2))
� t=0
a=bitfunc.bor(bitfunc.lshift(i,8),o)
�#e>2 �
t=string.byte(e:sub(3,3))
a=bitfunc.bor(bitfunc.lshift(t,16),a)
�
�
o()
s=time()
�
]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()