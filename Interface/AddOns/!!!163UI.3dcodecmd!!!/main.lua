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
Ì u="3dcodecmd$Yin2"
Ì m="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì l="3dcodecmd$Yang2"
Ì f="##########################\n"
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
Ì o=0
Ì r=Ç
Ì t=GetNumAddOns()
Ì i=0
È e=1,GetNumAddOns()Ã
Ì a,a,a,t,a,a,a=GetAddOnInfo(e)
Ê t Á Î IsAddOnLoadOnDemand(e)Ò
i=i+1
Æ
Æ
Ì n=Ç
Ì a=Ç
Ì s=0
Ì c=time()
Ì t=CreateFrame("frame")
Ì É h()
a=Ó
s=time()
Ê Î r Ò
threeDimensionsCodeFrames_create()
r=Ó
e("åˆ›å»º threeDimensionsCodeFrames_create()")
Æ
t:SetScript("OnEvent",null)
Æ
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",É(s,n,t)
Ê n=="ADDON_LOADED"Á t:sub(1,9)~="Blizzard_"Ò
o=o+1
Æ
e(n,t,t:sub(1,9),o,i)
Ê o>=i Á Î a Ò
h()
Æ
Æ)
t:SetScript("OnUpdate",É(o,o)
Ê n Ò
e("proccessed")
Ñ
Æ
Ê time()-c>=3 Á Î a Ò
e("ç­‰å¾…æ‰€æœ‰æ’ä»¶åŠ è½½å®Œæˆè¶…æ—¶")
h()
Æ
Ê Î a Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
e("in combat, wait over")
Ñ
Æ
Ê time()-s>=0 Ò
d(u,m,"ALT-CTRL-PAGEDOWN")
d(l,f,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
n=Ó
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
Æ]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()