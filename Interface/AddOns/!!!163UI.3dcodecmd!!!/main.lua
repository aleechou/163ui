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
� m="3dcodecmd$Yin2"
� c="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� f="3dcodecmd$Yang2"
� u="##########################\n"
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
� a=0
� s=�
� t=GetNumAddOns()
� i=0
� e=1,GetNumAddOns()�
� a,a,a,t,a,a,a=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
i=i+1
�
�
� h=�
� o=�
� r=0
� l=time()
� t=CreateFrame("frame")
� � n()
o=�
r=time()
� � s �
threeDimensionsCodeFrames_create()
s=�
e("创建 threeDimensionsCodeFrames_create()")
�
t:SetScript("OnEvent",null)
�
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",�(h,s,t)
� s=="ADDON_LOADED"� t:sub(1,9)~="Blizzard_"�
a=a+1
�
e(s,t,t:sub(1,9),a,i)
� a>=i � � o �
n()
�
�)
t:SetScript("OnUpdate",�(a,a)
� h �
e("proccessed")
�
�
� time()-l>=3 � � o �
e("等待所有插件加载完成超时")
n()
�
� � o �
�
�
� UnitAffectingCombat("player")�
e("in combat, wait over")
�
�
� time()-r>=0 �
d(m,c,"ALT-CTRL-PAGEDOWN")
d(f,u,"ALT-CTRL-PAGEUP")
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
� ThreeDimensionsCode_IsFramesCreated()
� s
�
� ThreeDimensionsCode_Tell_AllAddOnsLoaded()
� n()
�]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()