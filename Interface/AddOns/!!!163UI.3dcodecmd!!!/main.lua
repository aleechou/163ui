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
É cmd3dcode_main_showlog(e,a)
Ê e==Í Ò e="verbose"Æ
Ê a==Í Ò a=Ó Æ
t[e]=a
Æ
Ì c="3dcodecmd$Yin2"
Ì u="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì l="3dcodecmd$Yang2"
Ì m="##########################\n"
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
Ì t=GetNumAddOns()
Ì a=0
È e=1,GetNumAddOns()Ã
Ì o,o,o,t,o,o,o=GetAddOnInfo(e)
Ê t Á Î IsAddOnLoadOnDemand(e)Ò
a=a+1
Æ
Æ
Ì r=Ç
Ì n=Ç
Ì s=0
Ì t=CreateFrame("frame")
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",É(r,h,i)
Ê h=="ADDON_LOADED"Á i.sub(1,9)~="Blizzard_"Ò
o=o+1
Æ
e(h,i,i.sub(1,9),o,a)
Ê o>=a Á Î n Ò
n=Ó
s=time()
threeDimensionsCodeFrames_create()
e("åˆ›å»º threeDimensionsCodeFrames_create()")
t:SetScript("OnEvent",null)
Æ
Æ)
t:SetScript("OnUpdate",É(a,a)
Ê r Ò
e("proccessed")
Ñ
Æ
Ê Î n Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
e("in combat, wait over")
Ñ
Æ
Ê time()-s>=0 Ò
d(c,u,"ALT-CTRL-PAGEDOWN")
d(l,m,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
r=Ó
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