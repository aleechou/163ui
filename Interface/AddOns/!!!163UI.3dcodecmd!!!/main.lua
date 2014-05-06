local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì É e(...)
Æ
Ì É t(...)
print(...)
Æ
Ì É t(...)
print("[ERROR]",...)
Æ
Ì u="3dcodecmd$Yin2"
Ì l="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì d="3dcodecmd$Yang2"
Ì c="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
Ì É r(t,o,a)
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
Ì h=Ç
Ì i=Ç
Ì s=0
Ì t=CreateFrame("frame")
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",É(r,h,n)
Ê h=="ADDON_LOADED"Á n.sub(1,9)~="Blizzard_"Ò
o=o+1
Æ
e(h,n,n.sub(1,9),o,a)
Ê o>=a Á Î i Ò
i=Ó
s=time()
threeDimensionsCodeFrames_create()
e("åˆ›å»º threeDimensionsCodeFrames_create()")
t:SetScript("OnEvent",null)
Æ
Æ)
t:SetScript("OnUpdate",É(a,a)
Ê h Ò
e("proccessed")
Ñ
Æ
Ê Î i Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
e("in combat, wait over")
Ñ
Æ
Ê time()-s>=0 Ò
r(u,l,"ALT-CTRL-PAGEDOWN")
r(d,c,"ALT-CTRL-PAGEUP")
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
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()