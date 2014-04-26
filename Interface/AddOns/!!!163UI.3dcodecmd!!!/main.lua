local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì É e(...)
Æ
Ì É t(...)
print(...)
Æ
Ì É t(...)
print("[ERROR]",...)
Æ
Ì d="3dcodecmd$Yin2"
Ì u="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì l="3dcodecmd$Yang2"
Ì c="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
Ì É h(t,o,a)
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
Ì s=Ç
Ì n=Ç
Ì r=0
Ì t=CreateFrame("frame")
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",É(h,s,i)
Ê s=="ADDON_LOADED"Á i.sub(1,9)~="Blizzard_"Ò
o=o+1
Æ
e(s,i,i.sub(1,9),o,a)
Ê o>=a Á Î n Ò
n=Ó
r=time()
threeDimensionsCodeFrames_create()
e("åˆ›å»º threeDimensionsCodeFrames_create()")
t:SetScript("OnEvent",null)
Æ
Æ)
t:SetScript("OnUpdate",É(a,a)
Ê s Ò
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
Ê time()-r>=0 Ò
h(d,u,"ALT-CTRL-PAGEDOWN")
h(l,c,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
s=Ó
t:SetScript("OnUpdate",Í)
ThreeDimensionsCode_Send("innerbrowser","file:///f:\\project\\163ui\\build-163ui-client-Desktop_Qt_5_2_1_MinGW_32bit-Release\\testjs\\webapp.html")
Æ
Æ)
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()