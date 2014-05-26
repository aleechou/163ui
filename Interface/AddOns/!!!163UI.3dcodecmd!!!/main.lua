local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì t={
verbose=Ç,
info=Ç,
errro=Ó,
}
Ì É e(...)
Ê t.verbose Ò print("[verbose]",...)Æ
Æ
Ì É a(...)
Ê t.info Ò print("[verbose]",...)Æ
Æ
Ì É a(...)
Ê t.errro Ò print("[verbose]",...)Æ
Æ
É cmd3dcode_main_showlog(a,e)
Ê a==Í Ò a="verbose"Æ
Ê e==Í Ò e=Ó Æ
t[a]=e
Æ
Ì m="3dcodecmd$Yin2"
Ì c="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì f="3dcodecmd$Yang2"
Ì u="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
Ì É d(t,o,a)
Ê Î GetMacroBody(t)Ò
CreateMacro(t,"INV_MISC_QUESTIONMARK",o,Í)
e("create macro",t);
Ä
e("macro has already exists",t)
Æ
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,Ó,a,t)
Æ
Ì a=0
Ì s=Ç
Ì t=GetNumAddOns()
Ì i=0
È e=1,GetNumAddOns()Ã
Ì a,a,a,t,a,a,a=GetAddOnInfo(e)
Ê t Á Î IsAddOnLoadOnDemand(e)Ò
i=i+1
Æ
Æ
Ì h=Ç
Ì o=Ç
Ì r=0
Ì l=time()
Ì t=CreateFrame("frame")
Ì É n()
o=Ó
r=time()
Ê Î s Ò
threeDimensionsCodeFrames_create()
s=Ó
e("åˆ›å»º threeDimensionsCodeFrames_create()")
Æ
t:SetScript("OnEvent",null)
Æ
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",É(h,s,t)
Ê s=="ADDON_LOADED"Á t:sub(1,9)~="Blizzard_"Ò
a=a+1
Æ
e(s,t,t:sub(1,9),a,i)
Ê a>=i Á Î o Ò
n()
Æ
Æ)
t:SetScript("OnUpdate",É(a,a)
Ê h Ò
e("proccessed")
Ñ
Æ
Ê time()-l>=3 Á Î o Ò
e("ç­‰å¾…æ‰€æœ‰æ’ä»¶åŠ è½½å®Œæˆè¶…æ—¶")
n()
Æ
Ê Î o Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
e("in combat, wait over")
Ñ
Æ
Ê time()-r>=0 Ò
d(m,c,"ALT-CTRL-PAGEDOWN")
d(f,u,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
h=Ó
t:SetScript("OnUpdate",Í)
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
Ñ s
Æ
É ThreeDimensionsCode_Tell_AllAddOnsLoaded()
Ñ n()
Æ]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()