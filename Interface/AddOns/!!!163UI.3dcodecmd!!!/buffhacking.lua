local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì o="!!!163UI.3dcodecmd!!!"
Ê bit==Í Á bit32~=Í Ò
bitfunc=bit32
Ä
bitfunc=bit
Æ
Ì e={
verbose=Ç,
info=Ç,
errro=Ó,
}
Ì É a(...)
Ê e.verbose Ò print("[verbose]",...)Æ
Æ
Ì É t(...)
Ê e.info Ò print("[verbose]",...)Æ
Æ
Ì É t(...)
Ê e.errro Ò print("[verbose]",...)Æ
Æ
É cmd3dcode_buff_showlog(t,a)
Ê t==Í Ò t="verbose"Æ
Ê a==Í Ò a=Ó Æ
e[t]=a
Æ
Ì n=0
Ì s=Ç
Ì h=0
Ì i=Ç
Ì e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
Ì t=e:CreateTexture(Í,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",É(o)
Ì e=""
Ì t=0
Ê n<60 Ò
e="ä¸åˆ°1åˆ†é’Ÿ"
Ä
t=floor(n/60)
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
Ê s Ò
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cff00aa00[å·²è¿æ¥]|r")
Ä
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffFFCC00[å·²è¿æ¥ï¼Œæœªç™»å½•]|r")
Æ
GameTooltip:AddLine('|cffffffffä»Šæ—¥åœ¨çº¿ï¼š|r'..e)
Ê Î s Ò
GameTooltip:AddLine('|cffffffffè¯·ç‚¹å‡»Buffå›¾æ ‡ç™»é™†ç½‘æ˜“é€šè¡Œè¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffä»¥ä¾¿ç§¯ç´¯çš„åœ¨çº¿æ—¶é—´å®Œæˆç­¾åˆ°ä»»åŠ¡|r')
Ä
Ê i Ò
GameTooltip:AddLine('|cffffffffå•å‡»Buffå›¾æ ‡å®Œæˆç­¾åˆ°|r')
Ä
Ê t<30 Ò
GameTooltip:AddLine('|cffffffffè¿˜æœ‰'..(30-t)..'åˆ†é’Ÿå®Œæˆç­¾åˆ°|r')
Æ
Æ
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
Ì i=t:CreateTexture(Í,"BACKGROUND")
i:SetTexture("Interface\\AddOns\\"..o.."\\Textures\\logo-offline.tga")
i:SetAllPoints(t)
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
É ShownBuffNumber()
Ì i={BuffFrame:GetChildren()}
Ì o=0
a("ShownBuffNumber()-------------")
È n,i Ë ipairs(i)Ã
a(i:IsVisible(),i:GetTop(),i~=t,i~=e)
Ê i:IsVisible()Á i~=t Á i~=e Ò
o=o+1
Æ
Æ
Ê ConsolidatedBuffs:IsVisible()Ò
a("ConsolidatedBuffs:IsVisible()",ConsolidatedBuffs:IsVisible())
o=o+1
Æ
o=o-DEBUFF_ACTUAL_DISPLAY
a("ShownBuffNumber()",o)
Ñ o
Æ
Ì É r(o)
Ì e=ShownBuffNumber()
Ì t=floor(e/BUFFS_PER_ROW)
Ì i=-t*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
Ì t=e%BUFFS_PER_ROW
Ì t=t*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
a("index:",e,"x",t,"y",i)
o:SetPoint("TOPRIGHT",t,i)
o:Show()
Æ
Ì É i(o)
Ê Î o Ò
o=time()
Æ
Ê o-h>=45 Ò
a("display offline buff")
t:Show()
e:Hide()
r(t)
Ä
a("display online buff")
e:Show()
t:Hide()
r(e)
Æ
Æ
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors",i);
Ì o=0
CreateFrame("frame"):SetScript("OnUpdate",É()
Ì e=time()
Ê e-o>5 Ò
i(e)
o=e
Æ
Æ)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=É(t,e)
Ê#e<1 Ò
Ê s Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²é€€å‡ºç™»å½•çŠ¶æ€|r")
Æ
s=Ç
Ä
Ê Î s Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²ç™»å½•ç½‘æ˜“é€šè¡Œè¯|r")
Æ
s=Ó
Ì o=string.byte(e:sub(1,1))
Ì i=string.byte(e:sub(2,2))
Ì t=0
Ì s=Ç
n=bitfunc.bor(bitfunc.lshift(i,8),o)
Ê#e>2 Ò
t=string.byte(e:sub(3,3))
Ì e=bitfunc.band(t,1)
n=bitfunc.bor(bitfunc.lshift(e,16),n)
Æ
a("ping","#"..#e,o,i,t,n)
Æ
i()
h=time()
Æ
É hide163buff()
e:Hide()
t:Hide()
Æ
É cmd3dcode_lastPingTime()
Ñ h
Æ]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()