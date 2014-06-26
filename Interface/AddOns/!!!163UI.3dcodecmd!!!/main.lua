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
É cmd3dcode_main_showlog(t,a)
Ê t==Í Ò t="verbose"Æ
Ê a==Í Ò a=Ó Æ
e[t]=a
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
Ì o=0
È e=1,GetNumAddOns()Ã
Ì a,a,a,t,a,a,a=GetAddOnInfo(e)
Ê t Á Î IsAddOnLoadOnDemand(e)Ò
o=o+1
Æ
Æ
Ì h=Ç
Ì i=Ç
Ì r=0
Ì d=time()
Ì e=CreateFrame("frame","3DCodeCmdInit",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(128)
e:EnableKeyboard(Ó);
e:SetPropagateKeyboardInput(Ó);
e:SetScript("OnKeyDown",É(t,e,...)
Ê IsControlKeyDown()Á IsAltKeyDown()Á(e=="PAGEUP"Ï e=="PAGEDOWN")Ò
Ê e=="PAGEDOWN"Ò
ThreeDimensionsCode_Savepipe_Yin()
Å e=="PAGEUP"Ò
ThreeDimensionsCode_Savepipe_Yang()
Æ
Å IsControlKeyDown()Á e=="PRINTSCREEN"Ò
Cmd3DCode_Screenshot_Start()
Ä
t:SetPropagateKeyboardInput(Ó)
Ñ
Æ
t:SetPropagateKeyboardInput(Ç)
Ñ Ç
Æ)
Ì É s()
i=Ó
r=time()
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
t(n,e,e:sub(1,9),a,o)
Ê a>=o Á Î i Ò
s()
Æ
Æ)
e:SetScript("OnUpdate",É(a,a)
Ê h Ò
t("proccessed")
Ñ
Æ
Ê time()-d>=3 Á Î i Ò
t("ç­‰å¾…æ‰€æœ‰æ’ä»¶åŠ è½½å®Œæˆè¶…æ—¶")
s()
Æ
Ê Î i Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
t("in combat, wait over")
Ñ
Æ
Ê time()-r>=0 Ò
DeleteMacro("3dcodecmd$Yin")
DeleteMacro("3dcodecmd$Yin2")
DeleteMacro("3dcodecmd$Yang")
DeleteMacro("3dcodecmd$Yang2")
ThreeDimensionsCode_SignalLamp.desireWidth();
h=Ó
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