local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� � e(...)
�
� � t(...)
print(...)
�
� � t(...)
print("[ERROR]",...)
�
� c="3dcodecmd$Yin"
� u="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� l="3dcodecmd$Yang"
� m="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
� � d(t,o,a)
� � GetMacroBody(t)�
CreateMacro(t,"INV_MISC_QUESTIONMARK",o,�)
e("create macro",t);
�
e("macro has already exists",t)
�
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,�,a,t)
�
� t=GetNumAddOns()
� a=0
� e=1,GetNumAddOns()�
� t,t,t,e,t,t,t=GetAddOnInfo(e)
� e � a=a+1 �
�
� o=0
� r=�
� i=�
� s=0
� t=CreateFrame("frame")
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",�(r,h,n)
� h=="ADDON_LOADED"� n.sub(1,9)~="Blizzard_"�
o=o+1
�
e(h,n,n.sub(1,9),o,a)
� o>=a � � i �
i=�
s=time()
threeDimensionsCodeFrames_create()
e("创建 threeDimensionsCodeFrames_create()")
t:SetScript("OnEvent",null)
�
�)
t:SetScript("OnUpdate",�(a,a)
� r �
e("proccessed")
�
�
� � i �
�
�
� UnitAffectingCombat("player")�
e("in combat, wait over")
�
�
� time()-s>=0 �
d(c,u,"ALT-CTRL-SHIFT-PAGEDOWN")
d(l,m,"ALT-CTRL-SHIFT-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
r=�
t:SetScript("OnUpdate",�)
ThreeDimensionsCode_Send("innerbrowser","file:///f:\\project\\163ui\\build-163ui-client-Desktop_Qt_5_2_1_MinGW_32bit-Release\\testjs\\webapp.html")
�
�)
� s=UnitPopup_ShowMenu
� newUnitPopup_ShowMenu(o,i,t,n,a)
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
s(o,i,t,n,a)
print("xxd",o,i,t,n,a)
�
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()