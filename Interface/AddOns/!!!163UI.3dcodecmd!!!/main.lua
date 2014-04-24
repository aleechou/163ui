local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[Ì É t(...)
print("[verbose]",...)
Æ
Ì É e(...)
print(...)
Æ
Ì É e(...)
print("[ERROR]",...)
Æ
Ì r="3dcodecmd$Yin"
Ì h="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
Ì s="3dcodecmd$Yang"
Ì d="##########################\n"
.."# è¿™æ˜¯ç”±ç½‘æ˜“æœ‰çˆ±è‡ªåŠ¨åˆ›å»ºçš„å® #\n"
.."#                è¯·å‹¿åˆ é™¤ :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
Ì É i(e,a,o)
t("start createMacro",e);
Ê Î GetMacroBody(e)Ò
CreateMacro(e,"INV_MISC_QUESTIONMARK",a,Í)
print("create macro",e);
Ä
print("macro has already exists",e)
Æ
SetOverrideBindingMacro(threeDimensionsCodePad,Ó,o,e)
Æ
Ì o=Ç
Ì n=Ç
Ì a=0
Ì e=CreateFrame("frame")
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",É(o,t,e)
Ê t=="ADDON_LOADED"Á e=="!!!163UI.3dcodecmd!!!"Ò
n=Ó
a=time()
Æ
Æ)
e:SetScript("OnUpdate",É(l,l)
Ê o Ò
t("proccessed")
Ñ
Æ
Ê Î n Ò
Ñ
Æ
Ê UnitAffectingCombat("player")Ò
t("in combat, wait over")
Ñ
Æ
Ê time()-a>=0 Ò
i(r,h,"ALT-CTRL-SHIFT-PAGEDOWN")
i(s,d,"ALT-CTRL-SHIFT-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
o=Ó
e:SetScript("OnUpdate",Í)
Æ
Æ)
Ì s=UnitPopup_ShowMenu
É newUnitPopup_ShowMenu(a,i,t,n,o)
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
s(a,i,t,n,o)
print("xxd",a,i,t,n,o)
Æ
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()