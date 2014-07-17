local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� e={
verbose=�,
info=�,
errro=�,
}
� � t(...)
� e.verbose � print("[verbose]",...)�
�
� � a(...)
� e.info � print("[verbose]",...)�
�
� � a(...)
� e.errro � print("[verbose]",...)�
�
� cmd3dcode_main_showlog(a,t)
� a==� � a="verbose"�
� t==� � t=� �
e[a]=t
�
�(LoggingChat())�
�
LoggingChat(1);
�
� e="3dcodecmd$Yin2"
� e="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� e="3dcodecmd$Yang2"
� e="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
� � e(e,o,a)
� � GetMacroBody(e)�
CreateMacro(e,"INV_MISC_QUESTIONMARK",o,�)
t("create macro",e);
�
t("macro has already exists",e)
�
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,�,a,e)
�
� a=0
� n=�
� e=GetNumAddOns()
� i=0
� e=1,GetNumAddOns()�
� a,a,a,t,a,a,a=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
i=i+1
�
�
� createChatLeftBtn(o,i,e,t,a)
� e=CreateFrame("Frame",i,t,e)
e:SetPoint("BOTTOM",t,"TOP",0,a)
e.t=e:CreateTexture()
e.t:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
e.t:SetAllPoints(e)
e.fontstring=e:CreateFontString()
e.fontstring:SetFontObject(GameFontNormalSmall)
e.fontstring:SetText(o)
e.fontstring:SetAllPoints(e)
e:Show()
� e
�
� r=�
� o=�
� h=0
� d=time()
� e=CreateFrame("frame","3DCodeCmdInit",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(128)
e:EnableKeyboard(�)
e:SetPropagateKeyboardInput(�);
e.PropagateKeyboardInput=�
e:SetScript("OnKeyDown",�(a,t,...)
� IsControlKeyDown()� IsAltKeyDown()�(t=="PAGEUP"� t=="PAGEDOWN")�
� t=="PAGEDOWN"�
ThreeDimensionsCode_Savepipe_Yin()
� t=="PAGEUP"�
ThreeDimensionsCode_Savepipe_Yang()
�
� IsControlKeyDown()� t=="PRINTSCREEN"�
Cmd3DCode_Screenshot_Start()
�
� � e.PropagateKeyboardInput �
a:SetPropagateKeyboardInput(�)
�
�
�
e.PropagateKeyboardInput=�
a:SetPropagateKeyboardInput(�)
� �
�)
� � s()
� a=createChatLeftBtn("表","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate",ChatFrameMenuButton,5)
� i=createChatLeftBtn("图","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",Cmd3DCode_Emoticon_ChatFrameButton,-2)
� dwChannelMuteButton �
a:ClearAllPoints()
a:SetPoint("LEFT",dwChannelMuteButton,"RIGHT",0,0)
i:ClearAllPoints()
i:SetPoint("LEFT",a,"RIGHT",-6,0)
�
o=�
h=time()
� � n �
threeDimensionsCodeFrames_create()
n=�
t("创建 threeDimensionsCodeFrames_create()")
�
e:SetScript("OnEvent",null)
�
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",�(h,n,e)
� n=="ADDON_LOADED"� e:sub(1,9)~="Blizzard_"�
a=a+1
�
t(n,e,e:sub(1,9),a,i)
� a>=i � � o �
s()
�
�)
e:SetScript("OnUpdate",�(a,a)
� r �
t("proccessed")
�
�
� time()-d>=3 � � o �
t("等待所有插件加载完成超时")
s()
�
� � o �
�
�
� UnitAffectingCombat("player")�
t("in combat, wait over")
�
�
� time()-h>=0 �
DeleteMacro("3dcodecmd$Yin")
DeleteMacro("3dcodecmd$Yin2")
DeleteMacro("3dcodecmd$Yang")
DeleteMacro("3dcodecmd$Yang2")
ThreeDimensionsCode_SignalLamp.desireWidth();
r=�
e:SetScript("OnUpdate",�)
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
� n
�
� ThreeDimensionsCode_Tell_AllAddOnsLoaded()
� s()
�]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()