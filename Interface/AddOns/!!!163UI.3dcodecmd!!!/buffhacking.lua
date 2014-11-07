local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì d="!!!163UI.3dcodecmd!!!"
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
Ì É t(...)
Ê e.verbose Ò print("[verbose]",...)Æ
Æ
Ì É a(...)
Ê e.info Ò print("[verbose]",...)Æ
Æ
Ì É a(...)
Ê e.errro Ò print("[verbose]",...)Æ
Æ
É cmd3dcode_buff_showlog(a,t)
Ê a==Í Ò a="verbose"Æ
Ê t==Í Ò t=Ó Æ
e[a]=t
Æ
Ì o=0
Ì a=Ç
Ì i=0
Ì l=Ç
Ì s={
screenshot={
text="æˆªå›¾å‘é€",
notCheckable=Ó,
func=É()
Cmd3DCode_Screenshot_Start()
Æ,
},
u1console={
text="æœ‰çˆ±æ§åˆ¶å°",
notCheckable=Ó,
func=É()
U1Frame:Show()
Æ,
}
}
Ì É n(t,o)
Ì e=UIDropDownMenu_CreateInfo()
È t,a Ë pairs(t)Ã
e[t]=a
Æ
UIDropDownMenu_AddButton(e,o)
Æ
Ì É h(e,t)
Ì e=CreateFrame("Button",e,UIParent,"UIDropDownMenuTemplate")
e:ClearAllPoints()
e:SetPoint("TOPLEFT",UIParent,"BOTTOMRIGHT")
e:Show()
UIDropDownMenu_Initialize(e,t,"MENU")
Ñ e
Æ
Ì É r(t)
Ì e=CreateFrame("button","buff163uiLinkage_"..t,BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
Ì a=e:CreateTexture(Í,"BACKGROUND")
a:SetTexture("Interface\\AddOns\\"..d.."\\Textures\\logo-"..t..".tga")
a:SetAllPoints(e)
Ñ e
Æ
r("online")
buff163uiLinkage_online:SetScript("OnEnter",É(i)
Ì e=""
Ì t=0
Ê o<60 Ò
e="ä¸åˆ°1åˆ†é’Ÿ"
Ä
t=floor(o/60)
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
Ê a Ò
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cff00aa00[å·²è¿æ¥]|r")
Ä
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffFFCC00[å·²è¿æ¥ï¼Œæœªç™»å½•]|r")
Æ
GameTooltip:AddLine('|cffffffffä»Šæ—¥åœ¨çº¿ï¼š|r'..e)
Ê Î a Ò
GameTooltip:AddLine('|cffffffffè¯·ç™»é™†ç½‘æ˜“é€šè¡Œè¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffä»¥ä¾¿ç§¯ç´¯çš„åœ¨çº¿æ—¶é—´å®Œæˆç­¾åˆ°ä»»åŠ¡|r')
Ä
Ê l Ò
GameTooltip:AddLine('|cffffffffå•å‡»Buffå›¾æ ‡å®Œæˆç­¾åˆ°|r')
Ä
Ê t<30 Ò
GameTooltip:AddLine('|cffffffffè¿˜æœ‰'..(30-t)..'åˆ†é’Ÿå®Œæˆç­¾åˆ°|r')
Æ
Æ
Æ
GameTooltip:AddLine('|cffffffff(å¯åœ¨æœ‰çˆ±æ§åˆ¶å°>æœ‰çˆ±è®¾ç½®é‡Œéšè—Buff)|r')
GameTooltip:Show()
Æ)
buff163uiLinkage_online:SetScript("OnLeave",É(e)
GameTooltip:Hide()
Æ)
buff163uiLinkage_online:SetScript("OnClick",É(e)
Ê e Á e.menu Ò
ToggleDropDownMenu(1,Í,e.menu,e:GetName(),0,0)
Æ
Æ)
buff163uiLinkage_online.menu=h("buff163uiLinkage_online",É(t,e)
n(s.u1console,e)
n(s.screenshot,e)
Æ)
r("offline")
buff163uiLinkage_offline:SetScript("OnEnter",É(e)
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
GameTooltip:AddLine('|cffffffffåœ¨æ¸¸æˆæ—¶å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯å¯ä¿æŒæœ‰çˆ±è¿æ¥ï¼Œ|r')
GameTooltip:AddLine('|cffffffffå¹¶ç§¯ç´¯æ¸¸æˆæ—¶é—´ç”¨äºç­¾åˆ°æˆ–å‚ä¸å…¶ä»–å®˜æ–¹æ´»åŠ¨|r')
GameTooltip:AddLine('|cffffffff(å¯åœ¨æœ‰çˆ±æ§åˆ¶å°>æœ‰çˆ±è®¾ç½®é‡Œéšè—æ­¤Buff)|r')
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
buff163uiLinkage_offline:SetScript("OnClick",É(e)
Ê e Á e.menu Ò
ToggleDropDownMenu(1,Í,e.menu,e:GetName(),0,0)
Æ
Ê Î ThreeDimensionsCode_IsFramesCreated()Ò
ThreeDimensionsCode_Tell_AllAddOnsLoaded()
Æ
Ê GetCVar("gxWindow")=="0"Ò
StaticPopup_Show("163UI-Linkage:ChangeWindowMode")
Æ
Æ)
buff163uiLinkage_offline:SetScript("OnLeave",É(e)
GameTooltip:Hide()
Æ)
buff163uiLinkage_offline.menu=h("buff163uiLinkage_offline",É(t,e)
n(s.screenshot,e)
Æ)
Ì É n()
Ì a={BuffFrame:GetChildren()}
Ì e=0
t("ShownBuffNumber()-------------")
È a,t Ë ipairs(a)Ã
Ê t:IsVisible()Á t~=buff163uiLinkage_offline Á t~=buff163uiLinkage_online Ò
e=e+1
Æ
Æ
e=e-DEBUFF_ACTUAL_DISPLAY
Ì o,i,i,a=GetWeaponEnchantInfo()
Ê o Ò e=e+1 Æ
Ê a Ò e=e+1 Æ
Ê ConsolidatedBuffs:IsVisible()Ò
e=e+1
Æ
t("ShownBuffNumber()",e)
Ñ e
Æ
Ì É s(o)
Ì e=n()
Ì a=floor(e/BUFFS_PER_ROW)
Ì a=-a*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
Ì i=e%BUFFS_PER_ROW
Ì i=i*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
t("index:",e,"x",i,"y",a)
o:SetPoint("TOPRIGHT",i,a)
o:Show()
Æ
Ì É n(e)
Ê U1DB Á U1DB.configs Ò
Ê U1DB.configs["!!!163ui!!!/displayLinkageStatusAsBuff"]=="_NIL"Ï U1DB.configs["!!!163ui!!!/displayLinkageStatusAsBuff"]==Ç Ò
buff163uiLinkage_offline:Hide()
buff163uiLinkage_online:Hide()
Ñ
Æ
Æ
Ê Î e Ò
e=time()
Æ
Ê GetCVar("gxWindow")=="0"Ï e-i>=45 Ò
t("display offline buff")
buff163uiLinkage_offline:Show()
buff163uiLinkage_online:Hide()
s(buff163uiLinkage_offline)
Ä
t("display online buff")
buff163uiLinkage_online:Show()
buff163uiLinkage_offline:Hide()
s(buff163uiLinkage_online)
Æ
Æ
hooksecurefunc("BuffFrame_UpdateAllBuffAnchors",n);
Ì s=0
CreateFrame("frame"):SetScript("OnUpdate",É()
Ì e=time()
Ê e-s>5 Ò
n(e)
s=e
Æ
Æ)
ThreeDimensionsCode_SafePipe_CmdHandles["ping"]=É(s,e)
Ê#e<1 Ò
Ê a Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²é€€å‡ºç™»å½•çŠ¶æ€|r")
Æ
a=Ç
Ä
Ê Î a Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²ç™»å½•ç½‘æ˜“é€šè¡Œè¯|r")
Æ
a=Ó
Ì n=string.byte(e:sub(1,1))
Ì i=string.byte(e:sub(2,2))
Ì a=0
Ì s=Ç
o=bitfunc.bor(bitfunc.lshift(i,8),n)
Ê#e>2 Ò
a=string.byte(e:sub(3,3))
Ì e=bitfunc.band(a,1)
o=bitfunc.bor(bitfunc.lshift(e,16),o)
Æ
t("ping","#"..#e,n,i,a,o)
Æ
n()
i=time()
Æ
É hide163buff()
buff163uiLinkage_online:Hide()
buff163uiLinkage_offline:Hide()
Æ
É cmd3dcode_lastPingTime()
Ñ i
Æ
É Toggle3DCodeCmdBuff(e)
n()
Æ
É Cmd3DCode_CheckoutClient()
Ñ time()-i<45
Æ
É Cmd3DCode_CheckoutClientAndPrompt(e)
Ê Cmd3DCode_CheckoutClient()Ò
Ñ Ó
Ä
e="|cFFCD853F"..(e Ï"æ²¡æœ‰æ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œæ— æ³•å®Œæˆæ“ä½œï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ç»§ç»­ã€‚").."|r"
È t=1,10 Ã
Ê _G["ChatFrame"..t]:IsVisible()Ò
_G["ChatFrame"..t]:AddMessage(e)
Æ
Æ
Ñ Ç
Æ
Æ]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()