local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� � e(...)
�
� � t(...)
print(...)
�
� � t(...)
print("[ERROR]",...)
�
� d="3dcodecmd$Yin2"
� u="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� l="3dcodecmd$Yang2"
� c="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
� � h(t,o,a)
� � GetMacroBody(t)�
CreateMacro(t,"INV_MISC_QUESTIONMARK",o,�)
e("create macro",t);
�
e("macro has already exists",t)
�
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,�,a,t)
�
� o=0
� t=GetNumAddOns()
� a=0
� e=1,GetNumAddOns()�
� o,o,o,t,o,o,o=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
a=a+1
�
�
� s=�
� n=�
� r=0
� t=CreateFrame("frame")
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",�(h,s,i)
� s=="ADDON_LOADED"� i.sub(1,9)~="Blizzard_"�
o=o+1
�
e(s,i,i.sub(1,9),o,a)
� o>=a � � n �
n=�
r=time()
threeDimensionsCodeFrames_create()
e("创建 threeDimensionsCodeFrames_create()")
t:SetScript("OnEvent",null)
�
�)
t:SetScript("OnUpdate",�(a,a)
� s �
e("proccessed")
�
�
� � n �
�
�
� UnitAffectingCombat("player")�
e("in combat, wait over")
�
�
� time()-r>=0 �
h(d,u,"ALT-CTRL-PAGEDOWN")
h(l,c,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
s=�
t:SetScript("OnUpdate",�)
ThreeDimensionsCode_Send("innerbrowser","file:///f:\\project\\163ui\\build-163ui-client-Desktop_Qt_5_2_1_MinGW_32bit-Release\\testjs\\webapp.html")
�
�)
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()