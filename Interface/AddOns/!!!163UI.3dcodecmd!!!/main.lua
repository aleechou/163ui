local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì É e(...)
Æ
Ì É t(...)
print(...)
Æ
Ì É t(...)
print("[ERROR]",...)
Æ
Ì c="3dcodecmd$Yin"
Ì u="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì l="3dcodecmd$Yang"
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
Ì t=GetNumAddOns()
Ì a=0
È e=1,GetNumAddOns()Ã
Ì t,t,t,e,t,t,t=GetAddOnInfo(e)
Ê e Ò a=a+1 Æ
Æ
Ì o=0
Ì r=Ç
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
Ê r Ò
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
d(c,u,"ALT-CTRL-SHIFT-PAGEDOWN")
d(l,m,"ALT-CTRL-SHIFT-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
r=Ó
t:SetScript("OnUpdate",Í)
ThreeDimensionsCode_Send("innerbrowser","file:///f:\\project\\163ui\\build-163ui-client-Desktop_Qt_5_2_1_MinGW_32bit-Release\\testjs\\webapp.html")
Æ
Æ)
Ì s=UnitPopup_ShowMenu
É newUnitPopup_ShowMenu(o,i,t,n,a)
Ê(UIDROPDOWNMENU_MENU_LEVEL<=1)Ò
Ì e=UIDropDownMenu_CreateInfo()
e.text="ho ho !!!"
e.tooltipTitle="title"
e.tooltipText="xxxxddddd"
e.name=t
e.func=onclick
e.arg1={["name"]=GetUnitName(t,Ó)}
UIDropDownMenu_AddButton(e)
Æ
s(o,i,t,n,a)
print("xxd",o,i,t,n,a)
Æ
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()