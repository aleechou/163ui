local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì o="!!!163UI.3dcodecmd!!!"
Ê bit==Í Á bit32~=Í Ò
bitfunc=bit32
Ä
bitfunc=bit
Æ
Ì a=0
Ì i=Ç
Ì s=0
Ì e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
Ì t=e:CreateTexture(Í,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",É(o)
Ì e=""
Ì t=0
Ê a<60 Ò
e="ä¸åˆ°1åˆ†é’Ÿ"
Ä
t=floor(a/60)
Ì a=floor(t/60)
Ê a>0 Ò
e=a.."å°æ—¶"
Æ
mindisplay=t%60
Ê mindisplay>0 Ò
e=e..mindisplay.."åˆ†é’Ÿ"
Æ
Æ
GameTooltip:SetOwner(o,'ANCHOR_BOTTOMLEFT')
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cff00aa00[å·²è¿æ¥]|r")
GameTooltip:AddLine('|cffffffffä»Šæ—¥åœ¨çº¿ï¼š|r'..e)
Ê Î i Ò
GameTooltip:AddLine('|cffffffffè¯·ç‚¹å‡»Buffå›¾æ ‡ç™»é™†ç½‘æ˜“é€šè¡Œè¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffä»¥ä¾¿ç§¯ç´¯çš„åœ¨çº¿æ—¶é—´å®Œæˆç­¾åˆ°ä»»åŠ¡|r')
Å t<30 Ò
GameTooltip:AddLine('|cffffffffè¿˜æœ‰'..(30-t)..'åˆ†é’Ÿå®Œæˆç­¾åˆ°|r')
Ä
GameTooltip:AddLine('|cffffffffå•å‡»Buffå›¾æ ‡å®Œæˆç­¾åˆ°|r')
Æ
GameTooltip:Show()
Æ)
e:SetScript("OnLeave",É(e)
GameTooltip:Hide()
Æ)
e:SetScript("OnClick",É()
ThreeDimensionsCode_Send("checkin")
Æ)
Ì t=CreateFrame("button","buff163uiLinkage_offline",BuffFrame)
t:SetWidth(BUFF_BUTTON_HEIGHT)
t:SetHeight(BUFF_BUTTON_HEIGHT)
Ì n=t:CreateTexture(Í,"BACKGROUND")
n:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-offline.tga")
n:SetAllPoints(t)
e.tooltip=CreateFrame("BUTTON","ConsolidatedBuffsTooltipBuff_buff163uiLinkage_online",ConsolidatedBuffsTooltip,"ConsolidatedBuffTemplate");
t:SetScript("OnEnter",É(e)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMLEFT')
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffaaaaaa[æ–­å¼€]|r")
GameTooltip:AddLine('|cffffffffåœ¨æ¸¸æˆæ—¶å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffå¯ä¿æŒæœ‰çˆ±è¿æ¥ï¼Œå¹¶ç§¯ç´¯|r')
GameTooltip:AddLine('|cffffffffæ¸¸æˆæ—¶é—´ç”¨äºç­¾åˆ°|r')
GameTooltip:AddLine('|cffffffffæˆ–å‚ä¸å…¶ä»–å®˜æ–¹æ´»åŠ¨|r')
GameTooltip:Show()
Æ)
t:SetScript("OnLeave",É(e)
GameTooltip:Hide()
Æ)
Ì É n(o,t)
Ì a=ConsolidatedBuffsCount:GetText()
Ì e=0
Ê a~=Í Ò
Ì t=a:find("/")
e=a:sub(1,t-1)
e=tonumber(e)
Æ
Ê e~=Í Á e>0 Ò
t=t-e+1
Æ
Ì e=floor(t/BUFFS_PER_ROW)
Ì a=-e*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
Ì e=t%BUFFS_PER_ROW
Ì e=e*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
o:SetPoint("TOPRIGHT",e,a)
o:Show()
Æ
Ì É o(a)
Ê Î a Ò
a=time()
Æ
Ê a-s>=15 Ò
t:Show()
e:Hide()
n(t,BUFF_ACTUAL_DISPLAY)
Ä
e:Show()
t:Hide()
n(e,BUFF_ACTUAL_DISPLAY)
Æ
Æ
Ì e=BuffFrame_UpdateAllBuffAnchors
É BuffFrame_UpdateAllBuffAnchors(...)
e(...)
o()
Æ
Ì t=0
CreateFrame("frame"):SetScript("OnUpdate",É()
Ì e=time()
Ê e-t>5 Ò
o(e)
t=e
Æ
Æ)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=É(t,e)
Ê#e<1 Ò
i=Ç
Ä
i=Ó
Ì o=string.byte(e:sub(1,1))
Ì i=string.byte(e:sub(2,2))
Ì t=0
a=bitfunc.bor(bitfunc.lshift(i,8),o)
Ê#e>2 Ò
t=string.byte(e:sub(3,3))
a=bitfunc.bor(bitfunc.lshift(t,16),a)
Æ
Æ
o()
s=time()
Æ
]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()