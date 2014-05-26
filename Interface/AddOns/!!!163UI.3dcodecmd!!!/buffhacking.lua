local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì h="!!!163UI.3dcodecmd!!!"
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
Ì É n(...)
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
Ì i=0
Ì o=Ç
Ì s=0
Ì r=Ç
Ì e=CreateFrame("button","buff163uiLinkage_online",BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
Ì t=e:CreateTexture(Í,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..h.."\\Textures\\logo-online.tga")
t:SetAllPoints(e)
e:SetScript("OnEnter",É(n)
Ì t=""
Ì e=0
Ê i<60 Ò
t="ä¸åˆ°1åˆ†é’Ÿ"
Ä
e=floor(i/60)
Ì a=floor(e/60)
Ê a>0 Ò
t=a.."å°æ—¶"
Æ
mindisplay=e%60
Ê mindisplay>0 Ò
t=t..mindisplay.."åˆ†é’Ÿ"
Æ
Æ
GameTooltip:SetOwner(n,'ANCHOR_BOTTOMLEFT')
Ê o Ò
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cff00aa00[å·²è¿æ¥]|r")
Ä
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffFFCC00[å·²è¿æ¥ï¼Œæœªç™»å½•]|r")
Æ
GameTooltip:AddLine('|cffffffffä»Šæ—¥åœ¨çº¿ï¼š|r'..t)
Ê Î o Ò
GameTooltip:AddLine('|cffffffffè¯·ç™»é™†ç½‘æ˜“é€šè¡Œè¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffä»¥ä¾¿ç§¯ç´¯çš„åœ¨çº¿æ—¶é—´å®Œæˆç­¾åˆ°ä»»åŠ¡|r')
Ä
Ê r Ò
GameTooltip:AddLine('|cffffffffå•å‡»Buffå›¾æ ‡å®Œæˆç­¾åˆ°|r')
Ä
Ê e<30 Ò
GameTooltip:AddLine('|cffffffffè¿˜æœ‰'..(30-e)..'åˆ†é’Ÿå®Œæˆç­¾åˆ°|r')
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
Ì a=t:CreateTexture(Í,"BACKGROUND")
a:SetTexture("Interface\\AddOns\\"..h.."\\Textures\\logo-offline.tga")
a:SetAllPoints(t)
e.tooltip=CreateFrame("BUTTON","ConsolidatedBuffsTooltipBuff_buff163uiLinkage_online",ConsolidatedBuffsTooltip,"ConsolidatedBuffTemplate");
t:SetScript("OnEnter",É(e)
GameTooltip:SetOwner(e,'ANCHOR_BOTTOMLEFT')
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffaaaaaa[æ–­å¼€]|r")
Ê Î ThreeDimensionsCode_IsFramesCreated()Ò
GameTooltip:AddLine('|cFFFF0000æœ‰çˆ±è¿æ¥æ²¡æœ‰åˆ›å»º(å¯èƒ½å—å…¶ä»–æ’ä»¶å½±å“)|r')
GameTooltip:AddLine('|cFFFF0000è¯·ç‚¹å‡»Buffæ‰‹åŠ¨å»ºç«‹è¿æ¥|r')
Å GetCVar("gxWindow")=='0'Ò
GameTooltip:AddLine('|cFFFF0000è¯·ç‚¹å‡»Buffæ›´æ”¹çª—å£æ¨¡å¼|r')
Ä
GameTooltip:AddLine('|cFFFF0000æœªæ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯|r')
Æ
GameTooltip:AddLine(' ')
GameTooltip:AddLine('|cffffffffåœ¨æ¸¸æˆæ—¶å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffå¯ä¿æŒæœ‰çˆ±è¿æ¥ï¼Œå¹¶ç§¯ç´¯|r')
GameTooltip:AddLine('|cffffffffæ¸¸æˆæ—¶é—´ç”¨äºç­¾åˆ°|r')
GameTooltip:AddLine('|cffffffffæˆ–å‚ä¸å…¶ä»–å®˜æ–¹æ´»åŠ¨|r')
GameTooltip:Show()
Æ)
StaticPopupDialogs["163UI-Linkage:ChangeWindowMode"]={
text="ç¡®å®šç°åœ¨å˜æ›´ä¸ºå…¨å±çŠ¶æ€çš„çª—å£æ¨¡å¼å—ï¼ˆä¸ä¼šé‡å¯WOWï¼‰ï¼Ÿ",
button1="ç«‹å³ç”Ÿæ•ˆ",
button2="ä¸‹æ¬¡å†è¯´",
OnAccept=É()
SetCVar("gxWindow","1")
SetCVar("gxMaximize","1")
ConsoleExec("gxRestart")
Æ,
timeout=0,
whileDead=Ó,
hideOnEscape=Ó,
preferredIndex=3,
}
t:SetScript("OnClick",É()
Ê Î ThreeDimensionsCode_IsFramesCreated()Ò
ThreeDimensionsCode_Tell_AllAddOnsLoaded()
Æ
Ê GetCVar("gxWindow")=="0"Ò
StaticPopup_Show("163UI-Linkage:ChangeWindowMode")
Æ
Æ)
t:SetScript("OnLeave",É(e)
GameTooltip:Hide()
Æ)
É ShownBuffNumber()
Ì o={BuffFrame:GetChildren()}
Ì a=0
n("ShownBuffNumber()-------------")
È i,o Ë ipairs(o)Ã
Ê o:IsVisible()Á o~=t Á o~=e Ò
a=a+1
Æ
Æ
a=a-DEBUFF_ACTUAL_DISPLAY
Ì e,o,o,t=GetWeaponEnchantInfo()
Ê e Ò a=a+1 Æ
Ê t Ò a=a+1 Æ
n("ShownBuffNumber()",a)
Ñ a
Æ
Ì É h(t)
Ì e=ShownBuffNumber()
Ì a=floor(e/BUFFS_PER_ROW)
Ì a=-a*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
Ì o=e%BUFFS_PER_ROW
Ì o=o*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
n("index:",e,"x",o,"y",a)
t:SetPoint("TOPRIGHT",o,a)
t:Show()
Æ
Ì É a(a)
Ê Î a Ò
a=time()
Æ
Ê GetCVar("gxWindow")=="0"Ï a-s>=45 Ò
n("display offline buff")
t:Show()
e:Hide()
h(t)
Ä
n("display online buff")
e:Show()
t:Hide()
h(e)
Æ
Æ
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors",a);
Ì h=0
CreateFrame("frame"):SetScript("OnUpdate",É()
Ì e=time()
Ê e-h>5 Ò
a(e)
h=e
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
Ì o=string.byte(e:sub(1,1))
Ì a=string.byte(e:sub(2,2))
Ì t=0
Ì s=Ç
i=bitfunc.bor(bitfunc.lshift(a,8),o)
Ê#e>2 Ò
t=string.byte(e:sub(3,3))
Ì e=bitfunc.band(t,1)
i=bitfunc.bor(bitfunc.lshift(e,16),i)
Æ
n("ping","#"..#e,o,a,t,i)
Æ
a()
s=time()
Æ
É hide163buff()
e:Hide()
t:Hide()
Æ
É cmd3dcode_lastPingTime()
Ñ s
Æ]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()