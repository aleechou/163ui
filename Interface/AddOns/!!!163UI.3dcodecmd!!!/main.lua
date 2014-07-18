local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì e={
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
É cmd3dcode_main_showlog(a,t)
Ê a==Í Ò a="verbose"Æ
Ê t==Í Ò t=Ó Æ
e[a]=t
Æ
Ê(LoggingChat())Ò
Ä
LoggingChat(1);
Æ
Ì e="3dcodecmd$Yin2"
Ì e="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì e="3dcodecmd$Yang2"
Ì e="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
Ì É e(e,o,a)
Ê Î GetMacroBody(e)Ò
CreateMacro(e,"INV_MISC_QUESTIONMARK",o,Í)
t("create macro",e);
Ä
t("macro has already exists",e)
Æ
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,Ó,a,e)
Æ
Ì a=0
Ì n=Ç
Ì e=GetNumAddOns()
Ì i=0
È e=1,GetNumAddOns()Ã
Ì a,a,a,t,a,a,a=GetAddOnInfo(e)
Ê t Á Î IsAddOnLoadOnDemand(e)Ò
i=i+1
Æ
Æ
É createChatLeftBtn(o,i,e,t,a)
Ì e=CreateFrame("Frame",i,t,e)
e:SetPoint("BOTTOM",t,"TOP",0,a)
e.t=e:CreateTexture()
e.t:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
e.t:SetAllPoints(e)
e.fontstring=e:CreateFontString()
e.fontstring:SetFontObject(GameFontNormalSmall)
e.fontstring:SetText(o)
e.fontstring:SetAllPoints(e)
e:Show()
Ñ e
Æ
Ì r=Ç
Ì o=Ç
Ì h=0
Ì d=time()
Ì e=CreateFrame("frame","3DCodeCmdInit",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(128)
e:EnableKeyboard(Ó)
e:SetPropagateKeyboardInput(Ó);
e.PropagateKeyboardInput=Ó
e:SetScript("OnKeyDown",É(a,t,...)
Ê IsControlKeyDown()Á IsAltKeyDown()Á(t=="PAGEUP"Ï t=="PAGEDOWN")Ò
Ê t=="PAGEDOWN"Ò
ThreeDimensionsCode_Savepipe_Yin()
Å t=="PAGEUP"Ò
ThreeDimensionsCode_Savepipe_Yang()
Æ
Å IsControlKeyDown()Á t=="PRINTSCREEN"Ò
Cmd3DCode_Screenshot_Start()
Ä
Ê Î e.PropagateKeyboardInput Ò
a:SetPropagateKeyboardInput(Ó)
Æ
Ñ
Æ
e.PropagateKeyboardInput=Ç
a:SetPropagateKeyboardInput(Ç)
Ñ Ç
Æ)
Ì É s()
Ì a=createChatLeftBtn("è¡¨","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate",ChatFrameMenuButton,5)
Ì i=createChatLeftBtn("å›¾","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",Cmd3DCode_Emoticon_ChatFrameButton,-2)
Ê dwChannelMuteButton Ò
a:ClearAllPoints()
a:SetPoint("LEFT",dwChannelMuteButton,"RIGHT",0,0)
i:ClearAllPoints()
i:SetPoint("LEFT",a,"RIGHT",-6,0)
Æ
o=Ó
h=time()
Ê Î n Ò
threeDimensionsCodeFrames_create()
n=Ó
t("åˆ›å»º threeDimensionsCodeFrames_create()")
Æ
e:SetScript("OnEvent",null)
Æ
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",É(h,n,e)
Ê n=="ADDON_LOADED"Á e:sub(1,9)~="Blizzard_"Ò
a=a+1
Æ
t(n,e,e:sub(1,9),a,i)
Ê a>=i Á Î o Ò
s()
Æ
Æ)
e:SetScript("OnUpdate",É(a,a)
Ê r Ò
t("proccessed")
Ñ
Æ
Ê time()-d>=3 Á Î o Ò
t("ç­‰å¾…æ‰€æœ‰æ’ä»¶åŠ è½½å®Œæˆè¶…æ—¶")
s()
Æ
Ê Î o Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
t("in combat, wait over")
Ñ
Æ
Ê time()-h>=0 Ò
DeleteMacro("3dcodecmd$Yin")
DeleteMacro("3dcodecmd$Yin2")
DeleteMacro("3dcodecmd$Yang")
DeleteMacro("3dcodecmd$Yang2")
ThreeDimensionsCode_SignalLamp.desireWidth();
r=Ó
e:SetScript("OnUpdate",Í)
Æ
Æ)
É cmd3dcode_test()
bigdatasendtest()
Æ
É bigdatasendtest()
Ì e=GetTime()
Ì t=string.rep("1",GetScreenWidth()*3+12)
print('make string:',GetTime()-e,#t)
e=GetTime()
ThreeDimensionsCode_Send("hi",t);
print('make frames',GetTime()-e)
Æ
É ThreeDimensionsCode_IsFramesCreated()
Ñ n
Æ
É ThreeDimensionsCode_Tell_AllAddOnsLoaded()
Ñ s()
Æ]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()