local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì n="!!!163UI.3dcodecmd!!!"
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
Ì É i(...)
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
Ì a=0
Ì o=Ç
Ì h=0
Ì s=Ç
Ì e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
Ì t=e:CreateTexture(Í,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..n.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",É(i)
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
GameTooltip:SetOwner(i,'ANCHOR_BOTTOMLEFT')
Ê o Ò
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cff00aa00[å·²è¿æ¥]|r")
Ä
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffFFCC00[å·²è¿æ¥ï¼Œæœªç™»å½•]|r")
Æ
GameTooltip:AddLine('|cffffffffä»Šæ—¥åœ¨çº¿ï¼š|r'..e)
Ê Î o Ò
GameTooltip:AddLine('|cffffffffè¯·ç‚¹å‡»Buffå›¾æ ‡ç™»é™†ç½‘æ˜“é€šè¡Œè¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffä»¥ä¾¿ç§¯ç´¯çš„åœ¨çº¿æ—¶é—´å®Œæˆç­¾åˆ°ä»»åŠ¡|r')
Ä
Ê s Ò
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
Ì s=t:CreateTexture(Í,"BACKGROUND")
s:SetTexture("Interface\\AddOns\\"..n.."\\Textures\\logo-offline.tga")
s:SetAllPoints(t)
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
Ì É s(o,t)
Ì a=ConsolidatedBuffsCount:GetText()
Ì e=0
Ê ConsolidatedBuffs:IsVisible()Ò
i("ConsolidatedBuffs:IsVisible() true",a)
Ê a~=Í Ò
Ì t=a:find("/")
e=a:sub(1,t-1)
e=tonumber(e)
i("consolidated",e)
Æ
Ê e~=Í Á e>0 Ò
t=t-e+1
Æ
Æ
Ì e=floor(t/BUFFS_PER_ROW)
Ì e=-e*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
Ì a=t%BUFFS_PER_ROW
Ì a=a*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
i("index:",t,"x",a,"y",e)
o:SetPoint("TOPRIGHT",a,e)
o:Show()
Æ
Ì É n(a)
Ê Î a Ò
a=time()
Æ
Ê a-h>=15 Ò
i("display offline buff")
t:Show()
e:Hide()
s(t,BUFF_ACTUAL_DISPLAY)
Ä
i("display online buff")
e:Show()
t:Hide()
s(e,BUFF_ACTUAL_DISPLAY)
Æ
Æ
Ì s=BuffFrame_UpdateAllBuffAnchors
É BuffFrame_UpdateAllBuffAnchors(...)
s(...)
n()
Æ
Ì s=0
CreateFrame("frame"):SetScript("OnUpdate",É()
Ì e=time()
Ê e-s>5 Ò
n(e)
s=e
Æ
Æ)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=É(t,e)
Ê#e<1 Ò
Ê o Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²é€€å‡ºç™»å½•çŠ¶æ€|r")
Æ
o=Ç
Ä
Ê Î o Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²ç™»å½•ç½‘æ˜“é€šè¡Œè¯|r")
Æ
o=Ó
Ì n=string.byte(e:sub(1,1))
Ì o=string.byte(e:sub(2,2))
Ì t=0
Ì s=Ç
a=bitfunc.bor(bitfunc.lshift(o,8),n)
Ê#e>2 Ò
t=string.byte(e:sub(3,3))
Ì e=bitfunc.band(t,1)
a=bitfunc.bor(bitfunc.lshift(e,16),a)
Æ
i("ping","#"..#e,n,o,t,a)
Æ
n()
h=time()
Æ
É hide163buff()
e:Hide()
t:Hide()
Æ]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()