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
� cmd3dcode_main_showlog(e,a)
� e==� � e="verbose"�
� a==� � a=� �
t[e]=a
�
� c="3dcodecmd$Yin2"
� u="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� l="3dcodecmd$Yang2"
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
� o=0
� t=GetNumAddOns()
� a=0
� e=1,GetNumAddOns()�
� o,o,o,t,o,o,o=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
a=a+1
�
�
� r=�
� n=�
� s=0
� t=CreateFrame("frame")
t:RegisterEvent("ADDON_LOADED")
t:SetScript("OnEvent",�(r,h,i)
� h=="ADDON_LOADED"� i.sub(1,9)~="Blizzard_"�
o=o+1
�
e(h,i,i.sub(1,9),o,a)
� o>=a � � n �
n=�
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
� � n �
�
�
� UnitAffectingCombat("player")�
e("in combat, wait over")
�
�
� time()-s>=0 �
d(c,u,"ALT-CTRL-PAGEDOWN")
d(l,m,"ALT-CTRL-PAGEUP")
ThreeDimensionsCode_SignalLamp.desireWidth();
r=�
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