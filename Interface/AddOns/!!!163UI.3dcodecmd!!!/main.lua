local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� � t(...)
print("[verbose]",...)
�
� � e(...)
print(...)
�
� � e(...)
print("[ERROR]",...)
�
� r="3dcodecmd$Yin"
� h="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� s="3dcodecmd$Yang"
� d="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
� � i(e,a,o)
t("start createMacro",e);
� � GetMacroBody(e)�
CreateMacro(e,"INV_MISC_QUESTIONMARK",a,�)
print("create macro",e);
�
print("macro has already exists",e)
�
SetOverrideBindingMacro(threeDimensionsCodePad,�,o,e)
�
� o=�
� n=�
� a=0
� e=CreateFrame("frame")
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",�(o,t,e)
� t=="ADDON_LOADED"� e=="!!!163UI.3dcodecmd!!!"�
n=�
a=time()
�
�)
e:SetScript("OnUpdate",�(l,l)
� o �
t("proccessed")
�
�
� � n �
�
�
� UnitAffectingCombat("player")�
t("in combat, wait over")
�
�
� time()-a>=0 �
i(r,h,"ALT-CTRL-SHIFT-PAGEDOWN")
i(s,d,"ALT-CTRL-SHIFT-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
o=�
e:SetScript("OnUpdate",�)
�
�)
� s=UnitPopup_ShowMenu
� newUnitPopup_ShowMenu(a,i,t,n,o)
�(UIDROPDOWNMENU_MENU_LEVEL<=1)�
� e=UIDropDownMenu_CreateInfo()
e.text="ho ho !!!"
e.tooltipTitle="title"
e.tooltipText="xxxxddddd"
e.name=t
e.func=onclick
e.arg1={["name"]=GetUnitName(t,�)}
UIDropDownMenu_AddButton(e)
�
s(a,i,t,n,o)
print("xxd",a,i,t,n,o)
�
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()