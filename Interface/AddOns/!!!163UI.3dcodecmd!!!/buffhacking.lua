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
Ì É o(...)
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
Ì t=Ç
Ì i=0
Ì l=Ç
Ì n={
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
Ì É s(t,o)
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
Ì É r(a)
Ì e=CreateFrame("button","buff163uiLinkage_"..a,BuffFrame)
e:SetWidth(BUFF_BUTTON_HEIGHT)
e:SetHeight(BUFF_BUTTON_HEIGHT)
Ì t=e:CreateTexture(Í,"BACKGROUND")
t:SetTexture("Interface\\AddOns\\"..d.."\\Textures\\logo-"..a..".tga")
t:SetAllPoints(e)
Ñ e
Æ
r("online")
buff163uiLinkage_online:SetScript("OnEnter",É(i)
Ì e=""
Ì o=0
Ê a<60 Ò
e="ä¸åˆ°1åˆ†é’Ÿ"
Ä
o=floor(a/60)
Ì t=floor(o/60)
Ê t>0 Ò
e=t.."å°æ—¶"
Æ
mindisplay=o%60
Ê mindisplay>0 Ò
e=e..mindisplay.."åˆ†é’Ÿ"
Æ
Æ
GameTooltip:SetOwner(i,'ANCHOR_BOTTOMLEFT')
Ê t Ò
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cff00aa00[å·²è¿æ¥]|r")
Ä
GameTooltip:AddLine("æœ‰çˆ±è¿æ¥ |cffFFCC00[å·²è¿æ¥ï¼Œæœªç™»å½•]|r")
Æ
GameTooltip:AddLine('|cffffffffä»Šæ—¥åœ¨çº¿ï¼š|r'..e)
Ê Î t Ò
GameTooltip:AddLine('|cffffffffè¯·ç™»é™†ç½‘æ˜“é€šè¡Œè¯ï¼Œ|r')
GameTooltip:AddLine('|cffffffffä»¥ä¾¿ç§¯ç´¯çš„åœ¨çº¿æ—¶é—´å®Œæˆç­¾åˆ°ä»»åŠ¡|r')
Ä
Ê l Ò
GameTooltip:AddLine('|cffffffffå•å‡»Buffå›¾æ ‡å®Œæˆç­¾åˆ°|r')
Ä
Ê o<30 Ò
GameTooltip:AddLine('|cffffffffè¿˜æœ‰'..(30-o)..'åˆ†é’Ÿå®Œæˆç­¾åˆ°|r')
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
s(n.u1console,e)
s(n.screenshot,e)
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
s(n.screenshot,e)
Æ)
Ì É n()
Ì t={BuffFrame:GetChildren()}
Ì e=0
o("ShownBuffNumber()-------------")
È a,t Ë ipairs(t)Ã
Ê t:IsVisible()Á t~=buff163uiLinkage_offline Á t~=buff163uiLinkage_online Ò
e=e+1
Æ
Æ
e=e-DEBUFF_ACTUAL_DISPLAY
Ì t,i,i,a=GetWeaponEnchantInfo()
Ê t Ò e=e+1 Æ
Ê a Ò e=e+1 Æ
Ê ConsolidatedBuffs:IsVisible()Ò
e=e+1
Æ
o("ShownBuffNumber()",e)
Ñ e
Æ
Ì É s(t)
Ì e=n()
Ì a=floor(e/BUFFS_PER_ROW)
Ì a=-a*(BUFF_ROW_SPACING+BUFF_BUTTON_HEIGHT)
Ì i=e%BUFFS_PER_ROW
Ì i=i*(BUFF_HORIZ_SPACING-BUFF_BUTTON_HEIGHT)
o("index:",e,"x",i,"y",a)
t:SetPoint("TOPRIGHT",i,a)
t:Show()
Æ
Ì É n(e)
Ê U1DB Á U1DB.configs Á U1DB.configs["!!!163ui!!!/displayLinkageStatusAsBuff"]=="_NIL"Ò
buff163uiLinkage_offline:Hide()
buff163uiLinkage_online:Hide()
Ñ
Æ
Ê Î e Ò
e=time()
Æ
Ê GetCVar("gxWindow")=="0"Ï e-i>=45 Ò
o("display offline buff")
buff163uiLinkage_offline:Show()
buff163uiLinkage_online:Hide()
s(buff163uiLinkage_offline)
Ä
o("display online buff")
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
Ê t Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²é€€å‡ºç™»å½•çŠ¶æ€|r")
Æ
t=Ç
Ä
Ê Î t Ò
print("|cff00aa00æœ‰çˆ±å®¢æˆ·ç«¯å·²ç™»å½•ç½‘æ˜“é€šè¡Œè¯|r")
Æ
t=Ó
Ì i=string.byte(e:sub(1,1))
Ì n=string.byte(e:sub(2,2))
Ì t=0
Ì s=Ç
a=bitfunc.bor(bitfunc.lshift(n,8),i)
Ê#e>2 Ò
t=string.byte(e:sub(3,3))
Ì e=bitfunc.band(t,1)
a=bitfunc.bor(bitfunc.lshift(e,16),a)
Æ
o("ping","#"..#e,i,n,t,a)
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
É Cmd3DCode_CheckoutClientAndPrompt()
Ê time()-i>45 Ò
print("|cFFCD853F æ²¡æœ‰æ£€æµ‹åˆ°æœ‰çˆ±å®¢æˆ·ç«¯ï¼Œæ— æ³•å®Œæˆæ“ä½œï¼Œè¯·å¯åŠ¨æœ‰çˆ±å®¢æˆ·ç«¯ç»§ç»­ã€‚ |r")
Ñ Ç
Ä
Ñ Ó
Æ
Æ]===], '@../!!!163UI.3dcodecmd!!!/buffhacking.lua'))()