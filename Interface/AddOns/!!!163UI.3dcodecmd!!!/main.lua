local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� t={
verbose=�,
info=�,
errro=�,
}
� � e(...)
� t.verbose � print("[verbose]",...)�
�
� � a(...)
� t.info � print("[verbose]",...)�
�
� � a(...)
� t.errro � print("[verbose]",...)�
�
� cmd3dcode_main_showlog(a,e)
� a==� � a="verbose"�
� e==� � e=� �
t[a]=e
�
� u="3dcodecmd$Yin2"
� m="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� l="3dcodecmd$Yang2"
� f="##########################\n"
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
� o=0
� r=�
� t=GetNumAddOns()
� i=0
� e=1,GetNumAddOns()�
� a,a,a,t,a,a,a=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
i=i+1
�
�
� n=�
� a=�
� s=0
� c=time()
� t=CreateFrame("frame")
� � h()
a=�
s=time()
� � r �
threeDimensionsCodeFrames_create()
r=�
e("创建 threeDimensionsCodeFrames_create()")
�
t:SetScript("OnEvent",null)
�
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",�(s,n,t)
� n=="ADDON_LOADED"� t:sub(1,9)~="Blizzard_"�
o=o+1
�
e(n,t,t:sub(1,9),o,i)
� o>=i � � a �
h()
�
�)
t:SetScript("OnUpdate",�(o,o)
� n �
e("proccessed")
�
�
� time()-c>=3 � � a �
e("等待所有插件加载完成超时")
h()
�
� � a �
�
�
� UnitAffectingCombat("player")�
e("in combat, wait over")
�
�
� time()-s>=0 �
d(u,m,"ALT-CTRL-PAGEDOWN")
d(l,f,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
n=�
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
�]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()