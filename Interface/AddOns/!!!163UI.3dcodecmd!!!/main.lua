local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� � e(...)
�
� � t(...)
print(...)
�
� � t(...)
print("[ERROR]",...)
�
� u="3dcodecmd$Yin2"
� l="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� d="3dcodecmd$Yang2"
� c="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
� � r(t,o,a)
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
� h=�
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
� h �
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
r(u,l,"ALT-CTRL-PAGEDOWN")
r(d,c,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
h=�
t:SetScript("OnUpdate",�)
�
�)
� cmd3dcode_test()
bigdatasendtest()
�
� bigdatasendtest()
� e=GetTime()
� t=string.rep("1",GetScreenWidth()*3+12)
print('make string:',GetTime()-e,#t)
e=GetTime()
ThreeDimensionsCode_Send("hi",t);
print('make frames',GetTime()-e)
�
]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()